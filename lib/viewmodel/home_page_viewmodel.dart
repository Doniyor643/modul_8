
import 'package:scoped_model/scoped_model.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';
final HomePageViewModel homePageViewModel = HomePageViewModel();
class HomePageViewModel extends Model{

  List<Post> items = [];
  bool isLoading = false;

  Future apiPostList()async{

    isLoading = true;
    notifyListeners();

    var response = await Network.getRequest(Network.apiList, Network.paramsEmpty());

      if(response != null){
        items = Network.parsePostList(response);
      }else{
        items = [];
      }
      isLoading = false;
    notifyListeners();

  }

  Future<bool?> apiPostDelete(Post post) async {

      isLoading = true;
      notifyListeners();

    var response = await Network.deleteRequest(Network.apiList + post.id.toString(), Network.paramsEmpty());

      isLoading = false;
      notifyListeners();
      return response != null;

  }
}