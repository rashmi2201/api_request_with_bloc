import 'package:api_request_with_bloc/features/posts/models/post_data_ui_model.dart';

abstract class PostsState {}

abstract class PostsActionState extends PostsState {}

class PostsInitial extends PostsState {}

//loading state
class PostFetchingLoadingState extends PostsState {}

//error state
class PostFetchingErrorState extends PostsState {}

class PostFetchingSuccessfulState extends PostsState {
  final List<PostDataUiModel> posts;
  //emitting the state in post bloc
  PostFetchingSuccessfulState({required this.posts});
}

class PostAdditionSuccessState extends PostsActionState {}

class PostAdditionErrorState extends PostsActionState {}
