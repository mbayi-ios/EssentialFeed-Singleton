# EssentialFeed-Singleton
## Solution  - 1 
<img src="https://github.com/mbayi-ios/EssentialFeed-Singleton/assets/91916741/18a81020-238b-45e0-8299-e8b38813202a" width="75%" />

- Login doesnt care about loadFeed(), loadFollowers()
- Followers doesnt care about login(), loadFeed()
- Feed doesnt care about login(), loadFollowers()

BUT we have ApiClient module being shared by the other three different modules(Login, Followers, Feed) 
ApiClient is concrete time ApiClient - there is source code dependencies. You cant move Login(module) to different context/application without bringing in

## Solution - 2
<img src="https://github.com/mbayi-ios/EssentialFeed-Singleton/assets/91916741/39437efe-caad-4914-92d2-608178908b75" width="75%">

NOTE: Care about Modular design - breaking this code into something manageable/responsible

 The solution to this problem i.e where everytime you add a method you might to break other modules is faily simple.
 1. use extension - i.e we can have generic method /execute(request)/ then every module has its own apiClient Extension with whatever method they need
