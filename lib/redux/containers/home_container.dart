import 'package:flutter_redux_infinite_list/models/github_issue.dart';
import 'package:flutter_redux_infinite_list/presentation/screens/home_screen.dart';
import 'package:flutter_redux_infinite_list/redux/actions.dart';
import 'package:flutter_redux_infinite_list/redux/state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class HomeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      builder: (context, vm) {
        return HomeScreen(
          isDataLoading: vm.isDataLoading,
          isNextPageAvailable: vm.isNextPageAvailable,
          items: vm.items,
          refresh: vm.onRefresh,
          loadNextPage: vm.onLoadNextPage,
          noError: vm.noError,
        );
      },
      converter: _ViewModel.fromStore,
      onInit: (store) {
        store.dispatch(
          LoadItemsPageAction(pageNumber: 1, itemsPerPage: AppState.itemsPerPage),
        );
      },
    );
  }
}

class _ViewModel {
  _ViewModel({
    this.isDataLoading,
    this.isNextPageAvailable,
    this.items,
    this.store,
    this.noError,
  });

  final bool isDataLoading;
  final bool isNextPageAvailable;
  final List<GithubIssue> items;
  final Store<AppState> store;
  final bool noError;

  void onLoadNextPage() {
    if (!isDataLoading && isNextPageAvailable) {
      store.dispatch(LoadItemsPageAction(
        pageNumber: (items.length ~/ AppState.itemsPerPage) + 1,
        itemsPerPage: AppState.itemsPerPage,
      ));
    }
  }

  void onRefresh() {
    store.dispatch(
      LoadItemsPageAction(pageNumber: 1, itemsPerPage: AppState.itemsPerPage),
    );
  }

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      isDataLoading: store.state.isDataLoading,
      isNextPageAvailable: store.state.isNextPageAvailable,
      items: store.state.items,
      store: store,
      noError: store.state.error == null,
    );
  }
}
