import Foundation
import Paywall

@objc(Superwall)
class Superwall: RCTEventEmitter {

    public static var emitter: RCTEventEmitter!

      override init() {
        super.init()
        Superwall.emitter = self
      }

      open override func supportedEvents() -> [String] {
        ["superwallAnalyticsEvent"]
      }


    @objc(initPaywall:revenueCatApiKey:appUserID:)
    func initPaywall(superwallApiKey:String, revenueCatApiKey:String, appUserID:String) -> Void {
        PaywallService.initPaywall(superwallApiKey: superwallApiKey, revenueCatApiKey: revenueCatApiKey, appUserID: appUserID)
    }


    @objc(trigger:resolver:rejecter:)
    func trigger(campaignName:String, resolver: @escaping RCTPromiseResolveBlock,  rejecter: @escaping RCTPromiseRejectBlock) -> Void {
        Paywall.trigger(
          event: campaignName,
          params: nil,
          onSkip: { error in
            rejecter("error", error?.description, nil)
          },
          onPresent: nil,
          onDismiss: { didPurchase, productId, paywallInfo in
              if didPurchase {
                  resolver(["didPurchase": true, "productId": productId])
              } else {
                resolver(["didPurchase": false, "productId": nil])
              }
            }
        )
    }

    @objc
    func reset() -> Void {
        PaywallService.reset();
    }

    @objc(identify:)
    func identify(appUserID:String) -> Void {
        PaywallService.identify(appUserID: appUserID);
    }

}
