# FPSTool
>用来查看页面的FPS工具,如果你不想引入Pod也可以直接复制（FPSTool）到你的工程中，如果模块化建议使用Pod
可拖动: 以防止挡住页面以及视线

>pod 

```
pod 'FPSTool'
```

# 使用方式
```
[FPSTool sharedInstall]
```

# AppDelegate中

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
![示例图](https://github.com/farmerly/FPSTool/blob/master/zz.gif "示例图")
