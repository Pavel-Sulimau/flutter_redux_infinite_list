import 'package:flutter_redux_infinite_list/redux/containers/home_container.dart';
import 'package:flutter_redux_infinite_list/redux/middleware.dart';
import 'package:flutter_redux_infinite_list/redux/reducers.dart';
import 'package:flutter_redux_infinite_list/redux/state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: createAppMiddleware(),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeContainer(),
        theme: ThemeData(
          primaryColor: Color(0xFF0054A0),
        ),
      ),
    );
  }
}
