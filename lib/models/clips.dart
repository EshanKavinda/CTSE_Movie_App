class VideoClip {
  final String description;
  final String thumbName;
  final String title;
  final String parent;
  final int runtime;

  //constructor
  VideoClip(this.title, this.description, this.runtime, this.thumbName, this.parent);

  //video path method
  String videoPath() {
    return "$parent";
  }

  //thumb path method
  String thumbPath() {
    return "$thumbName";
  }

  // ignore: non_constant_identifier_names
  static List<VideoClip> Clips18_28 = [
    VideoClip("Movie 1", "Category 1 ", 0, "images/movie_icon.png", "https://www.googleapis.com/drive/v3/files/1M2TZDyJv7qyDd7HeRxiqYx8nOGHdN66H?alt=media&key=AIzaSyBN_y5s3dJjYBnawgYKLOalBLbV9y0cS7s"),
    VideoClip("Movie 2", "Category 2", 0, "images/movie_icon.png", "https://www.googleapis.com/drive/v3/files/1YBwQX64N87SNX_gnjWT0x1QAPQLnyKuV?alt=media&key=AIzaSyBN_y5s3dJjYBnawgYKLOalBLbV9y0cS7s"),
    VideoClip("Movie 3", "Category 3", 0, "images/movie_icon.png", "https://www.googleapis.com/drive/v3/files/1mWP4hchab-qmlAf4k-gMbAQvYycHwJr6?alt=media&key=AIzaSyBN_y5s3dJjYBnawgYKLOalBLbV9y0cS7s"),
    VideoClip("Movie 4", "Category 4", 0, "images/movie_icon.png", "https://www.googleapis.com/drive/v3/files/1mWP4hchab-qmlAf4k-gMbAQvYycHwJr6?alt=media&key=AIzaSyBN_y5s3dJjYBnawgYKLOalBLbV9y0cS7s"),
    VideoClip("Movie 5", "Category 5", 0, "images/movie_icon.png", "https://www.googleapis.com/drive/v3/files/1x9LmqCnfVPyHz64DQqPNGgCVFlRUAJ45?alt=media&key=AIzaSyBN_y5s3dJjYBnawgYKLOalBLbV9y0cS7s"),
  ];


}

