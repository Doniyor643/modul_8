
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modul_8/examle_in_youtube/pages/create.dart';
import 'package:modul_8/services/http_service.dart';
import 'package:modul_8/stores/home_store.dart';
import 'package:modul_8/viewmodel/home_page_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

import '../examle_in_youtube/pages/edit.dart';
import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final HomePageViewModel homePageViewModel = HomePageViewModel();
  final HomeStore store = HomeStore();

  @override
  void initState() {
    super.initState();
    homePageViewModel.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MobX"),
      ),
      body: Observer(
        builder: (_)=>Stack(
          children: [
            ListView.builder(
                itemCount: store.items.length,
                itemBuilder: (context, index){
                  return itemOfPost(store.items[index]);
                }),
            store.isLoading
                ?
            const Center(
              child: CircularProgressIndicator(),
            )
                :
            const SizedBox.shrink()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => const CreateUser()));
        },
        child: const Icon(Icons.add),

      ),

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
              onPressed: (context){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => EditUser(
                      userId: post.id.toString(),
                      userBody: post.body,
                      userText: post.title,
                    )));
              },
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
