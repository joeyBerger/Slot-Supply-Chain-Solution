App = {
    web3Provider: null,
    contracts: {},
    emptyAddress: "0x0000000000000000000000000000000000000000",
    sku: 0,
    upc: 0,
    metamaskAccountID: "0x0000000000000000000000000000000000000000",
    ownerID: "0x0000000000000000000000000000000000000000",
    originSlotTitleID: "0x0000000000000000000000000000000000000000",
    originGameStudioID: null,
    originGameStudioInformation: null,
    originGameStudioAddress: null,
    originGameStudioEmailContact: null,
    productNotes: null,
    productPrice: 0,
    slotManufacturerID: "0x0000000000000000000000000000000000000000",
    regulatoryID: "0x0000000000000000000000000000000000000000",
    casinoID: "0x0000000000000000000000000000000000000000",

    init: async function () {
        App.readForm();
        /// Setup access to blockchain
        return await App.initWeb3();
    },

    readForm: function () {
        App.sku = $("#sku").val();
        App.upcFetch = $("#upcFetch").val();
        App.upc = $("#upc").val();
        App.ownerID = $("#ownerID").val();
        App.originSlotTitleID = $("#originSlotTitleID").val();
        App.originGameStudioID = $("#originGameStudioID").val();
        App.originGameStudioInformation = $("#originGameStudioInformation").val();
        App.originGameStudioAddress = $("#originGameStudioAddress").val();
        App.originGameStudioEmailContact = $("#originGameStudioEmailContact").val();
        App.productNotes = $("#productNotes").val();
        App.productPrice = $("#productPrice").val();
        App.slotManufacturerID = $("#slotManufacturerID").val();
        App.regulatoryID = $("#regulatoryID").val();
        App.casinoID = $("#casinoID").val();
        App.casinoPrice = $("#casinoPrice").val();
        console.log(
            App.sku,
            App.upcFetch,
            App.upc,
            App.ownerID, 
            App.originSlotTitleID, 
            App.originGameStudioID, 
            App.originGameStudioInformation, 
            App.originGameStudioAddress, 
            App.originGameStudioEmailContact, 
            App.productNotes, 
            App.productPrice, 
            App.slotManufacturerID, 
            App.regulatoryID, 
            App.casinoID,
            App.casinoPrice
        );
    },

    initWeb3: async function () {
        /// Find or Inject Web3 Provider
        /// Modern dapp browsers...
        if (window.ethereum) {
            App.web3Provider = window.ethereum;
            try {
                // Request account access
                await window.ethereum.enable();
            } catch (error) {
                // User denied account access...
                console.error("User denied account access")
            }
        }
        // Legacy dapp browsers...
        else if (window.web3) {
            App.web3Provider = window.web3.currentProvider;
        }
        // If no injected web3 instance is detected, fall back to Ganache
        else {
            App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
        }

        App.getMetaskAccountID();

        return App.initSupplyChain();
    },

    getMetaskAccountID: function () {
        web3 = new Web3(App.web3Provider);

        // Retrieving accounts
        web3.eth.getAccounts(function(err, res) {
            if (err) {
                console.log('Error:',err);
                return;
            }
            console.log('getMetaskID:',res);
            App.metamaskAccountID = res[0];

        })
    },

    initSupplyChain: function () {
        /// Source the truffle compiled smart contracts
        // var jsonSupplyChain='sc/build/contracts/SupplyChain.json';
        var jsonSupplyChain='build/contracts/SupplyChain.json';
        
        /// JSONfy the smart contracts
        $.getJSON(jsonSupplyChain, function(data) {
            console.log('data',data);
            var SupplyChainArtifact = data;
            App.contracts.SupplyChain = TruffleContract(SupplyChainArtifact);
            App.contracts.SupplyChain.setProvider(App.web3Provider);
            
            App.fetchItemBufferOne();
            App.fetchItemBufferTwo();
            App.fetchEvents();

        });

        return App.bindEvents();
    },

    bindEvents: function() {
        $(document).on('click', App.handleButtonClick);
    },

    handleButtonClick: async function(event) {
        event.preventDefault();

        App.getMetaskAccountID();

        var processId = parseInt($(event.target).data('id'));
        console.log('processId',processId);

        switch(processId) {
            case 1:
                return await App.designMath(event);
                break;
            case 2:
                return await App.designArt(event);
                break;
            case 3:
                return await App.designAnim(event);
                break;
            case 4:
                return await App.designAudio(event);
                break;
            case 5:
                return await App.conductPrelimTesting(event);
                break;
            case 6:
                return await App.sellItem(event);
                break;
            case 7:
                return await App.buyItem(event);
                break;
            case 8:
                return await App.conductQA(event);
                break;
            case 9:
                return await App.releaseForReg(event);
                break;
            case 10:
                return await App.enterRegulatory(event);
                break;
            case 11:
                return await App.exitRegulatory(event);
                break;
            case 12:
                return await App.releaseForMarketing(event);
                break;
            case 13:
                return await App.exitMarketing(event);
                break;
            case 14:
                return await App.moveForRelease(event);
                break;
            case 15:
                return await App.purchaseItem(event);
                break;
            case 16:
                return await App.installGame(event);
                break;
            case 17:
                return await App.fetchItemBufferOne(event);
                break;
            case 18:
                return await App.fetchItemBufferTwo(event);
                break;
            }
    },

    designMath: function(event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));
        App.readForm();
        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.designMath(
                App.upc, 
                App.metamaskAccountID, 
                App.originGameStudioID, 
                App.originGameStudioInformation, 
                App.originGameStudioAddress, 
                App.originGameStudioEmailContact, 
                App.productNotes
            );
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('designMath',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    designArt: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.designArt(App.upc, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('designArt',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    designAnim: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.designAnim(App.upc, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('designAnim',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    designAudio: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.designAudio(App.upc, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('designAudio',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    conductPrelimTesting: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.conductPrelimTesting(App.upc, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('conductPrelimTesting',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    sellItem: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            const productPrice = web3.toWei(App.productPrice, "ether");
            console.log('productPrice',productPrice);
            return instance.sellItem(App.upc, productPrice, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('sellItem',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    buyItem: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            const walletValue = web3.toWei(3, "ether");
            return instance.buyItem(App.upc, {from: App.metamaskAccountID, value: walletValue});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('buyItem',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },
    
    conductQA: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.conductQA(App.upc, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('conductQA',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    releaseForReg: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.releaseForReg(App.upc, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('releaseForReg',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    enterRegulatory: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.enterRegulatory(App.upc, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('enterRegulatory',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    exitRegulatory: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.exitRegulatory(App.upc, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('exitRegulatory',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    releaseForMarketing: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.releaseForMarketing(App.upc, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('releaseForMarketing',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    exitMarketing: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.exitMarketing(App.upc, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('exitMarketing',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    moveForRelease: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));
        console.log("App.casinoPrice",App.casinoPrice);
        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.moveForRelease(App.upc, App.casinoPrice,{from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('moveForRelease',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    purchaseItem: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.purchaseItem(App.upc, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('purchaseItem',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    installGame: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.installGame(App.upc, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('installGame',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    fetchItemBufferOne: function () {
    ///   event.preventDefault();
    ///    var processId = parseInt($(event.target).data('id'));
        App.upcFetch = $('#upcFetch').val();
        console.log('upc',App.upc);

        App.contracts.SupplyChain.deployed().then(function(instance) {
          return instance.fetchItemBufferOne(App.upcFetch);
        }).then(function(result) {
          $("#ftc-item").text(result);
          console.log('fetchItemBufferOne', result);
        }).catch(function(err) {
          console.log(err.message);
        });
    },

    fetchItemBufferTwo: function () {
    ///    event.preventDefault();
    ///    var processId = parseInt($(event.target).data('id'));
        App.upcFetch = $('#upcFetch').val();
        console.log('upc',App.upc);           
        App.contracts.SupplyChain.deployed().then(function(instance) {
          return instance.fetchItemBufferTwo.call(App.upcFetch);
        }).then(function(result) {
          $("#ftc-item").text(result);
          console.log('fetchItemBufferTwo', result);
        }).catch(function(err) {
          console.log(err.message);
        });
    },

    fetchEvents: function () {
        if (typeof App.contracts.SupplyChain.currentProvider.sendAsync !== "function") {
            App.contracts.SupplyChain.currentProvider.sendAsync = function () {
                return App.contracts.SupplyChain.currentProvider.send.apply(
                App.contracts.SupplyChain.currentProvider,
                    arguments
              );
            };
        }

        App.contracts.SupplyChain.deployed().then(function(instance) {
        var events = instance.allEvents(function(err, log){
          if (!err)
            $("#ftc-events").append('<li>' + log.event + ' - ' + log.transactionHash + '</li>');
        });
        }).catch(function(err) {
          console.log(err.message);
        });
        
    }
};

$(function () {
    $(window).load(function () {
        App.init();
    });
});