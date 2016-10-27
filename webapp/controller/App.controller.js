sap.ui.define([
   "sap/ui/core/mvc/Controller",
   "sap/m/MessageToast"
], function (Controller, MessageToast) {
   "use strict";
	return Controller.extend("sap.ui.odataapp.controller.App", {
		onShowHello : function () {
	        var oBundle = this.getView().getModel("i18n").getResourceBundle();
	        var sMsg = oBundle.getText("helloMsg");
			MessageToast.show(sMsg);
    	}
	});
});