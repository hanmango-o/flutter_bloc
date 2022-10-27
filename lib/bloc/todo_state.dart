import 'package:bloc_flow/model/todo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class TodoState extends Equatable {}

class Empty extends TodoState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class Loading extends TodoState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class Error extends TodoState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class Loaded extends TodoState {
  final List<Todo> todos;

  Loaded({required this.todos});

  @override
  List<Object?> get props => todos;
}
