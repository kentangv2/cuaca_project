import 'package:NewsLine/ui/about_us/about_content.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us")),
      body: SingleChildScrollView( // Tambahkan SingleChildScrollView di sini
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$judul',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text('$deskripsi',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 16.0),
              Text(
                '$fitur',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '$deskripsi_fitur',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 16.0),
              Text(
                '$deskripsi_1',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 16.0),
              Text(
                '$deskripsi_2',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 16.0),
              Text(
                'Kontak',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(Icons.email),
                  SizedBox(width: 8.0),
                  Text('$email'),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 8.0),
                  Text('$hp'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
