import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:indiatodayapk/model/slider.dart';
import 'package:indiatodayapk/pages/viewartical.dart';
class Breakingnews extends StatefulWidget {
  List<NewsSliderComponent> allbreakingnews =[];
  Breakingnews ({required this.allbreakingnews});


  @override
  State<Breakingnews> createState() => _BreakingnewsState();
}

class _BreakingnewsState extends State<Breakingnews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Breaking",style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(width: 10,),
            Text("News",style: TextStyle(
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
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                physics:const ClampingScrollPhysics(),
                itemCount: widget.allbreakingnews.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin:const EdgeInsets.symmetric(vertical: 10),
                    child: CardTitle(
                        name: widget.allbreakingnews[index].name!,
                        url: widget.allbreakingnews[index].name!,
                        title: widget.allbreakingnews[index].title!,
                        desc: widget.allbreakingnews[index].description!,
                        imageUrl: widget.allbreakingnews[index].urlToImage!),
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
                const SizedBox(
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

