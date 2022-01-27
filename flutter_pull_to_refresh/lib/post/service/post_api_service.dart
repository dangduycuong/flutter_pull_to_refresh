import 'package:dio/dio.dart';
import 'package:flutter_pull_to_refresh/post/model/post_model.dart';
import 'package:retrofit/retrofit.dart';

part 'post_api_service.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class PostClient {
  factory PostClient(Dio dio, {String baseUrl}) = _PostClient;

  @GET("/posts")
  Future<List<PostModel>> getPosts(
    @Query("_start") int start,
    @Query("_limit") int limit,
  );
}
