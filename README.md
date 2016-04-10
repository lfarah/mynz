# MYNZ
Mynz is an Augmented Reality game where you drop virtual mines in the real world and explode your Friends. **100% Open source, 100% Swift** :large_orange_diamond:

![minepin](https://cloud.githubusercontent.com/assets/6511079/14408938/ea4d36ee-febc-11e5-99ef-42c8db7dadda.png)

# Goal
Your goal is to win points by **deploying traps** and exploding your friends

# Rules

- Everybody gets 10 mines per day. **Use it wisely**
- You can only get exploded one time per minutes, so if you just got exploded, you're immune for the next **60 seconds**

# Contributing
- Wanna contribute? **Awesome!** Start by our [Issues page](https://github.com/lfarah/mynz/issues) to see what we wanna see in the next version.
- Something wrong? We're definitely not perfect, so [create an issue here](https://github.com/lfarah/mynz/issues) and we'll do our best to fix it as quick as possible :smile:

## CocoaPods
We're using CocoaPods on our project, so if you wanna run our Xcode project, be sure to open your **Terminal** and run the folowing lines:
``` ruby
gem install cocoapods
```
and then:
``` ruby
pod install
```

## SwiftLint
We're also using [Swiftlint](https://github.com/realm/SwiftLint) to ensure our code is always the neatest and Swiftiest possible, so if you don't have it installed yet, run the following lines
``` ruby
brew install swiftlint
```
and then:
``` ruby
swiftlint lint
```

## Networking
Traps are downloaded on the following circumstances: 
- When app launches: ```didFinishLaunchingWithOptions()```
- When app goes to background: ```applicationDidEnterBackground()```
- When app becomes active again: ```applicationDidBecomeActive()```
- When user is exploded by a trap: ```explodeCheck()```
