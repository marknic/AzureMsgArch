param aiNameLocal string = 'mn-bicep3-ai'

module aiResource 'ai.bicep' = {
  name: 'aiResourceBicep'
  params: {
    aiName: aiNameLocal
  }

}
