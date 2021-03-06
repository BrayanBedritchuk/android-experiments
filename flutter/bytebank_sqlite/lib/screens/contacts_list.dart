import 'package:bytebank_sqlite/database/app_database.dart';
import 'package:bytebank_sqlite/models/contact.dart';
import 'package:bytebank_sqlite/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts')),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        // future: Future.delayed(Duration(seconds: 1)).then((value) => findAll()),
        future: findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[CircularProgressIndicator(), Text("Loading")],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return _ContactItem(contact);
                },
                itemCount: contacts.length,
              );
              break;
          }

          return Text("Unknown error");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onContactFormPressed(context);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  void _onContactFormPressed(BuildContext context) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ContactForm()));
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  const _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
