import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-superwall' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const Superwall = Platform.select({
  ios: NativeModules.Superwall
  ? NativeModules.Superwall
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    ),
  android: {},
});

export function initPaywall(apiKey: string, revenueCatKey: string | null, appUserID: string | null) {
  return Superwall.initPaywall(apiKey, revenueCatKey, appUserID);
}

export function trigger(campaignName: string) {
  return Superwall.trigger(campaignName);
}

export function test(campaignName: string) {
  return Superwall.testTrigger(campaignName);
}

export function reset() {
  return Superwall.reset();
}

export function identify(appUserID: string) {
  return Superwall.identify(appUserID);
}

export function setUserAttributes(userAttributes: { [key: string]: any }) {
  return Superwall.setUserAttributes(userAttributes);
}
