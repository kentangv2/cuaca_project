import 'package:flutter/material.dart';
import 'contact.dart';

class AddContactPage extends StatefulWidget {
  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Kontak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
              ),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Nomor Hp',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String phoneNumber = phoneNumberController.text;
                String email = emailController.text;

                Contact newContact = Contact(
                  id: 0,
                  name: name,
                  phoneNumber: phoneNumber,
                  email: email,
                );

                Navigator.pop(context, newContact);
              },
              child: Text('Tambah Kontak'),
            ),
          ],
        ),
      ),
    );
  }
}

