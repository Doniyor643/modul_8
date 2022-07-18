

import 'dart:convert';

import 'package:http/http.dart';

import '../model/post_model.dart';

class Network {
  static String base = "jsonplaceholder.typicode.com";
  static Map<String,String> headers = {'Content-Type':'application/json; charset=UTF-8'};

  /* Http Apis */

  static String apiList = "/posts";
  static String apiCreate = "/posts";
  static String apiUpdate = "/posts/"; //{id}
  static String apiDelete = "/posts/"; //{id}

  /* Http Requests */

  static Future<String?> getRequest(String api, Map<String, String> params) async {
    var uri = Uri.https(base, api, params); // http or https
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> postRequest(String api, Map<String, String> params) async {
    print(params.toString());
    var uri = Uri.https(base, api); // http or https
    var response = await post(uri, headers: headers,body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> putRequest(String api, Map<String, String> params) async {
    var uri = Uri.https(base, api); // http or https
    var response = await put(uri, headers: headers,body: jsonEncode(params));
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> deleteRequest(String api, Map<String, String> params) async {
    var uri = Uri.https(base, api, params); // http or https
    var response = await delete(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  /* Http Params */

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Post post) {
    Map<String, String> params = {};
    params.addAll({
      'title': post.title,
      'body': post.body,
      'userId': post.userId.toString(),
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Post post) {
    Map<String, String> params = {};
    params.addAll({
      'id': post.id.toString(),
      'title': post.title,
      'body': post.body,
      'userId': post.userId.toString(),
    });
    return params;
  }

  /* Http Parsing */

  static List<Post> parsePostList(String response) {
    dynamic json = jsonDecode(response);
    var data = List<Post>.from(json.map((x) => Post.fromJson(x)));
    return data;
  }

}