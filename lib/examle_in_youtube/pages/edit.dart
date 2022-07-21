import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modul_8/examle_in_youtube/contants/base_api.dart';
import 'package:modul_8/examle_in_youtube/theme/theme_colors.dart';

import 'package:modul_8/stores/home_store.dart';

import '../../stores/edit_store.dart';

class EditUser extends StatefulWidget{
  final String userId;
  final String userText;
  final String userBody;
  const EditUser({required this.userId,required this.userText,required this.userBody,Key? key}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  EditStore store = EditStore();
  String id = '';
  @override
  void initState() {
    super.initState();
      id = widget.userId;
      titleController.text = widget.userText;
      bodyController.text = widget.userBody;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edition User'),
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
              hintText: "Full name"
          ),
        ),
        const SizedBox(height: 30,),
        TextField(
          controller: bodyController,
          decoration: const InputDecoration(
              hintText: "Email"
          ),
        ),
        const SizedBox(height: 40,),
        Container(
          height: 40,
          width: double.infinity,
          color: primary,
          child: ElevatedButton(
            onPressed: (){
              store.editUser(titleController: titleController,bodyController: bodyController);
            },
            child: const Center(child: Text("Done"),),
          ),
        )
      ],
    );
  }
  // editUser()async{
  //   String title = titleController.text;
  //   String body = bodyController.text;
  //   if(title.isNotEmpty && body.isNotEmpty){
  //     var bodyData = jsonEncode({
  //       "title":title,
  //       "body":body
  //     });
  //     var response = await http.put(
  //       Uri.parse("$baseAPI$otherAPI/${widget.userId}"),
  //       headers: headers,
  //       body: bodyData
  //     );
  //     if(response.statusCode == 200 || response.statusCode == 201){
  //       print(response.body);
  //     }else{
  //       print('error');
  //     }
  //   }
  // }
}