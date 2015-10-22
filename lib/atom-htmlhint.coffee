AtomHtmlhintView = require './atom-htmlhint-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomHtmlhint =
  atomHtmlhintView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomHtmlhintView = new AtomHtmlhintView(state.atomHtmlhintViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomHtmlhintView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-htmlhint:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomHtmlhintView.destroy()

  serialize: ->
    atomHtmlhintViewState: @atomHtmlhintView.serialize()

  toggle: ->
    console.log 'AtomHtmlhint was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
