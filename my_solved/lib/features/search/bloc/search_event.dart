part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {}

class SearchTextFieldOnChanged extends SearchEvent {
  final String text;

  SearchTextFieldOnChanged({required this.text});

  @override
  List<Object?> get props => [text];
}

class SearchTextFieldOnSummited extends SearchEvent {
  final String text;

  SearchTextFieldOnSummited({required this.text});

  @override
  List<Object?> get props => [text];
}