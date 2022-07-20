
import 'package:mobx/mobx.dart';

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
}