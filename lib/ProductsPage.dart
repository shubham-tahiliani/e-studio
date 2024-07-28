import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Data.dart';
import 'LoginPage.dart';
import 'ProductScreen.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    fetchJsonData();
    final remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfig.onConfigUpdated.listen((RemoteConfigUpdate event)async{
      await remoteConfig.activate();
      setState(() {
        discount=remoteConfig.getBool('discount');
      });

    });
  }

  Future<void> fetchJsonData() async {
    final url = 'https://dummyjson.com/products';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _products = data['products'];
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<dynamic> _products = [];
  bool discount = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'e-Shop',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0C54BE),
          ),
        ),
        actions: [
          PopupMenuButton(
              tooltip: '',
              position: PopupMenuPosition.over,
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    onTap: () {
                      showLogoutDialog(context);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.logout),
                      title: Text.rich(TextSpan(
                        text: "Logout",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                      )),
                    ),
                  ),
                ];
              })
        ],
      ),
      backgroundColor: backgroundColor,
      body: _products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 0.5,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Product(product: product)),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Image.network(
                              product['thumbnail'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  product['title'],
                                  style: GoogleFonts.getFont('Poppins',fontSize: 16,fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  product['description'],
                                  style: GoogleFonts.getFont('Poppins',fontSize: 14,),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Spacer(),
                                Wrap(
                                  children: discount
                                      ? [
                                    Text(
                                      '\$${product['price']}',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontSize: 10,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '\$${(product['price'] * (1 - product['discountPercentage'] / 100)).toStringAsFixed(2)}',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontSize: 10,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '${product['discountPercentage']}% off',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontSize: 10,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ]
                                      : [
                                    Text(
                                      '\$${product['price']}',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

}
