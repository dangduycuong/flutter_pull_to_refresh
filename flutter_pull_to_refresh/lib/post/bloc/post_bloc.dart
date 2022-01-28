import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_pull_to_refresh/post/model/post_model.dart';
import 'package:flutter_pull_to_refresh/post/service/post_api_service.dart';

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



    final client =
        PostClient(Dio(BaseOptions(contentType: "application/json")));
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
    } catch (_) {
      emit(LoadPostSuccessState());
    }
  }
}
