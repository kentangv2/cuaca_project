import 'package:flutter/material.dart';
import 'contact.dart';

class EditContactPage extends StatefulWidget {
  final Contact contact;

  EditContactPage({required this.contact});

  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.contact.name;
    phoneNumberController.text = widget.contact.phoneNumber;
    emailController.text = widget.contact.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
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

                Contact editedContact = Contact(
                  id: widget.contact.id,
                  name: name,
                  phoneNumber: phoneNumber,
                  email: email,
                );

                Navigator.pop(context, editedContact);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
