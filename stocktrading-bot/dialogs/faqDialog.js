const { ComponentDialog, DialogSet, DialogTurnStatus, ChoiceFactory, TextPrompt, ChoicePrompt, ConfirmPrompt, ChoicePromptOptions, NumberPrompt, WaterfallDialog } = require('botbuilder-dialogs');
const { QnAMaker } = require('botbuilder-ai');

FAQWATERFLALL = 'faqWaterfall';
QUEST_PROMPT = 'questionPrompt';

class FaqDialog extends ComponentDialog {
  constructor() {
    super('faqDialog');

    this.addDialog(new TextPrompt(QUEST_PROMPT));
    this.addDialog(new ConfirmPrompt(CONFIRM_PROMPT));

    this.qnaMaker = new QnAMaker({
      knowledgeBaseId: process.env.QnAKnowledgebaseId,
      endpointKey: process.env.QnAAuthKey,
      host: process.env.QnAEndpointHostName
    });

    this.addDialog(new WaterfallDialog(FAQWATERFLALL, [
      this.askStep.bind(this),
      this.answerStep.bind(this),
      this.loopStep.bind(this),
    ]));

    this.initialDialogId = FAQWATERFLALL;
  }

  async askStep(step) {
    return await step.prompt(QUEST_PROMPT, 'What question do you have?');
  }

  async answerStep(step) {
    const qnaResults = await this.qnaMaker.getAnswers(step.context);
    if (qnaResults[0]) {
      await step.context.sendActivity(qnaResults[0].answer);
    } else {
      await step.context.sendActivity('No QnA Maker answers were found.');
    }
    return await step.prompt(CONFIRM_PROMPT, "Do you still want to continue?");
  }

  async loopStep(step) {
    if (step.result) {
      return step.replaceDialog(FAQWATERFLALL);
    }
    return step.endDialog();
  }
}

module.exports.FaqDialog = FaqDialog

