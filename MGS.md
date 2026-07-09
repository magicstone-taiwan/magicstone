# 麥金崗石 (Magic Stone) 官方網站維護與部署指南 (Maintenance & Deploy Guide)

本文件是麥金崗石官方網站專案的技術維護、UI/UX 規範、SEO 標準與一鍵部署上架指南，方便您隨時查閱與維護網站。

---

## 📂 專案檔案結構 (Project Structure)
本專案為高效能靜態網頁（Jamstack）架構，檔案存放於本地您的 `magicstone/` 目錄下：
* 📄 **[index.html](file:///C:/SYNC/TENG/magicstone/index.html)**：官方網站核心代碼（含 HTML 結構、CSS 樣式表、JavaScript 色彩模擬器與點擊複製信箱之核心邏輯）。
* 📂 **[swatch_scenes/](file:///C:/SYNC/TENG/magicstone/swatch_scenes/)**：存放 36 色大地色卡之高清實景圖（檔名為 `mgs_001.jpg` 至 `mgs_036.jpg`）。
* ⚙️ **[deploy.bat](file:///C:/SYNC/TENG/magicstone/deploy.bat)**：純英文編寫的一鍵 Git 提交與 GitHub Pages 推送工具。
* 🔍 **[robots.txt](file:///C:/SYNC/TENG/magicstone/robots.txt)** 與 **[sitemap.xml](file:///C:/SYNC/TENG/magicstone/sitemap.xml)**：搜尋引擎爬蟲指南與網站地圖。

---

## ✍️ 品牌文案與法規遵循規範 (Copywriting Rules)
為防止同行惡意競爭或公平交易法之誇大宣傳質疑，標語與數據請遵循以下規則：
1. **避用第一**：嚴禁在宣傳標語中使用「第一本土品牌」或「台灣第一」等字眼。
   * *合格標語*：`麥金崗石 — 台灣本土優質礦物塗料` 或 `台灣本土優質塗料代表`。
2. **避開精工**：根據您的偏好，避免使用「精工」字眼。
3. **模糊年資數據**：由於研發到銷售實際僅 7、8 年，網頁上已移成了具體年份數字（如 "10年" 或 "30年"），以保持嚴謹。
   * *合格數據指標展示*：
     * 數值：`專業` ➡️ 標籤：`在地核心技術研發`。
     * 數值：`100%` ➡️ 標籤：`台灣在地研發生產`。
     * 數值：`36+` ➡️ 標籤：`大自然大地精緻配色`。
     * 數值：`0` ➡️ 標籤：`重金屬有害化學添加`。

---

## 🎨 色彩模擬器與圖片優化標準 (Color Swatches & Image Processing)
網站採用 **100% 實景直出模式**（直接更換底圖，不加 CSS 混色濾鏡，以呈現最完美的天然岩石與漆面漫反射光影）。

### 1. 圖片處理標準 (極重要，維持載入速度低於 1 秒的關鍵)
嚴禁將生成的大容量圖片（如 9MB 的原始 PNG 檔）直接放入網頁！當有新圖片需要加入色卡時，必須進行以下處理：
* ✂️ **邊緣裁剪**：向內裁剪所有四個邊緣的 **5%**，去除 AI 繪圖模型在角落或邊界產生的痕跡。
* 📐 **比例重設**：重設為 **1920x1080 (16:9)** 的 Full HD 解析度。
* 💾 **Web 格式壓縮**：轉換為 **JPEG 格式**，並設定 `quality=88, optimize=True`。壓縮後的單張圖片容量應維持在 **150KB ~ 250KB** 之間。
* 📂 **路徑命名**：命名為 `mgs_xxx.jpg`，放入 `swatch_scenes/` 目錄。

### 2. 程式碼對照表更新 (JS Mapping)
圖片放妥後，必須更新 [index.html](file:///C:/SYNC/TENG/magicstone/index.html) 中名為 `mgsCustomScenes` 的 JavaScript 物件對照表，使瀏覽器在點擊色票時能正確加載：
```javascript
const mgsCustomScenes = {
    "MGS-001": "swatch_scenes/mgs_001.jpg",
    "MGS-002": "swatch_scenes/mgs_002.jpg",
    // ... 依此類推直至 MGS-036
};
```

---

## 📱 行動裝置響應式排版規範 (Mobile Responsive CSS)
當調整網頁排版時，必須確保在手機版面下（`@media (max-width: 768px)`）符合以下標準：
1. **導覽列防遮擋**：手機版導覽列會折成兩行，因此 `.hero` 區塊的頂部內距必須設定為 `padding-top: 175px !important;`，防止選單遮住主標題。
2. **大標題字型縮小**：`.hero h2` 縮小為 `2.0rem`，`.company-title` 縮小為 `1.7rem`，並設定 `line-height: 1.45; word-break: keep-all;`，防止中文字詞被突兀截斷。
3. **優點對照表滾動**：為防止表格溢出，對照表容器 `.comparison-table-wrapper` 必須設定 `overflow-x: auto;`，並在媒體查詢中限制 `table { min-width: 750px !important; }`，讓手機用戶可以流暢地水平滑動瀏覽完整表格。
4. **色票分類按鈕間距**：色彩分類按鈕 the container `.palette-nav` 必須設定 `row-gap: 1.2rem;`，並將底線定位控制在 `bottom: -0.7rem;`，防止第一排按鈕選取時的底線重疊到第二排的文字。
5. **首頁按鈕垂直排列**：手機版下 `.hero-actions` 需切換為 `flex-direction: column;`，按鈕寬度限制為 `280px` 居中，確保點擊體驗。

---

## ✉️ 信箱 Mailto 點擊複製防護機制
為了讓沒有設定預設郵件軟體的手機與電腦用戶也能順利聯絡，必須實施「Mailto 連結 + 自動複製剪貼簿」雙重機制：
1. **網址參數百分比編碼**：`mailto:` 連結中的中文主旨與內文必須經過 100% URL 編碼（Percent-encoding），防止瀏覽器解析錯誤。
2. **JavaScript 防護機制**：
   * 點擊連結時觸發 `onclick="copyEmailAndNotify(event, 'magic862726@gmail.com')"`。
   * 此函數會自動將信箱複製到客戶的剪貼簿，並在網頁下方跳出精緻的金色邊框懸浮通知（Toast）提示：`「已自動複製信箱：magic862726@gmail.com 點擊可直接貼上寄信！」`。

---

## 🛠️ 工程諮詢與銷售政策規範 (Engineering & Sales Policy)
* **單賣材料限制**：麥金系列產品中，**只有「室內礦物美學系列」提供材料單獨販售**。
* **連工帶料政策**：其餘系列（如室外礦物美學系列、多彩崗石系列等）均**只提供「連工帶料」的專業施工工程服務**，不單獨販售材料。
* **計算器設計**：官方網站的用量估算計算器中，只保留「室內礦物美學系列」的試算，並在旁以顯眼金色文字加註此銷售政策，避免客戶對其他產品單買材料產生誤解。

---

## 🚀 一鍵部署與 GSC 收錄
1. **一鍵部署**：修改網頁後，直接點擊執行 [deploy.bat](file:///C:/SYNC/TENG/magicstone/deploy.bat)。腳本會強制切換至網頁路徑，提交變更並強制推送（`--force`）至託管的 GitHub 組織倉庫：
   `https://github.com/magicstone-taiwan/magicstone.git`
2. **Google 搜尋驗證**：若需重新驗證 Google Search Console，請引導客戶將下載的 Google HTML 驗證檔放至網頁根目錄，運行 `deploy.bat` 上傳，並在 Search Console 中使用**網址前綴**進行驗證：
   `https://magicstone-taiwan.github.io/magicstone/`
3. **Sitemap 狀態**：新提交 `sitemap.xml` 時，Google 後台會暫時顯示「無法讀取」，這是正常延遲，大約等待 24 小時後即會自動變更為綠色「成功」。
