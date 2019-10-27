const { ComponentDialog, DialogSet, DialogTurnStatus, ChoiceFactory, TextPrompt, ChoicePrompt, ConfirmPrompt, ChoicePromptOptions, NumberPrompt, WaterfallDialog } = require('botbuilder-dialogs');
var stocks_json = require('../stocks.json');
stocks_len = stocks_json.length

LOOPWATERFALL_DIALOG = 'loopWaterfallDialog';

class AnalysisLoopDialog extends ComponentDialog {
  constructor() {
    super('analysisLoopDialog');

    this.addDialog(new TextPrompt(TICKER_PROMPT));
    this.addDialog(new ConfirmPrompt(CONFIRM_PROMPT));

    this.addDialog(new WaterfallDialog(LOOPWATERFALL_DIALOG, [
      this.askTickerStep.bind(this),
      this.analyzeStep.bind(this),
      this.loopStep.bind(this),
    ]));

    this.initialDialogId = LOOPWATERFALL_DIALOG;
  }

  async askTickerStep(step) {
    return await step.prompt(TICKER_PROMPT, 'Which stock do you want to know more about? Type the ticker of the stocks as follows: TSLA');
  }

  async analyzeStep(step) {
    for(var i in stocks_json){
      if (stocks_json[i]['ticker'] == step.result.toUpperCase()) {
        var stock = stocks_json[i]
        await step.context.sendActivity(stock['ticker'] + " is currently trading at " + stock['currentPrice'] + "$");
        let percentage = Math.round((stocks_len-i)/stocks_len*10000)/100
        await step.context.sendActivity("It is outperforming total of " + percentage + "% of stocks based on the analysis");
        let weeklyChange = Math.round(stock['weeklyChange']*100)/100;
        let monthlyChange = Math.round(stock['monthlyChange']*100)/100;
        await step.context.sendActivity("7D Change: " + weeklyChange + ". 30D Change: " + monthlyChange + "%");
        return await step.prompt(CONFIRM_PROMPT, 'Do you still have other stocks in mind that you want to know more about?');
      }
    }
    await step.context.sendActivity("Cannot find the following stock with ticker: " + step.result)
    return await step.prompt(CONFIRM_PROMPT, 'Do you still have other stocks in mind that you want to know more about?');
    // Currently the stock is trading at value
    // The change is 5%
    // Based on the integral factor it performs 60% better than other stock
    // Here are some graphs on history prices
  }

  async loopStep(step) {
    if (step.result) {
      return await step.replaceDialog(this.id, { restartMsg: 'Do you still have other stocks in mind that you want to know more about?' });
    } else {
      return await step.endDialog('tradingDialog');
    }
  }
}

module.exports.AnalysisLoopDialog = AnalysisLoopDialog
