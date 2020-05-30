import 'package:webfeed/webfeed.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class Article {
  final String title;
  final String image;
  final String description;
  final String pubDate;
  final String guid;

  Article({this.title, this.image, this.description, this.pubDate, this.guid});

  factory Article.fromJson(Map<String, dynamic> json) {
     var images = json['images'];
     final String image = (json['images']['image_intro'].length > 0)?json['images']['image_intro'] : 'https://flutterj3.joomla.com/images/develop_joomla_and_flutter_app.jpg';
     
    return Article(
      title: json['title'],
      image: image,
      description: json['content'],
      pubDate: json['published_date'],
      guid: 'https://flutterj3.joomla.com/'
    );
  }
  factory Article.fromRss(RssItem json) {
     dom.Document document = parser.parse(json.description);
     var images = document.getElementsByTagName('img');
     String image;
     if(images.length > 0) {
       image = images[0].attributes['src'];
     } else {
       image = 'https://flutterj3.joomla.com/images/develop_joomla_and_flutter_app.jpg';
     }
    return Article(
      title: json.title,      
      description: json.description,
      image:  image,
      pubDate: json.pubDate,
      guid: json.guid
    );
  }
}