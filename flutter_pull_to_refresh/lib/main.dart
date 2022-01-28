import 'package:flutter/material.dart';
import 'package:flutter_pull_to_refresh/post/view/post_detail_page.dart';
import 'package:flutter_pull_to_refresh/post/view/posts_list_page.dart';
import 'package:flutter_pull_to_refresh/post/view/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        DraggableLoadingBottomSheet.routeName: (context) =>
            const DraggableLoadingBottomSheet(),
        PostDetailPage.routeName: (context) => const PostDetailPage(),
      },
      home: const PostsListPage(),
    );
  }
}
