# 🫧 Bubbles Selection


> **Note**
>  This is an experimental release.
<br>

### Add 😍 not-so boring 🫧 bubbles selection to your app.



https://user-images.githubusercontent.com/65209850/188316726-583cc23f-f706-4298-ad92-1d7da26b62d6.mp4






## ✨ Features

* Fully customizable bubbles
* Fully customizable bubble text
* Interactive bubbles with collision system 
* Flexible API
* Fun to interact with

<br>
## 🚀 Getting started

You can add bubble selection like this, 

```DART
BubbleSelection(
            bubbles: [
              Bubble(
                text: "Gaming🎮",
                activeColor: Colors.red,
                inactiveColor: Colors.blue,
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.yellow,
                ),
              ),
              Bubble(
                text: "Food🍔",
                activeColor: Colors.red,
                inactiveColor: Colors.orange,
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
            selectedBubbles: selectedBubbles,
            size: const Size(
              900,
              300,
            ),
            onSelect: (bubble) {
              //  logic on bubble selection
            },
            onRemoved: (bubble) {
              //  logic when bubble is un-selected
            },
          )
```

<!-- ## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
``` -->
<br>
## 📝 TODO

* Improve positioning of bubbles initially to avoid any possible overlapping between bubbles
* Additional constraints to avoid bubbles whose sizes might be larger than the size of the bubbles selection box
* Api imrpovements around letting user know of selected and un-selected bubbles

<br>
<br>

> **Warning**
> This is an experimental relase. Meaning, things may change/break more often than usual untill a stable release.

<!-- ## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
 -->
