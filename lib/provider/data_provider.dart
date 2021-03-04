import 'package:flutter/cupertino.dart';
import 'package:flutter_listview_infinite_scrolling/models/data_model.dart';
import '../api_service.dart';

enum LoadMoreStatus { LOADING, STABLE }

class DataProvider with ChangeNotifier {
  APIService _apiService;
  LoadDataPagination _dataFetcher;
  int totalPages = 0;

  List<Product> get allUsers =>
      _dataFetcher.data == null ? null : _dataFetcher.data.products;
  double get totalRecords => _dataFetcher.data.total.toDouble();

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;

  DataProvider() {
    _initStreams();
  }

  void _initStreams() {
    _apiService = APIService();
    _dataFetcher = LoadDataPagination();
  }

  void resetStreams() {
    _initStreams();
  }

  fetchAllUsers(pageNumber) async {
    if (totalPages == 0  || pageNumber <= _dataFetcher.data.lastPage) {


      LoadDataPagination itemModel = await _apiService.getData(pageNumber);

      if (_dataFetcher.data == null) {
        //  totalPages =  ((itemModel.data.lastPage - 1) / pageSize).ceil();
        _dataFetcher = itemModel;
      } else {
        _dataFetcher.data.products.addAll(itemModel.data.products);
        _dataFetcher = _dataFetcher;

        // One load more is done will make it status as stable.
        setLoadingState(LoadMoreStatus.STABLE);
      }

      notifyListeners();
    }

    if (pageNumber > _dataFetcher.data.lastPage) {
      // One load more is done will make it status as stable.
      setLoadingState(LoadMoreStatus.STABLE);
      notifyListeners();
    }
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }
}
