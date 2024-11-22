import 'dart:async';
import 'package:api_request_with_bloc/features/posts/bloc/posts_event.dart';
import 'package:api_request_with_bloc/features/posts/bloc/posts_state.dart';
import 'package:api_request_with_bloc/features/posts/models/post_data_ui_model.dart';
import 'package:api_request_with_bloc/features/posts/repos/posts_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

//method for initial event
  Future<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostFetchingLoadingState());
    var client = http.Client();
    List<PostDataUiModel> posts = await PostsRepo.fetchPosts();
    //emitting
    emit(PostFetchingSuccessfulState(posts: posts));
  }

//method for add event
  Future<void> postAddEvent(
      PostAddEvent event, Emitter<PostsState> emit) async {
    bool success = await PostsRepo.addPost();

    if (success) {
      print(success);
      emit(PostAdditionSuccessState());
    } else {
      emit(PostAdditionErrorState());
    }
  }
}
