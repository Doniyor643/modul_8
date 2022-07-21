import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import '../examle_in_youtube/contants/base_api.dart';

part 'edit_store.g.dart';

class EditStore = _EditStore with _$EditStore;

abstract class _EditStore with Store {

  @observable String title = '';
  @observable String body = '';
  editUser({widget,titleController,bodyController})async{
    title = titleController.text;
    body = bodyController.text;
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
