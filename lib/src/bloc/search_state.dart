part of 'search_bloc.dart';

enum SearchStatus { initial, standby, searching, continuing }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.canContinue = false,
    this.lastSearchTerm = '',
    this.offset = 0,
    this.results = const <Search>[],
    this.articles = const <int, Article>{},
    this.history = const <Article>[]
  });

  final SearchStatus status;
  final bool canContinue;
  final String lastSearchTerm;
  final int offset;
  final List<Search> results;
  final Map<int, Article> articles;
  final List<Article> history;

  SearchState copyWith({
    SearchStatus? status,
      String? language,
      bool? canContinue,
      String? lastSearchTerm,
      int? limit,
      int? offset,
      List<Search>? results,
      Map<int, Article>? articles,
      List<Article>? history
  }) {
    return SearchState(
        status: status ?? this.status,
        canContinue: canContinue ?? this.canContinue,
        lastSearchTerm: lastSearchTerm ?? this.lastSearchTerm,
        offset: offset ?? this.offset,
        results: results ?? this.results,
        articles: articles ?? this.articles,
        history: history ?? this.history
    );
  }

  SearchState newSearch(bool canContinue, String lastSearchTerm, int offset, List<Search> newResults, Map<int, Article> newArticles) {
    return copyWith(
        status: SearchStatus.standby,
        canContinue: canContinue,
        lastSearchTerm: lastSearchTerm,
        offset: offset,
        results: newResults,
        articles: newArticles
        );
  }

  SearchState continueSearch(bool canContinue, int offset, List<Search> newResults, Map<int, Article> newArticles) {
    return copyWith(
        status: SearchStatus.standby,
        canContinue: canContinue,
        lastSearchTerm: lastSearchTerm,
        offset: offset,
        results: results..addAll(newResults),
        articles: articles..addAll(newArticles)
    );
  }

  @override
  List<Object?> get props => [status, canContinue, lastSearchTerm, offset, results, articles, history];

  bool isInitial() => (status == SearchStatus.initial);
  bool isStandby() => (status == SearchStatus.standby);
  bool isSearching() => (status == SearchStatus.searching);
  bool isContinuing() => (status == SearchStatus.continuing);

  Article getArticle(int pageID) {
    if (articles.containsKey(pageID)) return articles[pageID]!;
    return Article();
  }
}