import 'actions.dart';
import 'package:flutter_redux_infinite_list/models/github_issue.dart';
import 'package:flutter_redux_infinite_list/redux/state.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, action) {
  return state.copyWith(
    isDataLoading: _isDataLoadingReducer(state.isDataLoading, action),
    isNextPageAvailable:
        _isNextPageAvailableReducer(state.isNextPageAvailable, action),
    items: _itemsReducer(state.items, action),
    error: _errorReducer(state.error, action),
  );
}

final Reducer<bool> _isDataLoadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadItemsPageAction>(_isDataLoadingStartedReducer),
  TypedReducer<bool, ItemsPageLoadedAction>(_isDataLoadingFinishedReducer),
  TypedReducer<bool, ErrorOccurredAction>(_isDataLoadingFinishedReducer),
]);

bool _isDataLoadingStartedReducer(bool _, dynamic action) {
  return true;
}

bool _isDataLoadingFinishedReducer(bool _, dynamic action) {
  return false;
}

bool _isNextPageAvailableReducer(bool isNextPageAvailable, dynamic action) {
  return (action is ItemsPageLoadedAction)
      ? action.itemsPage.length == 20
      : isNextPageAvailable;
}

List<GithubIssue> _itemsReducer(List<GithubIssue> items, dynamic action) {
  if (action is ItemsPageLoadedAction) {
    return List.from(items)..addAll(action.itemsPage);
  } else if (action is LoadItemsPageAction && action.pageNumber == 1) {
    return List<GithubIssue>();
  } else {
    return items;
  }
}

final Reducer<Exception> _errorReducer = combineReducers<Exception>([
  TypedReducer<Exception, ErrorOccurredAction>(_errorOccurredReducer),
  TypedReducer<Exception, ErrorHandledAction>(_errorHandledReducer),
]);

Exception _errorOccurredReducer(Exception _, ErrorOccurredAction action) {
  return action.exception;
}

Exception _errorHandledReducer(Exception _, ErrorHandledAction action) {
  return null;
}
