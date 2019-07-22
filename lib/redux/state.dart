import 'package:flutter_redux_infinite_list/models/github_issue.dart';

class AppState {
  AppState({
    this.isDataLoading,
    this.isNextPageAvailable,
    this.items,
    this.error,
  });

  final bool isDataLoading;
  final bool isNextPageAvailable;
  final List<GithubIssue> items;
  final Exception error;

  static const int itemsPerPage = 20;

  factory AppState.initial() => AppState(
        isDataLoading: false,
        isNextPageAvailable: false,
        items: const [],
      );

  AppState copyWith({
    isDataLoading,
    isNextPageAvailable,
    items,
    error,
  }) {
    return AppState(
      isDataLoading: isDataLoading ?? this.isDataLoading,
      isNextPageAvailable: isNextPageAvailable ?? this.isNextPageAvailable,
      items: items ?? this.items,
      error: error != this.error ? error : this.error,
    );
  }

  @override
  String toString() {
    return "AppState: isDataLoading = $isDataLoading, "
        "isNextPageAvailable = $isNextPageAvailable, "
        "itemsLength = ${items.length}, "
        "error = $error.";
  }
}
