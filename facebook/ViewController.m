//
//  ViewController.m
//  facebook
//
//  Created by odc on 23/08/16.
//  Copyright © 2016 Haroun SMIDA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)facebookLoginAction:(id)sender {
    FBSDKLoginManager* manager = [FBSDKLoginManager new];
    if (![FBSDKAccessToken currentAccessToken]) {
        NSArray* permissions = @[@"public_profile", @"email", @"user_friends"];
        [manager logInWithReadPermissions:permissions fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (!error) {
                if ([result.grantedPermissions containsObject:@"email"]) {
                    NSLog(@"Granted all permission");
                    if ([FBSDKAccessToken currentAccessToken]) {
                        NSDictionary *param = @{@"fields" : @"email"};
                        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:param] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                            if (!error) {
                                NSLog(@"%@",result);
                                NSLog(@"Email: %@", result[@"email"]);
                            }
                        }];
                    }
                } else {
                    NSLog(@"Not granted");
                }
            }
        }];
    }
    else {
        NSDictionary *param = @{@"fields" : @"email"};
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:param] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                NSLog(@"%@",result);
                NSLog(@"Email: %@", result[@"email"]);
            }
        }];

    }

}
@end
