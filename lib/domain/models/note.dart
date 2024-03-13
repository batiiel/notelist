class Note {
  int? id;
  String? title;
  String? text;
  //DateTime? time;

  Note({this.id, this.title, this.text});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      text: json['text'],
      //time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "text": text,
      //"time": time,
    };
  }
}
