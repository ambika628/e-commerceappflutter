import 'package:flutter/material.dart';
import 'package:flutter_project/pages/category_products.dart';
import 'package:flutter_project/services/shared_pref.dart';
import 'package:flutter_project/widget/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    "images/headphone_icon.png",
    "images/laptop.png",
    "images/watch.png",
    "images/TV.png",
  ];

  List Categoryname=[
    "Headphone",
    "Laptop",
    "watch",
    "TV"
  ];

  String? name, image;

  getthesharedpref()async{
    name= await SharedPreferenceHelper().getUserName();
    image= await SharedPreferenceHelper().getUserImage();
    setState(() {
    });
  }

  ontheload()async{
    await getthesharedpref();
    setState(() {

    });
  }
  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body:name==null?Center(child: CircularProgressIndicator(),): Container(
        margin: EdgeInsets.only(left: 20.0, top: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hey "+name!,
                          style: AppWidget.boldTextFeildStyle()),
                      Text("Good Morning",
                        style: AppWidget.lightTextFeildStyle(),),

                    ],
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset("images/boy.jpg", height: 70,
                        width: 70,
                        fit: BoxFit.cover,))
                ],
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: AppWidget.lightTextFeildStyle(),
                    prefixIcon: Icon(Icons.search, color: Colors.black,)),
              ),
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories", style: AppWidget.semiboldTextFeildStyle(),),
                Text("See all", style: TextStyle(color: Color(0xfffd6f3e),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold))
              ],),
            SizedBox(height: 20.0,),
            Row(
              children: [
            Container(
              height: 130,
            padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Color(0xfffd6f3e),
          borderRadius: BorderRadius.circular(10),

        ),
        child: Center(child: Text("All",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),)),
      ),
                Expanded(
                  child: Container(
                    height: 130,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(image: categories[index],name: Categoryname[index],);
                        }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("All Products", style: AppWidget.semiboldTextFeildStyle(),),
                Text("See all", style: TextStyle(color: Color(0xfffd6f3e),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold))
              ],),
            SizedBox(height: 25.0,),
            Container(
              height:210 ,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    padding:EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(children: [
                      Image.asset("images/headphone2.png",height: 120,width: 120,fit: BoxFit.cover,),
                      Text("Headphone",style: AppWidget.semiboldTextFeildStyle(),),
                      SizedBox(height: 10.0,),
                      Row(
                        children: [
                        Text("\$100",style: TextStyle(color: Color(0xfffd6f3e),fontSize: 20.0,fontWeight: FontWeight.bold),),
                       SizedBox(width: 40.0,),
                        Container(
                          padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(color: Color(0xfffd6f3e),borderRadius: BorderRadius.circular(5)),
                            child: Icon(Icons.add,color: Colors.white,))
                      ],)
                    ],),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    padding:EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(children: [
                      Image.asset("images/watch2.png",height: 120,width: 120,fit: BoxFit.cover,),
                      Text("Apple Watch",style: AppWidget.semiboldTextFeildStyle(),),
                      SizedBox(height: 10.0,),
                      Row(
                        children: [
                          Text("\$300",style: TextStyle(color: Color(0xfffd6f3e),fontSize: 20.0,fontWeight: FontWeight.bold),),
                          SizedBox(width: 40.0,),
                          Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(color: Color(0xfffd6f3e),borderRadius: BorderRadius.circular(5)),
                              child: Icon(Icons.add,color: Colors.white,))
                        ],)
                    ],),
                  ),
                  Container(
                    padding:EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(children: [
                      Image.asset("images/laptop2.png",height: 120,width: 120,fit: BoxFit.cover,),
                      Text("Laptop",style: AppWidget.semiboldTextFeildStyle(),),
                      SizedBox(height: 10.0,),
                      Row(
                        children: [
                          Text("\$1000",style: TextStyle(color: Color(0xfffd6f3e),fontSize: 20.0,fontWeight: FontWeight.bold),),
                          SizedBox(width: 40.0,),
                          Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(color: Color(0xfffd6f3e),borderRadius: BorderRadius.circular(5)),
                              child: Icon(Icons.add,color: Colors.white,))
                        ],)
                    ],),
                  )
                ],
              ),
            )
          ],),

      )
              );

  }
}
class CategoryTile extends StatelessWidget {
  String image,name;
  CategoryTile({required this.image,required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryProducts(category:name )));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
      
        ),
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
         Image.asset(image, height: 50,width: 50,fit: BoxFit.cover,),
          Icon(Icons.arrow_forward)
        ],),
      ),
    );
  }
}

