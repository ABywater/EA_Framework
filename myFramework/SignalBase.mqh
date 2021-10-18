//+------------------------------------------------------------------+
//|                                                   SignalBase.mqh |
//|                                               Alekzander Bywater |
//|                                     https://github.com/BarneyB94 |
//+------------------------------------------------------------------+

#include	"CommonBase.mqh"
#include	"IndicatorBase.mqh"

////	New
////	This is to maintain compatibility and allow sub classes to still
////		use mEntrySignal= or mExitSignal=
////	mEntrySignal and mExitSignal are effectively deprecated now
#define mEntrySignal	mSignalValues[NWN_ENTRY_SIGNAL]	//	Deprecated
#define mExitSignal	mSignalValues[NWN_EXIT_SIGNAL]	//	Deprecated

struct SIndicatorItem {
	CIndicatorBase	*indicator;
	int				bufferNum;
};

////	New
enum ENUM_NWN_SIGNAL_TYPE {
	NWN_ENTRY_SIGNAL, 
	NWN_EXIT_SIGNAL
};

enum ENUM_NWN_SIGNAL_DIRECTION {
	NWN_SIGNAL_NONE	=	0,
	NWN_SIGNAL_BUY		=	1,
	NWN_SIGNAL_SELL	=	2,
	NWN_SIGNAL_BOTH	=	3
};

class CSignalBase : public CCommonBase {

private:

protected:	// member variables

	////	Replaced
	ENUM_NWN_SIGNAL_DIRECTION	mSignalValues[2];
	////ENUM_NWN_SIGNAL_DIRECTION	mEntrySignal;
	////ENUM_NWN_SIGNAL_DIRECTION	mExitSignal;
	SIndicatorItem					mIndicatorList[];
	
public:	// constructors

	CSignalBase()															:	CCommonBase()
																				{	Init();	}
	CSignalBase(string symbol, ENUM_TIMEFRAMES timeframe)		:	CCommonBase(symbol, timeframe)
																				{	Init();	}
	~CSignalBase()															{	}
	
	int			Init();

public:

	virtual void								UpdateSignal()		{	return;	}
	////	Changed - maintain backward compatibility
	virtual ENUM_NWN_SIGNAL_DIRECTION	EntrySignal()		{	return(mSignalValues[NWN_ENTRY_SIGNAL]);	}
	virtual ENUM_NWN_SIGNAL_DIRECTION	ExitSignal()		{	return(mSignalValues[NWN_EXIT_SIGNAL]);	}
	////	New, and shows my lack of planning
	virtual void								SetSignal(ENUM_NWN_SIGNAL_TYPE type,
																	ENUM_NWN_SIGNAL_DIRECTION value)
																			{	mSignalValues[type] = value;	}
	virtual ENUM_NWN_SIGNAL_DIRECTION	GetSignal(ENUM_NWN_SIGNAL_TYPE type)
																			{	return(mSignalValues[type]);	}
	
	virtual void								AddIndicator(CIndicatorBase *indicator, int bufferNum);
	virtual double								GetIndicatorData(int indicatorNum, int index);

};

int		CSignalBase::Init() {

	if (InitResult()!=INIT_SUCCEEDED)	return(InitResult());
	
	////	Replaced
	ArrayInitialize(mSignalValues, NWN_SIGNAL_NONE);
	////mEntrySignal		=	NWN_SIGNAL_NONE;
	////mExitSignal	   =	NWN_SIGNAL_NONE;

	return(INIT_SUCCEEDED);
	
}

void		CSignalBase::AddIndicator(CIndicatorBase *indicator, int bufferNum) {

	SIndicatorItem	indicatorItem	=	{NULL, 0};
	indicatorItem.indicator			=	indicator;
	indicatorItem.bufferNum			=	bufferNum;
	int	cnt	=	ArraySize(mIndicatorList);
	ArrayResize(mIndicatorList, cnt+1);
	mIndicatorList[cnt]	=	indicatorItem;
   if (indicator.InitResult()!=INIT_SUCCEEDED) {
      InitError("",indicator.InitResult());
   }
	
	return;

}

double	CSignalBase::GetIndicatorData(int indicatorNum,int index) {

	return(mIndicatorList[indicatorNum].indicator.GetData(mIndicatorList[indicatorNum].bufferNum, index));
	
}


