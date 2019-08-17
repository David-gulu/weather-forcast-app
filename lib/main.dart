import 'package:flutter/material.dart';
import 'package:forcaster/uis/search.dart';
import 'package:forcaster/uis/myhomepage.dart';
import 'package:forcaster/uis/detail.dart';
import 'package:forcaster/blocs/bloc_provider.dart';
import 'package:forcaster/blocs/city_bloc.dart';

void main() => runApp(
  BlocProvider(child:  MyApp(), bloc: CityBloc()));

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();



}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'flutter demo',),
//        BlocProvider(
//          child: MyHomePage(title: 'flutter demo',),
//          bloc: CityBloc()),
      routes: <String, WidgetBuilder> {
        'search':(_) => SearchPage(),
        'detail':(_) => DetailPage(),
      },
    );


  }



}


