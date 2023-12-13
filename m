Return-Path: <stable+bounces-5842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A78580D770
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1841C21437
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED386537F2;
	Mon, 11 Dec 2023 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w12KarOM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADDC524CF;
	Mon, 11 Dec 2023 18:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303FFC433C8;
	Mon, 11 Dec 2023 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319812;
	bh=cFL2JlvVvZXwynxobGN+oJvMGNujdPwiA+o+FP8+2TU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w12KarOMbOwdiKwHkdZlIGqbRKdRjPcWB+N2XPG6xWl5CnqyM+DfkZiktP7hPJ1i4
	 UddLviuSBbPTDh3SIzbd/qDosqqHBB7OLOQENgW6lTjV+/7DUi8XovsIvPH5Lg2d5y
	 hjwQCdHIdUfiWp3Ft4zRCL0U8GfWPSvc1LUKC3DI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 202/244] arm64: dts: mediatek: add missing space before {
Date: Mon, 11 Dec 2023 19:21:35 +0100
Message-ID: <20231211182055.006408766@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index a27d906db7ea0..77f9ab94c00bd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -155,8 +155,8 @@ &mt6358_vsram_gpu_reg {
 };
 
 &pio {
-	i2c_pins_0: i2c0{
-		pins_i2c{
+	i2c_pins_0: i2c0 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
 				 <PINMUX_GPIO83__FUNC_SCL0>;
 			mediatek,pull-up-adv = <3>;
@@ -164,8 +164,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_1: i2c1{
-		pins_i2c{
+	i2c_pins_1: i2c1 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
 				 <PINMUX_GPIO84__FUNC_SCL1>;
 			mediatek,pull-up-adv = <3>;
@@ -173,8 +173,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_2: i2c2{
-		pins_i2c{
+	i2c_pins_2: i2c2 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO103__FUNC_SCL2>,
 				 <PINMUX_GPIO104__FUNC_SDA2>;
 			mediatek,pull-up-adv = <3>;
@@ -182,8 +182,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_3: i2c3{
-		pins_i2c{
+	i2c_pins_3: i2c3 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
 				 <PINMUX_GPIO51__FUNC_SDA3>;
 			mediatek,pull-up-adv = <3>;
@@ -191,8 +191,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_4: i2c4{
-		pins_i2c{
+	i2c_pins_4: i2c4 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO105__FUNC_SCL4>,
 				 <PINMUX_GPIO106__FUNC_SDA4>;
 			mediatek,pull-up-adv = <3>;
@@ -200,8 +200,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_5: i2c5{
-		pins_i2c{
+	i2c_pins_5: i2c5 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
 				 <PINMUX_GPIO49__FUNC_SDA5>;
 			mediatek,pull-up-adv = <3>;
@@ -209,8 +209,8 @@ pins_i2c{
 		};
 	};
 
-	spi_pins_0: spi0{
-		pins_spi{
+	spi_pins_0: spi0 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
 				 <PINMUX_GPIO86__FUNC_SPI0_CSB>,
 				 <PINMUX_GPIO87__FUNC_SPI0_MO>,
@@ -324,8 +324,8 @@ pins_clk {
 		};
 	};
 
-	spi_pins_1: spi1{
-		pins_spi{
+	spi_pins_1: spi1 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO161__FUNC_SPI1_A_MI>,
 				 <PINMUX_GPIO162__FUNC_SPI1_A_CSB>,
 				 <PINMUX_GPIO163__FUNC_SPI1_A_MO>,
@@ -334,8 +334,8 @@ pins_spi{
 		};
 	};
 
-	spi_pins_2: spi2{
-		pins_spi{
+	spi_pins_2: spi2 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO0__FUNC_SPI2_CSB>,
 				 <PINMUX_GPIO1__FUNC_SPI2_MO>,
 				 <PINMUX_GPIO2__FUNC_SPI2_CLK>,
@@ -344,8 +344,8 @@ pins_spi{
 		};
 	};
 
-	spi_pins_3: spi3{
-		pins_spi{
+	spi_pins_3: spi3 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO21__FUNC_SPI3_MI>,
 				 <PINMUX_GPIO22__FUNC_SPI3_CSB>,
 				 <PINMUX_GPIO23__FUNC_SPI3_MO>,
@@ -354,8 +354,8 @@ pins_spi{
 		};
 	};
 
-	spi_pins_4: spi4{
-		pins_spi{
+	spi_pins_4: spi4 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO17__FUNC_SPI4_MI>,
 				 <PINMUX_GPIO18__FUNC_SPI4_CSB>,
 				 <PINMUX_GPIO19__FUNC_SPI4_MO>,
@@ -364,8 +364,8 @@ pins_spi{
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
index a3add21602337..9a6bfa5882e31 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -692,7 +692,7 @@ pins_scp_uart {
 	};
 
 	spi0_pins: spi0 {
-		pins_spi{
+		pins_spi {
 			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
 				 <PINMUX_GPIO86__FUNC_GPIO86>,
 				 <PINMUX_GPIO87__FUNC_SPI0_MO>,
@@ -702,7 +702,7 @@ pins_spi{
 	};
 
 	spi1_pins: spi1 {
-		pins_spi{
+		pins_spi {
 			pinmux = <PINMUX_GPIO161__FUNC_SPI1_A_MI>,
 				 <PINMUX_GPIO162__FUNC_SPI1_A_CSB>,
 				 <PINMUX_GPIO163__FUNC_SPI1_A_MO>,
@@ -712,7 +712,7 @@ pins_spi{
 	};
 
 	spi2_pins: spi2 {
-		pins_spi{
+		pins_spi {
 			pinmux = <PINMUX_GPIO0__FUNC_SPI2_CSB>,
 				 <PINMUX_GPIO1__FUNC_SPI2_MO>,
 				 <PINMUX_GPIO2__FUNC_SPI2_CLK>;
@@ -725,7 +725,7 @@ pins_spi_mi {
 	};
 
 	spi3_pins: spi3 {
-		pins_spi{
+		pins_spi {
 			pinmux = <PINMUX_GPIO21__FUNC_SPI3_MI>,
 				 <PINMUX_GPIO22__FUNC_SPI3_CSB>,
 				 <PINMUX_GPIO23__FUNC_SPI3_MO>,
@@ -735,7 +735,7 @@ pins_spi{
 	};
 
 	spi4_pins: spi4 {
-		pins_spi{
+		pins_spi {
 			pinmux = <PINMUX_GPIO17__FUNC_SPI4_MI>,
 				 <PINMUX_GPIO18__FUNC_SPI4_CSB>,
 				 <PINMUX_GPIO19__FUNC_SPI4_MO>,
@@ -745,7 +745,7 @@ pins_spi{
 	};
 
 	spi5_pins: spi5 {
-		pins_spi{
+		pins_spi {
 			pinmux = <PINMUX_GPIO13__FUNC_SPI5_MI>,
 				 <PINMUX_GPIO14__FUNC_SPI5_CSB>,
 				 <PINMUX_GPIO15__FUNC_SPI5_MO>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index 526bcae7a3f8f..b5784a60c315d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -193,7 +193,7 @@ &mt6358_vsram_gpu_reg {
 
 &pio {
 	i2c_pins_0: i2c0 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
 				 <PINMUX_GPIO83__FUNC_SCL0>;
 			mediatek,pull-up-adv = <3>;
@@ -202,7 +202,7 @@ pins_i2c{
 	};
 
 	i2c_pins_1: i2c1 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
 				 <PINMUX_GPIO84__FUNC_SCL1>;
 			mediatek,pull-up-adv = <3>;
@@ -211,7 +211,7 @@ pins_i2c{
 	};
 
 	i2c_pins_2: i2c2 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO103__FUNC_SCL2>,
 				 <PINMUX_GPIO104__FUNC_SDA2>;
 			mediatek,pull-up-adv = <3>;
@@ -220,7 +220,7 @@ pins_i2c{
 	};
 
 	i2c_pins_3: i2c3 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
 				 <PINMUX_GPIO51__FUNC_SDA3>;
 			mediatek,pull-up-adv = <3>;
@@ -229,7 +229,7 @@ pins_i2c{
 	};
 
 	i2c_pins_4: i2c4 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO105__FUNC_SCL4>,
 				 <PINMUX_GPIO106__FUNC_SDA4>;
 			mediatek,pull-up-adv = <3>;
@@ -238,7 +238,7 @@ pins_i2c{
 	};
 
 	i2c_pins_5: i2c5 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
 				 <PINMUX_GPIO49__FUNC_SDA5>;
 			mediatek,pull-up-adv = <3>;
-- 
2.42.0




