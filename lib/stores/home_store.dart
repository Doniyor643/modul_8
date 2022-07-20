
import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import '../examle_in_youtube/contants/base_api.dart';
import '../model/post_model.dart';
import '../services/http_service.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {

  @observable List<Post> items = [];
  @observable bool isLoading = false;

  Future apiPostList()async{
    isLoading = true;
    var response = await Network.getRequest(Network.apiList, Network.paramsEmpty());
    if(response != null){
      items = Network.parsePostList(response);
    }else{
      items = [];
    }
    isLoading = false;
  }

  Future<bool?> apiPostDelete(Post post) async {
    isLoading = true;
    var response = await Network.deleteRequest(Network.apiList + post.id.toString(), Network.paramsEmpty());
    isLoading = false;
    return response != null;

  }

  createNewUser({titleController,bodyController})async{
    String title = titleController.text;
    String body = bodyController.text;
    if(title.isNotEmpty && body.isNotEmpty){
      var bodyData = jsonEncode({
        "body":body,
        "title":title
      });
      var response = await http.post(
          Uri.parse(baseAPI+otherAPI),
          headers: headers,
          body: bodyData
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        titleController.clear();
        bodyController.clear();
      }else{

      }
      print("response Status Code = ${response.statusCode}");
      print("response = ${response.body}");

    }}

  editUser({titleController,bodyController})async{
    String title = titleController.text;
    String body = bodyController.text;
    if(title.isNotEmpty && body.isNotEmpty){
      var bodyData = jsonEncode({
        "title":title,
        "body":body
      });
      var response = await http.put(
          Uri.parse("$baseAPI$otherAPI/${widget.userId}"),
          headers: headers,
          body: bodyData
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        print(response.body);
      }else{
        print('error');
      }
    }
  }
}