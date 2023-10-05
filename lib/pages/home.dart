
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:indiatodayapk/model/category_model.dart';
import 'package:indiatodayapk/model/newsartical.dart';
import 'package:indiatodayapk/model/slider.dart';
import 'package:indiatodayapk/pages/category.dart';
import 'package:indiatodayapk/pages/viewallbreakingnews.dart';
import 'package:indiatodayapk/pages/viewallnews.dart';
import 'package:indiatodayapk/pages/viewartical.dart';
import 'package:indiatodayapk/service/category.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:indiatodayapk/service/news_api.dart';
import 'package:indiatodayapk/service/silderData.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<NewsComponent> newsartical = [];
  List<NewsSliderComponent> sliders = [];
  List<CategoryModel> categories = [];
  bool _loading = true;
  @override
  void initState() {
    categories = getCategory();
    getNews();
    getNewslider();
    // TODO: implement initState
    super.initState();
  }

  void getNewslider() async {
    Newslider newsClass = Newslider();
    await newsClass.getSlider();
    sliders = newsClass.newslider;

    setState(() {
      _loading = false;
    });
  }

  void getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    newsartical = newsClass.news;

    setState(() {
      _loading = false;
    });
  }

  Widget buildImage(String image, int index, String title,String desc,String url,String name) =>
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewArtical(url: url, name: name)));
        },
        child:  Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child:CachedNetworkImage(
                    placeholder: (context, url) =>const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.network(
                      'images/news.jpg', // Replace with your default image asset path
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    imageUrl: image,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )),
                  // child: Image.network(
                  //   image,
                  //   fit: BoxFit.cover,
                  //   width: MediaQuery.of(context).size.width,
                  //   height: MediaQuery.of(context).size.height,
                  // )),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    gradient: const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.9),
                          Color.fromRGBO(0, 0, 0, 0.05),
                        ])),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(

                    padding: EdgeInsets.only(left: 90,right: 10),
                    child: Text(
                               title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                  ),
                    const SizedBox(height: 10,),
                    Container(

                      padding:const EdgeInsets.only(left: 90,right: 10),
                      child: Text(
                        "$desc .....",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 11),
                      ),
                    ),
                  ],
                ),

              )
            ],
          ),

      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("India"),
            Text(
              "Today",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal, // Set to horizontal

                        itemCount: categories.length,

                        itemBuilder: (BuildContext context, int index) {
                          return Categories(
                            image: categories[index].image,
                            categoryName: categories[index].categoryName,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 70,
                      margin:const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Breaking',
                                style: TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w800,
                                  shadows: [
                                    Shadow(
                                      color: Colors.grey, // Shadow color
                                      offset: Offset(
                                          1.0, 1.0), // Offset of the shadow
                                      blurRadius:
                                          4.0, // Blur radius of the shadow
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16.0, height: 70.0),
                              DefaultTextStyle(
                                style: const TextStyle(
                                    fontSize:
                                        21.0, // You can adjust the font size as needed
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Mansalva",
                                    color: Colors.red
                                    // fontFamily: 'Horizon',
                                    ),
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    RotateAnimatedText('NEWS'),
                                    RotateAnimatedText('समाचार '),
                                    RotateAnimatedText('খবর '),
                                  ],
                                  repeatForever: true,
                                ),
                              ),
                            ],
                          ),
                          
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Breakingnews(allbreakingnews: sliders)));
                                },
                                child: const Text(
                                  "View All",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.blue),
                                ),
                              ),
                           
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CarouselSlider.builder(
                      itemCount: 6,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        String? res = sliders[index].urlToImage;
                        String? res1 = sliders[index].title;
                        String? res2 = sliders[index].description;
                        String? res3 = sliders[index].url;
                        String? res4 = sliders[index].name;

                        return buildImage(res!, index, res1!,res2!,res3!,res4!);
                      },
                      options: CarouselOptions(
                          height: 200,
                          //viewportFraction: 1,
                          enlargeCenterPage: true,
                          autoPlay: true),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 70,
                      margin:const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                style: const TextStyle(
                                  fontSize:
                                      21.0, // You can adjust the font size as needed
                                  fontWeight: FontWeight.w800,

                                  color: Color(0xFFF114b5f),
                                  // fontFamily: 'Horizon',
                                ),
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText('TRANDING News'),
                                    TypewriterAnimatedText('TRANDING समाचार'),
                                    TypewriterAnimatedText('TRANDING খবর'),
                                  ],
                                  repeatForever: true,
                                ),
                              ),
                            ],
                          ),
                          // const Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                               GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewallnews(allnews: newsartical)));
                                },
                                 child: const Text(
                                  "View All",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.blue),
                              ),
                               ),
                            //],
                          //),

                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                     ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: 11,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: CardTitle(
                                name: newsartical[index].name!,
                                  url: newsartical[index].name!,
                                  title: newsartical[index].title!,
                                  desc: newsartical[index].description!,
                                  imageUrl: newsartical[index].urlToImage!),
                            );
                          }),

                  ],
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
       Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewArtical(url: url, name: name)));
      },
      child: Container(
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
                          placeholder: (context, url) => CircularProgressIndicator(),
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

class Categories extends StatelessWidget {
  final image, categoryName;
  Categories({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
//        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewArtical(url: url, name: name)));

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Category(name: categoryName)));
      },
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.network(
                  image,
                  width: 120,
                  height: 80,
                  fit: BoxFit.cover,
                )),
            Container(
              height: 80,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(11),
                  gradient:const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black12,
                        Colors.blueAccent,
                      ])),
              child: Center(
                child: Text(
                  categoryName,
                  style:const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
