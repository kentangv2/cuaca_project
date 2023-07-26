import 'dart:convert';
import 'package:NewsLine/ui/news/news_1.dart';
import 'package:NewsLine/ui/news/news_2.dart';
import 'package:NewsLine/ui/news/news_3.dart';
import 'package:NewsLine/ui/news/news_4.dart';
import 'package:NewsLine/ui/news/news_5.dart';
import 'package:NewsLine/ui/news/news_6.dart';
import 'package:NewsLine/ui/news/news_7.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail_news.dart';

class NewsPaper extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<NewsPaper> {
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
      appBar: AppBar(title: Text('Berita CNN Terbaru Indonesia')),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: _isLoading ? _buildLoadingIndicator() : _buildNewsList(),
      ),
      floatingActionButton: _DropDown(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildNewsList() {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
              color: Colors.grey[200],
              height: 100,
              width: 100,
              child: _posts[index]['image']['small'] != null? Image.network(_posts[index]['image']['small'], width: 100,fit: BoxFit.cover,) : Center(),
            ),
            title: Text('${_posts[index]['title']}', maxLines: 2, overflow:TextOverflow.ellipsis),
            subtitle: Text('${_posts[index]['contentSnippet']}',maxLines: 2, overflow: 
            TextOverflow.ellipsis,),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> Detail(
                link: _posts[index]['link'],
                title: _posts[index]['title'],
                contentSnippet: _posts[index]['contentSnippet'],
                isoDate: _posts[index]['isoDate'],
                image: _posts[index]['image']['large'],
              )));
            },
        );
      },
    );
  }
  Widget _DropDown() {
    return FloatingActionButton(
      onPressed: () {},
      child: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'berita 1') {
            _navigateToNews1();
          } else if (value == 'berita 2') {
            _navigateToPage2();
          } else if (value == 'berita 3') {
            _navigateToPage3();
          }else if (value == 'berita 4'){
            _navigateToPage4();
          }else if (value == 'berita 5'){
            _navigateToPage5();
          }else if (value == 'berita 6'){
            _navigateToPage6();
          }else if (value == 'berita 7'){
            _navigateToPage7();
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(value: 'berita 1', child: Text('CNBC News')),
          PopupMenuItem(value: 'berita 2', child: Text('VOA News')),
          PopupMenuItem(value: 'berita 3', child: Text('Republika News')),
          PopupMenuItem(value: 'berita 4', child: Text('Kumparan News')),
          PopupMenuItem(value: 'berita 5', child: Text('OkeZone News')),
          PopupMenuItem(value: 'berita 6', child: Text('Vice News')),
          PopupMenuItem(value: 'berita 7', child: Text('Suara News')),
        ],
      ),
    );
  }

  void _navigateToNews1() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPaper1()));
  }
  void _navigateToPage2() {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>NewsPaper2() ));
  }
  void _navigateToPage3() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPaper3()));
  }
  void _navigateToPage4() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPaper4()));
  }
  void _navigateToPage5() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPaper5()));
  }
  void _navigateToPage6() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPaper6()));
  }
  void _navigateToPage7() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPaper7()));
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
          await http.get(Uri.parse('https://berita-indo-api.vercel.app/v1/cnn-news'));
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
