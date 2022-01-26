import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sparrowconnected_homework/core/model/news.dart';
import 'package:sparrowconnected_homework/core/viewmodel/authviewmodel.dart';
import 'package:sparrowconnected_homework/core/viewmodel/newsviewmodel.dart';
import 'package:sparrowconnected_homework/view/costant/customtext.dart';
import 'package:sparrowconnected_homework/view/newsdetailpage.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomText.newsText),
        centerTitle: true,
        actions: [IconButton(onPressed: () => context.read<AuthViewModel>().signOut(), icon: const Icon(Icons.close))],
      ),
      body: StreamBuilder<QuerySnapshot<News>>(
        stream: context.read<NewsViewModel>().readAllNews(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.requireData;
          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => NewsDetailPage(
                            news: data.docs[index].data(),
                          )));
                },
                child: ListTile(
                  title: Text(
                    data.docs[index].data().headline,
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    data.docs[index].data().summary,
                    maxLines: 3,
                  ),
                  leading: Image.network(data.docs[index].data().image),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
