import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pull_to_refresh/post/bloc/post_bloc.dart';
import 'package:flutter_pull_to_refresh/post/model/post_model.dart';
import 'package:flutter_pull_to_refresh/post/view/test.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostsListPage extends StatelessWidget {
  const PostsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostBloc(),
      child: const PostsListView(),
    );
  }
}

class PostsListView extends StatefulWidget {
  const PostsListView({Key? key}) : super(key: key);

  @override
  _PostsListViewState createState() => _PostsListViewState();
}

class _PostsListViewState extends State<PostsListView> {
  final RefreshController _controller = RefreshController();

  late PostBloc bloc;

  @override
  void initState() {
    bloc = context.read();
    bloc.add(const LoadPostsEvent(false));
    super.initState();
  }

  Widget _buildListView() {
    return ListView.builder(
      itemBuilder: (_, e) {
        PostModel item = bloc.posts[e];
        return _buildCell(item);
      },
      physics: const ClampingScrollPhysics(),
      itemCount: bloc.posts.length,
    );
  }

  Widget _buildCell(PostModel item) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DraggableLoadingBottomSheet.routeName);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
            // color: Colors.blue.withOpacity(0.3),
            color: Colors.deepOrange.shade900,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Text('${item.id}'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item.title}',
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item.body}',
                      style: const TextStyle(color: Colors.white),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Posts'),
            ),
            body: SafeArea(
              child: SmartRefresher(
                controller: _controller,
                child: _buildListView(),
                enablePullUp: true,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 1000));
                  _controller.refreshCompleted();
                  bloc.add(const LoadPostsEvent(true));
                },
                onLoading: () async {
                  await Future.delayed(const Duration(milliseconds: 1000));
                  _controller.loadComplete();
                  bloc.add(const LoadPostsEvent(false));
                },
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
