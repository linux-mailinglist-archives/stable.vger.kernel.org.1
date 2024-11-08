Return-Path: <stable+bounces-91954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD8A9C2166
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 17:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE2F284B01
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A942C191F60;
	Fri,  8 Nov 2024 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gXmtUxVV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC12E187FE4;
	Fri,  8 Nov 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081614; cv=none; b=O3iFk/lFICTQT7RpkVhnREzooiv4/CJO/RMK6zwE29V7VQgEt8QvpyjWh6HNKQcsbFC/DK9lacPvDQVNjQcaYyFuCNgxqglGT/QlHqAolb/VaAMRikPlN4lAxdlnxk6+Me6b4cVg8lIeHvfdVzHrS9jM2qIXPa6OjMGYsqPLADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081614; c=relaxed/simple;
	bh=6O0rSEg8bpue0nda3g4fDY+pO7l8EcxQ/Wb8DOvd6Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohtCbxM/6FoARQ216kipPynVtoRjZhxiKSWlFx7Kh3sl6O1UzNYhw6sSMUZRDXULZPe9bay3cA1d+5vsjs2g/RUGSJ5oT0icKVq/D08W/YhUgJANtZ6ZwISp2sksHurF3eieJJtWYOqVNHExSj2+rAOAgMXiCnEieK2uo8OSqDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gXmtUxVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089CBC4CECF;
	Fri,  8 Nov 2024 16:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731081613;
	bh=6O0rSEg8bpue0nda3g4fDY+pO7l8EcxQ/Wb8DOvd6Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXmtUxVVucx7ZyvN34QdbMCTz5UrlDu8B9tldZNZDp4j/UxYa/IW8iW8Q7EwU7Hcr
	 d4EIhQ96iy2yqMaI/ChMGAn4ynHPK/VVsMJOvdJdxLrfx9C9YRyVG77B/piTi4kZ7c
	 zqXhAkOwF6+diYLTr8mc1/B9RROwc4xgGYvB1yhk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.11.7
Date: Fri,  8 Nov 2024 16:59:45 +0100
Message-ID: <2024110845-observer-relative-9a08@gregkh>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024110845-cattishly-matter-4f04@gregkh>
References: <2024110845-cattishly-matter-4f04@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index 899b777017ce..7b299ddfea30 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -54,6 +54,10 @@ properties:
       A 2.5V to 3.3V supply for the external reference voltage. When omitted,
       the internal 2.5V reference is used.
 
+  refin-supply:
+    description:
+      A 2.5V to 3.3V supply for external reference voltage, for ad7380-4 only.
+
   aina-supply:
     description:
       The common mode voltage supply for the AINA- pin on pseudo-differential
@@ -122,6 +126,23 @@ allOf:
         ainc-supply: false
         aind-supply: false
 
+  # ad7380-4 uses refin-supply as external reference.
+  # All other chips from ad738x family use refio as optional external reference.
+  # When refio-supply is omitted, internal reference is used.
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7380-4
+    then:
+      properties:
+        refio-supply: false
+      required:
+        - refin-supply
+    else:
+      properties:
+        refin-supply: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index ea8d16600e16..e6855cd37e85 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -214,6 +214,27 @@ offset values are fractional with 3-digit decimal places and shell be
 divided with ``DPLL_PIN_PHASE_OFFSET_DIVIDER`` to get integer part and
 modulo divided to get fractional part.
 
+Embedded SYNC
+=============
+
+Device may provide ability to use Embedded SYNC feature. It allows
+to embed additional SYNC signal into the base frequency of a pin - a one
+special pulse of base frequency signal every time SYNC signal pulse
+happens. The user can configure the frequency of Embedded SYNC.
+The Embedded SYNC capability is always related to a given base frequency
+and HW capabilities. The user is provided a range of Embedded SYNC
+frequencies supported, depending on current base frequency configured for
+the pin.
+
+  ========================================= =================================
+  ``DPLL_A_PIN_ESYNC_FREQUENCY``            current Embedded SYNC frequency
+  ``DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED``  nest available Embedded SYNC
+                                            frequency ranges
+    ``DPLL_A_PIN_FREQUENCY_MIN``            attr minimum value of frequency
+    ``DPLL_A_PIN_FREQUENCY_MAX``            attr maximum value of frequency
+  ``DPLL_A_PIN_ESYNC_PULSE``                pulse type of Embedded SYNC
+  ========================================= =================================
+
 Configuration commands group
 ============================
 
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 94132d30e0e0..f2894ca35de8 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -345,6 +345,26 @@ attribute-sets:
           Value is in PPM (parts per million).
           This may be implemented for example for pin of type
           PIN_TYPE_SYNCE_ETH_PORT.
+      -
+        name: esync-frequency
+        type: u64
+        doc: |
+          Frequency of Embedded SYNC signal. If provided, the pin is configured
+          with a SYNC signal embedded into its base clock frequency.
+      -
+        name: esync-frequency-supported
+        type: nest
+        multi-attr: true
+        nested-attributes: frequency-range
+        doc: |
+          If provided a pin is capable of embedding a SYNC signal (within given
+          range) into its base frequency signal.
+      -
+        name: esync-pulse
+        type: u32
+        doc: |
+          A ratio of high to low state of a SYNC signal pulse embedded
+          into base clock frequency. Value is in percents.
   -
     name: pin-parent-device
     subset-of: pin
@@ -510,6 +530,9 @@ operations:
             - phase-adjust-max
             - phase-adjust
             - fractional-frequency-offset
+            - esync-frequency
+            - esync-frequency-supported
+            - esync-pulse
 
       dump:
         request:
@@ -536,6 +559,7 @@ operations:
             - parent-device
             - parent-pin
             - phase-adjust
+            - esync-frequency
     -
       name: pin-create-ntf
       doc: Notification about pin appearing
diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index 750ff371570a..54be7ddf3e57 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -17,7 +17,7 @@ Architecture   Level of support  Constraints
 =============  ================  ==============================================
 ``arm64``      Maintained        Little Endian only.
 ``loongarch``  Maintained        \-
-``riscv``      Maintained        ``riscv64`` only.
+``riscv``      Maintained        ``riscv64`` and LLVM/Clang only.
 ``um``         Maintained        \-
 ``x86``        Maintained        ``x86_64`` only.
 =============  ================  ==============================================
diff --git a/Makefile b/Makefile
index 318a5d60088e..692bbdf40fb5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 11
-SUBLEVEL = 6
+SUBLEVEL = 7
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index e32d5afcf4a9..43f543768444 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -384,7 +384,7 @@ pcc4: clock-controller@29800000 {
 			};
 
 			flexspi2: spi@29810000 {
-				compatible = "nxp,imx8mm-fspi";
+				compatible = "nxp,imx8ulp-fspi";
 				reg = <0x29810000 0x10000>, <0x60000000 0x10000000>;
 				reg-names = "fspi_base", "fspi_mmap";
 				#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 46d9480cd464..39405713329b 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -248,7 +248,7 @@ rpm: remoteproc {
 
 		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			mboxes = <&apcs1_mbox 0>;
+			qcom,ipc = <&apcs1_mbox 8 0>;
 			qcom,smd-edge = <15>;
 
 			rpm_requests: rpm-requests {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
index 9caa14dda585..530db0913f91 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
@@ -134,6 +134,8 @@ vreg_nvme: regulator-nvme {
 
 		pinctrl-0 = <&nvme_reg_en>;
 		pinctrl-names = "default";
+
+		regulator-boot-on;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index e17ab8251e2a..f566bbf50d6e 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -283,6 +283,8 @@ vreg_nvme: regulator-nvme {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&nvme_reg_en>;
+
+		regulator-boot-on;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index 1943bdbfb8c0..884595d98e64 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -206,6 +206,8 @@ vreg_nvme: regulator-nvme {
 
 		pinctrl-0 = <&nvme_reg_en>;
 		pinctrl-names = "default";
+
+		regulator-boot-on;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 8098e6730ae5..7bee11a5f6ee 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -253,6 +253,8 @@ vreg_nvme: regulator-nvme {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&nvme_reg_en>;
+
+		regulator-boot-on;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 6174160b56c4..bb2de6469972 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -2895,9 +2895,9 @@ pcie6a: pci@1bf8000 {
 				    "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0 0x00000000 0 0x70200000 0 0x100000>,
-				 <0x02000000 0 0x70300000 0 0x70300000 0 0x3d00000>;
-			bus-range = <0 0xff>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x70200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x70300000 0x0 0x70300000 0x0 0x1d00000>;
+			bus-range = <0x00 0xff>;
 
 			dma-coherent;
 
@@ -2973,14 +2973,16 @@ pcie6a_phy: phy@1bfc000 {
 
 			clocks = <&gcc GCC_PCIE_6A_PHY_AUX_CLK>,
 				 <&gcc GCC_PCIE_6A_CFG_AHB_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&tcsr TCSR_PCIE_4L_CLKREF_EN>,
 				 <&gcc GCC_PCIE_6A_PHY_RCHNG_CLK>,
-				 <&gcc GCC_PCIE_6A_PIPE_CLK>;
+				 <&gcc GCC_PCIE_6A_PIPE_CLK>,
+				 <&gcc GCC_PCIE_6A_PIPEDIV2_CLK>;
 			clock-names = "aux",
 				      "cfg_ahb",
 				      "ref",
 				      "rchng",
-				      "pipe";
+				      "pipe",
+				      "pipediv2";
 
 			resets = <&gcc GCC_PCIE_6A_PHY_BCR>,
 				 <&gcc GCC_PCIE_6A_NOCSR_COM_PHY_BCR>;
@@ -3017,8 +3019,8 @@ pcie4: pci@1c08000 {
 				    "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0 0x00000000 0 0x7c200000 0 0x100000>,
-				 <0x02000000 0 0x7c300000 0 0x7c300000 0 0x3d00000>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x7c200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x7c300000 0x0 0x7c300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
 			dma-coherent;
@@ -3068,7 +3070,7 @@ pcie4: pci@1c08000 {
 			assigned-clocks = <&gcc GCC_PCIE_4_AUX_CLK>;
 			assigned-clock-rates = <19200000>;
 
-			interconnects = <&pcie_south_anoc MASTER_PCIE_4 QCOM_ICC_TAG_ALWAYS
+			interconnects = <&pcie_north_anoc MASTER_PCIE_4 QCOM_ICC_TAG_ALWAYS
 					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
 					 &cnoc_main SLAVE_PCIE_4 QCOM_ICC_TAG_ALWAYS>;
@@ -3105,14 +3107,16 @@ pcie4_phy: phy@1c0e000 {
 
 			clocks = <&gcc GCC_PCIE_4_AUX_CLK>,
 				 <&gcc GCC_PCIE_4_CFG_AHB_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&tcsr TCSR_PCIE_2L_4_CLKREF_EN>,
 				 <&gcc GCC_PCIE_4_PHY_RCHNG_CLK>,
-				 <&gcc GCC_PCIE_4_PIPE_CLK>;
+				 <&gcc GCC_PCIE_4_PIPE_CLK>,
+				 <&gcc GCC_PCIE_4_PIPEDIV2_CLK>;
 			clock-names = "aux",
 				      "cfg_ahb",
 				      "ref",
 				      "rchng",
-				      "pipe";
+				      "pipe",
+				      "pipediv2";
 
 			resets = <&gcc GCC_PCIE_4_PHY_BCR>;
 			reset-names = "phy";
@@ -5700,7 +5704,8 @@ system-cache-controller@25000000 {
 			      <0 0x25a00000 0 0x200000>,
 			      <0 0x25c00000 0 0x200000>,
 			      <0 0x25e00000 0 0x200000>,
-			      <0 0x26000000 0 0x200000>;
+			      <0 0x26000000 0 0x200000>,
+			      <0 0x26200000 0 0x200000>;
 			reg-names = "llcc0_base",
 				    "llcc1_base",
 				    "llcc2_base",
@@ -5709,7 +5714,8 @@ system-cache-controller@25000000 {
 				    "llcc5_base",
 				    "llcc6_base",
 				    "llcc7_base",
-				    "llcc_broadcast_base";
+				    "llcc_broadcast_base",
+				    "llcc_broadcast_and_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
diff --git a/arch/mips/kernel/cmpxchg.c b/arch/mips/kernel/cmpxchg.c
index e974a4954df8..c371def2302d 100644
--- a/arch/mips/kernel/cmpxchg.c
+++ b/arch/mips/kernel/cmpxchg.c
@@ -102,3 +102,4 @@ unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
 			return old;
 	}
 }
+EXPORT_SYMBOL(__cmpxchg_small);
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d11c2479d8e1..6651a5cbdc27 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -172,7 +172,7 @@ config RISCV
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RETHOOK if !XIP_KERNEL
 	select HAVE_RSEQ
-	select HAVE_RUST if 64BIT
+	select HAVE_RUST if 64BIT && CC_IS_CLANG
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_STACKPROTECTOR
diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index c7771b3b6475..d6c55f1cc96a 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -128,7 +128,6 @@ &camss {
 	assigned-clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
 			  <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>;
 	assigned-clock-rates = <49500000>, <198000000>;
-	status = "okay";
 
 	ports {
 		#address-cells = <1>;
@@ -151,7 +150,6 @@ camss_from_csi2rx: endpoint {
 &csi2rx {
 	assigned-clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>;
 	assigned-clock-rates = <297000000>;
-	status = "okay";
 
 	ports {
 		#address-cells = <1>;
diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
index b720cdd15ed6..8e39fdc73ecb 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
@@ -44,8 +44,7 @@ &pcie1 {
 };
 
 &phy0 {
-	rx-internal-delay-ps = <1900>;
-	tx-internal-delay-ps = <1500>;
+	rx-internal-delay-ps = <1500>;
 	motorcomm,rx-clk-drv-microamp = <2910>;
 	motorcomm,rx-data-drv-microamp = <2910>;
 	motorcomm,tx-clk-adj-enabled;
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index ba957aaca5cb..71a3546c6f9e 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -210,7 +210,7 @@ void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
 	if (!size)
 		return NULL;
 
-	return early_ioremap(phys, size);
+	return early_memremap(phys, size);
 }
 
 void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
@@ -218,7 +218,7 @@ void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 	if (!map || !size)
 		return;
 
-	early_iounmap(map, size);
+	early_memunmap(map, size);
 }
 
 void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index b09ca5f944f7..cb09f0c4f62c 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -4,8 +4,6 @@
  * Copyright (C) 2017 SiFive
  */
 
-#define GENERATING_ASM_OFFSETS
-
 #include <linux/kbuild.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index d6c108c50cba..d32dfdba083e 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -75,8 +75,7 @@ int populate_cache_leaves(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
-	struct device_node *np = of_cpu_device_node_get(cpu);
-	struct device_node *prev = NULL;
+	struct device_node *np, *prev;
 	int levels = 1, level = 1;
 
 	if (!acpi_disabled) {
@@ -100,6 +99,10 @@ int populate_cache_leaves(unsigned int cpu)
 		return 0;
 	}
 
+	np = of_cpu_device_node_get(cpu);
+	if (!np)
+		return -ENOENT;
+
 	if (of_property_read_bool(np, "cache-size"))
 		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 	if (of_property_read_bool(np, "i-cache-size"))
diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index 28b58fc5ad19..a1e38ecfc8be 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -58,7 +58,7 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 	if (cpu_ops->cpu_is_stopped)
 		ret = cpu_ops->cpu_is_stopped(cpu);
 	if (ret)
-		pr_warn("CPU%d may not have stopped: %d\n", cpu, ret);
+		pr_warn("CPU%u may not have stopped: %d\n", cpu, ret);
 }
 
 /*
diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
index 515b2dfbca75..c5f17c2710b5 100644
--- a/arch/riscv/kernel/efi-header.S
+++ b/arch/riscv/kernel/efi-header.S
@@ -64,7 +64,7 @@ extra_header_fields:
 	.long	efi_header_end - _start			// SizeOfHeaders
 	.long	0					// CheckSum
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION		// Subsystem
-	.short	0					// DllCharacteristics
+	.short	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	// DllCharacteristics
 	.quad	0					// SizeOfStackReserve
 	.quad	0					// SizeOfStackCommit
 	.quad	0					// SizeOfHeapReserve
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index d4fd8af7aaf5..1b9867136b61 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -136,8 +136,6 @@
 #define REG_PTR(insn, pos, regs)	\
 	(ulong *)((ulong)(regs) + REG_OFFSET(insn, pos))
 
-#define GET_RM(insn)			(((insn) >> 12) & 7)
-
 #define GET_RS1(insn, regs)		(*REG_PTR(insn, SH_RS1, regs))
 #define GET_RS2(insn, regs)		(*REG_PTR(insn, SH_RS2, regs))
 #define GET_RS1S(insn, regs)		(*REG_PTR(RVC_RS1S(insn), 0, regs))
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index f7ef8ad9b550..54a7fec25d5f 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -18,6 +18,7 @@ obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
 
 ccflags-y := -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
+ccflags-y += -fno-builtin
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index a3ec87d198ac..806649c7f23d 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -13,6 +13,18 @@
 #define INSN_UD2	0x0b0f
 #define LEN_UD2		2
 
+/*
+ * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
+ */
+#define INSN_ASOP		0x67
+#define OPCODE_ESCAPE		0x0f
+#define SECOND_BYTE_OPCODE_UD1	0xb9
+#define SECOND_BYTE_OPCODE_UD2	0x0b
+
+#define BUG_NONE		0xffff
+#define BUG_UD1			0xfffe
+#define BUG_UD2			0xfffd
+
 #ifdef CONFIG_GENERIC_BUG
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4fa0b17e5043..29ec49209ae0 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -42,6 +42,7 @@
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
 #include <linux/iommu.h>
+#include <linux/ubsan.h>
 
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
@@ -91,6 +92,47 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
 	return *(unsigned short *)addr == INSN_UD2;
 }
 
+/*
+ * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
+ * If it's a UD1, get the ModRM byte to pass along to UBSan.
+ */
+__always_inline int decode_bug(unsigned long addr, u32 *imm)
+{
+	u8 v;
+
+	if (addr < TASK_SIZE_MAX)
+		return BUG_NONE;
+
+	v = *(u8 *)(addr++);
+	if (v == INSN_ASOP)
+		v = *(u8 *)(addr++);
+	if (v != OPCODE_ESCAPE)
+		return BUG_NONE;
+
+	v = *(u8 *)(addr++);
+	if (v == SECOND_BYTE_OPCODE_UD2)
+		return BUG_UD2;
+
+	if (!IS_ENABLED(CONFIG_UBSAN_TRAP) || v != SECOND_BYTE_OPCODE_UD1)
+		return BUG_NONE;
+
+	/* Retrieve the immediate (type value) for the UBSAN UD1 */
+	v = *(u8 *)(addr++);
+	if (X86_MODRM_RM(v) == 4)
+		addr++;
+
+	*imm = 0;
+	if (X86_MODRM_MOD(v) == 1)
+		*imm = *(u8 *)addr;
+	else if (X86_MODRM_MOD(v) == 2)
+		*imm = *(u32 *)addr;
+	else
+		WARN_ONCE(1, "Unexpected MODRM_MOD: %u\n", X86_MODRM_MOD(v));
+
+	return BUG_UD1;
+}
+
+
 static nokprobe_inline int
 do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
 		  struct pt_regs *regs,	long error_code)
@@ -216,30 +258,37 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled = false;
+	int ud_type;
+	u32 imm;
 
-	/*
-	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
-	 * is a rare case that uses @regs without passing them to
-	 * irqentry_enter().
-	 */
-	kmsan_unpoison_entry_regs(regs);
-	if (!is_valid_bugaddr(regs->ip))
+	ud_type = decode_bug(regs->ip, &imm);
+	if (ud_type == BUG_NONE)
 		return handled;
 
 	/*
 	 * All lies, just get the WARN/BUG out.
 	 */
 	instrumentation_begin();
+	/*
+	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
+	 * is a rare case that uses @regs without passing them to
+	 * irqentry_enter().
+	 */
+	kmsan_unpoison_entry_regs(regs);
 	/*
 	 * Since we're emulating a CALL with exceptions, restore the interrupt
 	 * state to what it was at the exception site.
 	 */
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_enable();
-	if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
-	    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
-		regs->ip += LEN_UD2;
-		handled = true;
+	if (ud_type == BUG_UD2) {
+		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
+		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
+			regs->ip += LEN_UD2;
+			handled = true;
+		}
+	} else if (IS_ENABLED(CONFIG_UBSAN_TRAP)) {
+		pr_crit("%s at %pS\n", report_ubsan_failure(regs, imm), (void *)regs->ip);
 	}
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
diff --git a/block/blk-map.c b/block/blk-map.c
index 0e1167b23934..6ef2ec1f7d78 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -600,9 +600,7 @@ static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 		if (nsegs >= nr_segs || bytes > UINT_MAX - bv->bv_len)
 			goto put_bio;
 		if (bytes + bv->bv_len > nr_iter)
-			goto put_bio;
-		if (bv->bv_offset + bv->bv_len > PAGE_SIZE)
-			goto put_bio;
+			break;
 
 		nsegs++;
 		bytes += bv->bv_len;
diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
index 6f86f8df30db..8d50981594d1 100644
--- a/drivers/accel/ivpu/ivpu_debugfs.c
+++ b/drivers/accel/ivpu/ivpu_debugfs.c
@@ -108,6 +108,14 @@ static int reset_pending_show(struct seq_file *s, void *v)
 	return 0;
 }
 
+static int firewall_irq_counter_show(struct seq_file *s, void *v)
+{
+	struct ivpu_device *vdev = seq_to_ivpu(s);
+
+	seq_printf(s, "%d\n", atomic_read(&vdev->hw->firewall_irq_counter));
+	return 0;
+}
+
 static const struct drm_debugfs_info vdev_debugfs_list[] = {
 	{"bo_list", bo_list_show, 0},
 	{"fw_name", fw_name_show, 0},
@@ -116,6 +124,7 @@ static const struct drm_debugfs_info vdev_debugfs_list[] = {
 	{"last_bootmode", last_bootmode_show, 0},
 	{"reset_counter", reset_counter_show, 0},
 	{"reset_pending", reset_pending_show, 0},
+	{"firewall_irq_counter", firewall_irq_counter_show, 0},
 };
 
 static ssize_t
diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
index 27f0fe4d54e0..e69c0613513f 100644
--- a/drivers/accel/ivpu/ivpu_hw.c
+++ b/drivers/accel/ivpu/ivpu_hw.c
@@ -249,6 +249,7 @@ int ivpu_hw_init(struct ivpu_device *vdev)
 	platform_init(vdev);
 	wa_init(vdev);
 	timeouts_init(vdev);
+	atomic_set(&vdev->hw->firewall_irq_counter, 0);
 
 	return 0;
 }
diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
index 1c0c98e3afb8..a96a05b2acda 100644
--- a/drivers/accel/ivpu/ivpu_hw.h
+++ b/drivers/accel/ivpu/ivpu_hw.h
@@ -52,6 +52,7 @@ struct ivpu_hw_info {
 	int dma_bits;
 	ktime_t d0i3_entry_host_ts;
 	u64 d0i3_entry_vpu_ts;
+	atomic_t firewall_irq_counter;
 };
 
 int ivpu_hw_init(struct ivpu_device *vdev);
diff --git a/drivers/accel/ivpu/ivpu_hw_ip.c b/drivers/accel/ivpu/ivpu_hw_ip.c
index dfd2f4a5b526..60b33fc59d96 100644
--- a/drivers/accel/ivpu/ivpu_hw_ip.c
+++ b/drivers/accel/ivpu/ivpu_hw_ip.c
@@ -1062,7 +1062,10 @@ static void irq_wdt_mss_handler(struct ivpu_device *vdev)
 
 static void irq_noc_firewall_handler(struct ivpu_device *vdev)
 {
-	ivpu_pm_trigger_recovery(vdev, "NOC Firewall IRQ");
+	atomic_inc(&vdev->hw->firewall_irq_counter);
+
+	ivpu_dbg(vdev, IRQ, "NOC Firewall interrupt detected, counter %d\n",
+		 atomic_read(&vdev->hw->firewall_irq_counter));
 }
 
 /* Handler for IRQs from NPU core */
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ed91dfd4fdca..544f53ae9cc0 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -867,7 +867,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	/* Store CPU Logical ID */
 	cpc_ptr->cpu_id = pr->id;
-	spin_lock_init(&cpc_ptr->rmw_lock);
+	raw_spin_lock_init(&cpc_ptr->rmw_lock);
 
 	/* Parse PSD data for this CPU */
 	ret = acpi_get_psd(cpc_ptr, handle);
@@ -1087,6 +1087,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 	struct cpc_desc *cpc_desc;
+	unsigned long flags;
 
 	size = GET_BIT_WIDTH(reg);
 
@@ -1126,7 +1127,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 			return -ENODEV;
 		}
 
-		spin_lock(&cpc_desc->rmw_lock);
+		raw_spin_lock_irqsave(&cpc_desc->rmw_lock, flags);
 		switch (size) {
 		case 8:
 			prev_val = readb_relaxed(vaddr);
@@ -1141,7 +1142,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 			prev_val = readq_relaxed(vaddr);
 			break;
 		default:
-			spin_unlock(&cpc_desc->rmw_lock);
+			raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
 			return -EFAULT;
 		}
 		val = MASK_VAL_WRITE(reg, prev_val, val);
@@ -1174,7 +1175,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	}
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		spin_unlock(&cpc_desc->rmw_lock);
+		raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
 
 	return ret_val;
 }
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index a904bf9a7f7d..42c490149a43 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -511,24 +511,10 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 		},
 	},
 	{
-		/* Asus Vivobook Pro N6506MV */
+		/* Asus Vivobook Pro N6506M* */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "N6506MV"),
-		},
-	},
-	{
-		/* Asus Vivobook Pro N6506MU */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "N6506MU"),
-		},
-	},
-	{
-		/* Asus Vivobook Pro N6506MJ */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "N6506MJ"),
+			DMI_MATCH(DMI_BOARD_NAME, "N6506M"),
 		},
 	},
 	{
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3b0f4b6153fc..68b8cb518463 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -25,7 +25,6 @@
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/netdevice.h>
-#include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/string_helpers.h>
@@ -2641,7 +2640,6 @@ static const char *dev_uevent_name(const struct kobject *kobj)
 static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 {
 	const struct device *dev = kobj_to_dev(kobj);
-	struct device_driver *driver;
 	int retval = 0;
 
 	/* add device node properties if present */
@@ -2670,12 +2668,8 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 	if (dev->type && dev->type->name)
 		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
 
-	/* Synchronize with module_remove_driver() */
-	rcu_read_lock();
-	driver = READ_ONCE(dev->driver);
-	if (driver)
-		add_uevent_var(env, "DRIVER=%s", driver->name);
-	rcu_read_unlock();
+	if (dev->driver)
+		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
 
 	/* Add common DT information about the device */
 	of_device_uevent(dev, env);
@@ -2745,8 +2739,11 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	if (!env)
 		return -ENOMEM;
 
+	/* Synchronize with really_probe() */
+	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(&dev->kobj, env);
+	device_unlock(dev);
 	if (retval)
 		goto out;
 
@@ -4044,6 +4041,41 @@ int device_for_each_child_reverse(struct device *parent, void *data,
 }
 EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
 
+/**
+ * device_for_each_child_reverse_from - device child iterator in reversed order.
+ * @parent: parent struct device.
+ * @from: optional starting point in child list
+ * @fn: function to be called for each device.
+ * @data: data for the callback.
+ *
+ * Iterate over @parent's child devices, starting at @from, and call @fn
+ * for each, passing it @data. This helper is identical to
+ * device_for_each_child_reverse() when @from is NULL.
+ *
+ * @fn is checked each iteration. If it returns anything other than 0,
+ * iteration stop and that value is returned to the caller of
+ * device_for_each_child_reverse_from();
+ */
+int device_for_each_child_reverse_from(struct device *parent,
+				       struct device *from, const void *data,
+				       int (*fn)(struct device *, const void *))
+{
+	struct klist_iter i;
+	struct device *child;
+	int error = 0;
+
+	if (!parent->p)
+		return 0;
+
+	klist_iter_init_node(&parent->p->klist_children, &i,
+			     (from ? &from->p->knode_parent : NULL));
+	while ((child = prev_device(&i)) && !error)
+		error = fn(child, data);
+	klist_iter_exit(&i);
+	return error;
+}
+EXPORT_SYMBOL_GPL(device_for_each_child_reverse_from);
+
 /**
  * device_find_child - device iterator for locating a particular device.
  * @parent: parent struct device
diff --git a/drivers/base/module.c b/drivers/base/module.c
index c4eaa1158d54..5bc71bea883a 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -7,7 +7,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/rcupdate.h>
 #include "base.h"
 
 static char *make_driver_name(const struct device_driver *drv)
@@ -102,9 +101,6 @@ void module_remove_driver(const struct device_driver *drv)
 	if (!drv)
 		return;
 
-	/* Synchronize with dev_uevent() */
-	synchronize_rcu();
-
 	sysfs_remove_link(&drv->p->kobj, "module");
 
 	if (drv->owner)
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 854546000c92..1ff99a7091bb 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -674,6 +674,16 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
  */
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
+#ifdef CONFIG_TCG_TPM2_HMAC
+	int rc;
+
+	rc = tpm_try_get_ops(chip);
+	if (!rc) {
+		tpm2_end_auth_session(chip);
+		tpm_put_ops(chip);
+	}
+#endif
+
 	tpm_del_legacy_sysfs(chip);
 	if (tpm_is_hwrng_enabled(chip))
 		hwrng_unregister(&chip->hwrng);
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index c3fbbf4d3db7..48ff87444f85 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -27,6 +27,9 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	struct tpm_header *header = (void *)buf;
 	ssize_t ret, len;
 
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		tpm2_end_auth_session(chip);
+
 	ret = tpm2_prepare_space(chip, space, buf, bufsiz);
 	/* If the command is not implemented by the TPM, synthesize a
 	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 5da134f12c9a..8134f002b121 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -379,10 +379,12 @@ int tpm_pm_suspend(struct device *dev)
 
 	rc = tpm_try_get_ops(chip);
 	if (!rc) {
-		if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+			tpm2_end_auth_session(chip);
 			tpm2_shutdown(chip, TPM2_SU_STATE);
-		else
+		} else {
 			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
+		}
 
 		tpm_put_ops(chip);
 	}
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 44f60730cff4..c8fdfe901dfb 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -333,6 +333,9 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 	}
 
 #ifdef CONFIG_TCG_TPM2_HMAC
+	/* The first write to /dev/tpm{rm0} will flush the session. */
+	attributes |= TPM2_SA_CONTINUE_SESSION;
+
 	/*
 	 * The Architecture Guide requires us to strip trailing zeros
 	 * before computing the HMAC
@@ -484,7 +487,8 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_v,
 	sha256_final(&sctx, out);
 }
 
-static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
+static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
+				struct tpm2_auth *auth)
 {
 	struct crypto_kpp *kpp;
 	struct kpp_request *req;
@@ -543,7 +547,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
 	sg_set_buf(&s[0], chip->null_ec_key_x, EC_PT_SZ);
 	sg_set_buf(&s[1], chip->null_ec_key_y, EC_PT_SZ);
 	kpp_request_set_input(req, s, EC_PT_SZ*2);
-	sg_init_one(d, chip->auth->salt, EC_PT_SZ);
+	sg_init_one(d, auth->salt, EC_PT_SZ);
 	kpp_request_set_output(req, d, EC_PT_SZ);
 	crypto_kpp_compute_shared_secret(req);
 	kpp_request_free(req);
@@ -554,8 +558,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
 	 * This works because KDFe fully consumes the secret before it
 	 * writes the salt
 	 */
-	tpm2_KDFe(chip->auth->salt, "SECRET", x, chip->null_ec_key_x,
-		  chip->auth->salt);
+	tpm2_KDFe(auth->salt, "SECRET", x, chip->null_ec_key_x, auth->salt);
 
  out:
 	crypto_free_kpp(kpp);
@@ -853,7 +856,9 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 		if (rc)
 			/* manually close the session if it wasn't consumed */
 			tpm2_flush_context(chip, auth->handle);
-		memzero_explicit(auth, sizeof(*auth));
+
+		kfree_sensitive(auth);
+		chip->auth = NULL;
 	} else {
 		/* reset for next use  */
 		auth->session = TPM_HEADER_SIZE;
@@ -881,7 +886,8 @@ void tpm2_end_auth_session(struct tpm_chip *chip)
 		return;
 
 	tpm2_flush_context(chip, auth->handle);
-	memzero_explicit(auth, sizeof(*auth));
+	kfree_sensitive(auth);
+	chip->auth = NULL;
 }
 EXPORT_SYMBOL(tpm2_end_auth_session);
 
@@ -915,33 +921,37 @@ static int tpm2_parse_start_auth_session(struct tpm2_auth *auth,
 
 static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
 {
-	int rc;
 	unsigned int offset = 0; /* dummy offset for null seed context */
 	u8 name[SHA256_DIGEST_SIZE + 2];
+	u32 tmp_null_key;
+	int rc;
 
 	rc = tpm2_load_context(chip, chip->null_key_context, &offset,
-			       null_key);
-	if (rc != -EINVAL)
-		return rc;
+			       &tmp_null_key);
+	if (rc != -EINVAL) {
+		if (!rc)
+			*null_key = tmp_null_key;
+		goto err;
+	}
 
-	/* an integrity failure may mean the TPM has been reset */
-	dev_err(&chip->dev, "NULL key integrity failure!\n");
-	/* check the null name against what we know */
-	tpm2_create_primary(chip, TPM2_RH_NULL, NULL, name);
-	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0)
-		/* name unchanged, assume transient integrity failure */
-		return rc;
-	/*
-	 * Fatal TPM failure: the NULL seed has actually changed, so
-	 * the TPM must have been illegally reset.  All in-kernel TPM
-	 * operations will fail because the NULL primary can't be
-	 * loaded to salt the sessions, but disable the TPM anyway so
-	 * userspace programmes can't be compromised by it.
-	 */
-	dev_err(&chip->dev, "NULL name has changed, disabling TPM due to interference\n");
+	/* Try to re-create null key, given the integrity failure: */
+	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &tmp_null_key, name);
+	if (rc)
+		goto err;
+
+	/* Return null key if the name has not been changed: */
+	if (!memcmp(name, chip->null_key_name, sizeof(name))) {
+		*null_key = tmp_null_key;
+		return 0;
+	}
+
+	/* Deduce from the name change TPM interference: */
+	dev_err(&chip->dev, "null key integrity check failed\n");
+	tpm2_flush_context(chip, tmp_null_key);
 	chip->flags |= TPM_CHIP_FLAG_DISABLE;
 
-	return rc;
+err:
+	return rc ? -ENODEV : 0;
 }
 
 /**
@@ -958,16 +968,20 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
  */
 int tpm2_start_auth_session(struct tpm_chip *chip)
 {
+	struct tpm2_auth *auth;
 	struct tpm_buf buf;
-	struct tpm2_auth *auth = chip->auth;
-	int rc;
 	u32 null_key;
+	int rc;
 
-	if (!auth) {
-		dev_warn_once(&chip->dev, "auth session is not active\n");
+	if (chip->auth) {
+		dev_warn_once(&chip->dev, "auth session is active\n");
 		return 0;
 	}
 
+	auth = kzalloc(sizeof(*auth), GFP_KERNEL);
+	if (!auth)
+		return -ENOMEM;
+
 	rc = tpm2_load_null(chip, &null_key);
 	if (rc)
 		goto out;
@@ -988,7 +1002,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
 
 	/* append encrypted salt and squirrel away unencrypted in auth */
-	tpm_buf_append_salt(&buf, chip);
+	tpm_buf_append_salt(&buf, chip, auth);
 	/* session type (HMAC, audit or policy) */
 	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
 
@@ -1010,10 +1024,13 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 
 	tpm_buf_destroy(&buf);
 
-	if (rc)
-		goto out;
+	if (rc == TPM2_RC_SUCCESS) {
+		chip->auth = auth;
+		return 0;
+	}
 
- out:
+out:
+	kfree_sensitive(auth);
 	return rc;
 }
 EXPORT_SYMBOL(tpm2_start_auth_session);
@@ -1347,18 +1364,21 @@ static int tpm2_create_null_primary(struct tpm_chip *chip)
  *
  * Derive and context save the null primary and allocate memory in the
  * struct tpm_chip for the authorizations.
+ *
+ * Return:
+ * * 0		- OK
+ * * -errno	- A system error
+ * * TPM_RC	- A TPM error
  */
 int tpm2_sessions_init(struct tpm_chip *chip)
 {
 	int rc;
 
 	rc = tpm2_create_null_primary(chip);
-	if (rc)
-		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n", rc);
-
-	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
-	if (!chip->auth)
-		return -ENOMEM;
+	if (rc) {
+		dev_err(&chip->dev, "null key creation failed with %d\n", rc);
+		return rc;
+	}
 
 	return rc;
 }
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 99b5c25be079..b3fd0f1b7578 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -60,6 +60,7 @@ config CXL_ACPI
 	default CXL_BUS
 	select ACPI_TABLE_LIB
 	select ACPI_HMAT
+	select CXL_PORT
 	help
 	  Enable support for host managed device memory (HDM) resources
 	  published by a platform's ACPI CXL memory layout description.  See
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index db321f48ba52..2caa90fa4bf2 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,13 +1,21 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# Order is important here for the built-in case:
+# - 'core' first for fundamental init
+# - 'port' before platform root drivers like 'acpi' so that CXL-root ports
+#   are immediately enabled
+# - 'mem' and 'pmem' before endpoint drivers so that memdevs are
+#   immediately enabled
+# - 'pci' last, also mirrors the hardware enumeration hierarchy
 obj-y += core/
-obj-$(CONFIG_CXL_PCI) += cxl_pci.o
-obj-$(CONFIG_CXL_MEM) += cxl_mem.o
+obj-$(CONFIG_CXL_PORT) += cxl_port.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
-obj-$(CONFIG_CXL_PORT) += cxl_port.o
+obj-$(CONFIG_CXL_MEM) += cxl_mem.o
+obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 
-cxl_mem-y := mem.o
-cxl_pci-y := pci.o
+cxl_port-y := port.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
-cxl_port-y := port.o
+cxl_mem-y := mem.o
+cxl_pci-y := pci.o
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 82b78e331d8e..432b7cfd12a8 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -924,6 +924,13 @@ static void __exit cxl_acpi_exit(void)
 
 /* load before dax_hmem sees 'Soft Reserved' CXL ranges */
 subsys_initcall(cxl_acpi_init);
+
+/*
+ * Arrange for host-bridge ports to be active synchronous with
+ * cxl_acpi_probe() exit.
+ */
+MODULE_SOFTDEP("pre: cxl_port");
+
 module_exit(cxl_acpi_exit);
 MODULE_DESCRIPTION("CXL ACPI: Platform Support");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 3df10517a327..223c273c0cd1 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -712,7 +712,44 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	return 0;
 }
 
-static int cxl_decoder_reset(struct cxl_decoder *cxld)
+static int commit_reap(struct device *dev, const void *data)
+{
+	struct cxl_port *port = to_cxl_port(dev->parent);
+	struct cxl_decoder *cxld;
+
+	if (!is_switch_decoder(dev) && !is_endpoint_decoder(dev))
+		return 0;
+
+	cxld = to_cxl_decoder(dev);
+	if (port->commit_end == cxld->id &&
+	    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
+		port->commit_end--;
+		dev_dbg(&port->dev, "reap: %s commit_end: %d\n",
+			dev_name(&cxld->dev), port->commit_end);
+	}
+
+	return 0;
+}
+
+void cxl_port_commit_reap(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	lockdep_assert_held_write(&cxl_region_rwsem);
+
+	/*
+	 * Once the highest committed decoder is disabled, free any other
+	 * decoders that were pinned allocated by out-of-order release.
+	 */
+	port->commit_end--;
+	dev_dbg(&port->dev, "reap: %s commit_end: %d\n", dev_name(&cxld->dev),
+		port->commit_end);
+	device_for_each_child_reverse_from(&port->dev, &cxld->dev, NULL,
+					   commit_reap);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_commit_reap, CXL);
+
+static void cxl_decoder_reset(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
@@ -721,14 +758,14 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
 	u32 ctrl;
 
 	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
-		return 0;
+		return;
 
-	if (port->commit_end != id) {
+	if (port->commit_end == id)
+		cxl_port_commit_reap(cxld);
+	else
 		dev_dbg(&port->dev,
 			"%s: out of order reset, expected decoder%d.%d\n",
 			dev_name(&cxld->dev), port->id, port->commit_end);
-		return -EBUSY;
-	}
 
 	down_read(&cxl_dpa_rwsem);
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
@@ -741,7 +778,6 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 	up_read(&cxl_dpa_rwsem);
 
-	port->commit_end--;
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
 
 	/* Userspace is now responsible for reconfiguring this decoder */
@@ -751,8 +787,6 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
 		cxled->state = CXL_DECODER_STATE_MANUAL;
 	}
-
-	return 0;
 }
 
 static int cxl_setup_hdm_decoder_from_dvsec(
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..d3237346f687 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2088,11 +2088,18 @@ static void cxl_bus_remove(struct device *dev)
 
 static struct workqueue_struct *cxl_bus_wq;
 
-static void cxl_bus_rescan_queue(struct work_struct *w)
+static int cxl_rescan_attach(struct device *dev, void *data)
 {
-	int rc = bus_rescan_devices(&cxl_bus_type);
+	int rc = device_attach(dev);
+
+	dev_vdbg(dev, "rescan: %s\n", rc ? "attach" : "detached");
 
-	pr_debug("CXL bus rescan result: %d\n", rc);
+	return 0;
+}
+
+static void cxl_bus_rescan_queue(struct work_struct *w)
+{
+	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_rescan_attach);
 }
 
 void cxl_bus_rescan(void)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..38507c4a3743 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -232,8 +232,8 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
 			return 0;
 		} else {
-			dev_err(&cxlr->dev,
-				"Failed to synchronize CPU cache state\n");
+			dev_WARN(&cxlr->dev,
+				 "Failed to synchronize CPU cache state\n");
 			return -ENXIO;
 		}
 	}
@@ -242,19 +242,17 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 	return 0;
 }
 
-static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
+static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	int i, rc = 0;
+	int i;
 
 	/*
-	 * Before region teardown attempt to flush, and if the flush
-	 * fails cancel the region teardown for data consistency
-	 * concerns
+	 * Before region teardown attempt to flush, evict any data cached for
+	 * this region, or scream loudly about missing arch / platform support
+	 * for CXL teardown.
 	 */
-	rc = cxl_region_invalidate_memregion(cxlr);
-	if (rc)
-		return rc;
+	cxl_region_invalidate_memregion(cxlr);
 
 	for (i = count - 1; i >= 0; i--) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
@@ -277,23 +275,17 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 			cxl_rr = cxl_rr_load(iter, cxlr);
 			cxld = cxl_rr->decoder;
 			if (cxld->reset)
-				rc = cxld->reset(cxld);
-			if (rc)
-				return rc;
+				cxld->reset(cxld);
 			set_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 		}
 
 endpoint_reset:
-		rc = cxled->cxld.reset(&cxled->cxld);
-		if (rc)
-			return rc;
+		cxled->cxld.reset(&cxled->cxld);
 		set_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 	}
 
 	/* all decoders associated with this region have been torn down */
 	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
-
-	return 0;
 }
 
 static int commit_decoder(struct cxl_decoder *cxld)
@@ -409,16 +401,8 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 		 * still pending.
 		 */
 		if (p->state == CXL_CONFIG_RESET_PENDING) {
-			rc = cxl_region_decode_reset(cxlr, p->interleave_ways);
-			/*
-			 * Revert to committed since there may still be active
-			 * decoders associated with this region, or move forward
-			 * to active to mark the reset successful
-			 */
-			if (rc)
-				p->state = CXL_CONFIG_COMMIT;
-			else
-				p->state = CXL_CONFIG_ACTIVE;
+			cxl_region_decode_reset(cxlr, p->interleave_ways);
+			p->state = CXL_CONFIG_ACTIVE;
 		}
 	}
 
@@ -2052,13 +2036,7 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	get_device(&cxlr->dev);
 
 	if (p->state > CXL_CONFIG_ACTIVE) {
-		/*
-		 * TODO: tear down all impacted regions if a device is
-		 * removed out of order
-		 */
-		rc = cxl_region_decode_reset(cxlr, p->interleave_ways);
-		if (rc)
-			goto out;
+		cxl_region_decode_reset(cxlr, p->interleave_ways);
 		p->state = CXL_CONFIG_ACTIVE;
 	}
 
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 9167cfba7f59..cdffebcf20a4 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -279,7 +279,7 @@ TRACE_EVENT(cxl_generic_event,
 #define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR			0x00
 #define CXL_GMER_MEM_EVT_TYPE_INV_ADDR			0x01
 #define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x02
-#define show_mem_event_type(type)	__print_symbolic(type,			\
+#define show_gmer_mem_event_type(type)	__print_symbolic(type,			\
 	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },		\
 	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },	\
 	{ CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,	"Data Path Error" }	\
@@ -373,7 +373,7 @@ TRACE_EVENT(cxl_general_media,
 		"hpa=%llx region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
-		show_mem_event_type(__entry->type),
+		show_gmer_mem_event_type(__entry->type),
 		show_trans_type(__entry->transaction_type),
 		__entry->channel, __entry->rank, __entry->device,
 		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
@@ -391,6 +391,17 @@ TRACE_EVENT(cxl_general_media,
  * DRAM Event Record defines many fields the same as the General Media Event
  * Record.  Reuse those definitions as appropriate.
  */
+#define CXL_DER_MEM_EVT_TYPE_ECC_ERROR			0x00
+#define CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR	0x01
+#define CXL_DER_MEM_EVT_TYPE_INV_ADDR			0x02
+#define CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x03
+#define show_dram_mem_event_type(type)  __print_symbolic(type,				\
+	{ CXL_DER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },			\
+	{ CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub Media ECC Error" },	\
+	{ CXL_DER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },		\
+	{ CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR,		"Data Path Error" }		\
+)
+
 #define CXL_DER_VALID_CHANNEL				BIT(0)
 #define CXL_DER_VALID_RANK				BIT(1)
 #define CXL_DER_VALID_NIBBLE				BIT(2)
@@ -477,7 +488,7 @@ TRACE_EVENT(cxl_dram,
 		"hpa=%llx region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
-		show_mem_event_type(__entry->type),
+		show_dram_mem_event_type(__entry->type),
 		show_trans_type(__entry->transaction_type),
 		__entry->channel, __entry->rank, __entry->nibble_mask,
 		__entry->bank_group, __entry->bank,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9afb407d438f..d437745ab172 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -359,7 +359,7 @@ struct cxl_decoder {
 	struct cxl_region *region;
 	unsigned long flags;
 	int (*commit)(struct cxl_decoder *cxld);
-	int (*reset)(struct cxl_decoder *cxld);
+	void (*reset)(struct cxl_decoder *cxld);
 };
 
 /*
@@ -730,6 +730,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
 int cxl_num_decoders_committed(struct cxl_port *port);
 bool is_cxl_port(const struct device *dev);
 struct cxl_port *to_cxl_port(const struct device *dev);
+void cxl_port_commit_reap(struct cxl_decoder *cxld);
 struct pci_bus;
 int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
 			      struct pci_bus *bus);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d7d5d982ce69..49733d2c38f1 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -208,7 +208,22 @@ static struct cxl_driver cxl_port_driver = {
 	},
 };
 
-module_cxl_driver(cxl_port_driver);
+static int __init cxl_port_init(void)
+{
+	return cxl_driver_register(&cxl_port_driver);
+}
+/*
+ * Be ready to immediately enable ports emitted by the platform CXL root
+ * (e.g. cxl_acpi) when CONFIG_CXL_PORT=y.
+ */
+subsys_initcall(cxl_port_init);
+
+static void __exit cxl_port_exit(void)
+{
+	cxl_driver_unregister(&cxl_port_driver);
+}
+module_exit(cxl_port_exit);
+
 MODULE_DESCRIPTION("CXL: Port enumeration and services");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 98e6ad8528d3..fc0280dcddd1 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -342,6 +342,51 @@ dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
 	return 0;
 }
 
+static int
+dpll_msg_add_pin_esync(struct sk_buff *msg, struct dpll_pin *pin,
+		       struct dpll_pin_ref *ref, struct netlink_ext_ack *extack)
+{
+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
+	struct dpll_device *dpll = ref->dpll;
+	struct dpll_pin_esync esync;
+	struct nlattr *nest;
+	int ret, i;
+
+	if (!ops->esync_get)
+		return 0;
+	ret = ops->esync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
+			     dpll_priv(dpll), &esync, extack);
+	if (ret == -EOPNOTSUPP)
+		return 0;
+	else if (ret)
+		return ret;
+	if (nla_put_64bit(msg, DPLL_A_PIN_ESYNC_FREQUENCY, sizeof(esync.freq),
+			  &esync.freq, DPLL_A_PIN_PAD))
+		return -EMSGSIZE;
+	if (nla_put_u32(msg, DPLL_A_PIN_ESYNC_PULSE, esync.pulse))
+		return -EMSGSIZE;
+	for (i = 0; i < esync.range_num; i++) {
+		nest = nla_nest_start(msg,
+				      DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED);
+		if (!nest)
+			return -EMSGSIZE;
+		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN,
+				  sizeof(esync.range[i].min),
+				  &esync.range[i].min, DPLL_A_PIN_PAD))
+			goto nest_cancel;
+		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX,
+				  sizeof(esync.range[i].max),
+				  &esync.range[i].max, DPLL_A_PIN_PAD))
+			goto nest_cancel;
+		nla_nest_end(msg, nest);
+	}
+	return 0;
+
+nest_cancel:
+	nla_nest_cancel(msg, nest);
+	return -EMSGSIZE;
+}
+
 static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 freq)
 {
 	int fs;
@@ -481,6 +526,9 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	if (ret)
 		return ret;
 	ret = dpll_msg_add_ffo(msg, pin, ref, extack);
+	if (ret)
+		return ret;
+	ret = dpll_msg_add_pin_esync(msg, pin, ref, extack);
 	if (ret)
 		return ret;
 	if (xa_empty(&pin->parent_refs))
@@ -738,6 +786,83 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 	return ret;
 }
 
+static int
+dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
+		   struct netlink_ext_ack *extack)
+{
+	struct dpll_pin_ref *ref, *failed;
+	const struct dpll_pin_ops *ops;
+	struct dpll_pin_esync esync;
+	u64 freq = nla_get_u64(a);
+	struct dpll_device *dpll;
+	bool supported = false;
+	unsigned long i;
+	int ret;
+
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		ops = dpll_pin_ops(ref);
+		if (!ops->esync_set || !ops->esync_get) {
+			NL_SET_ERR_MSG(extack,
+				       "embedded sync feature is not supported by this device");
+			return -EOPNOTSUPP;
+		}
+	}
+	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
+	ops = dpll_pin_ops(ref);
+	dpll = ref->dpll;
+	ret = ops->esync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
+			     dpll_priv(dpll), &esync, extack);
+	if (ret) {
+		NL_SET_ERR_MSG(extack, "unable to get current embedded sync frequency value");
+		return ret;
+	}
+	if (freq == esync.freq)
+		return 0;
+	for (i = 0; i < esync.range_num; i++)
+		if (freq <= esync.range[i].max && freq >= esync.range[i].min)
+			supported = true;
+	if (!supported) {
+		NL_SET_ERR_MSG_ATTR(extack, a,
+				    "requested embedded sync frequency value is not supported by this device");
+		return -EINVAL;
+	}
+
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		void *pin_dpll_priv;
+
+		ops = dpll_pin_ops(ref);
+		dpll = ref->dpll;
+		pin_dpll_priv = dpll_pin_on_dpll_priv(dpll, pin);
+		ret = ops->esync_set(pin, pin_dpll_priv, dpll, dpll_priv(dpll),
+				      freq, extack);
+		if (ret) {
+			failed = ref;
+			NL_SET_ERR_MSG_FMT(extack,
+					   "embedded sync frequency set failed for dpll_id: %u",
+					   dpll->id);
+			goto rollback;
+		}
+	}
+	__dpll_pin_change_ntf(pin);
+
+	return 0;
+
+rollback:
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		void *pin_dpll_priv;
+
+		if (ref == failed)
+			break;
+		ops = dpll_pin_ops(ref);
+		dpll = ref->dpll;
+		pin_dpll_priv = dpll_pin_on_dpll_priv(dpll, pin);
+		if (ops->esync_set(pin, pin_dpll_priv, dpll, dpll_priv(dpll),
+				   esync.freq, extack))
+			NL_SET_ERR_MSG(extack, "set embedded sync frequency rollback failed");
+	}
+	return ret;
+}
+
 static int
 dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
 			  enum dpll_pin_state state,
@@ -1039,6 +1164,11 @@ dpll_pin_set_from_nlattr(struct dpll_pin *pin, struct genl_info *info)
 			if (ret)
 				return ret;
 			break;
+		case DPLL_A_PIN_ESYNC_FREQUENCY:
+			ret = dpll_pin_esync_set(pin, a, info->extack);
+			if (ret)
+				return ret;
+			break;
 		}
 	}
 
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index 1e95f5397cfc..fe9b6893d261 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -62,7 +62,7 @@ static const struct nla_policy dpll_pin_get_dump_nl_policy[DPLL_A_PIN_ID + 1] =
 };
 
 /* DPLL_CMD_PIN_SET - do */
-static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_PHASE_ADJUST + 1] = {
+static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_ESYNC_FREQUENCY + 1] = {
 	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
 	[DPLL_A_PIN_FREQUENCY] = { .type = NLA_U64, },
 	[DPLL_A_PIN_DIRECTION] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
@@ -71,6 +71,7 @@ static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_PHASE_ADJUST +
 	[DPLL_A_PIN_PARENT_DEVICE] = NLA_POLICY_NESTED(dpll_pin_parent_device_nl_policy),
 	[DPLL_A_PIN_PARENT_PIN] = NLA_POLICY_NESTED(dpll_pin_parent_pin_nl_policy),
 	[DPLL_A_PIN_PHASE_ADJUST] = { .type = NLA_S32, },
+	[DPLL_A_PIN_ESYNC_FREQUENCY] = { .type = NLA_U64, },
 };
 
 /* Ops table for dpll */
@@ -138,7 +139,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
 		.doit		= dpll_nl_pin_set_doit,
 		.post_doit	= dpll_pin_post_doit,
 		.policy		= dpll_pin_set_nl_policy,
-		.maxattr	= DPLL_A_PIN_PHASE_ADJUST,
+		.maxattr	= DPLL_A_PIN_ESYNC_FREQUENCY,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 285fe7ad490d..3e8051fe8296 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -763,7 +763,7 @@ static int sdei_device_freeze(struct device *dev)
 	int err;
 
 	/* unregister private events */
-	cpuhp_remove_state(sdei_entry_point);
+	cpuhp_remove_state(sdei_hp_state);
 
 	err = sdei_unregister_shared();
 	if (err)
diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index 9ca5ee58edbd..0f7ec8848202 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -76,14 +76,11 @@
 #define AUTO_UPDATE_INFO_SIZE		SZ_1M
 #define AUTO_UPDATE_BITSTREAM_BASE	(AUTO_UPDATE_DIRECTORY_SIZE + AUTO_UPDATE_INFO_SIZE)
 
-#define AUTO_UPDATE_TIMEOUT_MS		60000
-
 struct mpfs_auto_update_priv {
 	struct mpfs_sys_controller *sys_controller;
 	struct device *dev;
 	struct mtd_info *flash;
 	struct fw_upload *fw_uploader;
-	struct completion programming_complete;
 	size_t size_per_bitstream;
 	bool cancel_request;
 };
@@ -156,19 +153,6 @@ static void mpfs_auto_update_cancel(struct fw_upload *fw_uploader)
 
 static enum fw_upload_err mpfs_auto_update_poll_complete(struct fw_upload *fw_uploader)
 {
-	struct mpfs_auto_update_priv *priv = fw_uploader->dd_handle;
-	int ret;
-
-	/*
-	 * There is no meaningful way to get the status of the programming while
-	 * it is in progress, so attempting anything other than waiting for it
-	 * to complete would be misplaced.
-	 */
-	ret = wait_for_completion_timeout(&priv->programming_complete,
-					  msecs_to_jiffies(AUTO_UPDATE_TIMEOUT_MS));
-	if (!ret)
-		return FW_UPLOAD_ERR_TIMEOUT;
-
 	return FW_UPLOAD_ERR_NONE;
 }
 
@@ -349,33 +333,23 @@ static enum fw_upload_err mpfs_auto_update_write(struct fw_upload *fw_uploader,
 						 u32 offset, u32 size, u32 *written)
 {
 	struct mpfs_auto_update_priv *priv = fw_uploader->dd_handle;
-	enum fw_upload_err err = FW_UPLOAD_ERR_NONE;
 	int ret;
 
-	reinit_completion(&priv->programming_complete);
-
 	ret = mpfs_auto_update_write_bitstream(fw_uploader, data, offset, size, written);
-	if (ret) {
-		err = FW_UPLOAD_ERR_RW_ERROR;
-		goto out;
-	}
+	if (ret)
+		return FW_UPLOAD_ERR_RW_ERROR;
 
-	if (priv->cancel_request) {
-		err = FW_UPLOAD_ERR_CANCELED;
-		goto out;
-	}
+	if (priv->cancel_request)
+		return FW_UPLOAD_ERR_CANCELED;
 
 	if (mpfs_auto_update_is_bitstream_info(data, size))
-		goto out;
+		return FW_UPLOAD_ERR_NONE;
 
 	ret = mpfs_auto_update_verify_image(fw_uploader);
 	if (ret)
-		err = FW_UPLOAD_ERR_FW_INVALID;
+		return FW_UPLOAD_ERR_FW_INVALID;
 
-out:
-	complete(&priv->programming_complete);
-
-	return err;
+	return FW_UPLOAD_ERR_NONE;
 }
 
 static const struct fw_upload_ops mpfs_auto_update_ops = {
@@ -461,8 +435,6 @@ static int mpfs_auto_update_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "The current bitstream does not support auto-update\n");
 
-	init_completion(&priv->programming_complete);
-
 	fw_uploader = firmware_upload_register(THIS_MODULE, dev, "mpfs-auto-update",
 					       &mpfs_auto_update_ops, priv);
 	if (IS_ERR(fw_uploader))
diff --git a/drivers/gpio/gpio-sloppy-logic-analyzer.c b/drivers/gpio/gpio-sloppy-logic-analyzer.c
index aed6d1f6cfc3..6440d55bf2e1 100644
--- a/drivers/gpio/gpio-sloppy-logic-analyzer.c
+++ b/drivers/gpio/gpio-sloppy-logic-analyzer.c
@@ -235,7 +235,9 @@ static int gpio_la_poll_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	devm_mutex_init(dev, &priv->blob_lock);
+	ret = devm_mutex_init(dev, &priv->blob_lock);
+	if (ret)
+		return ret;
 
 	fops_buf_size_set(priv, GPIO_LA_DEFAULT_BUF_SIZE);
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 148bcfbf98e0..337971080dfd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4834,6 +4834,8 @@ static void *gpiolib_seq_start(struct seq_file *s, loff_t *pos)
 		return NULL;
 
 	s->private = priv;
+	if (*pos > 0)
+		priv->newline = true;
 	priv->idx = srcu_read_lock(&gpio_devices_srcu);
 
 	list_for_each_entry_srcu(gdev, &gpio_devices, list,
@@ -4877,7 +4879,7 @@ static int gpiolib_seq_show(struct seq_file *s, void *v)
 
 	gc = srcu_dereference(gdev->chip, &gdev->srcu);
 	if (!gc) {
-		seq_printf(s, "%s%s: (dangling chip)",
+		seq_printf(s, "%s%s: (dangling chip)\n",
 			   priv->newline ? "\n" : "",
 			   dev_name(&gdev->dev));
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 403c177f2434..bbf43e668c1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -51,6 +51,12 @@ MODULE_FIRMWARE("amdgpu/sdma_7_0_1.bin");
 #define SDMA0_HYP_DEC_REG_END 0x589a
 #define SDMA1_HYP_DEC_REG_OFFSET 0x20
 
+/*define for compression field for sdma7*/
+#define SDMA_PKT_CONSTANT_FILL_HEADER_compress_offset 0
+#define SDMA_PKT_CONSTANT_FILL_HEADER_compress_mask   0x00000001
+#define SDMA_PKT_CONSTANT_FILL_HEADER_compress_shift  16
+#define SDMA_PKT_CONSTANT_FILL_HEADER_COMPRESS(x) (((x) & SDMA_PKT_CONSTANT_FILL_HEADER_compress_mask) << SDMA_PKT_CONSTANT_FILL_HEADER_compress_shift)
+
 static void sdma_v7_0_set_ring_funcs(struct amdgpu_device *adev);
 static void sdma_v7_0_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v7_0_set_vm_pte_funcs(struct amdgpu_device *adev);
@@ -1611,7 +1617,8 @@ static void sdma_v7_0_emit_fill_buffer(struct amdgpu_ib *ib,
 				       uint64_t dst_offset,
 				       uint32_t byte_count)
 {
-	ib->ptr[ib->length_dw++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_CONST_FILL);
+	ib->ptr[ib->length_dw++] = SDMA_PKT_CONSTANT_FILL_HEADER_OP(SDMA_OP_CONST_FILL) |
+		SDMA_PKT_CONSTANT_FILL_HEADER_COMPRESS(1);
 	ib->ptr[ib->length_dw++] = lower_32_bits(dst_offset);
 	ib->ptr[ib->length_dw++] = upper_32_bits(dst_offset);
 	ib->ptr[ib->length_dw++] = src_data;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
index 11c904ae2958..c4c52173ef22 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
@@ -303,6 +303,7 @@ void build_unoptimized_policy_settings(enum dml_project_id project, struct dml_m
 	if (project == dml_project_dcn35 ||
 		project == dml_project_dcn351) {
 		policy->DCCProgrammingAssumesScanDirectionUnknownFinal = false;
+		policy->EnhancedPrefetchScheduleAccelerationFinal = 0;
 		policy->AllowForPStateChangeOrStutterInVBlankFinal = dml_prefetch_support_uclk_fclk_and_stutter_if_possible; /*new*/
 		policy->UseOnlyMaxPrefetchModes = 1;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 87672ca714de..80e60ea2d11e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1234,6 +1234,14 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 	}
 }
 
+static bool smu_is_workload_profile_available(struct smu_context *smu,
+					      u32 profile)
+{
+	if (profile >= PP_SMC_POWER_PROFILE_COUNT)
+		return false;
+	return smu->workload_map && smu->workload_map[profile].valid_mapping;
+}
+
 static int smu_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1257,7 +1265,6 @@ static int smu_sw_init(void *handle)
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
-	smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
 	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
 	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
 	smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
@@ -1266,6 +1273,12 @@ static int smu_sw_init(void *handle)
 	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
 	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
 
+	if (smu->is_apu ||
+	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
+		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
+	else
+		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
+
 	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 22737b11b1bf..1fe020f1f4db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -242,7 +242,9 @@ static int vangogh_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = max(sizeof(struct gpu_metrics_v2_3), sizeof(struct gpu_metrics_v2_2));
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
+	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_3));
+	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_4));
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index cb923e33fd6f..d53e162dcd8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2485,7 +2485,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
-	u32 workload_mask;
+	u32 workload_mask, selected_workload_mask;
 
 	smu->power_profile_mode = input[size];
 
@@ -2552,7 +2552,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
-	workload_mask = 1 << workload_type;
+	selected_workload_mask = workload_mask = 1 << workload_type;
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
 	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
@@ -2572,7 +2572,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 					       workload_mask,
 					       NULL);
 	if (!ret)
-		smu->workload_mask = workload_mask;
+		smu->workload_mask = selected_workload_mask;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 10689480338e..90a960fb1d14 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -280,7 +280,7 @@ void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
 	if (DISPLAY_VER(i915) < 20)
 		return;
 
-	if (!intel_dp_as_sdp_supported(intel_dp))
+	if (!intel_dp->as_sdp_supported)
 		return;
 
 	if (crtc_state->has_psr)
diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index 6c3333136737..ca28558a2c93 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -1011,7 +1011,7 @@ static u32 cnp_hz_to_pwm(struct intel_connector *connector, u32 pwm_freq_hz)
 {
 	struct drm_i915_private *i915 = to_i915(connector->base.dev);
 
-	return DIV_ROUND_CLOSEST(KHz(RUNTIME_INFO(i915)->rawclk_freq),
+	return DIV_ROUND_CLOSEST(KHz(DISPLAY_RUNTIME_INFO(i915)->rawclk_freq),
 				 pwm_freq_hz);
 }
 
@@ -1073,7 +1073,7 @@ static u32 pch_hz_to_pwm(struct intel_connector *connector, u32 pwm_freq_hz)
 {
 	struct drm_i915_private *i915 = to_i915(connector->base.dev);
 
-	return DIV_ROUND_CLOSEST(KHz(RUNTIME_INFO(i915)->rawclk_freq),
+	return DIV_ROUND_CLOSEST(KHz(DISPLAY_RUNTIME_INFO(i915)->rawclk_freq),
 				 pwm_freq_hz * 128);
 }
 
@@ -1091,7 +1091,7 @@ static u32 i9xx_hz_to_pwm(struct intel_connector *connector, u32 pwm_freq_hz)
 	int clock;
 
 	if (IS_PINEVIEW(i915))
-		clock = KHz(RUNTIME_INFO(i915)->rawclk_freq);
+		clock = KHz(DISPLAY_RUNTIME_INFO(i915)->rawclk_freq);
 	else
 		clock = KHz(i915->display.cdclk.hw.cdclk);
 
@@ -1109,7 +1109,7 @@ static u32 i965_hz_to_pwm(struct intel_connector *connector, u32 pwm_freq_hz)
 	int clock;
 
 	if (IS_G4X(i915))
-		clock = KHz(RUNTIME_INFO(i915)->rawclk_freq);
+		clock = KHz(DISPLAY_RUNTIME_INFO(i915)->rawclk_freq);
 	else
 		clock = KHz(i915->display.cdclk.hw.cdclk);
 
@@ -1133,7 +1133,7 @@ static u32 vlv_hz_to_pwm(struct intel_connector *connector, u32 pwm_freq_hz)
 			clock = MHz(25);
 		mul = 16;
 	} else {
-		clock = KHz(RUNTIME_INFO(i915)->rawclk_freq);
+		clock = KHz(DISPLAY_RUNTIME_INFO(i915)->rawclk_freq);
 		mul = 128;
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index dd7dce4b0e7a..ff3bac7dd9e3 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -1474,6 +1474,9 @@ static void __intel_display_device_info_runtime_init(struct drm_i915_private *i9
 		}
 	}
 
+	display_runtime->rawclk_freq = intel_read_rawclk(i915);
+	drm_dbg_kms(&i915->drm, "rawclk rate: %d kHz\n", display_runtime->rawclk_freq);
+
 	return;
 
 display_fused_off:
@@ -1516,6 +1519,8 @@ void intel_display_device_info_print(const struct intel_display_device_info *inf
 	drm_printf(p, "has_hdcp: %s\n", str_yes_no(runtime->has_hdcp));
 	drm_printf(p, "has_dmc: %s\n", str_yes_no(runtime->has_dmc));
 	drm_printf(p, "has_dsc: %s\n", str_yes_no(runtime->has_dsc));
+
+	drm_printf(p, "rawclk rate: %u kHz\n", runtime->rawclk_freq);
 }
 
 /*
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.h b/drivers/gpu/drm/i915/display/intel_display_device.h
index 13453ea4daea..ad60c676c84d 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.h
+++ b/drivers/gpu/drm/i915/display/intel_display_device.h
@@ -204,6 +204,8 @@ struct intel_display_runtime_info {
 		u16 step;
 	} ip;
 
+	u32 rawclk_freq;
+
 	u8 pipe_mask;
 	u8 cpu_transcoder_mask;
 	u16 port_mask;
diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index e288a1b21d7e..0af1e34ef2a7 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -1704,6 +1704,14 @@ static void icl_display_core_init(struct drm_i915_private *dev_priv,
 	/* Wa_14011503030:xelpd */
 	if (DISPLAY_VER(dev_priv) == 13)
 		intel_de_write(dev_priv, XELPD_DISPLAY_ERR_FATAL_MASK, ~0);
+
+	/* Wa_15013987218 */
+	if (DISPLAY_VER(dev_priv) == 20) {
+		intel_de_rmw(dev_priv, SOUTH_DSPCLK_GATE_D,
+			     0, PCH_GMBUSUNIT_CLOCK_GATE_DISABLE);
+		intel_de_rmw(dev_priv, SOUTH_DSPCLK_GATE_D,
+			     PCH_GMBUSUNIT_CLOCK_GATE_DISABLE, 0);
+	}
 }
 
 static void icl_display_core_uninit(struct drm_i915_private *dev_priv)
diff --git a/drivers/gpu/drm/i915/display/intel_display_power_well.c b/drivers/gpu/drm/i915/display/intel_display_power_well.c
index 919f712fef13..adf5d1fbccb5 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power_well.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power_well.c
@@ -1176,9 +1176,9 @@ static void vlv_init_display_clock_gating(struct drm_i915_private *dev_priv)
 		       MI_ARB_DISPLAY_TRICKLE_FEED_DISABLE);
 	intel_de_write(dev_priv, CBR1_VLV, 0);
 
-	drm_WARN_ON(&dev_priv->drm, RUNTIME_INFO(dev_priv)->rawclk_freq == 0);
+	drm_WARN_ON(&dev_priv->drm, DISPLAY_RUNTIME_INFO(dev_priv)->rawclk_freq == 0);
 	intel_de_write(dev_priv, RAWCLK_FREQ_VLV,
-		       DIV_ROUND_CLOSEST(RUNTIME_INFO(dev_priv)->rawclk_freq,
+		       DIV_ROUND_CLOSEST(DISPLAY_RUNTIME_INFO(dev_priv)->rawclk_freq,
 					 1000));
 }
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index f9d3cc3c342b..160098708eba 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1806,6 +1806,7 @@ struct intel_dp {
 
 	/* connector directly attached - won't be use for modeset in mst world */
 	struct intel_connector *attached_connector;
+	bool as_sdp_supported;
 
 	struct drm_dp_tunnel *tunnel;
 	bool tunnel_suspended:1;
diff --git a/drivers/gpu/drm/i915/display/intel_display_wa.h b/drivers/gpu/drm/i915/display/intel_display_wa.h
index 63201d09852c..be644ab6ae00 100644
--- a/drivers/gpu/drm/i915/display/intel_display_wa.h
+++ b/drivers/gpu/drm/i915/display/intel_display_wa.h
@@ -6,8 +6,16 @@
 #ifndef __INTEL_DISPLAY_WA_H__
 #define __INTEL_DISPLAY_WA_H__
 
+#include <linux/types.h>
+
 struct drm_i915_private;
 
 void intel_display_wa_apply(struct drm_i915_private *i915);
 
+#ifdef I915
+static inline bool intel_display_needs_wa_16023588340(struct drm_i915_private *i915) { return false; }
+#else
+bool intel_display_needs_wa_16023588340(struct drm_i915_private *i915);
+#endif
+
 #endif
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index ffc0d1b14045..4ec724e8b220 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -130,14 +130,6 @@ bool intel_dp_is_edp(struct intel_dp *intel_dp)
 	return dig_port->base.type == INTEL_OUTPUT_EDP;
 }
 
-bool intel_dp_as_sdp_supported(struct intel_dp *intel_dp)
-{
-	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
-
-	return HAS_AS_SDP(i915) &&
-		drm_dp_as_sdp_supported(&intel_dp->aux, intel_dp->dpcd);
-}
-
 static void intel_dp_unset_edid(struct intel_dp *intel_dp);
 
 /* Is link rate UHBR and thus 128b/132b? */
@@ -2635,8 +2627,7 @@ static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
 	const struct drm_display_mode *adjusted_mode =
 		&crtc_state->hw.adjusted_mode;
 
-	if (!crtc_state->vrr.enable ||
-	    !intel_dp_as_sdp_supported(intel_dp))
+	if (!crtc_state->vrr.enable || !intel_dp->as_sdp_supported)
 		return;
 
 	crtc_state->infoframes.enable |= intel_hdmi_infoframe_enable(DP_SDP_ADAPTIVE_SYNC);
@@ -4402,8 +4393,11 @@ void intel_dp_set_infoframes(struct intel_encoder *encoder,
 	if (!enable && HAS_DSC(dev_priv))
 		val &= ~VDIP_ENABLE_PPS;
 
-	/* When PSR is enabled, this routine doesn't disable VSC DIP */
-	if (!crtc_state->has_psr)
+	/*
+	 * This routine disables VSC DIP if the function is called
+	 * to disable SDP or if it does not have PSR
+	 */
+	if (!enable || !crtc_state->has_psr)
 		val &= ~VIDEO_DIP_ENABLE_VSC_HSW;
 
 	intel_de_write(dev_priv, reg, val);
@@ -5921,6 +5915,15 @@ intel_dp_detect_dsc_caps(struct intel_dp *intel_dp, struct intel_connector *conn
 					  connector);
 }
 
+static void
+intel_dp_detect_sdp_caps(struct intel_dp *intel_dp)
+{
+	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
+
+	intel_dp->as_sdp_supported = HAS_AS_SDP(i915) &&
+		drm_dp_as_sdp_supported(&intel_dp->aux, intel_dp->dpcd);
+}
+
 static int
 intel_dp_detect(struct drm_connector *connector,
 		struct drm_modeset_acquire_ctx *ctx,
@@ -5991,6 +5994,8 @@ intel_dp_detect(struct drm_connector *connector,
 
 	intel_dp_detect_dsc_caps(intel_dp, intel_connector);
 
+	intel_dp_detect_sdp_caps(intel_dp);
+
 	intel_dp_mst_configure(intel_dp);
 
 	if (intel_dp->reset_link_params) {
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915/display/intel_dp.h
index a0f990a95ecc..9be539edf817 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -85,7 +85,6 @@ void intel_dp_audio_compute_config(struct intel_encoder *encoder,
 				   struct drm_connector_state *conn_state);
 bool intel_dp_has_hdmi_sink(struct intel_dp *intel_dp);
 bool intel_dp_is_edp(struct intel_dp *intel_dp);
-bool intel_dp_as_sdp_supported(struct intel_dp *intel_dp);
 bool intel_dp_is_uhbr(const struct intel_crtc_state *crtc_state);
 bool intel_dp_has_dsc(const struct intel_connector *connector);
 int intel_dp_link_symbol_size(int rate);
diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.c b/drivers/gpu/drm/i915/display/intel_dp_aux.c
index be58185a77c0..6420da69f3bb 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux.c
@@ -84,7 +84,7 @@ static u32 g4x_get_aux_clock_divider(struct intel_dp *intel_dp, int index)
 	 * The clock divider is based off the hrawclk, and would like to run at
 	 * 2MHz.  So, take the hrawclk value and divide by 2000 and use that
 	 */
-	return DIV_ROUND_CLOSEST(RUNTIME_INFO(i915)->rawclk_freq, 2000);
+	return DIV_ROUND_CLOSEST(DISPLAY_RUNTIME_INFO(i915)->rawclk_freq, 2000);
 }
 
 static u32 ilk_get_aux_clock_divider(struct intel_dp *intel_dp, int index)
@@ -104,7 +104,7 @@ static u32 ilk_get_aux_clock_divider(struct intel_dp *intel_dp, int index)
 	if (dig_port->aux_ch == AUX_CH_A)
 		freq = i915->display.cdclk.hw.cdclk;
 	else
-		freq = RUNTIME_INFO(i915)->rawclk_freq;
+		freq = DISPLAY_RUNTIME_INFO(i915)->rawclk_freq;
 	return DIV_ROUND_CLOSEST(freq, 2000);
 }
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp_hdcp.c b/drivers/gpu/drm/i915/display/intel_dp_hdcp.c
index b0101d72b9c1..71bf014a57e5 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_hdcp.c
@@ -677,8 +677,15 @@ static
 int intel_dp_hdcp2_get_capability(struct intel_connector *connector,
 				  bool *capable)
 {
-	struct intel_digital_port *dig_port = intel_attached_dig_port(connector);
-	struct drm_dp_aux *aux = &dig_port->dp.aux;
+	struct intel_digital_port *dig_port;
+	struct drm_dp_aux *aux;
+
+	*capable = false;
+	if (!intel_attached_encoder(connector))
+		return -EINVAL;
+
+	dig_port = intel_attached_dig_port(connector);
+	aux = &dig_port->dp.aux;
 
 	return _intel_dp_hdcp2_get_capability(aux, capable);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
index 67116c9f1464..8488f82143a4 100644
--- a/drivers/gpu/drm/i915/display/intel_fbc.c
+++ b/drivers/gpu/drm/i915/display/intel_fbc.c
@@ -56,6 +56,7 @@
 #include "intel_display_device.h"
 #include "intel_display_trace.h"
 #include "intel_display_types.h"
+#include "intel_display_wa.h"
 #include "intel_fbc.h"
 #include "intel_fbc_regs.h"
 #include "intel_frontbuffer.h"
@@ -1237,6 +1238,11 @@ static int intel_fbc_check_plane(struct intel_atomic_state *state,
 		return 0;
 	}
 
+	if (intel_display_needs_wa_16023588340(i915)) {
+		plane_state->no_fbc_reason = "Wa_16023588340";
+		return 0;
+	}
+
 	/* WaFbcTurnOffFbcWhenHyperVisorIsUsed:skl,bxt */
 	if (i915_vtd_active(i915) && (IS_SKYLAKE(i915) || IS_BROXTON(i915))) {
 		plane_state->no_fbc_reason = "VT-d enabled";
diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index b0440cc59c23..c2f42be26128 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -203,11 +203,16 @@ int intel_hdcp_read_valid_bksv(struct intel_digital_port *dig_port,
 /* Is HDCP1.4 capable on Platform and Sink */
 bool intel_hdcp_get_capability(struct intel_connector *connector)
 {
-	struct intel_digital_port *dig_port = intel_attached_dig_port(connector);
+	struct intel_digital_port *dig_port;
 	const struct intel_hdcp_shim *shim = connector->hdcp.shim;
 	bool capable = false;
 	u8 bksv[5];
 
+	if (!intel_attached_encoder(connector))
+		return capable;
+
+	dig_port = intel_attached_dig_port(connector);
+
 	if (!shim)
 		return capable;
 
diff --git a/drivers/gpu/drm/i915/display/intel_pps.c b/drivers/gpu/drm/i915/display/intel_pps.c
index 7ce926241e83..68141af4da54 100644
--- a/drivers/gpu/drm/i915/display/intel_pps.c
+++ b/drivers/gpu/drm/i915/display/intel_pps.c
@@ -951,6 +951,14 @@ void intel_pps_on_unlocked(struct intel_dp *intel_dp)
 		intel_de_posting_read(dev_priv, pp_ctrl_reg);
 	}
 
+	/*
+	 * WA: 22019252566
+	 * Disable DPLS gating around power sequence.
+	 */
+	if (IS_DISPLAY_VER(dev_priv, 13, 14))
+		intel_de_rmw(dev_priv, SOUTH_DSPCLK_GATE_D,
+			     0, PCH_DPLSUNIT_CLOCK_GATE_DISABLE);
+
 	pp |= PANEL_POWER_ON;
 	if (!IS_IRONLAKE(dev_priv))
 		pp |= PANEL_POWER_RESET;
@@ -961,6 +969,10 @@ void intel_pps_on_unlocked(struct intel_dp *intel_dp)
 	wait_panel_on(intel_dp);
 	intel_dp->pps.last_power_on = jiffies;
 
+	if (IS_DISPLAY_VER(dev_priv, 13, 14))
+		intel_de_rmw(dev_priv, SOUTH_DSPCLK_GATE_D,
+			     PCH_DPLSUNIT_CLOCK_GATE_DISABLE, 0);
+
 	if (IS_IRONLAKE(dev_priv)) {
 		pp |= PANEL_POWER_RESET; /* restore panel reset bit */
 		intel_de_write(dev_priv, pp_ctrl_reg, pp);
@@ -1471,7 +1483,7 @@ static void pps_init_registers(struct intel_dp *intel_dp, bool force_disable_vdd
 {
 	struct drm_i915_private *dev_priv = dp_to_i915(intel_dp);
 	u32 pp_on, pp_off, port_sel = 0;
-	int div = RUNTIME_INFO(dev_priv)->rawclk_freq / 1000;
+	int div = DISPLAY_RUNTIME_INFO(dev_priv)->rawclk_freq / 1000;
 	struct pps_registers regs;
 	enum port port = dp_to_dig_port(intel_dp)->base.port;
 	const struct edp_power_seq *seq = &intel_dp->pps.pps_delays;
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index da242ba19ed9..0876fe53a6f9 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1605,6 +1605,12 @@ _panel_replay_compute_config(struct intel_dp *intel_dp,
 	if (!alpm_config_valid(intel_dp, crtc_state, true))
 		return false;
 
+	if (crtc_state->crc_enabled) {
+		drm_dbg_kms(&i915->drm,
+			    "Panel Replay not enabled because it would inhibit pipe CRC calculation\n");
+		return false;
+	}
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index 9887967b2ca5..6f2ee7dbc43b 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -393,6 +393,9 @@ void intel_tc_port_set_fia_lane_count(struct intel_digital_port *dig_port,
 	bool lane_reversal = dig_port->saved_port_bits & DDI_BUF_PORT_REVERSAL;
 	u32 val;
 
+	if (DISPLAY_VER(i915) >= 14)
+		return;
+
 	drm_WARN_ON(&i915->drm,
 		    lane_reversal && tc->mode != TC_PORT_LEGACY);
 
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index 5a0da64c7db3..7e1d9c718214 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -233,8 +233,7 @@ intel_vrr_compute_config(struct intel_crtc_state *crtc_state,
 		crtc_state->mode_flags |= I915_MODE_FLAG_VRR;
 	}
 
-	if (intel_dp_as_sdp_supported(intel_dp) &&
-	    crtc_state->vrr.enable) {
+	if (intel_dp->as_sdp_supported && crtc_state->vrr.enable) {
 		crtc_state->vrr.vsync_start =
 			(crtc_state->hw.adjusted_mode.crtc_vtotal -
 			 crtc_state->hw.adjusted_mode.vsync_start);
diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index ba5a628b4757..a1ab64db0130 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -1085,11 +1085,6 @@ static u32 skl_plane_ctl(const struct intel_crtc_state *crtc_state,
 	if (DISPLAY_VER(dev_priv) == 13)
 		plane_ctl |= adlp_plane_ctl_arb_slots(plane_state);
 
-	if (GRAPHICS_VER(dev_priv) >= 20 &&
-	    fb->modifier == I915_FORMAT_MOD_4_TILED) {
-		plane_ctl |= PLANE_CTL_RENDER_DECOMPRESSION_ENABLE;
-	}
-
 	return plane_ctl;
 }
 
diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
index eede5417cb3f..01a650253050 100644
--- a/drivers/gpu/drm/i915/intel_device_info.c
+++ b/drivers/gpu/drm/i915/intel_device_info.c
@@ -124,7 +124,6 @@ void intel_device_info_print(const struct intel_device_info *info,
 #undef PRINT_FLAG
 
 	drm_printf(p, "has_pooled_eu: %s\n", str_yes_no(runtime->has_pooled_eu));
-	drm_printf(p, "rawclk rate: %u kHz\n", runtime->rawclk_freq);
 }
 
 #define ID(id) (id)
@@ -377,10 +376,6 @@ void intel_device_info_runtime_init(struct drm_i915_private *dev_priv)
 			 "Disabling ppGTT for VT-d support\n");
 		runtime->ppgtt_type = INTEL_PPGTT_NONE;
 	}
-
-	runtime->rawclk_freq = intel_read_rawclk(dev_priv);
-	drm_dbg(&dev_priv->drm, "rawclk rate: %d kHz\n", runtime->rawclk_freq);
-
 }
 
 /*
diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
index df73ef94615d..643ff1bf74ee 100644
--- a/drivers/gpu/drm/i915/intel_device_info.h
+++ b/drivers/gpu/drm/i915/intel_device_info.h
@@ -207,8 +207,6 @@ struct intel_runtime_info {
 
 	u16 device_id;
 
-	u32 rawclk_freq;
-
 	struct intel_step_info step;
 
 	unsigned int page_sizes; /* page sizes supported by the HW */
diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index a90504359e8d..e5d412b2d61b 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -120,44 +120,6 @@ static void mtk_drm_finish_page_flip(struct mtk_crtc *mtk_crtc)
 	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
 }
 
-#if IS_REACHABLE(CONFIG_MTK_CMDQ)
-static int mtk_drm_cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *pkt,
-				   size_t size)
-{
-	struct device *dev;
-	dma_addr_t dma_addr;
-
-	pkt->va_base = kzalloc(size, GFP_KERNEL);
-	if (!pkt->va_base)
-		return -ENOMEM;
-
-	pkt->buf_size = size;
-	pkt->cl = (void *)client;
-
-	dev = client->chan->mbox->dev;
-	dma_addr = dma_map_single(dev, pkt->va_base, pkt->buf_size,
-				  DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, dma_addr)) {
-		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
-		kfree(pkt->va_base);
-		return -ENOMEM;
-	}
-
-	pkt->pa_base = dma_addr;
-
-	return 0;
-}
-
-static void mtk_drm_cmdq_pkt_destroy(struct cmdq_pkt *pkt)
-{
-	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
-
-	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
-			 DMA_TO_DEVICE);
-	kfree(pkt->va_base);
-}
-#endif
-
 static void mtk_crtc_destroy(struct drm_crtc *crtc)
 {
 	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
@@ -165,9 +127,8 @@ static void mtk_crtc_destroy(struct drm_crtc *crtc)
 
 	mtk_mutex_put(mtk_crtc->mutex);
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	mtk_drm_cmdq_pkt_destroy(&mtk_crtc->cmdq_handle);
-
 	if (mtk_crtc->cmdq_client.chan) {
+		cmdq_pkt_destroy(&mtk_crtc->cmdq_client, &mtk_crtc->cmdq_handle);
 		mbox_free_channel(mtk_crtc->cmdq_client.chan);
 		mtk_crtc->cmdq_client.chan = NULL;
 	}
@@ -1122,9 +1083,9 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 			mbox_free_channel(mtk_crtc->cmdq_client.chan);
 			mtk_crtc->cmdq_client.chan = NULL;
 		} else {
-			ret = mtk_drm_cmdq_pkt_create(&mtk_crtc->cmdq_client,
-						      &mtk_crtc->cmdq_handle,
-						      PAGE_SIZE);
+			ret = cmdq_pkt_create(&mtk_crtc->cmdq_client,
+					      &mtk_crtc->cmdq_handle,
+					      PAGE_SIZE);
 			if (ret) {
 				dev_dbg(dev, "mtk_crtc %d failed to create cmdq packet\n",
 					drm_crtc_index(&mtk_crtc->base));
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 9d6d9fd8342e..064d03598ea2 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -61,8 +61,8 @@
 #define OVL_CON_CLRFMT_RGB	(1 << 12)
 #define OVL_CON_CLRFMT_ARGB8888	(2 << 12)
 #define OVL_CON_CLRFMT_RGBA8888	(3 << 12)
-#define OVL_CON_CLRFMT_ABGR8888	(OVL_CON_CLRFMT_RGBA8888 | OVL_CON_BYTE_SWAP)
-#define OVL_CON_CLRFMT_BGRA8888	(OVL_CON_CLRFMT_ARGB8888 | OVL_CON_BYTE_SWAP)
+#define OVL_CON_CLRFMT_ABGR8888	(OVL_CON_CLRFMT_ARGB8888 | OVL_CON_BYTE_SWAP)
+#define OVL_CON_CLRFMT_BGRA8888	(OVL_CON_CLRFMT_RGBA8888 | OVL_CON_BYTE_SWAP)
 #define OVL_CON_CLRFMT_UYVY	(4 << 12)
 #define OVL_CON_CLRFMT_YUYV	(5 << 12)
 #define OVL_CON_CLRFMT_RGB565(ovl)	((ovl)->data->fmt_rgb565_is_0 ? \
@@ -379,11 +379,6 @@ void mtk_ovl_layer_off(struct device *dev, unsigned int idx,
 
 static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl, unsigned int fmt)
 {
-	/* The return value in switch "MEM_MODE_INPUT_FORMAT_XXX"
-	 * is defined in mediatek HW data sheet.
-	 * The alphabet order in XXX is no relation to data
-	 * arrangement in memory.
-	 */
 	switch (fmt) {
 	default:
 	case DRM_FORMAT_RGB565:
diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index d8796a904eca..f2bee617f063 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -145,6 +145,89 @@ struct mtk_dp_data {
 	u16 audio_m_div2_bit;
 };
 
+static const struct mtk_dp_efuse_fmt mt8188_dp_efuse_fmt[MTK_DP_CAL_MAX] = {
+	[MTK_DP_CAL_GLB_BIAS_TRIM] = {
+		.idx = 0,
+		.shift = 10,
+		.mask = 0x1f,
+		.min_val = 1,
+		.max_val = 0x1e,
+		.default_val = 0xf,
+	},
+	[MTK_DP_CAL_CLKTX_IMPSE] = {
+		.idx = 0,
+		.shift = 15,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_0] = {
+		.idx = 1,
+		.shift = 0,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_1] = {
+		.idx = 1,
+		.shift = 8,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_2] = {
+		.idx = 1,
+		.shift = 16,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_3] = {
+		.idx = 1,
+		.shift = 24,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_0] = {
+		.idx = 1,
+		.shift = 4,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_1] = {
+		.idx = 1,
+		.shift = 12,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_2] = {
+		.idx = 1,
+		.shift = 20,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_3] = {
+		.idx = 1,
+		.shift = 28,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+};
+
 static const struct mtk_dp_efuse_fmt mt8195_edp_efuse_fmt[MTK_DP_CAL_MAX] = {
 	[MTK_DP_CAL_GLB_BIAS_TRIM] = {
 		.idx = 3,
@@ -2771,7 +2854,7 @@ static SIMPLE_DEV_PM_OPS(mtk_dp_pm_ops, mtk_dp_suspend, mtk_dp_resume);
 static const struct mtk_dp_data mt8188_dp_data = {
 	.bridge_type = DRM_MODE_CONNECTOR_DisplayPort,
 	.smc_cmd = MTK_DP_SIP_ATF_VIDEO_UNMUTE,
-	.efuse_fmt = mt8195_dp_efuse_fmt,
+	.efuse_fmt = mt8188_dp_efuse_fmt,
 	.audio_supported = true,
 	.audio_pkt_in_hblank_area = true,
 	.audio_m_div2_bit = MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index ef232c0c2049..4e2d3a02ea06 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -487,6 +487,7 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 					 struct panthor_fw_binary_iter *iter,
 					 u32 ehdr)
 {
+	ssize_t vm_pgsz = panthor_vm_page_size(ptdev->fw->vm);
 	struct panthor_fw_binary_section_entry_hdr hdr;
 	struct panthor_fw_section *section;
 	u32 section_size;
@@ -515,8 +516,7 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 		return -EINVAL;
 	}
 
-	if ((hdr.va.start & ~PAGE_MASK) != 0 ||
-	    (hdr.va.end & ~PAGE_MASK) != 0) {
+	if (!IS_ALIGNED(hdr.va.start, vm_pgsz) || !IS_ALIGNED(hdr.va.end, vm_pgsz)) {
 		drm_err(&ptdev->base, "Firmware corrupted, virtual addresses not page aligned: 0x%x-0x%x\n",
 			hdr.va.start, hdr.va.end);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 38f560864879..be97d56bc011 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -44,8 +44,7 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
 			to_panthor_bo(bo->obj)->exclusive_vm_root_gem != panthor_vm_root_gem(vm)))
 		goto out_free_bo;
 
-	ret = panthor_vm_unmap_range(vm, bo->va_node.start,
-				     panthor_kernel_bo_size(bo));
+	ret = panthor_vm_unmap_range(vm, bo->va_node.start, bo->va_node.size);
 	if (ret)
 		goto out_free_bo;
 
@@ -95,10 +94,16 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
 	}
 
 	bo = to_panthor_bo(&obj->base);
-	size = obj->base.size;
 	kbo->obj = &obj->base;
 	bo->flags = bo_flags;
 
+	/* The system and GPU MMU page size might differ, which becomes a
+	 * problem for FW sections that need to be mapped at explicit address
+	 * since our PAGE_SIZE alignment might cover a VA range that's
+	 * expected to be used for another section.
+	 * Make sure we never map more than we need.
+	 */
+	size = ALIGN(size, panthor_vm_page_size(vm));
 	ret = panthor_vm_alloc_va(vm, gpu_va, size, &kbo->va_node);
 	if (ret)
 		goto err_put_obj;
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index ce8e8a93d707..837ba312f3a8 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -826,6 +826,14 @@ void panthor_vm_idle(struct panthor_vm *vm)
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
 }
 
+u32 panthor_vm_page_size(struct panthor_vm *vm)
+{
+	const struct io_pgtable *pgt = io_pgtable_ops_to_pgtable(vm->pgtbl_ops);
+	u32 pg_shift = ffs(pgt->cfg.pgsize_bitmap) - 1;
+
+	return 1u << pg_shift;
+}
+
 static void panthor_vm_stop(struct panthor_vm *vm)
 {
 	drm_sched_stop(&vm->sched, NULL);
@@ -1025,12 +1033,13 @@ int
 panthor_vm_alloc_va(struct panthor_vm *vm, u64 va, u64 size,
 		    struct drm_mm_node *va_node)
 {
+	ssize_t vm_pgsz = panthor_vm_page_size(vm);
 	int ret;
 
-	if (!size || (size & ~PAGE_MASK))
+	if (!size || !IS_ALIGNED(size, vm_pgsz))
 		return -EINVAL;
 
-	if (va != PANTHOR_VM_KERNEL_AUTO_VA && (va & ~PAGE_MASK))
+	if (va != PANTHOR_VM_KERNEL_AUTO_VA && !IS_ALIGNED(va, vm_pgsz))
 		return -EINVAL;
 
 	mutex_lock(&vm->mm_lock);
@@ -2366,11 +2375,12 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 			       const struct drm_panthor_vm_bind_op *op,
 			       struct panthor_vm_op_ctx *op_ctx)
 {
+	ssize_t vm_pgsz = panthor_vm_page_size(vm);
 	struct drm_gem_object *gem;
 	int ret;
 
 	/* Aligned on page size. */
-	if ((op->va | op->size) & ~PAGE_MASK)
+	if (!IS_ALIGNED(op->va | op->size, vm_pgsz))
 		return -EINVAL;
 
 	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
index 6788771071e3..8d21e83d8aba 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu.h
@@ -30,6 +30,7 @@ panthor_vm_get_bo_for_va(struct panthor_vm *vm, u64 va, u64 *bo_offset);
 
 int panthor_vm_active(struct panthor_vm *vm);
 void panthor_vm_idle(struct panthor_vm *vm);
+u32 panthor_vm_page_size(struct panthor_vm *vm);
 int panthor_vm_as(struct panthor_vm *vm);
 int panthor_vm_flush_all(struct panthor_vm *vm);
 
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 4d1d5a342a4a..e9234488dc2b 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -589,10 +589,11 @@ struct panthor_group {
 	 * @timedout: True when a timeout occurred on any of the queues owned by
 	 * this group.
 	 *
-	 * Timeouts can be reported by drm_sched or by the FW. In any case, any
-	 * timeout situation is unrecoverable, and the group becomes useless.
-	 * We simply wait for all references to be dropped so we can release the
-	 * group object.
+	 * Timeouts can be reported by drm_sched or by the FW. If a reset is required,
+	 * and the group can't be suspended, this also leads to a timeout. In any case,
+	 * any timeout situation is unrecoverable, and the group becomes useless. We
+	 * simply wait for all references to be dropped so we can release the group
+	 * object.
 	 */
 	bool timedout;
 
@@ -2640,6 +2641,12 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
 		csgs_upd_ctx_init(&upd_ctx);
 		while (slot_mask) {
 			u32 csg_id = ffs(slot_mask) - 1;
+			struct panthor_csg_slot *csg_slot = &sched->csg_slots[csg_id];
+
+			/* We consider group suspension failures as fatal and flag the
+			 * group as unusable by setting timedout=true.
+			 */
+			csg_slot->group->timedout = true;
 
 			csgs_upd_ctx_queue_reqs(ptdev, &upd_ctx, csg_id,
 						CSG_STATE_TERMINATE,
@@ -3409,6 +3416,11 @@ panthor_job_create(struct panthor_file *pfile,
 		goto err_put_job;
 	}
 
+	if (!group_can_run(job->group)) {
+		ret = -EINVAL;
+		goto err_put_job;
+	}
+
 	if (job->queue_idx >= job->group->queue_count ||
 	    !job->group->queues[job->queue_idx]) {
 		ret = -EINVAL;
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index d79c76a287f2..6a29ac1b2d21 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1152,8 +1152,8 @@ static int host1x_drm_probe(struct host1x_device *dev)
 
 	if (host1x_drm_wants_iommu(dev) && device_iommu_mapped(dma_dev)) {
 		tegra->domain = iommu_paging_domain_alloc(dma_dev);
-		if (!tegra->domain) {
-			err = -ENOMEM;
+		if (IS_ERR(tegra->domain)) {
+			err = PTR_ERR(tegra->domain);
 			goto free;
 		}
 
diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 15e36a8db685..6bba97d0be88 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -996,7 +996,7 @@ static void drm_test_drm_hdmi_compute_mode_clock_rgb(struct kunit *test)
 	unsigned long long rate;
 	struct drm_device *drm = &priv->drm;
 
-	mode = drm_display_mode_from_cea_vic(drm, 16);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1017,7 +1017,7 @@ static void drm_test_drm_hdmi_compute_mode_clock_rgb_10bpc(struct kunit *test)
 	unsigned long long rate;
 	struct drm_device *drm = &priv->drm;
 
-	mode = drm_display_mode_from_cea_vic(drm, 16);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1038,7 +1038,7 @@ static void drm_test_drm_hdmi_compute_mode_clock_rgb_10bpc_vic_1(struct kunit *t
 	unsigned long long rate;
 	struct drm_device *drm = &priv->drm;
 
-	mode = drm_display_mode_from_cea_vic(drm, 1);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	rate = drm_hdmi_compute_mode_clock(mode, 10, HDMI_COLORSPACE_RGB);
@@ -1056,7 +1056,7 @@ static void drm_test_drm_hdmi_compute_mode_clock_rgb_12bpc(struct kunit *test)
 	unsigned long long rate;
 	struct drm_device *drm = &priv->drm;
 
-	mode = drm_display_mode_from_cea_vic(drm, 16);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1077,7 +1077,7 @@ static void drm_test_drm_hdmi_compute_mode_clock_rgb_12bpc_vic_1(struct kunit *t
 	unsigned long long rate;
 	struct drm_device *drm = &priv->drm;
 
-	mode = drm_display_mode_from_cea_vic(drm, 1);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	rate = drm_hdmi_compute_mode_clock(mode, 12, HDMI_COLORSPACE_RGB);
@@ -1095,7 +1095,7 @@ static void drm_test_drm_hdmi_compute_mode_clock_rgb_double(struct kunit *test)
 	unsigned long long rate;
 	struct drm_device *drm = &priv->drm;
 
-	mode = drm_display_mode_from_cea_vic(drm, 6);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 6);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_TRUE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1118,7 +1118,7 @@ static void drm_test_connector_hdmi_compute_mode_clock_yuv420_valid(struct kunit
 	unsigned long long rate;
 	unsigned int vic = *(unsigned int *)test->param_value;
 
-	mode = drm_display_mode_from_cea_vic(drm, vic);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, vic);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1155,7 +1155,7 @@ static void drm_test_connector_hdmi_compute_mode_clock_yuv420_10_bpc(struct kuni
 		drm_hdmi_compute_mode_clock_yuv420_vic_valid_tests[0];
 	unsigned long long rate;
 
-	mode = drm_display_mode_from_cea_vic(drm, vic);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, vic);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1180,7 +1180,7 @@ static void drm_test_connector_hdmi_compute_mode_clock_yuv420_12_bpc(struct kuni
 		drm_hdmi_compute_mode_clock_yuv420_vic_valid_tests[0];
 	unsigned long long rate;
 
-	mode = drm_display_mode_from_cea_vic(drm, vic);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, vic);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1203,7 +1203,7 @@ static void drm_test_connector_hdmi_compute_mode_clock_yuv422_8_bpc(struct kunit
 	struct drm_device *drm = &priv->drm;
 	unsigned long long rate;
 
-	mode = drm_display_mode_from_cea_vic(drm, 16);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1225,7 +1225,7 @@ static void drm_test_connector_hdmi_compute_mode_clock_yuv422_10_bpc(struct kuni
 	struct drm_device *drm = &priv->drm;
 	unsigned long long rate;
 
-	mode = drm_display_mode_from_cea_vic(drm, 16);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1247,7 +1247,7 @@ static void drm_test_connector_hdmi_compute_mode_clock_yuv422_12_bpc(struct kuni
 	struct drm_device *drm = &priv->drm;
 	unsigned long long rate;
 
-	mode = drm_display_mode_from_cea_vic(drm, 16);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 34ee95d41f29..294773342e71 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -441,7 +441,7 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	mode = drm_display_mode_from_cea_vic(drm, 1);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	drm = &priv->drm;
@@ -555,7 +555,7 @@ static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	mode = drm_display_mode_from_cea_vic(drm, 1);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	drm = &priv->drm;
@@ -671,7 +671,7 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	mode = drm_display_mode_from_cea_vic(drm, 1);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	drm = &priv->drm;
@@ -1263,7 +1263,7 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	mode = drm_display_mode_from_cea_vic(drm, 1);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	/*
diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index aa62719dab0e..04a6b8cc62ac 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -3,6 +3,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_edid.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_managed.h>
@@ -311,6 +312,47 @@ drm_kunit_helper_create_crtc(struct kunit *test,
 }
 EXPORT_SYMBOL_GPL(drm_kunit_helper_create_crtc);
 
+static void kunit_action_drm_mode_destroy(void *ptr)
+{
+	struct drm_display_mode *mode = ptr;
+
+	drm_mode_destroy(NULL, mode);
+}
+
+/**
+ * drm_kunit_display_mode_from_cea_vic() - return a mode for CEA VIC
+					   for a KUnit test
+ * @test: The test context object
+ * @dev: DRM device
+ * @video_code: CEA VIC of the mode
+ *
+ * Creates a new mode matching the specified CEA VIC for a KUnit test.
+ *
+ * Resources will be cleaned up automatically.
+ *
+ * Returns: A new drm_display_mode on success or NULL on failure
+ */
+struct drm_display_mode *
+drm_kunit_display_mode_from_cea_vic(struct kunit *test, struct drm_device *dev,
+				    u8 video_code)
+{
+	struct drm_display_mode *mode;
+	int ret;
+
+	mode = drm_display_mode_from_cea_vic(dev, video_code);
+	if (!mode)
+		return NULL;
+
+	ret = kunit_add_action_or_reset(test,
+					kunit_action_drm_mode_destroy,
+					mode);
+	if (ret)
+		return NULL;
+
+	return mode;
+}
+EXPORT_SYMBOL_GPL(drm_kunit_display_mode_from_cea_vic);
+
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
 MODULE_DESCRIPTION("KUnit test suite helper functions");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 1979614a90bd..1ff9602a52f6 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -175,6 +175,7 @@ xe-$(CONFIG_DRM_XE_DISPLAY) += \
 	display/xe_display.o \
 	display/xe_display_misc.o \
 	display/xe_display_rps.o \
+	display/xe_display_wa.o \
 	display/xe_dsb_buffer.o \
 	display/xe_fb_pin.o \
 	display/xe_hdcp_gsc.o \
diff --git a/drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h b/drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h
index 1f1ad4d3ef51..a7d206133922 100644
--- a/drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h
+++ b/drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h
@@ -116,7 +116,6 @@ struct i915_sched_attr {
 #define i915_gem_fence_wait_priority(fence, attr) do { (void) attr; } while (0)
 
 #define pdev_to_i915 pdev_to_xe_device
-#define RUNTIME_INFO(xe)		(&(xe)->info.i915_runtime)
 
 #define FORCEWAKE_ALL XE_FORCEWAKE_ALL
 
diff --git a/drivers/gpu/drm/xe/display/xe_display_wa.c b/drivers/gpu/drm/xe/display/xe_display_wa.c
new file mode 100644
index 000000000000..68e3d1959ad6
--- /dev/null
+++ b/drivers/gpu/drm/xe/display/xe_display_wa.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2024 Intel Corporation
+ */
+
+#include "intel_display_wa.h"
+
+#include "xe_device.h"
+#include "xe_wa.h"
+
+#include <generated/xe_wa_oob.h>
+
+bool intel_display_needs_wa_16023588340(struct drm_i915_private *i915)
+{
+	return XE_WA(xe_root_mmio_gt(i915), 16023588340);
+}
diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index 3c2865040058..660ff42e45a6 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -80,7 +80,10 @@
 #define   LE_CACHEABILITY_MASK			REG_GENMASK(1, 0)
 #define   LE_CACHEABILITY(value)		REG_FIELD_PREP(LE_CACHEABILITY_MASK, value)
 
-#define XE2_GAMREQSTRM_CTRL			XE_REG(0x4194)
+#define STATELESS_COMPRESSION_CTRL		XE_REG_MCR(0x4148)
+#define   UNIFIED_COMPRESSION_FORMAT		REG_GENMASK(3, 0)
+
+#define XE2_GAMREQSTRM_CTRL			XE_REG_MCR(0x4194)
 #define   CG_DIS_CNTLBUS			REG_BIT(6)
 
 #define CCS_AUX_INV				XE_REG(0x4208)
@@ -91,6 +94,8 @@
 #define VE1_AUX_INV				XE_REG(0x42b8)
 #define   AUX_INV				REG_BIT(0)
 
+#define XE2_LMEM_CFG				XE_REG(0x48b0)
+
 #define XEHP_TILE_ADDR_RANGE(_idx)		XE_REG_MCR(0x4900 + (_idx) * 4)
 #define XEHP_FLAT_CCS_BASE_ADDR			XE_REG_MCR(0x4910)
 #define XEHP_FLAT_CCS_PTR			REG_GENMASK(31, 8)
@@ -100,12 +105,14 @@
 
 #define CHICKEN_RASTER_1			XE_REG_MCR(0x6204, XE_REG_OPTION_MASKED)
 #define   DIS_SF_ROUND_NEAREST_EVEN		REG_BIT(8)
+#define   DIS_CLIP_NEGATIVE_BOUNDING_BOX	REG_BIT(6)
 
 #define CHICKEN_RASTER_2			XE_REG_MCR(0x6208, XE_REG_OPTION_MASKED)
 #define   TBIMR_FAST_CLIP			REG_BIT(5)
 
 #define FF_MODE					XE_REG_MCR(0x6210)
 #define   DIS_TE_AUTOSTRIP			REG_BIT(31)
+#define   VS_HIT_MAX_VALUE_MASK			REG_GENMASK(25, 20)
 #define   DIS_MESH_PARTIAL_AUTOSTRIP		REG_BIT(16)
 #define   DIS_MESH_AUTOSTRIP			REG_BIT(15)
 
@@ -190,6 +197,7 @@
 #define GSCPSMI_BASE				XE_REG(0x880c)
 
 #define CCCHKNREG1				XE_REG_MCR(0x8828)
+#define   L3CMPCTRL				REG_BIT(23)
 #define   ENCOMPPERFFIX				REG_BIT(18)
 
 /* Fuse readout registers for GT */
@@ -364,6 +372,9 @@
 #define XEHP_L3NODEARBCFG			XE_REG_MCR(0xb0b4)
 #define   XEHP_LNESPARE				REG_BIT(19)
 
+#define L3SQCREG2				XE_REG_MCR(0xb104)
+#define   COMPMEMRD256BOVRFETCHEN		REG_BIT(20)
+
 #define L3SQCREG3				XE_REG_MCR(0xb108)
 #define   COMPPWOVERFETCHEN			REG_BIT(28)
 
@@ -403,6 +414,10 @@
 #define   INVALIDATION_BROADCAST_MODE_DIS	REG_BIT(12)
 #define   GLOBAL_INVALIDATION_MODE		REG_BIT(2)
 
+#define LMEM_CFG				XE_REG(0xcf58)
+#define   LMEM_EN				REG_BIT(31)
+#define   LMTT_DIR_PTR				REG_GENMASK(30, 0) /* in multiples of 64KB */
+
 #define HALF_SLICE_CHICKEN5			XE_REG_MCR(0xe188, XE_REG_OPTION_MASKED)
 #define   DISABLE_SAMPLE_G_PERFORMANCE		REG_BIT(0)
 
diff --git a/drivers/gpu/drm/xe/regs/xe_regs.h b/drivers/gpu/drm/xe/regs/xe_regs.h
index 23e33ec84902..55bf47c99016 100644
--- a/drivers/gpu/drm/xe/regs/xe_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_regs.h
@@ -24,11 +24,14 @@
 #define   LMEM_INIT				REG_BIT(7)
 #define   DRIVERFLR				REG_BIT(31)
 
+#define XEHP_CLOCK_GATE_DIS			XE_REG(0x101014)
+#define   SGSI_SIDECLK_DIS			REG_BIT(17)
+
 #define GU_DEBUG				XE_REG(0x101018)
 #define   DRIVERFLR_STATUS			REG_BIT(31)
 
-#define XEHP_CLOCK_GATE_DIS			XE_REG(0x101014)
-#define   SGSI_SIDECLK_DIS			REG_BIT(17)
+#define VIRTUAL_CTRL_REG			XE_REG(0x10108c)
+#define   GUEST_GTT_UPDATE_EN			REG_BIT(8)
 
 #define XEHP_MTCFG_ADDR				XE_REG(0x101800)
 #define   TILE_COUNT				REG_GENMASK(15, 8)
@@ -66,6 +69,9 @@
 #define   DISPLAY_IRQ				REG_BIT(16)
 #define   GT_DW_IRQ(x)				REG_BIT(x)
 
+#define VF_CAP_REG				XE_REG(0x1901f8, XE_REG_OPTION_VF)
+#define   VF_CAP				REG_BIT(0)
+
 #define PVC_RP_STATE_CAP			XE_REG(0x281014)
 
 #endif
diff --git a/drivers/gpu/drm/xe/regs/xe_sriov_regs.h b/drivers/gpu/drm/xe/regs/xe_sriov_regs.h
deleted file mode 100644
index 017b4ddd1ecf..000000000000
--- a/drivers/gpu/drm/xe/regs/xe_sriov_regs.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Copyright © 2023 Intel Corporation
- */
-
-#ifndef _REGS_XE_SRIOV_REGS_H_
-#define _REGS_XE_SRIOV_REGS_H_
-
-#include "regs/xe_reg_defs.h"
-
-#define XE2_LMEM_CFG			XE_REG(0x48b0)
-
-#define LMEM_CFG			XE_REG(0xcf58)
-#define   LMEM_EN			REG_BIT(31)
-#define   LMTT_DIR_PTR			REG_GENMASK(30, 0) /* in multiples of 64KB */
-
-#define VIRTUAL_CTRL_REG		XE_REG(0x10108c)
-#define   GUEST_GTT_UPDATE_EN		REG_BIT(8)
-
-#define VF_CAP_REG			XE_REG(0x1901f8, XE_REG_OPTION_VF)
-#define   VF_CAP			REG_BIT(0)
-
-#endif
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index a7c7812d5791..ebdb6f2d1ca7 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -297,12 +297,6 @@ struct xe_device {
 		u8 has_atomic_enable_pte_bit:1;
 		/** @info.has_device_atomics_on_smem: Supports device atomics on SMEM */
 		u8 has_device_atomics_on_smem:1;
-
-#if IS_ENABLED(CONFIG_DRM_XE_DISPLAY)
-		struct {
-			u32 rawclk_freq;
-		} i915_runtime;
-#endif
 	} info;
 
 	/** @irq: device interrupt state */
diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index 0cdbc1296e88..226542bb1442 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -309,6 +309,16 @@ static void ggtt_invalidate_gt_tlb(struct xe_gt *gt)
 
 static void xe_ggtt_invalidate(struct xe_ggtt *ggtt)
 {
+	struct xe_device *xe = tile_to_xe(ggtt->tile);
+
+	/*
+	 * XXX: Barrier for GGTT pages. Unsure exactly why this required but
+	 * without this LNL is having issues with the GuC reading scratch page
+	 * vs. correct GGTT page. Not particularly a hot code path so blindly
+	 * do a mmio read here which results in GuC reading correct GGTT page.
+	 */
+	xe_mmio_read32(xe_root_mmio_gt(xe), VF_CAP_REG);
+
 	/* Each GT in a tile has its own TLB to cache GGTT lookups */
 	ggtt_invalidate_gt_tlb(ggtt->tile->primary_gt);
 	ggtt_invalidate_gt_tlb(ggtt->tile->media_gt);
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 0062a5e4d5fa..ba9f50c1faa6 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -109,9 +109,9 @@ static void xe_gt_enable_host_l2_vram(struct xe_gt *gt)
 
 	if (!xe_gt_is_media_type(gt)) {
 		xe_mmio_write32(gt, SCRATCH1LPFC, EN_L3_RW_CCS_CACHE_FLUSH);
-		reg = xe_mmio_read32(gt, XE2_GAMREQSTRM_CTRL);
+		reg = xe_gt_mcr_unicast_read_any(gt, XE2_GAMREQSTRM_CTRL);
 		reg |= CG_DIS_CNTLBUS;
-		xe_mmio_write32(gt, XE2_GAMREQSTRM_CTRL, reg);
+		xe_gt_mcr_multicast_write(gt, XE2_GAMREQSTRM_CTRL, reg);
 	}
 
 	xe_gt_mcr_multicast_write(gt, XEHPC_L3CLOS_MASK(3), 0x3);
@@ -133,9 +133,9 @@ static void xe_gt_disable_host_l2_vram(struct xe_gt *gt)
 	if (WARN_ON(err))
 		return;
 
-	reg = xe_mmio_read32(gt, XE2_GAMREQSTRM_CTRL);
+	reg = xe_gt_mcr_unicast_read_any(gt, XE2_GAMREQSTRM_CTRL);
 	reg &= ~CG_DIS_CNTLBUS;
-	xe_mmio_write32(gt, XE2_GAMREQSTRM_CTRL, reg);
+	xe_gt_mcr_multicast_write(gt, XE2_GAMREQSTRM_CTRL, reg);
 
 	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
 }
@@ -555,7 +555,6 @@ int xe_gt_init_hwconfig(struct xe_gt *gt)
 
 	xe_gt_mcr_init_early(gt);
 	xe_pat_init(gt);
-	xe_gt_enable_host_l2_vram(gt);
 
 	err = xe_uc_init(&gt->uc);
 	if (err)
@@ -567,6 +566,7 @@ int xe_gt_init_hwconfig(struct xe_gt *gt)
 
 	xe_gt_topology_init(gt);
 	xe_gt_mcr_init(gt);
+	xe_gt_enable_host_l2_vram(gt);
 
 out_fw:
 	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
index 9dbba9ab7a9a..ef239440963c 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
@@ -5,7 +5,7 @@
 
 #include <drm/drm_managed.h>
 
-#include "regs/xe_sriov_regs.h"
+#include "regs/xe_regs.h"
 
 #include "xe_gt_sriov_pf.h"
 #include "xe_gt_sriov_pf_config.h"
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index dfd809e7bbd2..cbdd44567d10 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -989,12 +989,22 @@ static void xe_guc_exec_queue_lr_cleanup(struct work_struct *w)
 static bool check_timeout(struct xe_exec_queue *q, struct xe_sched_job *job)
 {
 	struct xe_gt *gt = guc_to_gt(exec_queue_to_guc(q));
-	u32 ctx_timestamp = xe_lrc_ctx_timestamp(q->lrc[0]);
-	u32 ctx_job_timestamp = xe_lrc_ctx_job_timestamp(q->lrc[0]);
+	u32 ctx_timestamp, ctx_job_timestamp;
 	u32 timeout_ms = q->sched_props.job_timeout_ms;
 	u32 diff;
 	u64 running_time_ms;
 
+	if (!xe_sched_job_started(job)) {
+		xe_gt_warn(gt, "Check job timeout: seqno=%u, lrc_seqno=%u, guc_id=%d, not started",
+			   xe_sched_job_seqno(job), xe_sched_job_lrc_seqno(job),
+			   q->guc->id);
+
+		return xe_sched_invalidate_job(job, 2);
+	}
+
+	ctx_timestamp = xe_lrc_ctx_timestamp(q->lrc[0]);
+	ctx_job_timestamp = xe_lrc_ctx_job_timestamp(q->lrc[0]);
+
 	/*
 	 * Counter wraps at ~223s at the usual 19.2MHz, be paranoid catch
 	 * possible overflows with a high timeout.
@@ -1120,10 +1130,6 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 		exec_queue_killed_or_banned_or_wedged(q) ||
 		exec_queue_destroyed(q);
 
-	/* Job hasn't started, can't be timed out */
-	if (!skip_timeout_check && !xe_sched_job_started(job))
-		goto rearm;
-
 	/*
 	 * XXX: Sampling timeout doesn't work in wedged mode as we have to
 	 * modify scheduling state to read timestamp. We could read the
diff --git a/drivers/gpu/drm/xe/xe_lmtt.c b/drivers/gpu/drm/xe/xe_lmtt.c
index 418661a88918..c5fdb36b6d33 100644
--- a/drivers/gpu/drm/xe/xe_lmtt.c
+++ b/drivers/gpu/drm/xe/xe_lmtt.c
@@ -7,7 +7,7 @@
 
 #include <drm/drm_managed.h>
 
-#include "regs/xe_sriov_regs.h"
+#include "regs/xe_gt_regs.h"
 
 #include "xe_assert.h"
 #include "xe_bo.h"
diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
index 499540add465..464ec24e2dd2 100644
--- a/drivers/gpu/drm/xe/xe_module.c
+++ b/drivers/gpu/drm/xe/xe_module.c
@@ -8,6 +8,8 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
+#include <drm/drm_module.h>
+
 #include "xe_drv.h"
 #include "xe_hw_fence.h"
 #include "xe_pci.h"
@@ -61,12 +63,23 @@ module_param_named_unsafe(wedged_mode, xe_modparam.wedged_mode, int, 0600);
 MODULE_PARM_DESC(wedged_mode,
 		 "Module's default policy for the wedged mode - 0=never, 1=upon-critical-errors[default], 2=upon-any-hang");
 
+static int xe_check_nomodeset(void)
+{
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
+	return 0;
+}
+
 struct init_funcs {
 	int (*init)(void);
 	void (*exit)(void);
 };
 
 static const struct init_funcs init_funcs[] = {
+	{
+		.init = xe_check_nomodeset,
+	},
 	{
 		.init = xe_hw_fence_module_init,
 		.exit = xe_hw_fence_module_exit,
@@ -85,15 +98,35 @@ static const struct init_funcs init_funcs[] = {
 	},
 };
 
+static int __init xe_call_init_func(unsigned int i)
+{
+	if (WARN_ON(i >= ARRAY_SIZE(init_funcs)))
+		return 0;
+	if (!init_funcs[i].init)
+		return 0;
+
+	return init_funcs[i].init();
+}
+
+static void xe_call_exit_func(unsigned int i)
+{
+	if (WARN_ON(i >= ARRAY_SIZE(init_funcs)))
+		return;
+	if (!init_funcs[i].exit)
+		return;
+
+	init_funcs[i].exit();
+}
+
 static int __init xe_init(void)
 {
 	int err, i;
 
 	for (i = 0; i < ARRAY_SIZE(init_funcs); i++) {
-		err = init_funcs[i].init();
+		err = xe_call_init_func(i);
 		if (err) {
 			while (i--)
-				init_funcs[i].exit();
+				xe_call_exit_func(i);
 			return err;
 		}
 	}
@@ -106,7 +139,7 @@ static void __exit xe_exit(void)
 	int i;
 
 	for (i = ARRAY_SIZE(init_funcs) - 1; i >= 0; i--)
-		init_funcs[i].exit();
+		xe_call_exit_func(i);
 }
 
 module_init(xe_init);
diff --git a/drivers/gpu/drm/xe/xe_sriov.c b/drivers/gpu/drm/xe/xe_sriov.c
index a274a5fb1401..5a1d65e4f19f 100644
--- a/drivers/gpu/drm/xe/xe_sriov.c
+++ b/drivers/gpu/drm/xe/xe_sriov.c
@@ -5,7 +5,7 @@
 
 #include <drm/drm_managed.h>
 
-#include "regs/xe_sriov_regs.h"
+#include "regs/xe_regs.h"
 
 #include "xe_assert.h"
 #include "xe_device.h"
diff --git a/drivers/gpu/drm/xe/xe_tuning.c b/drivers/gpu/drm/xe/xe_tuning.c
index d4e6fa918942..faa1bf42e50e 100644
--- a/drivers/gpu/drm/xe/xe_tuning.c
+++ b/drivers/gpu/drm/xe/xe_tuning.c
@@ -39,12 +39,23 @@ static const struct xe_rtp_entry_sr gt_tunings[] = {
 	},
 	{ XE_RTP_NAME("Tuning: Compression Overfetch"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, XE_RTP_END_VERSION_UNDEFINED)),
-	  XE_RTP_ACTIONS(CLR(CCCHKNREG1, ENCOMPPERFFIX)),
+	  XE_RTP_ACTIONS(CLR(CCCHKNREG1, ENCOMPPERFFIX),
+			 SET(CCCHKNREG1, L3CMPCTRL))
 	},
 	{ XE_RTP_NAME("Tuning: Enable compressible partial write overfetch in L3"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, XE_RTP_END_VERSION_UNDEFINED)),
 	  XE_RTP_ACTIONS(SET(L3SQCREG3, COMPPWOVERFETCHEN))
 	},
+	{ XE_RTP_NAME("Tuning: L2 Overfetch Compressible Only"),
+	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, XE_RTP_END_VERSION_UNDEFINED)),
+	  XE_RTP_ACTIONS(SET(L3SQCREG2,
+			     COMPMEMRD256BOVRFETCHEN))
+	},
+	{ XE_RTP_NAME("Tuning: Stateless compression control"),
+	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, XE_RTP_END_VERSION_UNDEFINED)),
+	  XE_RTP_ACTIONS(FIELD_SET(STATELESS_COMPRESSION_CTRL, UNIFIED_COMPRESSION_FORMAT,
+				   REG_FIELD_PREP(UNIFIED_COMPRESSION_FORMAT, 0)))
+	},
 	{}
 };
 
@@ -93,6 +104,14 @@ static const struct xe_rtp_entry_sr lrc_tunings[] = {
 				   REG_FIELD_PREP(L3_PWM_TIMER_INIT_VAL_MASK, 0x7f)))
 	},
 
+	/* Xe2_HPG */
+
+	{ XE_RTP_NAME("Tuning: vs hit max value"),
+	  XE_RTP_RULES(GRAPHICS_VERSION(2001), ENGINE_CLASS(RENDER)),
+	  XE_RTP_ACTIONS(FIELD_SET(FF_MODE, VS_HIT_MAX_VALUE_MASK,
+				   REG_FIELD_PREP(VS_HIT_MAX_VALUE_MASK, 0x3f)))
+	},
+
 	{}
 };
 
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index e648265d081b..e2d7ccc6f144 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -733,6 +733,10 @@ static const struct xe_rtp_entry_sr lrc_was[] = {
 			     DIS_PARTIAL_AUTOSTRIP |
 			     DIS_AUTOSTRIP))
 	},
+	{ XE_RTP_NAME("15016589081"),
+	  XE_RTP_RULES(GRAPHICS_VERSION(2001), ENGINE_CLASS(RENDER)),
+	  XE_RTP_ACTIONS(SET(CHICKEN_RASTER_1, DIS_CLIP_NEGATIVE_BOUNDING_BOX))
+	},
 
 	{}
 };
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 108e9ccab1ef..e00074c88522 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -645,7 +645,7 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val2 != 0) {
+		if (val2 != 0 || val == 0) {
 			ret = -EINVAL;
 			break;
 		}
diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 59d7615c0f56..5f131bc1a01e 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -307,13 +307,15 @@ static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
 	if (ret)
 		goto err_free_out;
 
+	for (i = 0; i < gts->num_itime; i++)
+		kfree(per_time_gains[i]);
 	kfree(per_time_gains);
 	gts->per_time_avail_scale_tables = per_time_scales;
 
 	return 0;
 
 err_free_out:
-	for (i--; i; i--) {
+	for (i--; i >= 0; i--) {
 		kfree(per_time_scales[i]);
 		kfree(per_time_gains[i]);
 	}
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 9630de1c578e..621428885455 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -522,7 +522,7 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
 			}
 			if (mask == IIO_CHAN_INFO_PROCESSED) {
 				*val = (reg * data->cur_resolution) / 10000;
-				*val2 = (reg * data->cur_resolution) % 10000;
+				*val2 = (reg * data->cur_resolution) % 10000 * 100;
 				return IIO_VAL_INT_PLUS_MICRO;
 			}
 			*val = reg;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 03d517be9c52..560a0f7bff85 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1532,9 +1532,11 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 	u32 tbl_indx;
 	int rc;
 
+	spin_lock_bh(&rcfw->tbl_lock);
 	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
 	rcfw->qp_tbl[tbl_indx].qp_id = BNXT_QPLIB_QP_ID_INVALID;
 	rcfw->qp_tbl[tbl_indx].qp_handle = NULL;
+	spin_unlock_bh(&rcfw->tbl_lock);
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_DESTROY_QP,
@@ -1545,8 +1547,10 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 				sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc) {
+		spin_lock_bh(&rcfw->tbl_lock);
 		rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
 		rcfw->qp_tbl[tbl_indx].qp_handle = qp;
+		spin_unlock_bh(&rcfw->tbl_lock);
 		return rc;
 	}
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 7294221b3316..e82bd37158ad 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -290,7 +290,6 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	struct bnxt_qplib_hwq *hwq;
 	u32 sw_prod, cmdq_prod;
 	struct pci_dev *pdev;
-	unsigned long flags;
 	u16 cookie;
 	u8 *preq;
 
@@ -301,7 +300,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	/* Cmdq are in 16-byte units, each request can consume 1 or more
 	 * cmdqe
 	 */
-	spin_lock_irqsave(&hwq->lock, flags);
+	spin_lock_bh(&hwq->lock);
 	required_slots = bnxt_qplib_get_cmd_slots(msg->req);
 	free_slots = HWQ_FREE_SLOTS(hwq);
 	cookie = cmdq->seq_num & RCFW_MAX_COOKIE_VALUE;
@@ -311,7 +310,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 		dev_info_ratelimited(&pdev->dev,
 				     "CMDQ is full req/free %d/%d!",
 				     required_slots, free_slots);
-		spin_unlock_irqrestore(&hwq->lock, flags);
+		spin_unlock_bh(&hwq->lock);
 		return -EAGAIN;
 	}
 	if (msg->block)
@@ -367,7 +366,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	wmb();
 	writel(cmdq_prod, cmdq->cmdq_mbox.prod);
 	writel(RCFW_CMDQ_TRIG_VAL, cmdq->cmdq_mbox.db);
-	spin_unlock_irqrestore(&hwq->lock, flags);
+	spin_unlock_bh(&hwq->lock);
 	/* Return the CREQ response pointer */
 	return 0;
 }
@@ -486,7 +485,6 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 {
 	struct creq_qp_event *evnt = (struct creq_qp_event *)msg->resp;
 	struct bnxt_qplib_crsqe *crsqe;
-	unsigned long flags;
 	u16 cookie;
 	int rc;
 	u8 opcode;
@@ -512,12 +510,12 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 		rc = __poll_for_resp(rcfw, cookie);
 
 	if (rc) {
-		spin_lock_irqsave(&rcfw->cmdq.hwq.lock, flags);
+		spin_lock_bh(&rcfw->cmdq.hwq.lock);
 		crsqe = &rcfw->crsqe_tbl[cookie];
 		crsqe->is_waiter_alive = false;
 		if (rc == -ENODEV)
 			set_bit(FIRMWARE_STALL_DETECTED, &rcfw->cmdq.flags);
-		spin_unlock_irqrestore(&rcfw->cmdq.hwq.lock, flags);
+		spin_unlock_bh(&rcfw->cmdq.hwq.lock);
 		return -ETIMEDOUT;
 	}
 
@@ -628,7 +626,6 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	u16 cookie, blocked = 0;
 	bool is_waiter_alive;
 	struct pci_dev *pdev;
-	unsigned long flags;
 	u32 wait_cmds = 0;
 	int rc = 0;
 
@@ -637,17 +634,21 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
 		err_event = (struct creq_qp_error_notification *)qp_event;
 		qp_id = le32_to_cpu(err_event->xid);
+		spin_lock(&rcfw->tbl_lock);
 		tbl_indx = map_qp_id_to_tbl_indx(qp_id, rcfw);
 		qp = rcfw->qp_tbl[tbl_indx].qp_handle;
+		if (!qp) {
+			spin_unlock(&rcfw->tbl_lock);
+			break;
+		}
+		bnxt_qplib_mark_qp_error(qp);
+		rc = rcfw->creq.aeq_handler(rcfw, qp_event, qp);
+		spin_unlock(&rcfw->tbl_lock);
 		dev_dbg(&pdev->dev, "Received QP error notification\n");
 		dev_dbg(&pdev->dev,
 			"qpid 0x%x, req_err=0x%x, resp_err=0x%x\n",
 			qp_id, err_event->req_err_state_reason,
 			err_event->res_err_state_reason);
-		if (!qp)
-			break;
-		bnxt_qplib_mark_qp_error(qp);
-		rc = rcfw->creq.aeq_handler(rcfw, qp_event, qp);
 		break;
 	default:
 		/*
@@ -659,8 +660,7 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 		 *
 		 */
 
-		spin_lock_irqsave_nested(&hwq->lock, flags,
-					 SINGLE_DEPTH_NESTING);
+		spin_lock_nested(&hwq->lock, SINGLE_DEPTH_NESTING);
 		cookie = le16_to_cpu(qp_event->cookie);
 		blocked = cookie & RCFW_CMD_IS_BLOCKING;
 		cookie &= RCFW_MAX_COOKIE_VALUE;
@@ -672,7 +672,7 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 			dev_info(&pdev->dev,
 				 "rcfw timedout: cookie = %#x, free_slots = %d",
 				 cookie, crsqe->free_slots);
-			spin_unlock_irqrestore(&hwq->lock, flags);
+			spin_unlock(&hwq->lock);
 			return rc;
 		}
 
@@ -720,7 +720,7 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 			__destroy_timedout_ah(rcfw,
 					      (struct creq_create_ah_resp *)
 					      qp_event);
-		spin_unlock_irqrestore(&hwq->lock, flags);
+		spin_unlock(&hwq->lock);
 	}
 	*num_wait += wait_cmds;
 	return rc;
@@ -734,12 +734,11 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 	u32 type, budget = CREQ_ENTRY_POLL_BUDGET;
 	struct bnxt_qplib_hwq *hwq = &creq->hwq;
 	struct creq_base *creqe;
-	unsigned long flags;
 	u32 num_wakeup = 0;
 	u32 hw_polled = 0;
 
 	/* Service the CREQ until budget is over */
-	spin_lock_irqsave(&hwq->lock, flags);
+	spin_lock_bh(&hwq->lock);
 	while (budget > 0) {
 		creqe = bnxt_qplib_get_qe(hwq, hwq->cons, NULL);
 		if (!CREQ_CMP_VALID(creqe, creq->creq_db.dbinfo.flags))
@@ -782,7 +781,7 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 	if (hw_polled)
 		bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo,
 				      rcfw->res->cctx, true);
-	spin_unlock_irqrestore(&hwq->lock, flags);
+	spin_unlock_bh(&hwq->lock);
 	if (num_wakeup)
 		wake_up_nr(&rcfw->cmdq.waitq, num_wakeup);
 }
@@ -978,6 +977,7 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 			       GFP_KERNEL);
 	if (!rcfw->qp_tbl)
 		goto fail;
+	spin_lock_init(&rcfw->tbl_lock);
 
 	rcfw->max_timeout = res->cctx->hwrm_cmd_max_timeout;
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 45996e60a0d0..07779aeb7575 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -224,6 +224,8 @@ struct bnxt_qplib_rcfw {
 	struct bnxt_qplib_crsqe		*crsqe_tbl;
 	int qp_tbl_size;
 	struct bnxt_qplib_qp_node *qp_tbl;
+	/* To synchronize the qp-handle hash table */
+	spinlock_t			tbl_lock;
 	u64 oos_prev;
 	u32 init_oos_stats;
 	u32 cmdq_depth;
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 246b739ddb2b..9008584946c6 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -474,6 +474,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.fill_res_cq_entry = c4iw_fill_res_cq_entry,
 	.fill_res_cm_id_entry = c4iw_fill_res_cm_id_entry,
 	.fill_res_mr_entry = c4iw_fill_res_mr_entry,
+	.fill_res_qp_entry = c4iw_fill_res_qp_entry,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = c4iw_get_dma_mr,
 	.get_hw_stats = c4iw_get_mib,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index e39b1a101e97..10ce3b44f645 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4268,14 +4268,14 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 		MLX5_SET(qpc, qpc, retry_count, attr->retry_cnt);
 
 	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC && attr->max_rd_atomic)
-		MLX5_SET(qpc, qpc, log_sra_max, ilog2(attr->max_rd_atomic));
+		MLX5_SET(qpc, qpc, log_sra_max, fls(attr->max_rd_atomic - 1));
 
 	if (attr_mask & IB_QP_SQ_PSN)
 		MLX5_SET(qpc, qpc, next_send_psn, attr->sq_psn);
 
 	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC && attr->max_dest_rd_atomic)
 		MLX5_SET(qpc, qpc, log_rra_max,
-			 ilog2(attr->max_dest_rd_atomic));
+			 fls(attr->max_dest_rd_atomic - 1));
 
 	if (attr_mask & (IB_QP_ACCESS_FLAGS | IB_QP_MAX_DEST_RD_ATOMIC)) {
 		err = set_qpc_atomic_flags(qp, attr, attr_mask, qpc);
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 54c57b267b25..865d3f8e97a6 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -119,12 +119,12 @@ static void input_pass_values(struct input_dev *dev,
 
 	handle = rcu_dereference(dev->grab);
 	if (handle) {
-		count = handle->handler->events(handle, vals, count);
+		count = handle->handle_events(handle, vals, count);
 	} else {
 		list_for_each_entry_rcu(handle, &dev->h_list, d_node)
 			if (handle->open) {
-				count = handle->handler->events(handle, vals,
-								count);
+				count = handle->handle_events(handle, vals,
+							      count);
 				if (!count)
 					break;
 			}
@@ -2537,57 +2537,6 @@ static int input_handler_check_methods(const struct input_handler *handler)
 	return 0;
 }
 
-/*
- * An implementation of input_handler's events() method that simply
- * invokes handler->event() method for each event one by one.
- */
-static unsigned int input_handler_events_default(struct input_handle *handle,
-						 struct input_value *vals,
-						 unsigned int count)
-{
-	struct input_handler *handler = handle->handler;
-	struct input_value *v;
-
-	for (v = vals; v != vals + count; v++)
-		handler->event(handle, v->type, v->code, v->value);
-
-	return count;
-}
-
-/*
- * An implementation of input_handler's events() method that invokes
- * handler->filter() method for each event one by one and removes events
- * that were filtered out from the "vals" array.
- */
-static unsigned int input_handler_events_filter(struct input_handle *handle,
-						struct input_value *vals,
-						unsigned int count)
-{
-	struct input_handler *handler = handle->handler;
-	struct input_value *end = vals;
-	struct input_value *v;
-
-	for (v = vals; v != vals + count; v++) {
-		if (handler->filter(handle, v->type, v->code, v->value))
-			continue;
-		if (end != v)
-			*end = *v;
-		end++;
-	}
-
-	return end - vals;
-}
-
-/*
- * An implementation of input_handler's events() method that does nothing.
- */
-static unsigned int input_handler_events_null(struct input_handle *handle,
-					      struct input_value *vals,
-					      unsigned int count)
-{
-	return count;
-}
-
 /**
  * input_register_handler - register a new input handler
  * @handler: handler to be registered
@@ -2607,13 +2556,6 @@ int input_register_handler(struct input_handler *handler)
 
 	INIT_LIST_HEAD(&handler->h_list);
 
-	if (handler->filter)
-		handler->events = input_handler_events_filter;
-	else if (handler->event)
-		handler->events = input_handler_events_default;
-	else if (!handler->events)
-		handler->events = input_handler_events_null;
-
 	error = mutex_lock_interruptible(&input_mutex);
 	if (error)
 		return error;
@@ -2687,6 +2629,75 @@ int input_handler_for_each_handle(struct input_handler *handler, void *data,
 }
 EXPORT_SYMBOL(input_handler_for_each_handle);
 
+/*
+ * An implementation of input_handle's handle_events() method that simply
+ * invokes handler->event() method for each event one by one.
+ */
+static unsigned int input_handle_events_default(struct input_handle *handle,
+						struct input_value *vals,
+						unsigned int count)
+{
+	struct input_handler *handler = handle->handler;
+	struct input_value *v;
+
+	for (v = vals; v != vals + count; v++)
+		handler->event(handle, v->type, v->code, v->value);
+
+	return count;
+}
+
+/*
+ * An implementation of input_handle's handle_events() method that invokes
+ * handler->filter() method for each event one by one and removes events
+ * that were filtered out from the "vals" array.
+ */
+static unsigned int input_handle_events_filter(struct input_handle *handle,
+					       struct input_value *vals,
+					       unsigned int count)
+{
+	struct input_handler *handler = handle->handler;
+	struct input_value *end = vals;
+	struct input_value *v;
+
+	for (v = vals; v != vals + count; v++) {
+		if (handler->filter(handle, v->type, v->code, v->value))
+			continue;
+		if (end != v)
+			*end = *v;
+		end++;
+	}
+
+	return end - vals;
+}
+
+/*
+ * An implementation of input_handle's handle_events() method that does nothing.
+ */
+static unsigned int input_handle_events_null(struct input_handle *handle,
+					     struct input_value *vals,
+					     unsigned int count)
+{
+	return count;
+}
+
+/*
+ * Sets up appropriate handle->event_handler based on the input_handler
+ * associated with the handle.
+ */
+static void input_handle_setup_event_handler(struct input_handle *handle)
+{
+	struct input_handler *handler = handle->handler;
+
+	if (handler->filter)
+		handle->handle_events = input_handle_events_filter;
+	else if (handler->event)
+		handle->handle_events = input_handle_events_default;
+	else if (handler->events)
+		handle->handle_events = handler->events;
+	else
+		handle->handle_events = input_handle_events_null;
+}
+
 /**
  * input_register_handle - register a new input handle
  * @handle: handle to register
@@ -2704,6 +2715,7 @@ int input_register_handle(struct input_handle *handle)
 	struct input_dev *dev = handle->dev;
 	int error;
 
+	input_handle_setup_event_handler(handle);
 	/*
 	 * We take dev->mutex here to prevent race with
 	 * input_release_device().
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index e70415f189a5..126b0ed85aa5 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1121,6 +1121,14 @@ static void edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
 	}
 }
 
+static void edt_ft5x06_exit_regmap(void *arg)
+{
+	struct edt_ft5x06_ts_data *data = arg;
+
+	if (!IS_ERR_OR_NULL(data->regmap))
+		regmap_exit(data->regmap);
+}
+
 static void edt_ft5x06_disable_regulators(void *arg)
 {
 	struct edt_ft5x06_ts_data *data = arg;
@@ -1154,6 +1162,16 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 		return PTR_ERR(tsdata->regmap);
 	}
 
+	/*
+	 * We are not using devm_regmap_init_i2c() and instead install a
+	 * custom action because we may replace regmap with M06-specific one
+	 * and we need to make sure that it will not be released too early.
+	 */
+	error = devm_add_action_or_reset(&client->dev, edt_ft5x06_exit_regmap,
+					 tsdata);
+	if (error)
+		return error;
+
 	chip_data = device_get_match_data(&client->dev);
 	if (!chip_data)
 		chip_data = (const struct edt_i2c_chip_data *)id->driver_data;
@@ -1347,7 +1365,6 @@ static void edt_ft5x06_ts_remove(struct i2c_client *client)
 	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
 
 	edt_ft5x06_ts_teardown_debugfs(tsdata);
-	regmap_exit(tsdata->regmap);
 }
 
 static int edt_ft5x06_ts_suspend(struct device *dev)
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 9d090fa07516..be011cef12e5 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -321,7 +321,7 @@ void mei_io_cb_free(struct mei_cl_cb *cb)
 		return;
 
 	list_del(&cb->list);
-	kfree(cb->buf.data);
+	kvfree(cb->buf.data);
 	kfree(cb->ext_hdr);
 	kfree(cb);
 }
@@ -497,7 +497,7 @@ struct mei_cl_cb *mei_cl_alloc_cb(struct mei_cl *cl, size_t length,
 	if (length == 0)
 		return cb;
 
-	cb->buf.data = kmalloc(roundup(length, MEI_SLOT_SIZE), GFP_KERNEL);
+	cb->buf.data = kvmalloc(roundup(length, MEI_SLOT_SIZE), GFP_KERNEL);
 	if (!cb->buf.data) {
 		mei_io_cb_free(cb);
 		return NULL;
diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/grukservices.c
index 37e804bbb1f2..205945ce9e86 100644
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -258,7 +258,6 @@ static int gru_get_cpu_resources(int dsr_bytes, void **cb, void **dsr)
 	int lcpu;
 
 	BUG_ON(dsr_bytes > GRU_NUM_KERNEL_DSR_BYTES);
-	preempt_disable();
 	bs = gru_lock_kernel_context(-1);
 	lcpu = uv_blade_processor_id();
 	*cb = bs->kernel_cb + lcpu * GRU_HANDLE_STRIDE;
@@ -272,7 +271,6 @@ static int gru_get_cpu_resources(int dsr_bytes, void **cb, void **dsr)
 static void gru_free_cpu_resources(void *cb, void *dsr)
 {
 	gru_unlock_kernel_context(uv_numa_blade_id());
-	preempt_enable();
 }
 
 /*
diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index 0f5b09e290c8..3036c15f3689 100644
--- a/drivers/misc/sgi-gru/grumain.c
+++ b/drivers/misc/sgi-gru/grumain.c
@@ -937,10 +937,8 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 
 again:
 	mutex_lock(&gts->ts_ctxlock);
-	preempt_disable();
 
 	if (gru_check_context_placement(gts)) {
-		preempt_enable();
 		mutex_unlock(&gts->ts_ctxlock);
 		gru_unload_context(gts, 1);
 		return VM_FAULT_NOPAGE;
@@ -949,7 +947,6 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 	if (!gts->ts_gru) {
 		STAT(load_user_context);
 		if (!gru_assign_gru_context(gts)) {
-			preempt_enable();
 			mutex_unlock(&gts->ts_ctxlock);
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(GRU_ASSIGN_DELAY);  /* true hack ZZZ */
@@ -965,7 +962,6 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 				vma->vm_page_prot);
 	}
 
-	preempt_enable();
 	mutex_unlock(&gts->ts_ctxlock);
 
 	return VM_FAULT_NOPAGE;
diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
index 10921cd2608d..1107dd3e2e9f 100644
--- a/drivers/misc/sgi-gru/grutlbpurge.c
+++ b/drivers/misc/sgi-gru/grutlbpurge.c
@@ -65,7 +65,6 @@ static struct gru_tlb_global_handle *get_lock_tgh_handle(struct gru_state
 	struct gru_tlb_global_handle *tgh;
 	int n;
 
-	preempt_disable();
 	if (uv_numa_blade_id() == gru->gs_blade_id)
 		n = get_on_blade_tgh(gru);
 	else
@@ -79,7 +78,6 @@ static struct gru_tlb_global_handle *get_lock_tgh_handle(struct gru_state
 static void get_unlock_tgh_handle(struct gru_tlb_global_handle *tgh)
 {
 	unlock_tgh_handle(tgh);
-	preempt_enable();
 }
 
 /*
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 0f81586a19df..68ce4920e01e 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -892,28 +892,40 @@ static void gl9767_disable_ssc_pll(struct pci_dev *pdev)
 	gl9767_vhs_read(pdev);
 }
 
+static void gl9767_set_low_power_negotiation(struct pci_dev *pdev, bool enable)
+{
+	u32 value;
+
+	gl9767_vhs_write(pdev);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
+	if (enable)
+		value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
+	else
+		value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
+
+	gl9767_vhs_read(pdev);
+}
+
 static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct mmc_ios *ios = &host->mmc->ios;
 	struct pci_dev *pdev;
-	u32 value;
 	u16 clk;
 
 	pdev = slot->chip->pdev;
 	host->mmc->actual_clock = 0;
 
-	gl9767_vhs_write(pdev);
-
-	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
-	value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
-	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
-
+	gl9767_set_low_power_negotiation(pdev, false);
 	gl9767_disable_ssc_pll(pdev);
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
-	if (clock == 0)
+	if (clock == 0) {
+		gl9767_set_low_power_negotiation(pdev, true);
 		return;
+	}
 
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
@@ -922,12 +934,7 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 	sdhci_enable_clk(host, clk);
-
-	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
-	value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
-	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
-
-	gl9767_vhs_read(pdev);
+	gl9767_set_low_power_negotiation(pdev, true);
 }
 
 static void gli_set_9767(struct sdhci_host *host)
@@ -1061,6 +1068,9 @@ static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
 		sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
 	}
 
+	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
+	value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
 	gl9767_vhs_read(pdev);
 
 	return 0;
diff --git a/drivers/net/ethernet/amd/mvme147.c b/drivers/net/ethernet/amd/mvme147.c
index c156566c0906..f19b04b92fa9 100644
--- a/drivers/net/ethernet/amd/mvme147.c
+++ b/drivers/net/ethernet/amd/mvme147.c
@@ -105,10 +105,6 @@ static struct net_device * __init mvme147lance_probe(void)
 	macaddr[3] = address&0xff;
 	eth_hw_addr_set(dev, macaddr);
 
-	printk("%s: MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
-	       dev->name, dev->base_addr, MVME147_LANCE_IRQ,
-	       dev->dev_addr);
-
 	lp = netdev_priv(dev);
 	lp->ram = __get_dma_pages(GFP_ATOMIC, 3);	/* 32K */
 	if (!lp->ram) {
@@ -138,6 +134,9 @@ static struct net_device * __init mvme147lance_probe(void)
 		return ERR_PTR(err);
 	}
 
+	netdev_info(dev, "MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
+		    dev->base_addr, MVME147_LANCE_IRQ, dev->dev_addr);
+
 	return dev;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index cc35d29ac9e6..d5ad6d84007c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -9,6 +9,8 @@
 #define ICE_CGU_STATE_ACQ_ERR_THRESHOLD		50
 #define ICE_DPLL_PIN_IDX_INVALID		0xff
 #define ICE_DPLL_RCLK_NUM_PER_PF		1
+#define ICE_DPLL_PIN_ESYNC_PULSE_HIGH_PERCENT	25
+#define ICE_DPLL_PIN_GEN_RCLK_FREQ		1953125
 
 /**
  * enum ice_dpll_pin_type - enumerate ice pin types:
@@ -30,6 +32,10 @@ static const char * const pin_type_name[] = {
 	[ICE_DPLL_PIN_TYPE_RCLK_INPUT] = "rclk-input",
 };
 
+static const struct dpll_pin_frequency ice_esync_range[] = {
+	DPLL_PIN_FREQUENCY_RANGE(0, DPLL_PIN_FREQUENCY_1_HZ),
+};
+
 /**
  * ice_dpll_is_reset - check if reset is in progress
  * @pf: private board structure
@@ -394,8 +400,8 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 
 	switch (pin_type) {
 	case ICE_DPLL_PIN_TYPE_INPUT:
-		ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, NULL, NULL,
-					       NULL, &pin->flags[0],
+		ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, &pin->status,
+					       NULL, NULL, &pin->flags[0],
 					       &pin->freq, &pin->phase_adjust);
 		if (ret)
 			goto err;
@@ -430,7 +436,7 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 			goto err;
 
 		parent &= ICE_AQC_GET_CGU_OUT_CFG_DPLL_SRC_SEL;
-		if (ICE_AQC_SET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
+		if (ICE_AQC_GET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
 			pin->state[pf->dplls.eec.dpll_idx] =
 				parent == pf->dplls.eec.dpll_idx ?
 				DPLL_PIN_STATE_CONNECTED :
@@ -1100,6 +1106,214 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
 	return 0;
 }
 
+/**
+ * ice_dpll_output_esync_set - callback for setting embedded sync
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @freq: requested embedded sync frequency
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for setting embedded sync frequency value
+ * on output pin.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_output_esync_set(const struct dpll_pin *pin, void *pin_priv,
+			  const struct dpll_device *dpll, void *dpll_priv,
+			  u64 freq, struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+	struct ice_pf *pf = d->pf;
+	u8 flags = 0;
+	int ret;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+	mutex_lock(&pf->dplls.lock);
+	if (p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_OUT_EN)
+		flags = ICE_AQC_SET_CGU_OUT_CFG_OUT_EN;
+	if (freq == DPLL_PIN_FREQUENCY_1_HZ) {
+		if (p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN) {
+			ret = 0;
+		} else {
+			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
+			ret = ice_aq_set_output_pin_cfg(&pf->hw, p->idx, flags,
+							0, 0, 0);
+		}
+	} else {
+		if (!(p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)) {
+			ret = 0;
+		} else {
+			flags &= ~ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
+			ret = ice_aq_set_output_pin_cfg(&pf->hw, p->idx, flags,
+							0, 0, 0);
+		}
+	}
+	mutex_unlock(&pf->dplls.lock);
+
+	return ret;
+}
+
+/**
+ * ice_dpll_output_esync_get - callback for getting embedded sync config
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @esync: on success holds embedded sync pin properties
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for getting embedded sync frequency value
+ * and capabilities on output pin.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_output_esync_get(const struct dpll_pin *pin, void *pin_priv,
+			  const struct dpll_device *dpll, void *dpll_priv,
+			  struct dpll_pin_esync *esync,
+			  struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+	struct ice_pf *pf = d->pf;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+	mutex_lock(&pf->dplls.lock);
+	if (!(p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_ABILITY) ||
+	    p->freq != DPLL_PIN_FREQUENCY_10_MHZ) {
+		mutex_unlock(&pf->dplls.lock);
+		return -EOPNOTSUPP;
+	}
+	esync->range = ice_esync_range;
+	esync->range_num = ARRAY_SIZE(ice_esync_range);
+	if (p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN) {
+		esync->freq = DPLL_PIN_FREQUENCY_1_HZ;
+		esync->pulse = ICE_DPLL_PIN_ESYNC_PULSE_HIGH_PERCENT;
+	} else {
+		esync->freq = 0;
+		esync->pulse = 0;
+	}
+	mutex_unlock(&pf->dplls.lock);
+
+	return 0;
+}
+
+/**
+ * ice_dpll_input_esync_set - callback for setting embedded sync
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @freq: requested embedded sync frequency
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for setting embedded sync frequency value
+ * on input pin.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_input_esync_set(const struct dpll_pin *pin, void *pin_priv,
+			 const struct dpll_device *dpll, void *dpll_priv,
+			 u64 freq, struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+	struct ice_pf *pf = d->pf;
+	u8 flags_en = 0;
+	int ret;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+	mutex_lock(&pf->dplls.lock);
+	if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN)
+		flags_en = ICE_AQC_SET_CGU_IN_CFG_FLG2_INPUT_EN;
+	if (freq == DPLL_PIN_FREQUENCY_1_HZ) {
+		if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN) {
+			ret = 0;
+		} else {
+			flags_en |= ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
+			ret = ice_aq_set_input_pin_cfg(&pf->hw, p->idx, 0,
+						       flags_en, 0, 0);
+		}
+	} else {
+		if (!(p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN)) {
+			ret = 0;
+		} else {
+			flags_en &= ~ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
+			ret = ice_aq_set_input_pin_cfg(&pf->hw, p->idx, 0,
+						       flags_en, 0, 0);
+		}
+	}
+	mutex_unlock(&pf->dplls.lock);
+
+	return ret;
+}
+
+/**
+ * ice_dpll_input_esync_get - callback for getting embedded sync config
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @esync: on success holds embedded sync pin properties
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for getting embedded sync frequency value
+ * and capabilities on input pin.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_input_esync_get(const struct dpll_pin *pin, void *pin_priv,
+			 const struct dpll_device *dpll, void *dpll_priv,
+			 struct dpll_pin_esync *esync,
+			 struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+	struct ice_pf *pf = d->pf;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+	mutex_lock(&pf->dplls.lock);
+	if (!(p->status & ICE_AQC_GET_CGU_IN_CFG_STATUS_ESYNC_CAP) ||
+	    p->freq != DPLL_PIN_FREQUENCY_10_MHZ) {
+		mutex_unlock(&pf->dplls.lock);
+		return -EOPNOTSUPP;
+	}
+	esync->range = ice_esync_range;
+	esync->range_num = ARRAY_SIZE(ice_esync_range);
+	if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN) {
+		esync->freq = DPLL_PIN_FREQUENCY_1_HZ;
+		esync->pulse = ICE_DPLL_PIN_ESYNC_PULSE_HIGH_PERCENT;
+	} else {
+		esync->freq = 0;
+		esync->pulse = 0;
+	}
+	mutex_unlock(&pf->dplls.lock);
+
+	return 0;
+}
+
 /**
  * ice_dpll_rclk_state_on_pin_set - set a state on rclk pin
  * @pin: pointer to a pin
@@ -1224,6 +1438,8 @@ static const struct dpll_pin_ops ice_dpll_input_ops = {
 	.phase_adjust_get = ice_dpll_pin_phase_adjust_get,
 	.phase_adjust_set = ice_dpll_input_phase_adjust_set,
 	.phase_offset_get = ice_dpll_phase_offset_get,
+	.esync_set = ice_dpll_input_esync_set,
+	.esync_get = ice_dpll_input_esync_get,
 };
 
 static const struct dpll_pin_ops ice_dpll_output_ops = {
@@ -1234,6 +1450,8 @@ static const struct dpll_pin_ops ice_dpll_output_ops = {
 	.direction_get = ice_dpll_output_direction,
 	.phase_adjust_get = ice_dpll_pin_phase_adjust_get,
 	.phase_adjust_set = ice_dpll_output_phase_adjust_set,
+	.esync_set = ice_dpll_output_esync_set,
+	.esync_get = ice_dpll_output_esync_get,
 };
 
 static const struct dpll_device_ops ice_dpll_ops = {
@@ -1846,6 +2064,73 @@ static int ice_dpll_init_worker(struct ice_pf *pf)
 	return 0;
 }
 
+/**
+ * ice_dpll_init_info_pins_generic - initializes generic pins info
+ * @pf: board private structure
+ * @input: if input pins initialized
+ *
+ * Init information for generic pins, cache them in PF's pins structures.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - init failure reason
+ */
+static int ice_dpll_init_info_pins_generic(struct ice_pf *pf, bool input)
+{
+	struct ice_dpll *de = &pf->dplls.eec, *dp = &pf->dplls.pps;
+	static const char labels[][sizeof("99")] = {
+		"0", "1", "2", "3", "4", "5", "6", "7", "8",
+		"9", "10", "11", "12", "13", "14", "15" };
+	u32 cap = DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+	enum ice_dpll_pin_type pin_type;
+	int i, pin_num, ret = -EINVAL;
+	struct ice_dpll_pin *pins;
+	u32 phase_adj_max;
+
+	if (input) {
+		pin_num = pf->dplls.num_inputs;
+		pins = pf->dplls.inputs;
+		phase_adj_max = pf->dplls.input_phase_adj_max;
+		pin_type = ICE_DPLL_PIN_TYPE_INPUT;
+		cap |= DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE;
+	} else {
+		pin_num = pf->dplls.num_outputs;
+		pins = pf->dplls.outputs;
+		phase_adj_max = pf->dplls.output_phase_adj_max;
+		pin_type = ICE_DPLL_PIN_TYPE_OUTPUT;
+	}
+	if (pin_num > ARRAY_SIZE(labels))
+		return ret;
+
+	for (i = 0; i < pin_num; i++) {
+		pins[i].idx = i;
+		pins[i].prop.board_label = labels[i];
+		pins[i].prop.phase_range.min = phase_adj_max;
+		pins[i].prop.phase_range.max = -phase_adj_max;
+		pins[i].prop.capabilities = cap;
+		pins[i].pf = pf;
+		ret = ice_dpll_pin_state_update(pf, &pins[i], pin_type, NULL);
+		if (ret)
+			break;
+		if (input && pins[i].freq == ICE_DPLL_PIN_GEN_RCLK_FREQ)
+			pins[i].prop.type = DPLL_PIN_TYPE_MUX;
+		else
+			pins[i].prop.type = DPLL_PIN_TYPE_EXT;
+		if (!input)
+			continue;
+		ret = ice_aq_get_cgu_ref_prio(&pf->hw, de->dpll_idx, i,
+					      &de->input_prio[i]);
+		if (ret)
+			break;
+		ret = ice_aq_get_cgu_ref_prio(&pf->hw, dp->dpll_idx, i,
+					      &dp->input_prio[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 /**
  * ice_dpll_init_info_direct_pins - initializes direct pins info
  * @pf: board private structure
@@ -1884,6 +2169,8 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 	default:
 		return -EINVAL;
 	}
+	if (num_pins != ice_cgu_get_num_pins(hw, input))
+		return ice_dpll_init_info_pins_generic(pf, input);
 
 	for (i = 0; i < num_pins; i++) {
 		caps = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index 93172e93995b..c320f1bf7d6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -31,6 +31,7 @@ struct ice_dpll_pin {
 	struct dpll_pin_properties prop;
 	u32 freq;
 	s32 phase_adjust;
+	u8 status;
 };
 
 /** ice_dpll - store info required for DPLL control
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a33e6b9b313..ec8db830ac73 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -34,7 +34,6 @@ static const struct ice_cgu_pin_desc ice_e810t_sfp_cgu_inputs[] = {
 		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
 	{ "GNSS-1PPS",	  ZL_REF4P, DPLL_PIN_TYPE_GNSS,
 		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
-	{ "OCXO",	  ZL_REF4N, DPLL_PIN_TYPE_INT_OSCILLATOR, 0, },
 };
 
 static const struct ice_cgu_pin_desc ice_e810t_qsfp_cgu_inputs[] = {
@@ -52,7 +51,6 @@ static const struct ice_cgu_pin_desc ice_e810t_qsfp_cgu_inputs[] = {
 		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
 	{ "GNSS-1PPS",	  ZL_REF4P, DPLL_PIN_TYPE_GNSS,
 		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
-	{ "OCXO",	  ZL_REF4N, DPLL_PIN_TYPE_INT_OSCILLATOR, },
 };
 
 static const struct ice_cgu_pin_desc ice_e810t_sfp_cgu_outputs[] = {
@@ -5964,6 +5962,25 @@ ice_cgu_get_pin_desc(struct ice_hw *hw, bool input, int *size)
 	return t;
 }
 
+/**
+ * ice_cgu_get_num_pins - get pin description array size
+ * @hw: pointer to the hw struct
+ * @input: if request is done against input or output pins
+ *
+ * Return: size of pin description array for given hw.
+ */
+int ice_cgu_get_num_pins(struct ice_hw *hw, bool input)
+{
+	const struct ice_cgu_pin_desc *t;
+	int size;
+
+	t = ice_cgu_get_pin_desc(hw, input, &size);
+	if (t)
+		return size;
+
+	return 0;
+}
+
 /**
  * ice_cgu_get_pin_type - get pin's type
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 0852a34ade91..6cedc1a906af 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -404,6 +404,7 @@ int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data);
 int ice_write_sma_ctrl_e810t(struct ice_hw *hw, u8 data);
 int ice_read_pca9575_reg_e810t(struct ice_hw *hw, u8 offset, u8 *data);
 bool ice_is_pca9575_present(struct ice_hw *hw);
+int ice_cgu_get_num_pins(struct ice_hw *hw, bool input);
 enum dpll_pin_type ice_cgu_get_pin_type(struct ice_hw *hw, u8 pin, bool input);
 struct dpll_pin_frequency *
 ice_cgu_get_pin_freq_supp(struct ice_hw *hw, u8 pin, bool input, u8 *num);
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.h b/drivers/net/ethernet/mediatek/mtk_wed_wo.h
index 87a67fa3868d..c01b1e8428f6 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.h
@@ -91,8 +91,8 @@ enum mtk_wed_dummy_cr_idx {
 #define MT7981_FIRMWARE_WO	"mediatek/mt7981_wo.bin"
 #define MT7986_FIRMWARE_WO0	"mediatek/mt7986_wo_0.bin"
 #define MT7986_FIRMWARE_WO1	"mediatek/mt7986_wo_1.bin"
-#define MT7988_FIRMWARE_WO0	"mediatek/mt7988_wo_0.bin"
-#define MT7988_FIRMWARE_WO1	"mediatek/mt7988_wo_1.bin"
+#define MT7988_FIRMWARE_WO0	"mediatek/mt7988/mt7988_wo_0.bin"
+#define MT7988_FIRMWARE_WO1	"mediatek/mt7988/mt7988_wo_1.bin"
 
 #define MTK_WO_MCU_CFG_LS_BASE				0
 #define MTK_WO_MCU_CFG_LS_HW_VER_ADDR			(MTK_WO_MCU_CFG_LS_BASE + 0x000)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 060e5b939211..d6f37456fb31 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -389,15 +389,27 @@ static void mlxsw_pci_wqe_frag_unmap(struct mlxsw_pci *mlxsw_pci, char *wqe,
 	dma_unmap_single(&pdev->dev, mapaddr, frag_len, direction);
 }
 
-static struct sk_buff *mlxsw_pci_rdq_build_skb(struct page *pages[],
+static struct sk_buff *mlxsw_pci_rdq_build_skb(struct mlxsw_pci_queue *q,
+					       struct page *pages[],
 					       u16 byte_count)
 {
+	struct mlxsw_pci_queue *cq = q->u.rdq.cq;
 	unsigned int linear_data_size;
+	struct page_pool *page_pool;
 	struct sk_buff *skb;
 	int page_index = 0;
 	bool linear_only;
 	void *data;
 
+	linear_only = byte_count + MLXSW_PCI_RX_BUF_SW_OVERHEAD <= PAGE_SIZE;
+	linear_data_size = linear_only ? byte_count :
+					 PAGE_SIZE -
+					 MLXSW_PCI_RX_BUF_SW_OVERHEAD;
+
+	page_pool = cq->u.cq.page_pool;
+	page_pool_dma_sync_for_cpu(page_pool, pages[page_index],
+				   MLXSW_PCI_SKB_HEADROOM, linear_data_size);
+
 	data = page_address(pages[page_index]);
 	net_prefetch(data);
 
@@ -405,11 +417,6 @@ static struct sk_buff *mlxsw_pci_rdq_build_skb(struct page *pages[],
 	if (unlikely(!skb))
 		return ERR_PTR(-ENOMEM);
 
-	linear_only = byte_count + MLXSW_PCI_RX_BUF_SW_OVERHEAD <= PAGE_SIZE;
-	linear_data_size = linear_only ? byte_count :
-					 PAGE_SIZE -
-					 MLXSW_PCI_RX_BUF_SW_OVERHEAD;
-
 	skb_reserve(skb, MLXSW_PCI_SKB_HEADROOM);
 	skb_put(skb, linear_data_size);
 
@@ -425,6 +432,7 @@ static struct sk_buff *mlxsw_pci_rdq_build_skb(struct page *pages[],
 
 		page = pages[page_index];
 		frag_size = min(byte_count, PAGE_SIZE);
+		page_pool_dma_sync_for_cpu(page_pool, page, 0, frag_size);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 				page, 0, frag_size, PAGE_SIZE);
 		byte_count -= frag_size;
@@ -760,7 +768,7 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 	if (err)
 		goto out;
 
-	skb = mlxsw_pci_rdq_build_skb(pages, byte_count);
+	skb = mlxsw_pci_rdq_build_skb(q, pages, byte_count);
 	if (IS_ERR(skb)) {
 		dev_err_ratelimited(&pdev->dev, "Failed to build skb for RDQ\n");
 		mlxsw_pci_rdq_pages_recycle(q, pages, num_sg_entries);
@@ -988,12 +996,13 @@ static int mlxsw_pci_cq_page_pool_init(struct mlxsw_pci_queue *q,
 	if (cq_type != MLXSW_PCI_CQ_RDQ)
 		return 0;
 
-	pp_params.flags = PP_FLAG_DMA_MAP;
+	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 	pp_params.pool_size = MLXSW_PCI_WQE_COUNT * mlxsw_pci->num_sg_entries;
 	pp_params.nid = dev_to_node(&mlxsw_pci->pdev->dev);
 	pp_params.dev = &mlxsw_pci->pdev->dev;
 	pp_params.napi = &q->u.cq.napi;
 	pp_params.dma_dir = DMA_FROM_DEVICE;
+	pp_params.max_len = PAGE_SIZE;
 
 	page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(page_pool))
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
index d761a1235994..7ea798a4949e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
@@ -481,11 +481,33 @@ mlxsw_sp_ipip_ol_netdev_change_gre6(struct mlxsw_sp *mlxsw_sp,
 				    struct mlxsw_sp_ipip_entry *ipip_entry,
 				    struct netlink_ext_ack *extack)
 {
+	u32 new_kvdl_index, old_kvdl_index = ipip_entry->dip_kvdl_index;
+	struct in6_addr old_addr6 = ipip_entry->parms.daddr.addr6;
 	struct mlxsw_sp_ipip_parms new_parms;
+	int err;
 
 	new_parms = mlxsw_sp_ipip_netdev_parms_init_gre6(ipip_entry->ol_dev);
-	return mlxsw_sp_ipip_ol_netdev_change_gre(mlxsw_sp, ipip_entry,
-						  &new_parms, extack);
+
+	err = mlxsw_sp_ipv6_addr_kvdl_index_get(mlxsw_sp,
+						&new_parms.daddr.addr6,
+						&new_kvdl_index);
+	if (err)
+		return err;
+	ipip_entry->dip_kvdl_index = new_kvdl_index;
+
+	err = mlxsw_sp_ipip_ol_netdev_change_gre(mlxsw_sp, ipip_entry,
+						 &new_parms, extack);
+	if (err)
+		goto err_change_gre;
+
+	mlxsw_sp_ipv6_addr_put(mlxsw_sp, &old_addr6);
+
+	return 0;
+
+err_change_gre:
+	ipip_entry->dip_kvdl_index = old_kvdl_index;
+	mlxsw_sp_ipv6_addr_put(mlxsw_sp, &new_parms.daddr.addr6);
+	return err;
 }
 
 static int
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
index 5b174cb95eb8..d94081c7658e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -16,6 +16,7 @@
 #include "spectrum.h"
 #include "spectrum_ptp.h"
 #include "core.h"
+#include "txheader.h"
 
 #define MLXSW_SP1_PTP_CLOCK_CYCLES_SHIFT	29
 #define MLXSW_SP1_PTP_CLOCK_FREQ_KHZ		156257 /* 6.4nSec */
@@ -1684,6 +1685,12 @@ int mlxsw_sp_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
 				 struct sk_buff *skb,
 				 const struct mlxsw_tx_info *tx_info)
 {
+	if (skb_cow_head(skb, MLXSW_TXHDR_LEN)) {
+		this_cpu_inc(mlxsw_sp_port->pcpu_stats->tx_dropped);
+		dev_kfree_skb_any(skb);
+		return -ENOMEM;
+	}
+
 	mlxsw_sp_txhdr_construct(skb, tx_info);
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 84d3a8551b03..071f128aa490 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -203,8 +203,12 @@ static void _dwmac4_dump_dma_regs(struct stmmac_priv *priv,
 		readl(ioaddr + DMA_CHAN_TX_CONTROL(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_RX_CONTROL(default_addrs, channel) / 4] =
 		readl(ioaddr + DMA_CHAN_RX_CONTROL(dwmac4_addrs, channel));
+	reg_space[DMA_CHAN_TX_BASE_ADDR_HI(default_addrs, channel) / 4] =
+		readl(ioaddr + DMA_CHAN_TX_BASE_ADDR_HI(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_TX_BASE_ADDR(default_addrs, channel) / 4] =
 		readl(ioaddr + DMA_CHAN_TX_BASE_ADDR(dwmac4_addrs, channel));
+	reg_space[DMA_CHAN_RX_BASE_ADDR_HI(default_addrs, channel) / 4] =
+		readl(ioaddr + DMA_CHAN_RX_BASE_ADDR_HI(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_RX_BASE_ADDR(default_addrs, channel) / 4] =
 		readl(ioaddr + DMA_CHAN_RX_BASE_ADDR(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_TX_END_ADDR(default_addrs, channel) / 4] =
@@ -225,8 +229,12 @@ static void _dwmac4_dump_dma_regs(struct stmmac_priv *priv,
 		readl(ioaddr + DMA_CHAN_CUR_TX_DESC(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_CUR_RX_DESC(default_addrs, channel) / 4] =
 		readl(ioaddr + DMA_CHAN_CUR_RX_DESC(dwmac4_addrs, channel));
+	reg_space[DMA_CHAN_CUR_TX_BUF_ADDR_HI(default_addrs, channel) / 4] =
+		readl(ioaddr + DMA_CHAN_CUR_TX_BUF_ADDR_HI(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_CUR_TX_BUF_ADDR(default_addrs, channel) / 4] =
 		readl(ioaddr + DMA_CHAN_CUR_TX_BUF_ADDR(dwmac4_addrs, channel));
+	reg_space[DMA_CHAN_CUR_RX_BUF_ADDR_HI(default_addrs, channel) / 4] =
+		readl(ioaddr + DMA_CHAN_CUR_RX_BUF_ADDR_HI(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_CUR_RX_BUF_ADDR(default_addrs, channel) / 4] =
 		readl(ioaddr + DMA_CHAN_CUR_RX_BUF_ADDR(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_STATUS(default_addrs, channel) / 4] =
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 17d9120db5fe..4f980dcd3958 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -127,7 +127,9 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 #define DMA_CHAN_SLOT_CTRL_STATUS(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x3c)
 #define DMA_CHAN_CUR_TX_DESC(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x44)
 #define DMA_CHAN_CUR_RX_DESC(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x4c)
+#define DMA_CHAN_CUR_TX_BUF_ADDR_HI(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x50)
 #define DMA_CHAN_CUR_TX_BUF_ADDR(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x54)
+#define DMA_CHAN_CUR_RX_BUF_ADDR_HI(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x58)
 #define DMA_CHAN_CUR_RX_BUF_ADDR(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x5c)
 #define DMA_CHAN_STATUS(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x60)
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f3a1b179aaea..02368917efb4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4330,11 +4330,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (dma_mapping_error(priv->device, des))
 		goto dma_map_err;
 
-	tx_q->tx_skbuff_dma[first_entry].buf = des;
-	tx_q->tx_skbuff_dma[first_entry].len = skb_headlen(skb);
-	tx_q->tx_skbuff_dma[first_entry].map_as_page = false;
-	tx_q->tx_skbuff_dma[first_entry].buf_type = STMMAC_TXBUF_T_SKB;
-
 	if (priv->dma_cap.addr64 <= 32) {
 		first->des0 = cpu_to_le32(des);
 
@@ -4353,6 +4348,23 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags == 0), queue);
 
+	/* In case two or more DMA transmit descriptors are allocated for this
+	 * non-paged SKB data, the DMA buffer address should be saved to
+	 * tx_q->tx_skbuff_dma[].buf corresponding to the last descriptor,
+	 * and leave the other tx_q->tx_skbuff_dma[].buf as NULL to guarantee
+	 * that stmmac_tx_clean() does not unmap the entire DMA buffer too early
+	 * since the tail areas of the DMA buffer can be accessed by DMA engine
+	 * sooner or later.
+	 * By saving the DMA buffer address to tx_q->tx_skbuff_dma[].buf
+	 * corresponding to the last descriptor, stmmac_tx_clean() will unmap
+	 * this DMA buffer right after the DMA engine completely finishes the
+	 * full buffer transmission.
+	 */
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_headlen(skb);
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
+
 	/* Prepare fragments */
 	for (i = 0; i < nfrags; i++) {
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 2e94d10348cc..4cb925321785 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1702,20 +1702,24 @@ static int gtp_encap_enable(struct gtp_dev *gtp, struct nlattr *data[])
 		return -EINVAL;
 
 	if (data[IFLA_GTP_FD0]) {
-		u32 fd0 = nla_get_u32(data[IFLA_GTP_FD0]);
+		int fd0 = nla_get_u32(data[IFLA_GTP_FD0]);
 
-		sk0 = gtp_encap_enable_socket(fd0, UDP_ENCAP_GTP0, gtp);
-		if (IS_ERR(sk0))
-			return PTR_ERR(sk0);
+		if (fd0 >= 0) {
+			sk0 = gtp_encap_enable_socket(fd0, UDP_ENCAP_GTP0, gtp);
+			if (IS_ERR(sk0))
+				return PTR_ERR(sk0);
+		}
 	}
 
 	if (data[IFLA_GTP_FD1]) {
-		u32 fd1 = nla_get_u32(data[IFLA_GTP_FD1]);
+		int fd1 = nla_get_u32(data[IFLA_GTP_FD1]);
 
-		sk1u = gtp_encap_enable_socket(fd1, UDP_ENCAP_GTP1U, gtp);
-		if (IS_ERR(sk1u)) {
-			gtp_encap_disable_sock(sk0);
-			return PTR_ERR(sk1u);
+		if (fd1 >= 0) {
+			sk1u = gtp_encap_enable_socket(fd1, UDP_ENCAP_GTP1U, gtp);
+			if (IS_ERR(sk1u)) {
+				gtp_encap_disable_sock(sk0);
+				return PTR_ERR(sk1u);
+			}
 		}
 	}
 
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 2a31d09d43ed..edee2870f62a 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3798,8 +3798,7 @@ static void macsec_free_netdev(struct net_device *dev)
 {
 	struct macsec_dev *macsec = macsec_priv(dev);
 
-	if (macsec->secy.tx_sc.md_dst)
-		metadata_dst_free(macsec->secy.tx_sc.md_dst);
+	dst_release(&macsec->secy.tx_sc.md_dst->dst);
 	free_percpu(macsec->stats);
 	free_percpu(macsec->secy.tx_sc.stats);
 
diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index 4dc057c121f5..e70fb6687994 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -588,6 +588,9 @@ static int mctp_i2c_header_create(struct sk_buff *skb, struct net_device *dev,
 	if (len > MCTP_I2C_MAXMTU)
 		return -EMSGSIZE;
 
+	if (!daddr || !saddr)
+		return -EINVAL;
+
 	lldst = *((u8 *)daddr);
 	llsrc = *((u8 *)saddr);
 
diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
index a1f91ff8ec56..f108e363b716 100644
--- a/drivers/net/netdevsim/fib.c
+++ b/drivers/net/netdevsim/fib.c
@@ -1377,10 +1377,12 @@ static ssize_t nsim_nexthop_bucket_activity_write(struct file *file,
 
 	if (pos != 0)
 		return -EINVAL;
-	if (size > sizeof(buf))
+	if (size > sizeof(buf) - 1)
 		return -EINVAL;
 	if (copy_from_user(buf, user_buf, size))
 		return -EFAULT;
+	buf[size] = 0;
+
 	if (sscanf(buf, "%u %hu", &nhid, &bucket_index) != 2)
 		return -EINVAL;
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index dbaf26d6a7a6..16d07d619b4d 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -3043,9 +3043,14 @@ ath10k_wmi_tlv_op_cleanup_mgmt_tx_send(struct ath10k *ar,
 				       struct sk_buff *msdu)
 {
 	struct ath10k_skb_cb *cb = ATH10K_SKB_CB(msdu);
+	struct ath10k_mgmt_tx_pkt_addr *pkt_addr;
 	struct ath10k_wmi *wmi = &ar->wmi;
 
-	idr_remove(&wmi->mgmt_pending_tx, cb->msdu_id);
+	spin_lock_bh(&ar->data_lock);
+	pkt_addr = idr_remove(&wmi->mgmt_pending_tx, cb->msdu_id);
+	spin_unlock_bh(&ar->data_lock);
+
+	kfree(pkt_addr);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index fe2344598364..1d58452ed8ca 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -2441,6 +2441,7 @@ wmi_process_mgmt_tx_comp(struct ath10k *ar, struct mgmt_tx_compl_params *param)
 	dma_unmap_single(ar->dev, pkt_addr->paddr,
 			 msdu->len, DMA_TO_DEVICE);
 	info = IEEE80211_SKB_CB(msdu);
+	kfree(pkt_addr);
 
 	if (param->status) {
 		info->flags &= ~IEEE80211_TX_STAT_ACK;
@@ -9612,6 +9613,7 @@ static int ath10k_wmi_mgmt_tx_clean_up_pending(int msdu_id, void *ptr,
 	dma_unmap_single(ar->dev, pkt_addr->paddr,
 			 msdu->len, DMA_TO_DEVICE);
 	ieee80211_free_txskb(ar->hw, msdu);
+	kfree(pkt_addr);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index c087d8a0f5b2..40088e62572e 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -5291,8 +5291,11 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 		    hal_status == HAL_TLV_STATUS_PPDU_DONE) {
 			rx_mon_stats->status_ppdu_done++;
 			pmon->mon_ppdu_status = DP_PPDU_STATUS_DONE;
-			ath11k_dp_rx_mon_dest_process(ar, mac_id, budget, napi);
-			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
+			if (!ab->hw_params.full_monitor_mode) {
+				ath11k_dp_rx_mon_dest_process(ar, mac_id,
+							      budget, napi);
+				pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
+			}
 		}
 
 		if (ppdu_info->peer_id == HAL_INVALID_PEERID ||
diff --git a/drivers/net/wireless/broadcom/brcm80211/Kconfig b/drivers/net/wireless/broadcom/brcm80211/Kconfig
index 3a1a35b5672f..19d0c003f626 100644
--- a/drivers/net/wireless/broadcom/brcm80211/Kconfig
+++ b/drivers/net/wireless/broadcom/brcm80211/Kconfig
@@ -27,6 +27,7 @@ source "drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig"
 config BRCM_TRACING
 	bool "Broadcom device tracing"
 	depends on BRCMSMAC || BRCMFMAC
+	depends on TRACING
 	help
 	  If you say Y here, the Broadcom wireless drivers will register
 	  with ftrace to dump event information into the trace ringbuffer.
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 9d33a66a49b5..958dd4f9bc69 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -3122,6 +3122,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
 	struct il_cmd_meta *out_meta;
 	dma_addr_t phys_addr;
 	unsigned long flags;
+	u8 *out_payload;
 	u32 idx;
 	u16 fix_size;
 
@@ -3157,6 +3158,16 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
 	out_cmd = txq->cmd[idx];
 	out_meta = &txq->meta[idx];
 
+	/* The payload is in the same place in regular and huge
+	 * command buffers, but we need to let the compiler know when
+	 * we're using a larger payload buffer to avoid "field-
+	 * spanning write" warnings at run-time for huge commands.
+	 */
+	if (cmd->flags & CMD_SIZE_HUGE)
+		out_payload = ((struct il_device_cmd_huge *)out_cmd)->cmd.payload;
+	else
+		out_payload = out_cmd->cmd.payload;
+
 	if (WARN_ON(out_meta->flags & CMD_MAPPED)) {
 		spin_unlock_irqrestore(&il->hcmd_lock, flags);
 		return -ENOSPC;
@@ -3170,7 +3181,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
 		out_meta->callback = cmd->callback;
 
 	out_cmd->hdr.cmd = cmd->id;
-	memcpy(&out_cmd->cmd.payload, cmd->data, cmd->len);
+	memcpy(out_payload, cmd->data, cmd->len);
 
 	/* At this point, the out_cmd now has all of the incoming cmd
 	 * information */
@@ -4962,6 +4973,8 @@ il_pci_resume(struct device *device)
 	 */
 	pci_write_config_byte(pdev, PCI_CFG_RETRY_TIMEOUT, 0x00);
 
+	_il_wr(il, CSR_INT, 0xffffffff);
+	_il_wr(il, CSR_FH_INT_STATUS, 0xffffffff);
 	il_enable_interrupts(il);
 
 	if (!(_il_rd(il, CSR_GP_CNTRL) & CSR_GP_CNTRL_REG_FLAG_HW_RF_KILL_SW))
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index 69687fcf963f..027dae5619a3 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -560,6 +560,18 @@ struct il_device_cmd {
 
 #define TFD_MAX_PAYLOAD_SIZE (sizeof(struct il_device_cmd))
 
+/**
+ * struct il_device_cmd_huge
+ *
+ * For use when sending huge commands.
+ */
+struct il_device_cmd_huge {
+	struct il_cmd_header hdr;	/* uCode API */
+	union {
+		u8 payload[IL_MAX_CMD_SIZE - sizeof(struct il_cmd_header)];
+	} __packed cmd;
+} __packed;
+
 struct il_host_cmd {
 	const void *data;
 	unsigned long reply_page;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index aaaabd67f959..3709039a294d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1413,25 +1413,35 @@ _iwl_op_mode_start(struct iwl_drv *drv, struct iwlwifi_opmode_table *op)
 	const struct iwl_op_mode_ops *ops = op->ops;
 	struct dentry *dbgfs_dir = NULL;
 	struct iwl_op_mode *op_mode = NULL;
+	int retry, max_retry = !!iwlwifi_mod_params.fw_restart * IWL_MAX_INIT_RETRY;
 
 	/* also protects start/stop from racing against each other */
 	lockdep_assert_held(&iwlwifi_opmode_table_mtx);
 
+	for (retry = 0; retry <= max_retry; retry++) {
+
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-	drv->dbgfs_op_mode = debugfs_create_dir(op->name,
-						drv->dbgfs_drv);
-	dbgfs_dir = drv->dbgfs_op_mode;
+		drv->dbgfs_op_mode = debugfs_create_dir(op->name,
+							drv->dbgfs_drv);
+		dbgfs_dir = drv->dbgfs_op_mode;
 #endif
 
-	op_mode = ops->start(drv->trans, drv->trans->cfg,
-			     &drv->fw, dbgfs_dir);
-	if (op_mode)
-		return op_mode;
+		op_mode = ops->start(drv->trans, drv->trans->cfg,
+				     &drv->fw, dbgfs_dir);
+
+		if (op_mode)
+			return op_mode;
+
+		if (test_bit(STATUS_TRANS_DEAD, &drv->trans->status))
+			break;
+
+		IWL_ERR(drv, "retry init count %d\n", retry);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-	debugfs_remove_recursive(drv->dbgfs_op_mode);
-	drv->dbgfs_op_mode = NULL;
+		debugfs_remove_recursive(drv->dbgfs_op_mode);
+		drv->dbgfs_op_mode = NULL;
 #endif
+	}
 
 	return NULL;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
index 1549ff429549..6a1d31892417 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
@@ -98,6 +98,9 @@ void iwl_drv_stop(struct iwl_drv *drv);
 #define VISIBLE_IF_IWLWIFI_KUNIT static
 #endif
 
+/* max retry for init flow */
+#define IWL_MAX_INIT_RETRY 2
+
 #define FW_NAME_PRE_BUFSIZE	64
 struct iwl_trans;
 const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 08c4898c8f1a..49d5278d078a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1288,8 +1288,8 @@ static void iwl_mvm_disconnect_iterator(void *data, u8 *mac,
 void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 {
 	u32 error_log_size = mvm->fw->ucode_capa.error_log_size;
+	u32 status = 0;
 	int ret;
-	u32 resp;
 
 	struct iwl_fw_error_recovery_cmd recovery_cmd = {
 		.flags = cpu_to_le32(flags),
@@ -1297,7 +1297,6 @@ void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 	};
 	struct iwl_host_cmd host_cmd = {
 		.id = WIDE_ID(SYSTEM_GROUP, FW_ERROR_RECOVERY_CMD),
-		.flags = CMD_WANT_SKB,
 		.data = {&recovery_cmd, },
 		.len = {sizeof(recovery_cmd), },
 	};
@@ -1317,7 +1316,7 @@ void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 		recovery_cmd.buf_size = cpu_to_le32(error_log_size);
 	}
 
-	ret = iwl_mvm_send_cmd(mvm, &host_cmd);
+	ret = iwl_mvm_send_cmd_status(mvm, &host_cmd, &status);
 	kfree(mvm->error_recovery_buf);
 	mvm->error_recovery_buf = NULL;
 
@@ -1328,11 +1327,10 @@ void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 
 	/* skb respond is only relevant in ERROR_RECOVERY_UPDATE_DB */
 	if (flags & ERROR_RECOVERY_UPDATE_DB) {
-		resp = le32_to_cpu(*(__le32 *)host_cmd.resp_pkt->data);
-		if (resp) {
+		if (status) {
 			IWL_ERR(mvm,
 				"Failed to send recovery cmd blob was invalid %d\n",
-				resp);
+				status);
 
 			ieee80211_iterate_interfaces(mvm->hw, 0,
 						     iwl_mvm_disconnect_iterator,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1ebcc6417ece..63b2c6fe3f8a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1292,12 +1292,14 @@ int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
+	int retry, max_retry = 0;
 
 	mutex_lock(&mvm->mutex);
 
 	/* we are starting the mac not in error flow, and restart is enabled */
 	if (!test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status) &&
 	    iwlwifi_mod_params.fw_restart) {
+		max_retry = IWL_MAX_INIT_RETRY;
 		/*
 		 * This will prevent mac80211 recovery flows to trigger during
 		 * init failures
@@ -1305,7 +1307,13 @@ int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 		set_bit(IWL_MVM_STATUS_STARTING, &mvm->status);
 	}
 
-	ret = __iwl_mvm_mac_start(mvm);
+	for (retry = 0; retry <= max_retry; retry++) {
+		ret = __iwl_mvm_mac_start(mvm);
+		if (!ret)
+			break;
+
+		IWL_ERR(mvm, "mac start retry %d\n", retry);
+	}
 	clear_bit(IWL_MVM_STATUS_STARTING, &mvm->status);
 
 	mutex_unlock(&mvm->mutex);
@@ -1951,7 +1959,6 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 		mvm->p2p_device_vif = NULL;
 	}
 
-	iwl_mvm_unset_link_mapping(mvm, vif, &vif->bss_conf);
 	iwl_mvm_mac_ctxt_remove(mvm, vif);
 
 	RCU_INIT_POINTER(mvm->vif_id_to_mac[mvmvif->id], NULL);
@@ -1960,6 +1967,7 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 		mvm->monitor_on = false;
 
 out:
+	iwl_mvm_unset_link_mapping(mvm, vif, &vif->bss_conf);
 	if (vif->type == NL80211_IFTYPE_AP ||
 	    vif->type == NL80211_IFTYPE_ADHOC) {
 		iwl_mvm_dealloc_int_sta(mvm, &mvmvif->deflink.mcast_sta);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 3c99396ad369..c4ccc353a8fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -41,8 +41,6 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 	/* reset deflink MLO parameters */
 	mvmvif->deflink.fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
 	mvmvif->deflink.active = 0;
-	/* the first link always points to the default one */
-	mvmvif->link[0] = &mvmvif->deflink;
 
 	ret = iwl_mvm_mld_mac_ctxt_add(mvm, vif);
 	if (ret)
@@ -60,9 +58,19 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 	}
 
-	ret = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
-	if (ret)
-		goto out_free_bf;
+	/* We want link[0] to point to the default link, unless we have MLO and
+	 * in this case this will be modified later by .change_vif_links()
+	 * If we are in the restart flow with an MLD connection, we will wait
+	 * to .change_vif_links() to setup the links.
+	 */
+	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) ||
+	    !ieee80211_vif_is_mld(vif)) {
+		mvmvif->link[0] = &mvmvif->deflink;
+
+		ret = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
+		if (ret)
+			goto out_free_bf;
+	}
 
 	/* Save a pointer to p2p device vif, so it can later be used to
 	 * update the p2p device MAC when a GO is started/stopped
@@ -347,11 +355,6 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 		rcu_read_unlock();
 	}
 
-	if (vif->type == NL80211_IFTYPE_STATION)
-		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
-							link_conf,
-							false);
-
 	/* then activate */
 	ret = iwl_mvm_link_changed(mvm, vif, link_conf,
 				   LINK_CONTEXT_MODIFY_ACTIVE |
@@ -360,6 +363,11 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	if (ret)
 		goto out;
 
+	if (vif->type == NL80211_IFTYPE_STATION)
+		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
+							link_conf,
+							false);
+
 	/*
 	 * Power state must be updated before quotas,
 	 * otherwise fw will complain.
@@ -1188,7 +1196,11 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
-	if (old_links == 0) {
+	/* If we're in RESTART flow, the default link wasn't added in
+         * drv_add_interface(), and link[0] doesn't point to it.
+	 */
+	if (old_links == 0 && !test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
+					&mvm->status)) {
 		err = iwl_mvm_disable_link(mvm, vif, &vif->bss_conf);
 		if (err)
 			goto out_err;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 3a9018595ea9..cfc50c7b2949 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1774,7 +1774,7 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 			&cp->channel_config[ch_cnt];
 
 		u32 s_ssid_bitmap = 0, bssid_bitmap = 0, flags = 0;
-		u8 j, k, n_s_ssids = 0, n_bssids = 0;
+		u8 k, n_s_ssids = 0, n_bssids = 0;
 		u8 max_s_ssids, max_bssids;
 		bool force_passive = false, found = false, allow_passive = true,
 		     unsolicited_probe_on_chan = false, psc_no_listen = false;
@@ -1799,7 +1799,7 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 		cfg->v5.iter_count = 1;
 		cfg->v5.iter_interval = 0;
 
-		for (j = 0; j < params->n_6ghz_params; j++) {
+		for (u32 j = 0; j < params->n_6ghz_params; j++) {
 			s8 tmp_psd_20;
 
 			if (!(scan_6ghz_params[j].channel_idx == i))
@@ -1873,7 +1873,7 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 		 * SSID.
 		 * TODO: improve this logic
 		 */
-		for (j = 0; j < params->n_6ghz_params; j++) {
+		for (u32 j = 0; j < params->n_6ghz_params; j++) {
 			if (!(scan_6ghz_params[j].channel_idx == i))
 				continue;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
index d069a81ac617..cc699efa9c79 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
@@ -352,7 +352,6 @@ static const struct usb_device_id rtl8192d_usb_ids[] = {
 	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x8194, rtl92du_hal_cfg)},
 	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x8111, rtl92du_hal_cfg)},
 	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x0193, rtl92du_hal_cfg)},
-	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x8171, rtl92du_hal_cfg)},
 	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0xe194, rtl92du_hal_cfg)},
 	{RTL_USB_DEVICE(0x2019, 0xab2c, rtl92du_hal_cfg)},
 	{RTL_USB_DEVICE(0x2019, 0xab2d, rtl92du_hal_cfg)},
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 02afeb3acce4..5aef7fa37878 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3026,24 +3026,54 @@ static void rtw89_pci_declaim_device(struct rtw89_dev *rtwdev,
 	pci_disable_device(pdev);
 }
 
-static void rtw89_pci_cfg_dac(struct rtw89_dev *rtwdev)
+static bool rtw89_pci_chip_is_manual_dac(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	if (!rtwpci->enable_dac)
-		return;
-
 	switch (chip->chip_id) {
 	case RTL8852A:
 	case RTL8852B:
 	case RTL8851B:
 	case RTL8852BT:
-		break;
+		return true;
 	default:
-		return;
+		return false;
+	}
+}
+
+static bool rtw89_pci_is_dac_compatible_bridge(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct pci_dev *bridge = pci_upstream_bridge(rtwpci->pdev);
+
+	if (!rtw89_pci_chip_is_manual_dac(rtwdev))
+		return true;
+
+	if (!bridge)
+		return false;
+
+	switch (bridge->vendor) {
+	case PCI_VENDOR_ID_INTEL:
+		return true;
+	case PCI_VENDOR_ID_ASMEDIA:
+		if (bridge->device == 0x2806)
+			return true;
+		break;
 	}
 
+	return false;
+}
+
+static void rtw89_pci_cfg_dac(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+
+	if (!rtwpci->enable_dac)
+		return;
+
+	if (!rtw89_pci_chip_is_manual_dac(rtwdev))
+		return;
+
 	rtw89_pci_config_byte_set(rtwdev, RTW89_PCIE_L1_CTRL, RTW89_PCIE_BIT_EN_64BITS);
 }
 
@@ -3061,6 +3091,9 @@ static int rtw89_pci_setup_mapping(struct rtw89_dev *rtwdev,
 		goto err;
 	}
 
+	if (!rtw89_pci_is_dac_compatible_bridge(rtwdev))
+		goto no_dac;
+
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(36));
 	if (!ret) {
 		rtwpci->enable_dac = true;
@@ -3073,6 +3106,7 @@ static int rtw89_pci_setup_mapping(struct rtw89_dev *rtwdev,
 			goto err_release_regions;
 		}
 	}
+no_dac:
 
 	resource_len = pci_resource_len(pdev, bar_id);
 	rtwpci->mmap = pci_iomap(pdev, bar_id, resource_len);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a6fb1359a7e1..89ad4217f860 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -90,6 +90,17 @@ module_param(apst_secondary_latency_tol_us, ulong, 0644);
 MODULE_PARM_DESC(apst_secondary_latency_tol_us,
 	"secondary APST latency tolerance in us");
 
+/*
+ * Older kernels didn't enable protection information if it was at an offset.
+ * Newer kernels do, so it breaks reads on the upgrade if such formats were
+ * used in prior kernels since the metadata written did not contain a valid
+ * checksum.
+ */
+static bool disable_pi_offsets = false;
+module_param(disable_pi_offsets, bool, 0444);
+MODULE_PARM_DESC(disable_pi_offsets,
+	"disable protection information if it has an offset");
+
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -1921,8 +1932,12 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
 
 	if (head->pi_size && head->ms >= head->pi_size)
 		head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
-	if (!(id->dps & NVME_NS_DPS_PI_FIRST))
-		info->pi_offset = head->ms - head->pi_size;
+	if (!(id->dps & NVME_NS_DPS_PI_FIRST)) {
+		if (disable_pi_offsets)
+			head->pi_type = 0;
+		else
+			info->pi_offset = head->ms - head->pi_size;
+	}
 
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		/*
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 15c93ce07e26..2cb35c4528a9 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -423,10 +423,13 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	struct io_uring_cmd *ioucmd = req->end_io_data;
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 
-	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
+	if (nvme_req(req)->flags & NVME_REQ_CANCELLED) {
 		pdu->status = -EINTR;
-	else
+	} else {
 		pdu->status = nvme_req(req)->status;
+		if (!pdu->status)
+			pdu->status = blk_status_to_errno(err);
+	}
 	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
 
 	/*
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 8bc3f431c77f..8c41a47dfed1 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -103,6 +103,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 			pr_debug("%s: ctrl %d failed to generate private key, err %d\n",
 				 __func__, ctrl->cntlid, ret);
 			kfree_sensitive(ctrl->dh_key);
+			ctrl->dh_key = NULL;
 			return ret;
 		}
 		ctrl->dh_keysize = crypto_kpp_maxsize(ctrl->dh_tfm);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 85ced6958d6d..51407c376a22 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1067,8 +1067,15 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 static void pci_enable_acs(struct pci_dev *dev)
 {
 	struct pci_acs caps;
+	bool enable_acs = false;
 	int pos;
 
+	/* If an iommu is present we start with kernel default caps */
+	if (pci_acs_enable) {
+		if (pci_dev_specific_enable_acs(dev))
+			enable_acs = true;
+	}
+
 	pos = dev->acs_cap;
 	if (!pos)
 		return;
@@ -1077,11 +1084,8 @@ static void pci_enable_acs(struct pci_dev *dev)
 	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &caps.ctrl);
 	caps.fw_ctrl = caps.ctrl;
 
-	/* If an iommu is present we start with kernel default caps */
-	if (pci_acs_enable) {
-		if (pci_dev_specific_enable_acs(dev))
-			pci_std_enable_acs(dev, &caps);
-	}
+	if (enable_acs)
+		pci_std_enable_acs(dev, &caps);
 
 	/*
 	 * Always apply caps from the command line, even if there is no iommu.
diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index 11fcb1867118..e98361dcdead 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -141,11 +141,6 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
 	usleep_range(100, 200);
 
-	/* Do the PHY common block reset */
-	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
-			   IMX8MM_GPR_PCIE_CMN_RST,
-			   IMX8MM_GPR_PCIE_CMN_RST);
-
 	switch (imx8_phy->drvdata->variant) {
 	case IMX8MP:
 		reset_control_deassert(imx8_phy->perst);
@@ -156,6 +151,11 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 		break;
 	}
 
+	/* Do the PHY common block reset */
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
+			   IMX8MM_GPR_PCIE_CMN_RST,
+			   IMX8MM_GPR_PCIE_CMN_RST);
+
 	/* Polling to check the phy is ready or not. */
 	ret = readl_poll_timeout(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG075,
 				 val, val == ANA_PLL_DONE, 10, 20000);
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
index 6d0ba39c1943..8bf951b0490c 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
@@ -1248,6 +1248,7 @@ static int qmp_usb_legacy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	qmp->dev = dev;
+	dev_set_drvdata(dev, qmp);
 
 	qmp->cfg = of_device_get_match_data(dev);
 	if (!qmp->cfg)
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 9b0eb87b1680..f91446d1d2c3 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2179,6 +2179,7 @@ static int qmp_usb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	qmp->dev = dev;
+	dev_set_drvdata(dev, qmp);
 
 	qmp->cfg = of_device_get_match_data(dev);
 	if (!qmp->cfg)
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 5cbc5fd529eb..dea3456f88b1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -1049,6 +1049,7 @@ static int qmp_usbc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	qmp->dev = dev;
+	dev_set_drvdata(dev, qmp);
 
 	qmp->orientation = TYPEC_ORIENTATION_NORMAL;
 
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 733a36f67fbc..1f4c5389676a 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -147,6 +147,7 @@ static const struct x86_cpu_id pl4_support_ids[] = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
 	X86_MATCH_VFM(INTEL_METEORLAKE, NULL),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
 	{}
 };
 
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index a9d8a9c62663..e41698218e62 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -3652,7 +3652,7 @@ static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
 	enum dma_data_direction dir;
 	struct scsi_data_buffer *sdb = &scp->sdb;
 	u8 *fsp;
-	int i;
+	int i, total = 0;
 
 	/*
 	 * Even though reads are inherently atomic (in this driver), we expect
@@ -3689,18 +3689,16 @@ static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
 		   fsp + (block * sdebug_sector_size),
 		   sdebug_sector_size, sg_skip, do_write);
 		sdeb_data_sector_unlock(sip, do_write);
-		if (ret != sdebug_sector_size) {
-			ret += (i * sdebug_sector_size);
+		total += ret;
+		if (ret != sdebug_sector_size)
 			break;
-		}
 		sg_skip += sdebug_sector_size;
 		if (++block >= sdebug_store_sectors)
 			block = 0;
 	}
-	ret = num * sdebug_sector_size;
 	sdeb_data_unlock(sip, atomic);
 
-	return ret;
+	return total;
 }
 
 /* Returns number of bytes copied or -1 if error. */
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 7d088b8da075..2270732b353c 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -1255,7 +1255,7 @@ static ssize_t fc_rport_set_marginal_state(struct device *dev,
 		 */
 		if (rport->port_state == FC_PORTSTATE_ONLINE)
 			rport->port_state = port_state;
-		else
+		else if (port_state != rport->port_state)
 			return -EINVAL;
 	} else if (port_state == FC_PORTSTATE_ONLINE) {
 		/*
@@ -1265,7 +1265,7 @@ static ssize_t fc_rport_set_marginal_state(struct device *dev,
 		 */
 		if (rport->port_state == FC_PORTSTATE_MARGINAL)
 			rport->port_state = port_state;
-		else
+		else if (port_state != rport->port_state)
 			return -EINVAL;
 	} else
 		return -EINVAL;
diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 9606222993fd..baa4ac6704a9 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2022, Linaro Ltd
  */
 #include <linux/auxiliary_bus.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -13,6 +14,8 @@
 #include <linux/soc/qcom/pmic_glink.h>
 #include <linux/spinlock.h>
 
+#define PMIC_GLINK_SEND_TIMEOUT (5 * HZ)
+
 enum {
 	PMIC_GLINK_CLIENT_BATT = 0,
 	PMIC_GLINK_CLIENT_ALTMODE,
@@ -112,13 +115,29 @@ EXPORT_SYMBOL_GPL(pmic_glink_client_register);
 int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
 {
 	struct pmic_glink *pg = client->pg;
+	bool timeout_reached = false;
+	unsigned long start;
 	int ret;
 
 	mutex_lock(&pg->state_lock);
-	if (!pg->ept)
+	if (!pg->ept) {
 		ret = -ECONNRESET;
-	else
-		ret = rpmsg_send(pg->ept, data, len);
+	} else {
+		start = jiffies;
+		for (;;) {
+			ret = rpmsg_send(pg->ept, data, len);
+			if (ret != -EAGAIN)
+				break;
+
+			if (timeout_reached) {
+				ret = -ETIMEDOUT;
+				break;
+			}
+
+			usleep_range(1000, 5000);
+			timeout_reached = time_after(jiffies, start + PMIC_GLINK_SEND_TIMEOUT);
+		}
+	}
 	mutex_unlock(&pg->state_lock);
 
 	return ret;
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 191de1917f83..3fa990fb59c7 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1003,6 +1003,7 @@ static int dspi_setup(struct spi_device *spi)
 	u32 cs_sck_delay = 0, sck_cs_delay = 0;
 	struct fsl_dspi_platform_data *pdata;
 	unsigned char pasc = 0, asc = 0;
+	struct gpio_desc *gpio_cs;
 	struct chip_data *chip;
 	unsigned long clkrate;
 	bool cs = true;
@@ -1077,7 +1078,10 @@ static int dspi_setup(struct spi_device *spi)
 			chip->ctar_val |= SPI_CTAR_LSBFE;
 	}
 
-	gpiod_direction_output(spi_get_csgpiod(spi, 0), false);
+	gpio_cs = spi_get_csgpiod(spi, 0);
+	if (gpio_cs)
+		gpiod_direction_output(gpio_cs, false);
+
 	dspi_deassert_cs(spi, &cs);
 
 	spi_set_ctldata(spi, chip);
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6f4057330444..fa967be4f9a1 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1108,6 +1108,11 @@ static int spi_geni_probe(struct platform_device *pdev)
 	init_completion(&mas->tx_reset_done);
 	init_completion(&mas->rx_reset_done);
 	spin_lock_init(&mas->lock);
+
+	ret = geni_icc_get(&mas->se, NULL);
+	if (ret)
+		return ret;
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
 	ret = devm_pm_runtime_enable(dev);
@@ -1117,9 +1122,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (device_property_read_bool(&pdev->dev, "spi-slave"))
 		spi->target = true;
 
-	ret = geni_icc_get(&mas->se, NULL);
-	if (ret)
-		return ret;
 	/* Set the bus quota to a reasonable value for register access */
 	mas->se.icc_paths[GENI_TO_CORE].avg_bw = Bps_to_icc(CORE_2X_50_MHZ);
 	mas->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 6c390c4eb26d..492612e8f8ba 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -129,12 +129,15 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 static int ad9832_write_frequency(struct ad9832_state *st,
 				  unsigned int addr, unsigned long fout)
 {
+	unsigned long clk_freq;
 	unsigned long regval;
 
-	if (fout > (clk_get_rate(st->mclk) / 2))
+	clk_freq = clk_get_rate(st->mclk);
+
+	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
-	regval = ad9832_calc_freqreg(clk_get_rate(st->mclk), fout);
+	regval = ad9832_calc_freqreg(clk_freq, fout);
 
 	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
 					(addr << ADD_SHIFT) |
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index e9aa9e23aab9..bde2cc386afd 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -13,48 +13,12 @@ static struct rapl_if_priv rapl_mmio_priv;
 
 static const struct rapl_mmio_regs rapl_mmio_default = {
 	.reg_unit = 0x5938,
-	.regs[RAPL_DOMAIN_PACKAGE] = { 0x59a0, 0x593c, 0x58f0, 0, 0x5930},
+	.regs[RAPL_DOMAIN_PACKAGE] = { 0x59a0, 0x593c, 0x58f0, 0, 0x5930, 0x59b0},
 	.regs[RAPL_DOMAIN_DRAM] = { 0x58e0, 0x58e8, 0x58ec, 0, 0},
-	.limits[RAPL_DOMAIN_PACKAGE] = BIT(POWER_LIMIT2),
+	.limits[RAPL_DOMAIN_PACKAGE] = BIT(POWER_LIMIT2) | BIT(POWER_LIMIT4),
 	.limits[RAPL_DOMAIN_DRAM] = BIT(POWER_LIMIT2),
 };
 
-static int rapl_mmio_cpu_online(unsigned int cpu)
-{
-	struct rapl_package *rp;
-
-	/* mmio rapl supports package 0 only for now */
-	if (topology_physical_package_id(cpu))
-		return 0;
-
-	rp = rapl_find_package_domain_cpuslocked(cpu, &rapl_mmio_priv, true);
-	if (!rp) {
-		rp = rapl_add_package_cpuslocked(cpu, &rapl_mmio_priv, true);
-		if (IS_ERR(rp))
-			return PTR_ERR(rp);
-	}
-	cpumask_set_cpu(cpu, &rp->cpumask);
-	return 0;
-}
-
-static int rapl_mmio_cpu_down_prep(unsigned int cpu)
-{
-	struct rapl_package *rp;
-	int lead_cpu;
-
-	rp = rapl_find_package_domain_cpuslocked(cpu, &rapl_mmio_priv, true);
-	if (!rp)
-		return 0;
-
-	cpumask_clear_cpu(cpu, &rp->cpumask);
-	lead_cpu = cpumask_first(&rp->cpumask);
-	if (lead_cpu >= nr_cpu_ids)
-		rapl_remove_package_cpuslocked(rp);
-	else if (rp->lead_cpu == cpu)
-		rp->lead_cpu = lead_cpu;
-	return 0;
-}
-
 static int rapl_mmio_read_raw(int cpu, struct reg_action *ra)
 {
 	if (!ra->reg.mmio)
@@ -82,6 +46,7 @@ static int rapl_mmio_write_raw(int cpu, struct reg_action *ra)
 int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
 {
 	const struct rapl_mmio_regs *rapl_regs = &rapl_mmio_default;
+	struct rapl_package *rp;
 	enum rapl_domain_reg_id reg;
 	enum rapl_domain_type domain;
 	int ret;
@@ -109,25 +74,38 @@ int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 		return PTR_ERR(rapl_mmio_priv.control_type);
 	}
 
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powercap/rapl:online",
-				rapl_mmio_cpu_online, rapl_mmio_cpu_down_prep);
-	if (ret < 0) {
-		powercap_unregister_control_type(rapl_mmio_priv.control_type);
-		rapl_mmio_priv.control_type = NULL;
-		return ret;
+	/* Register a RAPL package device for package 0 which is always online */
+	rp = rapl_find_package_domain(0, &rapl_mmio_priv, false);
+	if (rp) {
+		ret = -EEXIST;
+		goto err;
+	}
+
+	rp = rapl_add_package(0, &rapl_mmio_priv, false);
+	if (IS_ERR(rp)) {
+		ret = PTR_ERR(rp);
+		goto err;
 	}
-	rapl_mmio_priv.pcap_rapl_online = ret;
 
 	return 0;
+
+err:
+	powercap_unregister_control_type(rapl_mmio_priv.control_type);
+	rapl_mmio_priv.control_type = NULL;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(proc_thermal_rapl_add);
 
 void proc_thermal_rapl_remove(void)
 {
+	struct rapl_package *rp;
+
 	if (IS_ERR_OR_NULL(rapl_mmio_priv.control_type))
 		return;
 
-	cpuhp_remove_state(rapl_mmio_priv.pcap_rapl_online);
+	rp = rapl_find_package_domain(0, &rapl_mmio_priv, false);
+	if (rp)
+		rapl_remove_package(rp);
 	powercap_unregister_control_type(rapl_mmio_priv.control_type);
 }
 EXPORT_SYMBOL_GPL(proc_thermal_rapl_remove);
diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 721319329afa..7db9869a9f3f 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -516,7 +516,7 @@ int tb_retimer_scan(struct tb_port *port, bool add)
 	 */
 	tb_retimer_set_inbound_sbtx(port);
 
-	for (i = 1; i <= TB_MAX_RETIMER_INDEX; i++) {
+	for (max = 1, i = 1; i <= TB_MAX_RETIMER_INDEX; i++) {
 		/*
 		 * Last retimer is true only for the last on-board
 		 * retimer (the one connected directly to the Type-C
@@ -527,9 +527,10 @@ int tb_retimer_scan(struct tb_port *port, bool add)
 			last_idx = i;
 		else if (ret < 0)
 			break;
+
+		max = i;
 	}
 
-	max = i;
 	ret = 0;
 
 	/* Add retimers if they do not exist already */
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 10e719dd837c..4f777788e917 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -288,6 +288,24 @@ static void tb_increase_tmu_accuracy(struct tb_tunnel *tunnel)
 	device_for_each_child(&sw->dev, NULL, tb_increase_switch_tmu_accuracy);
 }
 
+static int tb_switch_tmu_hifi_uni_required(struct device *dev, void *not_used)
+{
+	struct tb_switch *sw = tb_to_switch(dev);
+
+	if (sw && tb_switch_tmu_is_enabled(sw) &&
+	    tb_switch_tmu_is_configured(sw, TB_SWITCH_TMU_MODE_HIFI_UNI))
+		return 1;
+
+	return device_for_each_child(dev, NULL,
+				     tb_switch_tmu_hifi_uni_required);
+}
+
+static bool tb_tmu_hifi_uni_required(struct tb *tb)
+{
+	return device_for_each_child(&tb->dev, NULL,
+				     tb_switch_tmu_hifi_uni_required) == 1;
+}
+
 static int tb_enable_tmu(struct tb_switch *sw)
 {
 	int ret;
@@ -302,12 +320,30 @@ static int tb_enable_tmu(struct tb_switch *sw)
 	ret = tb_switch_tmu_configure(sw,
 			TB_SWITCH_TMU_MODE_MEDRES_ENHANCED_UNI);
 	if (ret == -EOPNOTSUPP) {
-		if (tb_switch_clx_is_enabled(sw, TB_CL1))
-			ret = tb_switch_tmu_configure(sw,
-					TB_SWITCH_TMU_MODE_LOWRES);
-		else
-			ret = tb_switch_tmu_configure(sw,
-					TB_SWITCH_TMU_MODE_HIFI_BI);
+		if (tb_switch_clx_is_enabled(sw, TB_CL1)) {
+			/*
+			 * Figure out uni-directional HiFi TMU requirements
+			 * currently in the domain. If there are no
+			 * uni-directional HiFi requirements we can put the TMU
+			 * into LowRes mode.
+			 *
+			 * Deliberately skip bi-directional HiFi links
+			 * as these work independently of other links
+			 * (and they do not allow any CL states anyway).
+			 */
+			if (tb_tmu_hifi_uni_required(sw->tb))
+				ret = tb_switch_tmu_configure(sw,
+						TB_SWITCH_TMU_MODE_HIFI_UNI);
+			else
+				ret = tb_switch_tmu_configure(sw,
+						TB_SWITCH_TMU_MODE_LOWRES);
+		} else {
+			ret = tb_switch_tmu_configure(sw, TB_SWITCH_TMU_MODE_HIFI_BI);
+		}
+
+		/* If not supported, fallback to bi-directional HiFi */
+		if (ret == -EOPNOTSUPP)
+			ret = tb_switch_tmu_configure(sw, TB_SWITCH_TMU_MODE_HIFI_BI);
 	}
 	if (ret)
 		return ret;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 09408642a6ef..83567388a7b5 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8224,7 +8224,7 @@ static void ufshcd_update_rtc(struct ufs_hba *hba)
 
 	err = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR, QUERY_ATTR_IDN_SECONDS_PASSED,
 				0, 0, &val);
-	ufshcd_rpm_put_sync(hba);
+	ufshcd_rpm_put(hba);
 
 	if (err)
 		dev_err(hba->dev, "%s: Failed to update rtc %d\n", __func__, err);
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index df0c5c4f4508..e629b3442640 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -654,7 +654,7 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	pm_runtime_put_noidle(&dev->dev);
 
 	if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
-		pm_runtime_forbid(&dev->dev);
+		pm_runtime_get(&dev->dev);
 	else if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_allow(&dev->dev);
 
@@ -681,7 +681,9 @@ static void xhci_pci_remove(struct pci_dev *dev)
 
 	xhci->xhc_state |= XHCI_STATE_REMOVING;
 
-	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
+	if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
+		pm_runtime_put(&dev->dev);
+	else if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_forbid(&dev->dev);
 
 	if (xhci->shared_hcd) {
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 785183f0b5f9..4479e949fa64 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1718,6 +1718,14 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 
 	trace_xhci_handle_command(xhci->cmd_ring, &cmd_trb->generic);
 
+	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
+
+	/* If CMD ring stopped we own the trbs between enqueue and dequeue */
+	if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
+		complete_all(&xhci->cmd_ring_stop_completion);
+		return;
+	}
+
 	cmd_dequeue_dma = xhci_trb_virt_to_dma(xhci->cmd_ring->deq_seg,
 			cmd_trb);
 	/*
@@ -1734,14 +1742,6 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 
 	cancel_delayed_work(&xhci->cmd_timer);
 
-	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
-
-	/* If CMD ring stopped we own the trbs between enqueue and dequeue */
-	if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
-		complete_all(&xhci->cmd_ring_stop_completion);
-		return;
-	}
-
 	if (cmd->command_trb != xhci->cmd_ring->dequeue) {
 		xhci_err(xhci,
 			 "Command completion event does not match command\n");
diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 06e0fb23566c..06f789097989 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -628,7 +628,7 @@ void devm_usb_put_phy(struct device *dev, struct usb_phy *phy)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_usb_phy_release, devm_usb_phy_match, phy);
+	r = devres_release(dev, devm_usb_phy_release, devm_usb_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_usb_put_phy);
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index d61b4c74648d..1eb240604cf6 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2341,6 +2341,7 @@ void typec_port_register_altmodes(struct typec_port *port,
 		altmodes[index] = alt;
 		index++;
 	}
+	fwnode_handle_put(altmodes_node);
 }
 EXPORT_SYMBOL_GPL(typec_port_register_altmodes);
 
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index 501eddb294e4..b80eb2d78d88 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -93,8 +93,10 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	bridge_dev = devm_drm_dp_hpd_bridge_alloc(tcpm->dev, to_of_node(tcpm->tcpc.fwnode));
-	if (IS_ERR(bridge_dev))
-		return PTR_ERR(bridge_dev);
+	if (IS_ERR(bridge_dev)) {
+		ret = PTR_ERR(bridge_dev);
+		goto fwnode_remove;
+	}
 
 	tcpm->tcpm_port = tcpm_register_port(tcpm->dev, &tcpm->tcpc);
 	if (IS_ERR(tcpm->tcpm_port)) {
@@ -123,7 +125,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 port_unregister:
 	tcpm_unregister_port(tcpm->tcpm_port);
 fwnode_remove:
-	fwnode_remove_software_node(tcpm->tcpc.fwnode);
+	fwnode_handle_put(tcpm->tcpc.fwnode);
 
 	return ret;
 }
@@ -135,7 +137,7 @@ static void qcom_pmic_typec_remove(struct platform_device *pdev)
 	tcpm->pdphy_stop(tcpm);
 	tcpm->port_stop(tcpm);
 	tcpm_unregister_port(tcpm->tcpm_port);
-	fwnode_remove_software_node(tcpm->tcpc.fwnode);
+	fwnode_handle_put(tcpm->tcpc.fwnode);
 }
 
 static const struct pmic_typec_resources pm8150b_typec_res = {
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 4b02d6474259..3bcf104543e9 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4515,7 +4515,8 @@ static inline enum tcpm_state hard_reset_state(struct tcpm_port *port)
 		return ERROR_RECOVERY;
 	if (port->pwr_role == TYPEC_SOURCE)
 		return SRC_UNATTACHED;
-	if (port->state == SNK_WAIT_CAPABILITIES_TIMEOUT)
+	if (port->state == SNK_WAIT_CAPABILITIES ||
+	    port->state == SNK_WAIT_CAPABILITIES_TIMEOUT)
 		return SNK_READY;
 	return SNK_UNATTACHED;
 }
@@ -5043,8 +5044,11 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_SOFT_RESET,
 				       PD_T_SINK_WAIT_CAP);
 		} else {
-			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
-				       PD_T_SINK_WAIT_CAP);
+			if (!port->self_powered)
+				upcoming_state = SNK_WAIT_CAPABILITIES_TIMEOUT;
+			else
+				upcoming_state = hard_reset_state(port);
+			tcpm_set_state(port, upcoming_state, PD_T_SINK_WAIT_CAP);
 		}
 		break;
 	case SNK_WAIT_CAPABILITIES_TIMEOUT:
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index f8622ed72e08..ada363af5aab 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -12,6 +12,7 @@
 #include <linux/swap.h>
 #include <linux/ctype.h>
 #include <linux/sched.h>
+#include <linux/iversion.h>
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 #include "afs_fs.h"
@@ -1823,6 +1824,8 @@ static int afs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 static void afs_rename_success(struct afs_operation *op)
 {
+	struct afs_vnode *vnode = AFS_FS_I(d_inode(op->dentry));
+
 	_enter("op=%08x", op->debug_id);
 
 	op->ctime = op->file[0].scb.status.mtime_client;
@@ -1832,6 +1835,22 @@ static void afs_rename_success(struct afs_operation *op)
 		op->ctime = op->file[1].scb.status.mtime_client;
 		afs_vnode_commit_status(op, &op->file[1]);
 	}
+
+	/* If we're moving a subdir between dirs, we need to update
+	 * its DV counter too as the ".." will be altered.
+	 */
+	if (S_ISDIR(vnode->netfs.inode.i_mode) &&
+	    op->file[0].vnode != op->file[1].vnode) {
+		u64 new_dv;
+
+		write_seqlock(&vnode->cb_lock);
+
+		new_dv = vnode->status.data_version + 1;
+		vnode->status.data_version = new_dv;
+		inode_set_iversion_raw(&vnode->netfs.inode, new_dv);
+
+		write_sequnlock(&vnode->cb_lock);
+	}
 }
 
 static void afs_rename_edit_dir(struct afs_operation *op)
@@ -1873,6 +1892,12 @@ static void afs_rename_edit_dir(struct afs_operation *op)
 				 &vnode->fid, afs_edit_dir_for_rename_2);
 	}
 
+	if (S_ISDIR(vnode->netfs.inode.i_mode) &&
+	    new_dvnode != orig_dvnode &&
+	    test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
+		afs_edit_dir_update_dotdot(vnode, new_dvnode,
+					   afs_edit_dir_for_rename_sub);
+
 	new_inode = d_inode(new_dentry);
 	if (new_inode) {
 		spin_lock(&new_inode->i_lock);
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index a71bff10496b..fe223fb78111 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -127,10 +127,10 @@ static struct folio *afs_dir_get_folio(struct afs_vnode *vnode, pgoff_t index)
 /*
  * Scan a directory block looking for a dirent of the right name.
  */
-static int afs_dir_scan_block(union afs_xdr_dir_block *block, struct qstr *name,
+static int afs_dir_scan_block(const union afs_xdr_dir_block *block, const struct qstr *name,
 			      unsigned int blocknum)
 {
-	union afs_xdr_dirent *de;
+	const union afs_xdr_dirent *de;
 	u64 bitmap;
 	int d, len, n;
 
@@ -492,3 +492,90 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	goto out_unmap;
 }
+
+/*
+ * Edit a subdirectory that has been moved between directories to update the
+ * ".." entry.
+ */
+void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_dvnode,
+				enum afs_edit_dir_reason why)
+{
+	union afs_xdr_dir_block *block;
+	union afs_xdr_dirent *de;
+	struct folio *folio;
+	unsigned int nr_blocks, b;
+	pgoff_t index;
+	loff_t i_size;
+	int slot;
+
+	_enter("");
+
+	i_size = i_size_read(&vnode->netfs.inode);
+	if (i_size < AFS_DIR_BLOCK_SIZE) {
+		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+		return;
+	}
+	nr_blocks = i_size / AFS_DIR_BLOCK_SIZE;
+
+	/* Find a block that has sufficient slots available.  Each folio
+	 * contains two or more directory blocks.
+	 */
+	for (b = 0; b < nr_blocks; b++) {
+		index = b / AFS_DIR_BLOCKS_PER_PAGE;
+		folio = afs_dir_get_folio(vnode, index);
+		if (!folio)
+			goto error;
+
+		block = kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_pos(folio));
+
+		/* Abandon the edit if we got a callback break. */
+		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
+			goto invalidated;
+
+		slot = afs_dir_scan_block(block, &dotdot_name, b);
+		if (slot >= 0)
+			goto found_dirent;
+
+		kunmap_local(block);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
+	/* Didn't find the dirent to clobber.  Download the directory again. */
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_nodd,
+			   0, 0, 0, 0, "..");
+	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	goto out;
+
+found_dirent:
+	de = &block->dirents[slot];
+	de->u.vnode  = htonl(new_dvnode->fid.vnode);
+	de->u.unique = htonl(new_dvnode->fid.unique);
+
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_dd, b, slot,
+			   ntohl(de->u.vnode), ntohl(de->u.unique), "..");
+
+	kunmap_local(block);
+	folio_unlock(folio);
+	folio_put(folio);
+	inode_set_iversion_raw(&vnode->netfs.inode, vnode->status.data_version);
+
+out:
+	_leave("");
+	return;
+
+invalidated:
+	kunmap_local(block);
+	folio_unlock(folio);
+	folio_put(folio);
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_inval,
+			   0, 0, 0, 0, "..");
+	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	goto out;
+
+error:
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_error,
+			   0, 0, 0, 0, "..");
+	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	goto out;
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 6e1d3c4daf72..b306c0980870 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1072,6 +1072,8 @@ extern void afs_check_for_remote_deletion(struct afs_operation *);
 extern void afs_edit_dir_add(struct afs_vnode *, struct qstr *, struct afs_fid *,
 			     enum afs_edit_dir_reason);
 extern void afs_edit_dir_remove(struct afs_vnode *, struct qstr *, enum afs_edit_dir_reason);
+void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_dvnode,
+				enum afs_edit_dir_reason why);
 
 /*
  * dir_silly.c
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index b4e31ae17cd9..31e437d94869 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -49,6 +49,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_fs_info *fs_info,
 	bbio->end_io = end_io;
 	bbio->private = private;
 	atomic_set(&bbio->pending_ios, 1);
+	WRITE_ONCE(bbio->status, BLK_STS_OK);
 }
 
 /*
@@ -123,43 +124,26 @@ static void __btrfs_bio_end_io(struct btrfs_bio *bbio)
 void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 {
 	bbio->bio.bi_status = status;
-	__btrfs_bio_end_io(bbio);
-}
-
-static void btrfs_orig_write_end_io(struct bio *bio);
-
-static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
-				       struct btrfs_bio *orig_bbio)
-{
-	/*
-	 * For writes we tolerate nr_mirrors - 1 write failures, so we can't
-	 * just blindly propagate a write failure here.  Instead increment the
-	 * error count in the original I/O context so that it is guaranteed to
-	 * be larger than the error tolerance.
-	 */
-	if (bbio->bio.bi_end_io == &btrfs_orig_write_end_io) {
-		struct btrfs_io_stripe *orig_stripe = orig_bbio->bio.bi_private;
-		struct btrfs_io_context *orig_bioc = orig_stripe->bioc;
-
-		atomic_add(orig_bioc->max_errors, &orig_bioc->error);
-	} else {
-		orig_bbio->bio.bi_status = bbio->bio.bi_status;
-	}
-}
-
-static void btrfs_orig_bbio_end_io(struct btrfs_bio *bbio)
-{
 	if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
 		struct btrfs_bio *orig_bbio = bbio->private;
 
-		if (bbio->bio.bi_status)
-			btrfs_bbio_propagate_error(bbio, orig_bbio);
 		btrfs_cleanup_bio(bbio);
 		bbio = orig_bbio;
 	}
 
-	if (atomic_dec_and_test(&bbio->pending_ios))
+	/*
+	 * At this point, bbio always points to the original btrfs_bio. Save
+	 * the first error in it.
+	 */
+	if (status != BLK_STS_OK)
+		cmpxchg(&bbio->status, BLK_STS_OK, status);
+
+	if (atomic_dec_and_test(&bbio->pending_ios)) {
+		/* Load split bio's error which might be set above. */
+		if (status == BLK_STS_OK)
+			bbio->bio.bi_status = READ_ONCE(bbio->status);
 		__btrfs_bio_end_io(bbio);
+	}
 }
 
 static int next_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
@@ -179,7 +163,7 @@ static int prev_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
 static void btrfs_repair_done(struct btrfs_failed_bio *fbio)
 {
 	if (atomic_dec_and_test(&fbio->repair_count)) {
-		btrfs_orig_bbio_end_io(fbio->bbio);
+		btrfs_bio_end_io(fbio->bbio, fbio->bbio->bio.bi_status);
 		mempool_free(fbio, &btrfs_failed_bio_pool);
 	}
 }
@@ -326,7 +310,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 	if (fbio)
 		btrfs_repair_done(fbio);
 	else
-		btrfs_orig_bbio_end_io(bbio);
+		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 }
 
 static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
@@ -360,7 +344,7 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	if (is_data_bbio(bbio))
 		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
 	else
-		btrfs_orig_bbio_end_io(bbio);
+		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 }
 
 static void btrfs_simple_end_io(struct bio *bio)
@@ -380,7 +364,7 @@ static void btrfs_simple_end_io(struct bio *bio)
 	} else {
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND && !bio->bi_status)
 			btrfs_record_physical_zoned(bbio);
-		btrfs_orig_bbio_end_io(bbio);
+		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 	}
 }
 
@@ -394,7 +378,7 @@ static void btrfs_raid56_end_io(struct bio *bio)
 	if (bio_op(bio) == REQ_OP_READ && is_data_bbio(bbio))
 		btrfs_check_read_bio(bbio, NULL);
 	else
-		btrfs_orig_bbio_end_io(bbio);
+		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 
 	btrfs_put_bioc(bioc);
 }
@@ -424,7 +408,7 @@ static void btrfs_orig_write_end_io(struct bio *bio)
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND && !bio->bi_status)
 		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 
-	btrfs_orig_bbio_end_io(bbio);
+	btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 	btrfs_put_bioc(bioc);
 }
 
@@ -593,7 +577,7 @@ static void run_one_async_done(struct btrfs_work *work, bool do_free)
 
 	/* If an error occurred we just want to clean up the bio and move on. */
 	if (bio->bi_status) {
-		btrfs_orig_bbio_end_io(async->bbio);
+		btrfs_bio_end_io(async->bbio, async->bbio->bio.bi_status);
 		return;
 	}
 
@@ -765,11 +749,9 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		ASSERT(bbio->bio.bi_pool == &btrfs_clone_bioset);
 		ASSERT(remaining);
 
-		remaining->bio.bi_status = ret;
-		btrfs_orig_bbio_end_io(remaining);
+		btrfs_bio_end_io(remaining, ret);
 	}
-	bbio->bio.bi_status = ret;
-	btrfs_orig_bbio_end_io(bbio);
+	btrfs_bio_end_io(bbio, ret);
 	/* Do not submit another chunk */
 	return true;
 }
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index d9dd5276093d..043f94562166 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -79,6 +79,9 @@ struct btrfs_bio {
 	/* File system that this I/O operates on. */
 	struct btrfs_fs_info *fs_info;
 
+	/* Save the first error status of split bio. */
+	blk_status_t status;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index f6dbda37a361..990ef97accec 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -772,12 +772,12 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 	 * We can get a merged extent, in that case, we need to re-search
 	 * tree to get the original em for defrag.
 	 *
-	 * If @newer_than is 0 or em::generation < newer_than, we can trust
-	 * this em, as either we don't care about the generation, or the
-	 * merged extent map will be rejected anyway.
+	 * This is because even if we have adjacent extents that are contiguous
+	 * and compatible (same type and flags), we still want to defrag them
+	 * so that we use less metadata (extent items in the extent tree and
+	 * file extent items in the inode's subvolume tree).
 	 */
-	if (em && (em->flags & EXTENT_FLAG_MERGED) &&
-	    newer_than && em->generation >= newer_than) {
+	if (em && (em->flags & EXTENT_FLAG_MERGED)) {
 		free_extent_map(em);
 		em = NULL;
 	}
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 72ae8f64482c..b56ec83bf952 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -227,7 +227,12 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
 	if (extent_map_end(prev) != next->start)
 		return false;
 
-	if (prev->flags != next->flags)
+	/*
+	 * The merged flag is not an on-disk flag, it just indicates we had the
+	 * extent maps of 2 (or more) adjacent extents merged, so factor it out.
+	 */
+	if ((prev->flags & ~EXTENT_FLAG_MERGED) !=
+	    (next->flags & ~EXTENT_FLAG_MERGED))
 		return false;
 
 	if (next->disk_bytenr < EXTENT_MAP_LAST_BYTE - 1)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fcedc43ef291..0485143cd75e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1103,6 +1103,7 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 	if (device->bdev) {
 		fs_devices->open_devices--;
 		device->bdev = NULL;
+		device->bdev_file = NULL;
 	}
 	clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 	btrfs_destroy_dev_zone_info(device);
diff --git a/fs/dax.c b/fs/dax.c
index c62acd2812f8..21b47402b3dc 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1262,35 +1262,46 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
 {
 	struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	loff_t pos = iter->pos;
-	loff_t length = iomap_length(iter);
+	loff_t copy_pos = iter->pos;
+	u64 copy_len = iomap_length(iter);
+	u32 mod;
 	int id = 0;
 	s64 ret = 0;
 	void *daddr = NULL, *saddr = NULL;
 
-	/* don't bother with blocks that are not shared to start with */
-	if (!(iomap->flags & IOMAP_F_SHARED))
-		return length;
+	if (!iomap_want_unshare_iter(iter))
+		return iomap_length(iter);
+
+	/*
+	 * Extend the file range to be aligned to fsblock/pagesize, because
+	 * we need to copy entire blocks, not just the byte range specified.
+	 * Invalidate the mapping because we're about to CoW.
+	 */
+	mod = offset_in_page(copy_pos);
+	if (mod) {
+		copy_len += mod;
+		copy_pos -= mod;
+	}
+
+	mod = offset_in_page(copy_pos + copy_len);
+	if (mod)
+		copy_len += PAGE_SIZE - mod;
+
+	invalidate_inode_pages2_range(iter->inode->i_mapping,
+				      copy_pos >> PAGE_SHIFT,
+				      (copy_pos + copy_len - 1) >> PAGE_SHIFT);
 
 	id = dax_read_lock();
-	ret = dax_iomap_direct_access(iomap, pos, length, &daddr, NULL);
+	ret = dax_iomap_direct_access(iomap, copy_pos, copy_len, &daddr, NULL);
 	if (ret < 0)
 		goto out_unlock;
 
-	/* zero the distance if srcmap is HOLE or UNWRITTEN */
-	if (srcmap->flags & IOMAP_F_SHARED || srcmap->type == IOMAP_UNWRITTEN) {
-		memset(daddr, 0, length);
-		dax_flush(iomap->dax_dev, daddr, length);
-		ret = length;
-		goto out_unlock;
-	}
-
-	ret = dax_iomap_direct_access(srcmap, pos, length, &saddr, NULL);
+	ret = dax_iomap_direct_access(srcmap, copy_pos, copy_len, &saddr, NULL);
 	if (ret < 0)
 		goto out_unlock;
 
-	if (copy_mc_to_kernel(daddr, saddr, length) == 0)
-		ret = length;
+	if (copy_mc_to_kernel(daddr, saddr, copy_len) == 0)
+		ret = iomap_length(iter);
 	else
 		ret = -EIO;
 
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8e6edb662818..c8e984be3982 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1337,16 +1337,11 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
 static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 {
 	struct iomap *iomap = &iter->iomap;
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	loff_t written = 0;
 
-	/* don't bother with blocks that are not shared to start with */
-	if (!(iomap->flags & IOMAP_F_SHARED))
-		return length;
-	/* don't bother with holes or unwritten extents */
-	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
+	if (!iomap_want_unshare_iter(iter))
 		return length;
 
 	do {
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 20cb2008f9e4..035ba52742a5 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1001,6 +1001,11 @@ void nfs_delegation_mark_returned(struct inode *inode,
 	}
 
 	nfs_mark_delegation_revoked(delegation);
+	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
+	spin_unlock(&delegation->lock);
+	if (nfs_detach_delegation(NFS_I(inode), delegation, NFS_SERVER(inode)))
+		nfs_put_delegation(delegation);
+	goto out_rcu_unlock;
 
 out_clear_returning:
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5768b2ff1d1d..8b78d493e301 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1838,14 +1838,12 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (!async_copy)
 			goto out_err;
 		async_copy->cp_nn = nn;
+		INIT_LIST_HEAD(&async_copy->copies);
+		refcount_set(&async_copy->refcount, 1);
 		/* Arbitrary cap on number of pending async copy operations */
 		if (atomic_inc_return(&nn->pending_async_copies) >
-				(int)rqstp->rq_pool->sp_nrthreads) {
-			atomic_dec(&nn->pending_async_copies);
+				(int)rqstp->rq_pool->sp_nrthreads)
 			goto out_err;
-		}
-		INIT_LIST_HEAD(&async_copy->copies);
-		refcount_set(&async_copy->refcount, 1);
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
 		if (!async_copy->cp_src)
 			goto out_err;
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 4905063790c5..9b108052d9f7 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -157,6 +157,9 @@ static int nilfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	/* slow symlink */
 	inode->i_op = &nilfs_symlink_inode_operations;
 	inode_nohighmem(inode);
+	mapping_set_gfp_mask(inode->i_mapping,
+			     mapping_gfp_constraint(inode->i_mapping,
+						    ~__GFP_FS));
 	inode->i_mapping->a_ops = &nilfs_aops;
 	err = page_symlink(inode, symname, l);
 	if (err)
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 7f9073d5c5a5..097e2c7f7f71 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -409,6 +409,7 @@ void nilfs_clear_folio_dirty(struct folio *folio, bool silent)
 
 	folio_clear_uptodate(folio);
 	folio_clear_mappedtodisk(folio);
+	folio_clear_checked(folio);
 
 	head = folio_buffers(folio);
 	if (head) {
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index d31eae611fe0..906ee60d91cb 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1285,7 +1285,14 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 	/* If we are last writer on the inode, drop the block reservation. */
 	if (sbi->options->prealloc &&
 	    ((file->f_mode & FMODE_WRITE) &&
-	     atomic_read(&inode->i_writecount) == 1)) {
+	     atomic_read(&inode->i_writecount) == 1)
+	   /*
+	    * The only file when inode->i_fop = &ntfs_file_operations and
+	    * init_rwsem(&ni->file.run_lock) is not called explicitly is MFT.
+	    *
+	    * Add additional check here.
+	    */
+	    && inode->i_ino != MFT_REC_MFT) {
 		ni_lock(ni);
 		down_write(&ni->file.run_lock);
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 60c975ac38e6..2a017b5c8101 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -102,7 +102,9 @@ void ni_clear(struct ntfs_inode *ni)
 {
 	struct rb_node *node;
 
-	if (!ni->vfs_inode.i_nlink && ni->mi.mrec && is_rec_inuse(ni->mi.mrec))
+	if (!ni->vfs_inode.i_nlink && ni->mi.mrec &&
+	    is_rec_inuse(ni->mi.mrec) &&
+	    !(ni->mi.sbi->flags & NTFS_FLAGS_LOG_REPLAYING))
 		ni_delete_all(ni);
 
 	al_destroy(ni);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 6b0bdc474e76..4804eb9628bb 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -536,11 +536,15 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 	if (inode->i_state & I_NEW)
 		inode = ntfs_read_mft(inode, name, ref);
 	else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
-		/* Inode overlaps? */
-		_ntfs_bad_inode(inode);
+		/*
+		 * Sequence number is not expected.
+		 * Looks like inode was reused but caller uses the old reference
+		 */
+		iput(inode);
+		inode = ERR_PTR(-ESTALE);
 	}
 
-	if (IS_ERR(inode) && name)
+	if (IS_ERR(inode))
 		ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
 
 	return inode;
@@ -1713,7 +1717,10 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	attr = ni_find_attr(ni, NULL, NULL, ATTR_EA, NULL, 0, NULL, NULL);
 	if (attr && attr->non_res) {
 		/* Delete ATTR_EA, if non-resident. */
-		attr_set_size(ni, ATTR_EA, NULL, 0, NULL, 0, NULL, false, NULL);
+		struct runs_tree run;
+		run_init(&run);
+		attr_set_size(ni, ATTR_EA, NULL, 0, &run, 0, NULL, false, NULL);
+		run_close(&run);
 	}
 
 	if (rp_inserted)
diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index 4aae598d6d88..fdc9b2ebf341 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -236,6 +236,9 @@ static inline ssize_t decompress_chunk(u8 *unc, u8 *unc_end, const u8 *cmpr,
 
 	/* Do decompression until pointers are inside range. */
 	while (up < unc_end && cmpr < cmpr_end) {
+		// return err if more than LZNT_CHUNK_SIZE bytes are written
+		if (up - unc > LZNT_CHUNK_SIZE)
+			return -EINVAL;
 		/* Correct index */
 		while (unc + s_max_off[index] < up)
 			index += 1;
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 0a70c3658546..02b745f117a5 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -81,7 +81,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 		if (err < 0)
 			inode = ERR_PTR(err);
 		else {
-			ni_lock(ni);
+			ni_lock_dir(ni);
 			inode = dir_search_u(dir, uni, NULL);
 			ni_unlock(ni);
 		}
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index e5255a251929..79047cd54611 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -334,7 +334,7 @@ struct mft_inode {
 
 /* Nested class for ntfs_inode::ni_lock. */
 enum ntfs_inode_mutex_lock_class {
-	NTFS_INODE_MUTEX_DIRTY,
+	NTFS_INODE_MUTEX_DIRTY = 1,
 	NTFS_INODE_MUTEX_SECURITY,
 	NTFS_INODE_MUTEX_OBJID,
 	NTFS_INODE_MUTEX_REPARSE,
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 6c76503edc20..f810f0419d25 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -223,29 +223,21 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		prev_type = 0;
 		attr = Add2Ptr(rec, off);
 	} else {
-		/* Check if input attr inside record. */
+		/*
+		 * We don't need to check previous attr here. There is
+		 * a bounds checking in the previous round.
+		 */
 		off = PtrOffset(rec, attr);
-		if (off >= used)
-			return NULL;
 
 		asize = le32_to_cpu(attr->size);
-		if (asize < SIZEOF_RESIDENT) {
-			/* Impossible 'cause we should not return such attribute. */
-			return NULL;
-		}
-
-		/* Overflow check. */
-		if (off + asize < off)
-			return NULL;
 
 		prev_type = le32_to_cpu(attr->type);
 		attr = Add2Ptr(attr, asize);
 		off += asize;
 	}
 
-	asize = le32_to_cpu(attr->size);
-
 	/* Can we use the first field (attr->type). */
+	/* NOTE: this code also checks attr->size availability. */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
 		return NULL;
@@ -265,6 +257,8 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	if (t32 < prev_type)
 		return NULL;
 
+	asize = le32_to_cpu(attr->size);
+
 	/* Check overflow and boundary. */
 	if (off + asize < off || off + asize > used)
 		return NULL;
@@ -293,6 +287,10 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	if (attr->non_res != 1)
 		return NULL;
 
+	/* Can we use memory including attr->nres.valid_size? */
+	if (asize < SIZEOF_NONRESIDENT)
+		return NULL;
+
 	t16 = le16_to_cpu(attr->nres.run_off);
 	if (t16 > asize)
 		return NULL;
@@ -319,7 +317,8 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	if (!attr->nres.svcn && is_attr_ext(attr)) {
 		/* First segment of sparse/compressed attribute */
-		if (asize + 8 < SIZEOF_NONRESIDENT_EX)
+		/* Can we use memory including attr->nres.total_size? */
+		if (asize < SIZEOF_NONRESIDENT_EX)
 			return NULL;
 
 		tot_size = le64_to_cpu(attr->nres.total_size);
@@ -329,10 +328,10 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		if (tot_size > alloc_size)
 			return NULL;
 	} else {
-		if (asize + 8 < SIZEOF_NONRESIDENT)
+		if (attr->nres.c_unit)
 			return NULL;
 
-		if (attr->nres.c_unit)
+		if (alloc_size > mi->sbi->volume.size)
 			return NULL;
 	}
 
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index ccc57038a977..02d2beb7ddb9 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1783,6 +1783,14 @@ int ocfs2_remove_inode_range(struct inode *inode,
 		return 0;
 
 	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) {
+		int id_count = ocfs2_max_inline_data_with_xattr(inode->i_sb, di);
+
+		if (byte_start > id_count || byte_start + byte_len > id_count) {
+			ret = -EINVAL;
+			mlog_errno(ret);
+			goto out;
+		}
+
 		ret = ocfs2_truncate_inline(inode, di_bh, byte_start,
 					    byte_start + byte_len, 0);
 		if (ret) {
diff --git a/fs/smb/client/cifs_unicode.c b/fs/smb/client/cifs_unicode.c
index 79d99a913944..4cc6e0896fad 100644
--- a/fs/smb/client/cifs_unicode.c
+++ b/fs/smb/client/cifs_unicode.c
@@ -484,10 +484,21 @@ cifsConvertToUTF16(__le16 *target, const char *source, int srclen,
 			/**
 			 * Remap spaces and periods found at the end of every
 			 * component of the path. The special cases of '.' and
-			 * '..' do not need to be dealt with explicitly because
-			 * they are addressed in namei.c:link_path_walk().
+			 * '..' are need to be handled because of symlinks.
+			 * They are treated as non-end-of-string to avoid
+			 * remapping and breaking symlinks pointing to . or ..
 			 **/
-			if ((i == srclen - 1) || (source[i+1] == '\\'))
+			if ((i == 0 || source[i-1] == '\\') &&
+			    source[i] == '.' &&
+			    (i == srclen-1 || source[i+1] == '\\'))
+				end_of_string = false; /* "." case */
+			else if (i >= 1 &&
+				 (i == 1 || source[i-2] == '\\') &&
+				 source[i-1] == '.' &&
+				 source[i] == '.' &&
+				 (i == srclen-1 || source[i+1] == '\\'))
+				end_of_string = false; /* ".." case */
+			else if ((i == srclen - 1) || (source[i+1] == '\\'))
 				end_of_string = true;
 			else
 				end_of_string = false;
diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 7429b96a6ae5..74abbdf5026c 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -14,6 +14,12 @@
 #include "fs_context.h"
 #include "reparse.h"
 
+static int detect_directory_symlink_target(struct cifs_sb_info *cifs_sb,
+					   const unsigned int xid,
+					   const char *full_path,
+					   const char *symname,
+					   bool *directory);
+
 int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
 				struct dentry *dentry, struct cifs_tcon *tcon,
 				const char *full_path, const char *symname)
@@ -24,6 +30,7 @@ int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
 	struct inode *new;
 	struct kvec iov;
 	__le16 *path;
+	bool directory;
 	char *sym, sep = CIFS_DIR_SEP(cifs_sb);
 	u16 len, plen;
 	int rc = 0;
@@ -45,6 +52,18 @@ int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
 		goto out;
 	}
 
+	/*
+	 * SMB distinguish between symlink to directory and symlink to file.
+	 * They cannot be exchanged (symlink of file type which points to
+	 * directory cannot be resolved and vice-versa). Try to detect if
+	 * the symlink target could be a directory or not. When detection
+	 * fails then treat symlink as a file (non-directory) symlink.
+	 */
+	directory = false;
+	rc = detect_directory_symlink_target(cifs_sb, xid, full_path, symname, &directory);
+	if (rc < 0)
+		goto out;
+
 	plen = 2 * UniStrnlen((wchar_t *)path, PATH_MAX);
 	len = sizeof(*buf) + plen * 2;
 	buf = kzalloc(len, GFP_KERNEL);
@@ -69,7 +88,8 @@ int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
 	iov.iov_base = buf;
 	iov.iov_len = len;
 	new = smb2_get_reparse_inode(&data, inode->i_sb, xid,
-				     tcon, full_path, &iov, NULL);
+				     tcon, full_path, directory,
+				     &iov, NULL);
 	if (!IS_ERR(new))
 		d_instantiate(dentry, new);
 	else
@@ -81,6 +101,144 @@ int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
 	return rc;
 }
 
+static int detect_directory_symlink_target(struct cifs_sb_info *cifs_sb,
+					   const unsigned int xid,
+					   const char *full_path,
+					   const char *symname,
+					   bool *directory)
+{
+	char sep = CIFS_DIR_SEP(cifs_sb);
+	struct cifs_open_parms oparms;
+	struct tcon_link *tlink;
+	struct cifs_tcon *tcon;
+	const char *basename;
+	struct cifs_fid fid;
+	char *resolved_path;
+	int full_path_len;
+	int basename_len;
+	int symname_len;
+	char *path_sep;
+	__u32 oplock;
+	int open_rc;
+
+	/*
+	 * First do some simple check. If the original Linux symlink target ends
+	 * with slash, or last path component is dot or dot-dot then it is for
+	 * sure symlink to the directory.
+	 */
+	basename = kbasename(symname);
+	basename_len = strlen(basename);
+	if (basename_len == 0 || /* symname ends with slash */
+	    (basename_len == 1 && basename[0] == '.') || /* last component is "." */
+	    (basename_len == 2 && basename[0] == '.' && basename[1] == '.')) { /* or ".." */
+		*directory = true;
+		return 0;
+	}
+
+	/*
+	 * For absolute symlinks it is not possible to determinate
+	 * if it should point to directory or file.
+	 */
+	if (symname[0] == '/') {
+		cifs_dbg(FYI,
+			 "%s: cannot determinate if the symlink target path '%s' "
+			 "is directory or not, creating '%s' as file symlink\n",
+			 __func__, symname, full_path);
+		return 0;
+	}
+
+	/*
+	 * If it was not detected as directory yet and the symlink is relative
+	 * then try to resolve the path on the SMB server, check if the path
+	 * exists and determinate if it is a directory or not.
+	 */
+
+	full_path_len = strlen(full_path);
+	symname_len = strlen(symname);
+
+	tlink = cifs_sb_tlink(cifs_sb);
+	if (IS_ERR(tlink))
+		return PTR_ERR(tlink);
+
+	resolved_path = kzalloc(full_path_len + symname_len + 1, GFP_KERNEL);
+	if (!resolved_path) {
+		cifs_put_tlink(tlink);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Compose the resolved SMB symlink path from the SMB full path
+	 * and Linux target symlink path.
+	 */
+	memcpy(resolved_path, full_path, full_path_len+1);
+	path_sep = strrchr(resolved_path, sep);
+	if (path_sep)
+		path_sep++;
+	else
+		path_sep = resolved_path;
+	memcpy(path_sep, symname, symname_len+1);
+	if (sep == '\\')
+		convert_delimiter(path_sep, sep);
+
+	tcon = tlink_tcon(tlink);
+	oparms = CIFS_OPARMS(cifs_sb, tcon, resolved_path,
+			     FILE_READ_ATTRIBUTES, FILE_OPEN, 0, ACL_NO_MODE);
+	oparms.fid = &fid;
+
+	/* Try to open as a directory (NOT_FILE) */
+	oplock = 0;
+	oparms.create_options = cifs_create_options(cifs_sb,
+						    CREATE_NOT_FILE | OPEN_REPARSE_POINT);
+	open_rc = tcon->ses->server->ops->open(xid, &oparms, &oplock, NULL);
+	if (open_rc == 0) {
+		/* Successful open means that the target path is definitely a directory. */
+		*directory = true;
+		tcon->ses->server->ops->close(xid, tcon, &fid);
+	} else if (open_rc == -ENOTDIR) {
+		/* -ENOTDIR means that the target path is definitely a file. */
+		*directory = false;
+	} else if (open_rc == -ENOENT) {
+		/* -ENOENT means that the target path does not exist. */
+		cifs_dbg(FYI,
+			 "%s: symlink target path '%s' does not exist, "
+			 "creating '%s' as file symlink\n",
+			 __func__, symname, full_path);
+	} else {
+		/* Try to open as a file (NOT_DIR) */
+		oplock = 0;
+		oparms.create_options = cifs_create_options(cifs_sb,
+							    CREATE_NOT_DIR | OPEN_REPARSE_POINT);
+		open_rc = tcon->ses->server->ops->open(xid, &oparms, &oplock, NULL);
+		if (open_rc == 0) {
+			/* Successful open means that the target path is definitely a file. */
+			*directory = false;
+			tcon->ses->server->ops->close(xid, tcon, &fid);
+		} else if (open_rc == -EISDIR) {
+			/* -EISDIR means that the target path is definitely a directory. */
+			*directory = true;
+		} else {
+			/*
+			 * This code branch is called when we do not have a permission to
+			 * open the resolved_path or some other client/process denied
+			 * opening the resolved_path.
+			 *
+			 * TODO: Try to use ops->query_dir_first on the parent directory
+			 * of resolved_path, search for basename of resolved_path and
+			 * check if the ATTR_DIRECTORY is set in fi.Attributes. In some
+			 * case this could work also when opening of the path is denied.
+			 */
+			cifs_dbg(FYI,
+				 "%s: cannot determinate if the symlink target path '%s' "
+				 "is directory or not, creating '%s' as file symlink\n",
+				 __func__, symname, full_path);
+		}
+	}
+
+	kfree(resolved_path);
+	cifs_put_tlink(tlink);
+	return 0;
+}
+
 static int nfs_set_reparse_buf(struct reparse_posix_data *buf,
 			       mode_t mode, dev_t dev,
 			       struct kvec *iov)
@@ -108,8 +266,8 @@ static int nfs_set_reparse_buf(struct reparse_posix_data *buf,
 	buf->InodeType = cpu_to_le64(type);
 	buf->ReparseDataLength = cpu_to_le16(len + dlen -
 					     sizeof(struct reparse_data_buffer));
-	*(__le64 *)buf->DataBuffer = cpu_to_le64(((u64)MAJOR(dev) << 32) |
-						 MINOR(dev));
+	*(__le64 *)buf->DataBuffer = cpu_to_le64(((u64)MINOR(dev) << 32) |
+						 MAJOR(dev));
 	iov->iov_base = buf;
 	iov->iov_len = len + dlen;
 	return 0;
@@ -137,7 +295,7 @@ static int mknod_nfs(unsigned int xid, struct inode *inode,
 	};
 
 	new = smb2_get_reparse_inode(&data, inode->i_sb, xid,
-				     tcon, full_path, &iov, NULL);
+				     tcon, full_path, false, &iov, NULL);
 	if (!IS_ERR(new))
 		d_instantiate(dentry, new);
 	else
@@ -283,7 +441,7 @@ static int mknod_wsl(unsigned int xid, struct inode *inode,
 	data.wsl.eas_len = len;
 
 	new = smb2_get_reparse_inode(&data, inode->i_sb,
-				     xid, tcon, full_path,
+				     xid, tcon, full_path, false,
 				     &reparse_iov, &xattr_iov);
 	if (!IS_ERR(new))
 		d_instantiate(dentry, new);
@@ -497,7 +655,7 @@ static void wsl_to_fattr(struct cifs_open_info_data *data,
 		else if (!strncmp(name, SMB2_WSL_XATTR_MODE, nlen))
 			fattr->cf_mode = (umode_t)le32_to_cpu(*(__le32 *)v);
 		else if (!strncmp(name, SMB2_WSL_XATTR_DEV, nlen))
-			fattr->cf_rdev = wsl_mkdev(v);
+			fattr->cf_rdev = reparse_mkdev(v);
 	} while (next);
 out:
 	fattr->cf_dtype = S_DT(fattr->cf_mode);
@@ -518,13 +676,13 @@ bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
 			if (le16_to_cpu(buf->ReparseDataLength) != sizeof(buf->InodeType) + 8)
 				return false;
 			fattr->cf_mode |= S_IFCHR;
-			fattr->cf_rdev = reparse_nfs_mkdev(buf);
+			fattr->cf_rdev = reparse_mkdev(buf->DataBuffer);
 			break;
 		case NFS_SPECFILE_BLK:
 			if (le16_to_cpu(buf->ReparseDataLength) != sizeof(buf->InodeType) + 8)
 				return false;
 			fattr->cf_mode |= S_IFBLK;
-			fattr->cf_rdev = reparse_nfs_mkdev(buf);
+			fattr->cf_rdev = reparse_mkdev(buf->DataBuffer);
 			break;
 		case NFS_SPECFILE_FIFO:
 			fattr->cf_mode |= S_IFIFO;
diff --git a/fs/smb/client/reparse.h b/fs/smb/client/reparse.h
index 2c0644bc4e65..158e7b7aae64 100644
--- a/fs/smb/client/reparse.h
+++ b/fs/smb/client/reparse.h
@@ -18,14 +18,7 @@
  */
 #define IO_REPARSE_TAG_INTERNAL ((__u32)~0U)
 
-static inline dev_t reparse_nfs_mkdev(struct reparse_posix_data *buf)
-{
-	u64 v = le64_to_cpu(*(__le64 *)buf->DataBuffer);
-
-	return MKDEV(v >> 32, v & 0xffffffff);
-}
-
-static inline dev_t wsl_mkdev(void *ptr)
+static inline dev_t reparse_mkdev(void *ptr)
 {
 	u64 v = le64_to_cpu(*(__le64 *)ptr);
 
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index a6dab60e2c01..cdb0e028e73c 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -1198,6 +1198,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 				     const unsigned int xid,
 				     struct cifs_tcon *tcon,
 				     const char *full_path,
+				     bool directory,
 				     struct kvec *reparse_iov,
 				     struct kvec *xattr_iov)
 {
@@ -1217,7 +1218,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 			     FILE_READ_ATTRIBUTES |
 			     FILE_WRITE_ATTRIBUTES,
 			     FILE_CREATE,
-			     CREATE_NOT_DIR | OPEN_REPARSE_POINT,
+			     (directory ? CREATE_NOT_FILE : CREATE_NOT_DIR) | OPEN_REPARSE_POINT,
 			     ACL_NO_MODE);
 	if (xattr_iov)
 		oparms.ea_cctx = xattr_iov;
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index b208232b12a2..5e0855fefcfe 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -61,6 +61,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 				     const unsigned int xid,
 				     struct cifs_tcon *tcon,
 				     const char *full_path,
+				     bool directory,
 				     struct kvec *reparse_iov,
 				     struct kvec *xattr_iov);
 int smb2_query_reparse_point(const unsigned int xid,
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 27a3e9285fbf..2f302da629cb 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -731,6 +731,34 @@ void dup_userfaultfd_complete(struct list_head *fcs)
 	}
 }
 
+void dup_userfaultfd_fail(struct list_head *fcs)
+{
+	struct userfaultfd_fork_ctx *fctx, *n;
+
+	/*
+	 * An error has occurred on fork, we will tear memory down, but have
+	 * allocated memory for fctx's and raised reference counts for both the
+	 * original and child contexts (and on the mm for each as a result).
+	 *
+	 * These would ordinarily be taken care of by a user handling the event,
+	 * but we are no longer doing so, so manually clean up here.
+	 *
+	 * mm tear down will take care of cleaning up VMA contexts.
+	 */
+	list_for_each_entry_safe(fctx, n, fcs, list) {
+		struct userfaultfd_ctx *octx = fctx->orig;
+		struct userfaultfd_ctx *ctx = fctx->new;
+
+		atomic_dec(&octx->mmap_changing);
+		VM_BUG_ON(atomic_read(&octx->mmap_changing) < 0);
+		userfaultfd_ctx_put(octx);
+		userfaultfd_ctx_put(ctx);
+
+		list_del(&fctx->list);
+		kfree(fctx);
+	}
+}
+
 void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 			     struct vm_userfaultfd_ctx *vm_ctx)
 {
diff --git a/fs/xfs/xfs_filestream.c b/fs/xfs/xfs_filestream.c
index e3aaa0555597..88bd23ce74cd 100644
--- a/fs/xfs/xfs_filestream.c
+++ b/fs/xfs/xfs_filestream.c
@@ -64,7 +64,7 @@ xfs_filestream_pick_ag(
 	struct xfs_perag	*pag;
 	struct xfs_perag	*max_pag = NULL;
 	xfs_extlen_t		minlen = *longest;
-	xfs_extlen_t		free = 0, minfree, maxfree = 0;
+	xfs_extlen_t		minfree, maxfree = 0;
 	xfs_agnumber_t		agno;
 	bool			first_pass = true;
 	int			err;
@@ -107,7 +107,6 @@ xfs_filestream_pick_ag(
 			     !(flags & XFS_PICK_USERDATA) ||
 			     (flags & XFS_PICK_LOWSPACE))) {
 				/* Break out, retaining the reference on the AG. */
-				free = pag->pagf_freeblks;
 				break;
 			}
 		}
@@ -150,23 +149,25 @@ xfs_filestream_pick_ag(
 		 * grab.
 		 */
 		if (!max_pag) {
-			for_each_perag_wrap(args->mp, 0, start_agno, args->pag)
+			for_each_perag_wrap(args->mp, 0, start_agno, pag) {
+				max_pag = pag;
 				break;
-			atomic_inc(&args->pag->pagf_fstrms);
-			*longest = 0;
-		} else {
-			pag = max_pag;
-			free = maxfree;
-			atomic_inc(&pag->pagf_fstrms);
+			}
+
+			/* Bail if there are no AGs at all to select from. */
+			if (!max_pag)
+				return -ENOSPC;
 		}
+
+		pag = max_pag;
+		atomic_inc(&pag->pagf_fstrms);
 	} else if (max_pag) {
 		xfs_perag_rele(max_pag);
 	}
 
-	trace_xfs_filestream_pick(pag, pino, free);
+	trace_xfs_filestream_pick(pag, pino);
 	args->pag = pag;
 	return 0;
-
 }
 
 static struct xfs_inode *
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 180ce697305a..f681a195a744 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -691,8 +691,8 @@ DEFINE_FILESTREAM_EVENT(xfs_filestream_lookup);
 DEFINE_FILESTREAM_EVENT(xfs_filestream_scan);
 
 TRACE_EVENT(xfs_filestream_pick,
-	TP_PROTO(struct xfs_perag *pag, xfs_ino_t ino, xfs_extlen_t free),
-	TP_ARGS(pag, ino, free),
+	TP_PROTO(struct xfs_perag *pag, xfs_ino_t ino),
+	TP_ARGS(pag, ino),
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(xfs_ino_t, ino)
@@ -703,14 +703,9 @@ TRACE_EVENT(xfs_filestream_pick,
 	TP_fast_assign(
 		__entry->dev = pag->pag_mount->m_super->s_dev;
 		__entry->ino = ino;
-		if (pag) {
-			__entry->agno = pag->pag_agno;
-			__entry->streams = atomic_read(&pag->pagf_fstrms);
-		} else {
-			__entry->agno = NULLAGNUMBER;
-			__entry->streams = 0;
-		}
-		__entry->free = free;
+		__entry->agno = pag->pag_agno;
+		__entry->streams = atomic_read(&pag->pagf_fstrms);
+		__entry->free = pag->pagf_freeblks;
 	),
 	TP_printk("dev %d:%d ino 0x%llx agno 0x%x streams %d free %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index e1720d930666..a451ca4c207b 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -65,7 +65,7 @@ struct cpc_desc {
 	int write_cmd_status;
 	int write_cmd_id;
 	/* Lock used for RMW operations in cpc_write() */
-	spinlock_t rmw_lock;
+	raw_spinlock_t rmw_lock;
 	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
 	struct acpi_psd_package domain_info;
 	struct kobject kobj;
diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index e7cc17ee4934..afdd46ef04f7 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -120,4 +120,8 @@ drm_kunit_helper_create_crtc(struct kunit *test,
 			     const struct drm_crtc_funcs *funcs,
 			     const struct drm_crtc_helper_funcs *helper_funcs);
 
+struct drm_display_mode *
+drm_kunit_display_mode_from_cea_vic(struct kunit *test, struct drm_device *dev,
+				    u8 video_code);
+
 #endif // DRM_KUNIT_HELPERS_H_
diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index aaf004d94322..e45162ef59bb 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -33,6 +33,9 @@ int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma, struct obj_cgroup *objcg
 int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size);
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
 
+/* Check the allocation size for kmalloc equivalent allocator */
+int bpf_mem_alloc_check_size(bool percpu, size_t size);
+
 /* kmalloc/kfree equivalent: */
 void *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size);
 void bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr);
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index f805adaa316e..cd6f9aae311f 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -80,7 +80,11 @@
 #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
 
+#ifdef __SANITIZE_HWADDRESS__
+#define __no_sanitize_address __attribute__((__no_sanitize__("hwaddress")))
+#else
 #define __no_sanitize_address __attribute__((__no_sanitize_address__))
+#endif
 
 #if defined(__SANITIZE_THREAD__)
 #define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
diff --git a/include/linux/device.h b/include/linux/device.h
index 34eb20f5966f..02d840f5c226 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1073,6 +1073,9 @@ int device_for_each_child(struct device *dev, void *data,
 			  int (*fn)(struct device *dev, void *data));
 int device_for_each_child_reverse(struct device *dev, void *data,
 				  int (*fn)(struct device *dev, void *data));
+int device_for_each_child_reverse_from(struct device *parent,
+				       struct device *from, const void *data,
+				       int (*fn)(struct device *, const void *));
 struct device *device_find_child(struct device *dev, void *data,
 				 int (*match)(struct device *dev, void *data));
 struct device *device_find_child_by_name(struct device *parent,
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index d275736230b3..81f7b623d0ba 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -15,6 +15,7 @@
 
 struct dpll_device;
 struct dpll_pin;
+struct dpll_pin_esync;
 
 struct dpll_device_ops {
 	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
@@ -83,6 +84,13 @@ struct dpll_pin_ops {
 	int (*ffo_get)(const struct dpll_pin *pin, void *pin_priv,
 		       const struct dpll_device *dpll, void *dpll_priv,
 		       s64 *ffo, struct netlink_ext_ack *extack);
+	int (*esync_set)(const struct dpll_pin *pin, void *pin_priv,
+			 const struct dpll_device *dpll, void *dpll_priv,
+			 u64 freq, struct netlink_ext_ack *extack);
+	int (*esync_get)(const struct dpll_pin *pin, void *pin_priv,
+			 const struct dpll_device *dpll, void *dpll_priv,
+			 struct dpll_pin_esync *esync,
+			 struct netlink_ext_ack *extack);
 };
 
 struct dpll_pin_frequency {
@@ -111,6 +119,13 @@ struct dpll_pin_phase_adjust_range {
 	s32 max;
 };
 
+struct dpll_pin_esync {
+	u64 freq;
+	const struct dpll_pin_frequency *range;
+	u8 range_num;
+	u8 pulse;
+};
+
 struct dpll_pin_properties {
 	const char *board_label;
 	const char *panel_label;
diff --git a/include/linux/input.h b/include/linux/input.h
index 89a0be6ee0e2..cd866b020a01 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -339,12 +339,16 @@ struct input_handler {
  * @name: name given to the handle by handler that created it
  * @dev: input device the handle is attached to
  * @handler: handler that works with the device through this handle
+ * @handle_events: event sequence handler. It is set up by the input core
+ *	according to event handling method specified in the @handler. See
+ *	input_handle_setup_event_handler().
+ *	This method is being called by the input core with interrupts disabled
+ *	and dev->event_lock spinlock held and so it may not sleep.
  * @d_node: used to put the handle on device's list of attached handles
  * @h_node: used to put the handle on handler's list of handles from which
  *	it gets events
  */
 struct input_handle {
-
 	void *private;
 
 	int open;
@@ -353,6 +357,10 @@ struct input_handle {
 	struct input_dev *dev;
 	struct input_handler *handler;
 
+	unsigned int (*handle_events)(struct input_handle *handle,
+				      struct input_value *vals,
+				      unsigned int count);
+
 	struct list_head	d_node;
 	struct list_head	h_node;
 };
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fc1c858013d..034399030609 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -256,6 +256,25 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
 	return &i->iomap;
 }
 
+/*
+ * Check if the range needs to be unshared for a FALLOC_FL_UNSHARE_RANGE
+ * operation.
+ *
+ * Don't bother with blocks that are not shared to start with; or mappings that
+ * cannot be shared, such as inline data, delalloc reservations, holes or
+ * unwritten extents.
+ *
+ * Note that we use srcmap directly instead of iomap_iter_srcmap as unsharing
+ * requires providing a separate source map, and the presence of one is a good
+ * indicator that unsharing is needed, unlike IOMAP_F_SHARED which can be set
+ * for any data that goes into the COW fork for XFS.
+ */
+static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
+{
+	return (iter->iomap.flags & IOMAP_F_SHARED) &&
+		iter->srcmap.type == IOMAP_MAPPED;
+}
+
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 11690dacd986..ec9c05044d4f 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -54,12 +54,11 @@ static inline long mm_ksm_zero_pages(struct mm_struct *mm)
 	return atomic_long_read(&mm->ksm_zero_pages);
 }
 
-static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
+static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
+	/* Adding mm to ksm is best effort on fork. */
 	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
-		return __ksm_enter(mm);
-
-	return 0;
+		__ksm_enter(mm);
 }
 
 static inline int ksm_execve(struct mm_struct *mm)
@@ -107,9 +106,8 @@ static inline int ksm_disable(struct mm_struct *mm)
 	return 0;
 }
 
-static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
+static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	return 0;
 }
 
 static inline int ksm_execve(struct mm_struct *mm)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1dc6248feb83..fd04c8e94225 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -458,9 +458,7 @@ struct lru_gen_folio {
 
 enum {
 	MM_LEAF_TOTAL,		/* total leaf entries */
-	MM_LEAF_OLD,		/* old leaf entries */
 	MM_LEAF_YOUNG,		/* young leaf entries */
-	MM_NONLEAF_TOTAL,	/* total non-leaf entries */
 	MM_NONLEAF_FOUND,	/* non-leaf entries found in Bloom filters */
 	MM_NONLEAF_ADDED,	/* non-leaf entries added to Bloom filters */
 	NR_MM_STATS
@@ -557,7 +555,7 @@ struct lru_gen_memcg {
 
 void lru_gen_init_pgdat(struct pglist_data *pgdat);
 void lru_gen_init_lruvec(struct lruvec *lruvec);
-void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
+bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
 
 void lru_gen_init_memcg(struct mem_cgroup *memcg);
 void lru_gen_exit_memcg(struct mem_cgroup *memcg);
@@ -576,8 +574,9 @@ static inline void lru_gen_init_lruvec(struct lruvec *lruvec)
 {
 }
 
-static inline void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
+static inline bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 {
+	return false;
 }
 
 static inline void lru_gen_init_memcg(struct mem_cgroup *memcg)
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index d9ac7b136aea..522123050ff8 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -111,6 +111,11 @@ static inline void __kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	kvfree(ptr);
 }
 
+static inline void kvfree_rcu_barrier(void)
+{
+	rcu_barrier();
+}
+
 #ifdef CONFIG_KASAN_GENERIC
 void kvfree_call_rcu(struct rcu_head *head, void *ptr);
 #else
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 254244202ea9..58e7db80f3a8 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -35,6 +35,7 @@ static inline void rcu_virt_note_context_switch(void)
 
 void synchronize_rcu_expedited(void);
 void kvfree_call_rcu(struct rcu_head *head, void *ptr);
+void kvfree_rcu_barrier(void);
 
 void rcu_barrier(void);
 void rcu_momentary_dyntick_idle(void);
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 72744638c5b0..99c9c5a7252a 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -251,12 +251,19 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
 	if (tick_nohz_full_enabled())
 		tick_nohz_dep_set_task(tsk, bit);
 }
+
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit)
 {
 	if (tick_nohz_full_enabled())
 		tick_nohz_dep_clear_task(tsk, bit);
 }
+
+static inline void tick_dep_init_task(struct task_struct *tsk)
+{
+	atomic_set(&tsk->tick_dep_mask, 0);
+}
+
 static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit)
 {
@@ -290,6 +297,7 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
+static inline void tick_dep_init_task(struct task_struct *tsk) { }
 static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
diff --git a/include/linux/ubsan.h b/include/linux/ubsan.h
index bff7445498de..d8219cbe09ff 100644
--- a/include/linux/ubsan.h
+++ b/include/linux/ubsan.h
@@ -4,6 +4,11 @@
 
 #ifdef CONFIG_UBSAN_TRAP
 const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type);
+#else
+static inline const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
+{
+	return NULL;
+}
 #endif
 
 #endif
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index a12bcf042551..f4a45a37229a 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -249,6 +249,7 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 
 extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
 extern void dup_userfaultfd_complete(struct list_head *);
+void dup_userfaultfd_fail(struct list_head *);
 
 extern void mremap_userfaultfd_prep(struct vm_area_struct *,
 				    struct vm_userfaultfd_ctx *);
@@ -332,6 +333,10 @@ static inline void dup_userfaultfd_complete(struct list_head *l)
 {
 }
 
+static inline void dup_userfaultfd_fail(struct list_head *l)
+{
+}
+
 static inline void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 					   struct vm_userfaultfd_ctx *ctx)
 {
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1db2417b8ff5..35d1e09940b2 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -354,7 +354,7 @@ static inline void ip_tunnel_init_flow(struct flowi4 *fl4,
 	memset(fl4, 0, sizeof(*fl4));
 
 	if (oif) {
-		fl4->flowi4_l3mdev = l3mdev_master_upper_ifindex_by_index_rcu(net, oif);
+		fl4->flowi4_l3mdev = l3mdev_master_upper_ifindex_by_index(net, oif);
 		/* Legacy VRF/l3mdev use case */
 		fl4->flowi4_oif = fl4->flowi4_l3mdev ? 0 : oif;
 	}
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 450c44c83a5d..a0aed1a428a1 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -331,7 +331,11 @@ enum yfs_cm_operation {
 	EM(afs_edit_dir_delete,			"delete") \
 	EM(afs_edit_dir_delete_error,		"d_err ") \
 	EM(afs_edit_dir_delete_inval,		"d_invl") \
-	E_(afs_edit_dir_delete_noent,		"d_nent")
+	EM(afs_edit_dir_delete_noent,		"d_nent") \
+	EM(afs_edit_dir_update_dd,		"u_ddot") \
+	EM(afs_edit_dir_update_error,		"u_fail") \
+	EM(afs_edit_dir_update_inval,		"u_invl") \
+	E_(afs_edit_dir_update_nodd,		"u_nodd")
 
 #define afs_edit_dir_reasons				  \
 	EM(afs_edit_dir_for_create,		"Create") \
@@ -340,6 +344,7 @@ enum yfs_cm_operation {
 	EM(afs_edit_dir_for_rename_0,		"Renam0") \
 	EM(afs_edit_dir_for_rename_1,		"Renam1") \
 	EM(afs_edit_dir_for_rename_2,		"Renam2") \
+	EM(afs_edit_dir_for_rename_sub,		"RnmSub") \
 	EM(afs_edit_dir_for_rmdir,		"RmDir ") \
 	EM(afs_edit_dir_for_silly_0,		"S_Ren0") \
 	EM(afs_edit_dir_for_silly_1,		"S_Ren1") \
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index 0c13d7f1a1bc..b0654ade7b7e 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -210,6 +210,9 @@ enum dpll_a_pin {
 	DPLL_A_PIN_PHASE_ADJUST,
 	DPLL_A_PIN_PHASE_OFFSET,
 	DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
+	DPLL_A_PIN_ESYNC_FREQUENCY,
+	DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED,
+	DPLL_A_PIN_ESYNC_PULSE,
 
 	__DPLL_A_PIN_MAX,
 	DPLL_A_PIN_MAX = (__DPLL_A_PIN_MAX - 1)
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 6b3bc0876f7f..19e2c1f9c4a2 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -1016,6 +1016,25 @@ int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags)
 	return IOU_OK;
 }
 
+static bool io_kiocb_start_write(struct io_kiocb *req, struct kiocb *kiocb)
+{
+	struct inode *inode;
+	bool ret;
+
+	if (!(req->flags & REQ_F_ISREG))
+		return true;
+	if (!(kiocb->ki_flags & IOCB_NOWAIT)) {
+		kiocb_start_write(kiocb);
+		return true;
+	}
+
+	inode = file_inode(kiocb->ki_filp);
+	ret = sb_start_write_trylock(inode->i_sb);
+	if (ret)
+		__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+	return ret;
+}
+
 int io_write(struct io_kiocb *req, unsigned int issue_flags)
 {
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
@@ -1053,8 +1072,8 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(ret))
 		return ret;
 
-	if (req->flags & REQ_F_ISREG)
-		kiocb_start_write(kiocb);
+	if (unlikely(!io_kiocb_start_write(req, kiocb)))
+		return -EAGAIN;
 	kiocb->ki_flags |= IOCB_WRITE;
 
 	if (likely(req->file->f_op->write_iter))
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 8ba73042a239..479a2ea5d9af 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -24,6 +24,23 @@
 DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
 EXPORT_SYMBOL(cgroup_bpf_enabled_key);
 
+/*
+ * cgroup bpf destruction makes heavy use of work items and there can be a lot
+ * of concurrent destructions.  Use a separate workqueue so that cgroup bpf
+ * destruction work items don't end up filling up max_active of system_wq
+ * which may lead to deadlock.
+ */
+static struct workqueue_struct *cgroup_bpf_destroy_wq;
+
+static int __init cgroup_bpf_wq_init(void)
+{
+	cgroup_bpf_destroy_wq = alloc_workqueue("cgroup_bpf_destroy", 0, 1);
+	if (!cgroup_bpf_destroy_wq)
+		panic("Failed to alloc workqueue for cgroup bpf destroy.\n");
+	return 0;
+}
+core_initcall(cgroup_bpf_wq_init);
+
 /* __always_inline is necessary to prevent indirect call through run_prog
  * function pointer.
  */
@@ -334,7 +351,7 @@ static void cgroup_bpf_release_fn(struct percpu_ref *ref)
 	struct cgroup *cgrp = container_of(ref, struct cgroup, bpf.refcnt);
 
 	INIT_WORK(&cgrp->bpf.release_work, cgroup_bpf_release);
-	queue_work(system_wq, &cgrp->bpf.release_work);
+	queue_work(cgroup_bpf_destroy_wq, &cgrp->bpf.release_work);
 }
 
 /* Get underlying bpf_prog of bpf_prog_list entry, regardless if it's through
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cc8c00864a68..8419de44c517 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2830,12 +2830,14 @@ struct bpf_iter_bits {
 	__u64 __opaque[2];
 } __aligned(8);
 
+#define BITS_ITER_NR_WORDS_MAX 511
+
 struct bpf_iter_bits_kern {
 	union {
 		unsigned long *bits;
 		unsigned long bits_copy;
 	};
-	u32 nr_bits;
+	int nr_bits;
 	int bit;
 } __aligned(8);
 
@@ -2844,7 +2846,8 @@ struct bpf_iter_bits_kern {
  * @it: The new bpf_iter_bits to be created
  * @unsafe_ptr__ign: A pointer pointing to a memory area to be iterated over
  * @nr_words: The size of the specified memory area, measured in 8-byte units.
- * Due to the limitation of memalloc, it can't be greater than 512.
+ * The maximum value of @nr_words is @BITS_ITER_NR_WORDS_MAX. This limit may be
+ * further reduced by the BPF memory allocator implementation.
  *
  * This function initializes a new bpf_iter_bits structure for iterating over
  * a memory area which is specified by the @unsafe_ptr__ign and @nr_words. It
@@ -2871,6 +2874,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 
 	if (!unsafe_ptr__ign || !nr_words)
 		return -EINVAL;
+	if (nr_words > BITS_ITER_NR_WORDS_MAX)
+		return -E2BIG;
 
 	/* Optimization for u64 mask */
 	if (nr_bits == 64) {
@@ -2882,6 +2887,9 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 		return 0;
 	}
 
+	if (bpf_mem_alloc_check_size(false, nr_bytes))
+		return -E2BIG;
+
 	/* Fallback to memalloc */
 	kit->bits = bpf_mem_alloc(&bpf_global_ma, nr_bytes);
 	if (!kit->bits)
@@ -2909,17 +2917,16 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 __bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
 {
 	struct bpf_iter_bits_kern *kit = (void *)it;
-	u32 nr_bits = kit->nr_bits;
+	int bit = kit->bit, nr_bits = kit->nr_bits;
 	const unsigned long *bits;
-	int bit;
 
-	if (nr_bits == 0)
+	if (!nr_bits || bit >= nr_bits)
 		return NULL;
 
 	bits = nr_bits == 64 ? &kit->bits_copy : kit->bits;
-	bit = find_next_bit(bits, nr_bits, kit->bit + 1);
+	bit = find_next_bit(bits, nr_bits, bit + 1);
 	if (bit >= nr_bits) {
-		kit->nr_bits = 0;
+		kit->bit = bit;
 		return NULL;
 	}
 
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 0218a5132ab5..9b60eda0f727 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -655,7 +655,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
 	if (!key || key->prefixlen > trie->max_prefixlen)
 		goto find_leftmost;
 
-	node_stack = kmalloc_array(trie->max_prefixlen,
+	node_stack = kmalloc_array(trie->max_prefixlen + 1,
 				   sizeof(struct lpm_trie_node *),
 				   GFP_ATOMIC | __GFP_NOWARN);
 	if (!node_stack)
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index dec892ded031..b2c7a4c49be7 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -35,6 +35,8 @@
  */
 #define LLIST_NODE_SZ sizeof(struct llist_node)
 
+#define BPF_MEM_ALLOC_SIZE_MAX 4096
+
 /* similar to kmalloc, but sizeof == 8 bucket is gone */
 static u8 size_index[24] __ro_after_init = {
 	3,	/* 8 */
@@ -65,7 +67,7 @@ static u8 size_index[24] __ro_after_init = {
 
 static int bpf_mem_cache_idx(size_t size)
 {
-	if (!size || size > 4096)
+	if (!size || size > BPF_MEM_ALLOC_SIZE_MAX)
 		return -1;
 
 	if (size <= 192)
@@ -1005,3 +1007,13 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
 
 	return !ret ? NULL : ret + LLIST_NODE_SZ;
 }
+
+int bpf_mem_alloc_check_size(bool percpu, size_t size)
+{
+	/* The size of percpu allocation doesn't have LLIST_NODE_SZ overhead */
+	if ((percpu && size > BPF_MEM_ALLOC_SIZE_MAX) ||
+	    (!percpu && size > BPF_MEM_ALLOC_SIZE_MAX - LLIST_NODE_SZ))
+		return -E2BIG;
+
+	return 0;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77b60896200e..626c5284ca5a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17416,9 +17416,11 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	struct bpf_verifier_state_list *sl, **pprev;
 	struct bpf_verifier_state *cur = env->cur_state, *new, *loop_entry;
 	int i, j, n, err, states_cnt = 0;
-	bool force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx);
-	bool add_new_state = force_new_state;
-	bool force_exact;
+	bool force_new_state, add_new_state, force_exact;
+
+	force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
+			  /* Avoid accumulating infinitely long jmp history */
+			  cur->jmp_history_cnt > 40;
 
 	/* bpf progs typically have pruning point every 4 instructions
 	 * http://vger.kernel.org/bpfconf2019.html#session-1
@@ -17428,6 +17430,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	 * In tests that amounts to up to 50% reduction into total verifier
 	 * memory consumption and 20% verifier time speedup.
 	 */
+	add_new_state = force_new_state;
 	if (env->jmps_processed - env->prev_jmps_processed >= 2 &&
 	    env->insn_processed - env->prev_insn_processed >= 8)
 		add_new_state = true;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c8e4b62b436a..6ba7dd2ab771 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5722,7 +5722,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 {
 	struct cgroup *cgroup;
 	int ret = false;
-	int level = 1;
+	int level = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -5730,7 +5730,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 		if (cgroup->nr_descendants >= cgroup->max_descendants)
 			goto fail;
 
-		if (level > cgroup->max_depth)
+		if (level >= cgroup->max_depth)
 			goto fail;
 
 		level++;
diff --git a/kernel/fork.c b/kernel/fork.c
index 6b97fb2ac4af..dc08a2374733 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -104,6 +104,7 @@
 #include <linux/rseq.h>
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
+#include <linux/tick.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -652,11 +653,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	mm->exec_vm = oldmm->exec_vm;
 	mm->stack_vm = oldmm->stack_vm;
 
-	retval = ksm_fork(mm, oldmm);
-	if (retval)
-		goto out;
-	khugepaged_fork(mm, oldmm);
-
 	/* Use __mt_dup() to efficiently build an identical maple tree. */
 	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
 	if (unlikely(retval))
@@ -759,6 +755,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	vma_iter_free(&vmi);
 	if (!retval) {
 		mt_set_in_rcu(vmi.mas.tree);
+		ksm_fork(mm, oldmm);
+		khugepaged_fork(mm, oldmm);
 	} else if (mpnt) {
 		/*
 		 * The entire maple tree has already been duplicated. If the
@@ -774,7 +772,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
-	dup_userfaultfd_complete(&uf);
+	if (!retval)
+		dup_userfaultfd_complete(&uf);
+	else
+		dup_userfaultfd_fail(&uf);
 fail_uprobe_end:
 	uprobe_end_dup_mmap();
 	return retval;
@@ -2290,6 +2291,7 @@ __latent_entropy struct task_struct *copy_process(
 	acct_clear_integrals(p);
 
 	posix_cputimers_init(&p->posix_cputimers);
+	tick_dep_init_task(p);
 
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..8af1354b2231 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3584,18 +3584,15 @@ kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
 }
 
 /*
- * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
+ * Return: %true if a work is queued, %false otherwise.
  */
-static void kfree_rcu_monitor(struct work_struct *work)
+static bool
+kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
 {
-	struct kfree_rcu_cpu *krcp = container_of(work,
-		struct kfree_rcu_cpu, monitor_work.work);
 	unsigned long flags;
+	bool queued = false;
 	int i, j;
 
-	// Drain ready for reclaim.
-	kvfree_rcu_drain_ready(krcp);
-
 	raw_spin_lock_irqsave(&krcp->lock, flags);
 
 	// Attempt to start a new batch.
@@ -3630,15 +3627,32 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			}
 
 			// One work is per one batch, so there are three
-			// "free channels", the batch can handle. It can
-			// be that the work is in the pending state when
-			// channels have been detached following by each
-			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			// "free channels", the batch can handle. Break
+			// the loop since it is done with this CPU thus
+			// queuing an RCU work is _always_ success here.
+			queued = queue_rcu_work(system_wq, &krwp->rcu_work);
+			WARN_ON_ONCE(!queued);
+			break;
 		}
 	}
 
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+	return queued;
+}
+
+/*
+ * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
+ */
+static void kfree_rcu_monitor(struct work_struct *work)
+{
+	struct kfree_rcu_cpu *krcp = container_of(work,
+		struct kfree_rcu_cpu, monitor_work.work);
+
+	// Drain ready for reclaim.
+	kvfree_rcu_drain_ready(krcp);
+
+	// Queue a batch for a rest.
+	kvfree_rcu_queue_batch(krcp);
 
 	// If there is nothing to detach, it means that our job is
 	// successfully done here. In case of having at least one
@@ -3859,6 +3873,86 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
+/**
+ * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
+ *
+ * Note that a single argument of kvfree_rcu() call has a slow path that
+ * triggers synchronize_rcu() following by freeing a pointer. It is done
+ * before the return from the function. Therefore for any single-argument
+ * call that will result in a kfree() to a cache that is to be destroyed
+ * during module exit, it is developer's responsibility to ensure that all
+ * such calls have returned before the call to kmem_cache_destroy().
+ */
+void kvfree_rcu_barrier(void)
+{
+	struct kfree_rcu_cpu_work *krwp;
+	struct kfree_rcu_cpu *krcp;
+	bool queued;
+	int i, cpu;
+
+	/*
+	 * Firstly we detach objects and queue them over an RCU-batch
+	 * for all CPUs. Finally queued works are flushed for each CPU.
+	 *
+	 * Please note. If there are outstanding batches for a particular
+	 * CPU, those have to be finished first following by queuing a new.
+	 */
+	for_each_possible_cpu(cpu) {
+		krcp = per_cpu_ptr(&krc, cpu);
+
+		/*
+		 * Check if this CPU has any objects which have been queued for a
+		 * new GP completion. If not(means nothing to detach), we are done
+		 * with it. If any batch is pending/running for this "krcp", below
+		 * per-cpu flush_rcu_work() waits its completion(see last step).
+		 */
+		if (!need_offload_krc(krcp))
+			continue;
+
+		while (1) {
+			/*
+			 * If we are not able to queue a new RCU work it means:
+			 * - batches for this CPU are still in flight which should
+			 *   be flushed first and then repeat;
+			 * - no objects to detach, because of concurrency.
+			 */
+			queued = kvfree_rcu_queue_batch(krcp);
+
+			/*
+			 * Bail out, if there is no need to offload this "krcp"
+			 * anymore. As noted earlier it can run concurrently.
+			 */
+			if (queued || !need_offload_krc(krcp))
+				break;
+
+			/* There are ongoing batches. */
+			for (i = 0; i < KFREE_N_BATCHES; i++) {
+				krwp = &(krcp->krw_arr[i]);
+				flush_rcu_work(&krwp->rcu_work);
+			}
+		}
+	}
+
+	/*
+	 * Now we guarantee that all objects are flushed.
+	 */
+	for_each_possible_cpu(cpu) {
+		krcp = per_cpu_ptr(&krc, cpu);
+
+		/*
+		 * A monitor work can drain ready to reclaim objects
+		 * directly. Wait its completion if running or pending.
+		 */
+		cancel_delayed_work_sync(&krcp->monitor_work);
+
+		for (i = 0; i < KFREE_N_BATCHES; i++) {
+			krwp = &(krcp->krw_arr[i]);
+			flush_rcu_work(&krwp->rcu_work);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
+
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
diff --git a/kernel/resource.c b/kernel/resource.c
index 1681ab5012e1..4f3df25176ca 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -460,9 +460,7 @@ int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
 			rams_size += 16;
 		}
 
-		rams[i].start = res.start;
-		rams[i++].end = res.end;
-
+		rams[i++] = res;
 		start = res.end + 1;
 	}
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d2cbdb162a6..425348b8d9eb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3289,7 +3289,7 @@ static void task_numa_work(struct callback_head *work)
 		vma = vma_next(&vmi);
 	}
 
-	do {
+	for (; vma; vma = vma_next(&vmi)) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UNSUITABLE);
@@ -3411,7 +3411,7 @@ static void task_numa_work(struct callback_head *work)
 		 */
 		if (vma_pids_forced)
 			break;
-	} for_each_vma(vmi, vma);
+	}
 
 	/*
 	 * If no VMAs are remaining and VMAs were skipped due to the PID
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index bdda600f8dfb..1d4aa7a83b3a 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -29,8 +29,8 @@ config UBSAN_TRAP
 
 	  Also note that selecting Y will cause your kernel to Oops
 	  with an "illegal instruction" error with no further details
-	  when a UBSAN violation occurs. (Except on arm64, which will
-	  report which Sanitizer failed.) This may make it hard to
+	  when a UBSAN violation occurs. (Except on arm64 and x86, which
+	  will report which Sanitizer failed.) This may make it hard to
 	  determine whether an Oops was caused by UBSAN or to figure
 	  out the details of a UBSAN violation. It makes the kernel log
 	  output less useful for bug reports.
diff --git a/lib/codetag.c b/lib/codetag.c
index afa8a2d4f317..d1fbbb7c2ec3 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -228,6 +228,9 @@ bool codetag_unload_module(struct module *mod)
 	if (!mod)
 		return true;
 
+	/* await any module's kfree_rcu() operations to complete */
+	kvfree_rcu_barrier();
+
 	mutex_lock(&codetag_lock);
 	list_for_each_entry(cttype, &codetag_types, link) {
 		struct codetag_module *found = NULL;
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4a6a9f419bd7..b892894228b0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -461,6 +461,8 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		size_t bytes, struct iov_iter *i)
 {
 	size_t n, copied = 0;
+	bool uses_kmap = IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) ||
+			 PageHighMem(page);
 
 	if (!page_copy_sane(page, offset, bytes))
 		return 0;
@@ -471,7 +473,7 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		char *p;
 
 		n = bytes - copied;
-		if (PageHighMem(page)) {
+		if (uses_kmap) {
 			page += offset / PAGE_SIZE;
 			offset %= PAGE_SIZE;
 			n = min_t(size_t, n, PAGE_SIZE - offset);
@@ -482,7 +484,7 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		kunmap_atomic(p);
 		copied += n;
 		offset += n;
-	} while (PageHighMem(page) && copied != bytes && n > 0);
+	} while (uses_kmap && copied != bytes && n > 0);
 
 	return copied;
 }
diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index e6667a28c014..af5b9c41d5b3 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -140,7 +140,7 @@ static void test_kmalloc_redzone_access(struct kunit *test)
 {
 	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_kmalloc", 32,
 				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
-	u8 *p = __kmalloc_cache_noprof(s, GFP_KERNEL, 18);
+	u8 *p = alloc_hooks(__kmalloc_cache_noprof(s, GFP_KERNEL, 18));
 
 	kasan_disable_current();
 
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 7b32be2a3cf0..9efde47f8069 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1765,32 +1765,6 @@ static void vm_map_ram_tags(struct kunit *test)
 	free_pages((unsigned long)p_ptr, 1);
 }
 
-static void vmalloc_percpu(struct kunit *test)
-{
-	char __percpu *ptr;
-	int cpu;
-
-	/*
-	 * This test is specifically crafted for the software tag-based mode,
-	 * the only tag-based mode that poisons percpu mappings.
-	 */
-	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_SW_TAGS);
-
-	ptr = __alloc_percpu(PAGE_SIZE, PAGE_SIZE);
-
-	for_each_possible_cpu(cpu) {
-		char *c_ptr = per_cpu_ptr(ptr, cpu);
-
-		KUNIT_EXPECT_GE(test, (u8)get_tag(c_ptr), (u8)KASAN_TAG_MIN);
-		KUNIT_EXPECT_LT(test, (u8)get_tag(c_ptr), (u8)KASAN_TAG_KERNEL);
-
-		/* Make sure that in-bounds accesses don't crash the kernel. */
-		*c_ptr = 0;
-	}
-
-	free_percpu(ptr);
-}
-
 /*
  * Check that the assigned pointer tag falls within the [KASAN_TAG_MIN,
  * KASAN_TAG_KERNEL) range (note: excluding the match-all tag) for tag-based
@@ -1967,7 +1941,6 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(vmalloc_oob),
 	KUNIT_CASE(vmap_tags),
 	KUNIT_CASE(vm_map_ram_tags),
-	KUNIT_CASE(vmalloc_percpu),
 	KUNIT_CASE(match_all_not_assigned),
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
diff --git a/mm/migrate.c b/mm/migrate.c
index 368ab3878fa6..75b858bd6aa5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1099,7 +1099,7 @@ static void migrate_folio_done(struct folio *src,
 	 * not accounted to NR_ISOLATED_*. They can be recognized
 	 * as __folio_test_movable
 	 */
-	if (likely(!__folio_test_movable(src)))
+	if (likely(!__folio_test_movable(src)) && reason != MR_DEMOTION)
 		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
 				    folio_is_file_lru(src), -folio_nr_pages(src));
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 18fddcce03b8..8a04f29aa423 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1952,7 +1952,8 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 
 	if (get_area) {
 		addr = get_area(file, addr, len, pgoff, flags);
-	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
+		   && IS_ALIGNED(len, PMD_SIZE)) {
 		/* Ensures that larger anonymous mappings are THP aligned. */
 		addr = thp_get_unmapped_area_vmflags(file, addr, len,
 						     pgoff, flags, vm_flags);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 91ace8ca97e2..ec459522c293 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2874,12 +2874,12 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			page = __rmqueue(zone, order, migratetype, alloc_flags);
 
 			/*
-			 * If the allocation fails, allow OOM handling access
-			 * to HIGHATOMIC reserves as failing now is worse than
-			 * failing a high-order atomic allocation in the
-			 * future.
+			 * If the allocation fails, allow OOM handling and
+			 * order-0 (atomic) allocs access to HIGHATOMIC
+			 * reserves as failing now is worse than failing a
+			 * high-order atomic allocation in the future.
 			 */
-			if (!page && (alloc_flags & ALLOC_OOM))
+			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
 				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 
 			if (!page) {
diff --git a/mm/rmap.c b/mm/rmap.c
index 2490e727e2dc..3d89847f01da 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -75,6 +75,7 @@
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/mm_inline.h>
+#include <linux/oom.h>
 
 #include <asm/tlbflush.h>
 
@@ -870,13 +871,24 @@ static bool folio_referenced_one(struct folio *folio,
 			continue;
 		}
 
-		if (pvmw.pte) {
-			if (lru_gen_enabled() &&
-			    pte_young(ptep_get(pvmw.pte))) {
-				lru_gen_look_around(&pvmw);
-				referenced++;
-			}
+		/*
+		 * Skip the non-shared swapbacked folio mapped solely by
+		 * the exiting or OOM-reaped process. This avoids redundant
+		 * swap-out followed by an immediate unmap.
+		 */
+		if ((!atomic_read(&vma->vm_mm->mm_users) ||
+		    check_stable_address_space(vma->vm_mm)) &&
+		    folio_test_anon(folio) && folio_test_swapbacked(folio) &&
+		    !folio_likely_mapped_shared(folio)) {
+			pra->referenced = -1;
+			page_vma_mapped_walk_done(&pvmw);
+			return false;
+		}
 
+		if (lru_gen_enabled() && pvmw.pte) {
+			if (lru_gen_look_around(&pvmw))
+				referenced++;
+		} else if (pvmw.pte) {
 			if (ptep_clear_flush_young_notify(vma, address,
 						pvmw.pte))
 				referenced++;
diff --git a/mm/shmem.c b/mm/shmem.c
index 27f496d6e43e..941d12713952 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1163,7 +1163,9 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
+	inode_lock_shared(inode);
 	generic_fillattr(idmap, request_mask, inode, stat);
+	inode_unlock_shared(inode);
 
 	if (shmem_huge_global_enabled(inode, 0, false, NULL, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
diff --git a/mm/shrinker.c b/mm/shrinker.c
index dc5d2a6fcfc4..4a93fd433689 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -76,19 +76,21 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 
 int alloc_shrinker_info(struct mem_cgroup *memcg)
 {
-	struct shrinker_info *info;
 	int nid, ret = 0;
 	int array_size = 0;
 
 	mutex_lock(&shrinker_mutex);
 	array_size = shrinker_unit_size(shrinker_nr_max);
 	for_each_node(nid) {
-		info = kvzalloc_node(sizeof(*info) + array_size, GFP_KERNEL, nid);
+		struct shrinker_info *info = kvzalloc_node(sizeof(*info) + array_size,
+							   GFP_KERNEL, nid);
 		if (!info)
 			goto err;
 		info->map_nr_max = shrinker_nr_max;
-		if (shrinker_unit_alloc(info, NULL, nid))
+		if (shrinker_unit_alloc(info, NULL, nid)) {
+			kvfree(info);
 			goto err;
+		}
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
 	}
 	mutex_unlock(&shrinker_mutex);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 128f307da6ee..f5bcd08527ae 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -56,6 +56,7 @@
 #include <linux/khugepaged.h>
 #include <linux/rculist_nulls.h>
 #include <linux/random.h>
+#include <linux/mmu_notifier.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -863,7 +864,12 @@ static enum folio_references folio_check_references(struct folio *folio,
 	if (vm_flags & VM_LOCKED)
 		return FOLIOREF_ACTIVATE;
 
-	/* rmap lock contention: rotate */
+	/*
+	 * There are two cases to consider.
+	 * 1) Rmap lock contention: rotate.
+	 * 2) Skip the non-shared swapbacked folio mapped solely by
+	 *    the exiting or OOM-reaped process.
+	 */
 	if (referenced_ptes == -1)
 		return FOLIOREF_KEEP;
 
@@ -3271,7 +3277,8 @@ static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk
 	return false;
 }
 
-static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, unsigned long addr)
+static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, unsigned long addr,
+				 struct pglist_data *pgdat)
 {
 	unsigned long pfn = pte_pfn(pte);
 
@@ -3283,13 +3290,20 @@ static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, unsigned
 	if (WARN_ON_ONCE(pte_devmap(pte) || pte_special(pte)))
 		return -1;
 
+	if (!pte_young(pte) && !mm_has_notifiers(vma->vm_mm))
+		return -1;
+
 	if (WARN_ON_ONCE(!pfn_valid(pfn)))
 		return -1;
 
+	if (pfn < pgdat->node_start_pfn || pfn >= pgdat_end_pfn(pgdat))
+		return -1;
+
 	return pfn;
 }
 
-static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned long addr)
+static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned long addr,
+				 struct pglist_data *pgdat)
 {
 	unsigned long pfn = pmd_pfn(pmd);
 
@@ -3301,9 +3315,15 @@ static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned
 	if (WARN_ON_ONCE(pmd_devmap(pmd)))
 		return -1;
 
+	if (!pmd_young(pmd) && !mm_has_notifiers(vma->vm_mm))
+		return -1;
+
 	if (WARN_ON_ONCE(!pfn_valid(pfn)))
 		return -1;
 
+	if (pfn < pgdat->node_start_pfn || pfn >= pgdat_end_pfn(pgdat))
+		return -1;
+
 	return pfn;
 }
 
@@ -3312,10 +3332,6 @@ static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
 {
 	struct folio *folio;
 
-	/* try to avoid unnecessary memory loads */
-	if (pfn < pgdat->node_start_pfn || pfn >= pgdat_end_pfn(pgdat))
-		return NULL;
-
 	folio = pfn_folio(pfn);
 	if (folio_nid(folio) != pgdat->node_id)
 		return NULL;
@@ -3371,21 +3387,16 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 		total++;
 		walk->mm_stats[MM_LEAF_TOTAL]++;
 
-		pfn = get_pte_pfn(ptent, args->vma, addr);
+		pfn = get_pte_pfn(ptent, args->vma, addr, pgdat);
 		if (pfn == -1)
 			continue;
 
-		if (!pte_young(ptent)) {
-			walk->mm_stats[MM_LEAF_OLD]++;
-			continue;
-		}
-
 		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap);
 		if (!folio)
 			continue;
 
-		if (!ptep_test_and_clear_young(args->vma, addr, pte + i))
-			VM_WARN_ON_ONCE(true);
+		if (!ptep_clear_young_notify(args->vma, addr, pte + i))
+			continue;
 
 		young++;
 		walk->mm_stats[MM_LEAF_YOUNG]++;
@@ -3451,21 +3462,25 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 		/* don't round down the first address */
 		addr = i ? (*first & PMD_MASK) + i * PMD_SIZE : *first;
 
-		pfn = get_pmd_pfn(pmd[i], vma, addr);
-		if (pfn == -1)
+		if (!pmd_present(pmd[i]))
 			goto next;
 
 		if (!pmd_trans_huge(pmd[i])) {
-			if (should_clear_pmd_young())
+			if (!walk->force_scan && should_clear_pmd_young() &&
+			    !mm_has_notifiers(args->mm))
 				pmdp_test_and_clear_young(vma, addr, pmd + i);
 			goto next;
 		}
 
+		pfn = get_pmd_pfn(pmd[i], vma, addr, pgdat);
+		if (pfn == -1)
+			goto next;
+
 		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap);
 		if (!folio)
 			goto next;
 
-		if (!pmdp_test_and_clear_young(vma, addr, pmd + i))
+		if (!pmdp_clear_young_notify(vma, addr, pmd + i))
 			goto next;
 
 		walk->mm_stats[MM_LEAF_YOUNG]++;
@@ -3523,27 +3538,18 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 		}
 
 		if (pmd_trans_huge(val)) {
-			unsigned long pfn = pmd_pfn(val);
 			struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
+			unsigned long pfn = get_pmd_pfn(val, vma, addr, pgdat);
 
 			walk->mm_stats[MM_LEAF_TOTAL]++;
 
-			if (!pmd_young(val)) {
-				walk->mm_stats[MM_LEAF_OLD]++;
-				continue;
-			}
-
-			/* try to avoid unnecessary memory loads */
-			if (pfn < pgdat->node_start_pfn || pfn >= pgdat_end_pfn(pgdat))
-				continue;
-
-			walk_pmd_range_locked(pud, addr, vma, args, bitmap, &first);
+			if (pfn != -1)
+				walk_pmd_range_locked(pud, addr, vma, args, bitmap, &first);
 			continue;
 		}
 
-		walk->mm_stats[MM_NONLEAF_TOTAL]++;
-
-		if (should_clear_pmd_young()) {
+		if (!walk->force_scan && should_clear_pmd_young() &&
+		    !mm_has_notifiers(args->mm)) {
 			if (!pmd_young(val))
 				continue;
 
@@ -4017,13 +4023,13 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
  * the PTE table to the Bloom filter. This forms a feedback loop between the
  * eviction and the aging.
  */
-void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
+bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 {
 	int i;
 	unsigned long start;
 	unsigned long end;
 	struct lru_gen_mm_walk *walk;
-	int young = 0;
+	int young = 1;
 	pte_t *pte = pvmw->pte;
 	unsigned long addr = pvmw->address;
 	struct vm_area_struct *vma = pvmw->vma;
@@ -4039,12 +4045,15 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	lockdep_assert_held(pvmw->ptl);
 	VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
 
+	if (!ptep_clear_young_notify(vma, addr, pte))
+		return false;
+
 	if (spin_is_contended(pvmw->ptl))
-		return;
+		return true;
 
 	/* exclude special VMAs containing anon pages from COW */
 	if (vma->vm_flags & VM_SPECIAL)
-		return;
+		return true;
 
 	/* avoid taking the LRU lock under the PTL when possible */
 	walk = current->reclaim_state ? current->reclaim_state->mm_walk : NULL;
@@ -4052,6 +4061,9 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	start = max(addr & PMD_MASK, vma->vm_start);
 	end = min(addr | ~PMD_MASK, vma->vm_end - 1) + 1;
 
+	if (end - start == PAGE_SIZE)
+		return true;
+
 	if (end - start > MIN_LRU_BATCH * PAGE_SIZE) {
 		if (addr - start < MIN_LRU_BATCH * PAGE_SIZE / 2)
 			end = start + MIN_LRU_BATCH * PAGE_SIZE;
@@ -4065,7 +4077,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 
 	/* folio_update_gen() requires stable folio_memcg() */
 	if (!mem_cgroup_trylock_pages(memcg))
-		return;
+		return true;
 
 	arch_enter_lazy_mmu_mode();
 
@@ -4075,19 +4087,16 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		unsigned long pfn;
 		pte_t ptent = ptep_get(pte + i);
 
-		pfn = get_pte_pfn(ptent, vma, addr);
+		pfn = get_pte_pfn(ptent, vma, addr, pgdat);
 		if (pfn == -1)
 			continue;
 
-		if (!pte_young(ptent))
-			continue;
-
 		folio = get_pfn_folio(pfn, memcg, pgdat, can_swap);
 		if (!folio)
 			continue;
 
-		if (!ptep_test_and_clear_young(vma, addr, pte + i))
-			VM_WARN_ON_ONCE(true);
+		if (!ptep_clear_young_notify(vma, addr, pte + i))
+			continue;
 
 		young++;
 
@@ -4117,6 +4126,8 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	/* feedback from rmap walkers to page table walkers */
 	if (mm_state && suitable_to_scan(i, young))
 		update_bloom_filter(mm_state, max_seq, pvmw->pmd);
+
+	return true;
 }
 
 /******************************************************************************
@@ -5231,11 +5242,11 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 	for (tier = 0; tier < MAX_NR_TIERS; tier++) {
 		seq_printf(m, "            %10d", tier);
 		for (type = 0; type < ANON_AND_FILE; type++) {
-			const char *s = "   ";
+			const char *s = "xxx";
 			unsigned long n[3] = {};
 
 			if (seq == max_seq) {
-				s = "RT ";
+				s = "RTx";
 				n[0] = READ_ONCE(lrugen->avg_refaulted[type][tier]);
 				n[1] = READ_ONCE(lrugen->avg_total[type][tier]);
 			} else if (seq == min_seq[type] || NR_HIST_GENS > 1) {
@@ -5257,14 +5268,14 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 
 	seq_puts(m, "                      ");
 	for (i = 0; i < NR_MM_STATS; i++) {
-		const char *s = "      ";
+		const char *s = "xxxx";
 		unsigned long n = 0;
 
 		if (seq == max_seq && NR_HIST_GENS == 1) {
-			s = "LOYNFA";
+			s = "TYFA";
 			n = READ_ONCE(mm_state->stats[hist][i]);
 		} else if (seq != max_seq && NR_HIST_GENS > 1) {
-			s = "loynfa";
+			s = "tyfa";
 			n = READ_ONCE(mm_state->stats[hist][i]);
 		}
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ae7a5817883a..c0203a2b5107 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -206,6 +206,12 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		return ERR_PTR(err);
 	}
 
+	/* If command return a status event skb will be set to NULL as there are
+	 * no parameters.
+	 */
+	if (!skb)
+		return ERR_PTR(-ENODATA);
+
 	return skb;
 }
 EXPORT_SYMBOL(__hci_cmd_sync_sk);
@@ -255,6 +261,11 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	u8 status;
 
 	skb = __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk);
+
+	/* If command return a status event, skb will be set to -ENODATA */
+	if (skb == ERR_PTR(-ENODATA))
+		return 0;
+
 	if (IS_ERR(skb)) {
 		if (!event)
 			bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld", opcode,
@@ -262,13 +273,6 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		return PTR_ERR(skb);
 	}
 
-	/* If command return a status event skb will be set to NULL as there are
-	 * no parameters, in case of failure IS_ERR(skb) would have be set to
-	 * the actual error would be found with PTR_ERR(skb).
-	 */
-	if (!skb)
-		return 0;
-
 	status = skb->data[0];
 
 	kfree_skb(skb);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 6d7a442ceb89..501ec4249fed 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -246,6 +246,7 @@ static void reset_ctx(struct xdp_page_head *head)
 	head->ctx.data_meta = head->orig_ctx.data_meta;
 	head->ctx.data_end = head->orig_ctx.data_end;
 	xdp_update_frame_from_buff(&head->ctx, head->frame);
+	head->frame->mem = head->orig_ctx.rxq->mem;
 }
 
 static int xdp_recv_frames(struct xdp_frame **frames, int nframes,
diff --git a/net/core/dev.c b/net/core/dev.c
index dd87f5fb2f3a..25f20c5cc8f5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3631,6 +3631,9 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		return 0;
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
+		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+			goto sw_checksum;
 		switch (skb->csum_offset) {
 		case offsetof(struct tcphdr, check):
 		case offsetof(struct udphdr, check):
@@ -3638,6 +3641,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		}
 	}
 
+sw_checksum:
 	return skb_checksum_help(skb);
 }
 EXPORT_SYMBOL(skb_csum_hwoffload_help);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 97a38a7e1b2c..3c5dead0c71c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2032,7 +2032,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_NUM_TX_QUEUES]	= { .type = NLA_U32 },
 	[IFLA_NUM_RX_QUEUES]	= { .type = NLA_U32 },
 	[IFLA_GSO_MAX_SEGS]	= { .type = NLA_U32 },
-	[IFLA_GSO_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_GSO_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_PHYS_PORT_ID]	= { .type = NLA_BINARY, .len = MAX_PHYS_ITEM_ID_LEN },
 	[IFLA_CARRIER_CHANGES]	= { .type = NLA_U32 },  /* ignored */
 	[IFLA_PHYS_SWITCH_ID]	= { .type = NLA_BINARY, .len = MAX_PHYS_ITEM_ID_LEN },
@@ -2057,7 +2057,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_TSO_MAX_SIZE]	= { .type = NLA_REJECT },
 	[IFLA_TSO_MAX_SEGS]	= { .type = NLA_REJECT },
 	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
-	[IFLA_GSO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
 };
 
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 219fd8f1ca2a..0550837775d5 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1771,6 +1771,10 @@ static int sock_map_link_update_prog(struct bpf_link *link,
 		ret = -EINVAL;
 		goto out;
 	}
+	if (!sockmap_link->map) {
+		ret = -ENOLINK;
+		goto out;
+	}
 
 	ret = sock_map_prog_link_lookup(sockmap_link->map, &pprog, &plink,
 					sockmap_link->attach_type);
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 5cffad42fe8c..49937878d5e8 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -217,7 +217,7 @@ static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
 
 	ip_tunnel_flags_copy(flags, parms->i_flags);
 
-	hlist_for_each_entry_rcu(t, head, hash_node) {
+	hlist_for_each_entry_rcu(t, head, hash_node, lockdep_rtnl_is_held()) {
 		if (local == t->parms.iph.saddr &&
 		    remote == t->parms.iph.daddr &&
 		    link == READ_ONCE(t->parms.link) &&
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 7db0437140bf..9ae2b2725bf9 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -268,12 +268,12 @@ static int nf_reject6_fill_skb_dst(struct sk_buff *skb_in)
 void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		    int hook)
 {
-	struct sk_buff *nskb;
-	struct tcphdr _otcph;
-	const struct tcphdr *otcph;
-	unsigned int otcplen, hh_len;
 	const struct ipv6hdr *oip6h = ipv6_hdr(oldskb);
 	struct dst_entry *dst = NULL;
+	const struct tcphdr *otcph;
+	struct sk_buff *nskb;
+	struct tcphdr _otcph;
+	unsigned int otcplen;
 	struct flowi6 fl6;
 
 	if ((!(ipv6_addr_type(&oip6h->saddr) & IPV6_ADDR_UNICAST)) ||
@@ -312,9 +312,8 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	if (IS_ERR(dst))
 		return;
 
-	hh_len = (dst->dev->hard_header_len + 15)&~15;
-	nskb = alloc_skb(hh_len + 15 + dst->header_len + sizeof(struct ipv6hdr)
-			 + sizeof(struct tcphdr) + dst->trailer_len,
+	nskb = alloc_skb(LL_MAX_HEADER + sizeof(struct ipv6hdr) +
+			 sizeof(struct tcphdr) + dst->trailer_len,
 			 GFP_ATOMIC);
 
 	if (!nskb) {
@@ -327,7 +326,7 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 
 	nskb->mark = fl6.flowi6_mark;
 
-	skb_reserve(nskb, hh_len + dst->header_len);
+	skb_reserve(nskb, LL_MAX_HEADER);
 	nf_reject_ip6hdr_put(nskb, oldskb, IPPROTO_TCP, ip6_dst_hoplimit(dst));
 	nf_reject_ip6_tcphdr_put(nskb, oldskb, otcph, otcplen);
 
diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index 13438cc0a6b1..cf0f7780fb10 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -96,7 +96,7 @@ config MAC80211_DEBUGFS
 
 config MAC80211_MESSAGE_TRACING
 	bool "Trace all mac80211 debug messages"
-	depends on MAC80211
+	depends on MAC80211 && TRACING
 	help
 	  Select this option to have mac80211 register the
 	  mac80211_msg trace subsystem with tracepoints to
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b02b84ce2130..f2b5c18417ef 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3138,7 +3138,8 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
-	if (local->ops->get_txpower)
+	if (local->ops->get_txpower &&
+	    (sdata->flags & IEEE80211_SDATA_IN_DRIVER))
 		return drv_get_txpower(local, sdata, dbm);
 
 	if (local->emulate_chanctx)
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index eecdd2265eaa..e45b5f56c405 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -987,6 +987,26 @@ void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata)
 	}
 }
 
+static void
+ieee80211_key_iter(struct ieee80211_hw *hw,
+		   struct ieee80211_vif *vif,
+		   struct ieee80211_key *key,
+		   void (*iter)(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				struct ieee80211_key_conf *key,
+				void *data),
+		   void *iter_data)
+{
+	/* skip keys of station in removal process */
+	if (key->sta && key->sta->removed)
+		return;
+	if (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
+		return;
+	iter(hw, vif, key->sta ? &key->sta->sta : NULL,
+	     &key->conf, iter_data);
+}
+
 void ieee80211_iter_keys(struct ieee80211_hw *hw,
 			 struct ieee80211_vif *vif,
 			 void (*iter)(struct ieee80211_hw *hw,
@@ -1005,16 +1025,13 @@ void ieee80211_iter_keys(struct ieee80211_hw *hw,
 	if (vif) {
 		sdata = vif_to_sdata(vif);
 		list_for_each_entry_safe(key, tmp, &sdata->key_list, list)
-			iter(hw, &sdata->vif,
-			     key->sta ? &key->sta->sta : NULL,
-			     &key->conf, iter_data);
+			ieee80211_key_iter(hw, vif, key, iter, iter_data);
 	} else {
 		list_for_each_entry(sdata, &local->interfaces, list)
 			list_for_each_entry_safe(key, tmp,
 						 &sdata->key_list, list)
-				iter(hw, &sdata->vif,
-				     key->sta ? &key->sta->sta : NULL,
-				     &key->conf, iter_data);
+				ieee80211_key_iter(hw, &sdata->vif, key,
+						   iter, iter_data);
 	}
 }
 EXPORT_SYMBOL(ieee80211_iter_keys);
@@ -1031,17 +1048,8 @@ _ieee80211_iter_keys_rcu(struct ieee80211_hw *hw,
 {
 	struct ieee80211_key *key;
 
-	list_for_each_entry_rcu(key, &sdata->key_list, list) {
-		/* skip keys of station in removal process */
-		if (key->sta && key->sta->removed)
-			continue;
-		if (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
-			continue;
-
-		iter(hw, &sdata->vif,
-		     key->sta ? &key->sta->sta : NULL,
-		     &key->conf, iter_data);
-	}
+	list_for_each_entry_rcu(key, &sdata->key_list, list)
+		ieee80211_key_iter(hw, &sdata->vif, key, iter, iter_data);
 }
 
 void ieee80211_iter_keys_rcu(struct ieee80211_hw *hw,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d4b3bc46cdaa..ec87b36f0d45 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2864,8 +2864,10 @@ static int mptcp_init_sock(struct sock *sk)
 	if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
 		return -ENOMEM;
 
+	rcu_read_lock();
 	ret = mptcp_init_sched(mptcp_sk(sk),
 			       mptcp_sched_find(mptcp_get_scheduler(net)));
+	rcu_read_unlock();
 	if (ret)
 		return ret;
 
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 50429cbd42da..2db38c06bede 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -904,6 +904,9 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 	    ((priv->base != NFT_PAYLOAD_TRANSPORT_HEADER &&
 	      priv->base != NFT_PAYLOAD_INNER_HEADER) ||
 	     skb->ip_summed != CHECKSUM_PARTIAL)) {
+		if (offset + priv->len > skb->len)
+			goto err;
+
 		fsum = skb_checksum(skb, offset, priv->len, 0);
 		tsum = csum_partial(src, priv->len, 0);
 
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index da5d929c7c85..709840612f0d 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1269,7 +1269,7 @@ struct xt_table *xt_find_table_lock(struct net *net, u_int8_t af,
 
 	/* and once again: */
 	list_for_each_entry(t, &xt_net->tables[af], list)
-		if (strcmp(t->name, name) == 0)
+		if (strcmp(t->name, name) == 0 && owner == t->me)
 			return t;
 
 	module_put(owner);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 17d97bbe890f..bbc778c233c8 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1518,6 +1518,7 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
 	return 0;
 
 err_dev_insert:
+	tcf_block_offload_unbind(block, q, ei);
 err_block_offload_bind:
 	tcf_chain0_head_change_cb_del(block, ei);
 err_chain0_head_change_cb_add:
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 2eefa4783879..a1d27bc039a3 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -791,7 +791,7 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 	drops = max_t(int, n, 0);
 	rcu_read_lock();
 	while ((parentid = sch->parent)) {
-		if (TC_H_MAJ(parentid) == TC_H_MAJ(TC_H_INGRESS))
+		if (parentid == TC_H_ROOT)
 			break;
 
 		if (sch->flags & TCQ_F_NOPARENT)
diff --git a/net/sunrpc/xprtrdma/ib_client.c b/net/sunrpc/xprtrdma/ib_client.c
index 8507cd4d8921..28c68b5f6823 100644
--- a/net/sunrpc/xprtrdma/ib_client.c
+++ b/net/sunrpc/xprtrdma/ib_client.c
@@ -153,6 +153,7 @@ static void rpcrdma_remove_one(struct ib_device *device,
 	}
 
 	trace_rpcrdma_client_remove_one_done(device);
+	xa_destroy(&rd->rd_xa);
 	kfree(rd);
 }
 
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 4d5d351bd0b5..c9ebf9449fcc 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1236,6 +1236,7 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 	/* deleted from the list, so can't be found from nl80211 any more */
 	cqm_config = rcu_access_pointer(wdev->cqm_config);
 	kfree_rcu(cqm_config, rcu_head);
+	RCU_INIT_POINTER(wdev->cqm_config, NULL);
 
 	/*
 	 * Ensure that all events have been processed and
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 851018eef885..c8199ee079ef 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -51,18 +51,9 @@ impl Device {
     ///
     /// It must also be ensured that `bindings::device::release` can be called from any thread.
     /// While not officially documented, this should be the case for any `struct device`.
-    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
-        // SAFETY: By the safety requirements, ptr is valid.
-        // Initially increase the reference count by one to compensate for the final decrement once
-        // this newly created `ARef<Device>` instance is dropped.
-        unsafe { bindings::get_device(ptr) };
-
-        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::device`.
-        let ptr = ptr.cast::<Self>();
-
-        // SAFETY: `ptr` is valid by the safety requirements of this function. By the above call to
-        // `bindings::get_device` we also own a reference to the underlying `struct device`.
-        unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr)) }
+    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
+        // SAFETY: By the safety requirements ptr is valid
+        unsafe { Self::as_ref(ptr) }.into()
     }
 
     /// Obtain the raw `struct device *`.
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index dee5b4b18aec..13a374a5cdb7 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -44,7 +44,7 @@ fn request_nowarn() -> Self {
 ///
 /// # fn no_run() -> Result<(), Error> {
 /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
-/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
+/// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
 ///
 /// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
 /// let blob = fw.data();
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2583081c0a3a..660fd984a928 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7507,6 +7507,7 @@ enum {
 	ALC286_FIXUP_SONY_MIC_NO_PRESENCE,
 	ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT,
 	ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+	ALC269_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
 	ALC269_FIXUP_DELL2_MIC_NO_PRESENCE,
 	ALC269_FIXUP_DELL3_MIC_NO_PRESENCE,
 	ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
@@ -7541,6 +7542,7 @@ enum {
 	ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
 	ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+	ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
 	ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
 	ALC255_FIXUP_HEADSET_MODE,
 	ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,
@@ -8102,6 +8104,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE
 	},
+	[ALC269_FIXUP_DELL1_LIMIT_INT_MIC_BOOST] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_limit_int_mic_boost,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE
+	},
 	[ALC269_FIXUP_DELL2_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -8382,6 +8390,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_HEADSET_MODE
 	},
+	[ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_limit_int_mic_boost,
+		.chained = true,
+		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
+	},
 	[ALC255_FIXUP_DELL2_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -10715,6 +10729,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x1404, "Clevo N150CU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x14a1, "Clevo L141MU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x2624, "Clevo L240TU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x28c1, "Clevo V370VND", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1558, 0x4018, "Clevo NV40M[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x4019, "Clevo NV40MZ", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x4020, "Clevo NV40MB", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
@@ -10956,6 +10971,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d05, 0x115c, "TongFang GMxTGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x121b, "TongFang GMxAGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x1387, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d05, 0x1409, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d17, 0x3288, "Haier Boyue G42", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
@@ -11050,6 +11066,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC269_FIXUP_DELL2_MIC_NO_PRESENCE, .name = "dell-headset-dock"},
 	{.id = ALC269_FIXUP_DELL3_MIC_NO_PRESENCE, .name = "dell-headset3"},
 	{.id = ALC269_FIXUP_DELL4_MIC_NO_PRESENCE, .name = "dell-headset4"},
+	{.id = ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_QUIET, .name = "dell-headset4-quiet"},
 	{.id = ALC283_FIXUP_CHROME_BOOK, .name = "alc283-dac-wcaps"},
 	{.id = ALC283_FIXUP_SENSE_COMBO_JACK, .name = "alc283-sense-combo"},
 	{.id = ALC292_FIXUP_TPT440_DOCK, .name = "tpt440-dock"},
@@ -11604,16 +11621,16 @@ static const struct snd_hda_pin_quirk alc269_fallback_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1b, 0x40000000}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_QUIET,
 		{0x19, 0x40000000},
 		{0x1b, 0x40000000}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),
-	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),
-	SND_HDA_PIN_QUIRK(0x10ec0274, 0x1028, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
+	SND_HDA_PIN_QUIRK(0x10ec0274, 0x1028, "Dell", ALC269_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC2XX_FIXUP_HEADSET_MIC,
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index e4827b8c2bde..6e51954bdb1e 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -747,8 +747,10 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 
 	cs42l51->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						      GPIOD_OUT_LOW);
-	if (IS_ERR(cs42l51->reset_gpio))
-		return PTR_ERR(cs42l51->reset_gpio);
+	if (IS_ERR(cs42l51->reset_gpio)) {
+		ret = PTR_ERR(cs42l51->reset_gpio);
+		goto error;
+	}
 
 	if (cs42l51->reset_gpio) {
 		dev_dbg(dev, "Release reset gpio\n");
@@ -780,6 +782,7 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 	return 0;
 
 error:
+	gpiod_set_value_cansleep(cs42l51->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(cs42l51->supplies),
 			       cs42l51->supplies);
 	return ret;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e39df5d10b07..1647b24ca34d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1147,6 +1147,8 @@ static int dapm_widget_list_create(struct snd_soc_dapm_widget_list **list,
 	if (*list == NULL)
 		return -ENOMEM;
 
+	(*list)->num_widgets = size;
+
 	list_for_each_entry(w, widgets, work_list)
 		(*list)->widgets[i++] = w;
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 5f09f9f205ce..d1cf32837be4 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -3880,6 +3880,9 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 			break;
 		err = dell_dock_mixer_init(mixer);
 		break;
+	case USB_ID(0x0bda, 0x402e): /* Dell WD19 dock */
+		err = dell_dock_mixer_create(mixer);
+		break;
 
 	case USB_ID(0x2a39, 0x3fd2): /* RME ADI-2 Pro */
 	case USB_ID(0x2a39, 0x3fd3): /* RME ADI-2 DAC */
diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
index 8d5595b6c59f..2a4ca4dd2da8 100644
--- a/tools/mm/page-types.c
+++ b/tools/mm/page-types.c
@@ -22,6 +22,7 @@
 #include <time.h>
 #include <setjmp.h>
 #include <signal.h>
+#include <inttypes.h>
 #include <sys/types.h>
 #include <sys/errno.h>
 #include <sys/fcntl.h>
@@ -392,9 +393,9 @@ static void show_page_range(unsigned long voffset, unsigned long offset,
 		if (opt_file)
 			printf("%lx\t", voff);
 		if (opt_list_cgroup)
-			printf("@%llu\t", (unsigned long long)cgroup0);
+			printf("@%" PRIu64 "\t", cgroup0);
 		if (opt_list_mapcnt)
-			printf("%lu\t", mapcnt0);
+			printf("%" PRIu64 "\t", mapcnt0);
 		printf("%lx\t%lx\t%s\n",
 				index, count, page_flag_name(flags0));
 	}
@@ -420,9 +421,9 @@ static void show_page(unsigned long voffset, unsigned long offset,
 	if (opt_file)
 		printf("%lx\t", voffset);
 	if (opt_list_cgroup)
-		printf("@%llu\t", (unsigned long long)cgroup);
+		printf("@%" PRIu64 "\t", cgroup)
 	if (opt_list_mapcnt)
-		printf("%lu\t", mapcnt);
+		printf("%" PRIu64 "\t", mapcnt);
 
 	printf("%lx\t%s\n", offset, page_flag_name(flags));
 }
diff --git a/tools/mm/slabinfo.c b/tools/mm/slabinfo.c
index cfaeaea71042..04e9e6ba86ea 100644
--- a/tools/mm/slabinfo.c
+++ b/tools/mm/slabinfo.c
@@ -1297,7 +1297,9 @@ static void read_slab_dir(void)
 			slab->cpu_partial_free = get_obj("cpu_partial_free");
 			slab->alloc_node_mismatch = get_obj("alloc_node_mismatch");
 			slab->deactivate_bypass = get_obj("deactivate_bypass");
-			chdir("..");
+			if (chdir(".."))
+				fatal("Unable to chdir from slab ../%s\n",
+				      slab->name);
 			if (slab->name[0] == ':')
 				alias_targets++;
 			slab++;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 31a223eaf8e6..ee3d43a7ba45 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -19,6 +19,7 @@
 #include "util/bpf-filter.h"
 #include "util/env.h"
 #include "util/kvm-stat.h"
+#include "util/stat.h"
 #include "util/kwork.h"
 #include "util/sample.h"
 #include "util/lock-contention.h"
@@ -1355,6 +1356,7 @@ PyMODINIT_FUNC PyInit_perf(void)
 
 unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
 
+#ifdef HAVE_KVM_STAT_SUPPORT
 bool kvm_entry_event(struct evsel *evsel __maybe_unused)
 {
 	return false;
@@ -1384,6 +1386,7 @@ void exit_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
 			   char *decode __maybe_unused)
 {
 }
+#endif // HAVE_KVM_STAT_SUPPORT
 
 int find_scripts(char **scripts_array  __maybe_unused, char **scripts_path_array  __maybe_unused,
 		int num  __maybe_unused, int pathlen __maybe_unused)
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 0dd26b991b3f..351da249f1cc 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -42,6 +42,11 @@ static const char *const *syscalltbl_native = syscalltbl_mips_n64;
 #include <asm/syscalls.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_loongarch;
+#else
+const int syscalltbl_native_max_id = 0;
+static const char *const syscalltbl_native[] = {
+	[0] = "unknown",
+};
 #endif
 
 struct syscall {
@@ -178,6 +183,11 @@ int syscalltbl__id(struct syscalltbl *tbl, const char *name)
 	return audit_name_to_syscall(name, tbl->audit_machine);
 }
 
+int syscalltbl__id_at_idx(struct syscalltbl *tbl __maybe_unused, int idx)
+{
+	return idx;
+}
+
 int syscalltbl__strglobmatch_next(struct syscalltbl *tbl __maybe_unused,
 				  const char *syscall_glob __maybe_unused, int *idx __maybe_unused)
 {
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 90d5afd52dd0..c5bbd89b3192 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -693,26 +693,22 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
 	return 0;
 }
 
-static int mock_decoder_reset(struct cxl_decoder *cxld)
+static void mock_decoder_reset(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	int id = cxld->id;
 
 	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
-		return 0;
+		return;
 
 	dev_dbg(&port->dev, "%s reset\n", dev_name(&cxld->dev));
-	if (port->commit_end != id) {
+	if (port->commit_end == id)
+		cxl_port_commit_reap(cxld);
+	else
 		dev_dbg(&port->dev,
 			"%s: out of order reset, expected decoder%d.%d\n",
 			dev_name(&cxld->dev), port->id, port->commit_end);
-		return -EBUSY;
-	}
-
-	port->commit_end--;
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
-
-	return 0;
 }
 
 static void default_mock_decoder(struct cxl_decoder *cxld)
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 852e7281026e..717539eddf98 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -18,7 +18,7 @@ bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
 uffd_test_case_ops_t *uffd_test_case_ops;
-pthread_barrier_t ready_for_fork;
+atomic_bool ready_for_fork;
 
 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -519,8 +519,7 @@ void *uffd_poll_thread(void *arg)
 	pollfd[1].fd = pipefd[cpu*2];
 	pollfd[1].events = POLLIN;
 
-	/* Ready for parent thread to fork */
-	pthread_barrier_wait(&ready_for_fork);
+	ready_for_fork = true;
 
 	for (;;) {
 		ret = poll(pollfd, 2, -1);
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 3e6228d8e0dc..a70ae10b5f62 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -33,6 +33,7 @@
 #include <inttypes.h>
 #include <stdint.h>
 #include <sys/random.h>
+#include <stdatomic.h>
 
 #include "../kselftest.h"
 #include "vm_util.h"
@@ -104,7 +105,7 @@ extern bool map_shared;
 extern bool test_uffdio_wp;
 extern unsigned long long *count_verify;
 extern volatile bool test_uffdio_copy_eexist;
-extern pthread_barrier_t ready_for_fork;
+extern atomic_bool ready_for_fork;
 
 extern uffd_test_ops_t anon_uffd_test_ops;
 extern uffd_test_ops_t shmem_uffd_test_ops;
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index c8a3b1c7edff..b3d21eed203d 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -241,9 +241,6 @@ static void *fork_event_consumer(void *data)
 	fork_event_args *args = data;
 	struct uffd_msg msg = { 0 };
 
-	/* Ready for parent thread to fork */
-	pthread_barrier_wait(&ready_for_fork);
-
 	/* Read until a full msg received */
 	while (uffd_read_msg(args->parent_uffd, &msg));
 
@@ -311,12 +308,8 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 
 	/* Prepare a thread to resolve EVENT_FORK */
 	if (with_event) {
-		pthread_barrier_init(&ready_for_fork, NULL, 2);
 		if (pthread_create(&thread, NULL, fork_event_consumer, &args))
 			err("pthread_create()");
-		/* Wait for child thread to start before forking */
-		pthread_barrier_wait(&ready_for_fork);
-		pthread_barrier_destroy(&ready_for_fork);
 	}
 
 	child = fork();
@@ -781,7 +774,7 @@ static void uffd_sigbus_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };
 
-	pthread_barrier_init(&ready_for_fork, NULL, 2);
+	ready_for_fork = false;
 
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
@@ -798,9 +791,8 @@ static void uffd_sigbus_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
-	/* Wait for child thread to start before forking */
-	pthread_barrier_wait(&ready_for_fork);
-	pthread_barrier_destroy(&ready_for_fork);
+	while (!ready_for_fork)
+		; /* Wait for the poll_thread to start executing before forking */
 
 	pid = fork();
 	if (pid < 0)
@@ -841,7 +833,7 @@ static void uffd_events_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };
 
-	pthread_barrier_init(&ready_for_fork, NULL, 2);
+	ready_for_fork = false;
 
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 	if (uffd_register(uffd, area_dst, nr_pages * page_size,
@@ -852,9 +844,8 @@ static void uffd_events_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
-	/* Wait for child thread to start before forking */
-	pthread_barrier_wait(&ready_for_fork);
-	pthread_barrier_destroy(&ready_for_fork);
+	while (!ready_for_fork)
+		; /* Wait for the poll_thread to start executing before forking */
 
 	pid = fork();
 	if (pid < 0)
diff --git a/tools/usb/usbip/src/usbip_detach.c b/tools/usb/usbip/src/usbip_detach.c
index b29101986b5a..6b78d4a81e95 100644
--- a/tools/usb/usbip/src/usbip_detach.c
+++ b/tools/usb/usbip/src/usbip_detach.c
@@ -68,6 +68,7 @@ static int detach_port(char *port)
 	}
 
 	if (!found) {
+		ret = -1;
 		err("Invalid port %s > maxports %d",
 			port, vhci_driver->nports);
 		goto call_driver_close;

