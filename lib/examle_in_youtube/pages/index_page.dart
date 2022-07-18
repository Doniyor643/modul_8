import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';
import 'package:modul_8/examle_in_youtube/contants/base_api.dart';
import 'package:modul_8/examle_in_youtube/theme/theme_colors.dart';
import 'package:http/http.dart' as http;
import 'create.dart';
import 'edit.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  List usersList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listing users"),
        backgroundColor: primary,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const CreateUser()));
              },
              icon: const Icon(Icons.add, color: Colors.white,))
        ],
      ),
      body: getBody(),
    );
  }
  Widget getBody(){
    if(usersList.isEmpty){
      return const Center(child: CircularProgressIndicator(),);
    }
    return ListView.builder(
        itemCount: usersList.length,
        itemBuilder: (context,index){
      return cardItem(usersList[index]);
    });
  }

  Widget cardItem(data){
    return Card(
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context){
                deleteUser();
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context){
                editUser(data);
              },
              backgroundColor: const Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.drive_file_rename_outline,
              label: 'Rename',
            ),
          ],
        ),
        child: ListTile(
            title: Text(data['title']),
            subtitle: Text(data['body']),),
      ),
    );
  }

  editUser(data){
    String id = data['id'].toString();
    String title = data['title'].toString();
    String body = data['body'].toString();
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => EditUser(userId: id,userText: title,userBody: body,)));
  }
  deleteUser(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Delete"),
          content: const Text("Delete this user ?"),
          actions: [
            TextButton(
                onPressed: (){

                },
                child: const Text("Yes")),
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text("No"))
          ],
        ));
  }


  fetchUsers()async{
    setState((){
      isLoading = false;
    });
    var response = await http.get(Uri.parse(baseAPI+otherAPI));
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      setState((){
        usersList = items;
        isLoading = false;
      });
    }else{
      setState((){
        usersList = [];
        isLoading = false;
      });
    }
  }
}
