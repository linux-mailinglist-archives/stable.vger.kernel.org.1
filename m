Return-Path: <stable+bounces-54818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DABE5912633
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 15:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D6B28ABCA
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C79155748;
	Fri, 21 Jun 2024 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HL3dLD8s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADCC1553B0;
	Fri, 21 Jun 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974784; cv=none; b=CKaQvzfLf3G0/fIfdq2GSZVHqTLqpvv10SxcZCzzCwtlbaDuUMrOwm2+uRUHkh2RJvz0VFAOKa6N0ertiU/7G66zrqM0CW8tr91b/7M8/T5fIM4C4reJF38jp5qfrAYrlyNZXef9WV1AL+WHFLAfOTU3INYn+nD8B+XbKmrFwZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974784; c=relaxed/simple;
	bh=SqEngIeeyFMldRNfspfAC7Nv1VH0sIPSlt03m8UAL20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usntI78fmkuZx6tBKI4ltRMnz2Hs4Krv0nBJYrGL055XMI7SYpg0we6BJJiCflhbXVHp+s+VAooQPMqC6larKB+RO95Fp+lcqsS4YOCXepTRopIlrRhRO8W0DrjFM5j07p/JPHnPPokU9d7pNnxWlHGlOflnlay7zkGmm/B0y7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HL3dLD8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFBEC4AF08;
	Fri, 21 Jun 2024 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718974784;
	bh=SqEngIeeyFMldRNfspfAC7Nv1VH0sIPSlt03m8UAL20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HL3dLD8sdkA1RLVGPEgzuOnefoQEXkWM7FB/wOApZhdB0MnyswE5I/oxNnXTckFPE
	 gCQBHqvk74rLOD24W+KdVRL0h1fqWaMy+Tv3Rr2p+/87Dcro/agJfuoR2HG1T7U3Fy
	 JjV6mkQigtnrq1/zKFRcERDZ4tVJE07SmIaMVRuA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.95
Date: Fri, 21 Jun 2024 14:59:34 +0200
Message-ID: <2024062133-barstool-unease-2591@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024062133-frigidly-swimmable-1f17@gregkh>
References: <2024062133-frigidly-swimmable-1f17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 6c21684b032e..b760de61167d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 94
+SUBLEVEL = 95
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index 4dee790f1049..cbec4c9f3102 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -372,6 +372,16 @@ rgmii_phy: phy@7 {
 	};
 };
 
+&pmm8155au_1_gpios {
+	pmm8155au_1_sdc2_cd: sdc2-cd-default-state {
+		pins = "gpio4";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		power-source = <0>;
+	};
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
@@ -389,10 +399,10 @@ &remoteproc_cdsp {
 &sdhc_2 {
 	status = "okay";
 
-	cd-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pmm8155au_1_gpios 4 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_on>;
-	pinctrl-1 = <&sdc2_off>;
+	pinctrl-0 = <&sdc2_on &pmm8155au_1_sdc2_cd>;
+	pinctrl-1 = <&sdc2_off &pmm8155au_1_sdc2_cd>;
 	vqmmc-supply = <&vreg_l13c_2p96>; /* IO line power */
 	vmmc-supply = <&vreg_l17a_2p96>;  /* Card power line */
 	bus-width = <4>;
@@ -488,120 +498,102 @@ &pcie1_phy {
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
-
-		sd-cd {
-			pins = "gpio96";
-			function = "gpio";
-			bias-pull-up;		/* pull up */
-			drive-strength = <2>;	/* 2 MA */
-		};
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
-
-		sd-cd {
-			pins = "gpio96";
-			function = "gpio";
-			bias-pull-up;		/* pull up */
-			drive-strength = <2>;	/* 2 MA */
-		};
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
index bb278ecac3fa..5397fba9417b 100644
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
index 9dccecd9fcae..bbd322fc5646 100644
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
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 45d4c9cf3f3a..661046150e49 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -80,9 +80,20 @@ __pu_failed:							\
 		:						\
 		: label)
 
+#ifdef CONFIG_CC_IS_CLANG
+#define DS_FORM_CONSTRAINT "Z<>"
+#else
+#define DS_FORM_CONSTRAINT "YZ<>"
+#endif
+
 #ifdef __powerpc64__
-#define __put_user_asm2_goto(x, ptr, label)			\
-	__put_user_asm_goto(x, ptr, label, "std")
+#define __put_user_asm2_goto(x, addr, label)			\
+	asm goto ("1: std%U1%X1 %0,%1	# put_user\n"		\
+		EX_TABLE(1b, %l2)				\
+		:						\
+		: "r" (x), DS_FORM_CONSTRAINT (*addr)		\
+		:						\
+		: label)
 #else /* __powerpc64__ */
 #define __put_user_asm2_goto(x, addr, label)			\
 	asm goto(					\
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 7c4852af9e3f..7ba5c244f3a0 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -213,18 +213,19 @@ static void __init setup_bootmem(void)
 	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
 		phys_ram_base = memblock_start_of_DRAM();
 	/*
-	 * memblock allocator is not aware of the fact that last 4K bytes of
-	 * the addressable memory can not be mapped because of IS_ERR_VALUE
-	 * macro. Make sure that last 4k bytes are not usable by memblock
-	 * if end of dram is equal to maximum addressable memory.  For 64-bit
-	 * kernel, this problem can't happen here as the end of the virtual
-	 * address space is occupied by the kernel mapping then this check must
-	 * be done as soon as the kernel mapping base address is determined.
+	 * Reserve physical address space that would be mapped to virtual
+	 * addresses greater than (void *)(-PAGE_SIZE) because:
+	 *  - This memory would overlap with ERR_PTR
+	 *  - This memory belongs to high memory, which is not supported
+	 *
+	 * This is not applicable to 64-bit kernel, because virtual addresses
+	 * after (void *)(-PAGE_SIZE) are not linearly mapped: they are
+	 * occupied by kernel mapping. Also it is unrealistic for high memory
+	 * to exist on 64-bit platforms.
 	 */
 	if (!IS_ENABLED(CONFIG_64BIT)) {
-		max_mapped_addr = __pa(~(ulong)0);
-		if (max_mapped_addr == (phys_ram_end - 1))
-			memblock_set_current_limit(max_mapped_addr - 4096);
+		max_mapped_addr = __va_to_pa_nodebug(-PAGE_SIZE);
+		memblock_reserve(max_mapped_addr, (phys_addr_t)-max_mapped_addr);
 	}
 
 	min_low_pfn = PFN_UP(phys_ram_base);
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 9587e4487415..d0557a4ab8f9 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -386,17 +386,33 @@ int set_direct_map_default_noflush(struct page *page)
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
+static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void *data)
+{
+	int enable = *(int *)data;
+
+	unsigned long val = pte_val(ptep_get(pte));
+
+	if (enable)
+		val |= _PAGE_PRESENT;
+	else
+		val &= ~_PAGE_PRESENT;
+
+	set_pte(pte, __pte(val));
+
+	return 0;
+}
+
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
 	if (!debug_pagealloc_enabled())
 		return;
 
-	if (enable)
-		__set_memory((unsigned long)page_address(page), numpages,
-			     __pgprot(_PAGE_PRESENT), __pgprot(0));
-	else
-		__set_memory((unsigned long)page_address(page), numpages,
-			     __pgprot(0), __pgprot(_PAGE_PRESENT));
+	unsigned long start = (unsigned long)page_address(page);
+	unsigned long size = PAGE_SIZE * numpages;
+
+	apply_to_existing_page_range(&init_mm, start, size, debug_pagealloc_set_page, &enable);
+
+	flush_tlb_kernel_range(start, start + size);
 }
 #endif
 
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6e61baff223f..897f56533e6c 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -115,9 +115,9 @@ vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
 
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
-vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
+$(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 8ea24df3c5ff..e8cc042e4905 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -195,7 +195,14 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 
 int amd_smn_read(u16 node, u32 address, u32 *value)
 {
-	return __amd_smn_rw(node, address, value, false);
+	int err = __amd_smn_rw(node, address, value, false);
+
+	if (PCI_POSSIBLE_ERROR(*value)) {
+		err = -ENODEV;
+		*value = 0;
+	}
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(amd_smn_read);
 
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 228e4dff5fb2..ab555a980147 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -113,9 +113,9 @@
 #define MAKE_RA_FOR_CALL(ra,ws)   (((ra) & 0x3fffffff) | (ws) << 30)
 
 /* Convert return address to a valid pc
- * Note: We assume that the stack pointer is in the same 1GB ranges as the ra
+ * Note: 'text' is the address within the same 1GB range as the ra
  */
-#define MAKE_PC_FROM_RA(ra,sp)    (((ra) & 0x3fffffff) | ((sp) & 0xc0000000))
+#define MAKE_PC_FROM_RA(ra, text) (((ra) & 0x3fffffff) | ((unsigned long)(text) & 0xc0000000))
 
 #elif defined(__XTENSA_CALL0_ABI__)
 
@@ -125,9 +125,9 @@
 #define MAKE_RA_FOR_CALL(ra, ws)   (ra)
 
 /* Convert return address to a valid pc
- * Note: We assume that the stack pointer is in the same 1GB ranges as the ra
+ * Note: 'text' is not used as 'ra' is always the full address
  */
-#define MAKE_PC_FROM_RA(ra, sp)    (ra)
+#define MAKE_PC_FROM_RA(ra, text)  (ra)
 
 #else
 #error Unsupported Xtensa ABI
diff --git a/arch/xtensa/include/asm/ptrace.h b/arch/xtensa/include/asm/ptrace.h
index 308f209a4740..17c5cbd1832e 100644
--- a/arch/xtensa/include/asm/ptrace.h
+++ b/arch/xtensa/include/asm/ptrace.h
@@ -87,7 +87,7 @@ struct pt_regs {
 # define user_mode(regs) (((regs)->ps & 0x00000020)!=0)
 # define instruction_pointer(regs) ((regs)->pc)
 # define return_pointer(regs) (MAKE_PC_FROM_RA((regs)->areg[0], \
-					       (regs)->areg[1]))
+					       (regs)->pc))
 
 # ifndef CONFIG_SMP
 #  define profile_pc(regs) instruction_pointer(regs)
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 68e0e2f06d66..3138f72dcbe2 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -47,6 +47,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/regs.h>
 #include <asm/hw_breakpoint.h>
+#include <asm/sections.h>
 #include <asm/traps.h>
 
 extern void ret_from_fork(void);
@@ -379,7 +380,7 @@ unsigned long __get_wchan(struct task_struct *p)
 	int count = 0;
 
 	sp = p->thread.sp;
-	pc = MAKE_PC_FROM_RA(p->thread.ra, p->thread.sp);
+	pc = MAKE_PC_FROM_RA(p->thread.ra, _text);
 
 	do {
 		if (sp < stack_page + sizeof(struct task_struct) ||
@@ -391,7 +392,7 @@ unsigned long __get_wchan(struct task_struct *p)
 
 		/* Stack layout: sp-4: ra, sp-3: sp' */
 
-		pc = MAKE_PC_FROM_RA(SPILL_SLOT(sp, 0), sp);
+		pc = MAKE_PC_FROM_RA(SPILL_SLOT(sp, 0), _text);
 		sp = SPILL_SLOT(sp, 1);
 	} while (count++ < 16);
 	return 0;
diff --git a/arch/xtensa/kernel/stacktrace.c b/arch/xtensa/kernel/stacktrace.c
index 7f7755cd28f0..b69044893287 100644
--- a/arch/xtensa/kernel/stacktrace.c
+++ b/arch/xtensa/kernel/stacktrace.c
@@ -12,6 +12,8 @@
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 
+#include <asm/ftrace.h>
+#include <asm/sections.h>
 #include <asm/stacktrace.h>
 #include <asm/traps.h>
 #include <linux/uaccess.h>
@@ -188,7 +190,7 @@ void walk_stackframe(unsigned long *sp,
 		if (a1 <= (unsigned long)sp)
 			break;
 
-		frame.pc = MAKE_PC_FROM_RA(a0, a1);
+		frame.pc = MAKE_PC_FROM_RA(a0, _text);
 		frame.sp = a1;
 
 		if (fn(&frame, data))
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8d87808cdb8a..30204e62497c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2657,8 +2657,11 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	if (!env)
 		return -ENOMEM;
 
+	/* Synchronize with really_probe() */
+	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(&dev->kobj, env);
+	device_unlock(dev);
 	if (retval)
 		goto out;
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 55a69e48ef8b..b0264b3df6f3 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -112,7 +112,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	if (dev->zone_max_active && dev->zone_max_open > dev->zone_max_active) {
 		dev->zone_max_open = dev->zone_max_active;
 		pr_info("changed the maximum number of open zones to %u\n",
-			dev->nr_zones);
+			dev->zone_max_open);
 	} else if (dev->zone_max_open >= dev->nr_zones - dev->zone_nr_conv) {
 		dev->zone_max_open = 0;
 		pr_info("zone_max_open limit disabled, limit >= zone count\n");
diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 2dda94a0875a..35fb26cbf229 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -408,6 +408,14 @@ static int qca_tlv_check_data(struct hci_dev *hdev,
 
 			/* Update NVM tags as needed */
 			switch (tag_id) {
+			case EDL_TAG_ID_BD_ADDR:
+				if (tag_len != sizeof(bdaddr_t))
+					return -EINVAL;
+
+				memcpy(&config->bdaddr, tlv_nvm->data, sizeof(bdaddr_t));
+
+				break;
+
 			case EDL_TAG_ID_HCI:
 				if (tag_len < 3)
 					return -EINVAL;
@@ -682,6 +690,38 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
+static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *config)
+{
+	struct hci_rp_read_bd_addr *bda;
+	struct sk_buff *skb;
+	int err;
+
+	if (bacmp(&hdev->public_addr, BDADDR_ANY))
+		return 0;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Failed to read device address (%d)", err);
+		return err;
+	}
+
+	if (skb->len != sizeof(*bda)) {
+		bt_dev_err(hdev, "Device address length mismatch");
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	bda = (struct hci_rp_read_bd_addr *)skb->data;
+	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
 static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
 		struct qca_btsoc_version ver, u8 rom_ver, u16 bid)
 {
@@ -703,7 +743,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
 		   const char *firmware_name)
 {
-	struct qca_fw_config config;
+	struct qca_fw_config config = {};
 	int err;
 	u8 rom_ver = 0;
 	u32 soc_ver;
@@ -888,6 +928,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		break;
 	}
 
+	err = qca_check_bdaddr(hdev, &config);
+	if (err)
+		return err;
+
 	bt_dev_info(hdev, "QCA setup on UART is completed");
 
 	return 0;
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 38e2fbc95024..215433fd76a1 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -29,6 +29,7 @@
 #define EDL_PATCH_CONFIG_RES_EVT	(0x00)
 #define QCA_DISABLE_LOGGING_SUB_OP	(0x14)
 
+#define EDL_TAG_ID_BD_ADDR		2
 #define EDL_TAG_ID_HCI			(17)
 #define EDL_TAG_ID_DEEP_SLEEP		(27)
 
@@ -93,6 +94,7 @@ struct qca_fw_config {
 	uint8_t user_baud_rate;
 	enum qca_tlv_dnld_mode dnld_mode;
 	enum qca_tlv_dnld_mode dnld_type;
+	bdaddr_t bdaddr;
 };
 
 struct edl_event_hdr {
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a0e2b5d99269..070014d0fc99 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1853,8 +1853,6 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
-
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->bdaddr_property_broken)
 			set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index 916d2fc28b9c..39bfbd120e0b 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2020 Zong Li
  */
 
-#include <linux/clkdev.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/of_device.h>
@@ -536,13 +535,6 @@ static int __prci_register_clocks(struct device *dev, struct __prci_data *pd,
 			return r;
 		}
 
-		r = clk_hw_register_clkdev(&pic->hw, pic->name, dev_name(dev));
-		if (r) {
-			dev_warn(dev, "Failed to register clkdev for %s: %d\n",
-				 init.name, r);
-			return r;
-		}
-
 		pd->hw_clks.hws[i] = &pic->hw;
 	}
 
diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index f30dabc99795..176cf3665a18 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -1036,8 +1036,8 @@ static int axi_dmac_remove(struct platform_device *pdev)
 {
 	struct axi_dmac *dmac = platform_get_drvdata(pdev);
 
-	of_dma_controller_free(pdev->dev.of_node);
 	free_irq(dmac->irq, dmac);
+	of_dma_controller_free(pdev->dev.of_node);
 	tasklet_kill(&dmac->chan.vchan.task);
 	dma_async_device_unregister(&dmac->dma_dev);
 	clk_disable_unprepare(dmac->clk);
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 58f1a86065dc..619cd6548cf6 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -495,13 +495,14 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 
 	ret = qcom_scm_bw_enable();
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	desc.args[1] = mdata_phys;
 
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
-
 	qcom_scm_bw_disable();
+
+disable_clk:
 	qcom_scm_clk_disable();
 
 out:
@@ -563,10 +564,12 @@ int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
 
 	ret = qcom_scm_bw_enable();
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
 	qcom_scm_bw_disable();
+
+disable_clk:
 	qcom_scm_clk_disable();
 
 	return ret ? : res.result[0];
@@ -598,10 +601,12 @@ int qcom_scm_pas_auth_and_reset(u32 peripheral)
 
 	ret = qcom_scm_bw_enable();
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
 	qcom_scm_bw_disable();
+
+disable_clk:
 	qcom_scm_clk_disable();
 
 	return ret ? : res.result[0];
@@ -632,11 +637,12 @@ int qcom_scm_pas_shutdown(u32 peripheral)
 
 	ret = qcom_scm_bw_enable();
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
-
 	qcom_scm_bw_disable();
+
+disable_clk:
 	qcom_scm_clk_disable();
 
 	return ret ? : res.result[0];
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 700f71c95495..b23ef29f5602 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1416,7 +1416,7 @@ config GPIO_TPS68470
 	  are "output only" GPIOs.
 
 config GPIO_TQMX86
-	tristate "TQ-Systems QTMX86 GPIO"
+	tristate "TQ-Systems TQMx86 GPIO"
 	depends on MFD_TQMX86 || COMPILE_TEST
 	depends on HAS_IOPORT_MAP
 	select GPIOLIB_IRQCHIP
diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
index e739dcea61b2..f2e7e8754d95 100644
--- a/drivers/gpio/gpio-tqmx86.c
+++ b/drivers/gpio/gpio-tqmx86.c
@@ -6,6 +6,7 @@
  *   Vadim V.Vlasov <vvlasov@dev.rtsoft.ru>
  */
 
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
@@ -15,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 
 #define TQMX86_NGPIO	8
@@ -27,17 +29,25 @@
 #define TQMX86_GPIIC	3	/* GPI Interrupt Configuration Register */
 #define TQMX86_GPIIS	4	/* GPI Interrupt Status Register */
 
+#define TQMX86_GPII_NONE	0
 #define TQMX86_GPII_FALLING	BIT(0)
 #define TQMX86_GPII_RISING	BIT(1)
+/* Stored in irq_type as a trigger type, but not actually valid as a register
+ * value, so the name doesn't use "GPII"
+ */
+#define TQMX86_INT_BOTH		(BIT(0) | BIT(1))
 #define TQMX86_GPII_MASK	(BIT(0) | BIT(1))
 #define TQMX86_GPII_BITS	2
+/* Stored in irq_type with GPII bits */
+#define TQMX86_INT_UNMASKED	BIT(2)
 
 struct tqmx86_gpio_data {
 	struct gpio_chip	chip;
-	struct irq_chip		irq_chip;
 	void __iomem		*io_base;
 	int			irq;
+	/* Lock must be held for accessing output and irq_type fields */
 	raw_spinlock_t		spinlock;
+	DECLARE_BITMAP(output, TQMX86_NGPIO);
 	u8			irq_type[TQMX86_NGPI];
 };
 
@@ -64,15 +74,10 @@ static void tqmx86_gpio_set(struct gpio_chip *chip, unsigned int offset,
 {
 	struct tqmx86_gpio_data *gpio = gpiochip_get_data(chip);
 	unsigned long flags;
-	u8 val;
 
 	raw_spin_lock_irqsave(&gpio->spinlock, flags);
-	val = tqmx86_gpio_read(gpio, TQMX86_GPIOD);
-	if (value)
-		val |= BIT(offset);
-	else
-		val &= ~BIT(offset);
-	tqmx86_gpio_write(gpio, val, TQMX86_GPIOD);
+	__assign_bit(offset, gpio->output, value);
+	tqmx86_gpio_write(gpio, bitmap_get_value8(gpio->output, 0), TQMX86_GPIOD);
 	raw_spin_unlock_irqrestore(&gpio->spinlock, flags);
 }
 
@@ -107,21 +112,39 @@ static int tqmx86_gpio_get_direction(struct gpio_chip *chip,
 	return GPIO_LINE_DIRECTION_OUT;
 }
 
+static void tqmx86_gpio_irq_config(struct tqmx86_gpio_data *gpio, int offset)
+	__must_hold(&gpio->spinlock)
+{
+	u8 type = TQMX86_GPII_NONE, gpiic;
+
+	if (gpio->irq_type[offset] & TQMX86_INT_UNMASKED) {
+		type = gpio->irq_type[offset] & TQMX86_GPII_MASK;
+
+		if (type == TQMX86_INT_BOTH)
+			type = tqmx86_gpio_get(&gpio->chip, offset + TQMX86_NGPO)
+				? TQMX86_GPII_FALLING
+				: TQMX86_GPII_RISING;
+	}
+
+	gpiic = tqmx86_gpio_read(gpio, TQMX86_GPIIC);
+	gpiic &= ~(TQMX86_GPII_MASK << (offset * TQMX86_GPII_BITS));
+	gpiic |= type << (offset * TQMX86_GPII_BITS);
+	tqmx86_gpio_write(gpio, gpiic, TQMX86_GPIIC);
+}
+
 static void tqmx86_gpio_irq_mask(struct irq_data *data)
 {
 	unsigned int offset = (data->hwirq - TQMX86_NGPO);
 	struct tqmx86_gpio_data *gpio = gpiochip_get_data(
 		irq_data_get_irq_chip_data(data));
 	unsigned long flags;
-	u8 gpiic, mask;
-
-	mask = TQMX86_GPII_MASK << (offset * TQMX86_GPII_BITS);
 
 	raw_spin_lock_irqsave(&gpio->spinlock, flags);
-	gpiic = tqmx86_gpio_read(gpio, TQMX86_GPIIC);
-	gpiic &= ~mask;
-	tqmx86_gpio_write(gpio, gpiic, TQMX86_GPIIC);
+	gpio->irq_type[offset] &= ~TQMX86_INT_UNMASKED;
+	tqmx86_gpio_irq_config(gpio, offset);
 	raw_spin_unlock_irqrestore(&gpio->spinlock, flags);
+
+	gpiochip_disable_irq(&gpio->chip, irqd_to_hwirq(data));
 }
 
 static void tqmx86_gpio_irq_unmask(struct irq_data *data)
@@ -130,15 +153,12 @@ static void tqmx86_gpio_irq_unmask(struct irq_data *data)
 	struct tqmx86_gpio_data *gpio = gpiochip_get_data(
 		irq_data_get_irq_chip_data(data));
 	unsigned long flags;
-	u8 gpiic, mask;
 
-	mask = TQMX86_GPII_MASK << (offset * TQMX86_GPII_BITS);
+	gpiochip_enable_irq(&gpio->chip, irqd_to_hwirq(data));
 
 	raw_spin_lock_irqsave(&gpio->spinlock, flags);
-	gpiic = tqmx86_gpio_read(gpio, TQMX86_GPIIC);
-	gpiic &= ~mask;
-	gpiic |= gpio->irq_type[offset] << (offset * TQMX86_GPII_BITS);
-	tqmx86_gpio_write(gpio, gpiic, TQMX86_GPIIC);
+	gpio->irq_type[offset] |= TQMX86_INT_UNMASKED;
+	tqmx86_gpio_irq_config(gpio, offset);
 	raw_spin_unlock_irqrestore(&gpio->spinlock, flags);
 }
 
@@ -149,7 +169,7 @@ static int tqmx86_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	unsigned int offset = (data->hwirq - TQMX86_NGPO);
 	unsigned int edge_type = type & IRQF_TRIGGER_MASK;
 	unsigned long flags;
-	u8 new_type, gpiic;
+	u8 new_type;
 
 	switch (edge_type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -159,19 +179,16 @@ static int tqmx86_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 		new_type = TQMX86_GPII_FALLING;
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
-		new_type = TQMX86_GPII_FALLING | TQMX86_GPII_RISING;
+		new_type = TQMX86_INT_BOTH;
 		break;
 	default:
 		return -EINVAL; /* not supported */
 	}
 
-	gpio->irq_type[offset] = new_type;
-
 	raw_spin_lock_irqsave(&gpio->spinlock, flags);
-	gpiic = tqmx86_gpio_read(gpio, TQMX86_GPIIC);
-	gpiic &= ~((TQMX86_GPII_MASK) << (offset * TQMX86_GPII_BITS));
-	gpiic |= new_type << (offset * TQMX86_GPII_BITS);
-	tqmx86_gpio_write(gpio, gpiic, TQMX86_GPIIC);
+	gpio->irq_type[offset] &= ~TQMX86_GPII_MASK;
+	gpio->irq_type[offset] |= new_type;
+	tqmx86_gpio_irq_config(gpio, offset);
 	raw_spin_unlock_irqrestore(&gpio->spinlock, flags);
 
 	return 0;
@@ -182,8 +199,8 @@ static void tqmx86_gpio_irq_handler(struct irq_desc *desc)
 	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
 	struct tqmx86_gpio_data *gpio = gpiochip_get_data(chip);
 	struct irq_chip *irq_chip = irq_desc_get_chip(desc);
-	unsigned long irq_bits;
-	int i = 0;
+	unsigned long irq_bits, flags;
+	int i;
 	u8 irq_status;
 
 	chained_irq_enter(irq_chip, desc);
@@ -192,6 +209,34 @@ static void tqmx86_gpio_irq_handler(struct irq_desc *desc)
 	tqmx86_gpio_write(gpio, irq_status, TQMX86_GPIIS);
 
 	irq_bits = irq_status;
+
+	raw_spin_lock_irqsave(&gpio->spinlock, flags);
+	for_each_set_bit(i, &irq_bits, TQMX86_NGPI) {
+		/*
+		 * Edge-both triggers are implemented by flipping the edge
+		 * trigger after each interrupt, as the controller only supports
+		 * either rising or falling edge triggers, but not both.
+		 *
+		 * Internally, the TQMx86 GPIO controller has separate status
+		 * registers for rising and falling edge interrupts. GPIIC
+		 * configures which bits from which register are visible in the
+		 * interrupt status register GPIIS and defines what triggers the
+		 * parent IRQ line. Writing to GPIIS always clears both rising
+		 * and falling interrupt flags internally, regardless of the
+		 * currently configured trigger.
+		 *
+		 * In consequence, we can cleanly implement the edge-both
+		 * trigger in software by first clearing the interrupt and then
+		 * setting the new trigger based on the current GPIO input in
+		 * tqmx86_gpio_irq_config() - even if an edge arrives between
+		 * reading the input and setting the trigger, we will have a new
+		 * interrupt pending.
+		 */
+		if ((gpio->irq_type[i] & TQMX86_GPII_MASK) == TQMX86_INT_BOTH)
+			tqmx86_gpio_irq_config(gpio, i);
+	}
+	raw_spin_unlock_irqrestore(&gpio->spinlock, flags);
+
 	for_each_set_bit(i, &irq_bits, TQMX86_NGPI)
 		generic_handle_domain_irq(gpio->chip.irq.domain,
 					  i + TQMX86_NGPO);
@@ -226,6 +271,22 @@ static void tqmx86_init_irq_valid_mask(struct gpio_chip *chip,
 	clear_bit(3, valid_mask);
 }
 
+static void tqmx86_gpio_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	seq_printf(p, gc->label);
+}
+
+static const struct irq_chip tqmx86_gpio_irq_chip = {
+	.irq_mask = tqmx86_gpio_irq_mask,
+	.irq_unmask = tqmx86_gpio_irq_unmask,
+	.irq_set_type = tqmx86_gpio_irq_set_type,
+	.irq_print_chip = tqmx86_gpio_irq_print_chip,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int tqmx86_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -259,7 +320,12 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 
 	tqmx86_gpio_write(gpio, (u8)~TQMX86_DIR_INPUT_MASK, TQMX86_GPIODD);
 
-	platform_set_drvdata(pdev, gpio);
+	/*
+	 * Reading the previous output state is not possible with TQMx86 hardware.
+	 * Initialize all outputs to 0 to have a defined state that matches the
+	 * shadow register.
+	 */
+	tqmx86_gpio_write(gpio, 0, TQMX86_GPIOD);
 
 	chip = &gpio->chip;
 	chip->label = "gpio-tqmx86";
@@ -277,14 +343,8 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	if (irq > 0) {
-		struct irq_chip *irq_chip = &gpio->irq_chip;
 		u8 irq_status;
 
-		irq_chip->name = chip->label;
-		irq_chip->irq_mask = tqmx86_gpio_irq_mask;
-		irq_chip->irq_unmask = tqmx86_gpio_irq_unmask;
-		irq_chip->irq_set_type = tqmx86_gpio_irq_set_type;
-
 		/* Mask all interrupts */
 		tqmx86_gpio_write(gpio, 0, TQMX86_GPIIC);
 
@@ -293,7 +353,7 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 		tqmx86_gpio_write(gpio, irq_status, TQMX86_GPIIS);
 
 		girq = &chip->irq;
-		girq->chip = irq_chip;
+		gpio_irq_chip_set_chip(girq, &tqmx86_gpio_irq_chip);
 		girq->parent_handler = tqmx86_gpio_irq_handler;
 		girq->num_parents = 1;
 		girq->parents = devm_kcalloc(&pdev->dev, 1,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index ff7dd17ad076..dd34dfcd5af7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1369,16 +1369,13 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		if (pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
@@ -1475,12 +1472,14 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		if (pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
-	if (!pipe_ctx || !pipe_ctx->stream)
+	if (!pipe_ctx->stream)
 		goto done;
 
 	// Get CRTC state
@@ -1560,16 +1559,13 @@ static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		if (pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
@@ -1664,12 +1660,14 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		if (pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
-	if (!pipe_ctx || !pipe_ctx->stream)
+	if (!pipe_ctx->stream)
 		goto done;
 
 	// Safely get CRTC state
@@ -1749,16 +1747,13 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		if (pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
@@ -1853,12 +1848,14 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		if (pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
-	if (!pipe_ctx || !pipe_ctx->stream)
+	if (!pipe_ctx->stream)
 		goto done;
 
 	// Get CRTC state
@@ -1934,16 +1931,13 @@ static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		if (pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
@@ -2035,12 +2029,14 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		if (pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
-	if (!pipe_ctx || !pipe_ctx->stream)
+	if (!pipe_ctx->stream)
 		goto done;
 
 	// Get CRTC state
@@ -2114,16 +2110,13 @@ static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		if (pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
@@ -2175,16 +2168,13 @@ static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		if (pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
@@ -2251,16 +2241,13 @@ static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		if (pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
@@ -2327,16 +2314,13 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		if (pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
-	if (!pipe_ctx) {
-		kfree(rd_buf);
-		return -ENXIO;
-	}
-
 	dsc = pipe_ctx->stream_res.dsc;
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 916f2c36bf2f..e200decd00c6 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -259,7 +259,7 @@ komeda_component_get_avail_scaler(struct komeda_component *c,
 	u32 avail_scalers;
 
 	pipe_st = komeda_pipeline_get_state(c->pipeline, state);
-	if (!pipe_st)
+	if (IS_ERR_OR_NULL(pipe_st))
 		return NULL;
 
 	avail_scalers = (pipe_st->active_comps & KOMEDA_PIPELINE_SCALERS) ^
diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 216af76d0042..cdfcdbecd4c8 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -306,9 +306,12 @@ EXPORT_SYMBOL(drm_panel_bridge_set_orientation);
 
 static void devm_drm_panel_bridge_release(struct device *dev, void *res)
 {
-	struct drm_bridge **bridge = res;
+	struct drm_bridge *bridge = *(struct drm_bridge **)res;
 
-	drm_panel_bridge_remove(*bridge);
+	if (!bridge)
+		return;
+
+	drm_bridge_remove(bridge);
 }
 
 /**
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index fb941a8c99f0..e17f9c5c9c90 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -309,6 +309,7 @@ static int vidi_get_modes(struct drm_connector *connector)
 	struct vidi_context *ctx = ctx_from_connector(connector);
 	struct edid *edid;
 	int edid_len;
+	int count;
 
 	/*
 	 * the edid data comes from user side and it would be set
@@ -328,7 +329,11 @@ static int vidi_get_modes(struct drm_connector *connector)
 
 	drm_connector_update_edid_property(connector, edid);
 
-	return drm_add_edid_modes(connector, edid);
+	count = drm_add_edid_modes(connector, edid);
+
+	kfree(edid);
+
+	return count;
 }
 
 static const struct drm_connector_helper_funcs vidi_connector_helper_funcs = {
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index be2d9cbaaef2..b0913bc81fc1 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -887,11 +887,11 @@ static int hdmi_get_modes(struct drm_connector *connector)
 	int ret;
 
 	if (!hdata->ddc_adpt)
-		return 0;
+		goto no_edid;
 
 	edid = drm_get_edid(connector, hdata->ddc_adpt);
 	if (!edid)
-		return 0;
+		goto no_edid;
 
 	hdata->dvi_mode = !connector->display_info.is_hdmi;
 	DRM_DEV_DEBUG_KMS(hdata->dev, "%s : width[%d] x height[%d]\n",
@@ -906,6 +906,9 @@ static int hdmi_get_modes(struct drm_connector *connector)
 	kfree(edid);
 
 	return ret;
+
+no_edid:
+	return drm_add_modes_noedid(connector, 640, 480);
 }
 
 static int hdmi_find_phy_conf(struct hdmi_context *hdata, u32 pixel_clock)
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index ea951e2f55b1..2c2be479acc1 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -295,7 +295,9 @@ bool i915_gem_object_has_iomem(const struct drm_i915_gem_object *obj);
 static inline bool
 i915_gem_object_is_shrinkable(const struct drm_i915_gem_object *obj)
 {
-	return i915_gem_object_type_has(obj, I915_GEM_OBJECT_IS_SHRINKABLE);
+	/* TODO: make DPT shrinkable when it has no bound vmas */
+	return i915_gem_object_type_has(obj, I915_GEM_OBJECT_IS_SHRINKABLE) &&
+		!obj->is_dpt;
 }
 
 static inline bool
diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
index ecc990ec1b95..f2973cd1a8aa 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -258,8 +258,13 @@ static void signal_irq_work(struct irq_work *work)
 		i915_request_put(rq);
 	}
 
+	/* Lazy irq enabling after HW submission */
 	if (!READ_ONCE(b->irq_armed) && !list_empty(&b->signalers))
 		intel_breadcrumbs_arm_irq(b);
+
+	/* And confirm that we still want irqs enabled before we yield */
+	if (READ_ONCE(b->irq_armed) && !atomic_read(&b->active))
+		intel_breadcrumbs_disarm_irq(b);
 }
 
 struct intel_breadcrumbs *
@@ -310,13 +315,7 @@ void __intel_breadcrumbs_park(struct intel_breadcrumbs *b)
 		return;
 
 	/* Kick the work once more to drain the signalers, and disarm the irq */
-	irq_work_sync(&b->irq_work);
-	while (READ_ONCE(b->irq_armed) && !atomic_read(&b->active)) {
-		local_irq_disable();
-		signal_irq_work(&b->irq_work);
-		local_irq_enable();
-		cond_resched();
-	}
+	irq_work_queue(&b->irq_work);
 }
 
 void intel_breadcrumbs_free(struct kref *kref)
@@ -399,7 +398,7 @@ static void insert_breadcrumb(struct i915_request *rq)
 	 * the request as it may have completed and raised the interrupt as
 	 * we were attaching it into the lists.
 	 */
-	if (!b->irq_armed || __i915_request_is_complete(rq))
+	if (!READ_ONCE(b->irq_armed) || __i915_request_is_complete(rq))
 		irq_work_queue(&b->irq_work);
 }
 
diff --git a/drivers/gpu/drm/vmwgfx/Kconfig b/drivers/gpu/drm/vmwgfx/Kconfig
index a4fabe208d9f..faddae3d6ac2 100644
--- a/drivers/gpu/drm/vmwgfx/Kconfig
+++ b/drivers/gpu/drm/vmwgfx/Kconfig
@@ -16,13 +16,6 @@ config DRM_VMWGFX
 	  virtual hardware.
 	  The compiled module will be called "vmwgfx.ko".
 
-config DRM_VMWGFX_FBCON
-	depends on DRM_VMWGFX && DRM_FBDEV_EMULATION
-	bool "Enable framebuffer console under vmwgfx by default"
-	help
-	   Choose this option if you are shipping a new vmwgfx
-	   userspace driver that supports using the kernel driver.
-
 config DRM_VMWGFX_MKSSTATS
 	bool "Enable mksGuestStats instrumentation of vmwgfx by default"
 	depends on DRM_VMWGFX
diff --git a/drivers/gpu/drm/vmwgfx/Makefile b/drivers/gpu/drm/vmwgfx/Makefile
index 68e350f410ad..2a644f035597 100644
--- a/drivers/gpu/drm/vmwgfx/Makefile
+++ b/drivers/gpu/drm/vmwgfx/Makefile
@@ -12,6 +12,4 @@ vmwgfx-y := vmwgfx_execbuf.o vmwgfx_gmr.o vmwgfx_kms.o vmwgfx_drv.o \
 	    vmwgfx_devcaps.o ttm_object.o vmwgfx_system_manager.o \
 	    vmwgfx_gem.o
 
-vmwgfx-$(CONFIG_DRM_FBDEV_EMULATION) += vmwgfx_fb.o
-
 obj-$(CONFIG_DRM_VMWGFX) := vmwgfx.o
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 53f63ad656a4..be27f9a3bf67 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -35,6 +35,7 @@
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_ttm_helper.h>
 #include <drm/drm_ioctl.h>
 #include <drm/drm_module.h>
@@ -52,9 +53,6 @@
 
 #define VMWGFX_DRIVER_DESC "Linux drm driver for VMware graphics devices"
 
-#define VMW_MIN_INITIAL_WIDTH 800
-#define VMW_MIN_INITIAL_HEIGHT 600
-
 /*
  * Fully encoded drm commands. Might move to vmw_drm.h
  */
@@ -265,7 +263,6 @@ static const struct pci_device_id vmw_pci_id_list[] = {
 };
 MODULE_DEVICE_TABLE(pci, vmw_pci_id_list);
 
-static int enable_fbdev = IS_ENABLED(CONFIG_DRM_VMWGFX_FBCON);
 static int vmw_restrict_iommu;
 static int vmw_force_coherent;
 static int vmw_restrict_dma_mask;
@@ -275,8 +272,6 @@ static int vmw_probe(struct pci_dev *, const struct pci_device_id *);
 static int vmwgfx_pm_notifier(struct notifier_block *nb, unsigned long val,
 			      void *ptr);
 
-MODULE_PARM_DESC(enable_fbdev, "Enable vmwgfx fbdev");
-module_param_named(enable_fbdev, enable_fbdev, int, 0600);
 MODULE_PARM_DESC(restrict_iommu, "Try to limit IOMMU usage for TTM pages");
 module_param_named(restrict_iommu, vmw_restrict_iommu, int, 0600);
 MODULE_PARM_DESC(force_coherent, "Force coherent TTM pages");
@@ -626,8 +621,8 @@ static void vmw_get_initial_size(struct vmw_private *dev_priv)
 	width = vmw_read(dev_priv, SVGA_REG_WIDTH);
 	height = vmw_read(dev_priv, SVGA_REG_HEIGHT);
 
-	width = max_t(uint32_t, width, VMW_MIN_INITIAL_WIDTH);
-	height = max_t(uint32_t, height, VMW_MIN_INITIAL_HEIGHT);
+	width = max_t(uint32_t, width, VMWGFX_MIN_INITIAL_WIDTH);
+	height = max_t(uint32_t, height, VMWGFX_MIN_INITIAL_HEIGHT);
 
 	if (width > dev_priv->fb_max_width ||
 	    height > dev_priv->fb_max_height) {
@@ -636,8 +631,8 @@ static void vmw_get_initial_size(struct vmw_private *dev_priv)
 		 * This is a host error and shouldn't occur.
 		 */
 
-		width = VMW_MIN_INITIAL_WIDTH;
-		height = VMW_MIN_INITIAL_HEIGHT;
+		width  = VMWGFX_MIN_INITIAL_WIDTH;
+		height = VMWGFX_MIN_INITIAL_HEIGHT;
 	}
 
 	dev_priv->initial_width = width;
@@ -887,9 +882,6 @@ static int vmw_driver_load(struct vmw_private *dev_priv, u32 pci_id)
 
 	dev_priv->assume_16bpp = !!vmw_assume_16bpp;
 
-	dev_priv->enable_fb = enable_fbdev;
-
-
 	dev_priv->capabilities = vmw_read(dev_priv, SVGA_REG_CAPABILITIES);
 	vmw_print_bitmap(&dev_priv->drm, "Capabilities",
 			 dev_priv->capabilities,
@@ -946,13 +938,6 @@ static int vmw_driver_load(struct vmw_private *dev_priv, u32 pci_id)
 				vmw_read(dev_priv,
 					 SVGA_REG_SUGGESTED_GBOBJECT_MEM_SIZE_KB);
 
-		/*
-		 * Workaround for low memory 2D VMs to compensate for the
-		 * allocation taken by fbdev
-		 */
-		if (!(dev_priv->capabilities & SVGA_CAP_3D))
-			mem_size *= 3;
-
 		dev_priv->max_mob_pages = mem_size * 1024 / PAGE_SIZE;
 		dev_priv->max_primary_mem =
 			vmw_read(dev_priv, SVGA_REG_MAX_PRIMARY_MEM);
@@ -1136,12 +1121,6 @@ static int vmw_driver_load(struct vmw_private *dev_priv, u32 pci_id)
 			VMWGFX_DRIVER_PATCHLEVEL, UTS_RELEASE);
 	vmw_write_driver_id(dev_priv);
 
-	if (dev_priv->enable_fb) {
-		vmw_fifo_resource_inc(dev_priv);
-		vmw_svga_enable(dev_priv);
-		vmw_fb_init(dev_priv);
-	}
-
 	dev_priv->pm_nb.notifier_call = vmwgfx_pm_notifier;
 	register_pm_notifier(&dev_priv->pm_nb);
 
@@ -1188,12 +1167,9 @@ static void vmw_driver_unload(struct drm_device *dev)
 	unregister_pm_notifier(&dev_priv->pm_nb);
 
 	vmw_sw_context_fini(dev_priv);
-	if (dev_priv->enable_fb) {
-		vmw_fb_off(dev_priv);
-		vmw_fb_close(dev_priv);
-		vmw_fifo_resource_dec(dev_priv);
-		vmw_svga_disable(dev_priv);
-	}
+	vmw_fifo_resource_dec(dev_priv);
+
+	vmw_svga_disable(dev_priv);
 
 	vmw_kms_close(dev_priv);
 	vmw_overlay_close(dev_priv);
@@ -1331,8 +1307,6 @@ static void vmw_master_drop(struct drm_device *dev,
 	struct vmw_private *dev_priv = vmw_priv(dev);
 
 	vmw_kms_legacy_hotspot_clear(dev_priv);
-	if (!dev_priv->enable_fb)
-		vmw_svga_disable(dev_priv);
 }
 
 /**
@@ -1528,25 +1502,19 @@ static int vmw_pm_freeze(struct device *kdev)
 		DRM_ERROR("Failed to freeze modesetting.\n");
 		return ret;
 	}
-	if (dev_priv->enable_fb)
-		vmw_fb_off(dev_priv);
 
 	vmw_execbuf_release_pinned_bo(dev_priv);
 	vmw_resource_evict_all(dev_priv);
 	vmw_release_device_early(dev_priv);
 	while (ttm_device_swapout(&dev_priv->bdev, &ctx, GFP_KERNEL) > 0);
-	if (dev_priv->enable_fb)
-		vmw_fifo_resource_dec(dev_priv);
+	vmw_fifo_resource_dec(dev_priv);
 	if (atomic_read(&dev_priv->num_fifo_resources) != 0) {
 		DRM_ERROR("Can't hibernate while 3D resources are active.\n");
-		if (dev_priv->enable_fb)
-			vmw_fifo_resource_inc(dev_priv);
+		vmw_fifo_resource_inc(dev_priv);
 		WARN_ON(vmw_request_device_late(dev_priv));
 		dev_priv->suspend_locked = false;
 		if (dev_priv->suspend_state)
 			vmw_kms_resume(dev);
-		if (dev_priv->enable_fb)
-			vmw_fb_on(dev_priv);
 		return -EBUSY;
 	}
 
@@ -1566,24 +1534,19 @@ static int vmw_pm_restore(struct device *kdev)
 
 	vmw_detect_version(dev_priv);
 
-	if (dev_priv->enable_fb)
-		vmw_fifo_resource_inc(dev_priv);
+	vmw_fifo_resource_inc(dev_priv);
 
 	ret = vmw_request_device(dev_priv);
 	if (ret)
 		return ret;
 
-	if (dev_priv->enable_fb)
-		__vmw_svga_enable(dev_priv);
+	__vmw_svga_enable(dev_priv);
 
 	vmw_fence_fifo_up(dev_priv->fman);
 	dev_priv->suspend_locked = false;
 	if (dev_priv->suspend_state)
 		vmw_kms_resume(&dev_priv->drm);
 
-	if (dev_priv->enable_fb)
-		vmw_fb_on(dev_priv);
-
 	return 0;
 }
 
@@ -1674,6 +1637,10 @@ static int vmw_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto out_unload;
 
+	vmw_fifo_resource_inc(vmw);
+	vmw_svga_enable(vmw);
+	drm_fbdev_generic_setup(&vmw->drm,  0);
+
 	vmw_debugfs_gem_init(vmw);
 	vmw_debugfs_resource_managers_init(vmw);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 136f1cdcf8cd..b0c23559511a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -62,6 +62,9 @@
 #define VMWGFX_MAX_DISPLAYS 16
 #define VMWGFX_CMD_BOUNCE_INIT_SIZE 32768
 
+#define VMWGFX_MIN_INITIAL_WIDTH 1280
+#define VMWGFX_MIN_INITIAL_HEIGHT 800
+
 #define VMWGFX_PCI_ID_SVGA2              0x0405
 #define VMWGFX_PCI_ID_SVGA3              0x0406
 
@@ -551,7 +554,6 @@ struct vmw_private {
 	 * Framebuffer info.
 	 */
 
-	void *fb_info;
 	enum vmw_display_unit_type active_display_unit;
 	struct vmw_legacy_display *ldu_priv;
 	struct vmw_overlay *overlay_priv;
@@ -610,8 +612,6 @@ struct vmw_private {
 	struct mutex cmdbuf_mutex;
 	struct mutex binding_mutex;
 
-	bool enable_fb;
-
 	/**
 	 * PM management.
 	 */
@@ -1178,35 +1178,6 @@ extern void vmw_generic_waiter_add(struct vmw_private *dev_priv, u32 flag,
 extern void vmw_generic_waiter_remove(struct vmw_private *dev_priv,
 				      u32 flag, int *waiter_count);
 
-
-/**
- * Kernel framebuffer - vmwgfx_fb.c
- */
-
-#ifdef CONFIG_DRM_FBDEV_EMULATION
-int vmw_fb_init(struct vmw_private *vmw_priv);
-int vmw_fb_close(struct vmw_private *dev_priv);
-int vmw_fb_off(struct vmw_private *vmw_priv);
-int vmw_fb_on(struct vmw_private *vmw_priv);
-#else
-static inline int vmw_fb_init(struct vmw_private *vmw_priv)
-{
-	return 0;
-}
-static inline int vmw_fb_close(struct vmw_private *dev_priv)
-{
-	return 0;
-}
-static inline int vmw_fb_off(struct vmw_private *vmw_priv)
-{
-	return 0;
-}
-static inline int vmw_fb_on(struct vmw_private *vmw_priv)
-{
-	return 0;
-}
-#endif
-
 /**
  * Kernel modesetting - vmwgfx_kms.c
  */
@@ -1223,9 +1194,6 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 int vmw_kms_write_svga(struct vmw_private *vmw_priv,
 		       unsigned width, unsigned height, unsigned pitch,
 		       unsigned bpp, unsigned depth);
-bool vmw_kms_validate_mode_vram(struct vmw_private *dev_priv,
-				uint32_t pitch,
-				uint32_t height);
 int vmw_kms_present(struct vmw_private *dev_priv,
 		    struct drm_file *file_priv,
 		    struct vmw_framebuffer *vfb,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
deleted file mode 100644
index 5b85b477e4c6..000000000000
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ /dev/null
@@ -1,831 +0,0 @@
-/**************************************************************************
- *
- * Copyright © 2007 David Airlie
- * Copyright © 2009-2015 VMware, Inc., Palo Alto, CA., USA
- * All Rights Reserved.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the
- * "Software"), to deal in the Software without restriction, including
- * without limitation the rights to use, copy, modify, merge, publish,
- * distribute, sub license, and/or sell copies of the Software, and to
- * permit persons to whom the Software is furnished to do so, subject to
- * the following conditions:
- *
- * The above copyright notice and this permission notice (including the
- * next paragraph) shall be included in all copies or substantial portions
- * of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
- * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
- * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
- * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
- * USE OR OTHER DEALINGS IN THE SOFTWARE.
- *
- **************************************************************************/
-
-#include <linux/fb.h>
-#include <linux/pci.h>
-
-#include <drm/drm_fourcc.h>
-#include <drm/ttm/ttm_placement.h>
-
-#include "vmwgfx_drv.h"
-#include "vmwgfx_kms.h"
-
-#define VMW_DIRTY_DELAY (HZ / 30)
-
-struct vmw_fb_par {
-	struct vmw_private *vmw_priv;
-
-	void *vmalloc;
-
-	struct mutex bo_mutex;
-	struct vmw_buffer_object *vmw_bo;
-	unsigned bo_size;
-	struct drm_framebuffer *set_fb;
-	struct drm_display_mode *set_mode;
-	u32 fb_x;
-	u32 fb_y;
-	bool bo_iowrite;
-
-	u32 pseudo_palette[17];
-
-	unsigned max_width;
-	unsigned max_height;
-
-	struct {
-		spinlock_t lock;
-		bool active;
-		unsigned x1;
-		unsigned y1;
-		unsigned x2;
-		unsigned y2;
-	} dirty;
-
-	struct drm_crtc *crtc;
-	struct drm_connector *con;
-	struct delayed_work local_work;
-};
-
-static int vmw_fb_setcolreg(unsigned regno, unsigned red, unsigned green,
-			    unsigned blue, unsigned transp,
-			    struct fb_info *info)
-{
-	struct vmw_fb_par *par = info->par;
-	u32 *pal = par->pseudo_palette;
-
-	if (regno > 15) {
-		DRM_ERROR("Bad regno %u.\n", regno);
-		return 1;
-	}
-
-	switch (par->set_fb->format->depth) {
-	case 24:
-	case 32:
-		pal[regno] = ((red & 0xff00) << 8) |
-			      (green & 0xff00) |
-			     ((blue  & 0xff00) >> 8);
-		break;
-	default:
-		DRM_ERROR("Bad depth %u, bpp %u.\n",
-			  par->set_fb->format->depth,
-			  par->set_fb->format->cpp[0] * 8);
-		return 1;
-	}
-
-	return 0;
-}
-
-static int vmw_fb_check_var(struct fb_var_screeninfo *var,
-			    struct fb_info *info)
-{
-	int depth = var->bits_per_pixel;
-	struct vmw_fb_par *par = info->par;
-	struct vmw_private *vmw_priv = par->vmw_priv;
-
-	switch (var->bits_per_pixel) {
-	case 32:
-		depth = (var->transp.length > 0) ? 32 : 24;
-		break;
-	default:
-		DRM_ERROR("Bad bpp %u.\n", var->bits_per_pixel);
-		return -EINVAL;
-	}
-
-	switch (depth) {
-	case 24:
-		var->red.offset = 16;
-		var->green.offset = 8;
-		var->blue.offset = 0;
-		var->red.length = 8;
-		var->green.length = 8;
-		var->blue.length = 8;
-		var->transp.length = 0;
-		var->transp.offset = 0;
-		break;
-	case 32:
-		var->red.offset = 16;
-		var->green.offset = 8;
-		var->blue.offset = 0;
-		var->red.length = 8;
-		var->green.length = 8;
-		var->blue.length = 8;
-		var->transp.length = 8;
-		var->transp.offset = 24;
-		break;
-	default:
-		DRM_ERROR("Bad depth %u.\n", depth);
-		return -EINVAL;
-	}
-
-	if ((var->xoffset + var->xres) > par->max_width ||
-	    (var->yoffset + var->yres) > par->max_height) {
-		DRM_ERROR("Requested geom can not fit in framebuffer\n");
-		return -EINVAL;
-	}
-
-	if (!vmw_kms_validate_mode_vram(vmw_priv,
-					var->xres * var->bits_per_pixel/8,
-					var->yoffset + var->yres)) {
-		DRM_ERROR("Requested geom can not fit in framebuffer\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int vmw_fb_blank(int blank, struct fb_info *info)
-{
-	return 0;
-}
-
-/**
- * vmw_fb_dirty_flush - flush dirty regions to the kms framebuffer
- *
- * @work: The struct work_struct associated with this task.
- *
- * This function flushes the dirty regions of the vmalloc framebuffer to the
- * kms framebuffer, and if the kms framebuffer is visible, also updated the
- * corresponding displays. Note that this function runs even if the kms
- * framebuffer is not bound to a crtc and thus not visible, but it's turned
- * off during hibernation using the par->dirty.active bool.
- */
-static void vmw_fb_dirty_flush(struct work_struct *work)
-{
-	struct vmw_fb_par *par = container_of(work, struct vmw_fb_par,
-					      local_work.work);
-	struct vmw_private *vmw_priv = par->vmw_priv;
-	struct fb_info *info = vmw_priv->fb_info;
-	unsigned long irq_flags;
-	s32 dst_x1, dst_x2, dst_y1, dst_y2, w = 0, h = 0;
-	u32 cpp, max_x, max_y;
-	struct drm_clip_rect clip;
-	struct drm_framebuffer *cur_fb;
-	u8 *src_ptr, *dst_ptr;
-	struct vmw_buffer_object *vbo = par->vmw_bo;
-	void *virtual;
-
-	if (!READ_ONCE(par->dirty.active))
-		return;
-
-	mutex_lock(&par->bo_mutex);
-	cur_fb = par->set_fb;
-	if (!cur_fb)
-		goto out_unlock;
-
-	(void) ttm_bo_reserve(&vbo->base, false, false, NULL);
-	virtual = vmw_bo_map_and_cache(vbo);
-	if (!virtual)
-		goto out_unreserve;
-
-	spin_lock_irqsave(&par->dirty.lock, irq_flags);
-	if (!par->dirty.active) {
-		spin_unlock_irqrestore(&par->dirty.lock, irq_flags);
-		goto out_unreserve;
-	}
-
-	/*
-	 * Handle panning when copying from vmalloc to framebuffer.
-	 * Clip dirty area to framebuffer.
-	 */
-	cpp = cur_fb->format->cpp[0];
-	max_x = par->fb_x + cur_fb->width;
-	max_y = par->fb_y + cur_fb->height;
-
-	dst_x1 = par->dirty.x1 - par->fb_x;
-	dst_y1 = par->dirty.y1 - par->fb_y;
-	dst_x1 = max_t(s32, dst_x1, 0);
-	dst_y1 = max_t(s32, dst_y1, 0);
-
-	dst_x2 = par->dirty.x2 - par->fb_x;
-	dst_y2 = par->dirty.y2 - par->fb_y;
-	dst_x2 = min_t(s32, dst_x2, max_x);
-	dst_y2 = min_t(s32, dst_y2, max_y);
-	w = dst_x2 - dst_x1;
-	h = dst_y2 - dst_y1;
-	w = max_t(s32, 0, w);
-	h = max_t(s32, 0, h);
-
-	par->dirty.x1 = par->dirty.x2 = 0;
-	par->dirty.y1 = par->dirty.y2 = 0;
-	spin_unlock_irqrestore(&par->dirty.lock, irq_flags);
-
-	if (w && h) {
-		dst_ptr = (u8 *)virtual  +
-			(dst_y1 * par->set_fb->pitches[0] + dst_x1 * cpp);
-		src_ptr = (u8 *)par->vmalloc +
-			((dst_y1 + par->fb_y) * info->fix.line_length +
-			 (dst_x1 + par->fb_x) * cpp);
-
-		while (h-- > 0) {
-			memcpy(dst_ptr, src_ptr, w*cpp);
-			dst_ptr += par->set_fb->pitches[0];
-			src_ptr += info->fix.line_length;
-		}
-
-		clip.x1 = dst_x1;
-		clip.x2 = dst_x2;
-		clip.y1 = dst_y1;
-		clip.y2 = dst_y2;
-	}
-
-out_unreserve:
-	ttm_bo_unreserve(&vbo->base);
-	if (w && h) {
-		WARN_ON_ONCE(par->set_fb->funcs->dirty(cur_fb, NULL, 0, 0,
-						       &clip, 1));
-		vmw_cmd_flush(vmw_priv, false);
-	}
-out_unlock:
-	mutex_unlock(&par->bo_mutex);
-}
-
-static void vmw_fb_dirty_mark(struct vmw_fb_par *par,
-			      unsigned x1, unsigned y1,
-			      unsigned width, unsigned height)
-{
-	unsigned long flags;
-	unsigned x2 = x1 + width;
-	unsigned y2 = y1 + height;
-
-	spin_lock_irqsave(&par->dirty.lock, flags);
-	if (par->dirty.x1 == par->dirty.x2) {
-		par->dirty.x1 = x1;
-		par->dirty.y1 = y1;
-		par->dirty.x2 = x2;
-		par->dirty.y2 = y2;
-		/* if we are active start the dirty work
-		 * we share the work with the defio system */
-		if (par->dirty.active)
-			schedule_delayed_work(&par->local_work,
-					      VMW_DIRTY_DELAY);
-	} else {
-		if (x1 < par->dirty.x1)
-			par->dirty.x1 = x1;
-		if (y1 < par->dirty.y1)
-			par->dirty.y1 = y1;
-		if (x2 > par->dirty.x2)
-			par->dirty.x2 = x2;
-		if (y2 > par->dirty.y2)
-			par->dirty.y2 = y2;
-	}
-	spin_unlock_irqrestore(&par->dirty.lock, flags);
-}
-
-static int vmw_fb_pan_display(struct fb_var_screeninfo *var,
-			      struct fb_info *info)
-{
-	struct vmw_fb_par *par = info->par;
-
-	if ((var->xoffset + var->xres) > var->xres_virtual ||
-	    (var->yoffset + var->yres) > var->yres_virtual) {
-		DRM_ERROR("Requested panning can not fit in framebuffer\n");
-		return -EINVAL;
-	}
-
-	mutex_lock(&par->bo_mutex);
-	par->fb_x = var->xoffset;
-	par->fb_y = var->yoffset;
-	if (par->set_fb)
-		vmw_fb_dirty_mark(par, par->fb_x, par->fb_y, par->set_fb->width,
-				  par->set_fb->height);
-	mutex_unlock(&par->bo_mutex);
-
-	return 0;
-}
-
-static void vmw_deferred_io(struct fb_info *info, struct list_head *pagereflist)
-{
-	struct vmw_fb_par *par = info->par;
-	unsigned long start, end, min, max;
-	unsigned long flags;
-	struct fb_deferred_io_pageref *pageref;
-	int y1, y2;
-
-	min = ULONG_MAX;
-	max = 0;
-	list_for_each_entry(pageref, pagereflist, list) {
-		start = pageref->offset;
-		end = start + PAGE_SIZE - 1;
-		min = min(min, start);
-		max = max(max, end);
-	}
-
-	if (min < max) {
-		y1 = min / info->fix.line_length;
-		y2 = (max / info->fix.line_length) + 1;
-
-		spin_lock_irqsave(&par->dirty.lock, flags);
-		par->dirty.x1 = 0;
-		par->dirty.y1 = y1;
-		par->dirty.x2 = info->var.xres;
-		par->dirty.y2 = y2;
-		spin_unlock_irqrestore(&par->dirty.lock, flags);
-
-		/*
-		 * Since we've already waited on this work once, try to
-		 * execute asap.
-		 */
-		cancel_delayed_work(&par->local_work);
-		schedule_delayed_work(&par->local_work, 0);
-	}
-};
-
-static struct fb_deferred_io vmw_defio = {
-	.delay		= VMW_DIRTY_DELAY,
-	.deferred_io	= vmw_deferred_io,
-};
-
-/*
- * Draw code
- */
-
-static void vmw_fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
-{
-	cfb_fillrect(info, rect);
-	vmw_fb_dirty_mark(info->par, rect->dx, rect->dy,
-			  rect->width, rect->height);
-}
-
-static void vmw_fb_copyarea(struct fb_info *info, const struct fb_copyarea *region)
-{
-	cfb_copyarea(info, region);
-	vmw_fb_dirty_mark(info->par, region->dx, region->dy,
-			  region->width, region->height);
-}
-
-static void vmw_fb_imageblit(struct fb_info *info, const struct fb_image *image)
-{
-	cfb_imageblit(info, image);
-	vmw_fb_dirty_mark(info->par, image->dx, image->dy,
-			  image->width, image->height);
-}
-
-/*
- * Bring up code
- */
-
-static int vmw_fb_create_bo(struct vmw_private *vmw_priv,
-			    size_t size, struct vmw_buffer_object **out)
-{
-	struct vmw_buffer_object *vmw_bo;
-	int ret;
-
-	ret = vmw_bo_create(vmw_priv, size,
-			      &vmw_sys_placement,
-			      false, false,
-			      &vmw_bo_bo_free, &vmw_bo);
-	if (unlikely(ret != 0))
-		return ret;
-
-	*out = vmw_bo;
-
-	return ret;
-}
-
-static int vmw_fb_compute_depth(struct fb_var_screeninfo *var,
-				int *depth)
-{
-	switch (var->bits_per_pixel) {
-	case 32:
-		*depth = (var->transp.length > 0) ? 32 : 24;
-		break;
-	default:
-		DRM_ERROR("Bad bpp %u.\n", var->bits_per_pixel);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int vmwgfx_set_config_internal(struct drm_mode_set *set)
-{
-	struct drm_crtc *crtc = set->crtc;
-	struct drm_modeset_acquire_ctx ctx;
-	int ret;
-
-	drm_modeset_acquire_init(&ctx, 0);
-
-restart:
-	ret = crtc->funcs->set_config(set, &ctx);
-
-	if (ret == -EDEADLK) {
-		drm_modeset_backoff(&ctx);
-		goto restart;
-	}
-
-	drm_modeset_drop_locks(&ctx);
-	drm_modeset_acquire_fini(&ctx);
-
-	return ret;
-}
-
-static int vmw_fb_kms_detach(struct vmw_fb_par *par,
-			     bool detach_bo,
-			     bool unref_bo)
-{
-	struct drm_framebuffer *cur_fb = par->set_fb;
-	int ret;
-
-	/* Detach the KMS framebuffer from crtcs */
-	if (par->set_mode) {
-		struct drm_mode_set set;
-
-		set.crtc = par->crtc;
-		set.x = 0;
-		set.y = 0;
-		set.mode = NULL;
-		set.fb = NULL;
-		set.num_connectors = 0;
-		set.connectors = &par->con;
-		ret = vmwgfx_set_config_internal(&set);
-		if (ret) {
-			DRM_ERROR("Could not unset a mode.\n");
-			return ret;
-		}
-		drm_mode_destroy(&par->vmw_priv->drm, par->set_mode);
-		par->set_mode = NULL;
-	}
-
-	if (cur_fb) {
-		drm_framebuffer_put(cur_fb);
-		par->set_fb = NULL;
-	}
-
-	if (par->vmw_bo && detach_bo && unref_bo)
-		vmw_bo_unreference(&par->vmw_bo);
-
-	return 0;
-}
-
-static int vmw_fb_kms_framebuffer(struct fb_info *info)
-{
-	struct drm_mode_fb_cmd2 mode_cmd = {0};
-	struct vmw_fb_par *par = info->par;
-	struct fb_var_screeninfo *var = &info->var;
-	struct drm_framebuffer *cur_fb;
-	struct vmw_framebuffer *vfb;
-	int ret = 0, depth;
-	size_t new_bo_size;
-
-	ret = vmw_fb_compute_depth(var, &depth);
-	if (ret)
-		return ret;
-
-	mode_cmd.width = var->xres;
-	mode_cmd.height = var->yres;
-	mode_cmd.pitches[0] = ((var->bits_per_pixel + 7) / 8) * mode_cmd.width;
-	mode_cmd.pixel_format =
-		drm_mode_legacy_fb_format(var->bits_per_pixel, depth);
-
-	cur_fb = par->set_fb;
-	if (cur_fb && cur_fb->width == mode_cmd.width &&
-	    cur_fb->height == mode_cmd.height &&
-	    cur_fb->format->format == mode_cmd.pixel_format &&
-	    cur_fb->pitches[0] == mode_cmd.pitches[0])
-		return 0;
-
-	/* Need new buffer object ? */
-	new_bo_size = (size_t) mode_cmd.pitches[0] * (size_t) mode_cmd.height;
-	ret = vmw_fb_kms_detach(par,
-				par->bo_size < new_bo_size ||
-				par->bo_size > 2*new_bo_size,
-				true);
-	if (ret)
-		return ret;
-
-	if (!par->vmw_bo) {
-		ret = vmw_fb_create_bo(par->vmw_priv, new_bo_size,
-				       &par->vmw_bo);
-		if (ret) {
-			DRM_ERROR("Failed creating a buffer object for "
-				  "fbdev.\n");
-			return ret;
-		}
-		par->bo_size = new_bo_size;
-	}
-
-	vfb = vmw_kms_new_framebuffer(par->vmw_priv, par->vmw_bo, NULL,
-				      true, &mode_cmd);
-	if (IS_ERR(vfb))
-		return PTR_ERR(vfb);
-
-	par->set_fb = &vfb->base;
-
-	return 0;
-}
-
-static int vmw_fb_set_par(struct fb_info *info)
-{
-	struct vmw_fb_par *par = info->par;
-	struct vmw_private *vmw_priv = par->vmw_priv;
-	struct drm_mode_set set;
-	struct fb_var_screeninfo *var = &info->var;
-	struct drm_display_mode new_mode = { DRM_MODE("fb_mode",
-		DRM_MODE_TYPE_DRIVER,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-		DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC)
-	};
-	struct drm_display_mode *mode;
-	int ret;
-
-	mode = drm_mode_duplicate(&vmw_priv->drm, &new_mode);
-	if (!mode) {
-		DRM_ERROR("Could not create new fb mode.\n");
-		return -ENOMEM;
-	}
-
-	mode->hdisplay = var->xres;
-	mode->vdisplay = var->yres;
-	vmw_guess_mode_timing(mode);
-
-	if (!vmw_kms_validate_mode_vram(vmw_priv,
-					mode->hdisplay *
-					DIV_ROUND_UP(var->bits_per_pixel, 8),
-					mode->vdisplay)) {
-		drm_mode_destroy(&vmw_priv->drm, mode);
-		return -EINVAL;
-	}
-
-	mutex_lock(&par->bo_mutex);
-	ret = vmw_fb_kms_framebuffer(info);
-	if (ret)
-		goto out_unlock;
-
-	par->fb_x = var->xoffset;
-	par->fb_y = var->yoffset;
-
-	set.crtc = par->crtc;
-	set.x = 0;
-	set.y = 0;
-	set.mode = mode;
-	set.fb = par->set_fb;
-	set.num_connectors = 1;
-	set.connectors = &par->con;
-
-	ret = vmwgfx_set_config_internal(&set);
-	if (ret)
-		goto out_unlock;
-
-	vmw_fb_dirty_mark(par, par->fb_x, par->fb_y,
-			  par->set_fb->width, par->set_fb->height);
-
-	/* If there already was stuff dirty we wont
-	 * schedule a new work, so lets do it now */
-
-	schedule_delayed_work(&par->local_work, 0);
-
-out_unlock:
-	if (par->set_mode)
-		drm_mode_destroy(&vmw_priv->drm, par->set_mode);
-	par->set_mode = mode;
-
-	mutex_unlock(&par->bo_mutex);
-
-	return ret;
-}
-
-
-static const struct fb_ops vmw_fb_ops = {
-	.owner = THIS_MODULE,
-	.fb_check_var = vmw_fb_check_var,
-	.fb_set_par = vmw_fb_set_par,
-	.fb_setcolreg = vmw_fb_setcolreg,
-	.fb_fillrect = vmw_fb_fillrect,
-	.fb_copyarea = vmw_fb_copyarea,
-	.fb_imageblit = vmw_fb_imageblit,
-	.fb_pan_display = vmw_fb_pan_display,
-	.fb_blank = vmw_fb_blank,
-	.fb_mmap = fb_deferred_io_mmap,
-};
-
-int vmw_fb_init(struct vmw_private *vmw_priv)
-{
-	struct device *device = vmw_priv->drm.dev;
-	struct vmw_fb_par *par;
-	struct fb_info *info;
-	unsigned fb_width, fb_height;
-	unsigned int fb_bpp, fb_pitch, fb_size;
-	struct drm_display_mode *init_mode;
-	int ret;
-
-	fb_bpp = 32;
-
-	/* XXX As shouldn't these be as well. */
-	fb_width = min(vmw_priv->fb_max_width, (unsigned)2048);
-	fb_height = min(vmw_priv->fb_max_height, (unsigned)2048);
-
-	fb_pitch = fb_width * fb_bpp / 8;
-	fb_size = fb_pitch * fb_height;
-
-	info = framebuffer_alloc(sizeof(*par), device);
-	if (!info)
-		return -ENOMEM;
-
-	/*
-	 * Par
-	 */
-	vmw_priv->fb_info = info;
-	par = info->par;
-	memset(par, 0, sizeof(*par));
-	INIT_DELAYED_WORK(&par->local_work, &vmw_fb_dirty_flush);
-	par->vmw_priv = vmw_priv;
-	par->vmalloc = NULL;
-	par->max_width = fb_width;
-	par->max_height = fb_height;
-
-	ret = vmw_kms_fbdev_init_data(vmw_priv, 0, par->max_width,
-				      par->max_height, &par->con,
-				      &par->crtc, &init_mode);
-	if (ret)
-		goto err_kms;
-
-	info->var.xres = init_mode->hdisplay;
-	info->var.yres = init_mode->vdisplay;
-
-	/*
-	 * Create buffers and alloc memory
-	 */
-	par->vmalloc = vzalloc(fb_size);
-	if (unlikely(par->vmalloc == NULL)) {
-		ret = -ENOMEM;
-		goto err_free;
-	}
-
-	/*
-	 * Fixed and var
-	 */
-	strcpy(info->fix.id, "svgadrmfb");
-	info->fix.type = FB_TYPE_PACKED_PIXELS;
-	info->fix.visual = FB_VISUAL_TRUECOLOR;
-	info->fix.type_aux = 0;
-	info->fix.xpanstep = 1; /* doing it in hw */
-	info->fix.ypanstep = 1; /* doing it in hw */
-	info->fix.ywrapstep = 0;
-	info->fix.accel = FB_ACCEL_NONE;
-	info->fix.line_length = fb_pitch;
-
-	info->fix.smem_start = 0;
-	info->fix.smem_len = fb_size;
-
-	info->pseudo_palette = par->pseudo_palette;
-	info->screen_base = (char __iomem *)par->vmalloc;
-	info->screen_size = fb_size;
-
-	info->fbops = &vmw_fb_ops;
-
-	/* 24 depth per default */
-	info->var.red.offset = 16;
-	info->var.green.offset = 8;
-	info->var.blue.offset = 0;
-	info->var.red.length = 8;
-	info->var.green.length = 8;
-	info->var.blue.length = 8;
-	info->var.transp.offset = 0;
-	info->var.transp.length = 0;
-
-	info->var.xres_virtual = fb_width;
-	info->var.yres_virtual = fb_height;
-	info->var.bits_per_pixel = fb_bpp;
-	info->var.xoffset = 0;
-	info->var.yoffset = 0;
-	info->var.activate = FB_ACTIVATE_NOW;
-	info->var.height = -1;
-	info->var.width = -1;
-
-	/* Use default scratch pixmap (info->pixmap.flags = FB_PIXMAP_SYSTEM) */
-	info->apertures = alloc_apertures(1);
-	if (!info->apertures) {
-		ret = -ENOMEM;
-		goto err_aper;
-	}
-	info->apertures->ranges[0].base = vmw_priv->vram_start;
-	info->apertures->ranges[0].size = vmw_priv->vram_size;
-
-	/*
-	 * Dirty & Deferred IO
-	 */
-	par->dirty.x1 = par->dirty.x2 = 0;
-	par->dirty.y1 = par->dirty.y2 = 0;
-	par->dirty.active = true;
-	spin_lock_init(&par->dirty.lock);
-	mutex_init(&par->bo_mutex);
-	info->fbdefio = &vmw_defio;
-	fb_deferred_io_init(info);
-
-	ret = register_framebuffer(info);
-	if (unlikely(ret != 0))
-		goto err_defio;
-
-	vmw_fb_set_par(info);
-
-	return 0;
-
-err_defio:
-	fb_deferred_io_cleanup(info);
-err_aper:
-err_free:
-	vfree(par->vmalloc);
-err_kms:
-	framebuffer_release(info);
-	vmw_priv->fb_info = NULL;
-
-	return ret;
-}
-
-int vmw_fb_close(struct vmw_private *vmw_priv)
-{
-	struct fb_info *info;
-	struct vmw_fb_par *par;
-
-	if (!vmw_priv->fb_info)
-		return 0;
-
-	info = vmw_priv->fb_info;
-	par = info->par;
-
-	/* ??? order */
-	fb_deferred_io_cleanup(info);
-	cancel_delayed_work_sync(&par->local_work);
-	unregister_framebuffer(info);
-
-	mutex_lock(&par->bo_mutex);
-	(void) vmw_fb_kms_detach(par, true, true);
-	mutex_unlock(&par->bo_mutex);
-
-	vfree(par->vmalloc);
-	framebuffer_release(info);
-
-	return 0;
-}
-
-int vmw_fb_off(struct vmw_private *vmw_priv)
-{
-	struct fb_info *info;
-	struct vmw_fb_par *par;
-	unsigned long flags;
-
-	if (!vmw_priv->fb_info)
-		return -EINVAL;
-
-	info = vmw_priv->fb_info;
-	par = info->par;
-
-	spin_lock_irqsave(&par->dirty.lock, flags);
-	par->dirty.active = false;
-	spin_unlock_irqrestore(&par->dirty.lock, flags);
-
-	flush_delayed_work(&info->deferred_work);
-	flush_delayed_work(&par->local_work);
-
-	return 0;
-}
-
-int vmw_fb_on(struct vmw_private *vmw_priv)
-{
-	struct fb_info *info;
-	struct vmw_fb_par *par;
-	unsigned long flags;
-
-	if (!vmw_priv->fb_info)
-		return -EINVAL;
-
-	info = vmw_priv->fb_info;
-	par = info->par;
-
-	spin_lock_irqsave(&par->dirty.lock, flags);
-	par->dirty.active = true;
-	spin_unlock_irqrestore(&par->dirty.lock, flags);
-
-	/*
-	 * Need to reschedule a dirty update, because otherwise that's
-	 * only done in dirty_mark() if the previous coalesced
-	 * dirty region was empty.
-	 */
-	schedule_delayed_work(&par->local_work, 0);
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index b1aed051b41a..5b30e4ba2811 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -31,6 +31,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_rect.h>
 #include <drm/drm_sysfs.h>
+#include <drm/drm_edid.h>
 
 #include "vmwgfx_kms.h"
 
@@ -1988,6 +1989,8 @@ int vmw_kms_init(struct vmw_private *dev_priv)
 	dev->mode_config.min_height = 1;
 	dev->mode_config.max_width = dev_priv->texture_max_width;
 	dev->mode_config.max_height = dev_priv->texture_max_height;
+	dev->mode_config.preferred_depth = dev_priv->assume_16bpp ? 16 : 32;
+	dev->mode_config.prefer_shadow_fbdev = !dev_priv->has_mob;
 
 	drm_mode_create_suggested_offset_properties(dev);
 	vmw_kms_create_hotplug_mode_update_property(dev_priv);
@@ -2082,13 +2085,12 @@ int vmw_kms_write_svga(struct vmw_private *vmw_priv,
 	return 0;
 }
 
+static
 bool vmw_kms_validate_mode_vram(struct vmw_private *dev_priv,
-				uint32_t pitch,
-				uint32_t height)
+				u64 pitch,
+				u64 height)
 {
-	return ((u64) pitch * (u64) height) < (u64)
-		((dev_priv->active_display_unit == vmw_du_screen_target) ?
-		 dev_priv->max_primary_mem : dev_priv->vram_size);
+	return (pitch * height) < (u64)dev_priv->vram_size;
 }
 
 /**
@@ -2134,8 +2136,8 @@ static int vmw_du_update_layout(struct vmw_private *dev_priv,
 			du->gui_x = rects[du->unit].x1;
 			du->gui_y = rects[du->unit].y1;
 		} else {
-			du->pref_width = 800;
-			du->pref_height = 600;
+			du->pref_width  = VMWGFX_MIN_INITIAL_WIDTH;
+			du->pref_height = VMWGFX_MIN_INITIAL_HEIGHT;
 			du->pref_active = false;
 			du->gui_x = 0;
 			du->gui_y = 0;
@@ -2162,13 +2164,13 @@ static int vmw_du_update_layout(struct vmw_private *dev_priv,
 		}
 		con->status = vmw_du_connector_detect(con, true);
 	}
-
-	drm_sysfs_hotplug_event(dev);
 out_fini:
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 	mutex_unlock(&dev->mode_config.mutex);
 
+	drm_sysfs_hotplug_event(dev);
+
 	return 0;
 }
 
@@ -2211,107 +2213,6 @@ vmw_du_connector_detect(struct drm_connector *connector, bool force)
 		connector_status_connected : connector_status_disconnected);
 }
 
-static struct drm_display_mode vmw_kms_connector_builtin[] = {
-	/* 640x480@60Hz */
-	{ DRM_MODE("640x480", DRM_MODE_TYPE_DRIVER, 25175, 640, 656,
-		   752, 800, 0, 480, 489, 492, 525, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC) },
-	/* 800x600@60Hz */
-	{ DRM_MODE("800x600", DRM_MODE_TYPE_DRIVER, 40000, 800, 840,
-		   968, 1056, 0, 600, 601, 605, 628, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1024x768@60Hz */
-	{ DRM_MODE("1024x768", DRM_MODE_TYPE_DRIVER, 65000, 1024, 1048,
-		   1184, 1344, 0, 768, 771, 777, 806, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC) },
-	/* 1152x864@75Hz */
-	{ DRM_MODE("1152x864", DRM_MODE_TYPE_DRIVER, 108000, 1152, 1216,
-		   1344, 1600, 0, 864, 865, 868, 900, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1280x720@60Hz */
-	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 74500, 1280, 1344,
-		   1472, 1664, 0, 720, 723, 728, 748, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1280x768@60Hz */
-	{ DRM_MODE("1280x768", DRM_MODE_TYPE_DRIVER, 79500, 1280, 1344,
-		   1472, 1664, 0, 768, 771, 778, 798, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1280x800@60Hz */
-	{ DRM_MODE("1280x800", DRM_MODE_TYPE_DRIVER, 83500, 1280, 1352,
-		   1480, 1680, 0, 800, 803, 809, 831, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC) },
-	/* 1280x960@60Hz */
-	{ DRM_MODE("1280x960", DRM_MODE_TYPE_DRIVER, 108000, 1280, 1376,
-		   1488, 1800, 0, 960, 961, 964, 1000, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1280x1024@60Hz */
-	{ DRM_MODE("1280x1024", DRM_MODE_TYPE_DRIVER, 108000, 1280, 1328,
-		   1440, 1688, 0, 1024, 1025, 1028, 1066, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1360x768@60Hz */
-	{ DRM_MODE("1360x768", DRM_MODE_TYPE_DRIVER, 85500, 1360, 1424,
-		   1536, 1792, 0, 768, 771, 777, 795, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1440x1050@60Hz */
-	{ DRM_MODE("1400x1050", DRM_MODE_TYPE_DRIVER, 121750, 1400, 1488,
-		   1632, 1864, 0, 1050, 1053, 1057, 1089, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1440x900@60Hz */
-	{ DRM_MODE("1440x900", DRM_MODE_TYPE_DRIVER, 106500, 1440, 1520,
-		   1672, 1904, 0, 900, 903, 909, 934, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1600x1200@60Hz */
-	{ DRM_MODE("1600x1200", DRM_MODE_TYPE_DRIVER, 162000, 1600, 1664,
-		   1856, 2160, 0, 1200, 1201, 1204, 1250, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1680x1050@60Hz */
-	{ DRM_MODE("1680x1050", DRM_MODE_TYPE_DRIVER, 146250, 1680, 1784,
-		   1960, 2240, 0, 1050, 1053, 1059, 1089, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1792x1344@60Hz */
-	{ DRM_MODE("1792x1344", DRM_MODE_TYPE_DRIVER, 204750, 1792, 1920,
-		   2120, 2448, 0, 1344, 1345, 1348, 1394, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1853x1392@60Hz */
-	{ DRM_MODE("1856x1392", DRM_MODE_TYPE_DRIVER, 218250, 1856, 1952,
-		   2176, 2528, 0, 1392, 1393, 1396, 1439, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1920x1080@60Hz */
-	{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 173000, 1920, 2048,
-		   2248, 2576, 0, 1080, 1083, 1088, 1120, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1920x1200@60Hz */
-	{ DRM_MODE("1920x1200", DRM_MODE_TYPE_DRIVER, 193250, 1920, 2056,
-		   2256, 2592, 0, 1200, 1203, 1209, 1245, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1920x1440@60Hz */
-	{ DRM_MODE("1920x1440", DRM_MODE_TYPE_DRIVER, 234000, 1920, 2048,
-		   2256, 2600, 0, 1440, 1441, 1444, 1500, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 2560x1440@60Hz */
-	{ DRM_MODE("2560x1440", DRM_MODE_TYPE_DRIVER, 241500, 2560, 2608,
-		   2640, 2720, 0, 1440, 1443, 1448, 1481, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC) },
-	/* 2560x1600@60Hz */
-	{ DRM_MODE("2560x1600", DRM_MODE_TYPE_DRIVER, 348500, 2560, 2752,
-		   3032, 3504, 0, 1600, 1603, 1609, 1658, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 2880x1800@60Hz */
-	{ DRM_MODE("2880x1800", DRM_MODE_TYPE_DRIVER, 337500, 2880, 2928,
-		   2960, 3040, 0, 1800, 1803, 1809, 1852, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC) },
-	/* 3840x2160@60Hz */
-	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 533000, 3840, 3888,
-		   3920, 4000, 0, 2160, 2163, 2168, 2222, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC) },
-	/* 3840x2400@60Hz */
-	{ DRM_MODE("3840x2400", DRM_MODE_TYPE_DRIVER, 592250, 3840, 3888,
-		   3920, 4000, 0, 2400, 2403, 2409, 2469, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC) },
-	/* Terminate */
-	{ DRM_MODE("", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) },
-};
-
 /**
  * vmw_guess_mode_timing - Provide fake timings for a
  * 60Hz vrefresh mode.
@@ -2333,88 +2234,6 @@ void vmw_guess_mode_timing(struct drm_display_mode *mode)
 }
 
 
-int vmw_du_connector_fill_modes(struct drm_connector *connector,
-				uint32_t max_width, uint32_t max_height)
-{
-	struct vmw_display_unit *du = vmw_connector_to_du(connector);
-	struct drm_device *dev = connector->dev;
-	struct vmw_private *dev_priv = vmw_priv(dev);
-	struct drm_display_mode *mode = NULL;
-	struct drm_display_mode *bmode;
-	struct drm_display_mode prefmode = { DRM_MODE("preferred",
-		DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-		DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC)
-	};
-	int i;
-	u32 assumed_bpp = 4;
-
-	if (dev_priv->assume_16bpp)
-		assumed_bpp = 2;
-
-	max_width  = min(max_width,  dev_priv->texture_max_width);
-	max_height = min(max_height, dev_priv->texture_max_height);
-
-	/*
-	 * For STDU extra limit for a mode on SVGA_REG_SCREENTARGET_MAX_WIDTH/
-	 * HEIGHT registers.
-	 */
-	if (dev_priv->active_display_unit == vmw_du_screen_target) {
-		max_width  = min(max_width,  dev_priv->stdu_max_width);
-		max_height = min(max_height, dev_priv->stdu_max_height);
-	}
-
-	/* Add preferred mode */
-	mode = drm_mode_duplicate(dev, &prefmode);
-	if (!mode)
-		return 0;
-	mode->hdisplay = du->pref_width;
-	mode->vdisplay = du->pref_height;
-	vmw_guess_mode_timing(mode);
-	drm_mode_set_name(mode);
-
-	if (vmw_kms_validate_mode_vram(dev_priv,
-					mode->hdisplay * assumed_bpp,
-					mode->vdisplay)) {
-		drm_mode_probed_add(connector, mode);
-	} else {
-		drm_mode_destroy(dev, mode);
-		mode = NULL;
-	}
-
-	if (du->pref_mode) {
-		list_del_init(&du->pref_mode->head);
-		drm_mode_destroy(dev, du->pref_mode);
-	}
-
-	/* mode might be null here, this is intended */
-	du->pref_mode = mode;
-
-	for (i = 0; vmw_kms_connector_builtin[i].type != 0; i++) {
-		bmode = &vmw_kms_connector_builtin[i];
-		if (bmode->hdisplay > max_width ||
-		    bmode->vdisplay > max_height)
-			continue;
-
-		if (!vmw_kms_validate_mode_vram(dev_priv,
-						bmode->hdisplay * assumed_bpp,
-						bmode->vdisplay))
-			continue;
-
-		mode = drm_mode_duplicate(dev, bmode);
-		if (!mode)
-			return 0;
-
-		drm_mode_probed_add(connector, mode);
-	}
-
-	drm_connector_list_update(connector);
-	/* Move the prefered mode first, help apps pick the right mode. */
-	drm_mode_sort(&connector->modes);
-
-	return 1;
-}
-
 /**
  * vmw_kms_update_layout_ioctl - Handler for DRM_VMW_UPDATE_LAYOUT ioctl
  * @dev: drm device for the ioctl
@@ -2448,10 +2267,9 @@ int vmw_kms_update_layout_ioctl(struct drm_device *dev, void *data,
 	int ret, i;
 
 	if (!arg->num_outputs) {
-		struct drm_rect def_rect = {0, 0, 800, 600};
-		VMW_DEBUG_KMS("Default layout x1 = %d y1 = %d x2 = %d y2 = %d\n",
-			      def_rect.x1, def_rect.y1,
-			      def_rect.x2, def_rect.y2);
+		struct drm_rect def_rect = {0, 0,
+					    VMWGFX_MIN_INITIAL_WIDTH,
+					    VMWGFX_MIN_INITIAL_HEIGHT};
 		vmw_du_update_layout(dev_priv, 1, &def_rect);
 		return 0;
 	}
@@ -2746,68 +2564,6 @@ int vmw_kms_update_proxy(struct vmw_resource *res,
 	return 0;
 }
 
-int vmw_kms_fbdev_init_data(struct vmw_private *dev_priv,
-			    unsigned unit,
-			    u32 max_width,
-			    u32 max_height,
-			    struct drm_connector **p_con,
-			    struct drm_crtc **p_crtc,
-			    struct drm_display_mode **p_mode)
-{
-	struct drm_connector *con;
-	struct vmw_display_unit *du;
-	struct drm_display_mode *mode;
-	int i = 0;
-	int ret = 0;
-
-	mutex_lock(&dev_priv->drm.mode_config.mutex);
-	list_for_each_entry(con, &dev_priv->drm.mode_config.connector_list,
-			    head) {
-		if (i == unit)
-			break;
-
-		++i;
-	}
-
-	if (&con->head == &dev_priv->drm.mode_config.connector_list) {
-		DRM_ERROR("Could not find initial display unit.\n");
-		ret = -EINVAL;
-		goto out_unlock;
-	}
-
-	if (list_empty(&con->modes))
-		(void) vmw_du_connector_fill_modes(con, max_width, max_height);
-
-	if (list_empty(&con->modes)) {
-		DRM_ERROR("Could not find initial display mode.\n");
-		ret = -EINVAL;
-		goto out_unlock;
-	}
-
-	du = vmw_connector_to_du(con);
-	*p_con = con;
-	*p_crtc = &du->crtc;
-
-	list_for_each_entry(mode, &con->modes, head) {
-		if (mode->type & DRM_MODE_TYPE_PREFERRED)
-			break;
-	}
-
-	if (&mode->head == &con->modes) {
-		WARN_ONCE(true, "Could not find initial preferred mode.\n");
-		*p_mode = list_first_entry(&con->modes,
-					   struct drm_display_mode,
-					   head);
-	} else {
-		*p_mode = mode;
-	}
-
- out_unlock:
-	mutex_unlock(&dev_priv->drm.mode_config.mutex);
-
-	return ret;
-}
-
 /**
  * vmw_kms_create_implicit_placement_property - Set up the implicit placement
  * property.
@@ -3006,3 +2762,84 @@ int vmw_du_helper_plane_update(struct vmw_du_update_plane *update)
 	vmw_validation_unref_lists(&val_ctx);
 	return ret;
 }
+
+/**
+ * vmw_connector_mode_valid - implements drm_connector_helper_funcs.mode_valid callback
+ *
+ * @connector: the drm connector, part of a DU container
+ * @mode: drm mode to check
+ *
+ * Returns MODE_OK on success, or a drm_mode_status error code.
+ */
+enum drm_mode_status vmw_connector_mode_valid(struct drm_connector *connector,
+					      struct drm_display_mode *mode)
+{
+	enum drm_mode_status ret;
+	struct drm_device *dev = connector->dev;
+	struct vmw_private *dev_priv = vmw_priv(dev);
+	u32 assumed_cpp = 4;
+
+	if (dev_priv->assume_16bpp)
+		assumed_cpp = 2;
+
+	ret = drm_mode_validate_size(mode, dev_priv->texture_max_width,
+				     dev_priv->texture_max_height);
+	if (ret != MODE_OK)
+		return ret;
+
+	if (!vmw_kms_validate_mode_vram(dev_priv,
+					mode->hdisplay * assumed_cpp,
+					mode->vdisplay))
+		return MODE_MEM;
+
+	return MODE_OK;
+}
+
+/**
+ * vmw_connector_get_modes - implements drm_connector_helper_funcs.get_modes callback
+ *
+ * @connector: the drm connector, part of a DU container
+ *
+ * Returns the number of added modes.
+ */
+int vmw_connector_get_modes(struct drm_connector *connector)
+{
+	struct vmw_display_unit *du = vmw_connector_to_du(connector);
+	struct drm_device *dev = connector->dev;
+	struct vmw_private *dev_priv = vmw_priv(dev);
+	struct drm_display_mode *mode = NULL;
+	struct drm_display_mode prefmode = { DRM_MODE("preferred",
+		DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC)
+	};
+	u32 max_width;
+	u32 max_height;
+	u32 num_modes;
+
+	/* Add preferred mode */
+	mode = drm_mode_duplicate(dev, &prefmode);
+	if (!mode)
+		return 0;
+
+	mode->hdisplay = du->pref_width;
+	mode->vdisplay = du->pref_height;
+	vmw_guess_mode_timing(mode);
+	drm_mode_set_name(mode);
+
+	drm_mode_probed_add(connector, mode);
+	drm_dbg_kms(dev, "preferred mode " DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
+
+	/* Probe connector for all modes not exceeding our geom limits */
+	max_width  = dev_priv->texture_max_width;
+	max_height = dev_priv->texture_max_height;
+
+	if (dev_priv->active_display_unit == vmw_du_screen_target) {
+		max_width  = min(dev_priv->stdu_max_width,  max_width);
+		max_height = min(dev_priv->stdu_max_height, max_height);
+	}
+
+	num_modes = 1 + drm_add_modes_noedid(connector, max_width, max_height);
+
+	return num_modes;
+}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index b116600b343a..1099de1ece4b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -379,7 +379,6 @@ struct vmw_display_unit {
 	unsigned pref_width;
 	unsigned pref_height;
 	bool pref_active;
-	struct drm_display_mode *pref_mode;
 
 	/*
 	 * Gui positioning
@@ -429,8 +428,6 @@ void vmw_du_connector_save(struct drm_connector *connector);
 void vmw_du_connector_restore(struct drm_connector *connector);
 enum drm_connector_status
 vmw_du_connector_detect(struct drm_connector *connector, bool force);
-int vmw_du_connector_fill_modes(struct drm_connector *connector,
-				uint32_t max_width, uint32_t max_height);
 int vmw_kms_helper_dirty(struct vmw_private *dev_priv,
 			 struct vmw_framebuffer *framebuffer,
 			 const struct drm_clip_rect *clips,
@@ -439,6 +436,9 @@ int vmw_kms_helper_dirty(struct vmw_private *dev_priv,
 			 int num_clips,
 			 int increment,
 			 struct vmw_kms_dirty *dirty);
+enum drm_mode_status vmw_connector_mode_valid(struct drm_connector *connector,
+					      struct drm_display_mode *mode);
+int vmw_connector_get_modes(struct drm_connector *connector);
 
 void vmw_kms_helper_validation_finish(struct vmw_private *dev_priv,
 				      struct drm_file *file_priv,
@@ -458,13 +458,6 @@ vmw_kms_new_framebuffer(struct vmw_private *dev_priv,
 			struct vmw_surface *surface,
 			bool only_2d,
 			const struct drm_mode_fb_cmd2 *mode_cmd);
-int vmw_kms_fbdev_init_data(struct vmw_private *dev_priv,
-			    unsigned unit,
-			    u32 max_width,
-			    u32 max_height,
-			    struct drm_connector **p_con,
-			    struct drm_crtc **p_crtc,
-			    struct drm_display_mode **p_mode);
 void vmw_guess_mode_timing(struct drm_display_mode *mode);
 void vmw_kms_update_implicit_fb(struct vmw_private *dev_priv);
 void vmw_kms_create_implicit_placement_property(struct vmw_private *dev_priv);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index ac72c20715f3..fdaf7d28cb21 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -263,7 +263,7 @@ static void vmw_ldu_connector_destroy(struct drm_connector *connector)
 static const struct drm_connector_funcs vmw_legacy_connector_funcs = {
 	.dpms = vmw_du_connector_dpms,
 	.detect = vmw_du_connector_detect,
-	.fill_modes = vmw_du_connector_fill_modes,
+	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = vmw_ldu_connector_destroy,
 	.reset = vmw_du_connector_reset,
 	.atomic_duplicate_state = vmw_du_connector_duplicate_state,
@@ -272,6 +272,8 @@ static const struct drm_connector_funcs vmw_legacy_connector_funcs = {
 
 static const struct
 drm_connector_helper_funcs vmw_ldu_connector_helper_funcs = {
+	.get_modes = vmw_connector_get_modes,
+	.mode_valid = vmw_connector_mode_valid
 };
 
 static int vmw_kms_ldu_do_bo_dirty(struct vmw_private *dev_priv,
@@ -408,7 +410,6 @@ static int vmw_ldu_init(struct vmw_private *dev_priv, unsigned unit)
 	ldu->base.pref_active = (unit == 0);
 	ldu->base.pref_width = dev_priv->initial_width;
 	ldu->base.pref_height = dev_priv->initial_height;
-	ldu->base.pref_mode = NULL;
 
 	/*
 	 * Remove this after enabling atomic because property values can
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index e1f36a09c59c..e33684f56eda 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -346,7 +346,7 @@ static void vmw_sou_connector_destroy(struct drm_connector *connector)
 static const struct drm_connector_funcs vmw_sou_connector_funcs = {
 	.dpms = vmw_du_connector_dpms,
 	.detect = vmw_du_connector_detect,
-	.fill_modes = vmw_du_connector_fill_modes,
+	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = vmw_sou_connector_destroy,
 	.reset = vmw_du_connector_reset,
 	.atomic_duplicate_state = vmw_du_connector_duplicate_state,
@@ -356,6 +356,8 @@ static const struct drm_connector_funcs vmw_sou_connector_funcs = {
 
 static const struct
 drm_connector_helper_funcs vmw_sou_connector_helper_funcs = {
+	.get_modes = vmw_connector_get_modes,
+	.mode_valid = vmw_connector_mode_valid
 };
 
 
@@ -827,7 +829,6 @@ static int vmw_sou_init(struct vmw_private *dev_priv, unsigned unit)
 	sou->base.pref_active = (unit == 0);
 	sou->base.pref_width = dev_priv->initial_width;
 	sou->base.pref_height = dev_priv->initial_height;
-	sou->base.pref_mode = NULL;
 
 	/*
 	 * Remove this after enabling atomic because property values can
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 0090abe89254..6dd33d1258d1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -40,7 +40,14 @@
 #define vmw_connector_to_stdu(x) \
 	container_of(x, struct vmw_screen_target_display_unit, base.connector)
 
-
+/*
+ * Some renderers such as llvmpipe will align the width and height of their
+ * buffers to match their tile size. We need to keep this in mind when exposing
+ * modes to userspace so that this possible over-allocation will not exceed
+ * graphics memory. 64x64 pixels seems to be a reasonable upper bound for the
+ * tile size of current renderers.
+ */
+#define GPU_TILE_SIZE 64
 
 enum stdu_content_type {
 	SAME_AS_DISPLAY = 0,
@@ -972,12 +979,46 @@ static void vmw_stdu_connector_destroy(struct drm_connector *connector)
 	vmw_stdu_destroy(vmw_connector_to_stdu(connector));
 }
 
+static enum drm_mode_status
+vmw_stdu_connector_mode_valid(struct drm_connector *connector,
+			      struct drm_display_mode *mode)
+{
+	enum drm_mode_status ret;
+	struct drm_device *dev = connector->dev;
+	struct vmw_private *dev_priv = vmw_priv(dev);
+	u64 assumed_cpp = dev_priv->assume_16bpp ? 2 : 4;
+	/* Align width and height to account for GPU tile over-alignment */
+	u64 required_mem = ALIGN(mode->hdisplay, GPU_TILE_SIZE) *
+			   ALIGN(mode->vdisplay, GPU_TILE_SIZE) *
+			   assumed_cpp;
+	required_mem = ALIGN(required_mem, PAGE_SIZE);
+
+	ret = drm_mode_validate_size(mode, dev_priv->stdu_max_width,
+				     dev_priv->stdu_max_height);
+	if (ret != MODE_OK)
+		return ret;
 
+	ret = drm_mode_validate_size(mode, dev_priv->texture_max_width,
+				     dev_priv->texture_max_height);
+	if (ret != MODE_OK)
+		return ret;
+
+	if (required_mem > dev_priv->max_primary_mem)
+		return MODE_MEM;
+
+	if (required_mem > dev_priv->max_mob_pages * PAGE_SIZE)
+		return MODE_MEM;
+
+	if (required_mem > dev_priv->max_mob_size)
+		return MODE_MEM;
+
+	return MODE_OK;
+}
 
 static const struct drm_connector_funcs vmw_stdu_connector_funcs = {
 	.dpms = vmw_du_connector_dpms,
 	.detect = vmw_du_connector_detect,
-	.fill_modes = vmw_du_connector_fill_modes,
+	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = vmw_stdu_connector_destroy,
 	.reset = vmw_du_connector_reset,
 	.atomic_duplicate_state = vmw_du_connector_duplicate_state,
@@ -987,6 +1028,8 @@ static const struct drm_connector_funcs vmw_stdu_connector_funcs = {
 
 static const struct
 drm_connector_helper_funcs vmw_stdu_connector_helper_funcs = {
+	.get_modes = vmw_connector_get_modes,
+	.mode_valid = vmw_stdu_connector_mode_valid
 };
 
 
diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
index 9ec949a438ef..52ef6be9d449 100644
--- a/drivers/greybus/interface.c
+++ b/drivers/greybus/interface.c
@@ -694,6 +694,7 @@ static void gb_interface_release(struct device *dev)
 
 	trace_gb_interface_release(intf);
 
+	cancel_work_sync(&intf->mode_switch_work);
 	kfree(intf);
 }
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index cdad3a066287..e2e52aa0eeba 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1451,7 +1451,6 @@ static void implement(const struct hid_device *hid, u8 *report,
 			hid_warn(hid,
 				 "%s() called with too large value %d (n: %d)! (%s)\n",
 				 __func__, value, n, current->comm);
-			WARN_ON(1);
 			value &= m;
 		}
 	}
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 57697605b2e2..dc7b0fe83478 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1284,8 +1284,10 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 		 */
 		msleep(50);
 
-		if (retval)
+		if (retval) {
+			kfree(dj_report);
 			return retval;
+		}
 	}
 
 	/*
diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 2d991325e734..8d4deb2def97 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -18,9 +18,11 @@
 #include "i2c-hid.h"
 
 struct elan_i2c_hid_chip_data {
-	unsigned int post_gpio_reset_delay_ms;
+	unsigned int post_gpio_reset_on_delay_ms;
+	unsigned int post_gpio_reset_off_delay_ms;
 	unsigned int post_power_delay_ms;
 	u16 hid_descriptor_address;
+	const char *main_supply_name;
 };
 
 struct i2c_hid_of_elan {
@@ -29,6 +31,7 @@ struct i2c_hid_of_elan {
 	struct regulator *vcc33;
 	struct regulator *vccio;
 	struct gpio_desc *reset_gpio;
+	bool no_reset_on_power_off;
 	const struct elan_i2c_hid_chip_data *chip_data;
 };
 
@@ -38,24 +41,35 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *ops)
 		container_of(ops, struct i2c_hid_of_elan, ops);
 	int ret;
 
-	ret = regulator_enable(ihid_elan->vcc33);
-	if (ret)
-		return ret;
+	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
 
-	ret = regulator_enable(ihid_elan->vccio);
-	if (ret) {
-		regulator_disable(ihid_elan->vcc33);
-		return ret;
+	if (ihid_elan->vcc33) {
+		ret = regulator_enable(ihid_elan->vcc33);
+		if (ret)
+			goto err_deassert_reset;
 	}
 
+	ret = regulator_enable(ihid_elan->vccio);
+	if (ret)
+		goto err_disable_vcc33;
+
 	if (ihid_elan->chip_data->post_power_delay_ms)
 		msleep(ihid_elan->chip_data->post_power_delay_ms);
 
 	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);
-	if (ihid_elan->chip_data->post_gpio_reset_delay_ms)
-		msleep(ihid_elan->chip_data->post_gpio_reset_delay_ms);
+	if (ihid_elan->chip_data->post_gpio_reset_on_delay_ms)
+		msleep(ihid_elan->chip_data->post_gpio_reset_on_delay_ms);
 
 	return 0;
+
+err_disable_vcc33:
+	if (ihid_elan->vcc33)
+		regulator_disable(ihid_elan->vcc33);
+err_deassert_reset:
+	if (ihid_elan->no_reset_on_power_off)
+		gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);
+
+	return ret;
 }
 
 static void elan_i2c_hid_power_down(struct i2chid_ops *ops)
@@ -63,15 +77,27 @@ static void elan_i2c_hid_power_down(struct i2chid_ops *ops)
 	struct i2c_hid_of_elan *ihid_elan =
 		container_of(ops, struct i2c_hid_of_elan, ops);
 
-	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
+	/*
+	 * Do not assert reset when the hardware allows for it to remain
+	 * deasserted regardless of the state of the (shared) power supply to
+	 * avoid wasting power when the supply is left on.
+	 */
+	if (!ihid_elan->no_reset_on_power_off)
+		gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
+
+	if (ihid_elan->chip_data->post_gpio_reset_off_delay_ms)
+		msleep(ihid_elan->chip_data->post_gpio_reset_off_delay_ms);
+
 	regulator_disable(ihid_elan->vccio);
-	regulator_disable(ihid_elan->vcc33);
+	if (ihid_elan->vcc33)
+		regulator_disable(ihid_elan->vcc33);
 }
 
 static int i2c_hid_of_elan_probe(struct i2c_client *client,
 				 const struct i2c_device_id *id)
 {
 	struct i2c_hid_of_elan *ihid_elan;
+	int ret;
 
 	ihid_elan = devm_kzalloc(&client->dev, sizeof(*ihid_elan), GFP_KERNEL);
 	if (!ihid_elan)
@@ -86,28 +112,63 @@ static int i2c_hid_of_elan_probe(struct i2c_client *client,
 	if (IS_ERR(ihid_elan->reset_gpio))
 		return PTR_ERR(ihid_elan->reset_gpio);
 
-	ihid_elan->vccio = devm_regulator_get(&client->dev, "vccio");
-	if (IS_ERR(ihid_elan->vccio))
-		return PTR_ERR(ihid_elan->vccio);
+	ihid_elan->no_reset_on_power_off = of_property_read_bool(client->dev.of_node,
+						"no-reset-on-power-off");
 
-	ihid_elan->vcc33 = devm_regulator_get(&client->dev, "vcc33");
-	if (IS_ERR(ihid_elan->vcc33))
-		return PTR_ERR(ihid_elan->vcc33);
+	ihid_elan->vccio = devm_regulator_get(&client->dev, "vccio");
+	if (IS_ERR(ihid_elan->vccio)) {
+		ret = PTR_ERR(ihid_elan->vccio);
+		goto err_deassert_reset;
+	}
 
 	ihid_elan->chip_data = device_get_match_data(&client->dev);
 
-	return i2c_hid_core_probe(client, &ihid_elan->ops,
-				  ihid_elan->chip_data->hid_descriptor_address, 0);
+	if (ihid_elan->chip_data->main_supply_name) {
+		ihid_elan->vcc33 = devm_regulator_get(&client->dev,
+						      ihid_elan->chip_data->main_supply_name);
+		if (IS_ERR(ihid_elan->vcc33)) {
+			ret = PTR_ERR(ihid_elan->vcc33);
+			goto err_deassert_reset;
+		}
+	}
+
+	ret = i2c_hid_core_probe(client, &ihid_elan->ops,
+				 ihid_elan->chip_data->hid_descriptor_address, 0);
+	if (ret)
+		goto err_deassert_reset;
+
+	return 0;
+
+err_deassert_reset:
+	if (ihid_elan->no_reset_on_power_off)
+		gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);
+
+	return ret;
 }
 
 static const struct elan_i2c_hid_chip_data elan_ekth6915_chip_data = {
 	.post_power_delay_ms = 1,
-	.post_gpio_reset_delay_ms = 300,
+	.post_gpio_reset_on_delay_ms = 300,
+	.hid_descriptor_address = 0x0001,
+	.main_supply_name = "vcc33",
+};
+
+static const struct elan_i2c_hid_chip_data ilitek_ili9882t_chip_data = {
+	.post_power_delay_ms = 1,
+	.post_gpio_reset_on_delay_ms = 200,
+	.post_gpio_reset_off_delay_ms = 65,
 	.hid_descriptor_address = 0x0001,
+	/*
+	 * this touchscreen is tightly integrated with the panel and assumes
+	 * that the relevant power rails (other than the IO rail) have already
+	 * been turned on by the panel driver because we're a panel follower.
+	 */
+	.main_supply_name = NULL,
 };
 
 static const struct of_device_id elan_i2c_hid_of_match[] = {
 	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
+	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, elan_i2c_hid_of_match);
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 648893f9e4b6..8dad239aba2c 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -294,6 +294,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xae24),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Meteor Lake-S */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7f26),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Raptor Lake-S */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7a26),
@@ -304,6 +309,26 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa76f),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Granite Rapids */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0963),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
+		/* Granite Rapids SOC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3256),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
+		/* Sapphire Rapids SOC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3456),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
+		/* Lunar Lake */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa824),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
diff --git a/drivers/i2c/busses/i2c-at91-slave.c b/drivers/i2c/busses/i2c-at91-slave.c
index d6eeea5166c0..131a67d9d4a6 100644
--- a/drivers/i2c/busses/i2c-at91-slave.c
+++ b/drivers/i2c/busses/i2c-at91-slave.c
@@ -106,8 +106,7 @@ static int at91_unreg_slave(struct i2c_client *slave)
 
 static u32 at91_twi_func(struct i2c_adapter *adapter)
 {
-	return I2C_FUNC_SLAVE | I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
-		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
+	return I2C_FUNC_SLAVE;
 }
 
 static const struct i2c_algorithm at91_twi_algorithm_slave = {
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 0d15f4c1e9f7..5b54a9b9ed1a 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -232,7 +232,7 @@ static const struct i2c_algorithm i2c_dw_algo = {
 
 void i2c_dw_configure_slave(struct dw_i2c_dev *dev)
 {
-	dev->functionality = I2C_FUNC_SLAVE | DW_IC_DEFAULT_FUNCTIONALITY;
+	dev->functionality = I2C_FUNC_SLAVE;
 
 	dev->slave_cfg = DW_IC_CON_RX_FIFO_FULL_HLD_CTRL |
 			 DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED;
diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 4dd777cc0c89..14ae0cfc325e 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -442,18 +442,12 @@ EXPORT_SYMBOL_GPL(i2c_acpi_find_adapter_by_handle);
 
 static struct i2c_client *i2c_acpi_find_client_by_adev(struct acpi_device *adev)
 {
-	struct device *dev;
-	struct i2c_client *client;
-
-	dev = bus_find_device_by_acpi_dev(&i2c_bus_type, adev);
-	if (!dev)
-		return NULL;
-
-	client = i2c_verify_client(dev);
-	if (!client)
-		put_device(dev);
+	return i2c_find_device_by_fwnode(acpi_fwnode_handle(adev));
+}
 
-	return client;
+static struct i2c_adapter *i2c_acpi_find_adapter_by_adev(struct acpi_device *adev)
+{
+	return i2c_find_adapter_by_fwnode(acpi_fwnode_handle(adev));
 }
 
 static int i2c_acpi_notify(struct notifier_block *nb, unsigned long value,
@@ -482,11 +476,17 @@ static int i2c_acpi_notify(struct notifier_block *nb, unsigned long value,
 			break;
 
 		client = i2c_acpi_find_client_by_adev(adev);
-		if (!client)
-			break;
+		if (client) {
+			i2c_unregister_device(client);
+			put_device(&client->dev);
+		}
+
+		adapter = i2c_acpi_find_adapter_by_adev(adev);
+		if (adapter) {
+			acpi_unbind_one(&adapter->dev);
+			put_device(&adapter->dev);
+		}
 
-		i2c_unregister_device(client);
-		put_device(&client->dev);
 		break;
 	}
 
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 1ebc95379914..8af82f42af30 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1017,6 +1017,35 @@ void i2c_unregister_device(struct i2c_client *client)
 }
 EXPORT_SYMBOL_GPL(i2c_unregister_device);
 
+/**
+ * i2c_find_device_by_fwnode() - find an i2c_client for the fwnode
+ * @fwnode: &struct fwnode_handle corresponding to the &struct i2c_client
+ *
+ * Look up and return the &struct i2c_client corresponding to the @fwnode.
+ * If no client can be found, or @fwnode is NULL, this returns NULL.
+ *
+ * The user must call put_device(&client->dev) once done with the i2c client.
+ */
+struct i2c_client *i2c_find_device_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct i2c_client *client;
+	struct device *dev;
+
+	if (!fwnode)
+		return NULL;
+
+	dev = bus_find_device_by_fwnode(&i2c_bus_type, fwnode);
+	if (!dev)
+		return NULL;
+
+	client = i2c_verify_client(dev);
+	if (!client)
+		put_device(dev);
+
+	return client;
+}
+EXPORT_SYMBOL(i2c_find_device_by_fwnode);
+
 
 static const struct i2c_device_id dummy_id[] = {
 	{ "dummy", 0 },
@@ -1767,6 +1796,75 @@ int devm_i2c_add_adapter(struct device *dev, struct i2c_adapter *adapter)
 }
 EXPORT_SYMBOL_GPL(devm_i2c_add_adapter);
 
+static int i2c_dev_or_parent_fwnode_match(struct device *dev, const void *data)
+{
+	if (dev_fwnode(dev) == data)
+		return 1;
+
+	if (dev->parent && dev_fwnode(dev->parent) == data)
+		return 1;
+
+	return 0;
+}
+
+/**
+ * i2c_find_adapter_by_fwnode() - find an i2c_adapter for the fwnode
+ * @fwnode: &struct fwnode_handle corresponding to the &struct i2c_adapter
+ *
+ * Look up and return the &struct i2c_adapter corresponding to the @fwnode.
+ * If no adapter can be found, or @fwnode is NULL, this returns NULL.
+ *
+ * The user must call put_device(&adapter->dev) once done with the i2c adapter.
+ */
+struct i2c_adapter *i2c_find_adapter_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct i2c_adapter *adapter;
+	struct device *dev;
+
+	if (!fwnode)
+		return NULL;
+
+	dev = bus_find_device(&i2c_bus_type, NULL, fwnode,
+			      i2c_dev_or_parent_fwnode_match);
+	if (!dev)
+		return NULL;
+
+	adapter = i2c_verify_adapter(dev);
+	if (!adapter)
+		put_device(dev);
+
+	return adapter;
+}
+EXPORT_SYMBOL(i2c_find_adapter_by_fwnode);
+
+/**
+ * i2c_get_adapter_by_fwnode() - find an i2c_adapter for the fwnode
+ * @fwnode: &struct fwnode_handle corresponding to the &struct i2c_adapter
+ *
+ * Look up and return the &struct i2c_adapter corresponding to the @fwnode,
+ * and increment the adapter module's use count. If no adapter can be found,
+ * or @fwnode is NULL, this returns NULL.
+ *
+ * The user must call i2c_put_adapter(adapter) once done with the i2c adapter.
+ * Note that this is different from i2c_find_adapter_by_node().
+ */
+struct i2c_adapter *i2c_get_adapter_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct i2c_adapter *adapter;
+
+	adapter = i2c_find_adapter_by_fwnode(fwnode);
+	if (!adapter)
+		return NULL;
+
+	if (!try_module_get(adapter->owner)) {
+		put_device(&adapter->dev);
+		adapter = NULL;
+	}
+
+	return adapter;
+}
+EXPORT_SYMBOL(i2c_get_adapter_by_fwnode);
+
 static void i2c_parse_timing(struct device *dev, char *prop_name, u32 *cur_val_p,
 			    u32 def_val, bool use_def)
 {
diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 1073f82d5dd4..545436b7dd53 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -113,72 +113,6 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
 	of_node_put(bus);
 }
 
-static int of_dev_or_parent_node_match(struct device *dev, const void *data)
-{
-	if (dev->of_node == data)
-		return 1;
-
-	if (dev->parent)
-		return dev->parent->of_node == data;
-
-	return 0;
-}
-
-/* must call put_device() when done with returned i2c_client device */
-struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
-{
-	struct device *dev;
-	struct i2c_client *client;
-
-	dev = bus_find_device_by_of_node(&i2c_bus_type, node);
-	if (!dev)
-		return NULL;
-
-	client = i2c_verify_client(dev);
-	if (!client)
-		put_device(dev);
-
-	return client;
-}
-EXPORT_SYMBOL(of_find_i2c_device_by_node);
-
-/* must call put_device() when done with returned i2c_adapter device */
-struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
-{
-	struct device *dev;
-	struct i2c_adapter *adapter;
-
-	dev = bus_find_device(&i2c_bus_type, NULL, node,
-			      of_dev_or_parent_node_match);
-	if (!dev)
-		return NULL;
-
-	adapter = i2c_verify_adapter(dev);
-	if (!adapter)
-		put_device(dev);
-
-	return adapter;
-}
-EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
-
-/* must call i2c_put_adapter() when done with returned i2c_adapter device */
-struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node)
-{
-	struct i2c_adapter *adapter;
-
-	adapter = of_find_i2c_adapter_by_node(node);
-	if (!adapter)
-		return NULL;
-
-	if (!try_module_get(adapter->owner)) {
-		put_device(&adapter->dev);
-		adapter = NULL;
-	}
-
-	return adapter;
-}
-EXPORT_SYMBOL(of_get_i2c_adapter_by_node);
-
 static const struct of_device_id*
 i2c_of_match_device_sysfs(const struct of_device_id *matches,
 				  struct i2c_client *client)
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index ffae30e5eb5b..0ae544aaff0c 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2014, Intel Corporation.
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
@@ -36,6 +37,7 @@
 
 #define MXC4005_REG_INT_CLR1		0x01
 #define MXC4005_REG_INT_CLR1_BIT_DRDYC	0x01
+#define MXC4005_REG_INT_CLR1_SW_RST	0x10
 
 #define MXC4005_REG_CONTROL		0x0D
 #define MXC4005_REG_CONTROL_MASK_FSR	GENMASK(6, 5)
@@ -43,6 +45,9 @@
 
 #define MXC4005_REG_DEVICE_ID		0x0E
 
+/* Datasheet does not specify a reset time, this is a conservative guess */
+#define MXC4005_RESET_TIME_US		2000
+
 enum mxc4005_axis {
 	AXIS_X,
 	AXIS_Y,
@@ -66,6 +71,8 @@ struct mxc4005_data {
 		s64 timestamp __aligned(8);
 	} scan;
 	bool trigger_enabled;
+	unsigned int control;
+	unsigned int int_mask1;
 };
 
 /*
@@ -349,6 +356,7 @@ static int mxc4005_set_trigger_state(struct iio_trigger *trig,
 		return ret;
 	}
 
+	data->int_mask1 = val;
 	data->trigger_enabled = state;
 	mutex_unlock(&data->mutex);
 
@@ -384,6 +392,13 @@ static int mxc4005_chip_init(struct mxc4005_data *data)
 
 	dev_dbg(data->dev, "MXC4005 chip id %02x\n", reg);
 
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_CLR1,
+			   MXC4005_REG_INT_CLR1_SW_RST);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret, "resetting chip\n");
+
+	fsleep(MXC4005_RESET_TIME_US);
+
 	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK0, 0);
 	if (ret < 0)
 		return dev_err_probe(data->dev, ret, "writing INT_MASK0\n");
@@ -480,6 +495,58 @@ static int mxc4005_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static int mxc4005_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mxc4005_data *data = iio_priv(indio_dev);
+	int ret;
+
+	/* Save control to restore it on resume */
+	ret = regmap_read(data->regmap, MXC4005_REG_CONTROL, &data->control);
+	if (ret < 0)
+		dev_err(data->dev, "failed to read reg_control\n");
+
+	return ret;
+}
+
+static int mxc4005_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mxc4005_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_CLR1,
+			   MXC4005_REG_INT_CLR1_SW_RST);
+	if (ret) {
+		dev_err(data->dev, "failed to reset chip: %d\n", ret);
+		return ret;
+	}
+
+	fsleep(MXC4005_RESET_TIME_US);
+
+	ret = regmap_write(data->regmap, MXC4005_REG_CONTROL, data->control);
+	if (ret) {
+		dev_err(data->dev, "failed to restore control register\n");
+		return ret;
+	}
+
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK0, 0);
+	if (ret) {
+		dev_err(data->dev, "failed to restore interrupt 0 mask\n");
+		return ret;
+	}
+
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1, data->int_mask1);
+	if (ret) {
+		dev_err(data->dev, "failed to restore interrupt 1 mask\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mxc4005_pm_ops, mxc4005_suspend, mxc4005_resume);
+
 static const struct acpi_device_id mxc4005_acpi_match[] = {
 	{"MXC4005",	0},
 	{"MXC6655",	0},
@@ -487,6 +554,13 @@ static const struct acpi_device_id mxc4005_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
 
+static const struct of_device_id mxc4005_of_match[] = {
+	{ .compatible = "memsic,mxc4005", },
+	{ .compatible = "memsic,mxc6655", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mxc4005_of_match);
+
 static const struct i2c_device_id mxc4005_id[] = {
 	{"mxc4005",	0},
 	{"mxc6655",	0},
@@ -498,6 +572,8 @@ static struct i2c_driver mxc4005_driver = {
 	.driver = {
 		.name = MXC4005_DRV_NAME,
 		.acpi_match_table = ACPI_PTR(mxc4005_acpi_match),
+		.of_match_table = mxc4005_of_match,
+		.pm = pm_sleep_ptr(&mxc4005_pm_ops),
 	},
 	.probe		= mxc4005_probe,
 	.id_table	= mxc4005_id,
diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 811525857d29..5edc2a3e687d 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -223,11 +223,11 @@ static void __ad9467_get_scale(struct adi_axi_adc_conv *conv, int index,
 }
 
 static const struct iio_chan_spec ad9434_channels[] = {
-	AD9467_CHAN(0, 0, 12, 'S'),
+	AD9467_CHAN(0, 0, 12, 's'),
 };
 
 static const struct iio_chan_spec ad9467_channels[] = {
-	AD9467_CHAN(0, 0, 16, 'S'),
+	AD9467_CHAN(0, 0, 16, 's'),
 };
 
 static const struct ad9467_chip_info ad9467_chip_tbl[] = {
diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 7a9b5fc1e579..aa5b4c4aff38 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -410,7 +410,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 			s64 tmp = *val * (3767897513LL / 25LL);
 			*val = div_s64_rem(tmp, 1000000000LL, val2);
 
-			return IIO_VAL_INT_PLUS_MICRO;
+			return IIO_VAL_INT_PLUS_NANO;
 		}
 
 		mutex_lock(&st->lock);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index c3f433ad3af6..7a0f5cfd9417 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -128,10 +128,6 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	/* update data FIFO write */
 	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
-	if (ret)
-		goto out_unlock;
-
-	ret = inv_icm42600_buffer_update_watermark(st);
 
 out_unlock:
 	mutex_unlock(&st->lock);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 9d94a8518e3c..4fb796e11486 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -128,10 +128,6 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 	/* update data FIFO write */
 	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
-	if (ret)
-		goto out_unlock;
-
-	ret = inv_icm42600_buffer_update_watermark(st);
 
 out_unlock:
 	mutex_unlock(&st->lock);
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 8b6a922f8470..78be582b5766 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1374,19 +1374,19 @@ static int input_print_modalias_bits(char *buf, int size,
 				     char name, unsigned long *bm,
 				     unsigned int min_bit, unsigned int max_bit)
 {
-	int len = 0, i;
+	int bit = min_bit;
+	int len = 0;
 
 	len += snprintf(buf, max(size, 0), "%c", name);
-	for (i = min_bit; i < max_bit; i++)
-		if (bm[BIT_WORD(i)] & BIT_MASK(i))
-			len += snprintf(buf + len, max(size - len, 0), "%X,", i);
+	for_each_set_bit_from(bit, bm, max_bit)
+		len += snprintf(buf + len, max(size - len, 0), "%X,", bit);
 	return len;
 }
 
-static int input_print_modalias(char *buf, int size, struct input_dev *id,
-				int add_cr)
+static int input_print_modalias_parts(char *buf, int size, int full_len,
+				      struct input_dev *id)
 {
-	int len;
+	int len, klen, remainder, space;
 
 	len = snprintf(buf, max(size, 0),
 		       "input:b%04Xv%04Xp%04Xe%04X-",
@@ -1395,8 +1395,48 @@ static int input_print_modalias(char *buf, int size, struct input_dev *id,
 
 	len += input_print_modalias_bits(buf + len, size - len,
 				'e', id->evbit, 0, EV_MAX);
-	len += input_print_modalias_bits(buf + len, size - len,
+
+	/*
+	 * Calculate the remaining space in the buffer making sure we
+	 * have place for the terminating 0.
+	 */
+	space = max(size - (len + 1), 0);
+
+	klen = input_print_modalias_bits(buf + len, size - len,
 				'k', id->keybit, KEY_MIN_INTERESTING, KEY_MAX);
+	len += klen;
+
+	/*
+	 * If we have more data than we can fit in the buffer, check
+	 * if we can trim key data to fit in the rest. We will indicate
+	 * that key data is incomplete by adding "+" sign at the end, like
+	 * this: * "k1,2,3,45,+,".
+	 *
+	 * Note that we shortest key info (if present) is "k+," so we
+	 * can only try to trim if key data is longer than that.
+	 */
+	if (full_len && size < full_len + 1 && klen > 3) {
+		remainder = full_len - len;
+		/*
+		 * We can only trim if we have space for the remainder
+		 * and also for at least "k+," which is 3 more characters.
+		 */
+		if (remainder <= space - 3) {
+			/*
+			 * We are guaranteed to have 'k' in the buffer, so
+			 * we need at least 3 additional bytes for storing
+			 * "+," in addition to the remainder.
+			 */
+			for (int i = size - 1 - remainder - 3; i >= 0; i--) {
+				if (buf[i] == 'k' || buf[i] == ',') {
+					strcpy(buf + i + 1, "+,");
+					len = i + 3; /* Not counting '\0' */
+					break;
+				}
+			}
+		}
+	}
+
 	len += input_print_modalias_bits(buf + len, size - len,
 				'r', id->relbit, 0, REL_MAX);
 	len += input_print_modalias_bits(buf + len, size - len,
@@ -1412,12 +1452,25 @@ static int input_print_modalias(char *buf, int size, struct input_dev *id,
 	len += input_print_modalias_bits(buf + len, size - len,
 				'w', id->swbit, 0, SW_MAX);
 
-	if (add_cr)
-		len += snprintf(buf + len, max(size - len, 0), "\n");
-
 	return len;
 }
 
+static int input_print_modalias(char *buf, int size, struct input_dev *id)
+{
+	int full_len;
+
+	/*
+	 * Printing is done in 2 passes: first one figures out total length
+	 * needed for the modalias string, second one will try to trim key
+	 * data in case when buffer is too small for the entire modalias.
+	 * If the buffer is too small regardless, it will fill as much as it
+	 * can (without trimming key data) into the buffer and leave it to
+	 * the caller to figure out what to do with the result.
+	 */
+	full_len = input_print_modalias_parts(NULL, 0, 0, id);
+	return input_print_modalias_parts(buf, size, full_len, id);
+}
+
 static ssize_t input_dev_show_modalias(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
@@ -1425,7 +1478,9 @@ static ssize_t input_dev_show_modalias(struct device *dev,
 	struct input_dev *id = to_input_dev(dev);
 	ssize_t len;
 
-	len = input_print_modalias(buf, PAGE_SIZE, id, 1);
+	len = input_print_modalias(buf, PAGE_SIZE, id);
+	if (len < PAGE_SIZE - 2)
+		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 
 	return min_t(int, len, PAGE_SIZE);
 }
@@ -1637,6 +1692,23 @@ static int input_add_uevent_bm_var(struct kobj_uevent_env *env,
 	return 0;
 }
 
+/*
+ * This is a pretty gross hack. When building uevent data the driver core
+ * may try adding more environment variables to kobj_uevent_env without
+ * telling us, so we have no idea how much of the buffer we can use to
+ * avoid overflows/-ENOMEM elsewhere. To work around this let's artificially
+ * reduce amount of memory we will use for the modalias environment variable.
+ *
+ * The potential additions are:
+ *
+ * SEQNUM=18446744073709551615 - (%llu - 28 bytes)
+ * HOME=/ (6 bytes)
+ * PATH=/sbin:/bin:/usr/sbin:/usr/bin (34 bytes)
+ *
+ * 68 bytes total. Allow extra buffer - 96 bytes
+ */
+#define UEVENT_ENV_EXTRA_LEN	96
+
 static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
 					 struct input_dev *dev)
 {
@@ -1646,9 +1718,11 @@ static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
 		return -ENOMEM;
 
 	len = input_print_modalias(&env->buf[env->buflen - 1],
-				   sizeof(env->buf) - env->buflen,
-				   dev, 0);
-	if (len >= (sizeof(env->buf) - env->buflen))
+				   (int)sizeof(env->buf) - env->buflen -
+					UEVENT_ENV_EXTRA_LEN,
+				   dev);
+	if (len >= ((int)sizeof(env->buf) - env->buflen -
+					UEVENT_ENV_EXTRA_LEN))
 		return -ENOMEM;
 
 	env->buflen += len;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index cc94ac666233..c9598c506ff9 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1655,8 +1655,17 @@ static void __init free_pci_segments(void)
 	}
 }
 
+static void __init free_sysfs(struct amd_iommu *iommu)
+{
+	if (iommu->iommu.dev) {
+		iommu_device_unregister(&iommu->iommu);
+		iommu_device_sysfs_remove(&iommu->iommu);
+	}
+}
+
 static void __init free_iommu_one(struct amd_iommu *iommu)
 {
+	free_sysfs(iommu);
 	free_cwwb_sem(iommu);
 	free_command_buffer(iommu);
 	free_event_buffer(iommu);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index f9ab5cfc9b94..3620bdb5200f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1837,28 +1837,22 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
-	int ret = 0;
 
 	if (!info->map)
 		return -EINVAL;
 
-	raw_spin_lock(&its_dev->event_map.vlpi_lock);
-
 	if (!its_dev->event_map.vm) {
 		struct its_vlpi_map *maps;
 
 		maps = kcalloc(its_dev->event_map.nr_lpis, sizeof(*maps),
 			       GFP_ATOMIC);
-		if (!maps) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		if (!maps)
+			return -ENOMEM;
 
 		its_dev->event_map.vm = info->map->vm;
 		its_dev->event_map.vlpi_maps = maps;
 	} else if (its_dev->event_map.vm != info->map->vm) {
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	/* Get our private copy of the mapping information */
@@ -1890,46 +1884,32 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
 		its_dev->event_map.nr_vlpis++;
 	}
 
-out:
-	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
-	return ret;
+	return 0;
 }
 
 static int its_vlpi_get(struct irq_data *d, struct its_cmd_info *info)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_vlpi_map *map;
-	int ret = 0;
-
-	raw_spin_lock(&its_dev->event_map.vlpi_lock);
 
 	map = get_vlpi_map(d);
 
-	if (!its_dev->event_map.vm || !map) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!its_dev->event_map.vm || !map)
+		return -EINVAL;
 
 	/* Copy our mapping information to the incoming request */
 	*info->map = *map;
 
-out:
-	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
-	return ret;
+	return 0;
 }
 
 static int its_vlpi_unmap(struct irq_data *d)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
-	int ret = 0;
-
-	raw_spin_lock(&its_dev->event_map.vlpi_lock);
 
-	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d))
+		return -EINVAL;
 
 	/* Drop the virtual mapping */
 	its_send_discard(its_dev, event);
@@ -1953,9 +1933,7 @@ static int its_vlpi_unmap(struct irq_data *d)
 		kfree(its_dev->event_map.vlpi_maps);
 	}
 
-out:
-	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
-	return ret;
+	return 0;
 }
 
 static int its_vlpi_prop_update(struct irq_data *d, struct its_cmd_info *info)
@@ -1983,6 +1961,8 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 	if (!is_v4(its_dev->its))
 		return -EINVAL;
 
+	guard(raw_spinlock_irq)(&its_dev->event_map.vlpi_lock);
+
 	/* Unmap request? */
 	if (!info)
 		return its_vlpi_unmap(d);
diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
index 32af2b14ff34..34c9be437432 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
@@ -69,8 +69,10 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 	aux_bus->aux_device_wrapper[1] = kzalloc(sizeof(*aux_bus->aux_device_wrapper[1]),
 						 GFP_KERNEL);
-	if (!aux_bus->aux_device_wrapper[1])
-		return -ENOMEM;
+	if (!aux_bus->aux_device_wrapper[1]) {
+		retval =  -ENOMEM;
+		goto err_aux_dev_add_0;
+	}
 
 	retval = ida_alloc(&gp_client_ida, GFP_KERNEL);
 	if (retval < 0)
@@ -111,6 +113,7 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 err_aux_dev_add_1:
 	auxiliary_device_uninit(&aux_bus->aux_device_wrapper[1]->aux_dev);
+	goto err_aux_dev_add_0;
 
 err_aux_dev_init_1:
 	ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[1]->aux_dev.id);
@@ -120,6 +123,7 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 err_aux_dev_add_0:
 	auxiliary_device_uninit(&aux_bus->aux_device_wrapper[0]->aux_dev);
+	goto err_ret;
 
 err_aux_dev_init_0:
 	ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[0]->aux_dev.id);
@@ -127,6 +131,7 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 err_ida_alloc_0:
 	kfree(aux_bus->aux_device_wrapper[0]);
 
+err_ret:
 	return retval;
 }
 
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index a4bdc4128458..dd4d92fa44c6 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -394,8 +394,10 @@ static int mei_me_pci_resume(struct device *device)
 	}
 
 	err = mei_restart(dev);
-	if (err)
+	if (err) {
+		free_irq(pdev->irq, dev);
 		return err;
+	}
 
 	/* Start timer if stopped in suspend */
 	schedule_delayed_work(&dev->timer_work, HZ);
diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index eb97167c03fb..9715798acce3 100644
--- a/drivers/misc/pvpanic/pvpanic-mmio.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -24,52 +24,9 @@ MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic-mmio device driver");
 MODULE_LICENSE("GPL");
 
-static ssize_t capability_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pvpanic_instance *pi = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%x\n", pi->capability);
-}
-static DEVICE_ATTR_RO(capability);
-
-static ssize_t events_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pvpanic_instance *pi = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%x\n", pi->events);
-}
-
-static ssize_t events_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
-{
-	struct pvpanic_instance *pi = dev_get_drvdata(dev);
-	unsigned int tmp;
-	int err;
-
-	err = kstrtouint(buf, 16, &tmp);
-	if (err)
-		return err;
-
-	if ((tmp & pi->capability) != tmp)
-		return -EINVAL;
-
-	pi->events = tmp;
-
-	return count;
-}
-static DEVICE_ATTR_RW(events);
-
-static struct attribute *pvpanic_mmio_dev_attrs[] = {
-	&dev_attr_capability.attr,
-	&dev_attr_events.attr,
-	NULL
-};
-ATTRIBUTE_GROUPS(pvpanic_mmio_dev);
-
 static int pvpanic_mmio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct pvpanic_instance *pi;
 	struct resource *res;
 	void __iomem *base;
 
@@ -92,18 +49,7 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pi = devm_kmalloc(dev, sizeof(*pi), GFP_KERNEL);
-	if (!pi)
-		return -ENOMEM;
-
-	pi->base = base;
-	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
-
-	/* initialize capability by RDPT */
-	pi->capability &= ioread8(base);
-	pi->events = pi->capability;
-
-	return devm_pvpanic_probe(dev, pi);
+	return devm_pvpanic_probe(dev, base);
 }
 
 static const struct of_device_id pvpanic_mmio_match[] = {
@@ -123,7 +69,7 @@ static struct platform_driver pvpanic_mmio_driver = {
 		.name = "pvpanic-mmio",
 		.of_match_table = pvpanic_mmio_match,
 		.acpi_match_table = pvpanic_device_ids,
-		.dev_groups = pvpanic_mmio_dev_groups,
+		.dev_groups = pvpanic_dev_groups,
 	},
 	.probe = pvpanic_mmio_probe,
 };
diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index 07eddb5ea30f..2494725dfacf 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -22,51 +22,8 @@ MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
 MODULE_LICENSE("GPL");
 
-static ssize_t capability_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pvpanic_instance *pi = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%x\n", pi->capability);
-}
-static DEVICE_ATTR_RO(capability);
-
-static ssize_t events_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pvpanic_instance *pi = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%x\n", pi->events);
-}
-
-static ssize_t events_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
-{
-	struct pvpanic_instance *pi = dev_get_drvdata(dev);
-	unsigned int tmp;
-	int err;
-
-	err = kstrtouint(buf, 16, &tmp);
-	if (err)
-		return err;
-
-	if ((tmp & pi->capability) != tmp)
-		return -EINVAL;
-
-	pi->events = tmp;
-
-	return count;
-}
-static DEVICE_ATTR_RW(events);
-
-static struct attribute *pvpanic_pci_dev_attrs[] = {
-	&dev_attr_capability.attr,
-	&dev_attr_events.attr,
-	NULL
-};
-ATTRIBUTE_GROUPS(pvpanic_pci_dev);
-
 static int pvpanic_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	struct pvpanic_instance *pi;
 	void __iomem *base;
 	int ret;
 
@@ -78,18 +35,7 @@ static int pvpanic_pci_probe(struct pci_dev *pdev, const struct pci_device_id *e
 	if (!base)
 		return -ENOMEM;
 
-	pi = devm_kmalloc(&pdev->dev, sizeof(*pi), GFP_KERNEL);
-	if (!pi)
-		return -ENOMEM;
-
-	pi->base = base;
-	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
-
-	/* initlize capability by RDPT */
-	pi->capability &= ioread8(base);
-	pi->events = pi->capability;
-
-	return devm_pvpanic_probe(&pdev->dev, pi);
+	return devm_pvpanic_probe(&pdev->dev, base);
 }
 
 static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
@@ -102,8 +48,6 @@ static struct pci_driver pvpanic_pci_driver = {
 	.name =         "pvpanic-pci",
 	.id_table =     pvpanic_pci_id_tbl,
 	.probe =        pvpanic_pci_probe,
-	.driver = {
-		.dev_groups = pvpanic_pci_dev_groups,
-	},
+	.dev_groups =   pvpanic_dev_groups,
 };
 module_pci_driver(pvpanic_pci_driver);
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 049a12006348..305b367e0ce3 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -7,6 +7,7 @@
  *  Copyright (C) 2021 Oracle.
  */
 
+#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
@@ -26,6 +27,13 @@ MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
 MODULE_LICENSE("GPL");
 
+struct pvpanic_instance {
+	void __iomem *base;
+	unsigned int capability;
+	unsigned int events;
+	struct list_head list;
+};
+
 static struct list_head pvpanic_list;
 static spinlock_t pvpanic_lock;
 
@@ -81,11 +89,75 @@ static void pvpanic_remove(void *param)
 	spin_unlock(&pvpanic_lock);
 }
 
-int devm_pvpanic_probe(struct device *dev, struct pvpanic_instance *pi)
+static ssize_t capability_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pvpanic_instance *pi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%x\n", pi->capability);
+}
+static DEVICE_ATTR_RO(capability);
+
+static ssize_t events_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pvpanic_instance *pi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%x\n", pi->events);
+}
+
+static ssize_t events_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct pvpanic_instance *pi = dev_get_drvdata(dev);
+	unsigned int tmp;
+	int err;
+
+	err = kstrtouint(buf, 16, &tmp);
+	if (err)
+		return err;
+
+	if ((tmp & pi->capability) != tmp)
+		return -EINVAL;
+
+	pi->events = tmp;
+
+	return count;
+}
+static DEVICE_ATTR_RW(events);
+
+static struct attribute *pvpanic_dev_attrs[] = {
+	&dev_attr_capability.attr,
+	&dev_attr_events.attr,
+	NULL
+};
+
+static const struct attribute_group pvpanic_dev_group = {
+	.attrs = pvpanic_dev_attrs,
+};
+
+const struct attribute_group *pvpanic_dev_groups[] = {
+	&pvpanic_dev_group,
+	NULL
+};
+EXPORT_SYMBOL_GPL(pvpanic_dev_groups);
+
+int devm_pvpanic_probe(struct device *dev, void __iomem *base)
 {
-	if (!pi || !pi->base)
+	struct pvpanic_instance *pi;
+
+	if (!base)
 		return -EINVAL;
 
+	pi = devm_kmalloc(dev, sizeof(*pi), GFP_KERNEL);
+	if (!pi)
+		return -ENOMEM;
+
+	pi->base = base;
+	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
+
+	/* initlize capability by RDPT */
+	pi->capability &= ioread8(base);
+	pi->events = pi->capability;
+
 	spin_lock(&pvpanic_lock);
 	list_add(&pi->list, &pvpanic_list);
 	spin_unlock(&pvpanic_lock);
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
index 493545951754..46ffb10438ad 100644
--- a/drivers/misc/pvpanic/pvpanic.h
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -8,13 +8,7 @@
 #ifndef PVPANIC_H_
 #define PVPANIC_H_
 
-struct pvpanic_instance {
-	void __iomem *base;
-	unsigned int capability;
-	unsigned int events;
-	struct list_head list;
-};
-
-int devm_pvpanic_probe(struct device *dev, struct pvpanic_instance *pi);
+int devm_pvpanic_probe(struct device *dev, void __iomem *base);
+extern const struct attribute_group *pvpanic_dev_groups[];
 
 #endif /* PVPANIC_H_ */
diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
index 2100297c94ad..a1205bce0b7e 100644
--- a/drivers/misc/vmw_vmci/vmci_event.c
+++ b/drivers/misc/vmw_vmci/vmci_event.c
@@ -9,6 +9,7 @@
 #include <linux/vmw_vmci_api.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/rculist.h>
@@ -86,9 +87,12 @@ static void event_deliver(struct vmci_event_msg *event_msg)
 {
 	struct vmci_subscription *cur;
 	struct list_head *subscriber_list;
+	u32 sanitized_event, max_vmci_event;
 
 	rcu_read_lock();
-	subscriber_list = &subscriber_array[event_msg->event_data.event];
+	max_vmci_event = ARRAY_SIZE(subscriber_array);
+	sanitized_event = array_index_nospec(event_msg->event_data.event, max_vmci_event);
+	subscriber_list = &subscriber_array[sanitized_event];
 	list_for_each_entry_rcu(cur, subscriber_list, node) {
 		cur->callback(cur->id, &event_msg->event_data,
 			      cur->callback_data);
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 7138dfa065bf..e89a97b41515 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1345,7 +1345,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
+static int davinci_mmcsd_remove(struct platform_device *pdev)
 {
 	struct mmc_davinci_host *host = platform_get_drvdata(pdev);
 
@@ -1402,7 +1402,7 @@ static struct platform_driver davinci_mmcsd_driver = {
 		.of_match_table = davinci_mmc_dt_ids,
 	},
 	.probe		= davinci_mmcsd_probe,
-	.remove		= __exit_p(davinci_mmcsd_remove),
+	.remove		= davinci_mmcsd_remove,
 	.id_table	= davinci_mmc_devtype,
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
index 132442f16fe6..7a4e08b5a8c1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
@@ -678,7 +678,7 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt_hwrm_ctx *ctx)
 			    req_type);
 	else if (rc && rc != HWRM_ERR_CODE_PF_UNAVAILABLE)
 		hwrm_err(bp, ctx, "hwrm req_type 0x%x seq id 0x%x error 0x%x\n",
-			 req_type, token->seq_id, rc);
+			 req_type, le16_to_cpu(ctx->req->seq_id), rc);
 	rc = __hwrm_to_stderr(rc);
 exit:
 	if (token)
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index 600de587d7a9..e70b9ccca380 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -272,13 +272,12 @@ lio_vf_rep_copy_packet(struct octeon_device *oct,
 				pg_info->page_offset;
 			memcpy(skb->data, va, MIN_SKB_SIZE);
 			skb_put(skb, MIN_SKB_SIZE);
+			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+					pg_info->page,
+					pg_info->page_offset + MIN_SKB_SIZE,
+					len - MIN_SKB_SIZE,
+					LIO_RXBUFFER_SZ);
 		}
-
-		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-				pg_info->page,
-				pg_info->page_offset + MIN_SKB_SIZE,
-				len - MIN_SKB_SIZE,
-				LIO_RXBUFFER_SZ);
 	} else {
 		struct octeon_skb_page_info *pg_info =
 			((struct octeon_skb_page_info *)(skb->cb));
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index a9409e3721ad..0a36b284de10 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -465,11 +465,13 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
 	skb_set_hash(skb, le32_to_cpu(compl_desc->hash), hash_type);
 }
 
-static void gve_rx_free_skb(struct gve_rx_ring *rx)
+static void gve_rx_free_skb(struct napi_struct *napi, struct gve_rx_ring *rx)
 {
 	if (!rx->ctx.skb_head)
 		return;
 
+	if (rx->ctx.skb_head == napi->skb)
+		napi->skb = NULL;
 	dev_kfree_skb_any(rx->ctx.skb_head);
 	rx->ctx.skb_head = NULL;
 	rx->ctx.skb_tail = NULL;
@@ -693,7 +695,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 
 		err = gve_rx_dqo(napi, rx, compl_desc, rx->q_num);
 		if (err < 0) {
-			gve_rx_free_skb(rx);
+			gve_rx_free_skb(napi, rx);
 			u64_stats_update_begin(&rx->statss);
 			if (err == -ENOMEM)
 				rx->rx_skb_alloc_fail++;
@@ -736,7 +738,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 
 		/* gve_rx_complete_skb() will consume skb if successful */
 		if (gve_rx_complete_skb(rx, napi, compl_desc, feat) != 0) {
-			gve_rx_free_skb(rx);
+			gve_rx_free_skb(napi, rx);
 			u64_stats_update_begin(&rx->statss);
 			rx->rx_desc_err_dropped_pkt++;
 			u64_stats_update_end(&rx->statss);
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index e84e944d751d..5147fb37929e 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -370,28 +370,18 @@ static int gve_prep_tso(struct sk_buff *skb)
 	if (unlikely(skb_shinfo(skb)->gso_size < GVE_TX_MIN_TSO_MSS_DQO))
 		return -1;
 
+	if (!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)))
+		return -EINVAL;
+
 	/* Needed because we will modify header. */
 	err = skb_cow_head(skb, 0);
 	if (err < 0)
 		return err;
 
 	tcp = tcp_hdr(skb);
-
-	/* Remove payload length from checksum. */
 	paylen = skb->len - skb_transport_offset(skb);
-
-	switch (skb_shinfo(skb)->gso_type) {
-	case SKB_GSO_TCPV4:
-	case SKB_GSO_TCPV6:
-		csum_replace_by_diff(&tcp->check,
-				     (__force __wsum)htonl(paylen));
-
-		/* Compute length of segmentation header. */
-		header_len = skb_tcp_all_headers(skb);
-		break;
-	default:
-		return -EINVAL;
-	}
+	csum_replace_by_diff(&tcp->check, (__force __wsum)htonl(paylen));
+	header_len = skb_tcp_all_headers(skb);
 
 	if (unlikely(header_len > GVE_TX_MAX_HDR_SIZE_DQO))
 		return -EINVAL;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 78d6752fe051..4ce43c3a00a3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3538,6 +3538,9 @@ static int hns3_alloc_ring_buffers(struct hns3_enet_ring *ring)
 		ret = hns3_alloc_and_attach_buffer(ring, i);
 		if (ret)
 			goto out_buffer_fail;
+
+		if (!(i % HNS3_RESCHED_BD_NUM))
+			cond_resched();
 	}
 
 	return 0;
@@ -5111,6 +5114,7 @@ int hns3_init_all_ring(struct hns3_nic_priv *priv)
 		}
 
 		u64_stats_init(&priv->ring[i].syncp);
+		cond_resched();
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 294a14b4fdef..1aac93f9aaa1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -214,6 +214,8 @@ enum hns3_nic_state {
 #define HNS3_CQ_MODE_EQE			1U
 #define HNS3_CQ_MODE_CQE			0U
 
+#define HNS3_RESCHED_BD_NUM			1024
+
 enum hns3_pkt_l2t_type {
 	HNS3_L2_TYPE_UNICAST,
 	HNS3_L2_TYPE_MULTICAST,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a2655adc764c..01e24b69e920 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3129,9 +3129,7 @@ static void hclge_push_link_status(struct hclge_dev *hdev)
 
 static void hclge_update_link_status(struct hclge_dev *hdev)
 {
-	struct hnae3_handle *rhandle = &hdev->vport[0].roce;
 	struct hnae3_handle *handle = &hdev->vport[0].nic;
-	struct hnae3_client *rclient = hdev->roce_client;
 	struct hnae3_client *client = hdev->nic_client;
 	int state;
 	int ret;
@@ -3155,8 +3153,15 @@ static void hclge_update_link_status(struct hclge_dev *hdev)
 
 		client->ops->link_status_change(handle, state);
 		hclge_config_mac_tnl_int(hdev, state);
-		if (rclient && rclient->ops->link_status_change)
-			rclient->ops->link_status_change(rhandle, state);
+
+		if (test_bit(HCLGE_STATE_ROCE_REGISTERED, &hdev->state)) {
+			struct hnae3_handle *rhandle = &hdev->vport[0].roce;
+			struct hnae3_client *rclient = hdev->roce_client;
+
+			if (rclient && rclient->ops->link_status_change)
+				rclient->ops->link_status_change(rhandle,
+								 state);
+		}
 
 		hclge_push_link_status(hdev);
 	}
@@ -11339,6 +11344,12 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 	return ret;
 }
 
+static bool hclge_uninit_need_wait(struct hclge_dev *hdev)
+{
+	return test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
+	       test_bit(HCLGE_STATE_LINK_UPDATING, &hdev->state);
+}
+
 static void hclge_uninit_client_instance(struct hnae3_client *client,
 					 struct hnae3_ae_dev *ae_dev)
 {
@@ -11347,7 +11358,7 @@ static void hclge_uninit_client_instance(struct hnae3_client *client,
 
 	if (hdev->roce_client) {
 		clear_bit(HCLGE_STATE_ROCE_REGISTERED, &hdev->state);
-		while (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		while (hclge_uninit_need_wait(hdev))
 			msleep(HCLGE_WAIT_RESET_DONE);
 
 		hdev->roce_client->ops->uninit_instance(&vport->roce, 0);
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index f2be383d97df..6d75e5638f66 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -388,7 +388,6 @@ struct ice_vsi {
 	struct ice_tc_cfg tc_cfg;
 	struct bpf_prog *xdp_prog;
 	struct ice_tx_ring **xdp_rings;	 /* XDP ring array */
-	unsigned long *af_xdp_zc_qps;	 /* tracks AF_XDP ZC enabled qps */
 	u16 num_xdp_txq;		 /* Used XDP queues */
 	u8 xdp_mapping_mode;		 /* ICE_MAP_MODE_[CONTIG|SCATTER] */
 
@@ -688,6 +687,25 @@ static inline void ice_set_ring_xdp(struct ice_tx_ring *ring)
 	ring->flags |= ICE_TX_FLAGS_RING_XDP;
 }
 
+/**
+ * ice_get_xp_from_qid - get ZC XSK buffer pool bound to a queue ID
+ * @vsi: pointer to VSI
+ * @qid: index of a queue to look at XSK buff pool presence
+ *
+ * Return: A pointer to xsk_buff_pool structure if there is a buffer pool
+ * attached and configured as zero-copy, NULL otherwise.
+ */
+static inline struct xsk_buff_pool *ice_get_xp_from_qid(struct ice_vsi *vsi,
+							u16 qid)
+{
+	struct xsk_buff_pool *pool = xsk_get_pool_from_qid(vsi->netdev, qid);
+
+	if (!ice_is_xdp_ena_vsi(vsi))
+		return NULL;
+
+	return (pool && pool->dev) ? pool : NULL;
+}
+
 /**
  * ice_xsk_pool - get XSK buffer pool bound to a ring
  * @ring: Rx ring to use
@@ -700,10 +718,7 @@ static inline struct xsk_buff_pool *ice_xsk_pool(struct ice_rx_ring *ring)
 	struct ice_vsi *vsi = ring->vsi;
 	u16 qid = ring->q_index;
 
-	if (!ice_is_xdp_ena_vsi(vsi) || !test_bit(qid, vsi->af_xdp_zc_qps))
-		return NULL;
-
-	return xsk_get_pool_from_qid(vsi->netdev, qid);
+	return ice_get_xp_from_qid(vsi, qid);
 }
 
 /**
@@ -728,12 +743,7 @@ static inline void ice_tx_xsk_pool(struct ice_vsi *vsi, u16 qid)
 	if (!ring)
 		return;
 
-	if (!ice_is_xdp_ena_vsi(vsi) || !test_bit(qid, vsi->af_xdp_zc_qps)) {
-		ring->xsk_pool = NULL;
-		return;
-	}
-
-	ring->xsk_pool = xsk_get_pool_from_qid(vsi->netdev, qid);
+	ring->xsk_pool = ice_get_xp_from_qid(vsi, qid);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index fe48164dce1e..4d53c40a9de2 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -848,9 +848,9 @@ struct ice_aqc_txsched_elem {
 	u8 generic;
 #define ICE_AQC_ELEM_GENERIC_MODE_M		0x1
 #define ICE_AQC_ELEM_GENERIC_PRIO_S		0x1
-#define ICE_AQC_ELEM_GENERIC_PRIO_M	(0x7 << ICE_AQC_ELEM_GENERIC_PRIO_S)
+#define ICE_AQC_ELEM_GENERIC_PRIO_M	        GENMASK(3, 1)
 #define ICE_AQC_ELEM_GENERIC_SP_S		0x4
-#define ICE_AQC_ELEM_GENERIC_SP_M	(0x1 << ICE_AQC_ELEM_GENERIC_SP_S)
+#define ICE_AQC_ELEM_GENERIC_SP_M	        GENMASK(4, 4)
 #define ICE_AQC_ELEM_GENERIC_ADJUST_VAL_S	0x5
 #define ICE_AQC_ELEM_GENERIC_ADJUST_VAL_M	\
 	(0x3 << ICE_AQC_ELEM_GENERIC_ADJUST_VAL_S)
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 039342a0ed15..419052ebc3ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -789,8 +789,7 @@ static void ice_cleanup_fltr_mgmt_struct(struct ice_hw *hw)
 				devm_kfree(ice_hw_to_dev(hw), lst_itr);
 			}
 		}
-		if (recps[i].root_buf)
-			devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
+		devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
 	}
 	ice_rm_all_sw_replay_rule_info(hw);
 	devm_kfree(ice_hw_to_dev(hw), sw->recp_list);
@@ -986,8 +985,7 @@ static int ice_cfg_fw_log(struct ice_hw *hw, bool enable)
 	}
 
 out:
-	if (data)
-		devm_kfree(ice_hw_to_dev(hw), data);
+	devm_kfree(ice_hw_to_dev(hw), data);
 
 	return status;
 }
@@ -1105,6 +1103,9 @@ int ice_init_hw(struct ice_hw *hw)
 
 	hw->evb_veb = true;
 
+	/* init xarray for identifying scheduling nodes uniquely */
+	xa_init_flags(&hw->port_info->sched_node_ids, XA_FLAGS_ALLOC);
+
 	/* Query the allocated resources for Tx scheduler */
 	status = ice_sched_query_res_alloc(hw);
 	if (status) {
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index 6bcfee295991..f68df8e05b18 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -339,8 +339,7 @@ do {									\
 		}							\
 	}								\
 	/* free the buffer info list */					\
-	if ((qi)->ring.cmd_buf)						\
-		devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);	\
+	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);		\
 	/* free DMA head */						\
 	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.dma_head);		\
 } while (0)
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index ef103e47a8dc..85cca572c22a 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1303,23 +1303,6 @@ ice_flow_find_prof_id(struct ice_hw *hw, enum ice_block blk, u64 prof_id)
 	return NULL;
 }
 
-/**
- * ice_dealloc_flow_entry - Deallocate flow entry memory
- * @hw: pointer to the HW struct
- * @entry: flow entry to be removed
- */
-static void
-ice_dealloc_flow_entry(struct ice_hw *hw, struct ice_flow_entry *entry)
-{
-	if (!entry)
-		return;
-
-	if (entry->entry)
-		devm_kfree(ice_hw_to_dev(hw), entry->entry);
-
-	devm_kfree(ice_hw_to_dev(hw), entry);
-}
-
 /**
  * ice_flow_rem_entry_sync - Remove a flow entry
  * @hw: pointer to the HW struct
@@ -1335,7 +1318,8 @@ ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block __always_unused blk,
 
 	list_del(&entry->l_entry);
 
-	ice_dealloc_flow_entry(hw, entry);
+	devm_kfree(ice_hw_to_dev(hw), entry->entry);
+	devm_kfree(ice_hw_to_dev(hw), entry);
 
 	return 0;
 }
@@ -1662,8 +1646,7 @@ ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
 
 out:
 	if (status && e) {
-		if (e->entry)
-			devm_kfree(ice_hw_to_dev(hw), e->entry);
+		devm_kfree(ice_hw_to_dev(hw), e->entry);
 		devm_kfree(ice_hw_to_dev(hw), e);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index cc6c04a69b28..7661e735d099 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -117,14 +117,8 @@ static int ice_vsi_alloc_arrays(struct ice_vsi *vsi)
 	if (!vsi->q_vectors)
 		goto err_vectors;
 
-	vsi->af_xdp_zc_qps = bitmap_zalloc(max_t(int, vsi->alloc_txq, vsi->alloc_rxq), GFP_KERNEL);
-	if (!vsi->af_xdp_zc_qps)
-		goto err_zc_qps;
-
 	return 0;
 
-err_zc_qps:
-	devm_kfree(dev, vsi->q_vectors);
 err_vectors:
 	devm_kfree(dev, vsi->rxq_map);
 err_rxq_map:
@@ -320,31 +314,17 @@ static void ice_vsi_free_arrays(struct ice_vsi *vsi)
 
 	dev = ice_pf_to_dev(pf);
 
-	if (vsi->af_xdp_zc_qps) {
-		bitmap_free(vsi->af_xdp_zc_qps);
-		vsi->af_xdp_zc_qps = NULL;
-	}
 	/* free the ring and vector containers */
-	if (vsi->q_vectors) {
-		devm_kfree(dev, vsi->q_vectors);
-		vsi->q_vectors = NULL;
-	}
-	if (vsi->tx_rings) {
-		devm_kfree(dev, vsi->tx_rings);
-		vsi->tx_rings = NULL;
-	}
-	if (vsi->rx_rings) {
-		devm_kfree(dev, vsi->rx_rings);
-		vsi->rx_rings = NULL;
-	}
-	if (vsi->txq_map) {
-		devm_kfree(dev, vsi->txq_map);
-		vsi->txq_map = NULL;
-	}
-	if (vsi->rxq_map) {
-		devm_kfree(dev, vsi->rxq_map);
-		vsi->rxq_map = NULL;
-	}
+	devm_kfree(dev, vsi->q_vectors);
+	vsi->q_vectors = NULL;
+	devm_kfree(dev, vsi->tx_rings);
+	vsi->tx_rings = NULL;
+	devm_kfree(dev, vsi->rx_rings);
+	vsi->rx_rings = NULL;
+	devm_kfree(dev, vsi->txq_map);
+	vsi->txq_map = NULL;
+	devm_kfree(dev, vsi->rxq_map);
+	vsi->rxq_map = NULL;
 }
 
 /**
@@ -787,10 +767,8 @@ static void ice_rss_clean(struct ice_vsi *vsi)
 
 	dev = ice_pf_to_dev(pf);
 
-	if (vsi->rss_hkey_user)
-		devm_kfree(dev, vsi->rss_hkey_user);
-	if (vsi->rss_lut_user)
-		devm_kfree(dev, vsi->rss_lut_user);
+	devm_kfree(dev, vsi->rss_hkey_user);
+	devm_kfree(dev, vsi->rss_lut_user);
 
 	ice_vsi_clean_rss_flow_fld(vsi);
 	/* remove RSS replay list */
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index c262dc886e6a..07ef6b1f0088 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -441,8 +441,7 @@ int
 ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
 		       u16 module_type)
 {
-	u16 pfa_len, pfa_ptr;
-	u16 next_tlv;
+	u16 pfa_len, pfa_ptr, next_tlv, max_tlv;
 	int status;
 
 	status = ice_read_sr_word(hw, ICE_SR_PFA_PTR, &pfa_ptr);
@@ -455,11 +454,23 @@ ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
 		ice_debug(hw, ICE_DBG_INIT, "Failed to read PFA length.\n");
 		return status;
 	}
+
+	/* The Preserved Fields Area contains a sequence of Type-Length-Value
+	 * structures which define its contents. The PFA length includes all
+	 * of the TLVs, plus the initial length word itself, *and* one final
+	 * word at the end after all of the TLVs.
+	 */
+	if (check_add_overflow(pfa_ptr, pfa_len - 1, &max_tlv)) {
+		dev_warn(ice_hw_to_dev(hw), "PFA starts at offset %u. PFA length of %u caused 16-bit arithmetic overflow.\n",
+			 pfa_ptr, pfa_len);
+		return -EINVAL;
+	}
+
 	/* Starting with first TLV after PFA length, iterate through the list
 	 * of TLVs to find the requested one.
 	 */
 	next_tlv = pfa_ptr + 1;
-	while (next_tlv < pfa_ptr + pfa_len) {
+	while (next_tlv < max_tlv) {
 		u16 tlv_sub_module_type;
 		u16 tlv_len;
 
@@ -483,10 +494,13 @@ ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
 			}
 			return -EINVAL;
 		}
-		/* Check next TLV, i.e. current TLV pointer + length + 2 words
-		 * (for current TLV's type and length)
-		 */
-		next_tlv = next_tlv + tlv_len + 2;
+
+		if (check_add_overflow(next_tlv, 2, &next_tlv) ||
+		    check_add_overflow(next_tlv, tlv_len, &next_tlv)) {
+			dev_warn(ice_hw_to_dev(hw), "TLV of type %u and length 0x%04x caused 16-bit arithmetic overflow. The PFA starts at 0x%04x and has length of 0x%04x\n",
+				 tlv_sub_module_type, tlv_len, pfa_ptr, pfa_len);
+			return -EINVAL;
+		}
 	}
 	/* Module does not exist */
 	return -ENOENT;
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 2c62c1763ee0..849b6c7f0506 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2018, Intel Corporation. */
 
+#include <net/devlink.h>
 #include "ice_sched.h"
 
 /**
@@ -352,9 +353,9 @@ void ice_free_sched_node(struct ice_port_info *pi, struct ice_sched_node *node)
 				node->sibling;
 	}
 
-	/* leaf nodes have no children */
-	if (node->children)
-		devm_kfree(ice_hw_to_dev(hw), node->children);
+	devm_kfree(ice_hw_to_dev(hw), node->children);
+	kfree(node->name);
+	xa_erase(&pi->sched_node_ids, node->id);
 	devm_kfree(ice_hw_to_dev(hw), node);
 }
 
@@ -850,10 +851,8 @@ void ice_sched_cleanup_all(struct ice_hw *hw)
 	if (!hw)
 		return;
 
-	if (hw->layer_info) {
-		devm_kfree(ice_hw_to_dev(hw), hw->layer_info);
-		hw->layer_info = NULL;
-	}
+	devm_kfree(ice_hw_to_dev(hw), hw->layer_info);
+	hw->layer_info = NULL;
 
 	ice_sched_clear_port(hw->port_info);
 
@@ -875,7 +874,7 @@ void ice_sched_cleanup_all(struct ice_hw *hw)
  *
  * This function add nodes to HW as well as to SW DB for a given layer
  */
-static int
+int
 ice_sched_add_elems(struct ice_port_info *pi, struct ice_sched_node *tc_node,
 		    struct ice_sched_node *parent, u8 layer, u16 num_nodes,
 		    u16 *num_nodes_added, u32 *first_node_teid)
@@ -940,6 +939,22 @@ ice_sched_add_elems(struct ice_port_info *pi, struct ice_sched_node *tc_node,
 
 		new_node->sibling = NULL;
 		new_node->tc_num = tc_node->tc_num;
+		new_node->tx_weight = ICE_SCHED_DFLT_BW_WT;
+		new_node->tx_share = ICE_SCHED_DFLT_BW;
+		new_node->tx_max = ICE_SCHED_DFLT_BW;
+		new_node->name = kzalloc(SCHED_NODE_NAME_MAX_LEN, GFP_KERNEL);
+		if (!new_node->name)
+			return -ENOMEM;
+
+		status = xa_alloc(&pi->sched_node_ids, &new_node->id, NULL, XA_LIMIT(0, UINT_MAX),
+				  GFP_KERNEL);
+		if (status) {
+			ice_debug(hw, ICE_DBG_SCHED, "xa_alloc failed for sched node status =%d\n",
+				  status);
+			break;
+		}
+
+		snprintf(new_node->name, SCHED_NODE_NAME_MAX_LEN, "node_%u", new_node->id);
 
 		/* add it to previous node sibling pointer */
 		/* Note: siblings are not linked across branches */
@@ -2154,7 +2169,7 @@ ice_sched_get_free_vsi_parent(struct ice_hw *hw, struct ice_sched_node *node,
  * This function removes the child from the old parent and adds it to a new
  * parent
  */
-static void
+void
 ice_sched_update_parent(struct ice_sched_node *new_parent,
 			struct ice_sched_node *node)
 {
@@ -2188,7 +2203,7 @@ ice_sched_update_parent(struct ice_sched_node *new_parent,
  *
  * This function move the child nodes to a given parent.
  */
-static int
+int
 ice_sched_move_nodes(struct ice_port_info *pi, struct ice_sched_node *parent,
 		     u16 num_items, u32 *list)
 {
@@ -3562,7 +3577,7 @@ ice_sched_set_eir_srl_excl(struct ice_port_info *pi,
  * node's RL profile ID of type CIR, EIR, or SRL, and removes old profile
  * ID from local database. The caller needs to hold scheduler lock.
  */
-static int
+int
 ice_sched_set_node_bw(struct ice_port_info *pi, struct ice_sched_node *node,
 		      enum ice_rl_type rl_type, u32 bw, u8 layer_num)
 {
@@ -3598,6 +3613,57 @@ ice_sched_set_node_bw(struct ice_port_info *pi, struct ice_sched_node *node,
 				       ICE_AQC_RL_PROFILE_TYPE_M, old_id);
 }
 
+/**
+ * ice_sched_set_node_priority - set node's priority
+ * @pi: port information structure
+ * @node: tree node
+ * @priority: number 0-7 representing priority among siblings
+ *
+ * This function sets priority of a node among it's siblings.
+ */
+int
+ice_sched_set_node_priority(struct ice_port_info *pi, struct ice_sched_node *node,
+			    u16 priority)
+{
+	struct ice_aqc_txsched_elem_data buf;
+	struct ice_aqc_txsched_elem *data;
+
+	buf = node->info;
+	data = &buf.data;
+
+	data->valid_sections |= ICE_AQC_ELEM_VALID_GENERIC;
+	data->generic |= FIELD_PREP(ICE_AQC_ELEM_GENERIC_PRIO_M, priority);
+
+	return ice_sched_update_elem(pi->hw, node, &buf);
+}
+
+/**
+ * ice_sched_set_node_weight - set node's weight
+ * @pi: port information structure
+ * @node: tree node
+ * @weight: number 1-200 representing weight for WFQ
+ *
+ * This function sets weight of the node for WFQ algorithm.
+ */
+int
+ice_sched_set_node_weight(struct ice_port_info *pi, struct ice_sched_node *node, u16 weight)
+{
+	struct ice_aqc_txsched_elem_data buf;
+	struct ice_aqc_txsched_elem *data;
+
+	buf = node->info;
+	data = &buf.data;
+
+	data->valid_sections = ICE_AQC_ELEM_VALID_CIR | ICE_AQC_ELEM_VALID_EIR |
+			       ICE_AQC_ELEM_VALID_GENERIC;
+	data->cir_bw.bw_alloc = cpu_to_le16(weight);
+	data->eir_bw.bw_alloc = cpu_to_le16(weight);
+
+	data->generic |= FIELD_PREP(ICE_AQC_ELEM_GENERIC_SP_M, 0x0);
+
+	return ice_sched_update_elem(pi->hw, node, &buf);
+}
+
 /**
  * ice_sched_set_node_bw_lmt - set node's BW limit
  * @pi: port information structure
@@ -3608,7 +3674,7 @@ ice_sched_set_node_bw(struct ice_port_info *pi, struct ice_sched_node *node,
  * It updates node's BW limit parameters like BW RL profile ID of type CIR,
  * EIR, or SRL. The caller needs to hold scheduler lock.
  */
-static int
+int
 ice_sched_set_node_bw_lmt(struct ice_port_info *pi, struct ice_sched_node *node,
 			  enum ice_rl_type rl_type, u32 bw)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.h b/drivers/net/ethernet/intel/ice/ice_sched.h
index 4f91577fed56..920db43ed4fa 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.h
+++ b/drivers/net/ethernet/intel/ice/ice_sched.h
@@ -6,6 +6,8 @@
 
 #include "ice_common.h"
 
+#define SCHED_NODE_NAME_MAX_LEN 32
+
 #define ICE_QGRP_LAYER_OFFSET	2
 #define ICE_VSI_LAYER_OFFSET	4
 #define ICE_AGG_LAYER_OFFSET	6
@@ -69,6 +71,28 @@ int
 ice_aq_query_sched_elems(struct ice_hw *hw, u16 elems_req,
 			 struct ice_aqc_txsched_elem_data *buf, u16 buf_size,
 			 u16 *elems_ret, struct ice_sq_cd *cd);
+
+int
+ice_sched_set_node_bw_lmt(struct ice_port_info *pi, struct ice_sched_node *node,
+			  enum ice_rl_type rl_type, u32 bw);
+
+int
+ice_sched_set_node_bw(struct ice_port_info *pi, struct ice_sched_node *node,
+		      enum ice_rl_type rl_type, u32 bw, u8 layer_num);
+
+int
+ice_sched_add_elems(struct ice_port_info *pi, struct ice_sched_node *tc_node,
+		    struct ice_sched_node *parent, u8 layer, u16 num_nodes,
+		    u16 *num_nodes_added, u32 *first_node_teid);
+
+int
+ice_sched_move_nodes(struct ice_port_info *pi, struct ice_sched_node *parent,
+		     u16 num_items, u32 *list);
+
+int ice_sched_set_node_priority(struct ice_port_info *pi, struct ice_sched_node *node,
+				u16 priority);
+int ice_sched_set_node_weight(struct ice_port_info *pi, struct ice_sched_node *node, u16 weight);
+
 int ice_sched_init_port(struct ice_port_info *pi);
 int ice_sched_query_res_alloc(struct ice_hw *hw);
 void ice_sched_get_psm_clk_freq(struct ice_hw *hw);
@@ -82,6 +106,9 @@ ice_sched_find_node_by_teid(struct ice_sched_node *start_node, u32 teid);
 int
 ice_sched_add_node(struct ice_port_info *pi, u8 layer,
 		   struct ice_aqc_txsched_elem_data *info);
+void
+ice_sched_update_parent(struct ice_sched_node *new_parent,
+			struct ice_sched_node *node);
 void ice_free_sched_node(struct ice_port_info *pi, struct ice_sched_node *node);
 struct ice_sched_node *ice_sched_get_tc_node(struct ice_port_info *pi, u8 tc);
 struct ice_sched_node *
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 46b36851af46..5ea636587257 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1636,21 +1636,16 @@ ice_save_vsi_ctx(struct ice_hw *hw, u16 vsi_handle, struct ice_vsi_ctx *vsi)
  */
 static void ice_clear_vsi_q_ctx(struct ice_hw *hw, u16 vsi_handle)
 {
-	struct ice_vsi_ctx *vsi;
+	struct ice_vsi_ctx *vsi = ice_get_vsi_ctx(hw, vsi_handle);
 	u8 i;
 
-	vsi = ice_get_vsi_ctx(hw, vsi_handle);
 	if (!vsi)
 		return;
 	ice_for_each_traffic_class(i) {
-		if (vsi->lan_q_ctx[i]) {
-			devm_kfree(ice_hw_to_dev(hw), vsi->lan_q_ctx[i]);
-			vsi->lan_q_ctx[i] = NULL;
-		}
-		if (vsi->rdma_q_ctx[i]) {
-			devm_kfree(ice_hw_to_dev(hw), vsi->rdma_q_ctx[i]);
-			vsi->rdma_q_ctx[i] = NULL;
-		}
+		devm_kfree(ice_hw_to_dev(hw), vsi->lan_q_ctx[i]);
+		vsi->lan_q_ctx[i] = NULL;
+		devm_kfree(ice_hw_to_dev(hw), vsi->rdma_q_ctx[i]);
+		vsi->rdma_q_ctx[i] = NULL;
 	}
 }
 
@@ -5525,9 +5520,7 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		devm_kfree(ice_hw_to_dev(hw), fvit);
 	}
 
-	if (rm->root_buf)
-		devm_kfree(ice_hw_to_dev(hw), rm->root_buf);
-
+	devm_kfree(ice_hw_to_dev(hw), rm->root_buf);
 	kfree(rm);
 
 err_free_lkup_exts:
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index e1abfcee96dc..daf86cf561bc 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -524,7 +524,14 @@ struct ice_sched_node {
 	struct ice_sched_node *sibling; /* next sibling in the same layer */
 	struct ice_sched_node **children;
 	struct ice_aqc_txsched_elem_data info;
+	char *name;
+	struct devlink_rate *rate_node;
+	u64 tx_max;
+	u64 tx_share;
 	u32 agg_id;			/* aggregator group ID */
+	u32 id;
+	u32 tx_priority;
+	u32 tx_weight;
 	u16 vsi_handle;
 	u8 in_use;			/* suspended or in use */
 	u8 tx_sched_layer;		/* Logical Layer (1-9) */
@@ -706,6 +713,7 @@ struct ice_port_info {
 	/* List contain profile ID(s) and other params per layer */
 	struct list_head rl_prof_list[ICE_AQC_TOPO_MAX_LEVEL_NUM];
 	struct ice_qos_cfg qos_cfg;
+	struct xarray sched_node_ids;
 	u8 is_vf:1;
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 48cf24709fe3..b917f271cdac 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -281,7 +281,6 @@ static int ice_xsk_pool_disable(struct ice_vsi *vsi, u16 qid)
 	if (!pool)
 		return -EINVAL;
 
-	clear_bit(qid, vsi->af_xdp_zc_qps);
 	xsk_pool_dma_unmap(pool, ICE_RX_DMA_ATTR);
 
 	return 0;
@@ -312,8 +311,6 @@ ice_xsk_pool_enable(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 	if (err)
 		return err;
 
-	set_bit(qid, vsi->af_xdp_zc_qps);
-
 	return 0;
 }
 
@@ -361,11 +358,13 @@ ice_realloc_rx_xdp_bufs(struct ice_rx_ring *rx_ring, bool pool_present)
 int ice_realloc_zc_buf(struct ice_vsi *vsi, bool zc)
 {
 	struct ice_rx_ring *rx_ring;
-	unsigned long q;
+	uint i;
+
+	ice_for_each_rxq(vsi, i) {
+		rx_ring = vsi->rx_rings[i];
+		if (!rx_ring->xsk_pool)
+			continue;
 
-	for_each_set_bit(q, vsi->af_xdp_zc_qps,
-			 max_t(int, vsi->alloc_txq, vsi->alloc_rxq)) {
-		rx_ring = vsi->rx_rings[q];
 		if (ice_realloc_rx_xdp_bufs(rx_ring, zc))
 			return -ENOMEM;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 91a4ea529d07..00ef6d201b97 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2506,7 +2506,17 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	 * - when available free entries are less.
 	 * Lower priority ones out of avaialble free entries are always
 	 * chosen when 'high vs low' question arises.
+	 *
+	 * For a VF base MCAM match rule is set by its PF. And all the
+	 * further MCAM rules installed by VF on its own are
+	 * concatenated with the base rule set by its PF. Hence PF entries
+	 * should be at lower priority compared to VF entries. Otherwise
+	 * base rule is hit always and rules installed by VF will be of
+	 * no use. Hence if the request is from PF then allocate low
+	 * priority entries.
 	 */
+	if (!(pcifunc & RVU_PFVF_FUNC_MASK))
+		goto lprio_alloc;
 
 	/* Get the search range for priority allocation request */
 	if (req->priority) {
@@ -2515,17 +2525,6 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 		goto alloc;
 	}
 
-	/* For a VF base MCAM match rule is set by its PF. And all the
-	 * further MCAM rules installed by VF on its own are
-	 * concatenated with the base rule set by its PF. Hence PF entries
-	 * should be at lower priority compared to VF entries. Otherwise
-	 * base rule is hit always and rules installed by VF will be of
-	 * no use. Hence if the request is from PF and NOT a priority
-	 * allocation request then allocate low priority entries.
-	 */
-	if (!(pcifunc & RVU_PFVF_FUNC_MASK))
-		goto lprio_alloc;
-
 	/* Find out the search range for non-priority allocation request
 	 *
 	 * Get MCAM free entry count in middle zone.
@@ -2555,6 +2554,18 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 		reverse = true;
 		start = 0;
 		end = mcam->bmap_entries;
+		/* Ensure PF requests are always at bottom and if PF requests
+		 * for higher/lower priority entry wrt reference entry then
+		 * honour that criteria and start search for entries from bottom
+		 * and not in mid zone.
+		 */
+		if (!(pcifunc & RVU_PFVF_FUNC_MASK) &&
+		    req->priority == NPC_MCAM_HIGHER_PRIO)
+			end = req->ref_entry;
+
+		if (!(pcifunc & RVU_PFVF_FUNC_MASK) &&
+		    req->priority == NPC_MCAM_LOWER_PRIO)
+			start = req->ref_entry;
 	}
 
 alloc:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e2f134e1d9fc..4c0eac83546d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4587,7 +4587,7 @@ static netdev_features_t mlx5e_tunnel_features_check(struct mlx5e_priv *priv,
 
 		/* Verify if UDP port is being offloaded by HW */
 		if (mlx5_vxlan_lookup_port(priv->mdev->vxlan, port))
-			return features;
+			return vxlan_features_check(skb, features);
 
 #if IS_ENABLED(CONFIG_GENEVE)
 		/* Support Geneve offload for default UDP port */
@@ -4613,7 +4613,6 @@ netdev_features_t mlx5e_features_check(struct sk_buff *skb,
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 
 	features = vlan_features_check(skb, features);
-	features = vxlan_features_check(skb, features);
 
 	/* Validate if the tunneled packet is being offloaded by HW */
 	if (skb->encapsulation &&
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index f34e758a2f1f..9e26dda93f8e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -379,6 +379,10 @@ int mlx5_cmd_fast_teardown_hca(struct mlx5_core_dev *dev)
 	do {
 		if (mlx5_get_nic_state(dev) == MLX5_NIC_IFC_DISABLED)
 			break;
+		if (pci_channel_offline(dev->pdev)) {
+			mlx5_core_err(dev, "PCI channel offline, stop waiting for NIC IFC\n");
+			return -EACCES;
+		}
 
 		cond_resched();
 	} while (!time_after(jiffies, end));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index e42e4ac231c6..65483dab9057 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -260,6 +260,10 @@ void mlx5_error_sw_reset(struct mlx5_core_dev *dev)
 	do {
 		if (mlx5_get_nic_state(dev) == MLX5_NIC_IFC_DISABLED)
 			break;
+		if (pci_channel_offline(dev->pdev)) {
+			mlx5_core_err(dev, "PCI channel offline, stop waiting for NIC IFC\n");
+			goto unlock;
+		}
 
 		msleep(20);
 	} while (!time_after(jiffies, end));
@@ -325,6 +329,14 @@ int mlx5_health_wait_pci_up(struct mlx5_core_dev *dev)
 	while (sensor_pci_not_working(dev)) {
 		if (time_after(jiffies, end))
 			return -ETIMEDOUT;
+		if (test_bit(MLX5_BREAK_FW_WAIT, &dev->intf_state)) {
+			mlx5_core_warn(dev, "device is being removed, stop waiting for PCI\n");
+			return -ENODEV;
+		}
+		if (pci_channel_offline(dev->pdev)) {
+			mlx5_core_err(dev, "PCI channel offline, stop waiting for PCI\n");
+			return -EACCES;
+		}
 		msleep(100);
 	}
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index 7d9bbb494d95..005661248c7e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -88,9 +88,13 @@ static int mlx5_lag_create_port_sel_table(struct mlx5_lag *ldev,
 								      &dest, 1);
 			if (IS_ERR(lag_definer->rules[idx])) {
 				err = PTR_ERR(lag_definer->rules[idx]);
-				while (i--)
-					while (j--)
+				do {
+					while (j--) {
+						idx = i * ldev->buckets + j;
 						mlx5_del_flow_rules(lag_definer->rules[idx]);
+					}
+					j = ldev->buckets;
+				} while (i--);
 				goto destroy_fg;
 			}
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
index 6b774e0c2766..d0b595ba6110 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
@@ -74,6 +74,10 @@ int mlx5_vsc_gw_lock(struct mlx5_core_dev *dev)
 			ret = -EBUSY;
 			goto pci_unlock;
 		}
+		if (pci_channel_offline(dev->pdev)) {
+			ret = -EACCES;
+			goto pci_unlock;
+		}
 
 		/* Check if semaphore is already locked */
 		ret = vsc_read(dev, VSC_SEMAPHORE_OFFSET, &lock_val);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 6ab0642e9de7..67849b1c0bb7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1093,7 +1093,7 @@ static void mlx5_cleanup_once(struct mlx5_core_dev *dev)
 	mlx5_devcom_unregister_device(dev->priv.devcom);
 }
 
-static int mlx5_function_setup(struct mlx5_core_dev *dev, bool boot, u64 timeout)
+static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeout)
 {
 	int err;
 
@@ -1158,28 +1158,56 @@ static int mlx5_function_setup(struct mlx5_core_dev *dev, bool boot, u64 timeout
 		goto reclaim_boot_pages;
 	}
 
+	return 0;
+
+reclaim_boot_pages:
+	mlx5_reclaim_startup_pages(dev);
+err_disable_hca:
+	mlx5_core_disable_hca(dev, 0);
+stop_health_poll:
+	mlx5_stop_health_poll(dev, boot);
+err_cmd_cleanup:
+	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_DOWN);
+	mlx5_cmd_cleanup(dev);
+
+	return err;
+}
+
+static void mlx5_function_disable(struct mlx5_core_dev *dev, bool boot)
+{
+	mlx5_reclaim_startup_pages(dev);
+	mlx5_core_disable_hca(dev, 0);
+	mlx5_stop_health_poll(dev, boot);
+	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_DOWN);
+	mlx5_cmd_cleanup(dev);
+}
+
+static int mlx5_function_open(struct mlx5_core_dev *dev)
+{
+	int err;
+
 	err = set_hca_ctrl(dev);
 	if (err) {
 		mlx5_core_err(dev, "set_hca_ctrl failed\n");
-		goto reclaim_boot_pages;
+		return err;
 	}
 
 	err = set_hca_cap(dev);
 	if (err) {
 		mlx5_core_err(dev, "set_hca_cap failed\n");
-		goto reclaim_boot_pages;
+		return err;
 	}
 
 	err = mlx5_satisfy_startup_pages(dev, 0);
 	if (err) {
 		mlx5_core_err(dev, "failed to allocate init pages\n");
-		goto reclaim_boot_pages;
+		return err;
 	}
 
 	err = mlx5_cmd_init_hca(dev, sw_owner_id);
 	if (err) {
 		mlx5_core_err(dev, "init hca failed\n");
-		goto reclaim_boot_pages;
+		return err;
 	}
 
 	mlx5_set_driver_version(dev);
@@ -1187,26 +1215,13 @@ static int mlx5_function_setup(struct mlx5_core_dev *dev, bool boot, u64 timeout
 	err = mlx5_query_hca_caps(dev);
 	if (err) {
 		mlx5_core_err(dev, "query hca failed\n");
-		goto reclaim_boot_pages;
+		return err;
 	}
 	mlx5_start_health_fw_log_up(dev);
-
 	return 0;
-
-reclaim_boot_pages:
-	mlx5_reclaim_startup_pages(dev);
-err_disable_hca:
-	mlx5_core_disable_hca(dev, 0);
-stop_health_poll:
-	mlx5_stop_health_poll(dev, boot);
-err_cmd_cleanup:
-	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_DOWN);
-	mlx5_cmd_cleanup(dev);
-
-	return err;
 }
 
-static int mlx5_function_teardown(struct mlx5_core_dev *dev, bool boot)
+static int mlx5_function_close(struct mlx5_core_dev *dev)
 {
 	int err;
 
@@ -1215,15 +1230,36 @@ static int mlx5_function_teardown(struct mlx5_core_dev *dev, bool boot)
 		mlx5_core_err(dev, "tear_down_hca failed, skip cleanup\n");
 		return err;
 	}
-	mlx5_reclaim_startup_pages(dev);
-	mlx5_core_disable_hca(dev, 0);
-	mlx5_stop_health_poll(dev, boot);
-	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_DOWN);
-	mlx5_cmd_cleanup(dev);
 
 	return 0;
 }
 
+static int mlx5_function_setup(struct mlx5_core_dev *dev, bool boot, u64 timeout)
+{
+	int err;
+
+	err = mlx5_function_enable(dev, boot, timeout);
+	if (err)
+		return err;
+
+	err = mlx5_function_open(dev);
+	if (err)
+		mlx5_function_disable(dev, boot);
+	return err;
+}
+
+static int mlx5_function_teardown(struct mlx5_core_dev *dev, bool boot)
+{
+	int err = mlx5_function_close(dev);
+
+	if (!err)
+		mlx5_function_disable(dev, boot);
+	else
+		mlx5_stop_health_poll(dev, boot);
+
+	return err;
+}
+
 static int mlx5_load(struct mlx5_core_dev *dev)
 {
 	int err;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index d33cf8ee7c33..d34aea85f8a6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -292,10 +292,8 @@ static int ionic_qcq_enable(struct ionic_qcq *qcq)
 	if (ret)
 		return ret;
 
-	if (qcq->napi.poll)
-		napi_enable(&qcq->napi);
-
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
+		napi_enable(&qcq->napi);
 		irq_set_affinity_hint(qcq->intr.vector,
 				      &qcq->intr.affinity_mask);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 390c900832cd..074ff289eaf2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -343,10 +343,11 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 			struct tc_cbs_qopt_offload *qopt)
 {
 	u32 tx_queues_count = priv->plat->tx_queues_to_use;
+	s64 port_transmit_rate_kbps;
 	u32 queue = qopt->queue;
-	u32 ptr, speed_div;
 	u32 mode_to_use;
 	u64 value;
+	u32 ptr;
 	int ret;
 
 	/* Queue 0 is not AVB capable */
@@ -355,30 +356,26 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	if (!priv->dma_cap.av)
 		return -EOPNOTSUPP;
 
+	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
+
 	/* Port Transmit Rate and Speed Divider */
-	switch (priv->speed) {
+	switch (div_s64(port_transmit_rate_kbps, 1000)) {
 	case SPEED_10000:
-		ptr = 32;
-		speed_div = 10000000;
-		break;
 	case SPEED_5000:
 		ptr = 32;
-		speed_div = 5000000;
 		break;
 	case SPEED_2500:
-		ptr = 8;
-		speed_div = 2500000;
-		break;
 	case SPEED_1000:
 		ptr = 8;
-		speed_div = 1000000;
 		break;
 	case SPEED_100:
 		ptr = 4;
-		speed_div = 100000;
 		break;
 	default:
-		return -EOPNOTSUPP;
+		netdev_err(priv->dev,
+			   "Invalid portTransmitRate %lld (idleSlope - sendSlope)\n",
+			   port_transmit_rate_kbps);
+		return -EINVAL;
 	}
 
 	mode_to_use = priv->plat->tx_queues_cfg[queue].mode_to_use;
@@ -398,10 +395,10 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	}
 
 	/* Final adjustments for HW */
-	value = div_s64(qopt->idleslope * 1024ll * ptr, speed_div);
+	value = div_s64(qopt->idleslope * 1024ll * ptr, port_transmit_rate_kbps);
 	priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
 
-	value = div_s64(-qopt->sendslope * 1024ll * ptr, speed_div);
+	value = div_s64(-qopt->sendslope * 1024ll * ptr, port_transmit_rate_kbps);
 	priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
 
 	value = qopt->hicredit * 1024ll * 8;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 488ca1c85496..c4a49a75250e 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -919,6 +919,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			   struct geneve_dev *geneve,
 			   const struct ip_tunnel_info *info)
 {
+	bool inner_proto_inherit = geneve->cfg.inner_proto_inherit;
 	bool xnet = !net_eq(geneve->net, dev_net(geneve->dev));
 	struct geneve_sock *gs4 = rcu_dereference(geneve->sock4);
 	const struct ip_tunnel_key *key = &info->key;
@@ -930,7 +931,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb))
+	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
 		return -EINVAL;
 
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
@@ -1003,7 +1004,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	err = geneve_build_skb(&rt->dst, skb, info, xnet, sizeof(struct iphdr),
-			       geneve->cfg.inner_proto_inherit);
+			       inner_proto_inherit);
 	if (unlikely(err))
 		return err;
 
@@ -1019,6 +1020,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    struct geneve_dev *geneve,
 			    const struct ip_tunnel_info *info)
 {
+	bool inner_proto_inherit = geneve->cfg.inner_proto_inherit;
 	bool xnet = !net_eq(geneve->net, dev_net(geneve->dev));
 	struct geneve_sock *gs6 = rcu_dereference(geneve->sock6);
 	const struct ip_tunnel_key *key = &info->key;
@@ -1028,7 +1030,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb))
+	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
 		return -EINVAL;
 
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
@@ -1083,7 +1085,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		ttl = ttl ? : ip6_dst_hoplimit(dst);
 	}
 	err = geneve_build_skb(dst, skb, info, xnet, sizeof(struct ipv6hdr),
-			       geneve->cfg.inner_proto_inherit);
+			       inner_proto_inherit);
 	if (unlikely(err))
 		return err;
 
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 9b1403291d92..06dce78d7b0c 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -2150,8 +2150,7 @@ static void sfp_sm_module(struct sfp *sfp, unsigned int event)
 
 	/* Handle remove event globally, it resets this state machine */
 	if (event == SFP_E_REMOVE) {
-		if (sfp->sm_mod_state > SFP_MOD_PROBE)
-			sfp_sm_mod_remove(sfp);
+		sfp_sm_mod_remove(sfp);
 		sfp_sm_mod_next(sfp, SFP_MOD_EMPTY, 0);
 		return;
 	}
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index a7ae68f490c4..61224a5a877c 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1493,6 +1493,10 @@ static bool vxlan_snoop(struct net_device *dev,
 	struct vxlan_fdb *f;
 	u32 ifindex = 0;
 
+	/* Ignore packets from invalid src-address */
+	if (!is_valid_ether_addr(src_mac))
+		return true;
+
 #if IS_ENABLED(CONFIG_IPV6)
 	if (src_ip->sa.sa_family == AF_INET6 &&
 	    (ipv6_addr_type(&src_ip->sin6.sin6_addr) & IPV6_ADDR_LINKLOCAL))
diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
index ca007b800f75..02ca6f8d788d 100644
--- a/drivers/net/wireless/ath/ath10k/Kconfig
+++ b/drivers/net/wireless/ath/ath10k/Kconfig
@@ -44,6 +44,7 @@ config ATH10K_SNOC
 	tristate "Qualcomm ath10k SNOC support"
 	depends on ATH10K
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on QCOM_RPROC_COMMON || QCOM_RPROC_COMMON=n
 	select QCOM_SCM
 	select QCOM_QMI_HELPERS
 	help
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 5eba1a355f04..024c37062a60 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1750,8 +1750,8 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
 err_fw:
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	debugfs_remove_recursive(drv->dbgfs_drv);
-	iwl_dbg_tlv_free(drv->trans);
 #endif
+	iwl_dbg_tlv_free(drv->trans);
 	kfree(drv);
 err:
 	return ERR_PTR(ret);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 2e3c98eaa400..668bb9ce293d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -91,20 +91,10 @@ void iwl_mvm_mfu_assert_dump_notif(struct iwl_mvm *mvm,
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_mfu_assert_dump_notif *mfu_dump_notif = (void *)pkt->data;
-	__le32 *dump_data = mfu_dump_notif->data;
-	int n_words = le32_to_cpu(mfu_dump_notif->data_size) / sizeof(__le32);
-	int i;
 
 	if (mfu_dump_notif->index_num == 0)
 		IWL_INFO(mvm, "MFUART assert id 0x%x occurred\n",
 			 le32_to_cpu(mfu_dump_notif->assert_id));
-
-	for (i = 0; i < n_words; i++)
-		IWL_DEBUG_INFO(mvm,
-			       "MFUART assert dump, dword %u: 0x%08x\n",
-			       le16_to_cpu(mfu_dump_notif->index_num) *
-			       n_words + i,
-			       le32_to_cpu(dump_data[i]));
 }
 
 static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index b7bc8c1b2dda..00f04f675cbb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -123,13 +123,8 @@ enum {
 
 #define LINK_QUAL_AGG_FRAME_LIMIT_DEF	(63)
 #define LINK_QUAL_AGG_FRAME_LIMIT_MAX	(63)
-/*
- * FIXME - various places in firmware API still use u8,
- * e.g. LQ command and SCD config command.
- * This should be 256 instead.
- */
-#define LINK_QUAL_AGG_FRAME_LIMIT_GEN2_DEF	(255)
-#define LINK_QUAL_AGG_FRAME_LIMIT_GEN2_MAX	(255)
+#define LINK_QUAL_AGG_FRAME_LIMIT_GEN2_DEF	(64)
+#define LINK_QUAL_AGG_FRAME_LIMIT_GEN2_MAX	(64)
 #define LINK_QUAL_AGG_FRAME_LIMIT_MIN	(0)
 
 #define LQ_SIZE		2	/* 2 mode tables:  "Active" and "Search" */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index b20d64dbba1a..a7a29f1659ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1298,7 +1298,7 @@ static void iwl_mvm_scan_umac_dwell(struct iwl_mvm *mvm,
 		if (IWL_MVM_ADWELL_MAX_BUDGET)
 			cmd->v7.adwell_max_budget =
 				cpu_to_le16(IWL_MVM_ADWELL_MAX_BUDGET);
-		else if (params->ssids && params->ssids[0].ssid_len)
+		else if (params->n_ssids && params->ssids[0].ssid_len)
 			cmd->v7.adwell_max_budget =
 				cpu_to_le16(IWL_SCAN_ADWELL_MAX_BUDGET_DIRECTED_SCAN);
 		else
@@ -1400,7 +1400,7 @@ iwl_mvm_scan_umac_dwell_v11(struct iwl_mvm *mvm,
 	if (IWL_MVM_ADWELL_MAX_BUDGET)
 		general_params->adwell_max_budget =
 			cpu_to_le16(IWL_MVM_ADWELL_MAX_BUDGET);
-	else if (params->ssids && params->ssids[0].ssid_len)
+	else if (params->n_ssids && params->ssids[0].ssid_len)
 		general_params->adwell_max_budget =
 			cpu_to_le16(IWL_SCAN_ADWELL_MAX_BUDGET_DIRECTED_SCAN);
 	else
diff --git a/drivers/net/wwan/iosm/iosm_ipc_devlink.c b/drivers/net/wwan/iosm/iosm_ipc_devlink.c
index 2fe724d623c0..33c5a46f1b92 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_devlink.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_devlink.c
@@ -210,7 +210,7 @@ static int ipc_devlink_create_region(struct iosm_devlink *devlink)
 			rc = PTR_ERR(devlink->cd_regions[i]);
 			dev_err(devlink->dev, "Devlink region fail,err %d", rc);
 			/* Delete previously created regions */
-			for ( ; i >= 0; i--)
+			for (i--; i >= 0; i--)
 				devlink_region_destroy(devlink->cd_regions[i]);
 			goto region_create_fail;
 		}
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index a0a292d49588..dc756a1c9d0e 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -226,13 +226,13 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	    req->cmd->common.opcode == nvme_admin_identify) {
 		switch (req->cmd->identify.cns) {
 		case NVME_ID_CNS_CTRL:
-			nvmet_passthru_override_id_ctrl(req);
+			status = nvmet_passthru_override_id_ctrl(req);
 			break;
 		case NVME_ID_CNS_NS:
-			nvmet_passthru_override_id_ns(req);
+			status = nvmet_passthru_override_id_ns(req);
 			break;
 		case NVME_ID_CNS_NS_DESC_LIST:
-			nvmet_passthru_override_id_descs(req);
+			status = nvmet_passthru_override_id_descs(req);
 			break;
 		}
 	} else if (status < 0)
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 0af0e965fb57..1e3c3192d122 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -98,10 +98,8 @@ static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
 
 	/* All functions share the same vendor ID with function 0 */
 	if (fn == 0) {
-		u32 vid_regs = (hdr->vendorid & GENMASK(15, 0)) |
-			       (hdr->subsys_vendor_id & GENMASK(31, 16)) << 16;
-
-		rockchip_pcie_write(rockchip, vid_regs,
+		rockchip_pcie_write(rockchip,
+				    hdr->vendorid | hdr->subsys_vendor_id << 16,
 				    PCIE_CORE_CONFIG_VENDOR);
 	}
 
diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index e61bfaf8b5c4..86b95206cb1b 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -11,6 +11,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/container_of.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/capability.h>
@@ -25,11 +26,16 @@ static u32 da_supported_commands;
 static int da_num_tokens;
 static struct platform_device *platform_device;
 static struct calling_interface_token *da_tokens;
-static struct device_attribute *token_location_attrs;
-static struct device_attribute *token_value_attrs;
+static struct token_sysfs_data *token_entries;
 static struct attribute **token_attrs;
 static DEFINE_MUTEX(smbios_mutex);
 
+struct token_sysfs_data {
+	struct device_attribute location_attr;
+	struct device_attribute value_attr;
+	struct calling_interface_token *token;
+};
+
 struct smbios_device {
 	struct list_head list;
 	struct device *device;
@@ -416,47 +422,26 @@ static void __init find_tokens(const struct dmi_header *dm, void *dummy)
 	}
 }
 
-static int match_attribute(struct device *dev,
-			   struct device_attribute *attr)
-{
-	int i;
-
-	for (i = 0; i < da_num_tokens * 2; i++) {
-		if (!token_attrs[i])
-			continue;
-		if (strcmp(token_attrs[i]->name, attr->attr.name) == 0)
-			return i/2;
-	}
-	dev_dbg(dev, "couldn't match: %s\n", attr->attr.name);
-	return -EINVAL;
-}
-
 static ssize_t location_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	int i;
+	struct token_sysfs_data *data = container_of(attr, struct token_sysfs_data, location_attr);
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	i = match_attribute(dev, attr);
-	if (i > 0)
-		return sysfs_emit(buf, "%08x", da_tokens[i].location);
-	return 0;
+	return sysfs_emit(buf, "%08x", data->token->location);
 }
 
 static ssize_t value_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
-	int i;
+	struct token_sysfs_data *data = container_of(attr, struct token_sysfs_data, value_attr);
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	i = match_attribute(dev, attr);
-	if (i > 0)
-		return sysfs_emit(buf, "%08x", da_tokens[i].value);
-	return 0;
+	return sysfs_emit(buf, "%08x", data->token->value);
 }
 
 static struct attribute_group smbios_attribute_group = {
@@ -473,22 +458,15 @@ static int build_tokens_sysfs(struct platform_device *dev)
 {
 	char *location_name;
 	char *value_name;
-	size_t size;
 	int ret;
 	int i, j;
 
-	/* (number of tokens  + 1 for null terminated */
-	size = sizeof(struct device_attribute) * (da_num_tokens + 1);
-	token_location_attrs = kzalloc(size, GFP_KERNEL);
-	if (!token_location_attrs)
+	token_entries = kcalloc(da_num_tokens, sizeof(*token_entries), GFP_KERNEL);
+	if (!token_entries)
 		return -ENOMEM;
-	token_value_attrs = kzalloc(size, GFP_KERNEL);
-	if (!token_value_attrs)
-		goto out_allocate_value;
 
 	/* need to store both location and value + terminator*/
-	size = sizeof(struct attribute *) * ((2 * da_num_tokens) + 1);
-	token_attrs = kzalloc(size, GFP_KERNEL);
+	token_attrs = kcalloc((2 * da_num_tokens) + 1, sizeof(*token_attrs), GFP_KERNEL);
 	if (!token_attrs)
 		goto out_allocate_attrs;
 
@@ -496,27 +474,32 @@ static int build_tokens_sysfs(struct platform_device *dev)
 		/* skip empty */
 		if (da_tokens[i].tokenID == 0)
 			continue;
+
+		token_entries[i].token = &da_tokens[i];
+
 		/* add location */
 		location_name = kasprintf(GFP_KERNEL, "%04x_location",
 					  da_tokens[i].tokenID);
 		if (location_name == NULL)
 			goto out_unwind_strings;
-		sysfs_attr_init(&token_location_attrs[i].attr);
-		token_location_attrs[i].attr.name = location_name;
-		token_location_attrs[i].attr.mode = 0444;
-		token_location_attrs[i].show = location_show;
-		token_attrs[j++] = &token_location_attrs[i].attr;
+
+		sysfs_attr_init(&token_entries[i].location_attr.attr);
+		token_entries[i].location_attr.attr.name = location_name;
+		token_entries[i].location_attr.attr.mode = 0444;
+		token_entries[i].location_attr.show = location_show;
+		token_attrs[j++] = &token_entries[i].location_attr.attr;
 
 		/* add value */
 		value_name = kasprintf(GFP_KERNEL, "%04x_value",
 				       da_tokens[i].tokenID);
 		if (value_name == NULL)
 			goto loop_fail_create_value;
-		sysfs_attr_init(&token_value_attrs[i].attr);
-		token_value_attrs[i].attr.name = value_name;
-		token_value_attrs[i].attr.mode = 0444;
-		token_value_attrs[i].show = value_show;
-		token_attrs[j++] = &token_value_attrs[i].attr;
+
+		sysfs_attr_init(&token_entries[i].value_attr.attr);
+		token_entries[i].value_attr.attr.name = value_name;
+		token_entries[i].value_attr.attr.mode = 0444;
+		token_entries[i].value_attr.show = value_show;
+		token_attrs[j++] = &token_entries[i].value_attr.attr;
 		continue;
 
 loop_fail_create_value:
@@ -532,14 +515,12 @@ static int build_tokens_sysfs(struct platform_device *dev)
 
 out_unwind_strings:
 	while (i--) {
-		kfree(token_location_attrs[i].attr.name);
-		kfree(token_value_attrs[i].attr.name);
+		kfree(token_entries[i].location_attr.attr.name);
+		kfree(token_entries[i].value_attr.attr.name);
 	}
 	kfree(token_attrs);
 out_allocate_attrs:
-	kfree(token_value_attrs);
-out_allocate_value:
-	kfree(token_location_attrs);
+	kfree(token_entries);
 
 	return -ENOMEM;
 }
@@ -551,12 +532,11 @@ static void free_group(struct platform_device *pdev)
 	sysfs_remove_group(&pdev->dev.kobj,
 				&smbios_attribute_group);
 	for (i = 0; i < da_num_tokens; i++) {
-		kfree(token_location_attrs[i].attr.name);
-		kfree(token_value_attrs[i].attr.name);
+		kfree(token_entries[i].location_attr.attr.name);
+		kfree(token_entries[i].value_attr.attr.name);
 	}
 	kfree(token_attrs);
-	kfree(token_value_attrs);
-	kfree(token_location_attrs);
+	kfree(token_entries);
 }
 
 static int __init dell_smbios_init(void)
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 9311f3d09c8f..8eb902fe73a9 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -84,7 +84,8 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 	}
 
 	if (info->verify(info, pin, func, chan)) {
-		pr_err("driver cannot use function %u on pin %u\n", func, chan);
+		pr_err("driver cannot use function %u and channel %u on pin %u\n",
+		       func, chan, pin);
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 0481926c6975..4919407d422d 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -98,12 +98,14 @@ struct k3_r5_soc_data {
  * @dev: cached device pointer
  * @mode: Mode to configure the Cluster - Split or LockStep
  * @cores: list of R5 cores within the cluster
+ * @core_transition: wait queue to sync core state changes
  * @soc_data: SoC-specific feature data for a R5FSS
  */
 struct k3_r5_cluster {
 	struct device *dev;
 	enum cluster_mode mode;
 	struct list_head cores;
+	wait_queue_head_t core_transition;
 	const struct k3_r5_soc_data *soc_data;
 };
 
@@ -123,6 +125,7 @@ struct k3_r5_cluster {
  * @atcm_enable: flag to control ATCM enablement
  * @btcm_enable: flag to control BTCM enablement
  * @loczrama: flag to dictate which TCM is at device address 0x0
+ * @released_from_reset: flag to signal when core is out of reset
  */
 struct k3_r5_core {
 	struct list_head elem;
@@ -139,6 +142,7 @@ struct k3_r5_core {
 	u32 atcm_enable;
 	u32 btcm_enable;
 	u32 loczrama;
+	bool released_from_reset;
 };
 
 /**
@@ -455,6 +459,8 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
 			ret);
 		return ret;
 	}
+	core->released_from_reset = true;
+	wake_up_interruptible(&cluster->core_transition);
 
 	/*
 	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
@@ -537,7 +543,7 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 	struct k3_r5_rproc *kproc = rproc->priv;
 	struct k3_r5_cluster *cluster = kproc->cluster;
 	struct device *dev = kproc->dev;
-	struct k3_r5_core *core;
+	struct k3_r5_core *core0, *core;
 	u32 boot_addr;
 	int ret;
 
@@ -563,6 +569,16 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 				goto unroll_core_run;
 		}
 	} else {
+		/* do not allow core 1 to start before core 0 */
+		core0 = list_first_entry(&cluster->cores, struct k3_r5_core,
+					 elem);
+		if (core != core0 && core0->rproc->state == RPROC_OFFLINE) {
+			dev_err(dev, "%s: can not start core 1 before core 0\n",
+				__func__);
+			ret = -EPERM;
+			goto put_mbox;
+		}
+
 		ret = k3_r5_core_run(core);
 		if (ret)
 			goto put_mbox;
@@ -608,7 +624,8 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
 {
 	struct k3_r5_rproc *kproc = rproc->priv;
 	struct k3_r5_cluster *cluster = kproc->cluster;
-	struct k3_r5_core *core = kproc->core;
+	struct device *dev = kproc->dev;
+	struct k3_r5_core *core1, *core = kproc->core;
 	int ret;
 
 	/* halt all applicable cores */
@@ -621,6 +638,16 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
 			}
 		}
 	} else {
+		/* do not allow core 0 to stop before core 1 */
+		core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
+					elem);
+		if (core != core1 && core1->rproc->state != RPROC_OFFLINE) {
+			dev_err(dev, "%s: can not stop core 0 before core 1\n",
+				__func__);
+			ret = -EPERM;
+			goto out;
+		}
+
 		ret = k3_r5_core_halt(core);
 		if (ret)
 			goto out;
@@ -1137,6 +1164,12 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
 		return ret;
 	}
 
+	/*
+	 * Skip the waiting mechanism for sequential power-on of cores if the
+	 * core has already been booted by another entity.
+	 */
+	core->released_from_reset = c_state;
+
 	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl,
 				     &stat);
 	if (ret < 0) {
@@ -1273,6 +1306,26 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 		if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
 		    cluster->mode == CLUSTER_MODE_SINGLECPU)
 			break;
+
+		/*
+		 * R5 cores require to be powered on sequentially, core0
+		 * should be in higher power state than core1 in a cluster
+		 * So, wait for current core to power up before proceeding
+		 * to next core and put timeout of 2sec for each core.
+		 *
+		 * This waiting mechanism is necessary because
+		 * rproc_auto_boot_callback() for core1 can be called before
+		 * core0 due to thread execution order.
+		 */
+		ret = wait_event_interruptible_timeout(cluster->core_transition,
+						       core->released_from_reset,
+						       msecs_to_jiffies(2000));
+		if (ret <= 0) {
+			dev_err(dev,
+				"Timed out waiting for %s core to power up!\n",
+				rproc->name);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -1708,6 +1761,7 @@ static int k3_r5_probe(struct platform_device *pdev)
 				CLUSTER_MODE_SPLIT : CLUSTER_MODE_LOCKSTEP;
 	cluster->soc_data = data;
 	INIT_LIST_HEAD(&cluster->cores);
+	init_waitqueue_head(&cluster->core_transition);
 
 	ret = of_property_read_u32(np, "ti,cluster-mode", &cluster->mode);
 	if (ret < 0 && ret != -EINVAL) {
diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 42600e5c457a..c77803bd9b00 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -1851,10 +1851,72 @@ persistent_id_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(persistent_id);
 
+/**
+ * sas_ncq_prio_supported_show - Indicate if device supports NCQ priority
+ * @dev: pointer to embedded device
+ * @attr: sas_ncq_prio_supported attribute descriptor
+ * @buf: the buffer returned
+ *
+ * A sysfs 'read-only' sdev attribute, only works with SATA devices
+ */
+static ssize_t
+sas_ncq_prio_supported_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+
+	return sysfs_emit(buf, "%d\n", sas_ata_ncq_prio_supported(sdev));
+}
+static DEVICE_ATTR_RO(sas_ncq_prio_supported);
+
+/**
+ * sas_ncq_prio_enable_show - send prioritized io commands to device
+ * @dev: pointer to embedded device
+ * @attr: sas_ncq_prio_enable attribute descriptor
+ * @buf: the buffer returned
+ *
+ * A sysfs 'read/write' sdev attribute, only works with SATA devices
+ */
+static ssize_t
+sas_ncq_prio_enable_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct mpi3mr_sdev_priv_data *sdev_priv_data =  sdev->hostdata;
+
+	if (!sdev_priv_data)
+		return 0;
+
+	return sysfs_emit(buf, "%d\n", sdev_priv_data->ncq_prio_enable);
+}
+
+static ssize_t
+sas_ncq_prio_enable_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct mpi3mr_sdev_priv_data *sdev_priv_data =  sdev->hostdata;
+	bool ncq_prio_enable = 0;
+
+	if (kstrtobool(buf, &ncq_prio_enable))
+		return -EINVAL;
+
+	if (!sas_ata_ncq_prio_supported(sdev))
+		return -EINVAL;
+
+	sdev_priv_data->ncq_prio_enable = ncq_prio_enable;
+
+	return strlen(buf);
+}
+static DEVICE_ATTR_RW(sas_ncq_prio_enable);
+
 static struct attribute *mpi3mr_dev_attrs[] = {
 	&dev_attr_sas_address.attr,
 	&dev_attr_device_handle.attr,
 	&dev_attr_persistent_id.attr,
+	&dev_attr_sas_ncq_prio_supported.attr,
+	&dev_attr_sas_ncq_prio_enable.attr,
 	NULL,
 };
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 8e6ac08e553b..421a03dbbeb7 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -8497,6 +8497,12 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 	ioc->pd_handles_sz = (ioc->facts.MaxDevHandle / 8);
 	if (ioc->facts.MaxDevHandle % 8)
 		ioc->pd_handles_sz++;
+	/*
+	 * pd_handles_sz should have, at least, the minimal room for
+	 * set_bit()/test_bit(), otherwise out-of-memory touch may occur.
+	 */
+	ioc->pd_handles_sz = ALIGN(ioc->pd_handles_sz, sizeof(unsigned long));
+
 	ioc->pd_handles = kzalloc(ioc->pd_handles_sz,
 	    GFP_KERNEL);
 	if (!ioc->pd_handles) {
@@ -8514,6 +8520,13 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 	ioc->pend_os_device_add_sz = (ioc->facts.MaxDevHandle / 8);
 	if (ioc->facts.MaxDevHandle % 8)
 		ioc->pend_os_device_add_sz++;
+
+	/*
+	 * pend_os_device_add_sz should have, at least, the minimal room for
+	 * set_bit()/test_bit(), otherwise out-of-memory may occur.
+	 */
+	ioc->pend_os_device_add_sz = ALIGN(ioc->pend_os_device_add_sz,
+					   sizeof(unsigned long));
 	ioc->pend_os_device_add = kzalloc(ioc->pend_os_device_add_sz,
 	    GFP_KERNEL);
 	if (!ioc->pend_os_device_add) {
@@ -8805,6 +8818,12 @@ _base_check_ioc_facts_changes(struct MPT3SAS_ADAPTER *ioc)
 		if (ioc->facts.MaxDevHandle % 8)
 			pd_handles_sz++;
 
+		/*
+		 * pd_handles should have, at least, the minimal room for
+		 * set_bit()/test_bit(), otherwise out-of-memory touch may
+		 * occur.
+		 */
+		pd_handles_sz = ALIGN(pd_handles_sz, sizeof(unsigned long));
 		pd_handles = krealloc(ioc->pd_handles, pd_handles_sz,
 		    GFP_KERNEL);
 		if (!pd_handles) {
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 10055c7e4a9f..eb00c091e29e 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -2045,9 +2045,6 @@ void
 mpt3sas_setup_direct_io(struct MPT3SAS_ADAPTER *ioc, struct scsi_cmnd *scmd,
 	struct _raid_device *raid_device, Mpi25SCSIIORequest_t *mpi_request);
 
-/* NCQ Prio Handling Check */
-bool scsih_ncq_prio_supp(struct scsi_device *sdev);
-
 void mpt3sas_setup_debugfs(struct MPT3SAS_ADAPTER *ioc);
 void mpt3sas_destroy_debugfs(struct MPT3SAS_ADAPTER *ioc);
 void mpt3sas_init_debugfs(void);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 0d8b1e942ded..fc5af6a5114e 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -4034,7 +4034,7 @@ sas_ncq_prio_supported_show(struct device *dev,
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 
-	return sysfs_emit(buf, "%d\n", scsih_ncq_prio_supp(sdev));
+	return sysfs_emit(buf, "%d\n", sas_ata_ncq_prio_supported(sdev));
 }
 static DEVICE_ATTR_RO(sas_ncq_prio_supported);
 
@@ -4069,7 +4069,7 @@ sas_ncq_prio_enable_store(struct device *dev,
 	if (kstrtobool(buf, &ncq_prio_enable))
 		return -EINVAL;
 
-	if (!scsih_ncq_prio_supp(sdev))
+	if (!sas_ata_ncq_prio_supported(sdev))
 		return -EINVAL;
 
 	sas_device_priv_data->ncq_prio_enable = ncq_prio_enable;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 2ea3bdc63817..31768da482a5 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -12591,29 +12591,6 @@ scsih_pci_mmio_enabled(struct pci_dev *pdev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-/**
- * scsih_ncq_prio_supp - Check for NCQ command priority support
- * @sdev: scsi device struct
- *
- * This is called when a user indicates they would like to enable
- * ncq command priorities. This works only on SATA devices.
- */
-bool scsih_ncq_prio_supp(struct scsi_device *sdev)
-{
-	struct scsi_vpd *vpd;
-	bool ncq_prio_supp = false;
-
-	rcu_read_lock();
-	vpd = rcu_dereference(sdev->vpd_pg89);
-	if (!vpd || vpd->len < 214)
-		goto out;
-
-	ncq_prio_supp = (vpd->data[213] >> 4) & 1;
-out:
-	rcu_read_unlock();
-
-	return ncq_prio_supp;
-}
 /*
  * The pci device ids are defined in mpi/mpi2_cnfg.h.
  */
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 74b99f2b0b74..6941d8cfb9ba 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -416,6 +416,29 @@ unsigned int sas_is_tlr_enabled(struct scsi_device *sdev)
 }
 EXPORT_SYMBOL_GPL(sas_is_tlr_enabled);
 
+/**
+ * sas_ata_ncq_prio_supported - Check for ATA NCQ command priority support
+ * @sdev: SCSI device
+ *
+ * Check if an ATA device supports NCQ priority using VPD page 89h (ATA
+ * Information). Since this VPD page is implemented only for ATA devices,
+ * this function always returns false for SCSI devices.
+ */
+bool sas_ata_ncq_prio_supported(struct scsi_device *sdev)
+{
+	struct scsi_vpd *vpd;
+	bool ncq_prio_supported = false;
+
+	rcu_read_lock();
+	vpd = rcu_dereference(sdev->vpd_pg89);
+	if (vpd && vpd->len >= 214)
+		ncq_prio_supported = (vpd->data[213] >> 4) & 1;
+	rcu_read_unlock();
+
+	return ncq_prio_supported;
+}
+EXPORT_SYMBOL_GPL(sas_ata_ncq_prio_supported);
+
 /*
  * SAS Phy attributes
  */
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 3ec9b324fdcf..10df4ee01b3f 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3288,16 +3288,23 @@ static bool sd_validate_opt_xfer_size(struct scsi_disk *sdkp,
 
 static void sd_read_block_zero(struct scsi_disk *sdkp)
 {
-	unsigned int buf_len = sdkp->device->sector_size;
-	char *buffer, cmd[10] = { };
+	struct scsi_device *sdev = sdkp->device;
+	unsigned int buf_len = sdev->sector_size;
+	u8 *buffer, cmd[16] = { };
 
 	buffer = kmalloc(buf_len, GFP_KERNEL);
 	if (!buffer)
 		return;
 
-	cmd[0] = READ_10;
-	put_unaligned_be32(0, &cmd[2]); /* Logical block address 0 */
-	put_unaligned_be16(1, &cmd[7]);	/* Transfer 1 logical block */
+	if (sdev->use_16_for_rw) {
+		cmd[0] = READ_16;
+		put_unaligned_be64(0, &cmd[2]); /* Logical block address 0 */
+		put_unaligned_be32(1, &cmd[10]);/* Transfer 1 logical block */
+	} else {
+		cmd[0] = READ_10;
+		put_unaligned_be32(0, &cmd[2]); /* Logical block address 0 */
+		put_unaligned_be16(1, &cmd[7]);	/* Transfer 1 logical block */
+	}
 
 	scsi_execute_req(sdkp->device, cmd, DMA_FROM_DEVICE, buffer, buf_len,
 			 NULL, SD_TIMEOUT, sdkp->max_retries, NULL);
diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index 5bd23262abd6..6f065159f3de 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -303,7 +303,6 @@ static int spmi_controller_probe(struct platform_device *pdev)
 
 	spin_lock_init(&spmi_controller->lock);
 
-	ctrl->nr = spmi_controller->channel;
 	ctrl->dev.parent = pdev->dev.parent;
 	ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
 
diff --git a/drivers/thunderbolt/debugfs.c b/drivers/thunderbolt/debugfs.c
index f691bce5c147..cbaaa9f776e5 100644
--- a/drivers/thunderbolt/debugfs.c
+++ b/drivers/thunderbolt/debugfs.c
@@ -927,8 +927,9 @@ static void margining_port_init(struct tb_port *port)
 	debugfs_create_file("run", 0600, dir, port, &margining_run_fops);
 	debugfs_create_file("results", 0600, dir, port, &margining_results_fops);
 	debugfs_create_file("test", 0600, dir, port, &margining_test_fops);
-	if (independent_voltage_margins(usb4) ||
-	    (supports_time(usb4) && independent_time_margins(usb4)))
+	if (independent_voltage_margins(usb4) == USB4_MARGIN_CAP_0_VOLTAGE_HL ||
+	    (supports_time(usb4) &&
+	     independent_time_margins(usb4) == USB4_MARGIN_CAP_1_TIME_LR))
 		debugfs_create_file("margin", 0600, dir, port, &margining_margin_fops);
 }
 
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 4dff2f34e2d0..3600cac105fa 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1602,15 +1602,25 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	else if (ldata->raw || (L_EXTPROC(tty) && !preops))
 		n_tty_receive_buf_raw(tty, cp, fp, count);
 	else if (tty->closing && !L_EXTPROC(tty)) {
-		if (la_count > 0)
+		if (la_count > 0) {
 			n_tty_receive_buf_closing(tty, cp, fp, la_count, true);
-		if (count > la_count)
-			n_tty_receive_buf_closing(tty, cp, fp, count - la_count, false);
+			cp += la_count;
+			if (fp)
+				fp += la_count;
+			count -= la_count;
+		}
+		if (count > 0)
+			n_tty_receive_buf_closing(tty, cp, fp, count, false);
 	} else {
-		if (la_count > 0)
+		if (la_count > 0) {
 			n_tty_receive_buf_standard(tty, cp, fp, la_count, true);
-		if (count > la_count)
-			n_tty_receive_buf_standard(tty, cp, fp, count - la_count, false);
+			cp += la_count;
+			if (fp)
+				fp += la_count;
+			count -= la_count;
+		}
+		if (count > 0)
+			n_tty_receive_buf_standard(tty, cp, fp, count, false);
 
 		flush_echoes(tty);
 		if (tty->ops->flush_chars)
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 88035100b86c..a1f2259cc9a9 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -523,7 +523,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!regs)
 		return dev_err_probe(dev, -EINVAL, "no registers defined\n");
 
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
+	/* no interrupt -> fall back to polling */
+	if (irq == -ENXIO)
+		irq = 0;
 	if (irq < 0)
 		return irq;
 
diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 795e55142d4c..70a56062f791 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -124,6 +124,7 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	uart.port.regshift = 2;
 	uart.port.irq = irq;
 	uart.port.fifosize = 64;
+	uart.tx_loadsz = 32;
 	uart.port.flags = UPF_IOREMAP | UPF_SKIP_TEST | UPF_FIXED_TYPE;
 	uart.port.dev = &pdev->dev;
 	uart.port.uartclk = clk_get_rate(data->clk);
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index e6eedebf6776..a723df9b37dd 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -482,16 +482,28 @@ static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
 	return reg == SC16IS7XX_RHR_REG;
 }
 
+/*
+ * Configure programmable baud rate generator (divisor) according to the
+ * desired baud rate.
+ *
+ * From the datasheet, the divisor is computed according to:
+ *
+ *              XTAL1 input frequency
+ *             -----------------------
+ *                    prescaler
+ * divisor = ---------------------------
+ *            baud-rate x sampling-rate
+ */
 static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	u8 lcr;
-	u8 prescaler = 0;
+	unsigned int prescaler = 1;
 	unsigned long clk = port->uartclk, div = clk / 16 / baud;
 
-	if (div > 0xffff) {
-		prescaler = SC16IS7XX_MCR_CLKSEL_BIT;
-		div /= 4;
+	if (div >= BIT(16)) {
+		prescaler = 4;
+		div /= prescaler;
 	}
 
 	/* In an amazing feat of design, the Enhanced Features Register shares
@@ -528,9 +540,10 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 
 	mutex_unlock(&one->efr_lock);
 
+	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_CLKSEL_BIT,
-			      prescaler);
+			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
 
 	/* Open the LCR divisors for configuration */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
@@ -545,7 +558,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	/* Put LCR back to the normal mode */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	return DIV_ROUND_CLOSEST(clk / 16, div);
+	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
 }
 
 static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 643edf5fe18c..80699e540caa 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_USB_R8A66597_HCD)	+= host/
 obj-$(CONFIG_USB_FSL_USB2)	+= host/
 obj-$(CONFIG_USB_FOTG210_HCD)	+= host/
 obj-$(CONFIG_USB_MAX3421_HCD)	+= host/
+obj-$(CONFIG_USB_XEN_HCD)	+= host/
 
 obj-$(CONFIG_USB_C67X00_HCD)	+= c67x00/
 
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 1f0951be15ab..eb0f5d7cc756 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -266,14 +266,14 @@ static void wdm_int_callback(struct urb *urb)
 			dev_err(&desc->intf->dev, "Stall on int endpoint\n");
 			goto sw; /* halt is cleared in work */
 		default:
-			dev_err(&desc->intf->dev,
+			dev_err_ratelimited(&desc->intf->dev,
 				"nonzero urb status received: %d\n", status);
 			break;
 		}
 	}
 
 	if (urb->actual_length < sizeof(struct usb_cdc_notification)) {
-		dev_err(&desc->intf->dev, "wdm_int_callback - %d bytes\n",
+		dev_err_ratelimited(&desc->intf->dev, "wdm_int_callback - %d bytes\n",
 			urb->actual_length);
 		goto exit;
 	}
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index b2da74bb107a..698bf24ba44c 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -830,9 +830,9 @@ static void ffs_user_copy_worker(struct work_struct *work)
 {
 	struct ffs_io_data *io_data = container_of(work, struct ffs_io_data,
 						   work);
-	int ret = io_data->req->status ? io_data->req->status :
-					 io_data->req->actual;
+	int ret = io_data->status;
 	bool kiocb_has_eventfd = io_data->kiocb->ki_flags & IOCB_EVENTFD;
+	unsigned long flags;
 
 	if (io_data->read && ret > 0) {
 		kthread_use_mm(io_data->mm);
@@ -845,7 +845,10 @@ static void ffs_user_copy_worker(struct work_struct *work)
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
 		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
 
+	spin_lock_irqsave(&io_data->ffs->eps_lock, flags);
 	usb_ep_free_request(io_data->ep, io_data->req);
+	io_data->req = NULL;
+	spin_unlock_irqrestore(&io_data->ffs->eps_lock, flags);
 
 	if (io_data->read)
 		kfree(io_data->to_free);
@@ -861,6 +864,8 @@ static void ffs_epfile_async_io_complete(struct usb_ep *_ep,
 
 	ENTER();
 
+	io_data->status = req->status ? req->status : req->actual;
+
 	INIT_WORK(&io_data->work, ffs_user_copy_worker);
 	queue_work(ffs->io_completion_wq, &io_data->work);
 }
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index e02ef31da68e..f3a3a02ff820 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -36,6 +36,7 @@
 
 #define PCI_VENDOR_ID_ETRON		0x1b6f
 #define PCI_DEVICE_ID_EJ168		0x7023
+#define PCI_DEVICE_ID_EJ188		0x7052
 
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
@@ -275,6 +276,12 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
+	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
+			pdev->device == PCI_DEVICE_ID_EJ188) {
+		xhci->quirks |= XHCI_RESET_ON_RESUME;
+		xhci->quirks |= XHCI_BROKEN_STREAMS;
+	}
+
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0014) {
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4a039e42694b..7549c430c4f0 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -987,13 +987,27 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 				break;
 			case TD_DIRTY: /* TD is cached, clear it */
 			case TD_HALTED:
+			case TD_CLEARING_CACHE_DEFERRED:
+				if (cached_td) {
+					if (cached_td->urb->stream_id != td->urb->stream_id) {
+						/* Multiple streams case, defer move dq */
+						xhci_dbg(xhci,
+							 "Move dq deferred: stream %u URB %p\n",
+							 td->urb->stream_id, td->urb);
+						td->cancel_status = TD_CLEARING_CACHE_DEFERRED;
+						break;
+					}
+
+					/* Should never happen, but clear the TD if it does */
+					xhci_warn(xhci,
+						  "Found multiple active URBs %p and %p in stream %u?\n",
+						  td->urb, cached_td->urb,
+						  td->urb->stream_id);
+					td_to_noop(xhci, ring, cached_td, false);
+					cached_td->cancel_status = TD_CLEARED;
+				}
+
 				td->cancel_status = TD_CLEARING_CACHE;
-				if (cached_td)
-					/* FIXME  stream case, several stopped rings */
-					xhci_dbg(xhci,
-						 "Move dq past stream %u URB %p instead of stream %u URB %p\n",
-						 td->urb->stream_id, td->urb,
-						 cached_td->urb->stream_id, cached_td->urb);
 				cached_td = td;
 				break;
 			}
@@ -1013,10 +1027,16 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 	if (err) {
 		/* Failed to move past cached td, just set cached TDs to no-op */
 		list_for_each_entry_safe(td, tmp_td, &ep->cancelled_td_list, cancelled_td_list) {
-			if (td->cancel_status != TD_CLEARING_CACHE)
+			/*
+			 * Deferred TDs need to have the deq pointer set after the above command
+			 * completes, so if that failed we just give up on all of them (and
+			 * complain loudly since this could cause issues due to caching).
+			 */
+			if (td->cancel_status != TD_CLEARING_CACHE &&
+			    td->cancel_status != TD_CLEARING_CACHE_DEFERRED)
 				continue;
-			xhci_dbg(xhci, "Failed to clear cancelled cached URB %p, mark clear anyway\n",
-				 td->urb);
+			xhci_warn(xhci, "Failed to clear cancelled cached URB %p, mark clear anyway\n",
+				  td->urb);
 			td_to_noop(xhci, ring, td, false);
 			td->cancel_status = TD_CLEARED;
 		}
@@ -1304,6 +1324,7 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 	struct xhci_ep_ctx *ep_ctx;
 	struct xhci_slot_ctx *slot_ctx;
 	struct xhci_td *td, *tmp_td;
+	bool deferred = false;
 
 	ep_index = TRB_TO_EP_INDEX(le32_to_cpu(trb->generic.field[3]));
 	stream_id = TRB_TO_STREAM_ID(le32_to_cpu(trb->generic.field[2]));
@@ -1390,6 +1411,8 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 			xhci_dbg(ep->xhci, "%s: Giveback cancelled URB %p TD\n",
 				 __func__, td->urb);
 			xhci_td_cleanup(ep->xhci, td, ep_ring, td->status);
+		} else if (td->cancel_status == TD_CLEARING_CACHE_DEFERRED) {
+			deferred = true;
 		} else {
 			xhci_dbg(ep->xhci, "%s: Keep cancelled URB %p TD as cancel_status is %d\n",
 				 __func__, td->urb, td->cancel_status);
@@ -1399,8 +1422,17 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 	ep->ep_state &= ~SET_DEQ_PENDING;
 	ep->queued_deq_seg = NULL;
 	ep->queued_deq_ptr = NULL;
-	/* Restart any rings with pending URBs */
-	ring_doorbell_for_active_rings(xhci, slot_id, ep_index);
+
+	if (deferred) {
+		/* We have more streams to clear */
+		xhci_dbg(ep->xhci, "%s: Pending TDs to clear, continuing with invalidation\n",
+			 __func__);
+		xhci_invalidate_cancelled_tds(ep);
+	} else {
+		/* Restart any rings with pending URBs */
+		xhci_dbg(ep->xhci, "%s: All TDs cleared, ring doorbell\n", __func__);
+		ring_doorbell_for_active_rings(xhci, slot_id, ep_index);
+	}
 }
 
 static void xhci_handle_cmd_reset_ep(struct xhci_hcd *xhci, int slot_id,
@@ -2506,9 +2538,8 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		goto finish_td;
 	case COMP_STOPPED_LENGTH_INVALID:
 		/* stopped on ep trb with invalid length, exclude it */
-		ep_trb_len	= 0;
-		remaining	= 0;
-		break;
+		td->urb->actual_length = sum_trb_lengths(xhci, ep_ring, ep_trb);
+		goto finish_td;
 	case COMP_USB_TRANSACTION_ERROR:
 		if (xhci->quirks & XHCI_NO_SOFT_RETRY ||
 		    (ep->err_count++ > MAX_SOFT_RETRY) ||
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index fa9e87141e0b..c42058bfcd16 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1556,6 +1556,7 @@ enum xhci_cancelled_td_status {
 	TD_DIRTY = 0,
 	TD_HALTED,
 	TD_CLEARING_CACHE,
+	TD_CLEARING_CACHE_DEFERRED,
 	TD_CLEARED,
 };
 
diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 115f05a6201a..40d34cc28344 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -105,6 +105,8 @@ struct alauda_info {
 	unsigned char sense_key;
 	unsigned long sense_asc;	/* additional sense code */
 	unsigned long sense_ascq;	/* additional sense code qualifier */
+
+	bool media_initialized;
 };
 
 #define short_pack(lsb,msb) ( ((u16)(lsb)) | ( ((u16)(msb))<<8 ) )
@@ -476,11 +478,12 @@ static int alauda_check_media(struct us_data *us)
 	}
 
 	/* Check for media change */
-	if (status[0] & 0x08) {
+	if (status[0] & 0x08 || !info->media_initialized) {
 		usb_stor_dbg(us, "Media change detected\n");
 		alauda_free_maps(&MEDIA_INFO(us));
-		alauda_init_media(us);
-
+		rc = alauda_init_media(us);
+		if (rc == USB_STOR_TRANSPORT_GOOD)
+			info->media_initialized = true;
 		info->sense_key = UNIT_ATTENTION;
 		info->sense_asc = 0x28;
 		info->sense_ascq = 0x00;
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index bbcc0e0aa070..bb77f646366a 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2430,8 +2430,10 @@ static int tcpm_register_sink_caps(struct tcpm_port *port)
 	memcpy(caps.pdo, port->sink_caps, sizeof(u32) * port->nr_sink_caps);
 	caps.role = TYPEC_SINK;
 
-	if (cap)
+	if (cap) {
 		usb_power_delivery_unregister_capabilities(cap);
+		port->partner_source_caps = NULL;
+	}
 
 	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
 	if (IS_ERR(cap))
@@ -5446,6 +5448,7 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *port)
 		port->tcpc->set_bist_data(port->tcpc, false);
 
 	switch (port->state) {
+	case TOGGLING:
 	case ERROR_RECOVERY:
 	case PORT_RESET:
 	case PORT_RESET_WAIT_OFF:
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5756edb37c61..c17232659942 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -51,15 +51,6 @@
 				 BTRFS_SUPER_FLAG_METADUMP |\
 				 BTRFS_SUPER_FLAG_METADUMP_V2)
 
-static void btrfs_destroy_ordered_extents(struct btrfs_root *root);
-static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
-				      struct btrfs_fs_info *fs_info);
-static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root);
-static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
-					struct extent_io_tree *dirty_pages,
-					int mark);
-static int btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
-				       struct extent_io_tree *pinned_extents);
 static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info);
 static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info);
 
@@ -4948,23 +4939,14 @@ static void btrfs_destroy_all_ordered_extents(struct btrfs_fs_info *fs_info)
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
 }
 
-static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
-				      struct btrfs_fs_info *fs_info)
+static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
+				       struct btrfs_fs_info *fs_info)
 {
 	struct rb_node *node;
-	struct btrfs_delayed_ref_root *delayed_refs;
+	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
-	int ret = 0;
-
-	delayed_refs = &trans->delayed_refs;
 
 	spin_lock(&delayed_refs->lock);
-	if (atomic_read(&delayed_refs->num_entries) == 0) {
-		spin_unlock(&delayed_refs->lock);
-		btrfs_debug(fs_info, "delayed_refs has NO entry");
-		return ret;
-	}
-
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
 		struct btrfs_delayed_ref_head *head;
 		struct rb_node *n;
@@ -5024,8 +5006,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	btrfs_qgroup_destroy_extent_records(trans);
 
 	spin_unlock(&delayed_refs->lock);
-
-	return ret;
 }
 
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 56d7580fdc3c..3518e638374e 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -867,7 +867,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 					split->block_len = em->block_len;
 					split->orig_start = em->orig_start;
 				} else {
-					const u64 diff = start + len - em->start;
+					const u64 diff = end - em->start;
 
 					split->block_len = split->len;
 					split->block_start += diff;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 99cb690da989..2c42e85a3e26 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1270,21 +1270,175 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 	return ret;
 }
 
+struct zone_info {
+	u64 physical;
+	u64 capacity;
+	u64 alloc_offset;
+};
+
+static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
+				struct zone_info *info, unsigned long *active,
+				struct map_lookup *map)
+{
+	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+	struct btrfs_device *device;
+	int dev_replace_is_ongoing = 0;
+	unsigned int nofs_flag;
+	struct blk_zone zone;
+	int ret;
+
+	info->physical = map->stripes[zone_idx].physical;
+
+	down_read(&dev_replace->rwsem);
+	device = map->stripes[zone_idx].dev;
+
+	if (!device->bdev) {
+		up_read(&dev_replace->rwsem);
+		info->alloc_offset = WP_MISSING_DEV;
+		return 0;
+	}
+
+	/* Consider a zone as active if we can allow any number of active zones. */
+	if (!device->zone_info->max_active_zones)
+		__set_bit(zone_idx, active);
+
+	if (!btrfs_dev_is_sequential(device, info->physical)) {
+		up_read(&dev_replace->rwsem);
+		info->alloc_offset = WP_CONVENTIONAL;
+		return 0;
+	}
+
+	/* This zone will be used for allocation, so mark this zone non-empty. */
+	btrfs_dev_clear_zone_empty(device, info->physical);
+
+	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
+	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL)
+		btrfs_dev_clear_zone_empty(dev_replace->tgtdev, info->physical);
+
+	/*
+	 * The group is mapped to a sequential zone. Get the zone write pointer
+	 * to determine the allocation offset within the zone.
+	 */
+	WARN_ON(!IS_ALIGNED(info->physical, fs_info->zone_size));
+	nofs_flag = memalloc_nofs_save();
+	ret = btrfs_get_dev_zone(device, info->physical, &zone);
+	memalloc_nofs_restore(nofs_flag);
+	if (ret) {
+		up_read(&dev_replace->rwsem);
+		if (ret != -EIO && ret != -EOPNOTSUPP)
+			return ret;
+		info->alloc_offset = WP_MISSING_DEV;
+		return 0;
+	}
+
+	if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		btrfs_err_in_rcu(fs_info,
+		"zoned: unexpected conventional zone %llu on device %s (devid %llu)",
+			zone.start << SECTOR_SHIFT, rcu_str_deref(device->name),
+			device->devid);
+		up_read(&dev_replace->rwsem);
+		return -EIO;
+	}
+
+	info->capacity = (zone.capacity << SECTOR_SHIFT);
+
+	switch (zone.cond) {
+	case BLK_ZONE_COND_OFFLINE:
+	case BLK_ZONE_COND_READONLY:
+		btrfs_err(fs_info,
+		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
+			  (info->physical >> device->zone_info->zone_size_shift),
+			  rcu_str_deref(device->name), device->devid);
+		info->alloc_offset = WP_MISSING_DEV;
+		break;
+	case BLK_ZONE_COND_EMPTY:
+		info->alloc_offset = 0;
+		break;
+	case BLK_ZONE_COND_FULL:
+		info->alloc_offset = info->capacity;
+		break;
+	default:
+		/* Partially used zone. */
+		info->alloc_offset = ((zone.wp - zone.start) << SECTOR_SHIFT);
+		__set_bit(zone_idx, active);
+		break;
+	}
+
+	up_read(&dev_replace->rwsem);
+
+	return 0;
+}
+
+static int btrfs_load_block_group_single(struct btrfs_block_group *bg,
+					 struct zone_info *info,
+					 unsigned long *active)
+{
+	if (info->alloc_offset == WP_MISSING_DEV) {
+		btrfs_err(bg->fs_info,
+			"zoned: cannot recover write pointer for zone %llu",
+			info->physical);
+		return -EIO;
+	}
+
+	bg->alloc_offset = info->alloc_offset;
+	bg->zone_capacity = info->capacity;
+	if (test_bit(0, active))
+		set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &bg->runtime_flags);
+	return 0;
+}
+
+static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
+				      struct map_lookup *map,
+				      struct zone_info *zone_info,
+				      unsigned long *active)
+{
+	if (map->type & BTRFS_BLOCK_GROUP_DATA) {
+		btrfs_err(bg->fs_info,
+			  "zoned: profile DUP not yet supported on data bg");
+		return -EINVAL;
+	}
+
+	if (zone_info[0].alloc_offset == WP_MISSING_DEV) {
+		btrfs_err(bg->fs_info,
+			  "zoned: cannot recover write pointer for zone %llu",
+			  zone_info[0].physical);
+		return -EIO;
+	}
+	if (zone_info[1].alloc_offset == WP_MISSING_DEV) {
+		btrfs_err(bg->fs_info,
+			  "zoned: cannot recover write pointer for zone %llu",
+			  zone_info[1].physical);
+		return -EIO;
+	}
+	if (zone_info[0].alloc_offset != zone_info[1].alloc_offset) {
+		btrfs_err(bg->fs_info,
+			  "zoned: write pointer offset mismatch of zones in DUP profile");
+		return -EIO;
+	}
+
+	if (test_bit(0, active) != test_bit(1, active)) {
+		if (!btrfs_zone_activate(bg))
+			return -EIO;
+	} else if (test_bit(0, active)) {
+		set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &bg->runtime_flags);
+	}
+
+	bg->alloc_offset = zone_info[0].alloc_offset;
+	bg->zone_capacity = min(zone_info[0].capacity, zone_info[1].capacity);
+	return 0;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
 	struct extent_map *em;
 	struct map_lookup *map;
-	struct btrfs_device *device;
 	u64 logical = cache->start;
 	u64 length = cache->length;
+	struct zone_info *zone_info = NULL;
 	int ret;
 	int i;
-	unsigned int nofs_flag;
-	u64 *alloc_offsets = NULL;
-	u64 *caps = NULL;
-	u64 *physical = NULL;
 	unsigned long *active = NULL;
 	u64 last_alloc = 0;
 	u32 num_sequential = 0, num_conventional = 0;
@@ -1316,20 +1470,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		goto out;
 	}
 
-	alloc_offsets = kcalloc(map->num_stripes, sizeof(*alloc_offsets), GFP_NOFS);
-	if (!alloc_offsets) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	caps = kcalloc(map->num_stripes, sizeof(*caps), GFP_NOFS);
-	if (!caps) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	physical = kcalloc(map->num_stripes, sizeof(*physical), GFP_NOFS);
-	if (!physical) {
+	zone_info = kcalloc(map->num_stripes, sizeof(*zone_info), GFP_NOFS);
+	if (!zone_info) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -1341,98 +1483,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 
 	for (i = 0; i < map->num_stripes; i++) {
-		bool is_sequential;
-		struct blk_zone zone;
-		struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
-		int dev_replace_is_ongoing = 0;
-
-		device = map->stripes[i].dev;
-		physical[i] = map->stripes[i].physical;
-
-		if (device->bdev == NULL) {
-			alloc_offsets[i] = WP_MISSING_DEV;
-			continue;
-		}
-
-		is_sequential = btrfs_dev_is_sequential(device, physical[i]);
-		if (is_sequential)
-			num_sequential++;
-		else
-			num_conventional++;
-
-		/*
-		 * Consider a zone as active if we can allow any number of
-		 * active zones.
-		 */
-		if (!device->zone_info->max_active_zones)
-			__set_bit(i, active);
-
-		if (!is_sequential) {
-			alloc_offsets[i] = WP_CONVENTIONAL;
-			continue;
-		}
-
-		/*
-		 * This zone will be used for allocation, so mark this zone
-		 * non-empty.
-		 */
-		btrfs_dev_clear_zone_empty(device, physical[i]);
-
-		down_read(&dev_replace->rwsem);
-		dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
-		if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL)
-			btrfs_dev_clear_zone_empty(dev_replace->tgtdev, physical[i]);
-		up_read(&dev_replace->rwsem);
-
-		/*
-		 * The group is mapped to a sequential zone. Get the zone write
-		 * pointer to determine the allocation offset within the zone.
-		 */
-		WARN_ON(!IS_ALIGNED(physical[i], fs_info->zone_size));
-		nofs_flag = memalloc_nofs_save();
-		ret = btrfs_get_dev_zone(device, physical[i], &zone);
-		memalloc_nofs_restore(nofs_flag);
-		if (ret == -EIO || ret == -EOPNOTSUPP) {
-			ret = 0;
-			alloc_offsets[i] = WP_MISSING_DEV;
-			continue;
-		} else if (ret) {
-			goto out;
-		}
-
-		if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL) {
-			btrfs_err_in_rcu(fs_info,
-	"zoned: unexpected conventional zone %llu on device %s (devid %llu)",
-				zone.start << SECTOR_SHIFT,
-				rcu_str_deref(device->name), device->devid);
-			ret = -EIO;
+		ret = btrfs_load_zone_info(fs_info, i, &zone_info[i], active, map);
+		if (ret)
 			goto out;
-		}
-
-		caps[i] = (zone.capacity << SECTOR_SHIFT);
 
-		switch (zone.cond) {
-		case BLK_ZONE_COND_OFFLINE:
-		case BLK_ZONE_COND_READONLY:
-			btrfs_err(fs_info,
-		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
-				  physical[i] >> device->zone_info->zone_size_shift,
-				  rcu_str_deref(device->name), device->devid);
-			alloc_offsets[i] = WP_MISSING_DEV;
-			break;
-		case BLK_ZONE_COND_EMPTY:
-			alloc_offsets[i] = 0;
-			break;
-		case BLK_ZONE_COND_FULL:
-			alloc_offsets[i] = caps[i];
-			break;
-		default:
-			/* Partially used zone */
-			alloc_offsets[i] =
-					((zone.wp - zone.start) << SECTOR_SHIFT);
-			__set_bit(i, active);
-			break;
-		}
+		if (zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			num_conventional++;
+		else
+			num_sequential++;
 	}
 
 	if (num_sequential > 0)
@@ -1456,56 +1514,10 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 	case 0: /* single */
-		if (alloc_offsets[0] == WP_MISSING_DEV) {
-			btrfs_err(fs_info,
-			"zoned: cannot recover write pointer for zone %llu",
-				physical[0]);
-			ret = -EIO;
-			goto out;
-		}
-		cache->alloc_offset = alloc_offsets[0];
-		cache->zone_capacity = caps[0];
-		if (test_bit(0, active))
-			set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags);
+		ret = btrfs_load_block_group_single(cache, &zone_info[0], active);
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
-		if (map->type & BTRFS_BLOCK_GROUP_DATA) {
-			btrfs_err(fs_info, "zoned: profile DUP not yet supported on data bg");
-			ret = -EINVAL;
-			goto out;
-		}
-		if (alloc_offsets[0] == WP_MISSING_DEV) {
-			btrfs_err(fs_info,
-			"zoned: cannot recover write pointer for zone %llu",
-				physical[0]);
-			ret = -EIO;
-			goto out;
-		}
-		if (alloc_offsets[1] == WP_MISSING_DEV) {
-			btrfs_err(fs_info,
-			"zoned: cannot recover write pointer for zone %llu",
-				physical[1]);
-			ret = -EIO;
-			goto out;
-		}
-		if (alloc_offsets[0] != alloc_offsets[1]) {
-			btrfs_err(fs_info,
-			"zoned: write pointer offset mismatch of zones in DUP profile");
-			ret = -EIO;
-			goto out;
-		}
-		if (test_bit(0, active) != test_bit(1, active)) {
-			if (!btrfs_zone_activate(cache)) {
-				ret = -EIO;
-				goto out;
-			}
-		} else {
-			if (test_bit(0, active))
-				set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
-					&cache->runtime_flags);
-		}
-		cache->alloc_offset = alloc_offsets[0];
-		cache->zone_capacity = min(caps[0], caps[1]);
+		ret = btrfs_load_block_group_dup(cache, map, zone_info, active);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
 	case BTRFS_BLOCK_GROUP_RAID0:
@@ -1558,9 +1570,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		cache->physical_map = NULL;
 	}
 	bitmap_free(active);
-	kfree(physical);
-	kfree(caps);
-	kfree(alloc_offsets);
+	kfree(zone_info);
 	free_extent_map(em);
 
 	return ret;
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 5f4df9588620..b9945e4f697b 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -77,6 +77,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "tag",	cachefiles_daemon_tag		},
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 	{ "copen",	cachefiles_ondemand_copen	},
+	{ "restore",	cachefiles_ondemand_restore	},
 #endif
 	{ "",		NULL				}
 };
@@ -132,7 +133,7 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static void cachefiles_flush_reqs(struct cachefiles_cache *cache)
+void cachefiles_flush_reqs(struct cachefiles_cache *cache)
 {
 	struct xarray *xa = &cache->reqs;
 	struct cachefiles_req *req;
@@ -158,6 +159,7 @@ static void cachefiles_flush_reqs(struct cachefiles_cache *cache)
 	xa_for_each(xa, index, req) {
 		req->error = -EIO;
 		complete(&req->done);
+		__xa_erase(xa, index);
 	}
 	xa_unlock(xa);
 
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index a69073a1d3f0..bde23e156a63 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -31,6 +31,11 @@ struct cachefiles_object *cachefiles_alloc_object(struct fscache_cookie *cookie)
 	if (!object)
 		return NULL;
 
+	if (cachefiles_ondemand_init_obj_info(object, volume)) {
+		kmem_cache_free(cachefiles_object_jar, object);
+		return NULL;
+	}
+
 	refcount_set(&object->ref, 1);
 
 	spin_lock_init(&object->lock);
@@ -88,7 +93,7 @@ void cachefiles_put_object(struct cachefiles_object *object,
 		ASSERTCMP(object->file, ==, NULL);
 
 		kfree(object->d_name);
-
+		cachefiles_ondemand_deinit_obj_info(object);
 		cache = object->volume->cache->cache;
 		fscache_put_cookie(object->cookie, fscache_cookie_put_object);
 		object->cookie = NULL;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2ad58c465208..3eea52462fc8 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -44,6 +44,20 @@ struct cachefiles_volume {
 	struct dentry			*fanout[256];	/* Fanout subdirs */
 };
 
+enum cachefiles_object_state {
+	CACHEFILES_ONDEMAND_OBJSTATE_CLOSE, /* Anonymous fd closed by daemon or initial state */
+	CACHEFILES_ONDEMAND_OBJSTATE_OPEN, /* Anonymous fd associated with object is available */
+	CACHEFILES_ONDEMAND_OBJSTATE_REOPENING, /* Object that was closed and is being reopened. */
+};
+
+struct cachefiles_ondemand_info {
+	struct work_struct		ondemand_work;
+	int				ondemand_id;
+	enum cachefiles_object_state	state;
+	struct cachefiles_object	*object;
+	spinlock_t			lock;
+};
+
 /*
  * Backing file state.
  */
@@ -61,7 +75,7 @@ struct cachefiles_object {
 	unsigned long			flags;
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 #ifdef CONFIG_CACHEFILES_ONDEMAND
-	int				ondemand_id;
+	struct cachefiles_ondemand_info	*ondemand;
 #endif
 };
 
@@ -125,6 +139,7 @@ static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
 struct cachefiles_req {
 	struct cachefiles_object *object;
 	struct completion done;
+	refcount_t ref;
 	int error;
 	struct cachefiles_msg msg;
 };
@@ -173,6 +188,7 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
  * daemon.c
  */
 extern const struct file_operations cachefiles_daemon_fops;
+extern void cachefiles_flush_reqs(struct cachefiles_cache *cache);
 extern void cachefiles_get_unbind_pincount(struct cachefiles_cache *cache);
 extern void cachefiles_put_unbind_pincount(struct cachefiles_cache *cache);
 
@@ -290,12 +306,35 @@ extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 				     char *args);
 
+extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
+					char *args);
+
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
 extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 
 extern int cachefiles_ondemand_read(struct cachefiles_object *object,
 				    loff_t pos, size_t len);
 
+extern int cachefiles_ondemand_init_obj_info(struct cachefiles_object *obj,
+					struct cachefiles_volume *volume);
+extern void cachefiles_ondemand_deinit_obj_info(struct cachefiles_object *obj);
+
+#define CACHEFILES_OBJECT_STATE_FUNCS(_state, _STATE)	\
+static inline bool								\
+cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
+{												\
+	return object->ondemand->state == CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
+}												\
+												\
+static inline void								\
+cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
+{												\
+	object->ondemand->state = CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
+}
+
+CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
+CACHEFILES_OBJECT_STATE_FUNCS(close, CLOSE);
+CACHEFILES_OBJECT_STATE_FUNCS(reopening, REOPENING);
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
@@ -317,6 +356,15 @@ static inline int cachefiles_ondemand_read(struct cachefiles_object *object,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *obj,
+						struct cachefiles_volume *volume)
+{
+	return 0;
+}
+static inline void cachefiles_ondemand_deinit_obj_info(struct cachefiles_object *obj)
+{
+}
 #endif
 
 /*
@@ -367,6 +415,8 @@ do {							\
 	pr_err("I/O Error: " FMT"\n", ##__VA_ARGS__);	\
 	fscache_io_error((___cache)->cache);		\
 	set_bit(CACHEFILES_DEAD, &(___cache)->flags);	\
+	if (cachefiles_in_ondemand_mode(___cache))	\
+		cachefiles_flush_reqs(___cache);	\
 } while (0)
 
 #define cachefiles_io_error_obj(object, FMT, ...)			\
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 0254ed39f68c..4b39f0422e59 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -4,26 +4,45 @@
 #include <linux/uio.h>
 #include "internal.h"
 
+struct ondemand_anon_file {
+	struct file *file;
+	int fd;
+};
+
+static inline void cachefiles_req_put(struct cachefiles_req *req)
+{
+	if (refcount_dec_and_test(&req->ref))
+		kfree(req);
+}
+
 static int cachefiles_ondemand_fd_release(struct inode *inode,
 					  struct file *file)
 {
 	struct cachefiles_object *object = file->private_data;
-	struct cachefiles_cache *cache = object->volume->cache;
-	int object_id = object->ondemand_id;
+	struct cachefiles_cache *cache;
+	struct cachefiles_ondemand_info *info;
+	int object_id;
 	struct cachefiles_req *req;
-	XA_STATE(xas, &cache->reqs, 0);
+	XA_STATE(xas, NULL, 0);
 
-	xa_lock(&cache->reqs);
-	object->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
+	if (!object)
+		return 0;
 
-	/*
-	 * Flush all pending READ requests since their completion depends on
-	 * anon_fd.
-	 */
-	xas_for_each(&xas, req, ULONG_MAX) {
+	info = object->ondemand;
+	cache = object->volume->cache;
+	xas.xa = &cache->reqs;
+
+	xa_lock(&cache->reqs);
+	spin_lock(&info->lock);
+	object_id = info->ondemand_id;
+	info->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
+	cachefiles_ondemand_set_object_close(object);
+	spin_unlock(&info->lock);
+
+	/* Only flush CACHEFILES_REQ_NEW marked req to avoid race with daemon_read */
+	xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
 		if (req->msg.object_id == object_id &&
-		    req->msg.opcode == CACHEFILES_OP_READ) {
-			req->error = -EIO;
+		    req->msg.opcode == CACHEFILES_OP_CLOSE) {
 			complete(&req->done);
 			xas_store(&xas, NULL);
 		}
@@ -118,6 +137,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 {
 	struct cachefiles_req *req;
 	struct fscache_cookie *cookie;
+	struct cachefiles_ondemand_info *info;
 	char *pid, *psize;
 	unsigned long id;
 	long size;
@@ -168,6 +188,33 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 		goto out;
 	}
 
+	info = req->object->ondemand;
+	spin_lock(&info->lock);
+	/*
+	 * The anonymous fd was closed before copen ? Fail the request.
+	 *
+	 *             t1             |             t2
+	 * ---------------------------------------------------------
+	 *                             cachefiles_ondemand_copen
+	 *                             req = xa_erase(&cache->reqs, id)
+	 * // Anon fd is maliciously closed.
+	 * cachefiles_ondemand_fd_release
+	 * xa_lock(&cache->reqs)
+	 * cachefiles_ondemand_set_object_close(object)
+	 * xa_unlock(&cache->reqs)
+	 *                             cachefiles_ondemand_set_object_open
+	 *                             // No one will ever close it again.
+	 * cachefiles_ondemand_daemon_read
+	 * cachefiles_ondemand_select_req
+	 *
+	 * Get a read req but its fd is already closed. The daemon can't
+	 * issue a cread ioctl with an closed fd, then hung.
+	 */
+	if (info->ondemand_id == CACHEFILES_ONDEMAND_ID_CLOSED) {
+		spin_unlock(&info->lock);
+		req->error = -EBADFD;
+		goto out;
+	}
 	cookie = req->object->cookie;
 	cookie->object_size = size;
 	if (size)
@@ -176,19 +223,46 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 	trace_cachefiles_ondemand_copen(req->object, id, size);
 
+	cachefiles_ondemand_set_object_open(req->object);
+	spin_unlock(&info->lock);
+	wake_up_all(&cache->daemon_pollwq);
+
 out:
 	complete(&req->done);
 	return ret;
 }
 
-static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
+int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
+{
+	struct cachefiles_req *req;
+
+	XA_STATE(xas, &cache->reqs, 0);
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Reset the requests to CACHEFILES_REQ_NEW state, so that the
+	 * requests have been processed halfway before the crash of the
+	 * user daemon could be reprocessed after the recovery.
+	 */
+	xas_lock(&xas);
+	xas_for_each(&xas, req, ULONG_MAX)
+		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+	xas_unlock(&xas);
+
+	wake_up_all(&cache->daemon_pollwq);
+	return 0;
+}
+
+static int cachefiles_ondemand_get_fd(struct cachefiles_req *req,
+				      struct ondemand_anon_file *anon_file)
 {
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	struct cachefiles_open *load;
-	struct file *file;
 	u32 object_id;
-	int ret, fd;
+	int ret;
 
 	object = cachefiles_grab_object(req->object,
 			cachefiles_obj_get_ondemand_fd);
@@ -200,60 +274,114 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	if (ret < 0)
 		goto err;
 
-	fd = get_unused_fd_flags(O_WRONLY);
-	if (fd < 0) {
-		ret = fd;
+	anon_file->fd = get_unused_fd_flags(O_WRONLY);
+	if (anon_file->fd < 0) {
+		ret = anon_file->fd;
 		goto err_free_id;
 	}
 
-	file = anon_inode_getfile("[cachefiles]", &cachefiles_ondemand_fd_fops,
-				  object, O_WRONLY);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
+	anon_file->file = anon_inode_getfile("[cachefiles]",
+				&cachefiles_ondemand_fd_fops, object, O_WRONLY);
+	if (IS_ERR(anon_file->file)) {
+		ret = PTR_ERR(anon_file->file);
 		goto err_put_fd;
 	}
 
-	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
-	fd_install(fd, file);
+	spin_lock(&object->ondemand->lock);
+	if (object->ondemand->ondemand_id > 0) {
+		spin_unlock(&object->ondemand->lock);
+		/* Pair with check in cachefiles_ondemand_fd_release(). */
+		anon_file->file->private_data = NULL;
+		ret = -EEXIST;
+		goto err_put_file;
+	}
+
+	anon_file->file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
 
 	load = (void *)req->msg.data;
-	load->fd = fd;
-	req->msg.object_id = object_id;
-	object->ondemand_id = object_id;
+	load->fd = anon_file->fd;
+	object->ondemand->ondemand_id = object_id;
+	spin_unlock(&object->ondemand->lock);
 
 	cachefiles_get_unbind_pincount(cache);
 	trace_cachefiles_ondemand_open(object, &req->msg, load);
 	return 0;
 
+err_put_file:
+	fput(anon_file->file);
+	anon_file->file = NULL;
 err_put_fd:
-	put_unused_fd(fd);
+	put_unused_fd(anon_file->fd);
+	anon_file->fd = ret;
 err_free_id:
 	xa_erase(&cache->ondemand_ids, object_id);
 err:
+	spin_lock(&object->ondemand->lock);
+	/* Avoid marking an opened object as closed. */
+	if (object->ondemand->ondemand_id <= 0)
+		cachefiles_ondemand_set_object_close(object);
+	spin_unlock(&object->ondemand->lock);
 	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
 	return ret;
 }
 
+static void ondemand_object_worker(struct work_struct *work)
+{
+	struct cachefiles_ondemand_info *info =
+		container_of(work, struct cachefiles_ondemand_info, ondemand_work);
+
+	cachefiles_ondemand_init_object(info->object);
+}
+
+/*
+ * If there are any inflight or subsequent READ requests on the
+ * closed object, reopen it.
+ * Skip read requests whose related object is reopening.
+ */
+static struct cachefiles_req *cachefiles_ondemand_select_req(struct xa_state *xas,
+							      unsigned long xa_max)
+{
+	struct cachefiles_req *req;
+	struct cachefiles_object *object;
+	struct cachefiles_ondemand_info *info;
+
+	xas_for_each_marked(xas, req, xa_max, CACHEFILES_REQ_NEW) {
+		if (req->msg.opcode != CACHEFILES_OP_READ)
+			return req;
+		object = req->object;
+		info = object->ondemand;
+		if (cachefiles_ondemand_object_is_close(object)) {
+			cachefiles_ondemand_set_object_reopening(object);
+			queue_work(fscache_wq, &info->ondemand_work);
+			continue;
+		}
+		if (cachefiles_ondemand_object_is_reopening(object))
+			continue;
+		return req;
+	}
+	return NULL;
+}
+
 ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
 {
 	struct cachefiles_req *req;
 	struct cachefiles_msg *msg;
-	unsigned long id = 0;
 	size_t n;
 	int ret = 0;
+	struct ondemand_anon_file anon_file;
 	XA_STATE(xas, &cache->reqs, cache->req_id_next);
 
+	xa_lock(&cache->reqs);
 	/*
 	 * Cyclically search for a request that has not ever been processed,
 	 * to prevent requests from being processed repeatedly, and make
 	 * request distribution fair.
 	 */
-	xa_lock(&cache->reqs);
-	req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
+	req = cachefiles_ondemand_select_req(&xas, ULONG_MAX);
 	if (!req && cache->req_id_next > 0) {
 		xas_set(&xas, 0);
-		req = xas_find_marked(&xas, cache->req_id_next - 1, CACHEFILES_REQ_NEW);
+		req = cachefiles_ondemand_select_req(&xas, cache->req_id_next - 1);
 	}
 	if (!req) {
 		xa_unlock(&cache->reqs);
@@ -270,38 +398,45 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 
 	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
 	cache->req_id_next = xas.xa_index + 1;
+	refcount_inc(&req->ref);
+	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
 	xa_unlock(&cache->reqs);
 
-	id = xas.xa_index;
-	msg->msg_id = id;
-
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
-		ret = cachefiles_ondemand_get_fd(req);
+		ret = cachefiles_ondemand_get_fd(req, &anon_file);
 		if (ret)
-			goto error;
+			goto out;
 	}
 
-	if (copy_to_user(_buffer, msg, n) != 0) {
+	msg->msg_id = xas.xa_index;
+	msg->object_id = req->object->ondemand->ondemand_id;
+
+	if (copy_to_user(_buffer, msg, n) != 0)
 		ret = -EFAULT;
-		goto err_put_fd;
-	}
 
-	/* CLOSE request has no reply */
-	if (msg->opcode == CACHEFILES_OP_CLOSE) {
-		xa_erase(&cache->reqs, id);
-		complete(&req->done);
+	if (msg->opcode == CACHEFILES_OP_OPEN) {
+		if (ret < 0) {
+			fput(anon_file.file);
+			put_unused_fd(anon_file.fd);
+			goto out;
+		}
+		fd_install(anon_file.fd, anon_file.file);
 	}
-
-	return n;
-
-err_put_fd:
-	if (msg->opcode == CACHEFILES_OP_OPEN)
-		close_fd(((struct cachefiles_open *)msg->data)->fd);
-error:
-	xa_erase(&cache->reqs, id);
-	req->error = ret;
-	complete(&req->done);
-	return ret;
+out:
+	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
+	/* Remove error request and CLOSE request has no reply */
+	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
+		xas_reset(&xas);
+		xas_lock(&xas);
+		if (xas_load(&xas) == req) {
+			req->error = ret;
+			complete(&req->done);
+			xas_store(&xas, NULL);
+		}
+		xas_unlock(&xas);
+	}
+	cachefiles_req_put(req);
+	return ret ? ret : n;
 }
 
 typedef int (*init_req_fn)(struct cachefiles_req *req, void *private);
@@ -313,20 +448,25 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 					void *private)
 {
 	struct cachefiles_cache *cache = object->volume->cache;
-	struct cachefiles_req *req;
+	struct cachefiles_req *req = NULL;
 	XA_STATE(xas, &cache->reqs, 0);
 	int ret;
 
 	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
 		return 0;
 
-	if (test_bit(CACHEFILES_DEAD, &cache->flags))
-		return -EIO;
+	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
+		ret = -EIO;
+		goto out;
+	}
 
 	req = kzalloc(sizeof(*req) + data_len, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
+	if (!req) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
+	refcount_set(&req->ref, 1);
 	req->object = object;
 	init_completion(&req->done);
 	req->msg.opcode = opcode;
@@ -363,8 +503,9 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		/* coupled with the barrier in cachefiles_flush_reqs() */
 		smp_mb();
 
-		if (opcode != CACHEFILES_OP_OPEN && object->ondemand_id <= 0) {
-			WARN_ON_ONCE(object->ondemand_id == 0);
+		if (opcode == CACHEFILES_OP_CLOSE &&
+			!cachefiles_ondemand_object_is_open(object)) {
+			WARN_ON_ONCE(object->ondemand->ondemand_id == 0);
 			xas_unlock(&xas);
 			ret = -EIO;
 			goto out;
@@ -387,7 +528,15 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 	wake_up_all(&cache->daemon_pollwq);
 	wait_for_completion(&req->done);
 	ret = req->error;
+	cachefiles_req_put(req);
+	return ret;
 out:
+	/* Reset the object to close state in error handling path.
+	 * If error occurs after creating the anonymous fd,
+	 * cachefiles_ondemand_fd_release() will set object to close.
+	 */
+	if (opcode == CACHEFILES_OP_OPEN)
+		cachefiles_ondemand_set_object_close(object);
 	kfree(req);
 	return ret;
 }
@@ -430,18 +579,10 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 					      void *private)
 {
 	struct cachefiles_object *object = req->object;
-	int object_id = object->ondemand_id;
 
-	/*
-	 * It's possible that object id is still 0 if the cookie looking up
-	 * phase failed before OPEN request has ever been sent. Also avoid
-	 * sending CLOSE request for CACHEFILES_ONDEMAND_ID_CLOSED, which means
-	 * anon_fd has already been closed.
-	 */
-	if (object_id <= 0)
+	if (!cachefiles_ondemand_object_is_open(object))
 		return -ENOENT;
 
-	req->msg.object_id = object_id;
 	trace_cachefiles_ondemand_close(object, &req->msg);
 	return 0;
 }
@@ -457,16 +598,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
 	struct cachefiles_object *object = req->object;
 	struct cachefiles_read *load = (void *)req->msg.data;
 	struct cachefiles_read_ctx *read_ctx = private;
-	int object_id = object->ondemand_id;
-
-	/* Stop enqueuing requests when daemon has closed anon_fd. */
-	if (object_id <= 0) {
-		WARN_ON_ONCE(object_id == 0);
-		pr_info_once("READ: anonymous fd closed prematurely.\n");
-		return -EIO;
-	}
 
-	req->msg.object_id = object_id;
 	load->off = read_ctx->off;
 	load->len = read_ctx->len;
 	trace_cachefiles_ondemand_read(object, &req->msg, load);
@@ -479,13 +611,16 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 	struct fscache_volume *volume = object->volume->vcookie;
 	size_t volume_key_size, cookie_key_size, data_len;
 
+	if (!object->ondemand)
+		return 0;
+
 	/*
 	 * CacheFiles will firstly check the cache file under the root cache
 	 * directory. If the coherency check failed, it will fallback to
 	 * creating a new tmpfile as the cache file. Reuse the previously
 	 * allocated object ID if any.
 	 */
-	if (object->ondemand_id > 0)
+	if (cachefiles_ondemand_object_is_open(object))
 		return 0;
 
 	volume_key_size = volume->key[0] + 1;
@@ -503,6 +638,29 @@ void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 			cachefiles_ondemand_init_close_req, NULL);
 }
 
+int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
+				struct cachefiles_volume *volume)
+{
+	if (!cachefiles_in_ondemand_mode(volume->cache))
+		return 0;
+
+	object->ondemand = kzalloc(sizeof(struct cachefiles_ondemand_info),
+					GFP_KERNEL);
+	if (!object->ondemand)
+		return -ENOMEM;
+
+	object->ondemand->object = object;
+	spin_lock_init(&object->ondemand->lock);
+	INIT_WORK(&object->ondemand->ondemand_work, ondemand_object_worker);
+	return 0;
+}
+
+void cachefiles_ondemand_deinit_obj_info(struct cachefiles_object *object)
+{
+	kfree(object->ondemand);
+	object->ondemand = NULL;
+}
+
 int cachefiles_ondemand_read(struct cachefiles_object *object,
 			     loff_t pos, size_t len)
 {
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index f9273f6901c8..07df16ce8006 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -557,9 +557,11 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 
       size_check:
 	if (EALIST_SIZE(ea_buf->xattr) != ea_size) {
+		int size = min_t(int, EALIST_SIZE(ea_buf->xattr), ea_size);
+
 		printk(KERN_ERR "ea_get: invalid extended attribute\n");
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
-				     ea_buf->xattr, ea_size, 1);
+				     ea_buf->xattr, size, 1);
 		ea_release(inode, ea_buf);
 		rc = -EIO;
 		goto clean_up;
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f594dac436a7..a5a4d9422d6e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1792,9 +1792,10 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags,
 		if (parent != READ_ONCE(dentry->d_parent))
 			return -ECHILD;
 	} else {
-		/* Wait for unlink to complete */
+		/* Wait for unlink to complete - see unblock_revalidate() */
 		wait_var_event(&dentry->d_fsdata,
-			       dentry->d_fsdata != NFS_FSDATA_BLOCKED);
+			       smp_load_acquire(&dentry->d_fsdata)
+			       != NFS_FSDATA_BLOCKED);
 		parent = dget_parent(dentry);
 		ret = reval(d_inode(parent), dentry, flags);
 		dput(parent);
@@ -1807,6 +1808,29 @@ static int nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 	return __nfs_lookup_revalidate(dentry, flags, nfs_do_lookup_revalidate);
 }
 
+static void block_revalidate(struct dentry *dentry)
+{
+	/* old devname - just in case */
+	kfree(dentry->d_fsdata);
+
+	/* Any new reference that could lead to an open
+	 * will take ->d_lock in lookup_open() -> d_lookup().
+	 * Holding this lock ensures we cannot race with
+	 * __nfs_lookup_revalidate() and removes and need
+	 * for further barriers.
+	 */
+	lockdep_assert_held(&dentry->d_lock);
+
+	dentry->d_fsdata = NFS_FSDATA_BLOCKED;
+}
+
+static void unblock_revalidate(struct dentry *dentry)
+{
+	/* store_release ensures wait_var_event() sees the update */
+	smp_store_release(&dentry->d_fsdata, NULL);
+	wake_up_var(&dentry->d_fsdata);
+}
+
 /*
  * A weaker form of d_revalidate for revalidating just the d_inode(dentry)
  * when we don't really care about the dentry name. This is called when a
@@ -2489,15 +2513,12 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
 		spin_unlock(&dentry->d_lock);
 		goto out;
 	}
-	/* old devname */
-	kfree(dentry->d_fsdata);
-	dentry->d_fsdata = NFS_FSDATA_BLOCKED;
+	block_revalidate(dentry);
 
 	spin_unlock(&dentry->d_lock);
 	error = nfs_safe_remove(dentry);
 	nfs_dentry_remove_handle_error(dir, dentry, error);
-	dentry->d_fsdata = NULL;
-	wake_up_var(&dentry->d_fsdata);
+	unblock_revalidate(dentry);
 out:
 	trace_nfs_unlink_exit(dir, dentry, error);
 	return error;
@@ -2609,8 +2630,7 @@ nfs_unblock_rename(struct rpc_task *task, struct nfs_renamedata *data)
 {
 	struct dentry *new_dentry = data->new_dentry;
 
-	new_dentry->d_fsdata = NULL;
-	wake_up_var(&new_dentry->d_fsdata);
+	unblock_revalidate(new_dentry);
 }
 
 /*
@@ -2672,11 +2692,6 @@ int nfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		if (WARN_ON(new_dentry->d_flags & DCACHE_NFSFS_RENAMED) ||
 		    WARN_ON(new_dentry->d_fsdata == NFS_FSDATA_BLOCKED))
 			goto out;
-		if (new_dentry->d_fsdata) {
-			/* old devname */
-			kfree(new_dentry->d_fsdata);
-			new_dentry->d_fsdata = NULL;
-		}
 
 		spin_lock(&new_dentry->d_lock);
 		if (d_count(new_dentry) > 2) {
@@ -2698,7 +2713,7 @@ int nfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			new_dentry = dentry;
 			new_inode = NULL;
 		} else {
-			new_dentry->d_fsdata = NFS_FSDATA_BLOCKED;
+			block_revalidate(new_dentry);
 			must_unblock = true;
 			spin_unlock(&new_dentry->d_lock);
 		}
@@ -2710,6 +2725,8 @@ int nfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	task = nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
 				must_unblock ? nfs_unblock_rename : NULL);
 	if (IS_ERR(task)) {
+		if (must_unblock)
+			unblock_revalidate(new_dentry);
 		error = PTR_ERR(task);
 		goto out;
 	}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bda3050817c9..ec641a8f6604 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4009,6 +4009,23 @@ static void test_fs_location_for_trunking(struct nfs4_fs_location *location,
 	}
 }
 
+static bool _is_same_nfs4_pathname(struct nfs4_pathname *path1,
+				   struct nfs4_pathname *path2)
+{
+	int i;
+
+	if (path1->ncomponents != path2->ncomponents)
+		return false;
+	for (i = 0; i < path1->ncomponents; i++) {
+		if (path1->components[i].len != path2->components[i].len)
+			return false;
+		if (memcmp(path1->components[i].data, path2->components[i].data,
+				path1->components[i].len))
+			return false;
+	}
+	return true;
+}
+
 static int _nfs4_discover_trunking(struct nfs_server *server,
 				   struct nfs_fh *fhandle)
 {
@@ -4042,9 +4059,13 @@ static int _nfs4_discover_trunking(struct nfs_server *server,
 	if (status)
 		goto out_free_3;
 
-	for (i = 0; i < locations->nlocations; i++)
+	for (i = 0; i < locations->nlocations; i++) {
+		if (!_is_same_nfs4_pathname(&locations->fs_path,
+					&locations->locations[i].rootpath))
+			continue;
 		test_fs_location_for_trunking(&locations->locations[i], clp,
 					      server);
+	}
 out_free_3:
 	kfree(locations->fattr);
 out_free_2:
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 8c52b6c9d31a..3a2ad88ae648 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -569,7 +569,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 		_fh_update(fhp, exp, dentry);
 	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID) {
 		fh_put(fhp);
-		return nfserr_opnotsupp;
+		return nfserr_stale;
 	}
 
 	return 0;
@@ -595,7 +595,7 @@ fh_update(struct svc_fh *fhp)
 
 	_fh_update(fhp, fhp->fh_export, dentry);
 	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID)
-		return nfserr_opnotsupp;
+		return nfserr_stale;
 	return 0;
 out_bad:
 	printk(KERN_ERR "fh_update: fh not verified!\n");
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 760405da852f..e9668e455a35 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -186,19 +186,24 @@ static bool nilfs_check_page(struct page *page)
 	return false;
 }
 
-static struct page *nilfs_get_page(struct inode *dir, unsigned long n)
+static void *nilfs_get_page(struct inode *dir, unsigned long n,
+		struct page **pagep)
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_mapping_page(mapping, n, NULL);
+	void *kaddr;
 
-	if (!IS_ERR(page)) {
-		kmap(page);
-		if (unlikely(!PageChecked(page))) {
-			if (!nilfs_check_page(page))
-				goto fail;
-		}
+	if (IS_ERR(page))
+		return page;
+
+	kaddr = kmap(page);
+	if (unlikely(!PageChecked(page))) {
+		if (!nilfs_check_page(page))
+			goto fail;
 	}
-	return page;
+
+	*pagep = page;
+	return kaddr;
 
 fail:
 	nilfs_put_page(page);
@@ -275,14 +280,14 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 	for ( ; n < npages; n++, offset = 0) {
 		char *kaddr, *limit;
 		struct nilfs_dir_entry *de;
-		struct page *page = nilfs_get_page(inode, n);
+		struct page *page;
 
-		if (IS_ERR(page)) {
+		kaddr = nilfs_get_page(inode, n, &page);
+		if (IS_ERR(kaddr)) {
 			nilfs_error(sb, "bad page in #%lu", inode->i_ino);
 			ctx->pos += PAGE_SIZE - offset;
 			return -EIO;
 		}
-		kaddr = page_address(page);
 		de = (struct nilfs_dir_entry *)(kaddr + offset);
 		limit = kaddr + nilfs_last_byte(inode, n) -
 			NILFS_DIR_REC_LEN(1);
@@ -345,11 +350,9 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 		start = 0;
 	n = start;
 	do {
-		char *kaddr;
+		char *kaddr = nilfs_get_page(dir, n, &page);
 
-		page = nilfs_get_page(dir, n);
-		if (!IS_ERR(page)) {
-			kaddr = page_address(page);
+		if (!IS_ERR(kaddr)) {
 			de = (struct nilfs_dir_entry *)kaddr;
 			kaddr += nilfs_last_byte(dir, n) - reclen;
 			while ((char *) de <= kaddr) {
@@ -387,15 +390,11 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 
 struct nilfs_dir_entry *nilfs_dotdot(struct inode *dir, struct page **p)
 {
-	struct page *page = nilfs_get_page(dir, 0);
-	struct nilfs_dir_entry *de = NULL;
+	struct nilfs_dir_entry *de = nilfs_get_page(dir, 0, p);
 
-	if (!IS_ERR(page)) {
-		de = nilfs_next_entry(
-			(struct nilfs_dir_entry *)page_address(page));
-		*p = page;
-	}
-	return de;
+	if (IS_ERR(de))
+		return NULL;
+	return nilfs_next_entry(de);
 }
 
 ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)
@@ -459,12 +458,11 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 	for (n = 0; n <= npages; n++) {
 		char *dir_end;
 
-		page = nilfs_get_page(dir, n);
-		err = PTR_ERR(page);
-		if (IS_ERR(page))
+		kaddr = nilfs_get_page(dir, n, &page);
+		err = PTR_ERR(kaddr);
+		if (IS_ERR(kaddr))
 			goto out;
 		lock_page(page);
-		kaddr = page_address(page);
 		dir_end = kaddr + nilfs_last_byte(dir, n);
 		de = (struct nilfs_dir_entry *)kaddr;
 		kaddr += PAGE_SIZE - reclen;
@@ -627,11 +625,10 @@ int nilfs_empty_dir(struct inode *inode)
 		char *kaddr;
 		struct nilfs_dir_entry *de;
 
-		page = nilfs_get_page(inode, i);
-		if (IS_ERR(page))
-			continue;
+		kaddr = nilfs_get_page(inode, i, &page);
+		if (IS_ERR(kaddr))
+			return 0;
 
-		kaddr = page_address(page);
 		de = (struct nilfs_dir_entry *)kaddr;
 		kaddr += nilfs_last_byte(inode, i) - NILFS_DIR_REC_LEN(1);
 
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index dfc459a62fb3..04943ab40a01 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1692,6 +1692,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 			if (bh->b_page != bd_page) {
 				if (bd_page) {
 					lock_page(bd_page);
+					wait_on_page_writeback(bd_page);
 					clear_page_dirty_for_io(bd_page);
 					set_page_writeback(bd_page);
 					unlock_page(bd_page);
@@ -1705,6 +1706,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 			if (bh == segbuf->sb_super_root) {
 				if (bh->b_page != bd_page) {
 					lock_page(bd_page);
+					wait_on_page_writeback(bd_page);
 					clear_page_dirty_for_io(bd_page);
 					set_page_writeback(bd_page);
 					unlock_page(bd_page);
@@ -1721,6 +1723,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 	}
 	if (bd_page) {
 		lock_page(bd_page);
+		wait_on_page_writeback(bd_page);
 		clear_page_dirty_for_io(bd_page);
 		set_page_writeback(bd_page);
 		unlock_page(bd_page);
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index cae410568bb2..f502bb2ce2ea 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1937,6 +1937,8 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 
 	inode_lock(inode);
 
+	/* Wait all existing dio workers, newcomers will block on i_rwsem */
+	inode_dio_wait(inode);
 	/*
 	 * This prevents concurrent writes on other nodes
 	 */
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 04a8505bd97a..8a0fa51c9ac6 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -566,7 +566,7 @@ static int __ocfs2_mknod_locked(struct inode *dir,
 	fe->i_last_eb_blk = 0;
 	strcpy(fe->i_signature, OCFS2_INODE_SIGNATURE);
 	fe->i_flags |= cpu_to_le32(OCFS2_VALID_FL);
-	ktime_get_real_ts64(&ts);
+	ktime_get_coarse_real_ts64(&ts);
 	fe->i_atime = fe->i_ctime = fe->i_mtime =
 		cpu_to_le64(ts.tv_sec);
 	fe->i_mtime_nsec = fe->i_ctime_nsec = fe->i_atime_nsec =
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1ec0647a2026..f4d5db359718 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -383,6 +383,8 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 		/* leave now if filled buffer already */
 		if (!iov_iter_count(iter))
 			return acc;
+
+		cond_resched();
 	}
 
 	list_for_each_entry(m, &vmcore_list, list) {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f7c49bbdb8a1..cfc59c3371cb 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -964,15 +964,33 @@ int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr);
 
 #endif /* I2C */
 
+/* must call put_device() when done with returned i2c_client device */
+struct i2c_client *i2c_find_device_by_fwnode(struct fwnode_handle *fwnode);
+
+/* must call put_device() when done with returned i2c_adapter device */
+struct i2c_adapter *i2c_find_adapter_by_fwnode(struct fwnode_handle *fwnode);
+
+/* must call i2c_put_adapter() when done with returned i2c_adapter device */
+struct i2c_adapter *i2c_get_adapter_by_fwnode(struct fwnode_handle *fwnode);
+
 #if IS_ENABLED(CONFIG_OF)
 /* must call put_device() when done with returned i2c_client device */
-struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
+static inline struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
+{
+	return i2c_find_device_by_fwnode(of_fwnode_handle(node));
+}
 
 /* must call put_device() when done with returned i2c_adapter device */
-struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node);
+static inline struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
+{
+	return i2c_find_adapter_by_fwnode(of_fwnode_handle(node));
+}
 
 /* must call i2c_put_adapter() when done with returned i2c_adapter device */
-struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node);
+static inline struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node)
+{
+	return i2c_get_adapter_by_fwnode(of_fwnode_handle(node));
+}
 
 const struct of_device_id
 *i2c_of_match_device(const struct of_device_id *matches,
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index fb724c65c77b..5ce0cd76956e 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -114,14 +114,14 @@ static inline int pse_ethtool_get_status(struct pse_control *psec,
 					 struct netlink_ext_ack *extack,
 					 struct pse_control_status *status)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int pse_ethtool_set_config(struct pse_control *psec,
 					 struct netlink_ext_ack *extack,
 					 const struct pse_control_config *config)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 #endif
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 13bf20242b61..1c9b3f27f2d3 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -467,6 +467,7 @@ struct uart_port {
 	unsigned char		iotype;			/* io access style */
 	unsigned char		quirks;			/* internal quirks */
 
+#define UPIO_UNKNOWN		((unsigned char)~0U)	/* UCHAR_MAX */
 #define UPIO_PORT		(SERIAL_IO_PORT)	/* 8b I/O port access */
 #define UPIO_HUB6		(SERIAL_IO_HUB6)	/* Hub6 ISA card */
 #define UPIO_MEM		(SERIAL_IO_MEM)		/* driver-specific */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c50a41f1782a..9df7e29386bc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1936,18 +1936,46 @@ static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
 {
 	u16 max_latency;
 
-	if (min > max || min < 6 || max > 3200)
+	if (min > max) {
+		BT_WARN("min %d > max %d", min, max);
 		return -EINVAL;
+	}
+
+	if (min < 6) {
+		BT_WARN("min %d < 6", min);
+		return -EINVAL;
+	}
+
+	if (max > 3200) {
+		BT_WARN("max %d > 3200", max);
+		return -EINVAL;
+	}
+
+	if (to_multiplier < 10) {
+		BT_WARN("to_multiplier %d < 10", to_multiplier);
+		return -EINVAL;
+	}
 
-	if (to_multiplier < 10 || to_multiplier > 3200)
+	if (to_multiplier > 3200) {
+		BT_WARN("to_multiplier %d > 3200", to_multiplier);
 		return -EINVAL;
+	}
 
-	if (max >= to_multiplier * 8)
+	if (max >= to_multiplier * 8) {
+		BT_WARN("max %d >= to_multiplier %d * 8", max, to_multiplier);
 		return -EINVAL;
+	}
 
 	max_latency = (to_multiplier * 4 / max) - 1;
-	if (latency > 499 || latency > max_latency)
+	if (latency > 499) {
+		BT_WARN("latency %d > 499", latency);
 		return -EINVAL;
+	}
+
+	if (latency > max_latency) {
+		BT_WARN("latency %d > max_latency %d", latency, max_latency);
+		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index f9906b73e7ff..0cc077c3dda3 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -353,9 +353,10 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 
 /* Variant of pskb_inet_may_pull().
  */
-static inline bool skb_vlan_inet_prepare(struct sk_buff *skb)
+static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
+					 bool inner_proto_inherit)
 {
-	int nhlen = 0, maclen = ETH_HLEN;
+	int nhlen = 0, maclen = inner_proto_inherit ? 0 : ETH_HLEN;
 	__be16 type = skb->protocol;
 
 	/* Essentially this is skb_protocol(skb, true)
diff --git a/include/scsi/scsi_transport_sas.h b/include/scsi/scsi_transport_sas.h
index 0e75b9277c8c..e3b6ce3cbf88 100644
--- a/include/scsi/scsi_transport_sas.h
+++ b/include/scsi/scsi_transport_sas.h
@@ -200,6 +200,8 @@ unsigned int sas_is_tlr_enabled(struct scsi_device *);
 void sas_disable_tlr(struct scsi_device *);
 void sas_enable_tlr(struct scsi_device *);
 
+bool sas_ata_ncq_prio_supported(struct scsi_device *sdev);
+
 extern struct sas_rphy *sas_end_device_alloc(struct sas_port *);
 extern struct sas_rphy *sas_expander_alloc(struct sas_port *, enum sas_device_type);
 void sas_rphy_free(struct sas_rphy *);
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index d8d4d73fe7b6..dff9a4850224 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -33,6 +33,8 @@ enum cachefiles_obj_ref_trace {
 	cachefiles_obj_see_withdrawal,
 	cachefiles_obj_get_ondemand_fd,
 	cachefiles_obj_put_ondemand_fd,
+	cachefiles_obj_get_read_req,
+	cachefiles_obj_put_read_req,
 };
 
 enum fscache_why_object_killed {
@@ -127,7 +129,11 @@ enum cachefiles_error_trace {
 	EM(cachefiles_obj_see_lookup_cookie,	"SEE lookup_cookie")	\
 	EM(cachefiles_obj_see_lookup_failed,	"SEE lookup_failed")	\
 	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
-	E_(cachefiles_obj_see_withdrawal,	"SEE withdrawal")
+	EM(cachefiles_obj_see_withdrawal,	"SEE withdrawal")	\
+	EM(cachefiles_obj_get_ondemand_fd,      "GET ondemand_fd")	\
+	EM(cachefiles_obj_put_ondemand_fd,      "PUT ondemand_fd")	\
+	EM(cachefiles_obj_get_read_req,		"GET read_req")		\
+	E_(cachefiles_obj_put_read_req,		"PUT read_req")
 
 #define cachefiles_coherency_traces					\
 	EM(cachefiles_coherency_check_aux,	"BAD aux ")		\
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 57ef6850c6a8..55902303d7dc 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -154,7 +154,8 @@ static void __user *io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	req->buf_list = bl;
 	req->buf_index = buf->bid;
 
-	if (issue_flags & IO_URING_F_UNLOCKED || !file_can_poll(req->file)) {
+	if (issue_flags & IO_URING_F_UNLOCKED ||
+	    (req->file && !file_can_poll(req->file))) {
 		/*
 		 * If we came in unlocked, we have no choice but to consume the
 		 * buffer here, otherwise nothing ensures that the buffer won't
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 872d149b1959..413a69aecf5c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5182,6 +5182,7 @@ int perf_event_release_kernel(struct perf_event *event)
 again:
 	mutex_lock(&event->child_mutex);
 	list_for_each_entry(child, &event->child_list, child_list) {
+		void *var = NULL;
 
 		/*
 		 * Cannot change, child events are not migrated, see the
@@ -5222,11 +5223,23 @@ int perf_event_release_kernel(struct perf_event *event)
 			 * this can't be the last reference.
 			 */
 			put_event(event);
+		} else {
+			var = &ctx->refcount;
 		}
 
 		mutex_unlock(&event->child_mutex);
 		mutex_unlock(&ctx->mutex);
 		put_ctx(ctx);
+
+		if (var) {
+			/*
+			 * If perf_event_free_task() has deleted all events from the
+			 * ctx while the child_mutex got released above, make sure to
+			 * notify about the preceding put_ctx().
+			 */
+			smp_mb(); /* pairs with wait_var_event() */
+			wake_up_var(var);
+		}
 		goto again;
 	}
 	mutex_unlock(&event->child_mutex);
diff --git a/kernel/fork.c b/kernel/fork.c
index 7e9a5919299b..85617928041c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -662,15 +662,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
 		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
-		/*
-		 * Copy/update hugetlb private vma information.
-		 */
-		if (is_vm_hugetlb_page(tmp))
-			hugetlb_dup_vma_private(tmp);
-
-		if (tmp->vm_ops && tmp->vm_ops->open)
-			tmp->vm_ops->open(tmp);
-
 		file = tmp->vm_file;
 		if (file) {
 			struct address_space *mapping = file->f_mapping;
@@ -687,6 +678,12 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			i_mmap_unlock_write(mapping);
 		}
 
+		/*
+		 * Copy/update hugetlb private vma information.
+		 */
+		if (is_vm_hugetlb_page(tmp))
+			hugetlb_dup_vma_private(tmp);
+
 		/* Link the vma into the MT */
 		mas.index = tmp->vm_start;
 		mas.last = tmp->vm_end - 1;
@@ -698,6 +695,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval = copy_page_range(tmp, mpnt);
 
+		if (tmp->vm_ops && tmp->vm_ops->open)
+			tmp->vm_ops->open(tmp);
+
 		if (retval)
 			goto loop_out;
 	}
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index fc21c5d5fd5d..1daadbefcee3 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -214,6 +214,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 */
 	do {
 		clear_thread_flag(TIF_SIGPENDING);
+		clear_thread_flag(TIF_NOTIFY_SIGNAL);
 		rc = kernel_wait4(-1, NULL, __WALL, NULL);
 	} while (rc != -ECHILD);
 
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index e9138cd7a0f5..7f2b17fc8ce4 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -179,26 +179,6 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 	}
 }
 
-#ifdef CONFIG_NO_HZ_FULL
-static void giveup_do_timer(void *info)
-{
-	int cpu = *(unsigned int *)info;
-
-	WARN_ON(tick_do_timer_cpu != smp_processor_id());
-
-	tick_do_timer_cpu = cpu;
-}
-
-static void tick_take_do_timer_from_boot(void)
-{
-	int cpu = smp_processor_id();
-	int from = tick_do_timer_boot_cpu;
-
-	if (from >= 0 && from != cpu)
-		smp_call_function_single(from, giveup_do_timer, &cpu, 1);
-}
-#endif
-
 /*
  * Setup the tick device
  */
@@ -222,19 +202,25 @@ static void tick_setup_device(struct tick_device *td,
 			tick_next_period = ktime_get();
 #ifdef CONFIG_NO_HZ_FULL
 			/*
-			 * The boot CPU may be nohz_full, in which case set
-			 * tick_do_timer_boot_cpu so the first housekeeping
-			 * secondary that comes up will take do_timer from
-			 * us.
+			 * The boot CPU may be nohz_full, in which case the
+			 * first housekeeping secondary will take do_timer()
+			 * from it.
 			 */
 			if (tick_nohz_full_cpu(cpu))
 				tick_do_timer_boot_cpu = cpu;
 
-		} else if (tick_do_timer_boot_cpu != -1 &&
-						!tick_nohz_full_cpu(cpu)) {
-			tick_take_do_timer_from_boot();
+		} else if (tick_do_timer_boot_cpu != -1 && !tick_nohz_full_cpu(cpu)) {
 			tick_do_timer_boot_cpu = -1;
-			WARN_ON(tick_do_timer_cpu != cpu);
+			/*
+			 * The boot CPU will stay in periodic (NOHZ disabled)
+			 * mode until clocksource_done_booting() called after
+			 * smp_init() selects a high resolution clocksource and
+			 * timekeeping_notify() kicks the NOHZ stuff alive.
+			 *
+			 * So this WRITE_ONCE can only race with the READ_ONCE
+			 * check in tick_periodic() but this race is harmless.
+			 */
+			WRITE_ONCE(tick_do_timer_cpu, cpu);
 #endif
 		}
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index be58ce999259..8067c1e22af9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1110,7 +1110,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		 * subpages.
 		 */
 		put_page(hpage);
-		if (__page_handle_poison(p) >= 0) {
+		if (__page_handle_poison(p) > 0) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
 		} else {
@@ -1888,7 +1888,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	 */
 	if (res == 0) {
 		unlock_page(head);
-		if (__page_handle_poison(p) >= 0) {
+		if (__page_handle_poison(p) > 0) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
 		} else {
@@ -2346,6 +2346,13 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
+	if (is_huge_zero_page(page)) {
+		unpoison_pr_info("Unpoison: huge zero page is not supported %#lx\n",
+				 pfn, &unpoison_rs);
+		ret = -EOPNOTSUPP;
+		goto unlock_mutex;
+	}
+
 	if (!PageHWPoison(p)) {
 		unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
 				 pfn, &unpoison_rs);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 67a10a04df04..c5e30b52844c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2923,6 +2923,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
 {
 	unsigned int nr_allocated = 0;
+	gfp_t alloc_gfp = gfp;
+	bool nofail = gfp & __GFP_NOFAIL;
 	struct page *page;
 	int i;
 
@@ -2933,6 +2935,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	 * more permissive.
 	 */
 	if (!order) {
+		/* bulk allocator doesn't support nofail req. officially */
 		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
 
 		while (nr_allocated < nr_pages) {
@@ -2971,20 +2974,34 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			if (nr != nr_pages_request)
 				break;
 		}
+	} else if (gfp & __GFP_NOFAIL) {
+		/*
+		 * Higher order nofail allocations are really expensive and
+		 * potentially dangerous (pre-mature OOM, disruptive reclaim
+		 * and compaction etc.
+		 */
+		alloc_gfp &= ~__GFP_NOFAIL;
 	}
 
 	/* High-order pages or fallback path if "bulk" fails. */
-
 	while (nr_allocated < nr_pages) {
-		if (fatal_signal_pending(current))
+		if (!nofail && fatal_signal_pending(current))
 			break;
 
 		if (nid == NUMA_NO_NODE)
-			page = alloc_pages(gfp, order);
+			page = alloc_pages(alloc_gfp, order);
 		else
-			page = alloc_pages_node(nid, gfp, order);
-		if (unlikely(!page))
-			break;
+			page = alloc_pages_node(nid, alloc_gfp, order);
+		if (unlikely(!page)) {
+			if (!nofail)
+				break;
+
+			/* fall back to the zero order allocations */
+			alloc_gfp |= __GFP_NOFAIL;
+			order = 0;
+			continue;
+		}
+
 		/*
 		 * Higher order allocations must be able to be treated as
 		 * indepdenent small pages by callers (as they can with
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 0bffac238b61..a1e0be871687 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1378,8 +1378,10 @@ static int ax25_accept(struct socket *sock, struct socket *newsock, int flags,
 {
 	struct sk_buff *skb;
 	struct sock *newsk;
+	ax25_dev *ax25_dev;
 	DEFINE_WAIT(wait);
 	struct sock *sk;
+	ax25_cb *ax25;
 	int err = 0;
 
 	if (sock->state != SS_UNCONNECTED)
@@ -1434,6 +1436,10 @@ static int ax25_accept(struct socket *sock, struct socket *newsock, int flags,
 	kfree_skb(skb);
 	sk_acceptq_removed(sk);
 	newsock->state = SS_CONNECTED;
+	ax25 = sk_to_ax25(newsk);
+	ax25_dev = ax25->ax25_dev;
+	netdev_hold(ax25_dev->dev, &ax25->dev_tracker, GFP_ATOMIC);
+	ax25_dev_hold(ax25_dev);
 
 out:
 	release_sock(sk);
diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index fcc64645bbf5..e165fe108bb0 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -193,7 +193,7 @@ void __exit ax25_dev_free(void)
 	list_for_each_entry_safe(s, n, &ax25_dev_list, list) {
 		netdev_put(s->dev, &s->dev_tracker);
 		list_del(&s->list);
-		kfree(s);
+		ax25_dev_put(s);
 	}
 	spin_unlock_bh(&ax25_dev_lock);
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5f9a599baa34..a204488a2175 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5641,13 +5641,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	if (max > hcon->le_conn_max_interval) {
-		BT_DBG("requested connection interval exceeds current bounds.");
-		err = -EINVAL;
-	} else {
-		err = hci_check_conn_params(min, max, latency, to_multiplier);
-	}
-
+	err = hci_check_conn_params(min, max, latency, to_multiplier);
 	if (err)
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 	else
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 6094ef7cffcd..64be562f0fe3 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -841,10 +841,16 @@ static void
 __bpf_prog_test_run_raw_tp(void *data)
 {
 	struct bpf_raw_tp_test_run_info *info = data;
+	struct bpf_trace_run_ctx run_ctx = {};
+	struct bpf_run_ctx *old_run_ctx;
+
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 
 	rcu_read_lock();
 	info->retval = bpf_prog_run(info->prog, info->ctx);
 	rcu_read_unlock();
+
+	bpf_reset_run_ctx(old_run_ctx);
 }
 
 int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 3c66141d34d6..1820f09ff59c 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -73,11 +73,10 @@ int br_mst_get_state(const struct net_device *dev, u16 msti, u8 *state)
 }
 EXPORT_SYMBOL_GPL(br_mst_get_state);
 
-static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_vlan *v,
+static void br_mst_vlan_set_state(struct net_bridge_vlan_group *vg,
+				  struct net_bridge_vlan *v,
 				  u8 state)
 {
-	struct net_bridge_vlan_group *vg = nbp_vlan_group(p);
-
 	if (br_vlan_get_state(v) == state)
 		return;
 
@@ -103,7 +102,7 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 	int err = 0;
 
 	rcu_read_lock();
-	vg = nbp_vlan_group(p);
+	vg = nbp_vlan_group_rcu(p);
 	if (!vg)
 		goto out;
 
@@ -121,7 +120,7 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 		if (v->brvlan->msti != msti)
 			continue;
 
-		br_mst_vlan_set_state(p, v, state);
+		br_mst_vlan_set_state(vg, v, state);
 	}
 
 out:
@@ -140,13 +139,13 @@ static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
 		 * it.
 		 */
 		if (v != pv && v->brvlan->msti == msti) {
-			br_mst_vlan_set_state(pv->port, pv, v->state);
+			br_mst_vlan_set_state(vg, pv, v->state);
 			return;
 		}
 	}
 
 	/* Otherwise, start out in a new MSTI with all ports disabled. */
-	return br_mst_vlan_set_state(pv->port, pv, BR_STATE_DISABLED);
+	return br_mst_vlan_set_state(vg, pv, BR_STATE_DISABLED);
 }
 
 int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index aa7ff6a46429..c1fb071eed9b 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1623,19 +1623,23 @@ void sock_map_close(struct sock *sk, long timeout)
 
 	lock_sock(sk);
 	rcu_read_lock();
-	psock = sk_psock_get(sk);
-	if (unlikely(!psock)) {
-		rcu_read_unlock();
-		release_sock(sk);
-		saved_close = READ_ONCE(sk->sk_prot)->close;
-	} else {
+	psock = sk_psock(sk);
+	if (likely(psock)) {
 		saved_close = psock->saved_close;
 		sock_map_remove_links(sk, psock);
+		psock = sk_psock_get(sk);
+		if (unlikely(!psock))
+			goto no_psock;
 		rcu_read_unlock();
 		sk_psock_stop(psock);
 		release_sock(sk);
 		cancel_delayed_work_sync(&psock->work);
 		sk_psock_put(sk, psock);
+	} else {
+		saved_close = READ_ONCE(sk->sk_prot)->close;
+no_psock:
+		rcu_read_unlock();
+		release_sock(sk);
 	}
 
 	/* Make sure we do not recurse. This is a bug.
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3447a09ee83a..2d4f697d338f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2758,6 +2758,10 @@ void tcp_set_state(struct sock *sk, int state)
 		if (oldstate != TCP_ESTABLISHED)
 			TCP_INC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
 		break;
+	case TCP_CLOSE_WAIT:
+		if (oldstate == TCP_SYN_RECV)
+			TCP_INC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
+		break;
 
 	case TCP_CLOSE:
 		if (oldstate == TCP_CLOSE_WAIT || oldstate == TCP_ESTABLISHED)
@@ -2769,7 +2773,7 @@ void tcp_set_state(struct sock *sk, int state)
 			inet_put_port(sk);
 		fallthrough;
 	default:
-		if (oldstate == TCP_ESTABLISHED)
+		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			TCP_DEC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
 	}
 
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index f6f5b83dd954..a5cfc5b0b206 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -351,9 +351,9 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		goto drop;
 
 	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
-		preempt_disable();
+		local_bh_disable();
 		dst = dst_cache_get(&ilwt->cache);
-		preempt_enable();
+		local_bh_enable();
 
 		if (unlikely(!dst)) {
 			struct ipv6hdr *hdr = ipv6_hdr(skb);
@@ -373,9 +373,9 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 				goto drop;
 			}
 
-			preempt_disable();
+			local_bh_disable();
 			dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
-			preempt_enable();
+			local_bh_enable();
 		}
 
 		skb_dst_drop(skb);
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 8213626434b9..1123594ad2be 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -962,6 +962,7 @@ static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_nh,
 	if (!fib6_nh->rt6i_pcpu)
 		return;
 
+	rcu_read_lock();
 	/* release the reference to this fib entry from
 	 * all of its cached pcpu routes
 	 */
@@ -970,7 +971,9 @@ static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_nh,
 		struct rt6_info *pcpu_rt;
 
 		ppcpu_rt = per_cpu_ptr(fib6_nh->rt6i_pcpu, cpu);
-		pcpu_rt = *ppcpu_rt;
+
+		/* Paired with xchg() in rt6_get_pcpu_route() */
+		pcpu_rt = READ_ONCE(*ppcpu_rt);
 
 		/* only dropping the 'from' reference if the cached route
 		 * is using 'match'. The cached pcpu_rt->from only changes
@@ -984,6 +987,7 @@ static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_nh,
 			fib6_info_release(from);
 		}
 	}
+	rcu_read_unlock();
 }
 
 struct fib6_nh_pcpu_arg {
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 258e87055836..d305051e8ab5 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1401,6 +1401,7 @@ static struct rt6_info *rt6_get_pcpu_route(const struct fib6_result *res)
 		struct rt6_info *prev, **p;
 
 		p = this_cpu_ptr(res->nh->rt6i_pcpu);
+		/* Paired with READ_ONCE() in __fib6_drop_pcpu_from() */
 		prev = xchg(p, NULL);
 		if (prev) {
 			dst_dev_put(&prev->dst);
@@ -6334,12 +6335,12 @@ static int ipv6_sysctl_rtcache_flush(struct ctl_table *ctl, int write,
 	if (!write)
 		return -EINVAL;
 
-	net = (struct net *)ctl->extra1;
-	delay = net->ipv6.sysctl.flush_delay;
 	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
 	if (ret)
 		return ret;
 
+	net = (struct net *)ctl->extra1;
+	delay = net->ipv6.sysctl.flush_delay;
 	fib6_run_gc(delay <= 0 ? 0 : (unsigned long)delay, net, delay > 0);
 	return 0;
 }
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 5924407b87b0..ae5299c277bc 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -464,9 +464,8 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
-	preempt_enable();
 
 	skb_dst_drop(skb);
 
@@ -474,14 +473,13 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
 		if (!dst->error) {
-			preempt_disable();
 			dst_cache_set_ip6(&slwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
-			preempt_enable();
 		}
 	} else {
 		skb_dst_set(skb, dst);
 	}
+	local_bh_enable();
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 	if (unlikely(err))
@@ -537,9 +535,9 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
-	preempt_enable();
+	local_bh_enable();
 
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
@@ -559,9 +557,9 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 			goto drop;
 		}
 
-		preempt_disable();
+		local_bh_disable();
 		dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
-		preempt_enable();
+		local_bh_enable();
 	}
 
 	skb_dst_drop(skb);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index ba9a22db5805..4b0e05349862 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1291,7 +1291,6 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	 */
 
 	newsk->sk_gso_type = SKB_GSO_TCPV6;
-	ip6_dst_store(newsk, dst, NULL, NULL);
 	inet6_sk_rx_dst_set(newsk, skb);
 
 	inet_sk(newsk)->pinet6 = tcp_inet6_sk(newsk);
@@ -1302,6 +1301,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 
+	ip6_dst_store(newsk, dst, NULL, NULL);
+
 	newsk->sk_v6_daddr = ireq->ir_v6_rmt_addr;
 	newnp->saddr = ireq->ir_v6_loc_addr;
 	newsk->sk_v6_rcv_saddr = ireq->ir_v6_loc_addr;
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 0322abae0825..147ff0f71b9b 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -231,15 +231,21 @@ ieee80211_he_spr_ie_to_bss_conf(struct ieee80211_vif *vif,
 
 	if (!he_spr_ie_elem)
 		return;
+
+	he_obss_pd->sr_ctrl = he_spr_ie_elem->he_sr_control;
 	data = he_spr_ie_elem->optional;
 
 	if (he_spr_ie_elem->he_sr_control &
 	    IEEE80211_HE_SPR_NON_SRG_OFFSET_PRESENT)
-		data++;
+		he_obss_pd->non_srg_max_offset = *data++;
+
 	if (he_spr_ie_elem->he_sr_control &
 	    IEEE80211_HE_SPR_SRG_INFORMATION_PRESENT) {
-		he_obss_pd->max_offset = *data++;
 		he_obss_pd->min_offset = *data++;
+		he_obss_pd->max_offset = *data++;
+		memcpy(he_obss_pd->bss_color_bitmap, data, 8);
+		data += 8;
+		memcpy(he_obss_pd->partial_bssid_bitmap, data, 8);
 		he_obss_pd->enable = true;
 	}
 }
diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 69d5e1ec6ede..e7b9dcf30adc 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -723,10 +723,23 @@ void mesh_path_discard_frame(struct ieee80211_sub_if_data *sdata,
  */
 void mesh_path_flush_pending(struct mesh_path *mpath)
 {
+	struct ieee80211_sub_if_data *sdata = mpath->sdata;
+	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct mesh_preq_queue *preq, *tmp;
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&mpath->frame_queue)) != NULL)
 		mesh_path_discard_frame(mpath->sdata, skb);
+
+	spin_lock_bh(&ifmsh->mesh_preq_queue_lock);
+	list_for_each_entry_safe(preq, tmp, &ifmsh->preq_queue.list, list) {
+		if (ether_addr_equal(mpath->dst, preq->dst)) {
+			list_del(&preq->list);
+			kfree(preq);
+			--ifmsh->preq_queue_len;
+		}
+	}
+	spin_unlock_bh(&ifmsh->mesh_preq_queue_lock);
 }
 
 /**
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index bd56015b2925..f388b3953174 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1555,7 +1555,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 	skb_queue_head_init(&pending);
 
 	/* sync with ieee80211_tx_h_unicast_ps_buf */
-	spin_lock(&sta->ps_lock);
+	spin_lock_bh(&sta->ps_lock);
 	/* Send all buffered frames to the station */
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
 		int count = skb_queue_len(&pending), tmp;
@@ -1584,7 +1584,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 	 */
 	clear_sta_flag(sta, WLAN_STA_PSPOLL);
 	clear_sta_flag(sta, WLAN_STA_UAPSD);
-	spin_unlock(&sta->ps_lock);
+	spin_unlock_bh(&sta->ps_lock);
 
 	atomic_dec(&ps->num_sta_ps);
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3328870b0c1f..3e2cbf0e6ce9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -685,6 +685,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
 	unsigned int subflows_max;
+	bool sf_created = false;
 	int i, nr;
 
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
@@ -710,15 +711,18 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	 */
 	nr = fill_local_addresses_vec(msk, addrs);
 
-	msk->pm.add_addr_accepted++;
-	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
-	    msk->pm.subflows >= subflows_max)
-		WRITE_ONCE(msk->pm.accept_addr, false);
-
 	spin_unlock_bh(&msk->pm.lock);
 	for (i = 0; i < nr; i++)
-		__mptcp_subflow_connect(sk, &addrs[i], &remote);
+		if (__mptcp_subflow_connect(sk, &addrs[i], &remote) == 0)
+			sf_created = true;
 	spin_lock_bh(&msk->pm.lock);
+
+	if (sf_created) {
+		msk->pm.add_addr_accepted++;
+		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
+		    msk->pm.subflows >= subflows_max)
+			WRITE_ONCE(msk->pm.accept_addr, false);
+	}
 }
 
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
@@ -820,10 +824,13 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			spin_lock_bh(&msk->pm.lock);
 
 			removed = true;
-			__MPTCP_INC_STATS(sock_net(sk), rm_type);
+			if (rm_type == MPTCP_MIB_RMSUBFLOW)
+				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
 		if (rm_type == MPTCP_MIB_RMSUBFLOW)
 			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
+		else if (rm_type == MPTCP_MIB_RMADDR)
+			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		if (!removed)
 			continue;
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b6815610a6fa..d6f3e1b9e844 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3757,6 +3757,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
 	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
+	WRITE_ONCE(msk->snd_una, subflow->idsn);
 	if (likely(!__mptcp_check_fallback(msk)))
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
 
diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 374412ed780b..ef0f8f73826f 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -325,6 +325,7 @@ struct ncsi_dev_priv {
 	spinlock_t          lock;            /* Protect the NCSI device    */
 	unsigned int        package_probe_id;/* Current ID during probe    */
 	unsigned int        package_num;     /* Number of packages         */
+	unsigned int        channel_probe_id;/* Current cahnnel ID during probe */
 	struct list_head    packages;        /* List of packages           */
 	struct ncsi_channel *hot_channel;    /* Channel was ever active    */
 	struct ncsi_request requests[256];   /* Request table              */
@@ -343,6 +344,7 @@ struct ncsi_dev_priv {
 	bool                multi_package;   /* Enable multiple packages   */
 	bool                mlx_multi_host;  /* Enable multi host Mellanox */
 	u32                 package_whitelist; /* Packages to configure    */
+	unsigned char       channel_count;     /* Num of channels to probe   */
 };
 
 struct ncsi_cmd_arg {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 80713febfac6..760b33fa03a8 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -510,17 +510,19 @@ static void ncsi_suspend_channel(struct ncsi_dev_priv *ndp)
 
 		break;
 	case ncsi_dev_state_suspend_gls:
-		ndp->pending_req_num = np->channel_num;
+		ndp->pending_req_num = 1;
 
 		nca.type = NCSI_PKT_CMD_GLS;
 		nca.package = np->id;
+		nca.channel = ndp->channel_probe_id;
+		ret = ncsi_xmit_cmd(&nca);
+		if (ret)
+			goto error;
+		ndp->channel_probe_id++;
 
-		nd->state = ncsi_dev_state_suspend_dcnt;
-		NCSI_FOR_EACH_CHANNEL(np, nc) {
-			nca.channel = nc->id;
-			ret = ncsi_xmit_cmd(&nca);
-			if (ret)
-				goto error;
+		if (ndp->channel_probe_id == ndp->channel_count) {
+			ndp->channel_probe_id = 0;
+			nd->state = ncsi_dev_state_suspend_dcnt;
 		}
 
 		break;
@@ -689,8 +691,6 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_KEEP_PHY)
-
 static int ncsi_oem_keep_phy_intel(struct ncsi_cmd_arg *nca)
 {
 	unsigned char data[NCSI_OEM_INTEL_CMD_KEEP_PHY_LEN];
@@ -716,10 +716,6 @@ static int ncsi_oem_keep_phy_intel(struct ncsi_cmd_arg *nca)
 	return ret;
 }
 
-#endif
-
-#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
-
 /* NCSI OEM Command APIs */
 static int ncsi_oem_gma_handler_bcm(struct ncsi_cmd_arg *nca)
 {
@@ -856,8 +852,6 @@ static int ncsi_gma_handler(struct ncsi_cmd_arg *nca, unsigned int mf_id)
 	return nch->handler(nca);
 }
 
-#endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
-
 /* Determine if a given channel from the channel_queue should be used for Tx */
 static bool ncsi_channel_is_tx(struct ncsi_dev_priv *ndp,
 			       struct ncsi_channel *nc)
@@ -1039,20 +1033,18 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			goto error;
 		}
 
-		nd->state = ncsi_dev_state_config_oem_gma;
+		nd->state = IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
+			  ? ncsi_dev_state_config_oem_gma
+			  : ncsi_dev_state_config_clear_vids;
 		break;
 	case ncsi_dev_state_config_oem_gma:
 		nd->state = ncsi_dev_state_config_clear_vids;
-		ret = -1;
 
-#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
 		nca.type = NCSI_PKT_CMD_OEM;
 		nca.package = np->id;
 		nca.channel = nc->id;
 		ndp->pending_req_num = 1;
 		ret = ncsi_gma_handler(&nca, nc->version.mf_id);
-#endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
-
 		if (ret < 0)
 			schedule_work(&ndp->work);
 
@@ -1350,7 +1342,6 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 {
 	struct ncsi_dev *nd = &ndp->ndev;
 	struct ncsi_package *np;
-	struct ncsi_channel *nc;
 	struct ncsi_cmd_arg nca;
 	unsigned char index;
 	int ret;
@@ -1404,7 +1395,6 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 
 		schedule_work(&ndp->work);
 		break;
-#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
 	case ncsi_dev_state_probe_mlx_gma:
 		ndp->pending_req_num = 1;
 
@@ -1429,25 +1419,6 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 
 		nd->state = ncsi_dev_state_probe_cis;
 		break;
-#endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
-	case ncsi_dev_state_probe_cis:
-		ndp->pending_req_num = NCSI_RESERVED_CHANNEL;
-
-		/* Clear initial state */
-		nca.type = NCSI_PKT_CMD_CIS;
-		nca.package = ndp->active_package->id;
-		for (index = 0; index < NCSI_RESERVED_CHANNEL; index++) {
-			nca.channel = index;
-			ret = ncsi_xmit_cmd(&nca);
-			if (ret)
-				goto error;
-		}
-
-		nd->state = ncsi_dev_state_probe_gvi;
-		if (IS_ENABLED(CONFIG_NCSI_OEM_CMD_KEEP_PHY))
-			nd->state = ncsi_dev_state_probe_keep_phy;
-		break;
-#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_KEEP_PHY)
 	case ncsi_dev_state_probe_keep_phy:
 		ndp->pending_req_num = 1;
 
@@ -1460,15 +1431,17 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 
 		nd->state = ncsi_dev_state_probe_gvi;
 		break;
-#endif /* CONFIG_NCSI_OEM_CMD_KEEP_PHY */
+	case ncsi_dev_state_probe_cis:
 	case ncsi_dev_state_probe_gvi:
 	case ncsi_dev_state_probe_gc:
 	case ncsi_dev_state_probe_gls:
 		np = ndp->active_package;
-		ndp->pending_req_num = np->channel_num;
+		ndp->pending_req_num = 1;
 
-		/* Retrieve version, capability or link status */
-		if (nd->state == ncsi_dev_state_probe_gvi)
+		/* Clear initial state Retrieve version, capability or link status */
+		if (nd->state == ncsi_dev_state_probe_cis)
+			nca.type = NCSI_PKT_CMD_CIS;
+		else if (nd->state == ncsi_dev_state_probe_gvi)
 			nca.type = NCSI_PKT_CMD_GVI;
 		else if (nd->state == ncsi_dev_state_probe_gc)
 			nca.type = NCSI_PKT_CMD_GC;
@@ -1476,19 +1449,29 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 			nca.type = NCSI_PKT_CMD_GLS;
 
 		nca.package = np->id;
-		NCSI_FOR_EACH_CHANNEL(np, nc) {
-			nca.channel = nc->id;
-			ret = ncsi_xmit_cmd(&nca);
-			if (ret)
-				goto error;
-		}
+		nca.channel = ndp->channel_probe_id;
+
+		ret = ncsi_xmit_cmd(&nca);
+		if (ret)
+			goto error;
 
-		if (nd->state == ncsi_dev_state_probe_gvi)
+		if (nd->state == ncsi_dev_state_probe_cis) {
+			nd->state = ncsi_dev_state_probe_gvi;
+			if (IS_ENABLED(CONFIG_NCSI_OEM_CMD_KEEP_PHY) && ndp->channel_probe_id == 0)
+				nd->state = ncsi_dev_state_probe_keep_phy;
+		} else if (nd->state == ncsi_dev_state_probe_gvi) {
 			nd->state = ncsi_dev_state_probe_gc;
-		else if (nd->state == ncsi_dev_state_probe_gc)
+		} else if (nd->state == ncsi_dev_state_probe_gc) {
 			nd->state = ncsi_dev_state_probe_gls;
-		else
+		} else {
+			nd->state = ncsi_dev_state_probe_cis;
+			ndp->channel_probe_id++;
+		}
+
+		if (ndp->channel_probe_id == ndp->channel_count) {
+			ndp->channel_probe_id = 0;
 			nd->state = ncsi_dev_state_probe_dp;
+		}
 		break;
 	case ncsi_dev_state_probe_dp:
 		ndp->pending_req_num = 1;
@@ -1789,6 +1772,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 		ndp->requests[i].ndp = ndp;
 		timer_setup(&ndp->requests[i].timer, ncsi_request_timeout, 0);
 	}
+	ndp->channel_count = NCSI_RESERVED_CHANNEL;
 
 	spin_lock_irqsave(&ncsi_dev_lock, flags);
 	list_add_tail_rcu(&ndp->node, &ncsi_dev_list);
@@ -1822,6 +1806,7 @@ int ncsi_start_dev(struct ncsi_dev *nd)
 
 	if (!(ndp->flags & NCSI_DEV_PROBED)) {
 		ndp->package_probe_id = 0;
+		ndp->channel_probe_id = 0;
 		nd->state = ncsi_dev_state_probe;
 		schedule_work(&ndp->work);
 		return 0;
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 480e80e3c283..f22d67cb04d3 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -795,12 +795,13 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
 	struct ncsi_rsp_gc_pkt *rsp;
 	struct ncsi_dev_priv *ndp = nr->ndp;
 	struct ncsi_channel *nc;
+	struct ncsi_package *np;
 	size_t size;
 
 	/* Find the channel */
 	rsp = (struct ncsi_rsp_gc_pkt *)skb_network_header(nr->rsp);
 	ncsi_find_package_and_channel(ndp, rsp->rsp.common.channel,
-				      NULL, &nc);
+				      &np, &nc);
 	if (!nc)
 		return -ENODEV;
 
@@ -835,6 +836,7 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
 	 */
 	nc->vlan_filter.bitmap = U64_MAX;
 	nc->vlan_filter.n_vids = rsp->vlan_cnt;
+	np->ndp->channel_count = rsp->channel_cnt;
 
 	return 0;
 }
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index f645da82d826..649b8a5901e3 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1174,23 +1174,50 @@ ip_set_setname_policy[IPSET_ATTR_CMD_MAX + 1] = {
 				    .len = IPSET_MAXNAMELEN - 1 },
 };
 
+/* In order to return quickly when destroying a single set, it is split
+ * into two stages:
+ * - Cancel garbage collector
+ * - Destroy the set itself via call_rcu()
+ */
+
 static void
-ip_set_destroy_set(struct ip_set *set)
+ip_set_destroy_set_rcu(struct rcu_head *head)
 {
-	pr_debug("set: %s\n",  set->name);
+	struct ip_set *set = container_of(head, struct ip_set, rcu);
 
-	/* Must call it without holding any lock */
 	set->variant->destroy(set);
 	module_put(set->type->me);
 	kfree(set);
 }
 
 static void
-ip_set_destroy_set_rcu(struct rcu_head *head)
+_destroy_all_sets(struct ip_set_net *inst)
 {
-	struct ip_set *set = container_of(head, struct ip_set, rcu);
+	struct ip_set *set;
+	ip_set_id_t i;
+	bool need_wait = false;
 
-	ip_set_destroy_set(set);
+	/* First cancel gc's: set:list sets are flushed as well */
+	for (i = 0; i < inst->ip_set_max; i++) {
+		set = ip_set(inst, i);
+		if (set) {
+			set->variant->cancel_gc(set);
+			if (set->type->features & IPSET_TYPE_NAME)
+				need_wait = true;
+		}
+	}
+	/* Must wait for flush to be really finished  */
+	if (need_wait)
+		rcu_barrier();
+	for (i = 0; i < inst->ip_set_max; i++) {
+		set = ip_set(inst, i);
+		if (set) {
+			ip_set(inst, i) = NULL;
+			set->variant->destroy(set);
+			module_put(set->type->me);
+			kfree(set);
+		}
+	}
 }
 
 static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
@@ -1204,11 +1231,10 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 	if (unlikely(protocol_min_failed(attr)))
 		return -IPSET_ERR_PROTOCOL;
 
-
 	/* Commands are serialized and references are
 	 * protected by the ip_set_ref_lock.
 	 * External systems (i.e. xt_set) must call
-	 * ip_set_put|get_nfnl_* functions, that way we
+	 * ip_set_nfnl_get_* functions, that way we
 	 * can safely check references here.
 	 *
 	 * list:set timer can only decrement the reference
@@ -1216,8 +1242,6 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 	 * without holding the lock.
 	 */
 	if (!attr[IPSET_ATTR_SETNAME]) {
-		/* Must wait for flush to be really finished in list:set */
-		rcu_barrier();
 		read_lock_bh(&ip_set_ref_lock);
 		for (i = 0; i < inst->ip_set_max; i++) {
 			s = ip_set(inst, i);
@@ -1228,15 +1252,7 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 		}
 		inst->is_destroyed = true;
 		read_unlock_bh(&ip_set_ref_lock);
-		for (i = 0; i < inst->ip_set_max; i++) {
-			s = ip_set(inst, i);
-			if (s) {
-				ip_set(inst, i) = NULL;
-				/* Must cancel garbage collectors */
-				s->variant->cancel_gc(s);
-				ip_set_destroy_set(s);
-			}
-		}
+		_destroy_all_sets(inst);
 		/* Modified by ip_set_destroy() only, which is serialized */
 		inst->is_destroyed = false;
 	} else {
@@ -1257,12 +1273,12 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 		features = s->type->features;
 		ip_set(inst, i) = NULL;
 		read_unlock_bh(&ip_set_ref_lock);
+		/* Must cancel garbage collectors */
+		s->variant->cancel_gc(s);
 		if (features & IPSET_TYPE_NAME) {
 			/* Must wait for flush to be really finished  */
 			rcu_barrier();
 		}
-		/* Must cancel garbage collectors */
-		s->variant->cancel_gc(s);
 		call_rcu(&s->rcu, ip_set_destroy_set_rcu);
 	}
 	return 0;
@@ -2367,30 +2383,25 @@ ip_set_net_init(struct net *net)
 }
 
 static void __net_exit
-ip_set_net_exit(struct net *net)
+ip_set_net_pre_exit(struct net *net)
 {
 	struct ip_set_net *inst = ip_set_pernet(net);
 
-	struct ip_set *set = NULL;
-	ip_set_id_t i;
-
 	inst->is_deleted = true; /* flag for ip_set_nfnl_put */
+}
 
-	nfnl_lock(NFNL_SUBSYS_IPSET);
-	for (i = 0; i < inst->ip_set_max; i++) {
-		set = ip_set(inst, i);
-		if (set) {
-			ip_set(inst, i) = NULL;
-			set->variant->cancel_gc(set);
-			ip_set_destroy_set(set);
-		}
-	}
-	nfnl_unlock(NFNL_SUBSYS_IPSET);
+static void __net_exit
+ip_set_net_exit(struct net *net)
+{
+	struct ip_set_net *inst = ip_set_pernet(net);
+
+	_destroy_all_sets(inst);
 	kvfree(rcu_dereference_protected(inst->ip_set_list, 1));
 }
 
 static struct pernet_operations ip_set_net_ops = {
 	.init	= ip_set_net_init,
+	.pre_exit = ip_set_net_pre_exit,
 	.exit   = ip_set_net_exit,
 	.id	= &ip_set_net_id,
 	.size	= sizeof(struct ip_set_net),
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index 6bc7019982b0..e839c356bcb5 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -79,7 +79,7 @@ list_set_kadd(struct ip_set *set, const struct sk_buff *skb,
 	struct set_elem *e;
 	int ret;
 
-	list_for_each_entry(e, &map->members, list) {
+	list_for_each_entry_rcu(e, &map->members, list) {
 		if (SET_WITH_TIMEOUT(set) &&
 		    ip_set_timeout_expired(ext_timeout(e, set)))
 			continue;
@@ -99,7 +99,7 @@ list_set_kdel(struct ip_set *set, const struct sk_buff *skb,
 	struct set_elem *e;
 	int ret;
 
-	list_for_each_entry(e, &map->members, list) {
+	list_for_each_entry_rcu(e, &map->members, list) {
 		if (SET_WITH_TIMEOUT(set) &&
 		    ip_set_timeout_expired(ext_timeout(e, set)))
 			continue;
@@ -188,9 +188,10 @@ list_set_utest(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	struct list_set *map = set->data;
 	struct set_adt_elem *d = value;
 	struct set_elem *e, *next, *prev = NULL;
-	int ret;
+	int ret = 0;
 
-	list_for_each_entry(e, &map->members, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(e, &map->members, list) {
 		if (SET_WITH_TIMEOUT(set) &&
 		    ip_set_timeout_expired(ext_timeout(e, set)))
 			continue;
@@ -201,6 +202,7 @@ list_set_utest(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 
 		if (d->before == 0) {
 			ret = 1;
+			goto out;
 		} else if (d->before > 0) {
 			next = list_next_entry(e, list);
 			ret = !list_is_last(&e->list, &map->members) &&
@@ -208,9 +210,11 @@ list_set_utest(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 		} else {
 			ret = prev && prev->id == d->refid;
 		}
-		return ret;
+		goto out;
 	}
-	return 0;
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 static void
@@ -239,7 +243,7 @@ list_set_uadd(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 
 	/* Find where to add the new entry */
 	n = prev = next = NULL;
-	list_for_each_entry(e, &map->members, list) {
+	list_for_each_entry_rcu(e, &map->members, list) {
 		if (SET_WITH_TIMEOUT(set) &&
 		    ip_set_timeout_expired(ext_timeout(e, set)))
 			continue;
@@ -316,9 +320,9 @@ list_set_udel(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 {
 	struct list_set *map = set->data;
 	struct set_adt_elem *d = value;
-	struct set_elem *e, *next, *prev = NULL;
+	struct set_elem *e, *n, *next, *prev = NULL;
 
-	list_for_each_entry(e, &map->members, list) {
+	list_for_each_entry_safe(e, n, &map->members, list) {
 		if (SET_WITH_TIMEOUT(set) &&
 		    ip_set_timeout_expired(ext_timeout(e, set)))
 			continue;
@@ -424,14 +428,8 @@ static void
 list_set_destroy(struct ip_set *set)
 {
 	struct list_set *map = set->data;
-	struct set_elem *e, *n;
 
-	list_for_each_entry_safe(e, n, &map->members, list) {
-		list_del(&e->list);
-		ip_set_put_byindex(map->net, e->id);
-		ip_set_ext_destroy(set, e);
-		kfree(e);
-	}
+	WARN_ON_ONCE(!list_empty(&map->members));
 	kfree(map);
 
 	set->data = NULL;
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 75c9c860182b..0d6649d937c9 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -185,7 +185,7 @@ static int multiq_tune(struct Qdisc *sch, struct nlattr *opt,
 
 	qopt->bands = qdisc_dev(sch)->real_num_tx_queues;
 
-	removed = kmalloc(sizeof(*removed) * (q->max_bands - q->bands),
+	removed = kmalloc(sizeof(*removed) * (q->max_bands - qopt->bands),
 			  GFP_KERNEL);
 	if (!removed)
 		return -ENOMEM;
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1d4638aa4254..41187bbd25ee 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -938,16 +938,13 @@ static int taprio_parse_mqprio_opt(struct net_device *dev,
 {
 	int i, j;
 
-	if (!qopt && !dev->num_tc) {
-		NL_SET_ERR_MSG(extack, "'mqprio' configuration is necessary");
-		return -EINVAL;
-	}
-
-	/* If num_tc is already set, it means that the user already
-	 * configured the mqprio part
-	 */
-	if (dev->num_tc)
+	if (!qopt) {
+		if (!dev->num_tc) {
+			NL_SET_ERR_MSG(extack, "'mqprio' configuration is necessary");
+			return -EINVAL;
+		}
 		return 0;
+	}
 
 	/* Verify num_tc is not out of max range */
 	if (qopt->num_tc > TC_MAX_QUEUE) {
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b6609527dff6..e86db21fef6e 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -462,29 +462,11 @@ static int smc_bind(struct socket *sock, struct sockaddr *uaddr,
 static void smc_adjust_sock_bufsizes(struct sock *nsk, struct sock *osk,
 				     unsigned long mask)
 {
-	struct net *nnet = sock_net(nsk);
-
 	nsk->sk_userlocks = osk->sk_userlocks;
-	if (osk->sk_userlocks & SOCK_SNDBUF_LOCK) {
+	if (osk->sk_userlocks & SOCK_SNDBUF_LOCK)
 		nsk->sk_sndbuf = osk->sk_sndbuf;
-	} else {
-		if (mask == SK_FLAGS_SMC_TO_CLC)
-			WRITE_ONCE(nsk->sk_sndbuf,
-				   READ_ONCE(nnet->ipv4.sysctl_tcp_wmem[1]));
-		else
-			WRITE_ONCE(nsk->sk_sndbuf,
-				   2 * READ_ONCE(nnet->smc.sysctl_wmem));
-	}
-	if (osk->sk_userlocks & SOCK_RCVBUF_LOCK) {
+	if (osk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		nsk->sk_rcvbuf = osk->sk_rcvbuf;
-	} else {
-		if (mask == SK_FLAGS_SMC_TO_CLC)
-			WRITE_ONCE(nsk->sk_rcvbuf,
-				   READ_ONCE(nnet->ipv4.sysctl_tcp_rmem[1]));
-		else
-			WRITE_ONCE(nsk->sk_rcvbuf,
-				   2 * READ_ONCE(nnet->smc.sysctl_rmem));
-	}
 }
 
 static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 2d7b1e03110a..3ef511d7af19 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1858,8 +1858,10 @@ gss_wrap_req_priv(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
 	offset = (u8 *)p - (u8 *)snd_buf->head[0].iov_base;
 	maj_stat = gss_wrap(ctx->gc_gss_ctx, offset, snd_buf, inpages);
 	/* slack space should prevent this ever happening: */
-	if (unlikely(snd_buf->len > snd_buf->buflen))
+	if (unlikely(snd_buf->len > snd_buf->buflen)) {
+		status = -EIO;
 		goto wrap_failed;
+	}
 	/* We're assuming that when GSS_S_CONTEXT_EXPIRED, the encryption was
 	 * done anyway, so it's safe to put the request on the wire: */
 	if (maj_stat == GSS_S_CONTEXT_EXPIRED)
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 7d2a3b42b456..3905cdcaa518 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -221,15 +221,9 @@ static inline int unix_may_send(struct sock *sk, struct sock *osk)
 	return unix_peer(osk) == NULL || unix_our_peer(sk, osk);
 }
 
-static inline int unix_recvq_full(const struct sock *sk)
-{
-	return skb_queue_len(&sk->sk_receive_queue) > sk->sk_max_ack_backlog;
-}
-
 static inline int unix_recvq_full_lockless(const struct sock *sk)
 {
-	return skb_queue_len_lockless(&sk->sk_receive_queue) >
-		READ_ONCE(sk->sk_max_ack_backlog);
+	return skb_queue_len_lockless(&sk->sk_receive_queue) > sk->sk_max_ack_backlog;
 }
 
 struct sock *unix_peer_get(struct sock *s)
@@ -518,9 +512,9 @@ static int unix_dgram_peer_wake_me(struct sock *sk, struct sock *other)
 	return 0;
 }
 
-static int unix_writable(const struct sock *sk)
+static int unix_writable(const struct sock *sk, unsigned char state)
 {
-	return sk->sk_state != TCP_LISTEN &&
+	return state != TCP_LISTEN &&
 	       (refcount_read(&sk->sk_wmem_alloc) << 2) <= sk->sk_sndbuf;
 }
 
@@ -529,7 +523,7 @@ static void unix_write_space(struct sock *sk)
 	struct socket_wq *wq;
 
 	rcu_read_lock();
-	if (unix_writable(sk)) {
+	if (unix_writable(sk, READ_ONCE(sk->sk_state))) {
 		wq = rcu_dereference(sk->sk_wq);
 		if (skwq_has_sleeper(wq))
 			wake_up_interruptible_sync_poll(&wq->wait,
@@ -554,11 +548,10 @@ static void unix_dgram_disconnected(struct sock *sk, struct sock *other)
 		 * when peer was not connected to us.
 		 */
 		if (!sock_flag(other, SOCK_DEAD) && unix_peer(other) == sk) {
-			other->sk_err = ECONNRESET;
+			WRITE_ONCE(other->sk_err, ECONNRESET);
 			sk_error_report(other);
 		}
 	}
-	other->sk_state = TCP_CLOSE;
 }
 
 static void unix_sock_destructor(struct sock *sk)
@@ -605,7 +598,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
 	state = sk->sk_state;
-	sk->sk_state = TCP_CLOSE;
+	WRITE_ONCE(sk->sk_state, TCP_CLOSE);
 
 	skpair = unix_peer(sk);
 	unix_peer(sk) = NULL;
@@ -626,8 +619,8 @@ static void unix_release_sock(struct sock *sk, int embrion)
 			unix_state_lock(skpair);
 			/* No more writes */
 			WRITE_ONCE(skpair->sk_shutdown, SHUTDOWN_MASK);
-			if (!skb_queue_empty(&sk->sk_receive_queue) || embrion)
-				skpair->sk_err = ECONNRESET;
+			if (!skb_queue_empty_lockless(&sk->sk_receive_queue) || embrion)
+				WRITE_ONCE(skpair->sk_err, ECONNRESET);
 			unix_state_unlock(skpair);
 			skpair->sk_state_change(skpair);
 			sk_wake_async(skpair, SOCK_WAKE_WAITD, POLL_HUP);
@@ -727,7 +720,8 @@ static int unix_listen(struct socket *sock, int backlog)
 	if (backlog > sk->sk_max_ack_backlog)
 		wake_up_interruptible_all(&u->peer_wait);
 	sk->sk_max_ack_backlog	= backlog;
-	sk->sk_state		= TCP_LISTEN;
+	WRITE_ONCE(sk->sk_state, TCP_LISTEN);
+
 	/* set credentials so connect can copy them */
 	init_peercred(sk);
 	err = 0;
@@ -966,7 +960,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sk->sk_hash		= unix_unbound_hash(sk);
 	sk->sk_allocation	= GFP_KERNEL_ACCOUNT;
 	sk->sk_write_space	= unix_write_space;
-	sk->sk_max_ack_backlog	= net->unx.sysctl_max_dgram_qlen;
+	sk->sk_max_ack_backlog	= READ_ONCE(net->unx.sysctl_max_dgram_qlen);
 	sk->sk_destruct		= unix_sock_destructor;
 	u = unix_sk(sk);
 	u->inflight = 0;
@@ -1390,7 +1384,8 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		if (err)
 			goto out_unlock;
 
-		sk->sk_state = other->sk_state = TCP_ESTABLISHED;
+		WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED);
+		WRITE_ONCE(other->sk_state, TCP_ESTABLISHED);
 	} else {
 		/*
 		 *	1003.1g breaking connected state with AF_UNSPEC
@@ -1407,13 +1402,20 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 
 		unix_peer(sk) = other;
 		if (!other)
-			sk->sk_state = TCP_CLOSE;
+			WRITE_ONCE(sk->sk_state, TCP_CLOSE);
 		unix_dgram_peer_wake_disconnect_wakeup(sk, old_peer);
 
 		unix_state_double_unlock(sk, other);
 
-		if (other != old_peer)
+		if (other != old_peer) {
 			unix_dgram_disconnected(sk, old_peer);
+
+			unix_state_lock(old_peer);
+			if (!unix_peer(old_peer))
+				WRITE_ONCE(old_peer->sk_state, TCP_CLOSE);
+			unix_state_unlock(old_peer);
+		}
+
 		sock_put(old_peer);
 	} else {
 		unix_peer(sk) = other;
@@ -1461,7 +1463,6 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	struct sk_buff *skb = NULL;
 	long timeo;
 	int err;
-	int st;
 
 	err = unix_validate_addr(sunaddr, addr_len);
 	if (err)
@@ -1520,7 +1521,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (other->sk_shutdown & RCV_SHUTDOWN)
 		goto out_unlock;
 
-	if (unix_recvq_full(other)) {
+	if (unix_recvq_full_lockless(other)) {
 		err = -EAGAIN;
 		if (!timeo)
 			goto out_unlock;
@@ -1545,9 +1546,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 	   Well, and we have to recheck the state after socket locked.
 	 */
-	st = sk->sk_state;
-
-	switch (st) {
+	switch (READ_ONCE(sk->sk_state)) {
 	case TCP_CLOSE:
 		/* This is ok... continue with connect */
 		break;
@@ -1562,7 +1561,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 	unix_state_lock_nested(sk, U_LOCK_SECOND);
 
-	if (sk->sk_state != st) {
+	if (sk->sk_state != TCP_CLOSE) {
 		unix_state_unlock(sk);
 		unix_state_unlock(other);
 		sock_put(other);
@@ -1614,7 +1613,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	copy_peercred(sk, other);
 
 	sock->state	= SS_CONNECTED;
-	sk->sk_state	= TCP_ESTABLISHED;
+	WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED);
 	sock_hold(newsk);
 
 	smp_mb__after_atomic();	/* sock_hold() does an atomic_inc() */
@@ -2009,7 +2008,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			unix_peer(sk) = NULL;
 			unix_dgram_peer_wake_disconnect_wakeup(sk, other);
 
-			sk->sk_state = TCP_CLOSE;
+			WRITE_ONCE(sk->sk_state, TCP_CLOSE);
 			unix_state_unlock(sk);
 
 			unix_dgram_disconnected(sk, other);
@@ -2185,7 +2184,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if (msg->msg_namelen) {
-		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
+		err = READ_ONCE(sk->sk_state) == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
 		goto out_err;
 	} else {
 		err = -ENOTCONN;
@@ -2397,7 +2396,7 @@ static int unix_seqpacket_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (err)
 		return err;
 
-	if (sk->sk_state != TCP_ESTABLISHED)
+	if (READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)
 		return -ENOTCONN;
 
 	if (msg->msg_namelen)
@@ -2411,7 +2410,7 @@ static int unix_seqpacket_recvmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 
-	if (sk->sk_state != TCP_ESTABLISHED)
+	if (READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)
 		return -ENOTCONN;
 
 	return unix_dgram_recvmsg(sock, msg, size, flags);
@@ -2683,18 +2682,18 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 		if (skb == u->oob_skb) {
 			if (copied) {
 				skb = NULL;
-			} else if (sock_flag(sk, SOCK_URGINLINE)) {
-				if (!(flags & MSG_PEEK)) {
+			} else if (!(flags & MSG_PEEK)) {
+				if (sock_flag(sk, SOCK_URGINLINE)) {
 					WRITE_ONCE(u->oob_skb, NULL);
 					consume_skb(skb);
+				} else {
+					__skb_unlink(skb, &sk->sk_receive_queue);
+					WRITE_ONCE(u->oob_skb, NULL);
+					unlinked_skb = skb;
+					skb = skb_peek(&sk->sk_receive_queue);
 				}
-			} else if (flags & MSG_PEEK) {
-				skb = NULL;
-			} else {
-				__skb_unlink(skb, &sk->sk_receive_queue);
-				WRITE_ONCE(u->oob_skb, NULL);
-				unlinked_skb = skb;
-				skb = skb_peek(&sk->sk_receive_queue);
+			} else if (!sock_flag(sk, SOCK_URGINLINE)) {
+				skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			}
 		}
 
@@ -2711,7 +2710,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 
 static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
-	if (unlikely(sk->sk_state != TCP_ESTABLISHED))
+	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED))
 		return -ENOTCONN;
 
 	return unix_read_skb(sk, recv_actor);
@@ -2735,7 +2734,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	size_t size = state->size;
 	unsigned int last_len;
 
-	if (unlikely(sk->sk_state != TCP_ESTABLISHED)) {
+	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -3060,7 +3059,7 @@ long unix_inq_len(struct sock *sk)
 	struct sk_buff *skb;
 	long amount = 0;
 
-	if (sk->sk_state == TCP_LISTEN)
+	if (READ_ONCE(sk->sk_state) == TCP_LISTEN)
 		return -EINVAL;
 
 	spin_lock(&sk->sk_receive_queue.lock);
@@ -3172,15 +3171,17 @@ static int unix_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned lon
 static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wait)
 {
 	struct sock *sk = sock->sk;
+	unsigned char state;
 	__poll_t mask;
 	u8 shutdown;
 
 	sock_poll_wait(file, sock, wait);
 	mask = 0;
 	shutdown = READ_ONCE(sk->sk_shutdown);
+	state = READ_ONCE(sk->sk_state);
 
 	/* exceptional events? */
-	if (sk->sk_err)
+	if (READ_ONCE(sk->sk_err))
 		mask |= EPOLLERR;
 	if (shutdown == SHUTDOWN_MASK)
 		mask |= EPOLLHUP;
@@ -3199,14 +3200,14 @@ static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wa
 
 	/* Connection-based need to check for termination and startup */
 	if ((sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET) &&
-	    sk->sk_state == TCP_CLOSE)
+	    state == TCP_CLOSE)
 		mask |= EPOLLHUP;
 
 	/*
 	 * we set writable also when the other side has shut down the
 	 * connection. This prevents stuck sockets.
 	 */
-	if (unix_writable(sk))
+	if (unix_writable(sk, state))
 		mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
 
 	return mask;
@@ -3217,15 +3218,18 @@ static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
 {
 	struct sock *sk = sock->sk, *other;
 	unsigned int writable;
+	unsigned char state;
 	__poll_t mask;
 	u8 shutdown;
 
 	sock_poll_wait(file, sock, wait);
 	mask = 0;
 	shutdown = READ_ONCE(sk->sk_shutdown);
+	state = READ_ONCE(sk->sk_state);
 
 	/* exceptional events? */
-	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR |
 			(sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? EPOLLPRI : 0);
 
@@ -3241,19 +3245,14 @@ static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	/* Connection-based need to check for termination and startup */
-	if (sk->sk_type == SOCK_SEQPACKET) {
-		if (sk->sk_state == TCP_CLOSE)
-			mask |= EPOLLHUP;
-		/* connection hasn't started yet? */
-		if (sk->sk_state == TCP_SYN_SENT)
-			return mask;
-	}
+	if (sk->sk_type == SOCK_SEQPACKET && state == TCP_CLOSE)
+		mask |= EPOLLHUP;
 
 	/* No write status requested, avoid expensive OUT tests. */
 	if (!(poll_requested_events(wait) & (EPOLLWRBAND|EPOLLWRNORM|EPOLLOUT)))
 		return mask;
 
-	writable = unix_writable(sk);
+	writable = unix_writable(sk, state);
 	if (writable) {
 		unix_state_lock(sk);
 
diff --git a/net/unix/diag.c b/net/unix/diag.c
index 3438b7af09af..1de7500b41b6 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -65,7 +65,7 @@ static int sk_diag_dump_icons(struct sock *sk, struct sk_buff *nlskb)
 	u32 *buf;
 	int i;
 
-	if (sk->sk_state == TCP_LISTEN) {
+	if (READ_ONCE(sk->sk_state) == TCP_LISTEN) {
 		spin_lock(&sk->sk_receive_queue.lock);
 
 		attr = nla_reserve(nlskb, UNIX_DIAG_ICONS,
@@ -103,8 +103,8 @@ static int sk_diag_show_rqlen(struct sock *sk, struct sk_buff *nlskb)
 {
 	struct unix_diag_rqlen rql;
 
-	if (sk->sk_state == TCP_LISTEN) {
-		rql.udiag_rqueue = sk->sk_receive_queue.qlen;
+	if (READ_ONCE(sk->sk_state) == TCP_LISTEN) {
+		rql.udiag_rqueue = skb_queue_len_lockless(&sk->sk_receive_queue);
 		rql.udiag_wqueue = sk->sk_max_ack_backlog;
 	} else {
 		rql.udiag_rqueue = (u32) unix_inq_len(sk);
@@ -136,7 +136,7 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb, struct unix_diag_r
 	rep = nlmsg_data(nlh);
 	rep->udiag_family = AF_UNIX;
 	rep->udiag_type = sk->sk_type;
-	rep->udiag_state = sk->sk_state;
+	rep->udiag_state = READ_ONCE(sk->sk_state);
 	rep->pad = 0;
 	rep->udiag_ino = sk_ino;
 	sock_diag_save_cookie(sk, rep->udiag_cookie);
@@ -165,7 +165,7 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb, struct unix_diag_r
 	    sock_diag_put_meminfo(sk, skb, UNIX_DIAG_MEMINFO))
 		goto out_nlmsg_trim;
 
-	if (nla_put_u8(skb, UNIX_DIAG_SHUTDOWN, sk->sk_shutdown))
+	if (nla_put_u8(skb, UNIX_DIAG_SHUTDOWN, READ_ONCE(sk->sk_shutdown)))
 		goto out_nlmsg_trim;
 
 	if ((req->udiag_show & UDIAG_SHOW_UID) &&
@@ -215,7 +215,7 @@ static int unix_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		sk_for_each(sk, &net->unx.table.buckets[slot]) {
 			if (num < s_num)
 				goto next;
-			if (!(req->udiag_states & (1 << sk->sk_state)))
+			if (!(req->udiag_states & (1 << READ_ONCE(sk->sk_state))))
 				goto next;
 			if (sk_diag_dump(sk, skb, req, sk_user_ns(skb->sk),
 					 NETLINK_CB(cb->skb).portid,
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 3fcddc8687ed..22f67b64135d 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -427,7 +427,7 @@ static void cfg80211_wiphy_work(struct work_struct *work)
 	if (wk) {
 		list_del_init(&wk->entry);
 		if (!list_empty(&rdev->wiphy_work_list))
-			schedule_work(work);
+			queue_work(system_unbound_wq, work);
 		spin_unlock_irq(&rdev->wiphy_work_lock);
 
 		wk->func(&rdev->wiphy, wk);
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 2bc647720cda..d26daa0370e7 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -56,7 +56,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	out->ftm.burst_period = 0;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD])
 		out->ftm.burst_period =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD]);
+			nla_get_u16(tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD]);
 
 	out->ftm.asap = !!tb[NL80211_PMSR_FTM_REQ_ATTR_ASAP];
 	if (out->ftm.asap && !capa->ftm.asap) {
@@ -75,7 +75,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	out->ftm.num_bursts_exp = 0;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP])
 		out->ftm.num_bursts_exp =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP]);
+			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP]);
 
 	if (capa->ftm.max_bursts_exponent >= 0 &&
 	    out->ftm.num_bursts_exp > capa->ftm.max_bursts_exponent) {
@@ -88,7 +88,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	out->ftm.burst_duration = 15;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION])
 		out->ftm.burst_duration =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION]);
+			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION]);
 
 	out->ftm.ftms_per_burst = 0;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST])
@@ -107,7 +107,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	out->ftm.ftmr_retries = 3;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES])
 		out->ftm.ftmr_retries =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES]);
+			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES]);
 
 	out->ftm.request_lci = !!tb[NL80211_PMSR_FTM_REQ_ATTR_REQUEST_LCI];
 	if (out->ftm.request_lci && !capa->ftm.request_lci) {
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index a88f338c61d3..17ccb9c6091e 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -5,7 +5,7 @@
  *
  * Copyright 2005-2006	Jiri Benc <jbenc@suse.cz>
  * Copyright 2006	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2020-2021, 2023 Intel Corporation
+ * Copyright (C) 2020-2021, 2023-2024 Intel Corporation
  */
 
 #include <linux/device.h>
@@ -137,7 +137,7 @@ static int wiphy_resume(struct device *dev)
 	if (rdev->wiphy.registered && rdev->ops->resume)
 		ret = rdev_resume(rdev);
 	rdev->suspended = false;
-	schedule_work(&rdev->wiphy_work);
+	queue_work(system_unbound_wq, &rdev->wiphy_work);
 	wiphy_unlock(&rdev->wiphy);
 
 	if (ret)
diff --git a/net/wireless/util.c b/net/wireless/util.c
index f433f3fdd9e9..73b3648e1b4c 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2202,6 +2202,7 @@ int cfg80211_get_station(struct net_device *dev, const u8 *mac_addr,
 {
 	struct cfg80211_registered_device *rdev;
 	struct wireless_dev *wdev;
+	int ret;
 
 	wdev = dev->ieee80211_ptr;
 	if (!wdev)
@@ -2213,7 +2214,11 @@ int cfg80211_get_station(struct net_device *dev, const u8 *mac_addr,
 
 	memset(sinfo, 0, sizeof(*sinfo));
 
-	return rdev_get_station(rdev, dev, mac_addr, sinfo);
+	wiphy_lock(&rdev->wiphy);
+	ret = rdev_get_station(rdev, dev, mac_addr, sinfo);
+	wiphy_unlock(&rdev->wiphy);
+
+	return ret;
 }
 EXPORT_SYMBOL(cfg80211_get_station);
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index d328965f32f7..7b0e5976113c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -824,6 +824,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	bool allow_parent1, allow_parent2;
 	access_mask_t access_request_parent1, access_request_parent2;
 	struct path mnt_dir;
+	struct dentry *old_parent;
 	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS] = {},
 		     layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS] = {};
 
@@ -870,9 +871,17 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	mnt_dir.mnt = new_dir->mnt;
 	mnt_dir.dentry = new_dir->mnt->mnt_root;
 
+	/*
+	 * old_dentry may be the root of the common mount point and
+	 * !IS_ROOT(old_dentry) at the same time (e.g. with open_tree() and
+	 * OPEN_TREE_CLONE).  We do not need to call dget(old_parent) because
+	 * we keep a reference to old_dentry.
+	 */
+	old_parent = (old_dentry == mnt_dir.dentry) ? old_dentry :
+						      old_dentry->d_parent;
+
 	/* new_dir->dentry is equal to new_dentry->d_parent */
-	allow_parent1 = collect_domain_accesses(dom, mnt_dir.dentry,
-						old_dentry->d_parent,
+	allow_parent1 = collect_domain_accesses(dom, mnt_dir.dentry, old_parent,
 						&layer_masks_parent1);
 	allow_parent2 = collect_domain_accesses(
 		dom, mnt_dir.dentry, new_dir->dentry, &layer_masks_parent2);
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index aa2df3a15051..6e9a89f54d94 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -3,6 +3,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/vmalloc.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
index d3a79da215c8..5f72abe6fa79 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - check if duplicate events are caught
-# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README
+# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README events/syscalls/sys_enter_openat
 
 echo 0 > events/enable
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
index 1f6981ef7afa..ba19b81cef39 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
@@ -30,7 +30,8 @@ find_dot_func() {
 	fi
 
 	grep " [tT] .*\.isra\..*" /proc/kallsyms | cut -f 3 -d " " | while read f; do
-		if grep -s $f available_filter_functions; then
+		cnt=`grep -s $f available_filter_functions | wc -l`;
+		if [ $cnt -eq 1 ]; then
 			echo $f
 			break
 		fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 635a1624b47d..51f68bb6bdb8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2343,9 +2343,10 @@ remove_tests()
 	if reset "remove invalid addresses"; then
 		pm_nl_set_limits $ns1 3 3
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
-		pm_nl_set_limits $ns2 3 3
+		pm_nl_set_limits $ns2 2 2
 		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/selftests/vm/compaction_test.c
index 9b420140ba2b..309b3750e57e 100644
--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -33,7 +33,7 @@ int read_memory_info(unsigned long *memfree, unsigned long *hugepagesize)
 	FILE *cmdfile = popen(cmd, "r");
 
 	if (!(fgets(buffer, sizeof(buffer), cmdfile))) {
-		perror("Failed to read meminfo\n");
+		ksft_print_msg("Failed to read meminfo: %s\n", strerror(errno));
 		return -1;
 	}
 
@@ -44,7 +44,7 @@ int read_memory_info(unsigned long *memfree, unsigned long *hugepagesize)
 	cmdfile = popen(cmd, "r");
 
 	if (!(fgets(buffer, sizeof(buffer), cmdfile))) {
-		perror("Failed to read meminfo\n");
+		ksft_print_msg("Failed to read meminfo: %s\n", strerror(errno));
 		return -1;
 	}
 
@@ -62,14 +62,14 @@ int prereq(void)
 	fd = open("/proc/sys/vm/compact_unevictable_allowed",
 		  O_RDONLY | O_NONBLOCK);
 	if (fd < 0) {
-		perror("Failed to open\n"
-		       "/proc/sys/vm/compact_unevictable_allowed\n");
+		ksft_print_msg("Failed to open /proc/sys/vm/compact_unevictable_allowed: %s\n",
+			       strerror(errno));
 		return -1;
 	}
 
 	if (read(fd, &allowed, sizeof(char)) != sizeof(char)) {
-		perror("Failed to read from\n"
-		       "/proc/sys/vm/compact_unevictable_allowed\n");
+		ksft_print_msg("Failed to read from /proc/sys/vm/compact_unevictable_allowed: %s\n",
+			       strerror(errno));
 		close(fd);
 		return -1;
 	}
@@ -78,15 +78,17 @@ int prereq(void)
 	if (allowed == '1')
 		return 0;
 
+	ksft_print_msg("Compaction isn't allowed\n");
 	return -1;
 }
 
-int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
+int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 {
-	int fd;
+	unsigned long nr_hugepages_ul;
+	int fd, ret = -1;
 	int compaction_index = 0;
-	char initial_nr_hugepages[10] = {0};
-	char nr_hugepages[10] = {0};
+	char initial_nr_hugepages[20] = {0};
+	char nr_hugepages[20] = {0};
 
 	/* We want to test with 80% of available memory. Else, OOM killer comes
 	   in to play */
@@ -94,18 +96,24 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 
 	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
 	if (fd < 0) {
-		perror("Failed to open /proc/sys/vm/nr_hugepages");
-		return -1;
+		ksft_print_msg("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
+		ret = -1;
+		goto out;
 	}
 
 	if (read(fd, initial_nr_hugepages, sizeof(initial_nr_hugepages)) <= 0) {
-		perror("Failed to read from /proc/sys/vm/nr_hugepages");
+		ksft_print_msg("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
+	lseek(fd, 0, SEEK_SET);
+
 	/* Start with the initial condition of 0 huge pages*/
 	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
-		perror("Failed to write 0 to /proc/sys/vm/nr_hugepages\n");
+		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
@@ -114,82 +122,82 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 	/* Request a large number of huge pages. The Kernel will allocate
 	   as much as it can */
 	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
-		perror("Failed to write 100000 to /proc/sys/vm/nr_hugepages\n");
+		ksft_print_msg("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
 	lseek(fd, 0, SEEK_SET);
 
 	if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
-		perror("Failed to re-read from /proc/sys/vm/nr_hugepages\n");
+		ksft_print_msg("Failed to re-read from /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
 	/* We should have been able to request at least 1/3 rd of the memory in
 	   huge pages */
-	compaction_index = mem_free/(atoi(nr_hugepages) * hugepage_size);
-
-	if (compaction_index > 3) {
-		printf("No of huge pages allocated = %d\n",
-		       (atoi(nr_hugepages)));
-		fprintf(stderr, "ERROR: Less that 1/%d of memory is available\n"
-			"as huge pages\n", compaction_index);
+	nr_hugepages_ul = strtoul(nr_hugepages, NULL, 10);
+	if (!nr_hugepages_ul) {
+		ksft_print_msg("ERROR: No memory is available as huge pages\n");
 		goto close_fd;
 	}
-
-	printf("No of huge pages allocated = %d\n",
-	       (atoi(nr_hugepages)));
+	compaction_index = mem_free/(nr_hugepages_ul * hugepage_size);
 
 	lseek(fd, 0, SEEK_SET);
 
 	if (write(fd, initial_nr_hugepages, strlen(initial_nr_hugepages))
 	    != strlen(initial_nr_hugepages)) {
-		perror("Failed to write value to /proc/sys/vm/nr_hugepages\n");
+		ksft_print_msg("Failed to write value to /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
-	close(fd);
-	return 0;
+	ksft_print_msg("Number of huge pages allocated = %lu\n",
+		       nr_hugepages_ul);
+
+	if (compaction_index > 3) {
+		ksft_print_msg("ERROR: Less than 1/%d of memory is available\n"
+			       "as huge pages\n", compaction_index);
+		goto close_fd;
+	}
+
+	ret = 0;
 
  close_fd:
 	close(fd);
-	printf("Not OK. Compaction test failed.");
-	return -1;
+ out:
+	ksft_test_result(ret == 0, "check_compaction\n");
+	return ret;
 }
 
 
 int main(int argc, char **argv)
 {
 	struct rlimit lim;
-	struct map_list *list, *entry;
+	struct map_list *list = NULL, *entry;
 	size_t page_size, i;
 	void *map = NULL;
 	unsigned long mem_free = 0;
 	unsigned long hugepage_size = 0;
 	long mem_fragmentable_MB = 0;
 
-	if (prereq() != 0) {
-		printf("Either the sysctl compact_unevictable_allowed is not\n"
-		       "set to 1 or couldn't read the proc file.\n"
-		       "Skipping the test\n");
-		return KSFT_SKIP;
-	}
+	ksft_print_header();
+
+	if (prereq() != 0)
+		return ksft_exit_pass();
+
+	ksft_set_plan(1);
 
 	lim.rlim_cur = RLIM_INFINITY;
 	lim.rlim_max = RLIM_INFINITY;
-	if (setrlimit(RLIMIT_MEMLOCK, &lim)) {
-		perror("Failed to set rlimit:\n");
-		return -1;
-	}
+	if (setrlimit(RLIMIT_MEMLOCK, &lim))
+		ksft_exit_fail_msg("Failed to set rlimit: %s\n", strerror(errno));
 
 	page_size = getpagesize();
 
-	list = NULL;
-
-	if (read_memory_info(&mem_free, &hugepage_size) != 0) {
-		printf("ERROR: Cannot read meminfo\n");
-		return -1;
-	}
+	if (read_memory_info(&mem_free, &hugepage_size) != 0)
+		ksft_exit_fail_msg("Failed to get meminfo\n");
 
 	mem_fragmentable_MB = mem_free * 0.8 / 1024;
 
@@ -225,7 +233,7 @@ int main(int argc, char **argv)
 	}
 
 	if (check_compaction(mem_free, hugepage_size) == 0)
-		return 0;
+		return ksft_exit_pass();
 
-	return -1;
+	return ksft_exit_fail();
 }

