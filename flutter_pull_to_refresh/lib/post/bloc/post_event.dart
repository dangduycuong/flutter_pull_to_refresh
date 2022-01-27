part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class LoadPostsEvent extends PostEvent {
  final bool isRefresh;
  const LoadPostsEvent(this.isRefresh);
  @override
  List<Object?> get props => [];
}
