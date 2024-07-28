import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Product extends StatelessWidget {
  final dynamic product;

  const Product({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(product['title']),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product['thumbnail'],
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product['title'],
              style: GoogleFonts.getFont(
                'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              product['description'],
              style: GoogleFonts.getFont('Poppins', fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  '\$${product['price']}',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    fontSize: 16,
                    decoration: product['discountPercentage'] > 0
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                SizedBox(width: 8),
                if (product['discountPercentage'] > 0) ...[
                  Text(
                    '\$${(product['price'] * (1 - product['discountPercentage'] / 100)).toStringAsFixed(2)}',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '${product['discountPercentage']}% off',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Category: ${product['category']}',
              style: GoogleFonts.getFont('Poppins', fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Brand: ${product['brand']}',
              style: GoogleFonts.getFont('Poppins', fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Stock: ${product['stock']}',
              style: GoogleFonts.getFont('Poppins', fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Rating: ${product['rating']}',
              style: GoogleFonts.getFont('Poppins', fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              'Reviews:',
              style: GoogleFonts.getFont('Poppins', fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...product['reviews'].map<Widget>((review) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${review['reviewerName']} (${review['rating']} stars)',
                      style: GoogleFonts.getFont('Poppins', fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      review['comment'],
                      style: GoogleFonts.getFont('Poppins', fontSize: 14),
                    ),
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: 16),
            Text(
              'Warranty Information: ${product['warrantyInformation']}',
              style: GoogleFonts.getFont('Poppins', fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Shipping Information: ${product['shippingInformation']}',
              style: GoogleFonts.getFont('Poppins', fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Return Policy: ${product['returnPolicy']}',
              style: GoogleFonts.getFont('Poppins', fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              'SKU: ${product['sku']}',
              style: GoogleFonts.getFont('Poppins', fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Minimum Order Quantity: ${product['minimumOrderQuantity']}',
              style: GoogleFonts.getFont('Poppins', fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Availability Status: ${product['availabilityStatus']}',
              style: GoogleFonts.getFont('Poppins', fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Weight: ${product['weight']} grams',
              style: GoogleFonts.getFont('Poppins', fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Dimensions: ${product['dimensions']['width']} x ${product['dimensions']['height']} x ${product['dimensions']['depth']} cm',
              style: GoogleFonts.getFont('Poppins', fontSize: 14),
            ),
            SizedBox(height: 16),
            Center(
              child: Image.network(
                product['meta']['qrCode'],
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
