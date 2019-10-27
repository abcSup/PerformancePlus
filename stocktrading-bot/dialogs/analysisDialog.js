const { ComponentDialog, DialogSet, DialogTurnStatus, ChoiceFactory, TextPrompt, ChoicePrompt, ConfirmPrompt, ChoicePromptOptions, NumberPrompt, WaterfallDialog } = require('botbuilder-dialogs');
var stocks_json = require('../stocks.json');
stocks_len = stocks_json.length

const { AnalysisLoopDialog } = require('./analysisLoopDialog');

ANALYSISWATERFALL_DIALOG = 'analysisWaterfallDialog';

class AnalysisDialog extends ComponentDialog {
  constructor() {
    super('analysisDialog');
    this.firstTime = false;

    this.addDialog(new TextPrompt(TICKER_PROMPT));
    this.addDialog(new ConfirmPrompt(CONFIRM_PROMPT));

    this.loopDialog = new AnalysisLoopDialog();
    this.addDialog(this.loopDialog);

    this.addDialog(new WaterfallDialog(ANALYSISWATERFALL_DIALOG, [
      this.suggestionStep.bind(this),
      this.analysisStep.bind(this),
    ]));

    this.initialDialogId = ANALYSISWATERFALL_DIALOG;
  }

  async suggestionStep(step) {
    if (!this.firstTime) {
      this.firstTime = true;
      await step.context.sendActivity("Currently, our insights find the following stocks " + stocks_json[0]['ticker'] + " has the most potential for growth. Are you interested to take a look at our analysis?")
      return await step.prompt(CONFIRM_PROMPT);
    }

    this.firstTime = false;
    return await step.endDialog();
  }

  async analysisStep(step) {
    if (step.result) {
      var stock = stocks_json[0];
      await step.context.sendActivity(stock['ticker'] + " is currently trading at " + stock['currentPrice'] + "$");
      await step.context.sendActivity("It is outperforming total of " + 100 + "% of stocks based on the analysis");
      let weeklyChange = Math.round(stock['weeklyChange']*100)/100;
      let monthlyChange = Math.round(stock['monthlyChange']*100)/100;
      await step.context.sendActivity("7D Change: " + weeklyChange + ". 30D Change: " + monthlyChange + "%");
    }
    return await step.beginDialog('analysisLoopDialog');
  }
}

module.exports.AnalysisDialog = AnalysisDialog
