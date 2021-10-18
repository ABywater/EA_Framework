//+------------------------------------------------------------------+
//|                                                 TPSLTemplate.mqh |
//|                                               Alekzander Bywater |
//|                                     https://github.com/BarneyB94 |
//+------------------------------------------------------------------+
 
// Next line assumes this file is located in .../Frameworks/Extensions/someFolder 
#include    "../../Framework.mqh"

class CTPSLConditional : public CTPSLBase {

private:

    double  GetValue(string TPSL);

protected:  // member variables

//  Place any required member variables here
    int     mIndicator;
    double  mTPMultiplier;
    double  mSLMultiplier;
    int     mIndex;

public: // constructors

    //  Add any required constructor arguments
    //  e.g. CTPSLXYZ(int periods, double multiplier)
    CTPSLConditional(int indicator, double tpMultiplier, double  slMultiplier, int index)          
                            :   CTPSLBase()
                            {   Init(); }
    // Same constructor with symbol and timeframe added
    CTPSLConditional(string symbol, ENUM_TIMEFRAMES timeframe, 
                        int indicator, double tpMultiplier, double  slMultiplier, int index)
                                :   CTPSLBase(symbol, timeframe)
                                {   Init(); }
    ~CTPSLConditional()             {   }
    
    int         Init(int indicator, double tpMultiplier, double  slMultiplier, int index);

public:

    //  Get and Set functions for additional parameters
    virtual void    SetIndicator(int indicator)          {   mIndicator = indicator;     }
    virtual double  GetIndicator()                       {   return(mIndicator);         }

    virtual void    SetIndex(int index)                  {   mIndex  =   index;  }
    virtual double  GetIndex()                           {   return(mIndex);     }

    virtual void    SetTPMultiplier(double tpMultiplier) {   mTPMultiplier =   tpMultiplier;   }
    virtual double  GetTPMultiplier()                    {   return(mTPMultiplier);            }

    virtual void    SetSLMultiplier(double slMultiplier) {   mSLMultiplier =   slMultiplier;   }
    virtual double  GetSLMultiplier()                    {   return(mSLMultiplier);            }
    //  Override these from the parent class to get required values
    //  GetValue here is just an example
    virtual double  GetTakeProfit()                      {   return(GetValue("Take Profit"));         }
    virtual double  GetStopLoss()                        {   return(GetValue("Stop Loss"));         }

};

int     CTPSLConditional::Init(int indicator, double tpMultiplier, double slMultiplier, int index) {

    //  Checks if init has been set to fail by any parent class already
    if (InitResult()!=INIT_SUCCEEDED)   return(InitResult());

    //  Assign variables and do any other initialisation here   
    mIndicator    = indicator;
    mTPMultiplier = tpMultiplier;
    mSLMultiplier = slMultiplier;
    mIndex        = index;

    return(INIT_SUCCEEDED);
    
}

//  A simple example of a value function
double  CTPSLConditional::GetValue(string exitType) {
    double value;
    if     (exitType == "Take Profit") {
        //  Pulls data from an assigned indicator number for bar mIndex and multiplies by 1
        value   =   GetIndicatorData(mIndicator, mIndex)*mTPMultiplier;
    } else if(exitType == "Stop Loss") {
        //  Pulls data from an assigned indicator number for bar mIndex and multiplies by 1.5
        value   =   GetIndicatorData(mIndicator, mIndex)*mSLMultiplier;
    } else {
        value    =   0.0;
          }

    return(value);
    
}

    
