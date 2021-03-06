//
//  MASSessionSharingDelegate.h
//  MASFoundation
//
//  Copyright (c) 2016 CA, Inc.
//
//  This software may be modified and distributed under the terms
//  of the MIT license. See the LICENSE file for details.
//

@import Foundation;

#import "MASConstants.h"



/**
 *  The enumerated MASBLEServiceState that can indicate what is current status of Device BLE
 */
typedef NS_ENUM(NSInteger, MASBLEServiceState) {
    /**
     *  Unknown
     */
    MASBLEServiceStateUnknonw = -1,
    /**
     *  BLE Central started
     */
    MASBLEServiceStateCentralStarted,
    /**
     *  BLE Central stopped
     */
    MASBLEServiceStateCentralStopped,
    /**
     *  BLE Central a device detected
     */
    MASBLEServiceStateCentralDeviceDetected,
    /**
     *  BLE Central a device connected
     */
    MASBLEServiceStateCentralDeviceConnected,
    /**
     *  BLE Central a device disconnected
     */
    MASBLEServiceStateCentralDeviceDisconnected,
    /**
     *  BLE Central service discovered
     */
    MASBLEServiceStateCentralServiceDiscovered,
    /**
     *  BLE Central characteristic discovered
     */
    MASBLEServiceStateCentralCharacteristicDiscovered,
    /**
     *  BLE Central characteristic written
     */
    MASBLEServiceStateCentralCharacteristicWritten,
    /**
     *  BLE Central authorization succeeded
     */
    MASBLEServiceStateCentralAuthorizationSucceeded,
    /**
     *  BLE Central authorization failed
     */
    MASBLEServiceStateCentralAuthorizationFailed,
    /**
     *  BLE Peripheral subscribed
     */
    MASBLEServiceStatePeripheralSubscribed,
    /**
     *  BLE Peripheral unsubscribed
     */
    MASBLEServiceStatePeripheralUnsubscribed,
    /**
     *  BLE Peripheral started
     */
    MASBLEServiceStatePeripheralStarted,
    /**
     *  BLE Peripheral stopped
     */
    MASBLEServiceStatePeripheralStopped,
    /**
     *  BLE Peripheral session authorized
     */
    MASBLEServiceStatePeripheralSessionAuthorized,
    /**
     *  BLE Peripheral session notified
     */
    MASBLEServiceStatePeripheralSessionNotified
};


@protocol MASSessionSharingDelegate <NSObject>


@required

/**
 *  SDK callback to this method for user consent to authorize session sharing.
 *
 *  @param completion MASCompletionErrorBlock returns boolean of consent state and error if there is any
 *  @param deviceName NSString of device name
 */
- (void)handleBLESessionSharingUserConsent:(MASCompletionErrorBlock)completion deviceName:(NSString *)deviceName;



@optional



/**
 *  Notify the host application that the authorization code has been received from other device.
 *  Alternatively, developers can subscribe notification, MASDeviceDidReceiveAuthorizationCodeFromSessionSharingNotification, to receive the authorization code.
 *
 *  @param authorizationCode NSString of authorization code
 */
- (void)didReceiveAuthorizationCode:(NSString *)authorizationCode;



/**
 *  Notify the host application on the state of the BLE session sharing.
 *
 *  @param state enumeration of MASBLEServiceState
 */
- (void)didReceiveBLESessionSharingStateUpdate:(MASBLEServiceState)state;



/**
 *  Notify the host application on any error occured while session sharing
 *
 *  @param error NSError of BLE session sharing error
 */
- (void)didReceiveSessionSharingError:(NSError *)error;

@end
