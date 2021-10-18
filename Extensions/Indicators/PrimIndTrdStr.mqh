//+------------------------------------------------------------------+
//|                                               PrimInd_TrdStr.mqh |
//|                                               Alekzander Bywater |
//|                                     https://github.com/BarneyB94 |
//+------------------------------------------------------------------+

// Next line assumes this file is located in .../Frameworks/Extensions/someFolder 
#include	"../../Framework.mqh"

class CPrimIndTrdStr : public CIndicatorBase {

private:

protected:	// member variables
	// Trend Strength inputs
	double         mRate;
	int            mMA_PERIOD;
	ENUM_MA_METHOD mMAMethod;

public:	// constructors

	CPrimIndTrdStr(double rate, int MA_PERIOD, ENUM_MA_METHOD MAMethod)
								:	CIndicatorBase()
								{	Init();	}
	// Same constructor with symbol and timeframe added
	CPrimIndTrdStr(string symbol, ENUM_TIMEFRAMES timeframe,
							double rate, int MA_PERIOD, ENUM_MA_METHOD MAMethod)
								:	CIndicatorBase(symbol, timeframe)
								{	Init();	}
	~CPrimIndTrdStr();

	//	Include all arguments to match the constructor
	virtual int			Init(double rate, int MA_PERIOD, ENUM_MA_METHOD MAMethod);

public:

	//	Add this line to override the same function from the parent class
   virtual double GetData(const int buffer_num,const int index);
 
};

CPrimIndTrdStr::~CPrimIndTrdStr() {

	//	Any destructors here
	
}

int		CPrimIndTrdStr::Init(double rate, int MA_PERIOD, ENUM_MA_METHOD MAMethod) {

	//	Checks if init has been set to fail by any parent class already
	if (InitResult()!=INIT_SUCCEEDED)	return(InitResult());

	mRate      = rate;
	mMA_PERIOD = MA_PERIOD;
	mMAMethod  = MAMethod;

	return(INIT_SUCCEEDED);
}

double	CPrimIndTrdStr::GetData(const int buffer_num,const int index) {

	double	value	=	0;
	//	value	=	iMA(mSymbol, mTimeframe, mPeriods, mShift, mMethod, mAppliedPrice, index);
	value = iCustom(_Symbol, _Period, "//NNFX ShortTerm//NNFX LowTF//TrendStrengthInd", mRate, 
                                                                                       mMA_PERIOD,
                                                                                       mMAMethod, buffer_num, index);

	return(value);
	
}


