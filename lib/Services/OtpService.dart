import 'package:fliq_dating_app/Api/ApiRequest.dart';
import 'package:fliq_dating_app/Api/ApiResponce.dart';
import 'package:fliq_dating_app/constants/ApiConstants.dart';

class OtpService {
  ApiRequest apiRequest = ApiRequest();

  Future<ApiResponce> requestOtpApi(params) async {
    return apiRequest.apiRequest(AppUrls.RequestOtp, params);
  }

  Future<ApiResponce> verifyOtpApi(params) async {
    return apiRequest.apiRequest(AppUrls.VerifyOtp, params);
  }
}
