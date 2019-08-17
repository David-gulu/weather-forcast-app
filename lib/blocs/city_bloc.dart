import 'dart:async';
import 'bloc_base.dart';

class CityBloc extends BlocBase {

  final _controller = StreamController<String>.broadcast();

  StreamSink<String> get citySink => _controller.sink;
  get cityStream => _controller.stream;
  void switchCity(String cityToSwitch) => citySink.add(cityToSwitch);
  void dispose() => _controller.close();



}