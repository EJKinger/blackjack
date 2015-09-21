class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  stand: ->
    @trigger("stand", @)
    #trigger event
      #if its the player
        #render "Busted", you lose
      #if its the dealer
        #render "you win"

  playDealer: (shouldFlip=true)->
    #flip hidden card (first card in dealers hand) .flip()
    if shouldFlip
      @at(0).flip()
    setTimeout( =>
      console.log(@scores())
      if _.min(@scores()) < 17 and (_.max(@scores()) < 17 or _.max(@scores()) > 21)  #or if the max score < 21 and > 17
          @hit()
          @playDealer(false)
      else
        @stand()
    , 500)


    # while hitAgain
    #   console.log("hitAgain", hitAgain)
    #   if _.min(@scores()) < 17
    #     setTimeout(@hit.bind(@), 200)
    #   else
    #     hitAgain = false

    #if score < 17 
      #hit
    #else trigger stand, which will check scores (in game model) and detirmine winner and end the game (somehow)