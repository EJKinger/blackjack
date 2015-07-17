###
List all rules of blackjack:
Hitting
1) If the player gets over 21 points, he is busted and can't hit or stand
2) If the player has an ace and is below 21 points, the ace's value is 11
3) If the player has an ace and gets to 21 points, the ace's value becomes 1


Standing
1) If the player clicks on Stand, the Dealer starts dealing cards to himself and stops whenever he gets to 17 points or more


Logic referring to the "blackjack" situation

###


class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()