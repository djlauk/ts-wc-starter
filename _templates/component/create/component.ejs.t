---
to: src/<%= tag %>.ts
---
<%
  className = h.changeCase.pascal(tag) + 'Element'
  dataClass = h.changeCase.pascal(tag) + 'Data'
  eventName = tag + '-click'
-%>
import {
  LitElement,
  customElement,
  property,
  html,
  css,
  CSSResultArray,
  CSSResult,
  TemplateResult,
} from 'lit-element'

export interface <%= dataClass %> {
  key: number
  name: string
}

declare global {
  interface DocumentEventMap {
    '<%= eventName %>': CustomEvent<<%= dataClass %>>
  }

  interface HTMLElementTagNameMap {
    '<%= tag %>': <%= className %>
  }
}

@customElement('<%= tag %>')
export class <%= className %> extends LitElement {
  @property({ type: Boolean, reflect: true })
  selected: boolean = false

  @property({ type: Number })
  key: number = 0

  @property({ type: String })
  name: string = 'nobody'

  onButtonClick(): void {
    const evt = new CustomEvent<<%= dataClass %>>('<%= eventName %>', {
      bubbles: true,
      composed: true,
      detail: {
        key: this.key,
        name: this.name,
      },
    })
    this.dispatchEvent(evt)
  }

  render(): TemplateResult {
    return html`
      <p>Hello from ${this.name}</p>
      <button @click=${this.onButtonClick}>send event</button>
    `
  }

  static get styles(): CSSResultArray {
    return [
      css`
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
      `,
    ]
  }
}
