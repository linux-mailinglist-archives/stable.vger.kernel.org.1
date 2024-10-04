Return-Path: <stable+bounces-80758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A1C99069E
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 16:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5094E1F223A5
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE84821BAF9;
	Fri,  4 Oct 2024 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RgUdJiRA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176892194BE;
	Fri,  4 Oct 2024 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053123; cv=none; b=SwkJoIAM0i6+fCLP07uD0jfg2qKQQ///HWuQLb2kw84Nb8hIcW/OdjRTJvuq16CDJDPxawfojki6mlvIeKlhHMK1wVTsZKVqWuM8+bymlRPUA65y3RrsQ584aMKZACOEqr0fy3YsIAJJGnjh83AmazLRir1FZGkze4ECAY8L2eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053123; c=relaxed/simple;
	bh=1RAcxLloQS3uVPk1qr4AHfUUMJyhw9Q2Ee6ViPxtQOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opohBFVXDUjCYsRjwmOF1dO+OpklgyZGAOuzGgeOlFQI0BYy9ANwJgKIZVexskblGcRuP/iMGFYC8U62eSOfRKYaF+f604anJbtnk6XFidTUgLPEzs3zpSZ/C4o/Z9P9RE5oTtOzCYK1U3v68ktjlGdcAYWCwGjwTyJA1WkXd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RgUdJiRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC97C4CEC6;
	Fri,  4 Oct 2024 14:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728053123;
	bh=1RAcxLloQS3uVPk1qr4AHfUUMJyhw9Q2Ee6ViPxtQOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RgUdJiRAXk9i7h9+UkcWFLa23DyKGnDJBeWN/eH1JDR2rPsFmT+ZtVe8kSeWN4ibn
	 g4s0K0ZbUvLbsNOIoSi6PLwA6oM+qeevu3CvFm9hKYcQ4ZOYEbj9VNOxzfuOlOCGl0
	 e7TTQGiOLy7iKwhUSix74cfl3gFlD8i7S/1EI6+E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.10.13
Date: Fri,  4 Oct 2024 16:45:06 +0200
Message-ID: <2024100406-embargo-broadways-5b4d@gregkh>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <2024100405-crazed-sage-a609@gregkh>
References: <2024100405-crazed-sage-a609@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/.gitignore b/.gitignore
index c59dc60ba62e..7acc74c54ded 100644
--- a/.gitignore
+++ b/.gitignore
@@ -136,7 +136,6 @@ GTAGS
 # id-utils files
 ID
 
-*.orig
 *~
 \#*#
 
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818 b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
index 31dbb390573f..c431f0a13cf5 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
+++ b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
@@ -3,7 +3,7 @@ KernelVersion:
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Reading this returns the valid values that can be written to the
-		on_altvoltage0_mode attribute:
+		filter_mode attribute:
 
 		- auto -> Adjust bandpass filter to track changes in input clock rate.
 		- manual -> disable/unregister the clock rate notifier / input clock tracking.
diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 50327c05be8d..39c52385f11f 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -55,6 +55,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Ampere         | AmpereOne       | AC03_CPU_38     | AMPERE_ERRATUM_AC03_CPU_38  |
 +----------------+-----------------+-----------------+-----------------------------+
+| Ampere         | AmpereOne AC04  | AC04_CPU_10     | AMPERE_ERRATUM_AC03_CPU_38  |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
index 9790f75fc669..fe5145d3b73c 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
@@ -23,7 +23,6 @@ properties:
           - ak8963
           - ak09911
           - ak09912
-          - ak09916
         deprecated: true
 
   reg:
diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
index 793986c5af7f..daeab5c0758d 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -22,18 +22,20 @@ description:
 
 properties:
   compatible:
-    enum:
-      - fsl,ls1021a-pcie
-      - fsl,ls2080a-pcie
-      - fsl,ls2085a-pcie
-      - fsl,ls2088a-pcie
-      - fsl,ls1088a-pcie
-      - fsl,ls1046a-pcie
-      - fsl,ls1043a-pcie
-      - fsl,ls1012a-pcie
-      - fsl,ls1028a-pcie
-      - fsl,lx2160a-pcie
-
+    oneOf:
+      - enum:
+          - fsl,ls1012a-pcie
+          - fsl,ls1021a-pcie
+          - fsl,ls1028a-pcie
+          - fsl,ls1043a-pcie
+          - fsl,ls1046a-pcie
+          - fsl,ls1088a-pcie
+          - fsl,ls2080a-pcie
+          - fsl,ls2085a-pcie
+          - fsl,ls2088a-pcie
+      - items:
+          - const: fsl,lx2160ar2-pcie
+          - const: fsl,ls2088a-pcie
   reg:
     maxItems: 2
 
diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
index 4a5f41bde00f..902db92da832 100644
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
@@ -21,6 +21,7 @@ properties:
           - nxp,imx8mm-fspi
           - nxp,imx8mp-fspi
           - nxp,imx8qxp-fspi
+          - nxp,imx8ulp-fspi
           - nxp,lx2160a-fspi
       - items:
           - enum:
diff --git a/Documentation/driver-api/ipmi.rst b/Documentation/driver-api/ipmi.rst
index e224e47b6b09..dfa021eacd63 100644
--- a/Documentation/driver-api/ipmi.rst
+++ b/Documentation/driver-api/ipmi.rst
@@ -540,7 +540,7 @@ at module load time (for a module) with::
 	alerts_broken
 
 The addresses are normal I2C addresses.  The adapter is the string
-name of the adapter, as shown in /sys/class/i2c-adapter/i2c-<n>/name.
+name of the adapter, as shown in /sys/bus/i2c/devices/i2c-<n>/name.
 It is *NOT* i2c-<n> itself.  Also, the comparison is done ignoring
 spaces, so if the name is "This is an I2C chip" you can say
 adapter_name=ThisisanI2cchip.  This is because it's hard to pass in
diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index 9aaf6ef75eb5..317934c9e8fc 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -645,6 +645,8 @@ The members are as follows:
 	fs_param_is_blockdev	Blockdev path		* Needs lookup
 	fs_param_is_path	Path			* Needs lookup
 	fs_param_is_fd		File descriptor		result->int_32
+	fs_param_is_uid		User ID (u32)           result->uid
+	fs_param_is_gid		Group ID (u32)          result->gid
 	=======================	=======================	=====================
 
      Note that if the value is of fs_param_is_bool type, fs_parse() will try
@@ -678,6 +680,8 @@ The members are as follows:
 	fsparam_bdev()		fs_param_is_blockdev
 	fsparam_path()		fs_param_is_path
 	fsparam_fd()		fs_param_is_fd
+	fsparam_uid()		fs_param_is_uid
+	fsparam_gid()		fs_param_is_gid
 	=======================	===============================================
 
      all of which take two arguments, name string and option number - for
@@ -784,8 +788,9 @@ process the parameters it is given.
      option number (which it returns).
 
      If successful, and if the parameter type indicates the result is a
-     boolean, integer or enum type, the value is converted by this function and
-     the result stored in result->{boolean,int_32,uint_32,uint_64}.
+     boolean, integer, enum, uid, or gid type, the value is converted by this
+     function and the result stored in
+     result->{boolean,int_32,uint_32,uint_64,uid,gid}.
 
      If a match isn't initially made, the key is prefixed with "no" and no
      value is present then an attempt will be made to look up the key with the
diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
index 02880d5552d5..198a5a8f26c2 100644
--- a/Documentation/virt/kvm/locking.rst
+++ b/Documentation/virt/kvm/locking.rst
@@ -9,7 +9,7 @@ KVM Lock Overview
 
 The acquisition orders for mutexes are as follows:
 
-- cpus_read_lock() is taken outside kvm_lock
+- cpus_read_lock() is taken outside kvm_lock and kvm_usage_lock
 
 - kvm->lock is taken outside vcpu->mutex
 
@@ -24,6 +24,13 @@ The acquisition orders for mutexes are as follows:
   are taken on the waiting side when modifying memslots, so MMU notifiers
   must not take either kvm->slots_lock or kvm->slots_arch_lock.
 
+cpus_read_lock() vs kvm_lock:
+
+- Taking cpus_read_lock() outside of kvm_lock is problematic, despite that
+  being the official ordering, as it is quite easy to unknowingly trigger
+  cpus_read_lock() while holding kvm_lock.  Use caution when walking vm_list,
+  e.g. avoid complex operations when possible.
+
 For SRCU:
 
 - ``synchronize_srcu(&kvm->srcu)`` is called inside critical sections
@@ -227,10 +234,17 @@ time it will be set using the Dirty tracking mechanism described above.
 :Type:		mutex
 :Arch:		any
 :Protects:	- vm_list
-		- kvm_usage_count
+
+``kvm_usage_lock``
+^^^^^^^^^^^^^^^^^^
+
+:Type:		mutex
+:Arch:		any
+:Protects:	- kvm_usage_count
 		- hardware virtualization enable/disable
-:Comment:	KVM also disables CPU hotplug via cpus_read_lock() during
-		enable/disable.
+:Comment:	Exists because using kvm_lock leads to deadlock (see earlier comment
+		on cpus_read_lock() vs kvm_lock).  Note, KVM also disables CPU hotplug via
+		cpus_read_lock() when enabling/disabling virtualization.
 
 ``kvm->mn_invalidate_lock``
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -290,11 +304,12 @@ time it will be set using the Dirty tracking mechanism described above.
 		wakeup.
 
 ``vendor_module_lock``
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+^^^^^^^^^^^^^^^^^^^^^^
 :Type:		mutex
 :Arch:		x86
 :Protects:	loading a vendor module (kvm_amd or kvm_intel)
-:Comment:	Exists because using kvm_lock leads to deadlock.  cpu_hotplug_lock is
-    taken outside of kvm_lock, e.g. in KVM's CPU online/offline callbacks, and
-    many operations need to take cpu_hotplug_lock when loading a vendor module,
-    e.g. updating static calls.
+:Comment:	Exists because using kvm_lock leads to deadlock.  kvm_lock is taken
+    in notifiers, e.g. __kvmclock_cpufreq_notifier(), that may be invoked while
+    cpu_hotplug_lock is held, e.g. from cpufreq_boost_trigger_state(), and many
+    operations need to take cpu_hotplug_lock when loading a vendor module, e.g.
+    updating static calls.
diff --git a/Makefile b/Makefile
index 175d7f27ea32..93731d0b1a04 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 10
-SUBLEVEL = 12
+SUBLEVEL = 13
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index 291540e5d81e..d077afd5024d 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -1312,7 +1312,7 @@ rtt: rtc@fffffe20 {
 				compatible = "microchip,sam9x60-rtt", "atmel,at91sam9260-rtt";
 				reg = <0xfffffe20 0x20>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&clk32k 0>;
+				clocks = <&clk32k 1>;
 			};
 
 			pit: timer@fffffe40 {
@@ -1338,7 +1338,7 @@ rtc: rtc@fffffea8 {
 				compatible = "microchip,sam9x60-rtc", "atmel,at91sam9x5-rtc";
 				reg = <0xfffffea8 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&clk32k 0>;
+				clocks = <&clk32k 1>;
 			};
 
 			watchdog: watchdog@ffffff80 {
diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
index 75778be126a3..17bcdcf0cf4a 100644
--- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
@@ -272,7 +272,7 @@ rtt: rtc@e001d020 {
 			compatible = "microchip,sama7g5-rtt", "microchip,sam9x60-rtt", "atmel,at91sam9260-rtt";
 			reg = <0xe001d020 0x30>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk32k 0>;
+			clocks = <&clk32k 1>;
 		};
 
 		clk32k: clock-controller@e001d050 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
index cdbb8c435cd6..601d89b904cd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
@@ -365,7 +365,7 @@ MX6UL_PAD_ENET1_RX_ER__PWM8_OUT   0x110b0
 	};
 
 	pinctrl_tsc: tscgrp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
 			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
 			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
index 6bb12e0bbc7e..50654dbf62e0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
@@ -339,14 +339,14 @@ MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x120b0
 	};
 
 	pinctrl_uart1: uart1grp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
 			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
 			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
 			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
@@ -355,7 +355,7 @@ MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
 	};
 
 	pinctrl_uart3: uart3grp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
 			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
 			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b0b1
@@ -364,21 +364,21 @@ MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
 	};
 
 	pinctrl_uart4: uart4grp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_UART4_TX_DATA__UART4_DCE_TX	0x1b0b1
 			MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x1b0b1
 		>;
 	};
 
 	pinctrl_uart5: uart5grp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_UART5_TX_DATA__UART5_DCE_TX	0x1b0b1
 			MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX	0x1b0b1
 		>;
 	};
 
 	pinctrl_usb_otg1_id: usbotg1idgrp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO00__ANATOP_OTG1_ID	0x17059
 		>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts b/arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts
index 521493342fe9..8f5566027c25 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts
@@ -350,7 +350,7 @@ MX7D_PAD_SD3_RESET_B__SD3_RESET_B	0x59
 
 &iomuxc_lpsr {
 	pinctrl_enet1_phy_interrupt: enet1phyinterruptgrp {
-		fsl,phy = <
+		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2	0x08
 		>;
 	};
diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 85a496ddc619..e9f72a529b50 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -359,7 +359,7 @@ static unsigned long ep93xx_div_recalc_rate(struct clk_hw *hw,
 	u32 val = __raw_readl(psc->reg);
 	u8 index = (val & psc->mask) >> psc->shift;
 
-	if (index > psc->num_div)
+	if (index >= psc->num_div)
 		return 0;
 
 	return DIV_ROUND_UP_ULL(parent_rate, psc->div[index]);
diff --git a/arch/arm/mach-versatile/platsmp-realview.c b/arch/arm/mach-versatile/platsmp-realview.c
index 6965a1de727b..d38b2e174257 100644
--- a/arch/arm/mach-versatile/platsmp-realview.c
+++ b/arch/arm/mach-versatile/platsmp-realview.c
@@ -70,6 +70,7 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
 		return;
 	}
 	map = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (IS_ERR(map)) {
 		pr_err("PLATSMP: No syscon regmap\n");
 		return;
diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
index 3c7938fd40aa..32090b0fb250 100644
--- a/arch/arm/vfp/vfpinstr.h
+++ b/arch/arm/vfp/vfpinstr.h
@@ -64,33 +64,37 @@
 
 #ifdef CONFIG_AS_VFP_VMRS_FPINST
 
-#define fmrx(_vfp_) ({			\
-	u32 __v;			\
-	asm(".fpu	vfpv2\n"	\
-	    "vmrs	%0, " #_vfp_	\
-	    : "=r" (__v) : : "cc");	\
-	__v;				\
- })
-
-#define fmxr(_vfp_,_var_)		\
-	asm(".fpu	vfpv2\n"	\
-	    "vmsr	" #_vfp_ ", %0"	\
-	   : : "r" (_var_) : "cc")
+#define fmrx(_vfp_) ({				\
+	u32 __v;				\
+	asm volatile (".fpu	vfpv2\n"	\
+		      "vmrs	%0, " #_vfp_	\
+		     : "=r" (__v) : : "cc");	\
+	__v;					\
+})
+
+#define fmxr(_vfp_, _var_) ({			\
+	asm volatile (".fpu	vfpv2\n"	\
+		      "vmsr	" #_vfp_ ", %0"	\
+		     : : "r" (_var_) : "cc");	\
+})
 
 #else
 
 #define vfpreg(_vfp_) #_vfp_
 
-#define fmrx(_vfp_) ({			\
-	u32 __v;			\
-	asm("mrc p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmrx	%0, " #_vfp_	\
-	    : "=r" (__v) : : "cc");	\
-	__v;				\
- })
-
-#define fmxr(_vfp_,_var_)		\
-	asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr	" #_vfp_ ", %0"	\
-	   : : "r" (_var_) : "cc")
+#define fmrx(_vfp_) ({						\
+	u32 __v;						\
+	asm volatile ("mrc p10, 7, %0, " vfpreg(_vfp_) ","	\
+		      "cr0, 0 @ fmrx	%0, " #_vfp_		\
+		     : "=r" (__v) : : "cc");			\
+	__v;							\
+})
+
+#define fmxr(_vfp_, _var_) ({					\
+	asm volatile ("mcr p10, 7, %0, " vfpreg(_vfp_) ","	\
+		      "cr0, 0 @ fmxr	" #_vfp_ ", %0"		\
+		     : : "r" (_var_) : "cc");			\
+})
 
 #endif
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 11bbdc15c6e5..cd9772b1fd95 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -422,7 +422,7 @@ config AMPERE_ERRATUM_AC03_CPU_38
 	default y
 	help
 	  This option adds an alternative code sequence to work around Ampere
-	  erratum AC03_CPU_38 on AmpereOne.
+	  errata AC03_CPU_38 and AC04_CPU_10 on AmpereOne.
 
 	  The affected design reports FEAT_HAFDBS as not implemented in
 	  ID_AA64MMFR1_EL1.HAFDBS, but (V)TCR_ELx.{HA,HD} are not RES0
diff --git a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
index 47a389d9ff7d..9d74fa6bfed9 100644
--- a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
@@ -32,7 +32,7 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x3da00000>,
 		      <0x0 0xc0000000 0x40000000>,
-		      <0x8 0x80000000 0x40000000>;
+		      <0x8 0x80000000 0x80000000>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index 1807e9d6cb0e..0a4838b35eab 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -321,7 +321,8 @@ &dpi {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&dpi_pins_default>;
 	pinctrl-1 = <&dpi_pins_sleep>;
-	status = "okay";
+	/* TODO Re-enable after DP to Type-C port muxing can be described */
+	status = "disabled";
 };
 
 &dpi_out {
diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 4763ed5dc86c..d63a9defe73e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -731,7 +731,7 @@ opp-850000000 {
 		opp-900000000-3 {
 			opp-hz = /bits/ 64 <900000000>;
 			opp-microvolt = <850000>;
-			opp-supported-hw = <0x8>;
+			opp-supported-hw = <0xcf>;
 		};
 
 		opp-900000000-4 {
@@ -743,13 +743,13 @@ opp-900000000-4 {
 		opp-900000000-5 {
 			opp-hz = /bits/ 64 <900000000>;
 			opp-microvolt = <825000>;
-			opp-supported-hw = <0x30>;
+			opp-supported-hw = <0x20>;
 		};
 
 		opp-950000000-3 {
 			opp-hz = /bits/ 64 <950000000>;
 			opp-microvolt = <900000>;
-			opp-supported-hw = <0x8>;
+			opp-supported-hw = <0xcf>;
 		};
 
 		opp-950000000-4 {
@@ -761,13 +761,13 @@ opp-950000000-4 {
 		opp-950000000-5 {
 			opp-hz = /bits/ 64 <950000000>;
 			opp-microvolt = <850000>;
-			opp-supported-hw = <0x30>;
+			opp-supported-hw = <0x20>;
 		};
 
 		opp-1000000000-3 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <950000>;
-			opp-supported-hw = <0x8>;
+			opp-supported-hw = <0xcf>;
 		};
 
 		opp-1000000000-4 {
@@ -779,7 +779,7 @@ opp-1000000000-4 {
 		opp-1000000000-5 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <875000>;
-			opp-supported-hw = <0x30>;
+			opp-supported-hw = <0x20>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 4a11918da370..5a2d65edf474 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1359,6 +1359,7 @@ &xhci1 {
 	rx-fifo-depth = <3072>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&usb_vbus>;
+	mediatek,u3p-dis-msk = <1>;
 };
 
 &xhci2 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 2ee45752583c..98c15eb68589 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -3251,10 +3251,10 @@ dp_intf0: dp-intf@1c015000 {
 			compatible = "mediatek,mt8195-dp-intf";
 			reg = <0 0x1c015000 0 0x1000>;
 			interrupts = <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&vdosys0  CLK_VDO0_DP_INTF0>,
-				 <&vdosys0 CLK_VDO0_DP_INTF0_DP_INTF>,
+			clocks = <&vdosys0 CLK_VDO0_DP_INTF0_DP_INTF>,
+				 <&vdosys0  CLK_VDO0_DP_INTF0>,
 				 <&apmixedsys CLK_APMIXED_TVDPLL1>;
-			clock-names = "engine", "pixel", "pll";
+			clock-names = "pixel", "engine", "pll";
 			status = "disabled";
 		};
 
@@ -3521,10 +3521,10 @@ dp_intf1: dp-intf@1c113000 {
 			reg = <0 0x1c113000 0 0x1000>;
 			interrupts = <GIC_SPI 513 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
-			clocks = <&vdosys1 CLK_VDO1_DP_INTF0_MM>,
-				 <&vdosys1 CLK_VDO1_DPINTF>,
+			clocks = <&vdosys1 CLK_VDO1_DPINTF>,
+				 <&vdosys1 CLK_VDO1_DP_INTF0_MM>,
 				 <&apmixedsys CLK_APMIXED_TVDPLL2>;
-			clock-names = "engine", "pixel", "pll";
+			clock-names = "pixel", "engine", "pll";
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 97634cc04e65..e2634590ca81 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -816,6 +816,7 @@ &xhci1 {
 	usb2-lpm-disable;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&vsys>;
+	mediatek,u3p-dis-msk = <1>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0008.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0008.dtsi
index 553fa4ba1cd4..62c4fdad0b60 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0008.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0008.dtsi
@@ -44,39 +44,6 @@ i2c@c240000 {
 			status = "okay";
 		};
 
-		i2c@c250000 {
-			power-sensor@41 {
-				compatible = "ti,ina3221";
-				reg = <0x41>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				input@0 {
-					reg = <0x0>;
-					label = "CVB_ATX_12V";
-					shunt-resistor-micro-ohms = <2000>;
-				};
-
-				input@1 {
-					reg = <0x1>;
-					label = "CVB_ATX_3V3";
-					shunt-resistor-micro-ohms = <2000>;
-				};
-
-				input@2 {
-					reg = <0x2>;
-					label = "CVB_ATX_5V";
-					shunt-resistor-micro-ohms = <2000>;
-				};
-			};
-
-			power-sensor@44 {
-				compatible = "ti,ina219";
-				reg = <0x44>;
-				shunt-resistor = <2000>;
-			};
-		};
-
 		rtc@c2a0000 {
 			status = "okay";
 		};
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002.dtsi
index 527f2f3aee3a..377f518bd3e5 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002.dtsi
@@ -183,6 +183,39 @@ usb@3610000 {
 			phy-names = "usb2-0", "usb2-1", "usb2-2", "usb2-3",
 				"usb3-0", "usb3-1", "usb3-2";
 		};
+
+		i2c@c250000 {
+			power-sensor@41 {
+				compatible = "ti,ina3221";
+				reg = <0x41>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				input@0 {
+					reg = <0x0>;
+					label = "CVB_ATX_12V";
+					shunt-resistor-micro-ohms = <2000>;
+				};
+
+				input@1 {
+					reg = <0x1>;
+					label = "CVB_ATX_3V3";
+					shunt-resistor-micro-ohms = <2000>;
+				};
+
+				input@2 {
+					reg = <0x2>;
+					label = "CVB_ATX_5V";
+					shunt-resistor-micro-ohms = <2000>;
+				};
+			};
+
+			power-sensor@44 {
+				compatible = "ti,ina219";
+				reg = <0x44>;
+				shunt-resistor = <2000>;
+			};
+		};
 	};
 
 	vdd_3v3_dp: regulator-vdd-3v3-dp {
diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 490e0369f529..3a51e79af1bb 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2104,6 +2104,7 @@ apps_smmu: iommu@15000000 {
 			reg = <0x0 0x15000000 0x0 0x100000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
+			dma-coherent;
 
 			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
@@ -2242,6 +2243,7 @@ pcie_smmu: iommu@15200000 {
 			reg = <0x0 0x15200000 0x0 0x80000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
+			dma-coherent;
 
 			interrupts = <GIC_SPI 920 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 921 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 36c398e5fe50..64d5f6e4c0b0 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3998,14 +3998,14 @@ mdss_dp2: displayport-controller@ae9a000 {
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX2_LINK_CLK_SRC>,
 						  <&dispcc DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>;
-				assigned-clock-parents = <&mdss_dp2_phy 0>,
-							 <&mdss_dp2_phy 1>;
+				assigned-clock-parents = <&usb_1_ss2_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_1_ss2_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
 				operating-points-v2 = <&mdss_dp2_opp_table>;
 
 				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
-				phys = <&mdss_dp2_phy>;
+				phys = <&usb_1_ss2_qmpphy QMP_USB43DP_DP_PHY>;
 				phy-names = "dp";
 
 				#sound-dai-cells = <0>;
@@ -4189,8 +4189,8 @@ dispcc: clock-controller@af00000 {
 				 <&usb_1_ss0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 				 <&usb_1_ss1_qmpphy QMP_USB43DP_DP_LINK_CLK>, /* dp1 */
 				 <&usb_1_ss1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
-				 <&mdss_dp2_phy 0>, /* dp2 */
-				 <&mdss_dp2_phy 1>,
+				 <&usb_1_ss2_qmpphy QMP_USB43DP_DP_LINK_CLK>, /* dp2 */
+				 <&usb_1_ss2_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 				 <&mdss_dp3_phy 0>, /* dp3 */
 				 <&mdss_dp3_phy 1>;
 			power-domains = <&rpmhpd RPMHPD_MMCX>;
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 18ef297db933..20fb5e41c598 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -210,8 +210,8 @@ gic: interrupt-controller@11900000 {
 		#interrupt-cells = <3>;
 		#address-cells = <0>;
 		interrupt-controller;
-		reg = <0x0 0x11900000 0 0x40000>,
-		      <0x0 0x11940000 0 0x60000>;
+		reg = <0x0 0x11900000 0 0x20000>,
+		      <0x0 0x11940000 0 0x40000>;
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 1a9891ba6c02..960537e401f4 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -1043,8 +1043,8 @@ gic: interrupt-controller@11900000 {
 			#interrupt-cells = <3>;
 			#address-cells = <0>;
 			interrupt-controller;
-			reg = <0x0 0x11900000 0 0x40000>,
-			      <0x0 0x11940000 0 0x60000>;
+			reg = <0x0 0x11900000 0 0x20000>,
+			      <0x0 0x11940000 0 0x40000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
 
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index a2318478a66b..66894b676c01 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -1051,8 +1051,8 @@ gic: interrupt-controller@11900000 {
 			#interrupt-cells = <3>;
 			#address-cells = <0>;
 			interrupt-controller;
-			reg = <0x0 0x11900000 0 0x40000>,
-			      <0x0 0x11940000 0 0x60000>;
+			reg = <0x0 0x11900000 0 0x20000>,
+			      <0x0 0x11940000 0 0x40000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
 
diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index a2adc4e27ce9..17609d81af29 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -269,8 +269,8 @@ gic: interrupt-controller@12400000 {
 			#interrupt-cells = <3>;
 			#address-cells = <0>;
 			interrupt-controller;
-			reg = <0x0 0x12400000 0 0x40000>,
-			      <0x0 0x12440000 0 0x60000>;
+			reg = <0x0 0x12400000 0 0x20000>,
+			      <0x0 0x12440000 0 0x40000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 294eb2de263d..f5e124b235c8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -32,12 +32,12 @@ chosen {
 	backlight: edp-backlight {
 		compatible = "pwm-backlight";
 		power-supply = <&vcc_12v>;
-		pwms = <&pwm0 0 740740 0>;
+		pwms = <&pwm0 0 125000 0>;
 	};
 
 	bat: battery {
 		compatible = "simple-battery";
-		charge-full-design-microamp-hours = <9800000>;
+		charge-full-design-microamp-hours = <10000000>;
 		voltage-max-design-microvolt = <4350000>;
 		voltage-min-design-microvolt = <3000000>;
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index a337f547caf5..6a02db4f073f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "Hardkernel ODROID-M1";
-	compatible = "rockchip,rk3568-odroid-m1", "rockchip,rk3568";
+	compatible = "hardkernel,odroid-m1", "rockchip,rk3568";
 
 	aliases {
 		ethernet0 = &gmac0;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
index 8bdb87fcbde0..1674ad564be1 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
@@ -58,9 +58,7 @@ icssg0_eth: icssg0-eth {
 		       <&main_udmap 0xc107>, /* egress slice 1 */
 
 		       <&main_udmap 0x4100>, /* ingress slice 0 */
-		       <&main_udmap 0x4101>, /* ingress slice 1 */
-		       <&main_udmap 0x4102>, /* mgmnt rsp slice 0 */
-		       <&main_udmap 0x4103>; /* mgmnt rsp slice 1 */
+		       <&main_udmap 0x4101>; /* ingress slice 1 */
 		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
 			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
 			    "rx0", "rx1";
@@ -126,9 +124,7 @@ icssg1_eth: icssg1-eth {
 		       <&main_udmap 0xc207>, /* egress slice 1 */
 
 		       <&main_udmap 0x4200>, /* ingress slice 0 */
-		       <&main_udmap 0x4201>, /* ingress slice 1 */
-		       <&main_udmap 0x4202>, /* mgmnt rsp slice 0 */
-		       <&main_udmap 0x4203>; /* mgmnt rsp slice 1 */
+		       <&main_udmap 0x4201>; /* ingress slice 1 */
 		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
 			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
 			    "rx0", "rx1";
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index a2925555fe81..fb899c99753e 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -123,7 +123,7 @@ main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
 			no-map;
 		};
 
-		c66_1_dma_memory_region: c66-dma-memory@a6000000 {
+		c66_0_dma_memory_region: c66-dma-memory@a6000000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0xa6000000 0x00 0x100000>;
 			no-map;
@@ -135,7 +135,7 @@ c66_0_memory_region: c66-memory@a6100000 {
 			no-map;
 		};
 
-		c66_0_dma_memory_region: c66-dma-memory@a7000000 {
+		c66_1_dma_memory_region: c66-dma-memory@a7000000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0xa7000000 0x00 0x100000>;
 			no-map;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 0c4575ad8d7c..53156b71e479 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -119,7 +119,7 @@ main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
 			no-map;
 		};
 
-		c66_1_dma_memory_region: c66-dma-memory@a6000000 {
+		c66_0_dma_memory_region: c66-dma-memory@a6000000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0xa6000000 0x00 0x100000>;
 			no-map;
@@ -131,7 +131,7 @@ c66_0_memory_region: c66-memory@a6100000 {
 			no-map;
 		};
 
-		c66_0_dma_memory_region: c66-dma-memory@a7000000 {
+		c66_1_dma_memory_region: c66-dma-memory@a7000000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0xa7000000 0x00 0x100000>;
 			no-map;
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 5fd7caea4419..5a7dfeb8e8eb 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -143,6 +143,7 @@
 #define APPLE_CPU_PART_M2_AVALANCHE_MAX	0x039
 
 #define AMPERE_CPU_PART_AMPERE1		0xAC3
+#define AMPERE_CPU_PART_AMPERE1A	0xAC4
 
 #define MICROSOFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
 
@@ -212,6 +213,7 @@
 #define MIDR_APPLE_M2_BLIZZARD_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_MAX)
 #define MIDR_APPLE_M2_AVALANCHE_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_MAX)
 #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
+#define MIDR_AMPERE1A MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1A)
 #define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MICROSOFT_CPU_PART_AZURE_COBALT_100)
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 7abf09df7033..60f4320e44e5 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -10,63 +10,63 @@
 #include <asm/memory.h>
 #include <asm/sysreg.h>
 
-#define ESR_ELx_EC_UNKNOWN	(0x00)
-#define ESR_ELx_EC_WFx		(0x01)
+#define ESR_ELx_EC_UNKNOWN	UL(0x00)
+#define ESR_ELx_EC_WFx		UL(0x01)
 /* Unallocated EC: 0x02 */
-#define ESR_ELx_EC_CP15_32	(0x03)
-#define ESR_ELx_EC_CP15_64	(0x04)
-#define ESR_ELx_EC_CP14_MR	(0x05)
-#define ESR_ELx_EC_CP14_LS	(0x06)
-#define ESR_ELx_EC_FP_ASIMD	(0x07)
-#define ESR_ELx_EC_CP10_ID	(0x08)	/* EL2 only */
-#define ESR_ELx_EC_PAC		(0x09)	/* EL2 and above */
+#define ESR_ELx_EC_CP15_32	UL(0x03)
+#define ESR_ELx_EC_CP15_64	UL(0x04)
+#define ESR_ELx_EC_CP14_MR	UL(0x05)
+#define ESR_ELx_EC_CP14_LS	UL(0x06)
+#define ESR_ELx_EC_FP_ASIMD	UL(0x07)
+#define ESR_ELx_EC_CP10_ID	UL(0x08)	/* EL2 only */
+#define ESR_ELx_EC_PAC		UL(0x09)	/* EL2 and above */
 /* Unallocated EC: 0x0A - 0x0B */
-#define ESR_ELx_EC_CP14_64	(0x0C)
-#define ESR_ELx_EC_BTI		(0x0D)
-#define ESR_ELx_EC_ILL		(0x0E)
+#define ESR_ELx_EC_CP14_64	UL(0x0C)
+#define ESR_ELx_EC_BTI		UL(0x0D)
+#define ESR_ELx_EC_ILL		UL(0x0E)
 /* Unallocated EC: 0x0F - 0x10 */
-#define ESR_ELx_EC_SVC32	(0x11)
-#define ESR_ELx_EC_HVC32	(0x12)	/* EL2 only */
-#define ESR_ELx_EC_SMC32	(0x13)	/* EL2 and above */
+#define ESR_ELx_EC_SVC32	UL(0x11)
+#define ESR_ELx_EC_HVC32	UL(0x12)	/* EL2 only */
+#define ESR_ELx_EC_SMC32	UL(0x13)	/* EL2 and above */
 /* Unallocated EC: 0x14 */
-#define ESR_ELx_EC_SVC64	(0x15)
-#define ESR_ELx_EC_HVC64	(0x16)	/* EL2 and above */
-#define ESR_ELx_EC_SMC64	(0x17)	/* EL2 and above */
-#define ESR_ELx_EC_SYS64	(0x18)
-#define ESR_ELx_EC_SVE		(0x19)
-#define ESR_ELx_EC_ERET		(0x1a)	/* EL2 only */
+#define ESR_ELx_EC_SVC64	UL(0x15)
+#define ESR_ELx_EC_HVC64	UL(0x16)	/* EL2 and above */
+#define ESR_ELx_EC_SMC64	UL(0x17)	/* EL2 and above */
+#define ESR_ELx_EC_SYS64	UL(0x18)
+#define ESR_ELx_EC_SVE		UL(0x19)
+#define ESR_ELx_EC_ERET		UL(0x1a)	/* EL2 only */
 /* Unallocated EC: 0x1B */
-#define ESR_ELx_EC_FPAC		(0x1C)	/* EL1 and above */
-#define ESR_ELx_EC_SME		(0x1D)
+#define ESR_ELx_EC_FPAC		UL(0x1C)	/* EL1 and above */
+#define ESR_ELx_EC_SME		UL(0x1D)
 /* Unallocated EC: 0x1E */
-#define ESR_ELx_EC_IMP_DEF	(0x1f)	/* EL3 only */
-#define ESR_ELx_EC_IABT_LOW	(0x20)
-#define ESR_ELx_EC_IABT_CUR	(0x21)
-#define ESR_ELx_EC_PC_ALIGN	(0x22)
+#define ESR_ELx_EC_IMP_DEF	UL(0x1f)	/* EL3 only */
+#define ESR_ELx_EC_IABT_LOW	UL(0x20)
+#define ESR_ELx_EC_IABT_CUR	UL(0x21)
+#define ESR_ELx_EC_PC_ALIGN	UL(0x22)
 /* Unallocated EC: 0x23 */
-#define ESR_ELx_EC_DABT_LOW	(0x24)
-#define ESR_ELx_EC_DABT_CUR	(0x25)
-#define ESR_ELx_EC_SP_ALIGN	(0x26)
-#define ESR_ELx_EC_MOPS		(0x27)
-#define ESR_ELx_EC_FP_EXC32	(0x28)
+#define ESR_ELx_EC_DABT_LOW	UL(0x24)
+#define ESR_ELx_EC_DABT_CUR	UL(0x25)
+#define ESR_ELx_EC_SP_ALIGN	UL(0x26)
+#define ESR_ELx_EC_MOPS		UL(0x27)
+#define ESR_ELx_EC_FP_EXC32	UL(0x28)
 /* Unallocated EC: 0x29 - 0x2B */
-#define ESR_ELx_EC_FP_EXC64	(0x2C)
+#define ESR_ELx_EC_FP_EXC64	UL(0x2C)
 /* Unallocated EC: 0x2D - 0x2E */
-#define ESR_ELx_EC_SERROR	(0x2F)
-#define ESR_ELx_EC_BREAKPT_LOW	(0x30)
-#define ESR_ELx_EC_BREAKPT_CUR	(0x31)
-#define ESR_ELx_EC_SOFTSTP_LOW	(0x32)
-#define ESR_ELx_EC_SOFTSTP_CUR	(0x33)
-#define ESR_ELx_EC_WATCHPT_LOW	(0x34)
-#define ESR_ELx_EC_WATCHPT_CUR	(0x35)
+#define ESR_ELx_EC_SERROR	UL(0x2F)
+#define ESR_ELx_EC_BREAKPT_LOW	UL(0x30)
+#define ESR_ELx_EC_BREAKPT_CUR	UL(0x31)
+#define ESR_ELx_EC_SOFTSTP_LOW	UL(0x32)
+#define ESR_ELx_EC_SOFTSTP_CUR	UL(0x33)
+#define ESR_ELx_EC_WATCHPT_LOW	UL(0x34)
+#define ESR_ELx_EC_WATCHPT_CUR	UL(0x35)
 /* Unallocated EC: 0x36 - 0x37 */
-#define ESR_ELx_EC_BKPT32	(0x38)
+#define ESR_ELx_EC_BKPT32	UL(0x38)
 /* Unallocated EC: 0x39 */
-#define ESR_ELx_EC_VECTOR32	(0x3A)	/* EL2 only */
+#define ESR_ELx_EC_VECTOR32	UL(0x3A)	/* EL2 only */
 /* Unallocated EC: 0x3B */
-#define ESR_ELx_EC_BRK64	(0x3C)
+#define ESR_ELx_EC_BRK64	UL(0x3C)
 /* Unallocated EC: 0x3D - 0x3F */
-#define ESR_ELx_EC_MAX		(0x3F)
+#define ESR_ELx_EC_MAX		UL(0x3F)
 
 #define ESR_ELx_EC_SHIFT	(26)
 #define ESR_ELx_EC_WIDTH	(6)
diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 8a45b7a411e0..57f76d82077e 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -320,10 +320,10 @@ struct zt_context {
 	((sizeof(struct za_context) + (__SVE_VQ_BYTES - 1))	\
 		/ __SVE_VQ_BYTES * __SVE_VQ_BYTES)
 
-#define ZA_SIG_REGS_SIZE(vq) ((vq * __SVE_VQ_BYTES) * (vq * __SVE_VQ_BYTES))
+#define ZA_SIG_REGS_SIZE(vq) (((vq) * __SVE_VQ_BYTES) * ((vq) * __SVE_VQ_BYTES))
 
 #define ZA_SIG_ZAV_OFFSET(vq, n) (ZA_SIG_REGS_OFFSET + \
-				  (SVE_SIG_ZREG_SIZE(vq) * n))
+				  (SVE_SIG_ZREG_SIZE(vq) * (n)))
 
 #define ZA_SIG_CONTEXT_SIZE(vq) \
 		(ZA_SIG_REGS_OFFSET + ZA_SIG_REGS_SIZE(vq))
@@ -334,7 +334,7 @@ struct zt_context {
 
 #define ZT_SIG_REGS_OFFSET sizeof(struct zt_context)
 
-#define ZT_SIG_REGS_SIZE(n) (ZT_SIG_REG_BYTES * n)
+#define ZT_SIG_REGS_SIZE(n) (ZT_SIG_REG_BYTES * (n))
 
 #define ZT_SIG_CONTEXT_SIZE(n) \
 	(sizeof(struct zt_context) + ZT_SIG_REGS_SIZE(n))
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index f6b6b4507357..dfefbdf4073a 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -456,6 +456,14 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 };
 #endif
 
+#ifdef CONFIG_AMPERE_ERRATUM_AC03_CPU_38
+static const struct midr_range erratum_ac03_cpu_38_list[] = {
+	MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+	MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
+	{},
+};
+#endif
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -772,7 +780,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.desc = "AmpereOne erratum AC03_CPU_38",
 		.capability = ARM64_WORKAROUND_AMPERE_AC03_CPU_38,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+		ERRATA_MIDR_RANGE_LIST(erratum_ac03_cpu_38_list),
 	},
 #endif
 	{
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 05688f6a275f..d36b9160e934 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -71,7 +71,7 @@ enum ipi_msg_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_CPU_STOP,
-	IPI_CPU_CRASH_STOP,
+	IPI_CPU_STOP_NMI,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
 	NR_IPI,
@@ -88,6 +88,8 @@ static int ipi_irq_base __ro_after_init;
 static int nr_ipi __ro_after_init = NR_IPI;
 static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
 
+static bool crash_stop;
+
 static void ipi_setup(int cpu);
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -773,7 +775,7 @@ static const char *ipi_types[MAX_IPI] __tracepoint_string = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
 	[IPI_CALL_FUNC]		= "Function call interrupts",
 	[IPI_CPU_STOP]		= "CPU stop interrupts",
-	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
+	[IPI_CPU_STOP_NMI]	= "CPU stop NMIs",
 	[IPI_TIMER]		= "Timer broadcast interrupts",
 	[IPI_IRQ_WORK]		= "IRQ work interrupts",
 	[IPI_CPU_BACKTRACE]	= "CPU backtrace interrupts",
@@ -817,9 +819,9 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-static void __noreturn local_cpu_stop(void)
+static void __noreturn local_cpu_stop(unsigned int cpu)
 {
-	set_cpu_online(smp_processor_id(), false);
+	set_cpu_online(cpu, false);
 
 	local_daif_mask();
 	sdei_mask_local_cpu();
@@ -833,21 +835,26 @@ static void __noreturn local_cpu_stop(void)
  */
 void __noreturn panic_smp_self_stop(void)
 {
-	local_cpu_stop();
+	local_cpu_stop(smp_processor_id());
 }
 
-#ifdef CONFIG_KEXEC_CORE
-static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
-#endif
-
 static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 {
 #ifdef CONFIG_KEXEC_CORE
+	/*
+	 * Use local_daif_mask() instead of local_irq_disable() to make sure
+	 * that pseudo-NMIs are disabled. The "crash stop" code starts with
+	 * an IRQ and falls back to NMI (which might be pseudo). If the IRQ
+	 * finally goes through right as we're timing out then the NMI could
+	 * interrupt us. It's better to prevent the NMI and let the IRQ
+	 * finish since the pt_regs will be better.
+	 */
+	local_daif_mask();
+
 	crash_save_cpu(regs, cpu);
 
-	atomic_dec(&waiting_for_crash_ipi);
+	set_cpu_online(cpu, false);
 
-	local_irq_disable();
 	sdei_mask_local_cpu();
 
 	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
@@ -912,14 +919,12 @@ static void do_handle_IPI(int ipinr)
 		break;
 
 	case IPI_CPU_STOP:
-		local_cpu_stop();
-		break;
-
-	case IPI_CPU_CRASH_STOP:
-		if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
+	case IPI_CPU_STOP_NMI:
+		if (IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop) {
 			ipi_cpu_crash_stop(cpu, get_irq_regs());
-
 			unreachable();
+		} else {
+			local_cpu_stop(cpu);
 		}
 		break;
 
@@ -974,8 +979,7 @@ static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
 		return false;
 
 	switch (ipi) {
-	case IPI_CPU_STOP:
-	case IPI_CPU_CRASH_STOP:
+	case IPI_CPU_STOP_NMI:
 	case IPI_CPU_BACKTRACE:
 	case IPI_KGDB_ROUNDUP:
 		return true;
@@ -1088,79 +1092,109 @@ static inline unsigned int num_other_online_cpus(void)
 
 void smp_send_stop(void)
 {
+	static unsigned long stop_in_progress;
+	cpumask_t mask;
 	unsigned long timeout;
 
-	if (num_other_online_cpus()) {
-		cpumask_t mask;
+	/*
+	 * If this cpu is the only one alive at this point in time, online or
+	 * not, there are no stop messages to be sent around, so just back out.
+	 */
+	if (num_other_online_cpus() == 0)
+		goto skip_ipi;
 
-		cpumask_copy(&mask, cpu_online_mask);
-		cpumask_clear_cpu(smp_processor_id(), &mask);
+	/* Only proceed if this is the first CPU to reach this code */
+	if (test_and_set_bit(0, &stop_in_progress))
+		return;
 
-		if (system_state <= SYSTEM_RUNNING)
-			pr_crit("SMP: stopping secondary CPUs\n");
-		smp_cross_call(&mask, IPI_CPU_STOP);
-	}
+	/*
+	 * Send an IPI to all currently online CPUs except the CPU running
+	 * this code.
+	 *
+	 * NOTE: we don't do anything here to prevent other CPUs from coming
+	 * online after we snapshot `cpu_online_mask`. Ideally, the calling code
+	 * should do something to prevent other CPUs from coming up. This code
+	 * can be called in the panic path and thus it doesn't seem wise to
+	 * grab the CPU hotplug mutex ourselves. Worst case:
+	 * - If a CPU comes online as we're running, we'll likely notice it
+	 *   during the 1 second wait below and then we'll catch it when we try
+	 *   with an NMI (assuming NMIs are enabled) since we re-snapshot the
+	 *   mask before sending an NMI.
+	 * - If we leave the function and see that CPUs are still online we'll
+	 *   at least print a warning. Especially without NMIs this function
+	 *   isn't foolproof anyway so calling code will just have to accept
+	 *   the fact that there could be cases where a CPU can't be stopped.
+	 */
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), &mask);
 
-	/* Wait up to one second for other CPUs to stop */
+	if (system_state <= SYSTEM_RUNNING)
+		pr_crit("SMP: stopping secondary CPUs\n");
+
+	/*
+	 * Start with a normal IPI and wait up to one second for other CPUs to
+	 * stop. We do this first because it gives other processors a chance
+	 * to exit critical sections / drop locks and makes the rest of the
+	 * stop process (especially console flush) more robust.
+	 */
+	smp_cross_call(&mask, IPI_CPU_STOP);
 	timeout = USEC_PER_SEC;
 	while (num_other_online_cpus() && timeout--)
 		udelay(1);
 
-	if (num_other_online_cpus())
+	/*
+	 * If CPUs are still online, try an NMI. There's no excuse for this to
+	 * be slow, so we only give them an extra 10 ms to respond.
+	 */
+	if (num_other_online_cpus() && ipi_should_be_nmi(IPI_CPU_STOP_NMI)) {
+		smp_rmb();
+		cpumask_copy(&mask, cpu_online_mask);
+		cpumask_clear_cpu(smp_processor_id(), &mask);
+
+		pr_info("SMP: retry stop with NMI for CPUs %*pbl\n",
+			cpumask_pr_args(&mask));
+
+		smp_cross_call(&mask, IPI_CPU_STOP_NMI);
+		timeout = USEC_PER_MSEC * 10;
+		while (num_other_online_cpus() && timeout--)
+			udelay(1);
+	}
+
+	if (num_other_online_cpus()) {
+		smp_rmb();
+		cpumask_copy(&mask, cpu_online_mask);
+		cpumask_clear_cpu(smp_processor_id(), &mask);
+
 		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
-			cpumask_pr_args(cpu_online_mask));
+			cpumask_pr_args(&mask));
+	}
 
+skip_ipi:
 	sdei_mask_local_cpu();
 }
 
 #ifdef CONFIG_KEXEC_CORE
 void crash_smp_send_stop(void)
 {
-	static int cpus_stopped;
-	cpumask_t mask;
-	unsigned long timeout;
-
 	/*
 	 * This function can be called twice in panic path, but obviously
 	 * we execute this only once.
+	 *
+	 * We use this same boolean to tell whether the IPI we send was a
+	 * stop or a "crash stop".
 	 */
-	if (cpus_stopped)
+	if (crash_stop)
 		return;
+	crash_stop = 1;
 
-	cpus_stopped = 1;
+	smp_send_stop();
 
-	/*
-	 * If this cpu is the only one alive at this point in time, online or
-	 * not, there are no stop messages to be sent around, so just back out.
-	 */
-	if (num_other_online_cpus() == 0)
-		goto skip_ipi;
-
-	cpumask_copy(&mask, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), &mask);
-
-	atomic_set(&waiting_for_crash_ipi, num_other_online_cpus());
-
-	pr_crit("SMP: stopping secondary CPUs\n");
-	smp_cross_call(&mask, IPI_CPU_CRASH_STOP);
-
-	/* Wait up to one second for other CPUs to stop */
-	timeout = USEC_PER_SEC;
-	while ((atomic_read(&waiting_for_crash_ipi) > 0) && timeout--)
-		udelay(1);
-
-	if (atomic_read(&waiting_for_crash_ipi) > 0)
-		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
-			cpumask_pr_args(&mask));
-
-skip_ipi:
-	sdei_mask_local_cpu();
 	sdei_handler_abort();
 }
 
 bool smp_crash_stop_failed(void)
 {
-	return (atomic_read(&waiting_for_crash_ipi) > 0);
+	return num_other_online_cpus() != 0;
 }
 #endif
 
diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index efb053af331c..f26ae1819d1b 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -423,9 +423,9 @@ static void do_ffa_mem_frag_tx(struct arm_smccc_res *res,
 	return;
 }
 
-static __always_inline void do_ffa_mem_xfer(const u64 func_id,
-					    struct arm_smccc_res *res,
-					    struct kvm_cpu_context *ctxt)
+static void __do_ffa_mem_xfer(const u64 func_id,
+			      struct arm_smccc_res *res,
+			      struct kvm_cpu_context *ctxt)
 {
 	DECLARE_REG(u32, len, ctxt, 1);
 	DECLARE_REG(u32, fraglen, ctxt, 2);
@@ -437,9 +437,6 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 	u32 offset, nr_ranges;
 	int ret = 0;
 
-	BUILD_BUG_ON(func_id != FFA_FN64_MEM_SHARE &&
-		     func_id != FFA_FN64_MEM_LEND);
-
 	if (addr_mbz || npages_mbz || fraglen > len ||
 	    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) {
 		ret = FFA_RET_INVALID_PARAMETERS;
@@ -458,6 +455,11 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 		goto out_unlock;
 	}
 
+	if (len > ffa_desc_buf.len) {
+		ret = FFA_RET_NO_MEMORY;
+		goto out_unlock;
+	}
+
 	buf = hyp_buffers.tx;
 	memcpy(buf, host_buffers.tx, fraglen);
 
@@ -509,6 +511,13 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 	goto out_unlock;
 }
 
+#define do_ffa_mem_xfer(fid, res, ctxt)				\
+	do {							\
+		BUILD_BUG_ON((fid) != FFA_FN64_MEM_SHARE &&	\
+			     (fid) != FFA_FN64_MEM_LEND);	\
+		__do_ffa_mem_xfer((fid), (res), (ctxt));	\
+	} while (0);
+
 static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
 			       struct kvm_cpu_context *ctxt)
 {
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 1bf483ec971d..c4190865f243 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -26,7 +26,7 @@
 
 #define TMP_REG_1 (MAX_BPF_JIT_REG + 0)
 #define TMP_REG_2 (MAX_BPF_JIT_REG + 1)
-#define TCALL_CNT (MAX_BPF_JIT_REG + 2)
+#define TCCNT_PTR (MAX_BPF_JIT_REG + 2)
 #define TMP_REG_3 (MAX_BPF_JIT_REG + 3)
 #define FP_BOTTOM (MAX_BPF_JIT_REG + 4)
 #define ARENA_VM_START (MAX_BPF_JIT_REG + 5)
@@ -63,8 +63,8 @@ static const int bpf2a64[] = {
 	[TMP_REG_1] = A64_R(10),
 	[TMP_REG_2] = A64_R(11),
 	[TMP_REG_3] = A64_R(12),
-	/* tail_call_cnt */
-	[TCALL_CNT] = A64_R(26),
+	/* tail_call_cnt_ptr */
+	[TCCNT_PTR] = A64_R(26),
 	/* temporary register for blinding constants */
 	[BPF_REG_AX] = A64_R(9),
 	[FP_BOTTOM] = A64_R(27),
@@ -282,13 +282,35 @@ static bool is_lsi_offset(int offset, int scale)
  *      mov x29, sp
  *      stp x19, x20, [sp, #-16]!
  *      stp x21, x22, [sp, #-16]!
- *      stp x25, x26, [sp, #-16]!
+ *      stp x26, x25, [sp, #-16]!
+ *      stp x26, x25, [sp, #-16]!
  *      stp x27, x28, [sp, #-16]!
  *      mov x25, sp
  *      mov tcc, #0
  *      // PROLOGUE_OFFSET
  */
 
+static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx)
+{
+	const struct bpf_prog *prog = ctx->prog;
+	const bool is_main_prog = !bpf_is_subprog(prog);
+	const u8 ptr = bpf2a64[TCCNT_PTR];
+	const u8 fp = bpf2a64[BPF_REG_FP];
+	const u8 tcc = ptr;
+
+	emit(A64_PUSH(ptr, fp, A64_SP), ctx);
+	if (is_main_prog) {
+		/* Initialize tail_call_cnt. */
+		emit(A64_MOVZ(1, tcc, 0, 0), ctx);
+		emit(A64_PUSH(tcc, fp, A64_SP), ctx);
+		emit(A64_MOV(1, ptr, A64_SP), ctx);
+	} else {
+		emit(A64_PUSH(ptr, fp, A64_SP), ctx);
+		emit(A64_NOP, ctx);
+		emit(A64_NOP, ctx);
+	}
+}
+
 #define BTI_INSNS (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) ? 1 : 0)
 #define PAC_INSNS (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL) ? 1 : 0)
 
@@ -296,7 +318,7 @@ static bool is_lsi_offset(int offset, int scale)
 #define POKE_OFFSET (BTI_INSNS + 1)
 
 /* Tail call offset to jump into */
-#define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 8)
+#define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 10)
 
 static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 			  bool is_exception_cb, u64 arena_vm_start)
@@ -308,7 +330,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 	const u8 r8 = bpf2a64[BPF_REG_8];
 	const u8 r9 = bpf2a64[BPF_REG_9];
 	const u8 fp = bpf2a64[BPF_REG_FP];
-	const u8 tcc = bpf2a64[TCALL_CNT];
 	const u8 fpb = bpf2a64[FP_BOTTOM];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
 	const int idx0 = ctx->idx;
@@ -359,7 +380,7 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 		/* Save callee-saved registers */
 		emit(A64_PUSH(r6, r7, A64_SP), ctx);
 		emit(A64_PUSH(r8, r9, A64_SP), ctx);
-		emit(A64_PUSH(fp, tcc, A64_SP), ctx);
+		prepare_bpf_tail_call_cnt(ctx);
 		emit(A64_PUSH(fpb, A64_R(28), A64_SP), ctx);
 	} else {
 		/*
@@ -372,18 +393,15 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 		 * callee-saved registers. The exception callback will not push
 		 * anything and re-use the main program's stack.
 		 *
-		 * 10 registers are on the stack
+		 * 12 registers are on the stack
 		 */
-		emit(A64_SUB_I(1, A64_SP, A64_FP, 80), ctx);
+		emit(A64_SUB_I(1, A64_SP, A64_FP, 96), ctx);
 	}
 
 	/* Set up BPF prog stack base register */
 	emit(A64_MOV(1, fp, A64_SP), ctx);
 
 	if (!ebpf_from_cbpf && is_main_prog) {
-		/* Initialize tail_call_cnt */
-		emit(A64_MOVZ(1, tcc, 0, 0), ctx);
-
 		cur_offset = ctx->idx - idx0;
 		if (cur_offset != PROLOGUE_OFFSET) {
 			pr_err_once("PROLOGUE_OFFSET = %d, expected %d!\n",
@@ -432,7 +450,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 prg = bpf2a64[TMP_REG_2];
-	const u8 tcc = bpf2a64[TCALL_CNT];
+	const u8 tcc = bpf2a64[TMP_REG_3];
+	const u8 ptr = bpf2a64[TCCNT_PTR];
 	const int idx0 = ctx->idx;
 #define cur_offset (ctx->idx - idx0)
 #define jmp_offset (out_offset - (cur_offset))
@@ -449,11 +468,12 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	emit(A64_B_(A64_COND_CS, jmp_offset), ctx);
 
 	/*
-	 * if (tail_call_cnt >= MAX_TAIL_CALL_CNT)
+	 * if ((*tail_call_cnt_ptr) >= MAX_TAIL_CALL_CNT)
 	 *     goto out;
-	 * tail_call_cnt++;
+	 * (*tail_call_cnt_ptr)++;
 	 */
 	emit_a64_mov_i64(tmp, MAX_TAIL_CALL_CNT, ctx);
+	emit(A64_LDR64I(tcc, ptr, 0), ctx);
 	emit(A64_CMP(1, tcc, tmp), ctx);
 	emit(A64_B_(A64_COND_CS, jmp_offset), ctx);
 	emit(A64_ADD_I(1, tcc, tcc, 1), ctx);
@@ -469,6 +489,9 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	emit(A64_LDR64(prg, tmp, prg), ctx);
 	emit(A64_CBZ(1, prg, jmp_offset), ctx);
 
+	/* Update tail_call_cnt if the slot is populated. */
+	emit(A64_STR64I(tcc, ptr, 0), ctx);
+
 	/* goto *(prog->bpf_func + prologue_offset); */
 	off = offsetof(struct bpf_prog, bpf_func);
 	emit_a64_mov_i64(tmp, off, ctx);
@@ -721,6 +744,7 @@ static void build_epilogue(struct jit_ctx *ctx, bool is_exception_cb)
 	const u8 r8 = bpf2a64[BPF_REG_8];
 	const u8 r9 = bpf2a64[BPF_REG_9];
 	const u8 fp = bpf2a64[BPF_REG_FP];
+	const u8 ptr = bpf2a64[TCCNT_PTR];
 	const u8 fpb = bpf2a64[FP_BOTTOM];
 
 	/* We're done with BPF stack */
@@ -738,7 +762,8 @@ static void build_epilogue(struct jit_ctx *ctx, bool is_exception_cb)
 	/* Restore x27 and x28 */
 	emit(A64_POP(fpb, A64_R(28), A64_SP), ctx);
 	/* Restore fs (x25) and x26 */
-	emit(A64_POP(fp, A64_R(26), A64_SP), ctx);
+	emit(A64_POP(ptr, fp, A64_SP), ctx);
+	emit(A64_POP(ptr, fp, A64_SP), ctx);
 
 	/* Restore callee-saved register */
 	emit(A64_POP(r8, r9, A64_SP), ctx);
diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
index d741c3e9933a..590a92cb5416 100644
--- a/arch/loongarch/include/asm/kvm_vcpu.h
+++ b/arch/loongarch/include/asm/kvm_vcpu.h
@@ -76,6 +76,7 @@ static inline void kvm_restore_lasx(struct loongarch_fpu *fpu) { }
 #endif
 
 void kvm_init_timer(struct kvm_vcpu *vcpu, unsigned long hz);
+void kvm_reset_timer(struct kvm_vcpu *vcpu);
 void kvm_save_timer(struct kvm_vcpu *vcpu);
 void kvm_restore_timer(struct kvm_vcpu *vcpu);
 
diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
index 74a4b5c272d6..bcc6b6d063d9 100644
--- a/arch/loongarch/kvm/timer.c
+++ b/arch/loongarch/kvm/timer.c
@@ -188,3 +188,10 @@ void kvm_save_timer(struct kvm_vcpu *vcpu)
 	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_ESTAT);
 	preempt_enable();
 }
+
+void kvm_reset_timer(struct kvm_vcpu *vcpu)
+{
+	write_gcsr_timercfg(0);
+	kvm_write_sw_gcsr(vcpu->arch.csr, LOONGARCH_CSR_TCFG, 0);
+	hrtimer_cancel(&vcpu->arch.swtimer);
+}
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 0b53f4d9fddf..9e8030d45129 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -572,7 +572,7 @@ static int kvm_set_one_reg(struct kvm_vcpu *vcpu,
 				vcpu->kvm->arch.time_offset = (signed long)(v - drdtime());
 			break;
 		case KVM_REG_LOONGARCH_VCPU_RESET:
-			vcpu->arch.st.guest_addr = 0;
+			kvm_reset_timer(vcpu);
 			memset(&vcpu->arch.irq_pending, 0, sizeof(vcpu->arch.irq_pending));
 			memset(&vcpu->arch.irq_clear, 0, sizeof(vcpu->arch.irq_clear));
 			break;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 2584e94e2134..fda7eac23f87 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -117,7 +117,7 @@ asmlinkage int m68k_clone(struct pt_regs *regs)
 {
 	/* regs will be equal to current_pt_regs() */
 	struct kernel_clone_args args = {
-		.flags		= regs->d1 & ~CSIGNAL,
+		.flags		= (u32)(regs->d1) & ~CSIGNAL,
 		.pidfd		= (int __user *)regs->d3,
 		.child_tid	= (int __user *)regs->d4,
 		.parent_tid	= (int __user *)regs->d3,
diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index 1e201b7ae2fc..bd9d77b0c92e 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -96,6 +96,7 @@ config CRYPTO_AES_PPC_SPE
 
 config CRYPTO_AES_GCM_P10
 	tristate "Stitched AES/GCM acceleration support on P10 or later CPU (PPC)"
+	depends on BROKEN
 	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
 	select CRYPTO_LIB_AES
 	select CRYPTO_ALGAPI
diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index 2bc53c646ccd..83848b534cb1 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -39,6 +39,12 @@
 #define STDX_BE	stringify_in_c(stdbrx)
 #endif
 
+#ifdef CONFIG_CC_IS_CLANG
+#define DS_FORM_CONSTRAINT "Z<>"
+#else
+#define DS_FORM_CONSTRAINT "YZ<>"
+#endif
+
 #else /* 32-bit */
 
 /* operations for longs and pointers */
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 5bf6a4d49268..d1ea554c33ed 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -11,6 +11,7 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 #include <asm/asm-const.h>
+#include <asm/asm-compat.h>
 
 /*
  * Since *_return_relaxed and {cmp}xchg_relaxed are implemented with
@@ -197,7 +198,7 @@ static __inline__ s64 arch_atomic64_read(const atomic64_t *v)
 	if (IS_ENABLED(CONFIG_PPC_KERNEL_PREFIXED))
 		__asm__ __volatile__("ld %0,0(%1)" : "=r"(t) : "b"(&v->counter));
 	else
-		__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : "m<>"(v->counter));
+		__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : DS_FORM_CONSTRAINT (v->counter));
 
 	return t;
 }
@@ -208,7 +209,7 @@ static __inline__ void arch_atomic64_set(atomic64_t *v, s64 i)
 	if (IS_ENABLED(CONFIG_PPC_KERNEL_PREFIXED))
 		__asm__ __volatile__("std %1,0(%2)" : "=m"(v->counter) : "r"(i), "b"(&v->counter));
 	else
-		__asm__ __volatile__("std%U0%X0 %1,%0" : "=m<>"(v->counter) : "r"(i));
+		__asm__ __volatile__("std%U0%X0 %1,%0" : "=" DS_FORM_CONSTRAINT (v->counter) : "r"(i));
 }
 
 #define ATOMIC64_OP(op, asm_op)						\
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index fd594bf6c6a9..4f5a46a77fa2 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -6,6 +6,7 @@
 #include <asm/page.h>
 #include <asm/extable.h>
 #include <asm/kup.h>
+#include <asm/asm-compat.h>
 
 #ifdef __powerpc64__
 /* We use TASK_SIZE_USER64 as TASK_SIZE is not constant */
@@ -92,12 +93,6 @@ __pu_failed:							\
 		: label)
 #endif
 
-#ifdef CONFIG_CC_IS_CLANG
-#define DS_FORM_CONSTRAINT "Z<>"
-#else
-#define DS_FORM_CONSTRAINT "YZ<>"
-#endif
-
 #ifdef __powerpc64__
 #ifdef CONFIG_PPC_KERNEL_PREFIXED
 #define __put_user_asm2_goto(x, ptr, label)			\
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index edc479a7c2bc..0bd317b56475 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -41,12 +41,12 @@
 #include "head_32.h"
 
 .macro compare_to_kernel_boundary scratch, addr
-#if CONFIG_TASK_SIZE <= 0x80000000 && CONFIG_PAGE_OFFSET >= 0x80000000
+#if CONFIG_TASK_SIZE <= 0x80000000 && MODULES_VADDR >= 0x80000000
 /* By simply checking Address >= 0x80000000, we know if its a kernel address */
 	not.	\scratch, \addr
 #else
 	rlwinm	\scratch, \addr, 16, 0xfff8
-	cmpli	cr0, \scratch, PAGE_OFFSET@h
+	cmpli	cr0, \scratch, TASK_SIZE@h
 #endif
 .endm
 
@@ -404,7 +404,7 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	mfspr	r10, SPRN_SRR0
 	mtspr	SPRN_MD_EPN, r10
 	rlwinm	r11, r10, 16, 0xfff8
-	cmpli	cr1, r11, PAGE_OFFSET@h
+	cmpli	cr1, r11, TASK_SIZE@h
 	mfspr	r11, SPRN_M_TWB	/* Get level 1 table */
 	blt+	cr1, 3f
 
diff --git a/arch/powerpc/kernel/vdso/gettimeofday.S b/arch/powerpc/kernel/vdso/gettimeofday.S
index 48fc6658053a..894cb939cd2b 100644
--- a/arch/powerpc/kernel/vdso/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso/gettimeofday.S
@@ -38,11 +38,7 @@
 	.else
 	addi		r4, r5, VDSO_DATA_OFFSET
 	.endif
-#ifdef __powerpc64__
 	bl		CFUNC(DOTSYM(\funct))
-#else
-	bl		\funct
-#endif
 	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
 #ifdef __powerpc64__
 	PPC_LL		r2, PPC_MIN_STKFRM + STK_GOT(r1)
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index d93433e26ded..e5cc3b3a259f 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -154,11 +154,11 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 
 	mmu_mapin_immr();
 
-	mmu_mapin_ram_chunk(0, boundary, PAGE_KERNEL_TEXT, true);
+	mmu_mapin_ram_chunk(0, boundary, PAGE_KERNEL_X, true);
 	if (debug_pagealloc_enabled_or_kfence()) {
 		top = boundary;
 	} else {
-		mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL_TEXT, true);
+		mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL_X, true);
 		mmu_mapin_ram_chunk(einittext8, top, PAGE_KERNEL, true);
 	}
 
diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
index fa0f535bbbf0..1d85b6617508 100644
--- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
+++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
@@ -10,6 +10,7 @@
 #define __KVM_VCPU_RISCV_PMU_H
 
 #include <linux/perf/riscv_pmu.h>
+#include <asm/kvm_vcpu_insn.h>
 #include <asm/sbi.h>
 
 #ifdef CONFIG_RISCV_PMU_SBI
@@ -64,11 +65,11 @@ struct kvm_pmu {
 
 #if defined(CONFIG_32BIT)
 #define KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS \
-{.base = CSR_CYCLEH,	.count = 31,	.func = kvm_riscv_vcpu_pmu_read_hpm }, \
-{.base = CSR_CYCLE,	.count = 31,	.func = kvm_riscv_vcpu_pmu_read_hpm },
+{.base = CSR_CYCLEH,	.count = 32,	.func = kvm_riscv_vcpu_pmu_read_hpm }, \
+{.base = CSR_CYCLE,	.count = 32,	.func = kvm_riscv_vcpu_pmu_read_hpm },
 #else
 #define KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS \
-{.base = CSR_CYCLE,	.count = 31,	.func = kvm_riscv_vcpu_pmu_read_hpm },
+{.base = CSR_CYCLE,	.count = 32,	.func = kvm_riscv_vcpu_pmu_read_hpm },
 #endif
 
 int kvm_riscv_vcpu_pmu_incr_fw(struct kvm_vcpu *vcpu, unsigned long fid);
@@ -104,8 +105,20 @@ void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu);
 struct kvm_pmu {
 };
 
+static inline int kvm_riscv_vcpu_pmu_read_legacy(struct kvm_vcpu *vcpu, unsigned int csr_num,
+						 unsigned long *val, unsigned long new_val,
+						 unsigned long wr_mask)
+{
+	if (csr_num == CSR_CYCLE || csr_num == CSR_INSTRET) {
+		*val = 0;
+		return KVM_INSN_CONTINUE_NEXT_SEPC;
+	} else {
+		return KVM_INSN_ILLEGAL_TRAP;
+	}
+}
+
 #define KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS \
-{.base = 0,	.count = 0,	.func = NULL },
+{.base = CSR_CYCLE,	.count = 3,	.func = kvm_riscv_vcpu_pmu_read_legacy },
 
 static inline void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu) {}
 static inline int kvm_riscv_vcpu_pmu_incr_fw(struct kvm_vcpu *vcpu, unsigned long fid)
diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
index 3348a61de7d9..2932791e9388 100644
--- a/arch/riscv/kernel/perf_callchain.c
+++ b/arch/riscv/kernel/perf_callchain.c
@@ -62,7 +62,7 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 	perf_callchain_store(entry, regs->epc);
 
 	fp = user_backtrace(entry, fp, regs->ra);
-	while (fp && !(fp & 0x3) && entry->nr < entry->max_stack)
+	while (fp && !(fp & 0x7) && entry->nr < entry->max_stack)
 		fp = user_backtrace(entry, fp, 0);
 }
 
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index bcf41d6e0df0..2707a51b082c 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -391,19 +391,9 @@ int kvm_riscv_vcpu_pmu_read_hpm(struct kvm_vcpu *vcpu, unsigned int csr_num,
 static void kvm_pmu_clear_snapshot_area(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
-	int snapshot_area_size = sizeof(struct riscv_pmu_snapshot_data);
 
-	if (kvpmu->sdata) {
-		if (kvpmu->snapshot_addr != INVALID_GPA) {
-			memset(kvpmu->sdata, 0, snapshot_area_size);
-			kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr,
-					     kvpmu->sdata, snapshot_area_size);
-		} else {
-			pr_warn("snapshot address invalid\n");
-		}
-		kfree(kvpmu->sdata);
-		kvpmu->sdata = NULL;
-	}
+	kfree(kvpmu->sdata);
+	kvpmu->sdata = NULL;
 	kvpmu->snapshot_addr = INVALID_GPA;
 }
 
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 62f409d4176e..7de128be8db9 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -127,8 +127,8 @@ void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	run->riscv_sbi.args[3] = cp->a3;
 	run->riscv_sbi.args[4] = cp->a4;
 	run->riscv_sbi.args[5] = cp->a5;
-	run->riscv_sbi.ret[0] = cp->a0;
-	run->riscv_sbi.ret[1] = cp->a1;
+	run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
+	run->riscv_sbi.ret[1] = 0;
 }
 
 void kvm_riscv_vcpu_sbi_system_reset(struct kvm_vcpu *vcpu,
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 77e479d44f1e..d0cb3ecd6390 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -7,8 +7,23 @@
 #define MCOUNT_INSN_SIZE	6
 
 #ifndef __ASSEMBLY__
+#include <asm/stacktrace.h>
 
-unsigned long return_address(unsigned int n);
+static __always_inline unsigned long return_address(unsigned int n)
+{
+	struct stack_frame *sf;
+
+	if (!n)
+		return (unsigned long)__builtin_return_address(0);
+
+	sf = (struct stack_frame *)current_frame_address();
+	do {
+		sf = (struct stack_frame *)sf->back_chain;
+		if (!sf)
+			return 0;
+	} while (--n);
+	return sf->gprs[8];
+}
 #define ftrace_return_address(n) return_address(n)
 
 void ftrace_caller(void);
diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index 640363b2a105..9f59837d159e 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -162,22 +162,3 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 {
 	arch_stack_walk_user_common(consume_entry, cookie, NULL, regs, false);
 }
-
-unsigned long return_address(unsigned int n)
-{
-	struct unwind_state state;
-	unsigned long addr;
-
-	/* Increment to skip current stack entry */
-	n++;
-
-	unwind_for_each_frame(&state, NULL, NULL, 0) {
-		addr = unwind_get_return_address(&state);
-		if (!addr)
-			break;
-		if (!n--)
-			return addr;
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(return_address);
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 8fe4c2b07128..327c45c5013f 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -7,6 +7,7 @@
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/kexec.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -14,6 +15,8 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/set_memory.h>
+#include <asm/traps.h>
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -38,6 +41,8 @@
 
 #define TDREPORT_SUBTYPE_0	0
 
+static atomic_long_t nr_shared;
+
 /* Called from __tdx_hypercall() for unrecoverable failure */
 noinstr void __noreturn __tdx_hypercall_failed(void)
 {
@@ -429,6 +434,11 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 			return -EINVAL;
 	}
 
+	if (!fault_in_kernel_space(ve->gla)) {
+		WARN_ONCE(1, "Access to userspace address is not supported");
+		return -EINVAL;
+	}
+
 	/*
 	 * Reject EPT violation #VEs that split pages.
 	 *
@@ -797,28 +807,124 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	return true;
 }
 
-static bool tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
-					  bool enc)
+static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
+					 bool enc)
 {
 	/*
 	 * Only handle shared->private conversion here.
 	 * See the comment in tdx_early_init().
 	 */
-	if (enc)
-		return tdx_enc_status_changed(vaddr, numpages, enc);
-	return true;
+	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc))
+		return -EIO;
+
+	return 0;
 }
 
-static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
+static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 					 bool enc)
 {
 	/*
 	 * Only handle private->shared conversion here.
 	 * See the comment in tdx_early_init().
 	 */
-	if (!enc)
-		return tdx_enc_status_changed(vaddr, numpages, enc);
-	return true;
+	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
+		return -EIO;
+
+	if (enc)
+		atomic_long_sub(numpages, &nr_shared);
+	else
+		atomic_long_add(numpages, &nr_shared);
+
+	return 0;
+}
+
+/* Stop new private<->shared conversions */
+static void tdx_kexec_begin(void)
+{
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	/*
+	 * Crash kernel reaches here with interrupts disabled: can't wait for
+	 * conversions to finish.
+	 *
+	 * If race happened, just report and proceed.
+	 */
+	if (!set_memory_enc_stop_conversion())
+		pr_warn("Failed to stop shared<->private conversions\n");
+}
+
+/* Walk direct mapping and convert all shared memory back to private */
+static void tdx_kexec_finish(void)
+{
+	unsigned long addr, end;
+	long found = 0, shared;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	lockdep_assert_irqs_disabled();
+
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+
+		if (pte && pte_decrypted(*pte)) {
+			int pages = size / PAGE_SIZE;
+
+			/*
+			 * Touching memory with shared bit set triggers implicit
+			 * conversion to shared.
+			 *
+			 * Make sure nobody touches the shared range from
+			 * now on.
+			 */
+			set_pte(pte, __pte(0));
+
+			/*
+			 * Memory encryption state persists across kexec.
+			 * If tdx_enc_status_changed() fails in the first
+			 * kernel, it leaves memory in an unknown state.
+			 *
+			 * If that memory remains shared, accessing it in the
+			 * *next* kernel through a private mapping will result
+			 * in an unrecoverable guest shutdown.
+			 *
+			 * The kdump kernel boot is not impacted as it uses
+			 * a pre-reserved memory range that is always private.
+			 * However, gathering crash information could lead to
+			 * a crash if it accesses unconverted memory through
+			 * a private mapping which is possible when accessing
+			 * that memory through /proc/vmcore, for example.
+			 *
+			 * In all cases, print error info in order to leave
+			 * enough bread crumbs for debugging.
+			 */
+			if (!tdx_enc_status_changed(addr, pages, true)) {
+				pr_err("Failed to unshare range %#lx-%#lx\n",
+				       addr, addr + size);
+			}
+
+			found += pages;
+		}
+
+		addr += size;
+	}
+
+	__flush_tlb_all();
+
+	shared = atomic_long_read(&nr_shared);
+	if (shared != found) {
+		pr_err("shared page accounting is off\n");
+		pr_err("nr_shared = %ld, nr_found = %ld\n", shared, found);
+	}
 }
 
 void __init tdx_early_init(void)
@@ -880,6 +986,9 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
 
+	x86_platform.guest.enc_kexec_begin	     = tdx_kexec_begin;
+	x86_platform.guest.enc_kexec_finish	     = tdx_kexec_finish;
+
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
 	 * bringup low level code. That raises #VE which cannot be handled
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dcac96133cb6..28757629d0d8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3912,8 +3912,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
 			x86_pmu.pebs_aliases(event);
 	}
 
-	if (needs_branch_stack(event) && is_sampling_event(event))
-		event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+	if (needs_branch_stack(event)) {
+		/* Avoid branch stack setup for counting events in SAMPLE READ */
+		if (is_sampling_event(event) ||
+		    !(event->attr.sample_type & PERF_SAMPLE_READ))
+			event->hw.flags |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+	}
 
 	if (branch_sample_counters(event)) {
 		struct perf_event *leader, *sibling;
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index b4aa8daa4773..2959970dd10e 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1606,6 +1606,7 @@ static void pt_event_stop(struct perf_event *event, int mode)
 	 * see comment in intel_pt_interrupt().
 	 */
 	WRITE_ONCE(pt->handle_nmi, 0);
+	barrier();
 
 	pt_config_stop(event);
 
@@ -1657,11 +1658,10 @@ static long pt_event_snapshot_aux(struct perf_event *event,
 		return 0;
 
 	/*
-	 * Here, handle_nmi tells us if the tracing is on
+	 * There is no PT interrupt in this mode, so stop the trace and it will
+	 * remain stopped while the buffer is copied.
 	 */
-	if (READ_ONCE(pt->handle_nmi))
-		pt_config_stop(event);
-
+	pt_config_stop(event);
 	pt_read_offset(buf);
 	pt_update_head(pt);
 
@@ -1673,11 +1673,10 @@ static long pt_event_snapshot_aux(struct perf_event *event,
 	ret = perf_output_copy_aux(&pt->handle, handle, from, to);
 
 	/*
-	 * If the tracing was on when we turned up, restart it.
-	 * Compiler barrier not needed as we couldn't have been
-	 * preempted by anything that touches pt->handle_nmi.
+	 * Here, handle_nmi tells us if the tracing was on.
+	 * If the tracing was on, restart it.
 	 */
-	if (pt->handle_nmi)
+	if (READ_ONCE(pt->handle_nmi))
 		pt_config_start(event);
 
 	return ret;
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 768d73de0d09..b4a851d27c7c 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -523,9 +523,9 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
  * transition is complete, hv_vtom_set_host_visibility() marks the pages
  * as "present" again.
  */
-static bool hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc)
+static int hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc)
 {
-	return !set_memory_np(kbuffer, pagecount);
+	return set_memory_np(kbuffer, pagecount);
 }
 
 /*
@@ -536,20 +536,19 @@ static bool hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc
  * with host. This function works as wrap of hv_mark_gpa_visibility()
  * with memory base and size.
  */
-static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bool enc)
+static int hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bool enc)
 {
 	enum hv_mem_host_visibility visibility = enc ?
 			VMBUS_PAGE_NOT_VISIBLE : VMBUS_PAGE_VISIBLE_READ_WRITE;
 	u64 *pfn_array;
 	phys_addr_t paddr;
+	int i, pfn, err;
 	void *vaddr;
 	int ret = 0;
-	bool result = true;
-	int i, pfn;
 
 	pfn_array = kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!pfn_array) {
-		result = false;
+		ret = -ENOMEM;
 		goto err_set_memory_p;
 	}
 
@@ -568,10 +567,8 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
 			ret = hv_mark_gpa_visibility(pfn, pfn_array,
 						     visibility);
-			if (ret) {
-				result = false;
+			if (ret)
 				goto err_free_pfn_array;
-			}
 			pfn = 0;
 		}
 	}
@@ -586,10 +583,11 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 	 * order to avoid leaving the memory range in a "broken" state. Setting
 	 * the PRESENT bits shouldn't fail, but return an error if it does.
 	 */
-	if (set_memory_p(kbuffer, pagecount))
-		result = false;
+	err = set_memory_p(kbuffer, pagecount);
+	if (err && !ret)
+		ret = err;
 
-	return result;
+	return ret;
 }
 
 static bool hv_vtom_tlb_flush_required(bool private)
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 5af926c050f0..041efa274eeb 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -167,6 +167,14 @@ void acpi_generic_reduced_hw_init(void);
 void x86_default_set_root_pointer(u64 addr);
 u64 x86_default_get_root_pointer(void);
 
+#ifdef CONFIG_XEN_PV
+/* A Xen PV domain needs a special acpi_os_ioremap() handling. */
+extern void __iomem * (*acpi_os_ioremap)(acpi_physical_address phys,
+					 acpi_size size);
+void __iomem *x86_acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
+#define acpi_os_ioremap acpi_os_ioremap
+#endif
+
 #else /* !CONFIG_ACPI */
 
 #define acpi_lapic 0
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index c67fa6ad098a..6ffa8b75f4cd 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -69,7 +69,11 @@ extern u64 arch_irq_stat(void);
 #define local_softirq_pending_ref       pcpu_hot.softirq_pending
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
-static inline void kvm_set_cpu_l1tf_flush_l1d(void)
+/*
+ * This function is called from noinstr interrupt contexts
+ * and must be inlined to not get instrumentation.
+ */
+static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void)
 {
 	__this_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 1);
 }
@@ -84,7 +88,7 @@ static __always_inline bool kvm_get_cpu_l1tf_flush_l1d(void)
 	return __this_cpu_read(irq_stat.kvm_cpu_l1tf_flush_l1d);
 }
 #else /* !IS_ENABLED(CONFIG_KVM_INTEL) */
-static inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
+static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
 #endif /* IS_ENABLED(CONFIG_KVM_INTEL) */
 
 #endif /* _ASM_X86_HARDIRQ_H */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index d4f24499b256..ad5c68f0509d 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -212,8 +212,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	irqentry_state_t state = irqentry_enter(regs);			\
 	u32 vector = (u32)(u8)error_code;				\
 									\
+	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
-	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_irq_on_irqstack_cond(__##func, regs, vector);		\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
@@ -250,7 +250,6 @@ static void __##func(struct pt_regs *regs);				\
 									\
 static __always_inline void instr_##func(struct pt_regs *regs)		\
 {									\
-	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_sysvec_on_irqstack_cond(__##func, regs);			\
 }									\
 									\
@@ -258,6 +257,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
+	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
 	instr_##func (regs);						\
 	instrumentation_end();						\
@@ -288,7 +288,6 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 static __always_inline void instr_##func(struct pt_regs *regs)		\
 {									\
 	__irq_enter_raw();						\
-	kvm_set_cpu_l1tf_flush_l1d();					\
 	__##func (regs);						\
 	__irq_exit_raw();						\
 }									\
@@ -297,6 +296,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
+	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
 	instr_##func (regs);						\
 	instrumentation_end();						\
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d0274b3be2c4..e18399d08fb1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1708,7 +1708,8 @@ struct kvm_x86_ops {
 	void (*enable_nmi_window)(struct kvm_vcpu *vcpu);
 	void (*enable_irq_window)(struct kvm_vcpu *vcpu);
 	void (*update_cr8_intercept)(struct kvm_vcpu *vcpu, int tpr, int irr);
-	bool (*check_apicv_inhibit_reasons)(enum kvm_apicv_inhibit reason);
+
+	const bool x2apic_icr_is_split;
 	const unsigned long required_apicv_inhibits;
 	bool allow_apicv_in_x2apic_without_x2apic_virtualization;
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 65b8e5bb902c..e39311a89bf4 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -140,6 +140,11 @@ static inline int pte_young(pte_t pte)
 	return pte_flags(pte) & _PAGE_ACCESSED;
 }
 
+static inline bool pte_decrypted(pte_t pte)
+{
+	return cc_mkdec(pte_val(pte)) == pte_val(pte);
+}
+
 #define pmd_dirty pmd_dirty
 static inline bool pmd_dirty(pmd_t pmd)
 {
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 9aee31862b4a..4b2abce2e3e7 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -49,8 +49,11 @@ int set_memory_wb(unsigned long addr, int numpages);
 int set_memory_np(unsigned long addr, int numpages);
 int set_memory_p(unsigned long addr, int numpages);
 int set_memory_4k(unsigned long addr, int numpages);
+
+bool set_memory_enc_stop_conversion(void);
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
+
 int set_memory_np_noalias(unsigned long addr, int numpages);
 int set_memory_nonglobal(unsigned long addr, int numpages);
 int set_memory_global(unsigned long addr, int numpages);
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 6149eabe200f..213cf5379a5a 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -149,12 +149,22 @@ struct x86_init_acpi {
  * @enc_status_change_finish	Notify HV after the encryption status of a range is changed
  * @enc_tlb_flush_required	Returns true if a TLB flush is needed before changing page encryption status
  * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
+ * @enc_kexec_begin		Begin the two-step process of converting shared memory back
+ *				to private. It stops the new conversions from being started
+ *				and waits in-flight conversions to finish, if possible.
+ * @enc_kexec_finish		Finish the two-step process of converting shared memory to
+ *				private. All memory is private after the call when
+ *				the function returns.
+ *				It is called on only one CPU while the others are shut down
+ *				and with interrupts disabled.
  */
 struct x86_guest {
-	bool (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
-	bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
+	int (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
+	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
+	void (*enc_kexec_begin)(void);
+	void (*enc_kexec_finish)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 4bf82dbd2a6b..01e929a0f6cc 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1862,3 +1862,14 @@ u64 x86_default_get_root_pointer(void)
 {
 	return boot_params.acpi_rsdp_addr;
 }
+
+#ifdef CONFIG_XEN_PV
+void __iomem *x86_acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
+{
+	return ioremap_cache(phys, size);
+}
+
+void __iomem * (*acpi_os_ioremap)(acpi_physical_address phys, acpi_size size) =
+	x86_acpi_os_ioremap;
+EXPORT_SYMBOL_GPL(acpi_os_ioremap);
+#endif
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 27892e57c4ef..6aeeb43dd3f6 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -475,24 +475,25 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
 {
 	struct sgx_epc_page *page;
 	int nid_of_current = numa_node_id();
-	int nid = nid_of_current;
+	int nid_start, nid;
 
-	if (node_isset(nid_of_current, sgx_numa_mask)) {
-		page = __sgx_alloc_epc_page_from_node(nid_of_current);
-		if (page)
-			return page;
-	}
-
-	/* Fall back to the non-local NUMA nodes: */
-	while (true) {
-		nid = next_node_in(nid, sgx_numa_mask);
-		if (nid == nid_of_current)
-			break;
+	/*
+	 * Try local node first. If it doesn't have an EPC section,
+	 * fall back to the non-local NUMA nodes.
+	 */
+	if (node_isset(nid_of_current, sgx_numa_mask))
+		nid_start = nid_of_current;
+	else
+		nid_start = next_node_in(nid_of_current, sgx_numa_mask);
 
+	nid = nid_start;
+	do {
 		page = __sgx_alloc_epc_page_from_node(nid);
 		if (page)
 			return page;
-	}
+
+		nid = next_node_in(nid, sgx_numa_mask);
+	} while (nid != nid_start);
 
 	return ERR_PTR(-ENOMEM);
 }
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index f06501445cd9..340af8155658 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -128,6 +128,18 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
 #endif
+
+	/*
+	 * Non-crash kexec calls enc_kexec_begin() while scheduling is still
+	 * active. This allows the callback to wait until all in-flight
+	 * shared<->private conversions are complete. In a crash scenario,
+	 * enc_kexec_begin() gets called after all but one CPU have been shut
+	 * down and interrupts have been disabled. This allows the callback to
+	 * detect a race with the conversion and report it.
+	 */
+	x86_platform.guest.enc_kexec_begin();
+	x86_platform.guest.enc_kexec_finish();
+
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a817ed0724d1..4b9d4557fc94 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -559,10 +559,11 @@ void early_setup_idt(void)
  */
 void __head startup_64_setup_gdt_idt(void)
 {
+	struct desc_struct *gdt = (void *)(__force unsigned long)init_per_cpu_var(gdt_page.gdt);
 	void *handler = NULL;
 
 	struct desc_ptr startup_gdt_descr = {
-		.address = (unsigned long)&RIP_REL_REF(init_per_cpu_var(gdt_page.gdt)),
+		.address = (unsigned long)&RIP_REL_REF(*gdt),
 		.size    = GDT_SIZE - 1,
 	};
 
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index df337860612d..cd8ed1edbf9e 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/reboot.h>
 #include <linux/serial_8250.h>
+#include <linux/acpi.h>
 #include <asm/apic.h>
 #include <asm/io_apic.h>
 #include <asm/acpi.h>
diff --git a/arch/x86/kernel/mmconf-fam10h_64.c b/arch/x86/kernel/mmconf-fam10h_64.c
index c94dec6a1834..1f54eedc3015 100644
--- a/arch/x86/kernel/mmconf-fam10h_64.c
+++ b/arch/x86/kernel/mmconf-fam10h_64.c
@@ -9,6 +9,7 @@
 #include <linux/pci.h>
 #include <linux/dmi.h>
 #include <linux/range.h>
+#include <linux/acpi.h>
 
 #include <asm/pci-direct.h>
 #include <linux/sort.h>
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6d3d20e3e43a..d8d582b750d4 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -798,6 +798,27 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 
 #define LAM_U57_BITS 6
 
+static void enable_lam_func(void *__mm)
+{
+	struct mm_struct *mm = __mm;
+
+	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm) {
+		write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
+		set_tlbstate_lam_mode(mm);
+	}
+}
+
+static void mm_enable_lam(struct mm_struct *mm)
+{
+	/*
+	 * Even though the process must still be single-threaded at this
+	 * point, kernel threads may be using the mm.  IPI those kernel
+	 * threads if they exist.
+	 */
+	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
+	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
+}
+
 static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_LAM))
@@ -814,6 +835,10 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
+	/*
+	 * MM_CONTEXT_LOCK_LAM is set on clone.  Prevent LAM from
+	 * being enabled unless the process is single threaded:
+	 */
 	if (test_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags)) {
 		mmap_write_unlock(mm);
 		return -EBUSY;
@@ -830,9 +855,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		return -EINVAL;
 	}
 
-	write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
-	set_tlbstate_lam_mode(mm);
-	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
+	mm_enable_lam(mm);
 
 	mmap_write_unlock(mm);
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index f3130f762784..bb7a44af7efd 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/objtool.h>
 #include <linux/pgtable.h>
+#include <linux/kexec.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -716,6 +717,14 @@ static void native_machine_emergency_restart(void)
 
 void native_machine_shutdown(void)
 {
+	/*
+	 * Call enc_kexec_begin() while all CPUs are still active and
+	 * interrupts are enabled. This will allow all in-flight memory
+	 * conversions to finish cleanly.
+	 */
+	if (kexec_in_progress)
+		x86_platform.guest.enc_kexec_begin();
+
 	/* Stop the cpus and apics */
 #ifdef CONFIG_X86_IO_APIC
 	/*
@@ -752,6 +761,9 @@ void native_machine_shutdown(void)
 #ifdef CONFIG_X86_64
 	x86_platform.iommu_shutdown();
 #endif
+
+	if (kexec_in_progress)
+		x86_platform.guest.enc_kexec_finish();
 }
 
 static void __machine_emergency_restart(int emergency)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0c35207320cb..390e4fe7433e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -60,6 +60,7 @@
 #include <linux/stackprotector.h>
 #include <linux/cpuhotplug.h>
 #include <linux/mc146818rtc.h>
+#include <linux/acpi.h>
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index d5dc5a92635a..0a2bbd674a6d 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -8,6 +8,7 @@
 #include <linux/ioport.h>
 #include <linux/export.h>
 #include <linux/pci.h>
+#include <linux/acpi.h>
 
 #include <asm/acpi.h>
 #include <asm/bios_ebda.h>
@@ -134,10 +135,12 @@ struct x86_cpuinit_ops x86_cpuinit = {
 
 static void default_nmi_init(void) { };
 
-static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
-static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return true; }
+static int enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return 0; }
+static int enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return 0; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
+static void enc_kexec_begin_noop(void) {}
+static void enc_kexec_finish_noop(void) {}
 static bool is_private_mmio_noop(u64 addr) {return false; }
 
 struct x86_platform_ops x86_platform __ro_after_init = {
@@ -161,6 +164,8 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 		.enc_status_change_finish  = enc_status_change_finish_noop,
 		.enc_tlb_flush_required	   = enc_tlb_flush_required_noop,
 		.enc_cache_flush_required  = enc_cache_flush_required_noop,
+		.enc_kexec_begin	   = enc_kexec_begin_noop,
+		.enc_kexec_finish	   = enc_kexec_finish_noop,
 	},
 };
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index acd7d48100a1..523d02c50562 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -351,10 +351,8 @@ static void kvm_recalculate_logical_map(struct kvm_apic_map *new,
 	 * reversing the LDR calculation to get cluster of APICs, i.e. no
 	 * additional work is required.
 	 */
-	if (apic_x2apic_mode(apic)) {
-		WARN_ON_ONCE(ldr != kvm_apic_calc_x2apic_ldr(kvm_x2apic_id(apic)));
+	if (apic_x2apic_mode(apic))
 		return;
-	}
 
 	if (WARN_ON_ONCE(!kvm_apic_map_get_logical_dest(new, ldr,
 							&cluster, &mask))) {
@@ -2453,6 +2451,43 @@ void kvm_lapic_set_eoi(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_lapic_set_eoi);
 
+#define X2APIC_ICR_RESERVED_BITS (GENMASK_ULL(31, 20) | GENMASK_ULL(17, 16) | BIT(13))
+
+int kvm_x2apic_icr_write(struct kvm_lapic *apic, u64 data)
+{
+	if (data & X2APIC_ICR_RESERVED_BITS)
+		return 1;
+
+	/*
+	 * The BUSY bit is reserved on both Intel and AMD in x2APIC mode, but
+	 * only AMD requires it to be zero, Intel essentially just ignores the
+	 * bit.  And if IPI virtualization (Intel) or x2AVIC (AMD) is enabled,
+	 * the CPU performs the reserved bits checks, i.e. the underlying CPU
+	 * behavior will "win".  Arbitrarily clear the BUSY bit, as there is no
+	 * sane way to provide consistent behavior with respect to hardware.
+	 */
+	data &= ~APIC_ICR_BUSY;
+
+	kvm_apic_send_ipi(apic, (u32)data, (u32)(data >> 32));
+	if (kvm_x86_ops.x2apic_icr_is_split) {
+		kvm_lapic_set_reg(apic, APIC_ICR, data);
+		kvm_lapic_set_reg(apic, APIC_ICR2, data >> 32);
+	} else {
+		kvm_lapic_set_reg64(apic, APIC_ICR, data);
+	}
+	trace_kvm_apic_write(APIC_ICR, data);
+	return 0;
+}
+
+static u64 kvm_x2apic_icr_read(struct kvm_lapic *apic)
+{
+	if (kvm_x86_ops.x2apic_icr_is_split)
+		return (u64)kvm_lapic_get_reg(apic, APIC_ICR) |
+		       (u64)kvm_lapic_get_reg(apic, APIC_ICR2) << 32;
+
+	return kvm_lapic_get_reg64(apic, APIC_ICR);
+}
+
 /* emulate APIC access in a trap manner */
 void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset)
 {
@@ -2470,7 +2505,7 @@ void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset)
 	 * maybe-unecessary write, and both are in the noise anyways.
 	 */
 	if (apic_x2apic_mode(apic) && offset == APIC_ICR)
-		kvm_x2apic_icr_write(apic, kvm_lapic_get_reg64(apic, APIC_ICR));
+		WARN_ON_ONCE(kvm_x2apic_icr_write(apic, kvm_x2apic_icr_read(apic)));
 	else
 		kvm_lapic_reg_write(apic, offset, kvm_lapic_get_reg(apic, offset));
 }
@@ -2964,34 +2999,48 @@ static int kvm_apic_state_fixup(struct kvm_vcpu *vcpu,
 		struct kvm_lapic_state *s, bool set)
 {
 	if (apic_x2apic_mode(vcpu->arch.apic)) {
+		u32 x2apic_id = kvm_x2apic_id(vcpu->arch.apic);
 		u32 *id = (u32 *)(s->regs + APIC_ID);
 		u32 *ldr = (u32 *)(s->regs + APIC_LDR);
 		u64 icr;
 
 		if (vcpu->kvm->arch.x2apic_format) {
-			if (*id != vcpu->vcpu_id)
+			if (*id != x2apic_id)
 				return -EINVAL;
 		} else {
+			/*
+			 * Ignore the userspace value when setting APIC state.
+			 * KVM's model is that the x2APIC ID is readonly, e.g.
+			 * KVM only supports delivering interrupts to KVM's
+			 * version of the x2APIC ID.  However, for backwards
+			 * compatibility, don't reject attempts to set a
+			 * mismatched ID for userspace that hasn't opted into
+			 * x2apic_format.
+			 */
 			if (set)
-				*id >>= 24;
+				*id = x2apic_id;
 			else
-				*id <<= 24;
+				*id = x2apic_id << 24;
 		}
 
 		/*
 		 * In x2APIC mode, the LDR is fixed and based on the id.  And
-		 * ICR is internally a single 64-bit register, but needs to be
-		 * split to ICR+ICR2 in userspace for backwards compatibility.
+		 * if the ICR is _not_ split, ICR is internally a single 64-bit
+		 * register, but needs to be split to ICR+ICR2 in userspace for
+		 * backwards compatibility.
 		 */
-		if (set) {
-			*ldr = kvm_apic_calc_x2apic_ldr(*id);
-
-			icr = __kvm_lapic_get_reg(s->regs, APIC_ICR) |
-			      (u64)__kvm_lapic_get_reg(s->regs, APIC_ICR2) << 32;
-			__kvm_lapic_set_reg64(s->regs, APIC_ICR, icr);
-		} else {
-			icr = __kvm_lapic_get_reg64(s->regs, APIC_ICR);
-			__kvm_lapic_set_reg(s->regs, APIC_ICR2, icr >> 32);
+		if (set)
+			*ldr = kvm_apic_calc_x2apic_ldr(x2apic_id);
+
+		if (!kvm_x86_ops.x2apic_icr_is_split) {
+			if (set) {
+				icr = __kvm_lapic_get_reg(s->regs, APIC_ICR) |
+				      (u64)__kvm_lapic_get_reg(s->regs, APIC_ICR2) << 32;
+				__kvm_lapic_set_reg64(s->regs, APIC_ICR, icr);
+			} else {
+				icr = __kvm_lapic_get_reg64(s->regs, APIC_ICR);
+				__kvm_lapic_set_reg(s->regs, APIC_ICR2, icr >> 32);
+			}
 		}
 	}
 
@@ -3183,22 +3232,12 @@ int kvm_lapic_set_vapic_addr(struct kvm_vcpu *vcpu, gpa_t vapic_addr)
 	return 0;
 }
 
-int kvm_x2apic_icr_write(struct kvm_lapic *apic, u64 data)
-{
-	data &= ~APIC_ICR_BUSY;
-
-	kvm_apic_send_ipi(apic, (u32)data, (u32)(data >> 32));
-	kvm_lapic_set_reg64(apic, APIC_ICR, data);
-	trace_kvm_apic_write(APIC_ICR, data);
-	return 0;
-}
-
 static int kvm_lapic_msr_read(struct kvm_lapic *apic, u32 reg, u64 *data)
 {
 	u32 low;
 
 	if (reg == APIC_ICR) {
-		*data = kvm_lapic_get_reg64(apic, APIC_ICR);
+		*data = kvm_x2apic_icr_read(apic);
 		return 0;
 	}
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0357f7af5596..6d5da700268a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5051,6 +5051,8 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.enable_nmi_window = svm_enable_nmi_window,
 	.enable_irq_window = svm_enable_irq_window,
 	.update_cr8_intercept = svm_update_cr8_intercept,
+
+	.x2apic_icr_is_split = true,
 	.set_virtual_apic_mode = avic_refresh_virtual_apic_mode,
 	.refresh_apicv_exec_ctrl = avic_refresh_apicv_exec_ctrl,
 	.apicv_post_state_restore = avic_apicv_post_state_restore,
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 547fca3709fe..35c2c004dacd 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -89,6 +89,8 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.enable_nmi_window = vmx_enable_nmi_window,
 	.enable_irq_window = vmx_enable_irq_window,
 	.update_cr8_intercept = vmx_update_cr8_intercept,
+
+	.x2apic_icr_is_split = false,
 	.set_virtual_apic_mode = vmx_set_virtual_apic_mode,
 	.set_apic_access_page_addr = vmx_set_apic_access_page_addr,
 	.refresh_apicv_exec_ctrl = vmx_refresh_apicv_exec_ctrl,
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index d404227c164d..e46aba18600e 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -46,7 +46,6 @@ bool vmx_apic_init_signal_blocked(struct kvm_vcpu *vcpu);
 void vmx_migrate_timers(struct kvm_vcpu *vcpu);
 void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
 void vmx_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
-bool vmx_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason);
 void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr);
 void vmx_hwapic_isr_update(int max_isr);
 int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 422602f6039b..e7b67519ddb5 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -283,7 +283,7 @@ static void enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc)
 #endif
 }
 
-static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
+static int amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
 {
 	/*
 	 * To maintain the security guarantees of SEV-SNP guests, make sure
@@ -292,11 +292,11 @@ static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool
 	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !enc)
 		snp_set_memory_shared(vaddr, npages);
 
-	return true;
+	return 0;
 }
 
 /* Return true unconditionally: return value doesn't matter for the SEV side */
-static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool enc)
+static int amd_enc_status_change_finish(unsigned long vaddr, int npages, bool enc)
 {
 	/*
 	 * After memory is mapped encrypted in the page table, validate it
@@ -308,7 +308,7 @@ static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool e
 	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		enc_dec_hypercall(vaddr, npages << PAGE_SHIFT, enc);
 
-	return true;
+	return 0;
 }
 
 static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 19fdfbb171ed..1356e25e6d12 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2196,7 +2196,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
 
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
-	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
+	ret = x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
+	if (ret)
 		goto vmm_fail;
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
@@ -2214,24 +2215,61 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 		return ret;
 
 	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
-	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
+	ret = x86_platform.guest.enc_status_change_finish(addr, numpages, enc);
+	if (ret)
 		goto vmm_fail;
 
 	return 0;
 
 vmm_fail:
-	WARN_ONCE(1, "CPA VMM failure to convert memory (addr=%p, numpages=%d) to %s.\n",
-		  (void *)addr, numpages, enc ? "private" : "shared");
+	WARN_ONCE(1, "CPA VMM failure to convert memory (addr=%p, numpages=%d) to %s: %d\n",
+		  (void *)addr, numpages, enc ? "private" : "shared", ret);
 
-	return -EIO;
+	return ret;
+}
+
+/*
+ * The lock serializes conversions between private and shared memory.
+ *
+ * It is taken for read on conversion. A write lock guarantees that no
+ * concurrent conversions are in progress.
+ */
+static DECLARE_RWSEM(mem_enc_lock);
+
+/*
+ * Stop new private<->shared conversions.
+ *
+ * Taking the exclusive mem_enc_lock waits for in-flight conversions to complete.
+ * The lock is not released to prevent new conversions from being started.
+ */
+bool set_memory_enc_stop_conversion(void)
+{
+	/*
+	 * In a crash scenario, sleep is not allowed. Try to take the lock.
+	 * Failure indicates that there is a race with the conversion.
+	 */
+	if (oops_in_progress)
+		return down_write_trylock(&mem_enc_lock);
+
+	down_write(&mem_enc_lock);
+
+	return true;
 }
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		return __set_memory_enc_pgtable(addr, numpages, enc);
+	int ret = 0;
 
-	return 0;
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+		if (!down_read_trylock(&mem_enc_lock))
+			return -EBUSY;
+
+		ret = __set_memory_enc_pgtable(addr, numpages, enc);
+
+		up_read(&mem_enc_lock);
+	}
+
+	return ret;
 }
 
 int set_memory_encrypted(unsigned long addr, int numpages)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047..a041d2ecd838 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -503,9 +503,9 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 {
 	struct mm_struct *prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	unsigned long new_lam = mm_lam_cr3_mask(next);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
+	unsigned long new_lam;
 	u64 next_tlb_gen;
 	bool need_flush;
 	u16 new_asid;
@@ -619,9 +619,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 			cpumask_clear_cpu(cpu, mm_cpumask(prev));
 		}
 
-		/*
-		 * Start remote flushes and then read tlb_gen.
-		 */
+		/* Start receiving IPIs and then read tlb_gen (and LAM below) */
 		if (next != &init_mm)
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
@@ -633,6 +631,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		barrier();
 	}
 
+	new_lam = mm_lam_cr3_mask(next);
 	set_tlbstate_lam_mode(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5159c7a22922..2f28a9b34b91 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -273,7 +273,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET	(12 + ENDBR_INSN_SIZE)
 
 static void push_r12(u8 **pprog)
 {
@@ -403,6 +403,37 @@ static void emit_cfi(u8 **pprog, u32 hash)
 	*pprog = prog;
 }
 
+static void emit_prologue_tail_call(u8 **pprog, bool is_subprog)
+{
+	u8 *prog = *pprog;
+
+	if (!is_subprog) {
+		/* cmp rax, MAX_TAIL_CALL_CNT */
+		EMIT4(0x48, 0x83, 0xF8, MAX_TAIL_CALL_CNT);
+		EMIT2(X86_JA, 6);        /* ja 6 */
+		/* rax is tail_call_cnt if <= MAX_TAIL_CALL_CNT.
+		 * case1: entry of main prog.
+		 * case2: tail callee of main prog.
+		 */
+		EMIT1(0x50);             /* push rax */
+		/* Make rax as tail_call_cnt_ptr. */
+		EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
+		EMIT2(0xEB, 1);          /* jmp 1 */
+		/* rax is tail_call_cnt_ptr if > MAX_TAIL_CALL_CNT.
+		 * case: tail callee of subprog.
+		 */
+		EMIT1(0x50);             /* push rax */
+		/* push tail_call_cnt_ptr */
+		EMIT1(0x50);             /* push rax */
+	} else { /* is_subprog */
+		/* rax is tail_call_cnt_ptr. */
+		EMIT1(0x50);             /* push rax */
+		EMIT1(0x50);             /* push rax */
+	}
+
+	*pprog = prog;
+}
+
 /*
  * Emit x86-64 prologue code for BPF program.
  * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
@@ -424,10 +455,10 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 			/* When it's the entry of the whole tailcall context,
 			 * zeroing rax means initialising tail_call_cnt.
 			 */
-			EMIT2(0x31, 0xC0); /* xor eax, eax */
+			EMIT3(0x48, 0x31, 0xC0); /* xor rax, rax */
 		else
 			/* Keep the same instruction layout. */
-			EMIT2(0x66, 0x90); /* nop2 */
+			emit_nops(&prog, 3);     /* nop3 */
 	}
 	/* Exception callback receives FP as third parameter */
 	if (is_exception_cb) {
@@ -453,7 +484,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
 	if (tail_call_reachable)
-		EMIT1(0x50);         /* push rax */
+		emit_prologue_tail_call(&prog, is_subprog);
 	*pprog = prog;
 }
 
@@ -589,13 +620,15 @@ static void emit_return(u8 **pprog, u8 *ip)
 	*pprog = prog;
 }
 
+#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack)	(-16 - round_up(stack, 8))
+
 /*
  * Generate the following code:
  *
  * ... bpf_tail_call(void *ctx, struct bpf_array *array, u64 index) ...
  *   if (index >= array->map.max_entries)
  *     goto out;
- *   if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+ *   if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
  *     goto out;
  *   prog = array->ptrs[index];
  *   if (prog == NULL)
@@ -608,7 +641,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 					u32 stack_depth, u8 *ip,
 					struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack_depth);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;
 
@@ -630,16 +663,14 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	EMIT2(X86_JBE, offset);                   /* jbe out */
 
 	/*
-	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
-	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
+	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off); /* mov rax, qword ptr [rbp - tcc_ptr_off] */
+	EMIT4(0x48, 0x83, 0x38, MAX_TAIL_CALL_CNT); /* cmp qword ptr [rax], MAX_TAIL_CALL_CNT */
 
 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                   /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
 
 	/* prog = array->ptrs[index]; */
 	EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx * 8 + offsetof(...)] */
@@ -654,6 +685,9 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JE, offset);                    /* je out */
 
+	/* Inc tail_call_cnt if the slot is populated. */
+	EMIT4(0x48, 0x83, 0x00, 0x01);            /* add qword ptr [rax], 1 */
+
 	if (bpf_prog->aux->exception_boundary) {
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
@@ -663,6 +697,11 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 			pop_r12(&prog);
 	}
 
+	/* Pop tail_call_cnt_ptr. */
+	EMIT1(0x58);                              /* pop rax */
+	/* Pop tail_call_cnt, if it's main prog.
+	 * Pop tail_call_cnt_ptr, if it's subprog.
+	 */
 	EMIT1(0x58);                              /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
@@ -691,21 +730,19 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 				      bool *callee_regs_used, u32 stack_depth,
 				      struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack_depth);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;
 
 	/*
-	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr [rbp - tcc_off] */
-	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax, MAX_TAIL_CALL_CNT */
+	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off);   /* mov rax, qword ptr [rbp - tcc_ptr_off] */
+	EMIT4(0x48, 0x83, 0x38, MAX_TAIL_CALL_CNT);   /* cmp qword ptr [rax], MAX_TAIL_CALL_CNT */
 
 	offset = ctx->tail_call_direct_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                       /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                      /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);             /* mov dword ptr [rbp - tcc_off], eax */
 
 	poke->tailcall_bypass = ip + (prog - start);
 	poke->adj_off = X86_TAIL_CALL_OFFSET;
@@ -715,6 +752,9 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 	emit_jump(&prog, (u8 *)poke->tailcall_target + X86_PATCH_SIZE,
 		  poke->tailcall_bypass);
 
+	/* Inc tail_call_cnt if the slot is populated. */
+	EMIT4(0x48, 0x83, 0x00, 0x01);                /* add qword ptr [rax], 1 */
+
 	if (bpf_prog->aux->exception_boundary) {
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
@@ -724,6 +764,11 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 			pop_r12(&prog);
 	}
 
+	/* Pop tail_call_cnt_ptr. */
+	EMIT1(0x58);                                  /* pop rax */
+	/* Pop tail_call_cnt, if it's main prog.
+	 * Pop tail_call_cnt_ptr, if it's subprog.
+	 */
 	EMIT1(0x58);                                  /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
@@ -1313,9 +1358,11 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
-/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
-#define RESTORE_TAIL_CALL_CNT(stack)				\
-	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
+#define __LOAD_TCC_PTR(off)			\
+	EMIT3_off32(0x48, 0x8B, 0x85, off)
+/* mov rax, qword ptr [rbp - rounded_stack_depth - 16] */
+#define LOAD_TAIL_CALL_CNT_PTR(stack)				\
+	__LOAD_TCC_PTR(BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack))
 
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
@@ -2038,7 +2085,7 @@ st:			if (is_imm8(insn->off))
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
+				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
 				ip += 7;
 			}
 			if (!imm32)
@@ -2713,6 +2760,10 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 	return 0;
 }
 
+/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
+#define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)	\
+	__LOAD_TCC_PTR(-round_up(stack, 8) - 8)
+
 /* Example:
  * __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
  * its 'struct btf_func_model' will be nr_args=2
@@ -2833,7 +2884,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *                     [ ...        ]
 	 *                     [ stack_arg2 ]
 	 * RBP - arg_stack_off [ stack_arg1 ]
-	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
+	 * RSP                 [ tail_call_cnt_ptr ] BPF_TRAMP_F_TAIL_CALL_CTX
 	 */
 
 	/* room for return value of orig_call or fentry prog */
@@ -2962,10 +3013,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		save_args(m, &prog, arg_stack_off, true);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
-			/* Before calling the original function, restore the
-			 * tail_call_cnt from stack to rax.
+			/* Before calling the original function, load the
+			 * tail_call_cnt_ptr from stack to rax.
 			 */
-			RESTORE_TAIL_CALL_CNT(stack_size);
+			LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack_size);
 		}
 
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
@@ -3024,10 +3075,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			goto cleanup;
 		}
 	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
-		/* Before running the original function, restore the
-		 * tail_call_cnt from stack to rax.
+		/* Before running the original function, load the
+		 * tail_call_cnt_ptr from stack to rax.
 		 */
-		RESTORE_TAIL_CALL_CNT(stack_size);
+		LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack_size);
 	}
 
 	/* restore return value of orig_call or fentry prog back into RAX */
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b33afb240601..98a9bb92d75c 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -980,7 +980,7 @@ static void amd_rp_pme_suspend(struct pci_dev *dev)
 		return;
 
 	rp = pcie_find_root_port(dev);
-	if (!rp->pm_cap)
+	if (!rp || !rp->pm_cap)
 		return;
 
 	rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
@@ -994,7 +994,7 @@ static void amd_rp_pme_resume(struct pci_dev *dev)
 	u16 pmc;
 
 	rp = pcie_find_root_port(dev);
-	if (!rp->pm_cap)
+	if (!rp || !rp->pm_cap)
 		return;
 
 	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 54e0d311dcc9..9e9a122c2bcf 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2019,10 +2019,7 @@ void __init xen_reserve_special_pages(void)
 
 void __init xen_pt_check_e820(void)
 {
-	if (xen_is_e820_reserved(xen_pt_base, xen_pt_size)) {
-		xen_raw_console_write("Xen hypervisor allocated page table memory conflicts with E820 map\n");
-		BUG();
-	}
+	xen_chk_is_e820_usable(xen_pt_base, xen_pt_size, "page table");
 }
 
 static unsigned char dummy_mapping[PAGE_SIZE] __page_aligned_bss;
diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 6bcbdf3b7999..d8f175ee9248 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -70,6 +70,7 @@
 #include <linux/memblock.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/acpi.h>
 
 #include <asm/cache.h>
 #include <asm/setup.h>
@@ -80,6 +81,7 @@
 #include <asm/xen/hypervisor.h>
 #include <xen/balloon.h>
 #include <xen/grant_table.h>
+#include <xen/hvc-console.h>
 
 #include "multicalls.h"
 #include "xen-ops.h"
@@ -793,6 +795,102 @@ int clear_foreign_p2m_mapping(struct gnttab_unmap_grant_ref *unmap_ops,
 	return ret;
 }
 
+/* Remapped non-RAM areas */
+#define NR_NONRAM_REMAP 4
+static struct nonram_remap {
+	phys_addr_t maddr;
+	phys_addr_t paddr;
+	size_t size;
+} xen_nonram_remap[NR_NONRAM_REMAP] __ro_after_init;
+static unsigned int nr_nonram_remap __ro_after_init;
+
+/*
+ * Do the real remapping of non-RAM regions as specified in the
+ * xen_nonram_remap[] array.
+ * In case of an error just crash the system.
+ */
+void __init xen_do_remap_nonram(void)
+{
+	unsigned int i;
+	unsigned int remapped = 0;
+	const struct nonram_remap *remap = xen_nonram_remap;
+	unsigned long pfn, mfn, end_pfn;
+
+	for (i = 0; i < nr_nonram_remap; i++) {
+		end_pfn = PFN_UP(remap->paddr + remap->size);
+		pfn = PFN_DOWN(remap->paddr);
+		mfn = PFN_DOWN(remap->maddr);
+		while (pfn < end_pfn) {
+			if (!set_phys_to_machine(pfn, mfn))
+				panic("Failed to set p2m mapping for pfn=%lx mfn=%lx\n",
+				       pfn, mfn);
+
+			pfn++;
+			mfn++;
+			remapped++;
+		}
+
+		remap++;
+	}
+
+	pr_info("Remapped %u non-RAM page(s)\n", remapped);
+}
+
+#ifdef CONFIG_ACPI
+/*
+ * Xen variant of acpi_os_ioremap() taking potentially remapped non-RAM
+ * regions into account.
+ * Any attempt to map an area crossing a remap boundary will produce a
+ * WARN() splat.
+ * phys is related to remap->maddr on input and will be rebased to remap->paddr.
+ */
+static void __iomem *xen_acpi_os_ioremap(acpi_physical_address phys,
+					 acpi_size size)
+{
+	unsigned int i;
+	const struct nonram_remap *remap = xen_nonram_remap;
+
+	for (i = 0; i < nr_nonram_remap; i++) {
+		if (phys + size > remap->maddr &&
+		    phys < remap->maddr + remap->size) {
+			WARN_ON(phys < remap->maddr ||
+				phys + size > remap->maddr + remap->size);
+			phys += remap->paddr - remap->maddr;
+			break;
+		}
+	}
+
+	return x86_acpi_os_ioremap(phys, size);
+}
+#endif /* CONFIG_ACPI */
+
+/*
+ * Add a new non-RAM remap entry.
+ * In case of no free entry found, just crash the system.
+ */
+void __init xen_add_remap_nonram(phys_addr_t maddr, phys_addr_t paddr,
+				 unsigned long size)
+{
+	BUG_ON((maddr & ~PAGE_MASK) != (paddr & ~PAGE_MASK));
+
+	if (nr_nonram_remap == NR_NONRAM_REMAP) {
+		xen_raw_console_write("Number of required E820 entry remapping actions exceed maximum value\n");
+		BUG();
+	}
+
+#ifdef CONFIG_ACPI
+	/* Switch to the Xen acpi_os_ioremap() variant. */
+	if (nr_nonram_remap == 0)
+		acpi_os_ioremap = xen_acpi_os_ioremap;
+#endif
+
+	xen_nonram_remap[nr_nonram_remap].maddr = maddr;
+	xen_nonram_remap[nr_nonram_remap].paddr = paddr;
+	xen_nonram_remap[nr_nonram_remap].size = size;
+
+	nr_nonram_remap++;
+}
+
 #ifdef CONFIG_XEN_DEBUG_FS
 #include <linux/debugfs.h>
 #include "debugfs.h"
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 380591028cb8..dc822124cacb 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -15,12 +15,12 @@
 #include <linux/cpuidle.h>
 #include <linux/cpufreq.h>
 #include <linux/memory_hotplug.h>
+#include <linux/acpi.h>
 
 #include <asm/elf.h>
 #include <asm/vdso.h>
 #include <asm/e820/api.h>
 #include <asm/setup.h>
-#include <asm/acpi.h>
 #include <asm/numa.h>
 #include <asm/idtentry.h>
 #include <asm/xen/hypervisor.h>
@@ -47,6 +47,9 @@ bool xen_pv_pci_possible;
 /* E820 map used during setting up memory. */
 static struct e820_table xen_e820_table __initdata;
 
+/* Number of initially usable memory pages. */
+static unsigned long ini_nr_pages __initdata;
+
 /*
  * Buffer used to remap identity mapped pages. We only need the virtual space.
  * The physical page behind this address is remapped as needed to different
@@ -213,7 +216,7 @@ static int __init xen_free_mfn(unsigned long mfn)
  * as a fallback if the remapping fails.
  */
 static void __init xen_set_identity_and_release_chunk(unsigned long start_pfn,
-			unsigned long end_pfn, unsigned long nr_pages)
+						      unsigned long end_pfn)
 {
 	unsigned long pfn, end;
 	int ret;
@@ -221,7 +224,7 @@ static void __init xen_set_identity_and_release_chunk(unsigned long start_pfn,
 	WARN_ON(start_pfn > end_pfn);
 
 	/* Release pages first. */
-	end = min(end_pfn, nr_pages);
+	end = min(end_pfn, ini_nr_pages);
 	for (pfn = start_pfn; pfn < end; pfn++) {
 		unsigned long mfn = pfn_to_mfn(pfn);
 
@@ -342,15 +345,14 @@ static void __init xen_do_set_identity_and_remap_chunk(
  * to Xen and not remapped.
  */
 static unsigned long __init xen_set_identity_and_remap_chunk(
-	unsigned long start_pfn, unsigned long end_pfn, unsigned long nr_pages,
-	unsigned long remap_pfn)
+	unsigned long start_pfn, unsigned long end_pfn, unsigned long remap_pfn)
 {
 	unsigned long pfn;
 	unsigned long i = 0;
 	unsigned long n = end_pfn - start_pfn;
 
 	if (remap_pfn == 0)
-		remap_pfn = nr_pages;
+		remap_pfn = ini_nr_pages;
 
 	while (i < n) {
 		unsigned long cur_pfn = start_pfn + i;
@@ -359,19 +361,19 @@ static unsigned long __init xen_set_identity_and_remap_chunk(
 		unsigned long remap_range_size;
 
 		/* Do not remap pages beyond the current allocation */
-		if (cur_pfn >= nr_pages) {
+		if (cur_pfn >= ini_nr_pages) {
 			/* Identity map remaining pages */
 			set_phys_range_identity(cur_pfn, cur_pfn + size);
 			break;
 		}
-		if (cur_pfn + size > nr_pages)
-			size = nr_pages - cur_pfn;
+		if (cur_pfn + size > ini_nr_pages)
+			size = ini_nr_pages - cur_pfn;
 
 		remap_range_size = xen_find_pfn_range(&remap_pfn);
 		if (!remap_range_size) {
 			pr_warn("Unable to find available pfn range, not remapping identity pages\n");
 			xen_set_identity_and_release_chunk(cur_pfn,
-						cur_pfn + left, nr_pages);
+							   cur_pfn + left);
 			break;
 		}
 		/* Adjust size to fit in current e820 RAM region */
@@ -398,18 +400,18 @@ static unsigned long __init xen_set_identity_and_remap_chunk(
 }
 
 static unsigned long __init xen_count_remap_pages(
-	unsigned long start_pfn, unsigned long end_pfn, unsigned long nr_pages,
+	unsigned long start_pfn, unsigned long end_pfn,
 	unsigned long remap_pages)
 {
-	if (start_pfn >= nr_pages)
+	if (start_pfn >= ini_nr_pages)
 		return remap_pages;
 
-	return remap_pages + min(end_pfn, nr_pages) - start_pfn;
+	return remap_pages + min(end_pfn, ini_nr_pages) - start_pfn;
 }
 
-static unsigned long __init xen_foreach_remap_area(unsigned long nr_pages,
+static unsigned long __init xen_foreach_remap_area(
 	unsigned long (*func)(unsigned long start_pfn, unsigned long end_pfn,
-			      unsigned long nr_pages, unsigned long last_val))
+			      unsigned long last_val))
 {
 	phys_addr_t start = 0;
 	unsigned long ret_val = 0;
@@ -437,8 +439,7 @@ static unsigned long __init xen_foreach_remap_area(unsigned long nr_pages,
 				end_pfn = PFN_UP(entry->addr);
 
 			if (start_pfn < end_pfn)
-				ret_val = func(start_pfn, end_pfn, nr_pages,
-					       ret_val);
+				ret_val = func(start_pfn, end_pfn, ret_val);
 			start = end;
 		}
 	}
@@ -495,6 +496,8 @@ void __init xen_remap_memory(void)
 	set_pte_mfn(buf, mfn_save, PAGE_KERNEL);
 
 	pr_info("Remapped %ld page(s)\n", remapped);
+
+	xen_do_remap_nonram();
 }
 
 static unsigned long __init xen_get_pages_limit(void)
@@ -568,7 +571,7 @@ static void __init xen_ignore_unusable(void)
 	}
 }
 
-bool __init xen_is_e820_reserved(phys_addr_t start, phys_addr_t size)
+static bool __init xen_is_e820_reserved(phys_addr_t start, phys_addr_t size)
 {
 	struct e820_entry *entry;
 	unsigned mapcnt;
@@ -625,6 +628,111 @@ phys_addr_t __init xen_find_free_area(phys_addr_t size)
 	return 0;
 }
 
+/*
+ * Swap a non-RAM E820 map entry with RAM above ini_nr_pages.
+ * Note that the E820 map is modified accordingly, but the P2M map isn't yet.
+ * The adaption of the P2M must be deferred until page allocation is possible.
+ */
+static void __init xen_e820_swap_entry_with_ram(struct e820_entry *swap_entry)
+{
+	struct e820_entry *entry;
+	unsigned int mapcnt;
+	phys_addr_t mem_end = PFN_PHYS(ini_nr_pages);
+	phys_addr_t swap_addr, swap_size, entry_end;
+
+	swap_addr = PAGE_ALIGN_DOWN(swap_entry->addr);
+	swap_size = PAGE_ALIGN(swap_entry->addr - swap_addr + swap_entry->size);
+	entry = xen_e820_table.entries;
+
+	for (mapcnt = 0; mapcnt < xen_e820_table.nr_entries; mapcnt++) {
+		entry_end = entry->addr + entry->size;
+		if (entry->type == E820_TYPE_RAM && entry->size >= swap_size &&
+		    entry_end - swap_size >= mem_end) {
+			/* Reduce RAM entry by needed space (whole pages). */
+			entry->size -= swap_size;
+
+			/* Add new entry at the end of E820 map. */
+			entry = xen_e820_table.entries +
+				xen_e820_table.nr_entries;
+			xen_e820_table.nr_entries++;
+
+			/* Fill new entry (keep size and page offset). */
+			entry->type = swap_entry->type;
+			entry->addr = entry_end - swap_size +
+				      swap_addr - swap_entry->addr;
+			entry->size = swap_entry->size;
+
+			/* Convert old entry to RAM, align to pages. */
+			swap_entry->type = E820_TYPE_RAM;
+			swap_entry->addr = swap_addr;
+			swap_entry->size = swap_size;
+
+			/* Remember PFN<->MFN relation for P2M update. */
+			xen_add_remap_nonram(swap_addr, entry_end - swap_size,
+					     swap_size);
+
+			/* Order E820 table and merge entries. */
+			e820__update_table(&xen_e820_table);
+
+			return;
+		}
+
+		entry++;
+	}
+
+	xen_raw_console_write("No suitable area found for required E820 entry remapping action\n");
+	BUG();
+}
+
+/*
+ * Look for non-RAM memory types in a specific guest physical area and move
+ * those away if possible (ACPI NVS only for now).
+ */
+static void __init xen_e820_resolve_conflicts(phys_addr_t start,
+					      phys_addr_t size)
+{
+	struct e820_entry *entry;
+	unsigned int mapcnt;
+	phys_addr_t end;
+
+	if (!size)
+		return;
+
+	end = start + size;
+	entry = xen_e820_table.entries;
+
+	for (mapcnt = 0; mapcnt < xen_e820_table.nr_entries; mapcnt++) {
+		if (entry->addr >= end)
+			return;
+
+		if (entry->addr + entry->size > start &&
+		    entry->type == E820_TYPE_NVS)
+			xen_e820_swap_entry_with_ram(entry);
+
+		entry++;
+	}
+}
+
+/*
+ * Check for an area in physical memory to be usable for non-movable purposes.
+ * An area is considered to usable if the used E820 map lists it to be RAM or
+ * some other type which can be moved to higher PFNs while keeping the MFNs.
+ * In case the area is not usable, crash the system with an error message.
+ */
+void __init xen_chk_is_e820_usable(phys_addr_t start, phys_addr_t size,
+				   const char *component)
+{
+	xen_e820_resolve_conflicts(start, size);
+
+	if (!xen_is_e820_reserved(start, size))
+		return;
+
+	xen_raw_console_write("Xen hypervisor allocated ");
+	xen_raw_console_write(component);
+	xen_raw_console_write(" memory conflicts with E820 map\n");
+	BUG();
+}
+
 /*
  * Like memcpy, but with physical addresses for dest and src.
  */
@@ -684,20 +792,20 @@ static void __init xen_reserve_xen_mfnlist(void)
  **/
 char * __init xen_memory_setup(void)
 {
-	unsigned long max_pfn, pfn_s, n_pfns;
+	unsigned long pfn_s, n_pfns;
 	phys_addr_t mem_end, addr, size, chunk_size;
 	u32 type;
 	int rc;
 	struct xen_memory_map memmap;
 	unsigned long max_pages;
 	unsigned long extra_pages = 0;
+	unsigned long maxmem_pages;
 	int i;
 	int op;
 
 	xen_parse_512gb();
-	max_pfn = xen_get_pages_limit();
-	max_pfn = min(max_pfn, xen_start_info->nr_pages);
-	mem_end = PFN_PHYS(max_pfn);
+	ini_nr_pages = min(xen_get_pages_limit(), xen_start_info->nr_pages);
+	mem_end = PFN_PHYS(ini_nr_pages);
 
 	memmap.nr_entries = ARRAY_SIZE(xen_e820_table.entries);
 	set_xen_guest_handle(memmap.buffer, xen_e820_table.entries);
@@ -747,13 +855,35 @@ char * __init xen_memory_setup(void)
 	/* Make sure the Xen-supplied memory map is well-ordered. */
 	e820__update_table(&xen_e820_table);
 
+	/*
+	 * Check whether the kernel itself conflicts with the target E820 map.
+	 * Failing now is better than running into weird problems later due
+	 * to relocating (and even reusing) pages with kernel text or data.
+	 */
+	xen_chk_is_e820_usable(__pa_symbol(_text),
+			       __pa_symbol(_end) - __pa_symbol(_text),
+			       "kernel");
+
+	/*
+	 * Check for a conflict of the xen_start_info memory with the target
+	 * E820 map.
+	 */
+	xen_chk_is_e820_usable(__pa(xen_start_info), sizeof(*xen_start_info),
+			       "xen_start_info");
+
+	/*
+	 * Check for a conflict of the hypervisor supplied page tables with
+	 * the target E820 map.
+	 */
+	xen_pt_check_e820();
+
 	max_pages = xen_get_max_pages();
 
 	/* How many extra pages do we need due to remapping? */
-	max_pages += xen_foreach_remap_area(max_pfn, xen_count_remap_pages);
+	max_pages += xen_foreach_remap_area(xen_count_remap_pages);
 
-	if (max_pages > max_pfn)
-		extra_pages += max_pages - max_pfn;
+	if (max_pages > ini_nr_pages)
+		extra_pages += max_pages - ini_nr_pages;
 
 	/*
 	 * Clamp the amount of extra memory to a EXTRA_MEM_RATIO
@@ -762,8 +892,8 @@ char * __init xen_memory_setup(void)
 	 * Make sure we have no memory above max_pages, as this area
 	 * isn't handled by the p2m management.
 	 */
-	extra_pages = min3(EXTRA_MEM_RATIO * min(max_pfn, PFN_DOWN(MAXMEM)),
-			   extra_pages, max_pages - max_pfn);
+	maxmem_pages = EXTRA_MEM_RATIO * min(ini_nr_pages, PFN_DOWN(MAXMEM));
+	extra_pages = min3(maxmem_pages, extra_pages, max_pages - ini_nr_pages);
 	i = 0;
 	addr = xen_e820_table.entries[0].addr;
 	size = xen_e820_table.entries[0].size;
@@ -819,23 +949,6 @@ char * __init xen_memory_setup(void)
 
 	e820__update_table(e820_table);
 
-	/*
-	 * Check whether the kernel itself conflicts with the target E820 map.
-	 * Failing now is better than running into weird problems later due
-	 * to relocating (and even reusing) pages with kernel text or data.
-	 */
-	if (xen_is_e820_reserved(__pa_symbol(_text),
-			__pa_symbol(__bss_stop) - __pa_symbol(_text))) {
-		xen_raw_console_write("Xen hypervisor allocated kernel memory conflicts with E820 map\n");
-		BUG();
-	}
-
-	/*
-	 * Check for a conflict of the hypervisor supplied page tables with
-	 * the target E820 map.
-	 */
-	xen_pt_check_e820();
-
 	xen_reserve_xen_mfnlist();
 
 	/* Check for a conflict of the initrd with the target E820 map. */
@@ -863,7 +976,7 @@ char * __init xen_memory_setup(void)
 	 * Set identity map on non-RAM pages and prepare remapping the
 	 * underlying RAM.
 	 */
-	xen_foreach_remap_area(max_pfn, xen_set_identity_and_remap_chunk);
+	xen_foreach_remap_area(xen_set_identity_and_remap_chunk);
 
 	pr_info("Released %ld page(s)\n", xen_released_pages);
 
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 79cf93f2c92f..a6a21dd05527 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -43,8 +43,12 @@ void xen_mm_unpin_all(void);
 #ifdef CONFIG_X86_64
 void __init xen_relocate_p2m(void);
 #endif
+void __init xen_do_remap_nonram(void);
+void __init xen_add_remap_nonram(phys_addr_t maddr, phys_addr_t paddr,
+				 unsigned long size);
 
-bool __init xen_is_e820_reserved(phys_addr_t start, phys_addr_t size);
+void __init xen_chk_is_e820_usable(phys_addr_t start, phys_addr_t size,
+				   const char *component);
 unsigned long __ref xen_chk_extra_mem(unsigned long pfn);
 void __init xen_inv_extra_mem(void);
 void __init xen_remap_memory(void);
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4b88a54a9b76..05372a78cd51 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2911,8 +2911,12 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
 
 	/* if a merge has already been setup, then proceed with that first */
-	if (bfqq->new_bfqq)
-		return bfqq->new_bfqq;
+	new_bfqq = bfqq->new_bfqq;
+	if (new_bfqq) {
+		while (new_bfqq->new_bfqq)
+			new_bfqq = new_bfqq->new_bfqq;
+		return new_bfqq;
+	}
 
 	/*
 	 * Check delayed stable merge for rotational or non-queueing
@@ -3125,10 +3129,12 @@ void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_put_queue(bfqq);
 }
 
-static void
-bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
-		struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
+static struct bfq_queue *bfq_merge_bfqqs(struct bfq_data *bfqd,
+					 struct bfq_io_cq *bic,
+					 struct bfq_queue *bfqq)
 {
+	struct bfq_queue *new_bfqq = bfqq->new_bfqq;
+
 	bfq_log_bfqq(bfqd, bfqq, "merging with queue %lu",
 		(unsigned long)new_bfqq->pid);
 	/* Save weight raising and idle window of the merged queues */
@@ -3222,6 +3228,8 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 	bfq_reassign_last_bfqq(bfqq, new_bfqq);
 
 	bfq_release_process_ref(bfqd, bfqq);
+
+	return new_bfqq;
 }
 
 static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
@@ -3257,14 +3265,8 @@ static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 		 * fulfilled, i.e., bic can be redirected to new_bfqq
 		 * and bfqq can be put.
 		 */
-		bfq_merge_bfqqs(bfqd, bfqd->bio_bic, bfqq,
-				new_bfqq);
-		/*
-		 * If we get here, bio will be queued into new_queue,
-		 * so use new_bfqq to decide whether bio and rq can be
-		 * merged.
-		 */
-		bfqq = new_bfqq;
+		while (bfqq != new_bfqq)
+			bfqq = bfq_merge_bfqqs(bfqd, bfqd->bio_bic, bfqq);
 
 		/*
 		 * Change also bqfd->bio_bfqq, as
@@ -5699,9 +5701,7 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	 * state before killing it.
 	 */
 	bfqq->bic = bic;
-	bfq_merge_bfqqs(bfqd, bic, bfqq, new_bfqq);
-
-	return new_bfqq;
+	return bfq_merge_bfqqs(bfqd, bic, bfqq);
 }
 
 /*
@@ -6156,6 +6156,7 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 	bool waiting, idle_timer_disabled = false;
 
 	if (new_bfqq) {
+		struct bfq_queue *old_bfqq = bfqq;
 		/*
 		 * Release the request's reference to the old bfqq
 		 * and make sure one is taken to the shared queue.
@@ -6172,18 +6173,18 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 		 * new_bfqq.
 		 */
 		if (bic_to_bfqq(RQ_BIC(rq), true,
-				bfq_actuator_index(bfqd, rq->bio)) == bfqq)
-			bfq_merge_bfqqs(bfqd, RQ_BIC(rq),
-					bfqq, new_bfqq);
+				bfq_actuator_index(bfqd, rq->bio)) == bfqq) {
+			while (bfqq != new_bfqq)
+				bfqq = bfq_merge_bfqqs(bfqd, RQ_BIC(rq), bfqq);
+		}
 
-		bfq_clear_bfqq_just_created(bfqq);
+		bfq_clear_bfqq_just_created(old_bfqq);
 		/*
 		 * rq is about to be enqueued into new_bfqq,
 		 * release rq reference on bfqq
 		 */
-		bfq_put_queue(bfqq);
+		bfq_put_queue(old_bfqq);
 		rq->elv.priv[1] = new_bfqq;
-		bfqq = new_bfqq;
 	}
 
 	bfq_update_io_thinktime(bfqd, bfqq);
@@ -6721,7 +6722,7 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq)
 {
 	bfq_log_bfqq(bfqq->bfqd, bfqq, "splitting queue");
 
-	if (bfqq_process_refs(bfqq) == 1) {
+	if (bfqq_process_refs(bfqq) == 1 && !bfqq->new_bfqq) {
 		bfqq->pid = current->pid;
 		bfq_clear_bfqq_coop(bfqq);
 		bfq_clear_bfqq_split_coop(bfqq);
@@ -6819,6 +6820,31 @@ static void bfq_prepare_request(struct request *rq)
 	rq->elv.priv[0] = rq->elv.priv[1] = NULL;
 }
 
+static struct bfq_queue *bfq_waker_bfqq(struct bfq_queue *bfqq)
+{
+	struct bfq_queue *new_bfqq = bfqq->new_bfqq;
+	struct bfq_queue *waker_bfqq = bfqq->waker_bfqq;
+
+	if (!waker_bfqq)
+		return NULL;
+
+	while (new_bfqq) {
+		if (new_bfqq == waker_bfqq) {
+			/*
+			 * If waker_bfqq is in the merge chain, and current
+			 * is the only procress.
+			 */
+			if (bfqq_process_refs(waker_bfqq) == 1)
+				return NULL;
+			break;
+		}
+
+		new_bfqq = new_bfqq->new_bfqq;
+	}
+
+	return waker_bfqq;
+}
+
 /*
  * If needed, init rq, allocate bfq data structures associated with
  * rq, and increment reference counters in the destination bfq_queue
@@ -6880,7 +6906,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 		/* If the queue was seeky for too long, break it apart. */
 		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
 			!bic->bfqq_data[a_idx].stably_merged) {
-			struct bfq_queue *old_bfqq = bfqq;
+			struct bfq_queue *waker_bfqq = bfq_waker_bfqq(bfqq);
 
 			/* Update bic before losing reference to bfqq */
 			if (bfq_bfqq_in_large_burst(bfqq))
@@ -6900,7 +6926,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 				bfqq_already_existing = true;
 
 			if (!bfqq_already_existing) {
-				bfqq->waker_bfqq = old_bfqq->waker_bfqq;
+				bfqq->waker_bfqq = waker_bfqq;
 				bfqq->tentative_waker_bfqq = NULL;
 
 				/*
@@ -6910,7 +6936,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 				 * woken_list of the waker. See
 				 * bfq_check_waker for details.
 				 */
-				if (bfqq->waker_bfqq)
+				if (waker_bfqq)
 					hlist_add_head(&bfqq->woken_list_node,
 						       &bfqq->waker_bfqq->woken_list);
 			}
@@ -6932,7 +6958,8 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	 * addition, if the queue has also just been split, we have to
 	 * resume its state.
 	 */
-	if (likely(bfqq != &bfqd->oom_bfqq) && bfqq_process_refs(bfqq) == 1) {
+	if (likely(bfqq != &bfqd->oom_bfqq) && !bfqq->new_bfqq &&
+	    bfqq_process_refs(bfqq) == 1) {
 		bfqq->bic = bic;
 		if (split) {
 			/*
diff --git a/block/partitions/core.c b/block/partitions/core.c
index ab76e64f0f6c..5bd7a603092e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -555,9 +555,11 @@ static bool blk_add_partition(struct gendisk *disk,
 
 	part = add_partition(disk, p, from, size, state->parts[p].flags,
 			     &state->parts[p].info);
-	if (IS_ERR(part) && PTR_ERR(part) != -ENXIO) {
-		printk(KERN_ERR " %s: p%d could not be added: %pe\n",
-		       disk->disk_name, p, part);
+	if (IS_ERR(part)) {
+		if (PTR_ERR(part) != -ENXIO) {
+			printk(KERN_ERR " %s: p%d could not be added: %pe\n",
+			       disk->disk_name, p, part);
+		}
 		return true;
 	}
 
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index a5da8ccd353e..43af5fa510c0 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -60,17 +60,18 @@ struct key *find_asymmetric_key(struct key *keyring,
 	char *req, *p;
 	int len;
 
-	WARN_ON(!id_0 && !id_1 && !id_2);
-
 	if (id_0) {
 		lookup = id_0->data;
 		len = id_0->len;
 	} else if (id_1) {
 		lookup = id_1->data;
 		len = id_1->len;
-	} else {
+	} else if (id_2) {
 		lookup = id_2->data;
 		len = id_2->len;
+	} else {
+		WARN_ON(1);
+		return ERR_PTR(-EINVAL);
 	}
 
 	/* Construct an identifier "id:<keyid>". */
diff --git a/crypto/xor.c b/crypto/xor.c
index 8e72e5d5db0d..56aa3169e871 100644
--- a/crypto/xor.c
+++ b/crypto/xor.c
@@ -83,33 +83,30 @@ static void __init
 do_xor_speed(struct xor_block_template *tmpl, void *b1, void *b2)
 {
 	int speed;
-	int i, j;
-	ktime_t min, start, diff;
+	unsigned long reps;
+	ktime_t min, start, t0;
 
 	tmpl->next = template_list;
 	template_list = tmpl;
 
 	preempt_disable();
 
-	min = (ktime_t)S64_MAX;
-	for (i = 0; i < 3; i++) {
-		start = ktime_get();
-		for (j = 0; j < REPS; j++) {
-			mb(); /* prevent loop optimization */
-			tmpl->do_2(BENCH_SIZE, b1, b2);
-			mb();
-		}
-		diff = ktime_sub(ktime_get(), start);
-		if (diff < min)
-			min = diff;
-	}
+	reps = 0;
+	t0 = ktime_get();
+	/* delay start until time has advanced */
+	while ((start = ktime_get()) == t0)
+		cpu_relax();
+	do {
+		mb(); /* prevent loop optimization */
+		tmpl->do_2(BENCH_SIZE, b1, b2);
+		mb();
+	} while (reps++ < REPS || (t0 = ktime_get()) == start);
+	min = ktime_sub(t0, start);
 
 	preempt_enable();
 
 	// bytes/ns == GB/s, multiply by 1000 to get MB/s [not MiB/s]
-	if (!min)
-		min = 1;
-	speed = (1000 * REPS * BENCH_SIZE) / (unsigned int)ktime_to_ns(min);
+	speed = (1000 * reps * BENCH_SIZE) / (unsigned int)ktime_to_ns(min);
 	tmpl->speed = speed;
 
 	pr_info("   %-16s: %5d MB/sec\n", tmpl->name, speed);
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index f665ffd9a396..2c384bd52b9c 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -133,14 +133,15 @@ acpi_status acpi_ex_system_do_stall(u32 how_long_us)
 		 * (ACPI specifies 100 usec as max, but this gives some slack in
 		 * order to support existing BIOSs)
 		 */
-		ACPI_ERROR((AE_INFO,
-			    "Time parameter is too large (%u)", how_long_us));
+		ACPI_ERROR_ONCE((AE_INFO,
+				 "Time parameter is too large (%u)",
+				 how_long_us));
 		status = AE_AML_OPERAND_VALUE;
 	} else {
 		if (how_long_us > 100) {
-			ACPI_WARNING((AE_INFO,
-				      "Time parameter %u us > 100 us violating ACPI spec, please fix the firmware.",
-				      how_long_us));
+			ACPI_WARNING_ONCE((AE_INFO,
+					   "Time parameter %u us > 100 us violating ACPI spec, please fix the firmware.",
+					   how_long_us));
 		}
 		acpi_os_stall(how_long_us);
 	}
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1d857978f5f4..2a588e4ed4af 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -170,8 +170,11 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
 
 /* Shift and apply the mask for CPC reads/writes */
-#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) & 			\
+#define MASK_VAL_READ(reg, val) (((val) >> (reg)->bit_offset) &				\
 					GENMASK(((reg)->bit_width) - 1, 0))
+#define MASK_VAL_WRITE(reg, prev_val, val)						\
+	((((val) & GENMASK(((reg)->bit_width) - 1, 0)) << (reg)->bit_offset) |		\
+	((prev_val) & ~(GENMASK(((reg)->bit_width) - 1, 0) << (reg)->bit_offset)))	\
 
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
@@ -857,6 +860,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	/* Store CPU Logical ID */
 	cpc_ptr->cpu_id = pr->id;
+	spin_lock_init(&cpc_ptr->rmw_lock);
 
 	/* Parse PSD data for this CPU */
 	ret = acpi_get_psd(cpc_ptr, handle);
@@ -1062,7 +1066,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		*val = MASK_VAL(reg, *val);
+		*val = MASK_VAL_READ(reg, *val);
 
 	return 0;
 }
@@ -1071,9 +1075,11 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 {
 	int ret_val = 0;
 	int size;
+	u64 prev_val;
 	void __iomem *vaddr = NULL;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
+	struct cpc_desc *cpc_desc;
 
 	size = GET_BIT_WIDTH(reg);
 
@@ -1106,8 +1112,34 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
 				val, size);
 
-	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		val = MASK_VAL(reg, val);
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+		if (!cpc_desc) {
+			pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+			return -ENODEV;
+		}
+
+		spin_lock(&cpc_desc->rmw_lock);
+		switch (size) {
+		case 8:
+			prev_val = readb_relaxed(vaddr);
+			break;
+		case 16:
+			prev_val = readw_relaxed(vaddr);
+			break;
+		case 32:
+			prev_val = readl_relaxed(vaddr);
+			break;
+		case 64:
+			prev_val = readq_relaxed(vaddr);
+			break;
+		default:
+			spin_unlock(&cpc_desc->rmw_lock);
+			return -EFAULT;
+		}
+		val = MASK_VAL_WRITE(reg, prev_val, val);
+		val |= prev_val;
+	}
 
 	switch (size) {
 	case 8:
@@ -1134,6 +1166,9 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		break;
 	}
 
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		spin_unlock(&cpc_desc->rmw_lock);
+
 	return ret_val;
 }
 
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 23373faa35ec..95a19e3569c8 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -540,8 +540,9 @@ int acpi_device_setup_files(struct acpi_device *dev)
 	 * If device has _STR, 'description' file is created
 	 */
 	if (acpi_has_method(dev->handle, "_STR")) {
-		status = acpi_evaluate_object(dev->handle, "_STR",
-					NULL, &buffer);
+		status = acpi_evaluate_object_typed(dev->handle, "_STR",
+						    NULL, &buffer,
+						    ACPI_TYPE_BUFFER);
 		if (ACPI_FAILURE(status))
 			buffer.pointer = NULL;
 		dev->pnp.str_obj = buffer.pointer;
diff --git a/drivers/acpi/pmic/tps68470_pmic.c b/drivers/acpi/pmic/tps68470_pmic.c
index ebd03e472955..0d1a82eeb4b0 100644
--- a/drivers/acpi/pmic/tps68470_pmic.c
+++ b/drivers/acpi/pmic/tps68470_pmic.c
@@ -376,10 +376,8 @@ static int tps68470_pmic_opregion_probe(struct platform_device *pdev)
 	struct tps68470_pmic_opregion *opregion;
 	acpi_status status;
 
-	if (!dev || !tps68470_regmap) {
-		dev_warn(dev, "dev or regmap is NULL\n");
-		return -EINVAL;
-	}
+	if (!tps68470_regmap)
+		return dev_err_probe(dev, -EINVAL, "regmap is missing\n");
 
 	if (!handle) {
 		dev_warn(dev, "acpi handle is NULL\n");
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index df5d5a554b38..cb2aacbb9335 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -554,6 +554,12 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
  * to have a working keyboard.
  */
 static const struct dmi_system_id irq1_edge_low_force_override[] = {
+	{
+		/* MECHREV Jiaolong17KS Series GM7XG0M */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM7XG0M"),
+		},
+	},
 	{
 		/* XMG APEX 17 (M23) */
 		.matches = {
@@ -572,6 +578,12 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
 		},
 	},
+	{
+		/* TongFang GMxXGxX/TUXEDO Polaris 15 Gen5 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxX"),
+		},
+	},
 	{
 		/* TongFang GMxXGxx sold as Eluktronics Inc. RP-15 */
 		.matches = {
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index ff6f260433a1..75a5f559402f 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -541,6 +541,22 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple MacBook Air 9,1 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir9,1"),
+		},
+	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple MacBook Pro 9,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro9,2"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,
@@ -550,6 +566,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro12,1"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple MacBook Pro 16,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,2"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Dell Inspiron N4010 */
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 214b935c2ced..7df9ec9f924c 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -630,6 +630,14 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
 		struct ata_queued_cmd *qc;
 
+		/*
+		 * If the scmd was added to EH, via ata_qc_schedule_eh() ->
+		 * scsi_timeout() -> scsi_eh_scmd_add(), scsi_timeout() will
+		 * have set DID_TIME_OUT (since libata does not have an abort
+		 * handler). Thus, to clear DID_TIME_OUT, clear the host byte.
+		 */
+		set_host_byte(scmd, DID_OK);
+
 		ata_qc_for_each_raw(ap, qc, i) {
 			if (qc->flags & ATA_QCFLAG_ACTIVE &&
 			    qc->scsicmd == scmd)
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4116ae088719..0cbe331124c2 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1693,9 +1693,6 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
 	} else if (is_error && !have_sense) {
 		ata_gen_ata_sense(qc);
-	} else {
-		/* Keep the SCSI ML and status byte, clear host byte. */
-		cmd->result &= 0x0000ffff;
 	}
 
 	ata_qc_done(qc);
@@ -2361,7 +2358,7 @@ static unsigned int ata_msense_control(struct ata_device *dev, u8 *buf,
 	case ALL_SUB_MPAGES:
 		n = ata_msense_control_spg0(dev, buf, changeable);
 		n += ata_msense_control_spgt2(dev, buf + n, CDL_T2A_SUB_MPAGE);
-		n += ata_msense_control_spgt2(dev, buf + n, CDL_T2A_SUB_MPAGE);
+		n += ata_msense_control_spgt2(dev, buf + n, CDL_T2B_SUB_MPAGE);
 		n += ata_msense_control_ata_feature(dev, buf + n);
 		return n;
 	default:
diff --git a/drivers/base/core.c b/drivers/base/core.c
index b5399262198a..6c1a944c00d9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4515,9 +4515,11 @@ EXPORT_SYMBOL_GPL(device_destroy);
  */
 int device_rename(struct device *dev, const char *new_name)
 {
+	struct subsys_private *sp = NULL;
 	struct kobject *kobj = &dev->kobj;
 	char *old_device_name = NULL;
 	int error;
+	bool is_link_renamed = false;
 
 	dev = get_device(dev);
 	if (!dev)
@@ -4532,7 +4534,7 @@ int device_rename(struct device *dev, const char *new_name)
 	}
 
 	if (dev->class) {
-		struct subsys_private *sp = class_to_subsys(dev->class);
+		sp = class_to_subsys(dev->class);
 
 		if (!sp) {
 			error = -EINVAL;
@@ -4541,16 +4543,19 @@ int device_rename(struct device *dev, const char *new_name)
 
 		error = sysfs_rename_link_ns(&sp->subsys.kobj, kobj, old_device_name,
 					     new_name, kobject_namespace(kobj));
-		subsys_put(sp);
 		if (error)
 			goto out;
+
+		is_link_renamed = true;
 	}
 
 	error = kobject_rename(kobj, new_name);
-	if (error)
-		goto out;
-
 out:
+	if (error && is_link_renamed)
+		sysfs_rename_link_ns(&sp->subsys.kobj, kobj, new_name,
+				     old_device_name, kobject_namespace(kobj));
+	subsys_put(sp);
+
 	put_device(dev);
 
 	kfree(old_device_name);
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index da8ca01d011c..0989a62962d3 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -849,6 +849,26 @@ static void fw_log_firmware_info(const struct firmware *fw, const char *name,
 {}
 #endif
 
+/*
+ * Reject firmware file names with ".." path components.
+ * There are drivers that construct firmware file names from device-supplied
+ * strings, and we don't want some device to be able to tell us "I would like to
+ * be sent my firmware from ../../../etc/shadow, please".
+ *
+ * Search for ".." surrounded by either '/' or start/end of string.
+ *
+ * This intentionally only looks at the firmware name, not at the firmware base
+ * directory or at symlink contents.
+ */
+static bool name_contains_dotdot(const char *name)
+{
+	size_t name_len = strlen(name);
+
+	return strcmp(name, "..") == 0 || strncmp(name, "../", 3) == 0 ||
+	       strstr(name, "/../") != NULL ||
+	       (name_len >= 3 && strcmp(name+name_len-3, "/..") == 0);
+}
+
 /* called from request_firmware() and request_firmware_work_func() */
 static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
@@ -869,6 +889,14 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		goto out;
 	}
 
+	if (name_contains_dotdot(name)) {
+		dev_warn(device,
+			 "Firmware load for '%s' refused, path contains '..' component\n",
+			 name);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ret = _request_firmware_prepare(&fw, name, device, buf, size,
 					offset, opt_flags);
 	if (ret <= 0) /* error or already assigned */
@@ -946,6 +974,8 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
  *      @name will be used as $FIRMWARE in the uevent environment and
  *      should be distinctive enough not to be confused with any other
  *      firmware image for this or any other device.
+ *	It must not contain any ".." path components - "foo/bar..bin" is
+ *	allowed, but "foo/../bar.bin" is not.
  *
  *	Caller must hold the reference count of @device.
  *
diff --git a/drivers/base/module.c b/drivers/base/module.c
index b0b79b9c189d..0d5c5da367f7 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -66,27 +66,31 @@ int module_add_driver(struct module *mod, struct device_driver *drv)
 	driver_name = make_driver_name(drv);
 	if (!driver_name) {
 		ret = -ENOMEM;
-		goto out;
+		goto out_remove_kobj;
 	}
 
 	module_create_drivers_dir(mk);
 	if (!mk->drivers_dir) {
 		ret = -EINVAL;
-		goto out;
+		goto out_free_driver_name;
 	}
 
 	ret = sysfs_create_link(mk->drivers_dir, &drv->p->kobj, driver_name);
 	if (ret)
-		goto out;
+		goto out_remove_drivers_dir;
 
 	kfree(driver_name);
 
 	return 0;
-out:
-	sysfs_remove_link(&drv->p->kobj, "module");
+
+out_remove_drivers_dir:
 	sysfs_remove_link(mk->drivers_dir, driver_name);
+
+out_free_driver_name:
 	kfree(driver_name);
 
+out_remove_kobj:
+	sysfs_remove_link(&drv->p->kobj, "module");
 	return ret;
 }
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 113b441d4d36..301843297fb7 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3399,10 +3399,12 @@ void drbd_uuid_new_current(struct drbd_device *device) __must_hold(local)
 void drbd_uuid_set_bm(struct drbd_device *device, u64 val) __must_hold(local)
 {
 	unsigned long flags;
-	if (device->ldev->md.uuid[UI_BITMAP] == 0 && val == 0)
+	spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
+	if (device->ldev->md.uuid[UI_BITMAP] == 0 && val == 0) {
+		spin_unlock_irqrestore(&device->ldev->md.uuid_lock, flags);
 		return;
+	}
 
-	spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
 	if (val == 0) {
 		drbd_uuid_move_history(device);
 		device->ldev->md.uuid[UI_HISTORY_START] = device->ldev->md.uuid[UI_BITMAP];
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index e858e7e0383f..c2b6c4d9729d 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -876,7 +876,7 @@ is_valid_state(struct drbd_device *device, union drbd_state ns)
 		  ns.disk == D_OUTDATED)
 		rv = SS_CONNECTED_OUTDATES;
 
-	else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
+	else if (nc && (ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
 		 (nc->verify_alg[0] == 0))
 		rv = SS_NO_VERIFY_ALG;
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b87aa80a46dd..d4e260d32180 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -181,6 +181,17 @@ static void nbd_requeue_cmd(struct nbd_cmd *cmd)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
 
+	lockdep_assert_held(&cmd->lock);
+
+	/*
+	 * Clear INFLIGHT flag so that this cmd won't be completed in
+	 * normal completion path
+	 *
+	 * INFLIGHT flag will be set when the cmd is queued to nbd next
+	 * time.
+	 */
+	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
+
 	if (!test_and_set_bit(NBD_CMD_REQUEUED, &cmd->flags))
 		blk_mq_requeue_request(req, true);
 }
@@ -339,7 +350,7 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 
 	lim = queue_limits_start_update(nbd->disk->queue);
 	if (nbd->config->flags & NBD_FLAG_SEND_TRIM)
-		lim.max_hw_discard_sectors = UINT_MAX;
+		lim.max_hw_discard_sectors = UINT_MAX >> SECTOR_SHIFT;
 	else
 		lim.max_hw_discard_sectors = 0;
 	lim.logical_block_size = blksize;
@@ -480,8 +491,8 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
 					nbd_mark_nsock_dead(nbd, nsock, 1);
 				mutex_unlock(&nsock->tx_lock);
 			}
-			mutex_unlock(&cmd->lock);
 			nbd_requeue_cmd(cmd);
+			mutex_unlock(&cmd->lock);
 			nbd_config_put(nbd);
 			return BLK_EH_DONE;
 		}
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index fc001e9f95f6..d06c8ed29620 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -71,9 +71,6 @@ struct ublk_rq_data {
 	struct llist_node node;
 
 	struct kref ref;
-	__u64 sector;
-	__u32 operation;
-	__u32 nr_zones;
 };
 
 struct ublk_uring_cmd_pdu {
@@ -214,6 +211,33 @@ static inline bool ublk_queue_is_zoned(struct ublk_queue *ubq)
 
 #ifdef CONFIG_BLK_DEV_ZONED
 
+struct ublk_zoned_report_desc {
+	__u64 sector;
+	__u32 operation;
+	__u32 nr_zones;
+};
+
+static DEFINE_XARRAY(ublk_zoned_report_descs);
+
+static int ublk_zoned_insert_report_desc(const struct request *req,
+		struct ublk_zoned_report_desc *desc)
+{
+	return xa_insert(&ublk_zoned_report_descs, (unsigned long)req,
+			    desc, GFP_KERNEL);
+}
+
+static struct ublk_zoned_report_desc *ublk_zoned_erase_report_desc(
+		const struct request *req)
+{
+	return xa_erase(&ublk_zoned_report_descs, (unsigned long)req);
+}
+
+static struct ublk_zoned_report_desc *ublk_zoned_get_report_desc(
+		const struct request *req)
+{
+	return xa_load(&ublk_zoned_report_descs, (unsigned long)req);
+}
+
 static int ublk_get_nr_zones(const struct ublk_device *ub)
 {
 	const struct ublk_param_basic *p = &ub->params.basic;
@@ -310,7 +334,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 		unsigned int zones_in_request =
 			min_t(unsigned int, remaining_zones, max_zones_per_request);
 		struct request *req;
-		struct ublk_rq_data *pdu;
+		struct ublk_zoned_report_desc desc;
 		blk_status_t status;
 
 		memset(buffer, 0, buffer_length);
@@ -321,20 +345,23 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 			goto out;
 		}
 
-		pdu = blk_mq_rq_to_pdu(req);
-		pdu->operation = UBLK_IO_OP_REPORT_ZONES;
-		pdu->sector = sector;
-		pdu->nr_zones = zones_in_request;
+		desc.operation = UBLK_IO_OP_REPORT_ZONES;
+		desc.sector = sector;
+		desc.nr_zones = zones_in_request;
+		ret = ublk_zoned_insert_report_desc(req, &desc);
+		if (ret)
+			goto free_req;
 
 		ret = blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
 					GFP_KERNEL);
-		if (ret) {
-			blk_mq_free_request(req);
-			goto out;
-		}
+		if (ret)
+			goto erase_desc;
 
 		status = blk_execute_rq(req, 0);
 		ret = blk_status_to_errno(status);
+erase_desc:
+		ublk_zoned_erase_report_desc(req);
+free_req:
 		blk_mq_free_request(req);
 		if (ret)
 			goto out;
@@ -368,7 +395,7 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 {
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
 	struct ublk_io *io = &ubq->ios[req->tag];
-	struct ublk_rq_data *pdu = blk_mq_rq_to_pdu(req);
+	struct ublk_zoned_report_desc *desc;
 	u32 ublk_op;
 
 	switch (req_op(req)) {
@@ -391,12 +418,15 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 		ublk_op = UBLK_IO_OP_ZONE_RESET_ALL;
 		break;
 	case REQ_OP_DRV_IN:
-		ublk_op = pdu->operation;
+		desc = ublk_zoned_get_report_desc(req);
+		if (!desc)
+			return BLK_STS_IOERR;
+		ublk_op = desc->operation;
 		switch (ublk_op) {
 		case UBLK_IO_OP_REPORT_ZONES:
 			iod->op_flags = ublk_op | ublk_req_build_flags(req);
-			iod->nr_zones = pdu->nr_zones;
-			iod->start_sector = pdu->sector;
+			iod->nr_zones = desc->nr_zones;
+			iod->start_sector = desc->sector;
 			return BLK_STS_OK;
 		default:
 			return BLK_STS_IOERR;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0927f51867c2..c41b86608ba8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1393,7 +1393,10 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	if (!urb)
 		return -ENOMEM;
 
-	size = le16_to_cpu(data->intr_ep->wMaxPacketSize);
+	/* Use maximum HCI Event size so the USB stack handles
+	 * ZPL/short-transfer automatically.
+	 */
+	size = HCI_MAX_EVENT_SIZE;
 
 	buf = kmalloc(size, mem_flags);
 	if (!buf) {
diff --git a/drivers/bus/arm-integrator-lm.c b/drivers/bus/arm-integrator-lm.c
index b715c8ab36e8..a65c79b08804 100644
--- a/drivers/bus/arm-integrator-lm.c
+++ b/drivers/bus/arm-integrator-lm.c
@@ -85,6 +85,7 @@ static int integrator_ap_lm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 	map = syscon_node_to_regmap(syscon);
+	of_node_put(syscon);
 	if (IS_ERR(map)) {
 		dev_err(dev,
 			"could not find Integrator/AP system controller\n");
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 08844ee79654..edb54c979928 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -606,6 +606,15 @@ static const struct mhi_pci_dev_info mhi_telit_fn990_info = {
 	.mru_default = 32768,
 };
 
+static const struct mhi_pci_dev_info mhi_telit_fe990a_info = {
+	.name = "telit-fe990a",
+	.config = &modem_telit_fn990_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.sideband_wake = false,
+	.mru_default = 32768,
+};
+
 /* Keep the list sorted based on the PID. New VID should be added as the last entry */
 static const struct pci_device_id mhi_pci_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
@@ -623,9 +632,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	/* Telit FN990 */
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0308, 0x1c5d, 0x2010),
 		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
-	/* Telit FE990 */
+	/* Telit FE990A */
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0308, 0x1c5d, 0x2015),
-		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
+		.driver_data = (kernel_ulong_t) &mhi_telit_fe990a_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index b03e80300627..aa2b135e3ee2 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -94,8 +94,10 @@ static int bcm2835_rng_init(struct hwrng *rng)
 		return ret;
 
 	ret = reset_control_reset(priv->reset);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(priv->clk);
 		return ret;
+	}
 
 	if (priv->mask_interrupts) {
 		/* mask the interrupt */
diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index c0d2f824769f..4c50efc46483 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -622,6 +622,7 @@ static int __maybe_unused cctrng_resume(struct device *dev)
 	/* wait for Cryptocell reset completion */
 	if (!cctrng_wait_for_reset_completion(drvdata)) {
 		dev_err(dev, "Cryptocell reset not completed");
+		clk_disable_unprepare(drvdata->clk);
 		return -EBUSY;
 	}
 
diff --git a/drivers/char/hw_random/mtk-rng.c b/drivers/char/hw_random/mtk-rng.c
index aa993753ab12..1e3048f2bb38 100644
--- a/drivers/char/hw_random/mtk-rng.c
+++ b/drivers/char/hw_random/mtk-rng.c
@@ -142,7 +142,7 @@ static int mtk_rng_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, priv);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, RNG_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+	devm_pm_runtime_enable(&pdev->dev);
 
 	dev_info(&pdev->dev, "registered RNG driver\n");
 
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 30b4c288c1bb..c3fbbf4d3db7 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -47,6 +47,8 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
 
 	if (!ret)
 		ret = tpm2_commit_space(chip, space, buf, &len);
+	else
+		tpm2_flush_space(chip);
 
 out_rc:
 	return ret ? ret : len;
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index d3521aadd43e..44f60730cff4 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1362,4 +1362,5 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 
 	return rc;
 }
+EXPORT_SYMBOL(tpm2_sessions_init);
 #endif /* CONFIG_TCG_TPM2_HMAC */
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 4892d491da8d..25a66870c165 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -169,6 +169,9 @@ void tpm2_flush_space(struct tpm_chip *chip)
 	struct tpm_space *space = &chip->work_space;
 	int i;
 
+	if (!space)
+		return;
+
 	for (i = 0; i < ARRAY_SIZE(space->context_tbl); i++)
 		if (space->context_tbl[i] && ~space->context_tbl[i])
 			tpm2_flush_context(chip, space->context_tbl[i]);
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 91b5c6f14819..4e9594714b14 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -66,6 +66,7 @@ enum pll_component_id {
 	PLL_COMPID_FRAC,
 	PLL_COMPID_DIV0,
 	PLL_COMPID_DIV1,
+	PLL_COMPID_MAX,
 };
 
 /*
@@ -165,7 +166,7 @@ static struct sama7g5_pll {
 	u8 t;
 	u8 eid;
 	u8 safe_div;
-} sama7g5_plls[][PLL_ID_MAX] = {
+} sama7g5_plls[][PLL_COMPID_MAX] = {
 	[PLL_ID_CPU] = {
 		[PLL_COMPID_FRAC] = {
 			.n = "cpupll_fracck",
@@ -1038,7 +1039,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	sama7g5_pmc->chws[PMC_MAIN] = hw;
 
 	for (i = 0; i < PLL_ID_MAX; i++) {
-		for (j = 0; j < 3; j++) {
+		for (j = 0; j < PLL_COMPID_MAX; j++) {
 			struct clk_hw *parent_hw;
 
 			if (!sama7g5_plls[i][j].n)
diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-composite-7ulp.c
index e208ddc51133..db7f40b07d1a 100644
--- a/drivers/clk/imx/clk-composite-7ulp.c
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -14,6 +14,7 @@
 #include "../clk-fractional-divider.h"
 #include "clk.h"
 
+#define PCG_PR_MASK		BIT(31)
 #define PCG_PCS_SHIFT	24
 #define PCG_PCS_MASK	0x7
 #define PCG_CGC_SHIFT	30
@@ -78,6 +79,12 @@ static struct clk_hw *imx_ulp_clk_hw_composite(const char *name,
 	struct clk_hw *hw;
 	u32 val;
 
+	val = readl(reg);
+	if (!(val & PCG_PR_MASK)) {
+		pr_info("PCC PR is 0 for clk:%s, bypass\n", name);
+		return 0;
+	}
+
 	if (mux_present) {
 		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 		if (!mux)
diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 8cc07d056a83..f187582ba491 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -204,6 +204,34 @@ static const struct clk_ops imx8m_clk_composite_mux_ops = {
 	.determine_rate = imx8m_clk_composite_mux_determine_rate,
 };
 
+static int imx8m_clk_composite_gate_enable(struct clk_hw *hw)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	val = readl(gate->reg);
+	val |= BIT(gate->bit_idx);
+	writel(val, gate->reg);
+
+	spin_unlock_irqrestore(gate->lock, flags);
+
+	return 0;
+}
+
+static void imx8m_clk_composite_gate_disable(struct clk_hw *hw)
+{
+	/* composite clk requires the disable hook */
+}
+
+static const struct clk_ops imx8m_clk_composite_gate_ops = {
+	.enable = imx8m_clk_composite_gate_enable,
+	.disable = imx8m_clk_composite_gate_disable,
+	.is_enabled = clk_gate_is_enabled,
+};
+
 struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 					const char * const *parent_names,
 					int num_parents, void __iomem *reg,
@@ -217,6 +245,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	struct clk_mux *mux;
 	const struct clk_ops *divider_ops;
 	const struct clk_ops *mux_ops;
+	const struct clk_ops *gate_ops;
 
 	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -257,20 +286,22 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
 
 	/* skip registering the gate ops if M4 is enabled */
-	if (!mcore_booted) {
-		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
-		if (!gate)
-			goto free_div;
-
-		gate_hw = &gate->hw;
-		gate->reg = reg;
-		gate->bit_idx = PCG_CGC_SHIFT;
-		gate->lock = &imx_ccm_lock;
-	}
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		goto free_div;
+
+	gate_hw = &gate->hw;
+	gate->reg = reg;
+	gate->bit_idx = PCG_CGC_SHIFT;
+	gate->lock = &imx_ccm_lock;
+	if (!mcore_booted)
+		gate_ops = &clk_gate_ops;
+	else
+		gate_ops = &imx8m_clk_composite_gate_ops;
 
 	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
 			mux_hw, mux_ops, div_hw,
-			divider_ops, gate_hw, &clk_gate_ops, flags);
+			divider_ops, gate_hw, gate_ops, flags);
 	if (IS_ERR(hw))
 		goto free_gate;
 
diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
index 81164bdcd6cc..6c6c5a30f328 100644
--- a/drivers/clk/imx/clk-composite-93.c
+++ b/drivers/clk/imx/clk-composite-93.c
@@ -76,6 +76,13 @@ static int imx93_clk_composite_gate_enable(struct clk_hw *hw)
 
 static void imx93_clk_composite_gate_disable(struct clk_hw *hw)
 {
+	/*
+	 * Skip disable the root clock gate if mcore enabled.
+	 * The root clock may be used by the mcore.
+	 */
+	if (mcore_booted)
+		return;
+
 	imx93_clk_composite_gate_endisable(hw, 0);
 }
 
@@ -222,7 +229,7 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
 					       mux_hw, &clk_mux_ro_ops, div_hw,
 					       &clk_divider_ro_ops, NULL, NULL, flags);
-	} else if (!mcore_booted) {
+	} else {
 		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
 		if (!gate)
 			goto fail;
@@ -238,12 +245,6 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 					       &imx93_clk_composite_divider_ops, gate_hw,
 					       &imx93_clk_composite_gate_ops,
 					       flags | CLK_SET_RATE_NO_REPARENT);
-	} else {
-		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
-					       mux_hw, &imx93_clk_composite_mux_ops, div_hw,
-					       &imx93_clk_composite_divider_ops, NULL,
-					       &imx93_clk_composite_gate_ops,
-					       flags | CLK_SET_RATE_NO_REPARENT);
 	}
 
 	if (IS_ERR(hw))
diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 44462ab50e51..1becba2b62d0 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -291,6 +291,10 @@ static int clk_fracn_gppll_prepare(struct clk_hw *hw)
 	if (val & POWERUP_MASK)
 		return 0;
 
+	if (pll->flags & CLK_FRACN_GPPLL_FRACN)
+		writel_relaxed(readl_relaxed(pll->base + PLL_NUMERATOR),
+			       pll->base + PLL_NUMERATOR);
+
 	val |= CLKMUX_BYPASS;
 	writel_relaxed(val, pll->base + PLL_CTRL);
 
diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index f9394e94f69d..05c7a82b751f 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -542,8 +542,8 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 
 	clk_set_parent(hws[IMX6UL_CLK_ENFC_SEL]->clk, hws[IMX6UL_CLK_PLL2_PFD2]->clk);
 
-	clk_set_parent(hws[IMX6UL_CLK_ENET1_REF_SEL]->clk, hws[IMX6UL_CLK_ENET_REF]->clk);
-	clk_set_parent(hws[IMX6UL_CLK_ENET2_REF_SEL]->clk, hws[IMX6UL_CLK_ENET2_REF]->clk);
+	clk_set_parent(hws[IMX6UL_CLK_ENET1_REF_SEL]->clk, hws[IMX6UL_CLK_ENET1_REF_125M]->clk);
+	clk_set_parent(hws[IMX6UL_CLK_ENET2_REF_SEL]->clk, hws[IMX6UL_CLK_ENET2_REF_125M]->clk);
 
 	imx_register_uart_clocks();
 }
diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index b381d6f784c8..0767d613b68b 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -154,6 +154,15 @@ static const struct clk_parent_data clk_imx8mp_audiomix_pll_bypass_sels[] = {
 		PDM_SEL, 2, 0						\
 	}
 
+#define CLK_GATE_PARENT(gname, cname, pname)						\
+	{								\
+		gname"_cg",						\
+		IMX8MP_CLK_AUDIOMIX_##cname,				\
+		{ .fw_name = pname, .name = pname }, NULL, 1,		\
+		CLKEN0 + 4 * !!(IMX8MP_CLK_AUDIOMIX_##cname / 32),	\
+		1, IMX8MP_CLK_AUDIOMIX_##cname % 32			\
+	}
+
 struct clk_imx8mp_audiomix_sel {
 	const char			*name;
 	int				clkid;
@@ -171,14 +180,14 @@ static struct clk_imx8mp_audiomix_sel sels[] = {
 	CLK_GATE("earc", EARC_IPG),
 	CLK_GATE("ocrama", OCRAMA_IPG),
 	CLK_GATE("aud2htx", AUD2HTX_IPG),
-	CLK_GATE("earc_phy", EARC_PHY),
+	CLK_GATE_PARENT("earc_phy", EARC_PHY, "sai_pll_out_div2"),
 	CLK_GATE("sdma2", SDMA2_ROOT),
 	CLK_GATE("sdma3", SDMA3_ROOT),
 	CLK_GATE("spba2", SPBA2_ROOT),
 	CLK_GATE("dsp", DSP_ROOT),
 	CLK_GATE("dspdbg", DSPDBG_ROOT),
 	CLK_GATE("edma", EDMA_ROOT),
-	CLK_GATE("audpll", AUDPLL_ROOT),
+	CLK_GATE_PARENT("audpll", AUDPLL_ROOT, "osc_24m"),
 	CLK_GATE("mu2", MU2_ROOT),
 	CLK_GATE("mu3", MU3_ROOT),
 	CLK_PDM,
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 670aa2bab301..e561ff7b135f 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -551,8 +551,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
 
-	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
-	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
+	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
+	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
 	hws[IMX8MP_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mp_vpu_g1_sels, ccm_base + 0xa100);
 	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
 	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 7d8883916cac..83f2e8bd6d50 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -170,8 +170,8 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_scu("pwm_clk",   IMX_SC_R_LCD_0_PWM_0, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("elcdif_pll", IMX_SC_R_ELCDIF_PLL, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu2("lcd_clk", lcd_sels, ARRAY_SIZE(lcd_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_PER);
-	imx_clk_scu2("lcd_pxl_clk", lcd_pxl_sels, ARRAY_SIZE(lcd_pxl_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_MISC0);
 	imx_clk_scu("lcd_pxl_bypass_div_clk", IMX_SC_R_LCD_0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("lcd_pxl_clk", lcd_pxl_sels, ARRAY_SIZE(lcd_pxl_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_MISC0);
 
 	/* Audio SS */
 	imx_clk_scu("audio_pll0_clk", IMX_SC_R_AUDIO_PLL_0, IMX_SC_PM_CLK_PLL);
@@ -206,18 +206,18 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_scu("usb3_lpm_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_MISC);
 
 	/* Display controller SS */
-	imx_clk_scu2("dc0_disp0_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC0);
-	imx_clk_scu2("dc0_disp1_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc0_pll0_clk", IMX_SC_R_DC_0_PLL_0, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc0_pll1_clk", IMX_SC_R_DC_0_PLL_1, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc0_bypass0_clk", IMX_SC_R_DC_0_VIDEO0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("dc0_disp0_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC0);
+	imx_clk_scu2("dc0_disp1_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc0_bypass1_clk", IMX_SC_R_DC_0_VIDEO1, IMX_SC_PM_CLK_BYPASS);
 
-	imx_clk_scu2("dc1_disp0_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC0);
-	imx_clk_scu2("dc1_disp1_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc1_pll0_clk", IMX_SC_R_DC_1_PLL_0, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc1_pll1_clk", IMX_SC_R_DC_1_PLL_1, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc1_bypass0_clk", IMX_SC_R_DC_1_VIDEO0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("dc1_disp0_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC0);
+	imx_clk_scu2("dc1_disp1_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc1_bypass1_clk", IMX_SC_R_DC_1_VIDEO1, IMX_SC_PM_CLK_BYPASS);
 
 	/* MIPI-LVDS SS */
diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 25a7b4b15c56..2720cbc40e0a 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1784,6 +1784,58 @@ const struct clk_ops clk_alpha_pll_agera_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_agera_ops);
 
+/**
+ * clk_lucid_5lpe_pll_configure - configure the lucid 5lpe pll
+ *
+ * @pll: clk alpha pll
+ * @regmap: register map
+ * @config: configuration to apply for pll
+ */
+void clk_lucid_5lpe_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				  const struct alpha_pll_config *config)
+{
+	/*
+	 * If the bootloader left the PLL enabled it's likely that there are
+	 * RCGs that will lock up if we disable the PLL below.
+	 */
+	if (trion_pll_is_enabled(pll, regmap)) {
+		pr_debug("Lucid 5LPE PLL is already enabled, skipping configuration\n");
+		return;
+	}
+
+	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
+	regmap_write(regmap, PLL_CAL_L_VAL(pll), TRION_PLL_CAL_VAL);
+	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll),
+				     config->config_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll),
+				     config->config_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U1(pll),
+				     config->config_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll),
+					config->user_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U(pll),
+					config->user_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U1(pll),
+					config->user_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll),
+					config->test_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll),
+					config->test_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll),
+					config->test_ctl_hi1_val);
+
+	/* Disable PLL output */
+	regmap_update_bits(regmap, PLL_MODE(pll),  PLL_OUTCTRL, 0);
+
+	/* Set operation mode to OFF */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+
+	/* Place the PLL in STANDBY mode */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+}
+EXPORT_SYMBOL_GPL(clk_lucid_5lpe_pll_configure);
+
 static int alpha_pll_lucid_5lpe_enable(struct clk_hw *hw)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index c7055b6c42f1..d89ec4723e2d 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -205,6 +205,8 @@ void clk_agera_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 
 void clk_zonda_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 			     const struct alpha_pll_config *config);
+void clk_lucid_5lpe_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				  const struct alpha_pll_config *config);
 void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 				 const struct alpha_pll_config *config);
 void clk_lucid_ole_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index 43307c8a342c..2103e22ca3dd 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -1357,8 +1357,13 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
 		disp_cc_sm8250_clocks[DISP_CC_MDSS_EDP_GTC_CLK_SRC] = NULL;
 	}
 
-	clk_lucid_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
-	clk_lucid_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
+	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8350-dispcc")) {
+		clk_lucid_5lpe_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
+		clk_lucid_5lpe_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
+	} else {
+		clk_lucid_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
+		clk_lucid_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
+	}
 
 	/* Enable clock gating for MDP clocks */
 	regmap_update_bits(regmap, 0x8000, 0x10, 0x10);
diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index 38ecea805503..1ba01bdb763b 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -196,7 +196,7 @@ static const struct clk_parent_data disp_cc_parent_data_3[] = {
 static const struct parent_map disp_cc_parent_map_4[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_DP0_PHY_PLL_LINK_CLK, 1 },
-	{ P_DP1_PHY_PLL_VCO_DIV_CLK, 2 },
+	{ P_DP0_PHY_PLL_VCO_DIV_CLK, 2 },
 	{ P_DP3_PHY_PLL_VCO_DIV_CLK, 3 },
 	{ P_DP1_PHY_PLL_VCO_DIV_CLK, 4 },
 	{ P_DP2_PHY_PLL_VCO_DIV_CLK, 6 },
@@ -213,7 +213,7 @@ static const struct clk_parent_data disp_cc_parent_data_4[] = {
 
 static const struct parent_map disp_cc_parent_map_5[] = {
 	{ P_BI_TCXO, 0 },
-	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 4 },
+	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 2 },
 	{ P_DSI1_PHY_PLL_OUT_BYTECLK, 4 },
 };
 
@@ -400,7 +400,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_aux_clk_src = {
 		.parent_data = disp_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_dp_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -562,7 +562,7 @@ static struct clk_rcg2 disp_cc_mdss_esc0_clk_src = {
 		.parent_data = disp_cc_parent_data_5,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -577,7 +577,7 @@ static struct clk_rcg2 disp_cc_mdss_esc1_clk_src = {
 		.parent_data = disp_cc_parent_data_5,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1611,7 +1611,7 @@ static struct gdsc mdss_gdsc = {
 		.name = "mdss_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.flags = POLL_CFG_GDSCR | HW_CTRL | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc mdss_int2_gdsc = {
@@ -1620,7 +1620,7 @@ static struct gdsc mdss_int2_gdsc = {
 		.name = "mdss_int2_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.flags = POLL_CFG_GDSCR | HW_CTRL | RETAIN_FF_ENABLE,
 };
 
 static struct clk_regmap *disp_cc_sm8550_clocks[] = {
diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index f98591148a97..6a4877d88829 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -3388,6 +3388,7 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
 	[GCC_QDSS_DAP_DIV_CLK_SRC] = &gcc_qdss_dap_div_clk_src.clkr,
 	[GCC_QDSS_ETR_USB_CLK] = &gcc_qdss_etr_usb_clk.clkr,
 	[GCC_QDSS_EUD_AT_CLK] = &gcc_qdss_eud_at_clk.clkr,
+	[GCC_QDSS_TSCTR_CLK_SRC] = &gcc_qdss_tsctr_clk_src.clkr,
 	[GCC_QPIC_AHB_CLK] = &gcc_qpic_ahb_clk.clkr,
 	[GCC_QPIC_CLK] = &gcc_qpic_clk.clkr,
 	[GCC_QPIC_IO_MACRO_CLK] = &gcc_qpic_io_macro_clk.clkr,
diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index a24a35553e13..7343d2d7676b 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -409,7 +409,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(29), 0, 3, DFLAGS),
 	DIV(0, "sclk_vop_pre", "sclk_vop_src", 0,
 			RK2928_CLKSEL_CON(27), 8, 8, DFLAGS),
-	MUX(DCLK_VOP, "dclk_vop", mux_dclk_vop_p, 0,
+	MUX(DCLK_VOP, "dclk_vop", mux_dclk_vop_p, CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			RK2928_CLKSEL_CON(27), 1, 1, MFLAGS),
 
 	FACTOR(0, "xin12m", "xin24m", 0, 1, 2),
diff --git a/drivers/clk/rockchip/clk-rk3588.c b/drivers/clk/rockchip/clk-rk3588.c
index b30279a96dc8..3027379f2fdd 100644
--- a/drivers/clk/rockchip/clk-rk3588.c
+++ b/drivers/clk/rockchip/clk-rk3588.c
@@ -526,7 +526,7 @@ PNAME(pmu_200m_100m_p)			= { "clk_pmu1_200m_src", "clk_pmu1_100m_src" };
 PNAME(pmu_300m_24m_p)			= { "clk_300m_src", "xin24m" };
 PNAME(pmu_400m_24m_p)			= { "clk_400m_src", "xin24m" };
 PNAME(pmu_100m_50m_24m_src_p)		= { "clk_pmu1_100m_src", "clk_pmu1_50m_src", "xin24m" };
-PNAME(pmu_24m_32k_100m_src_p)		= { "xin24m", "32k", "clk_pmu1_100m_src" };
+PNAME(pmu_24m_32k_100m_src_p)		= { "xin24m", "xin32k", "clk_pmu1_100m_src" };
 PNAME(hclk_pmu1_root_p)			= { "clk_pmu1_200m_src", "clk_pmu1_100m_src", "clk_pmu1_50m_src", "xin24m" };
 PNAME(hclk_pmu_cm0_root_p)		= { "clk_pmu1_400m_src", "clk_pmu1_200m_src", "clk_pmu1_100m_src", "xin24m" };
 PNAME(mclk_pdm0_p)			= { "clk_pmu1_300m_src", "clk_pmu1_200m_src" };
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
index 53f7af234cc2..aabd0484ac23 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-vout.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
@@ -145,7 +145,7 @@ static int jh7110_voutcrg_probe(struct platform_device *pdev)
 
 	/* enable power domain and clocks */
 	pm_runtime_enable(priv->dev);
-	ret = pm_runtime_get_sync(priv->dev);
+	ret = pm_runtime_resume_and_get(priv->dev);
 	if (ret < 0)
 		return dev_err_probe(priv->dev, ret, "failed to turn on power\n");
 
diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index d964e3affd42..0eab7f3e2eab 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -240,6 +240,7 @@ static int of_dra7_atl_clk_probe(struct platform_device *pdev)
 		}
 
 		clk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to get atl clock %d from provider\n",
 			       __func__, i);
diff --git a/drivers/clocksource/timer-qcom.c b/drivers/clocksource/timer-qcom.c
index b4afe3a67583..eac4c95c6127 100644
--- a/drivers/clocksource/timer-qcom.c
+++ b/drivers/clocksource/timer-qcom.c
@@ -233,6 +233,7 @@ static int __init msm_dt_timer_init(struct device_node *np)
 	}
 
 	if (of_property_read_u32(np, "clock-frequency", &freq)) {
+		iounmap(cpu0_base);
 		pr_err("Unknown frequency\n");
 		return -EINVAL;
 	}
@@ -243,7 +244,11 @@ static int __init msm_dt_timer_init(struct device_node *np)
 	freq /= 4;
 	writel_relaxed(DGT_CLK_CTL_DIV_4, source_base + DGT_CLK_CTL);
 
-	return msm_timer_init(freq, 32, irq, !!percpu_offset);
+	ret = msm_timer_init(freq, 32, irq, !!percpu_offset);
+	if (ret)
+		iounmap(cpu0_base);
+
+	return ret;
 }
 TIMER_OF_DECLARE(kpss_timer, "qcom,kpss-timer", msm_dt_timer_init);
 TIMER_OF_DECLARE(scss_timer, "qcom,scss-timer", msm_dt_timer_init);
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 5af85c4cbad0..f8e6dc3c14d3 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -61,6 +61,9 @@ struct ti_cpufreq_soc_data {
 	unsigned long efuse_shift;
 	unsigned long rev_offset;
 	bool multi_regulator;
+/* Backward compatibility hack: Might have missing syscon */
+#define TI_QUIRK_SYSCON_MAY_BE_MISSING	0x1
+	u8 quirks;
 };
 
 struct ti_cpufreq_data {
@@ -182,6 +185,7 @@ static struct ti_cpufreq_soc_data omap34xx_soc_data = {
 	.efuse_mask = BIT(3),
 	.rev_offset = OMAP3_CONTROL_IDCODE - OMAP3_SYSCON_BASE,
 	.multi_regulator = false,
+	.quirks = TI_QUIRK_SYSCON_MAY_BE_MISSING,
 };
 
 /*
@@ -209,6 +213,7 @@ static struct ti_cpufreq_soc_data omap36xx_soc_data = {
 	.efuse_mask = BIT(9),
 	.rev_offset = OMAP3_CONTROL_IDCODE - OMAP3_SYSCON_BASE,
 	.multi_regulator = true,
+	.quirks = TI_QUIRK_SYSCON_MAY_BE_MISSING,
 };
 
 /*
@@ -223,6 +228,7 @@ static struct ti_cpufreq_soc_data am3517_soc_data = {
 	.efuse_mask = 0,
 	.rev_offset = OMAP3_CONTROL_IDCODE - OMAP3_SYSCON_BASE,
 	.multi_regulator = false,
+	.quirks = TI_QUIRK_SYSCON_MAY_BE_MISSING,
 };
 
 static struct ti_cpufreq_soc_data am625_soc_data = {
@@ -250,7 +256,7 @@ static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
 
 	ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
 			  &efuse);
-	if (ret == -EIO) {
+	if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_MISSING && ret == -EIO) {
 		/* not a syscon register! */
 		void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
 				opp_data->soc_data->efuse_offset, 4);
@@ -291,7 +297,7 @@ static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
 
 	ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
 			  &revision);
-	if (ret == -EIO) {
+	if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_MISSING && ret == -EIO) {
 		/* not a syscon register! */
 		void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
 				opp_data->soc_data->rev_offset, 4);
diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index a6e123dfe394..5bb3401220d2 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "cpuidle-riscv-sbi: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/cpuhotplug.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
@@ -236,19 +237,16 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 {
 	struct sbi_cpuidle_data *data = per_cpu_ptr(&sbi_cpuidle_data, cpu);
 	struct device_node *state_node;
-	struct device_node *cpu_node;
 	u32 *states;
 	int i, ret;
 
-	cpu_node = of_cpu_device_node_get(cpu);
+	struct device_node *cpu_node __free(device_node) = of_cpu_device_node_get(cpu);
 	if (!cpu_node)
 		return -ENODEV;
 
 	states = devm_kcalloc(dev, state_count, sizeof(*states), GFP_KERNEL);
-	if (!states) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (!states)
+		return -ENOMEM;
 
 	/* Parse SBI specific details from state DT nodes */
 	for (i = 1; i < state_count; i++) {
@@ -264,10 +262,8 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 
 		pr_debug("sbi-state %#x index %d\n", states[i], i);
 	}
-	if (i != state_count) {
-		ret = -ENODEV;
-		goto fail;
-	}
+	if (i != state_count)
+		return -ENODEV;
 
 	/* Initialize optional data, used for the hierarchical topology. */
 	ret = sbi_dt_cpu_init_topology(drv, data, state_count, cpu);
@@ -277,10 +273,7 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 	/* Store states in the per-cpu struct. */
 	data->states = states;
 
-fail:
-	of_node_put(cpu_node);
-
-	return ret;
+	return 0;
 }
 
 static void sbi_cpuidle_deinit_cpu(int cpu)
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index fdd724228c2f..25c02e267258 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -708,6 +708,7 @@ static struct ahash_edesc *ahash_edesc_alloc(struct ahash_request *req,
 		       GFP_KERNEL : GFP_ATOMIC;
 	struct ahash_edesc *edesc;
 
+	sg_num = pad_sg_nents(sg_num);
 	edesc = kzalloc(struct_size(edesc, sec4_sg, sg_num), flags);
 	if (!edesc)
 		return NULL;
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 1912bee22dd4..7407c9a1e844 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -910,7 +910,18 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 
 	sev->int_rcvd = 0;
 
-	reg = FIELD_PREP(SEV_CMDRESP_CMD, cmd) | SEV_CMDRESP_IOC;
+	reg = FIELD_PREP(SEV_CMDRESP_CMD, cmd);
+
+	/*
+	 * If invoked during panic handling, local interrupts are disabled so
+	 * the PSP command completion interrupt can't be used.
+	 * sev_wait_cmd_ioc() already checks for interrupts disabled and
+	 * polls for PSP command completion.  Ensure we do not request an
+	 * interrupt from the PSP if irqs disabled.
+	 */
+	if (!irqs_disabled())
+		reg |= SEV_CMDRESP_IOC;
+
 	iowrite32(reg, sev->io_regs + sev->vdata->cmdresp_reg);
 
 	/* wait for command completion */
@@ -2374,6 +2385,8 @@ void sev_pci_init(void)
 	return;
 
 err:
+	sev_dev_destroy(psp_master);
+
 	psp_master->sev_data = NULL;
 }
 
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 10aa4da93323..6b536ad2ada5 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -13,9 +13,7 @@
 #include <linux/uacce.h>
 #include "hpre.h"
 
-#define HPRE_QM_ABNML_INT_MASK		0x100004
 #define HPRE_CTRL_CNT_CLR_CE_BIT	BIT(0)
-#define HPRE_COMM_CNT_CLR_CE		0x0
 #define HPRE_CTRL_CNT_CLR_CE		0x301000
 #define HPRE_FSM_MAX_CNT		0x301008
 #define HPRE_VFG_AXQOS			0x30100c
@@ -42,7 +40,6 @@
 #define HPRE_HAC_INT_SET		0x301500
 #define HPRE_RNG_TIMEOUT_NUM		0x301A34
 #define HPRE_CORE_INT_ENABLE		0
-#define HPRE_CORE_INT_DISABLE		GENMASK(21, 0)
 #define HPRE_RDCHN_INI_ST		0x301a00
 #define HPRE_CLSTR_BASE			0x302000
 #define HPRE_CORE_EN_OFFSET		0x04
@@ -66,7 +63,6 @@
 #define HPRE_CLSTR_ADDR_INTRVL		0x1000
 #define HPRE_CLUSTER_INQURY		0x100
 #define HPRE_CLSTR_ADDR_INQRY_RSLT	0x104
-#define HPRE_TIMEOUT_ABNML_BIT		6
 #define HPRE_PASID_EN_BIT		9
 #define HPRE_REG_RD_INTVRL_US		10
 #define HPRE_REG_RD_TMOUT_US		1000
@@ -203,9 +199,9 @@ static const struct hisi_qm_cap_info hpre_basic_info[] = {
 	{HPRE_QM_RESET_MASK_CAP, 0x3128, 0, GENMASK(31, 0), 0x0, 0xC37, 0x6C37},
 	{HPRE_QM_OOO_SHUTDOWN_MASK_CAP, 0x3128, 0, GENMASK(31, 0), 0x0, 0x4, 0x6C37},
 	{HPRE_QM_CE_MASK_CAP, 0x312C, 0, GENMASK(31, 0), 0x0, 0x8, 0x8},
-	{HPRE_NFE_MASK_CAP, 0x3130, 0, GENMASK(31, 0), 0x0, 0x3FFFFE, 0x1FFFFFE},
-	{HPRE_RESET_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x3FFFFE, 0xBFFFFE},
-	{HPRE_OOO_SHUTDOWN_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x22, 0xBFFFFE},
+	{HPRE_NFE_MASK_CAP, 0x3130, 0, GENMASK(31, 0), 0x0, 0x3FFFFE, 0x1FFFC3E},
+	{HPRE_RESET_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x3FFFFE, 0xBFFC3E},
+	{HPRE_OOO_SHUTDOWN_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x22, 0xBFFC3E},
 	{HPRE_CE_MASK_CAP, 0x3138, 0, GENMASK(31, 0), 0x0, 0x1, 0x1},
 	{HPRE_CLUSTER_NUM_CAP, 0x313c, 20, GENMASK(3, 0), 0x0,  0x4, 0x1},
 	{HPRE_CORE_TYPE_NUM_CAP, 0x313c, 16, GENMASK(3, 0), 0x0, 0x2, 0x2},
@@ -358,6 +354,8 @@ static struct dfx_diff_registers hpre_diff_regs[] = {
 	},
 };
 
+static const struct hisi_qm_err_ini hpre_err_ini;
+
 bool hpre_check_alg_support(struct hisi_qm *qm, u32 alg)
 {
 	u32 cap_val;
@@ -654,11 +652,6 @@ static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
 	writel(HPRE_QM_USR_CFG_MASK, qm->io_base + QM_AWUSER_M_CFG_ENABLE);
 	writel_relaxed(HPRE_QM_AXI_CFG_MASK, qm->io_base + QM_AXI_M_CFG);
 
-	/* HPRE need more time, we close this interrupt */
-	val = readl_relaxed(qm->io_base + HPRE_QM_ABNML_INT_MASK);
-	val |= BIT(HPRE_TIMEOUT_ABNML_BIT);
-	writel_relaxed(val, qm->io_base + HPRE_QM_ABNML_INT_MASK);
-
 	if (qm->ver >= QM_HW_V3)
 		writel(HPRE_RSA_ENB | HPRE_ECC_ENB,
 			qm->io_base + HPRE_TYPES_ENB);
@@ -667,9 +660,7 @@ static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
 
 	writel(HPRE_QM_VFG_AX_MASK, qm->io_base + HPRE_VFG_AXCACHE);
 	writel(0x0, qm->io_base + HPRE_BD_ENDIAN);
-	writel(0x0, qm->io_base + HPRE_INT_MASK);
 	writel(0x0, qm->io_base + HPRE_POISON_BYPASS);
-	writel(0x0, qm->io_base + HPRE_COMM_CNT_CLR_CE);
 	writel(0x0, qm->io_base + HPRE_ECC_BYPASS);
 
 	writel(HPRE_BD_USR_MASK, qm->io_base + HPRE_BD_ARUSR_CFG);
@@ -759,7 +750,7 @@ static void hpre_hw_error_disable(struct hisi_qm *qm)
 
 static void hpre_hw_error_enable(struct hisi_qm *qm)
 {
-	u32 ce, nfe;
+	u32 ce, nfe, err_en;
 
 	ce = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_CE_MASK_CAP, qm->cap_ver);
 	nfe = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_NFE_MASK_CAP, qm->cap_ver);
@@ -776,7 +767,8 @@ static void hpre_hw_error_enable(struct hisi_qm *qm)
 	hpre_master_ooo_ctrl(qm, true);
 
 	/* enable hpre hw error interrupts */
-	writel(HPRE_CORE_INT_ENABLE, qm->io_base + HPRE_INT_MASK);
+	err_en = ce | nfe | HPRE_HAC_RAS_FE_ENABLE;
+	writel(~err_en, qm->io_base + HPRE_INT_MASK);
 }
 
 static inline struct hisi_qm *hpre_file_to_qm(struct hpre_debugfs_file *file)
@@ -1161,6 +1153,7 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = pf_q_num;
 		qm->debug.curr_qm_qp_num = pf_q_num;
 		qm->qm_list = &hpre_devices;
+		qm->err_ini = &hpre_err_ini;
 		if (pf_q_num_flag)
 			set_bit(QM_MODULE_PARAM, &qm->misc_ctl);
 	}
@@ -1350,8 +1343,6 @@ static int hpre_pf_probe_init(struct hpre *hpre)
 
 	hpre_open_sva_prefetch(qm);
 
-	qm->err_ini = &hpre_err_ini;
-	qm->err_ini->err_info_init(qm);
 	hisi_qm_dev_err_init(qm);
 	ret = hpre_show_last_regs_init(qm);
 	if (ret)
@@ -1380,6 +1371,18 @@ static int hpre_probe_init(struct hpre *hpre)
 	return 0;
 }
 
+static void hpre_probe_uninit(struct hisi_qm *qm)
+{
+	if (qm->fun_type == QM_HW_VF)
+		return;
+
+	hpre_cnt_regs_clear(qm);
+	qm->debug.curr_qm_qp_num = 0;
+	hpre_show_last_regs_uninit(qm);
+	hpre_close_sva_prefetch(qm);
+	hisi_qm_dev_err_uninit(qm);
+}
+
 static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct hisi_qm *qm;
@@ -1405,7 +1408,7 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ret = hisi_qm_start(qm);
 	if (ret)
-		goto err_with_err_init;
+		goto err_with_probe_init;
 
 	ret = hpre_debugfs_init(qm);
 	if (ret)
@@ -1444,9 +1447,8 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hpre_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
 
-err_with_err_init:
-	hpre_show_last_regs_uninit(qm);
-	hisi_qm_dev_err_uninit(qm);
+err_with_probe_init:
+	hpre_probe_uninit(qm);
 
 err_with_qm_init:
 	hisi_qm_uninit(qm);
@@ -1468,13 +1470,7 @@ static void hpre_remove(struct pci_dev *pdev)
 	hpre_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
 
-	if (qm->fun_type == QM_HW_PF) {
-		hpre_cnt_regs_clear(qm);
-		qm->debug.curr_qm_qp_num = 0;
-		hpre_show_last_regs_uninit(qm);
-		hisi_qm_dev_err_uninit(qm);
-	}
-
+	hpre_probe_uninit(qm);
 	hisi_qm_uninit(qm);
 }
 
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 3dac8d8e8568..da562ceaaf27 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -450,6 +450,7 @@ static struct qm_typical_qos_table shaper_cbs_s[] = {
 };
 
 static void qm_irqs_unregister(struct hisi_qm *qm);
+static int qm_reset_device(struct hisi_qm *qm);
 
 static u32 qm_get_hw_error_status(struct hisi_qm *qm)
 {
@@ -4019,6 +4020,28 @@ static int qm_set_vf_mse(struct hisi_qm *qm, bool set)
 	return -ETIMEDOUT;
 }
 
+static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
+{
+	u32 nfe_enb = 0;
+
+	/* Kunpeng930 hardware automatically close master ooo when NFE occurs */
+	if (qm->ver >= QM_HW_V3)
+		return;
+
+	if (!qm->err_status.is_dev_ecc_mbit &&
+	    qm->err_status.is_qm_ecc_mbit &&
+	    qm->err_ini->close_axi_master_ooo) {
+		qm->err_ini->close_axi_master_ooo(qm);
+	} else if (qm->err_status.is_dev_ecc_mbit &&
+		   !qm->err_status.is_qm_ecc_mbit &&
+		   !qm->err_ini->close_axi_master_ooo) {
+		nfe_enb = readl(qm->io_base + QM_RAS_NFE_ENABLE);
+		writel(nfe_enb & QM_RAS_NFE_MBIT_DISABLE,
+		       qm->io_base + QM_RAS_NFE_ENABLE);
+		writel(QM_ECC_MBIT, qm->io_base + QM_ABNORMAL_INT_SET);
+	}
+}
+
 static int qm_vf_reset_prepare(struct hisi_qm *qm,
 			       enum qm_stop_reason stop_reason)
 {
@@ -4083,6 +4106,8 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
 		return ret;
 	}
 
+	qm_dev_ecc_mbit_handle(qm);
+
 	/* PF obtains the information of VF by querying the register. */
 	qm_cmd_uninit(qm);
 
@@ -4113,33 +4138,26 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
 	return 0;
 }
 
-static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
+static int qm_master_ooo_check(struct hisi_qm *qm)
 {
-	u32 nfe_enb = 0;
+	u32 val;
+	int ret;
 
-	/* Kunpeng930 hardware automatically close master ooo when NFE occurs */
-	if (qm->ver >= QM_HW_V3)
-		return;
+	/* Check the ooo register of the device before resetting the device. */
+	writel(ACC_MASTER_GLOBAL_CTRL_SHUTDOWN, qm->io_base + ACC_MASTER_GLOBAL_CTRL);
+	ret = readl_relaxed_poll_timeout(qm->io_base + ACC_MASTER_TRANS_RETURN,
+					 val, (val == ACC_MASTER_TRANS_RETURN_RW),
+					 POLL_PERIOD, POLL_TIMEOUT);
+	if (ret)
+		pci_warn(qm->pdev, "Bus lock! Please reset system.\n");
 
-	if (!qm->err_status.is_dev_ecc_mbit &&
-	    qm->err_status.is_qm_ecc_mbit &&
-	    qm->err_ini->close_axi_master_ooo) {
-		qm->err_ini->close_axi_master_ooo(qm);
-	} else if (qm->err_status.is_dev_ecc_mbit &&
-		   !qm->err_status.is_qm_ecc_mbit &&
-		   !qm->err_ini->close_axi_master_ooo) {
-		nfe_enb = readl(qm->io_base + QM_RAS_NFE_ENABLE);
-		writel(nfe_enb & QM_RAS_NFE_MBIT_DISABLE,
-		       qm->io_base + QM_RAS_NFE_ENABLE);
-		writel(QM_ECC_MBIT, qm->io_base + QM_ABNORMAL_INT_SET);
-	}
+	return ret;
 }
 
-static int qm_soft_reset(struct hisi_qm *qm)
+static int qm_soft_reset_prepare(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
 	int ret;
-	u32 val;
 
 	/* Ensure all doorbells and mailboxes received by QM */
 	ret = qm_check_req_recv(qm);
@@ -4160,30 +4178,23 @@ static int qm_soft_reset(struct hisi_qm *qm)
 		return ret;
 	}
 
-	qm_dev_ecc_mbit_handle(qm);
-
-	/* OOO register set and check */
-	writel(ACC_MASTER_GLOBAL_CTRL_SHUTDOWN,
-	       qm->io_base + ACC_MASTER_GLOBAL_CTRL);
-
-	/* If bus lock, reset chip */
-	ret = readl_relaxed_poll_timeout(qm->io_base + ACC_MASTER_TRANS_RETURN,
-					 val,
-					 (val == ACC_MASTER_TRANS_RETURN_RW),
-					 POLL_PERIOD, POLL_TIMEOUT);
-	if (ret) {
-		pci_emerg(pdev, "Bus lock! Please reset system.\n");
+	ret = qm_master_ooo_check(qm);
+	if (ret)
 		return ret;
-	}
 
 	if (qm->err_ini->close_sva_prefetch)
 		qm->err_ini->close_sva_prefetch(qm);
 
 	ret = qm_set_pf_mse(qm, false);
-	if (ret) {
+	if (ret)
 		pci_err(pdev, "Fails to disable pf MSE bit.\n");
-		return ret;
-	}
+
+	return ret;
+}
+
+static int qm_reset_device(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
 
 	/* The reset related sub-control registers are not in PCI BAR */
 	if (ACPI_HANDLE(&pdev->dev)) {
@@ -4202,12 +4213,23 @@ static int qm_soft_reset(struct hisi_qm *qm)
 			pci_err(pdev, "Reset step %llu failed!\n", value);
 			return -EIO;
 		}
-	} else {
-		pci_err(pdev, "No reset method!\n");
-		return -EINVAL;
+
+		return 0;
 	}
 
-	return 0;
+	pci_err(pdev, "No reset method!\n");
+	return -EINVAL;
+}
+
+static int qm_soft_reset(struct hisi_qm *qm)
+{
+	int ret;
+
+	ret = qm_soft_reset_prepare(qm);
+	if (ret)
+		return ret;
+
+	return qm_reset_device(qm);
 }
 
 static int qm_vf_reset_done(struct hisi_qm *qm)
@@ -5160,6 +5182,35 @@ static int qm_get_pci_res(struct hisi_qm *qm)
 	return ret;
 }
 
+static int qm_clear_device(struct hisi_qm *qm)
+{
+	acpi_handle handle = ACPI_HANDLE(&qm->pdev->dev);
+	int ret;
+
+	if (qm->fun_type == QM_HW_VF)
+		return 0;
+
+	/* Device does not support reset, return */
+	if (!qm->err_ini->err_info_init)
+		return 0;
+	qm->err_ini->err_info_init(qm);
+
+	if (!handle)
+		return 0;
+
+	/* No reset method, return */
+	if (!acpi_has_method(handle, qm->err_info.acpi_rst))
+		return 0;
+
+	ret = qm_master_ooo_check(qm);
+	if (ret) {
+		writel(0x0, qm->io_base + ACC_MASTER_GLOBAL_CTRL);
+		return ret;
+	}
+
+	return qm_reset_device(qm);
+}
+
 static int hisi_qm_pci_init(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -5189,8 +5240,14 @@ static int hisi_qm_pci_init(struct hisi_qm *qm)
 		goto err_get_pci_res;
 	}
 
+	ret = qm_clear_device(qm);
+	if (ret)
+		goto err_free_vectors;
+
 	return 0;
 
+err_free_vectors:
+	pci_free_irq_vectors(pdev);
 err_get_pci_res:
 	qm_put_pci_res(qm);
 err_disable_pcidev:
@@ -5491,7 +5548,6 @@ static int qm_prepare_for_suspend(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
 	int ret;
-	u32 val;
 
 	ret = qm->ops->set_msi(qm, false);
 	if (ret) {
@@ -5499,18 +5555,9 @@ static int qm_prepare_for_suspend(struct hisi_qm *qm)
 		return ret;
 	}
 
-	/* shutdown OOO register */
-	writel(ACC_MASTER_GLOBAL_CTRL_SHUTDOWN,
-	       qm->io_base + ACC_MASTER_GLOBAL_CTRL);
-
-	ret = readl_relaxed_poll_timeout(qm->io_base + ACC_MASTER_TRANS_RETURN,
-					 val,
-					 (val == ACC_MASTER_TRANS_RETURN_RW),
-					 POLL_PERIOD, POLL_TIMEOUT);
-	if (ret) {
-		pci_emerg(pdev, "Bus lock! Please reset system.\n");
+	ret = qm_master_ooo_check(qm);
+	if (ret)
 		return ret;
-	}
 
 	ret = qm_set_pf_mse(qm, false);
 	if (ret)
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 75aad04ffe5e..c35533d8930b 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -1065,9 +1065,6 @@ static int sec_pf_probe_init(struct sec_dev *sec)
 	struct hisi_qm *qm = &sec->qm;
 	int ret;
 
-	qm->err_ini = &sec_err_ini;
-	qm->err_ini->err_info_init(qm);
-
 	ret = sec_set_user_domain_and_cache(qm);
 	if (ret)
 		return ret;
@@ -1122,6 +1119,7 @@ static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = pf_q_num;
 		qm->debug.curr_qm_qp_num = pf_q_num;
 		qm->qm_list = &sec_devices;
+		qm->err_ini = &sec_err_ini;
 		if (pf_q_num_flag)
 			set_bit(QM_MODULE_PARAM, &qm->misc_ctl);
 	} else if (qm->fun_type == QM_HW_VF && qm->ver == QM_HW_V1) {
@@ -1186,6 +1184,12 @@ static int sec_probe_init(struct sec_dev *sec)
 
 static void sec_probe_uninit(struct hisi_qm *qm)
 {
+	if (qm->fun_type == QM_HW_VF)
+		return;
+
+	sec_debug_regs_clear(qm);
+	sec_show_last_regs_uninit(qm);
+	sec_close_sva_prefetch(qm);
 	hisi_qm_dev_err_uninit(qm);
 }
 
@@ -1274,7 +1278,6 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	sec_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
 err_probe_uninit:
-	sec_show_last_regs_uninit(qm);
 	sec_probe_uninit(qm);
 err_qm_uninit:
 	sec_qm_uninit(qm);
@@ -1296,11 +1299,6 @@ static void sec_remove(struct pci_dev *pdev)
 	sec_debugfs_exit(qm);
 
 	(void)hisi_qm_stop(qm, QM_NORMAL);
-
-	if (qm->fun_type == QM_HW_PF)
-		sec_debug_regs_clear(qm);
-	sec_show_last_regs_uninit(qm);
-
 	sec_probe_uninit(qm);
 
 	sec_qm_uninit(qm);
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index c94a7b20d07e..befef0b0e6bb 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -1149,8 +1149,6 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
 
 	hisi_zip->ctrl = ctrl;
 	ctrl->hisi_zip = hisi_zip;
-	qm->err_ini = &hisi_zip_err_ini;
-	qm->err_ini->err_info_init(qm);
 
 	ret = hisi_zip_set_user_domain_and_cache(qm);
 	if (ret)
@@ -1211,6 +1209,7 @@ static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = pf_q_num;
 		qm->debug.curr_qm_qp_num = pf_q_num;
 		qm->qm_list = &zip_devices;
+		qm->err_ini = &hisi_zip_err_ini;
 		if (pf_q_num_flag)
 			set_bit(QM_MODULE_PARAM, &qm->misc_ctl);
 	} else if (qm->fun_type == QM_HW_VF && qm->ver == QM_HW_V1) {
@@ -1277,6 +1276,16 @@ static int hisi_zip_probe_init(struct hisi_zip *hisi_zip)
 	return 0;
 }
 
+static void hisi_zip_probe_uninit(struct hisi_qm *qm)
+{
+	if (qm->fun_type == QM_HW_VF)
+		return;
+
+	hisi_zip_show_last_regs_uninit(qm);
+	hisi_zip_close_sva_prefetch(qm);
+	hisi_qm_dev_err_uninit(qm);
+}
+
 static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct hisi_zip *hisi_zip;
@@ -1303,7 +1312,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ret = hisi_qm_start(qm);
 	if (ret)
-		goto err_dev_err_uninit;
+		goto err_probe_uninit;
 
 	ret = hisi_zip_debugfs_init(qm);
 	if (ret)
@@ -1342,9 +1351,8 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hisi_zip_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
 
-err_dev_err_uninit:
-	hisi_zip_show_last_regs_uninit(qm);
-	hisi_qm_dev_err_uninit(qm);
+err_probe_uninit:
+	hisi_zip_probe_uninit(qm);
 
 err_qm_uninit:
 	hisi_zip_qm_uninit(qm);
@@ -1366,8 +1374,7 @@ static void hisi_zip_remove(struct pci_dev *pdev)
 
 	hisi_zip_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
-	hisi_zip_show_last_regs_uninit(qm);
-	hisi_qm_dev_err_uninit(qm);
+	hisi_zip_probe_uninit(qm);
 	hisi_zip_qm_uninit(qm);
 }
 
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index e810d286ee8c..237f87000070 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -495,10 +495,10 @@ static void remove_device_compression_modes(struct iaa_device *iaa_device)
 		if (!device_mode)
 			continue;
 
-		free_device_compression_mode(iaa_device, device_mode);
-		iaa_device->compression_modes[i] = NULL;
 		if (iaa_compression_modes[i]->free)
 			iaa_compression_modes[i]->free(device_mode);
+		free_device_compression_mode(iaa_device, device_mode);
+		iaa_device->compression_modes[i] = NULL;
 	}
 }
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
index 8b10926cedba..e8c53bd76f1b 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
@@ -83,7 +83,7 @@
 #define ADF_WQM_CSR_RPRESETSTS(bank)	(ADF_WQM_CSR_RPRESETCTL(bank) + 4)
 
 /* Ring interrupt */
-#define ADF_RP_INT_SRC_SEL_F_RISE_MASK	BIT(2)
+#define ADF_RP_INT_SRC_SEL_F_RISE_MASK	GENMASK(1, 0)
 #define ADF_RP_INT_SRC_SEL_F_FALL_MASK	GENMASK(2, 0)
 #define ADF_RP_INT_SRC_SEL_RANGE_WIDTH	4
 #define ADF_COALESCED_POLL_TIMEOUT_US	(1 * USEC_PER_SEC)
diff --git a/drivers/crypto/intel/qat/qat_common/adf_init.c b/drivers/crypto/intel/qat/qat_common/adf_init.c
index 74f0818c0703..55f1ff1e0b32 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_init.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_init.c
@@ -323,6 +323,8 @@ static void adf_dev_stop(struct adf_accel_dev *accel_dev)
 	if (hw_data->stop_timer)
 		hw_data->stop_timer(accel_dev);
 
+	hw_data->disable_iov(accel_dev);
+
 	if (wait)
 		msleep(100);
 
@@ -386,8 +388,6 @@ static void adf_dev_shutdown(struct adf_accel_dev *accel_dev)
 
 	adf_tl_shutdown(accel_dev);
 
-	hw_data->disable_iov(accel_dev);
-
 	if (test_bit(ADF_STATUS_IRQ_ALLOCATED, &accel_dev->status)) {
 		hw_data->free_irq(accel_dev);
 		clear_bit(ADF_STATUS_IRQ_ALLOCATED, &accel_dev->status);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_msg.c b/drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_msg.c
index 0e31f4b41844..0cee3b23dee9 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_msg.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_msg.c
@@ -18,14 +18,17 @@ void adf_pf2vf_notify_restarting(struct adf_accel_dev *accel_dev)
 
 	dev_dbg(&GET_DEV(accel_dev), "pf2vf notify restarting\n");
 	for (i = 0, vf = accel_dev->pf.vf_info; i < num_vfs; i++, vf++) {
-		vf->restarting = false;
+		if (vf->init && vf->vf_compat_ver >= ADF_PFVF_COMPAT_FALLBACK)
+			vf->restarting = true;
+		else
+			vf->restarting = false;
+
 		if (!vf->init)
 			continue;
+
 		if (adf_send_pf2vf_msg(accel_dev, i, msg))
 			dev_err(&GET_DEV(accel_dev),
 				"Failed to send restarting msg to VF%d\n", i);
-		else if (vf->vf_compat_ver >= ADF_PFVF_COMPAT_FALLBACK)
-			vf->restarting = true;
 	}
 }
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_msg.c b/drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_msg.c
index 1141258db4b6..10c91e56d6be 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_msg.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_msg.c
@@ -48,6 +48,20 @@ void adf_vf2pf_notify_shutdown(struct adf_accel_dev *accel_dev)
 }
 EXPORT_SYMBOL_GPL(adf_vf2pf_notify_shutdown);
 
+void adf_vf2pf_notify_restart_complete(struct adf_accel_dev *accel_dev)
+{
+	struct pfvf_message msg = { .type = ADF_VF2PF_MSGTYPE_RESTARTING_COMPLETE };
+
+	/* Check compatibility version */
+	if (accel_dev->vf.pf_compat_ver < ADF_PFVF_COMPAT_FALLBACK)
+		return;
+
+	if (adf_send_vf2pf_msg(accel_dev, msg))
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to send Restarting complete event to PF\n");
+}
+EXPORT_SYMBOL_GPL(adf_vf2pf_notify_restart_complete);
+
 int adf_vf2pf_request_version(struct adf_accel_dev *accel_dev)
 {
 	u8 pf_version;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_msg.h b/drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_msg.h
index 71bc0e3f1d93..d79340ab3134 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_msg.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_msg.h
@@ -6,6 +6,7 @@
 #if defined(CONFIG_PCI_IOV)
 int adf_vf2pf_notify_init(struct adf_accel_dev *accel_dev);
 void adf_vf2pf_notify_shutdown(struct adf_accel_dev *accel_dev);
+void adf_vf2pf_notify_restart_complete(struct adf_accel_dev *accel_dev);
 int adf_vf2pf_request_version(struct adf_accel_dev *accel_dev);
 int adf_vf2pf_get_capabilities(struct adf_accel_dev *accel_dev);
 int adf_vf2pf_get_ring_to_svc(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_vf_isr.c b/drivers/crypto/intel/qat/qat_common/adf_vf_isr.c
index cdbb2d687b1b..4ab9ac331519 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_vf_isr.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_vf_isr.c
@@ -13,6 +13,7 @@
 #include "adf_cfg.h"
 #include "adf_cfg_strings.h"
 #include "adf_cfg_common.h"
+#include "adf_pfvf_vf_msg.h"
 #include "adf_transport_access_macros.h"
 #include "adf_transport_internal.h"
 
@@ -75,6 +76,7 @@ static void adf_dev_stop_async(struct work_struct *work)
 
 	/* Re-enable PF2VF interrupts */
 	adf_enable_pf2vf_interrupts(accel_dev);
+	adf_vf2pf_notify_restart_complete(accel_dev);
 	kfree(stop_data);
 }
 
diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index 59d472cb11e7..509aeffdedc6 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -1357,6 +1357,7 @@ static int __n2_register_one_hmac(struct n2_ahash_alg *n2ahash)
 	ahash->setkey = n2_hmac_async_setkey;
 
 	base = &ahash->halg.base;
+	err = -EINVAL;
 	if (snprintf(base->cra_name, CRYPTO_MAX_ALG_NAME, "hmac(%s)",
 		     p->child_alg) >= CRYPTO_MAX_ALG_NAME)
 		goto out_free_p;
diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index c670d7d0c11e..6496b075a48d 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -196,7 +196,7 @@ static int qcom_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(rng->clk))
 		return PTR_ERR(rng->clk);
 
-	rng->of_data = (struct qcom_rng_of_data *)of_device_get_match_data(&pdev->dev);
+	rng->of_data = (struct qcom_rng_of_data *)device_get_match_data(&pdev->dev);
 
 	qcom_rng_dev = rng;
 	ret = crypto_register_rng(&qcom_rng_alg);
@@ -247,7 +247,7 @@ static struct qcom_rng_of_data qcom_trng_of_data = {
 };
 
 static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
-	{ .id = "QCOM8160", .driver_data = 1 },
+	{ .id = "QCOM8160", .driver_data = (kernel_ulong_t)&qcom_prng_ee_of_data },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, qcom_rng_acpi_match);
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 8567dd11eaac..205085ccf12c 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -390,10 +390,6 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 
 		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
 		if (!size) {
-			info->dvsec_range[i] = (struct range) {
-				.start = 0,
-				.end = CXL_RESOURCE_NONE,
-			};
 			continue;
 		}
 
@@ -411,12 +407,10 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 
 		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
 
-		info->dvsec_range[i] = (struct range) {
+		info->dvsec_range[ranges++] = (struct range) {
 			.start = base,
 			.end = base + size - 1
 		};
-
-		ranges++;
 	}
 
 	info->ranges = ranges;
diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index dbe9fe5f2ca6..594408aa934b 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -311,7 +311,7 @@ static u64 ehl_err_addr_to_imc_addr(u64 eaddr, int mc)
 	if (igen6_tom <= _4GB)
 		return eaddr + igen6_tolud - _4GB;
 
-	if (eaddr < _4GB)
+	if (eaddr >= igen6_tom)
 		return eaddr + igen6_tolud - igen6_tom;
 
 	return eaddr;
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index ea7a9a342dd3..d7416166fd8a 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
+#include <linux/sizes.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 
@@ -337,6 +338,7 @@ struct synps_edac_priv {
  * @get_mtype:		Get mtype.
  * @get_dtype:		Get dtype.
  * @get_ecc_state:	Get ECC state.
+ * @get_mem_info:	Get EDAC memory info
  * @quirks:		To differentiate IPs.
  */
 struct synps_platform_data {
@@ -344,6 +346,9 @@ struct synps_platform_data {
 	enum mem_type (*get_mtype)(const void __iomem *base);
 	enum dev_type (*get_dtype)(const void __iomem *base);
 	bool (*get_ecc_state)(void __iomem *base);
+#ifdef CONFIG_EDAC_DEBUG
+	u64 (*get_mem_info)(struct synps_edac_priv *priv);
+#endif
 	int quirks;
 };
 
@@ -402,6 +407,25 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
 	return 0;
 }
 
+#ifdef CONFIG_EDAC_DEBUG
+/**
+ * zynqmp_get_mem_info - Get the current memory info.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Return: host interface address.
+ */
+static u64 zynqmp_get_mem_info(struct synps_edac_priv *priv)
+{
+	u64 hif_addr = 0, linear_addr;
+
+	linear_addr = priv->poison_addr;
+	if (linear_addr >= SZ_32G)
+		linear_addr = linear_addr - SZ_32G + SZ_2G;
+	hif_addr = linear_addr >> 3;
+	return hif_addr;
+}
+#endif
+
 /**
  * zynqmp_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
@@ -922,6 +946,9 @@ static const struct synps_platform_data zynqmp_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
+#ifdef CONFIG_EDAC_DEBUG
+	.get_mem_info	= zynqmp_get_mem_info,
+#endif
 	.quirks         = (DDR_ECC_INTR_SUPPORT
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
@@ -975,10 +1002,16 @@ MODULE_DEVICE_TABLE(of, synps_edac_match);
 static void ddr_poison_setup(struct synps_edac_priv *priv)
 {
 	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
+	const struct synps_platform_data *p_data;
 	int index;
 	ulong hif_addr = 0;
 
-	hif_addr = priv->poison_addr >> 3;
+	p_data = priv->p_data;
+
+	if (p_data->get_mem_info)
+		hif_addr = p_data->get_mem_info(priv);
+	else
+		hif_addr = priv->poison_addr >> 3;
 
 	for (index = 0; index < DDR_MAX_ROW_SHIFT; index++) {
 		if (priv->row_shift[index])
diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 9a7dc90330a3..a888a001bedb 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -599,11 +599,11 @@ static void complete_transaction(struct fw_card *card, int rcode, u32 request_ts
 		queue_event(client, &e->event, rsp, sizeof(*rsp) + rsp->length, NULL, 0);
 
 		break;
+	}
 	default:
 		WARN_ON(1);
 		break;
 	}
-	}
 
 	/* Drop the idr's reference */
 	client_put(client);
diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 4e7944b91e38..0c8908d3b1d6 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -473,6 +473,13 @@ static int scmi_optee_chan_free(int id, void *p, void *data)
 	struct scmi_chan_info *cinfo = p;
 	struct scmi_optee_channel *channel = cinfo->transport_info;
 
+	/*
+	 * Different protocols might share the same chan info, so a previous
+	 * call might have already freed the structure.
+	 */
+	if (!channel)
+		return 0;
+
 	mutex_lock(&scmi_optee_private->mu);
 	list_del(&channel->link);
 	mutex_unlock(&scmi_optee_private->mu);
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index df3182f2e63a..1fd6823248ab 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
 	}
 
 	/* Allocate space for the logs and copy them. */
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
 			     sizeof(*log_tbl) + log_size, (void **)&log_tbl);
 
 	if (status != EFI_SUCCESS) {
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 68f4df7e6c3c..77dd831febf5 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1875,14 +1875,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	 * will cause the boot stages to enter download mode, unless
 	 * disabled below by a clean shutdown/reboot.
 	 */
-	if (download_mode)
-		qcom_scm_set_download_mode(true);
-
+	qcom_scm_set_download_mode(download_mode);
 
 	/*
 	 * Disable SDI if indicated by DT that it is enabled by default.
 	 */
-	if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"))
+	if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled") || !download_mode)
 		qcom_scm_disable_sdi();
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0f7106066480..3fdbc10aebce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -902,10 +902,12 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 {
 	struct amdgpu_vm *vm = params->vm;
 
-	if (!fence || !*fence)
+	tlb_cb->vm = vm;
+	if (!fence || !*fence) {
+		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
 		return;
+	}
 
-	tlb_cb->vm = vm;
 	if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
 				    amdgpu_vm_tlb_seq_cb)) {
 		dma_fence_put(vm->last_tlb_flush);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index fb2b394bb9c5..6e9eeaeb3de1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -213,7 +213,7 @@ struct amd_sriov_msg_pf2vf_info {
 	uint32_t gpu_capacity;
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
-};
+} __packed;
 
 struct amd_sriov_msg_vf2pf_info_header {
 	/* the total structure size in byte */
@@ -273,7 +273,7 @@ struct amd_sriov_msg_vf2pf_info {
 	uint32_t mes_info_size;
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE];
-};
+} __packed;
 
 /* mailbox message send from guest to host  */
 enum amd_sriov_mailbox_request_message {
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index 25feab188dfe..ebf83fee43bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -2065,26 +2065,29 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
 					fake_edid_record = (ATOM_FAKE_EDID_PATCH_RECORD *)record;
 					if (fake_edid_record->ucFakeEDIDLength) {
 						struct edid *edid;
-						int edid_size =
-							max((int)EDID_LENGTH, (int)fake_edid_record->ucFakeEDIDLength);
-						edid = kmalloc(edid_size, GFP_KERNEL);
+						int edid_size;
+
+						if (fake_edid_record->ucFakeEDIDLength == 128)
+							edid_size = fake_edid_record->ucFakeEDIDLength;
+						else
+							edid_size = fake_edid_record->ucFakeEDIDLength * 128;
+						edid = kmemdup(&fake_edid_record->ucFakeEDIDString[0],
+							       edid_size, GFP_KERNEL);
 						if (edid) {
-							memcpy((u8 *)edid, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
-							       fake_edid_record->ucFakeEDIDLength);
-
 							if (drm_edid_is_valid(edid)) {
 								adev->mode_info.bios_hardcoded_edid = edid;
 								adev->mode_info.bios_hardcoded_edid_size = edid_size;
-							} else
+							} else {
 								kfree(edid);
+							}
 						}
+						record += struct_size(fake_edid_record,
+								      ucFakeEDIDString,
+								      edid_size);
+					} else {
+						/* empty fake edid record must be 3 bytes long */
+						record += sizeof(ATOM_FAKE_EDID_PATCH_RECORD) + 1;
 					}
-					record += fake_edid_record->ucFakeEDIDLength ?
-						  struct_size(fake_edid_record,
-							      ucFakeEDIDString,
-							      fake_edid_record->ucFakeEDIDLength) :
-						  /* empty fake edid record must be 3 bytes long */
-						  sizeof(ATOM_FAKE_EDID_PATCH_RECORD) + 1;
 					break;
 				case LCD_PANEL_RESOLUTION_RECORD_TYPE:
 					panel_res_record = (ATOM_PANEL_RESOLUTION_PATCH_RECORD *)record;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e1a66d585f5e..44b277c55de4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -155,7 +155,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 						    int api_status_off)
 {
 	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
-	signed long timeout = 3000000; /* 3000 ms */
+	signed long timeout = 2100000; /* 2100 ms */
 	struct amdgpu_device *adev = mes->adev;
 	struct amdgpu_ring *ring = &mes->ring;
 	struct MES_API_STATUS *api_status;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 30e80c6f11ed..68ac91d28ded 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1353,170 +1353,6 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v4_0_5_limit_sched(struct amdgpu_cs_parser *p,
-				struct amdgpu_job *job)
-{
-	struct drm_gpu_scheduler **scheds;
-
-	/* The create msg must be in the first IB submitted */
-	if (atomic_read(&job->base.entity->fence_seq))
-		return -EINVAL;
-
-	/* if VCN0 is harvested, we can't support AV1 */
-	if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
-		return -EINVAL;
-
-	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_ENC]
-		[AMDGPU_RING_PRIO_0].sched;
-	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
-	return 0;
-}
-
-static int vcn_v4_0_5_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
-			    uint64_t addr)
-{
-	struct ttm_operation_ctx ctx = { false, false };
-	struct amdgpu_bo_va_mapping *map;
-	uint32_t *msg, num_buffers;
-	struct amdgpu_bo *bo;
-	uint64_t start, end;
-	unsigned int i;
-	void *ptr;
-	int r;
-
-	addr &= AMDGPU_GMC_HOLE_MASK;
-	r = amdgpu_cs_find_mapping(p, addr, &bo, &map);
-	if (r) {
-		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
-		return r;
-	}
-
-	start = map->start * AMDGPU_GPU_PAGE_SIZE;
-	end = (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
-	if (addr & 0x7) {
-		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
-		return -EINVAL;
-	}
-
-	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
-	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-	if (r) {
-		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
-		return r;
-	}
-
-	r = amdgpu_bo_kmap(bo, &ptr);
-	if (r) {
-		DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
-		return r;
-	}
-
-	msg = ptr + addr - start;
-
-	/* Check length */
-	if (msg[1] > end - addr) {
-		r = -EINVAL;
-		goto out;
-	}
-
-	if (msg[3] != RDECODE_MSG_CREATE)
-		goto out;
-
-	num_buffers = msg[2];
-	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
-		uint32_t offset, size, *create;
-
-		if (msg[0] != RDECODE_MESSAGE_CREATE)
-			continue;
-
-		offset = msg[1];
-		size = msg[2];
-
-		if (offset + size > end) {
-			r = -EINVAL;
-			goto out;
-		}
-
-		create = ptr + addr + offset - start;
-
-		/* H264, HEVC and VP9 can run on any instance */
-		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
-			continue;
-
-		r = vcn_v4_0_5_limit_sched(p, job);
-		if (r)
-			goto out;
-	}
-
-out:
-	amdgpu_bo_kunmap(bo);
-	return r;
-}
-
-#define RADEON_VCN_ENGINE_TYPE_ENCODE			(0x00000002)
-#define RADEON_VCN_ENGINE_TYPE_DECODE			(0x00000003)
-
-#define RADEON_VCN_ENGINE_INFO				(0x30000001)
-#define RADEON_VCN_ENGINE_INFO_MAX_OFFSET		16
-
-#define RENCODE_ENCODE_STANDARD_AV1			2
-#define RENCODE_IB_PARAM_SESSION_INIT			0x00000003
-#define RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET	64
-
-/* return the offset in ib if id is found, -1 otherwise
- * to speed up the searching we only search upto max_offset
- */
-static int vcn_v4_0_5_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int max_offset)
-{
-	int i;
-
-	for (i = 0; i < ib->length_dw && i < max_offset && ib->ptr[i] >= 8; i += ib->ptr[i]/4) {
-		if (ib->ptr[i + 1] == id)
-			return i;
-	}
-	return -1;
-}
-
-static int vcn_v4_0_5_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
-					   struct amdgpu_job *job,
-					   struct amdgpu_ib *ib)
-{
-	struct amdgpu_ring *ring = amdgpu_job_ring(job);
-	struct amdgpu_vcn_decode_buffer *decode_buffer;
-	uint64_t addr;
-	uint32_t val;
-	int idx;
-
-	/* The first instance can decode anything */
-	if (!ring->me)
-		return 0;
-
-	/* RADEON_VCN_ENGINE_INFO is at the top of ib block */
-	idx = vcn_v4_0_5_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO,
-			RADEON_VCN_ENGINE_INFO_MAX_OFFSET);
-	if (idx < 0) /* engine info is missing */
-		return 0;
-
-	val = amdgpu_ib_get_value(ib, idx + 2); /* RADEON_VCN_ENGINE_TYPE */
-	if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
-		decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[idx + 6];
-
-		if (!(decode_buffer->valid_buf_flag  & 0x1))
-			return 0;
-
-		addr = ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
-			decode_buffer->msg_buffer_address_lo;
-		return vcn_v4_0_5_dec_msg(p, job, addr);
-	} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
-		idx = vcn_v4_0_5_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT,
-			RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
-		if (idx >= 0 && ib->ptr[idx + 2] == RENCODE_ENCODE_STANDARD_AV1)
-			return vcn_v4_0_5_limit_sched(p, job);
-	}
-	return 0;
-}
-
 static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
@@ -1524,7 +1360,6 @@ static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
 	.get_rptr = vcn_v4_0_5_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_5_unified_ring_get_wptr,
 	.set_wptr = vcn_v4_0_5_unified_ring_set_wptr,
-	.patch_cs_in_place = vcn_v4_0_5_ring_patch_cs_in_place,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 27e641f17628..3541d154cc8d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4149,6 +4149,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 
 #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
 #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
+#define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_DM_DEFAULT_MIN_BACKLIGHT) / 2)
 #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
 
 static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
@@ -4163,6 +4164,21 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 		return;
 
 	amdgpu_acpi_get_backlight_caps(&caps);
+
+	/* validate the firmware value is sane */
+	if (caps.caps_valid) {
+		int spread = caps.max_input_signal - caps.min_input_signal;
+
+		if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
+		    caps.min_input_signal < AMDGPU_DM_DEFAULT_MIN_BACKLIGHT ||
+		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
+		    spread < AMDGPU_DM_MIN_SPREAD) {
+			DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
+				      caps.min_input_signal, caps.max_input_signal);
+			caps.caps_valid = false;
+		}
+	}
+
 	if (caps.caps_valid) {
 		dm->backlight_caps[bl_idx].caps_valid = true;
 		if (caps.aux_support)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index b50010ed7633..9a6207731416 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -251,7 +251,7 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 		aconnector->dsc_aux = &aconnector->mst_root->dm_dp_aux.aux;
 
 	/* synaptics cascaded MST hub case */
-	if (!aconnector->dsc_aux && is_synaptics_cascaded_panamera(aconnector->dc_link, port))
+	if (is_synaptics_cascaded_panamera(aconnector->dc_link, port))
 		aconnector->dsc_aux = port->mgr->aux;
 
 	if (!aconnector->dsc_aux)
@@ -1111,7 +1111,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		params[count].num_slices_v = aconnector->dsc_settings.dsc_num_slices_v;
 		params[count].bpp_overwrite = aconnector->dsc_settings.dsc_bits_per_pixel;
 		params[count].compression_possible = stream->sink->dsc_caps.dsc_dec_caps.is_dsc_supported;
-		dc_dsc_get_policy_for_timing(params[count].timing, 0, &dsc_policy);
+		dc_dsc_get_policy_for_timing(params[count].timing, 0, &dsc_policy, dc_link_get_highest_encoding_format(stream->link));
 		if (!dc_dsc_compute_bandwidth_range(
 				stream->sink->ctx->dc->res_pool->dscs[0],
 				stream->sink->ctx->dc->debug.dsc_min_slice_height_override,
@@ -1264,6 +1264,9 @@ static bool is_dsc_need_re_compute(
 		}
 	}
 
+	if (new_stream_on_link_num == 0)
+		return false;
+
 	if (new_stream_on_link_num == 0)
 		return false;
 
@@ -1583,7 +1586,7 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 {
 	struct dc_dsc_policy dsc_policy = {0};
 
-	dc_dsc_get_policy_for_timing(&stream->timing, 0, &dsc_policy);
+	dc_dsc_get_policy_for_timing(&stream->timing, 0, &dsc_policy, dc_link_get_highest_encoding_format(stream->link));
 	dc_dsc_compute_bandwidth_range(stream->sink->ctx->dc->res_pool->dscs[0],
 				       stream->sink->ctx->dc->debug.dsc_min_slice_height_override,
 				       dsc_policy.min_target_bpp * 16,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 6c9b4e6491a5..985e847f9580 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -1149,6 +1149,12 @@ void dcn35_clk_mgr_construct(
 			ctx->dc->debug.disable_dpp_power_gate = false;
 			ctx->dc->debug.disable_hubp_power_gate = false;
 			ctx->dc->debug.disable_dsc_power_gate = false;
+
+			/* Disable dynamic IPS2 in older PMFW (93.12) for Z8 interop. */
+			if (ctx->dc->config.disable_ips == DMUB_IPS_ENABLE &&
+			    ctx->dce_version == DCN_VERSION_3_5 &&
+			    ((clk_mgr->base.smu_ver & 0x00FFFFFF) <= 0x005d0c00))
+				ctx->dc->config.disable_ips = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
 		} else {
 			/*let's reset the config control flag*/
 			ctx->dc->config.disable_ips = DMUB_IPS_DISABLE_ALL; /*pmfw not support it, disable it all*/
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index fe3078b8789e..01c07545ef6b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -100,7 +100,8 @@ uint32_t dc_dsc_stream_bandwidth_overhead_in_kbps(
  */
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
 		uint32_t max_target_bpp_limit_override_x16,
-		struct dc_dsc_policy *policy);
+		struct dc_dsc_policy *policy,
+		const enum dc_link_encoding_format link_encoding);
 
 void dc_dsc_policy_set_max_target_bpp_limit(uint32_t limit);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 150ef23440a2..f8c1e1ca678b 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -883,7 +883,7 @@ static bool setup_dsc_config(
 
 	memset(dsc_cfg, 0, sizeof(struct dc_dsc_config));
 
-	dc_dsc_get_policy_for_timing(timing, options->max_target_bpp_limit_override_x16, &policy);
+	dc_dsc_get_policy_for_timing(timing, options->max_target_bpp_limit_override_x16, &policy, link_encoding);
 	pic_width = timing->h_addressable + timing->h_border_left + timing->h_border_right;
 	pic_height = timing->v_addressable + timing->v_border_top + timing->v_border_bottom;
 
@@ -1156,7 +1156,8 @@ uint32_t dc_dsc_stream_bandwidth_overhead_in_kbps(
 
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
 		uint32_t max_target_bpp_limit_override_x16,
-		struct dc_dsc_policy *policy)
+		struct dc_dsc_policy *policy,
+		const enum dc_link_encoding_format link_encoding)
 {
 	uint32_t bpc = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 0d3ea291eeee..e9e9f80a02a7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -57,6 +57,7 @@
 #include "panel_cntl.h"
 #include "dc_state_priv.h"
 #include "dpcd_defs.h"
+#include "dsc.h"
 /* include DCE11 register header files */
 #include "dce/dce_11_0_d.h"
 #include "dce/dce_11_0_sh_mask.h"
@@ -1768,6 +1769,48 @@ static void get_edp_links_with_sink(
 	}
 }
 
+static void clean_up_dsc_blocks(struct dc *dc)
+{
+	struct display_stream_compressor *dsc = NULL;
+	struct timing_generator *tg = NULL;
+	struct stream_encoder *se = NULL;
+	struct dccg *dccg = dc->res_pool->dccg;
+	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
+	int i;
+
+	if (dc->ctx->dce_version != DCN_VERSION_3_5 &&
+		dc->ctx->dce_version != DCN_VERSION_3_51)
+		return;
+
+	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
+		struct dcn_dsc_state s  = {0};
+
+		dsc = dc->res_pool->dscs[i];
+		dsc->funcs->dsc_read_state(dsc, &s);
+		if (s.dsc_fw_en) {
+			/* disable DSC in OPTC */
+			if (i < dc->res_pool->timing_generator_count) {
+				tg = dc->res_pool->timing_generators[i];
+				tg->funcs->set_dsc_config(tg, OPTC_DSC_DISABLED, 0, 0);
+			}
+			/* disable DSC in stream encoder */
+			if (i < dc->res_pool->stream_enc_count) {
+				se = dc->res_pool->stream_enc[i];
+				se->funcs->dp_set_dsc_config(se, OPTC_DSC_DISABLED, 0, 0);
+				se->funcs->dp_set_dsc_pps_info_packet(se, false, NULL, true);
+			}
+			/* disable DSC block */
+			if (dccg->funcs->set_ref_dscclk)
+				dccg->funcs->set_ref_dscclk(dccg, dsc->inst);
+			dsc->funcs->dsc_disable(dsc);
+
+			/* power down DSC */
+			if (pg_cntl != NULL)
+				pg_cntl->funcs->dsc_pg_control(pg_cntl, dsc->inst, false);
+		}
+	}
+}
+
 /*
  * When ASIC goes from VBIOS/VGA mode to driver/accelerated mode we need:
  *  1. Power down all DC HW blocks
@@ -1852,6 +1895,13 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 		clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
 
 		power_down_all_hw_blocks(dc);
+
+		/* DSC could be enabled on eDP during VBIOS post.
+		 * To clean up dsc blocks if eDP is in link but not active.
+		 */
+		if (edp_link_with_sink && (edp_stream_num == 0))
+			clean_up_dsc_blocks(dc);
+
 		disable_vga_and_power_gate_all_controllers(dc);
 		if (edp_link_with_sink && !keep_edp_vdd_on)
 			dc->hwss.edp_power_control(edp_link_with_sink, false);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 4c4706153305..05c5d4f04e1b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -395,7 +395,11 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
 		}
 	}
 
-	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	if (mpc->funcs->set_output_gamma)
+		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	else
+		DC_LOG_ERROR("%s: set_output_gamma function pointer is NULL.\n", __func__);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index b8e884368dc6..5fc377f51f56 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -991,6 +991,20 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		struct dsc_config dsc_cfg;
 		struct dsc_optc_config dsc_optc_cfg = {0};
 		enum optc_dsc_mode optc_dsc_mode;
+		struct dcn_dsc_state dsc_state = {0};
+
+		if (!dsc) {
+			DC_LOG_DSC("DSC is NULL for tg instance %d:", pipe_ctx->stream_res.tg->inst);
+			return;
+		}
+
+		if (dsc->funcs->dsc_read_state) {
+			dsc->funcs->dsc_read_state(dsc, &dsc_state);
+			if (!dsc_state.dsc_fw_en) {
+				DC_LOG_DSC("DSC has been disabled for tg instance %d:", pipe_ctx->stream_res.tg->inst);
+				return;
+			}
+		}
 
 		/* Enable DSC hw block */
 		dsc_cfg.pic_width = (stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 4f0e9e0f701d..900dfc0f2753 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -375,7 +375,20 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		struct dsc_config dsc_cfg;
 		struct dsc_optc_config dsc_optc_cfg = {0};
 		enum optc_dsc_mode optc_dsc_mode;
+		struct dcn_dsc_state dsc_state = {0};
 
+		if (!dsc) {
+			DC_LOG_DSC("DSC is NULL for tg instance %d:", pipe_ctx->stream_res.tg->inst);
+			return;
+		}
+
+		if (dsc->funcs->dsc_read_state) {
+			dsc->funcs->dsc_read_state(dsc, &dsc_state);
+			if (!dsc_state.dsc_fw_en) {
+				DC_LOG_DSC("DSC has been disabled for tg instance %d:", pipe_ctx->stream_res.tg->inst);
+				return;
+			}
+		}
 		/* Enable DSC hw block */
 		dsc_cfg.pic_width = (stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
 		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 915d68cc04e9..66b73edda7b6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -2150,6 +2150,7 @@ static bool dcn35_resource_construct(
 	dc->dml2_options.max_segments_per_hubp = 24;
 
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;/*todo*/
+	dc->dml2_options.override_det_buffer_size_kbytes = true;
 
 	if (dc->config.sdpif_request_limit_words_per_umc == 0)
 		dc->config.sdpif_request_limit_words_per_umc = 16;/*todo*/
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index b7bd0f36125a..987c3927b118 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -736,7 +736,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.hdmichar = true,
 			.dpstream = true,
 			.symclk32_se = true,
-			.symclk32_le = true,
+			.symclk32_le = false,
 			.symclk_fe = true,
 			.physymclk = true,
 			.dpiasymclk = true,
@@ -2132,6 +2132,7 @@ static bool dcn351_resource_construct(
 
 	dc->dml2_options.max_segments_per_hubp = 24;
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;/*todo*/
+	dc->dml2_options.override_det_buffer_size_kbytes = true;
 
 	if (dc->config.sdpif_request_limit_words_per_umc == 0)
 		dc->config.sdpif_request_limit_words_per_umc = 16;/*todo*/
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index d09627c15b9c..2b8d09bb0cc1 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -134,7 +134,7 @@ unsigned int mod_freesync_calc_v_total_from_refresh(
 
 	v_total = div64_u64(div64_u64(((unsigned long long)(
 			frame_duration_in_ns) * (stream->timing.pix_clk_100hz / 10)),
-			stream->timing.h_total), 1000000);
+			stream->timing.h_total) + 500000, 1000000);
 
 	/* v_total cannot be less than nominal */
 	if (v_total < stream->timing.v_total) {
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 1a9defa15663..e265ab3c8c92 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -422,22 +422,6 @@ static const struct drm_connector_funcs lt8912_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
-static enum drm_mode_status
-lt8912_connector_mode_valid(struct drm_connector *connector,
-			    struct drm_display_mode *mode)
-{
-	if (mode->clock > 150000)
-		return MODE_CLOCK_HIGH;
-
-	if (mode->hdisplay > 1920)
-		return MODE_BAD_HVALUE;
-
-	if (mode->vdisplay > 1080)
-		return MODE_BAD_VVALUE;
-
-	return MODE_OK;
-}
-
 static int lt8912_connector_get_modes(struct drm_connector *connector)
 {
 	const struct drm_edid *drm_edid;
@@ -463,7 +447,6 @@ static int lt8912_connector_get_modes(struct drm_connector *connector)
 
 static const struct drm_connector_helper_funcs lt8912_connector_helper_funcs = {
 	.get_modes = lt8912_connector_get_modes,
-	.mode_valid = lt8912_connector_mode_valid,
 };
 
 static void lt8912_bridge_mode_set(struct drm_bridge *bridge,
@@ -605,6 +588,23 @@ static void lt8912_bridge_detach(struct drm_bridge *bridge)
 		drm_bridge_hpd_disable(lt->hdmi_port);
 }
 
+static enum drm_mode_status
+lt8912_bridge_mode_valid(struct drm_bridge *bridge,
+			 const struct drm_display_info *info,
+			 const struct drm_display_mode *mode)
+{
+	if (mode->clock > 150000)
+		return MODE_CLOCK_HIGH;
+
+	if (mode->hdisplay > 1920)
+		return MODE_BAD_HVALUE;
+
+	if (mode->vdisplay > 1080)
+		return MODE_BAD_VVALUE;
+
+	return MODE_OK;
+}
+
 static enum drm_connector_status
 lt8912_bridge_detect(struct drm_bridge *bridge)
 {
@@ -635,6 +635,7 @@ static const struct drm_edid *lt8912_bridge_edid_read(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs lt8912_bridge_funcs = {
 	.attach = lt8912_bridge_attach,
 	.detach = lt8912_bridge_detach,
+	.mode_valid = lt8912_bridge_mode_valid,
 	.mode_set = lt8912_bridge_mode_set,
 	.enable = lt8912_bridge_enable,
 	.detect = lt8912_bridge_detect,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 1b111e2c3347..752339d33f39 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1174,7 +1174,7 @@ static int gsc_bind(struct device *dev, struct device *master, void *data)
 	struct exynos_drm_ipp *ipp = &ctx->ipp;
 
 	ctx->drm_dev = drm_dev;
-	ctx->drm_dev = drm_dev;
+	ipp->drm_dev = drm_dev;
 	exynos_drm_register_dma(drm_dev, dev, &ctx->dma_priv);
 
 	exynos_drm_ipp_register(dev, ipp, &ipp_funcs,
diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 6f34f573e127..a90504359e8d 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -69,6 +69,8 @@ struct mtk_crtc {
 	/* lock for display hardware access */
 	struct mutex			hw_lock;
 	bool				config_updating;
+	/* lock for config_updating to cmd buffer */
+	spinlock_t			config_lock;
 };
 
 struct mtk_crtc_state {
@@ -106,11 +108,16 @@ static void mtk_crtc_finish_page_flip(struct mtk_crtc *mtk_crtc)
 
 static void mtk_drm_finish_page_flip(struct mtk_crtc *mtk_crtc)
 {
+	unsigned long flags;
+
 	drm_crtc_handle_vblank(&mtk_crtc->base);
+
+	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
 	if (!mtk_crtc->config_updating && mtk_crtc->pending_needs_vblank) {
 		mtk_crtc_finish_page_flip(mtk_crtc);
 		mtk_crtc->pending_needs_vblank = false;
 	}
+	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
 }
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
@@ -308,12 +315,19 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 	struct mtk_crtc *mtk_crtc = container_of(cmdq_cl, struct mtk_crtc, cmdq_client);
 	struct mtk_crtc_state *state;
 	unsigned int i;
+	unsigned long flags;
 
 	if (data->sta < 0)
 		return;
 
 	state = to_mtk_crtc_state(mtk_crtc->base.state);
 
+	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
+	if (mtk_crtc->config_updating) {
+		spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
+		goto ddp_cmdq_cb_out;
+	}
+
 	state->pending_config = false;
 
 	if (mtk_crtc->pending_planes) {
@@ -340,6 +354,10 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 		mtk_crtc->pending_async_planes = false;
 	}
 
+	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
+
+ddp_cmdq_cb_out:
+
 	mtk_crtc->cmdq_vblank_cnt = 0;
 	wake_up(&mtk_crtc->cb_blocking_queue);
 }
@@ -449,6 +467,7 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_crtc *mtk_crtc)
 {
 	struct drm_device *drm = mtk_crtc->base.dev;
 	struct drm_crtc *crtc = &mtk_crtc->base;
+	unsigned long flags;
 	int i;
 
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
@@ -480,10 +499,10 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_crtc *mtk_crtc)
 	pm_runtime_put(drm->dev);
 
 	if (crtc->state->event && !crtc->state->active) {
-		spin_lock_irq(&crtc->dev->event_lock);
+		spin_lock_irqsave(&crtc->dev->event_lock, flags);
 		drm_crtc_send_vblank_event(crtc, crtc->state->event);
 		crtc->state->event = NULL;
-		spin_unlock_irq(&crtc->dev->event_lock);
+		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
 	}
 }
 
@@ -569,9 +588,14 @@ static void mtk_crtc_update_config(struct mtk_crtc *mtk_crtc, bool needs_vblank)
 	struct mtk_drm_private *priv = crtc->dev->dev_private;
 	unsigned int pending_planes = 0, pending_async_planes = 0;
 	int i;
+	unsigned long flags;
 
 	mutex_lock(&mtk_crtc->hw_lock);
+
+	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
 	mtk_crtc->config_updating = true;
+	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
+
 	if (needs_vblank)
 		mtk_crtc->pending_needs_vblank = true;
 
@@ -625,7 +649,10 @@ static void mtk_crtc_update_config(struct mtk_crtc *mtk_crtc, bool needs_vblank)
 		mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0);
 	}
 #endif
+	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
 	mtk_crtc->config_updating = false;
+	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
+
 	mutex_unlock(&mtk_crtc->hw_lock);
 }
 
@@ -1068,6 +1095,7 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 		drm_mode_crtc_set_gamma_size(&mtk_crtc->base, gamma_lut_size);
 	drm_crtc_enable_color_mgmt(&mtk_crtc->base, 0, has_ctm, gamma_lut_size);
 	mutex_init(&mtk_crtc->hw_lock);
+	spin_lock_init(&mtk_crtc->config_lock);
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	i = priv->mbox_index++;
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index c003f970189b..0eb3db9c3d9e 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -65,6 +65,8 @@ void a5xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 
 static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a5xx_gpu *a5xx_gpu = to_a5xx_gpu(adreno_gpu);
 	struct msm_ringbuffer *ring = submit->ring;
 	struct drm_gem_object *obj;
 	uint32_t *ptr, dwords;
@@ -109,6 +111,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
 		}
 	}
 
+	a5xx_gpu->last_seqno[ring->id] = submit->seqno;
 	a5xx_flush(gpu, ring, true);
 	a5xx_preempt_trigger(gpu);
 
@@ -150,9 +153,13 @@ static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
 	OUT_RING(ring, 1);
 
-	/* Enable local preemption for finegrain preemption */
+	/*
+	 * Disable local preemption by default because it requires
+	 * user-space to be aware of it and provide additional handling
+	 * to restore rendering state or do various flushes on switch.
+	 */
 	OUT_PKT7(ring, CP_PREEMPT_ENABLE_LOCAL, 1);
-	OUT_RING(ring, 0x1);
+	OUT_RING(ring, 0x0);
 
 	/* Allow CP_CONTEXT_SWITCH_YIELD packets in the IB2 */
 	OUT_PKT7(ring, CP_YIELD_ENABLE, 1);
@@ -206,6 +213,7 @@ static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	/* Write the fence to the scratch register */
 	OUT_PKT4(ring, REG_A5XX_CP_SCRATCH_REG(2), 1);
 	OUT_RING(ring, submit->seqno);
+	a5xx_gpu->last_seqno[ring->id] = submit->seqno;
 
 	/*
 	 * Execute a CACHE_FLUSH_TS event. This will ensure that the
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
index c7187bcc5e90..9c0d701fe4b8 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
@@ -34,8 +34,10 @@ struct a5xx_gpu {
 	struct drm_gem_object *preempt_counters_bo[MSM_GPU_MAX_RINGS];
 	struct a5xx_preempt_record *preempt[MSM_GPU_MAX_RINGS];
 	uint64_t preempt_iova[MSM_GPU_MAX_RINGS];
+	uint32_t last_seqno[MSM_GPU_MAX_RINGS];
 
 	atomic_t preempt_state;
+	spinlock_t preempt_start_lock;
 	struct timer_list preempt_timer;
 
 	struct drm_gem_object *shadow_bo;
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
index f58dd564d122..0469fea55010 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
@@ -55,6 +55,8 @@ static inline void update_wptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 /* Return the highest priority ringbuffer with something in it */
 static struct msm_ringbuffer *get_next_ring(struct msm_gpu *gpu)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a5xx_gpu *a5xx_gpu = to_a5xx_gpu(adreno_gpu);
 	unsigned long flags;
 	int i;
 
@@ -64,6 +66,8 @@ static struct msm_ringbuffer *get_next_ring(struct msm_gpu *gpu)
 
 		spin_lock_irqsave(&ring->preempt_lock, flags);
 		empty = (get_wptr(ring) == gpu->funcs->get_rptr(gpu, ring));
+		if (!empty && ring == a5xx_gpu->cur_ring)
+			empty = ring->memptrs->fence == a5xx_gpu->last_seqno[i];
 		spin_unlock_irqrestore(&ring->preempt_lock, flags);
 
 		if (!empty)
@@ -97,12 +101,19 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
 	if (gpu->nr_rings == 1)
 		return;
 
+	/*
+	 * Serialize preemption start to ensure that we always make
+	 * decision on latest state. Otherwise we can get stuck in
+	 * lower priority or empty ring.
+	 */
+	spin_lock_irqsave(&a5xx_gpu->preempt_start_lock, flags);
+
 	/*
 	 * Try to start preemption by moving from NONE to START. If
 	 * unsuccessful, a preemption is already in flight
 	 */
 	if (!try_preempt_state(a5xx_gpu, PREEMPT_NONE, PREEMPT_START))
-		return;
+		goto out;
 
 	/* Get the next ring to preempt to */
 	ring = get_next_ring(gpu);
@@ -127,9 +138,11 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
 		set_preempt_state(a5xx_gpu, PREEMPT_ABORT);
 		update_wptr(gpu, a5xx_gpu->cur_ring);
 		set_preempt_state(a5xx_gpu, PREEMPT_NONE);
-		return;
+		goto out;
 	}
 
+	spin_unlock_irqrestore(&a5xx_gpu->preempt_start_lock, flags);
+
 	/* Make sure the wptr doesn't update while we're in motion */
 	spin_lock_irqsave(&ring->preempt_lock, flags);
 	a5xx_gpu->preempt[ring->id]->wptr = get_wptr(ring);
@@ -152,6 +165,10 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
 
 	/* And actually start the preemption */
 	gpu_write(gpu, REG_A5XX_CP_CONTEXT_SWITCH_CNTL, 1);
+	return;
+
+out:
+	spin_unlock_irqrestore(&a5xx_gpu->preempt_start_lock, flags);
 }
 
 void a5xx_preempt_irq(struct msm_gpu *gpu)
@@ -188,6 +205,12 @@ void a5xx_preempt_irq(struct msm_gpu *gpu)
 	update_wptr(gpu, a5xx_gpu->cur_ring);
 
 	set_preempt_state(a5xx_gpu, PREEMPT_NONE);
+
+	/*
+	 * Try to trigger preemption again in case there was a submit or
+	 * retire during ring switch
+	 */
+	a5xx_preempt_trigger(gpu);
 }
 
 void a5xx_preempt_hw_init(struct msm_gpu *gpu)
@@ -204,6 +227,8 @@ void a5xx_preempt_hw_init(struct msm_gpu *gpu)
 		return;
 
 	for (i = 0; i < gpu->nr_rings; i++) {
+		a5xx_gpu->preempt[i]->data = 0;
+		a5xx_gpu->preempt[i]->info = 0;
 		a5xx_gpu->preempt[i]->wptr = 0;
 		a5xx_gpu->preempt[i]->rptr = 0;
 		a5xx_gpu->preempt[i]->rbase = gpu->rb[i]->iova;
@@ -298,5 +323,6 @@ void a5xx_preempt_init(struct msm_gpu *gpu)
 		}
 	}
 
+	spin_lock_init(&a5xx_gpu->preempt_start_lock);
 	timer_setup(&a5xx_gpu->preempt_timer, a5xx_preempt_timer, 0);
 }
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 789a11416f7a..0fcae53c0b14 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -388,18 +388,18 @@ static void a7xx_get_debugbus_blocks(struct msm_gpu *gpu,
 	const u32 *debugbus_blocks, *gbif_debugbus_blocks;
 	int i;
 
-	if (adreno_is_a730(adreno_gpu)) {
+	if (adreno_gpu->info->family == ADRENO_7XX_GEN1) {
 		debugbus_blocks = gen7_0_0_debugbus_blocks;
 		debugbus_blocks_count = ARRAY_SIZE(gen7_0_0_debugbus_blocks);
 		gbif_debugbus_blocks = a7xx_gbif_debugbus_blocks;
 		gbif_debugbus_blocks_count = ARRAY_SIZE(a7xx_gbif_debugbus_blocks);
-	} else if (adreno_is_a740_family(adreno_gpu)) {
+	} else if (adreno_gpu->info->family == ADRENO_7XX_GEN2) {
 		debugbus_blocks = gen7_2_0_debugbus_blocks;
 		debugbus_blocks_count = ARRAY_SIZE(gen7_2_0_debugbus_blocks);
 		gbif_debugbus_blocks = a7xx_gbif_debugbus_blocks;
 		gbif_debugbus_blocks_count = ARRAY_SIZE(a7xx_gbif_debugbus_blocks);
 	} else {
-		BUG_ON(!adreno_is_a750(adreno_gpu));
+		BUG_ON(adreno_gpu->info->family != ADRENO_7XX_GEN3);
 		debugbus_blocks = gen7_9_0_debugbus_blocks;
 		debugbus_blocks_count = ARRAY_SIZE(gen7_9_0_debugbus_blocks);
 		gbif_debugbus_blocks = gen7_9_0_gbif_debugbus_blocks;
@@ -509,7 +509,7 @@ static void a6xx_get_debugbus(struct msm_gpu *gpu,
 		const struct a6xx_debugbus_block *cx_debugbus_blocks;
 
 		if (adreno_is_a7xx(adreno_gpu)) {
-			BUG_ON(!(adreno_is_a730(adreno_gpu) || adreno_is_a740_family(adreno_gpu)));
+			BUG_ON(adreno_gpu->info->family > ADRENO_7XX_GEN3);
 			cx_debugbus_blocks = a7xx_cx_debugbus_blocks;
 			nr_cx_debugbus_blocks = ARRAY_SIZE(a7xx_cx_debugbus_blocks);
 		} else {
@@ -660,13 +660,16 @@ static void a7xx_get_dbgahb_clusters(struct msm_gpu *gpu,
 	const struct gen7_sptp_cluster_registers *dbgahb_clusters;
 	unsigned dbgahb_clusters_size;
 
-	if (adreno_is_a730(adreno_gpu)) {
+	if (adreno_gpu->info->family == ADRENO_7XX_GEN1) {
 		dbgahb_clusters = gen7_0_0_sptp_clusters;
 		dbgahb_clusters_size = ARRAY_SIZE(gen7_0_0_sptp_clusters);
-	} else {
-		BUG_ON(!adreno_is_a740_family(adreno_gpu));
+	} else if (adreno_gpu->info->family == ADRENO_7XX_GEN2) {
 		dbgahb_clusters = gen7_2_0_sptp_clusters;
 		dbgahb_clusters_size = ARRAY_SIZE(gen7_2_0_sptp_clusters);
+	} else {
+		BUG_ON(adreno_gpu->info->family != ADRENO_7XX_GEN3);
+		dbgahb_clusters = gen7_9_0_sptp_clusters;
+		dbgahb_clusters_size = ARRAY_SIZE(gen7_9_0_sptp_clusters);
 	}
 
 	a6xx_state->dbgahb_clusters = state_kcalloc(a6xx_state,
@@ -818,14 +821,14 @@ static void a7xx_get_clusters(struct msm_gpu *gpu,
 	const struct gen7_cluster_registers *clusters;
 	unsigned clusters_size;
 
-	if (adreno_is_a730(adreno_gpu)) {
+	if (adreno_gpu->info->family == ADRENO_7XX_GEN1) {
 		clusters = gen7_0_0_clusters;
 		clusters_size = ARRAY_SIZE(gen7_0_0_clusters);
-	} else if (adreno_is_a740_family(adreno_gpu)) {
+	} else if (adreno_gpu->info->family == ADRENO_7XX_GEN2) {
 		clusters = gen7_2_0_clusters;
 		clusters_size = ARRAY_SIZE(gen7_2_0_clusters);
 	} else {
-		BUG_ON(!adreno_is_a750(adreno_gpu));
+		BUG_ON(adreno_gpu->info->family != ADRENO_7XX_GEN3);
 		clusters = gen7_9_0_clusters;
 		clusters_size = ARRAY_SIZE(gen7_9_0_clusters);
 	}
@@ -893,7 +896,7 @@ static void a7xx_get_shader_block(struct msm_gpu *gpu,
 	if (WARN_ON(datasize > A6XX_CD_DATA_SIZE))
 		return;
 
-	if (adreno_is_a730(adreno_gpu)) {
+	if (adreno_gpu->info->family == ADRENO_7XX_GEN1) {
 		gpu_rmw(gpu, REG_A7XX_SP_DBG_CNTL, GENMASK(1, 0), 3);
 	}
 
@@ -923,7 +926,7 @@ static void a7xx_get_shader_block(struct msm_gpu *gpu,
 		datasize);
 
 out:
-	if (adreno_is_a730(adreno_gpu)) {
+	if (adreno_gpu->info->family == ADRENO_7XX_GEN1) {
 		gpu_rmw(gpu, REG_A7XX_SP_DBG_CNTL, GENMASK(1, 0), 0);
 	}
 }
@@ -956,14 +959,14 @@ static void a7xx_get_shaders(struct msm_gpu *gpu,
 	unsigned num_shader_blocks;
 	int i;
 
-	if (adreno_is_a730(adreno_gpu)) {
+	if (adreno_gpu->info->family == ADRENO_7XX_GEN1) {
 		shader_blocks = gen7_0_0_shader_blocks;
 		num_shader_blocks = ARRAY_SIZE(gen7_0_0_shader_blocks);
-	} else if (adreno_is_a740_family(adreno_gpu)) {
+	} else if (adreno_gpu->info->family == ADRENO_7XX_GEN2) {
 		shader_blocks = gen7_2_0_shader_blocks;
 		num_shader_blocks = ARRAY_SIZE(gen7_2_0_shader_blocks);
 	} else {
-		BUG_ON(!adreno_is_a750(adreno_gpu));
+		BUG_ON(adreno_gpu->info->family != ADRENO_7XX_GEN3);
 		shader_blocks = gen7_9_0_shader_blocks;
 		num_shader_blocks = ARRAY_SIZE(gen7_9_0_shader_blocks);
 	}
@@ -1348,14 +1351,14 @@ static void a7xx_get_registers(struct msm_gpu *gpu,
 	const u32 *pre_crashdumper_regs;
 	const struct gen7_reg_list *reglist;
 
-	if (adreno_is_a730(adreno_gpu)) {
+	if (adreno_gpu->info->family == ADRENO_7XX_GEN1) {
 		reglist = gen7_0_0_reg_list;
 		pre_crashdumper_regs = gen7_0_0_pre_crashdumper_gpu_registers;
-	} else if (adreno_is_a740_family(adreno_gpu)) {
+	} else if (adreno_gpu->info->family == ADRENO_7XX_GEN2) {
 		reglist = gen7_2_0_reg_list;
 		pre_crashdumper_regs = gen7_0_0_pre_crashdumper_gpu_registers;
 	} else {
-		BUG_ON(!adreno_is_a750(adreno_gpu));
+		BUG_ON(adreno_gpu->info->family != ADRENO_7XX_GEN3);
 		reglist = gen7_9_0_reg_list;
 		pre_crashdumper_regs = gen7_9_0_pre_crashdumper_gpu_registers;
 	}
@@ -1405,8 +1408,7 @@ static void a7xx_get_post_crashdumper_registers(struct msm_gpu *gpu,
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	const u32 *regs;
 
-	BUG_ON(!(adreno_is_a730(adreno_gpu) || adreno_is_a740_family(adreno_gpu) ||
-		 adreno_is_a750(adreno_gpu)));
+	BUG_ON(adreno_gpu->info->family > ADRENO_7XX_GEN3);
 	regs = gen7_0_0_post_crashdumper_registers;
 
 	a7xx_get_ahb_gpu_registers(gpu,
@@ -1514,11 +1516,11 @@ static void a7xx_get_indexed_registers(struct msm_gpu *gpu,
 	const struct a6xx_indexed_registers *indexed_regs;
 	int i, indexed_count, mempool_count;
 
-	if (adreno_is_a730(adreno_gpu) || adreno_is_a740_family(adreno_gpu)) {
+	if (adreno_gpu->info->family <= ADRENO_7XX_GEN2) {
 		indexed_regs = a7xx_indexed_reglist;
 		indexed_count = ARRAY_SIZE(a7xx_indexed_reglist);
 	} else {
-		BUG_ON(!adreno_is_a750(adreno_gpu));
+		BUG_ON(adreno_gpu->info->family != ADRENO_7XX_GEN3);
 		indexed_regs = gen7_9_0_cp_indexed_reg_list;
 		indexed_count = ARRAY_SIZE(gen7_9_0_cp_indexed_reg_list);
 	}
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h b/drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h
index 260d66eccfec..9a327d543f27 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h
@@ -1303,7 +1303,7 @@ static struct a6xx_indexed_registers gen7_9_0_cp_indexed_reg_list[] = {
 		REG_A6XX_CP_ROQ_DBG_DATA, 0x00800},
 	{ "CP_UCODE_DBG_DATA", REG_A6XX_CP_SQE_UCODE_DBG_ADDR,
 		REG_A6XX_CP_SQE_UCODE_DBG_DATA, 0x08000},
-	{ "CP_BV_SQE_STAT_ADDR", REG_A7XX_CP_BV_DRAW_STATE_ADDR,
+	{ "CP_BV_DRAW_STATE_ADDR", REG_A7XX_CP_BV_DRAW_STATE_ADDR,
 		REG_A7XX_CP_BV_DRAW_STATE_DATA, 0x00200},
 	{ "CP_BV_ROQ_DBG_ADDR", REG_A7XX_CP_BV_ROQ_DBG_ADDR,
 		REG_A7XX_CP_BV_ROQ_DBG_DATA, 0x00800},
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index b93ed15f04a3..d5d9361e11aa 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -475,7 +475,7 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
 		ret = request_firmware_direct(&fw, fwname, drm->dev);
 		if (!ret) {
 			DRM_DEV_INFO(drm->dev, "loaded %s from legacy location\n",
-				newname);
+				fwname);
 			adreno_gpu->fwloc = FW_LOCATION_LEGACY;
 			goto out;
 		} else if (adreno_gpu->fwloc != FW_LOCATION_UNKNOWN) {
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
index 3a7f7edda96b..500b7dc895d0 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
@@ -351,7 +351,7 @@ void mdp5_smp_dump(struct mdp5_smp *smp, struct drm_printer *p,
 
 			drm_printf(p, "%s:%d\t%d\t%s\n",
 				pipe2name(pipe), j, inuse,
-				plane ? plane->name : NULL);
+				plane ? plane->name : "(null)");
 
 			total += inuse;
 		}
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 672a7ba52eda..9dc44ea85b7c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -119,7 +119,7 @@ struct msm_dp_desc {
 };
 
 static const struct msm_dp_desc sc7180_dp_descs[] = {
-	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0 },
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{}
 };
 
@@ -130,9 +130,9 @@ static const struct msm_dp_desc sc7280_dp_descs[] = {
 };
 
 static const struct msm_dp_desc sc8180x_dp_descs[] = {
-	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0 },
-	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1 },
-	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2 },
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
 	{}
 };
 
@@ -149,7 +149,7 @@ static const struct msm_dp_desc sc8280xp_dp_descs[] = {
 };
 
 static const struct msm_dp_desc sm8650_dp_descs[] = {
-	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0 },
+	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{}
 };
 
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 82d015aa2d63..29aa91238bc4 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -135,7 +135,7 @@ static void dsi_pll_calc_dec_frac(struct dsi_pll_7nm *pll, struct dsi_pll_config
 			config->pll_clock_inverters = 0x00;
 		else
 			config->pll_clock_inverters = 0x40;
-	} else {
+	} else if (pll->phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V4_1) {
 		if (pll_freq <= 1000000000ULL)
 			config->pll_clock_inverters = 0xa0;
 		else if (pll_freq <= 2500000000ULL)
@@ -144,6 +144,16 @@ static void dsi_pll_calc_dec_frac(struct dsi_pll_7nm *pll, struct dsi_pll_config
 			config->pll_clock_inverters = 0x00;
 		else
 			config->pll_clock_inverters = 0x40;
+	} else {
+		/* 4.2, 4.3 */
+		if (pll_freq <= 1000000000ULL)
+			config->pll_clock_inverters = 0xa0;
+		else if (pll_freq <= 2500000000ULL)
+			config->pll_clock_inverters = 0x20;
+		else if (pll_freq <= 3500000000ULL)
+			config->pll_clock_inverters = 0x00;
+		else
+			config->pll_clock_inverters = 0x40;
 	}
 
 	config->decimal_div_start = dec;
diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index 1fe6e0d883c7..675a649fa7ab 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -395,7 +395,7 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 	struct evergreen_cs_track *track = p->track;
 	struct eg_surface surf;
 	unsigned pitch, slice, mslice;
-	unsigned long offset;
+	u64 offset;
 	int r;
 
 	mslice = G_028C6C_SLICE_MAX(track->cb_color_view[id]) + 1;
@@ -433,14 +433,14 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 		return r;
 	}
 
-	offset = track->cb_color_bo_offset[id] << 8;
+	offset = (u64)track->cb_color_bo_offset[id] << 8;
 	if (offset & (surf.base_align - 1)) {
-		dev_warn(p->dev, "%s:%d cb[%d] bo base %ld not aligned with %ld\n",
+		dev_warn(p->dev, "%s:%d cb[%d] bo base %llu not aligned with %ld\n",
 			 __func__, __LINE__, id, offset, surf.base_align);
 		return -EINVAL;
 	}
 
-	offset += surf.layer_size * mslice;
+	offset += (u64)surf.layer_size * mslice;
 	if (offset > radeon_bo_size(track->cb_color_bo[id])) {
 		/* old ddx are broken they allocate bo with w*h*bpp but
 		 * program slice with ALIGN(h, 8), catch this and patch
@@ -448,14 +448,14 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 		 */
 		if (!surf.mode) {
 			uint32_t *ib = p->ib.ptr;
-			unsigned long tmp, nby, bsize, size, min = 0;
+			u64 tmp, nby, bsize, size, min = 0;
 
 			/* find the height the ddx wants */
 			if (surf.nby > 8) {
 				min = surf.nby - 8;
 			}
 			bsize = radeon_bo_size(track->cb_color_bo[id]);
-			tmp = track->cb_color_bo_offset[id] << 8;
+			tmp = (u64)track->cb_color_bo_offset[id] << 8;
 			for (nby = surf.nby; nby > min; nby--) {
 				size = nby * surf.nbx * surf.bpe * surf.nsamples;
 				if ((tmp + size * mslice) <= bsize) {
@@ -467,7 +467,7 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 				slice = ((nby * surf.nbx) / 64) - 1;
 				if (!evergreen_surface_check(p, &surf, "cb")) {
 					/* check if this one works */
-					tmp += surf.layer_size * mslice;
+					tmp += (u64)surf.layer_size * mslice;
 					if (tmp <= bsize) {
 						ib[track->cb_color_slice_idx[id]] = slice;
 						goto old_ddx_ok;
@@ -476,9 +476,9 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 			}
 		}
 		dev_warn(p->dev, "%s:%d cb[%d] bo too small (layer size %d, "
-			 "offset %d, max layer %d, bo size %ld, slice %d)\n",
+			 "offset %llu, max layer %d, bo size %ld, slice %d)\n",
 			 __func__, __LINE__, id, surf.layer_size,
-			track->cb_color_bo_offset[id] << 8, mslice,
+			(u64)track->cb_color_bo_offset[id] << 8, mslice,
 			radeon_bo_size(track->cb_color_bo[id]), slice);
 		dev_warn(p->dev, "%s:%d problematic surf: (%d %d) (%d %d %d %d %d %d %d)\n",
 			 __func__, __LINE__, surf.nbx, surf.nby,
@@ -562,7 +562,7 @@ static int evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
 	struct evergreen_cs_track *track = p->track;
 	struct eg_surface surf;
 	unsigned pitch, slice, mslice;
-	unsigned long offset;
+	u64 offset;
 	int r;
 
 	mslice = G_028008_SLICE_MAX(track->db_depth_view) + 1;
@@ -608,18 +608,18 @@ static int evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
 		return r;
 	}
 
-	offset = track->db_s_read_offset << 8;
+	offset = (u64)track->db_s_read_offset << 8;
 	if (offset & (surf.base_align - 1)) {
-		dev_warn(p->dev, "%s:%d stencil read bo base %ld not aligned with %ld\n",
+		dev_warn(p->dev, "%s:%d stencil read bo base %llu not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
 		return -EINVAL;
 	}
-	offset += surf.layer_size * mslice;
+	offset += (u64)surf.layer_size * mslice;
 	if (offset > radeon_bo_size(track->db_s_read_bo)) {
 		dev_warn(p->dev, "%s:%d stencil read bo too small (layer size %d, "
-			 "offset %ld, max layer %d, bo size %ld)\n",
+			 "offset %llu, max layer %d, bo size %ld)\n",
 			 __func__, __LINE__, surf.layer_size,
-			(unsigned long)track->db_s_read_offset << 8, mslice,
+			(u64)track->db_s_read_offset << 8, mslice,
 			radeon_bo_size(track->db_s_read_bo));
 		dev_warn(p->dev, "%s:%d stencil invalid (0x%08x 0x%08x 0x%08x 0x%08x)\n",
 			 __func__, __LINE__, track->db_depth_size,
@@ -627,18 +627,18 @@ static int evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
 		return -EINVAL;
 	}
 
-	offset = track->db_s_write_offset << 8;
+	offset = (u64)track->db_s_write_offset << 8;
 	if (offset & (surf.base_align - 1)) {
-		dev_warn(p->dev, "%s:%d stencil write bo base %ld not aligned with %ld\n",
+		dev_warn(p->dev, "%s:%d stencil write bo base %llu not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
 		return -EINVAL;
 	}
-	offset += surf.layer_size * mslice;
+	offset += (u64)surf.layer_size * mslice;
 	if (offset > radeon_bo_size(track->db_s_write_bo)) {
 		dev_warn(p->dev, "%s:%d stencil write bo too small (layer size %d, "
-			 "offset %ld, max layer %d, bo size %ld)\n",
+			 "offset %llu, max layer %d, bo size %ld)\n",
 			 __func__, __LINE__, surf.layer_size,
-			(unsigned long)track->db_s_write_offset << 8, mslice,
+			(u64)track->db_s_write_offset << 8, mslice,
 			radeon_bo_size(track->db_s_write_bo));
 		return -EINVAL;
 	}
@@ -659,7 +659,7 @@ static int evergreen_cs_track_validate_depth(struct radeon_cs_parser *p)
 	struct evergreen_cs_track *track = p->track;
 	struct eg_surface surf;
 	unsigned pitch, slice, mslice;
-	unsigned long offset;
+	u64 offset;
 	int r;
 
 	mslice = G_028008_SLICE_MAX(track->db_depth_view) + 1;
@@ -706,34 +706,34 @@ static int evergreen_cs_track_validate_depth(struct radeon_cs_parser *p)
 		return r;
 	}
 
-	offset = track->db_z_read_offset << 8;
+	offset = (u64)track->db_z_read_offset << 8;
 	if (offset & (surf.base_align - 1)) {
-		dev_warn(p->dev, "%s:%d stencil read bo base %ld not aligned with %ld\n",
+		dev_warn(p->dev, "%s:%d stencil read bo base %llu not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
 		return -EINVAL;
 	}
-	offset += surf.layer_size * mslice;
+	offset += (u64)surf.layer_size * mslice;
 	if (offset > radeon_bo_size(track->db_z_read_bo)) {
 		dev_warn(p->dev, "%s:%d depth read bo too small (layer size %d, "
-			 "offset %ld, max layer %d, bo size %ld)\n",
+			 "offset %llu, max layer %d, bo size %ld)\n",
 			 __func__, __LINE__, surf.layer_size,
-			(unsigned long)track->db_z_read_offset << 8, mslice,
+			(u64)track->db_z_read_offset << 8, mslice,
 			radeon_bo_size(track->db_z_read_bo));
 		return -EINVAL;
 	}
 
-	offset = track->db_z_write_offset << 8;
+	offset = (u64)track->db_z_write_offset << 8;
 	if (offset & (surf.base_align - 1)) {
-		dev_warn(p->dev, "%s:%d stencil write bo base %ld not aligned with %ld\n",
+		dev_warn(p->dev, "%s:%d stencil write bo base %llu not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
 		return -EINVAL;
 	}
-	offset += surf.layer_size * mslice;
+	offset += (u64)surf.layer_size * mslice;
 	if (offset > radeon_bo_size(track->db_z_write_bo)) {
 		dev_warn(p->dev, "%s:%d depth write bo too small (layer size %d, "
-			 "offset %ld, max layer %d, bo size %ld)\n",
+			 "offset %llu, max layer %d, bo size %ld)\n",
 			 __func__, __LINE__, surf.layer_size,
-			(unsigned long)track->db_z_write_offset << 8, mslice,
+			(u64)track->db_z_write_offset << 8, mslice,
 			radeon_bo_size(track->db_z_write_bo));
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 10793a433bf5..d698a899eaf4 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -1717,26 +1717,29 @@ struct radeon_encoder_atom_dig *radeon_atombios_get_lvds_info(struct
 					fake_edid_record = (ATOM_FAKE_EDID_PATCH_RECORD *)record;
 					if (fake_edid_record->ucFakeEDIDLength) {
 						struct edid *edid;
-						int edid_size =
-							max((int)EDID_LENGTH, (int)fake_edid_record->ucFakeEDIDLength);
-						edid = kmalloc(edid_size, GFP_KERNEL);
+						int edid_size;
+
+						if (fake_edid_record->ucFakeEDIDLength == 128)
+							edid_size = fake_edid_record->ucFakeEDIDLength;
+						else
+							edid_size = fake_edid_record->ucFakeEDIDLength * 128;
+						edid = kmemdup(&fake_edid_record->ucFakeEDIDString[0],
+							       edid_size, GFP_KERNEL);
 						if (edid) {
-							memcpy((u8 *)edid, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
-							       fake_edid_record->ucFakeEDIDLength);
-
 							if (drm_edid_is_valid(edid)) {
 								rdev->mode_info.bios_hardcoded_edid = edid;
 								rdev->mode_info.bios_hardcoded_edid_size = edid_size;
-							} else
+							} else {
 								kfree(edid);
+							}
 						}
+						record += struct_size(fake_edid_record,
+								      ucFakeEDIDString,
+								      edid_size);
+					} else {
+						/* empty fake edid record must be 3 bytes long */
+						record += sizeof(ATOM_FAKE_EDID_PATCH_RECORD) + 1;
 					}
-					record += fake_edid_record->ucFakeEDIDLength ?
-						  struct_size(fake_edid_record,
-							      ucFakeEDIDString,
-							      fake_edid_record->ucFakeEDIDLength) :
-						  /* empty fake edid record must be 3 bytes long */
-						  sizeof(ATOM_FAKE_EDID_PATCH_RECORD) + 1;
 					break;
 				case LCD_PANEL_RESOLUTION_RECORD_TYPE:
 					panel_res_record = (ATOM_PANEL_RESOLUTION_PATCH_RECORD *)record;
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index fe33092abbe7..aae48e906af1 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -434,6 +434,8 @@ static void dw_hdmi_rk3328_setup_hpd(struct dw_hdmi *dw_hdmi, void *data)
 		HIWORD_UPDATE(RK3328_HDMI_SDAIN_MSK | RK3328_HDMI_SCLIN_MSK,
 			      RK3328_HDMI_SDAIN_MSK | RK3328_HDMI_SCLIN_MSK |
 			      RK3328_HDMI_HPD_IOE));
+
+	dw_hdmi_rk3328_read_hpd(dw_hdmi, data);
 }
 
 static const struct dw_hdmi_phy_ops rk3228_hdmi_phy_ops = {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a13473b2d54c..4a9c6ea7f15d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -396,8 +396,8 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 	if (info->is_yuv)
 		is_yuv = true;
 
-	if (dst_w > 3840) {
-		DRM_DEV_ERROR(vop->dev, "Maximum dst width (3840) exceeded\n");
+	if (dst_w > 4096) {
+		DRM_DEV_ERROR(vop->dev, "Maximum dst width (4096) exceeded\n");
 		return;
 	}
 
diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index e8523abef27a..4d2db079ad4f 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -203,12 +203,14 @@ static int stm_drm_platform_probe(struct platform_device *pdev)
 
 	ret = drm_dev_register(ddev, 0);
 	if (ret)
-		goto err_put;
+		goto err_unload;
 
 	drm_fbdev_dma_setup(ddev, 16);
 
 	return 0;
 
+err_unload:
+	drv_unload(ddev);
 err_put:
 	drm_dev_put(ddev);
 
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 5576fdae4962..5aec1e58c968 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1580,6 +1580,8 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 			       ARRAY_SIZE(ltdc_drm_fmt_ycbcr_sp) +
 			       ARRAY_SIZE(ltdc_drm_fmt_ycbcr_fp)) *
 			       sizeof(*formats), GFP_KERNEL);
+	if (!formats)
+		return NULL;
 
 	for (i = 0; i < ldev->caps.pix_fmt_nb; i++) {
 		drm_fmt = ldev->caps.pix_fmt_drm[i];
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index d30f8e8e8967..c75bd5af2cef 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -462,6 +462,7 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
 {
 	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
 	enum drm_connector_status status = connector_status_disconnected;
+	int ret;
 
 	/*
 	 * NOTE: This function should really take vc4_hdmi->mutex, but
@@ -474,7 +475,12 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
 	 * the lock for now.
 	 */
 
-	WARN_ON(pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev));
+	ret = pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev);
+	if (ret) {
+		drm_err_once(connector->dev, "Failed to retain HDMI power domain: %d\n",
+			     ret);
+		return connector_status_unknown;
+	}
 
 	if (vc4_hdmi->hpd_gpio) {
 		if (gpiod_get_value_cansleep(vc4_hdmi->hpd_gpio))
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index d84740be9642..7660f62e6c1f 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2368,6 +2368,9 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 		wacom_map_usage(input, usage, field, EV_KEY, BTN_STYLUS3, 0);
 		features->quirks &= ~WACOM_QUIRK_PEN_BUTTON3;
 		break;
+	case WACOM_HID_WD_SEQUENCENUMBER:
+		wacom_wac->hid_data.sequence_number = -1;
+		break;
 	}
 }
 
@@ -2492,9 +2495,15 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 		wacom_wac->hid_data.barrelswitch3 = value;
 		return;
 	case WACOM_HID_WD_SEQUENCENUMBER:
-		if (wacom_wac->hid_data.sequence_number != value)
-			hid_warn(hdev, "Dropped %hu packets", (unsigned short)(value - wacom_wac->hid_data.sequence_number));
+		if (wacom_wac->hid_data.sequence_number != value &&
+		    wacom_wac->hid_data.sequence_number >= 0) {
+			int sequence_size = field->logical_maximum - field->logical_minimum + 1;
+			int drop_count = (value - wacom_wac->hid_data.sequence_number) % sequence_size;
+			hid_warn(hdev, "Dropped %d packets", drop_count);
+		}
 		wacom_wac->hid_data.sequence_number = value + 1;
+		if (wacom_wac->hid_data.sequence_number > field->logical_maximum)
+			wacom_wac->hid_data.sequence_number = field->logical_minimum;
 		return;
 	}
 
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 6ec499841f70..e6443740b462 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -324,7 +324,7 @@ struct hid_data {
 	int bat_connected;
 	int ps_connected;
 	bool pad_input_event_flag;
-	unsigned short sequence_number;
+	int sequence_number;
 	ktime_t time_delayed;
 };
 
diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index aa38c45adc09..0ccb5eb596fc 100644
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -79,7 +79,7 @@ static const bool max16065_have_current[] = {
 };
 
 struct max16065_data {
-	enum chips type;
+	enum chips chip;
 	struct i2c_client *client;
 	const struct attribute_group *groups[4];
 	struct mutex update_lock;
@@ -114,9 +114,10 @@ static inline int LIMIT_TO_MV(int limit, int range)
 	return limit * range / 256;
 }
 
-static inline int MV_TO_LIMIT(int mv, int range)
+static inline int MV_TO_LIMIT(unsigned long mv, int range)
 {
-	return clamp_val(DIV_ROUND_CLOSEST(mv * 256, range), 0, 255);
+	mv = clamp_val(mv, 0, ULONG_MAX / 256);
+	return DIV_ROUND_CLOSEST(clamp_val(mv * 256, 0, range * 255), range);
 }
 
 static inline int ADC_TO_CURR(int adc, int gain)
@@ -161,10 +162,17 @@ static struct max16065_data *max16065_update_device(struct device *dev)
 						     MAX16065_CURR_SENSE);
 		}
 
-		for (i = 0; i < DIV_ROUND_UP(data->num_adc, 8); i++)
+		for (i = 0; i < 2; i++)
 			data->fault[i]
 			  = i2c_smbus_read_byte_data(client, MAX16065_FAULT(i));
 
+		/*
+		 * MAX16067 and MAX16068 have separate undervoltage and
+		 * overvoltage alarm bits. Squash them together.
+		 */
+		if (data->chip == max16067 || data->chip == max16068)
+			data->fault[0] |= data->fault[1];
+
 		data->last_updated = jiffies;
 		data->valid = true;
 	}
@@ -493,8 +501,6 @@ static const struct attribute_group max16065_max_group = {
 	.is_visible = max16065_secondary_is_visible,
 };
 
-static const struct i2c_device_id max16065_id[];
-
 static int max16065_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
@@ -505,7 +511,7 @@ static int max16065_probe(struct i2c_client *client)
 	bool have_secondary;		/* true if chip has secondary limits */
 	bool secondary_is_max = false;	/* secondary limits reflect max */
 	int groups = 0;
-	const struct i2c_device_id *id = i2c_match_id(max16065_id, client);
+	enum chips chip = (uintptr_t)i2c_get_match_data(client);
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA
 				     | I2C_FUNC_SMBUS_READ_WORD_DATA))
@@ -515,12 +521,13 @@ static int max16065_probe(struct i2c_client *client)
 	if (unlikely(!data))
 		return -ENOMEM;
 
+	data->chip = chip;
 	data->client = client;
 	mutex_init(&data->update_lock);
 
-	data->num_adc = max16065_num_adc[id->driver_data];
-	data->have_current = max16065_have_current[id->driver_data];
-	have_secondary = max16065_have_secondary[id->driver_data];
+	data->num_adc = max16065_num_adc[chip];
+	data->have_current = max16065_have_current[chip];
+	have_secondary = max16065_have_secondary[chip];
 
 	if (have_secondary) {
 		val = i2c_smbus_read_byte_data(client, MAX16065_SW_ENABLE);
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index ef75b63f5894..b5352900463f 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -62,6 +62,7 @@ static const struct platform_device_id ntc_thermistor_id[] = {
 	[NTC_SSG1404001221]   = { "ssg1404_001221",  TYPE_NCPXXWB473 },
 	[NTC_LAST]            = { },
 };
+MODULE_DEVICE_TABLE(platform, ntc_thermistor_id);
 
 /*
  * A compensation table should be sorted by the values of .ohm
diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
index ac70c0b491be..dab389a5507c 100644
--- a/drivers/hwtracing/coresight/coresight-dummy.c
+++ b/drivers/hwtracing/coresight/coresight-dummy.c
@@ -23,6 +23,9 @@ DEFINE_CORESIGHT_DEVLIST(sink_devs, "dummy_sink");
 static int dummy_source_enable(struct coresight_device *csdev,
 			       struct perf_event *event, enum cs_mode mode)
 {
+	if (!coresight_take_mode(csdev, mode))
+		return -EBUSY;
+
 	dev_dbg(csdev->dev.parent, "Dummy source enabled\n");
 
 	return 0;
@@ -31,6 +34,7 @@ static int dummy_source_enable(struct coresight_device *csdev,
 static void dummy_source_disable(struct coresight_device *csdev,
 				 struct perf_event *event)
 {
+	coresight_set_mode(csdev, CS_MODE_DISABLED);
 	dev_dbg(csdev->dev.parent, "Dummy source disabled\n");
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index e75428fa1592..610ad51cda65 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -261,6 +261,7 @@ void tmc_free_sg_table(struct tmc_sg_table *sg_table)
 {
 	tmc_free_table_pages(sg_table);
 	tmc_free_data_pages(sg_table);
+	kfree(sg_table);
 }
 EXPORT_SYMBOL_GPL(tmc_free_sg_table);
 
@@ -342,7 +343,6 @@ struct tmc_sg_table *tmc_alloc_sg_table(struct device *dev,
 		rc = tmc_alloc_table_pages(sg_table);
 	if (rc) {
 		tmc_free_sg_table(sg_table);
-		kfree(sg_table);
 		return ERR_PTR(rc);
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 0726f8842552..5c5a4b3fe687 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -449,6 +449,11 @@ static int tpdm_enable(struct coresight_device *csdev, struct perf_event *event,
 		return -EBUSY;
 	}
 
+	if (!coresight_take_mode(csdev, mode)) {
+		spin_unlock(&drvdata->spinlock);
+		return -EBUSY;
+	}
+
 	__tpdm_enable(drvdata);
 	drvdata->enable = true;
 	spin_unlock(&drvdata->spinlock);
@@ -506,6 +511,7 @@ static void tpdm_disable(struct coresight_device *csdev,
 	}
 
 	__tpdm_disable(drvdata);
+	coresight_set_mode(csdev, CS_MODE_DISABLED);
 	drvdata->enable = false;
 	spin_unlock(&drvdata->spinlock);
 
diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index ce8c4846b7fa..2a03a221e2dd 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -170,6 +170,13 @@ struct aspeed_i2c_bus {
 
 static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus);
 
+/* precondition: bus.lock has been acquired. */
+static void aspeed_i2c_do_stop(struct aspeed_i2c_bus *bus)
+{
+	bus->master_state = ASPEED_I2C_MASTER_STOP;
+	writel(ASPEED_I2CD_M_STOP_CMD, bus->base + ASPEED_I2C_CMD_REG);
+}
+
 static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
 {
 	unsigned long time_left, flags;
@@ -187,7 +194,7 @@ static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
 			command);
 
 		reinit_completion(&bus->cmd_complete);
-		writel(ASPEED_I2CD_M_STOP_CMD, bus->base + ASPEED_I2C_CMD_REG);
+		aspeed_i2c_do_stop(bus);
 		spin_unlock_irqrestore(&bus->lock, flags);
 
 		time_left = wait_for_completion_timeout(
@@ -390,13 +397,6 @@ static void aspeed_i2c_do_start(struct aspeed_i2c_bus *bus)
 	writel(command, bus->base + ASPEED_I2C_CMD_REG);
 }
 
-/* precondition: bus.lock has been acquired. */
-static void aspeed_i2c_do_stop(struct aspeed_i2c_bus *bus)
-{
-	bus->master_state = ASPEED_I2C_MASTER_STOP;
-	writel(ASPEED_I2CD_M_STOP_CMD, bus->base + ASPEED_I2C_CMD_REG);
-}
-
 /* precondition: bus.lock has been acquired. */
 static void aspeed_i2c_next_msg_or_stop(struct aspeed_i2c_bus *bus)
 {
diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index 416a9968ed28..8b225412be5b 100644
--- a/drivers/i2c/busses/i2c-isch.c
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -99,8 +99,7 @@ static int sch_transaction(void)
 	if (retries > MAX_RETRIES) {
 		dev_err(&sch_adapter.dev, "SMBus Timeout!\n");
 		result = -ETIMEDOUT;
-	}
-	if (temp & 0x04) {
+	} else if (temp & 0x04) {
 		result = -EIO;
 		dev_dbg(&sch_adapter.dev, "Bus collision! SMBus may be "
 			"locked until next hard reset. (sorry!)\n");
diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 1c08c0921ee7..4d755ffc3f41 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -215,9 +215,9 @@ static int ad7606_write_os_hw(struct iio_dev *indio_dev, int val)
 	struct ad7606_state *st = iio_priv(indio_dev);
 	DECLARE_BITMAP(values, 3);
 
-	values[0] = val;
+	values[0] = val & GENMASK(2, 0);
 
-	gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
+	gpiod_set_array_value(st->gpio_os->ndescs, st->gpio_os->desc,
 			      st->gpio_os->info, values);
 
 	/* AD7616 requires a reset to update value */
@@ -422,7 +422,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 		return PTR_ERR(st->gpio_range);
 
 	st->gpio_standby = devm_gpiod_get_optional(dev, "standby",
-						   GPIOD_OUT_HIGH);
+						   GPIOD_OUT_LOW);
 	if (IS_ERR(st->gpio_standby))
 		return PTR_ERR(st->gpio_standby);
 
@@ -665,7 +665,7 @@ static int ad7606_suspend(struct device *dev)
 
 	if (st->gpio_standby) {
 		gpiod_set_value(st->gpio_range, 1);
-		gpiod_set_value(st->gpio_standby, 0);
+		gpiod_set_value(st->gpio_standby, 1);
 	}
 
 	return 0;
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 263a778bcf25..287a0591533b 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -249,8 +249,9 @@ static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
 static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	unsigned long os[3] = {1};
+	DECLARE_BITMAP(os, 3);
 
+	bitmap_fill(os, 3);
 	/*
 	 * Software mode is enabled when all three oversampling
 	 * pins are set to high. If oversampling gpios are defined
@@ -258,7 +259,7 @@ static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 	 * otherwise, they must be hardwired to VDD
 	 */
 	if (st->gpio_os) {
-		gpiod_set_array_value(ARRAY_SIZE(os),
+		gpiod_set_array_value(st->gpio_os->ndescs,
 				      st->gpio_os->desc, st->gpio_os->info, os);
 	}
 	/* OS of 128 and 256 are available only in software mode */
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 500f56834b01..a6bf689833da 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -10,6 +10,7 @@
  */
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -52,6 +53,7 @@ struct bme680_calib {
 struct bme680_data {
 	struct regmap *regmap;
 	struct bme680_calib bme680;
+	struct mutex lock; /* Protect multiple serial R/W ops to device. */
 	u8 oversampling_temp;
 	u8 oversampling_press;
 	u8 oversampling_humid;
@@ -827,6 +829,8 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 {
 	struct bme680_data *data = iio_priv(indio_dev);
 
+	guard(mutex)(&data->lock);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
@@ -871,6 +875,8 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 {
 	struct bme680_data *data = iio_priv(indio_dev);
 
+	guard(mutex)(&data->lock);
+
 	if (val2 != 0)
 		return -EINVAL;
 
@@ -967,6 +973,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		name = bme680_match_acpi_device(dev);
 
 	data = iio_priv(indio_dev);
+	mutex_init(&data->lock);
 	dev_set_drvdata(dev, indio_dev);
 	data->regmap = regmap;
 	indio_dev->name = name;
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index dd466c5fa621..ccbebe5b66cd 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -1081,7 +1081,6 @@ static const struct of_device_id ak8975_of_match[] = {
 	{ .compatible = "asahi-kasei,ak09912", .data = &ak_def_array[AK09912] },
 	{ .compatible = "ak09912", .data = &ak_def_array[AK09912] },
 	{ .compatible = "asahi-kasei,ak09916", .data = &ak_def_array[AK09916] },
-	{ .compatible = "ak09916", .data = &ak_def_array[AK09916] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ak8975_of_match);
diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 6791df64a5fe..b7c078b7f7cf 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1640,8 +1640,10 @@ int ib_cache_setup_one(struct ib_device *device)
 
 	rdma_for_each_port (device, p) {
 		err = ib_cache_update(device, p, true, true, true);
-		if (err)
+		if (err) {
+			gid_table_cleanup_one(device);
 			return err;
+		}
 	}
 
 	return 0;
diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index bf3265e67865..7d85fe410042 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -1190,7 +1190,7 @@ static int __init iw_cm_init(void)
 	if (ret)
 		return ret;
 
-	iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", 0);
+	iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", WQ_MEM_RECLAIM);
 	if (!iwcm_wq)
 		goto err_alloc;
 
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 040ba2224f9f..b3757c6a0457 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -1222,6 +1222,8 @@ static int act_establish(struct c4iw_dev *dev, struct sk_buff *skb)
 	int ret;
 
 	ep = lookup_atid(t, atid);
+	if (!ep)
+		return -EINVAL;
 
 	pr_debug("ep %p tid %u snd_isn %u rcv_isn %u\n", ep, tid,
 		 be32_to_cpu(req->snd_isn), be32_to_cpu(req->rcv_isn));
@@ -2279,6 +2281,9 @@ static int act_open_rpl(struct c4iw_dev *dev, struct sk_buff *skb)
 	int ret = 0;
 
 	ep = lookup_atid(t, atid);
+	if (!ep)
+		return -EINVAL;
+
 	la = (struct sockaddr_in *)&ep->com.local_addr;
 	ra = (struct sockaddr_in *)&ep->com.remote_addr;
 	la6 = (struct sockaddr_in6 *)&ep->com.local_addr;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 40c9b6e46b82..3e3a3e1c241e 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1544,11 +1544,31 @@ int erdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 	return ret;
 }
 
+static enum ib_qp_state query_qp_state(struct erdma_qp *qp)
+{
+	switch (qp->attrs.state) {
+	case ERDMA_QP_STATE_IDLE:
+		return IB_QPS_INIT;
+	case ERDMA_QP_STATE_RTR:
+		return IB_QPS_RTR;
+	case ERDMA_QP_STATE_RTS:
+		return IB_QPS_RTS;
+	case ERDMA_QP_STATE_CLOSING:
+		return IB_QPS_ERR;
+	case ERDMA_QP_STATE_TERMINATE:
+		return IB_QPS_ERR;
+	case ERDMA_QP_STATE_ERROR:
+		return IB_QPS_ERR;
+	default:
+		return IB_QPS_ERR;
+	}
+}
+
 int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		   int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr)
 {
-	struct erdma_qp *qp;
 	struct erdma_dev *dev;
+	struct erdma_qp *qp;
 
 	if (ibqp && qp_attr && qp_init_attr) {
 		qp = to_eqp(ibqp);
@@ -1575,6 +1595,9 @@ int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 
 	qp_init_attr->cap = qp_attr->cap;
 
+	qp_attr->qp_state = query_qp_state(qp);
+	qp_attr->cur_qp_state = query_qp_state(qp);
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 3e02c474f59f..4fc5b9d5fea8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -64,8 +64,10 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	u8 tc_mode = 0;
 	int ret;
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 && udata)
-		return -EOPNOTSUPP;
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 && udata) {
+		ret = -EOPNOTSUPP;
+		goto err_out;
+	}
 
 	ah->av.port = rdma_ah_get_port_num(ah_attr);
 	ah->av.gid_index = grh->sgid_index;
@@ -83,7 +85,7 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		ret = 0;
 
 	if (ret && grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
-		return ret;
+		goto err_out;
 
 	if (tc_mode == HNAE3_TC_MAP_MODE_DSCP &&
 	    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
@@ -91,8 +93,10 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	else
 		ah->av.sl = rdma_ah_get_sl(ah_attr);
 
-	if (!check_sl_valid(hr_dev, ah->av.sl))
-		return -EINVAL;
+	if (!check_sl_valid(hr_dev, ah->av.sl)) {
+		ret = -EINVAL;
+		goto err_out;
+	}
 
 	memcpy(ah->av.dgid, grh->dgid.raw, HNS_ROCE_GID_SIZE);
 	memcpy(ah->av.mac, ah_attr->roce.dmac, ETH_ALEN);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 02baa853a76c..c7c167e2a045 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1041,9 +1041,9 @@ static bool hem_list_is_bottom_bt(int hopnum, int bt_level)
  * @bt_level: base address table level
  * @unit: ba entries per bt page
  */
-static u32 hem_list_calc_ba_range(int hopnum, int bt_level, int unit)
+static u64 hem_list_calc_ba_range(int hopnum, int bt_level, int unit)
 {
-	u32 step;
+	u64 step;
 	int max;
 	int i;
 
@@ -1079,7 +1079,7 @@ int hns_roce_hem_list_calc_root_ba(const struct hns_roce_buf_region *regions,
 {
 	struct hns_roce_buf_region *r;
 	int total = 0;
-	int step;
+	u64 step;
 	int i;
 
 	for (i = 0; i < region_cnt; i++) {
@@ -1110,7 +1110,7 @@ static int hem_list_alloc_mid_bt(struct hns_roce_dev *hr_dev,
 	int ret = 0;
 	int max_ofs;
 	int level;
-	u32 step;
+	u64 step;
 	int end;
 
 	if (hopnum <= 1)
@@ -1134,10 +1134,12 @@ static int hem_list_alloc_mid_bt(struct hns_roce_dev *hr_dev,
 
 	/* config L1 bt to last bt and link them to corresponding parent */
 	for (level = 1; level < hopnum; level++) {
-		cur = hem_list_search_item(&mid_bt[level], offset);
-		if (cur) {
-			hem_ptrs[level] = cur;
-			continue;
+		if (!hem_list_is_bottom_bt(hopnum, level)) {
+			cur = hem_list_search_item(&mid_bt[level], offset);
+			if (cur) {
+				hem_ptrs[level] = cur;
+				continue;
+			}
 		}
 
 		step = hem_list_calc_ba_range(hopnum, level, unit);
@@ -1147,7 +1149,7 @@ static int hem_list_alloc_mid_bt(struct hns_roce_dev *hr_dev,
 		}
 
 		start_aligned = (distance / step) * step + r->offset;
-		end = min_t(int, start_aligned + step - 1, max_ofs);
+		end = min_t(u64, start_aligned + step - 1, max_ofs);
 		cur = hem_list_alloc_item(hr_dev, start_aligned, end, unit,
 					  true);
 		if (!cur) {
@@ -1235,7 +1237,7 @@ static int setup_middle_bt(struct hns_roce_dev *hr_dev, void *cpu_base,
 	struct hns_roce_hem_item *hem, *temp_hem;
 	int total = 0;
 	int offset;
-	int step;
+	u64 step;
 
 	step = hem_list_calc_ba_range(r->hopnum, 1, unit);
 	if (step < 1)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 621b057fb9da..24e906b9d3ae 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1681,8 +1681,8 @@ static int hns_roce_hw_v2_query_counter(struct hns_roce_dev *hr_dev,
 
 	for (i = 0; i < HNS_ROCE_HW_CNT_TOTAL && i < *num_counters; i++) {
 		bd_idx = i / CNT_PER_DESC;
-		if (!(desc[bd_idx].flag & HNS_ROCE_CMD_FLAG_NEXT) &&
-		    bd_idx != HNS_ROCE_HW_CNT_TOTAL / CNT_PER_DESC)
+		if (bd_idx != HNS_ROCE_HW_CNT_TOTAL / CNT_PER_DESC &&
+		    !(desc[bd_idx].flag & cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT)))
 			break;
 
 		cnt_data = (__le64 *)&desc[bd_idx].data[0];
@@ -2972,6 +2972,9 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 
 static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 {
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08)
+		free_mr_exit(hr_dev);
+
 	hns_roce_function_clear(hr_dev);
 
 	if (!hr_dev->is_vf)
@@ -4423,12 +4426,14 @@ static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
 		     upper_32_bits(to_hr_hw_page_addr(mtts[0])));
 	hr_reg_clear(qpc_mask, QPC_RQ_CUR_BLK_ADDR_H);
 
-	context->rq_nxt_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[1]));
-	qpc_mask->rq_nxt_blk_addr = 0;
-
-	hr_reg_write(context, QPC_RQ_NXT_BLK_ADDR_H,
-		     upper_32_bits(to_hr_hw_page_addr(mtts[1])));
-	hr_reg_clear(qpc_mask, QPC_RQ_NXT_BLK_ADDR_H);
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
+		context->rq_nxt_blk_addr =
+				cpu_to_le32(to_hr_hw_page_addr(mtts[1]));
+		qpc_mask->rq_nxt_blk_addr = 0;
+		hr_reg_write(context, QPC_RQ_NXT_BLK_ADDR_H,
+			     upper_32_bits(to_hr_hw_page_addr(mtts[1])));
+		hr_reg_clear(qpc_mask, QPC_RQ_NXT_BLK_ADDR_H);
+	}
 
 	return 0;
 }
@@ -6193,6 +6198,7 @@ static irqreturn_t abnormal_interrupt_basic(struct hns_roce_dev *hr_dev,
 	struct pci_dev *pdev = hr_dev->pci_dev;
 	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(pdev);
 	const struct hnae3_ae_ops *ops = ae_dev->ops;
+	enum hnae3_reset_type reset_type;
 	irqreturn_t int_work = IRQ_NONE;
 	u32 int_en;
 
@@ -6204,10 +6210,12 @@ static irqreturn_t abnormal_interrupt_basic(struct hns_roce_dev *hr_dev,
 		roce_write(hr_dev, ROCEE_VF_ABN_INT_ST_REG,
 			   1 << HNS_ROCE_V2_VF_INT_ST_AEQ_OVERFLOW_S);
 
+		reset_type = hr_dev->is_vf ?
+			     HNAE3_VF_FUNC_RESET : HNAE3_FUNC_RESET;
+
 		/* Set reset level for reset_event() */
 		if (ops->set_default_reset_request)
-			ops->set_default_reset_request(ae_dev,
-						       HNAE3_FUNC_RESET);
+			ops->set_default_reset_request(ae_dev, reset_type);
 		if (ops->reset_event)
 			ops->reset_event(pdev, NULL);
 
@@ -6277,7 +6285,7 @@ static u64 fmea_get_ram_res_addr(u32 res_type, __le64 *data)
 	    res_type == ECC_RESOURCE_SCCC)
 		return le64_to_cpu(*data);
 
-	return le64_to_cpu(*data) << PAGE_SHIFT;
+	return le64_to_cpu(*data) << HNS_HW_PAGE_SHIFT;
 }
 
 static int fmea_recover_others(struct hns_roce_dev *hr_dev, u32 res_type,
@@ -6949,9 +6957,6 @@ static void __hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 	hr_dev->state = HNS_ROCE_DEVICE_STATE_UNINIT;
 	hns_roce_handle_device_err(hr_dev);
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08)
-		free_mr_exit(hr_dev);
-
 	hns_roce_exit(hr_dev);
 	kfree(hr_dev->priv);
 	ib_dealloc_device(&hr_dev->ib_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 1de384ce4d0e..6b03ba671ff8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1460,19 +1460,19 @@ void hns_roce_lock_cqs(struct hns_roce_cq *send_cq, struct hns_roce_cq *recv_cq)
 		__acquire(&send_cq->lock);
 		__acquire(&recv_cq->lock);
 	} else if (unlikely(send_cq != NULL && recv_cq == NULL)) {
-		spin_lock_irq(&send_cq->lock);
+		spin_lock(&send_cq->lock);
 		__acquire(&recv_cq->lock);
 	} else if (unlikely(send_cq == NULL && recv_cq != NULL)) {
-		spin_lock_irq(&recv_cq->lock);
+		spin_lock(&recv_cq->lock);
 		__acquire(&send_cq->lock);
 	} else if (send_cq == recv_cq) {
-		spin_lock_irq(&send_cq->lock);
+		spin_lock(&send_cq->lock);
 		__acquire(&recv_cq->lock);
 	} else if (send_cq->cqn < recv_cq->cqn) {
-		spin_lock_irq(&send_cq->lock);
+		spin_lock(&send_cq->lock);
 		spin_lock_nested(&recv_cq->lock, SINGLE_DEPTH_NESTING);
 	} else {
-		spin_lock_irq(&recv_cq->lock);
+		spin_lock(&recv_cq->lock);
 		spin_lock_nested(&send_cq->lock, SINGLE_DEPTH_NESTING);
 	}
 }
@@ -1492,13 +1492,13 @@ void hns_roce_unlock_cqs(struct hns_roce_cq *send_cq,
 		spin_unlock(&recv_cq->lock);
 	} else if (send_cq == recv_cq) {
 		__release(&recv_cq->lock);
-		spin_unlock_irq(&send_cq->lock);
+		spin_unlock(&send_cq->lock);
 	} else if (send_cq->cqn < recv_cq->cqn) {
 		spin_unlock(&recv_cq->lock);
-		spin_unlock_irq(&send_cq->lock);
+		spin_unlock(&send_cq->lock);
 	} else {
 		spin_unlock(&send_cq->lock);
-		spin_unlock_irq(&recv_cq->lock);
+		spin_unlock(&recv_cq->lock);
 	}
 }
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 12704efb7b19..954450195824 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1347,7 +1347,7 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		if (attr->max_dest_rd_atomic > dev->hw_attrs.max_hw_ird) {
 			ibdev_err(&iwdev->ibdev,
 				  "rd_atomic = %d, above max_hw_ird=%d\n",
-				   attr->max_rd_atomic,
+				   attr->max_dest_rd_atomic,
 				   dev->hw_attrs.max_hw_ird);
 			return -EINVAL;
 		}
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 43660c831b22..fdb0e62d805b 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -542,7 +542,7 @@ static int mlx5_query_port_roce(struct ib_device *device, u32 port_num,
 	if (!ndev)
 		goto out;
 
-	if (dev->lag_active) {
+	if (mlx5_lag_is_roce(mdev) || mlx5_lag_is_sriov(mdev)) {
 		rcu_read_lock();
 		upper = netdev_master_upper_dev_get_rcu(ndev);
 		if (upper) {
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index f9abdca3493a..0b2f18c34ee5 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -795,6 +795,7 @@ struct mlx5_cache_ent {
 	u8 is_tmp:1;
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
+	u8 tmp_cleanup_scheduled:1;
 
 	/*
 	 * - limit is the low water mark for stored mkeys, 2* limit is the
@@ -826,7 +827,6 @@ struct mlx5_mkey_cache {
 	struct mutex		rb_lock;
 	struct dentry		*fs_root;
 	unsigned long		last_add;
-	struct delayed_work	remove_ent_dwork;
 };
 
 struct mlx5_ib_port_resources {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index d3c1f63791a2..59bde614f061 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -48,6 +48,7 @@ enum {
 	MAX_PENDING_REG_MR = 8,
 };
 
+#define MLX5_MR_CACHE_PERSISTENT_ENTRY_MIN_DESCS 4
 #define MLX5_UMR_ALIGN 2048
 
 static void
@@ -211,9 +212,9 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
 
 	spin_lock_irqsave(&ent->mkeys_queue.lock, flags);
 	push_mkey_locked(ent, mkey_out->mkey);
+	ent->pending--;
 	/* If we are doing fill_to_high_water then keep going. */
 	queue_adjust_cache_locked(ent);
-	ent->pending--;
 	spin_unlock_irqrestore(&ent->mkeys_queue.lock, flags);
 	kfree(mkey_out);
 }
@@ -527,6 +528,21 @@ static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 	}
 }
 
+static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
+{
+	u32 mkey;
+
+	spin_lock_irq(&ent->mkeys_queue.lock);
+	while (ent->mkeys_queue.ci) {
+		mkey = pop_mkey_locked(ent);
+		spin_unlock_irq(&ent->mkeys_queue.lock);
+		mlx5_core_destroy_mkey(dev->mdev, mkey);
+		spin_lock_irq(&ent->mkeys_queue.lock);
+	}
+	ent->tmp_cleanup_scheduled = false;
+	spin_unlock_irq(&ent->mkeys_queue.lock);
+}
+
 static void __cache_work_func(struct mlx5_cache_ent *ent)
 {
 	struct mlx5_ib_dev *dev = ent->dev;
@@ -598,7 +614,11 @@ static void delayed_cache_work_func(struct work_struct *work)
 	struct mlx5_cache_ent *ent;
 
 	ent = container_of(work, struct mlx5_cache_ent, dwork.work);
-	__cache_work_func(ent);
+	/* temp entries are never filled, only cleaned */
+	if (ent->is_tmp)
+		clean_keys(ent->dev, ent);
+	else
+		__cache_work_func(ent);
 }
 
 static int cache_ent_key_cmp(struct mlx5r_cache_rb_key key1,
@@ -659,6 +679,7 @@ mkey_cache_ent_from_rb_key(struct mlx5_ib_dev *dev,
 {
 	struct rb_node *node = dev->cache.rb_root.rb_node;
 	struct mlx5_cache_ent *cur, *smallest = NULL;
+	u64 ndescs_limit;
 	int cmp;
 
 	/*
@@ -677,10 +698,18 @@ mkey_cache_ent_from_rb_key(struct mlx5_ib_dev *dev,
 			return cur;
 	}
 
+	/*
+	 * Limit the usage of mkeys larger than twice the required size while
+	 * also allowing the usage of smallest cache entry for small MRs.
+	 */
+	ndescs_limit = max_t(u64, rb_key.ndescs * 2,
+			     MLX5_MR_CACHE_PERSISTENT_ENTRY_MIN_DESCS);
+
 	return (smallest &&
 		smallest->rb_key.access_mode == rb_key.access_mode &&
 		smallest->rb_key.access_flags == rb_key.access_flags &&
-		smallest->rb_key.ats == rb_key.ats) ?
+		smallest->rb_key.ats == rb_key.ats &&
+		smallest->rb_key.ndescs <= ndescs_limit) ?
 		       smallest :
 		       NULL;
 }
@@ -765,21 +794,6 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 	return _mlx5_mr_cache_alloc(dev, ent, access_flags);
 }
 
-static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
-{
-	u32 mkey;
-
-	cancel_delayed_work(&ent->dwork);
-	spin_lock_irq(&ent->mkeys_queue.lock);
-	while (ent->mkeys_queue.ci) {
-		mkey = pop_mkey_locked(ent);
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-		mlx5_core_destroy_mkey(dev->mdev, mkey);
-		spin_lock_irq(&ent->mkeys_queue.lock);
-	}
-	spin_unlock_irq(&ent->mkeys_queue.lock);
-}
-
 static void mlx5_mkey_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
 {
 	if (!mlx5_debugfs_root || dev->is_rep)
@@ -892,10 +906,6 @@ mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
 			ent->limit = 0;
 
 		mlx5_mkey_cache_debugfs_add_ent(dev, ent);
-	} else {
-		mod_delayed_work(ent->dev->cache.wq,
-				 &ent->dev->cache.remove_ent_dwork,
-				 msecs_to_jiffies(30 * 1000));
 	}
 
 	return ent;
@@ -906,35 +916,6 @@ mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
 	return ERR_PTR(ret);
 }
 
-static void remove_ent_work_func(struct work_struct *work)
-{
-	struct mlx5_mkey_cache *cache;
-	struct mlx5_cache_ent *ent;
-	struct rb_node *cur;
-
-	cache = container_of(work, struct mlx5_mkey_cache,
-			     remove_ent_dwork.work);
-	mutex_lock(&cache->rb_lock);
-	cur = rb_last(&cache->rb_root);
-	while (cur) {
-		ent = rb_entry(cur, struct mlx5_cache_ent, node);
-		cur = rb_prev(cur);
-		mutex_unlock(&cache->rb_lock);
-
-		spin_lock_irq(&ent->mkeys_queue.lock);
-		if (!ent->is_tmp) {
-			spin_unlock_irq(&ent->mkeys_queue.lock);
-			mutex_lock(&cache->rb_lock);
-			continue;
-		}
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-
-		clean_keys(ent->dev, ent);
-		mutex_lock(&cache->rb_lock);
-	}
-	mutex_unlock(&cache->rb_lock);
-}
-
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_mkey_cache *cache = &dev->cache;
@@ -950,7 +931,6 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->slow_path_mutex);
 	mutex_init(&dev->cache.rb_lock);
 	dev->cache.rb_root = RB_ROOT;
-	INIT_DELAYED_WORK(&dev->cache.remove_ent_dwork, remove_ent_work_func);
 	cache->wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
 	if (!cache->wq) {
 		mlx5_ib_warn(dev, "failed to create work queue\n");
@@ -962,7 +942,7 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	mlx5_mkey_cache_debugfs_init(dev);
 	mutex_lock(&cache->rb_lock);
 	for (i = 0; i <= mkey_cache_max_order(dev); i++) {
-		rb_key.ndescs = 1 << (i + 2);
+		rb_key.ndescs = MLX5_MR_CACHE_PERSISTENT_ENTRY_MIN_DESCS << i;
 		ent = mlx5r_cache_create_ent_locked(dev, rb_key, true);
 		if (IS_ERR(ent)) {
 			ret = PTR_ERR(ent);
@@ -1001,7 +981,6 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 		return;
 
 	mutex_lock(&dev->cache.rb_lock);
-	cancel_delayed_work(&dev->cache.remove_ent_dwork);
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		spin_lock_irq(&ent->mkeys_queue.lock);
@@ -1843,8 +1822,18 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
 	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
 
-	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr))
+	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr)) {
+		ent = mr->mmkey.cache_ent;
+		/* upon storing to a clean temp entry - schedule its cleanup */
+		spin_lock_irq(&ent->mkeys_queue.lock);
+		if (ent->is_tmp && !ent->tmp_cleanup_scheduled) {
+			mod_delayed_work(ent->dev->cache.wq, &ent->dwork,
+					 msecs_to_jiffies(30 * 1000));
+			ent->tmp_cleanup_scheduled = true;
+		}
+		spin_unlock_irq(&ent->mkeys_queue.lock);
 		return 0;
+	}
 
 	if (ent) {
 		spin_lock_irq(&ent->mkeys_queue.lock);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 88106cf5ce55..84d2dfcd20af 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -626,6 +626,7 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		 */
 		if (WARN_ON(wc->wr_cqe->done != rtrs_clt_rdma_done))
 			return;
+		clt_path->s.hb_missed_cnt = 0;
 		rtrs_from_imm(be32_to_cpu(wc->ex.imm_data),
 			       &imm_type, &imm_payload);
 		if (imm_type == RTRS_IO_RSP_IMM ||
@@ -643,7 +644,6 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 				return  rtrs_clt_recv_done(con, wc);
 		} else if (imm_type == RTRS_HB_ACK_IMM) {
 			WARN_ON(con->c.cid);
-			clt_path->s.hb_missed_cnt = 0;
 			clt_path->s.hb_cur_latency =
 				ktime_sub(ktime_get(), clt_path->s.hb_last_sent);
 			if (clt_path->flags & RTRS_MSG_NEW_RKEY_F)
@@ -670,6 +670,7 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		/*
 		 * Key invalidations from server side
 		 */
+		clt_path->s.hb_missed_cnt = 0;
 		WARN_ON(!(wc->wc_flags & IB_WC_WITH_INVALIDATE ||
 			  wc->wc_flags & IB_WC_WITH_IMM));
 		WARN_ON(wc->wr_cqe->done != rtrs_clt_rdma_done);
@@ -2346,6 +2347,12 @@ static int init_conns(struct rtrs_clt_path *clt_path)
 		if (err)
 			goto destroy;
 	}
+
+	/*
+	 * Set the cid to con_num - 1, since if we fail later, we want to stay in bounds.
+	 */
+	cid = clt_path->s.con_num - 1;
+
 	err = alloc_path_reqs(clt_path);
 	if (err)
 		goto destroy;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 1d33efb8fb03..94ac99a4f696 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1229,6 +1229,7 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		 */
 		if (WARN_ON(wc->wr_cqe != &io_comp_cqe))
 			return;
+		srv_path->s.hb_missed_cnt = 0;
 		err = rtrs_post_recv_empty(&con->c, &io_comp_cqe);
 		if (err) {
 			rtrs_err(s, "rtrs_post_recv(), err: %d\n", err);
diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 1b0279393df4..5acaffb7f6e1 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -627,7 +627,7 @@ static int adp5588_setup(struct adp5588_kpad *kpad)
 
 	for (i = 0; i < KEYP_MAX_EVENT; i++) {
 		ret = adp5588_read(client, KEY_EVENTA);
-		if (ret)
+		if (ret < 0)
 			return ret;
 	}
 
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index bad238f69a7a..34d1f07ea4c3 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1120,6 +1120,43 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
+	/*
+	 * Some TongFang barebones have touchpad and/or keyboard issues after
+	 * suspend fixable with nomux + reset + noloop + nopnp. Luckily, none of
+	 * them have an external PS/2 port so this can safely be set for all of
+	 * them.
+	 * TongFang barebones come with board_vendor and/or system_vendor set to
+	 * a different value for each individual reseller. The only somewhat
+	 * universal way to identify them is by board_name.
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6XGxX"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxX"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
 	/*
 	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
 	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
index 3eb762896345..5a807ad72319 100644
--- a/drivers/input/touchscreen/ilitek_ts_i2c.c
+++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
@@ -37,6 +37,8 @@
 #define ILITEK_TP_CMD_GET_MCU_VER			0x61
 #define ILITEK_TP_CMD_GET_IC_MODE			0xC0
 
+#define ILITEK_TP_I2C_REPORT_ID				0x48
+
 #define REPORT_COUNT_ADDRESS				61
 #define ILITEK_SUPPORT_MAX_POINT			40
 
@@ -160,15 +162,19 @@ static int ilitek_process_and_report_v6(struct ilitek_ts_data *ts)
 	error = ilitek_i2c_write_and_read(ts, NULL, 0, 0, buf, 64);
 	if (error) {
 		dev_err(dev, "get touch info failed, err:%d\n", error);
-		goto err_sync_frame;
+		return error;
+	}
+
+	if (buf[0] != ILITEK_TP_I2C_REPORT_ID) {
+		dev_err(dev, "get touch info failed. Wrong id: 0x%02X\n", buf[0]);
+		return -EINVAL;
 	}
 
 	report_max_point = buf[REPORT_COUNT_ADDRESS];
 	if (report_max_point > ts->max_tp) {
 		dev_err(dev, "FW report max point:%d > panel info. max:%d\n",
 			report_max_point, ts->max_tp);
-		error = -EINVAL;
-		goto err_sync_frame;
+		return -EINVAL;
 	}
 
 	count = DIV_ROUND_UP(report_max_point, packet_max_point);
@@ -178,7 +184,7 @@ static int ilitek_process_and_report_v6(struct ilitek_ts_data *ts)
 		if (error) {
 			dev_err(dev, "get touch info. failed, cnt:%d, err:%d\n",
 				count, error);
-			goto err_sync_frame;
+			return error;
 		}
 	}
 
@@ -203,10 +209,10 @@ static int ilitek_process_and_report_v6(struct ilitek_ts_data *ts)
 		ilitek_touch_down(ts, id, x, y);
 	}
 
-err_sync_frame:
 	input_mt_sync_frame(input);
 	input_sync(input);
-	return error;
+
+	return 0;
 }
 
 /* APIs of cmds for ILITEK Touch IC */
diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index d787f2ea36d9..a91df709cfb2 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -87,6 +87,7 @@ struct icc_provider *icc_clk_register(struct device *dev,
 	onecell = devm_kzalloc(dev, struct_size(onecell, nodes, 2 * num_clocks), GFP_KERNEL);
 	if (!onecell)
 		return ERR_PTR(-ENOMEM);
+	onecell->num_nodes = 2 * num_clocks;
 
 	qp = devm_kzalloc(dev, struct_size(qp, clocks, num_clocks), GFP_KERNEL);
 	if (!qp)
@@ -133,8 +134,6 @@ struct icc_provider *icc_clk_register(struct device *dev,
 		onecell->nodes[j++] = node;
 	}
 
-	onecell->num_nodes = j;
-
 	ret = icc_provider_register(provider);
 	if (ret)
 		goto err;
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index b321c3009acb..885a9d3f92e4 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -1965,6 +1965,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8350",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 9d9a7fde59e7..05aed3cb46f1 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -574,23 +574,27 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 	       pgtable->mode > PAGE_MODE_6_LEVEL);
 
 	free_sub_pt(pgtable->root, pgtable->mode, &freelist);
+	iommu_put_pages_list(&freelist);
 
 	/* Update data structure */
 	amd_iommu_domain_clr_pt_root(dom);
 
 	/* Make changes visible to IOMMUs */
 	amd_iommu_domain_update(dom);
-
-	iommu_put_pages_list(&freelist);
 }
 
 static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 {
 	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
 
-	cfg->pgsize_bitmap  = AMD_IOMMU_PGSIZES,
-	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE,
-	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE,
+	pgtable->root = iommu_alloc_page(GFP_KERNEL);
+	if (!pgtable->root)
+		return NULL;
+	pgtable->mode = PAGE_MODE_3_LEVEL;
+
+	cfg->pgsize_bitmap  = AMD_IOMMU_PGSIZES;
+	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE;
+	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE;
 	cfg->tlb            = &v1_flush_ops;
 
 	pgtable->iop.ops.map_pages    = iommu_v1_map_pages;
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index 78ac37c5ccc1..743f417b281d 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -51,7 +51,7 @@ static inline u64 set_pgtable_attr(u64 *page)
 	u64 prot;
 
 	prot = IOMMU_PAGE_PRESENT | IOMMU_PAGE_RW | IOMMU_PAGE_USER;
-	prot |= IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
+	prot |= IOMMU_PAGE_ACCESS;
 
 	return (iommu_virt_to_phys(page) | prot);
 }
@@ -362,7 +362,7 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	struct protection_domain *pdom = (struct protection_domain *)cookie;
 	int ias = IOMMU_IN_ADDR_BIT_SIZE;
 
-	pgtable->pgd = iommu_alloc_page_node(pdom->nid, GFP_ATOMIC);
+	pgtable->pgd = iommu_alloc_page_node(pdom->nid, GFP_KERNEL);
 	if (!pgtable->pgd)
 		return NULL;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b19e8c0f48fa..1a61f14459e4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -52,8 +52,6 @@
 #define HT_RANGE_START		(0xfd00000000ULL)
 #define HT_RANGE_END		(0xffffffffffULL)
 
-#define DEFAULT_PGTABLE_LEVEL	PAGE_MODE_3_LEVEL
-
 static DEFINE_SPINLOCK(pd_bitmap_lock);
 
 LIST_HEAD(ioapic_map);
@@ -1552,8 +1550,8 @@ void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 				   ioasid_t pasid)
 {
-	amd_iommu_dev_flush_pasid_pages(dev_data, 0,
-					CMD_INV_IOMMU_ALL_PAGES_ADDRESS, pasid);
+	amd_iommu_dev_flush_pasid_pages(dev_data, pasid, 0,
+					CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
 void amd_iommu_domain_flush_complete(struct protection_domain *domain)
@@ -2185,11 +2183,12 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
 		iommu_ignore_device(iommu, dev);
-	} else {
-		amd_iommu_set_pci_msi_domain(dev, iommu);
-		iommu_dev = &iommu->iommu;
+		goto out_err;
 	}
 
+	amd_iommu_set_pci_msi_domain(dev, iommu);
+	iommu_dev = &iommu->iommu;
+
 	/*
 	 * If IOMMU and device supports PASID then it will contain max
 	 * supported PASIDs, else it will be zero.
@@ -2201,6 +2200,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 					     pci_max_pasids(to_pci_dev(dev)));
 	}
 
+out_err:
 	iommu_completion_wait(iommu);
 
 	return iommu_dev;
@@ -2265,47 +2265,17 @@ void protection_domain_free(struct protection_domain *domain)
 	if (domain->iop.pgtbl_cfg.tlb)
 		free_io_pgtable_ops(&domain->iop.iop.ops);
 
-	if (domain->iop.root)
-		iommu_free_page(domain->iop.root);
-
 	if (domain->id)
 		domain_id_free(domain->id);
 
 	kfree(domain);
 }
 
-static int protection_domain_init_v1(struct protection_domain *domain, int mode)
-{
-	u64 *pt_root = NULL;
-
-	BUG_ON(mode < PAGE_MODE_NONE || mode > PAGE_MODE_6_LEVEL);
-
-	if (mode != PAGE_MODE_NONE) {
-		pt_root = iommu_alloc_page(GFP_KERNEL);
-		if (!pt_root)
-			return -ENOMEM;
-	}
-
-	domain->pd_mode = PD_MODE_V1;
-	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
-
-	return 0;
-}
-
-static int protection_domain_init_v2(struct protection_domain *pdom)
-{
-	pdom->pd_mode = PD_MODE_V2;
-	pdom->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
-
-	return 0;
-}
-
 struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
 	int pgtable;
-	int ret;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
@@ -2341,18 +2311,14 @@ struct protection_domain *protection_domain_alloc(unsigned int type)
 
 	switch (pgtable) {
 	case AMD_IOMMU_V1:
-		ret = protection_domain_init_v1(domain, DEFAULT_PGTABLE_LEVEL);
+		domain->pd_mode = PD_MODE_V1;
 		break;
 	case AMD_IOMMU_V2:
-		ret = protection_domain_init_v2(domain);
+		domain->pd_mode = PD_MODE_V2;
 		break;
 	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	if (ret)
 		goto out_err;
+	}
 
 	pgtbl_ops = alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl_cfg, domain);
 	if (!pgtbl_ops)
@@ -2405,10 +2371,10 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	domain->domain.geometry.aperture_start = 0;
 	domain->domain.geometry.aperture_end   = dma_max_address();
 	domain->domain.geometry.force_aperture = true;
+	domain->domain.pgsize_bitmap = domain->iop.iop.cfg.pgsize_bitmap;
 
 	if (iommu) {
 		domain->domain.type = type;
-		domain->domain.pgsize_bitmap = iommu->iommu.ops->pgsize_bitmap;
 		domain->domain.ops = iommu->iommu.ops->default_domain_ops;
 
 		if (dirty_tracking)
@@ -2867,7 +2833,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.device_group = amd_iommu_device_group,
 	.get_resv_regions = amd_iommu_get_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
-	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.def_domain_type = amd_iommu_def_domain_type,
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 13f3e2efb2cc..ccca410c9481 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -282,6 +282,20 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 	u32 smr;
 	int i;
 
+	/*
+	 * MSM8998 LPASS SMMU reports 13 context banks, but accessing
+	 * the last context bank crashes the system.
+	 */
+	if (of_device_is_compatible(smmu->dev->of_node, "qcom,msm8998-smmu-v2") &&
+	    smmu->num_context_banks == 13) {
+		smmu->num_context_banks = 12;
+	} else if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm630-smmu-v2")) {
+		if (smmu->num_context_banks == 21) /* SDM630 / SDM660 A2NOC SMMU */
+			smmu->num_context_banks = 7;
+		else if (smmu->num_context_banks == 14) /* SDM630 / SDM660 LPASS SMMU */
+			smmu->num_context_banks = 13;
+	}
+
 	/*
 	 * Some platforms support more than the Arm SMMU architected maximum of
 	 * 128 stream matching groups. For unknown reasons, the additional
@@ -338,6 +352,19 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static int qcom_adreno_smmuv2_cfg_probe(struct arm_smmu_device *smmu)
+{
+	/* Support for 16K pages is advertised on some SoCs, but it doesn't seem to work */
+	smmu->features &= ~ARM_SMMU_FEAT_FMT_AARCH64_16K;
+
+	/* TZ protects several last context banks, hide them from Linux */
+	if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm630-smmu-v2") &&
+	    smmu->num_context_banks == 5)
+		smmu->num_context_banks = 2;
+
+	return 0;
+}
+
 static void qcom_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
 {
 	struct arm_smmu_s2cr *s2cr = smmu->s2crs + idx;
@@ -436,6 +463,7 @@ static const struct arm_smmu_impl sdm845_smmu_500_impl = {
 
 static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
 	.init_context = qcom_adreno_smmu_init_context,
+	.cfg_probe = qcom_adreno_smmuv2_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index a9f1fe44c4c0..21f0d8cbd7aa 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -215,7 +215,8 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 
 	if (flags || !user_data->len || !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
-	if (parent->auto_domain || !parent->nest_parent)
+	if (parent->auto_domain || !parent->nest_parent ||
+	    parent->common.domain->owner != ops)
 		return ERR_PTR(-EINVAL);
 
 	hwpt_nested = __iommufd_object_alloc(
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 05fd9d3abf1b..9f193c933de6 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -112,6 +112,7 @@ static int iopt_alloc_iova(struct io_pagetable *iopt, unsigned long *iova,
 	unsigned long page_offset = uptr % PAGE_SIZE;
 	struct interval_tree_double_span_iter used_span;
 	struct interval_tree_span_iter allowed_span;
+	unsigned long max_alignment = PAGE_SIZE;
 	unsigned long iova_alignment;
 
 	lockdep_assert_held(&iopt->iova_rwsem);
@@ -131,6 +132,13 @@ static int iopt_alloc_iova(struct io_pagetable *iopt, unsigned long *iova,
 				       roundup_pow_of_two(length),
 				       1UL << __ffs64(uptr));
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	max_alignment = HPAGE_SIZE;
+#endif
+	/* Protect against ALIGN() overflow */
+	if (iova_alignment >= max_alignment)
+		iova_alignment = max_alignment;
+
 	if (iova_alignment < iopt->iova_alignment)
 		return -EINVAL;
 
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 654ed3339095..62bfeb7a35d8 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1313,7 +1313,7 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 			      unsigned long page_size, void __user *uptr,
 			      u32 flags)
 {
-	unsigned long bitmap_size, i, max;
+	unsigned long i, max;
 	struct iommu_test_cmd *cmd = ucmd->cmd;
 	struct iommufd_hw_pagetable *hwpt;
 	struct mock_iommu_domain *mock;
@@ -1334,15 +1334,14 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 	}
 
 	max = length / page_size;
-	bitmap_size = DIV_ROUND_UP(max, BITS_PER_BYTE);
-
-	tmp = kvzalloc(bitmap_size, GFP_KERNEL_ACCOUNT);
+	tmp = kvzalloc(DIV_ROUND_UP(max, BITS_PER_LONG) * sizeof(unsigned long),
+		       GFP_KERNEL_ACCOUNT);
 	if (!tmp) {
 		rc = -ENOMEM;
 		goto out_put;
 	}
 
-	if (copy_from_user(tmp, uptr, bitmap_size)) {
+	if (copy_from_user(tmp, uptr,DIV_ROUND_UP(max, BITS_PER_BYTE))) {
 		rc = -EFAULT;
 		goto out_free;
 	}
diff --git a/drivers/leds/leds-bd2606mvv.c b/drivers/leds/leds-bd2606mvv.c
index 3fda712d2f80..c1181a35d0f7 100644
--- a/drivers/leds/leds-bd2606mvv.c
+++ b/drivers/leds/leds-bd2606mvv.c
@@ -69,16 +69,14 @@ static const struct regmap_config bd2606mvv_regmap = {
 
 static int bd2606mvv_probe(struct i2c_client *client)
 {
-	struct fwnode_handle *np, *child;
 	struct device *dev = &client->dev;
 	struct bd2606mvv_priv *priv;
 	struct fwnode_handle *led_fwnodes[BD2606_MAX_LEDS] = { 0 };
 	int active_pairs[BD2606_MAX_LEDS / 2] = { 0 };
 	int err, reg;
-	int i;
+	int i, j;
 
-	np = dev_fwnode(dev);
-	if (!np)
+	if (!dev_fwnode(dev))
 		return -ENODEV;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -94,20 +92,18 @@ static int bd2606mvv_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, priv);
 
-	fwnode_for_each_available_child_node(np, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		struct bd2606mvv_led *led;
 
 		err = fwnode_property_read_u32(child, "reg", &reg);
-		if (err) {
-			fwnode_handle_put(child);
+		if (err)
 			return err;
-		}
-		if (reg < 0 || reg >= BD2606_MAX_LEDS || led_fwnodes[reg]) {
-			fwnode_handle_put(child);
+
+		if (reg < 0 || reg >= BD2606_MAX_LEDS || led_fwnodes[reg])
 			return -EINVAL;
-		}
+
 		led = &priv->leds[reg];
-		led_fwnodes[reg] = child;
+		led_fwnodes[reg] = fwnode_handle_get(child);
 		active_pairs[reg / 2]++;
 		led->priv = priv;
 		led->led_no = reg;
@@ -130,7 +126,8 @@ static int bd2606mvv_probe(struct i2c_client *client)
 						     &priv->leds[i].ldev,
 						     &init_data);
 		if (err < 0) {
-			fwnode_handle_put(child);
+			for (j = i; j < BD2606_MAX_LEDS; j++)
+				fwnode_handle_put(led_fwnodes[j]);
 			return dev_err_probe(dev, err,
 					     "couldn't register LED %s\n",
 					     priv->leds[i].ldev.name);
diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 83fcd7b6afff..4d1612d557c8 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -150,7 +150,7 @@ static struct gpio_leds_priv *gpio_leds_create(struct device *dev)
 {
 	struct fwnode_handle *child;
 	struct gpio_leds_priv *priv;
-	int count, ret;
+	int count, used, ret;
 
 	count = device_get_child_node_count(dev);
 	if (!count)
@@ -159,9 +159,11 @@ static struct gpio_leds_priv *gpio_leds_create(struct device *dev)
 	priv = devm_kzalloc(dev, struct_size(priv, leds, count), GFP_KERNEL);
 	if (!priv)
 		return ERR_PTR(-ENOMEM);
+	priv->num_leds = count;
+	used = 0;
 
 	device_for_each_child_node(dev, child) {
-		struct gpio_led_data *led_dat = &priv->leds[priv->num_leds];
+		struct gpio_led_data *led_dat = &priv->leds[used];
 		struct gpio_led led = {};
 
 		/*
@@ -197,8 +199,9 @@ static struct gpio_leds_priv *gpio_leds_create(struct device *dev)
 		/* Set gpiod label to match the corresponding LED name. */
 		gpiod_set_consumer_name(led_dat->gpiod,
 					led_dat->cdev.dev->kobj.name);
-		priv->num_leds++;
+		used++;
 	}
+	priv->num_leds = used;
 
 	return priv;
 }
diff --git a/drivers/leds/leds-pca995x.c b/drivers/leds/leds-pca995x.c
index 78215dff1499..11c7bb69573e 100644
--- a/drivers/leds/leds-pca995x.c
+++ b/drivers/leds/leds-pca995x.c
@@ -19,10 +19,6 @@
 #define PCA995X_MODE1			0x00
 #define PCA995X_MODE2			0x01
 #define PCA995X_LEDOUT0			0x02
-#define PCA9955B_PWM0			0x08
-#define PCA9952_PWM0			0x0A
-#define PCA9952_IREFALL			0x43
-#define PCA9955B_IREFALL		0x45
 
 /* Auto-increment disabled. Normal mode */
 #define PCA995X_MODE1_CFG		0x00
@@ -34,17 +30,38 @@
 #define PCA995X_LDRX_MASK		0x3
 #define PCA995X_LDRX_BITS		2
 
-#define PCA995X_MAX_OUTPUTS		16
+#define PCA995X_MAX_OUTPUTS		24
 #define PCA995X_OUTPUTS_PER_REG		4
 
 #define PCA995X_IREFALL_FULL_CFG	0xFF
 #define PCA995X_IREFALL_HALF_CFG	(PCA995X_IREFALL_FULL_CFG / 2)
 
-#define PCA995X_TYPE_NON_B		0
-#define PCA995X_TYPE_B			1
-
 #define ldev_to_led(c)	container_of(c, struct pca995x_led, ldev)
 
+struct pca995x_chipdef {
+	unsigned int num_leds;
+	u8 pwm_base;
+	u8 irefall;
+};
+
+static const struct pca995x_chipdef pca9952_chipdef = {
+	.num_leds	= 16,
+	.pwm_base	= 0x0a,
+	.irefall	= 0x43,
+};
+
+static const struct pca995x_chipdef pca9955b_chipdef = {
+	.num_leds	= 16,
+	.pwm_base	= 0x08,
+	.irefall	= 0x45,
+};
+
+static const struct pca995x_chipdef pca9956b_chipdef = {
+	.num_leds	= 24,
+	.pwm_base	= 0x0a,
+	.irefall	= 0x40,
+};
+
 struct pca995x_led {
 	unsigned int led_no;
 	struct led_classdev ldev;
@@ -54,7 +71,7 @@ struct pca995x_led {
 struct pca995x_chip {
 	struct regmap *regmap;
 	struct pca995x_led leds[PCA995X_MAX_OUTPUTS];
-	int btype;
+	const struct pca995x_chipdef *chipdef;
 };
 
 static int pca995x_brightness_set(struct led_classdev *led_cdev,
@@ -62,10 +79,11 @@ static int pca995x_brightness_set(struct led_classdev *led_cdev,
 {
 	struct pca995x_led *led = ldev_to_led(led_cdev);
 	struct pca995x_chip *chip = led->chip;
+	const struct pca995x_chipdef *chipdef = chip->chipdef;
 	u8 ledout_addr, pwmout_addr;
 	int shift, ret;
 
-	pwmout_addr = (chip->btype ? PCA9955B_PWM0 : PCA9952_PWM0) + led->led_no;
+	pwmout_addr = chipdef->pwm_base + led->led_no;
 	ledout_addr = PCA995X_LEDOUT0 + (led->led_no / PCA995X_OUTPUTS_PER_REG);
 	shift = PCA995X_LDRX_BITS * (led->led_no % PCA995X_OUTPUTS_PER_REG);
 
@@ -102,43 +120,38 @@ static const struct regmap_config pca995x_regmap = {
 static int pca995x_probe(struct i2c_client *client)
 {
 	struct fwnode_handle *led_fwnodes[PCA995X_MAX_OUTPUTS] = { 0 };
-	struct fwnode_handle *np, *child;
 	struct device *dev = &client->dev;
+	const struct pca995x_chipdef *chipdef;
 	struct pca995x_chip *chip;
 	struct pca995x_led *led;
-	int i, btype, reg, ret;
+	int i, j, reg, ret;
 
-	btype = (unsigned long)device_get_match_data(&client->dev);
+	chipdef = device_get_match_data(&client->dev);
 
-	np = dev_fwnode(dev);
-	if (!np)
+	if (!dev_fwnode(dev))
 		return -ENODEV;
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
-	chip->btype = btype;
+	chip->chipdef = chipdef;
 	chip->regmap = devm_regmap_init_i2c(client, &pca995x_regmap);
 	if (IS_ERR(chip->regmap))
 		return PTR_ERR(chip->regmap);
 
 	i2c_set_clientdata(client, chip);
 
-	fwnode_for_each_available_child_node(np, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &reg);
-		if (ret) {
-			fwnode_handle_put(child);
+		if (ret)
 			return ret;
-		}
 
-		if (reg < 0 || reg >= PCA995X_MAX_OUTPUTS || led_fwnodes[reg]) {
-			fwnode_handle_put(child);
+		if (reg < 0 || reg >= PCA995X_MAX_OUTPUTS || led_fwnodes[reg])
 			return -EINVAL;
-		}
 
 		led = &chip->leds[reg];
-		led_fwnodes[reg] = child;
+		led_fwnodes[reg] = fwnode_handle_get(child);
 		led->chip = chip;
 		led->led_no = reg;
 		led->ldev.brightness_set_blocking = pca995x_brightness_set;
@@ -157,7 +170,8 @@ static int pca995x_probe(struct i2c_client *client)
 						     &chip->leds[i].ldev,
 						     &init_data);
 		if (ret < 0) {
-			fwnode_handle_put(child);
+			for (j = i; j < PCA995X_MAX_OUTPUTS; j++)
+				fwnode_handle_put(led_fwnodes[j]);
 			return dev_err_probe(dev, ret,
 					     "Could not register LED %s\n",
 					     chip->leds[i].ldev.name);
@@ -170,21 +184,21 @@ static int pca995x_probe(struct i2c_client *client)
 		return ret;
 
 	/* IREF Output current value for all LEDn outputs */
-	return regmap_write(chip->regmap,
-			    btype ? PCA9955B_IREFALL : PCA9952_IREFALL,
-			    PCA995X_IREFALL_HALF_CFG);
+	return regmap_write(chip->regmap, chipdef->irefall, PCA995X_IREFALL_HALF_CFG);
 }
 
 static const struct i2c_device_id pca995x_id[] = {
-	{ "pca9952", .driver_data = (kernel_ulong_t)PCA995X_TYPE_NON_B },
-	{ "pca9955b", .driver_data = (kernel_ulong_t)PCA995X_TYPE_B },
+	{ "pca9952", .driver_data = (kernel_ulong_t)&pca9952_chipdef },
+	{ "pca9955b", .driver_data = (kernel_ulong_t)&pca9955b_chipdef },
+	{ "pca9956b", .driver_data = (kernel_ulong_t)&pca9956b_chipdef },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, pca995x_id);
 
 static const struct of_device_id pca995x_of_match[] = {
-	{ .compatible = "nxp,pca9952",  .data = (void *)PCA995X_TYPE_NON_B },
-	{ .compatible = "nxp,pca9955b", .data = (void *)PCA995X_TYPE_B },
+	{ .compatible = "nxp,pca9952", .data = &pca9952_chipdef },
+	{ .compatible = "nxp,pca9955b", . data = &pca9955b_chipdef },
+	{ .compatible = "nxp,pca9956b", .data = &pca9956b_chipdef },
 	{},
 };
 MODULE_DEVICE_TABLE(of, pca995x_of_match);
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index f7e9a3632eb3..499f8cc8a39f 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -496,8 +496,10 @@ static blk_status_t dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 		map = dm_get_live_table(md, &srcu_idx);
 		if (unlikely(!map)) {
+			DMERR_LIMIT("%s: mapping table unavailable, erroring io",
+				    dm_device_name(md));
 			dm_put_live_table(md, srcu_idx);
-			return BLK_STS_RESOURCE;
+			return BLK_STS_IOERR;
 		}
 		ti = dm_table_find_target(map, 0);
 		dm_put_live_table(md, srcu_idx);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 6e15ac4e0845..a0b4afba8c60 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1880,10 +1880,15 @@ static void dm_submit_bio(struct bio *bio)
 	struct dm_table *map;
 
 	map = dm_get_live_table(md, &srcu_idx);
+	if (unlikely(!map)) {
+		DMERR_LIMIT("%s: mapping table unavailable, erroring io",
+			    dm_device_name(md));
+		bio_io_error(bio);
+		goto out;
+	}
 
-	/* If suspended, or map not yet available, queue this IO for later */
-	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags)) ||
-	    unlikely(!map)) {
+	/* If suspended, queue this IO for later */
+	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags))) {
 		if (bio->bi_opf & REQ_NOWAIT)
 			bio_wouldblock_error(bio);
 		else if (bio->bi_opf & REQ_RAHEAD)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index a5b5801baa9e..e832b8b5e631 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8648,7 +8648,6 @@ void md_write_start(struct mddev *mddev, struct bio *bi)
 	BUG_ON(mddev->ro == MD_RDONLY);
 	if (mddev->ro == MD_AUTO_READ) {
 		/* need to switch to read/write */
-		flush_work(&mddev->sync_work);
 		mddev->ro = MD_RDWR;
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 		md_wakeup_thread(mddev->thread);
diff --git a/drivers/media/dvb-frontends/rtl2830.c b/drivers/media/dvb-frontends/rtl2830.c
index 30d10fe4b33e..320aa2bf99d4 100644
--- a/drivers/media/dvb-frontends/rtl2830.c
+++ b/drivers/media/dvb-frontends/rtl2830.c
@@ -609,7 +609,7 @@ static int rtl2830_pid_filter(struct dvb_frontend *fe, u8 index, u16 pid, int on
 		index, pid, onoff);
 
 	/* skip invalid PIDs (0x2000) */
-	if (pid > 0x1fff || index > 32)
+	if (pid > 0x1fff || index >= 32)
 		return 0;
 
 	if (onoff)
diff --git a/drivers/media/dvb-frontends/rtl2832.c b/drivers/media/dvb-frontends/rtl2832.c
index 5142820b1b3d..76c3f40443b2 100644
--- a/drivers/media/dvb-frontends/rtl2832.c
+++ b/drivers/media/dvb-frontends/rtl2832.c
@@ -983,7 +983,7 @@ static int rtl2832_pid_filter(struct dvb_frontend *fe, u8 index, u16 pid,
 		index, pid, onoff, dev->slave_ts);
 
 	/* skip invalid PIDs (0x2000) */
-	if (pid > 0x1fff || index > 32)
+	if (pid > 0x1fff || index >= 32)
 		return 0;
 
 	if (onoff)
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
index 73d5cef33b2a..1e1b32faac77 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
@@ -347,11 +347,16 @@ static int vdec_h264_slice_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 		return vpu_dec_reset(vpu);
 
 	fb = inst->ctx->dev->vdec_pdata->get_cap_buffer(inst->ctx);
+	if (!fb) {
+		mtk_vdec_err(inst->ctx, "fb buffer is NULL");
+		return -ENOMEM;
+	}
+
 	src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
 	dst_buf_info = container_of(fb, struct mtk_video_dec_buf, frame_buffer);
 
-	y_fb_dma = fb ? (u64)fb->base_y.dma_addr : 0;
-	c_fb_dma = fb ? (u64)fb->base_c.dma_addr : 0;
+	y_fb_dma = fb->base_y.dma_addr;
+	c_fb_dma = fb->base_c.dma_addr;
 
 	mtk_vdec_debug(inst->ctx, "+ [%d] FB y_dma=%llx c_dma=%llx va=%p",
 		       inst->num_nalu, y_fb_dma, c_fb_dma, fb);
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
index 2d4611e7fa0b..1ed0ccec5665 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
@@ -724,11 +724,16 @@ static int vdec_h264_slice_single_decode(void *h_vdec, struct mtk_vcodec_mem *bs
 		return vpu_dec_reset(vpu);
 
 	fb = inst->ctx->dev->vdec_pdata->get_cap_buffer(inst->ctx);
+	if (!fb) {
+		mtk_vdec_err(inst->ctx, "fb buffer is NULL");
+		return -ENOMEM;
+	}
+
 	src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
 	dst_buf_info = container_of(fb, struct mtk_video_dec_buf, frame_buffer);
 
-	y_fb_dma = fb ? (u64)fb->base_y.dma_addr : 0;
-	c_fb_dma = fb ? (u64)fb->base_c.dma_addr : 0;
+	y_fb_dma = fb->base_y.dma_addr;
+	c_fb_dma = fb->base_c.dma_addr;
 	mtk_vdec_debug(inst->ctx, "[h264-dec] [%d] y_dma=%llx c_dma=%llx",
 		       inst->ctx->decoded_frame_cnt, y_fb_dma, c_fb_dma);
 
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
index e27e728f392e..232ef3bd246a 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
@@ -334,14 +334,18 @@ static int vdec_vp8_slice_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
 
 	fb = inst->ctx->dev->vdec_pdata->get_cap_buffer(inst->ctx);
-	dst_buf_info = container_of(fb, struct mtk_video_dec_buf, frame_buffer);
+	if (!fb) {
+		mtk_vdec_err(inst->ctx, "fb buffer is NULL");
+		return -ENOMEM;
+	}
 
-	y_fb_dma = fb ? (u64)fb->base_y.dma_addr : 0;
+	dst_buf_info = container_of(fb, struct mtk_video_dec_buf, frame_buffer);
+	y_fb_dma = fb->base_y.dma_addr;
 	if (inst->ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 1)
 		c_fb_dma = y_fb_dma +
 			inst->ctx->picinfo.buf_w * inst->ctx->picinfo.buf_h;
 	else
-		c_fb_dma = fb ? (u64)fb->base_c.dma_addr : 0;
+		c_fb_dma = fb->base_c.dma_addr;
 
 	inst->vsi->dec.bs_dma = (u64)bs->dma_addr;
 	inst->vsi->dec.bs_sz = bs->size;
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index e68fcdaea207..c7fdee347ac8 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -865,6 +865,7 @@ static const struct of_device_id rzg2l_csi2_of_table[] = {
 	{ .compatible = "renesas,rzg2l-csi2", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, rzg2l_csi2_of_table);
 
 static struct platform_driver rzg2l_csi2_pdrv = {
 	.remove_new = rzg2l_csi2_remove,
diff --git a/drivers/media/tuners/tuner-i2c.h b/drivers/media/tuners/tuner-i2c.h
index 07aeead0644a..724952e001cd 100644
--- a/drivers/media/tuners/tuner-i2c.h
+++ b/drivers/media/tuners/tuner-i2c.h
@@ -133,10 +133,8 @@ static inline int tuner_i2c_xfer_send_recv(struct tuner_i2c_props *props,
 	}								\
 	if (0 == __ret) {						\
 		state = kzalloc(sizeof(type), GFP_KERNEL);		\
-		if (!state) {						\
-			__ret = -ENOMEM;				\
+		if (NULL == state)					\
 			goto __fail;					\
-		}							\
 		state->i2c_props.addr = i2caddr;			\
 		state->i2c_props.adap = i2cadap;			\
 		state->i2c_props.name = devname;			\
diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index 66044f4f5bad..10cd1d9b4885 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -207,6 +207,9 @@ static int powernv_flash_set_driver_info(struct device *dev,
 	 * get them
 	 */
 	mtd->name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
+	if (!mtd->name)
+		return -ENOMEM;
+
 	mtd->type = MTD_NORFLASH;
 	mtd->flags = MTD_WRITEABLE;
 	mtd->size = size;
diff --git a/drivers/mtd/devices/slram.c b/drivers/mtd/devices/slram.c
index 28131a127d06..8297b366a066 100644
--- a/drivers/mtd/devices/slram.c
+++ b/drivers/mtd/devices/slram.c
@@ -296,10 +296,12 @@ static int __init init_slram(void)
 		T("slram: devname = %s\n", devname);
 		if ((!map) || (!(devstart = strsep(&map, ",")))) {
 			E("slram: No devicestart specified.\n");
+			break;
 		}
 		T("slram: devstart = %s\n", devstart);
 		if ((!map) || (!(devlength = strsep(&map, ",")))) {
 			E("slram: No devicelength / -end specified.\n");
+			break;
 		}
 		T("slram: devlength = %s\n", devlength);
 		if (parse_cmdline(devname, devstart, devlength) != 0) {
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 17477bb2d48f..586868b4139f 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1429,16 +1429,32 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 	return 0;
 }
 
+static void mtk_nfc_nand_chips_cleanup(struct mtk_nfc *nfc)
+{
+	struct mtk_nfc_nand_chip *mtk_chip;
+	struct nand_chip *chip;
+	int ret;
+
+	while (!list_empty(&nfc->chips)) {
+		mtk_chip = list_first_entry(&nfc->chips,
+					    struct mtk_nfc_nand_chip, node);
+		chip = &mtk_chip->nand;
+		ret = mtd_device_unregister(nand_to_mtd(chip));
+		WARN_ON(ret);
+		nand_cleanup(chip);
+		list_del(&mtk_chip->node);
+	}
+}
+
 static int mtk_nfc_nand_chips_init(struct device *dev, struct mtk_nfc *nfc)
 {
 	struct device_node *np = dev->of_node;
-	struct device_node *nand_np;
 	int ret;
 
-	for_each_child_of_node(np, nand_np) {
+	for_each_child_of_node_scoped(np, nand_np) {
 		ret = mtk_nfc_nand_chip_init(dev, nfc, nand_np);
 		if (ret) {
-			of_node_put(nand_np);
+			mtk_nfc_nand_chips_cleanup(nfc);
 			return ret;
 		}
 	}
@@ -1570,20 +1586,8 @@ static int mtk_nfc_probe(struct platform_device *pdev)
 static void mtk_nfc_remove(struct platform_device *pdev)
 {
 	struct mtk_nfc *nfc = platform_get_drvdata(pdev);
-	struct mtk_nfc_nand_chip *mtk_chip;
-	struct nand_chip *chip;
-	int ret;
-
-	while (!list_empty(&nfc->chips)) {
-		mtk_chip = list_first_entry(&nfc->chips,
-					    struct mtk_nfc_nand_chip, node);
-		chip = &mtk_chip->nand;
-		ret = mtd_device_unregister(nand_to_mtd(chip));
-		WARN_ON(ret);
-		nand_cleanup(chip);
-		list_del(&mtk_chip->node);
-	}
 
+	mtk_nfc_nand_chips_cleanup(nfc);
 	mtk_ecc_release(nfc->ecc);
 }
 
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 7aca0544fb29..e80992b4f9de 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -68,6 +68,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	__be16 proto;
 	void *oiph;
 	int err;
+	int nh;
 
 	bareudp = rcu_dereference_sk_user_data(sk);
 	if (!bareudp)
@@ -148,10 +149,25 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	}
 	skb_dst_set(skb, &tun_dst->dst);
 	skb->dev = bareudp->dev;
-	oiph = skb_network_header(skb);
-	skb_reset_network_header(skb);
 	skb_reset_mac_header(skb);
 
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
+	skb_reset_network_header(skb);
+
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(bareudp->dev, rx_length_errors);
+		DEV_STATS_INC(bareudp->dev, rx_errors);
+		goto drop;
+	}
+
+	/* Get the outer header. */
+	oiph = skb->head + nh;
+
 	if (!ipv6_mod_enabled() || family == AF_INET)
 		err = IP_ECN_decapsulate(oiph, skb);
 	else
@@ -301,6 +317,9 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be32 saddr;
 	int err;
 
+	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+		return -EINVAL;
+
 	if (!sock)
 		return -ESHUTDOWN;
 
@@ -368,6 +387,9 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
+	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+		return -EINVAL;
+
 	if (!sock)
 		return -ESHUTDOWN;
 
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 60db34095a25..3c61f5fbe6b7 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5536,9 +5536,9 @@ bond_xdp_get_xmit_slave(struct net_device *bond_dev, struct xdp_buff *xdp)
 		break;
 
 	default:
-		/* Should never happen. Mode guarded by bond_xdp_check() */
-		netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmit\n", BOND_MODE(bond));
-		WARN_ON_ONCE(1);
+		if (net_ratelimit())
+			netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmit\n",
+				   BOND_MODE(bond));
 		return NULL;
 	}
 
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index ddde067f593f..0f9f17fdb3bb 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1720,11 +1720,7 @@ static int m_can_close(struct net_device *dev)
 
 	netif_stop_queue(dev);
 
-	if (!cdev->is_peripheral)
-		napi_disable(&cdev->napi);
-
 	m_can_stop(dev);
-	m_can_clk_stop(cdev);
 	free_irq(dev->irq, dev);
 
 	m_can_clean(dev);
@@ -1733,10 +1729,13 @@ static int m_can_close(struct net_device *dev)
 		destroy_workqueue(cdev->tx_wq);
 		cdev->tx_wq = NULL;
 		can_rx_offload_disable(&cdev->offload);
+	} else {
+		napi_disable(&cdev->napi);
 	}
 
 	close_candev(dev);
 
+	m_can_clk_stop(cdev);
 	phy_power_off(cdev->transceiver);
 
 	return 0;
@@ -1987,6 +1986,8 @@ static int m_can_open(struct net_device *dev)
 
 	if (cdev->is_peripheral)
 		can_rx_offload_enable(&cdev->offload);
+	else
+		napi_enable(&cdev->napi);
 
 	/* register interrupt handler */
 	if (cdev->is_peripheral) {
@@ -2020,9 +2021,6 @@ static int m_can_open(struct net_device *dev)
 	if (err)
 		goto exit_start_fail;
 
-	if (!cdev->is_peripheral)
-		napi_enable(&cdev->napi);
-
 	netif_start_queue(dev);
 
 	return 0;
@@ -2036,6 +2034,8 @@ static int m_can_open(struct net_device *dev)
 out_wq_fail:
 	if (cdev->is_peripheral)
 		can_rx_offload_disable(&cdev->offload);
+	else
+		napi_disable(&cdev->napi);
 	close_candev(dev);
 exit_disable_clks:
 	m_can_clk_stop(cdev);
diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 41a0e4261d15..03ad10b01867 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -3,7 +3,7 @@
  * CAN driver for esd electronics gmbh CAN-USB/2, CAN-USB/3 and CAN-USB/Micro
  *
  * Copyright (C) 2010-2012 esd electronic system design gmbh, Matthias Fuchs <socketcan@esd.eu>
- * Copyright (C) 2022-2023 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
+ * Copyright (C) 2022-2024 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
  */
 
 #include <linux/can.h>
@@ -1116,9 +1116,6 @@ static int esd_usb_3_set_bittiming(struct net_device *netdev)
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		flags |= ESD_USB_3_BAUDRATE_FLAG_LOM;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		flags |= ESD_USB_3_BAUDRATE_FLAG_TRS;
-
 	baud_x->nom.brp = cpu_to_le16(nom_bt->brp & (nom_btc->brp_max - 1));
 	baud_x->nom.sjw = cpu_to_le16(nom_bt->sjw & (nom_btc->sjw_max - 1));
 	baud_x->nom.tseg1 = cpu_to_le16((nom_bt->prop_seg + nom_bt->phase_seg1)
@@ -1219,7 +1216,6 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 	switch (le16_to_cpu(dev->udev->descriptor.idProduct)) {
 	case ESD_USB_CANUSB3_PRODUCT_ID:
 		priv->can.clock.freq = ESD_USB_3_CAN_CLOCK;
-		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 		priv->can.bittiming_const = &esd_usb_3_nom_bittiming_const;
 		priv->can.data_bittiming_const = &esd_usb_3_data_bittiming_const;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 5c45f42232d3..f04f42ea60c0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2305,12 +2305,11 @@ static int enetc_setup_irqs(struct enetc_ndev_priv *priv)
 
 		snprintf(v->name, sizeof(v->name), "%s-rxtx%d",
 			 priv->ndev->name, i);
-		err = request_irq(irq, enetc_msix, 0, v->name, v);
+		err = request_irq(irq, enetc_msix, IRQF_NO_AUTOEN, v->name, v);
 		if (err) {
 			dev_err(priv->dev, "request_irq() failed!\n");
 			goto irq_err;
 		}
-		disable_irq(irq);
 
 		v->tbier_base = hw->reg + ENETC_BDR(TX, 0, ENETC_TBIER);
 		v->rbier = hw->reg + ENETC_BDR(RX, i, ENETC_RBIER);
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index e7a036538246..f9e43d171f17 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -17,10 +17,8 @@ struct idpf_vport_max_q;
 #include <linux/sctp.h>
 #include <linux/ethtool_netlink.h>
 #include <net/gro.h>
-#include <linux/dim.h>
 
 #include "virtchnl2.h"
-#include "idpf_lan_txrx.h"
 #include "idpf_txrx.h"
 #include "idpf_controlq.h"
 
@@ -302,7 +300,7 @@ struct idpf_vport {
 	u16 num_txq_grp;
 	struct idpf_txq_group *txq_grps;
 	u32 txq_model;
-	struct idpf_queue **txqs;
+	struct idpf_tx_queue **txqs;
 	bool crc_enable;
 
 	u16 num_rxq;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 1885ba618981..e933fed16c7e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -437,22 +437,24 @@ struct idpf_stats {
 	.stat_offset = offsetof(_type, _stat) \
 }
 
-/* Helper macro for defining some statistics related to queues */
-#define IDPF_QUEUE_STAT(_name, _stat) \
-	IDPF_STAT(struct idpf_queue, _name, _stat)
+/* Helper macros for defining some statistics related to queues */
+#define IDPF_RX_QUEUE_STAT(_name, _stat) \
+	IDPF_STAT(struct idpf_rx_queue, _name, _stat)
+#define IDPF_TX_QUEUE_STAT(_name, _stat) \
+	IDPF_STAT(struct idpf_tx_queue, _name, _stat)
 
 /* Stats associated with a Tx queue */
 static const struct idpf_stats idpf_gstrings_tx_queue_stats[] = {
-	IDPF_QUEUE_STAT("pkts", q_stats.tx.packets),
-	IDPF_QUEUE_STAT("bytes", q_stats.tx.bytes),
-	IDPF_QUEUE_STAT("lso_pkts", q_stats.tx.lso_pkts),
+	IDPF_TX_QUEUE_STAT("pkts", q_stats.packets),
+	IDPF_TX_QUEUE_STAT("bytes", q_stats.bytes),
+	IDPF_TX_QUEUE_STAT("lso_pkts", q_stats.lso_pkts),
 };
 
 /* Stats associated with an Rx queue */
 static const struct idpf_stats idpf_gstrings_rx_queue_stats[] = {
-	IDPF_QUEUE_STAT("pkts", q_stats.rx.packets),
-	IDPF_QUEUE_STAT("bytes", q_stats.rx.bytes),
-	IDPF_QUEUE_STAT("rx_gro_hw_pkts", q_stats.rx.rsc_pkts),
+	IDPF_RX_QUEUE_STAT("pkts", q_stats.packets),
+	IDPF_RX_QUEUE_STAT("bytes", q_stats.bytes),
+	IDPF_RX_QUEUE_STAT("rx_gro_hw_pkts", q_stats.rsc_pkts),
 };
 
 #define IDPF_TX_QUEUE_STATS_LEN		ARRAY_SIZE(idpf_gstrings_tx_queue_stats)
@@ -633,7 +635,7 @@ static int idpf_get_sset_count(struct net_device *netdev, int sset)
  * Copies the stat data defined by the pointer and stat structure pair into
  * the memory supplied as data. If the pointer is null, data will be zero'd.
  */
-static void idpf_add_one_ethtool_stat(u64 *data, void *pstat,
+static void idpf_add_one_ethtool_stat(u64 *data, const void *pstat,
 				      const struct idpf_stats *stat)
 {
 	char *p;
@@ -671,6 +673,7 @@ static void idpf_add_one_ethtool_stat(u64 *data, void *pstat,
  * idpf_add_queue_stats - copy queue statistics into supplied buffer
  * @data: ethtool stats buffer
  * @q: the queue to copy
+ * @type: type of the queue
  *
  * Queue statistics must be copied while protected by u64_stats_fetch_begin,
  * so we can't directly use idpf_add_ethtool_stats. Assumes that queue stats
@@ -681,19 +684,23 @@ static void idpf_add_one_ethtool_stat(u64 *data, void *pstat,
  *
  * This function expects to be called while under rcu_read_lock().
  */
-static void idpf_add_queue_stats(u64 **data, struct idpf_queue *q)
+static void idpf_add_queue_stats(u64 **data, const void *q,
+				 enum virtchnl2_queue_type type)
 {
+	const struct u64_stats_sync *stats_sync;
 	const struct idpf_stats *stats;
 	unsigned int start;
 	unsigned int size;
 	unsigned int i;
 
-	if (q->q_type == VIRTCHNL2_QUEUE_TYPE_RX) {
+	if (type == VIRTCHNL2_QUEUE_TYPE_RX) {
 		size = IDPF_RX_QUEUE_STATS_LEN;
 		stats = idpf_gstrings_rx_queue_stats;
+		stats_sync = &((const struct idpf_rx_queue *)q)->stats_sync;
 	} else {
 		size = IDPF_TX_QUEUE_STATS_LEN;
 		stats = idpf_gstrings_tx_queue_stats;
+		stats_sync = &((const struct idpf_tx_queue *)q)->stats_sync;
 	}
 
 	/* To avoid invalid statistics values, ensure that we keep retrying
@@ -701,10 +708,10 @@ static void idpf_add_queue_stats(u64 **data, struct idpf_queue *q)
 	 * u64_stats_fetch_retry.
 	 */
 	do {
-		start = u64_stats_fetch_begin(&q->stats_sync);
+		start = u64_stats_fetch_begin(stats_sync);
 		for (i = 0; i < size; i++)
 			idpf_add_one_ethtool_stat(&(*data)[i], q, &stats[i]);
-	} while (u64_stats_fetch_retry(&q->stats_sync, start));
+	} while (u64_stats_fetch_retry(stats_sync, start));
 
 	/* Once we successfully copy the stats in, update the data pointer */
 	*data += size;
@@ -793,7 +800,7 @@ static void idpf_collect_queue_stats(struct idpf_vport *vport)
 		for (j = 0; j < num_rxq; j++) {
 			u64 hw_csum_err, hsplit, hsplit_hbo, bad_descs;
 			struct idpf_rx_queue_stats *stats;
-			struct idpf_queue *rxq;
+			struct idpf_rx_queue *rxq;
 			unsigned int start;
 
 			if (idpf_is_queue_model_split(vport->rxq_model))
@@ -807,7 +814,7 @@ static void idpf_collect_queue_stats(struct idpf_vport *vport)
 			do {
 				start = u64_stats_fetch_begin(&rxq->stats_sync);
 
-				stats = &rxq->q_stats.rx;
+				stats = &rxq->q_stats;
 				hw_csum_err = u64_stats_read(&stats->hw_csum_err);
 				hsplit = u64_stats_read(&stats->hsplit_pkts);
 				hsplit_hbo = u64_stats_read(&stats->hsplit_buf_ovf);
@@ -828,7 +835,7 @@ static void idpf_collect_queue_stats(struct idpf_vport *vport)
 
 		for (j = 0; j < txq_grp->num_txq; j++) {
 			u64 linearize, qbusy, skb_drops, dma_map_errs;
-			struct idpf_queue *txq = txq_grp->txqs[j];
+			struct idpf_tx_queue *txq = txq_grp->txqs[j];
 			struct idpf_tx_queue_stats *stats;
 			unsigned int start;
 
@@ -838,7 +845,7 @@ static void idpf_collect_queue_stats(struct idpf_vport *vport)
 			do {
 				start = u64_stats_fetch_begin(&txq->stats_sync);
 
-				stats = &txq->q_stats.tx;
+				stats = &txq->q_stats;
 				linearize = u64_stats_read(&stats->linearize);
 				qbusy = u64_stats_read(&stats->q_busy);
 				skb_drops = u64_stats_read(&stats->skb_drops);
@@ -896,12 +903,12 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 		qtype = VIRTCHNL2_QUEUE_TYPE_TX;
 
 		for (j = 0; j < txq_grp->num_txq; j++, total++) {
-			struct idpf_queue *txq = txq_grp->txqs[j];
+			struct idpf_tx_queue *txq = txq_grp->txqs[j];
 
 			if (!txq)
 				idpf_add_empty_queue_stats(&data, qtype);
 			else
-				idpf_add_queue_stats(&data, txq);
+				idpf_add_queue_stats(&data, txq, qtype);
 		}
 	}
 
@@ -929,7 +936,7 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 			num_rxq = rxq_grp->singleq.num_rxq;
 
 		for (j = 0; j < num_rxq; j++, total++) {
-			struct idpf_queue *rxq;
+			struct idpf_rx_queue *rxq;
 
 			if (is_splitq)
 				rxq = &rxq_grp->splitq.rxq_sets[j]->rxq;
@@ -938,7 +945,7 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 			if (!rxq)
 				idpf_add_empty_queue_stats(&data, qtype);
 			else
-				idpf_add_queue_stats(&data, rxq);
+				idpf_add_queue_stats(&data, rxq, qtype);
 
 			/* In splitq mode, don't get page pool stats here since
 			 * the pools are attached to the buffer queues
@@ -953,7 +960,7 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 
 	for (i = 0; i < vport->num_rxq_grp; i++) {
 		for (j = 0; j < vport->num_bufqs_per_qgrp; j++) {
-			struct idpf_queue *rxbufq =
+			struct idpf_buf_queue *rxbufq =
 				&vport->rxq_grps[i].splitq.bufq_sets[j].bufq;
 
 			page_pool_get_stats(rxbufq->pp, &pp_stats);
@@ -971,60 +978,64 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 }
 
 /**
- * idpf_find_rxq - find rxq from q index
+ * idpf_find_rxq_vec - find rxq vector from q index
  * @vport: virtual port associated to queue
  * @q_num: q index used to find queue
  *
- * returns pointer to rx queue
+ * returns pointer to rx vector
  */
-static struct idpf_queue *idpf_find_rxq(struct idpf_vport *vport, int q_num)
+static struct idpf_q_vector *idpf_find_rxq_vec(const struct idpf_vport *vport,
+					       int q_num)
 {
 	int q_grp, q_idx;
 
 	if (!idpf_is_queue_model_split(vport->rxq_model))
-		return vport->rxq_grps->singleq.rxqs[q_num];
+		return vport->rxq_grps->singleq.rxqs[q_num]->q_vector;
 
 	q_grp = q_num / IDPF_DFLT_SPLITQ_RXQ_PER_GROUP;
 	q_idx = q_num % IDPF_DFLT_SPLITQ_RXQ_PER_GROUP;
 
-	return &vport->rxq_grps[q_grp].splitq.rxq_sets[q_idx]->rxq;
+	return vport->rxq_grps[q_grp].splitq.rxq_sets[q_idx]->rxq.q_vector;
 }
 
 /**
- * idpf_find_txq - find txq from q index
+ * idpf_find_txq_vec - find txq vector from q index
  * @vport: virtual port associated to queue
  * @q_num: q index used to find queue
  *
- * returns pointer to tx queue
+ * returns pointer to tx vector
  */
-static struct idpf_queue *idpf_find_txq(struct idpf_vport *vport, int q_num)
+static struct idpf_q_vector *idpf_find_txq_vec(const struct idpf_vport *vport,
+					       int q_num)
 {
 	int q_grp;
 
 	if (!idpf_is_queue_model_split(vport->txq_model))
-		return vport->txqs[q_num];
+		return vport->txqs[q_num]->q_vector;
 
 	q_grp = q_num / IDPF_DFLT_SPLITQ_TXQ_PER_GROUP;
 
-	return vport->txq_grps[q_grp].complq;
+	return vport->txq_grps[q_grp].complq->q_vector;
 }
 
 /**
  * __idpf_get_q_coalesce - get ITR values for specific queue
  * @ec: ethtool structure to fill with driver's coalesce settings
- * @q: quuee of Rx or Tx
+ * @q_vector: queue vector corresponding to this queue
+ * @type: queue type
  */
 static void __idpf_get_q_coalesce(struct ethtool_coalesce *ec,
-				  struct idpf_queue *q)
+				  const struct idpf_q_vector *q_vector,
+				  enum virtchnl2_queue_type type)
 {
-	if (q->q_type == VIRTCHNL2_QUEUE_TYPE_RX) {
+	if (type == VIRTCHNL2_QUEUE_TYPE_RX) {
 		ec->use_adaptive_rx_coalesce =
-				IDPF_ITR_IS_DYNAMIC(q->q_vector->rx_intr_mode);
-		ec->rx_coalesce_usecs = q->q_vector->rx_itr_value;
+				IDPF_ITR_IS_DYNAMIC(q_vector->rx_intr_mode);
+		ec->rx_coalesce_usecs = q_vector->rx_itr_value;
 	} else {
 		ec->use_adaptive_tx_coalesce =
-				IDPF_ITR_IS_DYNAMIC(q->q_vector->tx_intr_mode);
-		ec->tx_coalesce_usecs = q->q_vector->tx_itr_value;
+				IDPF_ITR_IS_DYNAMIC(q_vector->tx_intr_mode);
+		ec->tx_coalesce_usecs = q_vector->tx_itr_value;
 	}
 }
 
@@ -1040,8 +1051,8 @@ static int idpf_get_q_coalesce(struct net_device *netdev,
 			       struct ethtool_coalesce *ec,
 			       u32 q_num)
 {
-	struct idpf_netdev_priv *np = netdev_priv(netdev);
-	struct idpf_vport *vport;
+	const struct idpf_netdev_priv *np = netdev_priv(netdev);
+	const struct idpf_vport *vport;
 	int err = 0;
 
 	idpf_vport_ctrl_lock(netdev);
@@ -1056,10 +1067,12 @@ static int idpf_get_q_coalesce(struct net_device *netdev,
 	}
 
 	if (q_num < vport->num_rxq)
-		__idpf_get_q_coalesce(ec, idpf_find_rxq(vport, q_num));
+		__idpf_get_q_coalesce(ec, idpf_find_rxq_vec(vport, q_num),
+				      VIRTCHNL2_QUEUE_TYPE_RX);
 
 	if (q_num < vport->num_txq)
-		__idpf_get_q_coalesce(ec, idpf_find_txq(vport, q_num));
+		__idpf_get_q_coalesce(ec, idpf_find_txq_vec(vport, q_num),
+				      VIRTCHNL2_QUEUE_TYPE_TX);
 
 unlock_mutex:
 	idpf_vport_ctrl_unlock(netdev);
@@ -1103,16 +1116,15 @@ static int idpf_get_per_q_coalesce(struct net_device *netdev, u32 q_num,
 /**
  * __idpf_set_q_coalesce - set ITR values for specific queue
  * @ec: ethtool structure from user to update ITR settings
- * @q: queue for which itr values has to be set
+ * @qv: queue vector for which itr values has to be set
  * @is_rxq: is queue type rx
  *
  * Returns 0 on success, negative otherwise.
  */
-static int __idpf_set_q_coalesce(struct ethtool_coalesce *ec,
-				 struct idpf_queue *q, bool is_rxq)
+static int __idpf_set_q_coalesce(const struct ethtool_coalesce *ec,
+				 struct idpf_q_vector *qv, bool is_rxq)
 {
 	u32 use_adaptive_coalesce, coalesce_usecs;
-	struct idpf_q_vector *qv = q->q_vector;
 	bool is_dim_ena = false;
 	u16 itr_val;
 
@@ -1128,7 +1140,7 @@ static int __idpf_set_q_coalesce(struct ethtool_coalesce *ec,
 		itr_val = qv->tx_itr_value;
 	}
 	if (coalesce_usecs != itr_val && use_adaptive_coalesce) {
-		netdev_err(q->vport->netdev, "Cannot set coalesce usecs if adaptive enabled\n");
+		netdev_err(qv->vport->netdev, "Cannot set coalesce usecs if adaptive enabled\n");
 
 		return -EINVAL;
 	}
@@ -1137,7 +1149,7 @@ static int __idpf_set_q_coalesce(struct ethtool_coalesce *ec,
 		return 0;
 
 	if (coalesce_usecs > IDPF_ITR_MAX) {
-		netdev_err(q->vport->netdev,
+		netdev_err(qv->vport->netdev,
 			   "Invalid value, %d-usecs range is 0-%d\n",
 			   coalesce_usecs, IDPF_ITR_MAX);
 
@@ -1146,7 +1158,7 @@ static int __idpf_set_q_coalesce(struct ethtool_coalesce *ec,
 
 	if (coalesce_usecs % 2) {
 		coalesce_usecs--;
-		netdev_info(q->vport->netdev,
+		netdev_info(qv->vport->netdev,
 			    "HW only supports even ITR values, ITR rounded to %d\n",
 			    coalesce_usecs);
 	}
@@ -1185,15 +1197,16 @@ static int __idpf_set_q_coalesce(struct ethtool_coalesce *ec,
  *
  * Return 0 on success, and negative on failure
  */
-static int idpf_set_q_coalesce(struct idpf_vport *vport,
-			       struct ethtool_coalesce *ec,
+static int idpf_set_q_coalesce(const struct idpf_vport *vport,
+			       const struct ethtool_coalesce *ec,
 			       int q_num, bool is_rxq)
 {
-	struct idpf_queue *q;
+	struct idpf_q_vector *qv;
 
-	q = is_rxq ? idpf_find_rxq(vport, q_num) : idpf_find_txq(vport, q_num);
+	qv = is_rxq ? idpf_find_rxq_vec(vport, q_num) :
+		      idpf_find_txq_vec(vport, q_num);
 
-	if (q && __idpf_set_q_coalesce(ec, q, is_rxq))
+	if (qv && __idpf_set_q_coalesce(ec, qv, is_rxq))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
index a5752dcab888..8c7f8ef8f1a1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
@@ -4,6 +4,8 @@
 #ifndef _IDPF_LAN_TXRX_H_
 #define _IDPF_LAN_TXRX_H_
 
+#include <linux/bits.h>
+
 enum idpf_rss_hash {
 	IDPF_HASH_INVALID			= 0,
 	/* Values 1 - 28 are reserved for future use */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 3ac9d7ab83f2..5e336f64bc25 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -4,8 +4,7 @@
 #include "idpf.h"
 #include "idpf_virtchnl.h"
 
-static const struct net_device_ops idpf_netdev_ops_splitq;
-static const struct net_device_ops idpf_netdev_ops_singleq;
+static const struct net_device_ops idpf_netdev_ops;
 
 /**
  * idpf_init_vector_stack - Fill the MSIX vector stack with vector index
@@ -765,10 +764,7 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	}
 
 	/* assign netdev_ops */
-	if (idpf_is_queue_model_split(vport->txq_model))
-		netdev->netdev_ops = &idpf_netdev_ops_splitq;
-	else
-		netdev->netdev_ops = &idpf_netdev_ops_singleq;
+	netdev->netdev_ops = &idpf_netdev_ops;
 
 	/* setup watchdog timeout value to be 5 second */
 	netdev->watchdog_timeo = 5 * HZ;
@@ -1318,14 +1314,14 @@ static void idpf_rx_init_buf_tail(struct idpf_vport *vport)
 
 		if (idpf_is_queue_model_split(vport->rxq_model)) {
 			for (j = 0; j < vport->num_bufqs_per_qgrp; j++) {
-				struct idpf_queue *q =
+				const struct idpf_buf_queue *q =
 					&grp->splitq.bufq_sets[j].bufq;
 
 				writel(q->next_to_alloc, q->tail);
 			}
 		} else {
 			for (j = 0; j < grp->singleq.num_rxq; j++) {
-				struct idpf_queue *q =
+				const struct idpf_rx_queue *q =
 					grp->singleq.rxqs[j];
 
 				writel(q->next_to_alloc, q->tail);
@@ -1852,7 +1848,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	enum idpf_vport_state current_state = np->state;
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_vport *new_vport;
-	int err, i;
+	int err;
 
 	/* If the system is low on memory, we can end up in bad state if we
 	 * free all the memory for queue resources and try to allocate them
@@ -1923,46 +1919,6 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	 */
 	memcpy(vport, new_vport, offsetof(struct idpf_vport, link_speed_mbps));
 
-	/* Since idpf_vport_queues_alloc was called with new_port, the queue
-	 * back pointers are currently pointing to the local new_vport. Reset
-	 * the backpointers to the original vport here
-	 */
-	for (i = 0; i < vport->num_txq_grp; i++) {
-		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
-		int j;
-
-		tx_qgrp->vport = vport;
-		for (j = 0; j < tx_qgrp->num_txq; j++)
-			tx_qgrp->txqs[j]->vport = vport;
-
-		if (idpf_is_queue_model_split(vport->txq_model))
-			tx_qgrp->complq->vport = vport;
-	}
-
-	for (i = 0; i < vport->num_rxq_grp; i++) {
-		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
-		struct idpf_queue *q;
-		u16 num_rxq;
-		int j;
-
-		rx_qgrp->vport = vport;
-		for (j = 0; j < vport->num_bufqs_per_qgrp; j++)
-			rx_qgrp->splitq.bufq_sets[j].bufq.vport = vport;
-
-		if (idpf_is_queue_model_split(vport->rxq_model))
-			num_rxq = rx_qgrp->splitq.num_rxq_sets;
-		else
-			num_rxq = rx_qgrp->singleq.num_rxq;
-
-		for (j = 0; j < num_rxq; j++) {
-			if (idpf_is_queue_model_split(vport->rxq_model))
-				q = &rx_qgrp->splitq.rxq_sets[j]->rxq;
-			else
-				q = rx_qgrp->singleq.rxqs[j];
-			q->vport = vport;
-		}
-	}
-
 	if (reset_cause == IDPF_SR_Q_CHANGE)
 		idpf_vport_alloc_vec_indexes(vport);
 
@@ -2393,24 +2349,10 @@ void idpf_free_dma_mem(struct idpf_hw *hw, struct idpf_dma_mem *mem)
 	mem->pa = 0;
 }
 
-static const struct net_device_ops idpf_netdev_ops_splitq = {
-	.ndo_open = idpf_open,
-	.ndo_stop = idpf_stop,
-	.ndo_start_xmit = idpf_tx_splitq_start,
-	.ndo_features_check = idpf_features_check,
-	.ndo_set_rx_mode = idpf_set_rx_mode,
-	.ndo_validate_addr = eth_validate_addr,
-	.ndo_set_mac_address = idpf_set_mac,
-	.ndo_change_mtu = idpf_change_mtu,
-	.ndo_get_stats64 = idpf_get_stats64,
-	.ndo_set_features = idpf_set_features,
-	.ndo_tx_timeout = idpf_tx_timeout,
-};
-
-static const struct net_device_ops idpf_netdev_ops_singleq = {
+static const struct net_device_ops idpf_netdev_ops = {
 	.ndo_open = idpf_open,
 	.ndo_stop = idpf_stop,
-	.ndo_start_xmit = idpf_tx_singleq_start,
+	.ndo_start_xmit = idpf_tx_start,
 	.ndo_features_check = idpf_features_check,
 	.ndo_set_rx_mode = idpf_set_rx_mode,
 	.ndo_validate_addr = eth_validate_addr,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 27b93592c4ba..5e5fa2d0aa4d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -186,7 +186,7 @@ static int idpf_tx_singleq_csum(struct sk_buff *skb,
  * and gets a physical address for each memory location and programs
  * it and the length into the transmit base mode descriptor.
  */
-static void idpf_tx_singleq_map(struct idpf_queue *tx_q,
+static void idpf_tx_singleq_map(struct idpf_tx_queue *tx_q,
 				struct idpf_tx_buf *first,
 				struct idpf_tx_offload_params *offloads)
 {
@@ -205,12 +205,12 @@ static void idpf_tx_singleq_map(struct idpf_queue *tx_q,
 	data_len = skb->data_len;
 	size = skb_headlen(skb);
 
-	tx_desc = IDPF_BASE_TX_DESC(tx_q, i);
+	tx_desc = &tx_q->base_tx[i];
 
 	dma = dma_map_single(tx_q->dev, skb->data, size, DMA_TO_DEVICE);
 
 	/* write each descriptor with CRC bit */
-	if (tx_q->vport->crc_enable)
+	if (idpf_queue_has(CRC_EN, tx_q))
 		td_cmd |= IDPF_TX_DESC_CMD_ICRC;
 
 	for (frag = &skb_shinfo(skb)->frags[0];; frag++) {
@@ -239,7 +239,7 @@ static void idpf_tx_singleq_map(struct idpf_queue *tx_q,
 			i++;
 
 			if (i == tx_q->desc_count) {
-				tx_desc = IDPF_BASE_TX_DESC(tx_q, 0);
+				tx_desc = &tx_q->base_tx[0];
 				i = 0;
 			}
 
@@ -259,7 +259,7 @@ static void idpf_tx_singleq_map(struct idpf_queue *tx_q,
 		i++;
 
 		if (i == tx_q->desc_count) {
-			tx_desc = IDPF_BASE_TX_DESC(tx_q, 0);
+			tx_desc = &tx_q->base_tx[0];
 			i = 0;
 		}
 
@@ -285,7 +285,7 @@ static void idpf_tx_singleq_map(struct idpf_queue *tx_q,
 	/* set next_to_watch value indicating a packet is present */
 	first->next_to_watch = tx_desc;
 
-	nq = netdev_get_tx_queue(tx_q->vport->netdev, tx_q->idx);
+	nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 	netdev_tx_sent_queue(nq, first->bytecount);
 
 	idpf_tx_buf_hw_update(tx_q, i, netdev_xmit_more());
@@ -299,7 +299,7 @@ static void idpf_tx_singleq_map(struct idpf_queue *tx_q,
  * ring entry to reflect that this index is a context descriptor
  */
 static struct idpf_base_tx_ctx_desc *
-idpf_tx_singleq_get_ctx_desc(struct idpf_queue *txq)
+idpf_tx_singleq_get_ctx_desc(struct idpf_tx_queue *txq)
 {
 	struct idpf_base_tx_ctx_desc *ctx_desc;
 	int ntu = txq->next_to_use;
@@ -307,7 +307,7 @@ idpf_tx_singleq_get_ctx_desc(struct idpf_queue *txq)
 	memset(&txq->tx_buf[ntu], 0, sizeof(struct idpf_tx_buf));
 	txq->tx_buf[ntu].ctx_entry = true;
 
-	ctx_desc = IDPF_BASE_TX_CTX_DESC(txq, ntu);
+	ctx_desc = &txq->base_ctx[ntu];
 
 	IDPF_SINGLEQ_BUMP_RING_IDX(txq, ntu);
 	txq->next_to_use = ntu;
@@ -320,7 +320,7 @@ idpf_tx_singleq_get_ctx_desc(struct idpf_queue *txq)
  * @txq: queue to send buffer on
  * @offload: offload parameter structure
  **/
-static void idpf_tx_singleq_build_ctx_desc(struct idpf_queue *txq,
+static void idpf_tx_singleq_build_ctx_desc(struct idpf_tx_queue *txq,
 					   struct idpf_tx_offload_params *offload)
 {
 	struct idpf_base_tx_ctx_desc *desc = idpf_tx_singleq_get_ctx_desc(txq);
@@ -333,7 +333,7 @@ static void idpf_tx_singleq_build_ctx_desc(struct idpf_queue *txq,
 		qw1 |= FIELD_PREP(IDPF_TXD_CTX_QW1_MSS_M, offload->mss);
 
 		u64_stats_update_begin(&txq->stats_sync);
-		u64_stats_inc(&txq->q_stats.tx.lso_pkts);
+		u64_stats_inc(&txq->q_stats.lso_pkts);
 		u64_stats_update_end(&txq->stats_sync);
 	}
 
@@ -351,8 +351,8 @@ static void idpf_tx_singleq_build_ctx_desc(struct idpf_queue *txq,
  *
  * Returns NETDEV_TX_OK if sent, else an error code
  */
-static netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
-					 struct idpf_queue *tx_q)
+netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
+				  struct idpf_tx_queue *tx_q)
 {
 	struct idpf_tx_offload_params offload = { };
 	struct idpf_tx_buf *first;
@@ -369,6 +369,10 @@ static netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 				      IDPF_TX_DESCS_FOR_CTX)) {
 		idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
 
+		u64_stats_update_begin(&tx_q->stats_sync);
+		u64_stats_inc(&tx_q->q_stats.q_busy);
+		u64_stats_update_end(&tx_q->stats_sync);
+
 		return NETDEV_TX_BUSY;
 	}
 
@@ -408,33 +412,6 @@ static netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 	return idpf_tx_drop_skb(tx_q, skb);
 }
 
-/**
- * idpf_tx_singleq_start - Selects the right Tx queue to send buffer
- * @skb: send buffer
- * @netdev: network interface device structure
- *
- * Returns NETDEV_TX_OK if sent, else an error code
- */
-netdev_tx_t idpf_tx_singleq_start(struct sk_buff *skb,
-				  struct net_device *netdev)
-{
-	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
-	struct idpf_queue *tx_q;
-
-	tx_q = vport->txqs[skb_get_queue_mapping(skb)];
-
-	/* hardware can't handle really short frames, hardware padding works
-	 * beyond this point
-	 */
-	if (skb_put_padto(skb, IDPF_TX_MIN_PKT_LEN)) {
-		idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
-
-		return NETDEV_TX_OK;
-	}
-
-	return idpf_tx_singleq_frame(skb, tx_q);
-}
-
 /**
  * idpf_tx_singleq_clean - Reclaim resources from queue
  * @tx_q: Tx queue to clean
@@ -442,20 +419,19 @@ netdev_tx_t idpf_tx_singleq_start(struct sk_buff *skb,
  * @cleaned: returns number of packets cleaned
  *
  */
-static bool idpf_tx_singleq_clean(struct idpf_queue *tx_q, int napi_budget,
+static bool idpf_tx_singleq_clean(struct idpf_tx_queue *tx_q, int napi_budget,
 				  int *cleaned)
 {
-	unsigned int budget = tx_q->vport->compln_clean_budget;
 	unsigned int total_bytes = 0, total_pkts = 0;
 	struct idpf_base_tx_desc *tx_desc;
+	u32 budget = tx_q->clean_budget;
 	s16 ntc = tx_q->next_to_clean;
 	struct idpf_netdev_priv *np;
 	struct idpf_tx_buf *tx_buf;
-	struct idpf_vport *vport;
 	struct netdev_queue *nq;
 	bool dont_wake;
 
-	tx_desc = IDPF_BASE_TX_DESC(tx_q, ntc);
+	tx_desc = &tx_q->base_tx[ntc];
 	tx_buf = &tx_q->tx_buf[ntc];
 	ntc -= tx_q->desc_count;
 
@@ -517,7 +493,7 @@ static bool idpf_tx_singleq_clean(struct idpf_queue *tx_q, int napi_budget,
 			if (unlikely(!ntc)) {
 				ntc -= tx_q->desc_count;
 				tx_buf = tx_q->tx_buf;
-				tx_desc = IDPF_BASE_TX_DESC(tx_q, 0);
+				tx_desc = &tx_q->base_tx[0];
 			}
 
 			/* unmap any remaining paged data */
@@ -540,7 +516,7 @@ static bool idpf_tx_singleq_clean(struct idpf_queue *tx_q, int napi_budget,
 		if (unlikely(!ntc)) {
 			ntc -= tx_q->desc_count;
 			tx_buf = tx_q->tx_buf;
-			tx_desc = IDPF_BASE_TX_DESC(tx_q, 0);
+			tx_desc = &tx_q->base_tx[0];
 		}
 	} while (likely(budget));
 
@@ -550,16 +526,15 @@ static bool idpf_tx_singleq_clean(struct idpf_queue *tx_q, int napi_budget,
 	*cleaned += total_pkts;
 
 	u64_stats_update_begin(&tx_q->stats_sync);
-	u64_stats_add(&tx_q->q_stats.tx.packets, total_pkts);
-	u64_stats_add(&tx_q->q_stats.tx.bytes, total_bytes);
+	u64_stats_add(&tx_q->q_stats.packets, total_pkts);
+	u64_stats_add(&tx_q->q_stats.bytes, total_bytes);
 	u64_stats_update_end(&tx_q->stats_sync);
 
-	vport = tx_q->vport;
-	np = netdev_priv(vport->netdev);
-	nq = netdev_get_tx_queue(vport->netdev, tx_q->idx);
+	np = netdev_priv(tx_q->netdev);
+	nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 
 	dont_wake = np->state != __IDPF_VPORT_UP ||
-		    !netif_carrier_ok(vport->netdev);
+		    !netif_carrier_ok(tx_q->netdev);
 	__netif_txq_completed_wake(nq, total_pkts, total_bytes,
 				   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
 				   dont_wake);
@@ -584,7 +559,7 @@ static bool idpf_tx_singleq_clean_all(struct idpf_q_vector *q_vec, int budget,
 
 	budget_per_q = num_txq ? max(budget / num_txq, 1) : 0;
 	for (i = 0; i < num_txq; i++) {
-		struct idpf_queue *q;
+		struct idpf_tx_queue *q;
 
 		q = q_vec->tx[i];
 		clean_complete &= idpf_tx_singleq_clean(q, budget_per_q,
@@ -614,14 +589,9 @@ static bool idpf_rx_singleq_test_staterr(const union virtchnl2_rx_desc *rx_desc,
 
 /**
  * idpf_rx_singleq_is_non_eop - process handling of non-EOP buffers
- * @rxq: Rx ring being processed
  * @rx_desc: Rx descriptor for current buffer
- * @skb: Current socket buffer containing buffer in progress
- * @ntc: next to clean
  */
-static bool idpf_rx_singleq_is_non_eop(struct idpf_queue *rxq,
-				       union virtchnl2_rx_desc *rx_desc,
-				       struct sk_buff *skb, u16 ntc)
+static bool idpf_rx_singleq_is_non_eop(const union virtchnl2_rx_desc *rx_desc)
 {
 	/* if we are the last buffer then there is nothing else to do */
 	if (likely(idpf_rx_singleq_test_staterr(rx_desc, IDPF_RXD_EOF_SINGLEQ)))
@@ -639,7 +609,7 @@ static bool idpf_rx_singleq_is_non_eop(struct idpf_queue *rxq,
  *
  * skb->protocol must be set before this function is called
  */
-static void idpf_rx_singleq_csum(struct idpf_queue *rxq, struct sk_buff *skb,
+static void idpf_rx_singleq_csum(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 				 struct idpf_rx_csum_decoded *csum_bits,
 				 u16 ptype)
 {
@@ -647,14 +617,14 @@ static void idpf_rx_singleq_csum(struct idpf_queue *rxq, struct sk_buff *skb,
 	bool ipv4, ipv6;
 
 	/* check if Rx checksum is enabled */
-	if (unlikely(!(rxq->vport->netdev->features & NETIF_F_RXCSUM)))
+	if (unlikely(!(rxq->netdev->features & NETIF_F_RXCSUM)))
 		return;
 
 	/* check if HW has decoded the packet and checksum */
 	if (unlikely(!(csum_bits->l3l4p)))
 		return;
 
-	decoded = rxq->vport->rx_ptype_lkup[ptype];
+	decoded = rxq->rx_ptype_lkup[ptype];
 	if (unlikely(!(decoded.known && decoded.outer_ip)))
 		return;
 
@@ -707,7 +677,7 @@ static void idpf_rx_singleq_csum(struct idpf_queue *rxq, struct sk_buff *skb,
 
 checksum_fail:
 	u64_stats_update_begin(&rxq->stats_sync);
-	u64_stats_inc(&rxq->q_stats.rx.hw_csum_err);
+	u64_stats_inc(&rxq->q_stats.hw_csum_err);
 	u64_stats_update_end(&rxq->stats_sync);
 }
 
@@ -721,9 +691,9 @@ static void idpf_rx_singleq_csum(struct idpf_queue *rxq, struct sk_buff *skb,
  * This function only operates on the VIRTCHNL2_RXDID_1_32B_BASE_M base 32byte
  * descriptor writeback format.
  **/
-static void idpf_rx_singleq_base_csum(struct idpf_queue *rx_q,
+static void idpf_rx_singleq_base_csum(struct idpf_rx_queue *rx_q,
 				      struct sk_buff *skb,
-				      union virtchnl2_rx_desc *rx_desc,
+				      const union virtchnl2_rx_desc *rx_desc,
 				      u16 ptype)
 {
 	struct idpf_rx_csum_decoded csum_bits;
@@ -761,9 +731,9 @@ static void idpf_rx_singleq_base_csum(struct idpf_queue *rx_q,
  * This function only operates on the VIRTCHNL2_RXDID_2_FLEX_SQ_NIC flexible
  * descriptor writeback format.
  **/
-static void idpf_rx_singleq_flex_csum(struct idpf_queue *rx_q,
+static void idpf_rx_singleq_flex_csum(struct idpf_rx_queue *rx_q,
 				      struct sk_buff *skb,
-				      union virtchnl2_rx_desc *rx_desc,
+				      const union virtchnl2_rx_desc *rx_desc,
 				      u16 ptype)
 {
 	struct idpf_rx_csum_decoded csum_bits;
@@ -801,14 +771,14 @@ static void idpf_rx_singleq_flex_csum(struct idpf_queue *rx_q,
  * This function only operates on the VIRTCHNL2_RXDID_1_32B_BASE_M base 32byte
  * descriptor writeback format.
  **/
-static void idpf_rx_singleq_base_hash(struct idpf_queue *rx_q,
+static void idpf_rx_singleq_base_hash(struct idpf_rx_queue *rx_q,
 				      struct sk_buff *skb,
-				      union virtchnl2_rx_desc *rx_desc,
+				      const union virtchnl2_rx_desc *rx_desc,
 				      struct idpf_rx_ptype_decoded *decoded)
 {
 	u64 mask, qw1;
 
-	if (unlikely(!(rx_q->vport->netdev->features & NETIF_F_RXHASH)))
+	if (unlikely(!(rx_q->netdev->features & NETIF_F_RXHASH)))
 		return;
 
 	mask = VIRTCHNL2_RX_BASE_DESC_FLTSTAT_RSS_HASH_M;
@@ -831,12 +801,12 @@ static void idpf_rx_singleq_base_hash(struct idpf_queue *rx_q,
  * This function only operates on the VIRTCHNL2_RXDID_2_FLEX_SQ_NIC flexible
  * descriptor writeback format.
  **/
-static void idpf_rx_singleq_flex_hash(struct idpf_queue *rx_q,
+static void idpf_rx_singleq_flex_hash(struct idpf_rx_queue *rx_q,
 				      struct sk_buff *skb,
-				      union virtchnl2_rx_desc *rx_desc,
+				      const union virtchnl2_rx_desc *rx_desc,
 				      struct idpf_rx_ptype_decoded *decoded)
 {
-	if (unlikely(!(rx_q->vport->netdev->features & NETIF_F_RXHASH)))
+	if (unlikely(!(rx_q->netdev->features & NETIF_F_RXHASH)))
 		return;
 
 	if (FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_STATUS0_RSS_VALID_M,
@@ -857,16 +827,16 @@ static void idpf_rx_singleq_flex_hash(struct idpf_queue *rx_q,
  * order to populate the hash, checksum, VLAN, protocol, and
  * other fields within the skb.
  */
-static void idpf_rx_singleq_process_skb_fields(struct idpf_queue *rx_q,
-					       struct sk_buff *skb,
-					       union virtchnl2_rx_desc *rx_desc,
-					       u16 ptype)
+static void
+idpf_rx_singleq_process_skb_fields(struct idpf_rx_queue *rx_q,
+				   struct sk_buff *skb,
+				   const union virtchnl2_rx_desc *rx_desc,
+				   u16 ptype)
 {
-	struct idpf_rx_ptype_decoded decoded =
-					rx_q->vport->rx_ptype_lkup[ptype];
+	struct idpf_rx_ptype_decoded decoded = rx_q->rx_ptype_lkup[ptype];
 
 	/* modifies the skb - consumes the enet header */
-	skb->protocol = eth_type_trans(skb, rx_q->vport->netdev);
+	skb->protocol = eth_type_trans(skb, rx_q->netdev);
 
 	/* Check if we're using base mode descriptor IDs */
 	if (rx_q->rxdids == VIRTCHNL2_RXDID_1_32B_BASE_M) {
@@ -878,6 +848,22 @@ static void idpf_rx_singleq_process_skb_fields(struct idpf_queue *rx_q,
 	}
 }
 
+/**
+ * idpf_rx_buf_hw_update - Store the new tail and head values
+ * @rxq: queue to bump
+ * @val: new head index
+ */
+static void idpf_rx_buf_hw_update(struct idpf_rx_queue *rxq, u32 val)
+{
+	rxq->next_to_use = val;
+
+	if (unlikely(!rxq->tail))
+		return;
+
+	/* writel has an implicit memory barrier */
+	writel(val, rxq->tail);
+}
+
 /**
  * idpf_rx_singleq_buf_hw_alloc_all - Replace used receive buffers
  * @rx_q: queue for which the hw buffers are allocated
@@ -885,7 +871,7 @@ static void idpf_rx_singleq_process_skb_fields(struct idpf_queue *rx_q,
  *
  * Returns false if all allocations were successful, true if any fail
  */
-bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_queue *rx_q,
+bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
 				      u16 cleaned_count)
 {
 	struct virtchnl2_singleq_rx_buf_desc *desc;
@@ -895,8 +881,8 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_queue *rx_q,
 	if (!cleaned_count)
 		return false;
 
-	desc = IDPF_SINGLEQ_RX_BUF_DESC(rx_q, nta);
-	buf = &rx_q->rx_buf.buf[nta];
+	desc = &rx_q->single_buf[nta];
+	buf = &rx_q->rx_buf[nta];
 
 	do {
 		dma_addr_t addr;
@@ -915,8 +901,8 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_queue *rx_q,
 		buf++;
 		nta++;
 		if (unlikely(nta == rx_q->desc_count)) {
-			desc = IDPF_SINGLEQ_RX_BUF_DESC(rx_q, 0);
-			buf = rx_q->rx_buf.buf;
+			desc = &rx_q->single_buf[0];
+			buf = rx_q->rx_buf;
 			nta = 0;
 		}
 
@@ -933,7 +919,6 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_queue *rx_q,
 
 /**
  * idpf_rx_singleq_extract_base_fields - Extract fields from the Rx descriptor
- * @rx_q: Rx descriptor queue
  * @rx_desc: the descriptor to process
  * @fields: storage for extracted values
  *
@@ -943,9 +928,9 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_queue *rx_q,
  * This function only operates on the VIRTCHNL2_RXDID_1_32B_BASE_M base 32byte
  * descriptor writeback format.
  */
-static void idpf_rx_singleq_extract_base_fields(struct idpf_queue *rx_q,
-						union virtchnl2_rx_desc *rx_desc,
-						struct idpf_rx_extracted *fields)
+static void
+idpf_rx_singleq_extract_base_fields(const union virtchnl2_rx_desc *rx_desc,
+				    struct idpf_rx_extracted *fields)
 {
 	u64 qword;
 
@@ -957,7 +942,6 @@ static void idpf_rx_singleq_extract_base_fields(struct idpf_queue *rx_q,
 
 /**
  * idpf_rx_singleq_extract_flex_fields - Extract fields from the Rx descriptor
- * @rx_q: Rx descriptor queue
  * @rx_desc: the descriptor to process
  * @fields: storage for extracted values
  *
@@ -967,9 +951,9 @@ static void idpf_rx_singleq_extract_base_fields(struct idpf_queue *rx_q,
  * This function only operates on the VIRTCHNL2_RXDID_2_FLEX_SQ_NIC flexible
  * descriptor writeback format.
  */
-static void idpf_rx_singleq_extract_flex_fields(struct idpf_queue *rx_q,
-						union virtchnl2_rx_desc *rx_desc,
-						struct idpf_rx_extracted *fields)
+static void
+idpf_rx_singleq_extract_flex_fields(const union virtchnl2_rx_desc *rx_desc,
+				    struct idpf_rx_extracted *fields)
 {
 	fields->size = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_PKT_LEN_M,
 				 le16_to_cpu(rx_desc->flex_nic_wb.pkt_len));
@@ -984,14 +968,15 @@ static void idpf_rx_singleq_extract_flex_fields(struct idpf_queue *rx_q,
  * @fields: storage for extracted values
  *
  */
-static void idpf_rx_singleq_extract_fields(struct idpf_queue *rx_q,
-					   union virtchnl2_rx_desc *rx_desc,
-					   struct idpf_rx_extracted *fields)
+static void
+idpf_rx_singleq_extract_fields(const struct idpf_rx_queue *rx_q,
+			       const union virtchnl2_rx_desc *rx_desc,
+			       struct idpf_rx_extracted *fields)
 {
 	if (rx_q->rxdids == VIRTCHNL2_RXDID_1_32B_BASE_M)
-		idpf_rx_singleq_extract_base_fields(rx_q, rx_desc, fields);
+		idpf_rx_singleq_extract_base_fields(rx_desc, fields);
 	else
-		idpf_rx_singleq_extract_flex_fields(rx_q, rx_desc, fields);
+		idpf_rx_singleq_extract_flex_fields(rx_desc, fields);
 }
 
 /**
@@ -1001,7 +986,7 @@ static void idpf_rx_singleq_extract_fields(struct idpf_queue *rx_q,
  *
  * Returns true if there's any budget left (e.g. the clean is finished)
  */
-static int idpf_rx_singleq_clean(struct idpf_queue *rx_q, int budget)
+static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 {
 	unsigned int total_rx_bytes = 0, total_rx_pkts = 0;
 	struct sk_buff *skb = rx_q->skb;
@@ -1016,7 +1001,7 @@ static int idpf_rx_singleq_clean(struct idpf_queue *rx_q, int budget)
 		struct idpf_rx_buf *rx_buf;
 
 		/* get the Rx desc from Rx queue based on 'next_to_clean' */
-		rx_desc = IDPF_RX_DESC(rx_q, ntc);
+		rx_desc = &rx_q->rx[ntc];
 
 		/* status_error_ptype_len will always be zero for unused
 		 * descriptors because it's cleared in cleanup, and overlaps
@@ -1036,7 +1021,7 @@ static int idpf_rx_singleq_clean(struct idpf_queue *rx_q, int budget)
 
 		idpf_rx_singleq_extract_fields(rx_q, rx_desc, &fields);
 
-		rx_buf = &rx_q->rx_buf.buf[ntc];
+		rx_buf = &rx_q->rx_buf[ntc];
 		if (!fields.size) {
 			idpf_rx_put_page(rx_buf);
 			goto skip_data;
@@ -1058,7 +1043,7 @@ static int idpf_rx_singleq_clean(struct idpf_queue *rx_q, int budget)
 		cleaned_count++;
 
 		/* skip if it is non EOP desc */
-		if (idpf_rx_singleq_is_non_eop(rx_q, rx_desc, skb, ntc))
+		if (idpf_rx_singleq_is_non_eop(rx_desc))
 			continue;
 
 #define IDPF_RXD_ERR_S FIELD_PREP(VIRTCHNL2_RX_BASE_DESC_QW1_ERROR_M, \
@@ -1084,7 +1069,7 @@ static int idpf_rx_singleq_clean(struct idpf_queue *rx_q, int budget)
 						   rx_desc, fields.rx_ptype);
 
 		/* send completed skb up the stack */
-		napi_gro_receive(&rx_q->q_vector->napi, skb);
+		napi_gro_receive(rx_q->pp->p.napi, skb);
 		skb = NULL;
 
 		/* update budget accounting */
@@ -1099,8 +1084,8 @@ static int idpf_rx_singleq_clean(struct idpf_queue *rx_q, int budget)
 		failure = idpf_rx_singleq_buf_hw_alloc_all(rx_q, cleaned_count);
 
 	u64_stats_update_begin(&rx_q->stats_sync);
-	u64_stats_add(&rx_q->q_stats.rx.packets, total_rx_pkts);
-	u64_stats_add(&rx_q->q_stats.rx.bytes, total_rx_bytes);
+	u64_stats_add(&rx_q->q_stats.packets, total_rx_pkts);
+	u64_stats_add(&rx_q->q_stats.bytes, total_rx_bytes);
 	u64_stats_update_end(&rx_q->stats_sync);
 
 	/* guarantee a trip back through this routine if there was a failure */
@@ -1127,7 +1112,7 @@ static bool idpf_rx_singleq_clean_all(struct idpf_q_vector *q_vec, int budget,
 	 */
 	budget_per_q = num_rxq ? max(budget / num_rxq, 1) : 0;
 	for (i = 0; i < num_rxq; i++) {
-		struct idpf_queue *rxq = q_vec->rx[i];
+		struct idpf_rx_queue *rxq = q_vec->rx[i];
 		int pkts_cleaned_per_q;
 
 		pkts_cleaned_per_q = idpf_rx_singleq_clean(rxq, budget_per_q);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 20ca04320d4b..9b7e67d0f38b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4,6 +4,9 @@
 #include "idpf.h"
 #include "idpf_virtchnl.h"
 
+static bool idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs,
+			       unsigned int count);
+
 /**
  * idpf_buf_lifo_push - push a buffer pointer onto stack
  * @stack: pointer to stack struct
@@ -60,7 +63,8 @@ void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
  * @tx_q: the queue that owns the buffer
  * @tx_buf: the buffer to free
  */
-static void idpf_tx_buf_rel(struct idpf_queue *tx_q, struct idpf_tx_buf *tx_buf)
+static void idpf_tx_buf_rel(struct idpf_tx_queue *tx_q,
+			    struct idpf_tx_buf *tx_buf)
 {
 	if (tx_buf->skb) {
 		if (dma_unmap_len(tx_buf, len))
@@ -86,8 +90,9 @@ static void idpf_tx_buf_rel(struct idpf_queue *tx_q, struct idpf_tx_buf *tx_buf)
  * idpf_tx_buf_rel_all - Free any empty Tx buffers
  * @txq: queue to be cleaned
  */
-static void idpf_tx_buf_rel_all(struct idpf_queue *txq)
+static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
 {
+	struct idpf_buf_lifo *buf_stack;
 	u16 i;
 
 	/* Buffers already cleared, nothing to do */
@@ -101,38 +106,57 @@ static void idpf_tx_buf_rel_all(struct idpf_queue *txq)
 	kfree(txq->tx_buf);
 	txq->tx_buf = NULL;
 
-	if (!txq->buf_stack.bufs)
+	if (!idpf_queue_has(FLOW_SCH_EN, txq))
+		return;
+
+	buf_stack = &txq->stash->buf_stack;
+	if (!buf_stack->bufs)
 		return;
 
-	for (i = 0; i < txq->buf_stack.size; i++)
-		kfree(txq->buf_stack.bufs[i]);
+	for (i = 0; i < buf_stack->size; i++)
+		kfree(buf_stack->bufs[i]);
 
-	kfree(txq->buf_stack.bufs);
-	txq->buf_stack.bufs = NULL;
+	kfree(buf_stack->bufs);
+	buf_stack->bufs = NULL;
 }
 
 /**
  * idpf_tx_desc_rel - Free Tx resources per queue
  * @txq: Tx descriptor ring for a specific queue
- * @bufq: buffer q or completion q
  *
  * Free all transmit software resources
  */
-static void idpf_tx_desc_rel(struct idpf_queue *txq, bool bufq)
+static void idpf_tx_desc_rel(struct idpf_tx_queue *txq)
 {
-	if (bufq)
-		idpf_tx_buf_rel_all(txq);
+	idpf_tx_buf_rel_all(txq);
 
 	if (!txq->desc_ring)
 		return;
 
 	dmam_free_coherent(txq->dev, txq->size, txq->desc_ring, txq->dma);
 	txq->desc_ring = NULL;
-	txq->next_to_alloc = 0;
 	txq->next_to_use = 0;
 	txq->next_to_clean = 0;
 }
 
+/**
+ * idpf_compl_desc_rel - Free completion resources per queue
+ * @complq: completion queue
+ *
+ * Free all completion software resources.
+ */
+static void idpf_compl_desc_rel(struct idpf_compl_queue *complq)
+{
+	if (!complq->comp)
+		return;
+
+	dma_free_coherent(complq->netdev->dev.parent, complq->size,
+			  complq->comp, complq->dma);
+	complq->comp = NULL;
+	complq->next_to_use = 0;
+	complq->next_to_clean = 0;
+}
+
 /**
  * idpf_tx_desc_rel_all - Free Tx Resources for All Queues
  * @vport: virtual port structure
@@ -150,10 +174,10 @@ static void idpf_tx_desc_rel_all(struct idpf_vport *vport)
 		struct idpf_txq_group *txq_grp = &vport->txq_grps[i];
 
 		for (j = 0; j < txq_grp->num_txq; j++)
-			idpf_tx_desc_rel(txq_grp->txqs[j], true);
+			idpf_tx_desc_rel(txq_grp->txqs[j]);
 
 		if (idpf_is_queue_model_split(vport->txq_model))
-			idpf_tx_desc_rel(txq_grp->complq, false);
+			idpf_compl_desc_rel(txq_grp->complq);
 	}
 }
 
@@ -163,8 +187,9 @@ static void idpf_tx_desc_rel_all(struct idpf_vport *vport)
  *
  * Returns 0 on success, negative on failure
  */
-static int idpf_tx_buf_alloc_all(struct idpf_queue *tx_q)
+static int idpf_tx_buf_alloc_all(struct idpf_tx_queue *tx_q)
 {
+	struct idpf_buf_lifo *buf_stack;
 	int buf_size;
 	int i;
 
@@ -180,22 +205,26 @@ static int idpf_tx_buf_alloc_all(struct idpf_queue *tx_q)
 	for (i = 0; i < tx_q->desc_count; i++)
 		tx_q->tx_buf[i].compl_tag = IDPF_SPLITQ_TX_INVAL_COMPL_TAG;
 
+	if (!idpf_queue_has(FLOW_SCH_EN, tx_q))
+		return 0;
+
+	buf_stack = &tx_q->stash->buf_stack;
+
 	/* Initialize tx buf stack for out-of-order completions if
 	 * flow scheduling offload is enabled
 	 */
-	tx_q->buf_stack.bufs =
-		kcalloc(tx_q->desc_count, sizeof(struct idpf_tx_stash *),
-			GFP_KERNEL);
-	if (!tx_q->buf_stack.bufs)
+	buf_stack->bufs = kcalloc(tx_q->desc_count, sizeof(*buf_stack->bufs),
+				  GFP_KERNEL);
+	if (!buf_stack->bufs)
 		return -ENOMEM;
 
-	tx_q->buf_stack.size = tx_q->desc_count;
-	tx_q->buf_stack.top = tx_q->desc_count;
+	buf_stack->size = tx_q->desc_count;
+	buf_stack->top = tx_q->desc_count;
 
 	for (i = 0; i < tx_q->desc_count; i++) {
-		tx_q->buf_stack.bufs[i] = kzalloc(sizeof(*tx_q->buf_stack.bufs[i]),
-						  GFP_KERNEL);
-		if (!tx_q->buf_stack.bufs[i])
+		buf_stack->bufs[i] = kzalloc(sizeof(*buf_stack->bufs[i]),
+					     GFP_KERNEL);
+		if (!buf_stack->bufs[i])
 			return -ENOMEM;
 	}
 
@@ -204,28 +233,22 @@ static int idpf_tx_buf_alloc_all(struct idpf_queue *tx_q)
 
 /**
  * idpf_tx_desc_alloc - Allocate the Tx descriptors
+ * @vport: vport to allocate resources for
  * @tx_q: the tx ring to set up
- * @bufq: buffer or completion queue
  *
  * Returns 0 on success, negative on failure
  */
-static int idpf_tx_desc_alloc(struct idpf_queue *tx_q, bool bufq)
+static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
+			      struct idpf_tx_queue *tx_q)
 {
 	struct device *dev = tx_q->dev;
-	u32 desc_sz;
 	int err;
 
-	if (bufq) {
-		err = idpf_tx_buf_alloc_all(tx_q);
-		if (err)
-			goto err_alloc;
-
-		desc_sz = sizeof(struct idpf_base_tx_desc);
-	} else {
-		desc_sz = sizeof(struct idpf_splitq_tx_compl_desc);
-	}
+	err = idpf_tx_buf_alloc_all(tx_q);
+	if (err)
+		goto err_alloc;
 
-	tx_q->size = tx_q->desc_count * desc_sz;
+	tx_q->size = tx_q->desc_count * sizeof(*tx_q->base_tx);
 
 	/* Allocate descriptors also round up to nearest 4K */
 	tx_q->size = ALIGN(tx_q->size, 4096);
@@ -238,19 +261,43 @@ static int idpf_tx_desc_alloc(struct idpf_queue *tx_q, bool bufq)
 		goto err_alloc;
 	}
 
-	tx_q->next_to_alloc = 0;
 	tx_q->next_to_use = 0;
 	tx_q->next_to_clean = 0;
-	set_bit(__IDPF_Q_GEN_CHK, tx_q->flags);
+	idpf_queue_set(GEN_CHK, tx_q);
 
 	return 0;
 
 err_alloc:
-	idpf_tx_desc_rel(tx_q, bufq);
+	idpf_tx_desc_rel(tx_q);
 
 	return err;
 }
 
+/**
+ * idpf_compl_desc_alloc - allocate completion descriptors
+ * @vport: vport to allocate resources for
+ * @complq: completion queue to set up
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+static int idpf_compl_desc_alloc(const struct idpf_vport *vport,
+				 struct idpf_compl_queue *complq)
+{
+	complq->size = array_size(complq->desc_count, sizeof(*complq->comp));
+
+	complq->comp = dma_alloc_coherent(complq->netdev->dev.parent,
+					  complq->size, &complq->dma,
+					  GFP_KERNEL);
+	if (!complq->comp)
+		return -ENOMEM;
+
+	complq->next_to_use = 0;
+	complq->next_to_clean = 0;
+	idpf_queue_set(GEN_CHK, complq);
+
+	return 0;
+}
+
 /**
  * idpf_tx_desc_alloc_all - allocate all queues Tx resources
  * @vport: virtual port private structure
@@ -259,7 +306,6 @@ static int idpf_tx_desc_alloc(struct idpf_queue *tx_q, bool bufq)
  */
 static int idpf_tx_desc_alloc_all(struct idpf_vport *vport)
 {
-	struct device *dev = &vport->adapter->pdev->dev;
 	int err = 0;
 	int i, j;
 
@@ -268,13 +314,14 @@ static int idpf_tx_desc_alloc_all(struct idpf_vport *vport)
 	 */
 	for (i = 0; i < vport->num_txq_grp; i++) {
 		for (j = 0; j < vport->txq_grps[i].num_txq; j++) {
-			struct idpf_queue *txq = vport->txq_grps[i].txqs[j];
+			struct idpf_tx_queue *txq = vport->txq_grps[i].txqs[j];
 			u8 gen_bits = 0;
 			u16 bufidx_mask;
 
-			err = idpf_tx_desc_alloc(txq, true);
+			err = idpf_tx_desc_alloc(vport, txq);
 			if (err) {
-				dev_err(dev, "Allocation for Tx Queue %u failed\n",
+				pci_err(vport->adapter->pdev,
+					"Allocation for Tx Queue %u failed\n",
 					i);
 				goto err_out;
 			}
@@ -312,9 +359,10 @@ static int idpf_tx_desc_alloc_all(struct idpf_vport *vport)
 			continue;
 
 		/* Setup completion queues */
-		err = idpf_tx_desc_alloc(vport->txq_grps[i].complq, false);
+		err = idpf_compl_desc_alloc(vport, vport->txq_grps[i].complq);
 		if (err) {
-			dev_err(dev, "Allocation for Tx Completion Queue %u failed\n",
+			pci_err(vport->adapter->pdev,
+				"Allocation for Tx Completion Queue %u failed\n",
 				i);
 			goto err_out;
 		}
@@ -329,15 +377,14 @@ static int idpf_tx_desc_alloc_all(struct idpf_vport *vport)
 
 /**
  * idpf_rx_page_rel - Release an rx buffer page
- * @rxq: the queue that owns the buffer
  * @rx_buf: the buffer to free
  */
-static void idpf_rx_page_rel(struct idpf_queue *rxq, struct idpf_rx_buf *rx_buf)
+static void idpf_rx_page_rel(struct idpf_rx_buf *rx_buf)
 {
 	if (unlikely(!rx_buf->page))
 		return;
 
-	page_pool_put_full_page(rxq->pp, rx_buf->page, false);
+	page_pool_put_full_page(rx_buf->page->pp, rx_buf->page, false);
 
 	rx_buf->page = NULL;
 	rx_buf->page_offset = 0;
@@ -345,54 +392,72 @@ static void idpf_rx_page_rel(struct idpf_queue *rxq, struct idpf_rx_buf *rx_buf)
 
 /**
  * idpf_rx_hdr_buf_rel_all - Release header buffer memory
- * @rxq: queue to use
+ * @bufq: queue to use
+ * @dev: device to free DMA memory
  */
-static void idpf_rx_hdr_buf_rel_all(struct idpf_queue *rxq)
+static void idpf_rx_hdr_buf_rel_all(struct idpf_buf_queue *bufq,
+				    struct device *dev)
 {
-	struct idpf_adapter *adapter = rxq->vport->adapter;
-
-	dma_free_coherent(&adapter->pdev->dev,
-			  rxq->desc_count * IDPF_HDR_BUF_SIZE,
-			  rxq->rx_buf.hdr_buf_va,
-			  rxq->rx_buf.hdr_buf_pa);
-	rxq->rx_buf.hdr_buf_va = NULL;
+	dma_free_coherent(dev, bufq->desc_count * IDPF_HDR_BUF_SIZE,
+			  bufq->rx_buf.hdr_buf_va, bufq->rx_buf.hdr_buf_pa);
+	bufq->rx_buf.hdr_buf_va = NULL;
 }
 
 /**
- * idpf_rx_buf_rel_all - Free all Rx buffer resources for a queue
- * @rxq: queue to be cleaned
+ * idpf_rx_buf_rel_bufq - Free all Rx buffer resources for a buffer queue
+ * @bufq: queue to be cleaned
+ * @dev: device to free DMA memory
  */
-static void idpf_rx_buf_rel_all(struct idpf_queue *rxq)
+static void idpf_rx_buf_rel_bufq(struct idpf_buf_queue *bufq,
+				 struct device *dev)
 {
-	u16 i;
-
 	/* queue already cleared, nothing to do */
-	if (!rxq->rx_buf.buf)
+	if (!bufq->rx_buf.buf)
 		return;
 
 	/* Free all the bufs allocated and given to hw on Rx queue */
-	for (i = 0; i < rxq->desc_count; i++)
-		idpf_rx_page_rel(rxq, &rxq->rx_buf.buf[i]);
+	for (u32 i = 0; i < bufq->desc_count; i++)
+		idpf_rx_page_rel(&bufq->rx_buf.buf[i]);
+
+	if (idpf_queue_has(HSPLIT_EN, bufq))
+		idpf_rx_hdr_buf_rel_all(bufq, dev);
 
-	if (rxq->rx_hsplit_en)
-		idpf_rx_hdr_buf_rel_all(rxq);
+	page_pool_destroy(bufq->pp);
+	bufq->pp = NULL;
+
+	kfree(bufq->rx_buf.buf);
+	bufq->rx_buf.buf = NULL;
+}
+
+/**
+ * idpf_rx_buf_rel_all - Free all Rx buffer resources for a receive queue
+ * @rxq: queue to be cleaned
+ */
+static void idpf_rx_buf_rel_all(struct idpf_rx_queue *rxq)
+{
+	if (!rxq->rx_buf)
+		return;
+
+	for (u32 i = 0; i < rxq->desc_count; i++)
+		idpf_rx_page_rel(&rxq->rx_buf[i]);
 
 	page_pool_destroy(rxq->pp);
 	rxq->pp = NULL;
 
-	kfree(rxq->rx_buf.buf);
-	rxq->rx_buf.buf = NULL;
+	kfree(rxq->rx_buf);
+	rxq->rx_buf = NULL;
 }
 
 /**
  * idpf_rx_desc_rel - Free a specific Rx q resources
  * @rxq: queue to clean the resources from
- * @bufq: buffer q or completion q
- * @q_model: single or split q model
+ * @dev: device to free DMA memory
+ * @model: single or split queue model
  *
  * Free a specific rx queue resources
  */
-static void idpf_rx_desc_rel(struct idpf_queue *rxq, bool bufq, s32 q_model)
+static void idpf_rx_desc_rel(struct idpf_rx_queue *rxq, struct device *dev,
+			     u32 model)
 {
 	if (!rxq)
 		return;
@@ -402,7 +467,7 @@ static void idpf_rx_desc_rel(struct idpf_queue *rxq, bool bufq, s32 q_model)
 		rxq->skb = NULL;
 	}
 
-	if (bufq || !idpf_is_queue_model_split(q_model))
+	if (!idpf_is_queue_model_split(model))
 		idpf_rx_buf_rel_all(rxq);
 
 	rxq->next_to_alloc = 0;
@@ -411,10 +476,34 @@ static void idpf_rx_desc_rel(struct idpf_queue *rxq, bool bufq, s32 q_model)
 	if (!rxq->desc_ring)
 		return;
 
-	dmam_free_coherent(rxq->dev, rxq->size, rxq->desc_ring, rxq->dma);
+	dmam_free_coherent(dev, rxq->size, rxq->desc_ring, rxq->dma);
 	rxq->desc_ring = NULL;
 }
 
+/**
+ * idpf_rx_desc_rel_bufq - free buffer queue resources
+ * @bufq: buffer queue to clean the resources from
+ * @dev: device to free DMA memory
+ */
+static void idpf_rx_desc_rel_bufq(struct idpf_buf_queue *bufq,
+				  struct device *dev)
+{
+	if (!bufq)
+		return;
+
+	idpf_rx_buf_rel_bufq(bufq, dev);
+
+	bufq->next_to_alloc = 0;
+	bufq->next_to_clean = 0;
+	bufq->next_to_use = 0;
+
+	if (!bufq->split_buf)
+		return;
+
+	dma_free_coherent(dev, bufq->size, bufq->split_buf, bufq->dma);
+	bufq->split_buf = NULL;
+}
+
 /**
  * idpf_rx_desc_rel_all - Free Rx Resources for All Queues
  * @vport: virtual port structure
@@ -423,6 +512,7 @@ static void idpf_rx_desc_rel(struct idpf_queue *rxq, bool bufq, s32 q_model)
  */
 static void idpf_rx_desc_rel_all(struct idpf_vport *vport)
 {
+	struct device *dev = &vport->adapter->pdev->dev;
 	struct idpf_rxq_group *rx_qgrp;
 	u16 num_rxq;
 	int i, j;
@@ -435,15 +525,15 @@ static void idpf_rx_desc_rel_all(struct idpf_vport *vport)
 
 		if (!idpf_is_queue_model_split(vport->rxq_model)) {
 			for (j = 0; j < rx_qgrp->singleq.num_rxq; j++)
-				idpf_rx_desc_rel(rx_qgrp->singleq.rxqs[j],
-						 false, vport->rxq_model);
+				idpf_rx_desc_rel(rx_qgrp->singleq.rxqs[j], dev,
+						 VIRTCHNL2_QUEUE_MODEL_SINGLE);
 			continue;
 		}
 
 		num_rxq = rx_qgrp->splitq.num_rxq_sets;
 		for (j = 0; j < num_rxq; j++)
 			idpf_rx_desc_rel(&rx_qgrp->splitq.rxq_sets[j]->rxq,
-					 false, vport->rxq_model);
+					 dev, VIRTCHNL2_QUEUE_MODEL_SPLIT);
 
 		if (!rx_qgrp->splitq.bufq_sets)
 			continue;
@@ -452,44 +542,40 @@ static void idpf_rx_desc_rel_all(struct idpf_vport *vport)
 			struct idpf_bufq_set *bufq_set =
 				&rx_qgrp->splitq.bufq_sets[j];
 
-			idpf_rx_desc_rel(&bufq_set->bufq, true,
-					 vport->rxq_model);
+			idpf_rx_desc_rel_bufq(&bufq_set->bufq, dev);
 		}
 	}
 }
 
 /**
  * idpf_rx_buf_hw_update - Store the new tail and head values
- * @rxq: queue to bump
+ * @bufq: queue to bump
  * @val: new head index
  */
-void idpf_rx_buf_hw_update(struct idpf_queue *rxq, u32 val)
+static void idpf_rx_buf_hw_update(struct idpf_buf_queue *bufq, u32 val)
 {
-	rxq->next_to_use = val;
+	bufq->next_to_use = val;
 
-	if (unlikely(!rxq->tail))
+	if (unlikely(!bufq->tail))
 		return;
 
 	/* writel has an implicit memory barrier */
-	writel(val, rxq->tail);
+	writel(val, bufq->tail);
 }
 
 /**
  * idpf_rx_hdr_buf_alloc_all - Allocate memory for header buffers
- * @rxq: ring to use
+ * @bufq: ring to use
  *
  * Returns 0 on success, negative on failure.
  */
-static int idpf_rx_hdr_buf_alloc_all(struct idpf_queue *rxq)
+static int idpf_rx_hdr_buf_alloc_all(struct idpf_buf_queue *bufq)
 {
-	struct idpf_adapter *adapter = rxq->vport->adapter;
-
-	rxq->rx_buf.hdr_buf_va =
-		dma_alloc_coherent(&adapter->pdev->dev,
-				   IDPF_HDR_BUF_SIZE * rxq->desc_count,
-				   &rxq->rx_buf.hdr_buf_pa,
-				   GFP_KERNEL);
-	if (!rxq->rx_buf.hdr_buf_va)
+	bufq->rx_buf.hdr_buf_va =
+		dma_alloc_coherent(bufq->q_vector->vport->netdev->dev.parent,
+				   IDPF_HDR_BUF_SIZE * bufq->desc_count,
+				   &bufq->rx_buf.hdr_buf_pa, GFP_KERNEL);
+	if (!bufq->rx_buf.hdr_buf_va)
 		return -ENOMEM;
 
 	return 0;
@@ -502,19 +588,20 @@ static int idpf_rx_hdr_buf_alloc_all(struct idpf_queue *rxq)
  */
 static void idpf_rx_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
 {
-	u16 nta = refillq->next_to_alloc;
+	u32 nta = refillq->next_to_use;
 
 	/* store the buffer ID and the SW maintained GEN bit to the refillq */
 	refillq->ring[nta] =
 		FIELD_PREP(IDPF_RX_BI_BUFID_M, buf_id) |
 		FIELD_PREP(IDPF_RX_BI_GEN_M,
-			   test_bit(__IDPF_Q_GEN_CHK, refillq->flags));
+			   idpf_queue_has(GEN_CHK, refillq));
 
 	if (unlikely(++nta == refillq->desc_count)) {
 		nta = 0;
-		change_bit(__IDPF_Q_GEN_CHK, refillq->flags);
+		idpf_queue_change(GEN_CHK, refillq);
 	}
-	refillq->next_to_alloc = nta;
+
+	refillq->next_to_use = nta;
 }
 
 /**
@@ -524,21 +611,20 @@ static void idpf_rx_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
  *
  * Returns false if buffer could not be allocated, true otherwise.
  */
-static bool idpf_rx_post_buf_desc(struct idpf_queue *bufq, u16 buf_id)
+static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
 {
 	struct virtchnl2_splitq_rx_buf_desc *splitq_rx_desc = NULL;
 	u16 nta = bufq->next_to_alloc;
 	struct idpf_rx_buf *buf;
 	dma_addr_t addr;
 
-	splitq_rx_desc = IDPF_SPLITQ_RX_BUF_DESC(bufq, nta);
+	splitq_rx_desc = &bufq->split_buf[nta];
 	buf = &bufq->rx_buf.buf[buf_id];
 
-	if (bufq->rx_hsplit_en) {
+	if (idpf_queue_has(HSPLIT_EN, bufq))
 		splitq_rx_desc->hdr_addr =
 			cpu_to_le64(bufq->rx_buf.hdr_buf_pa +
 				    (u32)buf_id * IDPF_HDR_BUF_SIZE);
-	}
 
 	addr = idpf_alloc_page(bufq->pp, buf, bufq->rx_buf_size);
 	if (unlikely(addr == DMA_MAPPING_ERROR))
@@ -562,7 +648,8 @@ static bool idpf_rx_post_buf_desc(struct idpf_queue *bufq, u16 buf_id)
  *
  * Returns true if @working_set bufs were posted successfully, false otherwise.
  */
-static bool idpf_rx_post_init_bufs(struct idpf_queue *bufq, u16 working_set)
+static bool idpf_rx_post_init_bufs(struct idpf_buf_queue *bufq,
+				   u16 working_set)
 {
 	int i;
 
@@ -571,26 +658,28 @@ static bool idpf_rx_post_init_bufs(struct idpf_queue *bufq, u16 working_set)
 			return false;
 	}
 
-	idpf_rx_buf_hw_update(bufq,
-			      bufq->next_to_alloc & ~(bufq->rx_buf_stride - 1));
+	idpf_rx_buf_hw_update(bufq, ALIGN_DOWN(bufq->next_to_alloc,
+					       IDPF_RX_BUF_STRIDE));
 
 	return true;
 }
 
 /**
  * idpf_rx_create_page_pool - Create a page pool
- * @rxbufq: RX queue to create page pool for
+ * @napi: NAPI of the associated queue vector
+ * @count: queue descriptor count
  *
  * Returns &page_pool on success, casted -errno on failure
  */
-static struct page_pool *idpf_rx_create_page_pool(struct idpf_queue *rxbufq)
+static struct page_pool *idpf_rx_create_page_pool(struct napi_struct *napi,
+						  u32 count)
 {
 	struct page_pool_params pp = {
 		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.order		= 0,
-		.pool_size	= rxbufq->desc_count,
+		.pool_size	= count,
 		.nid		= NUMA_NO_NODE,
-		.dev		= rxbufq->vport->netdev->dev.parent,
+		.dev		= napi->dev->dev.parent,
 		.max_len	= PAGE_SIZE,
 		.dma_dir	= DMA_FROM_DEVICE,
 		.offset		= 0,
@@ -599,15 +688,58 @@ static struct page_pool *idpf_rx_create_page_pool(struct idpf_queue *rxbufq)
 	return page_pool_create(&pp);
 }
 
+/**
+ * idpf_rx_buf_alloc_singleq - Allocate memory for all buffer resources
+ * @rxq: queue for which the buffers are allocated
+ *
+ * Return: 0 on success, -ENOMEM on failure.
+ */
+static int idpf_rx_buf_alloc_singleq(struct idpf_rx_queue *rxq)
+{
+	rxq->rx_buf = kcalloc(rxq->desc_count, sizeof(*rxq->rx_buf),
+			      GFP_KERNEL);
+	if (!rxq->rx_buf)
+		return -ENOMEM;
+
+	if (idpf_rx_singleq_buf_hw_alloc_all(rxq, rxq->desc_count - 1))
+		goto err;
+
+	return 0;
+
+err:
+	idpf_rx_buf_rel_all(rxq);
+
+	return -ENOMEM;
+}
+
+/**
+ * idpf_rx_bufs_init_singleq - Initialize page pool and allocate Rx bufs
+ * @rxq: buffer queue to create page pool for
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+static int idpf_rx_bufs_init_singleq(struct idpf_rx_queue *rxq)
+{
+	struct page_pool *pool;
+
+	pool = idpf_rx_create_page_pool(&rxq->q_vector->napi, rxq->desc_count);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	rxq->pp = pool;
+
+	return idpf_rx_buf_alloc_singleq(rxq);
+}
+
 /**
  * idpf_rx_buf_alloc_all - Allocate memory for all buffer resources
- * @rxbufq: queue for which the buffers are allocated; equivalent to
- * rxq when operating in singleq mode
+ * @rxbufq: queue for which the buffers are allocated
  *
  * Returns 0 on success, negative on failure
  */
-static int idpf_rx_buf_alloc_all(struct idpf_queue *rxbufq)
+static int idpf_rx_buf_alloc_all(struct idpf_buf_queue *rxbufq)
 {
+	struct device *dev = rxbufq->q_vector->vport->netdev->dev.parent;
 	int err = 0;
 
 	/* Allocate book keeping buffers */
@@ -618,48 +750,41 @@ static int idpf_rx_buf_alloc_all(struct idpf_queue *rxbufq)
 		goto rx_buf_alloc_all_out;
 	}
 
-	if (rxbufq->rx_hsplit_en) {
+	if (idpf_queue_has(HSPLIT_EN, rxbufq)) {
 		err = idpf_rx_hdr_buf_alloc_all(rxbufq);
 		if (err)
 			goto rx_buf_alloc_all_out;
 	}
 
 	/* Allocate buffers to be given to HW.	 */
-	if (idpf_is_queue_model_split(rxbufq->vport->rxq_model)) {
-		int working_set = IDPF_RX_BUFQ_WORKING_SET(rxbufq);
-
-		if (!idpf_rx_post_init_bufs(rxbufq, working_set))
-			err = -ENOMEM;
-	} else {
-		if (idpf_rx_singleq_buf_hw_alloc_all(rxbufq,
-						     rxbufq->desc_count - 1))
-			err = -ENOMEM;
-	}
+	if (!idpf_rx_post_init_bufs(rxbufq, IDPF_RX_BUFQ_WORKING_SET(rxbufq)))
+		err = -ENOMEM;
 
 rx_buf_alloc_all_out:
 	if (err)
-		idpf_rx_buf_rel_all(rxbufq);
+		idpf_rx_buf_rel_bufq(rxbufq, dev);
 
 	return err;
 }
 
 /**
  * idpf_rx_bufs_init - Initialize page pool, allocate rx bufs, and post to HW
- * @rxbufq: RX queue to create page pool for
+ * @bufq: buffer queue to create page pool for
  *
  * Returns 0 on success, negative on failure
  */
-static int idpf_rx_bufs_init(struct idpf_queue *rxbufq)
+static int idpf_rx_bufs_init(struct idpf_buf_queue *bufq)
 {
 	struct page_pool *pool;
 
-	pool = idpf_rx_create_page_pool(rxbufq);
+	pool = idpf_rx_create_page_pool(&bufq->q_vector->napi,
+					bufq->desc_count);
 	if (IS_ERR(pool))
 		return PTR_ERR(pool);
 
-	rxbufq->pp = pool;
+	bufq->pp = pool;
 
-	return idpf_rx_buf_alloc_all(rxbufq);
+	return idpf_rx_buf_alloc_all(bufq);
 }
 
 /**
@@ -671,7 +796,6 @@ static int idpf_rx_bufs_init(struct idpf_queue *rxbufq)
 int idpf_rx_bufs_init_all(struct idpf_vport *vport)
 {
 	struct idpf_rxq_group *rx_qgrp;
-	struct idpf_queue *q;
 	int i, j, err;
 
 	for (i = 0; i < vport->num_rxq_grp; i++) {
@@ -682,8 +806,10 @@ int idpf_rx_bufs_init_all(struct idpf_vport *vport)
 			int num_rxq = rx_qgrp->singleq.num_rxq;
 
 			for (j = 0; j < num_rxq; j++) {
+				struct idpf_rx_queue *q;
+
 				q = rx_qgrp->singleq.rxqs[j];
-				err = idpf_rx_bufs_init(q);
+				err = idpf_rx_bufs_init_singleq(q);
 				if (err)
 					return err;
 			}
@@ -693,6 +819,8 @@ int idpf_rx_bufs_init_all(struct idpf_vport *vport)
 
 		/* Otherwise, allocate bufs for the buffer queues */
 		for (j = 0; j < vport->num_bufqs_per_qgrp; j++) {
+			struct idpf_buf_queue *q;
+
 			q = &rx_qgrp->splitq.bufq_sets[j].bufq;
 			err = idpf_rx_bufs_init(q);
 			if (err)
@@ -705,22 +833,17 @@ int idpf_rx_bufs_init_all(struct idpf_vport *vport)
 
 /**
  * idpf_rx_desc_alloc - Allocate queue Rx resources
+ * @vport: vport to allocate resources for
  * @rxq: Rx queue for which the resources are setup
- * @bufq: buffer or completion queue
- * @q_model: single or split queue model
  *
  * Returns 0 on success, negative on failure
  */
-static int idpf_rx_desc_alloc(struct idpf_queue *rxq, bool bufq, s32 q_model)
+static int idpf_rx_desc_alloc(const struct idpf_vport *vport,
+			      struct idpf_rx_queue *rxq)
 {
-	struct device *dev = rxq->dev;
+	struct device *dev = &vport->adapter->pdev->dev;
 
-	if (bufq)
-		rxq->size = rxq->desc_count *
-			sizeof(struct virtchnl2_splitq_rx_buf_desc);
-	else
-		rxq->size = rxq->desc_count *
-			sizeof(union virtchnl2_rx_desc);
+	rxq->size = rxq->desc_count * sizeof(union virtchnl2_rx_desc);
 
 	/* Allocate descriptors and also round up to nearest 4K */
 	rxq->size = ALIGN(rxq->size, 4096);
@@ -735,7 +858,35 @@ static int idpf_rx_desc_alloc(struct idpf_queue *rxq, bool bufq, s32 q_model)
 	rxq->next_to_alloc = 0;
 	rxq->next_to_clean = 0;
 	rxq->next_to_use = 0;
-	set_bit(__IDPF_Q_GEN_CHK, rxq->flags);
+	idpf_queue_set(GEN_CHK, rxq);
+
+	return 0;
+}
+
+/**
+ * idpf_bufq_desc_alloc - Allocate buffer queue descriptor ring
+ * @vport: vport to allocate resources for
+ * @bufq: buffer queue for which the resources are set up
+ *
+ * Return: 0 on success, -ENOMEM on failure.
+ */
+static int idpf_bufq_desc_alloc(const struct idpf_vport *vport,
+				struct idpf_buf_queue *bufq)
+{
+	struct device *dev = &vport->adapter->pdev->dev;
+
+	bufq->size = array_size(bufq->desc_count, sizeof(*bufq->split_buf));
+
+	bufq->split_buf = dma_alloc_coherent(dev, bufq->size, &bufq->dma,
+					     GFP_KERNEL);
+	if (!bufq->split_buf)
+		return -ENOMEM;
+
+	bufq->next_to_alloc = 0;
+	bufq->next_to_clean = 0;
+	bufq->next_to_use = 0;
+
+	idpf_queue_set(GEN_CHK, bufq);
 
 	return 0;
 }
@@ -748,9 +899,7 @@ static int idpf_rx_desc_alloc(struct idpf_queue *rxq, bool bufq, s32 q_model)
  */
 static int idpf_rx_desc_alloc_all(struct idpf_vport *vport)
 {
-	struct device *dev = &vport->adapter->pdev->dev;
 	struct idpf_rxq_group *rx_qgrp;
-	struct idpf_queue *q;
 	int i, j, err;
 	u16 num_rxq;
 
@@ -762,13 +911,17 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport)
 			num_rxq = rx_qgrp->singleq.num_rxq;
 
 		for (j = 0; j < num_rxq; j++) {
+			struct idpf_rx_queue *q;
+
 			if (idpf_is_queue_model_split(vport->rxq_model))
 				q = &rx_qgrp->splitq.rxq_sets[j]->rxq;
 			else
 				q = rx_qgrp->singleq.rxqs[j];
-			err = idpf_rx_desc_alloc(q, false, vport->rxq_model);
+
+			err = idpf_rx_desc_alloc(vport, q);
 			if (err) {
-				dev_err(dev, "Memory allocation for Rx Queue %u failed\n",
+				pci_err(vport->adapter->pdev,
+					"Memory allocation for Rx Queue %u failed\n",
 					i);
 				goto err_out;
 			}
@@ -778,10 +931,14 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport)
 			continue;
 
 		for (j = 0; j < vport->num_bufqs_per_qgrp; j++) {
+			struct idpf_buf_queue *q;
+
 			q = &rx_qgrp->splitq.bufq_sets[j].bufq;
-			err = idpf_rx_desc_alloc(q, true, vport->rxq_model);
+
+			err = idpf_bufq_desc_alloc(vport, q);
 			if (err) {
-				dev_err(dev, "Memory allocation for Rx Buffer Queue %u failed\n",
+				pci_err(vport->adapter->pdev,
+					"Memory allocation for Rx Buffer Queue %u failed\n",
 					i);
 				goto err_out;
 			}
@@ -802,11 +959,16 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport)
  */
 static void idpf_txq_group_rel(struct idpf_vport *vport)
 {
+	bool split, flow_sch_en;
 	int i, j;
 
 	if (!vport->txq_grps)
 		return;
 
+	split = idpf_is_queue_model_split(vport->txq_model);
+	flow_sch_en = !idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
+				       VIRTCHNL2_CAP_SPLITQ_QSCHED);
+
 	for (i = 0; i < vport->num_txq_grp; i++) {
 		struct idpf_txq_group *txq_grp = &vport->txq_grps[i];
 
@@ -814,8 +976,15 @@ static void idpf_txq_group_rel(struct idpf_vport *vport)
 			kfree(txq_grp->txqs[j]);
 			txq_grp->txqs[j] = NULL;
 		}
+
+		if (!split)
+			continue;
+
 		kfree(txq_grp->complq);
 		txq_grp->complq = NULL;
+
+		if (flow_sch_en)
+			kfree(txq_grp->stashes);
 	}
 	kfree(vport->txq_grps);
 	vport->txq_grps = NULL;
@@ -919,7 +1088,7 @@ static int idpf_vport_init_fast_path_txqs(struct idpf_vport *vport)
 {
 	int i, j, k = 0;
 
-	vport->txqs = kcalloc(vport->num_txq, sizeof(struct idpf_queue *),
+	vport->txqs = kcalloc(vport->num_txq, sizeof(*vport->txqs),
 			      GFP_KERNEL);
 
 	if (!vport->txqs)
@@ -1137,7 +1306,8 @@ static void idpf_vport_calc_numq_per_grp(struct idpf_vport *vport,
  * @q: rx queue for which descids are set
  *
  */
-static void idpf_rxq_set_descids(struct idpf_vport *vport, struct idpf_queue *q)
+static void idpf_rxq_set_descids(const struct idpf_vport *vport,
+				 struct idpf_rx_queue *q)
 {
 	if (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
 		q->rxdids = VIRTCHNL2_RXDID_2_FLEX_SPLITQ_M;
@@ -1158,20 +1328,22 @@ static void idpf_rxq_set_descids(struct idpf_vport *vport, struct idpf_queue *q)
  */
 static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
 {
-	bool flow_sch_en;
-	int err, i;
+	bool split, flow_sch_en;
+	int i;
 
 	vport->txq_grps = kcalloc(vport->num_txq_grp,
 				  sizeof(*vport->txq_grps), GFP_KERNEL);
 	if (!vport->txq_grps)
 		return -ENOMEM;
 
+	split = idpf_is_queue_model_split(vport->txq_model);
 	flow_sch_en = !idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
 				       VIRTCHNL2_CAP_SPLITQ_QSCHED);
 
 	for (i = 0; i < vport->num_txq_grp; i++) {
 		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
 		struct idpf_adapter *adapter = vport->adapter;
+		struct idpf_txq_stash *stashes;
 		int j;
 
 		tx_qgrp->vport = vport;
@@ -1180,45 +1352,62 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
 		for (j = 0; j < tx_qgrp->num_txq; j++) {
 			tx_qgrp->txqs[j] = kzalloc(sizeof(*tx_qgrp->txqs[j]),
 						   GFP_KERNEL);
-			if (!tx_qgrp->txqs[j]) {
-				err = -ENOMEM;
+			if (!tx_qgrp->txqs[j])
 				goto err_alloc;
-			}
+		}
+
+		if (split && flow_sch_en) {
+			stashes = kcalloc(num_txq, sizeof(*stashes),
+					  GFP_KERNEL);
+			if (!stashes)
+				goto err_alloc;
+
+			tx_qgrp->stashes = stashes;
 		}
 
 		for (j = 0; j < tx_qgrp->num_txq; j++) {
-			struct idpf_queue *q = tx_qgrp->txqs[j];
+			struct idpf_tx_queue *q = tx_qgrp->txqs[j];
 
 			q->dev = &adapter->pdev->dev;
 			q->desc_count = vport->txq_desc_count;
 			q->tx_max_bufs = idpf_get_max_tx_bufs(adapter);
 			q->tx_min_pkt_len = idpf_get_min_tx_pkt_len(adapter);
-			q->vport = vport;
+			q->netdev = vport->netdev;
 			q->txq_grp = tx_qgrp;
-			hash_init(q->sched_buf_hash);
 
-			if (flow_sch_en)
-				set_bit(__IDPF_Q_FLOW_SCH_EN, q->flags);
+			if (!split) {
+				q->clean_budget = vport->compln_clean_budget;
+				idpf_queue_assign(CRC_EN, q,
+						  vport->crc_enable);
+			}
+
+			if (!flow_sch_en)
+				continue;
+
+			if (split) {
+				q->stash = &stashes[j];
+				hash_init(q->stash->sched_buf_hash);
+			}
+
+			idpf_queue_set(FLOW_SCH_EN, q);
 		}
 
-		if (!idpf_is_queue_model_split(vport->txq_model))
+		if (!split)
 			continue;
 
 		tx_qgrp->complq = kcalloc(IDPF_COMPLQ_PER_GROUP,
 					  sizeof(*tx_qgrp->complq),
 					  GFP_KERNEL);
-		if (!tx_qgrp->complq) {
-			err = -ENOMEM;
+		if (!tx_qgrp->complq)
 			goto err_alloc;
-		}
 
-		tx_qgrp->complq->dev = &adapter->pdev->dev;
 		tx_qgrp->complq->desc_count = vport->complq_desc_count;
-		tx_qgrp->complq->vport = vport;
 		tx_qgrp->complq->txq_grp = tx_qgrp;
+		tx_qgrp->complq->netdev = vport->netdev;
+		tx_qgrp->complq->clean_budget = vport->compln_clean_budget;
 
 		if (flow_sch_en)
-			__set_bit(__IDPF_Q_FLOW_SCH_EN, tx_qgrp->complq->flags);
+			idpf_queue_set(FLOW_SCH_EN, tx_qgrp->complq);
 	}
 
 	return 0;
@@ -1226,7 +1415,7 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
 err_alloc:
 	idpf_txq_group_rel(vport);
 
-	return err;
+	return -ENOMEM;
 }
 
 /**
@@ -1238,8 +1427,6 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
  */
 static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 {
-	struct idpf_adapter *adapter = vport->adapter;
-	struct idpf_queue *q;
 	int i, k, err = 0;
 	bool hs;
 
@@ -1292,21 +1479,15 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 			struct idpf_bufq_set *bufq_set =
 				&rx_qgrp->splitq.bufq_sets[j];
 			int swq_size = sizeof(struct idpf_sw_queue);
+			struct idpf_buf_queue *q;
 
 			q = &rx_qgrp->splitq.bufq_sets[j].bufq;
-			q->dev = &adapter->pdev->dev;
 			q->desc_count = vport->bufq_desc_count[j];
-			q->vport = vport;
-			q->rxq_grp = rx_qgrp;
-			q->idx = j;
 			q->rx_buf_size = vport->bufq_size[j];
 			q->rx_buffer_low_watermark = IDPF_LOW_WATERMARK;
-			q->rx_buf_stride = IDPF_RX_BUF_STRIDE;
 
-			if (hs) {
-				q->rx_hsplit_en = true;
-				q->rx_hbuf_size = IDPF_HDR_BUF_SIZE;
-			}
+			idpf_queue_assign(HSPLIT_EN, q, hs);
+			q->rx_hbuf_size = hs ? IDPF_HDR_BUF_SIZE : 0;
 
 			bufq_set->num_refillqs = num_rxq;
 			bufq_set->refillqs = kcalloc(num_rxq, swq_size,
@@ -1319,13 +1500,12 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 				struct idpf_sw_queue *refillq =
 					&bufq_set->refillqs[k];
 
-				refillq->dev = &vport->adapter->pdev->dev;
 				refillq->desc_count =
 					vport->bufq_desc_count[j];
-				set_bit(__IDPF_Q_GEN_CHK, refillq->flags);
-				set_bit(__IDPF_RFLQ_GEN_CHK, refillq->flags);
+				idpf_queue_set(GEN_CHK, refillq);
+				idpf_queue_set(RFL_GEN_CHK, refillq);
 				refillq->ring = kcalloc(refillq->desc_count,
-							sizeof(u16),
+							sizeof(*refillq->ring),
 							GFP_KERNEL);
 				if (!refillq->ring) {
 					err = -ENOMEM;
@@ -1336,27 +1516,27 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 
 skip_splitq_rx_init:
 		for (j = 0; j < num_rxq; j++) {
+			struct idpf_rx_queue *q;
+
 			if (!idpf_is_queue_model_split(vport->rxq_model)) {
 				q = rx_qgrp->singleq.rxqs[j];
 				goto setup_rxq;
 			}
 			q = &rx_qgrp->splitq.rxq_sets[j]->rxq;
-			rx_qgrp->splitq.rxq_sets[j]->refillq0 =
+			rx_qgrp->splitq.rxq_sets[j]->refillq[0] =
 			      &rx_qgrp->splitq.bufq_sets[0].refillqs[j];
 			if (vport->num_bufqs_per_qgrp > IDPF_SINGLE_BUFQ_PER_RXQ_GRP)
-				rx_qgrp->splitq.rxq_sets[j]->refillq1 =
+				rx_qgrp->splitq.rxq_sets[j]->refillq[1] =
 				      &rx_qgrp->splitq.bufq_sets[1].refillqs[j];
 
-			if (hs) {
-				q->rx_hsplit_en = true;
-				q->rx_hbuf_size = IDPF_HDR_BUF_SIZE;
-			}
+			idpf_queue_assign(HSPLIT_EN, q, hs);
+			q->rx_hbuf_size = hs ? IDPF_HDR_BUF_SIZE : 0;
 
 setup_rxq:
-			q->dev = &adapter->pdev->dev;
 			q->desc_count = vport->rxq_desc_count;
-			q->vport = vport;
-			q->rxq_grp = rx_qgrp;
+			q->rx_ptype_lkup = vport->rx_ptype_lkup;
+			q->netdev = vport->netdev;
+			q->bufq_sets = rx_qgrp->splitq.bufq_sets;
 			q->idx = (i * num_rxq) + j;
 			/* In splitq mode, RXQ buffer size should be
 			 * set to that of the first buffer queue
@@ -1445,12 +1625,13 @@ int idpf_vport_queues_alloc(struct idpf_vport *vport)
  * idpf_tx_handle_sw_marker - Handle queue marker packet
  * @tx_q: tx queue to handle software marker
  */
-static void idpf_tx_handle_sw_marker(struct idpf_queue *tx_q)
+static void idpf_tx_handle_sw_marker(struct idpf_tx_queue *tx_q)
 {
-	struct idpf_vport *vport = tx_q->vport;
+	struct idpf_netdev_priv *priv = netdev_priv(tx_q->netdev);
+	struct idpf_vport *vport = priv->vport;
 	int i;
 
-	clear_bit(__IDPF_Q_SW_MARKER, tx_q->flags);
+	idpf_queue_clear(SW_MARKER, tx_q);
 	/* Hardware must write marker packets to all queues associated with
 	 * completion queues. So check if all queues received marker packets
 	 */
@@ -1458,7 +1639,7 @@ static void idpf_tx_handle_sw_marker(struct idpf_queue *tx_q)
 		/* If we're still waiting on any other TXQ marker completions,
 		 * just return now since we cannot wake up the marker_wq yet.
 		 */
-		if (test_bit(__IDPF_Q_SW_MARKER, vport->txqs[i]->flags))
+		if (idpf_queue_has(SW_MARKER, vport->txqs[i]))
 			return;
 
 	/* Drain complete */
@@ -1474,7 +1655,7 @@ static void idpf_tx_handle_sw_marker(struct idpf_queue *tx_q)
  * @cleaned: pointer to stats struct to track cleaned packets/bytes
  * @napi_budget: Used to determine if we are in netpoll
  */
-static void idpf_tx_splitq_clean_hdr(struct idpf_queue *tx_q,
+static void idpf_tx_splitq_clean_hdr(struct idpf_tx_queue *tx_q,
 				     struct idpf_tx_buf *tx_buf,
 				     struct idpf_cleaned_stats *cleaned,
 				     int napi_budget)
@@ -1505,7 +1686,8 @@ static void idpf_tx_splitq_clean_hdr(struct idpf_queue *tx_q,
  * @cleaned: pointer to stats struct to track cleaned packets/bytes
  * @budget: Used to determine if we are in netpoll
  */
-static void idpf_tx_clean_stashed_bufs(struct idpf_queue *txq, u16 compl_tag,
+static void idpf_tx_clean_stashed_bufs(struct idpf_tx_queue *txq,
+				       u16 compl_tag,
 				       struct idpf_cleaned_stats *cleaned,
 				       int budget)
 {
@@ -1513,7 +1695,7 @@ static void idpf_tx_clean_stashed_bufs(struct idpf_queue *txq, u16 compl_tag,
 	struct hlist_node *tmp_buf;
 
 	/* Buffer completion */
-	hash_for_each_possible_safe(txq->sched_buf_hash, stash, tmp_buf,
+	hash_for_each_possible_safe(txq->stash->sched_buf_hash, stash, tmp_buf,
 				    hlist, compl_tag) {
 		if (unlikely(stash->buf.compl_tag != (int)compl_tag))
 			continue;
@@ -1530,7 +1712,7 @@ static void idpf_tx_clean_stashed_bufs(struct idpf_queue *txq, u16 compl_tag,
 		}
 
 		/* Push shadow buf back onto stack */
-		idpf_buf_lifo_push(&txq->buf_stack, stash);
+		idpf_buf_lifo_push(&txq->stash->buf_stack, stash);
 
 		hash_del(&stash->hlist);
 	}
@@ -1542,7 +1724,7 @@ static void idpf_tx_clean_stashed_bufs(struct idpf_queue *txq, u16 compl_tag,
  * @txq: Tx queue to clean
  * @tx_buf: buffer to store
  */
-static int idpf_stash_flow_sch_buffers(struct idpf_queue *txq,
+static int idpf_stash_flow_sch_buffers(struct idpf_tx_queue *txq,
 				       struct idpf_tx_buf *tx_buf)
 {
 	struct idpf_tx_stash *stash;
@@ -1551,10 +1733,10 @@ static int idpf_stash_flow_sch_buffers(struct idpf_queue *txq,
 		     !dma_unmap_len(tx_buf, len)))
 		return 0;
 
-	stash = idpf_buf_lifo_pop(&txq->buf_stack);
+	stash = idpf_buf_lifo_pop(&txq->stash->buf_stack);
 	if (unlikely(!stash)) {
 		net_err_ratelimited("%s: No out-of-order TX buffers left!\n",
-				    txq->vport->netdev->name);
+				    netdev_name(txq->netdev));
 
 		return -ENOMEM;
 	}
@@ -1568,7 +1750,8 @@ static int idpf_stash_flow_sch_buffers(struct idpf_queue *txq,
 	stash->buf.compl_tag = tx_buf->compl_tag;
 
 	/* Add buffer to buf_hash table to be freed later */
-	hash_add(txq->sched_buf_hash, &stash->hlist, stash->buf.compl_tag);
+	hash_add(txq->stash->sched_buf_hash, &stash->hlist,
+		 stash->buf.compl_tag);
 
 	memset(tx_buf, 0, sizeof(struct idpf_tx_buf));
 
@@ -1584,7 +1767,7 @@ do {								\
 	if (unlikely(!(ntc))) {					\
 		ntc -= (txq)->desc_count;			\
 		buf = (txq)->tx_buf;				\
-		desc = IDPF_FLEX_TX_DESC(txq, 0);		\
+		desc = &(txq)->flex_tx[0];			\
 	} else {						\
 		(buf)++;					\
 		(desc)++;					\
@@ -1607,7 +1790,7 @@ do {								\
  * and the buffers will be cleaned separately. The stats are not updated from
  * this function when using flow-based scheduling.
  */
-static void idpf_tx_splitq_clean(struct idpf_queue *tx_q, u16 end,
+static void idpf_tx_splitq_clean(struct idpf_tx_queue *tx_q, u16 end,
 				 int napi_budget,
 				 struct idpf_cleaned_stats *cleaned,
 				 bool descs_only)
@@ -1617,8 +1800,8 @@ static void idpf_tx_splitq_clean(struct idpf_queue *tx_q, u16 end,
 	s16 ntc = tx_q->next_to_clean;
 	struct idpf_tx_buf *tx_buf;
 
-	tx_desc = IDPF_FLEX_TX_DESC(tx_q, ntc);
-	next_pending_desc = IDPF_FLEX_TX_DESC(tx_q, end);
+	tx_desc = &tx_q->flex_tx[ntc];
+	next_pending_desc = &tx_q->flex_tx[end];
 	tx_buf = &tx_q->tx_buf[ntc];
 	ntc -= tx_q->desc_count;
 
@@ -1703,7 +1886,7 @@ do {							\
  * stashed. Returns the byte/segment count for the cleaned packet associated
  * this completion tag.
  */
-static bool idpf_tx_clean_buf_ring(struct idpf_queue *txq, u16 compl_tag,
+static bool idpf_tx_clean_buf_ring(struct idpf_tx_queue *txq, u16 compl_tag,
 				   struct idpf_cleaned_stats *cleaned,
 				   int budget)
 {
@@ -1772,14 +1955,14 @@ static bool idpf_tx_clean_buf_ring(struct idpf_queue *txq, u16 compl_tag,
  *
  * Returns bytes/packets cleaned
  */
-static void idpf_tx_handle_rs_completion(struct idpf_queue *txq,
+static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
 					 struct idpf_splitq_tx_compl_desc *desc,
 					 struct idpf_cleaned_stats *cleaned,
 					 int budget)
 {
 	u16 compl_tag;
 
-	if (!test_bit(__IDPF_Q_FLOW_SCH_EN, txq->flags)) {
+	if (!idpf_queue_has(FLOW_SCH_EN, txq)) {
 		u16 head = le16_to_cpu(desc->q_head_compl_tag.q_head);
 
 		return idpf_tx_splitq_clean(txq, head, budget, cleaned, false);
@@ -1802,24 +1985,23 @@ static void idpf_tx_handle_rs_completion(struct idpf_queue *txq,
  *
  * Returns true if there's any budget left (e.g. the clean is finished)
  */
-static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
+static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 				 int *cleaned)
 {
 	struct idpf_splitq_tx_compl_desc *tx_desc;
-	struct idpf_vport *vport = complq->vport;
 	s16 ntc = complq->next_to_clean;
 	struct idpf_netdev_priv *np;
 	unsigned int complq_budget;
 	bool complq_ok = true;
 	int i;
 
-	complq_budget = vport->compln_clean_budget;
-	tx_desc = IDPF_SPLITQ_TX_COMPLQ_DESC(complq, ntc);
+	complq_budget = complq->clean_budget;
+	tx_desc = &complq->comp[ntc];
 	ntc -= complq->desc_count;
 
 	do {
 		struct idpf_cleaned_stats cleaned_stats = { };
-		struct idpf_queue *tx_q;
+		struct idpf_tx_queue *tx_q;
 		int rel_tx_qid;
 		u16 hw_head;
 		u8 ctype;	/* completion type */
@@ -1828,7 +2010,7 @@ static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
 		/* if the descriptor isn't done, no work yet to do */
 		gen = le16_get_bits(tx_desc->qid_comptype_gen,
 				    IDPF_TXD_COMPLQ_GEN_M);
-		if (test_bit(__IDPF_Q_GEN_CHK, complq->flags) != gen)
+		if (idpf_queue_has(GEN_CHK, complq) != gen)
 			break;
 
 		/* Find necessary info of TX queue to clean buffers */
@@ -1836,8 +2018,7 @@ static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
 					   IDPF_TXD_COMPLQ_QID_M);
 		if (rel_tx_qid >= complq->txq_grp->num_txq ||
 		    !complq->txq_grp->txqs[rel_tx_qid]) {
-			dev_err(&complq->vport->adapter->pdev->dev,
-				"TxQ not found\n");
+			netdev_err(complq->netdev, "TxQ not found\n");
 			goto fetch_next_desc;
 		}
 		tx_q = complq->txq_grp->txqs[rel_tx_qid];
@@ -1860,15 +2041,14 @@ static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
 			idpf_tx_handle_sw_marker(tx_q);
 			break;
 		default:
-			dev_err(&tx_q->vport->adapter->pdev->dev,
-				"Unknown TX completion type: %d\n",
-				ctype);
+			netdev_err(tx_q->netdev,
+				   "Unknown TX completion type: %d\n", ctype);
 			goto fetch_next_desc;
 		}
 
 		u64_stats_update_begin(&tx_q->stats_sync);
-		u64_stats_add(&tx_q->q_stats.tx.packets, cleaned_stats.packets);
-		u64_stats_add(&tx_q->q_stats.tx.bytes, cleaned_stats.bytes);
+		u64_stats_add(&tx_q->q_stats.packets, cleaned_stats.packets);
+		u64_stats_add(&tx_q->q_stats.bytes, cleaned_stats.bytes);
 		tx_q->cleaned_pkts += cleaned_stats.packets;
 		tx_q->cleaned_bytes += cleaned_stats.bytes;
 		complq->num_completions++;
@@ -1879,8 +2059,8 @@ static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
 		ntc++;
 		if (unlikely(!ntc)) {
 			ntc -= complq->desc_count;
-			tx_desc = IDPF_SPLITQ_TX_COMPLQ_DESC(complq, 0);
-			change_bit(__IDPF_Q_GEN_CHK, complq->flags);
+			tx_desc = &complq->comp[0];
+			idpf_queue_change(GEN_CHK, complq);
 		}
 
 		prefetch(tx_desc);
@@ -1896,9 +2076,9 @@ static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
 		     IDPF_TX_COMPLQ_OVERFLOW_THRESH(complq)))
 		complq_ok = false;
 
-	np = netdev_priv(complq->vport->netdev);
+	np = netdev_priv(complq->netdev);
 	for (i = 0; i < complq->txq_grp->num_txq; ++i) {
-		struct idpf_queue *tx_q = complq->txq_grp->txqs[i];
+		struct idpf_tx_queue *tx_q = complq->txq_grp->txqs[i];
 		struct netdev_queue *nq;
 		bool dont_wake;
 
@@ -1909,11 +2089,11 @@ static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
 		*cleaned += tx_q->cleaned_pkts;
 
 		/* Update BQL */
-		nq = netdev_get_tx_queue(tx_q->vport->netdev, tx_q->idx);
+		nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 
 		dont_wake = !complq_ok || IDPF_TX_BUF_RSV_LOW(tx_q) ||
 			    np->state != __IDPF_VPORT_UP ||
-			    !netif_carrier_ok(tx_q->vport->netdev);
+			    !netif_carrier_ok(tx_q->netdev);
 		/* Check if the TXQ needs to and can be restarted */
 		__netif_txq_completed_wake(nq, tx_q->cleaned_pkts, tx_q->cleaned_bytes,
 					   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
@@ -1969,29 +2149,6 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
 
-/**
- * idpf_tx_maybe_stop_common - 1st level check for common Tx stop conditions
- * @tx_q: the queue to be checked
- * @size: number of descriptors we want to assure is available
- *
- * Returns 0 if stop is not needed
- */
-int idpf_tx_maybe_stop_common(struct idpf_queue *tx_q, unsigned int size)
-{
-	struct netdev_queue *nq;
-
-	if (likely(IDPF_DESC_UNUSED(tx_q) >= size))
-		return 0;
-
-	u64_stats_update_begin(&tx_q->stats_sync);
-	u64_stats_inc(&tx_q->q_stats.tx.q_busy);
-	u64_stats_update_end(&tx_q->stats_sync);
-
-	nq = netdev_get_tx_queue(tx_q->vport->netdev, tx_q->idx);
-
-	return netif_txq_maybe_stop(nq, IDPF_DESC_UNUSED(tx_q), size, size);
-}
-
 /**
  * idpf_tx_maybe_stop_splitq - 1st level check for Tx splitq stop conditions
  * @tx_q: the queue to be checked
@@ -1999,11 +2156,11 @@ int idpf_tx_maybe_stop_common(struct idpf_queue *tx_q, unsigned int size)
  *
  * Returns 0 if stop is not needed
  */
-static int idpf_tx_maybe_stop_splitq(struct idpf_queue *tx_q,
+static int idpf_tx_maybe_stop_splitq(struct idpf_tx_queue *tx_q,
 				     unsigned int descs_needed)
 {
 	if (idpf_tx_maybe_stop_common(tx_q, descs_needed))
-		goto splitq_stop;
+		goto out;
 
 	/* If there are too many outstanding completions expected on the
 	 * completion queue, stop the TX queue to give the device some time to
@@ -2022,10 +2179,12 @@ static int idpf_tx_maybe_stop_splitq(struct idpf_queue *tx_q,
 	return 0;
 
 splitq_stop:
+	netif_stop_subqueue(tx_q->netdev, tx_q->idx);
+
+out:
 	u64_stats_update_begin(&tx_q->stats_sync);
-	u64_stats_inc(&tx_q->q_stats.tx.q_busy);
+	u64_stats_inc(&tx_q->q_stats.q_busy);
 	u64_stats_update_end(&tx_q->stats_sync);
-	netif_stop_subqueue(tx_q->vport->netdev, tx_q->idx);
 
 	return -EBUSY;
 }
@@ -2040,15 +2199,19 @@ static int idpf_tx_maybe_stop_splitq(struct idpf_queue *tx_q,
  * to do a register write to update our queue status. We know this can only
  * mean tail here as HW should be owning head for TX.
  */
-void idpf_tx_buf_hw_update(struct idpf_queue *tx_q, u32 val,
+void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
 			   bool xmit_more)
 {
 	struct netdev_queue *nq;
 
-	nq = netdev_get_tx_queue(tx_q->vport->netdev, tx_q->idx);
+	nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 	tx_q->next_to_use = val;
 
-	idpf_tx_maybe_stop_common(tx_q, IDPF_TX_DESC_NEEDED);
+	if (idpf_tx_maybe_stop_common(tx_q, IDPF_TX_DESC_NEEDED)) {
+		u64_stats_update_begin(&tx_q->stats_sync);
+		u64_stats_inc(&tx_q->q_stats.q_busy);
+		u64_stats_update_end(&tx_q->stats_sync);
+	}
 
 	/* Force memory writes to complete before letting h/w
 	 * know there are new descriptors to fetch.  (Only
@@ -2069,7 +2232,7 @@ void idpf_tx_buf_hw_update(struct idpf_queue *tx_q, u32 val,
  *
  * Returns number of data descriptors needed for this skb.
  */
-unsigned int idpf_tx_desc_count_required(struct idpf_queue *txq,
+unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
 					 struct sk_buff *skb)
 {
 	const struct skb_shared_info *shinfo;
@@ -2102,7 +2265,7 @@ unsigned int idpf_tx_desc_count_required(struct idpf_queue *txq,
 
 		count = idpf_size_to_txd_count(skb->len);
 		u64_stats_update_begin(&txq->stats_sync);
-		u64_stats_inc(&txq->q_stats.tx.linearize);
+		u64_stats_inc(&txq->q_stats.linearize);
 		u64_stats_update_end(&txq->stats_sync);
 	}
 
@@ -2116,11 +2279,11 @@ unsigned int idpf_tx_desc_count_required(struct idpf_queue *txq,
  * @first: original first buffer info buffer for packet
  * @idx: starting point on ring to unwind
  */
-void idpf_tx_dma_map_error(struct idpf_queue *txq, struct sk_buff *skb,
+void idpf_tx_dma_map_error(struct idpf_tx_queue *txq, struct sk_buff *skb,
 			   struct idpf_tx_buf *first, u16 idx)
 {
 	u64_stats_update_begin(&txq->stats_sync);
-	u64_stats_inc(&txq->q_stats.tx.dma_map_errs);
+	u64_stats_inc(&txq->q_stats.dma_map_errs);
 	u64_stats_update_end(&txq->stats_sync);
 
 	/* clear dma mappings for failed tx_buf map */
@@ -2143,7 +2306,7 @@ void idpf_tx_dma_map_error(struct idpf_queue *txq, struct sk_buff *skb,
 		 * used one additional descriptor for a context
 		 * descriptor. Reset that here.
 		 */
-		tx_desc = IDPF_FLEX_TX_DESC(txq, idx);
+		tx_desc = &txq->flex_tx[idx];
 		memset(tx_desc, 0, sizeof(struct idpf_flex_tx_ctx_desc));
 		if (idx == 0)
 			idx = txq->desc_count;
@@ -2159,7 +2322,7 @@ void idpf_tx_dma_map_error(struct idpf_queue *txq, struct sk_buff *skb,
  * @txq: the tx ring to wrap
  * @ntu: ring index to bump
  */
-static unsigned int idpf_tx_splitq_bump_ntu(struct idpf_queue *txq, u16 ntu)
+static unsigned int idpf_tx_splitq_bump_ntu(struct idpf_tx_queue *txq, u16 ntu)
 {
 	ntu++;
 
@@ -2181,7 +2344,7 @@ static unsigned int idpf_tx_splitq_bump_ntu(struct idpf_queue *txq, u16 ntu)
  * and gets a physical address for each memory location and programs
  * it and the length into the transmit flex descriptor.
  */
-static void idpf_tx_splitq_map(struct idpf_queue *tx_q,
+static void idpf_tx_splitq_map(struct idpf_tx_queue *tx_q,
 			       struct idpf_tx_splitq_params *params,
 			       struct idpf_tx_buf *first)
 {
@@ -2202,7 +2365,7 @@ static void idpf_tx_splitq_map(struct idpf_queue *tx_q,
 	data_len = skb->data_len;
 	size = skb_headlen(skb);
 
-	tx_desc = IDPF_FLEX_TX_DESC(tx_q, i);
+	tx_desc = &tx_q->flex_tx[i];
 
 	dma = dma_map_single(tx_q->dev, skb->data, size, DMA_TO_DEVICE);
 
@@ -2275,7 +2438,7 @@ static void idpf_tx_splitq_map(struct idpf_queue *tx_q,
 			i++;
 
 			if (i == tx_q->desc_count) {
-				tx_desc = IDPF_FLEX_TX_DESC(tx_q, 0);
+				tx_desc = &tx_q->flex_tx[0];
 				i = 0;
 				tx_q->compl_tag_cur_gen =
 					IDPF_TX_ADJ_COMPL_TAG_GEN(tx_q);
@@ -2320,7 +2483,7 @@ static void idpf_tx_splitq_map(struct idpf_queue *tx_q,
 		i++;
 
 		if (i == tx_q->desc_count) {
-			tx_desc = IDPF_FLEX_TX_DESC(tx_q, 0);
+			tx_desc = &tx_q->flex_tx[0];
 			i = 0;
 			tx_q->compl_tag_cur_gen = IDPF_TX_ADJ_COMPL_TAG_GEN(tx_q);
 		}
@@ -2348,7 +2511,7 @@ static void idpf_tx_splitq_map(struct idpf_queue *tx_q,
 	tx_q->txq_grp->num_completions_pending++;
 
 	/* record bytecount for BQL */
-	nq = netdev_get_tx_queue(tx_q->vport->netdev, tx_q->idx);
+	nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 	netdev_tx_sent_queue(nq, first->bytecount);
 
 	idpf_tx_buf_hw_update(tx_q, i, netdev_xmit_more());
@@ -2525,8 +2688,8 @@ static bool __idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs)
  * E.g.: a packet with 7 fragments can require 9 DMA transactions; 1 for TSO
  * header, 1 for segment payload, and then 7 for the fragments.
  */
-bool idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs,
-			unsigned int count)
+static bool idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs,
+			       unsigned int count)
 {
 	if (likely(count < max_bufs))
 		return false;
@@ -2544,7 +2707,7 @@ bool idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs,
  * ring entry to reflect that this index is a context descriptor
  */
 static struct idpf_flex_tx_ctx_desc *
-idpf_tx_splitq_get_ctx_desc(struct idpf_queue *txq)
+idpf_tx_splitq_get_ctx_desc(struct idpf_tx_queue *txq)
 {
 	struct idpf_flex_tx_ctx_desc *desc;
 	int i = txq->next_to_use;
@@ -2553,7 +2716,7 @@ idpf_tx_splitq_get_ctx_desc(struct idpf_queue *txq)
 	txq->tx_buf[i].compl_tag = IDPF_SPLITQ_TX_INVAL_COMPL_TAG;
 
 	/* grab the next descriptor */
-	desc = IDPF_FLEX_TX_CTX_DESC(txq, i);
+	desc = &txq->flex_ctx[i];
 	txq->next_to_use = idpf_tx_splitq_bump_ntu(txq, i);
 
 	return desc;
@@ -2564,10 +2727,10 @@ idpf_tx_splitq_get_ctx_desc(struct idpf_queue *txq)
  * @tx_q: queue to send buffer on
  * @skb: pointer to skb
  */
-netdev_tx_t idpf_tx_drop_skb(struct idpf_queue *tx_q, struct sk_buff *skb)
+netdev_tx_t idpf_tx_drop_skb(struct idpf_tx_queue *tx_q, struct sk_buff *skb)
 {
 	u64_stats_update_begin(&tx_q->stats_sync);
-	u64_stats_inc(&tx_q->q_stats.tx.skb_drops);
+	u64_stats_inc(&tx_q->q_stats.skb_drops);
 	u64_stats_update_end(&tx_q->stats_sync);
 
 	idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
@@ -2585,7 +2748,7 @@ netdev_tx_t idpf_tx_drop_skb(struct idpf_queue *tx_q, struct sk_buff *skb)
  * Returns NETDEV_TX_OK if sent, else an error code
  */
 static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
-					struct idpf_queue *tx_q)
+					struct idpf_tx_queue *tx_q)
 {
 	struct idpf_tx_splitq_params tx_params = { };
 	struct idpf_tx_buf *first;
@@ -2625,7 +2788,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 		ctx_desc->tso.qw0.hdr_len = tx_params.offload.tso_hdr_len;
 
 		u64_stats_update_begin(&tx_q->stats_sync);
-		u64_stats_inc(&tx_q->q_stats.tx.lso_pkts);
+		u64_stats_inc(&tx_q->q_stats.lso_pkts);
 		u64_stats_update_end(&tx_q->stats_sync);
 	}
 
@@ -2642,7 +2805,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 		first->bytecount = max_t(unsigned int, skb->len, ETH_ZLEN);
 	}
 
-	if (test_bit(__IDPF_Q_FLOW_SCH_EN, tx_q->flags)) {
+	if (idpf_queue_has(FLOW_SCH_EN, tx_q)) {
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
 		/* Set the RE bit to catch any packets that may have not been
@@ -2672,17 +2835,16 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 }
 
 /**
- * idpf_tx_splitq_start - Selects the right Tx queue to send buffer
+ * idpf_tx_start - Selects the right Tx queue to send buffer
  * @skb: send buffer
  * @netdev: network interface device structure
  *
  * Returns NETDEV_TX_OK if sent, else an error code
  */
-netdev_tx_t idpf_tx_splitq_start(struct sk_buff *skb,
-				 struct net_device *netdev)
+netdev_tx_t idpf_tx_start(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
-	struct idpf_queue *tx_q;
+	struct idpf_tx_queue *tx_q;
 
 	if (unlikely(skb_get_queue_mapping(skb) >= vport->num_txq)) {
 		dev_kfree_skb_any(skb);
@@ -2701,7 +2863,10 @@ netdev_tx_t idpf_tx_splitq_start(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
-	return idpf_tx_splitq_frame(skb, tx_q);
+	if (idpf_is_queue_model_split(vport->txq_model))
+		return idpf_tx_splitq_frame(skb, tx_q);
+	else
+		return idpf_tx_singleq_frame(skb, tx_q);
 }
 
 /**
@@ -2735,13 +2900,14 @@ enum pkt_hash_types idpf_ptype_to_htype(const struct idpf_rx_ptype_decoded *deco
  * @rx_desc: Receive descriptor
  * @decoded: Decoded Rx packet type related fields
  */
-static void idpf_rx_hash(struct idpf_queue *rxq, struct sk_buff *skb,
-			 struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc,
-			 struct idpf_rx_ptype_decoded *decoded)
+static void
+idpf_rx_hash(const struct idpf_rx_queue *rxq, struct sk_buff *skb,
+	     const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc,
+	     struct idpf_rx_ptype_decoded *decoded)
 {
 	u32 hash;
 
-	if (unlikely(!idpf_is_feature_ena(rxq->vport, NETIF_F_RXHASH)))
+	if (unlikely(!(rxq->netdev->features & NETIF_F_RXHASH)))
 		return;
 
 	hash = le16_to_cpu(rx_desc->hash1) |
@@ -2760,14 +2926,14 @@ static void idpf_rx_hash(struct idpf_queue *rxq, struct sk_buff *skb,
  *
  * skb->protocol must be set before this function is called
  */
-static void idpf_rx_csum(struct idpf_queue *rxq, struct sk_buff *skb,
+static void idpf_rx_csum(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 			 struct idpf_rx_csum_decoded *csum_bits,
 			 struct idpf_rx_ptype_decoded *decoded)
 {
 	bool ipv4, ipv6;
 
 	/* check if Rx checksum is enabled */
-	if (unlikely(!idpf_is_feature_ena(rxq->vport, NETIF_F_RXCSUM)))
+	if (unlikely(!(rxq->netdev->features & NETIF_F_RXCSUM)))
 		return;
 
 	/* check if HW has decoded the packet and checksum */
@@ -2814,7 +2980,7 @@ static void idpf_rx_csum(struct idpf_queue *rxq, struct sk_buff *skb,
 
 checksum_fail:
 	u64_stats_update_begin(&rxq->stats_sync);
-	u64_stats_inc(&rxq->q_stats.rx.hw_csum_err);
+	u64_stats_inc(&rxq->q_stats.hw_csum_err);
 	u64_stats_update_end(&rxq->stats_sync);
 }
 
@@ -2824,8 +2990,9 @@ static void idpf_rx_csum(struct idpf_queue *rxq, struct sk_buff *skb,
  * @csum: structure to extract checksum fields
  *
  **/
-static void idpf_rx_splitq_extract_csum_bits(struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc,
-					     struct idpf_rx_csum_decoded *csum)
+static void
+idpf_rx_splitq_extract_csum_bits(const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc,
+				 struct idpf_rx_csum_decoded *csum)
 {
 	u8 qword0, qword1;
 
@@ -2860,8 +3027,8 @@ static void idpf_rx_splitq_extract_csum_bits(struct virtchnl2_rx_flex_desc_adv_n
  * Populate the skb fields with the total number of RSC segments, RSC payload
  * length and packet type.
  */
-static int idpf_rx_rsc(struct idpf_queue *rxq, struct sk_buff *skb,
-		       struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc,
+static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
+		       const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc,
 		       struct idpf_rx_ptype_decoded *decoded)
 {
 	u16 rsc_segments, rsc_seg_len;
@@ -2914,7 +3081,7 @@ static int idpf_rx_rsc(struct idpf_queue *rxq, struct sk_buff *skb,
 	tcp_gro_complete(skb);
 
 	u64_stats_update_begin(&rxq->stats_sync);
-	u64_stats_inc(&rxq->q_stats.rx.rsc_pkts);
+	u64_stats_inc(&rxq->q_stats.rsc_pkts);
 	u64_stats_update_end(&rxq->stats_sync);
 
 	return 0;
@@ -2930,9 +3097,9 @@ static int idpf_rx_rsc(struct idpf_queue *rxq, struct sk_buff *skb,
  * order to populate the hash, checksum, protocol, and
  * other fields within the skb.
  */
-static int idpf_rx_process_skb_fields(struct idpf_queue *rxq,
-				      struct sk_buff *skb,
-				      struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc)
+static int
+idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
+			   const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc)
 {
 	struct idpf_rx_csum_decoded csum_bits = { };
 	struct idpf_rx_ptype_decoded decoded;
@@ -2940,19 +3107,13 @@ static int idpf_rx_process_skb_fields(struct idpf_queue *rxq,
 
 	rx_ptype = le16_get_bits(rx_desc->ptype_err_fflags0,
 				 VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_M);
-
-	skb->protocol = eth_type_trans(skb, rxq->vport->netdev);
-
-	decoded = rxq->vport->rx_ptype_lkup[rx_ptype];
-	/* If we don't know the ptype we can't do anything else with it. Just
-	 * pass it up the stack as-is.
-	 */
-	if (!decoded.known)
-		return 0;
+	decoded = rxq->rx_ptype_lkup[rx_ptype];
 
 	/* process RSS/hash */
 	idpf_rx_hash(rxq, skb, rx_desc, &decoded);
 
+	skb->protocol = eth_type_trans(skb, rxq->netdev);
+
 	if (le16_get_bits(rx_desc->hdrlen_flags,
 			  VIRTCHNL2_RX_FLEX_DESC_ADV_RSC_M))
 		return idpf_rx_rsc(rxq, skb, rx_desc, &decoded);
@@ -2992,7 +3153,7 @@ void idpf_rx_add_frag(struct idpf_rx_buf *rx_buf, struct sk_buff *skb,
  * data from the current receive descriptor, taking care to set up the
  * skb correctly.
  */
-struct sk_buff *idpf_rx_construct_skb(struct idpf_queue *rxq,
+struct sk_buff *idpf_rx_construct_skb(const struct idpf_rx_queue *rxq,
 				      struct idpf_rx_buf *rx_buf,
 				      unsigned int size)
 {
@@ -3005,7 +3166,7 @@ struct sk_buff *idpf_rx_construct_skb(struct idpf_queue *rxq,
 	/* prefetch first cache line of first page */
 	net_prefetch(va);
 	/* allocate a skb to store the frags */
-	skb = napi_alloc_skb(&rxq->q_vector->napi, IDPF_RX_HDR_SIZE);
+	skb = napi_alloc_skb(rxq->napi, IDPF_RX_HDR_SIZE);
 	if (unlikely(!skb)) {
 		idpf_rx_put_page(rx_buf);
 
@@ -3052,14 +3213,14 @@ struct sk_buff *idpf_rx_construct_skb(struct idpf_queue *rxq,
  * the current receive descriptor, taking care to set up the skb correctly.
  * This specifically uses a header buffer to start building the skb.
  */
-static struct sk_buff *idpf_rx_hdr_construct_skb(struct idpf_queue *rxq,
-						 const void *va,
-						 unsigned int size)
+static struct sk_buff *
+idpf_rx_hdr_construct_skb(const struct idpf_rx_queue *rxq, const void *va,
+			  unsigned int size)
 {
 	struct sk_buff *skb;
 
 	/* allocate a skb to store the frags */
-	skb = napi_alloc_skb(&rxq->q_vector->napi, size);
+	skb = napi_alloc_skb(rxq->napi, size);
 	if (unlikely(!skb))
 		return NULL;
 
@@ -3115,10 +3276,10 @@ static bool idpf_rx_splitq_is_eop(struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_de
  *
  * Returns amount of work completed
  */
-static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
+static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 {
 	int total_rx_bytes = 0, total_rx_pkts = 0;
-	struct idpf_queue *rx_bufq = NULL;
+	struct idpf_buf_queue *rx_bufq = NULL;
 	struct sk_buff *skb = rxq->skb;
 	u16 ntc = rxq->next_to_clean;
 
@@ -3128,7 +3289,6 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 		struct idpf_sw_queue *refillq = NULL;
 		struct idpf_rxq_set *rxq_set = NULL;
 		struct idpf_rx_buf *rx_buf = NULL;
-		union virtchnl2_rx_desc *desc;
 		unsigned int pkt_len = 0;
 		unsigned int hdr_len = 0;
 		u16 gen_id, buf_id = 0;
@@ -3138,8 +3298,7 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 		u8 rxdid;
 
 		/* get the Rx desc from Rx queue based on 'next_to_clean' */
-		desc = IDPF_RX_DESC(rxq, ntc);
-		rx_desc = (struct virtchnl2_rx_flex_desc_adv_nic_3 *)desc;
+		rx_desc = &rxq->rx[ntc].flex_adv_nic_3_wb;
 
 		/* This memory barrier is needed to keep us from reading
 		 * any other fields out of the rx_desc
@@ -3150,7 +3309,7 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 		gen_id = le16_get_bits(rx_desc->pktlen_gen_bufq_id,
 				       VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M);
 
-		if (test_bit(__IDPF_Q_GEN_CHK, rxq->flags) != gen_id)
+		if (idpf_queue_has(GEN_CHK, rxq) != gen_id)
 			break;
 
 		rxdid = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_RXDID_M,
@@ -3158,7 +3317,7 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 		if (rxdid != VIRTCHNL2_RXDID_2_FLEX_SPLITQ) {
 			IDPF_RX_BUMP_NTC(rxq, ntc);
 			u64_stats_update_begin(&rxq->stats_sync);
-			u64_stats_inc(&rxq->q_stats.rx.bad_descs);
+			u64_stats_inc(&rxq->q_stats.bad_descs);
 			u64_stats_update_end(&rxq->stats_sync);
 			continue;
 		}
@@ -3176,7 +3335,7 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 			 * data/payload buffer.
 			 */
 			u64_stats_update_begin(&rxq->stats_sync);
-			u64_stats_inc(&rxq->q_stats.rx.hsplit_buf_ovf);
+			u64_stats_inc(&rxq->q_stats.hsplit_buf_ovf);
 			u64_stats_update_end(&rxq->stats_sync);
 			goto bypass_hsplit;
 		}
@@ -3189,13 +3348,10 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 					VIRTCHNL2_RX_FLEX_DESC_ADV_BUFQ_ID_M);
 
 		rxq_set = container_of(rxq, struct idpf_rxq_set, rxq);
-		if (!bufq_id)
-			refillq = rxq_set->refillq0;
-		else
-			refillq = rxq_set->refillq1;
+		refillq = rxq_set->refillq[bufq_id];
 
 		/* retrieve buffer from the rxq */
-		rx_bufq = &rxq->rxq_grp->splitq.bufq_sets[bufq_id].bufq;
+		rx_bufq = &rxq->bufq_sets[bufq_id].bufq;
 
 		buf_id = le16_to_cpu(rx_desc->buf_id);
 
@@ -3207,7 +3363,7 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 
 			skb = idpf_rx_hdr_construct_skb(rxq, va, hdr_len);
 			u64_stats_update_begin(&rxq->stats_sync);
-			u64_stats_inc(&rxq->q_stats.rx.hsplit_pkts);
+			u64_stats_inc(&rxq->q_stats.hsplit_pkts);
 			u64_stats_update_end(&rxq->stats_sync);
 		}
 
@@ -3250,7 +3406,7 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 		}
 
 		/* send completed skb up the stack */
-		napi_gro_receive(&rxq->q_vector->napi, skb);
+		napi_gro_receive(rxq->napi, skb);
 		skb = NULL;
 
 		/* update budget accounting */
@@ -3261,8 +3417,8 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 
 	rxq->skb = skb;
 	u64_stats_update_begin(&rxq->stats_sync);
-	u64_stats_add(&rxq->q_stats.rx.packets, total_rx_pkts);
-	u64_stats_add(&rxq->q_stats.rx.bytes, total_rx_bytes);
+	u64_stats_add(&rxq->q_stats.packets, total_rx_pkts);
+	u64_stats_add(&rxq->q_stats.bytes, total_rx_bytes);
 	u64_stats_update_end(&rxq->stats_sync);
 
 	/* guarantee a trip back through this routine if there was a failure */
@@ -3272,19 +3428,16 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 /**
  * idpf_rx_update_bufq_desc - Update buffer queue descriptor
  * @bufq: Pointer to the buffer queue
- * @refill_desc: SW Refill queue descriptor containing buffer ID
+ * @buf_id: buffer ID
  * @buf_desc: Buffer queue descriptor
  *
  * Return 0 on success and negative on failure.
  */
-static int idpf_rx_update_bufq_desc(struct idpf_queue *bufq, u16 refill_desc,
+static int idpf_rx_update_bufq_desc(struct idpf_buf_queue *bufq, u32 buf_id,
 				    struct virtchnl2_splitq_rx_buf_desc *buf_desc)
 {
 	struct idpf_rx_buf *buf;
 	dma_addr_t addr;
-	u16 buf_id;
-
-	buf_id = FIELD_GET(IDPF_RX_BI_BUFID_M, refill_desc);
 
 	buf = &bufq->rx_buf.buf[buf_id];
 
@@ -3295,7 +3448,7 @@ static int idpf_rx_update_bufq_desc(struct idpf_queue *bufq, u16 refill_desc,
 	buf_desc->pkt_addr = cpu_to_le64(addr);
 	buf_desc->qword0.buf_id = cpu_to_le16(buf_id);
 
-	if (!bufq->rx_hsplit_en)
+	if (!idpf_queue_has(HSPLIT_EN, bufq))
 		return 0;
 
 	buf_desc->hdr_addr = cpu_to_le64(bufq->rx_buf.hdr_buf_pa +
@@ -3311,38 +3464,37 @@ static int idpf_rx_update_bufq_desc(struct idpf_queue *bufq, u16 refill_desc,
  *
  * This function takes care of the buffer refill management
  */
-static void idpf_rx_clean_refillq(struct idpf_queue *bufq,
+static void idpf_rx_clean_refillq(struct idpf_buf_queue *bufq,
 				  struct idpf_sw_queue *refillq)
 {
 	struct virtchnl2_splitq_rx_buf_desc *buf_desc;
 	u16 bufq_nta = bufq->next_to_alloc;
 	u16 ntc = refillq->next_to_clean;
 	int cleaned = 0;
-	u16 gen;
 
-	buf_desc = IDPF_SPLITQ_RX_BUF_DESC(bufq, bufq_nta);
+	buf_desc = &bufq->split_buf[bufq_nta];
 
 	/* make sure we stop at ring wrap in the unlikely case ring is full */
 	while (likely(cleaned < refillq->desc_count)) {
-		u16 refill_desc = IDPF_SPLITQ_RX_BI_DESC(refillq, ntc);
+		u32 buf_id, refill_desc = refillq->ring[ntc];
 		bool failure;
 
-		gen = FIELD_GET(IDPF_RX_BI_GEN_M, refill_desc);
-		if (test_bit(__IDPF_RFLQ_GEN_CHK, refillq->flags) != gen)
+		if (idpf_queue_has(RFL_GEN_CHK, refillq) !=
+		    !!(refill_desc & IDPF_RX_BI_GEN_M))
 			break;
 
-		failure = idpf_rx_update_bufq_desc(bufq, refill_desc,
-						   buf_desc);
+		buf_id = FIELD_GET(IDPF_RX_BI_BUFID_M, refill_desc);
+		failure = idpf_rx_update_bufq_desc(bufq, buf_id, buf_desc);
 		if (failure)
 			break;
 
 		if (unlikely(++ntc == refillq->desc_count)) {
-			change_bit(__IDPF_RFLQ_GEN_CHK, refillq->flags);
+			idpf_queue_change(RFL_GEN_CHK, refillq);
 			ntc = 0;
 		}
 
 		if (unlikely(++bufq_nta == bufq->desc_count)) {
-			buf_desc = IDPF_SPLITQ_RX_BUF_DESC(bufq, 0);
+			buf_desc = &bufq->split_buf[0];
 			bufq_nta = 0;
 		} else {
 			buf_desc++;
@@ -3376,7 +3528,7 @@ static void idpf_rx_clean_refillq(struct idpf_queue *bufq,
  * this vector.  Returns true if clean is complete within budget, false
  * otherwise.
  */
-static void idpf_rx_clean_refillq_all(struct idpf_queue *bufq)
+static void idpf_rx_clean_refillq_all(struct idpf_buf_queue *bufq)
 {
 	struct idpf_bufq_set *bufq_set;
 	int i;
@@ -3439,6 +3591,8 @@ void idpf_vport_intr_rel(struct idpf_vport *vport)
 	for (u32 v_idx = 0; v_idx < vport->num_q_vectors; v_idx++) {
 		struct idpf_q_vector *q_vector = &vport->q_vectors[v_idx];
 
+		kfree(q_vector->complq);
+		q_vector->complq = NULL;
 		kfree(q_vector->bufq);
 		q_vector->bufq = NULL;
 		kfree(q_vector->tx);
@@ -3557,13 +3711,13 @@ static void idpf_net_dim(struct idpf_q_vector *q_vector)
 		goto check_rx_itr;
 
 	for (i = 0, packets = 0, bytes = 0; i < q_vector->num_txq; i++) {
-		struct idpf_queue *txq = q_vector->tx[i];
+		struct idpf_tx_queue *txq = q_vector->tx[i];
 		unsigned int start;
 
 		do {
 			start = u64_stats_fetch_begin(&txq->stats_sync);
-			packets += u64_stats_read(&txq->q_stats.tx.packets);
-			bytes += u64_stats_read(&txq->q_stats.tx.bytes);
+			packets += u64_stats_read(&txq->q_stats.packets);
+			bytes += u64_stats_read(&txq->q_stats.bytes);
 		} while (u64_stats_fetch_retry(&txq->stats_sync, start));
 	}
 
@@ -3576,13 +3730,13 @@ static void idpf_net_dim(struct idpf_q_vector *q_vector)
 		return;
 
 	for (i = 0, packets = 0, bytes = 0; i < q_vector->num_rxq; i++) {
-		struct idpf_queue *rxq = q_vector->rx[i];
+		struct idpf_rx_queue *rxq = q_vector->rx[i];
 		unsigned int start;
 
 		do {
 			start = u64_stats_fetch_begin(&rxq->stats_sync);
-			packets += u64_stats_read(&rxq->q_stats.rx.packets);
-			bytes += u64_stats_read(&rxq->q_stats.rx.bytes);
+			packets += u64_stats_read(&rxq->q_stats.packets);
+			bytes += u64_stats_read(&rxq->q_stats.bytes);
 		} while (u64_stats_fetch_retry(&rxq->stats_sync, start));
 	}
 
@@ -3826,16 +3980,17 @@ static void idpf_vport_intr_napi_ena_all(struct idpf_vport *vport)
 static bool idpf_tx_splitq_clean_all(struct idpf_q_vector *q_vec,
 				     int budget, int *cleaned)
 {
-	u16 num_txq = q_vec->num_txq;
+	u16 num_complq = q_vec->num_complq;
 	bool clean_complete = true;
 	int i, budget_per_q;
 
-	if (unlikely(!num_txq))
+	if (unlikely(!num_complq))
 		return true;
 
-	budget_per_q = DIV_ROUND_UP(budget, num_txq);
-	for (i = 0; i < num_txq; i++)
-		clean_complete &= idpf_tx_clean_complq(q_vec->tx[i],
+	budget_per_q = DIV_ROUND_UP(budget, num_complq);
+
+	for (i = 0; i < num_complq; i++)
+		clean_complete &= idpf_tx_clean_complq(q_vec->complq[i],
 						       budget_per_q, cleaned);
 
 	return clean_complete;
@@ -3862,7 +4017,7 @@ static bool idpf_rx_splitq_clean_all(struct idpf_q_vector *q_vec, int budget,
 	 */
 	budget_per_q = num_rxq ? max(budget / num_rxq, 1) : 0;
 	for (i = 0; i < num_rxq; i++) {
-		struct idpf_queue *rxq = q_vec->rx[i];
+		struct idpf_rx_queue *rxq = q_vec->rx[i];
 		int pkts_cleaned_per_q;
 
 		pkts_cleaned_per_q = idpf_rx_splitq_clean(rxq, budget_per_q);
@@ -3917,8 +4072,8 @@ static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
 	 * queues virtchnl message, as the interrupts will be disabled after
 	 * that
 	 */
-	if (unlikely(q_vector->num_txq && test_bit(__IDPF_Q_POLL_MODE,
-						   q_vector->tx[0]->flags)))
+	if (unlikely(q_vector->num_txq && idpf_queue_has(POLL_MODE,
+							 q_vector->tx[0])))
 		return budget;
 	else
 		return work_done;
@@ -3932,27 +4087,28 @@ static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
  */
 static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport)
 {
+	bool split = idpf_is_queue_model_split(vport->rxq_model);
 	u16 num_txq_grp = vport->num_txq_grp;
-	int i, j, qv_idx, bufq_vidx = 0;
 	struct idpf_rxq_group *rx_qgrp;
 	struct idpf_txq_group *tx_qgrp;
-	struct idpf_queue *q, *bufq;
-	u16 q_index;
+	u32 i, qv_idx, q_index;
 
 	for (i = 0, qv_idx = 0; i < vport->num_rxq_grp; i++) {
 		u16 num_rxq;
 
+		if (qv_idx >= vport->num_q_vectors)
+			qv_idx = 0;
+
 		rx_qgrp = &vport->rxq_grps[i];
-		if (idpf_is_queue_model_split(vport->rxq_model))
+		if (split)
 			num_rxq = rx_qgrp->splitq.num_rxq_sets;
 		else
 			num_rxq = rx_qgrp->singleq.num_rxq;
 
-		for (j = 0; j < num_rxq; j++) {
-			if (qv_idx >= vport->num_q_vectors)
-				qv_idx = 0;
+		for (u32 j = 0; j < num_rxq; j++) {
+			struct idpf_rx_queue *q;
 
-			if (idpf_is_queue_model_split(vport->rxq_model))
+			if (split)
 				q = &rx_qgrp->splitq.rxq_sets[j]->rxq;
 			else
 				q = rx_qgrp->singleq.rxqs[j];
@@ -3960,52 +4116,53 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport)
 			q_index = q->q_vector->num_rxq;
 			q->q_vector->rx[q_index] = q;
 			q->q_vector->num_rxq++;
-			qv_idx++;
+
+			if (split)
+				q->napi = &q->q_vector->napi;
 		}
 
-		if (idpf_is_queue_model_split(vport->rxq_model)) {
-			for (j = 0; j < vport->num_bufqs_per_qgrp; j++) {
+		if (split) {
+			for (u32 j = 0; j < vport->num_bufqs_per_qgrp; j++) {
+				struct idpf_buf_queue *bufq;
+
 				bufq = &rx_qgrp->splitq.bufq_sets[j].bufq;
-				bufq->q_vector = &vport->q_vectors[bufq_vidx];
+				bufq->q_vector = &vport->q_vectors[qv_idx];
 				q_index = bufq->q_vector->num_bufq;
 				bufq->q_vector->bufq[q_index] = bufq;
 				bufq->q_vector->num_bufq++;
 			}
-			if (++bufq_vidx >= vport->num_q_vectors)
-				bufq_vidx = 0;
 		}
+
+		qv_idx++;
 	}
 
+	split = idpf_is_queue_model_split(vport->txq_model);
+
 	for (i = 0, qv_idx = 0; i < num_txq_grp; i++) {
 		u16 num_txq;
 
+		if (qv_idx >= vport->num_q_vectors)
+			qv_idx = 0;
+
 		tx_qgrp = &vport->txq_grps[i];
 		num_txq = tx_qgrp->num_txq;
 
-		if (idpf_is_queue_model_split(vport->txq_model)) {
-			if (qv_idx >= vport->num_q_vectors)
-				qv_idx = 0;
+		for (u32 j = 0; j < num_txq; j++) {
+			struct idpf_tx_queue *q;
 
-			q = tx_qgrp->complq;
+			q = tx_qgrp->txqs[j];
 			q->q_vector = &vport->q_vectors[qv_idx];
-			q_index = q->q_vector->num_txq;
-			q->q_vector->tx[q_index] = q;
-			q->q_vector->num_txq++;
-			qv_idx++;
-		} else {
-			for (j = 0; j < num_txq; j++) {
-				if (qv_idx >= vport->num_q_vectors)
-					qv_idx = 0;
+			q->q_vector->tx[q->q_vector->num_txq++] = q;
+		}
 
-				q = tx_qgrp->txqs[j];
-				q->q_vector = &vport->q_vectors[qv_idx];
-				q_index = q->q_vector->num_txq;
-				q->q_vector->tx[q_index] = q;
-				q->q_vector->num_txq++;
+		if (split) {
+			struct idpf_compl_queue *q = tx_qgrp->complq;
 
-				qv_idx++;
-			}
+			q->q_vector = &vport->q_vectors[qv_idx];
+			q->q_vector->complq[q->q_vector->num_complq++] = q;
 		}
+
+		qv_idx++;
 	}
 }
 
@@ -4081,18 +4238,22 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport)
 {
 	u16 txqs_per_vector, rxqs_per_vector, bufqs_per_vector;
 	struct idpf_q_vector *q_vector;
-	int v_idx, err;
+	u32 complqs_per_vector, v_idx;
 
 	vport->q_vectors = kcalloc(vport->num_q_vectors,
 				   sizeof(struct idpf_q_vector), GFP_KERNEL);
 	if (!vport->q_vectors)
 		return -ENOMEM;
 
-	txqs_per_vector = DIV_ROUND_UP(vport->num_txq, vport->num_q_vectors);
-	rxqs_per_vector = DIV_ROUND_UP(vport->num_rxq, vport->num_q_vectors);
+	txqs_per_vector = DIV_ROUND_UP(vport->num_txq_grp,
+				       vport->num_q_vectors);
+	rxqs_per_vector = DIV_ROUND_UP(vport->num_rxq_grp,
+				       vport->num_q_vectors);
 	bufqs_per_vector = vport->num_bufqs_per_qgrp *
 			   DIV_ROUND_UP(vport->num_rxq_grp,
 					vport->num_q_vectors);
+	complqs_per_vector = DIV_ROUND_UP(vport->num_txq_grp,
+					  vport->num_q_vectors);
 
 	for (v_idx = 0; v_idx < vport->num_q_vectors; v_idx++) {
 		q_vector = &vport->q_vectors[v_idx];
@@ -4106,32 +4267,30 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport)
 		q_vector->rx_intr_mode = IDPF_ITR_DYNAMIC;
 		q_vector->rx_itr_idx = VIRTCHNL2_ITR_IDX_0;
 
-		q_vector->tx = kcalloc(txqs_per_vector,
-				       sizeof(struct idpf_queue *),
+		q_vector->tx = kcalloc(txqs_per_vector, sizeof(*q_vector->tx),
 				       GFP_KERNEL);
-		if (!q_vector->tx) {
-			err = -ENOMEM;
+		if (!q_vector->tx)
 			goto error;
-		}
 
-		q_vector->rx = kcalloc(rxqs_per_vector,
-				       sizeof(struct idpf_queue *),
+		q_vector->rx = kcalloc(rxqs_per_vector, sizeof(*q_vector->rx),
 				       GFP_KERNEL);
-		if (!q_vector->rx) {
-			err = -ENOMEM;
+		if (!q_vector->rx)
 			goto error;
-		}
 
 		if (!idpf_is_queue_model_split(vport->rxq_model))
 			continue;
 
 		q_vector->bufq = kcalloc(bufqs_per_vector,
-					 sizeof(struct idpf_queue *),
+					 sizeof(*q_vector->bufq),
 					 GFP_KERNEL);
-		if (!q_vector->bufq) {
-			err = -ENOMEM;
+		if (!q_vector->bufq)
+			goto error;
+
+		q_vector->complq = kcalloc(complqs_per_vector,
+					   sizeof(*q_vector->complq),
+					   GFP_KERNEL);
+		if (!q_vector->complq)
 			goto error;
-		}
 	}
 
 	return 0;
@@ -4139,7 +4298,7 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport)
 error:
 	idpf_vport_intr_rel(vport);
 
-	return err;
+	return -ENOMEM;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 551391e20464..214a24e68463 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -4,10 +4,13 @@
 #ifndef _IDPF_TXRX_H_
 #define _IDPF_TXRX_H_
 
+#include <linux/dim.h>
+
 #include <net/page_pool/helpers.h>
 #include <net/tcp.h>
 #include <net/netdev_queues.h>
 
+#include "idpf_lan_txrx.h"
 #include "virtchnl2_lan_desc.h"
 
 #define IDPF_LARGE_MAX_Q			256
@@ -83,7 +86,7 @@
 do {								\
 	if (unlikely(++(ntc) == (rxq)->desc_count)) {		\
 		ntc = 0;					\
-		change_bit(__IDPF_Q_GEN_CHK, (rxq)->flags);	\
+		idpf_queue_change(GEN_CHK, rxq);		\
 	}							\
 } while (0)
 
@@ -110,36 +113,17 @@ do {								\
  */
 #define IDPF_TX_SPLITQ_RE_MIN_GAP	64
 
-#define IDPF_RX_BI_BUFID_S		0
-#define IDPF_RX_BI_BUFID_M		GENMASK(14, 0)
-#define IDPF_RX_BI_GEN_S		15
-#define IDPF_RX_BI_GEN_M		BIT(IDPF_RX_BI_GEN_S)
+#define IDPF_RX_BI_GEN_M		BIT(16)
+#define IDPF_RX_BI_BUFID_M		GENMASK(15, 0)
+
 #define IDPF_RXD_EOF_SPLITQ		VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_EOF_M
 #define IDPF_RXD_EOF_SINGLEQ		VIRTCHNL2_RX_BASE_DESC_STATUS_EOF_M
 
-#define IDPF_SINGLEQ_RX_BUF_DESC(rxq, i)	\
-	(&(((struct virtchnl2_singleq_rx_buf_desc *)((rxq)->desc_ring))[i]))
-#define IDPF_SPLITQ_RX_BUF_DESC(rxq, i)	\
-	(&(((struct virtchnl2_splitq_rx_buf_desc *)((rxq)->desc_ring))[i]))
-#define IDPF_SPLITQ_RX_BI_DESC(rxq, i) ((((rxq)->ring))[i])
-
-#define IDPF_BASE_TX_DESC(txq, i)	\
-	(&(((struct idpf_base_tx_desc *)((txq)->desc_ring))[i]))
-#define IDPF_BASE_TX_CTX_DESC(txq, i) \
-	(&(((struct idpf_base_tx_ctx_desc *)((txq)->desc_ring))[i]))
-#define IDPF_SPLITQ_TX_COMPLQ_DESC(txcq, i)	\
-	(&(((struct idpf_splitq_tx_compl_desc *)((txcq)->desc_ring))[i]))
-
-#define IDPF_FLEX_TX_DESC(txq, i) \
-	(&(((union idpf_tx_flex_desc *)((txq)->desc_ring))[i]))
-#define IDPF_FLEX_TX_CTX_DESC(txq, i)	\
-	(&(((struct idpf_flex_tx_ctx_desc *)((txq)->desc_ring))[i]))
-
 #define IDPF_DESC_UNUSED(txq)     \
 	((((txq)->next_to_clean > (txq)->next_to_use) ? 0 : (txq)->desc_count) + \
 	(txq)->next_to_clean - (txq)->next_to_use - 1)
 
-#define IDPF_TX_BUF_RSV_UNUSED(txq)	((txq)->buf_stack.top)
+#define IDPF_TX_BUF_RSV_UNUSED(txq)	((txq)->stash->buf_stack.top)
 #define IDPF_TX_BUF_RSV_LOW(txq)	(IDPF_TX_BUF_RSV_UNUSED(txq) < \
 					 (txq)->desc_count >> 2)
 
@@ -317,8 +301,6 @@ struct idpf_rx_extracted {
 
 #define IDPF_RX_DMA_ATTR \
 	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
-#define IDPF_RX_DESC(rxq, i)	\
-	(&(((union virtchnl2_rx_desc *)((rxq)->desc_ring))[i]))
 
 struct idpf_rx_buf {
 	struct page *page;
@@ -452,23 +434,37 @@ struct idpf_rx_ptype_decoded {
  *		      to 1 and knows that reading a gen bit of 1 in any
  *		      descriptor on the initial pass of the ring indicates a
  *		      writeback. It also flips on every ring wrap.
- * @__IDPF_RFLQ_GEN_CHK: Refill queues are SW only, so Q_GEN acts as the HW bit
- *			 and RFLGQ_GEN is the SW bit.
+ * @__IDPF_Q_RFL_GEN_CHK: Refill queues are SW only, so Q_GEN acts as the HW
+ *			  bit and Q_RFL_GEN is the SW bit.
  * @__IDPF_Q_FLOW_SCH_EN: Enable flow scheduling
  * @__IDPF_Q_SW_MARKER: Used to indicate TX queue marker completions
  * @__IDPF_Q_POLL_MODE: Enable poll mode
+ * @__IDPF_Q_CRC_EN: enable CRC offload in singleq mode
+ * @__IDPF_Q_HSPLIT_EN: enable header split on Rx (splitq)
  * @__IDPF_Q_FLAGS_NBITS: Must be last
  */
 enum idpf_queue_flags_t {
 	__IDPF_Q_GEN_CHK,
-	__IDPF_RFLQ_GEN_CHK,
+	__IDPF_Q_RFL_GEN_CHK,
 	__IDPF_Q_FLOW_SCH_EN,
 	__IDPF_Q_SW_MARKER,
 	__IDPF_Q_POLL_MODE,
+	__IDPF_Q_CRC_EN,
+	__IDPF_Q_HSPLIT_EN,
 
 	__IDPF_Q_FLAGS_NBITS,
 };
 
+#define idpf_queue_set(f, q)		__set_bit(__IDPF_Q_##f, (q)->flags)
+#define idpf_queue_clear(f, q)		__clear_bit(__IDPF_Q_##f, (q)->flags)
+#define idpf_queue_change(f, q)		__change_bit(__IDPF_Q_##f, (q)->flags)
+#define idpf_queue_has(f, q)		test_bit(__IDPF_Q_##f, (q)->flags)
+
+#define idpf_queue_has_clear(f, q)			\
+	__test_and_clear_bit(__IDPF_Q_##f, (q)->flags)
+#define idpf_queue_assign(f, q, v)			\
+	__assign_bit(__IDPF_Q_##f, (q)->flags, v)
+
 /**
  * struct idpf_vec_regs
  * @dyn_ctl_reg: Dynamic control interrupt register offset
@@ -514,7 +510,9 @@ struct idpf_intr_reg {
  * @v_idx: Vector index
  * @intr_reg: See struct idpf_intr_reg
  * @num_txq: Number of TX queues
+ * @num_complq: number of completion queues
  * @tx: Array of TX queues to service
+ * @complq: array of completion queues
  * @tx_dim: Data for TX net_dim algorithm
  * @tx_itr_value: TX interrupt throttling rate
  * @tx_intr_mode: Dynamic ITR or not
@@ -538,21 +536,24 @@ struct idpf_q_vector {
 	struct idpf_intr_reg intr_reg;
 
 	u16 num_txq;
-	struct idpf_queue **tx;
+	u16 num_complq;
+	struct idpf_tx_queue **tx;
+	struct idpf_compl_queue **complq;
+
 	struct dim tx_dim;
 	u16 tx_itr_value;
 	bool tx_intr_mode;
 	u32 tx_itr_idx;
 
 	u16 num_rxq;
-	struct idpf_queue **rx;
+	struct idpf_rx_queue **rx;
 	struct dim rx_dim;
 	u16 rx_itr_value;
 	bool rx_intr_mode;
 	u32 rx_itr_idx;
 
 	u16 num_bufq;
-	struct idpf_queue **bufq;
+	struct idpf_buf_queue **bufq;
 
 	u16 total_events;
 	char *name;
@@ -583,11 +584,6 @@ struct idpf_cleaned_stats {
 	u32 bytes;
 };
 
-union idpf_queue_stats {
-	struct idpf_rx_queue_stats rx;
-	struct idpf_tx_queue_stats tx;
-};
-
 #define IDPF_ITR_DYNAMIC	1
 #define IDPF_ITR_MAX		0x1FE0
 #define IDPF_ITR_20K		0x0032
@@ -603,39 +599,114 @@ union idpf_queue_stats {
 #define IDPF_DIM_DEFAULT_PROFILE_IX		1
 
 /**
- * struct idpf_queue
- * @dev: Device back pointer for DMA mapping
- * @vport: Back pointer to associated vport
- * @txq_grp: See struct idpf_txq_group
- * @rxq_grp: See struct idpf_rxq_group
- * @idx: For buffer queue, it is used as group id, either 0 or 1. On clean,
- *	 buffer queue uses this index to determine which group of refill queues
- *	 to clean.
- *	 For TX queue, it is used as index to map between TX queue group and
- *	 hot path TX pointers stored in vport. Used in both singleq/splitq.
- *	 For RX queue, it is used to index to total RX queue across groups and
+ * struct idpf_txq_stash - Tx buffer stash for Flow-based scheduling mode
+ * @buf_stack: Stack of empty buffers to store buffer info for out of order
+ *	       buffer completions. See struct idpf_buf_lifo
+ * @sched_buf_hash: Hash table to store buffers
+ */
+struct idpf_txq_stash {
+	struct idpf_buf_lifo buf_stack;
+	DECLARE_HASHTABLE(sched_buf_hash, 12);
+} ____cacheline_aligned;
+
+/**
+ * struct idpf_rx_queue - software structure representing a receive queue
+ * @rx: universal receive descriptor array
+ * @single_buf: buffer descriptor array in singleq
+ * @desc_ring: virtual descriptor ring address
+ * @bufq_sets: Pointer to the array of buffer queues in splitq mode
+ * @napi: NAPI instance corresponding to this queue (splitq)
+ * @rx_buf: See struct idpf_rx_buf
+ * @pp: Page pool pointer in singleq mode
+ * @netdev: &net_device corresponding to this queue
+ * @tail: Tail offset. Used for both queue models single and split.
+ * @flags: See enum idpf_queue_flags_t
+ * @idx: For RX queue, it is used to index to total RX queue across groups and
  *	 used for skb reporting.
- * @tail: Tail offset. Used for both queue models single and split. In splitq
- *	  model relevant only for TX queue and RX queue.
- * @tx_buf: See struct idpf_tx_buf
- * @rx_buf: Struct with RX buffer related members
- * @rx_buf.buf: See struct idpf_rx_buf
- * @rx_buf.hdr_buf_pa: DMA handle
- * @rx_buf.hdr_buf_va: Virtual address
- * @pp: Page pool pointer
+ * @desc_count: Number of descriptors
+ * @next_to_use: Next descriptor to use
+ * @next_to_clean: Next descriptor to clean
+ * @next_to_alloc: RX buffer to allocate at
+ * @rxdids: Supported RX descriptor ids
+ * @rx_ptype_lkup: LUT of Rx ptypes
  * @skb: Pointer to the skb
- * @q_type: Queue type (TX, RX, TX completion, RX buffer)
+ * @stats_sync: See struct u64_stats_sync
+ * @q_stats: See union idpf_rx_queue_stats
  * @q_id: Queue id
- * @desc_count: Number of descriptors
- * @next_to_use: Next descriptor to use. Relevant in both split & single txq
- *		 and bufq.
- * @next_to_clean: Next descriptor to clean. In split queue model, only
- *		   relevant to TX completion queue and RX queue.
- * @next_to_alloc: RX buffer to allocate at. Used only for RX. In splitq model
- *		   only relevant to RX queue.
+ * @size: Length of descriptor ring in bytes
+ * @dma: Physical address of ring
+ * @q_vector: Backreference to associated vector
+ * @rx_buffer_low_watermark: RX buffer low watermark
+ * @rx_hbuf_size: Header buffer size
+ * @rx_buf_size: Buffer size
+ * @rx_max_pkt_size: RX max packet size
+ */
+struct idpf_rx_queue {
+	union {
+		union virtchnl2_rx_desc *rx;
+		struct virtchnl2_singleq_rx_buf_desc *single_buf;
+
+		void *desc_ring;
+	};
+	union {
+		struct {
+			struct idpf_bufq_set *bufq_sets;
+			struct napi_struct *napi;
+		};
+		struct {
+			struct idpf_rx_buf *rx_buf;
+			struct page_pool *pp;
+		};
+	};
+	struct net_device *netdev;
+	void __iomem *tail;
+
+	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
+	u16 idx;
+	u16 desc_count;
+	u16 next_to_use;
+	u16 next_to_clean;
+	u16 next_to_alloc;
+
+	u32 rxdids;
+
+	const struct idpf_rx_ptype_decoded *rx_ptype_lkup;
+	struct sk_buff *skb;
+
+	struct u64_stats_sync stats_sync;
+	struct idpf_rx_queue_stats q_stats;
+
+	/* Slowpath */
+	u32 q_id;
+	u32 size;
+	dma_addr_t dma;
+
+	struct idpf_q_vector *q_vector;
+
+	u16 rx_buffer_low_watermark;
+	u16 rx_hbuf_size;
+	u16 rx_buf_size;
+	u16 rx_max_pkt_size;
+} ____cacheline_aligned;
+
+/**
+ * struct idpf_tx_queue - software structure representing a transmit queue
+ * @base_tx: base Tx descriptor array
+ * @base_ctx: base Tx context descriptor array
+ * @flex_tx: flex Tx descriptor array
+ * @flex_ctx: flex Tx context descriptor array
+ * @desc_ring: virtual descriptor ring address
+ * @tx_buf: See struct idpf_tx_buf
+ * @txq_grp: See struct idpf_txq_group
+ * @dev: Device back pointer for DMA mapping
+ * @tail: Tail offset. Used for both queue models single and split
  * @flags: See enum idpf_queue_flags_t
- * @q_stats: See union idpf_queue_stats
- * @stats_sync: See struct u64_stats_sync
+ * @idx: For TX queue, it is used as index to map between TX queue group and
+ *	 hot path TX pointers stored in vport. Used in both singleq/splitq.
+ * @desc_count: Number of descriptors
+ * @next_to_use: Next descriptor to use
+ * @next_to_clean: Next descriptor to clean
+ * @netdev: &net_device corresponding to this queue
  * @cleaned_bytes: Splitq only, TXQ only: When a TX completion is received on
  *		   the TX completion queue, it can be for any TXQ associated
  *		   with that completion queue. This means we can clean up to
@@ -644,26 +715,10 @@ union idpf_queue_stats {
  *		   that single call to clean the completion queue. By doing so,
  *		   we can update BQL with aggregate cleaned stats for each TXQ
  *		   only once at the end of the cleaning routine.
+ * @clean_budget: singleq only, queue cleaning budget
  * @cleaned_pkts: Number of packets cleaned for the above said case
- * @rx_hsplit_en: RX headsplit enable
- * @rx_hbuf_size: Header buffer size
- * @rx_buf_size: Buffer size
- * @rx_max_pkt_size: RX max packet size
- * @rx_buf_stride: RX buffer stride
- * @rx_buffer_low_watermark: RX buffer low watermark
- * @rxdids: Supported RX descriptor ids
- * @q_vector: Backreference to associated vector
- * @size: Length of descriptor ring in bytes
- * @dma: Physical address of ring
- * @desc_ring: Descriptor ring memory
  * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @tx_min_pkt_len: Min supported packet length
- * @num_completions: Only relevant for TX completion queue. It tracks the
- *		     number of completions received to compare against the
- *		     number of completions pending, as accumulated by the
- *		     TX queues.
- * @buf_stack: Stack of empty buffers to store buffer info for out of order
- *	       buffer completions. See struct idpf_buf_lifo.
  * @compl_tag_bufid_m: Completion tag buffer id mask
  * @compl_tag_gen_s: Completion tag generation bit
  *	The format of the completion tag will change based on the TXQ
@@ -687,106 +742,188 @@ union idpf_queue_stats {
  *	This gives us 8*8160 = 65280 possible unique values.
  * @compl_tag_cur_gen: Used to keep track of current completion tag generation
  * @compl_tag_gen_max: To determine when compl_tag_cur_gen should be reset
- * @sched_buf_hash: Hash table to stores buffers
+ * @stash: Tx buffer stash for Flow-based scheduling mode
+ * @stats_sync: See struct u64_stats_sync
+ * @q_stats: See union idpf_tx_queue_stats
+ * @q_id: Queue id
+ * @size: Length of descriptor ring in bytes
+ * @dma: Physical address of ring
+ * @q_vector: Backreference to associated vector
  */
-struct idpf_queue {
-	struct device *dev;
-	struct idpf_vport *vport;
+struct idpf_tx_queue {
 	union {
-		struct idpf_txq_group *txq_grp;
-		struct idpf_rxq_group *rxq_grp;
+		struct idpf_base_tx_desc *base_tx;
+		struct idpf_base_tx_ctx_desc *base_ctx;
+		union idpf_tx_flex_desc *flex_tx;
+		struct idpf_flex_tx_ctx_desc *flex_ctx;
+
+		void *desc_ring;
 	};
-	u16 idx;
+	struct idpf_tx_buf *tx_buf;
+	struct idpf_txq_group *txq_grp;
+	struct device *dev;
 	void __iomem *tail;
+
+	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
+	u16 idx;
+	u16 desc_count;
+	u16 next_to_use;
+	u16 next_to_clean;
+
+	struct net_device *netdev;
+
 	union {
-		struct idpf_tx_buf *tx_buf;
-		struct {
-			struct idpf_rx_buf *buf;
-			dma_addr_t hdr_buf_pa;
-			void *hdr_buf_va;
-		} rx_buf;
+		u32 cleaned_bytes;
+		u32 clean_budget;
 	};
-	struct page_pool *pp;
-	struct sk_buff *skb;
-	u16 q_type;
+	u16 cleaned_pkts;
+
+	u16 tx_max_bufs;
+	u16 tx_min_pkt_len;
+
+	u16 compl_tag_bufid_m;
+	u16 compl_tag_gen_s;
+
+	u16 compl_tag_cur_gen;
+	u16 compl_tag_gen_max;
+
+	struct idpf_txq_stash *stash;
+
+	struct u64_stats_sync stats_sync;
+	struct idpf_tx_queue_stats q_stats;
+
+	/* Slowpath */
 	u32 q_id;
-	u16 desc_count;
+	u32 size;
+	dma_addr_t dma;
 
+	struct idpf_q_vector *q_vector;
+} ____cacheline_aligned;
+
+/**
+ * struct idpf_buf_queue - software structure representing a buffer queue
+ * @split_buf: buffer descriptor array
+ * @rx_buf: Struct with RX buffer related members
+ * @rx_buf.buf: See struct idpf_rx_buf
+ * @rx_buf.hdr_buf_pa: DMA handle
+ * @rx_buf.hdr_buf_va: Virtual address
+ * @pp: Page pool pointer
+ * @tail: Tail offset
+ * @flags: See enum idpf_queue_flags_t
+ * @desc_count: Number of descriptors
+ * @next_to_use: Next descriptor to use
+ * @next_to_clean: Next descriptor to clean
+ * @next_to_alloc: RX buffer to allocate at
+ * @q_id: Queue id
+ * @size: Length of descriptor ring in bytes
+ * @dma: Physical address of ring
+ * @q_vector: Backreference to associated vector
+ * @rx_buffer_low_watermark: RX buffer low watermark
+ * @rx_hbuf_size: Header buffer size
+ * @rx_buf_size: Buffer size
+ */
+struct idpf_buf_queue {
+	struct virtchnl2_splitq_rx_buf_desc *split_buf;
+	struct {
+		struct idpf_rx_buf *buf;
+		dma_addr_t hdr_buf_pa;
+		void *hdr_buf_va;
+	} rx_buf;
+	struct page_pool *pp;
+	void __iomem *tail;
+
+	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
+	u16 desc_count;
 	u16 next_to_use;
 	u16 next_to_clean;
 	u16 next_to_alloc;
-	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
 
-	union idpf_queue_stats q_stats;
-	struct u64_stats_sync stats_sync;
+	/* Slowpath */
+	u32 q_id;
+	u32 size;
+	dma_addr_t dma;
 
-	u32 cleaned_bytes;
-	u16 cleaned_pkts;
+	struct idpf_q_vector *q_vector;
 
-	bool rx_hsplit_en;
+	u16 rx_buffer_low_watermark;
 	u16 rx_hbuf_size;
 	u16 rx_buf_size;
-	u16 rx_max_pkt_size;
-	u16 rx_buf_stride;
-	u8 rx_buffer_low_watermark;
-	u64 rxdids;
-	struct idpf_q_vector *q_vector;
-	unsigned int size;
-	dma_addr_t dma;
-	void *desc_ring;
-
-	u16 tx_max_bufs;
-	u8 tx_min_pkt_len;
+} ____cacheline_aligned;
 
-	u32 num_completions;
+/**
+ * struct idpf_compl_queue - software structure representing a completion queue
+ * @comp: completion descriptor array
+ * @txq_grp: See struct idpf_txq_group
+ * @flags: See enum idpf_queue_flags_t
+ * @desc_count: Number of descriptors
+ * @next_to_use: Next descriptor to use. Relevant in both split & single txq
+ *		 and bufq.
+ * @next_to_clean: Next descriptor to clean
+ * @netdev: &net_device corresponding to this queue
+ * @clean_budget: queue cleaning budget
+ * @num_completions: Only relevant for TX completion queue. It tracks the
+ *		     number of completions received to compare against the
+ *		     number of completions pending, as accumulated by the
+ *		     TX queues.
+ * @q_id: Queue id
+ * @size: Length of descriptor ring in bytes
+ * @dma: Physical address of ring
+ * @q_vector: Backreference to associated vector
+ */
+struct idpf_compl_queue {
+	struct idpf_splitq_tx_compl_desc *comp;
+	struct idpf_txq_group *txq_grp;
 
-	struct idpf_buf_lifo buf_stack;
+	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
+	u16 desc_count;
+	u16 next_to_use;
+	u16 next_to_clean;
 
-	u16 compl_tag_bufid_m;
-	u16 compl_tag_gen_s;
+	struct net_device *netdev;
+	u32 clean_budget;
+	u32 num_completions;
 
-	u16 compl_tag_cur_gen;
-	u16 compl_tag_gen_max;
+	/* Slowpath */
+	u32 q_id;
+	u32 size;
+	dma_addr_t dma;
 
-	DECLARE_HASHTABLE(sched_buf_hash, 12);
-} ____cacheline_internodealigned_in_smp;
+	struct idpf_q_vector *q_vector;
+} ____cacheline_aligned;
 
 /**
  * struct idpf_sw_queue
- * @next_to_clean: Next descriptor to clean
- * @next_to_alloc: Buffer to allocate at
- * @flags: See enum idpf_queue_flags_t
  * @ring: Pointer to the ring
+ * @flags: See enum idpf_queue_flags_t
  * @desc_count: Descriptor count
- * @dev: Device back pointer for DMA mapping
+ * @next_to_use: Buffer to allocate at
+ * @next_to_clean: Next descriptor to clean
  *
  * Software queues are used in splitq mode to manage buffers between rxq
  * producer and the bufq consumer.  These are required in order to maintain a
  * lockless buffer management system and are strictly software only constructs.
  */
 struct idpf_sw_queue {
-	u16 next_to_clean;
-	u16 next_to_alloc;
+	u32 *ring;
+
 	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
-	u16 *ring;
 	u16 desc_count;
-	struct device *dev;
-} ____cacheline_internodealigned_in_smp;
+	u16 next_to_use;
+	u16 next_to_clean;
+} ____cacheline_aligned;
 
 /**
  * struct idpf_rxq_set
  * @rxq: RX queue
- * @refillq0: Pointer to refill queue 0
- * @refillq1: Pointer to refill queue 1
+ * @refillq: pointers to refill queues
  *
  * Splitq only.  idpf_rxq_set associates an rxq with at an array of refillqs.
  * Each rxq needs a refillq to return used buffers back to the respective bufq.
  * Bufqs then clean these refillqs for buffers to give to hardware.
  */
 struct idpf_rxq_set {
-	struct idpf_queue rxq;
-	struct idpf_sw_queue *refillq0;
-	struct idpf_sw_queue *refillq1;
+	struct idpf_rx_queue rxq;
+	struct idpf_sw_queue *refillq[IDPF_MAX_BUFQS_PER_RXQ_GRP];
 };
 
 /**
@@ -805,7 +942,7 @@ struct idpf_rxq_set {
  * managed by at most two bufqs (depending on performance configuration).
  */
 struct idpf_bufq_set {
-	struct idpf_queue bufq;
+	struct idpf_buf_queue bufq;
 	int num_refillqs;
 	struct idpf_sw_queue *refillqs;
 };
@@ -831,7 +968,7 @@ struct idpf_rxq_group {
 	union {
 		struct {
 			u16 num_rxq;
-			struct idpf_queue *rxqs[IDPF_LARGE_MAX_Q];
+			struct idpf_rx_queue *rxqs[IDPF_LARGE_MAX_Q];
 		} singleq;
 		struct {
 			u16 num_rxq_sets;
@@ -846,6 +983,7 @@ struct idpf_rxq_group {
  * @vport: Vport back pointer
  * @num_txq: Number of TX queues associated
  * @txqs: Array of TX queue pointers
+ * @stashes: array of OOO stashes for the queues
  * @complq: Associated completion queue pointer, split queue only
  * @num_completions_pending: Total number of completions pending for the
  *			     completion queue, acculumated for all TX queues
@@ -859,9 +997,10 @@ struct idpf_txq_group {
 	struct idpf_vport *vport;
 
 	u16 num_txq;
-	struct idpf_queue *txqs[IDPF_LARGE_MAX_Q];
+	struct idpf_tx_queue *txqs[IDPF_LARGE_MAX_Q];
+	struct idpf_txq_stash *stashes;
 
-	struct idpf_queue *complq;
+	struct idpf_compl_queue *complq;
 
 	u32 num_completions_pending;
 };
@@ -998,29 +1137,31 @@ void idpf_deinit_rss(struct idpf_vport *vport);
 int idpf_rx_bufs_init_all(struct idpf_vport *vport);
 void idpf_rx_add_frag(struct idpf_rx_buf *rx_buf, struct sk_buff *skb,
 		      unsigned int size);
-struct sk_buff *idpf_rx_construct_skb(struct idpf_queue *rxq,
+struct sk_buff *idpf_rx_construct_skb(const struct idpf_rx_queue *rxq,
 				      struct idpf_rx_buf *rx_buf,
 				      unsigned int size);
-bool idpf_init_rx_buf_hw_alloc(struct idpf_queue *rxq, struct idpf_rx_buf *buf);
-void idpf_rx_buf_hw_update(struct idpf_queue *rxq, u32 val);
-void idpf_tx_buf_hw_update(struct idpf_queue *tx_q, u32 val,
+void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
 			   bool xmit_more);
 unsigned int idpf_size_to_txd_count(unsigned int size);
-netdev_tx_t idpf_tx_drop_skb(struct idpf_queue *tx_q, struct sk_buff *skb);
-void idpf_tx_dma_map_error(struct idpf_queue *txq, struct sk_buff *skb,
+netdev_tx_t idpf_tx_drop_skb(struct idpf_tx_queue *tx_q, struct sk_buff *skb);
+void idpf_tx_dma_map_error(struct idpf_tx_queue *txq, struct sk_buff *skb,
 			   struct idpf_tx_buf *first, u16 ring_idx);
-unsigned int idpf_tx_desc_count_required(struct idpf_queue *txq,
+unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
 					 struct sk_buff *skb);
-bool idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs,
-			unsigned int count);
-int idpf_tx_maybe_stop_common(struct idpf_queue *tx_q, unsigned int size);
 void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue);
-netdev_tx_t idpf_tx_splitq_start(struct sk_buff *skb,
-				 struct net_device *netdev);
-netdev_tx_t idpf_tx_singleq_start(struct sk_buff *skb,
-				  struct net_device *netdev);
-bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_queue *rxq,
+netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
+				  struct idpf_tx_queue *tx_q);
+netdev_tx_t idpf_tx_start(struct sk_buff *skb, struct net_device *netdev);
+bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rxq,
 				      u16 cleaned_count);
 int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off);
 
+static inline bool idpf_tx_maybe_stop_common(struct idpf_tx_queue *tx_q,
+					     u32 needed)
+{
+	return !netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
+					  IDPF_DESC_UNUSED(tx_q),
+					  needed, needed);
+}
+
 #endif /* !_IDPF_TXRX_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index a5f9b7a5effe..44602b87cd41 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -750,7 +750,7 @@ static int idpf_wait_for_marker_event(struct idpf_vport *vport)
 	int i;
 
 	for (i = 0; i < vport->num_txq; i++)
-		set_bit(__IDPF_Q_SW_MARKER, vport->txqs[i]->flags);
+		idpf_queue_set(SW_MARKER, vport->txqs[i]);
 
 	event = wait_event_timeout(vport->sw_marker_wq,
 				   test_and_clear_bit(IDPF_VPORT_SW_MARKER,
@@ -758,7 +758,7 @@ static int idpf_wait_for_marker_event(struct idpf_vport *vport)
 				   msecs_to_jiffies(500));
 
 	for (i = 0; i < vport->num_txq; i++)
-		clear_bit(__IDPF_Q_POLL_MODE, vport->txqs[i]->flags);
+		idpf_queue_clear(POLL_MODE, vport->txqs[i]);
 
 	if (event)
 		return 0;
@@ -1092,7 +1092,6 @@ static int __idpf_queue_reg_init(struct idpf_vport *vport, u32 *reg_vals,
 				 int num_regs, u32 q_type)
 {
 	struct idpf_adapter *adapter = vport->adapter;
-	struct idpf_queue *q;
 	int i, j, k = 0;
 
 	switch (q_type) {
@@ -1111,6 +1110,8 @@ static int __idpf_queue_reg_init(struct idpf_vport *vport, u32 *reg_vals,
 			u16 num_rxq = rx_qgrp->singleq.num_rxq;
 
 			for (j = 0; j < num_rxq && k < num_regs; j++, k++) {
+				struct idpf_rx_queue *q;
+
 				q = rx_qgrp->singleq.rxqs[j];
 				q->tail = idpf_get_reg_addr(adapter,
 							    reg_vals[k]);
@@ -1123,6 +1124,8 @@ static int __idpf_queue_reg_init(struct idpf_vport *vport, u32 *reg_vals,
 			u8 num_bufqs = vport->num_bufqs_per_qgrp;
 
 			for (j = 0; j < num_bufqs && k < num_regs; j++, k++) {
+				struct idpf_buf_queue *q;
+
 				q = &rx_qgrp->splitq.bufq_sets[j].bufq;
 				q->tail = idpf_get_reg_addr(adapter,
 							    reg_vals[k]);
@@ -1449,19 +1452,19 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
 			qi[k].model =
 				cpu_to_le16(vport->txq_model);
 			qi[k].type =
-				cpu_to_le32(tx_qgrp->txqs[j]->q_type);
+				cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_TX);
 			qi[k].ring_len =
 				cpu_to_le16(tx_qgrp->txqs[j]->desc_count);
 			qi[k].dma_ring_addr =
 				cpu_to_le64(tx_qgrp->txqs[j]->dma);
 			if (idpf_is_queue_model_split(vport->txq_model)) {
-				struct idpf_queue *q = tx_qgrp->txqs[j];
+				struct idpf_tx_queue *q = tx_qgrp->txqs[j];
 
 				qi[k].tx_compl_queue_id =
 					cpu_to_le16(tx_qgrp->complq->q_id);
 				qi[k].relative_queue_id = cpu_to_le16(j);
 
-				if (test_bit(__IDPF_Q_FLOW_SCH_EN, q->flags))
+				if (idpf_queue_has(FLOW_SCH_EN, q))
 					qi[k].sched_mode =
 					cpu_to_le16(VIRTCHNL2_TXQ_SCHED_MODE_FLOW);
 				else
@@ -1478,11 +1481,11 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
 
 		qi[k].queue_id = cpu_to_le32(tx_qgrp->complq->q_id);
 		qi[k].model = cpu_to_le16(vport->txq_model);
-		qi[k].type = cpu_to_le32(tx_qgrp->complq->q_type);
+		qi[k].type = cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION);
 		qi[k].ring_len = cpu_to_le16(tx_qgrp->complq->desc_count);
 		qi[k].dma_ring_addr = cpu_to_le64(tx_qgrp->complq->dma);
 
-		if (test_bit(__IDPF_Q_FLOW_SCH_EN, tx_qgrp->complq->flags))
+		if (idpf_queue_has(FLOW_SCH_EN, tx_qgrp->complq))
 			sched_mode = VIRTCHNL2_TXQ_SCHED_MODE_FLOW;
 		else
 			sched_mode = VIRTCHNL2_TXQ_SCHED_MODE_QUEUE;
@@ -1567,17 +1570,18 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 			goto setup_rxqs;
 
 		for (j = 0; j < vport->num_bufqs_per_qgrp; j++, k++) {
-			struct idpf_queue *bufq =
+			struct idpf_buf_queue *bufq =
 				&rx_qgrp->splitq.bufq_sets[j].bufq;
 
 			qi[k].queue_id = cpu_to_le32(bufq->q_id);
 			qi[k].model = cpu_to_le16(vport->rxq_model);
-			qi[k].type = cpu_to_le32(bufq->q_type);
+			qi[k].type =
+				cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_RX_BUFFER);
 			qi[k].desc_ids = cpu_to_le64(VIRTCHNL2_RXDID_2_FLEX_SPLITQ_M);
 			qi[k].ring_len = cpu_to_le16(bufq->desc_count);
 			qi[k].dma_ring_addr = cpu_to_le64(bufq->dma);
 			qi[k].data_buffer_size = cpu_to_le32(bufq->rx_buf_size);
-			qi[k].buffer_notif_stride = bufq->rx_buf_stride;
+			qi[k].buffer_notif_stride = IDPF_RX_BUF_STRIDE;
 			qi[k].rx_buffer_low_watermark =
 				cpu_to_le16(bufq->rx_buffer_low_watermark);
 			if (idpf_is_feature_ena(vport, NETIF_F_GRO_HW))
@@ -1591,7 +1595,7 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 			num_rxq = rx_qgrp->singleq.num_rxq;
 
 		for (j = 0; j < num_rxq; j++, k++) {
-			struct idpf_queue *rxq;
+			struct idpf_rx_queue *rxq;
 
 			if (!idpf_is_queue_model_split(vport->rxq_model)) {
 				rxq = rx_qgrp->singleq.rxqs[j];
@@ -1599,11 +1603,11 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 			}
 			rxq = &rx_qgrp->splitq.rxq_sets[j]->rxq;
 			qi[k].rx_bufq1_id =
-			  cpu_to_le16(rxq->rxq_grp->splitq.bufq_sets[0].bufq.q_id);
+			  cpu_to_le16(rxq->bufq_sets[0].bufq.q_id);
 			if (vport->num_bufqs_per_qgrp > IDPF_SINGLE_BUFQ_PER_RXQ_GRP) {
 				qi[k].bufq2_ena = IDPF_BUFQ2_ENA;
 				qi[k].rx_bufq2_id =
-				  cpu_to_le16(rxq->rxq_grp->splitq.bufq_sets[1].bufq.q_id);
+				  cpu_to_le16(rxq->bufq_sets[1].bufq.q_id);
 			}
 			qi[k].rx_buffer_low_watermark =
 				cpu_to_le16(rxq->rx_buffer_low_watermark);
@@ -1611,7 +1615,7 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 				qi[k].qflags |= cpu_to_le16(VIRTCHNL2_RXQ_RSC);
 
 common_qi_fields:
-			if (rxq->rx_hsplit_en) {
+			if (idpf_queue_has(HSPLIT_EN, rxq)) {
 				qi[k].qflags |=
 					cpu_to_le16(VIRTCHNL2_RXQ_HDR_SPLIT);
 				qi[k].hdr_buffer_size =
@@ -1619,7 +1623,7 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 			}
 			qi[k].queue_id = cpu_to_le32(rxq->q_id);
 			qi[k].model = cpu_to_le16(vport->rxq_model);
-			qi[k].type = cpu_to_le32(rxq->q_type);
+			qi[k].type = cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_RX);
 			qi[k].ring_len = cpu_to_le16(rxq->desc_count);
 			qi[k].dma_ring_addr = cpu_to_le64(rxq->dma);
 			qi[k].max_pkt_size = cpu_to_le32(rxq->rx_max_pkt_size);
@@ -1706,7 +1710,7 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool ena)
 		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
 
 		for (j = 0; j < tx_qgrp->num_txq; j++, k++) {
-			qc[k].type = cpu_to_le32(tx_qgrp->txqs[j]->q_type);
+			qc[k].type = cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_TX);
 			qc[k].start_queue_id = cpu_to_le32(tx_qgrp->txqs[j]->q_id);
 			qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
 		}
@@ -1720,7 +1724,7 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool ena)
 	for (i = 0; i < vport->num_txq_grp; i++, k++) {
 		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
 
-		qc[k].type = cpu_to_le32(tx_qgrp->complq->q_type);
+		qc[k].type = cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION);
 		qc[k].start_queue_id = cpu_to_le32(tx_qgrp->complq->q_id);
 		qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
 	}
@@ -1741,12 +1745,12 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool ena)
 				qc[k].start_queue_id =
 				cpu_to_le32(rx_qgrp->splitq.rxq_sets[j]->rxq.q_id);
 				qc[k].type =
-				cpu_to_le32(rx_qgrp->splitq.rxq_sets[j]->rxq.q_type);
+				cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_RX);
 			} else {
 				qc[k].start_queue_id =
 				cpu_to_le32(rx_qgrp->singleq.rxqs[j]->q_id);
 				qc[k].type =
-				cpu_to_le32(rx_qgrp->singleq.rxqs[j]->q_type);
+				cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_RX);
 			}
 			qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
 		}
@@ -1761,10 +1765,11 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool ena)
 		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
 
 		for (j = 0; j < vport->num_bufqs_per_qgrp; j++, k++) {
-			struct idpf_queue *q;
+			const struct idpf_buf_queue *q;
 
 			q = &rx_qgrp->splitq.bufq_sets[j].bufq;
-			qc[k].type = cpu_to_le32(q->q_type);
+			qc[k].type =
+				cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_RX_BUFFER);
 			qc[k].start_queue_id = cpu_to_le32(q->q_id);
 			qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
 		}
@@ -1849,7 +1854,8 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
 
 		for (j = 0; j < tx_qgrp->num_txq; j++, k++) {
-			vqv[k].queue_type = cpu_to_le32(tx_qgrp->txqs[j]->q_type);
+			vqv[k].queue_type =
+				cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_TX);
 			vqv[k].queue_id = cpu_to_le32(tx_qgrp->txqs[j]->q_id);
 
 			if (idpf_is_queue_model_split(vport->txq_model)) {
@@ -1879,14 +1885,15 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 			num_rxq = rx_qgrp->singleq.num_rxq;
 
 		for (j = 0; j < num_rxq; j++, k++) {
-			struct idpf_queue *rxq;
+			struct idpf_rx_queue *rxq;
 
 			if (idpf_is_queue_model_split(vport->rxq_model))
 				rxq = &rx_qgrp->splitq.rxq_sets[j]->rxq;
 			else
 				rxq = rx_qgrp->singleq.rxqs[j];
 
-			vqv[k].queue_type = cpu_to_le32(rxq->q_type);
+			vqv[k].queue_type =
+				cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_RX);
 			vqv[k].queue_id = cpu_to_le32(rxq->q_id);
 			vqv[k].vector_id = cpu_to_le16(rxq->q_vector->v_idx);
 			vqv[k].itr_idx = cpu_to_le32(rxq->q_vector->rx_itr_idx);
@@ -1975,7 +1982,7 @@ int idpf_send_disable_queues_msg(struct idpf_vport *vport)
 	 * queues virtchnl message is sent
 	 */
 	for (i = 0; i < vport->num_txq; i++)
-		set_bit(__IDPF_Q_POLL_MODE, vport->txqs[i]->flags);
+		idpf_queue_set(POLL_MODE, vport->txqs[i]);
 
 	/* schedule the napi to receive all the marker packets */
 	local_bh_disable();
@@ -3242,7 +3249,6 @@ static int __idpf_vport_queue_ids_init(struct idpf_vport *vport,
 				       int num_qids,
 				       u32 q_type)
 {
-	struct idpf_queue *q;
 	int i, j, k = 0;
 
 	switch (q_type) {
@@ -3250,11 +3256,8 @@ static int __idpf_vport_queue_ids_init(struct idpf_vport *vport,
 		for (i = 0; i < vport->num_txq_grp; i++) {
 			struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
 
-			for (j = 0; j < tx_qgrp->num_txq && k < num_qids; j++, k++) {
+			for (j = 0; j < tx_qgrp->num_txq && k < num_qids; j++, k++)
 				tx_qgrp->txqs[j]->q_id = qids[k];
-				tx_qgrp->txqs[j]->q_type =
-					VIRTCHNL2_QUEUE_TYPE_TX;
-			}
 		}
 		break;
 	case VIRTCHNL2_QUEUE_TYPE_RX:
@@ -3268,12 +3271,13 @@ static int __idpf_vport_queue_ids_init(struct idpf_vport *vport,
 				num_rxq = rx_qgrp->singleq.num_rxq;
 
 			for (j = 0; j < num_rxq && k < num_qids; j++, k++) {
+				struct idpf_rx_queue *q;
+
 				if (idpf_is_queue_model_split(vport->rxq_model))
 					q = &rx_qgrp->splitq.rxq_sets[j]->rxq;
 				else
 					q = rx_qgrp->singleq.rxqs[j];
 				q->q_id = qids[k];
-				q->q_type = VIRTCHNL2_QUEUE_TYPE_RX;
 			}
 		}
 		break;
@@ -3282,8 +3286,6 @@ static int __idpf_vport_queue_ids_init(struct idpf_vport *vport,
 			struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
 
 			tx_qgrp->complq->q_id = qids[k];
-			tx_qgrp->complq->q_type =
-				VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION;
 		}
 		break;
 	case VIRTCHNL2_QUEUE_TYPE_RX_BUFFER:
@@ -3292,9 +3294,10 @@ static int __idpf_vport_queue_ids_init(struct idpf_vport *vport,
 			u8 num_bufqs = vport->num_bufqs_per_qgrp;
 
 			for (j = 0; j < num_bufqs && k < num_qids; j++, k++) {
+				struct idpf_buf_queue *q;
+
 				q = &rx_qgrp->splitq.bufq_sets[j].bufq;
 				q->q_id = qids[k];
-				q->q_type = VIRTCHNL2_QUEUE_TYPE_RX_BUFFER;
 			}
 		}
 		break;
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 1f74317beb88..e1e5d9672ae4 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1060,6 +1060,7 @@ static void rtl8125a_2_hw_phy_config(struct rtl8169_private *tp,
 	phy_modify_paged(phydev, 0xa86, 0x15, 0x0001, 0x0000);
 	rtl8168g_enable_gphy_10m(phydev);
 
+	rtl8168g_disable_aldps(phydev);
 	rtl8125a_config_eee_phy(phydev);
 }
 
@@ -1099,6 +1100,7 @@ static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
 	phy_modify_paged(phydev, 0xbf8, 0x12, 0xe000, 0xa000);
 
 	rtl8125_legacy_force_mode(phydev);
+	rtl8168g_disable_aldps(phydev);
 	rtl8125b_config_eee_phy(phydev);
 }
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 4d100283c30f..067357b2495c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -530,8 +530,16 @@ static void ravb_emac_init_gbeth(struct net_device *ndev)
 
 static void ravb_emac_init_rcar(struct net_device *ndev)
 {
-	/* Receive frame limit set register */
-	ravb_write(ndev, ndev->mtu + ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN, RFLR);
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	/* Set receive frame length
+	 *
+	 * The length set here describes the frame from the destination address
+	 * up to and including the CRC data. However only the frame data,
+	 * excluding the CRC, are transferred to memory. To allow for the
+	 * largest frames add the CRC length to the maximum Rx descriptor size.
+	 */
+	ravb_write(ndev, priv->info->rx_max_frame_size + ETH_FCS_LEN, RFLR);
 
 	/* EMAC Mode: PAUSE prohibition; Duplex; RX Checksum; TX; RX */
 	ravb_write(ndev, ECMR_ZPF | ECMR_DM |
diff --git a/drivers/net/ethernet/seeq/ether3.c b/drivers/net/ethernet/seeq/ether3.c
index c672f92d65e9..9319a2675e7b 100644
--- a/drivers/net/ethernet/seeq/ether3.c
+++ b/drivers/net/ethernet/seeq/ether3.c
@@ -847,9 +847,11 @@ static void ether3_remove(struct expansion_card *ec)
 {
 	struct net_device *dev = ecard_get_drvdata(ec);
 
+	ether3_outw(priv(dev)->regs.config2 |= CFG2_CTRLO, REG_CONFIG2);
 	ecard_set_drvdata(ec, NULL);
 
 	unregister_netdev(dev);
+	del_timer_sync(&priv(dev)->timer);
 	free_netdev(dev);
 	ecard_release_resources(ec);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 9e40c28d453a..ee3604f58def 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -35,6 +35,9 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
 	/* Disable RX queues routing by default */
 	plat->rx_queues_cfg[0].pkt_route = 0x0;
 
+	plat->clk_ref_rate = 125000000;
+	plat->clk_ptp_rate = 125000000;
+
 	/* Default to phy auto-detection */
 	plat->phy_addr = -1;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 33e2bd5a351c..3b1bb6aa5b8c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2025,7 +2025,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	rx_q->queue_index = queue;
 	rx_q->priv_data = priv;
 
-	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	pp_params.flags = PP_FLAG_DMA_MAP | (xdp_prog ? PP_FLAG_DMA_SYNC_DEV : 0);
 	pp_params.pool_size = dma_conf->dma_rx_size;
 	num_pages = DIV_ROUND_UP(dma_conf->dma_buf_sz, PAGE_SIZE);
 	pp_params.order = ilog2(num_pages);
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 88d7bc2ea713..f1d928644b82 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -674,15 +674,15 @@ static int axienet_device_reset(struct net_device *ndev)
  *
  * Would either be called after a successful transmit operation, or after
  * there was an error when setting up the chain.
- * Returns the number of descriptors handled.
+ * Returns the number of packets handled.
  */
 static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 				 int nr_bds, bool force, u32 *sizep, int budget)
 {
 	struct axidma_bd *cur_p;
 	unsigned int status;
+	int i, packets = 0;
 	dma_addr_t phys;
-	int i;
 
 	for (i = 0; i < nr_bds; i++) {
 		cur_p = &lp->tx_bd_v[(first_bd + i) % lp->tx_bd_num];
@@ -701,8 +701,10 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 				 (cur_p->cntrl & XAXIDMA_BD_CTRL_LENGTH_MASK),
 				 DMA_TO_DEVICE);
 
-		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK))
+		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK)) {
 			napi_consume_skb(cur_p->skb, budget);
+			packets++;
+		}
 
 		cur_p->app0 = 0;
 		cur_p->app1 = 0;
@@ -718,7 +720,13 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 			*sizep += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
 	}
 
-	return i;
+	if (!force) {
+		lp->tx_bd_ci += i;
+		if (lp->tx_bd_ci >= lp->tx_bd_num)
+			lp->tx_bd_ci %= lp->tx_bd_num;
+	}
+
+	return packets;
 }
 
 /**
@@ -891,13 +899,10 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 	u32 size = 0;
 	int packets;
 
-	packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, budget, false, &size, budget);
+	packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, lp->tx_bd_num, false,
+					&size, budget);
 
 	if (packets) {
-		lp->tx_bd_ci += packets;
-		if (lp->tx_bd_ci >= lp->tx_bd_num)
-			lp->tx_bd_ci %= lp->tx_bd_num;
-
 		u64_stats_update_begin(&lp->tx_stat_sync);
 		u64_stats_add(&lp->tx_packets, packets);
 		u64_stats_add(&lp->tx_bytes, size);
@@ -1222,9 +1227,10 @@ static irqreturn_t axienet_tx_irq(int irq, void *_ndev)
 		u32 cr = lp->tx_dma_cr;
 
 		cr &= ~(XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
-		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
-
-		napi_schedule(&lp->napi_tx);
+		if (napi_schedule_prep(&lp->napi_tx)) {
+			axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
+			__napi_schedule(&lp->napi_tx);
+		}
 	}
 
 	return IRQ_HANDLED;
@@ -1266,9 +1272,10 @@ static irqreturn_t axienet_rx_irq(int irq, void *_ndev)
 		u32 cr = lp->rx_dma_cr;
 
 		cr &= ~(XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
-		axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
-
-		napi_schedule(&lp->napi_rx);
+		if (napi_schedule_prep(&lp->napi_rx)) {
+			axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
+			__napi_schedule(&lp->napi_rx);
+		}
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 18eb5ba436df..2506aa8c603e 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -464,10 +464,15 @@ static enum skb_state defer_bh(struct usbnet *dev, struct sk_buff *skb,
 void usbnet_defer_kevent (struct usbnet *dev, int work)
 {
 	set_bit (work, &dev->flags);
-	if (!schedule_work (&dev->kevent))
-		netdev_dbg(dev->net, "kevent %s may have been dropped\n", usbnet_event_names[work]);
-	else
-		netdev_dbg(dev->net, "kevent %s scheduled\n", usbnet_event_names[work]);
+	if (!usbnet_going_away(dev)) {
+		if (!schedule_work(&dev->kevent))
+			netdev_dbg(dev->net,
+				   "kevent %s may have been dropped\n",
+				   usbnet_event_names[work]);
+		else
+			netdev_dbg(dev->net,
+				   "kevent %s scheduled\n", usbnet_event_names[work]);
+	}
 }
 EXPORT_SYMBOL_GPL(usbnet_defer_kevent);
 
@@ -535,7 +540,8 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
 			tasklet_schedule (&dev->bh);
 			break;
 		case 0:
-			__usbnet_queue_skb(&dev->rxq, skb, rx_start);
+			if (!usbnet_going_away(dev))
+				__usbnet_queue_skb(&dev->rxq, skb, rx_start);
 		}
 	} else {
 		netif_dbg(dev, ifdown, dev->net, "rx: stopped\n");
@@ -843,9 +849,18 @@ int usbnet_stop (struct net_device *net)
 
 	/* deferred work (timer, softirq, task) must also stop */
 	dev->flags = 0;
-	del_timer_sync (&dev->delay);
-	tasklet_kill (&dev->bh);
+	del_timer_sync(&dev->delay);
+	tasklet_kill(&dev->bh);
 	cancel_work_sync(&dev->kevent);
+
+	/* We have cyclic dependencies. Those calls are needed
+	 * to break a cycle. We cannot fall into the gaps because
+	 * we have a flag
+	 */
+	tasklet_kill(&dev->bh);
+	del_timer_sync(&dev->delay);
+	cancel_work_sync(&dev->kevent);
+
 	if (!pm)
 		usb_autopm_put_interface(dev->intf);
 
@@ -1171,7 +1186,8 @@ usbnet_deferred_kevent (struct work_struct *work)
 					   status);
 		} else {
 			clear_bit (EVENT_RX_HALT, &dev->flags);
-			tasklet_schedule (&dev->bh);
+			if (!usbnet_going_away(dev))
+				tasklet_schedule(&dev->bh);
 		}
 	}
 
@@ -1196,7 +1212,8 @@ usbnet_deferred_kevent (struct work_struct *work)
 			usb_autopm_put_interface(dev->intf);
 fail_lowmem:
 			if (resched)
-				tasklet_schedule (&dev->bh);
+				if (!usbnet_going_away(dev))
+					tasklet_schedule(&dev->bh);
 		}
 	}
 
@@ -1559,6 +1576,7 @@ static void usbnet_bh (struct timer_list *t)
 	} else if (netif_running (dev->net) &&
 		   netif_device_present (dev->net) &&
 		   netif_carrier_ok(dev->net) &&
+		   !usbnet_going_away(dev) &&
 		   !timer_pending(&dev->delay) &&
 		   !test_bit(EVENT_RX_PAUSED, &dev->flags) &&
 		   !test_bit(EVENT_RX_HALT, &dev->flags)) {
@@ -1606,6 +1624,7 @@ void usbnet_disconnect (struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 	if (!dev)
 		return;
+	usbnet_mark_going_away(dev);
 
 	xdev = interface_to_usbdev (intf);
 
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 21bd0c127b05..0b1630bb173a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1439,6 +1439,11 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	struct page *page = virt_to_head_page(buf);
 	struct sk_buff *skb;
 
+	/* We passed the address of virtnet header to virtio-core,
+	 * so truncate the padding.
+	 */
+	buf -= VIRTNET_RX_PAD + xdp_headroom;
+
 	len -= vi->hdr_len;
 	u64_stats_add(&stats->bytes, len);
 
@@ -2029,8 +2034,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	if (unlikely(!buf))
 		return -ENOMEM;
 
-	virtnet_rq_init_one_sg(rq, buf + VIRTNET_RX_PAD + xdp_headroom,
-			       vi->hdr_len + GOOD_PACKET_LEN);
+	buf += VIRTNET_RX_PAD + xdp_headroom;
+
+	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 141ba4487cb4..9d2d3a86abf1 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -396,6 +396,7 @@ struct ath11k_vif {
 	u8 bssid[ETH_ALEN];
 	struct cfg80211_bitrate_mask bitrate_mask;
 	struct delayed_work connection_loss_work;
+	struct work_struct bcn_tx_work;
 	int num_legacy_stations;
 	int rtscts_prot_mode;
 	int txpower;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index eaa53bc39ab2..74719cb78888 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6599,6 +6599,16 @@ static int ath11k_mac_vdev_delete(struct ath11k *ar, struct ath11k_vif *arvif)
 	return ret;
 }
 
+static void ath11k_mac_bcn_tx_work(struct work_struct *work)
+{
+	struct ath11k_vif *arvif = container_of(work, struct ath11k_vif,
+						bcn_tx_work);
+
+	mutex_lock(&arvif->ar->conf_mutex);
+	ath11k_mac_bcn_tx_event(arvif);
+	mutex_unlock(&arvif->ar->conf_mutex);
+}
+
 static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
@@ -6637,6 +6647,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	arvif->vif = vif;
 
 	INIT_LIST_HEAD(&arvif->list);
+	INIT_WORK(&arvif->bcn_tx_work, ath11k_mac_bcn_tx_work);
 	INIT_DELAYED_WORK(&arvif->connection_loss_work,
 			  ath11k_mac_vif_sta_connection_loss_work);
 
@@ -6879,6 +6890,7 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	int i;
 
 	cancel_delayed_work_sync(&arvif->connection_loss_work);
+	cancel_work_sync(&arvif->bcn_tx_work);
 
 	mutex_lock(&ar->conf_mutex);
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 6ff01c45f165..f50a4c0d4b2b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7404,7 +7404,9 @@ static void ath11k_bcn_tx_status_event(struct ath11k_base *ab, struct sk_buff *s
 		rcu_read_unlock();
 		return;
 	}
-	ath11k_mac_bcn_tx_event(arvif);
+
+	queue_work(ab->workqueue, &arvif->bcn_tx_work);
+
 	rcu_read_unlock();
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7037004ce977..818ee74cf7a0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1948,9 +1948,8 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	 * request, then use MAX_AMPDU_LEN_FACTOR as 16 to calculate max_ampdu
 	 * length.
 	 */
-	ampdu_factor = (he_cap->he_cap_elem.mac_cap_info[3] &
-			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK) >>
-			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK;
+	ampdu_factor = u8_get_bits(he_cap->he_cap_elem.mac_cap_info[3],
+				   IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK);
 
 	if (ampdu_factor) {
 		if (sta->deflink.vht_cap.vht_supported)
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ef775af25093..55230dd00d0c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1528,6 +1528,7 @@ int ath12k_wmi_pdev_bss_chan_info_request(struct ath12k *ar,
 	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_PDEV_BSS_CHAN_INFO_REQUEST,
 						 sizeof(*cmd));
 	cmd->req_type = cpu_to_le32(type);
+	cmd->pdev_id = cpu_to_le32(ar->pdev->pdev_id);
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
 		   "WMI bss chan info req type %d\n", type);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 742fe0b36cf2..e947d646353c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3104,6 +3104,7 @@ struct wmi_pdev_bss_chan_info_req_cmd {
 	__le32 tlv_header;
 	/* ref wmi_bss_chan_info_req_type */
 	__le32 req_type;
+	__le32 pdev_id;
 } __packed;
 
 struct wmi_ap_ps_peer_cmd {
@@ -4053,7 +4054,6 @@ struct wmi_vdev_stopped_event {
 } __packed;
 
 struct wmi_pdev_bss_chan_info_event {
-	__le32 pdev_id;
 	__le32 freq;	/* Units in MHz */
 	__le32 noise_floor;	/* units are dBm */
 	/* rx clear - how often the channel was unused */
@@ -4071,6 +4071,7 @@ struct wmi_pdev_bss_chan_info_event {
 	/*rx_cycle cnt for my bss in 64bits format */
 	__le32 rx_bss_cycle_count_low;
 	__le32 rx_bss_cycle_count_high;
+	__le32 pdev_id;
 } __packed;
 
 #define WMI_VDEV_INSTALL_KEY_COMPL_STATUS_SUCCESS 0
diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index d84e3ee7b5d9..bf3da631c69f 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -1380,8 +1380,6 @@ int ath9k_init_debug(struct ath_hw *ah)
 
 	sc->debug.debugfs_phy = debugfs_create_dir("ath9k",
 						   sc->hw->wiphy->debugfsdir);
-	if (IS_ERR(sc->debug.debugfs_phy))
-		return -ENOMEM;
 
 #ifdef CONFIG_ATH_DEBUG
 	debugfs_create_file("debug", 0600, sc->debug.debugfs_phy,
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index f7c6d9bc9311..9437d69877cc 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -486,8 +486,6 @@ int ath9k_htc_init_debug(struct ath_hw *ah)
 
 	priv->debug.debugfs_phy = debugfs_create_dir(KBUILD_MODNAME,
 					     priv->hw->wiphy->debugfsdir);
-	if (IS_ERR(priv->debug.debugfs_phy))
-		return -ENOMEM;
 
 	ath9k_cmn_spectral_init_debug(&priv->spec_priv, priv->debug.debugfs_phy);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
index 7ea2631b8069..00794086cc7c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
@@ -123,7 +123,7 @@ static s32 brcmf_btcoex_params_read(struct brcmf_if *ifp, u32 addr, u32 *data)
 {
 	*data = addr;
 
-	return brcmf_fil_iovar_int_get(ifp, "btc_params", data);
+	return brcmf_fil_iovar_int_query(ifp, "btc_params", data);
 }
 
 /**
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 826b768196e2..ccc069ae5e9d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -663,8 +663,8 @@ static int brcmf_cfg80211_request_sta_if(struct brcmf_if *ifp, u8 *macaddr)
 	/* interface_create version 3+ */
 	/* get supported version from firmware side */
 	iface_create_ver = 0;
-	err = brcmf_fil_bsscfg_int_get(ifp, "interface_create",
-				       &iface_create_ver);
+	err = brcmf_fil_bsscfg_int_query(ifp, "interface_create",
+					 &iface_create_ver);
 	if (err) {
 		brcmf_err("fail to get supported version, err=%d\n", err);
 		return -EOPNOTSUPP;
@@ -756,8 +756,8 @@ static int brcmf_cfg80211_request_ap_if(struct brcmf_if *ifp)
 	/* interface_create version 3+ */
 	/* get supported version from firmware side */
 	iface_create_ver = 0;
-	err = brcmf_fil_bsscfg_int_get(ifp, "interface_create",
-				       &iface_create_ver);
+	err = brcmf_fil_bsscfg_int_query(ifp, "interface_create",
+					 &iface_create_ver);
 	if (err) {
 		brcmf_err("fail to get supported version, err=%d\n", err);
 		return -EOPNOTSUPP;
@@ -2101,7 +2101,8 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 	if (!sme->crypto.n_akm_suites)
 		return 0;
 
-	err = brcmf_fil_bsscfg_int_get(netdev_priv(ndev), "wpa_auth", &val);
+	err = brcmf_fil_bsscfg_int_get(netdev_priv(ndev),
+				       "wpa_auth", &val);
 	if (err) {
 		bphy_err(drvr, "could not get wpa_auth (%d)\n", err);
 		return err;
@@ -2680,7 +2681,7 @@ brcmf_cfg80211_get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_cfg80211_vif *vif = wdev_to_vif(wdev);
 	struct brcmf_pub *drvr = cfg->pub;
-	s32 qdbm = 0;
+	s32 qdbm;
 	s32 err;
 
 	brcmf_dbg(TRACE, "Enter\n");
@@ -3067,7 +3068,7 @@ brcmf_cfg80211_get_station_ibss(struct brcmf_if *ifp,
 	struct brcmf_scb_val_le scbval;
 	struct brcmf_pktcnt_le pktcnt;
 	s32 err;
-	u32 rate = 0;
+	u32 rate;
 	u32 rssi;
 
 	/* Get the current tx rate */
@@ -7046,8 +7047,8 @@ static int brcmf_construct_chaninfo(struct brcmf_cfg80211_info *cfg,
 			ch.bw = BRCMU_CHAN_BW_20;
 			cfg->d11inf.encchspec(&ch);
 			chaninfo = ch.chspec;
-			err = brcmf_fil_bsscfg_int_get(ifp, "per_chan_info",
-						       &chaninfo);
+			err = brcmf_fil_bsscfg_int_query(ifp, "per_chan_info",
+							 &chaninfo);
 			if (!err) {
 				if (chaninfo & WL_CHAN_RADAR)
 					channel->flags |=
@@ -7081,7 +7082,7 @@ static int brcmf_enable_bw40_2g(struct brcmf_cfg80211_info *cfg)
 
 	/* verify support for bw_cap command */
 	val = WLC_BAND_5G;
-	err = brcmf_fil_iovar_int_get(ifp, "bw_cap", &val);
+	err = brcmf_fil_iovar_int_query(ifp, "bw_cap", &val);
 
 	if (!err) {
 		/* only set 2G bandwidth using bw_cap command */
@@ -7157,11 +7158,11 @@ static void brcmf_get_bwcap(struct brcmf_if *ifp, u32 bw_cap[])
 	int err;
 
 	band = WLC_BAND_2G;
-	err = brcmf_fil_iovar_int_get(ifp, "bw_cap", &band);
+	err = brcmf_fil_iovar_int_query(ifp, "bw_cap", &band);
 	if (!err) {
 		bw_cap[NL80211_BAND_2GHZ] = band;
 		band = WLC_BAND_5G;
-		err = brcmf_fil_iovar_int_get(ifp, "bw_cap", &band);
+		err = brcmf_fil_iovar_int_query(ifp, "bw_cap", &band);
 		if (!err) {
 			bw_cap[NL80211_BAND_5GHZ] = band;
 			return;
@@ -7170,7 +7171,6 @@ static void brcmf_get_bwcap(struct brcmf_if *ifp, u32 bw_cap[])
 		return;
 	}
 	brcmf_dbg(INFO, "fallback to mimo_bw_cap info\n");
-	mimo_bwcap = 0;
 	err = brcmf_fil_iovar_int_get(ifp, "mimo_bw_cap", &mimo_bwcap);
 	if (err)
 		/* assume 20MHz if firmware does not give a clue */
@@ -7266,10 +7266,10 @@ static int brcmf_setup_wiphybands(struct brcmf_cfg80211_info *cfg)
 	struct brcmf_pub *drvr = cfg->pub;
 	struct brcmf_if *ifp = brcmf_get_ifp(drvr, 0);
 	struct wiphy *wiphy = cfg_to_wiphy(cfg);
-	u32 nmode = 0;
+	u32 nmode;
 	u32 vhtmode = 0;
 	u32 bw_cap[2] = { WLC_BW_20MHZ_BIT, WLC_BW_20MHZ_BIT };
-	u32 rxchain = 0;
+	u32 rxchain;
 	u32 nchain;
 	int err;
 	s32 i;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index bf91b1e1368f..df53dd1d7e74 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -691,7 +691,7 @@ static int brcmf_net_mon_open(struct net_device *ndev)
 {
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	struct brcmf_pub *drvr = ifp->drvr;
-	u32 monitor = 0;
+	u32 monitor;
 	int err;
 
 	brcmf_dbg(TRACE, "Enter\n");
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index f23310a77a5d..0d9ae197fa1e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -184,7 +184,7 @@ static void brcmf_feat_wlc_version_overrides(struct brcmf_pub *drv)
 static void brcmf_feat_iovar_int_get(struct brcmf_if *ifp,
 				     enum brcmf_feat_id id, char *name)
 {
-	u32 data = 0;
+	u32 data;
 	int err;
 
 	/* we need to know firmware error */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
index a315a7fac6a0..31e080e4da66 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
@@ -96,15 +96,22 @@ static inline
 s32 brcmf_fil_cmd_int_get(struct brcmf_if *ifp, u32 cmd, u32 *data)
 {
 	s32 err;
-	__le32 data_le = cpu_to_le32(*data);
 
-	err = brcmf_fil_cmd_data_get(ifp, cmd, &data_le, sizeof(data_le));
+	err = brcmf_fil_cmd_data_get(ifp, cmd, data, sizeof(*data));
 	if (err == 0)
-		*data = le32_to_cpu(data_le);
+		*data = le32_to_cpu(*(__le32 *)data);
 	brcmf_dbg(FIL, "ifidx=%d, cmd=%d, value=%d\n", ifp->ifidx, cmd, *data);
 
 	return err;
 }
+static inline
+s32 brcmf_fil_cmd_int_query(struct brcmf_if *ifp, u32 cmd, u32 *data)
+{
+	__le32 *data_le = (__le32 *)data;
+
+	*data_le = cpu_to_le32(*data);
+	return brcmf_fil_cmd_int_get(ifp, cmd, data);
+}
 
 s32 brcmf_fil_iovar_data_set(struct brcmf_if *ifp, const char *name,
 			     const void *data, u32 len);
@@ -120,14 +127,21 @@ s32 brcmf_fil_iovar_int_set(struct brcmf_if *ifp, const char *name, u32 data)
 static inline
 s32 brcmf_fil_iovar_int_get(struct brcmf_if *ifp, const char *name, u32 *data)
 {
-	__le32 data_le = cpu_to_le32(*data);
 	s32 err;
 
-	err = brcmf_fil_iovar_data_get(ifp, name, &data_le, sizeof(data_le));
+	err = brcmf_fil_iovar_data_get(ifp, name, data, sizeof(*data));
 	if (err == 0)
-		*data = le32_to_cpu(data_le);
+		*data = le32_to_cpu(*(__le32 *)data);
 	return err;
 }
+static inline
+s32 brcmf_fil_iovar_int_query(struct brcmf_if *ifp, const char *name, u32 *data)
+{
+	__le32 *data_le = (__le32 *)data;
+
+	*data_le = cpu_to_le32(*data);
+	return brcmf_fil_iovar_int_get(ifp, name, data);
+}
 
 
 s32 brcmf_fil_bsscfg_data_set(struct brcmf_if *ifp, const char *name,
@@ -145,15 +159,21 @@ s32 brcmf_fil_bsscfg_int_set(struct brcmf_if *ifp, const char *name, u32 data)
 static inline
 s32 brcmf_fil_bsscfg_int_get(struct brcmf_if *ifp, const char *name, u32 *data)
 {
-	__le32 data_le = cpu_to_le32(*data);
 	s32 err;
 
-	err = brcmf_fil_bsscfg_data_get(ifp, name, &data_le,
-					sizeof(data_le));
+	err = brcmf_fil_bsscfg_data_get(ifp, name, data, sizeof(*data));
 	if (err == 0)
-		*data = le32_to_cpu(data_le);
+		*data = le32_to_cpu(*(__le32 *)data);
 	return err;
 }
+static inline
+s32 brcmf_fil_bsscfg_int_query(struct brcmf_if *ifp, const char *name, u32 *data)
+{
+	__le32 *data_le = (__le32 *)data;
+
+	*data_le = cpu_to_le32(*data);
+	return brcmf_fil_bsscfg_int_get(ifp, name, data);
+}
 
 s32 brcmf_fil_xtlv_data_set(struct brcmf_if *ifp, const char *name, u16 id,
 			    void *data, u32 len);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index bc98b87cf2a1..02a95bf72740 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -148,6 +148,17 @@ const struct iwl_cfg_trans_params iwl_bz_trans_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
+const struct iwl_cfg_trans_params iwl_gl_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_BZ,
+	.base_params = &iwl_bz_base_params,
+	.mq_rx_supported = true,
+	.rf_id = true,
+	.gen2 = true,
+	.umac_prph_offset = 0x300000,
+	.xtal_latency = 12000,
+	.low_latency_xtal = true,
+};
+
 const char iwl_bz_name[] = "Intel(R) TBD Bz device";
 const char iwl_fm_name[] = "Intel(R) Wi-Fi 7 BE201 320MHz";
 const char iwl_gl_name[] = "Intel(R) Wi-Fi 7 BE200 320MHz";
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 732889f96ca2..29a28b5c2811 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -503,6 +503,7 @@ extern const struct iwl_cfg_trans_params iwl_so_long_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_so_long_latency_imr_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_ma_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_bz_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_gl_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_sc_trans_cfg;
 extern const char iwl9162_name[];
 extern const char iwl9260_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 3cbeaddf4358..4ff643e9db5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -109,7 +109,7 @@
 #define IWL_MVM_FTM_INITIATOR_SECURE_LTF	false
 #define IWL_MVM_FTM_RESP_NDP_SUPPORT		true
 #define IWL_MVM_FTM_RESP_LMR_FEEDBACK_SUPPORT	true
-#define IWL_MVM_FTM_NON_TB_MIN_TIME_BETWEEN_MSR	5
+#define IWL_MVM_FTM_NON_TB_MIN_TIME_BETWEEN_MSR	7
 #define IWL_MVM_FTM_NON_TB_MAX_TIME_BETWEEN_MSR	1000
 #define IWL_MVM_D3_DEBUG			false
 #define IWL_MVM_USE_TWT				true
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 9d681377cbab..f40d3e59d694 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -107,16 +107,14 @@ static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 		iwl_mvm_flush_sta(mvm, mvm->aux_sta.sta_id,
 				  mvm->aux_sta.tfd_queue_msk);
 
-		if (mvm->mld_api_is_used) {
-			iwl_mvm_mld_rm_aux_sta(mvm);
-			mutex_unlock(&mvm->mutex);
-			return;
-		}
-
 		/* In newer version of this command an aux station is added only
 		 * in cases of dedicated tx queue and need to be removed in end
-		 * of use */
-		if (iwl_mvm_has_new_station_api(mvm->fw))
+		 * of use. For the even newer mld api, use the appropriate
+		 * function.
+		 */
+		if (mvm->mld_api_is_used)
+			iwl_mvm_mld_rm_aux_sta(mvm);
+		else if (iwl_mvm_has_new_station_api(mvm->fw))
 			iwl_mvm_rm_aux_sta(mvm);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index fed2754be680..d93eec242204 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -500,10 +500,38 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x7E40, PCI_ANY_ID, iwl_ma_trans_cfg)},
 
 /* Bz devices */
-	{IWL_PCI_DEVICE(0x2727, PCI_ANY_ID, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0x272D, PCI_ANY_ID, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, PCI_ANY_ID, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_gl_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0000, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0090, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0094, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0098, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x009C, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00C0, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00C4, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00E0, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00E4, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00E8, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00EC, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0100, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0110, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0114, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0118, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x011C, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0310, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0314, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0510, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0A10, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1671, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1672, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1771, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1772, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1791, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1792, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x4090, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x40C4, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x40E0, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x4110, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x4314, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x4D40, PCI_ANY_ID, iwl_bz_trans_cfg)},
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index e8ba2e4e8484..b5dbcf925f92 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1524,7 +1524,7 @@ EXPORT_SYMBOL_GPL(mt76_wcid_init);
 
 void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid)
 {
-	struct mt76_phy *phy = dev->phys[wcid->phy_idx];
+	struct mt76_phy *phy = mt76_dev_phy(dev, wcid->phy_idx);
 	struct ieee80211_hw *hw;
 	struct sk_buff_head list;
 	struct sk_buff *skb;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 14304b063715..e238161dfaa9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -29,7 +29,7 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	struct ieee80211_sta *sta;
 	struct mt7603_sta *msta;
 	struct mt76_wcid *wcid;
-	u8 tid = 0, hwq = 0;
+	u8 qid, tid = 0, hwq = 0;
 	void *priv;
 	int idx;
 	u32 val;
@@ -57,7 +57,7 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	if (ieee80211_is_data_qos(hdr->frame_control)) {
 		tid = *ieee80211_get_qos_ctl(hdr) &
 			 IEEE80211_QOS_CTL_TAG1D_MASK;
-		u8 qid = tid_to_ac[tid];
+		qid = tid_to_ac[tid];
 		hwq = wmm_queue_map[qid];
 		skb_set_queue_mapping(skb, qid);
 	} else if (ieee80211_is_data(hdr->frame_control)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index f7722f67db57..0b9ebdcda221 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -56,6 +56,9 @@ int mt7615_thermal_init(struct mt7615_dev *dev)
 
 	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7615_%s",
 			      wiphy_name(wiphy));
+	if (!name)
+		return -ENOMEM;
+
 	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev, name, dev,
 						       mt7615_hwmon_groups);
 	return PTR_ERR_OR_ZERO(hwmon);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index 353e66069840..ef003d1620a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -28,8 +28,6 @@ enum {
 #define MT_RXD0_MESH			BIT(18)
 #define MT_RXD0_MHCP			BIT(19)
 #define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
-#define MT_RXD0_NORMAL_IP_SUM		BIT(23)
-#define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
 
 #define MT_RXD0_SW_PKT_TYPE_MASK	GENMASK(31, 16)
 #define MT_RXD0_SW_PKT_TYPE_MAP		0x380F
@@ -80,6 +78,8 @@ enum {
 #define MT_RXD3_NORMAL_BEACON_UC	BIT(21)
 #define MT_RXD3_NORMAL_CO_ANT		BIT(22)
 #define MT_RXD3_NORMAL_FCS_ERR		BIT(24)
+#define MT_RXD3_NORMAL_IP_SUM		BIT(26)
+#define MT_RXD3_NORMAL_UDP_TCP_SUM	BIT(27)
 #define MT_RXD3_NORMAL_VLAN2ETH		BIT(31)
 
 /* RXD DW4 */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index a978f434dc5e..7bc3b4cd3592 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -194,6 +194,8 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 
 	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7915_%s",
 			      wiphy_name(wiphy));
+	if (!name)
+		return -ENOMEM;
 
 	cdev = thermal_cooling_device_register(name, phy, &mt7915_thermal_ops);
 	if (!IS_ERR(cdev)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 2624edbb59a1..eea41b29f096 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -564,8 +564,7 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 
 	MT76_FILTER(CONTROL, MT_WF_RFCR_DROP_CTS |
 			     MT_WF_RFCR_DROP_RTS |
-			     MT_WF_RFCR_DROP_CTL_RSV |
-			     MT_WF_RFCR_DROP_NDPA);
+			     MT_WF_RFCR_DROP_CTL_RSV);
 
 	*total_flags = flags;
 	rxfilter = phy->rxfilter;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index ef0c721d26e3..d1d64fa7d35d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -52,6 +52,8 @@ static int mt7921_thermal_init(struct mt792x_phy *phy)
 
 	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7921_%s",
 			      wiphy_name(wiphy));
+	if (!name)
+		return -ENOMEM;
 
 	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev, name, phy,
 						       mt7921_hwmon_groups);
@@ -83,7 +85,7 @@ mt7921_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
 		}
 
 		/* UNII-4 */
-		if (IS_UNII_INVALID(0, 5850, 5925))
+		if (IS_UNII_INVALID(0, 5845, 5925))
 			ch->flags |= IEEE80211_CHAN_DISABLED;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index c2460ef4993d..e9d2d0f22a58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -350,7 +350,7 @@ mt7925_mac_fill_rx_rate(struct mt792x_dev *dev,
 static int
 mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 {
-	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
+	u32 csum_mask = MT_RXD3_NORMAL_IP_SUM | MT_RXD3_NORMAL_UDP_TCP_SUM;
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	bool hdr_trans, unicast, insert_ccmp_hdr = false;
 	u8 chfreq, qos_ctl = 0, remove_pad, amsdu_info;
@@ -360,7 +360,6 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 	struct mt792x_phy *phy = &dev->phy;
 	struct ieee80211_supported_band *sband;
 	u32 csum_status = *(u32 *)skb->cb;
-	u32 rxd0 = le32_to_cpu(rxd[0]);
 	u32 rxd1 = le32_to_cpu(rxd[1]);
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 rxd3 = le32_to_cpu(rxd[3]);
@@ -418,7 +417,7 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 	if (!sband->channels)
 		return -EINVAL;
 
-	if (mt76_is_mmio(&dev->mt76) && (rxd0 & csum_mask) == csum_mask &&
+	if (mt76_is_mmio(&dev->mt76) && (rxd3 & csum_mask) == csum_mask &&
 	    !(csum_status & (BIT(0) | BIT(2) | BIT(3))))
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 652a9accc43c..7ec6bb5bc276 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -613,6 +613,9 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	for (offset = 0; offset < len; offset += le32_to_cpu(clc->len)) {
 		clc = (const struct mt7925_clc *)(clc_base + offset);
 
+		if (clc->idx > ARRAY_SIZE(phy->clc))
+			break;
+
 		/* do not init buf again if chip reset triggered */
 		if (phy->clc[clc->idx])
 			continue;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 283df84f1b43..a98dcb40490b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1011,8 +1011,6 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
 		return;
 
 	elem->phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
-	if (vif == NL80211_IFTYPE_AP)
-		elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
 
 	c = FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
 		       sts - 1) |
@@ -1020,6 +1018,11 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
 		       sts - 1);
 	elem->phy_cap_info[5] |= c;
 
+	if (vif != NL80211_IFTYPE_AP)
+		return;
+
+	elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
+
 	c = IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
 	    IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB;
 	elem->phy_cap_info[6] |= c;
@@ -1179,7 +1182,6 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 		IEEE80211_EHT_MAC_CAP0_OM_CONTROL;
 
 	eht_cap_elem->phy_cap_info[0] =
-		IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ |
 		IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
 		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER |
 		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE;
@@ -1193,30 +1195,36 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 		u8_encode_bits(u8_get_bits(val, GENMASK(2, 1)),
 			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_80MHZ_MASK) |
 		u8_encode_bits(val,
-			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK) |
-		u8_encode_bits(val,
-			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK);
+			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK);
 
 	eht_cap_elem->phy_cap_info[2] =
 		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_80MHZ_MASK) |
-		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ_MASK) |
-		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK);
+		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ_MASK);
+
+	if (band == NL80211_BAND_6GHZ) {
+		eht_cap_elem->phy_cap_info[0] |=
+			IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+
+		eht_cap_elem->phy_cap_info[1] |=
+			u8_encode_bits(val,
+				       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK);
+
+		eht_cap_elem->phy_cap_info[2] |=
+			u8_encode_bits(sts - 1,
+				       IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK);
+	}
 
 	eht_cap_elem->phy_cap_info[3] =
 		IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
 		IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
 		IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK |
-		IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
-		IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FDBK |
-		IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK |
-		IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK;
+		IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK;
 
 	eht_cap_elem->phy_cap_info[4] =
 		u8_encode_bits(min_t(int, sts - 1, 2),
 			       IEEE80211_EHT_PHY_CAP4_MAX_NC_MASK);
 
 	eht_cap_elem->phy_cap_info[5] =
-		IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK |
 		u8_encode_bits(IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_16US,
 			       IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK) |
 		u8_encode_bits(u8_get_bits(0x11, GENMASK(1, 0)),
@@ -1230,14 +1238,6 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 			       IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK) |
 		u8_encode_bits(val, IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK);
 
-	eht_cap_elem->phy_cap_info[7] =
-		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
-		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
-		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ |
-		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
-		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ |
-		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;
-
 	val = u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_RX) |
 	      u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_TX);
 #define SET_EHT_MAX_NSS(_bw, _val) do {				\
@@ -1248,8 +1248,29 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 
 	SET_EHT_MAX_NSS(80, val);
 	SET_EHT_MAX_NSS(160, val);
-	SET_EHT_MAX_NSS(320, val);
+	if (band == NL80211_BAND_6GHZ)
+		SET_EHT_MAX_NSS(320, val);
 #undef SET_EHT_MAX_NSS
+
+	if (iftype != NL80211_IFTYPE_AP)
+		return;
+
+	eht_cap_elem->phy_cap_info[3] |=
+		IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FDBK |
+		IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK;
+
+	eht_cap_elem->phy_cap_info[7] =
+		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
+		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
+		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
+		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ;
+
+	if (band != NL80211_BAND_6GHZ)
+		return;
+
+	eht_cap_elem->phy_cap_info[7] |=
+		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ |
+		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index bc7111a71f98..fd5fe96c32e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -435,7 +435,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 rxd3 = le32_to_cpu(rxd[3]);
 	u32 rxd4 = le32_to_cpu(rxd[4]);
-	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
+	u32 csum_mask = MT_RXD3_NORMAL_IP_SUM | MT_RXD3_NORMAL_UDP_TCP_SUM;
 	u32 csum_status = *(u32 *)skb->cb;
 	u32 mesh_mask = MT_RXD0_MESH | MT_RXD0_MHCP;
 	bool is_mesh = (rxd0 & mesh_mask) == mesh_mask;
@@ -497,7 +497,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 	if (!sband->channels)
 		return -EINVAL;
 
-	if ((rxd0 & csum_mask) == csum_mask &&
+	if ((rxd3 & csum_mask) == csum_mask &&
 	    !(csum_status & (BIT(0) | BIT(2) | BIT(3))))
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 7c97140d8255..2b094b33ba31 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -206,7 +206,7 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	mvif->mt76.omac_idx = idx;
 	mvif->phy = phy;
 	mvif->mt76.band_idx = band_idx;
-	mvif->mt76.wmm_idx = vif->type != NL80211_IFTYPE_AP;
+	mvif->mt76.wmm_idx = vif->type == NL80211_IFTYPE_AP ? 0 : 3;
 
 	ret = mt7996_mcu_add_dev_info(phy, vif, true);
 	if (ret)
@@ -307,6 +307,10 @@ int mt7996_set_channel(struct mt7996_phy *phy)
 	if (ret)
 		goto out;
 
+	ret = mt7996_mcu_set_chan_info(phy, UNI_CHANNEL_RX_PATH);
+	if (ret)
+		goto out;
+
 	ret = mt7996_dfs_init_radar_detector(phy);
 	mt7996_mac_cca_stats_reset(phy);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 2c8578677800..36ab59885cf2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -735,7 +735,7 @@ void mt7996_mcu_rx_event(struct mt7996_dev *dev, struct sk_buff *skb)
 static struct tlv *
 mt7996_mcu_add_uni_tlv(struct sk_buff *skb, u16 tag, u16 len)
 {
-	struct tlv *ptlv = skb_put(skb, len);
+	struct tlv *ptlv = skb_put_zero(skb, len);
 
 	ptlv->tag = cpu_to_le16(tag);
 	ptlv->len = cpu_to_le16(len);
@@ -822,7 +822,7 @@ mt7996_mcu_bss_mbssid_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct bss_info_uni_mbssid *mbssid;
 	struct tlv *tlv;
 
-	if (!vif->bss_conf.bssid_indicator)
+	if (!vif->bss_conf.bssid_indicator && enable)
 		return;
 
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_11V_MBSSID, sizeof(*mbssid));
@@ -1429,10 +1429,10 @@ mt7996_is_ebf_supported(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 
 		if (bfee)
 			return vif->bss_conf.eht_su_beamformee &&
-			       EHT_PHY(CAP0_SU_BEAMFORMEE, pe->phy_cap_info[0]);
+			       EHT_PHY(CAP0_SU_BEAMFORMER, pe->phy_cap_info[0]);
 		else
 			return vif->bss_conf.eht_su_beamformer &&
-			       EHT_PHY(CAP0_SU_BEAMFORMER, pe->phy_cap_info[0]);
+			       EHT_PHY(CAP0_SU_BEAMFORMEE, pe->phy_cap_info[0]);
 	}
 
 	if (sta->deflink.he_cap.has_he) {
@@ -1544,6 +1544,9 @@ mt7996_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 	u8 nss_mcs = mt7996_mcu_get_sta_nss(mcs_map);
 	u8 snd_dim, sts;
 
+	if (!vc)
+		return;
+
 	bf->tx_mode = MT_PHY_TYPE_HE_SU;
 
 	mt7996_mcu_sta_sounding_rate(bf);
@@ -1653,7 +1656,7 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_phy *phy = mvif->phy;
-	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
+	int tx_ant = hweight16(phy->mt76->chainmask) - 1;
 	struct sta_rec_bf *bf;
 	struct tlv *tlv;
 	static const u8 matrix[4][4] = {
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 7719e4f3e2a2..2ee8c8e365f8 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -384,6 +384,7 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 	struct wilc_join_bss_param *param;
 	u8 rates_len = 0;
 	int ies_len;
+	u64 ies_tsf;
 	int ret;
 
 	param = kzalloc(sizeof(*param), GFP_KERNEL);
@@ -399,6 +400,7 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 		return NULL;
 	}
 	ies_len = ies->len;
+	ies_tsf = ies->tsf;
 	rcu_read_unlock();
 
 	param->beacon_period = cpu_to_le16(bss->beacon_interval);
@@ -454,7 +456,7 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 				    IEEE80211_P2P_ATTR_ABSENCE_NOTICE,
 				    (u8 *)&noa_attr, sizeof(noa_attr));
 	if (ret > 0) {
-		param->tsf_lo = cpu_to_le32(ies->tsf);
+		param->tsf_lo = cpu_to_le32(ies_tsf);
 		param->noa_enabled = 1;
 		param->idx = noa_attr.index;
 		if (noa_attr.oppps_ctwindow & IEEE80211_P2P_OPPPS_ENABLE_BIT) {
diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index de3332eb7a22..a99776af56c2 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2194,7 +2194,6 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	u8 table_case, tdma_case;
-	bool wl_cpt_test = false, bt_cpt_test = false;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 
@@ -2202,29 +2201,16 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	if (efuse->share_ant) {
 		/* Shared-Ant */
-		if (wl_cpt_test) {
-			if (coex_stat->wl_gl_busy) {
-				table_case = 20;
-				tdma_case = 17;
-			} else {
-				table_case = 10;
-				tdma_case = 15;
-			}
-		} else if (bt_cpt_test) {
-			table_case = 26;
-			tdma_case = 26;
-		} else {
-			if (coex_stat->wl_gl_busy &&
-			    coex_stat->wl_noisy_level == 0)
-				table_case = 14;
-			else
-				table_case = 10;
+		if (coex_stat->wl_gl_busy &&
+		    coex_stat->wl_noisy_level == 0)
+			table_case = 14;
+		else
+			table_case = 10;
 
-			if (coex_stat->wl_gl_busy)
-				tdma_case = 15;
-			else
-				tdma_case = 20;
-		}
+		if (coex_stat->wl_gl_busy)
+			tdma_case = 15;
+		else
+			tdma_case = 20;
 	} else {
 		/* Non-Shared-Ant */
 		table_case = 112;
@@ -2235,11 +2221,7 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 			tdma_case = 120;
 	}
 
-	if (wl_cpt_test)
-		rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[1]);
-	else
-		rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
-
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index ab7d414d0ba6..b9b0114e253b 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1468,10 +1468,12 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 	val |= BIT_ENSWBCN >> 8;
 	rtw_write8(rtwdev, REG_CR + 1, val);
 
-	val = rtw_read8(rtwdev, REG_FWHW_TXQ_CTRL + 2);
-	bckp[1] = val;
-	val &= ~(BIT_EN_BCNQ_DL >> 16);
-	rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 2, val);
+	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE) {
+		val = rtw_read8(rtwdev, REG_FWHW_TXQ_CTRL + 2);
+		bckp[1] = val;
+		val &= ~(BIT_EN_BCNQ_DL >> 16);
+		rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 2, val);
+	}
 
 	ret = rtw_hci_write_data_rsvd_page(rtwdev, buf, size);
 	if (ret) {
@@ -1496,7 +1498,8 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 	rsvd_pg_head = rtwdev->fifo.rsvd_boundary;
 	rtw_write16(rtwdev, REG_FIFOPAGE_CTRL_2,
 		    rsvd_pg_head | BIT_BCN_VALID_V1);
-	rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 2, bckp[1]);
+	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE)
+		rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 2, bckp[1]);
 	rtw_write8(rtwdev, REG_CR + 1, bckp[0]);
 
 	return ret;
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 7ab7a988b123..33a7577557a5 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1313,20 +1313,21 @@ static int rtw_wait_firmware_completion(struct rtw_dev *rtwdev)
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fw_state *fw;
+	int ret = 0;
 
 	fw = &rtwdev->fw;
 	wait_for_completion(&fw->completion);
 	if (!fw->firmware)
-		return -EINVAL;
+		ret = -EINVAL;
 
 	if (chip->wow_fw_name) {
 		fw = &rtwdev->wow_fw;
 		wait_for_completion(&fw->completion);
 		if (!fw->firmware)
-			return -EINVAL;
+			ret = -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static enum rtw_lps_deep_mode rtw_update_lps_deep_mode(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
index e2c7d9f87683..a019f4085e73 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
@@ -31,8 +31,6 @@ static const struct usb_device_id rtw_8821cu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82b, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82c, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x331d, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* D-Link */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xc811, 0xff, 0xff, 0xff),
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 62376d1cca22..732d78765220 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2611,12 +2611,14 @@ static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
 	else
 		rxsc = GET_PHY_STAT_P1_HT_RXSC(phy_status);
 
-	if (rxsc >= 9 && rxsc <= 12)
+	if (rxsc == 0)
+		bw = rtwdev->hal.current_band_width;
+	else if (rxsc >= 1 && rxsc <= 8)
+		bw = RTW_CHANNEL_WIDTH_20;
+	else if (rxsc >= 9 && rxsc <= 12)
 		bw = RTW_CHANNEL_WIDTH_40;
-	else if (rxsc >= 13)
-		bw = RTW_CHANNEL_WIDTH_80;
 	else
-		bw = RTW_CHANNEL_WIDTH_20;
+		bw = RTW_CHANNEL_WIDTH_80;
 
 	channel = GET_PHY_STAT_P1_CHANNEL(phy_status);
 	rtw_set_rx_freq_band(pkt_stat, channel);
diff --git a/drivers/net/wireless/realtek/rtw88/rx.h b/drivers/net/wireless/realtek/rtw88/rx.h
index d3668c4efc24..8a072dd3d73c 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.h
+++ b/drivers/net/wireless/realtek/rtw88/rx.h
@@ -41,7 +41,7 @@ enum rtw_rx_desc_enc {
 #define GET_RX_DESC_TSFL(rxdesc)                                               \
 	le32_get_bits(*((__le32 *)(rxdesc) + 0x05), GENMASK(31, 0))
 #define GET_RX_DESC_BW(rxdesc)                                                 \
-	(le32_get_bits(*((__le32 *)(rxdesc) + 0x04), GENMASK(31, 24)))
+	(le32_get_bits(*((__le32 *)(rxdesc) + 0x04), GENMASK(5, 4)))
 
 void rtw_rx_stats(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		  struct sk_buff *skb);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index a580cb719233..755a55c8bc20 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -421,7 +421,6 @@ enum rtw89_mac_c2h_mrc_func {
 
 enum rtw89_mac_c2h_wow_func {
 	RTW89_MAC_C2H_FUNC_AOAC_REPORT,
-	RTW89_MAC_C2H_FUNC_READ_WOW_CAM,
 
 	NUM_OF_RTW89_MAC_C2H_FUNC_WOW,
 };
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 9ab836d0d4f1..079b8cd79785 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -778,7 +778,7 @@ static void ndev_init_debugfs(struct intel_ntb_dev *ndev)
 		ndev->debugfs_dir =
 			debugfs_create_dir(pci_name(ndev->ntb.pdev),
 					   debugfs_dir);
-		if (!ndev->debugfs_dir)
+		if (IS_ERR(ndev->debugfs_dir))
 			ndev->debugfs_info = NULL;
 		else
 			ndev->debugfs_info =
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9e7847a378e..c84fadfc63c5 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -807,16 +807,29 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 }
 
 static int ntb_alloc_mw_buffer(struct ntb_transport_mw *mw,
-			       struct device *dma_dev, size_t align)
+			       struct device *ntb_dev, size_t align)
 {
 	dma_addr_t dma_addr;
 	void *alloc_addr, *virt_addr;
 	int rc;
 
-	alloc_addr = dma_alloc_coherent(dma_dev, mw->alloc_size,
-					&dma_addr, GFP_KERNEL);
+	/*
+	 * The buffer here is allocated against the NTB device. The reason to
+	 * use dma_alloc_*() call is to allocate a large IOVA contiguous buffer
+	 * backing the NTB BAR for the remote host to write to. During receive
+	 * processing, the data is being copied out of the receive buffer to
+	 * the kernel skbuff. When a DMA device is being used, dma_map_page()
+	 * is called on the kvaddr of the receive buffer (from dma_alloc_*())
+	 * and remapped against the DMA device. It appears to be a double
+	 * DMA mapping of buffers, but first is mapped to the NTB device and
+	 * second is to the DMA device. DMA_ATTR_FORCE_CONTIGUOUS is necessary
+	 * in order for the later dma_map_page() to not fail.
+	 */
+	alloc_addr = dma_alloc_attrs(ntb_dev, mw->alloc_size,
+				     &dma_addr, GFP_KERNEL,
+				     DMA_ATTR_FORCE_CONTIGUOUS);
 	if (!alloc_addr) {
-		dev_err(dma_dev, "Unable to alloc MW buff of size %zu\n",
+		dev_err(ntb_dev, "Unable to alloc MW buff of size %zu\n",
 			mw->alloc_size);
 		return -ENOMEM;
 	}
@@ -845,7 +858,7 @@ static int ntb_alloc_mw_buffer(struct ntb_transport_mw *mw,
 	return 0;
 
 err:
-	dma_free_coherent(dma_dev, mw->alloc_size, alloc_addr, dma_addr);
+	dma_free_coherent(ntb_dev, mw->alloc_size, alloc_addr, dma_addr);
 
 	return rc;
 }
diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 553f1f46bc66..72bc1d017a46 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1227,7 +1227,7 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
 			"\tOut buffer addr 0x%pK\n", peer->outbuf);
 
 		pos += scnprintf(buf + pos, buf_size - pos,
-			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
+			"\tOut buff phys addr %pap\n", &peer->out_phys_addr);
 
 		pos += scnprintf(buf + pos, buf_size - pos,
 			"\tOut buffer size %pa\n", &peer->outbuf_size);
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index d6d558f94d6b..35d9f3cc2efa 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1937,12 +1937,16 @@ static int cmp_dpa(const void *a, const void *b)
 static struct device **scan_labels(struct nd_region *nd_region)
 {
 	int i, count = 0;
-	struct device *dev, **devs = NULL;
+	struct device *dev, **devs;
 	struct nd_label_ent *label_ent, *e;
 	struct nd_mapping *nd_mapping = &nd_region->mapping[0];
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
 	resource_size_t map_end = nd_mapping->start + nd_mapping->size - 1;
 
+	devs = kcalloc(2, sizeof(dev), GFP_KERNEL);
+	if (!devs)
+		return NULL;
+
 	/* "safe" because create_namespace_pmem() might list_move() label_ent */
 	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
 		struct nd_namespace_label *nd_label = label_ent->label;
@@ -1961,12 +1965,14 @@ static struct device **scan_labels(struct nd_region *nd_region)
 			goto err;
 		if (i < count)
 			continue;
-		__devs = kcalloc(count + 2, sizeof(dev), GFP_KERNEL);
-		if (!__devs)
-			goto err;
-		memcpy(__devs, devs, sizeof(dev) * count);
-		kfree(devs);
-		devs = __devs;
+		if (count) {
+			__devs = kcalloc(count + 2, sizeof(dev), GFP_KERNEL);
+			if (!__devs)
+				goto err;
+			memcpy(__devs, devs, sizeof(dev) * count);
+			kfree(devs);
+			devs = __devs;
+		}
 
 		dev = create_namespace_pmem(nd_region, nd_mapping, nd_label);
 		if (IS_ERR(dev)) {
@@ -1993,11 +1999,6 @@ static struct device **scan_labels(struct nd_region *nd_region)
 
 		/* Publish a zero-sized namespace for userspace to configure. */
 		nd_mapping_free_labels(nd_mapping);
-
-		devs = kcalloc(2, sizeof(dev), GFP_KERNEL);
-		if (!devs)
-			goto err;
-
 		nspm = kzalloc(sizeof(*nspm), GFP_KERNEL);
 		if (!nspm)
 			goto err;
@@ -2036,11 +2037,10 @@ static struct device **scan_labels(struct nd_region *nd_region)
 	return devs;
 
  err:
-	if (devs) {
-		for (i = 0; devs[i]; i++)
-			namespace_pmem_release(devs[i]);
-		kfree(devs);
-	}
+	for (i = 0; devs[i]; i++)
+		namespace_pmem_release(devs[i]);
+	kfree(devs);
+
 	return NULL;
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 03a6868f4dbc..a47d35102b7c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -587,7 +587,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		rc = device_add_disk(&head->subsys->dev, head->disk,
 				     nvme_ns_attr_groups);
 		if (rc) {
-			clear_bit(NVME_NSHEAD_DISK_LIVE, &ns->flags);
+			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index d2d17d37d3e0..4c67fa78db26 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -850,14 +850,21 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	dra7xx->mode = mode;
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, dra7xx_pcie_irq_handler,
-			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
+					IRQF_SHARED | IRQF_ONESHOT,
+					"dra7xx-pcie-main", dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-		goto err_gpio;
+		goto err_deinit;
 	}
 
 	return 0;
 
+err_deinit:
+	if (dra7xx->mode == DW_PCIE_RC_TYPE)
+		dw_pcie_host_deinit(&dra7xx->pci->pp);
+	else
+		dw_pcie_ep_deinit(&dra7xx->pci->ep);
+
 err_gpio:
 err_get_sync:
 	pm_runtime_put(dev);
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 917c69edee1d..dbd6d7a27489 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -958,7 +958,7 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 		ret = phy_power_on(imx6_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");
-			goto err_phy_off;
+			goto err_phy_exit;
 		}
 	}
 
@@ -973,8 +973,9 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 
 err_phy_off:
-	if (imx6_pcie->phy)
-		phy_exit(imx6_pcie->phy);
+	phy_power_off(imx6_pcie->phy);
+err_phy_exit:
+	phy_exit(imx6_pcie->phy);
 err_clk_disable:
 	imx6_pcie_clk_disable(imx6_pcie);
 err_reg_disable:
@@ -1118,6 +1119,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
 		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 
+	ep->page_size = imx6_pcie->drvdata->epc_features->align;
+
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
 		dev_err(dev, "failed to initialize endpoint\n");
@@ -1578,7 +1581,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
@@ -1589,7 +1593,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 483c95406513..d911f0e521da 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -577,7 +577,7 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 	 */
 	if (pci_match_id(am6_pci_devids, bridge)) {
 		bridge_dev = pci_get_host_bridge_device(dev);
-		if (!bridge_dev && !bridge_dev->parent)
+		if (!bridge_dev || !bridge_dev->parent)
 			return;
 
 		ks_pcie = dev_get_drvdata(bridge_dev->parent);
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index d5523f302102..deab1e653b9a 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -412,12 +412,12 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 			if (pcie->gpio_id_reset[i] < 0)
 				continue;
 
-			pcie->num_slots++;
-			if (pcie->num_slots > MAX_PCI_SLOTS) {
+			if (pcie->num_slots + 1 >= MAX_PCI_SLOTS) {
 				dev_err(dev, "Too many PCI slots!\n");
 				ret = -EINVAL;
 				goto put_node;
 			}
+			pcie->num_slots++;
 
 			ret = of_pci_get_devfn(child);
 			if (ret < 0) {
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 50b1635e3cbb..26cab226bccf 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -816,21 +816,15 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = qcom_pcie_enable_resources(pcie_ep);
-	if (ret) {
-		dev_err(dev, "Failed to enable resources: %d\n", ret);
-		return ret;
-	}
-
 	ret = dw_pcie_ep_init(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to initialize endpoint: %d\n", ret);
-		goto err_disable_resources;
+		return ret;
 	}
 
 	ret = qcom_pcie_ep_enable_irq_resources(pdev, pcie_ep);
 	if (ret)
-		goto err_disable_resources;
+		goto err_ep_deinit;
 
 	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
 	if (!name) {
@@ -847,8 +841,8 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	disable_irq(pcie_ep->global_irq);
 	disable_irq(pcie_ep->perst_irq);
 
-err_disable_resources:
-	qcom_pcie_disable_resources(pcie_ep);
+err_ep_deinit:
+	dw_pcie_ep_deinit(&pcie_ep->pci.ep);
 
 	return ret;
 }
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 0408f4d612b5..7417993f8cff 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -80,8 +80,8 @@
 #define MSGF_MISC_SR_NON_FATAL_DEV	BIT(22)
 #define MSGF_MISC_SR_FATAL_DEV		BIT(23)
 #define MSGF_MISC_SR_LINK_DOWN		BIT(24)
-#define MSGF_MSIC_SR_LINK_AUTO_BWIDTH	BIT(25)
-#define MSGF_MSIC_SR_LINK_BWIDTH	BIT(26)
+#define MSGF_MISC_SR_LINK_AUTO_BWIDTH	BIT(25)
+#define MSGF_MISC_SR_LINK_BWIDTH	BIT(26)
 
 #define MSGF_MISC_SR_MASKALL		(MSGF_MISC_SR_RXMSG_AVAIL | \
 					MSGF_MISC_SR_RXMSG_OVER | \
@@ -96,8 +96,8 @@
 					MSGF_MISC_SR_NON_FATAL_DEV | \
 					MSGF_MISC_SR_FATAL_DEV | \
 					MSGF_MISC_SR_LINK_DOWN | \
-					MSGF_MSIC_SR_LINK_AUTO_BWIDTH | \
-					MSGF_MSIC_SR_LINK_BWIDTH)
+					MSGF_MISC_SR_LINK_AUTO_BWIDTH | \
+					MSGF_MISC_SR_LINK_BWIDTH)
 
 /* Legacy interrupt status mask bits */
 #define MSGF_LEG_SR_INTA		BIT(0)
@@ -299,10 +299,10 @@ static irqreturn_t nwl_pcie_misc_handler(int irq, void *data)
 	if (misc_stat & MSGF_MISC_SR_FATAL_DEV)
 		dev_err(dev, "Fatal Error Detected\n");
 
-	if (misc_stat & MSGF_MSIC_SR_LINK_AUTO_BWIDTH)
+	if (misc_stat & MSGF_MISC_SR_LINK_AUTO_BWIDTH)
 		dev_info(dev, "Link Autonomous Bandwidth Management Status bit set\n");
 
-	if (misc_stat & MSGF_MSIC_SR_LINK_BWIDTH)
+	if (misc_stat & MSGF_MISC_SR_LINK_BWIDTH)
 		dev_info(dev, "Link Bandwidth Management Status bit set\n");
 
 	/* Clear misc interrupt status */
@@ -371,7 +371,7 @@ static void nwl_mask_intx_irq(struct irq_data *data)
 	u32 mask;
 	u32 val;
 
-	mask = 1 << (data->hwirq - 1);
+	mask = 1 << data->hwirq;
 	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
 	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
 	nwl_bridge_writel(pcie, (val & (~mask)), MSGF_LEG_MASK);
@@ -385,7 +385,7 @@ static void nwl_unmask_intx_irq(struct irq_data *data)
 	u32 mask;
 	u32 val;
 
-	mask = 1 << (data->hwirq - 1);
+	mask = 1 << data->hwirq;
 	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
 	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
 	nwl_bridge_writel(pcie, (val | mask), MSGF_LEG_MASK);
@@ -779,6 +779,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	pcie = pci_host_bridge_priv(bridge);
+	platform_set_drvdata(pdev, pcie);
 
 	pcie->dev = dev;
 
@@ -801,13 +802,13 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	err = nwl_pcie_bridge_init(pcie);
 	if (err) {
 		dev_err(dev, "HW Initialization failed\n");
-		return err;
+		goto err_clk;
 	}
 
 	err = nwl_pcie_init_irq_domain(pcie);
 	if (err) {
 		dev_err(dev, "Failed creating IRQ Domain\n");
-		return err;
+		goto err_clk;
 	}
 
 	bridge->sysdata = pcie;
@@ -817,11 +818,24 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		err = nwl_pcie_enable_msi(pcie);
 		if (err < 0) {
 			dev_err(dev, "failed to enable MSI support: %d\n", err);
-			return err;
+			goto err_clk;
 		}
 	}
 
-	return pci_host_probe(bridge);
+	err = pci_host_probe(bridge);
+	if (!err)
+		return 0;
+
+err_clk:
+	clk_disable_unprepare(pcie->clk);
+	return err;
+}
+
+static void nwl_pcie_remove(struct platform_device *pdev)
+{
+	struct nwl_pcie *pcie = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(pcie->clk);
 }
 
 static struct platform_driver nwl_pcie_driver = {
@@ -831,5 +845,6 @@ static struct platform_driver nwl_pcie_driver = {
 		.of_match_table = nwl_pcie_of_match,
 	},
 	.probe = nwl_pcie_probe,
+	.remove_new = nwl_pcie_remove,
 };
 builtin_platform_driver(nwl_pcie_driver);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8db214d4b1d4..4f77fe122e7d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1295,7 +1295,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 		if (delay > PCI_RESET_WAIT) {
 			if (retrain) {
 				retrain = false;
-				if (pcie_failed_link_retrain(bridge)) {
+				if (pcie_failed_link_retrain(bridge) == 0) {
 					delay = 1;
 					continue;
 				}
@@ -4647,7 +4647,15 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 		pcie_capability_clear_word(pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
 	}
 
-	return pcie_wait_for_link_status(pdev, use_lt, !use_lt);
+	rc = pcie_wait_for_link_status(pdev, use_lt, !use_lt);
+
+	/*
+	 * Clear LBMS after a manual retrain so that the bit can be used
+	 * to track link speed or width changes made by hardware itself
+	 * in attempt to correct unreliable link operation.
+	 */
+	pcie_capability_write_word(pdev, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
+	return rc;
 }
 
 /**
@@ -5598,8 +5606,10 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pci_dev_restore(dev);
-		if (dev->subordinate)
+		if (dev->subordinate) {
+			pci_bridge_wait_for_secondary_bus(dev, "bus reset");
 			pci_bus_restore_locked(dev->subordinate);
+		}
 	}
 }
 
@@ -5633,8 +5643,10 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
 		if (!dev->slot || dev->slot != slot)
 			continue;
 		pci_dev_restore(dev);
-		if (dev->subordinate)
+		if (dev->subordinate) {
+			pci_bridge_wait_for_secondary_bus(dev, "slot reset");
 			pci_bus_restore_locked(dev->subordinate);
+		}
 	}
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd44565c4756..55d76d6802ec 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -541,7 +541,7 @@ void pci_acs_init(struct pci_dev *dev);
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
-bool pcie_failed_link_retrain(struct pci_dev *dev);
+int pcie_failed_link_retrain(struct pci_dev *dev);
 #else
 static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
 					       u16 acs_flags)
@@ -556,9 +556,9 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 {
 	return -ENOTTY;
 }
-static inline bool pcie_failed_link_retrain(struct pci_dev *dev)
+static inline int pcie_failed_link_retrain(struct pci_dev *dev)
 {
-	return false;
+	return -ENOTTY;
 }
 #endif
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 568410e64ce6..206b76156c05 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -66,7 +66,7 @@
  * apply this erratum workaround to any downstream ports as long as they
  * support Link Active reporting and have the Link Control 2 register.
  * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
- * request a retrain and wait 200ms for the data link to go up.
+ * request a retrain and check the result.
  *
  * If this turns out successful and we know by the Vendor:Device ID it is
  * safe to do so, then lift the restriction, letting the devices negotiate
@@ -74,33 +74,45 @@
  * firmware may have already arranged and lift it with ports that already
  * report their data link being up.
  *
- * Return TRUE if the link has been successfully retrained, otherwise FALSE.
+ * Otherwise revert the speed to the original setting and request a retrain
+ * again to remove any residual state, ignoring the result as it's supposed
+ * to fail anyway.
+ *
+ * Return 0 if the link has been successfully retrained.  Return an error
+ * if retraining was not needed or we attempted a retrain and it failed.
  */
-bool pcie_failed_link_retrain(struct pci_dev *dev)
+int pcie_failed_link_retrain(struct pci_dev *dev)
 {
 	static const struct pci_device_id ids[] = {
 		{ PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
 		{}
 	};
 	u16 lnksta, lnkctl2;
+	int ret = -ENOTTY;
 
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
-		return false;
+		return ret;
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
 	    PCI_EXP_LNKSTA_LBMS) {
+		u16 oldlnkctl2 = lnkctl2;
+
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 
 		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
 		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
-		if (pcie_retrain_link(dev, false)) {
+		ret = pcie_retrain_link(dev, false);
+		if (ret) {
 			pci_info(dev, "retraining failed\n");
-			return false;
+			pcie_capability_write_word(dev, PCI_EXP_LNKCTL2,
+						   oldlnkctl2);
+			pcie_retrain_link(dev, true);
+			return ret;
 		}
 
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
@@ -117,13 +129,14 @@ bool pcie_failed_link_retrain(struct pci_dev *dev)
 		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
-		if (pcie_retrain_link(dev, false)) {
+		ret = pcie_retrain_link(dev, false);
+		if (ret) {
 			pci_info(dev, "retraining failed\n");
-			return false;
+			return ret;
 		}
 	}
 
-	return true;
+	return ret;
 }
 
 static ktime_t fixup_debug_start(struct pci_dev *dev,
diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index 38a2947ae813..c6ff1bc7d336 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -400,7 +400,7 @@ static irqreturn_t ali_drw_pmu_isr(int irq_num, void *data)
 			}
 
 			/* clear common counter intr status */
-			clr_status = FIELD_PREP(ALI_DRW_PMCOM_CNT_OV_INTR_MASK, 1);
+			clr_status = FIELD_PREP(ALI_DRW_PMCOM_CNT_OV_INTR_MASK, status);
 			writel(clr_status,
 			       drw_pmu->cfg_base + ALI_DRW_PMU_OV_INTR_CLR);
 		}
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index e26ad1d3ed0b..058ea798b669 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -24,14 +24,6 @@
 #define CMN_NI_NODE_ID			GENMASK_ULL(31, 16)
 #define CMN_NI_LOGICAL_ID		GENMASK_ULL(47, 32)
 
-#define CMN_NODEID_DEVID(reg)		((reg) & 3)
-#define CMN_NODEID_EXT_DEVID(reg)	((reg) & 1)
-#define CMN_NODEID_PID(reg)		(((reg) >> 2) & 1)
-#define CMN_NODEID_EXT_PID(reg)		(((reg) >> 1) & 3)
-#define CMN_NODEID_1x1_PID(reg)		(((reg) >> 2) & 7)
-#define CMN_NODEID_X(reg, bits)		((reg) >> (3 + (bits)))
-#define CMN_NODEID_Y(reg, bits)		(((reg) >> 3) & ((1U << (bits)) - 1))
-
 #define CMN_CHILD_INFO			0x0080
 #define CMN_CI_CHILD_COUNT		GENMASK_ULL(15, 0)
 #define CMN_CI_CHILD_PTR_OFFSET		GENMASK_ULL(31, 16)
@@ -43,6 +35,9 @@
 #define CMN_MAX_XPS			(CMN_MAX_DIMENSION * CMN_MAX_DIMENSION)
 #define CMN_MAX_DTMS			(CMN_MAX_XPS + (CMN_MAX_DIMENSION - 1) * 4)
 
+/* Currently XPs are the node type we can have most of; others top out at 128 */
+#define CMN_MAX_NODES_PER_EVENT		CMN_MAX_XPS
+
 /* The CFG node has various info besides the discovery tree */
 #define CMN_CFGM_PERIPH_ID_01		0x0008
 #define CMN_CFGM_PID0_PART_0		GENMASK_ULL(7, 0)
@@ -78,7 +73,8 @@
 /* Technically this is 4 bits wide on DNs, but we only use 2 there anyway */
 #define CMN__PMU_OCCUP1_ID		GENMASK_ULL(34, 32)
 
-/* HN-Ps are weird... */
+/* Some types are designed to coexist with another device in the same node */
+#define CMN_CCLA_PMU_EVENT_SEL		0x008
 #define CMN_HNP_PMU_EVENT_SEL		0x008
 
 /* DTMs live in the PMU space of XP registers */
@@ -281,8 +277,11 @@ struct arm_cmn_node {
 	u16 id, logid;
 	enum cmn_node_type type;
 
+	/* XP properties really, but replicated to children for convenience */
 	u8 dtm;
 	s8 dtc;
+	u8 portid_bits:4;
+	u8 deviceid_bits:4;
 	/* DN/HN-F/CXHA */
 	struct {
 		u8 val : 4;
@@ -358,49 +357,33 @@ struct arm_cmn {
 static int arm_cmn_hp_state;
 
 struct arm_cmn_nodeid {
-	u8 x;
-	u8 y;
 	u8 port;
 	u8 dev;
 };
 
 static int arm_cmn_xyidbits(const struct arm_cmn *cmn)
 {
-	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1) | 2);
+	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1));
 }
 
-static struct arm_cmn_nodeid arm_cmn_nid(const struct arm_cmn *cmn, u16 id)
+static struct arm_cmn_nodeid arm_cmn_nid(const struct arm_cmn_node *dn)
 {
 	struct arm_cmn_nodeid nid;
 
-	if (cmn->num_xps == 1) {
-		nid.x = 0;
-		nid.y = 0;
-		nid.port = CMN_NODEID_1x1_PID(id);
-		nid.dev = CMN_NODEID_DEVID(id);
-	} else {
-		int bits = arm_cmn_xyidbits(cmn);
-
-		nid.x = CMN_NODEID_X(id, bits);
-		nid.y = CMN_NODEID_Y(id, bits);
-		if (cmn->ports_used & 0xc) {
-			nid.port = CMN_NODEID_EXT_PID(id);
-			nid.dev = CMN_NODEID_EXT_DEVID(id);
-		} else {
-			nid.port = CMN_NODEID_PID(id);
-			nid.dev = CMN_NODEID_DEVID(id);
-		}
-	}
+	nid.dev = dn->id & ((1U << dn->deviceid_bits) - 1);
+	nid.port = (dn->id >> dn->deviceid_bits) & ((1U << dn->portid_bits) - 1);
 	return nid;
 }
 
 static struct arm_cmn_node *arm_cmn_node_to_xp(const struct arm_cmn *cmn,
 					       const struct arm_cmn_node *dn)
 {
-	struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
-	int xp_idx = cmn->mesh_x * nid.y + nid.x;
+	int id = dn->id >> (dn->portid_bits + dn->deviceid_bits);
+	int bits = arm_cmn_xyidbits(cmn);
+	int x = id >> bits;
+	int y = id & ((1U << bits) - 1);
 
-	return cmn->xps + xp_idx;
+	return cmn->xps + cmn->mesh_x * y + x;
 }
 static struct arm_cmn_node *arm_cmn_node(const struct arm_cmn *cmn,
 					 enum cmn_node_type type)
@@ -486,13 +469,13 @@ static const char *arm_cmn_device_type(u8 type)
 	}
 }
 
-static void arm_cmn_show_logid(struct seq_file *s, int x, int y, int p, int d)
+static void arm_cmn_show_logid(struct seq_file *s, const struct arm_cmn_node *xp, int p, int d)
 {
 	struct arm_cmn *cmn = s->private;
 	struct arm_cmn_node *dn;
+	u16 id = xp->id | d | (p << xp->deviceid_bits);
 
 	for (dn = cmn->dns; dn->type; dn++) {
-		struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
 		int pad = dn->logid < 10;
 
 		if (dn->type == CMN_TYPE_XP)
@@ -501,7 +484,7 @@ static void arm_cmn_show_logid(struct seq_file *s, int x, int y, int p, int d)
 		if (dn->type < CMN_TYPE_HNI)
 			continue;
 
-		if (nid.x != x || nid.y != y || nid.port != p || nid.dev != d)
+		if (dn->id != id)
 			continue;
 
 		seq_printf(s, " %*c#%-*d  |", pad + 1, ' ', 3 - pad, dn->logid);
@@ -522,6 +505,7 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
 	y = cmn->mesh_y;
 	while (y--) {
 		int xp_base = cmn->mesh_x * y;
+		struct arm_cmn_node *xp = cmn->xps + xp_base;
 		u8 port[CMN_MAX_PORTS][CMN_MAX_DIMENSION];
 
 		for (x = 0; x < cmn->mesh_x; x++)
@@ -529,16 +513,14 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
 
 		seq_printf(s, "\n%-2d   |", y);
 		for (x = 0; x < cmn->mesh_x; x++) {
-			struct arm_cmn_node *xp = cmn->xps + xp_base + x;
-
 			for (p = 0; p < CMN_MAX_PORTS; p++)
-				port[p][x] = arm_cmn_device_connect_info(cmn, xp, p);
+				port[p][x] = arm_cmn_device_connect_info(cmn, xp + x, p);
 			seq_printf(s, " XP #%-3d|", xp_base + x);
 		}
 
 		seq_puts(s, "\n     |");
 		for (x = 0; x < cmn->mesh_x; x++) {
-			s8 dtc = cmn->xps[xp_base + x].dtc;
+			s8 dtc = xp[x].dtc;
 
 			if (dtc < 0)
 				seq_puts(s, " DTC ?? |");
@@ -555,10 +537,10 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
 				seq_puts(s, arm_cmn_device_type(port[p][x]));
 			seq_puts(s, "\n    0|");
 			for (x = 0; x < cmn->mesh_x; x++)
-				arm_cmn_show_logid(s, x, y, p, 0);
+				arm_cmn_show_logid(s, xp + x, p, 0);
 			seq_puts(s, "\n    1|");
 			for (x = 0; x < cmn->mesh_x; x++)
-				arm_cmn_show_logid(s, x, y, p, 1);
+				arm_cmn_show_logid(s, xp + x, p, 1);
 		}
 		seq_puts(s, "\n-----+");
 	}
@@ -586,7 +568,7 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
 
 struct arm_cmn_hw_event {
 	struct arm_cmn_node *dn;
-	u64 dtm_idx[4];
+	u64 dtm_idx[DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64)];
 	s8 dtc_idx[CMN_MAX_DTCS];
 	u8 num_dns;
 	u8 dtm_offset;
@@ -1753,10 +1735,7 @@ static int arm_cmn_event_init(struct perf_event *event)
 	}
 
 	if (!hw->num_dns) {
-		struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, nodeid);
-
-		dev_dbg(cmn->dev, "invalid node 0x%x (%d,%d,%d,%d) type 0x%x\n",
-			nodeid, nid.x, nid.y, nid.port, nid.dev, type);
+		dev_dbg(cmn->dev, "invalid node 0x%x type 0x%x\n", nodeid, type);
 		return -EINVAL;
 	}
 
@@ -1851,7 +1830,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 			dtm->wp_event[wp_idx] = hw->dtc_idx[d];
 			writel_relaxed(cfg, dtm->base + CMN_DTM_WPn_CONFIG(wp_idx));
 		} else {
-			struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
+			struct arm_cmn_nodeid nid = arm_cmn_nid(dn);
 
 			if (cmn->multi_dtm)
 				nid.port %= 2;
@@ -2098,10 +2077,12 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
 			continue;
 
 		xp = arm_cmn_node_to_xp(cmn, dn);
+		dn->portid_bits = xp->portid_bits;
+		dn->deviceid_bits = xp->deviceid_bits;
 		dn->dtc = xp->dtc;
 		dn->dtm = xp->dtm;
 		if (cmn->multi_dtm)
-			dn->dtm += arm_cmn_nid(cmn, dn->id).port / 2;
+			dn->dtm += arm_cmn_nid(dn).port / 2;
 
 		if (dn->type == CMN_TYPE_DTC) {
 			int err = arm_cmn_init_dtc(cmn, dn, dtc_idx++);
@@ -2271,18 +2252,27 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 		arm_cmn_init_dtm(dtm++, xp, 0);
 		/*
 		 * Keeping track of connected ports will let us filter out
-		 * unnecessary XP events easily. We can also reliably infer the
-		 * "extra device ports" configuration for the node ID format
-		 * from this, since in that case we will see at least one XP
-		 * with port 2 connected, for the HN-D.
+		 * unnecessary XP events easily, and also infer the per-XP
+		 * part of the node ID format.
 		 */
 		for (int p = 0; p < CMN_MAX_PORTS; p++)
 			if (arm_cmn_device_connect_info(cmn, xp, p))
 				xp_ports |= BIT(p);
 
-		if (cmn->multi_dtm && (xp_ports & 0xc))
+		if (cmn->num_xps == 1) {
+			xp->portid_bits = 3;
+			xp->deviceid_bits = 2;
+		} else if (xp_ports > 0x3) {
+			xp->portid_bits = 2;
+			xp->deviceid_bits = 1;
+		} else {
+			xp->portid_bits = 1;
+			xp->deviceid_bits = 2;
+		}
+
+		if (cmn->multi_dtm && (xp_ports > 0x3))
 			arm_cmn_init_dtm(dtm++, xp, 1);
-		if (cmn->multi_dtm && (xp_ports & 0x30))
+		if (cmn->multi_dtm && (xp_ports > 0xf))
 			arm_cmn_init_dtm(dtm++, xp, 2);
 
 		cmn->ports_used |= xp_ports;
@@ -2337,10 +2327,13 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 			case CMN_TYPE_CXHA:
 			case CMN_TYPE_CCRA:
 			case CMN_TYPE_CCHA:
-			case CMN_TYPE_CCLA:
 			case CMN_TYPE_HNS:
 				dn++;
 				break;
+			case CMN_TYPE_CCLA:
+				dn->pmu_base += CMN_CCLA_PMU_EVENT_SEL;
+				dn++;
+				break;
 			/* Nothing to see here */
 			case CMN_TYPE_MPAM_S:
 			case CMN_TYPE_MPAM_NS:
@@ -2358,7 +2351,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 			case CMN_TYPE_HNP:
 			case CMN_TYPE_CCLA_RNI:
 				dn[1] = dn[0];
-				dn[0].pmu_base += CMN_HNP_PMU_EVENT_SEL;
+				dn[0].pmu_base += CMN_CCLA_PMU_EVENT_SEL;
 				dn[1].type = arm_cmn_subtype(dn->type);
 				dn += 2;
 				break;
diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index c5e328f23841..f205ecad2e4c 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -556,10 +556,10 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
 {
 	struct platform_device *plat_dev;
 	struct dwc_pcie_dev_info *dev_info;
-	u32 bdf;
+	u32 sbdf;
 
-	bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
-	plat_dev = platform_device_register_data(NULL, "dwc_pcie_pmu", bdf,
+	sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
+	plat_dev = platform_device_register_data(NULL, "dwc_pcie_pmu", sbdf,
 						 pdev, sizeof(*pdev));
 
 	if (IS_ERR(plat_dev))
@@ -611,15 +611,15 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 	struct pci_dev *pdev = plat_dev->dev.platform_data;
 	struct dwc_pcie_pmu *pcie_pmu;
 	char *name;
-	u32 bdf, val;
+	u32 sbdf, val;
 	u16 vsec;
 	int ret;
 
 	vsec = pci_find_vsec_capability(pdev, pdev->vendor,
 					DWC_PCIE_VSEC_RAS_DES_ID);
 	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
-	bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
-	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", bdf);
+	sbdf = plat_dev->id;
+	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
 	if (!name)
 		return -ENOMEM;
 
@@ -650,7 +650,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 	ret = cpuhp_state_add_instance(dwc_pcie_pmu_hp_state,
 				       &pcie_pmu->cpuhp_node);
 	if (ret) {
-		pci_err(pdev, "Error %d registering hotplug @%x\n", ret, bdf);
+		pci_err(pdev, "Error %d registering hotplug @%x\n", ret, sbdf);
 		return ret;
 	}
 
@@ -663,7 +663,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 
 	ret = perf_pmu_register(&pcie_pmu->pmu, name, -1);
 	if (ret) {
-		pci_err(pdev, "Error %d registering PMU @%x\n", ret, bdf);
+		pci_err(pdev, "Error %d registering PMU @%x\n", ret, sbdf);
 		return ret;
 	}
 	ret = devm_add_action_or_reset(&plat_dev->dev, dwc_pcie_unregister_pmu,
@@ -726,7 +726,6 @@ static struct platform_driver dwc_pcie_pmu_driver = {
 static int __init dwc_pcie_pmu_init(void)
 {
 	struct pci_dev *pdev = NULL;
-	bool found = false;
 	int ret;
 
 	for_each_pci_dev(pdev) {
@@ -738,11 +737,7 @@ static int __init dwc_pcie_pmu_init(void)
 			pci_dev_put(pdev);
 			return ret;
 		}
-
-		found = true;
 	}
-	if (!found)
-		return -ENODEV;
 
 	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
 				      "perf/dwc_pcie_pmu:online",
diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index f06027574a24..f7d6c59d9930 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -208,7 +208,7 @@ static void hisi_pcie_pmu_writeq(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
 static u64 hisi_pcie_pmu_get_event_ctrl_val(struct perf_event *event)
 {
 	u64 port, trig_len, thr_len, len_mode;
-	u64 reg = HISI_PCIE_INIT_SET;
+	u64 reg = 0;
 
 	/* Config HISI_PCIE_EVENT_CTRL according to event. */
 	reg |= FIELD_PREP(HISI_PCIE_EVENT_M, hisi_pcie_get_real_event(event));
@@ -452,10 +452,24 @@ static void hisi_pcie_pmu_set_period(struct perf_event *event)
 	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
+	u64 orig_cnt, cnt;
+
+	orig_cnt = hisi_pcie_pmu_read_counter(event);
 
 	local64_set(&hwc->prev_count, HISI_PCIE_INIT_VAL);
 	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_CNT, idx, HISI_PCIE_INIT_VAL);
 	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EXT_CNT, idx, HISI_PCIE_INIT_VAL);
+
+	/*
+	 * The counter maybe unwritable if the target event is unsupported.
+	 * Check this by comparing the counts after setting the period. If
+	 * the counts stay unchanged after setting the period then update
+	 * the hwc->prev_count correctly. Otherwise the final counts user
+	 * get maybe totally wrong.
+	 */
+	cnt = hisi_pcie_pmu_read_counter(event);
+	if (orig_cnt == cnt)
+		local64_set(&hwc->prev_count, cnt);
 }
 
 static void hisi_pcie_pmu_enable_counter(struct hisi_pcie_pmu *pcie_pmu, struct hw_perf_event *hwc)
diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 946c01210ac8..3bd9b62b23dc 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -15,6 +15,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/rational.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index 1947da73e512..dce601d99372 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -767,7 +767,7 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 	struct resource fb_res;
 	struct mvebu_mpp_ctrl_data *mpp_data;
 	void __iomem *base;
-	int i;
+	int i, ret;
 
 	pdev->dev.platform_data = (void *)device_get_match_data(&pdev->dev);
 
@@ -783,13 +783,17 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 	clk_prepare_enable(clk);
 
 	base = devm_platform_get_and_ioremap_resource(pdev, 0, &mpp_res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto err_probe;
+	}
 
 	mpp_data = devm_kcalloc(&pdev->dev, dove_pinctrl_info.ncontrols,
 				sizeof(*mpp_data), GFP_KERNEL);
-	if (!mpp_data)
-		return -ENOMEM;
+	if (!mpp_data) {
+		ret = -ENOMEM;
+		goto err_probe;
+	}
 
 	dove_pinctrl_info.control_data = mpp_data;
 	for (i = 0; i < ARRAY_SIZE(dove_mpp_controls); i++)
@@ -808,8 +812,10 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	mpp4_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mpp4_base))
-		return PTR_ERR(mpp4_base);
+	if (IS_ERR(mpp4_base)) {
+		ret = PTR_ERR(mpp4_base);
+		goto err_probe;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
 	if (!res) {
@@ -820,8 +826,10 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	pmu_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pmu_base))
-		return PTR_ERR(pmu_base);
+	if (IS_ERR(pmu_base)) {
+		ret = PTR_ERR(pmu_base);
+		goto err_probe;
+	}
 
 	gconfmap = syscon_regmap_lookup_by_compatible("marvell,dove-global-config");
 	if (IS_ERR(gconfmap)) {
@@ -831,12 +839,17 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 		adjust_resource(&fb_res,
 			(mpp_res->start & INT_REGS_MASK) + GC_REGS_OFFS, 0x14);
 		gc_base = devm_ioremap_resource(&pdev->dev, &fb_res);
-		if (IS_ERR(gc_base))
-			return PTR_ERR(gc_base);
+		if (IS_ERR(gc_base)) {
+			ret = PTR_ERR(gc_base);
+			goto err_probe;
+		}
+
 		gconfmap = devm_regmap_init_mmio(&pdev->dev,
 						 gc_base, &gc_regmap_config);
-		if (IS_ERR(gconfmap))
-			return PTR_ERR(gconfmap);
+		if (IS_ERR(gconfmap)) {
+			ret = PTR_ERR(gconfmap);
+			goto err_probe;
+		}
 	}
 
 	/* Warn on any missing DT resource */
@@ -844,6 +857,9 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, FW_BUG "Missing pinctrl regs in DTB. Please update your firmware.\n");
 
 	return mvebu_pinctrl_probe(pdev);
+err_probe:
+	clk_disable_unprepare(clk);
+	return ret;
 }
 
 static struct platform_driver dove_pinctrl_driver = {
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 4da3c3f422b6..2ec599e383e4 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1913,7 +1913,8 @@ static int pcs_probe(struct platform_device *pdev)
 
 	dev_info(pcs->dev, "%i pins, size %u\n", pcs->desc.npins, pcs->size);
 
-	if (pinctrl_enable(pcs->pctl))
+	ret = pinctrl_enable(pcs->pctl);
+	if (ret)
 		goto free;
 
 	return 0;
diff --git a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
index ef9758638501..451801acdc40 100644
--- a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
+++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
@@ -273,6 +273,22 @@ static int ti_iodelay_pinconf_set(struct ti_iodelay_device *iod,
 	return r;
 }
 
+/**
+ * ti_iodelay_pinconf_deinit_dev() - deinit the iodelay device
+ * @data:	IODelay device
+ *
+ * Deinitialize the IODelay device (basically just lock the region back up.
+ */
+static void ti_iodelay_pinconf_deinit_dev(void *data)
+{
+	struct ti_iodelay_device *iod = data;
+	const struct ti_iodelay_reg_data *reg = iod->reg_data;
+
+	/* lock the iodelay region back again */
+	regmap_update_bits(iod->regmap, reg->reg_global_lock_offset,
+			   reg->global_lock_mask, reg->global_lock_val);
+}
+
 /**
  * ti_iodelay_pinconf_init_dev() - Initialize IODelay device
  * @iod: iodelay device
@@ -295,6 +311,11 @@ static int ti_iodelay_pinconf_init_dev(struct ti_iodelay_device *iod)
 	if (r)
 		return r;
 
+	r = devm_add_action_or_reset(iod->dev, ti_iodelay_pinconf_deinit_dev,
+				     iod);
+	if (r)
+		return r;
+
 	/* Read up Recalibration sequence done by bootloader */
 	r = regmap_read(iod->regmap, reg->reg_refclk_offset, &val);
 	if (r)
@@ -353,21 +374,6 @@ static int ti_iodelay_pinconf_init_dev(struct ti_iodelay_device *iod)
 	return 0;
 }
 
-/**
- * ti_iodelay_pinconf_deinit_dev() - deinit the iodelay device
- * @iod:	IODelay device
- *
- * Deinitialize the IODelay device (basically just lock the region back up.
- */
-static void ti_iodelay_pinconf_deinit_dev(struct ti_iodelay_device *iod)
-{
-	const struct ti_iodelay_reg_data *reg = iod->reg_data;
-
-	/* lock the iodelay region back again */
-	regmap_update_bits(iod->regmap, reg->reg_global_lock_offset,
-			   reg->global_lock_mask, reg->global_lock_val);
-}
-
 /**
  * ti_iodelay_get_pingroup() - Find the group mapped by a group selector
  * @iod: iodelay device
@@ -822,53 +828,48 @@ MODULE_DEVICE_TABLE(of, ti_iodelay_of_match);
 static int ti_iodelay_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = of_node_get(dev->of_node);
+	struct device_node *np __free(device_node) = of_node_get(dev->of_node);
 	struct resource *res;
 	struct ti_iodelay_device *iod;
-	int ret = 0;
+	int ret;
 
 	if (!np) {
-		ret = -EINVAL;
 		dev_err(dev, "No OF node\n");
-		goto exit_out;
+		return -EINVAL;
 	}
 
 	iod = devm_kzalloc(dev, sizeof(*iod), GFP_KERNEL);
-	if (!iod) {
-		ret = -ENOMEM;
-		goto exit_out;
-	}
+	if (!iod)
+		return -ENOMEM;
+
 	iod->dev = dev;
 	iod->reg_data = device_get_match_data(dev);
 	if (!iod->reg_data) {
-		ret = -EINVAL;
 		dev_err(dev, "No DATA match\n");
-		goto exit_out;
+		return -EINVAL;
 	}
 
 	/* So far We can assume there is only 1 bank of registers */
 	iod->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(iod->reg_base)) {
-		ret = PTR_ERR(iod->reg_base);
-		goto exit_out;
-	}
+	if (IS_ERR(iod->reg_base))
+		return PTR_ERR(iod->reg_base);
+
 	iod->phys_base = res->start;
 
 	iod->regmap = devm_regmap_init_mmio(dev, iod->reg_base,
 					    iod->reg_data->regmap_config);
 	if (IS_ERR(iod->regmap)) {
 		dev_err(dev, "Regmap MMIO init failed.\n");
-		ret = PTR_ERR(iod->regmap);
-		goto exit_out;
+		return PTR_ERR(iod->regmap);
 	}
 
 	ret = ti_iodelay_pinconf_init_dev(iod);
 	if (ret)
-		goto exit_out;
+		return ret;
 
 	ret = ti_iodelay_alloc_pins(dev, iod, res->start);
 	if (ret)
-		goto exit_out;
+		return ret;
 
 	iod->desc.pctlops = &ti_iodelay_pinctrl_ops;
 	/* no pinmux ops - we are pinconf */
@@ -879,38 +880,14 @@ static int ti_iodelay_probe(struct platform_device *pdev)
 	ret = devm_pinctrl_register_and_init(dev, &iod->desc, iod, &iod->pctl);
 	if (ret) {
 		dev_err(dev, "Failed to register pinctrl\n");
-		goto exit_out;
+		return ret;
 	}
 
-	platform_set_drvdata(pdev, iod);
-
-	ret = pinctrl_enable(iod->pctl);
-	if (ret)
-		goto exit_out;
-
-	return 0;
-
-exit_out:
-	of_node_put(np);
-	return ret;
-}
-
-/**
- * ti_iodelay_remove() - standard remove
- * @pdev: platform device
- */
-static void ti_iodelay_remove(struct platform_device *pdev)
-{
-	struct ti_iodelay_device *iod = platform_get_drvdata(pdev);
-
-	ti_iodelay_pinconf_deinit_dev(iod);
-
-	/* Expect other allocations to be freed by devm */
+	return pinctrl_enable(iod->pctl);
 }
 
 static struct platform_driver ti_iodelay_driver = {
 	.probe = ti_iodelay_probe,
-	.remove_new = ti_iodelay_remove,
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = ti_iodelay_of_match,
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 490815917ade..32293df50bb1 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -422,13 +422,14 @@ static ssize_t camera_power_show(struct device *dev,
 				 char *buf)
 {
 	struct ideapad_private *priv = dev_get_drvdata(dev);
-	unsigned long result;
+	unsigned long result = 0;
 	int err;
 
-	scoped_guard(mutex, &priv->vpc_mutex)
+	scoped_guard(mutex, &priv->vpc_mutex) {
 		err = read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &result);
-	if (err)
-		return err;
+		if (err)
+			return err;
+	}
 
 	return sysfs_emit(buf, "%d\n", !!result);
 }
@@ -445,10 +446,11 @@ static ssize_t camera_power_store(struct device *dev,
 	if (err)
 		return err;
 
-	scoped_guard(mutex, &priv->vpc_mutex)
+	scoped_guard(mutex, &priv->vpc_mutex) {
 		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_CAMERA, state);
-	if (err)
-		return err;
+		if (err)
+			return err;
+	}
 
 	return count;
 }
@@ -496,13 +498,14 @@ static ssize_t fan_mode_show(struct device *dev,
 			     char *buf)
 {
 	struct ideapad_private *priv = dev_get_drvdata(dev);
-	unsigned long result;
+	unsigned long result = 0;
 	int err;
 
-	scoped_guard(mutex, &priv->vpc_mutex)
+	scoped_guard(mutex, &priv->vpc_mutex) {
 		err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN, &result);
-	if (err)
-		return err;
+		if (err)
+			return err;
+	}
 
 	return sysfs_emit(buf, "%lu\n", result);
 }
@@ -522,10 +525,11 @@ static ssize_t fan_mode_store(struct device *dev,
 	if (state > 4 || state == 3)
 		return -EINVAL;
 
-	scoped_guard(mutex, &priv->vpc_mutex)
+	scoped_guard(mutex, &priv->vpc_mutex) {
 		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_FAN, state);
-	if (err)
-		return err;
+		if (err)
+			return err;
+	}
 
 	return count;
 }
@@ -605,13 +609,14 @@ static ssize_t touchpad_show(struct device *dev,
 			     char *buf)
 {
 	struct ideapad_private *priv = dev_get_drvdata(dev);
-	unsigned long result;
+	unsigned long result = 0;
 	int err;
 
-	scoped_guard(mutex, &priv->vpc_mutex)
+	scoped_guard(mutex, &priv->vpc_mutex) {
 		err = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &result);
-	if (err)
-		return err;
+		if (err)
+			return err;
+	}
 
 	priv->r_touchpad_val = result;
 
@@ -630,10 +635,11 @@ static ssize_t touchpad_store(struct device *dev,
 	if (err)
 		return err;
 
-	scoped_guard(mutex, &priv->vpc_mutex)
+	scoped_guard(mutex, &priv->vpc_mutex) {
 		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_TOUCHPAD, state);
-	if (err)
-		return err;
+		if (err)
+			return err;
+	}
 
 	priv->r_touchpad_val = state;
 
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 623d15b68707..0ab6008e863e 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3153,7 +3153,7 @@ static int genpd_summary_one(struct seq_file *s,
 	else
 		snprintf(state, sizeof(state), "%s",
 			 status_lookup[genpd->status]);
-	seq_printf(s, "%-30s  %-50s %u", genpd->name, state, genpd->performance_state);
+	seq_printf(s, "%-30s  %-49s  %u", genpd->name, state, genpd->performance_state);
 
 	/*
 	 * Modifications on the list require holding locks on both
diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 6ac5c80cfda2..7520b599eb3d 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -303,11 +303,11 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 		val->intval = reg & AXP209_FG_PERCENT;
 		break;
 
-	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
 		return axp20x_batt->data->get_max_voltage(axp20x_batt,
 							  &val->intval);
 
-	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		ret = regmap_read(axp20x_batt->regmap, AXP20X_V_OFF, &reg);
 		if (ret)
 			return ret;
@@ -455,10 +455,10 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
 	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
 
 	switch (psp) {
-	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		return axp20x_set_voltage_min_design(axp20x_batt, val->intval);
 
-	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
 		return axp20x_batt->data->set_max_voltage(axp20x_batt, val->intval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
@@ -493,8 +493,8 @@ static enum power_supply_property axp20x_battery_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_HEALTH,
-	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
-	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
 	POWER_SUPPLY_PROP_CAPACITY,
 };
 
@@ -502,8 +502,8 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
 					 enum power_supply_property psp)
 {
 	return psp == POWER_SUPPLY_PROP_STATUS ||
-	       psp == POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
-	       psp == POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
+	       psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
+	       psp == POWER_SUPPLY_PROP_VOLTAGE_MAX ||
 	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT ||
 	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
 }
diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index e7d37e422c3f..496c3e1f2ee6 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -853,7 +853,10 @@ static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 off)
 	/* program interrupt thresholds such that we should
 	 * get interrupt for every 'off' perc change in the soc
 	 */
-	regmap_read(map, MAX17042_RepSOC, &soc);
+	if (chip->pdata->enable_current_sense)
+		regmap_read(map, MAX17042_RepSOC, &soc);
+	else
+		regmap_read(map, MAX17042_VFSOC, &soc);
 	soc >>= 8;
 	soc_tr = (soc + off) << 8;
 	if (off < soc)
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 8e7f4c0473ab..9bf9ed9a6a54 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -740,7 +740,7 @@ static struct rapl_primitive_info *get_rpi(struct rapl_package *rp, int prim)
 {
 	struct rapl_primitive_info *rpi = rp->priv->rpi;
 
-	if (prim < 0 || prim > NR_RAPL_PRIMITIVES || !rpi)
+	if (prim < 0 || prim >= NR_RAPL_PRIMITIVES || !rpi)
 		return NULL;
 
 	return &rpi[prim];
diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index af972cdc04b5..53e9c304ae0a 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -149,6 +149,9 @@ static void parport_attach(struct parport *port)
 	}
 
 	index = ida_alloc(&pps_client_index, GFP_KERNEL);
+	if (index < 0)
+		goto err_free_device;
+
 	memset(&pps_client_cb, 0, sizeof(pps_client_cb));
 	pps_client_cb.private = device;
 	pps_client_cb.irq_func = parport_irq;
@@ -159,7 +162,7 @@ static void parport_attach(struct parport *port)
 						    index);
 	if (!device->pardev) {
 		pr_err("couldn't register with %s\n", port->name);
-		goto err_free;
+		goto err_free_ida;
 	}
 
 	if (parport_claim_or_block(device->pardev) < 0) {
@@ -187,8 +190,9 @@ static void parport_attach(struct parport *port)
 	parport_release(device->pardev);
 err_unregister_dev:
 	parport_unregister_device(device->pardev);
-err_free:
+err_free_ida:
 	ida_free(&pps_client_index, index);
+err_free_device:
 	kfree(device);
 }
 
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 03afc160fc72..86b680adbf01 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -777,7 +777,7 @@ int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 			name[i] = '\0';
 			tmp = regulator_get(dev, name);
 			if (IS_ERR(tmp)) {
-				ret = -EINVAL;
+				ret = PTR_ERR(tmp);
 				goto error;
 			}
 			(*consumers)[n].consumer = tmp;
diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 144c8e9a642e..448b9a5438e0 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -210,7 +210,7 @@ static const struct imx_rproc_att imx_rproc_att_imx8mq[] = {
 	/* QSPI Code - alias */
 	{ 0x08000000, 0x08000000, 0x08000000, 0 },
 	/* DDR (Code) - alias */
-	{ 0x10000000, 0x80000000, 0x0FFE0000, 0 },
+	{ 0x10000000, 0x40000000, 0x0FFE0000, 0 },
 	/* TCML */
 	{ 0x1FFE0000, 0x007E0000, 0x00020000, ATT_OWN  | ATT_IOMEM},
 	/* TCMU */
@@ -1076,6 +1076,8 @@ static int imx_rproc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
+
 	ret = imx_rproc_xtr_mbox_init(rproc);
 	if (ret)
 		goto err_put_wkq;
@@ -1094,8 +1096,6 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_put_scu;
 
-	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
-
 	if (rproc->state != RPROC_DETACHED)
 		rproc->auto_boot = of_property_read_bool(np, "fsl,auto-boot");
 
diff --git a/drivers/reset/reset-berlin.c b/drivers/reset/reset-berlin.c
index 2537ec05ecee..578fe867080c 100644
--- a/drivers/reset/reset-berlin.c
+++ b/drivers/reset/reset-berlin.c
@@ -68,13 +68,14 @@ static int berlin_reset_xlate(struct reset_controller_dev *rcdev,
 
 static int berlin2_reset_probe(struct platform_device *pdev)
 {
-	struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
+	struct device_node *parent_np;
 	struct berlin_reset_priv *priv;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	parent_np = of_get_parent(pdev->dev.of_node);
 	priv->regmap = syscon_node_to_regmap(parent_np);
 	of_node_put(parent_np);
 	if (IS_ERR(priv->regmap))
diff --git a/drivers/reset/reset-k210.c b/drivers/reset/reset-k210.c
index b62a2fd44e4e..e77e4cca377d 100644
--- a/drivers/reset/reset-k210.c
+++ b/drivers/reset/reset-k210.c
@@ -90,7 +90,7 @@ static const struct reset_control_ops k210_rst_ops = {
 static int k210_rst_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *parent_np = of_get_parent(dev->of_node);
+	struct device_node *parent_np;
 	struct k210_rst *ksr;
 
 	dev_info(dev, "K210 reset controller\n");
@@ -99,6 +99,7 @@ static int k210_rst_probe(struct platform_device *pdev)
 	if (!ksr)
 		return -ENOMEM;
 
+	parent_np = of_get_parent(dev->of_node);
 	ksr->map = syscon_node_to_regmap(parent_np);
 	of_node_put(parent_np);
 	if (IS_ERR(ksr->map))
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 99fadfb4cd9f..09acc321d013 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -107,6 +107,7 @@ debug_info_t *ap_dbf_info;
 static bool ap_scan_bus(void);
 static bool ap_scan_bus_result; /* result of last ap_scan_bus() */
 static DEFINE_MUTEX(ap_scan_bus_mutex); /* mutex ap_scan_bus() invocations */
+static struct task_struct *ap_scan_bus_task; /* thread holding the scan mutex */
 static atomic64_t ap_scan_bus_count; /* counter ap_scan_bus() invocations */
 static int ap_scan_bus_time = AP_CONFIG_TIME;
 static struct timer_list ap_scan_bus_timer;
@@ -1006,11 +1007,25 @@ bool ap_bus_force_rescan(void)
 	if (scan_counter <= 0)
 		goto out;
 
+	/*
+	 * There is one unlikely but nevertheless valid scenario where the
+	 * thread holding the mutex may try to send some crypto load but
+	 * all cards are offline so a rescan is triggered which causes
+	 * a recursive call of ap_bus_force_rescan(). A simple return if
+	 * the mutex is already locked by this thread solves this.
+	 */
+	if (mutex_is_locked(&ap_scan_bus_mutex)) {
+		if (ap_scan_bus_task == current)
+			goto out;
+	}
+
 	/* Try to acquire the AP scan bus mutex */
 	if (mutex_trylock(&ap_scan_bus_mutex)) {
 		/* mutex acquired, run the AP bus scan */
+		ap_scan_bus_task = current;
 		ap_scan_bus_result = ap_scan_bus();
 		rc = ap_scan_bus_result;
+		ap_scan_bus_task = NULL;
 		mutex_unlock(&ap_scan_bus_mutex);
 		goto out;
 	}
@@ -2284,7 +2299,9 @@ static void ap_scan_bus_wq_callback(struct work_struct *unused)
 	 * system_long_wq which invokes this function here again.
 	 */
 	if (mutex_trylock(&ap_scan_bus_mutex)) {
+		ap_scan_bus_task = current;
 		ap_scan_bus_result = ap_scan_bus();
+		ap_scan_bus_task = NULL;
 		mutex_unlock(&ap_scan_bus_mutex);
 	}
 }
diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index cea3a79d538e..00e245173320 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -1485,6 +1485,7 @@ static int NCR5380_transfer_dma(struct Scsi_Host *instance,
 				unsigned char **data)
 {
 	struct NCR5380_hostdata *hostdata = shost_priv(instance);
+	struct NCR5380_cmd *ncmd = NCR5380_to_ncmd(hostdata->connected);
 	int c = *count;
 	unsigned char p = *phase;
 	unsigned char *d = *data;
@@ -1496,7 +1497,7 @@ static int NCR5380_transfer_dma(struct Scsi_Host *instance,
 		return -1;
 	}
 
-	NCR5380_to_ncmd(hostdata->connected)->phase = p;
+	ncmd->phase = p;
 
 	if (p & SR_IO) {
 		if (hostdata->read_overruns)
@@ -1608,45 +1609,44 @@ static int NCR5380_transfer_dma(struct Scsi_Host *instance,
  * request.
  */
 
-	if (hostdata->flags & FLAG_DMA_FIXUP) {
-		if (p & SR_IO) {
-			/*
-			 * The workaround was to transfer fewer bytes than we
-			 * intended to with the pseudo-DMA read function, wait for
-			 * the chip to latch the last byte, read it, and then disable
-			 * pseudo-DMA mode.
-			 *
-			 * After REQ is asserted, the NCR5380 asserts DRQ and ACK.
-			 * REQ is deasserted when ACK is asserted, and not reasserted
-			 * until ACK goes false.  Since the NCR5380 won't lower ACK
-			 * until DACK is asserted, which won't happen unless we twiddle
-			 * the DMA port or we take the NCR5380 out of DMA mode, we
-			 * can guarantee that we won't handshake another extra
-			 * byte.
-			 */
-
-			if (NCR5380_poll_politely(hostdata, BUS_AND_STATUS_REG,
-			                          BASR_DRQ, BASR_DRQ, 0) < 0) {
-				result = -1;
-				shost_printk(KERN_ERR, instance, "PDMA read: DRQ timeout\n");
-			}
-			if (NCR5380_poll_politely(hostdata, STATUS_REG,
-			                          SR_REQ, 0, 0) < 0) {
-				result = -1;
-				shost_printk(KERN_ERR, instance, "PDMA read: !REQ timeout\n");
-			}
-			d[*count - 1] = NCR5380_read(INPUT_DATA_REG);
-		} else {
-			/*
-			 * Wait for the last byte to be sent.  If REQ is being asserted for
-			 * the byte we're interested, we'll ACK it and it will go false.
-			 */
-			if (NCR5380_poll_politely2(hostdata,
-			     BUS_AND_STATUS_REG, BASR_DRQ, BASR_DRQ,
-			     BUS_AND_STATUS_REG, BASR_PHASE_MATCH, 0, 0) < 0) {
-				result = -1;
-				shost_printk(KERN_ERR, instance, "PDMA write: DRQ and phase timeout\n");
+	if ((hostdata->flags & FLAG_DMA_FIXUP) &&
+	    (NCR5380_read(BUS_AND_STATUS_REG) & BASR_PHASE_MATCH)) {
+		/*
+		 * The workaround was to transfer fewer bytes than we
+		 * intended to with the pseudo-DMA receive function, wait for
+		 * the chip to latch the last byte, read it, and then disable
+		 * DMA mode.
+		 *
+		 * After REQ is asserted, the NCR5380 asserts DRQ and ACK.
+		 * REQ is deasserted when ACK is asserted, and not reasserted
+		 * until ACK goes false. Since the NCR5380 won't lower ACK
+		 * until DACK is asserted, which won't happen unless we twiddle
+		 * the DMA port or we take the NCR5380 out of DMA mode, we
+		 * can guarantee that we won't handshake another extra
+		 * byte.
+		 *
+		 * If sending, wait for the last byte to be sent. If REQ is
+		 * being asserted for the byte we're interested, we'll ACK it
+		 * and it will go false.
+		 */
+		if (!NCR5380_poll_politely(hostdata, BUS_AND_STATUS_REG,
+					   BASR_DRQ, BASR_DRQ, 0)) {
+			if ((p & SR_IO) &&
+			    (NCR5380_read(BUS_AND_STATUS_REG) & BASR_PHASE_MATCH)) {
+				if (!NCR5380_poll_politely(hostdata, STATUS_REG,
+							   SR_REQ, 0, 0)) {
+					d[c] = NCR5380_read(INPUT_DATA_REG);
+					--ncmd->this_residual;
+				} else {
+					result = -1;
+					scmd_printk(KERN_ERR, hostdata->connected,
+						    "PDMA fixup: !REQ timeout\n");
+				}
 			}
+		} else if (NCR5380_read(BUS_AND_STATUS_REG) & BASR_PHASE_MATCH) {
+			result = -1;
+			scmd_printk(KERN_ERR, hostdata->connected,
+				    "PDMA fixup: DRQ timeout\n");
 		}
 	}
 
diff --git a/drivers/scsi/elx/libefc/efc_nport.c b/drivers/scsi/elx/libefc/efc_nport.c
index 2e83a667901f..1a7437f4328e 100644
--- a/drivers/scsi/elx/libefc/efc_nport.c
+++ b/drivers/scsi/elx/libefc/efc_nport.c
@@ -705,9 +705,9 @@ efc_nport_vport_del(struct efc *efc, struct efc_domain *domain,
 	spin_lock_irqsave(&efc->lock, flags);
 	list_for_each_entry(nport, &domain->nport_list, list_entry) {
 		if (nport->wwpn == wwpn && nport->wwnn == wwnn) {
-			kref_put(&nport->ref, nport->release);
 			/* Shutdown this NPORT */
 			efc_sm_post_event(&nport->sm, EFC_EVT_SHUTDOWN, NULL);
+			kref_put(&nport->ref, nport->release);
 			break;
 		}
 	}
diff --git a/drivers/scsi/lpfc/lpfc_hw4.h b/drivers/scsi/lpfc/lpfc_hw4.h
index 500253007b1d..26e1313ebb21 100644
--- a/drivers/scsi/lpfc/lpfc_hw4.h
+++ b/drivers/scsi/lpfc/lpfc_hw4.h
@@ -4847,6 +4847,7 @@ struct fcp_iwrite64_wqe {
 #define	cmd_buff_len_SHIFT  16
 #define	cmd_buff_len_MASK  0x00000ffff
 #define	cmd_buff_len_WORD  word3
+/* Note: payload_offset_len field depends on ASIC support */
 #define payload_offset_len_SHIFT 0
 #define payload_offset_len_MASK 0x0000ffff
 #define payload_offset_len_WORD word3
@@ -4863,6 +4864,7 @@ struct fcp_iread64_wqe {
 #define	cmd_buff_len_SHIFT  16
 #define	cmd_buff_len_MASK  0x00000ffff
 #define	cmd_buff_len_WORD  word3
+/* Note: payload_offset_len field depends on ASIC support */
 #define payload_offset_len_SHIFT 0
 #define payload_offset_len_MASK 0x0000ffff
 #define payload_offset_len_WORD word3
@@ -4879,6 +4881,7 @@ struct fcp_icmnd64_wqe {
 #define	cmd_buff_len_SHIFT  16
 #define	cmd_buff_len_MASK  0x00000ffff
 #define	cmd_buff_len_WORD  word3
+/* Note: payload_offset_len field depends on ASIC support */
 #define payload_offset_len_SHIFT 0
 #define payload_offset_len_MASK 0x0000ffff
 #define payload_offset_len_WORD word3
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index e1dfa96c2a55..0c1404dc5f3b 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4699,6 +4699,7 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 	uint64_t wwn;
 	bool use_no_reset_hba = false;
 	int rc;
+	u8 if_type;
 
 	if (lpfc_no_hba_reset_cnt) {
 		if (phba->sli_rev < LPFC_SLI_REV4 &&
@@ -4773,10 +4774,24 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 	shost->max_id = LPFC_MAX_TARGET;
 	shost->max_lun = vport->cfg_max_luns;
 	shost->this_id = -1;
-	if (phba->sli_rev == LPFC_SLI_REV4)
-		shost->max_cmd_len = LPFC_FCP_CDB_LEN_32;
-	else
+
+	/* Set max_cmd_len applicable to ASIC support */
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		if_type = bf_get(lpfc_sli_intf_if_type,
+				 &phba->sli4_hba.sli_intf);
+		switch (if_type) {
+		case LPFC_SLI_INTF_IF_TYPE_2:
+			fallthrough;
+		case LPFC_SLI_INTF_IF_TYPE_6:
+			shost->max_cmd_len = LPFC_FCP_CDB_LEN_32;
+			break;
+		default:
+			shost->max_cmd_len = LPFC_FCP_CDB_LEN;
+			break;
+		}
+	} else {
 		shost->max_cmd_len = LPFC_FCP_CDB_LEN;
+	}
 
 	if (phba->sli_rev == LPFC_SLI_REV4) {
 		if (!phba->cfg_fcp_mq_threshold ||
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 98ce9d97a225..9f0b59672e19 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4760,7 +4760,7 @@ static int lpfc_scsi_prep_cmnd_buf_s4(struct lpfc_vport *vport,
 
 	 /* Word 3 */
 	bf_set(payload_offset_len, &wqe->fcp_icmd,
-	       sizeof(struct fcp_cmnd32) + sizeof(struct fcp_rsp));
+	       sizeof(struct fcp_cmnd) + sizeof(struct fcp_rsp));
 
 	/* Word 6 */
 	bf_set(wqe_ctxt_tag, &wqe->generic.wqe_com,
diff --git a/drivers/scsi/mac_scsi.c b/drivers/scsi/mac_scsi.c
index a402c4dc4645..2e9fad1e3069 100644
--- a/drivers/scsi/mac_scsi.c
+++ b/drivers/scsi/mac_scsi.c
@@ -102,11 +102,15 @@ __setup("mac5380=", mac_scsi_setup);
  * Linux SCSI drivers lack knowledge of the timing behaviour of SCSI targets
  * so bus errors are unavoidable.
  *
- * If a MOVE.B instruction faults, we assume that zero bytes were transferred
- * and simply retry. That assumption probably depends on target behaviour but
- * seems to hold up okay. The NOP provides synchronization: without it the
- * fault can sometimes occur after the program counter has moved past the
- * offending instruction. Post-increment addressing can't be used.
+ * If a MOVE.B instruction faults during a receive operation, we assume the
+ * target sent nothing and try again. That assumption probably depends on
+ * target firmware but it seems to hold up okay. If a fault happens during a
+ * send operation, the target may or may not have seen /ACK and got the byte.
+ * It's uncertain so the whole SCSI command gets retried.
+ *
+ * The NOP is needed for synchronization because the fault address in the
+ * exception stack frame may or may not be the instruction that actually
+ * caused the bus error. Post-increment addressing can't be used.
  */
 
 #define MOVE_BYTE(operands) \
@@ -208,8 +212,6 @@ __setup("mac5380=", mac_scsi_setup);
 		".previous                     \n" \
 		: "+a" (addr), "+r" (n), "+r" (result) : "a" (io))
 
-#define MAC_PDMA_DELAY		32
-
 static inline int mac_pdma_recv(void __iomem *io, unsigned char *start, int n)
 {
 	unsigned char *addr = start;
@@ -245,22 +247,21 @@ static inline int mac_pdma_send(unsigned char *start, void __iomem *io, int n)
 	if (n >= 1) {
 		MOVE_BYTE("%0@,%3@");
 		if (result)
-			goto out;
+			return -1;
 	}
 	if (n >= 1 && ((unsigned long)addr & 1)) {
 		MOVE_BYTE("%0@,%3@");
 		if (result)
-			goto out;
+			return -2;
 	}
 	while (n >= 32)
 		MOVE_16_WORDS("%0@+,%3@");
 	while (n >= 2)
 		MOVE_WORD("%0@+,%3@");
 	if (result)
-		return start - addr; /* Negated to indicate uncertain length */
+		return start - addr - 1; /* Negated to indicate uncertain length */
 	if (n == 1)
 		MOVE_BYTE("%0@,%3@");
-out:
 	return addr - start;
 }
 
@@ -274,25 +275,56 @@ static inline void write_ctrl_reg(struct NCR5380_hostdata *hostdata, u32 value)
 	out_be32(hostdata->io + (CTRL_REG << 4), value);
 }
 
+static inline int macscsi_wait_for_drq(struct NCR5380_hostdata *hostdata)
+{
+	unsigned int n = 1; /* effectively multiplies NCR5380_REG_POLL_TIME */
+	unsigned char basr;
+
+again:
+	basr = NCR5380_read(BUS_AND_STATUS_REG);
+
+	if (!(basr & BASR_PHASE_MATCH))
+		return 1;
+
+	if (basr & BASR_IRQ)
+		return -1;
+
+	if (basr & BASR_DRQ)
+		return 0;
+
+	if (n-- == 0) {
+		NCR5380_dprint(NDEBUG_PSEUDO_DMA, hostdata->host);
+		dsprintk(NDEBUG_PSEUDO_DMA, hostdata->host,
+			 "%s: DRQ timeout\n", __func__);
+		return -1;
+	}
+
+	NCR5380_poll_politely2(hostdata,
+			       BUS_AND_STATUS_REG, BASR_DRQ, BASR_DRQ,
+			       BUS_AND_STATUS_REG, BASR_PHASE_MATCH, 0, 0);
+	goto again;
+}
+
 static inline int macscsi_pread(struct NCR5380_hostdata *hostdata,
                                 unsigned char *dst, int len)
 {
 	u8 __iomem *s = hostdata->pdma_io + (INPUT_DATA_REG << 4);
 	unsigned char *d = dst;
-	int result = 0;
 
 	hostdata->pdma_residual = len;
 
-	while (!NCR5380_poll_politely(hostdata, BUS_AND_STATUS_REG,
-	                              BASR_DRQ | BASR_PHASE_MATCH,
-	                              BASR_DRQ | BASR_PHASE_MATCH, 0)) {
-		int bytes;
+	while (macscsi_wait_for_drq(hostdata) == 0) {
+		int bytes, chunk_bytes;
 
 		if (macintosh_config->ident == MAC_MODEL_IIFX)
 			write_ctrl_reg(hostdata, CTRL_HANDSHAKE_MODE |
 			                         CTRL_INTERRUPTS_ENABLE);
 
-		bytes = mac_pdma_recv(s, d, min(hostdata->pdma_residual, 512));
+		chunk_bytes = min(hostdata->pdma_residual, 512);
+		bytes = mac_pdma_recv(s, d, chunk_bytes);
+
+		if (macintosh_config->ident == MAC_MODEL_IIFX)
+			write_ctrl_reg(hostdata, CTRL_INTERRUPTS_ENABLE);
 
 		if (bytes > 0) {
 			d += bytes;
@@ -300,37 +332,25 @@ static inline int macscsi_pread(struct NCR5380_hostdata *hostdata,
 		}
 
 		if (hostdata->pdma_residual == 0)
-			goto out;
+			break;
 
-		if (NCR5380_poll_politely2(hostdata, STATUS_REG, SR_REQ, SR_REQ,
-		                           BUS_AND_STATUS_REG, BASR_ACK,
-		                           BASR_ACK, 0) < 0)
-			scmd_printk(KERN_DEBUG, hostdata->connected,
-			            "%s: !REQ and !ACK\n", __func__);
-		if (!(NCR5380_read(BUS_AND_STATUS_REG) & BASR_PHASE_MATCH))
-			goto out;
+		if (bytes > 0)
+			continue;
 
-		if (bytes == 0)
-			udelay(MAC_PDMA_DELAY);
+		NCR5380_dprint(NDEBUG_PSEUDO_DMA, hostdata->host);
+		dsprintk(NDEBUG_PSEUDO_DMA, hostdata->host,
+			 "%s: bus error [%d/%d] (%d/%d)\n",
+			 __func__, d - dst, len, bytes, chunk_bytes);
 
-		if (bytes >= 0)
+		if (bytes == 0)
 			continue;
 
-		dsprintk(NDEBUG_PSEUDO_DMA, hostdata->host,
-		         "%s: bus error (%d/%d)\n", __func__, d - dst, len);
-		NCR5380_dprint(NDEBUG_PSEUDO_DMA, hostdata->host);
-		result = -1;
-		goto out;
+		if (macscsi_wait_for_drq(hostdata) <= 0)
+			set_host_byte(hostdata->connected, DID_ERROR);
+		break;
 	}
 
-	scmd_printk(KERN_ERR, hostdata->connected,
-	            "%s: phase mismatch or !DRQ\n", __func__);
-	NCR5380_dprint(NDEBUG_PSEUDO_DMA, hostdata->host);
-	result = -1;
-out:
-	if (macintosh_config->ident == MAC_MODEL_IIFX)
-		write_ctrl_reg(hostdata, CTRL_INTERRUPTS_ENABLE);
-	return result;
+	return 0;
 }
 
 static inline int macscsi_pwrite(struct NCR5380_hostdata *hostdata,
@@ -338,67 +358,47 @@ static inline int macscsi_pwrite(struct NCR5380_hostdata *hostdata,
 {
 	unsigned char *s = src;
 	u8 __iomem *d = hostdata->pdma_io + (OUTPUT_DATA_REG << 4);
-	int result = 0;
 
 	hostdata->pdma_residual = len;
 
-	while (!NCR5380_poll_politely(hostdata, BUS_AND_STATUS_REG,
-	                              BASR_DRQ | BASR_PHASE_MATCH,
-	                              BASR_DRQ | BASR_PHASE_MATCH, 0)) {
-		int bytes;
+	while (macscsi_wait_for_drq(hostdata) == 0) {
+		int bytes, chunk_bytes;
 
 		if (macintosh_config->ident == MAC_MODEL_IIFX)
 			write_ctrl_reg(hostdata, CTRL_HANDSHAKE_MODE |
 			                         CTRL_INTERRUPTS_ENABLE);
 
-		bytes = mac_pdma_send(s, d, min(hostdata->pdma_residual, 512));
+		chunk_bytes = min(hostdata->pdma_residual, 512);
+		bytes = mac_pdma_send(s, d, chunk_bytes);
+
+		if (macintosh_config->ident == MAC_MODEL_IIFX)
+			write_ctrl_reg(hostdata, CTRL_INTERRUPTS_ENABLE);
 
 		if (bytes > 0) {
 			s += bytes;
 			hostdata->pdma_residual -= bytes;
 		}
 
-		if (hostdata->pdma_residual == 0) {
-			if (NCR5380_poll_politely(hostdata, TARGET_COMMAND_REG,
-			                          TCR_LAST_BYTE_SENT,
-			                          TCR_LAST_BYTE_SENT,
-			                          0) < 0) {
-				scmd_printk(KERN_ERR, hostdata->connected,
-				            "%s: Last Byte Sent timeout\n", __func__);
-				result = -1;
-			}
-			goto out;
-		}
+		if (hostdata->pdma_residual == 0)
+			break;
 
-		if (NCR5380_poll_politely2(hostdata, STATUS_REG, SR_REQ, SR_REQ,
-		                           BUS_AND_STATUS_REG, BASR_ACK,
-		                           BASR_ACK, 0) < 0)
-			scmd_printk(KERN_DEBUG, hostdata->connected,
-			            "%s: !REQ and !ACK\n", __func__);
-		if (!(NCR5380_read(BUS_AND_STATUS_REG) & BASR_PHASE_MATCH))
-			goto out;
+		if (bytes > 0)
+			continue;
 
-		if (bytes == 0)
-			udelay(MAC_PDMA_DELAY);
+		NCR5380_dprint(NDEBUG_PSEUDO_DMA, hostdata->host);
+		dsprintk(NDEBUG_PSEUDO_DMA, hostdata->host,
+			 "%s: bus error [%d/%d] (%d/%d)\n",
+			 __func__, s - src, len, bytes, chunk_bytes);
 
-		if (bytes >= 0)
+		if (bytes == 0)
 			continue;
 
-		dsprintk(NDEBUG_PSEUDO_DMA, hostdata->host,
-		         "%s: bus error (%d/%d)\n", __func__, s - src, len);
-		NCR5380_dprint(NDEBUG_PSEUDO_DMA, hostdata->host);
-		result = -1;
-		goto out;
+		if (macscsi_wait_for_drq(hostdata) <= 0)
+			set_host_byte(hostdata->connected, DID_ERROR);
+		break;
 	}
 
-	scmd_printk(KERN_ERR, hostdata->connected,
-	            "%s: phase mismatch or !DRQ\n", __func__);
-	NCR5380_dprint(NDEBUG_PSEUDO_DMA, hostdata->host);
-	result = -1;
-out:
-	if (macintosh_config->ident == MAC_MODEL_IIFX)
-		write_ctrl_reg(hostdata, CTRL_INTERRUPTS_ENABLE);
-	return result;
+	return 0;
 }
 
 static int macscsi_dma_xfer_len(struct NCR5380_hostdata *hostdata,
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 7d2a294ebc3d..5dd100175ec6 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3283,7 +3283,7 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 	rcu_read_lock();
 	vpd = rcu_dereference(sdkp->device->vpd_pgb1);
 
-	if (!vpd || vpd->len < 8) {
+	if (!vpd || vpd->len <= 8) {
 		rcu_read_unlock();
 	        return;
 	}
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 24c7cb285dca..c1524fb334eb 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2354,14 +2354,6 @@ static inline void pqi_mask_device(u8 *scsi3addr)
 	scsi3addr[3] |= 0xc0;
 }
 
-static inline bool pqi_is_multipath_device(struct pqi_scsi_dev *device)
-{
-	if (pqi_is_logical_device(device))
-		return false;
-
-	return (device->path_map & (device->path_map - 1)) != 0;
-}
-
 static inline bool pqi_expose_device(struct pqi_scsi_dev *device)
 {
 	return !device->is_physical_device || !pqi_skip_device(device->scsi3addr);
@@ -3258,14 +3250,12 @@ static void pqi_process_aio_io_error(struct pqi_io_request *io_request)
 	int residual_count;
 	int xfer_count;
 	bool device_offline;
-	struct pqi_scsi_dev *device;
 
 	scmd = io_request->scmd;
 	error_info = io_request->error_info;
 	host_byte = DID_OK;
 	sense_data_length = 0;
 	device_offline = false;
-	device = scmd->device->hostdata;
 
 	switch (error_info->service_response) {
 	case PQI_AIO_SERV_RESPONSE_COMPLETE:
@@ -3290,14 +3280,8 @@ static void pqi_process_aio_io_error(struct pqi_io_request *io_request)
 			break;
 		case PQI_AIO_STATUS_AIO_PATH_DISABLED:
 			pqi_aio_path_disabled(io_request);
-			if (pqi_is_multipath_device(device)) {
-				pqi_device_remove_start(device);
-				host_byte = DID_NO_CONNECT;
-				scsi_status = SAM_STAT_CHECK_CONDITION;
-			} else {
-				scsi_status = SAM_STAT_GOOD;
-				io_request->status = -EAGAIN;
-			}
+			scsi_status = SAM_STAT_GOOD;
+			io_request->status = -EAGAIN;
 			break;
 		case PQI_AIO_STATUS_NO_PATH_TO_DEVICE:
 		case PQI_AIO_STATUS_INVALID_DEVICE:
diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index f498db9abe35..04035706b96d 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -940,11 +940,13 @@ static int qmc_chan_start_rx(struct qmc_chan *chan)
 		goto end;
 	}
 
-	ret = qmc_setup_chan_trnsync(chan->qmc, chan);
-	if (ret) {
-		dev_err(chan->qmc->dev, "chan %u: setup TRNSYNC failed (%d)\n",
-			chan->id, ret);
-		goto end;
+	if (chan->mode == QMC_TRANSPARENT) {
+		ret = qmc_setup_chan_trnsync(chan->qmc, chan);
+		if (ret) {
+			dev_err(chan->qmc->dev, "chan %u: setup TRNSYNC failed (%d)\n",
+				chan->id, ret);
+			goto end;
+		}
 	}
 
 	/* Restart the receiver */
@@ -982,11 +984,13 @@ static int qmc_chan_start_tx(struct qmc_chan *chan)
 		goto end;
 	}
 
-	ret = qmc_setup_chan_trnsync(chan->qmc, chan);
-	if (ret) {
-		dev_err(chan->qmc->dev, "chan %u: setup TRNSYNC failed (%d)\n",
-			chan->id, ret);
-		goto end;
+	if (chan->mode == QMC_TRANSPARENT) {
+		ret = qmc_setup_chan_trnsync(chan->qmc, chan);
+		if (ret) {
+			dev_err(chan->qmc->dev, "chan %u: setup TRNSYNC failed (%d)\n",
+				chan->id, ret);
+			goto end;
+		}
 	}
 
 	/*
diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index 6c5741cf5e9d..53968ea84c88 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -140,7 +140,7 @@ static inline void tsa_write32(void __iomem *addr, u32 val)
 	iowrite32be(val, addr);
 }
 
-static inline void tsa_write8(void __iomem *addr, u32 val)
+static inline void tsa_write8(void __iomem *addr, u8 val)
 {
 	iowrite8(val, addr);
 }
diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index b7056aed4c7d..9d64283d2125 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -196,9 +196,6 @@ static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
 {
 	struct qcom_smd_rpm *rpm;
 
-	if (!rpdev->dev.of_node)
-		return -EINVAL;
-
 	rpm = devm_kzalloc(&rpdev->dev, sizeof(*rpm), GFP_KERNEL);
 	if (!rpm)
 		return -ENOMEM;
@@ -218,18 +215,38 @@ static void qcom_smd_rpm_remove(struct rpmsg_device *rpdev)
 	of_platform_depopulate(&rpdev->dev);
 }
 
-static const struct rpmsg_device_id qcom_smd_rpm_id_table[] = {
-	{ .name = "rpm_requests", },
-	{ /* sentinel */ }
+static const struct of_device_id qcom_smd_rpm_of_match[] = {
+	{ .compatible = "qcom,rpm-apq8084" },
+	{ .compatible = "qcom,rpm-ipq6018" },
+	{ .compatible = "qcom,rpm-ipq9574" },
+	{ .compatible = "qcom,rpm-msm8226" },
+	{ .compatible = "qcom,rpm-msm8909" },
+	{ .compatible = "qcom,rpm-msm8916" },
+	{ .compatible = "qcom,rpm-msm8936" },
+	{ .compatible = "qcom,rpm-msm8953" },
+	{ .compatible = "qcom,rpm-msm8974" },
+	{ .compatible = "qcom,rpm-msm8976" },
+	{ .compatible = "qcom,rpm-msm8994" },
+	{ .compatible = "qcom,rpm-msm8996" },
+	{ .compatible = "qcom,rpm-msm8998" },
+	{ .compatible = "qcom,rpm-sdm660" },
+	{ .compatible = "qcom,rpm-sm6115" },
+	{ .compatible = "qcom,rpm-sm6125" },
+	{ .compatible = "qcom,rpm-sm6375" },
+	{ .compatible = "qcom,rpm-qcm2290" },
+	{ .compatible = "qcom,rpm-qcs404" },
+	{}
 };
-MODULE_DEVICE_TABLE(rpmsg, qcom_smd_rpm_id_table);
+MODULE_DEVICE_TABLE(of, qcom_smd_rpm_of_match);
 
 static struct rpmsg_driver qcom_smd_rpm_driver = {
 	.probe = qcom_smd_rpm_probe,
 	.remove = qcom_smd_rpm_remove,
 	.callback = qcom_smd_rpm_callback,
-	.id_table = qcom_smd_rpm_id_table,
-	.drv.name = "qcom_smd_rpm",
+	.drv  = {
+		.name  = "qcom_smd_rpm",
+		.of_match_table = qcom_smd_rpm_of_match,
+	},
 };
 
 static int __init qcom_smd_rpm_init(void)
diff --git a/drivers/soc/versatile/soc-integrator.c b/drivers/soc/versatile/soc-integrator.c
index bab4ad87aa75..d5099a3386b4 100644
--- a/drivers/soc/versatile/soc-integrator.c
+++ b/drivers/soc/versatile/soc-integrator.c
@@ -113,6 +113,7 @@ static int __init integrator_soc_init(void)
 		return -ENODEV;
 
 	syscon_regmap = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (IS_ERR(syscon_regmap))
 		return PTR_ERR(syscon_regmap);
 
diff --git a/drivers/soc/versatile/soc-realview.c b/drivers/soc/versatile/soc-realview.c
index c6876d232d8f..cf91abe07d38 100644
--- a/drivers/soc/versatile/soc-realview.c
+++ b/drivers/soc/versatile/soc-realview.c
@@ -4,6 +4,7 @@
  *
  * Author: Linus Walleij <linus.walleij@linaro.org>
  */
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -81,6 +82,13 @@ static struct attribute *realview_attrs[] = {
 
 ATTRIBUTE_GROUPS(realview);
 
+static void realview_soc_socdev_release(void *data)
+{
+	struct soc_device *soc_dev = data;
+
+	soc_device_unregister(soc_dev);
+}
+
 static int realview_soc_probe(struct platform_device *pdev)
 {
 	struct regmap *syscon_regmap;
@@ -93,7 +101,7 @@ static int realview_soc_probe(struct platform_device *pdev)
 	if (IS_ERR(syscon_regmap))
 		return PTR_ERR(syscon_regmap);
 
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
@@ -106,10 +114,14 @@ static int realview_soc_probe(struct platform_device *pdev)
 	soc_dev_attr->family = "Versatile";
 	soc_dev_attr->custom_attr_group = realview_groups[0];
 	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-		kfree(soc_dev_attr);
+	if (IS_ERR(soc_dev))
 		return -ENODEV;
-	}
+
+	ret = devm_add_action_or_reset(&pdev->dev, realview_soc_socdev_release,
+				       soc_dev);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(syscon_regmap, REALVIEW_SYS_ID_OFFSET,
 			  &realview_coreid);
 	if (ret)
diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 5aaff3bee1b7..9ea91432c11d 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -375,9 +375,9 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 	 * If the QSPI controller is set in regular SPI mode, set it in
 	 * Serial Memory Mode (SMM).
 	 */
-	if (aq->mr != QSPI_MR_SMM) {
-		atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
-		aq->mr = QSPI_MR_SMM;
+	if (!(aq->mr & QSPI_MR_SMM)) {
+		aq->mr |= QSPI_MR_SMM;
+		atmel_qspi_write(aq->mr, aq, QSPI_MR);
 	}
 
 	/* Clear pending interrupts */
@@ -501,7 +501,8 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	aq->scr = QSPI_SCR_SCBR(scbr);
+	aq->scr &= ~QSPI_SCR_SCBR_MASK;
+	aq->scr |= QSPI_SCR_SCBR(scbr);
 	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
 
 	pm_runtime_mark_last_busy(ctrl->dev.parent);
@@ -534,6 +535,7 @@ static int atmel_qspi_set_cs_timing(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
+	aq->scr &= ~QSPI_SCR_DLYBS_MASK;
 	aq->scr |= QSPI_SCR_DLYBS(cs_setup);
 	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
 
@@ -549,8 +551,8 @@ static void atmel_qspi_init(struct atmel_qspi *aq)
 	atmel_qspi_write(QSPI_CR_SWRST, aq, QSPI_CR);
 
 	/* Set the QSPI controller by default in Serial Memory Mode */
-	atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
-	aq->mr = QSPI_MR_SMM;
+	aq->mr |= QSPI_MR_SMM;
+	atmel_qspi_write(aq->mr, aq, QSPI_MR);
 
 	/* Enable the QSPI controller */
 	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
@@ -726,6 +728,7 @@ static void atmel_qspi_remove(struct platform_device *pdev)
 	clk_unprepare(aq->pclk);
 
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 }
 
diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 9d97ec98881c..94458df53eae 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -211,9 +211,6 @@ struct airoha_snand_dev {
 
 	u8 *txrx_buf;
 	dma_addr_t dma_addr;
-
-	u64 cur_page_num;
-	bool data_need_update;
 };
 
 struct airoha_snand_ctrl {
@@ -405,7 +402,7 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
-		data_len = min(len, SPI_MAX_TRANSFER_SIZE);
+		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
 		err = airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
 		if (err)
 			return err;
@@ -427,7 +424,7 @@ static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 *data,
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
-		data_len = min(len, SPI_MAX_TRANSFER_SIZE);
+		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
 		err = airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
 		if (err)
 			return err;
@@ -644,11 +641,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u32 val, rd_mode;
 	int err;
 
-	if (!as_dev->data_need_update)
-		return len;
-
-	as_dev->data_need_update = false;
-
 	switch (op->cmd.opcode) {
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
 		rd_mode = 1;
@@ -739,8 +731,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		return err;
 
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
-			      SPI_NFI_READ_FROM_CACHE_DONE);
+	/*
+	 * SPI_NFI_READ_FROM_CACHE_DONE bit must be written at the end
+	 * of dirmap_read operation even if it is already set.
+	 */
+	err = regmap_write_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
+				SPI_NFI_READ_FROM_CACHE_DONE,
+				SPI_NFI_READ_FROM_CACHE_DONE);
 	if (err)
 		return err;
 
@@ -870,8 +867,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		return err;
 
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
-			      SPI_NFI_LOAD_TO_CACHE_DONE);
+	/*
+	 * SPI_NFI_LOAD_TO_CACHE_DONE bit must be written at the end
+	 * of dirmap_write operation even if it is already set.
+	 */
+	err = regmap_write_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
+				SPI_NFI_LOAD_TO_CACHE_DONE,
+				SPI_NFI_LOAD_TO_CACHE_DONE);
 	if (err)
 		return err;
 
@@ -885,23 +887,11 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 static int airoha_snand_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	struct airoha_snand_dev *as_dev = spi_get_ctldata(mem->spi);
 	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct airoha_snand_ctrl *as_ctrl;
 	int i, err;
 
 	as_ctrl = spi_controller_get_devdata(mem->spi->controller);
-	if (opcode == SPI_NAND_OP_PROGRAM_EXECUTE &&
-	    op->addr.val == as_dev->cur_page_num) {
-		as_dev->data_need_update = true;
-	} else if (opcode == SPI_NAND_OP_PAGE_READ) {
-		if (!as_dev->data_need_update &&
-		    op->addr.val == as_dev->cur_page_num)
-			return 0;
-
-		as_dev->data_need_update = true;
-		as_dev->cur_page_num = op->addr.val;
-	}
 
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
@@ -986,7 +976,6 @@ static int airoha_snand_setup(struct spi_device *spi)
 	if (dma_mapping_error(as_ctrl->dev, as_dev->dma_addr))
 		return -ENOMEM;
 
-	as_dev->data_need_update = true;
 	spi_set_ctldata(spi, as_dev);
 
 	return 0;
diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index 9f64afd8164e..4965bc86d7f5 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -546,12 +546,14 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 			goto out_put_host;
 	}
 
-	pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		goto out_put_host;
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
 	if (ret) {
 		dev_err(&pdev->dev, "couldn't register sysfs group\n");
-		goto out_pm_disable;
+		goto out_put_host;
 	}
 
 	/* register and we are done */
@@ -565,8 +567,6 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 
 out_sysgroup_disable:
 	sysfs_remove_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
-out_pm_disable:
-	pm_runtime_disable(&pdev->dev);
 out_put_host:
 	spi_controller_put(host);
 out_disable_pll_clk:
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index d2f603e1014c..e235df4177f9 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -986,6 +986,7 @@ static void fsl_lpspi_remove(struct platform_device *pdev)
 
 	fsl_lpspi_dma_exit(controller);
 
+	pm_runtime_dont_use_autosuspend(fsl_lpspi->dev);
 	pm_runtime_disable(fsl_lpspi->dev);
 }
 
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 6585b19a4866..a961785724cd 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -57,13 +57,6 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
-/*
- * The driver only uses one single LUT entry, that is updated on
- * each call of exec_op(). Index 0 is preset at boot with a basic
- * read operation, so let's use the last entry (31).
- */
-#define	SEQID_LUT			31
-
 /* Registers used by the driver */
 #define FSPI_MCR0			0x00
 #define FSPI_MCR0_AHB_TIMEOUT(x)	((x) << 24)
@@ -263,9 +256,6 @@
 #define FSPI_TFDR			0x180
 
 #define FSPI_LUT_BASE			0x200
-#define FSPI_LUT_OFFSET			(SEQID_LUT * 4 * 4)
-#define FSPI_LUT_REG(idx) \
-	(FSPI_LUT_BASE + FSPI_LUT_OFFSET + (idx) * 4)
 
 /* register map end */
 
@@ -341,6 +331,7 @@ struct nxp_fspi_devtype_data {
 	unsigned int txfifo;
 	unsigned int ahb_buf_size;
 	unsigned int quirks;
+	unsigned int lut_num;
 	bool little_endian;
 };
 
@@ -349,6 +340,7 @@ static struct nxp_fspi_devtype_data lx2160a_data = {
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
 	.quirks = 0,
+	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
 };
 
@@ -357,6 +349,7 @@ static struct nxp_fspi_devtype_data imx8mm_data = {
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
 	.quirks = 0,
+	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
 };
 
@@ -365,6 +358,7 @@ static struct nxp_fspi_devtype_data imx8qxp_data = {
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
 	.quirks = 0,
+	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
 };
 
@@ -373,6 +367,16 @@ static struct nxp_fspi_devtype_data imx8dxl_data = {
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
 	.quirks = FSPI_QUIRK_USE_IP_ONLY,
+	.lut_num = 32,
+	.little_endian = true,  /* little-endian    */
+};
+
+static struct nxp_fspi_devtype_data imx8ulp_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.lut_num = 16,
 	.little_endian = true,  /* little-endian    */
 };
 
@@ -544,6 +548,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	void __iomem *base = f->iobase;
 	u32 lutval[4] = {};
 	int lutidx = 1, i;
+	u32 lut_offset = (f->devtype_data->lut_num - 1) * 4 * 4;
+	u32 target_lut_reg;
 
 	/* cmd */
 	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
@@ -588,8 +594,10 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	fspi_writel(f, FSPI_LCKER_UNLOCK, f->iobase + FSPI_LCKCR);
 
 	/* fill LUT */
-	for (i = 0; i < ARRAY_SIZE(lutval); i++)
-		fspi_writel(f, lutval[i], base + FSPI_LUT_REG(i));
+	for (i = 0; i < ARRAY_SIZE(lutval); i++) {
+		target_lut_reg = FSPI_LUT_BASE + lut_offset + i * 4;
+		fspi_writel(f, lutval[i], base + target_lut_reg);
+	}
 
 	dev_dbg(f->dev, "CMD[%02x] lutval[0:%08x 1:%08x 2:%08x 3:%08x], size: 0x%08x\n",
 		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3], op->data.nbytes);
@@ -876,7 +884,7 @@ static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
 	void __iomem *base = f->iobase;
 	int seqnum = 0;
 	int err = 0;
-	u32 reg;
+	u32 reg, seqid_lut;
 
 	reg = fspi_readl(f, base + FSPI_IPRXFCR);
 	/* invalid RXFIFO first */
@@ -892,8 +900,9 @@ static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
 	 * the LUT at each exec_op() call. And also specify the DATA
 	 * length, since it's has not been specified in the LUT.
 	 */
+	seqid_lut = f->devtype_data->lut_num - 1;
 	fspi_writel(f, op->data.nbytes |
-		 (SEQID_LUT << FSPI_IPCR1_SEQID_SHIFT) |
+		 (seqid_lut << FSPI_IPCR1_SEQID_SHIFT) |
 		 (seqnum << FSPI_IPCR1_SEQNUM_SHIFT),
 		 base + FSPI_IPCR1);
 
@@ -1017,7 +1026,7 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 {
 	void __iomem *base = f->iobase;
 	int ret, i;
-	u32 reg;
+	u32 reg, seqid_lut;
 
 	/* disable and unprepare clock to avoid glitch pass to controller */
 	nxp_fspi_clk_disable_unprep(f);
@@ -1092,11 +1101,17 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	fspi_writel(f, reg, base + FSPI_FLSHB1CR1);
 	fspi_writel(f, reg, base + FSPI_FLSHB2CR1);
 
+	/*
+	 * The driver only uses one single LUT entry, that is updated on
+	 * each call of exec_op(). Index 0 is preset at boot with a basic
+	 * read operation, so let's use the last entry.
+	 */
+	seqid_lut = f->devtype_data->lut_num - 1;
 	/* AHB Read - Set lut sequence ID for all CS. */
-	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA1CR2);
-	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA2CR2);
-	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHB1CR2);
-	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHB2CR2);
+	fspi_writel(f, seqid_lut, base + FSPI_FLSHA1CR2);
+	fspi_writel(f, seqid_lut, base + FSPI_FLSHA2CR2);
+	fspi_writel(f, seqid_lut, base + FSPI_FLSHB1CR2);
+	fspi_writel(f, seqid_lut, base + FSPI_FLSHB2CR2);
 
 	f->selected = -1;
 
@@ -1291,6 +1306,7 @@ static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,imx8mp-fspi", .data = (void *)&imx8mm_data, },
 	{ .compatible = "nxp,imx8qxp-fspi", .data = (void *)&imx8qxp_data, },
 	{ .compatible = "nxp,imx8dxl-fspi", .data = (void *)&imx8dxl_data, },
+	{ .compatible = "nxp,imx8ulp-fspi", .data = (void *)&imx8ulp_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 942c3117ab3a..8f6309f32de0 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -27,7 +27,6 @@
 #include <linux/wait.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -412,7 +411,11 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	}
 
 	/* Request IRQ */
-	hw->irqnum = irq_of_parse_and_map(np, 0);
+	ret = platform_get_irq(op, 0);
+	if (ret < 0)
+		goto free_host;
+	hw->irqnum = ret;
+
 	ret = request_irq(hw->irqnum, spi_ppc4xx_int,
 			  0, "spi_ppc4xx_of", (void *)hw);
 	if (ret) {
diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
index fecd3e67c7a1..b6d34145bc19 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.c
+++ b/drivers/staging/media/starfive/camss/stf-camss.c
@@ -358,8 +358,6 @@ static int stfcamss_probe(struct platform_device *pdev)
 /*
  * stfcamss_remove - Remove STFCAMSS platform device
  * @pdev: Pointer to STFCAMSS platform device
- *
- * Always returns 0.
  */
 static void stfcamss_remove(struct platform_device *pdev)
 {
diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index daed67d19efb..863e7a4272e6 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -92,23 +92,21 @@ static void bang_bang_manage(struct thermal_zone_device *tz)
 
 	for_each_trip_desc(tz, td) {
 		const struct thermal_trip *trip = &td->trip;
+		bool turn_on;
 
-		if (tz->temperature >= td->threshold ||
-		    trip->temperature == THERMAL_TEMP_INVALID ||
+		if (trip->temperature == THERMAL_TEMP_INVALID ||
 		    trip->type == THERMAL_TRIP_CRITICAL ||
 		    trip->type == THERMAL_TRIP_HOT)
 			continue;
 
 		/*
-		 * If the initial cooling device state is "on", but the zone
-		 * temperature is not above the trip point, the core will not
-		 * call bang_bang_control() until the zone temperature reaches
-		 * the trip point temperature which may be never.  In those
-		 * cases, set the initial state of the cooling device to 0.
+		 * Adjust the target states for uninitialized thermal instances
+		 * to the thermal zone temperature and the trip point threshold.
 		 */
+		turn_on = tz->temperature >= td->threshold;
 		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 			if (!instance->initialized && instance->trip == trip)
-				bang_bang_set_instance_target(instance, 0);
+				bang_bang_set_instance_target(instance, turn_on);
 		}
 	}
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b8d889ef4fa5..d0e71698b356 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -323,11 +323,15 @@ static void thermal_zone_broken_disable(struct thermal_zone_device *tz)
 static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 					    unsigned long delay)
 {
-	if (delay)
-		mod_delayed_work(system_freezable_power_efficient_wq,
-				 &tz->poll_queue, delay);
-	else
+	if (!delay) {
 		cancel_delayed_work(&tz->poll_queue);
+		return;
+	}
+
+	if (delay > HZ)
+		delay = round_jiffies_relative(delay);
+
+	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, delay);
 }
 
 static void thermal_zone_recheck(struct thermal_zone_device *tz, int error)
@@ -988,20 +992,6 @@ void print_bind_err_msg(struct thermal_zone_device *tz,
 		tz->type, cdev->type, ret);
 }
 
-static void bind_cdev(struct thermal_cooling_device *cdev)
-{
-	int ret;
-	struct thermal_zone_device *pos = NULL;
-
-	list_for_each_entry(pos, &thermal_tz_list, node) {
-		if (pos->ops.bind) {
-			ret = pos->ops.bind(pos, cdev);
-			if (ret)
-				print_bind_err_msg(pos, cdev, ret);
-		}
-	}
-}
-
 /**
  * __thermal_cooling_device_register() - register a new thermal cooling device
  * @np:		a pointer to a device tree node.
@@ -1097,7 +1087,13 @@ __thermal_cooling_device_register(struct device_node *np,
 	list_add(&cdev->node, &thermal_cdev_list);
 
 	/* Update binding information for 'this' new cdev */
-	bind_cdev(cdev);
+	list_for_each_entry(pos, &thermal_tz_list, node) {
+		if (pos->ops.bind) {
+			ret = pos->ops.bind(pos, cdev);
+			if (ret)
+				print_bind_err_msg(pos, cdev, ret);
+		}
+	}
 
 	list_for_each_entry(pos, &thermal_tz_list, node)
 		if (atomic_cmpxchg(&pos->need_update, 1, 0))
@@ -1335,32 +1331,6 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
-static void bind_tz(struct thermal_zone_device *tz)
-{
-	int ret;
-	struct thermal_cooling_device *pos = NULL;
-
-	if (!tz->ops.bind)
-		return;
-
-	mutex_lock(&thermal_list_lock);
-
-	list_for_each_entry(pos, &thermal_cdev_list, node) {
-		ret = tz->ops.bind(tz, pos);
-		if (ret)
-			print_bind_err_msg(tz, pos, ret);
-	}
-
-	mutex_unlock(&thermal_list_lock);
-}
-
-static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
-{
-	*delay_jiffies = msecs_to_jiffies(delay_ms);
-	if (delay_ms > 1000)
-		*delay_jiffies = round_jiffies(*delay_jiffies);
-}
-
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 {
 	const struct thermal_trip_desc *td;
@@ -1497,8 +1467,8 @@ thermal_zone_device_register_with_trips(const char *type,
 		td->threshold = INT_MAX;
 	}
 
-	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
-	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
+	tz->polling_delay_jiffies = msecs_to_jiffies(polling_delay);
+	tz->passive_delay_jiffies = msecs_to_jiffies(passive_delay);
 	tz->recheck_delay_jiffies = THERMAL_RECHECK_DELAY;
 
 	/* sys I/F */
@@ -1542,13 +1512,23 @@ thermal_zone_device_register_with_trips(const char *type,
 	}
 
 	mutex_lock(&thermal_list_lock);
+
 	mutex_lock(&tz->lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
 	mutex_unlock(&tz->lock);
-	mutex_unlock(&thermal_list_lock);
 
 	/* Bind cooling devices for this zone */
-	bind_tz(tz);
+	if (tz->ops.bind) {
+		struct thermal_cooling_device *cdev;
+
+		list_for_each_entry(cdev, &thermal_cdev_list, node) {
+			result = tz->ops.bind(tz, cdev);
+			if (result)
+				print_bind_err_msg(tz, cdev, result);
+		}
+	}
+
+	mutex_unlock(&thermal_list_lock);
 
 	thermal_zone_device_init(tz);
 	/* Update the new thermal zone and mark it as already updated. */
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index afef1dd4ddf4..fca5f25d693a 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1581,7 +1581,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, up.port.irq, omap8250_irq, 0,
 			       dev_name(&pdev->dev), priv);
 	if (ret < 0)
-		return ret;
+		goto err;
 
 	priv->wakeirq = irq_of_parse_and_map(np, 1);
 
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 69a632fefc41..f8f6e9466b40 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -124,13 +124,14 @@ struct qcom_geni_serial_port {
 	dma_addr_t tx_dma_addr;
 	dma_addr_t rx_dma_addr;
 	bool setup;
-	unsigned int baud;
+	unsigned long poll_timeout_us;
 	unsigned long clk_rate;
 	void *rx_buf;
 	u32 loopback;
 	bool brk;
 
 	unsigned int tx_remaining;
+	unsigned int tx_queued;
 	int wakeup_irq;
 	bool rx_tx_swap;
 	bool cts_rts_swap;
@@ -144,6 +145,8 @@ static const struct uart_ops qcom_geni_uart_pops;
 static struct uart_driver qcom_geni_console_driver;
 static struct uart_driver qcom_geni_uart_driver;
 
+static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
+
 static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
 {
 	return container_of(uport, struct qcom_geni_serial_port, uport);
@@ -265,27 +268,18 @@ static bool qcom_geni_serial_secondary_active(struct uart_port *uport)
 	return readl(uport->membase + SE_GENI_STATUS) & S_GENI_CMD_ACTIVE;
 }
 
-static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
-				int offset, int field, bool set)
+static bool qcom_geni_serial_poll_bitfield(struct uart_port *uport,
+					   unsigned int offset, u32 field, u32 val)
 {
 	u32 reg;
 	struct qcom_geni_serial_port *port;
-	unsigned int baud;
-	unsigned int fifo_bits;
 	unsigned long timeout_us = 20000;
 	struct qcom_geni_private_data *private_data = uport->private_data;
 
 	if (private_data->drv) {
 		port = to_dev_port(uport);
-		baud = port->baud;
-		if (!baud)
-			baud = 115200;
-		fifo_bits = port->tx_fifo_depth * port->tx_fifo_width;
-		/*
-		 * Total polling iterations based on FIFO worth of bytes to be
-		 * sent at current baud. Add a little fluff to the wait.
-		 */
-		timeout_us = ((fifo_bits * USEC_PER_SEC) / baud) + 500;
+		if (port->poll_timeout_us)
+			timeout_us = port->poll_timeout_us;
 	}
 
 	/*
@@ -295,7 +289,7 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	timeout_us = DIV_ROUND_UP(timeout_us, 10) * 10;
 	while (timeout_us) {
 		reg = readl(uport->membase + offset);
-		if ((bool)(reg & field) == set)
+		if ((reg & field) == val)
 			return true;
 		udelay(10);
 		timeout_us -= 10;
@@ -303,6 +297,12 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	return false;
 }
 
+static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
+				      unsigned int offset, u32 field, bool set)
+{
+	return qcom_geni_serial_poll_bitfield(uport, offset, field, set ? field : 0);
+}
+
 static void qcom_geni_serial_setup_tx(struct uart_port *uport, u32 xmit_size)
 {
 	u32 m_cmd;
@@ -315,18 +315,16 @@ static void qcom_geni_serial_setup_tx(struct uart_port *uport, u32 xmit_size)
 static void qcom_geni_serial_poll_tx_done(struct uart_port *uport)
 {
 	int done;
-	u32 irq_clear = M_CMD_DONE_EN;
 
 	done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_CMD_DONE_EN, true);
 	if (!done) {
 		writel(M_GENI_CMD_ABORT, uport->membase +
 						SE_GENI_M_CMD_CTRL_REG);
-		irq_clear |= M_CMD_ABORT_EN;
 		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 							M_CMD_ABORT_EN, true);
+		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	}
-	writel(irq_clear, uport->membase + SE_GENI_M_IRQ_CLEAR);
 }
 
 static void qcom_geni_serial_abort_rx(struct uart_port *uport)
@@ -387,6 +385,7 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
 							unsigned char c)
 {
 	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
+	writel(M_CMD_DONE_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	qcom_geni_serial_setup_tx(uport, 1);
 	WARN_ON(!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_TX_FIFO_WATERMARK_EN, true));
@@ -397,6 +396,14 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
 #endif
 
 #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
+static void qcom_geni_serial_drain_fifo(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+
+	qcom_geni_serial_poll_bitfield(uport, SE_GENI_M_GP_LENGTH, GP_LENGTH,
+			port->tx_queued);
+}
+
 static void qcom_geni_serial_wr_char(struct uart_port *uport, unsigned char ch)
 {
 	struct qcom_geni_private_data *private_data = uport->private_data;
@@ -431,6 +438,7 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
 	}
 
 	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
+	writel(M_CMD_DONE_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	qcom_geni_serial_setup_tx(uport, bytes_to_send);
 	for (i = 0; i < count; ) {
 		size_t chars_to_write = 0;
@@ -471,8 +479,6 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 	struct qcom_geni_serial_port *port;
 	bool locked = true;
 	unsigned long flags;
-	u32 geni_status;
-	u32 irq_en;
 
 	WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);
 
@@ -486,40 +492,20 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 	else
 		uart_port_lock_irqsave(uport, &flags);
 
-	geni_status = readl(uport->membase + SE_GENI_STATUS);
+	if (qcom_geni_serial_main_active(uport)) {
+		/* Wait for completion or drain FIFO */
+		if (!locked || port->tx_remaining == 0)
+			qcom_geni_serial_poll_tx_done(uport);
+		else
+			qcom_geni_serial_drain_fifo(uport);
 
-	if (!locked) {
-		/*
-		 * We can only get here if an oops is in progress then we were
-		 * unable to get the lock. This means we can't safely access
-		 * our state variables like tx_remaining. About the best we
-		 * can do is wait for the FIFO to be empty before we start our
-		 * transfer, so we'll do that.
-		 */
-		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
-					  M_TX_FIFO_NOT_EMPTY_EN, false);
-	} else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->tx_remaining) {
-		/*
-		 * It seems we can't interrupt existing transfers if all data
-		 * has been sent, in which case we need to look for done first.
-		 */
-		qcom_geni_serial_poll_tx_done(uport);
-
-		if (!kfifo_is_empty(&uport->state->port.xmit_fifo)) {
-			irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
-			writel(irq_en | M_TX_FIFO_WATERMARK_EN,
-					uport->membase + SE_GENI_M_IRQ_EN);
-		}
+		qcom_geni_serial_cancel_tx_cmd(uport);
 	}
 
 	__qcom_geni_serial_console_write(uport, s, count);
 
-
-	if (locked) {
-		if (port->tx_remaining)
-			qcom_geni_serial_setup_tx(uport, port->tx_remaining);
+	if (locked)
 		uart_port_unlock_irqrestore(uport, flags);
-	}
 }
 
 static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
@@ -700,6 +686,7 @@ static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport)
 	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 
 	port->tx_remaining = 0;
+	port->tx_queued = 0;
 }
 
 static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, bool drop)
@@ -926,6 +913,7 @@ static void qcom_geni_serial_handle_tx_fifo(struct uart_port *uport,
 	if (!port->tx_remaining) {
 		qcom_geni_serial_setup_tx(uport, pending);
 		port->tx_remaining = pending;
+		port->tx_queued = 0;
 
 		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 		if (!(irq_en & M_TX_FIFO_WATERMARK_EN))
@@ -934,6 +922,7 @@ static void qcom_geni_serial_handle_tx_fifo(struct uart_port *uport,
 	}
 
 	qcom_geni_serial_send_chunk_fifo(uport, chunk);
+	port->tx_queued += chunk;
 
 	/*
 	 * The tx fifo watermark is level triggered and latched. Though we had
@@ -1244,11 +1233,11 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	unsigned long clk_rate;
 	u32 ver, sampling_rate;
 	unsigned int avg_bw_core;
+	unsigned long timeout;
 
 	qcom_geni_serial_stop_rx(uport);
 	/* baud rate */
 	baud = uart_get_baud_rate(uport, termios, old, 300, 4000000);
-	port->baud = baud;
 
 	sampling_rate = UART_OVERSAMPLING;
 	/* Sampling rate is halved for IP versions >= 2.5 */
@@ -1326,9 +1315,21 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	else
 		tx_trans_cfg |= UART_CTS_MASK;
 
-	if (baud)
+	if (baud) {
 		uart_update_timeout(uport, termios->c_cflag, baud);
 
+		/*
+		 * Make sure that qcom_geni_serial_poll_bitfield() waits for
+		 * the FIFO, two-word intermediate transfer register and shift
+		 * register to clear.
+		 *
+		 * Note that uart_fifo_timeout() also adds a 20 ms margin.
+		 */
+		timeout = jiffies_to_usecs(uart_fifo_timeout(uport));
+		timeout += 3 * timeout / port->tx_fifo_depth;
+		WRITE_ONCE(port->poll_timeout_us, timeout);
+	}
+
 	if (!uart_console(uport))
 		writel(port->loopback,
 				uport->membase + SE_UART_LOOPBACK_CFG);
diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 4132fcff7d4e..8bab2aedc499 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -577,8 +577,8 @@ static void rp2_reset_asic(struct rp2_card *card, unsigned int asic_id)
 	u32 clk_cfg;
 
 	writew(1, base + RP2_GLOBAL_CMD);
-	readw(base + RP2_GLOBAL_CMD);
 	msleep(100);
+	readw(base + RP2_GLOBAL_CMD);
 	writel(0, base + RP2_CLK_PRESCALER);
 
 	/* TDM clock configuration */
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9967444eae10..1d0e7b8514cc 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2696,14 +2696,13 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 	int ret = 0;
 
 	tport = &state->port;
-	mutex_lock(&tport->mutex);
+
+	guard(mutex)(&tport->mutex);
 
 	port = uart_port_check(state);
 	if (!port || port->type == PORT_UNKNOWN ||
-	    !(port->ops->poll_get_char && port->ops->poll_put_char)) {
-		ret = -1;
-		goto out;
-	}
+	    !(port->ops->poll_get_char && port->ops->poll_put_char))
+		return -1;
 
 	pm_state = state->pm_state;
 	uart_change_pm(state, UART_PM_STATE_ON);
@@ -2723,10 +2722,10 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 		ret = uart_set_options(port, NULL, baud, parity, bits, flow);
 		console_list_unlock();
 	}
-out:
+
 	if (ret)
 		uart_change_pm(state, pm_state);
-	mutex_unlock(&tport->mutex);
+
 	return ret;
 }
 
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index cca190d1c577..92ff9706860c 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -93,7 +93,7 @@ static const struct __ufs_qcom_bw_table {
 	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
 	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
 	[MODE_HS_RB][UFS_HS_G5][UFS_LANE_2] = { 5836800,	819200 },
-	[MODE_MAX][0][0]		    = { 7643136,	307200 },
+	[MODE_MAX][0][0]		    = { 7643136,	819200 },
 };
 
 static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index dbd83d321bca..46852529499d 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -718,7 +718,8 @@ int cdnsp_remove_request(struct cdnsp_device *pdev,
 	seg = cdnsp_trb_in_td(pdev, cur_td->start_seg, cur_td->first_trb,
 			      cur_td->last_trb, hw_deq);
 
-	if (seg && (pep->ep_state & EP_ENABLED))
+	if (seg && (pep->ep_state & EP_ENABLED) &&
+	    !(pep->ep_state & EP_DIS_IN_RROGRESS))
 		cdnsp_find_new_dequeue_state(pdev, pep, preq->request.stream_id,
 					     cur_td, &deq_state);
 	else
@@ -736,7 +737,8 @@ int cdnsp_remove_request(struct cdnsp_device *pdev,
 	 * During disconnecting all endpoint will be disabled so we don't
 	 * have to worry about updating dequeue pointer.
 	 */
-	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING) {
+	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING ||
+	    pep->ep_state & EP_DIS_IN_RROGRESS) {
 		status = -ESHUTDOWN;
 		ret = cdnsp_cmd_set_deq(pdev, pep, &deq_state);
 	}
diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index ceca4d839dfd..7ba760ee62e3 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -62,7 +62,9 @@ static const struct xhci_plat_priv xhci_plat_cdns3_xhci = {
 	.resume_quirk = xhci_cdns3_resume_quirk,
 };
 
-static const struct xhci_plat_priv xhci_plat_cdnsp_xhci;
+static const struct xhci_plat_priv xhci_plat_cdnsp_xhci = {
+	.quirks = XHCI_CDNS_SCTX_QUIRK,
+};
 
 static int __cdns_host_init(struct cdns *cdns)
 {
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 0c1b69d944ca..605fea461102 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -962,10 +962,12 @@ static int get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 	struct acm *acm = tty->driver_data;
 
 	ss->line = acm->minor;
+	mutex_lock(&acm->port.mutex);
 	ss->close_delay	= jiffies_to_msecs(acm->port.close_delay) / 10;
 	ss->closing_wait = acm->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
 				ASYNC_CLOSING_WAIT_NONE :
 				jiffies_to_msecs(acm->port.closing_wait) / 10;
+	mutex_unlock(&acm->port.mutex);
 	return 0;
 }
 
diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
index a8605b02115b..1ad8fa3f862a 100644
--- a/drivers/usb/dwc2/drd.c
+++ b/drivers/usb/dwc2/drd.c
@@ -127,6 +127,15 @@ static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
 			role = USB_ROLE_DEVICE;
 	}
 
+	if ((IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) ||
+	     IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)) &&
+	     dwc2_is_device_mode(hsotg) &&
+	     hsotg->lx_state == DWC2_L2 &&
+	     hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_NONE &&
+	     hsotg->bus_suspended &&
+	     !hsotg->params.no_clock_gating)
+		dwc2_gadget_exit_clock_gating(hsotg, 0);
+
 	if (role == USB_ROLE_HOST) {
 		already = dwc2_ovr_avalid(hsotg, true);
 	} else if (role == USB_ROLE_DEVICE) {
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index f37b0d8386c1..ff7bee78bcc4 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1304,7 +1304,8 @@ static int dummy_urb_enqueue(
 
 	/* kick the scheduler, it'll do the rest */
 	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+				HRTIMER_MODE_REL_SOFT);
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1325,7 +1326,7 @@ static int dummy_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
 			!list_empty(&dum_hcd->urbp_list))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
 
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
@@ -1995,7 +1996,8 @@ static enum hrtimer_restart dummy_timer(struct hrtimer *t)
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
 		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+				HRTIMER_MODE_REL_SOFT);
 	}
 
 	spin_unlock_irqrestore(&dum->lock, flags);
@@ -2389,7 +2391,7 @@ static int dummy_bus_resume(struct usb_hcd *hcd)
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
 		if (!list_empty(&dum_hcd->urbp_list))
-			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
+			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2467,7 +2469,7 @@ static DEVICE_ATTR_RO(urbs);
 
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
@@ -2497,7 +2499,7 @@ static int dummy_start(struct usb_hcd *hcd)
 		return dummy_start_ss(dum_hcd);
 
 	spin_lock_init(&dum_hcd->dum->lock);
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index f591ddd08662..fa3ee53df0ec 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2325,7 +2325,10 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
 	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
 	erst_base &= ERST_BASE_RSVDP;
 	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
-	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
+	if (xhci->quirks & XHCI_WRITE_64_HI_LO)
+		hi_lo_writeq(erst_base, &ir->ir_set->erst_base);
+	else
+		xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
 
 	/* Set the event ring dequeue address of this interrupter */
 	xhci_set_hc_event_deq(xhci, ir);
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dc1e345ab67e..994fd8b38bd0 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -55,6 +55,9 @@
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI		0x51ed
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
 
+#define PCI_VENDOR_ID_PHYTIUM		0x1db7
+#define PCI_DEVICE_ID_PHYTIUM_XHCI			0xdc27
+
 /* Thunderbolt */
 #define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI	0x15b5
@@ -78,6 +81,9 @@
 #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
 #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
 
+#define PCI_DEVICE_ID_CADENCE				0x17CD
+#define PCI_DEVICE_ID_CADENCE_SSP			0x0200
+
 static const char hcd_name[] = "xhci_hcd";
 
 static struct hc_driver __read_mostly xhci_pci_hc_driver;
@@ -416,6 +422,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_VIA)
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 
+	if (pdev->vendor == PCI_VENDOR_ID_PHYTIUM &&
+	    pdev->device == PCI_DEVICE_ID_PHYTIUM_XHCI)
+		xhci->quirks |= XHCI_RESET_ON_RESUME;
+
 	/* See https://bugzilla.kernel.org/show_bug.cgi?id=79511 */
 	if (pdev->vendor == PCI_VENDOR_ID_VIA &&
 			pdev->device == 0x3432)
@@ -473,6 +483,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
 	}
 
+	if (pdev->vendor == PCI_DEVICE_ID_CADENCE &&
+	    pdev->device == PCI_DEVICE_ID_CADENCE_SSP)
+		xhci->quirks |= XHCI_CDNS_SCTX_QUIRK;
+
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
@@ -655,8 +669,10 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 static void xhci_pci_remove(struct pci_dev *dev)
 {
 	struct xhci_hcd *xhci;
+	bool set_power_d3;
 
 	xhci = hcd_to_xhci(pci_get_drvdata(dev));
+	set_power_d3 = xhci->quirks & XHCI_SPURIOUS_WAKEUP;
 
 	xhci->xhc_state |= XHCI_STATE_REMOVING;
 
@@ -669,11 +685,11 @@ static void xhci_pci_remove(struct pci_dev *dev)
 		xhci->shared_hcd = NULL;
 	}
 
+	usb_hcd_pci_remove(dev);
+
 	/* Workaround for spurious wakeups at shutdown with HSW */
-	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
+	if (set_power_d3)
 		pci_set_power_state(dev, PCI_D3hot);
-
-	usb_hcd_pci_remove(dev);
 }
 
 /*
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index fd0cde3d1569..0fe6bef6c398 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1426,6 +1426,20 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 			struct xhci_stream_ctx *ctx =
 				&ep->stream_info->stream_ctx_array[stream_id];
 			deq = le64_to_cpu(ctx->stream_ring) & SCTX_DEQ_MASK;
+
+			/*
+			 * Cadence xHCI controllers store some endpoint state
+			 * information within Rsvd0 fields of Stream Endpoint
+			 * context. This field is not cleared during Set TR
+			 * Dequeue Pointer command which causes XDMA to skip
+			 * over transfer ring and leads to data loss on stream
+			 * pipe.
+			 * To fix this issue driver must clear Rsvd0 field.
+			 */
+			if (xhci->quirks & XHCI_CDNS_SCTX_QUIRK) {
+				ctx->reserved[0] = 0;
+				ctx->reserved[1] = 0;
+			}
 		} else {
 			deq = le64_to_cpu(ep_ctx->deq) & ~EP_CTX_CYCLE_MASK;
 		}
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 78d014c4d884..ac8da8a7df86 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/usb/hcd.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 
 /* Code sharing between pci-quirks and xhci hcd */
 #include	"xhci-ext-caps.h"
@@ -1628,6 +1629,8 @@ struct xhci_hcd {
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
 #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
+#define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
+#define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledisplay.c
index c8098e9b432e..62b5a30edc42 100644
--- a/drivers/usb/misc/appledisplay.c
+++ b/drivers/usb/misc/appledisplay.c
@@ -107,7 +107,12 @@ static void appledisplay_complete(struct urb *urb)
 	case ACD_BTN_BRIGHT_UP:
 	case ACD_BTN_BRIGHT_DOWN:
 		pdata->button_pressed = 1;
-		schedule_delayed_work(&pdata->work, 0);
+		/*
+		 * there is a window during which no device
+		 * is registered
+		 */
+		if (pdata->bd )
+			schedule_delayed_work(&pdata->work, 0);
 		break;
 	case ACD_BTN_NONE:
 	default:
@@ -202,6 +207,7 @@ static int appledisplay_probe(struct usb_interface *iface,
 	const struct usb_device_id *id)
 {
 	struct backlight_properties props;
+	struct backlight_device *backlight;
 	struct appledisplay *pdata;
 	struct usb_device *udev = interface_to_usbdev(iface);
 	struct usb_endpoint_descriptor *endpoint;
@@ -272,13 +278,14 @@ static int appledisplay_probe(struct usb_interface *iface,
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = 0xff;
-	pdata->bd = backlight_device_register(bl_name, NULL, pdata,
+	backlight = backlight_device_register(bl_name, NULL, pdata,
 					      &appledisplay_bl_data, &props);
-	if (IS_ERR(pdata->bd)) {
+	if (IS_ERR(backlight)) {
 		dev_err(&iface->dev, "Backlight registration failed\n");
-		retval = PTR_ERR(pdata->bd);
+		retval = PTR_ERR(backlight);
 		goto error;
 	}
+	pdata->bd = backlight;
 
 	/* Try to get brightness */
 	brightness = appledisplay_bl_get_brightness(pdata->bd);
diff --git a/drivers/usb/misc/cypress_cy7c63.c b/drivers/usb/misc/cypress_cy7c63.c
index cecd7693b741..75f5a740cba3 100644
--- a/drivers/usb/misc/cypress_cy7c63.c
+++ b/drivers/usb/misc/cypress_cy7c63.c
@@ -88,6 +88,9 @@ static int vendor_command(struct cypress *dev, unsigned char request,
 				 USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 				 address, data, iobuf, CYPRESS_MAX_REQSIZE,
 				 USB_CTRL_GET_TIMEOUT);
+	/* we must not process garbage */
+	if (retval < 2)
+		goto err_buf;
 
 	/* store returned data (more READs to be added) */
 	switch (request) {
@@ -107,6 +110,7 @@ static int vendor_command(struct cypress *dev, unsigned char request,
 			break;
 	}
 
+err_buf:
 	kfree(iobuf);
 error:
 	return retval;
diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index 9a0649d23693..6adaaf66c14d 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -404,7 +404,6 @@ static ssize_t yurex_read(struct file *file, char __user *buffer, size_t count,
 	struct usb_yurex *dev;
 	int len = 0;
 	char in_buffer[MAX_S64_STRLEN];
-	unsigned long flags;
 
 	dev = file->private_data;
 
@@ -419,9 +418,9 @@ static ssize_t yurex_read(struct file *file, char __user *buffer, size_t count,
 		return -EIO;
 	}
 
-	spin_lock_irqsave(&dev->lock, flags);
+	spin_lock_irq(&dev->lock);
 	scnprintf(in_buffer, MAX_S64_STRLEN, "%lld\n", dev->bbu);
-	spin_unlock_irqrestore(&dev->lock, flags);
+	spin_unlock_irq(&dev->lock);
 	mutex_unlock(&dev->io_mutex);
 
 	return simple_read_from_buffer(buffer, count, ppos, in_buffer, len);
@@ -511,8 +510,11 @@ static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
 			__func__, retval);
 		goto error;
 	}
-	if (set && timeout)
+	if (set && timeout) {
+		spin_lock_irq(&dev->lock);
 		dev->bbu = c2;
+		spin_unlock_irq(&dev->lock);
+	}
 	return timeout ? count : -EIO;
 
 error:
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 4758914ccf86..bf56f3d69625 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -581,6 +581,9 @@ static void mlx5_vdpa_show_mr_leaks(struct mlx5_vdpa_dev *mvdev)
 
 void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
 {
+	if (!mvdev->res.valid)
+		return;
+
 	for (int i = 0; i < MLX5_VDPA_NUM_AS; i++)
 		mlx5_vdpa_update_mr(mvdev, NULL, i);
 
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 6b9c12acf438..b3d2a53f9bb7 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -209,11 +209,9 @@ static void vhost_vdpa_setup_vq_irq(struct vhost_vdpa *v, u16 qid)
 	if (irq < 0)
 		return;
 
-	irq_bypass_unregister_producer(&vq->call_ctx.producer);
 	if (!vq->call_ctx.ctx)
 		return;
 
-	vq->call_ctx.producer.token = vq->call_ctx.ctx;
 	vq->call_ctx.producer.irq = irq;
 	ret = irq_bypass_register_producer(&vq->call_ctx.producer);
 	if (unlikely(ret))
@@ -709,6 +707,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 			vq->last_avail_idx = vq_state.split.avail_index;
 		}
 		break;
+	case VHOST_SET_VRING_CALL:
+		if (vq->call_ctx.ctx) {
+			if (ops->get_status(vdpa) &
+			    VIRTIO_CONFIG_S_DRIVER_OK)
+				vhost_vdpa_unsetup_vq_irq(v, idx);
+			vq->call_ctx.producer.token = NULL;
+		}
+		break;
 	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
@@ -747,13 +753,16 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 			cb.callback = vhost_vdpa_virtqueue_cb;
 			cb.private = vq;
 			cb.trigger = vq->call_ctx.ctx;
+			vq->call_ctx.producer.token = vq->call_ctx.ctx;
+			if (ops->get_status(vdpa) &
+			    VIRTIO_CONFIG_S_DRIVER_OK)
+				vhost_vdpa_setup_vq_irq(v, idx);
 		} else {
 			cb.callback = NULL;
 			cb.private = NULL;
 			cb.trigger = NULL;
 		}
 		ops->set_vq_cb(vdpa, idx, &cb);
-		vhost_vdpa_setup_vq_irq(v, idx);
 		break;
 
 	case VHOST_SET_VRING_NUM:
@@ -1421,6 +1430,7 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 	for (i = 0; i < nvqs; i++) {
 		vqs[i] = &v->vqs[i];
 		vqs[i]->handle_kick = handle_vq_kick;
+		vqs[i]->call_ctx.ctx = NULL;
 	}
 	vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
 		       vhost_vdpa_process_iotlb_msg);
diff --git a/drivers/video/fbdev/hpfb.c b/drivers/video/fbdev/hpfb.c
index 66fac8e5393e..a1144b150982 100644
--- a/drivers/video/fbdev/hpfb.c
+++ b/drivers/video/fbdev/hpfb.c
@@ -345,6 +345,7 @@ static int hpfb_dio_probe(struct dio_dev *d, const struct dio_device_id *ent)
 	if (hpfb_init_one(paddr, vaddr)) {
 		if (d->scode >= DIOII_SCBASE)
 			iounmap((void *)vaddr);
+		release_mem_region(d->resource.start, resource_size(&d->resource));
 		return -ENOMEM;
 	}
 	return 0;
diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index 66d4628a96ae..c90f48ebb15e 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -407,6 +407,7 @@ static int xenfb_probe(struct xenbus_device *dev,
 	/* complete the abuse: */
 	fb_info->pseudo_palette = fb_info->par;
 	fb_info->par = info;
+	fb_info->device = &dev->dev;
 
 	fb_info->screen_buffer = info->fb;
 
diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
index e51fe1b78518..d73076b686d8 100644
--- a/drivers/watchdog/imx_sc_wdt.c
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -216,29 +216,6 @@ static int imx_sc_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, wdog);
 }
 
-static int __maybe_unused imx_sc_wdt_suspend(struct device *dev)
-{
-	struct imx_sc_wdt_device *imx_sc_wdd = dev_get_drvdata(dev);
-
-	if (watchdog_active(&imx_sc_wdd->wdd))
-		imx_sc_wdt_stop(&imx_sc_wdd->wdd);
-
-	return 0;
-}
-
-static int __maybe_unused imx_sc_wdt_resume(struct device *dev)
-{
-	struct imx_sc_wdt_device *imx_sc_wdd = dev_get_drvdata(dev);
-
-	if (watchdog_active(&imx_sc_wdd->wdd))
-		imx_sc_wdt_start(&imx_sc_wdd->wdd);
-
-	return 0;
-}
-
-static SIMPLE_DEV_PM_OPS(imx_sc_wdt_pm_ops,
-			 imx_sc_wdt_suspend, imx_sc_wdt_resume);
-
 static const struct of_device_id imx_sc_wdt_dt_ids[] = {
 	{ .compatible = "fsl,imx-sc-wdt", },
 	{ /* sentinel */ }
@@ -250,7 +227,6 @@ static struct platform_driver imx_sc_wdt_driver = {
 	.driver		= {
 		.name	= "imx-sc-wdt",
 		.of_match_table = imx_sc_wdt_dt_ids,
-		.pm	= &imx_sc_wdt_pm_ops,
 	},
 };
 module_platform_driver(imx_sc_wdt_driver);
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 6579ae3f6dac..5e83d1e0bd18 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -78,9 +78,15 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 {
 	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
 	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
+	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
 
 	next_bfn = pfn_to_bfn(xen_pfn);
 
+	/* If buffer is physically aligned, ensure DMA alignment. */
+	if (IS_ALIGNED(p, algn) &&
+	    !IS_ALIGNED((phys_addr_t)next_bfn << XEN_PAGE_SHIFT, algn))
+		return 1;
+
 	for (i = 1; i < nr_pages; i++)
 		if (pfn_to_bfn(++xen_pfn) != ++next_bfn)
 			return 1;
@@ -140,7 +146,7 @@ xen_swiotlb_alloc_coherent(struct device *dev, size_t size,
 	void *ret;
 
 	/* Align the allocation to the Xen page size */
-	size = 1UL << (order + XEN_PAGE_SHIFT);
+	size = ALIGN(size, XEN_PAGE_SIZE);
 
 	ret = (void *)__get_free_pages(flags, get_order(size));
 	if (!ret)
@@ -172,7 +178,7 @@ xen_swiotlb_free_coherent(struct device *dev, size_t size, void *vaddr,
 	int order = get_order(size);
 
 	/* Convert the size to actually allocated. */
-	size = 1UL << (order + XEN_PAGE_SHIFT);
+	size = ALIGN(size, XEN_PAGE_SIZE);
 
 	if (WARN_ON_ONCE(dma_handle + size - 1 > dev->coherent_dma_mask) ||
 	    WARN_ON_ONCE(range_straddles_page_boundary(phys, size)))
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 1f5db6863663..bb404bfce036 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -172,8 +172,7 @@ static int autofs_parse_fd(struct fs_context *fc, struct autofs_sb_info *sbi,
 	ret = autofs_check_pipe(pipe);
 	if (ret < 0) {
 		errorf(fc, "Invalid/unusable pipe");
-		if (param->type != fs_value_is_file)
-			fput(pipe);
+		fput(pipe);
 		return -EBADF;
 	}
 
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 6ed495ca7a31..bc69bf0dbe93 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -126,6 +126,7 @@ struct btrfs_inode {
 	 * logged_trans), to access/update delalloc_bytes, new_delalloc_bytes,
 	 * defrag_bytes, disk_i_size, outstanding_extents, csum_bytes and to
 	 * update the VFS' inode number of bytes used.
+	 * Also protects setting struct file::private_data.
 	 */
 	spinlock_t lock;
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b2e4b30b8fae..a4296ce1de71 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -457,6 +457,8 @@ struct btrfs_file_private {
 	void *filldir_buf;
 	u64 last_index;
 	struct extent_state *llseek_cached_state;
+	/* Task that allocated this structure. */
+	struct task_struct *owner_task;
 };
 
 static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 55be8a7f0bb1..79dd2d9a62d9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6426,13 +6426,13 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 			continue;
 
 		ret = btrfs_trim_free_extents(device, &group_trimmed);
+
+		trimmed += group_trimmed;
 		if (ret) {
 			dev_failed++;
 			dev_ret = ret;
 			break;
 		}
-
-		trimmed += group_trimmed;
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 66dfee873906..0a14379a2d51 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3689,7 +3689,7 @@ static bool find_desired_extent_in_hole(struct btrfs_inode *inode, int whence,
 static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 {
 	struct btrfs_inode *inode = BTRFS_I(file->f_mapping->host);
-	struct btrfs_file_private *private = file->private_data;
+	struct btrfs_file_private *private;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_state *cached_state = NULL;
 	struct extent_state **delalloc_cached_state;
@@ -3717,7 +3717,19 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 	    inode_get_bytes(&inode->vfs_inode) == i_size)
 		return i_size;
 
-	if (!private) {
+	spin_lock(&inode->lock);
+	private = file->private_data;
+	spin_unlock(&inode->lock);
+
+	if (private && private->owner_task != current) {
+		/*
+		 * Not allocated by us, don't use it as its cached state is used
+		 * by the task that allocated it and we don't want neither to
+		 * mess with it nor get incorrect results because it reflects an
+		 * invalid state for the current task.
+		 */
+		private = NULL;
+	} else if (!private) {
 		private = kzalloc(sizeof(*private), GFP_KERNEL);
 		/*
 		 * No worries if memory allocation failed.
@@ -3725,7 +3737,23 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 		 * lseek SEEK_HOLE/DATA calls to a file when there's delalloc,
 		 * so everything will still be correct.
 		 */
-		file->private_data = private;
+		if (private) {
+			bool free = false;
+
+			private->owner_task = current;
+
+			spin_lock(&inode->lock);
+			if (file->private_data)
+				free = true;
+			else
+				file->private_data = private;
+			spin_unlock(&inode->lock);
+
+			if (free) {
+				kfree(private);
+				private = NULL;
+			}
+		}
 	}
 
 	if (private)
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c1b0556e4036..4a30f34bc830 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -543,13 +543,11 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 
 	range.minlen = max(range.minlen, minlen);
 	ret = btrfs_trim_fs(fs_info, &range);
-	if (ret < 0)
-		return ret;
 
 	if (copy_to_user(arg, &range, sizeof(range)))
 		return -EFAULT;
 
-	return 0;
+	return ret;
 }
 
 int __pure btrfs_is_empty_uuid(u8 *uuid)
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 54736f6238e6..831e96b607f5 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -766,8 +766,14 @@ void btrfs_folio_unlock_writer(struct btrfs_fs_info *fs_info,
 }
 
 #define GET_SUBPAGE_BITMAP(subpage, subpage_info, name, dst)		\
-	bitmap_cut(dst, subpage->bitmaps, 0,				\
-		   subpage_info->name##_offset, subpage_info->bitmap_nr_bits)
+{									\
+	const int bitmap_nr_bits = subpage_info->bitmap_nr_bits;	\
+									\
+	ASSERT(bitmap_nr_bits < BITS_PER_LONG);				\
+	*dst = bitmap_read(subpage->bitmaps,				\
+			   subpage_info->name##_offset,			\
+			   bitmap_nr_bits);				\
+}
 
 void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 				      struct folio *folio, u64 start, u32 len)
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index de1c063bc39d..42e2ec3cd1c1 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1499,7 +1499,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 				     dref_objectid > BTRFS_LAST_FREE_OBJECTID)) {
 				extent_err(leaf, slot,
 					   "invalid data ref objectid value %llu",
-					   dref_root);
+					   dref_objectid);
 				return -EUCLEAN;
 			}
 			if (unlikely(!IS_ALIGNED(dref_offset,
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 4dd8a993c60a..7c6f260a3be5 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -64,9 +64,15 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 		memcpy(buf->data, fscache_get_aux(object->cookie), len);
 
 	ret = cachefiles_inject_write_error();
-	if (ret == 0)
-		ret = vfs_setxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache,
-				   buf, sizeof(struct cachefiles_xattr) + len, 0);
+	if (ret == 0) {
+		ret = mnt_want_write_file(file);
+		if (ret == 0) {
+			ret = vfs_setxattr(&nop_mnt_idmap, dentry,
+					   cachefiles_xattr_cache, buf,
+					   sizeof(struct cachefiles_xattr) + len, 0);
+			mnt_drop_write_file(file);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, file_inode(file), ret,
 					   cachefiles_trace_setxattr_error);
@@ -151,8 +157,14 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 	int ret;
 
 	ret = cachefiles_inject_remove_error();
-	if (ret == 0)
-		ret = vfs_removexattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache);
+	if (ret == 0) {
+		ret = mnt_want_write(cache->mnt);
+		if (ret == 0) {
+			ret = vfs_removexattr(&nop_mnt_idmap, dentry,
+					      cachefiles_xattr_cache);
+			mnt_drop_write(cache->mnt);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, d_inode(dentry), ret,
 					   cachefiles_trace_remxattr_error);
@@ -208,9 +220,15 @@ bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume)
 	memcpy(buf->data, p, volume->vcookie->coherency_len);
 
 	ret = cachefiles_inject_write_error();
-	if (ret == 0)
-		ret = vfs_setxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache,
-				   buf, len, 0);
+	if (ret == 0) {
+		ret = mnt_want_write(volume->cache->mnt);
+		if (ret == 0) {
+			ret = vfs_setxattr(&nop_mnt_idmap, dentry,
+					   cachefiles_xattr_cache,
+					   buf, len, 0);
+			mnt_drop_write(volume->cache->mnt);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(NULL, d_inode(dentry), ret,
 					   cachefiles_trace_setxattr_error);
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 8fd928899a59..66d9b3b4c588 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -89,12 +89,14 @@ enum {
 	Opt_uid,
 	Opt_gid,
 	Opt_mode,
+	Opt_source,
 };
 
 static const struct fs_parameter_spec debugfs_param_specs[] = {
-	fsparam_u32	("gid",		Opt_gid),
+	fsparam_gid	("gid",		Opt_gid),
 	fsparam_u32oct	("mode",	Opt_mode),
-	fsparam_u32	("uid",		Opt_uid),
+	fsparam_uid	("uid",		Opt_uid),
+	fsparam_string	("source",	Opt_source),
 	{}
 };
 
@@ -102,8 +104,6 @@ static int debugfs_parse_param(struct fs_context *fc, struct fs_parameter *param
 {
 	struct debugfs_fs_info *opts = fc->s_fs_info;
 	struct fs_parse_result result;
-	kuid_t uid;
-	kgid_t gid;
 	int opt;
 
 	opt = fs_parse(fc, debugfs_param_specs, param, &result);
@@ -120,20 +120,20 @@ static int debugfs_parse_param(struct fs_context *fc, struct fs_parameter *param
 
 	switch (opt) {
 	case Opt_uid:
-		uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(uid))
-			return invalf(fc, "Unknown uid");
-		opts->uid = uid;
+		opts->uid = result.uid;
 		break;
 	case Opt_gid:
-		gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(gid))
-			return invalf(fc, "Unknown gid");
-		opts->gid = gid;
+		opts->gid = result.gid;
 		break;
 	case Opt_mode:
 		opts->mode = result.uint_32 & S_IALLUGO;
 		break;
+	case Opt_source:
+		if (fc->source)
+			return invalfc(fc, "Multiple sources specified");
+		fc->source = param->string;
+		param->string = NULL;
+		break;
 	/*
 	 * We might like to report bad mount options here;
 	 * but traditionally debugfs has ignored all mount options
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5f6439a63af7..f2cab9e4f3bc 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -178,12 +178,14 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 			      unsigned int m_pofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
-	unsigned int bsz = i_blocksize(inode);
+	loff_t off;
 	char *lnk;
 
-	/* if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= bsz || inode->i_size < 0) {
+	m_pofs += vi->xattr_isize;
+	/* check if it cannot be handled with fast symlink scheme */
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size < 0 ||
+	    check_add_overflow(m_pofs, inode->i_size, &off) ||
+	    off > i_blocksize(inode)) {
 		inode->i_op = &erofs_symlink_iops;
 		return 0;
 	}
@@ -192,16 +194,6 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 	if (!lnk)
 		return -ENOMEM;
 
-	m_pofs += vi->xattr_isize;
-	/* inline symlink data shouldn't cross block boundary */
-	if (m_pofs + inode->i_size > bsz) {
-		kfree(lnk);
-		erofs_err(inode->i_sb,
-			  "inline data cross block boundary @ nid %llu",
-			  vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
 	memcpy(lnk, kaddr + m_pofs, inode->i_size);
 	lnk[inode->i_size] = '\0';
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d6fe002a4a71..2535479fb82d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -19,10 +19,7 @@
 typedef void *z_erofs_next_pcluster_t;
 
 struct z_erofs_bvec {
-	union {
-		struct page *page;
-		struct folio *folio;
-	};
+	struct page *page;
 	int offset;
 	unsigned int end;
 };
@@ -617,32 +614,31 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 }
 
-/* called by erofs_shrinker to get rid of all cached compressed bvecs */
+/* (erofs_shrinker) disconnect cached encoded data with pclusters */
 int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
 					struct erofs_workgroup *grp)
 {
 	struct z_erofs_pcluster *const pcl =
 		container_of(grp, struct z_erofs_pcluster, obj);
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
+	struct folio *folio;
 	int i;
 
 	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
-	/* There is no actice user since the pcluster is now freezed */
+	/* Each cached folio contains one page unless bs > ps is supported */
 	for (i = 0; i < pclusterpages; ++i) {
-		struct folio *folio = pcl->compressed_bvecs[i].folio;
+		if (pcl->compressed_bvecs[i].page) {
+			folio = page_folio(pcl->compressed_bvecs[i].page);
+			/* Avoid reclaiming or migrating this folio */
+			if (!folio_trylock(folio))
+				return -EBUSY;
 
-		if (!folio)
-			continue;
-
-		/* Avoid reclaiming or migrating this folio */
-		if (!folio_trylock(folio))
-			return -EBUSY;
-
-		if (!erofs_folio_is_managed(sbi, folio))
-			continue;
-		pcl->compressed_bvecs[i].folio = NULL;
-		folio_detach_private(folio);
-		folio_unlock(folio);
+			if (!erofs_folio_is_managed(sbi, folio))
+				continue;
+			pcl->compressed_bvecs[i].page = NULL;
+			folio_detach_private(folio);
+			folio_unlock(folio);
+		}
 	}
 	return 0;
 }
@@ -650,9 +646,9 @@ int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
 static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 {
 	struct z_erofs_pcluster *pcl = folio_get_private(folio);
-	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
+	struct z_erofs_bvec *bvec = pcl->compressed_bvecs;
+	struct z_erofs_bvec *end = bvec + z_erofs_pclusterpages(pcl);
 	bool ret;
-	int i;
 
 	if (!folio_test_private(folio))
 		return true;
@@ -661,9 +657,9 @@ static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 	spin_lock(&pcl->obj.lockref.lock);
 	if (pcl->obj.lockref.count <= 0) {
 		DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
-		for (i = 0; i < pclusterpages; ++i) {
-			if (pcl->compressed_bvecs[i].folio == folio) {
-				pcl->compressed_bvecs[i].folio = NULL;
+		for (; bvec < end; ++bvec) {
+			if (bvec->page && page_folio(bvec->page) == folio) {
+				bvec->page = NULL;
 				folio_detach_private(folio);
 				ret = true;
 				break;
@@ -1066,7 +1062,7 @@ static bool z_erofs_is_sync_decompress(struct erofs_sb_info *sbi,
 
 static bool z_erofs_page_is_invalidated(struct page *page)
 {
-	return !page->mapping && !z_erofs_is_shortlived_page(page);
+	return !page_folio(page)->mapping && !z_erofs_is_shortlived_page(page);
 }
 
 struct z_erofs_decompress_backend {
@@ -1419,6 +1415,7 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	bool tocache = false;
 	struct z_erofs_bvec zbv;
 	struct address_space *mapping;
+	struct folio *folio;
 	struct page *page;
 	int bs = i_blocksize(f->inode);
 
@@ -1429,23 +1426,24 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	spin_lock(&pcl->obj.lockref.lock);
 	zbv = pcl->compressed_bvecs[nr];
 	spin_unlock(&pcl->obj.lockref.lock);
-	if (!zbv.folio)
+	if (!zbv.page)
 		goto out_allocfolio;
 
-	bvec->bv_page = &zbv.folio->page;
+	bvec->bv_page = zbv.page;
 	DBG_BUGON(z_erofs_is_shortlived_page(bvec->bv_page));
+
+	folio = page_folio(zbv.page);
 	/*
 	 * Handle preallocated cached folios.  We tried to allocate such folios
 	 * without triggering direct reclaim.  If allocation failed, inplace
 	 * file-backed folios will be used instead.
 	 */
-	if (zbv.folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
-		zbv.folio->private = 0;
+	if (folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
 		tocache = true;
 		goto out_tocache;
 	}
 
-	mapping = READ_ONCE(zbv.folio->mapping);
+	mapping = READ_ONCE(folio->mapping);
 	/*
 	 * File-backed folios for inplace I/Os are all locked steady,
 	 * therefore it is impossible for `mapping` to be NULL.
@@ -1457,56 +1455,58 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 		return;
 	}
 
-	folio_lock(zbv.folio);
-	if (zbv.folio->mapping == mc) {
+	folio_lock(folio);
+	if (likely(folio->mapping == mc)) {
 		/*
 		 * The cached folio is still in managed cache but without
 		 * a valid `->private` pcluster hint.  Let's reconnect them.
 		 */
-		if (!folio_test_private(zbv.folio)) {
-			folio_attach_private(zbv.folio, pcl);
+		if (!folio_test_private(folio)) {
+			folio_attach_private(folio, pcl);
 			/* compressed_bvecs[] already takes a ref before */
-			folio_put(zbv.folio);
+			folio_put(folio);
 		}
-
-		/* no need to submit if it is already up-to-date */
-		if (folio_test_uptodate(zbv.folio)) {
-			folio_unlock(zbv.folio);
-			bvec->bv_page = NULL;
+		if (likely(folio->private == pcl))  {
+			/* don't submit cache I/Os again if already uptodate */
+			if (folio_test_uptodate(folio)) {
+				folio_unlock(folio);
+				bvec->bv_page = NULL;
+			}
+			return;
 		}
-		return;
+		/*
+		 * Already linked with another pcluster, which only appears in
+		 * crafted images by fuzzers for now.  But handle this anyway.
+		 */
+		tocache = false;	/* use temporary short-lived pages */
+	} else {
+		DBG_BUGON(1); /* referenced managed folios can't be truncated */
+		tocache = true;
 	}
-
-	/*
-	 * It has been truncated, so it's unsafe to reuse this one. Let's
-	 * allocate a new page for compressed data.
-	 */
-	DBG_BUGON(zbv.folio->mapping);
-	tocache = true;
-	folio_unlock(zbv.folio);
-	folio_put(zbv.folio);
+	folio_unlock(folio);
+	folio_put(folio);
 out_allocfolio:
 	page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
 	spin_lock(&pcl->obj.lockref.lock);
-	if (pcl->compressed_bvecs[nr].folio) {
+	if (unlikely(pcl->compressed_bvecs[nr].page != zbv.page)) {
 		erofs_pagepool_add(&f->pagepool, page);
 		spin_unlock(&pcl->obj.lockref.lock);
 		cond_resched();
 		goto repeat;
 	}
-	pcl->compressed_bvecs[nr].folio = zbv.folio = page_folio(page);
+	bvec->bv_page = pcl->compressed_bvecs[nr].page = page;
+	folio = page_folio(page);
 	spin_unlock(&pcl->obj.lockref.lock);
-	bvec->bv_page = page;
 out_tocache:
 	if (!tocache || bs != PAGE_SIZE ||
-	    filemap_add_folio(mc, zbv.folio, pcl->obj.index + nr, gfp)) {
+	    filemap_add_folio(mc, folio, pcl->obj.index + nr, gfp)) {
 		/* turn into a temporary shortlived folio (1 ref) */
-		zbv.folio->private = (void *)Z_EROFS_SHORTLIVED_PAGE;
+		folio->private = (void *)Z_EROFS_SHORTLIVED_PAGE;
 		return;
 	}
-	folio_attach_private(zbv.folio, pcl);
+	folio_attach_private(folio, pcl);
 	/* drop a refcount added by allocpage (then 2 refs in total here) */
-	folio_put(zbv.folio);
+	folio_put(folio);
 }
 
 static struct z_erofs_decompressqueue *jobqueue_init(struct super_block *sb,
@@ -1638,13 +1638,10 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		cur = mdev.m_pa;
 		end = cur + pcl->pclustersize;
 		do {
-			z_erofs_fill_bio_vec(&bvec, f, pcl, i++, mc);
-			if (!bvec.bv_page)
-				continue;
-
+			bvec.bv_page = NULL;
 			if (bio && (cur != last_pa ||
 				    bio->bi_bdev != mdev.m_bdev)) {
-io_retry:
+drain_io:
 				if (!erofs_is_fscache_mode(sb))
 					submit_bio(bio);
 				else
@@ -1657,6 +1654,15 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				bio = NULL;
 			}
 
+			if (!bvec.bv_page) {
+				z_erofs_fill_bio_vec(&bvec, f, pcl, i++, mc);
+				if (!bvec.bv_page)
+					continue;
+				if (cur + bvec.bv_len > end)
+					bvec.bv_len = end - cur;
+				DBG_BUGON(bvec.bv_len < sb->s_blocksize);
+			}
+
 			if (unlikely(PageWorkingset(bvec.bv_page)) &&
 			    !memstall) {
 				psi_memstall_enter(&pflags);
@@ -1676,13 +1682,9 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				++nr_bios;
 			}
 
-			if (cur + bvec.bv_len > end)
-				bvec.bv_len = end - cur;
-			DBG_BUGON(bvec.bv_len < sb->s_blocksize);
 			if (!bio_add_page(bio, bvec.bv_page, bvec.bv_len,
 					  bvec.bv_offset))
-				goto io_retry;
-
+				goto drain_io;
 			last_pa = cur + bvec.bv_len;
 			bypass = false;
 		} while ((cur += bvec.bv_len) < end);
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f53ca4f7fced..6d0e2f547ae7 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -420,7 +420,7 @@ static bool busy_loop_ep_timeout(unsigned long start_time,
 
 static bool ep_busy_loop_on(struct eventpoll *ep)
 {
-	return !!ep->busy_poll_usecs || net_busy_loop_on();
+	return !!READ_ONCE(ep->busy_poll_usecs) || net_busy_loop_on();
 }
 
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index afdf13c34ff5..1ac011088ce7 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -779,8 +779,11 @@ int exfat_create_upcase_table(struct super_block *sb)
 				le32_to_cpu(ep->dentry.upcase.checksum));
 
 			brelse(bh);
-			if (ret && ret != -EIO)
+			if (ret && ret != -EIO) {
+				/* free memory from exfat_load_upcase_table call */
+				exfat_free_upcase_table(sbi);
 				goto load_default;
+			}
 
 			/* load successfully */
 			return ret;
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index e9bbb1da2d0a..5a3b4bc12414 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -514,6 +514,8 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 	if (min_inodes < 1)
 		min_inodes = 1;
 	min_clusters = avefreec - EXT4_CLUSTERS_PER_GROUP(sb)*flex_size / 4;
+	if (min_clusters < 0)
+		min_clusters = 0;
 
 	/*
 	 * Start looking in the flex group where we last allocated an
@@ -755,10 +757,10 @@ int ext4_mark_inode_used(struct super_block *sb, int ino)
 	struct ext4_group_desc *gdp;
 	ext4_group_t group;
 	int bit;
-	int err = -EFSCORRUPTED;
+	int err;
 
 	if (ino < EXT4_FIRST_INO(sb) || ino > max_ino)
-		goto out;
+		return -EFSCORRUPTED;
 
 	group = (ino - 1) / EXT4_INODES_PER_GROUP(sb);
 	bit = (ino - 1) % EXT4_INODES_PER_GROUP(sb);
@@ -860,6 +862,7 @@ int ext4_mark_inode_used(struct super_block *sb, int ino)
 	err = ext4_handle_dirty_metadata(NULL, NULL, group_desc_bh);
 	sync_dirty_buffer(group_desc_bh);
 out:
+	brelse(inode_bitmap_bh);
 	return err;
 }
 
@@ -1053,12 +1056,13 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		brelse(inode_bitmap_bh);
 		inode_bitmap_bh = ext4_read_inode_bitmap(sb, group);
 		/* Skip groups with suspicious inode tables */
-		if (((!(sbi->s_mount_state & EXT4_FC_REPLAY))
-		     && EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) ||
-		    IS_ERR(inode_bitmap_bh)) {
+		if (IS_ERR(inode_bitmap_bh)) {
 			inode_bitmap_bh = NULL;
 			goto next_group;
 		}
+		if (!(sbi->s_mount_state & EXT4_FC_REPLAY) &&
+		    EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
+			goto next_group;
 
 repeat_in_this_group:
 		ret2 = find_inode_bit(sb, group, inode_bitmap_bh, &ino);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index e7a09a99837b..44a5f6df59ec 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1664,24 +1664,36 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 					struct ext4_dir_entry_2 **res_dir,
 					int *has_inline_data)
 {
+	struct ext4_xattr_ibody_find is = {
+		.s = { .not_found = -ENODATA, },
+	};
+	struct ext4_xattr_info i = {
+		.name_index = EXT4_XATTR_INDEX_SYSTEM,
+		.name = EXT4_XATTR_SYSTEM_DATA,
+	};
 	int ret;
-	struct ext4_iloc iloc;
 	void *inline_start;
 	int inline_size;
 
-	if (ext4_get_inode_loc(dir, &iloc))
-		return NULL;
+	ret = ext4_get_inode_loc(dir, &is.iloc);
+	if (ret)
+		return ERR_PTR(ret);
 
 	down_read(&EXT4_I(dir)->xattr_sem);
+
+	ret = ext4_xattr_ibody_find(dir, &i, &is);
+	if (ret)
+		goto out;
+
 	if (!ext4_has_inline_data(dir)) {
 		*has_inline_data = 0;
 		goto out;
 	}
 
-	inline_start = (void *)ext4_raw_inode(&iloc)->i_block +
+	inline_start = (void *)ext4_raw_inode(&is.iloc)->i_block +
 						EXT4_INLINE_DOTDOT_SIZE;
 	inline_size = EXT4_MIN_INLINE_DATA_SIZE - EXT4_INLINE_DOTDOT_SIZE;
-	ret = ext4_search_dir(iloc.bh, inline_start, inline_size,
+	ret = ext4_search_dir(is.iloc.bh, inline_start, inline_size,
 			      dir, fname, 0, res_dir);
 	if (ret == 1)
 		goto out_find;
@@ -1691,20 +1703,23 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 	if (ext4_get_inline_size(dir) == EXT4_MIN_INLINE_DATA_SIZE)
 		goto out;
 
-	inline_start = ext4_get_inline_xattr_pos(dir, &iloc);
+	inline_start = ext4_get_inline_xattr_pos(dir, &is.iloc);
 	inline_size = ext4_get_inline_size(dir) - EXT4_MIN_INLINE_DATA_SIZE;
 
-	ret = ext4_search_dir(iloc.bh, inline_start, inline_size,
+	ret = ext4_search_dir(is.iloc.bh, inline_start, inline_size,
 			      dir, fname, 0, res_dir);
 	if (ret == 1)
 		goto out_find;
 
 out:
-	brelse(iloc.bh);
-	iloc.bh = NULL;
+	brelse(is.iloc.bh);
+	if (ret < 0)
+		is.iloc.bh = ERR_PTR(ret);
+	else
+		is.iloc.bh = NULL;
 out_find:
 	up_read(&EXT4_I(dir)->xattr_sem);
-	return iloc.bh;
+	return is.iloc.bh;
 }
 
 int ext4_delete_inline_entry(handle_t *handle,
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9dda9cd68ab2..dfecd25cee4e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3887,11 +3887,8 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	/*
 	 * Clear the trimmed flag for the group so that the next
 	 * ext4_trim_fs can trim it.
-	 * If the volume is mounted with -o discard, online discard
-	 * is supported and the free blocks will be trimmed online.
 	 */
-	if (!test_opt(sb, DISCARD))
-		EXT4_MB_GRP_CLEAR_TRIMMED(db);
+	EXT4_MB_GRP_CLEAR_TRIMMED(db);
 
 	if (!db->bb_free_root.rb_node) {
 		/* No more items in the per group rb tree
@@ -6515,8 +6512,9 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 					 " group:%u block:%d count:%lu failed"
 					 " with %d", block_group, bit, count,
 					 err);
-		} else
-			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
+		}
+
+		EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
 
 		ext4_lock_group(sb, block_group);
 		mb_free_blocks(inode, &e4b, bit, count_clusters);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c682fb927b64..edc692984404 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5177,6 +5177,18 @@ static int ext4_block_group_meta_init(struct super_block *sb, int silent)
 	return 0;
 }
 
+/*
+ * It's hard to get stripe aligned blocks if stripe is not aligned with
+ * cluster, just disable stripe and alert user to simplify code and avoid
+ * stripe aligned allocation which will rarely succeed.
+ */
+static bool ext4_is_stripe_incompatible(struct super_block *sb, unsigned long stripe)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	return (stripe > 0 && sbi->s_cluster_ratio > 1 &&
+		stripe % sbi->s_cluster_ratio != 0);
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct ext4_super_block *es = NULL;
@@ -5284,13 +5296,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto failed_mount3;
 
 	sbi->s_stripe = ext4_get_stripe_size(sbi);
-	/*
-	 * It's hard to get stripe aligned blocks if stripe is not aligned with
-	 * cluster, just disable stripe and alert user to simpfy code and avoid
-	 * stripe aligned allocation which will rarely successes.
-	 */
-	if (sbi->s_stripe > 0 && sbi->s_cluster_ratio > 1 &&
-	    sbi->s_stripe % sbi->s_cluster_ratio != 0) {
+	if (ext4_is_stripe_incompatible(sb, sbi->s_stripe)) {
 		ext4_msg(sb, KERN_WARNING,
 			 "stripe (%lu) is not aligned with cluster size (%u), "
 			 "stripe is disabled",
@@ -6453,6 +6459,15 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 
 	}
 
+	if ((ctx->spec & EXT4_SPEC_s_stripe) &&
+	    ext4_is_stripe_incompatible(sb, ctx->s_stripe)) {
+		ext4_msg(sb, KERN_WARNING,
+			 "stripe (%lu) is not aligned with cluster size (%u), "
+			 "stripe is disabled",
+			 ctx->s_stripe, sbi->s_cluster_ratio);
+		ctx->s_stripe = 0;
+	}
+
 	/*
 	 * Changing the DIOREAD_NOLOCK or DELALLOC mount options may cause
 	 * two calls to ext4_should_dioread_nolock() to return inconsistent
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 1ef82a546391..b0506745adab 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -945,7 +945,7 @@ static int __f2fs_get_cluster_blocks(struct inode *inode,
 	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
 	int count, i;
 
-	for (i = 1, count = 1; i < cluster_size; i++) {
+	for (i = 0, count = 0; i < cluster_size; i++) {
 		block_t blkaddr = data_blkaddr(dn->inode, dn->node_page,
 							dn->ofs_in_node + i);
 
@@ -956,8 +956,8 @@ static int __f2fs_get_cluster_blocks(struct inode *inode,
 	return count;
 }
 
-static int __f2fs_cluster_blocks(struct inode *inode,
-				unsigned int cluster_idx, bool compr_blks)
+static int __f2fs_cluster_blocks(struct inode *inode, unsigned int cluster_idx,
+				enum cluster_check_type type)
 {
 	struct dnode_of_data dn;
 	unsigned int start_idx = cluster_idx <<
@@ -978,10 +978,12 @@ static int __f2fs_cluster_blocks(struct inode *inode,
 	}
 
 	if (dn.data_blkaddr == COMPRESS_ADDR) {
-		if (compr_blks)
-			ret = __f2fs_get_cluster_blocks(inode, &dn);
-		else
+		if (type == CLUSTER_COMPR_BLKS)
+			ret = 1 + __f2fs_get_cluster_blocks(inode, &dn);
+		else if (type == CLUSTER_IS_COMPR)
 			ret = 1;
+	} else if (type == CLUSTER_RAW_BLKS) {
+		ret = __f2fs_get_cluster_blocks(inode, &dn);
 	}
 fail:
 	f2fs_put_dnode(&dn);
@@ -991,7 +993,16 @@ static int __f2fs_cluster_blocks(struct inode *inode,
 /* return # of compressed blocks in compressed cluster */
 static int f2fs_compressed_blocks(struct compress_ctx *cc)
 {
-	return __f2fs_cluster_blocks(cc->inode, cc->cluster_idx, true);
+	return __f2fs_cluster_blocks(cc->inode, cc->cluster_idx,
+		CLUSTER_COMPR_BLKS);
+}
+
+/* return # of raw blocks in non-compressed cluster */
+static int f2fs_decompressed_blocks(struct inode *inode,
+				unsigned int cluster_idx)
+{
+	return __f2fs_cluster_blocks(inode, cluster_idx,
+		CLUSTER_RAW_BLKS);
 }
 
 /* return whether cluster is compressed one or not */
@@ -999,7 +1010,16 @@ int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
 {
 	return __f2fs_cluster_blocks(inode,
 		index >> F2FS_I(inode)->i_log_cluster_size,
-		false);
+		CLUSTER_IS_COMPR);
+}
+
+/* return whether cluster contains non raw blocks or not */
+bool f2fs_is_sparse_cluster(struct inode *inode, pgoff_t index)
+{
+	unsigned int cluster_idx = index >> F2FS_I(inode)->i_log_cluster_size;
+
+	return f2fs_decompressed_blocks(inode, cluster_idx) !=
+		F2FS_I(inode)->i_cluster_size;
 }
 
 static bool cluster_may_compress(struct compress_ctx *cc)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 467f67cf2b38..825f6bcb7fc2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2645,10 +2645,13 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	struct dnode_of_data dn;
 	struct node_info ni;
 	bool ipu_force = false;
+	bool atomic_commit;
 	int err = 0;
 
 	/* Use COW inode to make dnode_of_data for atomic write */
-	if (f2fs_is_atomic_file(inode))
+	atomic_commit = f2fs_is_atomic_file(inode) &&
+				page_private_atomic(fio->page);
+	if (atomic_commit)
 		set_new_dnode(&dn, F2FS_I(inode)->cow_inode, NULL, NULL, 0);
 	else
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
@@ -2747,6 +2750,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	f2fs_outplace_write_data(&dn, fio);
 	trace_f2fs_do_write_data_page(page_folio(page), OPU);
 	set_inode_flag(inode, FI_APPEND_WRITE);
+	if (atomic_commit)
+		clear_page_private_atomic(page);
 out_writepage:
 	f2fs_put_dnode(&dn);
 out:
@@ -3716,6 +3721,9 @@ static int f2fs_write_end(struct file *file,
 
 	set_page_dirty(page);
 
+	if (f2fs_is_atomic_file(inode))
+		set_page_private_atomic(page);
+
 	if (pos + copied > i_size_read(inode) &&
 	    !f2fs_verity_in_progress(inode)) {
 		f2fs_i_size_write(inode, pos + copied);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 02c9355176d3..5a00e010f8c1 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -157,7 +157,8 @@ static unsigned long dir_block_index(unsigned int level,
 	unsigned long bidx = 0;
 
 	for (i = 0; i < level; i++)
-		bidx += dir_buckets(i, dir_level) * bucket_blocks(i);
+		bidx += mul_u32_u32(dir_buckets(i, dir_level),
+				    bucket_blocks(i));
 	bidx += idx * bucket_blocks(level);
 	return bidx;
 }
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index fd1fc06359ee..62ac440d9416 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -366,7 +366,7 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 static void __drop_largest_extent(struct extent_tree *et,
 					pgoff_t fofs, unsigned int len)
 {
-	if (fofs < et->largest.fofs + et->largest.len &&
+	if (fofs < (pgoff_t)et->largest.fofs + et->largest.len &&
 			fofs + len > et->largest.fofs) {
 		et->largest.len = 0;
 		et->largest_updated = true;
@@ -456,7 +456,7 @@ static bool __lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 
 	if (type == EX_READ &&
 			et->largest.fofs <= pgofs &&
-			et->largest.fofs + et->largest.len > pgofs) {
+			(pgoff_t)et->largest.fofs + et->largest.len > pgofs) {
 		*ei = et->largest;
 		ret = true;
 		stat_inc_largest_node_hit(sbi);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 92fda31c68cd..9c8acb98f4db 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -285,6 +285,7 @@ enum {
 	APPEND_INO,		/* for append ino list */
 	UPDATE_INO,		/* for update ino list */
 	TRANS_DIR_INO,		/* for transactions dir ino list */
+	XATTR_DIR_INO,		/* for xattr updated dir ino list */
 	FLUSH_INO,		/* for multiple device flushing */
 	MAX_INO_ENTRY,		/* max. list */
 };
@@ -784,7 +785,6 @@ enum {
 	FI_NEED_IPU,		/* used for ipu per file */
 	FI_ATOMIC_FILE,		/* indicate atomic file */
 	FI_DATA_EXIST,		/* indicate data exists */
-	FI_INLINE_DOTS,		/* indicate inline dot dentries */
 	FI_SKIP_WRITES,		/* should skip data page writeback */
 	FI_OPU_WRITE,		/* used for opu per file */
 	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
@@ -802,6 +802,7 @@ enum {
 	FI_ALIGNED_WRITE,	/* enable aligned write */
 	FI_COW_FILE,		/* indicate COW file */
 	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
+	FI_ATOMIC_DIRTIED,	/* indicate atomic file is dirtied */
 	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
 	FI_OPENED_FILE,		/* indicate file has been opened */
 	FI_MAX,			/* max flag, never be used */
@@ -1155,6 +1156,7 @@ enum cp_reason_type {
 	CP_FASTBOOT_MODE,
 	CP_SPEC_LOG_NUM,
 	CP_RECOVER_DIR,
+	CP_XATTR_DIR,
 };
 
 enum iostat_type {
@@ -1418,7 +1420,8 @@ static inline void f2fs_clear_bit(unsigned int nr, char *addr);
  * bit 1	PAGE_PRIVATE_ONGOING_MIGRATION
  * bit 2	PAGE_PRIVATE_INLINE_INODE
  * bit 3	PAGE_PRIVATE_REF_RESOURCE
- * bit 4-	f2fs private data
+ * bit 4	PAGE_PRIVATE_ATOMIC_WRITE
+ * bit 5-	f2fs private data
  *
  * Layout B: lowest bit should be 0
  * page.private is a wrapped pointer.
@@ -1428,6 +1431,7 @@ enum {
 	PAGE_PRIVATE_ONGOING_MIGRATION,		/* data page which is on-going migrating */
 	PAGE_PRIVATE_INLINE_INODE,		/* inode page contains inline data */
 	PAGE_PRIVATE_REF_RESOURCE,		/* dirty page has referenced resources */
+	PAGE_PRIVATE_ATOMIC_WRITE,		/* data page from atomic write path */
 	PAGE_PRIVATE_MAX
 };
 
@@ -2396,14 +2400,17 @@ static inline void clear_page_private_##name(struct page *page) \
 PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
 PAGE_PRIVATE_GET_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_GET_FUNC(gcing, ONGOING_MIGRATION);
+PAGE_PRIVATE_GET_FUNC(atomic, ATOMIC_WRITE);
 
 PAGE_PRIVATE_SET_FUNC(reference, REF_RESOURCE);
 PAGE_PRIVATE_SET_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_SET_FUNC(gcing, ONGOING_MIGRATION);
+PAGE_PRIVATE_SET_FUNC(atomic, ATOMIC_WRITE);
 
 PAGE_PRIVATE_CLEAR_FUNC(reference, REF_RESOURCE);
 PAGE_PRIVATE_CLEAR_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_CLEAR_FUNC(gcing, ONGOING_MIGRATION);
+PAGE_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
 
 static inline unsigned long get_page_private_data(struct page *page)
 {
@@ -2435,6 +2442,7 @@ static inline void clear_page_private_all(struct page *page)
 	clear_page_private_reference(page);
 	clear_page_private_gcing(page);
 	clear_page_private_inline(page);
+	clear_page_private_atomic(page);
 
 	f2fs_bug_on(F2FS_P_SB(page), page_private(page));
 }
@@ -3038,10 +3046,8 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 			return;
 		fallthrough;
 	case FI_DATA_EXIST:
-	case FI_INLINE_DOTS:
 	case FI_PIN_FILE:
 	case FI_COMPRESS_RELEASED:
-	case FI_ATOMIC_COMMITTED:
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 }
@@ -3163,8 +3169,6 @@ static inline void get_inline_info(struct inode *inode, struct f2fs_inode *ri)
 		set_bit(FI_INLINE_DENTRY, fi->flags);
 	if (ri->i_inline & F2FS_DATA_EXIST)
 		set_bit(FI_DATA_EXIST, fi->flags);
-	if (ri->i_inline & F2FS_INLINE_DOTS)
-		set_bit(FI_INLINE_DOTS, fi->flags);
 	if (ri->i_inline & F2FS_EXTRA_ATTR)
 		set_bit(FI_EXTRA_ATTR, fi->flags);
 	if (ri->i_inline & F2FS_PIN_FILE)
@@ -3185,8 +3189,6 @@ static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
 		ri->i_inline |= F2FS_INLINE_DENTRY;
 	if (is_inode_flag_set(inode, FI_DATA_EXIST))
 		ri->i_inline |= F2FS_DATA_EXIST;
-	if (is_inode_flag_set(inode, FI_INLINE_DOTS))
-		ri->i_inline |= F2FS_INLINE_DOTS;
 	if (is_inode_flag_set(inode, FI_EXTRA_ATTR))
 		ri->i_inline |= F2FS_EXTRA_ATTR;
 	if (is_inode_flag_set(inode, FI_PIN_FILE))
@@ -3273,11 +3275,6 @@ static inline int f2fs_exist_data(struct inode *inode)
 	return is_inode_flag_set(inode, FI_DATA_EXIST);
 }
 
-static inline int f2fs_has_inline_dots(struct inode *inode)
-{
-	return is_inode_flag_set(inode, FI_INLINE_DOTS);
-}
-
 static inline int f2fs_is_mmap_file(struct inode *inode)
 {
 	return is_inode_flag_set(inode, FI_MMAP_FILE);
@@ -3501,7 +3498,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
-							bool readonly);
+						bool readonly, bool need_lock);
 int f2fs_precache_extents(struct inode *inode);
 int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 int f2fs_fileattr_set(struct mnt_idmap *idmap,
@@ -4280,6 +4277,11 @@ static inline bool f2fs_meta_inode_gc_required(struct inode *inode)
  * compress.c
  */
 #ifdef CONFIG_F2FS_FS_COMPRESSION
+enum cluster_check_type {
+	CLUSTER_IS_COMPR,   /* check only if compressed cluster */
+	CLUSTER_COMPR_BLKS, /* return # of compressed blocks in a cluster */
+	CLUSTER_RAW_BLKS    /* return # of raw blocks in a cluster */
+};
 bool f2fs_is_compressed_page(struct page *page);
 struct page *f2fs_compress_control_page(struct page *page);
 int f2fs_prepare_compress_overwrite(struct inode *inode,
@@ -4306,6 +4308,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 						struct writeback_control *wbc,
 						enum iostat_type io_type);
 int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index);
+bool f2fs_is_sparse_cluster(struct inode *inode, pgoff_t index);
 void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 				pgoff_t fofs, block_t blkaddr,
 				unsigned int llen, unsigned int c_len);
@@ -4392,6 +4395,12 @@ static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
 static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi,
 							nid_t ino) { }
 #define inc_compr_inode_stat(inode)		do { } while (0)
+static inline int f2fs_is_compressed_cluster(
+				struct inode *inode,
+				pgoff_t index) { return 0; }
+static inline bool f2fs_is_sparse_cluster(
+				struct inode *inode,
+				pgoff_t index) { return true; }
 static inline void f2fs_update_read_extent_tree_range_compressed(
 				struct inode *inode,
 				pgoff_t fofs, block_t blkaddr,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 387ce167dda1..4bee980c6d18 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -218,6 +218,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
 		f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
 							TRANS_DIR_INO))
 		cp_reason = CP_RECOVER_DIR;
+	else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
+							XATTR_DIR_INO))
+		cp_reason = CP_XATTR_DIR;
 
 	return cp_reason;
 }
@@ -2117,10 +2120,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct inode *pinode;
 	loff_t isize;
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 
@@ -2167,15 +2172,10 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	/* Check if the inode already has a COW inode */
 	if (fi->cow_inode == NULL) {
 		/* Create a COW inode for atomic write */
-		pinode = f2fs_iget(inode->i_sb, fi->i_pino);
-		if (IS_ERR(pinode)) {
-			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-			ret = PTR_ERR(pinode);
-			goto out;
-		}
+		struct dentry *dentry = file_dentry(filp);
+		struct inode *dir = d_inode(dentry->d_parent);
 
-		ret = f2fs_get_tmpfile(idmap, pinode, &fi->cow_inode);
-		iput(pinode);
+		ret = f2fs_get_tmpfile(idmap, dir, &fi->cow_inode);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 			goto out;
@@ -2188,6 +2188,10 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		F2FS_I(fi->cow_inode)->atomic_inode = inode;
 	} else {
 		/* Reuse the already created COW inode */
+		f2fs_bug_on(sbi, get_dirty_pages(fi->cow_inode));
+
+		invalidate_mapping_pages(fi->cow_inode->i_mapping, 0, -1);
+
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
@@ -2229,6 +2233,9 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 
@@ -2261,6 +2268,9 @@ static int f2fs_ioc_abort_atomic_write(struct file *filp)
 	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 
@@ -2280,7 +2290,7 @@ static int f2fs_ioc_abort_atomic_write(struct file *filp)
 }
 
 int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
-							bool readonly)
+						bool readonly, bool need_lock)
 {
 	struct super_block *sb = sbi->sb;
 	int ret = 0;
@@ -2327,12 +2337,19 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 	if (readonly)
 		goto out;
 
+	/* grab sb->s_umount to avoid racing w/ remount() */
+	if (need_lock)
+		down_read(&sbi->sb->s_umount);
+
 	f2fs_stop_gc_thread(sbi);
 	f2fs_stop_discard_thread(sbi);
 
 	f2fs_drop_discard_cmd(sbi);
 	clear_opt(sbi, DISCARD);
 
+	if (need_lock)
+		up_read(&sbi->sb->s_umount);
+
 	f2fs_update_time(sbi, REQ_TIME);
 out:
 
@@ -2369,7 +2386,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		}
 	}
 
-	ret = f2fs_do_shutdown(sbi, in, readonly);
+	ret = f2fs_do_shutdown(sbi, in, readonly, true);
 
 	if (need_drop)
 		mnt_drop_write_file(filp);
@@ -2687,7 +2704,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 				(range->start + range->len) >> PAGE_SHIFT,
 				DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) ||
+		f2fs_is_atomic_file(inode)) {
 		err = -EINVAL;
 		goto unlock_out;
 	}
@@ -2711,7 +2729,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	 * block addresses are continuous.
 	 */
 	if (f2fs_lookup_read_extent_cache(inode, pg_start, &ei)) {
-		if (ei.fofs + ei.len >= pg_end)
+		if ((pgoff_t)ei.fofs + ei.len >= pg_end)
 			goto out;
 	}
 
@@ -2794,6 +2812,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 				goto clear_out;
 			}
 
+			f2fs_wait_on_page_writeback(page, DATA, true, true);
+
 			set_page_dirty(page);
 			set_page_private_gcing(page);
 			f2fs_put_page(page, 1);
@@ -2918,6 +2938,11 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 		goto out_unlock;
 	}
 
+	if (f2fs_is_atomic_file(src) || f2fs_is_atomic_file(dst)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	ret = -EINVAL;
 	if (pos_in + len > src->i_size || pos_in + len < pos_in)
 		goto out_unlock;
@@ -3301,6 +3326,11 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
+	if (f2fs_is_atomic_file(inode)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!pin) {
 		clear_inode_flag(inode, FI_PIN_FILE);
 		f2fs_i_gc_failures_write(inode, 0);
@@ -4187,6 +4217,8 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 		/* It will never fail, when page has pinned above */
 		f2fs_bug_on(F2FS_I_SB(inode), !page);
 
+		f2fs_wait_on_page_writeback(page, DATA, true, true);
+
 		set_page_dirty(page);
 		set_page_private_gcing(page);
 		f2fs_put_page(page, 1);
@@ -4201,9 +4233,8 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	pgoff_t page_idx = 0, last_idx;
-	int cluster_size = fi->i_cluster_size;
-	int count, ret;
+	pgoff_t page_idx = 0, last_idx, cluster_idx;
+	int ret;
 
 	if (!f2fs_sb_has_compression(sbi) ||
 			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
@@ -4236,10 +4267,15 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 		goto out;
 
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	last_idx >>= fi->i_log_cluster_size;
+
+	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
+		page_idx = cluster_idx << fi->i_log_cluster_size;
+
+		if (!f2fs_is_compressed_cluster(inode, page_idx))
+			continue;
 
-	count = last_idx - page_idx;
-	while (count && count >= cluster_size) {
-		ret = redirty_blocks(inode, page_idx, cluster_size);
+		ret = redirty_blocks(inode, page_idx, fi->i_cluster_size);
 		if (ret < 0)
 			break;
 
@@ -4249,9 +4285,6 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 				break;
 		}
 
-		count -= cluster_size;
-		page_idx += cluster_size;
-
 		cond_resched();
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
@@ -4278,9 +4311,9 @@ static int f2fs_ioc_compress_file(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	pgoff_t page_idx = 0, last_idx;
-	int cluster_size = F2FS_I(inode)->i_cluster_size;
-	int count, ret;
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	pgoff_t page_idx = 0, last_idx, cluster_idx;
+	int ret;
 
 	if (!f2fs_sb_has_compression(sbi) ||
 			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
@@ -4312,10 +4345,15 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	set_inode_flag(inode, FI_ENABLE_COMPRESS);
 
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	last_idx >>= fi->i_log_cluster_size;
+
+	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
+		page_idx = cluster_idx << fi->i_log_cluster_size;
 
-	count = last_idx - page_idx;
-	while (count && count >= cluster_size) {
-		ret = redirty_blocks(inode, page_idx, cluster_size);
+		if (f2fs_is_sparse_cluster(inode, page_idx))
+			continue;
+
+		ret = redirty_blocks(inode, page_idx, fi->i_cluster_size);
 		if (ret < 0)
 			break;
 
@@ -4325,9 +4363,6 @@ static int f2fs_ioc_compress_file(struct file *filp)
 				break;
 		}
 
-		count -= cluster_size;
-		page_idx += cluster_size;
-
 		cond_resched();
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
@@ -4587,6 +4622,10 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		f2fs_trace_rw_file_path(iocb->ki_filp, iocb->ki_pos,
 					iov_iter_count(to), READ);
 
+	/* In LFS mode, if there is inflight dio, wait for its completion */
+	if (f2fs_lfs_mode(F2FS_I_SB(inode)))
+		inode_dio_wait(inode);
+
 	if (f2fs_should_use_dio(inode, iocb, to)) {
 		ret = f2fs_dio_read_iter(iocb, to);
 	} else {
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 57da02bfa823..0b23a0cb438f 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -35,6 +35,11 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 	if (f2fs_inode_dirtied(inode, sync))
 		return;
 
+	if (f2fs_is_atomic_file(inode)) {
+		set_inode_flag(inode, FI_ATOMIC_DIRTIED);
+		return;
+	}
+
 	mark_inode_dirty_sync(inode);
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e54f8c08bda8..a2c4091fca6f 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -455,62 +455,6 @@ struct dentry *f2fs_get_parent(struct dentry *child)
 	return d_obtain_alias(f2fs_iget(child->d_sb, ino));
 }
 
-static int __recover_dot_dentries(struct inode *dir, nid_t pino)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
-	struct qstr dot = QSTR_INIT(".", 1);
-	struct f2fs_dir_entry *de;
-	struct page *page;
-	int err = 0;
-
-	if (f2fs_readonly(sbi->sb)) {
-		f2fs_info(sbi, "skip recovering inline_dots inode (ino:%lu, pino:%u) in readonly mountpoint",
-			  dir->i_ino, pino);
-		return 0;
-	}
-
-	if (!S_ISDIR(dir->i_mode)) {
-		f2fs_err(sbi, "inconsistent inode status, skip recovering inline_dots inode (ino:%lu, i_mode:%u, pino:%u)",
-			  dir->i_ino, dir->i_mode, pino);
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		return -ENOTDIR;
-	}
-
-	err = f2fs_dquot_initialize(dir);
-	if (err)
-		return err;
-
-	f2fs_balance_fs(sbi, true);
-
-	f2fs_lock_op(sbi);
-
-	de = f2fs_find_entry(dir, &dot, &page);
-	if (de) {
-		f2fs_put_page(page, 0);
-	} else if (IS_ERR(page)) {
-		err = PTR_ERR(page);
-		goto out;
-	} else {
-		err = f2fs_do_add_link(dir, &dot, NULL, dir->i_ino, S_IFDIR);
-		if (err)
-			goto out;
-	}
-
-	de = f2fs_find_entry(dir, &dotdot_name, &page);
-	if (de)
-		f2fs_put_page(page, 0);
-	else if (IS_ERR(page))
-		err = PTR_ERR(page);
-	else
-		err = f2fs_do_add_link(dir, &dotdot_name, NULL, pino, S_IFDIR);
-out:
-	if (!err)
-		clear_inode_flag(dir, FI_INLINE_DOTS);
-
-	f2fs_unlock_op(sbi);
-	return err;
-}
-
 static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		unsigned int flags)
 {
@@ -520,7 +464,6 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	struct dentry *new;
 	nid_t ino = -1;
 	int err = 0;
-	unsigned int root_ino = F2FS_ROOT_INO(F2FS_I_SB(dir));
 	struct f2fs_filename fname;
 
 	trace_f2fs_lookup_start(dir, dentry, flags);
@@ -556,17 +499,6 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out;
 	}
 
-	if ((dir->i_ino == root_ino) && f2fs_has_inline_dots(dir)) {
-		err = __recover_dot_dentries(dir, root_ino);
-		if (err)
-			goto out_iput;
-	}
-
-	if (f2fs_has_inline_dots(inode)) {
-		err = __recover_dot_dentries(inode, dir->i_ino);
-		if (err)
-			goto out_iput;
-	}
 	if (IS_ENCRYPTED(dir) &&
 	    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
 	    !fscrypt_has_permitted_context(dir, inode)) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 601825785226..425479d76921 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -199,6 +199,10 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
 	clear_inode_flag(inode, FI_ATOMIC_REPLACE);
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
+	if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
+		clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
+		f2fs_mark_inode_dirty_sync(inode, true);
+	}
 	stat_dec_atomic_inode(inode);
 
 	F2FS_I(inode)->atomic_write_task = NULL;
@@ -366,6 +370,10 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
 	} else {
 		sbi->committed_atomic_block += fi->atomic_write_cnt;
 		set_inode_flag(inode, FI_ATOMIC_COMMITTED);
+		if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
+			clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
+			f2fs_mark_inode_dirty_sync(inode, true);
+		}
 	}
 
 	__complete_revoke_list(inode, &revoke_list, ret ? true : false);
@@ -1282,6 +1290,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 						wait_list, issued);
 			return 0;
 		}
+
+		/*
+		 * Issue discard for conventional zones only if the device
+		 * supports discard.
+		 */
+		if (!bdev_max_discard_sectors(bdev))
+			return -EOPNOTSUPP;
 	}
 #endif
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1f1b3647a998..b4c8ac6c0859 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2571,7 +2571,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 static void f2fs_shutdown(struct super_block *sb)
 {
-	f2fs_do_shutdown(F2FS_SB(sb), F2FS_GOING_DOWN_NOSYNC, false);
+	f2fs_do_shutdown(F2FS_SB(sb), F2FS_GOING_DOWN_NOSYNC, false, false);
 }
 
 #ifdef CONFIG_QUOTA
@@ -3366,9 +3366,9 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 	u32 segment_count = le32_to_cpu(raw_super->segment_count);
 	u32 log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
 	u64 main_end_blkaddr = main_blkaddr +
-				(segment_count_main << log_blocks_per_seg);
+				((u64)segment_count_main << log_blocks_per_seg);
 	u64 seg_end_blkaddr = segment0_blkaddr +
-				(segment_count << log_blocks_per_seg);
+				((u64)segment_count << log_blocks_per_seg);
 
 	if (segment0_blkaddr != cp_blkaddr) {
 		f2fs_info(sbi, "Mismatch start address, segment0(%u) cp_blkaddr(%u)",
@@ -4183,12 +4183,14 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 	}
 
 	f2fs_warn(sbi, "Remounting filesystem read-only");
+
 	/*
-	 * Make sure updated value of ->s_mount_flags will be visible before
-	 * ->s_flags update
+	 * We have already set CP_ERROR_FLAG flag to stop all updates
+	 * to filesystem, so it doesn't need to set SB_RDONLY flag here
+	 * because the flag should be set covered w/ sb->s_umount semaphore
+	 * via remount procedure, otherwise, it will confuse code like
+	 * freeze_super() which will lead to deadlocks and other problems.
 	 */
-	smp_wmb();
-	sb->s_flags |= SB_RDONLY;
 }
 
 static void f2fs_record_error_work(struct work_struct *work)
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index f290fe9327c4..3f3874943679 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -629,6 +629,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 			const char *name, const void *value, size_t size,
 			struct page *ipage, int flags)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_xattr_entry *here, *last;
 	void *base_addr, *last_base_addr;
 	int found, newsize;
@@ -772,9 +773,18 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
 		f2fs_set_encrypted_inode(inode);
-	if (S_ISDIR(inode->i_mode))
-		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
 
+	if (!S_ISDIR(inode->i_mode))
+		goto same;
+	/*
+	 * In restrict mode, fsync() always try to trigger checkpoint for all
+	 * metadata consistency, in other mode, it triggers checkpoint when
+	 * parent's xattr metadata was updated.
+	 */
+	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
+		set_sbi_flag(sbi, SBI_NEED_CP);
+	else
+		f2fs_add_ino_entry(sbi, inode->i_ino, XATTR_DIR_INO);
 same:
 	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
 		inode->i_mode = F2FS_I(inode)->i_acl_mode;
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 300e5d9ad913..c28dc6c005f1 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -87,8 +87,8 @@ static int setfl(int fd, struct file * filp, unsigned int arg)
 	return error;
 }
 
-static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
-                     int force)
+void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
+		int force)
 {
 	write_lock_irq(&filp->f_owner.lock);
 	if (force || !filp->f_owner.pid) {
@@ -98,19 +98,13 @@ static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
 
 		if (pid) {
 			const struct cred *cred = current_cred();
+			security_file_set_fowner(filp);
 			filp->f_owner.uid = cred->uid;
 			filp->f_owner.euid = cred->euid;
 		}
 	}
 	write_unlock_irq(&filp->f_owner.lock);
 }
-
-void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
-		int force)
-{
-	security_file_set_fowner(filp);
-	f_modown(filp, pid, type, force);
-}
 EXPORT_SYMBOL(__f_setown);
 
 int f_setown(struct file *filp, int who, int force)
@@ -146,7 +140,7 @@ EXPORT_SYMBOL(f_setown);
 
 void f_delown(struct file *filp)
 {
-	f_modown(filp, NULL, PIDTYPE_TGID, 1);
+	__f_setown(filp, NULL, PIDTYPE_TGID, 1);
 }
 
 pid_t f_getown(struct file *filp)
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index a4d6ca0b8971..24727ec34e5a 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -308,6 +308,40 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_fd);
 
+int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p,
+		    struct fs_parameter *param, struct fs_parse_result *result)
+{
+	kuid_t uid;
+
+	if (fs_param_is_u32(log, p, param, result) != 0)
+		return fs_param_bad_value(log, param);
+
+	uid = make_kuid(current_user_ns(), result->uint_32);
+	if (!uid_valid(uid))
+		return inval_plog(log, "Invalid uid '%s'", param->string);
+
+	result->uid = uid;
+	return 0;
+}
+EXPORT_SYMBOL(fs_param_is_uid);
+
+int fs_param_is_gid(struct p_log *log, const struct fs_parameter_spec *p,
+		    struct fs_parameter *param, struct fs_parse_result *result)
+{
+	kgid_t gid;
+
+	if (fs_param_is_u32(log, p, param, result) != 0)
+		return fs_param_bad_value(log, param);
+
+	gid = make_kgid(current_user_ns(), result->uint_32);
+	if (!gid_valid(gid))
+		return inval_plog(log, "Invalid gid '%s'", param->string);
+
+	result->gid = gid;
+	return 0;
+}
+EXPORT_SYMBOL(fs_param_is_gid);
+
 int fs_param_is_blockdev(struct p_log *log, const struct fs_parameter_spec *p,
 		  struct fs_parameter *param, struct fs_parse_result *result)
 {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ed76121f73f2..08f7d538ca98 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1345,7 +1345,7 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 
 	/* shared locks are not allowed with parallel page cache IO */
 	if (test_bit(FUSE_I_CACHE_IO_MODE, &fi->state))
-		return false;
+		return true;
 
 	/* Parallel dio beyond EOF is not supported, at least for now. */
 	if (fuse_io_past_eof(iocb, from))
diff --git a/fs/inode.c b/fs/inode.c
index f5add7222c98..3df67672986a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -758,6 +758,10 @@ void evict_inodes(struct super_block *sb)
 			continue;
 
 		spin_lock(&inode->i_lock);
+		if (atomic_read(&inode->i_count)) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
 		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
 			spin_unlock(&inode->i_lock);
 			continue;
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 5713994328cb..0625d1c0d064 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -187,7 +187,7 @@ int dbMount(struct inode *ipbmap)
 	}
 
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
-	if (!bmp->db_numag) {
+	if (!bmp->db_numag || bmp->db_numag >= MAXAG) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
@@ -652,7 +652,7 @@ int dbNextAG(struct inode *ipbmap)
 	 * average free space.
 	 */
 	for (i = 0 ; i < bmp->db_numag; i++, agpref++) {
-		if (agpref == bmp->db_numag)
+		if (agpref >= bmp->db_numag)
 			agpref = 0;
 
 		if (atomic_read(&bmp->db_active[agpref]))
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 1407feccbc2d..a360b24ed320 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -1360,7 +1360,7 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 	/* get the ag number of this iag */
 	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
 	dn_numag = JFS_SBI(pip->i_sb)->bmap->db_numag;
-	if (agno < 0 || agno > dn_numag)
+	if (agno < 0 || agno > dn_numag || agno >= MAXAG)
 		return -EIO;
 
 	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
diff --git a/fs/namespace.c b/fs/namespace.c
index e1ced589d835..a6675c2a2383 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2801,8 +2801,15 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 	if (!__mnt_is_readonly(mnt) &&
 	   (!(sb->s_iflags & SB_I_TS_EXPIRY_WARNED)) &&
 	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
-		char *buf = (char *)__get_free_page(GFP_KERNEL);
-		char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
+		char *buf, *mntpath;
+
+		buf = (char *)__get_free_page(GFP_KERNEL);
+		if (buf)
+			mntpath = d_path(mountpoint, buf, PAGE_SIZE);
+		else
+			mntpath = ERR_PTR(-ENOMEM);
+		if (IS_ERR(mntpath))
+			mntpath = "(unknown)";
 
 		pr_warn("%s filesystem being %s at %s supports timestamps until %ptTd (0x%llx)\n",
 			sb->s_type->name,
@@ -2810,8 +2817,9 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 			mntpath, &sb->s_time_max,
 			(unsigned long long)sb->s_time_max);
 
-		free_page((unsigned long)buf);
 		sb->s_iflags |= SB_I_TS_EXPIRY_WARNED;
+		if (buf)
+			free_page((unsigned long)buf);
 	}
 }
 
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index db824c372842..b1d97335d7bb 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -138,7 +138,7 @@ static int __init netfs_init(void)
 
 error_fscache:
 error_procfile:
-	remove_proc_entry("fs/netfs", NULL);
+	remove_proc_subtree("fs/netfs", NULL);
 error_proc:
 	mempool_exit(&netfs_subrequest_pool);
 error_subreqpool:
@@ -155,7 +155,7 @@ fs_initcall(netfs_init);
 static void __exit netfs_exit(void)
 {
 	fscache_exit();
-	remove_proc_entry("fs/netfs", NULL);
+	remove_proc_subtree("fs/netfs", NULL);
 	mempool_exit(&netfs_subrequest_pool);
 	kmem_cache_destroy(netfs_subrequest_slab);
 	mempool_exit(&netfs_request_pool);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 5b452411e8fd..1153e166652b 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1956,6 +1956,7 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
 				set_bit(ops->owner_flag_bit, &sp->so_flags);
 				nfs4_put_state_owner(sp);
 				status = nfs4_recovery_handle_error(clp, status);
+				nfs4_free_state_owners(&freeme);
 				return (status != 0) ? status : -EAGAIN;
 			}
 
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index f4704f5d4086..e2e248032bfd 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1035,8 +1035,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (likely(ret == 0))
 		goto open_file;
 
-	if (ret == -EEXIST)
-		goto retry;
 	trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
 	status = nfserr_jukebox;
 	goto construction_err;
@@ -1051,6 +1049,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfserr_jukebox;
 			goto construction_err;
 		}
+		nfsd_file_put(nf);
 		open_retry = false;
 		fh_put(fhp);
 		goto retry;
diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index 7a806ac13e31..8cca1329f348 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -581,6 +581,7 @@ static __be32 idmap_id_to_name(struct xdr_stream *xdr,
 		.id = id,
 		.type = type,
 	};
+	__be32 status = nfs_ok;
 	__be32 *p;
 	int ret;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
@@ -593,12 +594,16 @@ static __be32 idmap_id_to_name(struct xdr_stream *xdr,
 		return nfserrno(ret);
 	ret = strlen(item->name);
 	WARN_ON_ONCE(ret > IDMAP_NAMESZ);
+
 	p = xdr_reserve_space(xdr, ret + 4);
-	if (!p)
-		return nfserr_resource;
-	p = xdr_encode_opaque(p, item->name, ret);
+	if (unlikely(!p)) {
+		status = nfserr_resource;
+		goto out_put;
+	}
+	xdr_encode_opaque(p, item->name, ret);
+out_put:
 	cache_put(&item->h, nn->idtoname_cache);
-	return 0;
+	return status;
 }
 
 static bool
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 67d8673a9391..69a3a84e159e 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -809,6 +809,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 			ci = &cmsg->cm_u.cm_clntinfo;
 			if (get_user(namelen, &ci->cc_name.cn_len))
 				return -EFAULT;
+			if (!namelen) {
+				dprintk("%s: namelen should not be zero", __func__);
+				return -EINVAL;
+			}
 			name.data = memdup_user(&ci->cc_name.cn_id, namelen);
 			if (IS_ERR(name.data))
 				return PTR_ERR(name.data);
@@ -831,6 +835,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 			cnm = &cmsg->cm_u.cm_name;
 			if (get_user(namelen, &cnm->cn_len))
 				return -EFAULT;
+			if (!namelen) {
+				dprintk("%s: namelen should not be zero", __func__);
+				return -EINVAL;
+			}
 			name.data = memdup_user(&cnm->cn_id, namelen);
 			if (IS_ERR(name.data))
 				return PTR_ERR(name.data);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a366fb1c1b9b..fe06779ea527 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5912,6 +5912,28 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
 	}
 }
 
+static bool
+nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
+		     struct kstat *stat)
+{
+	struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
+	struct path path;
+	int rc;
+
+	if (!nf)
+		return false;
+
+	path.mnt = currentfh->fh_export->ex_path.mnt;
+	path.dentry = file_dentry(nf->nf_file);
+
+	rc = vfs_getattr(&path, stat,
+			 (STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
+			 AT_STATX_SYNC_AS_STAT);
+
+	nfsd_file_put(nf);
+	return rc == 0;
+}
+
 /*
  * The Linux NFS server does not offer write delegations to NFSv4.0
  * clients in order to avoid conflicts between write delegations and
@@ -5947,7 +5969,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	int cb_up;
 	int status = 0;
 	struct kstat stat;
-	struct path path;
 
 	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
 	open->op_recall = false;
@@ -5983,20 +6004,16 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
-		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
-		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
-		path.mnt = currentfh->fh_export->ex_path.mnt;
-		path.dentry = currentfh->fh_dentry;
-		if (vfs_getattr(&path, &stat,
-				(STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
-				AT_STATX_SYNC_AS_STAT)) {
+		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
 			nfs4_put_stid(&dp->dl_stid);
 			destroy_delegation(dp);
 			goto out_no_deleg;
 		}
+		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
 		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
 		dp->dl_cb_fattr.ncf_initial_cinfo =
 			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
+		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
 	} else {
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
 		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
@@ -8836,6 +8853,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file_lock_context *ctx;
+	struct nfs4_delegation *dp = NULL;
 	struct file_lease *fl;
 	struct iattr attrs;
 	struct nfs4_cb_fattr *ncf;
@@ -8845,84 +8863,76 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	ctx = locks_inode_context(inode);
 	if (!ctx)
 		return 0;
+
+#define NON_NFSD_LEASE ((void *)1)
+
 	spin_lock(&ctx->flc_lock);
 	for_each_file_lock(fl, &ctx->flc_lease) {
-		unsigned char type = fl->c.flc_type;
-
 		if (fl->c.flc_flags == FL_LAYOUT)
 			continue;
-		if (fl->fl_lmops != &nfsd_lease_mng_ops) {
-			/*
-			 * non-nfs lease, if it's a lease with F_RDLCK then
-			 * we are done; there isn't any write delegation
-			 * on this inode
-			 */
-			if (type == F_RDLCK)
-				break;
-
-			nfsd_stats_wdeleg_getattr_inc(nn);
-			spin_unlock(&ctx->flc_lock);
-
-			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
+		if (fl->c.flc_type == F_WRLCK) {
+			if (fl->fl_lmops == &nfsd_lease_mng_ops)
+				dp = fl->c.flc_owner;
+			else
+				dp = NON_NFSD_LEASE;
+		}
+		break;
+	}
+	if (dp == NULL || dp == NON_NFSD_LEASE ||
+	    dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
+		spin_unlock(&ctx->flc_lock);
+		if (dp == NON_NFSD_LEASE) {
+			status = nfserrno(nfsd_open_break_lease(inode,
+								NFSD_MAY_READ));
 			if (status != nfserr_jukebox ||
 			    !nfsd_wait_for_delegreturn(rqstp, inode))
 				return status;
-			return 0;
 		}
-		if (type == F_WRLCK) {
-			struct nfs4_delegation *dp = fl->c.flc_owner;
+		return 0;
+	}
 
-			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
-				spin_unlock(&ctx->flc_lock);
-				return 0;
-			}
-			nfsd_stats_wdeleg_getattr_inc(nn);
-			dp = fl->c.flc_owner;
-			refcount_inc(&dp->dl_stid.sc_count);
-			ncf = &dp->dl_cb_fattr;
-			nfs4_cb_getattr(&dp->dl_cb_fattr);
-			spin_unlock(&ctx->flc_lock);
-			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
-					TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
-			if (ncf->ncf_cb_status) {
-				/* Recall delegation only if client didn't respond */
-				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
-				if (status != nfserr_jukebox ||
-						!nfsd_wait_for_delegreturn(rqstp, inode)) {
-					nfs4_put_stid(&dp->dl_stid);
-					return status;
-				}
-			}
-			if (!ncf->ncf_file_modified &&
-					(ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
-					ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
-				ncf->ncf_file_modified = true;
-			if (ncf->ncf_file_modified) {
-				int err;
-
-				/*
-				 * Per section 10.4.3 of RFC 8881, the server would
-				 * not update the file's metadata with the client's
-				 * modified size
-				 */
-				attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
-				attrs.ia_valid = ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
-				inode_lock(inode);
-				err = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
-				inode_unlock(inode);
-				if (err) {
-					nfs4_put_stid(&dp->dl_stid);
-					return nfserrno(err);
-				}
-				ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
-				*size = ncf->ncf_cur_fsize;
-				*modified = true;
-			}
-			nfs4_put_stid(&dp->dl_stid);
-			return 0;
+	nfsd_stats_wdeleg_getattr_inc(nn);
+	refcount_inc(&dp->dl_stid.sc_count);
+	ncf = &dp->dl_cb_fattr;
+	nfs4_cb_getattr(&dp->dl_cb_fattr);
+	spin_unlock(&ctx->flc_lock);
+
+	wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
+			    TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
+	if (ncf->ncf_cb_status) {
+		/* Recall delegation only if client didn't respond */
+		status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
+		if (status != nfserr_jukebox ||
+		    !nfsd_wait_for_delegreturn(rqstp, inode))
+			goto out_status;
+	}
+	if (!ncf->ncf_file_modified &&
+	    (ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
+	     ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
+		ncf->ncf_file_modified = true;
+	if (ncf->ncf_file_modified) {
+		int err;
+
+		/*
+		 * Per section 10.4.3 of RFC 8881, the server would
+		 * not update the file's metadata with the client's
+		 * modified size
+		 */
+		attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
+		attrs.ia_valid = ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
+		inode_lock(inode);
+		err = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
+		inode_unlock(inode);
+		if (err) {
+			status = nfserrno(err);
+			goto out_status;
 		}
-		break;
+		ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
+		*size = ncf->ncf_cur_fsize;
+		*modified = true;
 	}
-	spin_unlock(&ctx->flc_lock);
-	return 0;
+	status = 0;
+out_status:
+	nfs4_put_stid(&dp->dl_stid);
+	return status;
 }
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 862bdf23120e..ef5061bb56da 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -350,7 +350,7 @@ static int nilfs_btree_node_broken(const struct nilfs_btree_node *node,
 	if (unlikely(level < NILFS_BTREE_LEVEL_NODE_MIN ||
 		     level >= NILFS_BTREE_LEVEL_MAX ||
 		     (flags & NILFS_BTREE_NODE_ROOT) ||
-		     nchildren < 0 ||
+		     nchildren <= 0 ||
 		     nchildren > NILFS_BTREE_NODE_NCHILDREN_MAX(size))) {
 		nilfs_crit(inode->i_sb,
 			   "bad btree node (ino=%lu, blocknr=%llu): level = %d, flags = 0x%x, nchildren = %d",
@@ -381,7 +381,8 @@ static int nilfs_btree_root_broken(const struct nilfs_btree_node *node,
 	if (unlikely(level < NILFS_BTREE_LEVEL_NODE_MIN ||
 		     level >= NILFS_BTREE_LEVEL_MAX ||
 		     nchildren < 0 ||
-		     nchildren > NILFS_BTREE_ROOT_NCHILDREN_MAX)) {
+		     nchildren > NILFS_BTREE_ROOT_NCHILDREN_MAX ||
+		     (nchildren == 0 && level > NILFS_BTREE_LEVEL_NODE_MIN))) {
 		nilfs_crit(inode->i_sb,
 			   "bad btree root (ino=%lu): level = %d, flags = 0x%x, nchildren = %d",
 			   inode->i_ino, level, flags, nchildren);
@@ -1658,13 +1659,16 @@ static int nilfs_btree_check_delete(struct nilfs_bmap *btree, __u64 key)
 	int nchildren, ret;
 
 	root = nilfs_btree_get_root(btree);
+	nchildren = nilfs_btree_node_get_nchildren(root);
+	if (unlikely(nchildren == 0))
+		return 0;
+
 	switch (nilfs_btree_height(btree)) {
 	case 2:
 		bh = NULL;
 		node = root;
 		break;
 	case 3:
-		nchildren = nilfs_btree_node_get_nchildren(root);
 		if (nchildren > 1)
 			return 0;
 		ptr = nilfs_btree_node_get_ptr(root, nchildren - 1,
@@ -1673,12 +1677,12 @@ static int nilfs_btree_check_delete(struct nilfs_bmap *btree, __u64 key)
 		if (ret < 0)
 			return ret;
 		node = (struct nilfs_btree_node *)bh->b_data;
+		nchildren = nilfs_btree_node_get_nchildren(node);
 		break;
 	default:
 		return 0;
 	}
 
-	nchildren = nilfs_btree_node_get_nchildren(node);
 	maxkey = nilfs_btree_node_get_key(node, nchildren - 1);
 	nextmaxkey = (nchildren > 1) ?
 		nilfs_btree_node_get_key(node, nchildren - 2) : 0;
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 627eb2f72ef3..23fcf9e9d6c5 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2408,7 +2408,7 @@ static int vfs_setup_quota_inode(struct inode *inode, int type)
 int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 	unsigned int flags)
 {
-	struct quota_format_type *fmt = find_quota_format(format_id);
+	struct quota_format_type *fmt;
 	struct quota_info *dqopt = sb_dqopt(sb);
 	int error;
 
@@ -2418,6 +2418,7 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 	if (WARN_ON_ONCE(flags & DQUOT_SUSPENDED))
 		return -EINVAL;
 
+	fmt = find_quota_format(format_id);
 	if (!fmt)
 		return -ESRCH;
 	if (!sb->dq_op || !sb->s_qcop ||
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 9e859ba010cf..7cbd580120d1 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -496,7 +496,7 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 	int err = 0;
 
 	if (work->conn->connection_type) {
-		if (!(fp->daccess & FILE_WRITE_DATA_LE)) {
+		if (!(fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE))) {
 			pr_err("no right to write(%pD)\n", fp->filp);
 			err = -EACCES;
 			goto out;
@@ -1115,9 +1115,10 @@ static bool __dir_empty(struct dir_context *ctx, const char *name, int namlen,
 	struct ksmbd_readdir_data *buf;
 
 	buf = container_of(ctx, struct ksmbd_readdir_data, ctx);
-	buf->dirent_count++;
+	if (!is_dot_dotdot(name, namlen))
+		buf->dirent_count++;
 
-	return buf->dirent_count <= 2;
+	return !buf->dirent_count;
 }
 
 /**
@@ -1137,7 +1138,7 @@ int ksmbd_vfs_empty_dir(struct ksmbd_file *fp)
 	readdir_data.dirent_count = 0;
 
 	err = iterate_dir(fp->filp, &readdir_data.ctx);
-	if (readdir_data.dirent_count > 2)
+	if (readdir_data.dirent_count)
 		err = -ENOTEMPTY;
 	else
 		err = 0;
@@ -1166,7 +1167,7 @@ static bool __caseless_lookup(struct dir_context *ctx, const char *name,
 	if (cmp < 0)
 		cmp = strncasecmp((char *)buf->private, name, namlen);
 	if (!cmp) {
-		memcpy((char *)buf->private, name, namlen);
+		memcpy((char *)buf->private, name, buf->used);
 		buf->dirent_count = 1;
 		return false;
 	}
@@ -1234,10 +1235,7 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 		char *filepath;
 		size_t path_len, remain_len;
 
-		filepath = kstrdup(name, GFP_KERNEL);
-		if (!filepath)
-			return -ENOMEM;
-
+		filepath = name;
 		path_len = strlen(filepath);
 		remain_len = path_len;
 
@@ -1280,10 +1278,9 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 		err = -EINVAL;
 out2:
 		path_put(parent_path);
-out1:
-		kfree(filepath);
 	}
 
+out1:
 	if (!err) {
 		err = mnt_want_write(parent_path->mnt);
 		if (err) {
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index b1571dd96310..5e0346142f98 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -193,6 +193,7 @@
  */
 #ifndef ACPI_NO_ERROR_MESSAGES
 #define AE_INFO                         _acpi_module_name, __LINE__
+#define ACPI_ONCE(_fn, _plist)                  { static char _done; if (!_done) { _done = 1; _fn _plist; } }
 
 /*
  * Error reporting. Callers module and line number are inserted by AE_INFO,
@@ -201,8 +202,10 @@
  */
 #define ACPI_INFO(plist)                acpi_info plist
 #define ACPI_WARNING(plist)             acpi_warning plist
+#define ACPI_WARNING_ONCE(plist)        ACPI_ONCE(acpi_warning, plist)
 #define ACPI_EXCEPTION(plist)           acpi_exception plist
 #define ACPI_ERROR(plist)               acpi_error plist
+#define ACPI_ERROR_ONCE(plist)          ACPI_ONCE(acpi_error, plist)
 #define ACPI_BIOS_WARNING(plist)        acpi_bios_warning plist
 #define ACPI_BIOS_EXCEPTION(plist)      acpi_bios_exception plist
 #define ACPI_BIOS_ERROR(plist)          acpi_bios_error plist
@@ -214,8 +217,10 @@
 
 #define ACPI_INFO(plist)
 #define ACPI_WARNING(plist)
+#define ACPI_WARNING_ONCE(plist)
 #define ACPI_EXCEPTION(plist)
 #define ACPI_ERROR(plist)
+#define ACPI_ERROR_ONCE(plist)
 #define ACPI_BIOS_WARNING(plist)
 #define ACPI_BIOS_EXCEPTION(plist)
 #define ACPI_BIOS_ERROR(plist)
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 930b6afba6f4..e1720d930666 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -64,6 +64,8 @@ struct cpc_desc {
 	int cpu_id;
 	int write_cmd_status;
 	int write_cmd_id;
+	/* Lock used for RMW operations in cpc_write() */
+	spinlock_t rmw_lock;
 	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
 	struct acpi_psd_package domain_info;
 	struct kobject kobj;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5e694a308081..5e880f0b5662 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -694,6 +694,11 @@ enum bpf_type_flag {
 	/* DYNPTR points to xdp_buff */
 	DYNPTR_TYPE_XDP		= BIT(16 + BPF_BASE_TYPE_BITS),
 
+	/* Memory must be aligned on some architectures, used in combination with
+	 * MEM_FIXED_SIZE.
+	 */
+	MEM_ALIGNED		= BIT(17 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -731,8 +736,6 @@ enum bpf_arg_type {
 	ARG_ANYTHING,		/* any (initialized) argument is ok */
 	ARG_PTR_TO_SPIN_LOCK,	/* pointer to bpf_spin_lock */
 	ARG_PTR_TO_SOCK_COMMON,	/* pointer to sock_common */
-	ARG_PTR_TO_INT,		/* pointer to int */
-	ARG_PTR_TO_LONG,	/* pointer to long */
 	ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
 	ARG_PTR_TO_BTF_ID,	/* pointer to in-kernel struct */
 	ARG_PTR_TO_RINGBUF_MEM,	/* pointer to dynamically reserved ringbuf memory */
@@ -919,6 +922,7 @@ static_assert(__BPF_REG_TYPE_MAX <= BPF_BASE_TYPE_LIMIT);
  */
 struct bpf_insn_access_aux {
 	enum bpf_reg_type reg_type;
+	bool is_ldsx;
 	union {
 		int ctx_field_size;
 		struct {
@@ -927,6 +931,7 @@ struct bpf_insn_access_aux {
 		};
 	};
 	struct bpf_verifier_log *log; /* for verbose logs */
+	bool is_retval; /* is accessing function return value ? */
 };
 
 static inline void
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 1de7ece5d36d..aefcd6564251 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -9,6 +9,7 @@
 
 #include <linux/sched.h>
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
 #include <linux/lsm_hooks.h>
 
 #ifdef CONFIG_BPF_LSM
@@ -45,6 +46,8 @@ void bpf_inode_storage_free(struct inode *inode);
 
 void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func);
 
+int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+			     struct bpf_retval_range *range);
 #else /* !CONFIG_BPF_LSM */
 
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
@@ -78,6 +81,11 @@ static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 {
 }
 
+static inline int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+					   struct bpf_retval_range *range)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 8c252e073bd8..7325f88736b1 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -133,7 +133,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define annotate_unreachable() __annotate_unreachable(__COUNTER__)
 
 /* Annotate a C jump table to allow objtool to follow the code flow */
-#define __annotate_jump_table __section(".rodata..c_jump_table")
+#define __annotate_jump_table __section(".rodata..c_jump_table,\"a\",@progbits #")
 
 #else /* !CONFIG_OBJTOOL */
 #define annotate_reachable()
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 41d1d71c36ff..eee8577bcc54 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -279,7 +279,7 @@ struct node_footer {
 #define F2FS_INLINE_DATA	0x02	/* file inline data flag */
 #define F2FS_INLINE_DENTRY	0x04	/* file inline dentry flag */
 #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
-#define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
+#define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries (obsolete) */
 #define F2FS_EXTRA_ATTR		0x20	/* file having extra attribute */
 #define F2FS_PIN_FILE		0x40	/* file should not be gced */
 #define F2FS_COMPRESS_RELEASED	0x80	/* file released compressed blocks */
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index d3350979115f..6cf713a7e6c6 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -28,7 +28,7 @@ typedef int fs_param_type(struct p_log *,
  */
 fs_param_type fs_param_is_bool, fs_param_is_u32, fs_param_is_s32, fs_param_is_u64,
 	fs_param_is_enum, fs_param_is_string, fs_param_is_blob, fs_param_is_blockdev,
-	fs_param_is_path, fs_param_is_fd;
+	fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gid;
 
 /*
  * Specification of the type of value a parameter wants.
@@ -57,6 +57,8 @@ struct fs_parse_result {
 		int		int_32;		/* For spec_s32/spec_enum */
 		unsigned int	uint_32;	/* For spec_u32{,_octal,_hex}/spec_enum */
 		u64		uint_64;	/* For spec_u64 */
+		kuid_t		uid;
+		kgid_t		gid;
 	};
 };
 
@@ -131,6 +133,8 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_bdev(NAME, OPT)	__fsparam(fs_param_is_blockdev, NAME, OPT, 0, NULL)
 #define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0, NULL)
 #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0, NULL)
+#define fsparam_uid(NAME, OPT) __fsparam(fs_param_is_uid, NAME, OPT, 0, NULL)
+#define fsparam_gid(NAME, OPT) __fsparam(fs_param_is_gid, NAME, OPT, 0, NULL)
 
 /* String parameter that allows empty argument */
 #define fsparam_string_empty(NAME, OPT) \
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 855db460e08b..19c333fafe11 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -114,6 +114,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
 	 unsigned int obj_type)
 LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
+LSM_HOOK(void, LSM_RET_VOID, inode_free_security_rcu, void *inode_security)
 LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
 	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
 	 int *xattr_count)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a2ade0ffe9e7..efd4a0655159 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -73,6 +73,7 @@ struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
 	int	lbs_inode;
+	int	lbs_sock;
 	int	lbs_superblock;
 	int	lbs_ipc;
 	int	lbs_msg_msg;
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index c09cdcc99471..189140bf11fc 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -40,7 +40,7 @@ struct sbitmap_word {
 	/**
 	 * @swap_lock: serializes simultaneous updates of ->word and ->cleared
 	 */
-	spinlock_t swap_lock;
+	raw_spinlock_t swap_lock;
 } ____cacheline_aligned_in_smp;
 
 /**
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 0f038a1a0330..c3bca9c0bf2c 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -88,11 +88,15 @@ struct geni_se {
 #define SE_GENI_M_IRQ_STATUS		0x610
 #define SE_GENI_M_IRQ_EN		0x614
 #define SE_GENI_M_IRQ_CLEAR		0x618
+#define SE_GENI_M_IRQ_EN_SET		0x61c
+#define SE_GENI_M_IRQ_EN_CLEAR		0x620
 #define SE_GENI_S_CMD0			0x630
 #define SE_GENI_S_CMD_CTRL_REG		0x634
 #define SE_GENI_S_IRQ_STATUS		0x640
 #define SE_GENI_S_IRQ_EN		0x644
 #define SE_GENI_S_IRQ_CLEAR		0x648
+#define SE_GENI_S_IRQ_EN_SET		0x64c
+#define SE_GENI_S_IRQ_EN_CLEAR		0x650
 #define SE_GENI_TX_FIFOn		0x700
 #define SE_GENI_RX_FIFOn		0x780
 #define SE_GENI_TX_FIFO_STATUS		0x800
@@ -101,6 +105,8 @@ struct geni_se {
 #define SE_GENI_RX_WATERMARK_REG	0x810
 #define SE_GENI_RX_RFR_WATERMARK_REG	0x814
 #define SE_GENI_IOS			0x908
+#define SE_GENI_M_GP_LENGTH		0x910
+#define SE_GENI_S_GP_LENGTH		0x914
 #define SE_DMA_TX_IRQ_STAT		0xc40
 #define SE_DMA_TX_IRQ_CLR		0xc44
 #define SE_DMA_TX_FSM_RST		0xc58
@@ -234,6 +240,9 @@ struct geni_se {
 #define IO2_DATA_IN			BIT(1)
 #define RX_DATA_IN			BIT(0)
 
+/* SE_GENI_M_GP_LENGTH and SE_GENI_S_GP_LENGTH fields */
+#define GP_LENGTH			GENMASK(31, 0)
+
 /* SE_DMA_TX_IRQ_STAT Register fields */
 #define TX_DMA_DONE			BIT(0)
 #define TX_EOT				BIT(1)
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index 9f08a584d707..0b9f1e598e3a 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -76,8 +76,23 @@ struct usbnet {
 #		define EVENT_LINK_CHANGE	11
 #		define EVENT_SET_RX_MODE	12
 #		define EVENT_NO_IP_ALIGN	13
+/* This one is special, as it indicates that the device is going away
+ * there are cyclic dependencies between tasklet, timer and bh
+ * that must be broken
+ */
+#		define EVENT_UNPLUG		31
 };
 
+static inline bool usbnet_going_away(struct usbnet *ubn)
+{
+	return test_bit(EVENT_UNPLUG, &ubn->flags);
+}
+
+static inline void usbnet_mark_going_away(struct usbnet *ubn)
+{
+	set_bit(EVENT_UNPLUG, &ubn->flags);
+}
+
 static inline struct usb_driver *driver_of(struct usb_interface *intf)
 {
 	return to_usb_driver(intf->dev.driver);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ecb6824e9add..9cfd1ce0fd36 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2258,8 +2258,8 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			      bool mgmt_connected);
 void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 link_type, u8 addr_type, u8 status);
-void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-			 u8 addr_type, u8 status);
+void mgmt_connect_failed(struct hci_dev *hdev, struct hci_conn *conn,
+			 u8 status);
 void mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure);
 void mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  u8 status);
diff --git a/include/net/ip.h b/include/net/ip.h
index c5606cadb1a5..82248813619e 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -795,6 +795,8 @@ static inline void ip_cmsg_recv(struct msghdr *msg, struct sk_buff *skb)
 }
 
 bool icmp_global_allow(void);
+void icmp_global_consume(void);
+
 extern int sysctl_icmp_msgs_per_sec;
 extern int sysctl_icmp_msgs_burst;
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 45ad37adbe32..7b3f56d862de 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -953,8 +953,9 @@ enum mac80211_tx_info_flags {
  *	of their QoS TID or other priority field values.
  * @IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX: first MLO TX, used mostly internally
  *	for sequence number assignment
- * @IEEE80211_TX_CTRL_SCAN_TX: Indicates that this frame is transmitted
- *	due to scanning, not in normal operation on the interface.
+ * @IEEE80211_TX_CTRL_DONT_USE_RATE_MASK: Don't use rate mask for this frame
+ *	which is transmitted due to scanning or offchannel TX, not in normal
+ *	operation on the interface.
  * @IEEE80211_TX_CTRL_MLO_LINK: If not @IEEE80211_LINK_UNSPECIFIED, this
  *	frame should be transmitted on the specific link. This really is
  *	only relevant for frames that do not have data present, and is
@@ -975,7 +976,7 @@ enum mac80211_tx_control_flags {
 	IEEE80211_TX_CTRL_NO_SEQNO		= BIT(7),
 	IEEE80211_TX_CTRL_DONT_REORDER		= BIT(8),
 	IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX	= BIT(9),
-	IEEE80211_TX_CTRL_SCAN_TX		= BIT(10),
+	IEEE80211_TX_CTRL_DONT_USE_RATE_MASK	= BIT(10),
 	IEEE80211_TX_CTRL_MLO_LINK		= 0xf0000000,
 };
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 45bbb54e42e8..ac647c952cf0 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2437,9 +2437,26 @@ static inline s64 tcp_rto_delta_us(const struct sock *sk)
 {
 	const struct sk_buff *skb = tcp_rtx_queue_head(sk);
 	u32 rto = inet_csk(sk)->icsk_rto;
-	u64 rto_time_stamp_us = tcp_skb_timestamp_us(skb) + jiffies_to_usecs(rto);
 
-	return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
+	if (likely(skb)) {
+		u64 rto_time_stamp_us = tcp_skb_timestamp_us(skb) + jiffies_to_usecs(rto);
+
+		return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
+	} else {
+		WARN_ONCE(1,
+			"rtx queue emtpy: "
+			"out:%u sacked:%u lost:%u retrans:%u "
+			"tlp_high_seq:%u sk_state:%u ca_state:%u "
+			"advmss:%u mss_cache:%u pmtu:%u\n",
+			tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
+			tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
+			tcp_sk(sk)->tlp_high_seq, sk->sk_state,
+			inet_csk(sk)->icsk_ca_state,
+			tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
+			inet_csk(sk)->icsk_pmtu_cookie);
+		return jiffies_to_usecs(rto);
+	}
+
 }
 
 /*
diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index 99ca3e401fd1..6f6e3e2f652c 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -80,11 +80,6 @@ struct tasdevice {
 	bool is_loaderr;
 };
 
-struct tasdevice_irqinfo {
-	int irq_gpio;
-	int irq;
-};
-
 struct calidata {
 	unsigned char *data;
 	unsigned long total_sz;
@@ -92,7 +87,6 @@ struct calidata {
 
 struct tasdevice_priv {
 	struct tasdevice tasdevice[TASDEVICE_MAX_CHANNELS];
-	struct tasdevice_irqinfo irq_info;
 	struct tasdevice_rca rcabin;
 	struct calidata cali_data;
 	struct tasdevice_fw *fmw;
@@ -113,6 +107,7 @@ struct tasdevice_priv {
 	unsigned int chip_id;
 	unsigned int sysclk;
 
+	int irq;
 	int cur_prog;
 	int cur_conf;
 	int fw_state;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index ed794b5fefbe..2851c823095b 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -139,7 +139,8 @@ TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
 		{ CP_NODE_NEED_CP,	"node needs cp" },		\
 		{ CP_FASTBOOT_MODE,	"fastboot mode" },		\
 		{ CP_SPEC_LOG_NUM,	"log type is 2" },		\
-		{ CP_RECOVER_DIR,	"dir needs recovery" })
+		{ CP_RECOVER_DIR,	"dir needs recovery" },		\
+		{ CP_XATTR_DIR,		"dir's xattr updated" })
 
 #define show_shutdown_mode(type)					\
 	__print_symbolic(type,						\
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 22dac5850327..b59a1bf844cf 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/rculist_nulls.h>
 #include <linux/cpu.h>
+#include <linux/cpuset.h>
 #include <linux/task_work.h>
 #include <linux/audit.h>
 #include <linux/mmu_context.h>
@@ -1166,7 +1167,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 
 	if (!alloc_cpumask_var(&wq->cpu_mask, GFP_KERNEL))
 		goto err;
-	cpumask_copy(wq->cpu_mask, cpu_possible_mask);
+	cpuset_cpus_allowed(data->task, wq->cpu_mask);
 	wq->acct[IO_WQ_ACCT_BOUND].max_workers = bounded;
 	wq->acct[IO_WQ_ACCT_UNBOUND].max_workers =
 				task_rlimit(current, RLIMIT_NPROC);
@@ -1321,17 +1322,29 @@ static int io_wq_cpu_offline(unsigned int cpu, struct hlist_node *node)
 
 int io_wq_cpu_affinity(struct io_uring_task *tctx, cpumask_var_t mask)
 {
+	cpumask_var_t allowed_mask;
+	int ret = 0;
+
 	if (!tctx || !tctx->io_wq)
 		return -EINVAL;
 
+	if (!alloc_cpumask_var(&allowed_mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	rcu_read_lock();
-	if (mask)
-		cpumask_copy(tctx->io_wq->cpu_mask, mask);
-	else
-		cpumask_copy(tctx->io_wq->cpu_mask, cpu_possible_mask);
+	cpuset_cpus_allowed(tctx->io_wq->task, allowed_mask);
+	if (mask) {
+		if (cpumask_subset(mask, allowed_mask))
+			cpumask_copy(tctx->io_wq->cpu_mask, mask);
+		else
+			ret = -EINVAL;
+	} else {
+		cpumask_copy(tctx->io_wq->cpu_mask, allowed_mask);
+	}
 	rcu_read_unlock();
 
-	return 0;
+	free_cpumask_var(allowed_mask);
+	return ret;
 }
 
 /*
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 896e707e0618..c0d8ee0c9786 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2401,7 +2401,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 		return 1;
 	if (unlikely(!llist_empty(&ctx->work_llist)))
 		return 1;
-	if (unlikely(test_thread_flag(TIF_NOTIFY_SIGNAL)))
+	if (unlikely(task_work_pending(current)))
 		return 1;
 	if (unlikely(task_sigpending(current)))
 		return -EINTR;
@@ -2502,9 +2502,9 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 		 * If we got woken because of task_work being processed, run it
 		 * now rather than let the caller do another wait loop.
 		 */
-		io_run_task_work();
 		if (!llist_empty(&ctx->work_llist))
 			io_run_local_work(ctx, nr_wait);
+		io_run_task_work();
 
 		/*
 		 * Non-local task_work will be run on exit to userspace, but
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 1a2128459cb4..e6b44367df67 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -856,6 +856,14 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
 
 	ret = io_iter_do_read(rw, &io->iter);
 
+	/*
+	 * Some file systems like to return -EOPNOTSUPP for an IOCB_NOWAIT
+	 * issue, even though they should be returning -EAGAIN. To be safe,
+	 * retry from blocking context for either.
+	 */
+	if (ret == -EOPNOTSUPP && force_nonblock)
+		ret = -EAGAIN;
+
 	if (ret == -EAGAIN || (req->flags & REQ_F_REISSUE)) {
 		req->flags &= ~REQ_F_REISSUE;
 		/* If we can poll, just do that. */
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index b3722e5275e7..4dcb1c586536 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/audit.h>
 #include <linux/security.h>
+#include <linux/cpuset.h>
 #include <linux/io_uring.h>
 
 #include <uapi/linux/io_uring.h>
@@ -460,11 +461,22 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 			return 0;
 
 		if (p->flags & IORING_SETUP_SQ_AFF) {
+			cpumask_var_t allowed_mask;
 			int cpu = p->sq_thread_cpu;
 
 			ret = -EINVAL;
 			if (cpu >= nr_cpu_ids || !cpu_online(cpu))
 				goto err_sqpoll;
+			ret = -ENOMEM;
+			if (!alloc_cpumask_var(&allowed_mask, GFP_KERNEL))
+				goto err_sqpoll;
+			ret = -EINVAL;
+			cpuset_cpus_allowed(current, allowed_mask);
+			if (!cpumask_test_cpu(cpu, allowed_mask)) {
+				free_cpumask_var(allowed_mask);
+				goto err_sqpoll;
+			}
+			free_cpumask_var(allowed_mask);
 			sqd->sq_cpu = cpu;
 		} else {
 			sqd->sq_cpu = -1;
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 68240c3c6e7d..7f8a66a62661 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -11,7 +11,6 @@
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
 #include <linux/kallsyms.h>
-#include <linux/bpf_verifier.h>
 #include <net/bpf_sk_storage.h>
 #include <linux/bpf_local_storage.h>
 #include <linux/btf_ids.h>
@@ -389,3 +388,36 @@ const struct bpf_verifier_ops lsm_verifier_ops = {
 	.get_func_proto = bpf_lsm_func_proto,
 	.is_valid_access = btf_ctx_access,
 };
+
+/* hooks return 0 or 1 */
+BTF_SET_START(bool_lsm_hooks)
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+BTF_ID(func, bpf_lsm_xfrm_state_pol_flow_match)
+#endif
+#ifdef CONFIG_AUDIT
+BTF_ID(func, bpf_lsm_audit_rule_known)
+#endif
+BTF_ID(func, bpf_lsm_inode_xattr_skipcap)
+BTF_SET_END(bool_lsm_hooks)
+
+int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+			     struct bpf_retval_range *retval_range)
+{
+	/* no return value range for void hooks */
+	if (!prog->aux->attach_func_proto->type)
+		return -EINVAL;
+
+	if (btf_id_set_contains(&bool_lsm_hooks, prog->aux->attach_btf_id)) {
+		retval_range->minval = 0;
+		retval_range->maxval = 1;
+	} else {
+		/* All other available LSM hooks, except task_prctl, return 0
+		 * on success and negative error code on failure.
+		 * To keep things simple, we only allow bpf progs to return 0
+		 * or negative errno for task_prctl too.
+		 */
+		retval_range->minval = -MAX_ERRNO;
+		retval_range->maxval = 0;
+	}
+	return 0;
+}
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2f157ffbc67c..96e8596a76ce 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6250,8 +6250,11 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 
 	if (arg == nr_args) {
 		switch (prog->expected_attach_type) {
-		case BPF_LSM_CGROUP:
 		case BPF_LSM_MAC:
+			/* mark we are accessing the return value */
+			info->is_retval = true;
+			fallthrough;
+		case BPF_LSM_CGROUP:
 		case BPF_TRACE_FEXIT:
 			/* When LSM programs are attached to void LSM hooks
 			 * they use FEXIT trampolines and when attached to
@@ -8715,6 +8718,7 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	struct bpf_core_cand_list cands = {};
 	struct bpf_core_relo_res targ_res;
 	struct bpf_core_spec *specs;
+	const struct btf_type *type;
 	int err;
 
 	/* ~4k of temp memory necessary to convert LLVM spec like "0:1:0:5"
@@ -8724,6 +8728,13 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	if (!specs)
 		return -ENOMEM;
 
+	type = btf_type_by_id(ctx->btf, relo->type_id);
+	if (!type) {
+		bpf_log(ctx->log, "relo #%u: bad type id %u\n",
+			relo_idx, relo->type_id);
+		return -EINVAL;
+	}
+
 	if (need_cands) {
 		struct bpf_cand_cache *cc;
 		int i;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7268370600f6..a9ae8f8e6180 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -517,11 +517,12 @@ static int __bpf_strtoll(const char *buf, size_t buf_len, u64 flags,
 }
 
 BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf_len, u64, flags,
-	   long *, res)
+	   s64 *, res)
 {
 	long long _res;
 	int err;
 
+	*res = 0;
 	err = __bpf_strtoll(buf, buf_len, flags, &_res);
 	if (err < 0)
 		return err;
@@ -538,16 +539,18 @@ const struct bpf_func_proto bpf_strtol_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_size	= sizeof(s64),
 };
 
 BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
-	   unsigned long *, res)
+	   u64 *, res)
 {
 	unsigned long long _res;
 	bool is_negative;
 	int err;
 
+	*res = 0;
 	err = __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
 	if (err < 0)
 		return err;
@@ -566,7 +569,8 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_size	= sizeof(u64),
 };
 
 BPF_CALL_3(bpf_strncmp, const char *, s1, u32, s1_sz, const char *, s2)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f45ed6adc092..f6b6d297fad6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5910,6 +5910,7 @@ static const struct bpf_func_proto bpf_sys_close_proto = {
 
 BPF_CALL_4(bpf_kallsyms_lookup_name, const char *, name, int, name_sz, int, flags, u64 *, res)
 {
+	*res = 0;
 	if (flags)
 		return -EINVAL;
 
@@ -5930,7 +5931,8 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_size	= sizeof(u64),
 };
 
 static const struct bpf_func_proto *
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 73f55f4b945e..c821713249c8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2334,6 +2334,25 @@ static void mark_reg_unknown(struct bpf_verifier_env *env,
 	__mark_reg_unknown(env, regs + regno);
 }
 
+static int __mark_reg_s32_range(struct bpf_verifier_env *env,
+				struct bpf_reg_state *regs,
+				u32 regno,
+				s32 s32_min,
+				s32 s32_max)
+{
+	struct bpf_reg_state *reg = regs + regno;
+
+	reg->s32_min_value = max_t(s32, reg->s32_min_value, s32_min);
+	reg->s32_max_value = min_t(s32, reg->s32_max_value, s32_max);
+
+	reg->smin_value = max_t(s64, reg->smin_value, s32_min);
+	reg->smax_value = min_t(s64, reg->smax_value, s32_max);
+
+	reg_bounds_sync(reg);
+
+	return reg_bounds_sanity_check(env, reg, "s32_range");
+}
+
 static void __mark_reg_not_init(const struct bpf_verifier_env *env,
 				struct bpf_reg_state *reg)
 {
@@ -5575,11 +5594,13 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
 			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id)
+			    struct btf **btf, u32 *btf_id, bool *is_retval, bool is_ldsx)
 {
 	struct bpf_insn_access_aux info = {
 		.reg_type = *reg_type,
 		.log = &env->log,
+		.is_retval = false,
+		.is_ldsx = is_ldsx,
 	};
 
 	if (env->ops->is_valid_access &&
@@ -5592,6 +5613,7 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 		 * type of narrower access.
 		 */
 		*reg_type = info.reg_type;
+		*is_retval = info.is_retval;
 
 		if (base_type(*reg_type) == PTR_TO_BTF_ID) {
 			*btf = info.btf;
@@ -6760,6 +6782,17 @@ static int check_stack_access_within_bounds(
 	return grow_stack_state(env, state, -min_off /* size */);
 }
 
+static bool get_func_retval_range(struct bpf_prog *prog,
+				  struct bpf_retval_range *range)
+{
+	if (prog->type == BPF_PROG_TYPE_LSM &&
+		prog->expected_attach_type == BPF_LSM_MAC &&
+		!bpf_lsm_get_retval_range(prog, range)) {
+		return true;
+	}
+	return false;
+}
+
 /* check whether memory at (regno + off) is accessible for t = (read | write)
  * if t==write, value_regno is a register which value is stored into memory
  * if t==read, value_regno is a register which will receive the value from memory
@@ -6864,6 +6897,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (!err && value_regno >= 0 && (t == BPF_READ || rdonly_mem))
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_CTX) {
+		bool is_retval = false;
+		struct bpf_retval_range range;
 		enum bpf_reg_type reg_type = SCALAR_VALUE;
 		struct btf *btf = NULL;
 		u32 btf_id = 0;
@@ -6879,7 +6914,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return err;
 
 		err = check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
-				       &btf_id);
+				       &btf_id, &is_retval, is_ldsx);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t == BPF_READ && value_regno >= 0) {
@@ -6888,7 +6923,14 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			 * case, we know the offset is zero.
 			 */
 			if (reg_type == SCALAR_VALUE) {
-				mark_reg_unknown(env, regs, value_regno);
+				if (is_retval && get_func_retval_range(env->prog, &range)) {
+					err = __mark_reg_s32_range(env, regs, value_regno,
+								   range.minval, range.maxval);
+					if (err)
+						return err;
+				} else {
+					mark_reg_unknown(env, regs, value_regno);
+				}
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
@@ -8116,6 +8158,12 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
 	       type == ARG_CONST_SIZE_OR_ZERO;
 }
 
+static bool arg_type_is_raw_mem(enum bpf_arg_type type)
+{
+	return base_type(type) == ARG_PTR_TO_MEM &&
+	       type & MEM_UNINIT;
+}
+
 static bool arg_type_is_release(enum bpf_arg_type type)
 {
 	return type & OBJ_RELEASE;
@@ -8126,16 +8174,6 @@ static bool arg_type_is_dynptr(enum bpf_arg_type type)
 	return base_type(type) == ARG_PTR_TO_DYNPTR;
 }
 
-static int int_ptr_type_to_size(enum bpf_arg_type type)
-{
-	if (type == ARG_PTR_TO_INT)
-		return sizeof(u32);
-	else if (type == ARG_PTR_TO_LONG)
-		return sizeof(u64);
-
-	return -EINVAL;
-}
-
 static int resolve_map_arg_type(struct bpf_verifier_env *env,
 				 const struct bpf_call_arg_meta *meta,
 				 enum bpf_arg_type *arg_type)
@@ -8208,16 +8246,6 @@ static const struct bpf_reg_types mem_types = {
 	},
 };
 
-static const struct bpf_reg_types int_ptr_types = {
-	.types = {
-		PTR_TO_STACK,
-		PTR_TO_PACKET,
-		PTR_TO_PACKET_META,
-		PTR_TO_MAP_KEY,
-		PTR_TO_MAP_VALUE,
-	},
-};
-
 static const struct bpf_reg_types spin_lock_types = {
 	.types = {
 		PTR_TO_MAP_VALUE,
@@ -8273,8 +8301,6 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
 	[ARG_PTR_TO_MEM]		= &mem_types,
 	[ARG_PTR_TO_RINGBUF_MEM]	= &ringbuf_mem_types,
-	[ARG_PTR_TO_INT]		= &int_ptr_types,
-	[ARG_PTR_TO_LONG]		= &int_ptr_types,
 	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
 	[ARG_PTR_TO_FUNC]		= &func_ptr_types,
 	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
@@ -8835,9 +8861,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 */
 		meta->raw_mode = arg_type & MEM_UNINIT;
 		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_helper_mem_access(env, regno,
-						      fn->arg_size[arg], false,
-						      meta);
+			err = check_helper_mem_access(env, regno, fn->arg_size[arg], false, meta);
+			if (err)
+				return err;
+			if (arg_type & MEM_ALIGNED)
+				err = check_ptr_alignment(env, reg, 0, fn->arg_size[arg], true);
 		}
 		break;
 	case ARG_CONST_SIZE:
@@ -8862,17 +8890,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		if (err)
 			return err;
 		break;
-	case ARG_PTR_TO_INT:
-	case ARG_PTR_TO_LONG:
-	{
-		int size = int_ptr_type_to_size(arg_type);
-
-		err = check_helper_mem_access(env, regno, size, false, meta);
-		if (err)
-			return err;
-		err = check_ptr_alignment(env, reg, 0, size, true);
-		break;
-	}
 	case ARG_PTR_TO_CONST_STR:
 	{
 		err = check_reg_const_str(env, reg, regno);
@@ -9189,15 +9206,15 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn)
 {
 	int count = 0;
 
-	if (fn->arg1_type == ARG_PTR_TO_UNINIT_MEM)
+	if (arg_type_is_raw_mem(fn->arg1_type))
 		count++;
-	if (fn->arg2_type == ARG_PTR_TO_UNINIT_MEM)
+	if (arg_type_is_raw_mem(fn->arg2_type))
 		count++;
-	if (fn->arg3_type == ARG_PTR_TO_UNINIT_MEM)
+	if (arg_type_is_raw_mem(fn->arg3_type))
 		count++;
-	if (fn->arg4_type == ARG_PTR_TO_UNINIT_MEM)
+	if (arg_type_is_raw_mem(fn->arg4_type))
 		count++;
-	if (fn->arg5_type == ARG_PTR_TO_UNINIT_MEM)
+	if (arg_type_is_raw_mem(fn->arg5_type))
 		count++;
 
 	/* We only support one arg being in raw mode at the moment,
@@ -9911,9 +9928,13 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
 	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
 }
 
-static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg)
+static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg,
+				bool return_32bit)
 {
-	return range.minval <= reg->smin_value && reg->smax_value <= range.maxval;
+	if (return_32bit)
+		return range.minval <= reg->s32_min_value && reg->s32_max_value <= range.maxval;
+	else
+		return range.minval <= reg->smin_value && reg->smax_value <= range.maxval;
 }
 
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
@@ -9950,8 +9971,8 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		if (err)
 			return err;
 
-		/* enforce R0 return value range */
-		if (!retval_range_within(callee->callback_ret_range, r0)) {
+		/* enforce R0 return value range, and bpf_callback_t returns 64bit */
+		if (!retval_range_within(callee->callback_ret_range, r0, false)) {
 			verbose_invalid_scalar(env, r0, callee->callback_ret_range,
 					       "At callback return", "R0");
 			return -EINVAL;
@@ -15572,6 +15593,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	int err;
 	struct bpf_func_state *frame = env->cur_state->frame[0];
 	const bool is_subprog = frame->subprogno;
+	bool return_32bit = false;
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
 	if (!is_subprog || frame->in_exception_callback_fn) {
@@ -15677,12 +15699,14 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 
 	case BPF_PROG_TYPE_LSM:
 		if (env->prog->expected_attach_type != BPF_LSM_CGROUP) {
-			/* Regular BPF_PROG_TYPE_LSM programs can return
-			 * any value.
-			 */
-			return 0;
-		}
-		if (!env->prog->aux->attach_func_proto->type) {
+			/* no range found, any return value is allowed */
+			if (!get_func_retval_range(env->prog, &range))
+				return 0;
+			/* no restricted range, any return value is allowed */
+			if (range.minval == S32_MIN && range.maxval == S32_MAX)
+				return 0;
+			return_32bit = true;
+		} else if (!env->prog->aux->attach_func_proto->type) {
 			/* Make sure programs that attach to void
 			 * hooks don't try to modify return value.
 			 */
@@ -15712,7 +15736,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	if (err)
 		return err;
 
-	if (!retval_range_within(range, reg)) {
+	if (!retval_range_within(range, reg, return_32bit)) {
 		verbose_invalid_scalar(env, reg, range, exit_ctx, reg_name);
 		if (!is_subprog &&
 		    prog->expected_attach_type == BPF_LSM_CGROUP &&
diff --git a/kernel/kthread.c b/kernel/kthread.c
index f7be976ff88a..db4ceb0f503c 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -845,8 +845,16 @@ int kthread_worker_fn(void *worker_ptr)
 		 * event only cares about the address.
 		 */
 		trace_sched_kthread_work_execute_end(work, func);
-	} else if (!freezing(current))
+	} else if (!freezing(current)) {
 		schedule();
+	} else {
+		/*
+		 * Handle the case where the current remains
+		 * TASK_INTERRUPTIBLE. try_to_freeze() expects
+		 * the current to be TASK_RUNNING.
+		 */
+		__set_current_state(TASK_RUNNING);
+	}
 
 	try_to_freeze();
 	cond_resched();
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..3468d8230e5f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6184,25 +6184,27 @@ static struct pending_free *get_pending_free(void)
 static void free_zapped_rcu(struct rcu_head *cb);
 
 /*
- * Schedule an RCU callback if no RCU callback is pending. Must be called with
- * the graph lock held.
- */
-static void call_rcu_zapped(struct pending_free *pf)
+* See if we need to queue an RCU callback, must called with
+* the lockdep lock held, returns false if either we don't have
+* any pending free or the callback is already scheduled.
+* Otherwise, a call_rcu() must follow this function call.
+*/
+static bool prepare_call_rcu_zapped(struct pending_free *pf)
 {
 	WARN_ON_ONCE(inside_selftest());
 
 	if (list_empty(&pf->zapped))
-		return;
+		return false;
 
 	if (delayed_free.scheduled)
-		return;
+		return false;
 
 	delayed_free.scheduled = true;
 
 	WARN_ON_ONCE(delayed_free.pf + delayed_free.index != pf);
 	delayed_free.index ^= 1;
 
-	call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
+	return true;
 }
 
 /* The caller must hold the graph lock. May be called from RCU context. */
@@ -6228,6 +6230,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 {
 	struct pending_free *pf;
 	unsigned long flags;
+	bool need_callback;
 
 	if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
 		return;
@@ -6239,14 +6242,18 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	pf = delayed_free.pf + (delayed_free.index ^ 1);
 	__free_zapped_classes(pf);
 	delayed_free.scheduled = false;
+	need_callback =
+		prepare_call_rcu_zapped(delayed_free.pf + delayed_free.index);
+	lockdep_unlock();
+	raw_local_irq_restore(flags);
 
 	/*
-	 * If there's anything on the open list, close and start a new callback.
-	 */
-	call_rcu_zapped(delayed_free.pf + delayed_free.index);
+	* If there's pending free and its callback has not been scheduled,
+	* queue an RCU callback.
+	*/
+	if (need_callback)
+		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 
-	lockdep_unlock();
-	raw_local_irq_restore(flags);
 }
 
 /*
@@ -6286,6 +6293,7 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 {
 	struct pending_free *pf;
 	unsigned long flags;
+	bool need_callback;
 
 	init_data_structures_once();
 
@@ -6293,10 +6301,11 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 	lockdep_lock();
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
-	call_rcu_zapped(pf);
+	need_callback = prepare_call_rcu_zapped(pf);
 	lockdep_unlock();
 	raw_local_irq_restore(flags);
-
+	if (need_callback)
+		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 	/*
 	 * Wait for any possible iterators from look_up_lock_class() to pass
 	 * before continuing to free the memory they refer to.
@@ -6390,6 +6399,7 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 	struct pending_free *pf;
 	unsigned long flags;
 	int locked;
+	bool need_callback = false;
 
 	raw_local_irq_save(flags);
 	locked = graph_lock();
@@ -6398,11 +6408,13 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 
 	pf = get_pending_free();
 	__lockdep_reset_lock(pf, lock);
-	call_rcu_zapped(pf);
+	need_callback = prepare_call_rcu_zapped(pf);
 
 	graph_unlock();
 out_irq:
 	raw_local_irq_restore(flags);
+	if (need_callback)
+		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 }
 
 /*
@@ -6446,6 +6458,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	struct pending_free *pf;
 	unsigned long flags;
 	bool found = false;
+	bool need_callback = false;
 
 	might_sleep();
 
@@ -6466,11 +6479,14 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	if (found) {
 		pf = get_pending_free();
 		__lockdep_free_key_range(pf, key, 1);
-		call_rcu_zapped(pf);
+		need_callback = prepare_call_rcu_zapped(pf);
 	}
 	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
+	if (need_callback)
+		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
+
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
 	synchronize_rcu();
 }
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index a10b2b9a6fdf..50ffcc413b54 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -5,7 +5,7 @@
 
 # These are called from save_stack_trace() on slub debug path,
 # and produce insane amounts of uninteresting coverage.
-KCOV_INSTRUMENT_module.o := n
+KCOV_INSTRUMENT_main.o := n
 
 obj-y += main.o
 obj-y += strict_rwx.o
diff --git a/kernel/padata.c b/kernel/padata.c
index 0fa6c2895460..d899f34558af 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -404,7 +404,8 @@ void padata_do_serial(struct padata_priv *padata)
 	/* Sort in ascending order of sequence number. */
 	list_for_each_prev(pos, &reorder->list) {
 		cur = list_entry(pos, struct padata_priv, list);
-		if (cur->seq_nr < padata->seq_nr)
+		/* Compare by difference to consider integer wrap around */
+		if ((signed int)(cur->seq_nr - padata->seq_nr) < 0)
 			break;
 	}
 	list_add(&padata->list, pos);
@@ -512,9 +513,12 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
 	 * thread function.  Load balance large jobs between threads by
 	 * increasing the number of chunks, guarantee at least the minimum
 	 * chunk size from the caller, and honor the caller's alignment.
+	 * Ensure chunk_size is at least 1 to prevent divide-by-0
+	 * panic in padata_mt_helper().
 	 */
 	ps.chunk_size = job->size / (ps.nworks * load_balance_factor);
 	ps.chunk_size = max(ps.chunk_size, job->min_chunk);
+	ps.chunk_size = max(ps.chunk_size, 1ul);
 	ps.chunk_size = roundup(ps.chunk_size, job->align);
 
 	/*
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 2d9eed2bf750..9b485f1060c0 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -220,7 +220,10 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 	if (needwake) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DoWake"));
-		wake_up_process(rdp_gp->nocb_gp_kthread);
+		if (cpu_is_offline(raw_smp_processor_id()))
+			swake_up_one_online(&rdp_gp->nocb_gp_wq);
+		else
+			wake_up_process(rdp_gp->nocb_gp_kthread);
 	}
 
 	return needwake;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9bedd148f007..09faca47e90f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1599,46 +1599,40 @@ static inline bool __dl_less(struct rb_node *a, const struct rb_node *b)
 	return dl_time_before(__node_2_dle(a)->deadline, __node_2_dle(b)->deadline);
 }
 
-static inline struct sched_statistics *
+static __always_inline struct sched_statistics *
 __schedstats_from_dl_se(struct sched_dl_entity *dl_se)
 {
+	if (!schedstat_enabled())
+		return NULL;
+
+	if (dl_server(dl_se))
+		return NULL;
+
 	return &dl_task_of(dl_se)->stats;
 }
 
 static inline void
 update_stats_wait_start_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
-
-	if (!schedstat_enabled())
-		return;
-
-	stats = __schedstats_from_dl_se(dl_se);
-	__update_stats_wait_start(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
+	if (stats)
+		__update_stats_wait_start(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
 }
 
 static inline void
 update_stats_wait_end_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
-
-	if (!schedstat_enabled())
-		return;
-
-	stats = __schedstats_from_dl_se(dl_se);
-	__update_stats_wait_end(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
+	if (stats)
+		__update_stats_wait_end(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
 }
 
 static inline void
 update_stats_enqueue_sleeper_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
-
-	if (!schedstat_enabled())
-		return;
-
-	stats = __schedstats_from_dl_se(dl_se);
-	__update_stats_enqueue_sleeper(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
+	if (stats)
+		__update_stats_enqueue_sleeper(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
 }
 
 static inline void
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 483c137b9d3d..5e4162d02afc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -511,7 +511,7 @@ static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
 
 static int se_is_idle(struct sched_entity *se)
 {
-	return 0;
+	return task_has_idle_policy(task_of(se));
 }
 
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
@@ -3188,6 +3188,15 @@ static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 		return true;
 	}
 
+	/*
+	 * This vma has not been accessed for a while, and if the number
+	 * the threads in the same process is low, which means no other
+	 * threads can help scan this vma, force a vma scan.
+	 */
+	if (READ_ONCE(mm->numa_scan_seq) >
+	   (vma->numab_state->prev_scan_seq + get_nr_threads(current)))
+		return true;
+
 	return false;
 }
 
@@ -8381,16 +8390,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (test_tsk_need_resched(curr))
 		return;
 
-	/* Idle tasks are by definition preempted by non-idle tasks. */
-	if (unlikely(task_has_idle_policy(curr)) &&
-	    likely(!task_has_idle_policy(p)))
-		goto preempt;
-
-	/*
-	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
-	 * is driven by the tick):
-	 */
-	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
+	if (!sched_feat(WAKEUP_PREEMPTION))
 		return;
 
 	find_matching_se(&se, &pse);
@@ -8400,7 +8400,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	pse_is_idle = se_is_idle(pse);
 
 	/*
-	 * Preempt an idle group in favor of a non-idle group (and don't preempt
+	 * Preempt an idle entity in favor of a non-idle entity (and don't preempt
 	 * in the inverse case).
 	 */
 	if (cse_is_idle && !pse_is_idle)
@@ -8408,9 +8408,14 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (cse_is_idle != pse_is_idle)
 		return;
 
+	/*
+	 * BATCH and IDLE tasks do not preempt others.
+	 */
+	if (unlikely(p->policy != SCHED_NORMAL))
+		return;
+
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
-
 	/*
 	 * XXX pick_eevdf(cfs_rq) != se ?
 	 */
@@ -9360,9 +9365,10 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 
+	/* hw_pressure doesn't care about invariance */
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_hw_load_avg(now, rq, hw_pressure) |
+		  update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d1daeab1bbc1..433be6bc8b77 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1226,7 +1226,8 @@ static const struct bpf_func_proto bpf_get_func_arg_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_LONG,
+	.arg3_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_size	= sizeof(u64),
 };
 
 BPF_CALL_2(get_func_ret, void *, ctx, u64 *, value)
@@ -1242,7 +1243,8 @@ static const struct bpf_func_proto bpf_get_func_ret_proto = {
 	.func		= get_func_ret,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_LONG,
+	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg2_size	= sizeof(u64),
 };
 
 BPF_CALL_1(get_func_arg_cnt, void *, ctx)
@@ -3482,17 +3484,20 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 					     uprobes[i].ref_ctr_offset,
 					     &uprobes[i].consumer);
 		if (err) {
-			bpf_uprobe_unregister(&path, uprobes, i);
-			goto error_free;
+			link->cnt = i;
+			goto error_unregister;
 		}
 	}
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
-		goto error_free;
+		goto error_unregister;
 
 	return bpf_link_settle(&link_primer);
 
+error_unregister:
+	bpf_uprobe_unregister(&path, uprobes, link->cnt);
+
 error_free:
 	kvfree(uprobes);
 	kfree(link);
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7cea91e193a8..1ea8af72849c 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -142,13 +142,14 @@ static void fill_pool(void)
 	 * READ_ONCE()s pair with the WRITE_ONCE()s in pool_lock critical
 	 * sections.
 	 */
-	while (READ_ONCE(obj_nr_tofree) && (READ_ONCE(obj_pool_free) < obj_pool_min_free)) {
+	while (READ_ONCE(obj_nr_tofree) &&
+	       READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
 		raw_spin_lock_irqsave(&pool_lock, flags);
 		/*
 		 * Recheck with the lock held as the worker thread might have
 		 * won the race and freed the global free list already.
 		 */
-		while (obj_nr_tofree && (obj_pool_free < obj_pool_min_free)) {
+		while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
 			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
 			hlist_del(&obj->node);
 			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 5e2e93307f0d..d3412984170c 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -65,7 +65,7 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
 {
 	unsigned long mask, word_mask;
 
-	guard(spinlock_irqsave)(&map->swap_lock);
+	guard(raw_spinlock_irqsave)(&map->swap_lock);
 
 	if (!map->cleared) {
 		if (depth == 0)
@@ -136,7 +136,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 	}
 
 	for (i = 0; i < sb->map_nr; i++)
-		spin_lock_init(&sb->map[i].swap_lock);
+		raw_spin_lock_init(&sb->map[i].swap_lock);
 
 	return 0;
 }
diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
index 88a2c35e1b59..5627b00fca29 100644
--- a/lib/xz/xz_crc32.c
+++ b/lib/xz/xz_crc32.c
@@ -29,7 +29,7 @@ STATIC_RW_DATA uint32_t xz_crc32_table[256];
 
 XZ_EXTERN void xz_crc32_init(void)
 {
-	const uint32_t poly = CRC32_POLY_LE;
+	const uint32_t poly = 0xEDB88320;
 
 	uint32_t i;
 	uint32_t j;
diff --git a/lib/xz/xz_private.h b/lib/xz/xz_private.h
index bf1e94ec7873..d9fd49b45fd7 100644
--- a/lib/xz/xz_private.h
+++ b/lib/xz/xz_private.h
@@ -105,10 +105,6 @@
 #	endif
 #endif
 
-#ifndef CRC32_POLY_LE
-#define CRC32_POLY_LE 0xedb88320
-#endif
-
 /*
  * Allocate memory for LZMA2 decoder. xz_dec_lzma2_reset() must be used
  * before calling xz_dec_lzma2_run().
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 381559e4a1fa..26877b290de6 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -126,6 +126,7 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 	 * If this is too slow, it can be optimised to examine the maple
 	 * tree gaps.
 	 */
+	rcu_read_lock();
 	for_each_vma(vmi, vma) {
 		unsigned long gap;
 
@@ -146,6 +147,7 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 next:
 		prev = vma;
 	}
+	rcu_read_unlock();
 
 	if (!sz_range(&second_gap) || !sz_range(&first_gap))
 		return -EINVAL;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4d9c1277e5e4..cedc93028894 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -214,6 +214,8 @@ static bool get_huge_zero_page(void)
 		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
 		return false;
 	}
+	/* Ensure zero folio won't have large_rmappable flag set. */
+	folio_clear_large_rmappable(zero_folio);
 	preempt_disable();
 	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
 		preempt_enable();
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 92a2e8dcb796..423d20453b90 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3919,100 +3919,124 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
-static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
+static long demote_free_hugetlb_folios(struct hstate *src, struct hstate *dst,
+				       struct list_head *src_list)
 {
-	int i, nid = folio_nid(folio);
-	struct hstate *target_hstate;
-	struct page *subpage;
-	struct folio *inner_folio;
-	int rc = 0;
-
-	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
+	long rc;
+	struct folio *folio, *next;
+	LIST_HEAD(dst_list);
+	LIST_HEAD(ret_list);
 
-	remove_hugetlb_folio(h, folio, false);
-	spin_unlock_irq(&hugetlb_lock);
-
-	/*
-	 * If vmemmap already existed for folio, the remove routine above would
-	 * have cleared the hugetlb folio flag.  Hence the folio is technically
-	 * no longer a hugetlb folio.  hugetlb_vmemmap_restore_folio can only be
-	 * passed hugetlb folios and will BUG otherwise.
-	 */
-	if (folio_test_hugetlb(folio)) {
-		rc = hugetlb_vmemmap_restore_folio(h, folio);
-		if (rc) {
-			/* Allocation of vmemmmap failed, we can not demote folio */
-			spin_lock_irq(&hugetlb_lock);
-			add_hugetlb_folio(h, folio, false);
-			return rc;
-		}
-	}
-
-	/*
-	 * Use destroy_compound_hugetlb_folio_for_demote for all huge page
-	 * sizes as it will not ref count folios.
-	 */
-	destroy_compound_hugetlb_folio_for_demote(folio, huge_page_order(h));
+	rc = hugetlb_vmemmap_restore_folios(src, src_list, &ret_list);
+	list_splice_init(&ret_list, src_list);
 
 	/*
 	 * Taking target hstate mutex synchronizes with set_max_huge_pages.
 	 * Without the mutex, pages added to target hstate could be marked
 	 * as surplus.
 	 *
-	 * Note that we already hold h->resize_lock.  To prevent deadlock,
+	 * Note that we already hold src->resize_lock.  To prevent deadlock,
 	 * use the convention of always taking larger size hstate mutex first.
 	 */
-	mutex_lock(&target_hstate->resize_lock);
-	for (i = 0; i < pages_per_huge_page(h);
-				i += pages_per_huge_page(target_hstate)) {
-		subpage = folio_page(folio, i);
-		inner_folio = page_folio(subpage);
-		if (hstate_is_gigantic(target_hstate))
-			prep_compound_gigantic_folio_for_demote(inner_folio,
-							target_hstate->order);
-		else
-			prep_compound_page(subpage, target_hstate->order);
-		folio_change_private(inner_folio, NULL);
-		prep_new_hugetlb_folio(target_hstate, inner_folio, nid);
-		free_huge_folio(inner_folio);
+	mutex_lock(&dst->resize_lock);
+
+	list_for_each_entry_safe(folio, next, src_list, lru) {
+		int i;
+
+		if (folio_test_hugetlb_vmemmap_optimized(folio))
+			continue;
+
+		list_del(&folio->lru);
+		/*
+		 * Use destroy_compound_hugetlb_folio_for_demote for all huge page
+		 * sizes as it will not ref count folios.
+		 */
+		destroy_compound_hugetlb_folio_for_demote(folio, huge_page_order(src));
+
+		for (i = 0; i < pages_per_huge_page(src); i += pages_per_huge_page(dst)) {
+			struct page *page = folio_page(folio, i);
+
+			if (hstate_is_gigantic(dst))
+				prep_compound_gigantic_folio_for_demote(page_folio(page),
+									dst->order);
+			else
+				prep_compound_page(page, dst->order);
+			set_page_private(page, 0);
+
+			init_new_hugetlb_folio(dst, page_folio(page));
+			list_add(&page->lru, &dst_list);
+		}
 	}
-	mutex_unlock(&target_hstate->resize_lock);
 
-	spin_lock_irq(&hugetlb_lock);
+	prep_and_add_allocated_folios(dst, &dst_list);
 
-	/*
-	 * Not absolutely necessary, but for consistency update max_huge_pages
-	 * based on pool changes for the demoted page.
-	 */
-	h->max_huge_pages--;
-	target_hstate->max_huge_pages +=
-		pages_per_huge_page(h) / pages_per_huge_page(target_hstate);
+	mutex_unlock(&dst->resize_lock);
 
 	return rc;
 }
 
-static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
+static long demote_pool_huge_page(struct hstate *src, nodemask_t *nodes_allowed,
+				  unsigned long nr_to_demote)
 	__must_hold(&hugetlb_lock)
 {
 	int nr_nodes, node;
-	struct folio *folio;
+	struct hstate *dst;
+	long rc = 0;
+	long nr_demoted = 0;
 
 	lockdep_assert_held(&hugetlb_lock);
 
 	/* We should never get here if no demote order */
-	if (!h->demote_order) {
+	if (!src->demote_order) {
 		pr_warn("HugeTLB: NULL demote order passed to demote_pool_huge_page.\n");
 		return -EINVAL;		/* internal error */
 	}
+	dst = size_to_hstate(PAGE_SIZE << src->demote_order);
 
-	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
-		list_for_each_entry(folio, &h->hugepage_freelists[node], lru) {
+	for_each_node_mask_to_free(src, nr_nodes, node, nodes_allowed) {
+		LIST_HEAD(list);
+		struct folio *folio, *next;
+
+		list_for_each_entry_safe(folio, next, &src->hugepage_freelists[node], lru) {
 			if (folio_test_hwpoison(folio))
 				continue;
-			return demote_free_hugetlb_folio(h, folio);
+
+			remove_hugetlb_folio(src, folio, false);
+			list_add(&folio->lru, &list);
+
+			if (++nr_demoted == nr_to_demote)
+				break;
 		}
+
+		spin_unlock_irq(&hugetlb_lock);
+
+		rc = demote_free_hugetlb_folios(src, dst, &list);
+
+		spin_lock_irq(&hugetlb_lock);
+
+		list_for_each_entry_safe(folio, next, &list, lru) {
+			list_del(&folio->lru);
+			add_hugetlb_folio(src, folio, false);
+
+			nr_demoted--;
+		}
+
+		if (rc < 0 || nr_demoted == nr_to_demote)
+			break;
 	}
 
+	/*
+	 * Not absolutely necessary, but for consistency update max_huge_pages
+	 * based on pool changes for the demoted page.
+	 */
+	src->max_huge_pages -= nr_demoted;
+	dst->max_huge_pages += nr_demoted << (huge_page_order(src) - huge_page_order(dst));
+
+	if (rc < 0)
+		return rc;
+
+	if (nr_demoted)
+		return nr_demoted;
 	/*
 	 * Only way to get here is if all pages on free lists are poisoned.
 	 * Return -EBUSY so that caller will not retry.
@@ -4247,6 +4271,8 @@ static ssize_t demote_store(struct kobject *kobj,
 	spin_lock_irq(&hugetlb_lock);
 
 	while (nr_demote) {
+		long rc;
+
 		/*
 		 * Check for available pages to demote each time thorough the
 		 * loop as demote_pool_huge_page will drop hugetlb_lock.
@@ -4259,11 +4285,13 @@ static ssize_t demote_store(struct kobject *kobj,
 		if (!nr_available)
 			break;
 
-		err = demote_pool_huge_page(h, n_mask);
-		if (err)
+		rc = demote_pool_huge_page(h, n_mask, nr_demote);
+		if (rc < 0) {
+			err = rc;
 			break;
+		}
 
-		nr_demote--;
+		nr_demote -= rc;
 	}
 
 	spin_unlock_irq(&hugetlb_lock);
@@ -6047,7 +6075,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	 * When the original hugepage is shared one, it does not have
 	 * anon_vma prepared.
 	 */
-	ret = vmf_anon_prepare(vmf);
+	ret = __vmf_anon_prepare(vmf);
 	if (unlikely(ret))
 		goto out_release_all;
 
@@ -6246,7 +6274,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		}
 
 		if (!(vma->vm_flags & VM_MAYSHARE)) {
-			ret = vmf_anon_prepare(vmf);
+			ret = __vmf_anon_prepare(vmf);
 			if (unlikely(ret))
 				goto out;
 		}
@@ -6378,6 +6406,14 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	folio_unlock(folio);
 out:
 	hugetlb_vma_unlock_read(vma);
+
+	/*
+	 * We must check to release the per-VMA lock. __vmf_anon_prepare() is
+	 * the only way ret can be set to VM_FAULT_RETRY.
+	 */
+	if (unlikely(ret & VM_FAULT_RETRY))
+		vma_end_read(vma);
+
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	return ret;
 
@@ -6599,6 +6635,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	hugetlb_vma_unlock_read(vma);
+
+	/*
+	 * We must check to release the per-VMA lock. __vmf_anon_prepare() in
+	 * hugetlb_wp() is the only way ret can be set to VM_FAULT_RETRY.
+	 */
+	if (unlikely(ret & VM_FAULT_RETRY))
+		vma_end_read(vma);
+
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
diff --git a/mm/internal.h b/mm/internal.h
index cc2c5e07fad3..6ef5eecabfc4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -293,7 +293,16 @@ static inline void wake_throttle_isolated(pg_data_t *pgdat)
 		wake_up(wqh);
 }
 
-vm_fault_t vmf_anon_prepare(struct vm_fault *vmf);
+vm_fault_t __vmf_anon_prepare(struct vm_fault *vmf);
+static inline vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
+{
+	vm_fault_t ret = __vmf_anon_prepare(vmf);
+
+	if (unlikely(ret & VM_FAULT_RETRY))
+		vma_end_read(vmf->vma);
+	return ret;
+}
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
 bool __folio_end_writeback(struct folio *folio);
diff --git a/mm/memory.c b/mm/memory.c
index 7a898b85788d..cfc4df9fe995 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3226,7 +3226,7 @@ static inline vm_fault_t vmf_can_call_fault(const struct vm_fault *vmf)
 }
 
 /**
- * vmf_anon_prepare - Prepare to handle an anonymous fault.
+ * __vmf_anon_prepare - Prepare to handle an anonymous fault.
  * @vmf: The vm_fault descriptor passed from the fault handler.
  *
  * When preparing to insert an anonymous page into a VMA from a
@@ -3240,7 +3240,7 @@ static inline vm_fault_t vmf_can_call_fault(const struct vm_fault *vmf)
  * Return: 0 if fault handling can proceed.  Any other value should be
  * returned to the caller.
  */
-vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
+vm_fault_t __vmf_anon_prepare(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
@@ -3248,10 +3248,8 @@ vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
 	if (likely(vma->anon_vma))
 		return 0;
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-		if (!mmap_read_trylock(vma->vm_mm)) {
-			vma_end_read(vma);
+		if (!mmap_read_trylock(vma->vm_mm))
 			return VM_FAULT_RETRY;
-		}
 	}
 	if (__anon_vma_prepare(vma))
 		ret = VM_FAULT_OOM;
diff --git a/mm/migrate.c b/mm/migrate.c
index 9dabeb90f772..817019be8936 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1129,7 +1129,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	int rc = -EAGAIN;
 	int old_page_state = 0;
 	struct anon_vma *anon_vma = NULL;
-	bool is_lru = !__folio_test_movable(src);
+	bool is_lru = data_race(!__folio_test_movable(src));
 	bool locked = false;
 	bool dst_locked = false;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 83b4682ec85c..47bd6f65f441 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3127,8 +3127,12 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 		flags |= MAP_LOCKED;
 
 	file = get_file(vma->vm_file);
+	ret = security_mmap_file(vma->vm_file, prot, flags);
+	if (ret)
+		goto out_fput;
 	ret = do_mmap(vma->vm_file, start, size,
 			prot, flags, 0, pgoff, &populate, NULL);
+out_fput:
 	fput(file);
 out:
 	mmap_write_unlock(mm);
diff --git a/mm/util.c b/mm/util.c
index fe723241b66f..37a5d75f8adf 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -451,7 +451,7 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 	if (gap + pad > gap)
 		gap += pad;
 
-	if (gap < MIN_GAP)
+	if (gap < MIN_GAP && MIN_GAP < MAX_GAP)
 		gap = MIN_GAP;
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3c74d171085d..bfa773730f3b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -107,8 +107,7 @@ void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
 	 * where a timeout + cancel does indicate an actual failure.
 	 */
 	if (status && status != HCI_ERROR_UNKNOWN_CONN_ID)
-		mgmt_connect_failed(hdev, &conn->dst, conn->type,
-				    conn->dst_type, status);
+		mgmt_connect_failed(hdev, conn, status);
 
 	/* The connection attempt was doing scan for new RPA, and is
 	 * in scan phase. If params are not associated with any other
@@ -1251,8 +1250,7 @@ void hci_conn_failed(struct hci_conn *conn, u8 status)
 		hci_le_conn_failed(conn, status);
 		break;
 	case ACL_LINK:
-		mgmt_connect_failed(hdev, &conn->dst, conn->type,
-				    conn->dst_type, status);
+		mgmt_connect_failed(hdev, conn, status);
 		break;
 	}
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index f4a54dbc07f1..86fee9d6c142 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5331,7 +5331,10 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 		if (!e)
 			return 0;
 
-		return hci_remote_name_cancel_sync(hdev, &e->data.bdaddr);
+		/* Ignore cancel errors since it should interfere with stopping
+		 * of the discovery.
+		 */
+		hci_remote_name_cancel_sync(hdev, &e->data.bdaddr);
 	}
 
 	return 0;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ba28907afb3f..c383eb44d516 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9734,13 +9734,18 @@ void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	mgmt_pending_remove(cmd);
 }
 
-void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-			 u8 addr_type, u8 status)
+void mgmt_connect_failed(struct hci_dev *hdev, struct hci_conn *conn, u8 status)
 {
 	struct mgmt_ev_connect_failed ev;
 
-	bacpy(&ev.addr.bdaddr, bdaddr);
-	ev.addr.type = link_to_bdaddr(link_type, addr_type);
+	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
+		mgmt_device_disconnected(hdev, &conn->dst, conn->type,
+					 conn->dst_type, status, true);
+		return;
+	}
+
+	bacpy(&ev.addr.bdaddr, &conn->dst);
+	ev.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 	ev.status = mgmt_status(status);
 
 	mgmt_event(MGMT_EV_CONNECT_FAILED, hdev, &ev, sizeof(ev), NULL);
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 46d3ec3aa44b..217049fa496e 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1471,8 +1471,10 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 		/* remove device reference, if this is our bound device */
 		if (bo->bound && bo->ifindex == dev->ifindex) {
 #if IS_ENABLED(CONFIG_PROC_FS)
-			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read)
+			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read) {
 				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
+				bo->bcm_proc_read = NULL;
+			}
 #endif
 			bo->bound   = 0;
 			bo->ifindex = 0;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4be73de5033c..319f47df3330 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1179,10 +1179,10 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		break;
 	case -ENETDOWN:
 		/* In this case we should get a netdev_event(), all active
-		 * sessions will be cleared by
-		 * j1939_cancel_all_active_sessions(). So handle this as an
-		 * error, but let j1939_cancel_all_active_sessions() do the
-		 * cleanup including propagation of the error to user space.
+		 * sessions will be cleared by j1939_cancel_active_session().
+		 * So handle this as an error, but let
+		 * j1939_cancel_active_session() do the cleanup including
+		 * propagation of the error to user space.
 		 */
 		break;
 	case -EOVERFLOW:
diff --git a/net/core/filter.c b/net/core/filter.c
index 55b1d9de2334..61da5512cd4d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6258,20 +6258,25 @@ BPF_CALL_5(bpf_skb_check_mtu, struct sk_buff *, skb,
 	int ret = BPF_MTU_CHK_RET_FRAG_NEEDED;
 	struct net_device *dev = skb->dev;
 	int skb_len, dev_len;
-	int mtu;
+	int mtu = 0;
 
-	if (unlikely(flags & ~(BPF_MTU_CHK_SEGS)))
-		return -EINVAL;
+	if (unlikely(flags & ~(BPF_MTU_CHK_SEGS))) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	if (unlikely(flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len)))
-		return -EINVAL;
+	if (unlikely(flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len))) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	dev = __dev_via_ifindex(dev, ifindex);
-	if (unlikely(!dev))
-		return -ENODEV;
+	if (unlikely(!dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	mtu = READ_ONCE(dev->mtu);
-
 	dev_len = mtu + dev->hard_header_len;
 
 	/* If set use *mtu_len as input, L3 as iph->tot_len (like fib_lookup) */
@@ -6289,15 +6294,12 @@ BPF_CALL_5(bpf_skb_check_mtu, struct sk_buff *, skb,
 	 */
 	if (skb_is_gso(skb)) {
 		ret = BPF_MTU_CHK_RET_SUCCESS;
-
 		if (flags & BPF_MTU_CHK_SEGS &&
 		    !skb_gso_validate_network_len(skb, mtu))
 			ret = BPF_MTU_CHK_RET_SEGS_TOOBIG;
 	}
 out:
-	/* BPF verifier guarantees valid pointer */
 	*mtu_len = mtu;
-
 	return ret;
 }
 
@@ -6307,19 +6309,21 @@ BPF_CALL_5(bpf_xdp_check_mtu, struct xdp_buff *, xdp,
 	struct net_device *dev = xdp->rxq->dev;
 	int xdp_len = xdp->data_end - xdp->data;
 	int ret = BPF_MTU_CHK_RET_SUCCESS;
-	int mtu, dev_len;
+	int mtu = 0, dev_len;
 
 	/* XDP variant doesn't support multi-buffer segment check (yet) */
-	if (unlikely(flags))
-		return -EINVAL;
+	if (unlikely(flags)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	dev = __dev_via_ifindex(dev, ifindex);
-	if (unlikely(!dev))
-		return -ENODEV;
+	if (unlikely(!dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	mtu = READ_ONCE(dev->mtu);
-
-	/* Add L2-header as dev MTU is L3 size */
 	dev_len = mtu + dev->hard_header_len;
 
 	/* Use *mtu_len as input, L3 as iph->tot_len (like fib_lookup) */
@@ -6329,10 +6333,8 @@ BPF_CALL_5(bpf_xdp_check_mtu, struct xdp_buff *, xdp,
 	xdp_len += len_diff; /* minus result pass check */
 	if (xdp_len > dev_len)
 		ret = BPF_MTU_CHK_RET_FRAG_NEEDED;
-
-	/* BPF verifier guarantees valid pointer */
+out:
 	*mtu_len = mtu;
-
 	return ret;
 }
 
@@ -6342,7 +6344,8 @@ static const struct bpf_func_proto bpf_skb_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_INT,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
@@ -6353,7 +6356,8 @@ static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_INT,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
@@ -8568,13 +8572,16 @@ static bool bpf_skb_is_valid_access(int off, int size, enum bpf_access_type type
 		if (off + size > offsetofend(struct __sk_buff, cb[4]))
 			return false;
 		break;
+	case bpf_ctx_range(struct __sk_buff, data):
+	case bpf_ctx_range(struct __sk_buff, data_meta):
+	case bpf_ctx_range(struct __sk_buff, data_end):
+		if (info->is_ldsx || size != size_default)
+			return false;
+		break;
 	case bpf_ctx_range_till(struct __sk_buff, remote_ip6[0], remote_ip6[3]):
 	case bpf_ctx_range_till(struct __sk_buff, local_ip6[0], local_ip6[3]):
 	case bpf_ctx_range_till(struct __sk_buff, remote_ip4, remote_ip4):
 	case bpf_ctx_range_till(struct __sk_buff, local_ip4, local_ip4):
-	case bpf_ctx_range(struct __sk_buff, data):
-	case bpf_ctx_range(struct __sk_buff, data_meta):
-	case bpf_ctx_range(struct __sk_buff, data_end):
 		if (size != size_default)
 			return false;
 		break;
@@ -9018,6 +9025,14 @@ static bool xdp_is_valid_access(int off, int size,
 			}
 		}
 		return false;
+	} else {
+		switch (off) {
+		case offsetof(struct xdp_md, data_meta):
+		case offsetof(struct xdp_md, data):
+		case offsetof(struct xdp_md, data_end):
+			if (info->is_ldsx)
+				return false;
+		}
 	}
 
 	switch (off) {
@@ -9343,12 +9358,12 @@ static bool flow_dissector_is_valid_access(int off, int size,
 
 	switch (off) {
 	case bpf_ctx_range(struct __sk_buff, data):
-		if (size != size_default)
+		if (info->is_ldsx || size != size_default)
 			return false;
 		info->reg_type = PTR_TO_PACKET;
 		return true;
 	case bpf_ctx_range(struct __sk_buff, data_end):
-		if (size != size_default)
+		if (info->is_ldsx || size != size_default)
 			return false;
 		info->reg_type = PTR_TO_PACKET_END;
 		return true;
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index d3dbb92153f2..724b6856fcc3 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1183,6 +1183,7 @@ static void sock_hash_free(struct bpf_map *map)
 			sock_put(elem->sk);
 			sock_hash_free_elem(htab, elem);
 		}
+		cond_resched();
 	}
 
 	/* wait for psock readers accessing its map link */
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index af6cf64a00e0..464f683e016d 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -67,7 +67,16 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 		skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
 	skb_reset_mac_len(skb);
 
-	hsr_forward_skb(skb, port);
+	/* Only the frames received over the interlink port will assign a
+	 * sequence number and require synchronisation vs other sender.
+	 */
+	if (port->type == HSR_PT_INTERLINK) {
+		spin_lock_bh(&hsr->seqnr_lock);
+		hsr_forward_skb(skb, port);
+		spin_unlock_bh(&hsr->seqnr_lock);
+	} else {
+		hsr_forward_skb(skb, port);
+	}
 
 finish_consume:
 	return RX_HANDLER_CONSUMED;
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index ab6d0d98dbc3..336518e623b2 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -224,57 +224,59 @@ int sysctl_icmp_msgs_per_sec __read_mostly = 1000;
 int sysctl_icmp_msgs_burst __read_mostly = 50;
 
 static struct {
-	spinlock_t	lock;
-	u32		credit;
+	atomic_t	credit;
 	u32		stamp;
-} icmp_global = {
-	.lock		= __SPIN_LOCK_UNLOCKED(icmp_global.lock),
-};
+} icmp_global;
 
 /**
  * icmp_global_allow - Are we allowed to send one more ICMP message ?
  *
  * Uses a token bucket to limit our ICMP messages to ~sysctl_icmp_msgs_per_sec.
  * Returns false if we reached the limit and can not send another packet.
- * Note: called with BH disabled
+ * Works in tandem with icmp_global_consume().
  */
 bool icmp_global_allow(void)
 {
-	u32 credit, delta, incr = 0, now = (u32)jiffies;
-	bool rc = false;
+	u32 delta, now, oldstamp;
+	int incr, new, old;
 
-	/* Check if token bucket is empty and cannot be refilled
-	 * without taking the spinlock. The READ_ONCE() are paired
-	 * with the following WRITE_ONCE() in this same function.
+	/* Note: many cpus could find this condition true.
+	 * Then later icmp_global_consume() could consume more credits,
+	 * this is an acceptable race.
 	 */
-	if (!READ_ONCE(icmp_global.credit)) {
-		delta = min_t(u32, now - READ_ONCE(icmp_global.stamp), HZ);
-		if (delta < HZ / 50)
-			return false;
-	}
+	if (atomic_read(&icmp_global.credit) > 0)
+		return true;
 
-	spin_lock(&icmp_global.lock);
-	delta = min_t(u32, now - icmp_global.stamp, HZ);
-	if (delta >= HZ / 50) {
-		incr = READ_ONCE(sysctl_icmp_msgs_per_sec) * delta / HZ;
-		if (incr)
-			WRITE_ONCE(icmp_global.stamp, now);
-	}
-	credit = min_t(u32, icmp_global.credit + incr,
-		       READ_ONCE(sysctl_icmp_msgs_burst));
-	if (credit) {
-		/* We want to use a credit of one in average, but need to randomize
-		 * it for security reasons.
-		 */
-		credit = max_t(int, credit - get_random_u32_below(3), 0);
-		rc = true;
+	now = jiffies;
+	oldstamp = READ_ONCE(icmp_global.stamp);
+	delta = min_t(u32, now - oldstamp, HZ);
+	if (delta < HZ / 50)
+		return false;
+
+	incr = READ_ONCE(sysctl_icmp_msgs_per_sec) * delta / HZ;
+	if (!incr)
+		return false;
+
+	if (cmpxchg(&icmp_global.stamp, oldstamp, now) == oldstamp) {
+		old = atomic_read(&icmp_global.credit);
+		do {
+			new = min(old + incr, READ_ONCE(sysctl_icmp_msgs_burst));
+		} while (!atomic_try_cmpxchg(&icmp_global.credit, &old, new));
 	}
-	WRITE_ONCE(icmp_global.credit, credit);
-	spin_unlock(&icmp_global.lock);
-	return rc;
+	return true;
 }
 EXPORT_SYMBOL(icmp_global_allow);
 
+void icmp_global_consume(void)
+{
+	int credits = get_random_u32_below(3);
+
+	/* Note: this might make icmp_global.credit negative. */
+	if (credits)
+		atomic_sub(credits, &icmp_global.credit);
+}
+EXPORT_SYMBOL(icmp_global_consume);
+
 static bool icmpv4_mask_allow(struct net *net, int type, int code)
 {
 	if (type > NR_ICMP_TYPES)
@@ -291,14 +293,16 @@ static bool icmpv4_mask_allow(struct net *net, int type, int code)
 	return false;
 }
 
-static bool icmpv4_global_allow(struct net *net, int type, int code)
+static bool icmpv4_global_allow(struct net *net, int type, int code,
+				bool *apply_ratelimit)
 {
 	if (icmpv4_mask_allow(net, type, code))
 		return true;
 
-	if (icmp_global_allow())
+	if (icmp_global_allow()) {
+		*apply_ratelimit = true;
 		return true;
-
+	}
 	__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITGLOBAL);
 	return false;
 }
@@ -308,15 +312,16 @@ static bool icmpv4_global_allow(struct net *net, int type, int code)
  */
 
 static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
-			       struct flowi4 *fl4, int type, int code)
+			       struct flowi4 *fl4, int type, int code,
+			       bool apply_ratelimit)
 {
 	struct dst_entry *dst = &rt->dst;
 	struct inet_peer *peer;
 	bool rc = true;
 	int vif;
 
-	if (icmpv4_mask_allow(net, type, code))
-		goto out;
+	if (!apply_ratelimit)
+		return true;
 
 	/* No rate limit on loopback */
 	if (dst->dev && (dst->dev->flags&IFF_LOOPBACK))
@@ -331,6 +336,8 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 out:
 	if (!rc)
 		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
+	else
+		icmp_global_consume();
 	return rc;
 }
 
@@ -402,6 +409,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	struct ipcm_cookie ipc;
 	struct rtable *rt = skb_rtable(skb);
 	struct net *net = dev_net(rt->dst.dev);
+	bool apply_ratelimit = false;
 	struct flowi4 fl4;
 	struct sock *sk;
 	struct inet_sock *inet;
@@ -413,11 +421,11 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	if (ip_options_echo(net, &icmp_param->replyopts.opt.opt, skb))
 		return;
 
-	/* Needed by both icmp_global_allow and icmp_xmit_lock */
+	/* Needed by both icmpv4_global_allow and icmp_xmit_lock */
 	local_bh_disable();
 
-	/* global icmp_msgs_per_sec */
-	if (!icmpv4_global_allow(net, type, code))
+	/* is global icmp_msgs_per_sec exhausted ? */
+	if (!icmpv4_global_allow(net, type, code, &apply_ratelimit))
 		goto out_bh_enable;
 
 	sk = icmp_xmit_lock(net);
@@ -450,7 +458,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	rt = ip_route_output_key(net, &fl4);
 	if (IS_ERR(rt))
 		goto out_unlock;
-	if (icmpv4_xrlim_allow(net, rt, &fl4, type, code))
+	if (icmpv4_xrlim_allow(net, rt, &fl4, type, code, apply_ratelimit))
 		icmp_push_reply(sk, icmp_param, &fl4, &ipc, &rt);
 	ip_rt_put(rt);
 out_unlock:
@@ -596,6 +604,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	int room;
 	struct icmp_bxm icmp_param;
 	struct rtable *rt = skb_rtable(skb_in);
+	bool apply_ratelimit = false;
 	struct ipcm_cookie ipc;
 	struct flowi4 fl4;
 	__be32 saddr;
@@ -677,7 +686,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 		}
 	}
 
-	/* Needed by both icmp_global_allow and icmp_xmit_lock */
+	/* Needed by both icmpv4_global_allow and icmp_xmit_lock */
 	local_bh_disable();
 
 	/* Check global sysctl_icmp_msgs_per_sec ratelimit, unless
@@ -685,7 +694,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	 * loopback, then peer ratelimit still work (in icmpv4_xrlim_allow)
 	 */
 	if (!(skb_in->dev && (skb_in->dev->flags&IFF_LOOPBACK)) &&
-	      !icmpv4_global_allow(net, type, code))
+	      !icmpv4_global_allow(net, type, code, &apply_ratelimit))
 		goto out_bh_enable;
 
 	sk = icmp_xmit_lock(net);
@@ -744,7 +753,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 		goto out_unlock;
 
 	/* peer icmp_ratelimit */
-	if (!icmpv4_xrlim_allow(net, rt, &fl4, type, code))
+	if (!icmpv4_xrlim_allow(net, rt, &fl4, type, code, apply_ratelimit))
 		goto ende;
 
 	/* RFC says return as much as we can without exceeding 576 bytes. */
diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index 08d4b7132d4c..1c9c686d9522 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -323,6 +323,7 @@ config IPV6_RPL_LWTUNNEL
 	bool "IPv6: RPL Source Routing Header support"
 	depends on IPV6
 	select LWTUNNEL
+	select DST_CACHE
 	help
 	  Support for RFC6554 RPL Source Routing Header using the lightweight
 	  tunnels mechanism.
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 7b31674644ef..46f70e4a8351 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -175,14 +175,16 @@ static bool icmpv6_mask_allow(struct net *net, int type)
 	return false;
 }
 
-static bool icmpv6_global_allow(struct net *net, int type)
+static bool icmpv6_global_allow(struct net *net, int type,
+				bool *apply_ratelimit)
 {
 	if (icmpv6_mask_allow(net, type))
 		return true;
 
-	if (icmp_global_allow())
+	if (icmp_global_allow()) {
+		*apply_ratelimit = true;
 		return true;
-
+	}
 	__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITGLOBAL);
 	return false;
 }
@@ -191,13 +193,13 @@ static bool icmpv6_global_allow(struct net *net, int type)
  * Check the ICMP output rate limit
  */
 static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
-			       struct flowi6 *fl6)
+			       struct flowi6 *fl6, bool apply_ratelimit)
 {
 	struct net *net = sock_net(sk);
 	struct dst_entry *dst;
 	bool res = false;
 
-	if (icmpv6_mask_allow(net, type))
+	if (!apply_ratelimit)
 		return true;
 
 	/*
@@ -228,6 +230,8 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 	if (!res)
 		__ICMP6_INC_STATS(net, ip6_dst_idev(dst),
 				  ICMP6_MIB_RATELIMITHOST);
+	else
+		icmp_global_consume();
 	dst_release(dst);
 	return res;
 }
@@ -452,6 +456,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	struct net *net;
 	struct ipv6_pinfo *np;
 	const struct in6_addr *saddr = NULL;
+	bool apply_ratelimit = false;
 	struct dst_entry *dst;
 	struct icmp6hdr tmp_hdr;
 	struct flowi6 fl6;
@@ -533,11 +538,12 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 		return;
 	}
 
-	/* Needed by both icmp_global_allow and icmpv6_xmit_lock */
+	/* Needed by both icmpv6_global_allow and icmpv6_xmit_lock */
 	local_bh_disable();
 
 	/* Check global sysctl_icmp_msgs_per_sec ratelimit */
-	if (!(skb->dev->flags & IFF_LOOPBACK) && !icmpv6_global_allow(net, type))
+	if (!(skb->dev->flags & IFF_LOOPBACK) &&
+	    !icmpv6_global_allow(net, type, &apply_ratelimit))
 		goto out_bh_enable;
 
 	mip6_addr_swap(skb, parm);
@@ -575,7 +581,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 
 	np = inet6_sk(sk);
 
-	if (!icmpv6_xrlim_allow(sk, type, &fl6))
+	if (!icmpv6_xrlim_allow(sk, type, &fl6, apply_ratelimit))
 		goto out;
 
 	tmp_hdr.icmp6_type = type;
@@ -717,6 +723,7 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 	struct ipv6_pinfo *np;
 	const struct in6_addr *saddr = NULL;
 	struct icmp6hdr *icmph = icmp6_hdr(skb);
+	bool apply_ratelimit = false;
 	struct icmp6hdr tmp_hdr;
 	struct flowi6 fl6;
 	struct icmpv6_msg msg;
@@ -781,8 +788,9 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 		goto out;
 
 	/* Check the ratelimit */
-	if ((!(skb->dev->flags & IFF_LOOPBACK) && !icmpv6_global_allow(net, ICMPV6_ECHO_REPLY)) ||
-	    !icmpv6_xrlim_allow(sk, ICMPV6_ECHO_REPLY, &fl6))
+	if ((!(skb->dev->flags & IFF_LOOPBACK) &&
+	    !icmpv6_global_allow(net, ICMPV6_ECHO_REPLY, &apply_ratelimit)) ||
+	    !icmpv6_xrlim_allow(sk, ICMPV6_ECHO_REPLY, &fl6, apply_ratelimit))
 		goto out_dst_release;
 
 	idev = __in6_dev_get(skb->dev);
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index dedee264b8f6..b9457473c176 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -223,33 +223,23 @@ void nf_reject_ip6_tcphdr_put(struct sk_buff *nskb,
 			      const struct tcphdr *oth, unsigned int otcplen)
 {
 	struct tcphdr *tcph;
-	int needs_ack;
 
 	skb_reset_transport_header(nskb);
-	tcph = skb_put(nskb, sizeof(struct tcphdr));
+	tcph = skb_put_zero(nskb, sizeof(struct tcphdr));
 	/* Truncate to length (no data) */
 	tcph->doff = sizeof(struct tcphdr)/4;
 	tcph->source = oth->dest;
 	tcph->dest = oth->source;
 
 	if (oth->ack) {
-		needs_ack = 0;
 		tcph->seq = oth->ack_seq;
-		tcph->ack_seq = 0;
 	} else {
-		needs_ack = 1;
 		tcph->ack_seq = htonl(ntohl(oth->seq) + oth->syn + oth->fin +
 				      otcplen - (oth->doff<<2));
-		tcph->seq = 0;
+		tcph->ack = 1;
 	}
 
-	/* Reset flags */
-	((u_int8_t *)tcph)[13] = 0;
 	tcph->rst = 1;
-	tcph->ack = needs_ack;
-	tcph->window = 0;
-	tcph->urg_ptr = 0;
-	tcph->check = 0;
 
 	/* Adjust TCP checksum */
 	tcph->check = csum_ipv6_magic(&ipv6_hdr(nskb)->saddr,
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a9644a8edb96..1febd95822c9 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -175,7 +175,7 @@ static void rt6_uncached_list_flush_dev(struct net_device *dev)
 			struct net_device *rt_dev = rt->dst.dev;
 			bool handled = false;
 
-			if (rt_idev->dev == dev) {
+			if (rt_idev && rt_idev->dev == dev) {
 				rt->rt6i_idev = in6_dev_get(blackhole_netdev);
 				in6_dev_put(rt_idev);
 				handled = true;
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 2c83b7586422..db3c19a42e1c 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -263,10 +263,8 @@ static int rpl_input(struct sk_buff *skb)
 	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
 
 	err = rpl_do_srh(skb, rlwt);
-	if (unlikely(err)) {
-		kfree_skb(skb);
-		return err;
-	}
+	if (unlikely(err))
+		goto drop;
 
 	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
@@ -286,9 +284,13 @@ static int rpl_input(struct sk_buff *skb)
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 	if (unlikely(err))
-		return err;
+		goto drop;
 
 	return dst_input(skb);
+
+drop:
+	kfree_skb(skb);
+	return err;
 }
 
 static int nla_put_rpl_srh(struct sk_buff *skb, int attrtype,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b935bb5d8ed1..3e3814076006 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -462,6 +462,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 {
 	struct ieee80211_local *local = sdata->local;
 	unsigned long flags;
+	struct sk_buff_head freeq;
 	struct sk_buff *skb, *tmp;
 	u32 hw_reconf_flags = 0;
 	int i, flushed;
@@ -641,18 +642,32 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		skb_queue_purge(&sdata->status_queue);
 	}
 
+	/*
+	 * Since ieee80211_free_txskb() may issue __dev_queue_xmit()
+	 * which should be called with interrupts enabled, reclamation
+	 * is done in two phases:
+	 */
+	__skb_queue_head_init(&freeq);
+
+	/* unlink from local queues... */
 	spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
 	for (i = 0; i < IEEE80211_MAX_QUEUES; i++) {
 		skb_queue_walk_safe(&local->pending[i], skb, tmp) {
 			struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 			if (info->control.vif == &sdata->vif) {
 				__skb_unlink(skb, &local->pending[i]);
-				ieee80211_free_txskb(&local->hw, skb);
+				__skb_queue_tail(&freeq, skb);
 			}
 		}
 	}
 	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
 
+	/* ... and perform actual reclamation with interrupts enabled. */
+	skb_queue_walk_safe(&freeq, skb, tmp) {
+		__skb_unlink(skb, &freeq);
+		ieee80211_free_txskb(&local->hw, skb);
+	}
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		ieee80211_txq_remove_vlan(local, sdata);
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ad2ce9c92ba8..1faf4d7c115f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4317,7 +4317,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	    ((assoc_data->wmm && !elems->wmm_param) ||
 	     (link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT &&
 	      (!elems->ht_cap_elem || !elems->ht_operation)) ||
-	     (link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT &&
+	     (is_5ghz && link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT &&
 	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
 		const struct cfg80211_bss_ies *ies;
 		struct ieee802_11_elems *bss_elems;
@@ -4365,19 +4365,22 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 			sdata_info(sdata,
 				   "AP bug: HT operation missing from AssocResp\n");
 		}
-		if (!elems->vht_cap_elem && bss_elems->vht_cap_elem &&
-		    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT) {
-			elems->vht_cap_elem = bss_elems->vht_cap_elem;
-			sdata_info(sdata,
-				   "AP bug: VHT capa missing from AssocResp\n");
-		}
-		if (!elems->vht_operation && bss_elems->vht_operation &&
-		    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT) {
-			elems->vht_operation = bss_elems->vht_operation;
-			sdata_info(sdata,
-				   "AP bug: VHT operation missing from AssocResp\n");
-		}
 
+		if (is_5ghz) {
+			if (!elems->vht_cap_elem && bss_elems->vht_cap_elem &&
+			    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT) {
+				elems->vht_cap_elem = bss_elems->vht_cap_elem;
+				sdata_info(sdata,
+					   "AP bug: VHT capa missing from AssocResp\n");
+			}
+
+			if (!elems->vht_operation && bss_elems->vht_operation &&
+			    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT) {
+				elems->vht_operation = bss_elems->vht_operation;
+				sdata_info(sdata,
+					   "AP bug: VHT operation missing from AssocResp\n");
+			}
+		}
 		kfree(bss_elems);
 	}
 
@@ -7121,6 +7124,7 @@ static int ieee80211_do_assoc(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	assoc_data->tries++;
+	assoc_data->comeback = false;
 	if (assoc_data->tries > IEEE80211_ASSOC_MAX_TRIES) {
 		sdata_info(sdata, "association with %pM timed out\n",
 			   assoc_data->ap_addr);
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 65e1e9e971fd..5810d938edc4 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -964,6 +964,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	}
 
 	IEEE80211_SKB_CB(skb)->flags = flags;
+	IEEE80211_SKB_CB(skb)->control.flags |= IEEE80211_TX_CTRL_DONT_USE_RATE_MASK;
 
 	skb->dev = sdata->dev;
 
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 4dc1def69548..3dc9752188d5 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -890,7 +890,7 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
 	if (ieee80211_is_tx_data(skb))
 		rate_control_apply_mask(sdata, sta, sband, dest, max_rates);
 
-	if (!(info->control.flags & IEEE80211_TX_CTRL_SCAN_TX))
+	if (!(info->control.flags & IEEE80211_TX_CTRL_DONT_USE_RATE_MASK))
 		mask = sdata->rc_rateidx_mask[info->band];
 
 	if (dest[0].idx < 0)
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index b5f2df61c7f6..1c5d99975ad0 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -649,7 +649,7 @@ static void ieee80211_send_scan_probe_req(struct ieee80211_sub_if_data *sdata,
 				cpu_to_le16(IEEE80211_SN_TO_SEQ(sn));
 		}
 		IEEE80211_SKB_CB(skb)->flags |= tx_flags;
-		IEEE80211_SKB_CB(skb)->control.flags |= IEEE80211_TX_CTRL_SCAN_TX;
+		IEEE80211_SKB_CB(skb)->control.flags |= IEEE80211_TX_CTRL_DONT_USE_RATE_MASK;
 		ieee80211_tx_skb_tid_band(sdata, skb, 7, channel->band);
 	}
 }
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index bca7b341dd77..a9ee86982259 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -699,7 +699,7 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 	txrc.skb = tx->skb;
 	txrc.reported_rate.idx = -1;
 
-	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_SCAN_TX)) {
+	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_DONT_USE_RATE_MASK)) {
 		txrc.rate_idx_mask = ~0;
 	} else {
 		txrc.rate_idx_mask = tx->sdata->rc_rateidx_mask[info->band];
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 4cbf71d0786b..c55cf5bc36b2 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -382,7 +382,7 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 #define ctnetlink_dump_secctx(a, b) (0)
 #endif
 
-#ifdef CONFIG_NF_CONNTRACK_LABELS
+#ifdef CONFIG_NF_CONNTRACK_EVENTS
 static inline int ctnetlink_label_size(const struct nf_conn *ct)
 {
 	struct nf_conn_labels *labels = nf_ct_labels_find(ct);
@@ -391,6 +391,7 @@ static inline int ctnetlink_label_size(const struct nf_conn *ct)
 		return 0;
 	return nla_total_size(sizeof(labels->bits));
 }
+#endif
 
 static int
 ctnetlink_dump_labels(struct sk_buff *skb, const struct nf_conn *ct)
@@ -411,10 +412,6 @@ ctnetlink_dump_labels(struct sk_buff *skb, const struct nf_conn *ct)
 
 	return 0;
 }
-#else
-#define ctnetlink_dump_labels(a, b) (0)
-#define ctnetlink_label_size(a)	(0)
-#endif
 
 #define master_tuple(ct) &(ct->master->tuplehash[IP_CT_DIR_ORIGINAL].tuple)
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 41d7faeb101c..465cc43c75e3 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1795,7 +1795,7 @@ static int nft_dump_basechain_hook(struct sk_buff *skb, int family,
 		if (!hook_list)
 			hook_list = &basechain->hook_list;
 
-		list_for_each_entry(hook, hook_list, list) {
+		list_for_each_entry_rcu(hook, hook_list, list) {
 			if (!first)
 				first = hook;
 
@@ -4544,7 +4544,7 @@ int nf_msecs_to_jiffies64(const struct nlattr *nla, u64 *result)
 		return -ERANGE;
 
 	ms *= NSEC_PER_MSEC;
-	*result = nsecs_to_jiffies64(ms);
+	*result = nsecs_to_jiffies64(ms) ? : !!ms;
 	return 0;
 }
 
@@ -6631,7 +6631,7 @@ static int nft_setelem_catchall_insert(const struct net *net,
 		}
 	}
 
-	catchall = kmalloc(sizeof(*catchall), GFP_KERNEL);
+	catchall = kmalloc(sizeof(*catchall), GFP_KERNEL_ACCOUNT);
 	if (!catchall)
 		return -ENOMEM;
 
@@ -6867,17 +6867,23 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			return err;
 	} else if (set->flags & NFT_SET_TIMEOUT &&
 		   !(flags & NFT_SET_ELEM_INTERVAL_END)) {
-		timeout = READ_ONCE(set->timeout);
+		timeout = set->timeout;
 	}
 
 	expiration = 0;
 	if (nla[NFTA_SET_ELEM_EXPIRATION] != NULL) {
 		if (!(set->flags & NFT_SET_TIMEOUT))
 			return -EINVAL;
+		if (timeout == 0)
+			return -EOPNOTSUPP;
+
 		err = nf_msecs_to_jiffies64(nla[NFTA_SET_ELEM_EXPIRATION],
 					    &expiration);
 		if (err)
 			return err;
+
+		if (expiration > timeout)
+			return -ERANGE;
 	}
 
 	if (nla[NFTA_SET_ELEM_EXPR]) {
@@ -6968,7 +6974,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		if (err < 0)
 			goto err_parse_key_end;
 
-		if (timeout != READ_ONCE(set->timeout)) {
+		if (timeout != set->timeout) {
 			err = nft_set_ext_add(&tmpl, NFT_SET_EXT_TIMEOUT);
 			if (err < 0)
 				goto err_parse_key_end;
@@ -9131,7 +9137,7 @@ static void nf_tables_flowtable_destroy(struct nft_flowtable *flowtable)
 		flowtable->data.type->setup(&flowtable->data, hook->ops.dev,
 					    FLOW_BLOCK_UNBIND);
 		list_del_rcu(&hook->list);
-		kfree(hook);
+		kfree_rcu(hook, rcu);
 	}
 	kfree(flowtable->name);
 	module_put(flowtable->data.type->owner);
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index d3d11dede545..85450f601142 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -536,7 +536,7 @@ nft_match_large_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	struct xt_match *m = expr->ops->data;
 	int ret;
 
-	priv->info = kmalloc(XT_ALIGN(m->matchsize), GFP_KERNEL);
+	priv->info = kmalloc(XT_ALIGN(m->matchsize), GFP_KERNEL_ACCOUNT);
 	if (!priv->info)
 		return -ENOMEM;
 
@@ -810,7 +810,7 @@ nft_match_select_ops(const struct nft_ctx *ctx,
 		goto err;
 	}
 
-	ops = kzalloc(sizeof(struct nft_expr_ops), GFP_KERNEL);
+	ops = kzalloc(sizeof(struct nft_expr_ops), GFP_KERNEL_ACCOUNT);
 	if (!ops) {
 		err = -ENOMEM;
 		goto err;
@@ -900,7 +900,7 @@ nft_target_select_ops(const struct nft_ctx *ctx,
 		goto err;
 	}
 
-	ops = kzalloc(sizeof(struct nft_expr_ops), GFP_KERNEL);
+	ops = kzalloc(sizeof(struct nft_expr_ops), GFP_KERNEL_ACCOUNT);
 	if (!ops) {
 		err = -ENOMEM;
 		goto err;
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index b4ada3ab2167..489a9b34f1ec 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -56,7 +56,7 @@ static struct nft_elem_priv *nft_dynset_new(struct nft_set *set,
 	if (!atomic_add_unless(&set->nelems, 1, set->size))
 		return NULL;
 
-	timeout = priv->timeout ? : set->timeout;
+	timeout = priv->timeout ? : READ_ONCE(set->timeout);
 	elem_priv = nft_set_elem_init(set, &priv->tmpl,
 				      &regs->data[priv->sreg_key], NULL,
 				      &regs->data[priv->sreg_data],
@@ -95,7 +95,7 @@ void nft_dynset_eval(const struct nft_expr *expr,
 			     expr, regs, &ext)) {
 		if (priv->op == NFT_DYNSET_OP_UPDATE &&
 		    nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION)) {
-			timeout = priv->timeout ? : set->timeout;
+			timeout = priv->timeout ? : READ_ONCE(set->timeout);
 			*nft_set_ext_expiration(ext) = get_jiffies_64() + timeout;
 		}
 
@@ -313,7 +313,7 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 		nft_dynset_ext_add_expr(priv);
 
 	if (set->flags & NFT_SET_TIMEOUT) {
-		if (timeout || set->timeout) {
+		if (timeout || READ_ONCE(set->timeout)) {
 			nft_set_ext_add(&priv->tmpl, NFT_SET_EXT_TIMEOUT);
 			nft_set_ext_add(&priv->tmpl, NFT_SET_EXT_EXPIRATION);
 		}
diff --git a/net/netfilter/nft_log.c b/net/netfilter/nft_log.c
index 5defe6e4fd98..e35588137995 100644
--- a/net/netfilter/nft_log.c
+++ b/net/netfilter/nft_log.c
@@ -163,7 +163,7 @@ static int nft_log_init(const struct nft_ctx *ctx,
 
 	nla = tb[NFTA_LOG_PREFIX];
 	if (nla != NULL) {
-		priv->prefix = kmalloc(nla_len(nla) + 1, GFP_KERNEL);
+		priv->prefix = kmalloc(nla_len(nla) + 1, GFP_KERNEL_ACCOUNT);
 		if (priv->prefix == NULL)
 			return -ENOMEM;
 		nla_strscpy(priv->prefix, nla, nla_len(nla) + 1);
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 9139ce38ea7b..f23faf565b68 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -954,7 +954,7 @@ static int nft_secmark_obj_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_SECMARK_CTX] == NULL)
 		return -EINVAL;
 
-	priv->ctx = nla_strdup(tb[NFTA_SECMARK_CTX], GFP_KERNEL);
+	priv->ctx = nla_strdup(tb[NFTA_SECMARK_CTX], GFP_KERNEL_ACCOUNT);
 	if (!priv->ctx)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_numgen.c b/net/netfilter/nft_numgen.c
index 7d29db7c2ac0..bd058babfc82 100644
--- a/net/netfilter/nft_numgen.c
+++ b/net/netfilter/nft_numgen.c
@@ -66,7 +66,7 @@ static int nft_ng_inc_init(const struct nft_ctx *ctx,
 	if (priv->offset + priv->modulus - 1 < priv->offset)
 		return -EOVERFLOW;
 
-	priv->counter = kmalloc(sizeof(*priv->counter), GFP_KERNEL);
+	priv->counter = kmalloc(sizeof(*priv->counter), GFP_KERNEL_ACCOUNT);
 	if (!priv->counter)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index eb4c4a4ac7ac..7be342b495f5 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -663,7 +663,7 @@ static int pipapo_realloc_mt(struct nft_pipapo_field *f,
 	    check_add_overflow(rules, extra, &rules_alloc))
 		return -EOVERFLOW;
 
-	new_mt = kvmalloc_array(rules_alloc, sizeof(*new_mt), GFP_KERNEL);
+	new_mt = kvmalloc_array(rules_alloc, sizeof(*new_mt), GFP_KERNEL_ACCOUNT);
 	if (!new_mt)
 		return -ENOMEM;
 
@@ -936,7 +936,7 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 		return;
 	}
 
-	new_lt = kvzalloc(lt_size + NFT_PIPAPO_ALIGN_HEADROOM, GFP_KERNEL);
+	new_lt = kvzalloc(lt_size + NFT_PIPAPO_ALIGN_HEADROOM, GFP_KERNEL_ACCOUNT);
 	if (!new_lt)
 		return;
 
@@ -1212,7 +1212,7 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 		scratch = kzalloc_node(struct_size(scratch, map,
 						   bsize_max * 2) +
 				       NFT_PIPAPO_ALIGN_HEADROOM,
-				       GFP_KERNEL, cpu_to_node(i));
+				       GFP_KERNEL_ACCOUNT, cpu_to_node(i));
 		if (!scratch) {
 			/* On failure, there's no need to undo previous
 			 * allocations: this means that some scratch maps have
@@ -1427,7 +1427,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	struct nft_pipapo_match *new;
 	int i;
 
-	new = kmalloc(struct_size(new, f, old->field_count), GFP_KERNEL);
+	new = kmalloc(struct_size(new, f, old->field_count), GFP_KERNEL_ACCOUNT);
 	if (!new)
 		return NULL;
 
@@ -1457,7 +1457,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		new_lt = kvzalloc(src->groups * NFT_PIPAPO_BUCKETS(src->bb) *
 				  src->bsize * sizeof(*dst->lt) +
 				  NFT_PIPAPO_ALIGN_HEADROOM,
-				  GFP_KERNEL);
+				  GFP_KERNEL_ACCOUNT);
 		if (!new_lt)
 			goto out_lt;
 
@@ -1470,7 +1470,8 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 
 		if (src->rules > 0) {
 			dst->mt = kvmalloc_array(src->rules_alloc,
-						 sizeof(*src->mt), GFP_KERNEL);
+						 sizeof(*src->mt),
+						 GFP_KERNEL_ACCOUNT);
 			if (!dst->mt)
 				goto out_mt;
 
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 60a76e6e348e..5c6ed68cc6e0 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -509,13 +509,14 @@ static int nft_tunnel_obj_init(const struct nft_ctx *ctx,
 			return err;
 	}
 
-	md = metadata_dst_alloc(priv->opts.len, METADATA_IP_TUNNEL, GFP_KERNEL);
+	md = metadata_dst_alloc(priv->opts.len, METADATA_IP_TUNNEL,
+				GFP_KERNEL_ACCOUNT);
 	if (!md)
 		return -ENOMEM;
 
 	memcpy(&md->u.tun_info, &info, sizeof(info));
 #ifdef CONFIG_DST_CACHE
-	err = dst_cache_init(&md->u.tun_info.dst_cache, GFP_KERNEL);
+	err = dst_cache_init(&md->u.tun_info.dst_cache, GFP_KERNEL_ACCOUNT);
 	if (err < 0) {
 		metadata_dst_free(md);
 		return err;
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 41ece61eb57a..00c51cf693f3 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -884,7 +884,7 @@ static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 
 	mutex_lock(&qrtr_node_lock);
 	list_for_each_entry(node, &qrtr_all_nodes, item) {
-		skbn = skb_clone(skb, GFP_KERNEL);
+		skbn = pskb_copy(skb, GFP_KERNEL);
 		if (!skbn)
 			break;
 		skb_set_owner_w(skbn, skb->sk);
diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
index 593846d25214..114fef65f92e 100644
--- a/net/tipc/bcast.c
+++ b/net/tipc/bcast.c
@@ -320,8 +320,8 @@ static int tipc_mcast_send_sync(struct net *net, struct sk_buff *skb,
 {
 	struct tipc_msg *hdr, *_hdr;
 	struct sk_buff_head tmpq;
+	u16 cong_link_cnt = 0;
 	struct sk_buff *_skb;
-	u16 cong_link_cnt;
 	int rc = 0;
 
 	/* Is a cluster supporting with new capabilities ? */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 967bc4935b4e..e3bf14e489c5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9658,7 +9658,8 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
 		return ERR_PTR(-ENOMEM);
 
 	if (n_ssids)
-		request->ssids = (void *)&request->channels[n_channels];
+		request->ssids = (void *)request +
+			struct_size(request, channels, n_channels);
 	request->n_ssids = n_ssids;
 	if (ie_len) {
 		if (n_ssids)
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 64c779788a64..44c93b9a9751 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3452,8 +3452,8 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 		n_channels = ieee80211_get_num_supported_channels(wiphy);
 	}
 
-	creq = kzalloc(sizeof(*creq) + sizeof(struct cfg80211_ssid) +
-		       n_channels * sizeof(void *),
+	creq = kzalloc(struct_size(creq, channels, n_channels) +
+		       sizeof(struct cfg80211_ssid),
 		       GFP_ATOMIC);
 	if (!creq)
 		return -ENOMEM;
@@ -3461,7 +3461,7 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 	creq->wiphy = wiphy;
 	creq->wdev = dev->ieee80211_ptr;
 	/* SSIDs come after channels */
-	creq->ssids = (void *)&creq->channels[n_channels];
+	creq->ssids = (void *)creq + struct_size(creq, channels, n_channels);
 	creq->n_channels = n_channels;
 	creq->n_ssids = 1;
 	creq->scan_start = jiffies;
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 1cfe673bc52f..4b80af0edbe9 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -115,7 +115,8 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 		n_channels = i;
 	}
 	request->n_channels = n_channels;
-	request->ssids = (void *)&request->channels[n_channels];
+	request->ssids = (void *)request +
+		struct_size(request, channels, n_channels);
 	request->n_ssids = 1;
 
 	memcpy(request->ssids[0].ssid, wdev->conn->params.ssid,
diff --git a/net/wireless/util.c b/net/wireless/util.c
index af6ec719567f..f1193aca79ba 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -998,10 +998,10 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 	 * Diffserv Service Classes no update is needed:
 	 * - Standard: DF
 	 * - Low Priority Data: CS1
-	 * - Multimedia Streaming: AF31, AF32, AF33
 	 * - Multimedia Conferencing: AF41, AF42, AF43
 	 * - Network Control Traffic: CS7
 	 * - Real-Time Interactive: CS4
+	 * - Signaling: CS5
 	 */
 	switch (dscp >> 2) {
 	case 10:
@@ -1026,9 +1026,11 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 		/* Broadcasting video: CS3 */
 		ret = 4;
 		break;
-	case 40:
-		/* Signaling: CS5 */
-		ret = 5;
+	case 26:
+	case 28:
+	case 30:
+		/* Multimedia Streaming: AF31, AF32, AF33 */
+		ret = 4;
 		break;
 	case 44:
 		/* Voice Admit: VA */
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index c0e0204b9630..b0f24ebd05f0 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -623,20 +623,31 @@ static u32 xp_alloc_reused(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u3
 	return nb_entries;
 }
 
-u32 xp_alloc_batch(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u32 max)
+static u32 xp_alloc_slow(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
+			 u32 max)
 {
-	u32 nb_entries1 = 0, nb_entries2;
+	int i;
 
-	if (unlikely(pool->dev && dma_dev_need_sync(pool->dev))) {
+	for (i = 0; i < max; i++) {
 		struct xdp_buff *buff;
 
-		/* Slow path */
 		buff = xp_alloc(pool);
-		if (buff)
-			*xdp = buff;
-		return !!buff;
+		if (unlikely(!buff))
+			return i;
+		*xdp = buff;
+		xdp++;
 	}
 
+	return max;
+}
+
+u32 xp_alloc_batch(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u32 max)
+{
+	u32 nb_entries1 = 0, nb_entries2;
+
+	if (unlikely(pool->dev && dma_dev_need_sync(pool->dev)))
+		return xp_alloc_slow(pool, xdp, max);
+
 	if (unlikely(pool->free_list_cnt)) {
 		nb_entries1 = xp_alloc_reused(pool, xdp, max);
 		if (nb_entries1 == max)
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 3e003dd6bea0..dca56aa360ff 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -169,6 +169,10 @@ BPF_EXTRA_CFLAGS += -I$(srctree)/arch/mips/include/asm/mach-generic
 endif
 endif
 
+ifeq ($(ARCH), x86)
+BPF_EXTRA_CFLAGS += -fcf-protection
+endif
+
 TPROGS_CFLAGS += -Wall -O2
 TPROGS_CFLAGS += -Wmissing-prototypes
 TPROGS_CFLAGS += -Wstrict-prototypes
@@ -405,7 +409,7 @@ $(obj)/%.o: $(src)/%.c
 		-Wno-gnu-variable-sized-type-not-at-end \
 		-Wno-address-of-packed-member -Wno-tautological-compare \
 		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
-		-fno-asynchronous-unwind-tables -fcf-protection \
+		-fno-asynchronous-unwind-tables \
 		-I$(srctree)/samples/bpf/ -include asm_goto_workaround.h \
 		-O2 -emit-llvm -Xclang -disable-llvm-passes -c $< -o - | \
 		$(OPT) -O2 -mtriple=bpf-pc-linux | $(LLVM_DIS) | \
diff --git a/security/apparmor/include/net.h b/security/apparmor/include/net.h
index 67bf888c3bd6..c42ed8a73f1c 100644
--- a/security/apparmor/include/net.h
+++ b/security/apparmor/include/net.h
@@ -51,10 +51,9 @@ struct aa_sk_ctx {
 	struct aa_label *peer;
 };
 
-#define SK_CTX(X) ((X)->sk_security)
 static inline struct aa_sk_ctx *aa_sock(const struct sock *sk)
 {
-	return sk->sk_security;
+	return sk->sk_security + apparmor_blob_sizes.lbs_sock;
 }
 
 #define DEFINE_AUDIT_NET(NAME, OP, SK, F, T, P)				  \
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 4373b914acf2..b8366fca98d2 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1057,27 +1057,12 @@ static int apparmor_userns_create(const struct cred *cred)
 	return error;
 }
 
-static int apparmor_sk_alloc_security(struct sock *sk, int family, gfp_t flags)
-{
-	struct aa_sk_ctx *ctx;
-
-	ctx = kzalloc(sizeof(*ctx), flags);
-	if (!ctx)
-		return -ENOMEM;
-
-	sk->sk_security = ctx;
-
-	return 0;
-}
-
 static void apparmor_sk_free_security(struct sock *sk)
 {
 	struct aa_sk_ctx *ctx = aa_sock(sk);
 
-	sk->sk_security = NULL;
 	aa_put_label(ctx->label);
 	aa_put_label(ctx->peer);
-	kfree(ctx);
 }
 
 /**
@@ -1432,6 +1417,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
 	.lbs_cred = sizeof(struct aa_label *),
 	.lbs_file = sizeof(struct aa_file_ctx),
 	.lbs_task = sizeof(struct aa_task_ctx),
+	.lbs_sock = sizeof(struct aa_sk_ctx),
 };
 
 static const struct lsm_id apparmor_lsmid = {
@@ -1477,7 +1463,6 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
 	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
 
-	LSM_HOOK_INIT(sk_alloc_security, apparmor_sk_alloc_security),
 	LSM_HOOK_INIT(sk_free_security, apparmor_sk_free_security),
 	LSM_HOOK_INIT(sk_clone_security, apparmor_sk_clone_security),
 
diff --git a/security/apparmor/net.c b/security/apparmor/net.c
index 87e934b2b548..77413a519117 100644
--- a/security/apparmor/net.c
+++ b/security/apparmor/net.c
@@ -151,7 +151,7 @@ static int aa_label_sk_perm(const struct cred *subj_cred,
 			    const char *op, u32 request,
 			    struct sock *sk)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 	int error = 0;
 
 	AA_BUG(!label);
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 57b9ffd53c98..3663aec7bcbd 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -31,7 +31,6 @@ static int __init bpf_lsm_init(void)
 
 struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
 	.lbs_inode = sizeof(struct bpf_storage_blob),
-	.lbs_task = sizeof(struct bpf_storage_blob),
 };
 
 DEFINE_LSM(bpf) = {
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c51e24d24d1e..3c323ca213d4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -223,7 +223,7 @@ static inline void ima_inode_set_iint(const struct inode *inode,
 
 struct ima_iint_cache *ima_iint_find(struct inode *inode);
 struct ima_iint_cache *ima_inode_get(struct inode *inode);
-void ima_inode_free(struct inode *inode);
+void ima_inode_free_rcu(void *inode_security);
 void __init ima_iintcache_init(void);
 
 extern const int read_idmap[];
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index e23412a2c56b..00b249101f98 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -109,22 +109,18 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
 }
 
 /**
- * ima_inode_free - Called on inode free
- * @inode: Pointer to the inode
+ * ima_inode_free_rcu - Called to free an inode via a RCU callback
+ * @inode_security: The inode->i_security pointer
  *
- * Free the iint associated with an inode.
+ * Free the IMA data associated with an inode.
  */
-void ima_inode_free(struct inode *inode)
+void ima_inode_free_rcu(void *inode_security)
 {
-	struct ima_iint_cache *iint;
-
-	if (!IS_IMA(inode))
-		return;
-
-	iint = ima_iint_find(inode);
-	ima_inode_set_iint(inode, NULL);
+	struct ima_iint_cache **iint_p = inode_security + ima_blob_sizes.lbs_inode;
 
-	ima_iint_free(iint);
+	/* *iint_p should be NULL if !IS_IMA(inode) */
+	if (*iint_p)
+		ima_iint_free(*iint_p);
 }
 
 static void ima_iint_init_once(void *foo)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f04f43af651c..5b3394864b21 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1193,7 +1193,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
 	LSM_HOOK_INIT(kernel_module_request, ima_kernel_module_request),
 #endif
-	LSM_HOOK_INIT(inode_free_security, ima_inode_free),
+	LSM_HOOK_INIT(inode_free_security_rcu, ima_inode_free_rcu),
 };
 
 static const struct lsm_id ima_lsmid = {
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7877a64cc6b8..0804f76a67be 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1207,13 +1207,16 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 
 /* Inode hooks */
 
-static void hook_inode_free_security(struct inode *const inode)
+static void hook_inode_free_security_rcu(void *inode_security)
 {
+	struct landlock_inode_security *inode_sec;
+
 	/*
 	 * All inodes must already have been untied from their object by
 	 * release_inode() or hook_sb_delete().
 	 */
-	WARN_ON_ONCE(landlock_inode(inode)->object);
+	inode_sec = inode_security + landlock_blob_sizes.lbs_inode;
+	WARN_ON_ONCE(inode_sec->object);
 }
 
 /* Super-block hooks */
@@ -1637,7 +1640,7 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
-	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
+	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
 
 	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
 	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
diff --git a/security/security.c b/security/security.c
index 8cee5b6c6e6d..43166e341526 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,7 @@
 #include <linux/msg.h>
 #include <linux/overflow.h>
 #include <net/flow.h>
+#include <net/sock.h>
 
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
@@ -227,6 +228,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
 	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
 	lsm_set_blob_size(&needed->lbs_xattr_count,
@@ -401,6 +403,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
 	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
+	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
@@ -1596,9 +1599,8 @@ int security_inode_alloc(struct inode *inode)
 
 static void inode_free_by_rcu(struct rcu_head *head)
 {
-	/*
-	 * The rcu head is at the start of the inode blob
-	 */
+	/* The rcu head is at the start of the inode blob */
+	call_void_hook(inode_free_security_rcu, head);
 	kmem_cache_free(lsm_inode_cache, head);
 }
 
@@ -1606,23 +1608,24 @@ static void inode_free_by_rcu(struct rcu_head *head)
  * security_inode_free() - Free an inode's LSM blob
  * @inode: the inode
  *
- * Deallocate the inode security structure and set @inode->i_security to NULL.
+ * Release any LSM resources associated with @inode, although due to the
+ * inode's RCU protections it is possible that the resources will not be
+ * fully released until after the current RCU grace period has elapsed.
+ *
+ * It is important for LSMs to note that despite being present in a call to
+ * security_inode_free(), @inode may still be referenced in a VFS path walk
+ * and calls to security_inode_permission() may be made during, or after,
+ * a call to security_inode_free().  For this reason the inode->i_security
+ * field is released via a call_rcu() callback and any LSMs which need to
+ * retain inode state for use in security_inode_permission() should only
+ * release that state in the inode_free_security_rcu() LSM hook callback.
  */
 void security_inode_free(struct inode *inode)
 {
 	call_void_hook(inode_free_security, inode);
-	/*
-	 * The inode may still be referenced in a path walk and
-	 * a call to security_inode_permission() can be made
-	 * after inode_free_security() is called. Ideally, the VFS
-	 * wouldn't do this, but fixing that is a much harder
-	 * job. For now, simply free the i_security via RCU, and
-	 * leave the current inode->i_security pointer intact.
-	 * The inode will be freed after the RCU grace period too.
-	 */
-	if (inode->i_security)
-		call_rcu((struct rcu_head *)inode->i_security,
-			 inode_free_by_rcu);
+	if (!inode->i_security)
+		return;
+	call_rcu((struct rcu_head *)inode->i_security, inode_free_by_rcu);
 }
 
 /**
@@ -4673,6 +4676,28 @@ int security_socket_getpeersec_dgram(struct socket *sock,
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
+/**
+ * lsm_sock_alloc - allocate a composite sock blob
+ * @sock: the sock that needs a blob
+ * @priority: allocation mode
+ *
+ * Allocate the sock blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_sock_alloc(struct sock *sock, gfp_t priority)
+{
+	if (blob_sizes.lbs_sock == 0) {
+		sock->sk_security = NULL;
+		return 0;
+	}
+
+	sock->sk_security = kzalloc(blob_sizes.lbs_sock, priority);
+	if (sock->sk_security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
 /**
  * security_sk_alloc() - Allocate and initialize a sock's LSM blob
  * @sk: sock
@@ -4686,7 +4711,14 @@ EXPORT_SYMBOL(security_socket_getpeersec_dgram);
  */
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
 {
-	return call_int_hook(sk_alloc_security, sk, family, priority);
+	int rc = lsm_sock_alloc(sk, priority);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(sk_alloc_security, sk, family, priority);
+	if (unlikely(rc))
+		security_sk_free(sk);
+	return rc;
 }
 
 /**
@@ -4698,6 +4730,8 @@ int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
 void security_sk_free(struct sock *sk)
 {
 	call_void_hook(sk_free_security, sk);
+	kfree(sk->sk_security);
+	sk->sk_security = NULL;
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 400eca4ad0fb..c11303d662d8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4594,7 +4594,7 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
 
 static int sock_has_perm(struct sock *sk, u32 perms)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 
@@ -4662,7 +4662,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 	isec->initialized = LABEL_INITIALIZED;
 
 	if (sock->sk) {
-		sksec = sock->sk->sk_security;
+		sksec = selinux_sock(sock->sk);
 		sksec->sclass = sclass;
 		sksec->sid = sid;
 		/* Allows detection of the first association on this socket */
@@ -4678,8 +4678,8 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 static int selinux_socket_socketpair(struct socket *socka,
 				     struct socket *sockb)
 {
-	struct sk_security_struct *sksec_a = socka->sk->sk_security;
-	struct sk_security_struct *sksec_b = sockb->sk->sk_security;
+	struct sk_security_struct *sksec_a = selinux_sock(socka->sk);
+	struct sk_security_struct *sksec_b = selinux_sock(sockb->sk);
 
 	sksec_a->peer_sid = sksec_b->sid;
 	sksec_b->peer_sid = sksec_a->sid;
@@ -4694,7 +4694,7 @@ static int selinux_socket_socketpair(struct socket *socka,
 static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
 	int err;
 
@@ -4834,7 +4834,7 @@ static int selinux_socket_connect_helper(struct socket *sock,
 					 struct sockaddr *address, int addrlen)
 {
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 
 	err = sock_has_perm(sk, SOCKET__CONNECT);
@@ -5012,9 +5012,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 					      struct sock *other,
 					      struct sock *newsk)
 {
-	struct sk_security_struct *sksec_sock = sock->sk_security;
-	struct sk_security_struct *sksec_other = other->sk_security;
-	struct sk_security_struct *sksec_new = newsk->sk_security;
+	struct sk_security_struct *sksec_sock = selinux_sock(sock);
+	struct sk_security_struct *sksec_other = selinux_sock(other);
+	struct sk_security_struct *sksec_new = selinux_sock(newsk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	int err;
@@ -5043,8 +5043,8 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
-	struct sk_security_struct *ssec = sock->sk->sk_security;
-	struct sk_security_struct *osec = other->sk->sk_security;
+	struct sk_security_struct *ssec = selinux_sock(sock->sk);
+	struct sk_security_struct *osec = selinux_sock(other->sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 
@@ -5081,7 +5081,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 				       u16 family)
 {
 	int err = 0;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
@@ -5110,7 +5110,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	int err, peerlbl_active, secmark_active;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family = sk->sk_family;
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
@@ -5178,7 +5178,7 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 	int err = 0;
 	char *scontext = NULL;
 	u32 scontext_len;
-	struct sk_security_struct *sksec = sock->sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sock->sk);
 	u32 peer_sid = SECSID_NULL;
 
 	if (sksec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
@@ -5238,34 +5238,27 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock,
 
 static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
 {
-	struct sk_security_struct *sksec;
-
-	sksec = kzalloc(sizeof(*sksec), priority);
-	if (!sksec)
-		return -ENOMEM;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	sksec->peer_sid = SECINITSID_UNLABELED;
 	sksec->sid = SECINITSID_UNLABELED;
 	sksec->sclass = SECCLASS_SOCKET;
 	selinux_netlbl_sk_security_reset(sksec);
-	sk->sk_security = sksec;
 
 	return 0;
 }
 
 static void selinux_sk_free_security(struct sock *sk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
-	sk->sk_security = NULL;
 	selinux_netlbl_sk_security_free(sksec);
-	kfree(sksec);
 }
 
 static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->sid = sksec->sid;
 	newsksec->peer_sid = sksec->peer_sid;
@@ -5279,7 +5272,7 @@ static void selinux_sk_getsecid(const struct sock *sk, u32 *secid)
 	if (!sk)
 		*secid = SECINITSID_ANY_SOCKET;
 	else {
-		const struct sk_security_struct *sksec = sk->sk_security;
+		const struct sk_security_struct *sksec = selinux_sock(sk);
 
 		*secid = sksec->sid;
 	}
@@ -5289,7 +5282,7 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 {
 	struct inode_security_struct *isec =
 		inode_security_novalidate(SOCK_INODE(parent));
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
 	    sk->sk_family == PF_UNIX)
@@ -5306,7 +5299,7 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
 {
 	struct sock *sk = asoc->base.sk;
 	u16 family = sk->sk_family;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	int err;
@@ -5361,7 +5354,7 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
 static int selinux_sctp_assoc_request(struct sctp_association *asoc,
 				      struct sk_buff *skb)
 {
-	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
 	u32 conn_sid;
 	int err;
 
@@ -5394,7 +5387,7 @@ static int selinux_sctp_assoc_request(struct sctp_association *asoc,
 static int selinux_sctp_assoc_established(struct sctp_association *asoc,
 					  struct sk_buff *skb)
 {
-	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
 
 	if (!selinux_policycap_extsockclass())
 		return 0;
@@ -5493,8 +5486,8 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk,
 				  struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	/* If policy does not support SECCLASS_SCTP_SOCKET then call
 	 * the non-sctp clone version.
@@ -5510,8 +5503,8 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
 
 static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 {
-	struct sk_security_struct *ssksec = ssk->sk_security;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *ssksec = selinux_sock(ssk);
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	ssksec->sclass = sksec->sclass;
 	ssksec->sid = sksec->sid;
@@ -5526,7 +5519,7 @@ static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 				     struct request_sock *req)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 	u16 family = req->rsk_ops->family;
 	u32 connsid;
@@ -5547,7 +5540,7 @@ static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 static void selinux_inet_csk_clone(struct sock *newsk,
 				   const struct request_sock *req)
 {
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->sid = req->secid;
 	newsksec->peer_sid = req->peer_secid;
@@ -5564,7 +5557,7 @@ static void selinux_inet_csk_clone(struct sock *newsk,
 static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 {
 	u16 family = sk->sk_family;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	/* handle mapped IPv4 packets arriving via IPv6 sockets */
 	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
@@ -5639,7 +5632,7 @@ static int selinux_tun_dev_attach_queue(void *security)
 static int selinux_tun_dev_attach(struct sock *sk, void *security)
 {
 	struct tun_security_struct *tunsec = security;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	/* we don't currently perform any NetLabel based labeling here and it
 	 * isn't clear that we would want to do so anyway; while we could apply
@@ -5762,7 +5755,7 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 			return NF_ACCEPT;
 
 		/* standard practice, label using the parent socket */
-		sksec = sk->sk_security;
+		sksec = selinux_sock(sk);
 		sid = sksec->sid;
 	} else
 		sid = SECINITSID_KERNEL;
@@ -5785,7 +5778,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	sk = skb_to_full_sk(skb);
 	if (sk == NULL)
 		return NF_ACCEPT;
-	sksec = sk->sk_security;
+	sksec = selinux_sock(sk);
 
 	ad_net_init_from_iif(&ad, &net, state->out->ifindex, state->pf);
 	if (selinux_parse_skb(skb, &ad, NULL, 0, &proto))
@@ -5874,7 +5867,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 		u32 skb_sid;
 		struct sk_security_struct *sksec;
 
-		sksec = sk->sk_security;
+		sksec = selinux_sock(sk);
 		if (selinux_skb_peerlbl_sid(skb, family, &skb_sid))
 			return NF_DROP;
 		/* At this point, if the returned skb peerlbl is SECSID_NULL
@@ -5903,7 +5896,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 	} else {
 		/* Locally generated packet, fetch the security label from the
 		 * associated socket. */
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 		peer_sid = sksec->sid;
 		secmark_perm = PACKET__SEND;
 	}
@@ -5946,7 +5939,7 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 	unsigned int data_len = skb->len;
 	unsigned char *data = skb->data;
 	struct nlmsghdr *nlh;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 sclass = sksec->sclass;
 	u32 perm;
 
@@ -7004,6 +6997,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
+	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
 };
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index dea1d6f3ed2d..b074099acbaf 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -195,4 +195,9 @@ selinux_superblock(const struct super_block *superblock)
 	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
 }
 
+static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
+{
+	return sock->sk_security + selinux_blob_sizes.lbs_sock;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 55885634e880..fbe5f8c29f81 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -17,6 +17,7 @@
 #include <linux/gfp.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/lsm_hooks.h>
 #include <net/sock.h>
 #include <net/netlabel.h>
 #include <net/ip.h>
@@ -68,7 +69,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
 static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (sksec->nlbl_secattr != NULL)
@@ -100,7 +101,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
 							const struct sock *sk,
 							u32 sid)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr = sksec->nlbl_secattr;
 
 	if (secattr == NULL)
@@ -240,7 +241,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	 * being labeled by it's parent socket, if it is just exit */
 	sk = skb_to_full_sk(skb);
 	if (sk != NULL) {
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 
 		if (sksec->nlbl_state != NLBL_REQSKB)
 			return 0;
@@ -277,7 +278,7 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
 {
 	int rc;
 	struct netlbl_lsm_secattr secattr;
-	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
 	struct sockaddr_in addr4;
 	struct sockaddr_in6 addr6;
 
@@ -356,7 +357,7 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
  */
 void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (family == PF_INET)
 		sksec->nlbl_state = NLBL_LABELED;
@@ -374,8 +375,8 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
  */
 void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->nlbl_state = sksec->nlbl_state;
 }
@@ -393,7 +394,7 @@ void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
 int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (family != PF_INET && family != PF_INET6)
@@ -510,7 +511,7 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
 {
 	int rc = 0;
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr secattr;
 
 	if (selinux_netlbl_option(level, optname) &&
@@ -548,7 +549,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 						struct sockaddr *addr)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	/* connected sockets are allowed to disconnect when the address family
@@ -587,7 +588,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 int selinux_netlbl_socket_connect_locked(struct sock *sk,
 					 struct sockaddr *addr)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (sksec->nlbl_state != NLBL_REQSKB &&
 	    sksec->nlbl_state != NLBL_CONNLABELED)
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 041688e5a77a..297f21446f45 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -355,6 +355,11 @@ static inline struct superblock_smack *smack_superblock(
 	return superblock->s_security + smack_blob_sizes.lbs_superblock;
 }
 
+static inline struct socket_smack *smack_sock(const struct sock *sock)
+{
+	return sock->sk_security + smack_blob_sizes.lbs_sock;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 002a1b9ed83a..6ec9a40f3ec5 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1606,7 +1606,7 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 		if (sock == NULL || sock->sk == NULL)
 			return -EOPNOTSUPP;
 
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 
 		if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 			isp = ssp->smk_in;
@@ -1994,7 +1994,7 @@ static int smack_file_receive(struct file *file)
 
 	if (inode->i_sb->s_magic == SOCKFS_MAGIC) {
 		sock = SOCKET_I(inode);
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		tsp = smack_cred(current_cred());
 		/*
 		 * If the receiving process can't write to the
@@ -2409,11 +2409,7 @@ static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 {
 	struct smack_known *skp = smk_of_current();
-	struct socket_smack *ssp;
-
-	ssp = kzalloc(sizeof(struct socket_smack), gfp_flags);
-	if (ssp == NULL)
-		return -ENOMEM;
+	struct socket_smack *ssp = smack_sock(sk);
 
 	/*
 	 * Sockets created by kernel threads receive web label.
@@ -2427,11 +2423,10 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 	}
 	ssp->smk_packet = NULL;
 
-	sk->sk_security = ssp;
-
 	return 0;
 }
 
+#ifdef SMACK_IPV6_PORT_LABELING
 /**
  * smack_sk_free_security - Free a socket blob
  * @sk: the socket
@@ -2440,7 +2435,6 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
  */
 static void smack_sk_free_security(struct sock *sk)
 {
-#ifdef SMACK_IPV6_PORT_LABELING
 	struct smk_port_label *spp;
 
 	if (sk->sk_family == PF_INET6) {
@@ -2453,9 +2447,8 @@ static void smack_sk_free_security(struct sock *sk)
 		}
 		rcu_read_unlock();
 	}
-#endif
-	kfree(sk->sk_security);
 }
+#endif
 
 /**
  * smack_sk_clone_security - Copy security context
@@ -2466,8 +2459,8 @@ static void smack_sk_free_security(struct sock *sk)
  */
 static void smack_sk_clone_security(const struct sock *sk, struct sock *newsk)
 {
-	struct socket_smack *ssp_old = sk->sk_security;
-	struct socket_smack *ssp_new = newsk->sk_security;
+	struct socket_smack *ssp_old = smack_sock(sk);
+	struct socket_smack *ssp_new = smack_sock(newsk);
 
 	*ssp_new = *ssp_old;
 }
@@ -2583,7 +2576,7 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
  */
 static int smack_netlbl_add(struct sock *sk)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = ssp->smk_out;
 	int rc;
 
@@ -2616,7 +2609,7 @@ static int smack_netlbl_add(struct sock *sk)
  */
 static void smack_netlbl_delete(struct sock *sk)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 
 	/*
 	 * Take the label off the socket if one is set.
@@ -2648,7 +2641,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
 	struct smack_known *skp;
 	int rc = 0;
 	struct smack_known *hkp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smk_audit_info ad;
 
 	rcu_read_lock();
@@ -2721,7 +2714,7 @@ static void smk_ipv6_port_label(struct socket *sock, struct sockaddr *address)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_in6 *addr6;
-	struct socket_smack *ssp = sock->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
 	struct smk_port_label *spp;
 	unsigned short port = 0;
 
@@ -2809,7 +2802,7 @@ static int smk_ipv6_port_check(struct sock *sk, struct sockaddr_in6 *address,
 				int act)
 {
 	struct smk_port_label *spp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = NULL;
 	unsigned short port;
 	struct smack_known *object;
@@ -2912,7 +2905,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	if (sock == NULL || sock->sk == NULL)
 		return -EOPNOTSUPP;
 
-	ssp = sock->sk->sk_security;
+	ssp = smack_sock(sock->sk);
 
 	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 		ssp->smk_in = skp;
@@ -2960,7 +2953,7 @@ static int smack_socket_post_create(struct socket *sock, int family,
 	 * Sockets created by kernel threads receive web label.
 	 */
 	if (unlikely(current->flags & PF_KTHREAD)) {
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		ssp->smk_in = &smack_known_web;
 		ssp->smk_out = &smack_known_web;
 	}
@@ -2985,8 +2978,8 @@ static int smack_socket_post_create(struct socket *sock, int family,
 static int smack_socket_socketpair(struct socket *socka,
 		                   struct socket *sockb)
 {
-	struct socket_smack *asp = socka->sk->sk_security;
-	struct socket_smack *bsp = sockb->sk->sk_security;
+	struct socket_smack *asp = smack_sock(socka->sk);
+	struct socket_smack *bsp = smack_sock(sockb->sk);
 
 	asp->smk_packet = bsp->smk_out;
 	bsp->smk_packet = asp->smk_out;
@@ -3049,7 +3042,7 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 		if (__is_defined(SMACK_IPV6_SECMARK_LABELING))
 			rsp = smack_ipv6host_label(sip);
 		if (rsp != NULL) {
-			struct socket_smack *ssp = sock->sk->sk_security;
+			struct socket_smack *ssp = smack_sock(sock->sk);
 
 			rc = smk_ipv6_check(ssp->smk_out, rsp, sip,
 					    SMK_CONNECTING);
@@ -3844,9 +3837,9 @@ static int smack_unix_stream_connect(struct sock *sock,
 {
 	struct smack_known *skp;
 	struct smack_known *okp;
-	struct socket_smack *ssp = sock->sk_security;
-	struct socket_smack *osp = other->sk_security;
-	struct socket_smack *nsp = newsk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock);
+	struct socket_smack *osp = smack_sock(other);
+	struct socket_smack *nsp = smack_sock(newsk);
 	struct smk_audit_info ad;
 	int rc = 0;
 #ifdef CONFIG_AUDIT
@@ -3898,8 +3891,8 @@ static int smack_unix_stream_connect(struct sock *sock,
  */
 static int smack_unix_may_send(struct socket *sock, struct socket *other)
 {
-	struct socket_smack *ssp = sock->sk->sk_security;
-	struct socket_smack *osp = other->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
+	struct socket_smack *osp = smack_sock(other->sk);
 	struct smk_audit_info ad;
 	int rc;
 
@@ -3936,7 +3929,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 	struct sockaddr_in6 *sap = (struct sockaddr_in6 *) msg->msg_name;
 #endif
 #ifdef SMACK_IPV6_SECMARK_LABELING
-	struct socket_smack *ssp = sock->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
 	struct smack_known *rsp;
 #endif
 	int rc = 0;
@@ -4148,7 +4141,7 @@ static struct smack_known *smack_from_netlbl(const struct sock *sk, u16 family,
 	netlbl_secattr_init(&secattr);
 
 	if (sk)
-		ssp = sk->sk_security;
+		ssp = smack_sock(sk);
 
 	if (netlbl_skbuff_getattr(skb, family, &secattr) == 0) {
 		skp = smack_from_secattr(&secattr, ssp);
@@ -4170,7 +4163,7 @@ static struct smack_known *smack_from_netlbl(const struct sock *sk, u16 family,
  */
 static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = NULL;
 	int rc = 0;
 	struct smk_audit_info ad;
@@ -4274,7 +4267,7 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
 	u32 slen = 1;
 	int rc = 0;
 
-	ssp = sock->sk->sk_security;
+	ssp = smack_sock(sock->sk);
 	if (ssp->smk_packet != NULL) {
 		rcp = ssp->smk_packet->smk_known;
 		slen = strlen(rcp) + 1;
@@ -4324,7 +4317,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 
 	switch (family) {
 	case PF_UNIX:
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		s = ssp->smk_out->smk_secid;
 		break;
 	case PF_INET:
@@ -4373,7 +4366,7 @@ static void smack_sock_graft(struct sock *sk, struct socket *parent)
 	    (sk->sk_family != PF_INET && sk->sk_family != PF_INET6))
 		return;
 
-	ssp = sk->sk_security;
+	ssp = smack_sock(sk);
 	ssp->smk_in = skp;
 	ssp->smk_out = skp;
 	/* cssp->smk_packet is already set in smack_inet_csk_clone() */
@@ -4393,7 +4386,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 {
 	u16 family = sk->sk_family;
 	struct smack_known *skp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct sockaddr_in addr;
 	struct iphdr *hdr;
 	struct smack_known *hskp;
@@ -4479,7 +4472,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 static void smack_inet_csk_clone(struct sock *sk,
 				 const struct request_sock *req)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp;
 
 	if (req->peer_secid != 0) {
@@ -5049,6 +5042,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
 	.lbs_msg_msg = sizeof(struct smack_known *),
+	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
 };
@@ -5173,7 +5167,9 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(socket_getpeersec_stream, smack_socket_getpeersec_stream),
 	LSM_HOOK_INIT(socket_getpeersec_dgram, smack_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sk_alloc_security, smack_sk_alloc_security),
+#ifdef SMACK_IPV6_PORT_LABELING
 	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
+#endif
 	LSM_HOOK_INIT(sk_clone_security, smack_sk_clone_security),
 	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
 	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index b945c1d3a743..bad71b7e648d 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -26,8 +26,8 @@ static unsigned int smack_ip_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
-	if (sk && sk->sk_security) {
-		ssp = sk->sk_security;
+	if (sk) {
+		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
 		skb->secmark = skp->smk_secid;
 	}
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index e22aad7604e8..5dd1e164f9b1 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -932,7 +932,7 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	}
 	if (rc >= 0) {
 		old_cat = skp->smk_netlabel.attr.mls.cat;
-		skp->smk_netlabel.attr.mls.cat = ncats.attr.mls.cat;
+		rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
 		skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;
 		synchronize_rcu();
 		netlbl_catmap_free(old_cat);
diff --git a/sound/pci/hda/cs35l41_hda_spi.c b/sound/pci/hda/cs35l41_hda_spi.c
index b76c0dfd5fef..f8c356ad0d34 100644
--- a/sound/pci/hda/cs35l41_hda_spi.c
+++ b/sound/pci/hda/cs35l41_hda_spi.c
@@ -38,6 +38,7 @@ static const struct spi_device_id cs35l41_hda_spi_id[] = {
 	{ "cs35l41-hda", 0 },
 	{}
 };
+MODULE_DEVICE_TABLE(spi, cs35l41_hda_spi_id);
 
 static const struct acpi_device_id cs35l41_acpi_hda_match[] = {
 	{ "CSC3551", 0 },
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 9e88d39eac1e..0676b4160566 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -822,7 +822,7 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 	} else
 		return -ENODEV;
 
-	tas_hda->priv->irq_info.irq = clt->irq;
+	tas_hda->priv->irq = clt->irq;
 	ret = tas2781_read_acpi(tas_hda->priv, device_name);
 	if (ret)
 		return dev_err_probe(tas_hda->dev, ret,
diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index e3aca9c785a0..aa163ec40862 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2903,8 +2903,10 @@ int rt5682_register_dai_clks(struct rt5682_priv *rt5682)
 		}
 
 		if (dev->of_node) {
-			devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+			ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
 						    dai_clk_hw);
+			if (ret)
+				return ret;
 		} else {
 			ret = devm_clk_hw_register_clkdev(dev, dai_clk_hw,
 							  init.name,
diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index f50f196d700d..ce2e88e066f3 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -2828,7 +2828,9 @@ static int rt5682s_register_dai_clks(struct snd_soc_component *component)
 		}
 
 		if (dev->of_node) {
-			devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, dai_clk_hw);
+			ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, dai_clk_hw);
+			if (ret)
+				return ret;
 		} else {
 			ret = devm_clk_hw_register_clkdev(dev, dai_clk_hw,
 							  init.name, dev_name(dev));
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index 3aa81514dad7..0444cf90c511 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -14,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -406,8 +405,6 @@ EXPORT_SYMBOL_GPL(tasdevice_dsp_remove);
 
 void tasdevice_remove(struct tasdevice_priv *tas_priv)
 {
-	if (gpio_is_valid(tas_priv->irq_info.irq_gpio))
-		gpio_free(tas_priv->irq_info.irq_gpio);
 	mutex_destroy(&tas_priv->codec_lock);
 }
 EXPORT_SYMBOL_GPL(tasdevice_remove);
diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index 8f9a3ae7153e..f3a7605f0710 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -13,7 +13,6 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index c64d458e524e..edd1ad3062c8 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -21,7 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -618,7 +618,7 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 {
 	struct i2c_client *client = (struct i2c_client *)tas_priv->client;
 	unsigned int dev_addrs[TASDEVICE_MAX_CHANNELS];
-	int rc, i, ndev = 0;
+	int i, ndev = 0;
 
 	if (tas_priv->isacpi) {
 		ndev = device_property_read_u32_array(&client->dev,
@@ -633,64 +633,34 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 				"ti,audio-slots", dev_addrs, ndev);
 		}
 
-		tas_priv->irq_info.irq_gpio =
+		tas_priv->irq =
 			acpi_dev_gpio_irq_get(ACPI_COMPANION(&client->dev), 0);
-	} else {
+	} else if (IS_ENABLED(CONFIG_OF)) {
 		struct device_node *np = tas_priv->dev->of_node;
-#ifdef CONFIG_OF
-		const __be32 *reg, *reg_end;
-		int len, sw, aw;
-
-		aw = of_n_addr_cells(np);
-		sw = of_n_size_cells(np);
-		if (sw == 0) {
-			reg = (const __be32 *)of_get_property(np,
-				"reg", &len);
-			reg_end = reg + len/sizeof(*reg);
-			ndev = 0;
-			do {
-				dev_addrs[ndev] = of_read_number(reg, aw);
-				reg += aw;
-				ndev++;
-			} while (reg < reg_end);
-		} else {
-			ndev = 1;
-			dev_addrs[0] = client->addr;
+		u64 addr;
+
+		for (i = 0; i < TASDEVICE_MAX_CHANNELS; i++) {
+			if (of_property_read_reg(np, i, &addr, NULL))
+				break;
+			dev_addrs[ndev++] = addr;
 		}
-#else
+
+		tas_priv->irq = of_irq_get(np, 0);
+	} else {
 		ndev = 1;
 		dev_addrs[0] = client->addr;
-#endif
-		tas_priv->irq_info.irq_gpio = of_irq_get(np, 0);
 	}
 	tas_priv->ndev = ndev;
 	for (i = 0; i < ndev; i++)
 		tas_priv->tasdevice[i].dev_addr = dev_addrs[i];
 
 	tas_priv->reset = devm_gpiod_get_optional(&client->dev,
-			"reset-gpios", GPIOD_OUT_HIGH);
+			"reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(tas_priv->reset))
 		dev_err(tas_priv->dev, "%s Can't get reset GPIO\n",
 			__func__);
 
 	strcpy(tas_priv->dev_name, tasdevice_id[tas_priv->chip_id].name);
-
-	if (gpio_is_valid(tas_priv->irq_info.irq_gpio)) {
-		rc = gpio_request(tas_priv->irq_info.irq_gpio,
-				"AUDEV-IRQ");
-		if (!rc) {
-			gpio_direction_input(
-				tas_priv->irq_info.irq_gpio);
-
-			tas_priv->irq_info.irq =
-				gpio_to_irq(tas_priv->irq_info.irq_gpio);
-		} else
-			dev_err(tas_priv->dev, "%s: GPIO %d request error\n",
-				__func__, tas_priv->irq_info.irq_gpio);
-	} else
-		dev_err(tas_priv->dev,
-			"Looking up irq-gpio property failed %d\n",
-			tas_priv->irq_info.irq_gpio);
 }
 
 static int tasdevice_i2c_probe(struct i2c_client *i2c)
diff --git a/sound/soc/loongson/loongson_card.c b/sound/soc/loongson/loongson_card.c
index fae5e9312bf0..2c8dbdba27c5 100644
--- a/sound/soc/loongson/loongson_card.c
+++ b/sound/soc/loongson/loongson_card.c
@@ -127,8 +127,8 @@ static int loongson_card_parse_of(struct loongson_card_data *data)
 	codec = of_get_child_by_name(dev->of_node, "codec");
 	if (!codec) {
 		dev_err(dev, "audio-codec property missing or invalid\n");
-		ret = -EINVAL;
-		goto err;
+		of_node_put(cpu);
+		return -EINVAL;
 	}
 
 	for (i = 0; i < card->num_links; i++) {
diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index d8288936c912..c4f1f1735af6 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -15,6 +15,7 @@ INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../include/uapi)
 CFLAGS := -g -Wall $(CLANG_CROSS_FLAGS)
 CFLAGS += $(EXTRA_CFLAGS)
 LDFLAGS += $(EXTRA_LDFLAGS)
+LDLIBS += -lelf -lz
 
 # Try to detect best kernel BTF source
 KERNEL_REL := $(shell uname -r)
@@ -51,7 +52,7 @@ clean:
 libbpf_hdrs: $(BPFOBJ)
 
 $(OUTPUT)/runqslower: $(OUTPUT)/runqslower.o $(BPFOBJ)
-	$(QUIET_LINK)$(CC) $(CFLAGS) $^ -lelf -lz -o $@
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
 
 $(OUTPUT)/runqslower.o: runqslower.h $(OUTPUT)/runqslower.skel.h	      \
 			$(OUTPUT)/runqslower.bpf.o | libbpf_hdrs
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index dd0a18c2ef8f..6f4bf386a3b5 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -134,10 +134,6 @@
 #undef main
 #endif
 
-#define main main_test_libcapstone
-# include "test-libcapstone.c"
-#undef main
-
 #define main main_test_lzma
 # include "test-lzma.c"
 #undef main
diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index f9ab28421e6d..9ec9c24f38c0 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -7,6 +7,7 @@
 #ifndef _NOLIBC_STRING_H
 #define _NOLIBC_STRING_H
 
+#include "arch.h"
 #include "std.h"
 
 static void *malloc(size_t len);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5edb71764784..3ecb33188336 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -473,8 +473,6 @@ struct bpf_program {
 };
 
 struct bpf_struct_ops {
-	const char *tname;
-	const struct btf_type *type;
 	struct bpf_program **progs;
 	__u32 *kern_func_off;
 	/* e.g. struct tcp_congestion_ops in bpf_prog's btf format */
@@ -1059,11 +1057,14 @@ static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
 			continue;
 
 		for (j = 0; j < obj->nr_maps; ++j) {
+			const struct btf_type *type;
+
 			map = &obj->maps[j];
 			if (!bpf_map__is_struct_ops(map))
 				continue;
 
-			vlen = btf_vlen(map->st_ops->type);
+			type = btf__type_by_id(obj->btf, map->st_ops->type_id);
+			vlen = btf_vlen(type);
 			for (k = 0; k < vlen; ++k) {
 				slot_prog = map->st_ops->progs[k];
 				if (prog != slot_prog)
@@ -1097,8 +1098,8 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 	int err;
 
 	st_ops = map->st_ops;
-	type = st_ops->type;
-	tname = st_ops->tname;
+	type = btf__type_by_id(btf, st_ops->type_id);
+	tname = btf__name_by_offset(btf, type->name_off);
 	err = find_struct_ops_kern_types(obj, tname, &mod_btf,
 					 &kern_type, &kern_type_id,
 					 &kern_vtype, &kern_vtype_id,
@@ -1398,8 +1399,6 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		memcpy(st_ops->data,
 		       data->d_buf + vsi->offset,
 		       type->size);
-		st_ops->tname = tname;
-		st_ops->type = type;
 		st_ops->type_id = type_id;
 
 		pr_debug("struct_ops init: struct %s(type_id=%u) %s found at offset %u\n",
@@ -7867,16 +7866,19 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 }
 
 static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf, size_t obj_buf_sz,
+					  const char *obj_name,
 					  const struct bpf_object_open_opts *opts)
 {
-	const char *obj_name, *kconfig, *btf_tmp_path, *token_path;
+	const char *kconfig, *btf_tmp_path, *token_path;
 	struct bpf_object *obj;
-	char tmp_name[64];
 	int err;
 	char *log_buf;
 	size_t log_size;
 	__u32 log_level;
 
+	if (obj_buf && !obj_name)
+		return ERR_PTR(-EINVAL);
+
 	if (elf_version(EV_CURRENT) == EV_NONE) {
 		pr_warn("failed to init libelf for %s\n",
 			path ? : "(mem buf)");
@@ -7886,16 +7888,12 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	if (!OPTS_VALID(opts, bpf_object_open_opts))
 		return ERR_PTR(-EINVAL);
 
-	obj_name = OPTS_GET(opts, object_name, NULL);
+	obj_name = OPTS_GET(opts, object_name, NULL) ?: obj_name;
 	if (obj_buf) {
-		if (!obj_name) {
-			snprintf(tmp_name, sizeof(tmp_name), "%lx-%lx",
-				 (unsigned long)obj_buf,
-				 (unsigned long)obj_buf_sz);
-			obj_name = tmp_name;
-		}
 		path = obj_name;
 		pr_debug("loading object '%s' from buffer\n", obj_name);
+	} else {
+		pr_debug("loading object from %s\n", path);
 	}
 
 	log_buf = OPTS_GET(opts, kernel_log_buf, NULL);
@@ -7979,9 +7977,7 @@ bpf_object__open_file(const char *path, const struct bpf_object_open_opts *opts)
 	if (!path)
 		return libbpf_err_ptr(-EINVAL);
 
-	pr_debug("loading %s\n", path);
-
-	return libbpf_ptr(bpf_object_open(path, NULL, 0, opts));
+	return libbpf_ptr(bpf_object_open(path, NULL, 0, NULL, opts));
 }
 
 struct bpf_object *bpf_object__open(const char *path)
@@ -7993,10 +7989,15 @@ struct bpf_object *
 bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
 		     const struct bpf_object_open_opts *opts)
 {
+	char tmp_name[64];
+
 	if (!obj_buf || obj_buf_sz == 0)
 		return libbpf_err_ptr(-EINVAL);
 
-	return libbpf_ptr(bpf_object_open(NULL, obj_buf, obj_buf_sz, opts));
+	/* create a (quite useless) default "name" for this memory buffer object */
+	snprintf(tmp_name, sizeof(tmp_name), "%lx-%zx", (unsigned long)obj_buf, obj_buf_sz);
+
+	return libbpf_ptr(bpf_object_open(NULL, obj_buf, obj_buf_sz, tmp_name, opts));
 }
 
 static int bpf_object_unload(struct bpf_object *obj)
@@ -8406,11 +8407,13 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 
 static void bpf_map_prepare_vdata(const struct bpf_map *map)
 {
+	const struct btf_type *type;
 	struct bpf_struct_ops *st_ops;
 	__u32 i;
 
 	st_ops = map->st_ops;
-	for (i = 0; i < btf_vlen(st_ops->type); i++) {
+	type = btf__type_by_id(map->obj->btf, st_ops->type_id);
+	for (i = 0; i < btf_vlen(type); i++) {
 		struct bpf_program *prog = st_ops->progs[i];
 		void *kern_data;
 		int prog_fd;
@@ -9673,6 +9676,7 @@ static struct bpf_map *find_struct_ops_map_by_offset(struct bpf_object *obj,
 static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 					    Elf64_Shdr *shdr, Elf_Data *data)
 {
+	const struct btf_type *type;
 	const struct btf_member *member;
 	struct bpf_struct_ops *st_ops;
 	struct bpf_program *prog;
@@ -9732,13 +9736,14 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 		}
 		insn_idx = sym->st_value / BPF_INSN_SZ;
 
-		member = find_member_by_offset(st_ops->type, moff * 8);
+		type = btf__type_by_id(btf, st_ops->type_id);
+		member = find_member_by_offset(type, moff * 8);
 		if (!member) {
 			pr_warn("struct_ops reloc %s: cannot find member at moff %u\n",
 				map->name, moff);
 			return -EINVAL;
 		}
-		member_idx = member - btf_members(st_ops->type);
+		member_idx = member - btf_members(type);
 		name = btf__name_by_offset(btf, member->name_off);
 
 		if (!resolve_func_ptr(btf, member->type, NULL)) {
@@ -13715,29 +13720,13 @@ static int populate_skeleton_progs(const struct bpf_object *obj,
 int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
 			      const struct bpf_object_open_opts *opts)
 {
-	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, skel_opts,
-		.object_name = s->name,
-	);
 	struct bpf_object *obj;
 	int err;
 
-	/* Attempt to preserve opts->object_name, unless overriden by user
-	 * explicitly. Overwriting object name for skeletons is discouraged,
-	 * as it breaks global data maps, because they contain object name
-	 * prefix as their own map name prefix. When skeleton is generated,
-	 * bpftool is making an assumption that this name will stay the same.
-	 */
-	if (opts) {
-		memcpy(&skel_opts, opts, sizeof(*opts));
-		if (!opts->object_name)
-			skel_opts.object_name = s->name;
-	}
-
-	obj = bpf_object__open_mem(s->data, s->data_sz, &skel_opts);
-	err = libbpf_get_error(obj);
-	if (err) {
-		pr_warn("failed to initialize skeleton BPF object '%s': %d\n",
-			s->name, err);
+	obj = bpf_object_open(NULL, s->data, s->data_sz, s->name, opts);
+	if (IS_ERR(obj)) {
+		err = PTR_ERR(obj);
+		pr_warn("failed to initialize skeleton BPF object '%s': %d\n", s->name, err);
 		return libbpf_err(err);
 	}
 
diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index aee479d2191c..69b66994f2a1 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -122,7 +122,7 @@ static bool decode_insn_reg2i12_fomat(union loongarch_instruction inst,
 	switch (inst.reg2i12_format.opcode) {
 	case addid_op:
 		if ((inst.reg2i12_format.rd == CFI_SP) || (inst.reg2i12_format.rj == CFI_SP)) {
-			/* addi.d sp,sp,si12 or addi.d fp,sp,si12 */
+			/* addi.d sp,sp,si12 or addi.d fp,sp,si12 or addi.d sp,fp,si12 */
 			insn->immediate = sign_extend64(inst.reg2i12_format.immediate, 11);
 			ADD_OP(op) {
 				op->src.type = OP_SRC_ADD;
@@ -132,6 +132,15 @@ static bool decode_insn_reg2i12_fomat(union loongarch_instruction inst,
 				op->dest.reg = inst.reg2i12_format.rd;
 			}
 		}
+		if ((inst.reg2i12_format.rd == CFI_SP) && (inst.reg2i12_format.rj == CFI_FP)) {
+			/* addi.d sp,fp,si12 */
+			struct symbol *func = find_func_containing(insn->sec, insn->offset);
+
+			if (!func)
+				return false;
+
+			func->frame_pointer = true;
+		}
 		break;
 	case ldd_op:
 		if (inst.reg2i12_format.rj == CFI_SP) {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0a33d9195b7a..60680b2bec96 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2991,10 +2991,27 @@ static int update_cfi_state(struct instruction *insn,
 				break;
 			}
 
-			if (op->dest.reg == CFI_SP && op->src.reg == CFI_BP) {
+			if (op->dest.reg == CFI_BP && op->src.reg == CFI_SP &&
+			    insn->sym->frame_pointer) {
+				/* addi.d fp,sp,imm on LoongArch */
+				if (cfa->base == CFI_SP && cfa->offset == op->src.offset) {
+					cfa->base = CFI_BP;
+					cfa->offset = 0;
+				}
+				break;
+			}
 
-				/* lea disp(%rbp), %rsp */
-				cfi->stack_size = -(op->src.offset + regs[CFI_BP].offset);
+			if (op->dest.reg == CFI_SP && op->src.reg == CFI_BP) {
+				/* addi.d sp,fp,imm on LoongArch */
+				if (cfa->base == CFI_BP && cfa->offset == 0) {
+					if (insn->sym->frame_pointer) {
+						cfa->base = CFI_SP;
+						cfa->offset = -op->src.offset;
+					}
+				} else {
+					/* lea disp(%rbp), %rsp */
+					cfi->stack_size = -(op->src.offset + regs[CFI_BP].offset);
+				}
 				break;
 			}
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 2b8a69de4db8..d7e815c2fd15 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -68,6 +68,7 @@ struct symbol {
 	u8 warned	     : 1;
 	u8 embedded_insn     : 1;
 	u8 local_label       : 1;
+	u8 frame_pointer     : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 };
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c157bd31f2e5..7298f3607062 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3266,7 +3266,7 @@ static int perf_c2c__record(int argc, const char **argv)
 		return -1;
 	}
 
-	if (perf_pmu__mem_events_init(pmu)) {
+	if (perf_pmu__mem_events_init()) {
 		pr_err("failed: memory events not supported\n");
 		return -1;
 	}
@@ -3290,19 +3290,15 @@ static int perf_c2c__record(int argc, const char **argv)
 		 * PERF_MEM_EVENTS__LOAD_STORE if it is supported.
 		 */
 		if (e->tag) {
-			e->record = true;
+			perf_mem_record[PERF_MEM_EVENTS__LOAD_STORE] = true;
 			rec_argv[i++] = "-W";
 		} else {
-			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
-			e->record = true;
-
-			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__STORE);
-			e->record = true;
+			perf_mem_record[PERF_MEM_EVENTS__LOAD] = true;
+			perf_mem_record[PERF_MEM_EVENTS__STORE] = true;
 		}
 	}
 
-	e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
-	if (e->record)
+	if (perf_mem_record[PERF_MEM_EVENTS__LOAD])
 		rec_argv[i++] = "-W";
 
 	rec_argv[i++] = "-d";
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a212678d47be..c80fb0f60e61 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2204,6 +2204,7 @@ int cmd_inject(int argc, const char **argv)
 			.finished_init	= perf_event__repipe_op2_synth,
 			.compressed	= perf_event__repipe_op4_synth,
 			.auxtrace	= perf_event__repipe_auxtrace,
+			.dont_split_sample_group = true,
 		},
 		.input_name  = "-",
 		.samples = LIST_HEAD_INIT(inject.samples),
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 863fcd735dae..08724fa508e1 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -97,7 +97,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 		return -1;
 	}
 
-	if (perf_pmu__mem_events_init(pmu)) {
+	if (perf_pmu__mem_events_init()) {
 		pr_err("failed: memory events not supported\n");
 		return -1;
 	}
@@ -126,22 +126,17 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	if (e->tag &&
 	    (mem->operation & MEM_OPERATION_LOAD) &&
 	    (mem->operation & MEM_OPERATION_STORE)) {
-		e->record = true;
+		perf_mem_record[PERF_MEM_EVENTS__LOAD_STORE] = true;
 		rec_argv[i++] = "-W";
 	} else {
-		if (mem->operation & MEM_OPERATION_LOAD) {
-			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
-			e->record = true;
-		}
+		if (mem->operation & MEM_OPERATION_LOAD)
+			perf_mem_record[PERF_MEM_EVENTS__LOAD] = true;
 
-		if (mem->operation & MEM_OPERATION_STORE) {
-			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__STORE);
-			e->record = true;
-		}
+		if (mem->operation & MEM_OPERATION_STORE)
+			perf_mem_record[PERF_MEM_EVENTS__STORE] = true;
 	}
 
-	e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
-	if (e->record)
+	if (perf_mem_record[PERF_MEM_EVENTS__LOAD])
 		rec_argv[i++] = "-W";
 
 	rec_argv[i++] = "-d";
@@ -372,6 +367,7 @@ static int report_events(int argc, const char **argv, struct perf_mem *mem)
 		rep_argv[i] = argv[j];
 
 	ret = cmd_report(i, rep_argv);
+	free(new_sort_order);
 	free(rep_argv);
 	return ret;
 }
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 69618fb0110b..8bebaba56bc3 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -565,6 +565,7 @@ static int evlist__tty_browse_hists(struct evlist *evlist, struct report *rep, c
 		struct hists *hists = evsel__hists(pos);
 		const char *evname = evsel__name(pos);
 
+		i++;
 		if (symbol_conf.event_group && !evsel__is_group_leader(pos))
 			continue;
 
@@ -574,7 +575,7 @@ static int evlist__tty_browse_hists(struct evlist *evlist, struct report *rep, c
 		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
 
 		if (rep->total_cycles_mode) {
-			report__browse_block_hists(&rep->block_reports[i++].hist,
+			report__browse_block_hists(&rep->block_reports[i - 1].hist,
 						   rep->min_percent, pos, NULL);
 			continue;
 		}
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 5977c49ae2c7..ed11a20bc149 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2596,9 +2596,12 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 	 * - previous sched event is out of window - we are done
 	 * - sample time is beyond window user cares about - reset it
 	 *   to close out stats for time window interest
+	 * - If tprev is 0, that is, sched_in event for current task is
+	 *   not recorded, cannot determine whether sched_in event is
+	 *   within time window interest - ignore it
 	 */
 	if (ptime->end) {
-		if (tprev > ptime->end)
+		if (!tprev || tprev > ptime->end)
 			goto out;
 
 		if (t > ptime->end)
@@ -3031,7 +3034,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
 
 	if (perf_time__parse_str(&sched->ptime, sched->time_str) != 0) {
 		pr_err("Invalid time string\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto out;
 	}
 
 	if (timehist_check_attr(sched, evlist) != 0)
diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index d973c2baed1c..7aff02d84ffb 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -192,17 +192,16 @@ def process_event(param_dict):
 	ip = sample["ip"]
 	addr = sample["addr"]
 
+	if (options.verbose == True):
+		print("Event type: %s" % name)
+		print_sample(sample)
+
 	# Initialize CPU data if it's empty, and directly return back
 	# if this is the first tracing event for this CPU.
 	if (cpu_data.get(str(cpu) + 'addr') == None):
 		cpu_data[str(cpu) + 'addr'] = addr
 		return
 
-
-	if (options.verbose == True):
-		print("Event type: %s" % name)
-		print_sample(sample)
-
 	# If cannot find dso so cannot dump assembler, bail out
 	if (dso == '[unknown]'):
 		return
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 965da6c0b542..79c1f2ae7aff 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -104,7 +104,7 @@ static void pr_debug_location(Dwarf_Die *die, u64 pc, int reg)
 		return;
 
 	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
-		if (reg != DWARF_REG_PC && end < pc)
+		if (reg != DWARF_REG_PC && end <= pc)
 			continue;
 		if (reg != DWARF_REG_PC && start > pc)
 			break;
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index 36af11faad03..de12892f992f 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -7,11 +7,11 @@ struct tstamp_data {
 	u64 timestamp;
 	u64 lock;
 	u32 flags;
-	u32 stack_id;
+	s32 stack_id;
 };
 
 struct contention_key {
-	u32 stack_id;
+	s32 stack_id;
 	u32 pid;
 	u64 lock_addr_or_cgroup;
 };
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index e9028235d771..d818e30c5457 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -15,6 +15,7 @@
 
 typedef __u8 u8;
 typedef __u32 u32;
+typedef __s32 s32;
 typedef __u64 u64;
 typedef __s64 s64;
 
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 44ef968a7ad3..1b0e59f4d8e9 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1444,7 +1444,7 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 
 	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
 		/* Assuming the location list is sorted by address */
-		if (end < data->pc)
+		if (end <= data->pc)
 			continue;
 		if (start > data->pc)
 			break;
@@ -1598,6 +1598,9 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 	if (dwarf_getlocations(&attr, 0, &base, &start, &end, &ops, &nops) <= 0)
 		return DIE_FIND_CB_SIBLING;
 
+	if (!check_allowed_ops(ops, nops))
+		return DIE_FIND_CB_SIBLING;
+
 	if (die_get_real_type(die_mem, &type_die) == NULL)
 		return DIE_FIND_CB_SIBLING;
 
@@ -1974,8 +1977,15 @@ static int __die_find_member_offset_cb(Dwarf_Die *die_mem, void *arg)
 		return DIE_FIND_CB_SIBLING;
 
 	/* Unions might not have location */
-	if (die_get_data_member_location(die_mem, &loc) < 0)
-		loc = 0;
+	if (die_get_data_member_location(die_mem, &loc) < 0) {
+		Dwarf_Attribute attr;
+
+		if (dwarf_attr_integrate(die_mem, DW_AT_data_bit_offset, &attr) &&
+		    dwarf_formudata(&attr, &loc) == 0)
+			loc /= 8;
+		else
+			loc = 0;
+	}
 
 	if (offset == loc)
 		return DIE_FIND_CB_END;
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 6dda47bb774f..1f1e1063efe3 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -28,6 +28,8 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 };
 #undef E
 
+bool perf_mem_record[PERF_MEM_EVENTS__MAX] = { 0 };
+
 static char mem_loads_name[100];
 static char mem_stores_name[100];
 
@@ -162,7 +164,7 @@ int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str)
 				continue;
 
 			if (strstr(e->tag, tok))
-				e->record = found = true;
+				perf_mem_record[j] = found = true;
 		}
 
 		tok = strtok_r(NULL, ",", &saveptr);
@@ -191,7 +193,7 @@ static bool perf_pmu__mem_events_supported(const char *mnt, struct perf_pmu *pmu
 	return !stat(path, &st);
 }
 
-int perf_pmu__mem_events_init(struct perf_pmu *pmu)
+static int __perf_pmu__mem_events_init(struct perf_pmu *pmu)
 {
 	const char *mnt = sysfs__mount();
 	bool found = false;
@@ -218,6 +220,18 @@ int perf_pmu__mem_events_init(struct perf_pmu *pmu)
 	return found ? 0 : -ENOENT;
 }
 
+int perf_pmu__mem_events_init(void)
+{
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
+		if (__perf_pmu__mem_events_init(pmu))
+			return -ENOENT;
+	}
+
+	return 0;
+}
+
 void perf_pmu__mem_events_list(struct perf_pmu *pmu)
 {
 	int j;
@@ -247,7 +261,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
 		for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 			e = perf_pmu__mem_events_ptr(pmu, j);
 
-			if (!e->record)
+			if (!perf_mem_record[j])
 				continue;
 
 			if (!e->supported) {
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index ca31014d7934..8dc27db9fd52 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -6,7 +6,6 @@
 #include <linux/types.h>
 
 struct perf_mem_event {
-	bool		record;
 	bool		supported;
 	bool		ldlat;
 	u32		aux_event;
@@ -28,9 +27,10 @@ struct perf_pmu;
 
 extern unsigned int perf_mem_events__loads_ldlat;
 extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
+extern bool perf_mem_record[PERF_MEM_EVENTS__MAX];
 
 int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str);
-int perf_pmu__mem_events_init(struct perf_pmu *pmu);
+int perf_pmu__mem_events_init(void);
 
 struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i);
 struct perf_pmu *perf_mem_events_find_pmu(void);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a10343b9dcd4..1457cd5288ab 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1511,6 +1511,9 @@ static int deliver_sample_group(struct evlist *evlist,
 	int ret = -EINVAL;
 	struct sample_read_value *v = sample->read.group.values;
 
+	if (tool->dont_split_sample_group)
+		return deliver_sample_value(evlist, tool, event, sample, v, machine);
+
 	sample_read_group__for_each(v, sample->read.group.nr, read_format) {
 		ret = deliver_sample_value(evlist, tool, event, sample, v,
 					   machine);
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 186305fd2d0e..ac79ac4ccbe0 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1226,7 +1226,8 @@ static void print_metric_headers(struct perf_stat_config *config,
 
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
-		if (config->aggr_mode != AGGR_NONE && counter->metric_leader != counter)
+		if (!config->iostat_run &&
+		    config->aggr_mode != AGGR_NONE && counter->metric_leader != counter)
 			continue;
 
 		os.evsel = counter;
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 302443921681..1b91ccd4d523 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -20,7 +20,7 @@ int parse_nsec_time(const char *str, u64 *ptime)
 	u64 time_sec, time_nsec;
 	char *end;
 
-	time_sec = strtoul(str, &end, 10);
+	time_sec = strtoull(str, &end, 10);
 	if (*end != '.' && *end != '\0')
 		return -1;
 
@@ -38,7 +38,7 @@ int parse_nsec_time(const char *str, u64 *ptime)
 		for (i = strlen(nsec_buf); i < 9; i++)
 			nsec_buf[i] = '0';
 
-		time_nsec = strtoul(nsec_buf, &end, 10);
+		time_nsec = strtoull(nsec_buf, &end, 10);
 		if (*end != '\0')
 			return -1;
 	} else
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index c957fb849ac6..62bbc9cec151 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -85,6 +85,7 @@ struct perf_tool {
 	bool		namespace_events;
 	bool		cgroup_events;
 	bool		no_warn;
+	bool		dont_split_sample_group;
 	enum show_feature_header show_feat_hdr;
 };
 
diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index a7a59c6bacda..94a0c69e55ef 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -77,6 +77,14 @@ int powercap_get_enabled(int *mode)
 	return sysfs_get_enabled(path, mode);
 }
 
+/*
+ * TODO: implement function. Returns dummy 0 for now.
+ */
+int powercap_set_enabled(int mode)
+{
+	return 0;
+}
+
 /*
  * Hardcoded, because rapl is the only powercap implementation
 - * this needs to get more generic if more powercap implementations
diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index 8f5febaf1a9a..edb3613513b8 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -23,7 +23,7 @@ $(TEST_GEN_PROGS): $(PROGS)
 # Common test-unit targets to build common-layout test-cases executables
 # Needs secondary expansion to properly include the testcase c-file in pre-reqs
 COMMON_SOURCES := test_signals.c test_signals_utils.c testcases/testcases.c \
-	signals.S
+	signals.S sve_helpers.c
 COMMON_HEADERS := test_signals.h test_signals_utils.h testcases/testcases.h
 
 .SECONDEXPANSION:
diff --git a/tools/testing/selftests/arm64/signal/sve_helpers.c b/tools/testing/selftests/arm64/signal/sve_helpers.c
new file mode 100644
index 000000000000..0acc121af306
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/sve_helpers.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 ARM Limited
+ *
+ * Common helper functions for SVE and SME functionality.
+ */
+
+#include <stdbool.h>
+#include <kselftest.h>
+#include <asm/sigcontext.h>
+#include <sys/prctl.h>
+
+unsigned int vls[SVE_VQ_MAX];
+unsigned int nvls;
+
+int sve_fill_vls(bool use_sme, int min_vls)
+{
+	int vq, vl;
+	int pr_set_vl = use_sme ? PR_SME_SET_VL : PR_SVE_SET_VL;
+	int len_mask = use_sme ? PR_SME_VL_LEN_MASK : PR_SVE_VL_LEN_MASK;
+
+	/*
+	 * Enumerate up to SVE_VQ_MAX vector lengths
+	 */
+	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
+		vl = prctl(pr_set_vl, vq * 16);
+		if (vl == -1)
+			return KSFT_FAIL;
+
+		vl &= len_mask;
+
+		/*
+		 * Unlike SVE, SME does not require the minimum vector length
+		 * to be implemented, or the VLs to be consecutive, so any call
+		 * to the prctl might return the single implemented VL, which
+		 * might be larger than 16. So to avoid this loop never
+		 * terminating,  bail out here when we find a higher VL than
+		 * we asked for.
+		 * See the ARM ARM, DDI 0487K.a, B1.4.2: I_QQRNR and I_NWYBP.
+		 */
+		if (vq < sve_vq_from_vl(vl))
+			break;
+
+		/* Skip missing VLs */
+		vq = sve_vq_from_vl(vl);
+
+		vls[nvls++] = vl;
+	}
+
+	if (nvls < min_vls) {
+		fprintf(stderr, "Only %d VL supported\n", nvls);
+		return KSFT_SKIP;
+	}
+
+	return KSFT_PASS;
+}
diff --git a/tools/testing/selftests/arm64/signal/sve_helpers.h b/tools/testing/selftests/arm64/signal/sve_helpers.h
new file mode 100644
index 000000000000..50948ce471cc
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/sve_helpers.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 ARM Limited
+ *
+ * Common helper functions for SVE and SME functionality.
+ */
+
+#ifndef __SVE_HELPERS_H__
+#define __SVE_HELPERS_H__
+
+#include <stdbool.h>
+
+#define VLS_USE_SVE	false
+#define VLS_USE_SME	true
+
+extern unsigned int vls[];
+extern unsigned int nvls;
+
+int sve_fill_vls(bool use_sme, int min_vls);
+
+#endif
diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
index ebd5815b54bb..dfd6a2badf9f 100644
--- a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
@@ -6,44 +6,28 @@
  * handler, this is not supported and is expected to segfault.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 struct fake_sigframe sf;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 2);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SVE_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
+	if (!res)
+		return true;
 
-		vl &= PR_SME_VL_LEN_MASK;
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least two VLs */
-	if (nvls < 2) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
-
-	return true;
+	return false;
 }
 
 static int fake_sigreturn_ssve_change_vl(struct tdescr *td,
@@ -51,30 +35,30 @@ static int fake_sigreturn_ssve_change_vl(struct tdescr *td,
 {
 	size_t resv_sz, offset;
 	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
-	struct sve_context *sve;
+	struct za_context *za;
 
 	/* Get a signal context with a SME ZA frame in it */
 	if (!get_current_context(td, &sf.uc, sizeof(sf.uc)))
 		return 1;
 
 	resv_sz = GET_SF_RESV_SIZE(sf);
-	head = get_header(head, SVE_MAGIC, resv_sz, &offset);
+	head = get_header(head, ZA_MAGIC, resv_sz, &offset);
 	if (!head) {
-		fprintf(stderr, "No SVE context\n");
+		fprintf(stderr, "No ZA context\n");
 		return 1;
 	}
 
-	if (head->size != sizeof(struct sve_context)) {
+	if (head->size != sizeof(struct za_context)) {
 		fprintf(stderr, "Register data present, aborting\n");
 		return 1;
 	}
 
-	sve = (struct sve_context *)head;
+	za = (struct za_context *)head;
 
 	/* No changes are supported; init left us at minimum VL so go to max */
 	fprintf(stderr, "Attempting to change VL from %d to %d\n",
-		sve->vl, vls[0]);
-	sve->vl = vls[0];
+		za->vl, vls[0]);
+	za->vl = vls[0];
 
 	fake_sigreturn(&sf, sizeof(sf), 0);
 
diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
index e2a452190511..e1ccf8f85a70 100644
--- a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
@@ -12,40 +12,22 @@
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 struct fake_sigframe sf;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sve_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SVE, 2);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SVE_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
+	if (!res)
+		return true;
 
-		vl &= PR_SVE_VL_LEN_MASK;
-
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least two VLs */
-	if (nvls < 2) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
+	if (res == KSFT_SKIP)
 		td->result = KSFT_SKIP;
-		return false;
-	}
 
-	return true;
+	return false;
 }
 
 static int fake_sigreturn_sve_change_vl(struct tdescr *td,
diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
index 3d37daafcff5..6dbe48cf8b09 100644
--- a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
@@ -6,51 +6,31 @@
  * set up as expected.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 64];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 1);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SME_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SME_VL_LEN_MASK;
-
-		/* Did we find the lowest supported VL? */
-		if (vq < sve_vq_from_vl(vl))
-			break;
+	if (!res)
+		return true;
 
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static void setup_ssve_regs(void)
diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
index 9dc5f128bbc0..5557e116e973 100644
--- a/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
@@ -6,51 +6,31 @@
  * signal frames is set up as expected when enabled simultaneously.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 128];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 1);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SME_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SME_VL_LEN_MASK;
-
-		/* Did we find the lowest supported VL? */
-		if (vq < sve_vq_from_vl(vl))
-			break;
+	if (!res)
+		return true;
 
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static void setup_regs(void)
diff --git a/tools/testing/selftests/arm64/signal/testcases/sve_regs.c b/tools/testing/selftests/arm64/signal/testcases/sve_regs.c
index 8b16eabbb769..8143eb1c58c1 100644
--- a/tools/testing/selftests/arm64/signal/testcases/sve_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/sve_regs.c
@@ -6,47 +6,31 @@
  * expected.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 64];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sve_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SVE, 1);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SVE_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SVE_VL_LEN_MASK;
-
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
+	if (!res)
+		return true;
 
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static void setup_sve_regs(void)
diff --git a/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c
index 4d6f94b6178f..ce26e9c2fa5e 100644
--- a/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c
@@ -6,47 +6,31 @@
  * expected.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 128];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 1);
 
-	/*
-	 * Enumerate up to SME_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SME_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SME_VL_LEN_MASK;
-
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
+	if (!res)
+		return true;
 
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
diff --git a/tools/testing/selftests/arm64/signal/testcases/za_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
index 174ad6656696..b9e13f27f1f9 100644
--- a/tools/testing/selftests/arm64/signal/testcases/za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
@@ -6,51 +6,31 @@
  * expected.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 128];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 1);
 
-	/*
-	 * Enumerate up to SME_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SME_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SME_VL_LEN_MASK;
-
-		/* Did we find the lowest supported VL? */
-		if (vq < sve_vq_from_vl(vl))
-			break;
+	if (!res)
+		return true;
 
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static void setup_za_regs(void)
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index dd49c1d23a60..88e8a316e768 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -427,23 +427,24 @@ $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
 # $1 - input .c file
 # $2 - output .o file
 # $3 - CFLAGS
+# $4 - binary name
 define CLANG_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
+	$(call msg,CLNG-BPF,$4,$2)
 	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v3 -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
+	$(call msg,CLNG-BPF,$4,$2)
 	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v2 -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
 define CLANG_CPUV4_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
+	$(call msg,CLNG-BPF,$4,$2)
 	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v4 -o $2
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
-	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
+	$(call msg,GCC-BPF,$4,$2)
 	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2
 endef
 
@@ -535,7 +536,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
 	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
 					  $(TRUNNER_BPF_CFLAGS)         \
 					  $$($$<-CFLAGS)		\
-					  $$($$<-$2-CFLAGS))
+					  $$($$<-$2-CFLAGS),$(TRUNNER_BINARY))
 
 $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
@@ -762,6 +763,8 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
+# Linking uprobe_multi can fail due to relocation overflows on mips.
+$(OUTPUT)/uprobe_multi: CFLAGS += $(if $(filter mips, $(ARCH)),-mxgot)
 $(OUTPUT)/uprobe_multi: uprobe_multi.c
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 627b74ae041b..90dc3aca32bd 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -10,6 +10,7 @@
 #include <sys/sysinfo.h>
 #include <signal.h>
 #include "bench.h"
+#include "bpf_util.h"
 #include "testing_helpers.h"
 
 struct env env = {
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index 68180d8f8558..005c401b3e22 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -10,6 +10,7 @@
 #include <math.h>
 #include <time.h>
 #include <sys/syscall.h>
+#include <limits.h>
 
 struct cpu_set {
 	bool *cpus;
diff --git a/tools/testing/selftests/bpf/map_tests/sk_storage_map.c b/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
index 18405c3b7cee..af10c309359a 100644
--- a/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
+++ b/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
@@ -412,7 +412,7 @@ static void test_sk_storage_map_stress_free(void)
 		rlim_new.rlim_max = rlim_new.rlim_cur + 128;
 		err = setrlimit(RLIMIT_NOFILE, &rlim_new);
 		CHECK(err, "setrlimit(RLIMIT_NOFILE)", "rlim_new:%lu errno:%d",
-		      rlim_new.rlim_cur, errno);
+		      (unsigned long) rlim_new.rlim_cur, errno);
 	}
 
 	err = do_sk_storage_map_stress_free();
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
index b52ff8ce34db..16bed9dd8e6a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
@@ -95,7 +95,7 @@ static unsigned short get_local_port(int fd)
 	struct sockaddr_in6 addr;
 	socklen_t addrlen = sizeof(addr);
 
-	if (!getsockname(fd, &addr, &addrlen))
+	if (!getsockname(fd, (struct sockaddr *)&addr, &addrlen))
 		return ntohs(addr.sin6_port);
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 47f42e680105..26019313e1fc 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <test_progs.h>
 #include "progs/core_reloc_types.h"
 #include "bpf_testmod/bpf_testmod.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
index b1a3a49a822a..42bd07f7218d 100644
--- a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
+++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
@@ -4,7 +4,6 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <net/if.h>
-#include <linux/in6.h>
 #include <linux/if_alg.h>
 
 #include "test_progs.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
index dcb9e5070cc3..d79f398ec6b7 100644
--- a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
+++ b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
@@ -4,7 +4,6 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <net/if.h>
-#include <linux/in6.h>
 
 #include "test_progs.h"
 #include "network_helpers.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 9e5f38739104..3171047414a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <test_progs.h>
 #include <network_helpers.h>
-#include <error.h>
 #include <linux/if_tun.h>
 #include <sys/uio.h>
 
diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
index c07991544a78..34f8822fd221 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <test_progs.h>
 #include <network_helpers.h>
 #include "kfree_skb.skel.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
index 835a1d756c16..b6e8d822e8e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
@@ -47,7 +47,6 @@
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
 #include <linux/if_tun.h>
-#include <linux/icmp.h>
 #include <arpa/inet.h>
 #include <unistd.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
index 03825d2b45a8..6c50c0f63f43 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
@@ -49,6 +49,7 @@
  *  is not crashed, it is considered successful.
  */
 #define NETNS "ns_lwt_reroute"
+#include <netinet/in.h>
 #include "lwt_helpers.h"
 #include "network_helpers.h"
 #include <linux/net_tstamp.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index e72d75d6baa7..c29787e092d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -11,7 +11,7 @@
 #include <sched.h>
 #include <sys/wait.h>
 #include <sys/mount.h>
-#include <sys/fcntl.h>
+#include <fcntl.h>
 #include "network_helpers.h"
 
 #define STACK_SIZE (1024 * 1024)
diff --git a/tools/testing/selftests/bpf/prog_tests/parse_tcp_hdr_opt.c b/tools/testing/selftests/bpf/prog_tests/parse_tcp_hdr_opt.c
index daa952711d8f..e9c07d561ded 100644
--- a/tools/testing/selftests/bpf/prog_tests/parse_tcp_hdr_opt.c
+++ b/tools/testing/selftests/bpf/prog_tests/parse_tcp_hdr_opt.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define _GNU_SOURCE
 #include <test_progs.h>
 #include <network_helpers.h>
 #include "test_parse_tcp_hdr_opt.skel.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index de2466547efe..a1ab0af00454 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -18,7 +18,6 @@
 #include <arpa/inet.h>
 #include <assert.h>
 #include <errno.h>
-#include <error.h>
 #include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index b1073d36d77a..a80a83e0440e 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -471,7 +471,7 @@ static int set_forwarding(bool enable)
 
 static int __rcv_tstamp(int fd, const char *expected, size_t s, __u64 *tstamp)
 {
-	struct __kernel_timespec pkt_ts = {};
+	struct timespec pkt_ts = {};
 	char ctl[CMSG_SPACE(sizeof(pkt_ts))];
 	struct timespec now_ts;
 	struct msghdr msg = {};
@@ -495,7 +495,7 @@ static int __rcv_tstamp(int fd, const char *expected, size_t s, __u64 *tstamp)
 
 	cmsg = CMSG_FIRSTHDR(&msg);
 	if (cmsg && cmsg->cmsg_level == SOL_SOCKET &&
-	    cmsg->cmsg_type == SO_TIMESTAMPNS_NEW)
+	    cmsg->cmsg_type == SO_TIMESTAMPNS)
 		memcpy(&pkt_ts, CMSG_DATA(cmsg), sizeof(pkt_ts));
 
 	pkt_ns = pkt_ts.tv_sec * NSEC_PER_SEC + pkt_ts.tv_nsec;
@@ -537,9 +537,9 @@ static int wait_netstamp_needed_key(void)
 	if (!ASSERT_GE(srv_fd, 0, "start_server"))
 		goto done;
 
-	err = setsockopt(srv_fd, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
+	err = setsockopt(srv_fd, SOL_SOCKET, SO_TIMESTAMPNS,
 			 &opt, sizeof(opt));
-	if (!ASSERT_OK(err, "setsockopt(SO_TIMESTAMPNS_NEW)"))
+	if (!ASSERT_OK(err, "setsockopt(SO_TIMESTAMPNS)"))
 		goto done;
 
 	cli_fd = connect_to_fd(srv_fd, TIMEOUT_MILLIS);
@@ -621,9 +621,9 @@ static void test_inet_dtime(int family, int type, const char *addr, __u16 port)
 		return;
 
 	/* Ensure the kernel puts the (rcv) timestamp for all skb */
-	err = setsockopt(listen_fd, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
+	err = setsockopt(listen_fd, SOL_SOCKET, SO_TIMESTAMPNS,
 			 &opt, sizeof(opt));
-	if (!ASSERT_OK(err, "setsockopt(SO_TIMESTAMPNS_NEW)"))
+	if (!ASSERT_OK(err, "setsockopt(SO_TIMESTAMPNS)"))
 		goto done;
 
 	if (type == SOCK_STREAM) {
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
index f2b99d95d916..c38784c1c066 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
index e51721df14fc..dfff6feac12c 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -4,6 +4,7 @@
 #define _GNU_SOURCE
 #include <linux/compiler.h>
 #include <linux/ring_buffer.h>
+#include <linux/build_bug.h>
 #include <pthread.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index fb2f5513e29e..20541a7cd807 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -2,14 +2,17 @@
 #ifndef __BPF_MISC_H__
 #define __BPF_MISC_H__
 
+#define XSTR(s) STR(s)
+#define STR(s) #s
+
 /* This set of attributes controls behavior of the
  * test_loader.c:test_loader__run_subtests().
  *
  * The test_loader sequentially loads each program in a skeleton.
  * Programs could be loaded in privileged and unprivileged modes.
- * - __success, __failure, __msg imply privileged mode;
- * - __success_unpriv, __failure_unpriv, __msg_unpriv imply
- *   unprivileged mode.
+ * - __success, __failure, __msg, __regex imply privileged mode;
+ * - __success_unpriv, __failure_unpriv, __msg_unpriv, __regex_unpriv
+ *   imply unprivileged mode.
  * If combination of privileged and unprivileged attributes is present
  * both modes are used. If none are present privileged mode is implied.
  *
@@ -24,6 +27,12 @@
  *                   Multiple __msg attributes could be specified.
  * __msg_unpriv      Same as __msg but for unprivileged mode.
  *
+ * __regex           Same as __msg, but using a regular expression.
+ * __regex_unpriv    Same as __msg_unpriv but using a regular expression.
+ * __xlated          Expect a line in a disassembly log after verifier applies rewrites.
+ *                   Multiple __xlated attributes could be specified.
+ * __xlated_unpriv   Same as __xlated but for unprivileged mode.
+ *
  * __success         Expect program load success in privileged mode.
  * __success_unpriv  Expect program load success in unprivileged mode.
  *
@@ -57,12 +66,20 @@
  * __auxiliary         Annotated program is not a separate test, but used as auxiliary
  *                     for some other test cases and should always be loaded.
  * __auxiliary_unpriv  Same, but load program in unprivileged mode.
+ *
+ * __arch_*          Specify on which architecture the test case should be tested.
+ *                   Several __arch_* annotations could be specified at once.
+ *                   When test case is not run on current arch it is marked as skipped.
  */
-#define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
+#define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" XSTR(__COUNTER__) "=" msg)))
+#define __regex(regex)		__attribute__((btf_decl_tag("comment:test_expect_regex=" XSTR(__COUNTER__) "=" regex)))
+#define __xlated(msg)		__attribute__((btf_decl_tag("comment:test_expect_xlated=" XSTR(__COUNTER__) "=" msg)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
-#define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
+#define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
+#define __regex_unpriv(regex)	__attribute__((btf_decl_tag("comment:test_expect_regex_unpriv=" XSTR(__COUNTER__) "=" regex)))
+#define __xlated_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
@@ -72,6 +89,10 @@
 #define __auxiliary		__attribute__((btf_decl_tag("comment:test_auxiliary")))
 #define __auxiliary_unpriv	__attribute__((btf_decl_tag("comment:test_auxiliary_unpriv")))
 #define __btf_path(path)	__attribute__((btf_decl_tag("comment:test_btf_path=" path)))
+#define __arch(arch)		__attribute__((btf_decl_tag("comment:test_arch=" arch)))
+#define __arch_x86_64		__arch("X86_64")
+#define __arch_arm64		__arch("ARM64")
+#define __arch_riscv64		__arch("RISCV64")
 
 /* Convenience macro for use with 'asm volatile' blocks */
 #define __naked __attribute__((naked))
diff --git a/tools/testing/selftests/bpf/progs/cg_storage_multi.h b/tools/testing/selftests/bpf/progs/cg_storage_multi.h
index a0778fe7857a..41d59f0ee606 100644
--- a/tools/testing/selftests/bpf/progs/cg_storage_multi.h
+++ b/tools/testing/selftests/bpf/progs/cg_storage_multi.h
@@ -3,8 +3,6 @@
 #ifndef __PROGS_CG_STORAGE_MULTI_H
 #define __PROGS_CG_STORAGE_MULTI_H
 
-#include <asm/types.h>
-
 struct cgroup_value {
 	__u32 egress_pkts;
 	__u32 ingress_pkts;
diff --git a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
index f5ac5f3e8919..568816307f71 100644
--- a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
+++ b/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
@@ -31,6 +31,7 @@ int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
 
 	if (fmode & FMODE_WRITE)
 		return -EACCES;
+	barrier();
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 85e48069c9e6..d4b99c3b4719 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1213,10 +1213,10 @@ __success  __log_level(2)
  * - once for path entry - label 2;
  * - once for path entry - label 1 - label 2.
  */
-__msg("r1 = *(u64 *)(r10 -8)")
-__msg("exit")
-__msg("r1 = *(u64 *)(r10 -8)")
-__msg("exit")
+__msg("8: (79) r1 = *(u64 *)(r10 -8)")
+__msg("9: (95) exit")
+__msg("from 2 to 7")
+__msg("8: safe")
 __msg("processed 11 insns")
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void old_stack_misc_vs_cur_ctx_ptr(void)
diff --git a/tools/testing/selftests/bpf/test_cpp.cpp b/tools/testing/selftests/bpf/test_cpp.cpp
index dde0bb16e782..abc2a56ab261 100644
--- a/tools/testing/selftests/bpf/test_cpp.cpp
+++ b/tools/testing/selftests/bpf/test_cpp.cpp
@@ -6,6 +6,10 @@
 #include <bpf/libbpf.h>
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
+
+#ifndef _Bool
+#define _Bool bool
+#endif
 #include "test_core_extern.skel.h"
 #include "struct_ops_module.skel.h"
 
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 524c38e9cde4..2150e9c9b53f 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -2,10 +2,12 @@
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
 #include <linux/capability.h>
 #include <stdlib.h>
+#include <regex.h>
 #include <test_progs.h>
 #include <bpf/btf.h>
 
 #include "autoconf_helper.h"
+#include "disasm_helpers.h"
 #include "unpriv_helpers.h"
 #include "cap_helpers.h"
 
@@ -17,9 +19,13 @@
 #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
+#define TEST_TAG_EXPECT_REGEX_PFX "comment:test_expect_regex="
+#define TEST_TAG_EXPECT_XLATED_PFX "comment:test_expect_xlated="
 #define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
 #define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
 #define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
+#define TEST_TAG_EXPECT_REGEX_PFX_UNPRIV "comment:test_expect_regex_unpriv="
+#define TEST_TAG_EXPECT_XLATED_PFX_UNPRIV "comment:test_expect_xlated_unpriv="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
 #define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
@@ -28,6 +34,7 @@
 #define TEST_TAG_AUXILIARY "comment:test_auxiliary"
 #define TEST_TAG_AUXILIARY_UNPRIV "comment:test_auxiliary_unpriv"
 #define TEST_BTF_PATH "comment:test_btf_path="
+#define TEST_TAG_ARCH "comment:test_arch="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xcafe4all
@@ -46,11 +53,22 @@ enum mode {
 	UNPRIV = 2
 };
 
+struct expect_msg {
+	const char *substr; /* substring match */
+	const char *regex_str; /* regex-based match */
+	regex_t regex;
+};
+
+struct expected_msgs {
+	struct expect_msg *patterns;
+	size_t cnt;
+};
+
 struct test_subspec {
 	char *name;
 	bool expect_failure;
-	const char **expect_msgs;
-	size_t expect_msg_cnt;
+	struct expected_msgs expect_msgs;
+	struct expected_msgs expect_xlated;
 	int retval;
 	bool execute;
 };
@@ -63,6 +81,7 @@ struct test_spec {
 	int log_level;
 	int prog_flags;
 	int mode_mask;
+	int arch_mask;
 	bool auxiliary;
 	bool valid;
 };
@@ -87,31 +106,64 @@ void test_loader_fini(struct test_loader *tester)
 	free(tester->log_buf);
 }
 
+static void free_msgs(struct expected_msgs *msgs)
+{
+	int i;
+
+	for (i = 0; i < msgs->cnt; i++)
+		if (msgs->patterns[i].regex_str)
+			regfree(&msgs->patterns[i].regex);
+	free(msgs->patterns);
+	msgs->patterns = NULL;
+	msgs->cnt = 0;
+}
+
 static void free_test_spec(struct test_spec *spec)
 {
+	/* Deallocate expect_msgs arrays. */
+	free_msgs(&spec->priv.expect_msgs);
+	free_msgs(&spec->unpriv.expect_msgs);
+	free_msgs(&spec->priv.expect_xlated);
+	free_msgs(&spec->unpriv.expect_xlated);
+
 	free(spec->priv.name);
 	free(spec->unpriv.name);
-	free(spec->priv.expect_msgs);
-	free(spec->unpriv.expect_msgs);
-
 	spec->priv.name = NULL;
 	spec->unpriv.name = NULL;
-	spec->priv.expect_msgs = NULL;
-	spec->unpriv.expect_msgs = NULL;
 }
 
-static int push_msg(const char *msg, struct test_subspec *subspec)
+static int push_msg(const char *substr, const char *regex_str, struct expected_msgs *msgs)
 {
 	void *tmp;
+	int regcomp_res;
+	char error_msg[100];
+	struct expect_msg *msg;
 
-	tmp = realloc(subspec->expect_msgs, (1 + subspec->expect_msg_cnt) * sizeof(void *));
+	tmp = realloc(msgs->patterns,
+		      (1 + msgs->cnt) * sizeof(struct expect_msg));
 	if (!tmp) {
 		ASSERT_FAIL("failed to realloc memory for messages\n");
 		return -ENOMEM;
 	}
-	subspec->expect_msgs = tmp;
-	subspec->expect_msgs[subspec->expect_msg_cnt++] = msg;
+	msgs->patterns = tmp;
+	msg = &msgs->patterns[msgs->cnt];
+
+	if (substr) {
+		msg->substr = substr;
+		msg->regex_str = NULL;
+	} else {
+		msg->regex_str = regex_str;
+		msg->substr = NULL;
+		regcomp_res = regcomp(&msg->regex, regex_str, REG_EXTENDED|REG_NEWLINE);
+		if (regcomp_res != 0) {
+			regerror(regcomp_res, &msg->regex, error_msg, sizeof(error_msg));
+			PRINT_FAIL("Regexp compilation error in '%s': '%s'\n",
+				   regex_str, error_msg);
+			return -EINVAL;
+		}
+	}
 
+	msgs->cnt += 1;
 	return 0;
 }
 
@@ -163,6 +215,41 @@ static void update_flags(int *flags, int flag, bool clear)
 		*flags |= flag;
 }
 
+/* Matches a string of form '<pfx>[^=]=.*' and returns it's suffix.
+ * Used to parse btf_decl_tag values.
+ * Such values require unique prefix because compiler does not add
+ * same __attribute__((btf_decl_tag(...))) twice.
+ * Test suite uses two-component tags for such cases:
+ *
+ *   <pfx> __COUNTER__ '='
+ *
+ * For example, two consecutive __msg tags '__msg("foo") __msg("foo")'
+ * would be encoded as:
+ *
+ *   [18] DECL_TAG 'comment:test_expect_msg=0=foo' type_id=15 component_idx=-1
+ *   [19] DECL_TAG 'comment:test_expect_msg=1=foo' type_id=15 component_idx=-1
+ *
+ * And the purpose of this function is to extract 'foo' from the above.
+ */
+static const char *skip_dynamic_pfx(const char *s, const char *pfx)
+{
+	const char *msg;
+
+	if (strncmp(s, pfx, strlen(pfx)) != 0)
+		return NULL;
+	msg = s + strlen(pfx);
+	msg = strchr(msg, '=');
+	if (!msg)
+		return NULL;
+	return msg + 1;
+}
+
+enum arch {
+	ARCH_X86_64	= 0x1,
+	ARCH_ARM64	= 0x2,
+	ARCH_RISCV64	= 0x4,
+};
+
 /* Uses btf_decl_tag attributes to describe the expected test
  * behavior, see bpf_misc.h for detailed description of each attribute
  * and attribute combinations.
@@ -176,6 +263,7 @@ static int parse_test_spec(struct test_loader *tester,
 	bool has_unpriv_result = false;
 	bool has_unpriv_retval = false;
 	int func_id, i, err = 0;
+	u32 arch_mask = 0;
 	struct btf *btf;
 
 	memset(spec, 0, sizeof(*spec));
@@ -231,15 +319,33 @@ static int parse_test_spec(struct test_loader *tester,
 		} else if (strcmp(s, TEST_TAG_AUXILIARY_UNPRIV) == 0) {
 			spec->auxiliary = true;
 			spec->mode_mask |= UNPRIV;
-		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
-			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
-			err = push_msg(msg, &spec->priv);
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX))) {
+			err = push_msg(msg, NULL, &spec->priv.expect_msgs);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV))) {
+			err = push_msg(msg, NULL, &spec->unpriv.expect_msgs);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_REGEX_PFX))) {
+			err = push_msg(NULL, msg, &spec->priv.expect_msgs);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_REGEX_PFX_UNPRIV))) {
+			err = push_msg(NULL, msg, &spec->unpriv.expect_msgs);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX))) {
+			err = push_msg(msg, NULL, &spec->priv.expect_xlated);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
-		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV)) {
-			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX_UNPRIV) - 1;
-			err = push_msg(msg, &spec->unpriv);
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV))) {
+			err = push_msg(msg, NULL, &spec->unpriv.expect_xlated);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
@@ -290,11 +396,26 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 				update_flags(&spec->prog_flags, flags, clear);
 			}
+		} else if (str_has_pfx(s, TEST_TAG_ARCH)) {
+			val = s + sizeof(TEST_TAG_ARCH) - 1;
+			if (strcmp(val, "X86_64") == 0) {
+				arch_mask |= ARCH_X86_64;
+			} else if (strcmp(val, "ARM64") == 0) {
+				arch_mask |= ARCH_ARM64;
+			} else if (strcmp(val, "RISCV64") == 0) {
+				arch_mask |= ARCH_RISCV64;
+			} else {
+				PRINT_FAIL("bad arch spec: '%s'", val);
+				err = -EINVAL;
+				goto cleanup;
+			}
 		} else if (str_has_pfx(s, TEST_BTF_PATH)) {
 			spec->btf_custom_path = s + sizeof(TEST_BTF_PATH) - 1;
 		}
 	}
 
+	spec->arch_mask = arch_mask;
+
 	if (spec->mode_mask == 0)
 		spec->mode_mask = PRIV;
 
@@ -336,17 +457,25 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->unpriv.execute = spec->priv.execute;
 		}
 
-		if (!spec->unpriv.expect_msgs) {
-			size_t sz = spec->priv.expect_msg_cnt * sizeof(void *);
+		if (spec->unpriv.expect_msgs.cnt == 0) {
+			for (i = 0; i < spec->priv.expect_msgs.cnt; i++) {
+				struct expect_msg *msg = &spec->priv.expect_msgs.patterns[i];
 
-			spec->unpriv.expect_msgs = malloc(sz);
-			if (!spec->unpriv.expect_msgs) {
-				PRINT_FAIL("failed to allocate memory for unpriv.expect_msgs\n");
-				err = -ENOMEM;
-				goto cleanup;
+				err = push_msg(msg->substr, msg->regex_str,
+					       &spec->unpriv.expect_msgs);
+				if (err)
+					goto cleanup;
+			}
+		}
+		if (spec->unpriv.expect_xlated.cnt == 0) {
+			for (i = 0; i < spec->priv.expect_xlated.cnt; i++) {
+				struct expect_msg *msg = &spec->priv.expect_xlated.patterns[i];
+
+				err = push_msg(msg->substr, msg->regex_str,
+					       &spec->unpriv.expect_xlated);
+				if (err)
+					goto cleanup;
 			}
-			memcpy(spec->unpriv.expect_msgs, spec->priv.expect_msgs, sz);
-			spec->unpriv.expect_msg_cnt = spec->priv.expect_msg_cnt;
 		}
 	}
 
@@ -386,7 +515,6 @@ static void prepare_case(struct test_loader *tester,
 	bpf_program__set_flags(prog, prog_flags | spec->prog_flags);
 
 	tester->log_buf[0] = '\0';
-	tester->next_match_pos = 0;
 }
 
 static void emit_verifier_log(const char *log_buf, bool force)
@@ -396,33 +524,48 @@ static void emit_verifier_log(const char *log_buf, bool force)
 	fprintf(stdout, "VERIFIER LOG:\n=============\n%s=============\n", log_buf);
 }
 
-static void validate_case(struct test_loader *tester,
-			  struct test_subspec *subspec,
-			  struct bpf_object *obj,
-			  struct bpf_program *prog,
-			  int load_err)
+static void emit_xlated(const char *xlated, bool force)
 {
-	int i, j;
-
-	for (i = 0; i < subspec->expect_msg_cnt; i++) {
-		char *match;
-		const char *expect_msg;
+	if (!force && env.verbosity == VERBOSE_NONE)
+		return;
+	fprintf(stdout, "XLATED:\n=============\n%s=============\n", xlated);
+}
 
-		expect_msg = subspec->expect_msgs[i];
+static void validate_msgs(char *log_buf, struct expected_msgs *msgs,
+			  void (*emit_fn)(const char *buf, bool force))
+{
+	regmatch_t reg_match[1];
+	const char *log = log_buf;
+	int i, j, err;
+
+	for (i = 0; i < msgs->cnt; i++) {
+		struct expect_msg *msg = &msgs->patterns[i];
+		const char *match = NULL;
+
+		if (msg->substr) {
+			match = strstr(log, msg->substr);
+			if (match)
+				log = match + strlen(msg->substr);
+		} else {
+			err = regexec(&msg->regex, log, 1, reg_match, 0);
+			if (err == 0) {
+				match = log + reg_match[0].rm_so;
+				log += reg_match[0].rm_eo;
+			}
+		}
 
-		match = strstr(tester->log_buf + tester->next_match_pos, expect_msg);
 		if (!ASSERT_OK_PTR(match, "expect_msg")) {
-			/* if we are in verbose mode, we've already emitted log */
 			if (env.verbosity == VERBOSE_NONE)
-				emit_verifier_log(tester->log_buf, true /*force*/);
-			for (j = 0; j < i; j++)
-				fprintf(stderr,
-					"MATCHED  MSG: '%s'\n", subspec->expect_msgs[j]);
-			fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
+				emit_fn(log_buf, true /*force*/);
+			for (j = 0; j <= i; j++) {
+				msg = &msgs->patterns[j];
+				fprintf(stderr, "%s %s: '%s'\n",
+					j < i ? "MATCHED " : "EXPECTED",
+					msg->substr ? "SUBSTR" : " REGEX",
+					msg->substr ?: msg->regex_str);
+			}
 			return;
 		}
-
-		tester->next_match_pos = match - tester->log_buf + strlen(expect_msg);
 	}
 }
 
@@ -550,6 +693,51 @@ static bool should_do_test_run(struct test_spec *spec, struct test_subspec *subs
 	return true;
 }
 
+/* Get a disassembly of BPF program after verifier applies all rewrites */
+static int get_xlated_program_text(int prog_fd, char *text, size_t text_sz)
+{
+	struct bpf_insn *insn_start = NULL, *insn, *insn_end;
+	__u32 insns_cnt = 0, i;
+	char buf[64];
+	FILE *out = NULL;
+	int err;
+
+	err = get_xlated_program(prog_fd, &insn_start, &insns_cnt);
+	if (!ASSERT_OK(err, "get_xlated_program"))
+		goto out;
+	out = fmemopen(text, text_sz, "w");
+	if (!ASSERT_OK_PTR(out, "open_memstream"))
+		goto out;
+	insn_end = insn_start + insns_cnt;
+	insn = insn_start;
+	while (insn < insn_end) {
+		i = insn - insn_start;
+		insn = disasm_insn(insn, buf, sizeof(buf));
+		fprintf(out, "%d: %s\n", i, buf);
+	}
+	fflush(out);
+
+out:
+	free(insn_start);
+	if (out)
+		fclose(out);
+	return err;
+}
+
+static bool run_on_current_arch(int arch_mask)
+{
+	if (arch_mask == 0)
+		return true;
+#if defined(__x86_64__)
+	return arch_mask & ARCH_X86_64;
+#elif defined(__aarch64__)
+	return arch_mask & ARCH_ARM64;
+#elif defined(__riscv) && __riscv_xlen == 64
+	return arch_mask & ARCH_RISCV64;
+#endif
+	return false;
+}
+
 /* this function is forced noinline and has short generic name to look better
  * in test_progs output (in case of a failure)
  */
@@ -574,6 +762,11 @@ void run_subtest(struct test_loader *tester,
 	if (!test__start_subtest(subspec->name))
 		return;
 
+	if (!run_on_current_arch(spec->arch_mask)) {
+		test__skip();
+		return;
+	}
+
 	if (unpriv) {
 		if (!can_execute_unpriv(tester, spec)) {
 			test__skip();
@@ -634,9 +827,17 @@ void run_subtest(struct test_loader *tester,
 			goto tobj_cleanup;
 		}
 	}
-
 	emit_verifier_log(tester->log_buf, false /*force*/);
-	validate_case(tester, subspec, tobj, tprog, err);
+	validate_msgs(tester->log_buf, &subspec->expect_msgs, emit_verifier_log);
+
+	if (subspec->expect_xlated.cnt) {
+		err = get_xlated_program_text(bpf_program__fd(tprog),
+					      tester->log_buf, tester->log_buf_sz);
+		if (err)
+			goto tobj_cleanup;
+		emit_xlated(tester->log_buf, false /*force*/);
+		validate_msgs(tester->log_buf, &subspec->expect_xlated, emit_xlated);
+	}
 
 	if (should_do_test_run(spec, subspec)) {
 		/* For some reason test_verifier executes programs
diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index 4d0650cfb5cd..fda7589c5023 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -126,7 +126,8 @@ static int sched_next_online(int pid, int *next_to_try)
 
 	while (next < nr_cpus) {
 		CPU_ZERO(&cpuset);
-		CPU_SET(next++, &cpuset);
+		CPU_SET(next, &cpuset);
+		next++;
 		if (!sched_setaffinity(pid, sizeof(cpuset), &cpuset)) {
 			ret = 0;
 			break;
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 89ff704e9dad..d5d0cb4eb197 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -10,7 +10,6 @@
 #include <sched.h>
 #include <signal.h>
 #include <string.h>
-#include <execinfo.h> /* backtrace */
 #include <sys/sysinfo.h> /* get_nprocs */
 #include <netinet/in.h>
 #include <sys/select.h>
@@ -19,6 +18,21 @@
 #include <bpf/btf.h>
 #include "json_writer.h"
 
+#ifdef __GLIBC__
+#include <execinfo.h> /* backtrace */
+#endif
+
+/* Default backtrace funcs if missing at link */
+__weak int backtrace(void **buffer, int size)
+{
+	return 0;
+}
+
+__weak void backtrace_symbols_fd(void *const *buffer, int size, int fd)
+{
+	dprintf(fd, "<backtrace not supported>\n");
+}
+
 static bool verbose(void)
 {
 	return env.verbosity > VERBOSE_NONE;
@@ -1731,7 +1745,7 @@ int main(int argc, char **argv)
 	/* launch workers if requested */
 	env.worker_id = -1; /* main process */
 	if (env.workers) {
-		env.worker_pids = calloc(sizeof(__pid_t), env.workers);
+		env.worker_pids = calloc(sizeof(pid_t), env.workers);
 		env.worker_socks = calloc(sizeof(int), env.workers);
 		if (env.debug)
 			fprintf(stdout, "Launching %d workers.\n", env.workers);
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 0ba5a20b19ba..8e997de596db 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -438,7 +438,6 @@ typedef int (*pre_execution_cb)(struct bpf_object *obj);
 struct test_loader {
 	char *log_buf;
 	size_t log_buf_sz;
-	size_t next_match_pos;
 	pre_execution_cb pre_execution_cb;
 
 	struct bpf_object *obj;
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index d5379a0e6da8..680e452583a7 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -220,13 +220,13 @@ int parse_test_list(const char *s,
 		    bool is_glob_pattern)
 {
 	char *input, *state = NULL, *test_spec;
-	int err = 0;
+	int err = 0, cnt = 0;
 
 	input = strdup(s);
 	if (!input)
 		return -ENOMEM;
 
-	while ((test_spec = strtok_r(state ? NULL : input, ",", &state))) {
+	while ((test_spec = strtok_r(cnt++ ? NULL : input, ",", &state))) {
 		err = insert_test(set, test_spec, is_glob_pattern);
 		if (err)
 			break;
@@ -451,7 +451,7 @@ int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt)
 
 	*cnt = xlated_prog_len / buf_element_size;
 	*buf = calloc(*cnt, buf_element_size);
-	if (!buf) {
+	if (!*buf) {
 		perror("can't allocate xlated program buffer");
 		return -ENOMEM;
 	}
diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index b6d016461fb0..220f6a963813 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -2,7 +2,6 @@
 
 #include <stdbool.h>
 #include <stdlib.h>
-#include <error.h>
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index b2854238d4a0..fd9780082ff4 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -784,13 +784,13 @@ static int parse_stat(const char *stat_name, struct stat_specs *specs)
 static int parse_stats(const char *stats_str, struct stat_specs *specs)
 {
 	char *input, *state = NULL, *next;
-	int err;
+	int err, cnt = 0;
 
 	input = strdup(stats_str);
 	if (!input)
 		return -ENOMEM;
 
-	while ((next = strtok_r(state ? NULL : input, ",", &state))) {
+	while ((next = strtok_r(cnt++ ? NULL : input, ",", &state))) {
 		err = parse_stat(next, specs);
 		if (err) {
 			free(input);
@@ -1493,7 +1493,7 @@ static int parse_stats_csv(const char *filename, struct stat_specs *specs,
 	while (fgets(line, sizeof(line), f)) {
 		char *input = line, *state = NULL, *next;
 		struct verif_stats *st = NULL;
-		int col = 0;
+		int col = 0, cnt = 0;
 
 		if (!header) {
 			void *tmp;
@@ -1511,7 +1511,7 @@ static int parse_stats_csv(const char *filename, struct stat_specs *specs,
 			*stat_cntp += 1;
 		}
 
-		while ((next = strtok_r(state ? NULL : input, ",\n", &state))) {
+		while ((next = strtok_r(cnt++ ? NULL : input, ",\n", &state))) {
 			if (header) {
 				/* for the first line, set up spec stats */
 				err = parse_stat(next, specs);
diff --git a/tools/testing/selftests/dt/test_unprobed_devices.sh b/tools/testing/selftests/dt/test_unprobed_devices.sh
index 2d7e70c5ad2d..5e3f42ef249e 100755
--- a/tools/testing/selftests/dt/test_unprobed_devices.sh
+++ b/tools/testing/selftests/dt/test_unprobed_devices.sh
@@ -34,8 +34,21 @@ nodes_compatible=$(
 		# Check if node is available
 		if [[ -e "${node}"/status ]]; then
 			status=$(tr -d '\000' < "${node}"/status)
-			[[ "${status}" != "okay" && "${status}" != "ok" ]] && continue
+			if [[ "${status}" != "okay" && "${status}" != "ok" ]]; then
+				if [ -n "${disabled_nodes_regex}" ]; then
+					disabled_nodes_regex="${disabled_nodes_regex}|${node}"
+				else
+					disabled_nodes_regex="${node}"
+				fi
+				continue
+			fi
 		fi
+
+		# Ignore this node if one of its ancestors was disabled
+		if [ -n "${disabled_nodes_regex}" ]; then
+			echo "${node}" | grep -q -E "${disabled_nodes_regex}" && continue
+		fi
+
 		echo "${node}" | sed -e 's|\/proc\/device-tree||'
 	done | sort
 	)
diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
index c45094d1e1d2..803efd7b56c7 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
@@ -6,6 +6,18 @@ original_group=`stat -c "%g" .`
 original_owner=`stat -c "%u" .`
 
 mount_point=`stat -c '%m' .`
+
+# If stat -c '%m' does not work (e.g. busybox) or failed, try to use the
+# current working directory (which should be a tracefs) as the mount point.
+if [ ! -d "$mount_point" ]; then
+	if mount | grep -qw $PWD ; then
+		mount_point=$PWD
+	else
+		# If PWD doesn't work, that is an environmental problem.
+		exit_unresolved
+	fi
+fi
+
 mount_options=`mount | grep "$mount_point" | sed -e 's/.*(\(.*\)).*/\1/'`
 
 # find another owner and group that is not the original
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
index 073a748b9380..263f6b798c85 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
@@ -19,7 +19,14 @@ fail() { # mesg
 
 FILTER=set_ftrace_filter
 FUNC1="schedule"
-FUNC2="sched_tick"
+if grep '^sched_tick\b' available_filter_functions; then
+    FUNC2="sched_tick"
+elif grep '^scheduler_tick\b' available_filter_functions; then
+    FUNC2="scheduler_tick"
+else
+    exit_unresolved
+fi
+
 
 ALL_FUNCS="#### all functions enabled ####"
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
index e21c9c27ece4..77f4c07cdcb8 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event char type argument
-# requires: kprobe_events
+# requires: kprobe_events available_filter_functions
 
 case `uname -m` in
 x86_64)
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index 93217d459556..39001073f7ed 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event string type argument
-# requires: kprobe_events
+# requires: kprobe_events available_filter_functions
 
 case `uname -m` in
 x86_64)
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 76c2a6945d3e..f9214e7cdd13 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -61,6 +61,7 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #endif
 
+#if defined(__i386__) || defined(__x86_64__) /* arch */
 /*
  * gcc cpuid.h provides __cpuid_count() since v4.4.
  * Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
@@ -75,6 +76,7 @@
 			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
 			      : "0" (level), "2" (count))
 #endif
+#endif /* end arch */
 
 /* define kselftest exit codes */
 #define KSFT_PASS  0
diff --git a/tools/testing/selftests/net/netfilter/ipvs.sh b/tools/testing/selftests/net/netfilter/ipvs.sh
index 4ceee9fb3949..d3edb16cd4b3 100755
--- a/tools/testing/selftests/net/netfilter/ipvs.sh
+++ b/tools/testing/selftests/net/netfilter/ipvs.sh
@@ -97,7 +97,7 @@ cleanup() {
 }
 
 server_listen() {
-	ip netns exec "$ns2" socat -u -4 TCP-LISTEN:8080,reuseaddr STDOUT > "${outfile}" &
+	ip netns exec "$ns2" timeout 5 socat -u -4 TCP-LISTEN:8080,reuseaddr STDOUT > "${outfile}" &
 	server_pid=$!
 	sleep 0.2
 }
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 55315ed695f4..18565f02163e 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -293,12 +293,12 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 
 static bool arch_supports_noncont_cat(const struct resctrl_test *test)
 {
-	unsigned int eax, ebx, ecx, edx;
-
 	/* AMD always supports non-contiguous CBM. */
 	if (get_vendor() == ARCH_AMD)
 		return true;
 
+#if defined(__i386__) || defined(__x86_64__) /* arch */
+	unsigned int eax, ebx, ecx, edx;
 	/* Intel support for non-contiguous CBM needs to be discovered. */
 	if (!strcmp(test->resource, "L3"))
 		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
@@ -308,6 +308,9 @@ static bool arch_supports_noncont_cat(const struct resctrl_test *test)
 		return false;
 
 	return ((ecx >> 3) & 1);
+#endif /* end arch */
+
+	return false;
 }
 
 static int noncont_cat_run_test(const struct resctrl_test *test,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1192942aef91..3163bcf8148a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5500,6 +5500,7 @@ __visible bool kvm_rebooting;
 EXPORT_SYMBOL_GPL(kvm_rebooting);
 
 static DEFINE_PER_CPU(bool, hardware_enabled);
+static DEFINE_MUTEX(kvm_usage_lock);
 static int kvm_usage_count;
 
 static int __hardware_enable_nolock(void)
@@ -5532,10 +5533,10 @@ static int kvm_online_cpu(unsigned int cpu)
 	 * be enabled. Otherwise running VMs would encounter unrecoverable
 	 * errors when scheduled to this CPU.
 	 */
-	mutex_lock(&kvm_lock);
+	mutex_lock(&kvm_usage_lock);
 	if (kvm_usage_count)
 		ret = __hardware_enable_nolock();
-	mutex_unlock(&kvm_lock);
+	mutex_unlock(&kvm_usage_lock);
 	return ret;
 }
 
@@ -5555,10 +5556,10 @@ static void hardware_disable_nolock(void *junk)
 
 static int kvm_offline_cpu(unsigned int cpu)
 {
-	mutex_lock(&kvm_lock);
+	mutex_lock(&kvm_usage_lock);
 	if (kvm_usage_count)
 		hardware_disable_nolock(NULL);
-	mutex_unlock(&kvm_lock);
+	mutex_unlock(&kvm_usage_lock);
 	return 0;
 }
 
@@ -5574,9 +5575,9 @@ static void hardware_disable_all_nolock(void)
 static void hardware_disable_all(void)
 {
 	cpus_read_lock();
-	mutex_lock(&kvm_lock);
+	mutex_lock(&kvm_usage_lock);
 	hardware_disable_all_nolock();
-	mutex_unlock(&kvm_lock);
+	mutex_unlock(&kvm_usage_lock);
 	cpus_read_unlock();
 }
 
@@ -5607,7 +5608,7 @@ static int hardware_enable_all(void)
 	 * enable hardware multiple times.
 	 */
 	cpus_read_lock();
-	mutex_lock(&kvm_lock);
+	mutex_lock(&kvm_usage_lock);
 
 	r = 0;
 
@@ -5621,7 +5622,7 @@ static int hardware_enable_all(void)
 		}
 	}
 
-	mutex_unlock(&kvm_lock);
+	mutex_unlock(&kvm_usage_lock);
 	cpus_read_unlock();
 
 	return r;
@@ -5649,13 +5650,13 @@ static int kvm_suspend(void)
 {
 	/*
 	 * Secondary CPUs and CPU hotplug are disabled across the suspend/resume
-	 * callbacks, i.e. no need to acquire kvm_lock to ensure the usage count
-	 * is stable.  Assert that kvm_lock is not held to ensure the system
-	 * isn't suspended while KVM is enabling hardware.  Hardware enabling
-	 * can be preempted, but the task cannot be frozen until it has dropped
-	 * all locks (userspace tasks are frozen via a fake signal).
+	 * callbacks, i.e. no need to acquire kvm_usage_lock to ensure the usage
+	 * count is stable.  Assert that kvm_usage_lock is not held to ensure
+	 * the system isn't suspended while KVM is enabling hardware.  Hardware
+	 * enabling can be preempted, but the task cannot be frozen until it has
+	 * dropped all locks (userspace tasks are frozen via a fake signal).
 	 */
-	lockdep_assert_not_held(&kvm_lock);
+	lockdep_assert_not_held(&kvm_usage_lock);
 	lockdep_assert_irqs_disabled();
 
 	if (kvm_usage_count)
@@ -5665,7 +5666,7 @@ static int kvm_suspend(void)
 
 static void kvm_resume(void)
 {
-	lockdep_assert_not_held(&kvm_lock);
+	lockdep_assert_not_held(&kvm_usage_lock);
 	lockdep_assert_irqs_disabled();
 
 	if (kvm_usage_count)

