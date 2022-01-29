import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimart_grocery/models/category.dart';
import 'package:minimart_grocery/models/pagination.dart';
import 'package:minimart_grocery/services/api_service.dart';

final categoriesProvider= FutureProvider.family<List<Category>?,PaginationModel>(
    (ref,paginationModel){
      final apiRepository= ref.watch(apiService);
      return apiRepository.getCategories(paginationModel.page,paginationModel.pageSize);
    },
);