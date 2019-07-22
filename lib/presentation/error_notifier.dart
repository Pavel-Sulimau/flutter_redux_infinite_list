import 'package:flutter_redux_infinite_list/redux/actions.dart';
import 'package:flutter_redux_infinite_list/redux/state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class ErrorNotifier extends StatelessWidget {
  ErrorNotifier({
    @required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) => child,
      onDidChange: (vm) {
        if (vm.error != null) {
          vm.markErrorAsHandled();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(vm.error.toString()),
            ),
          );
        }
      },
      distinct: true,
    );
  }
}

class _ViewModel {
  _ViewModel({
    this.markErrorAsHandled,
    this.error,
  });

  final Function markErrorAsHandled;
  final Exception error;

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      markErrorAsHandled: () => store.dispatch(ErrorHandledAction()),
      error: store.state.error,
    );
  }

  @override
  int get hashCode => error.hashCode;

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is _ViewModel && other.error == this.error;
}
