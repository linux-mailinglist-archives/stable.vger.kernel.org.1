Return-Path: <stable+bounces-6320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4756880DA10
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7B21F21C94
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A20524C4;
	Mon, 11 Dec 2023 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vpbu0OV6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9952F8A;
	Mon, 11 Dec 2023 18:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C15FC433C9;
	Mon, 11 Dec 2023 18:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702321110;
	bh=82CFL+zOt9uXyhlYa+xShGlLOlwZk+rPMBYYUJC390o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vpbu0OV66tL+RWKxPlN2y/pEgoKXKxbbShmFz7uCCHjfZYk6ou8vbHN3uR+5pVEnP
	 8EIYb/8oiA18vAx6ktQ88g2PW8Vod/1ddhYklGBD6rlCMbrp7fJjl1Kcrz7W8FpFZX
	 XRwJZ88zqJXEulPKh9Iqi24fgpH6qIM0RIJQdqJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 114/141] arm64: dts: mediatek: add missing space before {
Date: Mon, 11 Dec 2023 19:22:53 +0100
Message-ID: <20231211182031.487943159@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit a9c740c57f977deb41bc53c02d0dae3d0e2f191a ]

Add missing whitespace between node name/label and opening {.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230705150006.293690-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Stable-dep-of: 8980c30141d3 ("arm64: dts: mt8183: kukui: Fix underscores in node names")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   | 48 +++++++++----------
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 12 ++---
 .../boot/dts/mediatek/mt8183-pumpkin.dts      | 12 ++---
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index 3023bef2200aa..69aee79d36d48 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -131,8 +131,8 @@ &mmc1 {
 };
 
 &pio {
-	i2c_pins_0: i2c0{
-		pins_i2c{
+	i2c_pins_0: i2c0 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
 				 <PINMUX_GPIO83__FUNC_SCL0>;
 			mediatek,pull-up-adv = <3>;
@@ -140,8 +140,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_1: i2c1{
-		pins_i2c{
+	i2c_pins_1: i2c1 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
 				 <PINMUX_GPIO84__FUNC_SCL1>;
 			mediatek,pull-up-adv = <3>;
@@ -149,8 +149,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_2: i2c2{
-		pins_i2c{
+	i2c_pins_2: i2c2 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO103__FUNC_SCL2>,
 				 <PINMUX_GPIO104__FUNC_SDA2>;
 			mediatek,pull-up-adv = <3>;
@@ -158,8 +158,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_3: i2c3{
-		pins_i2c{
+	i2c_pins_3: i2c3 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
 				 <PINMUX_GPIO51__FUNC_SDA3>;
 			mediatek,pull-up-adv = <3>;
@@ -167,8 +167,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_4: i2c4{
-		pins_i2c{
+	i2c_pins_4: i2c4 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO105__FUNC_SCL4>,
 				 <PINMUX_GPIO106__FUNC_SDA4>;
 			mediatek,pull-up-adv = <3>;
@@ -176,8 +176,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_5: i2c5{
-		pins_i2c{
+	i2c_pins_5: i2c5 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
 				 <PINMUX_GPIO49__FUNC_SDA5>;
 			mediatek,pull-up-adv = <3>;
@@ -185,8 +185,8 @@ pins_i2c{
 		};
 	};
 
-	spi_pins_0: spi0{
-		pins_spi{
+	spi_pins_0: spi0 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
 				 <PINMUX_GPIO86__FUNC_SPI0_CSB>,
 				 <PINMUX_GPIO87__FUNC_SPI0_MO>,
@@ -300,8 +300,8 @@ pins_clk {
 		};
 	};
 
-	spi_pins_1: spi1{
-		pins_spi{
+	spi_pins_1: spi1 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO161__FUNC_SPI1_A_MI>,
 				 <PINMUX_GPIO162__FUNC_SPI1_A_CSB>,
 				 <PINMUX_GPIO163__FUNC_SPI1_A_MO>,
@@ -310,8 +310,8 @@ pins_spi{
 		};
 	};
 
-	spi_pins_2: spi2{
-		pins_spi{
+	spi_pins_2: spi2 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO0__FUNC_SPI2_CSB>,
 				 <PINMUX_GPIO1__FUNC_SPI2_MO>,
 				 <PINMUX_GPIO2__FUNC_SPI2_CLK>,
@@ -320,8 +320,8 @@ pins_spi{
 		};
 	};
 
-	spi_pins_3: spi3{
-		pins_spi{
+	spi_pins_3: spi3 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO21__FUNC_SPI3_MI>,
 				 <PINMUX_GPIO22__FUNC_SPI3_CSB>,
 				 <PINMUX_GPIO23__FUNC_SPI3_MO>,
@@ -330,8 +330,8 @@ pins_spi{
 		};
 	};
 
-	spi_pins_4: spi4{
-		pins_spi{
+	spi_pins_4: spi4 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO17__FUNC_SPI4_MI>,
 				 <PINMUX_GPIO18__FUNC_SPI4_CSB>,
 				 <PINMUX_GPIO19__FUNC_SPI4_MO>,
@@ -340,8 +340,8 @@ pins_spi{
 		};
 	};
 
-	spi_pins_5: spi5{
-		pins_spi{
+	spi_pins_5: spi5 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO13__FUNC_SPI5_MI>,
 				 <PINMUX_GPIO14__FUNC_SPI5_CSB>,
 				 <PINMUX_GPIO15__FUNC_SPI5_MO>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 5950601813196..bc583a1da9060 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -619,7 +619,7 @@ pins_scp_uart {
 	};
 
 	spi0_pins: spi0 {
-		pins_spi{
+		pins_spi {
 			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
 				 <PINMUX_GPIO86__FUNC_GPIO86>,
 				 <PINMUX_GPIO87__FUNC_SPI0_MO>,
@@ -629,7 +629,7 @@ pins_spi{
 	};
 
 	spi1_pins: spi1 {
-		pins_spi{
+		pins_spi {
 			pinmux = <PINMUX_GPIO161__FUNC_SPI1_A_MI>,
 				 <PINMUX_GPIO162__FUNC_SPI1_A_CSB>,
 				 <PINMUX_GPIO163__FUNC_SPI1_A_MO>,
@@ -639,7 +639,7 @@ pins_spi{
 	};
 
 	spi2_pins: spi2 {
-		pins_spi{
+		pins_spi {
 			pinmux = <PINMUX_GPIO0__FUNC_SPI2_CSB>,
 				 <PINMUX_GPIO1__FUNC_SPI2_MO>,
 				 <PINMUX_GPIO2__FUNC_SPI2_CLK>;
@@ -652,7 +652,7 @@ pins_spi_mi {
 	};
 
 	spi3_pins: spi3 {
-		pins_spi{
+		pins_spi {
 			pinmux = <PINMUX_GPIO21__FUNC_SPI3_MI>,
 				 <PINMUX_GPIO22__FUNC_SPI3_CSB>,
 				 <PINMUX_GPIO23__FUNC_SPI3_MO>,
@@ -662,7 +662,7 @@ pins_spi{
 	};
 
 	spi4_pins: spi4 {
-		pins_spi{
+		pins_spi {
 			pinmux = <PINMUX_GPIO17__FUNC_SPI4_MI>,
 				 <PINMUX_GPIO18__FUNC_SPI4_CSB>,
 				 <PINMUX_GPIO19__FUNC_SPI4_MO>,
@@ -672,7 +672,7 @@ pins_spi{
 	};
 
 	spi5_pins: spi5 {
-		pins_spi{
+		pins_spi {
 			pinmux = <PINMUX_GPIO13__FUNC_SPI5_MI>,
 				 <PINMUX_GPIO14__FUNC_SPI5_CSB>,
 				 <PINMUX_GPIO15__FUNC_SPI5_MO>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index ee912825cfc60..b7f3c266d3dd2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -165,7 +165,7 @@ &mmc1 {
 
 &pio {
 	i2c_pins_0: i2c0 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
 				 <PINMUX_GPIO83__FUNC_SCL0>;
 			mediatek,pull-up-adv = <3>;
@@ -174,7 +174,7 @@ pins_i2c{
 	};
 
 	i2c_pins_1: i2c1 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
 				 <PINMUX_GPIO84__FUNC_SCL1>;
 			mediatek,pull-up-adv = <3>;
@@ -183,7 +183,7 @@ pins_i2c{
 	};
 
 	i2c_pins_2: i2c2 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO103__FUNC_SCL2>,
 				 <PINMUX_GPIO104__FUNC_SDA2>;
 			mediatek,pull-up-adv = <3>;
@@ -192,7 +192,7 @@ pins_i2c{
 	};
 
 	i2c_pins_3: i2c3 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
 				 <PINMUX_GPIO51__FUNC_SDA3>;
 			mediatek,pull-up-adv = <3>;
@@ -201,7 +201,7 @@ pins_i2c{
 	};
 
 	i2c_pins_4: i2c4 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO105__FUNC_SCL4>,
 				 <PINMUX_GPIO106__FUNC_SDA4>;
 			mediatek,pull-up-adv = <3>;
@@ -210,7 +210,7 @@ pins_i2c{
 	};
 
 	i2c_pins_5: i2c5 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
 				 <PINMUX_GPIO49__FUNC_SDA5>;
 			mediatek,pull-up-adv = <3>;
-- 
2.42.0




