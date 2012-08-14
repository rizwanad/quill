#= require mocha
#= require chai
#= require range
#= require jquery
#= require underscore

describe('Editor', ->
  describe('deleteAt', ->
    reset = ->
      $('#editor-container').html('<div class="line"><b>123</b><i>456</i></div><div class="line"><s>7</s><u>8</u><s>9</s><u>0</u></div><div class="line"><b>abcdefg</b></div>')
      return new Tandem.Editor('editor-container')

    it('should delete a node', ->
      editor = reset()
      editor.deleteAt(0, 3)
      expect(editor.iframeDoc.body.firstChild.textContent).to.equal('456')
      expect(editor.iframeDoc.body.childNodes.length).to.equal(3)
    )

    _.each([0..2], (i) ->
      it('should delete part of a node ' + i, ->
        editor = reset()
        editor.deleteAt(i, 1)
        expect(editor.iframeDoc.body.firstChild.textContent).to.equal('123456'.substr(0, i) + '123456'.substr(i + 1))
        expect(editor.iframeDoc.body.childNodes.length).to.equal(3)
      )
    )

    it('should delete multiple nodes', ->
      editor = reset()
      editor.deleteAt(0, 6)
      expect(editor.iframeDoc.body.firstChild.textContent).to.equal('')
      expect(editor.iframeDoc.body.childNodes.length).to.equal(3)
    )

    _.each([0..2], (i) ->
      it('should delete across multiple nodes ' + i, ->
        charsToDelete = 4
        editor = reset()
        editor.deleteAt(i, charsToDelete)
        expect(editor.iframeDoc.body.firstChild.textContent).to.equal('123456'.substr(0, i) + '123456'.substr(i + charsToDelete))
        expect(editor.iframeDoc.body.childNodes.length).to.equal(3)
      )
    )

    it('should delete exactly one line', ->
      editor = reset()
      editor.deleteAt(0, 7)
      expect(editor.iframeDoc.body.firstChild.textContent).to.equal('7890')
      expect(editor.iframeDoc.body.childNodes.length).to.equal(2)
    )

    _.each([2..4], (i) ->
      it('should delete across multiple lines ' + i, ->
        charsToDelete = 6
        editor = reset()
        editor.deleteAt(i, charsToDelete)
        expect(editor.iframeDoc.body.firstChild.textContent).to.equal('1234567890'.substr(0, i) + '1234567890'.substr(i + charsToDelete - 1))
        expect(editor.iframeDoc.body.childNodes.length).to.equal(2)
      )
    )

    it('should delete a newline character', ->
      editor = reset()
      editor.deleteAt(6, 1)
      expect(editor.iframeDoc.body.childNodes.length).to.equal(2)
    )

    it('should delete entire line and more', ->
      editor = reset()
      editor.deleteAt(5, 8)
      expect(editor.iframeDoc.body.childNodes.length).to.equal(1)
    )
  )
)


