Return-Path: <stable+bounces-5152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33E480B454
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 13:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F787281119
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA72A14A94;
	Sat,  9 Dec 2023 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HskG18VS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E6748C
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 12:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27350C433C8;
	Sat,  9 Dec 2023 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702126208;
	bh=utdfZ75KnDVJ1wq1+n5H02mKIC0Y/sVwvCXcMaqEoH4=;
	h=Subject:To:Cc:From:Date:From;
	b=HskG18VSiMLGXTIFF2ASeb+XH9e+Kcb7f/iix3Di8GSR0S3kRY0gLre+utSg397nw
	 uQPOZi58lCng8Ykpu/dTzRivrwM1kXG310b25jEtvMGiEBGmPJ2AnCKQQGmXwLpQ2x
	 qcRDQ4rnersruqkfq0VxmtluFhwK8z7Rmpk8BfvQ=
Subject: FAILED: patch "[PATCH] arm64: dts: mt8183: kukui: Fix underscores in node names" failed to apply to 5.15-stable tree
To: hsinyi@chromium.org,angelogioacchino.delregno@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Dec 2023 13:49:53 +0100
Message-ID: <2023120952-animosity-geometry-5d8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8980c30141d3986beab815d85762b9c67196ed72
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120952-animosity-geometry-5d8d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

8980c30141d3 ("arm64: dts: mt8183: kukui: Fix underscores in node names")
a9c740c57f97 ("arm64: dts: mediatek: add missing space before {")
d2bbd5d96b03 ("arm64: dts: mt8183: add kukui platform audio node")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8980c30141d3986beab815d85762b9c67196ed72 Mon Sep 17 00:00:00 2001
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Thu, 26 Oct 2023 12:09:10 -0700
Subject: [PATCH] arm64: dts: mt8183: kukui: Fix underscores in node names

Replace underscores with hyphens in pinctrl node names both for consistency
and to adhere to the bindings.

Cc: stable@vger.kernel.org
Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
Fixes: 1652dbf7363a ("arm64: dts: mt8183: add scp node")
Fixes: 27eaf34df364 ("arm64: dts: mt8183: config dsi node")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20231026191343.3345279-2-hsinyi@chromium.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index bf97b60ae4d1..06fde1a9aab7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -441,20 +441,20 @@ pins2 {
 	};
 
 	touchscreen_pins: touchscreen-pins {
-		touch_int_odl {
+		touch-int-odl {
 			pinmux = <PINMUX_GPIO155__FUNC_GPIO155>;
 			input-enable;
 			bias-pull-up;
 		};
 
-		touch_rst_l {
+		touch-rst-l {
 			pinmux = <PINMUX_GPIO156__FUNC_GPIO156>;
 			output-high;
 		};
 	};
 
 	trackpad_pins: trackpad-pins {
-		trackpad_int {
+		trackpad-int {
 			pinmux = <PINMUX_GPIO7__FUNC_GPIO7>;
 			input-enable;
 			bias-disable; /* pulled externally */
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 6e421e941e3a..7881a27be029 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -460,7 +460,7 @@ &mt6358_vsram_gpu_reg {
 
 &pio {
 	aud_pins_default: audiopins {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO97__FUNC_I2S2_MCK>,
 				<PINMUX_GPIO98__FUNC_I2S2_BCK>,
 				<PINMUX_GPIO101__FUNC_I2S2_LRCK>,
@@ -482,7 +482,7 @@ pins_bus {
 	};
 
 	aud_pins_tdm_out_on: audiotdmouton {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO169__FUNC_TDM_BCK_2ND>,
 				<PINMUX_GPIO170__FUNC_TDM_LRCK_2ND>,
 				<PINMUX_GPIO171__FUNC_TDM_DATA0_2ND>,
@@ -494,7 +494,7 @@ pins_bus {
 	};
 
 	aud_pins_tdm_out_off: audiotdmoutoff {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO169__FUNC_GPIO169>,
 				<PINMUX_GPIO170__FUNC_GPIO170>,
 				<PINMUX_GPIO171__FUNC_GPIO171>,
@@ -508,13 +508,13 @@ pins_bus {
 	};
 
 	bt_pins: bt-pins {
-		pins_bt_en {
+		pins-bt-en {
 			pinmux = <PINMUX_GPIO120__FUNC_GPIO120>;
 			output-low;
 		};
 	};
 
-	ec_ap_int_odl: ec_ap_int_odl {
+	ec_ap_int_odl: ec-ap-int-odl {
 		pins1 {
 			pinmux = <PINMUX_GPIO151__FUNC_GPIO151>;
 			input-enable;
@@ -522,7 +522,7 @@ pins1 {
 		};
 	};
 
-	h1_int_od_l: h1_int_od_l {
+	h1_int_od_l: h1-int-od-l {
 		pins1 {
 			pinmux = <PINMUX_GPIO153__FUNC_GPIO153>;
 			input-enable;
@@ -530,7 +530,7 @@ pins1 {
 	};
 
 	i2c0_pins: i2c0 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
 				 <PINMUX_GPIO83__FUNC_SCL0>;
 			mediatek,pull-up-adv = <3>;
@@ -539,7 +539,7 @@ pins_bus {
 	};
 
 	i2c1_pins: i2c1 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
 				 <PINMUX_GPIO84__FUNC_SCL1>;
 			mediatek,pull-up-adv = <3>;
@@ -548,7 +548,7 @@ pins_bus {
 	};
 
 	i2c2_pins: i2c2 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO103__FUNC_SCL2>,
 				 <PINMUX_GPIO104__FUNC_SDA2>;
 			bias-disable;
@@ -557,7 +557,7 @@ pins_bus {
 	};
 
 	i2c3_pins: i2c3 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
 				 <PINMUX_GPIO51__FUNC_SDA3>;
 			mediatek,pull-up-adv = <3>;
@@ -566,7 +566,7 @@ pins_bus {
 	};
 
 	i2c4_pins: i2c4 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO105__FUNC_SCL4>,
 				 <PINMUX_GPIO106__FUNC_SDA4>;
 			bias-disable;
@@ -575,7 +575,7 @@ pins_bus {
 	};
 
 	i2c5_pins: i2c5 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
 				 <PINMUX_GPIO49__FUNC_SDA5>;
 			mediatek,pull-up-adv = <3>;
@@ -584,7 +584,7 @@ pins_bus {
 	};
 
 	i2c6_pins: i2c6 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO11__FUNC_SCL6>,
 				 <PINMUX_GPIO12__FUNC_SDA6>;
 			bias-disable;
@@ -592,7 +592,7 @@ pins_bus {
 	};
 
 	mmc0_pins_default: mmc0-pins-default {
-		pins_cmd_dat {
+		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_DAT0>,
 				 <PINMUX_GPIO128__FUNC_MSDC0_DAT1>,
 				 <PINMUX_GPIO125__FUNC_MSDC0_DAT2>,
@@ -607,13 +607,13 @@ pins_cmd_dat {
 			mediatek,pull-up-adv = <01>;
 		};
 
-		pins_clk {
+		pins-clk {
 			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-down-adv = <10>;
 		};
 
-		pins_rst {
+		pins-rst {
 			pinmux = <PINMUX_GPIO133__FUNC_MSDC0_RSTB>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-down-adv = <01>;
@@ -621,7 +621,7 @@ pins_rst {
 	};
 
 	mmc0_pins_uhs: mmc0-pins-uhs {
-		pins_cmd_dat {
+		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_DAT0>,
 				 <PINMUX_GPIO128__FUNC_MSDC0_DAT1>,
 				 <PINMUX_GPIO125__FUNC_MSDC0_DAT2>,
@@ -636,19 +636,19 @@ pins_cmd_dat {
 			mediatek,pull-up-adv = <01>;
 		};
 
-		pins_clk {
+		pins-clk {
 			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-down-adv = <10>;
 		};
 
-		pins_ds {
+		pins-ds {
 			pinmux = <PINMUX_GPIO131__FUNC_MSDC0_DSL>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-down-adv = <10>;
 		};
 
-		pins_rst {
+		pins-rst {
 			pinmux = <PINMUX_GPIO133__FUNC_MSDC0_RSTB>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-up-adv = <01>;
@@ -656,7 +656,7 @@ pins_rst {
 	};
 
 	mmc1_pins_default: mmc1-pins-default {
-		pins_cmd_dat {
+		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO31__FUNC_MSDC1_CMD>,
 				 <PINMUX_GPIO32__FUNC_MSDC1_DAT0>,
 				 <PINMUX_GPIO34__FUNC_MSDC1_DAT1>,
@@ -666,7 +666,7 @@ pins_cmd_dat {
 			mediatek,pull-up-adv = <10>;
 		};
 
-		pins_clk {
+		pins-clk {
 			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
 			input-enable;
 			mediatek,pull-down-adv = <10>;
@@ -674,7 +674,7 @@ pins_clk {
 	};
 
 	mmc1_pins_uhs: mmc1-pins-uhs {
-		pins_cmd_dat {
+		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO31__FUNC_MSDC1_CMD>,
 				 <PINMUX_GPIO32__FUNC_MSDC1_DAT0>,
 				 <PINMUX_GPIO34__FUNC_MSDC1_DAT1>,
@@ -685,7 +685,7 @@ pins_cmd_dat {
 			mediatek,pull-up-adv = <10>;
 		};
 
-		pins_clk {
+		pins-clk {
 			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
 			drive-strength = <MTK_DRIVE_8mA>;
 			mediatek,pull-down-adv = <10>;
@@ -693,15 +693,15 @@ pins_clk {
 		};
 	};
 
-	panel_pins_default: panel_pins_default {
-		panel_reset {
+	panel_pins_default: panel-pins-default {
+		panel-reset {
 			pinmux = <PINMUX_GPIO45__FUNC_GPIO45>;
 			output-low;
 			bias-pull-up;
 		};
 	};
 
-	pwm0_pin_default: pwm0_pin_default {
+	pwm0_pin_default: pwm0-pin-default {
 		pins1 {
 			pinmux = <PINMUX_GPIO176__FUNC_GPIO176>;
 			output-high;
@@ -713,14 +713,14 @@ pins2 {
 	};
 
 	scp_pins: scp {
-		pins_scp_uart {
+		pins-scp-uart {
 			pinmux = <PINMUX_GPIO110__FUNC_TP_URXD1_AO>,
 				 <PINMUX_GPIO112__FUNC_TP_UTXD1_AO>;
 		};
 	};
 
 	spi0_pins: spi0 {
-		pins_spi {
+		pins-spi {
 			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
 				 <PINMUX_GPIO86__FUNC_GPIO86>,
 				 <PINMUX_GPIO87__FUNC_SPI0_MO>,
@@ -730,7 +730,7 @@ pins_spi {
 	};
 
 	spi1_pins: spi1 {
-		pins_spi {
+		pins-spi {
 			pinmux = <PINMUX_GPIO161__FUNC_SPI1_A_MI>,
 				 <PINMUX_GPIO162__FUNC_SPI1_A_CSB>,
 				 <PINMUX_GPIO163__FUNC_SPI1_A_MO>,
@@ -740,20 +740,20 @@ pins_spi {
 	};
 
 	spi2_pins: spi2 {
-		pins_spi {
+		pins-spi {
 			pinmux = <PINMUX_GPIO0__FUNC_SPI2_CSB>,
 				 <PINMUX_GPIO1__FUNC_SPI2_MO>,
 				 <PINMUX_GPIO2__FUNC_SPI2_CLK>;
 			bias-disable;
 		};
-		pins_spi_mi {
+		pins-spi-mi {
 			pinmux = <PINMUX_GPIO94__FUNC_SPI2_MI>;
 			mediatek,pull-down-adv = <00>;
 		};
 	};
 
 	spi3_pins: spi3 {
-		pins_spi {
+		pins-spi {
 			pinmux = <PINMUX_GPIO21__FUNC_SPI3_MI>,
 				 <PINMUX_GPIO22__FUNC_SPI3_CSB>,
 				 <PINMUX_GPIO23__FUNC_SPI3_MO>,
@@ -763,7 +763,7 @@ pins_spi {
 	};
 
 	spi4_pins: spi4 {
-		pins_spi {
+		pins-spi {
 			pinmux = <PINMUX_GPIO17__FUNC_SPI4_MI>,
 				 <PINMUX_GPIO18__FUNC_SPI4_CSB>,
 				 <PINMUX_GPIO19__FUNC_SPI4_MO>,
@@ -773,7 +773,7 @@ pins_spi {
 	};
 
 	spi5_pins: spi5 {
-		pins_spi {
+		pins-spi {
 			pinmux = <PINMUX_GPIO13__FUNC_SPI5_MI>,
 				 <PINMUX_GPIO14__FUNC_SPI5_CSB>,
 				 <PINMUX_GPIO15__FUNC_SPI5_MO>,
@@ -783,63 +783,63 @@ pins_spi {
 	};
 
 	uart0_pins_default: uart0-pins-default {
-		pins_rx {
+		pins-rx {
 			pinmux = <PINMUX_GPIO95__FUNC_URXD0>;
 			input-enable;
 			bias-pull-up;
 		};
-		pins_tx {
+		pins-tx {
 			pinmux = <PINMUX_GPIO96__FUNC_UTXD0>;
 		};
 	};
 
 	uart1_pins_default: uart1-pins-default {
-		pins_rx {
+		pins-rx {
 			pinmux = <PINMUX_GPIO121__FUNC_URXD1>;
 			input-enable;
 			bias-pull-up;
 		};
-		pins_tx {
+		pins-tx {
 			pinmux = <PINMUX_GPIO115__FUNC_UTXD1>;
 		};
-		pins_rts {
+		pins-rts {
 			pinmux = <PINMUX_GPIO47__FUNC_URTS1>;
 			output-enable;
 		};
-		pins_cts {
+		pins-cts {
 			pinmux = <PINMUX_GPIO46__FUNC_UCTS1>;
 			input-enable;
 		};
 	};
 
 	uart1_pins_sleep: uart1-pins-sleep {
-		pins_rx {
+		pins-rx {
 			pinmux = <PINMUX_GPIO121__FUNC_GPIO121>;
 			input-enable;
 			bias-pull-up;
 		};
-		pins_tx {
+		pins-tx {
 			pinmux = <PINMUX_GPIO115__FUNC_UTXD1>;
 		};
-		pins_rts {
+		pins-rts {
 			pinmux = <PINMUX_GPIO47__FUNC_URTS1>;
 			output-enable;
 		};
-		pins_cts {
+		pins-cts {
 			pinmux = <PINMUX_GPIO46__FUNC_UCTS1>;
 			input-enable;
 		};
 	};
 
 	wifi_pins_pwrseq: wifi-pins-pwrseq {
-		pins_wifi_enable {
+		pins-wifi-enable {
 			pinmux = <PINMUX_GPIO119__FUNC_GPIO119>;
 			output-low;
 		};
 	};
 
 	wifi_pins_wakeup: wifi-pins-wakeup {
-		pins_wifi_wakeup {
+		pins-wifi-wakeup {
 			pinmux = <PINMUX_GPIO113__FUNC_GPIO113>;
 			input-enable;
 		};


