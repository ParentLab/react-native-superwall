#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(Superwall, RCTEventEmitter)

RCT_EXTERN_METHOD(initPaywall:(NSString)superwallApiKey revenueCatApiKey:(NSString)revenueCatApiKey appUserID:(NSString)appUserID)

RCT_EXTERN_METHOD(trigger:(NSString)campaignName resolver: (RCTPromiseResolveBlock)resolve rejecter: (RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
