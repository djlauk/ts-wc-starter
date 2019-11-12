---
to: src/<%= tag %>.spec.ts
---
<%
  className = h.changeCase.pascal(tag) + 'Element'
  dataClass = h.changeCase.pascal(tag) + 'Data'
  eventName = tag + '-click'
-%>
import { <%= className %>, <%= dataClass %> } from './<%= tag %>'

describe('<%= tag %>', function() {
  let el: <%= className %>

  beforeEach(async function() {
    el = document.createElement('<%= tag %>')
    el.style.display = 'none'
    document.body.appendChild(el)
    await el.updateComplete
  })

  afterEach(function() {
    document.body.removeChild(el)
  })

  it('should create instance', function() {
    const el = document.createElement('<%= tag %>')
    chai.expect(el).to.be.instanceof(<%= className %>)
  })

  it('should raise event when button clicked', async function() {
    let clicked = false
    el.addEventListener('<%= eventName %>', () => {
      clicked = true
    })
    const button = el.shadowRoot.querySelector('button')
    button.dispatchEvent(new Event('click'))
    chai.expect(clicked).to.be.true
  })

  it('should contain current name and key in event', async function() {
    el.name = 'Whoever'
    el.key = 123
    await el.updateComplete
    let detail = {}
    el.addEventListener('<%= eventName %>', (e: CustomEvent<<%= dataClass %>>) => {
      detail = e.detail
    })
    const button = el.shadowRoot.querySelector('button')
    button.dispatchEvent(new Event('click'))
    chai.expect(detail).to.deep.equal({ name: 'Whoever', key: 123 })
  })

  it('should render default name', async function() {
    const text = el.shadowRoot.querySelector('p').textContent.trim()
    chai.expect(text).to.equal('Hello from nobody')
  })

  it('should render new name when set', async function() {
    el.name = 'Someone Else'
    await el.updateComplete
    const text = el.shadowRoot.querySelector('p').textContent.trim()
    chai.expect(text).to.equal('Hello from Someone Else')
  })
})
