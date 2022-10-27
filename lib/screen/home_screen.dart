import 'package:bloc_flow/bloc/todo_bloc.dart';
import 'package:bloc_flow/bloc/todo_event.dart';
import 'package:bloc_flow/repository/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc(repository: TodoRepository()),
      child: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String title = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoBloc>(context).add(ListTodoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Bloc')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TodoBloc>().add(CreateTodoEvent(title: title));
        },
        child: Icon(Icons.edit),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (val) {
              title = val;
            },
          ),
          SizedBox(height: 16.0),
          BlocBuilder<TodoBloc, TodoState>(
            builder: (_, state) {
              if (state is Empty) {
                return Container();
              } else if (state is Error) {
                return Container(
                  child: Text(state.toString()),
                );
              } else if (state is Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is Loaded) {
                final items = state.todos;

                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    final item = items[index];
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<TodoBloc>(context).add(
                              DeleteTodoEvent(todo: item),
                            );
                          },
                          child: Icon(Icons.delete),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: items.length,
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
