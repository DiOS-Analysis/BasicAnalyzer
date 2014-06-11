@interface NSTask : NSObject {
}

@property(copy) id terminationHandler;

+ (id)allocWithZone:(id)arg1;
+ (id)currentTaskDictionary;
+ (id)launchedTaskWithDictionary:(id)arg1;
+ (id)launchedTaskWithLaunchPath:(id)arg1 arguments:(id)arg2;

- (id)arguments;
- (id)currentDirectoryPath;
- (id)environment;
- (id)init;
- (void)interrupt;
- (BOOL)isRunning;
- (void)launch;
- (id)launchPath;
- (int)processIdentifier;
- (BOOL)resume;
- (void)setArguments:(id)arg1;
- (void)setCurrentDirectoryPath:(id)arg1;
- (void)setEnvironment:(id)arg1;
- (void)setLaunchPath:(id)arg1;
- (void)setStandardError:(id)arg1;
- (void)setStandardInput:(id)arg1;
- (void)setStandardOutput:(id)arg1;
- (void)setTerminationHandler:(id)arg1;
- (id)standardError;
- (id)standardInput;
- (id)standardOutput;
- (BOOL)suspend;
- (int)suspendCount;
- (void)terminate;
- (id)terminationHandler;
- (int)terminationReason;
- (int)terminationStatus;

@end