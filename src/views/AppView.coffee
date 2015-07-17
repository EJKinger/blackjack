class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @game.get('playerHand').hit()
    'click .stand-button': -> @game.get('playerHand').stand()

  initialize: ->
    @game = @model.get "game"
    @render()


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @game.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @game.get 'dealerHand').el

