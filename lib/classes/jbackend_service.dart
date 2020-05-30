import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class JbackendService {
  final _targetUrl = 'https://YourJoomla3Site.com/api/';
  //final _targetUrl = 'https://YourJoomla4Site.com/api/';

  Future<List<dynamic>> getArticles() async {
    final String module = 'get/content/articles?orderdir=asc&catid=9';
    var responseObject;

    final response = await this.request(module);

    if (response.statusCode == 200) {
      responseObject = jsonDecode(response.body);

      if (responseObject['status'] == 'ko') {
        switch (responseObject['error_code']) {
          default:
            print('There was an error:' + responseObject['error_description']);
            break;
        }
      } else {
        return responseObject['articles'];
      }
    }
  }

  Future<http.Response> request(module) async {
    var url = this._targetUrl + module;

    final response = await http.get(url);

    return response;
  }

  Future<List<dynamic>> getArticlesj4() async {
    final String module = 'index.php/v1/content/article';
    var responseObject;

    final token = '';

    final response = await http.get(
      this._targetUrl + module,
      headers: {
        'Authorization': 'Bearer ' + token,
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate",
        "Content-Type": "application/json"
      },
    );

    if (response.statusCode == 200) {
      responseObject = jsonDecode(response.body);

      if (responseObject['status'] == 'ko') {
        switch (responseObject['error_code']) {
          default:
            print('There was an error:' + responseObject['error_description']);
            break;
        }
      }
      else
      {
        return responseObject['articles'];
      }
    }
  }
}
