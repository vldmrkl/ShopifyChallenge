# Matchify 🃏🤖📱
Matchify is an iOS memory card matching game I developed as part of Shopify mobile developer challenge (iOS) for a winter 2020 internship.
The rules of the game are pretty straight-forward:
1) 20 cards are laid face down in a random order.
2) You turn any of two cards.
3) If the two cards are the same, you found a pair!
4) If the two cards are different, you have to turn them back.
5) The objective of the game is to find all pairs.

### Youtube demo
[Link](https://youtu.be/ZpfQ_ZKMUYE)

### Screenshots
<p align="center">
  <img src="https://i.imgur.com/2yzDceQ.png" height="500" title="hover text">
  <img src="https://i.imgur.com/1070BVS.png" height="500" title="hover text">
  <img src="https://i.imgur.com/rhp8qnu.png" height="500" title="hover text">
</p>

### Customization
Users can increase the number of cards in one set (i.e. you can search for 4 or 5 matching images), which makes the game more difficult. It can be done by visiting the "Settings" screen and changing the value of slider.
<p align="center">
  <img src="https://i.imgur.com/CeEITH2.png" height="500" title="hover text">
  <img src="https://i.imgur.com/nw5nts0.png" height="500" title="hover text">
</p>

### Tech stack
The app is built with Swift and UIKit. Also, as per requirements of the challenge, I had to use the [Shopify API endpoint](https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6) to get images for my cards.
