import 'package:bloc_flow/model/todo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class TodoEvent extends Equatable {}

class ListTodoEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class CreateTodoEvent extends TodoEvent {
  final String title;

  CreateTodoEvent({required this.title});

  @override
  List<Object?> get props => [title];
}

class DeleteTodoEvent extends TodoEvent {
  final Todo todo;

  DeleteTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}
