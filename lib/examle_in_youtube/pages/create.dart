import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modul_8/examle_in_youtube/contants/base_api.dart';
import 'package:modul_8/examle_in_youtube/theme/theme_colors.dart';
import 'package:http/http.dart' as http;
import 'package:modul_8/stores/home_store.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  HomeStore store = HomeStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creation User'),
        backgroundColor: primary,
      ),
      body: getBody(),
    );
  }

  Widget getBody(){
    return ListView(
      padding: const EdgeInsets.all(30),
      children: [
        const SizedBox(height: 30,),
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: "title"
          ),
        ),
        const SizedBox(height: 30,),
        TextField(
          controller: bodyController,
          decoration: const InputDecoration(
              hintText: "body"
          ),
        ),
        const SizedBox(height: 40,),
        Container(
          height: 40,
          width: double.infinity,
          color: primary,
          child: ElevatedButton(
              onPressed: (){
                store.createNewUser(titleController: titleController,bodyController: bodyController);
              },
              child: const Center(child: Text("Done"),),
              ),
        )
      ],
    );
  }
  createNewUser()async{
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

    }
  }
}
