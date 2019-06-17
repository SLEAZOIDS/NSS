<template>
  <div id="app">
    <div>
      <input type="text" v-model="keyword" name="" value="">
      <input type="button" v-on:click="search()" name="" value="search">
    </div>

    <div v-for='(book, index) in books' :key='index' class="item">
      <div class="item__image">
        <img v-if="book.Item.largeImageUrl" :src=book.Item.largeImageUrl />
      </div>
      <div class="item__text">
        <h2 class="item__title">{{book.Item.title}}</h2>
        <p class="item__authors">著者:{{book.Item.author}}</p>
        {{book.Item.salesDate}}
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
      .get('https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?format=json',
      {
        params:{
          title: this.keyword, 
          applicationId: process.env.VUE_APP_RAKUTEN_APPLICATION_ID
        }
      })
      .then(response => {
        this.books = response.data.Items
        console.log(JSON.stringify(response.data.Items,null,'\t'))
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
