import { LitElement, customElement, property, html, css } from 'lit-element'

export interface MyComponentData {
  key: number
  name: string
}

declare global {
  interface DocumentEventMap {
    'my-component-click': CustomEvent<MyComponentData>
  }

  interface HTMLElementTagNameMap {
    'my-component': MyComponentElement
  }
}

@customElement('my-component')
export class MyComponentElement extends LitElement {
  @property({ type: Boolean, reflect: true }) selected: boolean = false
  @property({ type: Number }) key: number = 0
  @property({ type: String }) name: string = 'CaptainCodeman'

  onButtonClick(e: Event) {
    const evt = new CustomEvent('my-component-click', {
      bubbles: true,
      composed: true,
      detail: {
        key: this.key,
        name: this.name,
      }
    })
    this.dispatchEvent(evt)
  }

  render() {
    return html`
      <p>Hello from ${this.name}</p>
      <button @click=${this.onButtonClick}>Select</button>
    `
  }

  static get styles() {
    return css`
      :host {
        display: block;
        padding: 10px;
        border: 1px solid #999;
        border-radius: 6px;
      }

      :host([selected]) {
        background-color: #f0fff0;
        border-color: #339933;
      }
    `
  }
}