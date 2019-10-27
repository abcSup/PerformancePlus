const { UserProfile } = require('./userProfile');
const { ComponentDialog, DialogSet, DialogTurnStatus, ChoiceFactory, TextPrompt, ChoicePrompt, ConfirmPrompt, ChoicePromptOptions, NumberPrompt, WaterfallDialog } = require('botbuilder-dialogs');

USER_PROFILE = 'userprofile';
NAME_PROMPT = 'nameprompt';
CHOICE_PROMPT = 'choiceprompt';
CONFIRM_PROMPT = 'confirmprompt';
NUMBER_PROMPT = 'numberprompt';
WATERFALL_DIALOG = 'waterdialog'

class UserProfileDialog extends ComponentDialog {
  constructor(userState) {
    super('userProfileDialog');

    this.id = 'userprofiledialog';

    this.userProfile = userState.createProperty(USER_PROFILE);

    this.addDialog(new TextPrompt(NAME_PROMPT));
    this.addDialog(new ChoicePrompt(CHOICE_PROMPT));
    this.addDialog(new ConfirmPrompt(CONFIRM_PROMPT));
    this.addDialog(new NumberPrompt(NUMBER_PROMPT, this.agePromptValidator));

    this.addDialog(new WaterfallDialog(WATERFALL_DIALOG, [
      this.transportStep.bind(this),
      this.nameStep.bind(this),
      this.nameConfirmStep.bind(this),
      this.ageStep.bind(this),
      this.confirmStep.bind(this),
      this.summaryStep.bind(this)
    ]));

    this.initialDialogId = WATERFALL_DIALOG;
  }

  async transportStep(step) {
    var choices = ChoiceFactory.toChoices(['Bicycle', 'Walk', 'Car']);
    return await step.prompt(CHOICE_PROMPT, "What is your transport?", choices);
  }

  async nameStep(step) {
    step.values.transport = step.result.value;
    return await step.prompt(NAME_PROMPT, 'What is your name, human?');
  }

  async nameConfirmStep(step) {
    step.values.name = step.result;
    return await step.prompt(CONFIRM_PROMPT, 'Confirm yes or no.');
  }

  async ageStep(step) {
    if (step.result) {
      // User said "yes" so we will be prompting for the age.
      // WaterfallStep always finishes with the end of the Waterfall or with another dialog, here it is a Prompt Dialog.
      const promptOptions = { prompt: 'Please enter your age.', retryPrompt: 'The value entered must be greater than 0 and less than 150.' };

      return await step.prompt(NUMBER_PROMPT, promptOptions);
    } else {
      // User said "no" so we will skip the next step. Give -1 as the age.
      return await step.next(-1);
    }
  }

  async confirmStep(step) {
    step.values.age = step.result;
    return await step.prompt(CONFIRM_PROMPT, 'Do you want to save profile, yes or no?');
  }

  async summaryStep(step) {
    if (step.result) {
      // Get the current profile object from user state.
      const userProfile = await this.userProfile.get(step.context, new UserProfile());
      console.log(step.values.name);

      userProfile.transport = step.values.transport;
      userProfile.name = step.values.name;
      userProfile.age = step.values.age;

      let msg = `I have your mode of transport as ${ userProfile.transport } and your name as ${ userProfile.name }.`;
      if (userProfile.age !== -1) {
        msg += ` And age as ${ step.values.age }.`;
      }

      await step.context.sendActivity(msg);
    } else {
      await step.context.sendActivity('Thanks. Your profile will not be kept.');
    }

    // WaterfallStep always finishes with the end of the Waterfall or with another dialog, here it is the end.
    return await step.endDialog();
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

module.exports.UserProfileDialog = UserProfileDialog
