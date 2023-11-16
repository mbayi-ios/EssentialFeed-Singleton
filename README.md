# EssentialFeed-Singleton
## Problem - 1 
<img src="https://github.com/mbayi-ios/EssentialFeed-Singleton/assets/91916741/18a81020-238b-45e0-8299-e8b38813202a" width="50%" />

- Login doesnt care about loadFeed(), loadFollowers()
- Followers doesnt care about login(), loadFeed()
- Feed doesnt care about login(), loadFollowers()

BUT we have ApiClient module being shared by the other three different modules(Login, Followers, Feed) 
ApiClient is concrete time ApiClient - there is source code dependencies. You cant move Login(module) to different context/application without bringing in
