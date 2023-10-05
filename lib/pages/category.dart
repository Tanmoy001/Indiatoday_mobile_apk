import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:indiatodayapk/model/show_category.dart';
import 'package:indiatodayapk/pages/viewartical.dart';
import 'package:indiatodayapk/service/category_api.dart';
class Category extends StatefulWidget {
  final String ? name;
  Category({super.key, required this.name});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<CategoryComponent>newscategory =[];
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  getNews();
  }
  getNews()async{
NewsCategory newclass = NewsCategory();
await newclass.getCategoryNews(widget.name!.toLowerCase());
newscategory=newclass.news;
setState(() {
  _loading=false;
});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(widget.name!,style:const TextStyle(
                fontWeight: FontWeight.bold,
              ),),
              const SizedBox(width: 10,),
              const Text("News",style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),),
            ],
          ),
          // title: const Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(widget.name,style: TextStyle(
          //       color: Colors.white
          //     ),),
          //     Text(
          //       "News",
          //       style: TextStyle(
          //         color: Colors.redAccent,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     )
          //   ],
          // ),
        ),
      body: SingleChildScrollView(
        child: SafeArea(
          child:_loading?const Center(child: CircularProgressIndicator()): Container(
            child: ListView.builder(
                shrinkWrap: true,
                physics:const ClampingScrollPhysics(),
                itemCount: newscategory.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin:const EdgeInsets.symmetric(vertical: 10),
                    child: CardTitle(
                        name: newscategory[index].name!,
                        url: newscategory[index].name!,
                        title: newscategory[index].title!,
                        desc: newscategory[index].description!,
                        imageUrl: newscategory[index].urlToImage!),
                  );
                }),
          ),
        ),
      ),
    );
  }

}

class CardTitle extends StatelessWidget {
  String imageUrl, title, desc,url,name;

  CardTitle(
      {super.key,
        required this.name,
        required this.url,
        required this.title,
        required this.desc,
        required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       // Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewArtical(url: url, name: name)));
     Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewArtical(url: url, name: name)));
      },
      child: Container(
        //height: 100,
        padding:const EdgeInsets.symmetric(horizontal: 11),
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(11),
          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                    ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Image.network(
                            'images/news.jpg', // Replace with your default image asset path
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                          imageUrl: imageUrl,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )),
                 SizedBox(
                  // height: 10,
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        style:const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "$desc...",
                        style:const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
