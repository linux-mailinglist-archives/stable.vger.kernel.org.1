Return-Path: <stable+bounces-169724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1744B281A5
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 16:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56BBE4E2AD9
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F5E233152;
	Fri, 15 Aug 2025 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z5WHtTYE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72C2248B4;
	Fri, 15 Aug 2025 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268112; cv=none; b=cYj9J3CkTeDMYjeoKcPWL8kTAPy56ae+TlKlP4eEd9h+aVIcRK7SZH+x08buGeEabyi11vZCUqjRbGYDfhCMrc3U5yxyh0EeosxHBynyCxZ2aM9q+1LdvQlamU/wNgohHFLMKk8nv33AdUKfYLrWKX0ACmf8y+DvwbUn3oXcUPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268112; c=relaxed/simple;
	bh=7RKf2/EgY42vk0qXbg/PDm5bNb9k8wyIRW8BrViGXLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQMZ1n7LVreN+sOEps4t+vaCEMsJDRmu4Vp7JxV5UoIQz5qKSCjyXlT+6b/U2c24r/WVof9T2Gd3Wrj18CbpEVZRLNLtTmIzQ8ZeMydnwMsOB1r1b4jH9sdprSkmJe0VCHyTv6l0l1f+gADCJNqx15xPknPzkcANeKsKZfEc0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z5WHtTYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F67C4CEEB;
	Fri, 15 Aug 2025 14:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755268111;
	bh=7RKf2/EgY42vk0qXbg/PDm5bNb9k8wyIRW8BrViGXLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z5WHtTYEIwfvs3OaaYKx4ce2mlaod/6I8MCRoedN8gYF4a+lu/VYcx+0oSuAS17V6
	 IPQW+vY3t1cxKcMD+6A9hSH1QmmG8cm6rMULBGNmmk5VmuF5Q15qgTCbdhAS3qWHOT
	 /ZS57snWaT7hQCZSMBAc6buI58+I4oKPAx3RloB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.42
Date: Fri, 15 Aug 2025 16:28:10 +0200
Message-ID: <2025081510-tactless-pedigree-f54e@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081510-unicycle-theme-26a0@gregkh>
References: <2025081510-unicycle-theme-26a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 68a0885fb5e6..fdf31514fb1c 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -235,9 +235,9 @@ usrjquota=<file>	 Appoint specified file and type during mount, so that quota
 grpjquota=<file>	 information can be properly updated during recovery flow,
 prjjquota=<file>	 <quota file>: must be in root directory;
 jqfmt=<quota type>	 <quota type>: [vfsold,vfsv0,vfsv1].
-offusrjquota		 Turn off user journalled quota.
-offgrpjquota		 Turn off group journalled quota.
-offprjjquota		 Turn off project journalled quota.
+usrjquota=		 Turn off user journalled quota.
+grpjquota=		 Turn off group journalled quota.
+prjjquota=		 Turn off project journalled quota.
 quota			 Enable plain user disk quota accounting.
 noquota			 Disable all plain disk quota option.
 alloc_mode=%s		 Adjust block allocation policy, which supports "reuse"
diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index f6c5d8214c7e..4936aa5855b1 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1682,9 +1682,6 @@ operations:
 
       do: &module-eeprom-get-op
         request:
-          attributes:
-            - header
-        reply:
           attributes:
             - header
             - offset
@@ -1692,6 +1689,9 @@ operations:
             - page
             - bank
             - i2c-address
+        reply:
+          attributes:
+            - header
             - data
       dump: *module-eeprom-get-op
     -
diff --git a/Makefile b/Makefile
index fbaebf00a33b..265dba73ce33 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 41
+SUBLEVEL = 42
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
index 29d2f86d5e34..f4c45e964daf 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
@@ -168,7 +168,6 @@ &uart2 {
 	pinctrl-0 = <&pinctrl_uart2>;
 	linux,rs485-enabled-at-boot-time;
 	rs485-rx-during-tx;
-	rs485-rts-active-low;
 	uart-has-rtscts;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi b/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi
index acccf9a3c898..27422a343f14 100644
--- a/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi
+++ b/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi
@@ -604,7 +604,7 @@ usbmisc1: usb@400b4800 {
 
 			ftm: ftm@400b8000 {
 				compatible = "fsl,ftm-timer";
-				reg = <0x400b8000 0x1000 0x400b9000 0x1000>;
+				reg = <0x400b8000 0x1000>, <0x400b9000 0x1000>;
 				interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "ftm-evt", "ftm-src",
 					"ftm-evt-counter-en", "ftm-src-counter-en";
diff --git a/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts b/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
index 16b567e3cb47..b4fdcf9c02b5 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
@@ -35,7 +35,7 @@ &gpio0 {
 		"P9_18 [spi0_d1]",
 		"P9_17 [spi0_cs0]",
 		"[mmc0_cd]",
-		"P8_42A [ecappwm0]",
+		"P9_42A [ecappwm0]",
 		"P8_35 [lcd d12]",
 		"P8_33 [lcd d13]",
 		"P8_31 [lcd d14]",
diff --git a/arch/arm/crypto/aes-neonbs-glue.c b/arch/arm/crypto/aes-neonbs-glue.c
index f6be80b5938b..2fad3a0c0563 100644
--- a/arch/arm/crypto/aes-neonbs-glue.c
+++ b/arch/arm/crypto/aes-neonbs-glue.c
@@ -232,7 +232,7 @@ static int ctr_encrypt(struct skcipher_request *req)
 	while (walk.nbytes > 0) {
 		const u8 *src = walk.src.virt.addr;
 		u8 *dst = walk.dst.virt.addr;
-		int bytes = walk.nbytes;
+		unsigned int bytes = walk.nbytes;
 
 		if (unlikely(bytes < AES_BLOCK_SIZE))
 			src = dst = memcpy(buf + sizeof(buf) - bytes,
diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index b8f8255f840b..7caa2f3ef134 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -155,6 +155,7 @@ ANANKE_CPU_SLEEP: cpu-ananke-sleep {
 				idle-state-name = "c2";
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x0010000>;
+				local-timer-stop;
 				entry-latency-us = <70>;
 				exit-latency-us = <160>;
 				min-residency-us = <2000>;
@@ -164,6 +165,7 @@ ENYO_CPU_SLEEP: cpu-enyo-sleep {
 				idle-state-name = "c2";
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x0010000>;
+				local-timer-stop;
 				entry-latency-us = <150>;
 				exit-latency-us = <190>;
 				min-residency-us = <2500>;
@@ -173,6 +175,7 @@ HERA_CPU_SLEEP: cpu-hera-sleep {
 				idle-state-name = "c2";
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x0010000>;
+				local-timer-stop;
 				entry-latency-us = <235>;
 				exit-latency-us = <220>;
 				min-residency-us = <3500>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index 9ba0cb89fa24..c0f00835e47d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -286,6 +286,8 @@ &usdhc3 {
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	assigned-clocks = <&clk IMX8MM_CLK_USDHC3>;
+	assigned-clock-rates = <400000000>;
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
index bb11590473a4..353d0c9ff35c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
@@ -297,6 +297,8 @@ &usdhc3 {
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	assigned-clocks = <&clk IMX8MN_CLK_USDHC3>;
+	assigned-clock-rates = <400000000>;
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
index 2cabdae24227..09385b058664 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright (c) 2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * Copyright (c) 2022-2025 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
  * Author: Markus Niebel
  */
@@ -110,11 +110,11 @@ buck1: BUCK1 {
 				regulator-ramp-delay = <3125>;
 			};
 
-			/* V_DDRQ - 1.1 LPDDR4 or 0.6 LPDDR4X */
+			/* V_DDRQ - 0.6 V for LPDDR4X */
 			buck2: BUCK2 {
 				regulator-name = "BUCK2";
 				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <1100000>;
+				regulator-max-microvolt = <600000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 06af6e5ec578..884b5bb54ba8 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -1330,6 +1330,7 @@ blsp1_dma: dma-controller@7884000 {
 			clock-names = "bam_clk";
 			#dma-cells = <1>;
 			qcom,ee = <0>;
+			qcom,controlled-remotely;
 		};
 
 		blsp1_uart1: serial@78af000 {
@@ -1450,6 +1451,7 @@ blsp2_dma: dma-controller@7ac4000 {
 			clock-names = "bam_clk";
 			#dma-cells = <1>;
 			qcom,ee = <0>;
+			qcom,controlled-remotely;
 		};
 
 		blsp2_uart2: serial@7af0000 {
diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index b28fa598cebb..60f3b545304b 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -3797,8 +3797,8 @@ remoteproc_gpdsp0: remoteproc@20c00000 {
 
 			interrupts-extended = <&intc GIC_SPI 768 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_gpdsp0_in 0 0>,
-					      <&smp2p_gpdsp0_in 2 0>,
 					      <&smp2p_gpdsp0_in 1 0>,
+					      <&smp2p_gpdsp0_in 2 0>,
 					      <&smp2p_gpdsp0_in 3 0>;
 			interrupt-names = "wdog", "fatal", "ready",
 					  "handover", "stop-ack";
@@ -3840,8 +3840,8 @@ remoteproc_gpdsp1: remoteproc@21c00000 {
 
 			interrupts-extended = <&intc GIC_SPI 624 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_gpdsp1_in 0 0>,
-					      <&smp2p_gpdsp1_in 2 0>,
 					      <&smp2p_gpdsp1_in 1 0>,
+					      <&smp2p_gpdsp1_in 2 0>,
 					      <&smp2p_gpdsp1_in 3 0>;
 			interrupt-names = "wdog", "fatal", "ready",
 					  "handover", "stop-ack";
@@ -3965,8 +3965,8 @@ remoteproc_cdsp0: remoteproc@26300000 {
 
 			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp0_in 0 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_cdsp0_in 2 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp0_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp0_in 2 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp0_in 3 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "wdog", "fatal", "ready",
 					  "handover", "stop-ack";
@@ -4097,8 +4097,8 @@ remoteproc_cdsp1: remoteproc@2a300000 {
 
 			interrupts-extended = <&intc GIC_SPI 798 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp1_in 0 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_cdsp1_in 2 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp1_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp1_in 2 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp1_in 3 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "wdog", "fatal", "ready",
 					  "handover", "stop-ack";
@@ -4253,8 +4253,8 @@ remoteproc_adsp: remoteproc@30000000 {
 
 			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "wdog", "fatal", "ready", "handover",
 					  "stop-ack";
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 249b257fc6a7..6ae5ca00c718 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3524,18 +3524,18 @@ spmi_bus: spmi@c440000 {
 			#interrupt-cells = <4>;
 		};
 
-		sram@146aa000 {
+		sram@14680000 {
 			compatible = "qcom,sc7180-imem", "syscon", "simple-mfd";
-			reg = <0 0x146aa000 0 0x2000>;
+			reg = <0 0x14680000 0 0x2e000>;
 
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			ranges = <0 0 0x146aa000 0x2000>;
+			ranges = <0 0 0x14680000 0x2e000>;
 
-			pil-reloc@94c {
+			pil-reloc@2a94c {
 				compatible = "qcom,pil-reloc-info";
-				reg = <0x94c 0xc8>;
+				reg = <0x2a94c 0xc8>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0a0cef9dfcc4..9bf7a405a964 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5074,18 +5074,18 @@ spmi_bus: spmi@c440000 {
 			#interrupt-cells = <4>;
 		};
 
-		sram@146bf000 {
+		sram@14680000 {
 			compatible = "qcom,sdm845-imem", "syscon", "simple-mfd";
-			reg = <0 0x146bf000 0 0x1000>;
+			reg = <0 0x14680000 0 0x40000>;
 
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			ranges = <0 0 0x146bf000 0x1000>;
+			ranges = <0 0 0x14680000 0x40000>;
 
-			pil-reloc@94c {
+			pil-reloc@3f94c {
 				compatible = "qcom,pil-reloc-info";
-				reg = <0x94c 0xc8>;
+				reg = <0x3f94c 0xc8>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index cd9b92144a42..ed7804f06189 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -149,7 +149,7 @@ timer {
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
-		always-on;
+		arm,no-tick-in-suspend;
 	};
 
 	soc@0 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 77fe2b27cb58..239acfcc3a5c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -250,7 +250,7 @@ secure_proxy_sa3: mailbox@43600000 {
 
 	main_pmx0: pinctrl@f4000 {
 		compatible = "pinctrl-single";
-		reg = <0x00 0xf4000 0x00 0x2ac>;
+		reg = <0x00 0xf4000 0x00 0x2b0>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 60285d736e07..78df1b43a633 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -319,6 +319,8 @@ AM64X_IOPAD(0x0040, PIN_OUTPUT, 7)	/* (U21) GPMC0_AD1.GPIO0_16 */
 &icssg0_mdio {
 	pinctrl-names = "default";
 	pinctrl-0 = <&icssg0_mdio_pins_default &clkout0_pins_default>;
+	assigned-clocks = <&k3_clks 157 123>;
+	assigned-clock-parents = <&k3_clks 157 125>;
 	status = "okay";
 
 	icssg0_phy1: ethernet-phy@1 {
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 515c411c2c83..5553508c3644 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -399,6 +399,7 @@ static void push_callee_regs(struct jit_ctx *ctx)
 		emit(A64_PUSH(A64_R(23), A64_R(24), A64_SP), ctx);
 		emit(A64_PUSH(A64_R(25), A64_R(26), A64_SP), ctx);
 		emit(A64_PUSH(A64_R(27), A64_R(28), A64_SP), ctx);
+		ctx->fp_used = true;
 	} else {
 		find_used_callee_regs(ctx);
 		for (i = 0; i + 1 < ctx->nr_used_callee_reg; i += 2) {
diff --git a/arch/m68k/Kconfig.debug b/arch/m68k/Kconfig.debug
index 30638a6e8edc..d036f903864c 100644
--- a/arch/m68k/Kconfig.debug
+++ b/arch/m68k/Kconfig.debug
@@ -10,7 +10,7 @@ config BOOTPARAM_STRING
 
 config EARLY_PRINTK
 	bool "Early printk"
-	depends on !(SUN3 || M68000 || COLDFIRE)
+	depends on MMU_MOTOROLA
 	help
 	  Write kernel log output directly to a serial port.
 	  Where implemented, output goes to the framebuffer as well.
diff --git a/arch/m68k/kernel/early_printk.c b/arch/m68k/kernel/early_printk.c
index f11ef9f1f56f..521cbb8a150c 100644
--- a/arch/m68k/kernel/early_printk.c
+++ b/arch/m68k/kernel/early_printk.c
@@ -16,25 +16,10 @@
 #include "../mvme147/mvme147.h"
 #include "../mvme16x/mvme16x.h"
 
-asmlinkage void __init debug_cons_nputs(const char *s, unsigned n);
-
-static void __ref debug_cons_write(struct console *c,
-				   const char *s, unsigned n)
-{
-#if !(defined(CONFIG_SUN3) || defined(CONFIG_M68000) || \
-      defined(CONFIG_COLDFIRE))
-	if (MACH_IS_MVME147)
-		mvme147_scc_write(c, s, n);
-	else if (MACH_IS_MVME16x)
-		mvme16x_cons_write(c, s, n);
-	else
-		debug_cons_nputs(s, n);
-#endif
-}
+asmlinkage void __init debug_cons_nputs(struct console *c, const char *s, unsigned int n);
 
 static struct console early_console_instance = {
 	.name  = "debug",
-	.write = debug_cons_write,
 	.flags = CON_PRINTBUFFER | CON_BOOT,
 	.index = -1
 };
@@ -44,6 +29,12 @@ static int __init setup_early_printk(char *buf)
 	if (early_console || buf)
 		return 0;
 
+	if (MACH_IS_MVME147)
+		early_console_instance.write = mvme147_scc_write;
+	else if (MACH_IS_MVME16x)
+		early_console_instance.write = mvme16x_cons_write;
+	else
+		early_console_instance.write = debug_cons_nputs;
 	early_console = &early_console_instance;
 	register_console(early_console);
 
@@ -51,20 +42,15 @@ static int __init setup_early_printk(char *buf)
 }
 early_param("earlyprintk", setup_early_printk);
 
-/*
- * debug_cons_nputs() defined in arch/m68k/kernel/head.S cannot be called
- * after init sections are discarded (for platforms that use it).
- */
-#if !(defined(CONFIG_SUN3) || defined(CONFIG_M68000) || \
-      defined(CONFIG_COLDFIRE))
-
 static int __init unregister_early_console(void)
 {
-	if (!early_console || MACH_IS_MVME16x)
-		return 0;
+	/*
+	 * debug_cons_nputs() defined in arch/m68k/kernel/head.S cannot be
+	 * called after init sections are discarded (for platforms that use it).
+	 */
+	if (early_console && early_console->write == debug_cons_nputs)
+		return unregister_console(early_console);
 
-	return unregister_console(early_console);
+	return 0;
 }
 late_initcall(unregister_early_console);
-
-#endif
diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
index 852255cf60de..ba22bc2f3d6d 100644
--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -3263,8 +3263,8 @@ func_return	putn
  *	turns around and calls the internal routines.  This routine
  *	is used by the boot console.
  *
- *	The calling parameters are:
- *		void debug_cons_nputs(const char *str, unsigned length)
+ *	The function signature is -
+ *		void debug_cons_nputs(struct console *c, const char *s, unsigned int n)
  *
  *	This routine does NOT understand variable arguments only
  *	simple strings!
@@ -3273,8 +3273,8 @@ ENTRY(debug_cons_nputs)
 	moveml	%d0/%d1/%a0,%sp@-
 	movew	%sr,%sp@-
 	ori	#0x0700,%sr
-	movel	%sp@(18),%a0		/* fetch parameter */
-	movel	%sp@(22),%d1		/* fetch parameter */
+	movel	%sp@(22),%a0		/* char *s */
+	movel	%sp@(26),%d1		/* unsigned int n */
 	jra	2f
 1:
 #ifdef CONSOLE_DEBUG
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 76f3b9c0a9f0..347126dc010d 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -508,6 +508,60 @@ static int __init set_ntlb(char *str)
 
 __setup("ntlb=", set_ntlb);
 
+/* Initialise all TLB entries with unique values */
+static void r4k_tlb_uniquify(void)
+{
+	int entry = num_wired_entries();
+
+	htw_stop();
+	write_c0_entrylo0(0);
+	write_c0_entrylo1(0);
+
+	while (entry < current_cpu_data.tlbsize) {
+		unsigned long asid_mask = cpu_asid_mask(&current_cpu_data);
+		unsigned long asid = 0;
+		int idx;
+
+		/* Skip wired MMID to make ginvt_mmid work */
+		if (cpu_has_mmid)
+			asid = MMID_KERNEL_WIRED + 1;
+
+		/* Check for match before using UNIQUE_ENTRYHI */
+		do {
+			if (cpu_has_mmid) {
+				write_c0_memorymapid(asid);
+				write_c0_entryhi(UNIQUE_ENTRYHI(entry));
+			} else {
+				write_c0_entryhi(UNIQUE_ENTRYHI(entry) | asid);
+			}
+			mtc0_tlbw_hazard();
+			tlb_probe();
+			tlb_probe_hazard();
+			idx = read_c0_index();
+			/* No match or match is on current entry */
+			if (idx < 0 || idx == entry)
+				break;
+			/*
+			 * If we hit a match, we need to try again with
+			 * a different ASID.
+			 */
+			asid++;
+		} while (asid < asid_mask);
+
+		if (idx >= 0 && idx != entry)
+			panic("Unable to uniquify TLB entry %d", idx);
+
+		write_c0_index(entry);
+		mtc0_tlbw_hazard();
+		tlb_write_indexed();
+		entry++;
+	}
+
+	tlbw_use_hazard();
+	htw_start();
+	flush_micro_tlb();
+}
+
 /*
  * Configure TLB (for init or after a CPU has been powered off).
  */
@@ -547,7 +601,7 @@ static void r4k_tlb_configure(void)
 	temp_tlb_entry = current_cpu_data.tlbsize - 1;
 
 	/* From this point on the ARC firmware is dead.	 */
-	local_flush_tlb_all();
+	r4k_tlb_uniquify();
 
 	/* Did I tell you that ARC SUCKS?  */
 }
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index c06344db0eb3..1c67f64739a0 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -253,7 +253,6 @@ CONFIG_NET_SCH_DSMARK=m
 CONFIG_NET_SCH_NETEM=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_CLS_BASIC=m
-CONFIG_NET_CLS_TCINDEX=m
 CONFIG_NET_CLS_ROUTE4=m
 CONFIG_NET_CLS_FW=m
 CONFIG_NET_CLS_U32=m
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index ca7f7bb2b478..2b5f3323e107 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1139,6 +1139,7 @@ int eeh_unfreeze_pe(struct eeh_pe *pe)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(eeh_unfreeze_pe);
 
 
 static struct pci_device_id eeh_reset_ids[] = {
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 7efe04c68f0f..dd50de91c438 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -257,13 +257,12 @@ static void eeh_pe_report_edev(struct eeh_dev *edev, eeh_report_fn fn,
 	struct pci_driver *driver;
 	enum pci_ers_result new_result;
 
-	pci_lock_rescan_remove();
 	pdev = edev->pdev;
 	if (pdev)
 		get_device(&pdev->dev);
-	pci_unlock_rescan_remove();
 	if (!pdev) {
 		eeh_edev_info(edev, "no device");
+		*result = PCI_ERS_RESULT_DISCONNECT;
 		return;
 	}
 	device_lock(&pdev->dev);
@@ -304,8 +303,9 @@ static void eeh_pe_report(const char *name, struct eeh_pe *root,
 	struct eeh_dev *edev, *tmp;
 
 	pr_info("EEH: Beginning: '%s'\n", name);
-	eeh_for_each_pe(root, pe) eeh_pe_for_each_dev(pe, edev, tmp)
-		eeh_pe_report_edev(edev, fn, result);
+	eeh_for_each_pe(root, pe)
+		eeh_pe_for_each_dev(pe, edev, tmp)
+			eeh_pe_report_edev(edev, fn, result);
 	if (result)
 		pr_info("EEH: Finished:'%s' with aggregate recovery state:'%s'\n",
 			name, pci_ers_result_name(*result));
@@ -383,6 +383,8 @@ static void eeh_dev_restore_state(struct eeh_dev *edev, void *userdata)
 	if (!edev)
 		return;
 
+	pci_lock_rescan_remove();
+
 	/*
 	 * The content in the config space isn't saved because
 	 * the blocked config space on some adapters. We have
@@ -393,14 +395,19 @@ static void eeh_dev_restore_state(struct eeh_dev *edev, void *userdata)
 		if (list_is_last(&edev->entry, &edev->pe->edevs))
 			eeh_pe_restore_bars(edev->pe);
 
+		pci_unlock_rescan_remove();
 		return;
 	}
 
 	pdev = eeh_dev_to_pci_dev(edev);
-	if (!pdev)
+	if (!pdev) {
+		pci_unlock_rescan_remove();
 		return;
+	}
 
 	pci_restore_state(pdev);
+
+	pci_unlock_rescan_remove();
 }
 
 /**
@@ -647,9 +654,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	if (any_passed || driver_eeh_aware || (pe->type & EEH_PE_VF)) {
 		eeh_pe_dev_traverse(pe, eeh_rmv_device, rmv_data);
 	} else {
-		pci_lock_rescan_remove();
 		pci_hp_remove_devices(bus);
-		pci_unlock_rescan_remove();
 	}
 
 	/*
@@ -665,8 +670,6 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	if (rc)
 		return rc;
 
-	pci_lock_rescan_remove();
-
 	/* Restore PE */
 	eeh_ops->configure_bridge(pe);
 	eeh_pe_restore_bars(pe);
@@ -674,7 +677,6 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	/* Clear frozen state */
 	rc = eeh_clear_pe_frozen_state(pe, false);
 	if (rc) {
-		pci_unlock_rescan_remove();
 		return rc;
 	}
 
@@ -709,7 +711,6 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	pe->tstamp = tstamp;
 	pe->freeze_count = cnt;
 
-	pci_unlock_rescan_remove();
 	return 0;
 }
 
@@ -843,10 +844,13 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		{LIST_HEAD_INIT(rmv_data.removed_vf_list), 0};
 	int devices = 0;
 
+	pci_lock_rescan_remove();
+
 	bus = eeh_pe_bus_get(pe);
 	if (!bus) {
 		pr_err("%s: Cannot find PCI bus for PHB#%x-PE#%x\n",
 			__func__, pe->phb->global_number, pe->addr);
+		pci_unlock_rescan_remove();
 		return;
 	}
 
@@ -1094,10 +1098,15 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		eeh_pe_state_clear(pe, EEH_PE_PRI_BUS, true);
 		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
 
-		pci_lock_rescan_remove();
-		pci_hp_remove_devices(bus);
-		pci_unlock_rescan_remove();
+		bus = eeh_pe_bus_get(pe);
+		if (bus)
+			pci_hp_remove_devices(bus);
+		else
+			pr_err("%s: PCI bus for PHB#%x-PE#%x disappeared\n",
+				__func__, pe->phb->global_number, pe->addr);
+
 		/* The passed PE should no longer be used */
+		pci_unlock_rescan_remove();
 		return;
 	}
 
@@ -1114,6 +1123,8 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 			eeh_clear_slot_attention(edev->pdev);
 
 	eeh_pe_state_clear(pe, EEH_PE_RECOVERING, true);
+
+	pci_unlock_rescan_remove();
 }
 
 /**
@@ -1132,6 +1143,7 @@ void eeh_handle_special_event(void)
 	unsigned long flags;
 	int rc;
 
+	pci_lock_rescan_remove();
 
 	do {
 		rc = eeh_ops->next_error(&pe);
@@ -1171,10 +1183,12 @@ void eeh_handle_special_event(void)
 
 			break;
 		case EEH_NEXT_ERR_NONE:
+			pci_unlock_rescan_remove();
 			return;
 		default:
 			pr_warn("%s: Invalid value %d from next_error()\n",
 				__func__, rc);
+			pci_unlock_rescan_remove();
 			return;
 		}
 
@@ -1186,7 +1200,9 @@ void eeh_handle_special_event(void)
 		if (rc == EEH_NEXT_ERR_FROZEN_PE ||
 		    rc == EEH_NEXT_ERR_FENCED_PHB) {
 			eeh_pe_state_mark(pe, EEH_PE_RECOVERING);
+			pci_unlock_rescan_remove();
 			eeh_handle_normal_event(pe);
+			pci_lock_rescan_remove();
 		} else {
 			eeh_for_each_pe(pe, tmp_pe)
 				eeh_pe_for_each_dev(tmp_pe, edev, tmp_edev)
@@ -1199,7 +1215,6 @@ void eeh_handle_special_event(void)
 				eeh_report_failure, NULL);
 			eeh_set_channel_state(pe, pci_channel_io_perm_failure);
 
-			pci_lock_rescan_remove();
 			list_for_each_entry(hose, &hose_list, list_node) {
 				phb_pe = eeh_phb_pe_get(hose);
 				if (!phb_pe ||
@@ -1218,7 +1233,6 @@ void eeh_handle_special_event(void)
 				}
 				pci_hp_remove_devices(bus);
 			}
-			pci_unlock_rescan_remove();
 		}
 
 		/*
@@ -1228,4 +1242,6 @@ void eeh_handle_special_event(void)
 		if (rc == EEH_NEXT_ERR_DEAD_IOC)
 			break;
 	} while (rc != EEH_NEXT_ERR_NONE);
+
+	pci_unlock_rescan_remove();
 }
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index d283d281d28e..e740101fadf3 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -671,10 +671,12 @@ static void eeh_bridge_check_link(struct eeh_dev *edev)
 	eeh_ops->write_config(edev, cap + PCI_EXP_LNKCTL, 2, val);
 
 	/* Check link */
-	if (!edev->pdev->link_active_reporting) {
-		eeh_edev_dbg(edev, "No link reporting capability\n");
-		msleep(1000);
-		return;
+	if (edev->pdev) {
+		if (!edev->pdev->link_active_reporting) {
+			eeh_edev_dbg(edev, "No link reporting capability\n");
+			msleep(1000);
+			return;
+		}
 	}
 
 	/* Wait the link is up until timeout (5s) */
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 9ea74973d78d..6f444d0822d8 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -141,6 +141,9 @@ void pci_hp_add_devices(struct pci_bus *bus)
 	struct pci_controller *phb;
 	struct device_node *dn = pci_bus_to_OF_node(bus);
 
+	if (!dn)
+		return;
+
 	phb = pci_bus_to_host(bus);
 
 	mode = PCI_PROBE_NORMAL;
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 213aa26dc8b3..979487da6522 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -404,6 +404,45 @@ get_device_node_with_drc_info(u32 index)
 	return NULL;
 }
 
+static struct device_node *
+get_device_node_with_drc_indexes(u32 drc_index)
+{
+	struct device_node *np = NULL;
+	u32 nr_indexes, index;
+	int i, rc;
+
+	for_each_node_with_property(np, "ibm,drc-indexes") {
+		/*
+		 * First element in the array is the total number of
+		 * DRC indexes returned.
+		 */
+		rc = of_property_read_u32_index(np, "ibm,drc-indexes",
+				0, &nr_indexes);
+		if (rc)
+			goto out_put_np;
+
+		/*
+		 * Retrieve DRC index from the list and return the
+		 * device node if matched with the specified index.
+		 */
+		for (i = 0; i < nr_indexes; i++) {
+			rc = of_property_read_u32_index(np, "ibm,drc-indexes",
+							i+1, &index);
+			if (rc)
+				goto out_put_np;
+
+			if (drc_index == index)
+				return np;
+		}
+	}
+
+	return NULL;
+
+out_put_np:
+	of_node_put(np);
+	return NULL;
+}
+
 static int dlpar_hp_dt_add(u32 index)
 {
 	struct device_node *np, *nodes;
@@ -423,10 +462,19 @@ static int dlpar_hp_dt_add(u32 index)
 		goto out;
 	}
 
+	/*
+	 * Recent FW provides ibm,drc-info property. So search
+	 * for the user specified DRC index from ibm,drc-info
+	 * property. If this property is not available, search
+	 * in the indexes array from ibm,drc-indexes property.
+	 */
 	np = get_device_node_with_drc_info(index);
 
-	if (!np)
-		return -EIO;
+	if (!np) {
+		np = get_device_node_with_drc_indexes(index);
+		if (!np)
+			return -EIO;
+	}
 
 	/* Next, configure the connector. */
 	nodes = dlpar_configure_connector(cpu_to_be32(index), np);
diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index 395b02d6a133..352108727d7e 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -103,7 +103,7 @@ struct ap_tapq_hwinfo {
 			unsigned int accel :  1; /* A */
 			unsigned int ep11  :  1; /* X */
 			unsigned int apxa  :  1; /* APXA */
-			unsigned int	   :  1;
+			unsigned int slcf  :  1; /* Cmd filtering avail. */
 			unsigned int class :  8;
 			unsigned int bs	   :  2; /* SE bind/assoc */
 			unsigned int	   : 14;
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index f691e0fb66a2..f5dece935353 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -219,11 +219,6 @@ void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pgtable);
 
 	call_rcu(&ptdesc->pt_rcu_head, pte_free_now);
-	/*
-	 * THPs are not allowed for KVM guests. Warn if pgste ever reaches here.
-	 * Turn to the generic pte_free_defer() version once gmap is removed.
-	 */
-	WARN_ON_ONCE(mm_has_pgste(mm));
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 665b8228afeb..dd971826652a 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -63,13 +63,12 @@ void *vmem_crst_alloc(unsigned long val)
 
 pte_t __ref *vmem_pte_alloc(void)
 {
-	unsigned long size = PTRS_PER_PTE * sizeof(pte_t);
 	pte_t *pte;
 
 	if (slab_is_available())
-		pte = (pte_t *) page_table_alloc(&init_mm);
+		pte = (pte_t *)page_table_alloc(&init_mm);
 	else
-		pte = (pte_t *) memblock_alloc(size, size);
+		pte = (pte_t *)memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	if (!pte)
 		return NULL;
 	memset64((u64 *)pte, _PAGE_INVALID, PTRS_PER_PTE);
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index cab2f9c011a8..7b420424b6d7 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -103,16 +103,16 @@ UTS_MACHINE		:= sh
 LDFLAGS_vmlinux		+= -e _stext
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
-ld-bfd			:= elf32-sh-linux
-LDFLAGS_vmlinux		+= --defsym jiffies=jiffies_64 --oformat $(ld-bfd)
+ld_bfd			:= elf32-sh-linux
+LDFLAGS_vmlinux		+= --defsym jiffies=jiffies_64 --oformat $(ld_bfd)
 KBUILD_LDFLAGS		+= -EL
 else
-ld-bfd			:= elf32-shbig-linux
-LDFLAGS_vmlinux		+= --defsym jiffies=jiffies_64+4 --oformat $(ld-bfd)
+ld_bfd			:= elf32-shbig-linux
+LDFLAGS_vmlinux		+= --defsym jiffies=jiffies_64+4 --oformat $(ld_bfd)
 KBUILD_LDFLAGS		+= -EB
 endif
 
-export ld-bfd
+export ld_bfd
 
 # Mach groups
 machdir-$(CONFIG_SOLUTION_ENGINE)		+= mach-se
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index 8bc319ff54bf..58df491778b2 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -27,7 +27,7 @@ endif
 
 ccflags-remove-$(CONFIG_MCOUNT) += -pg
 
-LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext $(IMAGE_OFFSET) -e startup \
+LDFLAGS_vmlinux := --oformat $(ld_bfd) -Ttext $(IMAGE_OFFSET) -e startup \
 		   -T $(obj)/../../kernel/vmlinux.lds
 
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
@@ -51,7 +51,7 @@ $(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
 
 OBJCOPYFLAGS += -R .empty_zero_page
 
-LDFLAGS_piggy.o := -r --format binary --oformat $(ld-bfd) -T
+LDFLAGS_piggy.o := -r --format binary --oformat $(ld_bfd) -T
 
 $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.$(suffix_y) FORCE
 	$(call if_changed,ld)
diff --git a/arch/sh/boot/romimage/Makefile b/arch/sh/boot/romimage/Makefile
index c7c8be58400c..17b03df0a8de 100644
--- a/arch/sh/boot/romimage/Makefile
+++ b/arch/sh/boot/romimage/Makefile
@@ -13,7 +13,7 @@ mmcif-obj-$(CONFIG_CPU_SUBTYPE_SH7724)	:= $(obj)/mmcif-sh7724.o
 load-$(CONFIG_ROMIMAGE_MMCIF)		:= $(mmcif-load-y)
 obj-$(CONFIG_ROMIMAGE_MMCIF)		:= $(mmcif-obj-y)
 
-LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext $(load-y) -e romstart \
+LDFLAGS_vmlinux := --oformat $(ld_bfd) -Ttext $(load-y) -e romstart \
 		   -T $(obj)/../../kernel/vmlinux.lds
 
 $(obj)/vmlinux: $(obj)/head.o $(obj-y) $(obj)/piggy.o FORCE
@@ -24,7 +24,7 @@ OBJCOPYFLAGS += -j .empty_zero_page
 $(obj)/zeropage.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
-LDFLAGS_piggy.o := -r --format binary --oformat $(ld-bfd) -T
+LDFLAGS_piggy.o := -r --format binary --oformat $(ld_bfd) -T
 
 $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/zeropage.bin arch/sh/boot/zImage FORCE
 	$(call if_changed,ld)
diff --git a/arch/um/drivers/rtc_user.c b/arch/um/drivers/rtc_user.c
index 7c3cec4c68cf..006a5a164ea9 100644
--- a/arch/um/drivers/rtc_user.c
+++ b/arch/um/drivers/rtc_user.c
@@ -28,7 +28,7 @@ int uml_rtc_start(bool timetravel)
 	int err;
 
 	if (timetravel) {
-		int err = os_pipe(uml_rtc_irq_fds, 1, 1);
+		err = os_pipe(uml_rtc_irq_fds, 1, 1);
 		if (err)
 			goto fail;
 	} else {
diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
index d75237ba7ce9..5660d3229d29 100644
--- a/arch/x86/boot/cpuflags.c
+++ b/arch/x86/boot/cpuflags.c
@@ -115,5 +115,18 @@ void get_cpuflags(void)
 			cpuid(0x80000001, &ignored, &ignored, &cpu.flags[6],
 			      &cpu.flags[1]);
 		}
+
+		if (max_amd_level >= 0x8000001f) {
+			u32 ebx;
+
+			/*
+			 * The X86_FEATURE_COHERENCY_SFW_NO feature bit is in
+			 * the virtualization flags entry (word 8) and set by
+			 * scattered.c, so the bit needs to be explicitly set.
+			 */
+			cpuid(0x8000001f, &ignored, &ebx, &ignored, &ignored);
+			if (ebx & BIT(31))
+				set_bit(X86_FEATURE_COHERENCY_SFW_NO, cpu.flags);
+		}
 	}
 }
diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index 71de53194089..f5936da235c7 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -1243,6 +1243,24 @@ static void svsm_pval_terminate(struct svsm_pvalidate_call *pc, int ret, u64 svs
 	__pval_terminate(pfn, action, page_size, ret, svsm_ret);
 }
 
+static inline void sev_evict_cache(void *va, int npages)
+{
+	volatile u8 val __always_unused;
+	u8 *bytes = va;
+	int page_idx;
+
+	/*
+	 * For SEV guests, a read from the first/last cache-lines of a 4K page
+	 * using the guest key is sufficient to cause a flush of all cache-lines
+	 * associated with that 4K page without incurring all the overhead of a
+	 * full CLFLUSH sequence.
+	 */
+	for (page_idx = 0; page_idx < npages; page_idx++) {
+		val = bytes[page_idx * PAGE_SIZE];
+		val = bytes[page_idx * PAGE_SIZE + PAGE_SIZE - 1];
+	}
+}
+
 static void svsm_pval_4k_page(unsigned long paddr, bool validate)
 {
 	struct svsm_pvalidate_call *pc;
@@ -1295,6 +1313,13 @@ static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool val
 		if (ret)
 			__pval_terminate(PHYS_PFN(paddr), validate, RMP_PG_SIZE_4K, ret, 0);
 	}
+
+	/*
+	 * If validating memory (making it private) and affected by the
+	 * cache-coherency vulnerability, perform the cache eviction mitigation.
+	 */
+	if (validate && !has_cpuflag(X86_FEATURE_COHERENCY_SFW_NO))
+		sev_evict_cache((void *)vaddr, 1);
 }
 
 static void pval_pages(struct snp_psc_desc *desc)
@@ -1479,10 +1504,31 @@ static void svsm_pval_pages(struct snp_psc_desc *desc)
 
 static void pvalidate_pages(struct snp_psc_desc *desc)
 {
+	struct psc_entry *e;
+	unsigned int i;
+
 	if (snp_vmpl)
 		svsm_pval_pages(desc);
 	else
 		pval_pages(desc);
+
+	/*
+	 * If not affected by the cache-coherency vulnerability there is no need
+	 * to perform the cache eviction mitigation.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_COHERENCY_SFW_NO))
+		return;
+
+	for (i = 0; i <= desc->hdr.end_entry; i++) {
+		e = &desc->entries[i];
+
+		/*
+		 * If validating memory (making it private) perform the cache
+		 * eviction mitigation.
+		 */
+		if (e->operation == SNP_PAGE_STATE_PRIVATE)
+			sev_evict_cache(pfn_to_kaddr(e->gfn), e->pagesize ? 512 : 1);
+	}
 }
 
 static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index ef5749a0d8c2..98e72c1391f2 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -227,6 +227,7 @@
 #define X86_FEATURE_FLEXPRIORITY	( 8*32+ 1) /* "flexpriority" Intel FlexPriority */
 #define X86_FEATURE_EPT			( 8*32+ 2) /* "ept" Intel Extended Page Table */
 #define X86_FEATURE_VPID		( 8*32+ 3) /* "vpid" Intel Virtual Processor ID */
+#define X86_FEATURE_COHERENCY_SFW_NO	( 8*32+ 4) /* SNP cache coherency software work around not needed */
 
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* "vmmcall" Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* Xen paravirtual guest */
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index edebf1020e04..6bb3d9a86abe 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -92,8 +92,6 @@ struct irq_cfg {
 
 extern struct irq_cfg *irq_cfg(unsigned int irq);
 extern struct irq_cfg *irqd_cfg(struct irq_data *irq_data);
-extern void lock_vector_lock(void);
-extern void unlock_vector_lock(void);
 #ifdef CONFIG_SMP
 extern void vector_schedule_cleanup(struct irq_cfg *);
 extern void irq_complete_move(struct irq_cfg *cfg);
@@ -101,12 +99,16 @@ extern void irq_complete_move(struct irq_cfg *cfg);
 static inline void vector_schedule_cleanup(struct irq_cfg *c) { }
 static inline void irq_complete_move(struct irq_cfg *c) { }
 #endif
-
 extern void apic_ack_edge(struct irq_data *data);
-#else	/*  CONFIG_IRQ_DOMAIN_HIERARCHY */
+#endif /* CONFIG_IRQ_DOMAIN_HIERARCHY */
+
+#ifdef CONFIG_X86_LOCAL_APIC
+extern void lock_vector_lock(void);
+extern void unlock_vector_lock(void);
+#else
 static inline void lock_vector_lock(void) {}
 static inline void unlock_vector_lock(void) {}
-#endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
+#endif
 
 /* Statistics */
 extern atomic_t irq_err_count;
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index bc4993aa41ed..c463363ae1d4 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -47,6 +47,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_FAST_CPPC, 	CPUID_EDX, 15, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
+	{ X86_FEATURE_COHERENCY_SFW_NO,	CPUID_EBX, 31, 0x8000001f, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
 	{ X86_FEATURE_TSA_SQ_NO,	CPUID_ECX,  1, 0x80000021, 0 },
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 85fa2db38dc4..9400730e538e 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -251,26 +251,59 @@ static __always_inline void handle_irq(struct irq_desc *desc,
 		__handle_irq(desc, regs);
 }
 
-static __always_inline int call_irq_handler(int vector, struct pt_regs *regs)
+static struct irq_desc *reevaluate_vector(int vector)
 {
-	struct irq_desc *desc;
-	int ret = 0;
+	struct irq_desc *desc = __this_cpu_read(vector_irq[vector]);
+
+	if (!IS_ERR_OR_NULL(desc))
+		return desc;
+
+	if (desc == VECTOR_UNUSED)
+		pr_emerg_ratelimited("No irq handler for %d.%u\n", smp_processor_id(), vector);
+	else
+		__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
+	return NULL;
+}
+
+static __always_inline bool call_irq_handler(int vector, struct pt_regs *regs)
+{
+	struct irq_desc *desc = __this_cpu_read(vector_irq[vector]);
 
-	desc = __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		handle_irq(desc, regs);
-	} else {
-		ret = -EINVAL;
-		if (desc == VECTOR_UNUSED) {
-			pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
-					     __func__, smp_processor_id(),
-					     vector);
-		} else {
-			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
-		}
+		return true;
 	}
 
-	return ret;
+	/*
+	 * Reevaluate with vector_lock held to prevent a race against
+	 * request_irq() setting up the vector:
+	 *
+	 * CPU0				CPU1
+	 *				interrupt is raised in APIC IRR
+	 *				but not handled
+	 * free_irq()
+	 *   per_cpu(vector_irq, CPU1)[vector] = VECTOR_SHUTDOWN;
+	 *
+	 * request_irq()		common_interrupt()
+	 *				  d = this_cpu_read(vector_irq[vector]);
+	 *
+	 * per_cpu(vector_irq, CPU1)[vector] = desc;
+	 *
+	 *				  if (d == VECTOR_SHUTDOWN)
+	 *				    this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
+	 *
+	 * This requires that the same vector on the same target CPU is
+	 * handed out or that a spurious interrupt hits that CPU/vector.
+	 */
+	lock_vector_lock();
+	desc = reevaluate_vector(vector);
+	unlock_vector_lock();
+
+	if (!desc)
+		return false;
+
+	handle_irq(desc, regs);
+	return true;
 }
 
 /*
@@ -284,7 +317,7 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 	/* entry code tells RCU that we're not quiescent.  Check it. */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
-	if (unlikely(call_irq_handler(vector, regs)))
+	if (unlikely(!call_irq_handler(vector, regs)))
 		apic_eoi();
 
 	set_irq_regs(old_regs);
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 51986e8a9d35..52e22d3e1a82 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -122,13 +122,12 @@ static bool ex_handler_sgx(const struct exception_table_entry *fixup,
 static bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 				 struct pt_regs *regs)
 {
-	regs->ip = ex_fixup_addr(fixup);
-
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
 	fpu_reset_from_exception_fixup();
-	return true;
+
+	return ex_handler_default(fixup, regs);
 }
 
 /*
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 7858c92b4483..22ce7fa4fe20 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -320,12 +320,19 @@ static int blk_validate_limits(struct queue_limits *lim)
 	lim->max_discard_sectors =
 		min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors);
 
+	/*
+	 * When discard is not supported, discard_granularity should be reported
+	 * as 0 to userspace.
+	 */
+	if (lim->max_discard_sectors)
+		lim->discard_granularity =
+			max(lim->discard_granularity, lim->physical_block_size);
+	else
+		lim->discard_granularity = 0;
+
 	if (!lim->max_discard_segments)
 		lim->max_discard_segments = 1;
 
-	if (lim->discard_granularity < lim->physical_block_size)
-		lim->discard_granularity = lim->physical_block_size;
-
 	/*
 	 * By default there is no limit on the segment boundary alignment,
 	 * but if there is one it can't be smaller than the page size as
diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
index 1edf6e564402..df89c1c0da6d 100644
--- a/drivers/accel/ivpu/ivpu_debugfs.c
+++ b/drivers/accel/ivpu/ivpu_debugfs.c
@@ -346,49 +346,23 @@ static const struct file_operations ivpu_force_recovery_fops = {
 	.write = ivpu_force_recovery_fn,
 };
 
-static ssize_t
-ivpu_reset_engine_fn(struct file *file, const char __user *user_buf, size_t size, loff_t *pos)
+static int ivpu_reset_engine_fn(void *data, u64 val)
 {
-	struct ivpu_device *vdev = file->private_data;
-
-	if (!size)
-		return -EINVAL;
+	struct ivpu_device *vdev = (struct ivpu_device *)data;
 
-	if (ivpu_jsm_reset_engine(vdev, DRM_IVPU_ENGINE_COMPUTE))
-		return -ENODEV;
-	if (ivpu_jsm_reset_engine(vdev, DRM_IVPU_ENGINE_COPY))
-		return -ENODEV;
-
-	return size;
+	return ivpu_jsm_reset_engine(vdev, (u32)val);
 }
 
-static const struct file_operations ivpu_reset_engine_fops = {
-	.owner = THIS_MODULE,
-	.open = simple_open,
-	.write = ivpu_reset_engine_fn,
-};
+DEFINE_DEBUGFS_ATTRIBUTE(ivpu_reset_engine_fops, NULL, ivpu_reset_engine_fn, "0x%02llx\n");
 
-static ssize_t
-ivpu_resume_engine_fn(struct file *file, const char __user *user_buf, size_t size, loff_t *pos)
+static int ivpu_resume_engine_fn(void *data, u64 val)
 {
-	struct ivpu_device *vdev = file->private_data;
-
-	if (!size)
-		return -EINVAL;
+	struct ivpu_device *vdev = (struct ivpu_device *)data;
 
-	if (ivpu_jsm_hws_resume_engine(vdev, DRM_IVPU_ENGINE_COMPUTE))
-		return -ENODEV;
-	if (ivpu_jsm_hws_resume_engine(vdev, DRM_IVPU_ENGINE_COPY))
-		return -ENODEV;
-
-	return size;
+	return ivpu_jsm_hws_resume_engine(vdev, (u32)val);
 }
 
-static const struct file_operations ivpu_resume_engine_fops = {
-	.owner = THIS_MODULE,
-	.open = simple_open,
-	.write = ivpu_resume_engine_fn,
-};
+DEFINE_DEBUGFS_ATTRIBUTE(ivpu_resume_engine_fops, NULL, ivpu_resume_engine_fn, "0x%02llx\n");
 
 static int dct_active_get(void *data, u64 *active_percent)
 {
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3b1a5cdd6311..defcc964ecab 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2116,7 +2116,7 @@ static void ublk_deinit_queues(struct ublk_device *ub)
 
 	for (i = 0; i < nr_queues; i++)
 		ublk_deinit_queue(ub, i);
-	kfree(ub->__queues);
+	kvfree(ub->__queues);
 }
 
 static int ublk_init_queues(struct ublk_device *ub)
@@ -2127,7 +2127,7 @@ static int ublk_init_queues(struct ublk_device *ub)
 	int i, ret = -ENOMEM;
 
 	ub->queue_size = ubq_size;
-	ub->__queues = kcalloc(nr_queues, ubq_size, GFP_KERNEL);
+	ub->__queues = kvcalloc(nr_queues, ubq_size, GFP_KERNEL);
 	if (!ub->__queues)
 		return ret;
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 72b529757373..1d2e85b41820 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -511,6 +511,10 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3549), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Realtek 8851BU Bluetooth devices */
+	{ USB_DEVICE(0x3625, 0x010b), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index acfd673834ed..6505ce6ab1a2 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -509,8 +509,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_dw5932e_info = {
 	.sideband_wake = false,
 };
 
-static const struct mhi_pci_dev_info mhi_foxconn_t99w515_info = {
-	.name = "foxconn-t99w515",
+static const struct mhi_pci_dev_info mhi_foxconn_t99w640_info = {
+	.name = "foxconn-t99w640",
 	.edl = "qcom/sdx72m/foxconn/edl.mbn",
 	.edl_trigger = true,
 	.config = &modem_foxconn_sdx72_config,
@@ -792,9 +792,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	/* DW5932e (sdx62), Non-eSIM */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f9),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5932e_info },
-	/* T99W515 (sdx72) */
+	/* T99W640 (sdx72) */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe118),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w515_info },
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w640_info },
 	/* DW5934e(sdx72), With eSIM */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe11d),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5934e_info },
diff --git a/drivers/char/hw_random/mtk-rng.c b/drivers/char/hw_random/mtk-rng.c
index 1e3048f2bb38..6c4e40d0365f 100644
--- a/drivers/char/hw_random/mtk-rng.c
+++ b/drivers/char/hw_random/mtk-rng.c
@@ -142,7 +142,9 @@ static int mtk_rng_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, priv);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, RNG_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
-	devm_pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
 
 	dev_info(&pdev->dev, "registered RNG driver\n");
 
diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
index cbb8b220f16b..ffab32b047a0 100644
--- a/drivers/clk/at91/sam9x7.c
+++ b/drivers/clk/at91/sam9x7.c
@@ -61,44 +61,44 @@ static const struct clk_master_layout sam9x7_master_layout = {
 
 /* Fractional PLL core output range. */
 static const struct clk_range plla_core_outputs[] = {
-	{ .min = 375000000, .max = 1600000000 },
+	{ .min = 800000000, .max = 1600000000 },
 };
 
 static const struct clk_range upll_core_outputs[] = {
-	{ .min = 600000000, .max = 1200000000 },
+	{ .min = 600000000, .max = 960000000 },
 };
 
 static const struct clk_range lvdspll_core_outputs[] = {
-	{ .min = 400000000, .max = 800000000 },
+	{ .min = 600000000, .max = 1200000000 },
 };
 
 static const struct clk_range audiopll_core_outputs[] = {
-	{ .min = 400000000, .max = 800000000 },
+	{ .min = 600000000, .max = 1200000000 },
 };
 
 static const struct clk_range plladiv2_core_outputs[] = {
-	{ .min = 375000000, .max = 1600000000 },
+	{ .min = 800000000, .max = 1600000000 },
 };
 
 /* Fractional PLL output range. */
 static const struct clk_range plla_outputs[] = {
-	{ .min = 732421, .max = 800000000 },
+	{ .min = 400000000, .max = 800000000 },
 };
 
 static const struct clk_range upll_outputs[] = {
-	{ .min = 300000000, .max = 600000000 },
+	{ .min = 300000000, .max = 480000000 },
 };
 
 static const struct clk_range lvdspll_outputs[] = {
-	{ .min = 10000000, .max = 800000000 },
+	{ .min = 175000000, .max = 550000000 },
 };
 
 static const struct clk_range audiopll_outputs[] = {
-	{ .min = 10000000, .max = 800000000 },
+	{ .min = 0, .max = 300000000 },
 };
 
 static const struct clk_range plladiv2_outputs[] = {
-	{ .min = 366210, .max = 400000000 },
+	{ .min = 200000000, .max = 400000000 },
 };
 
 /* PLL characteristics. */
diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 934e53a96ddd..00bf799964c6 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -118,7 +118,7 @@ static const struct axi_clkgen_limits axi_clkgen_zynqmp_default_limits = {
 
 static const struct axi_clkgen_limits axi_clkgen_zynq_default_limits = {
 	.fpfd_min = 10000,
-	.fpfd_max = 300000,
+	.fpfd_max = 450000,
 	.fvco_min = 600000,
 	.fvco_max = 1200000,
 };
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index 355d1be0b5d8..a37fea7542b2 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -277,6 +277,11 @@ davinci_lpsc_clk_register(struct device *dev, const char *name,
 
 	lpsc->pm_domain.name = devm_kasprintf(dev, GFP_KERNEL, "%s: %s",
 					      best_dev_name(dev), name);
+	if (!lpsc->pm_domain.name) {
+		clk_hw_unregister(&lpsc->hw);
+		kfree(lpsc);
+		return ERR_PTR(-ENOMEM);
+	}
 	lpsc->pm_domain.attach_dev = davinci_psc_genpd_attach_dev;
 	lpsc->pm_domain.detach_dev = davinci_psc_genpd_detach_dev;
 	lpsc->pm_domain.flags = GENPD_FLAG_PM_CLK;
diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
index 564e9f3f7508..5030e6e60b66 100644
--- a/drivers/clk/imx/clk-imx95-blk-ctl.c
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -323,8 +323,10 @@ static int imx95_bc_probe(struct platform_device *pdev)
 	if (!clk_hw_data)
 		return -ENOMEM;
 
-	if (bc_data->rpm_enabled)
-		pm_runtime_enable(&pdev->dev);
+	if (bc_data->rpm_enabled) {
+		devm_pm_runtime_enable(&pdev->dev);
+		pm_runtime_resume_and_get(&pdev->dev);
+	}
 
 	clk_hw_data->num = bc_data->num_clks;
 	hws = clk_hw_data->hws;
@@ -364,8 +366,10 @@ static int imx95_bc_probe(struct platform_device *pdev)
 		goto cleanup;
 	}
 
-	if (pm_runtime_enabled(bc->dev))
+	if (pm_runtime_enabled(bc->dev)) {
+		pm_runtime_put_sync(&pdev->dev);
 		clk_disable_unprepare(bc->clk_apb);
+	}
 
 	return 0;
 
@@ -376,9 +380,6 @@ static int imx95_bc_probe(struct platform_device *pdev)
 		clk_hw_unregister(hws[i]);
 	}
 
-	if (bc_data->rpm_enabled)
-		pm_runtime_disable(&pdev->dev);
-
 	return ret;
 }
 
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index b524a9d33610..5f8116e39e22 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -312,6 +312,7 @@ rzv2h_cpg_ddiv_clk_register(const struct cpg_core_clk *core,
 	init.ops = &rzv2h_ddiv_clk_divider_ops;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_PARENT;
 
 	ddiv->priv = priv;
 	ddiv->mon = cfg_ddiv.monbit;
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index d24c0d8dfee4..3416e0020799 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -347,8 +347,7 @@ static SUNXI_CCU_GATE(dram_ohci_clk,	"dram-ohci",	"dram",
 
 static const char * const de_parents[] = { "pll-video", "pll-periph0" };
 static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
-				 0x104, 0, 4, 24, 2, BIT(31),
-				 CLK_SET_RATE_PARENT);
+				 0x104, 0, 4, 24, 3, BIT(31), 0);
 
 static const char * const tcon_parents[] = { "pll-video" };
 static SUNXI_CCU_M_WITH_MUX_GATE(tcon_clk, "tcon", tcon_parents,
diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 4c9555fc6184..6ab89245af12 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -582,7 +582,14 @@ static const struct clk_parent_data peri2sys_apb_pclk_pd[] = {
 	{ .hw = &peri2sys_apb_pclk.common.hw }
 };
 
-static CLK_FIXED_FACTOR_FW_NAME(osc12m_clk, "osc_12m", "osc_24m", 2, 1, 0);
+static struct clk_fixed_factor osc12m_clk = {
+	.div		= 2,
+	.mult		= 1,
+	.hw.init	= CLK_HW_INIT_PARENTS_DATA("osc_12m",
+						   osc_24m_clk,
+						   &clk_fixed_factor_ops,
+						   0),
+};
 
 static const char * const out_parents[] = { "osc_24m", "osc_12m" };
 
diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
index 81501b48412e..88b3fd8250c2 100644
--- a/drivers/clk/xilinx/xlnx_vcu.c
+++ b/drivers/clk/xilinx/xlnx_vcu.c
@@ -587,8 +587,8 @@ static void xvcu_unregister_clock_provider(struct xvcu_device *xvcu)
 		xvcu_clk_hw_unregister_leaf(hws[CLK_XVCU_ENC_MCU]);
 	if (!IS_ERR_OR_NULL(hws[CLK_XVCU_ENC_CORE]))
 		xvcu_clk_hw_unregister_leaf(hws[CLK_XVCU_ENC_CORE]);
-
-	clk_hw_unregister_fixed_factor(xvcu->pll_post);
+	if (!IS_ERR_OR_NULL(xvcu->pll_post))
+		clk_hw_unregister_fixed_factor(xvcu->pll_post);
 }
 
 /**
diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index 7a979db81f09..ccbc826cc4c0 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -132,7 +132,7 @@ static int __init armada_8k_cpufreq_init(void)
 	int ret = 0, opps_index = 0, cpu, nb_cpus;
 	struct freq_table *freq_tables;
 	struct device_node *node;
-	static struct cpumask cpus;
+	static struct cpumask cpus, shared_cpus;
 
 	node = of_find_matching_node_and_match(NULL, armada_8k_cpufreq_of_match,
 					       NULL);
@@ -154,7 +154,6 @@ static int __init armada_8k_cpufreq_init(void)
 	 * divisions of it).
 	 */
 	for_each_cpu(cpu, &cpus) {
-		struct cpumask shared_cpus;
 		struct device *cpu_dev;
 		struct clk *clk;
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1f52bced4c29..fab94ffcb22c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1275,6 +1275,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_free_real_cpus;
 	}
 
+	init_rwsem(&policy->rwsem);
+
 	freq_constraints_init(&policy->constraints);
 
 	policy->nb_min.notifier_call = cpufreq_notifier_min;
@@ -1297,7 +1299,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	}
 
 	INIT_LIST_HEAD(&policy->policy_list);
-	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
 	init_waitqueue_head(&policy->transition_wait);
 	INIT_WORK(&policy->update, handle_update);
@@ -2961,15 +2962,6 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	cpufreq_driver = driver_data;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	/*
-	 * Mark support for the scheduler's frequency invariance engine for
-	 * drivers that implement target(), target_index() or fast_switch().
-	 */
-	if (!cpufreq_driver->setpolicy) {
-		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
-		pr_debug("supports frequency invariance");
-	}
-
 	if (driver_data->setpolicy)
 		driver_data->flags |= CPUFREQ_CONST_LOOPS;
 
@@ -3000,6 +2992,15 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	hp_online = ret;
 	ret = 0;
 
+	/*
+	 * Mark support for the scheduler's frequency invariance engine for
+	 * drivers that implement target(), target_index() or fast_switch().
+	 */
+	if (!cpufreq_driver->setpolicy) {
+		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
+		pr_debug("supports frequency invariance");
+	}
+
 	pr_debug("driver %s up and running\n", driver_data->name);
 	goto out;
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 54e7310454cc..b86372aa341d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3128,8 +3128,8 @@ static int intel_cpufreq_update_pstate(struct cpufreq_policy *policy,
 		int max_pstate = policy->strict_target ?
 					target_pstate : cpu->max_perf_ratio;
 
-		intel_cpufreq_hwp_update(cpu, target_pstate, max_pstate, 0,
-					 fast_switch);
+		intel_cpufreq_hwp_update(cpu, target_pstate, max_pstate,
+					 target_pstate, fast_switch);
 	} else if (target_pstate != old_pstate) {
 		intel_cpufreq_perf_ctl_update(cpu, target_pstate, fast_switch);
 	}
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 05f67661553c..63e66a85477e 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -265,8 +265,8 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 	}
 
 	chan->timeout = areq->cryptlen;
-	rctx->nr_sgs = nr_sgs;
-	rctx->nr_sgd = nr_sgd;
+	rctx->nr_sgs = ns;
+	rctx->nr_sgd = nd;
 	return 0;
 
 theend_sgs:
diff --git a/drivers/crypto/ccp/ccp-debugfs.c b/drivers/crypto/ccp/ccp-debugfs.c
index a1055554b47a..dc26bc22c91d 100644
--- a/drivers/crypto/ccp/ccp-debugfs.c
+++ b/drivers/crypto/ccp/ccp-debugfs.c
@@ -319,5 +319,8 @@ void ccp5_debugfs_setup(struct ccp_device *ccp)
 
 void ccp5_debugfs_destroy(void)
 {
+	mutex_lock(&ccp_debugfs_lock);
 	debugfs_remove_recursive(ccp_debugfs_dir);
+	ccp_debugfs_dir = NULL;
+	mutex_unlock(&ccp_debugfs_lock);
 }
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index af018afd9cd7..4d072c084d7b 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -424,7 +424,7 @@ static int rmp_mark_pages_firmware(unsigned long paddr, unsigned int npages, boo
 	return rc;
 }
 
-static struct page *__snp_alloc_firmware_pages(gfp_t gfp_mask, int order)
+static struct page *__snp_alloc_firmware_pages(gfp_t gfp_mask, int order, bool locked)
 {
 	unsigned long npages = 1ul << order, paddr;
 	struct sev_device *sev;
@@ -443,7 +443,7 @@ static struct page *__snp_alloc_firmware_pages(gfp_t gfp_mask, int order)
 		return page;
 
 	paddr = __pa((unsigned long)page_address(page));
-	if (rmp_mark_pages_firmware(paddr, npages, false))
+	if (rmp_mark_pages_firmware(paddr, npages, locked))
 		return NULL;
 
 	return page;
@@ -453,7 +453,7 @@ void *snp_alloc_firmware_page(gfp_t gfp_mask)
 {
 	struct page *page;
 
-	page = __snp_alloc_firmware_pages(gfp_mask, 0);
+	page = __snp_alloc_firmware_pages(gfp_mask, 0, false);
 
 	return page ? page_address(page) : NULL;
 }
@@ -488,7 +488,7 @@ static void *sev_fw_alloc(unsigned long len)
 {
 	struct page *page;
 
-	page = __snp_alloc_firmware_pages(GFP_KERNEL, get_order(len));
+	page = __snp_alloc_firmware_pages(GFP_KERNEL, get_order(len), true);
 	if (!page)
 		return NULL;
 
diff --git a/drivers/crypto/img-hash.c b/drivers/crypto/img-hash.c
index 7e93159c3b6b..d5df3d2da50c 100644
--- a/drivers/crypto/img-hash.c
+++ b/drivers/crypto/img-hash.c
@@ -436,7 +436,7 @@ static int img_hash_write_via_dma_stop(struct img_hash_dev *hdev)
 	struct img_hash_request_ctx *ctx = ahash_request_ctx(hdev->req);
 
 	if (ctx->flags & DRIVER_FLAGS_SG)
-		dma_unmap_sg(hdev->dev, ctx->sg, ctx->dma_ct, DMA_TO_DEVICE);
+		dma_unmap_sg(hdev->dev, ctx->sg, 1, DMA_TO_DEVICE);
 
 	return 0;
 }
diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index f44c08f5f5ec..af4b978189e5 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -249,7 +249,9 @@ static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv,
 	safexcel_complete(priv, ring);
 
 	if (sreq->nents) {
-		dma_unmap_sg(priv->dev, areq->src, sreq->nents, DMA_TO_DEVICE);
+		dma_unmap_sg(priv->dev, areq->src,
+			     sg_nents_for_len(areq->src, areq->nbytes),
+			     DMA_TO_DEVICE);
 		sreq->nents = 0;
 	}
 
@@ -497,7 +499,9 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 			 DMA_FROM_DEVICE);
 unmap_sg:
 	if (req->nents) {
-		dma_unmap_sg(priv->dev, areq->src, req->nents, DMA_TO_DEVICE);
+		dma_unmap_sg(priv->dev, areq->src,
+			     sg_nents_for_len(areq->src, areq->nbytes),
+			     DMA_TO_DEVICE);
 		req->nents = 0;
 	}
 cdesc_rollback:
diff --git a/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c b/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
index e54c79890d44..fdeca861933c 100644
--- a/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
+++ b/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
@@ -68,6 +68,7 @@ struct ocs_hcu_ctx {
  * @sg_data_total:  Total data in the SG list at any time.
  * @sg_data_offset: Offset into the data of the current individual SG node.
  * @sg_dma_nents:   Number of sg entries mapped in dma_list.
+ * @nents:          Number of entries in the scatterlist.
  */
 struct ocs_hcu_rctx {
 	struct ocs_hcu_dev	*hcu_dev;
@@ -91,6 +92,7 @@ struct ocs_hcu_rctx {
 	unsigned int		sg_data_total;
 	unsigned int		sg_data_offset;
 	unsigned int		sg_dma_nents;
+	unsigned int		nents;
 };
 
 /**
@@ -199,7 +201,7 @@ static void kmb_ocs_hcu_dma_cleanup(struct ahash_request *req,
 
 	/* Unmap req->src (if mapped). */
 	if (rctx->sg_dma_nents) {
-		dma_unmap_sg(dev, req->src, rctx->sg_dma_nents, DMA_TO_DEVICE);
+		dma_unmap_sg(dev, req->src, rctx->nents, DMA_TO_DEVICE);
 		rctx->sg_dma_nents = 0;
 	}
 
@@ -260,6 +262,10 @@ static int kmb_ocs_dma_prepare(struct ahash_request *req)
 			rc = -ENOMEM;
 			goto cleanup;
 		}
+
+		/* Save the value of nents to pass to dma_unmap_sg. */
+		rctx->nents = nents;
+
 		/*
 		 * The value returned by dma_map_sg() can be < nents; so update
 		 * nents accordingly.
diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
index a17adc4beda2..ef5f03be4190 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
@@ -199,7 +199,6 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 			  ICP_ACCEL_CAPABILITIES_SM4 |
 			  ICP_ACCEL_CAPABILITIES_AES_V2 |
 			  ICP_ACCEL_CAPABILITIES_ZUC |
-			  ICP_ACCEL_CAPABILITIES_ZUC_256 |
 			  ICP_ACCEL_CAPABILITIES_WIRELESS_CRYPTO_EXT |
 			  ICP_ACCEL_CAPABILITIES_EXT_ALGCHAIN;
 
@@ -231,17 +230,11 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 
 	if (fusectl1 & ICP_ACCEL_GEN4_MASK_WCP_WAT_SLICE) {
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_ZUC;
-		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_ZUC_256;
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_WIRELESS_CRYPTO_EXT;
 	}
 
-	if (fusectl1 & ICP_ACCEL_GEN4_MASK_EIA3_SLICE) {
+	if (fusectl1 & ICP_ACCEL_GEN4_MASK_EIA3_SLICE)
 		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_ZUC;
-		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_ZUC_256;
-	}
-
-	if (fusectl1 & ICP_ACCEL_GEN4_MASK_ZUC_256_SLICE)
-		capabilities_sym &= ~ICP_ACCEL_CAPABILITIES_ZUC_256;
 
 	capabilities_asym = ICP_ACCEL_CAPABILITIES_CRYPTO_ASYMMETRIC |
 			  ICP_ACCEL_CAPABILITIES_SM2 |
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
index 41a0979e68c1..e70adb90e5e4 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
@@ -585,6 +585,28 @@ static int bank_state_restore(struct adf_hw_csr_ops *ops, void __iomem *base,
 	ops->write_csr_int_srcsel_w_val(base, bank, state->iaintflagsrcsel0);
 	ops->write_csr_exp_int_en(base, bank, state->ringexpintenable);
 	ops->write_csr_int_col_ctl(base, bank, state->iaintcolctl);
+
+	/*
+	 * Verify whether any exceptions were raised during the bank save process.
+	 * If exceptions occurred, the status and exception registers cannot
+	 * be directly restored. Consequently, further restoration is not
+	 * feasible, and the current state of the ring should be maintained.
+	 */
+	val = state->ringexpstat;
+	if (val) {
+		pr_info("QAT: Bank %u state not fully restored due to exception in saved state (%#x)\n",
+			bank, val);
+		return 0;
+	}
+
+	/* Ensure that the restoration process completed without exceptions */
+	tmp_val = ops->read_csr_exp_stat(base, bank);
+	if (tmp_val) {
+		pr_err("QAT: Bank %u restored with exception: %#x\n",
+		       bank, tmp_val);
+		return -EFAULT;
+	}
+
 	ops->write_csr_ring_srv_arb_en(base, bank, state->ringsrvarben);
 
 	/* Check that all ring statuses match the saved state. */
@@ -618,13 +640,6 @@ static int bank_state_restore(struct adf_hw_csr_ops *ops, void __iomem *base,
 	if (ret)
 		return ret;
 
-	tmp_val = ops->read_csr_exp_stat(base, bank);
-	val = state->ringexpstat;
-	if (tmp_val && !val) {
-		pr_err("QAT: Bank was restored with exception: 0x%x\n", val);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_sriov.c b/drivers/crypto/intel/qat/qat_common/adf_sriov.c
index c75d0b6cb0ad..31d1ef0cb1f5 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_sriov.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_sriov.c
@@ -155,7 +155,6 @@ static int adf_do_enable_sriov(struct adf_accel_dev *accel_dev)
 	if (!device_iommu_mapped(&GET_DEV(accel_dev))) {
 		dev_warn(&GET_DEV(accel_dev),
 			 "IOMMU should be enabled for SR-IOV to work correctly\n");
-		return -EINVAL;
 	}
 
 	if (adf_dev_started(accel_dev)) {
diff --git a/drivers/crypto/intel/qat/qat_common/adf_transport_debug.c b/drivers/crypto/intel/qat/qat_common/adf_transport_debug.c
index e2dd568b87b5..621b5d3dfcef 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_transport_debug.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_transport_debug.c
@@ -31,8 +31,10 @@ static void *adf_ring_next(struct seq_file *sfile, void *v, loff_t *pos)
 	struct adf_etr_ring_data *ring = sfile->private;
 
 	if (*pos >= (ADF_SIZE_TO_RING_SIZE_IN_BYTES(ring->ring_size) /
-		     ADF_MSG_SIZE_TO_BYTES(ring->msg_size)))
+		     ADF_MSG_SIZE_TO_BYTES(ring->msg_size))) {
+		(*pos)++;
 		return NULL;
+	}
 
 	return ring->base_addr +
 		(ADF_MSG_SIZE_TO_BYTES(ring->msg_size) * (*pos)++);
diff --git a/drivers/crypto/intel/qat/qat_common/qat_bl.c b/drivers/crypto/intel/qat/qat_common/qat_bl.c
index 338acf29c487..5a7b43f9150d 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_bl.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_bl.c
@@ -38,7 +38,7 @@ void qat_bl_free_bufl(struct adf_accel_dev *accel_dev,
 		for (i = 0; i < blout->num_mapped_bufs; i++) {
 			dma_unmap_single(dev, blout->buffers[i].addr,
 					 blout->buffers[i].len,
-					 DMA_FROM_DEVICE);
+					 DMA_BIDIRECTIONAL);
 		}
 		dma_unmap_single(dev, blpout, sz_out, DMA_TO_DEVICE);
 
@@ -162,7 +162,7 @@ static int __qat_bl_sgl_to_bufl(struct adf_accel_dev *accel_dev,
 			}
 			buffers[y].addr = dma_map_single(dev, sg_virt(sg) + left,
 							 sg->length - left,
-							 DMA_FROM_DEVICE);
+							 DMA_BIDIRECTIONAL);
 			if (unlikely(dma_mapping_error(dev, buffers[y].addr)))
 				goto err_out;
 			buffers[y].len = sg->length;
@@ -204,7 +204,7 @@ static int __qat_bl_sgl_to_bufl(struct adf_accel_dev *accel_dev,
 		if (!dma_mapping_error(dev, buflout->buffers[i].addr))
 			dma_unmap_single(dev, buflout->buffers[i].addr,
 					 buflout->buffers[i].len,
-					 DMA_FROM_DEVICE);
+					 DMA_BIDIRECTIONAL);
 	}
 
 	if (!buf->sgl_dst_valid)
diff --git a/drivers/crypto/intel/qat/qat_common/qat_compression.c b/drivers/crypto/intel/qat/qat_common/qat_compression.c
index 7842a9f22178..cf94ba3011d5 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_compression.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_compression.c
@@ -197,7 +197,7 @@ static int qat_compression_alloc_dc_data(struct adf_accel_dev *accel_dev)
 	struct adf_dc_data *dc_data = NULL;
 	u8 *obuff = NULL;
 
-	dc_data = devm_kzalloc(dev, sizeof(*dc_data), GFP_KERNEL);
+	dc_data = kzalloc_node(sizeof(*dc_data), GFP_KERNEL, dev_to_node(dev));
 	if (!dc_data)
 		goto err;
 
@@ -205,7 +205,7 @@ static int qat_compression_alloc_dc_data(struct adf_accel_dev *accel_dev)
 	if (!obuff)
 		goto err;
 
-	obuff_p = dma_map_single(dev, obuff, ovf_buff_sz, DMA_FROM_DEVICE);
+	obuff_p = dma_map_single(dev, obuff, ovf_buff_sz, DMA_BIDIRECTIONAL);
 	if (unlikely(dma_mapping_error(dev, obuff_p)))
 		goto err;
 
@@ -233,9 +233,9 @@ static void qat_free_dc_data(struct adf_accel_dev *accel_dev)
 		return;
 
 	dma_unmap_single(dev, dc_data->ovf_buff_p, dc_data->ovf_buff_sz,
-			 DMA_FROM_DEVICE);
+			 DMA_BIDIRECTIONAL);
 	kfree_sensitive(dc_data->ovf_buff);
-	devm_kfree(dev, dc_data);
+	kfree(dc_data);
 	accel_dev->dc_data = NULL;
 }
 
diff --git a/drivers/crypto/marvell/cesa/cipher.c b/drivers/crypto/marvell/cesa/cipher.c
index 3876e3ce822f..eabed9d977df 100644
--- a/drivers/crypto/marvell/cesa/cipher.c
+++ b/drivers/crypto/marvell/cesa/cipher.c
@@ -75,9 +75,12 @@ mv_cesa_skcipher_dma_cleanup(struct skcipher_request *req)
 static inline void mv_cesa_skcipher_cleanup(struct skcipher_request *req)
 {
 	struct mv_cesa_skcipher_req *creq = skcipher_request_ctx(req);
+	struct mv_cesa_engine *engine = creq->base.engine;
 
 	if (mv_cesa_req_get_type(&creq->base) == CESA_DMA_REQ)
 		mv_cesa_skcipher_dma_cleanup(req);
+
+	atomic_sub(req->cryptlen, &engine->load);
 }
 
 static void mv_cesa_skcipher_std_step(struct skcipher_request *req)
@@ -212,7 +215,6 @@ mv_cesa_skcipher_complete(struct crypto_async_request *req)
 	struct mv_cesa_engine *engine = creq->base.engine;
 	unsigned int ivsize;
 
-	atomic_sub(skreq->cryptlen, &engine->load);
 	ivsize = crypto_skcipher_ivsize(crypto_skcipher_reqtfm(skreq));
 
 	if (mv_cesa_req_get_type(&creq->base) == CESA_DMA_REQ) {
diff --git a/drivers/crypto/marvell/cesa/hash.c b/drivers/crypto/marvell/cesa/hash.c
index 6815eddc9068..e339ce7ad533 100644
--- a/drivers/crypto/marvell/cesa/hash.c
+++ b/drivers/crypto/marvell/cesa/hash.c
@@ -110,9 +110,12 @@ static inline void mv_cesa_ahash_dma_cleanup(struct ahash_request *req)
 static inline void mv_cesa_ahash_cleanup(struct ahash_request *req)
 {
 	struct mv_cesa_ahash_req *creq = ahash_request_ctx(req);
+	struct mv_cesa_engine *engine = creq->base.engine;
 
 	if (mv_cesa_req_get_type(&creq->base) == CESA_DMA_REQ)
 		mv_cesa_ahash_dma_cleanup(req);
+
+	atomic_sub(req->nbytes, &engine->load);
 }
 
 static void mv_cesa_ahash_last_cleanup(struct ahash_request *req)
@@ -395,8 +398,6 @@ static void mv_cesa_ahash_complete(struct crypto_async_request *req)
 			}
 		}
 	}
-
-	atomic_sub(ahashreq->nbytes, &engine->load);
 }
 
 static void mv_cesa_ahash_prepare(struct crypto_async_request *req,
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 98657d3b9435..0d9f3d3282ec 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1382,15 +1382,11 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 		int ret;
 		struct device *dev = devfreq->dev.parent;
 
+		if (!devfreq->governor)
+			continue;
+
 		if (!strncmp(devfreq->governor->name, governor->name,
 			     DEVFREQ_NAME_LEN)) {
-			/* we should have a devfreq governor! */
-			if (!devfreq->governor) {
-				dev_warn(dev, "%s: Governor %s NOT present\n",
-					 __func__, governor->name);
-				continue;
-				/* Fall through */
-			}
 			ret = devfreq->governor->event_handler(devfreq,
 						DEVFREQ_GOV_STOP, NULL);
 			if (ret) {
@@ -1743,7 +1739,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	for (i = 0; i < max_state; i++) {
 		if (len >= PAGE_SIZE - 1)
 			break;
-		if (df->freq_table[2] == df->previous_freq)
+		if (df->freq_table[i] == df->previous_freq)
 			len += sysfs_emit_at(buf, len, "*");
 		else
 			len += sysfs_emit_at(buf, len, " ");
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index b76fe99e1151..f88792049be5 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -641,7 +641,7 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 	int chan_num = TDMA_CHANNEL_NUM;
 	struct gen_pool *pool = NULL;
 
-	type = (enum mmp_tdma_type)device_get_match_data(&pdev->dev);
+	type = (kernel_ulong_t)device_get_match_data(&pdev->dev);
 
 	/* always have couple channels */
 	tdev = devm_kzalloc(&pdev->dev, sizeof(*tdev), GFP_KERNEL);
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 40b76b40bc30..184813766cd1 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1061,8 +1061,16 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	 */
 	mv_chan->dummy_src_addr = dma_map_single(dma_dev->dev,
 		mv_chan->dummy_src, MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dma_dev->dev, mv_chan->dummy_src_addr))
+		return ERR_PTR(-ENOMEM);
+
 	mv_chan->dummy_dst_addr = dma_map_single(dma_dev->dev,
 		mv_chan->dummy_dst, MV_XOR_MIN_BYTE_COUNT, DMA_TO_DEVICE);
+	if (dma_mapping_error(dma_dev->dev, mv_chan->dummy_dst_addr)) {
+		ret = -ENOMEM;
+		goto err_unmap_src;
+	}
+
 
 	/* allocate coherent memory for hardware descriptors
 	 * note: writecombine gives slightly better performance, but
@@ -1071,8 +1079,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	mv_chan->dma_desc_pool_virt =
 	  dma_alloc_wc(&pdev->dev, MV_XOR_POOL_SIZE, &mv_chan->dma_desc_pool,
 		       GFP_KERNEL);
-	if (!mv_chan->dma_desc_pool_virt)
-		return ERR_PTR(-ENOMEM);
+	if (!mv_chan->dma_desc_pool_virt) {
+		ret = -ENOMEM;
+		goto err_unmap_dst;
+	}
 
 	/* discover transaction capabilities from the platform data */
 	dma_dev->cap_mask = cap_mask;
@@ -1155,6 +1165,13 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 err_free_dma:
 	dma_free_coherent(&pdev->dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
+err_unmap_dst:
+	dma_unmap_single(dma_dev->dev, mv_chan->dummy_dst_addr,
+			 MV_XOR_MIN_BYTE_COUNT, DMA_TO_DEVICE);
+err_unmap_src:
+	dma_unmap_single(dma_dev->dev, mv_chan->dummy_src_addr,
+			 MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
+
 	return ERR_PTR(ret);
 }
 
diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 5f5d6242427e..2fa6e90643d5 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -711,6 +711,9 @@ static int nbpf_desc_page_alloc(struct nbpf_channel *chan)
 		list_add_tail(&ldesc->node, &lhead);
 		ldesc->hwdesc_dma_addr = dma_map_single(dchan->device->dev,
 					hwdesc, sizeof(*hwdesc), DMA_TO_DEVICE);
+		if (dma_mapping_error(dchan->device->dev,
+				      ldesc->hwdesc_dma_addr))
+			goto unmap_error;
 
 		dev_dbg(dev, "%s(): mapped 0x%p to %pad\n", __func__,
 			hwdesc, &ldesc->hwdesc_dma_addr);
@@ -737,6 +740,16 @@ static int nbpf_desc_page_alloc(struct nbpf_channel *chan)
 	spin_unlock_irq(&chan->lock);
 
 	return ARRAY_SIZE(dpage->desc);
+
+unmap_error:
+	while (i--) {
+		ldesc--; hwdesc--;
+
+		dma_unmap_single(dchan->device->dev, ldesc->hwdesc_dma_addr,
+				 sizeof(hwdesc), DMA_TO_DEVICE);
+	}
+
+	return -ENOMEM;
 }
 
 static void nbpf_desc_put(struct nbpf_desc *desc)
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index c7e5a34b254b..683fd9b85c5c 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -892,7 +892,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 			freq = dom->opp[idx].indicative_freq * dom->mult_factor;
 
 		/* All OPPs above the sustained frequency are treated as turbo */
-		data.turbo = freq > dom->sustained_freq_khz * 1000;
+		data.turbo = freq > dom->sustained_freq_khz * 1000UL;
 
 		data.level = dom->opp[idx].perf;
 		data.freq = freq;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 24d711b0e634..9a1c9dbad126 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9510,9 +9510,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9559,9 +9558,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 114653a0b570..91af1adbf5e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7318,8 +7318,8 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		DRM_ERROR("fail to remap queue\n");
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 5dc3454d7d36..f27ccb8f3c8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3640,9 +3640,8 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index d1bd79bbae53..8e401f8b2a05 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -32,9 +32,6 @@
 
 #define NPS_MODE_MASK 0x000000FFL
 
-/* Core 0 Port 0 counter */
-#define smnPCIEP_NAK_COUNTER 0x1A340218
-
 static void nbio_v7_9_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -453,22 +450,6 @@ static void nbio_v7_9_init_registers(struct amdgpu_device *adev)
 	}
 }
 
-static u64 nbio_v7_9_get_pcie_replay_count(struct amdgpu_device *adev)
-{
-	u32 val, nak_r, nak_g;
-
-	if (adev->flags & AMD_IS_APU)
-		return 0;
-
-	/* Get the number of NAKs received and generated */
-	val = RREG32_PCIE(smnPCIEP_NAK_COUNTER);
-	nak_r = val & 0xFFFF;
-	nak_g = val >> 16;
-
-	/* Add the total number of NAKs, i.e the number of replays */
-	return (nak_r + nak_g);
-}
-
 #define MMIO_REG_HOLE_OFFSET 0x1A000
 
 static void nbio_v7_9_set_reg_remap(struct amdgpu_device *adev)
@@ -509,7 +490,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_compute_partition_mode = nbio_v7_9_get_compute_partition_mode,
 	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
 	.init_registers = nbio_v7_9_init_registers,
-	.get_pcie_replay_count = nbio_v7_9_get_pcie_replay_count,
 	.set_reg_remap = nbio_v7_9_set_reg_remap,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index 79a566f3564a..c305ea4ec17d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -149,7 +149,7 @@ int phm_wait_on_indirect_register(struct pp_hwmgr *hwmgr,
 	}
 
 	cgs_write_register(hwmgr->device, indirect_port, index);
-	return phm_wait_on_register(hwmgr, indirect_port + 1, mask, value);
+	return phm_wait_on_register(hwmgr, indirect_port + 1, value, mask);
 }
 
 int phm_wait_for_register_unequal(struct pp_hwmgr *hwmgr,
diff --git a/drivers/gpu/drm/i915/display/g4x_hdmi.c b/drivers/gpu/drm/i915/display/g4x_hdmi.c
index 46f23bdb4c17..b89a364a3924 100644
--- a/drivers/gpu/drm/i915/display/g4x_hdmi.c
+++ b/drivers/gpu/drm/i915/display/g4x_hdmi.c
@@ -683,7 +683,7 @@ static bool assert_hdmi_port_valid(struct drm_i915_private *i915, enum port port
 			 "Platform does not support HDMI %c\n", port_name(port));
 }
 
-void g4x_hdmi_init(struct drm_i915_private *dev_priv,
+bool g4x_hdmi_init(struct drm_i915_private *dev_priv,
 		   i915_reg_t hdmi_reg, enum port port)
 {
 	struct intel_display *display = &dev_priv->display;
@@ -693,10 +693,10 @@ void g4x_hdmi_init(struct drm_i915_private *dev_priv,
 	struct intel_connector *intel_connector;
 
 	if (!assert_port_valid(dev_priv, port))
-		return;
+		return false;
 
 	if (!assert_hdmi_port_valid(dev_priv, port))
-		return;
+		return false;
 
 	devdata = intel_bios_encoder_data_lookup(display, port);
 
@@ -707,15 +707,13 @@ void g4x_hdmi_init(struct drm_i915_private *dev_priv,
 
 	dig_port = kzalloc(sizeof(*dig_port), GFP_KERNEL);
 	if (!dig_port)
-		return;
+		return false;
 
 	dig_port->aux_ch = AUX_CH_NONE;
 
 	intel_connector = intel_connector_alloc();
-	if (!intel_connector) {
-		kfree(dig_port);
-		return;
-	}
+	if (!intel_connector)
+		goto err_connector_alloc;
 
 	intel_encoder = &dig_port->base;
 
@@ -723,9 +721,10 @@ void g4x_hdmi_init(struct drm_i915_private *dev_priv,
 
 	mutex_init(&dig_port->hdcp_mutex);
 
-	drm_encoder_init(&dev_priv->drm, &intel_encoder->base,
-			 &intel_hdmi_enc_funcs, DRM_MODE_ENCODER_TMDS,
-			 "HDMI %c", port_name(port));
+	if (drm_encoder_init(&dev_priv->drm, &intel_encoder->base,
+			     &intel_hdmi_enc_funcs, DRM_MODE_ENCODER_TMDS,
+			     "HDMI %c", port_name(port)))
+		goto err_encoder_init;
 
 	intel_encoder->hotplug = intel_hdmi_hotplug;
 	intel_encoder->compute_config = g4x_hdmi_compute_config;
@@ -788,5 +787,17 @@ void g4x_hdmi_init(struct drm_i915_private *dev_priv,
 
 	intel_infoframe_init(dig_port);
 
-	intel_hdmi_init_connector(dig_port, intel_connector);
+	if (!intel_hdmi_init_connector(dig_port, intel_connector))
+		goto err_init_connector;
+
+	return true;
+
+err_init_connector:
+	drm_encoder_cleanup(&intel_encoder->base);
+err_encoder_init:
+	kfree(intel_connector);
+err_connector_alloc:
+	kfree(dig_port);
+
+	return false;
 }
diff --git a/drivers/gpu/drm/i915/display/g4x_hdmi.h b/drivers/gpu/drm/i915/display/g4x_hdmi.h
index 817f55c7a3a1..a52e8986ec7a 100644
--- a/drivers/gpu/drm/i915/display/g4x_hdmi.h
+++ b/drivers/gpu/drm/i915/display/g4x_hdmi.h
@@ -16,14 +16,15 @@ struct drm_connector;
 struct drm_i915_private;
 
 #ifdef I915
-void g4x_hdmi_init(struct drm_i915_private *dev_priv,
+bool g4x_hdmi_init(struct drm_i915_private *dev_priv,
 		   i915_reg_t hdmi_reg, enum port port);
 int g4x_hdmi_connector_atomic_check(struct drm_connector *connector,
 				    struct drm_atomic_state *state);
 #else
-static inline void g4x_hdmi_init(struct drm_i915_private *dev_priv,
+static inline bool g4x_hdmi_init(struct drm_i915_private *dev_priv,
 				 i915_reg_t hdmi_reg, int port)
 {
+	return false;
 }
 static inline int g4x_hdmi_connector_atomic_check(struct drm_connector *connector,
 						  struct drm_atomic_state *state)
diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 34dee523f0b6..5b24460c0134 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4413,8 +4413,7 @@ static const struct drm_encoder_funcs intel_ddi_funcs = {
 	.late_register = intel_ddi_encoder_late_register,
 };
 
-static struct intel_connector *
-intel_ddi_init_dp_connector(struct intel_digital_port *dig_port)
+static int intel_ddi_init_dp_connector(struct intel_digital_port *dig_port)
 {
 	struct drm_i915_private *i915 = to_i915(dig_port->base.base.dev);
 	struct intel_connector *connector;
@@ -4422,7 +4421,7 @@ intel_ddi_init_dp_connector(struct intel_digital_port *dig_port)
 
 	connector = intel_connector_alloc();
 	if (!connector)
-		return NULL;
+		return -ENOMEM;
 
 	dig_port->dp.output_reg = DDI_BUF_CTL(port);
 	if (DISPLAY_VER(i915) >= 14)
@@ -4437,7 +4436,7 @@ intel_ddi_init_dp_connector(struct intel_digital_port *dig_port)
 
 	if (!intel_dp_init_connector(dig_port, connector)) {
 		kfree(connector);
-		return NULL;
+		return -EINVAL;
 	}
 
 	if (dig_port->base.type == INTEL_OUTPUT_EDP) {
@@ -4453,7 +4452,7 @@ intel_ddi_init_dp_connector(struct intel_digital_port *dig_port)
 		}
 	}
 
-	return connector;
+	return 0;
 }
 
 static int intel_hdmi_reset_link(struct intel_encoder *encoder,
@@ -4623,20 +4622,28 @@ static bool bdw_digital_port_connected(struct intel_encoder *encoder)
 	return intel_de_read(dev_priv, GEN8_DE_PORT_ISR) & bit;
 }
 
-static struct intel_connector *
-intel_ddi_init_hdmi_connector(struct intel_digital_port *dig_port)
+static int intel_ddi_init_hdmi_connector(struct intel_digital_port *dig_port)
 {
 	struct intel_connector *connector;
 	enum port port = dig_port->base.port;
 
 	connector = intel_connector_alloc();
 	if (!connector)
-		return NULL;
+		return -ENOMEM;
 
 	dig_port->hdmi.hdmi_reg = DDI_BUF_CTL(port);
-	intel_hdmi_init_connector(dig_port, connector);
 
-	return connector;
+	if (!intel_hdmi_init_connector(dig_port, connector)) {
+		/*
+		 * HDMI connector init failures may just mean conflicting DDC
+		 * pins or not having enough lanes. Handle them gracefully, but
+		 * don't fail the entire DDI init.
+		 */
+		dig_port->hdmi.hdmi_reg = INVALID_MMIO_REG;
+		kfree(connector);
+	}
+
+	return 0;
 }
 
 static bool intel_ddi_a_force_4_lanes(struct intel_digital_port *dig_port)
@@ -4791,8 +4798,10 @@ static void intel_ddi_tc_encoder_suspend_complete(struct intel_encoder *encoder)
 
 static void intel_ddi_encoder_shutdown(struct intel_encoder *encoder)
 {
-	intel_dp_encoder_shutdown(encoder);
-	intel_hdmi_encoder_shutdown(encoder);
+	if (intel_encoder_is_dp(encoder))
+		intel_dp_encoder_shutdown(encoder);
+	if (intel_encoder_is_hdmi(encoder))
+		intel_hdmi_encoder_shutdown(encoder);
 }
 
 static void intel_ddi_tc_encoder_shutdown_complete(struct intel_encoder *encoder)
@@ -5185,7 +5194,7 @@ void intel_ddi_init(struct intel_display *display,
 	intel_infoframe_init(dig_port);
 
 	if (init_dp) {
-		if (!intel_ddi_init_dp_connector(dig_port))
+		if (intel_ddi_init_dp_connector(dig_port))
 			goto err;
 
 		dig_port->hpd_pulse = intel_dp_hpd_pulse;
@@ -5199,7 +5208,7 @@ void intel_ddi_init(struct intel_display *display,
 	 * but leave it just in case we have some really bad VBTs...
 	 */
 	if (encoder->type != INTEL_OUTPUT_EDP && init_hdmi) {
-		if (!intel_ddi_init_hdmi_connector(dig_port))
+		if (intel_ddi_init_hdmi_connector(dig_port))
 			goto err;
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 3e24d2e90d3c..9812191e7ef2 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -2075,6 +2075,19 @@ static inline bool intel_encoder_is_dp(struct intel_encoder *encoder)
 	}
 }
 
+static inline bool intel_encoder_is_hdmi(struct intel_encoder *encoder)
+{
+	switch (encoder->type) {
+	case INTEL_OUTPUT_HDMI:
+		return true;
+	case INTEL_OUTPUT_DDI:
+		/* See if the HDMI encoder is valid. */
+		return i915_mmio_reg_valid(enc_to_intel_hdmi(encoder)->hdmi_reg);
+	default:
+		return false;
+	}
+}
+
 static inline struct intel_lspcon *
 enc_to_intel_lspcon(struct intel_encoder *encoder)
 {
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index cd9ee171e0df..c5b2fbaeff89 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3015,7 +3015,7 @@ void intel_infoframe_init(struct intel_digital_port *dig_port)
 	}
 }
 
-void intel_hdmi_init_connector(struct intel_digital_port *dig_port,
+bool intel_hdmi_init_connector(struct intel_digital_port *dig_port,
 			       struct intel_connector *intel_connector)
 {
 	struct intel_display *display = to_intel_display(dig_port);
@@ -3033,17 +3033,17 @@ void intel_hdmi_init_connector(struct intel_digital_port *dig_port,
 		    intel_encoder->base.base.id, intel_encoder->base.name);
 
 	if (DISPLAY_VER(display) < 12 && drm_WARN_ON(dev, port == PORT_A))
-		return;
+		return false;
 
 	if (drm_WARN(dev, dig_port->max_lanes < 4,
 		     "Not enough lanes (%d) for HDMI on [ENCODER:%d:%s]\n",
 		     dig_port->max_lanes, intel_encoder->base.base.id,
 		     intel_encoder->base.name))
-		return;
+		return false;
 
 	ddc_pin = intel_hdmi_ddc_pin(intel_encoder);
 	if (!ddc_pin)
-		return;
+		return false;
 
 	drm_connector_init_with_ddc(dev, connector,
 				    &intel_hdmi_connector_funcs,
@@ -3088,6 +3088,8 @@ void intel_hdmi_init_connector(struct intel_digital_port *dig_port,
 					   &conn_info);
 	if (!intel_hdmi->cec_notifier)
 		drm_dbg_kms(display->drm, "CEC notifier get failed\n");
+
+	return true;
 }
 
 /*
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.h b/drivers/gpu/drm/i915/display/intel_hdmi.h
index 9b97623665c5..fc64a3affc71 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -22,7 +22,7 @@ struct intel_encoder;
 struct intel_hdmi;
 union hdmi_infoframe;
 
-void intel_hdmi_init_connector(struct intel_digital_port *dig_port,
+bool intel_hdmi_init_connector(struct intel_digital_port *dig_port,
 			       struct intel_connector *intel_connector);
 bool intel_hdmi_compute_has_hdmi_sink(struct intel_encoder *encoder,
 				      const struct intel_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
index 485c3041c801..67f0694a2f10 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
@@ -383,6 +383,7 @@ static const struct dpu_perf_cfg sc8180x_perf_data = {
 	.min_core_ib = 2400000,
 	.min_llcc_ib = 800000,
 	.min_dram_ib = 800000,
+	.min_prefill_lines = 24,
 	.danger_lut_tbl = {0xf, 0xffff, 0x0},
 	.safe_lut_tbl = {0xfff0, 0xf000, 0xffff},
 	.qos_lut_tbl = {
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 3385fd3ef41a..5d0dce10336b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -29,7 +29,7 @@ static void panfrost_devfreq_update_utilization(struct panfrost_devfreq *pfdevfr
 static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 				   u32 flags)
 {
-	struct panfrost_device *ptdev = dev_get_drvdata(dev);
+	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
 	int err;
 
@@ -40,7 +40,7 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 
 	err = dev_pm_opp_set_rate(dev, *freq);
 	if (!err)
-		ptdev->pfdevfreq.current_frequency = *freq;
+		pfdev->pfdevfreq.current_frequency = *freq;
 
 	return err;
 }
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index cfe8b793d344..69ab8d4f289c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -52,16 +52,9 @@ rockchip_fb_create(struct drm_device *dev, struct drm_file *file,
 	}
 
 	if (drm_is_afbc(mode_cmd->modifier[0])) {
-		int ret, i;
-
 		ret = drm_gem_fb_afbc_init(dev, mode_cmd, afbc_fb);
 		if (ret) {
-			struct drm_gem_object **obj = afbc_fb->base.obj;
-
-			for (i = 0; i < info->num_planes; ++i)
-				drm_gem_object_put(obj[i]);
-
-			kfree(afbc_fb);
+			drm_framebuffer_put(&afbc_fb->base);
 			return ERR_PTR(ret);
 		}
 	}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index 7fb1c88bcc47..69dfe69ce0f8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -896,7 +896,7 @@ int vmw_compat_shader_add(struct vmw_private *dev_priv,
 		.busy_domain = VMW_BO_DOMAIN_SYS,
 		.bo_type = ttm_bo_type_device,
 		.size = size,
-		.pin = true,
+		.pin = false,
 		.keep_resv = true,
 	};
 
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 82da51a6616a..2e1d6d248d2e 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -549,6 +549,7 @@ static void update_device_info(struct xe_device *xe)
 	/* disable features that are not available/applicable to VFs */
 	if (IS_SRIOV_VF(xe)) {
 		xe->info.probe_display = 0;
+		xe->info.has_heci_cscfi = 0;
 		xe->info.has_heci_gscfi = 0;
 		xe->info.skip_guc_pc = 1;
 		xe->info.skip_pcode = 1;
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index d900dd05c335..c00ce5bfec4a 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -890,7 +890,8 @@ static int apple_magic_backlight_init(struct hid_device *hdev)
 	backlight->brightness = report_enum->report_id_hash[APPLE_MAGIC_REPORT_ID_BRIGHTNESS];
 	backlight->power = report_enum->report_id_hash[APPLE_MAGIC_REPORT_ID_POWER];
 
-	if (!backlight->brightness || !backlight->power)
+	if (!backlight->brightness || backlight->brightness->maxfield < 2 ||
+	    !backlight->power || backlight->power->maxfield < 2)
 		return -ENODEV;
 
 	backlight->cdev.name = ":white:" LED_FUNCTION_KBD_BACKLIGHT;
diff --git a/drivers/i2c/muxes/i2c-mux-mule.c b/drivers/i2c/muxes/i2c-mux-mule.c
index 284ff4afeeac..d3b32b794172 100644
--- a/drivers/i2c/muxes/i2c-mux-mule.c
+++ b/drivers/i2c/muxes/i2c-mux-mule.c
@@ -47,7 +47,6 @@ static int mule_i2c_mux_probe(struct platform_device *pdev)
 	struct mule_i2c_reg_mux *priv;
 	struct i2c_client *client;
 	struct i2c_mux_core *muxc;
-	struct device_node *dev;
 	unsigned int readback;
 	int ndev, ret;
 	bool old_fw;
@@ -95,7 +94,7 @@ static int mule_i2c_mux_probe(struct platform_device *pdev)
 				     "Failed to register mux remove\n");
 
 	/* Create device adapters */
-	for_each_child_of_node(mux_dev->of_node, dev) {
+	for_each_child_of_node_scoped(mux_dev->of_node, dev) {
 		u32 reg;
 
 		ret = of_property_read_u32(dev, "reg", &reg);
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 51d619edb6c5..e56ba86d460e 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -597,7 +597,8 @@ static struct erdma_mtt *erdma_create_cont_mtt(struct erdma_dev *dev,
 static void erdma_destroy_mtt_buf_sg(struct erdma_dev *dev,
 				     struct erdma_mtt *mtt)
 {
-	dma_unmap_sg(&dev->pdev->dev, mtt->sglist, mtt->nsg, DMA_TO_DEVICE);
+	dma_unmap_sg(&dev->pdev->dev, mtt->sglist,
+		     DIV_ROUND_UP(mtt->size, PAGE_SIZE), DMA_TO_DEVICE);
 	vfree(mtt->sglist);
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 560a1d9de408..cbe73d9ad525 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -856,6 +856,7 @@ struct hns_roce_caps {
 	u16		default_ceq_arm_st;
 	u8		cong_cap;
 	enum hns_roce_cong_type default_cong_type;
+	u32             max_ack_req_msg_len;
 };
 
 enum hns_roce_device_state {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index ca0798224e56..3d479c63b117 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -249,15 +249,12 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 }
 
 static struct hns_roce_hem *hns_roce_alloc_hem(struct hns_roce_dev *hr_dev,
-					       unsigned long hem_alloc_size,
-					       gfp_t gfp_mask)
+					       unsigned long hem_alloc_size)
 {
 	struct hns_roce_hem *hem;
 	int order;
 	void *buf;
 
-	WARN_ON(gfp_mask & __GFP_HIGHMEM);
-
 	order = get_order(hem_alloc_size);
 	if (PAGE_SIZE << order != hem_alloc_size) {
 		dev_err(hr_dev->dev, "invalid hem_alloc_size: %lu!\n",
@@ -265,13 +262,12 @@ static struct hns_roce_hem *hns_roce_alloc_hem(struct hns_roce_dev *hr_dev,
 		return NULL;
 	}
 
-	hem = kmalloc(sizeof(*hem),
-		      gfp_mask & ~(__GFP_HIGHMEM | __GFP_NOWARN));
+	hem = kmalloc(sizeof(*hem), GFP_KERNEL);
 	if (!hem)
 		return NULL;
 
 	buf = dma_alloc_coherent(hr_dev->dev, hem_alloc_size,
-				 &hem->dma, gfp_mask);
+				 &hem->dma, GFP_KERNEL);
 	if (!buf)
 		goto fail;
 
@@ -378,7 +374,6 @@ static int alloc_mhop_hem(struct hns_roce_dev *hr_dev,
 {
 	u32 bt_size = mhop->bt_chunk_size;
 	struct device *dev = hr_dev->dev;
-	gfp_t flag;
 	u64 bt_ba;
 	u32 size;
 	int ret;
@@ -417,8 +412,7 @@ static int alloc_mhop_hem(struct hns_roce_dev *hr_dev,
 	 * alloc bt space chunk for MTT/CQE.
 	 */
 	size = table->type < HEM_TYPE_MTT ? mhop->buf_chunk_size : bt_size;
-	flag = GFP_KERNEL | __GFP_NOWARN;
-	table->hem[index->buf] = hns_roce_alloc_hem(hr_dev, size, flag);
+	table->hem[index->buf] = hns_roce_alloc_hem(hr_dev, size);
 	if (!table->hem[index->buf]) {
 		ret = -ENOMEM;
 		goto err_alloc_hem;
@@ -546,9 +540,7 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 		goto out;
 	}
 
-	table->hem[i] = hns_roce_alloc_hem(hr_dev,
-				       table->table_chunk_size,
-				       GFP_KERNEL | __GFP_NOWARN);
+	table->hem[i] = hns_roce_alloc_hem(hr_dev, table->table_chunk_size);
 	if (!table->hem[i]) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 81e44b738122..53fe0ef3883d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2181,31 +2181,36 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_query_caps(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_cmq_desc desc[HNS_ROCE_QUERY_PF_CAPS_CMD_NUM];
+	struct hns_roce_cmq_desc desc[HNS_ROCE_QUERY_PF_CAPS_CMD_NUM] = {};
 	struct hns_roce_caps *caps = &hr_dev->caps;
 	struct hns_roce_query_pf_caps_a *resp_a;
 	struct hns_roce_query_pf_caps_b *resp_b;
 	struct hns_roce_query_pf_caps_c *resp_c;
 	struct hns_roce_query_pf_caps_d *resp_d;
 	struct hns_roce_query_pf_caps_e *resp_e;
+	struct hns_roce_query_pf_caps_f *resp_f;
 	enum hns_roce_opcode_type cmd;
 	int ctx_hop_num;
 	int pbl_hop_num;
+	int cmd_num;
 	int ret;
 	int i;
 
 	cmd = hr_dev->is_vf ? HNS_ROCE_OPC_QUERY_VF_CAPS_NUM :
 	      HNS_ROCE_OPC_QUERY_PF_CAPS_NUM;
+	cmd_num = hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 ?
+		  HNS_ROCE_QUERY_PF_CAPS_CMD_NUM_HIP08 :
+		  HNS_ROCE_QUERY_PF_CAPS_CMD_NUM;
 
-	for (i = 0; i < HNS_ROCE_QUERY_PF_CAPS_CMD_NUM; i++) {
+	for (i = 0; i < cmd_num - 1; i++) {
 		hns_roce_cmq_setup_basic_desc(&desc[i], cmd, true);
-		if (i < (HNS_ROCE_QUERY_PF_CAPS_CMD_NUM - 1))
-			desc[i].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
-		else
-			desc[i].flag &= ~cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
+		desc[i].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 	}
 
-	ret = hns_roce_cmq_send(hr_dev, desc, HNS_ROCE_QUERY_PF_CAPS_CMD_NUM);
+	hns_roce_cmq_setup_basic_desc(&desc[cmd_num - 1], cmd, true);
+	desc[cmd_num - 1].flag &= ~cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
+
+	ret = hns_roce_cmq_send(hr_dev, desc, cmd_num);
 	if (ret)
 		return ret;
 
@@ -2214,6 +2219,7 @@ static int hns_roce_query_caps(struct hns_roce_dev *hr_dev)
 	resp_c = (struct hns_roce_query_pf_caps_c *)desc[2].data;
 	resp_d = (struct hns_roce_query_pf_caps_d *)desc[3].data;
 	resp_e = (struct hns_roce_query_pf_caps_e *)desc[4].data;
+	resp_f = (struct hns_roce_query_pf_caps_f *)desc[5].data;
 
 	caps->local_ca_ack_delay = resp_a->local_ca_ack_delay;
 	caps->max_sq_sg = le16_to_cpu(resp_a->max_sq_sg);
@@ -2278,6 +2284,8 @@ static int hns_roce_query_caps(struct hns_roce_dev *hr_dev)
 	caps->reserved_srqs = hr_reg_read(resp_e, PF_CAPS_E_RSV_SRQS);
 	caps->reserved_lkey = hr_reg_read(resp_e, PF_CAPS_E_RSV_LKEYS);
 
+	caps->max_ack_req_msg_len = le32_to_cpu(resp_f->max_ack_req_msg_len);
+
 	caps->qpc_hop_num = ctx_hop_num;
 	caps->sccc_hop_num = ctx_hop_num;
 	caps->srqc_hop_num = ctx_hop_num;
@@ -2971,14 +2979,22 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 {
 	int ret;
 
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
+		ret = free_mr_init(hr_dev);
+		if (ret) {
+			dev_err(hr_dev->dev, "failed to init free mr!\n");
+			return ret;
+		}
+	}
+
 	/* The hns ROCEE requires the extdb info to be cleared before using */
 	ret = hns_roce_clear_extdb_list_info(hr_dev);
 	if (ret)
-		return ret;
+		goto err_clear_extdb_failed;
 
 	ret = get_hem_table(hr_dev);
 	if (ret)
-		return ret;
+		goto err_get_hem_table_failed;
 
 	if (hr_dev->is_vf)
 		return 0;
@@ -2993,6 +3009,11 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 
 err_llm_init_failed:
 	put_hem_table(hr_dev);
+err_get_hem_table_failed:
+	hns_roce_function_clear(hr_dev);
+err_clear_extdb_failed:
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08)
+		free_mr_exit(hr_dev);
 
 	return ret;
 }
@@ -4546,7 +4567,9 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	dma_addr_t trrl_ba;
 	dma_addr_t irrl_ba;
 	enum ib_mtu ib_mtu;
+	u8 ack_req_freq;
 	const u8 *smac;
+	int lp_msg_len;
 	u8 lp_pktn_ini;
 	u64 *mtts;
 	u8 *dmac;
@@ -4629,7 +4652,8 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		return -EINVAL;
 #define MIN_LP_MSG_LEN 1024
 	/* mtu * (2 ^ lp_pktn_ini) should be in the range of 1024 to mtu */
-	lp_pktn_ini = ilog2(max(mtu, MIN_LP_MSG_LEN) / mtu);
+	lp_msg_len = max(mtu, MIN_LP_MSG_LEN);
+	lp_pktn_ini = ilog2(lp_msg_len / mtu);
 
 	if (attr_mask & IB_QP_PATH_MTU) {
 		hr_reg_write(context, QPC_MTU, ib_mtu);
@@ -4639,8 +4663,22 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	hr_reg_write(context, QPC_LP_PKTN_INI, lp_pktn_ini);
 	hr_reg_clear(qpc_mask, QPC_LP_PKTN_INI);
 
-	/* ACK_REQ_FREQ should be larger than or equal to LP_PKTN_INI */
-	hr_reg_write(context, QPC_ACK_REQ_FREQ, lp_pktn_ini);
+	/*
+	 * There are several constraints for ACK_REQ_FREQ:
+	 * 1. mtu * (2 ^ ACK_REQ_FREQ) should not be too large, otherwise
+	 *    it may cause some unexpected retries when sending large
+	 *    payload.
+	 * 2. ACK_REQ_FREQ should be larger than or equal to LP_PKTN_INI.
+	 * 3. ACK_REQ_FREQ must be equal to LP_PKTN_INI when using LDCP
+	 *    or HC3 congestion control algorithm.
+	 */
+	if (hr_qp->cong_type == CONG_TYPE_LDCP ||
+	    hr_qp->cong_type == CONG_TYPE_HC3 ||
+	    hr_dev->caps.max_ack_req_msg_len < lp_msg_len)
+		ack_req_freq = lp_pktn_ini;
+	else
+		ack_req_freq = ilog2(hr_dev->caps.max_ack_req_msg_len / mtu);
+	hr_reg_write(context, QPC_ACK_REQ_FREQ, ack_req_freq);
 	hr_reg_clear(qpc_mask, QPC_ACK_REQ_FREQ);
 
 	hr_reg_clear(qpc_mask, QPC_RX_REQ_PSN_ERR);
@@ -5333,11 +5371,10 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
-	struct hns_roce_v2_qp_context ctx[2];
-	struct hns_roce_v2_qp_context *context = ctx;
-	struct hns_roce_v2_qp_context *qpc_mask = ctx + 1;
+	struct hns_roce_v2_qp_context *context;
+	struct hns_roce_v2_qp_context *qpc_mask;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	int ret;
+	int ret = -ENOMEM;
 
 	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
 		return -EOPNOTSUPP;
@@ -5348,7 +5385,11 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	 * we should set all bits of the relevant fields in context mask to
 	 * 0 at the same time, else set them to 0x1.
 	 */
-	memset(context, 0, hr_dev->caps.qpc_sz);
+	context = kvzalloc(sizeof(*context), GFP_KERNEL);
+	qpc_mask = kvzalloc(sizeof(*qpc_mask), GFP_KERNEL);
+	if (!context || !qpc_mask)
+		goto out;
+
 	memset(qpc_mask, 0xff, hr_dev->caps.qpc_sz);
 
 	ret = hns_roce_v2_set_abs_fields(ibqp, attr, attr_mask, cur_state,
@@ -5390,6 +5431,8 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 		clear_qp(hr_qp);
 
 out:
+	kvfree(qpc_mask);
+	kvfree(context);
 	return ret;
 }
 
@@ -7027,21 +7070,11 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 		goto error_failed_roce_init;
 	}
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
-		ret = free_mr_init(hr_dev);
-		if (ret) {
-			dev_err(hr_dev->dev, "failed to init free mr!\n");
-			goto error_failed_free_mr_init;
-		}
-	}
 
 	handle->priv = hr_dev;
 
 	return 0;
 
-error_failed_free_mr_init:
-	hns_roce_exit(hr_dev);
-
 error_failed_roce_init:
 	kfree(hr_dev->priv);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index bc7466830eaf..1c2660305d27 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1168,7 +1168,8 @@ struct hns_roce_cfg_gmv_tb_b {
 #define GMV_TB_B_SMAC_H GMV_TB_B_FIELD_LOC(47, 32)
 #define GMV_TB_B_SGID_IDX GMV_TB_B_FIELD_LOC(71, 64)
 
-#define HNS_ROCE_QUERY_PF_CAPS_CMD_NUM 5
+#define HNS_ROCE_QUERY_PF_CAPS_CMD_NUM_HIP08 5
+#define HNS_ROCE_QUERY_PF_CAPS_CMD_NUM 6
 struct hns_roce_query_pf_caps_a {
 	u8 number_ports;
 	u8 local_ca_ack_delay;
@@ -1280,6 +1281,11 @@ struct hns_roce_query_pf_caps_e {
 	__le16 aeq_period;
 };
 
+struct hns_roce_query_pf_caps_f {
+	__le32 max_ack_req_msg_len;
+	__le32 rsv[5];
+};
+
 #define PF_CAPS_E_FIELD_LOC(h, l) \
 	FIELD_LOC(struct hns_roce_query_pf_caps_e, h, l)
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index e7a497cc125c..11fa64044a8d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -947,10 +947,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 static void hns_roce_teardown_hca(struct hns_roce_dev *hr_dev)
 {
 	hns_roce_cleanup_bitmap(hr_dev);
-
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
-	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
-		mutex_destroy(&hr_dev->pgdir_mutex);
+	mutex_destroy(&hr_dev->pgdir_mutex);
 }
 
 /**
@@ -965,11 +962,11 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 
 	spin_lock_init(&hr_dev->sm_lock);
 
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
-	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) {
-		INIT_LIST_HEAD(&hr_dev->pgdir_list);
-		mutex_init(&hr_dev->pgdir_mutex);
-	}
+	INIT_LIST_HEAD(&hr_dev->qp_list);
+	spin_lock_init(&hr_dev->qp_list_lock);
+
+	INIT_LIST_HEAD(&hr_dev->pgdir_list);
+	mutex_init(&hr_dev->pgdir_mutex);
 
 	hns_roce_init_uar_table(hr_dev);
 
@@ -1001,9 +998,7 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 
 err_uar_table_free:
 	ida_destroy(&hr_dev->uar_ida.ida);
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
-	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
-		mutex_destroy(&hr_dev->pgdir_mutex);
+	mutex_destroy(&hr_dev->pgdir_mutex);
 
 	return ret;
 }
@@ -1132,9 +1127,6 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 		}
 	}
 
-	INIT_LIST_HEAD(&hr_dev->qp_list);
-	spin_lock_init(&hr_dev->qp_list_lock);
-
 	ret = hns_roce_register_device(hr_dev);
 	if (ret)
 		goto error_failed_register_device;
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 73d67c853b6f..48fef989318b 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -561,7 +561,7 @@ static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		req.ah_attr.dest_port = ROCE_V2_UDP_DPORT;
 		req.ah_attr.src_port = rdma_get_udp_sport(attr->ah_attr.grh.flow_label,
 							  ibqp->qp_num, attr->dest_qp_num);
-		req.ah_attr.traffic_class = attr->ah_attr.grh.traffic_class;
+		req.ah_attr.traffic_class = attr->ah_attr.grh.traffic_class >> 2;
 		req.ah_attr.hop_limit = attr->ah_attr.grh.hop_limit;
 	}
 
diff --git a/drivers/infiniband/hw/mlx5/dm.c b/drivers/infiniband/hw/mlx5/dm.c
index b4c97fb62abf..9ded2b7c1e31 100644
--- a/drivers/infiniband/hw/mlx5/dm.c
+++ b/drivers/infiniband/hw/mlx5/dm.c
@@ -282,7 +282,7 @@ static struct ib_dm *handle_alloc_dm_memic(struct ib_ucontext *ctx,
 	int err;
 	u64 address;
 
-	if (!MLX5_CAP_DEV_MEM(dm_db->dev, memic))
+	if (!dm_db || !MLX5_CAP_DEV_MEM(dm_db->dev, memic))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 793f3c5c4d01..80c665d15218 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -32,13 +32,15 @@ static __be64 get_umr_disable_mr_mask(void)
 	return cpu_to_be64(result);
 }
 
-static __be64 get_umr_update_translation_mask(void)
+static __be64 get_umr_update_translation_mask(struct mlx5_ib_dev *dev)
 {
 	u64 result;
 
 	result = MLX5_MKEY_MASK_LEN |
 		 MLX5_MKEY_MASK_PAGE_SIZE |
 		 MLX5_MKEY_MASK_START_ADDR;
+	if (MLX5_CAP_GEN_2(dev->mdev, umr_log_entity_size_5))
+		result |= MLX5_MKEY_MASK_PAGE_SIZE_5;
 
 	return cpu_to_be64(result);
 }
@@ -654,7 +656,7 @@ static void mlx5r_umr_final_update_xlt(struct mlx5_ib_dev *dev,
 		flags & MLX5_IB_UPD_XLT_ENABLE || flags & MLX5_IB_UPD_XLT_ADDR;
 
 	if (update_translation) {
-		wqe->ctrl_seg.mkey_mask |= get_umr_update_translation_mask();
+		wqe->ctrl_seg.mkey_mask |= get_umr_update_translation_mask(dev);
 		if (!mr->ibmr.length)
 			MLX5_SET(mkc, &wqe->mkey_seg, length64, 1);
 	}
diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index 03d626776ba1..576f90a7d55f 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -1492,34 +1492,40 @@ static struct qcom_icc_bcm bcm_sh3 = {
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
+	.num_nodes = 1,
 	.nodes = { &slv_qns_gemnoc_sf }
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
+	.num_nodes = 1,
 	.nodes = { &slv_qxs_imem }
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
 	.keepalive = true,
+	.num_nodes = 1,
 	.nodes = { &slv_qns_gemnoc_gc }
 };
 
 static struct qcom_icc_bcm bcm_co2 = {
 	.name = "CO2",
+	.num_nodes = 1,
 	.nodes = { &mas_qnm_npu }
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
 	.keepalive = true,
+	.num_nodes = 2,
 	.nodes = { &slv_srvc_aggre1_noc,
 		  &slv_qns_cnoc }
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
+	.num_nodes = 1,
 	.nodes = { &slv_qxs_pimem }
 };
 
diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index 7acd152bf0dd..fab5978ed9d3 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -48,6 +48,7 @@ static struct qcom_icc_node qnm_a1noc_cfg = {
 	.id = SC8280XP_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.num_links = 1,
 	.links = { SC8280XP_SLAVE_SERVICE_A1NOC },
 };
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 23e78a034da8..6a019670efc7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -483,8 +483,8 @@ static inline void pdev_disable_cap_pasid(struct pci_dev *pdev)
 
 static void pdev_enable_caps(struct pci_dev *pdev)
 {
-	pdev_enable_cap_ats(pdev);
 	pdev_enable_cap_pasid(pdev);
+	pdev_enable_cap_ats(pdev);
 	pdev_enable_cap_pri(pdev);
 }
 
@@ -2352,8 +2352,21 @@ static inline u64 dma_max_address(void)
 	if (amd_iommu_pgtable == AMD_IOMMU_V1)
 		return ~0ULL;
 
-	/* V2 with 4/5 level page table */
-	return ((1ULL << PM_LEVEL_SHIFT(amd_iommu_gpt_level)) - 1);
+	/*
+	 * V2 with 4/5 level page table. Note that "2.2.6.5 AMD64 4-Kbyte Page
+	 * Translation" shows that the V2 table sign extends the top of the
+	 * address space creating a reserved region in the middle of the
+	 * translation, just like the CPU does. Further Vasant says the docs are
+	 * incomplete and this only applies to non-zero PASIDs. If the AMDv2
+	 * page table is assigned to the 0 PASID then there is no sign extension
+	 * check.
+	 *
+	 * Since the IOMMU must have a fixed geometry, and the core code does
+	 * not understand sign extended addressing, we have to chop off the high
+	 * bit to get consistent behavior with attachments of the domain to any
+	 * PASID.
+	 */
+	return ((1ULL << (PM_LEVEL_SHIFT(amd_iommu_gpt_level) - 1)) - 1);
 }
 
 static bool amd_iommu_hd_support(struct amd_iommu *iommu)
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a799a89195c5..5d5b3cf381b9 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -506,6 +506,7 @@ config IMX_MU_MSI
 	tristate "i.MX MU used as MSI controller"
 	depends on OF && HAS_IOMEM
 	depends on ARCH_MXC || COMPILE_TEST
+	depends on ARM || ARM64
 	default m if ARCH_MXC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index da50f6661bae..48ce750bf70a 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -164,68 +164,40 @@ static void bch_invalidate_one_bucket(struct cache *ca, struct bucket *b)
  * prio is worth 1/8th of what INITIAL_PRIO is worth.
  */
 
-static inline unsigned int new_bucket_prio(struct cache *ca, struct bucket *b)
-{
-	unsigned int min_prio = (INITIAL_PRIO - ca->set->min_prio) / 8;
-
-	return (b->prio - ca->set->min_prio + min_prio) * GC_SECTORS_USED(b);
-}
-
-static inline bool new_bucket_max_cmp(const void *l, const void *r, void *args)
-{
-	struct bucket **lhs = (struct bucket **)l;
-	struct bucket **rhs = (struct bucket **)r;
-	struct cache *ca = args;
-
-	return new_bucket_prio(ca, *lhs) > new_bucket_prio(ca, *rhs);
-}
-
-static inline bool new_bucket_min_cmp(const void *l, const void *r, void *args)
-{
-	struct bucket **lhs = (struct bucket **)l;
-	struct bucket **rhs = (struct bucket **)r;
-	struct cache *ca = args;
-
-	return new_bucket_prio(ca, *lhs) < new_bucket_prio(ca, *rhs);
-}
-
-static inline void new_bucket_swap(void *l, void *r, void __always_unused *args)
-{
-	struct bucket **lhs = l, **rhs = r;
+#define bucket_prio(b)							\
+({									\
+	unsigned int min_prio = (INITIAL_PRIO - ca->set->min_prio) / 8;	\
+									\
+	(b->prio - ca->set->min_prio + min_prio) * GC_SECTORS_USED(b);	\
+})
 
-	swap(*lhs, *rhs);
-}
+#define bucket_max_cmp(l, r)	(bucket_prio(l) < bucket_prio(r))
+#define bucket_min_cmp(l, r)	(bucket_prio(l) > bucket_prio(r))
 
 static void invalidate_buckets_lru(struct cache *ca)
 {
 	struct bucket *b;
-	const struct min_heap_callbacks bucket_max_cmp_callback = {
-		.less = new_bucket_max_cmp,
-		.swp = new_bucket_swap,
-	};
-	const struct min_heap_callbacks bucket_min_cmp_callback = {
-		.less = new_bucket_min_cmp,
-		.swp = new_bucket_swap,
-	};
+	ssize_t i;
 
-	ca->heap.nr = 0;
+	ca->heap.used = 0;
 
 	for_each_bucket(b, ca) {
 		if (!bch_can_invalidate_bucket(ca, b))
 			continue;
 
-		if (!min_heap_full(&ca->heap))
-			min_heap_push(&ca->heap, &b, &bucket_max_cmp_callback, ca);
-		else if (!new_bucket_max_cmp(&b, min_heap_peek(&ca->heap), ca)) {
+		if (!heap_full(&ca->heap))
+			heap_add(&ca->heap, b, bucket_max_cmp);
+		else if (bucket_max_cmp(b, heap_peek(&ca->heap))) {
 			ca->heap.data[0] = b;
-			min_heap_sift_down(&ca->heap, 0, &bucket_max_cmp_callback, ca);
+			heap_sift(&ca->heap, 0, bucket_max_cmp);
 		}
 	}
 
-	min_heapify_all(&ca->heap, &bucket_min_cmp_callback, ca);
+	for (i = ca->heap.used / 2 - 1; i >= 0; --i)
+		heap_sift(&ca->heap, i, bucket_min_cmp);
 
 	while (!fifo_full(&ca->free_inc)) {
-		if (!ca->heap.nr) {
+		if (!heap_pop(&ca->heap, b, bucket_min_cmp)) {
 			/*
 			 * We don't want to be calling invalidate_buckets()
 			 * multiple times when it can't do anything
@@ -234,8 +206,6 @@ static void invalidate_buckets_lru(struct cache *ca)
 			wake_up_gc(ca->set);
 			return;
 		}
-		b = min_heap_peek(&ca->heap)[0];
-		min_heap_pop(&ca->heap, &bucket_min_cmp_callback, ca);
 
 		bch_invalidate_one_bucket(ca, b);
 	}
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 785b0d9008fa..1d33e40d26ea 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -458,7 +458,7 @@ struct cache {
 	/* Allocation stuff: */
 	struct bucket		*buckets;
 
-	DEFINE_MIN_HEAP(struct bucket *, cache_heap) heap;
+	DECLARE_HEAP(struct bucket *, heap);
 
 	/*
 	 * If nonzero, we know we aren't going to find any buckets to invalidate
diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index bd97d8626887..463eb13bd0b2 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -54,11 +54,9 @@ void bch_dump_bucket(struct btree_keys *b)
 int __bch_count_data(struct btree_keys *b)
 {
 	unsigned int ret = 0;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bkey *k;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 	if (b->ops->is_extents)
 		for_each_key(b, k, &iter)
 			ret += KEY_SIZE(k);
@@ -69,11 +67,9 @@ void __bch_check_keys(struct btree_keys *b, const char *fmt, ...)
 {
 	va_list args;
 	struct bkey *k, *p = NULL;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	const char *err;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 	for_each_key(b, k, &iter) {
 		if (b->ops->is_extents) {
 			err = "Keys out of order";
@@ -114,9 +110,9 @@ void __bch_check_keys(struct btree_keys *b, const char *fmt, ...)
 
 static void bch_btree_iter_next_check(struct btree_iter *iter)
 {
-	struct bkey *k = iter->heap.data->k, *next = bkey_next(k);
+	struct bkey *k = iter->data->k, *next = bkey_next(k);
 
-	if (next < iter->heap.data->end &&
+	if (next < iter->data->end &&
 	    bkey_cmp(k, iter->b->ops->is_extents ?
 		     &START_KEY(next) : next) > 0) {
 		bch_dump_bucket(iter->b);
@@ -883,14 +879,12 @@ unsigned int bch_btree_insert_key(struct btree_keys *b, struct bkey *k,
 	unsigned int status = BTREE_INSERT_STATUS_NO_INSERT;
 	struct bset *i = bset_tree_last(b)->data;
 	struct bkey *m, *prev = NULL;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bkey preceding_key_on_stack = ZERO_KEY;
 	struct bkey *preceding_key_p = &preceding_key_on_stack;
 
 	BUG_ON(b->ops->is_extents && !KEY_SIZE(k));
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 	/*
 	 * If k has preceding key, preceding_key_p will be set to address
 	 *  of k's preceding key; otherwise preceding_key_p will be set
@@ -901,9 +895,9 @@ unsigned int bch_btree_insert_key(struct btree_keys *b, struct bkey *k,
 	else
 		preceding_key(k, &preceding_key_p);
 
-	m = bch_btree_iter_init(b, &iter, preceding_key_p);
+	m = bch_btree_iter_stack_init(b, &iter, preceding_key_p);
 
-	if (b->ops->insert_fixup(b, k, &iter, replace_key))
+	if (b->ops->insert_fixup(b, k, &iter.iter, replace_key))
 		return status;
 
 	status = BTREE_INSERT_STATUS_INSERT;
@@ -1083,102 +1077,79 @@ struct bkey *__bch_bset_search(struct btree_keys *b, struct bset_tree *t,
 
 /* Btree iterator */
 
-typedef bool (new_btree_iter_cmp_fn)(const void *, const void *, void *);
-
-static inline bool new_btree_iter_cmp(const void *l, const void *r, void __always_unused *args)
-{
-	const struct btree_iter_set *_l = l;
-	const struct btree_iter_set *_r = r;
-
-	return bkey_cmp(_l->k, _r->k) <= 0;
-}
+typedef bool (btree_iter_cmp_fn)(struct btree_iter_set,
+				 struct btree_iter_set);
 
-static inline void new_btree_iter_swap(void *iter1, void *iter2, void __always_unused *args)
+static inline bool btree_iter_cmp(struct btree_iter_set l,
+				  struct btree_iter_set r)
 {
-	struct btree_iter_set *_iter1 = iter1;
-	struct btree_iter_set *_iter2 = iter2;
-
-	swap(*_iter1, *_iter2);
+	return bkey_cmp(l.k, r.k) > 0;
 }
 
 static inline bool btree_iter_end(struct btree_iter *iter)
 {
-	return !iter->heap.nr;
+	return !iter->used;
 }
 
 void bch_btree_iter_push(struct btree_iter *iter, struct bkey *k,
 			 struct bkey *end)
 {
-	const struct min_heap_callbacks callbacks = {
-		.less = new_btree_iter_cmp,
-		.swp = new_btree_iter_swap,
-	};
-
 	if (k != end)
-		BUG_ON(!min_heap_push(&iter->heap,
-				 &((struct btree_iter_set) { k, end }),
-				 &callbacks,
-				 NULL));
+		BUG_ON(!heap_add(iter,
+				 ((struct btree_iter_set) { k, end }),
+				 btree_iter_cmp));
 }
 
-static struct bkey *__bch_btree_iter_init(struct btree_keys *b,
-					  struct btree_iter *iter,
-					  struct bkey *search,
-					  struct bset_tree *start)
+static struct bkey *__bch_btree_iter_stack_init(struct btree_keys *b,
+						struct btree_iter_stack *iter,
+						struct bkey *search,
+						struct bset_tree *start)
 {
 	struct bkey *ret = NULL;
 
-	iter->heap.size = ARRAY_SIZE(iter->heap.preallocated);
-	iter->heap.nr = 0;
+	iter->iter.size = ARRAY_SIZE(iter->stack_data);
+	iter->iter.used = 0;
 
 #ifdef CONFIG_BCACHE_DEBUG
-	iter->b = b;
+	iter->iter.b = b;
 #endif
 
 	for (; start <= bset_tree_last(b); start++) {
 		ret = bch_bset_search(b, start, search);
-		bch_btree_iter_push(iter, ret, bset_bkey_last(start->data));
+		bch_btree_iter_push(&iter->iter, ret, bset_bkey_last(start->data));
 	}
 
 	return ret;
 }
 
-struct bkey *bch_btree_iter_init(struct btree_keys *b,
-				 struct btree_iter *iter,
+struct bkey *bch_btree_iter_stack_init(struct btree_keys *b,
+				 struct btree_iter_stack *iter,
 				 struct bkey *search)
 {
-	return __bch_btree_iter_init(b, iter, search, b->set);
+	return __bch_btree_iter_stack_init(b, iter, search, b->set);
 }
 
 static inline struct bkey *__bch_btree_iter_next(struct btree_iter *iter,
-						 new_btree_iter_cmp_fn *cmp)
+						 btree_iter_cmp_fn *cmp)
 {
 	struct btree_iter_set b __maybe_unused;
 	struct bkey *ret = NULL;
-	const struct min_heap_callbacks callbacks = {
-		.less = cmp,
-		.swp = new_btree_iter_swap,
-	};
 
 	if (!btree_iter_end(iter)) {
 		bch_btree_iter_next_check(iter);
 
-		ret = iter->heap.data->k;
-		iter->heap.data->k = bkey_next(iter->heap.data->k);
+		ret = iter->data->k;
+		iter->data->k = bkey_next(iter->data->k);
 
-		if (iter->heap.data->k > iter->heap.data->end) {
+		if (iter->data->k > iter->data->end) {
 			WARN_ONCE(1, "bset was corrupt!\n");
-			iter->heap.data->k = iter->heap.data->end;
+			iter->data->k = iter->data->end;
 		}
 
-		if (iter->heap.data->k == iter->heap.data->end) {
-			if (iter->heap.nr) {
-				b = min_heap_peek(&iter->heap)[0];
-				min_heap_pop(&iter->heap, &callbacks, NULL);
-			}
-		}
+		if (iter->data->k == iter->data->end)
+			heap_pop(iter, b, cmp);
 		else
-			min_heap_sift_down(&iter->heap, 0, &callbacks, NULL);
+			heap_sift(iter, 0, cmp);
 	}
 
 	return ret;
@@ -1186,7 +1157,7 @@ static inline struct bkey *__bch_btree_iter_next(struct btree_iter *iter,
 
 struct bkey *bch_btree_iter_next(struct btree_iter *iter)
 {
-	return __bch_btree_iter_next(iter, new_btree_iter_cmp);
+	return __bch_btree_iter_next(iter, btree_iter_cmp);
 
 }
 
@@ -1224,18 +1195,16 @@ static void btree_mergesort(struct btree_keys *b, struct bset *out,
 			    struct btree_iter *iter,
 			    bool fixup, bool remove_stale)
 {
+	int i;
 	struct bkey *k, *last = NULL;
 	BKEY_PADDED(k) tmp;
 	bool (*bad)(struct btree_keys *, const struct bkey *) = remove_stale
 		? bch_ptr_bad
 		: bch_ptr_invalid;
-	const struct min_heap_callbacks callbacks = {
-		.less = b->ops->sort_cmp,
-		.swp = new_btree_iter_swap,
-	};
 
 	/* Heapify the iterator, using our comparison function */
-	min_heapify_all(&iter->heap, &callbacks, NULL);
+	for (i = iter->used / 2 - 1; i >= 0; --i)
+		heap_sift(iter, i, b->ops->sort_cmp);
 
 	while (!btree_iter_end(iter)) {
 		if (b->ops->sort_fixup && fixup)
@@ -1324,11 +1293,10 @@ void bch_btree_sort_partial(struct btree_keys *b, unsigned int start,
 			    struct bset_sort_state *state)
 {
 	size_t order = b->page_order, keys = 0;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	int oldsize = bch_count_data(b);
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-	__bch_btree_iter_init(b, &iter, NULL, &b->set[start]);
+	__bch_btree_iter_stack_init(b, &iter, NULL, &b->set[start]);
 
 	if (start) {
 		unsigned int i;
@@ -1339,7 +1307,7 @@ void bch_btree_sort_partial(struct btree_keys *b, unsigned int start,
 		order = get_order(__set_bytes(b->set->data, keys));
 	}
 
-	__btree_sort(b, &iter, start, order, false, state);
+	__btree_sort(b, &iter.iter, start, order, false, state);
 
 	EBUG_ON(oldsize >= 0 && bch_count_data(b) != oldsize);
 }
@@ -1355,13 +1323,11 @@ void bch_btree_sort_into(struct btree_keys *b, struct btree_keys *new,
 			 struct bset_sort_state *state)
 {
 	uint64_t start_time = local_clock();
-	struct btree_iter iter;
-
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
+	struct btree_iter_stack iter;
 
-	bch_btree_iter_init(b, &iter, NULL);
+	bch_btree_iter_stack_init(b, &iter, NULL);
 
-	btree_mergesort(b, new->set->data, &iter, false, true);
+	btree_mergesort(b, new->set->data, &iter.iter, false, true);
 
 	bch_time_stats_update(&state->time, start_time);
 
diff --git a/drivers/md/bcache/bset.h b/drivers/md/bcache/bset.h
index f79441acd4c1..011f6062c4c0 100644
--- a/drivers/md/bcache/bset.h
+++ b/drivers/md/bcache/bset.h
@@ -187,9 +187,8 @@ struct bset_tree {
 };
 
 struct btree_keys_ops {
-	bool		(*sort_cmp)(const void *l,
-				    const void *r,
-					void *args);
+	bool		(*sort_cmp)(struct btree_iter_set l,
+				    struct btree_iter_set r);
 	struct bkey	*(*sort_fixup)(struct btree_iter *iter,
 				       struct bkey *tmp);
 	bool		(*insert_fixup)(struct btree_keys *b,
@@ -313,17 +312,23 @@ enum {
 	BTREE_INSERT_STATUS_FRONT_MERGE,
 };
 
-struct btree_iter_set {
-	struct bkey *k, *end;
-};
-
 /* Btree key iteration */
 
 struct btree_iter {
+	size_t size, used;
 #ifdef CONFIG_BCACHE_DEBUG
 	struct btree_keys *b;
 #endif
-	MIN_HEAP_PREALLOCATED(struct btree_iter_set, btree_iter_heap, MAX_BSETS) heap;
+	struct btree_iter_set {
+		struct bkey *k, *end;
+	} data[];
+};
+
+/* Fixed-size btree_iter that can be allocated on the stack */
+
+struct btree_iter_stack {
+	struct btree_iter iter;
+	struct btree_iter_set stack_data[MAX_BSETS];
 };
 
 typedef bool (*ptr_filter_fn)(struct btree_keys *b, const struct bkey *k);
@@ -335,9 +340,9 @@ struct bkey *bch_btree_iter_next_filter(struct btree_iter *iter,
 
 void bch_btree_iter_push(struct btree_iter *iter, struct bkey *k,
 			 struct bkey *end);
-struct bkey *bch_btree_iter_init(struct btree_keys *b,
-				 struct btree_iter *iter,
-				 struct bkey *search);
+struct bkey *bch_btree_iter_stack_init(struct btree_keys *b,
+				       struct btree_iter_stack *iter,
+				       struct bkey *search);
 
 struct bkey *__bch_bset_search(struct btree_keys *b, struct bset_tree *t,
 			       const struct bkey *search);
@@ -352,13 +357,14 @@ static inline struct bkey *bch_bset_search(struct btree_keys *b,
 	return search ? __bch_bset_search(b, t, search) : t->data->start;
 }
 
-#define for_each_key_filter(b, k, iter, filter)				\
-	for (bch_btree_iter_init((b), (iter), NULL);			\
-	     ((k) = bch_btree_iter_next_filter((iter), (b), filter));)
+#define for_each_key_filter(b, k, stack_iter, filter)                      \
+	for (bch_btree_iter_stack_init((b), (stack_iter), NULL);           \
+	     ((k) = bch_btree_iter_next_filter(&((stack_iter)->iter), (b), \
+					       filter));)
 
-#define for_each_key(b, k, iter)					\
-	for (bch_btree_iter_init((b), (iter), NULL);			\
-	     ((k) = bch_btree_iter_next(iter));)
+#define for_each_key(b, k, stack_iter)                           \
+	for (bch_btree_iter_stack_init((b), (stack_iter), NULL); \
+	     ((k) = bch_btree_iter_next(&((stack_iter)->iter)));)
 
 /* Sorting */
 
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index ed40d8600656..4e6ccf2c8a0b 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -149,19 +149,19 @@ void bch_btree_node_read_done(struct btree *b)
 {
 	const char *err = "bad btree header";
 	struct bset *i = btree_bset_first(b);
-	struct btree_iter iter;
+	struct btree_iter *iter;
 
 	/*
 	 * c->fill_iter can allocate an iterator with more memory space
 	 * than static MAX_BSETS.
 	 * See the comment arount cache_set->fill_iter.
 	 */
-	iter.heap.data = mempool_alloc(&b->c->fill_iter, GFP_NOIO);
-	iter.heap.size = b->c->cache->sb.bucket_size / b->c->cache->sb.block_size;
-	iter.heap.nr = 0;
+	iter = mempool_alloc(&b->c->fill_iter, GFP_NOIO);
+	iter->size = b->c->cache->sb.bucket_size / b->c->cache->sb.block_size;
+	iter->used = 0;
 
 #ifdef CONFIG_BCACHE_DEBUG
-	iter.b = &b->keys;
+	iter->b = &b->keys;
 #endif
 
 	if (!i->seq)
@@ -199,7 +199,7 @@ void bch_btree_node_read_done(struct btree *b)
 		if (i != b->keys.set[0].data && !i->keys)
 			goto err;
 
-		bch_btree_iter_push(&iter, i->start, bset_bkey_last(i));
+		bch_btree_iter_push(iter, i->start, bset_bkey_last(i));
 
 		b->written += set_blocks(i, block_bytes(b->c->cache));
 	}
@@ -211,7 +211,7 @@ void bch_btree_node_read_done(struct btree *b)
 		if (i->seq == b->keys.set[0].data->seq)
 			goto err;
 
-	bch_btree_sort_and_fix_extents(&b->keys, &iter, &b->c->sort);
+	bch_btree_sort_and_fix_extents(&b->keys, iter, &b->c->sort);
 
 	i = b->keys.set[0].data;
 	err = "short btree key";
@@ -223,7 +223,7 @@ void bch_btree_node_read_done(struct btree *b)
 		bch_bset_init_next(&b->keys, write_block(b),
 				   bset_magic(&b->c->cache->sb));
 out:
-	mempool_free(iter.heap.data, &b->c->fill_iter);
+	mempool_free(iter, &b->c->fill_iter);
 	return;
 err:
 	set_btree_node_io_error(b);
@@ -1309,11 +1309,9 @@ static bool btree_gc_mark_node(struct btree *b, struct gc_stat *gc)
 	uint8_t stale = 0;
 	unsigned int keys = 0, good_keys = 0;
 	struct bkey *k;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bset_tree *t;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 	gc->nodes++;
 
 	for_each_key_filter(&b->keys, k, &iter, bch_ptr_invalid) {
@@ -1572,11 +1570,9 @@ static int btree_gc_rewrite_node(struct btree *b, struct btree_op *op,
 static unsigned int btree_gc_count_keys(struct btree *b)
 {
 	struct bkey *k;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	unsigned int ret = 0;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 	for_each_key_filter(&b->keys, k, &iter, bch_ptr_bad)
 		ret += bkey_u64s(k);
 
@@ -1615,18 +1611,18 @@ static int btree_gc_recurse(struct btree *b, struct btree_op *op,
 	int ret = 0;
 	bool should_rewrite;
 	struct bkey *k;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct gc_merge_info r[GC_MERGE_NODES];
 	struct gc_merge_info *i, *last = r + ARRAY_SIZE(r) - 1;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-	bch_btree_iter_init(&b->keys, &iter, &b->c->gc_done);
+	bch_btree_iter_stack_init(&b->keys, &iter, &b->c->gc_done);
 
 	for (i = r; i < r + ARRAY_SIZE(r); i++)
 		i->b = ERR_PTR(-EINTR);
 
 	while (1) {
-		k = bch_btree_iter_next_filter(&iter, &b->keys, bch_ptr_bad);
+		k = bch_btree_iter_next_filter(&iter.iter, &b->keys,
+					       bch_ptr_bad);
 		if (k) {
 			r->b = bch_btree_node_get(b->c, op, k, b->level - 1,
 						  true, b);
@@ -1921,9 +1917,7 @@ static int bch_btree_check_recurse(struct btree *b, struct btree_op *op)
 {
 	int ret = 0;
 	struct bkey *k, *p = NULL;
-	struct btree_iter iter;
-
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
+	struct btree_iter_stack iter;
 
 	for_each_key_filter(&b->keys, k, &iter, bch_ptr_invalid)
 		bch_initial_mark_key(b->c, b->level, k);
@@ -1931,10 +1925,10 @@ static int bch_btree_check_recurse(struct btree *b, struct btree_op *op)
 	bch_initial_mark_key(b->c, b->level + 1, &b->key);
 
 	if (b->level) {
-		bch_btree_iter_init(&b->keys, &iter, NULL);
+		bch_btree_iter_stack_init(&b->keys, &iter, NULL);
 
 		do {
-			k = bch_btree_iter_next_filter(&iter, &b->keys,
+			k = bch_btree_iter_next_filter(&iter.iter, &b->keys,
 						       bch_ptr_bad);
 			if (k) {
 				btree_node_prefetch(b, k);
@@ -1962,7 +1956,7 @@ static int bch_btree_check_thread(void *arg)
 	struct btree_check_info *info = arg;
 	struct btree_check_state *check_state = info->state;
 	struct cache_set *c = check_state->c;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bkey *k, *p;
 	int cur_idx, prev_idx, skip_nr;
 
@@ -1970,11 +1964,9 @@ static int bch_btree_check_thread(void *arg)
 	cur_idx = prev_idx = 0;
 	ret = 0;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 	/* root node keys are checked before thread created */
-	bch_btree_iter_init(&c->root->keys, &iter, NULL);
-	k = bch_btree_iter_next_filter(&iter, &c->root->keys, bch_ptr_bad);
+	bch_btree_iter_stack_init(&c->root->keys, &iter, NULL);
+	k = bch_btree_iter_next_filter(&iter.iter, &c->root->keys, bch_ptr_bad);
 	BUG_ON(!k);
 
 	p = k;
@@ -1992,7 +1984,7 @@ static int bch_btree_check_thread(void *arg)
 		skip_nr = cur_idx - prev_idx;
 
 		while (skip_nr) {
-			k = bch_btree_iter_next_filter(&iter,
+			k = bch_btree_iter_next_filter(&iter.iter,
 						       &c->root->keys,
 						       bch_ptr_bad);
 			if (k)
@@ -2065,11 +2057,9 @@ int bch_btree_check(struct cache_set *c)
 	int ret = 0;
 	int i;
 	struct bkey *k = NULL;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct btree_check_state check_state;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 	/* check and mark root node keys */
 	for_each_key_filter(&c->root->keys, k, &iter, bch_ptr_invalid)
 		bch_initial_mark_key(c, c->root->level, k);
@@ -2563,12 +2553,11 @@ static int bch_btree_map_nodes_recurse(struct btree *b, struct btree_op *op,
 
 	if (b->level) {
 		struct bkey *k;
-		struct btree_iter iter;
+		struct btree_iter_stack iter;
 
-		min_heap_init(&iter.heap, NULL, MAX_BSETS);
-		bch_btree_iter_init(&b->keys, &iter, from);
+		bch_btree_iter_stack_init(&b->keys, &iter, from);
 
-		while ((k = bch_btree_iter_next_filter(&iter, &b->keys,
+		while ((k = bch_btree_iter_next_filter(&iter.iter, &b->keys,
 						       bch_ptr_bad))) {
 			ret = bcache_btree(map_nodes_recurse, k, b,
 				    op, from, fn, flags);
@@ -2597,12 +2586,12 @@ int bch_btree_map_keys_recurse(struct btree *b, struct btree_op *op,
 {
 	int ret = MAP_CONTINUE;
 	struct bkey *k;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-	bch_btree_iter_init(&b->keys, &iter, from);
+	bch_btree_iter_stack_init(&b->keys, &iter, from);
 
-	while ((k = bch_btree_iter_next_filter(&iter, &b->keys, bch_ptr_bad))) {
+	while ((k = bch_btree_iter_next_filter(&iter.iter, &b->keys,
+					       bch_ptr_bad))) {
 		ret = !b->level
 			? fn(op, b, k)
 			: bcache_btree(map_keys_recurse, k,
diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
index a7221e5dbe81..d626ffcbecb9 100644
--- a/drivers/md/bcache/extents.c
+++ b/drivers/md/bcache/extents.c
@@ -33,16 +33,15 @@ static void sort_key_next(struct btree_iter *iter,
 	i->k = bkey_next(i->k);
 
 	if (i->k == i->end)
-		*i = iter->heap.data[--iter->heap.nr];
+		*i = iter->data[--iter->used];
 }
 
-static bool new_bch_key_sort_cmp(const void *l, const void *r, void *args)
+static bool bch_key_sort_cmp(struct btree_iter_set l,
+			     struct btree_iter_set r)
 {
-	struct btree_iter_set *_l = (struct btree_iter_set *)l;
-	struct btree_iter_set *_r = (struct btree_iter_set *)r;
-	int64_t c = bkey_cmp(_l->k, _r->k);
+	int64_t c = bkey_cmp(l.k, r.k);
 
-	return !(c ? c > 0 : _l->k < _r->k);
+	return c ? c > 0 : l.k < r.k;
 }
 
 static bool __ptr_invalid(struct cache_set *c, const struct bkey *k)
@@ -239,7 +238,7 @@ static bool bch_btree_ptr_insert_fixup(struct btree_keys *bk,
 }
 
 const struct btree_keys_ops bch_btree_keys_ops = {
-	.sort_cmp	= new_bch_key_sort_cmp,
+	.sort_cmp	= bch_key_sort_cmp,
 	.insert_fixup	= bch_btree_ptr_insert_fixup,
 	.key_invalid	= bch_btree_ptr_invalid,
 	.key_bad	= bch_btree_ptr_bad,
@@ -256,36 +255,22 @@ const struct btree_keys_ops bch_btree_keys_ops = {
  * Necessary for btree_sort_fixup() - if there are multiple keys that compare
  * equal in different sets, we have to process them newest to oldest.
  */
-
-static bool new_bch_extent_sort_cmp(const void *l, const void *r, void __always_unused *args)
-{
-	struct btree_iter_set *_l = (struct btree_iter_set *)l;
-	struct btree_iter_set *_r = (struct btree_iter_set *)r;
-	int64_t c = bkey_cmp(&START_KEY(_l->k), &START_KEY(_r->k));
-
-	return !(c ? c > 0 : _l->k < _r->k);
-}
-
-static inline void new_btree_iter_swap(void *iter1, void *iter2, void __always_unused *args)
+static bool bch_extent_sort_cmp(struct btree_iter_set l,
+				struct btree_iter_set r)
 {
-	struct btree_iter_set *_iter1 = iter1;
-	struct btree_iter_set *_iter2 = iter2;
+	int64_t c = bkey_cmp(&START_KEY(l.k), &START_KEY(r.k));
 
-	swap(*_iter1, *_iter2);
+	return c ? c > 0 : l.k < r.k;
 }
 
 static struct bkey *bch_extent_sort_fixup(struct btree_iter *iter,
 					  struct bkey *tmp)
 {
-	const struct min_heap_callbacks callbacks = {
-		.less = new_bch_extent_sort_cmp,
-		.swp = new_btree_iter_swap,
-	};
-	while (iter->heap.nr > 1) {
-		struct btree_iter_set *top = iter->heap.data, *i = top + 1;
-
-		if (iter->heap.nr > 2 &&
-		    !new_bch_extent_sort_cmp(&i[0], &i[1], NULL))
+	while (iter->used > 1) {
+		struct btree_iter_set *top = iter->data, *i = top + 1;
+
+		if (iter->used > 2 &&
+		    bch_extent_sort_cmp(i[0], i[1]))
 			i++;
 
 		if (bkey_cmp(top->k, &START_KEY(i->k)) <= 0)
@@ -293,7 +278,7 @@ static struct bkey *bch_extent_sort_fixup(struct btree_iter *iter,
 
 		if (!KEY_SIZE(i->k)) {
 			sort_key_next(iter, i);
-			min_heap_sift_down(&iter->heap, i - top, &callbacks, NULL);
+			heap_sift(iter, i - top, bch_extent_sort_cmp);
 			continue;
 		}
 
@@ -303,7 +288,7 @@ static struct bkey *bch_extent_sort_fixup(struct btree_iter *iter,
 			else
 				bch_cut_front(top->k, i->k);
 
-			min_heap_sift_down(&iter->heap, i - top, &callbacks, NULL);
+			heap_sift(iter, i - top, bch_extent_sort_cmp);
 		} else {
 			/* can't happen because of comparison func */
 			BUG_ON(!bkey_cmp(&START_KEY(top->k), &START_KEY(i->k)));
@@ -313,7 +298,7 @@ static struct bkey *bch_extent_sort_fixup(struct btree_iter *iter,
 
 				bch_cut_back(&START_KEY(i->k), tmp);
 				bch_cut_front(i->k, top->k);
-				min_heap_sift_down(&iter->heap, 0, &callbacks, NULL);
+				heap_sift(iter, 0, bch_extent_sort_cmp);
 
 				return tmp;
 			} else {
@@ -633,7 +618,7 @@ static bool bch_extent_merge(struct btree_keys *bk,
 }
 
 const struct btree_keys_ops bch_extent_keys_ops = {
-	.sort_cmp	= new_bch_extent_sort_cmp,
+	.sort_cmp	= bch_extent_sort_cmp,
 	.sort_fixup	= bch_extent_sort_fixup,
 	.insert_fixup	= bch_extent_insert_fixup,
 	.key_invalid	= bch_extent_invalid,
diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
index 7f482729c56d..ebd500bdf0b2 100644
--- a/drivers/md/bcache/movinggc.c
+++ b/drivers/md/bcache/movinggc.c
@@ -182,27 +182,16 @@ err:		if (!IS_ERR_OR_NULL(w->private))
 	closure_sync(&cl);
 }
 
-static bool new_bucket_cmp(const void *l, const void *r, void __always_unused *args)
+static bool bucket_cmp(struct bucket *l, struct bucket *r)
 {
-	struct bucket **_l = (struct bucket **)l;
-	struct bucket **_r = (struct bucket **)r;
-
-	return GC_SECTORS_USED(*_l) >= GC_SECTORS_USED(*_r);
-}
-
-static void new_bucket_swap(void *l, void *r, void __always_unused *args)
-{
-	struct bucket **_l = l;
-	struct bucket **_r = r;
-
-	swap(*_l, *_r);
+	return GC_SECTORS_USED(l) < GC_SECTORS_USED(r);
 }
 
 static unsigned int bucket_heap_top(struct cache *ca)
 {
 	struct bucket *b;
 
-	return (b = min_heap_peek(&ca->heap)[0]) ? GC_SECTORS_USED(b) : 0;
+	return (b = heap_peek(&ca->heap)) ? GC_SECTORS_USED(b) : 0;
 }
 
 void bch_moving_gc(struct cache_set *c)
@@ -210,10 +199,6 @@ void bch_moving_gc(struct cache_set *c)
 	struct cache *ca = c->cache;
 	struct bucket *b;
 	unsigned long sectors_to_move, reserve_sectors;
-	const struct min_heap_callbacks callbacks = {
-		.less = new_bucket_cmp,
-		.swp = new_bucket_swap,
-	};
 
 	if (!c->copy_gc_enabled)
 		return;
@@ -224,7 +209,7 @@ void bch_moving_gc(struct cache_set *c)
 	reserve_sectors = ca->sb.bucket_size *
 			     fifo_used(&ca->free[RESERVE_MOVINGGC]);
 
-	ca->heap.nr = 0;
+	ca->heap.used = 0;
 
 	for_each_bucket(b, ca) {
 		if (GC_MARK(b) == GC_MARK_METADATA ||
@@ -233,31 +218,25 @@ void bch_moving_gc(struct cache_set *c)
 		    atomic_read(&b->pin))
 			continue;
 
-		if (!min_heap_full(&ca->heap)) {
+		if (!heap_full(&ca->heap)) {
 			sectors_to_move += GC_SECTORS_USED(b);
-			min_heap_push(&ca->heap, &b, &callbacks, NULL);
-		} else if (!new_bucket_cmp(&b, min_heap_peek(&ca->heap), ca)) {
+			heap_add(&ca->heap, b, bucket_cmp);
+		} else if (bucket_cmp(b, heap_peek(&ca->heap))) {
 			sectors_to_move -= bucket_heap_top(ca);
 			sectors_to_move += GC_SECTORS_USED(b);
 
 			ca->heap.data[0] = b;
-			min_heap_sift_down(&ca->heap, 0, &callbacks, NULL);
+			heap_sift(&ca->heap, 0, bucket_cmp);
 		}
 	}
 
 	while (sectors_to_move > reserve_sectors) {
-		if (ca->heap.nr) {
-			b = min_heap_peek(&ca->heap)[0];
-			min_heap_pop(&ca->heap, &callbacks, NULL);
-		}
+		heap_pop(&ca->heap, b, bucket_cmp);
 		sectors_to_move -= GC_SECTORS_USED(b);
 	}
 
-	while (ca->heap.nr) {
-		b = min_heap_peek(&ca->heap)[0];
-		min_heap_pop(&ca->heap, &callbacks, NULL);
+	while (heap_pop(&ca->heap, b, bucket_cmp))
 		SET_GC_MOVE(b, 1);
-	}
 
 	mutex_unlock(&c->bucket_lock);
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index f5171167819b..1084b3f0dfe7 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1912,7 +1912,8 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 	INIT_LIST_HEAD(&c->btree_cache_freed);
 	INIT_LIST_HEAD(&c->data_buckets);
 
-	iter_size = ((meta_bucket_pages(sb) * PAGE_SECTORS) / sb->block_size) *
+	iter_size = sizeof(struct btree_iter) +
+		    ((meta_bucket_pages(sb) * PAGE_SECTORS) / sb->block_size) *
 			    sizeof(struct btree_iter_set);
 
 	c->devices = kcalloc(c->nr_uuids, sizeof(void *), GFP_KERNEL);
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index e8f696cb58c0..826b14cae4e5 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -660,9 +660,7 @@ static unsigned int bch_root_usage(struct cache_set *c)
 	unsigned int bytes = 0;
 	struct bkey *k;
 	struct btree *b;
-	struct btree_iter iter;
-
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
+	struct btree_iter_stack iter;
 
 	goto lock_root;
 
diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
index 539454d8e2d0..f61ab1bada6c 100644
--- a/drivers/md/bcache/util.h
+++ b/drivers/md/bcache/util.h
@@ -9,7 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/sched/clock.h>
 #include <linux/llist.h>
-#include <linux/min_heap.h>
 #include <linux/ratelimit.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
@@ -31,10 +30,16 @@ struct closure;
 
 #endif
 
+#define DECLARE_HEAP(type, name)					\
+	struct {							\
+		size_t size, used;					\
+		type *data;						\
+	} name
+
 #define init_heap(heap, _size, gfp)					\
 ({									\
 	size_t _bytes;							\
-	(heap)->nr = 0;						\
+	(heap)->used = 0;						\
 	(heap)->size = (_size);						\
 	_bytes = (heap)->size * sizeof(*(heap)->data);			\
 	(heap)->data = kvmalloc(_bytes, (gfp) & GFP_KERNEL);		\
@@ -47,6 +52,64 @@ do {									\
 	(heap)->data = NULL;						\
 } while (0)
 
+#define heap_swap(h, i, j)	swap((h)->data[i], (h)->data[j])
+
+#define heap_sift(h, i, cmp)						\
+do {									\
+	size_t _r, _j = i;						\
+									\
+	for (; _j * 2 + 1 < (h)->used; _j = _r) {			\
+		_r = _j * 2 + 1;					\
+		if (_r + 1 < (h)->used &&				\
+		    cmp((h)->data[_r], (h)->data[_r + 1]))		\
+			_r++;						\
+									\
+		if (cmp((h)->data[_r], (h)->data[_j]))			\
+			break;						\
+		heap_swap(h, _r, _j);					\
+	}								\
+} while (0)
+
+#define heap_sift_down(h, i, cmp)					\
+do {									\
+	while (i) {							\
+		size_t p = (i - 1) / 2;					\
+		if (cmp((h)->data[i], (h)->data[p]))			\
+			break;						\
+		heap_swap(h, i, p);					\
+		i = p;							\
+	}								\
+} while (0)
+
+#define heap_add(h, d, cmp)						\
+({									\
+	bool _r = !heap_full(h);					\
+	if (_r) {							\
+		size_t _i = (h)->used++;				\
+		(h)->data[_i] = d;					\
+									\
+		heap_sift_down(h, _i, cmp);				\
+		heap_sift(h, _i, cmp);					\
+	}								\
+	_r;								\
+})
+
+#define heap_pop(h, d, cmp)						\
+({									\
+	bool _r = (h)->used;						\
+	if (_r) {							\
+		(d) = (h)->data[0];					\
+		(h)->used--;						\
+		heap_swap(h, 0, (h)->used);				\
+		heap_sift(h, 0, cmp);					\
+	}								\
+	_r;								\
+})
+
+#define heap_peek(h)	((h)->used ? (h)->data[0] : NULL)
+
+#define heap_full(h)	((h)->used == (h)->size)
+
 #define DECLARE_FIFO(type, name)					\
 	struct {							\
 		size_t front, back, size, mask;				\
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index c1d28e365910..792e070ccf38 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -908,16 +908,15 @@ static int bch_dirty_init_thread(void *arg)
 	struct dirty_init_thrd_info *info = arg;
 	struct bch_dirty_init_state *state = info->state;
 	struct cache_set *c = state->c;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bkey *k, *p;
 	int cur_idx, prev_idx, skip_nr;
 
 	k = p = NULL;
 	prev_idx = 0;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-	bch_btree_iter_init(&c->root->keys, &iter, NULL);
-	k = bch_btree_iter_next_filter(&iter, &c->root->keys, bch_ptr_bad);
+	bch_btree_iter_stack_init(&c->root->keys, &iter, NULL);
+	k = bch_btree_iter_next_filter(&iter.iter, &c->root->keys, bch_ptr_bad);
 	BUG_ON(!k);
 
 	p = k;
@@ -931,7 +930,7 @@ static int bch_dirty_init_thread(void *arg)
 		skip_nr = cur_idx - prev_idx;
 
 		while (skip_nr) {
-			k = bch_btree_iter_next_filter(&iter,
+			k = bch_btree_iter_next_filter(&iter.iter,
 						       &c->root->keys,
 						       bch_ptr_bad);
 			if (k)
@@ -980,13 +979,11 @@ void bch_sectors_dirty_init(struct bcache_device *d)
 	int i;
 	struct btree *b = NULL;
 	struct bkey *k = NULL;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct sectors_dirty_init op;
 	struct cache_set *c = d->c;
 	struct bch_dirty_init_state state;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 retry_lock:
 	b = c->root;
 	rw_lock(0, b, b->level);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7809b951e09a..4b3291723670 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9702,8 +9702,8 @@ void md_check_recovery(struct mddev *mddev)
 			 * remove disk.
 			 */
 			rdev_for_each_safe(rdev, tmp, mddev) {
-				if (test_and_clear_bit(ClusterRemove, &rdev->flags) &&
-						rdev->raid_disk < 0)
+				if (rdev->raid_disk < 0 &&
+				    test_and_clear_bit(ClusterRemove, &rdev->flags))
 					md_kick_rdev_from_array(rdev);
 			}
 		}
@@ -10000,8 +10000,11 @@ static void check_sb_changes(struct mddev *mddev, struct md_rdev *rdev)
 
 	/* Check for change of roles in the active devices */
 	rdev_for_each_safe(rdev2, tmp, mddev) {
-		if (test_bit(Faulty, &rdev2->flags))
+		if (test_bit(Faulty, &rdev2->flags)) {
+			if (test_bit(ClusterRemove, &rdev2->flags))
+				set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 			continue;
+		}
 
 		/* Check if the roles changed */
 		role = le16_to_cpu(sb->dev_roles[rdev2->desc_nr]);
diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 22442fce7607..3853245fcf6e 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -619,6 +619,7 @@ static void ti_csi2rx_dma_callback(void *param)
 
 		if (ti_csi2rx_start_dma(csi, buf)) {
 			dev_err(csi->dev, "Failed to queue the next buffer for DMA\n");
+			list_del(&buf->list);
 			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
 		} else {
 			list_move_tail(&buf->list, &dma->submitted);
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index eeab6a5eb7ba..675642af8601 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -897,12 +897,12 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 
 			p_h264_sps->flags &=
 				~V4L2_H264_SPS_FLAG_QPPRIME_Y_ZERO_TRANSFORM_BYPASS;
-
-			if (p_h264_sps->chroma_format_idc < 3)
-				p_h264_sps->flags &=
-					~V4L2_H264_SPS_FLAG_SEPARATE_COLOUR_PLANE;
 		}
 
+		if (p_h264_sps->chroma_format_idc < 3)
+			p_h264_sps->flags &=
+				~V4L2_H264_SPS_FLAG_SEPARATE_COLOUR_PLANE;
+
 		if (p_h264_sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY)
 			p_h264_sps->flags &=
 				~V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD;
diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-vsc.c
index 20a11b299bcd..ab80bd3271b2 100644
--- a/drivers/misc/mei/platform-vsc.c
+++ b/drivers/misc/mei/platform-vsc.c
@@ -379,6 +379,8 @@ static int mei_vsc_probe(struct platform_device *pdev)
 err_cancel:
 	mei_cancel_work(mei_dev);
 
+	vsc_tp_register_event_cb(tp, NULL, NULL);
+
 	mei_disable_interrupts(mei_dev);
 
 	return ret;
@@ -387,11 +389,14 @@ static int mei_vsc_probe(struct platform_device *pdev)
 static void mei_vsc_remove(struct platform_device *pdev)
 {
 	struct mei_device *mei_dev = platform_get_drvdata(pdev);
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
 
 	pm_runtime_disable(mei_dev->dev);
 
 	mei_stop(mei_dev);
 
+	vsc_tp_register_event_cb(hw->tp, NULL, NULL);
+
 	mei_disable_interrupts(mei_dev);
 
 	mei_deregister(mei_dev);
diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 5e44b518f36c..27c921c752e9 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -79,9 +79,8 @@ struct vsc_tp {
 
 	vsc_tp_event_cb_t event_notify;
 	void *event_notify_context;
-
-	/* used to protect command download */
-	struct mutex mutex;
+	struct mutex event_notify_mutex;	/* protects event_notify + context */
+	struct mutex mutex;			/* protects command download */
 };
 
 /* GPIO resources */
@@ -113,6 +112,8 @@ static irqreturn_t vsc_tp_thread_isr(int irq, void *data)
 {
 	struct vsc_tp *tp = data;
 
+	guard(mutex)(&tp->event_notify_mutex);
+
 	if (tp->event_notify)
 		tp->event_notify(tp->event_notify_context);
 
@@ -401,6 +402,8 @@ EXPORT_SYMBOL_NS_GPL(vsc_tp_need_read, VSC_TP);
 int vsc_tp_register_event_cb(struct vsc_tp *tp, vsc_tp_event_cb_t event_cb,
 			    void *context)
 {
+	guard(mutex)(&tp->event_notify_mutex);
+
 	tp->event_notify = event_cb;
 	tp->event_notify_context = context;
 
@@ -532,6 +535,7 @@ static int vsc_tp_probe(struct spi_device *spi)
 		return ret;
 
 	mutex_init(&tp->mutex);
+	mutex_init(&tp->event_notify_mutex);
 
 	/* only one child acpi device */
 	ret = acpi_dev_for_each_child(ACPI_COMPANION(dev),
@@ -554,10 +558,11 @@ static int vsc_tp_probe(struct spi_device *spi)
 	return 0;
 
 err_destroy_lock:
-	mutex_destroy(&tp->mutex);
-
 	free_irq(spi->irq, tp);
 
+	mutex_destroy(&tp->event_notify_mutex);
+	mutex_destroy(&tp->mutex);
+
 	return ret;
 }
 
@@ -567,9 +572,10 @@ static void vsc_tp_remove(struct spi_device *spi)
 
 	platform_device_unregister(tp->pdev);
 
-	mutex_destroy(&tp->mutex);
-
 	free_irq(spi->irq, tp);
+
+	mutex_destroy(&tp->event_notify_mutex);
+	mutex_destroy(&tp->mutex);
 }
 
 static void vsc_tp_shutdown(struct spi_device *spi)
diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
index 8c22064ead38..f2bd1984609c 100644
--- a/drivers/mtd/ftl.c
+++ b/drivers/mtd/ftl.c
@@ -344,7 +344,7 @@ static int erase_xfer(partition_t *part,
             return -ENOMEM;
 
     erase->addr = xfer->Offset;
-    erase->len = 1 << part->header.EraseUnitSize;
+    erase->len = 1ULL << part->header.EraseUnitSize;
 
     ret = mtd_erase(part->mbd.mtd, erase);
     if (!ret) {
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index f9ccfd02e804..6f8eb7fa4c59 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -373,7 +373,7 @@ static int atmel_nand_dma_transfer(struct atmel_nand_controller *nc,
 	dma_cookie_t cookie;
 
 	buf_dma = dma_map_single(nc->dev, buf, len, dir);
-	if (dma_mapping_error(nc->dev, dev_dma)) {
+	if (dma_mapping_error(nc->dev, buf_dma)) {
 		dev_err(nc->dev,
 			"Failed to prepare a buffer for DMA access\n");
 		goto err;
diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index 3c7dee1be21d..0b402823b619 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -143,6 +143,7 @@ struct atmel_pmecc_caps {
 	int nstrengths;
 	int el_offset;
 	bool correct_erased_chunks;
+	bool clk_ctrl;
 };
 
 struct atmel_pmecc {
@@ -843,6 +844,10 @@ static struct atmel_pmecc *atmel_pmecc_create(struct platform_device *pdev,
 	if (IS_ERR(pmecc->regs.errloc))
 		return ERR_CAST(pmecc->regs.errloc);
 
+	/* pmecc data setup time */
+	if (caps->clk_ctrl)
+		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
+
 	/* Disable all interrupts before registering the PMECC handler. */
 	writel(0xffffffff, pmecc->regs.base + ATMEL_PMECC_IDR);
 	atmel_pmecc_reset(pmecc);
@@ -896,6 +901,7 @@ static struct atmel_pmecc_caps at91sam9g45_caps = {
 	.strengths = atmel_pmecc_strengths,
 	.nstrengths = 5,
 	.el_offset = 0x8c,
+	.clk_ctrl = true,
 };
 
 static struct atmel_pmecc_caps sama5d4_caps = {
diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 51c9cf9013dc..1b65b3aa6aa2 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -656,9 +656,16 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
 
 	dma_data = dma_map_single(nfc->dev, (void *)nfc->page_buf,
 				  mtd->writesize, DMA_TO_DEVICE);
+	if (dma_mapping_error(nfc->dev, dma_data))
+		return -ENOMEM;
+
 	dma_oob = dma_map_single(nfc->dev, nfc->oob_buf,
 				 ecc->steps * oob_step,
 				 DMA_TO_DEVICE);
+	if (dma_mapping_error(nfc->dev, dma_oob)) {
+		dma_unmap_single(nfc->dev, dma_data, mtd->writesize, DMA_TO_DEVICE);
+		return -ENOMEM;
+	}
 
 	reinit_completion(&nfc->done);
 	writel(INT_DMA, nfc->regs + nfc->cfg->int_en_off);
@@ -772,9 +779,17 @@ static int rk_nfc_read_page_hwecc(struct nand_chip *chip, u8 *buf, int oob_on,
 	dma_data = dma_map_single(nfc->dev, nfc->page_buf,
 				  mtd->writesize,
 				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(nfc->dev, dma_data))
+		return -ENOMEM;
+
 	dma_oob = dma_map_single(nfc->dev, nfc->oob_buf,
 				 ecc->steps * oob_step,
 				 DMA_FROM_DEVICE);
+	if (dma_mapping_error(nfc->dev, dma_oob)) {
+		dma_unmap_single(nfc->dev, dma_data, mtd->writesize,
+				 DMA_FROM_DEVICE);
+		return -ENOMEM;
+	}
 
 	/*
 	 * The first blocks (4, 8 or 16 depending on the device)
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 5a88a6096ca8..fcd081b75784 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -17,6 +17,7 @@
 
 #define SPINOR_OP_CLSR		0x30	/* Clear status register 1 */
 #define SPINOR_OP_CLPEF		0x82	/* Clear program/erase failure flags */
+#define SPINOR_OP_CYPRESS_EX4B	0xB8	/* Exit 4-byte address mode */
 #define SPINOR_OP_CYPRESS_DIE_ERASE		0x61	/* Chip (die) erase */
 #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
 #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
@@ -58,6 +59,13 @@
 		   SPI_MEM_OP_DUMMY(ndummy, 0),				\
 		   SPI_MEM_OP_DATA_IN(1, buf, 0))
 
+#define CYPRESS_NOR_EN4B_EX4B_OP(enable)				\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(enable ? SPINOR_OP_EN4B :		\
+					   SPINOR_OP_CYPRESS_EX4B, 0),	\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
 #define SPANSION_OP(opcode)						\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),				\
 		   SPI_MEM_OP_NO_ADDR,					\
@@ -356,6 +364,20 @@ static int cypress_nor_quad_enable_volatile(struct spi_nor *nor)
 	return 0;
 }
 
+static int cypress_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+{
+	int ret;
+	struct spi_mem_op op = CYPRESS_NOR_EN4B_EX4B_OP(enable);
+
+	spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
+
+	return ret;
+}
+
 /**
  * cypress_nor_determine_addr_mode_by_sr1() - Determine current address mode
  *                                            (3 or 4-byte) by querying status
@@ -526,6 +548,9 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 	struct spi_mem_op op;
 	int ret;
 
+	/* Assign 4-byte address mode method that is not determined in BFPT */
+	nor->params->set_4byte_addr_mode = cypress_nor_set_4byte_addr_mode;
+
 	ret = cypress_nor_set_addr_mode_nbytes(nor);
 	if (ret)
 		return ret;
@@ -591,6 +616,9 @@ s25hx_t_post_bfpt_fixup(struct spi_nor *nor,
 {
 	int ret;
 
+	/* Assign 4-byte address mode method that is not determined in BFPT */
+	nor->params->set_4byte_addr_mode = cypress_nor_set_4byte_addr_mode;
+
 	ret = cypress_nor_set_addr_mode_nbytes(nor);
 	if (ret)
 		return ret;
@@ -718,6 +746,9 @@ static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
 				   const struct sfdp_parameter_header *bfpt_header,
 				   const struct sfdp_bfpt *bfpt)
 {
+	/* Assign 4-byte address mode method that is not determined in BFPT */
+	nor->params->set_4byte_addr_mode = cypress_nor_set_4byte_addr_mode;
+
 	return cypress_nor_set_addr_mode_nbytes(nor);
 }
 
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 3fa83f05bfcc..2bef6da4befa 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -981,6 +981,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->completed_tx_bytes = 0;
 		can->bec.txerr = 0;
 		can->bec.rxerr = 0;
+		can->can.dev->dev_port = i;
 
 		init_completion(&can->start_comp);
 		init_completion(&can->flush_comp);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 7d12776ab63e..8bd7e800af8f 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -851,6 +851,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	netdev->ethtool_ops = &kvaser_usb_ethtool_ops;
 	SET_NETDEV_DEV(netdev, &dev->intf->dev);
 	netdev->dev_id = channel;
+	netdev->dev_port = channel;
 
 	dev->nets[channel] = priv;
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 4d85b29a17b7..ebefc274b50a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -49,7 +49,7 @@ struct __packed pcan_ufd_fw_info {
 	__le32	ser_no;		/* S/N */
 	__le32	flags;		/* special functions */
 
-	/* extended data when type == PCAN_USBFD_TYPE_EXT */
+	/* extended data when type >= PCAN_USBFD_TYPE_EXT */
 	u8	cmd_out_ep;	/* ep for cmd */
 	u8	cmd_in_ep;	/* ep for replies */
 	u8	data_out_ep[2];	/* ep for CANx TX */
@@ -982,10 +982,11 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 			dev->can.ctrlmode |= CAN_CTRLMODE_FD_NON_ISO;
 		}
 
-		/* if vendor rsp is of type 2, then it contains EP numbers to
-		 * use for cmds pipes. If not, then default EP should be used.
+		/* if vendor rsp type is greater than or equal to 2, then it
+		 * contains EP numbers to use for cmds pipes. If not, then
+		 * default EP should be used.
 		 */
-		if (fw_info->type != cpu_to_le16(PCAN_USBFD_TYPE_EXT)) {
+		if (le16_to_cpu(fw_info->type) < PCAN_USBFD_TYPE_EXT) {
 			fw_info->cmd_out_ep = PCAN_USBPRO_EP_CMDOUT;
 			fw_info->cmd_in_ep = PCAN_USBPRO_EP_CMDIN;
 		}
@@ -1018,11 +1019,11 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 	dev->can_channel_id =
 		le32_to_cpu(pdev->usb_if->fw_info.dev_id[dev->ctrl_idx]);
 
-	/* if vendor rsp is of type 2, then it contains EP numbers to
-	 * use for data pipes. If not, then statically defined EP are used
-	 * (see peak_usb_create_dev()).
+	/* if vendor rsp type is greater than or equal to 2, then it contains EP
+	 * numbers to use for data pipes. If not, then statically defined EP are
+	 * used (see peak_usb_create_dev()).
 	 */
-	if (fw_info->type == cpu_to_le16(PCAN_USBFD_TYPE_EXT)) {
+	if (le16_to_cpu(fw_info->type) >= PCAN_USBFD_TYPE_EXT) {
 		dev->ep_msg_in = fw_info->data_in_ep;
 		dev->ep_msg_out = fw_info->data_out_ep[dev->ctrl_idx];
 	}
diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index da7110d67558..6c7454a43bce 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -371,6 +371,9 @@ static void ksz8863_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
 	addr -= dev->info->reg_mib_cnt;
 	ctrl_addr = addr ? KSZ8863_MIB_PACKET_DROPPED_TX_0 :
 			   KSZ8863_MIB_PACKET_DROPPED_RX_0;
+	if (ksz_is_8895_family(dev) &&
+	    ctrl_addr == KSZ8863_MIB_PACKET_DROPPED_RX_0)
+		ctrl_addr = KSZ8895_MIB_PACKET_DROPPED_RX_0;
 	ctrl_addr += port;
 	ctrl_addr |= IND_ACC_TABLE(TABLE_MIB | TABLE_READ);
 
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 329688603a58..da80e659c648 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -784,7 +784,9 @@
 #define KSZ8795_MIB_TOTAL_TX_1		0x105
 
 #define KSZ8863_MIB_PACKET_DROPPED_TX_0 0x100
-#define KSZ8863_MIB_PACKET_DROPPED_RX_0 0x105
+#define KSZ8863_MIB_PACKET_DROPPED_RX_0 0x103
+
+#define KSZ8895_MIB_PACKET_DROPPED_RX_0 0x105
 
 #define MIB_PACKET_DROPPED		0x0000FFFF
 
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index a89aa4ac0a06..779f1324bb5f 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -3852,8 +3852,8 @@ int be_cmd_set_mac_list(struct be_adapter *adapter, u8 *mac_array,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
 	spin_unlock_bh(&adapter->mcc_lock);
+	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
 	return status;
 }
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 6119a4108838..65a2816142d9 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -189,13 +189,14 @@ struct fm10k_q_vector {
 	struct fm10k_ring_container rx, tx;
 
 	struct napi_struct napi;
+	struct rcu_head rcu;	/* to avoid race with update stats on free */
+
 	cpumask_t affinity_mask;
 	char name[IFNAMSIZ + 9];
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dbg_q_vector;
 #endif /* CONFIG_DEBUG_FS */
-	struct rcu_head rcu;	/* to avoid race with update stats on free */
 
 	/* for dynamic allocation of rings associated with this q_vector */
 	struct fm10k_ring ring[] ____cacheline_internodealigned_in_smp;
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index d4255c2706fa..b22bb0ae9b9d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -943,6 +943,7 @@ struct i40e_q_vector {
 	u16 reg_idx;		/* register index of the interrupt */
 
 	struct napi_struct napi;
+	struct rcu_head rcu;	/* to avoid race with update stats on free */
 
 	struct i40e_ring_container rx;
 	struct i40e_ring_container tx;
@@ -953,7 +954,6 @@ struct i40e_q_vector {
 	cpumask_t affinity_mask;
 	struct irq_affinity_notify affinity_notify;
 
-	struct rcu_head rcu;	/* to avoid race with update stats on free */
 	char name[I40E_INT_NAME_STR_LEN];
 	bool arm_wb_state;
 	bool in_busy_poll;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 7c6f81beaee4..369c968a0117 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2226,6 +2226,7 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
 			hh_ts = ((u64)hh_ts_hi << 32) | hh_ts_lo;
 			system->cycles = hh_ts;
 			system->cs_id = CSID_X86_ART;
+			system->use_nsecs = true;
 			/* Read Device source clock time */
 			hh_ts_lo = rd32(hw, GLTSYN_HHTIME_L(tmr_idx));
 			hh_ts_hi = rd32(hw, GLTSYN_HHTIME_H(tmr_idx));
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 559b443c409f..c1f29296c1d5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -503,9 +503,10 @@ struct ixgbe_q_vector {
 	struct ixgbe_ring_container rx, tx;
 
 	struct napi_struct napi;
+	struct rcu_head rcu;	/* to avoid race with update stats on free */
+
 	cpumask_t affinity_mask;
 	int numa_node;
-	struct rcu_head rcu;	/* to avoid race with update stats on free */
 	char name[IFNAMSIZ + 9];
 
 	/* for dynamic allocation of rings associated with this q_vector */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index 8e25f4ef5ccc..5ae787656a7c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -331,6 +331,9 @@ static int port_set_buffer(struct mlx5e_priv *priv,
 	if (err)
 		goto out;
 
+	/* RO bits should be set to 0 on write */
+	MLX5_SET(pbmc_reg, in, port_buffer_size, 0);
+
 	err = mlx5e_port_set_pbmc(mdev, in);
 out:
 	kfree(in);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
index 727fa7c18523..6056106edcc6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
@@ -327,6 +327,10 @@ void mlx5e_ipsec_offload_handle_rx_skb(struct net_device *netdev,
 	if (unlikely(!sa_entry)) {
 		rcu_read_unlock();
 		atomic64_inc(&ipsec->sw_stats.ipsec_rx_drop_sadb_miss);
+		/* Clear secpath to prevent invalid dereference
+		 * in downstream XFRM policy checks.
+		 */
+		secpath_reset(skb);
 		return;
 	}
 	xfrm_state_hold(sa_entry->x);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 8ed47e7a7515..673043d9ed11 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1569,6 +1569,7 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 		unsigned int hdrlen = mlx5e_lro_update_hdr(skb, cqe, cqe_bcnt);
 
 		skb_shinfo(skb)->gso_size = DIV_ROUND_UP(cqe_bcnt - hdrlen, lro_num_seg);
+		skb_shinfo(skb)->gso_segs = lro_num_seg;
 		/* Subtract one since we already counted this as one
 		 * "regular" packet in mlx5e_complete_rx_cqe()
 		 */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
index 7c5516b0a844..8115071c34a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
@@ -30,7 +30,7 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
 
 	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
 	if (!dm)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	spin_lock_init(&dm->lock);
 
@@ -96,7 +96,7 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
 err_steering:
 	kfree(dm);
 
-	return ERR_PTR(-ENOMEM);
+	return NULL;
 }
 
 void mlx5_dm_cleanup(struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 5bc947f703b5..11d8739b9497 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1092,9 +1092,6 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 	}
 
 	dev->dm = mlx5_dm_create(dev);
-	if (IS_ERR(dev->dm))
-		mlx5_core_warn(dev, "Failed to init device memory %ld\n", PTR_ERR(dev->dm));
-
 	dev->tracer = mlx5_fw_tracer_create(dev);
 	dev->hv_vhca = mlx5_hv_vhca_create(dev);
 	dev->rsc_dump = mlx5_rsc_dump_create(dev);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 6a6d7e22f1a7..fc52db8e36f2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -389,8 +389,8 @@ static void fbnic_page_pool_init(struct fbnic_ring *ring, unsigned int idx,
 {
 	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx];
 
-	page_pool_fragment_page(page, PAGECNT_BIAS_MAX);
-	rx_buf->pagecnt_bias = PAGECNT_BIAS_MAX;
+	page_pool_fragment_page(page, FBNIC_PAGECNT_BIAS_MAX);
+	rx_buf->pagecnt_bias = FBNIC_PAGECNT_BIAS_MAX;
 	rx_buf->page = page;
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 2f91f68d11d5..05cde71db9df 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -59,10 +59,8 @@ struct fbnic_queue_stats {
 	struct u64_stats_sync syncp;
 };
 
-/* Pagecnt bias is long max to reserve the last bit to catch overflow
- * cases where if we overcharge the bias it will flip over to be negative.
- */
-#define PAGECNT_BIAS_MAX	LONG_MAX
+#define FBNIC_PAGECNT_BIAS_MAX	PAGE_SIZE
+
 struct fbnic_rx_buf {
 	struct page *page;
 	long pagecnt_bias;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 36328298dc9b..058cd9e9fd71 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2500,7 +2500,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 	budget = min(budget, stmmac_tx_avail(priv, queue));
 
-	while (budget-- > 0) {
+	for (; budget > 0; budget--) {
 		struct stmmac_metadata_request meta_req;
 		struct xsk_tx_metadata *meta = NULL;
 		dma_addr_t dma_addr;
diff --git a/drivers/net/ipa/ipa_sysfs.c b/drivers/net/ipa/ipa_sysfs.c
index a59bd215494c..a53e9e6f6cdf 100644
--- a/drivers/net/ipa/ipa_sysfs.c
+++ b/drivers/net/ipa/ipa_sysfs.c
@@ -37,8 +37,12 @@ static const char *ipa_version_string(struct ipa *ipa)
 		return "4.11";
 	case IPA_VERSION_5_0:
 		return "5.0";
+	case IPA_VERSION_5_1:
+		return "5.1";
+	case IPA_VERSION_5_5:
+		return "5.5";
 	default:
-		return "0.0";	/* Won't happen (checked at probe time) */
+		return "0.0";	/* Should not happen */
 	}
 }
 
diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index b7bc70586ee0..369540b43ada 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -209,10 +209,9 @@ static int unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
 	if (ret)
 		return ret;
 
-	if (!priv->clk)
+	rate = clk_get_rate(priv->clk);
+	if (!rate)
 		rate = 250000000;
-	else
-		rate = clk_get_rate(priv->clk);
 
 	div = (rate / (2 * priv->clk_freq)) - 1;
 	if (div & ~MDIO_CLK_DIV_MASK) {
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index ce49f3ac6939..bce6cc5b04ee 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -897,6 +897,7 @@ static int vsc85xx_eth1_conf(struct phy_device *phydev, enum ts_blk blk,
 				     get_unaligned_be32(ptp_multicast));
 	} else {
 		val |= ANA_ETH1_FLOW_ADDR_MATCH2_ANY_MULTICAST;
+		val |= ANA_ETH1_FLOW_ADDR_MATCH2_ANY_UNICAST;
 		vsc85xx_ts_write_csr(phydev, blk,
 				     MSCC_ANA_ETH1_FLOW_ADDR_MATCH2(0), val);
 		vsc85xx_ts_write_csr(phydev, blk,
diff --git a/drivers/net/phy/mscc/mscc_ptp.h b/drivers/net/phy/mscc/mscc_ptp.h
index da3465360e90..ae9ad925bfa8 100644
--- a/drivers/net/phy/mscc/mscc_ptp.h
+++ b/drivers/net/phy/mscc/mscc_ptp.h
@@ -98,6 +98,7 @@
 #define MSCC_ANA_ETH1_FLOW_ADDR_MATCH2(x) (MSCC_ANA_ETH1_FLOW_ENA(x) + 3)
 #define ANA_ETH1_FLOW_ADDR_MATCH2_MASK_MASK	GENMASK(22, 20)
 #define ANA_ETH1_FLOW_ADDR_MATCH2_ANY_MULTICAST	0x400000
+#define ANA_ETH1_FLOW_ADDR_MATCH2_ANY_UNICAST	0x200000
 #define ANA_ETH1_FLOW_ADDR_MATCH2_FULL_ADDR	0x100000
 #define ANA_ETH1_FLOW_ADDR_MATCH2_SRC_DEST_MASK	GENMASK(17, 16)
 #define ANA_ETH1_FLOW_ADDR_MATCH2_SRC_DEST	0x020000
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 689687bd2574..cec3bb22471b 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -159,19 +159,17 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	int len;
 	unsigned char *data;
 	__u32 seq_recv;
-
-
 	struct rtable *rt;
 	struct net_device *tdev;
 	struct iphdr  *iph;
 	int    max_headroom;
 
 	if (sk_pppox(po)->sk_state & PPPOX_DEAD)
-		goto tx_error;
+		goto tx_drop;
 
 	rt = pptp_route_output(po, &fl4);
 	if (IS_ERR(rt))
-		goto tx_error;
+		goto tx_drop;
 
 	tdev = rt->dst.dev;
 
@@ -179,16 +177,20 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 
 	if (skb_headroom(skb) < max_headroom || skb_cloned(skb) || skb_shared(skb)) {
 		struct sk_buff *new_skb = skb_realloc_headroom(skb, max_headroom);
-		if (!new_skb) {
-			ip_rt_put(rt);
+
+		if (!new_skb)
 			goto tx_error;
-		}
+
 		if (skb->sk)
 			skb_set_owner_w(new_skb, skb->sk);
 		consume_skb(skb);
 		skb = new_skb;
 	}
 
+	/* Ensure we can safely access protocol field and LCP code */
+	if (!pskb_may_pull(skb, 3))
+		goto tx_error;
+
 	data = skb->data;
 	islcp = ((data[0] << 8) + data[1]) == PPP_LCP && 1 <= data[2] && data[2] <= 7;
 
@@ -262,6 +264,8 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	return 1;
 
 tx_error:
+	ip_rt_put(rt);
+tx_drop:
 	kfree_skb(skb);
 	return 1;
 }
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 724b93aa4f7e..ccf45ca2feb5 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1113,6 +1113,9 @@ static void __handle_link_change(struct usbnet *dev)
 	if (!test_bit(EVENT_DEV_OPEN, &dev->flags))
 		return;
 
+	if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
+		netif_carrier_on(dev->net);
+
 	if (!netif_carrier_ok(dev->net)) {
 		/* kill URBs for reading packets to save bus bandwidth */
 		unlink_urbs(dev, &dev->rxq);
@@ -2009,10 +2012,12 @@ EXPORT_SYMBOL(usbnet_manage_power);
 void usbnet_link_change(struct usbnet *dev, bool link, bool need_reset)
 {
 	/* update link after link is reseted */
-	if (link && !need_reset)
-		netif_carrier_on(dev->net);
-	else
+	if (link && !need_reset) {
+		set_bit(EVENT_LINK_CARRIER_ON, &dev->flags);
+	} else {
+		clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags);
 		netif_carrier_off(dev->net);
+	}
 
 	if (need_reset && link)
 		usbnet_defer_kevent(dev, EVENT_LINK_RESET);
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 4087f72f0d2b..89dde220058a 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1324,6 +1324,8 @@ static void vrf_ip6_input_dst(struct sk_buff *skb, struct net_device *vrf_dev,
 	struct net *net = dev_net(vrf_dev);
 	struct rt6_info *rt6;
 
+	skb_dst_drop(skb);
+
 	rt6 = vrf_ip6_route_lookup(net, vrf_dev, &fl6, ifindex, skb,
 				   RT6_LOOKUP_F_HAS_SADDR | RT6_LOOKUP_F_IFACE);
 	if (unlikely(!rt6))
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index c445bf5cd832..f38decae77a9 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1346,6 +1346,10 @@ EXPORT_SYMBOL(ath11k_hal_srng_init);
 void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 {
 	struct ath11k_hal *hal = &ab->hal;
+	int i;
+
+	for (i = 0; i < HAL_SRNG_RING_ID_MAX; i++)
+		ab->hal.srng_list[i].initialized = 0;
 
 	ath11k_hal_unregister_srng_key(ab);
 	ath11k_hal_free_cont_rdp(ab);
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7ead581f5bfd..ddf4ec6b244b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8681,9 +8681,9 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 			return ret;
 		}
-		ieee80211_iterate_stations_atomic(ar->hw,
-						  ath11k_mac_disable_peer_fixed_rate,
-						  arvif);
+		ieee80211_iterate_stations_mtx(ar->hw,
+					       ath11k_mac_disable_peer_fixed_rate,
+					       arvif);
 	} else if (ath11k_mac_bitrate_mask_get_single_nss(ar, arvif, band, mask,
 							  &single_nss)) {
 		rate = WMI_FIXED_RATE_NONE;
@@ -8750,9 +8750,9 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 		}
 
 		mutex_lock(&ar->conf_mutex);
-		ieee80211_iterate_stations_atomic(ar->hw,
-						  ath11k_mac_disable_peer_fixed_rate,
-						  arvif);
+		ieee80211_iterate_stations_mtx(ar->hw,
+					       ath11k_mac_disable_peer_fixed_rate,
+					       arvif);
 
 		arvif->bitrate_mask = *mask;
 		ieee80211_iterate_stations_atomic(ar->hw,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 5c2130f77dac..d5892e17494f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6589,7 +6589,7 @@ static int ath12k_wmi_tlv_services_parser(struct ath12k_base *ab,
 					  void *data)
 {
 	const struct wmi_service_available_event *ev;
-	u32 *wmi_ext2_service_bitmap;
+	__le32 *wmi_ext2_service_bitmap;
 	int i, j;
 	u16 expected_len;
 
@@ -6621,12 +6621,12 @@ static int ath12k_wmi_tlv_services_parser(struct ath12k_base *ab,
 			   ev->wmi_service_segment_bitmap[3]);
 		break;
 	case WMI_TAG_ARRAY_UINT32:
-		wmi_ext2_service_bitmap = (u32 *)ptr;
+		wmi_ext2_service_bitmap = (__le32 *)ptr;
 		for (i = 0, j = WMI_MAX_EXT_SERVICE;
 		     i < WMI_SERVICE_SEGMENT_BM_SIZE32 && j < WMI_MAX_EXT2_SERVICE;
 		     i++) {
 			do {
-				if (wmi_ext2_service_bitmap[i] &
+				if (__le32_to_cpu(wmi_ext2_service_bitmap[i]) &
 				    BIT(j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32))
 					set_bit(j, ab->wmi_ab.svc_map);
 			} while (++j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32);
@@ -6634,8 +6634,10 @@ static int ath12k_wmi_tlv_services_parser(struct ath12k_base *ab,
 
 		ath12k_dbg(ab, ATH12K_DBG_WMI,
 			   "wmi_ext2_service_bitmap 0x%04x 0x%04x 0x%04x 0x%04x",
-			   wmi_ext2_service_bitmap[0], wmi_ext2_service_bitmap[1],
-			   wmi_ext2_service_bitmap[2], wmi_ext2_service_bitmap[3]);
+			   __le32_to_cpu(wmi_ext2_service_bitmap[0]),
+			   __le32_to_cpu(wmi_ext2_service_bitmap[1]),
+			   __le32_to_cpu(wmi_ext2_service_bitmap[2]),
+			   __le32_to_cpu(wmi_ext2_service_bitmap[3]));
 		break;
 	}
 	return 0;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 349aa3439502..708a4e2ad839 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1541,10 +1541,6 @@ brcmf_cfg80211_scan(struct wiphy *wiphy, struct cfg80211_scan_request *request)
 		return -EAGAIN;
 	}
 
-	/* If scan req comes for p2p0, send it over primary I/F */
-	if (vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif)
-		vif = cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
-
 	brcmf_dbg(SCAN, "START ESCAN\n");
 
 	cfg->scan_request = request;
@@ -1560,6 +1556,10 @@ brcmf_cfg80211_scan(struct wiphy *wiphy, struct cfg80211_scan_request *request)
 	if (err)
 		goto scan_out;
 
+	/* If scan req comes for p2p0, send it over primary I/F */
+	if (vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif)
+		vif = cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
+
 	err = brcmf_do_escan(vif->ifp, request);
 	if (err)
 		goto scan_out;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index e0b14be25b02..b8713ebd7190 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1048,9 +1048,11 @@ static void iwl_bg_restart(struct work_struct *data)
  *
  *****************************************************************************/
 
-static void iwl_setup_deferred_work(struct iwl_priv *priv)
+static int iwl_setup_deferred_work(struct iwl_priv *priv)
 {
 	priv->workqueue = alloc_ordered_workqueue(DRV_NAME, 0);
+	if (!priv->workqueue)
+		return -ENOMEM;
 
 	INIT_WORK(&priv->restart, iwl_bg_restart);
 	INIT_WORK(&priv->beacon_update, iwl_bg_beacon_update);
@@ -1067,6 +1069,8 @@ static void iwl_setup_deferred_work(struct iwl_priv *priv)
 	timer_setup(&priv->statistics_periodic, iwl_bg_statistics_periodic, 0);
 
 	timer_setup(&priv->ucode_trace, iwl_bg_ucode_trace, 0);
+
+	return 0;
 }
 
 void iwl_cancel_deferred_work(struct iwl_priv *priv)
@@ -1454,7 +1458,9 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	/********************
 	 * 6. Setup services
 	 ********************/
-	iwl_setup_deferred_work(priv);
+	if (iwl_setup_deferred_work(priv))
+		goto out_uninit_drv;
+
 	iwl_setup_rx_handlers(priv);
 
 	iwl_power_initialize(priv);
@@ -1492,6 +1498,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	iwl_cancel_deferred_work(priv);
 	destroy_workqueue(priv->workqueue);
 	priv->workqueue = NULL;
+out_uninit_drv:
 	iwl_uninit_drv(priv);
 out_free_eeprom_blob:
 	kfree(priv->eeprom_blob);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 4dd4a9d5c71f..a7dbc0a5ea84 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -61,8 +61,10 @@ static int __init iwl_mvm_init(void)
 	}
 
 	ret = iwl_opmode_register("iwlmvm", &iwl_mvm_ops);
-	if (ret)
+	if (ret) {
 		pr_err("Unable to register MVM op_mode: %d\n", ret);
+		iwl_mvm_rate_control_unregister();
+	}
 
 	return ret;
 }
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index bab9ef37a1ab..8bcb1d0dd618 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -1227,6 +1227,10 @@ static int rxq_refill(struct ieee80211_hw *hw, int index, int limit)
 
 		addr = dma_map_single(&priv->pdev->dev, skb->data,
 				      MWL8K_RX_MAXSZ, DMA_FROM_DEVICE);
+		if (dma_mapping_error(&priv->pdev->dev, addr)) {
+			kfree_skb(skb);
+			break;
+		}
 
 		rxq->rxd_count++;
 		rx = rxq->tail++;
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index 82d1bf7edba2..a7f5d287e369 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -99,11 +99,6 @@ int plfxlc_mac_init_hw(struct ieee80211_hw *hw)
 	return r;
 }
 
-void plfxlc_mac_release(struct plfxlc_mac *mac)
-{
-	plfxlc_chip_release(&mac->chip);
-}
-
 int plfxlc_op_start(struct ieee80211_hw *hw)
 {
 	plfxlc_hw_mac(hw)->chip.usb.initialized = 1;
@@ -755,3 +750,9 @@ struct ieee80211_hw *plfxlc_mac_alloc_hw(struct usb_interface *intf)
 	SET_IEEE80211_DEV(hw, &intf->dev);
 	return hw;
 }
+
+void plfxlc_mac_release_hw(struct ieee80211_hw *hw)
+{
+	plfxlc_chip_release(&plfxlc_hw_mac(hw)->chip);
+	ieee80211_free_hw(hw);
+}
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.h b/drivers/net/wireless/purelifi/plfxlc/mac.h
index 9384acddcf26..56da502999c1 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.h
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.h
@@ -168,7 +168,7 @@ static inline u8 *plfxlc_mac_get_perm_addr(struct plfxlc_mac *mac)
 }
 
 struct ieee80211_hw *plfxlc_mac_alloc_hw(struct usb_interface *intf);
-void plfxlc_mac_release(struct plfxlc_mac *mac);
+void plfxlc_mac_release_hw(struct ieee80211_hw *hw);
 
 int plfxlc_mac_preinit_hw(struct ieee80211_hw *hw, const u8 *hw_address);
 int plfxlc_mac_init_hw(struct ieee80211_hw *hw);
diff --git a/drivers/net/wireless/purelifi/plfxlc/usb.c b/drivers/net/wireless/purelifi/plfxlc/usb.c
index 7e7bfa532ed2..966a9e211963 100644
--- a/drivers/net/wireless/purelifi/plfxlc/usb.c
+++ b/drivers/net/wireless/purelifi/plfxlc/usb.c
@@ -604,7 +604,7 @@ static int probe(struct usb_interface *intf,
 	r = plfxlc_upload_mac_and_serial(intf, hw_address, serial_number);
 	if (r) {
 		dev_err(&intf->dev, "MAC and Serial upload failed (%d)\n", r);
-		goto error;
+		goto error_free_hw;
 	}
 
 	chip->unit_type = STA;
@@ -613,13 +613,13 @@ static int probe(struct usb_interface *intf,
 	r = plfxlc_mac_preinit_hw(hw, hw_address);
 	if (r) {
 		dev_err(&intf->dev, "Init mac failed (%d)\n", r);
-		goto error;
+		goto error_free_hw;
 	}
 
 	r = ieee80211_register_hw(hw);
 	if (r) {
 		dev_err(&intf->dev, "Register device failed (%d)\n", r);
-		goto error;
+		goto error_free_hw;
 	}
 
 	if ((le16_to_cpu(interface_to_usbdev(intf)->descriptor.idVendor) ==
@@ -632,7 +632,7 @@ static int probe(struct usb_interface *intf,
 	}
 	if (r != 0) {
 		dev_err(&intf->dev, "FPGA download failed (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}
 
 	tx->mac_fifo_full = 0;
@@ -642,21 +642,21 @@ static int probe(struct usb_interface *intf,
 	r = plfxlc_usb_init_hw(usb);
 	if (r < 0) {
 		dev_err(&intf->dev, "usb_init_hw failed (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}
 
 	msleep(PLF_MSLEEP_TIME);
 	r = plfxlc_chip_switch_radio(chip, PLFXLC_RADIO_ON);
 	if (r < 0) {
 		dev_dbg(&intf->dev, "chip_switch_radio_on failed (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}
 
 	msleep(PLF_MSLEEP_TIME);
 	r = plfxlc_chip_set_rate(chip, 8);
 	if (r < 0) {
 		dev_dbg(&intf->dev, "chip_set_rate failed (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}
 
 	msleep(PLF_MSLEEP_TIME);
@@ -664,7 +664,7 @@ static int probe(struct usb_interface *intf,
 			    hw_address, ETH_ALEN, USB_REQ_MAC_WR);
 	if (r < 0) {
 		dev_dbg(&intf->dev, "MAC_WR failure (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}
 
 	plfxlc_chip_enable_rxtx(chip);
@@ -691,12 +691,12 @@ static int probe(struct usb_interface *intf,
 	plfxlc_mac_init_hw(hw);
 	usb->initialized = true;
 	return 0;
+
+error_unreg_hw:
+	ieee80211_unregister_hw(hw);
+error_free_hw:
+	plfxlc_mac_release_hw(hw);
 error:
-	if (hw) {
-		plfxlc_mac_release(plfxlc_hw_mac(hw));
-		ieee80211_unregister_hw(hw);
-		ieee80211_free_hw(hw);
-	}
 	dev_err(&intf->dev, "pureLifi:Device error");
 	return r;
 }
@@ -730,8 +730,7 @@ static void disconnect(struct usb_interface *intf)
 	 */
 	usb_reset_device(interface_to_usbdev(intf));
 
-	plfxlc_mac_release(mac);
-	ieee80211_free_hw(hw);
+	plfxlc_mac_release_hw(hw);
 }
 
 static void plfxlc_usb_resume(struct plfxlc_usb *usb)
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index 220ac5bdf279..8a57d6c72335 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1041,10 +1041,11 @@ static void rtl8187_stop(struct ieee80211_hw *dev, bool suspend)
 	rtl818x_iowrite8(priv, &priv->map->CONFIG4, reg | RTL818X_CONFIG4_VCOOFF);
 	rtl818x_iowrite8(priv, &priv->map->EEPROM_CMD, RTL818X_EEPROM_CMD_NORMAL);
 
+	usb_kill_anchored_urbs(&priv->anchored);
+
 	while ((skb = skb_dequeue(&priv->b_tx_status.queue)))
 		dev_kfree_skb_any(skb);
 
-	usb_kill_anchored_urbs(&priv->anchored);
 	mutex_unlock(&priv->conf_mutex);
 
 	if (!priv->is_rtl8187b)
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 569856ca677f..c6f69d87c38d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -6617,7 +6617,7 @@ static int rtl8xxxu_submit_rx_urb(struct rtl8xxxu_priv *priv,
 		skb_size = fops->rx_agg_buf_size;
 		skb_size += (rx_desc_sz + sizeof(struct rtl8723au_phy_stats));
 	} else {
-		skb_size = IEEE80211_MAX_FRAME_LEN;
+		skb_size = IEEE80211_MAX_FRAME_LEN + rx_desc_sz;
 	}
 
 	skb = __netdev_alloc_skb(NULL, skb_size, GFP_KERNEL);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index a808af2f085e..01c8b748b20b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -329,7 +329,7 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	int i;
 
-	if (vif->type == NL80211_IFTYPE_STATION) {
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		si->mac_id = rtwvif->mac_id;
 	} else {
 		si->mac_id = rtw_acquire_macid(rtwdev);
@@ -366,7 +366,7 @@ void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 
 	cancel_work_sync(&si->rc_work);
 
-	if (vif->type != NL80211_IFTYPE_STATION)
+	if (vif->type != NL80211_IFTYPE_STATION || sta->tdls)
 		rtw_release_macid(rtwdev, si->mac_id);
 	if (fw_exist)
 		rtw_fw_media_status_report(rtwdev, si->mac_id, false);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 83b22bd0ce81..c336c66ac8e3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2014,6 +2014,11 @@ static void rtw89_core_cancel_6ghz_probe_tx(struct rtw89_dev *rtwdev,
 	if (rx_status->band != NL80211_BAND_6GHZ)
 		return;
 
+	if (unlikely(!(rtwdev->chip->support_bands & BIT(NL80211_BAND_6GHZ)))) {
+		rtw89_debug(rtwdev, RTW89_DBG_UNEXP, "invalid rx on unsupported 6 GHz\n");
+		return;
+	}
+
 	ssid_ie = cfg80211_find_ie(WLAN_EID_SSID, ies, skb->len);
 
 	list_for_each_entry(info, &pkt_list[NL80211_BAND_6GHZ], list) {
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4606c8813666..710e74d3ec3e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1714,24 +1714,24 @@ static int __init nvmet_init(void)
 	if (!nvmet_wq)
 		goto out_free_buffered_work_queue;
 
-	error = nvmet_init_discovery();
+	error = nvmet_init_debugfs();
 	if (error)
 		goto out_free_nvmet_work_queue;
 
-	error = nvmet_init_debugfs();
+	error = nvmet_init_discovery();
 	if (error)
-		goto out_exit_discovery;
+		goto out_exit_debugfs;
 
 	error = nvmet_init_configfs();
 	if (error)
-		goto out_exit_debugfs;
+		goto out_exit_discovery;
 
 	return 0;
 
-out_exit_debugfs:
-	nvmet_exit_debugfs();
 out_exit_discovery:
 	nvmet_exit_discovery();
+out_exit_debugfs:
+	nvmet_exit_debugfs();
 out_free_nvmet_work_queue:
 	destroy_workqueue(nvmet_wq);
 out_free_buffered_work_queue:
@@ -1746,8 +1746,8 @@ static int __init nvmet_init(void)
 static void __exit nvmet_exit(void)
 {
 	nvmet_exit_configfs();
-	nvmet_exit_debugfs();
 	nvmet_exit_discovery();
+	nvmet_exit_debugfs();
 	ida_destroy(&cntlid_ida);
 	destroy_workqueue(nvmet_wq);
 	destroy_workqueue(buffered_io_wq);
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 481dcc476c55..18e65571c145 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -439,7 +439,7 @@ static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 			dev_dbg(dev, "malformed TLP received from the link\n");
 
 		if (sub_reg & PCIE_CORE_INT_UCR)
-			dev_dbg(dev, "malformed TLP received from the link\n");
+			dev_dbg(dev, "Unexpected Completion received from the link\n");
 
 		if (sub_reg & PCIE_CORE_INT_FCE)
 			dev_dbg(dev, "an error was observed in the flow control advertisements from the other side\n");
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 874cb097b093..62d09a528e68 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -530,7 +530,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	struct device *dev = &ntb->epf->dev;
 	int ret;
 	struct pci_epf_bar *epf_bar;
-	void __iomem *mw_addr;
+	void *mw_addr;
 	enum pci_barno barno;
 	size_t size = sizeof(u32) * ntb->db_count;
 
@@ -700,7 +700,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 		barno = pci_epc_get_next_free_bar(epc_features, barno);
 		if (barno < 0) {
 			dev_err(dev, "Fail to get NTB function BAR\n");
-			return barno;
+			return -ENOENT;
 		}
 		ntb->epf_ntb_bar[bar] = barno;
 	}
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 573a41869c15..4f85e7fe29ec 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -3,12 +3,15 @@
  * PCI Hotplug Driver for PowerPC PowerNV platform.
  *
  * Copyright Gavin Shan, IBM Corporation 2016.
+ * Copyright (C) 2025 Raptor Engineering, LLC
+ * Copyright (C) 2025 Raptor Computing Systems, LLC
  */
 
 #include <linux/bitfield.h>
 #include <linux/libfdt.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 #include <linux/pci_hotplug.h>
 #include <linux/of_fdt.h>
 
@@ -36,8 +39,10 @@ static void pnv_php_register(struct device_node *dn);
 static void pnv_php_unregister_one(struct device_node *dn);
 static void pnv_php_unregister(struct device_node *dn);
 
+static void pnv_php_enable_irq(struct pnv_php_slot *php_slot);
+
 static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
-				bool disable_device)
+				bool disable_device, bool disable_msi)
 {
 	struct pci_dev *pdev = php_slot->pdev;
 	u16 ctrl;
@@ -53,19 +58,15 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 		php_slot->irq = 0;
 	}
 
-	if (php_slot->wq) {
-		destroy_workqueue(php_slot->wq);
-		php_slot->wq = NULL;
-	}
-
-	if (disable_device) {
+	if (disable_device || disable_msi) {
 		if (pdev->msix_enabled)
 			pci_disable_msix(pdev);
 		else if (pdev->msi_enabled)
 			pci_disable_msi(pdev);
+	}
 
+	if (disable_device)
 		pci_disable_device(pdev);
-	}
 }
 
 static void pnv_php_free_slot(struct kref *kref)
@@ -74,7 +75,8 @@ static void pnv_php_free_slot(struct kref *kref)
 					struct pnv_php_slot, kref);
 
 	WARN_ON(!list_empty(&php_slot->children));
-	pnv_php_disable_irq(php_slot, false);
+	pnv_php_disable_irq(php_slot, false, false);
+	destroy_workqueue(php_slot->wq);
 	kfree(php_slot->name);
 	kfree(php_slot);
 }
@@ -391,6 +393,20 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
 	return 0;
 }
 
+static int pcie_check_link_active(struct pci_dev *pdev)
+{
+	u16 lnk_status;
+	int ret;
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
+		return -ENODEV;
+
+	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+
+	return ret;
+}
+
 static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
@@ -403,6 +419,19 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 	 */
 	ret = pnv_pci_get_presence_state(php_slot->id, &presence);
 	if (ret >= 0) {
+		if (pci_pcie_type(php_slot->pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
+			presence == OPAL_PCI_SLOT_EMPTY) {
+			/*
+			 * Similar to pciehp_hpc, check whether the Link Active
+			 * bit is set to account for broken downstream bridges
+			 * that don't properly assert Presence Detect State, as
+			 * was observed on the Microsemi Switchtec PM8533 PFX
+			 * [11f8:8533].
+			 */
+			if (pcie_check_link_active(php_slot->pdev) > 0)
+				presence = OPAL_PCI_SLOT_PRESENT;
+		}
+
 		*state = presence;
 		ret = 0;
 	} else {
@@ -442,6 +471,61 @@ static int pnv_php_set_attention_state(struct hotplug_slot *slot, u8 state)
 	return 0;
 }
 
+static int pnv_php_activate_slot(struct pnv_php_slot *php_slot,
+				 struct hotplug_slot *slot)
+{
+	int ret, i;
+
+	/*
+	 * Issue initial slot activation command to firmware
+	 *
+	 * Firmware will power slot on, attempt to train the link, and
+	 * discover any downstream devices. If this process fails, firmware
+	 * will return an error code and an invalid device tree. Failure
+	 * can be caused for multiple reasons, including a faulty
+	 * downstream device, poor connection to the downstream device, or
+	 * a previously latched PHB fence.  On failure, issue fundamental
+	 * reset up to three times before aborting.
+	 */
+	ret = pnv_php_set_slot_power_state(slot, OPAL_PCI_SLOT_POWER_ON);
+	if (ret) {
+		SLOT_WARN(
+			php_slot,
+			"PCI slot activation failed with error code %d, possible frozen PHB",
+			ret);
+		SLOT_WARN(
+			php_slot,
+			"Attempting complete PHB reset before retrying slot activation\n");
+		for (i = 0; i < 3; i++) {
+			/*
+			 * Slot activation failed, PHB may be fenced from a
+			 * prior device failure.
+			 *
+			 * Use the OPAL fundamental reset call to both try a
+			 * device reset and clear any potentially active PHB
+			 * fence / freeze.
+			 */
+			SLOT_WARN(php_slot, "Try %d...\n", i + 1);
+			pci_set_pcie_reset_state(php_slot->pdev,
+						 pcie_warm_reset);
+			msleep(250);
+			pci_set_pcie_reset_state(php_slot->pdev,
+						 pcie_deassert_reset);
+
+			ret = pnv_php_set_slot_power_state(
+				slot, OPAL_PCI_SLOT_POWER_ON);
+			if (!ret)
+				break;
+		}
+
+		if (i >= 3)
+			SLOT_WARN(php_slot,
+				  "Failed to bring slot online, aborting!\n");
+	}
+
+	return ret;
+}
+
 static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 {
 	struct hotplug_slot *slot = &php_slot->slot;
@@ -504,7 +588,7 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 		goto scan;
 
 	/* Power is off, turn it on and then scan the slot */
-	ret = pnv_php_set_slot_power_state(slot, OPAL_PCI_SLOT_POWER_ON);
+	ret = pnv_php_activate_slot(php_slot, slot);
 	if (ret)
 		return ret;
 
@@ -561,8 +645,58 @@ static int pnv_php_reset_slot(struct hotplug_slot *slot, bool probe)
 static int pnv_php_enable_slot(struct hotplug_slot *slot)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
+	u32 prop32;
+	int ret;
+
+	ret = pnv_php_enable(php_slot, true);
+	if (ret)
+		return ret;
+
+	/* (Re-)enable interrupt if the slot supports surprise hotplug */
+	ret = of_property_read_u32(php_slot->dn, "ibm,slot-surprise-pluggable",
+				   &prop32);
+	if (!ret && prop32)
+		pnv_php_enable_irq(php_slot);
+
+	return 0;
+}
+
+/*
+ * Disable any hotplug interrupts for all slots on the provided bus, as well as
+ * all downstream slots in preparation for a hot unplug.
+ */
+static int pnv_php_disable_all_irqs(struct pci_bus *bus)
+{
+	struct pci_bus *child_bus;
+	struct pci_slot *slot;
+
+	/* First go down child buses */
+	list_for_each_entry(child_bus, &bus->children, node)
+		pnv_php_disable_all_irqs(child_bus);
+
+	/* Disable IRQs for all pnv_php slots on this bus */
+	list_for_each_entry(slot, &bus->slots, list) {
+		struct pnv_php_slot *php_slot = to_pnv_php_slot(slot->hotplug);
 
-	return pnv_php_enable(php_slot, true);
+		pnv_php_disable_irq(php_slot, false, true);
+	}
+
+	return 0;
+}
+
+/*
+ * Disable any hotplug interrupts for all downstream slots on the provided
+ * bus in preparation for a hot unplug.
+ */
+static int pnv_php_disable_all_downstream_irqs(struct pci_bus *bus)
+{
+	struct pci_bus *child_bus;
+
+	/* Go down child buses, recursively deactivating their IRQs */
+	list_for_each_entry(child_bus, &bus->children, node)
+		pnv_php_disable_all_irqs(child_bus);
+
+	return 0;
 }
 
 static int pnv_php_disable_slot(struct hotplug_slot *slot)
@@ -579,6 +713,13 @@ static int pnv_php_disable_slot(struct hotplug_slot *slot)
 	    php_slot->state != PNV_PHP_STATE_REGISTERED)
 		return 0;
 
+	/*
+	 * Free all IRQ resources from all child slots before remove.
+	 * Note that we do not disable the root slot IRQ here as that
+	 * would also deactivate the slot hot (re)plug interrupt!
+	 */
+	pnv_php_disable_all_downstream_irqs(php_slot->bus);
+
 	/* Remove all devices behind the slot */
 	pci_lock_rescan_remove();
 	pci_hp_remove_devices(php_slot->bus);
@@ -647,6 +788,15 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 		return NULL;
 	}
 
+	/* Allocate workqueue for this slot's interrupt handling */
+	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
+	if (!php_slot->wq) {
+		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
+		kfree(php_slot->name);
+		kfree(php_slot);
+		return NULL;
+	}
+
 	if (dn->child && PCI_DN(dn->child))
 		php_slot->slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
 	else
@@ -745,16 +895,63 @@ static int pnv_php_enable_msix(struct pnv_php_slot *php_slot)
 	return entry.vector;
 }
 
+static void
+pnv_php_detect_clear_suprise_removal_freeze(struct pnv_php_slot *php_slot)
+{
+	struct pci_dev *pdev = php_slot->pdev;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	int i, rc;
+
+	/*
+	 * When a device is surprise removed from a downstream bridge slot,
+	 * the upstream bridge port can still end up frozen due to related EEH
+	 * events, which will in turn block the MSI interrupts for slot hotplug
+	 * detection.
+	 *
+	 * Detect and thaw any frozen upstream PE after slot deactivation.
+	 */
+	edev = pci_dev_to_eeh_dev(pdev);
+	pe = edev ? edev->pe : NULL;
+	rc = eeh_pe_get_state(pe);
+	if ((rc == -ENODEV) || (rc == -ENOENT)) {
+		SLOT_WARN(
+			php_slot,
+			"Upstream bridge PE state unknown, hotplug detect may fail\n");
+	} else {
+		if (pe->state & EEH_PE_ISOLATED) {
+			SLOT_WARN(
+				php_slot,
+				"Upstream bridge PE %02x frozen, thawing...\n",
+				pe->addr);
+			for (i = 0; i < 3; i++)
+				if (!eeh_unfreeze_pe(pe))
+					break;
+			if (i >= 3)
+				SLOT_WARN(
+					php_slot,
+					"Unable to thaw PE %02x, hotplug detect will fail!\n",
+					pe->addr);
+			else
+				SLOT_WARN(php_slot,
+					  "PE %02x thawed successfully\n",
+					  pe->addr);
+		}
+	}
+}
+
 static void pnv_php_event_handler(struct work_struct *work)
 {
 	struct pnv_php_event *event =
 		container_of(work, struct pnv_php_event, work);
 	struct pnv_php_slot *php_slot = event->php_slot;
 
-	if (event->added)
+	if (event->added) {
 		pnv_php_enable_slot(&php_slot->slot);
-	else
+	} else {
 		pnv_php_disable_slot(&php_slot->slot);
+		pnv_php_detect_clear_suprise_removal_freeze(php_slot);
+	}
 
 	kfree(event);
 }
@@ -843,14 +1040,6 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 	u16 sts, ctrl;
 	int ret;
 
-	/* Allocate workqueue */
-	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
-	if (!php_slot->wq) {
-		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
-		pnv_php_disable_irq(php_slot, true);
-		return;
-	}
-
 	/* Check PDC (Presence Detection Change) is broken or not */
 	ret = of_property_read_u32(php_slot->dn, "ibm,slot-broken-pdc",
 				   &broken_pdc);
@@ -869,7 +1058,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 	ret = request_irq(irq, pnv_php_interrupt, IRQF_SHARED,
 			  php_slot->name, php_slot);
 	if (ret) {
-		pnv_php_disable_irq(php_slot, true);
+		pnv_php_disable_irq(php_slot, true, true);
 		SLOT_WARN(php_slot, "Error %d enabling IRQ %d\n", ret, irq);
 		return;
 	}
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a392e060ca2f..b8289b6c395b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -81,24 +81,44 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
 
 void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 {
+	struct pci_dev *parent = pdev->bus->self;
 	struct pci_cap_saved_state *save_state;
-	u16 l1ss = pdev->l1ss;
 	u32 *cap;
 
+	/*
+	 * If this is a Downstream Port, we never restore the L1SS state
+	 * directly; we only restore it when we restore the state of the
+	 * Upstream Port below it.
+	 */
+	if (pcie_downstream_port(pdev) || !parent)
+		return;
+
+	if (!pdev->l1ss || !parent->l1ss)
+		return;
+
 	/*
 	 * Save L1 substate configuration. The ASPM L0s/L1 configuration
 	 * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
 	 */
-	if (!l1ss)
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!save_state)
 		return;
 
-	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
+	cap = &save_state->cap.data[0];
+	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
+	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
+
+	/*
+	 * Save parent's L1 substate configuration so we have it for
+	 * pci_restore_aspm_l1ss_state(pdev) to restore.
+	 */
+	save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
 	if (!save_state)
 		return;
 
 	cap = &save_state->cap.data[0];
-	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
-	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, cap++);
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, cap++);
 }
 
 void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index b87d3a9ba7d5..4b9d53dae897 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -545,6 +545,8 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
 		return err;
 
 	cd->cpu = cpumask_local_spread(0, dev_to_node(ni->dev));
+	irq_set_affinity(cd->irq, cpumask_of(cd->cpu));
+
 	cd->pmu = (struct pmu) {
 		.module = THIS_MODULE,
 		.parent = ni->dev,
diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index 68cc8e24f383..163950e16dbe 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -37,32 +37,13 @@
 #define EUSB2_TUNE_EUSB_EQU		0x5A
 #define EUSB2_TUNE_EUSB_HS_COMP_CUR	0x5B
 
-enum eusb2_reg_layout {
-	TUNE_EUSB_HS_COMP_CUR,
-	TUNE_EUSB_EQU,
-	TUNE_EUSB_SLEW,
-	TUNE_USB2_HS_COMP_CUR,
-	TUNE_USB2_PREEM,
-	TUNE_USB2_EQU,
-	TUNE_USB2_SLEW,
-	TUNE_SQUELCH_U,
-	TUNE_HSDISC,
-	TUNE_RES_FSDIF,
-	TUNE_IUSB2,
-	TUNE_USB2_CROSSOVER,
-	NUM_TUNE_FIELDS,
-
-	FORCE_VAL_5 = NUM_TUNE_FIELDS,
-	FORCE_EN_5,
-
-	EN_CTL1,
-
-	RPTR_STATUS,
-	LAYOUT_SIZE,
+struct eusb2_repeater_init_tbl_reg {
+	unsigned int reg;
+	unsigned int value;
 };
 
 struct eusb2_repeater_cfg {
-	const u32 *init_tbl;
+	const struct eusb2_repeater_init_tbl_reg *init_tbl;
 	int init_tbl_num;
 	const char * const *vreg_list;
 	int num_vregs;
@@ -82,16 +63,16 @@ static const char * const pm8550b_vreg_l[] = {
 	"vdd18", "vdd3",
 };
 
-static const u32 pm8550b_init_tbl[NUM_TUNE_FIELDS] = {
-	[TUNE_IUSB2] = 0x8,
-	[TUNE_SQUELCH_U] = 0x3,
-	[TUNE_USB2_PREEM] = 0x5,
+static const struct eusb2_repeater_init_tbl_reg pm8550b_init_tbl[] = {
+	{ EUSB2_TUNE_IUSB2, 0x8 },
+	{ EUSB2_TUNE_SQUELCH_U, 0x3 },
+	{ EUSB2_TUNE_USB2_PREEM, 0x5 },
 };
 
-static const u32 smb2360_init_tbl[NUM_TUNE_FIELDS] = {
-	[TUNE_IUSB2] = 0x5,
-	[TUNE_SQUELCH_U] = 0x3,
-	[TUNE_USB2_PREEM] = 0x2,
+static const struct eusb2_repeater_init_tbl_reg smb2360_init_tbl[] = {
+	{ EUSB2_TUNE_IUSB2, 0x5 },
+	{ EUSB2_TUNE_SQUELCH_U, 0x3 },
+	{ EUSB2_TUNE_USB2_PREEM, 0x2 },
 };
 
 static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
@@ -129,17 +110,10 @@ static int eusb2_repeater_init(struct phy *phy)
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
 	struct device_node *np = rptr->dev->of_node;
 	struct regmap *regmap = rptr->regmap;
-	const u32 *init_tbl = rptr->cfg->init_tbl;
-	u8 tune_usb2_preem = init_tbl[TUNE_USB2_PREEM];
-	u8 tune_hsdisc = init_tbl[TUNE_HSDISC];
-	u8 tune_iusb2 = init_tbl[TUNE_IUSB2];
 	u32 base = rptr->base;
-	u32 val;
+	u32 poll_val;
 	int ret;
-
-	of_property_read_u8(np, "qcom,tune-usb2-amplitude", &tune_iusb2);
-	of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &tune_hsdisc);
-	of_property_read_u8(np, "qcom,tune-usb2-preem", &tune_usb2_preem);
+	u8 val;
 
 	ret = regulator_bulk_enable(rptr->cfg->num_vregs, rptr->vregs);
 	if (ret)
@@ -147,21 +121,24 @@ static int eusb2_repeater_init(struct phy *phy)
 
 	regmap_write(regmap, base + EUSB2_EN_CTL1, EUSB2_RPTR_EN);
 
-	regmap_write(regmap, base + EUSB2_TUNE_EUSB_HS_COMP_CUR, init_tbl[TUNE_EUSB_HS_COMP_CUR]);
-	regmap_write(regmap, base + EUSB2_TUNE_EUSB_EQU, init_tbl[TUNE_EUSB_EQU]);
-	regmap_write(regmap, base + EUSB2_TUNE_EUSB_SLEW, init_tbl[TUNE_EUSB_SLEW]);
-	regmap_write(regmap, base + EUSB2_TUNE_USB2_HS_COMP_CUR, init_tbl[TUNE_USB2_HS_COMP_CUR]);
-	regmap_write(regmap, base + EUSB2_TUNE_USB2_EQU, init_tbl[TUNE_USB2_EQU]);
-	regmap_write(regmap, base + EUSB2_TUNE_USB2_SLEW, init_tbl[TUNE_USB2_SLEW]);
-	regmap_write(regmap, base + EUSB2_TUNE_SQUELCH_U, init_tbl[TUNE_SQUELCH_U]);
-	regmap_write(regmap, base + EUSB2_TUNE_RES_FSDIF, init_tbl[TUNE_RES_FSDIF]);
-	regmap_write(regmap, base + EUSB2_TUNE_USB2_CROSSOVER, init_tbl[TUNE_USB2_CROSSOVER]);
-
-	regmap_write(regmap, base + EUSB2_TUNE_USB2_PREEM, tune_usb2_preem);
-	regmap_write(regmap, base + EUSB2_TUNE_HSDISC, tune_hsdisc);
-	regmap_write(regmap, base + EUSB2_TUNE_IUSB2, tune_iusb2);
-
-	ret = regmap_read_poll_timeout(regmap, base + EUSB2_RPTR_STATUS, val, val & RPTR_OK, 10, 5);
+	/* Write registers from init table */
+	for (int i = 0; i < rptr->cfg->init_tbl_num; i++)
+		regmap_write(regmap, base + rptr->cfg->init_tbl[i].reg,
+			     rptr->cfg->init_tbl[i].value);
+
+	/* Override registers from devicetree values */
+	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &val))
+		regmap_write(regmap, base + EUSB2_TUNE_USB2_PREEM, val);
+
+	if (!of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &val))
+		regmap_write(regmap, base + EUSB2_TUNE_HSDISC, val);
+
+	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &val))
+		regmap_write(regmap, base + EUSB2_TUNE_IUSB2, val);
+
+	/* Wait for status OK */
+	ret = regmap_read_poll_timeout(regmap, base + EUSB2_RPTR_STATUS, poll_val,
+				       poll_val & RPTR_OK, 10, 5);
 	if (ret)
 		dev_err(rptr->dev, "initialization timed-out\n");
 
diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
index c372a2a24be4..9dc2da8056b7 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -204,6 +204,7 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
 	const struct berlin_desc_group *desc_group;
 	const struct berlin_desc_function *desc_function;
 	int i, max_functions = 0;
+	struct pinfunction *new_functions;
 
 	pctrl->nfunctions = 0;
 
@@ -229,12 +230,15 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
 		}
 	}
 
-	pctrl->functions = krealloc(pctrl->functions,
+	new_functions = krealloc(pctrl->functions,
 				    pctrl->nfunctions * sizeof(*pctrl->functions),
 				    GFP_KERNEL);
-	if (!pctrl->functions)
+	if (!new_functions) {
+		kfree(pctrl->functions);
 		return -ENOMEM;
+	}
 
+	pctrl->functions = new_functions;
 	/* map functions to theirs groups */
 	for (i = 0; i < pctrl->desc->ngroups; i++) {
 		desc_group = pctrl->desc->groups + i;
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 0743190da59e..2c31e7f2a27a 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -236,18 +236,7 @@ static const char *pin_free(struct pinctrl_dev *pctldev, int pin,
 			if (desc->mux_usecount)
 				return NULL;
 		}
-	}
-
-	/*
-	 * If there is no kind of request function for the pin we just assume
-	 * we got it by default and proceed.
-	 */
-	if (gpio_range && ops->gpio_disable_free)
-		ops->gpio_disable_free(pctldev, gpio_range, pin);
-	else if (ops->free)
-		ops->free(pctldev, pin);
 
-	scoped_guard(mutex, &desc->mux_lock) {
 		if (gpio_range) {
 			owner = desc->gpio_owner;
 			desc->gpio_owner = NULL;
@@ -258,6 +247,15 @@ static const char *pin_free(struct pinctrl_dev *pctldev, int pin,
 		}
 	}
 
+	/*
+	 * If there is no kind of request function for the pin we just assume
+	 * we got it by default and proceed.
+	 */
+	if (gpio_range && ops->gpio_disable_free)
+		ops->gpio_disable_free(pctldev, gpio_range, pin);
+	else if (ops->free)
+		ops->free(pctldev, pin);
+
 	module_put(pctldev->owner);
 
 	return owner;
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index bde67ee31417..8fbbdcc52deb 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -395,6 +395,7 @@ static int sunxi_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	const char *function, *pin_prop;
 	const char *group;
 	int ret, npins, nmaps, configlen = 0, i = 0;
+	struct pinctrl_map *new_map;
 
 	*map = NULL;
 	*num_maps = 0;
@@ -469,9 +470,13 @@ static int sunxi_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	 * We know have the number of maps we need, we can resize our
 	 * map array
 	 */
-	*map = krealloc(*map, i * sizeof(struct pinctrl_map), GFP_KERNEL);
-	if (!*map)
-		return -ENOMEM;
+	new_map = krealloc(*map, i * sizeof(struct pinctrl_map), GFP_KERNEL);
+	if (!new_map) {
+		ret = -ENOMEM;
+		goto err_free_map;
+	}
+
+	*map = new_map;
 
 	return 0;
 
diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index c3ca2ac91b05..d2f0aea6ea50 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -97,7 +97,7 @@ intel_pmt_read(struct file *filp, struct kobject *kobj,
 	if (count > entry->size - off)
 		count = entry->size - off;
 
-	count = pmt_telem_read_mmio(entry->ep->pcidev, entry->cb, entry->header.guid, buf,
+	count = pmt_telem_read_mmio(entry->pcidev, entry->cb, entry->header.guid, buf,
 				    entry->base, off, count);
 
 	return count;
@@ -252,6 +252,7 @@ static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
 		return -EINVAL;
 	}
 
+	entry->pcidev = pci_dev;
 	entry->guid = header->guid;
 	entry->size = header->size;
 	entry->cb = ivdev->priv_data;
diff --git a/drivers/platform/x86/intel/pmt/class.h b/drivers/platform/x86/intel/pmt/class.h
index b2006d57779d..f6ce80c4e051 100644
--- a/drivers/platform/x86/intel/pmt/class.h
+++ b/drivers/platform/x86/intel/pmt/class.h
@@ -39,6 +39,7 @@ struct intel_pmt_header {
 
 struct intel_pmt_entry {
 	struct telem_endpoint	*ep;
+	struct pci_dev		*pcidev;
 	struct intel_pmt_header	header;
 	struct bin_attribute	pmt_bin_attr;
 	struct kobject		*kobj;
diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 91e7292d86bb..66dc622159a6 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -688,9 +688,8 @@ static void cpcap_usb_detect(struct work_struct *work)
 		struct power_supply *battery;
 
 		battery = power_supply_get_by_name("battery");
-		if (IS_ERR_OR_NULL(battery)) {
-			dev_err(ddata->dev, "battery power_supply not available %li\n",
-					PTR_ERR(battery));
+		if (!battery) {
+			dev_err(ddata->dev, "battery power_supply not available\n");
 			return;
 		}
 
diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supply/max14577_charger.c
index b28c04157709..90d40b35256f 100644
--- a/drivers/power/supply/max14577_charger.c
+++ b/drivers/power/supply/max14577_charger.c
@@ -501,7 +501,7 @@ static struct max14577_charger_platform_data *max14577_charger_dt_init(
 static struct max14577_charger_platform_data *max14577_charger_dt_init(
 		struct platform_device *pdev)
 {
-	return NULL;
+	return ERR_PTR(-ENODATA);
 }
 #endif /* CONFIG_OF */
 
@@ -572,7 +572,7 @@ static int max14577_charger_probe(struct platform_device *pdev)
 	chg->max14577 = max14577;
 
 	chg->pdata = max14577_charger_dt_init(pdev);
-	if (IS_ERR_OR_NULL(chg->pdata))
+	if (IS_ERR(chg->pdata))
 		return PTR_ERR(chg->pdata);
 
 	ret = max14577_charger_reg_init(chg);
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 6b6f51b21550..99390ec1481f 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -96,6 +96,8 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 	int i;
 
 	pd = em_cpu_get(dtpm_cpu->cpu);
+	if (!pd)
+		return 0;
 
 	pd_mask = em_span_cpus(pd);
 
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 6a02245ea35f..9463232af8d2 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -41,6 +41,9 @@ static __poll_t pps_cdev_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &pps->queue, wait);
 
+	if (pps->last_fetched_ev == pps->last_ev)
+		return 0;
+
 	return EPOLLIN | EPOLLRDNORM;
 }
 
@@ -186,9 +189,11 @@ static long pps_cdev_ioctl(struct file *file,
 		if (err)
 			return err;
 
-		/* Return the fetched timestamp */
+		/* Return the fetched timestamp and save last fetched event  */
 		spin_lock_irq(&pps->lock);
 
+		pps->last_fetched_ev = pps->last_ev;
+
 		fdata.info.assert_sequence = pps->assert_sequence;
 		fdata.info.clear_sequence = pps->clear_sequence;
 		fdata.info.assert_tu = pps->assert_tu;
@@ -272,9 +277,11 @@ static long pps_cdev_compat_ioctl(struct file *file,
 		if (err)
 			return err;
 
-		/* Return the fetched timestamp */
+		/* Return the fetched timestamp and save last fetched event  */
 		spin_lock_irq(&pps->lock);
 
+		pps->last_fetched_ev = pps->last_ev;
+
 		compat.info.assert_sequence = pps->assert_sequence;
 		compat.info.clear_sequence = pps->clear_sequence;
 		compat.info.current_mode = pps->current_mode;
diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 5aeedeaf3c41..c165422d0651 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -906,6 +906,8 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 
 	rproc_coredump_set_elf_info(r5_rproc, ELFCLASS32, EM_ARM);
 
+	r5_rproc->recovery_disabled = true;
+	r5_rproc->has_iommu = false;
 	r5_rproc->auto_boot = false;
 	r5_core = r5_rproc->priv;
 	r5_core->dev = cdev;
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 5efbe69bf5ca..c8a666de9cbe 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1466,7 +1466,7 @@ static long ds3231_clk_sqw_round_rate(struct clk_hw *hw, unsigned long rate,
 			return ds3231_clk_sqw_rates[i];
 	}
 
-	return 0;
+	return ds3231_clk_sqw_rates[ARRAY_SIZE(ds3231_clk_sqw_rates) - 1];
 }
 
 static int ds3231_clk_sqw_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 63f11ea3589d..759dc2ad6e3b 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -294,7 +294,7 @@ static long hym8563_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] <= rate)
 			return clkout_rates[i];
 
-	return 0;
+	return clkout_rates[0];
 }
 
 static int hym8563_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
index 76c5f464b2da..cea05fca0bcc 100644
--- a/drivers/rtc/rtc-nct3018y.c
+++ b/drivers/rtc/rtc-nct3018y.c
@@ -376,7 +376,7 @@ static long nct3018y_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] <= rate)
 			return clkout_rates[i];
 
-	return 0;
+	return clkout_rates[0];
 }
 
 static int nct3018y_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 73848f764559..2b4921c23467 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -410,7 +410,7 @@ static long pcf85063_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] <= rate)
 			return clkout_rates[i];
 
-	return 0;
+	return clkout_rates[0];
 }
 
 static int pcf85063_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 647d52f1f5c5..23b21b908915 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -386,7 +386,7 @@ static long pcf8563_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] <= rate)
 			return clkout_rates[i];
 
-	return 0;
+	return clkout_rates[0];
 }
 
 static int pcf8563_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index 2f001c59c61d..86b7f821e937 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -738,7 +738,7 @@ static long rv3028_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] <= rate)
 			return clkout_rates[i];
 
-	return 0;
+	return clkout_rates[0];
 }
 
 static int rv3028_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index f4622ee4d894..6111913c858c 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -180,7 +180,7 @@ struct ap_card {
 	atomic64_t total_request_count;	/* # requests ever for this AP device.*/
 };
 
-#define TAPQ_CARD_HWINFO_MASK 0xFEFF0000FFFF0F0FUL
+#define TAPQ_CARD_HWINFO_MASK 0xFFFF0000FFFF0F0FUL
 #define ASSOC_IDX_INVALID 0x10000
 
 #define to_ap_card(x) container_of((x), struct ap_card, ap_dev.device)
diff --git a/drivers/scsi/elx/efct/efct_lio.c b/drivers/scsi/elx/efct/efct_lio.c
index 9ac69356b13e..bd3d489e56ae 100644
--- a/drivers/scsi/elx/efct/efct_lio.c
+++ b/drivers/scsi/elx/efct/efct_lio.c
@@ -382,7 +382,7 @@ efct_lio_sg_unmap(struct efct_io *io)
 		return;
 
 	dma_unmap_sg(&io->efct->pci->dev, cmd->t_data_sg,
-		     ocp->seg_map_cnt, cmd->data_direction);
+		     cmd->t_data_nents, cmd->data_direction);
 	ocp->seg_map_cnt = 0;
 }
 
diff --git a/drivers/scsi/ibmvscsi_tgt/libsrp.c b/drivers/scsi/ibmvscsi_tgt/libsrp.c
index 8a0e28aec928..0ecad398ed3d 100644
--- a/drivers/scsi/ibmvscsi_tgt/libsrp.c
+++ b/drivers/scsi/ibmvscsi_tgt/libsrp.c
@@ -184,7 +184,8 @@ static int srp_direct_data(struct ibmvscsis_cmd *cmd, struct srp_direct_buf *md,
 	err = rdma_io(cmd, sg, nsg, md, 1, dir, len);
 
 	if (dma_map)
-		dma_unmap_sg(iue->target->dev, sg, nsg, DMA_BIDIRECTIONAL);
+		dma_unmap_sg(iue->target->dev, sg, cmd->se_cmd.t_data_nents,
+			     DMA_BIDIRECTIONAL);
 
 	return err;
 }
@@ -256,7 +257,8 @@ static int srp_indirect_data(struct ibmvscsis_cmd *cmd, struct srp_cmd *srp_cmd,
 	err = rdma_io(cmd, sg, nsg, md, nmd, dir, len);
 
 	if (dma_map)
-		dma_unmap_sg(iue->target->dev, sg, nsg, DMA_BIDIRECTIONAL);
+		dma_unmap_sg(iue->target->dev, sg, cmd->se_cmd.t_data_nents,
+			     DMA_BIDIRECTIONAL);
 
 free_mem:
 	if (token && dma_map) {
diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index 355a0bc0828e..bb89a2e33eb4 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -2904,7 +2904,7 @@ static void isci_request_io_request_complete(struct isci_host *ihost,
 					 task->total_xfer_len, task->data_dir);
 		else  /* unmap the sgl dma addresses */
 			dma_unmap_sg(&ihost->pdev->dev, task->scatter,
-				     request->num_sg_entries, task->data_dir);
+				     task->num_scatter, task->data_dir);
 		break;
 	case SAS_PROTOCOL_SMP: {
 		struct scatterlist *sg = &task->smp_task.smp_req;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 9599d7a50028..91aa9de3b84f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -10790,8 +10790,7 @@ _mpt3sas_fw_work(struct MPT3SAS_ADAPTER *ioc, struct fw_event_work *fw_event)
 		break;
 	case MPI2_EVENT_PCIE_TOPOLOGY_CHANGE_LIST:
 		_scsih_pcie_topology_change_event(ioc, fw_event);
-		ioc->current_event = NULL;
-		return;
+		break;
 	}
 out:
 	fw_event_work_put(fw_event);
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 1444b1f1c4c8..d6897432cf0f 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -828,7 +828,7 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
 	dev_printk(KERN_ERR, mvi->dev, "mvsas prep failed[%d]!\n", rc);
 	if (!sas_protocol_ata(task->task_proto))
 		if (n_elem)
-			dma_unmap_sg(mvi->dev, task->scatter, n_elem,
+			dma_unmap_sg(mvi->dev, task->scatter, task->num_scatter,
 				     task->data_dir);
 prep_out:
 	return rc;
@@ -874,7 +874,7 @@ static void mvs_slot_task_free(struct mvs_info *mvi, struct sas_task *task,
 	if (!sas_protocol_ata(task->task_proto))
 		if (slot->n_elem)
 			dma_unmap_sg(mvi->dev, task->scatter,
-				     slot->n_elem, task->data_dir);
+				     task->num_scatter, task->data_dir);
 
 	switch (task->task_proto) {
 	case SAS_PROTOCOL_SMP:
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 7a5bebf5b096..7528bb7c06bb 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2170,6 +2170,8 @@ static int iscsi_iter_destroy_conn_fn(struct device *dev, void *data)
 		return 0;
 
 	iscsi_remove_conn(iscsi_dev_to_conn(dev));
+	iscsi_put_conn(iscsi_dev_to_conn(dev));
+
 	return 0;
 }
 
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 86dde3e7debb..e1b06f803a94 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4179,7 +4179,9 @@ static void sd_shutdown(struct device *dev)
 	if ((system_state != SYSTEM_RESTART &&
 	     sdkp->device->manage_system_start_stop) ||
 	    (system_state == SYSTEM_POWER_OFF &&
-	     sdkp->device->manage_shutdown)) {
+	     sdkp->device->manage_shutdown) ||
+	    (system_state == SYSTEM_RUNNING &&
+	     sdkp->device->manage_runtime_start_stop)) {
 		sd_printk(KERN_NOTICE, sdkp, "Stopping disk\n");
 		sd_start_stop_device(sdkp, 0);
 	}
diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index baa4ac6704a9..5963f49f6e6e 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -169,7 +169,10 @@ static int pmic_glink_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	return 0;
 }
 
-static void pmic_glink_aux_release(struct device *dev) {}
+static void pmic_glink_aux_release(struct device *dev)
+{
+	of_node_put(dev->of_node);
+}
 
 static int pmic_glink_add_aux_device(struct pmic_glink *pg,
 				     struct auxiliary_device *aux,
@@ -183,8 +186,10 @@ static int pmic_glink_add_aux_device(struct pmic_glink *pg,
 	aux->dev.release = pmic_glink_aux_release;
 	device_set_of_node_from_dev(&aux->dev, parent);
 	ret = auxiliary_device_init(aux);
-	if (ret)
+	if (ret) {
+		of_node_put(aux->dev.of_node);
 		return ret;
+	}
 
 	ret = auxiliary_device_add(aux);
 	if (ret)
diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index bb09eff85cff..dafe0a4c202e 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -304,6 +304,8 @@ static int qmi_encode(const struct qmi_elem_info *ei_array, void *out_buf,
 	const void *buf_src;
 	int encode_tlv = 0;
 	int rc;
+	u8 val8;
+	u16 val16;
 
 	if (!ei_array)
 		return 0;
@@ -338,7 +340,6 @@ static int qmi_encode(const struct qmi_elem_info *ei_array, void *out_buf,
 			break;
 
 		case QMI_DATA_LEN:
-			memcpy(&data_len_value, buf_src, temp_ei->elem_size);
 			data_len_sz = temp_ei->elem_size == sizeof(u8) ?
 					sizeof(u8) : sizeof(u16);
 			/* Check to avoid out of range buffer access */
@@ -348,8 +349,17 @@ static int qmi_encode(const struct qmi_elem_info *ei_array, void *out_buf,
 				       __func__);
 				return -ETOOSMALL;
 			}
-			rc = qmi_encode_basic_elem(buf_dst, &data_len_value,
-						   1, data_len_sz);
+			if (data_len_sz == sizeof(u8)) {
+				val8 = *(u8 *)buf_src;
+				data_len_value = (u32)val8;
+				rc = qmi_encode_basic_elem(buf_dst, &val8,
+							   1, data_len_sz);
+			} else {
+				val16 = *(u16 *)buf_src;
+				data_len_value = (u32)le16_to_cpu(val16);
+				rc = qmi_encode_basic_elem(buf_dst, &val16,
+							   1, data_len_sz);
+			}
 			UPDATE_ENCODE_VARIABLES(temp_ei, buf_dst,
 						encoded_bytes, tlv_len,
 						encode_tlv, rc);
@@ -523,14 +533,23 @@ static int qmi_decode_string_elem(const struct qmi_elem_info *ei_array,
 	u32 string_len = 0;
 	u32 string_len_sz = 0;
 	const struct qmi_elem_info *temp_ei = ei_array;
+	u8 val8;
+	u16 val16;
 
 	if (dec_level == 1) {
 		string_len = tlv_len;
 	} else {
 		string_len_sz = temp_ei->elem_len <= U8_MAX ?
 				sizeof(u8) : sizeof(u16);
-		rc = qmi_decode_basic_elem(&string_len, buf_src,
-					   1, string_len_sz);
+		if (string_len_sz == sizeof(u8)) {
+			rc = qmi_decode_basic_elem(&val8, buf_src,
+						   1, string_len_sz);
+			string_len = (u32)val8;
+		} else {
+			rc = qmi_decode_basic_elem(&val16, buf_src,
+						   1, string_len_sz);
+			string_len = (u32)val16;
+		}
 		decoded_bytes += rc;
 	}
 
@@ -604,6 +623,9 @@ static int qmi_decode(const struct qmi_elem_info *ei_array, void *out_c_struct,
 	u32 decoded_bytes = 0;
 	const void *buf_src = in_buf;
 	int rc;
+	u8 val8;
+	u16 val16;
+	u32 val32;
 
 	while (decoded_bytes < in_buf_len) {
 		if (dec_level >= 2 && temp_ei->data_type == QMI_EOTI)
@@ -642,9 +664,17 @@ static int qmi_decode(const struct qmi_elem_info *ei_array, void *out_c_struct,
 		if (temp_ei->data_type == QMI_DATA_LEN) {
 			data_len_sz = temp_ei->elem_size == sizeof(u8) ?
 					sizeof(u8) : sizeof(u16);
-			rc = qmi_decode_basic_elem(&data_len_value, buf_src,
-						   1, data_len_sz);
-			memcpy(buf_dst, &data_len_value, sizeof(u32));
+			if (data_len_sz == sizeof(u8)) {
+				rc = qmi_decode_basic_elem(&val8, buf_src,
+							   1, data_len_sz);
+				data_len_value = (u32)val8;
+			} else {
+				rc = qmi_decode_basic_elem(&val16, buf_src,
+							   1, data_len_sz);
+				data_len_value = (u32)val16;
+			}
+			val32 = cpu_to_le32(data_len_value);
+			memcpy(buf_dst, &val32, sizeof(u32));
 			temp_ei = temp_ei + 1;
 			buf_dst = out_c_struct + temp_ei->offset;
 			tlv_len -= data_len_sz;
diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index 5cf0e8c34164..e8cc46874c72 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -185,6 +185,8 @@ static void tegra234_cbb_error_clear(struct tegra_cbb *cbb)
 {
 	struct tegra234_cbb *priv = to_tegra234_cbb(cbb);
 
+	writel(0, priv->mon + FABRIC_MN_MASTER_ERR_FORCE_0);
+
 	writel(0x3f, priv->mon + FABRIC_MN_MASTER_ERR_STATUS_0);
 	dsb(sy);
 }
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 7aa4900dcf31..6c1e3aed8162 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1414,7 +1414,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 		if (ret < 0) {
 			dev_err(bus->dev, "Prepare port(s) failed ret = %d\n",
 				ret);
-			return ret;
+			goto restore_params;
 		}
 	}
 
diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 5b8ed65f8094..7a02fb42a88b 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -265,7 +265,7 @@ static struct spi_board_info *cs42l43_create_bridge_amp(struct cs42l43_spi *priv
 	struct spi_board_info *info;
 
 	if (spkid >= 0) {
-		props = devm_kmalloc(priv->dev, sizeof(*props), GFP_KERNEL);
+		props = devm_kcalloc(priv->dev, 2, sizeof(*props), GFP_KERNEL);
 		if (!props)
 			return NULL;
 
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index fc72a89fb3a7..3b1b810f33bf 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2069,9 +2069,15 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct reset_control *rst;
 	struct device_node *np = pdev->dev.of_node;
+	const struct stm32_spi_cfg *cfg;
 	bool device_mode;
 	int ret;
-	const struct stm32_spi_cfg *cfg = of_device_get_match_data(&pdev->dev);
+
+	cfg = of_device_get_match_data(&pdev->dev);
+	if (!cfg) {
+		dev_err(&pdev->dev, "Failed to get match data for platform\n");
+		return -ENODEV;
+	}
 
 	device_mode = of_property_read_bool(np, "spi-slave");
 	if (!cfg->has_device_mode && device_mode) {
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 4cfa494243b9..8fab5126765d 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -694,6 +694,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	return info;
 
 release_framebuf:
+	fb_deferred_io_cleanup(info);
 	framebuffer_release(info);
 
 alloc_fail:
diff --git a/drivers/staging/greybus/gbphy.c b/drivers/staging/greybus/gbphy.c
index 6adcad286633..60cf09a302a7 100644
--- a/drivers/staging/greybus/gbphy.c
+++ b/drivers/staging/greybus/gbphy.c
@@ -102,8 +102,8 @@ static int gbphy_dev_uevent(const struct device *dev, struct kobj_uevent_env *en
 }
 
 static const struct gbphy_device_id *
-gbphy_dev_match_id(struct gbphy_device *gbphy_dev,
-		   struct gbphy_driver *gbphy_drv)
+gbphy_dev_match_id(const struct gbphy_device *gbphy_dev,
+		   const struct gbphy_driver *gbphy_drv)
 {
 	const struct gbphy_device_id *id = gbphy_drv->id_table;
 
@@ -119,7 +119,7 @@ gbphy_dev_match_id(struct gbphy_device *gbphy_dev,
 
 static int gbphy_dev_match(struct device *dev, const struct device_driver *drv)
 {
-	struct gbphy_driver *gbphy_drv = to_gbphy_driver(drv);
+	const struct gbphy_driver *gbphy_drv = to_gbphy_driver(drv);
 	struct gbphy_device *gbphy_dev = to_gbphy_dev(dev);
 	const struct gbphy_device_id *id;
 
diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index e176483df301..b86494faa63a 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
@@ -1358,14 +1358,15 @@ static int gmin_get_config_var(struct device *maindev,
 	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
 		status = efi.get_variable(var16, &GMIN_CFG_VAR_EFI_GUID, NULL,
 					  (unsigned long *)out_len, out);
-	if (status == EFI_SUCCESS)
+	if (status == EFI_SUCCESS) {
 		dev_info(maindev, "found EFI entry for '%s'\n", var8);
-	else if (is_gmin)
+		return 0;
+	}
+	if (is_gmin)
 		dev_info(maindev, "Failed to find EFI gmin variable %s\n", var8);
 	else
 		dev_info(maindev, "Failed to find EFI variable %s\n", var8);
-
-	return ret;
+	return -ENOENT;
 }
 
 int gmin_get_var_int(struct device *dev, bool is_gmin, const char *var, int def)
diff --git a/drivers/staging/nvec/nvec_power.c b/drivers/staging/nvec/nvec_power.c
index 9943b1fff190..573521e1703b 100644
--- a/drivers/staging/nvec/nvec_power.c
+++ b/drivers/staging/nvec/nvec_power.c
@@ -194,7 +194,7 @@ static int nvec_power_bat_notifier(struct notifier_block *nb,
 		break;
 	case MANUFACTURER:
 		memcpy(power->bat_manu, &res->plc, res->length - 2);
-		power->bat_model[res->length - 2] = '\0';
+		power->bat_manu[res->length - 2] = '\0';
 		break;
 	case MODEL:
 		memcpy(power->bat_model, &res->plc, res->length - 2);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a6299cb19237..e079cb5d9ec6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4337,7 +4337,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 	hba->uic_async_done = NULL;
 	if (reenable_intr)
 		ufshcd_enable_intr(hba, UIC_COMMAND_COMPL);
-	if (ret) {
+	if (ret && !hba->pm_op_in_progress) {
 		ufshcd_set_link_broken(hba);
 		ufshcd_schedule_eh_work(hba);
 	}
@@ -4345,6 +4345,14 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	mutex_unlock(&hba->uic_cmd_mutex);
 
+	/*
+	 * If the h8 exit fails during the runtime resume process, it becomes
+	 * stuck and cannot be recovered through the error handler.  To fix
+	 * this, use link recovery instead of the error handler.
+	 */
+	if (ret && hba->pm_op_in_progress)
+		ret = ufshcd_link_recovery(hba);
+
 	return ret;
 }
 
diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index 341408410ed9..41118bba9197 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -681,6 +681,10 @@ int __init early_xdbc_setup_hardware(void)
 
 		xdbc.table_base = NULL;
 		xdbc.out_buf = NULL;
+
+		early_iounmap(xdbc.xhci_base, xdbc.xhci_length);
+		xdbc.xhci_base = NULL;
+		xdbc.xhci_length = 0;
 	}
 
 	return ret;
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 301a435b9ee3..460a102c1419 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2489,6 +2489,11 @@ int composite_os_desc_req_prepare(struct usb_composite_dev *cdev,
 	if (!cdev->os_desc_req->buf) {
 		ret = -ENOMEM;
 		usb_ep_free_request(ep0, cdev->os_desc_req);
+		/*
+		 * Set os_desc_req to NULL so that composite_dev_cleanup()
+		 * will not try to free it again.
+		 */
+		cdev->os_desc_req = NULL;
 		goto end;
 	}
 	cdev->os_desc_req->context = cdev;
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index d8bd2d82e9ec..ab4d170469f5 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1275,18 +1275,19 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 
 	if (!hidg->workqueue) {
 		status = -ENOMEM;
-		goto fail;
+		goto fail_free_descs;
 	}
 
 	/* create char device */
 	cdev_init(&hidg->cdev, &f_hidg_fops);
 	status = cdev_device_add(&hidg->cdev, &hidg->dev);
 	if (status)
-		goto fail_free_descs;
+		goto fail_free_all;
 
 	return 0;
-fail_free_descs:
+fail_free_all:
 	destroy_workqueue(hidg->workqueue);
+fail_free_descs:
 	usb_free_all_descriptors(f);
 fail:
 	ERROR(f->config->cdev, "hidg_bind FAILED\n");
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 3a9bdf916755..8cf278a40bd9 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -152,7 +152,7 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 	int			ret;
 	int			irq;
 	struct xhci_plat_priv	*priv = NULL;
-	bool			of_match;
+	const struct of_device_id *of_match;
 
 	if (usb_disabled())
 		return -ENODEV;
diff --git a/drivers/usb/misc/apple-mfi-fastcharge.c b/drivers/usb/misc/apple-mfi-fastcharge.c
index ac8695195c13..8e852f4b8262 100644
--- a/drivers/usb/misc/apple-mfi-fastcharge.c
+++ b/drivers/usb/misc/apple-mfi-fastcharge.c
@@ -44,6 +44,7 @@ MODULE_DEVICE_TABLE(usb, mfi_fc_id_table);
 struct mfi_device {
 	struct usb_device *udev;
 	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
 	int charge_type;
 };
 
@@ -178,6 +179,7 @@ static int mfi_fc_probe(struct usb_device *udev)
 {
 	struct power_supply_config battery_cfg = {};
 	struct mfi_device *mfi = NULL;
+	char *battery_name;
 	int err;
 
 	if (!mfi_fc_match(udev))
@@ -187,23 +189,38 @@ static int mfi_fc_probe(struct usb_device *udev)
 	if (!mfi)
 		return -ENOMEM;
 
+	battery_name = kasprintf(GFP_KERNEL, "apple_mfi_fastcharge_%d-%d",
+				 udev->bus->busnum, udev->devnum);
+	if (!battery_name) {
+		err = -ENOMEM;
+		goto err_free_mfi;
+	}
+
+	mfi->battery_desc = apple_mfi_fc_desc;
+	mfi->battery_desc.name = battery_name;
+
 	battery_cfg.drv_data = mfi;
 
 	mfi->charge_type = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
 	mfi->battery = power_supply_register(&udev->dev,
-						&apple_mfi_fc_desc,
+						&mfi->battery_desc,
 						&battery_cfg);
 	if (IS_ERR(mfi->battery)) {
 		dev_err(&udev->dev, "Can't register battery\n");
 		err = PTR_ERR(mfi->battery);
-		kfree(mfi);
-		return err;
+		goto err_free_name;
 	}
 
 	mfi->udev = usb_get_dev(udev);
 	dev_set_drvdata(&udev->dev, mfi);
 
 	return 0;
+
+err_free_name:
+	kfree(battery_name);
+err_free_mfi:
+	kfree(mfi);
+	return err;
 }
 
 static void mfi_fc_disconnect(struct usb_device *udev)
@@ -213,6 +230,7 @@ static void mfi_fc_disconnect(struct usb_device *udev)
 	mfi = dev_get_drvdata(&udev->dev);
 	if (mfi->battery)
 		power_supply_unregister(mfi->battery);
+	kfree(mfi->battery_desc.name);
 	dev_set_drvdata(&udev->dev, NULL);
 	usb_put_dev(mfi->udev);
 	kfree(mfi);
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 147ca50c94be..e5cd33093423 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2346,6 +2346,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe145, 0xff),			/* Foxconn T99W651 RNDIS */
 	  .driver_info = RSVD(5) | RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe15f, 0xff),                     /* Foxconn T99W709 */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe167, 0xff),                     /* Foxconn T99W640 MBIM */
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
index 40e5da4fd2a4..080b6369a88c 100644
--- a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
+++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
@@ -133,17 +133,30 @@ static int yoga_c630_ucsi_probe(struct auxiliary_device *adev,
 
 	ret = yoga_c630_ec_register_notify(ec, &uec->nb);
 	if (ret)
-		return ret;
+		goto err_destroy;
+
+	ret = ucsi_register(uec->ucsi);
+	if (ret)
+		goto err_unregister;
+
+	return 0;
 
-	return ucsi_register(uec->ucsi);
+err_unregister:
+	yoga_c630_ec_unregister_notify(uec->ec, &uec->nb);
+
+err_destroy:
+	ucsi_destroy(uec->ucsi);
+
+	return ret;
 }
 
 static void yoga_c630_ucsi_remove(struct auxiliary_device *adev)
 {
 	struct yoga_c630_ucsi *uec = auxiliary_get_drvdata(adev);
 
-	yoga_c630_ec_unregister_notify(uec->ec, &uec->nb);
 	ucsi_unregister(uec->ucsi);
+	yoga_c630_ec_unregister_notify(uec->ec, &uec->nb);
+	ucsi_destroy(uec->ucsi);
 }
 
 static const struct auxiliary_device_id yoga_c630_ucsi_id_table[] = {
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 61424342c096..c7a20278bc3c 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -908,6 +908,9 @@ void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
 {
 	struct mlx5_vdpa_mr_resources *mres = &mvdev->mres;
 
+	if (!mres->wq_gc)
+		return;
+
 	atomic_set(&mres->shutdown, 1);
 
 	flush_delayed_work(&mres->gc_dwork_ent);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 76aedac37a78..2e0b8c5bec8d 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2491,7 +2491,7 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
         }
 
 	mvq = &ndev->vqs[idx];
-	ndev->needs_teardown = num != mvq->num_ent;
+	ndev->needs_teardown |= num != mvq->num_ent;
 	mvq->num_ent = num;
 }
 
@@ -3432,15 +3432,17 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
 
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 
+	/* Functions called here should be able to work with
+	 * uninitialized resources.
+	 */
 	free_fixed_resources(ndev);
 	mlx5_vdpa_clean_mrs(mvdev);
 	mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
-	mlx5_cmd_cleanup_async_ctx(&mvdev->async_ctx);
-
 	if (!is_zero_ether_addr(ndev->config.mac)) {
 		pfmdev = pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
 		mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
 	}
+	mlx5_cmd_cleanup_async_ctx(&mvdev->async_ctx);
 	mlx5_vdpa_free_resources(&ndev->mvdev);
 	free_irqs(ndev);
 	kfree(ndev->event_cbs);
@@ -3888,6 +3890,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	mvdev->actual_features =
 			(device_features & BIT_ULL(VIRTIO_F_VERSION_1));
 
+	mlx5_cmd_init_async_ctx(mdev, &mvdev->async_ctx);
+
 	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
 	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
 	if (!ndev->vqs || !ndev->event_cbs) {
@@ -3960,8 +3964,6 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		ndev->rqt_size = 1;
 	}
 
-	mlx5_cmd_init_async_ctx(mdev, &mvdev->async_ctx);
-
 	ndev->mvdev.mlx_features = device_features;
 	mvdev->vdev.dma_dev = &mdev->pdev->dev;
 	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 7ae99691efdf..7f569ce8fc7b 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2215,6 +2215,7 @@ static void vduse_exit(void)
 	cdev_del(&vduse_ctrl_cdev);
 	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
 	class_unregister(&vduse_class);
+	idr_destroy(&vduse_idr);
 }
 module_exit(vduse_exit);
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 95b336de8a17..5f2b2c950bbc 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -194,11 +194,10 @@ static int vfio_df_group_open(struct vfio_device_file *df)
 		 * implies they expected translation to exist
 		 */
 		if (!capable(CAP_SYS_RAWIO) ||
-		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd))
+		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd)) {
 			ret = -EPERM;
-		else
-			ret = 0;
-		goto out_put_kvm;
+			goto out_put_kvm;
+		}
 	}
 
 	ret = vfio_df_open(df);
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index 82eba6966fa5..02852899c2ae 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -25,6 +25,10 @@ int vfio_df_iommufd_bind(struct vfio_device_file *df)
 
 	lockdep_assert_held(&vdev->dev_set->lock);
 
+	/* Returns 0 to permit device opening under noiommu mode */
+	if (vfio_device_is_noiommu(vdev))
+		return 0;
+
 	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
 }
 
diff --git a/drivers/vfio/pci/pds/vfio_dev.c b/drivers/vfio/pci/pds/vfio_dev.c
index 76a80ae7087b..f6e0253a8a14 100644
--- a/drivers/vfio/pci/pds/vfio_dev.c
+++ b/drivers/vfio/pci/pds/vfio_dev.c
@@ -204,6 +204,7 @@ static const struct vfio_device_ops pds_vfio_ops = {
 	.bind_iommufd = vfio_iommufd_physical_bind,
 	.unbind_iommufd = vfio_iommufd_physical_unbind,
 	.attach_ioas = vfio_iommufd_physical_attach_ioas,
+	.detach_ioas = vfio_iommufd_physical_detach_ioas,
 };
 
 const struct vfio_device_ops *pds_vfio_ops_info(void)
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 087c273a547f..595503fa9ca8 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2153,7 +2153,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 		return -EBUSY;
 	}
 
-	if (pci_is_root_bus(pdev->bus)) {
+	if (pci_is_root_bus(pdev->bus) || pdev->is_virtfn) {
 		ret = vfio_assign_device_set(&vdev->vdev, vdev);
 	} else if (!pci_probe_reset_slot(pdev->slot)) {
 		ret = vfio_assign_device_set(&vdev->vdev, pdev->slot);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index a5a62d9d963f..ae78822f2d71 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -583,7 +583,8 @@ void vfio_df_close(struct vfio_device_file *df)
 
 	lockdep_assert_held(&device->dev_set->lock);
 
-	vfio_assert_device_open(device);
+	if (!vfio_assert_device_open(device))
+		return;
 	if (device->open_count == 1)
 		vfio_df_device_last_close(df);
 	device->open_count--;
diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index b455d9ab6f3d..a4730217bfb6 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -94,4 +94,22 @@ config VHOST_CROSS_ENDIAN_LEGACY
 
 	  If unsure, say "N".
 
+config VHOST_ENABLE_FORK_OWNER_CONTROL
+	bool "Enable VHOST_ENABLE_FORK_OWNER_CONTROL"
+	default y
+	help
+	  This option enables two IOCTLs: VHOST_SET_FORK_FROM_OWNER and
+	  VHOST_GET_FORK_FROM_OWNER. These allow userspace applications
+	  to modify the vhost worker mode for vhost devices.
+
+	  Also expose module parameter 'fork_from_owner_default' to allow users
+	  to configure the default mode for vhost workers.
+
+	  By default, `VHOST_ENABLE_FORK_OWNER_CONTROL` is set to `y`,
+	  users can change the worker thread mode as needed.
+	  If this config is disabled (n),the related IOCTLs and parameters will
+	  be unavailable.
+
+	  If unsure, say "Y".
+
 endif
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 38d243d914d0..88f213d1106f 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1088,10 +1088,8 @@ vhost_scsi_get_req(struct vhost_virtqueue *vq, struct vhost_scsi_ctx *vc,
 			/* validated at handler entry */
 			vs_tpg = vhost_vq_get_backend(vq);
 			tpg = READ_ONCE(vs_tpg[*vc->target]);
-			if (unlikely(!tpg)) {
-				vq_err(vq, "Target 0x%x does not exist\n", *vc->target);
+			if (unlikely(!tpg))
 				goto out;
-			}
 		}
 
 		if (tpgp)
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 63612faeab72..79b0b7cd2860 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/kthread.h>
+#include <linux/cgroup.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <linux/sched/mm.h>
@@ -41,6 +42,13 @@ static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
+static bool fork_from_owner_default = VHOST_FORK_OWNER_TASK;
+
+#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
+module_param(fork_from_owner_default, bool, 0444);
+MODULE_PARM_DESC(fork_from_owner_default,
+		 "Set task mode as the default(default: Y)");
+#endif
 
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
@@ -242,7 +250,7 @@ static void vhost_worker_queue(struct vhost_worker *worker,
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &worker->work_list);
-		vhost_task_wake(worker->vtsk);
+		worker->ops->wakeup(worker);
 	}
 }
 
@@ -388,6 +396,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	__vhost_vq_meta_reset(vq);
 }
 
+static int vhost_run_work_kthread_list(void *data)
+{
+	struct vhost_worker *worker = data;
+	struct vhost_work *work, *work_next;
+	struct vhost_dev *dev = worker->dev;
+	struct llist_node *node;
+
+	kthread_use_mm(dev->mm);
+
+	for (;;) {
+		/* mb paired w/ kthread_stop */
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (kthread_should_stop()) {
+			__set_current_state(TASK_RUNNING);
+			break;
+		}
+		node = llist_del_all(&worker->work_list);
+		if (!node)
+			schedule();
+
+		node = llist_reverse_order(node);
+		/* make sure flag is seen after deletion */
+		smp_wmb();
+		llist_for_each_entry_safe(work, work_next, node, node) {
+			clear_bit(VHOST_WORK_QUEUED, &work->flags);
+			__set_current_state(TASK_RUNNING);
+			kcov_remote_start_common(worker->kcov_handle);
+			work->fn(work);
+			kcov_remote_stop();
+			cond_resched();
+		}
+	}
+	kthread_unuse_mm(dev->mm);
+
+	return 0;
+}
+
 static bool vhost_run_work_list(void *data)
 {
 	struct vhost_worker *worker = data;
@@ -552,6 +598,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
+	dev->fork_owner = fork_from_owner_default;
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
@@ -581,6 +628,46 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
 
+struct vhost_attach_cgroups_struct {
+	struct vhost_work work;
+	struct task_struct *owner;
+	int ret;
+};
+
+static void vhost_attach_cgroups_work(struct vhost_work *work)
+{
+	struct vhost_attach_cgroups_struct *s;
+
+	s = container_of(work, struct vhost_attach_cgroups_struct, work);
+	s->ret = cgroup_attach_task_all(s->owner, current);
+}
+
+static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
+{
+	struct vhost_attach_cgroups_struct attach;
+	int saved_cnt;
+
+	attach.owner = current;
+
+	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
+	vhost_worker_queue(worker, &attach.work);
+
+	mutex_lock(&worker->mutex);
+
+	/*
+	 * Bypass attachment_cnt check in __vhost_worker_flush:
+	 * Temporarily change it to INT_MAX to bypass the check
+	 */
+	saved_cnt = worker->attachment_cnt;
+	worker->attachment_cnt = INT_MAX;
+	__vhost_worker_flush(worker);
+	worker->attachment_cnt = saved_cnt;
+
+	mutex_unlock(&worker->mutex);
+
+	return attach.ret;
+}
+
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
@@ -626,7 +713,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
 
 	WARN_ON(!llist_empty(&worker->work_list));
 	xa_erase(&dev->worker_xa, worker->id);
-	vhost_task_stop(worker->vtsk);
+	worker->ops->stop(worker);
 	kfree(worker);
 }
 
@@ -649,42 +736,115 @@ static void vhost_workers_free(struct vhost_dev *dev)
 	xa_destroy(&dev->worker_xa);
 }
 
+static void vhost_task_wakeup(struct vhost_worker *worker)
+{
+	return vhost_task_wake(worker->vtsk);
+}
+
+static void vhost_kthread_wakeup(struct vhost_worker *worker)
+{
+	wake_up_process(worker->kthread_task);
+}
+
+static void vhost_task_do_stop(struct vhost_worker *worker)
+{
+	return vhost_task_stop(worker->vtsk);
+}
+
+static void vhost_kthread_do_stop(struct vhost_worker *worker)
+{
+	kthread_stop(worker->kthread_task);
+}
+
+static int vhost_task_worker_create(struct vhost_worker *worker,
+				    struct vhost_dev *dev, const char *name)
+{
+	struct vhost_task *vtsk;
+	u32 id;
+	int ret;
+
+	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
+				 worker, name);
+	if (IS_ERR(vtsk))
+		return PTR_ERR(vtsk);
+
+	worker->vtsk = vtsk;
+	vhost_task_start(vtsk);
+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0) {
+		vhost_task_do_stop(worker);
+		return ret;
+	}
+	worker->id = id;
+	return 0;
+}
+
+static int vhost_kthread_worker_create(struct vhost_worker *worker,
+				       struct vhost_dev *dev, const char *name)
+{
+	struct task_struct *task;
+	u32 id;
+	int ret;
+
+	task = kthread_create(vhost_run_work_kthread_list, worker, "%s", name);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	worker->kthread_task = task;
+	wake_up_process(task);
+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0)
+		goto stop_worker;
+
+	ret = vhost_attach_task_to_cgroups(worker);
+	if (ret)
+		goto stop_worker;
+
+	worker->id = id;
+	return 0;
+
+stop_worker:
+	vhost_kthread_do_stop(worker);
+	return ret;
+}
+
+static const struct vhost_worker_ops kthread_ops = {
+	.create = vhost_kthread_worker_create,
+	.stop = vhost_kthread_do_stop,
+	.wakeup = vhost_kthread_wakeup,
+};
+
+static const struct vhost_worker_ops vhost_task_ops = {
+	.create = vhost_task_worker_create,
+	.stop = vhost_task_do_stop,
+	.wakeup = vhost_task_wakeup,
+};
+
 static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
-	struct vhost_task *vtsk;
 	char name[TASK_COMM_LEN];
 	int ret;
-	u32 id;
+	const struct vhost_worker_ops *ops = dev->fork_owner ? &vhost_task_ops :
+							       &kthread_ops;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
 	if (!worker)
 		return NULL;
 
 	worker->dev = dev;
+	worker->ops = ops;
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
 
-	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
-				 worker, name);
-	if (IS_ERR(vtsk))
-		goto free_worker;
-
 	mutex_init(&worker->mutex);
 	init_llist_head(&worker->work_list);
 	worker->kcov_handle = kcov_common_handle();
-	worker->vtsk = vtsk;
-
-	vhost_task_start(vtsk);
-
-	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	ret = ops->create(worker, dev, name);
 	if (ret < 0)
-		goto stop_worker;
-	worker->id = id;
+		goto free_worker;
 
 	return worker;
 
-stop_worker:
-	vhost_task_stop(vtsk);
 free_worker:
 	kfree(worker);
 	return NULL;
@@ -865,6 +1025,14 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 	switch (ioctl) {
 	/* dev worker ioctls */
 	case VHOST_NEW_WORKER:
+		/*
+		 * vhost_tasks will account for worker threads under the parent's
+		 * NPROC value but kthreads do not. To avoid userspace overflowing
+		 * the system with worker threads fork_owner must be true.
+		 */
+		if (!dev->fork_owner)
+			return -EFAULT;
+
 		ret = vhost_new_worker(dev, &state);
 		if (!ret && copy_to_user(argp, &state, sizeof(state)))
 			ret = -EFAULT;
@@ -982,6 +1150,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
 
 	vhost_dev_cleanup(dev);
 
+	dev->fork_owner = fork_from_owner_default;
 	dev->umem = umem;
 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
 	 * VQs aren't running.
@@ -2135,6 +2304,45 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		goto done;
 	}
 
+#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
+	if (ioctl == VHOST_SET_FORK_FROM_OWNER) {
+		/* Only allow modification before owner is set */
+		if (vhost_dev_has_owner(d)) {
+			r = -EBUSY;
+			goto done;
+		}
+		u8 fork_owner_val;
+
+		if (get_user(fork_owner_val, (u8 __user *)argp)) {
+			r = -EFAULT;
+			goto done;
+		}
+		if (fork_owner_val != VHOST_FORK_OWNER_TASK &&
+		    fork_owner_val != VHOST_FORK_OWNER_KTHREAD) {
+			r = -EINVAL;
+			goto done;
+		}
+		d->fork_owner = !!fork_owner_val;
+		r = 0;
+		goto done;
+	}
+	if (ioctl == VHOST_GET_FORK_FROM_OWNER) {
+		u8 fork_owner_val = d->fork_owner;
+
+		if (fork_owner_val != VHOST_FORK_OWNER_TASK &&
+		    fork_owner_val != VHOST_FORK_OWNER_KTHREAD) {
+			r = -EINVAL;
+			goto done;
+		}
+		if (put_user(fork_owner_val, (u8 __user *)argp)) {
+			r = -EFAULT;
+			goto done;
+		}
+		r = 0;
+		goto done;
+	}
+#endif
+
 	/* You must be the owner to do anything else */
 	r = vhost_dev_check_owner(d);
 	if (r)
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb75a292d50c..ab704d84fb34 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -26,7 +26,18 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+struct vhost_worker;
+struct vhost_dev;
+
+struct vhost_worker_ops {
+	int (*create)(struct vhost_worker *worker, struct vhost_dev *dev,
+		      const char *name);
+	void (*stop)(struct vhost_worker *worker);
+	void (*wakeup)(struct vhost_worker *worker);
+};
+
 struct vhost_worker {
+	struct task_struct *kthread_task;
 	struct vhost_task	*vtsk;
 	struct vhost_dev	*dev;
 	/* Used to serialize device wide flushing with worker swapping. */
@@ -36,6 +47,7 @@ struct vhost_worker {
 	u32			id;
 	int			attachment_cnt;
 	bool			killed;
+	const struct vhost_worker_ops *ops;
 };
 
 /* Poll a file (eventfd or socket) */
@@ -176,6 +188,16 @@ struct vhost_dev {
 	int byte_weight;
 	struct xarray worker_xa;
 	bool use_worker;
+	/*
+	 * If fork_owner is true we use vhost_tasks to create
+	 * the worker so all settings/limits like cgroups, NPROC,
+	 * scheduler, etc are inherited from the owner. If false,
+	 * we use kthreads and only attach to the same cgroups
+	 * as the owner for compat with older kernels.
+	 * here we use true as default value.
+	 * The default value is set by fork_from_owner_default
+	 */
+	bool fork_owner;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
 };
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c98786996c64..678d2802760c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -953,13 +953,13 @@ static const char *fbcon_startup(void)
 	int rows, cols;
 
 	/*
-	 *  If num_registered_fb is zero, this is a call for the dummy part.
+	 *  If fbcon_num_registered_fb is zero, this is a call for the dummy part.
 	 *  The frame buffer devices weren't initialized yet.
 	 */
 	if (!fbcon_num_registered_fb || info_idx == -1)
 		return display_desc;
 	/*
-	 * Instead of blindly using registered_fb[0], we use info_idx, set by
+	 * Instead of blindly using fbcon_registered_fb[0], we use info_idx, set by
 	 * fbcon_fb_registered();
 	 */
 	info = fbcon_registered_fb[info_idx];
diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index ff343e4ed35b..c0bdfb10f681 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -1007,8 +1007,13 @@ static int imxfb_probe(struct platform_device *pdev)
 	info->fix.smem_start = fbi->map_dma;
 
 	INIT_LIST_HEAD(&info->modelist);
-	for (i = 0; i < fbi->num_modes; i++)
-		fb_add_videomode(&fbi->mode[i].mode, &info->modelist);
+	for (i = 0; i < fbi->num_modes; i++) {
+		ret = fb_add_videomode(&fbi->mode[i].mode, &info->modelist);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to add videomode\n");
+			goto failed_cmap;
+		}
+	}
 
 	/*
 	 * This makes sure that our colour bitfield
diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index 775838346bb5..09d6721c7bfa 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -302,6 +302,9 @@ static int ziirave_firm_verify(struct watchdog_device *wdd,
 		const u16 len = be16_to_cpu(rec->len);
 		const u32 addr = be32_to_cpu(rec->addr);
 
+		if (len > sizeof(data))
+			return -EINVAL;
+
 		if (ziirave_firm_addr_readonly(addr))
 			continue;
 
diff --git a/drivers/xen/gntdev-common.h b/drivers/xen/gntdev-common.h
index 9c286b2a1900..ac8ce3179ba2 100644
--- a/drivers/xen/gntdev-common.h
+++ b/drivers/xen/gntdev-common.h
@@ -26,6 +26,10 @@ struct gntdev_priv {
 	/* lock protects maps and freeable_maps. */
 	struct mutex lock;
 
+	/* Free instances of struct gntdev_copy_batch. */
+	struct gntdev_copy_batch *batch;
+	struct mutex batch_lock;
+
 #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
 	/* Device for which DMA memory is allocated. */
 	struct device *dma_dev;
diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 42adc2c1e06b..5ab973627d18 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -357,8 +357,11 @@ struct gntdev_dmabuf_export_args {
 static int dmabuf_exp_from_pages(struct gntdev_dmabuf_export_args *args)
 {
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
-	struct gntdev_dmabuf *gntdev_dmabuf;
-	int ret;
+	struct gntdev_dmabuf *gntdev_dmabuf __free(kfree) = NULL;
+	CLASS(get_unused_fd, ret)(O_CLOEXEC);
+
+	if (ret < 0)
+		return ret;
 
 	gntdev_dmabuf = kzalloc(sizeof(*gntdev_dmabuf), GFP_KERNEL);
 	if (!gntdev_dmabuf)
@@ -383,32 +386,21 @@ static int dmabuf_exp_from_pages(struct gntdev_dmabuf_export_args *args)
 	exp_info.priv = gntdev_dmabuf;
 
 	gntdev_dmabuf->dmabuf = dma_buf_export(&exp_info);
-	if (IS_ERR(gntdev_dmabuf->dmabuf)) {
-		ret = PTR_ERR(gntdev_dmabuf->dmabuf);
-		gntdev_dmabuf->dmabuf = NULL;
-		goto fail;
-	}
-
-	ret = dma_buf_fd(gntdev_dmabuf->dmabuf, O_CLOEXEC);
-	if (ret < 0)
-		goto fail;
+	if (IS_ERR(gntdev_dmabuf->dmabuf))
+		return PTR_ERR(gntdev_dmabuf->dmabuf);
 
 	gntdev_dmabuf->fd = ret;
 	args->fd = ret;
 
 	pr_debug("Exporting DMA buffer with fd %d\n", ret);
 
+	get_file(gntdev_dmabuf->priv->filp);
 	mutex_lock(&args->dmabuf_priv->lock);
 	list_add(&gntdev_dmabuf->next, &args->dmabuf_priv->exp_list);
 	mutex_unlock(&args->dmabuf_priv->lock);
-	get_file(gntdev_dmabuf->priv->filp);
-	return 0;
 
-fail:
-	if (gntdev_dmabuf->dmabuf)
-		dma_buf_put(gntdev_dmabuf->dmabuf);
-	kfree(gntdev_dmabuf);
-	return ret;
+	fd_install(take_fd(ret), no_free_ptr(gntdev_dmabuf)->dmabuf->file);
+	return 0;
 }
 
 static struct gntdev_grant_map *
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 61faea1f0663..1f2160765618 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -56,6 +56,18 @@ MODULE_AUTHOR("Derek G. Murray <Derek.Murray@cl.cam.ac.uk>, "
 	      "Gerd Hoffmann <kraxel@redhat.com>");
 MODULE_DESCRIPTION("User-space granted page access driver");
 
+#define GNTDEV_COPY_BATCH 16
+
+struct gntdev_copy_batch {
+	struct gnttab_copy ops[GNTDEV_COPY_BATCH];
+	struct page *pages[GNTDEV_COPY_BATCH];
+	s16 __user *status[GNTDEV_COPY_BATCH];
+	unsigned int nr_ops;
+	unsigned int nr_pages;
+	bool writeable;
+	struct gntdev_copy_batch *next;
+};
+
 static unsigned int limit = 64*1024;
 module_param(limit, uint, 0644);
 MODULE_PARM_DESC(limit,
@@ -584,6 +596,8 @@ static int gntdev_open(struct inode *inode, struct file *flip)
 	INIT_LIST_HEAD(&priv->maps);
 	mutex_init(&priv->lock);
 
+	mutex_init(&priv->batch_lock);
+
 #ifdef CONFIG_XEN_GNTDEV_DMABUF
 	priv->dmabuf_priv = gntdev_dmabuf_init(flip);
 	if (IS_ERR(priv->dmabuf_priv)) {
@@ -608,6 +622,7 @@ static int gntdev_release(struct inode *inode, struct file *flip)
 {
 	struct gntdev_priv *priv = flip->private_data;
 	struct gntdev_grant_map *map;
+	struct gntdev_copy_batch *batch;
 
 	pr_debug("priv %p\n", priv);
 
@@ -620,6 +635,14 @@ static int gntdev_release(struct inode *inode, struct file *flip)
 	}
 	mutex_unlock(&priv->lock);
 
+	mutex_lock(&priv->batch_lock);
+	while (priv->batch) {
+		batch = priv->batch;
+		priv->batch = batch->next;
+		kfree(batch);
+	}
+	mutex_unlock(&priv->batch_lock);
+
 #ifdef CONFIG_XEN_GNTDEV_DMABUF
 	gntdev_dmabuf_fini(priv->dmabuf_priv);
 #endif
@@ -785,17 +808,6 @@ static long gntdev_ioctl_notify(struct gntdev_priv *priv, void __user *u)
 	return rc;
 }
 
-#define GNTDEV_COPY_BATCH 16
-
-struct gntdev_copy_batch {
-	struct gnttab_copy ops[GNTDEV_COPY_BATCH];
-	struct page *pages[GNTDEV_COPY_BATCH];
-	s16 __user *status[GNTDEV_COPY_BATCH];
-	unsigned int nr_ops;
-	unsigned int nr_pages;
-	bool writeable;
-};
-
 static int gntdev_get_page(struct gntdev_copy_batch *batch, void __user *virt,
 				unsigned long *gfn)
 {
@@ -953,36 +965,53 @@ static int gntdev_grant_copy_seg(struct gntdev_copy_batch *batch,
 static long gntdev_ioctl_grant_copy(struct gntdev_priv *priv, void __user *u)
 {
 	struct ioctl_gntdev_grant_copy copy;
-	struct gntdev_copy_batch batch;
+	struct gntdev_copy_batch *batch;
 	unsigned int i;
 	int ret = 0;
 
 	if (copy_from_user(&copy, u, sizeof(copy)))
 		return -EFAULT;
 
-	batch.nr_ops = 0;
-	batch.nr_pages = 0;
+	mutex_lock(&priv->batch_lock);
+	if (!priv->batch) {
+		batch = kmalloc(sizeof(*batch), GFP_KERNEL);
+	} else {
+		batch = priv->batch;
+		priv->batch = batch->next;
+	}
+	mutex_unlock(&priv->batch_lock);
+	if (!batch)
+		return -ENOMEM;
+
+	batch->nr_ops = 0;
+	batch->nr_pages = 0;
 
 	for (i = 0; i < copy.count; i++) {
 		struct gntdev_grant_copy_segment seg;
 
 		if (copy_from_user(&seg, &copy.segments[i], sizeof(seg))) {
 			ret = -EFAULT;
+			gntdev_put_pages(batch);
 			goto out;
 		}
 
-		ret = gntdev_grant_copy_seg(&batch, &seg, &copy.segments[i].status);
-		if (ret < 0)
+		ret = gntdev_grant_copy_seg(batch, &seg, &copy.segments[i].status);
+		if (ret < 0) {
+			gntdev_put_pages(batch);
 			goto out;
+		}
 
 		cond_resched();
 	}
-	if (batch.nr_ops)
-		ret = gntdev_copy(&batch);
-	return ret;
+	if (batch->nr_ops)
+		ret = gntdev_copy(batch);
+
+ out:
+	mutex_lock(&priv->batch_lock);
+	batch->next = priv->batch;
+	priv->batch = batch;
+	mutex_unlock(&priv->batch_lock);
 
-  out:
-	gntdev_put_pages(&batch);
 	return ret;
 }
 
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 3b3c4d8d401e..9c7062245880 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -215,35 +215,31 @@ static struct inode *parse_longname(const struct inode *parent,
 	struct ceph_client *cl = ceph_inode_to_client(parent);
 	struct inode *dir = NULL;
 	struct ceph_vino vino = { .snap = CEPH_NOSNAP };
-	char *inode_number;
-	char *name_end;
-	int orig_len = *name_len;
+	char *name_end, *inode_number;
 	int ret = -EIO;
-
+	/* NUL-terminate */
+	char *str __free(kfree) = kmemdup_nul(name, *name_len, GFP_KERNEL);
+	if (!str)
+		return ERR_PTR(-ENOMEM);
 	/* Skip initial '_' */
-	name++;
-	name_end = strrchr(name, '_');
+	str++;
+	name_end = strrchr(str, '_');
 	if (!name_end) {
-		doutc(cl, "failed to parse long snapshot name: %s\n", name);
+		doutc(cl, "failed to parse long snapshot name: %s\n", str);
 		return ERR_PTR(-EIO);
 	}
-	*name_len = (name_end - name);
+	*name_len = (name_end - str);
 	if (*name_len <= 0) {
 		pr_err_client(cl, "failed to parse long snapshot name\n");
 		return ERR_PTR(-EIO);
 	}
 
 	/* Get the inode number */
-	inode_number = kmemdup_nul(name_end + 1,
-				   orig_len - *name_len - 2,
-				   GFP_KERNEL);
-	if (!inode_number)
-		return ERR_PTR(-ENOMEM);
+	inode_number = name_end + 1;
 	ret = kstrtou64(inode_number, 10, &vino.ino);
 	if (ret) {
-		doutc(cl, "failed to parse inode number: %s\n", name);
-		dir = ERR_PTR(ret);
-		goto out;
+		doutc(cl, "failed to parse inode number: %s\n", str);
+		return ERR_PTR(ret);
 	}
 
 	/* And finally the inode */
@@ -254,9 +250,6 @@ static struct inode *parse_longname(const struct inode *parent,
 		if (IS_ERR(dir))
 			doutc(cl, "can't find inode %s (%s)\n", inode_number, name);
 	}
-
-out:
-	kfree(inode_number);
 	return dir;
 }
 
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 841a5b18e3df..7ac5126aa4f1 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -623,9 +623,8 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (pos > valid_size)
 		pos = valid_size;
 
-	if (iocb_is_dsync(iocb) && iocb->ki_pos > pos) {
-		ssize_t err = vfs_fsync_range(file, pos, iocb->ki_pos - 1,
-				iocb->ki_flags & IOCB_SYNC);
+	if (iocb->ki_pos > pos) {
+		ssize_t err = generic_write_sync(iocb, iocb->ki_pos - pos);
 		if (err < 0)
 			return err;
 	}
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 05b148d6fc71..e02a3141637a 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -606,6 +606,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	} else
 		ret = ext4_block_write_begin(handle, folio, from, to,
 					     ext4_get_block);
+	clear_buffer_new(folio_buffers(folio));
 
 	if (!ret && ext4_should_journal_data(inode)) {
 		ret = ext4_walk_page_buffers(handle, inode,
@@ -867,6 +868,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 		return ret;
 	}
 
+	clear_buffer_new(folio_buffers(folio));
 	folio_mark_dirty(folio);
 	folio_mark_uptodate(folio);
 	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index eb092133c6b8..232131804bb8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1056,7 +1056,7 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 			}
 			continue;
 		}
-		if (buffer_new(bh))
+		if (WARN_ON_ONCE(buffer_new(bh)))
 			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
 			WARN_ON(bh->b_size != blocksize);
@@ -1272,6 +1272,7 @@ static int write_end_fn(handle_t *handle, struct inode *inode,
 	ret = ext4_dirty_journalled_data(handle, bh);
 	clear_buffer_meta(bh);
 	clear_buffer_prio(bh);
+	clear_buffer_new(bh);
 	return ret;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 654f672639b3..efc30626760a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -287,7 +287,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(bio_first_page_all(bio));
 	struct bio_post_read_ctx *ctx;
-	bool intask = in_task();
+	bool intask = in_task() && !irqs_disabled();
 
 	iostat_update_and_unbind_ctx(bio);
 	ctx = bio->bi_private;
@@ -1573,8 +1573,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	end = pgofs + maxblocks;
 
 next_dnode:
-	if (map->m_may_create)
+	if (map->m_may_create) {
+		if (f2fs_lfs_mode(sbi))
+			f2fs_balance_fs(sbi, true);
 		f2fs_map_lock(sbi, flag);
+	}
 
 	/* When reading holes, we need its node page */
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index fb09c8e9bc57..2ccc86875099 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -381,7 +381,7 @@ void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
 	struct f2fs_extent *i_ext = &F2FS_INODE(ipage)->i_ext;
 	struct extent_tree *et;
 	struct extent_node *en;
-	struct extent_info ei;
+	struct extent_info ei = {0};
 
 	if (!__may_extent_tree(inode, EX_READ)) {
 		/* drop largest read extent */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a435550b2839..2dec22f2ea63 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1260,7 +1260,7 @@ struct f2fs_bio_info {
 struct f2fs_dev_info {
 	struct file *bdev_file;
 	struct block_device *bdev;
-	char path[MAX_PATH_LEN];
+	char path[MAX_PATH_LEN + 1];
 	unsigned int total_segments;
 	block_t start_blk;
 	block_t end_blk;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index cd56c0e66657..c0e43d6056a0 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1899,6 +1899,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	/* Let's run FG_GC, if we don't have enough space. */
 	if (has_not_enough_free_secs(sbi, 0, 0)) {
 		gc_type = FG_GC;
+		gc_control->one_time = false;
 
 		/*
 		 * For example, if there are many prefree_segments below given
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 06688b9957c8..41ead6c772e4 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -902,6 +902,19 @@ void f2fs_evict_inode(struct inode *inode)
 		f2fs_update_inode_page(inode);
 		if (dquot_initialize_needed(inode))
 			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+
+		/*
+		 * If both f2fs_truncate() and f2fs_update_inode_page() failed
+		 * due to fuzzed corrupted inode, call f2fs_inode_synced() to
+		 * avoid triggering later f2fs_bug_on().
+		 */
+		if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
+			f2fs_warn(sbi,
+				"f2fs_evict_inode: inode is dirty, ino:%lu",
+				inode->i_ino);
+			f2fs_inode_synced(inode);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+		}
 	}
 	if (freeze_protected)
 		sb_end_intwrite(inode->i_sb);
@@ -918,8 +931,12 @@ void f2fs_evict_inode(struct inode *inode)
 	if (likely(!f2fs_cp_error(sbi) &&
 				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
-	else
-		f2fs_inode_synced(inode);
+
+	/*
+	 * anyway, it needs to remove the inode from sbi->inode_list[DIRTY_META]
+	 * list to avoid UAF in f2fs_sync_inode_meta() during checkpoint.
+	 */
+	f2fs_inode_synced(inode);
 
 	/* for the case f2fs_new_inode() was failed, .i_ino is zero, skip it */
 	if (inode->i_ino)
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 52bb1a281935..f8f94301350c 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -626,8 +626,7 @@ static inline void __get_secs_required(struct f2fs_sb_info *sbi,
 	unsigned int dent_blocks = total_dent_blocks % CAP_BLKS_PER_SEC(sbi);
 	unsigned int data_blocks = 0;
 
-	if (f2fs_lfs_mode(sbi) &&
-		unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+	if (f2fs_lfs_mode(sbi)) {
 		total_data_blocks = get_pages(sbi, F2FS_DIRTY_DATA);
 		data_secs = total_data_blocks / CAP_BLKS_PER_SEC(sbi);
 		data_blocks = total_data_blocks % CAP_BLKS_PER_SEC(sbi);
@@ -636,7 +635,7 @@ static inline void __get_secs_required(struct f2fs_sb_info *sbi,
 	if (lower_p)
 		*lower_p = node_secs + dent_secs + data_secs;
 	if (upper_p)
-		*upper_p = node_secs + dent_secs +
+		*upper_p = node_secs + dent_secs + data_secs +
 			(node_blocks ? 1 : 0) + (dent_blocks ? 1 : 0) +
 			(data_blocks ? 1 : 0);
 	if (curseg_p)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3f2c6fa3623b..875aef2fc520 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3388,6 +3388,7 @@ static int __f2fs_commit_super(struct f2fs_sb_info *sbi, struct folio *folio,
 		f2fs_bug_on(sbi, 1);
 
 	ret = submit_bio_wait(bio);
+	bio_put(bio);
 	folio_end_writeback(folio);
 
 	return ret;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 7df638f901a1..eb84b9418ac1 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -623,6 +623,27 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_no_zoned_gc_percent")) {
+		if (t > 100)
+			return -EINVAL;
+		*ui = (unsigned int)t;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "gc_boost_zoned_gc_percent")) {
+		if (t > 100)
+			return -EINVAL;
+		*ui = (unsigned int)t;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "gc_valid_thresh_ratio")) {
+		if (t > 100)
+			return -EINVAL;
+		*ui = (unsigned int)t;
+		return count;
+	}
+
 #ifdef CONFIG_F2FS_IOSTAT
 	if (!strcmp(a->attr.name, "iostat_enable")) {
 		sbi->iostat_enable = !!t;
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 13be8d1d228b..ee198a261d4f 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -232,32 +232,23 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	 */
 	ret = gfs2_glock_nq(&sdp->sd_live_gh);
 
+	gfs2_glock_put(live_gl); /* drop extra reference we acquired */
+	clear_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags);
+
 	/*
 	 * If we actually got the "live" lock in EX mode, there are no other
-	 * nodes available to replay our journal. So we try to replay it
-	 * ourselves. We hold the "live" glock to prevent other mounters
-	 * during recovery, then just dequeue it and reacquire it in our
-	 * normal SH mode. Just in case the problem that caused us to
-	 * withdraw prevents us from recovering our journal (e.g. io errors
-	 * and such) we still check if the journal is clean before proceeding
-	 * but we may wait forever until another mounter does the recovery.
+	 * nodes available to replay our journal.
 	 */
 	if (ret == 0) {
-		fs_warn(sdp, "No other mounters found. Trying to recover our "
-			"own journal jid %d.\n", sdp->sd_lockstruct.ls_jid);
-		if (gfs2_recover_journal(sdp->sd_jdesc, 1))
-			fs_warn(sdp, "Unable to recover our journal jid %d.\n",
-				sdp->sd_lockstruct.ls_jid);
-		gfs2_glock_dq_wait(&sdp->sd_live_gh);
-		gfs2_holder_reinit(LM_ST_SHARED,
-				   LM_FLAG_NOEXP | GL_EXACT | GL_NOPID,
-				   &sdp->sd_live_gh);
-		gfs2_glock_nq(&sdp->sd_live_gh);
+		fs_warn(sdp, "No other mounters found.\n");
+		/*
+		 * We are about to release the lockspace.  By keeping live_gl
+		 * locked here, we ensure that the next mounter coming along
+		 * will be a "first" mounter which will perform recovery.
+		 */
+		goto skip_recovery;
 	}
 
-	gfs2_glock_put(live_gl); /* drop extra reference we acquired */
-	clear_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags);
-
 	/*
 	 * At this point our journal is evicted, so we need to get a new inode
 	 * for it. Once done, we need to call gfs2_find_jhead which
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index a81ce7a740b9..451115360f73 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -692,6 +692,7 @@ static const struct file_operations hfs_file_operations = {
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
 	.splice_read	= filemap_splice_read,
+	.splice_write	= iter_file_splice_write,
 	.fsync		= hfs_file_fsync,
 	.open		= hfs_file_open,
 	.release	= hfs_file_release,
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index a6d61685ae79..b1699b3c246a 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -342,9 +342,6 @@ static int hfsplus_free_extents(struct super_block *sb,
 	int i;
 	int err = 0;
 
-	/* Mapping the allocation file may lock the extent tree */
-	WARN_ON(mutex_is_locked(&HFSPLUS_SB(sb)->ext_tree->tree_lock));
-
 	hfsplus_dump_extent(extent);
 	for (i = 0; i < 8; extent++, i++) {
 		count = be32_to_cpu(extent->block_count);
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index f331e9574217..c85b5802ec0f 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -368,6 +368,7 @@ static const struct file_operations hfsplus_file_operations = {
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
 	.splice_read	= filemap_splice_read,
+	.splice_write	= iter_file_splice_write,
 	.fsync		= hfsplus_file_fsync,
 	.open		= hfsplus_file_open,
 	.release	= hfsplus_file_release,
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 35e063c9f3a4..5a877261c3fe 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1809,8 +1809,10 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
 			return -EIO;
 		dp = (struct dmap *) mp->data;
 
-		if (dp->tree.budmin < 0)
+		if (dp->tree.budmin < 0) {
+			release_metapage(mp);
 			return -EIO;
+		}
 
 		/* try to allocate the blocks.
 		 */
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f9f4a92f63e9..bbc625e742aa 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1837,9 +1837,7 @@ static void block_revalidate(struct dentry *dentry)
 
 static void unblock_revalidate(struct dentry *dentry)
 {
-	/* store_release ensures wait_var_event() sees the update */
-	smp_store_release(&dentry->d_fsdata, NULL);
-	wake_up_var(&dentry->d_fsdata);
+	store_release_wake_up(&dentry->d_fsdata, NULL);
 }
 
 /*
diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index be686b8e0c54..aeb17adcb2b6 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -66,14 +66,21 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
 {
 	struct nfs_fattr *fattr = NULL;
 	struct nfs_fh *server_fh = nfs_exp_embedfh(fid->raw);
-	size_t fh_size = offsetof(struct nfs_fh, data) + server_fh->size;
+	size_t fh_size = offsetof(struct nfs_fh, data);
 	const struct nfs_rpc_ops *rpc_ops;
 	struct dentry *dentry;
 	struct inode *inode;
-	int len = EMBED_FH_OFF + XDR_QUADLEN(fh_size);
+	int len = EMBED_FH_OFF;
 	u32 *p = fid->raw;
 	int ret;
 
+	/* Initial check of bounds */
+	if (fh_len < len + XDR_QUADLEN(fh_size) ||
+	    fh_len > XDR_QUADLEN(NFS_MAXFHSIZE))
+		return NULL;
+	/* Calculate embedded filehandle size */
+	fh_size += server_fh->size;
+	len += XDR_QUADLEN(fh_size);
 	/* NULL translates to ESTALE */
 	if (fh_len < len || fh_type != len)
 		return NULL;
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index bf96f7a8900c..b685e763ef11 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -761,14 +761,14 @@ ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
 {
 	struct nfs4_ff_layout_segment *fls = FF_LAYOUT_LSEG(lseg);
 	struct nfs4_ff_layout_mirror *mirror;
-	struct nfs4_pnfs_ds *ds;
+	struct nfs4_pnfs_ds *ds = ERR_PTR(-EAGAIN);
 	u32 idx;
 
 	/* mirrors are initially sorted by efficiency */
 	for (idx = start_idx; idx < fls->mirror_array_cnt; idx++) {
 		mirror = FF_LAYOUT_COMP(lseg, idx);
 		ds = nfs4_ff_layout_prepare_ds(lseg, mirror, false);
-		if (!ds)
+		if (IS_ERR(ds))
 			continue;
 
 		if (check_device &&
@@ -776,10 +776,10 @@ ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
 			continue;
 
 		*best_idx = idx;
-		return ds;
+		break;
 	}
 
-	return NULL;
+	return ds;
 }
 
 static struct nfs4_pnfs_ds *
@@ -941,7 +941,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 	for (i = 0; i < pgio->pg_mirror_count; i++) {
 		mirror = FF_LAYOUT_COMP(pgio->pg_lseg, i);
 		ds = nfs4_ff_layout_prepare_ds(pgio->pg_lseg, mirror, true);
-		if (!ds) {
+		if (IS_ERR(ds)) {
 			if (!ff_layout_no_fallback_to_mds(pgio->pg_lseg))
 				goto out_mds;
 			pnfs_generic_pg_cleanup(pgio);
@@ -1848,6 +1848,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	u32 idx = hdr->pgio_mirror_idx;
 	int vers;
 	struct nfs_fh *fh;
+	bool ds_fatal_error = false;
 
 	dprintk("--> %s ino %lu pgbase %u req %zu@%llu\n",
 		__func__, hdr->inode->i_ino,
@@ -1855,8 +1856,10 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 
 	mirror = FF_LAYOUT_COMP(lseg, idx);
 	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, false);
-	if (!ds)
+	if (IS_ERR(ds)) {
+		ds_fatal_error = nfs_error_is_fatal(PTR_ERR(ds));
 		goto out_failed;
+	}
 
 	ds_clnt = nfs4_ff_find_or_create_ds_client(mirror, ds->ds_clp,
 						   hdr->inode);
@@ -1904,7 +1907,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	return PNFS_ATTEMPTED;
 
 out_failed:
-	if (ff_layout_avoid_mds_available_ds(lseg))
+	if (ff_layout_avoid_mds_available_ds(lseg) && !ds_fatal_error)
 		return PNFS_TRY_AGAIN;
 	trace_pnfs_mds_fallback_read_pagelist(hdr->inode,
 			hdr->args.offset, hdr->args.count,
@@ -1926,11 +1929,14 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	int vers;
 	struct nfs_fh *fh;
 	u32 idx = hdr->pgio_mirror_idx;
+	bool ds_fatal_error = false;
 
 	mirror = FF_LAYOUT_COMP(lseg, idx);
 	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, true);
-	if (!ds)
+	if (IS_ERR(ds)) {
+		ds_fatal_error = nfs_error_is_fatal(PTR_ERR(ds));
 		goto out_failed;
+	}
 
 	ds_clnt = nfs4_ff_find_or_create_ds_client(mirror, ds->ds_clp,
 						   hdr->inode);
@@ -1981,7 +1987,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	return PNFS_ATTEMPTED;
 
 out_failed:
-	if (ff_layout_avoid_mds_available_ds(lseg))
+	if (ff_layout_avoid_mds_available_ds(lseg) && !ds_fatal_error)
 		return PNFS_TRY_AGAIN;
 	trace_pnfs_mds_fallback_write_pagelist(hdr->inode,
 			hdr->args.offset, hdr->args.count,
@@ -2024,7 +2030,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	idx = calc_ds_index_from_commit(lseg, data->ds_commit_index);
 	mirror = FF_LAYOUT_COMP(lseg, idx);
 	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, true);
-	if (!ds)
+	if (IS_ERR(ds))
 		goto out_err;
 
 	ds_clnt = nfs4_ff_find_or_create_ds_client(mirror, ds->ds_clp,
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index 4a304cf17c4b..ef535baeefb6 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -370,11 +370,11 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 			  struct nfs4_ff_layout_mirror *mirror,
 			  bool fail_return)
 {
-	struct nfs4_pnfs_ds *ds = NULL;
+	struct nfs4_pnfs_ds *ds;
 	struct inode *ino = lseg->pls_layout->plh_inode;
 	struct nfs_server *s = NFS_SERVER(ino);
 	unsigned int max_payload;
-	int status;
+	int status = -EAGAIN;
 
 	if (!ff_layout_init_mirror_ds(lseg->pls_layout, mirror))
 		goto noconnect;
@@ -418,7 +418,7 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 	ff_layout_send_layouterror(lseg);
 	if (fail_return || !ff_layout_has_available_ds(lseg))
 		pnfs_error_mark_layout_for_return(ino, lseg);
-	ds = NULL;
+	ds = ERR_PTR(status);
 out:
 	return ds;
 }
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 1be4be3d4a2b..9840b779f0df 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -668,9 +668,12 @@ nfs_write_match_verf(const struct nfs_writeverf *verf,
 
 static inline gfp_t nfs_io_gfp_mask(void)
 {
-	if (current->flags & PF_WQ_WORKER)
-		return GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
-	return GFP_KERNEL;
+	gfp_t ret = current_gfp_context(GFP_KERNEL);
+
+	/* For workers __GFP_NORETRY only with __GFP_IO or __GFP_FS */
+	if ((current->flags & PF_WQ_WORKER) && ret == GFP_KERNEL)
+		ret |= __GFP_NORETRY | __GFP_NOWARN;
+	return ret;
 }
 
 /*
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 77b239b10d41..e27cd2c7cfd1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10819,7 +10819,7 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
-	ssize_t error, error2, error3, error4;
+	ssize_t error, error2, error3, error4 = 0;
 	size_t left = size;
 
 	error = generic_listxattr(dentry, list, left);
@@ -10847,9 +10847,11 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 		left -= error3;
 	}
 
-	error4 = security_inode_listsecurity(d_inode(dentry), list, left);
-	if (error4 < 0)
-		return error4;
+	if (!nfs_server_capable(d_inode(dentry), NFS_CAP_SECURITY_LABEL)) {
+		error4 = security_inode_listsecurity(d_inode(dentry), list, left);
+		if (error4 < 0)
+			return error4;
+	}
 
 	error += error2 + error3 + error4;
 	if (size && error > size)
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 224bccaab4cc..bb00e1e16838 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -441,7 +441,13 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	dwords = fh_len >> 2;
 	type = exportfs_encode_fid(inode, buf, &dwords);
 	err = -EINVAL;
-	if (type <= 0 || type == FILEID_INVALID || fh_len != dwords << 2)
+	/*
+	 * Unlike file_handle, type and len of struct fanotify_fh are u8.
+	 * Traditionally, filesystem return handle_type < 0xff, but there
+	 * is no enforecement for that in vfs.
+	 */
+	BUILD_BUG_ON(MAX_HANDLE_SZ > 0xff || FILEID_INVALID > 0xff);
+	if (type <= 0 || type >= FILEID_INVALID || fh_len != dwords << 2)
 		goto out_err;
 
 	fh->type = type;
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 748c4be912db..902dc8ba878e 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -392,7 +392,10 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		}
 
 		if (ni->i_valid < to) {
-			inode_lock(inode);
+			if (!inode_trylock(inode)) {
+				err = -EAGAIN;
+				goto out;
+			}
 			err = ntfs_extend_initialized_size(file, ni,
 							   ni->i_valid, to);
 			inode_unlock(inode);
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 608634361a30..ed38014d1750 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3057,8 +3057,7 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
  * ni_rename - Remove one name and insert new name.
  */
 int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
-	      struct ntfs_inode *ni, struct NTFS_DE *de, struct NTFS_DE *new_de,
-	      bool *is_bad)
+	      struct ntfs_inode *ni, struct NTFS_DE *de, struct NTFS_DE *new_de)
 {
 	int err;
 	struct NTFS_DE *de2 = NULL;
@@ -3081,8 +3080,8 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
 	err = ni_add_name(new_dir_ni, ni, new_de);
 	if (!err) {
 		err = ni_remove_name(dir_ni, ni, de, &de2, &undo);
-		if (err && ni_remove_name(new_dir_ni, ni, new_de, &de2, &undo))
-			*is_bad = true;
+		WARN_ON(err && ni_remove_name(new_dir_ni, ni, new_de, &de2,
+			&undo));
 	}
 
 	/*
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index abf7e81584a9..71a5a959a48c 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -244,7 +244,7 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 	struct ntfs_inode *ni = ntfs_i(inode);
 	struct inode *new_inode = d_inode(new_dentry);
 	struct NTFS_DE *de, *new_de;
-	bool is_same, is_bad;
+	bool is_same;
 	/*
 	 * de		- memory of PATH_MAX bytes:
 	 * [0-1024)	- original name (dentry->d_name)
@@ -313,12 +313,8 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 	if (dir_ni != new_dir_ni)
 		ni_lock_dir2(new_dir_ni);
 
-	is_bad = false;
-	err = ni_rename(dir_ni, new_dir_ni, ni, de, new_de, &is_bad);
-	if (is_bad) {
-		/* Restore after failed rename failed too. */
-		_ntfs_bad_inode(inode);
-	} else if (!err) {
+	err = ni_rename(dir_ni, new_dir_ni, ni, de, new_de);
+	if (!err) {
 		simple_rename_timestamp(dir, dentry, new_dir, new_dentry);
 		mark_inode_dirty(inode);
 		mark_inode_dirty(dir);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index cd8e8374bb5a..ff7f241a25b2 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -584,8 +584,7 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
 		struct NTFS_DE *de);
 
 int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
-	      struct ntfs_inode *ni, struct NTFS_DE *de, struct NTFS_DE *new_de,
-	      bool *is_bad);
+	      struct ntfs_inode *ni, struct NTFS_DE *de, struct NTFS_DE *new_de);
 
 bool ni_is_dirty(struct inode *inode);
 int ni_set_compress(struct inode *inode, bool compr);
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index fa41db088488..b57140ebfad0 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -728,8 +728,8 @@ static void do_k_string(void *k_mask, int index)
 
 	if (*mask & s_kmod_keyword_mask_map[index].mask_val) {
 		if ((strlen(kernel_debug_string) +
-		     strlen(s_kmod_keyword_mask_map[index].keyword))
-			< ORANGEFS_MAX_DEBUG_STRING_LEN - 1) {
+		     strlen(s_kmod_keyword_mask_map[index].keyword) + 1)
+			< ORANGEFS_MAX_DEBUG_STRING_LEN) {
 				strcat(kernel_debug_string,
 				       s_kmod_keyword_mask_map[index].keyword);
 				strcat(kernel_debug_string, ",");
@@ -756,7 +756,7 @@ static void do_c_string(void *c_mask, int index)
 	    (mask->mask2 & cdm_array[index].mask2)) {
 		if ((strlen(client_debug_string) +
 		     strlen(cdm_array[index].keyword) + 1)
-			< ORANGEFS_MAX_DEBUG_STRING_LEN - 2) {
+			< ORANGEFS_MAX_DEBUG_STRING_LEN) {
 				strcat(client_debug_string,
 				       cdm_array[index].keyword);
 				strcat(client_debug_string, ",");
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 3431b083f7d0..e21d99fa9263 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -567,6 +567,8 @@ static void pde_set_flags(struct proc_dir_entry *pde)
 	if (pde->proc_ops->proc_compat_ioctl)
 		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
 #endif
+	if (pde->proc_ops->proc_lseek)
+		pde->flags |= PROC_ENTRY_proc_lseek;
 }
 
 struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 3604b616311c..129490151be1 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -473,7 +473,7 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 	typeof_member(struct proc_ops, proc_open) open;
 	struct pde_opener *pdeo;
 
-	if (!pde->proc_ops->proc_lseek)
+	if (!pde_has_proc_lseek(pde))
 		file->f_mode &= ~FMODE_LSEEK;
 
 	if (pde_is_permanent(pde)) {
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 4e0c5b57ffdb..edd4eb6fa12a 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -99,6 +99,11 @@ static inline bool pde_has_proc_compat_ioctl(const struct proc_dir_entry *pde)
 #endif
 }
 
+static inline bool pde_has_proc_lseek(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_proc_lseek;
+}
+
 extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index c0196be0e65f..9092051776fc 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -432,10 +432,8 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 			server->smbd_conn->receive_credit_target);
 		seq_printf(m, "\nPending send_pending: %x ",
 			atomic_read(&server->smbd_conn->send_pending));
-		seq_printf(m, "\nReceive buffers count_receive_queue: %x "
-			"count_empty_packet_queue: %x",
-			server->smbd_conn->count_receive_queue,
-			server->smbd_conn->count_empty_packet_queue);
+		seq_printf(m, "\nReceive buffers count_receive_queue: %x ",
+			server->smbd_conn->count_receive_queue);
 		seq_printf(m, "\nMR responder_resources: %x "
 			"max_frmr_depth: %x mr_type: %x",
 			server->smbd_conn->responder_resources,
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 754e94a0e07f..c661a8e6c18b 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -13,8 +13,6 @@
 #include "cifsproto.h"
 #include "smb2proto.h"
 
-static struct smbd_response *get_empty_queue_buffer(
-		struct smbd_connection *info);
 static struct smbd_response *get_receive_buffer(
 		struct smbd_connection *info);
 static void put_receive_buffer(
@@ -23,8 +21,6 @@ static void put_receive_buffer(
 static int allocate_receive_buffers(struct smbd_connection *info, int num_buf);
 static void destroy_receive_buffers(struct smbd_connection *info);
 
-static void put_empty_packet(
-		struct smbd_connection *info, struct smbd_response *response);
 static void enqueue_reassembly(
 		struct smbd_connection *info,
 		struct smbd_response *response, int data_length);
@@ -391,7 +387,6 @@ static bool process_negotiation_response(
 static void smbd_post_send_credits(struct work_struct *work)
 {
 	int ret = 0;
-	int use_receive_queue = 1;
 	int rc;
 	struct smbd_response *response;
 	struct smbd_connection *info =
@@ -407,18 +402,9 @@ static void smbd_post_send_credits(struct work_struct *work)
 	if (info->receive_credit_target >
 		atomic_read(&info->receive_credits)) {
 		while (true) {
-			if (use_receive_queue)
-				response = get_receive_buffer(info);
-			else
-				response = get_empty_queue_buffer(info);
-			if (!response) {
-				/* now switch to empty packet queue */
-				if (use_receive_queue) {
-					use_receive_queue = 0;
-					continue;
-				} else
-					break;
-			}
+			response = get_receive_buffer(info);
+			if (!response)
+				break;
 
 			response->type = SMBD_TRANSFER_DATA;
 			response->first_segment = false;
@@ -466,7 +452,6 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_RECV) {
 		log_rdma_recv(INFO, "wc->status=%d opcode=%d\n",
 			wc->status, wc->opcode);
-		smbd_disconnect_rdma_connection(info);
 		goto error;
 	}
 
@@ -483,18 +468,15 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		info->full_packet_received = true;
 		info->negotiate_done =
 			process_negotiation_response(response, wc->byte_len);
+		put_receive_buffer(info, response);
 		complete(&info->negotiate_completion);
-		break;
+		return;
 
 	/* SMBD data transfer packet */
 	case SMBD_TRANSFER_DATA:
 		data_transfer = smbd_response_payload(response);
 		data_length = le32_to_cpu(data_transfer->data_length);
 
-		/*
-		 * If this is a packet with data playload place the data in
-		 * reassembly queue and wake up the reading thread
-		 */
 		if (data_length) {
 			if (info->full_packet_received)
 				response->first_segment = true;
@@ -503,16 +485,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 				info->full_packet_received = false;
 			else
 				info->full_packet_received = true;
-
-			enqueue_reassembly(
-				info,
-				response,
-				data_length);
-		} else
-			put_empty_packet(info, response);
-
-		if (data_length)
-			wake_up_interruptible(&info->wait_reassembly_queue);
+		}
 
 		atomic_dec(&info->receive_credits);
 		info->receive_credit_target =
@@ -540,15 +513,27 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 			info->keep_alive_requested = KEEP_ALIVE_PENDING;
 		}
 
-		return;
+		/*
+		 * If this is a packet with data playload place the data in
+		 * reassembly queue and wake up the reading thread
+		 */
+		if (data_length) {
+			enqueue_reassembly(info, response, data_length);
+			wake_up_interruptible(&info->wait_reassembly_queue);
+		} else
+			put_receive_buffer(info, response);
 
-	default:
-		log_rdma_recv(ERR,
-			"unexpected response type=%d\n", response->type);
+		return;
 	}
 
+	/*
+	 * This is an internal error!
+	 */
+	log_rdma_recv(ERR, "unexpected response type=%d\n", response->type);
+	WARN_ON_ONCE(response->type != SMBD_TRANSFER_DATA);
 error:
 	put_receive_buffer(info, response);
+	smbd_disconnect_rdma_connection(info);
 }
 
 static struct rdma_cm_id *smbd_create_id(
@@ -1069,6 +1054,7 @@ static int smbd_post_recv(
 	if (rc) {
 		ib_dma_unmap_single(sc->ib.dev, response->sge.addr,
 				    response->sge.length, DMA_FROM_DEVICE);
+		response->sge.length = 0;
 		smbd_disconnect_rdma_connection(info);
 		log_rdma_recv(ERR, "ib_post_recv failed rc=%d\n", rc);
 	}
@@ -1113,17 +1099,6 @@ static int smbd_negotiate(struct smbd_connection *info)
 	return rc;
 }
 
-static void put_empty_packet(
-		struct smbd_connection *info, struct smbd_response *response)
-{
-	spin_lock(&info->empty_packet_queue_lock);
-	list_add_tail(&response->list, &info->empty_packet_queue);
-	info->count_empty_packet_queue++;
-	spin_unlock(&info->empty_packet_queue_lock);
-
-	queue_work(info->workqueue, &info->post_send_credits_work);
-}
-
 /*
  * Implement Connection.FragmentReassemblyBuffer defined in [MS-SMBD] 3.1.1.1
  * This is a queue for reassembling upper layer payload and present to upper
@@ -1172,25 +1147,6 @@ static struct smbd_response *_get_first_reassembly(struct smbd_connection *info)
 	return ret;
 }
 
-static struct smbd_response *get_empty_queue_buffer(
-		struct smbd_connection *info)
-{
-	struct smbd_response *ret = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&info->empty_packet_queue_lock, flags);
-	if (!list_empty(&info->empty_packet_queue)) {
-		ret = list_first_entry(
-			&info->empty_packet_queue,
-			struct smbd_response, list);
-		list_del(&ret->list);
-		info->count_empty_packet_queue--;
-	}
-	spin_unlock_irqrestore(&info->empty_packet_queue_lock, flags);
-
-	return ret;
-}
-
 /*
  * Get a receive buffer
  * For each remote send, we need to post a receive. The receive buffers are
@@ -1228,8 +1184,13 @@ static void put_receive_buffer(
 	struct smbdirect_socket *sc = &info->socket;
 	unsigned long flags;
 
-	ib_dma_unmap_single(sc->ib.dev, response->sge.addr,
-		response->sge.length, DMA_FROM_DEVICE);
+	if (likely(response->sge.length != 0)) {
+		ib_dma_unmap_single(sc->ib.dev,
+				    response->sge.addr,
+				    response->sge.length,
+				    DMA_FROM_DEVICE);
+		response->sge.length = 0;
+	}
 
 	spin_lock_irqsave(&info->receive_queue_lock, flags);
 	list_add_tail(&response->list, &info->receive_queue);
@@ -1255,10 +1216,6 @@ static int allocate_receive_buffers(struct smbd_connection *info, int num_buf)
 	spin_lock_init(&info->receive_queue_lock);
 	info->count_receive_queue = 0;
 
-	INIT_LIST_HEAD(&info->empty_packet_queue);
-	spin_lock_init(&info->empty_packet_queue_lock);
-	info->count_empty_packet_queue = 0;
-
 	init_waitqueue_head(&info->wait_receive_queues);
 
 	for (i = 0; i < num_buf; i++) {
@@ -1267,6 +1224,7 @@ static int allocate_receive_buffers(struct smbd_connection *info, int num_buf)
 			goto allocate_failed;
 
 		response->info = info;
+		response->sge.length = 0;
 		list_add_tail(&response->list, &info->receive_queue);
 		info->count_receive_queue++;
 	}
@@ -1292,9 +1250,6 @@ static void destroy_receive_buffers(struct smbd_connection *info)
 
 	while ((response = get_receive_buffer(info)))
 		mempool_free(response, info->response_mempool);
-
-	while ((response = get_empty_queue_buffer(info)))
-		mempool_free(response, info->response_mempool);
 }
 
 /* Implement idle connection timer [MS-SMBD] 3.1.6.2 */
@@ -1381,8 +1336,7 @@ void smbd_destroy(struct TCP_Server_Info *server)
 
 	log_rdma_event(INFO, "free receive buffers\n");
 	wait_event(info->wait_receive_queues,
-		info->count_receive_queue + info->count_empty_packet_queue
-			== sp->recv_credit_max);
+		info->count_receive_queue == sp->recv_credit_max);
 	destroy_receive_buffers(info);
 
 	/*
@@ -1680,8 +1634,10 @@ static struct smbd_connection *_smbd_get_connection(
 		goto rdma_connect_failed;
 	}
 
-	wait_event_interruptible(
-		info->conn_wait, sc->status != SMBDIRECT_SOCKET_CONNECTING);
+	wait_event_interruptible_timeout(
+		info->conn_wait,
+		sc->status != SMBDIRECT_SOCKET_CONNECTING,
+		msecs_to_jiffies(RDMA_RESOLVE_TIMEOUT));
 
 	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
 		log_rdma_event(ERR, "rdma_connect failed port=%d\n", port);
diff --git a/fs/smb/client/smbdirect.h b/fs/smb/client/smbdirect.h
index 3d552ab27e0f..fb8db71735f3 100644
--- a/fs/smb/client/smbdirect.h
+++ b/fs/smb/client/smbdirect.h
@@ -110,10 +110,6 @@ struct smbd_connection {
 	int count_receive_queue;
 	spinlock_t receive_queue_lock;
 
-	struct list_head empty_packet_queue;
-	int count_empty_packet_queue;
-	spinlock_t empty_packet_queue_lock;
-
 	wait_queue_head_t wait_receive_queues;
 
 	/* Reassembly queue */
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index dd3e0e3f7bf0..31dd1caac1e8 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -46,6 +46,7 @@ struct ksmbd_conn {
 	struct mutex			srv_mutex;
 	int				status;
 	unsigned int			cli_cap;
+	__be32				inet_addr;
 	char				*request_buf;
 	struct ksmbd_transport		*transport;
 	struct nls_table		*local_nls;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index a97a2885730d..495a9faa298b 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1619,11 +1619,24 @@ static int krb5_authenticate(struct ksmbd_work *work,
 
 	rsp->SecurityBufferLength = cpu_to_le16(out_len);
 
-	if ((conn->sign || server_conf.enforced_signing) ||
+	/*
+	 * If session state is SMB2_SESSION_VALID, We can assume
+	 * that it is reauthentication. And the user/password
+	 * has been verified, so return it here.
+	 */
+	if (sess->state == SMB2_SESSION_VALID) {
+		if (conn->binding)
+			goto binding_session;
+		return 0;
+	}
+
+	if ((rsp->SessionFlags != SMB2_SESSION_FLAG_IS_GUEST_LE &&
+	    (conn->sign || server_conf.enforced_signing)) ||
 	    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
 		sess->sign = true;
 
-	if (smb3_encryption_negotiated(conn)) {
+	if (smb3_encryption_negotiated(conn) &&
+	    !(req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
 		retval = conn->ops->generate_encryptionkey(conn, sess);
 		if (retval) {
 			ksmbd_debug(SMB,
@@ -1636,6 +1649,7 @@ static int krb5_authenticate(struct ksmbd_work *work,
 		sess->sign = false;
 	}
 
+binding_session:
 	if (conn->dialect >= SMB30_PROT_ID) {
 		chann = lookup_chann_list(sess, conn);
 		if (!chann) {
@@ -1831,8 +1845,6 @@ int smb2_sess_setup(struct ksmbd_work *work)
 				ksmbd_conn_set_good(conn);
 				sess->state = SMB2_SESSION_VALID;
 			}
-			kfree(sess->Preauth_HashValue);
-			sess->Preauth_HashValue = NULL;
 		} else if (conn->preferred_auth_mech == KSMBD_AUTH_NTLMSSP) {
 			if (negblob->MessageType == NtLmNegotiate) {
 				rc = ntlm_negotiate(work, negblob, negblob_len, rsp);
@@ -1859,8 +1871,6 @@ int smb2_sess_setup(struct ksmbd_work *work)
 						kfree(preauth_sess);
 					}
 				}
-				kfree(sess->Preauth_HashValue);
-				sess->Preauth_HashValue = NULL;
 			} else {
 				pr_info_ratelimited("Unknown NTLMSSP message type : 0x%x\n",
 						le32_to_cpu(negblob->MessageType));
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 191df59748e0..a29c0494dccb 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -515,7 +515,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn, const char *longname,
 
 	p = strrchr(longname, '.');
 	if (p == longname) { /*name starts with a dot*/
-		strscpy(extension, "___", strlen("___"));
+		strscpy(extension, "___", sizeof(extension));
 	} else {
 		if (p) {
 			p++;
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 3ab8c04f72e4..805c20f619b0 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -128,9 +128,6 @@ struct smb_direct_transport {
 	spinlock_t		recvmsg_queue_lock;
 	struct list_head	recvmsg_queue;
 
-	spinlock_t		empty_recvmsg_queue_lock;
-	struct list_head	empty_recvmsg_queue;
-
 	int			send_credit_target;
 	atomic_t		send_credits;
 	spinlock_t		lock_new_recv_credits;
@@ -267,40 +264,19 @@ smb_direct_recvmsg *get_free_recvmsg(struct smb_direct_transport *t)
 static void put_recvmsg(struct smb_direct_transport *t,
 			struct smb_direct_recvmsg *recvmsg)
 {
-	ib_dma_unmap_single(t->cm_id->device, recvmsg->sge.addr,
-			    recvmsg->sge.length, DMA_FROM_DEVICE);
+	if (likely(recvmsg->sge.length != 0)) {
+		ib_dma_unmap_single(t->cm_id->device,
+				    recvmsg->sge.addr,
+				    recvmsg->sge.length,
+				    DMA_FROM_DEVICE);
+		recvmsg->sge.length = 0;
+	}
 
 	spin_lock(&t->recvmsg_queue_lock);
 	list_add(&recvmsg->list, &t->recvmsg_queue);
 	spin_unlock(&t->recvmsg_queue_lock);
 }
 
-static struct
-smb_direct_recvmsg *get_empty_recvmsg(struct smb_direct_transport *t)
-{
-	struct smb_direct_recvmsg *recvmsg = NULL;
-
-	spin_lock(&t->empty_recvmsg_queue_lock);
-	if (!list_empty(&t->empty_recvmsg_queue)) {
-		recvmsg = list_first_entry(&t->empty_recvmsg_queue,
-					   struct smb_direct_recvmsg, list);
-		list_del(&recvmsg->list);
-	}
-	spin_unlock(&t->empty_recvmsg_queue_lock);
-	return recvmsg;
-}
-
-static void put_empty_recvmsg(struct smb_direct_transport *t,
-			      struct smb_direct_recvmsg *recvmsg)
-{
-	ib_dma_unmap_single(t->cm_id->device, recvmsg->sge.addr,
-			    recvmsg->sge.length, DMA_FROM_DEVICE);
-
-	spin_lock(&t->empty_recvmsg_queue_lock);
-	list_add_tail(&recvmsg->list, &t->empty_recvmsg_queue);
-	spin_unlock(&t->empty_recvmsg_queue_lock);
-}
-
 static void enqueue_reassembly(struct smb_direct_transport *t,
 			       struct smb_direct_recvmsg *recvmsg,
 			       int data_length)
@@ -385,9 +361,6 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 	spin_lock_init(&t->recvmsg_queue_lock);
 	INIT_LIST_HEAD(&t->recvmsg_queue);
 
-	spin_lock_init(&t->empty_recvmsg_queue_lock);
-	INIT_LIST_HEAD(&t->empty_recvmsg_queue);
-
 	init_waitqueue_head(&t->wait_send_pending);
 	atomic_set(&t->send_pending, 0);
 
@@ -547,13 +520,13 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	t = recvmsg->transport;
 
 	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_RECV) {
+		put_recvmsg(t, recvmsg);
 		if (wc->status != IB_WC_WR_FLUSH_ERR) {
 			pr_err("Recv error. status='%s (%d)' opcode=%d\n",
 			       ib_wc_status_msg(wc->status), wc->status,
 			       wc->opcode);
 			smb_direct_disconnect_rdma_connection(t);
 		}
-		put_empty_recvmsg(t, recvmsg);
 		return;
 	}
 
@@ -567,7 +540,8 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	switch (recvmsg->type) {
 	case SMB_DIRECT_MSG_NEGOTIATE_REQ:
 		if (wc->byte_len < sizeof(struct smb_direct_negotiate_req)) {
-			put_empty_recvmsg(t, recvmsg);
+			put_recvmsg(t, recvmsg);
+			smb_direct_disconnect_rdma_connection(t);
 			return;
 		}
 		t->negotiation_requested = true;
@@ -575,7 +549,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		t->status = SMB_DIRECT_CS_CONNECTED;
 		enqueue_reassembly(t, recvmsg, 0);
 		wake_up_interruptible(&t->wait_status);
-		break;
+		return;
 	case SMB_DIRECT_MSG_DATA_TRANSFER: {
 		struct smb_direct_data_transfer *data_transfer =
 			(struct smb_direct_data_transfer *)recvmsg->packet;
@@ -584,7 +558,8 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 
 		if (wc->byte_len <
 		    offsetof(struct smb_direct_data_transfer, padding)) {
-			put_empty_recvmsg(t, recvmsg);
+			put_recvmsg(t, recvmsg);
+			smb_direct_disconnect_rdma_connection(t);
 			return;
 		}
 
@@ -592,7 +567,8 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		if (data_length) {
 			if (wc->byte_len < sizeof(struct smb_direct_data_transfer) +
 			    (u64)data_length) {
-				put_empty_recvmsg(t, recvmsg);
+				put_recvmsg(t, recvmsg);
+				smb_direct_disconnect_rdma_connection(t);
 				return;
 			}
 
@@ -604,16 +580,11 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 			else
 				t->full_packet_received = true;
 
-			enqueue_reassembly(t, recvmsg, (int)data_length);
-			wake_up_interruptible(&t->wait_reassembly_queue);
-
 			spin_lock(&t->receive_credit_lock);
 			receive_credits = --(t->recv_credits);
 			avail_recvmsg_count = t->count_avail_recvmsg;
 			spin_unlock(&t->receive_credit_lock);
 		} else {
-			put_empty_recvmsg(t, recvmsg);
-
 			spin_lock(&t->receive_credit_lock);
 			receive_credits = --(t->recv_credits);
 			avail_recvmsg_count = ++(t->count_avail_recvmsg);
@@ -635,11 +606,23 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		if (is_receive_credit_post_required(receive_credits, avail_recvmsg_count))
 			mod_delayed_work(smb_direct_wq,
 					 &t->post_recv_credits_work, 0);
-		break;
+
+		if (data_length) {
+			enqueue_reassembly(t, recvmsg, (int)data_length);
+			wake_up_interruptible(&t->wait_reassembly_queue);
+		} else
+			put_recvmsg(t, recvmsg);
+
+		return;
 	}
-	default:
-		break;
 	}
+
+	/*
+	 * This is an internal error!
+	 */
+	WARN_ON_ONCE(recvmsg->type != SMB_DIRECT_MSG_DATA_TRANSFER);
+	put_recvmsg(t, recvmsg);
+	smb_direct_disconnect_rdma_connection(t);
 }
 
 static int smb_direct_post_recv(struct smb_direct_transport *t,
@@ -669,6 +652,7 @@ static int smb_direct_post_recv(struct smb_direct_transport *t,
 		ib_dma_unmap_single(t->cm_id->device,
 				    recvmsg->sge.addr, recvmsg->sge.length,
 				    DMA_FROM_DEVICE);
+		recvmsg->sge.length = 0;
 		smb_direct_disconnect_rdma_connection(t);
 		return ret;
 	}
@@ -810,7 +794,6 @@ static void smb_direct_post_recv_credits(struct work_struct *work)
 	struct smb_direct_recvmsg *recvmsg;
 	int receive_credits, credits = 0;
 	int ret;
-	int use_free = 1;
 
 	spin_lock(&t->receive_credit_lock);
 	receive_credits = t->recv_credits;
@@ -818,18 +801,9 @@ static void smb_direct_post_recv_credits(struct work_struct *work)
 
 	if (receive_credits < t->recv_credit_target) {
 		while (true) {
-			if (use_free)
-				recvmsg = get_free_recvmsg(t);
-			else
-				recvmsg = get_empty_recvmsg(t);
-			if (!recvmsg) {
-				if (use_free) {
-					use_free = 0;
-					continue;
-				} else {
-					break;
-				}
-			}
+			recvmsg = get_free_recvmsg(t);
+			if (!recvmsg)
+				break;
 
 			recvmsg->type = SMB_DIRECT_MSG_DATA_TRANSFER;
 			recvmsg->first_segment = false;
@@ -1805,8 +1779,6 @@ static void smb_direct_destroy_pools(struct smb_direct_transport *t)
 
 	while ((recvmsg = get_free_recvmsg(t)))
 		mempool_free(recvmsg, t->recvmsg_mempool);
-	while ((recvmsg = get_empty_recvmsg(t)))
-		mempool_free(recvmsg, t->recvmsg_mempool);
 
 	mempool_destroy(t->recvmsg_mempool);
 	t->recvmsg_mempool = NULL;
@@ -1862,6 +1834,7 @@ static int smb_direct_create_pools(struct smb_direct_transport *t)
 		if (!recvmsg)
 			goto err;
 		recvmsg->transport = t;
+		recvmsg->sge.length = 0;
 		list_add(&recvmsg->list, &t->recvmsg_queue);
 	}
 	t->count_avail_recvmsg = t->recv_credit_max;
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 4e9f98db9ff4..d72588f33b9c 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -87,6 +87,7 @@ static struct tcp_transport *alloc_transport(struct socket *client_sk)
 		return NULL;
 	}
 
+	conn->inet_addr = inet_sk(client_sk->sk)->inet_daddr;
 	conn->transport = KSMBD_TRANS(t);
 	KSMBD_TRANS(t)->conn = conn;
 	KSMBD_TRANS(t)->ops = &ksmbd_tcp_transport_ops;
@@ -230,6 +231,8 @@ static int ksmbd_kthread_fn(void *p)
 {
 	struct socket *client_sk = NULL;
 	struct interface *iface = (struct interface *)p;
+	struct inet_sock *csk_inet;
+	struct ksmbd_conn *conn;
 	int ret;
 
 	while (!kthread_should_stop()) {
@@ -248,6 +251,20 @@ static int ksmbd_kthread_fn(void *p)
 			continue;
 		}
 
+		/*
+		 * Limits repeated connections from clients with the same IP.
+		 */
+		csk_inet = inet_sk(client_sk->sk);
+		down_read(&conn_list_lock);
+		list_for_each_entry(conn, &conn_list, conns_list)
+			if (csk_inet->inet_daddr == conn->inet_addr) {
+				ret = -EAGAIN;
+				break;
+			}
+		up_read(&conn_list_lock);
+		if (ret == -EAGAIN)
+			continue;
+
 		if (server_conf.max_connections &&
 		    atomic_inc_return(&active_num_conn) >= server_conf.max_connections) {
 			pr_info_ratelimited("Limit the maximum number of connections(%u)\n",
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index a662aae5126c..9d38a651431c 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -563,7 +563,8 @@ int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat)
 {
 	int err;
 
-	err = vfs_getattr(path, stat, STATX_BTIME, AT_STATX_SYNC_AS_STAT);
+	err = vfs_getattr(path, stat, STATX_BASIC_STATS | STATX_BTIME,
+			AT_STATX_SYNC_AS_STAT);
 	if (err)
 		pr_err("getattr failed, err %d\n", err);
 	return err;
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 0050ef288ab3..a394614ccd0b 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -417,7 +417,7 @@ extern int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
 extern void __audit_log_capset(const struct cred *new, const struct cred *old);
 extern void __audit_mmap_fd(int fd, int flags);
 extern void __audit_openat2_how(struct open_how *how);
-extern void __audit_log_kern_module(char *name);
+extern void __audit_log_kern_module(const char *name);
 extern void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
 extern void __audit_tk_injoffset(struct timespec64 offset);
 extern void __audit_ntp_log(const struct audit_ntp_data *ad);
@@ -519,7 +519,7 @@ static inline void audit_openat2_how(struct open_how *how)
 		__audit_openat2_how(how);
 }
 
-static inline void audit_log_kern_module(char *name)
+static inline void audit_log_kern_module(const char *name)
 {
 	if (!audit_dummy_context())
 		__audit_log_kern_module(name);
@@ -677,9 +677,8 @@ static inline void audit_mmap_fd(int fd, int flags)
 static inline void audit_openat2_how(struct open_how *how)
 { }
 
-static inline void audit_log_kern_module(char *name)
-{
-}
+static inline void audit_log_kern_module(const char *name)
+{ }
 
 static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
 { }
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 0d99bf11d260..71f9dcf56128 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -596,7 +596,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	if (p_size != SIZE_MAX && p_size < size)
 		fortify_panic(func, FORTIFY_WRITE, p_size, size, true);
 	else if (q_size != SIZE_MAX && q_size < size)
-		fortify_panic(func, FORTIFY_READ, p_size, size, true);
+		fortify_panic(func, FORTIFY_READ, q_size, size, true);
 
 	/*
 	 * Warn when writing beyond destination field size.
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 4b4bfef6f053..d86922b5435b 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -202,7 +202,7 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
  */
 #define infof(fc, fmt, ...) __logfc(fc, 'i', fmt, ## __VA_ARGS__)
 #define info_plog(p, fmt, ...) __plog(p, 'i', fmt, ## __VA_ARGS__)
-#define infofc(p, fmt, ...) __plog((&(fc)->log), 'i', fmt, ## __VA_ARGS__)
+#define infofc(fc, fmt, ...) __plog((&(fc)->log), 'i', fmt, ## __VA_ARGS__)
 
 /**
  * warnf - Store supplementary warning message
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index b25377b6ea98..5210e8371238 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -60,7 +60,8 @@ static inline int __get_task_ioprio(struct task_struct *p)
 	int prio;
 
 	if (!ioc)
-		return IOPRIO_DEFAULT;
+		return IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
+					 task_nice_ioprio(p));
 
 	if (p != current)
 		lockdep_assert_held(&p->alloc_lock);
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index cc647992f3d1..35bf9cdc1b22 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -280,6 +280,7 @@ enum {
 	MLX5_MKEY_MASK_SMALL_FENCE	= 1ull << 23,
 	MLX5_MKEY_MASK_RELAXED_ORDERING_WRITE	= 1ull << 25,
 	MLX5_MKEY_MASK_FREE			= 1ull << 29,
+	MLX5_MKEY_MASK_PAGE_SIZE_5		= 1ull << 42,
 	MLX5_MKEY_MASK_RELAXED_ORDERING_READ	= 1ull << 47,
 };
 
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index bfb85fd13e1f..110e9d09de24 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -282,10 +282,9 @@ struct kparam_array
 #define __moduleparam_const const
 #endif
 
-/* This is the fundamental function for registering boot/module
-   parameters. */
+/* This is the fundamental function for registering boot/module parameters. */
 #define __module_param_call(prefix, name, ops, arg, perm, level, flags)	\
-	/* Default value instead of permissions? */			\
+	static_assert(sizeof(""prefix) - 1 <= MAX_PARAM_PREFIX_LEN);	\
 	static const char __param_str_##name[] = prefix #name;		\
 	static struct kernel_param __moduleparam_const __param_##name	\
 	__used __section("__param")					\
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index c7abce28ed29..aab0aebb529e 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -52,6 +52,7 @@ struct pps_device {
 	int current_mode;			/* PPS mode at event time */
 
 	unsigned int last_ev;			/* last PPS event id */
+	unsigned int last_fetched_ev;		/* last fetched PPS event id */
 	wait_queue_head_t queue;		/* PPS event queue */
 
 	unsigned int id;			/* PPS source unique ID */
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index ea62201c74c4..703d0c76cc9a 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -27,6 +27,7 @@ enum {
 
 	PROC_ENTRY_proc_read_iter	= 1U << 1,
 	PROC_ENTRY_proc_compat_ioctl	= 1U << 2,
+	PROC_ENTRY_proc_lseek		= 1U << 3,
 };
 
 struct proc_ops {
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index f1fd3a8044e0..dd10c22299ab 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -84,11 +84,9 @@ enum psi_aggregators {
 struct psi_group_cpu {
 	/* 1st cacheline updated by the scheduler */
 
-	/* Aggregator needs to know of concurrent changes */
-	seqcount_t seq ____cacheline_aligned_in_smp;
-
 	/* States of the tasks belonging to this group */
-	unsigned int tasks[NR_PSI_TASK_COUNTS];
+	unsigned int tasks[NR_PSI_TASK_COUNTS]
+			____cacheline_aligned_in_smp;
 
 	/* Aggregate pressure state derived from the tasks */
 	u32 state_mask;
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 17fbb7855295..d8424abcf726 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -152,9 +152,7 @@ ring_buffer_consume(struct trace_buffer *buffer, int cpu, u64 *ts,
 		    unsigned long *lost_events);
 
 struct ring_buffer_iter *
-ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags);
-void ring_buffer_read_prepare_sync(void);
-void ring_buffer_read_start(struct ring_buffer_iter *iter);
+ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags);
 void ring_buffer_read_finish(struct ring_buffer_iter *iter);
 
 struct ring_buffer_event *
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 39f1d16f3628..a726a698aac4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2991,6 +2991,29 @@ static inline void skb_reset_transport_header(struct sk_buff *skb)
 	skb->transport_header = skb->data - skb->head;
 }
 
+/**
+ * skb_reset_transport_header_careful - conditionally reset transport header
+ * @skb: buffer to alter
+ *
+ * Hardened version of skb_reset_transport_header().
+ *
+ * Returns: true if the operation was a success.
+ */
+static inline bool __must_check
+skb_reset_transport_header_careful(struct sk_buff *skb)
+{
+	long offset = skb->data - skb->head;
+
+	if (unlikely(offset != (typeof(skb->transport_header))offset))
+		return false;
+
+	if (unlikely(offset == (typeof(skb->transport_header))~0U))
+		return false;
+
+	skb->transport_header = offset;
+	return true;
+}
+
 static inline void skb_set_transport_header(struct sk_buff *skb,
 					    const int offset)
 {
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index 0b9f1e598e3a..4bc6bb01a0eb 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -76,6 +76,7 @@ struct usbnet {
 #		define EVENT_LINK_CHANGE	11
 #		define EVENT_SET_RX_MODE	12
 #		define EVENT_NO_IP_ALIGN	13
+#		define EVENT_LINK_CARRIER_ON	14
 /* This one is special, as it indicates that the device is going away
  * there are cyclic dependencies between tasklet, timer and bh
  * that must be broken
diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7725b7579b78..2209c227e859 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -335,4 +335,64 @@ static inline void clear_and_wake_up_bit(int bit, void *word)
 	wake_up_bit(word, bit);
 }
 
+/**
+ * test_and_clear_wake_up_bit - clear a bit if it was set: wake up anyone waiting on that bit
+ * @bit: the bit of the word being waited on
+ * @word: the address of memory containing that bit
+ *
+ * If the bit is set and can be atomically cleared, any tasks waiting in
+ * wait_on_bit() or similar will be woken.  This call has the same
+ * complete ordering semantics as test_and_clear_bit().  Any changes to
+ * memory made before this call are guaranteed to be visible after the
+ * corresponding wait_on_bit() completes.
+ *
+ * Returns %true if the bit was successfully set and the wake up was sent.
+ */
+static inline bool test_and_clear_wake_up_bit(int bit, unsigned long *word)
+{
+	if (!test_and_clear_bit(bit, word))
+		return false;
+	/* no extra barrier required */
+	wake_up_bit(word, bit);
+	return true;
+}
+
+/**
+ * atomic_dec_and_wake_up - decrement an atomic_t and if zero, wake up waiters
+ * @var: the variable to dec and test
+ *
+ * Decrements the atomic variable and if it reaches zero, send a wake_up to any
+ * processes waiting on the variable.
+ *
+ * This function has the same complete ordering semantics as atomic_dec_and_test.
+ *
+ * Returns %true is the variable reaches zero and the wake up was sent.
+ */
+
+static inline bool atomic_dec_and_wake_up(atomic_t *var)
+{
+	if (!atomic_dec_and_test(var))
+		return false;
+	/* No extra barrier required */
+	wake_up_var(var);
+	return true;
+}
+
+/**
+ * store_release_wake_up - update a variable and send a wake_up
+ * @var: the address of the variable to be updated and woken
+ * @val: the value to store in the variable.
+ *
+ * Store the given value in the variable send a wake up to any tasks
+ * waiting on the variable.  All necessary barriers are included to ensure
+ * the task calling wait_var_event() sees the new value and all values
+ * written to memory before this call.
+ */
+#define store_release_wake_up(var, val)					\
+do {									\
+	smp_store_release(var, val);					\
+	smp_mb();							\
+	wake_up_var(var);						\
+} while (0)
+
 #endif /* _LINUX_WAIT_BIT_H */
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 40fce4193cc1..4b3200542fe6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2612,6 +2612,7 @@ struct hci_ev_le_conn_complete {
 #define LE_EXT_ADV_DIRECT_IND		0x0004
 #define LE_EXT_ADV_SCAN_RSP		0x0008
 #define LE_EXT_ADV_LEGACY_PDU		0x0010
+#define LE_EXT_ADV_DATA_STATUS_MASK	0x0060
 #define LE_EXT_ADV_EVT_TYPE_MASK	0x007f
 
 #define ADDR_LE_DEV_PUBLIC		0x00
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3d1d7296aed9..df4af45f8603 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -29,6 +29,7 @@
 #include <linux/idr.h>
 #include <linux/leds.h>
 #include <linux/rculist.h>
+#include <linux/spinlock.h>
 #include <linux/srcu.h>
 
 #include <net/bluetooth/hci.h>
@@ -93,6 +94,7 @@ struct discovery_state {
 	u16			uuid_count;
 	u8			(*uuids)[16];
 	unsigned long		name_resolve_timeout;
+	spinlock_t		lock;
 };
 
 #define SUSPEND_NOTIFIER_TIMEOUT	msecs_to_jiffies(2000) /* 2 seconds */
@@ -873,6 +875,7 @@ static inline void iso_recv(struct hci_conn *hcon, struct sk_buff *skb,
 
 static inline void discovery_init(struct hci_dev *hdev)
 {
+	spin_lock_init(&hdev->discovery.lock);
 	hdev->discovery.state = DISCOVERY_STOPPED;
 	INIT_LIST_HEAD(&hdev->discovery.all);
 	INIT_LIST_HEAD(&hdev->discovery.unknown);
@@ -887,8 +890,11 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
 	hdev->discovery.report_invalid_rssi = true;
 	hdev->discovery.rssi = HCI_RSSI_INVALID;
 	hdev->discovery.uuid_count = 0;
+
+	spin_lock(&hdev->discovery.lock);
 	kfree(hdev->discovery.uuids);
 	hdev->discovery.uuids = NULL;
+	spin_unlock(&hdev->discovery.lock);
 }
 
 bool hci_discovery_active(struct hci_dev *hdev);
diff --git a/include/net/dst.h b/include/net/dst.h
index 08647c99d79c..e18826cd0559 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -456,7 +456,7 @@ INDIRECT_CALLABLE_DECLARE(int ip_output(struct net *, struct sock *,
 /* Output packet to network from transport.  */
 static inline int dst_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	return INDIRECT_CALL_INET(skb_dst(skb)->output,
+	return INDIRECT_CALL_INET(READ_ONCE(skb_dst(skb)->output),
 				  ip6_output, ip_output,
 				  net, sk, skb);
 }
@@ -466,7 +466,7 @@ INDIRECT_CALLABLE_DECLARE(int ip_local_deliver(struct sk_buff *));
 /* Input packet from network to transport.  */
 static inline int dst_input(struct sk_buff *skb)
 {
-	return INDIRECT_CALL_INET(skb_dst(skb)->input,
+	return INDIRECT_CALL_INET(READ_ONCE(skb_dst(skb)->input),
 				  ip6_input, ip_local_deliver, skb);
 }
 
diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index 53bd2d02a4f0..09791f5d9b6e 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -138,12 +138,12 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len,
 static inline void lwtunnel_set_redirect(struct dst_entry *dst)
 {
 	if (lwtunnel_output_redirect(dst->lwtstate)) {
-		dst->lwtstate->orig_output = dst->output;
-		dst->output = lwtunnel_output;
+		dst->lwtstate->orig_output = READ_ONCE(dst->output);
+		WRITE_ONCE(dst->output, lwtunnel_output);
 	}
 	if (lwtunnel_input_redirect(dst->lwtstate)) {
-		dst->lwtstate->orig_input = dst->input;
-		dst->input = lwtunnel_input;
+		dst->lwtstate->orig_input = READ_ONCE(dst->input);
+		WRITE_ONCE(dst->input, lwtunnel_input);
 	}
 }
 #else
diff --git a/include/net/tc_act/tc_ctinfo.h b/include/net/tc_act/tc_ctinfo.h
index f071c1d70a25..a04bcac7adf4 100644
--- a/include/net/tc_act/tc_ctinfo.h
+++ b/include/net/tc_act/tc_ctinfo.h
@@ -18,9 +18,9 @@ struct tcf_ctinfo_params {
 struct tcf_ctinfo {
 	struct tc_action common;
 	struct tcf_ctinfo_params __rcu *params;
-	u64 stats_dscp_set;
-	u64 stats_dscp_error;
-	u64 stats_cpmark_set;
+	atomic64_t stats_dscp_set;
+	atomic64_t stats_dscp_error;
+	atomic64_t stats_cpmark_set;
 };
 
 enum {
diff --git a/include/net/udp.h b/include/net/udp.h
index 61222545ab1c..0b2e3a5e01d8 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -461,6 +461,16 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
 {
 	netdev_features_t features = NETIF_F_SG;
 	struct sk_buff *segs;
+	int drop_count;
+
+	/*
+	 * Segmentation in UDP receive path is only for UDP GRO, drop udp
+	 * fragmentation offload (UFO) packets.
+	 */
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP) {
+		drop_count = 1;
+		goto drop;
+	}
 
 	/* Avoid csum recalculation by skb_segment unless userspace explicitly
 	 * asks for the final checksum values
@@ -484,16 +494,18 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
 	 */
 	segs = __skb_gso_segment(skb, features, false);
 	if (IS_ERR_OR_NULL(segs)) {
-		int segs_nr = skb_shinfo(skb)->gso_segs;
-
-		atomic_add(segs_nr, &sk->sk_drops);
-		SNMP_ADD_STATS(__UDPX_MIB(sk, ipv4), UDP_MIB_INERRORS, segs_nr);
-		kfree_skb(skb);
-		return NULL;
+		drop_count = skb_shinfo(skb)->gso_segs;
+		goto drop;
 	}
 
 	consume_skb(skb);
 	return segs;
+
+drop:
+	atomic_add(drop_count, &sk->sk_drops);
+	SNMP_ADD_STATS(__UDPX_MIB(sk, ipv4), UDP_MIB_INERRORS, drop_count);
+	kfree_skb(skb);
+	return NULL;
 }
 
 static inline void udp_post_segment_fix_csum(struct sk_buff *skb)
diff --git a/include/sound/tas2781-tlv.h b/include/sound/tas2781-tlv.h
index d87263e43fdb..ef9b9f19d212 100644
--- a/include/sound/tas2781-tlv.h
+++ b/include/sound/tas2781-tlv.h
@@ -15,7 +15,7 @@
 #ifndef __TAS2781_TLV_H__
 #define __TAS2781_TLV_H__
 
-static const __maybe_unused DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 100, 0);
+static const __maybe_unused DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 50, 0);
 static const __maybe_unused DECLARE_TLV_DB_SCALE(amp_vol_tlv, 1100, 50, 0);
 
 #endif
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index e23a7f9b0eac..21af62e3cc6f 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -327,6 +327,9 @@ struct drm_panthor_gpu_info {
 	/** @as_present: Bitmask encoding the number of address-space exposed by the MMU. */
 	__u32 as_present;
 
+	/** @pad0: MBZ. */
+	__u32 pad0;
+
 	/** @shader_present: Bitmask encoding the shader cores exposed by the GPU. */
 	__u64 shader_present;
 
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index b95dd84eef2d..1c7e7035fc49 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,33 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+/* fork_owner values for vhost */
+#define VHOST_FORK_OWNER_KTHREAD 0
+#define VHOST_FORK_OWNER_TASK 1
+
+/**
+ * VHOST_SET_FORK_FROM_OWNER - Set the fork_owner flag for the vhost device,
+ * This ioctl must called before VHOST_SET_OWNER.
+ * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=y
+ *
+ * @param fork_owner: An 8-bit value that determines the vhost thread mode
+ *
+ * When fork_owner is set to VHOST_FORK_OWNER_TASK(default value):
+ *   - Vhost will create vhost worker as tasks forked from the owner,
+ *     inheriting all of the owner's attributes.
+ *
+ * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
+ *   - Vhost will create vhost workers as kernel threads.
+ */
+#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
+
+/**
+ * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost device.
+ * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=y
+ *
+ * @return: An 8-bit value indicating the current thread mode.
+ */
+#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
+
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index d3755b2264bd..45990792cb4a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1741,7 +1741,7 @@ config IO_URING
 
 config GCOV_PROFILE_URING
 	bool "Enable GCOV profiling on the io_uring subsystem"
-	depends on GCOV_KERNEL
+	depends on IO_URING && GCOV_KERNEL
 	help
 	  Enable GCOV profiling on the io_uring subsystem, to facilitate
 	  code coverage testing.
diff --git a/kernel/audit.h b/kernel/audit.h
index a60d2840559e..5156ecd35457 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -199,7 +199,7 @@ struct audit_context {
 			int			argc;
 		} execve;
 		struct {
-			char			*name;
+			const char		*name;
 		} module;
 		struct {
 			struct audit_ntp_data	ntp_data;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index cd57053b4a69..dae80e4dfcce 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2870,7 +2870,7 @@ void __audit_openat2_how(struct open_how *how)
 	context->type = AUDIT_OPENAT2;
 }
 
-void __audit_log_kern_module(char *name)
+void __audit_log_kern_module(const char *name)
 {
 	struct audit_context *context = audit_context();
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 68a327158989..767dcb8471f6 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -778,7 +778,10 @@ bool is_bpf_text_address(unsigned long addr)
 
 struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
 {
-	struct bpf_ksym *ksym = bpf_ksym_find(addr);
+	struct bpf_ksym *ksym;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	ksym = bpf_ksym_find(addr);
 
 	return ksym && ksym->prog ?
 	       container_of(ksym, struct bpf_prog_aux, ksym)->prog :
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6cf165c55bda..be4429463599 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2781,9 +2781,16 @@ static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 	struct bpf_throw_ctx *ctx = cookie;
 	struct bpf_prog *prog;
 
-	if (!is_bpf_text_address(ip))
-		return !ctx->cnt;
+	/*
+	 * The RCU read lock is held to safely traverse the latch tree, but we
+	 * don't need its protection when accessing the prog, since it has an
+	 * active stack frame on the current stack trace, and won't disappear.
+	 */
+	rcu_read_lock();
 	prog = bpf_prog_ksym_find(ip);
+	rcu_read_unlock();
+	if (!prog)
+		return !ctx->cnt;
 	ctx->cnt++;
 	if (bpf_is_subprog(prog))
 		return true;
diff --git a/kernel/bpf/preload/Kconfig b/kernel/bpf/preload/Kconfig
index c9d45c9d6918..f9b11d01c3b5 100644
--- a/kernel/bpf/preload/Kconfig
+++ b/kernel/bpf/preload/Kconfig
@@ -10,7 +10,6 @@ menuconfig BPF_PRELOAD
 	# The dependency on !COMPILE_TEST prevents it from being enabled
 	# in allmodconfig or allyesconfig configurations
 	depends on !COMPILE_TEST
-	select USERMODE_DRIVER
 	help
 	  This builds kernel module with several embedded BPF programs that are
 	  pinned into BPF FS mount point as human readable files that are
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dd745485b0f4..3cc06ffb60c1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6617,11 +6617,21 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	ring_buffer_put(rb); /* could be last */
 }
 
+static int perf_mmap_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	/*
+	 * Forbid splitting perf mappings to prevent refcount leaks due to
+	 * the resulting non-matching offsets and sizes. See open()/close().
+	 */
+	return -EINVAL;
+}
+
 static const struct vm_operations_struct perf_mmap_vmops = {
 	.open		= perf_mmap_open,
 	.close		= perf_mmap_close, /* non mergeable */
 	.fault		= perf_mmap_fault,
 	.page_mkwrite	= perf_mmap_fault,
+	.may_split	= perf_mmap_may_split,
 };
 
 static int perf_mmap(struct file *file, struct vm_area_struct *vma)
@@ -6713,9 +6723,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			goto unlock;
 		}
 
-		atomic_set(&rb->aux_mmap_count, 1);
 		user_extra = nr_pages;
-
 		goto accounting;
 	}
 
@@ -6817,8 +6825,10 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	} else {
 		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
 				   event->attr.aux_watermark, flags);
-		if (!ret)
+		if (!ret) {
+			atomic_set(&rb->aux_mmap_count, 1);
 			rb->aux_mmap_locked = extra;
+		}
 	}
 
 unlock:
@@ -6828,6 +6838,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 		atomic_inc(&event->mmap_count);
 	} else if (rb) {
+		/* AUX allocation failed */
 		atomic_dec(&rb->mmap_count);
 	}
 aux_unlock:
@@ -6835,6 +6846,9 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		mutex_unlock(aux_mutex);
 	mutex_unlock(&event->mmap_mutex);
 
+	if (ret)
+		return ret;
+
 	/*
 	 * Since pinned accounting is per vm we cannot allow fork() to copy our
 	 * vma.
diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 117d9d4d3c3b..5121d9a6dd3b 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -533,7 +533,7 @@ static void test_barrier_nothreads(struct kunit *test)
 	struct kcsan_scoped_access *reorder_access = NULL;
 #endif
 	arch_spinlock_t arch_spinlock = __ARCH_SPIN_LOCK_UNLOCKED;
-	atomic_t dummy;
+	atomic_t dummy = ATOMIC_INIT(0);
 
 	KCSAN_TEST_REQUIRES(test, reorder_access != NULL);
 	KCSAN_TEST_REQUIRES(test, IS_ENABLED(CONFIG_SMP));
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 93a07387af3b..6908062f4560 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2898,7 +2898,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	module_allocated = true;
 
-	audit_log_kern_module(mod->name);
+	audit_log_kern_module(info->name);
 
 	/* Reserve our place in the list. */
 	err = add_unformed_module(mod);
@@ -3058,8 +3058,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	 * failures once the proper module was allocated and
 	 * before that.
 	 */
-	if (!module_allocated)
+	if (!module_allocated) {
+		audit_log_kern_module(info->name ? info->name : "?");
 		mod_stat_bump_becoming(info, flags);
+	}
 	free_copy(info, flags);
 	return err;
 }
diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 0db9db73f57f..36b78d5a0675 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -81,7 +81,7 @@ torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_SCALE_TEST) ? 10 : 0,
 // Number of typesafe_lookup structures, that is, the degree of concurrency.
 torture_param(long, lookup_instances, 0, "Number of typesafe_lookup structures.");
 // Number of loops per experiment, all readers execute operations concurrently.
-torture_param(long, loops, 10000, "Number of loops per experiment.");
+torture_param(int, loops, 10000, "Number of loops per experiment.");
 // Number of readers, with -1 defaulting to about 75% of the CPUs.
 torture_param(int, nreaders, -1, "Number of readers, -1 for 75% of CPUs.");
 // Number of runs.
@@ -1029,7 +1029,7 @@ static void
 ref_scale_print_module_parms(const struct ref_scale_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" SCALE_FLAG
-		 "--- %s:  verbose=%d verbose_batched=%d shutdown=%d holdoff=%d lookup_instances=%ld loops=%ld nreaders=%d nruns=%d readdelay=%d\n", scale_type, tag,
+		 "--- %s:  verbose=%d verbose_batched=%d shutdown=%d holdoff=%d lookup_instances=%ld loops=%d nreaders=%d nruns=%d readdelay=%d\n", scale_type, tag,
 		 verbose, verbose_batched, shutdown, holdoff, lookup_instances, loops, nreaders, nruns, readdelay);
 }
 
@@ -1126,12 +1126,16 @@ ref_scale_init(void)
 	// Reader tasks (default to ~75% of online CPUs).
 	if (nreaders < 0)
 		nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
-	if (WARN_ONCE(loops <= 0, "%s: loops = %ld, adjusted to 1\n", __func__, loops))
+	if (WARN_ONCE(loops <= 0, "%s: loops = %d, adjusted to 1\n", __func__, loops))
 		loops = 1;
 	if (WARN_ONCE(nreaders <= 0, "%s: nreaders = %d, adjusted to 1\n", __func__, nreaders))
 		nreaders = 1;
 	if (WARN_ONCE(nruns <= 0, "%s: nruns = %d, adjusted to 1\n", __func__, nruns))
 		nruns = 1;
+	if (WARN_ONCE(loops > INT_MAX / nreaders,
+		      "%s: nreaders * loops will overflow, adjusted loops to %d",
+		      __func__, INT_MAX / nreaders))
+		loops = INT_MAX / nreaders;
 	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (!reader_tasks) {
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 2605dd234a13..2ad3a88623a7 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -276,7 +276,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	 * callback storms, no need to wake up too early.
 	 */
 	if (waketype == RCU_NOCB_WAKE_LAZY &&
-	    rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
+	    rdp_gp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
 		mod_timer(&rdp_gp->nocb_timer, jiffies + rcu_get_jiffies_lazy_flush());
 		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
 	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 84dad1511d1e..7d0f8fdd48a3 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -172,17 +172,35 @@ struct psi_group psi_system = {
 	.pcpu = &system_group_pcpu,
 };
 
+static DEFINE_PER_CPU(seqcount_t, psi_seq) = SEQCNT_ZERO(psi_seq);
+
+static inline void psi_write_begin(int cpu)
+{
+	write_seqcount_begin(per_cpu_ptr(&psi_seq, cpu));
+}
+
+static inline void psi_write_end(int cpu)
+{
+	write_seqcount_end(per_cpu_ptr(&psi_seq, cpu));
+}
+
+static inline u32 psi_read_begin(int cpu)
+{
+	return read_seqcount_begin(per_cpu_ptr(&psi_seq, cpu));
+}
+
+static inline bool psi_read_retry(int cpu, u32 seq)
+{
+	return read_seqcount_retry(per_cpu_ptr(&psi_seq, cpu), seq);
+}
+
 static void psi_avgs_work(struct work_struct *work);
 
 static void poll_timer_fn(struct timer_list *t);
 
 static void group_init(struct psi_group *group)
 {
-	int cpu;
-
 	group->enabled = true;
-	for_each_possible_cpu(cpu)
-		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
 	group->avg_last_update = sched_clock();
 	group->avg_next_update = group->avg_last_update + psi_period;
 	mutex_init(&group->avgs_lock);
@@ -262,14 +280,14 @@ static void get_recent_times(struct psi_group *group, int cpu,
 
 	/* Snapshot a coherent view of the CPU state */
 	do {
-		seq = read_seqcount_begin(&groupc->seq);
+		seq = psi_read_begin(cpu);
 		now = cpu_clock(cpu);
 		memcpy(times, groupc->times, sizeof(groupc->times));
 		state_mask = groupc->state_mask;
 		state_start = groupc->state_start;
 		if (cpu == current_cpu)
 			memcpy(tasks, groupc->tasks, sizeof(groupc->tasks));
-	} while (read_seqcount_retry(&groupc->seq, seq));
+	} while (psi_read_retry(cpu, seq));
 
 	/* Calculate state time deltas against the previous snapshot */
 	for (s = 0; s < NR_PSI_STATES; s++) {
@@ -768,30 +786,20 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
 		groupc->times[PSI_NONIDLE] += delta;
 }
 
+#define for_each_group(iter, group) \
+	for (typeof(group) iter = group; iter; iter = iter->parent)
+
 static void psi_group_change(struct psi_group *group, int cpu,
 			     unsigned int clear, unsigned int set,
-			     bool wake_clock)
+			     u64 now, bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
 	unsigned int t, m;
 	u32 state_mask;
-	u64 now;
 
 	lockdep_assert_rq_held(cpu_rq(cpu));
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
-	/*
-	 * First we update the task counts according to the state
-	 * change requested through the @clear and @set bits.
-	 *
-	 * Then if the cgroup PSI stats accounting enabled, we
-	 * assess the aggregate resource states this CPU's tasks
-	 * have been in since the last change, and account any
-	 * SOME and FULL time these may have resulted in.
-	 */
-	write_seqcount_begin(&groupc->seq);
-	now = cpu_clock(cpu);
-
 	/*
 	 * Start with TSK_ONCPU, which doesn't have a corresponding
 	 * task count - it's just a boolean flag directly encoded in
@@ -843,7 +851,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
 
 		groupc->state_mask = state_mask;
 
-		write_seqcount_end(&groupc->seq);
 		return;
 	}
 
@@ -864,8 +871,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
 
 	groupc->state_mask = state_mask;
 
-	write_seqcount_end(&groupc->seq);
-
 	if (state_mask & group->rtpoll_states)
 		psi_schedule_rtpoll_work(group, 1, false);
 
@@ -900,24 +905,29 @@ static void psi_flags_change(struct task_struct *task, int clear, int set)
 void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
-	struct psi_group *group;
+	u64 now;
 
 	if (!task->pid)
 		return;
 
 	psi_flags_change(task, clear, set);
 
-	group = task_psi_group(task);
-	do {
-		psi_group_change(group, cpu, clear, set, true);
-	} while ((group = group->parent));
+	psi_write_begin(cpu);
+	now = cpu_clock(cpu);
+	for_each_group(group, task_psi_group(task))
+		psi_group_change(group, cpu, clear, set, now, true);
+	psi_write_end(cpu);
 }
 
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep)
 {
-	struct psi_group *group, *common = NULL;
+	struct psi_group *common = NULL;
 	int cpu = task_cpu(prev);
+	u64 now;
+
+	psi_write_begin(cpu);
+	now = cpu_clock(cpu);
 
 	if (next->pid) {
 		psi_flags_change(next, 0, TSK_ONCPU);
@@ -926,16 +936,15 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 * ancestors with @prev, those will already have @prev's
 		 * TSK_ONCPU bit set, and we can stop the iteration there.
 		 */
-		group = task_psi_group(next);
-		do {
-			if (per_cpu_ptr(group->pcpu, cpu)->state_mask &
-			    PSI_ONCPU) {
+		for_each_group(group, task_psi_group(next)) {
+			struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
+
+			if (groupc->state_mask & PSI_ONCPU) {
 				common = group;
 				break;
 			}
-
-			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
-		} while ((group = group->parent));
+			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true);
+		}
 	}
 
 	if (prev->pid) {
@@ -968,12 +977,11 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 
 		psi_flags_change(prev, clear, set);
 
-		group = task_psi_group(prev);
-		do {
+		for_each_group(group, task_psi_group(prev)) {
 			if (group == common)
 				break;
-			psi_group_change(group, cpu, clear, set, wake_clock);
-		} while ((group = group->parent));
+			psi_group_change(group, cpu, clear, set, now, wake_clock);
+		}
 
 		/*
 		 * TSK_ONCPU is handled up to the common ancestor. If there are
@@ -983,20 +991,21 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 */
 		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
 			clear &= ~TSK_ONCPU;
-			for (; group; group = group->parent)
-				psi_group_change(group, cpu, clear, set, wake_clock);
+			for_each_group(group, common)
+				psi_group_change(group, cpu, clear, set, now, wake_clock);
 		}
 	}
+	psi_write_end(cpu);
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev)
 {
 	int cpu = task_cpu(curr);
-	struct psi_group *group;
 	struct psi_group_cpu *groupc;
 	s64 delta;
 	u64 irq;
+	u64 now;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
@@ -1005,8 +1014,7 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 		return;
 
 	lockdep_assert_rq_held(rq);
-	group = task_psi_group(curr);
-	if (prev && task_psi_group(prev) == group)
+	if (prev && task_psi_group(prev) == task_psi_group(curr))
 		return;
 
 	irq = irq_time_read(cpu);
@@ -1015,25 +1023,22 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 		return;
 	rq->psi_irq_time = irq;
 
-	do {
-		u64 now;
+	psi_write_begin(cpu);
+	now = cpu_clock(cpu);
 
+	for_each_group(group, task_psi_group(curr)) {
 		if (!group->enabled)
 			continue;
 
 		groupc = per_cpu_ptr(group->pcpu, cpu);
 
-		write_seqcount_begin(&groupc->seq);
-		now = cpu_clock(cpu);
-
 		record_times(groupc, now);
 		groupc->times[PSI_IRQ_FULL] += delta;
 
-		write_seqcount_end(&groupc->seq);
-
 		if (group->rtpoll_states & (1 << PSI_IRQ_FULL))
 			psi_schedule_rtpoll_work(group, 1, false);
-	} while ((group = group->parent));
+	}
+	psi_write_end(cpu);
 }
 #endif
 
@@ -1221,12 +1226,14 @@ void psi_cgroup_restart(struct psi_group *group)
 		return;
 
 	for_each_possible_cpu(cpu) {
-		struct rq *rq = cpu_rq(cpu);
-		struct rq_flags rf;
+		u64 now;
 
-		rq_lock_irq(rq, &rf);
-		psi_group_change(group, cpu, 0, 0, true);
-		rq_unlock_irq(rq, &rf);
+		guard(rq_lock_irq)(cpu_rq(cpu));
+
+		psi_write_begin(cpu);
+		now = cpu_clock(cpu);
+		psi_group_change(group, cpu, 0, 0, now, true);
+		psi_write_end(cpu);
 	}
 }
 #endif /* CONFIG_CGROUPS */
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 314ffc143039..acb0c971a408 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -117,12 +117,15 @@ static int preemptirq_delay_run(void *data)
 {
 	int i;
 	int s = MIN(burst_size, NR_TEST_FUNCS);
-	struct cpumask cpu_mask;
+	cpumask_var_t cpu_mask;
+
+	if (!alloc_cpumask_var(&cpu_mask, GFP_KERNEL))
+		return -ENOMEM;
 
 	if (cpu_affinity > -1) {
-		cpumask_clear(&cpu_mask);
-		cpumask_set_cpu(cpu_affinity, &cpu_mask);
-		if (set_cpus_allowed_ptr(current, &cpu_mask))
+		cpumask_clear(cpu_mask);
+		cpumask_set_cpu(cpu_affinity, cpu_mask);
+		if (set_cpus_allowed_ptr(current, cpu_mask))
 			pr_err("cpu_affinity:%d, failed\n", cpu_affinity);
 	}
 
@@ -139,6 +142,8 @@ static int preemptirq_delay_run(void *data)
 
 	__set_current_state(TASK_RUNNING);
 
+	free_cpumask_var(cpu_mask);
+
 	return 0;
 }
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6ab740d3185b..95641a46db4c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5813,24 +5813,20 @@ ring_buffer_consume(struct trace_buffer *buffer, int cpu, u64 *ts,
 EXPORT_SYMBOL_GPL(ring_buffer_consume);
 
 /**
- * ring_buffer_read_prepare - Prepare for a non consuming read of the buffer
+ * ring_buffer_read_start - start a non consuming read of the buffer
  * @buffer: The ring buffer to read from
  * @cpu: The cpu buffer to iterate over
  * @flags: gfp flags to use for memory allocation
  *
- * This performs the initial preparations necessary to iterate
- * through the buffer.  Memory is allocated, buffer resizing
- * is disabled, and the iterator pointer is returned to the caller.
- *
- * After a sequence of ring_buffer_read_prepare calls, the user is
- * expected to make at least one call to ring_buffer_read_prepare_sync.
- * Afterwards, ring_buffer_read_start is invoked to get things going
- * for real.
+ * This creates an iterator to allow non-consuming iteration through
+ * the buffer. If the buffer is disabled for writing, it will produce
+ * the same information each time, but if the buffer is still writing
+ * then the first hit of a write will cause the iteration to stop.
  *
- * This overall must be paired with ring_buffer_read_finish.
+ * Must be paired with ring_buffer_read_finish.
  */
 struct ring_buffer_iter *
-ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
+ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_iter *iter;
@@ -5856,51 +5852,12 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
 
 	atomic_inc(&cpu_buffer->resize_disabled);
 
-	return iter;
-}
-EXPORT_SYMBOL_GPL(ring_buffer_read_prepare);
-
-/**
- * ring_buffer_read_prepare_sync - Synchronize a set of prepare calls
- *
- * All previously invoked ring_buffer_read_prepare calls to prepare
- * iterators will be synchronized.  Afterwards, read_buffer_read_start
- * calls on those iterators are allowed.
- */
-void
-ring_buffer_read_prepare_sync(void)
-{
-	synchronize_rcu();
-}
-EXPORT_SYMBOL_GPL(ring_buffer_read_prepare_sync);
-
-/**
- * ring_buffer_read_start - start a non consuming read of the buffer
- * @iter: The iterator returned by ring_buffer_read_prepare
- *
- * This finalizes the startup of an iteration through the buffer.
- * The iterator comes from a call to ring_buffer_read_prepare and
- * an intervening ring_buffer_read_prepare_sync must have been
- * performed.
- *
- * Must be paired with ring_buffer_read_finish.
- */
-void
-ring_buffer_read_start(struct ring_buffer_iter *iter)
-{
-	struct ring_buffer_per_cpu *cpu_buffer;
-	unsigned long flags;
-
-	if (!iter)
-		return;
-
-	cpu_buffer = iter->cpu_buffer;
-
-	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 	arch_spin_lock(&cpu_buffer->lock);
 	rb_iter_reset(iter);
 	arch_spin_unlock(&cpu_buffer->lock);
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+	return iter;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_start);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2dc5cfecb016..801def692f92 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4648,21 +4648,15 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {
 			iter->buffer_iter[cpu] =
-				ring_buffer_read_prepare(iter->array_buffer->buffer,
-							 cpu, GFP_KERNEL);
-		}
-		ring_buffer_read_prepare_sync();
-		for_each_tracing_cpu(cpu) {
-			ring_buffer_read_start(iter->buffer_iter[cpu]);
+				ring_buffer_read_start(iter->array_buffer->buffer,
+						       cpu, GFP_KERNEL);
 			tracing_iter_reset(iter, cpu);
 		}
 	} else {
 		cpu = iter->cpu_file;
 		iter->buffer_iter[cpu] =
-			ring_buffer_read_prepare(iter->array_buffer->buffer,
-						 cpu, GFP_KERNEL);
-		ring_buffer_read_prepare_sync();
-		ring_buffer_read_start(iter->buffer_iter[cpu]);
+			ring_buffer_read_start(iter->array_buffer->buffer,
+					       cpu, GFP_KERNEL);
 		tracing_iter_reset(iter, cpu);
 	}
 
diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 59857a1ee44c..628c25693cef 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -43,17 +43,15 @@ static void ftrace_dump_buf(int skip_entries, long cpu_file)
 	if (cpu_file == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {
 			iter.buffer_iter[cpu] =
-			ring_buffer_read_prepare(iter.array_buffer->buffer,
-						 cpu, GFP_ATOMIC);
-			ring_buffer_read_start(iter.buffer_iter[cpu]);
+			ring_buffer_read_start(iter.array_buffer->buffer,
+					       cpu, GFP_ATOMIC);
 			tracing_iter_reset(&iter, cpu);
 		}
 	} else {
 		iter.cpu_file = cpu_file;
 		iter.buffer_iter[cpu_file] =
-			ring_buffer_read_prepare(iter.array_buffer->buffer,
+			ring_buffer_read_start(iter.array_buffer->buffer,
 						 cpu_file, GFP_ATOMIC);
-		ring_buffer_read_start(iter.buffer_iter[cpu_file]);
 		tracing_iter_reset(&iter, cpu_file);
 	}
 
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 696406939be5..78f4c4255358 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -212,7 +212,7 @@ void put_ucounts(struct ucounts *ucounts)
 	}
 }
 
-static inline bool atomic_long_inc_below(atomic_long_t *v, int u)
+static inline bool atomic_long_inc_below(atomic_long_t *v, long u)
 {
 	long c, old;
 	c = atomic_long_read(v);
diff --git a/mm/hmm.c b/mm/hmm.c
index 7e0229ae4a5a..a67776aeb019 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -173,6 +173,7 @@ static inline unsigned long hmm_pfn_flags_order(unsigned long order)
 	return order << HMM_PFN_ORDER_SHIFT;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline unsigned long pmd_to_hmm_pfn_flags(struct hmm_range *range,
 						 pmd_t pmd)
 {
@@ -183,7 +184,6 @@ static inline unsigned long pmd_to_hmm_pfn_flags(struct hmm_range *range,
 	       hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 			      unsigned long end, unsigned long hmm_pfns[],
 			      pmd_t pmd)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index b0a9071cfe1d..c02493d9c7be 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3237,43 +3237,30 @@ static unsigned long read_swap_header(struct swap_info_struct *si,
 #define SWAP_CLUSTER_COLS						\
 	max_t(unsigned int, SWAP_CLUSTER_INFO_COLS, SWAP_CLUSTER_SPACE_COLS)
 
-static int setup_swap_map_and_extents(struct swap_info_struct *si,
-					union swap_header *swap_header,
-					unsigned char *swap_map,
-					unsigned long maxpages,
-					sector_t *span)
+static int setup_swap_map(struct swap_info_struct *si,
+			  union swap_header *swap_header,
+			  unsigned char *swap_map,
+			  unsigned long maxpages)
 {
-	unsigned int nr_good_pages;
 	unsigned long i;
-	int nr_extents;
-
-	nr_good_pages = maxpages - 1;	/* omit header page */
 
+	swap_map[0] = SWAP_MAP_BAD; /* omit header page */
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
 		unsigned int page_nr = swap_header->info.badpages[i];
 		if (page_nr == 0 || page_nr > swap_header->info.last_page)
 			return -EINVAL;
 		if (page_nr < maxpages) {
 			swap_map[page_nr] = SWAP_MAP_BAD;
-			nr_good_pages--;
+			si->pages--;
 		}
 	}
 
-	if (nr_good_pages) {
-		swap_map[0] = SWAP_MAP_BAD;
-		si->max = maxpages;
-		si->pages = nr_good_pages;
-		nr_extents = setup_swap_extents(si, span);
-		if (nr_extents < 0)
-			return nr_extents;
-		nr_good_pages = si->pages;
-	}
-	if (!nr_good_pages) {
+	if (!si->pages) {
 		pr_warn("Empty swap-file\n");
 		return -EINVAL;
 	}
 
-	return nr_extents;
+	return 0;
 }
 
 static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
@@ -3318,13 +3305,17 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	 * Mark unusable pages as unavailable. The clusters aren't
 	 * marked free yet, so no list operations are involved yet.
 	 *
-	 * See setup_swap_map_and_extents(): header page, bad pages,
+	 * See setup_swap_map(): header page, bad pages,
 	 * and the EOF part of the last cluster.
 	 */
 	inc_cluster_info_page(si, cluster_info, 0);
-	for (i = 0; i < swap_header->info.nr_badpages; i++)
-		inc_cluster_info_page(si, cluster_info,
-				      swap_header->info.badpages[i]);
+	for (i = 0; i < swap_header->info.nr_badpages; i++) {
+		unsigned int page_nr = swap_header->info.badpages[i];
+
+		if (page_nr >= maxpages)
+			continue;
+		inc_cluster_info_page(si, cluster_info, page_nr);
+	}
 	for (i = maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i++)
 		inc_cluster_info_page(si, cluster_info, i);
 
@@ -3456,6 +3447,21 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
+	si->max = maxpages;
+	si->pages = maxpages - 1;
+	nr_extents = setup_swap_extents(si, &span);
+	if (nr_extents < 0) {
+		error = nr_extents;
+		goto bad_swap_unlock_inode;
+	}
+	if (si->pages != si->max - 1) {
+		pr_err("swap:%u != (max:%u - 1)\n", si->pages, si->max);
+		error = -EINVAL;
+		goto bad_swap_unlock_inode;
+	}
+
+	maxpages = si->max;
+
 	/* OK, set up the swap map and apply the bad block list */
 	swap_map = vzalloc(maxpages);
 	if (!swap_map) {
@@ -3467,12 +3473,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (error)
 		goto bad_swap_unlock_inode;
 
-	nr_extents = setup_swap_map_and_extents(si, swap_header, swap_map,
-						maxpages, &span);
-	if (unlikely(nr_extents < 0)) {
-		error = nr_extents;
+	error = setup_swap_map(si, swap_header, swap_map, maxpages);
+	if (error)
 		goto bad_swap_unlock_inode;
-	}
 
 	/*
 	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b7dcebc70189..38643ffa65a9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6221,6 +6221,11 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
 
 static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 {
+	u16 pdu_type = evt_type & ~LE_EXT_ADV_DATA_STATUS_MASK;
+
+	if (!pdu_type)
+		return LE_ADV_NONCONN_IND;
+
 	if (evt_type & LE_EXT_ADV_LEGACY_PDU) {
 		switch (evt_type) {
 		case LE_LEGACY_ADV_IND:
@@ -6252,8 +6257,7 @@ static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 	if (evt_type & LE_EXT_ADV_SCAN_IND)
 		return LE_ADV_SCAN_IND;
 
-	if (evt_type == LE_EXT_ADV_NON_CONN_IND ||
-	    evt_type & LE_EXT_ADV_DIRECT_IND)
+	if (evt_type & LE_EXT_ADV_DIRECT_IND)
 		return LE_ADV_NONCONN_IND;
 
 invalid:
diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
index 20139fa1be1f..06b604cf9d58 100644
--- a/net/caif/cfctrl.c
+++ b/net/caif/cfctrl.c
@@ -351,17 +351,154 @@ int cfctrl_cancel_req(struct cflayer *layr, struct cflayer *adap_layer)
 	return found;
 }
 
+static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp)
+{
+	u8 len;
+	u8 linkid = 0;
+	enum cfctrl_srv serv;
+	enum cfctrl_srv servtype;
+	u8 endpoint;
+	u8 physlinkid;
+	u8 prio;
+	u8 tmp;
+	u8 *cp;
+	int i;
+	struct cfctrl_link_param linkparam;
+	struct cfctrl_request_info rsp, *req;
+
+	memset(&linkparam, 0, sizeof(linkparam));
+
+	tmp = cfpkt_extr_head_u8(pkt);
+
+	serv = tmp & CFCTRL_SRV_MASK;
+	linkparam.linktype = serv;
+
+	servtype = tmp >> 4;
+	linkparam.chtype = servtype;
+
+	tmp = cfpkt_extr_head_u8(pkt);
+	physlinkid = tmp & 0x07;
+	prio = tmp >> 3;
+
+	linkparam.priority = prio;
+	linkparam.phyid = physlinkid;
+	endpoint = cfpkt_extr_head_u8(pkt);
+	linkparam.endpoint = endpoint & 0x03;
+
+	switch (serv) {
+	case CFCTRL_SRV_VEI:
+	case CFCTRL_SRV_DBG:
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+		break;
+	case CFCTRL_SRV_VIDEO:
+		tmp = cfpkt_extr_head_u8(pkt);
+		linkparam.u.video.connid = tmp;
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+		break;
+
+	case CFCTRL_SRV_DATAGRAM:
+		linkparam.u.datagram.connid = cfpkt_extr_head_u32(pkt);
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+		break;
+	case CFCTRL_SRV_RFM:
+		/* Construct a frame, convert
+		 * DatagramConnectionID
+		 * to network format long and copy it out...
+		 */
+		linkparam.u.rfm.connid = cfpkt_extr_head_u32(pkt);
+		cp = (u8 *) linkparam.u.rfm.volume;
+		for (tmp = cfpkt_extr_head_u8(pkt);
+		     cfpkt_more(pkt) && tmp != '\0';
+		     tmp = cfpkt_extr_head_u8(pkt))
+			*cp++ = tmp;
+		*cp = '\0';
+
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+
+		break;
+	case CFCTRL_SRV_UTIL:
+		/* Construct a frame, convert
+		 * DatagramConnectionID
+		 * to network format long and copy it out...
+		 */
+		/* Fifosize KB */
+		linkparam.u.utility.fifosize_kb = cfpkt_extr_head_u16(pkt);
+		/* Fifosize bufs */
+		linkparam.u.utility.fifosize_bufs = cfpkt_extr_head_u16(pkt);
+		/* name */
+		cp = (u8 *) linkparam.u.utility.name;
+		caif_assert(sizeof(linkparam.u.utility.name)
+			     >= UTILITY_NAME_LENGTH);
+		for (i = 0; i < UTILITY_NAME_LENGTH && cfpkt_more(pkt); i++) {
+			tmp = cfpkt_extr_head_u8(pkt);
+			*cp++ = tmp;
+		}
+		/* Length */
+		len = cfpkt_extr_head_u8(pkt);
+		linkparam.u.utility.paramlen = len;
+		/* Param Data */
+		cp = linkparam.u.utility.params;
+		while (cfpkt_more(pkt) && len--) {
+			tmp = cfpkt_extr_head_u8(pkt);
+			*cp++ = tmp;
+		}
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+		/* Length */
+		len = cfpkt_extr_head_u8(pkt);
+		/* Param Data */
+		cfpkt_extr_head(pkt, NULL, len);
+		break;
+	default:
+		pr_warn("Request setup, invalid type (%d)\n", serv);
+		return -1;
+	}
+
+	rsp.cmd = CFCTRL_CMD_LINK_SETUP;
+	rsp.param = linkparam;
+	spin_lock_bh(&cfctrl->info_list_lock);
+	req = cfctrl_remove_req(cfctrl, &rsp);
+
+	if (CFCTRL_ERR_BIT == (CFCTRL_ERR_BIT & cmdrsp) ||
+		cfpkt_erroneous(pkt)) {
+		pr_err("Invalid O/E bit or parse error "
+				"on CAIF control channel\n");
+		cfctrl->res.reject_rsp(cfctrl->serv.layer.up, 0,
+				       req ? req->client_layer : NULL);
+	} else {
+		cfctrl->res.linksetup_rsp(cfctrl->serv.layer.up, linkid,
+					  serv, physlinkid,
+					  req ?  req->client_layer : NULL);
+	}
+
+	kfree(req);
+
+	spin_unlock_bh(&cfctrl->info_list_lock);
+
+	return 0;
+}
+
 static int cfctrl_recv(struct cflayer *layer, struct cfpkt *pkt)
 {
 	u8 cmdrsp;
 	u8 cmd;
-	int ret = -1;
-	u8 len;
-	u8 param[255];
+	int ret = 0;
 	u8 linkid = 0;
 	struct cfctrl *cfctrl = container_obj(layer);
-	struct cfctrl_request_info rsp, *req;
-
 
 	cmdrsp = cfpkt_extr_head_u8(pkt);
 	cmd = cmdrsp & CFCTRL_CMD_MASK;
@@ -374,150 +511,7 @@ static int cfctrl_recv(struct cflayer *layer, struct cfpkt *pkt)
 
 	switch (cmd) {
 	case CFCTRL_CMD_LINK_SETUP:
-		{
-			enum cfctrl_srv serv;
-			enum cfctrl_srv servtype;
-			u8 endpoint;
-			u8 physlinkid;
-			u8 prio;
-			u8 tmp;
-			u8 *cp;
-			int i;
-			struct cfctrl_link_param linkparam;
-			memset(&linkparam, 0, sizeof(linkparam));
-
-			tmp = cfpkt_extr_head_u8(pkt);
-
-			serv = tmp & CFCTRL_SRV_MASK;
-			linkparam.linktype = serv;
-
-			servtype = tmp >> 4;
-			linkparam.chtype = servtype;
-
-			tmp = cfpkt_extr_head_u8(pkt);
-			physlinkid = tmp & 0x07;
-			prio = tmp >> 3;
-
-			linkparam.priority = prio;
-			linkparam.phyid = physlinkid;
-			endpoint = cfpkt_extr_head_u8(pkt);
-			linkparam.endpoint = endpoint & 0x03;
-
-			switch (serv) {
-			case CFCTRL_SRV_VEI:
-			case CFCTRL_SRV_DBG:
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-				break;
-			case CFCTRL_SRV_VIDEO:
-				tmp = cfpkt_extr_head_u8(pkt);
-				linkparam.u.video.connid = tmp;
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-				break;
-
-			case CFCTRL_SRV_DATAGRAM:
-				linkparam.u.datagram.connid =
-				    cfpkt_extr_head_u32(pkt);
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-				break;
-			case CFCTRL_SRV_RFM:
-				/* Construct a frame, convert
-				 * DatagramConnectionID
-				 * to network format long and copy it out...
-				 */
-				linkparam.u.rfm.connid =
-				    cfpkt_extr_head_u32(pkt);
-				cp = (u8 *) linkparam.u.rfm.volume;
-				for (tmp = cfpkt_extr_head_u8(pkt);
-				     cfpkt_more(pkt) && tmp != '\0';
-				     tmp = cfpkt_extr_head_u8(pkt))
-					*cp++ = tmp;
-				*cp = '\0';
-
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-
-				break;
-			case CFCTRL_SRV_UTIL:
-				/* Construct a frame, convert
-				 * DatagramConnectionID
-				 * to network format long and copy it out...
-				 */
-				/* Fifosize KB */
-				linkparam.u.utility.fifosize_kb =
-				    cfpkt_extr_head_u16(pkt);
-				/* Fifosize bufs */
-				linkparam.u.utility.fifosize_bufs =
-				    cfpkt_extr_head_u16(pkt);
-				/* name */
-				cp = (u8 *) linkparam.u.utility.name;
-				caif_assert(sizeof(linkparam.u.utility.name)
-					     >= UTILITY_NAME_LENGTH);
-				for (i = 0;
-				     i < UTILITY_NAME_LENGTH
-				     && cfpkt_more(pkt); i++) {
-					tmp = cfpkt_extr_head_u8(pkt);
-					*cp++ = tmp;
-				}
-				/* Length */
-				len = cfpkt_extr_head_u8(pkt);
-				linkparam.u.utility.paramlen = len;
-				/* Param Data */
-				cp = linkparam.u.utility.params;
-				while (cfpkt_more(pkt) && len--) {
-					tmp = cfpkt_extr_head_u8(pkt);
-					*cp++ = tmp;
-				}
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-				/* Length */
-				len = cfpkt_extr_head_u8(pkt);
-				/* Param Data */
-				cfpkt_extr_head(pkt, &param, len);
-				break;
-			default:
-				pr_warn("Request setup, invalid type (%d)\n",
-					serv);
-				goto error;
-			}
-
-			rsp.cmd = cmd;
-			rsp.param = linkparam;
-			spin_lock_bh(&cfctrl->info_list_lock);
-			req = cfctrl_remove_req(cfctrl, &rsp);
-
-			if (CFCTRL_ERR_BIT == (CFCTRL_ERR_BIT & cmdrsp) ||
-				cfpkt_erroneous(pkt)) {
-				pr_err("Invalid O/E bit or parse error "
-						"on CAIF control channel\n");
-				cfctrl->res.reject_rsp(cfctrl->serv.layer.up,
-						       0,
-						       req ? req->client_layer
-						       : NULL);
-			} else {
-				cfctrl->res.linksetup_rsp(cfctrl->serv.
-							  layer.up, linkid,
-							  serv, physlinkid,
-							  req ? req->
-							  client_layer : NULL);
-			}
-
-			kfree(req);
-
-			spin_unlock_bh(&cfctrl->info_list_lock);
-		}
+		ret = cfctrl_link_setup(cfctrl, pkt, cmdrsp);
 		break;
 	case CFCTRL_CMD_LINK_DESTROY:
 		linkid = cfpkt_extr_head_u8(pkt);
@@ -544,9 +538,9 @@ static int cfctrl_recv(struct cflayer *layer, struct cfpkt *pkt)
 		break;
 	default:
 		pr_err("Unrecognized Control Frame\n");
+		ret = -1;
 		goto error;
 	}
-	ret = 0;
 error:
 	cfpkt_destroy(pkt);
 	return ret;
diff --git a/net/core/dst.c b/net/core/dst.c
index 6d76b799ce64..cc990706b645 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -148,8 +148,8 @@ void dst_dev_put(struct dst_entry *dst)
 	dst->obsolete = DST_OBSOLETE_DEAD;
 	if (dst->ops->ifdown)
 		dst->ops->ifdown(dst, dev);
-	dst->input = dst_discard;
-	dst->output = dst_discard_out;
+	WRITE_ONCE(dst->input, dst_discard);
+	WRITE_ONCE(dst->output, dst_discard_out);
 	dst->dev = blackhole_netdev;
 	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
 			   GFP_ATOMIC);
diff --git a/net/core/filter.c b/net/core/filter.c
index 1c0cf6f2fff5..02fedc404d7f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9407,6 +9407,9 @@ static bool flow_dissector_is_valid_access(int off, int size,
 	if (off < 0 || off >= sizeof(struct __sk_buff))
 		return false;
 
+	if (off % size != 0)
+		return false;
+
 	if (type == BPF_WRITE)
 		return false;
 
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index e95c2933756d..87182a4272bf 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -784,6 +784,13 @@ int netpoll_setup(struct netpoll *np)
 	if (err)
 		goto put;
 	rtnl_unlock();
+
+	/* Make sure all NAPI polls which started before dev->npinfo
+	 * was visible have exited before we start calling NAPI poll.
+	 * NAPI skips locking if dev->npinfo is NULL.
+	 */
+	synchronize_rcu();
+
 	return 0;
 
 put:
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 97f52394d1eb..adb3166ede97 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -655,6 +655,13 @@ static void sk_psock_backlog(struct work_struct *work)
 	bool ingress;
 	int ret;
 
+	/* If sk is quickly removed from the map and then added back, the old
+	 * psock should not be scheduled, because there are now two psocks
+	 * pointing to the same sk.
+	 */
+	if (!sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+		return;
+
 	/* Increment the psock refcnt to synchronize with close(fd) path in
 	 * sock_map_close(), ensuring we wait for backlog thread completion
 	 * before sk_socket freed. If refcnt increment fails, it indicates
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 88d7c96bfac0..73d555593f5c 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1684,8 +1684,8 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 		else if (rt->rt_gw_family == AF_INET6)
 			new_rt->rt_gw6 = rt->rt_gw6;
 
-		new_rt->dst.input = rt->dst.input;
-		new_rt->dst.output = rt->dst.output;
+		new_rt->dst.input = READ_ONCE(rt->dst.input);
+		new_rt->dst.output = READ_ONCE(rt->dst.output);
 		new_rt->dst.error = rt->dst.error;
 		new_rt->dst.lastuse = jiffies;
 		new_rt->dst.lwtstate = lwtstate_get(rt->dst.lwtstate);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d176e7888a20..30f4375f8431 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4970,8 +4970,9 @@ static void tcp_ofo_queue(struct sock *sk)
 
 		if (before(TCP_SKB_CB(skb)->seq, dsack_high)) {
 			__u32 dsack = dsack_high;
+
 			if (before(TCP_SKB_CB(skb)->end_seq, dsack_high))
-				dsack_high = TCP_SKB_CB(skb)->end_seq;
+				dsack = TCP_SKB_CB(skb)->end_seq;
 			tcp_dsack_extend(sk, TCP_SKB_CB(skb)->seq, dsack);
 		}
 		p = rb_next(p);
@@ -5039,6 +5040,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 		return;
 	}
 
+	tcp_measure_rcv_mss(sk, skb);
 	/* Disable header prediction. */
 	tp->pred_flags = 0;
 	inet_csk_schedule_ack(sk);
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 9a1c59275a10..aa1046fbf28e 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -440,15 +440,17 @@ struct fib6_dump_arg {
 static int fib6_rt_dump(struct fib6_info *rt, struct fib6_dump_arg *arg)
 {
 	enum fib_event_type fib_event = FIB_EVENT_ENTRY_REPLACE;
+	unsigned int nsiblings;
 	int err;
 
 	if (!rt || rt == arg->net->ipv6.fib6_null_entry)
 		return 0;
 
-	if (rt->fib6_nsiblings)
+	nsiblings = READ_ONCE(rt->fib6_nsiblings);
+	if (nsiblings)
 		err = call_fib6_multipath_entry_notifier(arg->nb, fib_event,
 							 rt,
-							 rt->fib6_nsiblings,
+							 nsiblings,
 							 arg->extack);
 	else
 		err = call_fib6_entry_notifier(arg->nb, fib_event, rt,
@@ -1126,7 +1128,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 
 			if (rt6_duplicate_nexthop(iter, rt)) {
 				if (rt->fib6_nsiblings)
-					rt->fib6_nsiblings = 0;
+					WRITE_ONCE(rt->fib6_nsiblings, 0);
 				if (!(iter->fib6_flags & RTF_EXPIRES))
 					return -EEXIST;
 				if (!(rt->fib6_flags & RTF_EXPIRES)) {
@@ -1155,7 +1157,8 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 			 */
 			if (rt_can_ecmp &&
 			    rt6_qualify_for_ecmp(iter))
-				rt->fib6_nsiblings++;
+				WRITE_ONCE(rt->fib6_nsiblings,
+					   rt->fib6_nsiblings + 1);
 		}
 
 		if (iter->fib6_metric > rt->fib6_metric)
@@ -1205,7 +1208,8 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 		fib6_nsiblings = 0;
 		list_for_each_entry_safe(sibling, temp_sibling,
 					 &rt->fib6_siblings, fib6_siblings) {
-			sibling->fib6_nsiblings++;
+			WRITE_ONCE(sibling->fib6_nsiblings,
+				   sibling->fib6_nsiblings + 1);
 			BUG_ON(sibling->fib6_nsiblings != rt->fib6_nsiblings);
 			fib6_nsiblings++;
 		}
@@ -1250,8 +1254,9 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 				list_for_each_entry_safe(sibling, next_sibling,
 							 &rt->fib6_siblings,
 							 fib6_siblings)
-					sibling->fib6_nsiblings--;
-				rt->fib6_nsiblings = 0;
+					WRITE_ONCE(sibling->fib6_nsiblings,
+						   sibling->fib6_nsiblings - 1);
+				WRITE_ONCE(rt->fib6_nsiblings, 0);
 				list_del_rcu(&rt->fib6_siblings);
 				rt6_multipath_rebalance(next_sibling);
 				return err;
@@ -1968,8 +1973,9 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 			notify_del = true;
 		list_for_each_entry_safe(sibling, next_sibling,
 					 &rt->fib6_siblings, fib6_siblings)
-			sibling->fib6_nsiblings--;
-		rt->fib6_nsiblings = 0;
+			WRITE_ONCE(sibling->fib6_nsiblings,
+				   sibling->fib6_nsiblings - 1);
+		WRITE_ONCE(rt->fib6_nsiblings, 0);
 		list_del_rcu(&rt->fib6_siblings);
 		rt6_multipath_rebalance(next_sibling);
 	}
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 9822163428b0..fce91183797a 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -148,7 +148,9 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 
 	ops = rcu_dereference(inet6_offloads[proto]);
 	if (likely(ops && ops->callbacks.gso_segment)) {
-		skb_reset_transport_header(skb);
+		if (!skb_reset_transport_header_careful(skb))
+			goto out;
+
 		segs = ops->callbacks.gso_segment(skb, features);
 		if (!segs)
 			skb->network_header = skb_mac_header(skb) + nhoff - skb->head;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 440048d609c3..68bc518500f9 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2032,6 +2032,7 @@ static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
 			  struct sk_buff *skb, int vifi)
 {
 	struct vif_device *vif = &mrt->vif_table[vifi];
+	struct net_device *indev = skb->dev;
 	struct net_device *vif_dev;
 	struct ipv6hdr *ipv6h;
 	struct dst_entry *dst;
@@ -2094,7 +2095,7 @@ static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
 	IP6CB(skb)->flags |= IP6SKB_FORWARDED;
 
 	return NF_HOOK(NFPROTO_IPV6, NF_INET_FORWARD,
-		       net, NULL, skb, skb->dev, vif_dev,
+		       net, NULL, skb, indev, skb->dev,
 		       ip6mr_forward2_finish);
 
 out_free:
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index d9ab070e78e0..22866444efc0 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5240,7 +5240,8 @@ static void ip6_route_mpath_notify(struct fib6_info *rt,
 	 */
 	rcu_read_lock();
 
-	if ((nlflags & NLM_F_APPEND) && rt_last && rt_last->fib6_nsiblings) {
+	if ((nlflags & NLM_F_APPEND) && rt_last &&
+	    READ_ONCE(rt_last->fib6_nsiblings)) {
 		rt = list_first_or_null_rcu(&rt_last->fib6_siblings,
 					    struct fib6_info,
 					    fib6_siblings);
@@ -5587,32 +5588,34 @@ static int rt6_nh_nlmsg_size(struct fib6_nh *nh, void *arg)
 
 static size_t rt6_nlmsg_size(struct fib6_info *f6i)
 {
+	struct fib6_info *sibling;
+	struct fib6_nh *nh;
 	int nexthop_len;
 
 	if (f6i->nh) {
 		nexthop_len = nla_total_size(4); /* RTA_NH_ID */
 		nexthop_for_each_fib6_nh(f6i->nh, rt6_nh_nlmsg_size,
 					 &nexthop_len);
-	} else {
-		struct fib6_nh *nh = f6i->fib6_nh;
-		struct fib6_info *sibling;
-
-		nexthop_len = 0;
-		if (f6i->fib6_nsiblings) {
-			rt6_nh_nlmsg_size(nh, &nexthop_len);
-
-			rcu_read_lock();
+		goto common;
+	}
 
-			list_for_each_entry_rcu(sibling, &f6i->fib6_siblings,
-						fib6_siblings) {
-				rt6_nh_nlmsg_size(sibling->fib6_nh, &nexthop_len);
-			}
+	rcu_read_lock();
+retry:
+	nh = f6i->fib6_nh;
+	nexthop_len = 0;
+	if (READ_ONCE(f6i->fib6_nsiblings)) {
+		rt6_nh_nlmsg_size(nh, &nexthop_len);
 
-			rcu_read_unlock();
+		list_for_each_entry_rcu(sibling, &f6i->fib6_siblings,
+					fib6_siblings) {
+			rt6_nh_nlmsg_size(sibling->fib6_nh, &nexthop_len);
+			if (!READ_ONCE(f6i->fib6_nsiblings))
+				goto retry;
 		}
-		nexthop_len += lwtunnel_get_encap_size(nh->fib_nh_lws);
 	}
-
+	rcu_read_unlock();
+	nexthop_len += lwtunnel_get_encap_size(nh->fib_nh_lws);
+common:
 	return NLMSG_ALIGN(sizeof(struct rtmsg))
 	       + nla_total_size(16) /* RTA_SRC */
 	       + nla_total_size(16) /* RTA_DST */
@@ -5771,7 +5774,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 		if (dst->lwtstate &&
 		    lwtunnel_fill_encap(skb, dst->lwtstate, RTA_ENCAP, RTA_ENCAP_TYPE) < 0)
 			goto nla_put_failure;
-	} else if (rt->fib6_nsiblings) {
+	} else if (READ_ONCE(rt->fib6_nsiblings)) {
 		struct fib6_info *sibling;
 		struct nlattr *mp;
 
@@ -5873,16 +5876,21 @@ static bool fib6_info_uses_dev(const struct fib6_info *f6i,
 	if (f6i->fib6_nh->fib_nh_dev == dev)
 		return true;
 
-	if (f6i->fib6_nsiblings) {
-		struct fib6_info *sibling, *next_sibling;
+	if (READ_ONCE(f6i->fib6_nsiblings)) {
+		const struct fib6_info *sibling;
 
-		list_for_each_entry_safe(sibling, next_sibling,
-					 &f6i->fib6_siblings, fib6_siblings) {
-			if (sibling->fib6_nh->fib_nh_dev == dev)
+		rcu_read_lock();
+		list_for_each_entry_rcu(sibling, &f6i->fib6_siblings,
+					fib6_siblings) {
+			if (sibling->fib6_nh->fib_nh_dev == dev) {
+				rcu_read_unlock();
 				return true;
+			}
+			if (!READ_ONCE(f6i->fib6_nsiblings))
+				break;
 		}
+		rcu_read_unlock();
 	}
-
 	return false;
 }
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index cf2b8a05c338..a72c1d9edb4a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1078,13 +1078,13 @@ ieee80211_copy_rnr_beacon(u8 *pos, struct cfg80211_rnr_elems *dst,
 {
 	int i, offset = 0;
 
+	dst->cnt = src->cnt;
 	for (i = 0; i < src->cnt; i++) {
 		memcpy(pos + offset, src->elem[i].data, src->elem[i].len);
 		dst->elem[i].len = src->elem[i].len;
 		dst->elem[i].data = pos + offset;
 		offset += dst->elem[i].len;
 	}
-	dst->cnt = src->cnt;
 
 	return offset;
 }
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index f07b40916485..1cb42c5b9b04 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1421,7 +1421,7 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 	if (!(wiphy->flags & WIPHY_FLAG_SUPPORTS_TDLS))
 		return -EOPNOTSUPP;
 
-	if (sdata->vif.type != NL80211_IFTYPE_STATION)
+	if (sdata->vif.type != NL80211_IFTYPE_STATION || !sdata->vif.cfg.assoc)
 		return -EINVAL;
 
 	switch (oper) {
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 00c309e7768e..9c515fb8ebe1 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -622,6 +622,12 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 	else
 		tx->key = NULL;
 
+	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
+		if (tx->key && tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)
+			info->control.hw_key = &tx->key->conf;
+		return TX_CONTINUE;
+	}
+
 	if (tx->key) {
 		bool skip_hw = false;
 
@@ -1437,7 +1443,7 @@ static void ieee80211_txq_enqueue(struct ieee80211_local *local,
 {
 	struct fq *fq = &local->fq;
 	struct fq_tin *tin = &txqi->tin;
-	u32 flow_idx = fq_flow_idx(fq, skb);
+	u32 flow_idx;
 
 	ieee80211_set_skb_enqueue_time(skb);
 
@@ -1453,6 +1459,7 @@ static void ieee80211_txq_enqueue(struct ieee80211_local *local,
 			IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
 		__skb_queue_tail(&txqi->frags, skb);
 	} else {
+		flow_idx = fq_flow_idx(fq, skb);
 		fq_tin_enqueue(fq, tin, flow_idx, skb,
 			       fq_skb_free_func);
 	}
@@ -3885,6 +3892,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	 * The key can be removed while the packet was queued, so need to call
 	 * this here to get the current key.
 	 */
+	info->control.hw_key = NULL;
 	r = ieee80211_tx_h_select_key(&tx);
 	if (r != TX_CONTINUE) {
 		ieee80211_free_txskb(&local->hw, skb);
@@ -4106,7 +4114,9 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
 
 	spin_lock_bh(&local->active_txq_lock[txq->ac]);
 
-	has_queue = force || txq_has_queue(txq);
+	has_queue = force ||
+		    (!test_bit(IEEE80211_TXQ_STOP, &txqi->flags) &&
+		     txq_has_queue(txq));
 	if (list_empty(&txqi->schedule_order) &&
 	    (has_queue || ieee80211_txq_keep_active(txqi))) {
 		/* If airtime accounting is active, always enqueue STAs at the
diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 3d64a4511fcf..b5e4ca9026a8 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -17,7 +17,7 @@ static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
 		.skb = skb,
 	};
 
-	return bpf_prog_run(prog, &ctx);
+	return bpf_prog_run_pin_on_cpu(prog, &ctx);
 }
 
 struct bpf_nf_link {
@@ -295,6 +295,9 @@ static bool nf_is_valid_access(int off, int size, enum bpf_access_type type,
 	if (off < 0 || off >= sizeof(struct bpf_nf_ctx))
 		return false;
 
+	if (off % size != 0)
+		return false;
+
 	if (type == BPF_WRITE)
 		return false;
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index bdee187bc5dd..3743e4249dc8 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1029,11 +1029,6 @@ static int nf_tables_fill_table_info(struct sk_buff *skb, struct net *net,
 			 NFTA_TABLE_PAD))
 		goto nla_put_failure;
 
-	if (event == NFT_MSG_DELTABLE) {
-		nlmsg_end(skb, nlh);
-		return 0;
-	}
-
 	if (nla_put_be32(skb, NFTA_TABLE_FLAGS,
 			 htonl(table->flags & NFT_TABLE_F_MASK)))
 		goto nla_put_failure;
@@ -1889,11 +1884,6 @@ static int nf_tables_fill_chain_info(struct sk_buff *skb, struct net *net,
 			 NFTA_CHAIN_PAD))
 		goto nla_put_failure;
 
-	if (event == NFT_MSG_DELCHAIN && !hook_list) {
-		nlmsg_end(skb, nlh);
-		return 0;
-	}
-
 	if (nft_is_base_chain(chain)) {
 		const struct nft_base_chain *basechain = nft_base_chain(chain);
 		struct nft_stats __percpu *stats;
@@ -3884,7 +3874,7 @@ void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule)
 /* can only be used if rule is no longer visible to dumps */
 static void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
-	lockdep_commit_lock_is_held(ctx->net);
+	WARN_ON_ONCE(!lockdep_commit_lock_is_held(ctx->net));
 
 	nft_rule_expr_deactivate(ctx, rule, NFT_TRANS_RELEASE);
 	nf_tables_rule_destroy(ctx, rule);
@@ -4678,11 +4668,6 @@ static int nf_tables_fill_set(struct sk_buff *skb, const struct nft_ctx *ctx,
 			 NFTA_SET_PAD))
 		goto nla_put_failure;
 
-	if (event == NFT_MSG_DELSET) {
-		nlmsg_end(skb, nlh);
-		return 0;
-	}
-
 	if (set->flags != 0)
 		if (nla_put_be32(skb, NFTA_SET_FLAGS, htonl(set->flags)))
 			goto nla_put_failure;
@@ -5674,7 +5659,7 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase)
 {
-	lockdep_commit_lock_is_held(ctx->net);
+	WARN_ON_ONCE(!lockdep_commit_lock_is_held(ctx->net));
 
 	switch (phase) {
 	case NFT_TRANS_PREPARE_ERROR:
@@ -8017,11 +8002,6 @@ static int nf_tables_fill_obj_info(struct sk_buff *skb, struct net *net,
 			 NFTA_OBJ_PAD))
 		goto nla_put_failure;
 
-	if (event == NFT_MSG_DELOBJ) {
-		nlmsg_end(skb, nlh);
-		return 0;
-	}
-
 	if (nla_put_be32(skb, NFTA_OBJ_TYPE, htonl(obj->ops->type->type)) ||
 	    nla_put_be32(skb, NFTA_OBJ_USE, htonl(obj->use)) ||
 	    nft_object_dump(skb, NFTA_OBJ_DATA, obj, reset))
@@ -9040,11 +9020,6 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 			 NFTA_FLOWTABLE_PAD))
 		goto nla_put_failure;
 
-	if (event == NFT_MSG_DELFLOWTABLE && !hook_list) {
-		nlmsg_end(skb, nlh);
-		return 0;
-	}
-
 	if (nla_put_be32(skb, NFTA_FLOWTABLE_USE, htonl(flowtable->use)) ||
 	    nla_put_be32(skb, NFTA_FLOWTABLE_FLAGS, htonl(flowtable->data.flags)))
 		goto nla_put_failure;
diff --git a/net/netfilter/xt_nfacct.c b/net/netfilter/xt_nfacct.c
index 7c6bf1c16813..0ca1cdfc4095 100644
--- a/net/netfilter/xt_nfacct.c
+++ b/net/netfilter/xt_nfacct.c
@@ -38,8 +38,8 @@ nfacct_mt_checkentry(const struct xt_mtchk_param *par)
 
 	nfacct = nfnl_acct_find_get(par->net, info->name);
 	if (nfacct == NULL) {
-		pr_info_ratelimited("accounting object `%s' does not exists\n",
-				    info->name);
+		pr_info_ratelimited("accounting object `%.*s' does not exist\n",
+				    NFACCT_NAME_MAX, info->name);
 		return -ENOENT;
 	}
 	info->nfacct = nfacct;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 19c4c1f27e58..e8589fede4d4 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4562,10 +4562,10 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 	spin_lock(&po->bind_lock);
 	was_running = packet_sock_flag(po, PACKET_SOCK_RUNNING);
 	num = po->num;
-	if (was_running) {
-		WRITE_ONCE(po->num, 0);
+	WRITE_ONCE(po->num, 0);
+	if (was_running)
 		__unregister_prot_hook(sk, false);
-	}
+
 	spin_unlock(&po->bind_lock);
 
 	synchronize_net();
@@ -4597,10 +4597,10 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 	mutex_unlock(&po->pg_vec_lock);
 
 	spin_lock(&po->bind_lock);
-	if (was_running) {
-		WRITE_ONCE(po->num, num);
+	WRITE_ONCE(po->num, num);
+	if (was_running)
 		register_prot_hook(sk);
-	}
+
 	spin_unlock(&po->bind_lock);
 	if (pg_vec && (po->tp_version > TPACKET_V2)) {
 		/* Because we don't support block-based V3 on tx-ring */
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index 5dd41a012110..ae571bfe84c7 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -44,9 +44,9 @@ static void tcf_ctinfo_dscp_set(struct nf_conn *ct, struct tcf_ctinfo *ca,
 				ipv4_change_dsfield(ip_hdr(skb),
 						    INET_ECN_MASK,
 						    newdscp);
-				ca->stats_dscp_set++;
+				atomic64_inc(&ca->stats_dscp_set);
 			} else {
-				ca->stats_dscp_error++;
+				atomic64_inc(&ca->stats_dscp_error);
 			}
 		}
 		break;
@@ -57,9 +57,9 @@ static void tcf_ctinfo_dscp_set(struct nf_conn *ct, struct tcf_ctinfo *ca,
 				ipv6_change_dsfield(ipv6_hdr(skb),
 						    INET_ECN_MASK,
 						    newdscp);
-				ca->stats_dscp_set++;
+				atomic64_inc(&ca->stats_dscp_set);
 			} else {
-				ca->stats_dscp_error++;
+				atomic64_inc(&ca->stats_dscp_error);
 			}
 		}
 		break;
@@ -72,7 +72,7 @@ static void tcf_ctinfo_cpmark_set(struct nf_conn *ct, struct tcf_ctinfo *ca,
 				  struct tcf_ctinfo_params *cp,
 				  struct sk_buff *skb)
 {
-	ca->stats_cpmark_set++;
+	atomic64_inc(&ca->stats_cpmark_set);
 	skb->mark = READ_ONCE(ct->mark) & cp->cpmarkmask;
 }
 
@@ -323,15 +323,18 @@ static int tcf_ctinfo_dump(struct sk_buff *skb, struct tc_action *a,
 	}
 
 	if (nla_put_u64_64bit(skb, TCA_CTINFO_STATS_DSCP_SET,
-			      ci->stats_dscp_set, TCA_CTINFO_PAD))
+			      atomic64_read(&ci->stats_dscp_set),
+			      TCA_CTINFO_PAD))
 		goto nla_put_failure;
 
 	if (nla_put_u64_64bit(skb, TCA_CTINFO_STATS_DSCP_ERROR,
-			      ci->stats_dscp_error, TCA_CTINFO_PAD))
+			      atomic64_read(&ci->stats_dscp_error),
+			      TCA_CTINFO_PAD))
 		goto nla_put_failure;
 
 	if (nla_put_u64_64bit(skb, TCA_CTINFO_STATS_CPMARK_SET,
-			      ci->stats_cpmark_set, TCA_CTINFO_PAD))
+			      atomic64_read(&ci->stats_cpmark_set),
+			      TCA_CTINFO_PAD))
 		goto nla_put_failure;
 
 	spin_unlock_bh(&ci->tcf_lock);
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 51d4013b6121..f3e5ef9a9592 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -152,7 +152,7 @@ static int mqprio_parse_opt(struct net_device *dev, struct tc_mqprio_qopt *qopt,
 static const struct
 nla_policy mqprio_tc_entry_policy[TCA_MQPRIO_TC_ENTRY_MAX + 1] = {
 	[TCA_MQPRIO_TC_ENTRY_INDEX]	= NLA_POLICY_MAX(NLA_U32,
-							 TC_QOPT_MAX_QUEUE),
+							 TC_QOPT_MAX_QUEUE - 1),
 	[TCA_MQPRIO_TC_ENTRY_FP]	= NLA_POLICY_RANGE(NLA_U32,
 							   TC_FP_EXPRESS,
 							   TC_FP_PREEMPTIBLE),
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 68a08f6d1fbc..2270547b51df 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -972,6 +972,41 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 	return 0;
 }
 
+static const struct Qdisc_class_ops netem_class_ops;
+
+static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
+			       struct netlink_ext_ack *extack)
+{
+	struct Qdisc *root, *q;
+	unsigned int i;
+
+	root = qdisc_root_sleeping(sch);
+
+	if (sch != root && root->ops->cl_ops == &netem_class_ops) {
+		if (duplicates ||
+		    ((struct netem_sched_data *)qdisc_priv(root))->duplicate)
+			goto err;
+	}
+
+	if (!qdisc_dev(root))
+		return 0;
+
+	hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
+		if (sch != q && q->ops->cl_ops == &netem_class_ops) {
+			if (duplicates ||
+			    ((struct netem_sched_data *)qdisc_priv(q))->duplicate)
+				goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	NL_SET_ERR_MSG(extack,
+		       "netem: cannot mix duplicating netems with other netems in tree");
+	return -EINVAL;
+}
+
 /* Parse netlink message to set options */
 static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 			struct netlink_ext_ack *extack)
@@ -1030,6 +1065,11 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	q->gap = qopt->gap;
 	q->counter = 0;
 	q->loss = qopt->loss;
+
+	ret = check_netem_in_tree(sch, qopt->duplicate, extack);
+	if (ret)
+		goto unlock;
+
 	q->duplicate = qopt->duplicate;
 
 	/* for compatibility with earlier versions.
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 3142715d7e41..1620f0fd78ce 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -43,6 +43,11 @@ static struct static_key_false taprio_have_working_mqprio;
 #define TAPRIO_SUPPORTED_FLAGS \
 	(TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST | TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
 #define TAPRIO_FLAGS_INVALID U32_MAX
+/* Minimum value for picos_per_byte to ensure non-zero duration
+ * for minimum-sized Ethernet frames (ETH_ZLEN = 60).
+ * 60 * 17 > PSEC_PER_NSEC (1000)
+ */
+#define TAPRIO_PICOS_PER_BYTE_MIN 17
 
 struct sched_entry {
 	/* Durations between this GCL entry and the GCL entry where the
@@ -1284,7 +1289,8 @@ static void taprio_start_sched(struct Qdisc *sch,
 }
 
 static void taprio_set_picos_per_byte(struct net_device *dev,
-				      struct taprio_sched *q)
+				      struct taprio_sched *q,
+				      struct netlink_ext_ack *extack)
 {
 	struct ethtool_link_ksettings ecmd;
 	int speed = SPEED_10;
@@ -1300,6 +1306,15 @@ static void taprio_set_picos_per_byte(struct net_device *dev,
 
 skip:
 	picos_per_byte = (USEC_PER_SEC * 8) / speed;
+	if (picos_per_byte < TAPRIO_PICOS_PER_BYTE_MIN) {
+		if (!extack)
+			pr_warn("Link speed %d is too high. Schedule may be inaccurate.\n",
+				speed);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Link speed %d is too high. Schedule may be inaccurate.",
+				       speed);
+		picos_per_byte = TAPRIO_PICOS_PER_BYTE_MIN;
+	}
 
 	atomic64_set(&q->picos_per_byte, picos_per_byte);
 	netdev_dbg(dev, "taprio: set %s's picos_per_byte to: %lld, linkspeed: %d\n",
@@ -1324,7 +1339,7 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
 		if (dev != qdisc_dev(q->root))
 			continue;
 
-		taprio_set_picos_per_byte(dev, q);
+		taprio_set_picos_per_byte(dev, q, NULL);
 
 		stab = rtnl_dereference(q->root->stab);
 
@@ -1848,7 +1863,7 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	q->flags = taprio_flags;
 
 	/* Needed for length_to_duration() during netlink attribute parsing */
-	taprio_set_picos_per_byte(dev, q);
+	taprio_set_picos_per_byte(dev, q, extack);
 
 	err = taprio_parse_mqprio_opt(dev, mqprio, extack, q->flags);
 	if (err < 0)
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 3bfbb789c4be..3c115936b719 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -257,20 +257,47 @@ svc_tcp_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
 }
 
 static int
-svc_tcp_sock_recv_cmsg(struct svc_sock *svsk, struct msghdr *msg)
+svc_tcp_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags)
 {
 	union {
 		struct cmsghdr	cmsg;
 		u8		buf[CMSG_SPACE(sizeof(u8))];
 	} u;
-	struct socket *sock = svsk->sk_sock;
+	u8 alert[2];
+	struct kvec alert_kvec = {
+		.iov_base = alert,
+		.iov_len = sizeof(alert),
+	};
+	struct msghdr msg = {
+		.msg_flags = *msg_flags,
+		.msg_control = &u,
+		.msg_controllen = sizeof(u),
+	};
+	int ret;
+
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
+		      alert_kvec.iov_len);
+	ret = sock_recvmsg(sock, &msg, MSG_DONTWAIT);
+	if (ret > 0 &&
+	    tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
+		iov_iter_revert(&msg.msg_iter, ret);
+		ret = svc_tcp_sock_process_cmsg(sock, &msg, &u.cmsg, -EAGAIN);
+	}
+	return ret;
+}
+
+static int
+svc_tcp_sock_recvmsg(struct svc_sock *svsk, struct msghdr *msg)
+{
 	int ret;
+	struct socket *sock = svsk->sk_sock;
 
-	msg->msg_control = &u;
-	msg->msg_controllen = sizeof(u);
 	ret = sock_recvmsg(sock, msg, MSG_DONTWAIT);
-	if (unlikely(msg->msg_controllen != sizeof(u)))
-		ret = svc_tcp_sock_process_cmsg(sock, msg, &u.cmsg, ret);
+	if (msg->msg_flags & MSG_CTRUNC) {
+		msg->msg_flags &= ~(MSG_CTRUNC | MSG_EOR);
+		if (ret == 0 || ret == -EIO)
+			ret = svc_tcp_sock_recv_cmsg(sock, &msg->msg_flags);
+	}
 	return ret;
 }
 
@@ -321,7 +348,7 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 		iov_iter_advance(&msg.msg_iter, seek);
 		buflen -= seek;
 	}
-	len = svc_tcp_sock_recv_cmsg(svsk, &msg);
+	len = svc_tcp_sock_recvmsg(svsk, &msg);
 	if (len > 0)
 		svc_flush_bvec(bvec, len, seek);
 
@@ -1019,7 +1046,7 @@ static ssize_t svc_tcp_read_marker(struct svc_sock *svsk,
 		iov.iov_base = ((char *)&svsk->sk_marker) + svsk->sk_tcplen;
 		iov.iov_len  = want;
 		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, want);
-		len = svc_tcp_sock_recv_cmsg(svsk, &msg);
+		len = svc_tcp_sock_recvmsg(svsk, &msg);
 		if (len < 0)
 			return len;
 		svsk->sk_tcplen += len;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 67d099c7c662..1397bb48cdde 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -358,7 +358,7 @@ xs_alloc_sparse_pages(struct xdr_buf *buf, size_t want, gfp_t gfp)
 
 static int
 xs_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
-		     struct cmsghdr *cmsg, int ret)
+		     unsigned int *msg_flags, struct cmsghdr *cmsg, int ret)
 {
 	u8 content_type = tls_get_record_type(sock->sk, cmsg);
 	u8 level, description;
@@ -371,7 +371,7 @@ xs_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
 		 * record, even though there might be more frames
 		 * waiting to be decrypted.
 		 */
-		msg->msg_flags &= ~MSG_EOR;
+		*msg_flags &= ~MSG_EOR;
 		break;
 	case TLS_RECORD_TYPE_ALERT:
 		tls_alert_recv(sock->sk, msg, &level, &description);
@@ -386,19 +386,33 @@ xs_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
 }
 
 static int
-xs_sock_recv_cmsg(struct socket *sock, struct msghdr *msg, int flags)
+xs_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags, int flags)
 {
 	union {
 		struct cmsghdr	cmsg;
 		u8		buf[CMSG_SPACE(sizeof(u8))];
 	} u;
+	u8 alert[2];
+	struct kvec alert_kvec = {
+		.iov_base = alert,
+		.iov_len = sizeof(alert),
+	};
+	struct msghdr msg = {
+		.msg_flags = *msg_flags,
+		.msg_control = &u,
+		.msg_controllen = sizeof(u),
+	};
 	int ret;
 
-	msg->msg_control = &u;
-	msg->msg_controllen = sizeof(u);
-	ret = sock_recvmsg(sock, msg, flags);
-	if (msg->msg_controllen != sizeof(u))
-		ret = xs_sock_process_cmsg(sock, msg, &u.cmsg, ret);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
+		      alert_kvec.iov_len);
+	ret = sock_recvmsg(sock, &msg, flags);
+	if (ret > 0 &&
+	    tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
+		iov_iter_revert(&msg.msg_iter, ret);
+		ret = xs_sock_process_cmsg(sock, &msg, msg_flags, &u.cmsg,
+					   -EAGAIN);
+	}
 	return ret;
 }
 
@@ -408,7 +422,13 @@ xs_sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags, size_t seek)
 	ssize_t ret;
 	if (seek != 0)
 		iov_iter_advance(&msg->msg_iter, seek);
-	ret = xs_sock_recv_cmsg(sock, msg, flags);
+	ret = sock_recvmsg(sock, msg, flags);
+	/* Handle TLS inband control message lazily */
+	if (msg->msg_flags & MSG_CTRUNC) {
+		msg->msg_flags &= ~(MSG_CTRUNC | MSG_EOR);
+		if (ret == 0 || ret == -EIO)
+			ret = xs_sock_recv_cmsg(sock, &msg->msg_flags, flags);
+	}
 	return ret > 0 ? ret + seek : ret;
 }
 
@@ -434,7 +454,7 @@ xs_read_discard(struct socket *sock, struct msghdr *msg, int flags,
 		size_t count)
 {
 	iov_iter_discard(&msg->msg_iter, ITER_DEST, count);
-	return xs_sock_recv_cmsg(sock, msg, flags);
+	return xs_sock_recvmsg(sock, msg, flags, 0);
 }
 
 #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 8fb5925f2389..1d7caadd0cbc 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -872,6 +872,19 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 		delta = msg->sg.size;
 		psock->eval = sk_psock_msg_verdict(sk, psock, msg);
 		delta -= msg->sg.size;
+
+		if ((s32)delta > 0) {
+			/* It indicates that we executed bpf_msg_pop_data(),
+			 * causing the plaintext data size to decrease.
+			 * Therefore the encrypted data size also needs to
+			 * correspondingly decrease. We only need to subtract
+			 * delta to calculate the new ciphertext length since
+			 * ktls does not support block encryption.
+			 */
+			struct sk_msg *enc = &ctx->open_rec->msg_encrypted;
+
+			sk_msg_trim(sk, enc, enc->sg.size - delta);
+		}
 	}
 	if (msg->cork_bytes && msg->cork_bytes > msg->sg.size &&
 	    !enospc && !full_record) {
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 08565e41b8e9..ef519b55a3d9 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -689,7 +689,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 		unsigned int i;
 
 		for (i = 0; i < MAX_PORT_RETRIES; i++) {
-			if (port <= LAST_RESERVED_PORT)
+			if (port == VMADDR_PORT_ANY ||
+			    port <= LAST_RESERVED_PORT)
 				port = LAST_RESERVED_PORT + 1;
 
 			new_addr.svm_port = port++;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4eb44821c70d..ec8265f2d568 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16789,6 +16789,7 @@ static int nl80211_set_sar_specs(struct sk_buff *skb, struct genl_info *info)
 	if (!sar_spec)
 		return -ENOMEM;
 
+	sar_spec->num_sub_specs = specs;
 	sar_spec->type = type;
 	specs = 0;
 	nla_for_each_nested(spec_list, tb[NL80211_SAR_ATTR_SPECS], rem) {
diff --git a/samples/mei/mei-amt-version.c b/samples/mei/mei-amt-version.c
index 867debd3b912..1d7254bcb44c 100644
--- a/samples/mei/mei-amt-version.c
+++ b/samples/mei/mei-amt-version.c
@@ -69,11 +69,11 @@
 #include <string.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
+#include <sys/time.h>
 #include <unistd.h>
 #include <errno.h>
 #include <stdint.h>
 #include <stdbool.h>
-#include <bits/wordsize.h>
 #include <linux/mei.h>
 
 /*****************************************************************************
diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index e260cab1c2af..4b375abda772 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -481,7 +481,7 @@ void ConfigList::updateListAllForAll()
 	while (it.hasNext()) {
 		ConfigList *list = it.next();
 
-		list->updateList();
+		list->updateListAll();
 	}
 }
 
diff --git a/security/apparmor/include/match.h b/security/apparmor/include/match.h
index 4bb0405c9190..ae31a8a631fc 100644
--- a/security/apparmor/include/match.h
+++ b/security/apparmor/include/match.h
@@ -135,17 +135,15 @@ aa_state_t aa_dfa_matchn_until(struct aa_dfa *dfa, aa_state_t start,
 
 void aa_dfa_free_kref(struct kref *kref);
 
-#define WB_HISTORY_SIZE 24
+/* This needs to be a power of 2 */
+#define WB_HISTORY_SIZE 32
 struct match_workbuf {
-	unsigned int count;
 	unsigned int pos;
 	unsigned int len;
-	unsigned int size;	/* power of 2, same as history size */
-	unsigned int history[WB_HISTORY_SIZE];
+	aa_state_t history[WB_HISTORY_SIZE];
 };
 #define DEFINE_MATCH_WB(N)		\
 struct match_workbuf N = {		\
-	.count = 0,			\
 	.pos = 0,			\
 	.len = 0,			\
 }
diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index 517d77d3c34c..12e036f8ce0f 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -624,34 +624,35 @@ aa_state_t aa_dfa_matchn_until(struct aa_dfa *dfa, aa_state_t start,
 	return state;
 }
 
-#define inc_wb_pos(wb)						\
-do {								\
+#define inc_wb_pos(wb)							\
+do {									\
+	BUILD_BUG_ON_NOT_POWER_OF_2(WB_HISTORY_SIZE);			\
 	wb->pos = (wb->pos + 1) & (WB_HISTORY_SIZE - 1);		\
-	wb->len = (wb->len + 1) & (WB_HISTORY_SIZE - 1);		\
+	wb->len = (wb->len + 1) > WB_HISTORY_SIZE ? WB_HISTORY_SIZE :	\
+				wb->len + 1;				\
 } while (0)
 
 /* For DFAs that don't support extended tagging of states */
+/* adjust is only set if is_loop returns true */
 static bool is_loop(struct match_workbuf *wb, aa_state_t state,
 		    unsigned int *adjust)
 {
-	aa_state_t pos = wb->pos;
-	aa_state_t i;
+	int pos = wb->pos;
+	int i;
 
 	if (wb->history[pos] < state)
 		return false;
 
-	for (i = 0; i <= wb->len; i++) {
+	for (i = 0; i < wb->len; i++) {
 		if (wb->history[pos] == state) {
 			*adjust = i;
 			return true;
 		}
-		if (pos == 0)
-			pos = WB_HISTORY_SIZE;
-		pos--;
+		/* -1 wraps to WB_HISTORY_SIZE - 1 */
+		pos = (pos - 1) & (WB_HISTORY_SIZE - 1);
 	}
 
-	*adjust = i;
-	return true;
+	return false;
 }
 
 static aa_state_t leftmatch_fb(struct aa_dfa *dfa, aa_state_t start,
diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index f070902da8fc..a7ac0ccc6cfe 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -9,6 +9,8 @@
 #include "include/policy.h"
 #include "include/policy_unpack.h"
 
+#include <linux/unaligned.h>
+
 #define TEST_STRING_NAME "TEST_STRING"
 #define TEST_STRING_DATA "testing"
 #define TEST_STRING_BUF_OFFSET \
@@ -80,7 +82,7 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
 	*(buf + 1) = strlen(TEST_U32_NAME) + 1;
 	strscpy(buf + 3, TEST_U32_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_U32_NAME) + 1) = AA_U32;
-	*((__le32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = cpu_to_le32(TEST_U32_DATA);
+	put_unaligned_le32(TEST_U32_DATA, buf + 3 + strlen(TEST_U32_NAME) + 2);
 
 	buf = e->start + TEST_NAMED_U64_BUF_OFFSET;
 	*buf = AA_NAME;
@@ -103,7 +105,7 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
 	*(buf + 1) = strlen(TEST_ARRAY_NAME) + 1;
 	strscpy(buf + 3, TEST_ARRAY_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_ARRAY_NAME) + 1) = AA_ARRAY;
-	*((__le16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = cpu_to_le16(TEST_ARRAY_SIZE);
+	put_unaligned_le16(TEST_ARRAY_SIZE, buf + 3 + strlen(TEST_ARRAY_NAME) + 2);
 
 	return e;
 }
diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 7baf3b506eef..7823f71012a8 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -876,6 +876,52 @@ static int cs35l56_hda_system_resume(struct device *dev)
 	return 0;
 }
 
+static int cs35l56_hda_fixup_yoga9(struct cs35l56_hda *cs35l56, int *bus_addr)
+{
+	/* The cirrus,dev-index property has the wrong values */
+	switch (*bus_addr) {
+	case 0x30:
+		cs35l56->index = 1;
+		return 0;
+	case 0x31:
+		cs35l56->index = 0;
+		return 0;
+	default:
+		/* There is a pseudo-address for broadcast to both amps - ignore it */
+		dev_dbg(cs35l56->base.dev, "Ignoring I2C address %#x\n", *bus_addr);
+		return 0;
+	}
+}
+
+static const struct {
+	const char *sub;
+	int (*fixup_fn)(struct cs35l56_hda *cs35l56, int *bus_addr);
+} cs35l56_hda_fixups[] = {
+	{
+		.sub = "17AA390B", /* Lenovo Yoga Book 9i GenX */
+		.fixup_fn = cs35l56_hda_fixup_yoga9,
+	},
+};
+
+static int cs35l56_hda_apply_platform_fixups(struct cs35l56_hda *cs35l56, const char *sub,
+					     int *bus_addr)
+{
+	int i;
+
+	if (IS_ERR(sub))
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(cs35l56_hda_fixups); i++) {
+		if (strcasecmp(cs35l56_hda_fixups[i].sub, sub) == 0) {
+			dev_dbg(cs35l56->base.dev, "Applying fixup for %s\n",
+				cs35l56_hda_fixups[i].sub);
+			return (cs35l56_hda_fixups[i].fixup_fn)(cs35l56, bus_addr);
+		}
+	}
+
+	return 0;
+}
+
 static int cs35l56_hda_read_acpi(struct cs35l56_hda *cs35l56, int hid, int id)
 {
 	u32 values[HDA_MAX_COMPONENTS];
@@ -900,39 +946,47 @@ static int cs35l56_hda_read_acpi(struct cs35l56_hda *cs35l56, int hid, int id)
 		ACPI_COMPANION_SET(cs35l56->base.dev, adev);
 	}
 
-	property = "cirrus,dev-index";
-	ret = device_property_count_u32(cs35l56->base.dev, property);
-	if (ret <= 0)
-		goto err;
-
-	if (ret > ARRAY_SIZE(values)) {
-		ret = -EINVAL;
-		goto err;
-	}
-	nval = ret;
+	/* Initialize things that could be overwritten by a fixup */
+	cs35l56->index = -1;
 
-	ret = device_property_read_u32_array(cs35l56->base.dev, property, values, nval);
+	sub = acpi_get_subsystem_id(ACPI_HANDLE(cs35l56->base.dev));
+	ret = cs35l56_hda_apply_platform_fixups(cs35l56, sub, &id);
 	if (ret)
-		goto err;
+		return ret;
 
-	cs35l56->index = -1;
-	for (i = 0; i < nval; i++) {
-		if (values[i] == id) {
-			cs35l56->index = i;
-			break;
-		}
-	}
-	/*
-	 * It's not an error for the ID to be missing: for I2C there can be
-	 * an alias address that is not a real device. So reject silently.
-	 */
 	if (cs35l56->index == -1) {
-		dev_dbg(cs35l56->base.dev, "No index found in %s\n", property);
-		ret = -ENODEV;
-		goto err;
-	}
+		property = "cirrus,dev-index";
+		ret = device_property_count_u32(cs35l56->base.dev, property);
+		if (ret <= 0)
+			goto err;
 
-	sub = acpi_get_subsystem_id(ACPI_HANDLE(cs35l56->base.dev));
+		if (ret > ARRAY_SIZE(values)) {
+			ret = -EINVAL;
+			goto err;
+		}
+		nval = ret;
+
+		ret = device_property_read_u32_array(cs35l56->base.dev, property, values, nval);
+		if (ret)
+			goto err;
+
+		for (i = 0; i < nval; i++) {
+			if (values[i] == id) {
+				cs35l56->index = i;
+				break;
+			}
+		}
+
+		/*
+		 * It's not an error for the ID to be missing: for I2C there can be
+		 * an alias address that is not a real device. So reject silently.
+		 */
+		if (cs35l56->index == -1) {
+			dev_dbg(cs35l56->base.dev, "No index found in %s\n", property);
+			ret = -ENODEV;
+			goto err;
+		}
+	}
 
 	if (IS_ERR(sub)) {
 		dev_info(cs35l56->base.dev,
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index d40197fb5fbd..77432e06f3e3 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4802,7 +4802,8 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 	if (err < 0)
 		goto exit;
 
-	if (ca0132_alt_select_out_quirk_set(codec) < 0)
+	err = ca0132_alt_select_out_quirk_set(codec);
+	if (err < 0)
 		goto exit;
 
 	switch (spec->cur_out_type) {
@@ -4892,6 +4893,8 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 				spec->bass_redirection_val);
 	else
 		err = ca0132_alt_surround_set_bass_redirection(codec, 0);
+	if (err < 0)
+		goto exit;
 
 	/* Unmute DSP now that we're done with output selection. */
 	err = dspio_set_uint_param(codec, 0x96,
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 085f0697bff1..6ef635d37f45 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10678,6 +10678,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
+	SND_PCI_QUIRK(0x103c, 0x8a26, "HP Victus 16-d1xxx (MB 8A26)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a28, "HP Envy 13", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a29, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2a, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
@@ -10736,6 +10737,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8bbe, "HP Victus 16-r0xxx (MB 8BBE)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
+	SND_PCI_QUIRK(0x103c, 0x8bd4, "HP Victus 16-s0xxx (MB 8BD4)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bdd, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bde, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bdf, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
@@ -10788,6 +10790,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c97, "HP ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c99, "HP Victus 16-r1xxx (MB 8C99)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8c9c, "HP Victus 16-s1xxx (MB 8C9C)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8ca1, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca2, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1689b6b22598..e362c2865ec1 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -409,6 +409,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M6501RM"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
@@ -528,6 +535,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16z-n000"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Victus by HP Gaming Laptop 15-fb1xxx"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
@@ -577,6 +591,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A7F"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A81"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 4341269eb977..0a67987c316e 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1239,6 +1239,26 @@ static irqreturn_t irq0_isr(int irq, void *devid)
 				/* clear CS control register */
 				memset_io(reg_ctrl, 0, sizeof(val));
 			}
+		} else {
+			regmap_read(xcvr->regmap, FSL_XCVR_RX_CS_DATA_0,
+				    (u32 *)&xcvr->rx_iec958.status[0]);
+			regmap_read(xcvr->regmap, FSL_XCVR_RX_CS_DATA_1,
+				    (u32 *)&xcvr->rx_iec958.status[4]);
+			regmap_read(xcvr->regmap, FSL_XCVR_RX_CS_DATA_2,
+				    (u32 *)&xcvr->rx_iec958.status[8]);
+			regmap_read(xcvr->regmap, FSL_XCVR_RX_CS_DATA_3,
+				    (u32 *)&xcvr->rx_iec958.status[12]);
+			regmap_read(xcvr->regmap, FSL_XCVR_RX_CS_DATA_4,
+				    (u32 *)&xcvr->rx_iec958.status[16]);
+			regmap_read(xcvr->regmap, FSL_XCVR_RX_CS_DATA_5,
+				    (u32 *)&xcvr->rx_iec958.status[20]);
+			for (i = 0; i < 6; i++) {
+				val = *(u32 *)(xcvr->rx_iec958.status + i * 4);
+				*(u32 *)(xcvr->rx_iec958.status + i * 4) =
+					bitrev32(val);
+			}
+			regmap_set_bits(xcvr->regmap, FSL_XCVR_RX_DPTH_CTRL,
+					FSL_XCVR_RX_DPTH_CTRL_CSA);
 		}
 	}
 	if (isr & FSL_XCVR_IRQ_NEW_UD) {
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 8dee46abf346..aed95d1583e0 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -11,7 +11,7 @@ menuconfig SND_SOC_INTEL_MACH
 	 kernel: saying N will just cause the configurator to skip all
 	 the questions about Intel ASoC machine drivers.
 
-if SND_SOC_INTEL_MACH
+if SND_SOC_INTEL_MACH && (SND_SOC_SOF_INTEL_COMMON || !SND_SOC_SOF_INTEL_COMMON)
 
 config SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES
 	bool "Use more user friendly long card names"
diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 6b6330583941..70fd05d5ff48 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -120,7 +120,9 @@ int mtk_afe_pcm_new(struct snd_soc_component *component,
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
 
 	size = afe->mtk_afe_hardware->buffer_bytes_max;
-	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV, afe->dev, 0, size);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV, afe->dev,
+				       afe->preallocate_buffers ? size : 0,
+				       size);
 
 	return 0;
 }
diff --git a/sound/soc/mediatek/common/mtk-base-afe.h b/sound/soc/mediatek/common/mtk-base-afe.h
index f51578b6c50a..a406f2e3e7a8 100644
--- a/sound/soc/mediatek/common/mtk-base-afe.h
+++ b/sound/soc/mediatek/common/mtk-base-afe.h
@@ -117,6 +117,7 @@ struct mtk_base_afe {
 	struct mtk_base_afe_irq *irqs;
 	int irqs_size;
 	int memif_32bit_supported;
+	bool preallocate_buffers;
 
 	struct list_head sub_dais;
 	struct snd_soc_dai_driver *dai_drivers;
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 03250273ea9c..47a88edf78ca 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <sound/soc.h>
@@ -1070,6 +1071,12 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	afe->dev = &pdev->dev;
 
+	ret = of_reserved_mem_device_init(&pdev->dev);
+	if (ret) {
+		dev_info(&pdev->dev, "no reserved memory found, pre-allocating buffers instead\n");
+		afe->preallocate_buffers = true;
+	}
+
 	irq_id = platform_get_irq(pdev, 0);
 	if (irq_id <= 0)
 		return irq_id < 0 ? irq_id : -ENXIO;
diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 3f377ba4ad53..501ea9d92aea 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -10,6 +10,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
@@ -1094,6 +1095,12 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->dev = &pdev->dev;
 	dev = afe->dev;
 
+	ret = of_reserved_mem_device_init(dev);
+	if (ret) {
+		dev_info(dev, "no reserved memory found, pre-allocating buffers instead\n");
+		afe->preallocate_buffers = true;
+	}
+
 	/* initial audio related clock */
 	ret = mt8183_init_clock(afe);
 	if (ret) {
diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
index bafbef96a42d..e6d3caf8b6fc 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <sound/soc.h>
@@ -2835,6 +2836,12 @@ static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe_priv = afe->platform_priv;
 	afe->dev = &pdev->dev;
 
+	ret = of_reserved_mem_device_init(dev);
+	if (ret) {
+		dev_info(dev, "no reserved memory found, pre-allocating buffers instead\n");
+		afe->preallocate_buffers = true;
+	}
+
 	afe->base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(afe->base_addr))
 		return PTR_ERR(afe->base_addr);
diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 9b502f4cd6ea..69ed34495d0f 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -12,6 +12,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <sound/soc.h>
@@ -2180,6 +2181,12 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->dev = &pdev->dev;
 	dev = afe->dev;
 
+	ret = of_reserved_mem_device_init(dev);
+	if (ret) {
+		dev_info(dev, "no reserved memory found, pre-allocating buffers instead\n");
+		afe->preallocate_buffers = true;
+	}
+
 	/* init audio related clock */
 	ret = mt8192_init_clock(afe);
 	if (ret) {
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index de09d21add45..ad106087dd4b 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -273,13 +273,15 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 		&rx_mask,
 	};
 
-	if (dai->driver->ops &&
-	    dai->driver->ops->xlate_tdm_slot_mask)
-		ret = dai->driver->ops->xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
-	else
-		ret = snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
-	if (ret)
-		goto err;
+	if (slots) {
+		if (dai->driver->ops &&
+		    dai->driver->ops->xlate_tdm_slot_mask)
+			ret = dai->driver->ops->xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
+		else
+			ret = snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
+		if (ret)
+			goto err;
+	}
 
 	for_each_pcm_streams(stream)
 		snd_soc_dai_tdm_mask_set(dai, stream, *tdm_mask[stream]);
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index fb11003d56cf..669b95cb4850 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -642,28 +642,32 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_range);
 static int snd_soc_clip_to_platform_max(struct snd_kcontrol *kctl)
 {
 	struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
-	struct snd_ctl_elem_value uctl;
+	struct snd_ctl_elem_value *uctl;
 	int ret;
 
 	if (!mc->platform_max)
 		return 0;
 
-	ret = kctl->get(kctl, &uctl);
+	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
+	if (!uctl)
+		return -ENOMEM;
+
+	ret = kctl->get(kctl, uctl);
 	if (ret < 0)
-		return ret;
+		goto out;
 
-	if (uctl.value.integer.value[0] > mc->platform_max)
-		uctl.value.integer.value[0] = mc->platform_max;
+	if (uctl->value.integer.value[0] > mc->platform_max)
+		uctl->value.integer.value[0] = mc->platform_max;
 
 	if (snd_soc_volsw_is_stereo(mc) &&
-	    uctl.value.integer.value[1] > mc->platform_max)
-		uctl.value.integer.value[1] = mc->platform_max;
+	    uctl->value.integer.value[1] > mc->platform_max)
+		uctl->value.integer.value[1] = mc->platform_max;
 
-	ret = kctl->put(kctl, &uctl);
-	if (ret < 0)
-		return ret;
+	ret = kctl->put(kctl, uctl);
 
-	return 0;
+out:
+	kfree(uctl);
+	return ret;
 }
 
 /**
diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 4cddf84db631..8e91fce6274f 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -2329,6 +2329,8 @@ static int scarlett2_usb(
 	struct scarlett2_usb_packet *req, *resp = NULL;
 	size_t req_buf_size = struct_size(req, data, req_size);
 	size_t resp_buf_size = struct_size(resp, data, resp_size);
+	int retries = 0;
+	const int max_retries = 5;
 	int err;
 
 	req = kmalloc(req_buf_size, GFP_KERNEL);
@@ -2352,10 +2354,15 @@ static int scarlett2_usb(
 	if (req_size)
 		memcpy(req->data, req_data, req_size);
 
+retry:
 	err = scarlett2_usb_tx(dev, private->bInterfaceNumber,
 			       req, req_buf_size);
 
 	if (err != req_buf_size) {
+		if (err == -EPROTO && ++retries <= max_retries) {
+			msleep(5 * (1 << (retries - 1)));
+			goto retry;
+		}
 		usb_audio_err(
 			mixer->chip,
 			"%s USB request result cmd %x was %d\n",
diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index d41ea09ffbe5..571a092b128a 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1767,7 +1767,7 @@ static int __hdmi_lpe_audio_probe(struct platform_device *pdev)
 		/* setup private data which can be retrieved when required */
 		pcm->private_data = ctx;
 		pcm->info_flags = 0;
-		strscpy(pcm->name, card->shortname, strlen(card->shortname));
+		strscpy(pcm->name, card->shortname, sizeof(pcm->name));
 		/* setup the ops for playback */
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &had_pcm_ops);
 
diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index d2242d9f8441..39f208928cdb 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -366,17 +366,18 @@ static int dump_link_nlmsg(void *cookie, void *msg, struct nlattr **tb)
 {
 	struct bpf_netdev_t *netinfo = cookie;
 	struct ifinfomsg *ifinfo = msg;
+	struct ip_devname_ifindex *tmp;
 
 	if (netinfo->filter_idx > 0 && netinfo->filter_idx != ifinfo->ifi_index)
 		return 0;
 
 	if (netinfo->used_len == netinfo->array_len) {
-		netinfo->devices = realloc(netinfo->devices,
-			(netinfo->array_len + 16) *
-			sizeof(struct ip_devname_ifindex));
-		if (!netinfo->devices)
+		tmp = realloc(netinfo->devices,
+			(netinfo->array_len + 16) * sizeof(struct ip_devname_ifindex));
+		if (!tmp)
 			return -ENOMEM;
 
+		netinfo->devices = tmp;
 		netinfo->array_len += 16;
 	}
 	netinfo->devices[netinfo->used_len].ifindex = ifinfo->ifi_index;
@@ -395,6 +396,7 @@ static int dump_class_qdisc_nlmsg(void *cookie, void *msg, struct nlattr **tb)
 {
 	struct bpf_tcinfo_t *tcinfo = cookie;
 	struct tcmsg *info = msg;
+	struct tc_kind_handle *tmp;
 
 	if (tcinfo->is_qdisc) {
 		/* skip clsact qdisc */
@@ -406,11 +408,12 @@ static int dump_class_qdisc_nlmsg(void *cookie, void *msg, struct nlattr **tb)
 	}
 
 	if (tcinfo->used_len == tcinfo->array_len) {
-		tcinfo->handle_array = realloc(tcinfo->handle_array,
+		tmp = realloc(tcinfo->handle_array,
 			(tcinfo->array_len + 16) * sizeof(struct tc_kind_handle));
-		if (!tcinfo->handle_array)
+		if (!tmp)
 			return -ENOMEM;
 
+		tcinfo->handle_array = tmp;
 		tcinfo->array_len += 16;
 	}
 	tcinfo->handle_array[tcinfo->used_len].handle = info->tcm_handle;
diff --git a/tools/cgroup/memcg_slabinfo.py b/tools/cgroup/memcg_slabinfo.py
index 270c28a0d098..6bf4bde77903 100644
--- a/tools/cgroup/memcg_slabinfo.py
+++ b/tools/cgroup/memcg_slabinfo.py
@@ -146,11 +146,11 @@ def detect_kernel_config():
 
 
 def for_each_slab(prog):
-    PGSlab = ~prog.constant('PG_slab')
+    slabtype = prog.constant('PGTY_slab')
 
     for page in for_each_page(prog):
         try:
-            if page.page_type.value_() == PGSlab:
+            if (page.page_type.value_() >> 24) == slabtype:
                 yield cast('struct slab *', page)
         except FaultError:
             pass
diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index 8561b0f01a24..9ef569492560 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -9,6 +9,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <dirent.h>
+#include <assert.h>
 #include "subcmd-util.h"
 #include "help.h"
 #include "exec-cmd.h"
@@ -82,10 +83,11 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 				ci++;
 				cj++;
 			} else {
-				zfree(&cmds->names[cj]);
-				cmds->names[cj++] = cmds->names[ci++];
+				cmds->names[cj++] = cmds->names[ci];
+				cmds->names[ci++] = NULL;
 			}
 		} else if (cmp == 0) {
+			zfree(&cmds->names[ci]);
 			ci++;
 			ei++;
 		} else if (cmp > 0) {
@@ -94,12 +96,12 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 	}
 	if (ci != cj) {
 		while (ci < cmds->cnt) {
-			zfree(&cmds->names[cj]);
-			cmds->names[cj++] = cmds->names[ci++];
+			cmds->names[cj++] = cmds->names[ci];
+			cmds->names[ci++] = NULL;
 		}
 	}
 	for (ci = cj; ci < cmds->cnt; ci++)
-		zfree(&cmds->names[ci]);
+		assert(cmds->names[ci] == NULL);
 	cmds->cnt = cj;
 }
 
diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index f5b81d439387..1ef45d803024 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -48,8 +48,6 @@ libbpf/
 libperf/
 libsubcmd/
 libsymbol/
-libtraceevent/
-libtraceevent_plugins/
 fixdep
 Documentation/doc.dep
 python_ext_build/
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 5981cc51abc8..64bf3ac237f2 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -999,7 +999,7 @@ thread_atoms_search(struct rb_root_cached *root, struct thread *thread,
 		else if (cmp < 0)
 			node = node->rb_right;
 		else {
-			BUG_ON(thread != atoms->thread);
+			BUG_ON(!RC_CHK_EQUAL(thread, atoms->thread));
 			return atoms;
 		}
 	}
@@ -1116,6 +1116,21 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
 	atoms->nb_atoms++;
 }
 
+static void free_work_atoms(struct work_atoms *atoms)
+{
+	struct work_atom *atom, *tmp;
+
+	if (atoms == NULL)
+		return;
+
+	list_for_each_entry_safe(atom, tmp, &atoms->work_list, list) {
+		list_del(&atom->list);
+		free(atom);
+	}
+	thread__zput(atoms->thread);
+	free(atoms);
+}
+
 static int latency_switch_event(struct perf_sched *sched,
 				struct evsel *evsel,
 				struct perf_sample *sample,
@@ -1639,6 +1654,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	const char *color = PERF_COLOR_NORMAL;
 	char stimestamp[32];
 	const char *str;
+	int ret = -1;
 
 	BUG_ON(this_cpu.cpu >= MAX_CPUS || this_cpu.cpu < 0);
 
@@ -1669,17 +1685,20 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	sched_in = map__findnew_thread(sched, machine, -1, next_pid);
 	sched_out = map__findnew_thread(sched, machine, -1, prev_pid);
 	if (sched_in == NULL || sched_out == NULL)
-		return -1;
+		goto out;
 
 	tr = thread__get_runtime(sched_in);
-	if (tr == NULL) {
-		thread__put(sched_in);
-		return -1;
-	}
+	if (tr == NULL)
+		goto out;
+
+	thread__put(sched->curr_thread[this_cpu.cpu]);
+	thread__put(sched->curr_out_thread[this_cpu.cpu]);
 
 	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
 	sched->curr_out_thread[this_cpu.cpu] = thread__get(sched_out);
 
+	ret = 0;
+
 	str = thread__comm_str(sched_in);
 	new_shortname = 0;
 	if (!tr->shortname[0]) {
@@ -1774,12 +1793,10 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	color_fprintf(stdout, color, "\n");
 
 out:
-	if (sched->map.task_name)
-		thread__put(sched_out);
-
+	thread__put(sched_out);
 	thread__put(sched_in);
 
-	return 0;
+	return ret;
 }
 
 static int process_sched_switch_event(const struct perf_tool *tool,
@@ -2023,6 +2040,16 @@ static u64 evsel__get_time(struct evsel *evsel, u32 cpu)
 	return r->last_time[cpu];
 }
 
+static void timehist__evsel_priv_destructor(void *priv)
+{
+	struct evsel_runtime *r = priv;
+
+	if (r) {
+		free(r->last_time);
+		free(r);
+	}
+}
+
 static int comm_width = 30;
 
 static char *timehist_get_commstr(struct thread *thread)
@@ -3276,6 +3303,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
 
 	setup_pager();
 
+	evsel__set_priv_destructor(timehist__evsel_priv_destructor);
+
 	/* prefer sched_waking if it is captured */
 	if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
 		handlers[1].handler = timehist_sched_wakeup_ignore;
@@ -3376,13 +3405,13 @@ static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *d
 			this->total_runtime += data->total_runtime;
 			this->nb_atoms += data->nb_atoms;
 			this->total_lat += data->total_lat;
-			list_splice(&data->work_list, &this->work_list);
+			list_splice_init(&data->work_list, &this->work_list);
 			if (this->max_lat < data->max_lat) {
 				this->max_lat = data->max_lat;
 				this->max_lat_start = data->max_lat_start;
 				this->max_lat_end = data->max_lat_end;
 			}
-			zfree(&data);
+			free_work_atoms(data);
 			return;
 		}
 	}
@@ -3461,7 +3490,6 @@ static int perf_sched__lat(struct perf_sched *sched)
 		work_list = rb_entry(next, struct work_atoms, node);
 		output_lat_thread(sched, work_list);
 		next = rb_next(next);
-		thread__zput(work_list->thread);
 	}
 
 	printf(" -----------------------------------------------------------------------------------------------------------------\n");
@@ -3475,6 +3503,13 @@ static int perf_sched__lat(struct perf_sched *sched)
 
 	rc = 0;
 
+	while ((next = rb_first_cached(&sched->sorted_atom_root))) {
+		struct work_atoms *data;
+
+		data = rb_entry(next, struct work_atoms, node);
+		rb_erase_cached(next, &sched->sorted_atom_root);
+		free_work_atoms(data);
+	}
 out_free_cpus_switch_event:
 	free_cpus_switch_event(sched);
 	return rc;
@@ -3546,10 +3581,10 @@ static int perf_sched__map(struct perf_sched *sched)
 
 	sched->curr_out_thread = calloc(MAX_CPUS, sizeof(*(sched->curr_out_thread)));
 	if (!sched->curr_out_thread)
-		return rc;
+		goto out_free_curr_thread;
 
 	if (setup_cpus_switch_event(sched))
-		goto out_free_curr_thread;
+		goto out_free_curr_out_thread;
 
 	if (setup_map_cpus(sched))
 		goto out_free_cpus_switch_event;
@@ -3580,7 +3615,14 @@ static int perf_sched__map(struct perf_sched *sched)
 out_free_cpus_switch_event:
 	free_cpus_switch_event(sched);
 
+out_free_curr_out_thread:
+	for (int i = 0; i < MAX_CPUS; i++)
+		thread__put(sched->curr_out_thread[i]);
+	zfree(&sched->curr_out_thread);
+
 out_free_curr_thread:
+	for (int i = 0; i < MAX_CPUS; i++)
+		thread__put(sched->curr_thread[i]);
 	zfree(&sched->curr_thread);
 	return rc;
 }
@@ -3887,13 +3929,15 @@ int cmd_sched(int argc, const char **argv)
 	if (!argc)
 		usage_with_options(sched_usage, sched_options);
 
+	thread__set_priv_destructor(free);
+
 	/*
 	 * Aliased to 'perf script' for now:
 	 */
 	if (!strcmp(argv[0], "script")) {
-		return cmd_script(argc, argv);
+		ret = cmd_script(argc, argv);
 	} else if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
-		return __cmd_record(argc, argv);
+		ret = __cmd_record(argc, argv);
 	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
 		sched.tp_handler = &lat_ops;
 		if (argc > 1) {
@@ -3902,7 +3946,7 @@ int cmd_sched(int argc, const char **argv)
 				usage_with_options(latency_usage, latency_options);
 		}
 		setup_sorting(&sched, latency_options, latency_usage);
-		return perf_sched__lat(&sched);
+		ret = perf_sched__lat(&sched);
 	} else if (!strcmp(argv[0], "map")) {
 		if (argc) {
 			argc = parse_options(argc, argv, map_options, map_usage, 0);
@@ -3913,13 +3957,14 @@ int cmd_sched(int argc, const char **argv)
 				sched.map.task_names = strlist__new(sched.map.task_name, NULL);
 				if (sched.map.task_names == NULL) {
 					fprintf(stderr, "Failed to parse task names\n");
-					return -1;
+					ret = -1;
+					goto out;
 				}
 			}
 		}
 		sched.tp_handler = &map_ops;
 		setup_sorting(&sched, latency_options, latency_usage);
-		return perf_sched__map(&sched);
+		ret = perf_sched__map(&sched);
 	} else if (strlen(argv[0]) > 2 && strstarts("replay", argv[0])) {
 		sched.tp_handler = &replay_ops;
 		if (argc) {
@@ -3927,7 +3972,7 @@ int cmd_sched(int argc, const char **argv)
 			if (argc)
 				usage_with_options(replay_usage, replay_options);
 		}
-		return perf_sched__replay(&sched);
+		ret = perf_sched__replay(&sched);
 	} else if (!strcmp(argv[0], "timehist")) {
 		if (argc) {
 			argc = parse_options(argc, argv, timehist_options,
@@ -3943,19 +3988,19 @@ int cmd_sched(int argc, const char **argv)
 				parse_options_usage(NULL, timehist_options, "w", true);
 			if (sched.show_next)
 				parse_options_usage(NULL, timehist_options, "n", true);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		ret = symbol__validate_sym_arguments();
-		if (ret)
-			return ret;
-
-		return perf_sched__timehist(&sched);
+		if (!ret)
+			ret = perf_sched__timehist(&sched);
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
 
+out:
 	/* free usage string allocated by parse_options_subcommand */
 	free((void *)sched_usage[0]);
 
-	return 0;
+	return ret;
 }
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 4cb7d486b5c1..047433c977bc 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -104,6 +104,7 @@ static int bp_accounting(int wp_cnt, int share)
 		fd_wp = wp_event((void *)&the_var, &attr_new);
 		TEST_ASSERT_VAL("failed to create max wp\n", fd_wp != -1);
 		pr_debug("wp max created\n");
+		close(fd_wp);
 	}
 
 	for (i = 0; i < wp_cnt; i++)
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index e763e8d99a43..ee00313d5d7e 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -864,7 +864,7 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine,
 	char *allocated_name = NULL;
 	int ret = 0;
 
-	if (!dso__has_build_id(dso))
+	if (!dso__has_build_id(dso) || !dso__hit(dso))
 		return 0;
 
 	if (dso__is_kcore(dso)) {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbf9c8cee3c5..6d7249cc1a99 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1477,6 +1477,15 @@ static void evsel__free_config_terms(struct evsel *evsel)
 	free_config_terms(&evsel->config_terms);
 }
 
+static void (*evsel__priv_destructor)(void *priv);
+
+void evsel__set_priv_destructor(void (*destructor)(void *priv))
+{
+	assert(evsel__priv_destructor == NULL);
+
+	evsel__priv_destructor = destructor;
+}
+
 void evsel__exit(struct evsel *evsel)
 {
 	assert(list_empty(&evsel->core.node));
@@ -1502,6 +1511,8 @@ void evsel__exit(struct evsel *evsel)
 	hashmap__free(evsel->per_pkg_mask);
 	evsel->per_pkg_mask = NULL;
 	zfree(&evsel->metric_events);
+	if (evsel__priv_destructor)
+		evsel__priv_destructor(evsel->priv);
 	perf_evsel__object.fini(evsel);
 	if (evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME ||
 	    evsel__tool_event(evsel) == PERF_TOOL_USER_TIME)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 15e745a9a798..26574a33a725 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -282,6 +282,8 @@ void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
 void evsel__exit(struct evsel *evsel);
 void evsel__delete(struct evsel *evsel);
 
+void evsel__set_priv_destructor(void (*destructor)(void *priv));
+
 struct callchain_param;
 
 void evsel__config(struct evsel *evsel, struct record_opts *opts,
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3bbf173ad822..c0ec5ed4f1aa 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1405,6 +1405,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 				goto out_err;
 			}
 		}
+		map__zput(new_node->map);
 		free(new_node);
 	}
 
diff --git a/tools/testing/selftests/alsa/utimer-test.c b/tools/testing/selftests/alsa/utimer-test.c
index 32ee3ce57721..37964f311a33 100644
--- a/tools/testing/selftests/alsa/utimer-test.c
+++ b/tools/testing/selftests/alsa/utimer-test.c
@@ -135,6 +135,7 @@ TEST_F(timer_f, utimer) {
 	pthread_join(ticking_thread, NULL);
 	ASSERT_EQ(total_ticks, TICKS_COUNT);
 	pclose(rfp);
+	free(buf);
 }
 
 TEST(wrong_timers_test) {
diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 6d61992fe8a0..c6228176dd1a 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -251,7 +251,7 @@ static void ptrace_set_get_vl(pid_t child, const struct vec_type *type,
 		return;
 	}
 
-	ksft_test_result(new_sve->vl = prctl_vl, "Set %s VL %u\n",
+	ksft_test_result(new_sve->vl == prctl_vl, "Set %s VL %u\n",
 			 type->name, vl);
 
 	free(new_sve);
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 4ee1148d22be..1cfed83156b0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -924,6 +924,8 @@ static void redir_partial(int family, int sotype, int sock_map, int parser_map)
 		goto close;
 
 	n = xsend(c1, buf, sizeof(buf), 0);
+	if (n == -1)
+		goto close;
 	if (n < sizeof(buf))
 		FAIL("incomplete write");
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index 6065f862d964..758b09a5eb88 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -29,12 +29,12 @@ int big_alloc1(void *ctx)
 	if (!page1)
 		return 1;
 	*page1 = 1;
-	page2 = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE,
+	page2 = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE * 2,
 				      1, NUMA_NO_NODE, 0);
 	if (!page2)
 		return 2;
 	*page2 = 2;
-	no_page = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE,
+	no_page = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE,
 					1, NUMA_NO_NODE, 0);
 	if (no_page)
 		return 3;
@@ -66,4 +66,110 @@ int big_alloc1(void *ctx)
 #endif
 	return 0;
 }
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+#define PAGE_CNT 100
+__u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */
+__u8 __arena *base;
+
+/*
+ * Check that arena's range_tree algorithm allocates pages sequentially
+ * on the first pass and then fills in all gaps on the second pass.
+ */
+__noinline int alloc_pages(int page_cnt, int pages_atonce, bool first_pass,
+		int max_idx, int step)
+{
+	__u8 __arena *pg;
+	int i, pg_idx;
+
+	for (i = 0; i < page_cnt; i++) {
+		pg = bpf_arena_alloc_pages(&arena, NULL, pages_atonce,
+					   NUMA_NO_NODE, 0);
+		if (!pg)
+			return step;
+		pg_idx = (unsigned long) (pg - base) / PAGE_SIZE;
+		if (first_pass) {
+			/* Pages must be allocated sequentially */
+			if (pg_idx != i)
+				return step + 100;
+		} else {
+			/* Allocator must fill into gaps */
+			if (pg_idx >= max_idx || (pg_idx & 1))
+				return step + 200;
+		}
+		*pg = pg_idx;
+		page[pg_idx] = pg;
+		cond_break;
+	}
+	return 0;
+}
+
+//SEC("syscall")
+//__success __retval(0)
+int big_alloc2(void *ctx)
+{
+	__u8 __arena *pg;
+	int i, err;
+
+	base = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!base)
+		return 1;
+	bpf_arena_free_pages(&arena, (void __arena *)base, 1);
+
+	err = alloc_pages(PAGE_CNT, 1, true, PAGE_CNT, 2);
+	if (err)
+		return err;
+
+	/* Clear all even pages */
+	for (i = 0; i < PAGE_CNT; i += 2) {
+		pg = page[i];
+		if (*pg != i)
+			return 3;
+		bpf_arena_free_pages(&arena, (void __arena *)pg, 1);
+		page[i] = NULL;
+		cond_break;
+	}
+
+	/* Allocate into freed gaps */
+	err = alloc_pages(PAGE_CNT / 2, 1, false, PAGE_CNT, 4);
+	if (err)
+		return err;
+
+	/* Free pairs of pages */
+	for (i = 0; i < PAGE_CNT; i += 4) {
+		pg = page[i];
+		if (*pg != i)
+			return 5;
+		bpf_arena_free_pages(&arena, (void __arena *)pg, 2);
+		page[i] = NULL;
+		page[i + 1] = NULL;
+		cond_break;
+	}
+
+	/* Allocate 2 pages at a time into freed gaps */
+	err = alloc_pages(PAGE_CNT / 4, 2, false, PAGE_CNT, 6);
+	if (err)
+		return err;
+
+	/* Check pages without freeing */
+	for (i = 0; i < PAGE_CNT; i += 2) {
+		pg = page[i];
+		if (*pg != i)
+			return 7;
+		cond_break;
+	}
+
+	pg = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+
+	if (!pg)
+		return 8;
+	/*
+	 * The first PAGE_CNT pages are occupied. The new page
+	 * must be above.
+	 */
+	if ((pg - base) / PAGE_SIZE < PAGE_CNT)
+		return 9;
+	return 0;
+}
+#endif
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 1ec5c4c47235..7b6b9c4cadb5 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -309,6 +309,7 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			fprintf(stderr, "invalid top N specifier: %s\n", arg);
 			argp_usage(state);
 		}
+		break;
 	case 'C':
 		env.comparison_mode = true;
 		break;
diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index 8d275f03e977..8d233ac95696 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -127,22 +127,42 @@ int run_test(int cpu)
 	return KSFT_PASS;
 }
 
+/*
+ * Reads the suspend success count from sysfs.
+ * Returns the count on success or exits on failure.
+ */
+static int get_suspend_success_count_or_fail(void)
+{
+	FILE *fp;
+	int val;
+
+	fp = fopen("/sys/power/suspend_stats/success", "r");
+	if (!fp)
+		ksft_exit_fail_msg(
+			"Failed to open suspend_stats/success: %s\n",
+			strerror(errno));
+
+	if (fscanf(fp, "%d", &val) != 1) {
+		fclose(fp);
+		ksft_exit_fail_msg(
+			"Failed to read suspend success count\n");
+	}
+
+	fclose(fp);
+	return val;
+}
+
 void suspend(void)
 {
-	int power_state_fd;
 	int timerfd;
 	int err;
+	int count_before;
+	int count_after;
 	struct itimerspec spec = {};
 
 	if (getuid() != 0)
 		ksft_exit_skip("Please run the test as root - Exiting.\n");
 
-	power_state_fd = open("/sys/power/state", O_RDWR);
-	if (power_state_fd < 0)
-		ksft_exit_fail_msg(
-			"open(\"/sys/power/state\") failed %s)\n",
-			strerror(errno));
-
 	timerfd = timerfd_create(CLOCK_BOOTTIME_ALARM, 0);
 	if (timerfd < 0)
 		ksft_exit_fail_msg("timerfd_create() failed\n");
@@ -152,14 +172,15 @@ void suspend(void)
 	if (err < 0)
 		ksft_exit_fail_msg("timerfd_settime() failed\n");
 
+	count_before = get_suspend_success_count_or_fail();
+
 	system("(echo mem > /sys/power/state) 2> /dev/null");
 
-	timerfd_gettime(timerfd, &spec);
-	if (spec.it_value.tv_sec != 0 || spec.it_value.tv_nsec != 0)
+	count_after = get_suspend_success_count_or_fail();
+	if (count_after <= count_before)
 		ksft_exit_fail_msg("Failed to enter Suspend state\n");
 
 	close(timerfd);
-	close(power_state_fd);
 }
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 1ea9bb695e94..3f35faca6559 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -224,7 +224,7 @@ class NetDrvEpEnv:
             if not self._require_cmd(comm, "local"):
                 raise KsftSkipEx("Test requires command: " + comm)
         if remote:
-            if not self._require_cmd(comm, "remote"):
+            if not self._require_cmd(comm, "remote", host=self.remote):
                 raise KsftSkipEx("Test requires (remote) command: " + comm)
 
     def wait_hw_stats_settle(self):
diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index b7c8f29c09a9..65916bb55dfb 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -14,11 +14,35 @@ fail() { #msg
     exit_fail
 }
 
+# As reading trace can last forever, simply look for 3 different
+# events then exit out of reading the file. If there's not 3 different
+# events, then the test has failed.
+check_unique() {
+    cat trace | grep -v '^#' | awk '
+	BEGIN { cnt = 0; }
+	{
+	    for (i = 0; i < cnt; i++) {
+		if (event[i] == $5) {
+		    break;
+		}
+	    }
+	    if (i == cnt) {
+		event[cnt++] = $5;
+		if (cnt > 2) {
+		    exit;
+		}
+	    }
+	}
+	END {
+	    printf "%d", cnt;
+	}'
+}
+
 echo 'sched:*' > set_event
 
 yield
 
-count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`check_unique`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
@@ -29,7 +53,7 @@ echo 1 > events/sched/enable
 
 yield
 
-count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`check_unique`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 87dce3efe31e..8a92432177d3 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -738,6 +738,11 @@ kci_test_ipsec_offload()
 	sysfsf=$sysfsd/ipsec
 	sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
 	probed=false
+	esp4_offload_probed_default=false
+
+	if lsmod | grep -q esp4_offload; then
+		esp4_offload_probed_default=true
+	fi
 
 	if ! mount | grep -q debugfs; then
 		mount -t debugfs none /sys/kernel/debug/ &> /dev/null
@@ -831,6 +836,7 @@ EOF
 	fi
 
 	# clean up any leftovers
+	! "$esp4_offload_probed_default" && lsmod | grep -q esp4_offload && rmmod esp4_offload
 	echo 0 > /sys/bus/netdevsim/del_device
 	$probed && rmmod netdevsim
 
diff --git a/tools/testing/selftests/perf_events/.gitignore b/tools/testing/selftests/perf_events/.gitignore
index ee93dc4969b8..4931b3b6bbd3 100644
--- a/tools/testing/selftests/perf_events/.gitignore
+++ b/tools/testing/selftests/perf_events/.gitignore
@@ -2,3 +2,4 @@
 sigtrap_threads
 remove_on_exec
 watermark_signal
+mmap
diff --git a/tools/testing/selftests/perf_events/Makefile b/tools/testing/selftests/perf_events/Makefile
index 70e3ff211278..2e5d85770dfe 100644
--- a/tools/testing/selftests/perf_events/Makefile
+++ b/tools/testing/selftests/perf_events/Makefile
@@ -2,5 +2,5 @@
 CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 LDFLAGS += -lpthread
 
-TEST_GEN_PROGS := sigtrap_threads remove_on_exec watermark_signal
+TEST_GEN_PROGS := sigtrap_threads remove_on_exec watermark_signal mmap
 include ../lib.mk
diff --git a/tools/testing/selftests/perf_events/mmap.c b/tools/testing/selftests/perf_events/mmap.c
new file mode 100644
index 000000000000..ea0427aac1f9
--- /dev/null
+++ b/tools/testing/selftests/perf_events/mmap.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define _GNU_SOURCE
+
+#include <dirent.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+
+#include <linux/perf_event.h>
+
+#include "../kselftest_harness.h"
+
+#define RB_SIZE		0x3000
+#define AUX_SIZE	0x10000
+#define AUX_OFFS	0x4000
+
+#define HOLE_SIZE	0x1000
+
+/* Reserve space for rb, aux with space for shrink-beyond-vma testing. */
+#define REGION_SIZE	(2 * RB_SIZE + 2 * AUX_SIZE)
+#define REGION_AUX_OFFS (2 * RB_SIZE)
+
+#define MAP_BASE	1
+#define MAP_AUX		2
+
+#define EVENT_SRC_DIR	"/sys/bus/event_source/devices"
+
+FIXTURE(perf_mmap)
+{
+	int		fd;
+	void		*ptr;
+	void		*region;
+};
+
+FIXTURE_VARIANT(perf_mmap)
+{
+	bool		aux;
+	unsigned long	ptr_size;
+};
+
+FIXTURE_VARIANT_ADD(perf_mmap, rb)
+{
+	.aux = false,
+	.ptr_size = RB_SIZE,
+};
+
+FIXTURE_VARIANT_ADD(perf_mmap, aux)
+{
+	.aux = true,
+	.ptr_size = AUX_SIZE,
+};
+
+static bool read_event_type(struct dirent *dent, __u32 *type)
+{
+	char typefn[512];
+	FILE *fp;
+	int res;
+
+	snprintf(typefn, sizeof(typefn), "%s/%s/type", EVENT_SRC_DIR, dent->d_name);
+	fp = fopen(typefn, "r");
+	if (!fp)
+		return false;
+
+	res = fscanf(fp, "%u", type);
+	fclose(fp);
+	return res > 0;
+}
+
+FIXTURE_SETUP(perf_mmap)
+{
+	struct perf_event_attr attr = {
+		.size		= sizeof(attr),
+		.disabled	= 1,
+		.exclude_kernel	= 1,
+		.exclude_hv	= 1,
+	};
+	struct perf_event_attr attr_ok = {};
+	unsigned int eacces = 0, map = 0;
+	struct perf_event_mmap_page *rb;
+	struct dirent *dent;
+	void *aux, *region;
+	DIR *dir;
+
+	self->ptr = NULL;
+
+	dir = opendir(EVENT_SRC_DIR);
+	if (!dir)
+		SKIP(return, "perf not available.");
+
+	region = mmap(NULL, REGION_SIZE, PROT_NONE, MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(region, MAP_FAILED);
+	self->region = region;
+
+	// Try to find a suitable event on this system
+	while ((dent = readdir(dir))) {
+		int fd;
+
+		if (!read_event_type(dent, &attr.type))
+			continue;
+
+		fd = syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0);
+		if (fd < 0) {
+			if (errno == EACCES)
+				eacces++;
+			continue;
+		}
+
+		// Check whether the event supports mmap()
+		rb = mmap(region, RB_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd, 0);
+		if (rb == MAP_FAILED) {
+			close(fd);
+			continue;
+		}
+
+		if (!map) {
+			// Save the event in case that no AUX capable event is found
+			attr_ok = attr;
+			map = MAP_BASE;
+		}
+
+		if (!variant->aux)
+			continue;
+
+		rb->aux_offset = AUX_OFFS;
+		rb->aux_size = AUX_SIZE;
+
+		// Check whether it supports a AUX buffer
+		aux = mmap(region + REGION_AUX_OFFS, AUX_SIZE, PROT_READ | PROT_WRITE,
+			   MAP_SHARED | MAP_FIXED, fd, AUX_OFFS);
+		if (aux == MAP_FAILED) {
+			munmap(rb, RB_SIZE);
+			close(fd);
+			continue;
+		}
+
+		attr_ok = attr;
+		map = MAP_AUX;
+		munmap(aux, AUX_SIZE);
+		munmap(rb, RB_SIZE);
+		close(fd);
+		break;
+	}
+	closedir(dir);
+
+	if (!map) {
+		if (!eacces)
+			SKIP(return, "No mappable perf event found.");
+		else
+			SKIP(return, "No permissions for perf_event_open()");
+	}
+
+	self->fd = syscall(SYS_perf_event_open, &attr_ok, 0, -1, -1, 0);
+	ASSERT_NE(self->fd, -1);
+
+	rb = mmap(region, RB_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, self->fd, 0);
+	ASSERT_NE(rb, MAP_FAILED);
+
+	if (!variant->aux) {
+		self->ptr = rb;
+		return;
+	}
+
+	if (map != MAP_AUX)
+		SKIP(return, "No AUX event found.");
+
+	rb->aux_offset = AUX_OFFS;
+	rb->aux_size = AUX_SIZE;
+	aux = mmap(region + REGION_AUX_OFFS, AUX_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_FIXED, self->fd, AUX_OFFS);
+	ASSERT_NE(aux, MAP_FAILED);
+	self->ptr = aux;
+}
+
+FIXTURE_TEARDOWN(perf_mmap)
+{
+	ASSERT_EQ(munmap(self->region, REGION_SIZE), 0);
+	if (self->fd != -1)
+		ASSERT_EQ(close(self->fd), 0);
+}
+
+TEST_F(perf_mmap, remap)
+{
+	void *tmp, *ptr = self->ptr;
+	unsigned long size = variant->ptr_size;
+
+	// Test the invalid remaps
+	ASSERT_EQ(mremap(ptr, size, HOLE_SIZE, MREMAP_MAYMOVE), MAP_FAILED);
+	ASSERT_EQ(mremap(ptr + HOLE_SIZE, size, HOLE_SIZE, MREMAP_MAYMOVE), MAP_FAILED);
+	ASSERT_EQ(mremap(ptr + size - HOLE_SIZE, HOLE_SIZE, size, MREMAP_MAYMOVE), MAP_FAILED);
+	// Shrink the end of the mapping such that we only unmap past end of the VMA,
+	// which should succeed and poke a hole into the PROT_NONE region
+	ASSERT_NE(mremap(ptr + size - HOLE_SIZE, size, HOLE_SIZE, MREMAP_MAYMOVE), MAP_FAILED);
+
+	// Remap the whole buffer to a new address
+	tmp = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(tmp, MAP_FAILED);
+
+	// Try splitting offset 1 hole size into VMA, this should fail
+	ASSERT_EQ(mremap(ptr + HOLE_SIZE, size - HOLE_SIZE, size - HOLE_SIZE,
+			 MREMAP_MAYMOVE | MREMAP_FIXED, tmp), MAP_FAILED);
+	// Remapping the whole thing should succeed fine
+	ptr = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, tmp);
+	ASSERT_EQ(ptr, tmp);
+	ASSERT_EQ(munmap(tmp, size), 0);
+}
+
+TEST_F(perf_mmap, unmap)
+{
+	unsigned long size = variant->ptr_size;
+
+	// Try to poke holes into the mappings
+	ASSERT_NE(munmap(self->ptr, HOLE_SIZE), 0);
+	ASSERT_NE(munmap(self->ptr + HOLE_SIZE, HOLE_SIZE), 0);
+	ASSERT_NE(munmap(self->ptr + size - HOLE_SIZE, HOLE_SIZE), 0);
+}
+
+TEST_F(perf_mmap, map)
+{
+	unsigned long size = variant->ptr_size;
+
+	// Try to poke holes into the mappings by mapping anonymous memory over it
+	ASSERT_EQ(mmap(self->ptr, HOLE_SIZE, PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANON | MAP_FIXED, -1, 0), MAP_FAILED);
+	ASSERT_EQ(mmap(self->ptr + HOLE_SIZE, HOLE_SIZE, PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANON | MAP_FIXED, -1, 0), MAP_FAILED);
+	ASSERT_EQ(mmap(self->ptr + size - HOLE_SIZE, HOLE_SIZE, PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANON | MAP_FIXED, -1, 0), MAP_FAILED);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index d975a6767329..48cf01aeec3e 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -79,6 +79,21 @@ TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
 	}
 }
 
+static void prctl_valid(struct __test_metadata *_metadata,
+			unsigned long op, unsigned long off,
+			unsigned long size, void *sel)
+{
+	EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, off, size, sel));
+}
+
+static void prctl_invalid(struct __test_metadata *_metadata,
+			  unsigned long op, unsigned long off,
+			  unsigned long size, void *sel, int err)
+{
+	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, off, size, sel));
+	EXPECT_EQ(err, errno);
+}
+
 TEST(bad_prctl_param)
 {
 	char sel = SYSCALL_DISPATCH_FILTER_ALLOW;
@@ -86,57 +101,42 @@ TEST(bad_prctl_param)
 
 	/* Invalid op */
 	op = -1;
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0, 0, &sel);
-	ASSERT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0, 0, &sel, EINVAL);
 
 	/* PR_SYS_DISPATCH_OFF */
 	op = PR_SYS_DISPATCH_OFF;
 
 	/* offset != 0 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, 0);
-	EXPECT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0x1, 0x0, 0, EINVAL);
 
 	/* len != 0 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0);
-	EXPECT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0x0, 0xff, 0, EINVAL);
 
 	/* sel != NULL */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, &sel);
-	EXPECT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0x0, 0x0, &sel, EINVAL);
 
 	/* Valid parameter */
-	errno = 0;
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, 0x0);
-	EXPECT_EQ(0, errno);
+	prctl_valid(_metadata, op, 0x0, 0x0, 0x0);
 
 	/* PR_SYS_DISPATCH_ON */
 	op = PR_SYS_DISPATCH_ON;
 
 	/* Dispatcher region is bad (offset > 0 && len == 0) */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel);
-	EXPECT_EQ(EINVAL, errno);
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel);
-	EXPECT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0x1, 0x0, &sel, EINVAL);
+	prctl_invalid(_metadata, op, -1L, 0x0, &sel, EINVAL);
 
 	/* Invalid selector */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x1, (void *) -1);
-	ASSERT_EQ(EFAULT, errno);
+	prctl_invalid(_metadata, op, 0x0, 0x1, (void *) -1, EFAULT);
 
 	/*
 	 * Dispatcher range overflows unsigned long
 	 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 1, -1L, &sel);
-	ASSERT_EQ(EINVAL, errno) {
-		TH_LOG("Should reject bad syscall range");
-	}
+	prctl_invalid(_metadata, PR_SYS_DISPATCH_ON, 1, -1L, &sel, EINVAL);
 
 	/*
 	 * Allowed range overflows usigned long
 	 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, -1L, 0x1, &sel);
-	ASSERT_EQ(EINVAL, errno) {
-		TH_LOG("Should reject bad syscall range");
-	}
+	prctl_invalid(_metadata, PR_SYS_DISPATCH_ON, -1L, 0x1, &sel, EINVAL);
 }
 
 /*
diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
index 8757f738b0b1..0aad682b12c8 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -76,7 +76,8 @@ static void reference_chacha20_blocks(uint8_t *dst_bytes, const uint32_t *key, u
 
 void __weak __arch_chacha20_blocks_nostack(uint8_t *dst_bytes, const uint32_t *key, uint32_t *counter, size_t nblocks)
 {
-	ksft_exit_skip("Not implemented on architecture\n");
+	ksft_test_result_skip("Not implemented on architecture\n");
+	ksft_finished();
 }
 
 int main(int argc, char *argv[])
diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index f04479ecc96c..ced72950cb1e 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -353,7 +353,7 @@ ikm_event_handler(struct trace_seq *s, struct tep_record *record,
 
 	if (config_has_id && (config_my_pid == id))
 		return 0;
-	else if (config_my_pid && (config_my_pid == pid))
+	else if (config_my_pid == pid)
 		return 0;
 
 	tep_print_event(trace_event->tep, s, record, "%16s-%-8d ", TEP_PRINT_COMM, TEP_PRINT_PID);
@@ -595,7 +595,7 @@ static int parse_arguments(char *monitor_name, int argc, char **argv)
 			config_reactor = optarg;
 			break;
 		case 's':
-			config_my_pid = 0;
+			config_my_pid = -1;
 			break;
 		case 't':
 			config_trace = 1;

