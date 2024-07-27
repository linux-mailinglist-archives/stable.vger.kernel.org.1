Return-Path: <stable+bounces-61960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A38893DE4C
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 11:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83491C21580
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C726959164;
	Sat, 27 Jul 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NMKpFcdt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B196F2E6;
	Sat, 27 Jul 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722073382; cv=none; b=MXTyxMsff2CsrxkENc3qFogRnrhw7aUsSXYMUo/8qIR0HEJ4ygAEkZGt+hXuegCI37XrI0+3lK5aqL6CrhGmLtFeB5uQ70Vw5CfvgfSTmabrS+0I45ZtkhVHqgP62V3gipRTzkxfKXAz4dWcuzD00+dFqg3Zr3CP0/r4JDTPlpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722073382; c=relaxed/simple;
	bh=zQePT+Gm+YIuVrnwaI5Awr9s1RLkooTw7p01KzVURV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCykPBDzZPlMaI3fMTx09DhVyI+Qgl0vMVfzNoYCOhASLHP68+jU5zoJbYVmmyutMzsFYc6wCkU5j3NwjI7Ab0Dd6X5x+CseRoCnYaPjoUaIZ3FUUNe74+wS5ZsryKLFmkWyZHj358bTVvsNkmWkTi47vmax7/RKFF/v6PCJm+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NMKpFcdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEEAC32781;
	Sat, 27 Jul 2024 09:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722073382;
	bh=zQePT+Gm+YIuVrnwaI5Awr9s1RLkooTw7p01KzVURV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NMKpFcdtCDStMPPinYsLAp9Mr51hByNZGoPwUVn0KBa+mBNK+9e2Uvax1CuY59NR2
	 O6Fy7shH3y/oWrhXqGppLR/ypxb/p2FfF8ji51HsjVN5kzknTVLIYHDe2CFy06a1Kz
	 d1ihBJ9BlHIfpVlfH7qDAAatc3ixgZ7zyywRXQxU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.9.12
Date: Sat, 27 Jul 2024 11:42:51 +0200
Message-ID: <2024072750-useable-trillion-7c47@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024072750-gummy-bobbed-8af6@gregkh>
References: <2024072750-gummy-bobbed-8af6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 46457f645921..d9243ad053f9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 9
-SUBLEVEL = 11
+SUBLEVEL = 12
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 4e29adea570a..1ddd31413701 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -685,6 +685,7 @@ dwc_0: usb@8a00000 {
 				clocks = <&xo>;
 				clock-names = "ref";
 				tx-fifo-resize;
+				snps,parkmode-disable-ss-quirk;
 				snps,is-utmi-l1-suspend;
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index e5b89753aa5c..cf04879c6b75 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -647,6 +647,7 @@ dwc_0: usb@8a00000 {
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&qusb_phy_0>, <&ssphy_0>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,parkmode-disable-ss-quirk;
 				snps,is-utmi-l1-suspend;
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;
@@ -696,6 +697,7 @@ dwc_1: usb@8c00000 {
 				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&qusb_phy_1>, <&ssphy_1>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,parkmode-disable-ss-quirk;
 				snps,is-utmi-l1-suspend;
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 1601e46549e7..db668416657c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3061,6 +3061,7 @@ usb3_dwc3: usb@6a00000 {
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
 				snps,is-utmi-l1-suspend;
+				snps,parkmode-disable-ss-quirk;
 				tx-fifo-resize;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 4dfe2d09ac28..240a29ed3526 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2154,6 +2154,7 @@ usb3_dwc3: usb@a800000 {
 				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
+				snps,parkmode-disable-ss-quirk;
 				phys = <&qusb2phy>, <&usb3phy>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,has-lpm-erratum;
diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 6e9dd0312adc..a9ab924d2ed1 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -59,6 +59,17 @@ hdmi_con: endpoint {
 		};
 	};
 
+	i2c2_gpio: i2c {
+		compatible = "i2c-gpio";
+
+		sda-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+		scl-gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		status = "disabled";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -199,7 +210,7 @@ &gpi_dma0 {
 	status = "okay";
 };
 
-&i2c2 {
+&i2c2_gpio {
 	clock-frequency = <400000>;
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 696d6d43c56b..54d17eca9751 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -60,6 +60,17 @@ hdmi_con: endpoint {
 		};
 	};
 
+	i2c2_gpio: i2c {
+		compatible = "i2c-gpio";
+
+		sda-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+		scl-gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		status = "disabled";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -190,7 +201,7 @@ zap-shader {
 	};
 };
 
-&i2c2 {
+&i2c2_gpio {
 	clock-frequency = <400000>;
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 2b481e20ae38..cc93b5675d5d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3063,6 +3063,7 @@ usb_1_dwc3: usb@a600000 {
 				iommus = <&apps_smmu 0x540 0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
+				snps,parkmode-disable-ss-quirk;
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 				maximum-speed = "super-speed";
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 41f51d326111..e0d3eeb6f639 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4131,6 +4131,7 @@ usb_1_dwc3: usb@a600000 {
 				iommus = <&apps_smmu 0xe0 0x0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
+				snps,parkmode-disable-ss-quirk;
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 				maximum-speed = "super-speed";
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index f5921b80ef94..5f6884b2367d 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1302,6 +1302,7 @@ usb3_dwc3: usb@a800000 {
 				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
+				snps,parkmode-disable-ss-quirk;
 
 				phys = <&qusb2phy0>, <&usb3_qmpphy>;
 				phy-names = "usb2-phy", "usb3-phy";
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2f20be99ee7e..9310aa238306 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4086,6 +4086,7 @@ usb_1_dwc3: usb@a600000 {
 				iommus = <&apps_smmu 0x740 0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
+				snps,parkmode-disable-ss-quirk;
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 			};
@@ -4141,6 +4142,7 @@ usb_2_dwc3: usb@a800000 {
 				iommus = <&apps_smmu 0x760 0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
+				snps,parkmode-disable-ss-quirk;
 				phys = <&usb_2_hsphy>, <&usb_2_qmpphy>;
 				phy-names = "usb2-phy", "usb3-phy";
 			};
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 9ed062150aaf..b4ce5a322107 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1656,6 +1656,7 @@ usb_dwc3: usb@4e00000 {
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
 				snps,usb3_lpm_capable;
+				snps,parkmode-disable-ss-quirk;
 
 				usb-role-switch;
 
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 0be053555602..d2b98f400d4f 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1859,6 +1859,7 @@ usb_1_dwc3: usb@a600000 {
 				snps,dis_enblslpm_quirk;
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
+				snps,parkmode-disable-ss-quirk;
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 			};
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index c5442396dcec..a40130ae3eb0 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -657,7 +657,7 @@ &pcie6a {
 };
 
 &pcie6a_phy {
-	vdda-phy-supply = <&vreg_l3j_0p8>;
+	vdda-phy-supply = <&vreg_l1d_0p8>;
 	vdda-pll-supply = <&vreg_l2j_1p2>;
 
 	status = "okay";
@@ -824,12 +824,15 @@ &uart21 {
 
 &usb_1_ss0_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
-	vdda12-supply = <&vreg_l3e_1p2>;
+	vdda12-supply = <&vreg_l2j_1p2>;
 
 	status = "okay";
 };
 
 &usb_1_ss0_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l1j_0p8>;
+
 	status = "okay";
 };
 
@@ -844,12 +847,15 @@ &usb_1_ss0_dwc3 {
 
 &usb_1_ss1_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
-	vdda12-supply = <&vreg_l3e_1p2>;
+	vdda12-supply = <&vreg_l2j_1p2>;
 
 	status = "okay";
 };
 
 &usb_1_ss1_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p9>;
+
 	status = "okay";
 };
 
@@ -864,12 +870,15 @@ &usb_1_ss1_dwc3 {
 
 &usb_1_ss2_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
-	vdda12-supply = <&vreg_l3e_1p2>;
+	vdda12-supply = <&vreg_l2j_1p2>;
 
 	status = "okay";
 };
 
 &usb_1_ss2_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p9>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 49e19a64455b..2dccb98b4437 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -468,7 +468,7 @@ &pcie6a {
 };
 
 &pcie6a_phy {
-	vdda-phy-supply = <&vreg_l3j_0p8>;
+	vdda-phy-supply = <&vreg_l1d_0p8>;
 	vdda-pll-supply = <&vreg_l2j_1p2>;
 
 	status = "okay";
@@ -520,12 +520,15 @@ &uart21 {
 
 &usb_1_ss0_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
-	vdda12-supply = <&vreg_l3e_1p2>;
+	vdda12-supply = <&vreg_l2j_1p2>;
 
 	status = "okay";
 };
 
 &usb_1_ss0_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l1j_0p8>;
+
 	status = "okay";
 };
 
@@ -540,12 +543,15 @@ &usb_1_ss0_dwc3 {
 
 &usb_1_ss1_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
-	vdda12-supply = <&vreg_l3e_1p2>;
+	vdda12-supply = <&vreg_l2j_1p2>;
 
 	status = "okay";
 };
 
 &usb_1_ss1_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p9>;
+
 	status = "okay";
 };
 
@@ -560,12 +566,15 @@ &usb_1_ss1_dwc3 {
 
 &usb_1_ss2_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
-	vdda12-supply = <&vreg_l3e_1p2>;
+	vdda12-supply = <&vreg_l2j_1p2>;
 
 	status = "okay";
 };
 
 &usb_1_ss2_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p9>;
+
 	status = "okay";
 };
 
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 0c66b32e0f9f..063a6ea378aa 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -432,12 +432,13 @@ static void do_exception(struct pt_regs *regs, int access)
 			handle_fault_error_nolock(regs, 0);
 		else
 			do_sigsegv(regs, SEGV_MAPERR);
-	} else if (fault & VM_FAULT_SIGBUS) {
+	} else if (fault & (VM_FAULT_SIGBUS | VM_FAULT_HWPOISON)) {
 		if (!user_mode(regs))
 			handle_fault_error_nolock(regs, 0);
 		else
 			do_sigbus(regs);
 	} else {
+		pr_emerg("Unexpected fault flags: %08x\n", fault);
 		BUG();
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 8f231766756a..3fac29233414 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2017,7 +2017,7 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
-	uint32_t instance;
+	int instance;
 
 	DRM_DEBUG("IH: SDMA trap\n");
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 9f0495e8df4d..feeeac715c18 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1177,6 +1177,11 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	struct sk_buff *skb;
 	int err, depth;
 
+	if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
+		err = -EINVAL;
+		goto err;
+	}
+
 	if (q->flags & IFF_VNET_HDR)
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 92da8c03d960..f0f3fa1fc626 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2451,6 +2451,9 @@ static int tun_xdp_one(struct tun_struct *tun,
 	bool skb_xdp = false;
 	struct page *page;
 
+	if (unlikely(datasize < ETH_HLEN))
+		return -EINVAL;
+
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
 		if (gso->gso_type) {
diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index ec8cd7c7bbfc..0e38bb145e8f 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -150,6 +150,9 @@ struct f_midi2 {
 
 #define func_to_midi2(f)	container_of(f, struct f_midi2, func)
 
+/* convert from MIDI protocol number (1 or 2) to SNDRV_UMP_EP_INFO_PROTO_* */
+#define to_ump_protocol(v)	(((v) & 3) << 8)
+
 /* get EP name string */
 static const char *ump_ep_name(const struct f_midi2_ep *ep)
 {
@@ -564,8 +567,7 @@ static void reply_ump_stream_ep_config(struct f_midi2_ep *ep)
 		.status = UMP_STREAM_MSG_STATUS_STREAM_CFG,
 	};
 
-	if ((ep->info.protocol & SNDRV_UMP_EP_INFO_PROTO_MIDI_MASK) ==
-	    SNDRV_UMP_EP_INFO_PROTO_MIDI2)
+	if (ep->info.protocol == 2)
 		rep.protocol = UMP_STREAM_MSG_EP_INFO_CAP_MIDI2 >> 8;
 	else
 		rep.protocol = UMP_STREAM_MSG_EP_INFO_CAP_MIDI1 >> 8;
@@ -627,13 +629,13 @@ static void process_ump_stream_msg(struct f_midi2_ep *ep, const u32 *data)
 		return;
 	case UMP_STREAM_MSG_STATUS_STREAM_CFG_REQUEST:
 		if (*data & UMP_STREAM_MSG_EP_INFO_CAP_MIDI2) {
-			ep->info.protocol = SNDRV_UMP_EP_INFO_PROTO_MIDI2;
+			ep->info.protocol = 2;
 			DBG(midi2, "Switching Protocol to MIDI2\n");
 		} else {
-			ep->info.protocol = SNDRV_UMP_EP_INFO_PROTO_MIDI1;
+			ep->info.protocol = 1;
 			DBG(midi2, "Switching Protocol to MIDI1\n");
 		}
-		snd_ump_switch_protocol(ep->ump, ep->info.protocol);
+		snd_ump_switch_protocol(ep->ump, to_ump_protocol(ep->info.protocol));
 		reply_ump_stream_ep_config(ep);
 		return;
 	case UMP_STREAM_MSG_STATUS_FB_DISCOVERY:
@@ -1065,7 +1067,8 @@ static void f_midi2_midi1_ep_out_complete(struct usb_ep *usb_ep,
 		group = midi2->out_cable_mapping[cable].group;
 		bytes = midi1_packet_bytes[*buf & 0x0f];
 		for (c = 0; c < bytes; c++) {
-			snd_ump_convert_to_ump(cvt, group, ep->info.protocol,
+			snd_ump_convert_to_ump(cvt, group,
+					       to_ump_protocol(ep->info.protocol),
 					       buf[c + 1]);
 			if (cvt->ump_bytes) {
 				snd_ump_receive(ep->ump, cvt->ump,
@@ -1375,7 +1378,7 @@ static void assign_block_descriptors(struct f_midi2 *midi2,
 			desc->nNumGroupTrm = b->num_groups;
 			desc->iBlockItem = ep->blks[blk].string_id;
 
-			if (ep->info.protocol & SNDRV_UMP_EP_INFO_PROTO_MIDI2)
+			if (ep->info.protocol == 2)
 				desc->bMIDIProtocol = USB_MS_MIDI_PROTO_2_0;
 			else
 				desc->bMIDIProtocol = USB_MS_MIDI_PROTO_1_0_128;
@@ -1552,7 +1555,7 @@ static int f_midi2_create_card(struct f_midi2 *midi2)
 		if (midi2->info.static_block)
 			ump->info.flags |= SNDRV_UMP_EP_INFO_STATIC_BLOCKS;
 		ump->info.protocol_caps = (ep->info.protocol_caps & 3) << 8;
-		ump->info.protocol = (ep->info.protocol & 3) << 8;
+		ump->info.protocol = to_ump_protocol(ep->info.protocol);
 		ump->info.version = 0x0101;
 		ump->info.family_id = ep->info.family;
 		ump->info.model_id = ep->info.model;
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 9987055293b3..2999ed5d83f5 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -797,7 +797,7 @@ ssize_t __jfs_getxattr(struct inode *inode, const char *name, void *data,
 		       size_t buf_size)
 {
 	struct jfs_ea_list *ealist;
-	struct jfs_ea *ea;
+	struct jfs_ea *ea, *ealist_end;
 	struct ea_buffer ea_buf;
 	int xattr_size;
 	ssize_t size;
@@ -817,9 +817,16 @@ ssize_t __jfs_getxattr(struct inode *inode, const char *name, void *data,
 		goto not_found;
 
 	ealist = (struct jfs_ea_list *) ea_buf.xattr;
+	ealist_end = END_EALIST(ealist);
 
 	/* Find the named attribute */
-	for (ea = FIRST_EA(ealist); ea < END_EALIST(ealist); ea = NEXT_EA(ea))
+	for (ea = FIRST_EA(ealist); ea < ealist_end; ea = NEXT_EA(ea)) {
+		if (unlikely(ea + 1 > ealist_end) ||
+		    unlikely(NEXT_EA(ea) > ealist_end)) {
+			size = -EUCLEAN;
+			goto release;
+		}
+
 		if ((namelen == ea->namelen) &&
 		    memcmp(name, ea->name, namelen) == 0) {
 			/* Found it */
@@ -834,6 +841,7 @@ ssize_t __jfs_getxattr(struct inode *inode, const char *name, void *data,
 			memcpy(data, value, size);
 			goto release;
 		}
+	}
       not_found:
 	size = -ENODATA;
       release:
@@ -861,7 +869,7 @@ ssize_t jfs_listxattr(struct dentry * dentry, char *data, size_t buf_size)
 	ssize_t size = 0;
 	int xattr_size;
 	struct jfs_ea_list *ealist;
-	struct jfs_ea *ea;
+	struct jfs_ea *ea, *ealist_end;
 	struct ea_buffer ea_buf;
 
 	down_read(&JFS_IP(inode)->xattr_sem);
@@ -876,9 +884,16 @@ ssize_t jfs_listxattr(struct dentry * dentry, char *data, size_t buf_size)
 		goto release;
 
 	ealist = (struct jfs_ea_list *) ea_buf.xattr;
+	ealist_end = END_EALIST(ealist);
 
 	/* compute required size of list */
-	for (ea = FIRST_EA(ealist); ea < END_EALIST(ealist); ea = NEXT_EA(ea)) {
+	for (ea = FIRST_EA(ealist); ea < ealist_end; ea = NEXT_EA(ea)) {
+		if (unlikely(ea + 1 > ealist_end) ||
+		    unlikely(NEXT_EA(ea) > ealist_end)) {
+			size = -EUCLEAN;
+			goto release;
+		}
+
 		if (can_list(ea))
 			size += name_size(ea) + 1;
 	}
diff --git a/fs/locks.c b/fs/locks.c
index bdd94c32256f..9afb16e0683f 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2570,8 +2570,9 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 	error = do_lock_file_wait(filp, cmd, file_lock);
 
 	/*
-	 * Attempt to detect a close/fcntl race and recover by releasing the
-	 * lock that was just acquired. There is no need to do that when we're
+	 * Detect close/fcntl races and recover by zapping all POSIX locks
+	 * associated with this file and our files_struct, just like on
+	 * filp_flush(). There is no need to do that when we're
 	 * unlocking though, or for OFD locks.
 	 */
 	if (!error && file_lock->c.flc_type != F_UNLCK &&
@@ -2586,9 +2587,7 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 		f = files_lookup_fd_locked(files, fd);
 		spin_unlock(&files->file_lock);
 		if (f != filp) {
-			file_lock->c.flc_type = F_UNLCK;
-			error = do_lock_file_wait(filp, cmd, file_lock);
-			WARN_ON_ONCE(error);
+			locks_remove_posix(filp, files);
 			error = -EBADF;
 		}
 	}
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 4085fe30bf48..c14ab9d5cfc7 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -724,7 +724,8 @@ static bool check_rstbl(const struct RESTART_TABLE *rt, size_t bytes)
 
 	if (!rsize || rsize > bytes ||
 	    rsize + sizeof(struct RESTART_TABLE) > bytes || bytes < ts ||
-	    le16_to_cpu(rt->total) > ne || ff > ts || lf > ts ||
+	    le16_to_cpu(rt->total) > ne ||
+			ff > ts - sizeof(__le32) || lf > ts - sizeof(__le32) ||
 	    (ff && ff < sizeof(struct RESTART_TABLE)) ||
 	    (lf && lf < sizeof(struct RESTART_TABLE))) {
 		return false;
@@ -754,6 +755,9 @@ static bool check_rstbl(const struct RESTART_TABLE *rt, size_t bytes)
 			return false;
 
 		off = le32_to_cpu(*(__le32 *)Add2Ptr(rt, off));
+
+		if (off > ts - sizeof(__le32))
+			return false;
 	}
 
 	return true;
@@ -3722,6 +3726,8 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 
 	u64 rec_lsn, checkpt_lsn = 0, rlsn = 0;
 	struct ATTR_NAME_ENTRY *attr_names = NULL;
+	u32 attr_names_bytes = 0;
+	u32 oatbl_bytes = 0;
 	struct RESTART_TABLE *dptbl = NULL;
 	struct RESTART_TABLE *trtbl = NULL;
 	const struct RESTART_TABLE *rt;
@@ -3736,6 +3742,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	struct NTFS_RESTART *rst = NULL;
 	struct lcb *lcb = NULL;
 	struct OPEN_ATTR_ENRTY *oe;
+	struct ATTR_NAME_ENTRY *ane;
 	struct TRANSACTION_ENTRY *tr;
 	struct DIR_PAGE_ENTRY *dp;
 	u32 i, bytes_per_attr_entry;
@@ -4314,17 +4321,40 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	lcb = NULL;
 
 check_attribute_names2:
-	if (rst->attr_names_len && oatbl) {
-		struct ATTR_NAME_ENTRY *ane = attr_names;
-		while (ane->off) {
+	if (attr_names && oatbl) {
+		off = 0;
+		for (;;) {
+			/* Check we can use attribute name entry 'ane'. */
+			static_assert(sizeof(*ane) == 4);
+			if (off + sizeof(*ane) > attr_names_bytes) {
+				/* just ignore the rest. */
+				break;
+			}
+
+			ane = Add2Ptr(attr_names, off);
+			t16 = le16_to_cpu(ane->off);
+			if (!t16) {
+				/* this is the only valid exit. */
+				break;
+			}
+
+			/* Check we can use open attribute entry 'oe'. */
+			if (t16 + sizeof(*oe) > oatbl_bytes) {
+				/* just ignore the rest. */
+				break;
+			}
+
 			/* TODO: Clear table on exit! */
-			oe = Add2Ptr(oatbl, le16_to_cpu(ane->off));
+			oe = Add2Ptr(oatbl, t16);
 			t16 = le16_to_cpu(ane->name_bytes);
+			off += t16 + sizeof(*ane);
+			if (off > attr_names_bytes) {
+				/* just ignore the rest. */
+				break;
+			}
 			oe->name_len = t16 / sizeof(short);
 			oe->ptr = ane->name;
 			oe->is_attr_name = 2;
-			ane = Add2Ptr(ane,
-				      sizeof(struct ATTR_NAME_ENTRY) + t16);
 		}
 	}
 
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index d620d4c53c6f..f0beb173dbba 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -294,13 +294,16 @@ static void ocfs2_dx_dir_name_hash(struct inode *dir, const char *name, int len,
  * bh passed here can be an inode block or a dir data block, depending
  * on the inode inline data flag.
  */
-static int ocfs2_check_dir_entry(struct inode * dir,
-				 struct ocfs2_dir_entry * de,
-				 struct buffer_head * bh,
+static int ocfs2_check_dir_entry(struct inode *dir,
+				 struct ocfs2_dir_entry *de,
+				 struct buffer_head *bh,
+				 char *buf,
+				 unsigned int size,
 				 unsigned long offset)
 {
 	const char *error_msg = NULL;
 	const int rlen = le16_to_cpu(de->rec_len);
+	const unsigned long next_offset = ((char *) de - buf) + rlen;
 
 	if (unlikely(rlen < OCFS2_DIR_REC_LEN(1)))
 		error_msg = "rec_len is smaller than minimal";
@@ -308,9 +311,11 @@ static int ocfs2_check_dir_entry(struct inode * dir,
 		error_msg = "rec_len % 4 != 0";
 	else if (unlikely(rlen < OCFS2_DIR_REC_LEN(de->name_len)))
 		error_msg = "rec_len is too small for name_len";
-	else if (unlikely(
-		 ((char *) de - bh->b_data) + rlen > dir->i_sb->s_blocksize))
-		error_msg = "directory entry across blocks";
+	else if (unlikely(next_offset > size))
+		error_msg = "directory entry overrun";
+	else if (unlikely(next_offset > size - OCFS2_DIR_REC_LEN(1)) &&
+		 next_offset != size)
+		error_msg = "directory entry too close to end";
 
 	if (unlikely(error_msg != NULL))
 		mlog(ML_ERROR, "bad entry in directory #%llu: %s - "
@@ -352,16 +357,17 @@ static inline int ocfs2_search_dirblock(struct buffer_head *bh,
 	de_buf = first_de;
 	dlimit = de_buf + bytes;
 
-	while (de_buf < dlimit) {
+	while (de_buf < dlimit - OCFS2_DIR_MEMBER_LEN) {
 		/* this code is executed quadratically often */
 		/* do minimal checking `by hand' */
 
 		de = (struct ocfs2_dir_entry *) de_buf;
 
-		if (de_buf + namelen <= dlimit &&
+		if (de->name + namelen <= dlimit &&
 		    ocfs2_match(namelen, name, de)) {
 			/* found a match - just to be sure, do a full check */
-			if (!ocfs2_check_dir_entry(dir, de, bh, offset)) {
+			if (!ocfs2_check_dir_entry(dir, de, bh, first_de,
+						   bytes, offset)) {
 				ret = -1;
 				goto bail;
 			}
@@ -1138,7 +1144,7 @@ static int __ocfs2_delete_entry(handle_t *handle, struct inode *dir,
 	pde = NULL;
 	de = (struct ocfs2_dir_entry *) first_de;
 	while (i < bytes) {
-		if (!ocfs2_check_dir_entry(dir, de, bh, i)) {
+		if (!ocfs2_check_dir_entry(dir, de, bh, first_de, bytes, i)) {
 			status = -EIO;
 			mlog_errno(status);
 			goto bail;
@@ -1635,7 +1641,8 @@ int __ocfs2_add_entry(handle_t *handle,
 		/* These checks should've already been passed by the
 		 * prepare function, but I guess we can leave them
 		 * here anyway. */
-		if (!ocfs2_check_dir_entry(dir, de, insert_bh, offset)) {
+		if (!ocfs2_check_dir_entry(dir, de, insert_bh, data_start,
+					   size, offset)) {
 			retval = -ENOENT;
 			goto bail;
 		}
@@ -1774,7 +1781,8 @@ static int ocfs2_dir_foreach_blk_id(struct inode *inode,
 		}
 
 		de = (struct ocfs2_dir_entry *) (data->id_data + ctx->pos);
-		if (!ocfs2_check_dir_entry(inode, de, di_bh, ctx->pos)) {
+		if (!ocfs2_check_dir_entry(inode, de, di_bh, (char *)data->id_data,
+					   i_size_read(inode), ctx->pos)) {
 			/* On error, skip the f_pos to the end. */
 			ctx->pos = i_size_read(inode);
 			break;
@@ -1867,7 +1875,8 @@ static int ocfs2_dir_foreach_blk_el(struct inode *inode,
 		while (ctx->pos < i_size_read(inode)
 		       && offset < sb->s_blocksize) {
 			de = (struct ocfs2_dir_entry *) (bh->b_data + offset);
-			if (!ocfs2_check_dir_entry(inode, de, bh, offset)) {
+			if (!ocfs2_check_dir_entry(inode, de, bh, bh->b_data,
+						   sb->s_blocksize, offset)) {
 				/* On error, skip the f_pos to the
 				   next block. */
 				ctx->pos = (ctx->pos | (sb->s_blocksize - 1)) + 1;
@@ -3339,7 +3348,7 @@ static int ocfs2_find_dir_space_id(struct inode *dir, struct buffer_head *di_bh,
 	struct super_block *sb = dir->i_sb;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 	struct ocfs2_dir_entry *de, *last_de = NULL;
-	char *de_buf, *limit;
+	char *first_de, *de_buf, *limit;
 	unsigned long offset = 0;
 	unsigned int rec_len, new_rec_len, free_space;
 
@@ -3352,14 +3361,16 @@ static int ocfs2_find_dir_space_id(struct inode *dir, struct buffer_head *di_bh,
 	else
 		free_space = dir->i_sb->s_blocksize - i_size_read(dir);
 
-	de_buf = di->id2.i_data.id_data;
+	first_de = di->id2.i_data.id_data;
+	de_buf = first_de;
 	limit = de_buf + i_size_read(dir);
 	rec_len = OCFS2_DIR_REC_LEN(namelen);
 
 	while (de_buf < limit) {
 		de = (struct ocfs2_dir_entry *)de_buf;
 
-		if (!ocfs2_check_dir_entry(dir, de, di_bh, offset)) {
+		if (!ocfs2_check_dir_entry(dir, de, di_bh, first_de,
+					   i_size_read(dir), offset)) {
 			ret = -ENOENT;
 			goto out;
 		}
@@ -3441,7 +3452,8 @@ static int ocfs2_find_dir_space_el(struct inode *dir, const char *name,
 			/* move to next block */
 			de = (struct ocfs2_dir_entry *) bh->b_data;
 		}
-		if (!ocfs2_check_dir_entry(dir, de, bh, offset)) {
+		if (!ocfs2_check_dir_entry(dir, de, bh, bh->b_data, blocksize,
+					   offset)) {
 			status = -ENOENT;
 			goto bail;
 		}
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index e299e8634751..62489677f394 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -352,8 +352,12 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open_request_chan);
 int snd_dmaengine_pcm_sync_stop(struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+	struct dma_tx_state state;
+	enum dma_status status;
 
-	dmaengine_synchronize(prtd->dma_chan);
+	status = dmaengine_tx_status(prtd->dma_chan, prtd->cookie, &state);
+	if (status != DMA_PAUSED)
+		dmaengine_synchronize(prtd->dma_chan);
 
 	return 0;
 }
diff --git a/sound/core/seq/seq_ump_client.c b/sound/core/seq/seq_ump_client.c
index c627d72f7fe2..9cdfbeae3ed5 100644
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -28,6 +28,7 @@ struct seq_ump_group {
 	int group;			/* group index (0-based) */
 	unsigned int dir_bits;		/* directions */
 	bool active;			/* activeness */
+	bool valid;			/* valid group (referred by blocks) */
 	char name[64];			/* seq port name */
 };
 
@@ -210,6 +211,13 @@ static void fill_port_info(struct snd_seq_port_info *port,
 		sprintf(port->name, "Group %d", group->group + 1);
 }
 
+/* skip non-existing group for static blocks */
+static bool skip_group(struct seq_ump_client *client, struct seq_ump_group *group)
+{
+	return !group->valid &&
+		(client->ump->info.flags & SNDRV_UMP_EP_INFO_STATIC_BLOCKS);
+}
+
 /* create a new sequencer port per UMP group */
 static int seq_ump_group_init(struct seq_ump_client *client, int group_index)
 {
@@ -217,6 +225,9 @@ static int seq_ump_group_init(struct seq_ump_client *client, int group_index)
 	struct snd_seq_port_info *port __free(kfree) = NULL;
 	struct snd_seq_port_callback pcallbacks;
 
+	if (skip_group(client, group))
+		return 0;
+
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
@@ -250,6 +261,9 @@ static void update_port_infos(struct seq_ump_client *client)
 		return;
 
 	for (i = 0; i < SNDRV_UMP_MAX_GROUPS; i++) {
+		if (skip_group(client, &client->groups[i]))
+			continue;
+
 		old->addr.client = client->seq_client;
 		old->addr.port = i;
 		err = snd_seq_kernel_client_ctl(client->seq_client,
@@ -284,6 +298,7 @@ static void update_group_attrs(struct seq_ump_client *client)
 		group->dir_bits = 0;
 		group->active = 0;
 		group->group = i;
+		group->valid = false;
 	}
 
 	list_for_each_entry(fb, &client->ump->block_list, list) {
@@ -291,6 +306,7 @@ static void update_group_attrs(struct seq_ump_client *client)
 			break;
 		group = &client->groups[fb->info.first_group];
 		for (i = 0; i < fb->info.num_groups; i++, group++) {
+			group->valid = true;
 			if (fb->info.active)
 				group->active = 1;
 			switch (fb->info.direction) {
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8a52ed9aa465..3d91ed8c445c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10333,6 +10333,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
 	SND_PCI_QUIRK(0x10ec, 0x118c, "Medion EE4254 MD62100", ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE),
+	SND_PCI_QUIRK(0x10ec, 0x119e, "Positivo SU C1400", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10ec, 0x11bc, "VAIO VJFE-IL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x10ec, 0x1230, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x124c, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
@@ -10347,6 +10348,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc189, "Samsung Galaxy Flex Book (NT950QCG-X716)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc18a, "Samsung Galaxy Book Ion (NP930XCJ-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc1a3, "Samsung Galaxy Book Pro (NP935XDB-KC1SE)", ALC298_FIXUP_SAMSUNG_AMP),
+	SND_PCI_QUIRK(0x144d, 0xc1a4, "Samsung Galaxy Book Pro 360 (NT935QBD)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc1a6, "Samsung Galaxy Book Pro 360 (NP930QBD)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)", ALC269_FIXUP_ATIV_BOOK_8),
 	SND_PCI_QUIRK(0x144d, 0xc812, "Samsung Notebook Pen S (NT950SBE-X58)", ALC298_FIXUP_SAMSUNG_AMP),
@@ -10488,6 +10490,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x231e, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318),
 	SND_PCI_QUIRK(0x17aa, 0x231f, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318),
+	SND_PCI_QUIRK(0x17aa, 0x2326, "Hera2", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),

