class WebtoonModel {
  final String title, thumb, id;

  WebtoonModel.fronJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
