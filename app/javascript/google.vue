<template>
  <div id="app">
    <div>
      <input type="text" v-model="keyword" name="" value="">
      <input type="button" v-on:click="search()" name="" value="search">
    </div>

    <div v-for='(book, index) in books' :key='index' class="item">
      <div class="item__image">
        <img v-if="book.volumeInfo.imageLinks" :src=book.volumeInfo.imageLinks.thumbnail />
      </div>
      <div class="item__text">
        <h2 class="item__title">{{book.volumeInfo.title}}</h2>
        <p class="item__authors">著者:{{book.volumeInfo.authors}}</p>
        {{book.volumeInfo.description}}
        {{book.volumeInfo.publishedDate}}
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data () {
    return {
      keyword: '',
      books: [],
      loading: true,
      errored: false
    }
  },
  methods:{
    search: function(){
      axios
      .get('https://www.googleapis.com/books/v1/volumes',{
        params:{
          q: this.keyword
        }
      })
      .then(response => {
        this.books = response.data.items
        console.log(response.data.items)
      })
      .catch(error => {
        console.log(error)
        this.errored = true
      })
      .finally(() => this.loading = false)
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}

div.item{
  background: #FFF;
  padding: 10px;
  overflow: hidden;
}

div.item__image{
  float: left;
  margin-right: 10px;
}

.item__title {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 10px;
}

.item__authors{
  font-size: 10px;
  text-align: left;
}
</style>
