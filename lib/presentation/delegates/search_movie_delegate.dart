import 'package:flutter/material.dart';

class SearchMovieDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [const Text('BuildActions')];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const Text('Buildleading');
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('BuildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text('BuildSeuggestions');
  }
}
