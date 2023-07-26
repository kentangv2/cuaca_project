import 'package:flutter/material.dart';

class Detail extends StatelessWidget{
  final link;
  final title;
  final contentSnippet;
  final isoDate;
  final image;
  final creator;

  Detail({
    this.link,
    this.title,
    this.contentSnippet,
    this.isoDate,
    this.image,
    this.creator
  });

  @override
  Widget build(BuildContext context){
    return SafeArea(
    child : Scaffold(
      body: Column(
        children: <Widget>[
          image != null ? Image.network(image) : Container(
            height: 250,
            color: Colors.grey[200],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('$title', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 10),
                Text('$isoDate',style: TextStyle(
                  fontStyle: FontStyle.italic
                ),),
                SizedBox(height: 20),
                Text('$contentSnippet'),
                Divider(),
                Text('Author: $creator'),
                Text('Sumber: '),
                Text('$link',
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),)
              ],
            ),
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: ()=> Navigator.pop(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ),
    );
  }
}

