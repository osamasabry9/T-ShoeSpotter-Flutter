import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import '../features/Personalization/data/datasources/address_remote_data_source.dart';
import '../features/Personalization/data/datasources/address_remote_data_source_impl.dart';
import '../features/Personalization/data/datasources/personalization_remote_data_source.dart';
import '../features/Personalization/data/datasources/personalization_remote_data_source_impl.dart';
import '../features/Personalization/data/repositories/address_repository_impl.dart';
import '../features/Personalization/data/repositories/personalization_repository_impl.dart';
import '../features/Personalization/domain/repositories/address_repository.dart';
import '../features/Personalization/domain/repositories/personalization_repository.dart';
import '../features/Personalization/domain/usecases/delete_user_account_usecase.dart';
import '../features/Personalization/domain/usecases/delete_user_address_usecase.dart';
import '../features/Personalization/domain/usecases/fetch_user_address_usecase.dart';
import '../features/Personalization/domain/usecases/fetch_user_details_usecase.dart';
import '../features/Personalization/domain/usecases/logout_user_usecase.dart';
import '../features/Personalization/domain/usecases/re_authenticate_email_and_password_usecase.dart';
import '../features/Personalization/domain/usecases/save_user_address_usecase.dart';
import '../features/Personalization/domain/usecases/save_user_data_usecase.dart';
import '../features/Personalization/domain/usecases/save_user_record_in_firestore_usecase.dart';
import '../features/Personalization/domain/usecases/update_single_field_usecase.dart';
import '../features/Personalization/domain/usecases/update_user_address_usecase.dart';
import '../features/Personalization/domain/usecases/update_user_details_usecase.dart';
import '../features/Personalization/domain/usecases/upload_image_usecase.dart';
import '../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import '../features/auth/data/repository/auth_firebase_repository_impl.dart';
import '../features/auth/domain/repository/auth_firebase_repository.dart';
import '../features/auth/domain/usecases/login_user_usecase.dart';
import '../features/auth/domain/usecases/send_email_verification_usecase.dart';
import '../features/auth/domain/usecases/send_password_reset_email_usecase.dart';
import '../features/auth/domain/usecases/sign_up_user_usecase.dart';
import '../features/auth/domain/usecases/sign_with_facebook_usecase.dart';
import '../features/auth/domain/usecases/sign_with_google_usecase.dart';
import '../features/shop/data/datasources/banner_remote_data_source.dart';
import '../features/shop/data/datasources/banner_remote_data_source_impl.dart';
import '../features/shop/data/datasources/brand_remote_data_source.dart';
import '../features/shop/data/datasources/brand_remote_data_source_impl.dart';
import '../features/shop/data/datasources/category_remote_data_source.dart';
import '../features/shop/data/datasources/category_remote_data_source_impl.dart';
import '../features/shop/data/datasources/order_remote_data_source.dart';
import '../features/shop/data/datasources/order_remote_data_source_impl.dart';
import '../features/shop/data/datasources/product_remote_data_source.dart';
import '../features/shop/data/datasources/product_remote_data_source_impl.dart';
import '../features/shop/data/datasources/stripe_remote_data_source.dart';
import '../features/shop/data/datasources/stripe_remote_data_source_impl.dart';
import '../features/shop/data/repositories/banner_repository_imp.dart';
import '../features/shop/data/repositories/brand_repository_imp.dart';
import '../features/shop/data/repositories/category_repository_imp.dart';
import '../features/shop/data/repositories/ckeckout_repository_impl.dart';
import '../features/shop/data/repositories/order_repository_impl.dart';
import '../features/shop/data/repositories/product_repository_imp.dart';
import '../features/shop/domain/repositories/banner_repository.dart';
import '../features/shop/domain/repositories/brand_repository.dart';
import '../features/shop/domain/repositories/category_repository.dart';
import '../features/shop/domain/repositories/checkout_repository.dart';
import '../features/shop/domain/repositories/order_repository.dart';
import '../features/shop/domain/repositories/product_repository.dart';
import '../features/shop/domain/usecases/get_all_banners_usecase.dart';
import '../features/shop/domain/usecases/get_all_brands_usecase.dart';
import '../features/shop/domain/usecases/get_all_categories_usecase.dart';
import '../features/shop/domain/usecases/get_brand_by_id_usecase.dart';
import '../features/shop/domain/usecases/get_brand_for_category_usecase.dart';
import '../features/shop/domain/usecases/get_category_by_id_usecase.dart';
import '../features/shop/domain/usecases/get_featured_categories_usecase.dart';
import '../features/shop/domain/usecases/get_featured_products_usecase.dart';
import '../features/shop/domain/usecases/get_product_by_id_usecase.dart';
import '../features/shop/domain/usecases/get_products_by_query_usecase.dart';
import '../features/shop/domain/usecases/get_products_for_brand_usecase.dart';
import '../features/shop/domain/usecases/get_products_for_category_usecase.dart';
import '../features/shop/domain/usecases/get_sub_categories_usecase.dart';
import '../features/shop/domain/usecases/get_user_orders_usecase.dart';
import '../features/shop/domain/usecases/make_payment_usecase.dart';
import '../features/shop/domain/usecases/save_order_usecase.dart';
import '../features/shop/domain/usecases/upload_banner_usecase.dart';
import '../features/shop/domain/usecases/upload_brand_usecase.dart';
import '../features/shop/domain/usecases/upload_category_usecase.dart';
import '../features/shop/domain/usecases/upload_product_usecase.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  //    GetStorage instance
  await GetStorage.init();
  getIt.registerLazySingleton<GetStorage>(() => GetStorage());

  // --------------------------Use Cases--------------------

  //++++++++++++++++++++++++++++  Auth Use Cases +++++++++++++++++++++++++++
  getIt.registerLazySingleton(() => SignUpUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(() => LogInUserUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => SignWithGoogleUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => SignWithFacebookUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => SendEmailVerificationUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => SendPasswordResetEmailUseCase(repository: getIt.call()));

  //+++++++++++++++++++++++  Personalization Use Cases +++++++++++++++++++++++
  getIt
      .registerLazySingleton(() => LogoutUserUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => DeleteUserAccountUseCase(repository: getIt.call()));

  getIt.registerFactory<SaveUserDataUseCase>(() => SaveUserDataUseCase(
        repository: getIt.call(),
      ));

  getIt.registerLazySingleton(
      () => SaveUserRecordInFirestoreUseCase(repository: getIt.call()));

  getIt.registerLazySingleton(
      () => UploadImageUseCase(repository: getIt.call()));

  getIt.registerLazySingleton(
      () => FetchUserDetailsUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => UpdateUserDetailsUseCase(repository: getIt.call()));

  getIt.registerLazySingleton(
      () => UpdateSingleFieldUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => ReAuthenticateEmailAndPasswordUseCase(repository: getIt.call()));

  //+++++++++++++++++++++++  Category Use Cases +++++++++++++++++++++++

  getIt.registerLazySingleton(
      () => GetAllCategoriesUseCase(repository: getIt.call()));

  getIt.registerLazySingleton(
      () => GetFeaturedCategoriesUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => GetCategoryByIdUseCase(repository: getIt.call()));

  getIt.registerLazySingleton(
      () => GetSubCategoriesUseCase(repository: getIt.call()));

  getIt.registerLazySingleton(
      () => UploadCategoryUseCase(repository: getIt.call()));

  //+++++++++++++++++++++++  Banners Use Cases +++++++++++++++++++++++

  getIt.registerLazySingleton(
      () => GetAllBannersUseCase(repository: getIt.call()));

  getIt.registerLazySingleton(
      () => UploadBannerUseCase(repository: getIt.call()));

  //+++++++++++++++++++++++  Brands Use Cases +++++++++++++++++++++++

  getIt.registerLazySingleton(
      () => GetAllBrandsUseCase(repository: getIt.call()));

  getIt.registerLazySingleton(
      () => GetBrandByIdUseCase(repository: getIt.call()));

  getIt.registerLazySingleton(
      () => UploadBrandUseCase(repository: getIt.call()));

  getIt.registerLazySingleton(
      () => GetBrandForCategoryUseCase(repository: getIt.call()));

  //+++++++++++++++++++++++  Product Use Cases +++++++++++++++++++++++

  getIt.registerLazySingleton(
      () => GetProductsByQueryUseCase(repository: getIt.call()));

  getIt.registerLazySingleton(
      () => GetFeaturedProductsUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => GetProductByIdUseCase(repository: getIt.call()));

  getIt.registerLazySingleton(
      () => UploadProductUseCase(repository: getIt.call()));

  getIt.registerLazySingleton(
      () => GetProductsForBrandUseCase(repository: getIt.call()));

  getIt.registerLazySingleton(
      () => GetProductsForCategoryUseCase(repository: getIt.call()));

  //+++++++++++++++++++++++  Address Use Cases +++++++++++++++++++++++

  getIt.registerLazySingleton(
      () => FetchUserAddressUseCase(addressRepository: getIt.call()));

  getIt.registerLazySingleton(
      () => SaveUserAddressUseCase(addressRepository: getIt.call()));
  getIt.registerLazySingleton(
      () => DeleteUserAddressUseCase(addressRepository: getIt.call()));

  getIt.registerLazySingleton(
      () => UpdateUserAddressUseCase(addressRepository: getIt.call()));

  //+++++++++++++++++++++++  Order Use Cases +++++++++++++++++++++++

  getIt.registerLazySingleton(
      () => GetUserOrdersUseCase(orderRepository: getIt.call()));

  getIt.registerLazySingleton(
      () => SaveOrderUseCase(orderRepository: getIt.call()));
  //+++++++++++++++++++++++  Checkout Use Cases +++++++++++++++++++++++

  getIt.registerLazySingleton(
      () => MakePaymentUseCase(checkoutRepository: getIt.call()));
  // -----------------------------Repository-----------------------
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(userRemoteDataSource: getIt.call()),
  );

  getIt.registerLazySingleton<PersonalizationRepository>(
    () => PersonalizationRepositoryImpl(
        personalizationRemoteDataSource: getIt.call()),
  );

  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(categoryRemoteDataSource: getIt.call()),
  );
  getIt.registerLazySingleton<BannerRepository>(
      () => BannerRepositoryImpl(bannerRemoteDataSource: getIt.call()));

  getIt.registerLazySingleton<BrandRepository>(
      () => BrandRepositoryImpl(brandRemoteDataSource: getIt.call()));

  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(productRemoteDataSource: getIt.call()),
  );

  getIt.registerLazySingleton<AddressRepository>(
    () => AddressRepositoryImpl(addressRemoteDataSource: getIt.call()),
  );

  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(orderRemoteDataSource: getIt.call()),
  );
  getIt.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepositoryImpl(stripeRemoteDataSource: getIt.call()),
  );
  // -------------------------------- Remote Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
            firebaseFirestore: getIt.call(),
            firebaseAuth: getIt.call(),
            firebaseStorage: getIt.call(),
          ));

  getIt.registerLazySingleton<PersonalizationRemoteDataSource>(
      () => PersonalizationRemoteDataSourceImpl(
            firebaseFirestore: getIt.call(),
            firebaseAuth: getIt.call(),
            firebaseStorage: getIt.call(),
          ));

  getIt.registerLazySingleton<AddressRemoteDataSource>(
      () => AddressRemoteDataSourceImpl(
            firebaseFirestore: getIt.call(),
            firebaseAuth: getIt.call(),
            firebaseStorage: getIt.call(),
          ));

  getIt.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(
            firebaseFirestore: getIt.call(),
            firebaseAuth: getIt.call(),
            firebaseStorage: getIt.call(),
          ));

  getIt.registerLazySingleton<OrderRemoteDataSource>(() =>
      OrderRemoteDataSourceImpl(
          firebaseFirestore: getIt.call(), firebaseAuth: getIt.call()));
  getIt.registerLazySingleton<BannerRemoteDataSource>(
      () => BannerRemoteDataSourceImpl(firebaseFirestore: getIt.call()));

  getIt.registerLazySingleton<BrandRemoteDataSource>(
      () => BrandRemoteDataSourceImpl(firebaseFirestore: getIt.call()));

  getIt.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(firebaseFirestore: getIt.call()));

  getIt.registerLazySingleton<StripeRemoteDataSource>(
      () => StripeRemoteDataSourceImpl());
  //--------------------------- Externals-----------------------------------

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;

  getIt.registerLazySingleton(() => firebaseFirestore);
  getIt.registerLazySingleton(() => firebaseAuth);
  getIt.registerLazySingleton(() => firebaseStorage);
}
