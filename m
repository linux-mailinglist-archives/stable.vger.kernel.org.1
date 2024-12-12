Return-Path: <stable+bounces-102663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092B39EF3FB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F173419413A9
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B857A23A1AB;
	Thu, 12 Dec 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yBuG5csN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE522969B;
	Thu, 12 Dec 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022044; cv=none; b=hZDWgEalZoNFWrl8BTvwrfMmYTL3gMfsYKQ5npSkaChyx5nZRtLxo7GXHuwJSQ6Y+Mhotk1kVWeFemZHVtUIkavYyvAHd5K+LbEGQHa6+4/JAFkDoVEEfWCqdYFOtGXp4P4Yb3D71sbLdFUhW5/ZKsK956c6x5fJZVIPgcrsyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022044; c=relaxed/simple;
	bh=WcdgCSJtuZWHgwSLZ8NBkMGwqZLjIlaeX2QQPpqB37g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKEo83zZGf2SO9P0MMKvSlrJ+Bl/o/xS55KOZmlxJvvBBKn5AEUt7CmZsoD1SmumFe5hqRSdT4CbkQFcVRqv/WS+sLlzA/WAF0vm5Gm9TMG1sW+/QEy866D4ZGnXvYdfPNv10A0sxTnvtFNBPEGLfqG/sB0JT+LTxzAh2wDFh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yBuG5csN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78597C4CECE;
	Thu, 12 Dec 2024 16:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022044;
	bh=WcdgCSJtuZWHgwSLZ8NBkMGwqZLjIlaeX2QQPpqB37g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yBuG5csNCTwgvyFTErERRqTCaV9+3CRRDHyZ/YI9SFU1rI4NkVRDZ/BPXb8zTwzB3
	 FieW79Ld6tbFQp9eN3WhYJZRrrmQv8PywnPT1orzKt5X1+2k3e4ah0jgYmuxW9AEBN
	 s6lmmh//jyFXQKajX77WRbkGGs0hHfXS82of22wY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 132/565] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Fix DP bridge supply names
Date: Thu, 12 Dec 2024 15:55:27 +0100
Message-ID: <20241212144316.698668854@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit c4e8cf13f1740037483565d5b802764e2426515b ]

Some of the regulator supplies for the MIPI-DPI-to-DP bridge and their
associated nodes are incorrectly named. In particular, the 1.0V supply
was modeled as a 1.2V supply.

Fix all the incorrect names, and also fix the voltage of the 1.0V
regulator.

Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://lore.kernel.org/r/20241030070224.1006331-3-wenst@chromium.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index 5c6721371945c..80b91c9ac268b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -8,11 +8,13 @@
 #include <arm/cros-ec-keyboard.dtsi>
 
 / {
-	pp1200_mipibrdg: pp1200-mipibrdg {
+	pp1000_mipibrdg: pp1000-mipibrdg {
 		compatible = "regulator-fixed";
-		regulator-name = "pp1200_mipibrdg";
+		regulator-name = "pp1000_mipibrdg";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&pp1200_mipibrdg_en>;
+		pinctrl-0 = <&pp1000_mipibrdg_en>;
 
 		enable-active-high;
 		regulator-boot-on;
@@ -24,7 +26,7 @@ pp1800_mipibrdg: pp1800-mipibrdg {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1800_mipibrdg";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pp1800_lcd_en>;
+		pinctrl-0 = <&pp1800_mipibrdg_en>;
 
 		enable-active-high;
 		regulator-boot-on;
@@ -46,11 +48,11 @@ pp3300_panel: pp3300-panel {
 		gpio = <&pio 35 GPIO_ACTIVE_HIGH>;
 	};
 
-	vddio_mipibrdg: vddio-mipibrdg {
+	pp3300_mipibrdg: pp3300-mipibrdg {
 		compatible = "regulator-fixed";
-		regulator-name = "vddio_mipibrdg";
+		regulator-name = "pp3300_mipibrdg";
 		pinctrl-names = "default";
-		pinctrl-0 = <&vddio_mipibrdg_en>;
+		pinctrl-0 = <&pp3300_mipibrdg_en>;
 
 		enable-active-high;
 		regulator-boot-on;
@@ -152,9 +154,9 @@ anx_bridge: anx7625@58 {
 		panel_flags = <1>;
 		enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
-		vdd10-supply = <&pp1200_mipibrdg>;
+		vdd10-supply = <&pp1000_mipibrdg>;
 		vdd18-supply = <&pp1800_mipibrdg>;
-		vdd33-supply = <&vddio_mipibrdg>;
+		vdd33-supply = <&pp3300_mipibrdg>;
 
 		ports {
 			#address-cells = <1>;
@@ -397,14 +399,14 @@ &pio {
 		"",
 		"";
 
-	pp1200_mipibrdg_en: pp1200-mipibrdg-en {
+	pp1000_mipibrdg_en: pp1000-mipibrdg-en {
 		pins1 {
 			pinmux = <PINMUX_GPIO54__FUNC_GPIO54>;
 			output-low;
 		};
 	};
 
-	pp1800_lcd_en: pp1800-lcd-en {
+	pp1800_mipibrdg_en: pp1800-mipibrdg-en {
 		pins1 {
 			pinmux = <PINMUX_GPIO36__FUNC_GPIO36>;
 			output-low;
@@ -466,7 +468,7 @@ trackpad-int {
 		};
 	};
 
-	vddio_mipibrdg_en: vddio-mipibrdg-en {
+	pp3300_mipibrdg_en: pp3300-mipibrdg-en {
 		pins1 {
 			pinmux = <PINMUX_GPIO37__FUNC_GPIO37>;
 			output-low;
-- 
2.43.0




