# FPSTool
>用来查看页面的FPS工具
可拖动: 以防止挡住页面以及视线

>pod 

```
pod 'FPSTool'
```

#使用方式
```
[FPSTool sharedInstall]
```

>在AppDelegate中

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[ViewController alloc]init];
    [self.window makeKeyAndVisible];
    
    
    [FPSTool sharedInstall];
    return YES;
}
```
