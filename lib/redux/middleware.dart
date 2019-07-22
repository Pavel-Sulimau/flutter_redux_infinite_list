import 'dart:convert';
import 'package:flutter_redux_infinite_list/models/github_issue.dart';
import 'package:flutter_redux_infinite_list/redux/actions.dart';
import 'package:flutter_redux_infinite_list/redux/state.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

List<Middleware<AppState>> createAppMiddleware() {
  return [
    TypedMiddleware<AppState, LoadItemsPageAction>(_loadItemsPage()),
    LoggingMiddleware.printer(),
  ];
}

_loadItemsPage() {
  return (Store<AppState> store, LoadItemsPageAction action,
      NextDispatcher next) {
    next(action);

    _loadFlutterGithubIssues(action.pageNumber, action.itemsPerPage).then(
      (itemsPage) {
        store.dispatch(ItemsPageLoadedAction(itemsPage));
      },
    ).catchError((exception, stacktrace) {
      store.dispatch(ErrorOccurredAction(exception));
    });
  };
}

Future<List<GithubIssue>> _loadFlutterGithubIssues(
    int page, int perPage) async {
  var response = await http.get(
      'https://api.github.com/repos/flutter/flutter/issues?page=$page&per_page=$perPage');
  if (response.statusCode == 200) {
    final items = json.decode(response.body) as List;
    return items.map((item) => GithubIssue.fromJson(item)).toList();
  } else {
    throw Exception('Error getting data, http code: ${response.statusCode}.');
  }
}
