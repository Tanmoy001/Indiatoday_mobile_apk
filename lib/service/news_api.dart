import 'dart:convert';

import 'package:indiatodayapk/model/newsartical.dart';
import 'package:http/http.dart'as http;
class News{
  List<NewsComponent> news =[];


  Future<void> getNews() async{
    String uri = "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=fa963863932043779dfe09c388777f25";
    var response = await http.get(Uri.parse(uri));
    var jsonData = jsonDecode(response.body);

    if (jsonData["status"]=='ok'){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"]!=null&& element["description"]!=null){
          String processedDescription = element["description"].length < 80
              ? element["description"]
              : element["description"].substring(0, 80);
          Map source = element["source"];
          NewsComponent newsComponent = NewsComponent(
            name: source["name"],
            title: element["title"],
            description: processedDescription,
            urlToImage: element["urlToImage"],
            url: element["url"],
            content: element["content"],
            author: element["author"],

          );
          news.add(newsComponent);

        }
      });
    }
  }
}