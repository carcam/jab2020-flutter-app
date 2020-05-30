import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class RssService {
  final _targetUrl = 'https://community.joomla.org/blogs/community.feed';

  Future<RssFeed> getFeed() =>
      http.read(_targetUrl).then((xmlString) => RssFeed.parse(xmlString));

  Future<List<dynamic>> getArticles() async {
    var feed = await this.getFeed();

    return feed.items;
  }
}