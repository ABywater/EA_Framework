//+------------------------------------------------------------------+
//|                                            SignalCombination.mqh |
//|                                               Alekzander Bywater |
//|                                     https://github.com/BarneyB94 |
//+------------------------------------------------------------------+
 
#include	"../../Framework.mqh"

class CSignalCombination : public CSignalBase {

private:

protected:	// member variables

	CSignalBase		*mSignals[];
	
public:	// constructors

	CSignalCombination(string symbol, ENUM_TIMEFRAMES timeframe)
								:	CSignalBase(symbol, timeframe)
								{	Init();	}
	CSignalCombination()
								:	CSignalBase()
								{	Init();	}
	~CSignalCombination()	{	}
	
	int			Init();

public:

	virtual void								AddSignal(CSignalBase *signal);
	virtual void								UpdateSignal();

};

int		CSignalCombination::Init() {

	if (InitResult()!=INIT_SUCCEEDED)	return(InitResult());

	ArrayResize(mSignals, 0);
	
	return(INIT_SUCCEEDED);
	
}

void		CSignalCombination::UpdateSignal() {

	int	index	=	ArraySize(mSignals);
	
	if (index<=0) {
	
		mEntrySignal	=	NWN_SIGNAL_NONE;
		mExitSignal		=	NWN_SIGNAL_NONE;
		
	} else {
		
		mSignals[0].UpdateSignal();
		mEntrySignal	=	mSignals[0].EntrySignal();
		mExitSignal		=	mSignals[0].ExitSignal();
		
		for (int i = 1; i<index; i++) {
		
			mSignals[i].UpdateSignal();
			if (mSignals[i].EntrySignal()!=mEntrySignal)	mEntrySignal	=	NWN_SIGNAL_NONE;
			if (mSignals[i].ExitSignal()!=mExitSignal)	mExitSignal		=	NWN_SIGNAL_NONE;
			
		}
	
	}
		
	return;
	
}

void		CSignalCombination::AddSignal(CSignalBase *signal) {

	int		index	=	ArraySize(mSignals);
	ArrayResize(mSignals, index+1);
	mSignals[index]	=	signal;
	
}

	
