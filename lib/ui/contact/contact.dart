import 'package:NewsLine/db_helper/db_helper.dart';
import 'package:NewsLine/ui/contact/detail_contact.dart';
import 'package:NewsLine/ui/contact/tambah_contact.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'edit_contact.dart';


class Contact {
  int id;
  String name;
  String phoneNumber;
  String email;

  Contact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
  });
}
 Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.getContacts().then((contactList) {
      setState(() {
        contacts = contactList;
      });
    });
  }
  
    void editContact(BuildContext context, Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditContactPage(contact: contact),
      ),
    ).then((editedContact) {
      if (editedContact != null) {
        DatabaseHelper.updateContact(editedContact).then((success) {
          if (success) {
            setState(() {
              int index = contacts.indexWhere((c) => c.id == editedContact.id);
              if (index != -1) {
                contacts[index] = editedContact;
              }
            });
          }
        });
      }
    });
  }

  void deleteContact(BuildContext context, Contact contact) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hapus Kontak'),
          content: Text('Yakin ingin menghapus kontak ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                DatabaseHelper.deleteContact(contact).then((success) {
                  if (success) {
                    setState(() {
                      contacts.removeWhere((c) => c.id == contact.id);
                    });
                  }
                });
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kontak'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContactPage(),
            ),
          ).then((newContact) {
            if (newContact != null) {
              DatabaseHelper.addContact(newContact).then((id) {
                setState(() {
                  newContact.id = id;
                  contacts.add(newContact);
                });
              });
            }
          });
        },
        child: Icon(Icons.person_add),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          Color randomColor = getRandomColor();
          return ListTile(
            leading: Icon(Icons.person),iconColor: randomColor,
            title: Text(contacts[index].name,style: TextStyle(fontWeight: FontWeight.bold) ,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetailPage(contact: contacts[index]),
                ),
              ).then((editedContact) {
                if (editedContact != null) {
                  setState(() {
                    contacts[index] = editedContact;
                  });
                }
              });
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),color: Colors.blue[300],
                  onPressed: () => editContact(context,contacts[index]),
                  
                ),
                IconButton(
                  icon: Icon(Icons.delete),color: Colors.red,
                  onPressed: () => deleteContact(context, contacts[index]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

