import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_pull_to_refresh/post/model/post_model.dart';
import 'package:flutter_pull_to_refresh/post/service/post_api_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  int _start = 0;
  final int _limit = 20;
  List<PostModel> posts = [];
  bool stopLoadMorePost = false;

  PostBloc() : super(PostInitial()) {
    on<PostEvent>((event, emit) {});
    on<LoadPostsEvent>(_fetchPosts);
  }

  void _fetchPosts(LoadPostsEvent event, Emitter<PostState> emit) async {
    emit(LoadingPostState());

    final dio = Dio(
      BaseOptions(
          baseUrl: "https://jsonplaceholder.typicode.com/",
          connectTimeout: 10000,
          contentType: "application/json"),
    );
    dio.interceptors.addAll(
      [
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      ],
    );

    final client = PostClient(dio);
    if (event.isRefresh) {
      _start = 0;
      stopLoadMorePost = false;
      posts = [];
    }

    try {
      List<PostModel> result = await client.getPosts(_start, _limit);

      if (result.isEmpty) {
        stopLoadMorePost = true;
      }

      for (PostModel element in result) {
        posts.add(element);
      }

      _start += _limit;
      emit(LoadPostSuccessState());
    } catch (e) {
      emit(LoadPostSuccessState());
    }
  }
}
