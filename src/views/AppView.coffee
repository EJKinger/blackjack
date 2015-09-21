class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="new-game">New Game</button>
    <div class="result"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @game.get('playerHand').hit()
    'click .stand-button': -> 
      @$('.hit-button').css("visibility", "hidden")
      @$('.stand-button').css("visibility", "hidden")
      @game.get('playerHand').stand()
    'click .new-game': ->
      @$('.player-hand-container').html("")
      @$('.dealer-hand-container').html("")
      $('.result').html("")
      @model.set("game", new Game())
      @game = @model.get "game"
      @game.on('outcome', (outcome) => @gameReset(outcome))
      @$('.player-hand-container').html new HandView(collection: @game.get 'playerHand').el
      @$('.dealer-hand-container').html new HandView(collection: @game.get 'dealerHand').el
      @$('.hit-button').css("visibility", "visible")
      @$('.stand-button').css("visibility", "visible")
      @$('.new-game').css("visibility", "hidden")

  initialize: ->
    @game = @model.get "game"
    @game.on('outcome', (outcome) => @gameReset(outcome))
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.new-game').css("visibility", "hidden")
    @$('.player-hand-container').html new HandView(collection: @game.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @game.get 'dealerHand').el

  gameReset: (outcome) ->
    console.log('game reset', outcome)
    message = "You win!" if outcome is "win"
    message = "You lost!" if outcome is "loss"
    message = "Draw" if outcome is "draw"
    # @$('.player-hand-container').find("h2").append(" — " + message)
    $('.result').append(message)
    @$('.hit-button').css("visibility", "hidden")
    @$('.stand-button').css("visibility", "hidden")
    @$('.new-game').css("visibility", "visible")
    #You + outcome
    #if win render win
    #if loss render loss
    #if draw render draw
    #insert button to reset
      #on press, reset