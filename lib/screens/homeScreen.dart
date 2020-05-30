import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'webview_container.dart';

import '../classes/jbackend_service.dart';
import '../classes/rss_service.dart';
import '../classes/article.dart';

class HomeScreen extends StatelessWidget {
  AtomFeed feed;

  HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Joomla App'),
        ),
        body: FutureBuilder(
          future: RssService().getArticles(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final items = snapshot.data;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = Article.fromRss(items[index]);
                  return ListTile(
                    leading: Image.network(item.image, width: 100, fit: BoxFit.cover,),
                    title: Text(item.title),
                    subtitle: Text('Published at ' +
                        item.pubDate),
                    contentPadding: EdgeInsets.all(16.0),
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewContainer(
                                  item.guid)));
                    },
                  );
                },
              );
            }
          },
        ));
  }
}
