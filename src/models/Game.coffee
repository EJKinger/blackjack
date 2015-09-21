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
    @get("playerHand").on('add', @playerScorer)
    @get('playerHand').on('stand', @playDealerHand)
    @get('dealerHand').on('stand', @endGame)

  playerScorer: =>
    #TODO
    #if player has 'natural' 21 /blackjack
      #check if dealer has natural
      #end game
    #if player busted, endgame
    if _.min(@get("playerHand").scores()) > 21
      @trigger('outcome', 'loss')

  playDealerHand: =>
    @get('dealerHand').playDealer()

  endGame: =>
    console.log('endgame sequence')
    playerScores = @get("playerHand").scores()
    dealerScores = @get("dealerHand").scores()
    # if _.min(playerScores) > 21
    #   outcome = 'loss'
    if _.min(dealerScores) > 21
      outcome = 'win'
      # ...
      #if dealerHand min > 21, render dealer loss
      #else compare hands to detirmine winner/loser
    else
      playerScore = if playerScores[1] > 21 then playerScores[0] else playerScores[1]
      dealerScore = if dealerScores[1] > 21 then dealerScores[0] else dealerScores[1]
      if dealerScore > playerScore
        outcome = "loss"
      else if playerScore > dealerScore
        outcome = "win"
      else
        outcome = "draw"
    @trigger('outcome', outcome)

    #compare scores
    #detirmine winner/loser
    #render results
    #give an option to start a new game