import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sparrowconnected_homework/core/model/comment.dart';
import 'package:sparrowconnected_homework/core/model/news.dart';
import 'package:provider/provider.dart';
import 'package:sparrowconnected_homework/core/viewmodel/authviewmodel.dart';
import 'package:sparrowconnected_homework/core/viewmodel/newsviewmodel.dart';
import 'package:sparrowconnected_homework/view/costant/customtext.dart';
import 'package:sparrowconnected_homework/view/custom/toastmessage.dart';
import 'package:sparrowconnected_homework/view/widget/textformfield.dart';

class NewsDetailPage extends StatelessWidget {
  final News news;

  const NewsDetailPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomText.newsDetailText),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Image.network(news.image),
              ),
              Expanded(flex: 1, child: Text(news.headline)),
              Expanded(flex: 2, child: Text(news.summary)),
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Text(CustomText.myCommentText),
                      StreamBuilder<QuerySnapshot<Comment>>(
                        stream: context.read<NewsViewModel>().readCommentWithNews(news, context.read<AuthViewModel>().user!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          }
                          if (!snapshot.hasData) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.requireData.size > 0) {
                            final data = snapshot.requireData;
                            return editComment(context, data);
                          } else {
                            return addComment(context);
                          }
                        },
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget addComment(BuildContext context) {
    return Column(
      children: [
        MyTextFormField(
          controller: context.read<NewsViewModel>().rateAddingController,
          textInputType: TextInputType.number,
          hintText: CustomText.rateText,
        ),
        MyTextFormField(
          controller: context.read<NewsViewModel>().titleAddingController,
          textInputType: TextInputType.text,
          hintText: CustomText.titleText,
        ),
        TextButton(
          child: Text(CustomText.addCommentText),
          onPressed: () async {
            Comment comment = Comment(
                newsId: int.parse(news.id),
                rate: int.parse(context.read<NewsViewModel>().rateAddingController.text),
                title: context.read<NewsViewModel>().titleAddingController.text,
                userId: context.read<AuthViewModel>().user!.uid);
            bool result = await context.read<NewsViewModel>().addComments(news, comment);
            if (result) {
              MyToastMessage.myToastMessage(message: CustomText.addSucText, color: Colors.green);
              Navigator.of(context).pop();
            } else {
              MyToastMessage.myToastMessage(message: CustomText.addFailText, color: Colors.red);
            }
          },
        )
      ],
    );
  }

  Widget editComment(BuildContext context, QuerySnapshot<Comment> data) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        itemCount: data.size,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(data.docs[index].data().rate.toString()),
              Text(
                data.docs[index].data().title,
                maxLines: 1,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        bool result = await context.read<NewsViewModel>().deleteComment(news, context.read<AuthViewModel>().user!.uid);
                        if (result) {
                          MyToastMessage.myToastMessage(message: CustomText.deleteSucText, color: Colors.green);
                        } else {
                          MyToastMessage.myToastMessage(message: CustomText.deleteFailText, color: Colors.red);
                        }
                      },
                      icon: const Icon(Icons.remove)),
                  IconButton(
                      onPressed: () {
                        context.read<NewsViewModel>().rateEditingController.text = data.docs[index].data().rate.toString();
                        context.read<NewsViewModel>().titleEditingController.text = data.docs[index].data().title;
                        _editDialog(context);
                      },
                      icon: const Icon(Icons.edit))
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Future<void> _editDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(CustomText.editCommentText),
          content: SingleChildScrollView(
            child: Column(
              children: [
                MyTextFormField(
                  controller: context.read<NewsViewModel>().rateEditingController,
                  textInputType: TextInputType.number,
                  hintText: CustomText.rateText,
                ),
                MyTextFormField(
                  controller: context.read<NewsViewModel>().titleEditingController,
                  textInputType: TextInputType.text,
                  hintText: CustomText.titleText,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(CustomText.cancelText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(CustomText.editCommentText),
              onPressed: () async {
                Comment comment = Comment(
                    newsId: int.parse(news.id),
                    rate: int.parse(context.read<NewsViewModel>().rateEditingController.text),
                    title: context.read<NewsViewModel>().titleEditingController.text,
                    userId: context.read<AuthViewModel>().user!.uid);
                bool result = await context.read<NewsViewModel>().updateComment(news, comment);
                if (result) {
                  MyToastMessage.myToastMessage(message: CustomText.updateSucText, color: Colors.green);
                  Navigator.of(context).pop();
                } else {
                  MyToastMessage.myToastMessage(message: CustomText.updateFailText, color: Colors.red);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
