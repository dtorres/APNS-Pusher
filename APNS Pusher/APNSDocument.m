//
//  APNSDocument.m
//  APNS Pusher
//
//  Created by Simon Blommegard on 14/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

#import "APNSDocument.h"
#import "APNSViewController.h"
#import "APNSItem.h"

@interface APNSDocument ()
@property (nonatomic, strong) APNSItem *item;
@end

@implementation APNSDocument

- (instancetype)initWithType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
  if (self = [super initWithType:typeName error:outError]) {
    _payload = @"{\n\t\"aps\":{\n\t\t\"alert\":\"Test\",\n\t\t\"sound\":\"default\",\n\t\t\"badge\":0\n\t}\n}";
  }
  return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    // Add your subclass-specific initialization here.
    }
    return self;
}

+ (BOOL)autosavesInPlace {
  return YES;
}

- (void)makeWindowControllers {
  // Override to return the Storyboard file name of the document.
  NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
  NSWindowController *windowController = [storyboard instantiateControllerWithIdentifier:@"Document Window Controller"];
  [self addWindowController:windowController];
  
  APNSViewController *viewController = (APNSViewController *)windowController.contentViewController;
  viewController.windowController = windowController;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.item];
  
  if (!data) {
    *outError = [NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:nil];
    return nil;
  }
  
  return data;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
  self.item = [NSKeyedUnarchiver unarchiveObjectWithData:data];
  
  if (!self.item) {
    *outError = [NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:nil];
    return NO;
  }
  
  return YES;
}

- (void)setPayload:(NSString *)payload {
  [[self.undoManager prepareWithInvocationTarget:self] setPayload:self.payload];
  
  _payload = payload;
}


@end