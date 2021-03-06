import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movie_model.dart';
import 'package:flutter_movies/src/widgets/touchable_opacity_widget.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({Key key, @required this.movies, @required this.nextPage})
      : super(key: key);

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int key) {
            return _createCard(context, movies[key]);
          }),
    );
  }

  Widget _createCard(BuildContext context, Movie movie) {
    final card = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(movie.getPosterImg()),
              placeholder: AssetImage("assets/img/no-image.jpg"),
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.22,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return TouchableOpacity(
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
      child: card,
    );
  }
}
