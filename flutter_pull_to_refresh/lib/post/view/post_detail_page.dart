import 'package:flutter/material.dart';
import 'package:flutter_pull_to_refresh/post/model/post_model.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({Key? key}) : super(key: key);

  static const routeName = 'PostDetailPage';

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)?.settings.arguments as PostModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '${post.title}',
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '${post.body}',
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
