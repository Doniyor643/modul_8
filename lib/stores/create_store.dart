
import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

import '../examle_in_youtube/contants/base_api.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {

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
}