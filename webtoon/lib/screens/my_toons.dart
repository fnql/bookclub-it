import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/webtoon_detail_model.dart';
import '../services/api_service.dart';

class MyToons extends StatefulWidget {
  const MyToons({super.key});

  @override
  State<MyToons> createState() => _MyToonsState();
}

class _MyToonsState extends State<MyToons> {
  late List<Future<WebtoonDetailModel>> webtoons = [];
  late SharedPreferences prefs;
  late Future<List<String>?> likedToons;

  @override
  void initState() {
    super.initState();
    // likedToons = initPrefs();
    initPrefs();
  }

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      print(likedToons[0]);
      for (int k = 1; k < likedToons.length; k++) {
        webtoons.add(ApiService.getToonById(likedToons[k]));
      }
    } else {
      await prefs.setStringList('likedToons', []);
    }
    setState(() {});
  }
  // 776255

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('좋아하는 웹툰'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < webtoons.length; i++)
              FutureBuilder(
                future: webtoons[i],
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 7,
                                    offset: const Offset(10, 10),
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                              child: Image.network(snapshot.data!.thumb),
                            ),
                          ],
                        ),
                        Text(
                          snapshot.data!.title,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                }),
              ),
          ],
        ),
      ),
    );
  }
}
