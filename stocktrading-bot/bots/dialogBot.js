const { ActivityHandler } = require('botbuilder');
const { TradingDialog } = require('../dialogs/tradingDialog');

DIALOG_STATE = 'dialogstate';

class DialogBot extends ActivityHandler {
  constructor(conversationState, userState) {
    super();

    this.conversationState = conversationState;
    this.dialogState = conversationState.createProperty(DIALOG_STATE);
    this.userState = userState;

    this.dialog = new TradingDialog(userState);

    this.onMessage(async (context, next) => {
      console.log('Running dialog with Message Activity.');

      // Run the Dialog with the new message Activity.
      await this.dialog.run(context, this.dialogState);

      await next();
    });

    this.onDialog(async (context, next) => {
      // Save any state changes. The load happened during the execution of the Dialog.
      await this.conversationState.saveChanges(context, false);
      await this.userState.saveChanges(context, false);
      await next();
    });

    this.onMembersAdded(async (context, next) => {
      for (const idx in context.activity.membersAdded) {
        if (context.activity.membersAdded[idx].id !== context.activity.recipient.id) {
          await context.sendActivity(`Welcome to the 'Best Trading' Bot.`);
          await context.sendActivity("Our goal is to help starters to get into stock investment by providing insights to make the right decisions. Our insights are generated using machine learning techniques and analysis of stock's past performance.")
          await context.sendActivity("Thank you for your sponsor, Goldman Sachs for providing us the dataset of fundamental stock data and key performance to accomplish this project! Type anything to get started.")
        }
      }

      // By calling next() you ensure that the next BotHandler is run.
      await next();
    });

  }
}

module.exports.DialogBot = DialogBot;
