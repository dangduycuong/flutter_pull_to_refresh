part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class LoadingPostState extends PostState {
  @override
  List<Object?> get props => [];
}

class LoadPostSuccessState extends PostState {
  @override
  List<Object?> get props => [];
}
