Return-Path: <stable+bounces-202990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43870CCC226
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 14:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 775BE303E4AA
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A18C33AD8A;
	Thu, 18 Dec 2025 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TBlfirpD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DE338F20;
	Thu, 18 Dec 2025 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065597; cv=none; b=jNHwNrmYTzsnvYQC9oNzy1DE8RQbH7/Q8ccUwfihi11NIqHtLjwHjJi/VOieL3Tw0NGEqhy7IDF63lR47Ul0qTr0TbcaUD0Sxw64g0TuQhvrRc+1NkQB8K2iylx/GU1LgmaWzo+qPzm5FUK/g0NQBMU6Xia7emeILHdeTONM9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065597; c=relaxed/simple;
	bh=o/sKIQS95R6IyXc/sNp9bQ4xOR6uM3rCbEyQo9+MukM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqepR4UFZU2toqUa7QqRBrj4Ur6vQM90quVEsAzoHCf+EPWCCMixNpGbhP2HRQ+QuUUe2+SJFrN7II6Rur8N9FG6qQx04zfiRbFkCOJI/CD8O4rrUqNOkyAVlT0sstztrGG7h4W1vTviC1GOQ208IgWafn6dys4Ck1qypdz1KyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TBlfirpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA042C116B1;
	Thu, 18 Dec 2025 13:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766065596;
	bh=o/sKIQS95R6IyXc/sNp9bQ4xOR6uM3rCbEyQo9+MukM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBlfirpDPEW+GBYGQUAWWXDN6PgwYwWBJb8qyWcmU+iVP/R+/r7+rhdqyAmbuofpW
	 I6ApcIyUuRDjf++KILDXxwEfZ1PxpzJ0IsNiCxHmAN+xOUE3mmlPjjTlLXQbvzS0UT
	 Iq4XwiCGmE8aDIiNLRFRWKKw4uc5eiCKygmkAaRM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.17.13
Date: Thu, 18 Dec 2025 14:46:20 +0100
Message-ID: <2025121823-studio-deduce-622a@gregkh>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2025121823-avid-hatchback-83fb@gregkh>
References: <2025121823-avid-hatchback-83fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/LSM/Smack.rst b/Documentation/admin-guide/LSM/Smack.rst
index 6d44f4fdbf59..c5ed775f2d10 100644
--- a/Documentation/admin-guide/LSM/Smack.rst
+++ b/Documentation/admin-guide/LSM/Smack.rst
@@ -601,10 +601,15 @@ specification.
 Task Attribute
 ~~~~~~~~~~~~~~
 
-The Smack label of a process can be read from /proc/<pid>/attr/current. A
-process can read its own Smack label from /proc/self/attr/current. A
+The Smack label of a process can be read from ``/proc/<pid>/attr/current``. A
+process can read its own Smack label from ``/proc/self/attr/current``. A
 privileged process can change its own Smack label by writing to
-/proc/self/attr/current but not the label of another process.
+``/proc/self/attr/current`` but not the label of another process.
+
+Format of writing is : only the label or the label followed by one of the
+3 trailers: ``\n`` (by common agreement for ``/proc/...`` interfaces),
+``\0`` (because some applications incorrectly include it),
+``\n\0`` (because we think some applications may incorrectly include it).
 
 File Attribute
 ~~~~~~~~~~~~~~
@@ -696,6 +701,11 @@ sockets.
 	A privileged program may set this to match the label of another
 	task with which it hopes to communicate.
 
+UNIX domain socket (UDS) with a BSD address functions both as a file in a
+filesystem and as a socket. As a file, it carries the SMACK64 attribute. This
+attribute is not involved in Smack security enforcement and is immutably
+assigned the label "*".
+
 Smack Netlabel Exceptions
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/Documentation/devicetree/bindings/clock/qcom,x1e80100-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,x1e80100-gcc.yaml
index 68dde0720c71..1b15b5070954 100644
--- a/Documentation/devicetree/bindings/clock/qcom,x1e80100-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,x1e80100-gcc.yaml
@@ -32,9 +32,36 @@ properties:
       - description: PCIe 5 pipe clock
       - description: PCIe 6a pipe clock
       - description: PCIe 6b pipe clock
-      - description: USB QMP Phy 0 clock source
-      - description: USB QMP Phy 1 clock source
-      - description: USB QMP Phy 2 clock source
+      - description: USB4_0 QMPPHY clock source
+      - description: USB4_1 QMPPHY clock source
+      - description: USB4_2 QMPPHY clock source
+      - description: USB4_0 PHY DP0 GMUX clock source
+      - description: USB4_0 PHY DP1 GMUX clock source
+      - description: USB4_0 PHY PCIE PIPEGMUX clock source
+      - description: USB4_0 PHY PIPEGMUX clock source
+      - description: USB4_0 PHY SYS PCIE PIPEGMUX clock source
+      - description: USB4_1 PHY DP0 GMUX 2 clock source
+      - description: USB4_1 PHY DP1 GMUX 2 clock source
+      - description: USB4_1 PHY PCIE PIPEGMUX clock source
+      - description: USB4_1 PHY PIPEGMUX clock source
+      - description: USB4_1 PHY SYS PCIE PIPEGMUX clock source
+      - description: USB4_2 PHY DP0 GMUX 2 clock source
+      - description: USB4_2 PHY DP1 GMUX 2 clock source
+      - description: USB4_2 PHY PCIE PIPEGMUX clock source
+      - description: USB4_2 PHY PIPEGMUX clock source
+      - description: USB4_2 PHY SYS PCIE PIPEGMUX clock source
+      - description: USB4_0 PHY RX 0 clock source
+      - description: USB4_0 PHY RX 1 clock source
+      - description: USB4_1 PHY RX 0 clock source
+      - description: USB4_1 PHY RX 1 clock source
+      - description: USB4_2 PHY RX 0 clock source
+      - description: USB4_2 PHY RX 1 clock source
+      - description: USB4_0 PHY PCIE PIPE clock source
+      - description: USB4_0 PHY max PIPE clock source
+      - description: USB4_1 PHY PCIE PIPE clock source
+      - description: USB4_1 PHY max PIPE clock source
+      - description: USB4_2 PHY PCIE PIPE clock source
+      - description: USB4_2 PHY max PIPE clock source
 
   power-domains:
     description:
@@ -67,7 +94,34 @@ examples:
                <&pcie6b_phy>,
                <&usb_1_ss0_qmpphy 0>,
                <&usb_1_ss1_qmpphy 1>,
-               <&usb_1_ss2_qmpphy 2>;
+               <&usb_1_ss2_qmpphy 2>,
+               <&usb4_0_phy_dp0_gmux_clk>,
+               <&usb4_0_phy_dp1_gmux_clk>,
+               <&usb4_0_phy_pcie_pipegmux_clk>,
+               <&usb4_0_phy_pipegmux_clk>,
+               <&usb4_0_phy_sys_pcie_pipegmux_clk>,
+               <&usb4_1_phy_dp0_gmux_2_clk>,
+               <&usb4_1_phy_dp1_gmux_2_clk>,
+               <&usb4_1_phy_pcie_pipegmux_clk>,
+               <&usb4_1_phy_pipegmux_clk>,
+               <&usb4_1_phy_sys_pcie_pipegmux_clk>,
+               <&usb4_2_phy_dp0_gmux_2_clk>,
+               <&usb4_2_phy_dp1_gmux_2_clk>,
+               <&usb4_2_phy_pcie_pipegmux_clk>,
+               <&usb4_2_phy_pipegmux_clk>,
+               <&usb4_2_phy_sys_pcie_pipegmux_clk>,
+               <&usb4_0_phy_rx_0_clk>,
+               <&usb4_0_phy_rx_1_clk>,
+               <&usb4_1_phy_rx_0_clk>,
+               <&usb4_1_phy_rx_1_clk>,
+               <&usb4_2_phy_rx_0_clk>,
+               <&usb4_2_phy_rx_1_clk>,
+               <&usb4_0_phy_pcie_pipe_clk>,
+               <&usb4_0_phy_max_pipe_clk>,
+               <&usb4_1_phy_pcie_pipe_clk>,
+               <&usb4_1_phy_max_pipe_clk>,
+               <&usb4_2_phy_pcie_pipe_clk>,
+               <&usb4_2_phy_max_pipe_clk>;
       power-domains = <&rpmhpd RPMHPD_CX>;
       #clock-cells = <1>;
       #reset-cells = <1>;
diff --git a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
index 79a21ba0f9fd..c8258ef40328 100644
--- a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
@@ -36,13 +36,13 @@ properties:
 
   reg:
     items:
-      - description: External local bus interface registers
+      - description: Data Bus Interface registers
       - description: Meson designed configuration registers
       - description: PCIe configuration space
 
   reg-names:
     items:
-      - const: elbi
+      - const: dbi
       - const: cfg
       - const: config
 
@@ -113,7 +113,7 @@ examples:
     pcie: pcie@f9800000 {
         compatible = "amlogic,axg-pcie", "snps,dw-pcie";
         reg = <0xf9800000 0x400000>, <0xff646000 0x2000>, <0xf9f00000 0x100000>;
-        reg-names = "elbi", "cfg", "config";
+        reg-names = "dbi", "cfg", "config";
         interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
         clocks = <&pclk>, <&clk_port>, <&clk_phy>;
         clock-names = "pclk", "port", "general";
diff --git a/Documentation/hwmon/g762.rst b/Documentation/hwmon/g762.rst
index 0371b3365c48..f224552a2d3c 100644
--- a/Documentation/hwmon/g762.rst
+++ b/Documentation/hwmon/g762.rst
@@ -17,7 +17,7 @@ done via a userland daemon like fancontrol.
 Note that those entries do not provide ways to setup the specific
 hardware characteristics of the system (reference clock, pulses per
 fan revolution, ...); Those can be modified via devicetree bindings
-documented in Documentation/devicetree/bindings/hwmon/g762.txt or
+documented in Documentation/devicetree/bindings/hwmon/gmt,g762.yaml or
 using a specific platform_data structure in board initialization
 file (see include/linux/platform_data/g762.h).
 
diff --git a/Makefile b/Makefile
index 49052b005854..dcfa99bf0e1b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 17
-SUBLEVEL = 12
+SUBLEVEL = 13
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/boot/dts/renesas/r8a7793-gose.dts b/arch/arm/boot/dts/renesas/r8a7793-gose.dts
index 45b267ec2679..5c6928c941ac 100644
--- a/arch/arm/boot/dts/renesas/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/renesas/r8a7793-gose.dts
@@ -373,7 +373,6 @@ adv7180_in: endpoint {
 				port@3 {
 					reg = <3>;
 					adv7180_out: endpoint {
-						bus-width = <8>;
 						remote-endpoint = <&vin1ep>;
 					};
 				};
diff --git a/arch/arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts b/arch/arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts
index 3258b2e27434..4a72aa7663f2 100644
--- a/arch/arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts
+++ b/arch/arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts
@@ -308,8 +308,6 @@ &rtc0 {
 
 &switch {
 	status = "okay";
-	#address-cells = <1>;
-	#size-cells = <0>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pins_eth3>, <&pins_eth4>, <&pins_mdio1>;
diff --git a/arch/arm/boot/dts/samsung/exynos4210-i9100.dts b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
index df229fb8a16b..8a635bee59fa 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
@@ -853,6 +853,7 @@ &sdhci_3 {
 	#size-cells = <0>;
 
 	non-removable;
+	cap-power-off-card;
 	bus-width = <4>;
 	mmc-pwrseq = <&wlan_pwrseq>;
 	vmmc-supply = <&vtf_reg>;
diff --git a/arch/arm/boot/dts/samsung/exynos4210-trats.dts b/arch/arm/boot/dts/samsung/exynos4210-trats.dts
index 95e0e01b6ff6..6bd902cb8f4a 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-trats.dts
@@ -518,6 +518,7 @@ &sdhci_3 {
 	#size-cells = <0>;
 
 	non-removable;
+	cap-power-off-card;
 	bus-width = <4>;
 	mmc-pwrseq = <&wlan_pwrseq>;
 	vmmc-supply = <&tflash_reg>;
diff --git a/arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts b/arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts
index bdc30f8cf748..91490693432b 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts
@@ -610,6 +610,7 @@ &sdhci_3 {
 	#size-cells = <0>;
 
 	non-removable;
+	cap-power-off-card;
 	bus-width = <4>;
 	mmc-pwrseq = <&wlan_pwrseq>;
 	vmmc-supply = <&ldo5_reg>;
diff --git a/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi b/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
index 05ddddb565ee..48245b1665a6 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
@@ -1440,6 +1440,7 @@ &sdhci_3 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	non-removable;
+	cap-power-off-card;
 	bus-width = <4>;
 
 	mmc-pwrseq = <&wlan_pwrseq>;
diff --git a/arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi b/arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi
index bf0c32027baf..370b2afbf15b 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi
@@ -185,13 +185,13 @@ touch@44 {
 		interrupt-parent = <&gpioi>;
 		vio-supply = <&v3v3>;
 		vcc-supply = <&v3v3>;
+		st,sample-time = <4>;
+		st,mod-12b = <1>;
+		st,ref-sel = <0>;
+		st,adc-freq = <1>;
 
 		touchscreen {
 			compatible = "st,stmpe-ts";
-			st,sample-time = <4>;
-			st,mod-12b = <1>;
-			st,ref-sel = <0>;
-			st,adc-freq = <1>;
 			st,ave-ctrl = <1>;
 			st,touch-det-delay = <2>;
 			st,settling = <2>;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dts b/arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dts
index f66d57bb685e..f0519ab30141 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dts
@@ -222,10 +222,10 @@ &gpio3 {
 		"ModeA1",
 		"ModeA2",
 		"ModeA3",
-		"NC",
-		"NC",
-		"NC",
-		"NC",
+		"ModeB0",
+		"ModeB1",
+		"ModeB2",
+		"ModeB3",
 		"NC",
 		"NC",
 		"NC",
diff --git a/arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts b/arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts
index 08ee0f8ea68f..71b39a923d37 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts
@@ -291,7 +291,7 @@ codec {
 		};
 
 		twl_power: power {
-			compatible = "ti,twl4030-power-beagleboard-xm", "ti,twl4030-power-idle-osc-off";
+			compatible = "ti,twl4030-power-idle-osc-off";
 			ti,use_poweroff;
 		};
 	};
diff --git a/arch/arm/boot/dts/ti/omap/omap3-n900.dts b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
index c50ca572d1b9..7db73d9bed9e 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-n900.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
@@ -508,7 +508,7 @@ twl_audio: audio {
 	};
 
 	twl_power: power {
-		compatible = "ti,twl4030-power-n900", "ti,twl4030-power-idle-osc-off";
+		compatible = "ti,twl4030-power-idle-osc-off";
 		ti,use_poweroff;
 	};
 };
diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
index f9a3897b06e7..5023f98d8293 100644
--- a/arch/arm/include/asm/word-at-a-time.h
+++ b/arch/arm/include/asm/word-at-a-time.h
@@ -67,7 +67,7 @@ static inline unsigned long find_zero(unsigned long mask)
  */
 static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
-	unsigned long ret, offset;
+	unsigned long ret, tmp;
 
 	/* Load word from unaligned pointer addr */
 	asm(
@@ -75,9 +75,9 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 	"2:\n"
 	"	.pushsection .text.fixup,\"ax\"\n"
 	"	.align 2\n"
-	"3:	and	%1, %2, #0x3\n"
-	"	bic	%2, %2, #0x3\n"
-	"	ldr	%0, [%2]\n"
+	"3:	bic	%1, %2, #0x3\n"
+	"	ldr	%0, [%1]\n"
+	"	and	%1, %2, #0x3\n"
 	"	lsl	%1, %1, #0x3\n"
 #ifndef __ARMEB__
 	"	lsr	%0, %0, %1\n"
@@ -90,7 +90,7 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 	"	.align	3\n"
 	"	.long	1b, 3b\n"
 	"	.popsection"
-	: "=&r" (ret), "=&r" (offset)
+	: "=&r" (ret), "=&r" (tmp)
 	: "r" (addr), "Qo" (*(unsigned long *)addr));
 
 	return ret;
diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index c0f8c25861a9..668de6b2b9de 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1401,9 +1401,9 @@ cmu_apm: clock-controller@17400000 {
 			clock-names = "oscclk";
 		};
 
-		sysreg_apm: syscon@174204e0 {
+		sysreg_apm: syscon@17420000 {
 			compatible = "google,gs101-apm-sysreg", "syscon";
-			reg = <0x174204e0 0x1000>;
+			reg = <0x17420000 0x10000>;
 		};
 
 		pmu_system_controller: system-controller@17460000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
index 752caa38eb03..266038fbbef9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
@@ -351,17 +351,6 @@ MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX	0x140
 		>;
 	};
 
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
-			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
-			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
-			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
-			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
-			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
-		>;
-	};
-
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
index cbf0c9a740fa..fb159199b39d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
@@ -395,13 +395,6 @@ &i2c3 {
 	status = "okay";
 };
 
-/* off-board header */
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
 /* console */
 &uart2 {
 	pinctrl-names = "default";
@@ -409,25 +402,6 @@ &uart2 {
 	status = "okay";
 };
 
-/* off-board header */
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	status = "okay";
-};
-
-/* off-board */
-&usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
-};
-
 /* eMMC */
 &usdhc3 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
@@ -523,13 +497,6 @@ MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19	0x400001c2
 		>;
 	};
 
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
-			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
-		>;
-	};
-
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
@@ -537,24 +504,6 @@ MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
 		>;
 	};
 
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX	0x140
-			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x190
-			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d0
-			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d0
-			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d0
-			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d0
-			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d0
-		>;
-	};
-
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi
index cf747ec6fa16..76020ef89bf3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi
@@ -365,17 +365,6 @@ MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX	0x140
 		>;
 	};
 
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x190
-			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d0
-			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d0
-			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d0
-			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d0
-			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d0
-		>;
-	};
-
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 46f6e0fbf2b0..29630b666d54 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -44,6 +44,7 @@ chosen {
 
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
+		fan-supply = <&reg_vcc_12v>;
 		#cooling-cells = <2>;
 		cooling-levels = <64 128 192 255>;
 		pwms = <&tpm6 0 4000000 PWM_POLARITY_INVERTED>;
diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index 180124cc5bce..16c40d11d3b5 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -115,7 +115,7 @@ &flexspi1 {
 	flash0: flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <80000000>;
+		spi-max-frequency = <66000000>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		vcc-supply = <&reg_1v8>;
@@ -617,7 +617,7 @@ pinctrl_tpm4: tpm4grp {
 		fsl,pins = <IMX95_PAD_GPIO_IO05__TPM4_CH0			0x51e>;
 	};
 
-	pinctrl_tpm5: tpm4grp {
+	pinctrl_tpm5: tpm5grp {
 		fsl,pins = <IMX95_PAD_GPIO_IO06__TPM5_CH0			0x51e>;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index f91605de4909..8575f4aff94c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3496,6 +3496,9 @@ usb2: usb@76f8800 {
 					  <&gcc GCC_USB20_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <60000000>;
 
+			interconnects = <&pnoc MASTER_USB_HS &bimc SLAVE_EBI_CH0>,
+					<&bimc MASTER_AMPSS_M0 &pnoc SLAVE_USB_HS>;
+			interconnect-names = "usb-ddr", "apps-usb";
 			power-domains = <&gcc USB30_GDSC>;
 			qcom,select-utmi-as-pipe-clk;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 6b7070dad3df..7705ef6ebea1 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -565,6 +565,20 @@ qup_uart4_default: qup-uart4-default-state {
 				bias-disable;
 			};
 
+			cci0_default: cci0-default-state {
+				pins = "gpio22", "gpio23";
+				function = "cci_i2c";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cci1_default: cci1-default-state {
+				pins = "gpio29", "gpio30";
+				function = "cci_i2c";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			sdc1_state_on: sdc1-on-state {
 				clk-pins {
 					pins = "sdc1_clk";
@@ -1629,25 +1643,61 @@ adreno_smmu: iommu@59a0000 {
 			#iommu-cells = <2>;
 		};
 
-		camss: camss@5c6e000 {
+		cci: cci@5c1b000 {
+			compatible = "qcom,qcm2290-cci", "qcom,msm8996-cci";
+			reg = <0x0 0x5c1b000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 206 IRQ_TYPE_EDGE_RISING>;
+
+			clocks = <&gcc GCC_CAMSS_TOP_AHB_CLK>, <&gcc GCC_CAMSS_CCI_0_CLK>;
+			clock-names = "ahb", "cci";
+			assigned-clocks = <&gcc GCC_CAMSS_CCI_0_CLK>;
+			assigned-clock-rates = <37500000>;
+
+			power-domains = <&gcc GCC_CAMSS_TOP_GDSC>;
+
+			pinctrl-0 = <&cci0_default &cci1_default>;
+			pinctrl-names = "default";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+
+			cci_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <400000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <400000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		camss: camss@5c11000 {
 			compatible = "qcom,qcm2290-camss";
 
-			reg = <0x0 0x5c6e000 0x0 0x1000>,
+			reg = <0x0 0x5c11000 0x0 0x1000>,
+			      <0x0 0x5c6e000 0x0 0x1000>,
 			      <0x0 0x5c75000 0x0 0x1000>,
 			      <0x0 0x5c52000 0x0 0x1000>,
 			      <0x0 0x5c53000 0x0 0x1000>,
 			      <0x0 0x5c66000 0x0 0x400>,
 			      <0x0 0x5c68000 0x0 0x400>,
-			      <0x0 0x5c11000 0x0 0x1000>,
 			      <0x0 0x5c6f000 0x0 0x4000>,
 			      <0x0 0x5c76000 0x0 0x4000>;
-			reg-names = "csid0",
+			reg-names = "top",
+				    "csid0",
 				    "csid1",
 				    "csiphy0",
 				    "csiphy1",
 				    "csitpg0",
 				    "csitpg1",
-				    "top",
 				    "vfe0",
 				    "vfe1";
 
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index e115b6a52b29..82494b41bd9a 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -47,6 +47,8 @@ framebuffer0: framebuffer@a000000 {
 			stride = <(1224 * 4)>;
 			format = "a8r8g8b8";
 			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
+			vci-supply = <&vreg_oled_vci>;
+			dvdd-supply = <&vreg_oled_dvdd>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index b9a0f7ac4d9c..3fe4e8b76334 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -118,6 +118,11 @@ cdsp_mem: cdsp@88f00000 {
 			no-map;
 		};
 
+		removed_mem: removed@c0000000 {
+			reg = <0x0 0xc0000000 0x0 0x5100000>;
+			no-map;
+		};
+
 		rmtfs_mem: rmtfs@f8500000 {
 			compatible = "qcom,rmtfs-mem";
 			reg = <0x0 0xf8500000 0x0 0x600000>;
diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index b2e0fc5501c1..af29c7ed7a68 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -648,7 +648,7 @@ key_volp_n: key-volp-n-state {
 &uart3 {
 	/delete-property/ interrupts;
 	interrupts-extended = <&intc GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
-			      <&tlmm 11 IRQ_TYPE_LEVEL_HIGH>;
+			      <&tlmm 11 IRQ_TYPE_EDGE_FALLING>;
 	pinctrl-0 = <&uart3_default>;
 	pinctrl-1 = <&uart3_sleep>;
 	pinctrl-names = "default", "sleep";
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index b118d666e535..942e0f0d6d9b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -799,8 +799,8 @@ hall_sensor_default: hall-sensor-default-state {
 		bias-disable;
 	};
 
-	tri_state_key_default: tri-state-key-default-state {
-		pins = "gpio40", "gpio42", "gpio26";
+	alert_slider_default: alert-slider-default-state {
+		pins = "gpio126", "gpio52", "gpio24";
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index d686531bf4ea..1a17870dcf6d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -143,7 +143,7 @@ rmtfs_mem: rmtfs-mem@fde00000 {
 		};
 	};
 
-	i2c21 {
+	i2c-21 {
 		compatible = "i2c-gpio";
 		sda-gpios = <&tlmm 127 GPIO_ACTIVE_HIGH>;
 		scl-gpios = <&tlmm 128 GPIO_ACTIVE_HIGH>;
@@ -584,15 +584,15 @@ &uart9 {
 &i2c14 {
 	status = "okay";
 
-	pmic@66 {
+	max77705: pmic@66 {
 		compatible = "maxim,max77705";
 		reg = <0x66>;
+		#interrupt-cells = <1>;
 		interrupt-parent = <&pm8998_gpios>;
 		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
 		pinctrl-0 = <&pmic_int_default>;
 		pinctrl-names = "default";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		leds {
 			compatible = "maxim,max77705-rgb";
@@ -631,9 +631,8 @@ max77705_charger: charger@69 {
 		reg = <0x69>;
 		compatible = "maxim,max77705-charger";
 		monitored-battery = <&battery>;
-		interrupt-parent = <&pm8998_gpios>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-
+		interrupt-parent = <&max77705>;
+		interrupts = <0>;
 	};
 
 	fuel-gauge@36 {
@@ -641,8 +640,8 @@ fuel-gauge@36 {
 		compatible = "maxim,max77705-battery";
 		power-supplies = <&max77705_charger>;
 		maxim,rsns-microohm = <5000>;
-		interrupt-parent = <&pm8998_gpios>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&max77705>;
+		interrupts = <2>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index e14d3d778b71..d7ed45027ff4 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4020,6 +4020,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 
 			iommus = <&apps_smmu 0x60 0>;
 
+			dma-coherent;
+
 			lanes-per-direction = <2>;
 			qcom,ice = <&ice>;
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index a9a7bb676c6f..67c888ae94de 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4859,6 +4859,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			interconnect-names = "usb-ddr",
 					     "apps-usb";
 
+			qcom,select-utmi-as-pipe-clk;
 			wakeup-source;
 
 			status = "disabled";
@@ -4876,15 +4877,8 @@ usb_2_dwc3: usb@a200000 {
 
 				dma-coherent;
 
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					port@0 {
-						reg = <0>;
-
-						usb_2_dwc3_hs: endpoint {
-						};
+				port {
+					usb_2_dwc3_hs: endpoint {
 					};
 				};
 			};
diff --git a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
index 2c1ab75e4d91..e5af9c056ac9 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
@@ -118,13 +118,13 @@ memory@600000000 {
 	};
 
 	/* Page 27 / DSI to Display */
-	mini-dp-con {
+	dp-con {
 		compatible = "dp-connector";
 		label = "CN6";
 		type = "full-size";
 
 		port {
-			mini_dp_con_in: endpoint {
+			dp_con_in: endpoint {
 				remote-endpoint = <&sn65dsi86_out>;
 			};
 		};
@@ -371,7 +371,7 @@ sn65dsi86_in: endpoint {
 					port@1 {
 						reg = <1>;
 						sn65dsi86_out: endpoint {
-							remote-endpoint = <&mini_dp_con_in>;
+							remote-endpoint = <&dp_con_in>;
 						};
 					};
 				};
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
index 6224d72813e5..80ac40555e02 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
@@ -466,6 +466,7 @@ eeprom: eeprom@50 {
 		compatible = "belling,bl24c16a", "atmel,24c16";
 		reg = <0x50>;
 		pagesize = <16>;
+		vcc-supply = <&vcca1v8_pmu>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index f894742b1ebe..6ed8b15e6cdf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -221,6 +221,13 @@ regulator-state-mem {
 			regulator-off-in-suspend;
 		};
 	};
+
+	eeprom: eeprom@50 {
+		compatible = "belling,bl24c16a", "atmel,24c16";
+		reg = <0x50>;
+		pagesize = <16>;
+		vcc-supply = <&vcc_3v3_pmu>;
+	};
 };
 
 &i2c2 {
@@ -242,12 +249,6 @@ regulator-state-mem {
 			regulator-off-in-suspend;
 		};
 	};
-
-	eeprom: eeprom@50 {
-		compatible = "belling,bl24c16a", "atmel,24c16";
-		reg = <0x50>;
-		pagesize = <16>;
-	};
 };
 
 &i2c3 {
@@ -593,7 +594,7 @@ regulator-state-mem {
 				};
 			};
 
-			vcc_3v3_s3: dcdc-reg8 {
+			vcc_3v3_pmu: vcc_3v3_s3: dcdc-reg8 {
 				regulator-name = "vcc_3v3_s3";
 				regulator-always-on;
 				regulator-boot-on;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 75a15c368c11..dd24c40c7965 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -59,7 +59,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripheral window */
 			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
 			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01d20000>, /* Second peripheral window */
-			 <0x00 0x0fd00000 0x00 0x0fd00000 0x00 0x00020000>, /* GPU */
+			 <0x00 0x0fd80000 0x00 0x0fd80000 0x00 0x00080000>, /* GPU */
 			 <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>, /* Third peripheral window */
 			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
 			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00010100>, /* CSI window */
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index f4a8c9877249..1beb578c6411 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -263,10 +263,9 @@ interrupt_return:
 	mtspr	SPRN_SRR1,r12
 
 BEGIN_FTR_SECTION
+	lwarx   r0,0,r1
+END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1		/* to clear the reservation */
-FTR_SECTION_ELSE
-	lwarx	r0,0,r1
-ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 	lwz	r3,_CCR(r1)
 	lwz	r4,_LINK(r1)
@@ -306,10 +305,9 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	mtspr	SPRN_SRR1,r12
 
 BEGIN_FTR_SECTION
+	lwarx   r0,0,r1
+END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1		/* to clear the reservation */
-FTR_SECTION_ELSE
-	lwarx	r0,0,r1
-ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 	lwz	r3,_LINK(r1)
 	lwz	r4,_CTR(r1)
diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index 3702b0bdab14..426bdca4667e 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -697,8 +697,8 @@ int remove_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size)
 		 * two half.
 		 */
 		else {
+			size = mem_rngs->ranges[i].end - end + 1;
 			mem_rngs->ranges[i].end = base - 1;
-			size = mem_rngs->ranges[i].end - end;
 			ret = add_mem_range(mem_ranges, end + 1, size);
 		}
 	}
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 4693c464fc5a..1e062056cfb8 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1302,11 +1302,14 @@ static void __init htab_initialize(void)
 	unsigned long table;
 	unsigned long pteg_count;
 	unsigned long prot;
-	phys_addr_t base = 0, size = 0, end;
+	phys_addr_t base = 0, size = 0, end, limit = MEMBLOCK_ALLOC_ANYWHERE;
 	u64 i;
 
 	DBG(" -> htab_initialize()\n");
 
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		limit = ppc64_rma_size;
+
 	if (mmu_has_feature(MMU_FTR_1T_SEGMENT)) {
 		mmu_kernel_ssize = MMU_SEGSIZE_1T;
 		mmu_highuser_ssize = MMU_SEGSIZE_1T;
@@ -1322,7 +1325,7 @@ static void __init htab_initialize(void)
 		// Too early to use nr_cpu_ids, so use NR_CPUS
 		tmp = memblock_phys_alloc_range(sizeof(struct stress_hpt_struct) * NR_CPUS,
 						__alignof__(struct stress_hpt_struct),
-						0, MEMBLOCK_ALLOC_ANYWHERE);
+						MEMBLOCK_LOW_LIMIT, limit);
 		memset((void *)tmp, 0xff, sizeof(struct stress_hpt_struct) * NR_CPUS);
 		stress_hpt_struct = __va(tmp);
 
@@ -1356,11 +1359,10 @@ static void __init htab_initialize(void)
 			mmu_hash_ops.hpte_clear_all();
 #endif
 	} else {
-		unsigned long limit = MEMBLOCK_ALLOC_ANYWHERE;
 
 		table = memblock_phys_alloc_range(htab_size_bytes,
 						  htab_size_bytes,
-						  0, limit);
+						  MEMBLOCK_LOW_LIMIT, limit);
 		if (!table)
 			panic("ERROR: Failed to allocate %pa bytes below %pa\n",
 			      &htab_size_bytes, &limit);
diff --git a/arch/powerpc/mm/ptdump/hashpagetable.c b/arch/powerpc/mm/ptdump/hashpagetable.c
index a6baa6166d94..671d0dc00c6d 100644
--- a/arch/powerpc/mm/ptdump/hashpagetable.c
+++ b/arch/powerpc/mm/ptdump/hashpagetable.c
@@ -216,6 +216,8 @@ static int native_find(unsigned long ea, int psize, bool primary, u64 *v, u64
 	vpn  = hpt_vpn(ea, vsid, ssize);
 	hash = hpt_hash(vpn, shift, ssize);
 	want_v = hpte_encode_avpn(vpn, psize, ssize);
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		want_v = hpte_old_to_new_v(want_v);
 
 	/* to check in the secondary hash table, we invert the hash */
 	if (!primary)
@@ -229,6 +231,10 @@ static int native_find(unsigned long ea, int psize, bool primary, u64 *v, u64
 			/* HPTE matches */
 			*v = be64_to_cpu(hptep->v);
 			*r = be64_to_cpu(hptep->r);
+			if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+				*v = hpte_new_to_old_v(*v, *r);
+				*r = hpte_new_to_old_r(*r);
+			}
 			return 0;
 		}
 		++hpte_group;
diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index 97dec18e6989..3dbd6a09d482 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -424,6 +424,22 @@ static int system_opcode_insn(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	return (rc <= 0) ? rc : 1;
 }
 
+static bool is_load_guest_page_fault(unsigned long scause)
+{
+	/**
+	 * If a g-stage page fault occurs, the direct approach
+	 * is to let the g-stage page fault handler handle it
+	 * naturally, however, calling the g-stage page fault
+	 * handler here seems rather strange.
+	 * Considering this is a corner case, we can directly
+	 * return to the guest and re-execute the same PC, this
+	 * will trigger a g-stage page fault again and then the
+	 * regular g-stage page fault handler will populate
+	 * g-stage page table.
+	 */
+	return (scause == EXC_LOAD_GUEST_PAGE_FAULT);
+}
+
 /**
  * kvm_riscv_vcpu_virtual_insn -- Handle virtual instruction trap
  *
@@ -449,6 +465,8 @@ int kvm_riscv_vcpu_virtual_insn(struct kvm_vcpu *vcpu, struct kvm_run *run,
 							  ct->sepc,
 							  &utrap);
 			if (utrap.scause) {
+				if (is_load_guest_page_fault(utrap.scause))
+					return 1;
 				utrap.sepc = ct->sepc;
 				kvm_riscv_vcpu_trap_redirect(vcpu, &utrap);
 				return 1;
@@ -504,6 +522,8 @@ int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		insn = kvm_riscv_vcpu_unpriv_read(vcpu, true, ct->sepc,
 						  &utrap);
 		if (utrap.scause) {
+			if (is_load_guest_page_fault(utrap.scause))
+				return 1;
 			/* Redirect trap if we failed to read instruction */
 			utrap.sepc = ct->sepc;
 			kvm_riscv_vcpu_trap_redirect(vcpu, &utrap);
@@ -630,6 +650,8 @@ int kvm_riscv_vcpu_mmio_store(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		insn = kvm_riscv_vcpu_unpriv_read(vcpu, true, ct->sepc,
 						  &utrap);
 		if (utrap.scause) {
+			if (is_load_guest_page_fault(utrap.scause))
+				return 1;
 			/* Redirect trap if we failed to read instruction */
 			utrap.sepc = ct->sepc;
 			kvm_riscv_vcpu_trap_redirect(vcpu, &utrap);
diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
index 135bb89c0a89..8f2dd6e879ff 100644
--- a/arch/s390/include/asm/fpu-insn.h
+++ b/arch/s390/include/asm/fpu-insn.h
@@ -12,6 +12,7 @@
 #ifndef __ASSEMBLER__
 
 #include <linux/instrumented.h>
+#include <linux/kmsan.h>
 #include <asm/asm-extable.h>
 
 asm(".include \"asm/fpu-insn-asm.h\"\n");
@@ -393,6 +394,7 @@ static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
 		     : [vxr] "=Q" (*(u8 *)vxr)
 		     : [index] "d" (index), [v1] "I" (v1)
 		     : "memory");
+	kmsan_unpoison_memory(vxr, size);
 }
 
 #else /* CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS */
@@ -409,6 +411,7 @@ static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
 		: [vxr] "=R" (*(u8 *)vxr)
 		: [index] "d" (index), [v1] "I" (v1)
 		: "memory", "1");
+	kmsan_unpoison_memory(vxr, size);
 }
 
 #endif /* CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS */
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index e88ebe5339fc..4b0ce76c6bbd 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -697,6 +697,7 @@ static void __ref smp_get_core_info(struct sclp_core_info *info, int early)
 				continue;
 			info->core[info->configured].core_id =
 				address >> smp_cpu_mt_shift;
+			info->core[info->configured].type = boot_core_type;
 			info->configured++;
 		}
 		info->combined = info->configured;
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 7be0143b5ba3..721b652ffb65 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -46,19 +46,17 @@ ARCH_INCLUDE	:= -I$(srctree)/$(SHARED_HEADERS)
 ARCH_INCLUDE	+= -I$(srctree)/$(HOST_DIR)/um/shared
 KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/um
 
-# -Dvmap=kernel_vmap prevents anything from referencing the libpcap.o symbol so
-# named - it's a common symbol in libpcap, so we get a binary which crashes.
-#
-# Same things for in6addr_loopback and mktime - found in libc. For these two we
-# only get link-time error, luckily.
+# -Dstrrchr=kernel_strrchr (as well as the various in6addr symbols) prevents
+#  anything from referencing
+# libc symbols with the same name, which can cause a linker error.
 #
 # -Dlongjmp=kernel_longjmp prevents anything from referencing the libpthread.a
 # embedded copy of longjmp, same thing for setjmp.
 #
-# These apply to USER_CFLAGS to.
+# These apply to USER_CFLAGS too.
 
 KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
-	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap	\
+	$(ARCH_INCLUDE) $(MODE_INCLUDE)	\
 	-Dlongjmp=kernel_longjmp -Dsetjmp=kernel_setjmp \
 	-Din6addr_loopback=kernel_in6addr_loopback \
 	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr \
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index bdd26050dff7..0e89e197e112 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -3,6 +3,7 @@
 #include <asm/bootparam.h>
 #include <asm/bootparam_utils.h>
 #include <asm/e820/types.h>
+#include <asm/pgtable.h>
 #include <asm/processor.h>
 #include "../string.h"
 #include "efi.h"
@@ -168,9 +169,10 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 		 * For 4- to 5-level paging transition, set up current CR3 as
 		 * the first and the only entry in a new top-level page table.
 		 */
-		*trampoline_32bit = __native_read_cr3() | _PAGE_TABLE_NOENC;
+		*trampoline_32bit = native_read_cr3_pa() | _PAGE_TABLE_NOENC;
 	} else {
-		unsigned long src;
+		u64 *new_cr3;
+		pgd_t *pgdp;
 
 		/*
 		 * For 5- to 4-level paging transition, copy page table pointed
@@ -180,8 +182,9 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 		 * We cannot just point to the page table from trampoline as it
 		 * may be above 4G.
 		 */
-		src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
-		memcpy(trampoline_32bit, (void *)src, PAGE_SIZE);
+		pgdp = (pgd_t *)native_read_cr3_pa();
+		new_cr3 = (u64 *)(native_pgd_val(pgdp[0]) & PTE_PFN_MASK);
+		memcpy(trampoline_32bit, new_cr3, PAGE_SIZE);
 	}
 
 	toggle_la57(trampoline_32bit);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 38f7102e2dac..dc77e11f2365 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1344,6 +1344,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 				hwc->state |= PERF_HES_ARCH;
 
 			x86_pmu_stop(event, PERF_EF_UPDATE);
+			cpuc->events[hwc->idx] = NULL;
 		}
 
 		/*
@@ -1365,6 +1366,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 			 * if cpuc->enabled = 0, then no wrmsr as
 			 * per x86_pmu_enable_event()
 			 */
+			cpuc->events[hwc->idx] = event;
 			x86_pmu_start(event, PERF_EF_RELOAD);
 		}
 		cpuc->n_added = 0;
@@ -1531,7 +1533,6 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 
 	event->hw.state = 0;
 
-	cpuc->events[idx] = event;
 	__set_bit(idx, cpuc->active_mask);
 	static_call(x86_pmu_enable)(event);
 	perf_event_update_userpage(event);
@@ -1610,7 +1611,6 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 	if (test_bit(hwc->idx, cpuc->active_mask)) {
 		static_call(x86_pmu_disable)(event);
 		__clear_bit(hwc->idx, cpuc->active_mask);
-		cpuc->events[hwc->idx] = NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 		hwc->state |= PERF_HES_STOPPED;
 	}
@@ -1648,6 +1648,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	 * Not a TXN, therefore cleanup properly.
 	 */
 	x86_pmu_stop(event, PERF_EF_UPDATE);
+	cpuc->events[event->hw.idx] = NULL;
 
 	for (i = 0; i < cpuc->n_events; i++) {
 		if (event == cpuc->event_list[i])
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 046d12281fd9..76cd840e33e3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3249,6 +3249,9 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		if (!test_bit(bit, cpuc->active_mask))
 			continue;
+		/* Event may have already been cleared: */
+		if (!event)
+			continue;
 
 		/*
 		 * There may be unprocessed PEBS records in the PEBS buffer,
@@ -4029,7 +4032,9 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
 	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
-		flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
+		flags &= ~PERF_SAMPLE_REGS_USER;
+	if (event->attr.sample_regs_intr & ~PEBS_GP_REGS)
+		flags &= ~PERF_SAMPLE_REGS_INTR;
 	return flags;
 }
 
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index ec753e39b007..6f5286a99e0c 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -70,7 +70,7 @@
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
  *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
- *						ADL,RPL,MTL,ARL,LNL
+ *						ADL,RPL,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
@@ -522,7 +522,6 @@ static const struct cstate_model lnl_cstates __initconst = {
 				  BIT(PERF_CSTATE_CORE_C7_RES),
 
 	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
-				  BIT(PERF_CSTATE_PKG_C3_RES) |
 				  BIT(PERF_CSTATE_PKG_C6_RES) |
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 71ee20102a8a..b10684dedc58 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -181,8 +181,8 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
  * in false positive reports. Disable instrumentation to avoid those.
  */
 __no_kmsan_checks
-static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
-			unsigned long *stack, const char *log_lvl)
+static void __show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
+				 unsigned long *stack, const char *log_lvl)
 {
 	struct unwind_state state;
 	struct stack_info stack_info = {0};
@@ -303,6 +303,25 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
+static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
+			       unsigned long *stack, const char *log_lvl)
+{
+	/*
+	 * Disable KASAN to avoid false positives during walking another
+	 * task's stacks, as values on these stacks may change concurrently
+	 * with task execution.
+	 */
+	bool disable_kasan = task && task != current;
+
+	if (disable_kasan)
+		kasan_disable_current();
+
+	__show_trace_log_lvl(task, regs, stack, log_lvl);
+
+	if (disable_kasan)
+		kasan_enable_current();
+}
+
 void show_stack(struct task_struct *task, unsigned long *sp,
 		       const char *loglvl)
 {
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 4c9f20a689f7..8cb2987db786 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -200,13 +200,13 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
 		unsigned int nr_vecs = __blkdev_sectors_to_bio_pages(nr_sects);
 		struct bio *bio;
 
-		bio = bio_alloc(bdev, nr_vecs, REQ_OP_WRITE, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-
 		if ((flags & BLKDEV_ZERO_KILLABLE) &&
 		    fatal_signal_pending(current))
 			break;
 
+		bio = bio_alloc(bdev, nr_vecs, REQ_OP_WRITE, gfp_mask);
+		bio->bi_iter.bi_sector = sector;
+
 		do {
 			unsigned int len, added;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 19f62b070ca9..77261fba5090 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -23,6 +23,7 @@
 #include <linux/cache.h>
 #include <linux/sched/topology.h>
 #include <linux/sched/signal.h>
+#include <linux/suspend.h>
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
@@ -335,12 +336,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
 
-	mutex_lock(&set->tag_list_lock);
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_quiesce_queue_nowait(q);
 	}
-	mutex_unlock(&set->tag_list_lock);
+	rcu_read_unlock();
 
 	blk_mq_wait_quiesce_done(set);
 }
@@ -350,12 +351,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
 
-	mutex_lock(&set->tag_list_lock);
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_unquiesce_queue(q);
 	}
-	mutex_unlock(&set->tag_list_lock);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
 
@@ -3721,6 +3722,7 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 {
 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
 			struct blk_mq_hw_ctx, cpuhp_online);
+	int ret = 0;
 
 	if (blk_mq_hctx_has_online_cpu(hctx, cpu))
 		return 0;
@@ -3741,12 +3743,24 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	 * frozen and there are no requests.
 	 */
 	if (percpu_ref_tryget(&hctx->queue->q_usage_counter)) {
-		while (blk_mq_hctx_has_requests(hctx))
+		while (blk_mq_hctx_has_requests(hctx)) {
+			/*
+			 * The wakeup capable IRQ handler of block device is
+			 * not called during suspend. Skip the loop by checking
+			 * pm_wakeup_pending to prevent the deadlock and improve
+			 * suspend latency.
+			 */
+			if (pm_wakeup_pending()) {
+				clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+				ret = -EBUSY;
+				break;
+			}
 			msleep(5);
+		}
 		percpu_ref_put(&hctx->queue->q_usage_counter);
 	}
 
-	return 0;
+	return ret;
 }
 
 /*
@@ -4303,7 +4317,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 	struct blk_mq_tag_set *set = q->tag_set;
 
 	mutex_lock(&set->tag_list_lock);
-	list_del(&q->tag_set_list);
+	list_del_rcu(&q->tag_set_list);
 	if (list_is_singular(&set->tag_list)) {
 		/* just transitioned to unshared */
 		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
@@ -4311,7 +4325,6 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 		blk_mq_update_tag_set_shared(set, false);
 	}
 	mutex_unlock(&set->tag_list_lock);
-	INIT_LIST_HEAD(&q->tag_set_list);
 }
 
 static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
@@ -4330,7 +4343,7 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 	}
 	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
 		queue_set_hctx_shared(q, true);
-	list_add_tail(&q->tag_set_list, &set->tag_list);
+	list_add_tail_rcu(&q->tag_set_list, &set->tag_list);
 
 	mutex_unlock(&set->tag_list_lock);
 }
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 2c5b64b1a724..c19d052a8f2f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -22,9 +22,7 @@
 #define THROTL_QUANTUM 32
 
 /* Throttling is performed over a slice and after that slice is renewed */
-#define DFL_THROTL_SLICE_HD (HZ / 10)
-#define DFL_THROTL_SLICE_SSD (HZ / 50)
-#define MAX_THROTL_SLICE (HZ)
+#define DFL_THROTL_SLICE (HZ / 10)
 
 /* A workqueue to queue throttle related work */
 static struct workqueue_struct *kthrotld_workqueue;
@@ -1341,10 +1339,7 @@ static int blk_throtl_init(struct gendisk *disk)
 		goto out;
 	}
 
-	if (blk_queue_nonrot(q))
-		td->throtl_slice = DFL_THROTL_SLICE_SSD;
-	else
-		td->throtl_slice = DFL_THROTL_SLICE_HD;
+	td->throtl_slice = DFL_THROTL_SLICE;
 	td->track_bio_latency = !queue_is_mq(q);
 	if (!td->track_bio_latency)
 		blk_stat_enable_accounting(q);
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 2e689b2c4021..77250fcecb54 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -71,7 +71,6 @@ struct io_stats_per_prio {
  * present on both sort_list[] and fifo_list[].
  */
 struct dd_per_prio {
-	struct list_head dispatch;
 	struct rb_root sort_list[DD_DIR_COUNT];
 	struct list_head fifo_list[DD_DIR_COUNT];
 	/* Position of the most recently dispatched request. */
@@ -84,6 +83,7 @@ struct deadline_data {
 	 * run time data
 	 */
 
+	struct list_head dispatch;
 	struct dd_per_prio per_prio[DD_PRIO_COUNT];
 
 	/* Data direction of latest dispatched request. */
@@ -310,6 +310,19 @@ static bool started_after(struct deadline_data *dd, struct request *rq,
 	return time_after(start_time, latest_start);
 }
 
+static struct request *dd_start_request(struct deadline_data *dd,
+					enum dd_data_dir data_dir,
+					struct request *rq)
+{
+	u8 ioprio_class = dd_rq_ioclass(rq);
+	enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+
+	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
+	dd->per_prio[prio].stats.dispatched++;
+	rq->rq_flags |= RQF_STARTED;
+	return rq;
+}
+
 /*
  * deadline_dispatch_requests selects the best request according to
  * read/write expire, fifo_batch, etc and with a start time <= @latest_start.
@@ -320,21 +333,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 {
 	struct request *rq, *next_rq;
 	enum dd_data_dir data_dir;
-	enum dd_prio prio;
-	u8 ioprio_class;
 
 	lockdep_assert_held(&dd->lock);
 
-	if (!list_empty(&per_prio->dispatch)) {
-		rq = list_first_entry(&per_prio->dispatch, struct request,
-				      queuelist);
-		if (started_after(dd, rq, latest_start))
-			return NULL;
-		list_del_init(&rq->queuelist);
-		data_dir = rq_data_dir(rq);
-		goto done;
-	}
-
 	/*
 	 * batches are currently reads XOR writes
 	 */
@@ -414,13 +415,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	 */
 	dd->batching++;
 	deadline_move_request(dd, per_prio, rq);
-done:
-	ioprio_class = dd_rq_ioclass(rq);
-	prio = ioprio_class_to_prio[ioprio_class];
-	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
-	dd->per_prio[prio].stats.dispatched++;
-	rq->rq_flags |= RQF_STARTED;
-	return rq;
+	return dd_start_request(dd, data_dir, rq);
 }
 
 /*
@@ -467,6 +462,14 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	enum dd_prio prio;
 
 	spin_lock(&dd->lock);
+
+	if (!list_empty(&dd->dispatch)) {
+		rq = list_first_entry(&dd->dispatch, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		dd_start_request(dd, rq_data_dir(rq), rq);
+		goto unlock;
+	}
+
 	rq = dd_dispatch_prio_aged_requests(dd, now);
 	if (rq)
 		goto unlock;
@@ -555,10 +558,10 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 
 	eq->elevator_data = dd;
 
+	INIT_LIST_HEAD(&dd->dispatch);
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
-		INIT_LIST_HEAD(&per_prio->dispatch);
 		INIT_LIST_HEAD(&per_prio->fifo_list[DD_READ]);
 		INIT_LIST_HEAD(&per_prio->fifo_list[DD_WRITE]);
 		per_prio->sort_list[DD_READ] = RB_ROOT;
@@ -662,7 +665,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	trace_block_rq_insert(rq);
 
 	if (flags & BLK_MQ_INSERT_AT_HEAD) {
-		list_add(&rq->queuelist, &per_prio->dispatch);
+		list_add(&rq->queuelist, &dd->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
 		deadline_add_rq_rb(per_prio, rq);
@@ -729,8 +732,7 @@ static void dd_finish_request(struct request *rq)
 
 static bool dd_has_work_for_prio(struct dd_per_prio *per_prio)
 {
-	return !list_empty_careful(&per_prio->dispatch) ||
-		!list_empty_careful(&per_prio->fifo_list[DD_READ]) ||
+	return !list_empty_careful(&per_prio->fifo_list[DD_READ]) ||
 		!list_empty_careful(&per_prio->fifo_list[DD_WRITE]);
 }
 
@@ -739,6 +741,9 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
 	enum dd_prio prio;
 
+	if (!list_empty_careful(&dd->dispatch))
+		return true;
+
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++)
 		if (dd_has_work_for_prio(&dd->per_prio[prio]))
 			return true;
@@ -947,49 +952,39 @@ static int dd_owned_by_driver_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-#define DEADLINE_DISPATCH_ATTR(prio)					\
-static void *deadline_dispatch##prio##_start(struct seq_file *m,	\
-					     loff_t *pos)		\
-	__acquires(&dd->lock)						\
-{									\
-	struct request_queue *q = m->private;				\
-	struct deadline_data *dd = q->elevator->elevator_data;		\
-	struct dd_per_prio *per_prio = &dd->per_prio[prio];		\
-									\
-	spin_lock(&dd->lock);						\
-	return seq_list_start(&per_prio->dispatch, *pos);		\
-}									\
-									\
-static void *deadline_dispatch##prio##_next(struct seq_file *m,		\
-					    void *v, loff_t *pos)	\
-{									\
-	struct request_queue *q = m->private;				\
-	struct deadline_data *dd = q->elevator->elevator_data;		\
-	struct dd_per_prio *per_prio = &dd->per_prio[prio];		\
-									\
-	return seq_list_next(v, &per_prio->dispatch, pos);		\
-}									\
-									\
-static void deadline_dispatch##prio##_stop(struct seq_file *m, void *v)	\
-	__releases(&dd->lock)						\
-{									\
-	struct request_queue *q = m->private;				\
-	struct deadline_data *dd = q->elevator->elevator_data;		\
-									\
-	spin_unlock(&dd->lock);						\
-}									\
-									\
-static const struct seq_operations deadline_dispatch##prio##_seq_ops = { \
-	.start	= deadline_dispatch##prio##_start,			\
-	.next	= deadline_dispatch##prio##_next,			\
-	.stop	= deadline_dispatch##prio##_stop,			\
-	.show	= blk_mq_debugfs_rq_show,				\
+static void *deadline_dispatch_start(struct seq_file *m, loff_t *pos)
+	__acquires(&dd->lock)
+{
+	struct request_queue *q = m->private;
+	struct deadline_data *dd = q->elevator->elevator_data;
+
+	spin_lock(&dd->lock);
+	return seq_list_start(&dd->dispatch, *pos);
+}
+
+static void *deadline_dispatch_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct request_queue *q = m->private;
+	struct deadline_data *dd = q->elevator->elevator_data;
+
+	return seq_list_next(v, &dd->dispatch, pos);
+}
+
+static void deadline_dispatch_stop(struct seq_file *m, void *v)
+	__releases(&dd->lock)
+{
+	struct request_queue *q = m->private;
+	struct deadline_data *dd = q->elevator->elevator_data;
+
+	spin_unlock(&dd->lock);
 }
 
-DEADLINE_DISPATCH_ATTR(0);
-DEADLINE_DISPATCH_ATTR(1);
-DEADLINE_DISPATCH_ATTR(2);
-#undef DEADLINE_DISPATCH_ATTR
+static const struct seq_operations deadline_dispatch_seq_ops = {
+	.start	= deadline_dispatch_start,
+	.next	= deadline_dispatch_next,
+	.stop	= deadline_dispatch_stop,
+	.show	= blk_mq_debugfs_rq_show,
+};
 
 #define DEADLINE_QUEUE_DDIR_ATTRS(name)					\
 	{#name "_fifo_list", 0400,					\
@@ -1012,9 +1007,7 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
 	{"batching", 0400, deadline_batching_show},
 	{"starved", 0400, deadline_starved_show},
 	{"async_depth", 0400, dd_async_depth_show},
-	{"dispatch0", 0400, .seq_ops = &deadline_dispatch0_seq_ops},
-	{"dispatch1", 0400, .seq_ops = &deadline_dispatch1_seq_ops},
-	{"dispatch2", 0400, .seq_ops = &deadline_dispatch2_seq_ops},
+	{"dispatch", 0400, .seq_ops = &deadline_dispatch_seq_ops},
 	{"owned_by_driver", 0400, dd_owned_by_driver_show},
 	{"queued", 0400, dd_queued_show},
 	{},
diff --git a/crypto/aead.c b/crypto/aead.c
index 5d14b775036e..51ab3af691af 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -120,6 +120,7 @@ static int crypto_aead_init_tfm(struct crypto_tfm *tfm)
 	struct aead_alg *alg = crypto_aead_alg(aead);
 
 	crypto_aead_set_flags(aead, CRYPTO_TFM_NEED_KEY);
+	crypto_aead_set_reqsize(aead, crypto_tfm_alg_reqsize(tfm));
 
 	aead->authsize = alg->maxauthsize;
 
diff --git a/crypto/ahash.c b/crypto/ahash.c
index a227793d2c5b..09a02ed4c4a0 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -423,7 +423,11 @@ static int ahash_update_finish(struct ahash_request *req, int err)
 
 	req->nbytes += nonzero - blen;
 
-	blen = err < 0 ? 0 : err + nonzero;
+	blen = 0;
+	if (err >= 0) {
+		blen = err + nonzero;
+		err = 0;
+	}
 	if (ahash_request_isvirt(req))
 		memcpy(buf, req->svirt + req->nbytes - blen, blen);
 	else
@@ -661,6 +665,12 @@ int crypto_ahash_import_core(struct ahash_request *req, const void *in)
 						in);
 	if (crypto_ahash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		return -ENOKEY;
+	if (crypto_ahash_block_only(tfm)) {
+		unsigned int reqsize = crypto_ahash_reqsize(tfm);
+		u8 *buf = ahash_request_ctx(req);
+
+		buf[reqsize - 1] = 0;
+	}
 	return crypto_ahash_alg(tfm)->import_core(req, in);
 }
 EXPORT_SYMBOL_GPL(crypto_ahash_import_core);
@@ -674,10 +684,14 @@ int crypto_ahash_import(struct ahash_request *req, const void *in)
 	if (crypto_ahash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		return -ENOKEY;
 	if (crypto_ahash_block_only(tfm)) {
+		unsigned int plen = crypto_ahash_blocksize(tfm) + 1;
 		unsigned int reqsize = crypto_ahash_reqsize(tfm);
+		unsigned int ss = crypto_ahash_statesize(tfm);
 		u8 *buf = ahash_request_ctx(req);
 
-		buf[reqsize - 1] = 0;
+		memcpy(buf + reqsize - plen, in + ss - plen, plen);
+		if (buf[reqsize - 1] >= plen)
+			return -EOVERFLOW;
 	}
 	return crypto_ahash_alg(tfm)->import(req, in);
 }
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index ba2d9d1ea235..348966ea2175 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -11,6 +11,7 @@
 #include <crypto/public_key.h>
 #include <linux/seq_file.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <keys/system_keyring.h>
@@ -141,12 +142,17 @@ struct asymmetric_key_id *asymmetric_key_generate_id(const void *val_1,
 						     size_t len_2)
 {
 	struct asymmetric_key_id *kid;
-
-	kid = kmalloc(sizeof(struct asymmetric_key_id) + len_1 + len_2,
-		      GFP_KERNEL);
+	size_t kid_sz;
+	size_t len;
+
+	if (check_add_overflow(len_1, len_2, &len))
+		return ERR_PTR(-EOVERFLOW);
+	if (check_add_overflow(sizeof(struct asymmetric_key_id), len, &kid_sz))
+		return ERR_PTR(-EOVERFLOW);
+	kid = kmalloc(kid_sz, GFP_KERNEL);
 	if (!kid)
 		return ERR_PTR(-ENOMEM);
-	kid->len = len_1 + len_2;
+	kid->len = len;
 	memcpy(kid->data, val_1, len_1);
 	memcpy(kid->data + len_1, val_2, len_2);
 	return kid;
diff --git a/crypto/authenc.c b/crypto/authenc.c
index a723769c8777..ac679ce2cb95 100644
--- a/crypto/authenc.c
+++ b/crypto/authenc.c
@@ -37,7 +37,7 @@ struct authenc_request_ctx {
 
 static void authenc_request_complete(struct aead_request *req, int err)
 {
-	if (err != -EINPROGRESS)
+	if (err != -EINPROGRESS && err != -EBUSY)
 		aead_request_complete(req, err);
 }
 
@@ -107,27 +107,42 @@ static int crypto_authenc_setkey(struct crypto_aead *authenc, const u8 *key,
 	return err;
 }
 
-static void authenc_geniv_ahash_done(void *data, int err)
+static void authenc_geniv_ahash_finish(struct aead_request *req)
 {
-	struct aead_request *req = data;
 	struct crypto_aead *authenc = crypto_aead_reqtfm(req);
 	struct aead_instance *inst = aead_alg_instance(authenc);
 	struct authenc_instance_ctx *ictx = aead_instance_ctx(inst);
 	struct authenc_request_ctx *areq_ctx = aead_request_ctx(req);
 	struct ahash_request *ahreq = (void *)(areq_ctx->tail + ictx->reqoff);
 
-	if (err)
-		goto out;
-
 	scatterwalk_map_and_copy(ahreq->result, req->dst,
 				 req->assoclen + req->cryptlen,
 				 crypto_aead_authsize(authenc), 1);
+}
 
-out:
+static void authenc_geniv_ahash_done(void *data, int err)
+{
+	struct aead_request *req = data;
+
+	if (!err)
+		authenc_geniv_ahash_finish(req);
 	aead_request_complete(req, err);
 }
 
-static int crypto_authenc_genicv(struct aead_request *req, unsigned int flags)
+/*
+ * Used when the ahash request was invoked in the async callback context
+ * of the previous skcipher request.  Eat any EINPROGRESS notifications.
+ */
+static void authenc_geniv_ahash_done2(void *data, int err)
+{
+	struct aead_request *req = data;
+
+	if (!err)
+		authenc_geniv_ahash_finish(req);
+	authenc_request_complete(req, err);
+}
+
+static int crypto_authenc_genicv(struct aead_request *req, unsigned int mask)
 {
 	struct crypto_aead *authenc = crypto_aead_reqtfm(req);
 	struct aead_instance *inst = aead_alg_instance(authenc);
@@ -136,6 +151,7 @@ static int crypto_authenc_genicv(struct aead_request *req, unsigned int flags)
 	struct crypto_ahash *auth = ctx->auth;
 	struct authenc_request_ctx *areq_ctx = aead_request_ctx(req);
 	struct ahash_request *ahreq = (void *)(areq_ctx->tail + ictx->reqoff);
+	unsigned int flags = aead_request_flags(req) & ~mask;
 	u8 *hash = areq_ctx->tail;
 	int err;
 
@@ -143,7 +159,8 @@ static int crypto_authenc_genicv(struct aead_request *req, unsigned int flags)
 	ahash_request_set_crypt(ahreq, req->dst, hash,
 				req->assoclen + req->cryptlen);
 	ahash_request_set_callback(ahreq, flags,
-				   authenc_geniv_ahash_done, req);
+				   mask ? authenc_geniv_ahash_done2 :
+					  authenc_geniv_ahash_done, req);
 
 	err = crypto_ahash_digest(ahreq);
 	if (err)
@@ -159,12 +176,11 @@ static void crypto_authenc_encrypt_done(void *data, int err)
 {
 	struct aead_request *areq = data;
 
-	if (err)
-		goto out;
-
-	err = crypto_authenc_genicv(areq, 0);
-
-out:
+	if (err) {
+		aead_request_complete(areq, err);
+		return;
+	}
+	err = crypto_authenc_genicv(areq, CRYPTO_TFM_REQ_MAY_SLEEP);
 	authenc_request_complete(areq, err);
 }
 
@@ -199,11 +215,18 @@ static int crypto_authenc_encrypt(struct aead_request *req)
 	if (err)
 		return err;
 
-	return crypto_authenc_genicv(req, aead_request_flags(req));
+	return crypto_authenc_genicv(req, 0);
+}
+
+static void authenc_decrypt_tail_done(void *data, int err)
+{
+	struct aead_request *req = data;
+
+	authenc_request_complete(req, err);
 }
 
 static int crypto_authenc_decrypt_tail(struct aead_request *req,
-				       unsigned int flags)
+				       unsigned int mask)
 {
 	struct crypto_aead *authenc = crypto_aead_reqtfm(req);
 	struct aead_instance *inst = aead_alg_instance(authenc);
@@ -214,6 +237,7 @@ static int crypto_authenc_decrypt_tail(struct aead_request *req,
 	struct skcipher_request *skreq = (void *)(areq_ctx->tail +
 						  ictx->reqoff);
 	unsigned int authsize = crypto_aead_authsize(authenc);
+	unsigned int flags = aead_request_flags(req) & ~mask;
 	u8 *ihash = ahreq->result + authsize;
 	struct scatterlist *src, *dst;
 
@@ -230,7 +254,9 @@ static int crypto_authenc_decrypt_tail(struct aead_request *req,
 
 	skcipher_request_set_tfm(skreq, ctx->enc);
 	skcipher_request_set_callback(skreq, flags,
-				      req->base.complete, req->base.data);
+				      mask ? authenc_decrypt_tail_done :
+					     req->base.complete,
+				      mask ? req : req->base.data);
 	skcipher_request_set_crypt(skreq, src, dst,
 				   req->cryptlen - authsize, req->iv);
 
@@ -241,12 +267,11 @@ static void authenc_verify_ahash_done(void *data, int err)
 {
 	struct aead_request *req = data;
 
-	if (err)
-		goto out;
-
-	err = crypto_authenc_decrypt_tail(req, 0);
-
-out:
+	if (err) {
+		aead_request_complete(req, err);
+		return;
+	}
+	err = crypto_authenc_decrypt_tail(req, CRYPTO_TFM_REQ_MAY_SLEEP);
 	authenc_request_complete(req, err);
 }
 
@@ -273,7 +298,7 @@ static int crypto_authenc_decrypt(struct aead_request *req)
 	if (err)
 		return err;
 
-	return crypto_authenc_decrypt_tail(req, aead_request_flags(req));
+	return crypto_authenc_decrypt_tail(req, 0);
 }
 
 static int crypto_authenc_init_tfm(struct crypto_aead *tfm)
diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 6f77d1794e48..8e6a60897479 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -183,7 +183,6 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
 
 	up(&job->hwctx->priv->job_sem);
 	job->job_done = true;
-	dma_fence_put(fence);
 	mmput_async(job->mm);
 	aie2_job_put(job);
 }
@@ -198,10 +197,13 @@ aie2_sched_resp_handler(void *handle, void __iomem *data, size_t size)
 
 	cmd_abo = job->cmd_bo;
 
-	if (unlikely(!data))
+	if (unlikely(job->job_timeout)) {
+		amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_TIMEOUT);
+		ret = -EINVAL;
 		goto out;
+	}
 
-	if (unlikely(size != sizeof(u32))) {
+	if (unlikely(!data) || unlikely(size != sizeof(u32))) {
 		amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_ABORT);
 		ret = -EINVAL;
 		goto out;
@@ -254,6 +256,13 @@ aie2_sched_cmdlist_resp_handler(void *handle, void __iomem *data, size_t size)
 	int ret = 0;
 
 	cmd_abo = job->cmd_bo;
+
+	if (unlikely(job->job_timeout)) {
+		amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_TIMEOUT);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (unlikely(!data) || unlikely(size != sizeof(u32) * 3)) {
 		amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_ABORT);
 		ret = -EINVAL;
@@ -356,6 +365,7 @@ aie2_sched_job_timedout(struct drm_sched_job *sched_job)
 
 	xdna = hwctx->client->xdna;
 	trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
+	job->job_timeout = true;
 	mutex_lock(&xdna->dev_lock);
 	aie2_hwctx_stop(xdna, hwctx, sched_job);
 
@@ -665,17 +675,19 @@ void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
 	ndev->hwctx_num--;
 
 	XDNA_DBG(xdna, "%s sequence number %lld", hwctx->name, hwctx->priv->seq);
-	drm_sched_entity_destroy(&hwctx->priv->entity);
-
 	aie2_hwctx_wait_for_idle(hwctx);
 
 	/* Request fw to destroy hwctx and cancel the rest pending requests */
 	aie2_release_resource(hwctx);
 
+	mutex_unlock(&xdna->dev_lock);
+	drm_sched_entity_destroy(&hwctx->priv->entity);
+
 	/* Wait for all submitted jobs to be completed or canceled */
 	wait_event(hwctx->priv->job_free_wq,
 		   atomic64_read(&hwctx->job_submit_cnt) ==
 		   atomic64_read(&hwctx->job_free_cnt));
+	mutex_lock(&xdna->dev_lock);
 
 	drm_sched_fini(&hwctx->priv->sched);
 	aie2_ctx_syncobj_destroy(hwctx);
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index b47a7f8e9017..7242af5346f9 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -375,6 +375,7 @@ void amdxdna_sched_job_cleanup(struct amdxdna_sched_job *job)
 	trace_amdxdna_debug_point(job->hwctx->name, job->seq, "job release");
 	amdxdna_arg_bos_put(job);
 	amdxdna_gem_put_obj(job->cmd_bo);
+	dma_fence_put(job->fence);
 }
 
 int amdxdna_cmd_submit(struct amdxdna_client *client,
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index c652229547a3..e454b19d6ba7 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -105,6 +105,7 @@ struct amdxdna_sched_job {
 	/* user can wait on this fence */
 	struct dma_fence	*out_fence;
 	bool			job_done;
+	bool			job_timeout;
 	u64			seq;
 	struct amdxdna_gem_obj	*cmd_bo;
 	size_t			bo_cnt;
diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index da1ac89bb78f..6634a4d5717f 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -513,6 +513,7 @@ xdna_mailbox_create_channel(struct mailbox *mb,
 	}
 
 	mb_chann->bad_state = false;
+	mailbox_reg_write(mb_chann, mb_chann->iohub_int_addr, 0);
 
 	MB_DBG(mb_chann, "Mailbox channel created (irq: %d)", mb_chann->msix_irq);
 	return mb_chann;
diff --git a/drivers/accel/ivpu/ivpu_fw.h b/drivers/accel/ivpu/ivpu_fw.h
index 9a3935be1c05..7081913fb0dd 100644
--- a/drivers/accel/ivpu/ivpu_fw.h
+++ b/drivers/accel/ivpu/ivpu_fw.h
@@ -45,7 +45,7 @@ struct ivpu_fw_info {
 int ivpu_fw_init(struct ivpu_device *vdev);
 void ivpu_fw_fini(struct ivpu_device *vdev);
 void ivpu_fw_load(struct ivpu_device *vdev);
-void ivpu_fw_boot_params_setup(struct ivpu_device *vdev, struct vpu_boot_params *bp);
+void ivpu_fw_boot_params_setup(struct ivpu_device *vdev, struct vpu_boot_params *boot_params);
 
 static inline bool ivpu_fw_is_cold_boot(struct ivpu_device *vdev)
 {
diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index 59cfcf3eaded..fda0a18e6d63 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -27,8 +27,8 @@ static const struct drm_gem_object_funcs ivpu_gem_funcs;
 static inline void ivpu_dbg_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, const char *action)
 {
 	ivpu_dbg(vdev, BO,
-		 "%6s: bo %8p vpu_addr %9llx size %8zu ctx %d has_pages %d dma_mapped %d mmu_mapped %d wc %d imported %d\n",
-		 action, bo, bo->vpu_addr, ivpu_bo_size(bo), bo->ctx_id,
+		 "%6s: bo %8p size %9zu ctx %d vpu_addr %9llx pages %d sgt %d mmu_mapped %d wc %d imported %d\n",
+		 action, bo, ivpu_bo_size(bo), bo->ctx_id, bo->vpu_addr,
 		 (bool)bo->base.pages, (bool)bo->base.sgt, bo->mmu_mapped, bo->base.map_wc,
 		 (bool)drm_gem_is_imported(&bo->base.base));
 }
@@ -43,22 +43,47 @@ static inline void ivpu_bo_unlock(struct ivpu_bo *bo)
 	dma_resv_unlock(bo->base.base.resv);
 }
 
+static struct sg_table *ivpu_bo_map_attachment(struct ivpu_device *vdev, struct ivpu_bo *bo)
+{
+	struct sg_table *sgt;
+
+	drm_WARN_ON(&vdev->drm, !bo->base.base.import_attach);
+
+	ivpu_bo_lock(bo);
+
+	sgt = bo->base.sgt;
+	if (!sgt) {
+		sgt = dma_buf_map_attachment(bo->base.base.import_attach, DMA_BIDIRECTIONAL);
+		if (IS_ERR(sgt))
+			ivpu_err(vdev, "Failed to map BO in IOMMU: %ld\n", PTR_ERR(sgt));
+		else
+			bo->base.sgt = sgt;
+	}
+
+	ivpu_bo_unlock(bo);
+
+	return sgt;
+}
+
 /*
- * ivpu_bo_pin() - pin the backing physical pages and map them to VPU.
+ * ivpu_bo_bind() - pin the backing physical pages and map them to VPU.
  *
  * This function pins physical memory pages, then maps the physical pages
  * to IOMMU address space and finally updates the VPU MMU page tables
  * to allow the VPU to translate VPU address to IOMMU address.
  */
-int __must_check ivpu_bo_pin(struct ivpu_bo *bo)
+int __must_check ivpu_bo_bind(struct ivpu_bo *bo)
 {
 	struct ivpu_device *vdev = ivpu_bo_to_vdev(bo);
 	struct sg_table *sgt;
 	int ret = 0;
 
-	ivpu_dbg_bo(vdev, bo, "pin");
+	ivpu_dbg_bo(vdev, bo, "bind");
 
-	sgt = drm_gem_shmem_get_pages_sgt(&bo->base);
+	if (bo->base.base.import_attach)
+		sgt = ivpu_bo_map_attachment(vdev, bo);
+	else
+		sgt = drm_gem_shmem_get_pages_sgt(&bo->base);
 	if (IS_ERR(sgt)) {
 		ret = PTR_ERR(sgt);
 		ivpu_err(vdev, "Failed to map BO in IOMMU: %d\n", ret);
@@ -99,7 +124,9 @@ ivpu_bo_alloc_vpu_addr(struct ivpu_bo *bo, struct ivpu_mmu_context *ctx,
 	ret = ivpu_mmu_context_insert_node(ctx, range, ivpu_bo_size(bo), &bo->mm_node);
 	if (!ret) {
 		bo->ctx = ctx;
+		bo->ctx_id = ctx->id;
 		bo->vpu_addr = bo->mm_node.start;
+		ivpu_dbg_bo(vdev, bo, "vaddr");
 	} else {
 		ivpu_err(vdev, "Failed to add BO to context %u: %d\n", ctx->id, ret);
 	}
@@ -115,7 +142,7 @@ static void ivpu_bo_unbind_locked(struct ivpu_bo *bo)
 {
 	struct ivpu_device *vdev = ivpu_bo_to_vdev(bo);
 
-	lockdep_assert(dma_resv_held(bo->base.base.resv) || !kref_read(&bo->base.base.refcount));
+	dma_resv_assert_held(bo->base.base.resv);
 
 	if (bo->mmu_mapped) {
 		drm_WARN_ON(&vdev->drm, !bo->ctx);
@@ -130,13 +157,15 @@ static void ivpu_bo_unbind_locked(struct ivpu_bo *bo)
 		bo->ctx = NULL;
 	}
 
-	if (drm_gem_is_imported(&bo->base.base))
-		return;
-
 	if (bo->base.sgt) {
-		dma_unmap_sgtable(vdev->drm.dev, bo->base.sgt, DMA_BIDIRECTIONAL, 0);
-		sg_free_table(bo->base.sgt);
-		kfree(bo->base.sgt);
+		if (bo->base.base.import_attach) {
+			dma_buf_unmap_attachment(bo->base.base.import_attach,
+						 bo->base.sgt, DMA_BIDIRECTIONAL);
+		} else {
+			dma_unmap_sgtable(vdev->drm.dev, bo->base.sgt, DMA_BIDIRECTIONAL, 0);
+			sg_free_table(bo->base.sgt);
+			kfree(bo->base.sgt);
+		}
 		bo->base.sgt = NULL;
 	}
 }
@@ -182,10 +211,11 @@ struct drm_gem_object *ivpu_gem_create_object(struct drm_device *dev, size_t siz
 struct drm_gem_object *ivpu_gem_prime_import(struct drm_device *dev,
 					     struct dma_buf *dma_buf)
 {
+	struct ivpu_device *vdev = to_ivpu_device(dev);
 	struct device *attach_dev = dev->dev;
 	struct dma_buf_attachment *attach;
-	struct sg_table *sgt;
 	struct drm_gem_object *obj;
+	struct ivpu_bo *bo;
 	int ret;
 
 	attach = dma_buf_attach(dma_buf, attach_dev);
@@ -194,25 +224,25 @@ struct drm_gem_object *ivpu_gem_prime_import(struct drm_device *dev,
 
 	get_dma_buf(dma_buf);
 
-	sgt = dma_buf_map_attachment_unlocked(attach, DMA_BIDIRECTIONAL);
-	if (IS_ERR(sgt)) {
-		ret = PTR_ERR(sgt);
-		goto fail_detach;
-	}
-
-	obj = drm_gem_shmem_prime_import_sg_table(dev, attach, sgt);
+	obj = drm_gem_shmem_prime_import_sg_table(dev, attach, NULL);
 	if (IS_ERR(obj)) {
 		ret = PTR_ERR(obj);
-		goto fail_unmap;
+		goto fail_detach;
 	}
 
 	obj->import_attach = attach;
 	obj->resv = dma_buf->resv;
 
+	bo = to_ivpu_bo(obj);
+
+	mutex_lock(&vdev->bo_list_lock);
+	list_add_tail(&bo->bo_list_node, &vdev->bo_list);
+	mutex_unlock(&vdev->bo_list_lock);
+
+	ivpu_dbg(vdev, BO, "import: bo %8p size %9zu\n", bo, ivpu_bo_size(bo));
+
 	return obj;
 
-fail_unmap:
-	dma_buf_unmap_attachment_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
 fail_detach:
 	dma_buf_detach(dma_buf, attach);
 	dma_buf_put(dma_buf);
@@ -220,7 +250,7 @@ struct drm_gem_object *ivpu_gem_prime_import(struct drm_device *dev,
 	return ERR_PTR(ret);
 }
 
-static struct ivpu_bo *ivpu_bo_alloc(struct ivpu_device *vdev, u64 size, u32 flags, u32 ctx_id)
+static struct ivpu_bo *ivpu_bo_alloc(struct ivpu_device *vdev, u64 size, u32 flags)
 {
 	struct drm_gem_shmem_object *shmem;
 	struct ivpu_bo *bo;
@@ -238,7 +268,6 @@ static struct ivpu_bo *ivpu_bo_alloc(struct ivpu_device *vdev, u64 size, u32 fla
 		return ERR_CAST(shmem);
 
 	bo = to_ivpu_bo(&shmem->base);
-	bo->ctx_id = ctx_id;
 	bo->base.map_wc = flags & DRM_IVPU_BO_WC;
 	bo->flags = flags;
 
@@ -246,7 +275,7 @@ static struct ivpu_bo *ivpu_bo_alloc(struct ivpu_device *vdev, u64 size, u32 fla
 	list_add_tail(&bo->bo_list_node, &vdev->bo_list);
 	mutex_unlock(&vdev->bo_list_lock);
 
-	ivpu_dbg_bo(vdev, bo, "alloc");
+	ivpu_dbg(vdev, BO, " alloc: bo %8p size %9llu\n", bo, size);
 
 	return bo;
 }
@@ -281,16 +310,22 @@ static void ivpu_gem_bo_free(struct drm_gem_object *obj)
 
 	ivpu_dbg_bo(vdev, bo, "free");
 
+	drm_WARN_ON(&vdev->drm, list_empty(&bo->bo_list_node));
+
 	mutex_lock(&vdev->bo_list_lock);
 	list_del(&bo->bo_list_node);
-	mutex_unlock(&vdev->bo_list_lock);
 
 	drm_WARN_ON(&vdev->drm, !drm_gem_is_imported(&bo->base.base) &&
 		    !dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_READ));
 	drm_WARN_ON(&vdev->drm, ivpu_bo_size(bo) == 0);
 	drm_WARN_ON(&vdev->drm, bo->base.vaddr);
 
+	ivpu_bo_lock(bo);
 	ivpu_bo_unbind_locked(bo);
+	ivpu_bo_unlock(bo);
+
+	mutex_unlock(&vdev->bo_list_lock);
+
 	drm_WARN_ON(&vdev->drm, bo->mmu_mapped);
 	drm_WARN_ON(&vdev->drm, bo->ctx);
 
@@ -326,7 +361,7 @@ int ivpu_bo_create_ioctl(struct drm_device *dev, void *data, struct drm_file *fi
 	if (size == 0)
 		return -EINVAL;
 
-	bo = ivpu_bo_alloc(vdev, size, args->flags, file_priv->ctx.id);
+	bo = ivpu_bo_alloc(vdev, size, args->flags);
 	if (IS_ERR(bo)) {
 		ivpu_err(vdev, "Failed to allocate BO: %pe (ctx %u size %llu flags 0x%x)",
 			 bo, file_priv->ctx.id, args->size, args->flags);
@@ -360,7 +395,7 @@ ivpu_bo_create(struct ivpu_device *vdev, struct ivpu_mmu_context *ctx,
 	drm_WARN_ON(&vdev->drm, !PAGE_ALIGNED(range->end));
 	drm_WARN_ON(&vdev->drm, !PAGE_ALIGNED(size));
 
-	bo = ivpu_bo_alloc(vdev, size, flags, IVPU_GLOBAL_CONTEXT_MMU_SSID);
+	bo = ivpu_bo_alloc(vdev, size, flags);
 	if (IS_ERR(bo)) {
 		ivpu_err(vdev, "Failed to allocate BO: %pe (vpu_addr 0x%llx size %llu flags 0x%x)",
 			 bo, range->start, size, flags);
@@ -371,7 +406,7 @@ ivpu_bo_create(struct ivpu_device *vdev, struct ivpu_mmu_context *ctx,
 	if (ret)
 		goto err_put;
 
-	ret = ivpu_bo_pin(bo);
+	ret = ivpu_bo_bind(bo);
 	if (ret)
 		goto err_put;
 
diff --git a/drivers/accel/ivpu/ivpu_gem.h b/drivers/accel/ivpu/ivpu_gem.h
index aa8ff14f7aae..ade0d127453f 100644
--- a/drivers/accel/ivpu/ivpu_gem.h
+++ b/drivers/accel/ivpu/ivpu_gem.h
@@ -24,7 +24,7 @@ struct ivpu_bo {
 	bool mmu_mapped;
 };
 
-int ivpu_bo_pin(struct ivpu_bo *bo);
+int ivpu_bo_bind(struct ivpu_bo *bo);
 void ivpu_bo_unbind_all_bos_from_context(struct ivpu_device *vdev, struct ivpu_mmu_context *ctx);
 
 struct drm_gem_object *ivpu_gem_create_object(struct drm_device *dev, size_t size);
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ivpu_hw_btrs.c
index b236c7234daa..05f4133c3511 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.c
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
@@ -753,7 +753,7 @@ int ivpu_hw_btrs_dct_get_request(struct ivpu_device *vdev, bool *enable)
 	}
 }
 
-void ivpu_hw_btrs_dct_set_status(struct ivpu_device *vdev, bool enable, u32 active_percent)
+void ivpu_hw_btrs_dct_set_status(struct ivpu_device *vdev, bool enable, u8 active_percent)
 {
 	u32 val = 0;
 	u32 cmd = enable ? DCT_ENABLE : DCT_DISABLE;
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.h b/drivers/accel/ivpu/ivpu_hw_btrs.h
index d2d82651976d..c4c10e22f30f 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.h
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.h
@@ -36,7 +36,7 @@ u32 ivpu_hw_btrs_dpu_freq_get(struct ivpu_device *vdev);
 bool ivpu_hw_btrs_irq_handler_mtl(struct ivpu_device *vdev, int irq);
 bool ivpu_hw_btrs_irq_handler_lnl(struct ivpu_device *vdev, int irq);
 int ivpu_hw_btrs_dct_get_request(struct ivpu_device *vdev, bool *enable);
-void ivpu_hw_btrs_dct_set_status(struct ivpu_device *vdev, bool enable, u32 dct_percent);
+void ivpu_hw_btrs_dct_set_status(struct ivpu_device *vdev, bool enable, u8 active_percent);
 u32 ivpu_hw_btrs_telemetry_offset_get(struct ivpu_device *vdev);
 u32 ivpu_hw_btrs_telemetry_size_get(struct ivpu_device *vdev);
 u32 ivpu_hw_btrs_telemetry_enable_get(struct ivpu_device *vdev);
diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index 060f1fc031d3..1e4caf572647 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -732,7 +732,7 @@ ivpu_job_prepare_bos_for_submit(struct drm_file *file, struct ivpu_job *job, u32
 
 		job->bos[i] = to_ivpu_bo(obj);
 
-		ret = ivpu_bo_pin(job->bos[i]);
+		ret = ivpu_bo_bind(job->bos[i]);
 		if (ret)
 			return ret;
 	}
@@ -1012,7 +1012,7 @@ void ivpu_context_abort_work_fn(struct work_struct *work)
 
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
 		if (ivpu_jsm_reset_engine(vdev, 0))
-			return;
+			goto runtime_put;
 
 	mutex_lock(&vdev->context_list_lock);
 	xa_for_each(&vdev->context_xa, ctx_id, file_priv) {
@@ -1036,7 +1036,7 @@ void ivpu_context_abort_work_fn(struct work_struct *work)
 		goto runtime_put;
 
 	if (ivpu_jsm_hws_resume_engine(vdev, 0))
-		return;
+		goto runtime_put;
 	/*
 	 * In hardware scheduling mode NPU already has stopped processing jobs
 	 * and won't send us any further notifications, thus we have to free job related resources
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index 475ddc94f1cf..457ccf09df54 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -502,6 +502,11 @@ void ivpu_pm_irq_dct_work_fn(struct work_struct *work)
 	else
 		ret = ivpu_pm_dct_disable(vdev);
 
-	if (!ret)
-		ivpu_hw_btrs_dct_set_status(vdev, enable, vdev->pm->dct_active_percent);
+	if (!ret) {
+		/* Convert percent to U1.7 format */
+		u8 val = DIV_ROUND_CLOSEST(vdev->pm->dct_active_percent * 128, 100);
+
+		ivpu_hw_btrs_dct_set_status(vdev, enable, val);
+	}
+
 }
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a0d54993edb3..307dc7f62e52 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -22,6 +22,7 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/timer.h>
@@ -552,26 +553,25 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 }
 
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
-				       int sev, bool sync)
+				     int sev, bool sync)
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
+	char error_type[120];
 	bool queued = false;
 	int sec_sev, i;
 	char *p;
 
-	log_arm_hw_error(err);
-
 	sec_sev = ghes_severity(gdata->error_severity);
+	log_arm_hw_error(err, sec_sev);
 	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
 		return false;
 
 	p = (char *)(err + 1);
 	for (i = 0; i < err->err_info_num; i++) {
 		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
-		bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
+		bool is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
 		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
-		const char *error_type = "unknown error";
 
 		/*
 		 * The field (err_info->error_info & BIT(26)) is fixed to set to
@@ -585,12 +585,15 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 			continue;
 		}
 
-		if (err_info->type < ARRAY_SIZE(cper_proc_error_type_strs))
-			error_type = cper_proc_error_type_strs[err_info->type];
+		cper_bits_to_str(error_type, sizeof(error_type),
+				 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
+				 cper_proc_error_type_strs,
+				 ARRAY_SIZE(cper_proc_error_type_strs));
 
 		pr_warn_ratelimited(FW_WARN GHES_PFX
-				    "Unhandled processor error type: %s\n",
-				    error_type);
+				    "Unhandled processor error type 0x%02x: %s%s\n",
+				    err_info->type, error_type,
+				    (err_info->type & ~CPER_ARM_ERR_TYPE_MASK) ? " with reserved bit(s)" : "");
 		p += err_info->length;
 	}
 
@@ -895,11 +898,9 @@ static void ghes_do_proc(struct ghes *ghes,
 
 			arch_apei_report_mem_error(sev, mem_err);
 			queued = ghes_handle_memory_failure(gdata, sev, sync);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
+		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
 			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 9b6b71a2ffb5..a4498357bd16 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -54,7 +54,7 @@ static int map_x2apic_id(struct acpi_subtable_header *entry,
 	if (!(apic->lapic_flags & ACPI_MADT_ENABLED))
 		return -ENODEV;
 
-	if (device_declaration && (apic->uid == acpi_id)) {
+	if (apic->uid == acpi_id && (device_declaration || acpi_id < 255)) {
 		*apic_id = apic->local_apic_id;
 		return 0;
 	}
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index d74678f0ba4a..57bf9c973c4f 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1693,6 +1693,7 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	if (fwnode_property_read_u32(fwnode, "reg", &endpoint->id))
 		fwnode_property_read_u32(fwnode, "endpoint", &endpoint->id);
 
+	fwnode_handle_put(port_fwnode);
 	return 0;
 }
 
diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 752b9a9bea03..15eff8a4b505 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -38,7 +38,7 @@ config FW_LOADER_DEBUG
 config RUST_FW_LOADER_ABSTRACTIONS
 	bool "Rust Firmware Loader abstractions"
 	depends on RUST
-	depends on FW_LOADER=y
+	select FW_LOADER
 	help
 	  This enables the Rust abstractions for the firmware loader API.
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ad39ab95ea66..9ba4b20b80ba 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1024,9 +1024,9 @@ static void recv_work(struct work_struct *work)
 	nbd_mark_nsock_dead(nbd, nsock, 1);
 	mutex_unlock(&nsock->tx_lock);
 
-	nbd_config_put(nbd);
 	atomic_dec(&config->recv_threads);
 	wake_up(&config->recv_wq);
+	nbd_config_put(nbd);
 	kfree(args);
 }
 
@@ -2241,12 +2241,13 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 
 	ret = nbd_start_device(nbd);
 out:
-	mutex_unlock(&nbd->config_lock);
 	if (!ret) {
 		set_bit(NBD_RT_HAS_CONFIG_REF, &config->runtime_flags);
 		refcount_inc(&nbd->config_refs);
 		nbd_connect_reply(info, nbd->index);
 	}
+	mutex_unlock(&nbd->config_lock);
+
 	nbd_config_put(nbd);
 	if (put_dev)
 		nbd_put(nbd);
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index dc9e4a14b885..8892f218a814 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -85,10 +85,14 @@ static void ps3disk_scatter_gather(struct ps3_storage_device *dev,
 	struct bio_vec bvec;
 
 	rq_for_each_segment(bvec, req, iter) {
+		dev_dbg(&dev->sbd.core, "%s:%u: %u sectors from %llu\n",
+			__func__, __LINE__, bio_sectors(iter.bio),
+			iter.bio->bi_iter.bi_sector);
 		if (gather)
 			memcpy_from_bvec(dev->bounce_buf + offset, &bvec);
 		else
 			memcpy_to_bvec(&bvec, dev->bounce_buf + offset);
+		offset += bvec.bv_len;
 	}
 }
 
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 67d4a867aec4..c12bee92fcfd 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2340,7 +2340,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	u16 buf_idx = UBLK_INVALID_BUF_IDX;
 	struct ublk_device *ub = cmd->file->private_data;
 	struct ublk_queue *ubq;
-	struct ublk_io *io;
+	struct ublk_io *io = NULL;
 	u32 cmd_op = cmd->cmd_op;
 	unsigned tag = ub_cmd->tag;
 	struct request *req;
@@ -2458,7 +2458,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
  out:
 	pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
-			__func__, cmd_op, tag, ret, io->flags);
+			__func__, cmd_op, tag, ret, io ? io->flags : 0);
 	return ret;
 }
 
diff --git a/drivers/char/random.c b/drivers/char/random.c
index b8b24b6ed3fe..4ba5f0c4c8b2 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1296,6 +1296,7 @@ static void __cold try_to_generate_entropy(void)
 	struct entropy_timer_state *stack = PTR_ALIGN((void *)stack_bytes, SMP_CACHE_BYTES);
 	unsigned int i, num_different = 0;
 	unsigned long last = random_get_entropy();
+	cpumask_var_t timer_cpus;
 	int cpu = -1;
 
 	for (i = 0; i < NUM_TRIAL_SAMPLES - 1; ++i) {
@@ -1310,13 +1311,15 @@ static void __cold try_to_generate_entropy(void)
 
 	atomic_set(&stack->samples, 0);
 	timer_setup_on_stack(&stack->timer, entropy_timer, 0);
+	if (!alloc_cpumask_var(&timer_cpus, GFP_KERNEL))
+		goto out;
+
 	while (!crng_ready() && !signal_pending(current)) {
 		/*
 		 * Check !timer_pending() and then ensure that any previous callback has finished
 		 * executing by checking timer_delete_sync_try(), before queueing the next one.
 		 */
 		if (!timer_pending(&stack->timer) && timer_delete_sync_try(&stack->timer) >= 0) {
-			struct cpumask timer_cpus;
 			unsigned int num_cpus;
 
 			/*
@@ -1326,19 +1329,19 @@ static void __cold try_to_generate_entropy(void)
 			preempt_disable();
 
 			/* Only schedule callbacks on timer CPUs that are online. */
-			cpumask_and(&timer_cpus, housekeeping_cpumask(HK_TYPE_TIMER), cpu_online_mask);
-			num_cpus = cpumask_weight(&timer_cpus);
+			cpumask_and(timer_cpus, housekeeping_cpumask(HK_TYPE_TIMER), cpu_online_mask);
+			num_cpus = cpumask_weight(timer_cpus);
 			/* In very bizarre case of misconfiguration, fallback to all online. */
 			if (unlikely(num_cpus == 0)) {
-				timer_cpus = *cpu_online_mask;
-				num_cpus = cpumask_weight(&timer_cpus);
+				*timer_cpus = *cpu_online_mask;
+				num_cpus = cpumask_weight(timer_cpus);
 			}
 
 			/* Basic CPU round-robin, which avoids the current CPU. */
 			do {
-				cpu = cpumask_next(cpu, &timer_cpus);
+				cpu = cpumask_next(cpu, timer_cpus);
 				if (cpu >= nr_cpu_ids)
-					cpu = cpumask_first(&timer_cpus);
+					cpu = cpumask_first(timer_cpus);
 			} while (cpu == smp_processor_id() && num_cpus > 1);
 
 			/* Expiring the timer at `jiffies` means it's the next tick. */
@@ -1354,6 +1357,8 @@ static void __cold try_to_generate_entropy(void)
 	}
 	mix_pool_bytes(&stack->entropy, sizeof(stack->entropy));
 
+	free_cpumask_var(timer_cpus);
+out:
 	timer_delete_sync(&stack->timer);
 	timer_destroy_on_stack(&stack->timer);
 }
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 18ed29cfdc11..12b4688131f1 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -124,8 +124,7 @@ obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
 obj-y					+= imgtec/
 obj-y					+= imx/
 obj-y					+= ingenic/
-obj-$(CONFIG_ARCH_K3)			+= keystone/
-obj-$(CONFIG_ARCH_KEYSTONE)		+= keystone/
+obj-y					+= keystone/
 obj-y					+= mediatek/
 obj-$(CONFIG_ARCH_MESON)		+= meson/
 obj-y					+= microchip/
diff --git a/drivers/clk/qcom/camcc-sm6350.c b/drivers/clk/qcom/camcc-sm6350.c
index 8aac97d29ce3..7df12c1311c6 100644
--- a/drivers/clk/qcom/camcc-sm6350.c
+++ b/drivers/clk/qcom/camcc-sm6350.c
@@ -145,15 +145,11 @@ static struct clk_alpha_pll_postdiv camcc_pll1_out_even = {
 static const struct alpha_pll_config camcc_pll2_config = {
 	.l = 0x64,
 	.alpha = 0x0,
-	.post_div_val = 0x3 << 8,
-	.post_div_mask = 0x3 << 8,
-	.aux_output_mask = BIT(1),
-	.main_output_mask = BIT(0),
-	.early_output_mask = BIT(3),
 	.config_ctl_val = 0x20000800,
 	.config_ctl_hi_val = 0x400003d2,
 	.test_ctl_val = 0x04000400,
 	.test_ctl_hi_val = 0x00004000,
+	.user_ctl_val = 0x0000030b,
 };
 
 static struct clk_alpha_pll camcc_pll2 = {
@@ -1693,6 +1689,8 @@ static struct clk_branch camcc_sys_tmr_clk = {
 	},
 };
 
+static struct gdsc titan_top_gdsc;
+
 static struct gdsc bps_gdsc = {
 	.gdscr = 0x6004,
 	.en_rest_wait_val = 0x2,
@@ -1702,6 +1700,7 @@ static struct gdsc bps_gdsc = {
 		.name = "bps_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &titan_top_gdsc.pd,
 	.flags = VOTABLE,
 };
 
@@ -1714,6 +1713,7 @@ static struct gdsc ipe_0_gdsc = {
 		.name = "ipe_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &titan_top_gdsc.pd,
 	.flags = VOTABLE,
 };
 
@@ -1726,6 +1726,7 @@ static struct gdsc ife_0_gdsc = {
 		.name = "ife_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &titan_top_gdsc.pd,
 };
 
 static struct gdsc ife_1_gdsc = {
@@ -1737,6 +1738,7 @@ static struct gdsc ife_1_gdsc = {
 		.name = "ife_1_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &titan_top_gdsc.pd,
 };
 
 static struct gdsc ife_2_gdsc = {
@@ -1748,6 +1750,7 @@ static struct gdsc ife_2_gdsc = {
 		.name = "ife_2_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &titan_top_gdsc.pd,
 };
 
 static struct gdsc titan_top_gdsc = {
diff --git a/drivers/clk/qcom/camcc-sm7150.c b/drivers/clk/qcom/camcc-sm7150.c
index 4a3baf5d8e85..590548cac45b 100644
--- a/drivers/clk/qcom/camcc-sm7150.c
+++ b/drivers/clk/qcom/camcc-sm7150.c
@@ -139,13 +139,9 @@ static struct clk_fixed_factor camcc_pll1_out_even = {
 /* 1920MHz configuration */
 static const struct alpha_pll_config camcc_pll2_config = {
 	.l = 0x64,
-	.post_div_val = 0x3 << 8,
-	.post_div_mask = 0x3 << 8,
-	.early_output_mask = BIT(3),
-	.aux_output_mask = BIT(1),
-	.main_output_mask = BIT(0),
 	.config_ctl_hi_val = 0x400003d6,
 	.config_ctl_val = 0x20000954,
+	.user_ctl_val = 0x0000030b,
 };
 
 static struct clk_alpha_pll camcc_pll2 = {
diff --git a/drivers/clk/qcom/camcc-sm8550.c b/drivers/clk/qcom/camcc-sm8550.c
index 63aed9e4c362..b8ece8a57a8a 100644
--- a/drivers/clk/qcom/camcc-sm8550.c
+++ b/drivers/clk/qcom/camcc-sm8550.c
@@ -3204,6 +3204,8 @@ static struct clk_branch cam_cc_sfe_1_fast_ahb_clk = {
 	},
 };
 
+static struct gdsc cam_cc_titan_top_gdsc;
+
 static struct gdsc cam_cc_bps_gdsc = {
 	.gdscr = 0x10004,
 	.en_rest_wait_val = 0x2,
@@ -3213,6 +3215,7 @@ static struct gdsc cam_cc_bps_gdsc = {
 		.name = "cam_cc_bps_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -3225,6 +3228,7 @@ static struct gdsc cam_cc_ife_0_gdsc = {
 		.name = "cam_cc_ife_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -3237,6 +3241,7 @@ static struct gdsc cam_cc_ife_1_gdsc = {
 		.name = "cam_cc_ife_1_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -3249,6 +3254,7 @@ static struct gdsc cam_cc_ife_2_gdsc = {
 		.name = "cam_cc_ife_2_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -3261,6 +3267,7 @@ static struct gdsc cam_cc_ipe_0_gdsc = {
 		.name = "cam_cc_ipe_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -3273,6 +3280,7 @@ static struct gdsc cam_cc_sbi_gdsc = {
 		.name = "cam_cc_sbi_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -3285,6 +3293,7 @@ static struct gdsc cam_cc_sfe_0_gdsc = {
 		.name = "cam_cc_sfe_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -3297,6 +3306,7 @@ static struct gdsc cam_cc_sfe_1_gdsc = {
 		.name = "cam_cc_sfe_1_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
diff --git a/drivers/clk/qcom/gcc-ipq5424.c b/drivers/clk/qcom/gcc-ipq5424.c
index 3d42f3d85c7a..71afa1b86b72 100644
--- a/drivers/clk/qcom/gcc-ipq5424.c
+++ b/drivers/clk/qcom/gcc-ipq5424.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2018,2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/clk-provider.h>
@@ -3284,6 +3284,7 @@ static const struct qcom_cc_desc gcc_ipq5424_desc = {
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq5424_hws),
 	.icc_hws = icc_ipq5424_hws,
 	.num_icc_hws = ARRAY_SIZE(icc_ipq5424_hws),
+	.icc_first_node_id = IPQ_APPS_ID,
 };
 
 static int gcc_ipq5424_probe(struct platform_device *pdev)
diff --git a/drivers/clk/qcom/gcc-qcs615.c b/drivers/clk/qcom/gcc-qcs615.c
index 9695446bc2a3..5b3b8dd4f114 100644
--- a/drivers/clk/qcom/gcc-qcs615.c
+++ b/drivers/clk/qcom/gcc-qcs615.c
@@ -784,7 +784,7 @@ static struct clk_rcg2 gcc_sdcc1_apps_clk_src = {
 		.name = "gcc_sdcc1_apps_clk_src",
 		.parent_data = gcc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_shared_floor_ops,
 	},
 };
 
@@ -806,7 +806,7 @@ static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
 		.name = "gcc_sdcc1_ice_core_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_shared_floor_ops,
 	},
 };
 
@@ -830,7 +830,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_8,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_shared_floor_ops,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sm8750.c b/drivers/clk/qcom/gcc-sm8750.c
index 8092dd6b37b5..def86b71a3da 100644
--- a/drivers/clk/qcom/gcc-sm8750.c
+++ b/drivers/clk/qcom/gcc-sm8750.c
@@ -1012,6 +1012,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s7_clk_src = {
 static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
 	F(400000, P_BI_TCXO, 12, 1, 4),
 	F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
+	F(37500000, P_GCC_GPLL0_OUT_EVEN, 8, 0, 0),
 	F(50000000, P_GCC_GPLL0_OUT_EVEN, 6, 0, 0),
 	F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
 	F(202000000, P_GCC_GPLL9_OUT_MAIN, 4, 0, 0),
diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index 301fc9fc32d8..8804ad5d70be 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -32,6 +32,33 @@ enum {
 	DT_USB3_PHY_0_WRAPPER_GCC_USB30_PIPE,
 	DT_USB3_PHY_1_WRAPPER_GCC_USB30_PIPE,
 	DT_USB3_PHY_2_WRAPPER_GCC_USB30_PIPE,
+	DT_GCC_USB4_0_PHY_DP0_GMUX_CLK_SRC,
+	DT_GCC_USB4_0_PHY_DP1_GMUX_CLK_SRC,
+	DT_GCC_USB4_0_PHY_PCIE_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_0_PHY_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_0_PHY_SYS_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_1_PHY_DP0_GMUX_CLK_SRC,
+	DT_GCC_USB4_1_PHY_DP1_GMUX_CLK_SRC,
+	DT_GCC_USB4_1_PHY_PCIE_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_1_PHY_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_1_PHY_SYS_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_2_PHY_DP0_GMUX_CLK_SRC,
+	DT_GCC_USB4_2_PHY_DP1_GMUX_CLK_SRC,
+	DT_GCC_USB4_2_PHY_PCIE_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_2_PHY_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_2_PHY_SYS_PIPEGMUX_CLK_SRC,
+	DT_QUSB4PHY_0_GCC_USB4_RX0_CLK,
+	DT_QUSB4PHY_0_GCC_USB4_RX1_CLK,
+	DT_QUSB4PHY_1_GCC_USB4_RX0_CLK,
+	DT_QUSB4PHY_1_GCC_USB4_RX1_CLK,
+	DT_QUSB4PHY_2_GCC_USB4_RX0_CLK,
+	DT_QUSB4PHY_2_GCC_USB4_RX1_CLK,
+	DT_USB4_0_PHY_GCC_USB4_PCIE_PIPE_CLK,
+	DT_USB4_0_PHY_GCC_USB4RTR_MAX_PIPE_CLK,
+	DT_USB4_1_PHY_GCC_USB4_PCIE_PIPE_CLK,
+	DT_USB4_1_PHY_GCC_USB4RTR_MAX_PIPE_CLK,
+	DT_USB4_2_PHY_GCC_USB4_PCIE_PIPE_CLK,
+	DT_USB4_2_PHY_GCC_USB4RTR_MAX_PIPE_CLK,
 };
 
 enum {
@@ -42,10 +69,40 @@ enum {
 	P_GCC_GPLL7_OUT_MAIN,
 	P_GCC_GPLL8_OUT_MAIN,
 	P_GCC_GPLL9_OUT_MAIN,
+	P_GCC_USB3_PRIM_PHY_PIPE_CLK_SRC,
+	P_GCC_USB3_SEC_PHY_PIPE_CLK_SRC,
+	P_GCC_USB3_TERT_PHY_PIPE_CLK_SRC,
+	P_GCC_USB4_0_PHY_DP0_GMUX_CLK_SRC,
+	P_GCC_USB4_0_PHY_DP1_GMUX_CLK_SRC,
+	P_GCC_USB4_0_PHY_PCIE_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_0_PHY_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_0_PHY_SYS_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_1_PHY_DP0_GMUX_CLK_SRC,
+	P_GCC_USB4_1_PHY_DP1_GMUX_CLK_SRC,
+	P_GCC_USB4_1_PHY_PCIE_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_1_PHY_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_1_PHY_SYS_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_2_PHY_DP0_GMUX_CLK_SRC,
+	P_GCC_USB4_2_PHY_DP1_GMUX_CLK_SRC,
+	P_GCC_USB4_2_PHY_PCIE_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_2_PHY_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_2_PHY_SYS_PIPEGMUX_CLK_SRC,
+	P_QUSB4PHY_0_GCC_USB4_RX0_CLK,
+	P_QUSB4PHY_0_GCC_USB4_RX1_CLK,
+	P_QUSB4PHY_1_GCC_USB4_RX0_CLK,
+	P_QUSB4PHY_1_GCC_USB4_RX1_CLK,
+	P_QUSB4PHY_2_GCC_USB4_RX0_CLK,
+	P_QUSB4PHY_2_GCC_USB4_RX1_CLK,
 	P_SLEEP_CLK,
 	P_USB3_PHY_0_WRAPPER_GCC_USB30_PIPE_CLK,
 	P_USB3_PHY_1_WRAPPER_GCC_USB30_PIPE_CLK,
 	P_USB3_PHY_2_WRAPPER_GCC_USB30_PIPE_CLK,
+	P_USB4_0_PHY_GCC_USB4_PCIE_PIPE_CLK,
+	P_USB4_0_PHY_GCC_USB4RTR_MAX_PIPE_CLK,
+	P_USB4_1_PHY_GCC_USB4_PCIE_PIPE_CLK,
+	P_USB4_1_PHY_GCC_USB4RTR_MAX_PIPE_CLK,
+	P_USB4_2_PHY_GCC_USB4_PCIE_PIPE_CLK,
+	P_USB4_2_PHY_GCC_USB4RTR_MAX_PIPE_CLK,
 };
 
 static struct clk_alpha_pll gcc_gpll0 = {
@@ -320,6 +377,342 @@ static const struct freq_tbl ftbl_gcc_gp1_clk_src[] = {
 	{ }
 };
 
+static const struct clk_parent_data gcc_parent_data_13[] = {
+	{ .index = DT_GCC_USB4_0_PHY_DP0_GMUX_CLK_SRC },
+	{ .index = DT_USB4_0_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_14[] = {
+	{ .index = DT_GCC_USB4_0_PHY_DP1_GMUX_CLK_SRC },
+	{ .index = DT_USB4_0_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_15[] = {
+	{ .index = DT_USB4_0_PHY_GCC_USB4_PCIE_PIPE_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_16[] = {
+	{ .index = DT_GCC_USB4_0_PHY_PCIE_PIPEGMUX_CLK_SRC },
+	{ .index = DT_USB4_0_PHY_GCC_USB4_PCIE_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_17[] = {
+	{ .index = DT_QUSB4PHY_0_GCC_USB4_RX0_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_18[] = {
+	{ .index = DT_QUSB4PHY_0_GCC_USB4_RX1_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_19[] = {
+	{ .index = DT_GCC_USB4_0_PHY_SYS_PIPEGMUX_CLK_SRC },
+	{ .index = DT_USB4_0_PHY_GCC_USB4_PCIE_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_20[] = {
+	{ .index = DT_GCC_USB4_1_PHY_DP0_GMUX_CLK_SRC },
+	{ .index = DT_USB4_1_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_21[] = {
+	{ .index = DT_GCC_USB4_1_PHY_DP1_GMUX_CLK_SRC },
+	{ .index = DT_USB4_1_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_22[] = {
+	{ .index = DT_USB4_1_PHY_GCC_USB4_PCIE_PIPE_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_23[] = {
+	{ .index = DT_GCC_USB4_1_PHY_PCIE_PIPEGMUX_CLK_SRC },
+	{ .index = DT_USB4_1_PHY_GCC_USB4_PCIE_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_24[] = {
+	{ .index = DT_QUSB4PHY_1_GCC_USB4_RX0_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_25[] = {
+	{ .index = DT_QUSB4PHY_1_GCC_USB4_RX1_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_26[] = {
+	{ .index = DT_GCC_USB4_1_PHY_SYS_PIPEGMUX_CLK_SRC },
+	{ .index = DT_USB4_1_PHY_GCC_USB4_PCIE_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_27[] = {
+	{ .index = DT_GCC_USB4_2_PHY_DP0_GMUX_CLK_SRC },
+	{ .index = DT_USB4_2_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_28[] = {
+	{ .index = DT_GCC_USB4_2_PHY_DP1_GMUX_CLK_SRC },
+	{ .index = DT_USB4_2_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_29[] = {
+	{ .index = DT_USB4_2_PHY_GCC_USB4_PCIE_PIPE_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_30[] = {
+	{ .index = DT_GCC_USB4_2_PHY_PCIE_PIPEGMUX_CLK_SRC },
+	{ .index = DT_USB4_2_PHY_GCC_USB4_PCIE_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_31[] = {
+	{ .index = DT_QUSB4PHY_2_GCC_USB4_RX0_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_32[] = {
+	{ .index = DT_QUSB4PHY_2_GCC_USB4_RX1_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_33[] = {
+	{ .index = DT_GCC_USB4_2_PHY_SYS_PIPEGMUX_CLK_SRC },
+	{ .index = DT_USB4_2_PHY_GCC_USB4_PCIE_PIPE_CLK },
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_0_phy_dp0_clk_src = {
+	.reg = 0x9f06c,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_0_phy_dp0_clk_src",
+			.parent_data = gcc_parent_data_13,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_0_phy_dp1_clk_src = {
+	.reg = 0x9f114,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_0_phy_dp1_clk_src",
+			.parent_data = gcc_parent_data_14,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_0_phy_p2rr2p_pipe_clk_src = {
+	.reg = 0x9f0d4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_0_phy_p2rr2p_pipe_clk_src",
+			.parent_data = gcc_parent_data_15,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_0_phy_pcie_pipe_mux_clk_src = {
+	.reg = 0x9f104,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_0_phy_pcie_pipe_mux_clk_src",
+			.parent_data = gcc_parent_data_16,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_0_phy_rx0_clk_src = {
+	.reg = 0x9f0ac,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_0_phy_rx0_clk_src",
+			.parent_data = gcc_parent_data_17,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_0_phy_rx1_clk_src = {
+	.reg = 0x9f0bc,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_0_phy_rx1_clk_src",
+			.parent_data = gcc_parent_data_18,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_0_phy_sys_clk_src = {
+	.reg = 0x9f0e4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_0_phy_sys_clk_src",
+			.parent_data = gcc_parent_data_19,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_1_phy_dp0_clk_src = {
+	.reg = 0x2b06c,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_1_phy_dp0_clk_src",
+			.parent_data = gcc_parent_data_20,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_1_phy_dp1_clk_src = {
+	.reg = 0x2b114,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_1_phy_dp1_clk_src",
+			.parent_data = gcc_parent_data_21,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_1_phy_p2rr2p_pipe_clk_src = {
+	.reg = 0x2b0d4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_1_phy_p2rr2p_pipe_clk_src",
+			.parent_data = gcc_parent_data_22,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_1_phy_pcie_pipe_mux_clk_src = {
+	.reg = 0x2b104,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_1_phy_pcie_pipe_mux_clk_src",
+			.parent_data = gcc_parent_data_23,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_1_phy_rx0_clk_src = {
+	.reg = 0x2b0ac,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_1_phy_rx0_clk_src",
+			.parent_data = gcc_parent_data_24,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_1_phy_rx1_clk_src = {
+	.reg = 0x2b0bc,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_1_phy_rx1_clk_src",
+			.parent_data = gcc_parent_data_25,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_1_phy_sys_clk_src = {
+	.reg = 0x2b0e4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_1_phy_sys_clk_src",
+			.parent_data = gcc_parent_data_26,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_2_phy_dp0_clk_src = {
+	.reg = 0x1106c,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_2_phy_dp0_clk_src",
+			.parent_data = gcc_parent_data_27,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_2_phy_dp1_clk_src = {
+	.reg = 0x11114,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_2_phy_dp1_clk_src",
+			.parent_data = gcc_parent_data_28,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_2_phy_p2rr2p_pipe_clk_src = {
+	.reg = 0x110d4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_2_phy_p2rr2p_pipe_clk_src",
+			.parent_data = gcc_parent_data_29,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_2_phy_pcie_pipe_mux_clk_src = {
+	.reg = 0x11104,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_2_phy_pcie_pipe_mux_clk_src",
+			.parent_data = gcc_parent_data_30,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_2_phy_rx0_clk_src = {
+	.reg = 0x110ac,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_2_phy_rx0_clk_src",
+			.parent_data = gcc_parent_data_31,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_2_phy_rx1_clk_src = {
+	.reg = 0x110bc,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_2_phy_rx1_clk_src",
+			.parent_data = gcc_parent_data_32,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_2_phy_sys_clk_src = {
+	.reg = 0x110e4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_2_phy_sys_clk_src",
+			.parent_data = gcc_parent_data_33,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
 static struct clk_rcg2 gcc_gp1_clk_src = {
 	.cmd_rcgr = 0x64004,
 	.mnd_width = 16,
@@ -2790,6 +3183,11 @@ static struct clk_branch gcc_pcie_0_pipe_clk = {
 		.enable_mask = BIT(25),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_0_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_pcie_pipe_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2879,6 +3277,11 @@ static struct clk_branch gcc_pcie_1_pipe_clk = {
 		.enable_mask = BIT(30),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_1_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_pcie_pipe_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2968,6 +3371,11 @@ static struct clk_branch gcc_pcie_2_pipe_clk = {
 		.enable_mask = BIT(23),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_2_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_2_phy_pcie_pipe_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5156,6 +5564,33 @@ static struct clk_regmap_mux gcc_usb3_prim_phy_pipe_clk_src = {
 	},
 };
 
+static const struct parent_map gcc_parent_map_34[] = {
+	{ P_GCC_USB3_PRIM_PHY_PIPE_CLK_SRC, 0 },
+	{ P_USB4_0_PHY_GCC_USB4RTR_MAX_PIPE_CLK, 1 },
+	{ P_GCC_USB4_0_PHY_PIPEGMUX_CLK_SRC, 3 },
+};
+
+static const struct clk_parent_data gcc_parent_data_34[] = {
+	{ .hw = &gcc_usb3_prim_phy_pipe_clk_src.clkr.hw },
+	{ .index = DT_USB4_0_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+	{ .index = DT_GCC_USB4_0_PHY_PIPEGMUX_CLK_SRC },
+};
+
+static struct clk_regmap_mux gcc_usb34_prim_phy_pipe_clk_src = {
+	.reg = 0x39070,
+	.shift = 0,
+	.width = 2,
+	.parent_map = gcc_parent_map_34,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb34_prim_phy_pipe_clk_src",
+			.parent_data = gcc_parent_data_34,
+			.num_parents = ARRAY_SIZE(gcc_parent_data_34),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
 	.halt_reg = 0x39068,
 	.halt_check = BRANCH_HALT_SKIP,
@@ -5167,7 +5602,7 @@ static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb3_prim_phy_pipe_clk",
 			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_usb3_prim_phy_pipe_clk_src.clkr.hw,
+				&gcc_usb34_prim_phy_pipe_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -5227,6 +5662,33 @@ static struct clk_regmap_mux gcc_usb3_sec_phy_pipe_clk_src = {
 	},
 };
 
+static const struct parent_map gcc_parent_map_35[] = {
+	{ P_GCC_USB3_SEC_PHY_PIPE_CLK_SRC, 0 },
+	{ P_USB4_1_PHY_GCC_USB4RTR_MAX_PIPE_CLK, 1 },
+	{ P_GCC_USB4_1_PHY_PIPEGMUX_CLK_SRC, 3 },
+};
+
+static const struct clk_parent_data gcc_parent_data_35[] = {
+	{ .hw = &gcc_usb3_sec_phy_pipe_clk_src.clkr.hw },
+	{ .index = DT_USB4_1_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+	{ .index = DT_GCC_USB4_1_PHY_PIPEGMUX_CLK_SRC },
+};
+
+static struct clk_regmap_mux gcc_usb34_sec_phy_pipe_clk_src = {
+	.reg = 0xa1070,
+	.shift = 0,
+	.width = 2,
+	.parent_map = gcc_parent_map_35,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb34_sec_phy_pipe_clk_src",
+			.parent_data = gcc_parent_data_35,
+			.num_parents = ARRAY_SIZE(gcc_parent_data_35),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_usb3_sec_phy_pipe_clk = {
 	.halt_reg = 0xa1068,
 	.halt_check = BRANCH_HALT_SKIP,
@@ -5238,7 +5700,7 @@ static struct clk_branch gcc_usb3_sec_phy_pipe_clk = {
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb3_sec_phy_pipe_clk",
 			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_usb3_sec_phy_pipe_clk_src.clkr.hw,
+				&gcc_usb34_sec_phy_pipe_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -5298,6 +5760,33 @@ static struct clk_regmap_mux gcc_usb3_tert_phy_pipe_clk_src = {
 	},
 };
 
+static const struct parent_map gcc_parent_map_36[] = {
+	{ P_GCC_USB3_TERT_PHY_PIPE_CLK_SRC, 0 },
+	{ P_USB4_2_PHY_GCC_USB4RTR_MAX_PIPE_CLK, 1 },
+	{ P_GCC_USB4_2_PHY_PIPEGMUX_CLK_SRC, 3 },
+};
+
+static const struct clk_parent_data gcc_parent_data_36[] = {
+	{ .hw = &gcc_usb3_tert_phy_pipe_clk_src.clkr.hw },
+	{ .index = DT_USB4_2_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+	{ .index = DT_GCC_USB4_2_PHY_PIPEGMUX_CLK_SRC },
+};
+
+static struct clk_regmap_mux gcc_usb34_tert_phy_pipe_clk_src = {
+	.reg = 0xa2070,
+	.shift = 0,
+	.width = 2,
+	.parent_map = gcc_parent_map_36,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb34_tert_phy_pipe_clk_src",
+			.parent_data = gcc_parent_data_36,
+			.num_parents = ARRAY_SIZE(gcc_parent_data_36),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_usb3_tert_phy_pipe_clk = {
 	.halt_reg = 0xa2068,
 	.halt_check = BRANCH_HALT_SKIP,
@@ -5309,7 +5798,7 @@ static struct clk_branch gcc_usb3_tert_phy_pipe_clk = {
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb3_tert_phy_pipe_clk",
 			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_usb3_tert_phy_pipe_clk_src.clkr.hw,
+				&gcc_usb34_tert_phy_pipe_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -5335,12 +5824,17 @@ static struct clk_branch gcc_usb4_0_cfg_ahb_clk = {
 
 static struct clk_branch gcc_usb4_0_dp0_clk = {
 	.halt_reg = 0x9f060,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x9f060,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_dp0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_dp0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5348,12 +5842,17 @@ static struct clk_branch gcc_usb4_0_dp0_clk = {
 
 static struct clk_branch gcc_usb4_0_dp1_clk = {
 	.halt_reg = 0x9f108,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x9f108,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_dp1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_dp1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5385,6 +5884,11 @@ static struct clk_branch gcc_usb4_0_phy_p2rr2p_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_phy_p2rr2p_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_p2rr2p_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5398,6 +5902,11 @@ static struct clk_branch gcc_usb4_0_phy_pcie_pipe_clk = {
 		.enable_mask = BIT(19),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_phy_pcie_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_pcie_pipe_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5405,12 +5914,17 @@ static struct clk_branch gcc_usb4_0_phy_pcie_pipe_clk = {
 
 static struct clk_branch gcc_usb4_0_phy_rx0_clk = {
 	.halt_reg = 0x9f0b0,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x9f0b0,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_phy_rx0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_rx0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5418,12 +5932,17 @@ static struct clk_branch gcc_usb4_0_phy_rx0_clk = {
 
 static struct clk_branch gcc_usb4_0_phy_rx1_clk = {
 	.halt_reg = 0x9f0c0,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x9f0c0,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_phy_rx1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_rx1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5439,6 +5958,11 @@ static struct clk_branch gcc_usb4_0_phy_usb_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_phy_usb_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb34_prim_phy_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5470,6 +5994,11 @@ static struct clk_branch gcc_usb4_0_sys_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_sys_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_sys_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5512,12 +6041,17 @@ static struct clk_branch gcc_usb4_1_cfg_ahb_clk = {
 
 static struct clk_branch gcc_usb4_1_dp0_clk = {
 	.halt_reg = 0x2b060,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x2b060,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_dp0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_dp0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5525,12 +6059,17 @@ static struct clk_branch gcc_usb4_1_dp0_clk = {
 
 static struct clk_branch gcc_usb4_1_dp1_clk = {
 	.halt_reg = 0x2b108,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x2b108,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_dp1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_dp1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5562,6 +6101,11 @@ static struct clk_branch gcc_usb4_1_phy_p2rr2p_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_phy_p2rr2p_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_p2rr2p_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5575,6 +6119,11 @@ static struct clk_branch gcc_usb4_1_phy_pcie_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_phy_pcie_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_pcie_pipe_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5582,12 +6131,17 @@ static struct clk_branch gcc_usb4_1_phy_pcie_pipe_clk = {
 
 static struct clk_branch gcc_usb4_1_phy_rx0_clk = {
 	.halt_reg = 0x2b0b0,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x2b0b0,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_phy_rx0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_rx0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5595,12 +6149,17 @@ static struct clk_branch gcc_usb4_1_phy_rx0_clk = {
 
 static struct clk_branch gcc_usb4_1_phy_rx1_clk = {
 	.halt_reg = 0x2b0c0,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x2b0c0,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_phy_rx1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_rx1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5616,6 +6175,11 @@ static struct clk_branch gcc_usb4_1_phy_usb_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_phy_usb_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb34_sec_phy_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5647,6 +6211,11 @@ static struct clk_branch gcc_usb4_1_sys_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_sys_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_sys_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5689,12 +6258,17 @@ static struct clk_branch gcc_usb4_2_cfg_ahb_clk = {
 
 static struct clk_branch gcc_usb4_2_dp0_clk = {
 	.halt_reg = 0x11060,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x11060,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_2_dp0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_2_phy_dp0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5702,12 +6276,17 @@ static struct clk_branch gcc_usb4_2_dp0_clk = {
 
 static struct clk_branch gcc_usb4_2_dp1_clk = {
 	.halt_reg = 0x11108,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x11108,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_2_dp1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_2_phy_dp1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5739,6 +6318,11 @@ static struct clk_branch gcc_usb4_2_phy_p2rr2p_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_2_phy_p2rr2p_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_2_phy_p2rr2p_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5752,6 +6336,11 @@ static struct clk_branch gcc_usb4_2_phy_pcie_pipe_clk = {
 		.enable_mask = BIT(1),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_2_phy_pcie_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_2_phy_pcie_pipe_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5759,12 +6348,17 @@ static struct clk_branch gcc_usb4_2_phy_pcie_pipe_clk = {
 
 static struct clk_branch gcc_usb4_2_phy_rx0_clk = {
 	.halt_reg = 0x110b0,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x110b0,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_2_phy_rx0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_2_phy_rx0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5772,12 +6366,17 @@ static struct clk_branch gcc_usb4_2_phy_rx0_clk = {
 
 static struct clk_branch gcc_usb4_2_phy_rx1_clk = {
 	.halt_reg = 0x110c0,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x110c0,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_2_phy_rx1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_2_phy_rx1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5793,6 +6392,11 @@ static struct clk_branch gcc_usb4_2_phy_usb_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_2_phy_usb_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb34_tert_phy_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -6483,6 +7087,9 @@ static struct clk_regmap *gcc_x1e80100_clocks[] = {
 	[GCC_USB30_TERT_MOCK_UTMI_CLK_SRC] = &gcc_usb30_tert_mock_utmi_clk_src.clkr,
 	[GCC_USB30_TERT_MOCK_UTMI_POSTDIV_CLK_SRC] = &gcc_usb30_tert_mock_utmi_postdiv_clk_src.clkr,
 	[GCC_USB30_TERT_SLEEP_CLK] = &gcc_usb30_tert_sleep_clk.clkr,
+	[GCC_USB34_PRIM_PHY_PIPE_CLK_SRC] = &gcc_usb34_prim_phy_pipe_clk_src.clkr,
+	[GCC_USB34_SEC_PHY_PIPE_CLK_SRC] = &gcc_usb34_sec_phy_pipe_clk_src.clkr,
+	[GCC_USB34_TERT_PHY_PIPE_CLK_SRC] = &gcc_usb34_tert_phy_pipe_clk_src.clkr,
 	[GCC_USB3_MP_PHY_AUX_CLK] = &gcc_usb3_mp_phy_aux_clk.clkr,
 	[GCC_USB3_MP_PHY_AUX_CLK_SRC] = &gcc_usb3_mp_phy_aux_clk_src.clkr,
 	[GCC_USB3_MP_PHY_COM_AUX_CLK] = &gcc_usb3_mp_phy_com_aux_clk.clkr,
@@ -6508,11 +7115,18 @@ static struct clk_regmap *gcc_x1e80100_clocks[] = {
 	[GCC_USB4_0_DP1_CLK] = &gcc_usb4_0_dp1_clk.clkr,
 	[GCC_USB4_0_MASTER_CLK] = &gcc_usb4_0_master_clk.clkr,
 	[GCC_USB4_0_MASTER_CLK_SRC] = &gcc_usb4_0_master_clk_src.clkr,
+	[GCC_USB4_0_PHY_DP0_CLK_SRC] = &gcc_usb4_0_phy_dp0_clk_src.clkr,
+	[GCC_USB4_0_PHY_DP1_CLK_SRC] = &gcc_usb4_0_phy_dp1_clk_src.clkr,
 	[GCC_USB4_0_PHY_P2RR2P_PIPE_CLK] = &gcc_usb4_0_phy_p2rr2p_pipe_clk.clkr,
+	[GCC_USB4_0_PHY_P2RR2P_PIPE_CLK_SRC] = &gcc_usb4_0_phy_p2rr2p_pipe_clk_src.clkr,
 	[GCC_USB4_0_PHY_PCIE_PIPE_CLK] = &gcc_usb4_0_phy_pcie_pipe_clk.clkr,
 	[GCC_USB4_0_PHY_PCIE_PIPE_CLK_SRC] = &gcc_usb4_0_phy_pcie_pipe_clk_src.clkr,
+	[GCC_USB4_0_PHY_PCIE_PIPE_MUX_CLK_SRC] = &gcc_usb4_0_phy_pcie_pipe_mux_clk_src.clkr,
 	[GCC_USB4_0_PHY_RX0_CLK] = &gcc_usb4_0_phy_rx0_clk.clkr,
+	[GCC_USB4_0_PHY_RX0_CLK_SRC] = &gcc_usb4_0_phy_rx0_clk_src.clkr,
 	[GCC_USB4_0_PHY_RX1_CLK] = &gcc_usb4_0_phy_rx1_clk.clkr,
+	[GCC_USB4_0_PHY_RX1_CLK_SRC] = &gcc_usb4_0_phy_rx1_clk_src.clkr,
+	[GCC_USB4_0_PHY_SYS_CLK_SRC] = &gcc_usb4_0_phy_sys_clk_src.clkr,
 	[GCC_USB4_0_PHY_USB_PIPE_CLK] = &gcc_usb4_0_phy_usb_pipe_clk.clkr,
 	[GCC_USB4_0_SB_IF_CLK] = &gcc_usb4_0_sb_if_clk.clkr,
 	[GCC_USB4_0_SB_IF_CLK_SRC] = &gcc_usb4_0_sb_if_clk_src.clkr,
@@ -6524,11 +7138,18 @@ static struct clk_regmap *gcc_x1e80100_clocks[] = {
 	[GCC_USB4_1_DP1_CLK] = &gcc_usb4_1_dp1_clk.clkr,
 	[GCC_USB4_1_MASTER_CLK] = &gcc_usb4_1_master_clk.clkr,
 	[GCC_USB4_1_MASTER_CLK_SRC] = &gcc_usb4_1_master_clk_src.clkr,
+	[GCC_USB4_1_PHY_DP0_CLK_SRC] = &gcc_usb4_1_phy_dp0_clk_src.clkr,
+	[GCC_USB4_1_PHY_DP1_CLK_SRC] = &gcc_usb4_1_phy_dp1_clk_src.clkr,
 	[GCC_USB4_1_PHY_P2RR2P_PIPE_CLK] = &gcc_usb4_1_phy_p2rr2p_pipe_clk.clkr,
+	[GCC_USB4_1_PHY_P2RR2P_PIPE_CLK_SRC] = &gcc_usb4_1_phy_p2rr2p_pipe_clk_src.clkr,
 	[GCC_USB4_1_PHY_PCIE_PIPE_CLK] = &gcc_usb4_1_phy_pcie_pipe_clk.clkr,
 	[GCC_USB4_1_PHY_PCIE_PIPE_CLK_SRC] = &gcc_usb4_1_phy_pcie_pipe_clk_src.clkr,
+	[GCC_USB4_1_PHY_PCIE_PIPE_MUX_CLK_SRC] = &gcc_usb4_1_phy_pcie_pipe_mux_clk_src.clkr,
 	[GCC_USB4_1_PHY_RX0_CLK] = &gcc_usb4_1_phy_rx0_clk.clkr,
+	[GCC_USB4_1_PHY_RX0_CLK_SRC] = &gcc_usb4_1_phy_rx0_clk_src.clkr,
 	[GCC_USB4_1_PHY_RX1_CLK] = &gcc_usb4_1_phy_rx1_clk.clkr,
+	[GCC_USB4_1_PHY_RX1_CLK_SRC] = &gcc_usb4_1_phy_rx1_clk_src.clkr,
+	[GCC_USB4_1_PHY_SYS_CLK_SRC] = &gcc_usb4_1_phy_sys_clk_src.clkr,
 	[GCC_USB4_1_PHY_USB_PIPE_CLK] = &gcc_usb4_1_phy_usb_pipe_clk.clkr,
 	[GCC_USB4_1_SB_IF_CLK] = &gcc_usb4_1_sb_if_clk.clkr,
 	[GCC_USB4_1_SB_IF_CLK_SRC] = &gcc_usb4_1_sb_if_clk_src.clkr,
@@ -6540,11 +7161,18 @@ static struct clk_regmap *gcc_x1e80100_clocks[] = {
 	[GCC_USB4_2_DP1_CLK] = &gcc_usb4_2_dp1_clk.clkr,
 	[GCC_USB4_2_MASTER_CLK] = &gcc_usb4_2_master_clk.clkr,
 	[GCC_USB4_2_MASTER_CLK_SRC] = &gcc_usb4_2_master_clk_src.clkr,
+	[GCC_USB4_2_PHY_DP0_CLK_SRC] = &gcc_usb4_2_phy_dp0_clk_src.clkr,
+	[GCC_USB4_2_PHY_DP1_CLK_SRC] = &gcc_usb4_2_phy_dp1_clk_src.clkr,
 	[GCC_USB4_2_PHY_P2RR2P_PIPE_CLK] = &gcc_usb4_2_phy_p2rr2p_pipe_clk.clkr,
+	[GCC_USB4_2_PHY_P2RR2P_PIPE_CLK_SRC] = &gcc_usb4_2_phy_p2rr2p_pipe_clk_src.clkr,
 	[GCC_USB4_2_PHY_PCIE_PIPE_CLK] = &gcc_usb4_2_phy_pcie_pipe_clk.clkr,
 	[GCC_USB4_2_PHY_PCIE_PIPE_CLK_SRC] = &gcc_usb4_2_phy_pcie_pipe_clk_src.clkr,
+	[GCC_USB4_2_PHY_PCIE_PIPE_MUX_CLK_SRC] = &gcc_usb4_2_phy_pcie_pipe_mux_clk_src.clkr,
 	[GCC_USB4_2_PHY_RX0_CLK] = &gcc_usb4_2_phy_rx0_clk.clkr,
+	[GCC_USB4_2_PHY_RX0_CLK_SRC] = &gcc_usb4_2_phy_rx0_clk_src.clkr,
 	[GCC_USB4_2_PHY_RX1_CLK] = &gcc_usb4_2_phy_rx1_clk.clkr,
+	[GCC_USB4_2_PHY_RX1_CLK_SRC] = &gcc_usb4_2_phy_rx1_clk_src.clkr,
+	[GCC_USB4_2_PHY_SYS_CLK_SRC] = &gcc_usb4_2_phy_sys_clk_src.clkr,
 	[GCC_USB4_2_PHY_USB_PIPE_CLK] = &gcc_usb4_2_phy_usb_pipe_clk.clkr,
 	[GCC_USB4_2_SB_IF_CLK] = &gcc_usb4_2_sb_if_clk.clkr,
 	[GCC_USB4_2_SB_IF_CLK_SRC] = &gcc_usb4_2_sb_if_clk_src.clkr,
@@ -6660,16 +7288,52 @@ static const struct qcom_reset_map gcc_x1e80100_resets[] = {
 	[GCC_USB3_UNIPHY_MP0_BCR] = { 0x19000 },
 	[GCC_USB3_UNIPHY_MP1_BCR] = { 0x54000 },
 	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
+	[GCC_USB4PHY_PHY_PRIM_BCR] = { 0x5000c },
 	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x2a004 },
+	[GCC_USB4PHY_PHY_SEC_BCR] = { 0x2a00c },
 	[GCC_USB3PHY_PHY_TERT_BCR] = { 0xa3004 },
+	[GCC_USB4PHY_PHY_TERT_BCR] = { 0xa300c },
 	[GCC_USB3UNIPHY_PHY_MP0_BCR] = { 0x19004 },
 	[GCC_USB3UNIPHY_PHY_MP1_BCR] = { 0x54004 },
 	[GCC_USB4_0_BCR] = { 0x9f000 },
 	[GCC_USB4_0_DP0_PHY_PRIM_BCR] = { 0x50010 },
-	[GCC_USB4_1_DP0_PHY_SEC_BCR] = { 0x2a010 },
-	[GCC_USB4_2_DP0_PHY_TERT_BCR] = { 0xa3010 },
+	[GCC_USB4_0_MISC_USB4_SYS_BCR] = { .reg = 0xad0f8, .bit = 0 },
+	[GCC_USB4_0_MISC_RX_CLK_0_BCR] = { .reg = 0xad0f8, .bit = 1 },
+	[GCC_USB4_0_MISC_RX_CLK_1_BCR] = { .reg = 0xad0f8, .bit = 2 },
+	[GCC_USB4_0_MISC_USB_PIPE_BCR] = { .reg = 0xad0f8, .bit = 3 },
+	[GCC_USB4_0_MISC_PCIE_PIPE_BCR] = { .reg = 0xad0f8, .bit = 4 },
+	[GCC_USB4_0_MISC_TMU_BCR] = { .reg = 0xad0f8, .bit = 5 },
+	[GCC_USB4_0_MISC_SB_IF_BCR] = { .reg = 0xad0f8, .bit = 6 },
+	[GCC_USB4_0_MISC_HIA_MSTR_BCR] = { .reg = 0xad0f8, .bit = 7 },
+	[GCC_USB4_0_MISC_AHB_BCR] = { .reg = 0xad0f8, .bit = 8 },
+	[GCC_USB4_0_MISC_DP0_MAX_PCLK_BCR] = { .reg = 0xad0f8, .bit = 9 },
+	[GCC_USB4_0_MISC_DP1_MAX_PCLK_BCR] = { .reg = 0xad0f8, .bit = 10 },
 	[GCC_USB4_1_BCR] = { 0x2b000 },
+	[GCC_USB4_1_DP0_PHY_SEC_BCR] = { 0x2a010 },
+	[GCC_USB4_1_MISC_USB4_SYS_BCR] = { .reg = 0xae0f8, .bit = 0 },
+	[GCC_USB4_1_MISC_RX_CLK_0_BCR] = { .reg = 0xae0f8, .bit = 1 },
+	[GCC_USB4_1_MISC_RX_CLK_1_BCR] = { .reg = 0xae0f8, .bit = 2 },
+	[GCC_USB4_1_MISC_USB_PIPE_BCR] = { .reg = 0xae0f8, .bit = 3 },
+	[GCC_USB4_1_MISC_PCIE_PIPE_BCR] = { .reg = 0xae0f8, .bit = 4 },
+	[GCC_USB4_1_MISC_TMU_BCR] = { .reg = 0xae0f8, .bit = 5 },
+	[GCC_USB4_1_MISC_SB_IF_BCR] = { .reg = 0xae0f8, .bit = 6 },
+	[GCC_USB4_1_MISC_HIA_MSTR_BCR] = { .reg = 0xae0f8, .bit = 7 },
+	[GCC_USB4_1_MISC_AHB_BCR] = { .reg = 0xae0f8, .bit = 8 },
+	[GCC_USB4_1_MISC_DP0_MAX_PCLK_BCR] = { .reg = 0xae0f8, .bit = 9 },
+	[GCC_USB4_1_MISC_DP1_MAX_PCLK_BCR] = { .reg = 0xae0f8, .bit = 10 },
 	[GCC_USB4_2_BCR] = { 0x11000 },
+	[GCC_USB4_2_DP0_PHY_TERT_BCR] = { 0xa3010 },
+	[GCC_USB4_2_MISC_USB4_SYS_BCR] = { .reg = 0xaf0f8, .bit = 0 },
+	[GCC_USB4_2_MISC_RX_CLK_0_BCR] = { .reg = 0xaf0f8, .bit = 1 },
+	[GCC_USB4_2_MISC_RX_CLK_1_BCR] = { .reg = 0xaf0f8, .bit = 2 },
+	[GCC_USB4_2_MISC_USB_PIPE_BCR] = { .reg = 0xaf0f8, .bit = 3 },
+	[GCC_USB4_2_MISC_PCIE_PIPE_BCR] = { .reg = 0xaf0f8, .bit = 4 },
+	[GCC_USB4_2_MISC_TMU_BCR] = { .reg = 0xaf0f8, .bit = 5 },
+	[GCC_USB4_2_MISC_SB_IF_BCR] = { .reg = 0xaf0f8, .bit = 6 },
+	[GCC_USB4_2_MISC_HIA_MSTR_BCR] = { .reg = 0xaf0f8, .bit = 7 },
+	[GCC_USB4_2_MISC_AHB_BCR] = { .reg = 0xaf0f8, .bit = 8 },
+	[GCC_USB4_2_MISC_DP0_MAX_PCLK_BCR] = { .reg = 0xaf0f8, .bit = 9 },
+	[GCC_USB4_2_MISC_DP1_MAX_PCLK_BCR] = { .reg = 0xaf0f8, .bit = 10 },
 	[GCC_USB_0_PHY_BCR] = { 0x50020 },
 	[GCC_USB_1_PHY_BCR] = { 0x2a020 },
 	[GCC_USB_2_PHY_BCR] = { 0xa3020 },
diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index dcda19318b2a..0f5c91b5dfa9 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -1333,9 +1333,9 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 	if (IS_ERR(mclk))
 		return PTR_ERR(mclk);
 
-	clocks->reg = of_iomap(np, 0);
-	if (WARN_ON(!clocks->reg))
-		return -ENOMEM;
+	clocks->reg = devm_of_iomap(dev, np, 0, NULL);
+	if (IS_ERR(clocks->reg))
+		return PTR_ERR(clocks->reg);
 
 	r9a06g032_init_h2mode(clocks);
 
diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index c920d6a9707f..c8c28909ed9d 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -178,7 +178,7 @@ r9a09g077_cpg_div_clk_register(struct device *dev,
 
 	if (core->dtable)
 		clk_hw = clk_hw_register_divider_table(dev, core->name,
-						       parent_name, 0,
+						       parent_name, CLK_SET_RATE_PARENT,
 						       addr,
 						       GET_SHIFT(core->conf),
 						       GET_WIDTH(core->conf),
@@ -187,7 +187,7 @@ r9a09g077_cpg_div_clk_register(struct device *dev,
 						       &pub->rmw_lock);
 	else
 		clk_hw = clk_hw_register_divider(dev, core->name,
-						 parent_name, 0,
+						 parent_name, CLK_SET_RATE_PARENT,
 						 addr,
 						 GET_SHIFT(core->conf),
 						 GET_WIDTH(core->conf),
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index de1cf7ba45b7..a0a68ec0490f 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -676,53 +676,56 @@ static int __init cpg_mssr_add_clk_domain(struct device *dev,
 
 #define rcdev_to_priv(x)	container_of(x, struct cpg_mssr_priv, rcdev)
 
-static int cpg_mssr_reset(struct reset_controller_dev *rcdev,
-			  unsigned long id)
+static int cpg_mssr_reset_operate(struct reset_controller_dev *rcdev,
+				  const char *func, bool set, unsigned long id)
 {
 	struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
 	unsigned int reg = id / 32;
 	unsigned int bit = id % 32;
+	const u16 off = set ? priv->reset_regs[reg] : priv->reset_clear_regs[reg];
 	u32 bitmask = BIT(bit);
 
-	dev_dbg(priv->dev, "reset %u%02u\n", reg, bit);
-
-	/* Reset module */
-	writel(bitmask, priv->pub.base0 + priv->reset_regs[reg]);
-
-	/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
-	udelay(35);
+	if (func)
+		dev_dbg(priv->dev, "%s %u%02u\n", func, reg, bit);
 
-	/* Release module from reset state */
-	writel(bitmask, priv->pub.base0 + priv->reset_clear_regs[reg]);
+	writel(bitmask, priv->pub.base0 + off);
+	readl(priv->pub.base0 + off);
+	barrier_data(priv->pub.base0 + off);
 
 	return 0;
 }
 
-static int cpg_mssr_assert(struct reset_controller_dev *rcdev, unsigned long id)
+static int cpg_mssr_reset(struct reset_controller_dev *rcdev,
+			  unsigned long id)
 {
 	struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
-	unsigned int reg = id / 32;
-	unsigned int bit = id % 32;
-	u32 bitmask = BIT(bit);
 
-	dev_dbg(priv->dev, "assert %u%02u\n", reg, bit);
+	/* Reset module */
+	cpg_mssr_reset_operate(rcdev, "reset", true, id);
 
-	writel(bitmask, priv->pub.base0 + priv->reset_regs[reg]);
-	return 0;
+	/*
+	 * On R-Car Gen4, delay after SRCR has been written is 1ms.
+	 * On older SoCs, delay after SRCR has been written is 35us
+	 * (one cycle of the RCLK clock @ ca. 32 kHz).
+	 */
+	if (priv->reg_layout == CLK_REG_LAYOUT_RCAR_GEN4)
+		usleep_range(1000, 2000);
+	else
+		usleep_range(35, 1000);
+
+	/* Release module from reset state */
+	return cpg_mssr_reset_operate(rcdev, NULL, false, id);
+}
+
+static int cpg_mssr_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return cpg_mssr_reset_operate(rcdev, "assert", true, id);
 }
 
 static int cpg_mssr_deassert(struct reset_controller_dev *rcdev,
 			     unsigned long id)
 {
-	struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
-	unsigned int reg = id / 32;
-	unsigned int bit = id % 32;
-	u32 bitmask = BIT(bit);
-
-	dev_dbg(priv->dev, "deassert %u%02u\n", reg, bit);
-
-	writel(bitmask, priv->pub.base0 + priv->reset_clear_regs[reg]);
-	return 0;
+	return cpg_mssr_reset_operate(rcdev, "deassert", false, id);
 }
 
 static int cpg_mssr_status(struct reset_controller_dev *rcdev,
diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index 65e6de030717..7c9585c9359d 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -973,6 +973,8 @@ static int spacemit_ccu_register(struct device *dev,
 	if (!clk_data)
 		return -ENOMEM;
 
+	clk_data->num = data->num;
+
 	for (i = 0; i < data->num; i++) {
 		struct clk_hw *hw = data->hws[i];
 		struct ccu_common *common;
@@ -999,8 +1001,6 @@ static int spacemit_ccu_register(struct device *dev,
 		clk_data->hws[i] = hw;
 	}
 
-	clk_data->num = data->num;
-
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
 	if (ret)
 		dev_err(dev, "failed to add clock hardware provider (%d)\n", ret);
diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index d7ccf9001729..b0cd3bc7b096 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -177,15 +177,15 @@ static void nxp_stm_clocksource_resume(struct clocksource *cs)
 	nxp_stm_clocksource_enable(cs);
 }
 
-static void __init devm_clocksource_unregister(void *data)
+static void devm_clocksource_unregister(void *data)
 {
 	struct stm_timer *stm_timer = data;
 
 	clocksource_unregister(&stm_timer->cs);
 }
 
-static int __init nxp_stm_clocksource_init(struct device *dev, struct stm_timer *stm_timer,
-					   const char *name, void __iomem *base, struct clk *clk)
+static int nxp_stm_clocksource_init(struct device *dev, struct stm_timer *stm_timer,
+				    const char *name, void __iomem *base, struct clk *clk)
 {
 	int ret;
 
@@ -207,10 +207,8 @@ static int __init nxp_stm_clocksource_init(struct device *dev, struct stm_timer
 		return ret;
 
 	ret = devm_add_action_or_reset(dev, devm_clocksource_unregister, stm_timer);
-	if (ret) {
-		clocksource_unregister(&stm_timer->cs);
+	if (ret)
 		return ret;
-	}
 
 	stm_sched_clock = stm_timer;
 
@@ -297,9 +295,9 @@ static void nxp_stm_clockevent_resume(struct clock_event_device *ced)
 	nxp_stm_module_get(stm_timer);
 }
 
-static int __init nxp_stm_clockevent_per_cpu_init(struct device *dev, struct stm_timer *stm_timer,
-						  const char *name, void __iomem *base, int irq,
-						  struct clk *clk, int cpu)
+static int nxp_stm_clockevent_per_cpu_init(struct device *dev, struct stm_timer *stm_timer,
+					   const char *name, void __iomem *base, int irq,
+					   struct clk *clk, int cpu)
 {
 	stm_timer->base = base;
 	stm_timer->rate = clk_get_rate(clk);
@@ -386,7 +384,7 @@ static irqreturn_t nxp_stm_module_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init nxp_stm_timer_probe(struct platform_device *pdev)
+static int nxp_stm_timer_probe(struct platform_device *pdev)
 {
 	struct stm_timer *stm_timer;
 	struct device *dev = &pdev->dev;
@@ -482,14 +480,15 @@ static const struct of_device_id nxp_stm_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, nxp_stm_of_match);
 
-static struct platform_driver nxp_stm_probe = {
+static struct platform_driver nxp_stm_driver = {
 	.probe	= nxp_stm_timer_probe,
 	.driver	= {
 		.name		= "nxp-stm",
 		.of_match_table	= nxp_stm_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
-module_platform_driver(nxp_stm_probe);
+builtin_platform_driver(nxp_stm_driver);
 
 MODULE_DESCRIPTION("NXP System Timer Module driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clocksource/timer-ralink.c b/drivers/clocksource/timer-ralink.c
index 6ecdb4228f76..68434d9ed910 100644
--- a/drivers/clocksource/timer-ralink.c
+++ b/drivers/clocksource/timer-ralink.c
@@ -130,14 +130,15 @@ static int __init ralink_systick_init(struct device_node *np)
 	systick.dev.irq = irq_of_parse_and_map(np, 0);
 	if (!systick.dev.irq) {
 		pr_err("%pOFn: request_irq failed", np);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_iounmap;
 	}
 
 	ret = clocksource_mmio_init(systick.membase + SYSTICK_COUNT, np->name,
 				    SYSTICK_FREQ, 301, 16,
 				    clocksource_mmio_readl_up);
 	if (ret)
-		return ret;
+		goto err_free_irq;
 
 	clockevents_register_device(&systick.dev);
 
@@ -145,6 +146,12 @@ static int __init ralink_systick_init(struct device_node *np)
 			np, systick.dev.mult, systick.dev.shift);
 
 	return 0;
+
+err_free_irq:
+	irq_dispose_mapping(systick.dev.irq);
+err_iounmap:
+	iounmap(systick.membase);
+	return ret;
 }
 
 TIMER_OF_DECLARE(systick, "ralink,cevt-systick", ralink_systick_init);
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e4f1933dd7d4..7be26007f1d8 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1282,7 +1282,7 @@ static int amd_pstate_change_mode_without_dvr_change(int mode)
 	if (cpu_feature_enabled(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
 
-	for_each_present_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		cppc_set_auto_sel(cpu, (cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
 	}
 
diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c b/drivers/crypto/ccree/cc_buffer_mgr.c
index 3963bb91321f..dc7e0cd51c25 100644
--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -1235,6 +1235,7 @@ int cc_map_hash_request_update(struct cc_drvdata *drvdata, void *ctx,
 	int rc = 0;
 	u32 dummy = 0;
 	u32 mapped_nents = 0;
+	int sg_nents;
 
 	dev_dbg(dev, " update params : curr_buff=%p curr_buff_cnt=0x%X nbytes=0x%X src=%p curr_index=%u\n",
 		curr_buff, *curr_buff_cnt, nbytes, src, areq_ctx->buff_index);
@@ -1248,7 +1249,10 @@ int cc_map_hash_request_update(struct cc_drvdata *drvdata, void *ctx,
 	if (total_in_len < block_size) {
 		dev_dbg(dev, " less than one block: curr_buff=%p *curr_buff_cnt=0x%X copy_to=%p\n",
 			curr_buff, *curr_buff_cnt, &curr_buff[*curr_buff_cnt]);
-		areq_ctx->in_nents = sg_nents_for_len(src, nbytes);
+		sg_nents = sg_nents_for_len(src, nbytes);
+		if (sg_nents < 0)
+			return sg_nents;
+		areq_ctx->in_nents = sg_nents;
 		sg_copy_to_buffer(src, areq_ctx->in_nents,
 				  &curr_buff[*curr_buff_cnt], nbytes);
 		*curr_buff_cnt += nbytes;
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 60fe8cc9a7d0..dae2e4c36e53 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3664,6 +3664,7 @@ static void qm_clear_vft_config(struct hisi_qm *qm)
 static int qm_func_shaper_enable(struct hisi_qm *qm, u32 fun_index, u32 qos)
 {
 	struct device *dev = &qm->pdev->dev;
+	struct qm_shaper_factor t_factor;
 	u32 ir = qos * QM_QOS_RATE;
 	int ret, total_vfs, i;
 
@@ -3671,6 +3672,7 @@ static int qm_func_shaper_enable(struct hisi_qm *qm, u32 fun_index, u32 qos)
 	if (fun_index > total_vfs)
 		return -EINVAL;
 
+	memcpy(&t_factor, &qm->factor[fun_index], sizeof(t_factor));
 	qm->factor[fun_index].func_qos = qos;
 
 	ret = qm_get_shaper_para(ir, &qm->factor[fun_index]);
@@ -3684,11 +3686,21 @@ static int qm_func_shaper_enable(struct hisi_qm *qm, u32 fun_index, u32 qos)
 		ret = qm_set_vft_common(qm, SHAPER_VFT, fun_index, i, 1);
 		if (ret) {
 			dev_err(dev, "type: %d, failed to set shaper vft!\n", i);
-			return -EINVAL;
+			goto back_func_qos;
 		}
 	}
 
 	return 0;
+
+back_func_qos:
+	memcpy(&qm->factor[fun_index], &t_factor, sizeof(t_factor));
+	for (i--; i >= ALG_TYPE_0; i--) {
+		ret = qm_set_vft_common(qm, SHAPER_VFT, fun_index, i, 1);
+		if (ret)
+			dev_err(dev, "failed to restore shaper vft during rollback!\n");
+	}
+
+	return -EINVAL;
 }
 
 static u32 qm_get_shaper_vft_qos(struct hisi_qm *qm, u32 fun_index)
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 23f585219fb4..d0058757b000 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -805,7 +805,7 @@ static int save_iaa_wq(struct idxd_wq *wq)
 	if (!cpus_per_iaa)
 		cpus_per_iaa = 1;
 out:
-	return 0;
+	return ret;
 }
 
 static void remove_iaa_wq(struct idxd_wq *wq)
diff --git a/drivers/crypto/starfive/jh7110-hash.c b/drivers/crypto/starfive/jh7110-hash.c
index 6cfe0238f615..66a8b04c0a55 100644
--- a/drivers/crypto/starfive/jh7110-hash.c
+++ b/drivers/crypto/starfive/jh7110-hash.c
@@ -326,6 +326,7 @@ static int starfive_hash_digest(struct ahash_request *req)
 	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
 	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
 	struct starfive_cryp_dev *cryp = ctx->cryp;
+	int sg_len;
 
 	memset(rctx, 0, sizeof(struct starfive_cryp_request_ctx));
 
@@ -334,7 +335,10 @@ static int starfive_hash_digest(struct ahash_request *req)
 	rctx->in_sg = req->src;
 	rctx->blksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
 	rctx->digsize = crypto_ahash_digestsize(tfm);
-	rctx->in_sg_len = sg_nents_for_len(rctx->in_sg, rctx->total);
+	sg_len = sg_nents_for_len(rctx->in_sg, rctx->total);
+	if (sg_len < 0)
+		return sg_len;
+	rctx->in_sg_len = sg_len;
 	ctx->rctx = rctx;
 
 	return crypto_transfer_hash_request_to_engine(cryp->engine, req);
diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
index 96d1815059e3..c1ed70fa0a40 100644
--- a/drivers/devfreq/hisi_uncore_freq.c
+++ b/drivers/devfreq/hisi_uncore_freq.c
@@ -265,10 +265,11 @@ static int hisi_uncore_target(struct device *dev, unsigned long *freq,
 		dev_err(dev, "Failed to get opp for freq %lu hz\n", *freq);
 		return PTR_ERR(opp);
 	}
-	dev_pm_opp_put(opp);
 
 	data = (u32)(dev_pm_opp_get_freq(opp) / HZ_PER_MHZ);
 
+	dev_pm_opp_put(opp);
+
 	return hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_SET_FREQ, &data);
 }
 
diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index f0a63d09d3c4..76542a53e202 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -93,15 +93,11 @@ static void cper_print_arm_err_info(const char *pfx, u32 type,
 	bool proc_context_corrupt, corrected, precise_pc, restartable_pc;
 	bool time_out, access_mode;
 
-	/* If the type is unknown, bail. */
-	if (type > CPER_ARM_MAX_TYPE)
-		return;
-
 	/*
 	 * Vendor type errors have error information values that are vendor
 	 * specific.
 	 */
-	if (type == CPER_ARM_VENDOR_ERROR)
+	if (type & CPER_ARM_VENDOR_ERROR)
 		return;
 
 	if (error_info & CPER_ARM_ERR_VALID_TRANSACTION_TYPE) {
@@ -116,43 +112,38 @@ static void cper_print_arm_err_info(const char *pfx, u32 type,
 	if (error_info & CPER_ARM_ERR_VALID_OPERATION_TYPE) {
 		op_type = ((error_info >> CPER_ARM_ERR_OPERATION_SHIFT)
 			   & CPER_ARM_ERR_OPERATION_MASK);
-		switch (type) {
-		case CPER_ARM_CACHE_ERROR:
+		if (type & CPER_ARM_CACHE_ERROR) {
 			if (op_type < ARRAY_SIZE(arm_cache_err_op_strs)) {
-				printk("%soperation type: %s\n", pfx,
+				printk("%scache error, operation type: %s\n", pfx,
 				       arm_cache_err_op_strs[op_type]);
 			}
-			break;
-		case CPER_ARM_TLB_ERROR:
+		}
+		if (type & CPER_ARM_TLB_ERROR) {
 			if (op_type < ARRAY_SIZE(arm_tlb_err_op_strs)) {
-				printk("%soperation type: %s\n", pfx,
+				printk("%sTLB error, operation type: %s\n", pfx,
 				       arm_tlb_err_op_strs[op_type]);
 			}
-			break;
-		case CPER_ARM_BUS_ERROR:
+		}
+		if (type & CPER_ARM_BUS_ERROR) {
 			if (op_type < ARRAY_SIZE(arm_bus_err_op_strs)) {
-				printk("%soperation type: %s\n", pfx,
+				printk("%sbus error, operation type: %s\n", pfx,
 				       arm_bus_err_op_strs[op_type]);
 			}
-			break;
 		}
 	}
 
 	if (error_info & CPER_ARM_ERR_VALID_LEVEL) {
 		level = ((error_info >> CPER_ARM_ERR_LEVEL_SHIFT)
 			 & CPER_ARM_ERR_LEVEL_MASK);
-		switch (type) {
-		case CPER_ARM_CACHE_ERROR:
+		if (type & CPER_ARM_CACHE_ERROR)
 			printk("%scache level: %d\n", pfx, level);
-			break;
-		case CPER_ARM_TLB_ERROR:
+
+		if (type & CPER_ARM_TLB_ERROR)
 			printk("%sTLB level: %d\n", pfx, level);
-			break;
-		case CPER_ARM_BUS_ERROR:
+
+		if (type & CPER_ARM_BUS_ERROR)
 			printk("%saffinity level at which the bus error occurred: %d\n",
 			       pfx, level);
-			break;
-		}
 	}
 
 	if (error_info & CPER_ARM_ERR_VALID_PROC_CONTEXT_CORRUPT) {
@@ -240,7 +231,8 @@ void cper_print_proc_arm(const char *pfx,
 	int i, len, max_ctx_type;
 	struct cper_arm_err_info *err_info;
 	struct cper_arm_ctx_info *ctx_info;
-	char newpfx[64], infopfx[64];
+	char newpfx[64], infopfx[ARRAY_SIZE(newpfx) + 1];
+	char error_type[120];
 
 	printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);
 
@@ -289,9 +281,15 @@ void cper_print_proc_arm(const char *pfx,
 				       newpfx);
 		}
 
-		printk("%serror_type: %d, %s\n", newpfx, err_info->type,
-			err_info->type < ARRAY_SIZE(cper_proc_error_type_strs) ?
-			cper_proc_error_type_strs[err_info->type] : "unknown");
+		cper_bits_to_str(error_type, sizeof(error_type),
+				 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
+				 cper_proc_error_type_strs,
+				 ARRAY_SIZE(cper_proc_error_type_strs));
+
+		printk("%serror_type: 0x%02x: %s%s\n", newpfx, err_info->type,
+		       error_type,
+		       (err_info->type & ~CPER_ARM_ERR_TYPE_MASK) ? " with reserved bit(s)" : "");
+
 		if (err_info->validation_bits & CPER_ARM_INFO_VALID_ERR_INFO) {
 			printk("%serror_info: 0x%016llx\n", newpfx,
 			       err_info->error_info);
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 928409199a1a..79ba688a64f8 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -12,6 +12,7 @@
  * Specification version 2.4.
  */
 
+#include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/time.h>
@@ -106,6 +107,65 @@ void cper_print_bits(const char *pfx, unsigned int bits,
 		printk("%s\n", buf);
 }
 
+/**
+ * cper_bits_to_str - return a string for set bits
+ * @buf: buffer to store the output string
+ * @buf_size: size of the output string buffer
+ * @bits: bit mask
+ * @strs: string array, indexed by bit position
+ * @strs_size: size of the string array: @strs
+ *
+ * Add to @buf the bitmask in hexadecimal. Then, for each set bit in @bits,
+ * add the corresponding string describing the bit in @strs to @buf.
+ *
+ * A typical example is::
+ *
+ *	const char * const bits[] = {
+ *		"bit 3 name",
+ *		"bit 4 name",
+ *		"bit 5 name",
+ *	};
+ *	char str[120];
+ *	unsigned int bitmask = BIT(3) | BIT(5);
+ *	#define MASK GENMASK(5,3)
+ *
+ *	cper_bits_to_str(str, sizeof(str), FIELD_GET(MASK, bitmask),
+ *			 bits, ARRAY_SIZE(bits));
+ *
+ * The above code fills the string ``str`` with ``bit 3 name|bit 5 name``.
+ *
+ * Return: number of bytes stored or an error code if lower than zero.
+ */
+int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
+		     const char * const strs[], unsigned int strs_size)
+{
+	int len = buf_size;
+	char *str = buf;
+	int i, size;
+
+	*buf = '\0';
+
+	for_each_set_bit(i, &bits, strs_size) {
+		if (!(bits & BIT_ULL(i)))
+			continue;
+
+		if (*buf && len > 0) {
+			*str = '|';
+			len--;
+			str++;
+		}
+
+		size = strscpy(str, strs[i], len);
+		if (size < 0)
+			return size;
+
+		len -= size;
+		str += size;
+	}
+	return len - buf_size;
+}
+EXPORT_SYMBOL_GPL(cper_bits_to_str);
+
 static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
index f1c5fb45d5f7..c00d0ae7ed5d 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -66,7 +66,7 @@ void efi_5level_switch(void)
 	bool have_la57 = native_read_cr4() & X86_CR4_LA57;
 	bool need_toggle = want_la57 ^ have_la57;
 	u64 *pgt = (void *)la57_toggle + PAGE_SIZE;
-	u64 *cr3 = (u64 *)__native_read_cr3();
+	pgd_t *cr3 = (pgd_t *)native_read_cr3_pa();
 	u64 *new_cr3;
 
 	if (!la57_toggle || !need_toggle)
@@ -82,7 +82,7 @@ void efi_5level_switch(void)
 		new_cr3[0] = (u64)cr3 | _PAGE_TABLE_NOENC;
 	} else {
 		/* take the new root table pointer from the current entry #0 */
-		new_cr3 = (u64 *)(cr3[0] & PAGE_MASK);
+		new_cr3 = (u64 *)(native_pgd_val(cr3[0]) & PTE_PFN_MASK);
 
 		/* copy the new root table if it is not 32-bit addressable */
 		if ((u64)new_cr3 > U32_MAX)
diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 6125cccc9ba7..f2b902e95b73 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -226,8 +226,10 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
 
 	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
-				       "#mbox-cells", 0, &spec))
+				       "#mbox-cells", 0, &spec)) {
 		i = of_alias_get_id(spec.np, "mu");
+		of_node_put(spec.np);
+	}
 
 	/* use mu1 as general mu irq channel if failed */
 	if (i < 0)
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 00f58e27f6de..deee0e7be34b 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -52,6 +52,7 @@ struct stratix10_svc_chan;
 /**
  * struct stratix10_svc - svc private data
  * @stratix10_svc_rsu: pointer to stratix10 RSU device
+ * @intel_svc_fcs: pointer to the FCS device
  */
 struct stratix10_svc {
 	struct platform_device *stratix10_svc_rsu;
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 49fd2ae01055..8d96a3c12b36 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3751,9 +3751,11 @@ static int __maybe_unused ti_sci_suspend_noirq(struct device *dev)
 	struct ti_sci_info *info = dev_get_drvdata(dev);
 	int ret = 0;
 
-	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
-	if (ret)
-		return ret;
+	if (info->fw_caps & MSG_FLAG_CAPS_IO_ISOLATION) {
+		ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -3767,9 +3769,11 @@ static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
 	u8 pin;
 	u8 mode;
 
-	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
-	if (ret)
-		return ret;
+	if (info->fw_caps & MSG_FLAG_CAPS_IO_ISOLATION) {
+		ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
+		if (ret)
+			return ret;
+	}
 
 	ret = ti_sci_msg_cmd_lpm_wake_reason(&info->handle, &source, &time, &pin, &mode);
 	/* Do not fail to resume on error as the wake reason is not critical */
@@ -3928,11 +3932,12 @@ static int ti_sci_probe(struct platform_device *pdev)
 	}
 
 	ti_sci_msg_cmd_query_fw_caps(&info->handle, &info->fw_caps);
-	dev_dbg(dev, "Detected firmware capabilities: %s%s%s%s\n",
+	dev_dbg(dev, "Detected firmware capabilities: %s%s%s%s%s\n",
 		info->fw_caps & MSG_FLAG_CAPS_GENERIC ? "Generic" : "",
 		info->fw_caps & MSG_FLAG_CAPS_LPM_PARTIAL_IO ? " Partial-IO" : "",
 		info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED ? " DM-Managed" : "",
-		info->fw_caps & MSG_FLAG_CAPS_LPM_ABORT ? " LPM-Abort" : ""
+		info->fw_caps & MSG_FLAG_CAPS_LPM_ABORT ? " LPM-Abort" : "",
+		info->fw_caps & MSG_FLAG_CAPS_IO_ISOLATION ? " IO-Isolation" : ""
 	);
 
 	ti_sci_setup_ops(info);
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 701c416b2e78..7559cde17b6c 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -149,6 +149,7 @@ struct ti_sci_msg_req_reboot {
  *		MSG_FLAG_CAPS_LPM_PARTIAL_IO: Partial IO in LPM
  *		MSG_FLAG_CAPS_LPM_DM_MANAGED: LPM can be managed by DM
  *		MSG_FLAG_CAPS_LPM_ABORT: Abort entry to LPM
+ *		MSG_FLAG_CAPS_IO_ISOLATION: IO Isolation support
  *
  * Response to a generic message with message type TI_SCI_MSG_QUERY_FW_CAPS
  * providing currently available SOC/firmware capabilities. SoC that don't
@@ -160,6 +161,7 @@ struct ti_sci_msg_resp_query_fw_caps {
 #define MSG_FLAG_CAPS_LPM_PARTIAL_IO	TI_SCI_MSG_FLAG(4)
 #define MSG_FLAG_CAPS_LPM_DM_MANAGED	TI_SCI_MSG_FLAG(5)
 #define MSG_FLAG_CAPS_LPM_ABORT		TI_SCI_MSG_FLAG(9)
+#define MSG_FLAG_CAPS_IO_ISOLATION	TI_SCI_MSG_FLAG(7)
 #define MSG_MASK_CAPS_LPM		GENMASK_ULL(4, 1)
 	u64 fw_caps;
 } __packed;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index c316920f3450..1e1ee4a0cd0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -96,6 +96,7 @@ struct amdgpu_bo_va {
 	 * if non-zero, cannot unmap from GPU because user queues may still access it
 	 */
 	unsigned int			queue_refcount;
+	atomic_t			userq_va_mapped;
 };
 
 struct amdgpu_bo {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a0fb13172e8b..0b9269aaabde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -44,10 +44,29 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
-int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
-				   u64 expected_size)
+static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
+					   struct amdgpu_bo_va_mapping *va_map, u64 addr)
+{
+	struct amdgpu_userq_va_cursor *va_cursor;
+	struct userq_va_list;
+
+	va_cursor = kzalloc(sizeof(*va_cursor), GFP_KERNEL);
+	if (!va_cursor)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&va_cursor->list);
+	va_cursor->gpu_addr = addr;
+	atomic_set(&va_map->bo_va->userq_va_mapped, 1);
+	list_add(&va_cursor->list, &queue->userq_va_list);
+
+	return 0;
+}
+
+int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
+				   u64 addr, u64 expected_size)
 {
 	struct amdgpu_bo_va_mapping *va_map;
+	struct amdgpu_vm *vm = queue->vm;
 	u64 user_addr;
 	u64 size;
 	int r = 0;
@@ -67,6 +86,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 	/* Only validate the userq whether resident in the VM mapping range */
 	if (user_addr >= va_map->start  &&
 	    va_map->last - user_addr + 1 >= size) {
+		amdgpu_userq_buffer_va_list_add(queue, va_map, user_addr);
 		amdgpu_bo_unreserve(vm->root.bo);
 		return 0;
 	}
@@ -142,6 +162,7 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
+	list_del(&queue->userq_va_list);
 	kfree(queue);
 }
 
@@ -473,14 +494,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-	/* Validate the userq virtual address.*/
-	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
-	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
-	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
-		r = -EINVAL;
-		kfree(queue);
-		goto unlock;
-	}
+	INIT_LIST_HEAD(&queue->userq_va_list);
 	queue->doorbell_handle = args->in.doorbell_handle;
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
@@ -491,6 +505,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	db_info.db_obj = &queue->db_obj;
 	db_info.doorbell_offset = args->in.doorbell_offset;
 
+	/* Validate the userq virtual address.*/
+	if (amdgpu_userq_input_va_validate(queue, args->in.queue_va, args->in.queue_size) ||
+	    amdgpu_userq_input_va_validate(queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
+	    amdgpu_userq_input_va_validate(queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
+		r = -EINVAL;
+		kfree(queue);
+		goto unlock;
+	}
+
 	/* Convert relative doorbell offset into absolute doorbell index */
 	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
 	if (index == (uint64_t)-EINVAL) {
@@ -516,7 +539,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 8603c31320f1..17ac12893ef9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -47,6 +47,11 @@ struct amdgpu_userq_obj {
 	struct amdgpu_bo *obj;
 };
 
+struct amdgpu_userq_va_cursor {
+	u64			gpu_addr;
+	struct list_head	list;
+};
+
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	enum amdgpu_userq_state state;
@@ -66,6 +71,8 @@ struct amdgpu_usermode_queue {
 	u32			xcp_id;
 	int			priority;
 	struct dentry		*debugfs_queue;
+
+	struct list_head	userq_va_list;
 };
 
 struct amdgpu_userq_funcs {
@@ -132,7 +139,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx);
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
-
-int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
-				   u64 expected_size);
+int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
+				   u64 addr, u64 expected_size);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index ef54d211214f..1cd1fdec9cc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -206,7 +206,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
 	struct drm_amdgpu_userq_in *mqd_user = args_in;
 	struct amdgpu_mqd_prop *userq_props;
-	struct amdgpu_gfx_shadow_info shadow_info;
 	int r;
 
 	/* Structure to initialize MQD for userqueue using generic MQD init function */
@@ -232,8 +231,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props->doorbell_index = queue->doorbell_index;
 	userq_props->fence_address = queue->fence_drv->gpu_addr;
 
-	if (adev->gfx.funcs->get_gfx_shadow_info)
-		adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
 
@@ -250,8 +247,9 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
-		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
-		    max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
+		r = amdgpu_userq_input_va_validate(queue, compute_mqd->eop_va,
+						   2048);
+		if (r)
 			goto free_mqd;
 
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
@@ -263,6 +261,14 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
+		struct amdgpu_gfx_shadow_info shadow_info;
+
+		if (adev->gfx.funcs->get_gfx_shadow_info) {
+			adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
+		} else {
+			r = -EINVAL;
+			goto free_mqd;
+		}
 
 		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
 			DRM_ERROR("Invalid GFX MQD\n");
@@ -282,8 +288,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 
-		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
-		    shadow_info.shadow_size))
+		r = amdgpu_userq_input_va_validate(queue, mqd_gfx_v11->shadow_va,
+						   shadow_info.shadow_size);
+		if (r)
+			goto free_mqd;
+		r = amdgpu_userq_input_va_validate(queue, mqd_gfx_v11->csa_va,
+						   shadow_info.csa_size);
+		if (r)
 			goto free_mqd;
 
 		kfree(mqd_gfx_v11);
@@ -302,9 +313,9 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			r = -ENOMEM;
 			goto free_mqd;
 		}
-
-		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
-		    shadow_info.csa_size))
+		r = amdgpu_userq_input_va_validate(queue, mqd_sdma_v11->csa_va,
+						   32);
+		if (r)
 			goto free_mqd;
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fab6e7721c80..2850356b018d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1144,30 +1144,48 @@ static int
 svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
+	unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
+	unsigned long start_align = ALIGN(prange->start, 512);
+	bool huge_page_mapping = last_align_down > start_align;
 	struct svm_range *tail = NULL;
-	int r = svm_range_split(prange, prange->start, new_last, &tail);
+	int r;
 
-	if (!r) {
-		list_add(&tail->list, insert_list);
-		if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
-			list_add(&tail->update_list, remap_list);
-	}
-	return r;
+	r = svm_range_split(prange, prange->start, new_last, &tail);
+
+	if (r)
+		return r;
+
+	list_add(&tail->list, insert_list);
+
+	if (huge_page_mapping && tail->start > start_align &&
+	    tail->start < last_align_down && (!IS_ALIGNED(tail->start, 512)))
+		list_add(&tail->update_list, remap_list);
+
+	return 0;
 }
 
 static int
 svm_range_split_head(struct svm_range *prange, uint64_t new_start,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
+	unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
+	unsigned long start_align = ALIGN(prange->start, 512);
+	bool huge_page_mapping = last_align_down > start_align;
 	struct svm_range *head = NULL;
-	int r = svm_range_split(prange, new_start, prange->last, &head);
+	int r;
 
-	if (!r) {
-		list_add(&head->list, insert_list);
-		if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
-			list_add(&head->update_list, remap_list);
-	}
-	return r;
+	r = svm_range_split(prange, new_start, prange->last, &head);
+
+	if (r)
+		return r;
+
+	list_add(&head->list, insert_list);
+
+	if (huge_page_mapping && head->last + 1 > start_align &&
+	    head->last + 1 < last_align_down && (!IS_ALIGNED(head->last, 512)))
+		list_add(&head->update_list, remap_list);
+
+	return 0;
 }
 
 static void
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 04eb647acc4e..550a9f1d03f8 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1480,10 +1480,10 @@ static enum bp_result get_embedded_panel_info_v2_1(
 	/* not provided by VBIOS */
 	info->lcd_timing.misc_info.HORIZONTAL_CUT_OFF = 0;
 
-	info->lcd_timing.misc_info.H_SYNC_POLARITY = ~(uint32_t) (lvds->lcd_timing.miscinfo
-			& ATOM_HSYNC_POLARITY);
-	info->lcd_timing.misc_info.V_SYNC_POLARITY = ~(uint32_t) (lvds->lcd_timing.miscinfo
-			& ATOM_VSYNC_POLARITY);
+	info->lcd_timing.misc_info.H_SYNC_POLARITY = !(lvds->lcd_timing.miscinfo &
+						       ATOM_HSYNC_POLARITY);
+	info->lcd_timing.misc_info.V_SYNC_POLARITY = !(lvds->lcd_timing.miscinfo &
+						       ATOM_VSYNC_POLARITY);
 
 	/* not provided by VBIOS */
 	info->lcd_timing.misc_info.VERTICAL_CUT_OFF = 0;
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 4a7ba0918eca..3787db014501 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -365,13 +365,34 @@ void atmel_xlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
 				    xfactor);
 
 	/*
-	 * With YCbCr 4:2:2 and YCbYcr 4:2:0 window resampling, configuration
-	 * register LCDC_HEOCFG25.VXSCFACT and LCDC_HEOCFG27.HXSCFACT is half
+	 * With YCbCr 4:2:0 window resampling, configuration register
+	 * LCDC_HEOCFG25.VXSCFACT and LCDC_HEOCFG27.HXSCFACT values are half
 	 * the value of yfactor and xfactor.
+	 *
+	 * On the other hand, with YCbCr 4:2:2 window resampling, only the
+	 * configuration register LCDC_HEOCFG27.HXSCFACT value is half the value
+	 * of the xfactor; the value of LCDC_HEOCFG25.VXSCFACT is yfactor (no
+	 * division by 2).
 	 */
-	if (state->base.fb->format->format == DRM_FORMAT_YUV420) {
+	switch (state->base.fb->format->format) {
+	/* YCbCr 4:2:2 */
+	case DRM_FORMAT_YUYV:
+	case DRM_FORMAT_UYVY:
+	case DRM_FORMAT_YVYU:
+	case DRM_FORMAT_VYUY:
+	case DRM_FORMAT_YUV422:
+	case DRM_FORMAT_NV61:
+		xfactor /= 2;
+		break;
+
+	/* YCbCr 4:2:0 */
+	case DRM_FORMAT_YUV420:
+	case DRM_FORMAT_NV21:
 		yfactor /= 2;
 		xfactor /= 2;
+		break;
+	default:
+		break;
 	}
 
 	atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config + 2,
diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index a30493ed9715..4cadea997129 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -338,14 +338,14 @@ static int drm_plane_create_hotspot_properties(struct drm_plane *plane)
 
 	prop_x = drm_property_create_signed_range(plane->dev, 0, "HOTSPOT_X",
 						  INT_MIN, INT_MAX);
-	if (IS_ERR(prop_x))
-		return PTR_ERR(prop_x);
+	if (!prop_x)
+		return -ENOMEM;
 
 	prop_y = drm_property_create_signed_range(plane->dev, 0, "HOTSPOT_Y",
 						  INT_MIN, INT_MAX);
-	if (IS_ERR(prop_y)) {
+	if (!prop_y) {
 		drm_property_destroy(plane->dev, prop_x);
-		return PTR_ERR(prop_y);
+		return -ENOMEM;
 	}
 
 	drm_object_attach_property(&plane->base, prop_x, 0);
diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
index 7c4709d58aa3..7daf72b69bae 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
@@ -207,6 +207,35 @@ static const struct drm_fb_helper_funcs intel_fb_helper_funcs = {
 	.fb_set_suspend = intelfb_set_suspend,
 };
 
+static void intel_fbdev_fill_mode_cmd(struct drm_fb_helper_surface_size *sizes,
+				      struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	/* we don't do packed 24bpp */
+	if (sizes->surface_bpp == 24)
+		sizes->surface_bpp = 32;
+
+	mode_cmd->width = sizes->surface_width;
+	mode_cmd->height = sizes->surface_height;
+
+	mode_cmd->pitches[0] = ALIGN(mode_cmd->width * DIV_ROUND_UP(sizes->surface_bpp, 8), 64);
+	mode_cmd->pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
+							   sizes->surface_depth);
+}
+
+static struct intel_framebuffer *
+__intel_fbdev_fb_alloc(struct intel_display *display,
+		       struct drm_fb_helper_surface_size *sizes)
+{
+	struct drm_mode_fb_cmd2 mode_cmd = {};
+	struct intel_framebuffer *fb;
+
+	intel_fbdev_fill_mode_cmd(sizes, &mode_cmd);
+
+	fb = intel_fbdev_fb_alloc(display->drm, &mode_cmd);
+
+	return fb;
+}
+
 int intel_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 				   struct drm_fb_helper_surface_size *sizes)
 {
@@ -234,12 +263,18 @@ int intel_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 		drm_framebuffer_put(&fb->base);
 		fb = NULL;
 	}
+
+	wakeref = intel_display_rpm_get(display);
+
 	if (!fb || drm_WARN_ON(display->drm, !intel_fb_bo(&fb->base))) {
 		drm_dbg_kms(display->drm,
 			    "no BIOS fb, allocating a new one\n");
-		fb = intel_fbdev_fb_alloc(helper, sizes);
-		if (IS_ERR(fb))
-			return PTR_ERR(fb);
+
+		fb = __intel_fbdev_fb_alloc(display, sizes);
+		if (IS_ERR(fb)) {
+			ret = PTR_ERR(fb);
+			goto out_unlock;
+		}
 	} else {
 		drm_dbg_kms(display->drm, "re-using BIOS fb\n");
 		prealloc = true;
@@ -247,8 +282,6 @@ int intel_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 		sizes->fb_height = fb->base.height;
 	}
 
-	wakeref = intel_display_rpm_get(display);
-
 	/* Pin the GGTT vma for our access via info->screen_base.
 	 * This also validates that any existing fb inherited from the
 	 * BIOS is suitable for own access.
diff --git a/drivers/gpu/drm/i915/display/intel_fbdev_fb.c b/drivers/gpu/drm/i915/display/intel_fbdev_fb.c
index 210aee9ae88b..685612e6afc5 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fbdev_fb.c
@@ -3,7 +3,7 @@
  * Copyright © 2023 Intel Corporation
  */
 
-#include <drm/drm_fb_helper.h>
+#include <linux/fb.h>
 
 #include "gem/i915_gem_lmem.h"
 
@@ -13,29 +13,16 @@
 #include "intel_fb.h"
 #include "intel_fbdev_fb.h"
 
-struct intel_framebuffer *intel_fbdev_fb_alloc(struct drm_fb_helper *helper,
-					       struct drm_fb_helper_surface_size *sizes)
+struct intel_framebuffer *intel_fbdev_fb_alloc(struct drm_device *drm,
+					       struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	struct intel_display *display = to_intel_display(helper->dev);
-	struct drm_i915_private *dev_priv = to_i915(display->drm);
+	struct intel_display *display = to_intel_display(drm);
+	struct drm_i915_private *dev_priv = to_i915(drm);
 	struct drm_framebuffer *fb;
-	struct drm_mode_fb_cmd2 mode_cmd = {};
 	struct drm_i915_gem_object *obj;
 	int size;
 
-	/* we don't do packed 24bpp */
-	if (sizes->surface_bpp == 24)
-		sizes->surface_bpp = 32;
-
-	mode_cmd.width = sizes->surface_width;
-	mode_cmd.height = sizes->surface_height;
-
-	mode_cmd.pitches[0] = ALIGN(mode_cmd.width *
-				    DIV_ROUND_UP(sizes->surface_bpp, 8), 64);
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
-							  sizes->surface_depth);
-
-	size = mode_cmd.pitches[0] * mode_cmd.height;
+	size = mode_cmd->pitches[0] * mode_cmd->height;
 	size = PAGE_ALIGN(size);
 
 	obj = ERR_PTR(-ENODEV);
@@ -58,18 +45,25 @@ struct intel_framebuffer *intel_fbdev_fb_alloc(struct drm_fb_helper *helper,
 	}
 
 	if (IS_ERR(obj)) {
-		drm_err(display->drm, "failed to allocate framebuffer (%pe)\n", obj);
+		drm_err(drm, "failed to allocate framebuffer (%pe)\n", obj);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	fb = intel_framebuffer_create(intel_bo_to_drm_bo(obj),
-				      drm_get_format_info(display->drm,
-							  mode_cmd.pixel_format,
-							  mode_cmd.modifier[0]),
-				      &mode_cmd);
+				      drm_get_format_info(drm,
+							  mode_cmd->pixel_format,
+							  mode_cmd->modifier[0]),
+				      mode_cmd);
+	if (IS_ERR(fb)) {
+		i915_gem_object_put(obj);
+		goto err;
+	}
+
 	i915_gem_object_put(obj);
 
 	return to_intel_framebuffer(fb);
+err:
+	return ERR_CAST(fb);
 }
 
 int intel_fbdev_fb_fill_info(struct intel_display *display, struct fb_info *info,
diff --git a/drivers/gpu/drm/i915/display/intel_fbdev_fb.h b/drivers/gpu/drm/i915/display/intel_fbdev_fb.h
index cb7957272715..83454ffbf79c 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev_fb.h
+++ b/drivers/gpu/drm/i915/display/intel_fbdev_fb.h
@@ -6,15 +6,15 @@
 #ifndef __INTEL_FBDEV_FB_H__
 #define __INTEL_FBDEV_FB_H__
 
-struct drm_fb_helper;
-struct drm_fb_helper_surface_size;
+struct drm_device;
 struct drm_gem_object;
+struct drm_mode_fb_cmd2;
 struct fb_info;
 struct i915_vma;
 struct intel_display;
 
-struct intel_framebuffer *intel_fbdev_fb_alloc(struct drm_fb_helper *helper,
-					       struct drm_fb_helper_surface_size *sizes);
+struct intel_framebuffer *intel_fbdev_fb_alloc(struct drm_device *drm,
+					       struct drm_mode_fb_cmd2 *mode_cmd);
 int intel_fbdev_fb_fill_info(struct intel_display *display, struct fb_info *info,
 			     struct drm_gem_object *obj, struct i915_vma *vma);
 
diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 8b9ba4983c4c..f9271efbd74a 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -47,7 +47,7 @@
  *
  * Return:
  *  * 0 on success, or
- *  * Any error returned by devm_platform_ioremap_resource().
+ *  * Any error returned by devm_platform_get_and_ioremap_resource().
  */
 static int
 pvr_device_reg_init(struct pvr_device *pvr_dev)
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 10d60d2c2a56..6d7bf4afa78d 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -80,27 +80,6 @@ void mtk_ccorr_stop(struct device *dev)
 	writel_relaxed(0x0, ccorr->regs + DISP_CCORR_EN);
 }
 
-/* Converts a DRM S31.32 value to the HW S1.n format. */
-static u16 mtk_ctm_s31_32_to_s1_n(u64 in, u32 n)
-{
-	u16 r;
-
-	/* Sign bit. */
-	r = in & BIT_ULL(63) ? BIT(n + 1) : 0;
-
-	if ((in & GENMASK_ULL(62, 33)) > 0) {
-		/* identity value 0x100000000 -> 0x400(mt8183), */
-		/* identity value 0x100000000 -> 0x800(mt8192), */
-		/* if bigger this, set it to max 0x7ff. */
-		r |= GENMASK(n, 0);
-	} else {
-		/* take the n+1 most important bits. */
-		r |= (in >> (32 - n)) & GENMASK(n, 0);
-	}
-
-	return r;
-}
-
 void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)
 {
 	struct mtk_disp_ccorr *ccorr = dev_get_drvdata(dev);
@@ -119,7 +98,7 @@ void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)
 	input = ctm->matrix;
 
 	for (i = 0; i < ARRAY_SIZE(coeffs); i++)
-		coeffs[i] = mtk_ctm_s31_32_to_s1_n(input[i], matrix_bits);
+		coeffs[i] = drm_color_ctm_s31_32_to_qm_n(input[i], 2, matrix_bits);
 
 	mtk_ddp_write(cmdq_pkt, coeffs[0] << 16 | coeffs[1],
 		      &ccorr->cmdq_reg, ccorr->regs, DISP_CCORR_COEF_0);
diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index ec38db45d8a3..963c0f669ee5 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
@@ -234,7 +234,7 @@ static int a2xx_hw_init(struct msm_gpu *gpu)
 	 * word (0x20xxxx for A200, 0x220xxx for A220, 0x225xxx for A225).
 	 * Older firmware files, which lack protection support, have 0 instead.
 	 */
-	if (ptr[1] == 0) {
+	if (ptr[1] == 0 && !a2xx_gpu->protection_disabled) {
 		dev_warn(gpu->dev->dev,
 			 "Legacy firmware detected, disabling protection support\n");
 		a2xx_gpu->protection_disabled = true;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index ee82489025c3..4f6e68c86b58 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -471,8 +471,9 @@ static void a6xx_gemnoc_workaround(struct a6xx_gmu *gmu)
 	 * in the power down sequence not being fully executed. That in turn can
 	 * prevent CX_GDSC from collapsing. Assert Qactive to avoid this.
 	 */
-	if (adreno_is_a621(adreno_gpu) || adreno_is_7c3(adreno_gpu))
-		gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, BIT(0));
+	if (adreno_is_a7xx(adreno_gpu) || (adreno_is_a621(adreno_gpu) ||
+				adreno_is_7c3(adreno_gpu)))
+		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, BIT(0));
 }
 
 /* Let the GMU know that we are about to go into slumber */
@@ -508,10 +509,9 @@ static int a6xx_gmu_notify_slumber(struct a6xx_gmu *gmu)
 	}
 
 out:
-	a6xx_gemnoc_workaround(gmu);
-
 	/* Put fence into allow mode */
 	gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
+	a6xx_gemnoc_workaround(gmu);
 	return ret;
 }
 
@@ -1459,13 +1459,14 @@ static unsigned int a6xx_gmu_get_arc_level(struct device *dev,
 }
 
 static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
-		unsigned long *freqs, int freqs_count, const char *id)
+		unsigned long *freqs, int freqs_count,
+		const char *pri_id, const char *sec_id)
 {
 	int i, j;
 	const u16 *pri, *sec;
 	size_t pri_count, sec_count;
 
-	pri = cmd_db_read_aux_data(id, &pri_count);
+	pri = cmd_db_read_aux_data(pri_id, &pri_count);
 	if (IS_ERR(pri))
 		return PTR_ERR(pri);
 	/*
@@ -1476,13 +1477,7 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 	if (!pri_count)
 		return -EINVAL;
 
-	/*
-	 * Some targets have a separate gfx mxc rail. So try to read that first and then fall back
-	 * to regular mx rail if it is missing
-	 */
-	sec = cmd_db_read_aux_data("gmxc.lvl", &sec_count);
-	if (IS_ERR(sec) && sec != ERR_PTR(-EPROBE_DEFER))
-		sec = cmd_db_read_aux_data("mx.lvl", &sec_count);
+	sec = cmd_db_read_aux_data(sec_id, &sec_count);
 	if (IS_ERR(sec))
 		return PTR_ERR(sec);
 
@@ -1550,15 +1545,24 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	const struct a6xx_info *info = adreno_gpu->info->a6xx;
 	struct msm_gpu *gpu = &adreno_gpu->base;
+	const char *sec_id;
+	const u16 *gmxc;
 	int ret;
 
+	gmxc = cmd_db_read_aux_data("gmxc.lvl", NULL);
+	if (gmxc == ERR_PTR(-EPROBE_DEFER))
+		return -EPROBE_DEFER;
+
+	/* If GMxC is present, prefer that as secondary rail for GX votes */
+	sec_id = IS_ERR_OR_NULL(gmxc) ? "mx.lvl" : "gmxc.lvl";
+
 	/* Build the GX votes */
 	ret = a6xx_gmu_rpmh_arc_votes_init(&gpu->pdev->dev, gmu->gx_arc_votes,
-		gmu->gpu_freqs, gmu->nr_gpu_freqs, "gfx.lvl");
+		gmu->gpu_freqs, gmu->nr_gpu_freqs, "gfx.lvl", sec_id);
 
 	/* Build the CX votes */
 	ret |= a6xx_gmu_rpmh_arc_votes_init(gmu->dev, gmu->cx_arc_votes,
-		gmu->gmu_freqs, gmu->nr_gmu_freqs, "cx.lvl");
+		gmu->gmu_freqs, gmu->nr_gmu_freqs, "cx.lvl", "mx.lvl");
 
 	/* Build the interconnect votes */
 	if (info->bcms && gmu->nr_gpu_bws > 1)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 1e363af31948..f8939f0fad4f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -224,7 +224,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 		OUT_RING(ring, submit->seqno - 1);
 
 		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-		OUT_RING(ring, CP_SET_THREAD_BOTH);
+		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
 
 		/* Reset state used to synchronize BR and BV */
 		OUT_PKT7(ring, CP_RESET_CONTEXT_STATE, 1);
@@ -235,7 +235,13 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 			 CP_RESET_CONTEXT_STATE_0_RESET_GLOBAL_LOCAL_TS);
 
 		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-		OUT_RING(ring, CP_SET_THREAD_BR);
+		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
+
+		OUT_PKT7(ring, CP_EVENT_WRITE, 1);
+		OUT_RING(ring, LRZ_FLUSH);
+
+		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BR);
 	}
 
 	if (!sysprof) {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
index b7013c9822d2..cc7cc6f6f7cd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
@@ -71,12 +71,6 @@ struct dpu_hw_dsc *dpu_hw_dsc_init_1_2(struct drm_device *dev,
 				       const struct dpu_dsc_cfg *cfg,
 				       void __iomem *addr);
 
-/**
- * dpu_hw_dsc_destroy - destroys dsc driver context
- * @dsc:   Pointer to dsc driver context returned by dpu_hw_dsc_init
- */
-void dpu_hw_dsc_destroy(struct dpu_hw_dsc *dsc);
-
 static inline struct dpu_hw_dsc *to_dpu_hw_dsc(struct dpu_hw_blk *hw)
 {
 	return container_of(hw, struct dpu_hw_dsc, base);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 26c5ce897cbb..d5f8df3110ce 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -287,16 +287,17 @@ static void crashstate_get_bos(struct msm_gpu_state *state, struct msm_gem_submi
 
 		state->bos = kcalloc(cnt, sizeof(struct msm_gpu_state_bo), GFP_KERNEL);
 
-		drm_gpuvm_for_each_va (vma, submit->vm) {
-			bool dump = rd_full || (vma->flags & MSM_VMA_DUMP);
+		if (state->bos)
+			drm_gpuvm_for_each_va(vma, submit->vm) {
+				bool dump = rd_full || (vma->flags & MSM_VMA_DUMP);
 
-			/* Skip MAP_NULL/PRR VMAs: */
-			if (!vma->gem.obj)
-				continue;
+				/* Skip MAP_NULL/PRR VMAs: */
+				if (!vma->gem.obj)
+					continue;
 
-			msm_gpu_crashstate_get_bo(state, vma->gem.obj, vma->va.addr,
-						  dump, vma->gem.offset, vma->va.range);
-		}
+				msm_gpu_crashstate_get_bo(state, vma->gem.obj, vma->va.addr,
+							  dump, vma->gem.offset, vma->va.range);
+			}
 
 		drm_exec_fini(&exec);
 	} else {
@@ -348,6 +349,10 @@ static void crashstate_get_vm_logs(struct msm_gpu_state *state, struct msm_gem_v
 
 	state->vm_logs = kmalloc_array(
 		state->nr_vm_logs, sizeof(vm->log[0]), GFP_KERNEL);
+	if (!state->vm_logs) {
+		state->nr_vm_logs = 0;
+	}
+
 	for (int i = 0; i < state->nr_vm_logs; i++) {
 		int idx = (i + first) & vm_log_mask;
 
diff --git a/drivers/gpu/drm/nouveau/dispnv04/nouveau_i2c_encoder.c b/drivers/gpu/drm/nouveau/dispnv04/nouveau_i2c_encoder.c
index e2bf99c43336..a60209097a20 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/nouveau_i2c_encoder.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/nouveau_i2c_encoder.c
@@ -94,26 +94,6 @@ int nouveau_i2c_encoder_init(struct drm_device *dev,
 	return err;
 }
 
-/**
- * nouveau_i2c_encoder_destroy - Unregister the I2C device backing an encoder
- * @drm_encoder:	Encoder to be unregistered.
- *
- * This should be called from the @destroy method of an I2C slave
- * encoder driver once I2C access is no longer needed.
- */
-void nouveau_i2c_encoder_destroy(struct drm_encoder *drm_encoder)
-{
-	struct nouveau_i2c_encoder *encoder = to_encoder_i2c(drm_encoder);
-	struct i2c_client *client = nouveau_i2c_encoder_get_client(drm_encoder);
-	struct module *module = client->dev.driver->owner;
-
-	i2c_unregister_device(client);
-	encoder->i2c_client = NULL;
-
-	module_put(module);
-}
-EXPORT_SYMBOL(nouveau_i2c_encoder_destroy);
-
 /*
  * Wrapper fxns which can be plugged in to drm_encoder_helper_funcs:
  */
diff --git a/drivers/gpu/drm/nouveau/include/dispnv04/i2c/encoder_i2c.h b/drivers/gpu/drm/nouveau/include/dispnv04/i2c/encoder_i2c.h
index 31334aa90781..869820701a56 100644
--- a/drivers/gpu/drm/nouveau/include/dispnv04/i2c/encoder_i2c.h
+++ b/drivers/gpu/drm/nouveau/include/dispnv04/i2c/encoder_i2c.h
@@ -202,7 +202,24 @@ static inline struct i2c_client *nouveau_i2c_encoder_get_client(struct drm_encod
 	return to_encoder_i2c(encoder)->i2c_client;
 }
 
-void nouveau_i2c_encoder_destroy(struct drm_encoder *encoder);
+/**
+ * nouveau_i2c_encoder_destroy - Unregister the I2C device backing an encoder
+ * @drm_encoder:        Encoder to be unregistered.
+ *
+ * This should be called from the @destroy method of an I2C slave
+ * encoder driver once I2C access is no longer needed.
+ */
+static __always_inline void nouveau_i2c_encoder_destroy(struct drm_encoder *drm_encoder)
+{
+	struct nouveau_i2c_encoder *encoder = to_encoder_i2c(drm_encoder);
+	struct i2c_client *client = nouveau_i2c_encoder_get_client(drm_encoder);
+	struct module *module = client->dev.driver->owner;
+
+	i2c_unregister_device(client);
+	encoder->i2c_client = NULL;
+
+	module_put(module);
+}
 
 /*
  * Wrapper fxns which can be plugged in to drm_encoder_helper_funcs:
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index 869d4335c0f4..4a193b7d6d9e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -183,11 +183,11 @@ nouveau_fence_context_new(struct nouveau_channel *chan, struct nouveau_fence_cha
 	fctx->context = drm->runl[chan->runlist].context_base + chan->chid;
 
 	if (chan == drm->cechan)
-		strcpy(fctx->name, "copy engine channel");
+		strscpy(fctx->name, "copy engine channel");
 	else if (chan == drm->channel)
-		strcpy(fctx->name, "generic kernel channel");
+		strscpy(fctx->name, "generic kernel channel");
 	else
-		strcpy(fctx->name, cli->name);
+		strscpy(fctx->name, cli->name);
 
 	kref_init(&fctx->fence_ref);
 	if (!priv->uevent)
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/base.c
index 8a286a9349ac..7ce1b65e2c1c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/base.c
@@ -279,7 +279,7 @@ nvkm_fb_ctor(const struct nvkm_fb_func *func, struct nvkm_device *device,
 	mutex_init(&fb->tags.mutex);
 
 	if (func->sysmem.flush_page_init) {
-		fb->sysmem.flush_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		fb->sysmem.flush_page = alloc_page(GFP_KERNEL | GFP_DMA32 | __GFP_ZERO);
 		if (!fb->sysmem.flush_page)
 			return -ENOMEM;
 
diff --git a/drivers/gpu/drm/nova/Kconfig b/drivers/gpu/drm/nova/Kconfig
index cca6a3fea879..bd1df0879191 100644
--- a/drivers/gpu/drm/nova/Kconfig
+++ b/drivers/gpu/drm/nova/Kconfig
@@ -4,6 +4,7 @@ config DRM_NOVA
 	depends on PCI
 	depends on RUST
 	select AUXILIARY_BUS
+	select NOVA_CORE
 	default n
 	help
 	  Choose this if you want to build the Nova DRM driver for Nvidia
diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 909c280eab1f..66c30db3b73a 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -192,7 +192,7 @@ static int visionox_rm69299_unprepare(struct drm_panel *panel)
 	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	ctx->dsi->mode_flags = 0;
+	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
 	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
@@ -247,7 +247,7 @@ static const struct drm_display_mode visionox_rm69299_1080x2248_60hz = {
 };
 
 static const struct drm_display_mode visionox_rm69299_1080x2160_60hz = {
-	.clock = 158695,
+	.clock = (2160 + 8 + 4 + 4) * (1080 + 26 + 2 + 36) * 60 / 1000,
 	.hdisplay = 1080,
 	.hsync_start = 1080 + 26,
 	.hsync_end = 1080 + 26 + 2,
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index f0b2da5b2b96..1c0a9337404f 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -82,6 +82,8 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 		return;
 	}
 
+	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
+
 	/* Call drm_dev_unplug() so any access to HW blocks happening after
 	 * that point get rejected.
 	 */
@@ -92,8 +94,6 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	 */
 	mutex_unlock(&ptdev->unplug.lock);
 
-	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
-
 	/* Now, try to cleanly shutdown the GPU before the device resources
 	 * get reclaimed.
 	 */
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index eb5f0b9d437f..aca09bc449fc 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -87,7 +87,6 @@ static void panthor_gem_free_object(struct drm_gem_object *obj)
 void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
 {
 	struct panthor_vm *vm;
-	int ret;
 
 	if (IS_ERR_OR_NULL(bo))
 		return;
@@ -95,18 +94,11 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
 	vm = bo->vm;
 	panthor_kernel_bo_vunmap(bo);
 
-	if (drm_WARN_ON(bo->obj->dev,
-			to_panthor_bo(bo->obj)->exclusive_vm_root_gem != panthor_vm_root_gem(vm)))
-		goto out_free_bo;
-
-	ret = panthor_vm_unmap_range(vm, bo->va_node.start, bo->va_node.size);
-	if (ret)
-		goto out_free_bo;
-
+	drm_WARN_ON(bo->obj->dev,
+		    to_panthor_bo(bo->obj)->exclusive_vm_root_gem != panthor_vm_root_gem(vm));
+	panthor_vm_unmap_range(vm, bo->va_node.start, bo->va_node.size);
 	panthor_vm_free_va(vm, &bo->va_node);
 	drm_gem_object_put(bo->obj);
-
-out_free_bo:
 	panthor_vm_put(vm);
 	kfree(bo);
 }
@@ -153,6 +145,9 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
 	bo = to_panthor_bo(&obj->base);
 	kbo->obj = &obj->base;
 	bo->flags = bo_flags;
+	bo->exclusive_vm_root_gem = panthor_vm_root_gem(vm);
+	drm_gem_object_get(bo->exclusive_vm_root_gem);
+	bo->base.base.resv = bo->exclusive_vm_root_gem->resv;
 
 	if (vm == panthor_fw_vm(ptdev))
 		debug_flags |= PANTHOR_DEBUGFS_GEM_USAGE_FLAG_FW_MAPPED;
@@ -176,9 +171,6 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
 		goto err_free_va;
 
 	kbo->vm = panthor_vm_get(vm);
-	bo->exclusive_vm_root_gem = panthor_vm_root_gem(vm);
-	drm_gem_object_get(bo->exclusive_vm_root_gem);
-	bo->base.base.resv = bo->exclusive_vm_root_gem->resv;
 	return kbo;
 
 err_free_va:
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index de6ec324c8ef..3d356a08695a 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1118,6 +1118,20 @@ static void panthor_vm_cleanup_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	}
 }
 
+static void
+panthor_vm_op_ctx_return_vma(struct panthor_vm_op_ctx *op_ctx,
+			     struct panthor_vma *vma)
+{
+	for (u32 i = 0; i < ARRAY_SIZE(op_ctx->preallocated_vmas); i++) {
+		if (!op_ctx->preallocated_vmas[i]) {
+			op_ctx->preallocated_vmas[i] = vma;
+			return;
+		}
+	}
+
+	WARN_ON_ONCE(1);
+}
+
 static struct panthor_vma *
 panthor_vm_op_ctx_get_vma(struct panthor_vm_op_ctx *op_ctx)
 {
@@ -2057,8 +2071,10 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
 	ret = panthor_vm_map_pages(vm, op->map.va.addr, flags_to_prot(vma->flags),
 				   op_ctx->map.sgt, op->map.gem.offset,
 				   op->map.va.range);
-	if (ret)
+	if (ret) {
+		panthor_vm_op_ctx_return_vma(op_ctx, vma);
 		return ret;
+	}
 
 	/* Ref owned by the mapping now, clear the obj field so we don't release the
 	 * pinning/obj ref behind GPUVA's back.
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index df76653e649a..9d58e01a88a5 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -641,6 +641,15 @@ struct panthor_group {
 		size_t kbo_sizes;
 	} fdinfo;
 
+	/** @task_info: Info of current->group_leader that created the group. */
+	struct {
+		/** @task_info.pid: pid of current->group_leader */
+		pid_t pid;
+
+		/** @task_info.comm: comm of current->group_leader */
+		char comm[TASK_COMM_LEN];
+	} task_info;
+
 	/** @state: Group state. */
 	enum panthor_group_state state;
 
@@ -763,6 +772,12 @@ struct panthor_job_profiling_data {
  */
 #define MAX_GROUPS_PER_POOL 128
 
+/*
+ * Mark added on an entry of group pool Xarray to identify if the group has
+ * been fully initialized and can be accessed elsewhere in the driver code.
+ */
+#define GROUP_REGISTERED XA_MARK_1
+
 /**
  * struct panthor_group_pool - Group pool
  *
@@ -886,7 +901,8 @@ static void group_free_queue(struct panthor_group *group, struct panthor_queue *
 	if (IS_ERR_OR_NULL(queue))
 		return;
 
-	drm_sched_entity_destroy(&queue->entity);
+	if (queue->entity.fence_context)
+		drm_sched_entity_destroy(&queue->entity);
 
 	if (queue->scheduler.ops)
 		drm_sched_fini(&queue->scheduler);
@@ -2877,7 +2893,7 @@ void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
 		return;
 
 	xa_lock(&gpool->xa);
-	xa_for_each(&gpool->xa, i, group) {
+	xa_for_each_marked(&gpool->xa, i, group, GROUP_REGISTERED) {
 		guard(spinlock)(&group->fdinfo.lock);
 		pfile->stats.cycles += group->fdinfo.data.cycles;
 		pfile->stats.time += group->fdinfo.data.time;
@@ -3380,6 +3396,8 @@ group_create_queue(struct panthor_group *group,
 
 	drm_sched = &queue->scheduler;
 	ret = drm_sched_entity_init(&queue->entity, 0, &drm_sched, 1, NULL);
+	if (ret)
+		goto err_free_queue;
 
 	return queue;
 
@@ -3388,6 +3406,14 @@ group_create_queue(struct panthor_group *group,
 	return ERR_PTR(ret);
 }
 
+static void group_init_task_info(struct panthor_group *group)
+{
+	struct task_struct *task = current->group_leader;
+
+	group->task_info.pid = task->pid;
+	get_task_comm(group->task_info.comm, task);
+}
+
 static void add_group_kbo_sizes(struct panthor_device *ptdev,
 				struct panthor_group *group)
 {
@@ -3539,6 +3565,10 @@ int panthor_group_create(struct panthor_file *pfile,
 	add_group_kbo_sizes(group->ptdev, group);
 	spin_lock_init(&group->fdinfo.lock);
 
+	group_init_task_info(group);
+
+	xa_set_mark(&gpool->xa, gid, GROUP_REGISTERED);
+
 	return gid;
 
 err_put_group:
@@ -3553,6 +3583,9 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
 	struct panthor_scheduler *sched = ptdev->scheduler;
 	struct panthor_group *group;
 
+	if (!xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
+		return -EINVAL;
+
 	group = xa_erase(&gpool->xa, group_handle);
 	if (!group)
 		return -EINVAL;
@@ -3578,12 +3611,12 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
 }
 
 static struct panthor_group *group_from_handle(struct panthor_group_pool *pool,
-					       u32 group_handle)
+					       unsigned long group_handle)
 {
 	struct panthor_group *group;
 
 	xa_lock(&pool->xa);
-	group = group_get(xa_load(&pool->xa, group_handle));
+	group = group_get(xa_find(&pool->xa, &group_handle, group_handle, GROUP_REGISTERED));
 	xa_unlock(&pool->xa);
 
 	return group;
@@ -3670,7 +3703,7 @@ panthor_fdinfo_gather_group_mem_info(struct panthor_file *pfile,
 		return;
 
 	xa_lock(&gpool->xa);
-	xa_for_each(&gpool->xa, i, group) {
+	xa_for_each_marked(&gpool->xa, i, group, GROUP_REGISTERED) {
 		stats->resident += group->fdinfo.kbo_sizes;
 		if (group->csg_id >= 0)
 			stats->active += group->fdinfo.kbo_sizes;
@@ -3823,6 +3856,7 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
 	struct panthor_scheduler *sched = ptdev->scheduler;
 
 	cancel_delayed_work_sync(&sched->tick_work);
+	disable_work_sync(&sched->fw_events_work);
 
 	mutex_lock(&sched->lock);
 	if (sched->pm.has_ref) {
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 3f6cff2ab1b2..50ccf48ed492 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -56,12 +56,6 @@ static const u16 tidss_k2g_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
 };
 
 const struct dispc_features dispc_k2g_feats = {
-	.min_pclk_khz = 4375,
-
-	.max_pclk_khz = {
-		[DISPC_VP_DPI] = 150000,
-	},
-
 	/*
 	 * XXX According TRM the RGB input buffer width up to 2560 should
 	 *     work on 3 taps, but in practice it only works up to 1280.
@@ -144,11 +138,6 @@ static const u16 tidss_am65x_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
 };
 
 const struct dispc_features dispc_am65x_feats = {
-	.max_pclk_khz = {
-		[DISPC_VP_DPI] = 165000,
-		[DISPC_VP_OLDI_AM65X] = 165000,
-	},
-
 	.scaling = {
 		.in_width_max_5tap_rgb = 1280,
 		.in_width_max_3tap_rgb = 2560,
@@ -244,11 +233,6 @@ static const u16 tidss_j721e_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
 };
 
 const struct dispc_features dispc_j721e_feats = {
-	.max_pclk_khz = {
-		[DISPC_VP_DPI] = 170000,
-		[DISPC_VP_INTERNAL] = 600000,
-	},
-
 	.scaling = {
 		.in_width_max_5tap_rgb = 2048,
 		.in_width_max_3tap_rgb = 4096,
@@ -315,11 +299,6 @@ const struct dispc_features dispc_j721e_feats = {
 };
 
 const struct dispc_features dispc_am625_feats = {
-	.max_pclk_khz = {
-		[DISPC_VP_DPI] = 165000,
-		[DISPC_VP_INTERNAL] = 170000,
-	},
-
 	.scaling = {
 		.in_width_max_5tap_rgb = 1280,
 		.in_width_max_3tap_rgb = 2560,
@@ -376,15 +355,6 @@ const struct dispc_features dispc_am625_feats = {
 };
 
 const struct dispc_features dispc_am62a7_feats = {
-	/*
-	 * if the code reaches dispc_mode_valid with VP1,
-	 * it should return MODE_BAD.
-	 */
-	.max_pclk_khz = {
-		[DISPC_VP_TIED_OFF] = 0,
-		[DISPC_VP_DPI] = 165000,
-	},
-
 	.scaling = {
 		.in_width_max_5tap_rgb = 1280,
 		.in_width_max_3tap_rgb = 2560,
@@ -441,10 +411,6 @@ const struct dispc_features dispc_am62a7_feats = {
 };
 
 const struct dispc_features dispc_am62l_feats = {
-	.max_pclk_khz = {
-		[DISPC_VP_DPI] = 165000,
-	},
-
 	.subrev = DISPC_AM62L,
 
 	.common = "common",
@@ -1347,33 +1313,61 @@ static void dispc_vp_set_default_color(struct dispc_device *dispc,
 			DISPC_OVR_DEFAULT_COLOR2, (v >> 32) & 0xffff);
 }
 
+/*
+ * Calculate the percentage difference between the requested pixel clock rate
+ * and the effective rate resulting from calculating the clock divider value.
+ */
+unsigned int dispc_pclk_diff(unsigned long rate, unsigned long real_rate)
+{
+	int r = rate / 100, rr = real_rate / 100;
+
+	return (unsigned int)(abs(((rr - r) * 100) / r));
+}
+
+static int check_pixel_clock(struct dispc_device *dispc, u32 hw_videoport,
+			     unsigned long clock)
+{
+	unsigned long round_clock;
+
+	/*
+	 * For VP's with external clocking, clock operations must be
+	 * delegated to respective driver, so we skip the check here.
+	 */
+	if (dispc->tidss->is_ext_vp_clk[hw_videoport])
+		return 0;
+
+	round_clock = clk_round_rate(dispc->vp_clk[hw_videoport], clock);
+	/*
+	 * To keep the check consistent with dispc_vp_set_clk_rate(), we
+	 * use the same 5% check here.
+	 */
+	if (dispc_pclk_diff(clock, round_clock) > 5)
+		return -EINVAL;
+
+	return 0;
+}
+
 enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 					 u32 hw_videoport,
 					 const struct drm_display_mode *mode)
 {
 	u32 hsw, hfp, hbp, vsw, vfp, vbp;
 	enum dispc_vp_bus_type bus_type;
-	int max_pclk;
 
 	bus_type = dispc->feat->vp_bus_type[hw_videoport];
 
-	max_pclk = dispc->feat->max_pclk_khz[bus_type];
-
-	if (WARN_ON(max_pclk == 0))
+	if (WARN_ON(bus_type == DISPC_VP_TIED_OFF))
 		return MODE_BAD;
 
-	if (mode->clock < dispc->feat->min_pclk_khz)
-		return MODE_CLOCK_LOW;
-
-	if (mode->clock > max_pclk)
-		return MODE_CLOCK_HIGH;
-
 	if (mode->hdisplay > 4096)
 		return MODE_BAD;
 
 	if (mode->vdisplay > 4096)
 		return MODE_BAD;
 
+	if (check_pixel_clock(dispc, hw_videoport, mode->clock * 1000))
+		return MODE_CLOCK_RANGE;
+
 	/* TODO: add interlace support */
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
 		return MODE_NO_INTERLACE;
@@ -1437,17 +1431,6 @@ void dispc_vp_disable_clk(struct dispc_device *dispc, u32 hw_videoport)
 	clk_disable_unprepare(dispc->vp_clk[hw_videoport]);
 }
 
-/*
- * Calculate the percentage difference between the requested pixel clock rate
- * and the effective rate resulting from calculating the clock divider value.
- */
-unsigned int dispc_pclk_diff(unsigned long rate, unsigned long real_rate)
-{
-	int r = rate / 100, rr = real_rate / 100;
-
-	return (unsigned int)(abs(((rr - r) * 100) / r));
-}
-
 int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
 			  unsigned long rate)
 {
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index b8614f62186c..3979aed6413b 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -74,9 +74,6 @@ enum dispc_dss_subrevision {
 };
 
 struct dispc_features {
-	int min_pclk_khz;
-	int max_pclk_khz[DISPC_VP_MAX_BUS_TYPE];
-
 	struct dispc_features_scaling scaling;
 
 	enum dispc_dss_subrevision subrev;
diff --git a/drivers/gpu/drm/tidss/tidss_drv.h b/drivers/gpu/drm/tidss/tidss_drv.h
index d14d5d28f0a3..4e38cfa99e84 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.h
+++ b/drivers/gpu/drm/tidss/tidss_drv.h
@@ -22,6 +22,8 @@ struct tidss_device {
 
 	const struct dispc_features *feat;
 	struct dispc_device *dispc;
+	bool is_ext_vp_clk[TIDSS_MAX_PORTS];
+
 
 	unsigned int num_crtcs;
 	struct drm_crtc *crtcs[TIDSS_MAX_PORTS];
diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 8f25159d0666..d24b1e3cdce0 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -309,6 +309,25 @@ static u32 *tidss_oldi_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	return input_fmts;
 }
 
+static enum drm_mode_status
+tidss_oldi_mode_valid(struct drm_bridge *bridge,
+		      const struct drm_display_info *info,
+		      const struct drm_display_mode *mode)
+{
+	struct tidss_oldi *oldi = drm_bridge_to_tidss_oldi(bridge);
+	unsigned long round_clock;
+
+	round_clock = clk_round_rate(oldi->serial, mode->clock * 7 * 1000);
+	/*
+	 * To keep the check consistent with dispc_vp_set_clk_rate(),
+	 * we use the same 5% check here.
+	 */
+	if (dispc_pclk_diff(mode->clock * 7 * 1000, round_clock) > 5)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
 	.attach	= tidss_oldi_bridge_attach,
 	.atomic_pre_enable = tidss_oldi_atomic_pre_enable,
@@ -317,6 +336,7 @@ static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.mode_valid = tidss_oldi_mode_valid,
 };
 
 static int get_oldi_mode(struct device_node *oldi_tx, int *companion_instance)
@@ -430,6 +450,7 @@ void tidss_oldi_deinit(struct tidss_device *tidss)
 	for (int i = 0; i < tidss->num_oldis; i++) {
 		if (tidss->oldis[i]) {
 			drm_bridge_remove(&tidss->oldis[i]->bridge);
+			tidss->is_ext_vp_clk[tidss->oldis[i]->parent_vp] = false;
 			tidss->oldis[i] = NULL;
 		}
 	}
@@ -581,6 +602,7 @@ int tidss_oldi_init(struct tidss_device *tidss)
 		oldi->bridge.timings = &default_tidss_oldi_timings;
 
 		tidss->oldis[tidss->num_oldis++] = oldi;
+		tidss->is_ext_vp_clk[oldi->parent_vp] = true;
 		oldi->tidss = tidss;
 
 		drm_bridge_add(&oldi->bridge);
diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index fd76730fd38c..07db319c3d7f 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -79,7 +79,7 @@ static struct dma_fence *vgem_fence_create(struct vgem_file *vfile,
 	dma_fence_init(&fence->base, &vgem_fence_ops, &fence->lock,
 		       dma_fence_context_alloc(1), 1);
 
-	timer_setup(&fence->timer, vgem_fence_timeout, 0);
+	timer_setup(&fence->timer, vgem_fence_timeout, TIMER_IRQSAFE);
 
 	/* We force the fence to expire within 10s to prevent driver hangs */
 	mod_timer(&fence->timer, jiffies + VGEM_FENCE_TIMEOUT);
diff --git a/drivers/gpu/drm/xe/display/intel_fbdev_fb.c b/drivers/gpu/drm/xe/display/intel_fbdev_fb.c
index fba9617a75a5..96ad1c100931 100644
--- a/drivers/gpu/drm/xe/display/intel_fbdev_fb.c
+++ b/drivers/gpu/drm/xe/display/intel_fbdev_fb.c
@@ -3,7 +3,7 @@
  * Copyright © 2023 Intel Corporation
  */
 
-#include <drm/drm_fb_helper.h>
+#include <linux/fb.h>
 
 #include "intel_display_core.h"
 #include "intel_display_types.h"
@@ -15,29 +15,15 @@
 
 #include <generated/xe_wa_oob.h>
 
-struct intel_framebuffer *intel_fbdev_fb_alloc(struct drm_fb_helper *helper,
-					       struct drm_fb_helper_surface_size *sizes)
+struct intel_framebuffer *intel_fbdev_fb_alloc(struct drm_device *drm,
+					       struct drm_mode_fb_cmd2 *mode_cmd)
 {
 	struct drm_framebuffer *fb;
-	struct drm_device *dev = helper->dev;
-	struct xe_device *xe = to_xe_device(dev);
-	struct drm_mode_fb_cmd2 mode_cmd = {};
+	struct xe_device *xe = to_xe_device(drm);
 	struct xe_bo *obj;
 	int size;
 
-	/* we don't do packed 24bpp */
-	if (sizes->surface_bpp == 24)
-		sizes->surface_bpp = 32;
-
-	mode_cmd.width = sizes->surface_width;
-	mode_cmd.height = sizes->surface_height;
-
-	mode_cmd.pitches[0] = ALIGN(mode_cmd.width *
-				    DIV_ROUND_UP(sizes->surface_bpp, 8), XE_PAGE_SIZE);
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
-							  sizes->surface_depth);
-
-	size = mode_cmd.pitches[0] * mode_cmd.height;
+	size = mode_cmd->pitches[0] * mode_cmd->height;
 	size = PAGE_ALIGN(size);
 	obj = ERR_PTR(-ENODEV);
 
@@ -67,10 +53,10 @@ struct intel_framebuffer *intel_fbdev_fb_alloc(struct drm_fb_helper *helper,
 	}
 
 	fb = intel_framebuffer_create(&obj->ttm.base,
-				      drm_get_format_info(dev,
-							  mode_cmd.pixel_format,
-							  mode_cmd.modifier[0]),
-				      &mode_cmd);
+				      drm_get_format_info(drm,
+							  mode_cmd->pixel_format,
+							  mode_cmd->modifier[0]),
+				      mode_cmd);
 	if (IS_ERR(fb)) {
 		xe_bo_unpin_map_no_vm(obj);
 		goto err;
diff --git a/drivers/gpu/host1x/syncpt.c b/drivers/gpu/host1x/syncpt.c
index f63d14a57a1d..acc7d82e0585 100644
--- a/drivers/gpu/host1x/syncpt.c
+++ b/drivers/gpu/host1x/syncpt.c
@@ -345,8 +345,6 @@ static void syncpt_release(struct kref *ref)
 
 	sp->locked = false;
 
-	mutex_lock(&sp->host->syncpt_mutex);
-
 	host1x_syncpt_base_free(sp->base);
 	kfree(sp->name);
 	sp->base = NULL;
@@ -369,7 +367,7 @@ void host1x_syncpt_put(struct host1x_syncpt *sp)
 	if (!sp)
 		return;
 
-	kref_put(&sp->ref, syncpt_release);
+	kref_put_mutex(&sp->ref, syncpt_release, &sp->host->syncpt_mutex);
 }
 EXPORT_SYMBOL(host1x_syncpt_put);
 
diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
index 9610f878da1b..87186f891a6a 100644
--- a/drivers/greybus/gb-beagleplay.c
+++ b/drivers/greybus/gb-beagleplay.c
@@ -644,8 +644,8 @@ static int cc1352_bootloader_wait_for_ack(struct gb_beagleplay *bg)
 
 	ret = wait_for_completion_timeout(
 		&bg->fwl_ack_com, msecs_to_jiffies(CC1352_BOOTLOADER_TIMEOUT));
-	if (ret < 0)
-		return dev_err_probe(&bg->sd->dev, ret,
+	if (!ret)
+		return dev_err_probe(&bg->sd->dev, -ETIMEDOUT,
 				     "Failed to acquire ack semaphore");
 
 	switch (READ_ONCE(bg->fwl_ack)) {
@@ -683,8 +683,8 @@ static int cc1352_bootloader_get_status(struct gb_beagleplay *bg)
 	ret = wait_for_completion_timeout(
 		&bg->fwl_cmd_response_com,
 		msecs_to_jiffies(CC1352_BOOTLOADER_TIMEOUT));
-	if (ret < 0)
-		return dev_err_probe(&bg->sd->dev, ret,
+	if (!ret)
+		return dev_err_probe(&bg->sd->dev, -ETIMEDOUT,
 				     "Failed to acquire last status semaphore");
 
 	switch (READ_ONCE(bg->fwl_cmd_response)) {
@@ -768,8 +768,8 @@ static int cc1352_bootloader_crc32(struct gb_beagleplay *bg, u32 *crc32)
 	ret = wait_for_completion_timeout(
 		&bg->fwl_cmd_response_com,
 		msecs_to_jiffies(CC1352_BOOTLOADER_TIMEOUT));
-	if (ret < 0)
-		return dev_err_probe(&bg->sd->dev, ret,
+	if (!ret)
+		return dev_err_probe(&bg->sd->dev, -ETIMEDOUT,
 				     "Failed to acquire last status semaphore");
 
 	*crc32 = READ_ONCE(bg->fwl_cmd_response);
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5e763de4b94f..a88f2e5f791c 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -352,10 +352,15 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 
 	do {
 		ret = __do_hidpp_send_message_sync(hidpp, message, response);
-		if (ret != HIDPP20_ERROR_BUSY)
+		if (response->report_id == REPORT_ID_HIDPP_SHORT &&
+		    ret != HIDPP_ERROR_BUSY)
+			break;
+		if ((response->report_id == REPORT_ID_HIDPP_LONG ||
+		     response->report_id == REPORT_ID_HIDPP_VERY_LONG) &&
+		    ret != HIDPP20_ERROR_BUSY)
 			break;
 
-		dbg_hid("%s:got busy hidpp 2.0 error %02X, retrying\n", __func__, ret);
+		dbg_hid("%s:got busy hidpp error %02X, retrying\n", __func__, ret);
 	} while (--max_retries);
 
 	mutex_unlock(&hidpp->send_mutex);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index cad09ff5f94d..baa6a2406634 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -164,6 +164,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	unsigned int pages_order;
 	void *input_pg = NULL;
 	void *output_pg = NULL;
+	u16 reps_completed;
 
 	if (copy_from_user(&args, user_args, sizeof(args)))
 		return -EFAULT;
@@ -215,41 +216,42 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	 */
 	*(u64 *)input_pg = partition->pt_id;
 
-	if (args.reps)
-		status = hv_do_rep_hypercall(args.code, args.reps, 0,
-					     input_pg, output_pg);
-	else
-		status = hv_do_hypercall(args.code, input_pg, output_pg);
-
-	if (hv_result(status) == HV_STATUS_CALL_PENDING) {
-		if (is_async) {
-			mshv_async_hvcall_handler(partition, &status);
-		} else { /* Paranoia check. This shouldn't happen! */
-			ret = -EBADFD;
-			goto free_pages_out;
+	reps_completed = 0;
+	do {
+		if (args.reps) {
+			status = hv_do_rep_hypercall_ex(args.code, args.reps,
+							0, reps_completed,
+							input_pg, output_pg);
+			reps_completed = hv_repcomp(status);
+		} else {
+			status = hv_do_hypercall(args.code, input_pg, output_pg);
 		}
-	}
 
-	if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
-		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id, 1);
-		if (!ret)
-			ret = -EAGAIN;
-	} else if (!hv_result_success(status)) {
-		ret = hv_result_to_errno(status);
-	}
+		if (hv_result(status) == HV_STATUS_CALL_PENDING) {
+			if (is_async) {
+				mshv_async_hvcall_handler(partition, &status);
+			} else { /* Paranoia check. This shouldn't happen! */
+				ret = -EBADFD;
+				goto free_pages_out;
+			}
+		}
+
+		if (hv_result_success(status))
+			break;
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY)
+			ret = hv_result_to_errno(status);
+		else
+			ret = hv_call_deposit_pages(NUMA_NO_NODE,
+						    partition->pt_id, 1);
+	} while (!ret);
 
-	/*
-	 * Always return the status and output data regardless of result.
-	 * The VMM may need it to determine how to proceed. E.g. the status may
-	 * contain the number of reps completed if a rep hypercall partially
-	 * succeeded.
-	 */
 	args.status = hv_result(status);
-	args.reps = args.reps ? hv_repcomp(status) : 0;
+	args.reps = reps_completed;
 	if (copy_to_user(user_args, &args, sizeof(args)))
 		ret = -EFAULT;
 
-	if (output_pg &&
+	if (!ret && output_pg &&
 	    copy_to_user((void __user *)args.out_ptr, output_pg, args.out_sz))
 		ret = -EFAULT;
 
@@ -1198,21 +1200,6 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
 	return NULL;
 }
 
-static struct mshv_mem_region *
-mshv_partition_region_by_uaddr(struct mshv_partition *partition, u64 uaddr)
-{
-	struct mshv_mem_region *region;
-
-	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
-		if (uaddr >= region->start_uaddr &&
-		    uaddr < region->start_uaddr +
-			    (region->nr_pages << HV_HYP_PAGE_SHIFT))
-			return region;
-	}
-
-	return NULL;
-}
-
 /*
  * NB: caller checks and makes sure mem->size is page aligned
  * Returns: 0 with regionpp updated on success, or -errno
@@ -1222,15 +1209,21 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 					struct mshv_mem_region **regionpp,
 					bool is_mmio)
 {
-	struct mshv_mem_region *region;
+	struct mshv_mem_region *region, *rg;
 	u64 nr_pages = HVPFN_DOWN(mem->size);
 
 	/* Reject overlapping regions */
-	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
-	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages - 1) ||
-	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr) ||
-	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr + mem->size - 1))
+	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
+		u64 rg_size = rg->nr_pages << HV_HYP_PAGE_SHIFT;
+
+		if ((mem->guest_pfn + nr_pages <= rg->start_gfn ||
+		     rg->start_gfn + rg->nr_pages <= mem->guest_pfn) &&
+		    (mem->userspace_addr + mem->size <= rg->start_uaddr ||
+		     rg->start_uaddr + rg_size <= mem->userspace_addr))
+			continue;
+
 		return -EEXIST;
+	}
 
 	region = vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
 	if (!region)
diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
index a12fc0ce70e7..d51daaf63d63 100644
--- a/drivers/hwmon/sy7636a-hwmon.c
+++ b/drivers/hwmon/sy7636a-hwmon.c
@@ -66,18 +66,13 @@ static const struct hwmon_chip_info sy7636a_chip_info = {
 static int sy7636a_sensor_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	struct regulator *regulator;
 	struct device *hwmon_dev;
 	int err;
 
 	if (!regmap)
 		return -EPROBE_DEFER;
 
-	regulator = devm_regulator_get(&pdev->dev, "vcom");
-	if (IS_ERR(regulator))
-		return PTR_ERR(regulator);
-
-	err = regulator_enable(regulator);
+	err = devm_regulator_get_enable(&pdev->dev, "vcom");
 	if (err)
 		return err;
 
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f1551c08ecb2..20fdd09b75c9 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -520,6 +520,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 		goto out;
 
 	path = etm_event_cpu_path(event_data, cpu);
+	path->handle = handle;
 	/* We need a sink, no need to continue without one */
 	sink = coresight_get_sink(path);
 	if (WARN_ON_ONCE(!sink))
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index baba2245b1df..602648eb33ec 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -439,13 +439,26 @@ struct etm_enable_arg {
 	int rc;
 };
 
-static void etm_enable_hw_smp_call(void *info)
+static void etm_enable_sysfs_smp_call(void *info)
 {
 	struct etm_enable_arg *arg = info;
+	struct coresight_device *csdev;
 
 	if (WARN_ON(!arg))
 		return;
+
+	csdev = arg->drvdata->csdev;
+	if (!coresight_take_mode(csdev, CS_MODE_SYSFS)) {
+		/* Someone is already using the tracer */
+		arg->rc = -EBUSY;
+		return;
+	}
+
 	arg->rc = etm_enable_hw(arg->drvdata);
+
+	/* The tracer didn't start */
+	if (arg->rc)
+		coresight_set_mode(csdev, CS_MODE_DISABLED);
 }
 
 static int etm_cpu_id(struct coresight_device *csdev)
@@ -465,16 +478,26 @@ static int etm_enable_perf(struct coresight_device *csdev,
 			   struct coresight_path *path)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	int ret;
 
 	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
 		return -EINVAL;
 
+	if (!coresight_take_mode(csdev, CS_MODE_PERF))
+		return -EBUSY;
+
 	/* Configure the tracer based on the session's specifics */
 	etm_parse_event_config(drvdata, event);
 	drvdata->traceid = path->trace_id;
 
 	/* And enable it */
-	return etm_enable_hw(drvdata);
+	ret = etm_enable_hw(drvdata);
+
+	/* Failed to start tracer; roll back to DISABLED mode */
+	if (ret)
+		coresight_set_mode(csdev, CS_MODE_DISABLED);
+
+	return ret;
 }
 
 static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_path *path)
@@ -494,7 +517,7 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
 	if (cpu_online(drvdata->cpu)) {
 		arg.drvdata = drvdata;
 		ret = smp_call_function_single(drvdata->cpu,
-					       etm_enable_hw_smp_call, &arg, 1);
+					       etm_enable_sysfs_smp_call, &arg, 1);
 		if (!ret)
 			ret = arg.rc;
 		if (!ret)
@@ -517,12 +540,6 @@ static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
 		      enum cs_mode mode, struct coresight_path *path)
 {
 	int ret;
-	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	if (!coresight_take_mode(csdev, mode)) {
-		/* Someone is already using the tracer */
-		return -EBUSY;
-	}
 
 	switch (mode) {
 	case CS_MODE_SYSFS:
@@ -535,17 +552,12 @@ static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
 		ret = -EINVAL;
 	}
 
-	/* The tracer didn't start */
-	if (ret)
-		coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
-
 	return ret;
 }
 
-static void etm_disable_hw(void *info)
+static void etm_disable_hw(struct etm_drvdata *drvdata)
 {
 	int i;
-	struct etm_drvdata *drvdata = info;
 	struct etm_config *config = &drvdata->config;
 	struct coresight_device *csdev = drvdata->csdev;
 
@@ -567,6 +579,15 @@ static void etm_disable_hw(void *info)
 		"cpu: %d disable smp call done\n", drvdata->cpu);
 }
 
+static void etm_disable_sysfs_smp_call(void *info)
+{
+	struct etm_drvdata *drvdata = info;
+
+	etm_disable_hw(drvdata);
+
+	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
+}
+
 static void etm_disable_perf(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -588,6 +609,8 @@ static void etm_disable_perf(struct coresight_device *csdev)
 
 	CS_LOCK(drvdata->csa.base);
 
+	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
+
 	/*
 	 * perf will release trace ids when _free_aux()
 	 * is called at the end of the session
@@ -612,7 +635,8 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	 * Executing etm_disable_hw on the cpu whose ETM is being disabled
 	 * ensures that register writes occur when cpu is powered.
 	 */
-	smp_call_function_single(drvdata->cpu, etm_disable_hw, drvdata, 1);
+	smp_call_function_single(drvdata->cpu, etm_disable_sysfs_smp_call,
+				 drvdata, 1);
 
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
@@ -652,9 +676,6 @@ static void etm_disable(struct coresight_device *csdev,
 		WARN_ON_ONCE(mode);
 		return;
 	}
-
-	if (mode)
-		coresight_set_mode(csdev, CS_MODE_DISABLED);
 }
 
 static const struct coresight_ops_source etm_source_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 4b98a7bf4cb7..3906818e65c8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -446,10 +446,24 @@ static int etm4_enable_trace_unit(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, TRCRSR_TA, TRCRSR);
 
 	etm4x_allow_trace(drvdata);
+
+	/*
+	 * According to software usage PKLXF in Arm ARM (ARM DDI 0487 L.a),
+	 * execute a Context synchronization event to guarantee the trace unit
+	 * will observe the new values of the System registers.
+	 */
+	if (!csa->io_mem)
+		isb();
+
 	/* Enable the trace unit */
 	etm4x_relaxed_write32(csa, 1, TRCPRGCTLR);
 
-	/* Synchronize the register updates for sysreg access */
+	/*
+	 * As recommended by section 4.3.7 ("Synchronization when using system
+	 * instructions to progrom the trace unit") of ARM IHI 0064H.b, the
+	 * self-hosted trace analyzer must perform a Context synchronization
+	 * event between writing to the TRCPRGCTLR and reading the TRCSTATR.
+	 */
 	if (!csa->io_mem)
 		isb();
 
@@ -589,13 +603,26 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	return rc;
 }
 
-static void etm4_enable_hw_smp_call(void *info)
+static void etm4_enable_sysfs_smp_call(void *info)
 {
 	struct etm4_enable_arg *arg = info;
+	struct coresight_device *csdev;
 
 	if (WARN_ON(!arg))
 		return;
+
+	csdev = arg->drvdata->csdev;
+	if (!coresight_take_mode(csdev, CS_MODE_SYSFS)) {
+		/* Someone is already using the tracer */
+		arg->rc = -EBUSY;
+		return;
+	}
+
 	arg->rc = etm4_enable_hw(arg->drvdata);
+
+	/* The tracer didn't start */
+	if (arg->rc)
+		coresight_set_mode(csdev, CS_MODE_DISABLED);
 }
 
 /*
@@ -808,13 +835,14 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 			    struct perf_event *event,
 			    struct coresight_path *path)
 {
-	int ret = 0;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	int ret;
 
-	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id())) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
+		return -EINVAL;
+
+	if (!coresight_take_mode(csdev, CS_MODE_PERF))
+		return -EBUSY;
 
 	/* Configure the tracer based on the session's specifics */
 	ret = etm4_parse_event_config(csdev, event);
@@ -830,6 +858,9 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 	ret = etm4_enable_hw(drvdata);
 
 out:
+	/* Failed to start tracer; roll back to DISABLED mode */
+	if (ret)
+		coresight_set_mode(csdev, CS_MODE_DISABLED);
 	return ret;
 }
 
@@ -861,7 +892,7 @@ static int etm4_enable_sysfs(struct coresight_device *csdev, struct coresight_pa
 	 */
 	arg.drvdata = drvdata;
 	ret = smp_call_function_single(drvdata->cpu,
-				       etm4_enable_hw_smp_call, &arg, 1);
+				       etm4_enable_sysfs_smp_call, &arg, 1);
 	if (!ret)
 		ret = arg.rc;
 	if (!ret)
@@ -882,11 +913,6 @@ static int etm4_enable(struct coresight_device *csdev, struct perf_event *event,
 {
 	int ret;
 
-	if (!coresight_take_mode(csdev, mode)) {
-		/* Someone is already using the tracer */
-		return -EBUSY;
-	}
-
 	switch (mode) {
 	case CS_MODE_SYSFS:
 		ret = etm4_enable_sysfs(csdev, path);
@@ -898,10 +924,6 @@ static int etm4_enable(struct coresight_device *csdev, struct perf_event *event,
 		ret = -EINVAL;
 	}
 
-	/* The tracer didn't start */
-	if (ret)
-		coresight_set_mode(csdev, CS_MODE_DISABLED);
-
 	return ret;
 }
 
@@ -923,11 +945,16 @@ static void etm4_disable_trace_unit(struct etmv4_drvdata *drvdata)
 	 */
 	etm4x_prohibit_trace(drvdata);
 	/*
-	 * Make sure everything completes before disabling, as recommended
-	 * by section 7.3.77 ("TRCVICTLR, ViewInst Main Control Register,
-	 * SSTATUS") of ARM IHI 0064D
+	 * Prevent being speculative at the point of disabling the trace unit,
+	 * as recommended by section 7.3.77 ("TRCVICTLR, ViewInst Main Control
+	 * Register, SSTATUS") of ARM IHI 0064D
 	 */
 	dsb(sy);
+	/*
+	 * According to software usage VKHHY in Arm ARM (ARM DDI 0487 L.a),
+	 * execute a Context synchronization event to guarantee no new
+	 * program-flow trace is generated.
+	 */
 	isb();
 	/* Trace synchronization barrier, is a nop if not supported */
 	tsb_csync();
@@ -953,10 +980,9 @@ static void etm4_disable_trace_unit(struct etmv4_drvdata *drvdata)
 	isb();
 }
 
-static void etm4_disable_hw(void *info)
+static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
 {
 	u32 control;
-	struct etmv4_drvdata *drvdata = info;
 	struct etmv4_config *config = &drvdata->config;
 	struct coresight_device *csdev = drvdata->csdev;
 	struct csdev_access *csa = &csdev->access;
@@ -993,6 +1019,15 @@ static void etm4_disable_hw(void *info)
 		"cpu: %d disable smp call done\n", drvdata->cpu);
 }
 
+static void etm4_disable_sysfs_smp_call(void *info)
+{
+	struct etmv4_drvdata *drvdata = info;
+
+	etm4_disable_hw(drvdata);
+
+	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
+}
+
 static int etm4_disable_perf(struct coresight_device *csdev,
 			     struct perf_event *event)
 {
@@ -1022,6 +1057,8 @@ static int etm4_disable_perf(struct coresight_device *csdev,
 	/* TRCVICTLR::SSSTATUS, bit[9] */
 	filters->ssstatus = (control & BIT(9));
 
+	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
+
 	/*
 	 * perf will release trace ids when _free_aux() is
 	 * called at the end of the session.
@@ -1047,7 +1084,8 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	 * Executing etm4_disable_hw on the cpu whose ETM is being disabled
 	 * ensures that register writes occur when cpu is powered.
 	 */
-	smp_call_function_single(drvdata->cpu, etm4_disable_hw, drvdata, 1);
+	smp_call_function_single(drvdata->cpu, etm4_disable_sysfs_smp_call,
+				 drvdata, 1);
 
 	raw_spin_unlock(&drvdata->spinlock);
 
@@ -1087,9 +1125,6 @@ static void etm4_disable(struct coresight_device *csdev,
 		etm4_disable_perf(csdev, event);
 		break;
 	}
-
-	if (mode)
-		coresight_set_mode(csdev, CS_MODE_DISABLED);
 }
 
 static int etm4_resume_perf(struct coresight_device *csdev)
@@ -1823,9 +1858,11 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		goto out;
 	}
 
+	if (!drvdata->paused)
+		etm4_disable_trace_unit(drvdata);
+
 	state = drvdata->save_state;
 
-	state->trcprgctlr = etm4x_read32(csa, TRCPRGCTLR);
 	if (drvdata->nr_pe)
 		state->trcprocselr = etm4x_read32(csa, TRCPROCSELR);
 	state->trcconfigr = etm4x_read32(csa, TRCCONFIGR);
@@ -1908,7 +1945,7 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		state->trcpdcr = etm4x_read32(csa, TRCPDCR);
 
 	/* wait for TRCSTATR.IDLE to go up */
-	if (etm4x_wait_status(csa, TRCSTATR_PMSTABLE_BIT, 1)) {
+	if (etm4x_wait_status(csa, TRCSTATR_IDLE_BIT, 1)) {
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 		etm4_os_unlock(drvdata);
@@ -1935,9 +1972,6 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 {
 	int ret = 0;
 
-	/* Save the TRFCR irrespective of whether the ETM is ON */
-	if (drvdata->trfcr)
-		drvdata->save_trfcr = read_trfcr();
 	/*
 	 * Save and restore the ETM Trace registers only if
 	 * the ETM is active.
@@ -1959,7 +1993,6 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	etm4_cs_unlock(drvdata, csa);
 	etm4x_relaxed_write32(csa, state->trcclaimset, TRCCLAIMSET);
 
-	etm4x_relaxed_write32(csa, state->trcprgctlr, TRCPRGCTLR);
 	if (drvdata->nr_pe)
 		etm4x_relaxed_write32(csa, state->trcprocselr, TRCPROCSELR);
 	etm4x_relaxed_write32(csa, state->trcconfigr, TRCCONFIGR);
@@ -2044,13 +2077,15 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 
 	/* Unlock the OS lock to re-enable trace and external debug access */
 	etm4_os_unlock(drvdata);
+
+	if (!drvdata->paused)
+		etm4_enable_trace_unit(drvdata);
+
 	etm4_cs_lock(drvdata, csa);
 }
 
 static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 {
-	if (drvdata->trfcr)
-		write_trfcr(drvdata->save_trfcr);
 	if (drvdata->state_needs_restore)
 		__etm4_cpu_restore(drvdata);
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 13ec9ecef46f..b8796b427102 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -866,7 +866,6 @@ struct etmv4_config {
  * struct etm4_save_state - state to be preserved when ETM is without power
  */
 struct etmv4_save_state {
-	u32	trcprgctlr;
 	u32	trcprocselr;
 	u32	trcconfigr;
 	u32	trcauxctlr;
@@ -980,7 +979,6 @@ struct etmv4_save_state {
  *		at runtime, due to the additional setting of TRFCR_CX when
  *		in EL2. Otherwise, 0.
  * @config:	structure holding configuration parameters.
- * @save_trfcr:	Saved TRFCR_EL1 register during a CPU PM event.
  * @save_state:	State to be preserved across power loss
  * @state_needs_restore: True when there is context to restore after PM exit
  * @skip_power_up: Indicates if an implementation can skip powering up
@@ -1037,7 +1035,6 @@ struct etmv4_drvdata {
 	bool				lpoverride;
 	u64				trfcr;
 	struct etmv4_config		config;
-	u64				save_trfcr;
 	struct etmv4_save_state		*save_state;
 	bool				state_needs_restore;
 	bool				skip_power_up;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index b07fcdb3fe1a..60b0e0a6da05 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1250,6 +1250,13 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 	 * with the lock released.
 	 */
 	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/*
+	 * If the ETR is already enabled, continue with the existing buffer.
+	 */
+	if (coresight_get_mode(csdev) == CS_MODE_SYSFS)
+		goto out;
+
 	sysfs_buf = READ_ONCE(drvdata->sysfs_buf);
 	if (!sysfs_buf || (sysfs_buf->size != drvdata->size)) {
 		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -1327,7 +1334,8 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
 				   enum cs_mode mode, void *data)
 {
-	struct perf_output_handle *handle = data;
+	struct coresight_path *path = data;
+	struct perf_output_handle *handle = path->handle;
 	struct etr_perf_buffer *etr_perf;
 
 	switch (mode) {
diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index 6b918770e612..d42c03ef5db5 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -158,11 +158,16 @@ static int spacemit_i2c_handle_err(struct spacemit_i2c_dev *i2c)
 {
 	dev_dbg(i2c->dev, "i2c error status: 0x%08x\n", i2c->status);
 
-	if (i2c->status & (SPACEMIT_SR_BED | SPACEMIT_SR_ALD)) {
+	/* Arbitration Loss Detected */
+	if (i2c->status & SPACEMIT_SR_ALD) {
 		spacemit_i2c_reset(i2c);
 		return -EAGAIN;
 	}
 
+	/* Bus Error No ACK/NAK */
+	if (i2c->status & SPACEMIT_SR_BED)
+		spacemit_i2c_reset(i2c);
+
 	return i2c->status & SPACEMIT_SR_ACKNAK ? -ENXIO : -EIO;
 }
 
@@ -224,6 +229,12 @@ static void spacemit_i2c_check_bus_release(struct spacemit_i2c_dev *i2c)
 	}
 }
 
+static inline void
+spacemit_i2c_clear_int_status(struct spacemit_i2c_dev *i2c, u32 mask)
+{
+	writel(mask & SPACEMIT_I2C_INT_STATUS_MASK, i2c->base + SPACEMIT_ISR);
+}
+
 static void spacemit_i2c_init(struct spacemit_i2c_dev *i2c)
 {
 	u32 val;
@@ -267,12 +278,8 @@ static void spacemit_i2c_init(struct spacemit_i2c_dev *i2c)
 	val = readl(i2c->base + SPACEMIT_IRCR);
 	val |= SPACEMIT_RCR_SDA_GLITCH_NOFIX;
 	writel(val, i2c->base + SPACEMIT_IRCR);
-}
 
-static inline void
-spacemit_i2c_clear_int_status(struct spacemit_i2c_dev *i2c, u32 mask)
-{
-	writel(mask & SPACEMIT_I2C_INT_STATUS_MASK, i2c->base + SPACEMIT_ISR);
+	spacemit_i2c_clear_int_status(i2c, SPACEMIT_I2C_INT_STATUS_MASK);
 }
 
 static void spacemit_i2c_start(struct spacemit_i2c_dev *i2c)
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 67a18e437f83..08caaad195d5 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2811,10 +2811,6 @@ int i3c_master_register(struct i3c_master_controller *master,
 	INIT_LIST_HEAD(&master->boardinfo.i2c);
 	INIT_LIST_HEAD(&master->boardinfo.i3c);
 
-	ret = i3c_bus_init(i3cbus, master->dev.of_node);
-	if (ret)
-		return ret;
-
 	device_initialize(&master->dev);
 	dev_set_name(&master->dev, "i3c-%d", i3cbus->id);
 
@@ -2822,6 +2818,10 @@ int i3c_master_register(struct i3c_master_controller *master,
 	master->dev.coherent_dma_mask = parent->coherent_dma_mask;
 	master->dev.dma_parms = parent->dma_parms;
 
+	ret = i3c_bus_init(i3cbus, master->dev.of_node);
+	if (ret)
+		goto err_put_dev;
+
 	ret = of_populate_i3c_bus(master);
 	if (ret)
 		goto err_put_dev;
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 9641e66a4e5f..e70a64f2a32f 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -406,21 +406,27 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	int ret, val;
 	u8 *buf;
 
-	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
-	if (!slot)
-		return -ENOSPC;
-
-	slot->len = 0;
-	buf = slot->data;
-
+	/*
+	 * Wait for transfer to complete before returning. Otherwise, the EmitStop
+	 * request might be sent when the transfer is not complete.
+	 */
 	ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
 						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
 	if (ret) {
 		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
-		i3c_generic_ibi_recycle_slot(data->ibi_pool, slot);
 		return ret;
 	}
 
+	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
+	if (!slot) {
+		dev_dbg(master->dev, "No free ibi slot, drop the data\n");
+		writel(SVC_I3C_MDATACTRL_FLUSHRB, master->regs + SVC_I3C_MDATACTRL);
+		return -ENOSPC;
+	}
+
+	slot->len = 0;
+	buf = slot->data;
+
 	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  &&
 	       slot->len < SVC_I3C_FIFO_SIZE) {
 		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
index 19dd7734f9d0..80c9fa1d685a 100644
--- a/drivers/iio/imu/bmi270/bmi270_spi.c
+++ b/drivers/iio/imu/bmi270/bmi270_spi.c
@@ -60,7 +60,7 @@ static int bmi270_spi_probe(struct spi_device *spi)
 				  &bmi270_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
-				     "Failed to init i2c regmap");
+				     "Failed to init spi regmap\n");
 
 	return bmi270_core_probe(dev, regmap, chip_info);
 }
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 381b016fa524..56244d49ab2f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -383,7 +383,7 @@ enum st_lsm6dsx_fifo_mode {
  * @id: Sensor identifier.
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  * @gain: Configured sensor sensitivity.
- * @odr: Output data rate of the sensor [Hz].
+ * @odr: Output data rate of the sensor [mHz].
  * @samples_to_discard: Number of samples to discard for filters settling time.
  * @watermark: Sensor watermark level.
  * @decimator: Sensor decimation factor.
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 12fee23de81e..ba87606263cf 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -599,7 +599,8 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	mr->qplib_mr.va = (u64)(unsigned long)fence->va;
 	mr->qplib_mr.total_size = BNXT_RE_FENCE_BYTES;
 	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, NULL,
-			       BNXT_RE_FENCE_PBL_SIZE, PAGE_SIZE);
+			       BNXT_RE_FENCE_PBL_SIZE, PAGE_SIZE,
+			       _is_alloc_mr_unified(rdev->dev_attr->dev_cap_flags));
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to register fence-MR\n");
 		goto fail;
@@ -3972,7 +3973,7 @@ struct ib_mr *bnxt_re_get_dma_mr(struct ib_pd *ib_pd, int mr_access_flags)
 	mr->qplib_mr.hwq.level = PBL_LVL_MAX;
 	mr->qplib_mr.total_size = -1; /* Infinte length */
 	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, NULL, 0,
-			       PAGE_SIZE);
+			       PAGE_SIZE, false);
 	if (rc)
 		goto fail_mr;
 
@@ -4202,7 +4203,8 @@ static struct ib_mr *__bnxt_re_user_reg_mr(struct ib_pd *ib_pd, u64 length, u64
 
 	umem_pgs = ib_umem_num_dma_blocks(umem, page_size);
 	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, umem,
-			       umem_pgs, page_size);
+			       umem_pgs, page_size,
+			       _is_alloc_mr_unified(rdev->dev_attr->dev_cap_flags));
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to register user MR - rc = %d\n", rc);
 		rc = -EIO;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 68981399598d..6d1d55c8423d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -161,7 +161,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw)
 	attr->max_srq_wqes = le32_to_cpu(sb->max_srq_wr) - 1;
 	attr->max_srq_sges = sb->max_srq_sge;
 	attr->max_pkey = 1;
-	attr->max_inline_data = le32_to_cpu(sb->max_inline_data);
+	attr->max_inline_data = attr->max_qp_sges * sizeof(struct sq_sge);
 	if (!bnxt_qplib_is_chip_gen_p7(rcfw->res->cctx))
 		attr->l2_db_size = (sb->l2_db_space_size + 1) *
 				    (0x01 << RCFW_DBR_BASE_PAGE_SHIFT);
@@ -615,7 +615,7 @@ int bnxt_qplib_dereg_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
 }
 
 int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
-		      struct ib_umem *umem, int num_pbls, u32 buf_pg_size)
+		      struct ib_umem *umem, int num_pbls, u32 buf_pg_size, bool unified_mr)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
@@ -677,7 +677,7 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 	req.access = (mr->access_flags & BNXT_QPLIB_MR_ACCESS_MASK);
 	req.va = cpu_to_le64(mr->va);
 	req.key = cpu_to_le32(mr->lkey);
-	if (_is_alloc_mr_unified(res->dattr->dev_cap_flags))
+	if (unified_mr)
 		req.key = cpu_to_le32(mr->pd->id);
 	req.flags = cpu_to_le16(mr->flags);
 	req.mr_size = cpu_to_le64(mr->total_size);
@@ -688,7 +688,7 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 	if (rc)
 		goto fail;
 
-	if (_is_alloc_mr_unified(res->dattr->dev_cap_flags)) {
+	if (unified_mr) {
 		mr->lkey = le32_to_cpu(resp.xid);
 		mr->rkey = mr->lkey;
 	}
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 09faf4a1e849..4e080108b1f2 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -340,7 +340,7 @@ int bnxt_qplib_alloc_mrw(struct bnxt_qplib_res *res,
 int bnxt_qplib_dereg_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
 			 bool block);
 int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
-		      struct ib_umem *umem, int num_pbls, u32 buf_pg_size);
+		      struct ib_umem *umem, int num_pbls, u32 buf_pg_size, bool unified_mr);
 int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr);
 int bnxt_qplib_alloc_fast_reg_mr(struct bnxt_qplib_res *res,
 				 struct bnxt_qplib_mrw *mr, int max);
diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index c6a0a661d6e7..f4f4f92ba63a 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -3710,7 +3710,7 @@ int irdma_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 	iwpd = iwqp->iwpd;
 	tagged_offset = (uintptr_t)iwqp->ietf_mem.va;
 	ibmr = irdma_reg_phys_mr(&iwpd->ibpd, iwqp->ietf_mem.pa, buf_len,
-				 IB_ACCESS_LOCAL_WRITE, &tagged_offset);
+				 IB_ACCESS_LOCAL_WRITE, &tagged_offset, false);
 	if (IS_ERR(ibmr)) {
 		ret = -ENOMEM;
 		goto error;
diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 99a7f1a6c0b5..30a162f68b06 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -3316,11 +3316,13 @@ int irdma_sc_cqp_destroy(struct irdma_sc_cqp *cqp)
  */
 void irdma_sc_ccq_arm(struct irdma_sc_cq *ccq)
 {
+	unsigned long flags;
 	u64 temp_val;
 	u16 sw_cq_sel;
 	u8 arm_next_se;
 	u8 arm_seq_num;
 
+	spin_lock_irqsave(&ccq->dev->cqp_lock, flags);
 	get_64bit_val(ccq->cq_uk.shadow_area, 32, &temp_val);
 	sw_cq_sel = (u16)FIELD_GET(IRDMA_CQ_DBSA_SW_CQ_SELECT, temp_val);
 	arm_next_se = (u8)FIELD_GET(IRDMA_CQ_DBSA_ARM_NEXT_SE, temp_val);
@@ -3331,6 +3333,7 @@ void irdma_sc_ccq_arm(struct irdma_sc_cq *ccq)
 		   FIELD_PREP(IRDMA_CQ_DBSA_ARM_NEXT_SE, arm_next_se) |
 		   FIELD_PREP(IRDMA_CQ_DBSA_ARM_NEXT, 1);
 	set_64bit_val(ccq->cq_uk.shadow_area, 32, temp_val);
+	spin_unlock_irqrestore(&ccq->dev->cqp_lock, flags);
 
 	dma_wmb(); /* make sure shadow area is updated before arming */
 
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 674acc952168..f863c0aaf85d 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -538,7 +538,7 @@ void irdma_copy_ip_htonl(__be32 *dst, u32 *src);
 u16 irdma_get_vlan_ipv4(u32 *addr);
 void irdma_get_vlan_mac_ipv6(u32 *addr, u16 *vlan_id, u8 *mac);
 struct ib_mr *irdma_reg_phys_mr(struct ib_pd *ib_pd, u64 addr, u64 size,
-				int acc, u64 *iova_start);
+				int acc, u64 *iova_start, bool dma_mr);
 int irdma_upload_qp_context(struct irdma_qp *iwqp, bool freeze, bool raw);
 void irdma_cqp_ce_handler(struct irdma_pci_f *rf, struct irdma_sc_cq *cq);
 int irdma_ah_cqp_op(struct irdma_pci_f *rf, struct irdma_sc_ah *sc_ah, u8 cmd,
diff --git a/drivers/infiniband/hw/irdma/pble.c b/drivers/infiniband/hw/irdma/pble.c
index 24f455e6dbbc..42d61b17e676 100644
--- a/drivers/infiniband/hw/irdma/pble.c
+++ b/drivers/infiniband/hw/irdma/pble.c
@@ -498,12 +498,14 @@ int irdma_get_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
 void irdma_free_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
 		     struct irdma_pble_alloc *palloc)
 {
-	pble_rsrc->freedpbles += palloc->total_cnt;
-
 	if (palloc->level == PBLE_LEVEL_2)
 		free_lvl2(pble_rsrc, palloc);
 	else
 		irdma_prm_return_pbles(&pble_rsrc->pinfo,
 				       &palloc->level1.chunkinfo);
+
+	mutex_lock(&pble_rsrc->pble_mutex_lock);
+	pble_rsrc->freedpbles += palloc->total_cnt;
 	pble_rsrc->stats_alloc_freed++;
+	mutex_unlock(&pble_rsrc->pble_mutex_lock);
 }
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index eb4683b248af..f8a7a0382a38 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2654,7 +2654,6 @@ static int irdma_hw_alloc_stag(struct irdma_device *iwdev,
 	info->stag_idx = iwmr->stag >> IRDMA_CQPSQ_STAG_IDX_S;
 	info->pd_id = iwpd->sc_pd.pd_id;
 	info->total_len = iwmr->len;
-	info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	info->remote_access = true;
 	cqp_info->cqp_cmd = IRDMA_OP_ALLOC_STAG;
 	cqp_info->post_sq = 1;
@@ -2665,7 +2664,7 @@ static int irdma_hw_alloc_stag(struct irdma_device *iwdev,
 	if (status)
 		return status;
 
-	iwmr->is_hwreg = 1;
+	iwmr->is_hwreg = true;
 	return 0;
 }
 
@@ -2806,7 +2805,7 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	stag_info->total_len = iwmr->len;
 	stag_info->access_rights = irdma_get_mr_access(access);
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
-	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
+	stag_info->all_memory = iwmr->dma_mr;
 	if (stag_info->access_rights & IRDMA_ACCESS_FLAGS_ZERO_BASED)
 		stag_info->addr_type = IRDMA_ADDR_TYPE_ZERO_BASED;
 	else
@@ -2833,7 +2832,7 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	irdma_put_cqp_request(&iwdev->rf->cqp, cqp_request);
 
 	if (!ret)
-		iwmr->is_hwreg = 1;
+		iwmr->is_hwreg = true;
 
 	return ret;
 }
@@ -3169,7 +3168,7 @@ static int irdma_hwdereg_mr(struct ib_mr *ib_mr)
 	if (status)
 		return status;
 
-	iwmr->is_hwreg = 0;
+	iwmr->is_hwreg = false;
 	return 0;
 }
 
@@ -3292,9 +3291,10 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
  * @size: size of memory to register
  * @access: Access rights
  * @iova_start: start of virtual address for physical buffers
+ * @dma_mr: Flag indicating whether this region is a PD DMA MR
  */
 struct ib_mr *irdma_reg_phys_mr(struct ib_pd *pd, u64 addr, u64 size, int access,
-				u64 *iova_start)
+				u64 *iova_start, bool dma_mr)
 {
 	struct irdma_device *iwdev = to_iwdev(pd->device);
 	struct irdma_pbl *iwpbl;
@@ -3311,6 +3311,7 @@ struct ib_mr *irdma_reg_phys_mr(struct ib_pd *pd, u64 addr, u64 size, int access
 	iwpbl = &iwmr->iwpbl;
 	iwpbl->iwmr = iwmr;
 	iwmr->type = IRDMA_MEMREG_TYPE_MEM;
+	iwmr->dma_mr = dma_mr;
 	iwpbl->user_base = *iova_start;
 	stag = irdma_create_stag(iwdev);
 	if (!stag) {
@@ -3349,7 +3350,7 @@ static struct ib_mr *irdma_get_dma_mr(struct ib_pd *pd, int acc)
 {
 	u64 kva = 0;
 
-	return irdma_reg_phys_mr(pd, 0, 0, acc, &kva);
+	return irdma_reg_phys_mr(pd, 0, 0, acc, &kva, true);
 }
 
 /**
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index 36ff8dd712f0..cbd8bef68ae4 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -101,7 +101,8 @@ struct irdma_mr {
 	};
 	struct ib_umem *region;
 	int access;
-	u8 is_hwreg;
+	bool is_hwreg:1;
+	bool dma_mr:1;
 	u16 type;
 	u32 page_cnt;
 	u64 page_size;
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 3661cb627d28..2a234f26ac10 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -171,7 +171,7 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 				       udata, mi, &srq->rq.producer_lock,
 				       &srq->rq.consumer_lock);
 		if (err)
-			goto err_free;
+			return err;
 
 		srq->rq.max_wr = attr->max_wr;
 	}
@@ -180,11 +180,6 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		srq->limit = attr->srq_limit;
 
 	return 0;
-
-err_free:
-	rxe_queue_cleanup(q);
-	srq->rq.queue = NULL;
-	return err;
 }
 
 void rxe_srq_cleanup(struct rxe_pool_elem *elem)
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index ef4abdea3c2d..9ecc6343455d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1450,7 +1450,7 @@ static struct rtrs_srv_sess *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 	kfree(srv->chunks);
 
 err_free_srv:
-	kfree(srv);
+	put_device(&srv->dev);
 	return ERR_PTR(-ENOMEM);
 }
 
diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
index bc3fd8a7b9eb..778deeb4a7e8 100644
--- a/drivers/interconnect/debugfs-client.c
+++ b/drivers/interconnect/debugfs-client.c
@@ -117,7 +117,12 @@ static int icc_commit_set(void *data, u64 val)
 
 	mutex_lock(&debugfs_lock);
 
-	if (IS_ERR_OR_NULL(cur_path)) {
+	if (!cur_path) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (IS_ERR(cur_path)) {
 		ret = PTR_ERR(cur_path);
 		goto out;
 	}
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index b73566c9b21f..84cfafb22aa1 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -552,6 +552,7 @@ static struct qcom_icc_node mas_venus_vmem = {
 static const u16 mas_snoc_pnoc_links[] = {
 	MSM8996_SLAVE_BLSP_1,
 	MSM8996_SLAVE_BLSP_2,
+	MSM8996_SLAVE_USB_HS,
 	MSM8996_SLAVE_SDCC_1,
 	MSM8996_SLAVE_SDCC_2,
 	MSM8996_SLAVE_SDCC_4,
diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 10fa217a7119..20b04996441d 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -37,7 +37,7 @@ static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
 	if (ret)
 		return ret;
 
-	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - 4) {
+	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64)) {
 		iommu->dbg_mmio_offset = -1;
 		return  -EINVAL;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2a8b46b948f0..9780f40ba3e6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1464,7 +1464,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 		cd_table->l2.l1tab = dma_alloc_coherent(smmu->dev, l1size,
 							&cd_table->cdtab_dma,
 							GFP_KERNEL);
-		if (!cd_table->l2.l2ptrs) {
+		if (!cd_table->l2.l1tab) {
 			ret = -ENOMEM;
 			goto err_free_l2ptrs;
 		}
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 57c097e87613..c939d0856b71 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -431,17 +431,19 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 
 	/*
 	 * Some platforms support more than the Arm SMMU architected maximum of
-	 * 128 stream matching groups. For unknown reasons, the additional
-	 * groups don't exhibit the same behavior as the architected registers,
-	 * so limit the groups to 128 until the behavior is fixed for the other
-	 * groups.
+	 * 128 stream matching groups. The additional registers appear to have
+	 * the same behavior as the architected registers in the hardware.
+	 * However, on some firmware versions, the hypervisor does not
+	 * correctly trap and emulate accesses to the additional registers,
+	 * resulting in unexpected behavior.
+	 *
+	 * If there are more than 128 groups, use the last reliable group to
+	 * detect if we need to apply the bypass quirk.
 	 */
-	if (smmu->num_mapping_groups > 128) {
-		dev_notice(smmu->dev, "\tLimiting the stream matching groups to 128\n");
-		smmu->num_mapping_groups = 128;
-	}
-
-	last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
+	if (smmu->num_mapping_groups > 128)
+		last_s2cr = ARM_SMMU_GR0_S2CR(127);
+	else
+		last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
 
 	/*
 	 * With some firmware versions writes to S2CR of type FAULT are
@@ -464,6 +466,11 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 
 		reg = FIELD_PREP(ARM_SMMU_CBAR_TYPE, CBAR_TYPE_S1_TRANS_S2_BYPASS);
 		arm_smmu_gr1_write(smmu, ARM_SMMU_GR1_CBAR(qsmmu->bypass_cbndx), reg);
+
+		if (smmu->num_mapping_groups > 128) {
+			dev_notice(smmu->dev, "\tLimiting the stream matching groups to 128\n");
+			smmu->num_mapping_groups = 128;
+		}
 	}
 
 	for (i = 0; i < smmu->num_mapping_groups; i++) {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 21b2c3f85ddc..96823fab06a7 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1100,7 +1100,7 @@ static inline void qi_desc_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 				 struct qi_desc *desc)
 {
 	u8 dw = 0, dr = 0;
-	int ih = 0;
+	int ih = addr & 1;
 
 	if (cap_write_drain(iommu->cap))
 		dw = 1;
diff --git a/drivers/irqchip/irq-bcm2712-mip.c b/drivers/irqchip/irq-bcm2712-mip.c
index 9bd7bc0bf6d5..8466646e5a2d 100644
--- a/drivers/irqchip/irq-bcm2712-mip.c
+++ b/drivers/irqchip/irq-bcm2712-mip.c
@@ -232,14 +232,13 @@ static int mip_parse_dt(struct mip_priv *mip, struct device_node *np)
 	return ret;
 }
 
-static int __init mip_of_msi_init(struct device_node *node, struct device_node *parent)
+static int mip_of_msi_init(struct device_node *node, struct device_node *parent)
 {
 	struct platform_device *pdev;
 	struct mip_priv *mip;
 	int ret;
 
 	pdev = of_find_device_by_node(node);
-	of_node_put(node);
 	if (!pdev)
 		return -EPROBE_DEFER;
 
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 04fac0cc857f..eda33bd5d080 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -219,9 +219,8 @@ static int bcm7038_l1_set_affinity(struct irq_data *d,
 }
 #endif
 
-static int __init bcm7038_l1_init_one(struct device_node *dn,
-				      unsigned int idx,
-				      struct bcm7038_l1_chip *intc)
+static int bcm7038_l1_init_one(struct device_node *dn, unsigned int idx,
+			       struct bcm7038_l1_chip *intc)
 {
 	struct resource res;
 	resource_size_t sz;
@@ -395,8 +394,7 @@ static const struct irq_domain_ops bcm7038_l1_domain_ops = {
 	.map			= bcm7038_l1_map,
 };
 
-static int __init bcm7038_l1_of_init(struct device_node *dn,
-			      struct device_node *parent)
+static int bcm7038_l1_of_init(struct device_node *dn, struct device_node *parent)
 {
 	struct bcm7038_l1_chip *intc;
 	int idx, ret;
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index ff22c3104401..b6c85560c42e 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -143,8 +143,7 @@ static int bcm7120_l2_intc_init_one(struct device_node *dn,
 	return 0;
 }
 
-static int __init bcm7120_l2_intc_iomap_7120(struct device_node *dn,
-					     struct bcm7120_l2_intc_data *data)
+static int bcm7120_l2_intc_iomap_7120(struct device_node *dn, struct bcm7120_l2_intc_data *data)
 {
 	int ret;
 
@@ -177,8 +176,7 @@ static int __init bcm7120_l2_intc_iomap_7120(struct device_node *dn,
 	return 0;
 }
 
-static int __init bcm7120_l2_intc_iomap_3380(struct device_node *dn,
-					     struct bcm7120_l2_intc_data *data)
+static int bcm7120_l2_intc_iomap_3380(struct device_node *dn, struct bcm7120_l2_intc_data *data)
 {
 	unsigned int gc_idx;
 
@@ -208,10 +206,9 @@ static int __init bcm7120_l2_intc_iomap_3380(struct device_node *dn,
 	return 0;
 }
 
-static int __init bcm7120_l2_intc_probe(struct device_node *dn,
-				 struct device_node *parent,
+static int bcm7120_l2_intc_probe(struct device_node *dn, struct device_node *parent,
 				 int (*iomap_regs_fn)(struct device_node *,
-					struct bcm7120_l2_intc_data *),
+						      struct bcm7120_l2_intc_data *),
 				 const char *intc_name)
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
@@ -339,15 +336,13 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 	return ret;
 }
 
-static int __init bcm7120_l2_intc_probe_7120(struct device_node *dn,
-					     struct device_node *parent)
+static int bcm7120_l2_intc_probe_7120(struct device_node *dn, struct device_node *parent)
 {
 	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_7120,
 				     "BCM7120 L2");
 }
 
-static int __init bcm7120_l2_intc_probe_3380(struct device_node *dn,
-					     struct device_node *parent)
+static int bcm7120_l2_intc_probe_3380(struct device_node *dn, struct device_node *parent)
 {
 	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_3380,
 				     "BCM3380 L2");
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 1bec5b2cd3f0..53e67c6c01f7 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -138,10 +138,8 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	irq_reg_writel(gc, ~b->saved_mask, ct->regs.enable);
 }
 
-static int __init brcmstb_l2_intc_of_init(struct device_node *np,
-					  struct device_node *parent,
-					  const struct brcmstb_intc_init_params
-					  *init_params)
+static int brcmstb_l2_intc_of_init(struct device_node *np, struct device_node *parent,
+				   const struct brcmstb_intc_init_params *init_params)
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	unsigned int set = 0;
@@ -257,14 +255,12 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	return ret;
 }
 
-static int __init brcmstb_l2_edge_intc_of_init(struct device_node *np,
-	struct device_node *parent)
+static int brcmstb_l2_edge_intc_of_init(struct device_node *np, struct device_node *parent)
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_edge_intc_init);
 }
 
-static int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
-	struct device_node *parent)
+static int brcmstb_l2_lvl_intc_of_init(struct device_node *np, struct device_node *parent)
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_lvl_intc_init);
 }
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index d2a4e8a61a42..41df168aa7da 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -296,9 +296,8 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
 		  },
 };
 
-static int __init imx_mu_of_init(struct device_node *dn,
-				 struct device_node *parent,
-				 const struct imx_mu_dcfg *cfg)
+static int imx_mu_of_init(struct device_node *dn, struct device_node *parent,
+			  const struct imx_mu_dcfg *cfg)
 {
 	struct platform_device *pdev = of_find_device_by_node(dn);
 	struct device_link *pd_link_a;
@@ -416,20 +415,17 @@ static const struct dev_pm_ops imx_mu_pm_ops = {
 			   imx_mu_runtime_resume, NULL)
 };
 
-static int __init imx_mu_imx7ulp_of_init(struct device_node *dn,
-					 struct device_node *parent)
+static int imx_mu_imx7ulp_of_init(struct device_node *dn, struct device_node *parent)
 {
 	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx7ulp);
 }
 
-static int __init imx_mu_imx6sx_of_init(struct device_node *dn,
-					struct device_node *parent)
+static int imx_mu_imx6sx_of_init(struct device_node *dn, struct device_node *parent)
 {
 	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx6sx);
 }
 
-static int __init imx_mu_imx8ulp_of_init(struct device_node *dn,
-					 struct device_node *parent)
+static int imx_mu_imx8ulp_of_init(struct device_node *dn, struct device_node *parent)
 {
 	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx8ulp);
 }
diff --git a/drivers/irqchip/irq-mchp-eic.c b/drivers/irqchip/irq-mchp-eic.c
index 516a3a0e359c..c6b5529e17f1 100644
--- a/drivers/irqchip/irq-mchp-eic.c
+++ b/drivers/irqchip/irq-mchp-eic.c
@@ -166,7 +166,7 @@ static int mchp_eic_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	ret = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
 	if (ret || hwirq >= MCHP_EIC_NIRQ)
-		return ret;
+		return ret ?: -EINVAL;
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 360d88687e4f..32fec9aa37c4 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -597,14 +597,12 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 	return 0;
 }
 
-static int __init rzg2l_irqc_init(struct device_node *node,
-				  struct device_node *parent)
+static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 {
 	return rzg2l_irqc_common_init(node, parent, &rzg2l_irqc_chip);
 }
 
-static int __init rzfive_irqc_init(struct device_node *node,
-				   struct device_node *parent)
+static int rzfive_irqc_init(struct device_node *node, struct device_node *parent)
 {
 	return rzg2l_irqc_common_init(node, parent, &rzfive_irqc_chip);
 }
diff --git a/drivers/irqchip/irq-starfive-jh8100-intc.c b/drivers/irqchip/irq-starfive-jh8100-intc.c
index 2460798ec158..117f2c651ebd 100644
--- a/drivers/irqchip/irq-starfive-jh8100-intc.c
+++ b/drivers/irqchip/irq-starfive-jh8100-intc.c
@@ -114,8 +114,7 @@ static void starfive_intc_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int __init starfive_intc_init(struct device_node *intc,
-				     struct device_node *parent)
+static int starfive_intc_init(struct device_node *intc, struct device_node *parent)
 {
 	struct starfive_irq_chip *irqc;
 	struct reset_control *rst;
diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
index 18e696dc7f4d..9308088773be 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -222,7 +222,7 @@ static int get_registers(struct platform_device *pdev, struct combiner *comb)
 	return 0;
 }
 
-static int __init combiner_probe(struct platform_device *pdev)
+static int combiner_probe(struct platform_device *pdev)
 {
 	struct combiner *combiner;
 	int nregs;
diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
index e95287416ef8..99df46f2d9f5 100644
--- a/drivers/leds/leds-netxbig.c
+++ b/drivers/leds/leds-netxbig.c
@@ -364,6 +364,9 @@ static int netxbig_gpio_ext_get(struct device *dev,
 	if (!addr)
 		return -ENOMEM;
 
+	gpio_ext->addr = addr;
+	gpio_ext->num_addr = 0;
+
 	/*
 	 * We cannot use devm_ managed resources with these GPIO descriptors
 	 * since they are associated with the "GPIO extension device" which
@@ -375,45 +378,58 @@ static int netxbig_gpio_ext_get(struct device *dev,
 		gpiod = gpiod_get_index(gpio_ext_dev, "addr", i,
 					GPIOD_OUT_LOW);
 		if (IS_ERR(gpiod))
-			return PTR_ERR(gpiod);
+			goto err_set_code;
 		gpiod_set_consumer_name(gpiod, "GPIO extension addr");
 		addr[i] = gpiod;
+		gpio_ext->num_addr++;
 	}
-	gpio_ext->addr = addr;
-	gpio_ext->num_addr = num_addr;
 
 	ret = gpiod_count(gpio_ext_dev, "data");
 	if (ret < 0) {
 		dev_err(dev,
 			"Failed to count GPIOs in DT property data-gpios\n");
-		return ret;
+		goto err_free_addr;
 	}
 	num_data = ret;
 	data = devm_kcalloc(dev, num_data, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
+	if (!data) {
+		ret = -ENOMEM;
+		goto err_free_addr;
+	}
+
+	gpio_ext->data = data;
+	gpio_ext->num_data = 0;
 
 	for (i = 0; i < num_data; i++) {
 		gpiod = gpiod_get_index(gpio_ext_dev, "data", i,
 					GPIOD_OUT_LOW);
 		if (IS_ERR(gpiod))
-			return PTR_ERR(gpiod);
+			goto err_free_data;
 		gpiod_set_consumer_name(gpiod, "GPIO extension data");
 		data[i] = gpiod;
+		gpio_ext->num_data++;
 	}
-	gpio_ext->data = data;
-	gpio_ext->num_data = num_data;
 
 	gpiod = gpiod_get(gpio_ext_dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(gpiod)) {
 		dev_err(dev,
 			"Failed to get GPIO from DT property enable-gpio\n");
-		return PTR_ERR(gpiod);
+		goto err_free_data;
 	}
 	gpiod_set_consumer_name(gpiod, "GPIO extension enable");
 	gpio_ext->enable = gpiod;
 
 	return devm_add_action_or_reset(dev, netxbig_gpio_ext_remove, gpio_ext);
+
+err_free_data:
+	for (i = 0; i < gpio_ext->num_data; i++)
+		gpiod_put(gpio_ext->data[i]);
+err_set_code:
+	ret = PTR_ERR(gpiod);
+err_free_addr:
+	for (i = 0; i < gpio_ext->num_addr; i++)
+		gpiod_put(gpio_ext->addr[i]);
+	return ret;
 }
 
 static int netxbig_leds_get_of_pdata(struct device *dev,
diff --git a/drivers/leds/leds-upboard.c b/drivers/leds/leds-upboard.c
index b350eb294280..12989b2f1953 100644
--- a/drivers/leds/leds-upboard.c
+++ b/drivers/leds/leds-upboard.c
@@ -123,4 +123,4 @@ MODULE_AUTHOR("Gary Wang <garywang@aaeon.com.tw>");
 MODULE_AUTHOR("Thomas Richard <thomas.richard@bootlin.com>");
 MODULE_DESCRIPTION("UP Board LED driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:upboard-led");
+MODULE_ALIAS("platform:upboard-leds");
diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 4f2a178e3d26..e197f548cddb 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) 2017-2022 Linaro Ltd
  * Copyright (c) 2010-2012, The Linux Foundation. All rights reserved.
- * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/bits.h>
 #include <linux/bitfield.h>
@@ -1247,8 +1247,6 @@ static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	lpg_apply(chan);
 
-	triled_set(lpg, chan->triled_mask, chan->enabled ? chan->triled_mask : 0);
-
 out_unlock:
 	mutex_unlock(&lpg->lock);
 
diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index 369d72f59b3c..06fd910b3fd1 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -187,13 +187,14 @@ static int mac_hid_toggle_emumouse(const struct ctl_table *table, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = table->data;
-	int old_val = *valp;
+	int old_val;
 	int rc;
 
 	rc = mutex_lock_killable(&mac_hid_emumouse_mutex);
 	if (rc)
 		return rc;
 
+	old_val = *valp;
 	rc = proc_dointvec(table, write, buffer, lenp, ppos);
 
 	if (rc == 0 && write && *valp != old_val) {
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 679b07dee229..1f8fbc27a12f 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -432,6 +432,7 @@ static int log_writes_kthread(void *arg)
 	struct log_writes_c *lc = arg;
 	sector_t sector = 0;
 
+	set_freezable();
 	while (!kthread_should_stop()) {
 		bool super = false;
 		bool logging_enabled;
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index f4b904e24328..0d2e1c5eee92 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2287,6 +2287,8 @@ static int super_init_validation(struct raid_set *rs, struct md_rdev *rdev)
 
 			mddev->reshape_position = le64_to_cpu(sb->reshape_position);
 			rs->raid_type = get_raid_type_by_ll(mddev->level, mddev->layout);
+			if (!rs->raid_type)
+				return -EINVAL;
 		}
 
 	} else {
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4e033c26fdd4..48345082d2eb 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -100,7 +100,7 @@ static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this);
 static void mddev_detach(struct mddev *mddev);
 static void export_rdev(struct md_rdev *rdev, struct mddev *mddev);
-static void md_wakeup_thread_directly(struct md_thread __rcu *thread);
+static void md_wakeup_thread_directly(struct md_thread __rcu **thread);
 
 /*
  * Default number of read corrections we'll attempt on an rdev
@@ -887,8 +887,11 @@ void mddev_unlock(struct mddev *mddev)
 		 * do_md_stop. dm raid only uses md_stop to stop. So dm raid
 		 * doesn't need to check MD_DELETED when getting reconfig lock
 		 */
-		if (test_bit(MD_DELETED, &mddev->flags))
+		if (test_bit(MD_DELETED, &mddev->flags) &&
+		    !test_and_set_bit(MD_DO_DELETE, &mddev->flags)) {
+			kobject_del(&mddev->kobj);
 			del_gendisk(mddev->gendisk);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(mddev_unlock);
@@ -4982,7 +4985,7 @@ static void stop_sync_thread(struct mddev *mddev, bool locked)
 	 * Thread might be blocked waiting for metadata update which will now
 	 * never happen
 	 */
-	md_wakeup_thread_directly(mddev->sync_thread);
+	md_wakeup_thread_directly(&mddev->sync_thread);
 	if (work_pending(&mddev->sync_work))
 		flush_work(&mddev->sync_work);
 
@@ -6693,6 +6696,10 @@ static int do_md_stop(struct mddev *mddev, int mode)
 		if (!md_is_rdwr(mddev))
 			set_disk_ro(disk, 0);
 
+		if (mode == 2 && mddev->pers->sync_request &&
+		    mddev->to_remove == NULL)
+			mddev->to_remove = &md_redundancy_group;
+
 		__md_stop_writes(mddev);
 		__md_stop(mddev);
 
@@ -8194,22 +8201,21 @@ static int md_thread(void *arg)
 	return 0;
 }
 
-static void md_wakeup_thread_directly(struct md_thread __rcu *thread)
+static void md_wakeup_thread_directly(struct md_thread __rcu **thread)
 {
 	struct md_thread *t;
 
 	rcu_read_lock();
-	t = rcu_dereference(thread);
+	t = rcu_dereference(*thread);
 	if (t)
 		wake_up_process(t->tsk);
 	rcu_read_unlock();
 }
 
-void md_wakeup_thread(struct md_thread __rcu *thread)
+void __md_wakeup_thread(struct md_thread __rcu *thread)
 {
 	struct md_thread *t;
 
-	rcu_read_lock();
 	t = rcu_dereference(thread);
 	if (t) {
 		pr_debug("md: waking up MD thread %s.\n", t->tsk->comm);
@@ -8217,9 +8223,8 @@ void md_wakeup_thread(struct md_thread __rcu *thread)
 		if (wq_has_sleeper(&t->wqueue))
 			wake_up(&t->wqueue);
 	}
-	rcu_read_unlock();
 }
-EXPORT_SYMBOL(md_wakeup_thread);
+EXPORT_SYMBOL(__md_wakeup_thread);
 
 struct md_thread *md_register_thread(void (*run) (struct md_thread *),
 		struct mddev *mddev, const char *name)
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 51af29a03079..0a1a227f106b 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -353,6 +353,7 @@ enum mddev_flags {
 	MD_HAS_MULTIPLE_PPLS,
 	MD_NOT_READY,
 	MD_BROKEN,
+	MD_DO_DELETE,
 	MD_DELETED,
 };
 
@@ -878,6 +879,12 @@ struct md_io_clone {
 
 #define THREAD_WAKEUP  0
 
+#define md_wakeup_thread(thread) do {   \
+	rcu_read_lock();                    \
+	__md_wakeup_thread(thread);         \
+	rcu_read_unlock();                  \
+} while (0)
+
 static inline void safe_put_page(struct page *p)
 {
 	if (p) put_page(p);
@@ -891,7 +898,7 @@ extern struct md_thread *md_register_thread(
 	struct mddev *mddev,
 	const char *name);
 extern void md_unregister_thread(struct mddev *mddev, struct md_thread __rcu **threadp);
-extern void md_wakeup_thread(struct md_thread __rcu *thread);
+extern void __md_wakeup_thread(struct md_thread __rcu *thread);
 extern void md_check_recovery(struct mddev *mddev);
 extern void md_reap_sync_thread(struct mddev *mddev);
 extern enum sync_action md_sync_action(struct mddev *mddev);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 771ac1cbab99..8f45de227f1c 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4938,7 +4938,8 @@ static void handle_stripe(struct stripe_head *sh)
 		goto finish;
 
 	if (s.handle_bad_blocks ||
-	    test_bit(MD_SB_CHANGE_PENDING, &conf->mddev->sb_flags)) {
+	    (md_is_rdwr(conf->mddev) &&
+	     test_bit(MD_SB_CHANGE_PENDING, &conf->mddev->sb_flags))) {
 		set_bit(STRIPE_HANDLE, &sh->state);
 		goto finish;
 	}
@@ -6753,7 +6754,8 @@ static void raid5d(struct md_thread *thread)
 		int batch_size, released;
 		unsigned int offset;
 
-		if (test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
+		if (md_is_rdwr(mddev) &&
+		    test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
 			break;
 
 		released = release_stripe_list(conf, conf->temp_inactive_list);
diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index 1f727ef60d63..8c989b74f924 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -388,6 +388,7 @@ int da9055_device_init(struct da9055 *da9055)
 
 err:
 	mfd_remove_devices(da9055->dev);
+	regmap_del_irq_chip(da9055->chip_irq, da9055->irq_data);
 	return ret;
 }
 
diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
index f467b00d2366..74cf20843044 100644
--- a/drivers/mfd/mt6358-irq.c
+++ b/drivers/mfd/mt6358-irq.c
@@ -285,6 +285,7 @@ int mt6358_irq_init(struct mt6397_chip *chip)
 	if (ret) {
 		dev_err(chip->dev, "Failed to register IRQ=%d, ret=%d\n",
 			chip->irq, ret);
+		irq_domain_remove(chip->irq_domain);
 		return ret;
 	}
 
diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
index 0e463026c5a9..5d2e5459f744 100644
--- a/drivers/mfd/mt6397-irq.c
+++ b/drivers/mfd/mt6397-irq.c
@@ -229,6 +229,7 @@ int mt6397_irq_init(struct mt6397_chip *chip)
 	if (ret) {
 		dev_err(chip->dev, "failed to register irq=%d; err: %d\n",
 			chip->irq, ret);
+		irq_domain_remove(chip->irq_domain);
 		return ret;
 	}
 
diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
index 803832006ec8..a342bcc6164b 100644
--- a/drivers/misc/rp1/rp1_pci.c
+++ b/drivers/misc/rp1/rp1_pci.c
@@ -289,6 +289,9 @@ static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_unload_overlay;
 	}
 
+	if (skip_ovl)
+		of_node_put(rp1_node);
+
 	return 0;
 
 err_unload_overlay:
diff --git a/drivers/mtd/lpddr/lpddr_cmds.c b/drivers/mtd/lpddr/lpddr_cmds.c
index 14e36ae71958..bd76479b90e4 100644
--- a/drivers/mtd/lpddr/lpddr_cmds.c
+++ b/drivers/mtd/lpddr/lpddr_cmds.c
@@ -79,7 +79,7 @@ struct mtd_info *lpddr_cmdset(struct map_info *map)
 		mutex_init(&shared[i].lock);
 		for (j = 0; j < lpddr->qinfo->HWPartsNum; j++) {
 			*chip = lpddr->chips[i];
-			chip->start += j << lpddr->chipshift;
+			chip->start += (unsigned long)j << lpddr->chipshift;
 			chip->oldstate = chip->state = FL_READY;
 			chip->priv = &shared[i];
 			/* those should be reset too since
@@ -559,7 +559,7 @@ static int lpddr_point(struct mtd_info *mtd, loff_t adr, size_t len,
 			break;
 
 		if ((len + ofs - 1) >> lpddr->chipshift)
-			thislen = (1<<lpddr->chipshift) - ofs;
+			thislen = (1UL << lpddr->chipshift) - ofs;
 		else
 			thislen = len;
 		/* get the chip */
@@ -575,7 +575,7 @@ static int lpddr_point(struct mtd_info *mtd, loff_t adr, size_t len,
 		len -= thislen;
 
 		ofs = 0;
-		last_end += 1 << lpddr->chipshift;
+		last_end += 1UL << lpddr->chipshift;
 		chipnum++;
 		chip = &lpddr->chips[chipnum];
 	}
@@ -601,7 +601,7 @@ static int lpddr_unpoint (struct mtd_info *mtd, loff_t adr, size_t len)
 			break;
 
 		if ((len + ofs - 1) >> lpddr->chipshift)
-			thislen = (1<<lpddr->chipshift) - ofs;
+			thislen = (1UL << lpddr->chipshift) - ofs;
 		else
 			thislen = len;
 
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index b54d76547ffb..fea3705a2138 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -937,6 +937,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	dma_release_channel(host->dma_chan);
 enable_wp:
 	lpc32xx_wp_enable(host);
+	gpiod_put(host->wp_gpio);
 
 	return res;
 }
@@ -962,6 +963,7 @@ static void lpc32xx_nand_remove(struct platform_device *pdev)
 	writel(tmp, SLC_CTRL(host->io_base));
 
 	lpc32xx_wp_enable(host);
+	gpiod_put(host->wp_gpio);
 }
 
 static int lpc32xx_nand_resume(struct platform_device *pdev)
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 303b3016a070..38b7eb5b992c 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -290,13 +290,16 @@ static const struct marvell_hw_ecc_layout marvell_nfc_layouts[] = {
 	MARVELL_LAYOUT( 2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
 	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,32, 30),
 	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,64, 30),
-	MARVELL_LAYOUT( 2048,   512,  16, 4,  4, 512,   0, 30,  0, 32, 30),
+	MARVELL_LAYOUT( 2048,   512,  12, 3,  2, 704,   0, 30,640,  0, 30),
+	MARVELL_LAYOUT( 2048,   512,  16, 5,  4, 512,   0, 30,  0, 32, 30),
 	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 4096,   512,  8,  4,  4, 1024,  0, 30,  0, 64, 30),
-	MARVELL_LAYOUT( 4096,   512,  16, 8,  8, 512,   0, 30,  0, 32, 30),
+	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
+	MARVELL_LAYOUT( 4096,   512,  12, 6,  5, 704,   0, 30,576, 32, 30),
+	MARVELL_LAYOUT( 4096,   512,  16, 9,  8, 512,   0, 30,  0, 32, 30),
 	MARVELL_LAYOUT( 8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 8192,   512,  8,  8,  8, 1024,  0, 30,  0, 160, 30),
-	MARVELL_LAYOUT( 8192,   512,  16, 16, 16, 512,  0, 30,  0,  32, 30),
+	MARVELL_LAYOUT( 8192,   512,  8,  9,  8, 1024,  0, 30,  0, 160, 30),
+	MARVELL_LAYOUT( 8192,   512,  12, 12, 11, 704,  0, 30,448,  64, 30),
+	MARVELL_LAYOUT( 8192,   512,  16, 17, 16, 512,  0, 30,  0,  32, 30),
 };
 
 /**
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 13e4060bd1b6..a25145dbc16e 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -6469,11 +6469,14 @@ static int nand_scan_tail(struct nand_chip *chip)
 		ecc->steps = mtd->writesize / ecc->size;
 	if (!base->ecc.ctx.nsteps)
 		base->ecc.ctx.nsteps = ecc->steps;
-	if (ecc->steps * ecc->size != mtd->writesize) {
-		WARN(1, "Invalid ECC parameters\n");
-		ret = -EINVAL;
-		goto err_nand_manuf_cleanup;
-	}
+
+	/*
+	 * Validity check: Warn if ECC parameters are not compatible with page size.
+	 * Due to the custom handling of ECC blocks in certain controllers the check
+	 * may result in an expected failure.
+	 */
+	if (ecc->steps * ecc->size != mtd->writesize)
+		pr_warn("ECC parameters may be invalid in reference to underlying NAND chip\n");
 
 	if (!ecc->total) {
 		ecc->total = ecc->steps * ecc->bytes;
diff --git a/drivers/mtd/nand/raw/renesas-nand-controller.c b/drivers/mtd/nand/raw/renesas-nand-controller.c
index ac8c1b80d7be..201dd62b9990 100644
--- a/drivers/mtd/nand/raw/renesas-nand-controller.c
+++ b/drivers/mtd/nand/raw/renesas-nand-controller.c
@@ -1336,7 +1336,10 @@ static int rnandc_probe(struct platform_device *pdev)
 	if (IS_ERR(rnandc->regs))
 		return PTR_ERR(rnandc->regs);
 
-	devm_pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index eb767edc4c13..62cafced758e 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1830,49 +1830,83 @@ static int b53_arl_rw_op(struct b53_device *dev, unsigned int op)
 	return b53_arl_op_wait(dev);
 }
 
-static int b53_arl_read(struct b53_device *dev, u64 mac,
-			u16 vid, struct b53_arl_entry *ent, u8 *idx)
+static void b53_arl_read_entry_25(struct b53_device *dev,
+				  struct b53_arl_entry *ent, u8 idx)
 {
-	DECLARE_BITMAP(free_bins, B53_ARLTBL_MAX_BIN_ENTRIES);
-	unsigned int i;
-	int ret;
+	u8 vid_entry;
+	u64 mac_vid;
 
-	ret = b53_arl_op_wait(dev);
-	if (ret)
-		return ret;
+	b53_read8(dev, B53_ARLIO_PAGE, B53_ARLTBL_VID_ENTRY_25(idx),
+		  &vid_entry);
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARLTBL_MAC_VID_ENTRY(idx),
+		   &mac_vid);
+	b53_arl_to_entry_25(ent, mac_vid, vid_entry);
+}
 
-	bitmap_zero(free_bins, dev->num_arl_bins);
+static void b53_arl_write_entry_25(struct b53_device *dev,
+				   const struct b53_arl_entry *ent, u8 idx)
+{
+	u8 vid_entry;
+	u64 mac_vid;
 
-	/* Read the bins */
-	for (i = 0; i < dev->num_arl_bins; i++) {
-		u64 mac_vid;
-		u32 fwd_entry;
+	b53_arl_from_entry_25(&mac_vid, &vid_entry, ent);
+	b53_write8(dev, B53_ARLIO_PAGE, B53_ARLTBL_VID_ENTRY_25(idx), vid_entry);
+	b53_write64(dev, B53_ARLIO_PAGE, B53_ARLTBL_MAC_VID_ENTRY(idx),
+		    mac_vid);
+}
 
-		b53_read64(dev, B53_ARLIO_PAGE,
-			   B53_ARLTBL_MAC_VID_ENTRY(i), &mac_vid);
-		b53_read32(dev, B53_ARLIO_PAGE,
-			   B53_ARLTBL_DATA_ENTRY(i), &fwd_entry);
-		b53_arl_to_entry(ent, mac_vid, fwd_entry);
+static void b53_arl_read_entry_89(struct b53_device *dev,
+				  struct b53_arl_entry *ent, u8 idx)
+{
+	u64 mac_vid;
+	u16 fwd_entry;
 
-		if (!(fwd_entry & ARLTBL_VALID)) {
-			set_bit(i, free_bins);
-			continue;
-		}
-		if ((mac_vid & ARLTBL_MAC_MASK) != mac)
-			continue;
-		if (dev->vlan_enabled &&
-		    ((mac_vid >> ARLTBL_VID_S) & ARLTBL_VID_MASK) != vid)
-			continue;
-		*idx = i;
-		return 0;
-	}
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARLTBL_MAC_VID_ENTRY(idx),
+		   &mac_vid);
+	b53_read16(dev, B53_ARLIO_PAGE, B53_ARLTBL_DATA_ENTRY(idx), &fwd_entry);
+	b53_arl_to_entry_89(ent, mac_vid, fwd_entry);
+}
 
-	*idx = find_first_bit(free_bins, dev->num_arl_bins);
-	return *idx >= dev->num_arl_bins ? -ENOSPC : -ENOENT;
+static void b53_arl_write_entry_89(struct b53_device *dev,
+				   const struct b53_arl_entry *ent, u8 idx)
+{
+	u32 fwd_entry;
+	u64 mac_vid;
+
+	b53_arl_from_entry_89(&mac_vid, &fwd_entry, ent);
+	b53_write64(dev, B53_ARLIO_PAGE,
+		    B53_ARLTBL_MAC_VID_ENTRY(idx), mac_vid);
+	b53_write16(dev, B53_ARLIO_PAGE,
+		    B53_ARLTBL_DATA_ENTRY(idx), fwd_entry);
+}
+
+static void b53_arl_read_entry_95(struct b53_device *dev,
+				  struct b53_arl_entry *ent, u8 idx)
+{
+	u32 fwd_entry;
+	u64 mac_vid;
+
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARLTBL_MAC_VID_ENTRY(idx),
+		   &mac_vid);
+	b53_read32(dev, B53_ARLIO_PAGE, B53_ARLTBL_DATA_ENTRY(idx), &fwd_entry);
+	b53_arl_to_entry(ent, mac_vid, fwd_entry);
+}
+
+static void b53_arl_write_entry_95(struct b53_device *dev,
+				   const struct b53_arl_entry *ent, u8 idx)
+{
+	u32 fwd_entry;
+	u64 mac_vid;
+
+	b53_arl_from_entry(&mac_vid, &fwd_entry, ent);
+	b53_write64(dev, B53_ARLIO_PAGE, B53_ARLTBL_MAC_VID_ENTRY(idx),
+		    mac_vid);
+	b53_write32(dev, B53_ARLIO_PAGE, B53_ARLTBL_DATA_ENTRY(idx),
+		    fwd_entry);
 }
 
-static int b53_arl_read_25(struct b53_device *dev, u64 mac,
-			   u16 vid, struct b53_arl_entry *ent, u8 *idx)
+static int b53_arl_read(struct b53_device *dev, const u8 *mac,
+			u16 vid, struct b53_arl_entry *ent, u8 *idx)
 {
 	DECLARE_BITMAP(free_bins, B53_ARLTBL_MAX_BIN_ENTRIES);
 	unsigned int i;
@@ -1886,21 +1920,15 @@ static int b53_arl_read_25(struct b53_device *dev, u64 mac,
 
 	/* Read the bins */
 	for (i = 0; i < dev->num_arl_bins; i++) {
-		u64 mac_vid;
+		b53_arl_read_entry(dev, ent, i);
 
-		b53_read64(dev, B53_ARLIO_PAGE,
-			   B53_ARLTBL_MAC_VID_ENTRY(i), &mac_vid);
-
-		b53_arl_to_entry_25(ent, mac_vid);
-
-		if (!(mac_vid & ARLTBL_VALID_25)) {
+		if (!ent->is_valid) {
 			set_bit(i, free_bins);
 			continue;
 		}
-		if ((mac_vid & ARLTBL_MAC_MASK) != mac)
+		if (!ether_addr_equal(ent->mac, mac))
 			continue;
-		if (dev->vlan_enabled &&
-		    ((mac_vid >> ARLTBL_VID_S_65) & ARLTBL_VID_MASK_25) != vid)
+		if (dev->vlan_enabled && ent->vid != vid)
 			continue;
 		*idx = i;
 		return 0;
@@ -1914,9 +1942,8 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 		      const unsigned char *addr, u16 vid, bool is_valid)
 {
 	struct b53_arl_entry ent;
-	u32 fwd_entry;
-	u64 mac, mac_vid = 0;
 	u8 idx = 0;
+	u64 mac;
 	int ret;
 
 	/* Convert the array into a 64-bit MAC */
@@ -1924,18 +1951,19 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 
 	/* Perform a read for the given MAC and VID */
 	b53_write48(dev, B53_ARLIO_PAGE, B53_MAC_ADDR_IDX, mac);
-	if (!is5325m(dev))
-		b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+	if (!is5325m(dev)) {
+		if (is5325(dev) || is5365(dev))
+			b53_write8(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+		else
+			b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+	}
 
 	/* Issue a read operation for this MAC */
 	ret = b53_arl_rw_op(dev, 1);
 	if (ret)
 		return ret;
 
-	if (is5325(dev) || is5365(dev))
-		ret = b53_arl_read_25(dev, mac, vid, &ent, &idx);
-	else
-		ret = b53_arl_read(dev, mac, vid, &ent, &idx);
+	ret = b53_arl_read(dev, addr, vid, &ent, &idx);
 
 	/* If this is a read, just finish now */
 	if (op)
@@ -1952,7 +1980,6 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 		/* We could not find a matching MAC, so reset to a new entry */
 		dev_dbg(dev->dev, "{%pM,%.4d} not found, using idx: %d\n",
 			addr, vid, idx);
-		fwd_entry = 0;
 		break;
 	default:
 		dev_dbg(dev->dev, "{%pM,%.4d} found, using idx: %d\n",
@@ -1979,17 +2006,7 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 	ent.is_static = true;
 	ent.is_age = false;
 	memcpy(ent.mac, addr, ETH_ALEN);
-	if (is5325(dev) || is5365(dev))
-		b53_arl_from_entry_25(&mac_vid, &ent);
-	else
-		b53_arl_from_entry(&mac_vid, &fwd_entry, &ent);
-
-	b53_write64(dev, B53_ARLIO_PAGE,
-		    B53_ARLTBL_MAC_VID_ENTRY(idx), mac_vid);
-
-	if (!is5325(dev) && !is5365(dev))
-		b53_write32(dev, B53_ARLIO_PAGE,
-			    B53_ARLTBL_DATA_ENTRY(idx), fwd_entry);
+	b53_arl_write_entry(dev, &ent, idx);
 
 	return b53_arl_rw_op(dev, 0);
 }
@@ -2024,18 +2041,53 @@ int b53_fdb_del(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL(b53_fdb_del);
 
-static int b53_arl_search_wait(struct b53_device *dev)
+static void b53_read_arl_srch_ctl(struct b53_device *dev, u8 *val)
 {
-	unsigned int timeout = 1000;
-	u8 reg, offset;
+	u8 offset;
 
 	if (is5325(dev) || is5365(dev))
 		offset = B53_ARL_SRCH_CTL_25;
+	else if (dev->chip_id == BCM5389_DEVICE_ID || is5397_98(dev) ||
+		 is63xx(dev))
+		offset = B53_ARL_SRCH_CTL_89;
 	else
 		offset = B53_ARL_SRCH_CTL;
 
+	if (is63xx(dev)) {
+		u16 val16;
+
+		b53_read16(dev, B53_ARLIO_PAGE, offset, &val16);
+		*val = val16 & 0xff;
+	} else {
+		b53_read8(dev, B53_ARLIO_PAGE, offset, val);
+	}
+}
+
+static void b53_write_arl_srch_ctl(struct b53_device *dev, u8 val)
+{
+	u8 offset;
+
+	if (is5325(dev) || is5365(dev))
+		offset = B53_ARL_SRCH_CTL_25;
+	else if (dev->chip_id == BCM5389_DEVICE_ID || is5397_98(dev) ||
+		 is63xx(dev))
+		offset = B53_ARL_SRCH_CTL_89;
+	else
+		offset = B53_ARL_SRCH_CTL;
+
+	if (is63xx(dev))
+		b53_write16(dev, B53_ARLIO_PAGE, offset, val);
+	else
+		b53_write8(dev, B53_ARLIO_PAGE, offset, val);
+}
+
+static int b53_arl_search_wait(struct b53_device *dev)
+{
+	unsigned int timeout = 1000;
+	u8 reg;
+
 	do {
-		b53_read8(dev, B53_ARLIO_PAGE, offset, &reg);
+		b53_read_arl_srch_ctl(dev, &reg);
 		if (!(reg & ARL_SRCH_STDN))
 			return -ENOENT;
 
@@ -2048,28 +2100,53 @@ static int b53_arl_search_wait(struct b53_device *dev)
 	return -ETIMEDOUT;
 }
 
-static void b53_arl_search_rd(struct b53_device *dev, u8 idx,
-			      struct b53_arl_entry *ent)
+static void b53_arl_search_read_25(struct b53_device *dev, u8 idx,
+				   struct b53_arl_entry *ent)
 {
 	u64 mac_vid;
+	u8 ext;
 
-	if (is5325(dev)) {
-		b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVID_25,
-			   &mac_vid);
-		b53_arl_to_entry_25(ent, mac_vid);
-	} else if (is5365(dev)) {
-		b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVID_65,
-			   &mac_vid);
-		b53_arl_to_entry_25(ent, mac_vid);
-	} else {
-		u32 fwd_entry;
+	b53_read8(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSLT_EXT_25, &ext);
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVID_25,
+		   &mac_vid);
+	b53_arl_search_to_entry_25(ent, mac_vid, ext);
+}
 
-		b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_MACVID(idx),
-			   &mac_vid);
-		b53_read32(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL(idx),
-			   &fwd_entry);
-		b53_arl_to_entry(ent, mac_vid, fwd_entry);
-	}
+static void b53_arl_search_read_89(struct b53_device *dev, u8 idx,
+				   struct b53_arl_entry *ent)
+{
+	u16 fwd_entry;
+	u64 mac_vid;
+
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSLT_MACVID_89,
+		   &mac_vid);
+	b53_read16(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSLT_89, &fwd_entry);
+	b53_arl_to_entry_89(ent, mac_vid, fwd_entry);
+}
+
+static void b53_arl_search_read_63xx(struct b53_device *dev, u8 idx,
+				     struct b53_arl_entry *ent)
+{
+	u16 fwd_entry;
+	u64 mac_vid;
+
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSLT_MACVID_63XX,
+		   &mac_vid);
+	b53_read16(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSLT_63XX, &fwd_entry);
+	b53_arl_search_to_entry_63xx(ent, mac_vid, fwd_entry);
+}
+
+static void b53_arl_search_read_95(struct b53_device *dev, u8 idx,
+				   struct b53_arl_entry *ent)
+{
+	u32 fwd_entry;
+	u64 mac_vid;
+
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_MACVID(idx),
+		   &mac_vid);
+	b53_read32(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL(idx),
+		   &fwd_entry);
+	b53_arl_to_entry(ent, mac_vid, fwd_entry);
 }
 
 static int b53_fdb_copy(int port, const struct b53_arl_entry *ent,
@@ -2090,36 +2167,28 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
 	unsigned int count = 0, results_per_hit = 1;
 	struct b53_device *priv = ds->priv;
 	struct b53_arl_entry results[2];
-	u8 offset;
 	int ret;
-	u8 reg;
 
 	if (priv->num_arl_bins > 2)
 		results_per_hit = 2;
 
 	mutex_lock(&priv->arl_mutex);
 
-	if (is5325(priv) || is5365(priv))
-		offset = B53_ARL_SRCH_CTL_25;
-	else
-		offset = B53_ARL_SRCH_CTL;
-
 	/* Start search operation */
-	reg = ARL_SRCH_STDN;
-	b53_write8(priv, B53_ARLIO_PAGE, offset, reg);
+	b53_write_arl_srch_ctl(priv, ARL_SRCH_STDN);
 
 	do {
 		ret = b53_arl_search_wait(priv);
 		if (ret)
 			break;
 
-		b53_arl_search_rd(priv, 0, &results[0]);
+		b53_arl_search_read(priv, 0, &results[0]);
 		ret = b53_fdb_copy(port, &results[0], cb, data);
 		if (ret)
 			break;
 
 		if (results_per_hit == 2) {
-			b53_arl_search_rd(priv, 1, &results[1]);
+			b53_arl_search_read(priv, 1, &results[1]);
 			ret = b53_fdb_copy(port, &results[1], cb, data);
 			if (ret)
 				break;
@@ -2645,6 +2714,30 @@ static const struct dsa_switch_ops b53_switch_ops = {
 	.port_change_mtu	= b53_change_mtu,
 };
 
+static const struct b53_arl_ops b53_arl_ops_25 = {
+	.arl_read_entry = b53_arl_read_entry_25,
+	.arl_write_entry = b53_arl_write_entry_25,
+	.arl_search_read = b53_arl_search_read_25,
+};
+
+static const struct b53_arl_ops b53_arl_ops_89 = {
+	.arl_read_entry = b53_arl_read_entry_89,
+	.arl_write_entry = b53_arl_write_entry_89,
+	.arl_search_read = b53_arl_search_read_89,
+};
+
+static const struct b53_arl_ops b53_arl_ops_63xx = {
+	.arl_read_entry = b53_arl_read_entry_89,
+	.arl_write_entry = b53_arl_write_entry_89,
+	.arl_search_read = b53_arl_search_read_63xx,
+};
+
+static const struct b53_arl_ops b53_arl_ops_95 = {
+	.arl_read_entry = b53_arl_read_entry_95,
+	.arl_write_entry = b53_arl_write_entry_95,
+	.arl_search_read = b53_arl_search_read_95,
+};
+
 struct b53_chip_data {
 	u32 chip_id;
 	const char *dev_name;
@@ -2658,6 +2751,7 @@ struct b53_chip_data {
 	u8 duplex_reg;
 	u8 jumbo_pm_reg;
 	u8 jumbo_size_reg;
+	const struct b53_arl_ops *arl_ops;
 };
 
 #define B53_VTA_REGS	\
@@ -2677,6 +2771,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.arl_buckets = 1024,
 		.imp_port = 5,
 		.duplex_reg = B53_DUPLEX_STAT_FE,
+		.arl_ops = &b53_arl_ops_25,
 	},
 	{
 		.chip_id = BCM5365_DEVICE_ID,
@@ -2687,6 +2782,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.arl_buckets = 1024,
 		.imp_port = 5,
 		.duplex_reg = B53_DUPLEX_STAT_FE,
+		.arl_ops = &b53_arl_ops_25,
 	},
 	{
 		.chip_id = BCM5389_DEVICE_ID,
@@ -2700,6 +2796,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_89,
 	},
 	{
 		.chip_id = BCM5395_DEVICE_ID,
@@ -2713,6 +2810,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM5397_DEVICE_ID,
@@ -2726,6 +2824,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_89,
 	},
 	{
 		.chip_id = BCM5398_DEVICE_ID,
@@ -2739,6 +2838,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_89,
 	},
 	{
 		.chip_id = BCM53101_DEVICE_ID,
@@ -2752,6 +2852,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53115_DEVICE_ID,
@@ -2765,6 +2866,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53125_DEVICE_ID,
@@ -2778,6 +2880,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53128_DEVICE_ID,
@@ -2791,19 +2894,21 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM63XX_DEVICE_ID,
 		.dev_name = "BCM63xx",
 		.vlans = 4096,
 		.enabled_ports = 0, /* pdata must provide them */
-		.arl_bins = 4,
-		.arl_buckets = 1024,
+		.arl_bins = 1,
+		.arl_buckets = 4096,
 		.imp_port = 8,
 		.vta_regs = B53_VTA_REGS_63XX,
 		.duplex_reg = B53_DUPLEX_STAT_63XX,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK_63XX,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE_63XX,
+		.arl_ops = &b53_arl_ops_63xx,
 	},
 	{
 		.chip_id = BCM53010_DEVICE_ID,
@@ -2817,6 +2922,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53011_DEVICE_ID,
@@ -2830,6 +2936,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53012_DEVICE_ID,
@@ -2843,6 +2950,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53018_DEVICE_ID,
@@ -2856,6 +2964,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53019_DEVICE_ID,
@@ -2869,6 +2978,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM58XX_DEVICE_ID,
@@ -2882,6 +2992,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM583XX_DEVICE_ID,
@@ -2895,6 +3006,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	/* Starfighter 2 */
 	{
@@ -2909,6 +3021,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM7445_DEVICE_ID,
@@ -2922,6 +3035,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM7278_DEVICE_ID,
@@ -2935,6 +3049,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53134_DEVICE_ID,
@@ -2949,6 +3064,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 };
 
@@ -2977,6 +3093,7 @@ static int b53_switch_init(struct b53_device *dev)
 			dev->num_vlans = chip->vlans;
 			dev->num_arl_bins = chip->arl_bins;
 			dev->num_arl_buckets = chip->arl_buckets;
+			dev->arl_ops = chip->arl_ops;
 			break;
 		}
 	}
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 458775f95164..bd6849e5bb93 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -58,6 +58,17 @@ struct b53_io_ops {
 				bool link_up);
 };
 
+struct b53_arl_entry;
+
+struct b53_arl_ops {
+	void (*arl_read_entry)(struct b53_device *dev,
+			       struct b53_arl_entry *ent, u8 idx);
+	void (*arl_write_entry)(struct b53_device *dev,
+				const struct b53_arl_entry *ent, u8 idx);
+	void (*arl_search_read)(struct b53_device *dev, u8 idx,
+				struct b53_arl_entry *ent);
+};
+
 #define B53_INVALID_LANE	0xff
 
 enum {
@@ -127,6 +138,7 @@ struct b53_device {
 	struct mutex stats_mutex;
 	struct mutex arl_mutex;
 	const struct b53_io_ops *ops;
+	const struct b53_arl_ops *arl_ops;
 
 	/* chip specific data */
 	u32 chip_id;
@@ -329,16 +341,30 @@ static inline void b53_arl_to_entry(struct b53_arl_entry *ent,
 }
 
 static inline void b53_arl_to_entry_25(struct b53_arl_entry *ent,
-				       u64 mac_vid)
+				       u64 mac_vid, u8 vid_entry)
 {
 	memset(ent, 0, sizeof(*ent));
-	ent->port = (mac_vid >> ARLTBL_DATA_PORT_ID_S_25) &
-		     ARLTBL_DATA_PORT_ID_MASK_25;
 	ent->is_valid = !!(mac_vid & ARLTBL_VALID_25);
 	ent->is_age = !!(mac_vid & ARLTBL_AGE_25);
 	ent->is_static = !!(mac_vid & ARLTBL_STATIC_25);
 	u64_to_ether_addr(mac_vid, ent->mac);
-	ent->vid = mac_vid >> ARLTBL_VID_S_65;
+	ent->port = (mac_vid & ARLTBL_DATA_PORT_ID_MASK_25) >>
+		     ARLTBL_DATA_PORT_ID_S_25;
+	if (is_unicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT)
+		ent->port = B53_CPU_PORT_25;
+	ent->vid = vid_entry;
+}
+
+static inline void b53_arl_to_entry_89(struct b53_arl_entry *ent,
+				       u64 mac_vid, u16 fwd_entry)
+{
+	memset(ent, 0, sizeof(*ent));
+	ent->port = fwd_entry & ARLTBL_DATA_PORT_ID_MASK_89;
+	ent->is_valid = !!(fwd_entry & ARLTBL_VALID_89);
+	ent->is_age = !!(fwd_entry & ARLTBL_AGE_89);
+	ent->is_static = !!(fwd_entry & ARLTBL_STATIC_89);
+	u64_to_ether_addr(mac_vid, ent->mac);
+	ent->vid = mac_vid >> ARLTBL_VID_S;
 }
 
 static inline void b53_arl_from_entry(u64 *mac_vid, u32 *fwd_entry,
@@ -355,20 +381,87 @@ static inline void b53_arl_from_entry(u64 *mac_vid, u32 *fwd_entry,
 		*fwd_entry |= ARLTBL_AGE;
 }
 
-static inline void b53_arl_from_entry_25(u64 *mac_vid,
+static inline void b53_arl_from_entry_25(u64 *mac_vid, u8 *vid_entry,
 					 const struct b53_arl_entry *ent)
 {
 	*mac_vid = ether_addr_to_u64(ent->mac);
-	*mac_vid |= (u64)(ent->port & ARLTBL_DATA_PORT_ID_MASK_25) <<
-			  ARLTBL_DATA_PORT_ID_S_25;
-	*mac_vid |= (u64)(ent->vid & ARLTBL_VID_MASK_25) <<
-			  ARLTBL_VID_S_65;
+	if (is_unicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT_25)
+		*mac_vid |= (u64)B53_CPU_PORT << ARLTBL_DATA_PORT_ID_S_25;
+	else
+		*mac_vid |= ((u64)ent->port << ARLTBL_DATA_PORT_ID_S_25) &
+			    ARLTBL_DATA_PORT_ID_MASK_25;
 	if (ent->is_valid)
 		*mac_vid |= ARLTBL_VALID_25;
 	if (ent->is_static)
 		*mac_vid |= ARLTBL_STATIC_25;
 	if (ent->is_age)
 		*mac_vid |= ARLTBL_AGE_25;
+	*vid_entry = ent->vid;
+}
+
+static inline void b53_arl_from_entry_89(u64 *mac_vid, u32 *fwd_entry,
+					 const struct b53_arl_entry *ent)
+{
+	*mac_vid = ether_addr_to_u64(ent->mac);
+	*mac_vid |= (u64)(ent->vid & ARLTBL_VID_MASK) << ARLTBL_VID_S;
+	*fwd_entry = ent->port & ARLTBL_DATA_PORT_ID_MASK_89;
+	if (ent->is_valid)
+		*fwd_entry |= ARLTBL_VALID_89;
+	if (ent->is_static)
+		*fwd_entry |= ARLTBL_STATIC_89;
+	if (ent->is_age)
+		*fwd_entry |= ARLTBL_AGE_89;
+}
+
+static inline void b53_arl_search_to_entry_25(struct b53_arl_entry *ent,
+					      u64 mac_vid, u8 ext)
+{
+	memset(ent, 0, sizeof(*ent));
+	ent->is_valid = !!(mac_vid & ARLTBL_VALID_25);
+	ent->is_age = !!(mac_vid & ARLTBL_AGE_25);
+	ent->is_static = !!(mac_vid & ARLTBL_STATIC_25);
+	u64_to_ether_addr(mac_vid, ent->mac);
+	ent->vid = (mac_vid & ARL_SRCH_RSLT_VID_MASK_25) >>
+		   ARL_SRCH_RSLT_VID_S_25;
+	ent->port = (mac_vid & ARL_SRCH_RSLT_PORT_ID_MASK_25) >>
+		    ARL_SRCH_RSLT_PORT_ID_S_25;
+	if (is_multicast_ether_addr(ent->mac) && (ext & ARL_SRCH_RSLT_EXT_MC_MII))
+		ent->port |= BIT(B53_CPU_PORT_25);
+	else if (!is_multicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT)
+		ent->port = B53_CPU_PORT_25;
+}
+
+static inline void b53_arl_search_to_entry_63xx(struct b53_arl_entry *ent,
+						u64 mac_vid, u16 fwd_entry)
+{
+	memset(ent, 0, sizeof(*ent));
+	u64_to_ether_addr(mac_vid, ent->mac);
+	ent->vid = mac_vid >> ARLTBL_VID_S;
+
+	ent->port = fwd_entry & ARL_SRST_PORT_ID_MASK_63XX;
+	ent->port >>= 1;
+
+	ent->is_age = !!(fwd_entry & ARL_SRST_AGE_63XX);
+	ent->is_static = !!(fwd_entry & ARL_SRST_STATIC_63XX);
+	ent->is_valid = 1;
+}
+
+static inline void b53_arl_read_entry(struct b53_device *dev,
+				      struct b53_arl_entry *ent, u8 idx)
+{
+	dev->arl_ops->arl_read_entry(dev, ent, idx);
+}
+
+static inline void b53_arl_write_entry(struct b53_device *dev,
+				       const struct b53_arl_entry *ent, u8 idx)
+{
+	dev->arl_ops->arl_write_entry(dev, ent, idx);
+}
+
+static inline void b53_arl_search_read(struct b53_device *dev, u8 idx,
+				       struct b53_arl_entry *ent)
+{
+	dev->arl_ops->arl_search_read(dev, idx, ent);
 }
 
 #ifdef CONFIG_BCM47XX
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 8ce1ce72e938..b6fe7d207a2c 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -325,11 +325,9 @@
 #define B53_ARLTBL_MAC_VID_ENTRY(n)	((0x10 * (n)) + 0x10)
 #define   ARLTBL_MAC_MASK		0xffffffffffffULL
 #define   ARLTBL_VID_S			48
-#define   ARLTBL_VID_MASK_25		0xff
 #define   ARLTBL_VID_MASK		0xfff
 #define   ARLTBL_DATA_PORT_ID_S_25	48
-#define   ARLTBL_DATA_PORT_ID_MASK_25	0xf
-#define   ARLTBL_VID_S_65		53
+#define   ARLTBL_DATA_PORT_ID_MASK_25	GENMASK_ULL(53, 48)
 #define   ARLTBL_AGE_25			BIT_ULL(61)
 #define   ARLTBL_STATIC_25		BIT_ULL(62)
 #define   ARLTBL_VALID_25		BIT_ULL(63)
@@ -342,12 +340,23 @@
 #define   ARLTBL_STATIC			BIT(15)
 #define   ARLTBL_VALID			BIT(16)
 
+/* BCM5389 ARL Table Data Entry N Register format (16 bit) */
+#define   ARLTBL_DATA_PORT_ID_MASK_89	GENMASK(8, 0)
+#define   ARLTBL_TC_MASK_89		GENMASK(12, 10)
+#define   ARLTBL_AGE_89			BIT(13)
+#define   ARLTBL_STATIC_89		BIT(14)
+#define   ARLTBL_VALID_89		BIT(15)
+
+/* BCM5325/BCM565 ARL Table VID Entry N Registers (8 bit) */
+#define B53_ARLTBL_VID_ENTRY_25(n)	((0x2 * (n)) + 0x30)
+
 /* Maximum number of bin entries in the ARL for all switches */
 #define B53_ARLTBL_MAX_BIN_ENTRIES	4
 
 /* ARL Search Control Register (8 bit) */
 #define B53_ARL_SRCH_CTL		0x50
 #define B53_ARL_SRCH_CTL_25		0x20
+#define B53_ARL_SRCH_CTL_89		0x30
 #define   ARL_SRCH_VLID			BIT(0)
 #define   ARL_SRCH_STDN			BIT(7)
 
@@ -355,22 +364,42 @@
 #define B53_ARL_SRCH_ADDR		0x51
 #define B53_ARL_SRCH_ADDR_25		0x22
 #define B53_ARL_SRCH_ADDR_65		0x24
+#define B53_ARL_SRCH_ADDR_89		0x31
+#define B53_ARL_SRCH_ADDR_63XX		0x32
 #define  ARL_ADDR_MASK			GENMASK(14, 0)
 
 /* ARL Search MAC/VID Result (64 bit) */
 #define B53_ARL_SRCH_RSTL_0_MACVID	0x60
+#define B53_ARL_SRCH_RSLT_MACVID_89	0x33
+#define B53_ARL_SRCH_RSLT_MACVID_63XX	0x34
 
-/* Single register search result on 5325 */
+/* Single register search result on 5325/5365 */
 #define B53_ARL_SRCH_RSTL_0_MACVID_25	0x24
-/* Single register search result on 5365 */
-#define B53_ARL_SRCH_RSTL_0_MACVID_65	0x30
+#define   ARL_SRCH_RSLT_PORT_ID_S_25	48
+#define   ARL_SRCH_RSLT_PORT_ID_MASK_25	GENMASK_ULL(52, 48)
+#define   ARL_SRCH_RSLT_VID_S_25	53
+#define   ARL_SRCH_RSLT_VID_MASK_25	GENMASK_ULL(60, 53)
+
+/* BCM5325/5365 Search result extend register (8 bit) */
+#define B53_ARL_SRCH_RSLT_EXT_25	0x2c
+#define   ARL_SRCH_RSLT_EXT_MC_MII	BIT(2)
 
 /* ARL Search Data Result (32 bit) */
 #define B53_ARL_SRCH_RSTL_0		0x68
 
+/* BCM5389 ARL Search Data Result (16 bit) */
+#define B53_ARL_SRCH_RSLT_89		0x3b
+
 #define B53_ARL_SRCH_RSTL_MACVID(x)	(B53_ARL_SRCH_RSTL_0_MACVID + ((x) * 0x10))
 #define B53_ARL_SRCH_RSTL(x)		(B53_ARL_SRCH_RSTL_0 + ((x) * 0x10))
 
+/* 63XX ARL Search Data Result (16 bit) */
+#define B53_ARL_SRCH_RSLT_63XX		0x3c
+#define   ARL_SRST_PORT_ID_MASK_63XX	GENMASK(9, 1)
+#define   ARL_SRST_TC_MASK_63XX		GENMASK(13, 11)
+#define   ARL_SRST_AGE_63XX		BIT(14)
+#define   ARL_SRST_STATIC_63XX		BIT(15)
+
 /*************************************************************************
  * IEEE 802.1X Registers
  *************************************************************************/
diff --git a/drivers/net/dsa/xrs700x/xrs700x.c b/drivers/net/dsa/xrs700x/xrs700x.c
index 4dbcc49a9e52..0a05f4156ef4 100644
--- a/drivers/net/dsa/xrs700x/xrs700x.c
+++ b/drivers/net/dsa/xrs700x/xrs700x.c
@@ -566,6 +566,7 @@ static int xrs700x_hsr_join(struct dsa_switch *ds, int port,
 	struct xrs700x *priv = ds->priv;
 	struct net_device *user;
 	int ret, i, hsr_pair[2];
+	enum hsr_port_type type;
 	enum hsr_version ver;
 	bool fwd = false;
 
@@ -589,6 +590,16 @@ static int xrs700x_hsr_join(struct dsa_switch *ds, int port,
 		return -EOPNOTSUPP;
 	}
 
+	ret = hsr_get_port_type(hsr, dsa_to_port(ds, port)->user, &type);
+	if (ret)
+		return ret;
+
+	if (type != HSR_PT_SLAVE_A && type != HSR_PT_SLAVE_B) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only HSR slave ports can be offloaded");
+		return -EOPNOTSUPP;
+	}
+
 	dsa_hsr_foreach_port(dp, ds, hsr) {
 		if (dp->index != port) {
 			partner = dp;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index b4d5eda2e84f..9cbd8c154031 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -252,6 +252,12 @@ static int iavf_ptp_gettimex64(struct ptp_clock_info *info,
 	return iavf_read_phc_indirect(adapter, ts, sts);
 }
 
+static int iavf_ptp_settime64(struct ptp_clock_info *info,
+			      const struct timespec64 *ts)
+{
+	return -EOPNOTSUPP;
+}
+
 /**
  * iavf_ptp_cache_phc_time - Cache PHC time for performing timestamp extension
  * @adapter: private adapter structure
@@ -320,6 +326,7 @@ static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
 		 KBUILD_MODNAME, dev_name(dev));
 	ptp_info->owner = THIS_MODULE;
 	ptp_info->gettimex64 = iavf_ptp_gettimex64;
+	ptp_info->settime64 = iavf_ptp_settime64;
 	ptp_info->do_aux_work = iavf_ptp_do_aux_work;
 
 	clock = ptp_clock_register(ptp_info, dev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
index 3b7947a7a7ba..fcdda2401968 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
@@ -7,11 +7,16 @@
 
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include "stmmac_platform.h"
 
+struct sophgo_dwmac_data {
+	bool has_internal_rx_delay;
+};
+
 static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
 				    struct plat_stmmacenet_data *plat_dat,
 				    struct stmmac_resources *stmmac_res)
@@ -32,6 +37,7 @@ static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
 static int sophgo_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
+	const struct sophgo_dwmac_data *data;
 	struct stmmac_resources stmmac_res;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -50,11 +56,23 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	data = device_get_match_data(&pdev->dev);
+	if (data && data->has_internal_rx_delay) {
+		plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
+									  false, true);
+		if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
+			return -EINVAL;
+	}
+
 	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
 }
 
+static const struct sophgo_dwmac_data sg2042_dwmac_data = {
+	.has_internal_rx_delay = true,
+};
+
 static const struct of_device_id sophgo_dwmac_match[] = {
-	{ .compatible = "sophgo,sg2042-dwmac" },
+	{ .compatible = "sophgo,sg2042-dwmac", .data = &sg2042_dwmac_data },
 	{ .compatible = "sophgo,sg2044-dwmac" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7a375de2258c..abbd83f4c70f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5349,10 +5349,10 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 			len = 0;
 		}
 
+read_again:
 		if (count >= limit)
 			break;
 
-read_again:
 		buf1_len = 0;
 		entry = next_entry;
 		buf = &rx_q->buf_pool[entry];
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index 0b6f6228ae35..fd97879a8740 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -122,7 +122,8 @@ static int vlan_del_hw_rx_fltr(struct net_device *dev,
 
 	/* Extended Rx VLAN Filter Enable */
 	for (i = 0; i < hw->num_vlan; i++) {
-		if ((hw->vlan_filter[i] & VLAN_TAG_DATA_VID) == vid) {
+		if ((hw->vlan_filter[i] & VLAN_TAG_DATA_VEN) &&
+		    ((hw->vlan_filter[i] & VLAN_TAG_DATA_VID) == vid)) {
 			ret = vlan_write_filter(dev, hw, i, 0);
 
 			if (!ret)
diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
index bd7a47a903ac..10b796c2daee 100644
--- a/drivers/net/phy/adin1100.c
+++ b/drivers/net/phy/adin1100.c
@@ -201,7 +201,7 @@ static int adin_set_powerdown_mode(struct phy_device *phydev, bool en)
 		return ret;
 
 	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, ADIN_CRSM_STAT, ret,
-					 (ret & ADIN_CRSM_SFT_PD_RDY) == val,
+					 !!(ret & ADIN_CRSM_SFT_PD_RDY) == en,
 					 1000, 30000, true);
 }
 
diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
index bbbcc9736b00..569256152689 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -369,7 +369,7 @@ int aqr_firmware_load(struct phy_device *phydev)
 		 * assume that, and load a new image.
 		 */
 		ret = aqr_firmware_load_nvmem(phydev);
-		if (!ret)
+		if (ret == -EPROBE_DEFER || !ret)
 			return ret;
 
 		ret = aqr_firmware_load_fs(phydev);
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index ef0ef1570d39..48d43f60b8ff 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2625,7 +2625,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
 	.remove		= &vsc85xx_remove,
-	.probe		= &vsc8574_probe,
+	.probe		= &vsc8584_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
@@ -2648,12 +2648,12 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_aneg    = &vsc85xx_config_aneg,
 	.aneg_done	= &genphy_aneg_done,
 	.read_status	= &vsc85xx_read_status,
-	.handle_interrupt = vsc85xx_handle_interrupt,
+	.handle_interrupt = vsc8584_handle_interrupt,
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
 	.remove		= &vsc85xx_remove,
-	.probe		= &vsc8574_probe,
+	.probe		= &vsc8584_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 605ca20ae192..0c63e6ba2cb0 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -101,6 +101,49 @@ const char *phy_rate_matching_to_str(int rate_matching)
 }
 EXPORT_SYMBOL_GPL(phy_rate_matching_to_str);
 
+/**
+ * phy_fix_phy_mode_for_mac_delays - Convenience function for fixing PHY
+ * mode based on whether mac adds internal delay
+ *
+ * @interface: The current interface mode of the port
+ * @mac_txid: True if the mac adds internal tx delay
+ * @mac_rxid: True if the mac adds internal rx delay
+ *
+ * Return: fixed PHY mode, or PHY_INTERFACE_MODE_NA if the interface can
+ * not apply the internal delay
+ */
+phy_interface_t phy_fix_phy_mode_for_mac_delays(phy_interface_t interface,
+						bool mac_txid, bool mac_rxid)
+{
+	if (!phy_interface_mode_is_rgmii(interface))
+		return interface;
+
+	if (mac_txid && mac_rxid) {
+		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
+			return PHY_INTERFACE_MODE_RGMII;
+		return PHY_INTERFACE_MODE_NA;
+	}
+
+	if (mac_txid) {
+		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
+			return PHY_INTERFACE_MODE_RGMII_RXID;
+		if (interface == PHY_INTERFACE_MODE_RGMII_TXID)
+			return PHY_INTERFACE_MODE_RGMII;
+		return PHY_INTERFACE_MODE_NA;
+	}
+
+	if (mac_rxid) {
+		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
+			return PHY_INTERFACE_MODE_RGMII_TXID;
+		if (interface == PHY_INTERFACE_MODE_RGMII_RXID)
+			return PHY_INTERFACE_MODE_RGMII;
+		return PHY_INTERFACE_MODE_NA;
+	}
+
+	return interface;
+}
+EXPORT_SYMBOL_GPL(phy_fix_phy_mode_for_mac_delays);
+
 /**
  * phy_interface_num_ports - Return the number of links that can be carried by
  *			     a given MAC-PHY physical link. Returns 0 if this is
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 62ef87ecc558..54a3faf5e6f5 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -516,22 +516,11 @@ static int rtl8211c_config_init(struct phy_device *phydev)
 			    CTL1000_ENABLE_MASTER | CTL1000_AS_MASTER);
 }
 
-static int rtl8211f_config_init(struct phy_device *phydev)
+static int rtl8211f_config_rgmii_delay(struct phy_device *phydev)
 {
-	struct rtl821x_priv *priv = phydev->priv;
-	struct device *dev = &phydev->mdio.dev;
 	u16 val_txdly, val_rxdly;
 	int ret;
 
-	ret = phy_modify_paged_changed(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1,
-				       RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF,
-				       priv->phycr1);
-	if (ret < 0) {
-		dev_err(dev, "aldps mode  configuration failed: %pe\n",
-			ERR_PTR(ret));
-		return ret;
-	}
-
 	switch (phydev->interface) {
 	case PHY_INTERFACE_MODE_RGMII:
 		val_txdly = 0;
@@ -561,34 +550,58 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 				       RTL8211F_TXCR, RTL8211F_TX_DELAY,
 				       val_txdly);
 	if (ret < 0) {
-		dev_err(dev, "Failed to update the TX delay register\n");
+		phydev_err(phydev, "Failed to update the TX delay register: %pe\n",
+			   ERR_PTR(ret));
 		return ret;
 	} else if (ret) {
-		dev_dbg(dev,
-			"%s 2ns TX delay (and changing the value from pin-strapping RXD1 or the bootloader)\n",
-			str_enable_disable(val_txdly));
+		phydev_dbg(phydev,
+			   "%s 2ns TX delay (and changing the value from pin-strapping RXD1 or the bootloader)\n",
+			   str_enable_disable(val_txdly));
 	} else {
-		dev_dbg(dev,
-			"2ns TX delay was already %s (by pin-strapping RXD1 or bootloader configuration)\n",
-			str_enabled_disabled(val_txdly));
+		phydev_dbg(phydev,
+			   "2ns TX delay was already %s (by pin-strapping RXD1 or bootloader configuration)\n",
+			   str_enabled_disabled(val_txdly));
 	}
 
 	ret = phy_modify_paged_changed(phydev, RTL8211F_RGMII_PAGE,
 				       RTL8211F_RXCR, RTL8211F_RX_DELAY,
 				       val_rxdly);
 	if (ret < 0) {
-		dev_err(dev, "Failed to update the RX delay register\n");
+		phydev_err(phydev, "Failed to update the RX delay register: %pe\n",
+			   ERR_PTR(ret));
 		return ret;
 	} else if (ret) {
-		dev_dbg(dev,
-			"%s 2ns RX delay (and changing the value from pin-strapping RXD0 or the bootloader)\n",
-			str_enable_disable(val_rxdly));
+		phydev_dbg(phydev,
+			   "%s 2ns RX delay (and changing the value from pin-strapping RXD0 or the bootloader)\n",
+			   str_enable_disable(val_rxdly));
 	} else {
-		dev_dbg(dev,
-			"2ns RX delay was already %s (by pin-strapping RXD0 or bootloader configuration)\n",
-			str_enabled_disabled(val_rxdly));
+		phydev_dbg(phydev,
+			   "2ns RX delay was already %s (by pin-strapping RXD0 or bootloader configuration)\n",
+			   str_enabled_disabled(val_rxdly));
 	}
 
+	return 0;
+}
+
+static int rtl8211f_config_init(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+
+	ret = phy_modify_paged_changed(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1,
+				       RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF,
+				       priv->phycr1);
+	if (ret < 0) {
+		dev_err(dev, "aldps mode  configuration failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = rtl8211f_config_rgmii_delay(phydev);
+	if (ret)
+		return ret;
+
 	if (!priv->has_phycr2)
 		return 0;
 
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 6f78f1752cd6..9ae3595fb698 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -2493,8 +2492,9 @@ static int ath10k_init_hw_params(struct ath10k *ar)
 	return 0;
 }
 
-static bool ath10k_core_needs_recovery(struct ath10k *ar)
+static void ath10k_core_recovery_check_work(struct work_struct *work)
 {
+	struct ath10k *ar = container_of(work, struct ath10k, recovery_check_work);
 	long time_left;
 
 	/* Sometimes the recovery will fail and then the next all recovery fail,
@@ -2504,7 +2504,7 @@ static bool ath10k_core_needs_recovery(struct ath10k *ar)
 		ath10k_err(ar, "consecutive fail %d times, will shutdown driver!",
 			   atomic_read(&ar->fail_cont_count));
 		ar->state = ATH10K_STATE_WEDGED;
-		return false;
+		return;
 	}
 
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "total recovery count: %d", ++ar->recovery_count);
@@ -2518,27 +2518,24 @@ static bool ath10k_core_needs_recovery(struct ath10k *ar)
 							ATH10K_RECOVERY_TIMEOUT_HZ);
 		if (time_left) {
 			ath10k_warn(ar, "previous recovery succeeded, skip this!\n");
-			return false;
+			return;
 		}
 
 		/* Record the continuous recovery fail count when recovery failed. */
 		atomic_inc(&ar->fail_cont_count);
 
 		/* Avoid having multiple recoveries at the same time. */
-		return false;
+		return;
 	}
 
 	atomic_inc(&ar->pending_recovery);
-
-	return true;
+	queue_work(ar->workqueue, &ar->restart_work);
 }
 
 void ath10k_core_start_recovery(struct ath10k *ar)
 {
-	if (!ath10k_core_needs_recovery(ar))
-		return;
-
-	queue_work(ar->workqueue, &ar->restart_work);
+	/* Use workqueue_aux to avoid blocking recovery tracking */
+	queue_work(ar->workqueue_aux, &ar->recovery_check_work);
 }
 EXPORT_SYMBOL(ath10k_core_start_recovery);
 
@@ -3734,6 +3731,7 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
 
 	INIT_WORK(&ar->register_work, ath10k_core_register_work);
 	INIT_WORK(&ar->restart_work, ath10k_core_restart);
+	INIT_WORK(&ar->recovery_check_work, ath10k_core_recovery_check_work);
 	INIT_WORK(&ar->set_coverage_class_work,
 		  ath10k_core_set_coverage_class_work);
 
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 8c72ed386edb..859176fcb5a2 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -3,7 +3,6 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -1208,6 +1207,7 @@ struct ath10k {
 
 	struct work_struct register_work;
 	struct work_struct restart_work;
+	struct work_struct recovery_check_work;
 	struct work_struct bundle_tx_work;
 	struct work_struct tx_complete_work;
 
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 154ac7a70982..da6f7957a0ae 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -5428,6 +5427,7 @@ static void ath10k_stop(struct ieee80211_hw *hw, bool suspend)
 	cancel_work_sync(&ar->set_coverage_class_work);
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->restart_work);
+	cancel_work_sync(&ar->recovery_check_work);
 }
 
 static int ath10k_config_ps(struct ath10k *ar)
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 0e41b5a91d66..f142c17aa9aa 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2235,9 +2235,9 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 	arg->peer_nss = min(sta->deflink.rx_nss, max_nss);
 	arg->rx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.rx_highest);
 	arg->rx_mcs_set = __le16_to_cpu(vht_cap->vht_mcs.rx_mcs_map);
+	arg->rx_mcs_set = ath11k_peer_assoc_h_vht_limit(arg->rx_mcs_set, vht_mcs_mask);
 	arg->tx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.tx_highest);
-	arg->tx_mcs_set = ath11k_peer_assoc_h_vht_limit(
-		__le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map), vht_mcs_mask);
+	arg->tx_mcs_set = __le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map);
 
 	/* In IPQ8074 platform, VHT mcs rate 10 and 11 is enabled by default.
 	 * VHT mcs rate 10 and 11 is not supported in 11ac standard.
@@ -2522,10 +2522,10 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 			he_tx_mcs = v;
 		}
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
+		v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
 
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_160);
-		v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
 
 		arg->peer_he_mcs_count++;
@@ -2535,10 +2535,10 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 
 	default:
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
+		v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
 
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80);
-		v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
 
 		arg->peer_he_mcs_count++;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index d8655badd96d..7114eca8810d 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/module.h>
@@ -177,6 +177,19 @@ static inline void ath11k_pci_select_static_window(struct ath11k_pci *ab_pci)
 		  ab_pci->ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
 }
 
+static void ath11k_pci_restore_window(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+
+	spin_lock_bh(&ab_pci->window_lock);
+
+	iowrite32(ATH11K_PCI_WINDOW_ENABLE_BIT | ab_pci->register_window,
+		  ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
+	ioread32(ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
+
+	spin_unlock_bh(&ab_pci->window_lock);
+}
+
 static void ath11k_pci_soc_global_reset(struct ath11k_base *ab)
 {
 	u32 val, delay;
@@ -201,6 +214,11 @@ static void ath11k_pci_soc_global_reset(struct ath11k_base *ab)
 	val = ath11k_pcic_read32(ab, PCIE_SOC_GLOBAL_RESET);
 	if (val == 0xffffffff)
 		ath11k_warn(ab, "link down error during global reset\n");
+
+	/* Restore window register as its content is cleared during
+	 * hardware global reset, such that it aligns with host cache.
+	 */
+	ath11k_pci_restore_window(ab);
 }
 
 static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index e3b444333dee..110035dae8a6 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -2061,10 +2061,13 @@ int ath11k_wmi_send_peer_assoc_cmd(struct ath11k *ar,
 	cmd->peer_bw_rxnss_override |= param->peer_bw_rxnss_override;
 
 	if (param->vht_capable) {
-		mcs->rx_max_rate = param->rx_max_rate;
-		mcs->rx_mcs_set = param->rx_mcs_set;
-		mcs->tx_max_rate = param->tx_max_rate;
-		mcs->tx_mcs_set = param->tx_mcs_set;
+		/* firmware interprets mcs->tx_mcs_set field as peer's
+		 * RX capability
+		 */
+		mcs->tx_max_rate = param->rx_max_rate;
+		mcs->tx_mcs_set = param->rx_mcs_set;
+		mcs->rx_max_rate = param->tx_max_rate;
+		mcs->rx_mcs_set = param->tx_mcs_set;
 	}
 
 	/* HE Rates */
@@ -2088,8 +2091,11 @@ int ath11k_wmi_send_peer_assoc_cmd(struct ath11k *ar,
 				     FIELD_PREP(WMI_TLV_LEN,
 						sizeof(*he_mcs) - TLV_HDR_SIZE);
 
-		he_mcs->rx_mcs_set = param->peer_he_tx_mcs_set[i];
-		he_mcs->tx_mcs_set = param->peer_he_rx_mcs_set[i];
+		/* firmware interprets mcs->rx_mcs_set field as peer's
+		 * RX capability
+		 */
+		he_mcs->rx_mcs_set = param->peer_he_rx_mcs_set[i];
+		he_mcs->tx_mcs_set = param->peer_he_tx_mcs_set[i];
 		ptr += sizeof(*he_mcs);
 	}
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 9fcffaa2f383..6e9354297e71 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4133,8 +4133,10 @@ struct wmi_rate_set {
 struct wmi_vht_rate_set {
 	u32 tlv_header;
 	u32 rx_max_rate;
+	/* MCS at which the peer can transmit */
 	u32 rx_mcs_set;
 	u32 tx_max_rate;
+	/* MCS at which the peer can receive */
 	u32 tx_mcs_set;
 	u32 tx_max_mcs_nss;
 } __packed;
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 5d494c5cdc0d..cc352eef1939 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -1250,7 +1249,6 @@ void ath12k_fw_stats_reset(struct ath12k *ar)
 	spin_lock_bh(&ar->data_lock);
 	ath12k_fw_stats_free(&ar->fw_stats);
 	ar->fw_stats.num_vdev_recvd = 0;
-	ar->fw_stats.num_bcn_recvd = 0;
 	spin_unlock_bh(&ar->data_lock);
 }
 
@@ -2106,14 +2104,27 @@ static int ath12k_core_hw_group_create(struct ath12k_hw_group *ag)
 		ret = ath12k_core_soc_create(ab);
 		if (ret) {
 			mutex_unlock(&ab->core_lock);
-			ath12k_err(ab, "failed to create soc core: %d\n", ret);
-			return ret;
+			ath12k_err(ab, "failed to create soc %d core: %d\n", i, ret);
+			goto destroy;
 		}
 
 		mutex_unlock(&ab->core_lock);
 	}
 
 	return 0;
+
+destroy:
+	for (i--; i >= 0; i--) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		mutex_lock(&ab->core_lock);
+		ath12k_core_soc_destroy(ab);
+		mutex_unlock(&ab->core_lock);
+	}
+
+	return ret;
 }
 
 void ath12k_core_hw_group_set_mlo_capable(struct ath12k_hw_group *ag)
@@ -2188,7 +2199,7 @@ int ath12k_core_init(struct ath12k_base *ab)
 		if (ret) {
 			mutex_unlock(&ag->mutex);
 			ath12k_warn(ab, "unable to create hw group\n");
-			goto err_destroy_hw_group;
+			goto err_unassign_hw_group;
 		}
 	}
 
@@ -2196,8 +2207,7 @@ int ath12k_core_init(struct ath12k_base *ab)
 
 	return 0;
 
-err_destroy_hw_group:
-	ath12k_core_hw_group_destroy(ab->ag);
+err_unassign_hw_group:
 	ath12k_core_hw_group_unassign(ab);
 err_unregister_notifier:
 	ath12k_core_panic_notifier_unregister(ab);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 519f826f56c8..65b75cae1fb9 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -640,7 +640,6 @@ struct ath12k_fw_stats {
 	struct list_head vdevs;
 	struct list_head bcn;
 	u32 num_vdev_recvd;
-	u32 num_bcn_recvd;
 };
 
 struct ath12k_dbg_htt_stats {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 9048818984f1..0be911b4f316 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/ieee80211.h>
@@ -3690,6 +3690,48 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
 	return 0;
 }
 
+static int ath12k_dp_h_msdu_buffer_type(struct ath12k_base *ab,
+					struct list_head *list,
+					struct hal_reo_dest_ring *desc)
+{
+	struct ath12k_rx_desc_info *desc_info;
+	struct ath12k_skb_rxcb *rxcb;
+	struct sk_buff *msdu;
+	u64 desc_va;
+
+	desc_va = (u64)le32_to_cpu(desc->buf_va_hi) << 32 |
+		  le32_to_cpu(desc->buf_va_lo);
+	desc_info = (struct ath12k_rx_desc_info *)(uintptr_t)desc_va;
+	if (!desc_info) {
+		u32 cookie;
+
+		cookie = le32_get_bits(desc->buf_addr_info.info1,
+				       BUFFER_ADDR_INFO1_SW_COOKIE);
+		desc_info = ath12k_dp_get_rx_desc(ab, cookie);
+		if (!desc_info) {
+			ath12k_warn(ab, "Invalid cookie in manual descriptor retrieval: 0x%x\n",
+				    cookie);
+			return -EINVAL;
+		}
+	}
+
+	if (desc_info->magic != ATH12K_DP_RX_DESC_MAGIC) {
+		ath12k_warn(ab, "rx exception, magic check failed with value: %u\n",
+			    desc_info->magic);
+		return -EINVAL;
+	}
+
+	msdu = desc_info->skb;
+	desc_info->skb = NULL;
+	list_add_tail(&desc_info->list, list);
+	rxcb = ATH12K_SKB_RXCB(msdu);
+	dma_unmap_single(ab->dev, rxcb->paddr, msdu->len + skb_tailroom(msdu),
+			 DMA_FROM_DEVICE);
+	dev_kfree_skb_any(msdu);
+
+	return 0;
+}
+
 int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			     int budget)
 {
@@ -3734,6 +3776,26 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 		drop = false;
 		ab->device_stats.err_ring_pkts++;
 
+		hw_link_id = le32_get_bits(reo_desc->info0,
+					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
+		device_id = hw_links[hw_link_id].device_id;
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
+
+		/* Below case is added to handle data packet from un-associated clients.
+		 * As it is expected that AST lookup will fail for
+		 * un-associated station's data packets.
+		 */
+		if (le32_get_bits(reo_desc->info0, HAL_REO_DEST_RING_INFO0_BUFFER_TYPE) ==
+		    HAL_REO_DEST_RING_BUFFER_TYPE_MSDU) {
+			if (!ath12k_dp_h_msdu_buffer_type(partner_ab,
+							  &rx_desc_used_list[device_id],
+							  reo_desc)) {
+				num_buffs_reaped[device_id]++;
+				tot_n_bufs_reaped++;
+			}
+			goto next_desc;
+		}
+
 		ret = ath12k_hal_desc_reo_parse_err(ab, reo_desc, &paddr,
 						    &desc_bank);
 		if (ret) {
@@ -3742,11 +3804,6 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			continue;
 		}
 
-		hw_link_id = le32_get_bits(reo_desc->info0,
-					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
-		device_id = hw_links[hw_link_id].device_id;
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-
 		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
 						      hw_links[hw_link_id].pdev_idx);
 		ar = partner_ab->pdevs[pdev_id].ar;
@@ -3795,6 +3852,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			}
 		}
 
+next_desc:
 		if (tot_n_bufs_reaped >= quota) {
 			tot_n_bufs_reaped = quota;
 			goto exit;
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/hal_rx.c
index 48aa48c48606..805c31e4243d 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "debug.h"
@@ -320,7 +320,7 @@ int ath12k_hal_desc_reo_parse_err(struct ath12k_base *ab,
 {
 	enum hal_reo_dest_ring_push_reason push_reason;
 	enum hal_reo_dest_ring_error_code err_code;
-	u32 cookie, val;
+	u32 cookie;
 
 	push_reason = le32_get_bits(desc->info0,
 				    HAL_REO_DEST_RING_INFO0_PUSH_REASON);
@@ -335,12 +335,6 @@ int ath12k_hal_desc_reo_parse_err(struct ath12k_base *ab,
 		return -EINVAL;
 	}
 
-	val = le32_get_bits(desc->info0, HAL_REO_DEST_RING_INFO0_BUFFER_TYPE);
-	if (val != HAL_REO_DEST_RING_BUFFER_TYPE_LINK_DESC) {
-		ath12k_warn(ab, "expected buffer type link_desc");
-		return -EINVAL;
-	}
-
 	ath12k_hal_rx_reo_ent_paddr_get(ab, &desc->buf_addr_info, paddr, &cookie);
 	*desc_bank = u32_get_bits(cookie, DP_LINK_DESC_BANK_MASK);
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fd584633392c..6bdcf5ecb39e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2263,7 +2263,6 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	u16 *vht_mcs_mask;
-	u16 tx_mcs_map;
 	u8 ampdu_factor;
 	u8 max_nss, vht_mcs;
 	int i, vht_nss, nss_idx;
@@ -2354,10 +2353,10 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	arg->peer_nss = min(link_sta->rx_nss, max_nss);
 	arg->rx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.rx_highest);
 	arg->rx_mcs_set = __le16_to_cpu(vht_cap->vht_mcs.rx_mcs_map);
-	arg->tx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.tx_highest);
+	arg->rx_mcs_set = ath12k_peer_assoc_h_vht_limit(arg->rx_mcs_set, vht_mcs_mask);
 
-	tx_mcs_map = __le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map);
-	arg->tx_mcs_set = ath12k_peer_assoc_h_vht_limit(tx_mcs_map, vht_mcs_mask);
+	arg->tx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.tx_highest);
+	arg->tx_mcs_set = __le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map);
 
 	/* In QCN9274 platform, VHT MCS rate 10 and 11 is enabled by default.
 	 * VHT MCS rate 10 and 11 is not supported in 11ac standard.
@@ -2639,9 +2638,10 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	switch (link_sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
+		v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
 
-		v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
+		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_160);
 		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
 
 		arg->peer_he_mcs_count++;
@@ -2651,10 +2651,10 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 
 	default:
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
+		v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
 
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80);
-		v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
 
 		arg->peer_he_mcs_count++;
@@ -5073,7 +5073,8 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
 		ret = ath12k_mac_vdev_create(ar, arvif);
 		if (ret) {
 			ath12k_warn(ar->ab, "unable to create scan vdev %d\n", ret);
-			return -EINVAL;
+			ath12k_mac_unassign_link_vif(arvif);
+			return ret;
 		}
 	}
 
@@ -12846,6 +12847,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		if (ret) {
 			ath12k_warn(ar->ab, "unable to create scan vdev for roc: %d\n",
 				    ret);
+			ath12k_mac_unassign_link_vif(arvif);
 			return ret;
 		}
 	}
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index c729d5526c75..60b8f7361b7f 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/module.h>
@@ -218,6 +218,19 @@ static inline bool ath12k_pci_is_offset_within_mhi_region(u32 offset)
 	return (offset >= PCI_MHIREGLEN_REG && offset <= PCI_MHI_REGION_END);
 }
 
+static void ath12k_pci_restore_window(struct ath12k_base *ab)
+{
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
+
+	spin_lock_bh(&ab_pci->window_lock);
+
+	iowrite32(WINDOW_ENABLE_BIT | ab_pci->register_window,
+		  ab->mem + WINDOW_REG_ADDRESS);
+	ioread32(ab->mem + WINDOW_REG_ADDRESS);
+
+	spin_unlock_bh(&ab_pci->window_lock);
+}
+
 static void ath12k_pci_soc_global_reset(struct ath12k_base *ab)
 {
 	u32 val, delay;
@@ -242,6 +255,11 @@ static void ath12k_pci_soc_global_reset(struct ath12k_base *ab)
 	val = ath12k_pci_read32(ab, PCIE_SOC_GLOBAL_RESET);
 	if (val == 0xffffffff)
 		ath12k_warn(ab, "link down error during global reset\n");
+
+	/* Restore window register as its content is cleared during
+	 * hardware global reset, such that it aligns with host cache.
+	 */
+	ath12k_pci_restore_window(ab);
 }
 
 static void ath12k_pci_clear_dbg_registers(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 7c611a1fd6d0..9c03a890e6cf 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/elf.h>
@@ -3114,9 +3114,10 @@ static void ath12k_qmi_m3_free(struct ath12k_base *ab)
 	if (!m3_mem->vaddr)
 		return;
 
-	dma_free_coherent(ab->dev, m3_mem->size,
+	dma_free_coherent(ab->dev, m3_mem->total_size,
 			  m3_mem->vaddr, m3_mem->paddr);
 	m3_mem->vaddr = NULL;
+	m3_mem->total_size = 0;
 	m3_mem->size = 0;
 }
 
@@ -3152,7 +3153,7 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 
 	/* In recovery/resume cases, M3 buffer is not freed, try to reuse that */
 	if (m3_mem->vaddr) {
-		if (m3_mem->size >= m3_len)
+		if (m3_mem->total_size >= m3_len)
 			goto skip_m3_alloc;
 
 		/* Old buffer is too small, free and reallocate */
@@ -3164,11 +3165,13 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 					   GFP_KERNEL);
 	if (!m3_mem->vaddr) {
 		ath12k_err(ab, "failed to allocate memory for M3 with size %zu\n",
-			   fw->size);
+			   m3_len);
 		ret = -ENOMEM;
 		goto out;
 	}
 
+	m3_mem->total_size = m3_len;
+
 skip_m3_alloc:
 	memcpy(m3_mem->vaddr, m3_data, m3_len);
 	m3_mem->size = m3_len;
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index abdaade3b542..92962cd009ad 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_QMI_H
@@ -120,6 +120,9 @@ struct target_info {
 };
 
 struct m3_mem_region {
+	/* total memory allocated */
+	u32 total_size;
+	/* actual memory being used */
 	u32 size;
 	dma_addr_t paddr;
 	void *vaddr;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 29dadedefdd2..82d0773b0380 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -2362,10 +2362,13 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 	cmd->peer_bw_rxnss_override |= cpu_to_le32(arg->peer_bw_rxnss_override);
 
 	if (arg->vht_capable) {
-		mcs->rx_max_rate = cpu_to_le32(arg->rx_max_rate);
-		mcs->rx_mcs_set = cpu_to_le32(arg->rx_mcs_set);
-		mcs->tx_max_rate = cpu_to_le32(arg->tx_max_rate);
-		mcs->tx_mcs_set = cpu_to_le32(arg->tx_mcs_set);
+		/* Firmware interprets mcs->tx_mcs_set field as peer's
+		 * RX capability
+		 */
+		mcs->rx_max_rate = cpu_to_le32(arg->tx_max_rate);
+		mcs->rx_mcs_set = cpu_to_le32(arg->tx_mcs_set);
+		mcs->tx_max_rate = cpu_to_le32(arg->rx_max_rate);
+		mcs->tx_mcs_set = cpu_to_le32(arg->rx_mcs_set);
 	}
 
 	/* HE Rates */
@@ -8295,18 +8298,10 @@ static void ath12k_wmi_fw_stats_process(struct ath12k *ar,
 			ath12k_warn(ab, "empty beacon stats");
 			return;
 		}
-		/* Mark end until we reached the count of all started VDEVs
-		 * within the PDEV
-		 */
-		if (ar->num_started_vdevs)
-			is_end = ((++ar->fw_stats.num_bcn_recvd) ==
-				  ar->num_started_vdevs);
 
 		list_splice_tail_init(&stats->bcn,
 				      &ar->fw_stats.bcn);
-
-		if (is_end)
-			complete(&ar->fw_stats_done);
+		complete(&ar->fw_stats_done);
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index f3b0a6f57ec2..62d570a846da 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4218,8 +4218,10 @@ struct wmi_unit_test_cmd {
 struct ath12k_wmi_vht_rate_set_params {
 	__le32 tlv_header;
 	__le32 rx_max_rate;
+	/* MCS at which the peer can transmit */
 	__le32 rx_mcs_set;
 	__le32 tx_max_rate;
+	/* MCS at which the peer can receive */
 	__le32 tx_mcs_set;
 	__le32 tx_max_mcs_nss;
 } __packed;
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index dce9bd0bcaef..e8481626f194 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -758,6 +758,7 @@ static int ath12k_wow_arp_ns_offload(struct ath12k *ar, bool enable)
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to set arp ns offload vdev %i: enable %d, ret %d\n",
 				    arvif->vdev_id, enable, ret);
+			kfree(offload);
 			return ret;
 		}
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index ed0a0f76f1c5..de669e9ae55a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1632,6 +1632,10 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
 	u32 enabled = 0;
 
 	cmd = kzalloc(hcmd.len[0], GFP_KERNEL);
+	if (!cmd) {
+		IWL_DEBUG_WOWLAN(mld, "Failed to allocate proto offload cmd\n");
+		return -ENOMEM;
+	}
 
 #if IS_ENABLED(CONFIG_IPV6)
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 47c143e6a79a..eba26875aded 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1226,6 +1226,15 @@ static inline int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q,
 #define mt76_dereference(p, dev) \
 	rcu_dereference_protected(p, lockdep_is_held(&(dev)->mutex))
 
+static inline struct mt76_dev *mt76_wed_to_dev(struct mtk_wed_device *wed)
+{
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	if (wed->wlan.hif2)
+		return container_of(wed, struct mt76_dev, mmio.wed_hif2);
+#endif /* CONFIG_NET_MEDIATEK_SOC_WED */
+	return container_of(wed, struct mt76_dev, mmio.wed);
+}
+
 static inline struct mt76_wcid *
 __mt76_wcid_ptr(struct mt76_dev *dev, u16 idx)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 4064e193d4de..08ee2e861c4e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -874,8 +874,10 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
 						  WTBL_RESET_AND_SET, NULL,
 						  &wskb);
-	if (IS_ERR(wtbl_hdr))
+	if (IS_ERR(wtbl_hdr)) {
+		dev_kfree_skb(sskb);
 		return PTR_ERR(wtbl_hdr);
+	}
 
 	if (enable) {
 		mt76_connac_mcu_wtbl_generic_tlv(&dev->mt76, wskb, vif, sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 16db0f2082d1..fc3e6728fcfb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1662,6 +1662,31 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 			return err;
 	}
 
+	if (enable && vif->bss_conf.bssid_indicator) {
+		struct {
+			struct {
+				u8 bss_idx;
+				u8 pad[3];
+			} __packed hdr;
+			struct bss_info_uni_mbssid mbssid;
+		} mbssid_req = {
+			.hdr = {
+				.bss_idx = mvif->idx,
+			},
+			.mbssid = {
+				.tag = cpu_to_le16(UNI_BSS_INFO_11V_MBSSID),
+				.len = cpu_to_le16(sizeof(struct bss_info_uni_mbssid)),
+				.max_indicator = vif->bss_conf.bssid_indicator,
+				.mbss_idx =  vif->bss_conf.bssid_index,
+			},
+		};
+
+		err = mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE),
+					&mbssid_req, sizeof(mbssid_req), true);
+		if (err < 0)
+			return err;
+	}
+
 	return mt76_connac_mcu_uni_set_chctx(phy, mvif, ctx);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_add_bss);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index b0e053b15227..c7903972b1d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -240,6 +240,7 @@ int mt7925_init_mlo_caps(struct mt792x_phy *phy)
 {
 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
 	static const u8 ext_capa_sta[] = {
+		[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 		[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
 	};
 	static struct wiphy_iftype_ext_capab ext_capab[] = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index cd457be26523..10d68d241ba1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2621,6 +2621,25 @@ mt7925_mcu_bss_qos_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf
 	qos->qos = link_conf->qos;
 }
 
+static void
+mt7925_mcu_bss_mbssid_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
+			  bool enable)
+{
+	struct bss_info_uni_mbssid *mbssid;
+	struct tlv *tlv;
+
+	if (!enable && !link_conf->bssid_indicator)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_11V_MBSSID,
+				      sizeof(*mbssid));
+
+	mbssid = (struct bss_info_uni_mbssid *)tlv;
+	mbssid->max_indicator = link_conf->bssid_indicator;
+	mbssid->mbss_idx = link_conf->bssid_index;
+	mbssid->tx_bss_omac_idx = 0;
+}
+
 static void
 mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
 		      struct mt792x_phy *phy)
@@ -2787,8 +2806,10 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 		mt7925_mcu_bss_color_tlv(skb, link_conf, enable);
 	}
 
-	if (enable)
+	if (enable) {
 		mt7925_mcu_bss_rlm_tlv(skb, phy->mt76, link_conf, ctx);
+		mt7925_mcu_bss_mbssid_tlv(skb, link_conf, enable);
+	}
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index e3a703398b30..9cad572c34a3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -688,9 +688,12 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 	ieee80211_hw_set(hw, CONNECTION_MONITOR);
-	ieee80211_hw_set(hw, NO_VIRTUAL_MONITOR);
-	if (is_mt7921(&dev->mt76))
+	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
+	ieee80211_hw_set(hw, SUPPORTS_ONLY_HE_MULTI_BSSID);
+
+	if (is_mt7921(&dev->mt76)) {
 		ieee80211_hw_set(hw, CHANCTX_STA_CSA);
+	}
 
 	if (dev->pm.enable)
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 30e2ef1404b9..4662111ad064 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1894,7 +1894,7 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 		if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
 			continue;
 
-		ret = mt7996_run(&dev->phy);
+		ret = mt7996_run(phy);
 		if (ret)
 			goto out;
 	}
@@ -2338,6 +2338,8 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 	LIST_HEAD(list);
 	u32 changed;
 
+	mutex_lock(&dev->mt76.mutex);
+
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	list_splice_init(&dev->sta_rc_list, &list);
 
@@ -2370,6 +2372,8 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 	}
 
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+
+	mutex_unlock(&dev->mt76.mutex);
 }
 
 void mt7996_mac_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 4693d376e64e..1bd0214a01b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -90,9 +90,11 @@ static void mt7996_stop(struct ieee80211_hw *hw, bool suspend)
 {
 }
 
-static inline int get_free_idx(u32 mask, u8 start, u8 end)
+static inline int get_free_idx(u64 mask, u8 start, u8 end)
 {
-	return ffs(~mask & GENMASK(end, start));
+	if (~mask & GENMASK_ULL(end, start))
+		return __ffs64(~mask & GENMASK_ULL(end, start)) + 1;
+	return 0;
 }
 
 static int get_omac_idx(enum nl80211_iftype type, u64 mask)
@@ -311,12 +313,6 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	if (idx < 0)
 		return -ENOSPC;
 
-	if (!dev->mld_idx_mask) { /* first link in the group */
-		mvif->mld_group_idx = get_own_mld_idx(dev->mld_idx_mask, true);
-		mvif->mld_remap_idx = get_free_idx(dev->mld_remap_idx_mask,
-						   0, 15);
-	}
-
 	mld_idx = get_own_mld_idx(dev->mld_idx_mask, false);
 	if (mld_idx < 0)
 		return -ENOSPC;
@@ -334,10 +330,6 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 		return ret;
 
 	dev->mt76.vif_mask |= BIT_ULL(mlink->idx);
-	if (!dev->mld_idx_mask) {
-		dev->mld_idx_mask |= BIT_ULL(mvif->mld_group_idx);
-		dev->mld_remap_idx_mask |= BIT_ULL(mvif->mld_remap_idx);
-	}
 	dev->mld_idx_mask |= BIT_ULL(link->mld_idx);
 	phy->omac_mask |= BIT_ULL(mlink->omac_idx);
 
@@ -346,6 +338,7 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	INIT_LIST_HEAD(&msta_link->rc_list);
 	msta_link->wcid.idx = idx;
 	msta_link->wcid.link_id = link_conf->link_id;
+	msta_link->wcid.link_valid = ieee80211_vif_is_mld(vif);
 	msta_link->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mt76_wcid_init(&msta_link->wcid, band_idx);
 
@@ -379,7 +372,8 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 
 	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, NULL);
 
-	if (mvif->mt76.deflink_id == IEEE80211_LINK_UNSPECIFIED)
+	if (!mlink->wcid->offchannel &&
+	    mvif->mt76.deflink_id == IEEE80211_LINK_UNSPECIFIED)
 		mvif->mt76.deflink_id = link_conf->link_id;
 
 	return 0;
@@ -404,7 +398,8 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	if (mvif->mt76.deflink_id == link_conf->link_id) {
+	if (!mlink->wcid->offchannel &&
+	    mvif->mt76.deflink_id == link_conf->link_id) {
 		struct ieee80211_bss_conf *iter;
 		unsigned int link_id;
 
@@ -420,11 +415,6 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	dev->mt76.vif_mask &= ~BIT_ULL(mlink->idx);
 	dev->mld_idx_mask &= ~BIT_ULL(link->mld_idx);
 	phy->omac_mask &= ~BIT_ULL(mlink->omac_idx);
-	if (!(dev->mld_idx_mask & ~BIT_ULL(mvif->mld_group_idx))) {
-		/* last link */
-		dev->mld_idx_mask &= ~BIT_ULL(mvif->mld_group_idx);
-		dev->mld_remap_idx_mask &= ~BIT_ULL(mvif->mld_remap_idx);
-	}
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (!list_empty(&msta_link->wcid.poll_list))
@@ -650,8 +640,8 @@ mt7996_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       unsigned int link_id, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
-	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_vif_link *mlink = mt7996_vif_link(dev, vif, link_id);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_vif_link_info *link_info = &mvif->link_info[link_id];
 	static const u8 mq_to_aci[] = {
 		[IEEE80211_AC_VO] = 3,
 		[IEEE80211_AC_VI] = 2,
@@ -660,7 +650,7 @@ mt7996_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	};
 
 	/* firmware uses access class index */
-	mlink->queue_params[mq_to_aci[queue]] = *params;
+	link_info->queue_params[mq_to_aci[queue]] = *params;
 	/* no need to update right away, we'll get BSS_CHANGED_QOS */
 
 	return 0;
@@ -969,6 +959,7 @@ mt7996_mac_sta_init_link(struct mt7996_dev *dev,
 	msta_link->wcid.sta = 1;
 	msta_link->wcid.idx = idx;
 	msta_link->wcid.link_id = link_id;
+	msta_link->wcid.link_valid = !!sta->valid_links;
 	msta_link->wcid.def_wcid = &msta->deflink.wcid;
 
 	ewma_avg_signal_init(&msta_link->avg_ack_signal);
@@ -1151,12 +1142,15 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	unsigned long links = sta->valid_links;
 	struct ieee80211_link_sta *link_sta;
 	unsigned int link_id;
+	int err = 0;
+
+	mutex_lock(&dev->mt76.mutex);
 
 	for_each_sta_active_link(vif, sta, link_sta, link_id) {
 		struct ieee80211_bss_conf *link_conf;
 		struct mt7996_sta_link *msta_link;
 		struct mt7996_vif_link *link;
-		int i, err;
+		int i;
 
 		link_conf = link_conf_dereference_protected(vif, link_id);
 		if (!link_conf)
@@ -1176,12 +1170,12 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 						 link, msta_link,
 						 CONN_STATE_CONNECT, true);
 			if (err)
-				return err;
+				goto unlock;
 
 			err = mt7996_mcu_add_rate_ctrl(dev, msta_link->sta, vif,
 						       link_id, false);
 			if (err)
-				return err;
+				goto unlock;
 
 			msta_link->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 			break;
@@ -1190,28 +1184,30 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 						 link, msta_link,
 						 CONN_STATE_PORT_SECURE, false);
 			if (err)
-				return err;
+				goto unlock;
 			break;
 		case MT76_STA_EVENT_DISASSOC:
 			for (i = 0; i < ARRAY_SIZE(msta_link->twt.flow); i++)
 				mt7996_mac_twt_teardown_flow(dev, link,
 							     msta_link, i);
 
-			if (sta->mlo && links == BIT(link_id)) /* last link */
-				mt7996_mcu_teardown_mld_sta(dev, link,
-							    msta_link);
-			else
+			if (!sta->mlo)
 				mt7996_mcu_add_sta(dev, link_conf, link_sta,
 						   link, msta_link,
 						   CONN_STATE_DISCONNECT, false);
+			else if (sta->mlo && links == BIT(link_id)) /* last link */
+				mt7996_mcu_teardown_mld_sta(dev, link,
+							    msta_link);
 			msta_link->wcid.sta_disabled = 1;
 			msta_link->wcid.sta = 0;
 			links = links & ~BIT(link_id);
 			break;
 		}
 	}
+unlock:
+	mutex_unlock(&dev->mt76.mutex);
 
-	return 0;
+	return err;
 }
 
 static void
@@ -2179,7 +2175,42 @@ mt7996_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			u16 old_links, u16 new_links,
 			struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
 {
-	return 0;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	int ret = 0;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (!old_links) {
+		int idx;
+
+		idx = get_own_mld_idx(dev->mld_idx_mask, true);
+		if (idx < 0) {
+			ret = -ENOSPC;
+			goto out;
+		}
+		mvif->mld_group_idx = idx;
+		dev->mld_idx_mask |= BIT_ULL(mvif->mld_group_idx);
+
+		idx = get_free_idx(dev->mld_remap_idx_mask, 0, 15) - 1;
+		if (idx < 0) {
+			ret = -ENOSPC;
+			goto out;
+		}
+		mvif->mld_remap_idx = idx;
+		dev->mld_remap_idx_mask |= BIT_ULL(mvif->mld_remap_idx);
+	}
+
+	if (new_links)
+		goto out;
+
+	dev->mld_idx_mask &= ~BIT_ULL(mvif->mld_group_idx);
+	dev->mld_remap_idx_mask &= ~BIT_ULL(mvif->mld_remap_idx);
+
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
 }
 
 const struct ieee80211_ops mt7996_ops = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 0d688ec5a816..ff9b70292bfd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1010,7 +1010,6 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 	struct mt76_connac_bss_basic_tlv *bss;
 	u32 type = CONNECTION_INFRA_AP;
 	u16 sta_wlan_idx = wlan_idx;
-	struct ieee80211_sta *sta;
 	struct tlv *tlv;
 	int idx;
 
@@ -1021,14 +1020,18 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 		break;
 	case NL80211_IFTYPE_STATION:
 		if (enable) {
+			struct ieee80211_sta *sta;
+
 			rcu_read_lock();
-			sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
-			/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
+			sta = ieee80211_find_sta(vif, link_conf->bssid);
 			if (sta) {
-				struct mt76_wcid *wcid;
+				struct mt7996_sta *msta = (void *)sta->drv_priv;
+				struct mt7996_sta_link *msta_link;
+				int link_id = link_conf->link_id;
 
-				wcid = (struct mt76_wcid *)sta->drv_priv;
-				sta_wlan_idx = wcid->idx;
+				msta_link = rcu_dereference(msta->link[link_id]);
+				if (msta_link)
+					sta_wlan_idx = msta_link->wcid.idx;
 			}
 			rcu_read_unlock();
 		}
@@ -1045,8 +1048,6 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_BASIC, sizeof(*bss));
 
 	bss = (struct mt76_connac_bss_basic_tlv *)tlv;
-	bss->bcn_interval = cpu_to_le16(link_conf->beacon_int);
-	bss->dtim_period = link_conf->dtim_period;
 	bss->bmc_tx_wlan_idx = cpu_to_le16(wlan_idx);
 	bss->sta_idx = cpu_to_le16(sta_wlan_idx);
 	bss->conn_type = cpu_to_le32(type);
@@ -1066,10 +1067,10 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 
 	memcpy(bss->bssid, link_conf->bssid, ETH_ALEN);
 	bss->bcn_interval = cpu_to_le16(link_conf->beacon_int);
-	bss->dtim_period = vif->bss_conf.dtim_period;
+	bss->dtim_period = link_conf->dtim_period;
 	bss->phymode = mt76_connac_get_phy_mode(phy, vif,
 						chandef->chan->band, NULL);
-	bss->phymode_ext = mt76_connac_get_phy_mode_ext(phy, &vif->bss_conf,
+	bss->phymode_ext = mt76_connac_get_phy_mode_ext(phy, link_conf,
 							chandef->chan->band);
 
 	return 0;
@@ -1754,8 +1755,8 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	bf->ibf_nrow = tx_ant;
 
 	if (link_sta->eht_cap.has_eht || link_sta->he_cap.has_he)
-		bf->ibf_timeout = is_mt7996(&dev->mt76) ? MT7996_IBF_TIMEOUT :
-							  MT7992_IBF_TIMEOUT;
+		bf->ibf_timeout = is_mt7992(&dev->mt76) ? MT7992_IBF_TIMEOUT :
+							  MT7996_IBF_TIMEOUT;
 	else if (!ebf && link_sta->bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->ncol)
 		bf->ibf_timeout = MT7996_IBF_TIMEOUT_LEGACY;
 	else
@@ -3438,6 +3439,9 @@ int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 #define WMM_PARAM_SET		(WMM_AIFS_SET | WMM_CW_MIN_SET | \
 				 WMM_CW_MAX_SET | WMM_TXOP_SET)
 	struct mt7996_vif_link *link = mt7996_vif_conf_link(dev, vif, link_conf);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	unsigned int link_id = link_conf->link_id;
+	struct mt7996_vif_link_info *link_info = &mvif->link_info[link_id];
 	struct {
 		u8 bss_idx;
 		u8 __rsv[3];
@@ -3455,7 +3459,7 @@ int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	skb_put_data(skb, &hdr, sizeof(hdr));
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		struct ieee80211_tx_queue_params *q = &link->queue_params[ac];
+		struct ieee80211_tx_queue_params *q = &link_info->queue_params[ac];
 		struct edca *e;
 		struct tlv *tlv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 30b40f4a91be..b2af25aef762 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -562,6 +562,7 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 
 	wed->wlan.nbuf = MT7996_HW_TOKEN_SIZE;
 	wed->wlan.token_start = MT7996_TOKEN_SIZE - wed->wlan.nbuf;
+	wed->wlan.hif2 = hif2;
 
 	wed->wlan.amsdu_max_subframes = 8;
 	wed->wlan.amsdu_max_len = 1536;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 048d9a9898c6..5a415424291f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -246,16 +246,21 @@ struct mt7996_vif_link {
 	struct mt7996_sta_link msta_link;
 	struct mt7996_phy *phy;
 
-	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
 	struct cfg80211_bitrate_mask bitrate_mask;
 
 	u8 mld_idx;
 };
 
+struct mt7996_vif_link_info {
+	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+};
+
 struct mt7996_vif {
 	struct mt7996_vif_link deflink; /* must be first */
 	struct mt76_vif_data mt76;
 
+	struct mt7996_vif_link_info link_info[IEEE80211_MLD_MAX_NUM_LINKS];
+
 	u8 mld_group_idx;
 	u8 mld_remap_idx;
 };
@@ -715,7 +720,7 @@ void mt7996_memcpy_fromio(struct mt7996_dev *dev, void *buf, u32 offset,
 
 static inline u16 mt7996_rx_chainmask(struct mt7996_phy *phy)
 {
-	int max_nss = hweight8(phy->mt76->hw->wiphy->available_antennas_tx);
+	int max_nss = hweight16(phy->orig_antenna_mask);
 	int cur_nss = hweight8(phy->mt76->antenna_mask);
 	u16 tx_chainmask = phy->mt76->chainmask;
 
diff --git a/drivers/net/wireless/mediatek/mt76/wed.c b/drivers/net/wireless/mediatek/mt76/wed.c
index 63f69e152b1c..3ff547e0b250 100644
--- a/drivers/net/wireless/mediatek/mt76/wed.c
+++ b/drivers/net/wireless/mediatek/mt76/wed.c
@@ -8,7 +8,7 @@
 
 void mt76_wed_release_rx_buf(struct mtk_wed_device *wed)
 {
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+	struct mt76_dev *dev = mt76_wed_to_dev(wed);
 	int i;
 
 	for (i = 0; i < dev->rx_token_size; i++) {
@@ -31,8 +31,8 @@ EXPORT_SYMBOL_GPL(mt76_wed_release_rx_buf);
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 u32 mt76_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 {
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
 	struct mtk_wed_bm_desc *desc = wed->rx_buf_ring.desc;
+	struct mt76_dev *dev = mt76_wed_to_dev(wed);
 	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
 	struct mt76_txwi_cache *t = NULL;
 	int i;
@@ -80,7 +80,7 @@ EXPORT_SYMBOL_GPL(mt76_wed_init_rx_buf);
 
 int mt76_wed_offload_enable(struct mtk_wed_device *wed)
 {
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+	struct mt76_dev *dev = mt76_wed_to_dev(wed);
 
 	spin_lock_bh(&dev->token_lock);
 	dev->token_size = wed->wlan.token_start;
@@ -164,7 +164,7 @@ EXPORT_SYMBOL_GPL(mt76_wed_dma_setup);
 
 void mt76_wed_offload_disable(struct mtk_wed_device *wed)
 {
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+	struct mt76_dev *dev = mt76_wed_to_dev(wed);
 
 	spin_lock_bh(&dev->token_lock);
 	dev->token_size = dev->drv->token_size;
@@ -174,7 +174,7 @@ EXPORT_SYMBOL_GPL(mt76_wed_offload_disable);
 
 void mt76_wed_reset_complete(struct mtk_wed_device *wed)
 {
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+	struct mt76_dev *dev = mt76_wed_to_dev(wed);
 
 	complete(&dev->mmio.wed_reset_complete);
 }
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
index 2905baea6239..070c0431c482 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
@@ -1023,9 +1023,6 @@ static int rtl8180_init_rx_ring(struct ieee80211_hw *dev)
 		dma_addr_t *mapping;
 		entry = priv->rx_ring + priv->rx_ring_sz*i;
 		if (!skb) {
-			dma_free_coherent(&priv->pdev->dev,
-					  priv->rx_ring_sz * 32,
-					  priv->rx_ring, priv->rx_ring_dma);
 			wiphy_err(dev->wiphy, "Cannot allocate RX skb\n");
 			return -ENOMEM;
 		}
@@ -1037,9 +1034,7 @@ static int rtl8180_init_rx_ring(struct ieee80211_hw *dev)
 
 		if (dma_mapping_error(&priv->pdev->dev, *mapping)) {
 			kfree_skb(skb);
-			dma_free_coherent(&priv->pdev->dev,
-					  priv->rx_ring_sz * 32,
-					  priv->rx_ring, priv->rx_ring_dma);
+			priv->rx_buf[i] = NULL;
 			wiphy_err(dev->wiphy, "Cannot map DMA for RX skb\n");
 			return -ENOMEM;
 		}
@@ -1130,7 +1125,7 @@ static int rtl8180_start(struct ieee80211_hw *dev)
 
 	ret = rtl8180_init_rx_ring(dev);
 	if (ret)
-		return ret;
+		goto err_free_rings;
 
 	for (i = 0; i < (dev->queues + 1); i++)
 		if ((ret = rtl8180_init_tx_ring(dev, i, 16)))
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index 0c5c66401daa..7aa2da0cd63c 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -338,14 +338,16 @@ static void rtl8187_rx_cb(struct urb *urb)
 	spin_unlock_irqrestore(&priv->rx_queue.lock, f);
 	skb_put(skb, urb->actual_length);
 
-	if (unlikely(urb->status)) {
-		dev_kfree_skb_irq(skb);
-		return;
-	}
+	if (unlikely(urb->status))
+		goto free_skb;
 
 	if (!priv->is_rtl8187b) {
-		struct rtl8187_rx_hdr *hdr =
-			(typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
+		struct rtl8187_rx_hdr *hdr;
+
+		if (skb->len < sizeof(struct rtl8187_rx_hdr))
+			goto free_skb;
+
+		hdr = (typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
 		flags = le32_to_cpu(hdr->flags);
 		/* As with the RTL8187B below, the AGC is used to calculate
 		 * signal strength. In this case, the scaling
@@ -355,8 +357,12 @@ static void rtl8187_rx_cb(struct urb *urb)
 		rx_status.antenna = (hdr->signal >> 7) & 1;
 		rx_status.mactime = le64_to_cpu(hdr->mac_time);
 	} else {
-		struct rtl8187b_rx_hdr *hdr =
-			(typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
+		struct rtl8187b_rx_hdr *hdr;
+
+		if (skb->len < sizeof(struct rtl8187b_rx_hdr))
+			goto free_skb;
+
+		hdr = (typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
 		/* The Realtek datasheet for the RTL8187B shows that the RX
 		 * header contains the following quantities: signal quality,
 		 * RSSI, AGC, the received power in dB, and the measured SNR.
@@ -409,6 +415,11 @@ static void rtl8187_rx_cb(struct urb *urb)
 		skb_unlink(skb, &priv->rx_queue);
 		dev_kfree_skb_irq(skb);
 	}
+	return;
+
+free_skb:
+	dev_kfree_skb_irq(skb);
+	return;
 }
 
 static int rtl8187_init_urbs(struct ieee80211_hw *dev)
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 6cf89aee252e..512a46dd9d06 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -256,7 +256,7 @@ static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
 	int ret;
 
 	if (test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
-		return 0;
+		return -ENODEV;
 
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urb)
@@ -305,8 +305,9 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 		ret = rtw89_usb_write_port(rtwdev, txch, skb->data, skb->len,
 					   txcb);
 		if (ret) {
-			rtw89_err(rtwdev, "write port txch %d failed: %d\n",
-				  txch, ret);
+			if (ret != -ENODEV)
+				rtw89_err(rtwdev, "write port txch %d failed: %d\n",
+					  txch, ret);
 
 			skb_dequeue(&txcb->tx_ack_queue);
 			kfree(txcb);
@@ -410,8 +411,7 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
 
 		if (skb_queue_len(&rtwusb->rx_queue) >= RTW89_USB_MAX_RXQ_LEN) {
 			rtw89_warn(rtwdev, "rx_queue overflow\n");
-			dev_kfree_skb_any(rx_skb);
-			continue;
+			goto free_or_reuse;
 		}
 
 		memset(&desc_info, 0, sizeof(desc_info));
@@ -422,7 +422,7 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
 			rtw89_debug(rtwdev, RTW89_DBG_HCI,
 				    "failed to allocate RX skb of size %u\n",
 				    desc_info.pkt_size);
-			continue;
+			goto free_or_reuse;
 		}
 
 		pkt_offset = desc_info.offset + desc_info.rxd_len;
@@ -432,6 +432,7 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
 
 		rtw89_core_rx(rtwdev, &desc_info, skb);
 
+free_or_reuse:
 		if (skb_queue_len(&rtwusb->rx_free_queue) >= RTW89_USB_RX_SKB_NUM)
 			dev_kfree_skb_any(rx_skb);
 		else
diff --git a/drivers/net/wireless/st/cw1200/bh.c b/drivers/net/wireless/st/cw1200/bh.c
index 3b4ded2ac801..37232ee22037 100644
--- a/drivers/net/wireless/st/cw1200/bh.c
+++ b/drivers/net/wireless/st/cw1200/bh.c
@@ -317,10 +317,12 @@ static int cw1200_bh_rx_helper(struct cw1200_common *priv,
 
 	if (wsm_id & 0x0400) {
 		int rc = wsm_release_tx_buffer(priv, 1);
-		if (WARN_ON(rc < 0))
+		if (WARN_ON(rc < 0)) {
+			dev_kfree_skb(skb_rx);
 			return rc;
-		else if (rc > 0)
+		} else if (rc > 0) {
 			*tx = 1;
+		}
 	}
 
 	/* cw1200_wsm_rx takes care on SKB livetime */
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index a01178caf15b..8f3ccb317e4d 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -1122,7 +1122,7 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
 	if (ctrl->dhchap_ctxs) {
 		for (i = 0; i < ctrl_max_dhchaps(ctrl); i++)
 			nvme_auth_free_dhchap(&ctrl->dhchap_ctxs[i]);
-		kfree(ctrl->dhchap_ctxs);
+		kvfree(ctrl->dhchap_ctxs);
 	}
 	if (ctrl->host_key) {
 		nvme_auth_free_key(ctrl->host_key);
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 0edd639898a6..de16785a4869 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -625,6 +625,47 @@ const void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
 	return fdt_getprop(initial_boot_params, node, name, size);
 }
 
+const __be32 *__init of_flat_dt_get_addr_size_prop(unsigned long node,
+						   const char *name,
+						   int *entries)
+{
+	const __be32 *prop;
+	int len, elen = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+
+	prop = of_get_flat_dt_prop(node, name, &len);
+	if (!prop || len % elen) {
+		*entries = 0;
+		return NULL;
+	}
+
+	*entries = len / elen;
+	return prop;
+}
+
+bool __init of_flat_dt_get_addr_size(unsigned long node, const char *name,
+				     u64 *addr, u64 *size)
+{
+	const __be32 *prop;
+	int entries;
+
+	prop = of_flat_dt_get_addr_size_prop(node, name, &entries);
+	if (!prop || entries != 1)
+		return false;
+
+	of_flat_dt_read_addr_size(prop, 0, addr, size);
+	return true;
+}
+
+void __init of_flat_dt_read_addr_size(const __be32 *prop, int entry_index,
+				      u64 *addr, u64 *size)
+{
+	int entry_cells = dt_root_addr_cells + dt_root_size_cells;
+	prop += entry_cells * entry_index;
+
+	*addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
+	*size = dt_mem_next_cell(dt_root_size_cells, &prop);
+}
+
 /**
  * of_fdt_is_compatible - Return true if given node from the given blob has
  * compat in its compatible list
@@ -883,26 +924,18 @@ static void __init early_init_dt_check_kho(void)
 {
 	unsigned long node = chosen_node_offset;
 	u64 fdt_start, fdt_size, scratch_start, scratch_size;
-	const __be32 *p;
-	int l;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER) || (long)node < 0)
 		return;
 
-	p = of_get_flat_dt_prop(node, "linux,kho-fdt", &l);
-	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
+	if (!of_flat_dt_get_addr_size(node, "linux,kho-fdt",
+				      &fdt_start, &fdt_size))
 		return;
 
-	fdt_start = dt_mem_next_cell(dt_root_addr_cells, &p);
-	fdt_size = dt_mem_next_cell(dt_root_addr_cells, &p);
-
-	p = of_get_flat_dt_prop(node, "linux,kho-scratch", &l);
-	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
+	if (!of_flat_dt_get_addr_size(node, "linux,kho-scratch",
+				      &scratch_start, &scratch_size))
 		return;
 
-	scratch_start = dt_mem_next_cell(dt_root_addr_cells, &p);
-	scratch_size = dt_mem_next_cell(dt_root_addr_cells, &p);
-
 	kho_populate(fdt_start, fdt_size, scratch_start, scratch_size);
 }
 
diff --git a/drivers/of/of_kunit_helpers.c b/drivers/of/of_kunit_helpers.c
index 7b3ed5a382aa..f6ed1af8b62a 100644
--- a/drivers/of/of_kunit_helpers.c
+++ b/drivers/of/of_kunit_helpers.c
@@ -18,8 +18,9 @@
  */
 void of_root_kunit_skip(struct kunit *test)
 {
-	if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ACPI) && !of_root)
-		kunit_skip(test, "arm64+acpi doesn't populate a root node");
+	if ((IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_RISCV)) &&
+	    IS_ENABLED(CONFIG_ACPI) && !of_root)
+		kunit_skip(test, "arm64/riscv+acpi doesn't populate a root node");
 }
 EXPORT_SYMBOL_GPL(of_root_kunit_skip);
 
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 41748d083b93..0452151a7bcc 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -259,12 +259,11 @@ config PCIE_RCAR_EP
 
 config PCI_RCAR_GEN2
 	bool "Renesas R-Car Gen2 Internal PCI controller"
-	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on ARM
+	depends on (ARCH_RENESAS && ARM) || COMPILE_TEST
 	help
 	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
-	  There are 3 internal PCI controllers available with a single
-	  built-in EHCI/OHCI host controller present on each one.
+	  Each internal PCI controller contains a single built-in EHCI/OHCI
+	  host controller.
 
 config PCIE_ROCKCHIP
 	bool
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 21808a9e5158..ed0f6cf3df6b 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1338,6 +1338,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		break;
 	default:
 		dev_err(dev, "INVALID device type %d\n", mode);
+		ret = -EINVAL;
+		goto err_get_sync;
 	}
 
 	ks_pcie_enable_error_irq(ks_pcie);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index cc71a2d90cd4..509e08e58b69 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -95,7 +95,7 @@
 #define PORT_LANE_SKEW_INSERT_MASK	GENMASK(23, 0)
 
 #define PCIE_PORT_DEBUG0		0x728
-#define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
+#define PORT_LOGIC_LTSSM_STATE_MASK	0x3f
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
 #define PCIE_PORT_DEBUG1		0x72C
 #define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 31617772ad51..b05e8db575c3 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -730,8 +730,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (bar < BAR_0)
 		goto err_doorbell_cleanup;
 
-	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
-			  "pci-ep-test-doorbell", epf_test);
+	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
+				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
+				   "pci-ep-test-doorbell", epf_test);
 	if (ret) {
 		dev_err(&epf->dev,
 			"Failed to request doorbell IRQ: %d\n",
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 77a566aeae60..bca00d7ce3ce 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2489,6 +2489,11 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		bridge = dev_res->dev;
 		i = pci_resource_num(bridge, res);
 
+		if (res->parent) {
+			release_child_resources(res);
+			pci_release_resource(bridge, i);
+		}
+
 		restore_dev_resource(dev_res);
 
 		pci_claim_resource(bridge, i);
diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
index 5dca93cd325c..977d21d753a5 100644
--- a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
+++ b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
@@ -533,7 +533,7 @@ static struct phy *imx_hsio_xlate(struct device *dev,
 
 static int imx_hsio_probe(struct platform_device *pdev)
 {
-	int i;
+	int i, ret;
 	void __iomem *off;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -545,6 +545,9 @@ static int imx_hsio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv->dev = &pdev->dev;
 	priv->drvdata = of_device_get_match_data(dev);
+	ret = devm_mutex_init(dev, &priv->lock);
+	if (ret)
+		return ret;
 
 	/* Get HSIO configuration mode */
 	if (of_property_read_string(np, "fsl,hsio-cfg", &priv->hsio_cfg))
diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 47beb94cd424..dece07c94491 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -125,7 +125,6 @@ struct rcar_gen3_chan {
 	struct extcon_dev *extcon;
 	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
 	struct regulator *vbus;
-	struct reset_control *rstc;
 	struct work_struct work;
 	spinlock_t lock;	/* protects access to hardware and driver data structure. */
 	enum usb_dr_mode dr_mode;
@@ -699,21 +698,31 @@ static enum usb_dr_mode rcar_gen3_get_dr_mode(struct device_node *np)
 	return candidate;
 }
 
+static void rcar_gen3_reset_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
 {
 	struct device *dev = channel->dev;
+	struct reset_control *rstc;
 	int ret;
 	u32 val;
 
-	channel->rstc = devm_reset_control_array_get_shared(dev);
-	if (IS_ERR(channel->rstc))
-		return PTR_ERR(channel->rstc);
+	rstc = devm_reset_control_array_get_shared(dev);
+	if (IS_ERR(rstc))
+		return PTR_ERR(rstc);
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
 
-	ret = reset_control_deassert(channel->rstc);
+	ret = reset_control_deassert(rstc);
+	if (ret)
+		goto rpm_put;
+
+	ret = devm_add_action_or_reset(dev, rcar_gen3_reset_assert, rstc);
 	if (ret)
 		goto rpm_put;
 
@@ -860,7 +869,6 @@ static void rcar_gen3_phy_usb2_remove(struct platform_device *pdev)
 	if (channel->is_otg_channel)
 		device_remove_file(&pdev->dev, &dev_attr_role);
 
-	reset_control_assert(channel->rstc);
 	pm_runtime_disable(&pdev->dev);
 };
 
diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 17c6310f4b54..6d6928869395 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -21,78 +21,84 @@
 #define REF_CLOCK_100MHz		(100 * HZ_PER_MHZ)
 
 /* COMBO PHY REG */
-#define PHYREG6				0x14
-#define PHYREG6_PLL_DIV_MASK		GENMASK(7, 6)
-#define PHYREG6_PLL_DIV_SHIFT		6
-#define PHYREG6_PLL_DIV_2		1
-
-#define PHYREG7				0x18
-#define PHYREG7_TX_RTERM_MASK		GENMASK(7, 4)
-#define PHYREG7_TX_RTERM_SHIFT		4
-#define PHYREG7_TX_RTERM_50OHM		8
-#define PHYREG7_RX_RTERM_MASK		GENMASK(3, 0)
-#define PHYREG7_RX_RTERM_SHIFT		0
-#define PHYREG7_RX_RTERM_44OHM		15
-
-#define PHYREG8				0x1C
-#define PHYREG8_SSC_EN			BIT(4)
-
-#define PHYREG10			0x24
-#define PHYREG10_SSC_PCM_MASK		GENMASK(3, 0)
-#define PHYREG10_SSC_PCM_3500PPM	7
-
-#define PHYREG11			0x28
-#define PHYREG11_SU_TRIM_0_7		0xF0
-
-#define PHYREG12			0x2C
-#define PHYREG12_PLL_LPF_ADJ_VALUE	4
-
-#define PHYREG13			0x30
-#define PHYREG13_RESISTER_MASK		GENMASK(5, 4)
-#define PHYREG13_RESISTER_SHIFT		0x4
-#define PHYREG13_RESISTER_HIGH_Z	3
-#define PHYREG13_CKRCV_AMP0		BIT(7)
-
-#define PHYREG14			0x34
-#define PHYREG14_CKRCV_AMP1		BIT(0)
-
-#define PHYREG15			0x38
-#define PHYREG15_CTLE_EN		BIT(0)
-#define PHYREG15_SSC_CNT_MASK		GENMASK(7, 6)
-#define PHYREG15_SSC_CNT_SHIFT		6
-#define PHYREG15_SSC_CNT_VALUE		1
-
-#define PHYREG16			0x3C
-#define PHYREG16_SSC_CNT_VALUE		0x5f
-
-#define PHYREG17			0x40
-
-#define PHYREG18			0x44
-#define PHYREG18_PLL_LOOP		0x32
-
-#define PHYREG21			0x50
-#define PHYREG21_RX_SQUELCH_VAL		0x0D
-
-#define PHYREG27			0x6C
-#define PHYREG27_RX_TRIM_RK3588		0x4C
-
-#define PHYREG30			0x74
-
-#define PHYREG32			0x7C
-#define PHYREG32_SSC_MASK		GENMASK(7, 4)
-#define PHYREG32_SSC_DIR_MASK		GENMASK(5, 4)
-#define PHYREG32_SSC_DIR_SHIFT		4
-#define PHYREG32_SSC_UPWARD		0
-#define PHYREG32_SSC_DOWNWARD		1
-#define PHYREG32_SSC_OFFSET_MASK	GENMASK(7, 6)
-#define PHYREG32_SSC_OFFSET_SHIFT	6
-#define PHYREG32_SSC_OFFSET_500PPM	1
-
-#define PHYREG33			0x80
-#define PHYREG33_PLL_KVCO_MASK		GENMASK(4, 2)
-#define PHYREG33_PLL_KVCO_SHIFT		2
-#define PHYREG33_PLL_KVCO_VALUE		2
-#define PHYREG33_PLL_KVCO_VALUE_RK3576	4
+#define RK3568_PHYREG6				0x14
+#define RK3568_PHYREG6_PLL_DIV_MASK		GENMASK(7, 6)
+#define RK3568_PHYREG6_PLL_DIV_SHIFT		6
+#define RK3568_PHYREG6_PLL_DIV_2		1
+
+#define RK3568_PHYREG7				0x18
+#define RK3568_PHYREG7_TX_RTERM_MASK		GENMASK(7, 4)
+#define RK3568_PHYREG7_TX_RTERM_SHIFT		4
+#define RK3568_PHYREG7_TX_RTERM_50OHM		8
+#define RK3568_PHYREG7_RX_RTERM_MASK		GENMASK(3, 0)
+#define RK3568_PHYREG7_RX_RTERM_SHIFT		0
+#define RK3568_PHYREG7_RX_RTERM_44OHM		15
+
+#define RK3568_PHYREG8				0x1C
+#define RK3568_PHYREG8_SSC_EN			BIT(4)
+
+#define RK3568_PHYREG11				0x28
+#define RK3568_PHYREG11_SU_TRIM_0_7		0xF0
+
+#define RK3568_PHYREG12				0x2C
+#define RK3568_PHYREG12_PLL_LPF_ADJ_VALUE	4
+
+#define RK3568_PHYREG13				0x30
+#define RK3568_PHYREG13_RESISTER_MASK		GENMASK(5, 4)
+#define RK3568_PHYREG13_RESISTER_SHIFT		0x4
+#define RK3568_PHYREG13_RESISTER_HIGH_Z		3
+#define RK3568_PHYREG13_CKRCV_AMP0		BIT(7)
+
+#define RK3568_PHYREG14				0x34
+#define RK3568_PHYREG14_CKRCV_AMP1		BIT(0)
+
+#define RK3568_PHYREG15				0x38
+#define RK3568_PHYREG15_CTLE_EN			BIT(0)
+#define RK3568_PHYREG15_SSC_CNT_MASK		GENMASK(7, 6)
+#define RK3568_PHYREG15_SSC_CNT_SHIFT		6
+#define RK3568_PHYREG15_SSC_CNT_VALUE		1
+
+#define RK3568_PHYREG16				0x3C
+#define RK3568_PHYREG16_SSC_CNT_VALUE		0x5f
+
+#define RK3568_PHYREG18				0x44
+#define RK3568_PHYREG18_PLL_LOOP		0x32
+
+#define RK3568_PHYREG30				0x74
+#define RK3568_PHYREG30_GATE_TX_PCK_SEL         BIT(7)
+#define RK3568_PHYREG30_GATE_TX_PCK_DLY_PLL_OFF BIT(7)
+
+#define RK3568_PHYREG32				0x7C
+#define RK3568_PHYREG32_SSC_MASK		GENMASK(7, 4)
+#define RK3568_PHYREG32_SSC_DIR_MASK		GENMASK(5, 4)
+#define RK3568_PHYREG32_SSC_DIR_SHIFT		4
+#define RK3568_PHYREG32_SSC_UPWARD		0
+#define RK3568_PHYREG32_SSC_DOWNWARD		1
+#define RK3568_PHYREG32_SSC_OFFSET_MASK	GENMASK(7, 6)
+#define RK3568_PHYREG32_SSC_OFFSET_SHIFT	6
+#define RK3568_PHYREG32_SSC_OFFSET_500PPM	1
+
+#define RK3568_PHYREG33				0x80
+#define RK3568_PHYREG33_PLL_KVCO_MASK		GENMASK(4, 2)
+#define RK3568_PHYREG33_PLL_KVCO_SHIFT		2
+#define RK3568_PHYREG33_PLL_KVCO_VALUE		2
+#define RK3576_PHYREG33_PLL_KVCO_VALUE		4
+
+/* RK3588 COMBO PHY registers */
+#define RK3588_PHYREG27				0x6C
+#define RK3588_PHYREG27_RX_TRIM			0x4C
+
+/* RK3576 COMBO PHY registers */
+#define RK3576_PHYREG10				0x24
+#define RK3576_PHYREG10_SSC_PCM_MASK		GENMASK(3, 0)
+#define RK3576_PHYREG10_SSC_PCM_3500PPM		7
+
+#define RK3576_PHYREG17				0x40
+
+#define RK3576_PHYREG21				0x50
+#define RK3576_PHYREG21_RX_SQUELCH_VAL		0x0D
+
+#define RK3576_PHYREG30				0x74
 
 struct rockchip_combphy_priv;
 
@@ -407,9 +413,8 @@ static int rk3562_combphy_cfg(struct rockchip_combphy_priv *priv)
 	switch (priv->type) {
 	case PHY_TYPE_PCIE:
 		/* Set SSC downward spread spectrum */
-		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
-					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
-					 PHYREG32);
+		val = RK3568_PHYREG32_SSC_DOWNWARD << RK3568_PHYREG32_SSC_DIR_SHIFT;
+		rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val, RK3568_PHYREG32);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
@@ -418,29 +423,30 @@ static int rk3562_combphy_cfg(struct rockchip_combphy_priv *priv)
 		break;
 	case PHY_TYPE_USB3:
 		/* Set SSC downward spread spectrum */
-		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
-					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
-					 PHYREG32);
+		val = RK3568_PHYREG32_SSC_DOWNWARD << RK3568_PHYREG32_SSC_DIR_SHIFT;
+		rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val,
+					 RK3568_PHYREG32);
 
 		/* Enable adaptive CTLE for USB3.0 Rx */
-		rockchip_combphy_updatel(priv, PHYREG15_CTLE_EN,
-					 PHYREG15_CTLE_EN, PHYREG15);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG15_CTLE_EN,
+					 RK3568_PHYREG15_CTLE_EN, RK3568_PHYREG15);
 
 		/* Set PLL KVCO fine tuning signals */
-		rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK, BIT(3), PHYREG33);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK,
+					 BIT(3), RK3568_PHYREG33);
 
 		/* Set PLL LPF R1 to su_trim[10:7]=1001 */
-		writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+		writel(RK3568_PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + RK3568_PHYREG12);
 
 		/* Set PLL input clock divider 1/2 */
-		val = FIELD_PREP(PHYREG6_PLL_DIV_MASK, PHYREG6_PLL_DIV_2);
-		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK, val, PHYREG6);
+		val = FIELD_PREP(RK3568_PHYREG6_PLL_DIV_MASK, RK3568_PHYREG6_PLL_DIV_2);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG6_PLL_DIV_MASK, val, RK3568_PHYREG6);
 
 		/* Set PLL loop divider */
-		writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
+		writel(RK3568_PHYREG18_PLL_LOOP, priv->mmio + RK3568_PHYREG18);
 
 		/* Set PLL KVCO to min and set PLL charge pump current to max */
-		writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+		writel(RK3568_PHYREG11_SU_TRIM_0_7, priv->mmio + RK3568_PHYREG11);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_usb, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
@@ -458,11 +464,12 @@ static int rk3562_combphy_cfg(struct rockchip_combphy_priv *priv)
 	case REF_CLOCK_24MHz:
 		if (priv->type == PHY_TYPE_USB3) {
 			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz */
-			val = FIELD_PREP(PHYREG15_SSC_CNT_MASK, PHYREG15_SSC_CNT_VALUE);
-			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
-						 val, PHYREG15);
+			val = FIELD_PREP(RK3568_PHYREG15_SSC_CNT_MASK,
+					 RK3568_PHYREG15_SSC_CNT_VALUE);
+			rockchip_combphy_updatel(priv, RK3568_PHYREG15_SSC_CNT_MASK,
+						 val, RK3568_PHYREG15);
 
-			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+			writel(RK3568_PHYREG16_SSC_CNT_VALUE, priv->mmio + RK3568_PHYREG16);
 		}
 		break;
 	case REF_CLOCK_25MHz:
@@ -471,20 +478,25 @@ static int rk3562_combphy_cfg(struct rockchip_combphy_priv *priv)
 	case REF_CLOCK_100MHz:
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
 		if (priv->type == PHY_TYPE_PCIE) {
+			/* Gate_tx_pck_sel length select for L1ss support */
+			rockchip_combphy_updatel(priv, RK3568_PHYREG30_GATE_TX_PCK_SEL,
+						 RK3568_PHYREG30_GATE_TX_PCK_DLY_PLL_OFF,
+						 RK3568_PHYREG30);
 			/* PLL KVCO tuning fine */
-			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE);
-			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-						 val, PHYREG33);
+			val = FIELD_PREP(RK3568_PHYREG33_PLL_KVCO_MASK,
+					 RK3568_PHYREG33_PLL_KVCO_VALUE);
+			rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK,
+						 val, RK3568_PHYREG33);
 
 			/* Enable controlling random jitter, aka RMJ */
-			writel(0x4, priv->mmio + PHYREG12);
+			writel(0x4, priv->mmio + RK3568_PHYREG12);
 
-			val = PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
-						 val, PHYREG6);
+			val = RK3568_PHYREG6_PLL_DIV_2 << RK3568_PHYREG6_PLL_DIV_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG6_PLL_DIV_MASK,
+						 val, RK3568_PHYREG6);
 
-			writel(0x32, priv->mmio + PHYREG18);
-			writel(0xf0, priv->mmio + PHYREG11);
+			writel(0x32, priv->mmio + RK3568_PHYREG18);
+			writel(0xf0, priv->mmio + RK3568_PHYREG11);
 		}
 		break;
 	default:
@@ -495,20 +507,21 @@ static int rk3562_combphy_cfg(struct rockchip_combphy_priv *priv)
 	if (priv->ext_refclk) {
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
 		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
-			val = PHYREG13_RESISTER_HIGH_Z << PHYREG13_RESISTER_SHIFT;
-			val |= PHYREG13_CKRCV_AMP0;
-			rockchip_combphy_updatel(priv, PHYREG13_RESISTER_MASK, val, PHYREG13);
-
-			val = readl(priv->mmio + PHYREG14);
-			val |= PHYREG14_CKRCV_AMP1;
-			writel(val, priv->mmio + PHYREG14);
+			val = RK3568_PHYREG13_RESISTER_HIGH_Z << RK3568_PHYREG13_RESISTER_SHIFT;
+			val |= RK3568_PHYREG13_CKRCV_AMP0;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG13_RESISTER_MASK, val,
+						 RK3568_PHYREG13);
+
+			val = readl(priv->mmio + RK3568_PHYREG14);
+			val |= RK3568_PHYREG14_CKRCV_AMP1;
+			writel(val, priv->mmio + RK3568_PHYREG14);
 		}
 	}
 
 	if (priv->enable_ssc) {
-		val = readl(priv->mmio + PHYREG8);
-		val |= PHYREG8_SSC_EN;
-		writel(val, priv->mmio + PHYREG8);
+		val = readl(priv->mmio + RK3568_PHYREG8);
+		val |= RK3568_PHYREG8_SSC_EN;
+		writel(val, priv->mmio + RK3568_PHYREG8);
 	}
 
 	return 0;
@@ -555,9 +568,9 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 	switch (priv->type) {
 	case PHY_TYPE_PCIE:
 		/* Set SSC downward spread spectrum. */
-		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
-					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
-					 PHYREG32);
+		val = RK3568_PHYREG32_SSC_DOWNWARD << RK3568_PHYREG32_SSC_DIR_SHIFT;
+
+		rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val, RK3568_PHYREG32);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
@@ -567,30 +580,28 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 
 	case PHY_TYPE_USB3:
 		/* Set SSC downward spread spectrum. */
-		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
-					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
-					 PHYREG32);
+		val = RK3568_PHYREG32_SSC_DOWNWARD << RK3568_PHYREG32_SSC_DIR_SHIFT,
+		rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val, RK3568_PHYREG32);
 
 		/* Enable adaptive CTLE for USB3.0 Rx. */
-		val = readl(priv->mmio + PHYREG15);
-		val |= PHYREG15_CTLE_EN;
-		writel(val, priv->mmio + PHYREG15);
+		val = readl(priv->mmio + RK3568_PHYREG15);
+		val |= RK3568_PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + RK3568_PHYREG15);
 
 		/* Set PLL KVCO fine tuning signals. */
-		rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-					 PHYREG33_PLL_KVCO_VALUE << PHYREG33_PLL_KVCO_SHIFT,
-					 PHYREG33);
+		val = RK3568_PHYREG33_PLL_KVCO_VALUE << RK3568_PHYREG33_PLL_KVCO_SHIFT;
+		rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK, val, RK3568_PHYREG33);
 
 		/* Enable controlling random jitter. */
-		writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+		writel(RK3568_PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + RK3568_PHYREG12);
 
 		/* Set PLL input clock divider 1/2. */
-		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
-					 PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT,
-					 PHYREG6);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG6_PLL_DIV_MASK,
+					 RK3568_PHYREG6_PLL_DIV_2 << RK3568_PHYREG6_PLL_DIV_SHIFT,
+					 RK3568_PHYREG6);
 
-		writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
-		writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+		writel(RK3568_PHYREG18_PLL_LOOP, priv->mmio + RK3568_PHYREG18);
+		writel(RK3568_PHYREG11_SU_TRIM_0_7, priv->mmio + RK3568_PHYREG11);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_usb, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
@@ -608,16 +619,16 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 
 	case PHY_TYPE_SATA:
 		/* Enable adaptive CTLE for SATA Rx. */
-		val = readl(priv->mmio + PHYREG15);
-		val |= PHYREG15_CTLE_EN;
-		writel(val, priv->mmio + PHYREG15);
+		val = readl(priv->mmio + RK3568_PHYREG15);
+		val |= RK3568_PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + RK3568_PHYREG15);
 		/*
 		 * Set tx_rterm=50ohm and rx_rterm=44ohm for SATA.
 		 * 0: 60ohm, 8: 50ohm 15: 44ohm (by step abort 1ohm)
 		 */
-		val = PHYREG7_TX_RTERM_50OHM << PHYREG7_TX_RTERM_SHIFT;
-		val |= PHYREG7_RX_RTERM_44OHM << PHYREG7_RX_RTERM_SHIFT;
-		writel(val, priv->mmio + PHYREG7);
+		val = RK3568_PHYREG7_TX_RTERM_50OHM << RK3568_PHYREG7_TX_RTERM_SHIFT;
+		val |= RK3568_PHYREG7_RX_RTERM_44OHM << RK3568_PHYREG7_RX_RTERM_SHIFT;
+		writel(val, priv->mmio + RK3568_PHYREG7);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_sata, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_sata, true);
@@ -652,11 +663,11 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 	case REF_CLOCK_24MHz:
 		if (priv->type == PHY_TYPE_USB3 || priv->type == PHY_TYPE_SATA) {
 			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz. */
-			val = PHYREG15_SSC_CNT_VALUE << PHYREG15_SSC_CNT_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
-						 val, PHYREG15);
+			val = RK3568_PHYREG15_SSC_CNT_VALUE << RK3568_PHYREG15_SSC_CNT_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG15_SSC_CNT_MASK,
+						 val, RK3568_PHYREG15);
 
-			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+			writel(RK3568_PHYREG16_SSC_CNT_VALUE, priv->mmio + RK3568_PHYREG16);
 		}
 		break;
 
@@ -668,24 +679,26 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
 		if (priv->type == PHY_TYPE_PCIE) {
 			/* PLL KVCO  fine tuning. */
-			val = PHYREG33_PLL_KVCO_VALUE << PHYREG33_PLL_KVCO_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-						 val, PHYREG33);
+			val = RK3568_PHYREG33_PLL_KVCO_VALUE << RK3568_PHYREG33_PLL_KVCO_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK,
+						 val, RK3568_PHYREG33);
 
 			/* Enable controlling random jitter. */
-			writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+			writel(RK3568_PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + RK3568_PHYREG12);
 
-			val = PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
-						 val, PHYREG6);
+			val = RK3568_PHYREG6_PLL_DIV_2 << RK3568_PHYREG6_PLL_DIV_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG6_PLL_DIV_MASK,
+						 val, RK3568_PHYREG6);
 
-			writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
-			writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+			writel(RK3568_PHYREG18_PLL_LOOP, priv->mmio + RK3568_PHYREG18);
+			writel(RK3568_PHYREG11_SU_TRIM_0_7, priv->mmio + RK3568_PHYREG11);
 		} else if (priv->type == PHY_TYPE_SATA) {
 			/* downward spread spectrum +500ppm */
-			val = PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT;
-			val |= PHYREG32_SSC_OFFSET_500PPM << PHYREG32_SSC_OFFSET_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
+			val = RK3568_PHYREG32_SSC_DOWNWARD << RK3568_PHYREG32_SSC_DIR_SHIFT;
+			val |= RK3568_PHYREG32_SSC_OFFSET_500PPM <<
+			       RK3568_PHYREG32_SSC_OFFSET_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val,
+						 RK3568_PHYREG32);
 		}
 		break;
 
@@ -697,20 +710,21 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 	if (priv->ext_refclk) {
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
 		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
-			val = PHYREG13_RESISTER_HIGH_Z << PHYREG13_RESISTER_SHIFT;
-			val |= PHYREG13_CKRCV_AMP0;
-			rockchip_combphy_updatel(priv, PHYREG13_RESISTER_MASK, val, PHYREG13);
-
-			val = readl(priv->mmio + PHYREG14);
-			val |= PHYREG14_CKRCV_AMP1;
-			writel(val, priv->mmio + PHYREG14);
+			val = RK3568_PHYREG13_RESISTER_HIGH_Z << RK3568_PHYREG13_RESISTER_SHIFT;
+			val |= RK3568_PHYREG13_CKRCV_AMP0;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG13_RESISTER_MASK, val,
+						 RK3568_PHYREG13);
+
+			val = readl(priv->mmio + RK3568_PHYREG14);
+			val |= RK3568_PHYREG14_CKRCV_AMP1;
+			writel(val, priv->mmio + RK3568_PHYREG14);
 		}
 	}
 
 	if (priv->enable_ssc) {
-		val = readl(priv->mmio + PHYREG8);
-		val |= PHYREG8_SSC_EN;
-		writel(val, priv->mmio + PHYREG8);
+		val = readl(priv->mmio + RK3568_PHYREG8);
+		val |= RK3568_PHYREG8_SSC_EN;
+		writel(val, priv->mmio + RK3568_PHYREG8);
 	}
 
 	return 0;
@@ -771,8 +785,8 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 	switch (priv->type) {
 	case PHY_TYPE_PCIE:
 		/* Set SSC downward spread spectrum */
-		val = FIELD_PREP(PHYREG32_SSC_MASK, PHYREG32_SSC_DOWNWARD);
-		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
+		val = FIELD_PREP(RK3568_PHYREG32_SSC_MASK, RK3568_PHYREG32_SSC_DOWNWARD);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val, RK3568_PHYREG32);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
@@ -782,32 +796,33 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 
 	case PHY_TYPE_USB3:
 		/* Set SSC downward spread spectrum */
-		val = FIELD_PREP(PHYREG32_SSC_MASK, PHYREG32_SSC_DOWNWARD);
-		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
+		val = FIELD_PREP(RK3568_PHYREG32_SSC_MASK, RK3568_PHYREG32_SSC_DOWNWARD);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val, RK3568_PHYREG32);
 
 		/* Enable adaptive CTLE for USB3.0 Rx */
-		val = readl(priv->mmio + PHYREG15);
-		val |= PHYREG15_CTLE_EN;
-		writel(val, priv->mmio + PHYREG15);
+		val = readl(priv->mmio + RK3568_PHYREG15);
+		val |= RK3568_PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + RK3568_PHYREG15);
 
 		/* Set PLL KVCO fine tuning signals */
-		rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK, BIT(3), PHYREG33);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK, BIT(3),
+					 RK3568_PHYREG33);
 
 		/* Set PLL LPF R1 to su_trim[10:7]=1001 */
-		writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+		writel(RK3568_PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + RK3568_PHYREG12);
 
 		/* Set PLL input clock divider 1/2 */
-		val = FIELD_PREP(PHYREG6_PLL_DIV_MASK, PHYREG6_PLL_DIV_2);
-		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK, val, PHYREG6);
+		val = FIELD_PREP(RK3568_PHYREG6_PLL_DIV_MASK, RK3568_PHYREG6_PLL_DIV_2);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG6_PLL_DIV_MASK, val, RK3568_PHYREG6);
 
 		/* Set PLL loop divider */
-		writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
+		writel(RK3568_PHYREG18_PLL_LOOP, priv->mmio + RK3568_PHYREG18);
 
 		/* Set PLL KVCO to min and set PLL charge pump current to max */
-		writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+		writel(RK3568_PHYREG11_SU_TRIM_0_7, priv->mmio + RK3568_PHYREG11);
 
 		/* Set Rx squelch input filler bandwidth */
-		writel(PHYREG21_RX_SQUELCH_VAL, priv->mmio + PHYREG21);
+		writel(RK3576_PHYREG21_RX_SQUELCH_VAL, priv->mmio + RK3576_PHYREG21);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
@@ -816,14 +831,14 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 
 	case PHY_TYPE_SATA:
 		/* Enable adaptive CTLE for SATA Rx */
-		val = readl(priv->mmio + PHYREG15);
-		val |= PHYREG15_CTLE_EN;
-		writel(val, priv->mmio + PHYREG15);
+		val = readl(priv->mmio + RK3568_PHYREG15);
+		val |= RK3568_PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + RK3568_PHYREG15);
 
 		/* Set tx_rterm = 50 ohm and rx_rterm = 43.5 ohm */
-		val = PHYREG7_TX_RTERM_50OHM << PHYREG7_TX_RTERM_SHIFT;
-		val |= PHYREG7_RX_RTERM_44OHM << PHYREG7_RX_RTERM_SHIFT;
-		writel(val, priv->mmio + PHYREG7);
+		val = RK3568_PHYREG7_TX_RTERM_50OHM << RK3568_PHYREG7_TX_RTERM_SHIFT;
+		val |= RK3568_PHYREG7_RX_RTERM_44OHM << RK3568_PHYREG7_RX_RTERM_SHIFT;
+		writel(val, priv->mmio + RK3568_PHYREG7);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_sata, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_sata, true);
@@ -845,19 +860,21 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_24m, true);
 		if (priv->type == PHY_TYPE_USB3 || priv->type == PHY_TYPE_SATA) {
 			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz */
-			val = FIELD_PREP(PHYREG15_SSC_CNT_MASK, PHYREG15_SSC_CNT_VALUE);
-			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
-						 val, PHYREG15);
+			val = FIELD_PREP(RK3568_PHYREG15_SSC_CNT_MASK,
+					 RK3568_PHYREG15_SSC_CNT_VALUE);
+			rockchip_combphy_updatel(priv, RK3568_PHYREG15_SSC_CNT_MASK,
+						 val, RK3568_PHYREG15);
 
-			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+			writel(RK3568_PHYREG16_SSC_CNT_VALUE, priv->mmio + RK3568_PHYREG16);
 		} else if (priv->type == PHY_TYPE_PCIE) {
 			/* PLL KVCO tuning fine */
-			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE_RK3576);
-			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-						 val, PHYREG33);
+			val = FIELD_PREP(RK3568_PHYREG33_PLL_KVCO_MASK,
+					 RK3576_PHYREG33_PLL_KVCO_VALUE);
+			rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK,
+						 val, RK3568_PHYREG33);
 
 			/* Set up rx_pck invert and rx msb to disable */
-			writel(0x00, priv->mmio + PHYREG27);
+			writel(0x00, priv->mmio + RK3588_PHYREG27);
 
 			/*
 			 * Set up SU adjust signal:
@@ -865,11 +882,11 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 			 * su_trim[15:8],  PLL LPF R1 adujst bits[9:7]=3'b011
 			 * su_trim[31:24], CKDRV adjust
 			 */
-			writel(0x90, priv->mmio + PHYREG11);
-			writel(0x02, priv->mmio + PHYREG12);
-			writel(0x57, priv->mmio + PHYREG14);
+			writel(0x90, priv->mmio + RK3568_PHYREG11);
+			writel(0x02, priv->mmio + RK3568_PHYREG12);
+			writel(0x57, priv->mmio + RK3568_PHYREG14);
 
-			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+			writel(RK3568_PHYREG16_SSC_CNT_VALUE, priv->mmio + RK3568_PHYREG16);
 		}
 		break;
 
@@ -881,15 +898,16 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
 		if (priv->type == PHY_TYPE_PCIE) {
 			/* gate_tx_pck_sel length select work for L1SS */
-			writel(0xc0, priv->mmio + PHYREG30);
+			writel(0xc0, priv->mmio + RK3576_PHYREG30);
 
 			/* PLL KVCO tuning fine */
-			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE_RK3576);
-			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-						 val, PHYREG33);
+			val = FIELD_PREP(RK3568_PHYREG33_PLL_KVCO_MASK,
+					 RK3576_PHYREG33_PLL_KVCO_VALUE);
+			rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK,
+						 val, RK3568_PHYREG33);
 
 			/* Set up rx_trim: PLL LPF C1 85pf R1 1.25kohm */
-			writel(0x4c, priv->mmio + PHYREG27);
+			writel(0x4c, priv->mmio + RK3588_PHYREG27);
 
 			/*
 			 * Set up SU adjust signal:
@@ -899,20 +917,23 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 			 * su_trim[23:16], CKRCV adjust
 			 * su_trim[31:24], CKDRV adjust
 			 */
-			writel(0x90, priv->mmio + PHYREG11);
-			writel(0x43, priv->mmio + PHYREG12);
-			writel(0x88, priv->mmio + PHYREG13);
-			writel(0x56, priv->mmio + PHYREG14);
+			writel(0x90, priv->mmio + RK3568_PHYREG11);
+			writel(0x43, priv->mmio + RK3568_PHYREG12);
+			writel(0x88, priv->mmio + RK3568_PHYREG13);
+			writel(0x56, priv->mmio + RK3568_PHYREG14);
 		} else if (priv->type == PHY_TYPE_SATA) {
 			/* downward spread spectrum +500ppm */
-			val = FIELD_PREP(PHYREG32_SSC_DIR_MASK, PHYREG32_SSC_DOWNWARD);
-			val |= FIELD_PREP(PHYREG32_SSC_OFFSET_MASK, PHYREG32_SSC_OFFSET_500PPM);
-			rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
+			val = FIELD_PREP(RK3568_PHYREG32_SSC_DIR_MASK,
+					 RK3568_PHYREG32_SSC_DOWNWARD);
+			val |= FIELD_PREP(RK3568_PHYREG32_SSC_OFFSET_MASK,
+					  RK3568_PHYREG32_SSC_OFFSET_500PPM);
+			rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val,
+						 RK3568_PHYREG32);
 
 			/* ssc ppm adjust to 3500ppm */
-			rockchip_combphy_updatel(priv, PHYREG10_SSC_PCM_MASK,
-						 PHYREG10_SSC_PCM_3500PPM,
-						 PHYREG10);
+			rockchip_combphy_updatel(priv, RK3576_PHYREG10_SSC_PCM_MASK,
+						 RK3576_PHYREG10_SSC_PCM_3500PPM,
+						 RK3576_PHYREG10);
 		}
 		break;
 
@@ -924,12 +945,13 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 	if (priv->ext_refclk) {
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
 		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
-			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE_RK3576);
-			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-						 val, PHYREG33);
+			val = FIELD_PREP(RK3568_PHYREG33_PLL_KVCO_MASK,
+					 RK3576_PHYREG33_PLL_KVCO_VALUE);
+			rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK,
+						 val, RK3568_PHYREG33);
 
 			/* Set up rx_trim: PLL LPF C1 85pf R1 2.5kohm */
-			writel(0x0c, priv->mmio + PHYREG27);
+			writel(0x0c, priv->mmio + RK3588_PHYREG27);
 
 			/*
 			 * Set up SU adjust signal:
@@ -939,25 +961,25 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 			 * su_trim[23:16], CKRCV adjust
 			 * su_trim[31:24], CKDRV adjust
 			 */
-			writel(0x90, priv->mmio + PHYREG11);
-			writel(0x43, priv->mmio + PHYREG12);
-			writel(0x88, priv->mmio + PHYREG13);
-			writel(0x56, priv->mmio + PHYREG14);
+			writel(0x90, priv->mmio + RK3568_PHYREG11);
+			writel(0x43, priv->mmio + RK3568_PHYREG12);
+			writel(0x88, priv->mmio + RK3568_PHYREG13);
+			writel(0x56, priv->mmio + RK3568_PHYREG14);
 		}
 	}
 
 	if (priv->enable_ssc) {
-		val = readl(priv->mmio + PHYREG8);
-		val |= PHYREG8_SSC_EN;
-		writel(val, priv->mmio + PHYREG8);
+		val = readl(priv->mmio + RK3568_PHYREG8);
+		val |= RK3568_PHYREG8_SSC_EN;
+		writel(val, priv->mmio + RK3568_PHYREG8);
 
 		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_24MHz) {
 			/* Set PLL loop divider */
-			writel(0x00, priv->mmio + PHYREG17);
-			writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
+			writel(0x00, priv->mmio + RK3576_PHYREG17);
+			writel(RK3568_PHYREG18_PLL_LOOP, priv->mmio + RK3568_PHYREG18);
 
 			/* Set up rx_pck invert and rx msb to disable */
-			writel(0x00, priv->mmio + PHYREG27);
+			writel(0x00, priv->mmio + RK3588_PHYREG27);
 
 			/*
 			 * Set up SU adjust signal:
@@ -966,16 +988,17 @@ static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
 			 * su_trim[23:16], CKRCV adjust
 			 * su_trim[31:24], CKDRV adjust
 			 */
-			writel(0x90, priv->mmio + PHYREG11);
-			writel(0x02, priv->mmio + PHYREG12);
-			writel(0x08, priv->mmio + PHYREG13);
-			writel(0x57, priv->mmio + PHYREG14);
-			writel(0x40, priv->mmio + PHYREG15);
+			writel(0x90, priv->mmio + RK3568_PHYREG11);
+			writel(0x02, priv->mmio + RK3568_PHYREG12);
+			writel(0x08, priv->mmio + RK3568_PHYREG13);
+			writel(0x57, priv->mmio + RK3568_PHYREG14);
+			writel(0x40, priv->mmio + RK3568_PHYREG15);
 
-			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+			writel(RK3568_PHYREG16_SSC_CNT_VALUE, priv->mmio + RK3568_PHYREG16);
 
-			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE_RK3576);
-			writel(val, priv->mmio + PHYREG33);
+			val = FIELD_PREP(RK3568_PHYREG33_PLL_KVCO_MASK,
+					 RK3576_PHYREG33_PLL_KVCO_VALUE);
+			writel(val, priv->mmio + RK3568_PHYREG33);
 		}
 	}
 
@@ -1045,30 +1068,28 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
 		break;
 	case PHY_TYPE_USB3:
 		/* Set SSC downward spread spectrum */
-		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
-					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
-					 PHYREG32);
+		val = RK3568_PHYREG32_SSC_DOWNWARD << RK3568_PHYREG32_SSC_DIR_SHIFT;
+		rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val, RK3568_PHYREG32);
 
 		/* Enable adaptive CTLE for USB3.0 Rx. */
-		val = readl(priv->mmio + PHYREG15);
-		val |= PHYREG15_CTLE_EN;
-		writel(val, priv->mmio + PHYREG15);
+		val = readl(priv->mmio + RK3568_PHYREG15);
+		val |= RK3568_PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + RK3568_PHYREG15);
 
 		/* Set PLL KVCO fine tuning signals. */
-		rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-					 PHYREG33_PLL_KVCO_VALUE << PHYREG33_PLL_KVCO_SHIFT,
-					 PHYREG33);
+		val = RK3568_PHYREG33_PLL_KVCO_VALUE << RK3568_PHYREG33_PLL_KVCO_SHIFT,
+		rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK, val, RK3568_PHYREG33);
 
 		/* Enable controlling random jitter. */
-		writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+		writel(RK3568_PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + RK3568_PHYREG12);
 
 		/* Set PLL input clock divider 1/2. */
-		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
-					 PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT,
-					 PHYREG6);
+		rockchip_combphy_updatel(priv, RK3568_PHYREG6_PLL_DIV_MASK,
+					 RK3568_PHYREG6_PLL_DIV_2 << RK3568_PHYREG6_PLL_DIV_SHIFT,
+					 RK3568_PHYREG6);
 
-		writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
-		writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+		writel(RK3568_PHYREG18_PLL_LOOP, priv->mmio + RK3568_PHYREG18);
+		writel(RK3568_PHYREG11_SU_TRIM_0_7, priv->mmio + RK3568_PHYREG11);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
@@ -1076,16 +1097,16 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
 		break;
 	case PHY_TYPE_SATA:
 		/* Enable adaptive CTLE for SATA Rx. */
-		val = readl(priv->mmio + PHYREG15);
-		val |= PHYREG15_CTLE_EN;
-		writel(val, priv->mmio + PHYREG15);
+		val = readl(priv->mmio + RK3568_PHYREG15);
+		val |= RK3568_PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + RK3568_PHYREG15);
 		/*
 		 * Set tx_rterm=50ohm and rx_rterm=44ohm for SATA.
 		 * 0: 60ohm, 8: 50ohm 15: 44ohm (by step abort 1ohm)
 		 */
-		val = PHYREG7_TX_RTERM_50OHM << PHYREG7_TX_RTERM_SHIFT;
-		val |= PHYREG7_RX_RTERM_44OHM << PHYREG7_RX_RTERM_SHIFT;
-		writel(val, priv->mmio + PHYREG7);
+		val = RK3568_PHYREG7_TX_RTERM_50OHM << RK3568_PHYREG7_TX_RTERM_SHIFT;
+		val |= RK3568_PHYREG7_RX_RTERM_44OHM << RK3568_PHYREG7_RX_RTERM_SHIFT;
+		writel(val, priv->mmio + RK3568_PHYREG7);
 
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_sata, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_sata, true);
@@ -1107,11 +1128,11 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
 	case REF_CLOCK_24MHz:
 		if (priv->type == PHY_TYPE_USB3 || priv->type == PHY_TYPE_SATA) {
 			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz. */
-			val = PHYREG15_SSC_CNT_VALUE << PHYREG15_SSC_CNT_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
-						 val, PHYREG15);
+			val = RK3568_PHYREG15_SSC_CNT_VALUE << RK3568_PHYREG15_SSC_CNT_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG15_SSC_CNT_MASK,
+						 val, RK3568_PHYREG15);
 
-			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+			writel(RK3568_PHYREG16_SSC_CNT_VALUE, priv->mmio + RK3568_PHYREG16);
 		}
 		break;
 
@@ -1122,23 +1143,25 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
 		if (priv->type == PHY_TYPE_PCIE) {
 			/* PLL KVCO fine tuning. */
-			val = 4 << PHYREG33_PLL_KVCO_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
-						 val, PHYREG33);
+			val = 4 << RK3568_PHYREG33_PLL_KVCO_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG33_PLL_KVCO_MASK,
+						 val, RK3568_PHYREG33);
 
 			/* Enable controlling random jitter. */
-			writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+			writel(RK3568_PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + RK3568_PHYREG12);
 
 			/* Set up rx_trim: PLL LPF C1 85pf R1 1.25kohm */
-			writel(PHYREG27_RX_TRIM_RK3588, priv->mmio + PHYREG27);
+			writel(RK3588_PHYREG27_RX_TRIM, priv->mmio + RK3588_PHYREG27);
 
 			/* Set up su_trim:  */
-			writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+			writel(RK3568_PHYREG11_SU_TRIM_0_7, priv->mmio + RK3568_PHYREG11);
 		} else if (priv->type == PHY_TYPE_SATA) {
 			/* downward spread spectrum +500ppm */
-			val = PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT;
-			val |= PHYREG32_SSC_OFFSET_500PPM << PHYREG32_SSC_OFFSET_SHIFT;
-			rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
+			val = RK3568_PHYREG32_SSC_DOWNWARD << RK3568_PHYREG32_SSC_DIR_SHIFT;
+			val |= RK3568_PHYREG32_SSC_OFFSET_500PPM <<
+			       RK3568_PHYREG32_SSC_OFFSET_SHIFT;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG32_SSC_MASK, val,
+						 RK3568_PHYREG32);
 		}
 		break;
 	default:
@@ -1149,20 +1172,21 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
 	if (priv->ext_refclk) {
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
 		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
-			val = PHYREG13_RESISTER_HIGH_Z << PHYREG13_RESISTER_SHIFT;
-			val |= PHYREG13_CKRCV_AMP0;
-			rockchip_combphy_updatel(priv, PHYREG13_RESISTER_MASK, val, PHYREG13);
-
-			val = readl(priv->mmio + PHYREG14);
-			val |= PHYREG14_CKRCV_AMP1;
-			writel(val, priv->mmio + PHYREG14);
+			val = RK3568_PHYREG13_RESISTER_HIGH_Z << RK3568_PHYREG13_RESISTER_SHIFT;
+			val |= RK3568_PHYREG13_CKRCV_AMP0;
+			rockchip_combphy_updatel(priv, RK3568_PHYREG13_RESISTER_MASK, val,
+						 RK3568_PHYREG13);
+
+			val = readl(priv->mmio + RK3568_PHYREG14);
+			val |= RK3568_PHYREG14_CKRCV_AMP1;
+			writel(val, priv->mmio + RK3568_PHYREG14);
 		}
 	}
 
 	if (priv->enable_ssc) {
-		val = readl(priv->mmio + PHYREG8);
-		val |= PHYREG8_SSC_EN;
-		writel(val, priv->mmio + PHYREG8);
+		val = readl(priv->mmio + RK3568_PHYREG8);
+		val |= RK3568_PHYREG8_SSC_EN;
+		writel(val, priv->mmio + RK3568_PHYREG8);
 	}
 
 	return 0;
diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 79db57ee90d1..5605610465bc 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -500,9 +500,7 @@ static const struct reg_sequence rk_hdtpx_common_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(0043), 0x00),
 	REG_SEQ0(CMN_REG(0044), 0x46),
 	REG_SEQ0(CMN_REG(0045), 0x24),
-	REG_SEQ0(CMN_REG(0046), 0xff),
 	REG_SEQ0(CMN_REG(0047), 0x00),
-	REG_SEQ0(CMN_REG(0048), 0x44),
 	REG_SEQ0(CMN_REG(0049), 0xfa),
 	REG_SEQ0(CMN_REG(004a), 0x08),
 	REG_SEQ0(CMN_REG(004b), 0x00),
@@ -575,6 +573,8 @@ static const struct reg_sequence rk_hdtpx_tmds_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(0034), 0x00),
 	REG_SEQ0(CMN_REG(003d), 0x40),
 	REG_SEQ0(CMN_REG(0042), 0x78),
+	REG_SEQ0(CMN_REG(0046), 0xdd),
+	REG_SEQ0(CMN_REG(0048), 0x11),
 	REG_SEQ0(CMN_REG(004e), 0x34),
 	REG_SEQ0(CMN_REG(005c), 0x25),
 	REG_SEQ0(CMN_REG(005e), 0x4f),
@@ -668,13 +668,9 @@ static const struct reg_sequence rk_hdtpx_common_lane_init_seq[] = {
 
 static const struct reg_sequence rk_hdtpx_tmds_lane_init_seq[] = {
 	REG_SEQ0(LANE_REG(0312), 0x00),
-	REG_SEQ0(LANE_REG(031e), 0x00),
 	REG_SEQ0(LANE_REG(0412), 0x00),
-	REG_SEQ0(LANE_REG(041e), 0x00),
 	REG_SEQ0(LANE_REG(0512), 0x00),
-	REG_SEQ0(LANE_REG(051e), 0x00),
 	REG_SEQ0(LANE_REG(0612), 0x00),
-	REG_SEQ0(LANE_REG(061e), 0x08),
 	REG_SEQ0(LANE_REG(0303), 0x2f),
 	REG_SEQ0(LANE_REG(0403), 0x2f),
 	REG_SEQ0(LANE_REG(0503), 0x2f),
@@ -687,6 +683,11 @@ static const struct reg_sequence rk_hdtpx_tmds_lane_init_seq[] = {
 	REG_SEQ0(LANE_REG(0406), 0x1c),
 	REG_SEQ0(LANE_REG(0506), 0x1c),
 	REG_SEQ0(LANE_REG(0606), 0x1c),
+	/* Keep Inter-Pair Skew in the limits */
+	REG_SEQ0(LANE_REG(031e), 0x02),
+	REG_SEQ0(LANE_REG(041e), 0x02),
+	REG_SEQ0(LANE_REG(051e), 0x02),
+	REG_SEQ0(LANE_REG(061e), 0x0a),
 };
 
 static struct tx_drv_ctrl tx_drv_ctrl_rbr[4][4] = {
@@ -1038,7 +1039,8 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx)
 
 	ret = rk_hdptx_post_enable_pll(hdptx);
 	if (!ret)
-		hdptx->hw_rate = hdptx->hdmi_cfg.tmds_char_rate;
+		hdptx->hw_rate = DIV_ROUND_CLOSEST_ULL(hdptx->hdmi_cfg.tmds_char_rate * 8,
+						       hdptx->hdmi_cfg.bpc);
 
 	return ret;
 }
@@ -1896,19 +1898,20 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * hence ensure rk_hdptx_phy_clk_set_rate() won't be invoked with
 	 * a different rate argument.
 	 */
-	return hdptx->hdmi_cfg.tmds_char_rate;
+	return DIV_ROUND_CLOSEST_ULL(hdptx->hdmi_cfg.tmds_char_rate * 8, hdptx->hdmi_cfg.bpc);
 }
 
 static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 				     unsigned long parent_rate)
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
+	unsigned long long tmds_rate = DIV_ROUND_CLOSEST_ULL(rate * hdptx->hdmi_cfg.bpc, 8);
 
 	/* Revert any unlikely TMDS char rate change since round_rate() */
-	if (hdptx->hdmi_cfg.tmds_char_rate != rate) {
-		dev_warn(hdptx->dev, "Reverting unexpected rate change from %lu to %llu\n",
-			 rate, hdptx->hdmi_cfg.tmds_char_rate);
-		hdptx->hdmi_cfg.tmds_char_rate = rate;
+	if (hdptx->hdmi_cfg.tmds_char_rate != tmds_rate) {
+		dev_warn(hdptx->dev, "Reverting unexpected rate change from %llu to %llu\n",
+			 tmds_rate, hdptx->hdmi_cfg.tmds_char_rate);
+		hdptx->hdmi_cfg.tmds_char_rate = tmds_rate;
 	}
 
 	/*
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 8aedee2720bc..ac5eae50b8a2 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -485,7 +485,8 @@ static int pcs_pinconf_get(struct pinctrl_dev *pctldev,
 	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
 	struct pcs_function *func;
 	enum pin_config_param param;
-	unsigned offset = 0, data = 0, i, j, ret;
+	unsigned offset = 0, data = 0, i, j;
+	int ret;
 
 	ret = pcs_get_function(pctldev, pin, &func);
 	if (ret)
@@ -549,9 +550,9 @@ static int pcs_pinconf_set(struct pinctrl_dev *pctldev,
 {
 	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
 	struct pcs_function *func;
-	unsigned offset = 0, shift = 0, i, data, ret;
+	unsigned offset = 0, shift = 0, i, data;
 	u32 arg;
-	int j;
+	int j, ret;
 	enum pin_config_param param;
 
 	ret = pcs_get_function(pctldev, pin, &func);
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 289917a0e872..9330d1bcf6b2 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -3008,7 +3008,11 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 		 * Now cache the registers or set them in the order suggested by
 		 * HW manual (section "Operation for GPIO Function").
 		 */
-		RZG2L_PCTRL_REG_ACCESS8(suspend, pctrl->base + PMC(off), cache->pmc[port]);
+		if (suspend)
+			RZG2L_PCTRL_REG_ACCESS8(suspend, pctrl->base + PMC(off), cache->pmc[port]);
+		else
+			pctrl->data->pmc_writeb(pctrl, cache->pmc[port], PMC(off));
+
 		if (has_iolh) {
 			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IOLH(off),
 						 cache->iolh[0][port]);
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 823c8fe758e2..d9a2d20a7e6b 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1671,7 +1671,7 @@ int stm32_pctl_probe(struct platform_device *pdev)
 		if (hwlock_id == -EPROBE_DEFER)
 			return hwlock_id;
 	} else {
-		pctl->hwlock = hwspin_lock_request_specific(hwlock_id);
+		pctl->hwlock = devm_hwspin_lock_request_specific(dev, hwlock_id);
 	}
 
 	spin_lock_init(&pctl->irqmux_lock);
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index e72a2b5d158e..8e3300f5c294 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1619,14 +1619,14 @@ static void do_kbd_led_set(struct led_classdev *led_cdev, int value)
 	kbd_led_update(asus);
 }
 
-static void kbd_led_set(struct led_classdev *led_cdev,
-			enum led_brightness value)
+static int kbd_led_set(struct led_classdev *led_cdev, enum led_brightness value)
 {
 	/* Prevent disabling keyboard backlight on module unregister */
 	if (led_cdev->flags & LED_UNREGISTERING)
-		return;
+		return 0;
 
 	do_kbd_led_set(led_cdev, value);
+	return 0;
 }
 
 static void kbd_led_set_by_kbd(struct asus_wmi *asus, enum led_brightness value)
@@ -1802,7 +1802,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 		asus->kbd_led_wk = led_val;
 		asus->kbd_led.name = "asus::kbd_backlight";
 		asus->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
-		asus->kbd_led.brightness_set = kbd_led_set;
+		asus->kbd_led.brightness_set_blocking = kbd_led_set;
 		asus->kbd_led.brightness_get = kbd_led_get;
 		asus->kbd_led.max_brightness = 3;
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 4a94a4ee031e..24139617eef6 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -282,7 +282,7 @@ enum ppfear_regs {
 /* Die C6 from PUNIT telemetry */
 #define MTL_PMT_DMU_DIE_C6_OFFSET		15
 #define MTL_PMT_DMU_GUID			0x1A067102
-#define ARL_PMT_DMU_GUID			0x1A06A000
+#define ARL_PMT_DMU_GUID			0x1A06A102
 
 #define LNL_PMC_MMIO_REG_LEN			0x2708
 #define LNL_PMC_LTR_OSSE			0x1B88
diff --git a/drivers/power/supply/apm_power.c b/drivers/power/supply/apm_power.c
index 9236e0078578..9933cdc5c387 100644
--- a/drivers/power/supply/apm_power.c
+++ b/drivers/power/supply/apm_power.c
@@ -364,7 +364,8 @@ static int __init apm_battery_init(void)
 
 static void __exit apm_battery_exit(void)
 {
-	apm_get_power_status = NULL;
+	if (apm_get_power_status == apm_battery_apm_get_power_status)
+		apm_get_power_status = NULL;
 }
 
 module_init(apm_battery_init);
diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 382dff8805c6..f41ce7e41fac 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -702,7 +702,13 @@ static int cw_bat_probe(struct i2c_client *client)
 	if (!cw_bat->battery_workqueue)
 		return -ENOMEM;
 
-	devm_delayed_work_autocancel(&client->dev, &cw_bat->battery_delay_work, cw_bat_work);
+	ret = devm_delayed_work_autocancel(&client->dev, &cw_bat->battery_delay_work, cw_bat_work);
+	if (ret) {
+		dev_err_probe(&client->dev, ret,
+			"Failed to register delayed work\n");
+		return ret;
+	}
+
 	queue_delayed_work(cw_bat->battery_workqueue,
 			   &cw_bat->battery_delay_work, msecs_to_jiffies(10));
 	return 0;
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index c1640bc6accd..48453508688a 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -388,6 +388,7 @@ static int max17040_get_property(struct power_supply *psy,
 			    union power_supply_propval *val)
 {
 	struct max17040_chip *chip = power_supply_get_drvdata(psy);
+	int ret;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -410,7 +411,10 @@ static int max17040_get_property(struct power_supply *psy,
 		if (!chip->channel_temp)
 			return -ENODATA;
 
-		iio_read_channel_processed(chip->channel_temp, &val->intval);
+		ret = iio_read_channel_processed(chip->channel_temp, &val->intval);
+		if (ret)
+			return ret;
+
 		val->intval /= 100; /* Convert from milli- to deci-degree */
 
 		break;
diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index 2fdc58439707..de724f23e453 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -701,6 +701,8 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	np_conn = of_parse_phandle(pdev->dev.of_node, "richtek,usb-connector", 0);
 	np_edev = of_get_parent(np_conn);
 	charger->edev = extcon_find_edev_by_node(np_edev);
+	of_node_put(np_edev);
+	of_node_put(np_conn);
 	if (IS_ERR(charger->edev)) {
 		dev_warn(charger->dev, "no extcon device found in device-tree\n");
 		goto out;
diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index e9aba9ad393c..3beb8a763a92 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -376,7 +376,7 @@ static int rt9467_set_value_from_ranges(struct rt9467_chg_data *data,
 	if (rsel == RT9467_RANGE_VMIVR) {
 		ret = linear_range_get_selector_high(range, value, &sel, &found);
 		if (ret)
-			value = range->max_sel;
+			sel = range->max_sel;
 	} else {
 		linear_range_get_selector_within(range, value, &sel);
 	}
@@ -588,6 +588,10 @@ static int rt9467_run_aicl(struct rt9467_chg_data *data)
 	aicl_vth = mivr_vth + RT9467_AICLVTH_GAP_uV;
 	ret = rt9467_set_value_from_ranges(data, F_AICL_VTH,
 					   RT9467_RANGE_AICL_VTH, aicl_vth);
+	if (ret) {
+		dev_err(data->dev, "Failed to set AICL VTH\n");
+		return ret;
+	}
 
 	/* Trigger AICL function */
 	ret = regmap_field_write(data->rm_field[F_AICL_MEAS], 1);
diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/wm831x_power.c
index 6acdba7885ca..78fa0573ef25 100644
--- a/drivers/power/supply/wm831x_power.c
+++ b/drivers/power/supply/wm831x_power.c
@@ -144,6 +144,7 @@ static int wm831x_usb_limit_change(struct notifier_block *nb,
 							 struct wm831x_power,
 							 usb_notify);
 	unsigned int i, best;
+	int ret;
 
 	/* Find the highest supported limit */
 	best = 0;
@@ -156,8 +157,13 @@ static int wm831x_usb_limit_change(struct notifier_block *nb,
 	dev_dbg(wm831x_power->wm831x->dev,
 		"Limiting USB current to %umA", wm831x_usb_limits[best]);
 
-	wm831x_set_bits(wm831x_power->wm831x, WM831X_POWER_STATE,
-		        WM831X_USB_ILIM_MASK, best);
+	ret = wm831x_set_bits(wm831x_power->wm831x, WM831X_POWER_STATE,
+			      WM831X_USB_ILIM_MASK, best);
+	if (ret < 0) {
+		dev_err(wm831x_power->wm831x->dev,
+			"Failed to set USB current limit: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 578e95e0296c..532903da521f 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -34,29 +34,6 @@ static inline struct bcm2835_pwm *to_bcm2835_pwm(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
-static int bcm2835_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
-	u32 value;
-
-	value = readl(pc->base + PWM_CONTROL);
-	value &= ~(PWM_CONTROL_MASK << PWM_CONTROL_SHIFT(pwm->hwpwm));
-	value |= (PWM_MODE << PWM_CONTROL_SHIFT(pwm->hwpwm));
-	writel(value, pc->base + PWM_CONTROL);
-
-	return 0;
-}
-
-static void bcm2835_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
-	u32 value;
-
-	value = readl(pc->base + PWM_CONTROL);
-	value &= ~(PWM_CONTROL_MASK << PWM_CONTROL_SHIFT(pwm->hwpwm));
-	writel(value, pc->base + PWM_CONTROL);
-}
-
 static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			     const struct pwm_state *state)
 {
@@ -102,6 +79,9 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* set polarity */
 	val = readl(pc->base + PWM_CONTROL);
 
+	val &= ~(PWM_CONTROL_MASK << PWM_CONTROL_SHIFT(pwm->hwpwm));
+	val |= PWM_MODE << PWM_CONTROL_SHIFT(pwm->hwpwm);
+
 	if (state->polarity == PWM_POLARITY_NORMAL)
 		val &= ~(PWM_POLARITY << PWM_CONTROL_SHIFT(pwm->hwpwm));
 	else
@@ -119,8 +99,6 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static const struct pwm_ops bcm2835_pwm_ops = {
-	.request = bcm2835_pwm_request,
-	.free = bcm2835_pwm_free,
 	.apply = bcm2835_pwm_apply,
 };
 
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index a6e4792a1b2e..c1b36a5601c4 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -52,9 +52,45 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
 }
 
-void log_arm_hw_error(struct cper_sec_proc_arm *err)
+void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 {
-	trace_arm_event(err);
+	struct cper_arm_err_info *err_info;
+	struct cper_arm_ctx_info *ctx_info;
+	u8 *ven_err_data;
+	u32 ctx_len = 0;
+	int n, sz, cpu;
+	s32 vsei_len;
+	u32 pei_len;
+	u8 *pei_err, *ctx_err;
+
+	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
+	pei_err = (u8 *)(err + 1);
+
+	err_info = (struct cper_arm_err_info *)(err + 1);
+	ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
+	ctx_err = (u8 *)ctx_info;
+
+	for (n = 0; n < err->context_info_num; n++) {
+		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
+		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
+		ctx_len += sz;
+	}
+
+	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) + pei_len + ctx_len);
+	if (vsei_len < 0) {
+		pr_warn(FW_BUG "section length: %d\n", err->section_length);
+		pr_warn(FW_BUG "section length is too small\n");
+		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
+		vsei_len = 0;
+	}
+	ven_err_data = (u8 *)ctx_info;
+
+	cpu = GET_LOGICAL_INDEX(err->mpidr);
+	if (cpu < 0)
+		cpu = -1;
+
+	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
+			ven_err_data, (u32)vsei_len, sev, cpu);
 }
 
 static int __init ras_init(void)
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 554d83c4af0c..8d3d6085f0ad 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1618,6 +1618,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 	 * and we have control then make sure it is enabled.
 	 */
 	if (rdev->constraints->always_on || rdev->constraints->boot_on) {
+		bool supply_enabled = false;
+
 		/* If we want to enable this regulator, make sure that we know
 		 * the supplying regulator.
 		 */
@@ -1637,11 +1639,14 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 				rdev->supply = NULL;
 				return ret;
 			}
+			supply_enabled = true;
 		}
 
 		ret = _regulator_do_enable(rdev);
 		if (ret < 0 && ret != -EINVAL) {
 			rdev_err(rdev, "failed to enable: %pe\n", ERR_PTR(ret));
+			if (supply_enabled)
+				regulator_disable(rdev->supply);
 			return ret;
 		}
 
@@ -1942,6 +1947,7 @@ static void regulator_supply_alias(struct device **dev, const char **supply)
 {
 	struct regulator_supply_alias *map;
 
+	mutex_lock(&regulator_list_mutex);
 	map = regulator_find_supply_alias(*dev, *supply);
 	if (map) {
 		dev_dbg(*dev, "Mapping supply %s to %s,%s\n",
@@ -1950,6 +1956,7 @@ static void regulator_supply_alias(struct device **dev, const char **supply)
 		*dev = map->alias_dev;
 		*supply = map->alias_supply;
 	}
+	mutex_unlock(&regulator_list_mutex);
 }
 
 static int regulator_match(struct device *dev, const void *data)
@@ -2492,22 +2499,26 @@ int regulator_register_supply_alias(struct device *dev, const char *id,
 				    const char *alias_id)
 {
 	struct regulator_supply_alias *map;
+	struct regulator_supply_alias *new_map;
 
-	map = regulator_find_supply_alias(dev, id);
-	if (map)
-		return -EEXIST;
-
-	map = kzalloc(sizeof(struct regulator_supply_alias), GFP_KERNEL);
-	if (!map)
+	new_map = kzalloc(sizeof(struct regulator_supply_alias), GFP_KERNEL);
+	if (!new_map)
 		return -ENOMEM;
 
-	map->src_dev = dev;
-	map->src_supply = id;
-	map->alias_dev = alias_dev;
-	map->alias_supply = alias_id;
-
-	list_add(&map->list, &regulator_supply_alias_list);
+	mutex_lock(&regulator_list_mutex);
+	map = regulator_find_supply_alias(dev, id);
+	if (map) {
+		mutex_unlock(&regulator_list_mutex);
+		kfree(new_map);
+		return -EEXIST;
+	}
 
+	new_map->src_dev = dev;
+	new_map->src_supply = id;
+	new_map->alias_dev = alias_dev;
+	new_map->alias_supply = alias_id;
+	list_add(&new_map->list, &regulator_supply_alias_list);
+	mutex_unlock(&regulator_list_mutex);
 	pr_info("Adding alias for supply %s,%s -> %s,%s\n",
 		id, dev_name(dev), alias_id, dev_name(alias_dev));
 
@@ -2527,11 +2538,13 @@ void regulator_unregister_supply_alias(struct device *dev, const char *id)
 {
 	struct regulator_supply_alias *map;
 
+	mutex_lock(&regulator_list_mutex);
 	map = regulator_find_supply_alias(dev, id);
 	if (map) {
 		list_del(&map->list);
 		kfree(map);
 	}
+	mutex_unlock(&regulator_list_mutex);
 }
 EXPORT_SYMBOL_GPL(regulator_unregister_supply_alias);
 
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index a2d16e9abfb5..254c0a8a4555 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -330,13 +330,10 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 
 	drvdata->dev = devm_regulator_register(&pdev->dev, &drvdata->desc,
 					       &cfg);
-	if (IS_ERR(drvdata->dev)) {
-		ret = dev_err_probe(&pdev->dev, PTR_ERR(drvdata->dev),
-				    "Failed to register regulator: %ld\n",
-				    PTR_ERR(drvdata->dev));
-		gpiod_put(cfg.ena_gpiod);
-		return ret;
-	}
+	if (IS_ERR(drvdata->dev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->dev),
+				     "Failed to register regulator: %ld\n",
+				     PTR_ERR(drvdata->dev));
 
 	platform_set_drvdata(pdev, drvdata);
 
diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 4be270f4d6c3..91b96dbab328 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -1251,10 +1251,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	 * to this signal (if SION bit is set in IOMUX).
 	 */
 	pca9450->sd_vsel_gpio = gpiod_get_optional(&ldo5->dev, "sd-vsel", GPIOD_IN);
-	if (IS_ERR(pca9450->sd_vsel_gpio)) {
-		dev_err(&i2c->dev, "Failed to get SD_VSEL GPIO\n");
-		return ret;
-	}
+	if (IS_ERR(pca9450->sd_vsel_gpio))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pca9450->sd_vsel_gpio),
+				     "Failed to get SD_VSEL GPIO\n");
 
 	pca9450->sd_vsel_fixed_low =
 		of_property_read_bool(ldo5->dev.of_node, "nxp,sd-vsel-fixed-low");
diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index a6eef0080ca9..2eaff813a5b9 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -1174,11 +1174,16 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	ret = rproc_add(rproc);
 	if (ret) {
 		dev_err(dev, "rproc_add failed\n");
-		goto err_put_clk;
+		goto err_put_pm;
 	}
 
 	return 0;
 
+err_put_pm:
+	if (dcfg->method == IMX_RPROC_SCU_API) {
+		pm_runtime_disable(dev);
+		pm_runtime_put_noidle(dev);
+	}
 err_put_clk:
 	clk_disable_unprepare(priv->clk);
 err_put_scu:
@@ -1198,7 +1203,7 @@ static void imx_rproc_remove(struct platform_device *pdev)
 
 	if (priv->dcfg->method == IMX_RPROC_SCU_API) {
 		pm_runtime_disable(priv->dev);
-		pm_runtime_put(priv->dev);
+		pm_runtime_put_noidle(priv->dev);
 	}
 	clk_disable_unprepare(priv->clk);
 	rproc_del(rproc);
diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
index 93648734a2f2..74e9e642b5e7 100644
--- a/drivers/remoteproc/qcom_q6v5_wcss.c
+++ b/drivers/remoteproc/qcom_q6v5_wcss.c
@@ -85,7 +85,7 @@
 #define TCSR_WCSS_CLK_MASK	0x1F
 #define TCSR_WCSS_CLK_ENABLE	0x14
 
-#define MAX_HALT_REG		3
+#define MAX_HALT_REG		4
 enum {
 	WCSS_IPQ8074,
 	WCSS_QCS404,
@@ -864,9 +864,9 @@ static int q6v5_wcss_init_mmio(struct q6v5_wcss *wcss,
 		return -EINVAL;
 	}
 
-	wcss->halt_q6 = halt_reg[0];
-	wcss->halt_wcss = halt_reg[1];
-	wcss->halt_nc = halt_reg[2];
+	wcss->halt_q6 = halt_reg[1];
+	wcss->halt_wcss = halt_reg[2];
+	wcss->halt_nc = halt_reg[3];
 
 	return 0;
 }
diff --git a/drivers/rtc/rtc-amlogic-a4.c b/drivers/rtc/rtc-amlogic-a4.c
index 09d78c2cc691..c3cac29d96f0 100644
--- a/drivers/rtc/rtc-amlogic-a4.c
+++ b/drivers/rtc/rtc-amlogic-a4.c
@@ -390,7 +390,6 @@ static int aml_rtc_probe(struct platform_device *pdev)
 
 	return 0;
 err_clk:
-	clk_disable_unprepare(rtc->sys_clk);
 	device_init_wakeup(dev, false);
 
 	return ret;
@@ -423,9 +422,6 @@ static SIMPLE_DEV_PM_OPS(aml_rtc_pm_ops,
 
 static void aml_rtc_remove(struct platform_device *pdev)
 {
-	struct aml_rtc_data *rtc = dev_get_drvdata(&pdev->dev);
-
-	clk_disable_unprepare(rtc->sys_clk);
 	device_init_wakeup(&pdev->dev, false);
 }
 
diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
index c828bc8e05b9..045d5d45ab4b 100644
--- a/drivers/rtc/rtc-gamecube.c
+++ b/drivers/rtc/rtc-gamecube.c
@@ -242,6 +242,10 @@ static int gamecube_rtc_read_offset_from_sram(struct priv *d)
 	}
 
 	hw_srnprot = ioremap(res.start, resource_size(&res));
+	if (!hw_srnprot) {
+		pr_err("failed to ioremap hw_srnprot\n");
+		return -ENOMEM;
+	}
 	old = ioread32be(hw_srnprot);
 
 	/* TODO: figure out why we use this magic constant.  I obtained it by
diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
index dfb5bad3a369..23b7bf16b4cd 100644
--- a/drivers/rtc/rtc-max31335.c
+++ b/drivers/rtc/rtc-max31335.c
@@ -391,10 +391,8 @@ static int max31335_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(max31335->regmap, max31335->chip->int_status_reg,
-				 MAX31335_STATUS1_A1F, 0);
-
-	return 0;
+	return regmap_update_bits(max31335->regmap, max31335->chip->int_status_reg,
+				  MAX31335_STATUS1_A1F, 0);
 }
 
 static int max31335_alarm_irq_enable(struct device *dev, unsigned int enabled)
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 65f1a127cc3f..dfd5d0f61a70 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -2484,15 +2484,15 @@ static int __init ap_module_init(void)
 {
 	int rc;
 
-	rc = ap_debug_init();
-	if (rc)
-		return rc;
-
 	if (!ap_instructions_available()) {
 		pr_warn("The hardware system does not support AP instructions\n");
 		return -ENODEV;
 	}
 
+	rc = ap_debug_init();
+	if (rc)
+		return rc;
+
 	/* init ap_queue hashtable */
 	hash_init(ap_queues);
 
diff --git a/drivers/scsi/imm.c b/drivers/scsi/imm.c
index 0821cf994b98..8a099bc27e06 100644
--- a/drivers/scsi/imm.c
+++ b/drivers/scsi/imm.c
@@ -1260,6 +1260,7 @@ static void imm_detach(struct parport *pb)
 	imm_struct *dev;
 	list_for_each_entry(dev, &imm_hosts, list) {
 		if (dev->dev->port == pb) {
+			disable_delayed_work_sync(&dev->imm_tq);
 			list_del_init(&dev->list);
 			scsi_remove_host(dev->host);
 			scsi_host_put(dev->host);
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 316594aa40cc..42eb65a62f1f 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -1292,7 +1292,7 @@ void qla2xxx_process_purls_iocb(void **pkt, struct rsp_que **rsp)
 		a.reason = FCNVME_RJT_RC_LOGIC;
 		a.explanation = FCNVME_RJT_EXP_NONE;
 		xmt_reject = true;
-		kfree(item);
+		qla24xx_free_purex_item(item);
 		goto out;
 	}
 
diff --git a/drivers/scsi/sim710.c b/drivers/scsi/sim710.c
index e519df68d603..70c75ab1453a 100644
--- a/drivers/scsi/sim710.c
+++ b/drivers/scsi/sim710.c
@@ -133,6 +133,7 @@ static int sim710_probe_common(struct device *dev, unsigned long base_addr,
  out_put_host:
 	scsi_host_put(host);
  out_release:
+	ioport_unmap(hostdata->base);
 	release_region(base_addr, 64);
  out_free:
 	kfree(hostdata);
@@ -148,6 +149,7 @@ static int sim710_device_remove(struct device *dev)
 
 	scsi_remove_host(host);
 	NCR_700_release(host);
+	ioport_unmap(hostdata->base);
 	kfree(hostdata);
 	free_irq(host->irq, host);
 	release_region(host->base, 64);
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 125944941601..9f4f6e74f3e3 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6409,10 +6409,22 @@ static int pqi_device_reset(struct pqi_ctrl_info *ctrl_info, struct pqi_scsi_dev
 
 static int pqi_device_reset_handler(struct pqi_ctrl_info *ctrl_info, struct pqi_scsi_dev *device, u8 lun, struct scsi_cmnd *scmd, u8 scsi_opcode)
 {
+	unsigned long flags;
 	int rc;
 
 	mutex_lock(&ctrl_info->lun_reset_mutex);
 
+	spin_lock_irqsave(&ctrl_info->scsi_device_list_lock, flags);
+	if (pqi_find_scsi_dev(ctrl_info, device->bus, device->target, device->lun) == NULL) {
+		dev_warn(&ctrl_info->pci_dev->dev,
+			"skipping reset of scsi %d:%d:%d:%u, device has been removed\n",
+			ctrl_info->scsi_host->host_no, device->bus, device->target, device->lun);
+		spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
+		mutex_unlock(&ctrl_info->lun_reset_mutex);
+		return 0;
+	}
+	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
+
 	dev_err(&ctrl_info->pci_dev->dev,
 		"resetting scsi %d:%d:%d:%u SCSI cmd at %p due to cmd opcode 0x%02x\n",
 		ctrl_info->scsi_host->host_no, device->bus, device->target, lun, scmd, scsi_opcode);
@@ -6593,7 +6605,9 @@ static void pqi_sdev_destroy(struct scsi_device *sdev)
 {
 	struct pqi_ctrl_info *ctrl_info;
 	struct pqi_scsi_dev *device;
+	struct pqi_tmf_work *tmf_work;
 	int mutex_acquired;
+	unsigned int lun;
 	unsigned long flags;
 
 	ctrl_info = shost_to_hba(sdev->host);
@@ -6620,8 +6634,13 @@ static void pqi_sdev_destroy(struct scsi_device *sdev)
 
 	mutex_unlock(&ctrl_info->scan_mutex);
 
+	for (lun = 0, tmf_work = device->tmf_work; lun < PQI_MAX_LUNS_PER_DEVICE; lun++, tmf_work++)
+		cancel_work_sync(&tmf_work->work_struct);
+
+	mutex_lock(&ctrl_info->lun_reset_mutex);
 	pqi_dev_info(ctrl_info, "removed", device);
 	pqi_free_device(device);
+	mutex_unlock(&ctrl_info->lun_reset_mutex);
 }
 
 static int pqi_getpciinfo_ioctl(struct pqi_ctrl_info *ctrl_info, void __user *arg)
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 63ed7f9aaa93..34a557297fef 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -1844,6 +1844,7 @@ static int stex_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_scsi_host_put:
 	scsi_host_put(host);
 out_disable:
+	unregister_reboot_notifier(&stex_notifier);
 	pci_disable_device(pdev);
 
 	return err;
diff --git a/drivers/soc/qcom/qcom_gsbi.c b/drivers/soc/qcom/qcom_gsbi.c
index 8f1158e0c631..a25d1de592f0 100644
--- a/drivers/soc/qcom/qcom_gsbi.c
+++ b/drivers/soc/qcom/qcom_gsbi.c
@@ -212,13 +212,6 @@ static int gsbi_probe(struct platform_device *pdev)
 	return of_platform_populate(node, NULL, NULL, &pdev->dev);
 }
 
-static void gsbi_remove(struct platform_device *pdev)
-{
-	struct gsbi_info *gsbi = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(gsbi->hclk);
-}
-
 static const struct of_device_id gsbi_dt_match[] = {
 	{ .compatible = "qcom,gsbi-v1.0.0", },
 	{ },
@@ -232,7 +225,6 @@ static struct platform_driver gsbi_driver = {
 		.of_match_table	= gsbi_dt_match,
 	},
 	.probe = gsbi_probe,
-	.remove = gsbi_remove,
 };
 
 module_platform_driver(gsbi_driver);
diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index c4c45f15dca4..f1d1b5aa5e4d 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -1190,7 +1190,7 @@ static int qcom_smem_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, hwlock_id,
 				     "failed to retrieve hwlock\n");
 
-	smem->hwlock = hwspin_lock_request_specific(hwlock_id);
+	smem->hwlock = devm_hwspin_lock_request_specific(&pdev->dev, hwlock_id);
 	if (!smem->hwlock)
 		return -ENXIO;
 
@@ -1243,7 +1243,6 @@ static void qcom_smem_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(__smem->socinfo);
 
-	hwspin_lock_free(__smem->hwlock);
 	__smem = NULL;
 }
 
diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index b78163eaed61..20b5d469d519 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -1030,6 +1030,11 @@ static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 	.dirmap_write = airoha_snand_dirmap_write,
 };
 
+static const struct spi_controller_mem_ops airoha_snand_nodma_mem_ops = {
+	.supports_op = airoha_snand_supports_op,
+	.exec_op = airoha_snand_exec_op,
+};
+
 static int airoha_snand_setup(struct spi_device *spi)
 {
 	struct airoha_snand_ctrl *as_ctrl;
@@ -1104,7 +1109,9 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	struct airoha_snand_ctrl *as_ctrl;
 	struct device *dev = &pdev->dev;
 	struct spi_controller *ctrl;
+	bool dma_enable = true;
 	void __iomem *base;
+	u32 sfc_strap;
 	int err;
 
 	ctrl = devm_spi_alloc_host(dev, sizeof(*as_ctrl));
@@ -1139,12 +1146,28 @@ static int airoha_snand_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(as_ctrl->spi_clk),
 				     "unable to get spi clk\n");
 
+	if (device_is_compatible(dev, "airoha,en7523-snand")) {
+		err = regmap_read(as_ctrl->regmap_ctrl,
+				  REG_SPI_CTRL_SFC_STRAP, &sfc_strap);
+		if (err)
+			return err;
+
+		if (!(sfc_strap & 0x04)) {
+			dma_enable = false;
+			dev_warn(dev, "Detected booting in RESERVED mode (UART_TXD was short to GND).\n");
+			dev_warn(dev, "This mode is known for incorrect DMA reading of some flashes.\n");
+			dev_warn(dev, "Much slower PIO mode will be used to prevent flash data damage.\n");
+			dev_warn(dev, "Unplug UART cable and power cycle board to get full performance.\n");
+		}
+	}
+
 	err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
 	if (err)
 		return err;
 
 	ctrl->num_chipselect = 2;
-	ctrl->mem_ops = &airoha_snand_mem_ops;
+	ctrl->mem_ops = dma_enable ? &airoha_snand_mem_ops
+				   : &airoha_snand_nodma_mem_ops;
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->mode_bits = SPI_RX_DUAL;
 	ctrl->setup = airoha_snand_setup;
diff --git a/drivers/spi/spi-ch341.c b/drivers/spi/spi-ch341.c
index 46bc208f2d05..79d2f9ab4ef0 100644
--- a/drivers/spi/spi-ch341.c
+++ b/drivers/spi/spi-ch341.c
@@ -78,7 +78,7 @@ static int ch341_transfer_one(struct spi_controller *host,
 
 	ch341->tx_buf[0] = CH341A_CMD_SPI_STREAM;
 
-	memcpy(ch341->tx_buf + 1, trans->tx_buf, len);
+	memcpy(ch341->tx_buf + 1, trans->tx_buf, len - 1);
 
 	ret = usb_bulk_msg(ch341->udev, ch341->write_pipe, ch341->tx_buf, len,
 			   NULL, CH341_DEFAULT_TIMEOUT);
diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index af48b1fcda93..37f1cfe10be4 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -42,6 +42,7 @@
 #define SPIFMC_TRAN_CSR_TRAN_MODE_RX		BIT(0)
 #define SPIFMC_TRAN_CSR_TRAN_MODE_TX		BIT(1)
 #define SPIFMC_TRAN_CSR_FAST_MODE		BIT(3)
+#define SPIFMC_TRAN_CSR_BUS_WIDTH_MASK		GENMASK(5, 4)
 #define SPIFMC_TRAN_CSR_BUS_WIDTH_1_BIT		(0x00 << 4)
 #define SPIFMC_TRAN_CSR_BUS_WIDTH_2_BIT		(0x01 << 4)
 #define SPIFMC_TRAN_CSR_BUS_WIDTH_4_BIT		(0x02 << 4)
@@ -122,8 +123,7 @@ static u32 sg2044_spifmc_init_reg(struct sg2044_spifmc *spifmc)
 	reg = readl(spifmc->io_base + SPIFMC_TRAN_CSR);
 	reg &= ~(SPIFMC_TRAN_CSR_TRAN_MODE_MASK |
 		 SPIFMC_TRAN_CSR_FAST_MODE |
-		 SPIFMC_TRAN_CSR_BUS_WIDTH_2_BIT |
-		 SPIFMC_TRAN_CSR_BUS_WIDTH_4_BIT |
+		 SPIFMC_TRAN_CSR_BUS_WIDTH_MASK |
 		 SPIFMC_TRAN_CSR_DMA_EN |
 		 SPIFMC_TRAN_CSR_ADDR_BYTES_MASK |
 		 SPIFMC_TRAN_CSR_WITH_CMD |
diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 3be7499db21e..d9ca3d7b082f 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1024,8 +1024,10 @@ static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
 	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
 	tegra_qspi_dump_regs(tqspi);
 	tegra_qspi_flush_fifos(tqspi, true);
-	if (device_reset(tqspi->dev) < 0)
+	if (device_reset(tqspi->dev) < 0) {
 		dev_warn_once(tqspi->dev, "device reset failed\n");
+		tegra_qspi_mask_clear_irq(tqspi);
+	}
 }
 
 static void tegra_qspi_transfer_end(struct spi_device *spi)
@@ -1176,9 +1178,11 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 				}
 
 				/* Reset controller if timeout happens */
-				if (device_reset(tqspi->dev) < 0)
+				if (device_reset(tqspi->dev) < 0) {
 					dev_warn_once(tqspi->dev,
 						      "device reset failed\n");
+					tegra_qspi_mask_clear_irq(tqspi);
+				}
 				ret = -EIO;
 				goto exit;
 			}
@@ -1200,11 +1204,13 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 			tegra_qspi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
 		}
+		tqspi->curr_xfer = NULL;
 		transfer_phase++;
 	}
 	ret = 0;
 
 exit:
+	tqspi->curr_xfer = NULL;
 	msg->status = ret;
 
 	return ret;
@@ -1290,6 +1296,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 		msg->actual_length += xfer->len + dummy_bytes;
 
 complete_xfer:
+		tqspi->curr_xfer = NULL;
+
 		if (ret < 0) {
 			tegra_qspi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
@@ -1395,6 +1403,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi)
 	tegra_qspi_calculate_curr_xfer_param(tqspi, t);
 	tegra_qspi_start_cpu_based_transfer(tqspi, t);
 exit:
+	tqspi->curr_xfer = NULL;
 	spin_unlock_irqrestore(&tqspi->lock, flags);
 	return IRQ_HANDLED;
 }
@@ -1480,6 +1489,15 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
 
+	/*
+	 * Occasionally the IRQ thread takes a long time to wake up (usually
+	 * when the CPU that it's running on is excessively busy) and we have
+	 * already reached the timeout before and cleaned up the timed out
+	 * transfer. Avoid any processing in that case and bail out early.
+	 */
+	if (!tqspi->curr_xfer)
+		return IRQ_NONE;
+
 	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
 
 	if (tqspi->cur_direction & DATA_DIR_TX)
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 9e7b84071174..8a5ccc8ae0a1 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -1171,8 +1171,8 @@ int fbtft_probe_common(struct fbtft_display *display,
 	par->pdev = pdev;
 
 	if (display->buswidth == 0) {
-		dev_err(dev, "buswidth is not set\n");
-		return -EINVAL;
+		ret = dev_err_probe(dev, -EINVAL, "buswidth is not set\n");
+		goto out_release;
 	}
 
 	/* write register functions */
diff --git a/drivers/staging/most/Kconfig b/drivers/staging/most/Kconfig
index 6f420cbcdcff..e89658df6f12 100644
--- a/drivers/staging/most/Kconfig
+++ b/drivers/staging/most/Kconfig
@@ -24,6 +24,4 @@ source "drivers/staging/most/video/Kconfig"
 
 source "drivers/staging/most/dim2/Kconfig"
 
-source "drivers/staging/most/i2c/Kconfig"
-
 endif
diff --git a/drivers/staging/most/Makefile b/drivers/staging/most/Makefile
index 8b3fc5a7af51..e45084df7803 100644
--- a/drivers/staging/most/Makefile
+++ b/drivers/staging/most/Makefile
@@ -3,4 +3,3 @@
 obj-$(CONFIG_MOST_NET)	+= net/
 obj-$(CONFIG_MOST_VIDEO)	+= video/
 obj-$(CONFIG_MOST_DIM2)	+= dim2/
-obj-$(CONFIG_MOST_I2C)	+= i2c/
diff --git a/drivers/staging/most/i2c/Kconfig b/drivers/staging/most/i2c/Kconfig
deleted file mode 100644
index ff64283cbad1..000000000000
--- a/drivers/staging/most/i2c/Kconfig
+++ /dev/null
@@ -1,13 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# MOST I2C configuration
-#
-
-config MOST_I2C
-	tristate "I2C"
-	depends on I2C
-	help
-	  Say Y here if you want to connect via I2C to network transceiver.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called most_i2c.
diff --git a/drivers/staging/most/i2c/Makefile b/drivers/staging/most/i2c/Makefile
deleted file mode 100644
index 71099dd0f85b..000000000000
--- a/drivers/staging/most/i2c/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_MOST_I2C) += most_i2c.o
-
-most_i2c-objs := i2c.o
diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/i2c.c
deleted file mode 100644
index 184b2dd11fc3..000000000000
--- a/drivers/staging/most/i2c/i2c.c
+++ /dev/null
@@ -1,374 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * i2c.c - Hardware Dependent Module for I2C Interface
- *
- * Copyright (C) 2013-2015, Microchip Technology Germany II GmbH & Co. KG
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/interrupt.h>
-#include <linux/err.h>
-#include <linux/most.h>
-
-enum { CH_RX, CH_TX, NUM_CHANNELS };
-
-#define MAX_BUFFERS_CONTROL 32
-#define MAX_BUF_SIZE_CONTROL 256
-
-/**
- * list_first_mbo - get the first mbo from a list
- * @ptr:	the list head to take the mbo from.
- */
-#define list_first_mbo(ptr) \
-	list_first_entry(ptr, struct mbo, list)
-
-static unsigned int polling_rate;
-module_param(polling_rate, uint, 0644);
-MODULE_PARM_DESC(polling_rate, "Polling rate [Hz]. Default = 0 (use IRQ)");
-
-struct hdm_i2c {
-	struct most_interface most_iface;
-	struct most_channel_capability capabilities[NUM_CHANNELS];
-	struct i2c_client *client;
-	struct rx {
-		struct delayed_work dwork;
-		struct list_head list;
-		bool int_disabled;
-		unsigned int delay;
-	} rx;
-	char name[64];
-};
-
-static inline struct hdm_i2c *to_hdm(struct most_interface *iface)
-{
-	return container_of(iface, struct hdm_i2c, most_iface);
-}
-
-static irqreturn_t most_irq_handler(int, void *);
-static void pending_rx_work(struct work_struct *);
-
-/**
- * configure_channel - called from MOST core to configure a channel
- * @most_iface: interface the channel belongs to
- * @ch_idx: channel to be configured
- * @channel_config: structure that holds the configuration information
- *
- * Return 0 on success, negative on failure.
- *
- * Receives configuration information from MOST core and initialize the
- * corresponding channel.
- */
-static int configure_channel(struct most_interface *most_iface,
-			     int ch_idx,
-			     struct most_channel_config *channel_config)
-{
-	int ret;
-	struct hdm_i2c *dev = to_hdm(most_iface);
-	unsigned int delay, pr;
-
-	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
-
-	if (channel_config->data_type != MOST_CH_CONTROL) {
-		pr_err("bad data type for channel %d\n", ch_idx);
-		return -EPERM;
-	}
-
-	if (channel_config->direction != dev->capabilities[ch_idx].direction) {
-		pr_err("bad direction for channel %d\n", ch_idx);
-		return -EPERM;
-	}
-
-	if (channel_config->direction == MOST_CH_RX) {
-		if (!polling_rate) {
-			if (dev->client->irq <= 0) {
-				pr_err("bad irq: %d\n", dev->client->irq);
-				return -ENOENT;
-			}
-			dev->rx.int_disabled = false;
-			ret = request_irq(dev->client->irq, most_irq_handler, 0,
-					  dev->client->name, dev);
-			if (ret) {
-				pr_err("request_irq(%d) failed: %d\n",
-				       dev->client->irq, ret);
-				return ret;
-			}
-		} else {
-			delay = msecs_to_jiffies(MSEC_PER_SEC / polling_rate);
-			dev->rx.delay = delay ? delay : 1;
-			pr = MSEC_PER_SEC / jiffies_to_msecs(dev->rx.delay);
-			pr_info("polling rate is %u Hz\n", pr);
-		}
-	}
-
-	return 0;
-}
-
-/**
- * enqueue - called from MOST core to enqueue a buffer for data transfer
- * @most_iface: intended interface
- * @ch_idx: ID of the channel the buffer is intended for
- * @mbo: pointer to the buffer object
- *
- * Return 0 on success, negative on failure.
- *
- * Transmit the data over I2C if it is a "write" request or push the buffer into
- * list if it is an "read" request
- */
-static int enqueue(struct most_interface *most_iface,
-		   int ch_idx, struct mbo *mbo)
-{
-	struct hdm_i2c *dev = to_hdm(most_iface);
-	int ret;
-
-	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
-
-	if (ch_idx == CH_RX) {
-		/* RX */
-		if (!polling_rate)
-			disable_irq(dev->client->irq);
-		cancel_delayed_work_sync(&dev->rx.dwork);
-		list_add_tail(&mbo->list, &dev->rx.list);
-		if (dev->rx.int_disabled || polling_rate)
-			pending_rx_work(&dev->rx.dwork.work);
-		if (!polling_rate)
-			enable_irq(dev->client->irq);
-	} else {
-		/* TX */
-		ret = i2c_master_send(dev->client, mbo->virt_address,
-				      mbo->buffer_length);
-		if (ret <= 0) {
-			mbo->processed_length = 0;
-			mbo->status = MBO_E_INVAL;
-		} else {
-			mbo->processed_length = mbo->buffer_length;
-			mbo->status = MBO_SUCCESS;
-		}
-		mbo->complete(mbo);
-	}
-
-	return 0;
-}
-
-/**
- * poison_channel - called from MOST core to poison buffers of a channel
- * @most_iface: pointer to the interface the channel to be poisoned belongs to
- * @ch_idx: corresponding channel ID
- *
- * Return 0 on success, negative on failure.
- *
- * If channel direction is RX, complete the buffers in list with
- * status MBO_E_CLOSE
- */
-static int poison_channel(struct most_interface *most_iface,
-			  int ch_idx)
-{
-	struct hdm_i2c *dev = to_hdm(most_iface);
-	struct mbo *mbo;
-
-	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
-
-	if (ch_idx == CH_RX) {
-		if (!polling_rate)
-			free_irq(dev->client->irq, dev);
-		cancel_delayed_work_sync(&dev->rx.dwork);
-
-		while (!list_empty(&dev->rx.list)) {
-			mbo = list_first_mbo(&dev->rx.list);
-			list_del(&mbo->list);
-
-			mbo->processed_length = 0;
-			mbo->status = MBO_E_CLOSE;
-			mbo->complete(mbo);
-		}
-	}
-
-	return 0;
-}
-
-static void do_rx_work(struct hdm_i2c *dev)
-{
-	struct mbo *mbo;
-	unsigned char msg[MAX_BUF_SIZE_CONTROL];
-	int ret;
-	u16 pml, data_size;
-
-	/* Read PML (2 bytes) */
-	ret = i2c_master_recv(dev->client, msg, 2);
-	if (ret <= 0) {
-		pr_err("Failed to receive PML\n");
-		return;
-	}
-
-	pml = (msg[0] << 8) | msg[1];
-	if (!pml)
-		return;
-
-	data_size = pml + 2;
-
-	/* Read the whole message, including PML */
-	ret = i2c_master_recv(dev->client, msg, data_size);
-	if (ret <= 0) {
-		pr_err("Failed to receive a Port Message\n");
-		return;
-	}
-
-	mbo = list_first_mbo(&dev->rx.list);
-	list_del(&mbo->list);
-
-	mbo->processed_length = min(data_size, mbo->buffer_length);
-	memcpy(mbo->virt_address, msg, mbo->processed_length);
-	mbo->status = MBO_SUCCESS;
-	mbo->complete(mbo);
-}
-
-/**
- * pending_rx_work - Read pending messages through I2C
- * @work: definition of this work item
- *
- * Invoked by the Interrupt Service Routine, most_irq_handler()
- */
-static void pending_rx_work(struct work_struct *work)
-{
-	struct hdm_i2c *dev = container_of(work, struct hdm_i2c, rx.dwork.work);
-
-	if (list_empty(&dev->rx.list))
-		return;
-
-	do_rx_work(dev);
-
-	if (polling_rate) {
-		schedule_delayed_work(&dev->rx.dwork, dev->rx.delay);
-	} else {
-		dev->rx.int_disabled = false;
-		enable_irq(dev->client->irq);
-	}
-}
-
-/*
- * most_irq_handler - Interrupt Service Routine
- * @irq: irq number
- * @_dev: private data
- *
- * Schedules a delayed work
- *
- * By default the interrupt line behavior is Active Low. Once an interrupt is
- * generated by the device, until driver clears the interrupt (by reading
- * the PMP message), device keeps the interrupt line in low state. Since i2c
- * read is done in work queue, the interrupt line must be disabled temporarily
- * to avoid ISR being called repeatedly. Re-enable the interrupt in workqueue,
- * after reading the message.
- *
- * Note: If we use the interrupt line in Falling edge mode, there is a
- * possibility to miss interrupts when ISR is getting executed.
- *
- */
-static irqreturn_t most_irq_handler(int irq, void *_dev)
-{
-	struct hdm_i2c *dev = _dev;
-
-	disable_irq_nosync(irq);
-	dev->rx.int_disabled = true;
-	schedule_delayed_work(&dev->rx.dwork, 0);
-
-	return IRQ_HANDLED;
-}
-
-/*
- * i2c_probe - i2c probe handler
- * @client: i2c client device structure
- * @id: i2c client device id
- *
- * Return 0 on success, negative on failure.
- *
- * Register the i2c client device as a MOST interface
- */
-static int i2c_probe(struct i2c_client *client)
-{
-	struct hdm_i2c *dev;
-	int ret, i;
-
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
-
-	/* ID format: i2c-<bus>-<address> */
-	snprintf(dev->name, sizeof(dev->name), "i2c-%d-%04x",
-		 client->adapter->nr, client->addr);
-
-	for (i = 0; i < NUM_CHANNELS; i++) {
-		dev->capabilities[i].data_type = MOST_CH_CONTROL;
-		dev->capabilities[i].num_buffers_packet = MAX_BUFFERS_CONTROL;
-		dev->capabilities[i].buffer_size_packet = MAX_BUF_SIZE_CONTROL;
-	}
-	dev->capabilities[CH_RX].direction = MOST_CH_RX;
-	dev->capabilities[CH_RX].name_suffix = "rx";
-	dev->capabilities[CH_TX].direction = MOST_CH_TX;
-	dev->capabilities[CH_TX].name_suffix = "tx";
-
-	dev->most_iface.interface = ITYPE_I2C;
-	dev->most_iface.description = dev->name;
-	dev->most_iface.num_channels = NUM_CHANNELS;
-	dev->most_iface.channel_vector = dev->capabilities;
-	dev->most_iface.configure = configure_channel;
-	dev->most_iface.enqueue = enqueue;
-	dev->most_iface.poison_channel = poison_channel;
-
-	INIT_LIST_HEAD(&dev->rx.list);
-
-	INIT_DELAYED_WORK(&dev->rx.dwork, pending_rx_work);
-
-	dev->client = client;
-	i2c_set_clientdata(client, dev);
-
-	ret = most_register_interface(&dev->most_iface);
-	if (ret) {
-		pr_err("Failed to register i2c as a MOST interface\n");
-		kfree(dev);
-		return ret;
-	}
-
-	return 0;
-}
-
-/*
- * i2c_remove - i2c remove handler
- * @client: i2c client device structure
- *
- * Return 0 on success.
- *
- * Unregister the i2c client device as a MOST interface
- */
-static void i2c_remove(struct i2c_client *client)
-{
-	struct hdm_i2c *dev = i2c_get_clientdata(client);
-
-	most_deregister_interface(&dev->most_iface);
-	kfree(dev);
-}
-
-static const struct i2c_device_id i2c_id[] = {
-	{ "most_i2c" },
-	{ } /* Terminating entry */
-};
-
-MODULE_DEVICE_TABLE(i2c, i2c_id);
-
-static struct i2c_driver i2c_driver = {
-	.driver = {
-		.name = "hdm_i2c",
-	},
-	.probe = i2c_probe,
-	.remove = i2c_remove,
-	.id_table = i2c_id,
-};
-
-module_i2c_driver(i2c_driver);
-
-MODULE_AUTHOR("Andrey Shvetsov <andrey.shvetsov@k2l.de>");
-MODULE_DESCRIPTION("I2C Hardware Dependent Module");
-MODULE_LICENSE("GPL");
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index b19acd662726..1bd28482e7cb 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -2772,7 +2772,6 @@ static ssize_t target_lu_gp_members_show(struct config_item *item, char *page)
 		cur_len = snprintf(buf, LU_GROUP_NAME_BUF, "%s/%s\n",
 			config_item_name(&hba->hba_group.cg_item),
 			config_item_name(&dev->dev_group.cg_item));
-		cur_len++; /* Extra byte for NULL terminator */
 
 		if ((cur_len + len) > PAGE_SIZE || cur_len > LU_GROUP_NAME_BUF) {
 			pr_warn("Ran out of lu_gp_show_attr"
diff --git a/drivers/target/target_core_stat.c b/drivers/target/target_core_stat.c
index 6bdf2d8bd694..4fdc307ea38b 100644
--- a/drivers/target/target_core_stat.c
+++ b/drivers/target/target_core_stat.c
@@ -282,7 +282,7 @@ static ssize_t target_stat_lu_num_cmds_show(struct config_item *item,
 	struct se_device *dev = to_stat_lu_dev(item);
 	struct se_dev_io_stats *stats;
 	unsigned int cpu;
-	u32 cmds = 0;
+	u64 cmds = 0;
 
 	for_each_possible_cpu(cpu) {
 		stats = per_cpu_ptr(dev->stats, cpu);
@@ -290,7 +290,7 @@ static ssize_t target_stat_lu_num_cmds_show(struct config_item *item,
 	}
 
 	/* scsiLuNumCommands */
-	return snprintf(page, PAGE_SIZE, "%u\n", cmds);
+	return snprintf(page, PAGE_SIZE, "%llu\n", cmds);
 }
 
 static ssize_t target_stat_lu_read_mbytes_show(struct config_item *item,
@@ -299,7 +299,7 @@ static ssize_t target_stat_lu_read_mbytes_show(struct config_item *item,
 	struct se_device *dev = to_stat_lu_dev(item);
 	struct se_dev_io_stats *stats;
 	unsigned int cpu;
-	u32 bytes = 0;
+	u64 bytes = 0;
 
 	for_each_possible_cpu(cpu) {
 		stats = per_cpu_ptr(dev->stats, cpu);
@@ -307,7 +307,7 @@ static ssize_t target_stat_lu_read_mbytes_show(struct config_item *item,
 	}
 
 	/* scsiLuReadMegaBytes */
-	return snprintf(page, PAGE_SIZE, "%u\n", bytes >> 20);
+	return snprintf(page, PAGE_SIZE, "%llu\n", bytes >> 20);
 }
 
 static ssize_t target_stat_lu_write_mbytes_show(struct config_item *item,
@@ -316,7 +316,7 @@ static ssize_t target_stat_lu_write_mbytes_show(struct config_item *item,
 	struct se_device *dev = to_stat_lu_dev(item);
 	struct se_dev_io_stats *stats;
 	unsigned int cpu;
-	u32 bytes = 0;
+	u64 bytes = 0;
 
 	for_each_possible_cpu(cpu) {
 		stats = per_cpu_ptr(dev->stats, cpu);
@@ -324,7 +324,7 @@ static ssize_t target_stat_lu_write_mbytes_show(struct config_item *item,
 	}
 
 	/* scsiLuWrittenMegaBytes */
-	return snprintf(page, PAGE_SIZE, "%u\n", bytes >> 20);
+	return snprintf(page, PAGE_SIZE, "%llu\n", bytes >> 20);
 }
 
 static ssize_t target_stat_lu_resets_show(struct config_item *item, char *page)
@@ -1044,7 +1044,7 @@ static ssize_t target_stat_auth_num_cmds_show(struct config_item *item,
 	struct se_dev_entry *deve;
 	unsigned int cpu;
 	ssize_t ret;
-	u32 cmds = 0;
+	u64 cmds = 0;
 
 	rcu_read_lock();
 	deve = target_nacl_find_deve(nacl, lacl->mapped_lun);
@@ -1059,7 +1059,7 @@ static ssize_t target_stat_auth_num_cmds_show(struct config_item *item,
 	}
 
 	/* scsiAuthIntrOutCommands */
-	ret = snprintf(page, PAGE_SIZE, "%u\n", cmds);
+	ret = snprintf(page, PAGE_SIZE, "%llu\n", cmds);
 	rcu_read_unlock();
 	return ret;
 }
@@ -1073,7 +1073,7 @@ static ssize_t target_stat_auth_read_mbytes_show(struct config_item *item,
 	struct se_dev_entry *deve;
 	unsigned int cpu;
 	ssize_t ret;
-	u32 bytes = 0;
+	u64 bytes = 0;
 
 	rcu_read_lock();
 	deve = target_nacl_find_deve(nacl, lacl->mapped_lun);
@@ -1088,7 +1088,7 @@ static ssize_t target_stat_auth_read_mbytes_show(struct config_item *item,
 	}
 
 	/* scsiAuthIntrReadMegaBytes */
-	ret = snprintf(page, PAGE_SIZE, "%u\n", bytes >> 20);
+	ret = snprintf(page, PAGE_SIZE, "%llu\n", bytes >> 20);
 	rcu_read_unlock();
 	return ret;
 }
@@ -1102,7 +1102,7 @@ static ssize_t target_stat_auth_write_mbytes_show(struct config_item *item,
 	struct se_dev_entry *deve;
 	unsigned int cpu;
 	ssize_t ret;
-	u32 bytes = 0;
+	u64 bytes = 0;
 
 	rcu_read_lock();
 	deve = target_nacl_find_deve(nacl, lacl->mapped_lun);
@@ -1117,7 +1117,7 @@ static ssize_t target_stat_auth_write_mbytes_show(struct config_item *item,
 	}
 
 	/* scsiAuthIntrWrittenMegaBytes */
-	ret = snprintf(page, PAGE_SIZE, "%u\n", bytes >> 20);
+	ret = snprintf(page, PAGE_SIZE, "%llu\n", bytes >> 20);
 	rcu_read_unlock();
 	return ret;
 }
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 500dfc009d03..90e2ea1e8afe 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2697,8 +2697,22 @@ static void imx_uart_save_context(struct imx_port *sport)
 /* called with irq off */
 static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 {
+	struct tty_port *port = &sport->port.state->port;
+	struct device *tty_dev;
+	bool may_wake = false;
 	u32 ucr3;
 
+	scoped_guard(tty_port_tty, port) {
+		struct tty_struct *tty = scoped_tty();
+
+		tty_dev = tty->dev;
+		may_wake = tty_dev && device_may_wakeup(tty_dev);
+	}
+
+	/* only configure the wake register when device set as wakeup source */
+	if (!may_wake)
+		return;
+
 	uart_port_lock_irq(&sport->port);
 
 	ucr3 = imx_uart_readl(sport, UCR3);
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index d0a2c963a27d..1f0d38aa37f9 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -6,6 +6,8 @@
 #include <linux/pm_runtime.h>
 #include <ufs/ufshcd.h>
 
+void ufshcd_enable_intr(struct ufs_hba *hba, u32 intrs);
+
 static inline bool ufshcd_is_user_access_allowed(struct ufs_hba *hba)
 {
 	return !hba->shutting_down;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f69a23726235..9331ee359905 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3831,7 +3831,7 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
 		str[ret++] = '\0';
 
 	} else {
-		str = kmemdup(uc_str, uc_str->len, GFP_KERNEL);
+		str = kmemdup(uc_str->uc, uc_str->len, GFP_KERNEL);
 		if (!str) {
 			ret = -ENOMEM;
 			goto out;
diff --git a/drivers/ufs/host/ufs-rockchip.c b/drivers/ufs/host/ufs-rockchip.c
index 8754085dd0cc..8cecb28cdce4 100644
--- a/drivers/ufs/host/ufs-rockchip.c
+++ b/drivers/ufs/host/ufs-rockchip.c
@@ -20,9 +20,17 @@
 #include "ufshcd-pltfrm.h"
 #include "ufs-rockchip.h"
 
+static void ufs_rockchip_controller_reset(struct ufs_rockchip_host *host)
+{
+	reset_control_assert(host->rst);
+	udelay(1);
+	reset_control_deassert(host->rst);
+}
+
 static int ufs_rockchip_hce_enable_notify(struct ufs_hba *hba,
 					 enum ufs_notify_change_status status)
 {
+	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
 	int err = 0;
 
 	if (status == POST_CHANGE) {
@@ -37,6 +45,9 @@ static int ufs_rockchip_hce_enable_notify(struct ufs_hba *hba,
 		return ufshcd_vops_phy_initialization(hba);
 	}
 
+	/* PRE_CHANGE */
+	ufs_rockchip_controller_reset(host);
+
 	return 0;
 }
 
@@ -156,9 +167,7 @@ static int ufs_rockchip_common_init(struct ufs_hba *hba)
 		return dev_err_probe(dev, PTR_ERR(host->rst),
 				"failed to get reset control\n");
 
-	reset_control_assert(host->rst);
-	udelay(1);
-	reset_control_deassert(host->rst);
+	ufs_rockchip_controller_reset(host);
 
 	host->ref_out_clk = devm_clk_get_enabled(dev, "ref_out");
 	if (IS_ERR(host->ref_out_clk))
@@ -282,9 +291,7 @@ static int ufs_rockchip_runtime_resume(struct device *dev)
 		return err;
 	}
 
-	reset_control_assert(host->rst);
-	udelay(1);
-	reset_control_deassert(host->rst);
+	ufs_rockchip_controller_reset(host);
 
 	return ufshcd_runtime_resume(dev);
 }
diff --git a/drivers/uio/uio_fsl_elbc_gpcm.c b/drivers/uio/uio_fsl_elbc_gpcm.c
index 81454c3e2484..338dd2aaabc8 100644
--- a/drivers/uio/uio_fsl_elbc_gpcm.c
+++ b/drivers/uio/uio_fsl_elbc_gpcm.c
@@ -384,6 +384,11 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 
 	/* set all UIO data */
 	info->mem[0].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn", node);
+	if (!info->mem[0].name) {
+		ret = -ENODEV;
+		goto out_err3;
+	}
+
 	info->mem[0].addr = res.start;
 	info->mem[0].size = resource_size(&res);
 	info->mem[0].memtype = UIO_MEM_PHYS;
@@ -423,6 +428,8 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 out_err2:
 	if (priv->shutdown)
 		priv->shutdown(info, true);
+
+out_err3:
 	iounmap(info->mem[0].internal_addr);
 	return ret;
 }
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index d2b2787be409..6138468c67c4 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2431,7 +2431,7 @@ int cdc_parse_cdc_header(struct usb_cdc_parsed_header *hdr,
 			break;
 		case USB_CDC_MBIM_EXTENDED_TYPE:
 			if (elength < sizeof(struct usb_cdc_mbim_extended_desc))
-				break;
+				goto next_desc;
 			hdr->usb_cdc_mbim_extended_desc =
 				(struct usb_cdc_mbim_extended_desc *)buffer;
 			break;
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 3f83ecc9fc23..ef0d73077034 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -369,11 +369,11 @@ static void dwc2_driver_shutdown(struct platform_device *dev)
 {
 	struct dwc2_hsotg *hsotg = platform_get_drvdata(dev);
 
-	dwc2_disable_global_interrupts(hsotg);
-	synchronize_irq(hsotg->irq);
-
-	if (hsotg->ll_hw_enabled)
+	if (hsotg->ll_hw_enabled) {
+		dwc2_disable_global_interrupts(hsotg);
+		synchronize_irq(hsotg->irq);
 		dwc2_lowlevel_hw_disable(hsotg);
+	}
 }
 
 /**
@@ -649,9 +649,13 @@ static int dwc2_driver_probe(struct platform_device *dev)
 static int __maybe_unused dwc2_suspend(struct device *dev)
 {
 	struct dwc2_hsotg *dwc2 = dev_get_drvdata(dev);
-	bool is_device_mode = dwc2_is_device_mode(dwc2);
+	bool is_device_mode;
 	int ret = 0;
 
+	if (!dwc2->ll_hw_enabled)
+		return 0;
+
+	is_device_mode = dwc2_is_device_mode(dwc2);
 	if (is_device_mode)
 		dwc2_hsotg_suspend(dwc2);
 
@@ -728,6 +732,9 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 	struct dwc2_hsotg *dwc2 = dev_get_drvdata(dev);
 	int ret = 0;
 
+	if (!dwc2->ll_hw_enabled)
+		return 0;
+
 	if (dwc2->phy_off_for_suspend && dwc2->ll_hw_enabled) {
 		ret = __dwc2_lowlevel_hw_enable(dwc2);
 		if (ret)
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 1c513bf8002e..e77fd86d09cf 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -37,7 +37,10 @@ static void dwc3_power_off_all_roothub_ports(struct dwc3 *dwc)
 
 	/* xhci regs are not mapped yet, do it temporarily here */
 	if (dwc->xhci_resources[0].start) {
-		xhci_regs = ioremap(dwc->xhci_resources[0].start, DWC3_XHCI_REGS_END);
+		if (dwc->xhci_resources[0].flags & IORESOURCE_MEM_NONPOSTED)
+			xhci_regs = ioremap_np(dwc->xhci_resources[0].start, DWC3_XHCI_REGS_END);
+		else
+			xhci_regs = ioremap(dwc->xhci_resources[0].start, DWC3_XHCI_REGS_END);
 		if (!xhci_regs) {
 			dev_err(dwc->dev, "Failed to ioremap xhci_regs\n");
 			return;
diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index b71680c58de6..46f343ba48b3 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -40,6 +40,7 @@ MODULE_LICENSE("GPL");
 
 static DEFINE_IDA(driver_id_numbers);
 #define DRIVER_DRIVER_NAME_LENGTH_MAX	32
+#define USB_RAW_IO_LENGTH_MAX KMALLOC_MAX_SIZE
 
 #define RAW_EVENT_QUEUE_SIZE	16
 
@@ -667,6 +668,8 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *io, void __user *ptr,
 		return ERR_PTR(-EINVAL);
 	if (!usb_raw_io_flags_valid(io->flags))
 		return ERR_PTR(-EINVAL);
+	if (io->length > USB_RAW_IO_LENGTH_MAX)
+		return ERR_PTR(-EINVAL);
 	if (get_from_user)
 		data = memdup_user(ptr + sizeof(*io), io->length);
 	else {
diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 1d3085cc9d22..37bbf2362c1c 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -1559,12 +1559,6 @@ static int __tegra_xudc_ep_set_halt(struct tegra_xudc_ep *ep, bool halt)
 		return -ENOTSUPP;
 	}
 
-	if (!!(xudc_readl(xudc, EP_HALT) & BIT(ep->index)) == halt) {
-		dev_dbg(xudc->dev, "EP %u already %s\n", ep->index,
-			halt ? "halted" : "not halted");
-		return 0;
-	}
-
 	if (halt) {
 		ep_halt(xudc, ep->index);
 	} else {
diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index 225863321dc4..45cff32656c6 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -444,9 +444,19 @@ static ssize_t chaoskey_read(struct file *file,
 			goto bail;
 		mutex_unlock(&dev->rng_lock);
 
-		result = mutex_lock_interruptible(&dev->lock);
-		if (result)
-			goto bail;
+		if (file->f_flags & O_NONBLOCK) {
+			result = mutex_trylock(&dev->lock);
+			if (result == 0) {
+				result = -EAGAIN;
+				goto bail;
+			} else {
+				result = 0;
+			}
+		} else {
+			result = mutex_lock_interruptible(&dev->lock);
+			if (result)
+				goto bail;
+		}
 		if (dev->valid == dev->used) {
 			result = _chaoskey_fill(dev);
 			if (result < 0) {
diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index e1435bc59662..5a9b9353f343 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -646,6 +646,8 @@ int usb_add_phy(struct usb_phy *x, enum usb_phy_type type)
 		return -EINVAL;
 	}
 
+	INIT_LIST_HEAD(&x->head);
+
 	usb_charger_init(x);
 	ret = usb_add_extcon(x);
 	if (ret)
@@ -696,6 +698,8 @@ int usb_add_phy_dev(struct usb_phy *x)
 		return -EINVAL;
 	}
 
+	INIT_LIST_HEAD(&x->head);
+
 	usb_charger_init(x);
 	ret = usb_add_extcon(x);
 	if (ret)
diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
index 7b5222081bbb..c5965656baba 100644
--- a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
+++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
@@ -196,6 +196,7 @@ static void gaokun_ucsi_connector_status(struct ucsi_connector *con)
 const struct ucsi_operations gaokun_ucsi_ops = {
 	.read_version = gaokun_ucsi_read_version,
 	.read_cci = gaokun_ucsi_read_cci,
+	.poll_cci = gaokun_ucsi_read_cci,
 	.read_message_in = gaokun_ucsi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = gaokun_ucsi_async_control,
@@ -502,6 +503,7 @@ static void gaokun_ucsi_remove(struct auxiliary_device *adev)
 {
 	struct gaokun_ucsi *uec = auxiliary_get_drvdata(adev);
 
+	disable_delayed_work_sync(&uec->work);
 	gaokun_ec_unregister_notify(uec->ec, &uec->nb);
 	ucsi_unregister(uec->ucsi);
 	ucsi_destroy(uec->ucsi);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 53cc9ef01e9f..ab626f7c8117 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1256,7 +1256,7 @@ static int query_virtqueues(struct mlx5_vdpa_net *ndev,
 		int vq_idx = start_vq + i;
 
 		if (cmd->err) {
-			mlx5_vdpa_err(mvdev, "query vq %d failed, err: %d\n", vq_idx, err);
+			mlx5_vdpa_err(mvdev, "query vq %d failed, err: %d\n", vq_idx, cmd->err);
 			if (!err)
 				err = cmd->err;
 			continue;
diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 301d95e08596..a1eff7441450 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -51,7 +51,7 @@ static int pds_vdpa_register_event_handler(struct pds_vdpa_device *pdsv)
 		err = pdsc_register_notify(nb);
 		if (err) {
 			nb->notifier_call = NULL;
-			dev_err(dev, "failed to register pds event handler: %ps\n",
+			dev_err(dev, "failed to register pds event handler: %pe\n",
 				ERR_PTR(err));
 			return -EINVAL;
 		}
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 7dcf5439dedc..5efe7535f41e 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -41,6 +41,40 @@ static bool nointxmask;
 static bool disable_vga;
 static bool disable_idle_d3;
 
+static void vfio_pci_eventfd_rcu_free(struct rcu_head *rcu)
+{
+	struct vfio_pci_eventfd *eventfd =
+		container_of(rcu, struct vfio_pci_eventfd, rcu);
+
+	eventfd_ctx_put(eventfd->ctx);
+	kfree(eventfd);
+}
+
+int vfio_pci_eventfd_replace_locked(struct vfio_pci_core_device *vdev,
+				    struct vfio_pci_eventfd __rcu **peventfd,
+				    struct eventfd_ctx *ctx)
+{
+	struct vfio_pci_eventfd *new = NULL;
+	struct vfio_pci_eventfd *old;
+
+	lockdep_assert_held(&vdev->igate);
+
+	if (ctx) {
+		new = kzalloc(sizeof(*new), GFP_KERNEL_ACCOUNT);
+		if (!new)
+			return -ENOMEM;
+
+		new->ctx = ctx;
+	}
+
+	old = rcu_replace_pointer(*peventfd, new,
+				  lockdep_is_held(&vdev->igate));
+	if (old)
+		call_rcu(&old->rcu, vfio_pci_eventfd_rcu_free);
+
+	return 0;
+}
+
 /* List of PF's that vfio_pci_core_sriov_configure() has been called on */
 static DEFINE_MUTEX(vfio_pci_sriov_pfs_mutex);
 static LIST_HEAD(vfio_pci_sriov_pfs);
@@ -696,14 +730,8 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 	vfio_pci_core_disable(vdev);
 
 	mutex_lock(&vdev->igate);
-	if (vdev->err_trigger) {
-		eventfd_ctx_put(vdev->err_trigger);
-		vdev->err_trigger = NULL;
-	}
-	if (vdev->req_trigger) {
-		eventfd_ctx_put(vdev->req_trigger);
-		vdev->req_trigger = NULL;
-	}
+	vfio_pci_eventfd_replace_locked(vdev, &vdev->err_trigger, NULL);
+	vfio_pci_eventfd_replace_locked(vdev, &vdev->req_trigger, NULL);
 	mutex_unlock(&vdev->igate);
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_close_device);
@@ -1800,21 +1828,21 @@ void vfio_pci_core_request(struct vfio_device *core_vdev, unsigned int count)
 	struct vfio_pci_core_device *vdev =
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
 	struct pci_dev *pdev = vdev->pdev;
+	struct vfio_pci_eventfd *eventfd;
 
-	mutex_lock(&vdev->igate);
-
-	if (vdev->req_trigger) {
+	rcu_read_lock();
+	eventfd = rcu_dereference(vdev->req_trigger);
+	if (eventfd) {
 		if (!(count % 10))
 			pci_notice_ratelimited(pdev,
 				"Relaying device request to user (#%u)\n",
 				count);
-		eventfd_signal(vdev->req_trigger);
+		eventfd_signal(eventfd->ctx);
 	} else if (count == 0) {
 		pci_warn(pdev,
 			"No device request channel registered, blocked until released by user\n");
 	}
-
-	mutex_unlock(&vdev->igate);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_request);
 
@@ -2227,13 +2255,13 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 						pci_channel_state_t state)
 {
 	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+	struct vfio_pci_eventfd *eventfd;
 
-	mutex_lock(&vdev->igate);
-
-	if (vdev->err_trigger)
-		eventfd_signal(vdev->err_trigger);
-
-	mutex_unlock(&vdev->igate);
+	rcu_read_lock();
+	eventfd = rcu_dereference(vdev->err_trigger);
+	if (eventfd)
+		eventfd_signal(eventfd->ctx);
+	rcu_read_unlock();
 
 	return PCI_ERS_RESULT_CAN_RECOVER;
 }
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 61d29f6b3730..969e9342f9b1 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -731,21 +731,27 @@ static int vfio_pci_set_msi_trigger(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
-static int vfio_pci_set_ctx_trigger_single(struct eventfd_ctx **ctx,
+static int vfio_pci_set_ctx_trigger_single(struct vfio_pci_core_device *vdev,
+					   struct vfio_pci_eventfd __rcu **peventfd,
 					   unsigned int count, uint32_t flags,
 					   void *data)
 {
 	/* DATA_NONE/DATA_BOOL enables loopback testing */
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
-		if (*ctx) {
-			if (count) {
-				eventfd_signal(*ctx);
-			} else {
-				eventfd_ctx_put(*ctx);
-				*ctx = NULL;
-			}
+		struct vfio_pci_eventfd *eventfd;
+
+		eventfd = rcu_dereference_protected(*peventfd,
+						lockdep_is_held(&vdev->igate));
+
+		if (!eventfd)
+			return -EINVAL;
+
+		if (count) {
+			eventfd_signal(eventfd->ctx);
 			return 0;
 		}
+
+		return vfio_pci_eventfd_replace_locked(vdev, peventfd, NULL);
 	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
 		uint8_t trigger;
 
@@ -753,8 +759,15 @@ static int vfio_pci_set_ctx_trigger_single(struct eventfd_ctx **ctx,
 			return -EINVAL;
 
 		trigger = *(uint8_t *)data;
-		if (trigger && *ctx)
-			eventfd_signal(*ctx);
+
+		if (trigger) {
+			struct vfio_pci_eventfd *eventfd =
+					rcu_dereference_protected(*peventfd,
+					lockdep_is_held(&vdev->igate));
+
+			if (eventfd)
+				eventfd_signal(eventfd->ctx);
+		}
 
 		return 0;
 	} else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
@@ -765,22 +778,23 @@ static int vfio_pci_set_ctx_trigger_single(struct eventfd_ctx **ctx,
 
 		fd = *(int32_t *)data;
 		if (fd == -1) {
-			if (*ctx)
-				eventfd_ctx_put(*ctx);
-			*ctx = NULL;
+			return vfio_pci_eventfd_replace_locked(vdev,
+							       peventfd, NULL);
 		} else if (fd >= 0) {
 			struct eventfd_ctx *efdctx;
+			int ret;
 
 			efdctx = eventfd_ctx_fdget(fd);
 			if (IS_ERR(efdctx))
 				return PTR_ERR(efdctx);
 
-			if (*ctx)
-				eventfd_ctx_put(*ctx);
+			ret = vfio_pci_eventfd_replace_locked(vdev,
+							      peventfd, efdctx);
+			if (ret)
+				eventfd_ctx_put(efdctx);
 
-			*ctx = efdctx;
+			return ret;
 		}
-		return 0;
 	}
 
 	return -EINVAL;
@@ -793,7 +807,7 @@ static int vfio_pci_set_err_trigger(struct vfio_pci_core_device *vdev,
 	if (index != VFIO_PCI_ERR_IRQ_INDEX || start != 0 || count > 1)
 		return -EINVAL;
 
-	return vfio_pci_set_ctx_trigger_single(&vdev->err_trigger,
+	return vfio_pci_set_ctx_trigger_single(vdev, &vdev->err_trigger,
 					       count, flags, data);
 }
 
@@ -804,7 +818,7 @@ static int vfio_pci_set_req_trigger(struct vfio_pci_core_device *vdev,
 	if (index != VFIO_PCI_REQ_IRQ_INDEX || start != 0 || count > 1)
 		return -EINVAL;
 
-	return vfio_pci_set_ctx_trigger_single(&vdev->req_trigger,
+	return vfio_pci_set_ctx_trigger_single(vdev, &vdev->req_trigger,
 					       count, flags, data);
 }
 
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index a9972eacb293..97d992c06322 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -26,6 +26,10 @@ struct vfio_pci_ioeventfd {
 bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
 void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev);
 
+int vfio_pci_eventfd_replace_locked(struct vfio_pci_core_device *vdev,
+				    struct vfio_pci_eventfd __rcu **peventfd,
+				    struct eventfd_ctx *ctx);
+
 int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
 			    unsigned index, unsigned start, unsigned count,
 			    void *data);
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 8f7f50acb6d6..1e77c0482b84 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -69,7 +69,7 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
 
 #define VHOST_DMA_IS_DONE(len) ((__force u32)(len) >= (__force u32)VHOST_DMA_DONE_LEN)
 
-static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
+static const u64 vhost_net_features[VIRTIO_FEATURES_U64S] = {
 	VHOST_FEATURES |
 	(1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 	(1ULL << VIRTIO_NET_F_MRG_RXBUF) |
@@ -1731,7 +1731,7 @@ static long vhost_net_set_owner(struct vhost_net *n)
 static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			    unsigned long arg)
 {
-	u64 all_features[VIRTIO_FEATURES_DWORDS];
+	u64 all_features[VIRTIO_FEATURES_U64S];
 	struct vhost_net *n = f->private_data;
 	void __user *argp = (void __user *)arg;
 	u64 __user *featurep = argp;
@@ -1763,7 +1763,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 
 		/* Copy the net features, up to the user-provided buffer size */
 		argp += sizeof(u64);
-		copied = min(count, VIRTIO_FEATURES_DWORDS);
+		copied = min(count, (u64)VIRTIO_FEATURES_U64S);
 		if (copy_to_user(argp, vhost_net_features,
 				 copied * sizeof(u64)))
 			return -EFAULT;
@@ -1778,13 +1778,13 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 
 		virtio_features_zero(all_features);
 		argp += sizeof(u64);
-		copied = min(count, VIRTIO_FEATURES_DWORDS);
+		copied = min(count, (u64)VIRTIO_FEATURES_U64S);
 		if (copy_from_user(all_features, argp, copied * sizeof(u64)))
 			return -EFAULT;
 
 		/*
 		 * Any feature specified by user-space above
-		 * VIRTIO_FEATURES_MAX is not supported by definition.
+		 * VIRTIO_FEATURES_BITS is not supported by definition.
 		 */
 		for (i = copied; i < count; ++i) {
 			if (copy_from_user(&features, featurep + 1 + i,
@@ -1794,7 +1794,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 				return -EOPNOTSUPP;
 		}
 
-		for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++)
+		for (i = 0; i < VIRTIO_FEATURES_U64S; i++)
 			if (all_features[i] & ~vhost_net_features[i])
 				return -EOPNOTSUPP;
 
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a78226b37739..bccdc9eab267 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -804,11 +804,13 @@ static int vhost_kthread_worker_create(struct vhost_worker *worker,
 
 	ret = vhost_attach_task_to_cgroups(worker);
 	if (ret)
-		goto stop_worker;
+		goto free_id;
 
 	worker->id = id;
 	return 0;
 
+free_id:
+	xa_erase(&dev->worker_xa, id);
 stop_worker:
 	vhost_kthread_do_stop(worker);
 	return ret;
diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index d2db157b2c29..0ed585eb2790 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -209,6 +209,19 @@ static int led_bl_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->bl_dev);
 	}
 
+	for (i = 0; i < priv->nb_leds; i++) {
+		struct device_link *link;
+
+		link = device_link_add(&pdev->dev, priv->leds[i]->dev->parent,
+				       DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (!link) {
+			dev_err(&pdev->dev, "Failed to add devlink (consumer %s, supplier %s)\n",
+				dev_name(&pdev->dev), dev_name(priv->leds[i]->dev->parent));
+			backlight_device_unregister(priv->bl_dev);
+			return -EINVAL;
+		}
+	}
+
 	for (i = 0; i < priv->nb_leds; i++) {
 		mutex_lock(&priv->leds[i]->led_access);
 		led_sysfs_disable(priv->leds[i]);
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index aa6cc0a8151a..83dd31fa1fab 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -680,7 +680,7 @@ static int ssd1307fb_probe(struct i2c_client *client)
 	if (!ssd1307fb_defio) {
 		dev_err(dev, "Couldn't allocate deferred io.\n");
 		ret = -ENOMEM;
-		goto fb_alloc_error;
+		goto fb_defio_error;
 	}
 
 	ssd1307fb_defio->delay = HZ / refreshrate;
@@ -757,6 +757,8 @@ static int ssd1307fb_probe(struct i2c_client *client)
 		regulator_disable(par->vbat_reg);
 reset_oled_error:
 	fb_deferred_io_cleanup(info);
+fb_defio_error:
+	__free_pages(vmem, get_order(vmem_size));
 fb_alloc_error:
 	framebuffer_release(info);
 	return ret;
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a09eb4d62f82..5bdc6b82b30b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -53,7 +53,7 @@ static ssize_t features_show(struct device *_d,
 
 	/* We actually represent this as a bitstring, as it could be
 	 * arbitrary length in future. */
-	for (i = 0; i < VIRTIO_FEATURES_MAX; i++)
+	for (i = 0; i < VIRTIO_FEATURES_BITS; i++)
 		len += sysfs_emit_at(buf, len, "%c",
 			       __virtio_test_bit(dev, i) ? '1' : '0');
 	len += sysfs_emit_at(buf, len, "\n");
@@ -272,8 +272,8 @@ static int virtio_dev_probe(struct device *_d)
 	int err, i;
 	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
-	u64 device_features[VIRTIO_FEATURES_DWORDS];
-	u64 driver_features[VIRTIO_FEATURES_DWORDS];
+	u64 device_features[VIRTIO_FEATURES_U64S];
+	u64 driver_features[VIRTIO_FEATURES_U64S];
 	u64 driver_features_legacy;
 
 	/* We have a driver! */
@@ -286,7 +286,7 @@ static int virtio_dev_probe(struct device *_d)
 	virtio_features_zero(driver_features);
 	for (i = 0; i < drv->feature_table_size; i++) {
 		unsigned int f = drv->feature_table[i];
-		if (!WARN_ON_ONCE(f >= VIRTIO_FEATURES_MAX))
+		if (!WARN_ON_ONCE(f >= VIRTIO_FEATURES_BITS))
 			virtio_features_set_bit(driver_features, f);
 	}
 
@@ -303,7 +303,7 @@ static int virtio_dev_probe(struct device *_d)
 	}
 
 	if (virtio_features_test_bit(device_features, VIRTIO_F_VERSION_1)) {
-		for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i)
+		for (i = 0; i < VIRTIO_FEATURES_U64S; ++i)
 			dev->features_array[i] = driver_features[i] &
 						 device_features[i];
 	} else {
@@ -325,7 +325,7 @@ static int virtio_dev_probe(struct device *_d)
 		goto err;
 
 	if (drv->validate) {
-		u64 features[VIRTIO_FEATURES_DWORDS];
+		u64 features[VIRTIO_FEATURES_U64S];
 
 		virtio_features_copy(features, dev->features_array);
 		err = drv->validate(dev);
diff --git a/drivers/virtio/virtio_debug.c b/drivers/virtio/virtio_debug.c
index d58713ddf2e5..ccf1955a1183 100644
--- a/drivers/virtio/virtio_debug.c
+++ b/drivers/virtio/virtio_debug.c
@@ -8,12 +8,12 @@ static struct dentry *virtio_debugfs_dir;
 
 static int virtio_debug_device_features_show(struct seq_file *s, void *data)
 {
-	u64 device_features[VIRTIO_FEATURES_DWORDS];
+	u64 device_features[VIRTIO_FEATURES_U64S];
 	struct virtio_device *dev = s->private;
 	unsigned int i;
 
 	virtio_get_features(dev, device_features);
-	for (i = 0; i < VIRTIO_FEATURES_MAX; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS; i++) {
 		if (virtio_features_test_bit(device_features, i))
 			seq_printf(s, "%u\n", i);
 	}
@@ -26,7 +26,7 @@ static int virtio_debug_filter_features_show(struct seq_file *s, void *data)
 	struct virtio_device *dev = s->private;
 	unsigned int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_MAX; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS; i++) {
 		if (virtio_features_test_bit(dev->debugfs_filter_features, i))
 			seq_printf(s, "%u\n", i);
 	}
@@ -50,7 +50,7 @@ static int virtio_debug_filter_feature_add(void *data, u64 val)
 {
 	struct virtio_device *dev = data;
 
-	if (val >= VIRTIO_FEATURES_MAX)
+	if (val >= VIRTIO_FEATURES_BITS)
 		return -EINVAL;
 
 	virtio_features_set_bit(dev->debugfs_filter_features, val);
@@ -64,7 +64,7 @@ static int virtio_debug_filter_feature_del(void *data, u64 val)
 {
 	struct virtio_device *dev = data;
 
-	if (val >= VIRTIO_FEATURES_MAX)
+	if (val >= VIRTIO_FEATURES_BITS)
 		return -EINVAL;
 
 	virtio_features_clear_bit(dev->debugfs_filter_features, val);
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 9e503b7a58d8..413a8c353463 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -401,7 +401,7 @@ void vp_modern_get_extended_features(struct virtio_pci_modern_device *mdev,
 	int i;
 
 	virtio_features_zero(features);
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
 		u64 cur;
 
 		vp_iowrite32(i, &cfg->device_feature_select);
@@ -427,7 +427,7 @@ vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
 	int i;
 
 	virtio_features_zero(features);
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
 		u64 cur;
 
 		vp_iowrite32(i, &cfg->guest_feature_select);
@@ -448,7 +448,7 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
 		u32 cur = features[i >> 1] >> (32 * (i & 1));
 
 		vp_iowrite32(i, &cfg->guest_feature_select);
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 657b07a60788..1abecaf76465 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -80,7 +80,7 @@ static void virtio_vdpa_set_status(struct virtio_device *vdev, u8 status)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 
-	return vdpa_set_status(vdpa, status);
+	vdpa_set_status(vdpa, status);
 }
 
 static void virtio_vdpa_reset(struct virtio_device *vdev)
diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 355918d62f63..ed71d3960a0f 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -500,12 +500,14 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 		if (pm_runtime_enabled(&pdev->dev)) {
 			ret = pm_runtime_put_sync(&pdev->dev);
 			if (ret)
-				goto err_exit;
+				goto err_unregister_wdt;
 		}
 	}
 
 	return 0;
 
+err_unregister_wdt:
+	watchdog_unregister_device(&wdt->wdd);
 err_exit:
 	starfive_wdt_disable_clock(wdt);
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 650fdc7996e1..dd3c2d69c9df 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -326,19 +326,27 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	wdat = devm_kzalloc(dev, sizeof(*wdat), GFP_KERNEL);
-	if (!wdat)
-		return -ENOMEM;
+	if (!wdat) {
+		ret = -ENOMEM;
+		goto out_put_table;
+	}
 
 	regs = devm_kcalloc(dev, pdev->num_resources, sizeof(*regs),
 			    GFP_KERNEL);
-	if (!regs)
-		return -ENOMEM;
+	if (!regs) {
+		ret = -ENOMEM;
+		goto out_put_table;
+	}
 
 	/* WDAT specification wants to have >= 1ms period */
-	if (tbl->timer_period < 1)
-		return -EINVAL;
-	if (tbl->min_count > tbl->max_count)
-		return -EINVAL;
+	if (tbl->timer_period < 1) {
+		ret = -EINVAL;
+		goto out_put_table;
+	}
+	if (tbl->min_count > tbl->max_count) {
+		ret = -EINVAL;
+		goto out_put_table;
+	}
 
 	wdat->period = tbl->timer_period;
 	wdat->wdd.min_timeout = DIV_ROUND_UP(wdat->period * tbl->min_count, 1000);
@@ -355,15 +363,20 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 		res = &pdev->resource[i];
 		if (resource_type(res) == IORESOURCE_MEM) {
 			reg = devm_ioremap_resource(dev, res);
-			if (IS_ERR(reg))
-				return PTR_ERR(reg);
+			if (IS_ERR(reg)) {
+				ret = PTR_ERR(reg);
+				goto out_put_table;
+			}
 		} else if (resource_type(res) == IORESOURCE_IO) {
 			reg = devm_ioport_map(dev, res->start, 1);
-			if (!reg)
-				return -ENOMEM;
+			if (!reg) {
+				ret = -ENOMEM;
+				goto out_put_table;
+			}
 		} else {
 			dev_err(dev, "Unsupported resource\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out_put_table;
 		}
 
 		regs[i] = reg;
@@ -385,8 +398,10 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 		}
 
 		instr = devm_kzalloc(dev, sizeof(*instr), GFP_KERNEL);
-		if (!instr)
-			return -ENOMEM;
+		if (!instr) {
+			ret = -ENOMEM;
+			goto out_put_table;
+		}
 
 		INIT_LIST_HEAD(&instr->node);
 		instr->entry = entries[i];
@@ -417,7 +432,8 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 
 		if (!instr->reg) {
 			dev_err(dev, "I/O resource not found\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out_put_table;
 		}
 
 		instructions = wdat->instructions[action];
@@ -425,8 +441,10 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 			instructions = devm_kzalloc(dev,
 						    sizeof(*instructions),
 						    GFP_KERNEL);
-			if (!instructions)
-				return -ENOMEM;
+			if (!instructions) {
+				ret = -ENOMEM;
+				goto out_put_table;
+			}
 
 			INIT_LIST_HEAD(instructions);
 			wdat->instructions[action] = instructions;
@@ -443,7 +461,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 
 	ret = wdat_wdt_enable_reboot(wdat);
 	if (ret)
-		return ret;
+		goto out_put_table;
 
 	platform_set_drvdata(pdev, wdat);
 
@@ -460,12 +478,16 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 
 	ret = wdat_wdt_set_timeout(&wdat->wdd, timeout);
 	if (ret)
-		return ret;
+		goto out_put_table;
 
 	watchdog_set_nowayout(&wdat->wdd, nowayout);
 	watchdog_stop_on_reboot(&wdat->wdd);
 	watchdog_stop_on_unregister(&wdat->wdd);
-	return devm_watchdog_register_device(dev, &wdat->wdd);
+	ret = devm_watchdog_register_device(dev, &wdat->wdd);
+
+out_put_table:
+	acpi_put_table((struct acpi_table_header *)tbl);
+	return ret;
 }
 
 static int wdat_wdt_suspend_noirq(struct device *dev)
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index a59c26cc3c7d..9e2f8f0f8264 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -101,7 +101,7 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 	struct v9fs_session_info *v9ses = root->d_sb->s_fs_info;
 
 	if (v9ses->debug)
-		seq_printf(m, ",debug=%x", v9ses->debug);
+		seq_printf(m, ",debug=%#x", v9ses->debug);
 	if (!uid_eq(v9ses->dfltuid, V9FS_DEFUID))
 		seq_printf(m, ",dfltuid=%u",
 			   from_kuid_munged(&init_user_ns, v9ses->dfltuid));
@@ -117,7 +117,7 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 	if (v9ses->nodev)
 		seq_puts(m, ",nodevmap");
 	if (v9ses->cache)
-		seq_printf(m, ",cache=%x", v9ses->cache);
+		seq_printf(m, ",cache=%#x", v9ses->cache);
 #ifdef CONFIG_9P_FSCACHE
 	if (v9ses->cachetag && (v9ses->cache & CACHE_FSCACHE))
 		seq_printf(m, ",cachetag=%s", v9ses->cachetag);
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index eb0b083da269..d1db03093d4c 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -43,14 +43,18 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid;
 	int omode;
+	int o_append;
 
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
 	v9ses = v9fs_inode2v9ses(inode);
-	if (v9fs_proto_dotl(v9ses))
+	if (v9fs_proto_dotl(v9ses)) {
 		omode = v9fs_open_to_dotl_flags(file->f_flags);
-	else
+		o_append = P9_DOTL_APPEND;
+	} else {
 		omode = v9fs_uflags2omode(file->f_flags,
 					v9fs_proto_dotu(v9ses));
+		o_append = P9_OAPPEND;
+	}
 	fid = file->private_data;
 	if (!fid) {
 		fid = v9fs_fid_clone(file_dentry(file));
@@ -58,9 +62,10 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 			return PTR_ERR(fid);
 
 		if ((v9ses->cache & CACHE_WRITEBACK) && (omode & P9_OWRITE)) {
-			int writeback_omode = (omode & ~P9_OWRITE) | P9_ORDWR;
+			int writeback_omode = (omode & ~(P9_OWRITE | o_append)) | P9_ORDWR;
 
 			p9_debug(P9_DEBUG_CACHE, "write-only file with writeback enabled, try opening O_RDWR\n");
+
 			err = p9_client_open(fid, writeback_omode);
 			if (err < 0) {
 				p9_debug(P9_DEBUG_CACHE, "could not open O_RDWR, disabling caches\n");
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 399d455d50d6..2fe2d1cb20ff 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -790,7 +790,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	p9_omode = v9fs_uflags2omode(flags, v9fs_proto_dotu(v9ses));
 
 	if ((v9ses->cache & CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
-		p9_omode = (p9_omode & ~P9_OWRITE) | P9_ORDWR;
+		p9_omode = (p9_omode & ~(P9_OWRITE | P9_OAPPEND)) | P9_ORDWR;
 		p9_debug(P9_DEBUG_CACHE,
 			"write-only file with writeback enabled, creating w/ O_RDWR\n");
 	}
@@ -1403,4 +1403,3 @@ static const struct inode_operations v9fs_symlink_inode_operations = {
 	.getattr = v9fs_vfs_getattr,
 	.setattr = v9fs_vfs_setattr,
 };
-
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 5b5fda617b80..a84ee2a04dbb 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -286,7 +286,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	}
 
 	if ((v9ses->cache & CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
-		p9_omode = (p9_omode & ~P9_OWRITE) | P9_ORDWR;
+		p9_omode = (p9_omode & ~(P9_OWRITE | P9_DOTL_APPEND)) | P9_ORDWR;
 		p9_debug(P9_DEBUG_CACHE,
 			"write-only file with writeback enabled, creating w/ O_RDWR\n");
 	}
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 499a9edf0ca3..a368d6ac98ed 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4215,7 +4215,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
 			mutex_unlock(&fs_info->chunk_mutex);
 		} else {
 			/* Proceed with allocation */
-			space_info->chunk_alloc = 1;
+			space_info->chunk_alloc = true;
 			wait_for_alloc = false;
 			spin_unlock(&space_info->lock);
 		}
@@ -4264,7 +4264,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
 	spin_lock(&space_info->lock);
 	if (ret < 0) {
 		if (ret == -ENOSPC)
-			space_info->full = 1;
+			space_info->full = true;
 		else
 			goto out;
 	} else {
@@ -4274,7 +4274,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
 
 	space_info->force_alloc = CHUNK_ALLOC_NO_FORCE;
 out:
-	space_info->chunk_alloc = 0;
+	space_info->chunk_alloc = false;
 	spin_unlock(&space_info->lock);
 	mutex_unlock(&fs_info->chunk_mutex);
 
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 74e6d7f3d266..47776c4487bc 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4557,9 +4557,9 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			if (btrfs_header_nritems(leaf) == 0) {
 				path->slots[1] = slot;
 				ret = btrfs_del_leaf(trans, root, path, leaf);
+				free_extent_buffer(leaf);
 				if (ret < 0)
 					return ret;
-				free_extent_buffer(leaf);
 				ret = 0;
 			} else {
 				/* if we're still in the path, make sure
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index ca382c5b186f..39c7ad123167 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -798,9 +798,13 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 }
 
 /*
- * helper function to actually insert a head node into the rbtree.
- * this does all the dirty work in terms of maintaining the correct
- * overall modification count.
+ * Helper function to actually insert a head node into the xarray. This does all
+ * the dirty work in terms of maintaining the correct overall modification
+ * count.
+ *
+ * The caller is responsible for calling kfree() on @qrecord. More specifically,
+ * if this function reports that it did not insert it as noted in
+ * @qrecord_inserted_ret, then it's safe to call kfree() on it.
  *
  * Returns an error pointer in case of an error.
  */
@@ -814,7 +818,14 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_ref_head *existing;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	const unsigned long index = (head_ref->bytenr >> fs_info->sectorsize_bits);
-	bool qrecord_inserted = false;
+
+	/*
+	 * If 'qrecord_inserted_ret' is provided, then the first thing we need
+	 * to do is to initialize it to false just in case we have an exit
+	 * before trying to insert the record.
+	 */
+	if (qrecord_inserted_ret)
+		*qrecord_inserted_ret = false;
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	lockdep_assert_held(&delayed_refs->lock);
@@ -833,6 +844,12 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 
 	/* Record qgroup extent info if provided */
 	if (qrecord) {
+		/*
+		 * Setting 'qrecord' but not 'qrecord_inserted_ret' will likely
+		 * result in a memory leakage.
+		 */
+		ASSERT(qrecord_inserted_ret != NULL);
+
 		int ret;
 
 		ret = btrfs_qgroup_trace_extent_nolock(fs_info, delayed_refs, qrecord,
@@ -840,12 +857,10 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		if (ret) {
 			/* Clean up if insertion fails or item exists. */
 			xa_release(&delayed_refs->dirty_extents, index);
-			/* Caller responsible for freeing qrecord on error. */
 			if (ret < 0)
 				return ERR_PTR(ret);
-			kfree(qrecord);
-		} else {
-			qrecord_inserted = true;
+		} else if (qrecord_inserted_ret) {
+			*qrecord_inserted_ret = true;
 		}
 	}
 
@@ -888,8 +903,6 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		delayed_refs->num_heads++;
 		delayed_refs->num_heads_ready++;
 	}
-	if (qrecord_inserted_ret)
-		*qrecord_inserted_ret = qrecord_inserted;
 
 	return head_ref;
 }
@@ -1049,6 +1062,14 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 		xa_release(&delayed_refs->head_refs, index);
 		spin_unlock(&delayed_refs->lock);
 		ret = PTR_ERR(new_head_ref);
+
+		/*
+		 * It's only safe to call kfree() on 'qrecord' if
+		 * add_delayed_ref_head() has _not_ inserted it for
+		 * tracing. Otherwise we need to handle this here.
+		 */
+		if (!qrecord_reserved || qrecord_inserted)
+			goto free_head_ref;
 		goto free_record;
 	}
 	head_ref = new_head_ref;
@@ -1071,6 +1092,8 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 
 	if (qrecord_inserted)
 		return btrfs_qgroup_trace_extent_post(trans, record, generic_ref->bytenr);
+
+	kfree(record);
 	return 0;
 
 free_record:
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0481c693ac2e..b05ab1122a42 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -192,7 +192,7 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
 	struct btrfs_space_info *found;
 
 	list_for_each_entry(found, head, list)
-		found->full = 0;
+		found->full = false;
 }
 
 /*
@@ -372,7 +372,7 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	space_info->bytes_readonly += block_group->bytes_super;
 	btrfs_space_info_update_bytes_zone_unusable(space_info, block_group->zone_unusable);
 	if (block_group->length > 0)
-		space_info->full = 0;
+		space_info->full = false;
 	btrfs_try_granting_tickets(info, space_info);
 	spin_unlock(&space_info->lock);
 
@@ -1146,7 +1146,7 @@ static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
 	spin_lock(&space_info->lock);
 	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
 	if (!to_reclaim) {
-		space_info->flush = 0;
+		space_info->flush = false;
 		spin_unlock(&space_info->lock);
 		return;
 	}
@@ -1158,7 +1158,7 @@ static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
 		flush_space(fs_info, space_info, to_reclaim, flush_state, false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
-			space_info->flush = 0;
+			space_info->flush = false;
 			spin_unlock(&space_info->lock);
 			return;
 		}
@@ -1201,7 +1201,7 @@ static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
 					flush_state = FLUSH_DELAYED_ITEMS_NR;
 					commit_cycles--;
 				} else {
-					space_info->flush = 0;
+					space_info->flush = false;
 				}
 			} else {
 				flush_state = FLUSH_DELAYED_ITEMS_NR;
@@ -1383,7 +1383,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 
 	spin_lock(&space_info->lock);
 	if (list_empty(&space_info->tickets)) {
-		space_info->flush = 0;
+		space_info->flush = false;
 		spin_unlock(&space_info->lock);
 		return;
 	}
@@ -1394,7 +1394,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE, false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
-			space_info->flush = 0;
+			space_info->flush = false;
 			spin_unlock(&space_info->lock);
 			return;
 		}
@@ -1411,7 +1411,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 			    data_flush_states[flush_state], false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
-			space_info->flush = 0;
+			space_info->flush = false;
 			spin_unlock(&space_info->lock);
 			return;
 		}
@@ -1428,7 +1428,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 				if (maybe_fail_all_tickets(fs_info, space_info))
 					flush_state = 0;
 				else
-					space_info->flush = 0;
+					space_info->flush = false;
 			} else {
 				flush_state = 0;
 			}
@@ -1444,7 +1444,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 
 aborted_fs:
 	maybe_fail_all_tickets(fs_info, space_info);
-	space_info->flush = 0;
+	space_info->flush = false;
 	spin_unlock(&space_info->lock);
 }
 
@@ -1825,7 +1825,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 				 */
 				maybe_clamp_preempt(fs_info, space_info);
 
-				space_info->flush = 1;
+				space_info->flush = true;
 				trace_btrfs_trigger_flush(fs_info,
 							  space_info->flags,
 							  orig_bytes, flush,
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 679f22efb407..a846f63585c9 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -142,11 +142,11 @@ struct btrfs_space_info {
 				   flushing. The value is >> clamp, so turns
 				   out to be a 2^clamp divisor. */
 
-	unsigned int full:1;	/* indicates that we cannot allocate any more
+	bool full;		/* indicates that we cannot allocate any more
 				   chunks for this space */
-	unsigned int chunk_alloc:1;	/* set if we are allocating a chunk */
+	bool chunk_alloc;	/* set if we are allocating a chunk */
 
-	unsigned int flush:1;		/* set if we are trying to make space */
+	bool flush;		/* set if we are trying to make space */
 
 	unsigned int force_alloc;	/* set if we need to force a chunk
 					   alloc for this space */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index db13b40a78e0..32336e7c1d9b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -174,15 +174,15 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (!erofs_is_fileio_mode(sbi)) {
 			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
 					&dif->dax_part_off, NULL, NULL);
-			if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
-				erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
-					   dif->path);
-				clear_opt(&sbi->opt, DAX_ALWAYS);
-			}
 		} else if (!S_ISREG(file_inode(file)->i_mode)) {
 			fput(file);
 			return -EINVAL;
 		}
+		if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
+			erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
+				   dif->path);
+			clear_opt(&sbi->opt, DAX_ALWAYS);
+		}
 		dif->file = file;
 	}
 
@@ -215,13 +215,13 @@ static int erofs_scan_devices(struct super_block *sb,
 			  ondisk_extradevs, sbi->devs->extra_devices);
 		return -EINVAL;
 	}
-	if (!ondisk_extradevs) {
-		if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {
-			erofs_info(sb, "DAX unsupported by block device. Turning off DAX.");
-			clear_opt(&sbi->opt, DAX_ALWAYS);
-		}
-		return 0;
+
+	if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {
+		erofs_info(sb, "DAX unsupported by block device. Turning off DAX.");
+		clear_opt(&sbi->opt, DAX_ALWAYS);
 	}
+	if (!ondisk_extradevs)
+		return 0;
 
 	if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))
 		sbi->devs->flatdev = true;
@@ -632,6 +632,22 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sbi->blkszbits = PAGE_SHIFT;
 	if (!sb->s_bdev) {
+		/*
+		 * (File-backed mounts) EROFS claims it's safe to nest other
+		 * fs contexts (including its own) due to self-controlled RO
+		 * accesses/contexts and no side-effect changes that need to
+		 * context save & restore so it can reuse the current thread
+		 * context.  However, it still needs to bump `s_stack_depth` to
+		 * avoid kernel stack overflow from nested filesystems.
+		 */
+		if (erofs_is_fileio_mode(sbi)) {
+			sb->s_stack_depth =
+				file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
+			if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
+				erofs_err(sb, "maximum fs stacking depth exceeded");
+				return -ENOTBLK;
+			}
+		}
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 6070d3c86678..80d6944755b8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -682,6 +682,24 @@ do {									\
 	}								\
 } while (0)
 
+/*
+ * Perform buddy integrity check with the following steps:
+ *
+ * 1. Top-down validation (from highest order down to order 1, excluding order-0 bitmap):
+ *    For each pair of adjacent orders, if a higher-order bit is set (indicating a free block),
+ *    at most one of the two corresponding lower-order bits may be clear (free).
+ *
+ * 2. Order-0 (bitmap) validation, performed on bit pairs:
+ *    - If either bit in a pair is set (1, allocated), then all corresponding higher-order bits
+ *      must not be free (0).
+ *    - If both bits in a pair are clear (0, free), then exactly one of the corresponding
+ *      higher-order bits must be free (0).
+ *
+ * 3. Preallocation (pa) list validation:
+ *    For each preallocated block (pa) in the group:
+ *    - Verify that pa_pstart falls within the bounds of this block group.
+ *    - Ensure the corresponding bit(s) in the order-0 bitmap are marked as allocated (1).
+ */
 static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 				const char *function, int line)
 {
@@ -723,15 +741,6 @@ static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 				continue;
 			}
 
-			/* both bits in buddy2 must be 1 */
-			MB_CHECK_ASSERT(mb_test_bit(i << 1, buddy2));
-			MB_CHECK_ASSERT(mb_test_bit((i << 1) + 1, buddy2));
-
-			for (j = 0; j < (1 << order); j++) {
-				k = (i * (1 << order)) + j;
-				MB_CHECK_ASSERT(
-					!mb_test_bit(k, e4b->bd_bitmap));
-			}
 			count++;
 		}
 		MB_CHECK_ASSERT(e4b->bd_info->bb_counters[order] == count);
@@ -747,15 +756,21 @@ static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 				fragments++;
 				fstart = i;
 			}
-			continue;
+		} else {
+			fstart = -1;
 		}
-		fstart = -1;
-		/* check used bits only */
-		for (j = 0; j < e4b->bd_blkbits + 1; j++) {
-			buddy2 = mb_find_buddy(e4b, j, &max2);
-			k = i >> j;
-			MB_CHECK_ASSERT(k < max2);
-			MB_CHECK_ASSERT(mb_test_bit(k, buddy2));
+		if (!(i & 1)) {
+			int in_use, zero_bit_count = 0;
+
+			in_use = mb_test_bit(i, buddy) || mb_test_bit(i + 1, buddy);
+			for (j = 1; j < e4b->bd_blkbits + 2; j++) {
+				buddy2 = mb_find_buddy(e4b, j, &max2);
+				k = i >> j;
+				MB_CHECK_ASSERT(k < max2);
+				if (!mb_test_bit(k, buddy2))
+					zero_bit_count++;
+			}
+			MB_CHECK_ASSERT(zero_bit_count == !in_use);
 		}
 	}
 	MB_CHECK_ASSERT(!EXT4_MB_GRP_NEED_INIT(e4b->bd_info));
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 4b091c21908f..0f4b7c89edd3 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -485,7 +485,7 @@ mext_check_arguments(struct inode *orig_inode,
 		return -ETXTBSY;
 	}
 
-	if (ext4_is_quota_file(orig_inode) && ext4_is_quota_file(donor_inode)) {
+	if (ext4_is_quota_file(orig_inode) || ext4_is_quota_file(donor_inode)) {
 		ext4_debug("ext4 move extent: The argument files should not be quota files [ino:orig %lu, donor %lu]\n",
 			orig_inode->i_ino, donor_inode->i_ino);
 		return -EOPNOTSUPP;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dac7d44885e4..ca2f640c0387 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -230,6 +230,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_COMPRESSION		0x00002000
 #define F2FS_FEATURE_RO				0x00004000
 #define F2FS_FEATURE_DEVICE_ALIAS		0x00008000
+#define F2FS_FEATURE_PACKED_SSA			0x00010000
 
 #define __F2FS_HAS_FEATURE(raw_super, mask)				\
 	((raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -4648,6 +4649,7 @@ F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
 F2FS_FEATURE_FUNCS(compression, COMPRESSION);
 F2FS_FEATURE_FUNCS(readonly, RO);
 F2FS_FEATURE_FUNCS(device_alias, DEVICE_ALIAS);
+F2FS_FEATURE_FUNCS(packed_ssa, PACKED_SSA);
 
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline bool f2fs_zone_is_seq(struct f2fs_sb_info *sbi, int devi,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5734e0386468..57dd50d83cbb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -38,13 +38,14 @@ static int gc_thread_func(void *data)
 	struct f2fs_gc_control gc_control = {
 		.victim_segno = NULL_SEGNO,
 		.should_migrate_blocks = false,
-		.err_gc_skipped = false };
+		.err_gc_skipped = false,
+		.one_time = false };
 
 	wait_ms = gc_th->min_sleep_time;
 
 	set_freezable();
 	do {
-		bool sync_mode, foreground = false;
+		bool sync_mode, foreground = false, gc_boost = false;
 
 		wait_event_freezable_timeout(*wq,
 				kthread_should_stop() ||
@@ -52,8 +53,12 @@ static int gc_thread_func(void *data)
 				gc_th->gc_wake,
 				msecs_to_jiffies(wait_ms));
 
-		if (test_opt(sbi, GC_MERGE) && waitqueue_active(fggc_wq))
+		if (test_opt(sbi, GC_MERGE) && waitqueue_active(fggc_wq)) {
 			foreground = true;
+			gc_control.one_time = false;
+		} else if (f2fs_sb_has_blkzoned(sbi)) {
+			gc_control.one_time = true;
+		}
 
 		/* give it a try one time */
 		if (gc_th->gc_wake)
@@ -81,8 +86,6 @@ static int gc_thread_func(void *data)
 			continue;
 		}
 
-		gc_control.one_time = false;
-
 		/*
 		 * [GC triggering condition]
 		 * 0. GC is not conducted currently.
@@ -132,7 +135,7 @@ static int gc_thread_func(void *data)
 		if (need_to_boost_gc(sbi)) {
 			decrease_sleep_time(gc_th, &wait_ms);
 			if (f2fs_sb_has_blkzoned(sbi))
-				gc_control.one_time = true;
+				gc_boost = true;
 		} else {
 			increase_sleep_time(gc_th, &wait_ms);
 		}
@@ -141,7 +144,7 @@ static int gc_thread_func(void *data)
 					FOREGROUND : BACKGROUND);
 
 		sync_mode = (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC) ||
-			(gc_control.one_time && gc_th->boost_gc_greedy);
+			(gc_boost && gc_th->boost_gc_greedy);
 
 		/* foreground GC was been triggered via f2fs_balance_fs() */
 		if (foreground && !f2fs_sb_has_blkzoned(sbi))
@@ -1729,7 +1732,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
 						SUM_TYPE_DATA : SUM_TYPE_NODE;
 	unsigned char data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
-	int submitted = 0;
+	int submitted = 0, sum_blk_cnt;
 
 	if (__is_large_section(sbi)) {
 		sec_end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
@@ -1763,22 +1766,28 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 	sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
 
+	segno = rounddown(segno, SUMS_PER_BLOCK);
+	sum_blk_cnt = DIV_ROUND_UP(end_segno - segno, SUMS_PER_BLOCK);
 	/* readahead multi ssa blocks those have contiguous address */
 	if (__is_large_section(sbi))
 		f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
-					end_segno - segno, META_SSA, true);
+					sum_blk_cnt, META_SSA, true);
 
 	/* reference all summary page */
 	while (segno < end_segno) {
-		struct folio *sum_folio = f2fs_get_sum_folio(sbi, segno++);
+		struct folio *sum_folio = f2fs_get_sum_folio(sbi, segno);
+
+		segno += SUMS_PER_BLOCK;
 		if (IS_ERR(sum_folio)) {
 			int err = PTR_ERR(sum_folio);
 
-			end_segno = segno - 1;
-			for (segno = start_segno; segno < end_segno; segno++) {
+			end_segno = segno - SUMS_PER_BLOCK;
+			segno = rounddown(start_segno, SUMS_PER_BLOCK);
+			while (segno < end_segno) {
 				sum_folio = filemap_get_folio(META_MAPPING(sbi),
 						GET_SUM_BLOCK(sbi, segno));
 				folio_put_refs(sum_folio, 2);
+				segno += SUMS_PER_BLOCK;
 			}
 			return err;
 		}
@@ -1787,68 +1796,83 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 	blk_start_plug(&plug);
 
-	for (segno = start_segno; segno < end_segno; segno++) {
-		struct f2fs_summary_block *sum;
+	segno = start_segno;
+	while (segno < end_segno) {
+		unsigned int cur_segno;
 
 		/* find segment summary of victim */
 		struct folio *sum_folio = filemap_get_folio(META_MAPPING(sbi),
 					GET_SUM_BLOCK(sbi, segno));
+		unsigned int block_end_segno = rounddown(segno, SUMS_PER_BLOCK)
+					+ SUMS_PER_BLOCK;
+
+		if (block_end_segno > end_segno)
+			block_end_segno = end_segno;
 
 		if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno))) {
 			f2fs_err(sbi, "%s: segment %u is used by log",
 							__func__, segno);
 			f2fs_bug_on(sbi, 1);
-			goto skip;
+			goto next_block;
 		}
 
-		if (get_valid_blocks(sbi, segno, false) == 0)
-			goto freed;
-		if (gc_type == BG_GC && __is_large_section(sbi) &&
-				migrated >= sbi->migration_granularity)
-			goto skip;
 		if (!folio_test_uptodate(sum_folio) ||
 		    unlikely(f2fs_cp_error(sbi)))
-			goto skip;
+			goto next_block;
 
-		sum = folio_address(sum_folio);
-		if (type != GET_SUM_TYPE((&sum->footer))) {
-			f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SIT and SSA",
-				 segno, type, GET_SUM_TYPE((&sum->footer)));
-			f2fs_stop_checkpoint(sbi, false,
-				STOP_CP_REASON_CORRUPTED_SUMMARY);
-			goto skip;
-		}
+		for (cur_segno = segno; cur_segno < block_end_segno;
+				cur_segno++) {
+			struct f2fs_summary_block *sum;
 
-		/*
-		 * this is to avoid deadlock:
-		 * - lock_page(sum_page)         - f2fs_replace_block
-		 *  - check_valid_map()            - down_write(sentry_lock)
-		 *   - down_read(sentry_lock)     - change_curseg()
-		 *                                  - lock_page(sum_page)
-		 */
-		if (type == SUM_TYPE_NODE)
-			submitted += gc_node_segment(sbi, sum->entries, segno,
-								gc_type);
-		else
-			submitted += gc_data_segment(sbi, sum->entries, gc_list,
-							segno, gc_type,
-							force_migrate);
+			if (get_valid_blocks(sbi, cur_segno, false) == 0)
+				goto freed;
+			if (gc_type == BG_GC && __is_large_section(sbi) &&
+					migrated >= sbi->migration_granularity)
+				continue;
 
-		stat_inc_gc_seg_count(sbi, data_type, gc_type);
-		sbi->gc_reclaimed_segs[sbi->gc_mode]++;
-		migrated++;
+			sum = SUM_BLK_PAGE_ADDR(sum_folio, cur_segno);
+			if (type != GET_SUM_TYPE((&sum->footer))) {
+				f2fs_err(sbi, "Inconsistent segment (%u) type "
+						"[%d, %d] in SSA and SIT",
+						cur_segno, type,
+						GET_SUM_TYPE((&sum->footer)));
+				f2fs_stop_checkpoint(sbi, false,
+						STOP_CP_REASON_CORRUPTED_SUMMARY);
+				continue;
+			}
 
-freed:
-		if (gc_type == FG_GC &&
-				get_valid_blocks(sbi, segno, false) == 0)
-			seg_freed++;
+			/*
+			 * this is to avoid deadlock:
+			 *  - lock_page(sum_page)     - f2fs_replace_block
+			 *   - check_valid_map()        - down_write(sentry_lock)
+			 *    - down_read(sentry_lock) - change_curseg()
+			 *                               - lock_page(sum_page)
+			 */
+			if (type == SUM_TYPE_NODE)
+				submitted += gc_node_segment(sbi, sum->entries,
+						cur_segno, gc_type);
+			else
+				submitted += gc_data_segment(sbi, sum->entries,
+						gc_list, cur_segno,
+						gc_type, force_migrate);
 
-		if (__is_large_section(sbi))
-			sbi->next_victim_seg[gc_type] =
-				(segno + 1 < sec_end_segno) ?
-					segno + 1 : NULL_SEGNO;
-skip:
+			stat_inc_gc_seg_count(sbi, data_type, gc_type);
+			sbi->gc_reclaimed_segs[sbi->gc_mode]++;
+			migrated++;
+
+freed:
+			if (gc_type == FG_GC &&
+					get_valid_blocks(sbi, cur_segno, false) == 0)
+				seg_freed++;
+
+			if (__is_large_section(sbi))
+				sbi->next_victim_seg[gc_type] =
+					(cur_segno + 1 < sec_end_segno) ?
+					cur_segno + 1 : NULL_SEGNO;
+		}
+next_block:
 		folio_put_refs(sum_folio, 2);
+		segno = block_end_segno;
 	}
 
 	if (submitted)
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 215e442db72c..af72309b9bfc 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -519,7 +519,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	sum_folio = f2fs_get_sum_folio(sbi, segno);
 	if (IS_ERR(sum_folio))
 		return PTR_ERR(sum_folio);
-	sum_node = folio_address(sum_folio);
+	sum_node = SUM_BLK_PAGE_ADDR(sum_folio, segno);
 	sum = sum_node->entries[blkoff];
 	f2fs_folio_put(sum_folio, true);
 got_it:
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cc82d42ef14c..3ffb796d0d07 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2712,7 +2712,15 @@ struct folio *f2fs_get_sum_folio(struct f2fs_sb_info *sbi, unsigned int segno)
 void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
 					void *src, block_t blk_addr)
 {
-	struct folio *folio = f2fs_grab_meta_folio(sbi, blk_addr);
+	struct folio *folio;
+
+	if (SUMS_PER_BLOCK == 1)
+		folio = f2fs_grab_meta_folio(sbi, blk_addr);
+	else
+		folio = f2fs_get_meta_folio_retry(sbi, blk_addr);
+
+	if (IS_ERR(folio))
+		return;
 
 	memcpy(folio_address(folio), src, PAGE_SIZE);
 	folio_mark_dirty(folio);
@@ -2720,9 +2728,21 @@ void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
 }
 
 static void write_sum_page(struct f2fs_sb_info *sbi,
-			struct f2fs_summary_block *sum_blk, block_t blk_addr)
+		struct f2fs_summary_block *sum_blk, unsigned int segno)
 {
-	f2fs_update_meta_page(sbi, (void *)sum_blk, blk_addr);
+	struct folio *folio;
+
+	if (SUMS_PER_BLOCK == 1)
+		return f2fs_update_meta_page(sbi, (void *)sum_blk,
+				GET_SUM_BLOCK(sbi, segno));
+
+	folio = f2fs_get_sum_folio(sbi, segno);
+	if (IS_ERR(folio))
+		return;
+
+	memcpy(SUM_BLK_PAGE_ADDR(folio, segno), sum_blk, sizeof(*sum_blk));
+	folio_mark_dirty(folio);
+	f2fs_folio_put(folio, true);
 }
 
 static void write_current_sum_page(struct f2fs_sb_info *sbi,
@@ -2970,7 +2990,7 @@ static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 	int ret;
 
 	if (curseg->inited)
-		write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, segno));
+		write_sum_page(sbi, curseg->sum_blk, segno);
 
 	segno = __get_next_segno(sbi, type);
 	ret = get_new_segment(sbi, &segno, new_sec, pinning);
@@ -3029,7 +3049,7 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
 	struct folio *sum_folio;
 
 	if (curseg->inited)
-		write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, curseg->segno));
+		write_sum_page(sbi, curseg->sum_blk, curseg->segno);
 
 	__set_test_and_inuse(sbi, new_segno);
 
@@ -3048,7 +3068,7 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
 		memset(curseg->sum_blk, 0, SUM_ENTRY_SIZE);
 		return PTR_ERR(sum_folio);
 	}
-	sum_node = folio_address(sum_folio);
+	sum_node = SUM_BLK_PAGE_ADDR(sum_folio, new_segno);
 	memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
 	f2fs_folio_put(sum_folio, true);
 	return 0;
@@ -3137,8 +3157,7 @@ static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type)
 		goto out;
 
 	if (get_valid_blocks(sbi, curseg->segno, false)) {
-		write_sum_page(sbi, curseg->sum_blk,
-				GET_SUM_BLOCK(sbi, curseg->segno));
+		write_sum_page(sbi, curseg->sum_blk, curseg->segno);
 	} else {
 		mutex_lock(&DIRTY_I(sbi)->seglist_lock);
 		__set_test_and_free(sbi, curseg->segno, true);
@@ -3815,8 +3834,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
 	if (segment_full) {
 		if (type == CURSEG_COLD_DATA_PINNED &&
 		    !((curseg->segno + 1) % sbi->segs_per_sec)) {
-			write_sum_page(sbi, curseg->sum_blk,
-					GET_SUM_BLOCK(sbi, curseg->segno));
+			write_sum_page(sbi, curseg->sum_blk, curseg->segno);
 			reset_curseg_fields(curseg);
 			goto skip_new_segment;
 		}
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5e2ee5c686b1..510487669610 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -85,8 +85,12 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 #define GET_ZONE_FROM_SEG(sbi, segno)				\
 	GET_ZONE_FROM_SEC(sbi, GET_SEC_FROM_SEG(sbi, segno))
 
-#define GET_SUM_BLOCK(sbi, segno)				\
-	((sbi)->sm_info->ssa_blkaddr + (segno))
+#define SUMS_PER_BLOCK (F2FS_BLKSIZE / F2FS_SUM_BLKSIZE)
+#define GET_SUM_BLOCK(sbi, segno)	\
+	(SM_I(sbi)->ssa_blkaddr + (segno / SUMS_PER_BLOCK))
+#define GET_SUM_BLKOFF(segno) (segno % SUMS_PER_BLOCK)
+#define SUM_BLK_PAGE_ADDR(folio, segno)	\
+	(folio_address(folio) + GET_SUM_BLKOFF(segno) * F2FS_SUM_BLKSIZE)
 
 #define GET_SUM_TYPE(footer) ((footer)->entry_type)
 #define SET_SUM_TYPE(footer, type) ((footer)->entry_type = (type))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8086a3456e4d..f47e2689d7fb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3965,6 +3965,20 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	if (sanity_check_area_boundary(sbi, folio, index))
 		return -EFSCORRUPTED;
 
+	/*
+	 * Check for legacy summary layout on 16KB+ block devices.
+	 * Modern f2fs-tools packs multiple 4KB summary areas into one block,
+	 * whereas legacy versions used one block per summary, leading
+	 * to a much larger SSA.
+	 */
+	if (SUMS_PER_BLOCK > 1 &&
+		    !(__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_PACKED_SSA))) {
+		f2fs_info(sbi, "Error: Device formatted with a legacy version. "
+			"Please reformat with a tool supporting the packed ssa "
+			"feature for block sizes larger than 4kb.");
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 902ffb3faa1f..0dee87b90e00 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -235,6 +235,9 @@ static ssize_t features_show(struct f2fs_attr *a,
 	if (f2fs_sb_has_compression(sbi))
 		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "compression");
+	if (f2fs_sb_has_packed_ssa(sbi))
+		len += sysfs_emit_at(buf, len, "%s%s",
+				len ? ", " : "", "packed_ssa");
 	len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "pin_file");
 	len += sysfs_emit_at(buf, len, "\n");
@@ -1255,6 +1258,7 @@ F2FS_FEATURE_RO_ATTR(pin_file);
 #ifdef CONFIG_UNICODE
 F2FS_FEATURE_RO_ATTR(linear_lookup);
 #endif
+F2FS_FEATURE_RO_ATTR(packed_ssa);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -1410,6 +1414,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 #ifdef CONFIG_UNICODE
 	BASE_ATTR_LIST(linear_lookup),
 #endif
+	BASE_ATTR_LIST(packed_ssa),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_feat);
@@ -1445,6 +1450,7 @@ F2FS_SB_FEATURE_RO_ATTR(casefold, CASEFOLD);
 F2FS_SB_FEATURE_RO_ATTR(compression, COMPRESSION);
 F2FS_SB_FEATURE_RO_ATTR(readonly, RO);
 F2FS_SB_FEATURE_RO_ATTR(device_alias, DEVICE_ALIAS);
+F2FS_SB_FEATURE_RO_ATTR(packed_ssa, PACKED_SSA);
 
 static struct attribute *f2fs_sb_feat_attrs[] = {
 	ATTR_LIST(sb_encryption),
@@ -1462,6 +1468,7 @@ static struct attribute *f2fs_sb_feat_attrs[] = {
 	ATTR_LIST(sb_compression),
 	ATTR_LIST(sb_readonly),
 	ATTR_LIST(sb_device_alias),
+	ATTR_LIST(sb_packed_ssa),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_sb_feat);
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index bb407705603c..5247df896c5d 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -205,8 +205,7 @@ static const struct file_operations fuse_conn_congestion_threshold_ops = {
 
 static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
 					  struct fuse_conn *fc,
-					  const char *name,
-					  int mode, int nlink,
+					  const char *name, int mode,
 					  const struct inode_operations *iop,
 					  const struct file_operations *fop)
 {
@@ -232,7 +231,10 @@ static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
 	if (iop)
 		inode->i_op = iop;
 	inode->i_fop = fop;
-	set_nlink(inode, nlink);
+	if (S_ISDIR(mode)) {
+		inc_nlink(d_inode(parent));
+		inc_nlink(inode);
+	}
 	inode->i_private = fc;
 	d_add(dentry, inode);
 
@@ -252,22 +254,21 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 		return 0;
 
 	parent = fuse_control_sb->s_root;
-	inc_nlink(d_inode(parent));
 	sprintf(name, "%u", fc->dev);
-	parent = fuse_ctl_add_dentry(parent, fc, name, S_IFDIR | 0500, 2,
+	parent = fuse_ctl_add_dentry(parent, fc, name, S_IFDIR | 0500,
 				     &simple_dir_inode_operations,
 				     &simple_dir_operations);
 	if (!parent)
 		goto err;
 
-	if (!fuse_ctl_add_dentry(parent, fc, "waiting", S_IFREG | 0400, 1,
+	if (!fuse_ctl_add_dentry(parent, fc, "waiting", S_IFREG | 0400,
 				 NULL, &fuse_ctl_waiting_ops) ||
-	    !fuse_ctl_add_dentry(parent, fc, "abort", S_IFREG | 0200, 1,
+	    !fuse_ctl_add_dentry(parent, fc, "abort", S_IFREG | 0200,
 				 NULL, &fuse_ctl_abort_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "max_background", S_IFREG | 0600,
-				 1, NULL, &fuse_conn_max_background_ops) ||
+				 NULL, &fuse_conn_max_background_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
-				 S_IFREG | 0600, 1, NULL,
+				 S_IFREG | 0600, NULL,
 				 &fuse_conn_congestion_threshold_ops))
 		goto err;
 
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index a6535413a0b4..d00cedf4460c 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1205,10 +1205,13 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 
 	mapping = gfs2_glock2aspace(gl);
 	if (mapping) {
+		gfp_t gfp_mask;
+
                 mapping->a_ops = &gfs2_meta_aops;
 		mapping->host = sdp->sd_inode;
 		mapping->flags = 0;
-		mapping_set_gfp_mask(mapping, GFP_NOFS);
+		gfp_mask = mapping_gfp_mask(sdp->sd_inode->i_mapping);
+		mapping_set_gfp_mask(mapping, gfp_mask);
 		mapping->i_private_data = NULL;
 		mapping->writeback_index = 0;
 	}
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8760e7e20c9d..35c1ccc1747f 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -89,6 +89,19 @@ static int iget_set(struct inode *inode, void *opaque)
 	return 0;
 }
 
+void gfs2_setup_inode(struct inode *inode)
+{
+	gfp_t gfp_mask;
+
+	/*
+	 * Ensure all page cache allocations are done from GFP_NOFS context to
+	 * prevent direct reclaim recursion back into the filesystem and blowing
+	 * stacks or deadlocking.
+	 */
+	gfp_mask = mapping_gfp_mask(inode->i_mapping);
+	mapping_set_gfp_mask(inode->i_mapping, gfp_mask & ~__GFP_FS);
+}
+
 /**
  * gfs2_inode_lookup - Lookup an inode
  * @sb: The super block
@@ -132,6 +145,7 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 		struct gfs2_glock *io_gl;
 		int extra_flags = 0;
 
+		gfs2_setup_inode(inode);
 		error = gfs2_glock_get(sdp, no_addr, &gfs2_inode_glops, CREATE,
 				       &ip->i_gl);
 		if (unlikely(error))
@@ -752,6 +766,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	error = -ENOMEM;
 	if (!inode)
 		goto fail_gunlock;
+	gfs2_setup_inode(inode);
 	ip = GFS2_I(inode);
 
 	error = posix_acl_create(dir, &mode, &default_acl, &acl);
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index e43f08eb26e7..2fcd96dd1361 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -86,6 +86,7 @@ static inline int gfs2_check_internal_file_size(struct inode *inode,
 	return -EIO;
 }
 
+void gfs2_setup_inode(struct inode *inode);
 struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned type,
 			        u64 no_addr, u64 no_formal_ino,
 			        unsigned int blktype);
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index efe99b732551..468ff57386dc 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1183,7 +1183,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	mapping = gfs2_aspace(sdp);
 	mapping->a_ops = &gfs2_rgrp_aops;
-	mapping_set_gfp_mask(mapping, GFP_NOFS);
+	gfs2_setup_inode(sdp->sd_inode);
 
 	error = init_names(sdp, silent);
 	if (error)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 46aa85af13dc..97c40e7df721 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -179,7 +179,18 @@ static void iomap_dio_done(struct iomap_dio *dio)
 
 		WRITE_ONCE(dio->submit.waiter, NULL);
 		blk_wake_io_task(waiter);
-	} else if (dio->flags & IOMAP_DIO_INLINE_COMP) {
+		return;
+	}
+
+	/*
+	 * Always run error completions in user context.  These are not
+	 * performance critical and some code relies on taking sleeping locks
+	 * for error handling.
+	 */
+	if (dio->error)
+		dio->flags &= ~IOMAP_DIO_INLINE_COMP;
+
+	if (dio->flags & IOMAP_DIO_INLINE_COMP) {
 		WRITE_ONCE(iocb->private, NULL);
 		iomap_dio_complete_work(&dio->aio.work);
 	} else if (dio->flags & IOMAP_DIO_CALLER_COMP) {
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 54699299d5b1..2aaea9c98c2c 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -784,10 +784,18 @@ static int nfs_init_server(struct nfs_server *server,
 		server->fattr_valid = NFS_ATTR_FATTR_V4;
 	}
 
-	if (ctx->rsize)
+	if (ctx->bsize) {
+		server->bsize = ctx->bsize;
+		server->automount_inherit |= NFS_AUTOMOUNT_INHERIT_BSIZE;
+	}
+	if (ctx->rsize) {
 		server->rsize = nfs_io_size(ctx->rsize, clp->cl_proto);
-	if (ctx->wsize)
+		server->automount_inherit |= NFS_AUTOMOUNT_INHERIT_RSIZE;
+	}
+	if (ctx->wsize) {
 		server->wsize = nfs_io_size(ctx->wsize, clp->cl_proto);
+		server->automount_inherit |= NFS_AUTOMOUNT_INHERIT_WSIZE;
+	}
 
 	server->acregmin = ctx->acregmin * HZ;
 	server->acregmax = ctx->acregmax * HZ;
@@ -977,8 +985,13 @@ EXPORT_SYMBOL_GPL(nfs_probe_server);
 void nfs_server_copy_userdata(struct nfs_server *target, struct nfs_server *source)
 {
 	target->flags = source->flags;
-	target->rsize = source->rsize;
-	target->wsize = source->wsize;
+	target->automount_inherit = source->automount_inherit;
+	if (source->automount_inherit & NFS_AUTOMOUNT_INHERIT_BSIZE)
+		target->bsize = source->bsize;
+	if (source->automount_inherit & NFS_AUTOMOUNT_INHERIT_RSIZE)
+		target->rsize = source->rsize;
+	if (source->automount_inherit & NFS_AUTOMOUNT_INHERIT_WSIZE)
+		target->wsize = source->wsize;
 	target->acregmin = source->acregmin;
 	target->acregmax = source->acregmax;
 	target->acdirmin = source->acdirmin;
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 82ef36cc9cee..c0b4d24e95bd 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -789,16 +789,17 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		goto out;
 	}
 
+	nfs_set_verifier(dentry, dir_verifier);
 	inode = nfs_fhget(dentry->d_sb, entry->fh, entry->fattr);
 	alias = d_splice_alias(inode, dentry);
 	d_lookup_done(dentry);
 	if (alias) {
 		if (IS_ERR(alias))
 			goto out;
+		nfs_set_verifier(alias, dir_verifier);
 		dput(dentry);
 		dentry = alias;
 	}
-	nfs_set_verifier(dentry, dir_verifier);
 	trace_nfs_readdir_lookup(d_inode(parent), dentry, 0);
 out:
 	dput(dentry);
@@ -1894,13 +1895,15 @@ static int nfs_dentry_delete(const struct dentry *dentry)
 }
 
 /* Ensure that we revalidate inode->i_nlink */
-static void nfs_drop_nlink(struct inode *inode)
+static void nfs_drop_nlink(struct inode *inode, unsigned long gencount)
 {
+	struct nfs_inode *nfsi = NFS_I(inode);
+
 	spin_lock(&inode->i_lock);
 	/* drop the inode if we're reasonably sure this is the last link */
-	if (inode->i_nlink > 0)
+	if (inode->i_nlink > 0 && gencount == nfsi->attr_gencount)
 		drop_nlink(inode);
-	NFS_I(inode)->attr_gencount = nfs_inc_attr_generation_counter();
+	nfsi->attr_gencount = nfs_inc_attr_generation_counter();
 	nfs_set_cache_invalid(
 		inode, NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
 			       NFS_INO_INVALID_NLINK);
@@ -1914,8 +1917,9 @@ static void nfs_drop_nlink(struct inode *inode)
 static void nfs_dentry_iput(struct dentry *dentry, struct inode *inode)
 {
 	if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
+		unsigned long gencount = READ_ONCE(NFS_I(inode)->attr_gencount);
 		nfs_complete_unlink(dentry, inode);
-		nfs_drop_nlink(inode);
+		nfs_drop_nlink(inode, gencount);
 	}
 	iput(inode);
 }
@@ -1991,13 +1995,14 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 	nfs_lookup_advise_force_readdirplus(dir, flags);
 
 no_entry:
+	nfs_set_verifier(dentry, dir_verifier);
 	res = d_splice_alias(inode, dentry);
 	if (res != NULL) {
 		if (IS_ERR(res))
 			goto out;
+		nfs_set_verifier(res, dir_verifier);
 		dentry = res;
 	}
-	nfs_set_verifier(dentry, dir_verifier);
 out:
 	trace_nfs_lookup_exit(dir, dentry, flags, PTR_ERR_OR_ZERO(res));
 	nfs_free_fattr(fattr);
@@ -2139,12 +2144,12 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		d_drop(dentry);
 		switch (err) {
 		case -ENOENT:
-			d_splice_alias(NULL, dentry);
 			if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
 				dir_verifier = inode_peek_iversion_raw(dir);
 			else
 				dir_verifier = nfs_save_change_attribute(dir);
 			nfs_set_verifier(dentry, dir_verifier);
+			d_splice_alias(NULL, dentry);
 			break;
 		case -EISDIR:
 		case -ENOTDIR:
@@ -2509,9 +2514,11 @@ static int nfs_safe_remove(struct dentry *dentry)
 
 	trace_nfs_remove_enter(dir, dentry);
 	if (inode != NULL) {
+		unsigned long gencount = READ_ONCE(NFS_I(inode)->attr_gencount);
+
 		error = NFS_PROTO(dir)->remove(dir, dentry);
 		if (error == 0)
-			nfs_drop_nlink(inode);
+			nfs_drop_nlink(inode, gencount);
 	} else
 		error = NFS_PROTO(dir)->remove(dir, dentry);
 	if (error == -ENOENT)
@@ -2711,6 +2718,7 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 {
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
+	unsigned long new_gencount = 0;
 	struct dentry *dentry = NULL;
 	struct rpc_task *task;
 	bool must_unblock = false;
@@ -2763,6 +2771,7 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		} else {
 			block_revalidate(new_dentry);
 			must_unblock = true;
+			new_gencount = NFS_I(new_inode)->attr_gencount;
 			spin_unlock(&new_dentry->d_lock);
 		}
 
@@ -2802,7 +2811,7 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			new_dir, new_dentry, error);
 	if (!error) {
 		if (new_inode != NULL)
-			nfs_drop_nlink(new_inode);
+			nfs_drop_nlink(new_inode, new_gencount);
 		/*
 		 * The d_move() should be here instead of in an async RPC completion
 		 * handler because we need the proper locks to move the dentry.  If
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index c0a44f389f8f..a76332820cff 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -13,7 +13,7 @@
 #include <linux/nfslocalio.h>
 #include <linux/wait_bit.h>
 
-#define NFS_SB_MASK (SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
+#define NFS_SB_MASK (SB_RDONLY|SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
 
 extern const struct export_operations nfs_export_ops;
 
@@ -152,7 +152,6 @@ struct nfs_fs_context {
 		struct super_block	*sb;
 		struct dentry		*dentry;
 		struct nfs_fattr	*fattr;
-		unsigned int		inherited_bsize;
 	} clone_data;
 };
 
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 7f1ec9c67ff2..5dd753eed6d1 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -149,6 +149,7 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	struct vfsmount *mnt = ERR_PTR(-ENOMEM);
 	struct nfs_server *server = NFS_SB(path->dentry->d_sb);
 	struct nfs_client *client = server->nfs_client;
+	unsigned long s_flags = path->dentry->d_sb->s_flags;
 	int timeout = READ_ONCE(nfs_mountpoint_expiry_timeout);
 	int ret;
 
@@ -174,6 +175,11 @@ struct vfsmount *nfs_d_automount(struct path *path)
 		fc->net_ns = get_net(client->cl_net);
 	}
 
+	/* Inherit the flags covered by NFS_SB_MASK */
+	fc->sb_flags_mask |= NFS_SB_MASK;
+	fc->sb_flags &= ~NFS_SB_MASK;
+	fc->sb_flags |= s_flags & NFS_SB_MASK;
+
 	/* for submounts we want the same server; referrals will reassign */
 	memcpy(&ctx->nfs_server._address, &client->cl_addr, client->cl_addrlen);
 	ctx->nfs_server.addrlen	= client->cl_addrlen;
@@ -184,6 +190,10 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	ctx->nfs_mod		= client->cl_nfs_mod;
 	get_nfs_version(ctx->nfs_mod);
 
+	/* Inherit block sizes if they were specified as mount parameters */
+	if (server->automount_inherit & NFS_AUTOMOUNT_INHERIT_BSIZE)
+		ctx->bsize = server->bsize;
+
 	ret = client->rpc_ops->submount(fc, server);
 	if (ret < 0) {
 		mnt = ERR_PTR(ret);
@@ -283,7 +293,6 @@ int nfs_do_submount(struct fs_context *fc)
 		return -ENOMEM;
 
 	ctx->internal		= true;
-	ctx->clone_data.inherited_bsize = ctx->clone_data.sb->s_blocksize_bits;
 
 	p = nfs_devname(dentry, buffer, 4096);
 	if (IS_ERR(p)) {
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 3a4baed993c9..4ff0e9dd1145 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1174,10 +1174,20 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 	if (error < 0)
 		return error;
 
-	if (ctx->rsize)
-		server->rsize = nfs_io_size(ctx->rsize, server->nfs_client->cl_proto);
-	if (ctx->wsize)
-		server->wsize = nfs_io_size(ctx->wsize, server->nfs_client->cl_proto);
+	if (ctx->bsize) {
+		server->bsize = ctx->bsize;
+		server->automount_inherit |= NFS_AUTOMOUNT_INHERIT_BSIZE;
+	}
+	if (ctx->rsize) {
+		server->rsize =
+			nfs_io_size(ctx->rsize, server->nfs_client->cl_proto);
+		server->automount_inherit |= NFS_AUTOMOUNT_INHERIT_RSIZE;
+	}
+	if (ctx->wsize) {
+		server->wsize =
+			nfs_io_size(ctx->wsize, server->nfs_client->cl_proto);
+		server->automount_inherit |= NFS_AUTOMOUNT_INHERIT_WSIZE;
+	}
 
 	server->acregmin = ctx->acregmin * HZ;
 	server->acregmax = ctx->acregmax * HZ;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a1e95732fd03..106f0bf88137 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3174,18 +3174,6 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	if (opendata->o_res.rflags & NFS4_OPEN_RESULT_PRESERVE_UNLINKED)
 		set_bit(NFS_INO_PRESERVE_UNLINKED, &NFS_I(state->inode)->flags);
 
-	dentry = opendata->dentry;
-	if (d_really_is_negative(dentry)) {
-		struct dentry *alias;
-		d_drop(dentry);
-		alias = d_splice_alias(igrab(state->inode), dentry);
-		/* d_splice_alias() can't fail here - it's a non-directory */
-		if (alias) {
-			dput(ctx->dentry);
-			ctx->dentry = dentry = alias;
-		}
-	}
-
 	switch(opendata->o_arg.claim) {
 	default:
 		break;
@@ -3196,7 +3184,20 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 			break;
 		if (opendata->o_res.delegation.type != 0)
 			dir_verifier = nfs_save_change_attribute(dir);
-		nfs_set_verifier(dentry, dir_verifier);
+	}
+
+	dentry = opendata->dentry;
+	nfs_set_verifier(dentry, dir_verifier);
+	if (d_really_is_negative(dentry)) {
+		struct dentry *alias;
+		d_drop(dentry);
+		alias = d_splice_alias(igrab(state->inode), dentry);
+		/* d_splice_alias() can't fail here - it's a non-directory */
+		if (alias) {
+			dput(ctx->dentry);
+			nfs_set_verifier(alias, dir_verifier);
+			ctx->dentry = dentry = alias;
+		}
 	}
 
 	/* Parse layoutget results before we check for access */
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a3135b5af7ee..7ce2e840217c 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -464,6 +464,7 @@ pnfs_mark_layout_stateid_invalid(struct pnfs_layout_hdr *lo,
 	struct pnfs_layout_segment *lseg, *next;
 
 	set_bit(NFS_LAYOUT_INVALID_STID, &lo->plh_flags);
+	clear_bit(NFS_INO_LAYOUTCOMMIT, &NFS_I(lo->plh_inode)->flags);
 	list_for_each_entry_safe(lseg, next, &lo->plh_segs, pls_list)
 		pnfs_clear_lseg_state(lseg, lseg_list);
 	pnfs_clear_layoutreturn_info(lo);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 72dee6f3050e..57d372db03b9 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1051,16 +1051,6 @@ int nfs_reconfigure(struct fs_context *fc)
 
 	sync_filesystem(sb);
 
-	/*
-	 * The SB_RDONLY flag has been removed from the superblock during
-	 * mounts to prevent interference between different filesystems.
-	 * Similarly, it is also necessary to ignore the SB_RDONLY flag
-	 * during reconfiguration; otherwise, it may also result in the
-	 * creation of redundant superblocks when mounting a directory with
-	 * different rw and ro flags multiple times.
-	 */
-	fc->sb_flags_mask &= ~SB_RDONLY;
-
 	/*
 	 * Userspace mount programs that send binary options generally send
 	 * them populated with default values. We have no way to know which
@@ -1101,8 +1091,9 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 	sb->s_blocksize = 0;
 	sb->s_xattr = server->nfs_client->cl_nfs_mod->xattr;
 	sb->s_op = server->nfs_client->cl_nfs_mod->sops;
-	if (ctx->bsize)
-		sb->s_blocksize = nfs_block_size(ctx->bsize, &sb->s_blocksize_bits);
+	if (server->bsize)
+		sb->s_blocksize =
+			nfs_block_size(server->bsize, &sb->s_blocksize_bits);
 
 	switch (server->nfs_client->rpc_ops->version) {
 	case 2:
@@ -1318,26 +1309,13 @@ int nfs_get_tree_common(struct fs_context *fc)
 	if (IS_ERR(server))
 		return PTR_ERR(server);
 
-	/*
-	 * When NFS_MOUNT_UNSHARED is not set, NFS forces the sharing of a
-	 * superblock among each filesystem that mounts sub-directories
-	 * belonging to a single exported root path.
-	 * To prevent interference between different filesystems, the
-	 * SB_RDONLY flag should be removed from the superblock.
-	 */
 	if (server->flags & NFS_MOUNT_UNSHARED)
 		compare_super = NULL;
-	else
-		fc->sb_flags &= ~SB_RDONLY;
 
 	/* -o noac implies -o sync */
 	if (server->flags & NFS_MOUNT_NOAC)
 		fc->sb_flags |= SB_SYNCHRONOUS;
 
-	if (ctx->clone_data.sb)
-		if (ctx->clone_data.sb->s_flags & SB_SYNCHRONOUS)
-			fc->sb_flags |= SB_SYNCHRONOUS;
-
 	/* Get a superblock - note that we may end up sharing one that already exists */
 	fc->s_fs_info = server;
 	s = sget_fc(fc, compare_super, nfs_set_super);
@@ -1361,13 +1339,8 @@ int nfs_get_tree_common(struct fs_context *fc)
 	}
 
 	if (!s->s_root) {
-		unsigned bsize = ctx->clone_data.inherited_bsize;
 		/* initial superblock/root creation */
 		nfs_fill_super(s, ctx);
-		if (bsize) {
-			s->s_blocksize_bits = bsize;
-			s->s_blocksize = 1U << bsize;
-		}
 		error = nfs_get_cache_cookie(s, ctx);
 		if (error < 0)
 			goto error_splat_super;
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 0822d8a119c6..eefe50a17c4a 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -23,6 +23,7 @@ nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	struct super_block *sb = inode->i_sb;
+	u64 length;
 	u32 block_size = i_blocksize(inode);
 	struct pnfs_block_extent *bex;
 	struct iomap iomap;
@@ -53,7 +54,8 @@ nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
 		goto out_error;
 	}
 
-	if (iomap.length < args->lg_minlength) {
+	length = iomap.offset + iomap.length - seg->offset;
+	if (length < args->lg_minlength) {
 		dprintk("pnfsd: extent smaller than minlength\n");
 		goto out_layoutunavailable;
 	}
diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 18d597e49a19..a5c3a9f1b8dc 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -67,19 +67,22 @@ int utf8_to_utf32(const u8 *s, int inlen, unicode_t *pu)
 			l &= t->lmask;
 			if (l < t->lval || l > UNICODE_MAX ||
 					(l & SURROGATE_MASK) == SURROGATE_PAIR)
-				return -1;
+				return -EILSEQ;
+
 			*pu = (unicode_t) l;
 			return nc;
 		}
 		if (inlen <= nc)
-			return -1;
+			return -EOVERFLOW;
+
 		s++;
 		c = (*s ^ 0x80) & 0xFF;
 		if (c & 0xC0)
-			return -1;
+			return -EILSEQ;
+
 		l = (l << 6) | c;
 	}
-	return -1;
+	return -EILSEQ;
 }
 EXPORT_SYMBOL(utf8_to_utf32);
 
@@ -94,7 +97,7 @@ int utf32_to_utf8(unicode_t u, u8 *s, int maxout)
 
 	l = u;
 	if (l > UNICODE_MAX || (l & SURROGATE_MASK) == SURROGATE_PAIR)
-		return -1;
+		return -EILSEQ;
 
 	nc = 0;
 	for (t = utf8_table; t->cmask && maxout; t++, maxout--) {
@@ -110,7 +113,7 @@ int utf32_to_utf8(unicode_t u, u8 *s, int maxout)
 			return nc;
 		}
 	}
-	return -1;
+	return -EOVERFLOW;
 }
 EXPORT_SYMBOL(utf32_to_utf8);
 
@@ -217,8 +220,16 @@ int utf16s_to_utf8s(const wchar_t *pwcs, int inlen, enum utf16_endian endian,
 				inlen--;
 			}
 			size = utf32_to_utf8(u, op, maxout);
-			if (size == -1) {
-				/* Ignore character and move on */
+			if (size < 0) {
+				if (size == -EILSEQ) {
+					/* Ignore character and move on */
+					continue;
+				}
+				/*
+				 * Stop filling the buffer with data once a character
+				 * does not fit anymore.
+				 */
+				break;
 			} else {
 				op += size;
 				maxout -= size;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 8f9fe1d7a690..e5a005d216f3 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -325,8 +325,10 @@ bool ni_add_subrecord(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi)
 
 	mi_get_ref(&ni->mi, &m->mrec->parent_ref);
 
-	ni_add_mi(ni, m);
-	*mi = m;
+	*mi = ni_ins_mi(ni, &ni->mi_tree, m->rno, &m->node);
+	if (*mi != m)
+		mi_put(m);
+
 	return true;
 }
 
@@ -1015,9 +1017,9 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 
 out2:
 	ni_remove_mi(ni, mi);
-	mi_put(mi);
 
 out1:
+	mi_put(mi);
 	ntfs_mark_rec_free(sbi, rno, is_mft);
 
 out:
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index c7a2f191254d..5ae910e9ecbd 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1349,7 +1349,14 @@ int ntfs_get_bh(struct ntfs_sb_info *sbi, const struct runs_tree *run, u64 vbo,
 				}
 				if (buffer_locked(bh))
 					__wait_on_buffer(bh);
-				set_buffer_uptodate(bh);
+
+				lock_buffer(bh);
+				if (!buffer_uptodate(bh))
+				{
+					memset(bh->b_data, 0, blocksize);
+					set_buffer_uptodate(bh);
+				}
+				unlock_buffer(bh);
 			} else {
 				bh = ntfs_bread(sb, block);
 				if (!bh) {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index b08b00912165..d085bc437034 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -472,6 +472,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		/* Records in $Extend are not a files or general directories. */
 		inode->i_op = &ntfs_file_inode_operations;
 		mode = S_IFREG;
+		init_rwsem(&ni->file.run_lock);
 	} else {
 		err = -EINVAL;
 		goto out;
@@ -1717,6 +1718,7 @@ int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
 	de = __getname();
 	if (!de)
 		return -ENOMEM;
+	memset(de, 0, PATH_MAX);
 
 	/* Mark rw ntfs as dirty. It will be cleared at umount. */
 	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 821cb7874685..b23eb63dc838 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -3654,7 +3654,6 @@ static int ocfs2_merge_rec_left(struct ocfs2_path *right_path,
 			 * So we use the new rightmost path.
 			 */
 			ocfs2_mv_path(right_path, left_path);
-			left_path = NULL;
 		} else
 			ocfs2_complete_edge_insert(handle, left_path,
 						   right_path, subtree_index);
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 6c4f78f473fb..d4ca824f9c82 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -201,13 +201,15 @@ struct inode *ocfs2_iget(struct ocfs2_super *osb, u64 blkno, unsigned flags,
 static int ocfs2_dinode_has_extents(struct ocfs2_dinode *di)
 {
 	/* inodes flagged with other stuff in id2 */
-	if (di->i_flags & (OCFS2_SUPER_BLOCK_FL | OCFS2_LOCAL_ALLOC_FL |
-			   OCFS2_CHAIN_FL | OCFS2_DEALLOC_FL))
+	if (le32_to_cpu(di->i_flags) &
+	    (OCFS2_SUPER_BLOCK_FL | OCFS2_LOCAL_ALLOC_FL | OCFS2_CHAIN_FL |
+	     OCFS2_DEALLOC_FL))
 		return 0;
 	/* i_flags doesn't indicate when id2 is a fast symlink */
-	if (S_ISLNK(di->i_mode) && di->i_size && di->i_clusters == 0)
+	if (S_ISLNK(le16_to_cpu(di->i_mode)) && le64_to_cpu(di->i_size) &&
+	    !le32_to_cpu(di->i_clusters))
 		return 0;
-	if (di->i_dyn_features & OCFS2_INLINE_DATA_FL)
+	if (le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL)
 		return 0;
 
 	return 1;
diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 80ebb0b7265a..5a0228c51ec3 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -98,7 +98,13 @@ static int __ocfs2_move_extent(handle_t *handle,
 
 	rec = &el->l_recs[index];
 
-	BUG_ON(ext_flags != rec->e_flags);
+	if (ext_flags != rec->e_flags) {
+		ret = ocfs2_error(inode->i_sb,
+				  "Inode %llu has corrupted extent %d with flags 0x%x at cpos %u\n",
+				  (unsigned long long)ino, index, rec->e_flags, cpos);
+		goto out;
+	}
+
 	/*
 	 * after moving/defraging to new location, the extent is not going
 	 * to be refcounted anymore.
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 2c9c7636253a..3fde97d2889b 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -306,6 +306,8 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	const struct cred *c;
 	__u64 mask;
 
+	BUILD_BUG_ON(sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER1);
+
 	if (!uinfo)
 		return -EINVAL;
 	if (usize < PIDFD_INFO_SIZE_VER0)
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index d20766f664c4..4368771aad16 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1364,7 +1364,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	} else {
 		size_t trans = rdata->subreq.transferred + rdata->got_bytes;
 		if (trans < rdata->subreq.len &&
-		    rdata->subreq.start + trans == ictx->remote_i_size) {
+		    rdata->subreq.start + trans >= ictx->remote_i_size) {
 			rdata->result = 0;
 			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 		} else if (rdata->got_bytes > 0) {
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index f925b2da76c1..64fe2de662ff 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4629,7 +4629,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	} else {
 		size_t trans = rdata->subreq.transferred + rdata->got_bytes;
 		if (trans < rdata->subreq.len &&
-		    rdata->subreq.start + trans == ictx->remote_i_size) {
+		    rdata->subreq.start + trans >= ictx->remote_i_size) {
 			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 			rdata->result = 0;
 		}
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 8705c77a9e75..93c231601c8e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -757,7 +757,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 						const struct eventfs_entry *entries,
 						int size, void *data)
 {
-	struct dentry *dentry = tracefs_start_creating(name, parent);
+	struct dentry *dentry;
 	struct eventfs_root_inode *rei;
 	struct eventfs_inode *ei;
 	struct tracefs_inode *ti;
@@ -768,6 +768,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	if (security_locked_down(LOCKDOWN_TRACEFS))
 		return NULL;
 
+	dentry = tracefs_start_creating(name, parent);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index a729b77983fa..18ee23174da0 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -123,10 +123,12 @@ static inline unsigned int hv_repcomp(u64 status)
 
 /*
  * Rep hypercalls. Callers of this functions are supposed to ensure that
- * rep_count and varhead_size comply with Hyper-V hypercall definition.
+ * rep_count, varhead_size, and rep_start comply with Hyper-V hypercall
+ * definition.
  */
-static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
-				      void *input, void *output)
+static inline u64 hv_do_rep_hypercall_ex(u16 code, u16 rep_count,
+					 u16 varhead_size, u16 rep_start,
+					 void *input, void *output)
 {
 	u64 control = code;
 	u64 status;
@@ -134,6 +136,7 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
 
 	control |= (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
 	control |= (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
+	control |= (u64)rep_start << HV_HYPERCALL_REP_START_OFFSET;
 
 	do {
 		status = hv_do_hypercall(control, input, output);
@@ -151,6 +154,14 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
 	return status;
 }
 
+/* For the typical case where rep_start is 0 */
+static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
+				      void *input, void *output)
+{
+	return hv_do_rep_hypercall_ex(code, rep_count, varhead_size, 0,
+				      input, output);
+}
+
 /* Generate the guest OS identifier as described in the Hyper-V TLFS */
 static inline u64 hv_generate_guest_id(u64 kernel_version)
 {
diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 6d4244d643df..0f2dcbbfee2f 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -129,8 +129,8 @@ static __always_inline void release_held_lock_entry(void)
 	 * <error> for lock B
 	 * release_held_lock_entry
 	 *
-	 * try_cmpxchg_acquire for lock A
 	 * grab_held_lock_entry
+	 * try_cmpxchg_acquire for lock A
 	 *
 	 * Lack of any ordering means reordering may occur such that dec, inc
 	 * are done before entry is overwritten. This permits a remote lock
@@ -139,13 +139,8 @@ static __always_inline void release_held_lock_entry(void)
 	 * CPU holds a lock it is attempting to acquire, leading to false ABBA
 	 * diagnosis).
 	 *
-	 * In case of unlock, we will always do a release on the lock word after
-	 * releasing the entry, ensuring that other CPUs cannot hold the lock
-	 * (and make conclusions about deadlocks) until the entry has been
-	 * cleared on the local CPU, preventing any anomalies. Reordering is
-	 * still possible there, but a remote CPU cannot observe a lock in our
-	 * table which it is already holding, since visibility entails our
-	 * release store for the said lock has not retired.
+	 * The case of unlock is treated differently due to NMI reentrancy, see
+	 * comments in res_spin_unlock.
 	 *
 	 * In theory we don't have a problem if the dec and WRITE_ONCE above get
 	 * reordered with each other, we either notice an empty NULL entry on
@@ -175,10 +170,22 @@ static __always_inline int res_spin_lock(rqspinlock_t *lock)
 {
 	int val = 0;
 
-	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL))) {
-		grab_held_lock_entry(lock);
+	/*
+	 * Grab the deadlock detection entry before doing the cmpxchg, so that
+	 * reentrancy due to NMIs between the succeeding cmpxchg and creation of
+	 * held lock entry can correctly detect an acquisition attempt in the
+	 * interrupted context.
+	 *
+	 * cmpxchg lock A
+	 * <NMI>
+	 * res_spin_lock(A) --> missed AA, leads to timeout
+	 * </NMI>
+	 * grab_held_lock_entry(A)
+	 */
+	grab_held_lock_entry(lock);
+
+	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
 		return 0;
-	}
 	return resilient_queued_spin_lock_slowpath(lock, val);
 }
 
@@ -192,28 +199,25 @@ static __always_inline void res_spin_unlock(rqspinlock_t *lock)
 {
 	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
 
-	if (unlikely(rqh->cnt > RES_NR_HELD))
-		goto unlock;
-	WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
-unlock:
 	/*
-	 * Release barrier, ensures correct ordering. See release_held_lock_entry
-	 * for details.  Perform release store instead of queued_spin_unlock,
-	 * since we use this function for test-and-set fallback as well. When we
-	 * have CONFIG_QUEUED_SPINLOCKS=n, we clear the full 4-byte lockword.
+	 * Release barrier, ensures correct ordering. Perform release store
+	 * instead of queued_spin_unlock, since we use this function for the TAS
+	 * fallback as well. When we have CONFIG_QUEUED_SPINLOCKS=n, we clear
+	 * the full 4-byte lockword.
 	 *
-	 * Like release_held_lock_entry, we can do the release before the dec.
-	 * We simply care about not seeing the 'lock' in our table from a remote
-	 * CPU once the lock has been released, which doesn't rely on the dec.
+	 * Perform the smp_store_release before clearing the lock entry so that
+	 * NMIs landing in the unlock path can correctly detect AA issues. The
+	 * opposite order shown below may lead to missed AA checks:
 	 *
-	 * Unlike smp_wmb(), release is not a two way fence, hence it is
-	 * possible for a inc to move up and reorder with our clearing of the
-	 * entry. This isn't a problem however, as for a misdiagnosis of ABBA,
-	 * the remote CPU needs to hold this lock, which won't be released until
-	 * the store below is done, which would ensure the entry is overwritten
-	 * to NULL, etc.
+	 * WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL)
+	 * <NMI>
+	 * res_spin_lock(A) --> missed AA, leads to timeout
+	 * </NMI>
+	 * smp_store_release(A->locked, 0)
 	 */
 	smp_store_release(&lock->locked, 0);
+	if (likely(rqh->cnt <= RES_NR_HELD))
+		WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
 	this_cpu_dec(rqspinlock_held_locks.cnt);
 }
 
diff --git a/include/dt-bindings/clock/qcom,x1e80100-gcc.h b/include/dt-bindings/clock/qcom,x1e80100-gcc.h
index 710c340f24a5..62aa12425592 100644
--- a/include/dt-bindings/clock/qcom,x1e80100-gcc.h
+++ b/include/dt-bindings/clock/qcom,x1e80100-gcc.h
@@ -363,6 +363,30 @@
 #define GCC_USB3_PRIM_PHY_PIPE_CLK_SRC				353
 #define GCC_USB3_SEC_PHY_PIPE_CLK_SRC				354
 #define GCC_USB3_TERT_PHY_PIPE_CLK_SRC				355
+#define GCC_USB34_PRIM_PHY_PIPE_CLK_SRC				356
+#define GCC_USB34_SEC_PHY_PIPE_CLK_SRC				357
+#define GCC_USB34_TERT_PHY_PIPE_CLK_SRC				358
+#define GCC_USB4_0_PHY_DP0_CLK_SRC				359
+#define GCC_USB4_0_PHY_DP1_CLK_SRC				360
+#define GCC_USB4_0_PHY_P2RR2P_PIPE_CLK_SRC			361
+#define GCC_USB4_0_PHY_PCIE_PIPE_MUX_CLK_SRC			362
+#define GCC_USB4_0_PHY_RX0_CLK_SRC				363
+#define GCC_USB4_0_PHY_RX1_CLK_SRC				364
+#define GCC_USB4_0_PHY_SYS_CLK_SRC				365
+#define GCC_USB4_1_PHY_DP0_CLK_SRC				366
+#define GCC_USB4_1_PHY_DP1_CLK_SRC				367
+#define GCC_USB4_1_PHY_P2RR2P_PIPE_CLK_SRC			368
+#define GCC_USB4_1_PHY_PCIE_PIPE_MUX_CLK_SRC			369
+#define GCC_USB4_1_PHY_RX0_CLK_SRC				370
+#define GCC_USB4_1_PHY_RX1_CLK_SRC				371
+#define GCC_USB4_1_PHY_SYS_CLK_SRC				372
+#define GCC_USB4_2_PHY_DP0_CLK_SRC				373
+#define GCC_USB4_2_PHY_DP1_CLK_SRC				374
+#define GCC_USB4_2_PHY_P2RR2P_PIPE_CLK_SRC			375
+#define GCC_USB4_2_PHY_PCIE_PIPE_MUX_CLK_SRC			376
+#define GCC_USB4_2_PHY_RX0_CLK_SRC				377
+#define GCC_USB4_2_PHY_RX1_CLK_SRC				378
+#define GCC_USB4_2_PHY_SYS_CLK_SRC				379
 
 /* GCC power domains */
 #define GCC_PCIE_0_TUNNEL_GDSC					0
@@ -484,4 +508,41 @@
 #define GCC_VIDEO_BCR						87
 #define GCC_VIDEO_AXI0_CLK_ARES					88
 #define GCC_VIDEO_AXI1_CLK_ARES					89
+#define GCC_USB4_0_MISC_USB4_SYS_BCR				90
+#define GCC_USB4_0_MISC_RX_CLK_0_BCR				91
+#define GCC_USB4_0_MISC_RX_CLK_1_BCR				92
+#define GCC_USB4_0_MISC_USB_PIPE_BCR				93
+#define GCC_USB4_0_MISC_PCIE_PIPE_BCR				94
+#define GCC_USB4_0_MISC_TMU_BCR					95
+#define GCC_USB4_0_MISC_SB_IF_BCR				96
+#define GCC_USB4_0_MISC_HIA_MSTR_BCR				97
+#define GCC_USB4_0_MISC_AHB_BCR					98
+#define GCC_USB4_0_MISC_DP0_MAX_PCLK_BCR			99
+#define GCC_USB4_0_MISC_DP1_MAX_PCLK_BCR			100
+#define GCC_USB4_1_MISC_USB4_SYS_BCR				101
+#define GCC_USB4_1_MISC_RX_CLK_0_BCR				102
+#define GCC_USB4_1_MISC_RX_CLK_1_BCR				103
+#define GCC_USB4_1_MISC_USB_PIPE_BCR				104
+#define GCC_USB4_1_MISC_PCIE_PIPE_BCR				105
+#define GCC_USB4_1_MISC_TMU_BCR					106
+#define GCC_USB4_1_MISC_SB_IF_BCR				107
+#define GCC_USB4_1_MISC_HIA_MSTR_BCR				108
+#define GCC_USB4_1_MISC_AHB_BCR					109
+#define GCC_USB4_1_MISC_DP0_MAX_PCLK_BCR			110
+#define GCC_USB4_1_MISC_DP1_MAX_PCLK_BCR			111
+#define GCC_USB4_2_MISC_USB4_SYS_BCR				112
+#define GCC_USB4_2_MISC_RX_CLK_0_BCR				113
+#define GCC_USB4_2_MISC_RX_CLK_1_BCR				114
+#define GCC_USB4_2_MISC_USB_PIPE_BCR				115
+#define GCC_USB4_2_MISC_PCIE_PIPE_BCR				116
+#define GCC_USB4_2_MISC_TMU_BCR					117
+#define GCC_USB4_2_MISC_SB_IF_BCR				118
+#define GCC_USB4_2_MISC_HIA_MSTR_BCR				119
+#define GCC_USB4_2_MISC_AHB_BCR					120
+#define GCC_USB4_2_MISC_DP0_MAX_PCLK_BCR			121
+#define GCC_USB4_2_MISC_DP1_MAX_PCLK_BCR			122
+#define GCC_USB4PHY_PHY_PRIM_BCR				123
+#define GCC_USB4PHY_PHY_SEC_BCR					124
+#define GCC_USB4PHY_PHY_TERT_BCR				125
+
 #endif
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1d6e2df0fdd3..93d83aba236b 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -471,10 +471,7 @@ static inline bool op_is_discard(blk_opf_t op)
 }
 
 /*
- * Check if a bio or request operation is a zone management operation, with
- * the exception of REQ_OP_ZONE_RESET_ALL which is treated as a special case
- * due to its different handling in the block layer and device response in
- * case of command failure.
+ * Check if a bio or request operation is a zone management operation.
  */
 static inline bool op_is_zone_mgmt(enum req_op op)
 {
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 2573585b7f06..19c7e475d3a4 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -290,15 +290,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
 		class_##_name##_constructor
 
-#define scoped_class(_name, var, args)                          \
-	for (CLASS(_name, var)(args);                           \
-	     __guard_ptr(_name)(&var) || !__is_cond_ptr(_name); \
-	     ({ goto _label; }))                                \
-		if (0) {                                        \
-_label:                                                         \
-			break;                                  \
+#define __scoped_class(_name, var, _label, args...)        \
+	for (CLASS(_name, var)(args); ; ({ goto _label; })) \
+		if (0) {                                   \
+_label:                                                    \
+			break;                             \
 		} else
 
+#define scoped_class(_name, var, args...) \
+	__scoped_class(_name, var, __UNIQUE_ID(label), args)
+
 /*
  * DEFINE_GUARD(name, type, lock, unlock):
  *	trivial wrapper around DEFINE_CLASS() above specifically
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index bb49080ec8f9..b2b7f09ac382 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -252,15 +252,11 @@ struct coresight_trace_id_map {
  *		by @coresight_ops.
  * @access:	Device i/o access abstraction for this device.
  * @dev:	The device entity associated to this component.
- * @mode:	This tracer's mode, i.e sysFS, Perf or disabled. This is
- *		actually an 'enum cs_mode', but is stored in an atomic type.
- *		This is always accessed through local_read() and local_set(),
- *		but wherever it's done from within the Coresight device's lock,
- *		a non-atomic read would also work. This is the main point of
- *		synchronisation between code happening inside the sysfs mode's
- *		coresight_mutex and outside when running in Perf mode. A compare
- *		and exchange swap is done to atomically claim one mode or the
- *		other.
+ * @mode:	The device mode, i.e sysFS, Perf or disabled. This is actually
+ *		an 'enum cs_mode' but stored in an atomic type. Access is always
+ *		through atomic APIs, ensuring SMP-safe synchronisation between
+ *		racing from sysFS and Perf mode. A compare-and-exchange
+ *		operation is done to atomically claim one mode or the other.
  * @refcnt:	keep track of what is in use. Only access this outside of the
  *		device's spinlock when the coresight_mutex held and mode ==
  *		CS_MODE_SYSFS. Otherwise it must be accessed from inside the
@@ -289,7 +285,7 @@ struct coresight_device {
 	const struct coresight_ops *ops;
 	struct csdev_access access;
 	struct device dev;
-	local_t	mode;
+	atomic_t mode;
 	int refcnt;
 	bool orphan;
 	/* sink specific fields */
@@ -333,12 +329,14 @@ static struct coresight_dev_list (var) = {				\
 
 /**
  * struct coresight_path - data needed by enable/disable path
- * @path_list:              path from source to sink.
- * @trace_id:          trace_id of the whole path.
+ * @path_list:		path from source to sink.
+ * @trace_id:		trace_id of the whole path.
+ * @handle:		handle of the aux_event.
  */
 struct coresight_path {
-	struct list_head	path_list;
-	u8			trace_id;
+	struct list_head		path_list;
+	u8				trace_id;
+	struct perf_output_handle	*handle;
 };
 
 enum cs_mode {
@@ -649,13 +647,14 @@ static inline bool coresight_is_percpu_sink(struct coresight_device *csdev)
 static inline bool coresight_take_mode(struct coresight_device *csdev,
 				       enum cs_mode new_mode)
 {
-	return local_cmpxchg(&csdev->mode, CS_MODE_DISABLED, new_mode) ==
-	       CS_MODE_DISABLED;
+	int curr = CS_MODE_DISABLED;
+
+	return atomic_try_cmpxchg_acquire(&csdev->mode, &curr, new_mode);
 }
 
 static inline enum cs_mode coresight_get_mode(struct coresight_device *csdev)
 {
-	return local_read(&csdev->mode);
+	return atomic_read_acquire(&csdev->mode);
 }
 
 static inline void coresight_set_mode(struct coresight_device *csdev,
@@ -671,7 +670,7 @@ static inline void coresight_set_mode(struct coresight_device *csdev,
 	WARN(new_mode != CS_MODE_DISABLED && current_mode != CS_MODE_DISABLED &&
 	     current_mode != new_mode, "Device already in use\n");
 
-	local_set(&csdev->mode, new_mode);
+	atomic_set_release(&csdev->mode, new_mode);
 }
 
 struct coresight_device *coresight_register(struct coresight_desc *desc);
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 0ed60a91eca9..5b1236d8c65b 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -297,11 +297,11 @@ enum {
 #define CPER_ARM_INFO_FLAGS_PROPAGATED		BIT(2)
 #define CPER_ARM_INFO_FLAGS_OVERFLOW		BIT(3)
 
-#define CPER_ARM_CACHE_ERROR			0
-#define CPER_ARM_TLB_ERROR			1
-#define CPER_ARM_BUS_ERROR			2
-#define CPER_ARM_VENDOR_ERROR			3
-#define CPER_ARM_MAX_TYPE			CPER_ARM_VENDOR_ERROR
+#define CPER_ARM_ERR_TYPE_MASK			GENMASK(4,1)
+#define CPER_ARM_CACHE_ERROR			BIT(1)
+#define CPER_ARM_TLB_ERROR			BIT(2)
+#define CPER_ARM_BUS_ERROR			BIT(3)
+#define CPER_ARM_VENDOR_ERROR			BIT(4)
 
 #define CPER_ARM_ERR_VALID_TRANSACTION_TYPE	BIT(0)
 #define CPER_ARM_ERR_VALID_OPERATION_TYPE	BIT(1)
@@ -588,6 +588,8 @@ const char *cper_mem_err_type_str(unsigned int);
 const char *cper_mem_err_status_str(u64 status);
 void cper_print_bits(const char *prefix, unsigned int bits,
 		     const char * const strs[], unsigned int strs_size);
+int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
+		     const char * const strs[], unsigned int strs_size);
 void cper_mem_err_pack(const struct cper_sec_mem_err *,
 		       struct cper_mem_err_compact *);
 const char *cper_mem_err_unpack(struct trace_seq *,
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 6afb4a13b81d..a7880787cad3 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -17,6 +17,7 @@
 #define F2FS_LOG_SECTORS_PER_BLOCK	(PAGE_SHIFT - 9) /* log number for sector/blk */
 #define F2FS_BLKSIZE			PAGE_SIZE /* support only block == page */
 #define F2FS_BLKSIZE_BITS		PAGE_SHIFT /* bits for F2FS_BLKSIZE */
+#define F2FS_SUM_BLKSIZE		4096	/* only support 4096 byte sum block */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
 #define F2FS_EXTENSION_LEN		8	/* max size of extension */
 
@@ -441,7 +442,7 @@ struct f2fs_sit_block {
  * from node's page's beginning to get a data block address.
  * ex) data_blkaddr = (block_t)(nodepage_start_address + ofs_in_node)
  */
-#define ENTRIES_IN_SUM		(F2FS_BLKSIZE / 8)
+#define ENTRIES_IN_SUM		(F2FS_SUM_BLKSIZE / 8)
 #define	SUMMARY_SIZE		(7)	/* sizeof(struct f2fs_summary) */
 #define	SUM_FOOTER_SIZE		(5)	/* sizeof(struct summary_footer) */
 #define SUM_ENTRY_SIZE		(SUMMARY_SIZE * ENTRIES_IN_SUM)
@@ -467,7 +468,7 @@ struct summary_footer {
 	__le32 check_sum;		/* summary checksum */
 } __packed;
 
-#define SUM_JOURNAL_SIZE	(F2FS_BLKSIZE - SUM_FOOTER_SIZE -\
+#define SUM_JOURNAL_SIZE	(F2FS_SUM_BLKSIZE - SUM_FOOTER_SIZE -\
 				SUM_ENTRY_SIZE)
 #define NAT_JOURNAL_ENTRIES	((SUM_JOURNAL_SIZE - 2) /\
 				sizeof(struct nat_journal_entry))
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 152f2fc7b65a..70e2f5051676 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -709,11 +709,13 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
 
 		duration = sched_clock() - start;
-		stats = this_cpu_ptr(prog->stats);
-		flags = u64_stats_update_begin_irqsave(&stats->syncp);
-		u64_stats_inc(&stats->cnt);
-		u64_stats_add(&stats->nsecs, duration);
-		u64_stats_update_end_irqrestore(&stats->syncp, flags);
+		if (likely(prog->stats)) {
+			stats = this_cpu_ptr(prog->stats);
+			flags = u64_stats_update_begin_irqsave(&stats->syncp);
+			u64_stats_inc(&stats->cnt);
+			u64_stats_add(&stats->nsecs, duration);
+			u64_stats_update_end_irqrestore(&stats->syncp, flags);
+		}
 	} else {
 		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
 	}
diff --git a/include/linux/firmware/qcom/qcom_tzmem.h b/include/linux/firmware/qcom/qcom_tzmem.h
index b83b63a0c049..e1e26dc4180e 100644
--- a/include/linux/firmware/qcom/qcom_tzmem.h
+++ b/include/linux/firmware/qcom/qcom_tzmem.h
@@ -17,11 +17,20 @@ struct qcom_tzmem_pool;
  * enum qcom_tzmem_policy - Policy for pool growth.
  */
 enum qcom_tzmem_policy {
-	/**< Static pool, never grow above initial size. */
+	/**
+	 * @QCOM_TZMEM_POLICY_STATIC: Static pool,
+	 * never grow above initial size.
+	 */
 	QCOM_TZMEM_POLICY_STATIC = 1,
-	/**< When out of memory, add increment * current size of memory. */
+	/**
+	 * @QCOM_TZMEM_POLICY_MULTIPLIER: When out of memory,
+	 * add increment * current size of memory.
+	 */
 	QCOM_TZMEM_POLICY_MULTIPLIER,
-	/**< When out of memory add as much as is needed until max_size. */
+	/**
+	 * @QCOM_TZMEM_POLICY_ON_DEMAND: When out of memory
+	 * add as much as is needed until max_size.
+	 */
 	QCOM_TZMEM_POLICY_ON_DEMAND,
 };
 
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index e5a2096e022e..e3562770ffff 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3572,8 +3572,8 @@ enum ieee80211_statuscode {
 	WLAN_STATUS_DENIED_WITH_SUGGESTED_BAND_AND_CHANNEL = 99,
 	WLAN_STATUS_DENIED_DUE_TO_SPECTRUM_MANAGEMENT = 103,
 	/* 802.11ai */
-	WLAN_STATUS_FILS_AUTHENTICATION_FAILURE = 108,
-	WLAN_STATUS_UNKNOWN_AUTHENTICATION_SERVER = 109,
+	WLAN_STATUS_FILS_AUTHENTICATION_FAILURE = 112,
+	WLAN_STATUS_UNKNOWN_AUTHENTICATION_SERVER = 113,
 	WLAN_STATUS_SAE_HASH_TO_ELEMENT = 126,
 	WLAN_STATUS_SAE_PK = 127,
 	WLAN_STATUS_DENIED_TID_TO_LINK_MAPPING = 133,
diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index d7941fd88032..f4cf2dd36d19 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -43,6 +43,8 @@ extern bool is_hsr_master(struct net_device *dev);
 extern int hsr_get_version(struct net_device *dev, enum hsr_version *ver);
 struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 				     enum hsr_port_type pt);
+int hsr_get_port_type(struct net_device *hsr_dev, struct net_device *dev,
+		      enum hsr_port_type *type);
 #else
 static inline bool is_hsr_master(struct net_device *dev)
 {
@@ -59,6 +61,13 @@ static inline struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static inline int hsr_get_port_type(struct net_device *hsr_dev,
+				    struct net_device *dev,
+				    enum hsr_port_type *type)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_HSR */
 
 #endif /*_LINUX_IF_HSR_H_*/
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index d643c7c87822..ba1ed42f8a1c 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -253,11 +253,11 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
 static __always_inline void exit_to_user_mode(void)
 {
 	instrumentation_begin();
+	unwind_reset_info();
 	trace_hardirqs_on_prepare();
 	lockdep_hardirqs_on_prepare();
 	instrumentation_end();
 
-	unwind_reset_info();
 	user_enter_irqoff();
 	arch_exit_to_user_mode();
 	lockdep_hardirqs_on(CALLER_ADDR0);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index d30c0245031c..30ac384e011a 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -172,6 +172,11 @@ struct nfs_server {
 #define NFS_MOUNT_FORCE_RDIRPLUS	0x20000000
 #define NFS_MOUNT_NETUNREACH_FATAL	0x40000000
 
+	unsigned int		automount_inherit; /* Properties inherited by automount */
+#define NFS_AUTOMOUNT_INHERIT_BSIZE	0x0001
+#define NFS_AUTOMOUNT_INHERIT_RSIZE	0x0002
+#define NFS_AUTOMOUNT_INHERIT_WSIZE	0x0004
+
 	unsigned int		caps;		/* server capabilities */
 	__u64			fattr_valid;	/* Valid attributes */
 	unsigned int		rsize;		/* read size */
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index b8d6c0c20876..51dadbaa3d63 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -55,6 +55,15 @@ extern int of_get_flat_dt_subnode_by_name(unsigned long node,
 					  const char *uname);
 extern const void *of_get_flat_dt_prop(unsigned long node, const char *name,
 				       int *size);
+
+extern const __be32 *of_flat_dt_get_addr_size_prop(unsigned long node,
+						   const char *name,
+						   int *entries);
+extern bool of_flat_dt_get_addr_size(unsigned long node, const char *name,
+				     u64 *addr, u64 *size);
+extern void of_flat_dt_read_addr_size(const __be32 *prop, int entry_index,
+				      u64 *addr, u64 *size);
+
 extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern unsigned long of_get_flat_dt_root(void);
 extern uint32_t of_get_flat_dt_phandle(unsigned long node);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ec9d96025683..54e0d31afcad 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1719,7 +1719,7 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 04553419adc3..2640ce96db3f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1795,6 +1795,9 @@ static inline bool phy_is_pseudo_fixed_link(struct phy_device *phydev)
 	return phydev->is_pseudo_fixed_link;
 }
 
+phy_interface_t phy_fix_phy_mode_for_mac_delays(phy_interface_t interface,
+						bool mac_txid, bool mac_rxid);
+
 int phy_save_page(struct phy_device *phydev);
 int phy_select_page(struct phy_device *phydev, int page);
 int phy_restore_page(struct phy_device *phydev, int oldpage, int ret);
diff --git a/include/linux/platform_data/lp855x.h b/include/linux/platform_data/lp855x.h
index ab222dd05bbc..3b4a891acefe 100644
--- a/include/linux/platform_data/lp855x.h
+++ b/include/linux/platform_data/lp855x.h
@@ -124,12 +124,12 @@ struct lp855x_rom_data {
 };
 
 /**
- * struct lp855x_platform_data
+ * struct lp855x_platform_data - lp855 platform-specific data
  * @name : Backlight driver name. If it is not defined, default name is set.
  * @device_control : value of DEVICE CONTROL register
  * @initial_brightness : initial value of backlight brightness
  * @period_ns : platform specific pwm period value. unit is nano.
-		Only valid when mode is PWM_BASED.
+ *		Only valid when mode is PWM_BASED.
  * @size_program : total size of lp855x_rom_data
  * @rom_data : list of new eeprom/eprom registers
  */
diff --git a/include/linux/ras.h b/include/linux/ras.h
index a64182bc72ad..468941bfe855 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -24,8 +24,7 @@ int __init parse_cec_param(char *str);
 void log_non_standard_event(const guid_t *sec_type,
 			    const guid_t *fru_id, const char *fru_text,
 			    const u8 sev, const u8 *err, const u32 len);
-void log_arm_hw_error(struct cper_sec_proc_arm *err);
-
+void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev);
 #else
 static inline void
 log_non_standard_event(const guid_t *sec_type,
@@ -33,7 +32,7 @@ log_non_standard_event(const guid_t *sec_type,
 		       const u8 sev, const u8 *err, const u32 len)
 { return; }
 static inline void
-log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
+log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev) { return; }
 #endif
 
 struct atl_err {
@@ -53,4 +52,15 @@ static inline unsigned long
 amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
 #endif /* CONFIG_AMD_ATL */
 
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+#include <asm/smp_plat.h>
+/*
+ * Include ARM-specific SMP header which provides a function mapping mpidr to
+ * CPU logical index.
+ */
+#define GET_LOGICAL_INDEX(mpidr) get_logical_index(mpidr & MPIDR_HWID_BITMASK)
+#else
+#define GET_LOGICAL_INDEX(mpidr) -EINVAL
+#endif /* CONFIG_ARM || CONFIG_ARM64 */
+
 #endif /* __RAS_H__ */
diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 89186c499dd4..c26cb83ca071 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
 #define hlist_nulls_next_rcu(node) \
 	(*((struct hlist_nulls_node __rcu __force **)&(node)->next))
 
+/**
+ * hlist_nulls_pprev_rcu - returns the dereferenced pprev of @node.
+ * @node: element of the list.
+ */
+#define hlist_nulls_pprev_rcu(node) \
+	(*((struct hlist_nulls_node __rcu __force **)(node)->pprev))
+
 /**
  * hlist_nulls_del_rcu - deletes entry from hash list without re-initialization
  * @n: the element to delete from the hash list.
@@ -152,6 +159,58 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
 	n->next = (struct hlist_nulls_node *)NULLS_MARKER(NULL);
 }
 
+/**
+ * hlist_nulls_replace_rcu - replace an old entry by a new one
+ * @old: the element to be replaced
+ * @new: the new element to insert
+ *
+ * Description:
+ * Replace the old entry with the new one in a RCU-protected hlist_nulls, while
+ * permitting racing traversals.
+ *
+ * The caller must take whatever precautions are necessary (such as holding
+ * appropriate locks) to avoid racing with another list-mutation primitive, such
+ * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
+ * list.  However, it is perfectly legal to run concurrently with the _rcu
+ * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
+ */
+static inline void hlist_nulls_replace_rcu(struct hlist_nulls_node *old,
+					   struct hlist_nulls_node *new)
+{
+	struct hlist_nulls_node *next = old->next;
+
+	WRITE_ONCE(new->next, next);
+	WRITE_ONCE(new->pprev, old->pprev);
+	rcu_assign_pointer(hlist_nulls_pprev_rcu(new), new);
+	if (!is_a_nulls(next))
+		WRITE_ONCE(next->pprev, &new->next);
+}
+
+/**
+ * hlist_nulls_replace_init_rcu - replace an old entry by a new one and
+ * initialize the old
+ * @old: the element to be replaced
+ * @new: the new element to insert
+ *
+ * Description:
+ * Replace the old entry with the new one in a RCU-protected hlist_nulls, while
+ * permitting racing traversals, and reinitialize the old entry.
+ *
+ * Note: @old must be hashed.
+ *
+ * The caller must take whatever precautions are necessary (such as holding
+ * appropriate locks) to avoid racing with another list-mutation primitive, such
+ * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
+ * list. However, it is perfectly legal to run concurrently with the _rcu
+ * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
+ */
+static inline void hlist_nulls_replace_init_rcu(struct hlist_nulls_node *old,
+						struct hlist_nulls_node *new)
+{
+	hlist_nulls_replace_rcu(old, new);
+	WRITE_ONCE(old->pprev, NULL);
+}
+
 /**
  * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
  * @tpos:	the type * to use as a loop cursor.
diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/mediatek/mtk_wed.h
index d8949a4ed0dc..8d34bee714e8 100644
--- a/include/linux/soc/mediatek/mtk_wed.h
+++ b/include/linux/soc/mediatek/mtk_wed.h
@@ -154,6 +154,7 @@ struct mtk_wed_device {
 		bool wcid_512;
 		bool hw_rro;
 		bool msi;
+		bool hif2;
 
 		u16 token_start;
 		unsigned int nbuf;
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 332ddb93603e..660c254f1efe 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -270,4 +270,18 @@ static inline void tty_port_tty_vhangup(struct tty_port *port)
 	__tty_port_tty_hangup(port, false, false);
 }
 
+#ifdef CONFIG_TTY
+void tty_kref_put(struct tty_struct *tty);
+__DEFINE_CLASS_IS_CONDITIONAL(tty_port_tty, true);
+__DEFINE_UNLOCK_GUARD(tty_port_tty, struct tty_struct, tty_kref_put(_T->lock));
+static inline class_tty_port_tty_t class_tty_port_tty_constructor(struct tty_port *tport)
+{
+	class_tty_port_tty_t _t = {
+		.lock = tty_port_tty_get(tport),
+	};
+	return _t;
+}
+#define scoped_tty()	((struct tty_struct *)(__guard_ptr(tty_port_tty)(&scope)))
+#endif
+
 #endif
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index f541044e42a2..f5c93787f8e0 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/vfio.h>
 #include <linux/irqbypass.h>
+#include <linux/rcupdate.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/notifier.h>
@@ -27,6 +28,11 @@
 struct vfio_pci_core_device;
 struct vfio_pci_region;
 
+struct vfio_pci_eventfd {
+	struct eventfd_ctx	*ctx;
+	struct rcu_head		rcu;
+};
+
 struct vfio_pci_regops {
 	ssize_t (*rw)(struct vfio_pci_core_device *vdev, char __user *buf,
 		      size_t count, loff_t *ppos, bool iswrite);
@@ -83,8 +89,8 @@ struct vfio_pci_core_device {
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;
-	struct eventfd_ctx	*err_trigger;
-	struct eventfd_ctx	*req_trigger;
+	struct vfio_pci_eventfd __rcu *err_trigger;
+	struct vfio_pci_eventfd __rcu *req_trigger;
 	struct eventfd_ctx	*pm_wake_eventfd_ctx;
 	struct list_head	dummy_resources_list;
 	struct mutex		ioeventfds_lock;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index db31fc6f4f1f..bbeb55f478b5 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -166,7 +166,7 @@ struct virtio_device {
 	void *priv;
 #ifdef CONFIG_VIRTIO_DEBUG
 	struct dentry *debugfs_dir;
-	u64 debugfs_filter_features[VIRTIO_FEATURES_DWORDS];
+	u64 debugfs_filter_features[VIRTIO_FEATURES_U64S];
 #endif
 };
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 7427b79d6f3d..7e10fe010527 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -24,7 +24,7 @@ typedef void vq_callback_t(struct virtqueue *);
  *        a virtqueue unused by the driver.
  * @callback: A callback to invoke on a used buffer notification.
  *            NULL for a virtqueue that does not need a callback.
- * @ctx: A flag to indicate to maintain an extra context per virtqueue.
+ * @ctx: whether to maintain an extra context per virtqueue.
  */
 struct virtqueue_info {
 	const char *name;
@@ -80,13 +80,13 @@ struct virtqueue_info {
  *	Returns the first 64 feature bits.
  * @get_extended_features:
  *      vdev: the virtio_device
- *      Returns the first VIRTIO_FEATURES_MAX feature bits (all we currently
+ *      Returns the first VIRTIO_FEATURES_BITS feature bits (all we currently
  *      need).
  * @finalize_features: confirm what device features we'll be using.
  *	vdev: the virtio_device
  *	This sends the driver feature bits to the device: it can change
  *	the dev->feature bits if it wants.
- *	Note that despite the name this	can be called any number of
+ *	Note that despite the name this can be called any number of
  *	times.
  *	Returns 0 on success or error status
  * @bus_name: return the bus name associated with the device (optional)
@@ -290,7 +290,7 @@ void virtio_device_ready(struct virtio_device *dev)
 	 * specific set_status() method.
 	 *
 	 * A well behaved device will only notify a virtqueue after
-	 * DRIVER_OK, this means the device should "see" the coherenct
+	 * DRIVER_OK, this means the device should "see" the coherent
 	 * memory write that set vq->broken as false which is done by
 	 * the driver when it sees DRIVER_OK, then the following
 	 * driver's vring_interrupt() will see vq->broken as false so
@@ -312,7 +312,7 @@ const char *virtio_bus_name(struct virtio_device *vdev)
  * @vq: the virtqueue
  * @cpu_mask: the cpu mask
  *
- * Pay attention the function are best-effort: the affinity hint may not be set
+ * Note that this function is best-effort: the affinity hint may not be set
  * due to config support, irq type and sharing.
  *
  */
diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
index f748f2f87de8..ea2ad8717882 100644
--- a/include/linux/virtio_features.h
+++ b/include/linux/virtio_features.h
@@ -4,15 +4,16 @@
 
 #include <linux/bits.h>
 
-#define VIRTIO_FEATURES_DWORDS	2
-#define VIRTIO_FEATURES_MAX	(VIRTIO_FEATURES_DWORDS * 64)
-#define VIRTIO_FEATURES_WORDS	(VIRTIO_FEATURES_DWORDS * 2)
+#define VIRTIO_FEATURES_U64S	2
+#define VIRTIO_FEATURES_BITS	(VIRTIO_FEATURES_U64S * 64)
+
 #define VIRTIO_BIT(b)		BIT_ULL((b) & 0x3f)
-#define VIRTIO_DWORD(b)		((b) >> 6)
+#define VIRTIO_U64(b)		((b) >> 6)
+
 #define VIRTIO_DECLARE_FEATURES(name)			\
 	union {						\
 		u64 name;				\
-		u64 name##_array[VIRTIO_FEATURES_DWORDS];\
+		u64 name##_array[VIRTIO_FEATURES_U64S];\
 	}
 
 static inline bool virtio_features_chk_bit(unsigned int bit)
@@ -22,9 +23,9 @@ static inline bool virtio_features_chk_bit(unsigned int bit)
 		 * Don't care returning the correct value: the build
 		 * will fail before any bad features access
 		 */
-		BUILD_BUG_ON(bit >= VIRTIO_FEATURES_MAX);
+		BUILD_BUG_ON(bit >= VIRTIO_FEATURES_BITS);
 	} else {
-		if (WARN_ON_ONCE(bit >= VIRTIO_FEATURES_MAX))
+		if (WARN_ON_ONCE(bit >= VIRTIO_FEATURES_BITS))
 			return false;
 	}
 	return true;
@@ -34,26 +35,26 @@ static inline bool virtio_features_test_bit(const u64 *features,
 					    unsigned int bit)
 {
 	return virtio_features_chk_bit(bit) &&
-	       !!(features[VIRTIO_DWORD(bit)] & VIRTIO_BIT(bit));
+	       !!(features[VIRTIO_U64(bit)] & VIRTIO_BIT(bit));
 }
 
 static inline void virtio_features_set_bit(u64 *features,
 					   unsigned int bit)
 {
 	if (virtio_features_chk_bit(bit))
-		features[VIRTIO_DWORD(bit)] |= VIRTIO_BIT(bit);
+		features[VIRTIO_U64(bit)] |= VIRTIO_BIT(bit);
 }
 
 static inline void virtio_features_clear_bit(u64 *features,
 					     unsigned int bit)
 {
 	if (virtio_features_chk_bit(bit))
-		features[VIRTIO_DWORD(bit)] &= ~VIRTIO_BIT(bit);
+		features[VIRTIO_U64(bit)] &= ~VIRTIO_BIT(bit);
 }
 
 static inline void virtio_features_zero(u64 *features)
 {
-	memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_DWORDS);
+	memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_U64S);
 }
 
 static inline void virtio_features_from_u64(u64 *features, u64 from)
@@ -66,7 +67,7 @@ static inline bool virtio_features_equal(const u64 *f1, const u64 *f2)
 {
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i)
+	for (i = 0; i < VIRTIO_FEATURES_U64S; ++i)
 		if (f1[i] != f2[i])
 			return false;
 	return true;
@@ -74,14 +75,14 @@ static inline bool virtio_features_equal(const u64 *f1, const u64 *f2)
 
 static inline void virtio_features_copy(u64 *to, const u64 *from)
 {
-	memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_DWORDS);
+	memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_U64S);
 }
 
 static inline void virtio_features_andnot(u64 *to, const u64 *f1, const u64 *f2)
 {
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++)
+	for (i = 0; i < VIRTIO_FEATURES_U64S; i++)
 		to[i] = f1[i] & ~f2[i];
 }
 
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 48bc12d1045b..9a3f2fc53bd6 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -107,7 +107,7 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
 static inline u64
 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
 {
-	u64 features_array[VIRTIO_FEATURES_DWORDS];
+	u64 features_array[VIRTIO_FEATURES_U64S];
 
 	vp_modern_get_extended_features(mdev, features_array);
 	return features_array[0];
@@ -116,11 +116,11 @@ vp_modern_get_features(struct virtio_pci_modern_device *mdev)
 static inline u64
 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
 {
-	u64 features_array[VIRTIO_FEATURES_DWORDS];
+	u64 features_array[VIRTIO_FEATURES_U64S];
 	int i;
 
 	vp_modern_get_driver_extended_features(mdev, features_array);
-	for (i = 1; i < VIRTIO_FEATURES_DWORDS; ++i)
+	for (i = 1; i < VIRTIO_FEATURES_U64S; ++i)
 		WARN_ON_ONCE(features_array[i]);
 	return features_array[0];
 }
@@ -128,7 +128,7 @@ vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
 static inline void
 vp_modern_set_features(struct virtio_pci_modern_device *mdev, u64 features)
 {
-	u64 features_array[VIRTIO_FEATURES_DWORDS];
+	u64 features_array[VIRTIO_FEATURES_U64S];
 
 	virtio_features_from_u64(features_array, features);
 	vp_modern_set_extended_features(mdev, features_array);
diff --git a/include/net/netfilter/nf_conntrack_count.h b/include/net/netfilter/nf_conntrack_count.h
index 1b58b5b91ff6..52a06de41aa0 100644
--- a/include/net/netfilter/nf_conntrack_count.h
+++ b/include/net/netfilter/nf_conntrack_count.h
@@ -18,15 +18,14 @@ struct nf_conncount_list {
 struct nf_conncount_data *nf_conncount_init(struct net *net, unsigned int keylen);
 void nf_conncount_destroy(struct net *net, struct nf_conncount_data *data);
 
-unsigned int nf_conncount_count(struct net *net,
-				struct nf_conncount_data *data,
-				const u32 *key,
-				const struct nf_conntrack_tuple *tuple,
-				const struct nf_conntrack_zone *zone);
-
-int nf_conncount_add(struct net *net, struct nf_conncount_list *list,
-		     const struct nf_conntrack_tuple *tuple,
-		     const struct nf_conntrack_zone *zone);
+unsigned int nf_conncount_count_skb(struct net *net,
+				    const struct sk_buff *skb,
+				    u16 l3num,
+				    struct nf_conncount_data *data,
+				    const u32 *key);
+
+int nf_conncount_add_skb(struct net *net, const struct sk_buff *skb,
+			 u16 l3num, struct nf_conncount_list *list);
 
 void nf_conncount_list_init(struct nf_conncount_list *list);
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 57c0df29ee96..5ab31eb69acb 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -850,6 +850,19 @@ static inline bool sk_nulls_del_node_init_rcu(struct sock *sk)
 	return rc;
 }
 
+static inline bool sk_nulls_replace_node_init_rcu(struct sock *old,
+						  struct sock *new)
+{
+	if (sk_hashed(old)) {
+		hlist_nulls_replace_init_rcu(&old->sk_nulls_node,
+					     &new->sk_nulls_node);
+		__sock_put(old);
+		return true;
+	}
+
+	return false;
+}
+
 static inline void __sk_add_node(struct sock *sk, struct hlist_head *list)
 {
 	hlist_add_head(&sk->sk_node, list);
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index c8cd0f00c845..c9f0b1018bcc 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -168,11 +168,25 @@ TRACE_EVENT(mc_event,
  * This event is generated when hardware detects an ARM processor error
  * has occurred. UEFI 2.6 spec section N.2.4.4.
  */
+#define APEIL "ARM Processor Err Info data len"
+#define APEID "ARM Processor Err Info raw data"
+#define APECIL "ARM Processor Err Context Info data len"
+#define APECID "ARM Processor Err Context Info raw data"
+#define VSEIL "Vendor Specific Err Info data len"
+#define VSEID "Vendor Specific Err Info raw data"
 TRACE_EVENT(arm_event,
 
-	TP_PROTO(const struct cper_sec_proc_arm *proc),
+	TP_PROTO(const struct cper_sec_proc_arm *proc,
+		 const u8 *pei_err,
+		 const u32 pei_len,
+		 const u8 *ctx_err,
+		 const u32 ctx_len,
+		 const u8 *oem,
+		 const u32 oem_len,
+		 u8 sev,
+		 int cpu),
 
-	TP_ARGS(proc),
+	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len, sev, cpu),
 
 	TP_STRUCT__entry(
 		__field(u64, mpidr)
@@ -180,6 +194,14 @@ TRACE_EVENT(arm_event,
 		__field(u32, running_state)
 		__field(u32, psci_state)
 		__field(u8, affinity)
+		__field(u32, pei_len)
+		__dynamic_array(u8, pei_buf, pei_len)
+		__field(u32, ctx_len)
+		__dynamic_array(u8, ctx_buf, ctx_len)
+		__field(u32, oem_len)
+		__dynamic_array(u8, oem_buf, oem_len)
+		__field(u8, sev)
+		__field(int, cpu)
 	),
 
 	TP_fast_assign(
@@ -199,12 +221,29 @@ TRACE_EVENT(arm_event,
 			__entry->running_state = ~0;
 			__entry->psci_state = ~0;
 		}
+		__entry->pei_len = pei_len;
+		memcpy(__get_dynamic_array(pei_buf), pei_err, pei_len);
+		__entry->ctx_len = ctx_len;
+		memcpy(__get_dynamic_array(ctx_buf), ctx_err, ctx_len);
+		__entry->oem_len = oem_len;
+		memcpy(__get_dynamic_array(oem_buf), oem, oem_len);
+		__entry->sev = sev;
+		__entry->cpu = cpu;
 	),
 
-	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
-		  "running state: %d; PSCI state: %d",
+	TP_printk("cpu: %d; error: %d; affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
+		  "running state: %d; PSCI state: %d; "
+		  "%s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s: %s",
+		  __entry->cpu,
+		  __entry->sev,
 		  __entry->affinity, __entry->mpidr, __entry->midr,
-		  __entry->running_state, __entry->psci_state)
+		  __entry->running_state, __entry->psci_state,
+		  APEIL, __entry->pei_len, APEID,
+		  __print_hex(__get_dynamic_array(pei_buf), __entry->pei_len),
+		  APECIL, __entry->ctx_len, APECID,
+		  __print_hex(__get_dynamic_array(ctx_buf), __entry->ctx_len),
+		  VSEIL, __entry->oem_len, VSEID,
+		  __print_hex(__get_dynamic_array(oem_buf), __entry->oem_len))
 );
 
 /*
diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index 3875e92f1ec5..8e016c9a32dd 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -183,7 +183,6 @@ struct tasdevice_priv {
 	struct acoustic_data acou_data;
 #endif
 	struct tasdevice_fw *fmw;
-	struct gpio_desc *speaker_id;
 	struct gpio_desc *reset;
 	struct mutex codec_lock;
 	struct regmap *regmap;
@@ -200,6 +199,7 @@ struct tasdevice_priv {
 	unsigned int magic_num;
 	unsigned int chip_id;
 	unsigned int sysclk;
+	int speaker_id;
 
 	int irq;
 	int cur_prog;
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index c4d9116904aa..27e1f9d5f0c6 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -671,9 +671,9 @@ struct se_lun_acl {
 };
 
 struct se_dev_entry_io_stats {
-	u32			total_cmds;
-	u32			read_bytes;
-	u32			write_bytes;
+	u64			total_cmds;
+	u64			read_bytes;
+	u64			write_bytes;
 };
 
 struct se_dev_entry {
@@ -806,9 +806,9 @@ struct se_device_queue {
 };
 
 struct se_dev_io_stats {
-	u32			total_cmds;
-	u32			read_bytes;
-	u32			write_bytes;
+	u64			total_cmds;
+	u64			read_bytes;
+	u64			write_bytes;
 };
 
 struct se_device {
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 957db425d459..6ccbabd9a68d 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -28,6 +28,7 @@
 #define PIDFD_INFO_COREDUMP		(1UL << 4) /* Only returned if requested. */
 
 #define PIDFD_INFO_SIZE_VER0		64 /* sizeof first published struct */
+#define PIDFD_INFO_SIZE_VER1		72 /* sizeof second published struct */
 
 /*
  * Values for @coredump_mask in pidfd_info.
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 5a049eeaecce..d3ce75ba938a 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -60,7 +60,7 @@ struct snd_cea_861_aud_if {
 	unsigned char db2_sf_ss; /* sample frequency and size */
 	unsigned char db3; /* not used, all zeros */
 	unsigned char db4_ca; /* channel allocation code */
-	unsigned char db5_dminh_lsv; /* downmix inhibit & level-shit values */
+	unsigned char db5_dminh_lsv; /* downmix inhibit & level-shift values */
 };
 
 /****************************************************************************
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index ace8b9c33f1f..0303103e8cac 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1328,7 +1328,6 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 
 void ufshcd_enable_irq(struct ufs_hba *hba);
 void ufshcd_disable_irq(struct ufs_hba *hba);
-void ufshcd_enable_intr(struct ufs_hba *hba, u32 intrs);
 int ufshcd_alloc_host(struct device *, struct ufs_hba **);
 int ufshcd_hba_enable(struct ufs_hba *hba);
 int ufshcd_init(struct ufs_hba *, void __iomem *, unsigned int);
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 93665cebe9bd..44afe57cbd65 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3570,10 +3570,6 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 
 	if (!(ctx->flags & IORING_SETUP_NO_SQARRAY))
 		ctx->sq_array = (u32 *)((char *)rings + sq_array_offset);
-	rings->sq_ring_mask = p->sq_entries - 1;
-	rings->cq_ring_mask = p->cq_entries - 1;
-	rings->sq_ring_entries = p->sq_entries;
-	rings->cq_ring_entries = p->cq_entries;
 
 	if (p->flags & IORING_SETUP_SQE128)
 		size = array_size(2 * sizeof(struct io_uring_sqe), p->sq_entries);
@@ -3596,6 +3592,12 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 		return ret;
 	}
 	ctx->sq_sqes = io_region_get_ptr(&ctx->sq_region);
+
+	memset(rings, 0, sizeof(*rings));
+	WRITE_ONCE(rings->sq_ring_mask, ctx->sq_entries - 1);
+	WRITE_ONCE(rings->cq_ring_mask, ctx->cq_entries - 1);
+	WRITE_ONCE(rings->sq_ring_entries, ctx->sq_entries);
+	WRITE_ONCE(rings->cq_ring_entries, ctx->cq_entries);
 	return 0;
 }
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 71f9931ac64c..f3bc22ea503f 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -939,15 +939,21 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 			    void *value, bool onallcpus)
 {
+	void *ptr;
+
 	if (!onallcpus) {
 		/* copy true value_size bytes */
-		copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
+		ptr = this_cpu_ptr(pptr);
+		copy_map_value(&htab->map, ptr, value);
+		bpf_obj_free_fields(htab->map.record, ptr);
 	} else {
 		u32 size = round_up(htab->map.value_size, 8);
 		int off = 0, cpu;
 
 		for_each_possible_cpu(cpu) {
-			copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value + off);
+			ptr = per_cpu_ptr(pptr, cpu);
+			copy_map_value_long(&htab->map, ptr, value + off);
+			bpf_obj_free_fields(htab->map.record, ptr);
 			off += size;
 		}
 	}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3eb02ce0dba3..722314912ba8 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -774,9 +774,11 @@ int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
 {
 	int nest_level;
 
+	preempt_disable();
 	nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
 	if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
 		this_cpu_dec(bpf_bprintf_nest_level);
+		preempt_enable();
 		return -EBUSY;
 	}
 	*bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
@@ -789,6 +791,7 @@ void bpf_put_buffers(void)
 	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
 		return;
 	this_cpu_dec(bpf_bprintf_nest_level);
+	preempt_enable();
 }
 
 void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index a00561b1d3e5..3faf9cbd6c75 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -89,15 +89,14 @@ struct rqspinlock_timeout {
 DEFINE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
 EXPORT_SYMBOL_GPL(rqspinlock_held_locks);
 
-static bool is_lock_released(rqspinlock_t *lock, u32 mask, struct rqspinlock_timeout *ts)
+static bool is_lock_released(rqspinlock_t *lock, u32 mask)
 {
 	if (!(atomic_read_acquire(&lock->val) & (mask)))
 		return true;
 	return false;
 }
 
-static noinline int check_deadlock_AA(rqspinlock_t *lock, u32 mask,
-				      struct rqspinlock_timeout *ts)
+static noinline int check_deadlock_AA(rqspinlock_t *lock)
 {
 	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
 	int cnt = min(RES_NR_HELD, rqh->cnt);
@@ -118,8 +117,7 @@ static noinline int check_deadlock_AA(rqspinlock_t *lock, u32 mask,
  * more locks, which reduce to ABBA). This is not exhaustive, and we rely on
  * timeouts as the final line of defense.
  */
-static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
-					struct rqspinlock_timeout *ts)
+static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask)
 {
 	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
 	int rqh_cnt = min(RES_NR_HELD, rqh->cnt);
@@ -142,7 +140,7 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
 		 * Let's ensure to break out of this loop if the lock is available for
 		 * us to potentially acquire.
 		 */
-		if (is_lock_released(lock, mask, ts))
+		if (is_lock_released(lock, mask))
 			return 0;
 
 		/*
@@ -198,15 +196,14 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
 	return 0;
 }
 
-static noinline int check_deadlock(rqspinlock_t *lock, u32 mask,
-				   struct rqspinlock_timeout *ts)
+static noinline int check_deadlock(rqspinlock_t *lock, u32 mask)
 {
 	int ret;
 
-	ret = check_deadlock_AA(lock, mask, ts);
+	ret = check_deadlock_AA(lock);
 	if (ret)
 		return ret;
-	ret = check_deadlock_ABBA(lock, mask, ts);
+	ret = check_deadlock_ABBA(lock, mask);
 	if (ret)
 		return ret;
 
@@ -234,7 +231,7 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 	 */
 	if (prev + NSEC_PER_MSEC < time) {
 		ts->cur = time;
-		return check_deadlock(lock, mask, ts);
+		return check_deadlock(lock, mask);
 	}
 
 	return 0;
@@ -278,6 +275,10 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	int val, ret = 0;
 
 	RES_INIT_TIMEOUT(ts);
+	/*
+	 * The fast path is not invoked for the TAS fallback, so we must grab
+	 * the deadlock detection entry here.
+	 */
 	grab_held_lock_entry(lock);
 
 	/*
@@ -400,10 +401,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 		goto queue;
 	}
 
-	/*
-	 * Grab an entry in the held locks array, to enable deadlock detection.
-	 */
-	grab_held_lock_entry(lock);
+	/* Deadlock detection entry already held after failing fast path. */
 
 	/*
 	 * We're pending, wait for the owner to go away.
@@ -451,11 +449,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 queue:
 	lockevent_inc(lock_slowpath);
-	/*
-	 * Grab deadlock detection entry for the queue path.
-	 */
-	grab_held_lock_entry(lock);
-
+	/* Deadlock detection entry already held after failing fast path. */
 	node = this_cpu_ptr(&rqnodes[0].mcs);
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
@@ -471,7 +465,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * any MCS node. This is not the most elegant solution, but is
 	 * simple enough.
 	 */
-	if (unlikely(idx >= _Q_MAX_NODES || in_nmi())) {
+	if (unlikely(idx >= _Q_MAX_NODES || (in_nmi() && idx > 0))) {
 		lockevent_inc(lock_no_node);
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
 		while (!queued_spin_trylock(lock)) {
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7dfa..4abb01f281fe 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -42,6 +42,28 @@ static inline int stack_map_data_size(struct bpf_map *map)
 		sizeof(struct bpf_stack_build_id) : sizeof(u64);
 }
 
+/**
+ * stack_map_calculate_max_depth - Calculate maximum allowed stack trace depth
+ * @size:  Size of the buffer/map value in bytes
+ * @elem_size:  Size of each stack trace element
+ * @flags:  BPF stack trace flags (BPF_F_USER_STACK, BPF_F_USER_BUILD_ID, ...)
+ *
+ * Return: Maximum number of stack trace entries that can be safely stored
+ */
+static u32 stack_map_calculate_max_depth(u32 size, u32 elem_size, u64 flags)
+{
+	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
+	u32 max_depth;
+	u32 curr_sysctl_max_stack = READ_ONCE(sysctl_perf_event_max_stack);
+
+	max_depth = size / elem_size;
+	max_depth += skip;
+	if (max_depth > curr_sysctl_max_stack)
+		return curr_sysctl_max_stack;
+
+	return max_depth;
+}
+
 static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
 {
 	u64 elem_size = sizeof(struct stack_map_bucket) +
@@ -229,8 +251,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
+	u32 hash, id, trace_nr, trace_len, i, max_depth;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
-	u32 hash, id, trace_nr, trace_len, i;
 	bool user = flags & BPF_F_USER_STACK;
 	u64 *ips;
 	bool hash_matches;
@@ -239,7 +261,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
 		/* skipping more than usable stack trace */
 		return -EFAULT;
 
-	trace_nr = trace->nr - skip;
+	max_depth = stack_map_calculate_max_depth(map->value_size, stack_map_data_size(map), flags);
+	trace_nr = min_t(u32, trace->nr - skip, max_depth - skip);
 	trace_len = trace_nr * sizeof(u64);
 	ips = trace->ip + skip;
 	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
@@ -300,21 +323,18 @@ static long __bpf_get_stackid(struct bpf_map *map,
 BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	   u64, flags)
 {
-	u32 max_depth = map->value_size / stack_map_data_size(map);
-	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
+	u32 elem_size = stack_map_data_size(map);
 	bool user = flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
 	bool kernel = !user;
+	u32 max_depth;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
 		return -EINVAL;
 
-	max_depth += skip;
-	if (max_depth > sysctl_perf_event_max_stack)
-		max_depth = sysctl_perf_event_max_stack;
-
-	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
+	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+	trace = get_perf_callchain(regs, kernel, user, max_depth,
 				   false, false);
 
 	if (unlikely(!trace))
@@ -371,15 +391,11 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 		return -EFAULT;
 
 	nr_kernel = count_kernel_ip(trace);
+	__u64 nr = trace->nr; /* save original */
 
 	if (kernel) {
-		__u64 nr = trace->nr;
-
 		trace->nr = nr_kernel;
 		ret = __bpf_get_stackid(map, trace, flags);
-
-		/* restore nr */
-		trace->nr = nr;
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
@@ -390,6 +406,10 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
 		ret = __bpf_get_stackid(map, trace, flags);
 	}
+
+	/* restore nr */
+	trace->nr = nr;
+
 	return ret;
 }
 
@@ -406,7 +426,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 			    struct perf_callchain_entry *trace_in,
 			    void *buf, u32 size, u64 flags, bool may_fault)
 {
-	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
+	u32 trace_nr, copy_len, elem_size, max_depth;
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
 	bool crosstask = task && task != current;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
@@ -438,21 +458,20 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto clear;
 	}
 
-	num_elem = size / elem_size;
-	max_depth = num_elem + skip;
-	if (sysctl_perf_event_max_stack < max_depth)
-		max_depth = sysctl_perf_event_max_stack;
+	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
 
 	if (may_fault)
 		rcu_read_lock(); /* need RCU for perf's callchain below */
 
-	if (trace_in)
+	if (trace_in) {
 		trace = trace_in;
-	else if (kernel && task)
+		trace->nr = min_t(u32, trace->nr, max_depth);
+	} else if (kernel && task) {
 		trace = get_callchain_entry_for_task(task, max_depth);
-	else
-		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
+	} else {
+		trace = get_perf_callchain(regs, kernel, user, max_depth,
 					   crosstask, false);
+	}
 
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
@@ -461,7 +480,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = trace->nr - skip;
-	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fbfa8532c39..c7b4f597a293 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2406,6 +2406,9 @@ void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog)
 	struct bpf_prog_stats *stats;
 	unsigned int flags;
 
+	if (unlikely(!prog->stats))
+		return;
+
 	stats = this_cpu_ptr(prog->stats);
 	flags = u64_stats_update_begin_irqsave(&stats->syncp);
 	u64_stats_inc(&stats->misses);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 0db567381210..1ce8696f6f6d 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -220,7 +220,9 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	}
 
 	if (tr->func.ftrace_managed) {
-		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
+		ret = ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
+		if (ret)
+			return ret;
 		ret = register_ftrace_direct(tr->fops, (long)new_addr);
 	} else {
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fd890b34a840..06a58f62be58 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -327,6 +327,15 @@ static inline bool is_in_v2_mode(void)
 	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
 }
 
+static inline bool cpuset_is_populated(struct cpuset *cs)
+{
+	lockdep_assert_held(&cpuset_mutex);
+
+	/* Cpusets in the process of attaching should be considered as populated */
+	return cgroup_is_populated(cs->css.cgroup) ||
+		cs->attach_in_progress;
+}
+
 /**
  * partition_is_populated - check if partition has tasks
  * @cs: partition root to be checked
@@ -339,21 +348,31 @@ static inline bool is_in_v2_mode(void)
 static inline bool partition_is_populated(struct cpuset *cs,
 					  struct cpuset *excluded_child)
 {
-	struct cgroup_subsys_state *css;
-	struct cpuset *child;
+	struct cpuset *cp;
+	struct cgroup_subsys_state *pos_css;
 
-	if (cs->css.cgroup->nr_populated_csets)
+	/*
+	 * We cannot call cs_is_populated(cs) directly, as
+	 * nr_populated_domain_children may include populated
+	 * csets from descendants that are partitions.
+	 */
+	if (cs->css.cgroup->nr_populated_csets ||
+	    cs->attach_in_progress)
 		return true;
 	if (!excluded_child && !cs->nr_subparts)
 		return cgroup_is_populated(cs->css.cgroup);
 
 	rcu_read_lock();
-	cpuset_for_each_child(child, css, cs) {
-		if (child == excluded_child)
+	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
+		if (cp == cs || cp == excluded_child)
 			continue;
-		if (is_partition_valid(child))
+
+		if (is_partition_valid(cp)) {
+			pos_css = css_rightmost_descendant(pos_css);
 			continue;
-		if (cgroup_is_populated(child->css.cgroup)) {
+		}
+
+		if (cpuset_is_populated(cp)) {
 			rcu_read_unlock();
 			return true;
 		}
@@ -584,7 +603,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	 * be changed to have empty cpus_allowed or mems_allowed.
 	 */
 	ret = -ENOSPC;
-	if ((cgroup_is_populated(cur->css.cgroup) || cur->attach_in_progress)) {
+	if (cpuset_is_populated(cur)) {
 		if (!cpumask_empty(cur->cpus_allowed) &&
 		    cpumask_empty(trial->cpus_allowed))
 			goto out;
diff --git a/kernel/cpu.c b/kernel/cpu.c
index db9f6c539b28..15000c7abc65 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -249,6 +249,14 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 	return ret;
 }
 
+/*
+ * The former STARTING/DYING states, ran with IRQs disabled and must not fail.
+ */
+static bool cpuhp_is_atomic_state(enum cpuhp_state state)
+{
+	return CPUHP_AP_IDLE_DEAD <= state && state < CPUHP_AP_ONLINE;
+}
+
 #ifdef CONFIG_SMP
 static bool cpuhp_is_ap_state(enum cpuhp_state state)
 {
@@ -271,14 +279,6 @@ static inline void complete_ap_thread(struct cpuhp_cpu_state *st, bool bringup)
 	complete(done);
 }
 
-/*
- * The former STARTING/DYING states, ran with IRQs disabled and must not fail.
- */
-static bool cpuhp_is_atomic_state(enum cpuhp_state state)
-{
-	return CPUHP_AP_IDLE_DEAD <= state && state < CPUHP_AP_ONLINE;
-}
-
 /* Synchronization state management */
 enum cpuhp_sync_state {
 	SYNC_STATE_DEAD,
@@ -2364,7 +2364,14 @@ static int cpuhp_issue_call(int cpu, enum cpuhp_state state, bool bringup,
 	else
 		ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
 #else
-	ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
+	if (cpuhp_is_atomic_state(state)) {
+		guard(irqsave)();
+		ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
+		/* STARTING/DYING must not fail! */
+		WARN_ON_ONCE(ret);
+	} else {
+		ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
+	}
 #endif
 	BUG_ON(ret && !bringup);
 	return ret;
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index ee45dee33d49..26392badc36b 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -93,7 +93,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 			page = dma_alloc_from_contiguous(NULL, 1 << order,
 							 order, false);
 		if (!page)
-			page = alloc_pages(gfp, order);
+			page = alloc_pages(gfp | __GFP_NOWARN, order);
 	} while (!page && order-- > 0);
 	if (!page)
 		goto out;
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 2609998ca07f..5982d18f169b 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -217,7 +217,7 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 }
 
 struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark)
 {
 	struct perf_callchain_entry *entry;
@@ -232,11 +232,11 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 	if (!entry)
 		return NULL;
 
-	ctx.entry     = entry;
-	ctx.max_stack = max_stack;
-	ctx.nr	      = entry->nr = init_nr;
-	ctx.contexts       = 0;
-	ctx.contexts_maxed = false;
+	ctx.entry		= entry;
+	ctx.max_stack		= max_stack;
+	ctx.nr			= entry->nr = 0;
+	ctx.contexts		= 0;
+	ctx.contexts_maxed	= false;
 
 	if (kernel && !user_mode(regs)) {
 		if (add_mark)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 970c4a5ab763..a9d7ad430135 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2316,8 +2316,6 @@ static void perf_group_detach(struct perf_event *event)
 	perf_event__header_size(leader);
 }
 
-static void sync_child_event(struct perf_event *child_event);
-
 static void perf_child_detach(struct perf_event *event)
 {
 	struct perf_event *parent_event = event->parent;
@@ -2336,7 +2334,6 @@ static void perf_child_detach(struct perf_event *event)
 	lockdep_assert_held(&parent_event->child_mutex);
 	 */
 
-	sync_child_event(event);
 	list_del_init(&event->child_list);
 }
 
@@ -4587,6 +4584,7 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *event,
 				  struct perf_event_context *ctx,
+				  struct task_struct *task,
 				  bool revoke);
 
 /*
@@ -4614,7 +4612,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)
 
 		modified = true;
 
-		perf_event_exit_event(event, ctx, false);
+		perf_event_exit_event(event, ctx, ctx->task, false);
 	}
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -8205,7 +8203,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, 0, kernel, user,
+	callchain = get_perf_callchain(regs, kernel, user,
 				       max_stack, crosstask, true);
 	return callchain ?: &__empty_callchain;
 }
@@ -12431,7 +12429,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
 	/*
 	 * De-schedule the event and mark it REVOKED.
 	 */
-	perf_event_exit_event(event, ctx, true);
+	perf_event_exit_event(event, ctx, ctx->task, true);
 
 	/*
 	 * All _free_event() bits that rely on event->pmu:
@@ -13988,14 +13986,13 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 }
 EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);
 
-static void sync_child_event(struct perf_event *child_event)
+static void sync_child_event(struct perf_event *child_event,
+			     struct task_struct *task)
 {
 	struct perf_event *parent_event = child_event->parent;
 	u64 child_val;
 
 	if (child_event->attr.inherit_stat) {
-		struct task_struct *task = child_event->ctx->task;
-
 		if (task && task != TASK_TOMBSTONE)
 			perf_event_read_event(child_event, task);
 	}
@@ -14014,7 +14011,9 @@ static void sync_child_event(struct perf_event *child_event)
 
 static void
 perf_event_exit_event(struct perf_event *event,
-		      struct perf_event_context *ctx, bool revoke)
+		      struct perf_event_context *ctx,
+		      struct task_struct *task,
+		      bool revoke)
 {
 	struct perf_event *parent_event = event->parent;
 	unsigned long detach_flags = DETACH_EXIT;
@@ -14037,6 +14036,9 @@ perf_event_exit_event(struct perf_event *event,
 		mutex_lock(&parent_event->child_mutex);
 		/* PERF_ATTACH_ITRACE might be set concurrently */
 		attach_state = READ_ONCE(event->attach_state);
+
+		if (attach_state & PERF_ATTACH_CHILD)
+			sync_child_event(event, task);
 	}
 
 	if (revoke)
@@ -14128,7 +14130,7 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 		perf_event_task(task, ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, ctx, false);
+		perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);
 
 	mutex_unlock(&ctx->mutex);
 
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index ce0362f0a871..6567e5eeacc0 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -103,8 +103,8 @@ static const struct kernel_param_ops lt_bind_ops = {
 	.get = param_get_cpumask,
 };
 
-module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0644);
-module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0644);
+module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0444);
+module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0444);
 
 long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask, bool dowarn);
 
@@ -1211,6 +1211,10 @@ static void lock_torture_cleanup(void)
 			cxt.cur_ops->exit();
 		cxt.init_called = false;
 	}
+
+	free_cpumask_var(bind_readers);
+	free_cpumask_var(bind_writers);
+
 	torture_cleanup_end();
 }
 
diff --git a/kernel/resource.c b/kernel/resource.c
index f9bb5481501a..ff00e563ecea 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -341,6 +341,8 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 			       unsigned long flags, unsigned long desc,
 			       struct resource *res)
 {
+	/* Skip children until we find a top level range that matches */
+	bool skip_children = true;
 	struct resource *p;
 
 	if (!res)
@@ -351,7 +353,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 
 	read_lock(&resource_lock);
 
-	for_each_resource(&iomem_resource, p, false) {
+	for_each_resource(&iomem_resource, p, skip_children) {
 		/* If we passed the resource we are looking for, stop */
 		if (p->start > end) {
 			p = NULL;
@@ -362,6 +364,12 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 		if (p->end < start)
 			continue;
 
+		/*
+		 * We found a top level range that matches what we are looking
+		 * for. Time to start checking children too.
+		 */
+		skip_children = false;
+
 		/* Found a match, break */
 		if (is_type_match(p, flags, desc))
 			break;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4770d25ae240..434df3fb6c44 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4062,6 +4062,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (child_cfs_rq_on_list(cfs_rq))
 		return false;
 
+	if (cfs_rq->tg_load_avg_contrib)
+		return false;
+
 	return true;
 }
 
@@ -8919,7 +8922,19 @@ static void yield_task_fair(struct rq *rq)
 	 */
 	rq_clock_skip_update(rq);
 
-	se->deadline += calc_delta_fair(se->slice, se);
+	/*
+	 * Forfeit the remaining vruntime, only if the entity is eligible. This
+	 * condition is necessary because in core scheduling we prefer to run
+	 * ineligible tasks rather than force idling. If this happens we may
+	 * end up in a loop where the core scheduler picks the yielding task,
+	 * which yields immediately again; without the condition the vruntime
+	 * ends up quickly running away.
+	 */
+	if (entity_eligible(cfs_rq, se)) {
+		se->vruntime = se->deadline;
+		se->deadline += calc_delta_fair(se->slice, se);
+		update_min_vruntime(cfs_rq);
+	}
 }
 
 static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 26f3fd4d34ce..73bd6bca4d31 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -180,8 +180,13 @@ static inline void psi_dequeue(struct task_struct *p, int flags)
 	 * avoid walking all ancestors twice, psi_task_switch() handles
 	 * TSK_RUNNING and TSK_IOWAIT for us when it moves TSK_ONCPU.
 	 * Do nothing here.
+	 *
+	 * In the SCHED_PROXY_EXECUTION case we may do sleeping
+	 * dequeues that are not followed by a task switch, so check
+	 * TSK_ONCPU is set to ensure the task switch is imminent.
+	 * Otherwise clear the flags as usual.
 	 */
-	if (flags & DEQUEUE_SLEEP)
+	if ((flags & DEQUEUE_SLEEP) && (p->psi_flags & TSK_ONCPU))
 		return;
 
 	/*
diff --git a/kernel/task_work.c b/kernel/task_work.c
index d1efec571a4a..0f7519f8e7c9 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -9,7 +9,12 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
 #ifdef CONFIG_IRQ_WORK
 static void task_work_set_notify_irq(struct irq_work *entry)
 {
-	test_and_set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+	/*
+	 * no-op IPI
+	 *
+	 * TWA_NMI_CURRENT will already have set the TIF flag, all
+	 * this interrupt does it tickle the return-to-user path.
+	 */
 }
 static DEFINE_PER_CPU(struct irq_work, irq_work_NMI_resume) =
 	IRQ_WORK_INIT_HARD(task_work_set_notify_irq);
@@ -86,6 +91,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		break;
 #ifdef CONFIG_IRQ_WORK
 	case TWA_NMI_CURRENT:
+		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
 		irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume));
 		break;
 #endif
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c0c54dc5314c..49635a2b7ee2 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -420,6 +420,8 @@ static struct list_head *tmigr_level_list __read_mostly;
 static unsigned int tmigr_hierarchy_levels __read_mostly;
 static unsigned int tmigr_crossnode_level __read_mostly;
 
+static struct tmigr_group *tmigr_root;
+
 static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
 
 #define TMIGR_NONE	0xFF
@@ -522,11 +524,9 @@ struct tmigr_walk {
 
 typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, struct tmigr_walk *);
 
-static void __walk_groups(up_f up, struct tmigr_walk *data,
-			  struct tmigr_cpu *tmc)
+static void __walk_groups_from(up_f up, struct tmigr_walk *data,
+			       struct tmigr_group *child, struct tmigr_group *group)
 {
-	struct tmigr_group *child = NULL, *group = tmc->tmgroup;
-
 	do {
 		WARN_ON_ONCE(group->level >= tmigr_hierarchy_levels);
 
@@ -544,6 +544,12 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
 	} while (group);
 }
 
+static void __walk_groups(up_f up, struct tmigr_walk *data,
+			  struct tmigr_cpu *tmc)
+{
+	__walk_groups_from(up, data, NULL, tmc->tmgroup);
+}
+
 static void walk_groups(up_f up, struct tmigr_walk *data, struct tmigr_cpu *tmc)
 {
 	lockdep_assert_held(&tmc->lock);
@@ -1498,21 +1504,6 @@ static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
 	s.seq = 0;
 	atomic_set(&group->migr_state, s.state);
 
-	/*
-	 * If this is a new top-level, prepare its groupmask in advance.
-	 * This avoids accidents where yet another new top-level is
-	 * created in the future and made visible before the current groupmask.
-	 */
-	if (list_empty(&tmigr_level_list[lvl])) {
-		group->groupmask = BIT(0);
-		/*
-		 * The previous top level has prepared its groupmask already,
-		 * simply account it as the first child.
-		 */
-		if (lvl > 0)
-			group->num_children = 1;
-	}
-
 	timerqueue_init_head(&group->events);
 	timerqueue_init(&group->groupevt.nextevt);
 	group->groupevt.nextevt.expires = KTIME_MAX;
@@ -1567,25 +1558,51 @@ static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
 	return group;
 }
 
+static bool tmigr_init_root(struct tmigr_group *group, bool activate)
+{
+	if (!group->parent && group != tmigr_root) {
+		/*
+		 * This is the new top-level, prepare its groupmask in advance
+		 * to avoid accidents where yet another new top-level is
+		 * created in the future and made visible before this groupmask.
+		 */
+		group->groupmask = BIT(0);
+		WARN_ON_ONCE(activate);
+
+		return true;
+	}
+
+	return false;
+
+}
+
 static void tmigr_connect_child_parent(struct tmigr_group *child,
 				       struct tmigr_group *parent,
 				       bool activate)
 {
-	struct tmigr_walk data;
-
-	raw_spin_lock_irq(&child->lock);
-	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
+	if (tmigr_init_root(parent, activate)) {
+		/*
+		 * The previous top level had prepared its groupmask already,
+		 * simply account it in advance as the first child. If some groups
+		 * have been created between the old and new root due to node
+		 * mismatch, the new root's child will be intialized accordingly.
+		 */
+		parent->num_children = 1;
+	}
 
-	if (activate) {
+	/* Connecting old root to new root ? */
+	if (!parent->parent && activate) {
 		/*
-		 * @child is the old top and @parent the new one. In this
-		 * case groupmask is pre-initialized and @child already
-		 * accounted, along with its new sibling corresponding to the
-		 * CPU going up.
+		 * @child is the old top, or in case of node mismatch, some
+		 * intermediate group between the old top and the new one in
+		 * @parent. In this case the @child must be pre-accounted above
+		 * as the first child. Its new inactive sibling corresponding
+		 * to the CPU going up has been accounted as the second child.
 		 */
-		WARN_ON_ONCE(child->groupmask != BIT(0) || parent->num_children != 2);
+		WARN_ON_ONCE(parent->num_children != 2);
+		child->groupmask = BIT(0);
 	} else {
-		/* Adding @child for the CPU going up to @parent. */
+		/* Common case adding @child for the CPU going up to @parent. */
 		child->groupmask = BIT(parent->num_children++);
 	}
 
@@ -1596,87 +1613,61 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	 */
 	smp_store_release(&child->parent, parent);
 
-	raw_spin_unlock(&parent->lock);
-	raw_spin_unlock_irq(&child->lock);
-
 	trace_tmigr_connect_child_parent(child);
-
-	if (!activate)
-		return;
-
-	/*
-	 * To prevent inconsistent states, active children need to be active in
-	 * the new parent as well. Inactive children are already marked inactive
-	 * in the parent group:
-	 *
-	 * * When new groups were created by tmigr_setup_groups() starting from
-	 *   the lowest level (and not higher then one level below the current
-	 *   top level), then they are not active. They will be set active when
-	 *   the new online CPU comes active.
-	 *
-	 * * But if a new group above the current top level is required, it is
-	 *   mandatory to propagate the active state of the already existing
-	 *   child to the new parent. So tmigr_connect_child_parent() is
-	 *   executed with the formerly top level group (child) and the newly
-	 *   created group (parent).
-	 *
-	 * * It is ensured that the child is active, as this setup path is
-	 *   executed in hotplug prepare callback. This is exectued by an
-	 *   already connected and !idle CPU. Even if all other CPUs go idle,
-	 *   the CPU executing the setup will be responsible up to current top
-	 *   level group. And the next time it goes inactive, it will release
-	 *   the new childmask and parent to subsequent walkers through this
-	 *   @child. Therefore propagate active state unconditionally.
-	 */
-	data.childmask = child->groupmask;
-
-	/*
-	 * There is only one new level per time (which is protected by
-	 * tmigr_mutex). When connecting the child and the parent and set the
-	 * child active when the parent is inactive, the parent needs to be the
-	 * uppermost level. Otherwise there went something wrong!
-	 */
-	WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
 }
 
-static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
+static int tmigr_setup_groups(unsigned int cpu, unsigned int node,
+			      struct tmigr_group *start, bool activate)
 {
 	struct tmigr_group *group, *child, **stack;
-	int top = 0, err = 0, i = 0;
-	struct list_head *lvllist;
+	int i, top = 0, err = 0, start_lvl = 0;
+	bool root_mismatch = false;
 
 	stack = kcalloc(tmigr_hierarchy_levels, sizeof(*stack), GFP_KERNEL);
 	if (!stack)
 		return -ENOMEM;
 
-	do {
+	if (start) {
+		stack[start->level] = start;
+		start_lvl = start->level + 1;
+	}
+
+	if (tmigr_root)
+		root_mismatch = tmigr_root->numa_node != node;
+
+	for (i = start_lvl; i < tmigr_hierarchy_levels; i++) {
 		group = tmigr_get_group(cpu, node, i);
 		if (IS_ERR(group)) {
 			err = PTR_ERR(group);
+			i--;
 			break;
 		}
 
 		top = i;
-		stack[i++] = group;
+		stack[i] = group;
 
 		/*
 		 * When booting only less CPUs of a system than CPUs are
-		 * available, not all calculated hierarchy levels are required.
+		 * available, not all calculated hierarchy levels are required,
+		 * unless a node mismatch is detected.
 		 *
 		 * The loop is aborted as soon as the highest level, which might
 		 * be different from tmigr_hierarchy_levels, contains only a
-		 * single group.
+		 * single group, unless the nodes mismatch below tmigr_crossnode_level
 		 */
-		if (group->parent || list_is_singular(&tmigr_level_list[i - 1]))
+		if (group->parent)
 			break;
+		if ((!root_mismatch || i >= tmigr_crossnode_level) &&
+		    list_is_singular(&tmigr_level_list[i]))
+			break;
+	}
 
-	} while (i < tmigr_hierarchy_levels);
-
-	/* Assert single root */
-	WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_list[top]));
+	/* Assert single root without parent */
+	if (WARN_ON_ONCE(i >= tmigr_hierarchy_levels))
+		return -EINVAL;
 
-	while (i > 0) {
-		group = stack[--i];
+	for (; i >= start_lvl; i--) {
+		group = stack[i];
 
 		if (err < 0) {
 			list_del(&group->list);
@@ -1692,12 +1683,10 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 		if (i == 0) {
 			struct tmigr_cpu *tmc = per_cpu_ptr(&tmigr_cpu, cpu);
 
-			raw_spin_lock_irq(&group->lock);
-
 			tmc->tmgroup = group;
 			tmc->groupmask = BIT(group->num_children++);
 
-			raw_spin_unlock_irq(&group->lock);
+			tmigr_init_root(group, activate);
 
 			trace_tmigr_connect_cpu_parent(tmc);
 
@@ -1705,42 +1694,55 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 			continue;
 		} else {
 			child = stack[i - 1];
-			/* Will be activated at online time */
-			tmigr_connect_child_parent(child, group, false);
+			tmigr_connect_child_parent(child, group, activate);
 		}
+	}
 
-		/* check if uppermost level was newly created */
-		if (top != i)
-			continue;
-
-		WARN_ON_ONCE(top == 0);
+	if (err < 0)
+		goto out;
 
-		lvllist = &tmigr_level_list[top];
+	if (activate) {
+		struct tmigr_walk data;
 
 		/*
-		 * Newly created root level should have accounted the upcoming
-		 * CPU's child group and pre-accounted the old root.
+		 * To prevent inconsistent states, active children need to be active in
+		 * the new parent as well. Inactive children are already marked inactive
+		 * in the parent group:
+		 *
+		 * * When new groups were created by tmigr_setup_groups() starting from
+		 *   the lowest level, then they are not active. They will be set active
+		 *   when the new online CPU comes active.
+		 *
+		 * * But if new groups above the current top level are required, it is
+		 *   mandatory to propagate the active state of the already existing
+		 *   child to the new parents. So tmigr_active_up() activates the
+		 *   new parents while walking up from the old root to the new.
+		 *
+		 * * It is ensured that @start is active, as this setup path is
+		 *   executed in hotplug prepare callback. This is executed by an
+		 *   already connected and !idle CPU. Even if all other CPUs go idle,
+		 *   the CPU executing the setup will be responsible up to current top
+		 *   level group. And the next time it goes inactive, it will release
+		 *   the new childmask and parent to subsequent walkers through this
+		 *   @child. Therefore propagate active state unconditionally.
 		 */
-		if (group->num_children == 2 && list_is_singular(lvllist)) {
-			/*
-			 * The target CPU must never do the prepare work, except
-			 * on early boot when the boot CPU is the target. Otherwise
-			 * it may spuriously activate the old top level group inside
-			 * the new one (nevertheless whether old top level group is
-			 * active or not) and/or release an uninitialized childmask.
-			 */
-			WARN_ON_ONCE(cpu == raw_smp_processor_id());
-
-			lvllist = &tmigr_level_list[top - 1];
-			list_for_each_entry(child, lvllist, list) {
-				if (child->parent)
-					continue;
+		WARN_ON_ONCE(!start->parent);
+		data.childmask = start->groupmask;
+		__walk_groups_from(tmigr_active_up, &data, start, start->parent);
+	}
 
-				tmigr_connect_child_parent(child, group, true);
-			}
+	/* Root update */
+	if (list_is_singular(&tmigr_level_list[top])) {
+		group = list_first_entry(&tmigr_level_list[top],
+					 typeof(*group), list);
+		WARN_ON_ONCE(group->parent);
+		if (tmigr_root) {
+			/* Old root should be the same or below */
+			WARN_ON_ONCE(tmigr_root->level > top);
 		}
+		tmigr_root = group;
 	}
-
+out:
 	kfree(stack);
 
 	return err;
@@ -1748,12 +1750,26 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 static int tmigr_add_cpu(unsigned int cpu)
 {
+	struct tmigr_group *old_root = tmigr_root;
 	int node = cpu_to_node(cpu);
 	int ret;
 
-	mutex_lock(&tmigr_mutex);
-	ret = tmigr_setup_groups(cpu, node);
-	mutex_unlock(&tmigr_mutex);
+	guard(mutex)(&tmigr_mutex);
+
+	ret = tmigr_setup_groups(cpu, node, NULL, false);
+
+	/* Root has changed? Connect the old one to the new */
+	if (ret >= 0 && old_root && old_root != tmigr_root) {
+		/*
+		 * The target CPU must never do the prepare work, except
+		 * on early boot when the boot CPU is the target. Otherwise
+		 * it may spuriously activate the old top level group inside
+		 * the new one (nevertheless whether old top level group is
+		 * active or not) and/or release an uninitialized childmask.
+		 */
+		WARN_ON_ONCE(cpu == raw_smp_processor_id());
+		ret = tmigr_setup_groups(-1, old_root->numa_node, old_root, true);
+	}
 
 	return ret;
 }
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index eb0cb11d0d12..a356965c1d73 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1928,9 +1928,6 @@ char *rtc_str(char *buf, char *end, const struct rtc_time *tm,
 	bool found = true;
 	int count = 2;
 
-	if (check_pointer(&buf, end, tm, spec))
-		return buf;
-
 	switch (fmt[count]) {
 	case 'd':
 		have_t = false;
@@ -1996,6 +1993,9 @@ static noinline_for_stack
 char *time_and_date(char *buf, char *end, void *ptr, struct printf_spec spec,
 		    const char *fmt)
 {
+	if (check_pointer(&buf, end, ptr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case 'R':
 		return rtc_str(buf, end, (const struct rtc_time *)ptr, spec, fmt);
diff --git a/net/core/filter.c b/net/core/filter.c
index b20d5fecdbc9..47366ec94e58 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6414,9 +6414,12 @@ BPF_CALL_5(bpf_skb_check_mtu, struct sk_buff *, skb,
 	 */
 	if (skb_is_gso(skb)) {
 		ret = BPF_MTU_CHK_RET_SUCCESS;
-		if (flags & BPF_MTU_CHK_SEGS &&
-		    !skb_gso_validate_network_len(skb, mtu))
-			ret = BPF_MTU_CHK_RET_SEGS_TOOBIG;
+		if (flags & BPF_MTU_CHK_SEGS) {
+			if (!skb_transport_header_was_set(skb))
+				return -EINVAL;
+			if (!skb_gso_validate_network_len(skb, mtu))
+				ret = BPF_MTU_CHK_RET_SEGS_TOOBIG;
+		}
 	}
 out:
 	*mtu_len = mtu;
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index be5658ff74ee..27f573d2c5e3 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -554,6 +554,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	int err;
 
 	skb_queue_head_init(&np->skb_pool);
+	INIT_WORK(&np->refill_wq, refill_skbs_work_handler);
 
 	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
 		np_err(np, "%s doesn't support polling, aborting\n",
@@ -592,7 +593,6 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 	/* fill up the skb queue */
 	refill_skbs(np);
-	INIT_WORK(&np->refill_wq, refill_skbs_work_handler);
 
 	/* last thing to do is link it to the net device structure */
 	rcu_assign_pointer(ndev->npinfo, npinfo);
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 492cbc78ab75..d1bfc49b5f01 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -690,6 +690,26 @@ struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 }
 EXPORT_SYMBOL(hsr_get_port_ndev);
 
+int hsr_get_port_type(struct net_device *hsr_dev, struct net_device *dev,
+		      enum hsr_port_type *type)
+{
+	struct hsr_priv *hsr = netdev_priv(hsr_dev);
+	struct hsr_port *port;
+
+	rcu_read_lock();
+	hsr_for_each_port(hsr, port) {
+		if (port->dev == dev) {
+			*type = port->type;
+			rcu_read_unlock();
+			return 0;
+		}
+	}
+	rcu_read_unlock();
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hsr_get_port_type);
+
 /* Default multicast address for HSR Supervision frames */
 static const unsigned char def_multicast_addr[ETH_ALEN] __aligned(2) = {
 	0x01, 0x15, 0x4e, 0x00, 0x01, 0x00
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 102eccf5ead7..82c0bc69c9b3 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -204,14 +204,14 @@ int hsr_add_port(struct hsr_priv *hsr, struct net_device *dev,
 	port->type = type;
 	ether_addr_copy(port->original_macaddress, dev->dev_addr);
 
+	list_add_tail_rcu(&port->port_list, &hsr->ports);
+
 	if (type != HSR_PT_MASTER) {
 		res = hsr_portdev_setup(hsr, dev, port, extack);
 		if (res)
 			goto fail_dev_setup;
 	}
 
-	list_add_tail_rcu(&port->port_list, &hsr->ports);
-
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	netdev_update_features(master->dev);
 	dev_set_mtu(master->dev, hsr_get_max_mtu(hsr));
@@ -219,7 +219,8 @@ int hsr_add_port(struct hsr_priv *hsr, struct net_device *dev,
 	return 0;
 
 fail_dev_setup:
-	kfree(port);
+	list_del_rcu(&port->port_list);
+	kfree_rcu(port, rcu);
 	return res;
 }
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 4316c127f789..ddeb5ee52d40 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -720,8 +720,11 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	spin_lock(lock);
 	if (osk) {
 		WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
-		ret = sk_nulls_del_node_init_rcu(osk);
-	} else if (found_dup_sk) {
+		ret = sk_nulls_replace_node_init_rcu(osk, sk);
+		goto unlock;
+	}
+
+	if (found_dup_sk) {
 		*found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
 		if (*found_dup_sk)
 			ret = false;
@@ -730,6 +733,7 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	if (ret)
 		__sk_nulls_add_node_rcu(sk, list);
 
+unlock:
 	spin_unlock(lock);
 
 	return ret;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 6fb9efdbee27..2386552f4eee 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -86,12 +86,6 @@ void inet_twsk_put(struct inet_timewait_sock *tw)
 }
 EXPORT_SYMBOL_GPL(inet_twsk_put);
 
-static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
-				   struct hlist_nulls_head *list)
-{
-	hlist_nulls_add_head_rcu(&tw->tw_node, list);
-}
-
 static void inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)
 {
 	__inet_twsk_schedule(tw, timeo, false);
@@ -111,13 +105,12 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 {
 	const struct inet_sock *inet = inet_sk(sk);
 	const struct inet_connection_sock *icsk = inet_csk(sk);
-	struct inet_ehash_bucket *ehead = inet_ehash_bucket(hashinfo, sk->sk_hash);
 	spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
 	struct inet_bind_hashbucket *bhead, *bhead2;
 
-	/* Step 1: Put TW into bind hash. Original socket stays there too.
-	   Note, that any socket with inet->num != 0 MUST be bound in
-	   binding cache, even if it is closed.
+	/* Put TW into bind hash. Original socket stays there too.
+	 * Note, that any socket with inet->num != 0 MUST be bound in
+	 * binding cache, even if it is closed.
 	 */
 	bhead = &hashinfo->bhash[inet_bhashfn(twsk_net(tw), inet->inet_num,
 			hashinfo->bhash_size)];
@@ -139,19 +132,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 
 	spin_lock(lock);
 
-	/* Step 2: Hash TW into tcp ehash chain */
-	inet_twsk_add_node_rcu(tw, &ehead->chain);
-
-	/* Step 3: Remove SK from hash chain */
-	if (__sk_nulls_del_node_init_rcu(sk))
-		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
-
-
-	/* Ensure above writes are committed into memory before updating the
-	 * refcount.
-	 * Provides ordering vs later refcount_inc().
-	 */
-	smp_wmb();
 	/* tw_refcnt is set to 3 because we have :
 	 * - one reference for bhash chain.
 	 * - one reference for ehash chain.
@@ -161,6 +141,15 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 	 */
 	refcount_set(&tw->tw_refcnt, 3);
 
+	/* Ensure tw_refcnt has been set before tw is published.
+	 * smp_wmb() provides the necessary memory barrier to enforce this
+	 * ordering.
+	 */
+	smp_wmb();
+
+	hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+
 	inet_twsk_schedule(tw, timeo);
 
 	spin_unlock(lock);
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 02c16909f618..2111af022d94 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1138,6 +1138,10 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 					fib6_set_expires(iter, rt->expires);
 					fib6_add_gc_list(iter);
 				}
+				if (!(rt->fib6_flags & (RTF_ADDRCONF | RTF_PREFIX_RT))) {
+					iter->fib6_flags &= ~RTF_ADDRCONF;
+					iter->fib6_flags &= ~RTF_PREFIX_RT;
+				}
 
 				if (rt->fib6_pmtu)
 					fib6_metric_set(iter, RTAX_MTU,
diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
index 48c04f89de20..65989c7dfc68 100644
--- a/net/mac80211/aes_cmac.c
+++ b/net/mac80211/aes_cmac.c
@@ -22,50 +22,77 @@
 
 static const u8 zero[CMAC_TLEN_256];
 
-void ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
-			const u8 *data, size_t data_len, u8 *mic)
+int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
+		       const u8 *data, size_t data_len, u8 *mic)
 {
+	int err;
 	SHASH_DESC_ON_STACK(desc, tfm);
 	u8 out[AES_BLOCK_SIZE];
 	const __le16 *fc;
 
 	desc->tfm = tfm;
 
-	crypto_shash_init(desc);
-	crypto_shash_update(desc, aad, AAD_LEN);
+	err = crypto_shash_init(desc);
+	if (err)
+		return err;
+	err = crypto_shash_update(desc, aad, AAD_LEN);
+	if (err)
+		return err;
 	fc = (const __le16 *)aad;
 	if (ieee80211_is_beacon(*fc)) {
 		/* mask Timestamp field to zero */
-		crypto_shash_update(desc, zero, 8);
-		crypto_shash_update(desc, data + 8, data_len - 8 - CMAC_TLEN);
+		err = crypto_shash_update(desc, zero, 8);
+		if (err)
+			return err;
+		err = crypto_shash_update(desc, data + 8,
+					  data_len - 8 - CMAC_TLEN);
+		if (err)
+			return err;
 	} else {
-		crypto_shash_update(desc, data, data_len - CMAC_TLEN);
+		err = crypto_shash_update(desc, data,
+					  data_len - CMAC_TLEN);
+		if (err)
+			return err;
 	}
-	crypto_shash_finup(desc, zero, CMAC_TLEN, out);
-
+	err = crypto_shash_finup(desc, zero, CMAC_TLEN, out);
+	if (err)
+		return err;
 	memcpy(mic, out, CMAC_TLEN);
+
+	return 0;
 }
 
-void ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
-			    const u8 *data, size_t data_len, u8 *mic)
+int ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
+			   const u8 *data, size_t data_len, u8 *mic)
 {
+	int err;
 	SHASH_DESC_ON_STACK(desc, tfm);
 	const __le16 *fc;
 
 	desc->tfm = tfm;
 
-	crypto_shash_init(desc);
-	crypto_shash_update(desc, aad, AAD_LEN);
+	err = crypto_shash_init(desc);
+	if (err)
+		return err;
+	err = crypto_shash_update(desc, aad, AAD_LEN);
+	if (err)
+		return err;
 	fc = (const __le16 *)aad;
 	if (ieee80211_is_beacon(*fc)) {
 		/* mask Timestamp field to zero */
-		crypto_shash_update(desc, zero, 8);
-		crypto_shash_update(desc, data + 8,
-				    data_len - 8 - CMAC_TLEN_256);
+		err = crypto_shash_update(desc, zero, 8);
+		if (err)
+			return err;
+		err = crypto_shash_update(desc, data + 8,
+					  data_len - 8 - CMAC_TLEN_256);
+		if (err)
+			return err;
 	} else {
-		crypto_shash_update(desc, data, data_len - CMAC_TLEN_256);
+		err = crypto_shash_update(desc, data, data_len - CMAC_TLEN_256);
+		if (err)
+			return err;
 	}
-	crypto_shash_finup(desc, zero, CMAC_TLEN_256, mic);
+	return crypto_shash_finup(desc, zero, CMAC_TLEN_256, mic);
 }
 
 struct crypto_shash *ieee80211_aes_cmac_key_setup(const u8 key[],
diff --git a/net/mac80211/aes_cmac.h b/net/mac80211/aes_cmac.h
index 76817446fb83..f74150542142 100644
--- a/net/mac80211/aes_cmac.h
+++ b/net/mac80211/aes_cmac.h
@@ -11,10 +11,10 @@
 
 struct crypto_shash *ieee80211_aes_cmac_key_setup(const u8 key[],
 						  size_t key_len);
-void ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
-			const u8 *data, size_t data_len, u8 *mic);
-void ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
-			    const u8 *data, size_t data_len, u8 *mic);
+int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
+		       const u8 *data, size_t data_len, u8 *mic);
+int ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
+			   const u8 *data, size_t data_len, u8 *mic);
 void ieee80211_aes_cmac_key_free(struct crypto_shash *tfm);
 
 #endif /* AES_CMAC_H */
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 40d5d9e48479..bb0fa505cdca 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -869,8 +869,9 @@ ieee80211_crypto_aes_cmac_encrypt(struct ieee80211_tx_data *tx)
 	/*
 	 * MIC = AES-128-CMAC(IGTK, AAD || Management Frame Body || MMIE, 64)
 	 */
-	ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
-			   skb->data + 24, skb->len - 24, mmie->mic);
+	if (ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
+			       skb->data + 24, skb->len - 24, mmie->mic))
+		return TX_DROP;
 
 	return TX_CONTINUE;
 }
@@ -916,8 +917,9 @@ ieee80211_crypto_aes_cmac_256_encrypt(struct ieee80211_tx_data *tx)
 
 	/* MIC = AES-256-CMAC(IGTK, AAD || Management Frame Body || MMIE, 128)
 	 */
-	ieee80211_aes_cmac_256(key->u.aes_cmac.tfm, aad,
-			       skb->data + 24, skb->len - 24, mmie->mic);
+	if (ieee80211_aes_cmac_256(key->u.aes_cmac.tfm, aad,
+				   skb->data + 24, skb->len - 24, mmie->mic))
+		return TX_DROP;
 
 	return TX_CONTINUE;
 }
@@ -956,8 +958,9 @@ ieee80211_crypto_aes_cmac_decrypt(struct ieee80211_rx_data *rx)
 	if (!(status->flag & RX_FLAG_DECRYPTED)) {
 		/* hardware didn't decrypt/verify MIC */
 		bip_aad(skb, aad);
-		ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
-				   skb->data + 24, skb->len - 24, mic);
+		if (ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
+				       skb->data + 24, skb->len - 24, mic))
+			return RX_DROP_U_DECRYPT_FAIL;
 		if (crypto_memneq(mic, mmie->mic, sizeof(mmie->mic))) {
 			key->u.aes_cmac.icverrors++;
 			return RX_DROP_U_MIC_FAIL;
@@ -1006,8 +1009,9 @@ ieee80211_crypto_aes_cmac_256_decrypt(struct ieee80211_rx_data *rx)
 	if (!(status->flag & RX_FLAG_DECRYPTED)) {
 		/* hardware didn't decrypt/verify MIC */
 		bip_aad(skb, aad);
-		ieee80211_aes_cmac_256(key->u.aes_cmac.tfm, aad,
-				       skb->data + 24, skb->len - 24, mic);
+		if (ieee80211_aes_cmac_256(key->u.aes_cmac.tfm, aad,
+					   skb->data + 24, skb->len - 24, mic))
+			return RX_DROP_U_DECRYPT_FAIL;
 		if (crypto_memneq(mic, mmie->mic, sizeof(mmie->mic))) {
 			key->u.aes_cmac.icverrors++;
 			return RX_DROP_U_MIC_FAIL;
diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index 913ede2f57f9..b84cfb5616df 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -122,15 +122,65 @@ find_or_evict(struct net *net, struct nf_conncount_list *list,
 	return ERR_PTR(-EAGAIN);
 }
 
+static bool get_ct_or_tuple_from_skb(struct net *net,
+				     const struct sk_buff *skb,
+				     u16 l3num,
+				     struct nf_conn **ct,
+				     struct nf_conntrack_tuple *tuple,
+				     const struct nf_conntrack_zone **zone,
+				     bool *refcounted)
+{
+	const struct nf_conntrack_tuple_hash *h;
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn *found_ct;
+
+	found_ct = nf_ct_get(skb, &ctinfo);
+	if (found_ct && !nf_ct_is_template(found_ct)) {
+		*tuple = found_ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple;
+		*zone = nf_ct_zone(found_ct);
+		*ct = found_ct;
+		return true;
+	}
+
+	if (!nf_ct_get_tuplepr(skb, skb_network_offset(skb), l3num, net, tuple))
+		return false;
+
+	if (found_ct)
+		*zone = nf_ct_zone(found_ct);
+
+	h = nf_conntrack_find_get(net, *zone, tuple);
+	if (!h)
+		return true;
+
+	found_ct = nf_ct_tuplehash_to_ctrack(h);
+	*refcounted = true;
+	*ct = found_ct;
+
+	return true;
+}
+
 static int __nf_conncount_add(struct net *net,
-			      struct nf_conncount_list *list,
-			      const struct nf_conntrack_tuple *tuple,
-			      const struct nf_conntrack_zone *zone)
+			      const struct sk_buff *skb,
+			      u16 l3num,
+			      struct nf_conncount_list *list)
 {
+	const struct nf_conntrack_zone *zone = &nf_ct_zone_dflt;
 	const struct nf_conntrack_tuple_hash *found;
 	struct nf_conncount_tuple *conn, *conn_n;
+	struct nf_conntrack_tuple tuple;
+	struct nf_conn *ct = NULL;
 	struct nf_conn *found_ct;
 	unsigned int collect = 0;
+	bool refcounted = false;
+
+	if (!get_ct_or_tuple_from_skb(net, skb, l3num, &ct, &tuple, &zone, &refcounted))
+		return -ENOENT;
+
+	if (ct && nf_ct_is_confirmed(ct)) {
+		if (refcounted)
+			nf_ct_put(ct);
+		return -EEXIST;
+	}
 
 	if ((u32)jiffies == list->last_gc)
 		goto add_new_node;
@@ -144,10 +194,10 @@ static int __nf_conncount_add(struct net *net,
 		if (IS_ERR(found)) {
 			/* Not found, but might be about to be confirmed */
 			if (PTR_ERR(found) == -EAGAIN) {
-				if (nf_ct_tuple_equal(&conn->tuple, tuple) &&
+				if (nf_ct_tuple_equal(&conn->tuple, &tuple) &&
 				    nf_ct_zone_id(&conn->zone, conn->zone.dir) ==
 				    nf_ct_zone_id(zone, zone->dir))
-					return 0; /* already exists */
+					goto out_put; /* already exists */
 			} else {
 				collect++;
 			}
@@ -156,7 +206,7 @@ static int __nf_conncount_add(struct net *net,
 
 		found_ct = nf_ct_tuplehash_to_ctrack(found);
 
-		if (nf_ct_tuple_equal(&conn->tuple, tuple) &&
+		if (nf_ct_tuple_equal(&conn->tuple, &tuple) &&
 		    nf_ct_zone_equal(found_ct, zone, zone->dir)) {
 			/*
 			 * We should not see tuples twice unless someone hooks
@@ -165,7 +215,7 @@ static int __nf_conncount_add(struct net *net,
 			 * Attempt to avoid a re-add in this case.
 			 */
 			nf_ct_put(found_ct);
-			return 0;
+			goto out_put;
 		} else if (already_closed(found_ct)) {
 			/*
 			 * we do not care about connections which are
@@ -188,31 +238,35 @@ static int __nf_conncount_add(struct net *net,
 	if (conn == NULL)
 		return -ENOMEM;
 
-	conn->tuple = *tuple;
+	conn->tuple = tuple;
 	conn->zone = *zone;
 	conn->cpu = raw_smp_processor_id();
 	conn->jiffies32 = (u32)jiffies;
 	list_add_tail(&conn->node, &list->head);
 	list->count++;
 	list->last_gc = (u32)jiffies;
+
+out_put:
+	if (refcounted)
+		nf_ct_put(ct);
 	return 0;
 }
 
-int nf_conncount_add(struct net *net,
-		     struct nf_conncount_list *list,
-		     const struct nf_conntrack_tuple *tuple,
-		     const struct nf_conntrack_zone *zone)
+int nf_conncount_add_skb(struct net *net,
+			 const struct sk_buff *skb,
+			 u16 l3num,
+			 struct nf_conncount_list *list)
 {
 	int ret;
 
 	/* check the saved connections */
 	spin_lock_bh(&list->list_lock);
-	ret = __nf_conncount_add(net, list, tuple, zone);
+	ret = __nf_conncount_add(net, skb, l3num, list);
 	spin_unlock_bh(&list->list_lock);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(nf_conncount_add);
+EXPORT_SYMBOL_GPL(nf_conncount_add_skb);
 
 void nf_conncount_list_init(struct nf_conncount_list *list)
 {
@@ -309,19 +363,22 @@ static void schedule_gc_worker(struct nf_conncount_data *data, int tree)
 
 static unsigned int
 insert_tree(struct net *net,
+	    const struct sk_buff *skb,
+	    u16 l3num,
 	    struct nf_conncount_data *data,
 	    struct rb_root *root,
 	    unsigned int hash,
-	    const u32 *key,
-	    const struct nf_conntrack_tuple *tuple,
-	    const struct nf_conntrack_zone *zone)
+	    const u32 *key)
 {
 	struct nf_conncount_rb *gc_nodes[CONNCOUNT_GC_MAX_NODES];
+	const struct nf_conntrack_zone *zone = &nf_ct_zone_dflt;
+	bool do_gc = true, refcounted = false;
+	unsigned int count = 0, gc_count = 0;
 	struct rb_node **rbnode, *parent;
-	struct nf_conncount_rb *rbconn;
+	struct nf_conntrack_tuple tuple;
 	struct nf_conncount_tuple *conn;
-	unsigned int count = 0, gc_count = 0;
-	bool do_gc = true;
+	struct nf_conncount_rb *rbconn;
+	struct nf_conn *ct = NULL;
 
 	spin_lock_bh(&nf_conncount_locks[hash]);
 restart:
@@ -340,8 +397,8 @@ insert_tree(struct net *net,
 		} else {
 			int ret;
 
-			ret = nf_conncount_add(net, &rbconn->list, tuple, zone);
-			if (ret)
+			ret = nf_conncount_add_skb(net, skb, l3num, &rbconn->list);
+			if (ret && ret != -EEXIST)
 				count = 0; /* hotdrop */
 			else
 				count = rbconn->list.count;
@@ -364,30 +421,35 @@ insert_tree(struct net *net,
 		goto restart;
 	}
 
-	/* expected case: match, insert new node */
-	rbconn = kmem_cache_alloc(conncount_rb_cachep, GFP_ATOMIC);
-	if (rbconn == NULL)
-		goto out_unlock;
+	if (get_ct_or_tuple_from_skb(net, skb, l3num, &ct, &tuple, &zone, &refcounted)) {
+		/* expected case: match, insert new node */
+		rbconn = kmem_cache_alloc(conncount_rb_cachep, GFP_ATOMIC);
+		if (rbconn == NULL)
+			goto out_unlock;
 
-	conn = kmem_cache_alloc(conncount_conn_cachep, GFP_ATOMIC);
-	if (conn == NULL) {
-		kmem_cache_free(conncount_rb_cachep, rbconn);
-		goto out_unlock;
-	}
+		conn = kmem_cache_alloc(conncount_conn_cachep, GFP_ATOMIC);
+		if (conn == NULL) {
+			kmem_cache_free(conncount_rb_cachep, rbconn);
+			goto out_unlock;
+		}
 
-	conn->tuple = *tuple;
-	conn->zone = *zone;
-	conn->cpu = raw_smp_processor_id();
-	conn->jiffies32 = (u32)jiffies;
-	memcpy(rbconn->key, key, sizeof(u32) * data->keylen);
+		conn->tuple = tuple;
+		conn->zone = *zone;
+		conn->cpu = raw_smp_processor_id();
+		conn->jiffies32 = (u32)jiffies;
+		memcpy(rbconn->key, key, sizeof(u32) * data->keylen);
 
-	nf_conncount_list_init(&rbconn->list);
-	list_add(&conn->node, &rbconn->list.head);
-	count = 1;
-	rbconn->list.count = count;
+		nf_conncount_list_init(&rbconn->list);
+		list_add(&conn->node, &rbconn->list.head);
+		count = 1;
+		rbconn->list.count = count;
 
-	rb_link_node_rcu(&rbconn->node, parent, rbnode);
-	rb_insert_color(&rbconn->node, root);
+		rb_link_node_rcu(&rbconn->node, parent, rbnode);
+		rb_insert_color(&rbconn->node, root);
+
+		if (refcounted)
+			nf_ct_put(ct);
+	}
 out_unlock:
 	spin_unlock_bh(&nf_conncount_locks[hash]);
 	return count;
@@ -395,10 +457,10 @@ insert_tree(struct net *net,
 
 static unsigned int
 count_tree(struct net *net,
+	   const struct sk_buff *skb,
+	   u16 l3num,
 	   struct nf_conncount_data *data,
-	   const u32 *key,
-	   const struct nf_conntrack_tuple *tuple,
-	   const struct nf_conntrack_zone *zone)
+	   const u32 *key)
 {
 	struct rb_root *root;
 	struct rb_node *parent;
@@ -422,7 +484,7 @@ count_tree(struct net *net,
 		} else {
 			int ret;
 
-			if (!tuple) {
+			if (!skb) {
 				nf_conncount_gc_list(net, &rbconn->list);
 				return rbconn->list.count;
 			}
@@ -437,19 +499,23 @@ count_tree(struct net *net,
 			}
 
 			/* same source network -> be counted! */
-			ret = __nf_conncount_add(net, &rbconn->list, tuple, zone);
+			ret = __nf_conncount_add(net, skb, l3num, &rbconn->list);
 			spin_unlock_bh(&rbconn->list.list_lock);
-			if (ret)
+			if (ret && ret != -EEXIST) {
 				return 0; /* hotdrop */
-			else
+			} else {
+				/* -EEXIST means add was skipped, update the list */
+				if (ret == -EEXIST)
+					nf_conncount_gc_list(net, &rbconn->list);
 				return rbconn->list.count;
+			}
 		}
 	}
 
-	if (!tuple)
+	if (!skb)
 		return 0;
 
-	return insert_tree(net, data, root, hash, key, tuple, zone);
+	return insert_tree(net, skb, l3num, data, root, hash, key);
 }
 
 static void tree_gc_worker(struct work_struct *work)
@@ -511,18 +577,19 @@ static void tree_gc_worker(struct work_struct *work)
 }
 
 /* Count and return number of conntrack entries in 'net' with particular 'key'.
- * If 'tuple' is not null, insert it into the accounting data structure.
- * Call with RCU read lock.
+ * If 'skb' is not null, insert the corresponding tuple into the accounting
+ * data structure. Call with RCU read lock.
  */
-unsigned int nf_conncount_count(struct net *net,
-				struct nf_conncount_data *data,
-				const u32 *key,
-				const struct nf_conntrack_tuple *tuple,
-				const struct nf_conntrack_zone *zone)
+unsigned int nf_conncount_count_skb(struct net *net,
+				    const struct sk_buff *skb,
+				    u16 l3num,
+				    struct nf_conncount_data *data,
+				    const u32 *key)
 {
-	return count_tree(net, data, key, tuple, zone);
+	return count_tree(net, skb, l3num, data, key);
+
 }
-EXPORT_SYMBOL_GPL(nf_conncount_count);
+EXPORT_SYMBOL_GPL(nf_conncount_count_skb);
 
 struct nf_conncount_data *nf_conncount_init(struct net *net, unsigned int keylen)
 {
diff --git a/net/netfilter/nft_connlimit.c b/net/netfilter/nft_connlimit.c
index 92b984fa8175..83a7d5769396 100644
--- a/net/netfilter/nft_connlimit.c
+++ b/net/netfilter/nft_connlimit.c
@@ -24,28 +24,22 @@ static inline void nft_connlimit_do_eval(struct nft_connlimit *priv,
 					 const struct nft_pktinfo *pkt,
 					 const struct nft_set_ext *ext)
 {
-	const struct nf_conntrack_zone *zone = &nf_ct_zone_dflt;
-	const struct nf_conntrack_tuple *tuple_ptr;
-	struct nf_conntrack_tuple tuple;
-	enum ip_conntrack_info ctinfo;
-	const struct nf_conn *ct;
 	unsigned int count;
+	int err;
 
-	tuple_ptr = &tuple;
-
-	ct = nf_ct_get(pkt->skb, &ctinfo);
-	if (ct != NULL) {
-		tuple_ptr = &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple;
-		zone = nf_ct_zone(ct);
-	} else if (!nf_ct_get_tuplepr(pkt->skb, skb_network_offset(pkt->skb),
-				      nft_pf(pkt), nft_net(pkt), &tuple)) {
-		regs->verdict.code = NF_DROP;
-		return;
-	}
-
-	if (nf_conncount_add(nft_net(pkt), priv->list, tuple_ptr, zone)) {
-		regs->verdict.code = NF_DROP;
-		return;
+	err = nf_conncount_add_skb(nft_net(pkt), pkt->skb, nft_pf(pkt), priv->list);
+	if (err) {
+		if (err == -EEXIST) {
+			/* Call gc to update the list count if any connection has
+			 * been closed already. This is useful for softlimit
+			 * connections like limiting bandwidth based on a number
+			 * of open connections.
+			 */
+			nf_conncount_gc_list(nft_net(pkt), priv->list);
+		} else {
+			regs->verdict.code = NF_DROP;
+			return;
+		}
 	}
 
 	count = priv->list->count;
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 225ff293cd50..3e1e8c6de9aa 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -141,12 +141,19 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 				info->ingress_vlans |= BIT(info->num_encaps - 1);
 				break;
 			case DEV_PATH_BR_VLAN_TAG:
+				if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
+					info->indev = NULL;
+					break;
+				}
 				info->encap[info->num_encaps].id = path->bridge.vlan_id;
 				info->encap[info->num_encaps].proto = path->bridge.vlan_proto;
 				info->num_encaps++;
 				break;
 			case DEV_PATH_BR_VLAN_UNTAG:
-				info->num_encaps--;
+				if (WARN_ON_ONCE(info->num_encaps-- == 0)) {
+					info->indev = NULL;
+					break;
+				}
 				break;
 			case DEV_PATH_BR_VLAN_KEEP:
 				break;
diff --git a/net/netfilter/xt_connlimit.c b/net/netfilter/xt_connlimit.c
index 0189f8b6b0bd..848287ab79cf 100644
--- a/net/netfilter/xt_connlimit.c
+++ b/net/netfilter/xt_connlimit.c
@@ -31,8 +31,6 @@ connlimit_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	struct net *net = xt_net(par);
 	const struct xt_connlimit_info *info = par->matchinfo;
-	struct nf_conntrack_tuple tuple;
-	const struct nf_conntrack_tuple *tuple_ptr = &tuple;
 	const struct nf_conntrack_zone *zone = &nf_ct_zone_dflt;
 	enum ip_conntrack_info ctinfo;
 	const struct nf_conn *ct;
@@ -40,13 +38,8 @@ connlimit_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	u32 key[5];
 
 	ct = nf_ct_get(skb, &ctinfo);
-	if (ct != NULL) {
-		tuple_ptr = &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple;
+	if (ct)
 		zone = nf_ct_zone(ct);
-	} else if (!nf_ct_get_tuplepr(skb, skb_network_offset(skb),
-				      xt_family(par), net, &tuple)) {
-		goto hotdrop;
-	}
 
 	if (xt_family(par) == NFPROTO_IPV6) {
 		const struct ipv6hdr *iph = ipv6_hdr(skb);
@@ -69,10 +62,9 @@ connlimit_mt(const struct sk_buff *skb, struct xt_action_param *par)
 		key[1] = zone->id;
 	}
 
-	connections = nf_conncount_count(net, info->data, key, tuple_ptr,
-					 zone);
+	connections = nf_conncount_count_skb(net, skb, xt_family(par), info->data, key);
 	if (connections == 0)
-		/* kmalloc failed, drop it entirely */
+		/* kmalloc failed or tuple couldn't be found, drop it entirely */
 		goto hotdrop;
 
 	return (connections > info->limit) ^ !!(info->flags & XT_CONNLIMIT_INVERT);
diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index e573e9221302..a0811e1fba65 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -928,8 +928,8 @@ static u32 ct_limit_get(const struct ovs_ct_limit_info *info, u16 zone)
 }
 
 static int ovs_ct_check_limit(struct net *net,
-			      const struct ovs_conntrack_info *info,
-			      const struct nf_conntrack_tuple *tuple)
+			      const struct sk_buff *skb,
+			      const struct ovs_conntrack_info *info)
 {
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
 	const struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
@@ -942,8 +942,9 @@ static int ovs_ct_check_limit(struct net *net,
 	if (per_zone_limit == OVS_CT_LIMIT_UNLIMITED)
 		return 0;
 
-	connections = nf_conncount_count(net, ct_limit_info->data,
-					 &conncount_key, tuple, &info->zone);
+	connections = nf_conncount_count_skb(net, skb, info->family,
+					     ct_limit_info->data,
+					     &conncount_key);
 	if (connections > per_zone_limit)
 		return -ENOMEM;
 
@@ -972,8 +973,7 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 	if (static_branch_unlikely(&ovs_ct_limit_enabled)) {
 		if (!nf_ct_is_confirmed(ct)) {
-			err = ovs_ct_check_limit(net, info,
-				&ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple);
+			err = ovs_ct_check_limit(net, skb, info);
 			if (err) {
 				net_warn_ratelimited("openvswitch: zone: %u "
 					"exceeds conntrack limit\n",
@@ -1770,8 +1770,8 @@ static int __ovs_ct_limit_get_zone_limit(struct net *net,
 	zone_limit.limit = limit;
 	nf_ct_zone_init(&ct_zone, zone_id, NF_CT_DEFAULT_ZONE_DIR, 0);
 
-	zone_limit.count = nf_conncount_count(net, data, &conncount_key, NULL,
-					      &ct_zone);
+	zone_limit.count = nf_conncount_count_skb(net, NULL, 0, data,
+						  &conncount_key);
 	return nla_put_nohdr(reply, sizeof(zone_limit), &zone_limit);
 }
 
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 32bacfc314c2..d325a90cde9e 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1597,7 +1597,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT);
 	sch->q.qlen--;
-	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	cake_heapify(q, 0);
 
@@ -1743,14 +1742,14 @@ static void cake_reconfigure(struct Qdisc *sch);
 static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			struct sk_buff **to_free)
 {
+	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
 	struct cake_sched_data *q = qdisc_priv(sch);
-	int len = qdisc_pkt_len(skb);
-	int ret;
+	int len = qdisc_pkt_len(skb), ret;
 	struct sk_buff *ack = NULL;
 	ktime_t now = ktime_get();
 	struct cake_tin_data *b;
 	struct cake_flow *flow;
-	u32 idx, tin;
+	bool same_flow = false;
 
 	/* choose flow to insert into */
 	idx = cake_classify(sch, &b, skb, q->flow_mode, &ret);
@@ -1823,6 +1822,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		consume_skb(skb);
 	} else {
 		/* not splitting */
+		int ack_pkt_len = 0;
+
 		cobalt_set_enqueue_time(skb, now);
 		get_cobalt_cb(skb)->adjusted_len = cake_overhead(q, skb);
 		flow_queue_add(flow, skb);
@@ -1833,13 +1834,13 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (ack) {
 			b->ack_drops++;
 			sch->qstats.drops++;
-			b->bytes += qdisc_pkt_len(ack);
-			len -= qdisc_pkt_len(ack);
+			ack_pkt_len = qdisc_pkt_len(ack);
+			b->bytes += ack_pkt_len;
 			q->buffer_used += skb->truesize - ack->truesize;
 			if (q->rate_flags & CAKE_FLAG_INGRESS)
 				cake_advance_shaper(q, b, ack, now, true);
 
-			qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(ack));
+			qdisc_tree_reduce_backlog(sch, 1, ack_pkt_len);
 			consume_skb(ack);
 		} else {
 			sch->q.qlen++;
@@ -1848,11 +1849,11 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 		/* stats */
 		b->packets++;
-		b->bytes	    += len;
-		b->backlogs[idx]    += len;
-		b->tin_backlog      += len;
-		sch->qstats.backlog += len;
-		q->avg_window_bytes += len;
+		b->bytes	    += len - ack_pkt_len;
+		b->backlogs[idx]    += len - ack_pkt_len;
+		b->tin_backlog      += len - ack_pkt_len;
+		sch->qstats.backlog += len - ack_pkt_len;
+		q->avg_window_bytes += len - ack_pkt_len;
 	}
 
 	if (q->overflow_timeout)
@@ -1927,24 +1928,29 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (q->buffer_used > q->buffer_max_used)
 		q->buffer_max_used = q->buffer_used;
 
-	if (q->buffer_used > q->buffer_limit) {
-		bool same_flow = false;
-		u32 dropped = 0;
-		u32 drop_id;
+	if (q->buffer_used <= q->buffer_limit)
+		return NET_XMIT_SUCCESS;
 
-		while (q->buffer_used > q->buffer_limit) {
-			dropped++;
-			drop_id = cake_drop(sch, to_free);
+	prev_qlen = sch->q.qlen;
+	prev_backlog = sch->qstats.backlog;
 
-			if ((drop_id >> 16) == tin &&
-			    (drop_id & 0xFFFF) == idx)
-				same_flow = true;
-		}
-		b->drop_overlimit += dropped;
+	while (q->buffer_used > q->buffer_limit) {
+		drop_id = cake_drop(sch, to_free);
+		if ((drop_id >> 16) == tin &&
+		    (drop_id & 0xFFFF) == idx)
+			same_flow = true;
+	}
+
+	prev_qlen -= sch->q.qlen;
+	prev_backlog -= sch->qstats.backlog;
+	b->drop_overlimit += prev_qlen;
 
-		if (same_flow)
-			return NET_XMIT_CN;
+	if (same_flow) {
+		qdisc_tree_reduce_backlog(sch, prev_qlen - 1,
+					  prev_backlog - len);
+		return NET_XMIT_CN;
 	}
+	qdisc_tree_reduce_backlog(sch, prev_qlen, prev_backlog);
 	return NET_XMIT_SUCCESS;
 }
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 4921416434f9..1c465365daf2 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1554,8 +1554,6 @@ static void sctp_close(struct sock *sk, long timeout)
 	spin_unlock_bh(&net->sctp.addr_wq_lock);
 
 	sock_put(sk);
-
-	SCTP_DBG_OBJCNT_DEC(sock);
 }
 
 /* Handle EPIPE error. */
@@ -5112,9 +5110,12 @@ static void sctp_destroy_sock(struct sock *sk)
 		sp->do_auto_asconf = 0;
 		list_del(&sp->auto_asconf_list);
 	}
+
 	sctp_endpoint_free(sp->ep);
+
 	sk_sockets_allocated_dec(sk);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	SCTP_DBG_OBJCNT_DEC(sock);
 }
 
 /* Triggered when there are no references on the socket anymore */
diff --git a/scripts/package/install-extmod-build b/scripts/package/install-extmod-build
index b96538787f3d..2576cf7902db 100755
--- a/scripts/package/install-extmod-build
+++ b/scripts/package/install-extmod-build
@@ -63,7 +63,7 @@ if [ "${CC}" != "${HOSTCC}" ]; then
 	# Clear VPATH and srcroot because the source files reside in the output
 	# directory.
 	# shellcheck disable=SC2016 # $(MAKE) and $(build) will be expanded by Make
-	"${MAKE}" run-command KBUILD_RUN_COMMAND='+$(MAKE) HOSTCC='"${CC}"' VPATH= srcroot=. $(build)='"$(realpath --relative-base=. "${destdir}")"/scripts
+	"${MAKE}" run-command KBUILD_RUN_COMMAND='+$(MAKE) HOSTCC="'"${CC}"'" VPATH= srcroot=. $(build)='"$(realpath --relative-to=. "${destdir}")"/scripts
 
 	rm -f "${destdir}/scripts/Kbuild"
 fi
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cdd225f65a62..ebaebccfbe9a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -573,18 +573,41 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
  */
 static int ima_bprm_check(struct linux_binprm *bprm)
 {
-	int ret;
 	struct lsm_prop prop;
 
 	security_current_getlsmprop_subj(&prop);
-	ret = process_measurement(bprm->file, current_cred(),
-				  &prop, NULL, 0, MAY_EXEC, BPRM_CHECK);
-	if (ret)
-		return ret;
-
-	security_cred_getlsmprop(bprm->cred, &prop);
-	return process_measurement(bprm->file, bprm->cred, &prop, NULL, 0,
-				   MAY_EXEC, CREDS_CHECK);
+	return process_measurement(bprm->file, current_cred(),
+				   &prop, NULL, 0, MAY_EXEC, BPRM_CHECK);
+}
+
+/**
+ * ima_creds_check - based on policy, collect/store measurement.
+ * @bprm: contains the linux_binprm structure
+ * @file: contains the file descriptor of the binary being executed
+ *
+ * The OS protects against an executable file, already open for write,
+ * from being executed in deny_write_access() and an executable file,
+ * already open for execute, from being modified in get_write_access().
+ * So we can be certain that what we verify and measure here is actually
+ * what is being executed.
+ *
+ * The difference from ima_bprm_check() is that ima_creds_check() is invoked
+ * only after determining the final binary to be executed without interpreter,
+ * and not when searching for intermediate binaries. The reason is that since
+ * commit 56305aa9b6fab ("exec: Compute file based creds only once"), the
+ * credentials to be applied to the process are calculated only at that stage
+ * (bprm_creds_from_file security hook instead of bprm_check_security).
+ *
+ * On success return 0.  On integrity appraisal error, assuming the file
+ * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
+ */
+static int ima_creds_check(struct linux_binprm *bprm, const struct file *file)
+{
+	struct lsm_prop prop;
+
+	security_current_getlsmprop_subj(&prop);
+	return process_measurement((struct file *)file, bprm->cred, &prop, NULL,
+				   0, MAY_EXEC, CREDS_CHECK);
 }
 
 /**
@@ -1242,6 +1265,7 @@ static int __init init_ima(void)
 static struct security_hook_list ima_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
 	LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
+	LSM_HOOK_INIT(bprm_creds_from_file, ima_creds_check),
 	LSM_HOOK_INIT(file_post_open, ima_file_check),
 	LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
 	LSM_HOOK_INIT(file_release, ima_file_free),
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 128fab897930..db6d55af5a80 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -674,7 +674,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 				goto retry;
 			}
 		}
-		if (!rc) {
+		if (rc <= 0) {
 			result = false;
 			goto out;
 		}
diff --git a/security/smack/smack.h b/security/smack/smack.h
index bf6a6ed3946c..759343a6bbae 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -286,9 +286,12 @@ int smk_tskacc(struct task_smack *, struct smack_known *,
 int smk_curacc(struct smack_known *, u32, struct smk_audit_info *);
 int smack_str_from_perm(char *string, int access);
 struct smack_known *smack_from_secid(const u32);
+int smk_parse_label_len(const char *string, int len);
 char *smk_parse_smack(const char *string, int len);
 int smk_netlbl_mls(int, char *, struct netlbl_lsm_secattr *, int);
 struct smack_known *smk_import_entry(const char *, int);
+struct smack_known *smk_import_valid_label(const char *label, int label_len,
+					   gfp_t gfp);
 void smk_insert_entry(struct smack_known *skp);
 struct smack_known *smk_find_entry(const char *);
 bool smack_privileged(int cap);
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 2e4a0cb22782..a289cb6672bd 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -443,19 +443,19 @@ struct smack_known *smk_find_entry(const char *string)
 }
 
 /**
- * smk_parse_smack - parse smack label from a text string
- * @string: a text string that might contain a Smack label
- * @len: the maximum size, or zero if it is NULL terminated.
+ * smk_parse_label_len - calculate the length of the starting segment
+ *                       in the string that constitutes a valid smack label
+ * @string: a text string that might contain a Smack label at the beginning
+ * @len: the maximum size to look into, may be zero if string is null-terminated
  *
- * Returns a pointer to the clean label or an error code.
+ * Returns the length of the segment (0 < L < SMK_LONGLABEL) or an error code.
  */
-char *smk_parse_smack(const char *string, int len)
+int smk_parse_label_len(const char *string, int len)
 {
-	char *smack;
 	int i;
 
-	if (len <= 0)
-		len = strlen(string) + 1;
+	if (len <= 0 || len > SMK_LONGLABEL)
+		len = SMK_LONGLABEL;
 
 	/*
 	 * Reserve a leading '-' as an indicator that
@@ -463,7 +463,7 @@ char *smk_parse_smack(const char *string, int len)
 	 * including /smack/cipso and /smack/cipso2
 	 */
 	if (string[0] == '-')
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	for (i = 0; i < len; i++)
 		if (string[i] > '~' || string[i] <= ' ' || string[i] == '/' ||
@@ -471,6 +471,25 @@ char *smk_parse_smack(const char *string, int len)
 			break;
 
 	if (i == 0 || i >= SMK_LONGLABEL)
+		return -EINVAL;
+
+	return i;
+}
+
+/**
+ * smk_parse_smack - copy the starting segment in the string
+ *                   that constitutes a valid smack label
+ * @string: a text string that might contain a Smack label at the beginning
+ * @len: the maximum size to look into, may be zero if string is null-terminated
+ *
+ * Returns a pointer to the copy of the label or an error code.
+ */
+char *smk_parse_smack(const char *string, int len)
+{
+	char *smack;
+	int i = smk_parse_label_len(string, len);
+
+	if (i < 0)
 		return ERR_PTR(-EINVAL);
 
 	smack = kstrndup(string, i, GFP_NOFS);
@@ -554,31 +573,25 @@ int smack_populate_secattr(struct smack_known *skp)
 }
 
 /**
- * smk_import_entry - import a label, return the list entry
- * @string: a text string that might be a Smack label
- * @len: the maximum size, or zero if it is NULL terminated.
+ * smk_import_valid_allocated_label - import a label, return the list entry
+ * @smack: a text string that is a valid Smack label and may be kfree()ed.
+ *         It is consumed: either becomes a part of the entry or kfree'ed.
  *
- * Returns a pointer to the entry in the label list that
- * matches the passed string, adding it if necessary,
- * or an error code.
+ * Returns: see description of smk_import_entry()
  */
-struct smack_known *smk_import_entry(const char *string, int len)
+static struct smack_known *
+smk_import_allocated_label(char *smack, gfp_t gfp)
 {
 	struct smack_known *skp;
-	char *smack;
 	int rc;
 
-	smack = smk_parse_smack(string, len);
-	if (IS_ERR(smack))
-		return ERR_CAST(smack);
-
 	mutex_lock(&smack_known_lock);
 
 	skp = smk_find_entry(smack);
 	if (skp != NULL)
 		goto freeout;
 
-	skp = kzalloc(sizeof(*skp), GFP_NOFS);
+	skp = kzalloc(sizeof(*skp), gfp);
 	if (skp == NULL) {
 		skp = ERR_PTR(-ENOMEM);
 		goto freeout;
@@ -608,6 +621,42 @@ struct smack_known *smk_import_entry(const char *string, int len)
 	return skp;
 }
 
+/**
+ * smk_import_entry - import a label, return the list entry
+ * @string: a text string that might contain a Smack label at the beginning
+ * @len: the maximum size to look into, may be zero if string is null-terminated
+ *
+ * Returns a pointer to the entry in the label list that
+ * matches the passed string, adding it if necessary,
+ * or an error code.
+ */
+struct smack_known *smk_import_entry(const char *string, int len)
+{
+	char *smack = smk_parse_smack(string, len);
+
+	if (IS_ERR(smack))
+		return ERR_CAST(smack);
+
+	return smk_import_allocated_label(smack, GFP_NOFS);
+}
+
+/**
+ * smk_import_valid_label - import a label, return the list entry
+ * @label a text string that is a valid Smack label, not null-terminated
+ *
+ * Returns: see description of smk_import_entry()
+ */
+struct smack_known *
+smk_import_valid_label(const char *label, int label_len, gfp_t gfp)
+{
+	char *smack = kstrndup(label, label_len, gfp);
+
+	if  (!smack)
+		return ERR_PTR(-ENOMEM);
+
+	return smk_import_allocated_label(smack, gfp);
+}
+
 /**
  * smack_from_secid - find the Smack label associated with a secid
  * @secid: an integer that might be associated with a Smack label
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index fc340a6f0dde..adf1c542d213 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -962,6 +962,42 @@ static int smack_inode_alloc_security(struct inode *inode)
 	return 0;
 }
 
+/**
+ * smk_rule_transmutes - does access rule for (subject,object) contain 't'?
+ * @subject: a pointer to the subject's Smack label entry
+ * @object: a pointer to the object's Smack label entry
+ */
+static bool
+smk_rule_transmutes(struct smack_known *subject,
+	      const struct smack_known *object)
+{
+	int may;
+
+	rcu_read_lock();
+	may = smk_access_entry(subject->smk_known, object->smk_known,
+			       &subject->smk_rules);
+	rcu_read_unlock();
+	return (may > 0) && (may & MAY_TRANSMUTE);
+}
+
+static int
+xattr_dupval(struct xattr *xattrs, int *xattr_count,
+	     const char *name, const void *value, unsigned int vallen)
+{
+	struct xattr * const xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+
+	if (!xattr)
+		return 0;
+
+	xattr->value = kmemdup(value, vallen, GFP_NOFS);
+	if (!xattr->value)
+		return -ENOMEM;
+
+	xattr->value_len = vallen;
+	xattr->name = name;
+	return 0;
+}
+
 /**
  * smack_inode_init_security - copy out the smack from an inode
  * @inode: the newly created inode
@@ -977,23 +1013,30 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     struct xattr *xattrs, int *xattr_count)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
-	struct inode_smack *issp = smack_inode(inode);
-	struct smack_known *skp = smk_of_task(tsp);
-	struct smack_known *isp = smk_of_inode(inode);
+	struct inode_smack * const issp = smack_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
-	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
-	int may;
+	int rc = 0;
+	int transflag = 0;
+	bool trans_cred;
+	bool trans_rule;
 
+	/*
+	 * UNIX domain sockets use lower level socket data. Let
+	 * UDS inode have fixed * label to keep smack_inode_permission() calm
+	 * when called from unix_find_bsd()
+	 */
+	if (S_ISSOCK(inode->i_mode)) {
+		/* forced label, no need to save to xattrs */
+		issp->smk_inode = &smack_known_star;
+		goto instant_inode;
+	}
 	/*
 	 * If equal, transmuting already occurred in
 	 * smack_dentry_create_files_as(). No need to check again.
 	 */
-	if (tsp->smk_task != tsp->smk_transmuted) {
-		rcu_read_lock();
-		may = smk_access_entry(skp->smk_known, dsp->smk_known,
-				       &skp->smk_rules);
-		rcu_read_unlock();
-	}
+	trans_cred = (tsp->smk_task == tsp->smk_transmuted);
+	if (!trans_cred)
+		trans_rule = smk_rule_transmutes(smk_of_task(tsp), dsp);
 
 	/*
 	 * In addition to having smk_task equal to smk_transmuted,
@@ -1001,47 +1044,38 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	 * requests transmutation then by all means transmute.
 	 * Mark the inode as changed.
 	 */
-	if ((tsp->smk_task == tsp->smk_transmuted) ||
-	    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
-	     smk_inode_transmutable(dir))) {
-		struct xattr *xattr_transmute;
-
+	if (trans_cred || (trans_rule && smk_inode_transmutable(dir))) {
 		/*
 		 * The caller of smack_dentry_create_files_as()
 		 * should have overridden the current cred, so the
 		 * inode label was already set correctly in
 		 * smack_inode_alloc_security().
 		 */
-		if (tsp->smk_task != tsp->smk_transmuted)
-			isp = issp->smk_inode = dsp;
-
-		issp->smk_flags |= SMK_INODE_TRANSMUTE;
-		xattr_transmute = lsm_get_xattr_slot(xattrs,
-						     xattr_count);
-		if (xattr_transmute) {
-			xattr_transmute->value = kmemdup(TRANS_TRUE,
-							 TRANS_TRUE_SIZE,
-							 GFP_NOFS);
-			if (!xattr_transmute->value)
-				return -ENOMEM;
+		if (!trans_cred)
+			issp->smk_inode = dsp;
 
-			xattr_transmute->value_len = TRANS_TRUE_SIZE;
-			xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
+		if (S_ISDIR(inode->i_mode)) {
+			transflag = SMK_INODE_TRANSMUTE;
+
+			if (xattr_dupval(xattrs, xattr_count,
+				XATTR_SMACK_TRANSMUTE,
+				TRANS_TRUE,
+				TRANS_TRUE_SIZE
+			))
+				rc = -ENOMEM;
 		}
 	}
 
-	issp->smk_flags |= SMK_INODE_INSTANT;
-
-	if (xattr) {
-		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
-		if (!xattr->value)
-			return -ENOMEM;
-
-		xattr->value_len = strlen(isp->smk_known);
-		xattr->name = XATTR_SMACK_SUFFIX;
-	}
-
-	return 0;
+	if (rc == 0)
+		if (xattr_dupval(xattrs, xattr_count,
+			    XATTR_SMACK_SUFFIX,
+			    issp->smk_inode->smk_known,
+		     strlen(issp->smk_inode->smk_known)
+		))
+			rc = -ENOMEM;
+instant_inode:
+	issp->smk_flags |= (SMK_INODE_INSTANT | transflag);
+	return rc;
 }
 
 /**
@@ -1315,13 +1349,23 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 	int check_import = 0;
 	int check_star = 0;
 	int rc = 0;
+	umode_t const i_mode = d_backing_inode(dentry)->i_mode;
 
 	/*
 	 * Check label validity here so import won't fail in post_setxattr
 	 */
-	if (strcmp(name, XATTR_NAME_SMACK) == 0 ||
-	    strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
-	    strcmp(name, XATTR_NAME_SMACKIPOUT) == 0) {
+	if (strcmp(name, XATTR_NAME_SMACK) == 0) {
+		/*
+		 * UDS inode has fixed label
+		 */
+		if (S_ISSOCK(i_mode)) {
+			rc = -EINVAL;
+		} else {
+			check_priv = 1;
+			check_import = 1;
+		}
+	} else if (strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
+		   strcmp(name, XATTR_NAME_SMACKIPOUT) == 0) {
 		check_priv = 1;
 		check_import = 1;
 	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0 ||
@@ -1331,7 +1375,7 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 		check_star = 1;
 	} else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		check_priv = 1;
-		if (!S_ISDIR(d_backing_inode(dentry)->i_mode) ||
+		if (!S_ISDIR(i_mode) ||
 		    size != TRANS_TRUE_SIZE ||
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			rc = -EINVAL;
@@ -1462,12 +1506,15 @@ static int smack_inode_removexattr(struct mnt_idmap *idmap,
 	 * Don't do anything special for these.
 	 *	XATTR_NAME_SMACKIPIN
 	 *	XATTR_NAME_SMACKIPOUT
+	 *	XATTR_NAME_SMACK if S_ISSOCK (UDS inode has fixed label)
 	 */
 	if (strcmp(name, XATTR_NAME_SMACK) == 0) {
-		struct super_block *sbp = dentry->d_sb;
-		struct superblock_smack *sbsp = smack_superblock(sbp);
+		if (!S_ISSOCK(d_backing_inode(dentry)->i_mode)) {
+			struct super_block *sbp = dentry->d_sb;
+			struct superblock_smack *sbsp = smack_superblock(sbp);
 
-		isp->smk_inode = sbsp->smk_default;
+			isp->smk_inode = sbsp->smk_default;
+		}
 	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0)
 		isp->smk_task = NULL;
 	else if (strcmp(name, XATTR_NAME_SMACKMMAP) == 0)
@@ -3585,7 +3632,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 		 */
 
 		/*
-		 * UNIX domain sockets use lower level socket data.
+		 * UDS inode has fixed label (*)
 		 */
 		if (S_ISSOCK(inode->i_mode)) {
 			final = &smack_known_star;
@@ -3663,7 +3710,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
  * @attr: which attribute to fetch
  * @ctx: buffer to receive the result
  * @size: available size in, actual size out
- * @flags: unused
+ * @flags: reserved, currently zero
  *
  * Fill the passed user space @ctx with the details of the requested
  * attribute.
@@ -3724,47 +3771,55 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
  * Sets the Smack value of the task. Only setting self
  * is permitted and only with privilege
  *
- * Returns the length of the smack label or an error code
+ * Returns zero on success or an error code
  */
-static int do_setattr(u64 attr, void *value, size_t size)
+static int do_setattr(unsigned int attr, void *value, size_t size)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct cred *new;
 	struct smack_known *skp;
-	struct smack_known_list_elem *sklep;
-	int rc;
-
-	if (!smack_privileged(CAP_MAC_ADMIN) && list_empty(&tsp->smk_relabel))
-		return -EPERM;
+	int label_len;
 
+	/*
+	 * let unprivileged user validate input, check permissions later
+	 */
 	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
 		return -EINVAL;
 
-	if (attr != LSM_ATTR_CURRENT)
-		return -EOPNOTSUPP;
-
-	skp = smk_import_entry(value, size);
-	if (IS_ERR(skp))
-		return PTR_ERR(skp);
+	label_len = smk_parse_label_len(value, size);
+	if (label_len < 0 || label_len != size)
+		return -EINVAL;
 
 	/*
 	 * No process is ever allowed the web ("@") label
 	 * and the star ("*") label.
 	 */
-	if (skp == &smack_known_web || skp == &smack_known_star)
-		return -EINVAL;
+	if (label_len == 1 /* '@', '*' */) {
+		const char c = *(const char *)value;
+
+		if (c == *smack_known_web.smk_known ||
+		    c == *smack_known_star.smk_known)
+			return -EPERM;
+	}
 
 	if (!smack_privileged(CAP_MAC_ADMIN)) {
-		rc = -EPERM;
-		list_for_each_entry(sklep, &tsp->smk_relabel, list)
-			if (sklep->smk_label == skp) {
-				rc = 0;
-				break;
-			}
-		if (rc)
-			return rc;
+		const struct smack_known_list_elem *sklep;
+		list_for_each_entry(sklep, &tsp->smk_relabel, list) {
+			const char *cp = sklep->smk_label->smk_known;
+
+			if (strlen(cp) == label_len &&
+			    strncmp(cp, value, label_len) == 0)
+				goto in_relabel;
+		}
+		return -EPERM;
+in_relabel:
+		;
 	}
 
+	skp = smk_import_valid_label(value, label_len, GFP_KERNEL);
+	if (IS_ERR(skp))
+		return PTR_ERR(skp);
+
 	new = prepare_creds();
 	if (new == NULL)
 		return -ENOMEM;
@@ -3777,7 +3832,7 @@ static int do_setattr(u64 attr, void *value, size_t size)
 	smk_destroy_label_list(&tsp->smk_relabel);
 
 	commit_creds(new);
-	return size;
+	return 0;
 }
 
 /**
@@ -3785,7 +3840,7 @@ static int do_setattr(u64 attr, void *value, size_t size)
  * @attr: which attribute to set
  * @ctx: buffer containing the data
  * @size: size of @ctx
- * @flags: unused
+ * @flags: reserved, must be zero
  *
  * Fill the passed user space @ctx with the details of the requested
  * attribute.
@@ -3795,12 +3850,26 @@ static int do_setattr(u64 attr, void *value, size_t size)
 static int smack_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
 			     u32 size, u32 flags)
 {
-	int rc;
+	if (attr != LSM_ATTR_CURRENT)
+		return -EOPNOTSUPP;
 
-	rc = do_setattr(attr, ctx->ctx, ctx->ctx_len);
-	if (rc > 0)
-		return 0;
-	return rc;
+	if (ctx->flags)
+		return -EINVAL;
+	/*
+	 * string must have \0 terminator, included in ctx->ctx
+	 * (see description of struct lsm_ctx)
+	 */
+	if (ctx->ctx_len == 0)
+		return -EINVAL;
+
+	if (ctx->ctx[ctx->ctx_len - 1] != '\0')
+		return -EINVAL;
+	/*
+	 * other do_setattr() caller, smack_setprocattr(),
+	 * does not count \0 into size, so
+	 * decreasing length by 1 to accommodate the divergence.
+	 */
+	return do_setattr(attr, ctx->ctx, ctx->ctx_len - 1);
 }
 
 /**
@@ -3812,15 +3881,39 @@ static int smack_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
  * Sets the Smack value of the task. Only setting self
  * is permitted and only with privilege
  *
- * Returns the length of the smack label or an error code
+ * Returns the size of the input value or an error code
  */
 static int smack_setprocattr(const char *name, void *value, size_t size)
 {
-	int attr = lsm_name_to_attr(name);
+	size_t realsize = size;
+	unsigned int attr = lsm_name_to_attr(name);
 
-	if (attr != LSM_ATTR_UNDEF)
-		return do_setattr(attr, value, size);
-	return -EINVAL;
+	switch (attr) {
+	case LSM_ATTR_UNDEF:   return -EINVAL;
+	default:               return -EOPNOTSUPP;
+	case LSM_ATTR_CURRENT:
+		;
+	}
+
+	/*
+	 * The value for the "current" attribute is the label
+	 * followed by one of the 4 trailers: none, \0, \n, \n\0
+	 *
+	 * I.e. following inputs are accepted as 3-characters long label "foo":
+	 *
+	 *   "foo"     (3 characters)
+	 *   "foo\0"   (4 characters)
+	 *   "foo\n"   (4 characters)
+	 *   "foo\n\0" (5 characters)
+	 */
+
+	if (realsize && (((const char *)value)[realsize - 1] == '\0'))
+		--realsize;
+
+	if (realsize && (((const char *)value)[realsize - 1] == '\n'))
+		--realsize;
+
+	return do_setattr(attr, value, realsize) ? : size;
 }
 
 /**
@@ -4850,6 +4943,11 @@ static int smack_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 
 static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
+	/*
+	 * UDS inode has fixed label. Ignore nfs label.
+	 */
+	if (S_ISSOCK(inode->i_mode))
+		return 0;
 	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, ctx,
 				       ctxlen, 0);
 }
@@ -4915,7 +5013,6 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	struct task_smack *otsp = smack_cred(old);
 	struct task_smack *ntsp = smack_cred(new);
 	struct inode_smack *isp;
-	int may;
 
 	/*
 	 * Use the process credential unless all of
@@ -4929,18 +5026,12 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	isp = smack_inode(d_inode(dentry->d_parent));
 
 	if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
-		rcu_read_lock();
-		may = smk_access_entry(otsp->smk_task->smk_known,
-				       isp->smk_inode->smk_known,
-				       &otsp->smk_task->smk_rules);
-		rcu_read_unlock();
-
 		/*
 		 * If the directory is transmuting and the rule
 		 * providing access is transmuting use the containing
 		 * directory label instead of the process label.
 		 */
-		if (may > 0 && (may & MAY_TRANSMUTE)) {
+		if (smk_rule_transmutes(otsp->smk_task, isp->smk_inode)) {
 			ntsp->smk_task = isp->smk_inode;
 			ntsp->smk_transmuted = ntsp->smk_task;
 		}
diff --git a/sound/firewire/dice/dice-extension.c b/sound/firewire/dice/dice-extension.c
index 02f4a8318e38..48bfb3ad93ce 100644
--- a/sound/firewire/dice/dice-extension.c
+++ b/sound/firewire/dice/dice-extension.c
@@ -116,7 +116,7 @@ static int detect_stream_formats(struct snd_dice *dice, u64 section_addr)
 			break;
 
 		base_offset += EXT_APP_STREAM_ENTRIES;
-		stream_count = be32_to_cpu(reg[0]);
+		stream_count = min_t(unsigned int, be32_to_cpu(reg[0]), MAX_STREAMS);
 		err = read_stream_entries(dice, section_addr, base_offset,
 					  stream_count, mode,
 					  dice->tx_pcm_chs,
@@ -125,7 +125,7 @@ static int detect_stream_formats(struct snd_dice *dice, u64 section_addr)
 			break;
 
 		base_offset += stream_count * EXT_APP_STREAM_ENTRY_SIZE;
-		stream_count = be32_to_cpu(reg[1]);
+		stream_count = min_t(unsigned int, be32_to_cpu(reg[1]), MAX_STREAMS);
 		err = read_stream_entries(dice, section_addr, base_offset,
 					  stream_count,
 					  mode, dice->rx_pcm_chs,
diff --git a/sound/firewire/motu/motu-hwdep.c b/sound/firewire/motu/motu-hwdep.c
index fa2685665db3..38807dd7a766 100644
--- a/sound/firewire/motu/motu-hwdep.c
+++ b/sound/firewire/motu/motu-hwdep.c
@@ -75,7 +75,7 @@ static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 		while (consumed < count &&
 		       snd_motu_register_dsp_message_parser_copy_event(motu, &ev)) {
 			ptr = (u32 __user *)(buf + consumed);
-			if (put_user(ev, ptr))
+			if (consumed + sizeof(ev) > count || put_user(ev, ptr))
 				return -EFAULT;
 			consumed += sizeof(ev);
 		}
@@ -83,10 +83,11 @@ static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 		event.motu_register_dsp_change.type = SNDRV_FIREWIRE_EVENT_MOTU_REGISTER_DSP_CHANGE;
 		event.motu_register_dsp_change.count =
 			(consumed - sizeof(event.motu_register_dsp_change)) / 4;
-		if (copy_to_user(buf, &event, sizeof(event.motu_register_dsp_change)))
+		if (copy_to_user(buf, &event,
+				 min_t(long, count, sizeof(event.motu_register_dsp_change))))
 			return -EFAULT;
 
-		count = consumed;
+		count = min_t(long, count, consumed);
 	} else {
 		spin_unlock_irq(&motu->lock);
 
diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 5e0c0f1e231b..89e5db6bf65f 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6725,6 +6725,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1314, "ASUS GA605K", ALC285_FIXUP_ASUS_GA605K_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1384, "ASUS RC73XA", ALC287_FIXUP_TXNW2781_I2C),
+	SND_PCI_QUIRK(0x1043, 0x1394, "ASUS RC73YA", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650PY/PZ/PV/PU/PYV/PZV/PIV/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index 0ef77fae0402..8d0cfe0a7ecb 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1917,6 +1917,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 
 	cs35l41->dacpi = adev;
 	physdev = get_device(acpi_get_first_physical_node(adev));
+	if (!physdev)
+		return -ENODEV;
 
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
 	if (IS_ERR(sub))
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 32f16a8f9df3..38c9abb15cd0 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -85,6 +85,7 @@ static const struct acpi_gpio_mapping tas2781_speaker_id_gpios[] = {
 
 static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
 {
+	struct gpio_desc *speaker_id;
 	struct acpi_device *adev;
 	struct device *physdev;
 	LIST_HEAD(resources);
@@ -117,19 +118,31 @@ static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
 	/* Speaker id was needed for ASUS projects. */
 	ret = kstrtou32(sub, 16, &subid);
 	if (!ret && upper_16_bits(subid) == PCI_VENDOR_ID_ASUSTEK) {
-		ret = devm_acpi_dev_add_driver_gpios(p->dev,
-			tas2781_speaker_id_gpios);
-		if (ret < 0)
+		ret = acpi_dev_add_driver_gpios(adev, tas2781_speaker_id_gpios);
+		if (ret < 0) {
 			dev_err(p->dev, "Failed to add driver gpio %d.\n",
 				ret);
-		p->speaker_id = devm_gpiod_get(p->dev, "speakerid", GPIOD_IN);
-		if (IS_ERR(p->speaker_id)) {
-			dev_err(p->dev, "Failed to get Speaker id.\n");
-			ret = PTR_ERR(p->speaker_id);
-			goto err;
+			p->speaker_id = -1;
+			goto end_2563;
+		}
+
+		speaker_id = fwnode_gpiod_get_index(acpi_fwnode_handle(adev),
+			"speakerid", 0, GPIOD_IN, NULL);
+		if (!IS_ERR(speaker_id)) {
+			p->speaker_id = gpiod_get_value_cansleep(speaker_id);
+			dev_dbg(p->dev, "Got speaker id gpio from ACPI: %d.\n",
+				p->speaker_id);
+			gpiod_put(speaker_id);
+		} else {
+			p->speaker_id = -1;
+			ret = PTR_ERR(speaker_id);
+			dev_err(p->dev, "Get speaker id gpio failed %d.\n",
+				ret);
 		}
+
+		acpi_dev_remove_driver_gpios(adev);
 	} else {
-		p->speaker_id = NULL;
+		p->speaker_id = -1;
 	}
 
 end_2563:
@@ -430,23 +443,16 @@ static void tasdevice_dspfw_init(void *context)
 	struct tas2781_hda *tas_hda = dev_get_drvdata(tas_priv->dev);
 	struct tas2781_hda_i2c_priv *hda_priv = tas_hda->hda_priv;
 	struct hda_codec *codec = tas_priv->codec;
-	int ret, spk_id;
+	int ret;
 
 	tasdevice_dsp_remove(tas_priv);
 	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
-	if (tas_priv->speaker_id != NULL) {
-		// Speaker id need to be checked for ASUS only.
-		spk_id = gpiod_get_value(tas_priv->speaker_id);
-		if (spk_id < 0) {
-			// Speaker id is not valid, use default.
-			dev_dbg(tas_priv->dev, "Wrong spk_id = %d\n", spk_id);
-			spk_id = 0;
-		}
+	if (tas_priv->speaker_id >= 0) {
 		snprintf(tas_priv->coef_binaryname,
 			  sizeof(tas_priv->coef_binaryname),
 			  "TAS2XXX%04X%d.bin",
 			  lower_16_bits(codec->core.subsystem_id),
-			  spk_id);
+			  tas_priv->speaker_id);
 	} else {
 		snprintf(tas_priv->coef_binaryname,
 			  sizeof(tas_priv->coef_binaryname),
diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index bd679e2da154..9eaab9ca4f95 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -950,9 +950,9 @@ wavefront_send_sample (snd_wavefront_t *dev,
 	if (header->size) {
 		dev->freemem = wavefront_freemem (dev);
 
-		if (dev->freemem < (int)header->size) {
+		if (dev->freemem < 0 || dev->freemem < header->size) {
 			dev_err(dev->card->dev,
-				"insufficient memory to load %d byte sample.\n",
+				"insufficient memory to load %u byte sample.\n",
 				header->size);
 			return -ENOMEM;
 		}
diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index 4ba0a66981ea..283a674c7e2c 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -157,6 +157,8 @@ static int acp_i2s_set_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask, u32 rx_mas
 
 	spin_lock_irq(&chip->acp_lock);
 	list_for_each_entry(stream, &chip->stream_list, list) {
+		if (dai->id != stream->dai_id)
+			continue;
 		switch (chip->acp_rev) {
 		case ACP_RN_PCI_ID:
 		case ACP_RMB_PCI_ID:
diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index 3078f459e005..4e477c48d4bd 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -219,7 +219,10 @@ static int set_acp_i2s_dma_fifo(struct snd_pcm_substream *substream,
 					SP_PB_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = ACP_I2S_TX_FIFOADDR(chip);
 			reg_fifo_size = ACP_I2S_TX_FIFOSIZE(chip);
-			phy_addr = I2S_SP_TX_MEM_WINDOW_START + stream->reg_offset;
+			if (chip->acp_rev >= ACP70_PCI_ID)
+				phy_addr = ACP7x_I2S_SP_TX_MEM_WINDOW_START;
+			else
+				phy_addr = I2S_SP_TX_MEM_WINDOW_START + stream->reg_offset;
 			writel(phy_addr, chip->base + ACP_I2S_TX_RINGBUFADDR(chip));
 		} else {
 			reg_dma_size = ACP_I2S_RX_DMA_SIZE(chip);
@@ -227,7 +230,10 @@ static int set_acp_i2s_dma_fifo(struct snd_pcm_substream *substream,
 					SP_CAPT_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = ACP_I2S_RX_FIFOADDR(chip);
 			reg_fifo_size = ACP_I2S_RX_FIFOSIZE(chip);
-			phy_addr = I2S_SP_RX_MEM_WINDOW_START + stream->reg_offset;
+			if (chip->acp_rev >= ACP70_PCI_ID)
+				phy_addr = ACP7x_I2S_SP_RX_MEM_WINDOW_START;
+			else
+				phy_addr = I2S_SP_RX_MEM_WINDOW_START + stream->reg_offset;
 			writel(phy_addr, chip->base + ACP_I2S_RX_RINGBUFADDR(chip));
 		}
 		break;
@@ -238,7 +244,10 @@ static int set_acp_i2s_dma_fifo(struct snd_pcm_substream *substream,
 					BT_PB_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = ACP_BT_TX_FIFOADDR(chip);
 			reg_fifo_size = ACP_BT_TX_FIFOSIZE(chip);
-			phy_addr = I2S_BT_TX_MEM_WINDOW_START + stream->reg_offset;
+			if (chip->acp_rev >= ACP70_PCI_ID)
+				phy_addr = ACP7x_I2S_BT_TX_MEM_WINDOW_START;
+			else
+				phy_addr = I2S_BT_TX_MEM_WINDOW_START + stream->reg_offset;
 			writel(phy_addr, chip->base + ACP_BT_TX_RINGBUFADDR(chip));
 		} else {
 			reg_dma_size = ACP_BT_RX_DMA_SIZE(chip);
@@ -246,7 +255,10 @@ static int set_acp_i2s_dma_fifo(struct snd_pcm_substream *substream,
 					BT_CAPT_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = ACP_BT_RX_FIFOADDR(chip);
 			reg_fifo_size = ACP_BT_RX_FIFOSIZE(chip);
-			phy_addr = I2S_BT_TX_MEM_WINDOW_START + stream->reg_offset;
+			if (chip->acp_rev >= ACP70_PCI_ID)
+				phy_addr = ACP7x_I2S_BT_RX_MEM_WINDOW_START;
+			else
+				phy_addr = I2S_BT_RX_MEM_WINDOW_START + stream->reg_offset;
 			writel(phy_addr, chip->base + ACP_BT_RX_RINGBUFADDR(chip));
 		}
 		break;
@@ -257,7 +269,10 @@ static int set_acp_i2s_dma_fifo(struct snd_pcm_substream *substream,
 					HS_PB_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = ACP_HS_TX_FIFOADDR;
 			reg_fifo_size = ACP_HS_TX_FIFOSIZE;
-			phy_addr = I2S_HS_TX_MEM_WINDOW_START + stream->reg_offset;
+			if (chip->acp_rev >= ACP70_PCI_ID)
+				phy_addr = ACP7x_I2S_HS_TX_MEM_WINDOW_START;
+			else
+				phy_addr = I2S_HS_TX_MEM_WINDOW_START + stream->reg_offset;
 			writel(phy_addr, chip->base + ACP_HS_TX_RINGBUFADDR);
 		} else {
 			reg_dma_size = ACP_HS_RX_DMA_SIZE;
@@ -265,7 +280,10 @@ static int set_acp_i2s_dma_fifo(struct snd_pcm_substream *substream,
 					HS_CAPT_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = ACP_HS_RX_FIFOADDR;
 			reg_fifo_size = ACP_HS_RX_FIFOSIZE;
-			phy_addr = I2S_HS_RX_MEM_WINDOW_START + stream->reg_offset;
+			if (chip->acp_rev >= ACP70_PCI_ID)
+				phy_addr = ACP7x_I2S_HS_RX_MEM_WINDOW_START;
+			else
+				phy_addr = I2S_HS_RX_MEM_WINDOW_START + stream->reg_offset;
 			writel(phy_addr, chip->base + ACP_HS_RX_RINGBUFADDR);
 		}
 		break;
diff --git a/sound/soc/bcm/bcm63xx-pcm-whistler.c b/sound/soc/bcm/bcm63xx-pcm-whistler.c
index e3a4fcc63a56..efeb06ddabeb 100644
--- a/sound/soc/bcm/bcm63xx-pcm-whistler.c
+++ b/sound/soc/bcm/bcm63xx-pcm-whistler.c
@@ -358,7 +358,9 @@ static int bcm63xx_soc_pcm_new(struct snd_soc_component *component,
 
 	i2s_priv = dev_get_drvdata(snd_soc_rtd_to_cpu(rtd, 0)->dev);
 
-	of_dma_configure(pcm->card->dev, pcm->card->dev->of_node, 1);
+	ret = of_dma_configure(pcm->card->dev, pcm->card->dev->of_node, 1);
+	if (ret)
+		return ret;
 
 	ret = dma_coerce_mask_and_coherent(pcm->card->dev, DMA_BIT_MASK(32));
 	if (ret)
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6d7e4725d89c..412f8710049d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -169,6 +169,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_MT6359
 	imply SND_SOC_MT6660
 	imply SND_SOC_NAU8315
+	imply SND_SOC_NAU8325
 	imply SND_SOC_NAU8540
 	imply SND_SOC_NAU8810
 	imply SND_SOC_NAU8821
@@ -2655,6 +2656,10 @@ config SND_SOC_MT6660
 config SND_SOC_NAU8315
 	tristate "Nuvoton Technology Corporation NAU8315 CODEC"
 
+config SND_SOC_NAU8325
+	tristate "Nuvoton Technology Corporation NAU8325 CODEC"
+	depends on I2C
+
 config SND_SOC_NAU8540
 	tristate "Nuvoton Technology Corporation NAU85L40 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index a68c3d192a1b..53976868e6a7 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -190,6 +190,7 @@ snd-soc-mt6359-y := mt6359.o
 snd-soc-mt6359-accdet-y := mt6359-accdet.o
 snd-soc-mt6660-y := mt6660.o
 snd-soc-nau8315-y := nau8315.o
+snd-soc-nau8325-y := nau8325.o
 snd-soc-nau8540-y := nau8540.o
 snd-soc-nau8810-y := nau8810.o
 snd-soc-nau8821-y := nau8821.o
@@ -610,6 +611,7 @@ obj-$(CONFIG_SND_SOC_MT6359)	+= snd-soc-mt6359.o
 obj-$(CONFIG_SND_SOC_MT6359_ACCDET) += mt6359-accdet.o
 obj-$(CONFIG_SND_SOC_MT6660)	+= snd-soc-mt6660.o
 obj-$(CONFIG_SND_SOC_NAU8315)   += snd-soc-nau8315.o
+obj-$(CONFIG_SND_SOC_NAU8325)   += snd-soc-nau8325.o
 obj-$(CONFIG_SND_SOC_NAU8540)   += snd-soc-nau8540.o
 obj-$(CONFIG_SND_SOC_NAU8810)   += snd-soc-nau8810.o
 obj-$(CONFIG_SND_SOC_NAU8821)   += snd-soc-nau8821.o
diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 57cf601d3df3..a6c04dd3de3e 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -671,7 +671,15 @@ static int ak4458_runtime_resume(struct device *dev)
 	regcache_cache_only(ak4458->regmap, false);
 	regcache_mark_dirty(ak4458->regmap);
 
-	return regcache_sync(ak4458->regmap);
+	ret = regcache_sync(ak4458->regmap);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	regcache_cache_only(ak4458->regmap, true);
+	regulator_bulk_disable(ARRAY_SIZE(ak4458->supplies), ak4458->supplies);
+	return ret;
 }
 
 static const struct snd_soc_component_driver soc_codec_dev_ak4458 = {
diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index 683f3e472f50..73684fc5beb1 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -372,7 +372,15 @@ static int ak5558_runtime_resume(struct device *dev)
 	regcache_cache_only(ak5558->regmap, false);
 	regcache_mark_dirty(ak5558->regmap);
 
-	return regcache_sync(ak5558->regmap);
+	ret = regcache_sync(ak5558->regmap);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	regcache_cache_only(ak5558->regmap, true);
+	regulator_bulk_disable(ARRAY_SIZE(ak5558->supplies), ak5558->supplies);
+	return ret;
 }
 
 static const struct dev_pm_ops ak5558_pm = {
diff --git a/sound/soc/codecs/nau8325.c b/sound/soc/codecs/nau8325.c
index 2266f320a8f2..d396160213f5 100644
--- a/sound/soc/codecs/nau8325.c
+++ b/sound/soc/codecs/nau8325.c
@@ -386,7 +386,8 @@ static int nau8325_clksrc_choose(struct nau8325 *nau8325,
 				 const struct nau8325_srate_attr **srate_table,
 				 int *n1_sel, int *mult_sel, int *n2_sel)
 {
-	int i, j, mclk, mclk_max, ratio, ratio_sel, n2_max;
+	int i, j, mclk, ratio;
+	int mclk_max = 0, ratio_sel = 0, n2_max = 0;
 
 	if (!nau8325->mclk || !nau8325->fs)
 		goto proc_err;
@@ -408,7 +409,6 @@ static int nau8325_clksrc_choose(struct nau8325 *nau8325,
 	}
 
 	/* Get MCLK_SRC through 1/N, Multiplier, and then 1/N2. */
-	mclk_max = 0;
 	for (i = 0; i < ARRAY_SIZE(mclk_n1_div); i++) {
 		for (j = 0; j < ARRAY_SIZE(mclk_n3_mult); j++) {
 			mclk = nau8325->mclk << mclk_n3_mult[j].param;
@@ -829,8 +829,7 @@ static int nau8325_read_device_properties(struct device *dev,
 	return 0;
 }
 
-static int nau8325_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int nau8325_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct nau8325 *nau8325 = dev_get_platdata(dev);
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 9890b1a6d292..e3a4d95b2b82 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -1340,7 +1340,7 @@ static int tasdevice_create_cali_ctrls(struct tasdevice_priv *priv)
 
 	/*
 	 * Alloc kcontrol via devm_kzalloc(), which don't manually
-	 * free the kcontrol。
+	 * free the kcontrol.
 	 */
 	cali_ctrls = devm_kcalloc(priv->dev, nctrls,
 		sizeof(cali_ctrls[0]), GFP_KERNEL);
diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 5d804860f7d8..58db4906a01d 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1421,7 +1421,7 @@ static irqreturn_t irq0_isr(int irq, void *devid)
 						bitrev32(val);
 				}
 				/* clear CS control register */
-				memset_io(reg_ctrl, 0, sizeof(val));
+				writel_relaxed(0, reg_ctrl);
 			}
 		} else {
 			regmap_read(xcvr->regmap, FSL_XCVR_RX_CS_DATA_0,
diff --git a/sound/soc/intel/catpt/pcm.c b/sound/soc/intel/catpt/pcm.c
index bf734c69c4e0..eb03cecdee28 100644
--- a/sound/soc/intel/catpt/pcm.c
+++ b/sound/soc/intel/catpt/pcm.c
@@ -417,8 +417,10 @@ static int catpt_dai_hw_params(struct snd_pcm_substream *substream,
 		return CATPT_IPC_ERROR(ret);
 
 	ret = catpt_dai_apply_usettings(dai, stream);
-	if (ret)
+	if (ret) {
+		catpt_ipc_free_stream(cdev, stream->info.stream_hw_id);
 		return ret;
+	}
 
 	stream->allocated = true;
 	return 0;
diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
index 0ccb6775f4de..19b12564f822 100644
--- a/sound/soc/sdca/sdca_functions.c
+++ b/sound/soc/sdca/sdca_functions.c
@@ -1263,7 +1263,7 @@ find_sdca_entity_hide(struct device *dev, struct fwnode_handle *function_node,
 	unsigned char *report_desc = NULL;
 
 	ret = fwnode_property_read_u32(entity_node,
-				       "mipi-sdca-RxUMP-ownership-transition-maxdelay", &delay);
+				       "mipi-sdca-RxUMP-ownership-transition-max-delay", &delay);
 	if (!ret)
 		hide->max_delay = delay;
 
diff --git a/tools/include/nolibc/dirent.h b/tools/include/nolibc/dirent.h
index 758b95c48e7a..61a122a60327 100644
--- a/tools/include/nolibc/dirent.h
+++ b/tools/include/nolibc/dirent.h
@@ -86,9 +86,9 @@ int readdir_r(DIR *dirp, struct dirent *entry, struct dirent **result)
 	 * readdir() can only return one entry at a time.
 	 * Make sure the non-returned ones are not skipped.
 	 */
-	ret = lseek(fd, ldir->d_off, SEEK_SET);
-	if (ret == -1)
-		return errno;
+	ret = sys_lseek(fd, ldir->d_off, SEEK_SET);
+	if (ret < 0)
+		return -ret;
 
 	entry->d_ino = ldir->d_ino;
 	/* the destination should always be big enough */
diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 7630234408c5..724d05ce6962 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -600,7 +600,11 @@ int sscanf(const char *str, const char *format, ...)
 static __attribute__((unused))
 void perror(const char *msg)
 {
+#ifdef NOLIBC_IGNORE_ERRNO
+	fprintf(stderr, "%s%sunknown error\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "");
+#else
 	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
+#endif
 }
 
 static __attribute__((unused))
diff --git a/tools/include/nolibc/sys/wait.h b/tools/include/nolibc/sys/wait.h
index 56ddb806da7f..c1b797c234d1 100644
--- a/tools/include/nolibc/sys/wait.h
+++ b/tools/include/nolibc/sys/wait.h
@@ -82,23 +82,29 @@ pid_t waitpid(pid_t pid, int *status, int options)
 
 	switch (info.si_code) {
 	case 0:
-		*status = 0;
+		if (status)
+			*status = 0;
 		break;
 	case CLD_EXITED:
-		*status = (info.si_status & 0xff) << 8;
+		if (status)
+			*status = (info.si_status & 0xff) << 8;
 		break;
 	case CLD_KILLED:
-		*status = info.si_status & 0x7f;
+		if (status)
+			*status = info.si_status & 0x7f;
 		break;
 	case CLD_DUMPED:
-		*status = (info.si_status & 0x7f) | 0x80;
+		if (status)
+			*status = (info.si_status & 0x7f) | 0x80;
 		break;
 	case CLD_STOPPED:
 	case CLD_TRAPPED:
-		*status = (info.si_status << 8) + 0x7f;
+		if (status)
+			*status = (info.si_status << 8) + 0x7f;
 		break;
 	case CLD_CONTINUED:
-		*status = 0xffff;
+		if (status)
+			*status = 0xffff;
 		break;
 	default:
 		return -1;
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 37682908cb0f..ea9f3311bbac 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1062,7 +1062,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	if (base_btf) {
 		btf->base_btf = base_btf;
 		btf->start_id = btf__type_cnt(base_btf);
-		btf->start_str_off = base_btf->hdr->str_len;
+		btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
 	}
 
 	if (is_mmap) {
@@ -5819,7 +5819,7 @@ void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 {
 	btf->base_btf = (struct btf *)base_btf;
 	btf->start_id = btf__type_cnt(base_btf);
-	btf->start_str_off = base_btf->hdr->str_len;
+	btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
 }
 
 int btf__relocate(struct btf *btf, const struct btf *base_btf)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d23fefcb15d3..ac2b8813c4a0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2563,7 +2563,8 @@ static int decode_sections(struct objtool_file *file)
 	 * Must be before add_jump_destinations(), which depends on 'func'
 	 * being set for alternatives, to enable proper sibling call detection.
 	 */
-	if (opts.stackval || opts.orc || opts.uaccess || opts.noinstr) {
+	if (opts.stackval || opts.orc || opts.uaccess || opts.noinstr ||
+	    opts.hack_jump_label) {
 		ret = add_special_section_alts(file);
 		if (ret)
 			return ret;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index ca5d77db692a..9cb51fcde798 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -108,7 +108,7 @@ struct symbol_hole {
 };
 
 /*
- * Find !section symbol where @offset is after it.
+ * Find the last symbol before @offset.
  */
 static int symbol_hole_by_offset(const void *key, const struct rb_node *node)
 {
@@ -119,8 +119,7 @@ static int symbol_hole_by_offset(const void *key, const struct rb_node *node)
 		return -1;
 
 	if (sh->key >= s->offset + s->len) {
-		if (s->type != STT_SECTION)
-			sh->sym = s;
+		sh->sym = s;
 		return 1;
 	}
 
@@ -412,7 +411,8 @@ static void elf_add_symbol(struct elf *elf, struct symbol *sym)
 	sym->len = sym->sym.st_size;
 
 	__sym_for_each(iter, &sym->sec->symbol_tree, sym->offset, sym->offset) {
-		if (iter->offset == sym->offset && iter->type == sym->type)
+		if (iter->offset == sym->offset && iter->type == sym->type &&
+		    iter->len == sym->len)
 			iter->alias = sym;
 	}
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7ea3a11aca70..e7bebd1fa810 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2885,11 +2885,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		rec->bytes_written += off_cpu_write(rec->session);
 
 	record__read_lost_samples(rec);
-	record__synthesize(rec, true);
 	/* this will be recalculated during process_buildids() */
 	rec->samples = 0;
 
 	if (!err) {
+		record__synthesize(rec, true);
 		if (!rec->timestamp_filename) {
 			record__finish_output(rec);
 		} else {
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2c38dd98f6ca..64af743bb10a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2511,6 +2511,7 @@ int cmd_stat(int argc, const char **argv)
 	unsigned int interval, timeout;
 	const char * const stat_subcommands[] = { "record", "report" };
 	char errbuf[BUFSIZ];
+	struct evsel *counter;
 
 	setlocale(LC_ALL, "");
 
@@ -2768,6 +2769,18 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
 
+	evlist__for_each_entry(evsel_list, counter) {
+		/*
+		 * Setup BPF counters to require CPUs as any(-1) isn't
+		 * supported. evlist__create_maps below will propagate this
+		 * information to the evsels. Note, evsel__is_bperf isn't yet
+		 * set up, and this change must happen early, so directly use
+		 * the bpf_counter variable and target information.
+		 */
+		if ((counter->bpf_counter || target.use_bpf) && !target__has_cpu(&target))
+			counter->core.requires_cpu = true;
+	}
+
 	if (evlist__create_maps(evsel_list, &target) < 0) {
 		if (target__has_task(&target)) {
 			pr_err("Problems finding threads of monitor\n");
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0dd475a744b6..3c3fb8c2a36d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1020,7 +1020,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	int err, nr;
 
 	err = evsel__get_arch(evsel, &arch);
-	if (err < 0)
+	if (err)
 		return err;
 
 	if (parch)
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 13cadb2f1cea..3c4ef5381c76 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -357,31 +357,20 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " AR");
 		}
 
-		switch (SPE_OP_PKT_LDST_SUBCLASS_GET(payload)) {
-		case SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP:
+		if (SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " SIMD-FP");
-			break;
-		case SPE_OP_PKT_LDST_SUBCLASS_GP_REG:
+		else if (SPE_OP_PKT_LDST_SUBCLASS_GP_REG(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " GP-REG");
-			break;
-		case SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG:
+		else if (SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " UNSPEC-REG");
-			break;
-		case SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG:
+		else if (SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " NV-SYSREG");
-			break;
-		case SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG:
+		else if (SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " MTE-TAG");
-			break;
-		case SPE_OP_PKT_LDST_SUBCLASS_MEMCPY:
+		else if (SPE_OP_PKT_LDST_SUBCLASS_MEMCPY(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " MEMCPY");
-			break;
-		case SPE_OP_PKT_LDST_SUBCLASS_MEMSET:
+		else if (SPE_OP_PKT_LDST_SUBCLASS_MEMSET(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " MEMSET");
-			break;
-		default:
-			break;
-		}
 
 		if (SPE_OP_PKT_IS_LDST_SVE(payload)) {
 			/* SVE effective vector length */
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 2cdf9f6da268..51d5d038f620 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -118,14 +118,13 @@ enum arm_spe_events {
 
 #define SPE_OP_PKT_IS_OTHER_SVE_OP(v)		(((v) & (BIT(7) | BIT(3) | BIT(0))) == 0x8)
 
-#define SPE_OP_PKT_LDST_SUBCLASS_GET(v)		((v) & GENMASK_ULL(7, 1))
-#define SPE_OP_PKT_LDST_SUBCLASS_GP_REG		0x0
-#define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP	0x4
-#define SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG	0x10
-#define SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG	0x30
-#define SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG	0x14
-#define SPE_OP_PKT_LDST_SUBCLASS_MEMCPY		0x20
-#define SPE_OP_PKT_LDST_SUBCLASS_MEMSET		0x25
+#define SPE_OP_PKT_LDST_SUBCLASS_GP_REG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x0)
+#define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP(v)	(((v) & GENMASK_ULL(7, 1)) == 0x4)
+#define SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x10)
+#define SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x30)
+#define SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x14)
+#define SPE_OP_PKT_LDST_SUBCLASS_MEMCPY(v)	(((v) & GENMASK_ULL(7, 1)) == 0x20)
+#define SPE_OP_PKT_LDST_SUBCLASS_MEMSET(v)	(((v) & GENMASK_ULL(7, 0)) == 0x25)
 
 #define SPE_OP_PKT_IS_LDST_ATOMIC(v)		(((v) & (GENMASK_ULL(7, 5) | BIT(1))) == 0x2)
 
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index ed88ba570c80..af31aa28ff44 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -402,6 +402,7 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 	struct bperf_leader_bpf *skel = bperf_leader_bpf__open();
 	int link_fd, diff_map_fd, err;
 	struct bpf_link *link = NULL;
+	struct perf_thread_map *threads;
 
 	if (!skel) {
 		pr_err("Failed to open leader skeleton\n");
@@ -437,7 +438,11 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 	 * following evsel__open_per_cpu call
 	 */
 	evsel->leader_skel = skel;
-	evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
+	assert(!perf_cpu_map__has_any_cpu_or_is_empty(evsel->core.cpus));
+	/* Always open system wide. */
+	threads = thread_map__new_by_tid(-1);
+	evsel__open(evsel, evsel->core.cpus, threads);
+	perf_thread_map__put(threads);
 
 out:
 	bperf_leader_bpf__destroy(skel);
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 60b81d586323..7b5671f13c53 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -184,6 +184,9 @@ int lock_contention_prepare(struct lock_contention *con)
 	struct evlist *evlist = con->evlist;
 	struct target *target = con->target;
 
+	/* make sure it loads the kernel map before lookup */
+	map__load(machine__kernel_map(con->machine));
+
 	skel = lock_contention_bpf__open();
 	if (!skel) {
 		pr_err("Failed to open lock-contention BPF skeleton\n");
@@ -749,9 +752,6 @@ int lock_contention_read(struct lock_contention *con)
 		bpf_prog_test_run_opts(prog_fd, &opts);
 	}
 
-	/* make sure it loads the kernel map */
-	maps__load_first(machine->kmaps);
-
 	prev_key = NULL;
 	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
 		s64 ls_key;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5df59812b80c..9efd177551f2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2396,7 +2396,7 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
 	/* Please add new feature detection here. */
 
 	attr.inherit = true;
-	attr.sample_type = PERF_SAMPLE_READ;
+	attr.sample_type = PERF_SAMPLE_READ | PERF_SAMPLE_TID;
 	if (has_attr_feature(&attr, /*flags=*/0))
 		goto found;
 	perf_missing_features.inherit_sample_read = true;
diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index 591548b10e34..a1cd5196f4ec 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -173,6 +173,8 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	Elf_Shdr *shdr;
 	uint64_t eh_frame_base_offset;
 	char *strsym = NULL;
+	void *build_id_data = NULL, *tmp;
+	int build_id_data_len;
 	int symlen;
 	int retval = -1;
 
@@ -251,6 +253,14 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	shdr->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
 	shdr->sh_entsize = 0;
 
+	build_id_data = malloc(csize);
+	if (build_id_data == NULL) {
+		warnx("cannot allocate build-id data");
+		goto error;
+	}
+	memcpy(build_id_data, code, csize);
+	build_id_data_len = csize;
+
 	/*
 	 * Setup .eh_frame_hdr and .eh_frame
 	 */
@@ -334,6 +344,15 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	shdr->sh_entsize = sizeof(Elf_Sym);
 	shdr->sh_link = unwinding ? 6 : 4; /* index of .strtab section */
 
+	tmp = realloc(build_id_data, build_id_data_len + sizeof(symtab));
+	if (tmp == NULL) {
+		warnx("cannot allocate build-id data");
+		goto error;
+	}
+	memcpy(tmp + build_id_data_len, symtab, sizeof(symtab));
+	build_id_data = tmp;
+	build_id_data_len += sizeof(symtab);
+
 	/*
 	 * setup symbols string table
 	 * 2 = 1 for 0 in 1st entry, 1 for the 0 at end of symbol for 2nd entry
@@ -376,6 +395,15 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	shdr->sh_flags = 0;
 	shdr->sh_entsize = 0;
 
+	tmp = realloc(build_id_data, build_id_data_len + symlen);
+	if (tmp == NULL) {
+		warnx("cannot allocate build-id data");
+		goto error;
+	}
+	memcpy(tmp + build_id_data_len, strsym, symlen);
+	build_id_data = tmp;
+	build_id_data_len += symlen;
+
 	/*
 	 * setup build-id section
 	 */
@@ -394,7 +422,7 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	/*
 	 * build-id generation
 	 */
-	sha1(code, csize, bnote.build_id);
+	sha1(build_id_data, build_id_data_len, bnote.build_id);
 	bnote.desc.namesz = sizeof(bnote.name); /* must include 0 termination */
 	bnote.desc.descsz = sizeof(bnote.build_id);
 	bnote.desc.type   = NT_GNU_BUILD_ID;
@@ -439,7 +467,7 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	(void)elf_end(e);
 
 	free(strsym);
-
+	free(build_id_data);
 
 	return retval;
 }
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 64ff427040c3..ef4b569f7df4 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -608,10 +608,8 @@ static int hist_entry__init(struct hist_entry *he,
 		map_symbol__exit(&he->branch_info->to.ms);
 		zfree(&he->branch_info);
 	}
-	if (he->mem_info) {
-		map_symbol__exit(&mem_info__iaddr(he->mem_info)->ms);
-		map_symbol__exit(&mem_info__daddr(he->mem_info)->ms);
-	}
+	if (he->mem_info)
+		mem_info__zput(he->mem_info);
 err:
 	map_symbol__exit(&he->ms);
 	zfree(&he->stat_acc);
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 416dfea9ffff..5c27256a220a 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -742,8 +742,7 @@ int perf_pmus__read_hwmon_pmus(struct list_head *pmus)
 			continue;
 		}
 		io__init(&io, name_fd, buf2, sizeof(buf2));
-		io__getline(&io, &line, &line_len);
-		if (line_len > 0 && line[line_len - 1] == '\n')
+		if (io__getline(&io, &line, &line_len) > 0 && line[line_len - 1] == '\n')
 			line[line_len - 1] = '\0';
 		hwmon_pmu__new(pmus, buf, class_hwmon_ent->d_name, line);
 		close(name_fd);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0026cff4d69e..fbf287363d9e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -475,8 +475,10 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *parsed_terms)
+			   struct parse_events_terms *parsed_terms,
+			   void *loc_)
 {
+	YYLTYPE *loc = loc_;
 	struct perf_pmu *pmu = NULL;
 	bool found_supported = false;
 	const char *config_name = get_config_name(parsed_terms);
@@ -497,12 +499,36 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			 * The PMU has the event so add as not a legacy cache
 			 * event.
 			 */
+			struct parse_events_terms temp_terms;
+			struct parse_events_term *term;
+			char *config = strdup(name);
+
+			if (!config)
+				goto out_err;
+
+			parse_events_terms__init(&temp_terms);
+			if (!parsed_terms)
+				parsed_terms = &temp_terms;
+
+			if (parse_events_term__num(&term,
+						    PARSE_EVENTS__TERM_TYPE_USER,
+						    config, /*num=*/1, /*novalue=*/true,
+						    loc, /*loc_val=*/NULL) < 0) {
+				zfree(&config);
+				goto out_err;
+			}
+			list_add(&term->list, &parsed_terms->terms);
+
 			ret = parse_events_add_pmu(parse_state, list, pmu,
 						   parsed_terms,
 						   first_wildcard_match,
 						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
+			list_del_init(&term->list);
+			parse_events_term__delete(term);
+			parse_events_terms__exit(&temp_terms);
 			if (ret)
 				goto out_err;
+			found_supported = true;
 			if (first_wildcard_match == NULL)
 				first_wildcard_match =
 					container_of(list->prev, struct evsel, core.node);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 62dc7202e3ba..c498d896badf 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -235,7 +235,8 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     bool wildcard);
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *parsed_terms);
+			   struct parse_events_terms *parsed_terms,
+			   void *loc);
 int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config);
 int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				struct list_head *list,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index a2361c0040d7..ced26c549c33 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -353,7 +353,7 @@ PE_LEGACY_CACHE opt_event_config
 	if (!list)
 		YYNOMEM;
 
-	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2);
+	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2, &@1);
 
 	parse_events_terms__delete($2);
 	free($1);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3fed54de5401..dfa8340eeaf8 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -955,11 +955,11 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			if (dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST)
 				snprintf(dso_name, sizeof(dso_name),
 					"[guest.kernel].%d",
-					kernel_range++);
+					kernel_range);
 			else
 				snprintf(dso_name, sizeof(dso_name),
 					"[kernel].%d",
-					kernel_range++);
+					kernel_range);
 
 			ndso = dso__new(dso_name);
 			map__zput(curr_map);
@@ -967,6 +967,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				return -1;
 
 			dso__set_kernel(ndso, dso__kernel(dso));
+			dso__set_loaded(ndso);
 
 			curr_map = map__new2(pos->start, ndso);
 			if (curr_map == NULL) {
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 931bad99277f..405b13b690ba 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3285,13 +3285,13 @@ int format_counters(PER_THREAD_PARAMS)
 
 	/* Added counters */
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
-		if (mp->format == FORMAT_RAW || mp->format == FORMAT_AVERAGE) {
+		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
 				outp +=
 				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int)t->counter[i]);
 			else
 				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), t->counter[i]);
-		} else if (mp->format == FORMAT_DELTA) {
+		} else if (mp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE) {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
 				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), t->counter[i]);
 			else
@@ -3382,13 +3382,13 @@ int format_counters(PER_THREAD_PARAMS)
 		outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), c->core_throt_cnt);
 
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
-		if (mp->format == FORMAT_RAW || mp->format == FORMAT_AVERAGE) {
+		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
 				outp +=
 				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int)c->counter[i]);
 			else
 				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), c->counter[i]);
-		} else if (mp->format == FORMAT_DELTA) {
+		} else if (mp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE) {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
 				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), c->counter[i]);
 			else
@@ -3581,7 +3581,7 @@ int format_counters(PER_THREAD_PARAMS)
 		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->uncore_mhz);
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
-		if (mp->format == FORMAT_RAW || mp->format == FORMAT_AVERAGE) {
+		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
 				outp +=
 				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int)p->counter[i]);
@@ -3758,7 +3758,7 @@ int delta_package(struct pkg_data *new, struct pkg_data *old)
 	    new->rapl_dram_perf_status.raw_value - old->rapl_dram_perf_status.raw_value;
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
-		if (mp->format == FORMAT_RAW || mp->format == FORMAT_AVERAGE)
+		if (mp->format == FORMAT_RAW)
 			old->counter[i] = new->counter[i];
 		else if (mp->format == FORMAT_AVERAGE)
 			old->counter[i] = new->counter[i];
diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
index 1de14b111931..6e35e13c2022 100644
--- a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
@@ -57,7 +57,8 @@ static void subtest_kmem_cache_iter_check_slabinfo(struct kmem_cache_iter *skel)
 		if (!ASSERT_OK(ret, "kmem_cache_lookup"))
 			break;
 
-		ASSERT_STREQ(r.name, name, "kmem_cache_name");
+		ASSERT_STRNEQ(r.name, name, sizeof(r.name) - 1,
+			      "kmem_cache_name");
 		ASSERT_EQ(r.obj_size, objsize, "kmem_cache_objsize");
 
 		seen++;
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
index bc24f83339d6..0a7ef770c487 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -15,6 +15,10 @@ static void check_good_sample(struct test_perf_branches *skel)
 	int pbe_size = sizeof(struct perf_branch_entry);
 	int duration = 0;
 
+	if (CHECK(!skel->bss->run_cnt, "invalid run_cnt",
+		  "checked sample validity before prog run"))
+		return;
+
 	if (CHECK(!skel->bss->valid, "output not valid",
 		 "no valid sample from prog"))
 		return;
@@ -45,6 +49,10 @@ static void check_bad_sample(struct test_perf_branches *skel)
 	int written_stack = skel->bss->written_stack_out;
 	int duration = 0;
 
+	if (CHECK(!skel->bss->run_cnt, "invalid run_cnt",
+		  "checked sample validity before prog run"))
+		return;
+
 	if (CHECK(!skel->bss->valid, "output not valid",
 		 "no valid sample from prog"))
 		return;
@@ -83,8 +91,12 @@ static void test_perf_branches_common(int perf_fd,
 	err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
 	if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
 		goto out_destroy;
-	/* spin the loop for a while (random high number) */
-	for (i = 0; i < 1000000; ++i)
+
+	/* Spin the loop for a while by using a high iteration count, and by
+	 * checking whether the specific run count marker has been explicitly
+	 * incremented at least once by the backing perf_event BPF program.
+	 */
+	for (i = 0; i < 100000000 && !*(volatile int *)&skel->bss->run_cnt; ++i)
 		++j;
 
 	test_perf_branches__detach(skel);
@@ -116,11 +128,11 @@ static void test_perf_branches_hw(void)
 	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
 
 	/*
-	 * Some setups don't support branch records (virtual machines, !x86),
-	 * so skip test in this case.
+	 * Some setups don't support LBR (virtual machines, !x86, AMD Milan Zen
+	 * 3 which only supports BRS), so skip test in this case.
 	 */
 	if (pfd < 0) {
-		if (errno == ENOENT || errno == EOPNOTSUPP) {
+		if (errno == ENOENT || errno == EOPNOTSUPP || errno == EINVAL) {
 			printf("%s:SKIP:no PERF_SAMPLE_BRANCH_STACK\n",
 			       __func__);
 			test__skip();
diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 1702aa592c2c..7ac4d5a488aa 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -206,6 +206,11 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 skel_open_load_failure:
 	close(pipe_c2p[0]);
 	close(pipe_p2c[1]);
+	/*
+	 * Child is either about to exit cleanly or stuck in case of errors.
+	 * Nudge it to exit.
+	 */
+	kill(pid, SIGKILL);
 	wait(NULL);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_perf_branches.c b/tools/testing/selftests/bpf/progs/test_perf_branches.c
index a1ccc831c882..05ac9410cd68 100644
--- a/tools/testing/selftests/bpf/progs/test_perf_branches.c
+++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c
@@ -8,6 +8,7 @@
 #include <bpf/bpf_tracing.h>
 
 int valid = 0;
+int run_cnt = 0;
 int required_size_out = 0;
 int written_stack_out = 0;
 int written_global_out = 0;
@@ -24,6 +25,8 @@ int perf_branches(void *ctx)
 	__u64 entries[4 * 3] = {0};
 	int required_size, written_stack, written_global;
 
+	++run_cnt;
+
 	/* write to stack */
 	written_stack = bpf_read_branch_records(ctx, entries, sizeof(entries), 0);
 	/* ignore spurious events */
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
index c4711272fe45..559f300f965a 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
@@ -30,6 +30,7 @@ check_connection()
 	local message=${3}
 	RET=0
 
+	sleep 0.25
 	ip netns exec ${ns} ping ${target} -c 4 -i 0.1 &>/dev/null
 	check_err $? "ping failed"
 	log_test "${bond_mode}/${xvlan_type}_${xvlan_mode}: ${message}"
diff --git a/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt b/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt
index b2b2cdf27e20..454441e7ecff 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 // Test that we correctly skip zero-length IOVs.
+
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
+
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
    +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
index a82c8899d36b..0a0700afdaa3 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
@@ -4,6 +4,8 @@
 // send a packet with MSG_ZEROCOPY and receive the notification ID
 // repeat and verify IDs are consecutive
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
index c01915e7f4a1..df91675d2991 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
@@ -3,6 +3,8 @@
 //
 // send multiple packets, then read one range of all notifications.
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
index 6509882932e9..2963cfcb14df 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Minimal client-side zerocopy test
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
index 2cd78755cb2a..ea0c2fa73c2d 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
@@ -7,6 +7,8 @@
 // First send on a closed socket and wait for (absent) notification.
 // Then connect and send and verify that notification nr. is zero.
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
index 7671c20e01cf..4df978a9b82e 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
@@ -7,6 +7,9 @@
 // fire two sends with MSG_ZEROCOPY and receive the acks. confirm that EPOLLERR
 // is correctly fired only once, when EPOLLET is set. send another packet with
 // MSG_ZEROCOPY. confirm that EPOLLERR is correctly fired again only once.
+
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
index fadc480fdb7f..36b6edc4858c 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
@@ -8,6 +8,9 @@
 // fire two sends with MSG_ZEROCOPY and receive the acks. confirm that EPOLLERR
 // is correctly fired only once, when EPOLLET is set. send another packet with
 // MSG_ZEROCOPY. confirm that EPOLLERR is correctly fired again only once.
+
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
index 5bfa0d1d2f4a..1bea6f3b4558 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
@@ -8,6 +8,9 @@
 // is correctly fired only once, when EPOLLONESHOT is set. send another packet
 // with MSG_ZEROCOPY. confirm that EPOLLERR is not fired. Rearm the FD and
 // confirm that EPOLLERR is correctly set.
+
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
index 4a73bbf46961..e27c21ff5d18 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
@@ -8,6 +8,8 @@
 // one will have no data in the initial send. On return 0 the
 // zerocopy notification counter is not incremented. Verify this too.
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
 // Send a FastOpen request, no cookie yet so no data in SYN
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
index 36086c5877ce..b1fa77c77dfa 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
@@ -4,6 +4,8 @@
 // send data with MSG_FASTOPEN | MSG_ZEROCOPY and verify that the
 // kernel returns the notification ID.
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh
  ./set_sysctls.py /proc/sys/net/ipv4/tcp_fastopen=0x207`
 
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
index 672f817faca0..2f5317d0a9fa 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
@@ -7,6 +7,8 @@
 //    because each iovec element becomes a frag
 // 3) the PSH bit is set on an skb when it runs out of fragments
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt
index a9a1ac0aea4f..9d5272c6b207 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt
@@ -4,6 +4,8 @@
 // verify that SO_EE_CODE_ZEROCOPY_COPIED is set on zerocopy
 // packets of all sizes, including the smallest payload, 1B.
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3

