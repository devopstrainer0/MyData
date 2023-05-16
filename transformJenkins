def call(Map params = [:]) {
    println params
    println "*********************************************"
    println "Name: ${params.name}"
    println "Number: ${params.number}"
   
    for (def itr in params.inputScan.keySet()) {
        def cList = []
        def bList = []
        def branch = ''
        println "Key: ${itr}"
        def count = 0
        for (def value in params.inputScan.get(itr)) {
            if (count == 0) {
                println "The count is 0!"
                println "Value: ${value}"
               cList = value.replaceAll(/\[|\]|"/, '').split(',')
                println "cList: ${cList}"
                count++
            } else if (count == 1 ){
                println "The count is 1!"
                println "Value: ${value}"
                bList = value.replaceAll(/\[|\]|"/, '').split(',')
                println "bList: ${bList}"
                count++
            } else {
            	println "The count is 2!"
                println "Value: ${value}"
                params.branch = value
                println "branch: ${branch}"	
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
