Return-Path: <stable+bounces-54465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317B990EE53
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96709B2578E
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D47314A0A0;
	Wed, 19 Jun 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CXNhQBbU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237861494BD;
	Wed, 19 Jun 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803660; cv=none; b=gvOpP9QpO7O+bZq7GPmvjE45esjjlU0idmpil3A0/9Vd3a71tMwaMqj6WBkVMTHUrJh1smvOO98hn92fzf5+k9hPxEYgsvkOwxXKgC6phZOz3T26/ztLMFC2cb5a87FABfhZh+T2KBobxGWauKilJv3e/KKLmi2WApGwEZTkWQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803660; c=relaxed/simple;
	bh=+eC1FQj2/CIFL5CIjFe9PVkJPk58BlmR9rub/UX8L4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3C9gX4ylno8qnc29VohhpdwXW+2M4Bd2eJq2pAbf2DVaY28Xhgz5Nz2/2pN6YvwA1bDz0wpg82dhypGweNmpPTBdMr31sE3APmQ6c9Jhi3KRsR6GxyUHe/QiF7dSHzlx11Pku61eOgpPl8mxhqu2sZGODF3BY2aCj6ThSQpyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CXNhQBbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F3BC2BBFC;
	Wed, 19 Jun 2024 13:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803660;
	bh=+eC1FQj2/CIFL5CIjFe9PVkJPk58BlmR9rub/UX8L4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CXNhQBbU22oHK++HlsoIsevlwmgEcr9VoszzcseCs4OrzGvGKzh2cq8v0xa3nhy4X
	 Zgkf1Bs1CPj4u4NlkMq632rOAhec/aXR005W9vHGvLe/CFce7kwmQa17KWQSGCcN1H
	 O3+2x8EZ+69x5h1iVz0XMKwJyJVyMXPcpRYnVLYM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 060/217] arm64: dts: qcom: sm8150: align TLMM pin configuration with DT schema
Date: Wed, 19 Jun 2024 14:55:03 +0200
Message-ID: <20240619125559.002311273@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 028fe09cda0a0d568e6a7d65b0336d32600b480c ]

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20221006144518.256956-1-krzysztof.kozlowski@linaro.org
Stable-dep-of: 819fe8c96a51 ("arm64: dts: qcom: sa8155p-adp: fix SDHC2 CD pin configuration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts      |  60 ++-
 .../dts/qcom/sm8150-microsoft-surface-duo.dts |   2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 376 ++++++------------
 3 files changed, 157 insertions(+), 281 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index 4dee790f1049d..01ac460d910ec 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -488,26 +488,26 @@ &pcie1_phy {
 &tlmm {
 	gpio-reserved-ranges = <0 4>;
 
-	sdc2_on: sdc2_on {
-		clk {
+	sdc2_on: sdc2-on-state {
+		clk-pins {
 			pins = "sdc2_clk";
 			bias-disable;		/* No pull */
 			drive-strength = <16>;	/* 16 MA */
 		};
 
-		cmd {
+		cmd-pins {
 			pins = "sdc2_cmd";
 			bias-pull-up;		/* pull up */
 			drive-strength = <16>;	/* 16 MA */
 		};
 
-		data {
+		data-pins {
 			pins = "sdc2_data";
 			bias-pull-up;		/* pull up */
 			drive-strength = <16>;	/* 16 MA */
 		};
 
-		sd-cd {
+		sd-cd-pins {
 			pins = "gpio96";
 			function = "gpio";
 			bias-pull-up;		/* pull up */
@@ -515,26 +515,26 @@ sd-cd {
 		};
 	};
 
-	sdc2_off: sdc2_off {
-		clk {
+	sdc2_off: sdc2-off-state {
+		clk-pins {
 			pins = "sdc2_clk";
 			bias-disable;		/* No pull */
 			drive-strength = <2>;	/* 2 MA */
 		};
 
-		cmd {
+		cmd-pins {
 			pins = "sdc2_cmd";
 			bias-pull-up;		/* pull up */
 			drive-strength = <2>;	/* 2 MA */
 		};
 
-		data {
+		data-pins {
 			pins = "sdc2_data";
 			bias-pull-up;		/* pull up */
 			drive-strength = <2>;	/* 2 MA */
 		};
 
-		sd-cd {
+		sd-cd-pins {
 			pins = "gpio96";
 			function = "gpio";
 			bias-pull-up;		/* pull up */
@@ -542,66 +542,62 @@ sd-cd {
 		};
 	};
 
-	usb2phy_ac_en1_default: usb2phy_ac_en1_default {
-		mux {
-			pins = "gpio113";
-			function = "usb2phy_ac";
-			bias-disable;
-			drive-strength = <2>;
-		};
+	usb2phy_ac_en1_default: usb2phy-ac-en1-default-state {
+		pins = "gpio113";
+		function = "usb2phy_ac";
+		bias-disable;
+		drive-strength = <2>;
 	};
 
-	usb2phy_ac_en2_default: usb2phy_ac_en2_default {
-		mux {
-			pins = "gpio123";
-			function = "usb2phy_ac";
-			bias-disable;
-			drive-strength = <2>;
-		};
+	usb2phy_ac_en2_default: usb2phy-ac-en2-default-state {
+		pins = "gpio123";
+		function = "usb2phy_ac";
+		bias-disable;
+		drive-strength = <2>;
 	};
 
-	ethernet_defaults: ethernet-defaults {
-		mdc {
+	ethernet_defaults: ethernet-defaults-state {
+		mdc-pins {
 			pins = "gpio7";
 			function = "rgmii";
 			bias-pull-up;
 		};
 
-		mdio {
+		mdio-pins {
 			pins = "gpio59";
 			function = "rgmii";
 			bias-pull-up;
 		};
 
-		rgmii-rx {
+		rgmii-rx-pins {
 			pins = "gpio117", "gpio118", "gpio119", "gpio120", "gpio115", "gpio116";
 			function = "rgmii";
 			bias-disable;
 			drive-strength = <2>;
 		};
 
-		rgmii-tx {
+		rgmii-tx-pins {
 			pins = "gpio122", "gpio4", "gpio5", "gpio6", "gpio114", "gpio121";
 			function = "rgmii";
 			bias-pull-up;
 			drive-strength = <16>;
 		};
 
-		phy-intr {
+		phy-intr-pins {
 			pins = "gpio124";
 			function = "emac_phy";
 			bias-disable;
 			drive-strength = <8>;
 		};
 
-		pps {
+		pps-pins {
 			pins = "gpio81";
 			function = "emac_pps";
 			bias-disable;
 			drive-strength = <8>;
 		};
 
-		phy-reset {
+		phy-reset-pins {
 			pins = "gpio79";
 			function = "gpio";
 			bias-pull-up;
diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
index bb278ecac3faf..5397fba9417bb 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
@@ -475,7 +475,7 @@ &pon_resin {
 &tlmm {
 	gpio-reserved-ranges = <126 4>;
 
-	da7280_intr_default: da7280-intr-default {
+	da7280_intr_default: da7280-intr-default-state {
 		pins = "gpio42";
 		function = "gpio";
 		bias-pull-up;
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 9dccecd9fcaef..bbd322fc56460 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2284,422 +2284,302 @@ tlmm: pinctrl@3100000 {
 			#interrupt-cells = <2>;
 			wakeup-parent = <&pdc>;
 
-			qup_i2c0_default: qup-i2c0-default {
-				mux {
-					pins = "gpio0", "gpio1";
-					function = "qup0";
-				};
-
-				config {
-					pins = "gpio0", "gpio1";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c0_default: qup-i2c0-default-state {
+				pins = "gpio0", "gpio1";
+				function = "qup0";
+				drive-strength = <0x02>;
+				bias-disable;
 			};
 
-			qup_spi0_default: qup-spi0-default {
+			qup_spi0_default: qup-spi0-default-state {
 				pins = "gpio0", "gpio1", "gpio2", "gpio3";
 				function = "qup0";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c1_default: qup-i2c1-default {
-				mux {
-					pins = "gpio114", "gpio115";
-					function = "qup1";
-				};
-
-				config {
-					pins = "gpio114", "gpio115";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c1_default: qup-i2c1-default-state {
+				pins = "gpio114", "gpio115";
+				function = "qup1";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi1_default: qup-spi1-default {
+			qup_spi1_default: qup-spi1-default-state {
 				pins = "gpio114", "gpio115", "gpio116", "gpio117";
 				function = "qup1";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c2_default: qup-i2c2-default {
-				mux {
-					pins = "gpio126", "gpio127";
-					function = "qup2";
-				};
-
-				config {
-					pins = "gpio126", "gpio127";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c2_default: qup-i2c2-default-state {
+				pins = "gpio126", "gpio127";
+				function = "qup2";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi2_default: qup-spi2-default {
+			qup_spi2_default: qup-spi2-default-state {
 				pins = "gpio126", "gpio127", "gpio128", "gpio129";
 				function = "qup2";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c3_default: qup-i2c3-default {
-				mux {
-					pins = "gpio144", "gpio145";
-					function = "qup3";
-				};
-
-				config {
-					pins = "gpio144", "gpio145";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c3_default: qup-i2c3-default-state {
+				pins = "gpio144", "gpio145";
+				function = "qup3";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi3_default: qup-spi3-default {
+			qup_spi3_default: qup-spi3-default-state {
 				pins = "gpio144", "gpio145", "gpio146", "gpio147";
 				function = "qup3";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c4_default: qup-i2c4-default {
-				mux {
-					pins = "gpio51", "gpio52";
-					function = "qup4";
-				};
-
-				config {
-					pins = "gpio51", "gpio52";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c4_default: qup-i2c4-default-state {
+				pins = "gpio51", "gpio52";
+				function = "qup4";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi4_default: qup-spi4-default {
+			qup_spi4_default: qup-spi4-default-state {
 				pins = "gpio51", "gpio52", "gpio53", "gpio54";
 				function = "qup4";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c5_default: qup-i2c5-default {
-				mux {
-					pins = "gpio121", "gpio122";
-					function = "qup5";
-				};
-
-				config {
-					pins = "gpio121", "gpio122";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c5_default: qup-i2c5-default-state {
+				pins = "gpio121", "gpio122";
+				function = "qup5";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi5_default: qup-spi5-default {
+			qup_spi5_default: qup-spi5-default-state {
 				pins = "gpio119", "gpio120", "gpio121", "gpio122";
 				function = "qup5";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c6_default: qup-i2c6-default {
-				mux {
-					pins = "gpio6", "gpio7";
-					function = "qup6";
-				};
-
-				config {
-					pins = "gpio6", "gpio7";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c6_default: qup-i2c6-default-state {
+				pins = "gpio6", "gpio7";
+				function = "qup6";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi6_default: qup-spi6_default {
+			qup_spi6_default: qup-spi6_default-state {
 				pins = "gpio4", "gpio5", "gpio6", "gpio7";
 				function = "qup6";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c7_default: qup-i2c7-default {
-				mux {
-					pins = "gpio98", "gpio99";
-					function = "qup7";
-				};
-
-				config {
-					pins = "gpio98", "gpio99";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c7_default: qup-i2c7-default-state {
+				pins = "gpio98", "gpio99";
+				function = "qup7";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi7_default: qup-spi7_default {
+			qup_spi7_default: qup-spi7_default-state {
 				pins = "gpio98", "gpio99", "gpio100", "gpio101";
 				function = "qup7";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c8_default: qup-i2c8-default {
-				mux {
-					pins = "gpio88", "gpio89";
-					function = "qup8";
-				};
-
-				config {
-					pins = "gpio88", "gpio89";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c8_default: qup-i2c8-default-state {
+				pins = "gpio88", "gpio89";
+				function = "qup8";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi8_default: qup-spi8-default {
+			qup_spi8_default: qup-spi8-default-state {
 				pins = "gpio88", "gpio89", "gpio90", "gpio91";
 				function = "qup8";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c9_default: qup-i2c9-default {
-				mux {
-					pins = "gpio39", "gpio40";
-					function = "qup9";
-				};
-
-				config {
-					pins = "gpio39", "gpio40";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c9_default: qup-i2c9-default-state {
+				pins = "gpio39", "gpio40";
+				function = "qup9";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi9_default: qup-spi9-default {
+			qup_spi9_default: qup-spi9-default-state {
 				pins = "gpio39", "gpio40", "gpio41", "gpio42";
 				function = "qup9";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c10_default: qup-i2c10-default {
-				mux {
-					pins = "gpio9", "gpio10";
-					function = "qup10";
-				};
-
-				config {
-					pins = "gpio9", "gpio10";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c10_default: qup-i2c10-default-state {
+				pins = "gpio9", "gpio10";
+				function = "qup10";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi10_default: qup-spi10-default {
+			qup_spi10_default: qup-spi10-default-state {
 				pins = "gpio9", "gpio10", "gpio11", "gpio12";
 				function = "qup10";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c11_default: qup-i2c11-default {
-				mux {
-					pins = "gpio94", "gpio95";
-					function = "qup11";
-				};
-
-				config {
-					pins = "gpio94", "gpio95";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c11_default: qup-i2c11-default-state {
+				pins = "gpio94", "gpio95";
+				function = "qup11";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi11_default: qup-spi11-default {
+			qup_spi11_default: qup-spi11-default-state {
 				pins = "gpio92", "gpio93", "gpio94", "gpio95";
 				function = "qup11";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c12_default: qup-i2c12-default {
-				mux {
-					pins = "gpio83", "gpio84";
-					function = "qup12";
-				};
-
-				config {
-					pins = "gpio83", "gpio84";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c12_default: qup-i2c12-default-state {
+				pins = "gpio83", "gpio84";
+				function = "qup12";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi12_default: qup-spi12-default {
+			qup_spi12_default: qup-spi12-default-state {
 				pins = "gpio83", "gpio84", "gpio85", "gpio86";
 				function = "qup12";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c13_default: qup-i2c13-default {
-				mux {
-					pins = "gpio43", "gpio44";
-					function = "qup13";
-				};
-
-				config {
-					pins = "gpio43", "gpio44";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c13_default: qup-i2c13-default-state {
+				pins = "gpio43", "gpio44";
+				function = "qup13";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi13_default: qup-spi13-default {
+			qup_spi13_default: qup-spi13-default-state {
 				pins = "gpio43", "gpio44", "gpio45", "gpio46";
 				function = "qup13";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c14_default: qup-i2c14-default {
-				mux {
-					pins = "gpio47", "gpio48";
-					function = "qup14";
-				};
-
-				config {
-					pins = "gpio47", "gpio48";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c14_default: qup-i2c14-default-state {
+				pins = "gpio47", "gpio48";
+				function = "qup14";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi14_default: qup-spi14-default {
+			qup_spi14_default: qup-spi14-default-state {
 				pins = "gpio47", "gpio48", "gpio49", "gpio50";
 				function = "qup14";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c15_default: qup-i2c15-default {
-				mux {
-					pins = "gpio27", "gpio28";
-					function = "qup15";
-				};
-
-				config {
-					pins = "gpio27", "gpio28";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c15_default: qup-i2c15-default-state {
+				pins = "gpio27", "gpio28";
+				function = "qup15";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi15_default: qup-spi15-default {
+			qup_spi15_default: qup-spi15-default-state {
 				pins = "gpio27", "gpio28", "gpio29", "gpio30";
 				function = "qup15";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c16_default: qup-i2c16-default {
-				mux {
-					pins = "gpio86", "gpio85";
-					function = "qup16";
-				};
-
-				config {
-					pins = "gpio86", "gpio85";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c16_default: qup-i2c16-default-state {
+				pins = "gpio86", "gpio85";
+				function = "qup16";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi16_default: qup-spi16-default {
+			qup_spi16_default: qup-spi16-default-state {
 				pins = "gpio83", "gpio84", "gpio85", "gpio86";
 				function = "qup16";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c17_default: qup-i2c17-default {
-				mux {
-					pins = "gpio55", "gpio56";
-					function = "qup17";
-				};
-
-				config {
-					pins = "gpio55", "gpio56";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c17_default: qup-i2c17-default-state {
+				pins = "gpio55", "gpio56";
+				function = "qup17";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi17_default: qup-spi17-default {
+			qup_spi17_default: qup-spi17-default-state {
 				pins = "gpio55", "gpio56", "gpio57", "gpio58";
 				function = "qup17";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c18_default: qup-i2c18-default {
-				mux {
-					pins = "gpio23", "gpio24";
-					function = "qup18";
-				};
-
-				config {
-					pins = "gpio23", "gpio24";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c18_default: qup-i2c18-default-state {
+				pins = "gpio23", "gpio24";
+				function = "qup18";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi18_default: qup-spi18-default {
+			qup_spi18_default: qup-spi18-default-state {
 				pins = "gpio23", "gpio24", "gpio25", "gpio26";
 				function = "qup18";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			qup_i2c19_default: qup-i2c19-default {
-				mux {
-					pins = "gpio57", "gpio58";
-					function = "qup19";
-				};
-
-				config {
-					pins = "gpio57", "gpio58";
-					drive-strength = <0x02>;
-					bias-disable;
-				};
+			qup_i2c19_default: qup-i2c19-default-state {
+				pins = "gpio57", "gpio58";
+				function = "qup19";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi19_default: qup-spi19-default {
+			qup_spi19_default: qup-spi19-default-state {
 				pins = "gpio55", "gpio56", "gpio57", "gpio58";
 				function = "qup19";
 				drive-strength = <6>;
 				bias-disable;
 			};
 
-			pcie0_default_state: pcie0-default {
-				perst {
+			pcie0_default_state: pcie0-default-state {
+				perst-pins {
 					pins = "gpio35";
 					function = "gpio";
 					drive-strength = <2>;
 					bias-pull-down;
 				};
 
-				clkreq {
+				clkreq-pins {
 					pins = "gpio36";
 					function = "pci_e0";
 					drive-strength = <2>;
 					bias-pull-up;
 				};
 
-				wake {
+				wake-pins {
 					pins = "gpio37";
 					function = "gpio";
 					drive-strength = <2>;
@@ -2707,22 +2587,22 @@ wake {
 				};
 			};
 
-			pcie1_default_state: pcie1-default {
-				perst {
+			pcie1_default_state: pcie1-default-state {
+				perst-pins {
 					pins = "gpio102";
 					function = "gpio";
 					drive-strength = <2>;
 					bias-pull-down;
 				};
 
-				clkreq {
+				clkreq-pins {
 					pins = "gpio103";
 					function = "pci_e1";
 					drive-strength = <2>;
 					bias-pull-up;
 				};
 
-				wake {
+				wake-pins {
 					pins = "gpio104";
 					function = "gpio";
 					drive-strength = <2>;
-- 
2.43.0




