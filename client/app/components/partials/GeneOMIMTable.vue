<style lang="sass" >

@import ../../../assets/sass/variables

#omim-table
  .title-row
    display: flex
    height: 25px

    .table-title
      color: $app-color
    .count
      display: inline-block
      font-size: 12px
      margin-left: 10px
      padding-top: 1px

  .omim-row
    font-size: 12px
    padding-bottom: 5px
    >span
      display: inline-block
      vertical-align: top
      line-height: 15px

    .omim-launch
      min-width: 20px
      max-width: 20px
      i.material-icons
        font-size: 13px
        color: $link-color
    .omim-phenotype
      min-width: 300px
      max-width: 300px
    .omim-inheritance
      display: inline-block
      min-width: 100px
      max-width: 100px
</style>

<style lang="css">
/* Extra small devices (phones, 600px and down) */
@media only screen and (max-width: 600px) {
.omim-phenotype {
  min-width: 150px !important;
  max-width: 150px !important;
}  
}

/* Small devices (portrait tablets and large phones, 600px and up) */
@media only screen and (min-width: 600px) {
.omim-phenotype {
  min-width: 150px !important;
  max-width: 150px !important;
}  

}

/* Medium devices (landscape tablets, 768px and up) */
@media only screen and (min-width: 768px) {
.omim-phenotype {
  min-width: 200px !important;
  max-width: 200px !important;
}  

}

/* Large devices (laptops/desktops, 992px and up) */
@media only screen and (min-width: 992px) {
.omim-phenotype {
  min-width: 200px !important;
  max-width: 200px !important;
} 
}

/* Extra large devices (large laptops and desktops, 1200px and up) */
@media only screen and (min-width: 1200px) {
.omim-phenotype {
  min-width: 200px !important;
  max-width: 200px !important;
} 
}
/* Extra large devices (large laptops and desktops, 1200px and up) */
@media only screen and (min-width: 1400px) {
.omim-phenotype {
  min-width: 300px !important;
  max-width: 300px !important;
} 
}

</style>

<template>

  <div id="omim-table" v-if="omimEntries && omimEntries.length > 0">
    <div class="title-row">
      <div class="table-title">OMIM Phenotypes</div>
    </div>
    <div style="max-height:158px;min-height:158px;overflow-y:scroll;padding-top:5px">
      <div class="omim-row" v-for="entry in omimEntries" :key="entry.phenotypeMimNumber">
          <span class="omim-launch" >
            <a :href="getEntryHref(entry.phenotypeMimNumber)" target="_omim">
              <v-icon>launch</v-icon>
            </a>
          </span>
          <span class="omim-phenotype" >{{ entry.phenotype }}
          </span>
          <span class="omim-inheritance">{{ entry.phenotypeInheritance }}</span>
      </div>
    </div>

  </div>


</template>

<script>

export default {
  name: 'gene-omim-table',
  components: {
  },
  props: {
    geneModel: null,
    selectedGene: null,
  },
  data () {
    return {
      omimEntries: []
    }
  },
  methods: {
    getOMIMEntries: function() {
      let self = this;
      self.omimEntries = [];
  
      if (self.selectedGene && Object.keys(self.selectedGene).length > 0 ) {
        self.geneModel.promiseGetOMIMEntries(self.selectedGene.gene_name)
        .then(function(data) {
          if (data && data.omimEntries) {
            self.omimEntries = data.omimEntries.map(function(entry) {
              return entry.phenotype;
            });
          }
        })
      } else {
        self.omimEntries = [];
      }

    },
    getEntryHref: function(mimNumber) {
      return "https://www.omim.org/entry/" + mimNumber;
    }
  },
  watch: {
    selectedGene: function() {
      this.getOMIMEntries();
    },
  },
  calculated: {
    
  },
  created: function() {
  },
  mounted: function() {
    let self = this;
    setTimeout(function() {
      self.getOMIMEntries();
    },2000)
  },
}
</script>

