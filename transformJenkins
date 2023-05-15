def call(Map params = [:]) {
    def jsonSlurper = new groovy.json.JsonSlurperClassic()
    println params
    println "*********************************************"
    println "Name: ${params.name}"
    println "Number: ${params.number}"
   
    for (def itr in params.inputScan.keySet()) {
        def cList = []
        def bList = []
        println "Key: ${itr}"
        def count = 0
        for (def value in params.inputScan.get(itr)) {
            if (count == 0) {
                println "The count is 0!"
                println "Value: ${value}"
               cList = jsonSlurper.parseText(value)
                println "cList: ${cList}"
                count++
            } else {
                println "The count is 1!"
                println "Value: ${value}"
              


                bList = jsonSlurper.parseText(value)
                println "bList: ${bList}"
            }
        }
        
        if (cList.size() == bList.size()) {
            for (i = 0; i < cList.size(); i++) {
                params.compname = cList[i]
                params.buildfile = bList[i]
                params.giturl = itr
                println "Updated params: ${params}"
            }
        }
    }
    
    println "*********************************************"
    println params
}
