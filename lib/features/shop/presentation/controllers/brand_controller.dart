import 'package:get/get.dart';
import '../../domain/usecases/get_brand_for_category_usecase.dart';

import '../../../../app/di.dart' as di;
import '../../../../core/repositories/firebase/app_firebase_storage_service.dart';
import '../../../../core/utils/constants/api_constants.dart';
import '../../../../core/utils/popups/loaders.dart';
import '../../data/models/brand_model.dart';
import '../../domain/entities/brand_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_all_brands_usecase.dart';
import '../../domain/usecases/get_brand_by_id_usecase.dart';
import '../../domain/usecases/get_products_for_brand_usecase.dart';
import '../../domain/usecases/upload_brand_usecase.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();
  final isLoading = false.obs;
  RxList<BrandEntity> allBrands = <BrandEntity>[].obs;
  RxList<BrandEntity> featuredBrands = <BrandEntity>[].obs;
  Rx<BrandEntity?> selectedBrand = Rx<BrandEntity?>(null);

  @override
  void onInit() {
    fetchBrands();
    super.onInit();
  }

  // Fetch brands
  Future<void> fetchBrands() async {
    try {
      // show loading while fetching brands
      isLoading.value = true;

      // fetch brands from data source
      final brands = await di.getIt<GetAllBrandsUseCase>().call();

      // Update the Brands List
      allBrands.assignAll(brands);

      // filter featured brands
      featuredBrands
          .assignAll(brands.where((brand) => brand.isFeatured!).take(4));
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // remove loading
      isLoading.value = false;
    }
  }

  Future<void> getBrandById(String id) async {
    try {
      // show loading while fetching brands
      isLoading.value = true;

      // fetch brands from data source
      final brand = await di.getIt<GetBrandByIdUseCase>().call(id: id);

      // Update the Brands List
      selectedBrand(brand);
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // remove loading
      isLoading.value = false;
    }
  }

// Get Brand for category
  Future<List<BrandEntity>> getBrandsByCategoryId(String id) async {
    try {
      final brands =
          await di.getIt<GetBrandForCategoryUseCase>().call(categoryId: id);

      return brands;
    } catch (e) {
      AppLoaders.errorSnackBar(
          title: 'Oh Snap! when getting brands by category',
          message: e.toString());
      return [];
    }
  }

// Get products by brand id
  Future<List<ProductEntity>> getProductsByBrandId(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await di
          .getIt<GetProductsForBrandUseCase>()
          .call(brandId: brandId, limit: limit);

      return products;
    } catch (e) {
      AppLoaders.errorSnackBar(
          title: 'Oh Snap! when getting products by brand',
          message: e.toString());
      return [];
    }
  }

  /// Upload Brands to the cloud firestore
  Future<void> uploadDummyDataBrands(List<BrandModel> brands) async {
    try {
      // Upload all the Brands along with their Images
      final storage = Get.put(AppFirebaseStorageService());

// loop through all the Brands
      for (var brand in brands) {
        // Get image data link from the local assets
        final imageUrl = await storage.getImageDataFromAssets(brand.image);

        // Upload image to the cloud storage
        final imageUrlUploaded = await storage.uploadImageData(
            FirebaseConst.PATH_IMAGE_BRAND_COLLECTION, imageUrl, brand.image);

        // Assign URL to category name attribute
        brand.image = imageUrlUploaded;

        // store category in the firestore
        await di.getIt<UploadBrandUseCase>().call(brand: brand);
      }
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
