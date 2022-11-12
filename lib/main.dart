import 'package:corona_case/helper.dart';
import 'package:corona_case/modal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homepage(),
    ),
  );
}

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff52796f),
        elevation: 0,
        title: const Text("Corona case"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: CoronaCaseAPI.coronaCaseAPI.fetchCoronaCaseData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<CoronaCase>? res = snapshot.data;

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: res!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  color: const Color(0xffcad2c5),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            content: Container(
                              height: 420,
                              width: 450,
                              decoration: BoxDecoration(
                                color: Color(0xffe5e5e5),
                                  borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListView(
                                children: [
                                  const SizedBox(height: 15),
                                  Container(
                                   height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(res[index].flag),
                                        fit: BoxFit.contain
                                      )
                                    ),
                                  ),
                                  const Divider(color: Colors.black),
                                  Center(child: Text("${res[index].country}")),
                                  const Divider(color: Colors.black,),
                                  const SizedBox(height: 25,),
                                  Row(
                                    children: [
                                      const SizedBox(width: 5,),
                                      const Text("Total Case:"),
                                      const Spacer(),
                                      Text("${res[index].coronaCase}"),
                                      const SizedBox(width: 10,),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      const SizedBox(width: 5,),
                                      const Text("Active Case:"),
                                      const Spacer(),
                                      Text("${res[index].activeCase}"),
                                      const SizedBox(width: 10,),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      const SizedBox(width: 5,),
                                      const Text("Critical Case:"),
                                      const Spacer(),
                                      Text("${res[index].criticalCase}"),
                                      const SizedBox(width: 10,),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      const SizedBox(width: 5,),
                                      const Text("Total Death:"),
                                      const Spacer(),
                                      Text("${res[index].death}"),
                                      const SizedBox(width: 10,),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      const SizedBox(width: 5,),
                                      const Text("Total Recovered:"),
                                      const Spacer(),
                                      Text("${res[index].recovered}"),
                                      const SizedBox(width: 10,),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      const SizedBox(width: 5,),
                                      const Text("CasesPerOneMillion:"),
                                      const Spacer(),
                                      Text("${res[index].casesPerOneMillion}"),
                                      const SizedBox(width: 10,),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      const SizedBox(width: 5,),
                                      const Text("deathsPerOneMillion:"),
                                      const Spacer(),
                                      Text("${res[index].deathsPerOneMillion}"),
                                      const SizedBox(width: 10,),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          );
                        },
                      );
                    },
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Container(
                            height: 80,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                image: DecorationImage(
                                    image: NetworkImage(res[index].flag),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Country : ${res[index].country}",
                                overflow: TextOverflow.fade,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Continent : ${res[index].continent}"),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("Population : ${res[index].population}"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      backgroundColor: const Color(0xff52796f),
    );
  }
}
