import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sparrowconnected_homework/core/model/comment.dart';
import 'package:sparrowconnected_homework/core/model/news.dart';

class NewServices{
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  Stream<QuerySnapshot<News>> readAllNews() {
   final newsRef = _firebaseDB
       .collection('news')
       .withConverter<News>(
     fromFirestore: (snapshots, _) => News.fromMap(snapshots.data()!),
     toFirestore: (news, _) => news.toJson(),
   );
   return newsRef.snapshots();
  }
  Stream<QuerySnapshot<Comment>> readCommentWithNews(News news,String userId) {
    final commentRef = _firebaseDB
        .collection('comment')
        .doc(news.id)
        .collection("users")
        .where("user_id",isEqualTo:userId)
        .withConverter<Comment>(
      fromFirestore: (snapshots, _) => Comment.fromMap(snapshots.data()!),
      toFirestore: (comment, _) => comment.toMap(),
    );
    return commentRef.snapshots();
  }
  Future<bool> addComments(News news,Comment comment)async{
   try{
     await _firebaseDB
         .collection("comment")
         .doc(news.id)
         .collection("users")
         .doc(comment.userId)
         .set(comment.toMap());
     return true;
   }catch(e){
     return false;
   }
  }
  Future<bool> deleteComment(News news,String userId)async{
    try{
      await _firebaseDB.collection("comment").doc(news.id)
          .collection("users").doc(userId).delete();
      return true;
    }catch(e){
      return false;
    }

  }
  Future<bool> updateComment(News news,Comment comment)async{
    try{
      await _firebaseDB
          .collection("comment")
          .doc(news.id)
          .collection("users")
          .doc(comment.userId)
          .update(comment.toMap());
      return true;
    }catch(e){
      return false;
    }
  }
}