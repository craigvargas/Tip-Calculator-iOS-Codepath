# Pre-work - Tipster

Tipster is a tip calculator application for iOS.

Submitted by: Craig Vargas

Time spent: 24 hours spent in total

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [ ] UI animations
* [ ] Remembering the bill amount across app restarts (if <10mins)
* [X] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [X] Decorated UI with different layout and color scheme
- [X] Used a slider for the tip adjustment rather than a segmented control; Allows for more tip optoins.
- [X] Used a UIPicker for settings page to give the user a different way to select a tip
- [X] Used Autolayout to accomodate different sized screens
- [X] Only implemented first responder code for the Text field to work when the app initially starts. I thought that after the user changes the default settings they have likely already played around with the tip slider; which means they have likely already entered their bill into the app, so it is not straight forward that they want to change the bill when they return from the settings screen. 

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Challenges:
1. Getting used to the iOS documentation
2. iOS example code on the web is often written in Objective C rather than swift
3. Autolayout is really challenging for people new to layout constraints

## License

    Copyright [2016] [Craig Vargas]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
