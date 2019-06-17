import Vue from 'vue'
import Google from '../google.vue'

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('google'))
  const app = new Vue({
    el,  
    render: h => h(Google),
  })

  console.log(app)
})