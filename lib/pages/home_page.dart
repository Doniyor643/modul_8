import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:modul_8/services/http_service.dart';

import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Post> items = [];
  bool isLoading = false;

  void _apiPostList()async{
    setState((){
      isLoading = true;
    });
    var response = await Network.getRequest(Network.apiList, Network.paramsEmpty());
    setState((){
      if(response != null){
        items = Network.parsePostList(response);
      }else{
        items = [];
      }
      isLoading = false;
    });
  }

  void _apiPostDelete(Post post) async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.deleteRequest(Network.apiList + post.id.toString(), Network.paramsEmpty());
    setState(() {
      if (response != null) {
        _apiPostList();
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("setState"),
      ),
      body: Stack(
          children: [
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index){
                return itemOfPost(items[index]);
              }),
            isLoading
                ?
            const Center(
              child: CircularProgressIndicator(),
            )
                :
            const SizedBox.shrink()
          ],
        )

    );
  }
  Widget itemOfPost(Post post) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            onPressed: (context){
              Network.deleteRequest(Network.apiList, Network.paramsEmpty());
            },
            icon: Icons.delete_outline,
            label: "Delete",),
          ]),
      startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.green,
              onPressed: (context){},
              icon: Icons.drive_file_rename_outline,
              label: "Rename",),
          ]),
      child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title.toUpperCase(),
                style:
                const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(post.body),
            ],
          ),
        ),
    );
  }
}
