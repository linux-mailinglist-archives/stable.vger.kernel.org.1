Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AB67A3B94
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbjIQUTr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbjIQUT1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:19:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCFCF1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:19:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905CAC433C8;
        Sun, 17 Sep 2023 20:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981961;
        bh=wN3EMAP5Kp9JzYiKCUJg54CuzucsgJu1Yf995neI9K0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HljAX2xr+FzIRB0AcPvRsVdcJcOVXdd6PWMQsm4aKlseDDduYMYNgOqUn2jQmDLE8
         BS9PHXTPIlIVm+T5uv7sOSkgLxKeNzOy1GPURYcZRYoFPNHK7xFBayTLIWhBQNlSQI
         urgsGV5nTrKQSASswg/8RLKPiryn+ZFKrnD3xtWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 132/511] arm64: dts: qcom: sm8250-edo: Add gpio line names for TLMM
Date:   Sun, 17 Sep 2023 21:09:19 +0200
Message-ID: <20230917191117.051839142@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 40b398beabdfe0e9088b13976e56b1dc706fe851 ]

Sony ever so graciously provides GPIO line names in their downstream
kernel (though sometimes they are not 100% accurate and you can judge
that by simply looking at them and with what drivers they are used).

Add these to the PDX203&206 DTSIs to better document the hardware.

Diff between 203 and 206:
<                         "CAM_PWR_A_CS",
>                         "FRONTC_PWR_EN",
<                         "CAM4_MCLK",
<                         "TOF_RST_N",
>                         "NC",
>                         "NC",
<                         "WLC_I2C_SDA",
<                         "WLC_I2C_SCL", /* GPIO_120 */
>                         "NC",
>                         "NC",
<                         "WLC_INT_N",
>                         "NC",

Which makes sense, as 203 has a 3D iToF, slightly different camera
power wiring and WLC (WireLess Charging).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230614-topic-edo_pinsgpiopmic-v2-1-6f90bba54c53@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: a422c6a91a66 ("arm64: dts: qcom: sm8250-edo: Rectify gpio-keys")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../qcom/sm8250-sony-xperia-edo-pdx203.dts    | 183 ++++++++++++++++++
 .../qcom/sm8250-sony-xperia-edo-pdx206.dts    | 183 ++++++++++++++++++
 2 files changed, 366 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
index 79afeb07f4a24..9b758385faafd 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
@@ -13,3 +13,186 @@ / {
 };
 
 /delete-node/ &vreg_l7f_1p8;
+
+&tlmm {
+	gpio-line-names = "AP_CTI_IN", /* GPIO_0 */
+			  "MDM2AP_ERR_FATAL",
+			  "AP_CTI_OUT",
+			  "MDM2AP_STATUS",
+			  "NFC_I2C_SDA",
+			  "NFC_I2C_SCL",
+			  "NFC_EN",
+			  "NFC_CLK_REQ",
+			  "NFC_ESE_PWR_REQ",
+			  "DVDT_WRT_DET_AND",
+			  "SPK_AMP_RESET_N", /* GPIO_10 */
+			  "SPK_AMP_INT_N",
+			  "APPS_I2C_1_SDA",
+			  "APPS_I2C_1_SCL",
+			  "NC",
+			  "TX_GTR_THRES_IN",
+			  "HST_BT_UART_CTS",
+			  "HST_BT_UART_RFR",
+			  "HST_BT_UART_TX",
+			  "HST_BT_UART_RX",
+			  "HST_WLAN_EN", /* GPIO_20 */
+			  "HST_BT_EN",
+			  "RGBC_IR_PWR_EN",
+			  "FP_INT_N",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NFC_ESE_SPI_MISO",
+			  "NFC_ESE_SPI_MOSI",
+			  "NFC_ESE_SPI_SCLK", /* GPIO_30 */
+			  "NFC_ESE_SPI_CS_N",
+			  "WCD_RST_N",
+			  "NC",
+			  "SDM_DEBUG_UART_TX",
+			  "SDM_DEBUG_UART_RX",
+			  "TS_I2C_SDA",
+			  "TS_I2C_SCL",
+			  "TS_INT_N",
+			  "FP_SPI_MISO", /* GPIO_40 */
+			  "FP_SPI_MOSI",
+			  "FP_SPI_SCLK",
+			  "FP_SPI_CS_N",
+			  "APPS_I2C_0_SDA",
+			  "APPS_I2C_0_SCL",
+			  "DISP_ERR_FG",
+			  "UIM2_DETECT_EN",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_50 */
+			  "NC",
+			  "MDM_UART_CTS",
+			  "MDM_UART_RFR",
+			  "MDM_UART_TX",
+			  "MDM_UART_RX",
+			  "AP2MDM_STATUS",
+			  "AP2MDM_ERR_FATAL",
+			  "MDM_IPC_HS_UART_TX",
+			  "MDM_IPC_HS_UART_RX",
+			  "NC", /* GPIO_60 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "USB_CC_DIR",
+			  "DISP_VSYNC",
+			  "NC",
+			  "NC",
+			  "CAM_PWR_B_CS",
+			  "NC", /* GPIO_70 */
+			  "CAM_PWR_A_CS",
+			  "SBU_SW_SEL",
+			  "SBU_SW_OE",
+			  "FP_RESET_N",
+			  "FP_RESET_N",
+			  "DISP_RESET_N",
+			  "DEBUG_GPIO0",
+			  "TRAY_DET",
+			  "CAM2_RST_N",
+			  "PCIE0_RST_N",
+			  "PCIE0_CLK_REQ_N", /* GPIO_80 */
+			  "PCIE0_WAKE_N",
+			  "DVDT_ENABLE",
+			  "DVDT_WRT_DET_OR",
+			  "NC",
+			  "PCIE2_RST_N",
+			  "PCIE2_CLK_REQ_N",
+			  "PCIE2_WAKE_N",
+			  "MDM_VFR_IRQ0",
+			  "MDM_VFR_IRQ1",
+			  "SW_SERVICE", /* GPIO_90 */
+			  "CAM_SOF",
+			  "CAM1_RST_N",
+			  "CAM0_RST_N",
+			  "CAM0_MCLK",
+			  "CAM1_MCLK",
+			  "CAM2_MCLK",
+			  "CAM3_MCLK",
+			  "CAM4_MCLK",
+			  "TOF_RST_N",
+			  "NC", /* GPIO_100 */
+			  "CCI0_I2C_SDA",
+			  "CCI0_I2C_SCL",
+			  "CCI1_I2C_SDA",
+			  "CCI1_I2C_SCL_",
+			  "CCI2_I2C_SDA",
+			  "CCI2_I2C_SCL",
+			  "CCI3_I2C_SDA",
+			  "CCI3_I2C_SCL",
+			  "CAM3_RST_N",
+			  "NFC_DWL_REQ", /* GPIO_110 */
+			  "NFC_IRQ",
+			  "XVS",
+			  "NC",
+			  "RF_ID_EXTENSION",
+			  "SPK_AMP_I2C_SDA",
+			  "SPK_AMP_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "WLC_I2C_SDA",
+			  "WLC_I2C_SCL", /* GPIO_120 */
+			  "ACC_COVER_OPEN",
+			  "ALS_PROX_INT_N",
+			  "ACCEL_INT",
+			  "WLAN_SW_CTRL",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "UDON_SWITCH_SEL",
+			  "WDOG_DISABLE",
+			  "BAROMETER_INT",
+			  "NC", /* GPIO_130 */
+			  "NC",
+			  "FORCED_USB_BOOT",
+			  "NC",
+			  "NC",
+			  "WLC_INT_N",
+			  "NC",
+			  "NC",
+			  "RGBC_IR_INT",
+			  "NC",
+			  "NC", /* GPIO_140 */
+			  "NC",
+			  "BT_SLIMBUS_CLK",
+			  "BT_SLIMBUS_DATA",
+			  "HW_ID_0",
+			  "HW_ID_1",
+			  "WCD_SWR_TX_CLK",
+			  "WCD_SWR_TX_DATA0",
+			  "WCD_SWR_TX_DATA1",
+			  "WCD_SWR_RX_CLK",
+			  "WCD_SWR_RX_DATA0", /* GPIO_150 */
+			  "WCD_SWR_RX_DATA1",
+			  "SDM_DMIC_CLK1",
+			  "SDM_DMIC_DATA1",
+			  "SDM_DMIC_CLK2",
+			  "SDM_DMIC_DATA2",
+			  "SPK_AMP_I2S_CLK",
+			  "SPK_AMP_I2S_WS",
+			  "SPK_AMP_I2S_ASP_DIN",
+			  "SPK_AMP_I2S_ASP_DOUT",
+			  "COMPASS_I2C_SDA", /* GPIO_160 */
+			  "COMPASS_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "SSC_SPI_1_MISO",
+			  "SSC_SPI_1_MOSI",
+			  "SSC_SPI_1_CLK",
+			  "SSC_SPI_1_CS_N",
+			  "NC",
+			  "NC",
+			  "SSC_SENSOR_I2C_SDA", /* GPIO_170 */
+			  "SSC_SENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "HST_BLE_SNS_UART6_TX",
+			  "HST_BLE_SNS_UART6_RX",
+			  "HST_WLAN_UART_TX",
+			  "HST_WLAN_UART_RX";
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
index 16c96e8385348..bf4e6a32736de 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
@@ -29,6 +29,189 @@ g-assist-key {
 	};
 };
 
+&tlmm {
+	gpio-line-names = "AP_CTI_IN", /* GPIO_0 */
+			  "MDM2AP_ERR_FATAL",
+			  "AP_CTI_OUT",
+			  "MDM2AP_STATUS",
+			  "NFC_I2C_SDA",
+			  "NFC_I2C_SCL",
+			  "NFC_EN",
+			  "NFC_CLK_REQ",
+			  "NFC_ESE_PWR_REQ",
+			  "DVDT_WRT_DET_AND",
+			  "SPK_AMP_RESET_N", /* GPIO_10 */
+			  "SPK_AMP_INT_N",
+			  "APPS_I2C_1_SDA",
+			  "APPS_I2C_1_SCL",
+			  "NC",
+			  "TX_GTR_THRES_IN",
+			  "HST_BT_UART_CTS",
+			  "HST_BT_UART_RFR",
+			  "HST_BT_UART_TX",
+			  "HST_BT_UART_RX",
+			  "HST_WLAN_EN", /* GPIO_20 */
+			  "HST_BT_EN",
+			  "RGBC_IR_PWR_EN",
+			  "FP_INT_N",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NFC_ESE_SPI_MISO",
+			  "NFC_ESE_SPI_MOSI",
+			  "NFC_ESE_SPI_SCLK", /* GPIO_30 */
+			  "NFC_ESE_SPI_CS_N",
+			  "WCD_RST_N",
+			  "NC",
+			  "SDM_DEBUG_UART_TX",
+			  "SDM_DEBUG_UART_RX",
+			  "TS_I2C_SDA",
+			  "TS_I2C_SCL",
+			  "TS_INT_N",
+			  "FP_SPI_MISO", /* GPIO_40 */
+			  "FP_SPI_MOSI",
+			  "FP_SPI_SCLK",
+			  "FP_SPI_CS_N",
+			  "APPS_I2C_0_SDA",
+			  "APPS_I2C_0_SCL",
+			  "DISP_ERR_FG",
+			  "UIM2_DETECT_EN",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_50 */
+			  "NC",
+			  "MDM_UART_CTS",
+			  "MDM_UART_RFR",
+			  "MDM_UART_TX",
+			  "MDM_UART_RX",
+			  "AP2MDM_STATUS",
+			  "AP2MDM_ERR_FATAL",
+			  "MDM_IPC_HS_UART_TX",
+			  "MDM_IPC_HS_UART_RX",
+			  "NC", /* GPIO_60 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "USB_CC_DIR",
+			  "DISP_VSYNC",
+			  "NC",
+			  "NC",
+			  "CAM_PWR_B_CS",
+			  "NC", /* GPIO_70 */
+			  "FRONTC_PWR_EN",
+			  "SBU_SW_SEL",
+			  "SBU_SW_OE",
+			  "FP_RESET_N",
+			  "FP_RESET_N",
+			  "DISP_RESET_N",
+			  "DEBUG_GPIO0",
+			  "TRAY_DET",
+			  "CAM2_RST_N",
+			  "PCIE0_RST_N",
+			  "PCIE0_CLK_REQ_N", /* GPIO_80 */
+			  "PCIE0_WAKE_N",
+			  "DVDT_ENABLE",
+			  "DVDT_WRT_DET_OR",
+			  "NC",
+			  "PCIE2_RST_N",
+			  "PCIE2_CLK_REQ_N",
+			  "PCIE2_WAKE_N",
+			  "MDM_VFR_IRQ0",
+			  "MDM_VFR_IRQ1",
+			  "SW_SERVICE", /* GPIO_90 */
+			  "CAM_SOF",
+			  "CAM1_RST_N",
+			  "CAM0_RST_N",
+			  "CAM0_MCLK",
+			  "CAM1_MCLK",
+			  "CAM2_MCLK",
+			  "CAM3_MCLK",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_100 */
+			  "CCI0_I2C_SDA",
+			  "CCI0_I2C_SCL",
+			  "CCI1_I2C_SDA",
+			  "CCI1_I2C_SCL_",
+			  "CCI2_I2C_SDA",
+			  "CCI2_I2C_SCL",
+			  "CCI3_I2C_SDA",
+			  "CCI3_I2C_SCL",
+			  "CAM3_RST_N",
+			  "NFC_DWL_REQ", /* GPIO_110 */
+			  "NFC_IRQ",
+			  "XVS",
+			  "NC",
+			  "RF_ID_EXTENSION",
+			  "SPK_AMP_I2C_SDA",
+			  "SPK_AMP_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "ACC_COVER_OPEN",
+			  "ALS_PROX_INT_N",
+			  "ACCEL_INT",
+			  "WLAN_SW_CTRL",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "UDON_SWITCH_SEL",
+			  "WDOG_DISABLE",
+			  "BAROMETER_INT",
+			  "NC", /* GPIO_130 */
+			  "NC",
+			  "FORCED_USB_BOOT",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "RGBC_IR_INT",
+			  "NC",
+			  "NC", /* GPIO_140 */
+			  "NC",
+			  "BT_SLIMBUS_CLK",
+			  "BT_SLIMBUS_DATA",
+			  "HW_ID_0",
+			  "HW_ID_1",
+			  "WCD_SWR_TX_CLK",
+			  "WCD_SWR_TX_DATA0",
+			  "WCD_SWR_TX_DATA1",
+			  "WCD_SWR_RX_CLK",
+			  "WCD_SWR_RX_DATA0", /* GPIO_150 */
+			  "WCD_SWR_RX_DATA1",
+			  "SDM_DMIC_CLK1",
+			  "SDM_DMIC_DATA1",
+			  "SDM_DMIC_CLK2",
+			  "SDM_DMIC_DATA2",
+			  "SPK_AMP_I2S_CLK",
+			  "SPK_AMP_I2S_WS",
+			  "SPK_AMP_I2S_ASP_DIN",
+			  "SPK_AMP_I2S_ASP_DOUT",
+			  "COMPASS_I2C_SDA", /* GPIO_160 */
+			  "COMPASS_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "SSC_SPI_1_MISO",
+			  "SSC_SPI_1_MOSI",
+			  "SSC_SPI_1_CLK",
+			  "SSC_SPI_1_CS_N",
+			  "NC",
+			  "NC",
+			  "SSC_SENSOR_I2C_SDA", /* GPIO_170 */
+			  "SSC_SENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "HST_BLE_SNS_UART6_TX",
+			  "HST_BLE_SNS_UART6_RX",
+			  "HST_WLAN_UART_TX",
+			  "HST_WLAN_UART_RX";
+};
+
 &vreg_l2f_1p3 {
 	regulator-min-microvolt = <1200000>;
 	regulator-max-microvolt = <1200000>;
-- 
2.40.1



