import 'package:flutter/material.dart';
import 'package:random_people_data/helpers.dart';

import 'modal.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String API = "https://randomuser.me/api/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff264653),
      appBar: AppBar(
        title: const Text('Random People Data'),
        centerTitle: true,
        backgroundColor: const Color(0xff264653),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                API = "https://randomuser.me/api/";
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: RandomDataAPIHelper.randomDataAPIHelper
            .fetchSingelRandomData(API: API),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error : ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            Random? data = snapshot.data;

            return Center(
              child: Container(
                height: 450,
                width: 330,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xfff1faee),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black45, blurRadius: 4, spreadRadius: 2,)
                    ]),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      height: 120,
                      width: 120,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black,width: 1.5),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(data!.image),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text('${data.title} ${data.fName} ${data.lName}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        const Icon(Icons.person_outline_outlined,size: 25,),
                        const SizedBox(width: 17),
                        Text(data.gender,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        const Icon(Icons.account_circle_outlined,size: 25,),
                        const SizedBox(width: 17),
                        Text('${data.age}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        const Icon(Icons.email_outlined,size: 25,),
                        const SizedBox(width: 17),
                        Text(data.email,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        const Icon(Icons.call,size: 25,),
                        const SizedBox(width: 17),
                        Text(data.call,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        const Icon(Icons.home,size: 25,),
                        const SizedBox(width: 17),
                        Text('${data.sNumber}, ${data.sName}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        const Icon(Icons.location_on_sharp,size: 25,),
                        const SizedBox(width: 17),
                        Text('${data.state}, ${data.country}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)
                      ],
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
