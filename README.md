# 🐻 Flutter Login: Interactive Rive Animation

This project features a high-quality, interactive login interface built with **Flutter**, centered around a dynamic **Rive** animation that responds to user input in real-time.

---

## 📘 Academic Information
* **Subject:** [Login with Rive animation]
* **Professor:** [Rodrigo Fidel Gaxiola Sosa]
* **Student:** [Ramiro German Arcila Gamboa]

---

## 🚀 Key Functionalities
* **State-Driven Interactions:** The character (Teddy) performs specific actions based on the "Focus" of the text fields.
* **Input Tracking:** As the user types their email, the character's eyes follow the cursor movement across the screen.
* **Privacy Mode:** When the user clicks the password field, the character covers its eyes to simulate privacy.
* **Success/Fail Logic:** The animation triggers a "Success" reaction upon correct login or a "Fail/Shaking" animation if the credentials are incorrect.
* **Clean UI/UX:** A modern and minimalist aesthetic designed for mobile performance.

## 🎨 About Rive and State Machine
* **What is Rive?**
Rive is a real-time interactive design and animation tool that allows for the creation of functional vector graphics. Unlike traditional video or GIF formats, Rive files are tiny, fully scalable, and can be manipulated by code in real-time without losing quality.

* **The Power of the State Machine:**
The **State Machine** is the brain of the Rive animation. It consists of a set of logic gates and inputs (Booleans, Triggers, or Numbers) that we control via Flutter. 
  * **Inputs used in this project:** * `isChecking`: Boolean to trigger the "look at hands" state.
    * `isHandsUp`: Boolean to trigger the "cover eyes" state.
    * `trigSuccess / trigFail`: Triggers for final feedback.
    * `look`: Number value to coordinate the eye tracking.

## 🛠️ Technologies & Packages
* **Flutter SDK:** For the cross-platform application framework.
* **Dart:** The programming language behind the logic.
* **rive (Package):** The official library used to bridge the `.riv` assets with the Flutter controller.
* **Google Fonts:** For a clean and readable typography.

## 📂 Project Structure (lib folder)
The core logic is organized within the `lib` directory as follows:
* **`main.dart`**: The entry point that initializes the app and sets the global theme.
* **`screens/login_screen.dart`**: The main controller. It manages the `TextEditingControllers`, listens to focus nodes, and communicates with the Rive State Machine to update the bear's behavior.
* **`assets/`**: Contains `animated_login_bear.riv`, the binary file containing all the bone-based animations and state logic.

## 🎬 Demo
<div align="center">
  <img src="https://github.com/user-attachments/assets/b8b23860-d8bc-4504-9189-d1198bd387fe" width="350">
  <p><i>Interactive character tracking input and reacting to login states.</i></p>
</div>

## 👏 Credits
* **Animation Design:** [dexterc](https://rive.app/community/61-137-bear-binary-login/) via Rive Community.
* **Original Reference:** [Google Developers Blog](https://blog.google/innovation-and-ai/technology/developers-tools/build-your-next-ios-and-android-app-flutter/)
---
