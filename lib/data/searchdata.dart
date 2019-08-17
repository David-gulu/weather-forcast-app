import 'package:forcaster/data/searchunit.dart';

//模型类

class SearchData {

  List<SearchUnit> searchResult = List<SearchUnit>();
  Map<String, dynamic> json;
  static int searchDataLen = 0;

  SearchData(Map<String, dynamic> _json) {

    searchDataLen = 0;

    json= _json['HeWeather6'][0];
    if(json['status'].toString() != 'ok') {
      searchDataLen = 0;
      return;
    }
    List<dynamic> info = json['basic'];
    setDataFromJson(info);


  }


  setDataFromJson(List<dynamic> info) {

    for (int i = 0; i< info.length; i++) {

      Map<String, dynamic> map = info[i];
      searchResult.add(SearchUnit(map['admin_area'], map['parent_city'], map['location']));
      searchDataLen = searchResult.length;

    }


  }

  List<SearchUnit> getSearchResult () {

    return searchResult;


  }




}