import 'package:api_request_with_bloc/features/posts/bloc/posts_bloc.dart';
import 'package:api_request_with_bloc/features/posts/bloc/posts_event.dart';
import 'package:api_request_with_bloc/features/posts/bloc/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  //created a instance of bloc
  final PostsBloc postsBloc = PostsBloc();
  @override
  void initState() {
    //add the initial event where our api is their
    postsBloc.add(PostInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        titleTextStyle: TextStyle(fontSize: 25),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text('Post Page'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            postsBloc.add(PostAddEvent());
          }),
      body: BlocConsumer<PostsBloc, PostsState>(
          bloc: postsBloc,
          listenWhen: (previous, current) => current is PostsActionState,
          buildWhen: (previous, current) => current is! PostsActionState,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case PostFetchingLoadingState:
                return Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(seconds: 3),
                    child: Icon(
                      size: 50,
                      Icons.tag_faces_rounded,
                      color: Colors.pink,
                    ),
                  ),
                );

              case PostFetchingSuccessfulState:
                //storing a state in a variable
                final successState = state as PostFetchingSuccessfulState;

                return ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(16),
                    color: Colors.grey.shade200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          successState.posts[index].title,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(successState.posts[index].body),
                      ],
                    ),
                  ),
                );
              default:
                return SizedBox();
            }
          }),
    );
  }
}
