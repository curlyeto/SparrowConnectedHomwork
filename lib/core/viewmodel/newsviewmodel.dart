import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sparrowconnected_homework/core/model/comment.dart';
import 'package:sparrowconnected_homework/core/model/news.dart';
import 'package:sparrowconnected_homework/core/services/newservices.dart';
import 'package:sparrowconnected_homework/locator.dart';

class NewsViewModel extends ChangeNotifier{
  final NewServices _newServices = locator<NewServices>();
  TextEditingController rateAddingController=TextEditingController();
  TextEditingController rateEditingController=TextEditingController();
  TextEditingController titleEditingController=TextEditingController();
  TextEditingController titleAddingController=TextEditingController();
  Stream<QuerySnapshot<News>> readAllNews() {
    return _newServices.readAllNews();
  }
  Stream<QuerySnapshot<Comment>> readCommentWithNews(News news,String userID) {
    return _newServices.readCommentWithNews(news,userID);
  }

  Future<bool> addComments(News news,Comment comment)async{
    return _newServices.addComments(news, comment);
  }
  Future<bool> deleteComment(News news,String userId)async{
    return _newServices.deleteComment(news,userId);
  }
  Future<bool> updateComment(News news,Comment comment)async{
    return _newServices.updateComment(news,comment);
  }
}