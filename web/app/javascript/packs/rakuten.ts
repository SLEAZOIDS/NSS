import Vue from 'vue'
import Rakuten from '../rakuten.vue'

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('rakuten'))
  const app = new Vue({
    el,
    render: h => h(Rakuten),
  })
  console.log(app)
})