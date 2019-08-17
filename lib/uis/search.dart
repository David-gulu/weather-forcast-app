import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:forcaster/data/weatherdata.dart';
import 'package:forcaster/data/searchdata.dart';
import 'package:forcaster/blocs/bloc_provider.dart';
import 'package:forcaster/blocs/city_bloc.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();



}

class _SearchState extends State<SearchPage> {

  TextEditingController textEditingController = TextEditingController();
  SearchData searchData;

  Dio dio = Dio();
  Response response = Response();
  //int searchDataLen = 0;



  Future <Map<String,dynamic>> searchCity(String city) async {

    String url = WeatherData.urlSearchCity+'location='+city+'&key='+WeatherData.keys[0]+'&group=cn';
    response = await dio.get(url);
    print ('searchurl ' + url);
    print ('citySearch : '+ response.data.toString());
    return response.data;


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child:DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.lightBlue[200], Colors.lightBlue]),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(bottom: 0),
                                width: 330,
                                child: TextField(
                                  autofocus: true,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                      hintText: '请输入城市名称',
                                      prefixIcon: Image(
                                        image: AssetImage('images/search.png',
                                        ),
                                        color: Colors.white,
                                      ),
                                      border: InputBorder.none //取消下划线
                                  ),
                                  onChanged: (_) async {
                                    if(textEditingController.text.length >= 2) {
                                      searchCity(textEditingController.text).then((jsonOutput) {
                                        setState(() {
                                          searchData = new SearchData(jsonOutput);
                                        });
                                      });
                                    }
                                  },
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  '取消',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: (){
                                  Navigator.pop(context);
                                  SearchData.searchDataLen=0; //代码写的不好了，这个变量状态很重要，需要在视图层重置模型层的状态，高耦合
                                },
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          _renderRow(context, index),
                          Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: SearchData.searchDataLen==0 ? 1 : searchData.getSearchResult().length,
                ),
              ),
            ]
        ),
      ),
    );



  }

  Widget _renderRow(BuildContext context, int index) {

    if (0 != SearchData.searchDataLen) {
      return new ListTile(
        contentPadding: EdgeInsets.fromLTRB(20,0,20,0),
        title: new Text(searchData.getSearchResult()[index].getParentCity()),
        subtitle: Text(searchData.getSearchResult()[index].getAdminArea() + ' - ' + searchData.getSearchResult()[index].getLocation()),
        leading:Icon(Icons.location_city,size: 50,color: Colors.lightBlueAccent),
        onTap: () {
          CityBloc cityBloc = BlocProvider.of<CityBloc>(context);
          cityBloc.switchCity(searchData.getSearchResult()[index].getParentCity());
          SearchData.searchDataLen = 0; //必须设为0 ，要么下次进入的时候不为零，加载list会报null
          Navigator.pop(context);

        },
      );
    } else
      return new ListTile(
        contentPadding: EdgeInsets.fromLTRB(20,0,20,0),
        title: new Text('输入有误'),
        subtitle: Text('输入城市名或拼音'),
        leading: Icon(Icons.error, color: Colors.red, size: 50),

      );


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();


  }



}





