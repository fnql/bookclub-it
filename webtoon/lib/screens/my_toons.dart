import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtoon/models/webtoon_model.dart';

class MyToons extends StatefulWidget {
  const MyToons({super.key});

  @override
  State<MyToons> createState() => _MyToonsState();
}

class _MyToonsState extends State<MyToons> {
  late Future<List<WebtoonModel>> webtoons;
  late SharedPreferences prefs;
  late Future<List<String>?> likedToons;

  @override
  void initState() {
    super.initState();
    likedToons = initPrefs();
    // webtoons = ApiService.getToonById(widget.id) as Future<List<WebtoonModel>>;
  }

  Future<List<String>?> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
    } else {
      await prefs.setStringList('likedToons', []);
    }
    return likedToons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('좋아하는 웹툰'),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: likedToons,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data!.first,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      snapshot.data!.first,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                );
              }
              return const Text("...");
            }),
          ),
        ],
      ),
    );
  }
}
