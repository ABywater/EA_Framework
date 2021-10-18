//+------------------------------------------------------------------+
//|                                                ConfInd_WAExp.mq4 |
//|                                               Alekzander Bywater |
//|                                     https://github.com/BarneyB94 |
//+------------------------------------------------------------------+

// Next line assumes this file is located in .../Frameworks/Extensions/someFolder 
#include	"../../Framework.mqh"

class CConfIndWAExp : public CIndicatorBase {

private:

protected:	// member variables
	// Waddah Attar inputs
	int  mSensetive;
	int  mDeadZonePip;
	int  mExplosionPower;
	int  mTrendPower;
	bool mAlertWindow;
	int  mAlertCount;
	bool mAlertLong;
	bool mAlertShort;
	bool mAlertExitLong;
	bool mAlertExitShort;

//	Place any required member variables here

public:	// constructors

	//	Add any required constructor arguments
	//	e.g. CIndicatorXYZ(int periods, double multiplier)
	CConfIndWAExp(int Sensetive, int DeadZonePip, int ExplosionPower, int TrendPower, bool AlertWindow, int AlertCount, bool AlertLong, bool AlertShort, bool AlertExitLong, bool  AlertExitShort)
								:	CIndicatorBase()
								{	Init();	}
	// Same constructor with symbol and timeframe added
	CConfIndWAExp(string symbol, ENUM_TIMEFRAMES timeframe, 
							int Sensetive, int DeadZonePip, int ExplosionPower, int TrendPower, bool AlertWindow, int AlertCount, bool AlertLong, bool AlertShort, bool AlertExitLong, bool  AlertExitShort)
								:	CIndicatorBase(symbol, timeframe)
								{	Init();	}
	~CConfIndWAExp();

	//	Include all arguments to match the constructor
	virtual int			Init(int Sensetive, int DeadZonePip, int ExplosionPower, int TrendPower, bool AlertWindow, int AlertCount, bool AlertLong, bool AlertShort, bool AlertExitLong, bool  AlertExitShort);

public:

	//	Add this line to override the same function from the parent class
   virtual double GetData(const int buffer_num,const int index);

};

CConfIndWAExp::~CConfIndWAExp() {

	//	Any destructors here
	
}

int		CConfIndWAExp::Init(int Sensetive, int DeadZonePip, int ExplosionPower, int TrendPower, bool AlertWindow, int AlertCount, bool AlertLong, bool AlertShort, bool AlertExitLong, bool  AlertExitShort) {

	//	Checks if init has been set to fail by any parent class already
	if (InitResult()!=INIT_SUCCEEDED)	return(InitResult());

	//	Assign variables and do any other initialisation here	
	mSensetive		 = Sensetive;
	mDeadZonePip	 = DeadZonePip;
	mExplosionPower = ExplosionPower;
	mTrendPower     = TrendPower;
	mAlertWindow	 = AlertWindow;
	mAlertCount	  	 = AlertCount;
	mAlertLong 		 = AlertLong;
	mAlertShort 	 = AlertShort;
	mAlertExitLong	 = AlertExitLong;
	mAlertExitShort = AlertExitShort;
	
	return(INIT_SUCCEEDED);
	
}

double	CConfIndWAExp::GetData(const int buffer_num,const int index) {

	double	value	=	0;
	// Next line is just an example using iMA
	//	value	=	iMA(mSymbol, mTimeframe, mPeriods, mShift, mMethod, mAppliedPrice, index);
	value = iCustom(_Symbol, _Period, "//NNFX ShortTerm//NNFX LowTF//Waddah_Attar_Explosion", mSensetive, 
                                                                                             mDeadZonePip, 
                                                                                             mExplosionPower, 
                                                                                             mTrendPower, 
                                                                                             mAlertWindow, 
                                                                                             mAlertCount, 
                                                                                             mAlertLong, 
                                                                                             mAlertShort, 
                                                                                             mAlertExitLong, 
                                                                                             mAlertExitShort, buffer_num, index);

return(value);
	
}


