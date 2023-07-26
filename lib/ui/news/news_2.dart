import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail_news.dart';

class NewsPaper2 extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<NewsPaper2> {
  List _posts = [];
  bool _isLoading = false; 
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Berita VOA Terbaru Indonesia')),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: _isLoading ? _buildLoadingIndicator() : _buildNewsList(),
      ),
    );
  }

  Widget _buildNewsList() {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
              color: Colors.grey[200],
              height: 300,
              width: 100,
              child: _posts[index]['image']['small'] != null? Image.network(_posts[index]['image']['small'], width: 100,fit: BoxFit.cover,) : Center(),
            ),
            title: Text('${_posts[index]['title']}', maxLines: 2, overflow:TextOverflow.ellipsis),
            subtitle: Text('${_posts[index]['description']}',maxLines: 2, overflow: 
            TextOverflow.ellipsis,),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> Detail(
                link: _posts[index]['link'],
                title: _posts[index]['title'],
                contentSnippet: _posts[index]['description'],
                isoDate: _posts[index]['isoDate'],
                image: _posts[index]['image']['small'],
              )));
            },
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Future<void> _handleRefresh() async {
    // Kode untuk memperbarui data
    await _getData();
  }

  Future _getData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response =
          await http.get(Uri.parse('https://berita-indo-api.vercel.app/v1/voa'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _posts = data['data'];
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }
}
