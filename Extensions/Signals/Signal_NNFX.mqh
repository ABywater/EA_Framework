//+------------------------------------------------------------------+
//|                                                  Signal_NNFX.mqh |
//|                                               Alekzander Bywater |
//|                                         https://wwwdocs.mql4.com |
//+------------------------------------------------------------------+

#include	"../../Framework.mqh"

class CSignal_NNFX : public CSignalBase {

private:

protected: // Member variables
	int mIndex;

public: // Constructors/Destructors
	CSignal_NNFX(int index=1)
					: CSignalBase()
					{ Init(index); } 	
	CSignal_NNFX(string symbol, ENUM_TIMEFRAMES timeframe,
					int index=1)
					: CSignalBase(symbol, timeframe)
					{ Init(index); }
	~CSignal_NNFX() { }

	int Init(int index);

public:
	virtual void UpdateSignal();

};

int CSignal_NNFX::Init(int index) {
	if (InitResult()!=INIT_SUCCEEDED) return(InitResult() );

	mIndex      = index;

	return(INIT_SUCCEEDED);
}

void CSignal_NNFX::UpdateSignal() {
	double price = 0;
//--- ALMA line
  double baseline = iCustom(_Symbol, _Period, "//NNFX ShortTerm//NNFX LowTF//ALMA_v2.1_ATR_Bands", 0, 1);
//--- ATR Upper Band
  double atrHighBand = iCustom(_Symbol, _Period, "//NNFX ShortTerm//NNFX LowTF//ALMA_v2.1_ATR_Bands", 5, 1);
//--- ATR Lower Band
  double atrLowBand = iCustom(_Symbol, _Period, "//NNFX ShortTerm//NNFX LowTF//ALMA_v2.1_ATR_Bands", 6, 1);
//--- Trend green
  double primary1 = iCustom(_Symbol, _Period, "//NNFX ShortTerm//NNFX LowTF//TrendStrengthInd", 1, 1);
//--- Trend red
  double primary2 = iCustom(_Symbol, _Period, "//NNFX ShortTerm//NNFX LowTF//TrendStrengthInd", 2, 1);
//--- Explosion line
  double secondary1 = iCustom(_Symbol, _Period, "//NNFX ShortTerm//NNFX LowTF//Waddah_Attar_Explosion", 2, 1);
//--- Explosion green
  double secondary2 = iCustom(_Symbol, _Period, "//NNFX ShortTerm//NNFX LowTF//Waddah_Attar_Explosion", 0, 1);
//--- Explosion red
  double secondary3 = iCustom(_Symbol, _Period, "//NNFX ShortTerm//NNFX LowTF//Waddah_Attar_Explosion", 1, 1);

  if(Bid > baseline && Bid < atrHighBand && Bid > atrLowBand && primary1 > 0 && secondary2 > secondary1) {
  mEntrySignal = NWN_SIGNAL_BUY;
  mExitSignal = NWN_SIGNAL_SELL;
  } else
  if(Ask < baseline && Ask < atrHighBand && Ask > atrLowBand && primary2 > 0 && secondary3 > secondary1) {
  mEntrySignal = NWN_SIGNAL_SELL;
  mExitSignal = NWN_SIGNAL_BUY;
  } else {
  mEntrySignal = NWN_SIGNAL_NONE;
  mExitSignal = NWN_SIGNAL_NONE;
  }
    return;
}
   