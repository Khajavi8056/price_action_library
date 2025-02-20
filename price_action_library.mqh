#ifndef PRICE_ACTION_LIBRARY_MQH
#define PRICE_ACTION_LIBRARY_MQH

//+------------------------------------------------------------------+
//| تنظیمات پیش‌فرض و ثابت‌ها                                        |
//+------------------------------------------------------------------+
#define LIBRARY_VERSION "1.1.0"                  // نسخه به‌روزرسانی‌شده کتابخانه
#define DEFAULT_LOOKBACK_PERIOD 20               // تعداد کندل‌های پیش‌فرض برای نگاه به عقب
#define MINIMUM_PIP_RANGE 20                     // حداقل دامنه قیمتی به پیپ برای تأیید ساختارها
#define MINIMUM_VOLUME_THRESHOLD 10              // حداقل حجم برای اعتبارسنجی الگوها
#define PINBAR_TAIL_RATIO 0.7                    // نسبت دم به بدنه در پین بار (70%)
#define ENGULFING_RATIO 1.5                      // حداقل نسبت اینگالفینگ به کندل قبلی
#define GAP_THRESHOLD 10                         // حداقل اندازه شکاف به پیپ
#define SWING_MINOR_THRESHOLD 10                 // حداقل پیپ برای تشخیص Swing Minor
#define SWING_MAJOR_THRESHOLD 50                 // حداقل پیپ برای تشخیص Swing Major
#define SWING_CONFIRMATION_CANDLES 2             // تعداد کندل‌های تأییدی برای Swing

//+------------------------------------------------------------------+
//| تعریف نوع داده برای ساختار بازار                                |
//+------------------------------------------------------------------+
enum ENUM_MARKET_STRUCTURE {
   MARKET_STRUCTURE_BULLISH,       // ساختار صعودی بازار
   MARKET_STRUCTURE_BEARISH,       // ساختار نزولی بازار
   MARKET_STRUCTURE_CONSOLIDATION  // ساختار خنثی (تثبیت) بازار
};

//+------------------------------------------------------------------+
//| ساختارهای پیشرفته برای ذخیره اطلاعات پرایس اکشن               |
//+------------------------------------------------------------------+
struct SupportResistanceLevel {
   double priceLevel;          // سطح قیمت حمایت یا مقاومت
   datetime timeDetected;      // زمان تشخیص سطح
   int touchCount;             // تعداد برخوردها به سطح
   bool isSupport;             // آیا سطح حمایت است؟ (true) یا مقاومت (false)
   bool isBroken;              // آیا سطح شکسته شده است؟
};

struct TrendInfo {
   ENUM_MARKET_STRUCTURE trendType; // نوع روند (صعودی، نزولی، خنثی)
   double slope;                    // شیب روند (درصد تغییر قیمت)
   datetime startTime;              // زمان شروع روند
   datetime endTime;                // زمان پایان روند
   int candleCount;                 // تعداد کندل‌ها در روند
};

struct PinBar {
   bool isDetected;            // آیا پین بار تشخیص داده شده است؟
   double tailPrice;           // قیمت دم پین بار
   double bodyPrice;           // قیمت بدنه پین بار
   datetime time;              // زمان وقوع پین بار
   bool isBullish;             // آیا پین بار صعودی است؟ (true) یا نزولی (false)
};

struct EngulfingPattern {
   bool isDetected;            // آیا الگوی اینگالفینگ تشخیص داده شده است؟
   double engulfingHigh;       // بالاترین قیمت کندل اینگالفینگ
   double engulfingLow;        // پایین‌ترین قیمت کندل اینگالفینگ
   datetime time;              // زمان وقوع الگو
   bool isBullish;             // آیا الگو صعودی است؟ (true) یا نزولی (false)
};

struct DojiPattern {
   bool isDetected;            // آیا الگوی دوجی تشخیص داده شده است؟
   double dojiPrice;           // قیمت کندل دوجی
   datetime time;              // زمان وقوع دوجی
};

struct BreakoutInfo {
   bool isDetected;            // آیا شکست تشخیص داده شده است؟
   double breakLevel;          // سطح شکسته‌شده
   datetime breakTime;         // زمان وقوع شکست
   bool isBullish;             // آیا شکست صعودی است؟ (true) یا نزولی (false)
   bool isConfirmed;           // آیا شکست تأیید شده است؟
};

struct ReversalInfo {
   bool isDetected;            // آیا بازگشت تشخیص داده شده است؟
   double reversalLevel;       // سطح بازگشت
   datetime reversalTime;      // زمان وقوع بازگشت
   bool isBullish;             // آیا بازگشت صعودی است؟ (true) یا نزولی (false)
};

struct SupplyDemandZone {
   double highPrice;           // بالاترین قیمت ناحیه عرضه/تقاضا
   double lowPrice;            // پایین‌ترین قیمت ناحیه عرضه/تقاضا
   datetime startTime;         // زمان شروع ناحیه
   datetime endTime;           // زمان پایان ناحیه
   bool isSupply;              // آیا ناحیه عرضه است؟ (true) یا تقاضا (false)
   double strength;            // قدرت ناحیه بر اساس حجم و دامنه
};

struct PriceGap {
   bool isDetected;            // آیا شکاف تشخیص داده شده است؟
   double topLevel;            // سطح بالای شکاف
   double bottomLevel;         // سطح پایین شکاف
   datetime time;              // زمان وقوع شکاف
   double gapSizeInPips;       // اندازه شکاف به پیپ
   bool isFilled;              // آیا شکاف پر شده است؟
};

struct PivotPoint {
   double highPrice;           // قیمت نقطه چرخش بالا
   double lowPrice;            // قیمت نقطه چرخش پایین
   datetime time;              // زمان وقوع نقطه چرخش
   bool isValid;               // آیا نقطه چرخش معتبر است؟
};

struct SwingMinorInfo {
   bool isDetected;            // آیا Swing Minor تشخیص داده شده است؟
   double swingHigh;           // قیمت نقطه چرخش بالای مینور
   double swingLow;            // قیمت نقطه چرخش پایین مینور
   datetime time;              // زمان وقوع Swing Minor
   bool isBullish;             // آیا Swing صعودی است؟ (true) یا نزولی (false)
   double strength;            // قدرت Swing بر اساس حجم و دامنه
};

struct SwingMajorInfo {
   bool isDetected;            // آیا Swing Major تشخیص داده شده است؟
   double swingHigh;           // قیمت نقطه چرخش بالای ماژور
   double swingLow;            // قیمت نقطه چرخش پایین ماژور
   datetime time;              // زمان وقوع Swing Major
   bool isBullish;             // آیا Swing صعودی است؟ (true) یا نزولی (false)
   double strength;            // قدرت Swing بر اساس حجم و دامنه
};

//+------------------------------------------------------------------+
//| توابع کمکی برای محاسبات پایه                                    |
//+------------------------------------------------------------------+
double FindHighestHigh(int startIndex, int candleCount, const double &highPrices[], string &errorMessage) {
   if (startIndex < 0 || startIndex + candleCount > ArraySize(highPrices)) {
      errorMessage = "بازه مشخص‌شده برای یافتن بالاترین قیمت نامعتبر است";
      return 0;
   }
   int maximumIndex = ArrayMaximum(highPrices, startIndex, candleCount);
   return (maximumIndex >= 0) ? highPrices[maximumIndex] : 0;
}

double FindLowestLow(int startIndex, int candleCount, const double &lowPrices[], string &errorMessage) {
   if (startIndex < 0 || startIndex + candleCount > ArraySize(lowPrices)) {
      errorMessage = "بازه مشخص‌شده برای یافتن پایین‌ترین قیمت نامعتبر است";
      return 0;
   }
   int minimumIndex = ArrayMinimum(lowPrices, startIndex, candleCount);
   return (minimumIndex >= 0) ? lowPrices[minimumIndex] : 0;
}

double CalculateAverageVolume(int startIndex, int candleCount, const long &volumeData[], string &errorMessage) {
   if (startIndex < 0 || startIndex + candleCount > ArraySize(volumeData)) {
      errorMessage = "بازه مشخص‌شده برای محاسبه میانگین حجم نامعتبر است";
      return 0;
   }
   double totalVolume = 0;
   for (int i = startIndex; i < startIndex + candleCount; i++) {
      totalVolume += (double)volumeData[i];
   }
   return (candleCount > 0) ? totalVolume / candleCount : 0;
}

double CalculatePipSize(double priceLevel1, double priceLevel2) {
   return MathAbs(priceLevel1 - priceLevel2) / Point();
}

//+------------------------------------------------------------------+
//| تابع تشخیص سطوح حمایت و مقاومت                                 |
//+------------------------------------------------------------------+
SupportResistanceLevel DetectSupportResistance(int currentIndex, int lookbackPeriod, const double &highPrices[], 
                                              const double &lowPrices[], const double &closePrices[], 
                                              const datetime &timeStamps[], string &errorMessage) {
   SupportResistanceLevel srLevel = {0, 0, 0, false, false};
   
   if (currentIndex < lookbackPeriod || ArraySize(highPrices) <= currentIndex || ArraySize(closePrices) <= currentIndex) {
      errorMessage = "اندیس خارج از محدوده برای تشخیص سطح حمایت/مقاومت";
      return srLevel;
   }

   double levelPrice = highPrices[currentIndex];
   int touches = 0;
   bool isSupport = true;

   for (int i = currentIndex - lookbackPeriod; i < currentIndex; i++) {
      if (MathAbs(highPrices[i] - levelPrice) <= Point() * MINIMUM_PIP_RANGE) {
         touches++;
         isSupport = false; // اگر قیمت به‌عنوان High برخورد داشته باشد، مقاومت است
      } else if (MathAbs(lowPrices[i] - levelPrice) <= Point() * MINIMUM_PIP_RANGE) {
         touches++;
         isSupport = true; // اگر قیمت به‌عنوان Low برخورد داشته باشد، حمایت است
      }
   }

   if (touches >= 2) {
      srLevel.priceLevel = levelPrice;
      srLevel.timeDetected = timeStamps[currentIndex];
      srLevel.touchCount = touches;
      srLevel.isSupport = isSupport;
      srLevel.isBroken = (closePrices[currentIndex] > levelPrice && !isSupport) || 
                         (closePrices[currentIndex] < levelPrice && isSupport);
   }

   return srLevel;
}

//+------------------------------------------------------------------+
//| تابع تشخیص روند (Trend)                                        |
//+------------------------------------------------------------------+
TrendInfo DetectTrend(int currentIndex, int lookbackPeriod, const double &highPrices[], 
                     const double &lowPrices[], const double &closePrices[], 
                     const datetime &timeStamps[], string &errorMessage) {
   TrendInfo trend = {MARKET_STRUCTURE_CONSOLIDATION, 0, 0, 0, 0};
   
   if (currentIndex < lookbackPeriod || ArraySize(highPrices) <= currentIndex) {
      errorMessage = "اندیس خارج از محدوده برای تشخیص روند";
      return trend;
   }

   double startPrice = closePrices[currentIndex - lookbackPeriod];
   double endPrice = closePrices[currentIndex];
   double priceChange = (endPrice - startPrice) / Point();
   trend.slope = priceChange / lookbackPeriod;

   if (priceChange > MINIMUM_PIP_RANGE && highPrices[currentIndex] > FindHighestHigh(currentIndex - lookbackPeriod, lookbackPeriod, highPrices, errorMessage)) {
      trend.trendType = MARKET_STRUCTURE_BULLISH;
   } else if (priceChange < -MINIMUM_PIP_RANGE && lowPrices[currentIndex] < FindLowestLow(currentIndex - lookbackPeriod, lookbackPeriod, lowPrices, errorMessage)) {
      trend.trendType = MARKET_STRUCTURE_BEARISH;
   } else {
      trend.trendType = MARKET_STRUCTURE_CONSOLIDATION;
   }

   trend.startTime = timeStamps[currentIndex - lookbackPeriod];
   trend.endTime = timeStamps[currentIndex];
   trend.candleCount = lookbackPeriod;

   return trend;
}

//+------------------------------------------------------------------+
//| تابع تشخیص پین بار (Pin Bar)                                   |
//+------------------------------------------------------------------+
PinBar DetectPinBar(int currentIndex, const double &highPrices[], const double &lowPrices[], 
                   const double &openPrices[], const double &closePrices[], 
                   const datetime &timeStamps[], string &errorMessage) {
   PinBar pinBar = {false, 0, 0, 0, false};
   
   if (currentIndex < 1 || ArraySize(highPrices) <= currentIndex) {
      errorMessage = "اندیس خارج از محدوده برای تشخیص پین بار";
      return pinBar;
   }

   double bodySize = MathAbs(closePrices[currentIndex] - openPrices[currentIndex]);
   double upperTail = highPrices[currentIndex] - MathMax(openPrices[currentIndex], closePrices[currentIndex]);
   double lowerTail = MathMin(openPrices[currentIndex], closePrices[currentIndex]) - lowPrices[currentIndex];
   double totalRange = highPrices[currentIndex] - lowPrices[currentIndex];

   if (totalRange > 0) {
      if (upperTail / totalRange >= PINBAR_TAIL_RATIO && bodySize < upperTail) {
         pinBar.isDetected = true;
         pinBar.tailPrice = highPrices[currentIndex];
         pinBar.bodyPrice = closePrices[currentIndex];
         pinBar.time = timeStamps[currentIndex];
         pinBar.isBullish = false;
      } else if (lowerTail / totalRange >= PINBAR_TAIL_RATIO && bodySize < lowerTail) {
         pinBar.isDetected = true;
         pinBar.tailPrice = lowPrices[currentIndex];
         pinBar.bodyPrice = closePrices[currentIndex];
         pinBar.time = timeStamps[currentIndex];
         pinBar.isBullish = true;
      }
   }

   return pinBar;
}

//+------------------------------------------------------------------+
//| تابع تشخیص الگوی اینگالفینگ (Engulfing Pattern)               |
//+------------------------------------------------------------------+
EngulfingPattern DetectEngulfing(int currentIndex, const double &highPrices[], const double &lowPrices[], 
                                const double &openPrices[], const double &closePrices[], 
                                const datetime &timeStamps[], string &errorMessage) {
   EngulfingPattern engulfing = {false, 0, 0, 0, false};
   
   if (currentIndex < 1 || ArraySize(highPrices) <= currentIndex) {
      errorMessage = "اندیس خارج از محدوده برای تشخیص اینگالفینگ";
      return engulfing;
   }

   double prevRange = highPrices[currentIndex - 1] - lowPrices[currentIndex - 1];
   double currRange = highPrices[currentIndex] - lowPrices[currentIndex];
   bool isBullish = closePrices[currentIndex] > openPrices[currentIndex];
   bool prevIsBearish = closePrices[currentIndex - 1] < openPrices[currentIndex - 1];

   if (currRange >= ENGULFING_RATIO * prevRange && 
       highPrices[currentIndex] > highPrices[currentIndex - 1] && 
       lowPrices[currentIndex] < lowPrices[currentIndex - 1]) {
      engulfing.isDetected = true;
      engulfing.engulfingHigh = highPrices[currentIndex];
      engulfing.engulfingLow = lowPrices[currentIndex];
      engulfing.time = timeStamps[currentIndex];
      engulfing.isBullish = isBullish && prevIsBearish;
   }

   return engulfing;
}

//+------------------------------------------------------------------+
//| تابع تشخیص الگوی دوجی (Doji Pattern)                          |
//+------------------------------------------------------------------+
DojiPattern DetectDoji(int currentIndex, const double &highPrices[], const double &lowPrices[], 
                      const double &openPrices[], const double &closePrices[], 
                      const datetime &timeStamps[], string &errorMessage) {
   DojiPattern doji = {false, 0, 0};
   
   if (currentIndex < 0 || ArraySize(highPrices) <= currentIndex) {
      errorMessage = "اندیس خارج از محدوده برای تشخیص دوجی";
      return doji;
   }

   double bodySize = MathAbs(closePrices[currentIndex] - openPrices[currentIndex]);
   double totalRange = highPrices[currentIndex] - lowPrices[currentIndex];

   if (totalRange > 0 && bodySize / totalRange <= 0.1) { // بدنه کمتر از 10% کل دامنه
      doji.isDetected = true;
      doji.dojiPrice = (highPrices[currentIndex] + lowPrices[currentIndex]) / 2;
      doji.time = timeStamps[currentIndex];
   }

   return doji;
}

//+------------------------------------------------------------------+
//| تابع تشخیص شکست (Breakout)                                     |
//+------------------------------------------------------------------+
BreakoutInfo DetectBreakout(int currentIndex, int lookbackPeriod, const double &highPrices[], 
                           const double &lowPrices[], const double &closePrices[], 
                           const datetime &timeStamps[], string &errorMessage) {
   BreakoutInfo breakout = {false, 0, 0, false, false};
   
   if (currentIndex < lookbackPeriod || ArraySize(highPrices) <= currentIndex) {
      errorMessage = "اندیس خارج از محدوده برای تشخیص شکست";
      return breakout;
   }

   double previousHigh = FindHighestHigh(currentIndex - lookbackPeriod, lookbackPeriod, highPrices, errorMessage);
   double previousLow = FindLowestLow(currentIndex - lookbackPeriod, lookbackPeriod, lowPrices, errorMessage);

   if (closePrices[currentIndex] > previousHigh) {
      breakout.isDetected = true;
      breakout.breakLevel = previousHigh;
      breakout.breakTime = timeStamps[currentIndex];
      breakout.isBullish = true;
      breakout.isConfirmed = closePrices[currentIndex - 1] > previousHigh;
   } else if (closePrices[currentIndex] < previousLow) {
      breakout.isDetected = true;
      breakout.breakLevel = previousLow;
      breakout.breakTime = timeStamps[currentIndex];
      breakout.isBullish = false;
      breakout.isConfirmed = closePrices[currentIndex - 1] < previousLow;
   }

   return breakout;
}

//+------------------------------------------------------------------+
//| تابع تشخیص بازگشت (Reversal)                                   |
//+------------------------------------------------------------------+
ReversalInfo DetectReversal(int currentIndex, int lookbackPeriod, const double &highPrices[], 
                           const double &lowPrices[], const double &closePrices[], 
                           const datetime &timeStamps[], string &errorMessage) {
   ReversalInfo reversal = {false, 0, 0, false};
   
   if (currentIndex < lookbackPeriod + 1 || ArraySize(highPrices) <= currentIndex) {
      errorMessage = "اندیس خارج از محدوده برای تشخیص بازگشت";
      return reversal;
   }

   double prevHigh = FindHighestHigh(currentIndex - lookbackPeriod, lookbackPeriod, highPrices, errorMessage);
   double prevLow = FindLowestLow(currentIndex - lookbackPeriod, lookbackPeriod, lowPrices, errorMessage);
   bool wasBullish = closePrices[currentIndex - 1] > prevHigh;
   bool wasBearish = closePrices[currentIndex - 1] < prevLow;

   if (wasBullish && closePrices[currentIndex] < prevLow) {
      reversal.isDetected = true;
      reversal.reversalLevel = prevLow;
      reversal.reversalTime = timeStamps[currentIndex];
      reversal.isBullish = false;
   } else if (wasBearish && closePrices[currentIndex] > prevHigh) {
      reversal.isDetected = true;
      reversal.reversalLevel = prevHigh;
      reversal.reversalTime = timeStamps[currentIndex];
      reversal.isBullish = true;
   }

   return reversal;
}

//+------------------------------------------------------------------+
//| تابع تشخیص نواحی عرضه و تقاضا (Supply & Demand Zones)         |
//+------------------------------------------------------------------+
SupplyDemandZone DetectSupplyDemandZone(int currentIndex, int lookbackPeriod, const double &highPrices[], 
                                       const double &lowPrices[], const double &closePrices[], 
                                       const long &volumeData[], const datetime &timeStamps[], 
                                       string &errorMessage) {
   SupplyDemandZone sdZone = {0, 0, 0, 0, false, 0};
   
   if (currentIndex < lookbackPeriod + 1 || ArraySize(highPrices) <= currentIndex) {
      errorMessage = "اندیس خارج از محدوده برای تشخیص ناحیه عرضه/تقاضا";
      return sdZone;
   }

   double prevHigh = FindHighestHigh(currentIndex - lookbackPeriod, lookbackPeriod, highPrices, errorMessage);
   double prevLow = FindLowestLow(currentIndex - lookbackPeriod, lookbackPeriod, lowPrices, errorMessage);
   double volumeAvg = CalculateAverageVolume(currentIndex - lookbackPeriod, lookbackPeriod, volumeData, errorMessage);

   if (closePrices[currentIndex] > prevHigh && closePrices[currentIndex - 1] < prevHigh && volumeAvg >= MINIMUM_VOLUME_THRESHOLD) {
      sdZone.highPrice = highPrices[currentIndex - 1];
      sdZone.lowPrice = lowPrices[currentIndex - 1];
      sdZone.startTime = timeStamps[currentIndex - 1];
      sdZone.endTime = timeStamps[currentIndex];
      sdZone.isSupply = false;
      sdZone.strength = volumeAvg * (sdZone.highPrice - sdZone.lowPrice) / Point();
   } else if (closePrices[currentIndex] < prevLow && closePrices[currentIndex - 1] > prevLow && volumeAvg >= MINIMUM_VOLUME_THRESHOLD) {
      sdZone.highPrice = highPrices[currentIndex - 1];
      sdZone.lowPrice = lowPrices[currentIndex - 1];
      sdZone.startTime = timeStamps[currentIndex - 1];
      sdZone.endTime = timeStamps[currentIndex];
      sdZone.isSupply = true;
      sdZone.strength = volumeAvg * (sdZone.highPrice - sdZone.lowPrice) / Point();
   }

   return sdZone;
}

//+------------------------------------------------------------------+
//| تابع تشخیص شکاف قیمتی (Price Gap)                             |
//+------------------------------------------------------------------+
PriceGap DetectPriceGap(int currentIndex, const double &highPrices[], const double &lowPrices[], 
                       const double &closePrices[], const datetime &timeStamps[], string &errorMessage) {
   PriceGap gap = {false, 0, 0, 0, 0, false};
   
   if (currentIndex < 1 || ArraySize(highPrices) <= currentIndex) {
      errorMessage = "اندیس خارج از محدوده برای تشخیص شکاف قیمتی";
      return gap;
   }

   double prevHigh = highPrices[currentIndex - 1];
   double currLow = lowPrices[currentIndex];
   double prevLow = lowPrices[currentIndex - 1];
   double currHigh = highPrices[currentIndex];

   if (currLow > prevHigh) {
      gap.isDetected = true;
      gap.topLevel = currLow;
      gap.bottomLevel = prevHigh;
      gap.time = timeStamps[currentIndex];
      gap.gapSizeInPips = CalculatePipSize(gap.topLevel, gap.bottomLevel);
      gap.isFilled = (currentIndex + 1 < ArraySize(closePrices) && closePrices[currentIndex + 1] <= gap.bottomLevel);
   } else if (currHigh < prevLow) {
      gap.isDetected = true;
      gap.topLevel = prevLow;
      gap.bottomLevel = currHigh;
      gap.time = timeStamps[currentIndex];
      gap.gapSizeInPips = CalculatePipSize(gap.topLevel, gap.bottomLevel);
      gap.isFilled = (currentIndex + 1 < ArraySize(closePrices) && closePrices[currentIndex + 1] >= gap.topLevel);
   }

   return gap;
}

//+------------------------------------------------------------------+
//| تابع تشخیص نقاط چرخش (Pivot Points)                            |
//+------------------------------------------------------------------+
PivotPoint DetectPivotPoint(int currentIndex, int lookbackPeriod, const double &highPrices[], 
                           const double &lowPrices[], const datetime &timeStamps[], string &errorMessage) {
   PivotPoint pivot = {EMPTY_VALUE, EMPTY_VALUE, 0, false};
   
   if (currentIndex < lookbackPeriod + 1 || ArraySize(highPrices) <= currentIndex) {
      errorMessage = "اندیس خارج از محدوده برای تشخیص نقاط چرخش";
      return pivot;
   }

   double currentHigh = highPrices[currentIndex];
   double currentLow = lowPrices[currentIndex];
   double prevHigh = FindHighestHigh(currentIndex - lookbackPeriod, lookbackPeriod, highPrices, errorMessage);
   double prevLow = FindLowestLow(currentIndex - lookbackPeriod, lookbackPeriod, lowPrices, errorMessage);

   if (currentHigh > prevHigh && highPrices[currentIndex - 1] < currentHigh) {
      pivot.highPrice = currentHigh;
      pivot.isValid = true;
   }
   if (currentLow < prevLow && lowPrices[currentIndex - 1] > currentLow) {
      pivot.lowPrice = currentLow;
      pivot.isValid = true;
   }
   if (pivot.isValid) {
      pivot.time = timeStamps[currentIndex];
   }

   return pivot;
}

//+------------------------------------------------------------------+
//| تابع تشخیص Swing Minor                                         |
//+------------------------------------------------------------------+
SwingMinorInfo DetectSwingMinor(int currentIndex, int lookbackPeriod, const double &highPrices[], 
                               const double &lowPrices[], const double &closePrices[], 
                               const long &volumeData[], const datetime &timeStamps[], 
                               string &errorMessage) {
   SwingMinorInfo swingMinor = {false, 0, 0, 0, false, 0};
   
   if (currentIndex < lookbackPeriod + SWING_CONFIRMATION_CANDLES || ArraySize(highPrices) <= currentIndex) {
      errorMessage = "اندیس خارج از محدوده برای تشخیص Swing Minor";
      return swingMinor;
   }

   double currentHigh = highPrices[currentIndex];
   double currentLow = lowPrices[currentIndex];
   double prevHigh = FindHighestHigh(currentIndex - lookbackPeriod, lookbackPeriod, highPrices, errorMessage);
   double prevLow = FindLowestLow(currentIndex - lookbackPeriod, lookbackPeriod, lowPrices, errorMessage);
   double volumeAvg = CalculateAverageVolume(currentIndex - lookbackPeriod, lookbackPeriod, volumeData, errorMessage);

   if (currentHigh > prevHigh && CalculatePipSize(currentHigh, prevHigh) >= SWING_MINOR_THRESHOLD) {
      bool confirmed = true;
      for (int i = 1; i <= SWING_CONFIRMATION_CANDLES; i++) {
         if (highPrices[currentIndex - i] >= currentHigh) {
            confirmed = false;
            break;
         }
      }
      if (confirmed) {
         swingMinor.isDetected = true;
         swingMinor.swingHigh = currentHigh;
         swingMinor.swingLow = prevLow;
         swingMinor.time = timeStamps[currentIndex];
         swingMinor.isBullish = true;
         swingMinor.strength = volumeAvg * CalculatePipSize(currentHigh, prevHigh);
      }
   } else if (currentLow < prevLow && CalculatePipSize(prevLow, currentLow) >= SWING_MINOR_THRESHOLD) {
      bool confirmed = true;
      for (int i = 1; i <= SWING_CONFIRMATION_CANDLES; i++) {
         if (lowPrices[currentIndex - i] <= currentLow) {
            confirmed = false;
            break;
         }
      }
      if (confirmed) {
         swingMinor.isDetected = true;
         swingMinor.swingHigh = prevHigh;
         swingMinor.swingLow = currentLow;
         swingMinor.time = timeStamps[currentIndex];
         swingMinor.isBullish = false;
         swingMinor.strength = volumeAvg * CalculatePipSize(prevLow, currentLow);
      }
   }

   return swingMinor;
}

//+------------------------------------------------------------------+
//| تابع تشخیص Swing Major                                         |
//+------------------------------------------------------------------+
SwingMajorInfo DetectSwingMajor(int currentIndex, int lookbackPeriod, const double &highPrices[], 
                               const double &lowPrices[], const double &closePrices[], 
                               const long &volumeData[], const datetime &timeStamps[], 
                               string &errorMessage) {
   SwingMajorInfo swingMajor = {false, 0, 0, 0, false, 0};
   
   if (currentIndex < lookbackPeriod + SWING_CONFIRMATION_CANDLES || ArraySize(highPrices) <= currentIndex) {
      errorMessage = "اندیس خارج از محدوده برای تشخیص Swing Major";
      return swingMajor;
   }

   double currentHigh = highPrices[currentIndex];
   double currentLow = lowPrices[currentIndex];
   double prevHigh = FindHighestHigh(currentIndex - lookbackPeriod, lookbackPeriod, highPrices, errorMessage);
   double prevLow = FindLowestLow(currentIndex - lookbackPeriod, lookbackPeriod, lowPrices, errorMessage);
   double volumeAvg = CalculateAverageVolume(currentIndex - lookbackPeriod, lookbackPeriod, volumeData, errorMessage);

   if (currentHigh > prevHigh && CalculatePipSize(currentHigh, prevHigh) >= SWING_MAJOR_THRESHOLD) {
      bool confirmed = true;
      for (int i = 1; i <= SWING_CONFIRMATION_CANDLES; i++) {
         if (highPrices[currentIndex - i] >= currentHigh) {
            confirmed = false;
            break;
         }
      }
      if (confirmed) {
         swingMajor.isDetected = true;
         swingMajor.swingHigh = currentHigh;
         swingMajor.swingLow = prevLow;
         swingMajor.time = timeStamps[currentIndex];
         swingMajor.isBullish = true;
         swingMajor.strength = volumeAvg * CalculatePipSize(currentHigh, prevHigh);
      }
   } else if (currentLow < prevLow && CalculatePipSize(prevLow, currentLow) >= SWING_MAJOR_THRESHOLD) {
      bool confirmed = true;
      for (int i = 1; i <= SWING_CONFIRMATION_CANDLES; i++) {
         if (lowPrices[currentIndex - i] <= currentLow) {
            confirmed = false;
            break;
         }
      }
      if (confirmed) {
         swingMajor.isDetected = true;
         swingMajor.swingHigh = prevHigh;
         swingMajor.swingLow = currentLow;
         swingMajor.time = timeStamps[currentIndex];
         swingMajor.isBullish = false;
         swingMajor.strength = volumeAvg * CalculatePipSize(prevLow, currentLow);
      }
   }

   return swingMajor;
}

#endif