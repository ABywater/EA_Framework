//+------------------------------------------------------------------+
//|                                               ConfInd_WA-Exp.mq4 |
//|                                               Alekzander Bywater |
//|                                     https://github.com/BarneyB94 |
//+------------------------------------------------------------------+

// Next line assumes this file is located in .../Frameworks/Extensions/someFolder 
#include	"../../Framework.mqh"

class CBaselineIndALMAATR : public CIndicatorBase {

private:

protected:	// member variables
	// ALMA+ATR inputs
	int     mPrice;
	int     mWindowSize;
	double  mSigma;
	double  mOffset;
	double  mNegAdd;
	double  mPctFilter;
	int     mShift;
	bool    mAtrBand;
	int     mColorMode;
	int     mColorBarBack;
	int     mAlertMode;
	int     mWarningMode;
	bool    mAlertsPushNotif;

public:	// constructors

	//	Add any required constructor arguments
	//	e.g. CIndicatorXYZ(int periods, double multiplier)
	CBaselineIndALMAATR(int Price, int WindowSize, double Sigma, double Offset, double NegAdd, double PctFilter, int Shift, bool AtrBand, int ColorMode, int ColorBarBack, int AlertMode, int WarningMode, bool AlertsPushNotif)
								:	CIndicatorBase()
								{	Init();	}
	// Same constructor with symbol and timeframe added
	CBaselineIndALMAATR(string symbol, ENUM_TIMEFRAMES timeframe, 
							int Price, int WindowSize, double Sigma, double Offset, double NegAdd, double PctFilter, int Shift, bool AtrBand, int ColorMode, int ColorBarBack, int AlertMode, int WarningMode, bool AlertsPushNotif)
								:	CIndicatorBase(symbol, timeframe)
								{	Init();	}
	~CBaselineIndALMAATR();

	//	Include all arguments to match the constructor
	virtual int			Init(int Price, int WindowSize, double Sigma, double Offset, double NegAdd, double PctFilter, int Shift, bool AtrBand, int ColorMode, int ColorBarBack, int AlertMode, int WarningMode, bool AlertsPushNotif);

public:

	//	Add this line to override the same function from the parent class
   virtual double GetData(const int buffer_num,const int index);

};

CBaselineIndALMAATR::~CBaselineIndALMAATR() {

	//	Any destructors here
	
}

int		CBaselineIndALMAATR::Init(int Price, int WindowSize, double Sigma, double Offset, double NegAdd, double PctFilter, int Shift, bool AtrBand, int ColorMode, int ColorBarBack, int AlertMode, int WarningMode, bool AlertsPushNotif) {

	//	Checks if init has been set to fail by any parent class already
	if (InitResult()!=INIT_SUCCEEDED)	return(InitResult());

	mPrice           = Price;
	mWindowSize      = WindowSize;
	mSigma           = Sigma;
	mOffset          = Offset;
	mNegAdd          = NegAdd;
	mPctFilter       = PctFilter;
	mShift           = Shift;
	mAtrBand         = AtrBand;
	mColorMode       = ColorMode;
	mColorBarBack    = ColorBarBack;
	mAlertMode       = AlertMode;
	mWarningMode     = WarningMode;
	mAlertsPushNotif = AlertsPushNotif;
	//	Assign variables and do any other initialisation here
	return(INIT_SUCCEEDED);
	
}
	
double	CBaselineIndALMAATR::GetData(const int buffer_num,const int index) {

	double	value	=	0;
	//	value	=	iMA(mSymbol, mTimeframe, mPeriods, mShift, mMethod, mAppliedPrice, index);
	value = iCustom(_Symbol, _Period, "//NNFX ShortTerm//NNFX LowTF//ALMA_v2.1_ATR_Bands", mPrice, 
                                                                                           mWindowSize, 
                                                                                           mSigma, 
                                                                                           mOffset, 
                                                                                           mNegAdd, 
                                                                                           mPctFilter, 
                                                                                           mShift, 
                                                                                           mAtrBand, 
                                                                                           mColorMode, 
                                                                                           mColorBarBack, 
                                                                                           mAlertMode, 
                                                                                           mWarningMode, 
                                                                                           mAlertsPushNotif, buffer_num, index);
	return(value);
	
}


