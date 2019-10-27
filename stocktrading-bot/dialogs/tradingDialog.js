const { ComponentDialog, DialogSet, DialogTurnStatus, ChoiceFactory, TextPrompt, ChoicePrompt, ConfirmPrompt, ChoicePromptOptions, NumberPrompt, WaterfallDialog } = require('botbuilder-dialogs');

const { UserProfile } = require('./userProfile');
const { AnalysisDialog } = require('./analysisDialog');
const { FaqDialog } = require('./faqDialog');

USER_PROFILE = 'userprofile';
TICKER_PROMPT = 'tickerprompt';
CHOICE_PROMPT = 'choiceprompt';
CONFIRM_PROMPT = 'confirmprompt';
WATERFALL_DIALOG = 'waterdialog'

class TradingDialog extends ComponentDialog {
  constructor(userState) {
    super('tradingDialog');

    this.userProfile = userState.createProperty(USER_PROFILE);

    this.addDialog(new TextPrompt(TICKER_PROMPT));
    this.addDialog(new ConfirmPrompt(CONFIRM_PROMPT));
    this.addDialog(new ChoicePrompt(CHOICE_PROMPT));

    this.analysisDialog = new AnalysisDialog();
    this.addDialog(this.analysisDialog);
    this.faqDialog = new FaqDialog();
    this.addDialog(this.faqDialog);

    this.addDialog(new WaterfallDialog(WATERFALL_DIALOG, [
      this.pathStep.bind(this),
      this.branchStep.bind(this),
      this.loopStep.bind(this),
    ]));

    this.initialDialogId = WATERFALL_DIALOG;
  }

  async pathStep(step) {
    var choices = ChoiceFactory.toChoices(['Analysis', 'FAQ', 'Nothing']);
    return await step.prompt(CHOICE_PROMPT, "What can I do for you today?", choices);
  }

  async branchStep(step) {
    const branch = step.result.value;
    if (branch == 'Analysis') {
      return await step.beginDialog('analysisDialog');
    }
    else if (branch == 'FAQ') {
      return await step.beginDialog('faqDialog');
    }
    step.context.sendActivity('Thank you for using the best trading bot. Happy Hackathon!');
    return await step.endDialog();
  }

  async loopStep(step) {
    return step.replaceDialog(WATERFALL_DIALOG);
  }

  async run(turnContext, accessor) {
    const dialogSet = new DialogSet(accessor);
    dialogSet.add(this);

    const dialogContext = await dialogSet.createContext(turnContext);
    const results = await dialogContext.continueDialog();
    if (results.status === DialogTurnStatus.empty) {
      await dialogContext.beginDialog(this.id);
    }
  }
}

module.exports.TradingDialog = TradingDialog
