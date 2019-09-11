import { MyComponentElement } from './my-component'

describe('my-component', function () {
  let el: MyComponentElement

  beforeEach(async function() {
    el = document.createElement('my-component')
    el.style.display = 'none'
    document.body.appendChild(el)
    await el.updateComplete
  })

  afterEach(function() {
    document.body.removeChild(el)
  })

  it('should create instance', function () {
    const el = document.createElement('my-component')
    chai.expect(el).to.be.instanceof(MyComponentElement)
  })

  it('should raise event when button clicked', async function () {
    let clicked = false
    el.addEventListener('my-component-click', _ => clicked = true)
    const button = el.shadowRoot.querySelector('button')
    button.dispatchEvent(new Event('click'))
    chai.expect(clicked).to.be.true
  })

  it('should contain current name in event', async function () {
    el.name = 'Whoever'
    await el.updateComplete
    let name = ''
    el.addEventListener('my-component-click', (e: CustomEvent<string>) => name = e.detail)
    const button = el.shadowRoot.querySelector('button')
    button.dispatchEvent(new Event('click'))
    chai.expect(name).to.equal('Whoever')
  })

  it('should render default name', async function () {
    const text = el.shadowRoot.querySelector('p').textContent.trim()
    chai.expect(text).to.equal('Hello from CaptainCodeman')
  })

  it('should render new name when set', async function () {
    el.name = 'Someone Else'
    await el.updateComplete
    const text = el.shadowRoot.querySelector('p').textContent.trim()
    chai.expect(text).to.equal('Hello from Someone Else')
  })
})