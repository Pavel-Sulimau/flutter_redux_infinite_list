import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_infinite_list/models/github_issue.dart';
import 'package:meta/meta.dart';

class LoadItemsPageAction {
  LoadItemsPageAction({
    @required this.pageNumber,
    @required this.itemsPerPage,
  });

  final int pageNumber;
  final int itemsPerPage;
}

class ItemsPageLoadedAction {
  ItemsPageLoadedAction(this.itemsPage);

  final List<GithubIssue> itemsPage;
}

class ErrorOccurredAction {
  ErrorOccurredAction(this.exception);

  final Exception exception;
}

class ErrorHandledAction {}
