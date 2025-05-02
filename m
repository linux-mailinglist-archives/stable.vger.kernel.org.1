Return-Path: <stable+bounces-139444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F57AA6A85
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 08:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19C23BF9E5
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 06:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A881F2BA7;
	Fri,  2 May 2025 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lXMuLVOb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE1A1F2365;
	Fri,  2 May 2025 06:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166090; cv=none; b=mi0TAzj1pY3Ps8sgTrd5OCfG8GwhmWzzeawT3AcvGMhO1+bESS22Npphk6fXCqc6+rP0B5FwEIXm03v1891XsMyR4a1SGWRN66QNXNYRdetS5cSIr7O2C78TcDdAU+ocWJGY3H7cgUT2tWWEJyAwK3h7kLbK2RuJfCeDZmtOasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166090; c=relaxed/simple;
	bh=bP9BOW6NXLH2uE7d7n9Vj0efv1mJg3HD1Bkom/WN7iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0uKh2+Hqw4rIT5wcAcC178ZtiwXBbzUFhE9BYHSXWeuFHh8ZxRQUyliT5Z/S+Z+fW+/5WeuRH1wDHHIPXUN0o/1/KxVQ6S3JCzszsZHvM1hMqKy+3b/8UXfe3QFWeFzEKTmYY0PHKR84bhtPpmK2oOWjlhtbUczJRCR0f/i/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lXMuLVOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE28C4CEF0;
	Fri,  2 May 2025 06:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746166090;
	bh=bP9BOW6NXLH2uE7d7n9Vj0efv1mJg3HD1Bkom/WN7iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXMuLVOb79vCmf77tgsxMLaUdqdRUyQDyo/o8NEQ0qdx2IBxQpXr49+Bcrz6AhL5H
	 4K3yAi6uWZcKE/JnLcOPaw3KWl6qToobKTiCrkqcyoedTjl4feuD/dvpFkNL4q3UvL
	 EaT+rWzRYYK7Qq95ymMok7IVFRMfHo3YLPuk26Tg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.26
Date: Fri,  2 May 2025 08:07:40 +0200
Message-ID: <2025050240-share-tibia-d24e@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025050240-residence-rubbed-53b7@gregkh>
References: <2025050240-residence-rubbed-53b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index de27e1620821..0acb4c9b8d90 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -382,6 +382,14 @@ In case of new BPF instructions, once the changes have been accepted
 into the Linux kernel, please implement support into LLVM's BPF back
 end. See LLVM_ section below for further information.
 
+Q: What "BPF_INTERNAL" symbol namespace is for?
+-----------------------------------------------
+A: Symbols exported as BPF_INTERNAL can only be used by BPF infrastructure
+like preload kernel modules with light skeleton. Most symbols outside
+of BPF_INTERNAL are not expected to be used by code outside of BPF either.
+Symbols may lack the designation because they predate the namespaces,
+or due to an oversight.
+
 Stable submission
 =================
 
diff --git a/Makefile b/Makefile
index 93f4ba25a453..467d820fa23f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 25
+SUBLEVEL = 26
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 5ff49a5e9afc..f87e63b2212e 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -3,10 +3,12 @@
 menu "Accelerated Cryptographic Algorithms for CPU (arm)"
 
 config CRYPTO_CURVE25519_NEON
-	tristate "Public key crypto: Curve25519 (NEON)"
+	tristate
 	depends on KERNEL_MODE_NEON
+	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	default CRYPTO_LIB_CURVE25519_INTERNAL
 	help
 	  Curve25519 algorithm
 
@@ -45,9 +47,10 @@ config CRYPTO_NHPOLY1305_NEON
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_POLY1305_ARM
-	tristate "Hash functions: Poly1305 (NEON)"
+	tristate
 	select CRYPTO_HASH
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	default CRYPTO_LIB_POLY1305_INTERNAL
 	help
 	  Poly1305 authenticator algorithm (RFC7539)
 
@@ -212,9 +215,10 @@ config CRYPTO_AES_ARM_CE
 	  - ARMv8 Crypto Extensions
 
 config CRYPTO_CHACHA20_NEON
-	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12 (NEON)"
+	tristate
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	default CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
 	  stream cipher algorithms
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi
new file mode 100644
index 000000000000..1dceff119a47
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree Source for J784S4 and J742S2 SoC Family
+ *
+ * TRM (j784s4) (SPRUJ43 JULY 2022): https://www.ti.com/lit/zip/spruj52
+ * TRM (j742s2): https://www.ti.com/lit/pdf/spruje3
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+#include "k3-pinctrl.h"
+
+/ {
+	interrupt-parent = <&gic500>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	L2_0: l2-cache0 {
+		compatible = "cache";
+		cache-level = <2>;
+		cache-unified;
+		cache-size = <0x200000>;
+		cache-line-size = <64>;
+		cache-sets = <1024>;
+		next-level-cache = <&msmc_l3>;
+	};
+
+	L2_1: l2-cache1 {
+		compatible = "cache";
+		cache-level = <2>;
+		cache-unified;
+		cache-size = <0x200000>;
+		cache-line-size = <64>;
+		cache-sets = <1024>;
+		next-level-cache = <&msmc_l3>;
+	};
+
+	msmc_l3: l3-cache0 {
+		compatible = "cache";
+		cache-level = <3>;
+		cache-unified;
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		psci: psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	a72_timer0: timer-cl0-cpu0 {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
+	};
+
+	pmu: pmu {
+		compatible = "arm,cortex-a72-pmu";
+		/* Recommendation from GIC500 TRM Table A.3 */
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	cbass_main: bus@100000 {
+		bootph-all;
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
+			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
+			 <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
+			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
+			 <0x00 0x04210000 0x00 0x04210000 0x00 0x00010000>, /* VPU0 */
+			 <0x00 0x04220000 0x00 0x04220000 0x00 0x00010000>, /* VPU1 */
+			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIe0 Core*/
+			 <0x00 0x0d800000 0x00 0x0d800000 0x00 0x00800000>, /* PCIe1 Core*/
+			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x00800000>, /* PCIe2 Core*/
+			 <0x00 0x0e800000 0x00 0x0e800000 0x00 0x00800000>, /* PCIe3 Core*/
+			 <0x00 0x10000000 0x00 0x10000000 0x00 0x08000000>, /* PCIe0 DAT0 */
+			 <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */
+			 <0x00 0x64800000 0x00 0x64800000 0x00 0x0070c000>, /* C71_1 */
+			 <0x00 0x65800000 0x00 0x65800000 0x00 0x0070c000>, /* C71_2 */
+			 <0x00 0x66800000 0x00 0x66800000 0x00 0x0070c000>, /* C71_3 */
+			 <0x00 0x67800000 0x00 0x67800000 0x00 0x0070c000>, /* C71_4 */
+			 <0x00 0x6f000000 0x00 0x6f000000 0x00 0x00310000>, /* A72 PERIPHBASE */
+			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00400000>, /* MSMC RAM */
+			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
+			 <0x40 0x00000000 0x40 0x00000000 0x01 0x00000000>, /* PCIe0 DAT1 */
+			 <0x41 0x00000000 0x41 0x00000000 0x01 0x00000000>, /* PCIe1 DAT1 */
+			 <0x42 0x00000000 0x42 0x00000000 0x01 0x00000000>, /* PCIe2 DAT1 */
+			 <0x43 0x00000000 0x43 0x00000000 0x01 0x00000000>, /* PCIe3 DAT1 */
+			 <0x44 0x00000000 0x44 0x00000000 0x00 0x08000000>, /* PCIe2 DAT0 */
+			 <0x44 0x10000000 0x44 0x10000000 0x00 0x08000000>, /* PCIe3 DAT0 */
+			 <0x4e 0x20000000 0x4e 0x20000000 0x00 0x00080000>, /* GPU */
+
+			 /* MCUSS_WKUP Range */
+			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
+			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>,
+			 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>,
+			 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>,
+			 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>,
+			 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>,
+			 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>,
+			 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
+			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
+			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
+			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
+			 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>;
+
+		cbass_mcu_wakeup: bus@28380000 {
+			bootph-all;
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>, /* MCU NAVSS*/
+				 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>, /* First peripheral window */
+				 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>, /* CTRL_MMR0 */
+				 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>, /* MCU R5F Core0 */
+				 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>, /* MCU R5F Core1 */
+				 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>, /* MCU SRAM */
+				 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>, /* WKUP peripheral window */
+				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
+				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
+				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI register space */
+				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS data region 1 */
+				 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS data region 0/3 */
+		};
+	};
+
+	thermal_zones: thermal-zones {
+		#include "k3-j784s4-j742s2-thermal-common.dtsi"
+	};
+};
+
+/* Now include peripherals from each bus segment */
+#include "k3-j784s4-j742s2-main-common.dtsi"
+#include "k3-j784s4-j742s2-mcu-wakeup-common.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
new file mode 100644
index 000000000000..2bf4547485e1
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -0,0 +1,2673 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree Source for J784S4 and J742S2 SoC Family Main Domain peripherals
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <dt-bindings/mux/mux.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-ti.h>
+
+#include "k3-serdes.h"
+
+/ {
+	serdes_refclk: clock-serdes {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		/* To be enabled when serdes_wiz* is functional */
+		status = "disabled";
+	};
+};
+
+&cbass_main {
+	/*
+	 * MSMC is configured by bootloaders and a runtime fixup is done in the
+	 * DT for this node
+	 */
+	msmc_ram: sram@70000000 {
+		compatible = "mmio-sram";
+		reg = <0x00 0x70000000 0x00 0x800000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x70000000 0x800000>;
+
+		atf-sram@0 {
+			reg = <0x00 0x20000>;
+		};
+
+		tifs-sram@1f0000 {
+			reg = <0x1f0000 0x10000>;
+		};
+
+		l3cache-sram@200000 {
+			reg = <0x200000 0x200000>;
+		};
+	};
+
+	scm_conf: bus@100000 {
+		compatible = "simple-bus";
+		reg = <0x00 0x00100000 0x00 0x1c000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x00100000 0x1c000>;
+
+		cpsw1_phy_gmii_sel: phy@4034 {
+			compatible = "ti,am654-phy-gmii-sel";
+			reg = <0x4034 0x4>;
+			#phy-cells = <1>;
+		};
+
+		cpsw0_phy_gmii_sel: phy@4044 {
+			compatible = "ti,j784s4-cpsw9g-phy-gmii-sel";
+			reg = <0x4044 0x20>;
+			#phy-cells = <1>;
+			ti,qsgmii-main-ports = <7>, <7>;
+		};
+
+		pcie0_ctrl: pcie0-ctrl@4070 {
+			compatible = "ti,j784s4-pcie-ctrl", "syscon";
+			reg = <0x4070 0x4>;
+		};
+
+		pcie1_ctrl: pcie1-ctrl@4074 {
+			compatible = "ti,j784s4-pcie-ctrl", "syscon";
+			reg = <0x4074 0x4>;
+		};
+
+		serdes_ln_ctrl: mux-controller@4080 {
+			compatible = "reg-mux";
+			reg = <0x00004080 0x30>;
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
+					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */
+					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
+					<0x18 0x3>, <0x1c 0x3>, /* SERDES1 lane2/3 select */
+					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
+					<0x28 0x3>, <0x2c 0x3>, /* SERDES2 lane2/3 select */
+					<0x40 0x3>, <0x44 0x3>, /* SERDES4 lane0/1 select */
+					<0x48 0x3>, <0x4c 0x3>; /* SERDES4 lane2/3 select */
+			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
+				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
+				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,
+				      <J784S4_SERDES0_LANE3_USB>,
+				      <J784S4_SERDES1_LANE0_PCIE0_LANE0>,
+				      <J784S4_SERDES1_LANE1_PCIE0_LANE1>,
+				      <J784S4_SERDES1_LANE2_PCIE0_LANE2>,
+				      <J784S4_SERDES1_LANE3_PCIE0_LANE3>,
+				      <J784S4_SERDES2_LANE0_IP2_UNUSED>,
+				      <J784S4_SERDES2_LANE1_IP2_UNUSED>,
+				      <J784S4_SERDES2_LANE2_QSGMII_LANE1>,
+				      <J784S4_SERDES2_LANE3_QSGMII_LANE2>,
+				      <J784S4_SERDES4_LANE0_EDP_LANE0>,
+				      <J784S4_SERDES4_LANE1_EDP_LANE1>,
+				      <J784S4_SERDES4_LANE2_EDP_LANE2>,
+				      <J784S4_SERDES4_LANE3_EDP_LANE3>;
+		};
+
+		usb_serdes_mux: mux-controller@4000 {
+			compatible = "reg-mux";
+			reg = <0x4000 0x4>;
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 3 mux */
+		};
+
+		ehrpwm_tbclk: clock-controller@4140 {
+			compatible = "ti,am654-ehrpwm-tbclk";
+			reg = <0x4140 0x18>;
+			#clock-cells = <1>;
+		};
+
+		audio_refclk1: clock@82e4 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e4 0x4>;
+			clocks = <&k3_clks 157 34>;
+			assigned-clocks = <&k3_clks 157 34>;
+			assigned-clock-parents = <&k3_clks 157 63>;
+			#clock-cells = <0>;
+		};
+	};
+
+	main_ehrpwm0: pwm@3000000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		reg = <0x00 0x3000000 0x00 0x100>;
+		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 219 0>;
+		clock-names = "tbclk", "fck";
+		power-domains = <&k3_pds 219 TI_SCI_PD_EXCLUSIVE>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	main_ehrpwm1: pwm@3010000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		reg = <0x00 0x3010000 0x00 0x100>;
+		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 220 0>;
+		clock-names = "tbclk", "fck";
+		power-domains = <&k3_pds 220 TI_SCI_PD_EXCLUSIVE>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	main_ehrpwm2: pwm@3020000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		reg = <0x00 0x3020000 0x00 0x100>;
+		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 221 0>;
+		clock-names = "tbclk", "fck";
+		power-domains = <&k3_pds 221 TI_SCI_PD_EXCLUSIVE>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	main_ehrpwm3: pwm@3030000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		reg = <0x00 0x3030000 0x00 0x100>;
+		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 222 0>;
+		clock-names = "tbclk", "fck";
+		power-domains = <&k3_pds 222 TI_SCI_PD_EXCLUSIVE>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	main_ehrpwm4: pwm@3040000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		reg = <0x00 0x3040000 0x00 0x100>;
+		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 223 0>;
+		clock-names = "tbclk", "fck";
+		power-domains = <&k3_pds 223 TI_SCI_PD_EXCLUSIVE>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	main_ehrpwm5: pwm@3050000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		reg = <0x00 0x3050000 0x00 0x100>;
+		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 224 0>;
+		clock-names = "tbclk", "fck";
+		power-domains = <&k3_pds 224 TI_SCI_PD_EXCLUSIVE>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	gic500: interrupt-controller@1800000 {
+		compatible = "arm,gic-v3";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x00 0x01800000 0x00 0x10000>, /* GICD */
+		      <0x00 0x01900000 0x00 0x100000>, /* GICR */
+		      <0x00 0x6f000000 0x00 0x2000>,   /* GICC */
+		      <0x00 0x6f010000 0x00 0x1000>,   /* GICH */
+		      <0x00 0x6f020000 0x00 0x2000>;   /* GICV */
+
+		/* vcpumntirq: virtual CPU interface maintenance interrupt */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		gic_its: msi-controller@1820000 {
+			compatible = "arm,gic-v3-its";
+			reg = <0x00 0x01820000 0x00 0x10000>;
+			socionext,synquacer-pre-its = <0x1000000 0x400000>;
+			msi-controller;
+			#msi-cells = <1>;
+		};
+	};
+
+	main_gpio_intr: interrupt-controller@a00000 {
+		compatible = "ti,sci-intr";
+		reg = <0x00 0x00a00000 0x00 0x800>;
+		ti,intr-trigger-type = <1>;
+		interrupt-controller;
+		interrupt-parent = <&gic500>;
+		#interrupt-cells = <1>;
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <10>;
+		ti,interrupt-ranges = <8 392 56>;
+	};
+
+	main_pmx0: pinctrl@11c000 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x11c000 0x00 0x120>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	/* TIMERIO pad input CTRLMMR_TIMER*_CTRL registers */
+	main_timerio_input: pinctrl@104200 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x104200 0x00 0x50>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x00000007>;
+	};
+
+	/* TIMERIO pad output CTCTRLMMR_TIMERIO*_CTRL registers */
+	main_timerio_output: pinctrl@104280 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x104280 0x00 0x20>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000001f>;
+	};
+
+	main_crypto: crypto@4e00000 {
+		compatible = "ti,j721e-sa2ul";
+		reg = <0x00 0x4e00000 0x00 0x1200>;
+		power-domains = <&k3_pds 369 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x04e00000 0x00 0x04e00000 0x00 0x30000>;
+
+		dmas = <&main_udmap 0xca40>, <&main_udmap 0x4a40>,
+				<&main_udmap 0x4a41>;
+		dma-names = "tx", "rx1", "rx2";
+
+		rng: rng@4e10000 {
+			compatible = "inside-secure,safexcel-eip76";
+			reg = <0x00 0x4e10000 0x00 0x7d>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	main_timer0: timer@2400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2400000 0x00 0x400>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 97 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 97 2>;
+		assigned-clock-parents = <&k3_clks 97 3>;
+		power-domains = <&k3_pds 97 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer1: timer@2410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2410000 0x00 0x400>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 98 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 98 2>;
+		assigned-clock-parents = <&k3_clks 98 3>;
+		power-domains = <&k3_pds 98 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer2: timer@2420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2420000 0x00 0x400>;
+		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 99 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 99 2>;
+		assigned-clock-parents = <&k3_clks 99 3>;
+		power-domains = <&k3_pds 99 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer3: timer@2430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2430000 0x00 0x400>;
+		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 100 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 100 2>;
+		assigned-clock-parents = <&k3_clks 100 3>;
+		power-domains = <&k3_pds 100 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer4: timer@2440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2440000 0x00 0x400>;
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 101 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 101 2>;
+		assigned-clock-parents = <&k3_clks 101 3>;
+		power-domains = <&k3_pds 101 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer5: timer@2450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2450000 0x00 0x400>;
+		interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 102 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 102 2>;
+		assigned-clock-parents = <&k3_clks 102 3>;
+		power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer6: timer@2460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2460000 0x00 0x400>;
+		interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 103 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 103 2>;
+		assigned-clock-parents = <&k3_clks 103 3>;
+		power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer7: timer@2470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2470000 0x00 0x400>;
+		interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 104 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 104 2>;
+		assigned-clock-parents = <&k3_clks 104 3>;
+		power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer8: timer@2480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2480000 0x00 0x400>;
+		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 105 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 105 2>;
+		assigned-clock-parents = <&k3_clks 105 3>;
+		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer9: timer@2490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2490000 0x00 0x400>;
+		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 106 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 106 2>;
+		assigned-clock-parents = <&k3_clks 106 3>;
+		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer10: timer@24a0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24a0000 0x00 0x400>;
+		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 107 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 107 2>;
+		assigned-clock-parents = <&k3_clks 107 3>;
+		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer11: timer@24b0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24b0000 0x00 0x400>;
+		interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 108 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 108 2>;
+		assigned-clock-parents = <&k3_clks 108 3>;
+		power-domains = <&k3_pds 108 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer12: timer@24c0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24c0000 0x00 0x400>;
+		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 109 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 109 2>;
+		assigned-clock-parents = <&k3_clks 109 3>;
+		power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer13: timer@24d0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24d0000 0x00 0x400>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 110 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 110 2>;
+		assigned-clock-parents = <&k3_clks 110 3>;
+		power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer14: timer@24e0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24e0000 0x00 0x400>;
+		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 111 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 111 2>;
+		assigned-clock-parents = <&k3_clks 111 3>;
+		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer15: timer@24f0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24f0000 0x00 0x400>;
+		interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 112 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 112 2>;
+		assigned-clock-parents = <&k3_clks 112 3>;
+		power-domains = <&k3_pds 112 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer16: timer@2500000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2500000 0x00 0x400>;
+		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 113 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 113 2>;
+		assigned-clock-parents = <&k3_clks 113 3>;
+		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer17: timer@2510000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2510000 0x00 0x400>;
+		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 114 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 114 2>;
+		assigned-clock-parents = <&k3_clks 114 3>;
+		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer18: timer@2520000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2520000 0x00 0x400>;
+		interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 115 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 115 2>;
+		assigned-clock-parents = <&k3_clks 115 3>;
+		power-domains = <&k3_pds 115 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer19: timer@2530000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2530000 0x00 0x400>;
+		interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 116 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 116 2>;
+		assigned-clock-parents = <&k3_clks 116 3>;
+		power-domains = <&k3_pds 116 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_uart0: serial@2800000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02800000 0x00 0x200>;
+		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 146 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart1: serial@2810000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02810000 0x00 0x200>;
+		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 388 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 388 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart2: serial@2820000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02820000 0x00 0x200>;
+		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 389 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 389 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart3: serial@2830000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02830000 0x00 0x200>;
+		interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 390 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 390 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart4: serial@2840000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02840000 0x00 0x200>;
+		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 391 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 391 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart5: serial@2850000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02850000 0x00 0x200>;
+		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 392 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 392 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart6: serial@2860000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02860000 0x00 0x200>;
+		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 393 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 393 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart7: serial@2870000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02870000 0x00 0x200>;
+		interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 394 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 394 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart8: serial@2880000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02880000 0x00 0x200>;
+		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 395 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 395 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart9: serial@2890000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02890000 0x00 0x200>;
+		interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 396 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 396 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_gpio0: gpio@600000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00600000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <145>, <146>, <147>, <148>, <149>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <66>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 163 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 163 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	main_gpio2: gpio@610000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00610000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <154>, <155>, <156>, <157>, <158>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <66>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 164 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 164 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	main_gpio4: gpio@620000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00620000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <163>, <164>, <165>, <166>, <167>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <66>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 165 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 165 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	main_gpio6: gpio@630000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00630000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <172>, <173>, <174>, <175>, <176>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <66>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 166 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	usbss0: usb@4104000 {
+		bootph-all;
+		compatible = "ti,j721e-usb";
+		reg = <0x00 0x4104000 0x00 0x100>;
+		dma-coherent;
+		power-domains = <&k3_pds 398 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 398 21>, <&k3_clks 398 2>;
+		clock-names = "ref", "lpm";
+		assigned-clocks = <&k3_clks 398 21>;    /* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 398 22>; /* HFOSC0 */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		status = "disabled"; /* Needs lane config */
+
+		usb0: usb@6000000 {
+			bootph-all;
+			compatible = "cdns,usb3";
+			reg = <0x00 0x6000000 0x00 0x10000>,
+			      <0x00 0x6010000 0x00 0x10000>,
+			      <0x00 0x6020000 0x00 0x10000>;
+			reg-names = "otg", "xhci", "dev";
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,  /* irq.0 */
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>, /* irq.6 */
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>; /* otgirq.0 */
+			interrupt-names = "host",
+					  "peripheral",
+					  "otg";
+		};
+	};
+
+	main_i2c0: i2c@2000000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02000000 0x00 0x100>;
+		interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 270 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 270 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_i2c1: i2c@2010000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02010000 0x00 0x100>;
+		interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 271 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 271 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_i2c2: i2c@2020000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02020000 0x00 0x100>;
+		interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 272 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 272 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_i2c3: i2c@2030000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02030000 0x00 0x100>;
+		interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 273 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 273 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_i2c4: i2c@2040000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02040000 0x00 0x100>;
+		interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 274 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 274 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_i2c5: i2c@2050000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02050000 0x00 0x100>;
+		interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 275 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 275 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_i2c6: i2c@2060000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02060000 0x00 0x100>;
+		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 276 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	ti_csi2rx0: ticsi2rx@4500000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		reg = <0x00 0x04500000 0x00 0x00001000>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dmas = <&main_bcdma_csi 0 0x4940 0>;
+		dma-names = "rx0";
+		power-domains = <&k3_pds 72 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		cdns_csi2rx0: csi-bridge@4504000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x04504000 0x00 0x00001000>;
+			clocks = <&k3_clks 72 2>, <&k3_clks 72 0>, <&k3_clks 72 2>,
+				<&k3_clks 72 2>, <&k3_clks 72 3>, <&k3_clks 72 3>;
+			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+			phys = <&dphy0>;
+			phy-names = "dphy";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				csi0_port0: port@0 {
+					reg = <0>;
+					status = "disabled";
+				};
+
+				csi0_port1: port@1 {
+					reg = <1>;
+					status = "disabled";
+				};
+
+				csi0_port2: port@2 {
+					reg = <2>;
+					status = "disabled";
+				};
+
+				csi0_port3: port@3 {
+					reg = <3>;
+					status = "disabled";
+				};
+
+				csi0_port4: port@4 {
+					reg = <4>;
+					status = "disabled";
+				};
+			};
+		};
+	};
+
+	ti_csi2rx1: ticsi2rx@4510000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		reg = <0x00 0x04510000 0x00 0x1000>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dmas = <&main_bcdma_csi 0 0x4960 0>;
+		dma-names = "rx0";
+		power-domains = <&k3_pds 73 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		cdns_csi2rx1: csi-bridge@4514000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x04514000 0x00 0x00001000>;
+			clocks = <&k3_clks 73 2>, <&k3_clks 73 0>, <&k3_clks 73 2>,
+				<&k3_clks 73 2>, <&k3_clks 73 3>, <&k3_clks 73 3>;
+			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+			phys = <&dphy1>;
+			phy-names = "dphy";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				csi1_port0: port@0 {
+					reg = <0>;
+					status = "disabled";
+				};
+
+				csi1_port1: port@1 {
+					reg = <1>;
+					status = "disabled";
+				};
+
+				csi1_port2: port@2 {
+					reg = <2>;
+					status = "disabled";
+				};
+
+				csi1_port3: port@3 {
+					reg = <3>;
+					status = "disabled";
+				};
+
+				csi1_port4: port@4 {
+					reg = <4>;
+					status = "disabled";
+				};
+			};
+		};
+	};
+
+	ti_csi2rx2: ticsi2rx@4520000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		reg = <0x00 0x04520000 0x00 0x00001000>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dmas = <&main_bcdma_csi 0 0x4980 0>;
+		dma-names = "rx0";
+		power-domains = <&k3_pds 74 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		cdns_csi2rx2: csi-bridge@4524000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x04524000 0x00 0x00001000>;
+			clocks = <&k3_clks 74 2>, <&k3_clks 74 0>, <&k3_clks 74 2>,
+				<&k3_clks 74 2>, <&k3_clks 74 3>, <&k3_clks 74 3>;
+			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+			phys = <&dphy2>;
+			phy-names = "dphy";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				csi2_port0: port@0 {
+					reg = <0>;
+					status = "disabled";
+				};
+
+				csi2_port1: port@1 {
+					reg = <1>;
+					status = "disabled";
+				};
+
+				csi2_port2: port@2 {
+					reg = <2>;
+					status = "disabled";
+				};
+
+				csi2_port3: port@3 {
+					reg = <3>;
+					status = "disabled";
+				};
+
+				csi2_port4: port@4 {
+					reg = <4>;
+					status = "disabled";
+				};
+			};
+		};
+	};
+
+	dphy0: phy@4580000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x00 0x04580000 0x00 0x00001100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 212 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	dphy1: phy@4590000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x00 0x04590000 0x00 0x00001100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 213 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	dphy2: phy@45a0000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x00 0x045a0000 0x00 0x00001100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 214 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	vpu0: video-codec@4210000 {
+		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
+		reg = <0x00 0x4210000 0x00 0x10000>;
+		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 241 2>;
+		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	vpu1: video-codec@4220000 {
+		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
+		reg = <0x00 0x4220000 0x00 0x10000>;
+		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 242 2>;
+		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_sdhci0: mmc@4f80000 {
+		compatible = "ti,j721e-sdhci-8bit";
+		reg = <0x00 0x04f80000 0x00 0x1000>,
+		      <0x00 0x04f88000 0x00 0x400>;
+		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 140 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 140 1>, <&k3_clks 140 2>;
+		clock-names = "clk_ahb", "clk_xin";
+		assigned-clocks = <&k3_clks 140 2>;
+		assigned-clock-parents = <&k3_clks 140 3>;
+		bus-width = <8>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
+		ti,otap-del-sel-ddr52 = <0x6>;
+		ti,otap-del-sel-hs200 = <0x8>;
+		ti,otap-del-sel-hs400 = <0x5>;
+		ti,itap-del-sel-legacy = <0x10>;
+		ti,itap-del-sel-mmc-hs = <0xa>;
+		ti,strobe-sel = <0x77>;
+		ti,clkbuf-sel = <0x7>;
+		ti,trm-icp = <0x8>;
+		mmc-ddr-1_8v;
+		mmc-hs200-1_8v;
+		mmc-hs400-1_8v;
+		dma-coherent;
+		status = "disabled";
+	};
+
+	main_sdhci1: mmc@4fb0000 {
+		compatible = "ti,j721e-sdhci-4bit";
+		reg = <0x00 0x04fb0000 0x00 0x1000>,
+		      <0x00 0x04fb8000 0x00 0x400>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 141 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 141 3>, <&k3_clks 141 4>;
+		clock-names = "clk_ahb", "clk_xin";
+		assigned-clocks = <&k3_clks 141 4>;
+		assigned-clock-parents = <&k3_clks 141 5>;
+		bus-width = <4>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x5>;
+		ti,otap-del-sel-ddr50 = <0xc>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,itap-del-sel-ddr50 = <0x2>;
+		ti,clkbuf-sel = <0x7>;
+		ti,trm-icp = <0x8>;
+		dma-coherent;
+		status = "disabled";
+	};
+
+	pcie0_rc: pcie@2900000 {
+		compatible = "ti,j784s4-pcie-host";
+		reg = <0x00 0x02900000 0x00 0x1000>,
+		      <0x00 0x02907000 0x00 0x400>,
+		      <0x00 0x0d000000 0x00 0x00800000>,
+		      <0x00 0x10000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x0>;
+		max-link-speed = <3>;
+		num-lanes = <4>;
+		power-domains = <&k3_pds 332 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 332 0>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xff>;
+		vendor-id = <0x104c>;
+		device-id = <0xb012>;
+		msi-map = <0x0 &gic_its 0x0 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x10001000 0x0 0x10001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x10011000 0x0 0x10011000 0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		status = "disabled";
+	};
+
+	pcie1_rc: pcie@2910000 {
+		compatible = "ti,j784s4-pcie-host";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x00800000>,
+		      <0x00 0x18000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie1_ctrl 0x0>;
+		max-link-speed = <3>;
+		num-lanes = <4>;
+		power-domains = <&k3_pds 333 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 333 0>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xff>;
+		vendor-id = <0x104c>;
+		device-id = <0xb012>;
+		msi-map = <0x0 &gic_its 0x10000 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
+			 <0x02000000 0x0 0x18011000  0x00 0x18011000  0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		status = "disabled";
+	};
+
+	serdes_wiz0: wiz@5060000 {
+		compatible = "ti,j784s4-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 404 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 404 2>, <&k3_clks 404 6>, <&serdes_refclk>, <&k3_clks 404 5>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
+		assigned-clocks = <&k3_clks 404 6>;
+		assigned-clock-parents = <&k3_clks 404 10>;
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x5060000 0x00 0x5060000 0x10000>;
+		status = "disabled";
+
+		serdes0: serdes@5060000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05060000 0x010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz0 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 404 6>,
+						 <&k3_clks 404 6>,
+						 <&k3_clks 404 6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+	};
+
+	serdes_wiz1: wiz@5070000 {
+		compatible = "ti,j784s4-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 405 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 405 2>, <&k3_clks 405 6>, <&serdes_refclk>, <&k3_clks 405 5>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
+		assigned-clocks = <&k3_clks 405 6>;
+		assigned-clock-parents = <&k3_clks 405 10>;
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x05070000 0x00 0x05070000 0x10000>;
+		status = "disabled";
+
+		serdes1: serdes@5070000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05070000 0x010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz1 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz1 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz1 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz1 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 405 6>,
+						 <&k3_clks 405 6>,
+						 <&k3_clks 405 6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+	};
+
+	serdes_wiz4: wiz@5050000 {
+		compatible = "ti,j784s4-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 407 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 407 2>, <&k3_clks 407 6>, <&serdes_refclk>, <&k3_clks 407 5>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
+		assigned-clocks = <&k3_clks 407 6>;
+		assigned-clock-parents = <&k3_clks 407 10>;
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x05050000 0x00 0x05050000 0x10000>,
+			 <0xa030a00 0x00 0xa030a00 0x40>; /* DPTX PHY */
+		status = "disabled";
+
+		serdes4: serdes@5050000 {
+			/*
+			 * Note: we also map DPTX PHY registers as the Torrent
+			 * needs to manage those.
+			 */
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05050000 0x010000>,
+			      <0x0a030a00 0x40>; /* DPTX PHY */
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz4 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz4 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz4 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz4 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 407 6>,
+						 <&k3_clks 407 6>,
+						 <&k3_clks 407 6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+	};
+
+	main_navss: bus@30000000 {
+		bootph-all;
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
+		ti,sci-dev-id = <280>;
+		dma-coherent;
+		dma-ranges;
+
+		main_navss_intr: interrupt-controller@310e0000 {
+			compatible = "ti,sci-intr";
+			reg = <0x00 0x310e0000 0x00 0x4000>;
+			ti,intr-trigger-type = <4>;
+			interrupt-controller;
+			interrupt-parent = <&gic500>;
+			#interrupt-cells = <1>;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <283>;
+			ti,interrupt-ranges = <0 64 64>,
+					      <64 448 64>,
+					      <128 672 64>;
+		};
+
+		main_udmass_inta: msi-controller@33d00000 {
+			compatible = "ti,sci-inta";
+			reg = <0x00 0x33d00000 0x00 0x100000>;
+			interrupt-controller;
+			#interrupt-cells = <0>;
+			interrupt-parent = <&main_navss_intr>;
+			msi-controller;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <321>;
+			ti,interrupt-ranges = <0 0 256>;
+			ti,unmapped-event-sources = <&main_bcdma_csi>;
+		};
+
+		secure_proxy_main: mailbox@32c00000 {
+			bootph-all;
+			compatible = "ti,am654-secure-proxy";
+			#mbox-cells = <1>;
+			reg-names = "target_data", "rt", "scfg";
+			reg = <0x00 0x32c00000 0x00 0x100000>,
+			      <0x00 0x32400000 0x00 0x100000>,
+			      <0x00 0x32800000 0x00 0x100000>;
+			interrupt-names = "rx_011";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		hwspinlock: hwlock@30e00000 {
+			compatible = "ti,am654-hwspinlock";
+			reg = <0x00 0x30e00000 0x00 0x1000>;
+			#hwlock-cells = <1>;
+		};
+
+		mailbox0_cluster0: mailbox@31f80000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f80000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster1: mailbox@31f81000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f81000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster2: mailbox@31f82000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f82000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster3: mailbox@31f83000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f83000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster4: mailbox@31f84000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f84000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster5: mailbox@31f85000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f85000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster6: mailbox@31f86000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f86000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster7: mailbox@31f87000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f87000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster8: mailbox@31f88000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f88000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster9: mailbox@31f89000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f89000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster10: mailbox@31f8a000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f8a000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster11: mailbox@31f8b000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f8b000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster0: mailbox@31f90000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f90000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster1: mailbox@31f91000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f91000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster2: mailbox@31f92000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f92000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster3: mailbox@31f93000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f93000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster4: mailbox@31f94000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f94000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster5: mailbox@31f95000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f95000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster6: mailbox@31f96000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f96000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster7: mailbox@31f97000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f97000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster8: mailbox@31f98000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f98000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster9: mailbox@31f99000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f99000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster10: mailbox@31f9a000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f9a000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster11: mailbox@31f9b000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f9b000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		main_ringacc: ringacc@3c000000 {
+			compatible = "ti,am654-navss-ringacc";
+			reg = <0x00 0x3c000000 0x00 0x400000>,
+			      <0x00 0x38000000 0x00 0x400000>,
+			      <0x00 0x31120000 0x00 0x100>,
+			      <0x00 0x33000000 0x00 0x40000>,
+			      <0x00 0x31080000 0x00 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
+			ti,num-rings = <1024>;
+			ti,sci-rm-range-gp-rings = <0x1>;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <315>;
+			msi-parent = <&main_udmass_inta>;
+		};
+
+		main_udmap: dma-controller@31150000 {
+			compatible = "ti,j721e-navss-main-udmap";
+			reg = <0x00 0x31150000 0x00 0x100>,
+			      <0x00 0x34000000 0x00 0x80000>,
+			      <0x00 0x35000000 0x00 0x200000>,
+			      <0x00 0x30b00000 0x00 0x20000>,
+			      <0x00 0x30c00000 0x00 0x8000>,
+			      <0x00 0x30d00000 0x00 0x4000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt",
+				    "tchan", "rchan", "rflow";
+			msi-parent = <&main_udmass_inta>;
+			#dma-cells = <1>;
+
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <319>;
+			ti,ringacc = <&main_ringacc>;
+
+			ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
+						<0x0f>, /* TX_HCHAN */
+						<0x10>; /* TX_UHCHAN */
+			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
+						<0x0b>, /* RX_HCHAN */
+						<0x0c>; /* RX_UHCHAN */
+			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
+		};
+
+		main_bcdma_csi: dma-controller@311a0000 {
+			compatible = "ti,j721s2-dmss-bcdma-csi";
+			reg = <0x00 0x311a0000 0x00 0x100>,
+			      <0x00 0x35d00000 0x00 0x20000>,
+			      <0x00 0x35c00000 0x00 0x10000>,
+			      <0x00 0x35e00000 0x00 0x80000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
+			msi-parent = <&main_udmass_inta>;
+			#dma-cells = <3>;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <281>;
+			ti,sci-rm-range-rchan = <0x21>;
+			ti,sci-rm-range-tchan = <0x22>;
+		};
+
+		cpts@310d0000 {
+			compatible = "ti,j721e-cpts";
+			reg = <0x00 0x310d0000 0x00 0x400>;
+			reg-names = "cpts";
+			clocks = <&k3_clks 282 0>;
+			clock-names = "cpts";
+			assigned-clocks = <&k3_clks 62 3>; /* CPTS_RFT_CLK */
+			assigned-clock-parents = <&k3_clks 62 5>; /* MAIN_0_HSDIV6_CLK */
+			interrupts-extended = <&main_navss_intr 391>;
+			interrupt-names = "cpts";
+			ti,cpts-periodic-outputs = <6>;
+			ti,cpts-ext-ts-inputs = <8>;
+		};
+	};
+
+	main_cpsw0: ethernet@c000000 {
+		compatible = "ti,j784s4-cpswxg-nuss";
+		reg = <0x00 0xc000000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x00 0x00 0x00 0xc000000 0x00 0x200000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-coherent;
+		clocks = <&k3_clks 64 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 64 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&main_udmap 0xca00>,
+		       <&main_udmap 0xca01>,
+		       <&main_udmap 0xca02>,
+		       <&main_udmap 0xca03>,
+		       <&main_udmap 0xca04>,
+		       <&main_udmap 0xca05>,
+		       <&main_udmap 0xca06>,
+		       <&main_udmap 0xca07>,
+		       <&main_udmap 0x4a00>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+			    "tx4", "tx5", "tx6", "tx7",
+			    "rx";
+
+		status = "disabled";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			main_cpsw0_port1: port@1 {
+				reg = <1>;
+				label = "port1";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port2: port@2 {
+				reg = <2>;
+				label = "port2";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port3: port@3 {
+				reg = <3>;
+				label = "port3";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port4: port@4 {
+				reg = <4>;
+				label = "port4";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port5: port@5 {
+				reg = <5>;
+				label = "port5";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port6: port@6 {
+				reg = <6>;
+				label = "port6";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port7: port@7 {
+				reg = <7>;
+				label = "port7";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port8: port@8 {
+				reg = <8>;
+				label = "port8";
+				ti,mac-only;
+				status = "disabled";
+			};
+		};
+
+		main_cpsw0_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 64 0>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+			status = "disabled";
+		};
+
+		cpts@3d000 {
+			compatible = "ti,am65-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 64 3>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
+	main_cpsw1: ethernet@c200000 {
+		compatible = "ti,j721e-cpsw-nuss";
+		reg = <0x00 0xc200000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x00 0x00 0x00 0xc200000 0x00 0x200000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-coherent;
+		clocks = <&k3_clks 62 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 62 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&main_udmap 0xc640>,
+			<&main_udmap 0xc641>,
+			<&main_udmap 0xc642>,
+			<&main_udmap 0xc643>,
+			<&main_udmap 0xc644>,
+			<&main_udmap 0xc645>,
+			<&main_udmap 0xc646>,
+			<&main_udmap 0xc647>,
+			<&main_udmap 0x4640>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+				"tx4", "tx5", "tx6", "tx7",
+				"rx";
+
+		status = "disabled";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			main_cpsw1_port1: port@1 {
+				reg = <1>;
+				label = "port1";
+				phys = <&cpsw1_phy_gmii_sel 1>;
+				ti,mac-only;
+				status = "disabled";
+			};
+		};
+
+		main_cpsw1_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio", "ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 62 0>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+			status = "disabled";
+		};
+
+		cpts@3d000 {
+			compatible = "ti,am65-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 62 3>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
+	main_mcan0: can@2701000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02701000 0x00 0x200>,
+		      <0x00 0x02708000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 245 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 245 6>, <&k3_clks 245 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan1: can@2711000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02711000 0x00 0x200>,
+		      <0x00 0x02718000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 246 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 246 6>, <&k3_clks 246 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan2: can@2721000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02721000 0x00 0x200>,
+		      <0x00 0x02728000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 247 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 247 6>, <&k3_clks 247 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan3: can@2731000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02731000 0x00 0x200>,
+		      <0x00 0x02738000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 248 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 248 6>, <&k3_clks 248 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan4: can@2741000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02741000 0x00 0x200>,
+		      <0x00 0x02748000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 249 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 249 6>, <&k3_clks 249 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan5: can@2751000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02751000 0x00 0x200>,
+		      <0x00 0x02758000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 250 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 250 6>, <&k3_clks 250 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan6: can@2761000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02761000 0x00 0x200>,
+		      <0x00 0x02768000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 251 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 251 6>, <&k3_clks 251 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan7: can@2771000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02771000 0x00 0x200>,
+		      <0x00 0x02778000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 252 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 252 6>, <&k3_clks 252 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan8: can@2781000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02781000 0x00 0x200>,
+		      <0x00 0x02788000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 253 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 253 6>, <&k3_clks 253 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan9: can@2791000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02791000 0x00 0x200>,
+		      <0x00 0x02798000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 254 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 254 6>, <&k3_clks 254 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 579 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan10: can@27a1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027a1000 0x00 0x200>,
+		      <0x00 0x027a8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 255 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 255 6>, <&k3_clks 255 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan11: can@27b1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027b1000 0x00 0x200>,
+		      <0x00 0x027b8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 256 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 256 6>, <&k3_clks 256 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan12: can@27c1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027c1000 0x00 0x200>,
+		      <0x00 0x027c8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 257 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 257 6>, <&k3_clks 257 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan13: can@27d1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027d1000 0x00 0x200>,
+		      <0x00 0x027d8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 258 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 258 6>, <&k3_clks 258 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan14: can@2681000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02681000 0x00 0x200>,
+		      <0x00 0x02688000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 259 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 259 6>, <&k3_clks 259 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan15: can@2691000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02691000 0x00 0x200>,
+		      <0x00 0x02698000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 260 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 260 6>, <&k3_clks 260 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan16: can@26a1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x026a1000 0x00 0x200>,
+		      <0x00 0x026a8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 261 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 261 6>, <&k3_clks 261 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 784 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 785 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan17: can@26b1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x026b1000 0x00 0x200>,
+		      <0x00 0x026b8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 262 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 262 6>, <&k3_clks 262 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 787 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 788 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_spi0: spi@2100000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02100000 0x00 0x400>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 376 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 376 1>;
+		status = "disabled";
+	};
+
+	main_spi1: spi@2110000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02110000 0x00 0x400>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 377 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 377 1>;
+		status = "disabled";
+	};
+
+	main_spi2: spi@2120000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02120000 0x00 0x400>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 378 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 378 1>;
+		status = "disabled";
+	};
+
+	main_spi3: spi@2130000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02130000 0x00 0x400>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 379 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 379 1>;
+		status = "disabled";
+	};
+
+	main_spi4: spi@2140000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02140000 0x00 0x400>;
+		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 380 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 380 1>;
+		status = "disabled";
+	};
+
+	main_spi5: spi@2150000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02150000 0x00 0x400>;
+		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 381 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 381 1>;
+		status = "disabled";
+	};
+
+	main_spi6: spi@2160000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02160000 0x00 0x400>;
+		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 382 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 382 1>;
+		status = "disabled";
+	};
+
+	main_spi7: spi@2170000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02170000 0x00 0x400>;
+		interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 383 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 383 1>;
+		status = "disabled";
+	};
+
+	ufs_wrapper: ufs-wrapper@4e80000 {
+		compatible = "ti,j721e-ufs";
+		reg = <0x00 0x4e80000 0x00 0x100>;
+		power-domains = <&k3_pds 387 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 387 3>;
+		assigned-clocks = <&k3_clks 387 3>;
+		assigned-clock-parents = <&k3_clks 387 6>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		status = "disabled";
+
+		ufs@4e84000 {
+			compatible = "cdns,ufshc-m31-16nm", "jedec,ufs-2.0";
+			reg = <0x00 0x4e84000 0x00 0x10000>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			freq-table-hz = <250000000 250000000>, <19200000 19200000>,
+					<19200000 19200000>;
+			clocks = <&k3_clks 387 1>, <&k3_clks 387 3>, <&k3_clks 387 3>;
+			clock-names = "core_clk", "phy_clk", "ref_clk";
+			dma-coherent;
+		};
+	};
+
+	main_r5fss0: r5fss@5c00000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
+			 <0x5d00000 0x00 0x5d00000 0x20000>;
+		power-domains = <&k3_pds 336 TI_SCI_PD_EXCLUSIVE>;
+
+		main_r5fss0_core0: r5f@5c00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5c00000 0x00010000>,
+			      <0x5c10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <339>;
+			ti,sci-proc-ids = <0x06 0xff>;
+			resets = <&k3_reset 339 1>;
+			firmware-name = "j784s4-main-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+
+		main_r5fss0_core1: r5f@5d00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5d00000 0x00010000>,
+			      <0x5d10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <340>;
+			ti,sci-proc-ids = <0x07 0xff>;
+			resets = <&k3_reset 340 1>;
+			firmware-name = "j784s4-main-r5f0_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
+	main_r5fss1: r5fss@5e00000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
+			 <0x5f00000 0x00 0x5f00000 0x20000>;
+		power-domains = <&k3_pds 337 TI_SCI_PD_EXCLUSIVE>;
+
+		main_r5fss1_core0: r5f@5e00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5e00000 0x00010000>,
+			      <0x5e10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <341>;
+			ti,sci-proc-ids = <0x08 0xff>;
+			resets = <&k3_reset 341 1>;
+			firmware-name = "j784s4-main-r5f1_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+
+		main_r5fss1_core1: r5f@5f00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5f00000 0x00010000>,
+			      <0x5f10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <342>;
+			ti,sci-proc-ids = <0x09 0xff>;
+			resets = <&k3_reset 342 1>;
+			firmware-name = "j784s4-main-r5f1_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
+	main_r5fss2: r5fss@5900000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5900000 0x00 0x5900000 0x20000>,
+			 <0x5a00000 0x00 0x5a00000 0x20000>;
+		power-domains = <&k3_pds 338 TI_SCI_PD_EXCLUSIVE>;
+
+		main_r5fss2_core0: r5f@5900000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5900000 0x00010000>,
+			      <0x5910000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <343>;
+			ti,sci-proc-ids = <0x0a 0xff>;
+			resets = <&k3_reset 343 1>;
+			firmware-name = "j784s4-main-r5f2_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+
+		main_r5fss2_core1: r5f@5a00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5a00000 0x00010000>,
+			      <0x5a10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <344>;
+			ti,sci-proc-ids = <0x0b 0xff>;
+			resets = <&k3_reset 344 1>;
+			firmware-name = "j784s4-main-r5f2_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
+	c71_0: dsp@64800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x64800000 0x00 0x00080000>,
+		      <0x00 0x64e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <30>;
+		ti,sci-proc-ids = <0x30 0xff>;
+		resets = <&k3_reset 30 1>;
+		firmware-name = "j784s4-c71_0-fw";
+		status = "disabled";
+	};
+
+	c71_1: dsp@65800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x65800000 0x00 0x00080000>,
+		      <0x00 0x65e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <33>;
+		ti,sci-proc-ids = <0x31 0xff>;
+		resets = <&k3_reset 33 1>;
+		firmware-name = "j784s4-c71_1-fw";
+		status = "disabled";
+	};
+
+	c71_2: dsp@66800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x66800000 0x00 0x00080000>,
+		      <0x00 0x66e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <37>;
+		ti,sci-proc-ids = <0x32 0xff>;
+		resets = <&k3_reset 37 1>;
+		firmware-name = "j784s4-c71_2-fw";
+		status = "disabled";
+	};
+
+	main_esm: esm@700000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x700000 0x00 0x1000>;
+		ti,esm-pins = <688>, <689>, <690>, <691>, <692>, <693>, <694>,
+			      <695>;
+		bootph-pre-ram;
+	};
+
+	watchdog0: watchdog@2200000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2200000 0x00 0x100>;
+		clocks = <&k3_clks 348 0>;
+		power-domains = <&k3_pds 348 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 348 0>;
+		assigned-clock-parents = <&k3_clks 348 4>;
+	};
+
+	watchdog1: watchdog@2210000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2210000 0x00 0x100>;
+		clocks = <&k3_clks 349 0>;
+		power-domains = <&k3_pds 349 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 349 0>;
+		assigned-clock-parents = <&k3_clks 349 4>;
+	};
+
+	watchdog2: watchdog@2220000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2220000 0x00 0x100>;
+		clocks = <&k3_clks 350 0>;
+		power-domains = <&k3_pds 350 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 350 0>;
+		assigned-clock-parents = <&k3_clks 350 4>;
+	};
+
+	watchdog3: watchdog@2230000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2230000 0x00 0x100>;
+		clocks = <&k3_clks 351 0>;
+		power-domains = <&k3_pds 351 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 351 0>;
+		assigned-clock-parents = <&k3_clks 351 4>;
+	};
+
+	watchdog4: watchdog@2240000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2240000 0x00 0x100>;
+		clocks = <&k3_clks 352 0>;
+		power-domains = <&k3_pds 352 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 352 0>;
+		assigned-clock-parents = <&k3_clks 352 4>;
+	};
+
+	watchdog5: watchdog@2250000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2250000 0x00 0x100>;
+		clocks = <&k3_clks 353 0>;
+		power-domains = <&k3_pds 353 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 353 0>;
+		assigned-clock-parents = <&k3_clks 353 4>;
+	};
+
+	watchdog6: watchdog@2260000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2260000 0x00 0x100>;
+		clocks = <&k3_clks 354 0>;
+		power-domains = <&k3_pds 354 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 354 0>;
+		assigned-clock-parents = <&k3_clks 354 4>;
+	};
+
+	watchdog7: watchdog@2270000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2270000 0x00 0x100>;
+		clocks = <&k3_clks 355 0>;
+		power-domains = <&k3_pds 355 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 355 0>;
+		assigned-clock-parents = <&k3_clks 355 4>;
+	};
+
+	/*
+	 * The following RTI instances are coupled with MCU R5Fs, c7x and
+	 * GPU so keeping them reserved as these will be used by their
+	 * respective firmware
+	 */
+	watchdog8: watchdog@22f0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x22f0000 0x00 0x100>;
+		clocks = <&k3_clks 360 0>;
+		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 360 0>;
+		assigned-clock-parents = <&k3_clks 360 4>;
+		/* reserved for GPU */
+		status = "reserved";
+	};
+
+	watchdog9: watchdog@2300000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2300000 0x00 0x100>;
+		clocks = <&k3_clks 356 0>;
+		power-domains = <&k3_pds 356 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 356 0>;
+		assigned-clock-parents = <&k3_clks 356 4>;
+		/* reserved for C7X_0 DSP */
+		status = "reserved";
+	};
+
+	watchdog10: watchdog@2310000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2310000 0x00 0x100>;
+		clocks = <&k3_clks 357 0>;
+		power-domains = <&k3_pds 357 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 357 0>;
+		assigned-clock-parents = <&k3_clks 357 4>;
+		/* reserved for C7X_1 DSP */
+		status = "reserved";
+	};
+
+	watchdog11: watchdog@2320000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2320000 0x00 0x100>;
+		clocks = <&k3_clks 358 0>;
+		power-domains = <&k3_pds 358 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 358 0>;
+		assigned-clock-parents = <&k3_clks 358 4>;
+		/* reserved for C7X_2 DSP */
+		status = "reserved";
+	};
+
+	watchdog12: watchdog@2330000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2330000 0x00 0x100>;
+		clocks = <&k3_clks 359 0>;
+		power-domains = <&k3_pds 359 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 359 0>;
+		assigned-clock-parents = <&k3_clks 359 4>;
+		/* reserved for C7X_3 DSP */
+		status = "reserved";
+	};
+
+	watchdog13: watchdog@23c0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23c0000 0x00 0x100>;
+		clocks = <&k3_clks 361 0>;
+		power-domains = <&k3_pds 361 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 361 0>;
+		assigned-clock-parents = <&k3_clks 361 4>;
+		/* reserved for MAIN_R5F0_0 */
+		status = "reserved";
+	};
+
+	watchdog14: watchdog@23d0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23d0000 0x00 0x100>;
+		clocks = <&k3_clks 362 0>;
+		power-domains = <&k3_pds 362 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 362 0>;
+		assigned-clock-parents = <&k3_clks 362 4>;
+		/* reserved for MAIN_R5F0_1 */
+		status = "reserved";
+	};
+
+	watchdog15: watchdog@23e0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23e0000 0x00 0x100>;
+		clocks = <&k3_clks 363 0>;
+		power-domains = <&k3_pds 363 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 363 0>;
+		assigned-clock-parents = <&k3_clks 363 4>;
+		/* reserved for MAIN_R5F1_0 */
+		status = "reserved";
+	};
+
+	watchdog16: watchdog@23f0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23f0000 0x00 0x100>;
+		clocks = <&k3_clks 364 0>;
+		power-domains = <&k3_pds 364 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 364 0>;
+		assigned-clock-parents = <&k3_clks 364 4>;
+		/* reserved for MAIN_R5F1_1 */
+		status = "reserved";
+	};
+
+	watchdog17: watchdog@2540000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2540000 0x00 0x100>;
+		clocks = <&k3_clks 365 0>;
+		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 365 0>;
+		assigned-clock-parents = <&k3_clks 366 4>;
+		/* reserved for MAIN_R5F2_0 */
+		status = "reserved";
+	};
+
+	watchdog18: watchdog@2550000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2550000 0x00 0x100>;
+		clocks = <&k3_clks 366 0>;
+		power-domains = <&k3_pds 366 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 366 0>;
+		assigned-clock-parents = <&k3_clks 366 4>;
+		/* reserved for MAIN_R5F2_1 */
+		status = "reserved";
+	};
+
+	mhdp: bridge@a000000 {
+		compatible = "ti,j721e-mhdp8546";
+		reg = <0x0 0xa000000 0x0 0x30a00>,
+		      <0x0 0x4f40000 0x0 0x20>;
+		reg-names = "mhdptx", "j721e-intg";
+		clocks = <&k3_clks 217 11>;
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 217 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		dp0_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			/* Remote-endpoints are on the boards so
+			 * ports are defined in the platform dt file.
+			 */
+		};
+	};
+
+	dss: dss@4a00000 {
+		compatible = "ti,j721e-dss";
+		reg = <0x00 0x04a00000 0x00 0x10000>, /* common_m */
+		      <0x00 0x04a10000 0x00 0x10000>, /* common_s0*/
+		      <0x00 0x04b00000 0x00 0x10000>, /* common_s1*/
+		      <0x00 0x04b10000 0x00 0x10000>, /* common_s2*/
+		      <0x00 0x04a20000 0x00 0x10000>, /* vidl1 */
+		      <0x00 0x04a30000 0x00 0x10000>, /* vidl2 */
+		      <0x00 0x04a50000 0x00 0x10000>, /* vid1 */
+		      <0x00 0x04a60000 0x00 0x10000>, /* vid2 */
+		      <0x00 0x04a70000 0x00 0x10000>, /* ovr1 */
+		      <0x00 0x04a90000 0x00 0x10000>, /* ovr2 */
+		      <0x00 0x04ab0000 0x00 0x10000>, /* ovr3 */
+		      <0x00 0x04ad0000 0x00 0x10000>, /* ovr4 */
+		      <0x00 0x04a80000 0x00 0x10000>, /* vp1 */
+		      <0x00 0x04aa0000 0x00 0x10000>, /* vp1 */
+		      <0x00 0x04ac0000 0x00 0x10000>, /* vp1 */
+		      <0x00 0x04ae0000 0x00 0x10000>, /* vp4 */
+		      <0x00 0x04af0000 0x00 0x10000>; /* wb */
+		reg-names = "common_m", "common_s0",
+			    "common_s1", "common_s2",
+			    "vidl1", "vidl2","vid1","vid2",
+			    "ovr1", "ovr2", "ovr3", "ovr4",
+			    "vp1", "vp2", "vp3", "vp4",
+			    "wb";
+		clocks = <&k3_clks 218 0>,
+			 <&k3_clks 218 2>,
+			 <&k3_clks 218 5>,
+			 <&k3_clks 218 14>,
+			 <&k3_clks 218 18>;
+		clock-names = "fck", "vp1", "vp2", "vp3", "vp4";
+		power-domains = <&k3_pds 218 TI_SCI_PD_EXCLUSIVE>;
+		interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "common_m",
+				  "common_s0",
+				  "common_s1",
+				  "common_s2";
+		status = "disabled";
+
+		dss_ports: ports {
+			/* Ports that DSS drives are platform specific
+			 * so they are defined in platform dt file.
+			 */
+		};
+	};
+
+	mcasp0: mcasp@2b00000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b00000 0x00 0x2000>,
+		      <0x00 0x02b08000 0x00 0x1000>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 545 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+		dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
+		dma-names = "tx", "rx";
+		clocks = <&k3_clks 265 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 265 0>;
+		assigned-clock-parents = <&k3_clks 265 1>;
+		power-domains = <&k3_pds 265 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp1: mcasp@2b10000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b10000 0x00 0x2000>,
+		      <0x00 0x02b18000 0x00 0x1000>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 546 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 547 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+		dmas = <&main_udmap 0xc401>, <&main_udmap 0x4401>;
+		dma-names = "tx", "rx";
+		clocks = <&k3_clks 266 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 266 0>;
+		assigned-clock-parents = <&k3_clks 266 1>;
+		power-domains = <&k3_pds 266 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp2: mcasp@2b20000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b20000 0x00 0x2000>,
+		      <0x00 0x02b28000 0x00 0x1000>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 548 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 549 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+		dmas = <&main_udmap 0xc402>, <&main_udmap 0x4402>;
+		dma-names = "tx", "rx";
+		clocks = <&k3_clks 267 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 267 0>;
+		assigned-clock-parents = <&k3_clks 267 1>;
+		power-domains = <&k3_pds 267 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp3: mcasp@2b30000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b30000 0x00 0x2000>,
+		      <0x00 0x02b38000 0x00 0x1000>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 550 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 551 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+		dmas = <&main_udmap 0xc403>, <&main_udmap 0x4403>;
+		dma-names = "tx", "rx";
+		clocks = <&k3_clks 268 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 268 0>;
+		assigned-clock-parents = <&k3_clks 268 1>;
+		power-domains = <&k3_pds 268 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp4: mcasp@2b40000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b40000 0x00 0x2000>,
+		      <0x00 0x02b48000 0x00 0x1000>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 552 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 553 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+		dmas = <&main_udmap 0xc404>, <&main_udmap 0x4404>;
+		dma-names = "tx", "rx";
+		clocks = <&k3_clks 269 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 269 0>;
+		assigned-clock-parents = <&k3_clks 269 1>;
+		power-domains = <&k3_pds 269 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
new file mode 100644
index 000000000000..cba8d0e64f2e
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
@@ -0,0 +1,760 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree Source for J784S4 and J742S2 SoC Family MCU/WAKEUP Domain peripherals
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&cbass_mcu_wakeup {
+	sms: system-controller@44083000 {
+		bootph-all;
+		compatible = "ti,k2g-sci";
+		ti,host-id = <12>;
+
+		mbox-names = "rx", "tx";
+
+		mboxes = <&secure_proxy_main 11>,
+			 <&secure_proxy_main 13>;
+
+		reg-names = "debug_messages";
+		reg = <0x00 0x44083000 0x00 0x1000>;
+
+		k3_pds: power-controller {
+			bootph-all;
+			compatible = "ti,sci-pm-domain";
+			#power-domain-cells = <2>;
+		};
+
+		k3_clks: clock-controller {
+			bootph-all;
+			compatible = "ti,k2g-sci-clk";
+			#clock-cells = <2>;
+		};
+
+		k3_reset: reset-controller {
+			bootph-all;
+			compatible = "ti,sci-reset";
+			#reset-cells = <2>;
+		};
+	};
+
+	wkup_conf: bus@43000000 {
+		bootph-all;
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x00 0x43000000 0x20000>;
+
+		chipid: chipid@14 {
+			bootph-all;
+			compatible = "ti,am654-chipid";
+			reg = <0x14 0x4>;
+		};
+	};
+
+	secure_proxy_sa3: mailbox@43600000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x00 0x43600000 0x00 0x10000>,
+		      <0x00 0x44880000 0x00 0x20000>,
+		      <0x00 0x44860000 0x00 0x20000>;
+		/*
+		 * Marked Disabled:
+		 * Node is incomplete as it is meant for bootloaders and
+		 * firmware on non-MPU processors
+		 */
+		status = "disabled";
+	};
+
+	mcu_ram: sram@41c00000 {
+		compatible = "mmio-sram";
+		reg = <0x00 0x41c00000 0x00 0x100000>;
+		ranges = <0x00 0x00 0x41c00000 0x100000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	wkup_pmx0: pinctrl@4301c000 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c000 0x00 0x034>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx1: pinctrl@4301c038 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c038 0x00 0x02c>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx2: pinctrl@4301c068 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c068 0x00 0x120>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx3: pinctrl@4301c190 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c190 0x00 0x004>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_gpio_intr: interrupt-controller@42200000 {
+		compatible = "ti,sci-intr";
+		reg = <0x00 0x42200000 0x00 0x400>;
+		ti,intr-trigger-type = <1>;
+		interrupt-controller;
+		interrupt-parent = <&gic500>;
+		#interrupt-cells = <1>;
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <177>;
+		ti,interrupt-ranges = <16 960 16>;
+	};
+
+	/* MCU_TIMERIO pad input CTRLMMR_MCU_TIMER*_CTRL registers */
+	mcu_timerio_input: pinctrl@40f04200 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x40f04200 0x00 0x28>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000f>;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	/* MCU_TIMERIO pad output CTRLMMR_MCU_TIMERIO*_CTRL registers */
+	mcu_timerio_output: pinctrl@40f04280 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x40f04280 0x00 0x28>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000f>;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_conf: bus@40f00000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x40f00000 0x20000>;
+
+		cpsw_mac_syscon: ethernet-mac-syscon@200 {
+			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
+			reg = <0x200 0x8>;
+		};
+
+		phy_gmii_sel: phy@4040 {
+			compatible = "ti,am654-phy-gmii-sel";
+			reg = <0x4040 0x4>;
+			#phy-cells = <1>;
+		};
+	};
+
+	mcu_timer0: timer@40400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40400000 0x00 0x400>;
+		interrupts = <GIC_SPI 816 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 35 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 35 2>;
+		assigned-clock-parents = <&k3_clks 35 3>;
+		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer1: timer@40410000 {
+		bootph-all;
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40410000 0x00 0x400>;
+		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 117 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 117 2>;
+		assigned-clock-parents = <&k3_clks 117 3>;
+		power-domains = <&k3_pds 117 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer2: timer@40420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40420000 0x00 0x400>;
+		interrupts = <GIC_SPI 818 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 118 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 118 2>;
+		assigned-clock-parents = <&k3_clks 118 3>;
+		power-domains = <&k3_pds 118 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer3: timer@40430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40430000 0x00 0x400>;
+		interrupts = <GIC_SPI 819 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 119 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 119 2>;
+		assigned-clock-parents = <&k3_clks 119 3>;
+		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer4: timer@40440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40440000 0x00 0x400>;
+		interrupts = <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 120 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 120 2>;
+		assigned-clock-parents = <&k3_clks 120 3>;
+		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer5: timer@40450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40450000 0x00 0x400>;
+		interrupts = <GIC_SPI 821 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 121 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 121 2>;
+		assigned-clock-parents = <&k3_clks 121 3>;
+		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer6: timer@40460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40460000 0x00 0x400>;
+		interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 122 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 122 2>;
+		assigned-clock-parents = <&k3_clks 122 3>;
+		power-domains = <&k3_pds 122 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer7: timer@40470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40470000 0x00 0x400>;
+		interrupts = <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 123 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 123 2>;
+		assigned-clock-parents = <&k3_clks 123 3>;
+		power-domains = <&k3_pds 123 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer8: timer@40480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40480000 0x00 0x400>;
+		interrupts = <GIC_SPI 824 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 124 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 124 2>;
+		assigned-clock-parents = <&k3_clks 124 3>;
+		power-domains = <&k3_pds 124 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer9: timer@40490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40490000 0x00 0x400>;
+		interrupts = <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 125 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 125 2>;
+		assigned-clock-parents = <&k3_clks 125 3>;
+		power-domains = <&k3_pds 125 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	wkup_uart0: serial@42300000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x42300000 0x00 0x200>;
+		interrupts = <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 397 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 397 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcu_uart0: serial@40a00000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x40a00000 0x00 0x200>;
+		interrupts = <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 149 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	wkup_gpio0: gpio@42110000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x42110000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&wkup_gpio_intr>;
+		interrupts = <103>, <104>, <105>, <106>, <107>, <108>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <89>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 167 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 167 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	wkup_gpio1: gpio@42100000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x42100000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&wkup_gpio_intr>;
+		interrupts = <112>, <113>, <114>, <115>, <116>, <117>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <89>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 168 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 168 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	wkup_i2c0: i2c@42120000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x42120000 0x00 0x100>;
+		interrupts = <GIC_SPI 896 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 279 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcu_i2c0: i2c@40b00000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x40b00000 0x00 0x100>;
+		interrupts = <GIC_SPI 852 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 277 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 277 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcu_i2c1: i2c@40b10000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x40b10000 0x00 0x100>;
+		interrupts = <GIC_SPI 853 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 278 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcu_mcan0: can@40528000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x40528000 0x00 0x200>,
+		      <0x00 0x40500000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 263 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 263 6>, <&k3_clks 263 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 832 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	mcu_mcan1: can@40568000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x40568000 0x00 0x200>,
+		      <0x00 0x40540000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 264 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 264 6>, <&k3_clks 264 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	mcu_spi0: spi@40300000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040300000 0x00 0x400>;
+		interrupts = <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 384 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 384 0>;
+		status = "disabled";
+	};
+
+	mcu_spi1: spi@40310000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040310000 0x00 0x400>;
+		interrupts = <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 385 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 385 0>;
+		status = "disabled";
+	};
+
+	mcu_spi2: spi@40320000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040320000 0x00 0x400>;
+		interrupts = <GIC_SPI 850 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 386 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 386 0>;
+		status = "disabled";
+	};
+
+	mcu_navss: bus@28380000 {
+		bootph-all;
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
+		ti,sci-dev-id = <323>;
+		dma-coherent;
+		dma-ranges;
+
+		mcu_ringacc: ringacc@2b800000 {
+			bootph-all;
+			compatible = "ti,am654-navss-ringacc";
+			reg = <0x00 0x2b800000 0x00 0x400000>,
+			      <0x00 0x2b000000 0x00 0x400000>,
+			      <0x00 0x28590000 0x00 0x100>,
+			      <0x00 0x2a500000 0x00 0x40000>,
+			      <0x00 0x28440000 0x00 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
+			ti,num-rings = <286>;
+			ti,sci-rm-range-gp-rings = <0x1>;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <328>;
+			msi-parent = <&main_udmass_inta>;
+		};
+
+		mcu_udmap: dma-controller@285c0000 {
+			bootph-all;
+			compatible = "ti,j721e-navss-mcu-udmap";
+			reg = <0x00 0x285c0000 0x00 0x100>,
+			      <0x00 0x2a800000 0x00 0x40000>,
+			      <0x00 0x2aa00000 0x00 0x40000>,
+			      <0x00 0x284a0000 0x00 0x4000>,
+			      <0x00 0x284c0000 0x00 0x4000>,
+			      <0x00 0x28400000 0x00 0x2000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt",
+				    "tchan", "rchan", "rflow";
+			msi-parent = <&main_udmass_inta>;
+			#dma-cells = <1>;
+
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <329>;
+			ti,ringacc = <&mcu_ringacc>;
+			ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
+						<0x0f>; /* TX_HCHAN */
+			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
+						<0x0b>; /* RX_HCHAN */
+			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
+		};
+	};
+
+	secure_proxy_mcu: mailbox@2a480000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x00 0x2a480000 0x00 0x80000>,
+		      <0x00 0x2a380000 0x00 0x80000>,
+		      <0x00 0x2a400000 0x00 0x80000>;
+		/*
+		 * Marked Disabled:
+		 * Node is incomplete as it is meant for bootloaders and
+		 * firmware on non-MPU processors
+		 */
+		status = "disabled";
+	};
+
+	mcu_cpsw: ethernet@46000000 {
+		compatible = "ti,j721e-cpsw-nuss";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x00 0x46000000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x00 0x00 0x00 0x46000000 0x00 0x200000>;
+		dma-coherent;
+		clocks = <&k3_clks 63 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 63 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&mcu_udmap 0xf000>,
+		       <&mcu_udmap 0xf001>,
+		       <&mcu_udmap 0xf002>,
+		       <&mcu_udmap 0xf003>,
+		       <&mcu_udmap 0xf004>,
+		       <&mcu_udmap 0xf005>,
+		       <&mcu_udmap 0xf006>,
+		       <&mcu_udmap 0xf007>,
+		       <&mcu_udmap 0x7000>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+			    "tx4", "tx5", "tx6", "tx7",
+			    "rx";
+		status = "disabled";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mcu_cpsw_port1: port@1 {
+				reg = <1>;
+				ti,mac-only;
+				label = "port1";
+				ti,syscon-efuse = <&cpsw_mac_syscon 0x0>;
+				phys = <&phy_gmii_sel 1>;
+			};
+		};
+
+		davinci_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 63 0>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+		};
+
+		cpts@3d000 {
+			compatible = "ti,am65-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 63 3>;
+			clock-names = "cpts";
+			assigned-clocks = <&k3_clks 63 3>; /* CPTS_RFT_CLK */
+			assigned-clock-parents = <&k3_clks 63 5>; /* MAIN_0_HSDIV6_CLK */
+			interrupts-extended = <&gic500 GIC_SPI 858 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
+	mcu_r5fss0: r5fss@41000000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x41000000 0x00 0x41000000 0x20000>,
+			 <0x41400000 0x00 0x41400000 0x20000>;
+		power-domains = <&k3_pds 345 TI_SCI_PD_EXCLUSIVE>;
+
+		mcu_r5fss0_core0: r5f@41000000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x41000000 0x00010000>,
+			      <0x41010000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <346>;
+			ti,sci-proc-ids = <0x01 0xff>;
+			resets = <&k3_reset 346 1>;
+			firmware-name = "j784s4-mcu-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+
+		mcu_r5fss0_core1: r5f@41400000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x41400000 0x00010000>,
+			      <0x41410000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <347>;
+			ti,sci-proc-ids = <0x02 0xff>;
+			resets = <&k3_reset 347 1>;
+			firmware-name = "j784s4-mcu-r5f0_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
+	wkup_vtm0: temperature-sensor@42040000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0x42040000 0x00 0x350>,
+		      <0x00 0x42050000 0x00 0x350>;
+		power-domains = <&k3_pds 243 TI_SCI_PD_SHARED>;
+		#thermal-sensor-cells = <1>;
+	};
+
+	tscadc0: tscadc@40200000 {
+		compatible = "ti,am3359-tscadc";
+		reg = <0x00 0x40200000 0x00 0x1000>;
+		interrupts = <GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 0 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 0 0>;
+		assigned-clocks = <&k3_clks 0 2>;
+		assigned-clock-rates = <60000000>;
+		clock-names = "fck";
+		dmas = <&main_udmap 0x7400>,
+			<&main_udmap 0x7401>;
+		dma-names = "fifo0", "fifo1";
+		status = "disabled";
+
+		adc {
+			#io-channel-cells = <1>;
+			compatible = "ti,am3359-adc";
+		};
+	};
+
+	tscadc1: tscadc@40210000 {
+		compatible = "ti,am3359-tscadc";
+		reg = <0x00 0x40210000 0x00 0x1000>;
+		interrupts = <GIC_SPI 861 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 1 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 1 0>;
+		assigned-clocks = <&k3_clks 1 2>;
+		assigned-clock-rates = <60000000>;
+		clock-names = "fck";
+		dmas = <&main_udmap 0x7402>,
+			<&main_udmap 0x7403>;
+		dma-names = "fifo0", "fifo1";
+		status = "disabled";
+
+		adc {
+			#io-channel-cells = <1>;
+			compatible = "ti,am3359-adc";
+		};
+	};
+
+	fss: bus@47000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x47000000 0x00 0x47000000 0x00 0x00000100>, /* FSS Control */
+			 <0x00 0x47040000 0x00 0x47040000 0x00 0x00000100>, /* OSPI0 Control */
+			 <0x00 0x47050000 0x00 0x47050000 0x00 0x00000100>, /* OSPI1 Control */
+			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS data region 1 */
+			 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS data region 0/3 */
+
+		ospi0: spi@47040000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x47040000 0x00 0x100>,
+			      <0x05 0x00000000 0x01 0x00000000>;
+			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 161 7>;
+			assigned-clocks = <&k3_clks 161 7>;
+			assigned-clock-parents = <&k3_clks 161 9>;
+			assigned-clock-rates = <166666666>;
+			power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		ospi1: spi@47050000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x47050000 0x00 0x100>,
+			      <0x07 0x00000000 0x01 0x00000000>;
+			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 162 7>;
+			power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+	};
+
+	mcu_esm: esm@40800000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x40800000 0x00 0x1000>;
+		ti,esm-pins = <95>;
+		bootph-pre-ram;
+	};
+
+	wkup_esm: esm@42080000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x42080000 0x00 0x1000>;
+		ti,esm-pins = <63>;
+		bootph-pre-ram;
+	};
+
+	/*
+	 * The 2 RTI instances are couple with MCU R5Fs so keeping them
+	 * reserved as these will be used by their respective firmware
+	 */
+	mcu_watchdog0: watchdog@40600000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x40600000 0x00 0x100>;
+		clocks = <&k3_clks 367 1>;
+		power-domains = <&k3_pds 367 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 367 0>;
+		assigned-clock-parents = <&k3_clks 367 4>;
+		/* reserved for MCU_R5F0_0 */
+		status = "reserved";
+	};
+
+	mcu_watchdog1: watchdog@40610000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x40610000 0x00 0x100>;
+		clocks = <&k3_clks 368 1>;
+		power-domains = <&k3_pds 368 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 368 0>;
+		assigned-clock-parents = <&k3_clks 368 4>;
+		/* reserved for MCU_R5F0_1 */
+		status = "reserved";
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-thermal-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-thermal-common.dtsi
new file mode 100644
index 000000000000..e3ef61c1658f
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-thermal-common.dtsi
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+wkup0_thermal: wkup0-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 0>;
+
+	trips {
+		wkup0_crit: wkup0-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+wkup1_thermal: wkup1-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 1>;
+
+	trips {
+		wkup1_crit: wkup1-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main0_thermal: main0-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 2>;
+
+	trips {
+		main0_crit: main0-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main1_thermal: main1-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 3>;
+
+	trips {
+		main1_crit: main1-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main2_thermal: main2-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 4>;
+
+	trips {
+		main2_crit: main2-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main3_thermal: main3-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 5>;
+
+	trips {
+		main3_crit: main3-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main4_thermal: main4-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 6>;
+
+	trips {
+		main4_crit: main4-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index e73bb750b09a..0160fe0da983 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -5,2781 +5,124 @@
  * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include <dt-bindings/mux/mux.h>
-#include <dt-bindings/phy/phy.h>
-#include <dt-bindings/phy/phy-ti.h>
-
-#include "k3-serdes.h"
-
-/ {
-	serdes_refclk: clock-serdes {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		/* To be enabled when serdes_wiz* is functional */
-		status = "disabled";
-	};
-};
-
-&cbass_main {
-	msmc_ram: sram@70000000 {
-		compatible = "mmio-sram";
-		reg = <0x00 0x70000000 0x00 0x800000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x00 0x00 0x70000000 0x800000>;
-
-		atf-sram@0 {
-			reg = <0x00 0x20000>;
-		};
-
-		tifs-sram@1f0000 {
-			reg = <0x1f0000 0x10000>;
-		};
-
-		l3cache-sram@200000 {
-			reg = <0x200000 0x200000>;
-		};
-	};
-
-	scm_conf: bus@100000 {
-		compatible = "simple-bus";
-		reg = <0x00 0x00100000 0x00 0x1c000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x00 0x00 0x00100000 0x1c000>;
-
-		cpsw1_phy_gmii_sel: phy@4034 {
-			compatible = "ti,am654-phy-gmii-sel";
-			reg = <0x4034 0x4>;
-			#phy-cells = <1>;
-		};
-
-		cpsw0_phy_gmii_sel: phy@4044 {
-			compatible = "ti,j784s4-cpsw9g-phy-gmii-sel";
-			reg = <0x4044 0x20>;
-			#phy-cells = <1>;
-			ti,qsgmii-main-ports = <7>, <7>;
-		};
-
-		pcie0_ctrl: pcie0-ctrl@4070 {
-			compatible = "ti,j784s4-pcie-ctrl", "syscon";
-			reg = <0x4070 0x4>;
-		};
-
-		pcie1_ctrl: pcie1-ctrl@4074 {
-			compatible = "ti,j784s4-pcie-ctrl", "syscon";
-			reg = <0x4074 0x4>;
-		};
-
-		pcie2_ctrl: pcie2-ctrl@4078 {
-			compatible = "ti,j784s4-pcie-ctrl", "syscon";
-			reg = <0x4078 0x4>;
-		};
-
-		pcie3_ctrl: pcie3-ctrl@407c {
-			compatible = "ti,j784s4-pcie-ctrl", "syscon";
-			reg = <0x407c 0x4>;
-		};
-
-		serdes_ln_ctrl: mux-controller@4080 {
-			compatible = "reg-mux";
-			reg = <0x00004080 0x30>;
-			#mux-control-cells = <1>;
-			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
-					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */
-					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
-					<0x18 0x3>, <0x1c 0x3>, /* SERDES1 lane2/3 select */
-					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
-					<0x28 0x3>, <0x2c 0x3>; /* SERDES2 lane2/3 select */
-			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
-				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
-				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,
-				      <J784S4_SERDES0_LANE3_USB>,
-				      <J784S4_SERDES1_LANE0_PCIE0_LANE0>,
-				      <J784S4_SERDES1_LANE1_PCIE0_LANE1>,
-				      <J784S4_SERDES1_LANE2_PCIE0_LANE2>,
-				      <J784S4_SERDES1_LANE3_PCIE0_LANE3>,
-				      <J784S4_SERDES2_LANE0_IP2_UNUSED>,
-				      <J784S4_SERDES2_LANE1_IP2_UNUSED>,
-				      <J784S4_SERDES2_LANE2_QSGMII_LANE1>,
-				      <J784S4_SERDES2_LANE3_QSGMII_LANE2>,
-				      <J784S4_SERDES4_LANE0_EDP_LANE0>,
-				      <J784S4_SERDES4_LANE1_EDP_LANE1>,
-				      <J784S4_SERDES4_LANE2_EDP_LANE2>,
-				      <J784S4_SERDES4_LANE3_EDP_LANE3>;
-		};
-
-		usb_serdes_mux: mux-controller@4000 {
-			compatible = "reg-mux";
-			reg = <0x4000 0x4>;
-			#mux-control-cells = <1>;
-			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 3 mux */
-		};
-
-		ehrpwm_tbclk: clock-controller@4140 {
-			compatible = "ti,am654-ehrpwm-tbclk";
-			reg = <0x4140 0x18>;
-			#clock-cells = <1>;
-		};
-
-		audio_refclk1: clock@82e4 {
-			compatible = "ti,am62-audio-refclk";
-			reg = <0x82e4 0x4>;
-			clocks = <&k3_clks 157 34>;
-			assigned-clocks = <&k3_clks 157 34>;
-			assigned-clock-parents = <&k3_clks 157 63>;
-			#clock-cells = <0>;
-		};
-	};
-
-	main_ehrpwm0: pwm@3000000 {
-		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
-		reg = <0x00 0x3000000 0x00 0x100>;
-		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 219 0>;
-		clock-names = "tbclk", "fck";
-		power-domains = <&k3_pds 219 TI_SCI_PD_EXCLUSIVE>;
-		#pwm-cells = <3>;
-		status = "disabled";
-	};
-
-	main_ehrpwm1: pwm@3010000 {
-		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
-		reg = <0x00 0x3010000 0x00 0x100>;
-		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 220 0>;
-		clock-names = "tbclk", "fck";
-		power-domains = <&k3_pds 220 TI_SCI_PD_EXCLUSIVE>;
-		#pwm-cells = <3>;
-		status = "disabled";
-	};
-
-	main_ehrpwm2: pwm@3020000 {
-		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
-		reg = <0x00 0x3020000 0x00 0x100>;
-		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 221 0>;
-		clock-names = "tbclk", "fck";
-		power-domains = <&k3_pds 221 TI_SCI_PD_EXCLUSIVE>;
-		#pwm-cells = <3>;
-		status = "disabled";
-	};
-
-	main_ehrpwm3: pwm@3030000 {
-		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
-		reg = <0x00 0x3030000 0x00 0x100>;
-		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 222 0>;
-		clock-names = "tbclk", "fck";
-		power-domains = <&k3_pds 222 TI_SCI_PD_EXCLUSIVE>;
-		#pwm-cells = <3>;
-		status = "disabled";
-	};
-
-	main_ehrpwm4: pwm@3040000 {
-		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
-		reg = <0x00 0x3040000 0x00 0x100>;
-		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 223 0>;
-		clock-names = "tbclk", "fck";
-		power-domains = <&k3_pds 223 TI_SCI_PD_EXCLUSIVE>;
-		#pwm-cells = <3>;
-		status = "disabled";
-	};
-
-	main_ehrpwm5: pwm@3050000 {
-		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
-		reg = <0x00 0x3050000 0x00 0x100>;
-		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 224 0>;
-		clock-names = "tbclk", "fck";
-		power-domains = <&k3_pds 224 TI_SCI_PD_EXCLUSIVE>;
-		#pwm-cells = <3>;
-		status = "disabled";
-	};
-
-	gic500: interrupt-controller@1800000 {
-		compatible = "arm,gic-v3";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x00 0x01800000 0x00 0x200000>, /* GICD */
-		      <0x00 0x01900000 0x00 0x100000>, /* GICR */
-		      <0x00 0x6f000000 0x00 0x2000>,   /* GICC */
-		      <0x00 0x6f010000 0x00 0x1000>,   /* GICH */
-		      <0x00 0x6f020000 0x00 0x2000>;   /* GICV */
-
-		/* vcpumntirq: virtual CPU interface maintenance interrupt */
-		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
-
-		gic_its: msi-controller@1820000 {
-			compatible = "arm,gic-v3-its";
-			reg = <0x00 0x01820000 0x00 0x10000>;
-			socionext,synquacer-pre-its = <0x1000000 0x400000>;
-			msi-controller;
-			#msi-cells = <1>;
-		};
-	};
-
-	main_gpio_intr: interrupt-controller@a00000 {
-		compatible = "ti,sci-intr";
-		reg = <0x00 0x00a00000 0x00 0x800>;
-		ti,intr-trigger-type = <1>;
-		interrupt-controller;
-		interrupt-parent = <&gic500>;
-		#interrupt-cells = <1>;
-		ti,sci = <&sms>;
-		ti,sci-dev-id = <10>;
-		ti,interrupt-ranges = <8 392 56>;
-	};
-
-	main_pmx0: pinctrl@11c000 {
-		compatible = "pinctrl-single";
-		/* Proxy 0 addressing */
-		reg = <0x00 0x11c000 0x00 0x120>;
-		#pinctrl-cells = <1>;
-		pinctrl-single,register-width = <32>;
-		pinctrl-single,function-mask = <0xffffffff>;
-	};
-
-	/* TIMERIO pad input CTRLMMR_TIMER*_CTRL registers */
-	main_timerio_input: pinctrl@104200 {
-		compatible = "pinctrl-single";
-		reg = <0x00 0x104200 0x00 0x50>;
-		#pinctrl-cells = <1>;
-		pinctrl-single,register-width = <32>;
-		pinctrl-single,function-mask = <0x00000007>;
-	};
-
-	/* TIMERIO pad output CTCTRLMMR_TIMERIO*_CTRL registers */
-	main_timerio_output: pinctrl@104280 {
-		compatible = "pinctrl-single";
-		reg = <0x00 0x104280 0x00 0x20>;
-		#pinctrl-cells = <1>;
-		pinctrl-single,register-width = <32>;
-		pinctrl-single,function-mask = <0x0000001f>;
-	};
-
-	main_crypto: crypto@4e00000 {
-		compatible = "ti,j721e-sa2ul";
-		reg = <0x00 0x4e00000 0x00 0x1200>;
-		power-domains = <&k3_pds 369 TI_SCI_PD_EXCLUSIVE>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges = <0x00 0x04e00000 0x00 0x04e00000 0x00 0x30000>;
-
-		dmas = <&main_udmap 0xca40>, <&main_udmap 0x4a40>,
-				<&main_udmap 0x4a41>;
-		dma-names = "tx", "rx1", "rx2";
-
-		rng: rng@4e10000 {
-			compatible = "inside-secure,safexcel-eip76";
-			reg = <0x00 0x4e10000 0x00 0x7d>;
-			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
-
-	main_timer0: timer@2400000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x2400000 0x00 0x400>;
-		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 97 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 97 2>;
-		assigned-clock-parents = <&k3_clks 97 3>;
-		power-domains = <&k3_pds 97 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer1: timer@2410000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x2410000 0x00 0x400>;
-		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 98 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 98 2>;
-		assigned-clock-parents = <&k3_clks 98 3>;
-		power-domains = <&k3_pds 98 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer2: timer@2420000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x2420000 0x00 0x400>;
-		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 99 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 99 2>;
-		assigned-clock-parents = <&k3_clks 99 3>;
-		power-domains = <&k3_pds 99 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer3: timer@2430000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x2430000 0x00 0x400>;
-		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 100 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 100 2>;
-		assigned-clock-parents = <&k3_clks 100 3>;
-		power-domains = <&k3_pds 100 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer4: timer@2440000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x2440000 0x00 0x400>;
-		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 101 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 101 2>;
-		assigned-clock-parents = <&k3_clks 101 3>;
-		power-domains = <&k3_pds 101 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer5: timer@2450000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x2450000 0x00 0x400>;
-		interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 102 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 102 2>;
-		assigned-clock-parents = <&k3_clks 102 3>;
-		power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer6: timer@2460000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x2460000 0x00 0x400>;
-		interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 103 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 103 2>;
-		assigned-clock-parents = <&k3_clks 103 3>;
-		power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer7: timer@2470000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x2470000 0x00 0x400>;
-		interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 104 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 104 2>;
-		assigned-clock-parents = <&k3_clks 104 3>;
-		power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer8: timer@2480000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x2480000 0x00 0x400>;
-		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 105 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 105 2>;
-		assigned-clock-parents = <&k3_clks 105 3>;
-		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer9: timer@2490000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x2490000 0x00 0x400>;
-		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 106 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 106 2>;
-		assigned-clock-parents = <&k3_clks 106 3>;
-		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer10: timer@24a0000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x24a0000 0x00 0x400>;
-		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 107 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 107 2>;
-		assigned-clock-parents = <&k3_clks 107 3>;
-		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer11: timer@24b0000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x24b0000 0x00 0x400>;
-		interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 108 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 108 2>;
-		assigned-clock-parents = <&k3_clks 108 3>;
-		power-domains = <&k3_pds 108 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer12: timer@24c0000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x24c0000 0x00 0x400>;
-		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 109 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 109 2>;
-		assigned-clock-parents = <&k3_clks 109 3>;
-		power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer13: timer@24d0000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x24d0000 0x00 0x400>;
-		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 110 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 110 2>;
-		assigned-clock-parents = <&k3_clks 110 3>;
-		power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer14: timer@24e0000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x24e0000 0x00 0x400>;
-		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 111 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 111 2>;
-		assigned-clock-parents = <&k3_clks 111 3>;
-		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer15: timer@24f0000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x24f0000 0x00 0x400>;
-		interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 112 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 112 2>;
-		assigned-clock-parents = <&k3_clks 112 3>;
-		power-domains = <&k3_pds 112 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer16: timer@2500000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x2500000 0x00 0x400>;
-		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 113 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 113 2>;
-		assigned-clock-parents = <&k3_clks 113 3>;
-		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer17: timer@2510000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x2510000 0x00 0x400>;
-		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 114 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 114 2>;
-		assigned-clock-parents = <&k3_clks 114 3>;
-		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer18: timer@2520000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x2520000 0x00 0x400>;
-		interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 115 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 115 2>;
-		assigned-clock-parents = <&k3_clks 115 3>;
-		power-domains = <&k3_pds 115 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_timer19: timer@2530000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x2530000 0x00 0x400>;
-		interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 116 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 116 2>;
-		assigned-clock-parents = <&k3_clks 116 3>;
-		power-domains = <&k3_pds 116 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-	};
-
-	main_uart0: serial@2800000 {
-		compatible = "ti,j721e-uart", "ti,am654-uart";
-		reg = <0x00 0x02800000 0x00 0x200>;
-		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 146 0>;
-		clock-names = "fclk";
-		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_uart1: serial@2810000 {
-		compatible = "ti,j721e-uart", "ti,am654-uart";
-		reg = <0x00 0x02810000 0x00 0x200>;
-		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 388 0>;
-		clock-names = "fclk";
-		power-domains = <&k3_pds 388 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_uart2: serial@2820000 {
-		compatible = "ti,j721e-uart", "ti,am654-uart";
-		reg = <0x00 0x02820000 0x00 0x200>;
-		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 389 0>;
-		clock-names = "fclk";
-		power-domains = <&k3_pds 389 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_uart3: serial@2830000 {
-		compatible = "ti,j721e-uart", "ti,am654-uart";
-		reg = <0x00 0x02830000 0x00 0x200>;
-		interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 390 0>;
-		clock-names = "fclk";
-		power-domains = <&k3_pds 390 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_uart4: serial@2840000 {
-		compatible = "ti,j721e-uart", "ti,am654-uart";
-		reg = <0x00 0x02840000 0x00 0x200>;
-		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 391 0>;
-		clock-names = "fclk";
-		power-domains = <&k3_pds 391 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_uart5: serial@2850000 {
-		compatible = "ti,j721e-uart", "ti,am654-uart";
-		reg = <0x00 0x02850000 0x00 0x200>;
-		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 392 0>;
-		clock-names = "fclk";
-		power-domains = <&k3_pds 392 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_uart6: serial@2860000 {
-		compatible = "ti,j721e-uart", "ti,am654-uart";
-		reg = <0x00 0x02860000 0x00 0x200>;
-		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 393 0>;
-		clock-names = "fclk";
-		power-domains = <&k3_pds 393 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_uart7: serial@2870000 {
-		compatible = "ti,j721e-uart", "ti,am654-uart";
-		reg = <0x00 0x02870000 0x00 0x200>;
-		interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 394 0>;
-		clock-names = "fclk";
-		power-domains = <&k3_pds 394 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_uart8: serial@2880000 {
-		compatible = "ti,j721e-uart", "ti,am654-uart";
-		reg = <0x00 0x02880000 0x00 0x200>;
-		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 395 0>;
-		clock-names = "fclk";
-		power-domains = <&k3_pds 395 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_uart9: serial@2890000 {
-		compatible = "ti,j721e-uart", "ti,am654-uart";
-		reg = <0x00 0x02890000 0x00 0x200>;
-		interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 396 0>;
-		clock-names = "fclk";
-		power-domains = <&k3_pds 396 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_gpio0: gpio@600000 {
-		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
-		reg = <0x00 0x00600000 0x00 0x100>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <145>, <146>, <147>, <148>, <149>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		ti,ngpio = <66>;
-		ti,davinci-gpio-unbanked = <0>;
-		power-domains = <&k3_pds 163 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 163 0>;
-		clock-names = "gpio";
-		status = "disabled";
-	};
-
-	main_gpio2: gpio@610000 {
-		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
-		reg = <0x00 0x00610000 0x00 0x100>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <154>, <155>, <156>, <157>, <158>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		ti,ngpio = <66>;
-		ti,davinci-gpio-unbanked = <0>;
-		power-domains = <&k3_pds 164 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 164 0>;
-		clock-names = "gpio";
-		status = "disabled";
-	};
-
-	main_gpio4: gpio@620000 {
-		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
-		reg = <0x00 0x00620000 0x00 0x100>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <163>, <164>, <165>, <166>, <167>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		ti,ngpio = <66>;
-		ti,davinci-gpio-unbanked = <0>;
-		power-domains = <&k3_pds 165 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 165 0>;
-		clock-names = "gpio";
-		status = "disabled";
-	};
-
-	main_gpio6: gpio@630000 {
-		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
-		reg = <0x00 0x00630000 0x00 0x100>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <172>, <173>, <174>, <175>, <176>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		ti,ngpio = <66>;
-		ti,davinci-gpio-unbanked = <0>;
-		power-domains = <&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 166 0>;
-		clock-names = "gpio";
-		status = "disabled";
-	};
-
-	usbss0: usb@4104000 {
-		bootph-all;
-		compatible = "ti,j721e-usb";
-		reg = <0x00 0x4104000 0x00 0x100>;
-		dma-coherent;
-		power-domains = <&k3_pds 398 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 398 21>, <&k3_clks 398 2>;
-		clock-names = "ref", "lpm";
-		assigned-clocks = <&k3_clks 398 21>;    /* USB2_REFCLK */
-		assigned-clock-parents = <&k3_clks 398 22>; /* HFOSC0 */
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		status = "disabled"; /* Needs lane config */
-
-		usb0: usb@6000000 {
-			bootph-all;
-			compatible = "cdns,usb3";
-			reg = <0x00 0x6000000 0x00 0x10000>,
-			      <0x00 0x6010000 0x00 0x10000>,
-			      <0x00 0x6020000 0x00 0x10000>;
-			reg-names = "otg", "xhci", "dev";
-			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,  /* irq.0 */
-				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>, /* irq.6 */
-				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>; /* otgirq.0 */
-			interrupt-names = "host",
-					  "peripheral",
-					  "otg";
-		};
-	};
-
-	main_i2c0: i2c@2000000 {
-		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
-		reg = <0x00 0x02000000 0x00 0x100>;
-		interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&k3_clks 270 2>;
-		clock-names = "fck";
-		power-domains = <&k3_pds 270 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_i2c1: i2c@2010000 {
-		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
-		reg = <0x00 0x02010000 0x00 0x100>;
-		interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&k3_clks 271 2>;
-		clock-names = "fck";
-		power-domains = <&k3_pds 271 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_i2c2: i2c@2020000 {
-		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
-		reg = <0x00 0x02020000 0x00 0x100>;
-		interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&k3_clks 272 2>;
-		clock-names = "fck";
-		power-domains = <&k3_pds 272 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_i2c3: i2c@2030000 {
-		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
-		reg = <0x00 0x02030000 0x00 0x100>;
-		interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&k3_clks 273 2>;
-		clock-names = "fck";
-		power-domains = <&k3_pds 273 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_i2c4: i2c@2040000 {
-		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
-		reg = <0x00 0x02040000 0x00 0x100>;
-		interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&k3_clks 274 2>;
-		clock-names = "fck";
-		power-domains = <&k3_pds 274 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_i2c5: i2c@2050000 {
-		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
-		reg = <0x00 0x02050000 0x00 0x100>;
-		interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&k3_clks 275 2>;
-		clock-names = "fck";
-		power-domains = <&k3_pds 275 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	main_i2c6: i2c@2060000 {
-		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
-		reg = <0x00 0x02060000 0x00 0x100>;
-		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&k3_clks 276 2>;
-		clock-names = "fck";
-		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	ti_csi2rx0: ticsi2rx@4500000 {
-		compatible = "ti,j721e-csi2rx-shim";
-		reg = <0x00 0x04500000 0x00 0x00001000>;
-		ranges;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		dmas = <&main_bcdma_csi 0 0x4940 0>;
-		dma-names = "rx0";
-		power-domains = <&k3_pds 72 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-
-		cdns_csi2rx0: csi-bridge@4504000 {
-			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
-			reg = <0x00 0x04504000 0x00 0x00001000>;
-			clocks = <&k3_clks 72 2>, <&k3_clks 72 0>, <&k3_clks 72 2>,
-				<&k3_clks 72 2>, <&k3_clks 72 3>, <&k3_clks 72 3>;
-			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
-				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
-			phys = <&dphy0>;
-			phy-names = "dphy";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				csi0_port0: port@0 {
-					reg = <0>;
-					status = "disabled";
-				};
-
-				csi0_port1: port@1 {
-					reg = <1>;
-					status = "disabled";
-				};
-
-				csi0_port2: port@2 {
-					reg = <2>;
-					status = "disabled";
-				};
-
-				csi0_port3: port@3 {
-					reg = <3>;
-					status = "disabled";
-				};
-
-				csi0_port4: port@4 {
-					reg = <4>;
-					status = "disabled";
-				};
-			};
-		};
-	};
-
-	ti_csi2rx1: ticsi2rx@4510000 {
-		compatible = "ti,j721e-csi2rx-shim";
-		reg = <0x00 0x04510000 0x00 0x1000>;
-		ranges;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		dmas = <&main_bcdma_csi 0 0x4960 0>;
-		dma-names = "rx0";
-		power-domains = <&k3_pds 73 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-
-		cdns_csi2rx1: csi-bridge@4514000 {
-			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
-			reg = <0x00 0x04514000 0x00 0x00001000>;
-			clocks = <&k3_clks 73 2>, <&k3_clks 73 0>, <&k3_clks 73 2>,
-				<&k3_clks 73 2>, <&k3_clks 73 3>, <&k3_clks 73 3>;
-			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
-				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
-			phys = <&dphy1>;
-			phy-names = "dphy";
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				csi1_port0: port@0 {
-					reg = <0>;
-					status = "disabled";
-				};
-
-				csi1_port1: port@1 {
-					reg = <1>;
-					status = "disabled";
-				};
-
-				csi1_port2: port@2 {
-					reg = <2>;
-					status = "disabled";
-				};
-
-				csi1_port3: port@3 {
-					reg = <3>;
-					status = "disabled";
-				};
-
-				csi1_port4: port@4 {
-					reg = <4>;
-					status = "disabled";
-				};
-			};
-		};
-	};
-
-	ti_csi2rx2: ticsi2rx@4520000 {
-		compatible = "ti,j721e-csi2rx-shim";
-		reg = <0x00 0x04520000 0x00 0x00001000>;
-		ranges;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		dmas = <&main_bcdma_csi 0 0x4980 0>;
-		dma-names = "rx0";
-		power-domains = <&k3_pds 74 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-
-		cdns_csi2rx2: csi-bridge@4524000 {
-			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
-			reg = <0x00 0x04524000 0x00 0x00001000>;
-			clocks = <&k3_clks 74 2>, <&k3_clks 74 0>, <&k3_clks 74 2>,
-				<&k3_clks 74 2>, <&k3_clks 74 3>, <&k3_clks 74 3>;
-			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
-				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
-			phys = <&dphy2>;
-			phy-names = "dphy";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				csi2_port0: port@0 {
-					reg = <0>;
-					status = "disabled";
-				};
-
-				csi2_port1: port@1 {
-					reg = <1>;
-					status = "disabled";
-				};
-
-				csi2_port2: port@2 {
-					reg = <2>;
-					status = "disabled";
-				};
-
-				csi2_port3: port@3 {
-					reg = <3>;
-					status = "disabled";
-				};
-
-				csi2_port4: port@4 {
-					reg = <4>;
-					status = "disabled";
-				};
-			};
-		};
-	};
-
-	dphy0: phy@4580000 {
-		compatible = "cdns,dphy-rx";
-		reg = <0x00 0x04580000 0x00 0x00001100>;
-		#phy-cells = <0>;
-		power-domains = <&k3_pds 212 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	dphy1: phy@4590000 {
-		compatible = "cdns,dphy-rx";
-		reg = <0x00 0x04590000 0x00 0x00001100>;
-		#phy-cells = <0>;
-		power-domains = <&k3_pds 213 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	dphy2: phy@45a0000 {
-		compatible = "cdns,dphy-rx";
-		reg = <0x00 0x045a0000 0x00 0x00001100>;
-		#phy-cells = <0>;
-		power-domains = <&k3_pds 214 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	vpu0: video-codec@4210000 {
-		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
-		reg = <0x00 0x4210000 0x00 0x10000>;
-		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 241 2>;
-		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
-	};
-
-	vpu1: video-codec@4220000 {
-		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
-		reg = <0x00 0x4220000 0x00 0x10000>;
-		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 242 2>;
-		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
-	};
-
-	main_sdhci0: mmc@4f80000 {
-		compatible = "ti,j721e-sdhci-8bit";
-		reg = <0x00 0x04f80000 0x00 0x1000>,
-		      <0x00 0x04f88000 0x00 0x400>;
-		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-		power-domains = <&k3_pds 140 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 140 1>, <&k3_clks 140 2>;
-		clock-names = "clk_ahb", "clk_xin";
-		assigned-clocks = <&k3_clks 140 2>;
-		assigned-clock-parents = <&k3_clks 140 3>;
-		bus-width = <8>;
-		ti,otap-del-sel-legacy = <0x0>;
-		ti,otap-del-sel-mmc-hs = <0x0>;
-		ti,otap-del-sel-ddr52 = <0x6>;
-		ti,otap-del-sel-hs200 = <0x8>;
-		ti,otap-del-sel-hs400 = <0x5>;
-		ti,itap-del-sel-legacy = <0x10>;
-		ti,itap-del-sel-mmc-hs = <0xa>;
-		ti,strobe-sel = <0x77>;
-		ti,clkbuf-sel = <0x7>;
-		ti,trm-icp = <0x8>;
-		mmc-ddr-1_8v;
-		mmc-hs200-1_8v;
-		mmc-hs400-1_8v;
-		dma-coherent;
-		status = "disabled";
-	};
-
-	main_sdhci1: mmc@4fb0000 {
-		compatible = "ti,j721e-sdhci-4bit";
-		reg = <0x00 0x04fb0000 0x00 0x1000>,
-		      <0x00 0x04fb8000 0x00 0x400>;
-		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-		power-domains = <&k3_pds 141 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 141 3>, <&k3_clks 141 4>;
-		clock-names = "clk_ahb", "clk_xin";
-		assigned-clocks = <&k3_clks 141 4>;
-		assigned-clock-parents = <&k3_clks 141 5>;
-		bus-width = <4>;
-		ti,otap-del-sel-legacy = <0x0>;
-		ti,otap-del-sel-sd-hs = <0x0>;
-		ti,otap-del-sel-sdr12 = <0xf>;
-		ti,otap-del-sel-sdr25 = <0xf>;
-		ti,otap-del-sel-sdr50 = <0xc>;
-		ti,otap-del-sel-sdr104 = <0x5>;
-		ti,otap-del-sel-ddr50 = <0xc>;
-		ti,itap-del-sel-legacy = <0x0>;
-		ti,itap-del-sel-sd-hs = <0x0>;
-		ti,itap-del-sel-sdr12 = <0x0>;
-		ti,itap-del-sel-sdr25 = <0x0>;
-		ti,itap-del-sel-ddr50 = <0x2>;
-		ti,clkbuf-sel = <0x7>;
-		ti,trm-icp = <0x8>;
-		dma-coherent;
-		status = "disabled";
-	};
-
-	pcie0_rc: pcie@2900000 {
-		compatible = "ti,j784s4-pcie-host";
-		reg = <0x00 0x02900000 0x00 0x1000>,
-		      <0x00 0x02907000 0x00 0x400>,
-		      <0x00 0x0d000000 0x00 0x00800000>,
-		      <0x00 0x10000000 0x00 0x00001000>;
-		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
-		interrupt-names = "link_state";
-		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
-		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x0>;
-		max-link-speed = <3>;
-		num-lanes = <4>;
-		power-domains = <&k3_pds 332 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 332 0>;
-		clock-names = "fck";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		bus-range = <0x0 0xff>;
-		vendor-id = <0x104c>;
-		device-id = <0xb012>;
-		msi-map = <0x0 &gic_its 0x0 0x10000>;
-		dma-coherent;
-		ranges = <0x01000000 0x0 0x10001000 0x0 0x10001000 0x0 0x0010000>,
-			 <0x02000000 0x0 0x10011000 0x0 0x10011000 0x0 0x7fef000>;
-		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
-		status = "disabled";
-	};
-
-	pcie1_rc: pcie@2910000 {
-		compatible = "ti,j784s4-pcie-host";
-		reg = <0x00 0x02910000 0x00 0x1000>,
-		      <0x00 0x02917000 0x00 0x400>,
-		      <0x00 0x0d800000 0x00 0x00800000>,
-		      <0x00 0x18000000 0x00 0x00001000>;
-		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
-		interrupt-names = "link_state";
-		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
-		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&pcie1_ctrl 0x0>;
-		max-link-speed = <3>;
-		num-lanes = <4>;
-		power-domains = <&k3_pds 333 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 333 0>;
-		clock-names = "fck";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		bus-range = <0x0 0xff>;
-		vendor-id = <0x104c>;
-		device-id = <0xb012>;
-		msi-map = <0x0 &gic_its 0x10000 0x10000>;
-		dma-coherent;
-		ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
-			 <0x02000000 0x0 0x18011000  0x00 0x18011000  0x0 0x7fef000>;
-		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
-		status = "disabled";
-	};
-
-	pcie2_rc: pcie@2920000 {
-		compatible = "ti,j784s4-pcie-host";
-		reg = <0x00 0x02920000 0x00 0x1000>,
-		      <0x00 0x02927000 0x00 0x400>,
-		      <0x00 0x0e000000 0x00 0x00800000>,
-		      <0x44 0x00000000 0x00 0x00001000>;
-		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
-		interrupt-names = "link_state";
-		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
-		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&pcie2_ctrl 0x0>;
-		max-link-speed = <3>;
-		num-lanes = <2>;
-		power-domains = <&k3_pds 334 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 334 0>;
-		clock-names = "fck";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		bus-range = <0x0 0xff>;
-		vendor-id = <0x104c>;
-		device-id = <0xb012>;
-		msi-map = <0x0 &gic_its 0x20000 0x10000>;
-		dma-coherent;
-		ranges = <0x01000000 0x0 0x00001000 0x44 0x00001000 0x0 0x0010000>,
-			 <0x02000000 0x0 0x00011000 0x44 0x00011000 0x0 0x7fef000>;
-		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
-		status = "disabled";
-	};
-
-	pcie3_rc: pcie@2930000 {
-		compatible = "ti,j784s4-pcie-host";
-		reg = <0x00 0x02930000 0x00 0x1000>,
-		      <0x00 0x02937000 0x00 0x400>,
-		      <0x00 0x0e800000 0x00 0x00800000>,
-		      <0x44 0x10000000 0x00 0x00001000>;
-		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
-		interrupt-names = "link_state";
-		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
-		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&pcie3_ctrl 0x0>;
-		max-link-speed = <3>;
-		num-lanes = <2>;
-		power-domains = <&k3_pds 335 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 335 0>;
-		clock-names = "fck";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		bus-range = <0x0 0xff>;
-		vendor-id = <0x104c>;
-		device-id = <0xb012>;
-		msi-map = <0x0 &gic_its 0x30000 0x10000>;
-		dma-coherent;
-		ranges = <0x01000000 0x0 0x00001000 0x44 0x10001000 0x0 0x0010000>,
-			 <0x02000000 0x0 0x00011000 0x44 0x10011000 0x0 0x7fef000>;
-		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
-		status = "disabled";
-	};
-
-	serdes_wiz0: wiz@5060000 {
-		compatible = "ti,j784s4-wiz-10g";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		power-domains = <&k3_pds 404 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 404 2>, <&k3_clks 404 6>, <&serdes_refclk>, <&k3_clks 404 5>;
-		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
-		assigned-clocks = <&k3_clks 404 6>;
-		assigned-clock-parents = <&k3_clks 404 10>;
-		num-lanes = <4>;
-		#reset-cells = <1>;
-		#clock-cells = <1>;
-		ranges = <0x5060000 0x00 0x5060000 0x10000>;
-		status = "disabled";
-
-		serdes0: serdes@5060000 {
-			compatible = "ti,j721e-serdes-10g";
-			reg = <0x05060000 0x010000>;
-			reg-names = "torrent_phy";
-			resets = <&serdes_wiz0 0>;
-			reset-names = "torrent_reset";
-			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
-				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
-			clock-names = "refclk", "phy_en_refclk";
-			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
-					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
-					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
-			assigned-clock-parents = <&k3_clks 404 6>,
-						 <&k3_clks 404 6>,
-						 <&k3_clks 404 6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#clock-cells = <1>;
-			status = "disabled";
-		};
-	};
-
-	serdes_wiz1: wiz@5070000 {
-		compatible = "ti,j784s4-wiz-10g";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		power-domains = <&k3_pds 405 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 405 2>, <&k3_clks 405 6>, <&serdes_refclk>, <&k3_clks 405 5>;
-		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
-		assigned-clocks = <&k3_clks 405 6>;
-		assigned-clock-parents = <&k3_clks 405 10>;
-		num-lanes = <4>;
-		#reset-cells = <1>;
-		#clock-cells = <1>;
-		ranges = <0x05070000 0x00 0x05070000 0x10000>;
-		status = "disabled";
-
-		serdes1: serdes@5070000 {
-			compatible = "ti,j721e-serdes-10g";
-			reg = <0x05070000 0x010000>;
-			reg-names = "torrent_phy";
-			resets = <&serdes_wiz1 0>;
-			reset-names = "torrent_reset";
-			clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
-				 <&serdes_wiz1 TI_WIZ_PHY_EN_REFCLK>;
-			clock-names = "refclk", "phy_en_refclk";
-			assigned-clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
-					  <&serdes_wiz1 TI_WIZ_PLL1_REFCLK>,
-					  <&serdes_wiz1 TI_WIZ_REFCLK_DIG>;
-			assigned-clock-parents = <&k3_clks 405 6>,
-						 <&k3_clks 405 6>,
-						 <&k3_clks 405 6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#clock-cells = <1>;
-			status = "disabled";
-		};
-	};
-
-	serdes_wiz2: wiz@5020000 {
-		compatible = "ti,j784s4-wiz-10g";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		power-domains = <&k3_pds 406 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 406 2>, <&k3_clks 406 6>, <&serdes_refclk>, <&k3_clks 406 5>;
-		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
-		assigned-clocks = <&k3_clks 406 6>;
-		assigned-clock-parents = <&k3_clks 406 10>;
-		num-lanes = <4>;
-		#reset-cells = <1>;
-		#clock-cells = <1>;
-		ranges = <0x05020000 0x00 0x05020000 0x10000>;
-		status = "disabled";
-
-		serdes2: serdes@5020000 {
-			compatible = "ti,j721e-serdes-10g";
-			reg = <0x05020000 0x010000>;
-			reg-names = "torrent_phy";
-			resets = <&serdes_wiz2 0>;
-			reset-names = "torrent_reset";
-			clocks = <&serdes_wiz2 TI_WIZ_PLL0_REFCLK>,
-				 <&serdes_wiz2 TI_WIZ_PHY_EN_REFCLK>;
-			clock-names = "refclk", "phy_en_refclk";
-			assigned-clocks = <&serdes_wiz2 TI_WIZ_PLL0_REFCLK>,
-					  <&serdes_wiz2 TI_WIZ_PLL1_REFCLK>,
-					  <&serdes_wiz2 TI_WIZ_REFCLK_DIG>;
-			assigned-clock-parents = <&k3_clks 406 6>,
-						 <&k3_clks 406 6>,
-						 <&k3_clks 406 6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#clock-cells = <1>;
-			status = "disabled";
-		};
-	};
-
-	serdes_wiz4: wiz@5050000 {
-		compatible = "ti,j784s4-wiz-10g";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		power-domains = <&k3_pds 407 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 407 2>, <&k3_clks 407 6>, <&serdes_refclk>, <&k3_clks 407 5>;
-		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
-		assigned-clocks = <&k3_clks 407 6>;
-		assigned-clock-parents = <&k3_clks 407 10>;
-		num-lanes = <4>;
-		#reset-cells = <1>;
-		#clock-cells = <1>;
-		ranges = <0x05050000 0x00 0x05050000 0x10000>,
-			 <0xa030a00 0x00 0xa030a00 0x40>; /* DPTX PHY */
-		status = "disabled";
-
-		serdes4: serdes@5050000 {
-			/*
-			 * Note: we also map DPTX PHY registers as the Torrent
-			 * needs to manage those.
-			 */
-			compatible = "ti,j721e-serdes-10g";
-			reg = <0x05050000 0x010000>,
-			      <0x0a030a00 0x40>; /* DPTX PHY */
-			reg-names = "torrent_phy";
-			resets = <&serdes_wiz4 0>;
-			reset-names = "torrent_reset";
-			clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>,
-				 <&serdes_wiz4 TI_WIZ_PHY_EN_REFCLK>;
-			clock-names = "refclk", "phy_en_refclk";
-			assigned-clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>,
-					  <&serdes_wiz4 TI_WIZ_PLL1_REFCLK>,
-					  <&serdes_wiz4 TI_WIZ_REFCLK_DIG>;
-			assigned-clock-parents = <&k3_clks 407 6>,
-						 <&k3_clks 407 6>,
-						 <&k3_clks 407 6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#clock-cells = <1>;
-			status = "disabled";
-		};
-	};
-
-	main_navss: bus@30000000 {
-		bootph-all;
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
-		ti,sci-dev-id = <280>;
-		dma-coherent;
-		dma-ranges;
-
-		main_navss_intr: interrupt-controller@310e0000 {
-			compatible = "ti,sci-intr";
-			reg = <0x00 0x310e0000 0x00 0x4000>;
-			ti,intr-trigger-type = <4>;
-			interrupt-controller;
-			interrupt-parent = <&gic500>;
-			#interrupt-cells = <1>;
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <283>;
-			ti,interrupt-ranges = <0 64 64>,
-					      <64 448 64>,
-					      <128 672 64>;
-		};
-
-		main_udmass_inta: msi-controller@33d00000 {
-			compatible = "ti,sci-inta";
-			reg = <0x00 0x33d00000 0x00 0x100000>;
-			interrupt-controller;
-			#interrupt-cells = <0>;
-			interrupt-parent = <&main_navss_intr>;
-			msi-controller;
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <321>;
-			ti,interrupt-ranges = <0 0 256>;
-			ti,unmapped-event-sources = <&main_bcdma_csi>;
-		};
-
-		secure_proxy_main: mailbox@32c00000 {
-			bootph-all;
-			compatible = "ti,am654-secure-proxy";
-			#mbox-cells = <1>;
-			reg-names = "target_data", "rt", "scfg";
-			reg = <0x00 0x32c00000 0x00 0x100000>,
-			      <0x00 0x32400000 0x00 0x100000>,
-			      <0x00 0x32800000 0x00 0x100000>;
-			interrupt-names = "rx_011";
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		hwspinlock: hwlock@30e00000 {
-			compatible = "ti,am654-hwspinlock";
-			reg = <0x00 0x30e00000 0x00 0x1000>;
-			#hwlock-cells = <1>;
-		};
-
-		mailbox0_cluster0: mailbox@31f80000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f80000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox0_cluster1: mailbox@31f81000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f81000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox0_cluster2: mailbox@31f82000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f82000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox0_cluster3: mailbox@31f83000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f83000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox0_cluster4: mailbox@31f84000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f84000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox0_cluster5: mailbox@31f85000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f85000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox0_cluster6: mailbox@31f86000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f86000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox0_cluster7: mailbox@31f87000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f87000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox0_cluster8: mailbox@31f88000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f88000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox0_cluster9: mailbox@31f89000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f89000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox0_cluster10: mailbox@31f8a000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f8a000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox0_cluster11: mailbox@31f8b000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f8b000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox1_cluster0: mailbox@31f90000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f90000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox1_cluster1: mailbox@31f91000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f91000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox1_cluster2: mailbox@31f92000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f92000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox1_cluster3: mailbox@31f93000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f93000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox1_cluster4: mailbox@31f94000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f94000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox1_cluster5: mailbox@31f95000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f95000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox1_cluster6: mailbox@31f96000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f96000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox1_cluster7: mailbox@31f97000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f97000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox1_cluster8: mailbox@31f98000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f98000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox1_cluster9: mailbox@31f99000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f99000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox1_cluster10: mailbox@31f9a000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f9a000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		mailbox1_cluster11: mailbox@31f9b000 {
-			compatible = "ti,am654-mailbox";
-			reg = <0x00 0x31f9b000 0x00 0x200>;
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <16>;
-			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
-		};
-
-		main_ringacc: ringacc@3c000000 {
-			compatible = "ti,am654-navss-ringacc";
-			reg = <0x00 0x3c000000 0x00 0x400000>,
-			      <0x00 0x38000000 0x00 0x400000>,
-			      <0x00 0x31120000 0x00 0x100>,
-			      <0x00 0x33000000 0x00 0x40000>,
-			      <0x00 0x31080000 0x00 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
-			ti,num-rings = <1024>;
-			ti,sci-rm-range-gp-rings = <0x1>;
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <315>;
-			msi-parent = <&main_udmass_inta>;
-		};
-
-		main_udmap: dma-controller@31150000 {
-			compatible = "ti,j721e-navss-main-udmap";
-			reg = <0x00 0x31150000 0x00 0x100>,
-			      <0x00 0x34000000 0x00 0x80000>,
-			      <0x00 0x35000000 0x00 0x200000>,
-			      <0x00 0x30b00000 0x00 0x20000>,
-			      <0x00 0x30c00000 0x00 0x8000>,
-			      <0x00 0x30d00000 0x00 0x4000>;
-			reg-names = "gcfg", "rchanrt", "tchanrt",
-				    "tchan", "rchan", "rflow";
-			msi-parent = <&main_udmass_inta>;
-			#dma-cells = <1>;
-
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <319>;
-			ti,ringacc = <&main_ringacc>;
-
-			ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
-						<0x0f>, /* TX_HCHAN */
-						<0x10>; /* TX_UHCHAN */
-			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
-						<0x0b>, /* RX_HCHAN */
-						<0x0c>; /* RX_UHCHAN */
-			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
-		};
-
-		main_bcdma_csi: dma-controller@311a0000 {
-			compatible = "ti,j721s2-dmss-bcdma-csi";
-			reg = <0x00 0x311a0000 0x00 0x100>,
-			      <0x00 0x35d00000 0x00 0x20000>,
-			      <0x00 0x35c00000 0x00 0x10000>,
-			      <0x00 0x35e00000 0x00 0x80000>;
-			reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
-			msi-parent = <&main_udmass_inta>;
-			#dma-cells = <3>;
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <281>;
-			ti,sci-rm-range-rchan = <0x21>;
-			ti,sci-rm-range-tchan = <0x22>;
-		};
-
-		cpts@310d0000 {
-			compatible = "ti,j721e-cpts";
-			reg = <0x00 0x310d0000 0x00 0x400>;
-			reg-names = "cpts";
-			clocks = <&k3_clks 282 0>;
-			clock-names = "cpts";
-			assigned-clocks = <&k3_clks 62 3>; /* CPTS_RFT_CLK */
-			assigned-clock-parents = <&k3_clks 62 5>; /* MAIN_0_HSDIV6_CLK */
-			interrupts-extended = <&main_navss_intr 391>;
-			interrupt-names = "cpts";
-			ti,cpts-periodic-outputs = <6>;
-			ti,cpts-ext-ts-inputs = <8>;
-		};
-	};
-
-	main_cpsw0: ethernet@c000000 {
-		compatible = "ti,j784s4-cpswxg-nuss";
-		reg = <0x00 0xc000000 0x00 0x200000>;
-		reg-names = "cpsw_nuss";
-		ranges = <0x00 0x00 0x00 0xc000000 0x00 0x200000>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		dma-coherent;
-		clocks = <&k3_clks 64 0>;
-		clock-names = "fck";
-		power-domains = <&k3_pds 64 TI_SCI_PD_EXCLUSIVE>;
-
-		dmas = <&main_udmap 0xca00>,
-		       <&main_udmap 0xca01>,
-		       <&main_udmap 0xca02>,
-		       <&main_udmap 0xca03>,
-		       <&main_udmap 0xca04>,
-		       <&main_udmap 0xca05>,
-		       <&main_udmap 0xca06>,
-		       <&main_udmap 0xca07>,
-		       <&main_udmap 0x4a00>;
-		dma-names = "tx0", "tx1", "tx2", "tx3",
-			    "tx4", "tx5", "tx6", "tx7",
-			    "rx";
-
-		status = "disabled";
-
-		ethernet-ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			main_cpsw0_port1: port@1 {
-				reg = <1>;
-				label = "port1";
-				ti,mac-only;
-				status = "disabled";
-			};
-
-			main_cpsw0_port2: port@2 {
-				reg = <2>;
-				label = "port2";
-				ti,mac-only;
-				status = "disabled";
-			};
-
-			main_cpsw0_port3: port@3 {
-				reg = <3>;
-				label = "port3";
-				ti,mac-only;
-				status = "disabled";
-			};
-
-			main_cpsw0_port4: port@4 {
-				reg = <4>;
-				label = "port4";
-				ti,mac-only;
-				status = "disabled";
-			};
-
-			main_cpsw0_port5: port@5 {
-				reg = <5>;
-				label = "port5";
-				ti,mac-only;
-				status = "disabled";
-			};
-
-			main_cpsw0_port6: port@6 {
-				reg = <6>;
-				label = "port6";
-				ti,mac-only;
-				status = "disabled";
-			};
-
-			main_cpsw0_port7: port@7 {
-				reg = <7>;
-				label = "port7";
-				ti,mac-only;
-				status = "disabled";
-			};
-
-			main_cpsw0_port8: port@8 {
-				reg = <8>;
-				label = "port8";
-				ti,mac-only;
-				status = "disabled";
-			};
-		};
-
-		main_cpsw0_mdio: mdio@f00 {
-			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
-			reg = <0x00 0xf00 0x00 0x100>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&k3_clks 64 0>;
-			clock-names = "fck";
-			bus_freq = <1000000>;
-			status = "disabled";
-		};
-
-		cpts@3d000 {
-			compatible = "ti,am65-cpts";
-			reg = <0x00 0x3d000 0x00 0x400>;
-			clocks = <&k3_clks 64 3>;
-			clock-names = "cpts";
-			interrupts-extended = <&gic500 GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "cpts";
-			ti,cpts-ext-ts-inputs = <4>;
-			ti,cpts-periodic-outputs = <2>;
-		};
-	};
-
-	main_cpsw1: ethernet@c200000 {
-		compatible = "ti,j721e-cpsw-nuss";
-		reg = <0x00 0xc200000 0x00 0x200000>;
-		reg-names = "cpsw_nuss";
-		ranges = <0x00 0x00 0x00 0xc200000 0x00 0x200000>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		dma-coherent;
-		clocks = <&k3_clks 62 0>;
-		clock-names = "fck";
-		power-domains = <&k3_pds 62 TI_SCI_PD_EXCLUSIVE>;
-
-		dmas = <&main_udmap 0xc640>,
-			<&main_udmap 0xc641>,
-			<&main_udmap 0xc642>,
-			<&main_udmap 0xc643>,
-			<&main_udmap 0xc644>,
-			<&main_udmap 0xc645>,
-			<&main_udmap 0xc646>,
-			<&main_udmap 0xc647>,
-			<&main_udmap 0x4640>;
-		dma-names = "tx0", "tx1", "tx2", "tx3",
-				"tx4", "tx5", "tx6", "tx7",
-				"rx";
-
-		status = "disabled";
-
-		ethernet-ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			main_cpsw1_port1: port@1 {
-				reg = <1>;
-				label = "port1";
-				phys = <&cpsw1_phy_gmii_sel 1>;
-				ti,mac-only;
-				status = "disabled";
-			};
-		};
-
-		main_cpsw1_mdio: mdio@f00 {
-			compatible = "ti,cpsw-mdio", "ti,davinci_mdio";
-			reg = <0x00 0xf00 0x00 0x100>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&k3_clks 62 0>;
-			clock-names = "fck";
-			bus_freq = <1000000>;
-			status = "disabled";
-		};
-
-		cpts@3d000 {
-			compatible = "ti,am65-cpts";
-			reg = <0x00 0x3d000 0x00 0x400>;
-			clocks = <&k3_clks 62 3>;
-			clock-names = "cpts";
-			interrupts-extended = <&gic500 GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "cpts";
-			ti,cpts-ext-ts-inputs = <4>;
-			ti,cpts-periodic-outputs = <2>;
-		};
-	};
-
-	main_mcan0: can@2701000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x02701000 0x00 0x200>,
-		      <0x00 0x02708000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 245 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 245 6>, <&k3_clks 245 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan1: can@2711000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x02711000 0x00 0x200>,
-		      <0x00 0x02718000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 246 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 246 6>, <&k3_clks 246 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan2: can@2721000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x02721000 0x00 0x200>,
-		      <0x00 0x02728000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 247 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 247 6>, <&k3_clks 247 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan3: can@2731000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x02731000 0x00 0x200>,
-		      <0x00 0x02738000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 248 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 248 6>, <&k3_clks 248 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan4: can@2741000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x02741000 0x00 0x200>,
-		      <0x00 0x02748000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 249 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 249 6>, <&k3_clks 249 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan5: can@2751000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x02751000 0x00 0x200>,
-		      <0x00 0x02758000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 250 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 250 6>, <&k3_clks 250 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan6: can@2761000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x02761000 0x00 0x200>,
-		      <0x00 0x02768000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 251 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 251 6>, <&k3_clks 251 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan7: can@2771000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x02771000 0x00 0x200>,
-		      <0x00 0x02778000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 252 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 252 6>, <&k3_clks 252 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan8: can@2781000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x02781000 0x00 0x200>,
-		      <0x00 0x02788000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 253 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 253 6>, <&k3_clks 253 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan9: can@2791000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x02791000 0x00 0x200>,
-		      <0x00 0x02798000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 254 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 254 6>, <&k3_clks 254 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 579 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan10: can@27a1000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x027a1000 0x00 0x200>,
-		      <0x00 0x027a8000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 255 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 255 6>, <&k3_clks 255 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan11: can@27b1000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x027b1000 0x00 0x200>,
-		      <0x00 0x027b8000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 256 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 256 6>, <&k3_clks 256 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan12: can@27c1000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x027c1000 0x00 0x200>,
-		      <0x00 0x027c8000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 257 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 257 6>, <&k3_clks 257 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan13: can@27d1000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x027d1000 0x00 0x200>,
-		      <0x00 0x027d8000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 258 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 258 6>, <&k3_clks 258 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan14: can@2681000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x02681000 0x00 0x200>,
-		      <0x00 0x02688000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 259 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 259 6>, <&k3_clks 259 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan15: can@2691000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x02691000 0x00 0x200>,
-		      <0x00 0x02698000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 260 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 260 6>, <&k3_clks 260 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan16: can@26a1000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x026a1000 0x00 0x200>,
-		      <0x00 0x026a8000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 261 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 261 6>, <&k3_clks 261 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 784 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 785 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_mcan17: can@26b1000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x026b1000 0x00 0x200>,
-		      <0x00 0x026b8000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 262 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 262 6>, <&k3_clks 262 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 787 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 788 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	main_spi0: spi@2100000 {
-		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
-		reg = <0x00 0x02100000 0x00 0x400>;
-		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		power-domains = <&k3_pds 376 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 376 1>;
-		status = "disabled";
-	};
-
-	main_spi1: spi@2110000 {
-		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
-		reg = <0x00 0x02110000 0x00 0x400>;
-		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		power-domains = <&k3_pds 377 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 377 1>;
-		status = "disabled";
-	};
-
-	main_spi2: spi@2120000 {
-		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
-		reg = <0x00 0x02120000 0x00 0x400>;
-		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		power-domains = <&k3_pds 378 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 378 1>;
-		status = "disabled";
-	};
-
-	main_spi3: spi@2130000 {
-		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
-		reg = <0x00 0x02130000 0x00 0x400>;
-		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		power-domains = <&k3_pds 379 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 379 1>;
-		status = "disabled";
-	};
-
-	main_spi4: spi@2140000 {
-		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
-		reg = <0x00 0x02140000 0x00 0x400>;
-		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		power-domains = <&k3_pds 380 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 380 1>;
-		status = "disabled";
-	};
-
-	main_spi5: spi@2150000 {
-		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
-		reg = <0x00 0x02150000 0x00 0x400>;
-		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		power-domains = <&k3_pds 381 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 381 1>;
-		status = "disabled";
-	};
-
-	main_spi6: spi@2160000 {
-		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
-		reg = <0x00 0x02160000 0x00 0x400>;
-		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		power-domains = <&k3_pds 382 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 382 1>;
-		status = "disabled";
-	};
-
-	main_spi7: spi@2170000 {
-		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
-		reg = <0x00 0x02170000 0x00 0x400>;
-		interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		power-domains = <&k3_pds 383 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 383 1>;
-		status = "disabled";
-	};
-
-	ufs_wrapper: ufs-wrapper@4e80000 {
-		compatible = "ti,j721e-ufs";
-		reg = <0x00 0x4e80000 0x00 0x100>;
-		power-domains = <&k3_pds 387 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 387 3>;
-		assigned-clocks = <&k3_clks 387 3>;
-		assigned-clock-parents = <&k3_clks 387 6>;
-		ranges;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		status = "disabled";
-
-		ufs@4e84000 {
-			compatible = "cdns,ufshc-m31-16nm", "jedec,ufs-2.0";
-			reg = <0x00 0x4e84000 0x00 0x10000>;
-			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			freq-table-hz = <250000000 250000000>, <19200000 19200000>,
-					<19200000 19200000>;
-			clocks = <&k3_clks 387 1>, <&k3_clks 387 3>, <&k3_clks 387 3>;
-			clock-names = "core_clk", "phy_clk", "ref_clk";
-			dma-coherent;
-		};
-	};
-
-	main_r5fss0: r5fss@5c00000 {
-		compatible = "ti,j721s2-r5fss";
-		ti,cluster-mode = <1>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
-			 <0x5d00000 0x00 0x5d00000 0x20000>;
-		power-domains = <&k3_pds 336 TI_SCI_PD_EXCLUSIVE>;
-
-		main_r5fss0_core0: r5f@5c00000 {
-			compatible = "ti,j721s2-r5f";
-			reg = <0x5c00000 0x00010000>,
-			      <0x5c10000 0x00010000>;
-			reg-names = "atcm", "btcm";
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <339>;
-			ti,sci-proc-ids = <0x06 0xff>;
-			resets = <&k3_reset 339 1>;
-			firmware-name = "j784s4-main-r5f0_0-fw";
-			ti,atcm-enable = <1>;
-			ti,btcm-enable = <1>;
-			ti,loczrama = <1>;
-		};
-
-		main_r5fss0_core1: r5f@5d00000 {
-			compatible = "ti,j721s2-r5f";
-			reg = <0x5d00000 0x00010000>,
-			      <0x5d10000 0x00010000>;
-			reg-names = "atcm", "btcm";
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <340>;
-			ti,sci-proc-ids = <0x07 0xff>;
-			resets = <&k3_reset 340 1>;
-			firmware-name = "j784s4-main-r5f0_1-fw";
-			ti,atcm-enable = <1>;
-			ti,btcm-enable = <1>;
-			ti,loczrama = <1>;
-		};
-	};
-
-	main_r5fss1: r5fss@5e00000 {
-		compatible = "ti,j721s2-r5fss";
-		ti,cluster-mode = <1>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
-			 <0x5f00000 0x00 0x5f00000 0x20000>;
-		power-domains = <&k3_pds 337 TI_SCI_PD_EXCLUSIVE>;
-
-		main_r5fss1_core0: r5f@5e00000 {
-			compatible = "ti,j721s2-r5f";
-			reg = <0x5e00000 0x00010000>,
-			      <0x5e10000 0x00010000>;
-			reg-names = "atcm", "btcm";
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <341>;
-			ti,sci-proc-ids = <0x08 0xff>;
-			resets = <&k3_reset 341 1>;
-			firmware-name = "j784s4-main-r5f1_0-fw";
-			ti,atcm-enable = <1>;
-			ti,btcm-enable = <1>;
-			ti,loczrama = <1>;
-		};
-
-		main_r5fss1_core1: r5f@5f00000 {
-			compatible = "ti,j721s2-r5f";
-			reg = <0x5f00000 0x00010000>,
-			      <0x5f10000 0x00010000>;
-			reg-names = "atcm", "btcm";
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <342>;
-			ti,sci-proc-ids = <0x09 0xff>;
-			resets = <&k3_reset 342 1>;
-			firmware-name = "j784s4-main-r5f1_1-fw";
-			ti,atcm-enable = <1>;
-			ti,btcm-enable = <1>;
-			ti,loczrama = <1>;
-		};
-	};
-
-	main_r5fss2: r5fss@5900000 {
-		compatible = "ti,j721s2-r5fss";
-		ti,cluster-mode = <1>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x5900000 0x00 0x5900000 0x20000>,
-			 <0x5a00000 0x00 0x5a00000 0x20000>;
-		power-domains = <&k3_pds 338 TI_SCI_PD_EXCLUSIVE>;
-
-		main_r5fss2_core0: r5f@5900000 {
-			compatible = "ti,j721s2-r5f";
-			reg = <0x5900000 0x00010000>,
-			      <0x5910000 0x00010000>;
-			reg-names = "atcm", "btcm";
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <343>;
-			ti,sci-proc-ids = <0x0a 0xff>;
-			resets = <&k3_reset 343 1>;
-			firmware-name = "j784s4-main-r5f2_0-fw";
-			ti,atcm-enable = <1>;
-			ti,btcm-enable = <1>;
-			ti,loczrama = <1>;
-		};
-
-		main_r5fss2_core1: r5f@5a00000 {
-			compatible = "ti,j721s2-r5f";
-			reg = <0x5a00000 0x00010000>,
-			      <0x5a10000 0x00010000>;
-			reg-names = "atcm", "btcm";
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <344>;
-			ti,sci-proc-ids = <0x0b 0xff>;
-			resets = <&k3_reset 344 1>;
-			firmware-name = "j784s4-main-r5f2_1-fw";
-			ti,atcm-enable = <1>;
-			ti,btcm-enable = <1>;
-			ti,loczrama = <1>;
-		};
-	};
-
-	c71_0: dsp@64800000 {
-		compatible = "ti,j721s2-c71-dsp";
-		reg = <0x00 0x64800000 0x00 0x00080000>,
-		      <0x00 0x64e00000 0x00 0x0000c000>;
-		reg-names = "l2sram", "l1dram";
-		ti,sci = <&sms>;
-		ti,sci-dev-id = <30>;
-		ti,sci-proc-ids = <0x30 0xff>;
-		resets = <&k3_reset 30 1>;
-		firmware-name = "j784s4-c71_0-fw";
-		status = "disabled";
-	};
-
-	c71_1: dsp@65800000 {
-		compatible = "ti,j721s2-c71-dsp";
-		reg = <0x00 0x65800000 0x00 0x00080000>,
-		      <0x00 0x65e00000 0x00 0x0000c000>;
-		reg-names = "l2sram", "l1dram";
-		ti,sci = <&sms>;
-		ti,sci-dev-id = <33>;
-		ti,sci-proc-ids = <0x31 0xff>;
-		resets = <&k3_reset 33 1>;
-		firmware-name = "j784s4-c71_1-fw";
-		status = "disabled";
-	};
-
-	c71_2: dsp@66800000 {
-		compatible = "ti,j721s2-c71-dsp";
-		reg = <0x00 0x66800000 0x00 0x00080000>,
-		      <0x00 0x66e00000 0x00 0x0000c000>;
-		reg-names = "l2sram", "l1dram";
-		ti,sci = <&sms>;
-		ti,sci-dev-id = <37>;
-		ti,sci-proc-ids = <0x32 0xff>;
-		resets = <&k3_reset 37 1>;
-		firmware-name = "j784s4-c71_2-fw";
-		status = "disabled";
-	};
-
+&cbass_main {
 	c71_3: dsp@67800000 {
 		compatible = "ti,j721s2-c71-dsp";
 		reg = <0x00 0x67800000 0x00 0x00080000>,
 		      <0x00 0x67e00000 0x00 0x0000c000>;
 		reg-names = "l2sram", "l1dram";
+		resets = <&k3_reset 40 1>;
+		firmware-name = "j784s4-c71_3-fw";
 		ti,sci = <&sms>;
 		ti,sci-dev-id = <40>;
 		ti,sci-proc-ids = <0x33 0xff>;
-		resets = <&k3_reset 40 1>;
-		firmware-name = "j784s4-c71_3-fw";
-		status = "disabled";
-	};
-
-	main_esm: esm@700000 {
-		compatible = "ti,j721e-esm";
-		reg = <0x00 0x700000 0x00 0x1000>;
-		ti,esm-pins = <688>, <689>, <690>, <691>, <692>, <693>, <694>,
-			      <695>;
-		bootph-pre-ram;
-	};
-
-	watchdog0: watchdog@2200000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x2200000 0x00 0x100>;
-		clocks = <&k3_clks 348 0>;
-		power-domains = <&k3_pds 348 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 348 0>;
-		assigned-clock-parents = <&k3_clks 348 4>;
-	};
-
-	watchdog1: watchdog@2210000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x2210000 0x00 0x100>;
-		clocks = <&k3_clks 349 0>;
-		power-domains = <&k3_pds 349 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 349 0>;
-		assigned-clock-parents = <&k3_clks 349 4>;
-	};
-
-	watchdog2: watchdog@2220000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x2220000 0x00 0x100>;
-		clocks = <&k3_clks 350 0>;
-		power-domains = <&k3_pds 350 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 350 0>;
-		assigned-clock-parents = <&k3_clks 350 4>;
-	};
-
-	watchdog3: watchdog@2230000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x2230000 0x00 0x100>;
-		clocks = <&k3_clks 351 0>;
-		power-domains = <&k3_pds 351 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 351 0>;
-		assigned-clock-parents = <&k3_clks 351 4>;
-	};
-
-	watchdog4: watchdog@2240000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x2240000 0x00 0x100>;
-		clocks = <&k3_clks 352 0>;
-		power-domains = <&k3_pds 352 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 352 0>;
-		assigned-clock-parents = <&k3_clks 352 4>;
-	};
-
-	watchdog5: watchdog@2250000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x2250000 0x00 0x100>;
-		clocks = <&k3_clks 353 0>;
-		power-domains = <&k3_pds 353 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 353 0>;
-		assigned-clock-parents = <&k3_clks 353 4>;
-	};
-
-	watchdog6: watchdog@2260000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x2260000 0x00 0x100>;
-		clocks = <&k3_clks 354 0>;
-		power-domains = <&k3_pds 354 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 354 0>;
-		assigned-clock-parents = <&k3_clks 354 4>;
-	};
-
-	watchdog7: watchdog@2270000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x2270000 0x00 0x100>;
-		clocks = <&k3_clks 355 0>;
-		power-domains = <&k3_pds 355 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 355 0>;
-		assigned-clock-parents = <&k3_clks 355 4>;
-	};
-
-	/*
-	 * The following RTI instances are coupled with MCU R5Fs, c7x and
-	 * GPU so keeping them reserved as these will be used by their
-	 * respective firmware
-	 */
-	watchdog8: watchdog@22f0000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x22f0000 0x00 0x100>;
-		clocks = <&k3_clks 360 0>;
-		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 360 0>;
-		assigned-clock-parents = <&k3_clks 360 4>;
-		/* reserved for GPU */
-		status = "reserved";
-	};
-
-	watchdog9: watchdog@2300000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x2300000 0x00 0x100>;
-		clocks = <&k3_clks 356 0>;
-		power-domains = <&k3_pds 356 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 356 0>;
-		assigned-clock-parents = <&k3_clks 356 4>;
-		/* reserved for C7X_0 DSP */
-		status = "reserved";
-	};
-
-	watchdog10: watchdog@2310000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x2310000 0x00 0x100>;
-		clocks = <&k3_clks 357 0>;
-		power-domains = <&k3_pds 357 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 357 0>;
-		assigned-clock-parents = <&k3_clks 357 4>;
-		/* reserved for C7X_1 DSP */
-		status = "reserved";
-	};
-
-	watchdog11: watchdog@2320000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x2320000 0x00 0x100>;
-		clocks = <&k3_clks 358 0>;
-		power-domains = <&k3_pds 358 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 358 0>;
-		assigned-clock-parents = <&k3_clks 358 4>;
-		/* reserved for C7X_2 DSP */
-		status = "reserved";
-	};
-
-	watchdog12: watchdog@2330000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x2330000 0x00 0x100>;
-		clocks = <&k3_clks 359 0>;
-		power-domains = <&k3_pds 359 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 359 0>;
-		assigned-clock-parents = <&k3_clks 359 4>;
-		/* reserved for C7X_3 DSP */
-		status = "reserved";
-	};
-
-	watchdog13: watchdog@23c0000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x23c0000 0x00 0x100>;
-		clocks = <&k3_clks 361 0>;
-		power-domains = <&k3_pds 361 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 361 0>;
-		assigned-clock-parents = <&k3_clks 361 4>;
-		/* reserved for MAIN_R5F0_0 */
-		status = "reserved";
-	};
-
-	watchdog14: watchdog@23d0000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x23d0000 0x00 0x100>;
-		clocks = <&k3_clks 362 0>;
-		power-domains = <&k3_pds 362 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 362 0>;
-		assigned-clock-parents = <&k3_clks 362 4>;
-		/* reserved for MAIN_R5F0_1 */
-		status = "reserved";
-	};
-
-	watchdog15: watchdog@23e0000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x23e0000 0x00 0x100>;
-		clocks = <&k3_clks 363 0>;
-		power-domains = <&k3_pds 363 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 363 0>;
-		assigned-clock-parents = <&k3_clks 363 4>;
-		/* reserved for MAIN_R5F1_0 */
-		status = "reserved";
-	};
-
-	watchdog16: watchdog@23f0000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x23f0000 0x00 0x100>;
-		clocks = <&k3_clks 364 0>;
-		power-domains = <&k3_pds 364 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 364 0>;
-		assigned-clock-parents = <&k3_clks 364 4>;
-		/* reserved for MAIN_R5F1_1 */
-		status = "reserved";
-	};
-
-	watchdog17: watchdog@2540000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x2540000 0x00 0x100>;
-		clocks = <&k3_clks 365 0>;
-		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 365 0>;
-		assigned-clock-parents = <&k3_clks 366 4>;
-		/* reserved for MAIN_R5F2_0 */
-		status = "reserved";
-	};
-
-	watchdog18: watchdog@2550000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x2550000 0x00 0x100>;
-		clocks = <&k3_clks 366 0>;
-		power-domains = <&k3_pds 366 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 366 0>;
-		assigned-clock-parents = <&k3_clks 366 4>;
-		/* reserved for MAIN_R5F2_1 */
-		status = "reserved";
-	};
-
-	mhdp: bridge@a000000 {
-		compatible = "ti,j721e-mhdp8546";
-		reg = <0x0 0xa000000 0x0 0x30a00>,
-		      <0x0 0x4f40000 0x0 0x20>;
-		reg-names = "mhdptx", "j721e-intg";
-		clocks = <&k3_clks 217 11>;
-		interrupt-parent = <&gic500>;
-		interrupts = <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>;
-		power-domains = <&k3_pds 217 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-
-		dp0_ports: ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			/* Remote-endpoints are on the boards so
-			 * ports are defined in the platform dt file.
-			 */
-		};
-	};
-
-	dss: dss@4a00000 {
-		compatible = "ti,j721e-dss";
-		reg = <0x00 0x04a00000 0x00 0x10000>, /* common_m */
-		      <0x00 0x04a10000 0x00 0x10000>, /* common_s0*/
-		      <0x00 0x04b00000 0x00 0x10000>, /* common_s1*/
-		      <0x00 0x04b10000 0x00 0x10000>, /* common_s2*/
-		      <0x00 0x04a20000 0x00 0x10000>, /* vidl1 */
-		      <0x00 0x04a30000 0x00 0x10000>, /* vidl2 */
-		      <0x00 0x04a50000 0x00 0x10000>, /* vid1 */
-		      <0x00 0x04a60000 0x00 0x10000>, /* vid2 */
-		      <0x00 0x04a70000 0x00 0x10000>, /* ovr1 */
-		      <0x00 0x04a90000 0x00 0x10000>, /* ovr2 */
-		      <0x00 0x04ab0000 0x00 0x10000>, /* ovr3 */
-		      <0x00 0x04ad0000 0x00 0x10000>, /* ovr4 */
-		      <0x00 0x04a80000 0x00 0x10000>, /* vp1 */
-		      <0x00 0x04aa0000 0x00 0x10000>, /* vp1 */
-		      <0x00 0x04ac0000 0x00 0x10000>, /* vp1 */
-		      <0x00 0x04ae0000 0x00 0x10000>, /* vp4 */
-		      <0x00 0x04af0000 0x00 0x10000>; /* wb */
-		reg-names = "common_m", "common_s0",
-			    "common_s1", "common_s2",
-			    "vidl1", "vidl2","vid1","vid2",
-			    "ovr1", "ovr2", "ovr3", "ovr4",
-			    "vp1", "vp2", "vp3", "vp4",
-			    "wb";
-		clocks = <&k3_clks 218 0>,
-			 <&k3_clks 218 2>,
-			 <&k3_clks 218 5>,
-			 <&k3_clks 218 14>,
-			 <&k3_clks 218 18>;
-		clock-names = "fck", "vp1", "vp2", "vp3", "vp4";
-		power-domains = <&k3_pds 218 TI_SCI_PD_EXCLUSIVE>;
-		interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "common_m",
-				  "common_s0",
-				  "common_s1",
-				  "common_s2";
 		status = "disabled";
-
-		dss_ports: ports {
-			/* Ports that DSS drives are platform specific
-			 * so they are defined in platform dt file.
-			 */
-		};
 	};
 
-	mcasp0: mcasp@2b00000 {
-		compatible = "ti,am33xx-mcasp-audio";
-		reg = <0x00 0x02b00000 0x00 0x2000>,
-		      <0x00 0x02b08000 0x00 0x1000>;
-		reg-names = "mpu","dat";
-		interrupts = <GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 545 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "tx", "rx";
-		dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
-		dma-names = "tx", "rx";
-		clocks = <&k3_clks 265 0>;
+	pcie2_rc: pcie@2920000 {
+		compatible = "ti,j784s4-pcie-host";
+		reg = <0x00 0x02920000 0x00 0x1000>,
+		      <0x00 0x02927000 0x00 0x400>,
+		      <0x00 0x0e000000 0x00 0x00800000>,
+		      <0x44 0x00000000 0x00 0x00001000>;
+		ranges = <0x01000000 0x0 0x00001000 0x44 0x00001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x00011000 0x44 0x00011000 0x0 0x7fef000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 334 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 334 0>;
 		clock-names = "fck";
-		assigned-clocks = <&k3_clks 265 0>;
-		assigned-clock-parents = <&k3_clks 265 1>;
-		power-domains = <&k3_pds 265 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xff>;
+		vendor-id = <0x104c>;
+		device-id = <0xb012>;
+		msi-map = <0x0 &gic_its 0x20000 0x10000>;
+		dma-coherent;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		ti,syscon-pcie-ctrl = <&pcie2_ctrl 0x0>;
 		status = "disabled";
 	};
 
-	mcasp1: mcasp@2b10000 {
-		compatible = "ti,am33xx-mcasp-audio";
-		reg = <0x00 0x02b10000 0x00 0x2000>,
-		      <0x00 0x02b18000 0x00 0x1000>;
-		reg-names = "mpu","dat";
-		interrupts = <GIC_SPI 546 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 547 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "tx", "rx";
-		dmas = <&main_udmap 0xc401>, <&main_udmap 0x4401>;
-		dma-names = "tx", "rx";
-		clocks = <&k3_clks 266 0>;
+	pcie3_rc: pcie@2930000 {
+		compatible = "ti,j784s4-pcie-host";
+		reg = <0x00 0x02930000 0x00 0x1000>,
+		      <0x00 0x02937000 0x00 0x400>,
+		      <0x00 0x0e800000 0x00 0x00800000>,
+		      <0x44 0x10000000 0x00 0x00001000>;
+		ranges = <0x01000000 0x0 0x00001000 0x44 0x10001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x00011000 0x44 0x10011000 0x0 0x7fef000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 335 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 335 0>;
 		clock-names = "fck";
-		assigned-clocks = <&k3_clks 266 0>;
-		assigned-clock-parents = <&k3_clks 266 1>;
-		power-domains = <&k3_pds 266 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xff>;
+		vendor-id = <0x104c>;
+		device-id = <0xb012>;
+		msi-map = <0x0 &gic_its 0x30000 0x10000>;
+		dma-coherent;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		ti,syscon-pcie-ctrl = <&pcie3_ctrl 0x0>;
 		status = "disabled";
 	};
 
-	mcasp2: mcasp@2b20000 {
-		compatible = "ti,am33xx-mcasp-audio";
-		reg = <0x00 0x02b20000 0x00 0x2000>,
-		      <0x00 0x02b28000 0x00 0x1000>;
-		reg-names = "mpu","dat";
-		interrupts = <GIC_SPI 548 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 549 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "tx", "rx";
-		dmas = <&main_udmap 0xc402>, <&main_udmap 0x4402>;
-		dma-names = "tx", "rx";
-		clocks = <&k3_clks 267 0>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 267 0>;
-		assigned-clock-parents = <&k3_clks 267 1>;
-		power-domains = <&k3_pds 267 TI_SCI_PD_EXCLUSIVE>;
+	serdes_wiz2: wiz@5020000 {
+		compatible = "ti,j784s4-wiz-10g";
+		ranges = <0x05020000 0x00 0x05020000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 406 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 406 2>, <&k3_clks 406 6>, <&serdes_refclk>, <&k3_clks 406 5>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
+		assigned-clocks = <&k3_clks 406 6>;
+		assigned-clock-parents = <&k3_clks 406 10>;
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
 		status = "disabled";
+
+		serdes2: serdes@5020000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05020000 0x010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz2 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz2 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz2 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz2 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz2 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz2 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 406 6>,
+						 <&k3_clks 406 6>,
+						 <&k3_clks 406 6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
 	};
+};
 
-	mcasp3: mcasp@2b30000 {
-		compatible = "ti,am33xx-mcasp-audio";
-		reg = <0x00 0x02b30000 0x00 0x2000>,
-		      <0x00 0x02b38000 0x00 0x1000>;
-		reg-names = "mpu","dat";
-		interrupts = <GIC_SPI 550 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 551 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "tx", "rx";
-		dmas = <&main_udmap 0xc403>, <&main_udmap 0x4403>;
-		dma-names = "tx", "rx";
-		clocks = <&k3_clks 268 0>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 268 0>;
-		assigned-clock-parents = <&k3_clks 268 1>;
-		power-domains = <&k3_pds 268 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
+&scm_conf {
+	pcie2_ctrl: pcie2-ctrl@4078 {
+		compatible = "ti,j784s4-pcie-ctrl", "syscon";
+		reg = <0x4078 0x4>;
 	};
 
-	mcasp4: mcasp@2b40000 {
-		compatible = "ti,am33xx-mcasp-audio";
-		reg = <0x00 0x02b40000 0x00 0x2000>,
-		      <0x00 0x02b48000 0x00 0x1000>;
-		reg-names = "mpu","dat";
-		interrupts = <GIC_SPI 552 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 553 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "tx", "rx";
-		dmas = <&main_udmap 0xc404>, <&main_udmap 0x4404>;
-		dma-names = "tx", "rx";
-		clocks = <&k3_clks 269 0>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 269 0>;
-		assigned-clock-parents = <&k3_clks 269 1>;
-		power-domains = <&k3_pds 269 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
+	pcie3_ctrl: pcie3-ctrl@407c {
+		compatible = "ti,j784s4-pcie-ctrl", "syscon";
+		reg = <0x407c 0x4>;
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
deleted file mode 100644
index f603380fc91c..000000000000
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ /dev/null
@@ -1,760 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only OR MIT
-/*
- * Device Tree Source for J784S4 SoC Family MCU/WAKEUP Domain peripherals
- *
- * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-&cbass_mcu_wakeup {
-	sms: system-controller@44083000 {
-		bootph-all;
-		compatible = "ti,k2g-sci";
-		ti,host-id = <12>;
-
-		mbox-names = "rx", "tx";
-
-		mboxes = <&secure_proxy_main 11>,
-			 <&secure_proxy_main 13>;
-
-		reg-names = "debug_messages";
-		reg = <0x00 0x44083000 0x00 0x1000>;
-
-		k3_pds: power-controller {
-			bootph-all;
-			compatible = "ti,sci-pm-domain";
-			#power-domain-cells = <2>;
-		};
-
-		k3_clks: clock-controller {
-			bootph-all;
-			compatible = "ti,k2g-sci-clk";
-			#clock-cells = <2>;
-		};
-
-		k3_reset: reset-controller {
-			bootph-all;
-			compatible = "ti,sci-reset";
-			#reset-cells = <2>;
-		};
-	};
-
-	wkup_conf: bus@43000000 {
-		bootph-all;
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x00 0x43000000 0x20000>;
-
-		chipid: chipid@14 {
-			bootph-all;
-			compatible = "ti,am654-chipid";
-			reg = <0x14 0x4>;
-		};
-	};
-
-	secure_proxy_sa3: mailbox@43600000 {
-		compatible = "ti,am654-secure-proxy";
-		#mbox-cells = <1>;
-		reg-names = "target_data", "rt", "scfg";
-		reg = <0x00 0x43600000 0x00 0x10000>,
-		      <0x00 0x44880000 0x00 0x20000>,
-		      <0x00 0x44860000 0x00 0x20000>;
-		/*
-		 * Marked Disabled:
-		 * Node is incomplete as it is meant for bootloaders and
-		 * firmware on non-MPU processors
-		 */
-		status = "disabled";
-	};
-
-	mcu_ram: sram@41c00000 {
-		compatible = "mmio-sram";
-		reg = <0x00 0x41c00000 0x00 0x100000>;
-		ranges = <0x00 0x00 0x41c00000 0x100000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-	};
-
-	wkup_pmx0: pinctrl@4301c000 {
-		compatible = "pinctrl-single";
-		/* Proxy 0 addressing */
-		reg = <0x00 0x4301c000 0x00 0x034>;
-		#pinctrl-cells = <1>;
-		pinctrl-single,register-width = <32>;
-		pinctrl-single,function-mask = <0xffffffff>;
-	};
-
-	wkup_pmx1: pinctrl@4301c038 {
-		compatible = "pinctrl-single";
-		/* Proxy 0 addressing */
-		reg = <0x00 0x4301c038 0x00 0x02c>;
-		#pinctrl-cells = <1>;
-		pinctrl-single,register-width = <32>;
-		pinctrl-single,function-mask = <0xffffffff>;
-	};
-
-	wkup_pmx2: pinctrl@4301c068 {
-		compatible = "pinctrl-single";
-		/* Proxy 0 addressing */
-		reg = <0x00 0x4301c068 0x00 0x120>;
-		#pinctrl-cells = <1>;
-		pinctrl-single,register-width = <32>;
-		pinctrl-single,function-mask = <0xffffffff>;
-	};
-
-	wkup_pmx3: pinctrl@4301c190 {
-		compatible = "pinctrl-single";
-		/* Proxy 0 addressing */
-		reg = <0x00 0x4301c190 0x00 0x004>;
-		#pinctrl-cells = <1>;
-		pinctrl-single,register-width = <32>;
-		pinctrl-single,function-mask = <0xffffffff>;
-	};
-
-	wkup_gpio_intr: interrupt-controller@42200000 {
-		compatible = "ti,sci-intr";
-		reg = <0x00 0x42200000 0x00 0x400>;
-		ti,intr-trigger-type = <1>;
-		interrupt-controller;
-		interrupt-parent = <&gic500>;
-		#interrupt-cells = <1>;
-		ti,sci = <&sms>;
-		ti,sci-dev-id = <177>;
-		ti,interrupt-ranges = <16 960 16>;
-	};
-
-	/* MCU_TIMERIO pad input CTRLMMR_MCU_TIMER*_CTRL registers */
-	mcu_timerio_input: pinctrl@40f04200 {
-		compatible = "pinctrl-single";
-		reg = <0x00 0x40f04200 0x00 0x28>;
-		#pinctrl-cells = <1>;
-		pinctrl-single,register-width = <32>;
-		pinctrl-single,function-mask = <0x0000000f>;
-		/* Non-MPU Firmware usage */
-		status = "reserved";
-	};
-
-	/* MCU_TIMERIO pad output CTRLMMR_MCU_TIMERIO*_CTRL registers */
-	mcu_timerio_output: pinctrl@40f04280 {
-		compatible = "pinctrl-single";
-		reg = <0x00 0x40f04280 0x00 0x28>;
-		#pinctrl-cells = <1>;
-		pinctrl-single,register-width = <32>;
-		pinctrl-single,function-mask = <0x0000000f>;
-		/* Non-MPU Firmware usage */
-		status = "reserved";
-	};
-
-	mcu_conf: bus@40f00000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x40f00000 0x20000>;
-
-		cpsw_mac_syscon: ethernet-mac-syscon@200 {
-			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
-			reg = <0x200 0x8>;
-		};
-
-		phy_gmii_sel: phy@4040 {
-			compatible = "ti,am654-phy-gmii-sel";
-			reg = <0x4040 0x4>;
-			#phy-cells = <1>;
-		};
-	};
-
-	mcu_timer0: timer@40400000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x40400000 0x00 0x400>;
-		interrupts = <GIC_SPI 816 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 35 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 35 2>;
-		assigned-clock-parents = <&k3_clks 35 3>;
-		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-		/* Non-MPU Firmware usage */
-		status = "reserved";
-	};
-
-	mcu_timer1: timer@40410000 {
-		bootph-all;
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x40410000 0x00 0x400>;
-		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 117 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 117 2>;
-		assigned-clock-parents = <&k3_clks 117 3>;
-		power-domains = <&k3_pds 117 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-		/* Non-MPU Firmware usage */
-		status = "reserved";
-	};
-
-	mcu_timer2: timer@40420000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x40420000 0x00 0x400>;
-		interrupts = <GIC_SPI 818 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 118 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 118 2>;
-		assigned-clock-parents = <&k3_clks 118 3>;
-		power-domains = <&k3_pds 118 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-		/* Non-MPU Firmware usage */
-		status = "reserved";
-	};
-
-	mcu_timer3: timer@40430000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x40430000 0x00 0x400>;
-		interrupts = <GIC_SPI 819 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 119 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 119 2>;
-		assigned-clock-parents = <&k3_clks 119 3>;
-		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-		/* Non-MPU Firmware usage */
-		status = "reserved";
-	};
-
-	mcu_timer4: timer@40440000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x40440000 0x00 0x400>;
-		interrupts = <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 120 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 120 2>;
-		assigned-clock-parents = <&k3_clks 120 3>;
-		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-		/* Non-MPU Firmware usage */
-		status = "reserved";
-	};
-
-	mcu_timer5: timer@40450000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x40450000 0x00 0x400>;
-		interrupts = <GIC_SPI 821 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 121 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 121 2>;
-		assigned-clock-parents = <&k3_clks 121 3>;
-		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-		/* Non-MPU Firmware usage */
-		status = "reserved";
-	};
-
-	mcu_timer6: timer@40460000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x40460000 0x00 0x400>;
-		interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 122 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 122 2>;
-		assigned-clock-parents = <&k3_clks 122 3>;
-		power-domains = <&k3_pds 122 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-		/* Non-MPU Firmware usage */
-		status = "reserved";
-	};
-
-	mcu_timer7: timer@40470000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x40470000 0x00 0x400>;
-		interrupts = <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 123 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 123 2>;
-		assigned-clock-parents = <&k3_clks 123 3>;
-		power-domains = <&k3_pds 123 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-		/* Non-MPU Firmware usage */
-		status = "reserved";
-	};
-
-	mcu_timer8: timer@40480000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x40480000 0x00 0x400>;
-		interrupts = <GIC_SPI 824 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 124 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 124 2>;
-		assigned-clock-parents = <&k3_clks 124 3>;
-		power-domains = <&k3_pds 124 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-		/* Non-MPU Firmware usage */
-		status = "reserved";
-	};
-
-	mcu_timer9: timer@40490000 {
-		compatible = "ti,am654-timer";
-		reg = <0x00 0x40490000 0x00 0x400>;
-		interrupts = <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 125 2>;
-		clock-names = "fck";
-		assigned-clocks = <&k3_clks 125 2>;
-		assigned-clock-parents = <&k3_clks 125 3>;
-		power-domains = <&k3_pds 125 TI_SCI_PD_EXCLUSIVE>;
-		ti,timer-pwm;
-		/* Non-MPU Firmware usage */
-		status = "reserved";
-	};
-
-	wkup_uart0: serial@42300000 {
-		compatible = "ti,j721e-uart", "ti,am654-uart";
-		reg = <0x00 0x42300000 0x00 0x200>;
-		interrupts = <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 397 0>;
-		clock-names = "fclk";
-		power-domains = <&k3_pds 397 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	mcu_uart0: serial@40a00000 {
-		compatible = "ti,j721e-uart", "ti,am654-uart";
-		reg = <0x00 0x40a00000 0x00 0x200>;
-		interrupts = <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&k3_clks 149 0>;
-		clock-names = "fclk";
-		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	wkup_gpio0: gpio@42110000 {
-		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
-		reg = <0x00 0x42110000 0x00 0x100>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-parent = <&wkup_gpio_intr>;
-		interrupts = <103>, <104>, <105>, <106>, <107>, <108>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		ti,ngpio = <89>;
-		ti,davinci-gpio-unbanked = <0>;
-		power-domains = <&k3_pds 167 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 167 0>;
-		clock-names = "gpio";
-		status = "disabled";
-	};
-
-	wkup_gpio1: gpio@42100000 {
-		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
-		reg = <0x00 0x42100000 0x00 0x100>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-parent = <&wkup_gpio_intr>;
-		interrupts = <112>, <113>, <114>, <115>, <116>, <117>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		ti,ngpio = <89>;
-		ti,davinci-gpio-unbanked = <0>;
-		power-domains = <&k3_pds 168 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 168 0>;
-		clock-names = "gpio";
-		status = "disabled";
-	};
-
-	wkup_i2c0: i2c@42120000 {
-		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
-		reg = <0x00 0x42120000 0x00 0x100>;
-		interrupts = <GIC_SPI 896 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&k3_clks 279 2>;
-		clock-names = "fck";
-		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	mcu_i2c0: i2c@40b00000 {
-		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
-		reg = <0x00 0x40b00000 0x00 0x100>;
-		interrupts = <GIC_SPI 852 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&k3_clks 277 2>;
-		clock-names = "fck";
-		power-domains = <&k3_pds 277 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	mcu_i2c1: i2c@40b10000 {
-		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
-		reg = <0x00 0x40b10000 0x00 0x100>;
-		interrupts = <GIC_SPI 853 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&k3_clks 278 2>;
-		clock-names = "fck";
-		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
-		status = "disabled";
-	};
-
-	mcu_mcan0: can@40528000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x40528000 0x00 0x200>,
-		      <0x00 0x40500000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 263 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 263 6>, <&k3_clks 263 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 832 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	mcu_mcan1: can@40568000 {
-		compatible = "bosch,m_can";
-		reg = <0x00 0x40568000 0x00 0x200>,
-		      <0x00 0x40540000 0x00 0x8000>;
-		reg-names = "m_can", "message_ram";
-		power-domains = <&k3_pds 264 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 264 6>, <&k3_clks 264 1>;
-		clock-names = "hclk", "cclk";
-		interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "int0", "int1";
-		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
-		status = "disabled";
-	};
-
-	mcu_spi0: spi@40300000 {
-		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
-		reg = <0x00 0x040300000 0x00 0x400>;
-		interrupts = <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		power-domains = <&k3_pds 384 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 384 0>;
-		status = "disabled";
-	};
-
-	mcu_spi1: spi@40310000 {
-		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
-		reg = <0x00 0x040310000 0x00 0x400>;
-		interrupts = <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		power-domains = <&k3_pds 385 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 385 0>;
-		status = "disabled";
-	};
-
-	mcu_spi2: spi@40320000 {
-		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
-		reg = <0x00 0x040320000 0x00 0x400>;
-		interrupts = <GIC_SPI 850 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		power-domains = <&k3_pds 386 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 386 0>;
-		status = "disabled";
-	};
-
-	mcu_navss: bus@28380000 {
-		bootph-all;
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
-		ti,sci-dev-id = <323>;
-		dma-coherent;
-		dma-ranges;
-
-		mcu_ringacc: ringacc@2b800000 {
-			bootph-all;
-			compatible = "ti,am654-navss-ringacc";
-			reg = <0x00 0x2b800000 0x00 0x400000>,
-			      <0x00 0x2b000000 0x00 0x400000>,
-			      <0x00 0x28590000 0x00 0x100>,
-			      <0x00 0x2a500000 0x00 0x40000>,
-			      <0x00 0x28440000 0x00 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
-			ti,num-rings = <286>;
-			ti,sci-rm-range-gp-rings = <0x1>;
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <328>;
-			msi-parent = <&main_udmass_inta>;
-		};
-
-		mcu_udmap: dma-controller@285c0000 {
-			bootph-all;
-			compatible = "ti,j721e-navss-mcu-udmap";
-			reg = <0x00 0x285c0000 0x00 0x100>,
-			      <0x00 0x2a800000 0x00 0x40000>,
-			      <0x00 0x2aa00000 0x00 0x40000>,
-			      <0x00 0x284a0000 0x00 0x4000>,
-			      <0x00 0x284c0000 0x00 0x4000>,
-			      <0x00 0x28400000 0x00 0x2000>;
-			reg-names = "gcfg", "rchanrt", "tchanrt",
-				    "tchan", "rchan", "rflow";
-			msi-parent = <&main_udmass_inta>;
-			#dma-cells = <1>;
-
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <329>;
-			ti,ringacc = <&mcu_ringacc>;
-			ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
-						<0x0f>; /* TX_HCHAN */
-			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
-						<0x0b>; /* RX_HCHAN */
-			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
-		};
-	};
-
-	secure_proxy_mcu: mailbox@2a480000 {
-		compatible = "ti,am654-secure-proxy";
-		#mbox-cells = <1>;
-		reg-names = "target_data", "rt", "scfg";
-		reg = <0x00 0x2a480000 0x00 0x80000>,
-		      <0x00 0x2a380000 0x00 0x80000>,
-		      <0x00 0x2a400000 0x00 0x80000>;
-		/*
-		 * Marked Disabled:
-		 * Node is incomplete as it is meant for bootloaders and
-		 * firmware on non-MPU processors
-		 */
-		status = "disabled";
-	};
-
-	mcu_cpsw: ethernet@46000000 {
-		compatible = "ti,j721e-cpsw-nuss";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		reg = <0x00 0x46000000 0x00 0x200000>;
-		reg-names = "cpsw_nuss";
-		ranges = <0x00 0x00 0x00 0x46000000 0x00 0x200000>;
-		dma-coherent;
-		clocks = <&k3_clks 63 0>;
-		clock-names = "fck";
-		power-domains = <&k3_pds 63 TI_SCI_PD_EXCLUSIVE>;
-
-		dmas = <&mcu_udmap 0xf000>,
-		       <&mcu_udmap 0xf001>,
-		       <&mcu_udmap 0xf002>,
-		       <&mcu_udmap 0xf003>,
-		       <&mcu_udmap 0xf004>,
-		       <&mcu_udmap 0xf005>,
-		       <&mcu_udmap 0xf006>,
-		       <&mcu_udmap 0xf007>,
-		       <&mcu_udmap 0x7000>;
-		dma-names = "tx0", "tx1", "tx2", "tx3",
-			    "tx4", "tx5", "tx6", "tx7",
-			    "rx";
-		status = "disabled";
-
-		ethernet-ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			mcu_cpsw_port1: port@1 {
-				reg = <1>;
-				ti,mac-only;
-				label = "port1";
-				ti,syscon-efuse = <&cpsw_mac_syscon 0x0>;
-				phys = <&phy_gmii_sel 1>;
-			};
-		};
-
-		davinci_mdio: mdio@f00 {
-			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
-			reg = <0x00 0xf00 0x00 0x100>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&k3_clks 63 0>;
-			clock-names = "fck";
-			bus_freq = <1000000>;
-		};
-
-		cpts@3d000 {
-			compatible = "ti,am65-cpts";
-			reg = <0x00 0x3d000 0x00 0x400>;
-			clocks = <&k3_clks 63 3>;
-			clock-names = "cpts";
-			assigned-clocks = <&k3_clks 63 3>; /* CPTS_RFT_CLK */
-			assigned-clock-parents = <&k3_clks 63 5>; /* MAIN_0_HSDIV6_CLK */
-			interrupts-extended = <&gic500 GIC_SPI 858 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "cpts";
-			ti,cpts-ext-ts-inputs = <4>;
-			ti,cpts-periodic-outputs = <2>;
-		};
-	};
-
-	mcu_r5fss0: r5fss@41000000 {
-		compatible = "ti,j721s2-r5fss";
-		ti,cluster-mode = <1>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x41000000 0x00 0x41000000 0x20000>,
-			 <0x41400000 0x00 0x41400000 0x20000>;
-		power-domains = <&k3_pds 345 TI_SCI_PD_EXCLUSIVE>;
-
-		mcu_r5fss0_core0: r5f@41000000 {
-			compatible = "ti,j721s2-r5f";
-			reg = <0x41000000 0x00010000>,
-			      <0x41010000 0x00010000>;
-			reg-names = "atcm", "btcm";
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <346>;
-			ti,sci-proc-ids = <0x01 0xff>;
-			resets = <&k3_reset 346 1>;
-			firmware-name = "j784s4-mcu-r5f0_0-fw";
-			ti,atcm-enable = <1>;
-			ti,btcm-enable = <1>;
-			ti,loczrama = <1>;
-		};
-
-		mcu_r5fss0_core1: r5f@41400000 {
-			compatible = "ti,j721s2-r5f";
-			reg = <0x41400000 0x00010000>,
-			      <0x41410000 0x00010000>;
-			reg-names = "atcm", "btcm";
-			ti,sci = <&sms>;
-			ti,sci-dev-id = <347>;
-			ti,sci-proc-ids = <0x02 0xff>;
-			resets = <&k3_reset 347 1>;
-			firmware-name = "j784s4-mcu-r5f0_1-fw";
-			ti,atcm-enable = <1>;
-			ti,btcm-enable = <1>;
-			ti,loczrama = <1>;
-		};
-	};
-
-	wkup_vtm0: temperature-sensor@42040000 {
-		compatible = "ti,j7200-vtm";
-		reg = <0x00 0x42040000 0x00 0x350>,
-		      <0x00 0x42050000 0x00 0x350>;
-		power-domains = <&k3_pds 243 TI_SCI_PD_SHARED>;
-		#thermal-sensor-cells = <1>;
-	};
-
-	tscadc0: tscadc@40200000 {
-		compatible = "ti,am3359-tscadc";
-		reg = <0x00 0x40200000 0x00 0x1000>;
-		interrupts = <GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>;
-		power-domains = <&k3_pds 0 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 0 0>;
-		assigned-clocks = <&k3_clks 0 2>;
-		assigned-clock-rates = <60000000>;
-		clock-names = "fck";
-		dmas = <&main_udmap 0x7400>,
-			<&main_udmap 0x7401>;
-		dma-names = "fifo0", "fifo1";
-		status = "disabled";
-
-		adc {
-			#io-channel-cells = <1>;
-			compatible = "ti,am3359-adc";
-		};
-	};
-
-	tscadc1: tscadc@40210000 {
-		compatible = "ti,am3359-tscadc";
-		reg = <0x00 0x40210000 0x00 0x1000>;
-		interrupts = <GIC_SPI 861 IRQ_TYPE_LEVEL_HIGH>;
-		power-domains = <&k3_pds 1 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 1 0>;
-		assigned-clocks = <&k3_clks 1 2>;
-		assigned-clock-rates = <60000000>;
-		clock-names = "fck";
-		dmas = <&main_udmap 0x7402>,
-			<&main_udmap 0x7403>;
-		dma-names = "fifo0", "fifo1";
-		status = "disabled";
-
-		adc {
-			#io-channel-cells = <1>;
-			compatible = "ti,am3359-adc";
-		};
-	};
-
-	fss: bus@47000000 {
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges = <0x00 0x47000000 0x00 0x47000000 0x00 0x00000100>, /* FSS Control */
-			 <0x00 0x47040000 0x00 0x47040000 0x00 0x00000100>, /* OSPI0 Control */
-			 <0x00 0x47050000 0x00 0x47050000 0x00 0x00000100>, /* OSPI1 Control */
-			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS data region 1 */
-			 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS data region 0/3 */
-
-		ospi0: spi@47040000 {
-			compatible = "ti,am654-ospi", "cdns,qspi-nor";
-			reg = <0x00 0x47040000 0x00 0x100>,
-			      <0x05 0x00000000 0x01 0x00000000>;
-			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
-			cdns,fifo-depth = <256>;
-			cdns,fifo-width = <4>;
-			cdns,trigger-address = <0x0>;
-			clocks = <&k3_clks 161 7>;
-			assigned-clocks = <&k3_clks 161 7>;
-			assigned-clock-parents = <&k3_clks 161 9>;
-			assigned-clock-rates = <166666666>;
-			power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		ospi1: spi@47050000 {
-			compatible = "ti,am654-ospi", "cdns,qspi-nor";
-			reg = <0x00 0x47050000 0x00 0x100>,
-			      <0x07 0x00000000 0x01 0x00000000>;
-			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
-			cdns,fifo-depth = <256>;
-			cdns,fifo-width = <4>;
-			cdns,trigger-address = <0x0>;
-			clocks = <&k3_clks 162 7>;
-			power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-	};
-
-	mcu_esm: esm@40800000 {
-		compatible = "ti,j721e-esm";
-		reg = <0x00 0x40800000 0x00 0x1000>;
-		ti,esm-pins = <95>;
-		bootph-pre-ram;
-	};
-
-	wkup_esm: esm@42080000 {
-		compatible = "ti,j721e-esm";
-		reg = <0x00 0x42080000 0x00 0x1000>;
-		ti,esm-pins = <63>;
-		bootph-pre-ram;
-	};
-
-	/*
-	 * The 2 RTI instances are couple with MCU R5Fs so keeping them
-	 * reserved as these will be used by their respective firmware
-	 */
-	mcu_watchdog0: watchdog@40600000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x40600000 0x00 0x100>;
-		clocks = <&k3_clks 367 1>;
-		power-domains = <&k3_pds 367 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 367 0>;
-		assigned-clock-parents = <&k3_clks 367 4>;
-		/* reserved for MCU_R5F0_0 */
-		status = "reserved";
-	};
-
-	mcu_watchdog1: watchdog@40610000 {
-		compatible = "ti,j7-rti-wdt";
-		reg = <0x00 0x40610000 0x00 0x100>;
-		clocks = <&k3_clks 368 1>;
-		power-domains = <&k3_pds 368 TI_SCI_PD_EXCLUSIVE>;
-		assigned-clocks = <&k3_clks 368 0>;
-		assigned-clock-parents = <&k3_clks 368 4>;
-		/* reserved for MCU_R5F0_1 */
-		status = "reserved";
-	};
-};
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-thermal.dtsi
deleted file mode 100644
index e3ef61c1658f..000000000000
--- a/arch/arm64/boot/dts/ti/k3-j784s4-thermal.dtsi
+++ /dev/null
@@ -1,104 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only OR MIT
-/*
- * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-#include <dt-bindings/thermal/thermal.h>
-
-wkup0_thermal: wkup0-thermal {
-	polling-delay-passive = <250>; /* milliseconds */
-	polling-delay = <500>; /* milliseconds */
-	thermal-sensors = <&wkup_vtm0 0>;
-
-	trips {
-		wkup0_crit: wkup0-crit {
-			temperature = <125000>; /* milliCelsius */
-			hysteresis = <2000>; /* milliCelsius */
-			type = "critical";
-		};
-	};
-};
-
-wkup1_thermal: wkup1-thermal {
-	polling-delay-passive = <250>; /* milliseconds */
-	polling-delay = <500>; /* milliseconds */
-	thermal-sensors = <&wkup_vtm0 1>;
-
-	trips {
-		wkup1_crit: wkup1-crit {
-			temperature = <125000>; /* milliCelsius */
-			hysteresis = <2000>; /* milliCelsius */
-			type = "critical";
-		};
-	};
-};
-
-main0_thermal: main0-thermal {
-	polling-delay-passive = <250>; /* milliseconds */
-	polling-delay = <500>; /* milliseconds */
-	thermal-sensors = <&wkup_vtm0 2>;
-
-	trips {
-		main0_crit: main0-crit {
-			temperature = <125000>; /* milliCelsius */
-			hysteresis = <2000>; /* milliCelsius */
-			type = "critical";
-		};
-	};
-};
-
-main1_thermal: main1-thermal {
-	polling-delay-passive = <250>; /* milliseconds */
-	polling-delay = <500>; /* milliseconds */
-	thermal-sensors = <&wkup_vtm0 3>;
-
-	trips {
-		main1_crit: main1-crit {
-			temperature = <125000>; /* milliCelsius */
-			hysteresis = <2000>; /* milliCelsius */
-			type = "critical";
-		};
-	};
-};
-
-main2_thermal: main2-thermal {
-	polling-delay-passive = <250>; /* milliseconds */
-	polling-delay = <500>; /* milliseconds */
-	thermal-sensors = <&wkup_vtm0 4>;
-
-	trips {
-		main2_crit: main2-crit {
-			temperature = <125000>; /* milliCelsius */
-			hysteresis = <2000>; /* milliCelsius */
-			type = "critical";
-		};
-	};
-};
-
-main3_thermal: main3-thermal {
-	polling-delay-passive = <250>; /* milliseconds */
-	polling-delay = <500>; /* milliseconds */
-	thermal-sensors = <&wkup_vtm0 5>;
-
-	trips {
-		main3_crit: main3-crit {
-			temperature = <125000>; /* milliCelsius */
-			hysteresis = <2000>; /* milliCelsius */
-			type = "critical";
-		};
-	};
-};
-
-main4_thermal: main4-thermal {
-	polling-delay-passive = <250>; /* milliseconds */
-	polling-delay = <500>; /* milliseconds */
-	thermal-sensors = <&wkup_vtm0 6>;
-
-	trips {
-		main4_crit: main4-crit {
-			temperature = <125000>; /* milliCelsius */
-			hysteresis = <2000>; /* milliCelsius */
-			type = "critical";
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
index 5e84c6b4f5ad..f5afa32157cb 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
@@ -8,18 +8,11 @@
  *
  */
 
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/soc/ti,sci_pm_domain.h>
-
-#include "k3-pinctrl.h"
+#include "k3-j784s4-j742s2-common.dtsi"
 
 / {
 	model = "Texas Instruments K3 J784S4 SoC";
 	compatible = "ti,j784s4";
-	interrupt-parent = <&gic500>;
-	#address-cells = <2>;
-	#size-cells = <2>;
 
 	cpus {
 		#address-cells = <1>;
@@ -174,130 +167,6 @@ cpu7: cpu@103 {
 			next-level-cache = <&L2_1>;
 		};
 	};
-
-	L2_0: l2-cache0 {
-		compatible = "cache";
-		cache-level = <2>;
-		cache-unified;
-		cache-size = <0x200000>;
-		cache-line-size = <64>;
-		cache-sets = <1024>;
-		next-level-cache = <&msmc_l3>;
-	};
-
-	L2_1: l2-cache1 {
-		compatible = "cache";
-		cache-level = <2>;
-		cache-unified;
-		cache-size = <0x200000>;
-		cache-line-size = <64>;
-		cache-sets = <1024>;
-		next-level-cache = <&msmc_l3>;
-	};
-
-	msmc_l3: l3-cache0 {
-		compatible = "cache";
-		cache-level = <3>;
-		cache-unified;
-	};
-
-	firmware {
-		optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-
-		psci: psci {
-			compatible = "arm,psci-1.0";
-			method = "smc";
-		};
-	};
-
-	a72_timer0: timer-cl0-cpu0 {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
-			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
-			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
-	};
-
-	pmu: pmu {
-		compatible = "arm,cortex-a72-pmu";
-		/* Recommendation from GIC500 TRM Table A.3 */
-		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	cbass_main: bus@100000 {
-		bootph-all;
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
-			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
-			 <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
-			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
-			 <0x00 0x04210000 0x00 0x04210000 0x00 0x00010000>, /* VPU0 */
-			 <0x00 0x04220000 0x00 0x04220000 0x00 0x00010000>, /* VPU1 */
-			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIe0 Core*/
-			 <0x00 0x0d800000 0x00 0x0d800000 0x00 0x00800000>, /* PCIe1 Core*/
-			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x00800000>, /* PCIe2 Core*/
-			 <0x00 0x0e800000 0x00 0x0e800000 0x00 0x00800000>, /* PCIe3 Core*/
-			 <0x00 0x10000000 0x00 0x10000000 0x00 0x08000000>, /* PCIe0 DAT0 */
-			 <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */
-			 <0x00 0x64800000 0x00 0x64800000 0x00 0x0070c000>, /* C71_1 */
-			 <0x00 0x65800000 0x00 0x65800000 0x00 0x0070c000>, /* C71_2 */
-			 <0x00 0x66800000 0x00 0x66800000 0x00 0x0070c000>, /* C71_3 */
-			 <0x00 0x67800000 0x00 0x67800000 0x00 0x0070c000>, /* C71_4 */
-			 <0x00 0x6f000000 0x00 0x6f000000 0x00 0x00310000>, /* A72 PERIPHBASE */
-			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00400000>, /* MSMC RAM */
-			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
-			 <0x40 0x00000000 0x40 0x00000000 0x01 0x00000000>, /* PCIe0 DAT1 */
-			 <0x41 0x00000000 0x41 0x00000000 0x01 0x00000000>, /* PCIe1 DAT1 */
-			 <0x42 0x00000000 0x42 0x00000000 0x01 0x00000000>, /* PCIe2 DAT1 */
-			 <0x43 0x00000000 0x43 0x00000000 0x01 0x00000000>, /* PCIe3 DAT1 */
-			 <0x44 0x00000000 0x44 0x00000000 0x00 0x08000000>, /* PCIe2 DAT0 */
-			 <0x44 0x10000000 0x44 0x10000000 0x00 0x08000000>, /* PCIe3 DAT0 */
-			 <0x4e 0x20000000 0x4e 0x20000000 0x00 0x00080000>, /* GPU */
-
-			 /* MCUSS_WKUP Range */
-			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
-			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>,
-			 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>,
-			 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>,
-			 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>,
-			 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>,
-			 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>,
-			 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
-			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
-			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
-			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
-			 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>;
-
-		cbass_mcu_wakeup: bus@28380000 {
-			bootph-all;
-			compatible = "simple-bus";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>, /* MCU NAVSS*/
-				 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>, /* First peripheral window */
-				 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>, /* CTRL_MMR0 */
-				 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>, /* MCU R5F Core0 */
-				 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>, /* MCU R5F Core1 */
-				 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>, /* MCU SRAM */
-				 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>, /* WKUP peripheral window */
-				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
-				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
-				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI register space */
-				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS data region 1 */
-				 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS data region 0/3 */
-		};
-	};
-
-	thermal_zones: thermal-zones {
-		#include "k3-j784s4-thermal.dtsi"
-	};
 };
 
-/* Now include peripherals from each bus segment */
 #include "k3-j784s4-main.dtsi"
-#include "k3-j784s4-mcu-wakeup.dtsi"
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index e7d9bd8e4709..20c7b828e2fb 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -26,10 +26,11 @@ config CRYPTO_NHPOLY1305_NEON
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_POLY1305_NEON
-	tristate "Hash functions: Poly1305 (NEON)"
+	tristate
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	default CRYPTO_LIB_POLY1305_INTERNAL
 	help
 	  Poly1305 authenticator algorithm (RFC7539)
 
@@ -186,11 +187,12 @@ config CRYPTO_AES_ARM64_NEON_BLK
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_CHACHA20_NEON
-	tristate "Ciphers: ChaCha (NEON)"
+	tristate
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	default CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
 	  stream cipher algorithms
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index fe9f895138db..a7a1f15bcc67 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -68,6 +68,7 @@ config LOONGARCH
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_DEFAULT_BPF_JIT
diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
index 3177674228f8..45514f314664 100644
--- a/arch/loongarch/include/asm/fpu.h
+++ b/arch/loongarch/include/asm/fpu.h
@@ -22,22 +22,29 @@
 struct sigcontext;
 
 #define kernel_fpu_available() cpu_has_fpu
-extern void kernel_fpu_begin(void);
-extern void kernel_fpu_end(void);
-
-extern void _init_fpu(unsigned int);
-extern void _save_fp(struct loongarch_fpu *);
-extern void _restore_fp(struct loongarch_fpu *);
-
-extern void _save_lsx(struct loongarch_fpu *fpu);
-extern void _restore_lsx(struct loongarch_fpu *fpu);
-extern void _init_lsx_upper(void);
-extern void _restore_lsx_upper(struct loongarch_fpu *fpu);
-
-extern void _save_lasx(struct loongarch_fpu *fpu);
-extern void _restore_lasx(struct loongarch_fpu *fpu);
-extern void _init_lasx_upper(void);
-extern void _restore_lasx_upper(struct loongarch_fpu *fpu);
+
+void kernel_fpu_begin(void);
+void kernel_fpu_end(void);
+
+asmlinkage void _init_fpu(unsigned int);
+asmlinkage void _save_fp(struct loongarch_fpu *);
+asmlinkage void _restore_fp(struct loongarch_fpu *);
+asmlinkage int _save_fp_context(void __user *fpregs, void __user *fcc, void __user *csr);
+asmlinkage int _restore_fp_context(void __user *fpregs, void __user *fcc, void __user *csr);
+
+asmlinkage void _save_lsx(struct loongarch_fpu *fpu);
+asmlinkage void _restore_lsx(struct loongarch_fpu *fpu);
+asmlinkage void _init_lsx_upper(void);
+asmlinkage void _restore_lsx_upper(struct loongarch_fpu *fpu);
+asmlinkage int _save_lsx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
+asmlinkage int _restore_lsx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
+
+asmlinkage void _save_lasx(struct loongarch_fpu *fpu);
+asmlinkage void _restore_lasx(struct loongarch_fpu *fpu);
+asmlinkage void _init_lasx_upper(void);
+asmlinkage void _restore_lasx_upper(struct loongarch_fpu *fpu);
+asmlinkage int _save_lasx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
+asmlinkage int _restore_lasx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
 
 static inline void enable_lsx(void);
 static inline void disable_lsx(void);
diff --git a/arch/loongarch/include/asm/lbt.h b/arch/loongarch/include/asm/lbt.h
index e671978bf552..38566574e562 100644
--- a/arch/loongarch/include/asm/lbt.h
+++ b/arch/loongarch/include/asm/lbt.h
@@ -12,9 +12,13 @@
 #include <asm/loongarch.h>
 #include <asm/processor.h>
 
-extern void _init_lbt(void);
-extern void _save_lbt(struct loongarch_lbt *);
-extern void _restore_lbt(struct loongarch_lbt *);
+asmlinkage void _init_lbt(void);
+asmlinkage void _save_lbt(struct loongarch_lbt *);
+asmlinkage void _restore_lbt(struct loongarch_lbt *);
+asmlinkage int _save_lbt_context(void __user *regs, void __user *eflags);
+asmlinkage int _restore_lbt_context(void __user *regs, void __user *eflags);
+asmlinkage int _save_ftop_context(void __user *ftop);
+asmlinkage int _restore_ftop_context(void __user *ftop);
 
 static inline int is_lbt_enabled(void)
 {
diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index f3ddaed9ef7f..a5b63c84f854 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -33,9 +33,9 @@ struct pt_regs {
 	unsigned long __last[];
 } __aligned(8);
 
-static inline int regs_irqs_disabled(struct pt_regs *regs)
+static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
 {
-	return arch_irqs_disabled_flags(regs->csr_prmd);
+	return !(regs->csr_prmd & CSR_PRMD_PIE);
 }
 
 static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
index 6ab640101457..28caf416ae36 100644
--- a/arch/loongarch/kernel/fpu.S
+++ b/arch/loongarch/kernel/fpu.S
@@ -458,6 +458,7 @@ SYM_FUNC_START(_save_fp_context)
 	li.w		a0, 0				# success
 	jr		ra
 SYM_FUNC_END(_save_fp_context)
+EXPORT_SYMBOL_GPL(_save_fp_context)
 
 /*
  * a0: fpregs
@@ -471,6 +472,7 @@ SYM_FUNC_START(_restore_fp_context)
 	li.w		a0, 0				# success
 	jr		ra
 SYM_FUNC_END(_restore_fp_context)
+EXPORT_SYMBOL_GPL(_restore_fp_context)
 
 /*
  * a0: fpregs
@@ -484,6 +486,7 @@ SYM_FUNC_START(_save_lsx_context)
 	li.w	a0, 0					# success
 	jr	ra
 SYM_FUNC_END(_save_lsx_context)
+EXPORT_SYMBOL_GPL(_save_lsx_context)
 
 /*
  * a0: fpregs
@@ -497,6 +500,7 @@ SYM_FUNC_START(_restore_lsx_context)
 	li.w	a0, 0					# success
 	jr	ra
 SYM_FUNC_END(_restore_lsx_context)
+EXPORT_SYMBOL_GPL(_restore_lsx_context)
 
 /*
  * a0: fpregs
@@ -510,6 +514,7 @@ SYM_FUNC_START(_save_lasx_context)
 	li.w	a0, 0					# success
 	jr	ra
 SYM_FUNC_END(_save_lasx_context)
+EXPORT_SYMBOL_GPL(_save_lasx_context)
 
 /*
  * a0: fpregs
@@ -523,6 +528,7 @@ SYM_FUNC_START(_restore_lasx_context)
 	li.w	a0, 0					# success
 	jr	ra
 SYM_FUNC_END(_restore_lasx_context)
+EXPORT_SYMBOL_GPL(_restore_lasx_context)
 
 .L_fpu_fault:
 	li.w	a0, -EFAULT				# failure
diff --git a/arch/loongarch/kernel/lbt.S b/arch/loongarch/kernel/lbt.S
index 001f061d226a..71678912d24c 100644
--- a/arch/loongarch/kernel/lbt.S
+++ b/arch/loongarch/kernel/lbt.S
@@ -90,6 +90,7 @@ SYM_FUNC_START(_save_lbt_context)
 	li.w		a0, 0			# success
 	jr		ra
 SYM_FUNC_END(_save_lbt_context)
+EXPORT_SYMBOL_GPL(_save_lbt_context)
 
 /*
  * a0: scr
@@ -110,6 +111,7 @@ SYM_FUNC_START(_restore_lbt_context)
 	li.w		a0, 0			# success
 	jr		ra
 SYM_FUNC_END(_restore_lbt_context)
+EXPORT_SYMBOL_GPL(_restore_lbt_context)
 
 /*
  * a0: ftop
@@ -120,6 +122,7 @@ SYM_FUNC_START(_save_ftop_context)
 	li.w		a0, 0			# success
 	jr		ra
 SYM_FUNC_END(_save_ftop_context)
+EXPORT_SYMBOL_GPL(_save_ftop_context)
 
 /*
  * a0: ftop
@@ -150,6 +153,7 @@ SYM_FUNC_START(_restore_ftop_context)
 	li.w		a0, 0			# success
 	jr		ra
 SYM_FUNC_END(_restore_ftop_context)
+EXPORT_SYMBOL_GPL(_restore_ftop_context)
 
 .L_lbt_fault:
 	li.w		a0, -EFAULT		# failure
diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
index 7a555b600171..4740cb5b2388 100644
--- a/arch/loongarch/kernel/signal.c
+++ b/arch/loongarch/kernel/signal.c
@@ -51,27 +51,6 @@
 #define lock_lbt_owner()	({ preempt_disable(); pagefault_disable(); })
 #define unlock_lbt_owner()	({ pagefault_enable(); preempt_enable(); })
 
-/* Assembly functions to move context to/from the FPU */
-extern asmlinkage int
-_save_fp_context(void __user *fpregs, void __user *fcc, void __user *csr);
-extern asmlinkage int
-_restore_fp_context(void __user *fpregs, void __user *fcc, void __user *csr);
-extern asmlinkage int
-_save_lsx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
-extern asmlinkage int
-_restore_lsx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
-extern asmlinkage int
-_save_lasx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
-extern asmlinkage int
-_restore_lasx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
-
-#ifdef CONFIG_CPU_HAS_LBT
-extern asmlinkage int _save_lbt_context(void __user *regs, void __user *eflags);
-extern asmlinkage int _restore_lbt_context(void __user *regs, void __user *eflags);
-extern asmlinkage int _save_ftop_context(void __user *ftop);
-extern asmlinkage int _restore_ftop_context(void __user *ftop);
-#endif
-
 struct rt_sigframe {
 	struct siginfo rs_info;
 	struct ucontext rs_uctx;
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index c57b4134f3e8..00424b7e34c1 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -553,9 +553,10 @@ asmlinkage void noinstr do_ale(struct pt_regs *regs)
 	die_if_kernel("Kernel ale access", regs);
 	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)regs->csr_badvaddr);
 #else
+	bool pie = regs_irqs_disabled(regs);
 	unsigned int *pc;
 
-	if (regs->csr_prmd & CSR_PRMD_PIE)
+	if (!pie)
 		local_irq_enable();
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, regs->csr_badvaddr);
@@ -582,7 +583,7 @@ asmlinkage void noinstr do_ale(struct pt_regs *regs)
 	die_if_kernel("Kernel ale access", regs);
 	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)regs->csr_badvaddr);
 out:
-	if (regs->csr_prmd & CSR_PRMD_PIE)
+	if (!pie)
 		local_irq_disable();
 #endif
 	irqentry_exit(regs, state);
@@ -614,12 +615,13 @@ static void bug_handler(struct pt_regs *regs)
 asmlinkage void noinstr do_bce(struct pt_regs *regs)
 {
 	bool user = user_mode(regs);
+	bool pie = regs_irqs_disabled(regs);
 	unsigned long era = exception_era(regs);
 	u64 badv = 0, lower = 0, upper = ULONG_MAX;
 	union loongarch_instruction insn;
 	irqentry_state_t state = irqentry_enter(regs);
 
-	if (regs->csr_prmd & CSR_PRMD_PIE)
+	if (!pie)
 		local_irq_enable();
 
 	current->thread.trap_nr = read_csr_excode();
@@ -685,7 +687,7 @@ asmlinkage void noinstr do_bce(struct pt_regs *regs)
 	force_sig_bnderr((void __user *)badv, (void __user *)lower, (void __user *)upper);
 
 out:
-	if (regs->csr_prmd & CSR_PRMD_PIE)
+	if (!pie)
 		local_irq_disable();
 
 	irqentry_exit(regs, state);
@@ -703,11 +705,12 @@ asmlinkage void noinstr do_bce(struct pt_regs *regs)
 asmlinkage void noinstr do_bp(struct pt_regs *regs)
 {
 	bool user = user_mode(regs);
+	bool pie = regs_irqs_disabled(regs);
 	unsigned int opcode, bcode;
 	unsigned long era = exception_era(regs);
 	irqentry_state_t state = irqentry_enter(regs);
 
-	if (regs->csr_prmd & CSR_PRMD_PIE)
+	if (!pie)
 		local_irq_enable();
 
 	if (__get_inst(&opcode, (u32 *)era, user))
@@ -773,7 +776,7 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
 	}
 
 out:
-	if (regs->csr_prmd & CSR_PRMD_PIE)
+	if (!pie)
 		local_irq_disable();
 
 	irqentry_exit(regs, state);
@@ -1008,6 +1011,7 @@ static void init_restore_lbt(void)
 
 asmlinkage void noinstr do_lbt(struct pt_regs *regs)
 {
+	bool pie = regs_irqs_disabled(regs);
 	irqentry_state_t state = irqentry_enter(regs);
 
 	/*
@@ -1017,7 +1021,7 @@ asmlinkage void noinstr do_lbt(struct pt_regs *regs)
 	 * (including the user using 'MOVGR2GCSR' to turn on TM, which
 	 * will not trigger the BTE), we need to check PRMD first.
 	 */
-	if (regs->csr_prmd & CSR_PRMD_PIE)
+	if (!pie)
 		local_irq_enable();
 
 	if (!cpu_has_lbt) {
@@ -1031,7 +1035,7 @@ asmlinkage void noinstr do_lbt(struct pt_regs *regs)
 	preempt_enable();
 
 out:
-	if (regs->csr_prmd & CSR_PRMD_PIE)
+	if (!pie)
 		local_irq_disable();
 
 	irqentry_exit(regs, state);
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index e7a084de64f7..4b0ae29b8aca 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -294,6 +294,7 @@ static int kvm_pre_enter_guest(struct kvm_vcpu *vcpu)
 		vcpu->arch.aux_inuse &= ~KVM_LARCH_SWCSR_LATEST;
 
 		if (kvm_request_pending(vcpu) || xfer_to_guest_mode_work_pending()) {
+			kvm_lose_pmu(vcpu);
 			/* make sure the vcpu mode has been written */
 			smp_store_mb(vcpu->mode, OUTSIDE_GUEST_MODE);
 			local_irq_enable();
@@ -874,6 +875,13 @@ static int kvm_set_one_reg(struct kvm_vcpu *vcpu,
 			vcpu->arch.st.guest_addr = 0;
 			memset(&vcpu->arch.irq_pending, 0, sizeof(vcpu->arch.irq_pending));
 			memset(&vcpu->arch.irq_clear, 0, sizeof(vcpu->arch.irq_clear));
+
+			/*
+			 * When vCPU reset, clear the ESTAT and GINTC registers
+			 * Other CSR registers are cleared with function _kvm_setcsr().
+			 */
+			kvm_write_sw_gcsr(vcpu->arch.csr, LOONGARCH_CSR_GINTC, 0);
+			kvm_write_sw_gcsr(vcpu->arch.csr, LOONGARCH_CSR_ESTAT, 0);
 			break;
 		default:
 			ret = -EINVAL;
diff --git a/arch/loongarch/mm/hugetlbpage.c b/arch/loongarch/mm/hugetlbpage.c
index e4068906143b..cea84d7f2b91 100644
--- a/arch/loongarch/mm/hugetlbpage.c
+++ b/arch/loongarch/mm/hugetlbpage.c
@@ -47,7 +47,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 				pmd = pmd_offset(pud, addr);
 		}
 	}
-	return (pte_t *) pmd;
+	return pmd_none(pmdp_get(pmd)) ? NULL : (pte_t *) pmd;
 }
 
 uint64_t pmd_to_entrylo(unsigned long pmd_val)
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 188b52bbb254..61497f9c3fef 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -65,9 +65,6 @@ void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
-#ifdef CONFIG_ZONE_DMA
-	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
-#endif
 #ifdef CONFIG_ZONE_DMA32
 	max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
 #endif
diff --git a/arch/mips/crypto/Kconfig b/arch/mips/crypto/Kconfig
index 9003a5c1e879..ee9604fd2037 100644
--- a/arch/mips/crypto/Kconfig
+++ b/arch/mips/crypto/Kconfig
@@ -12,9 +12,11 @@ config CRYPTO_CRC32_MIPS
 	  Architecture: mips
 
 config CRYPTO_POLY1305_MIPS
-	tristate "Hash functions: Poly1305"
+	tristate
 	depends on MIPS
+	select CRYPTO_HASH
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	default CRYPTO_LIB_POLY1305_INTERNAL
 	help
 	  Poly1305 authenticator algorithm (RFC7539)
 
@@ -61,10 +63,11 @@ config CRYPTO_SHA512_OCTEON
 	  Architecture: mips OCTEON using crypto instructions, when available
 
 config CRYPTO_CHACHA_MIPS
-	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12 (MIPS32r2)"
+	tristate
 	depends on CPU_MIPS32_R2
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	default CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
 	  stream cipher algorithms
diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 1e782275850a..9fb50827090a 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -59,6 +59,16 @@ extern phys_addr_t mips_cm_l2sync_phys_base(void);
  */
 extern int mips_cm_is64;
 
+/*
+ * mips_cm_is_l2_hci_broken  - determine if HCI is broken
+ *
+ * Some CM reports show that Hardware Cache Initialization is
+ * complete, but in reality it's not the case. They also incorrectly
+ * indicate that Hardware Cache Initialization is supported. This
+ * flags allows warning about this broken feature.
+ */
+extern bool mips_cm_is_l2_hci_broken;
+
 /**
  * mips_cm_error_report - Report CM cache errors
  */
@@ -97,6 +107,18 @@ static inline bool mips_cm_present(void)
 #endif
 }
 
+/**
+ * mips_cm_update_property - update property from the device tree
+ *
+ * Retrieve the properties from the device tree if a CM node exist and
+ * update the internal variable based on this.
+ */
+#ifdef CONFIG_MIPS_CM
+extern void mips_cm_update_property(void);
+#else
+static inline void mips_cm_update_property(void) {}
+#endif
+
 /**
  * mips_cm_has_l2sync - determine whether an L2-only sync region is present
  *
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 3eb2cfb893e1..9cfabaa94d01 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/of.h>
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 
@@ -14,6 +15,7 @@
 void __iomem *mips_gcr_base;
 void __iomem *mips_cm_l2sync_base;
 int mips_cm_is64;
+bool mips_cm_is_l2_hci_broken;
 
 static char *cm2_tr[8] = {
 	"mem",	"gcr",	"gic",	"mmio",
@@ -237,6 +239,18 @@ static void mips_cm_probe_l2sync(void)
 	mips_cm_l2sync_base = ioremap(addr, MIPS_CM_L2SYNC_SIZE);
 }
 
+void mips_cm_update_property(void)
+{
+	struct device_node *cm_node;
+
+	cm_node = of_find_compatible_node(of_root, NULL, "mobileye,eyeq6-cm");
+	if (!cm_node)
+		return;
+	pr_info("HCI (Hardware Cache Init for the L2 cache) in GCR_L2_RAM_CONFIG from the CM3 is broken");
+	mips_cm_is_l2_hci_broken = true;
+	of_node_put(cm_node);
+}
+
 int mips_cm_probe(void)
 {
 	phys_addr_t addr;
diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
index 0f9b3b5914cf..b70b67adb855 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -63,6 +63,7 @@ static unsigned long pdt_entry[MAX_PDT_ENTRIES] __page_aligned_bss;
 #define PDT_ADDR_PERM_ERR	(pdt_type != PDT_PDC ? 2UL : 0UL)
 #define PDT_ADDR_SINGLE_ERR	1UL
 
+#ifdef CONFIG_PROC_FS
 /* report PDT entries via /proc/meminfo */
 void arch_report_meminfo(struct seq_file *m)
 {
@@ -74,6 +75,7 @@ void arch_report_meminfo(struct seq_file *m)
 	seq_printf(m, "PDT_cur_entries: %7lu\n",
 			pdt_status.pdt_entries);
 }
+#endif
 
 static int get_info_pat_new(void)
 {
diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index 46a4c85e85e2..7012fa55aceb 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -3,10 +3,12 @@
 menu "Accelerated Cryptographic Algorithms for CPU (powerpc)"
 
 config CRYPTO_CURVE25519_PPC64
-	tristate "Public key crypto: Curve25519 (PowerPC64)"
+	tristate
 	depends on PPC64 && CPU_LITTLE_ENDIAN
+	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	default CRYPTO_LIB_CURVE25519_INTERNAL
 	help
 	  Curve25519 algorithm
 
@@ -124,11 +126,12 @@ config CRYPTO_AES_GCM_P10
 	  later CPU. This module supports stitched acceleration for AES/GCM.
 
 config CRYPTO_CHACHA20_P10
-	tristate "Ciphers: ChaCha20, XChacha20, XChacha12 (P10 or later)"
+	tristate
 	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	default CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
 	  stream cipher algorithms
diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index ad58dad9a580..c67095a3d669 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -22,7 +22,6 @@ config CRYPTO_CHACHA_RISCV64
 	tristate "Ciphers: ChaCha"
 	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_SKCIPHER
-	select CRYPTO_LIB_CHACHA_GENERIC
 	help
 	  Length-preserving ciphers: ChaCha20 stream cipher algorithm
 
diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index 721ec275ce57..231d777d936c 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -115,24 +115,19 @@
 	\old_c
 .endm
 
-#define _ALTERNATIVE_CFG(old_c, ...)	\
-	ALTERNATIVE_CFG old_c
-
-#define _ALTERNATIVE_CFG_2(old_c, ...)	\
-	ALTERNATIVE_CFG old_c
+#define __ALTERNATIVE_CFG(old_c, ...)		ALTERNATIVE_CFG old_c
+#define __ALTERNATIVE_CFG_2(old_c, ...)		ALTERNATIVE_CFG old_c
 
 #else /* !__ASSEMBLY__ */
 
-#define __ALTERNATIVE_CFG(old_c)	\
-	old_c "\n"
+#define __ALTERNATIVE_CFG(old_c, ...)		old_c "\n"
+#define __ALTERNATIVE_CFG_2(old_c, ...)		old_c "\n"
 
-#define _ALTERNATIVE_CFG(old_c, ...)	\
-	__ALTERNATIVE_CFG(old_c)
+#endif /* __ASSEMBLY__ */
 
-#define _ALTERNATIVE_CFG_2(old_c, ...)	\
-	__ALTERNATIVE_CFG(old_c)
+#define _ALTERNATIVE_CFG(old_c, ...)		__ALTERNATIVE_CFG(old_c)
+#define _ALTERNATIVE_CFG_2(old_c, ...)		__ALTERNATIVE_CFG_2(old_c)
 
-#endif /* __ASSEMBLY__ */
 #endif /* CONFIG_RISCV_ALTERNATIVE */
 
 /*
diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 8de73f91bfa3..b59ffeb668d6 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -34,11 +34,6 @@ static inline void flush_dcache_page(struct page *page)
 	flush_dcache_folio(page_folio(page));
 }
 
-/*
- * RISC-V doesn't have an instruction to flush parts of the instruction cache,
- * so instead we just flush the whole thing.
- */
-#define flush_icache_range(start, end) flush_icache_all()
 #define flush_icache_user_page(vma, pg, addr, len)	\
 do {							\
 	if (vma->vm_flags & VM_EXEC)			\
@@ -78,6 +73,16 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
 
 #endif /* CONFIG_SMP */
 
+/*
+ * RISC-V doesn't have an instruction to flush parts of the instruction cache,
+ * so instead we just flush the whole thing.
+ */
+#define flush_icache_range flush_icache_range
+static inline void flush_icache_range(unsigned long start, unsigned long end)
+{
+	flush_icache_all();
+}
+
 extern unsigned int riscv_cbom_block_size;
 extern unsigned int riscv_cboz_block_size;
 void riscv_init_cbo_blocksizes(void);
diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index 4b3dc8beaf77..cc15f7ca6cc1 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -167,6 +167,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 	/* Initialize the slot */
 	void *kaddr = kmap_atomic(page);
 	void *dst = kaddr + (vaddr & ~PAGE_MASK);
+	unsigned long start = (unsigned long)dst;
 
 	memcpy(dst, src, len);
 
@@ -176,13 +177,6 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 		*(uprobe_opcode_t *)dst = __BUG_INSN_32;
 	}
 
+	flush_icache_range(start, start + len);
 	kunmap_atomic(kaddr);
-
-	/*
-	 * We probably need flush_icache_user_page() but it needs vma.
-	 * This should work on most of architectures by default. If
-	 * architecture needs to do something different it can define
-	 * its own version of the function.
-	 */
-	flush_dcache_page(page);
 }
diff --git a/arch/s390/crypto/Kconfig b/arch/s390/crypto/Kconfig
index d3eb3a233693..16ced2203935 100644
--- a/arch/s390/crypto/Kconfig
+++ b/arch/s390/crypto/Kconfig
@@ -120,11 +120,12 @@ config CRYPTO_DES_S390
 	  As of z196 the CTR mode is hardware accelerated.
 
 config CRYPTO_CHACHA_S390
-	tristate "Ciphers: ChaCha20"
+	tristate
 	depends on S390
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	default CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Length-preserving cipher: ChaCha20 stream cipher (RFC 7539)
 
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index b16352083ff9..f0be263b334c 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -94,7 +94,7 @@ static int handle_validity(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.exit_validity++;
 	trace_kvm_s390_intercept_validity(vcpu, viwhy);
-	KVM_EVENT(3, "validity intercept 0x%x for pid %u (kvm 0x%pK)", viwhy,
+	KVM_EVENT(3, "validity intercept 0x%x for pid %u (kvm 0x%p)", viwhy,
 		  current->pid, vcpu->kvm);
 
 	/* do not warn on invalid runtime instrumentation mode */
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 4f0e7f61edf7..bc65fa6dc155 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3161,7 +3161,7 @@ void kvm_s390_gisa_clear(struct kvm *kvm)
 	if (!gi->origin)
 		return;
 	gisa_clear_ipm(gi->origin);
-	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", gi->origin);
+	VM_EVENT(kvm, 3, "gisa 0x%p cleared", gi->origin);
 }
 
 void kvm_s390_gisa_init(struct kvm *kvm)
@@ -3178,7 +3178,7 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 	gi->timer.function = gisa_vcpu_kicker;
 	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
 	gi->origin->next_alert = (u32)virt_to_phys(gi->origin);
-	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
+	VM_EVENT(kvm, 3, "gisa 0x%p initialized", gi->origin);
 }
 
 void kvm_s390_gisa_enable(struct kvm *kvm)
@@ -3219,7 +3219,7 @@ void kvm_s390_gisa_destroy(struct kvm *kvm)
 		process_gib_alert_list();
 	hrtimer_cancel(&gi->timer);
 	gi->origin = NULL;
-	VM_EVENT(kvm, 3, "gisa 0x%pK destroyed", gisa);
+	VM_EVENT(kvm, 3, "gisa 0x%p destroyed", gisa);
 }
 
 void kvm_s390_gisa_disable(struct kvm *kvm)
@@ -3468,7 +3468,7 @@ int __init kvm_s390_gib_init(u8 nisc)
 		}
 	}
 
-	KVM_EVENT(3, "gib 0x%pK (nisc=%d) initialized", gib, gib->nisc);
+	KVM_EVENT(3, "gib 0x%p (nisc=%d) initialized", gib, gib->nisc);
 	goto out;
 
 out_unreg_gal:
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index bb7134faaebf..286a224c81ee 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -998,7 +998,7 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		}
 		mutex_unlock(&kvm->lock);
 		VM_EVENT(kvm, 3, "SET: max guest address: %lu", new_limit);
-		VM_EVENT(kvm, 3, "New guest asce: 0x%pK",
+		VM_EVENT(kvm, 3, "New guest asce: 0x%p",
 			 (void *) kvm->arch.gmap->asce);
 		break;
 	}
@@ -3421,7 +3421,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		kvm_s390_gisa_init(kvm);
 	INIT_LIST_HEAD(&kvm->arch.pv.need_cleanup);
 	kvm->arch.pv.set_aside = NULL;
-	KVM_EVENT(3, "vm 0x%pK created by pid %u", kvm, current->pid);
+	KVM_EVENT(3, "vm 0x%p created by pid %u", kvm, current->pid);
 
 	return 0;
 out_err:
@@ -3484,7 +3484,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_s390_destroy_adapters(kvm);
 	kvm_s390_clear_float_irqs(kvm);
 	kvm_s390_vsie_destroy(kvm);
-	KVM_EVENT(3, "vm 0x%pK destroyed", kvm);
+	KVM_EVENT(3, "vm 0x%p destroyed", kvm);
 }
 
 /* Section: vcpu related */
@@ -3605,7 +3605,7 @@ static int sca_switch_to_extended(struct kvm *kvm)
 
 	free_page((unsigned long)old_sca);
 
-	VM_EVENT(kvm, 2, "Switched to ESCA (0x%pK -> 0x%pK)",
+	VM_EVENT(kvm, 2, "Switched to ESCA (0x%p -> 0x%p)",
 		 old_sca, kvm->arch.sca);
 	return 0;
 }
@@ -3978,7 +3978,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 			goto out_free_sie_block;
 	}
 
-	VM_EVENT(vcpu->kvm, 3, "create cpu %d at 0x%pK, sie block at 0x%pK",
+	VM_EVENT(vcpu->kvm, 3, "create cpu %d at 0x%p, sie block at 0x%p",
 		 vcpu->vcpu_id, vcpu, vcpu->arch.sie_block);
 	trace_kvm_s390_create_vcpu(vcpu->vcpu_id, vcpu, vcpu->arch.sie_block);
 
diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
index 9ac92dbf680d..9e28f165c114 100644
--- a/arch/s390/kvm/trace-s390.h
+++ b/arch/s390/kvm/trace-s390.h
@@ -56,7 +56,7 @@ TRACE_EVENT(kvm_s390_create_vcpu,
 		    __entry->sie_block = sie_block;
 		    ),
 
-	    TP_printk("create cpu %d at 0x%pK, sie block at 0x%pK",
+	    TP_printk("create cpu %d at 0x%p, sie block at 0x%p",
 		      __entry->id, __entry->vcpu, __entry->sie_block)
 	);
 
@@ -255,7 +255,7 @@ TRACE_EVENT(kvm_s390_enable_css,
 		    __entry->kvm = kvm;
 		    ),
 
-	    TP_printk("enabling channel I/O support (kvm @ %pK)\n",
+	    TP_printk("enabling channel I/O support (kvm @ %p)\n",
 		      __entry->kvm)
 	);
 
diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index b22226634ff6..138908b999d7 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -83,6 +83,8 @@ extern void time_travel_not_configured(void);
 #define time_travel_del_event(...) time_travel_not_configured()
 #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 
+extern unsigned long tt_extra_sched_jiffies;
+
 /*
  * Without CONFIG_UML_TIME_TRAVEL_SUPPORT this is a linker error if used,
  * which is intentional since we really shouldn't link it in that case.
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index b09e85279d2b..a5beaea2967e 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -31,6 +31,17 @@ void handle_syscall(struct uml_pt_regs *r)
 		goto out;
 
 	syscall = UPT_SYSCALL_NR(r);
+
+	/*
+	 * If no time passes, then sched_yield may not actually yield, causing
+	 * broken spinlock implementations in userspace (ASAN) to hang for long
+	 * periods of time.
+	 */
+	if ((time_travel_mode == TT_MODE_INFCPU ||
+	     time_travel_mode == TT_MODE_EXTERNAL) &&
+	    syscall == __NR_sched_yield)
+		tt_extra_sched_jiffies += 1;
+
 	if (syscall >= 0 && syscall < __NR_syscalls) {
 		unsigned long ret = EXECUTE_SYSCALL(syscall, regs);
 
diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 7b1bebed879d..46b53ab06165 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -3,10 +3,12 @@
 menu "Accelerated Cryptographic Algorithms for CPU (x86)"
 
 config CRYPTO_CURVE25519_X86
-	tristate "Public key crypto: Curve25519 (ADX)"
+	tristate
 	depends on X86 && 64BIT
+	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	default CRYPTO_LIB_CURVE25519_INTERNAL
 	help
 	  Curve25519 algorithm
 
@@ -348,11 +350,12 @@ config CRYPTO_ARIA_GFNI_AVX512_X86_64
 	  Processes 64 blocks in parallel.
 
 config CRYPTO_CHACHA20_X86_64
-	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12 (SSSE3/AVX2/AVX-512VL)"
+	tristate
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	default CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
 	  stream cipher algorithms
@@ -417,10 +420,12 @@ config CRYPTO_POLYVAL_CLMUL_NI
 	  - CLMUL-NI (carry-less multiplication new instructions)
 
 config CRYPTO_POLY1305_X86_64
-	tristate "Hash functions: Poly1305 (SSE2/AVX2)"
+	tristate
 	depends on X86 && 64BIT
+	select CRYPTO_HASH
 	select CRYPTO_LIB_POLY1305_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	default CRYPTO_LIB_POLY1305_INTERNAL
 	help
 	  Poly1305 authenticator algorithm (RFC7539)
 
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index b7ea3e8e9ecc..58e3124ee2b4 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -18,7 +18,7 @@
 
 SYM_FUNC_START(entry_ibpb)
 	movl	$MSR_IA32_PRED_CMD, %ecx
-	movl	$PRED_CMD_IBPB, %eax
+	movl	_ASM_RIP(x86_pred_cmd), %eax
 	xorl	%edx, %edx
 	wrmsr
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0d33c85da453..d737d53d03aa 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -628,7 +628,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type == event->pmu->type)
 		event->hw.config |= x86_pmu_get_event_config(event);
 
-	if (!event->attr.freq && x86_pmu.limit_period) {
+	if (is_sampling_event(event) && !event->attr.freq && x86_pmu.limit_period) {
 		s64 left = event->attr.sample_period;
 		x86_pmu.limit_period(event, &left);
 		if (left > event->attr.sample_period)
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 913fd3a7bac6..64fa42175a15 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -449,6 +449,7 @@
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
+#define X86_FEATURE_HV_INUSE_WR_ALLOWED	(19*32+30) /* Allow Write to in-use hypervisor-owned pages */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Breakpoints */
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 1a42f829667a..62d8b9448dc5 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -115,6 +115,8 @@
 #define INTEL_GRANITERAPIDS_X		IFM(6, 0xAD)
 #define INTEL_GRANITERAPIDS_D		IFM(6, 0xAE)
 
+#define INTEL_BARTLETTLAKE		IFM(6, 0xD7) /* Raptor Cove */
+
 /* "Hybrid" Processors (P-Core/E-Core) */
 
 #define INTEL_LAKEFIELD			IFM(6, 0x8A) /* Sunny Cove / Tremont */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5fba44a4f988..46bddb5bb15f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1578,7 +1578,7 @@ static void __init spec_ctrl_disable_kernel_rrsba(void)
 	rrsba_disabled = true;
 }
 
-static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_mitigation mode)
+static void __init spectre_v2_select_rsb_mitigation(enum spectre_v2_mitigation mode)
 {
 	/*
 	 * Similar to context switches, there are two types of RSB attacks
@@ -1602,27 +1602,30 @@ static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_
 	 */
 	switch (mode) {
 	case SPECTRE_V2_NONE:
-		return;
+		break;
 
-	case SPECTRE_V2_EIBRS_LFENCE:
 	case SPECTRE_V2_EIBRS:
+	case SPECTRE_V2_EIBRS_LFENCE:
+	case SPECTRE_V2_EIBRS_RETPOLINE:
 		if (boot_cpu_has_bug(X86_BUG_EIBRS_PBRSB)) {
-			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
 			pr_info("Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT\n");
+			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
 		}
-		return;
+		break;
 
-	case SPECTRE_V2_EIBRS_RETPOLINE:
 	case SPECTRE_V2_RETPOLINE:
 	case SPECTRE_V2_LFENCE:
 	case SPECTRE_V2_IBRS:
+		pr_info("Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT\n");
+		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 		setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT);
-		pr_info("Spectre v2 / SpectreRSB : Filling RSB on VMEXIT\n");
-		return;
-	}
+		break;
 
-	pr_warn_once("Unknown Spectre v2 mode, disabling RSB mitigation at VM exit");
-	dump_stack();
+	default:
+		pr_warn_once("Unknown Spectre v2 mode, disabling RSB mitigation\n");
+		dump_stack();
+		break;
+	}
 }
 
 /*
@@ -1854,10 +1857,7 @@ static void __init spectre_v2_select_mitigation(void)
 	 *
 	 * FIXME: Is this pointless for retbleed-affected AMD?
 	 */
-	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
-	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
-
-	spectre_v2_determine_rsb_fill_type_at_vmexit(mode);
+	spectre_v2_select_rsb_mitigation(mode);
 
 	/*
 	 * Retpoline protects the kernel, but doesn't protect firmware.  IBRS
diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index 80e262bb627f..cb9852ad6098 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -46,7 +46,8 @@ bool __init pit_timer_init(void)
 		 * VMMs otherwise steal CPU time just to pointlessly waggle
 		 * the (masked) IRQ.
 		 */
-		clockevent_i8253_disable();
+		scoped_guard(irq)
+			clockevent_i8253_disable();
 		return false;
 	}
 	clockevent_i8253_init(true);
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 4b74ea91f4e6..63dea8ecd7ef 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -820,7 +820,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 	 * Allocating new amd_iommu_pi_data, which will get
 	 * add to the per-vcpu ir_list.
 	 */
-	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_KERNEL_ACCOUNT);
+	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_ATOMIC | __GFP_ACCOUNT);
 	if (!ir) {
 		ret = -ENOMEM;
 		goto out;
@@ -896,6 +896,7 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 {
 	struct kvm_kernel_irq_routing_entry *e;
 	struct kvm_irq_routing_table *irq_rt;
+	bool enable_remapped_mode = true;
 	int idx, ret = 0;
 
 	if (!kvm_arch_has_assigned_device(kvm) ||
@@ -933,6 +934,8 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 		    kvm_vcpu_apicv_active(&svm->vcpu)) {
 			struct amd_iommu_pi_data pi;
 
+			enable_remapped_mode = false;
+
 			/* Try to enable guest_mode in IRTE */
 			pi.base = __sme_set(page_to_phys(svm->avic_backing_page) &
 					    AVIC_HPA_MASK);
@@ -951,33 +954,6 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 			 */
 			if (!ret && pi.is_guest_mode)
 				svm_ir_list_add(svm, &pi);
-		} else {
-			/* Use legacy mode in IRTE */
-			struct amd_iommu_pi_data pi;
-
-			/**
-			 * Here, pi is used to:
-			 * - Tell IOMMU to use legacy mode for this interrupt.
-			 * - Retrieve ga_tag of prior interrupt remapping data.
-			 */
-			pi.prev_ga_tag = 0;
-			pi.is_guest_mode = false;
-			ret = irq_set_vcpu_affinity(host_irq, &pi);
-
-			/**
-			 * Check if the posted interrupt was previously
-			 * setup with the guest_mode by checking if the ga_tag
-			 * was cached. If so, we need to clean up the per-vcpu
-			 * ir_list.
-			 */
-			if (!ret && pi.prev_ga_tag) {
-				int id = AVIC_GATAG_TO_VCPUID(pi.prev_ga_tag);
-				struct kvm_vcpu *vcpu;
-
-				vcpu = kvm_get_vcpu_by_id(kvm, id);
-				if (vcpu)
-					svm_ir_list_del(to_svm(vcpu), &pi);
-			}
 		}
 
 		if (!ret && svm) {
@@ -993,6 +969,34 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 	}
 
 	ret = 0;
+	if (enable_remapped_mode) {
+		/* Use legacy mode in IRTE */
+		struct amd_iommu_pi_data pi;
+
+		/**
+		 * Here, pi is used to:
+		 * - Tell IOMMU to use legacy mode for this interrupt.
+		 * - Retrieve ga_tag of prior interrupt remapping data.
+		 */
+		pi.prev_ga_tag = 0;
+		pi.is_guest_mode = false;
+		ret = irq_set_vcpu_affinity(host_irq, &pi);
+
+		/**
+		 * Check if the posted interrupt was previously
+		 * setup with the guest_mode by checking if the ga_tag
+		 * was cached. If so, we need to clean up the per-vcpu
+		 * ir_list.
+		 */
+		if (!ret && pi.prev_ga_tag) {
+			int id = AVIC_GATAG_TO_VCPUID(pi.prev_ga_tag);
+			struct kvm_vcpu *vcpu;
+
+			vcpu = kvm_get_vcpu_by_id(kvm, id);
+			if (vcpu)
+				svm_ir_list_del(to_svm(vcpu), &pi);
+		}
+	}
 out:
 	srcu_read_unlock(&kvm->irq_srcu, idx);
 	return ret;
@@ -1199,6 +1203,12 @@ bool avic_hardware_setup(void)
 		return false;
 	}
 
+	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP) &&
+	    !boot_cpu_has(X86_FEATURE_HV_INUSE_WR_ALLOWED)) {
+		pr_warn("AVIC disabled: missing HvInUseWrAllowed on SNP-enabled system\n");
+		return false;
+	}
+
 	if (boot_cpu_has(X86_FEATURE_AVIC)) {
 		pr_info("AVIC enabled\n");
 	} else if (force_avic) {
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index ec08fa3caf43..6b803324a981 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -274,6 +274,7 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 {
 	struct kvm_kernel_irq_routing_entry *e;
 	struct kvm_irq_routing_table *irq_rt;
+	bool enable_remapped_mode = true;
 	struct kvm_lapic_irq irq;
 	struct kvm_vcpu *vcpu;
 	struct vcpu_data vcpu_info;
@@ -312,21 +313,8 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 
 		kvm_set_msi_irq(kvm, e, &irq);
 		if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu) ||
-		    !kvm_irq_is_postable(&irq)) {
-			/*
-			 * Make sure the IRTE is in remapped mode if
-			 * we don't handle it in posted mode.
-			 */
-			ret = irq_set_vcpu_affinity(host_irq, NULL);
-			if (ret < 0) {
-				printk(KERN_INFO
-				   "failed to back to remapped mode, irq: %u\n",
-				   host_irq);
-				goto out;
-			}
-
+		    !kvm_irq_is_postable(&irq))
 			continue;
-		}
 
 		vcpu_info.pi_desc_addr = __pa(vcpu_to_pi_desc(vcpu));
 		vcpu_info.vector = irq.vector;
@@ -334,11 +322,12 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, e->gsi,
 				vcpu_info.vector, vcpu_info.pi_desc_addr, set);
 
-		if (set)
-			ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
-		else
-			ret = irq_set_vcpu_affinity(host_irq, NULL);
+		if (!set)
+			continue;
 
+		enable_remapped_mode = false;
+
+		ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
 		if (ret < 0) {
 			printk(KERN_INFO "%s: failed to update PI IRTE\n",
 					__func__);
@@ -346,6 +335,9 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 		}
 	}
 
+	if (enable_remapped_mode)
+		ret = irq_set_vcpu_affinity(host_irq, NULL);
+
 	ret = 0;
 out:
 	srcu_read_unlock(&kvm->irq_srcu, idx);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1a4ca471d63d..7a5367b14518 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13555,15 +13555,22 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 {
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
 	int ret;
 
-	irqfd->producer = prod;
 	kvm_arch_start_assignment(irqfd->kvm);
+
+	spin_lock_irq(&kvm->irqfds.lock);
+	irqfd->producer = prod;
+
 	ret = kvm_x86_call(pi_update_irte)(irqfd->kvm,
 					   prod->irq, irqfd->gsi, 1);
 	if (ret)
 		kvm_arch_end_assignment(irqfd->kvm);
 
+	spin_unlock_irq(&kvm->irqfds.lock);
+
+
 	return ret;
 }
 
@@ -13573,9 +13580,9 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	int ret;
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
 
 	WARN_ON(irqfd->producer != prod);
-	irqfd->producer = NULL;
 
 	/*
 	 * When producer of consumer is unregistered, we change back to
@@ -13583,12 +13590,18 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	 * when the irq is masked/disabled or the consumer side (KVM
 	 * int this case doesn't want to receive the interrupts.
 	*/
+	spin_lock_irq(&kvm->irqfds.lock);
+	irqfd->producer = NULL;
+
 	ret = kvm_x86_call(pi_update_irte)(irqfd->kvm,
 					   prod->irq, irqfd->gsi, 0);
 	if (ret)
 		printk(KERN_INFO "irq bypass consumer (token %p) unregistration"
 		       " fails: %d\n", irqfd->consumer.token, ret);
 
+	spin_unlock_irq(&kvm->irqfds.lock);
+
+
 	kvm_arch_end_assignment(irqfd->kvm);
 }
 
@@ -13601,7 +13614,8 @@ int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
 bool kvm_arch_irqfd_route_changed(struct kvm_kernel_irq_routing_entry *old,
 				  struct kvm_kernel_irq_routing_entry *new)
 {
-	if (new->type != KVM_IRQ_ROUTING_MSI)
+	if (old->type != KVM_IRQ_ROUTING_MSI ||
+	    new->type != KVM_IRQ_ROUTING_MSI)
 		return true;
 
 	return !!memcmp(&old->msi, &new->msi, sizeof(new->msi));
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index caedb3ef6688..f5dd84eb55dc 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -996,8 +996,8 @@ AVXcode: 4
 83: Grp1 Ev,Ib (1A),(es)
 # CTESTSCC instructions are: CTESTB, CTESTBE, CTESTF, CTESTL, CTESTLE, CTESTNB, CTESTNBE, CTESTNL,
 #			     CTESTNLE, CTESTNO, CTESTNS, CTESTNZ, CTESTO, CTESTS, CTESTT, CTESTZ
-84: CTESTSCC (ev)
-85: CTESTSCC (es) | CTESTSCC (66),(es)
+84: CTESTSCC Eb,Gb (ev)
+85: CTESTSCC Ev,Gv (es) | CTESTSCC Ev,Gv (66),(es)
 88: POPCNT Gv,Ev (es) | POPCNT Gv,Ev (66),(es)
 8f: POP2 Bq,Rq (000),(11B),(ev)
 a5: SHLD Ev,Gv,CL (es) | SHLD Ev,Gv,CL (66),(es)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 00ffa74d0dd0..27d81cb049ff 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -389,9 +389,9 @@ static void cond_mitigation(struct task_struct *next)
 	prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_spec);
 
 	/*
-	 * Avoid user/user BTB poisoning by flushing the branch predictor
-	 * when switching between processes. This stops one process from
-	 * doing Spectre-v2 attacks on another.
+	 * Avoid user->user BTB/RSB poisoning by flushing them when switching
+	 * between processes. This stops one process from doing Spectre-v2
+	 * attacks on another.
 	 *
 	 * Both, the conditional and the always IBPB mode use the mm
 	 * pointer to avoid the IBPB when switching between tasks of the
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 0f2fe524f60d..b8755cde2419 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -436,7 +436,8 @@ static struct msi_domain_ops xen_pci_msi_domain_ops = {
 };
 
 static struct msi_domain_info xen_pci_msi_domain_info = {
-	.flags			= MSI_FLAG_PCI_MSIX | MSI_FLAG_FREE_MSI_DESCS | MSI_FLAG_DEV_SYSFS,
+	.flags			= MSI_FLAG_PCI_MSIX | MSI_FLAG_FREE_MSI_DESCS |
+				  MSI_FLAG_DEV_SYSFS | MSI_FLAG_NO_MASK,
 	.ops			= &xen_pci_msi_domain_ops,
 };
 
@@ -484,11 +485,6 @@ static __init void xen_setup_pci_msi(void)
 	 * in allocating the native domain and never use it.
 	 */
 	x86_init.irqs.create_pci_msi_domain = xen_create_pci_msi_domain;
-	/*
-	 * With XEN PIRQ/Eventchannels in use PCI/MSI[-X] masking is solely
-	 * controlled by the hypervisor.
-	 */
-	pci_msi_ignore_mask = 1;
 }
 
 #else /* CONFIG_PCI_MSI */
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 0e3d930bcb89..9d25d9373945 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/acpi.h>
+#include <linux/cpufreq.h>
+#include <linux/cpuidle.h>
 #include <linux/export.h>
 #include <linux/mm.h>
 
@@ -123,8 +125,23 @@ static void __init pvh_arch_setup(void)
 {
 	pvh_reserve_extra_memory();
 
-	if (xen_initial_domain())
+	if (xen_initial_domain()) {
 		xen_add_preferred_consoles();
+
+		/*
+		 * Disable usage of CPU idle and frequency drivers: when
+		 * running as hardware domain the exposed native ACPI tables
+		 * causes idle and/or frequency drivers to attach and
+		 * malfunction.  It's Xen the entity that controls the idle and
+		 * frequency states.
+		 *
+		 * For unprivileged domains the exposed ACPI tables are
+		 * fabricated and don't contain such data.
+		 */
+		disable_cpuidle();
+		disable_cpufreq();
+		WARN_ON(xen_set_default_idle());
+	}
 }
 
 void __init xen_pvh_init(struct boot_params *boot_params)
diff --git a/block/blk-merge.c b/block/blk-merge.c
index ceac64e796ea..f575cc1705b3 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -864,12 +864,13 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (rq_data_dir(req) != rq_data_dir(next))
 		return NULL;
 
-	/* Don't merge requests with different write hints. */
-	if (req->write_hint != next->write_hint)
-		return NULL;
-
-	if (req->ioprio != next->ioprio)
-		return NULL;
+	if (req->bio && next->bio) {
+		/* Don't merge requests with different write hints. */
+		if (req->bio->bi_write_hint != next->bio->bi_write_hint)
+			return NULL;
+		if (req->bio->bi_ioprio != next->bio->bi_ioprio)
+			return NULL;
+	}
 
 	if (!blk_atomic_write_mergeable_rqs(req, next))
 		return NULL;
@@ -998,12 +999,13 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (!bio_crypt_rq_ctx_compatible(rq, bio))
 		return false;
 
-	/* Don't merge requests with different write hints. */
-	if (rq->write_hint != bio->bi_write_hint)
-		return false;
-
-	if (rq->ioprio != bio_prio(bio))
-		return false;
+	if (rq->bio) {
+		/* Don't merge requests with different write hints. */
+		if (rq->bio->bi_write_hint != bio->bi_write_hint)
+			return false;
+		if (rq->bio->bi_ioprio != bio->bi_ioprio)
+			return false;
+	}
 
 	if (blk_atomic_write_mergeable_rq_bio(rq, bio) == false)
 		return false;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f26bee562693..a7765e96cf40 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -870,7 +870,7 @@ static void blk_print_req_error(struct request *req, blk_status_t status)
 		blk_op_str(req_op(req)),
 		(__force u32)(req->cmd_flags & ~REQ_OP_MASK),
 		req->nr_phys_segments,
-		IOPRIO_PRIO_CLASS(req->ioprio));
+		IOPRIO_PRIO_CLASS(req_get_ioprio(req)));
 }
 
 /*
@@ -2654,7 +2654,6 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 		rq->cmd_flags |= REQ_FAILFAST_MASK;
 
 	rq->__sector = bio->bi_iter.bi_sector;
-	rq->write_hint = bio->bi_write_hint;
 	blk_rq_bio_prep(rq, bio, nr_segs);
 	if (bio_integrity(bio))
 		rq->nr_integrity_segments = blk_rq_count_integrity_sg(rq->q,
@@ -3307,8 +3306,7 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 		rq->special_vec = rq_src->special_vec;
 	}
 	rq->nr_phys_segments = rq_src->nr_phys_segments;
-	rq->ioprio = rq_src->ioprio;
-	rq->write_hint = rq_src->write_hint;
+	rq->nr_integrity_segments = rq_src->nr_integrity_segments;
 
 	if (rq->bio && blk_crypto_rq_bio_prep(rq, rq->bio, gfp_mask) < 0)
 		goto free_and_out;
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 7abf034089cd..1e63e3dd5440 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -61,8 +61,14 @@ void blk_apply_bdi_limits(struct backing_dev_info *bdi,
 	/*
 	 * For read-ahead of large files to be effective, we need to read ahead
 	 * at least twice the optimal I/O size.
+	 *
+	 * There is no hardware limitation for the read-ahead size and the user
+	 * might have increased the read-ahead size through sysfs, so don't ever
+	 * decrease it.
 	 */
-	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
+	bdi->ra_pages = max3(bdi->ra_pages,
+				lim->io_opt * 2 / PAGE_SIZE,
+				VM_READAHEAD_PAGES);
 	bdi->io_pages = lim->max_sectors >> PAGE_SECTORS_SHIFT;
 }
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index acdc28756d9d..91b3789f710e 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -685,10 +685,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	prio = ioprio_class_to_prio[ioprio_class];
 	per_prio = &dd->per_prio[prio];
-	if (!rq->elv.priv[0]) {
+	if (!rq->elv.priv[0])
 		per_prio->stats.inserted++;
-		rq->elv.priv[0] = (void *)(uintptr_t)1;
-	}
+	rq->elv.priv[0] = per_prio;
 
 	if (blk_mq_sched_try_insert_merge(q, rq, free))
 		return;
@@ -753,18 +752,14 @@ static void dd_prepare_request(struct request *rq)
  */
 static void dd_finish_request(struct request *rq)
 {
-	struct request_queue *q = rq->q;
-	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(rq);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
-	struct dd_per_prio *per_prio = &dd->per_prio[prio];
+	struct dd_per_prio *per_prio = rq->elv.priv[0];
 
 	/*
 	 * The block layer core may call dd_finish_request() without having
 	 * called dd_insert_requests(). Skip requests that bypassed I/O
 	 * scheduling. See also blk_mq_request_bypass_insert().
 	 */
-	if (rq->elv.priv[0])
+	if (per_prio)
 		atomic_inc(&per_prio->stats.completed);
 }
 
diff --git a/crypto/Kconfig b/crypto/Kconfig
index a779cab668c2..e7528986e94f 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -317,6 +317,7 @@ config CRYPTO_CURVE25519
 	tristate "Curve25519"
 	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
+	select CRYPTO_LIB_CURVE25519_INTERNAL
 	help
 	  Curve25519 elliptic curve (RFC7748)
 
@@ -615,6 +616,7 @@ config CRYPTO_ARC4
 config CRYPTO_CHACHA20
 	tristate "ChaCha"
 	select CRYPTO_LIB_CHACHA_GENERIC
+	select CRYPTO_LIB_CHACHA_INTERNAL
 	select CRYPTO_SKCIPHER
 	help
 	  The ChaCha20, XChaCha20, and XChaCha12 stream cipher algorithms
@@ -944,6 +946,7 @@ config CRYPTO_POLY1305
 	tristate "Poly1305"
 	select CRYPTO_HASH
 	select CRYPTO_LIB_POLY1305_GENERIC
+	select CRYPTO_LIB_POLY1305_INTERNAL
 	help
 	  Poly1305 authenticator algorithm (RFC7539)
 
diff --git a/crypto/crypto_null.c b/crypto/crypto_null.c
index 5b84b0f7cc17..337867028653 100644
--- a/crypto/crypto_null.c
+++ b/crypto/crypto_null.c
@@ -17,10 +17,10 @@
 #include <crypto/internal/skcipher.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/mm.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 
-static DEFINE_MUTEX(crypto_default_null_skcipher_lock);
+static DEFINE_SPINLOCK(crypto_default_null_skcipher_lock);
 static struct crypto_sync_skcipher *crypto_default_null_skcipher;
 static int crypto_default_null_skcipher_refcnt;
 
@@ -152,23 +152,32 @@ MODULE_ALIAS_CRYPTO("cipher_null");
 
 struct crypto_sync_skcipher *crypto_get_default_null_skcipher(void)
 {
+	struct crypto_sync_skcipher *ntfm = NULL;
 	struct crypto_sync_skcipher *tfm;
 
-	mutex_lock(&crypto_default_null_skcipher_lock);
+	spin_lock_bh(&crypto_default_null_skcipher_lock);
 	tfm = crypto_default_null_skcipher;
 
 	if (!tfm) {
-		tfm = crypto_alloc_sync_skcipher("ecb(cipher_null)", 0, 0);
-		if (IS_ERR(tfm))
-			goto unlock;
-
-		crypto_default_null_skcipher = tfm;
+		spin_unlock_bh(&crypto_default_null_skcipher_lock);
+
+		ntfm = crypto_alloc_sync_skcipher("ecb(cipher_null)", 0, 0);
+		if (IS_ERR(ntfm))
+			return ntfm;
+
+		spin_lock_bh(&crypto_default_null_skcipher_lock);
+		tfm = crypto_default_null_skcipher;
+		if (!tfm) {
+			tfm = ntfm;
+			ntfm = NULL;
+			crypto_default_null_skcipher = tfm;
+		}
 	}
 
 	crypto_default_null_skcipher_refcnt++;
+	spin_unlock_bh(&crypto_default_null_skcipher_lock);
 
-unlock:
-	mutex_unlock(&crypto_default_null_skcipher_lock);
+	crypto_free_sync_skcipher(ntfm);
 
 	return tfm;
 }
@@ -176,12 +185,16 @@ EXPORT_SYMBOL_GPL(crypto_get_default_null_skcipher);
 
 void crypto_put_default_null_skcipher(void)
 {
-	mutex_lock(&crypto_default_null_skcipher_lock);
+	struct crypto_sync_skcipher *tfm = NULL;
+
+	spin_lock_bh(&crypto_default_null_skcipher_lock);
 	if (!--crypto_default_null_skcipher_refcnt) {
-		crypto_free_sync_skcipher(crypto_default_null_skcipher);
+		tfm = crypto_default_null_skcipher;
 		crypto_default_null_skcipher = NULL;
 	}
-	mutex_unlock(&crypto_default_null_skcipher_lock);
+	spin_unlock_bh(&crypto_default_null_skcipher_lock);
+
+	crypto_free_sync_skcipher(tfm);
 }
 EXPORT_SYMBOL_GPL(crypto_put_default_null_skcipher);
 
diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 38b4158f5278..88df2cdc46b6 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2025 Intel Corporation
  */
 
 #include <linux/firmware.h>
@@ -54,9 +54,9 @@ u8 ivpu_pll_max_ratio = U8_MAX;
 module_param_named(pll_max_ratio, ivpu_pll_max_ratio, byte, 0644);
 MODULE_PARM_DESC(pll_max_ratio, "Maximum PLL ratio used to set NPU frequency");
 
-int ivpu_sched_mode;
+int ivpu_sched_mode = IVPU_SCHED_MODE_AUTO;
 module_param_named(sched_mode, ivpu_sched_mode, int, 0444);
-MODULE_PARM_DESC(sched_mode, "Scheduler mode: 0 - Default scheduler, 1 - Force HW scheduler");
+MODULE_PARM_DESC(sched_mode, "Scheduler mode: -1 - Use default scheduler, 0 - Use OS scheduler, 1 - Use HW scheduler");
 
 bool ivpu_disable_mmu_cont_pages;
 module_param_named(disable_mmu_cont_pages, ivpu_disable_mmu_cont_pages, bool, 0444);
@@ -165,7 +165,7 @@ static int ivpu_get_param_ioctl(struct drm_device *dev, void *data, struct drm_f
 		args->value = vdev->platform;
 		break;
 	case DRM_IVPU_PARAM_CORE_CLOCK_RATE:
-		args->value = ivpu_hw_ratio_to_freq(vdev, vdev->hw->pll.max_ratio);
+		args->value = ivpu_hw_dpu_max_freq_get(vdev);
 		break;
 	case DRM_IVPU_PARAM_NUM_CONTEXTS:
 		args->value = ivpu_get_context_count(vdev);
@@ -347,7 +347,7 @@ static int ivpu_hw_sched_init(struct ivpu_device *vdev)
 {
 	int ret = 0;
 
-	if (vdev->hw->sched_mode == VPU_SCHEDULING_MODE_HW) {
+	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW) {
 		ret = ivpu_jsm_hws_setup_priority_bands(vdev);
 		if (ret) {
 			ivpu_err(vdev, "Failed to enable hw scheduler: %d", ret);
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 2b30cc2e9272..9430a24994c3 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -57,6 +57,8 @@
 #define IVPU_PLATFORM_FPGA    3
 #define IVPU_PLATFORM_INVALID 8
 
+#define IVPU_SCHED_MODE_AUTO -1
+
 #define IVPU_DBG_REG	 BIT(0)
 #define IVPU_DBG_IRQ	 BIT(1)
 #define IVPU_DBG_MMU	 BIT(2)
diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index b2b6d89f0653..8a9395a2abb5 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2025 Intel Corporation
  */
 
 #include <linux/firmware.h>
@@ -134,6 +134,15 @@ static bool is_within_range(u64 addr, size_t size, u64 range_start, size_t range
 	return true;
 }
 
+static u32
+ivpu_fw_sched_mode_select(struct ivpu_device *vdev, const struct vpu_firmware_header *fw_hdr)
+{
+	if (ivpu_sched_mode != IVPU_SCHED_MODE_AUTO)
+		return ivpu_sched_mode;
+
+	return VPU_SCHEDULING_MODE_OS;
+}
+
 static int ivpu_fw_parse(struct ivpu_device *vdev)
 {
 	struct ivpu_fw_info *fw = vdev->fw;
@@ -215,8 +224,10 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
 
 	fw->dvfs_mode = 0;
 
+	fw->sched_mode = ivpu_fw_sched_mode_select(vdev, fw_hdr);
 	fw->primary_preempt_buf_size = fw_hdr->preemption_buffer_1_size;
 	fw->secondary_preempt_buf_size = fw_hdr->preemption_buffer_2_size;
+	ivpu_info(vdev, "Scheduler mode: %s\n", fw->sched_mode ? "HW" : "OS");
 
 	if (fw_hdr->ro_section_start_address && !is_within_range(fw_hdr->ro_section_start_address,
 								 fw_hdr->ro_section_size,
@@ -545,7 +556,6 @@ void ivpu_fw_boot_params_setup(struct ivpu_device *vdev, struct vpu_boot_params
 
 	boot_params->magic = VPU_BOOT_PARAMS_MAGIC;
 	boot_params->vpu_id = to_pci_dev(vdev->drm.dev)->bus->number;
-	boot_params->frequency = ivpu_hw_pll_freq_get(vdev);
 
 	/*
 	 * This param is a debug firmware feature.  It switches default clock
@@ -605,8 +615,8 @@ void ivpu_fw_boot_params_setup(struct ivpu_device *vdev, struct vpu_boot_params
 	boot_params->punit_telemetry_sram_base = ivpu_hw_telemetry_offset_get(vdev);
 	boot_params->punit_telemetry_sram_size = ivpu_hw_telemetry_size_get(vdev);
 	boot_params->vpu_telemetry_enable = ivpu_hw_telemetry_enable_get(vdev);
-	boot_params->vpu_scheduling_mode = vdev->hw->sched_mode;
-	if (vdev->hw->sched_mode == VPU_SCHEDULING_MODE_HW)
+	boot_params->vpu_scheduling_mode = vdev->fw->sched_mode;
+	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
 		boot_params->vpu_focus_present_timer_ms = IVPU_FOCUS_PRESENT_TIMER_MS;
 	boot_params->dvfs_mode = vdev->fw->dvfs_mode;
 	if (!IVPU_WA(disable_d0i3_msg))
diff --git a/drivers/accel/ivpu/ivpu_fw.h b/drivers/accel/ivpu/ivpu_fw.h
index 5e8eb608b70f..1d0b2bd9d65c 100644
--- a/drivers/accel/ivpu/ivpu_fw.h
+++ b/drivers/accel/ivpu/ivpu_fw.h
@@ -6,6 +6,8 @@
 #ifndef __IVPU_FW_H__
 #define __IVPU_FW_H__
 
+#include "vpu_jsm_api.h"
+
 #define FW_VERSION_HEADER_SIZE	SZ_4K
 #define FW_VERSION_STR_SIZE	SZ_256
 
@@ -36,6 +38,7 @@ struct ivpu_fw_info {
 	u32 secondary_preempt_buf_size;
 	u64 read_only_addr;
 	u32 read_only_size;
+	u32 sched_mode;
 };
 
 int ivpu_fw_init(struct ivpu_device *vdev);
diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
index a96a05b2acda..1e85306bcd06 100644
--- a/drivers/accel/ivpu/ivpu_hw.h
+++ b/drivers/accel/ivpu/ivpu_hw.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2025 Intel Corporation
  */
 
 #ifndef __IVPU_HW_H__
@@ -46,7 +46,6 @@ struct ivpu_hw_info {
 		u32 profiling_freq;
 	} pll;
 	u32 tile_fuse;
-	u32 sched_mode;
 	u32 sku;
 	u16 config;
 	int dma_bits;
@@ -87,9 +86,9 @@ static inline u64 ivpu_hw_range_size(const struct ivpu_addr_range *range)
 	return range->end - range->start;
 }
 
-static inline u32 ivpu_hw_ratio_to_freq(struct ivpu_device *vdev, u32 ratio)
+static inline u32 ivpu_hw_dpu_max_freq_get(struct ivpu_device *vdev)
 {
-	return ivpu_hw_btrs_ratio_to_freq(vdev, ratio);
+	return ivpu_hw_btrs_dpu_max_freq_get(vdev);
 }
 
 static inline void ivpu_hw_irq_clear(struct ivpu_device *vdev)
@@ -97,11 +96,6 @@ static inline void ivpu_hw_irq_clear(struct ivpu_device *vdev)
 	ivpu_hw_ip_irq_clear(vdev);
 }
 
-static inline u32 ivpu_hw_pll_freq_get(struct ivpu_device *vdev)
-{
-	return ivpu_hw_btrs_pll_freq_get(vdev);
-}
-
 static inline u32 ivpu_hw_profiling_freq_get(struct ivpu_device *vdev)
 {
 	return vdev->hw->pll.profiling_freq;
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ivpu_hw_btrs.c
index 745e5248803d..2d88357b9a3a 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.c
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2025 Intel Corporation
  */
 
+#include <linux/units.h>
+
 #include "ivpu_drv.h"
 #include "ivpu_hw.h"
 #include "ivpu_hw_btrs.h"
@@ -28,17 +30,13 @@
 
 #define BTRS_LNL_ALL_IRQ_MASK ((u32)-1)
 
-#define BTRS_MTL_WP_CONFIG_1_TILE_5_3_RATIO WP_CONFIG(MTL_CONFIG_1_TILE, MTL_PLL_RATIO_5_3)
-#define BTRS_MTL_WP_CONFIG_1_TILE_4_3_RATIO WP_CONFIG(MTL_CONFIG_1_TILE, MTL_PLL_RATIO_4_3)
-#define BTRS_MTL_WP_CONFIG_2_TILE_5_3_RATIO WP_CONFIG(MTL_CONFIG_2_TILE, MTL_PLL_RATIO_5_3)
-#define BTRS_MTL_WP_CONFIG_2_TILE_4_3_RATIO WP_CONFIG(MTL_CONFIG_2_TILE, MTL_PLL_RATIO_4_3)
-#define BTRS_MTL_WP_CONFIG_0_TILE_PLL_OFF   WP_CONFIG(0, 0)
 
 #define PLL_CDYN_DEFAULT               0x80
 #define PLL_EPP_DEFAULT                0x80
 #define PLL_CONFIG_DEFAULT             0x0
-#define PLL_SIMULATION_FREQ            10000000
-#define PLL_REF_CLK_FREQ               50000000
+#define PLL_REF_CLK_FREQ               50000000ull
+#define PLL_RATIO_TO_FREQ(x)           ((x) * PLL_REF_CLK_FREQ)
+
 #define PLL_TIMEOUT_US		       (1500 * USEC_PER_MSEC)
 #define IDLE_TIMEOUT_US		       (5 * USEC_PER_MSEC)
 #define TIMEOUT_US                     (150 * USEC_PER_MSEC)
@@ -62,6 +60,8 @@
 #define DCT_ENABLE                     0x1
 #define DCT_DISABLE                    0x0
 
+static u32 pll_ratio_to_dpu_freq(struct ivpu_device *vdev, u32 ratio);
+
 int ivpu_hw_btrs_irqs_clear_with_0_mtl(struct ivpu_device *vdev)
 {
 	REGB_WR32(VPU_HW_BTRS_MTL_INTERRUPT_STAT, BTRS_MTL_ALL_IRQ_MASK);
@@ -162,8 +162,7 @@ static int info_init_mtl(struct ivpu_device *vdev)
 
 	hw->tile_fuse = BTRS_MTL_TILE_FUSE_ENABLE_BOTH;
 	hw->sku = BTRS_MTL_TILE_SKU_BOTH;
-	hw->config = BTRS_MTL_WP_CONFIG_2_TILE_4_3_RATIO;
-	hw->sched_mode = ivpu_sched_mode;
+	hw->config = WP_CONFIG(MTL_CONFIG_2_TILE, MTL_PLL_RATIO_4_3);
 
 	return 0;
 }
@@ -178,7 +177,6 @@ static int info_init_lnl(struct ivpu_device *vdev)
 	if (ret)
 		return ret;
 
-	hw->sched_mode = ivpu_sched_mode;
 	hw->tile_fuse = tile_fuse_config;
 	hw->pll.profiling_freq = PLL_PROFILING_FREQ_DEFAULT;
 
@@ -346,8 +344,8 @@ int ivpu_hw_btrs_wp_drive(struct ivpu_device *vdev, bool enable)
 
 	prepare_wp_request(vdev, &wp, enable);
 
-	ivpu_dbg(vdev, PM, "PLL workpoint request: %u Hz, config: 0x%x, epp: 0x%x, cdyn: 0x%x\n",
-		 PLL_RATIO_TO_FREQ(wp.target), wp.cfg, wp.epp, wp.cdyn);
+	ivpu_dbg(vdev, PM, "PLL workpoint request: %lu MHz, config: 0x%x, epp: 0x%x, cdyn: 0x%x\n",
+		 pll_ratio_to_dpu_freq(vdev, wp.target) / HZ_PER_MHZ, wp.cfg, wp.epp, wp.cdyn);
 
 	ret = wp_request_send(vdev, &wp);
 	if (ret) {
@@ -588,6 +586,39 @@ int ivpu_hw_btrs_wait_for_idle(struct ivpu_device *vdev)
 		return REGB_POLL_FLD(VPU_HW_BTRS_LNL_VPU_STATUS, IDLE, 0x1, IDLE_TIMEOUT_US);
 }
 
+static u32 pll_config_get_mtl(struct ivpu_device *vdev)
+{
+	return REGB_RD32(VPU_HW_BTRS_MTL_CURRENT_PLL);
+}
+
+static u32 pll_config_get_lnl(struct ivpu_device *vdev)
+{
+	return REGB_RD32(VPU_HW_BTRS_LNL_PLL_FREQ);
+}
+
+static u32 pll_ratio_to_dpu_freq_mtl(u16 ratio)
+{
+	return (PLL_RATIO_TO_FREQ(ratio) * 2) / 3;
+}
+
+static u32 pll_ratio_to_dpu_freq_lnl(u16 ratio)
+{
+	return PLL_RATIO_TO_FREQ(ratio) / 2;
+}
+
+static u32 pll_ratio_to_dpu_freq(struct ivpu_device *vdev, u32 ratio)
+{
+	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
+		return pll_ratio_to_dpu_freq_mtl(ratio);
+	else
+		return pll_ratio_to_dpu_freq_lnl(ratio);
+}
+
+u32 ivpu_hw_btrs_dpu_max_freq_get(struct ivpu_device *vdev)
+{
+	return pll_ratio_to_dpu_freq(vdev, vdev->hw->pll.max_ratio);
+}
+
 /* Handler for IRQs from Buttress core (irqB) */
 bool ivpu_hw_btrs_irq_handler_mtl(struct ivpu_device *vdev, int irq)
 {
@@ -597,9 +628,12 @@ bool ivpu_hw_btrs_irq_handler_mtl(struct ivpu_device *vdev, int irq)
 	if (!status)
 		return false;
 
-	if (REG_TEST_FLD(VPU_HW_BTRS_MTL_INTERRUPT_STAT, FREQ_CHANGE, status))
-		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq: %08x",
-			 REGB_RD32(VPU_HW_BTRS_MTL_CURRENT_PLL));
+	if (REG_TEST_FLD(VPU_HW_BTRS_MTL_INTERRUPT_STAT, FREQ_CHANGE, status)) {
+		u32 pll = pll_config_get_mtl(vdev);
+
+		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq, wp %08x, %lu MHz",
+			 pll, pll_ratio_to_dpu_freq_mtl(pll) / HZ_PER_MHZ);
+	}
 
 	if (REG_TEST_FLD(VPU_HW_BTRS_MTL_INTERRUPT_STAT, ATS_ERR, status)) {
 		ivpu_err(vdev, "ATS_ERR irq 0x%016llx", REGB_RD64(VPU_HW_BTRS_MTL_ATS_ERR_LOG_0));
@@ -649,8 +683,12 @@ bool ivpu_hw_btrs_irq_handler_lnl(struct ivpu_device *vdev, int irq)
 			ivpu_err_ratelimited(vdev, "IRQ FIFO full\n");
 	}
 
-	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, FREQ_CHANGE, status))
-		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq: %08x", REGB_RD32(VPU_HW_BTRS_LNL_PLL_FREQ));
+	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, FREQ_CHANGE, status)) {
+		u32 pll = pll_config_get_lnl(vdev);
+
+		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq, wp %08x, %lu MHz",
+			 pll, pll_ratio_to_dpu_freq_lnl(pll) / HZ_PER_MHZ);
+	}
 
 	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, ATS_ERR, status)) {
 		ivpu_err(vdev, "ATS_ERR LOG1 0x%08x ATS_ERR_LOG2 0x%08x\n",
@@ -733,60 +771,6 @@ void ivpu_hw_btrs_dct_set_status(struct ivpu_device *vdev, bool enable, u32 acti
 	REGB_WR32(VPU_HW_BTRS_LNL_PCODE_MAILBOX_STATUS, val);
 }
 
-static u32 pll_ratio_to_freq_mtl(u32 ratio, u32 config)
-{
-	u32 pll_clock = PLL_REF_CLK_FREQ * ratio;
-	u32 cpu_clock;
-
-	if ((config & 0xff) == MTL_PLL_RATIO_4_3)
-		cpu_clock = pll_clock * 2 / 4;
-	else
-		cpu_clock = pll_clock * 2 / 5;
-
-	return cpu_clock;
-}
-
-u32 ivpu_hw_btrs_ratio_to_freq(struct ivpu_device *vdev, u32 ratio)
-{
-	struct ivpu_hw_info *hw = vdev->hw;
-
-	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
-		return pll_ratio_to_freq_mtl(ratio, hw->config);
-	else
-		return PLL_RATIO_TO_FREQ(ratio);
-}
-
-static u32 pll_freq_get_mtl(struct ivpu_device *vdev)
-{
-	u32 pll_curr_ratio;
-
-	pll_curr_ratio = REGB_RD32(VPU_HW_BTRS_MTL_CURRENT_PLL);
-	pll_curr_ratio &= VPU_HW_BTRS_MTL_CURRENT_PLL_RATIO_MASK;
-
-	if (!ivpu_is_silicon(vdev))
-		return PLL_SIMULATION_FREQ;
-
-	return pll_ratio_to_freq_mtl(pll_curr_ratio, vdev->hw->config);
-}
-
-static u32 pll_freq_get_lnl(struct ivpu_device *vdev)
-{
-	u32 pll_curr_ratio;
-
-	pll_curr_ratio = REGB_RD32(VPU_HW_BTRS_LNL_PLL_FREQ);
-	pll_curr_ratio &= VPU_HW_BTRS_LNL_PLL_FREQ_RATIO_MASK;
-
-	return PLL_RATIO_TO_FREQ(pll_curr_ratio);
-}
-
-u32 ivpu_hw_btrs_pll_freq_get(struct ivpu_device *vdev)
-{
-	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
-		return pll_freq_get_mtl(vdev);
-	else
-		return pll_freq_get_lnl(vdev);
-}
-
 u32 ivpu_hw_btrs_telemetry_offset_get(struct ivpu_device *vdev)
 {
 	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.h b/drivers/accel/ivpu/ivpu_hw_btrs.h
index 04f14f50fed6..71792dab3c21 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.h
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2025 Intel Corporation
  */
 
 #ifndef __IVPU_HW_BTRS_H__
@@ -13,7 +13,6 @@
 
 #define PLL_PROFILING_FREQ_DEFAULT   38400000
 #define PLL_PROFILING_FREQ_HIGH      400000000
-#define PLL_RATIO_TO_FREQ(x)         ((x) * PLL_REF_CLK_FREQ)
 
 #define DCT_DEFAULT_ACTIVE_PERCENT 15u
 #define DCT_PERIOD_US		   35300u
@@ -32,12 +31,11 @@ int ivpu_hw_btrs_ip_reset(struct ivpu_device *vdev);
 void ivpu_hw_btrs_profiling_freq_reg_set_lnl(struct ivpu_device *vdev);
 void ivpu_hw_btrs_ats_print_lnl(struct ivpu_device *vdev);
 void ivpu_hw_btrs_clock_relinquish_disable_lnl(struct ivpu_device *vdev);
+u32 ivpu_hw_btrs_dpu_max_freq_get(struct ivpu_device *vdev);
 bool ivpu_hw_btrs_irq_handler_mtl(struct ivpu_device *vdev, int irq);
 bool ivpu_hw_btrs_irq_handler_lnl(struct ivpu_device *vdev, int irq);
 int ivpu_hw_btrs_dct_get_request(struct ivpu_device *vdev, bool *enable);
 void ivpu_hw_btrs_dct_set_status(struct ivpu_device *vdev, bool enable, u32 dct_percent);
-u32 ivpu_hw_btrs_pll_freq_get(struct ivpu_device *vdev);
-u32 ivpu_hw_btrs_ratio_to_freq(struct ivpu_device *vdev, u32 ratio);
 u32 ivpu_hw_btrs_telemetry_offset_get(struct ivpu_device *vdev);
 u32 ivpu_hw_btrs_telemetry_size_get(struct ivpu_device *vdev);
 u32 ivpu_hw_btrs_telemetry_enable_get(struct ivpu_device *vdev);
diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index be2e2bf0f43f..91f7f6f3ca67 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -37,7 +37,7 @@ static int ivpu_preemption_buffers_create(struct ivpu_device *vdev,
 	u64 secondary_size = ALIGN(vdev->fw->secondary_preempt_buf_size, PAGE_SIZE);
 	struct ivpu_addr_range range;
 
-	if (vdev->hw->sched_mode != VPU_SCHEDULING_MODE_HW)
+	if (vdev->fw->sched_mode != VPU_SCHEDULING_MODE_HW)
 		return 0;
 
 	range.start = vdev->hw->ranges.user.end - (primary_size * IVPU_NUM_CMDQS_PER_CTX);
@@ -68,7 +68,7 @@ static int ivpu_preemption_buffers_create(struct ivpu_device *vdev,
 static void ivpu_preemption_buffers_free(struct ivpu_device *vdev,
 					 struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cmdq)
 {
-	if (vdev->hw->sched_mode != VPU_SCHEDULING_MODE_HW)
+	if (vdev->fw->sched_mode != VPU_SCHEDULING_MODE_HW)
 		return;
 
 	drm_WARN_ON(&vdev->drm, !cmdq->primary_preempt_buf);
@@ -149,7 +149,7 @@ static int ivpu_register_db(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *
 	struct ivpu_device *vdev = file_priv->vdev;
 	int ret;
 
-	if (vdev->hw->sched_mode == VPU_SCHEDULING_MODE_HW)
+	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
 		ret = ivpu_jsm_hws_register_db(vdev, file_priv->ctx.id, cmdq->db_id, cmdq->db_id,
 					       cmdq->mem->vpu_addr, ivpu_bo_size(cmdq->mem));
 	else
@@ -184,7 +184,7 @@ ivpu_cmdq_init(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cmdq, u16 eng
 	jobq_header->tail = 0;
 	wmb(); /* Flush WC buffer for jobq->header */
 
-	if (vdev->hw->sched_mode == VPU_SCHEDULING_MODE_HW) {
+	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW) {
 		ret = ivpu_hws_cmdq_init(file_priv, cmdq, engine, priority);
 		if (ret)
 			return ret;
@@ -211,7 +211,7 @@ static int ivpu_cmdq_fini(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cm
 
 	cmdq->db_registered = false;
 
-	if (vdev->hw->sched_mode == VPU_SCHEDULING_MODE_HW) {
+	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW) {
 		ret = ivpu_jsm_hws_destroy_cmdq(vdev, file_priv->ctx.id, cmdq->db_id);
 		if (!ret)
 			ivpu_dbg(vdev, JOB, "Command queue %d destroyed\n", cmdq->db_id);
@@ -335,7 +335,7 @@ void ivpu_context_abort_locked(struct ivpu_file_priv *file_priv)
 
 	ivpu_cmdq_fini_all(file_priv);
 
-	if (vdev->hw->sched_mode == VPU_SCHEDULING_MODE_OS)
+	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_OS)
 		ivpu_jsm_context_release(vdev, file_priv->ctx.id);
 }
 
@@ -361,7 +361,7 @@ static int ivpu_cmdq_push_job(struct ivpu_cmdq *cmdq, struct ivpu_job *job)
 	if (unlikely(ivpu_test_mode & IVPU_TEST_MODE_NULL_SUBMISSION))
 		entry->flags = VPU_JOB_FLAGS_NULL_SUBMISSION_MASK;
 
-	if (vdev->hw->sched_mode == VPU_SCHEDULING_MODE_HW &&
+	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW &&
 	    (unlikely(!(ivpu_test_mode & IVPU_TEST_MODE_PREEMPTION_DISABLE)))) {
 		entry->primary_preempt_buf_addr = cmdq->primary_preempt_buf->vpu_addr;
 		entry->primary_preempt_buf_size = ivpu_bo_size(cmdq->primary_preempt_buf);
diff --git a/drivers/accel/ivpu/ivpu_sysfs.c b/drivers/accel/ivpu/ivpu_sysfs.c
index 913669f1786e..616477fc17fa 100644
--- a/drivers/accel/ivpu/ivpu_sysfs.c
+++ b/drivers/accel/ivpu/ivpu_sysfs.c
@@ -6,6 +6,8 @@
 #include <linux/device.h>
 #include <linux/err.h>
 
+#include "ivpu_drv.h"
+#include "ivpu_fw.h"
 #include "ivpu_hw.h"
 #include "ivpu_sysfs.h"
 
@@ -39,8 +41,30 @@ npu_busy_time_us_show(struct device *dev, struct device_attribute *attr, char *b
 
 static DEVICE_ATTR_RO(npu_busy_time_us);
 
+/**
+ * DOC: sched_mode
+ *
+ * The sched_mode is used to report current NPU scheduling mode.
+ *
+ * It returns following strings:
+ * - "HW"		- Hardware Scheduler mode
+ * - "OS"		- Operating System Scheduler mode
+ *
+ */
+static ssize_t
+sched_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct ivpu_device *vdev = to_ivpu_device(drm);
+
+	return sysfs_emit(buf, "%s\n", vdev->fw->sched_mode ? "HW" : "OS");
+}
+
+static DEVICE_ATTR_RO(sched_mode);
+
 static struct attribute *ivpu_dev_attrs[] = {
 	&dev_attr_npu_busy_time_us.attr,
+	&dev_attr_sched_mode.attr,
 	NULL,
 };
 
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 25399f6dde7e..e614e4bef9ea 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
 		},
 	},
+	/*
+	 * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up from EC
+	 * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
+		}
+	},
 	{ },
 };
 
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index a35dd0e41c27..f73ce6e13065 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -229,7 +229,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
 	node_entry = ACPI_PTR_DIFF(node, table_hdr);
 	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
 			     sizeof(struct acpi_table_pptt));
-	proc_sz = sizeof(struct acpi_pptt_processor *);
+	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	while ((unsigned long)entry + proc_sz < table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
@@ -270,7 +270,7 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
 	table_end = (unsigned long)table_hdr + table_hdr->length;
 	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
 			     sizeof(struct acpi_table_pptt));
-	proc_sz = sizeof(struct acpi_pptt_processor *);
+	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	/* find the processor structure associated with this cpuid */
 	while ((unsigned long)entry + proc_sz < table_end) {
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f915e3df57a9..1660f46dc08b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2325,8 +2325,8 @@ static unsigned int ata_msense_control_ata_feature(struct ata_device *dev,
 	 */
 	put_unaligned_be16(ATA_FEATURE_SUB_MPAGE_LEN - 4, &buf[2]);
 
-	if (dev->flags & ATA_DFLAG_CDL)
-		buf[4] = 0x02; /* Support T2A and T2B pages */
+	if (dev->flags & ATA_DFLAG_CDL_ENABLED)
+		buf[4] = 0x02; /* T2A and T2B pages enabled */
 	else
 		buf[4] = 0;
 
@@ -3734,12 +3734,11 @@ static int ata_mselect_control_spg0(struct ata_queued_cmd *qc,
 }
 
 /*
- * Translate MODE SELECT control mode page, sub-pages f2h (ATA feature mode
+ * Translate MODE SELECT control mode page, sub-page f2h (ATA feature mode
  * page) into a SET FEATURES command.
  */
-static unsigned int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
-						    const u8 *buf, int len,
-						    u16 *fp)
+static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
+					   const u8 *buf, int len, u16 *fp)
 {
 	struct ata_device *dev = qc->dev;
 	struct ata_taskfile *tf = &qc->tf;
@@ -3757,17 +3756,27 @@ static unsigned int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
 	/* Check cdl_ctrl */
 	switch (buf[0] & 0x03) {
 	case 0:
-		/* Disable CDL */
+		/* Disable CDL if it is enabled */
+		if (!(dev->flags & ATA_DFLAG_CDL_ENABLED))
+			return 0;
+		ata_dev_dbg(dev, "Disabling CDL\n");
 		cdl_action = 0;
 		dev->flags &= ~ATA_DFLAG_CDL_ENABLED;
 		break;
 	case 0x02:
-		/* Enable CDL T2A/T2B: NCQ priority must be disabled */
+		/*
+		 * Enable CDL if not already enabled. Since this is mutually
+		 * exclusive with NCQ priority, allow this only if NCQ priority
+		 * is disabled.
+		 */
+		if (dev->flags & ATA_DFLAG_CDL_ENABLED)
+			return 0;
 		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED) {
 			ata_dev_err(dev,
 				"NCQ priority must be disabled to enable CDL\n");
 			return -EINVAL;
 		}
+		ata_dev_dbg(dev, "Enabling CDL\n");
 		cdl_action = 1;
 		dev->flags |= ATA_DFLAG_CDL_ENABLED;
 		break;
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 8cf04a557bdb..c4ffd0995043 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -73,6 +73,7 @@ static inline void subsys_put(struct subsys_private *sp)
 		kset_put(&sp->subsys);
 }
 
+struct subsys_private *bus_to_subsys(const struct bus_type *bus);
 struct subsys_private *class_to_subsys(const struct class *class);
 
 struct driver_private {
@@ -179,6 +180,22 @@ int driver_add_groups(const struct device_driver *drv, const struct attribute_gr
 void driver_remove_groups(const struct device_driver *drv, const struct attribute_group **groups);
 void device_driver_detach(struct device *dev);
 
+static inline void device_set_driver(struct device *dev, const struct device_driver *drv)
+{
+	/*
+	 * Majority (all?) read accesses to dev->driver happens either
+	 * while holding device lock or in bus/driver code that is only
+	 * invoked when the device is bound to a driver and there is no
+	 * concern of the pointer being changed while it is being read.
+	 * However when reading device's uevent file we read driver pointer
+	 * without taking device lock (so we do not block there for
+	 * arbitrary amount of time). We use WRITE_ONCE() here to prevent
+	 * tearing so that READ_ONCE() can safely be used in uevent code.
+	 */
+	// FIXME - this cast should not be needed "soon"
+	WRITE_ONCE(dev->driver, (struct device_driver *)drv);
+}
+
 int devres_release_all(struct device *dev);
 void device_block_probing(void);
 void device_unblock_probing(void);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 657c93c38b0d..eaf38a6f6091 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -57,7 +57,7 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
  * NULL.  A call to subsys_put() must be done when finished with the pointer in
  * order for it to be properly freed.
  */
-static struct subsys_private *bus_to_subsys(const struct bus_type *bus)
+struct subsys_private *bus_to_subsys(const struct bus_type *bus)
 {
 	struct subsys_private *sp = NULL;
 	struct kobject *kobj;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index ec0ef6a0de94..ba9b4cbef9e0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2624,6 +2624,35 @@ static const char *dev_uevent_name(const struct kobject *kobj)
 	return NULL;
 }
 
+/*
+ * Try filling "DRIVER=<name>" uevent variable for a device. Because this
+ * function may race with binding and unbinding the device from a driver,
+ * we need to be careful. Binding is generally safe, at worst we miss the
+ * fact that the device is already bound to a driver (but the driver
+ * information that is delivered through uevents is best-effort, it may
+ * become obsolete as soon as it is generated anyways). Unbinding is more
+ * risky as driver pointer is transitioning to NULL, so READ_ONCE() should
+ * be used to make sure we are dealing with the same pointer, and to
+ * ensure that driver structure is not going to disappear from under us
+ * we take bus' drivers klist lock. The assumption that only registered
+ * driver can be bound to a device, and to unregister a driver bus code
+ * will take the same lock.
+ */
+static void dev_driver_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	struct subsys_private *sp = bus_to_subsys(dev->bus);
+
+	if (sp) {
+		scoped_guard(spinlock, &sp->klist_drivers.k_lock) {
+			struct device_driver *drv = READ_ONCE(dev->driver);
+			if (drv)
+				add_uevent_var(env, "DRIVER=%s", drv->name);
+		}
+
+		subsys_put(sp);
+	}
+}
+
 static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 {
 	const struct device *dev = kobj_to_dev(kobj);
@@ -2655,8 +2684,8 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 	if (dev->type && dev->type->name)
 		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
 
-	if (dev->driver)
-		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
+	/* Add "DRIVER=%s" variable if the device is bound to a driver */
+	dev_driver_uevent(dev, env);
 
 	/* Add common DT information about the device */
 	of_device_uevent(dev, env);
@@ -2726,11 +2755,8 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	if (!env)
 		return -ENOMEM;
 
-	/* Synchronize with really_probe() */
-	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(&dev->kobj, env);
-	device_unlock(dev);
 	if (retval)
 		goto out;
 
@@ -3700,7 +3726,7 @@ int device_add(struct device *dev)
 	device_pm_remove(dev);
 	dpm_sysfs_remove(dev);
  DPMError:
-	dev->driver = NULL;
+	device_set_driver(dev, NULL);
 	bus_remove_device(dev);
  BusError:
 	device_remove_attrs(dev);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f0e4b4aba885..b526e0e0f52d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -550,7 +550,7 @@ static void device_unbind_cleanup(struct device *dev)
 	arch_teardown_dma_ops(dev);
 	kfree(dev->dma_range_map);
 	dev->dma_range_map = NULL;
-	dev->driver = NULL;
+	device_set_driver(dev, NULL);
 	dev_set_drvdata(dev, NULL);
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
@@ -629,8 +629,7 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
 	}
 
 re_probe:
-	// FIXME - this cast should not be needed "soon"
-	dev->driver = (struct device_driver *)drv;
+	device_set_driver(dev, drv);
 
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
@@ -1014,7 +1013,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 		if (ret == 0)
 			ret = 1;
 		else {
-			dev->driver = NULL;
+			device_set_driver(dev, NULL);
 			ret = 0;
 		}
 	} else {
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index f7dd455dd0dd..dda466f9181a 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -315,7 +315,7 @@ static int __init misc_init(void)
 		goto fail_remove;
 
 	err = -EIO;
-	if (register_chrdev(MISC_MAJOR, "misc", &misc_fops))
+	if (__register_chrdev(MISC_MAJOR, 0, MINORMASK + 1, "misc", &misc_fops))
 		goto fail_printk;
 	return 0;
 
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index c62b208b42f1..abcfdd3c2918 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1579,8 +1579,8 @@ static void handle_control_message(struct virtio_device *vdev,
 		break;
 	case VIRTIO_CONSOLE_RESIZE: {
 		struct {
-			__u16 rows;
-			__u16 cols;
+			__virtio16 rows;
+			__virtio16 cols;
 		} size;
 
 		if (!is_console_port(port))
@@ -1588,7 +1588,8 @@ static void handle_control_message(struct virtio_device *vdev,
 
 		memcpy(&size, buf->buf + buf->offset + sizeof(*cpkt),
 		       sizeof(size));
-		set_console_size(port, size.rows, size.cols);
+		set_console_size(port, virtio16_to_cpu(vdev, size.rows),
+				 virtio16_to_cpu(vdev, size.cols));
 
 		port->cons.hvc->irq_requested = 1;
 		resize_console(port);
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 5b4ab94193c2..7de3dfdae4b5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -5264,6 +5264,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
 	if (!clkspec)
 		return ERR_PTR(-EINVAL);
 
+	/* Check if node in clkspec is in disabled/fail state */
+	if (!of_device_is_available(clkspec->np))
+		return ERR_PTR(-ENOENT);
+
 	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(provider, &of_clk_providers, link) {
 		if (provider->node == clkspec->np) {
diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
index 951c23fa0369..75dce1ff2419 100644
--- a/drivers/comedi/drivers/jr3_pci.c
+++ b/drivers/comedi/drivers/jr3_pci.c
@@ -758,7 +758,7 @@ static void jr3_pci_detach(struct comedi_device *dev)
 	struct jr3_pci_dev_private *devpriv = dev->private;
 
 	if (devpriv)
-		del_timer_sync(&devpriv->timer);
+		timer_shutdown_sync(&devpriv->timer);
 
 	comedi_pci_detach(dev);
 }
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index e67b2326671c..71f4b612dd97 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -67,7 +67,7 @@ config ARM_VEXPRESS_SPC_CPUFREQ
 config ARM_BRCMSTB_AVS_CPUFREQ
 	tristate "Broadcom STB AVS CPUfreq driver"
 	depends on (ARCH_BRCMSTB && !ARM_SCMI_CPUFREQ) || COMPILE_TEST
-	default y
+	default y if ARCH_BRCMSTB && !ARM_SCMI_CPUFREQ
 	help
 	  Some Broadcom STB SoCs use a co-processor running proprietary firmware
 	  ("AVS") to handle voltage and frequency scaling. This driver provides
@@ -79,7 +79,7 @@ config ARM_HIGHBANK_CPUFREQ
 	tristate "Calxeda Highbank-based"
 	depends on ARCH_HIGHBANK || COMPILE_TEST
 	depends on CPUFREQ_DT && REGULATOR && PL320_MBOX
-	default m
+	default m if ARCH_HIGHBANK
 	help
 	  This adds the CPUFreq driver for Calxeda Highbank SoC
 	  based boards.
@@ -124,7 +124,7 @@ config ARM_MEDIATEK_CPUFREQ
 config ARM_MEDIATEK_CPUFREQ_HW
 	tristate "MediaTek CPUFreq HW driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
-	default m
+	default m if ARCH_MEDIATEK
 	help
 	  Support for the CPUFreq HW driver.
 	  Some MediaTek chipsets have a HW engine to offload the steps
@@ -172,7 +172,7 @@ config ARM_RASPBERRYPI_CPUFREQ
 config ARM_S3C64XX_CPUFREQ
 	bool "Samsung S3C64XX"
 	depends on CPU_S3C6410 || COMPILE_TEST
-	default y
+	default CPU_S3C6410
 	help
 	  This adds the CPUFreq driver for Samsung S3C6410 SoC.
 
@@ -181,7 +181,7 @@ config ARM_S3C64XX_CPUFREQ
 config ARM_S5PV210_CPUFREQ
 	bool "Samsung S5PV210 and S5PC110"
 	depends on CPU_S5PV210 || COMPILE_TEST
-	default y
+	default CPU_S5PV210
 	help
 	  This adds the CPUFreq driver for Samsung S5PV210 and
 	  S5PC110 SoCs.
@@ -205,7 +205,7 @@ config ARM_SCMI_CPUFREQ
 config ARM_SPEAR_CPUFREQ
 	bool "SPEAr CPUFreq support"
 	depends on PLAT_SPEAR || COMPILE_TEST
-	default y
+	default PLAT_SPEAR
 	help
 	  This adds the CPUFreq driver support for SPEAr SOCs.
 
@@ -224,7 +224,7 @@ config ARM_TEGRA20_CPUFREQ
 	tristate "Tegra20/30 CPUFreq support"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on CPUFREQ_DT
-	default y
+	default ARCH_TEGRA
 	help
 	  This adds the CPUFreq driver support for Tegra20/30 SOCs.
 
@@ -232,7 +232,7 @@ config ARM_TEGRA124_CPUFREQ
 	bool "Tegra124 CPUFreq support"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on CPUFREQ_DT
-	default y
+	default ARCH_TEGRA
 	help
 	  This adds the CPUFreq driver support for Tegra124 SOCs.
 
@@ -247,14 +247,14 @@ config ARM_TEGRA194_CPUFREQ
 	tristate "Tegra194 CPUFreq support"
 	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || (64BIT && COMPILE_TEST)
 	depends on TEGRA_BPMP
-	default y
+	default ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC
 	help
 	  This adds CPU frequency driver support for Tegra194 SOCs.
 
 config ARM_TI_CPUFREQ
 	bool "Texas Instruments CPUFreq support"
 	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
-	default y
+	default ARCH_OMAP2PLUS || ARCH_K3
 	help
 	  This driver enables valid OPPs on the running platform based on
 	  values contained within the SoC in use. Enable this in order to
diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 4dcacab9b4bf..ddf7dcb3e9b0 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -103,11 +103,17 @@ static const struct of_device_id apple_soc_cpufreq_of_match[] __maybe_unused = {
 
 static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct apple_cpu_priv *priv = policy->driver_data;
+	struct cpufreq_policy *policy;
+	struct apple_cpu_priv *priv;
 	struct cpufreq_frequency_table *p;
 	unsigned int pstate;
 
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+
 	if (priv->info->cur_pstate_mask) {
 		u64 reg = readq_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
 
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index c1cdf0f4d0dd..36ea181260c7 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -767,7 +767,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	int ret;
 
 	if (!policy)
-		return -ENODEV;
+		return 0;
 
 	cpu_data = policy->driver_data;
 
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 07d6f9a9b7c8..7e7c1613a67c 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -34,11 +34,17 @@ static struct cpufreq_driver scmi_cpufreq_driver;
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct scmi_data *priv = policy->driver_data;
+	struct cpufreq_policy *policy;
+	struct scmi_data *priv;
 	unsigned long rate;
 	int ret;
 
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+
 	ret = perf_ops->freq_get(ph, priv->domain_id, &rate, false);
 	if (ret)
 		return 0;
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index f2d913a91be9..a191d9bdf667 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -29,9 +29,16 @@ static struct scpi_ops *scpi_ops;
 
 static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct scpi_data *priv = policy->driver_data;
-	unsigned long rate = clk_get_rate(priv->clk);
+	struct cpufreq_policy *policy;
+	struct scpi_data *priv;
+	unsigned long rate;
+
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+	rate = clk_get_rate(priv->clk);
 
 	return rate / 1000;
 }
diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 293921acec93..0599dbf851eb 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -167,7 +167,9 @@ static int sun50i_cpufreq_get_efuse(void)
 	struct nvmem_cell *speedbin_nvmem;
 	const struct of_device_id *match;
 	struct device *cpu_dev;
-	u32 *speedbin;
+	void *speedbin_ptr;
+	u32 speedbin = 0;
+	size_t len;
 	int ret;
 
 	cpu_dev = get_cpu_device(0);
@@ -190,14 +192,18 @@ static int sun50i_cpufreq_get_efuse(void)
 		return dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
 				     "Could not get nvmem cell\n");
 
-	speedbin = nvmem_cell_read(speedbin_nvmem, NULL);
+	speedbin_ptr = nvmem_cell_read(speedbin_nvmem, &len);
 	nvmem_cell_put(speedbin_nvmem);
-	if (IS_ERR(speedbin))
-		return PTR_ERR(speedbin);
+	if (IS_ERR(speedbin_ptr))
+		return PTR_ERR(speedbin_ptr);
 
-	ret = opp_data->efuse_xlate(*speedbin);
+	if (len <= 4)
+		memcpy(&speedbin, speedbin_ptr, len);
+	speedbin = le32_to_cpu(speedbin);
 
-	kfree(speedbin);
+	ret = opp_data->efuse_xlate(speedbin);
+
+	kfree(speedbin_ptr);
 
 	return ret;
 };
diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index a02d496f4c41..b9658e38cb03 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -163,6 +163,12 @@ static int atmel_sha204a_probe(struct i2c_client *client)
 	i2c_priv->hwrng.name = dev_name(&client->dev);
 	i2c_priv->hwrng.read = atmel_sha204a_rng_read;
 
+	/*
+	 * According to review by Bill Cox [1], this HWRNG has very low entropy.
+	 * [1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
+	 */
+	i2c_priv->hwrng.quality = 1;
+
 	ret = devm_hwrng_register(&client->dev, &i2c_priv->hwrng);
 	if (ret)
 		dev_warn(&client->dev, "failed to register RNG (%d)\n", ret);
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index 157f9a9ed636..2ebc878da160 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -532,6 +532,7 @@ static const struct pci_device_id sp_pci_table[] = {
 	{ PCI_VDEVICE(AMD, 0x14CA), (kernel_ulong_t)&dev_vdata[5] },
 	{ PCI_VDEVICE(AMD, 0x15C7), (kernel_ulong_t)&dev_vdata[6] },
 	{ PCI_VDEVICE(AMD, 0x1649), (kernel_ulong_t)&dev_vdata[6] },
+	{ PCI_VDEVICE(AMD, 0x1134), (kernel_ulong_t)&dev_vdata[7] },
 	{ PCI_VDEVICE(AMD, 0x17E0), (kernel_ulong_t)&dev_vdata[7] },
 	{ PCI_VDEVICE(AMD, 0x156E), (kernel_ulong_t)&dev_vdata[8] },
 	/* Last entry must be zero */
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e1082e749c69..a9c39025535f 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -513,7 +513,6 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 	resource_size_t rcrb = ri->base;
 	void __iomem *addr;
 	u32 bar0, bar1;
-	u16 cmd;
 	u32 id;
 
 	if (which == CXL_RCRB_UPSTREAM)
@@ -535,7 +534,6 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 	}
 
 	id = readl(addr + PCI_VENDOR_ID);
-	cmd = readw(addr + PCI_COMMAND);
 	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
 	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
 	iounmap(addr);
@@ -550,8 +548,6 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 			dev_err(dev, "Failed to access Downstream Port RCRB\n");
 		return CXL_RESOURCE_NONE;
 	}
-	if (!(cmd & PCI_COMMAND_MEMORY))
-		return CXL_RESOURCE_NONE;
 	/* The RCRB is a Memory Window, and the MEM_TYPE_1M bit is obsolete */
 	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
 		return CXL_RESOURCE_NONE;
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 91b2fbc0b864..d891dfca358e 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -841,9 +841,9 @@ static int dmatest_func(void *data)
 		} else {
 			dma_async_issue_pending(chan);
 
-			wait_event_freezable_timeout(thread->done_wait,
-					done->done,
-					msecs_to_jiffies(params->timeout));
+			wait_event_timeout(thread->done_wait,
+					   done->done,
+					   msecs_to_jiffies(params->timeout));
 
 			status = dma_async_is_tx_complete(chan, cookie, NULL,
 							  NULL);
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 528f37417aea..f9429dd52fd9 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1227,22 +1227,28 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	if (!svc->intel_svc_fcs) {
 		dev_err(dev, "failed to allocate %s device\n", INTEL_FCS);
 		ret = -ENOMEM;
-		goto err_unregister_dev;
+		goto err_unregister_rsu_dev;
 	}
 
 	ret = platform_device_add(svc->intel_svc_fcs);
 	if (ret) {
 		platform_device_put(svc->intel_svc_fcs);
-		goto err_unregister_dev;
+		goto err_unregister_rsu_dev;
 	}
 
+	ret = of_platform_default_populate(dev_of_node(dev), NULL, dev);
+	if (ret)
+		goto err_unregister_fcs_dev;
+
 	dev_set_drvdata(dev, svc);
 
 	pr_info("Intel Service Layer Driver Initialized\n");
 
 	return 0;
 
-err_unregister_dev:
+err_unregister_fcs_dev:
+	platform_device_unregister(svc->intel_svc_fcs);
+err_unregister_rsu_dev:
 	platform_device_unregister(svc->stratix10_svc_rsu);
 err_free_kfifo:
 	kfifo_free(&controller->svc_fifo);
@@ -1256,6 +1262,8 @@ static void stratix10_svc_drv_remove(struct platform_device *pdev)
 	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
 
+	of_platform_depopulate(ctrl->dev);
+
 	platform_device_unregister(svc->intel_svc_fcs);
 	platform_device_unregister(svc->stratix10_svc_rsu);
 
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index e543129d3605..626daedb0169 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -259,6 +259,9 @@ static void of_gpio_set_polarity_by_property(const struct device_node *np,
 		{ "fsl,imx8qm-fec",  "phy-reset-gpios", "phy-reset-active-high" },
 		{ "fsl,s32v234-fec", "phy-reset-gpios", "phy-reset-active-high" },
 #endif
+#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
+		{ "atmel,hsmci",       "cd-gpios",     "cd-inverted" },
+#endif
 #if IS_ENABLED(CONFIG_PCI_IMX6)
 		{ "fsl,imx6q-pcie",  "reset-gpio", "reset-gpio-active-high" },
 		{ "fsl,imx6sx-pcie", "reset-gpio", "reset-gpio-active-high" },
@@ -284,9 +287,6 @@ static void of_gpio_set_polarity_by_property(const struct device_node *np,
 #if IS_ENABLED(CONFIG_REGULATOR_GPIO)
 		{ "regulator-gpio",    "enable-gpio",  "enable-active-high" },
 		{ "regulator-gpio",    "enable-gpios", "enable-active-high" },
-#endif
-#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
-		{ "atmel,hsmci",       "cd-gpios",     "cd-inverted" },
 #endif
 	};
 	unsigned int i;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9b1e0ede05a4..b7aad43d9ad0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -350,7 +350,6 @@ enum amdgpu_kiq_irq {
 	AMDGPU_CP_KIQ_IRQ_DRIVER0 = 0,
 	AMDGPU_CP_KIQ_IRQ_LAST
 };
-#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
 #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
 #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 05ebb8216a55..3c2ac5f4e814 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1426,9 +1426,11 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct drm_gpu_scheduler *sched = &ring->sched;
 	struct drm_sched_entity entity;
+	static atomic_t counter;
 	struct dma_fence *f;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
+	void *owner;
 	int i, r;
 
 	/* Initialize the scheduler entity */
@@ -1439,9 +1441,15 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 		goto err;
 	}
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, NULL,
-				     64, 0,
-				     &job);
+	/*
+	 * Use some unique dummy value as the owner to make sure we execute
+	 * the cleaner shader on each submission. The value just need to change
+	 * for each submission and is otherwise meaningless.
+	 */
+	owner = (void *)(unsigned long)atomic_inc_return(&counter);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
+				     64, 0, &job);
 	if (r)
 		goto err;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 17a19d49d30a..9d130d3af0b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -678,12 +678,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 				   uint32_t flush_type, bool all_hub,
 				   uint32_t inst)
 {
-	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
-		adev->usec_timeout;
 	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 	unsigned int ndw;
-	int r;
+	int r, cnt = 0;
 	uint32_t seq;
 
 	/*
@@ -740,10 +738,21 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-		if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1) {
+
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+		might_sleep();
+		while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
+		       !amdgpu_reset_pending(adev->reset_domain)) {
+			msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+			r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+		}
+
+		if (cnt > MAX_KIQ_REG_TRY) {
 			dev_err(adev->dev, "timeout waiting for kiq fence\n");
 			r = -ETIME;
-		}
+		} else
+			r = 0;
 	}
 
 error_unlock_reset:
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 45ed97038df0..24d711b0e634 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5998,7 +5998,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_PFP_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_PFP_IC_BASE_CNTL, VMID, 0);
@@ -6076,7 +6076,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_CE_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CE_IC_BASE_CNTL, VMID, 0);
@@ -6153,7 +6153,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_ME_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_ME_IC_BASE_CNTL, VMID, 0);
@@ -6528,7 +6528,7 @@ static int gfx_v10_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_CPC_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 84cf5fd297b7..0357fea8ae1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2327,7 +2327,7 @@ static int gfx_v11_0_config_me_cache(struct amdgpu_device *adev, uint64_t addr)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, regCP_ME_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_ME_IC_BASE_CNTL, VMID, 0);
@@ -2371,7 +2371,7 @@ static int gfx_v11_0_config_pfp_cache(struct amdgpu_device *adev, uint64_t addr)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_PFP_IC_BASE_CNTL, VMID, 0);
@@ -2416,7 +2416,7 @@ static int gfx_v11_0_config_mec_cache(struct amdgpu_device *adev, uint64_t addr)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, regCP_CPC_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
@@ -3051,7 +3051,7 @@ static int gfx_v11_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	amdgpu_bo_unreserve(adev->gfx.pfp.pfp_fw_data_obj);
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	WREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_LO,
 		lower_32_bits(adev->gfx.pfp.pfp_fw_gpu_addr));
@@ -3269,7 +3269,7 @@ static int gfx_v11_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	amdgpu_bo_unreserve(adev->gfx.me.me_fw_data_obj);
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	WREG32_SOC15(GC, 0, regCP_ME_IC_BASE_LO,
 		lower_32_bits(adev->gfx.me.me_fw_gpu_addr));
@@ -4487,7 +4487,7 @@ static int gfx_v11_0_gfxhub_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b259e217930c..241619ee10e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2264,7 +2264,7 @@ static int gfx_v12_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	amdgpu_bo_unreserve(adev->gfx.pfp.pfp_fw_data_obj);
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	WREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_LO,
 		lower_32_bits(adev->gfx.pfp.pfp_fw_gpu_addr));
@@ -2408,7 +2408,7 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	amdgpu_bo_unreserve(adev->gfx.me.me_fw_data_obj);
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	WREG32_SOC15(GC, 0, regCP_ME_IC_BASE_LO,
 		lower_32_bits(adev->gfx.me.me_fw_gpu_addr));
@@ -3429,7 +3429,7 @@ static int gfx_v12_0_gfxhub_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 9784a2892185..c6e742921282 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -265,7 +265,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 	/* flush hdp cache */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
@@ -966,7 +966,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	adev->hdp.funcs->init_registers(adev);
 
 	/* Flush HDP after it is initialized */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 2797fd84432b..4e9c23d65b02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -226,7 +226,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 	/* flush hdp cache */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
@@ -893,7 +893,7 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
 		return r;
 
 	/* Flush HDP after it is initialized */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 60acf676000b..525e435ee22d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -294,7 +294,7 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 
 	/* flush hdp cache */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
@@ -862,7 +862,7 @@ static int gmc_v12_0_gart_enable(struct amdgpu_device *adev)
 		return r;
 
 	/* Flush HDP after it is initialized */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 7a45f3fdc734..9a212413c6d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2351,7 +2351,7 @@ static int gmc_v9_0_hw_init(void *handle)
 	adev->hdp.funcs->init_registers(adev);
 
 	/* After HDP is initialized, flush HDP.*/
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS)
 		value = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 2395f1856962..e77a467af7ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -532,7 +532,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 			}
 
 			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-			adev->hdp.funcs->flush_hdp(adev, NULL);
+			amdgpu_device_flush_hdp(adev, NULL);
 			vfree(buf);
 			drm_dev_exit(idx);
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 51e470e8d67d..bf00de763acb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -600,7 +600,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
 			}
 
 			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-			adev->hdp.funcs->flush_hdp(adev, NULL);
+			amdgpu_device_flush_hdp(adev, NULL);
 			vfree(buf);
 			drm_dev_exit(idx);
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index 4d33c95a5116..89f6c06946c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -488,7 +488,7 @@ static int psp_v14_0_memory_training(struct psp_context *psp, uint32_t ops)
 			}
 
 			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-			adev->hdp.funcs->flush_hdp(adev, NULL);
+			amdgpu_device_flush_hdp(adev, NULL);
 			vfree(buf);
 			drm_dev_exit(idx);
 		} else {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c22da13859bd..f3cbff861557 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3216,16 +3216,16 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	for (k = 0; k < dc_state->stream_count; k++) {
 		bundle->stream_update.stream = dc_state->streams[k];
 
-		for (m = 0; m < dc_state->stream_status->plane_count; m++) {
+		for (m = 0; m < dc_state->stream_status[k].plane_count; m++) {
 			bundle->surface_updates[m].surface =
-				dc_state->stream_status->plane_states[m];
+				dc_state->stream_status[k].plane_states[m];
 			bundle->surface_updates[m].surface->force_full_update =
 				true;
 		}
 
 		update_planes_and_stream_adapter(dm->dc,
 					 UPDATE_TYPE_FULL,
-					 dc_state->stream_status->plane_count,
+					 dc_state->stream_status[k].plane_count,
 					 dc_state->streams[k],
 					 &bundle->stream_update,
 					 bundle->surface_updates);
@@ -10775,6 +10775,9 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	    state->allow_modeset)
 		return true;
 
+	if (amdgpu_in_reset(adev) && state->allow_modeset)
+		return true;
+
 	/* Exit early if we know that we're adding or removing the plane. */
 	if (old_plane_state->crtc != new_plane_state->crtc)
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index cb187604744e..e3e4f40bd412 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -2,6 +2,7 @@
 //
 // Copyright 2024 Advanced Micro Devices, Inc.
 
+#include <linux/vmalloc.h>
 
 #include "dml2_internal_types.h"
 #include "dml_top.h"
@@ -13,11 +14,11 @@
 
 static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 {
-	*dml_ctx = (struct dml2_context *)kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
+	*dml_ctx = vzalloc(sizeof(struct dml2_context));
 	if (!(*dml_ctx))
 		return false;
 
-	(*dml_ctx)->v21.dml_init.dml2_instance = (struct dml2_instance *)kzalloc(sizeof(struct dml2_instance), GFP_KERNEL);
+	(*dml_ctx)->v21.dml_init.dml2_instance = vzalloc(sizeof(struct dml2_instance));
 	if (!((*dml_ctx)->v21.dml_init.dml2_instance))
 		return false;
 
@@ -27,7 +28,7 @@ static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 	(*dml_ctx)->v21.mode_support.display_config = &(*dml_ctx)->v21.display_config;
 	(*dml_ctx)->v21.mode_programming.display_config = (*dml_ctx)->v21.mode_support.display_config;
 
-	(*dml_ctx)->v21.mode_programming.programming = (struct dml2_display_cfg_programming *)kzalloc(sizeof(struct dml2_display_cfg_programming), GFP_KERNEL);
+	(*dml_ctx)->v21.mode_programming.programming = vzalloc(sizeof(struct dml2_display_cfg_programming));
 	if (!((*dml_ctx)->v21.mode_programming.programming))
 		return false;
 
@@ -116,8 +117,8 @@ bool dml21_create(const struct dc *in_dc, struct dml2_context **dml_ctx, const s
 
 void dml21_destroy(struct dml2_context *dml2)
 {
-	kfree(dml2->v21.dml_init.dml2_instance);
-	kfree(dml2->v21.mode_programming.programming);
+	vfree(dml2->v21.dml_init.dml2_instance);
+	vfree(dml2->v21.mode_programming.programming);
 }
 
 static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *context, struct resource_context *out_new_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index cb2cb89dfecb..03812f862b3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -24,6 +24,8 @@
  *
  */
 
+#include <linux/vmalloc.h>
+
 #include "display_mode_core.h"
 #include "dml2_internal_types.h"
 #include "dml2_utils.h"
@@ -749,7 +751,7 @@ bool dml2_validate(const struct dc *in_dc, struct dc_state *context, struct dml2
 
 static inline struct dml2_context *dml2_allocate_memory(void)
 {
-	return (struct dml2_context *) kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
+	return (struct dml2_context *) vzalloc(sizeof(struct dml2_context));
 }
 
 static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
@@ -820,7 +822,7 @@ void dml2_destroy(struct dml2_context *dml2)
 
 	if (dml2->architecture == dml2_architecture_21)
 		dml21_destroy(dml2);
-	kfree(dml2);
+	vfree(dml2);
 }
 
 void dml2_extract_dram_and_fclk_change_support(struct dml2_context *dml2,
diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 7d68a8acfe2e..eb0f8373258c 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -129,11 +129,11 @@ static int jadard_unprepare(struct drm_panel *panel)
 {
 	struct jadard *jadard = panel_to_jadard(panel);
 
-	gpiod_set_value(jadard->reset, 1);
+	gpiod_set_value(jadard->reset, 0);
 	msleep(120);
 
 	if (jadard->desc->reset_before_power_off_vcioo) {
-		gpiod_set_value(jadard->reset, 0);
+		gpiod_set_value(jadard->reset, 1);
 
 		usleep_range(1000, 2000);
 	}
diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
index 264d6e116499..93fa2708ee37 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -29,8 +29,10 @@
 13011645652	GRAPHICS_VERSION(2004)
 14022293748	GRAPHICS_VERSION(2001)
 		GRAPHICS_VERSION(2004)
+		GRAPHICS_VERSION_RANGE(3000, 3001)
 22019794406	GRAPHICS_VERSION(2001)
 		GRAPHICS_VERSION(2004)
+		GRAPHICS_VERSION_RANGE(3000, 3001)
 22019338487	MEDIA_VERSION(2000)
 		GRAPHICS_VERSION(2001)
 		MEDIA_VERSION(3000), MEDIA_STEP(A0, B0)
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 42102baabcdd..7911814ad82a 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -158,6 +158,10 @@ struct svc_i3c_regs_save {
 	u32 mdynaddr;
 };
 
+struct svc_i3c_drvdata {
+	u32 quirks;
+};
+
 /**
  * struct svc_i3c_master - Silvaco I3C Master structure
  * @base: I3C master controller
@@ -183,6 +187,7 @@ struct svc_i3c_regs_save {
  * @ibi.tbq_slot: To be queued IBI slot
  * @ibi.lock: IBI lock
  * @lock: Transfer lock, protect between IBI work thread and callbacks from master
+ * @drvdata: Driver data
  * @enabled_events: Bit masks for enable events (IBI, HotJoin).
  * @mctrl_config: Configuration value in SVC_I3C_MCTRL for setting speed back.
  */
@@ -214,6 +219,7 @@ struct svc_i3c_master {
 		spinlock_t lock;
 	} ibi;
 	struct mutex lock;
+	const struct svc_i3c_drvdata *drvdata;
 	u32 enabled_events;
 	u32 mctrl_config;
 };
@@ -1768,6 +1774,10 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
+	master->drvdata = of_device_get_match_data(dev);
+	if (!master->drvdata)
+		return -EINVAL;
+
 	master->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(master->regs))
 		return PTR_ERR(master->regs);
@@ -1909,8 +1919,13 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
 			   svc_i3c_runtime_resume, NULL)
 };
 
+static const struct svc_i3c_drvdata npcm845_drvdata = {};
+
+static const struct svc_i3c_drvdata svc_default_drvdata = {};
+
 static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
-	{ .compatible = "silvaco,i3c-master-v1"},
+	{ .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
+	{ .compatible = "silvaco,i3c-master-v1", .data = &svc_default_drvdata },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 6f8816483f1a..157a0df97f97 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -142,7 +142,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.channel = 0,
 		.scan_index = 0,
 		.scan_type = {
-			.sign = 'u',
+			.sign = 's',
 			.realbits = 24,
 			.storagebits = 32,
 			.shift = 8,
@@ -370,12 +370,11 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = ad7768_scan_direct(indio_dev);
-		if (ret >= 0)
-			*val = ret;
 
 		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
+		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
 
 		return IIO_VAL_INT;
 
diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index b27791029fa9..b9f4a2937c3a 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -55,6 +55,7 @@ static int qibfs_mknod(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = new_inode(dir->i_sb);
 
 	if (!inode) {
+		dput(dentry);
 		error = -EPERM;
 		goto bail;
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a24a97a2c646..f61e48f23732 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3660,7 +3660,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	 * we should not modify the IRTE
 	 */
 	if (!dev_data || !dev_data->use_vapic)
-		return 0;
+		return -EINVAL;
 
 	ir_data->cfg = irqd_cfg(data);
 	pi_data->ir_data = ir_data;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e617a2c5..cac3dce11168 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -503,6 +503,9 @@ static void iommu_deinit_device(struct device *dev)
 	dev->iommu_group = NULL;
 	module_put(ops->owner);
 	dev_iommu_free(dev);
+#ifdef CONFIG_IOMMU_DMA
+	dev->dma_iommu = false;
+#endif
 }
 
 DEFINE_MUTEX(iommu_probe_device_lock);
@@ -3112,6 +3115,11 @@ int iommu_device_use_default_domain(struct device *dev)
 		return 0;
 
 	mutex_lock(&group->mutex);
+	/* We may race against bus_iommu_probe() finalising groups here */
+	if (!group->default_domain) {
+		ret = -EPROBE_DEFER;
+		goto unlock_out;
+	}
 	if (group->owner_cnt) {
 		if (group->domain != group->default_domain || group->owner ||
 		    !xa_empty(&group->pasid_array)) {
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index be35c5349986..a1e370d0200f 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -423,7 +423,7 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 #ifdef CONFIG_ACPI
 static int acpi_num_msi;
 
-static __init struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
+static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
 {
 	struct v2m_data *data;
 
diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 82102a4c5d68..f8215a8f656a 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -313,6 +313,10 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	int ret;
 
 	pchan = chan->con_priv;
+
+	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
+		return IRQ_NONE;
+
 	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
 	    !pchan->chan_in_use)
 		return IRQ_NONE;
@@ -330,13 +334,16 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 		return IRQ_NONE;
 	}
 
-	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
-		return IRQ_NONE;
-
+	/*
+	 * Clear this flag after updating interrupt ack register and just
+	 * before mbox_chan_received_data() which might call pcc_send_data()
+	 * where the flag is set again to start new transfer. This is
+	 * required to avoid any possible race in updatation of this flag.
+	 */
+	pchan->chan_in_use = false;
 	mbox_chan_received_data(chan, NULL);
 
 	check_and_ack(pchan, chan);
-	pchan->chan_in_use = false;
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index a5f8ab9a0910..7acff8e02eb4 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -96,7 +96,7 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 
 	ret = mcb_device_register(bus, mdev);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	return 0;
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 8a994a1975ca..6b6cd753d61a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2156,14 +2156,9 @@ static int fix_sync_read_error(struct r1bio *r1_bio)
 				if (!rdev_set_badblocks(rdev, sect, s, 0))
 					abort = 1;
 			}
-			if (abort) {
-				conf->recovery_disabled =
-					mddev->recovery_disabled;
-				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-				md_done_sync(mddev, r1_bio->sectors, 0);
-				put_buf(r1_bio);
+			if (abort)
 				return 0;
-			}
+
 			/* Try next page */
 			sectors -= s;
 			sect += s;
@@ -2302,10 +2297,21 @@ static void sync_request_write(struct mddev *mddev, struct r1bio *r1_bio)
 	int disks = conf->raid_disks * 2;
 	struct bio *wbio;
 
-	if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
-		/* ouch - failed to read all of that. */
-		if (!fix_sync_read_error(r1_bio))
+	if (!test_bit(R1BIO_Uptodate, &r1_bio->state)) {
+		/*
+		 * ouch - failed to read all of that.
+		 * No need to fix read error for check/repair
+		 * because all member disks are read.
+		 */
+		if (test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) ||
+		    !fix_sync_read_error(r1_bio)) {
+			conf->recovery_disabled = mddev->recovery_disabled;
+			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+			md_done_sync(mddev, r1_bio->sectors, 0);
+			put_buf(r1_bio);
 			return;
+		}
+	}
 
 	if (test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
 		process_checks(r1_bio);
diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 8ba096b8ebca..85ecb2aeefdb 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -140,6 +140,7 @@ config VIDEO_IMX214
 	tristate "Sony IMX214 sensor support"
 	depends on GPIOLIB
 	select REGMAP_I2C
+	select V4L2_CCI_I2C
 	help
 	  This is a Video4Linux2 sensor driver for the Sony
 	  IMX214 camera.
diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 6a393e18267f..ea5e294327e7 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -15,26 +15,152 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <media/media-entity.h>
+#include <media/v4l2-cci.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
-#define IMX214_REG_MODE_SELECT		0x0100
+#define IMX214_REG_MODE_SELECT		CCI_REG8(0x0100)
 #define IMX214_MODE_STANDBY		0x00
 #define IMX214_MODE_STREAMING		0x01
 
+#define IMX214_REG_FAST_STANDBY_CTRL	CCI_REG8(0x0106)
+
 #define IMX214_DEFAULT_CLK_FREQ	24000000
-#define IMX214_DEFAULT_LINK_FREQ 480000000
+#define IMX214_DEFAULT_LINK_FREQ	600000000
+/* Keep wrong link frequency for backward compatibility */
+#define IMX214_DEFAULT_LINK_FREQ_LEGACY	480000000
 #define IMX214_DEFAULT_PIXEL_RATE ((IMX214_DEFAULT_LINK_FREQ * 8LL) / 10)
 #define IMX214_FPS 30
 #define IMX214_MBUS_CODE MEDIA_BUS_FMT_SRGGB10_1X10
 
+/* V-TIMING internal */
+#define IMX214_REG_FRM_LENGTH_LINES	CCI_REG16(0x0340)
+
 /* Exposure control */
-#define IMX214_REG_EXPOSURE		0x0202
+#define IMX214_REG_EXPOSURE		CCI_REG16(0x0202)
 #define IMX214_EXPOSURE_MIN		0
 #define IMX214_EXPOSURE_MAX		3184
 #define IMX214_EXPOSURE_STEP		1
 #define IMX214_EXPOSURE_DEFAULT		3184
+#define IMX214_REG_EXPOSURE_RATIO	CCI_REG8(0x0222)
+#define IMX214_REG_SHORT_EXPOSURE	CCI_REG16(0x0224)
+
+/* Analog gain control */
+#define IMX214_REG_ANALOG_GAIN		CCI_REG16(0x0204)
+#define IMX214_REG_SHORT_ANALOG_GAIN	CCI_REG16(0x0216)
+
+/* Digital gain control */
+#define IMX214_REG_DIG_GAIN_GREENR	CCI_REG16(0x020e)
+#define IMX214_REG_DIG_GAIN_RED		CCI_REG16(0x0210)
+#define IMX214_REG_DIG_GAIN_BLUE	CCI_REG16(0x0212)
+#define IMX214_REG_DIG_GAIN_GREENB	CCI_REG16(0x0214)
+
+#define IMX214_REG_ORIENTATION		CCI_REG8(0x0101)
+
+#define IMX214_REG_MASK_CORR_FRAMES	CCI_REG8(0x0105)
+#define IMX214_CORR_FRAMES_TRANSMIT	0
+#define IMX214_CORR_FRAMES_MASK		1
+
+#define IMX214_REG_CSI_DATA_FORMAT	CCI_REG16(0x0112)
+#define IMX214_CSI_DATA_FORMAT_RAW8	0x0808
+#define IMX214_CSI_DATA_FORMAT_RAW10	0x0A0A
+#define IMX214_CSI_DATA_FORMAT_COMP6	0x0A06
+#define IMX214_CSI_DATA_FORMAT_COMP8	0x0A08
+
+#define IMX214_REG_CSI_LANE_MODE	CCI_REG8(0x0114)
+#define IMX214_CSI_2_LANE_MODE		1
+#define IMX214_CSI_4_LANE_MODE		3
+
+#define IMX214_REG_EXCK_FREQ		CCI_REG16(0x0136)
+#define IMX214_EXCK_FREQ(n)		((n) * 256)	/* n expressed in MHz */
+
+#define IMX214_REG_TEMP_SENSOR_CONTROL	CCI_REG8(0x0138)
+
+#define IMX214_REG_HDR_MODE		CCI_REG8(0x0220)
+#define IMX214_HDR_MODE_OFF		0
+#define IMX214_HDR_MODE_ON		1
+
+#define IMX214_REG_HDR_RES_REDUCTION	CCI_REG8(0x0221)
+#define IMX214_HDR_RES_REDU_THROUGH	0x11
+#define IMX214_HDR_RES_REDU_2_BINNING	0x22
+
+/* PLL settings */
+#define IMX214_REG_VTPXCK_DIV		CCI_REG8(0x0301)
+#define IMX214_REG_VTSYCK_DIV		CCI_REG8(0x0303)
+#define IMX214_REG_PREPLLCK_VT_DIV	CCI_REG8(0x0305)
+#define IMX214_REG_PLL_VT_MPY		CCI_REG16(0x0306)
+#define IMX214_REG_OPPXCK_DIV		CCI_REG8(0x0309)
+#define IMX214_REG_OPSYCK_DIV		CCI_REG8(0x030b)
+#define IMX214_REG_PLL_MULT_DRIV	CCI_REG8(0x0310)
+#define IMX214_PLL_SINGLE		0
+#define IMX214_PLL_DUAL			1
+
+#define IMX214_REG_LINE_LENGTH_PCK	CCI_REG16(0x0342)
+#define IMX214_REG_X_ADD_STA		CCI_REG16(0x0344)
+#define IMX214_REG_Y_ADD_STA		CCI_REG16(0x0346)
+#define IMX214_REG_X_ADD_END		CCI_REG16(0x0348)
+#define IMX214_REG_Y_ADD_END		CCI_REG16(0x034a)
+#define IMX214_REG_X_OUTPUT_SIZE	CCI_REG16(0x034c)
+#define IMX214_REG_Y_OUTPUT_SIZE	CCI_REG16(0x034e)
+#define IMX214_REG_X_EVEN_INC		CCI_REG8(0x0381)
+#define IMX214_REG_X_ODD_INC		CCI_REG8(0x0383)
+#define IMX214_REG_Y_EVEN_INC		CCI_REG8(0x0385)
+#define IMX214_REG_Y_ODD_INC		CCI_REG8(0x0387)
+
+#define IMX214_REG_SCALE_MODE		CCI_REG8(0x0401)
+#define IMX214_SCALE_NONE		0
+#define IMX214_SCALE_HORIZONTAL		1
+#define IMX214_SCALE_FULL		2
+#define IMX214_REG_SCALE_M		CCI_REG16(0x0404)
+
+#define IMX214_REG_DIG_CROP_X_OFFSET	CCI_REG16(0x0408)
+#define IMX214_REG_DIG_CROP_Y_OFFSET	CCI_REG16(0x040a)
+#define IMX214_REG_DIG_CROP_WIDTH	CCI_REG16(0x040c)
+#define IMX214_REG_DIG_CROP_HEIGHT	CCI_REG16(0x040e)
+
+#define IMX214_REG_REQ_LINK_BIT_RATE	CCI_REG32(0x0820)
+#define IMX214_LINK_BIT_RATE_MBPS(n)	((n) << 16)
+
+/* Binning mode */
+#define IMX214_REG_BINNING_MODE		CCI_REG8(0x0900)
+#define IMX214_BINNING_NONE		0
+#define IMX214_BINNING_ENABLE		1
+#define IMX214_REG_BINNING_TYPE		CCI_REG8(0x0901)
+#define IMX214_REG_BINNING_WEIGHTING	CCI_REG8(0x0902)
+#define IMX214_BINNING_AVERAGE		0x00
+#define IMX214_BINNING_SUMMED		0x01
+#define IMX214_BINNING_BAYER		0x02
+
+#define IMX214_REG_SING_DEF_CORR_EN	CCI_REG8(0x0b06)
+#define IMX214_SING_DEF_CORR_OFF	0
+#define IMX214_SING_DEF_CORR_ON		1
+
+/* AWB control */
+#define IMX214_REG_ABS_GAIN_GREENR	CCI_REG16(0x0b8e)
+#define IMX214_REG_ABS_GAIN_RED		CCI_REG16(0x0b90)
+#define IMX214_REG_ABS_GAIN_BLUE	CCI_REG16(0x0b92)
+#define IMX214_REG_ABS_GAIN_GREENB	CCI_REG16(0x0b94)
+
+#define IMX214_REG_RMSC_NR_MODE		CCI_REG8(0x3001)
+#define IMX214_REG_STATS_OUT_EN		CCI_REG8(0x3013)
+#define IMX214_STATS_OUT_OFF		0
+#define IMX214_STATS_OUT_ON		1
+
+/* Chroma noise reduction */
+#define IMX214_REG_NML_NR_EN		CCI_REG8(0x30a2)
+#define IMX214_NML_NR_OFF		0
+#define IMX214_NML_NR_ON		1
+
+#define IMX214_REG_EBD_SIZE_V		CCI_REG8(0x5041)
+#define IMX214_EBD_NO			0
+#define IMX214_EBD_4_LINE		4
+
+#define IMX214_REG_RG_STATS_LMT		CCI_REG16(0x6d12)
+#define IMX214_RG_STATS_LMT_10_BIT	0x03FF
+#define IMX214_RG_STATS_LMT_14_BIT	0x3FFF
+
+#define IMX214_REG_ATR_FAST_MOVE	CCI_REG8(0x9300)
 
 /* IMX214 native and active pixel array size */
 #define IMX214_NATIVE_WIDTH		4224U
@@ -59,8 +185,6 @@ struct imx214 {
 
 	struct v4l2_subdev sd;
 	struct media_pad pad;
-	struct v4l2_mbus_framefmt fmt;
-	struct v4l2_rect crop;
 
 	struct v4l2_ctrl_handler ctrls;
 	struct v4l2_ctrl *pixel_rate;
@@ -71,353 +195,266 @@ struct imx214 {
 	struct regulator_bulk_data	supplies[IMX214_NUM_SUPPLIES];
 
 	struct gpio_desc *enable_gpio;
-
-	/*
-	 * Serialize control access, get/set format, get selection
-	 * and start streaming.
-	 */
-	struct mutex mutex;
-};
-
-struct reg_8 {
-	u16 addr;
-	u8 val;
-};
-
-enum {
-	IMX214_TABLE_WAIT_MS = 0,
-	IMX214_TABLE_END,
-	IMX214_MAX_RETRIES,
-	IMX214_WAIT_MS
 };
 
 /*From imx214_mode_tbls.h*/
-static const struct reg_8 mode_4096x2304[] = {
-	{0x0114, 0x03},
-	{0x0220, 0x00},
-	{0x0221, 0x11},
-	{0x0222, 0x01},
-	{0x0340, 0x0C},
-	{0x0341, 0x7A},
-	{0x0342, 0x13},
-	{0x0343, 0x90},
-	{0x0344, 0x00},
-	{0x0345, 0x38},
-	{0x0346, 0x01},
-	{0x0347, 0x98},
-	{0x0348, 0x10},
-	{0x0349, 0x37},
-	{0x034A, 0x0A},
-	{0x034B, 0x97},
-	{0x0381, 0x01},
-	{0x0383, 0x01},
-	{0x0385, 0x01},
-	{0x0387, 0x01},
-	{0x0900, 0x00},
-	{0x0901, 0x00},
-	{0x0902, 0x00},
-	{0x3000, 0x35},
-	{0x3054, 0x01},
-	{0x305C, 0x11},
-
-	{0x0112, 0x0A},
-	{0x0113, 0x0A},
-	{0x034C, 0x10},
-	{0x034D, 0x00},
-	{0x034E, 0x09},
-	{0x034F, 0x00},
-	{0x0401, 0x00},
-	{0x0404, 0x00},
-	{0x0405, 0x10},
-	{0x0408, 0x00},
-	{0x0409, 0x00},
-	{0x040A, 0x00},
-	{0x040B, 0x00},
-	{0x040C, 0x10},
-	{0x040D, 0x00},
-	{0x040E, 0x09},
-	{0x040F, 0x00},
-
-	{0x0301, 0x05},
-	{0x0303, 0x02},
-	{0x0305, 0x03},
-	{0x0306, 0x00},
-	{0x0307, 0x96},
-	{0x0309, 0x0A},
-	{0x030B, 0x01},
-	{0x0310, 0x00},
-
-	{0x0820, 0x12},
-	{0x0821, 0xC0},
-	{0x0822, 0x00},
-	{0x0823, 0x00},
-
-	{0x3A03, 0x09},
-	{0x3A04, 0x50},
-	{0x3A05, 0x01},
-
-	{0x0B06, 0x01},
-	{0x30A2, 0x00},
-
-	{0x30B4, 0x00},
-
-	{0x3A02, 0xFF},
-
-	{0x3011, 0x00},
-	{0x3013, 0x01},
-
-	{0x0202, 0x0C},
-	{0x0203, 0x70},
-	{0x0224, 0x01},
-	{0x0225, 0xF4},
-
-	{0x0204, 0x00},
-	{0x0205, 0x00},
-	{0x020E, 0x01},
-	{0x020F, 0x00},
-	{0x0210, 0x01},
-	{0x0211, 0x00},
-	{0x0212, 0x01},
-	{0x0213, 0x00},
-	{0x0214, 0x01},
-	{0x0215, 0x00},
-	{0x0216, 0x00},
-	{0x0217, 0x00},
-
-	{0x4170, 0x00},
-	{0x4171, 0x10},
-	{0x4176, 0x00},
-	{0x4177, 0x3C},
-	{0xAE20, 0x04},
-	{0xAE21, 0x5C},
-
-	{IMX214_TABLE_WAIT_MS, 10},
-	{0x0138, 0x01},
-	{IMX214_TABLE_END, 0x00}
+static const struct cci_reg_sequence mode_4096x2304[] = {
+	{ IMX214_REG_HDR_MODE, IMX214_HDR_MODE_OFF },
+	{ IMX214_REG_HDR_RES_REDUCTION, IMX214_HDR_RES_REDU_THROUGH },
+	{ IMX214_REG_EXPOSURE_RATIO, 1 },
+	{ IMX214_REG_FRM_LENGTH_LINES, 3194 },
+	{ IMX214_REG_LINE_LENGTH_PCK, 5008 },
+	{ IMX214_REG_X_ADD_STA, 56 },
+	{ IMX214_REG_Y_ADD_STA, 408 },
+	{ IMX214_REG_X_ADD_END, 4151 },
+	{ IMX214_REG_Y_ADD_END, 2711 },
+	{ IMX214_REG_X_EVEN_INC, 1 },
+	{ IMX214_REG_X_ODD_INC, 1 },
+	{ IMX214_REG_Y_EVEN_INC, 1 },
+	{ IMX214_REG_Y_ODD_INC, 1 },
+	{ IMX214_REG_BINNING_MODE, IMX214_BINNING_NONE },
+	{ IMX214_REG_BINNING_TYPE, 0 },
+	{ IMX214_REG_BINNING_WEIGHTING, IMX214_BINNING_AVERAGE },
+	{ CCI_REG8(0x3000), 0x35 },
+	{ CCI_REG8(0x3054), 0x01 },
+	{ CCI_REG8(0x305C), 0x11 },
+
+	{ IMX214_REG_CSI_DATA_FORMAT, IMX214_CSI_DATA_FORMAT_RAW10 },
+	{ IMX214_REG_X_OUTPUT_SIZE, 4096 },
+	{ IMX214_REG_Y_OUTPUT_SIZE, 2304 },
+	{ IMX214_REG_SCALE_MODE, IMX214_SCALE_NONE },
+	{ IMX214_REG_SCALE_M, 2 },
+	{ IMX214_REG_DIG_CROP_X_OFFSET, 0 },
+	{ IMX214_REG_DIG_CROP_Y_OFFSET, 0 },
+	{ IMX214_REG_DIG_CROP_WIDTH, 4096 },
+	{ IMX214_REG_DIG_CROP_HEIGHT, 2304 },
+
+	{ IMX214_REG_VTPXCK_DIV, 5 },
+	{ IMX214_REG_VTSYCK_DIV, 2 },
+	{ IMX214_REG_PREPLLCK_VT_DIV, 3 },
+	{ IMX214_REG_PLL_VT_MPY, 150 },
+	{ IMX214_REG_OPPXCK_DIV, 10 },
+	{ IMX214_REG_OPSYCK_DIV, 1 },
+	{ IMX214_REG_PLL_MULT_DRIV, IMX214_PLL_SINGLE },
+
+	{ IMX214_REG_REQ_LINK_BIT_RATE, IMX214_LINK_BIT_RATE_MBPS(4800) },
+
+	{ CCI_REG8(0x3A03), 0x09 },
+	{ CCI_REG8(0x3A04), 0x50 },
+	{ CCI_REG8(0x3A05), 0x01 },
+
+	{ IMX214_REG_SING_DEF_CORR_EN, IMX214_SING_DEF_CORR_ON },
+	{ IMX214_REG_NML_NR_EN, IMX214_NML_NR_OFF },
+
+	{ CCI_REG8(0x30B4), 0x00 },
+
+	{ CCI_REG8(0x3A02), 0xFF },
+
+	{ CCI_REG8(0x3011), 0x00 },
+	{ IMX214_REG_STATS_OUT_EN, IMX214_STATS_OUT_ON },
+
+	{ IMX214_REG_EXPOSURE, IMX214_EXPOSURE_DEFAULT },
+	{ IMX214_REG_SHORT_EXPOSURE, 500 },
+
+	{ IMX214_REG_ANALOG_GAIN, 0 },
+	{ IMX214_REG_DIG_GAIN_GREENR, 256 },
+	{ IMX214_REG_DIG_GAIN_RED, 256 },
+	{ IMX214_REG_DIG_GAIN_BLUE, 256 },
+	{ IMX214_REG_DIG_GAIN_GREENB, 256 },
+	{ IMX214_REG_SHORT_ANALOG_GAIN, 0 },
+
+	{ CCI_REG8(0x4170), 0x00 },
+	{ CCI_REG8(0x4171), 0x10 },
+	{ CCI_REG8(0x4176), 0x00 },
+	{ CCI_REG8(0x4177), 0x3C },
+	{ CCI_REG8(0xAE20), 0x04 },
+	{ CCI_REG8(0xAE21), 0x5C },
 };
 
-static const struct reg_8 mode_1920x1080[] = {
-	{0x0114, 0x03},
-	{0x0220, 0x00},
-	{0x0221, 0x11},
-	{0x0222, 0x01},
-	{0x0340, 0x0C},
-	{0x0341, 0x7A},
-	{0x0342, 0x13},
-	{0x0343, 0x90},
-	{0x0344, 0x04},
-	{0x0345, 0x78},
-	{0x0346, 0x03},
-	{0x0347, 0xFC},
-	{0x0348, 0x0B},
-	{0x0349, 0xF7},
-	{0x034A, 0x08},
-	{0x034B, 0x33},
-	{0x0381, 0x01},
-	{0x0383, 0x01},
-	{0x0385, 0x01},
-	{0x0387, 0x01},
-	{0x0900, 0x00},
-	{0x0901, 0x00},
-	{0x0902, 0x00},
-	{0x3000, 0x35},
-	{0x3054, 0x01},
-	{0x305C, 0x11},
-
-	{0x0112, 0x0A},
-	{0x0113, 0x0A},
-	{0x034C, 0x07},
-	{0x034D, 0x80},
-	{0x034E, 0x04},
-	{0x034F, 0x38},
-	{0x0401, 0x00},
-	{0x0404, 0x00},
-	{0x0405, 0x10},
-	{0x0408, 0x00},
-	{0x0409, 0x00},
-	{0x040A, 0x00},
-	{0x040B, 0x00},
-	{0x040C, 0x07},
-	{0x040D, 0x80},
-	{0x040E, 0x04},
-	{0x040F, 0x38},
-
-	{0x0301, 0x05},
-	{0x0303, 0x02},
-	{0x0305, 0x03},
-	{0x0306, 0x00},
-	{0x0307, 0x96},
-	{0x0309, 0x0A},
-	{0x030B, 0x01},
-	{0x0310, 0x00},
-
-	{0x0820, 0x12},
-	{0x0821, 0xC0},
-	{0x0822, 0x00},
-	{0x0823, 0x00},
-
-	{0x3A03, 0x04},
-	{0x3A04, 0xF8},
-	{0x3A05, 0x02},
-
-	{0x0B06, 0x01},
-	{0x30A2, 0x00},
-
-	{0x30B4, 0x00},
-
-	{0x3A02, 0xFF},
-
-	{0x3011, 0x00},
-	{0x3013, 0x01},
-
-	{0x0202, 0x0C},
-	{0x0203, 0x70},
-	{0x0224, 0x01},
-	{0x0225, 0xF4},
-
-	{0x0204, 0x00},
-	{0x0205, 0x00},
-	{0x020E, 0x01},
-	{0x020F, 0x00},
-	{0x0210, 0x01},
-	{0x0211, 0x00},
-	{0x0212, 0x01},
-	{0x0213, 0x00},
-	{0x0214, 0x01},
-	{0x0215, 0x00},
-	{0x0216, 0x00},
-	{0x0217, 0x00},
-
-	{0x4170, 0x00},
-	{0x4171, 0x10},
-	{0x4176, 0x00},
-	{0x4177, 0x3C},
-	{0xAE20, 0x04},
-	{0xAE21, 0x5C},
-
-	{IMX214_TABLE_WAIT_MS, 10},
-	{0x0138, 0x01},
-	{IMX214_TABLE_END, 0x00}
+static const struct cci_reg_sequence mode_1920x1080[] = {
+	{ IMX214_REG_HDR_MODE, IMX214_HDR_MODE_OFF },
+	{ IMX214_REG_HDR_RES_REDUCTION, IMX214_HDR_RES_REDU_THROUGH },
+	{ IMX214_REG_EXPOSURE_RATIO, 1 },
+	{ IMX214_REG_FRM_LENGTH_LINES, 3194 },
+	{ IMX214_REG_LINE_LENGTH_PCK, 5008 },
+	{ IMX214_REG_X_ADD_STA, 1144 },
+	{ IMX214_REG_Y_ADD_STA, 1020 },
+	{ IMX214_REG_X_ADD_END, 3063 },
+	{ IMX214_REG_Y_ADD_END, 2099 },
+	{ IMX214_REG_X_EVEN_INC, 1 },
+	{ IMX214_REG_X_ODD_INC, 1 },
+	{ IMX214_REG_Y_EVEN_INC, 1 },
+	{ IMX214_REG_Y_ODD_INC, 1 },
+	{ IMX214_REG_BINNING_MODE, IMX214_BINNING_NONE },
+	{ IMX214_REG_BINNING_TYPE, 0 },
+	{ IMX214_REG_BINNING_WEIGHTING, IMX214_BINNING_AVERAGE },
+	{ CCI_REG8(0x3000), 0x35 },
+	{ CCI_REG8(0x3054), 0x01 },
+	{ CCI_REG8(0x305C), 0x11 },
+
+	{ IMX214_REG_CSI_DATA_FORMAT, IMX214_CSI_DATA_FORMAT_RAW10 },
+	{ IMX214_REG_X_OUTPUT_SIZE, 1920 },
+	{ IMX214_REG_Y_OUTPUT_SIZE, 1080 },
+	{ IMX214_REG_SCALE_MODE, IMX214_SCALE_NONE },
+	{ IMX214_REG_SCALE_M, 2 },
+	{ IMX214_REG_DIG_CROP_X_OFFSET, 0 },
+	{ IMX214_REG_DIG_CROP_Y_OFFSET, 0 },
+	{ IMX214_REG_DIG_CROP_WIDTH, 1920 },
+	{ IMX214_REG_DIG_CROP_HEIGHT, 1080 },
+
+	{ IMX214_REG_VTPXCK_DIV, 5 },
+	{ IMX214_REG_VTSYCK_DIV, 2 },
+	{ IMX214_REG_PREPLLCK_VT_DIV, 3 },
+	{ IMX214_REG_PLL_VT_MPY, 150 },
+	{ IMX214_REG_OPPXCK_DIV, 10 },
+	{ IMX214_REG_OPSYCK_DIV, 1 },
+	{ IMX214_REG_PLL_MULT_DRIV, IMX214_PLL_SINGLE },
+
+	{ IMX214_REG_REQ_LINK_BIT_RATE, IMX214_LINK_BIT_RATE_MBPS(4800) },
+
+	{ CCI_REG8(0x3A03), 0x04 },
+	{ CCI_REG8(0x3A04), 0xF8 },
+	{ CCI_REG8(0x3A05), 0x02 },
+
+	{ IMX214_REG_SING_DEF_CORR_EN, IMX214_SING_DEF_CORR_ON },
+	{ IMX214_REG_NML_NR_EN, IMX214_NML_NR_OFF },
+
+	{ CCI_REG8(0x30B4), 0x00 },
+
+	{ CCI_REG8(0x3A02), 0xFF },
+
+	{ CCI_REG8(0x3011), 0x00 },
+	{ IMX214_REG_STATS_OUT_EN, IMX214_STATS_OUT_ON },
+
+	{ IMX214_REG_EXPOSURE, IMX214_EXPOSURE_DEFAULT },
+	{ IMX214_REG_SHORT_EXPOSURE, 500 },
+
+	{ IMX214_REG_ANALOG_GAIN, 0 },
+	{ IMX214_REG_DIG_GAIN_GREENR, 256 },
+	{ IMX214_REG_DIG_GAIN_RED, 256 },
+	{ IMX214_REG_DIG_GAIN_BLUE, 256 },
+	{ IMX214_REG_DIG_GAIN_GREENB, 256 },
+	{ IMX214_REG_SHORT_ANALOG_GAIN, 0 },
+
+	{ CCI_REG8(0x4170), 0x00 },
+	{ CCI_REG8(0x4171), 0x10 },
+	{ CCI_REG8(0x4176), 0x00 },
+	{ CCI_REG8(0x4177), 0x3C },
+	{ CCI_REG8(0xAE20), 0x04 },
+	{ CCI_REG8(0xAE21), 0x5C },
 };
 
-static const struct reg_8 mode_table_common[] = {
+static const struct cci_reg_sequence mode_table_common[] = {
 	/* software reset */
 
 	/* software standby settings */
-	{0x0100, 0x00},
+	{ IMX214_REG_MODE_SELECT, IMX214_MODE_STANDBY },
 
 	/* ATR setting */
-	{0x9300, 0x02},
+	{ IMX214_REG_ATR_FAST_MOVE, 2 },
 
 	/* external clock setting */
-	{0x0136, 0x18},
-	{0x0137, 0x00},
+	{ IMX214_REG_EXCK_FREQ, IMX214_EXCK_FREQ(IMX214_DEFAULT_CLK_FREQ / 1000000) },
 
 	/* global setting */
 	/* basic config */
-	{0x0101, 0x00},
-	{0x0105, 0x01},
-	{0x0106, 0x01},
-	{0x4550, 0x02},
-	{0x4601, 0x00},
-	{0x4642, 0x05},
-	{0x6227, 0x11},
-	{0x6276, 0x00},
-	{0x900E, 0x06},
-	{0xA802, 0x90},
-	{0xA803, 0x11},
-	{0xA804, 0x62},
-	{0xA805, 0x77},
-	{0xA806, 0xAE},
-	{0xA807, 0x34},
-	{0xA808, 0xAE},
-	{0xA809, 0x35},
-	{0xA80A, 0x62},
-	{0xA80B, 0x83},
-	{0xAE33, 0x00},
+	{ IMX214_REG_ORIENTATION, 0 },
+	{ IMX214_REG_MASK_CORR_FRAMES, IMX214_CORR_FRAMES_MASK },
+	{ IMX214_REG_FAST_STANDBY_CTRL, 1 },
+	{ CCI_REG8(0x4550), 0x02 },
+	{ CCI_REG8(0x4601), 0x00 },
+	{ CCI_REG8(0x4642), 0x05 },
+	{ CCI_REG8(0x6227), 0x11 },
+	{ CCI_REG8(0x6276), 0x00 },
+	{ CCI_REG8(0x900E), 0x06 },
+	{ CCI_REG8(0xA802), 0x90 },
+	{ CCI_REG8(0xA803), 0x11 },
+	{ CCI_REG8(0xA804), 0x62 },
+	{ CCI_REG8(0xA805), 0x77 },
+	{ CCI_REG8(0xA806), 0xAE },
+	{ CCI_REG8(0xA807), 0x34 },
+	{ CCI_REG8(0xA808), 0xAE },
+	{ CCI_REG8(0xA809), 0x35 },
+	{ CCI_REG8(0xA80A), 0x62 },
+	{ CCI_REG8(0xA80B), 0x83 },
+	{ CCI_REG8(0xAE33), 0x00 },
 
 	/* analog setting */
-	{0x4174, 0x00},
-	{0x4175, 0x11},
-	{0x4612, 0x29},
-	{0x461B, 0x12},
-	{0x461F, 0x06},
-	{0x4635, 0x07},
-	{0x4637, 0x30},
-	{0x463F, 0x18},
-	{0x4641, 0x0D},
-	{0x465B, 0x12},
-	{0x465F, 0x11},
-	{0x4663, 0x11},
-	{0x4667, 0x0F},
-	{0x466F, 0x0F},
-	{0x470E, 0x09},
-	{0x4909, 0xAB},
-	{0x490B, 0x95},
-	{0x4915, 0x5D},
-	{0x4A5F, 0xFF},
-	{0x4A61, 0xFF},
-	{0x4A73, 0x62},
-	{0x4A85, 0x00},
-	{0x4A87, 0xFF},
+	{ CCI_REG8(0x4174), 0x00 },
+	{ CCI_REG8(0x4175), 0x11 },
+	{ CCI_REG8(0x4612), 0x29 },
+	{ CCI_REG8(0x461B), 0x12 },
+	{ CCI_REG8(0x461F), 0x06 },
+	{ CCI_REG8(0x4635), 0x07 },
+	{ CCI_REG8(0x4637), 0x30 },
+	{ CCI_REG8(0x463F), 0x18 },
+	{ CCI_REG8(0x4641), 0x0D },
+	{ CCI_REG8(0x465B), 0x12 },
+	{ CCI_REG8(0x465F), 0x11 },
+	{ CCI_REG8(0x4663), 0x11 },
+	{ CCI_REG8(0x4667), 0x0F },
+	{ CCI_REG8(0x466F), 0x0F },
+	{ CCI_REG8(0x470E), 0x09 },
+	{ CCI_REG8(0x4909), 0xAB },
+	{ CCI_REG8(0x490B), 0x95 },
+	{ CCI_REG8(0x4915), 0x5D },
+	{ CCI_REG8(0x4A5F), 0xFF },
+	{ CCI_REG8(0x4A61), 0xFF },
+	{ CCI_REG8(0x4A73), 0x62 },
+	{ CCI_REG8(0x4A85), 0x00 },
+	{ CCI_REG8(0x4A87), 0xFF },
 
 	/* embedded data */
-	{0x5041, 0x04},
-	{0x583C, 0x04},
-	{0x620E, 0x04},
-	{0x6EB2, 0x01},
-	{0x6EB3, 0x00},
-	{0x9300, 0x02},
+	{ IMX214_REG_EBD_SIZE_V, IMX214_EBD_4_LINE },
+	{ CCI_REG8(0x583C), 0x04 },
+	{ CCI_REG8(0x620E), 0x04 },
+	{ CCI_REG8(0x6EB2), 0x01 },
+	{ CCI_REG8(0x6EB3), 0x00 },
+	{ IMX214_REG_ATR_FAST_MOVE, 2 },
 
 	/* imagequality */
 	/* HDR setting */
-	{0x3001, 0x07},
-	{0x6D12, 0x3F},
-	{0x6D13, 0xFF},
-	{0x9344, 0x03},
-	{0x9706, 0x10},
-	{0x9707, 0x03},
-	{0x9708, 0x03},
-	{0x9E04, 0x01},
-	{0x9E05, 0x00},
-	{0x9E0C, 0x01},
-	{0x9E0D, 0x02},
-	{0x9E24, 0x00},
-	{0x9E25, 0x8C},
-	{0x9E26, 0x00},
-	{0x9E27, 0x94},
-	{0x9E28, 0x00},
-	{0x9E29, 0x96},
+	{ IMX214_REG_RMSC_NR_MODE, 0x07 },
+	{ IMX214_REG_RG_STATS_LMT, IMX214_RG_STATS_LMT_14_BIT },
+	{ CCI_REG8(0x9344), 0x03 },
+	{ CCI_REG8(0x9706), 0x10 },
+	{ CCI_REG8(0x9707), 0x03 },
+	{ CCI_REG8(0x9708), 0x03 },
+	{ CCI_REG8(0x9E04), 0x01 },
+	{ CCI_REG8(0x9E05), 0x00 },
+	{ CCI_REG8(0x9E0C), 0x01 },
+	{ CCI_REG8(0x9E0D), 0x02 },
+	{ CCI_REG8(0x9E24), 0x00 },
+	{ CCI_REG8(0x9E25), 0x8C },
+	{ CCI_REG8(0x9E26), 0x00 },
+	{ CCI_REG8(0x9E27), 0x94 },
+	{ CCI_REG8(0x9E28), 0x00 },
+	{ CCI_REG8(0x9E29), 0x96 },
 
 	/* CNR parameter setting */
-	{0x69DB, 0x01},
+	{ CCI_REG8(0x69DB), 0x01 },
 
 	/* Moire reduction */
-	{0x6957, 0x01},
+	{ CCI_REG8(0x6957), 0x01 },
 
 	/* image enhancement */
-	{0x6987, 0x17},
-	{0x698A, 0x03},
-	{0x698B, 0x03},
+	{ CCI_REG8(0x6987), 0x17 },
+	{ CCI_REG8(0x698A), 0x03 },
+	{ CCI_REG8(0x698B), 0x03 },
 
 	/* white balanace */
-	{0x0B8E, 0x01},
-	{0x0B8F, 0x00},
-	{0x0B90, 0x01},
-	{0x0B91, 0x00},
-	{0x0B92, 0x01},
-	{0x0B93, 0x00},
-	{0x0B94, 0x01},
-	{0x0B95, 0x00},
+	{ IMX214_REG_ABS_GAIN_GREENR, 0x0100 },
+	{ IMX214_REG_ABS_GAIN_RED, 0x0100 },
+	{ IMX214_REG_ABS_GAIN_BLUE, 0x0100 },
+	{ IMX214_REG_ABS_GAIN_GREENB, 0x0100 },
 
 	/* ATR setting */
-	{0x6E50, 0x00},
-	{0x6E51, 0x32},
-	{0x9340, 0x00},
-	{0x9341, 0x3C},
-	{0x9342, 0x03},
-	{0x9343, 0xFF},
-	{IMX214_TABLE_END, 0x00}
+	{ CCI_REG8(0x6E50), 0x00 },
+	{ CCI_REG8(0x6E51), 0x32 },
+	{ CCI_REG8(0x9340), 0x00 },
+	{ CCI_REG8(0x9341), 0x3C },
+	{ CCI_REG8(0x9342), 0x03 },
+	{ CCI_REG8(0x9343), 0xFF },
 };
 
 /*
@@ -427,16 +464,19 @@ static const struct reg_8 mode_table_common[] = {
 static const struct imx214_mode {
 	u32 width;
 	u32 height;
-	const struct reg_8 *reg_table;
+	unsigned int num_of_regs;
+	const struct cci_reg_sequence *reg_table;
 } imx214_modes[] = {
 	{
 		.width = 4096,
 		.height = 2304,
+		.num_of_regs = ARRAY_SIZE(mode_4096x2304),
 		.reg_table = mode_4096x2304,
 	},
 	{
 		.width = 1920,
 		.height = 1080,
+		.num_of_regs = ARRAY_SIZE(mode_1920x1080),
 		.reg_table = mode_1920x1080,
 	},
 };
@@ -490,6 +530,22 @@ static int __maybe_unused imx214_power_off(struct device *dev)
 	return 0;
 }
 
+static void imx214_update_pad_format(struct imx214 *imx214,
+				     const struct imx214_mode *mode,
+				     struct v4l2_mbus_framefmt *fmt, u32 code)
+{
+	fmt->code = IMX214_MBUS_CODE;
+	fmt->width = mode->width;
+	fmt->height = mode->height;
+	fmt->field = V4L2_FIELD_NONE;
+	fmt->colorspace = V4L2_COLORSPACE_SRGB;
+	fmt->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(fmt->colorspace);
+	fmt->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(true,
+							  fmt->colorspace,
+							  fmt->ycbcr_enc);
+	fmt->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(fmt->colorspace);
+}
+
 static int imx214_enum_mbus_code(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_state *sd_state,
 				 struct v4l2_subdev_mbus_code_enum *code)
@@ -549,52 +605,6 @@ static const struct v4l2_subdev_core_ops imx214_core_ops = {
 #endif
 };
 
-static struct v4l2_mbus_framefmt *
-__imx214_get_pad_format(struct imx214 *imx214,
-			struct v4l2_subdev_state *sd_state,
-			unsigned int pad,
-			enum v4l2_subdev_format_whence which)
-{
-	switch (which) {
-	case V4L2_SUBDEV_FORMAT_TRY:
-		return v4l2_subdev_state_get_format(sd_state, pad);
-	case V4L2_SUBDEV_FORMAT_ACTIVE:
-		return &imx214->fmt;
-	default:
-		return NULL;
-	}
-}
-
-static int imx214_get_format(struct v4l2_subdev *sd,
-			     struct v4l2_subdev_state *sd_state,
-			     struct v4l2_subdev_format *format)
-{
-	struct imx214 *imx214 = to_imx214(sd);
-
-	mutex_lock(&imx214->mutex);
-	format->format = *__imx214_get_pad_format(imx214, sd_state,
-						  format->pad,
-						  format->which);
-	mutex_unlock(&imx214->mutex);
-
-	return 0;
-}
-
-static struct v4l2_rect *
-__imx214_get_pad_crop(struct imx214 *imx214,
-		      struct v4l2_subdev_state *sd_state,
-		      unsigned int pad, enum v4l2_subdev_format_whence which)
-{
-	switch (which) {
-	case V4L2_SUBDEV_FORMAT_TRY:
-		return v4l2_subdev_state_get_crop(sd_state, pad);
-	case V4L2_SUBDEV_FORMAT_ACTIVE:
-		return &imx214->crop;
-	default:
-		return NULL;
-	}
-}
-
 static int imx214_set_format(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_state *sd_state,
 			     struct v4l2_subdev_format *format)
@@ -604,34 +614,20 @@ static int imx214_set_format(struct v4l2_subdev *sd,
 	struct v4l2_rect *__crop;
 	const struct imx214_mode *mode;
 
-	mutex_lock(&imx214->mutex);
-
-	__crop = __imx214_get_pad_crop(imx214, sd_state, format->pad,
-				       format->which);
-
 	mode = v4l2_find_nearest_size(imx214_modes,
 				      ARRAY_SIZE(imx214_modes), width, height,
 				      format->format.width,
 				      format->format.height);
 
-	__crop->width = mode->width;
-	__crop->height = mode->height;
-
-	__format = __imx214_get_pad_format(imx214, sd_state, format->pad,
-					   format->which);
-	__format->width = __crop->width;
-	__format->height = __crop->height;
-	__format->code = IMX214_MBUS_CODE;
-	__format->field = V4L2_FIELD_NONE;
-	__format->colorspace = V4L2_COLORSPACE_SRGB;
-	__format->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(__format->colorspace);
-	__format->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(true,
-				__format->colorspace, __format->ycbcr_enc);
-	__format->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(__format->colorspace);
+	imx214_update_pad_format(imx214, mode, &format->format,
+				 format->format.code);
+	__format = v4l2_subdev_state_get_format(sd_state, 0);
 
-	format->format = *__format;
+	*__format = format->format;
 
-	mutex_unlock(&imx214->mutex);
+	__crop = v4l2_subdev_state_get_crop(sd_state, 0);
+	__crop->width = mode->width;
+	__crop->height = mode->height;
 
 	return 0;
 }
@@ -640,14 +636,9 @@ static int imx214_get_selection(struct v4l2_subdev *sd,
 				struct v4l2_subdev_state *sd_state,
 				struct v4l2_subdev_selection *sel)
 {
-	struct imx214 *imx214 = to_imx214(sd);
-
 	switch (sel->target) {
 	case V4L2_SEL_TGT_CROP:
-		mutex_lock(&imx214->mutex);
-		sel->r = *__imx214_get_pad_crop(imx214, sd_state, sel->pad,
-						sel->which);
-		mutex_unlock(&imx214->mutex);
+		sel->r = *v4l2_subdev_state_get_crop(sd_state, 0);
 		return 0;
 
 	case V4L2_SEL_TGT_NATIVE_SIZE:
@@ -687,7 +678,6 @@ static int imx214_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct imx214 *imx214 = container_of(ctrl->handler,
 					     struct imx214, ctrls);
-	u8 vals[2];
 	int ret;
 
 	/*
@@ -699,12 +689,7 @@ static int imx214_set_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_EXPOSURE:
-		vals[1] = ctrl->val;
-		vals[0] = ctrl->val >> 8;
-		ret = regmap_bulk_write(imx214->regmap, IMX214_REG_EXPOSURE, vals, 2);
-		if (ret < 0)
-			dev_err(imx214->dev, "Error %d\n", ret);
-		ret = 0;
+		cci_write(imx214->regmap, IMX214_REG_EXPOSURE, ctrl->val, &ret);
 		break;
 
 	default:
@@ -790,76 +775,52 @@ static int imx214_ctrls_init(struct imx214 *imx214)
 	return 0;
 };
 
-#define MAX_CMD 4
-static int imx214_write_table(struct imx214 *imx214,
-			      const struct reg_8 table[])
-{
-	u8 vals[MAX_CMD];
-	int i;
-	int ret;
-
-	for (; table->addr != IMX214_TABLE_END ; table++) {
-		if (table->addr == IMX214_TABLE_WAIT_MS) {
-			usleep_range(table->val * 1000,
-				     table->val * 1000 + 500);
-			continue;
-		}
-
-		for (i = 0; i < MAX_CMD; i++) {
-			if (table[i].addr != (table[0].addr + i))
-				break;
-			vals[i] = table[i].val;
-		}
-
-		ret = regmap_bulk_write(imx214->regmap, table->addr, vals, i);
-
-		if (ret) {
-			dev_err(imx214->dev, "write_table error: %d\n", ret);
-			return ret;
-		}
-
-		table += i - 1;
-	}
-
-	return 0;
-}
-
 static int imx214_start_streaming(struct imx214 *imx214)
 {
+	const struct v4l2_mbus_framefmt *fmt;
+	struct v4l2_subdev_state *state;
 	const struct imx214_mode *mode;
 	int ret;
 
-	mutex_lock(&imx214->mutex);
-	ret = imx214_write_table(imx214, mode_table_common);
+	ret = cci_multi_reg_write(imx214->regmap, mode_table_common,
+				  ARRAY_SIZE(mode_table_common), NULL);
 	if (ret < 0) {
 		dev_err(imx214->dev, "could not sent common table %d\n", ret);
-		goto error;
+		return ret;
 	}
 
-	mode = v4l2_find_nearest_size(imx214_modes,
-				ARRAY_SIZE(imx214_modes), width, height,
-				imx214->fmt.width, imx214->fmt.height);
-	ret = imx214_write_table(imx214, mode->reg_table);
+	ret = cci_write(imx214->regmap, IMX214_REG_CSI_LANE_MODE,
+			IMX214_CSI_4_LANE_MODE, NULL);
+	if (ret) {
+		dev_err(imx214->dev, "failed to configure lanes\n");
+		return ret;
+	}
+
+	state = v4l2_subdev_get_locked_active_state(&imx214->sd);
+	fmt = v4l2_subdev_state_get_format(state, 0);
+	mode = v4l2_find_nearest_size(imx214_modes, ARRAY_SIZE(imx214_modes),
+				      width, height, fmt->width, fmt->height);
+	ret = cci_multi_reg_write(imx214->regmap, mode->reg_table,
+				  mode->num_of_regs, NULL);
 	if (ret < 0) {
 		dev_err(imx214->dev, "could not sent mode table %d\n", ret);
-		goto error;
+		return ret;
 	}
+
+	usleep_range(10000, 10500);
+
+	cci_write(imx214->regmap, IMX214_REG_TEMP_SENSOR_CONTROL, 0x01, NULL);
+
 	ret = __v4l2_ctrl_handler_setup(&imx214->ctrls);
 	if (ret < 0) {
 		dev_err(imx214->dev, "could not sync v4l2 controls\n");
-		goto error;
+		return ret;
 	}
-	ret = regmap_write(imx214->regmap, IMX214_REG_MODE_SELECT, IMX214_MODE_STREAMING);
-	if (ret < 0) {
+	ret = cci_write(imx214->regmap, IMX214_REG_MODE_SELECT,
+			IMX214_MODE_STREAMING, NULL);
+	if (ret < 0)
 		dev_err(imx214->dev, "could not sent start table %d\n", ret);
-		goto error;
-	}
 
-	mutex_unlock(&imx214->mutex);
-	return 0;
-
-error:
-	mutex_unlock(&imx214->mutex);
 	return ret;
 }
 
@@ -867,7 +828,8 @@ static int imx214_stop_streaming(struct imx214 *imx214)
 {
 	int ret;
 
-	ret = regmap_write(imx214->regmap, IMX214_REG_MODE_SELECT, IMX214_MODE_STANDBY);
+	ret = cci_write(imx214->regmap, IMX214_REG_MODE_SELECT,
+			IMX214_MODE_STANDBY, NULL);
 	if (ret < 0)
 		dev_err(imx214->dev, "could not sent stop table %d\n",	ret);
 
@@ -877,14 +839,17 @@ static int imx214_stop_streaming(struct imx214 *imx214)
 static int imx214_s_stream(struct v4l2_subdev *subdev, int enable)
 {
 	struct imx214 *imx214 = to_imx214(subdev);
-	int ret;
+	struct v4l2_subdev_state *state;
+	int ret = 0;
 
 	if (enable) {
 		ret = pm_runtime_resume_and_get(imx214->dev);
 		if (ret < 0)
 			return ret;
 
+		state = v4l2_subdev_lock_and_get_active_state(subdev);
 		ret = imx214_start_streaming(imx214);
+		v4l2_subdev_unlock_state(state);
 		if (ret < 0)
 			goto err_rpm_put;
 	} else {
@@ -948,7 +913,7 @@ static const struct v4l2_subdev_pad_ops imx214_subdev_pad_ops = {
 	.enum_mbus_code = imx214_enum_mbus_code,
 	.enum_frame_size = imx214_enum_frame_size,
 	.enum_frame_interval = imx214_enum_frame_interval,
-	.get_fmt = imx214_get_format,
+	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = imx214_set_format,
 	.get_selection = imx214_get_selection,
 	.get_frame_interval = imx214_get_frame_interval,
@@ -965,12 +930,6 @@ static const struct v4l2_subdev_internal_ops imx214_internal_ops = {
 	.init_state = imx214_entity_init_state,
 };
 
-static const struct regmap_config sensor_regmap_config = {
-	.reg_bits = 16,
-	.val_bits = 8,
-	.cache_type = REGCACHE_MAPLE,
-};
-
 static int imx214_get_regulators(struct device *dev, struct imx214 *imx214)
 {
 	unsigned int i;
@@ -992,28 +951,42 @@ static int imx214_parse_fwnode(struct device *dev)
 	int ret;
 
 	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
-	if (!endpoint) {
-		dev_err(dev, "endpoint node not found\n");
-		return -EINVAL;
-	}
+	if (!endpoint)
+		return dev_err_probe(dev, -EINVAL, "endpoint node not found\n");
 
 	ret = v4l2_fwnode_endpoint_alloc_parse(endpoint, &bus_cfg);
 	if (ret) {
-		dev_err(dev, "parsing endpoint node failed\n");
+		dev_err_probe(dev, ret, "parsing endpoint node failed\n");
+		goto done;
+	}
+
+	/* Check the number of MIPI CSI2 data lanes */
+	if (bus_cfg.bus.mipi_csi2.num_data_lanes != 4) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "only 4 data lanes are currently supported\n");
 		goto done;
 	}
 
-	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
+	if (bus_cfg.nr_of_link_frequencies != 1)
+		dev_warn(dev, "Only one link-frequency supported, please review your DT. Continuing anyway\n");
+
+	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++) {
 		if (bus_cfg.link_frequencies[i] == IMX214_DEFAULT_LINK_FREQ)
 			break;
-
-	if (i == bus_cfg.nr_of_link_frequencies) {
-		dev_err(dev, "link-frequencies %d not supported, Please review your DT\n",
-			IMX214_DEFAULT_LINK_FREQ);
-		ret = -EINVAL;
-		goto done;
+		if (bus_cfg.link_frequencies[i] ==
+		    IMX214_DEFAULT_LINK_FREQ_LEGACY) {
+			dev_warn(dev,
+				 "link-frequencies %d not supported, please review your DT. Continuing anyway\n",
+				 IMX214_DEFAULT_LINK_FREQ);
+			break;
+		}
 	}
 
+	if (i == bus_cfg.nr_of_link_frequencies)
+		ret = dev_err_probe(dev, -EINVAL,
+				    "link-frequencies %d not supported, please review your DT\n",
+				    IMX214_DEFAULT_LINK_FREQ);
+
 done:
 	v4l2_fwnode_endpoint_free(&bus_cfg);
 	fwnode_handle_put(endpoint);
@@ -1037,34 +1010,28 @@ static int imx214_probe(struct i2c_client *client)
 	imx214->dev = dev;
 
 	imx214->xclk = devm_clk_get(dev, NULL);
-	if (IS_ERR(imx214->xclk)) {
-		dev_err(dev, "could not get xclk");
-		return PTR_ERR(imx214->xclk);
-	}
+	if (IS_ERR(imx214->xclk))
+		return dev_err_probe(dev, PTR_ERR(imx214->xclk),
+				     "failed to get xclk\n");
 
 	ret = clk_set_rate(imx214->xclk, IMX214_DEFAULT_CLK_FREQ);
-	if (ret) {
-		dev_err(dev, "could not set xclk frequency\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to set xclk frequency\n");
 
 	ret = imx214_get_regulators(dev, imx214);
-	if (ret < 0) {
-		dev_err(dev, "cannot get regulators\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get regulators\n");
 
 	imx214->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
-	if (IS_ERR(imx214->enable_gpio)) {
-		dev_err(dev, "cannot get enable gpio\n");
-		return PTR_ERR(imx214->enable_gpio);
-	}
+	if (IS_ERR(imx214->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(imx214->enable_gpio),
+				     "failed to get enable gpio\n");
 
-	imx214->regmap = devm_regmap_init_i2c(client, &sensor_regmap_config);
-	if (IS_ERR(imx214->regmap)) {
-		dev_err(dev, "regmap init failed\n");
-		return PTR_ERR(imx214->regmap);
-	}
+	imx214->regmap = devm_cci_regmap_init_i2c(client, 16);
+	if (IS_ERR(imx214->regmap))
+		return dev_err_probe(dev, PTR_ERR(imx214->regmap),
+				     "failed to initialize CCI\n");
 
 	v4l2_i2c_subdev_init(&imx214->sd, client, &imx214_subdev_ops);
 	imx214->sd.internal_ops = &imx214_internal_ops;
@@ -1079,9 +1046,6 @@ static int imx214_probe(struct i2c_client *client)
 	if (ret < 0)
 		goto error_power_off;
 
-	mutex_init(&imx214->mutex);
-	imx214->ctrls.lock = &imx214->mutex;
-
 	imx214->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	imx214->pad.flags = MEDIA_PAD_FL_SOURCE;
 	imx214->sd.dev = &client->dev;
@@ -1089,32 +1053,40 @@ static int imx214_probe(struct i2c_client *client)
 
 	ret = media_entity_pads_init(&imx214->sd.entity, 1, &imx214->pad);
 	if (ret < 0) {
-		dev_err(dev, "could not register media entity\n");
+		dev_err_probe(dev, ret, "failed to init entity pads\n");
 		goto free_ctrl;
 	}
 
-	imx214_entity_init_state(&imx214->sd, NULL);
+	imx214->sd.state_lock = imx214->ctrls.lock;
+	ret = v4l2_subdev_init_finalize(&imx214->sd);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "subdev init error\n");
+		goto free_entity;
+	}
 
 	pm_runtime_set_active(imx214->dev);
 	pm_runtime_enable(imx214->dev);
 
 	ret = v4l2_async_register_subdev_sensor(&imx214->sd);
 	if (ret < 0) {
-		dev_err(dev, "could not register v4l2 device\n");
-		goto free_entity;
+		dev_err_probe(dev, ret,
+			      "failed to register sensor sub-device\n");
+		goto error_subdev_cleanup;
 	}
 
 	pm_runtime_idle(imx214->dev);
 
 	return 0;
 
-free_entity:
+error_subdev_cleanup:
 	pm_runtime_disable(imx214->dev);
 	pm_runtime_set_suspended(&client->dev);
+	v4l2_subdev_cleanup(&imx214->sd);
+
+free_entity:
 	media_entity_cleanup(&imx214->sd.entity);
 
 free_ctrl:
-	mutex_destroy(&imx214->mutex);
 	v4l2_ctrl_handler_free(&imx214->ctrls);
 
 error_power_off:
@@ -1129,9 +1101,9 @@ static void imx214_remove(struct i2c_client *client)
 	struct imx214 *imx214 = to_imx214(sd);
 
 	v4l2_async_unregister_subdev(&imx214->sd);
+	v4l2_subdev_cleanup(sd);
 	media_entity_cleanup(&imx214->sd.entity);
 	v4l2_ctrl_handler_free(&imx214->ctrls);
-	mutex_destroy(&imx214->mutex);
 	pm_runtime_disable(&client->dev);
 	if (!pm_runtime_status_suspended(&client->dev)) {
 		imx214_power_off(imx214->dev);
diff --git a/drivers/media/i2c/ov08x40.c b/drivers/media/i2c/ov08x40.c
index 67b86dabc67e..1fe8e9b584f8 100644
--- a/drivers/media/i2c/ov08x40.c
+++ b/drivers/media/i2c/ov08x40.c
@@ -1869,6 +1869,32 @@ static int ov08x40_stop_streaming(struct ov08x40 *ov08x)
 				 OV08X40_REG_VALUE_08BIT, OV08X40_MODE_STANDBY);
 }
 
+/* Verify chip ID */
+static int ov08x40_identify_module(struct ov08x40 *ov08x)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&ov08x->sd);
+	int ret;
+	u32 val;
+
+	if (ov08x->identified)
+		return 0;
+
+	ret = ov08x40_read_reg(ov08x, OV08X40_REG_CHIP_ID,
+			       OV08X40_REG_VALUE_24BIT, &val);
+	if (ret)
+		return ret;
+
+	if (val != OV08X40_CHIP_ID) {
+		dev_err(&client->dev, "chip id mismatch: %x!=%x\n",
+			OV08X40_CHIP_ID, val);
+		return -ENXIO;
+	}
+
+	ov08x->identified = true;
+
+	return 0;
+}
+
 static int ov08x40_set_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct ov08x40 *ov08x = to_ov08x40(sd);
@@ -1882,6 +1908,10 @@ static int ov08x40_set_stream(struct v4l2_subdev *sd, int enable)
 		if (ret < 0)
 			goto err_unlock;
 
+		ret = ov08x40_identify_module(ov08x);
+		if (ret)
+			goto err_rpm_put;
+
 		/*
 		 * Apply default & customized values
 		 * and then start streaming.
@@ -1906,32 +1936,6 @@ static int ov08x40_set_stream(struct v4l2_subdev *sd, int enable)
 	return ret;
 }
 
-/* Verify chip ID */
-static int ov08x40_identify_module(struct ov08x40 *ov08x)
-{
-	struct i2c_client *client = v4l2_get_subdevdata(&ov08x->sd);
-	int ret;
-	u32 val;
-
-	if (ov08x->identified)
-		return 0;
-
-	ret = ov08x40_read_reg(ov08x, OV08X40_REG_CHIP_ID,
-			       OV08X40_REG_VALUE_24BIT, &val);
-	if (ret)
-		return ret;
-
-	if (val != OV08X40_CHIP_ID) {
-		dev_err(&client->dev, "chip id mismatch: %x!=%x\n",
-			OV08X40_CHIP_ID, val);
-		return -ENXIO;
-	}
-
-	ov08x->identified = true;
-
-	return 0;
-}
-
 static const struct v4l2_subdev_video_ops ov08x40_video_ops = {
 	.s_stream = ov08x40_set_stream,
 };
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 5b861dbff27e..6c24426104ba 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -28,6 +28,13 @@ static const unsigned long rodata = 0xAA55AA55;
 /* This is marked __ro_after_init, so it should ultimately be .rodata. */
 static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
 
+/*
+ * This is a pointer to do_nothing() which is initialized at runtime rather
+ * than build time to avoid objtool IBT validation warnings caused by an
+ * inlined unrolled memcpy() in execute_location().
+ */
+static void __ro_after_init *do_nothing_ptr;
+
 /*
  * This just returns to the caller. It is designed to be copied into
  * non-executable memory regions.
@@ -65,13 +72,12 @@ static noinline __nocfi void execute_location(void *dst, bool write)
 {
 	void (*func)(void);
 	func_desc_t fdesc;
-	void *do_nothing_text = dereference_function_descriptor(do_nothing);
 
-	pr_info("attempting ok execution at %px\n", do_nothing_text);
+	pr_info("attempting ok execution at %px\n", do_nothing_ptr);
 	do_nothing();
 
 	if (write == CODE_WRITE) {
-		memcpy(dst, do_nothing_text, EXEC_SIZE);
+		memcpy(dst, do_nothing_ptr, EXEC_SIZE);
 		flush_icache_range((unsigned long)dst,
 				   (unsigned long)dst + EXEC_SIZE);
 	}
@@ -267,6 +273,8 @@ static void lkdtm_ACCESS_NULL(void)
 
 void __init lkdtm_perms_init(void)
 {
+	do_nothing_ptr = dereference_function_descriptor(do_nothing);
+
 	/* Make sure we can write to __ro_after_init values during __init */
 	ro_after_init |= 0xAA;
 }
diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
index 3c1359d8d4e6..55b892f982e9 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
@@ -37,6 +37,7 @@
 struct pci1xxxx_gpio {
 	struct auxiliary_device *aux_dev;
 	void __iomem *reg_base;
+	raw_spinlock_t wa_lock;
 	struct gpio_chip gpio;
 	spinlock_t lock;
 	int irq_base;
@@ -164,7 +165,7 @@ static void pci1xxxx_gpio_irq_ack(struct irq_data *data)
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->lock, flags);
-	pci1xxx_assign_bit(priv->reg_base, INTR_STAT_OFFSET(gpio), (gpio % 32), true);
+	writel(BIT(gpio % 32), priv->reg_base + INTR_STAT_OFFSET(gpio));
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
@@ -254,6 +255,7 @@ static irqreturn_t pci1xxxx_gpio_irq_handler(int irq, void *dev_id)
 	struct pci1xxxx_gpio *priv = dev_id;
 	struct gpio_chip *gc =  &priv->gpio;
 	unsigned long int_status = 0;
+	unsigned long wa_flags;
 	unsigned long flags;
 	u8 pincount;
 	int bit;
@@ -277,7 +279,9 @@ static irqreturn_t pci1xxxx_gpio_irq_handler(int irq, void *dev_id)
 			writel(BIT(bit), priv->reg_base + INTR_STATUS_OFFSET(gpiobank));
 			spin_unlock_irqrestore(&priv->lock, flags);
 			irq = irq_find_mapping(gc->irq.domain, (bit + (gpiobank * 32)));
-			handle_nested_irq(irq);
+			raw_spin_lock_irqsave(&priv->wa_lock, wa_flags);
+			generic_handle_irq(irq);
+			raw_spin_unlock_irqrestore(&priv->wa_lock, wa_flags);
 		}
 	}
 	spin_lock_irqsave(&priv->lock, flags);
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index a5f88ec97df7..bc40b940ae21 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -117,6 +117,7 @@
 
 #define MEI_DEV_ID_LNL_M      0xA870  /* Lunar Lake Point M */
 
+#define MEI_DEV_ID_PTL_H      0xE370  /* Panther Lake H */
 #define MEI_DEV_ID_PTL_P      0xE470  /* Panther Lake P */
 
 /*
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index d6ff9d82ae94..3f9c60b579ae 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -124,6 +124,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_LNL_M, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_H, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_P, MEI_ME_PCH15_CFG)},
 
 	/* required last entry */
diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index ef0a9f423c8f..eb51fbe8d92f 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -36,20 +36,24 @@
 #define VSC_TP_XFER_TIMEOUT_BYTES		700
 #define VSC_TP_PACKET_PADDING_SIZE		1
 #define VSC_TP_PACKET_SIZE(pkt) \
-	(sizeof(struct vsc_tp_packet) + le16_to_cpu((pkt)->len) + VSC_TP_CRC_SIZE)
+	(sizeof(struct vsc_tp_packet_hdr) + le16_to_cpu((pkt)->hdr.len) + VSC_TP_CRC_SIZE)
 #define VSC_TP_MAX_PACKET_SIZE \
-	(sizeof(struct vsc_tp_packet) + VSC_TP_MAX_MSG_SIZE + VSC_TP_CRC_SIZE)
+	(sizeof(struct vsc_tp_packet_hdr) + VSC_TP_MAX_MSG_SIZE + VSC_TP_CRC_SIZE)
 #define VSC_TP_MAX_XFER_SIZE \
 	(VSC_TP_MAX_PACKET_SIZE + VSC_TP_XFER_TIMEOUT_BYTES)
 #define VSC_TP_NEXT_XFER_LEN(len, offset) \
-	(len + sizeof(struct vsc_tp_packet) + VSC_TP_CRC_SIZE - offset + VSC_TP_PACKET_PADDING_SIZE)
+	(len + sizeof(struct vsc_tp_packet_hdr) + VSC_TP_CRC_SIZE - offset + VSC_TP_PACKET_PADDING_SIZE)
 
-struct vsc_tp_packet {
+struct vsc_tp_packet_hdr {
 	__u8 sync;
 	__u8 cmd;
 	__le16 len;
 	__le32 seq;
-	__u8 buf[] __counted_by(len);
+};
+
+struct vsc_tp_packet {
+	struct vsc_tp_packet_hdr hdr;
+	__u8 buf[VSC_TP_MAX_XFER_SIZE - sizeof(struct vsc_tp_packet_hdr)];
 };
 
 struct vsc_tp {
@@ -158,12 +162,12 @@ static int vsc_tp_dev_xfer(struct vsc_tp *tp, void *obuf, void *ibuf, size_t len
 static int vsc_tp_xfer_helper(struct vsc_tp *tp, struct vsc_tp_packet *pkt,
 			      void *ibuf, u16 ilen)
 {
-	int ret, offset = 0, cpy_len, src_len, dst_len = sizeof(struct vsc_tp_packet);
+	int ret, offset = 0, cpy_len, src_len, dst_len = sizeof(struct vsc_tp_packet_hdr);
 	int next_xfer_len = VSC_TP_PACKET_SIZE(pkt) + VSC_TP_XFER_TIMEOUT_BYTES;
 	u8 *src, *crc_src, *rx_buf = tp->rx_buf;
 	int count_down = VSC_TP_MAX_XFER_COUNT;
 	u32 recv_crc = 0, crc = ~0;
-	struct vsc_tp_packet ack;
+	struct vsc_tp_packet_hdr ack;
 	u8 *dst = (u8 *)&ack;
 	bool synced = false;
 
@@ -280,10 +284,10 @@ int vsc_tp_xfer(struct vsc_tp *tp, u8 cmd, const void *obuf, size_t olen,
 
 	guard(mutex)(&tp->mutex);
 
-	pkt->sync = VSC_TP_PACKET_SYNC;
-	pkt->cmd = cmd;
-	pkt->len = cpu_to_le16(olen);
-	pkt->seq = cpu_to_le32(++tp->seq);
+	pkt->hdr.sync = VSC_TP_PACKET_SYNC;
+	pkt->hdr.cmd = cmd;
+	pkt->hdr.len = cpu_to_le16(olen);
+	pkt->hdr.seq = cpu_to_le32(++tp->seq);
 	memcpy(pkt->buf, obuf, olen);
 
 	crc = ~crc32(~0, (u8 *)pkt, sizeof(pkt) + olen);
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 945d08531de3..82808cc373f6 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1866,7 +1866,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	if (!(cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS))
 		return 0;
 
-	ice = of_qcom_ice_get(dev);
+	ice = devm_of_qcom_ice_get(dev);
 	if (ice == ERR_PTR(-EOPNOTSUPP)) {
 		dev_warn(dev, "Disabling inline encryption support\n");
 		ice = NULL;
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index abc979fbb45d..93bf085a61d3 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2540,6 +2540,9 @@ mt7531_setup_common(struct dsa_switch *ds)
 	struct mt7530_priv *priv = ds->priv;
 	int ret, i;
 
+	ds->assisted_learning_on_cpu_port = true;
+	ds->mtu_enforcement_ingress = true;
+
 	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
@@ -2687,9 +2690,6 @@ mt7531_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
-	ds->assisted_learning_on_cpu_port = true;
-	ds->mtu_enforcement_ingress = true;
-
 	return 0;
 }
 
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index df1df6015412..211c219dd52d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5186,6 +5186,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -5210,8 +5211,10 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
-	.vtu_getnext = mv88e6185_g1_vtu_getnext,
-	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.vtu_getnext = mv88e6352_g1_vtu_getnext,
+	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5236,6 +5239,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -5259,8 +5263,10 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
-	.vtu_getnext = mv88e6185_g1_vtu_getnext,
-	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.vtu_getnext = mv88e6352_g1_vtu_getnext,
+	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5852,7 +5858,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
@@ -6182,8 +6188,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 2,
-		.internal_phys_offset = 3,
+		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,
@@ -6257,6 +6262,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
@@ -6282,6 +6288,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
@@ -6290,6 +6297,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.g1_irqs = 8,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
@@ -6312,7 +6320,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
@@ -6377,8 +6385,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 2,
-		.internal_phys_offset = 3,
+		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,
diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index c83a0a80d533..506f682d15c1 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -5,11 +5,6 @@
 
 #include "core.h"
 
-struct pdsc_wait_context {
-	struct pdsc_qcq *qcq;
-	struct completion wait_completion;
-};
-
 static int pdsc_process_notifyq(struct pdsc_qcq *qcq)
 {
 	union pds_core_notifyq_comp *comp;
@@ -109,10 +104,10 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 		q_info = &q->info[q->tail_idx];
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
 
-		/* Copy out the completion data */
-		memcpy(q_info->dest, comp, sizeof(*comp));
-
-		complete_all(&q_info->wc->wait_completion);
+		if (!completion_done(&q_info->completion)) {
+			memcpy(q_info->dest, comp, sizeof(*comp));
+			complete(&q_info->completion);
+		}
 
 		if (cq->tail_idx == cq->num_descs - 1)
 			cq->done_color = !cq->done_color;
@@ -162,8 +157,7 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 static int __pdsc_adminq_post(struct pdsc *pdsc,
 			      struct pdsc_qcq *qcq,
 			      union pds_core_adminq_cmd *cmd,
-			      union pds_core_adminq_comp *comp,
-			      struct pdsc_wait_context *wc)
+			      union pds_core_adminq_comp *comp)
 {
 	struct pdsc_queue *q = &qcq->q;
 	struct pdsc_q_info *q_info;
@@ -205,9 +199,9 @@ static int __pdsc_adminq_post(struct pdsc *pdsc,
 	/* Post the request */
 	index = q->head_idx;
 	q_info = &q->info[index];
-	q_info->wc = wc;
 	q_info->dest = comp;
 	memcpy(q_info->desc, cmd, sizeof(*cmd));
+	reinit_completion(&q_info->completion);
 
 	dev_dbg(pdsc->dev, "head_idx %d tail_idx %d\n",
 		q->head_idx, q->tail_idx);
@@ -231,16 +225,13 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 		     union pds_core_adminq_comp *comp,
 		     bool fast_poll)
 {
-	struct pdsc_wait_context wc = {
-		.wait_completion =
-			COMPLETION_INITIALIZER_ONSTACK(wc.wait_completion),
-	};
 	unsigned long poll_interval = 1;
 	unsigned long poll_jiffies;
 	unsigned long time_limit;
 	unsigned long time_start;
 	unsigned long time_done;
 	unsigned long remaining;
+	struct completion *wc;
 	int err = 0;
 	int index;
 
@@ -250,20 +241,19 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 		return -ENXIO;
 	}
 
-	wc.qcq = &pdsc->adminqcq;
-	index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp, &wc);
+	index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp);
 	if (index < 0) {
 		err = index;
 		goto err_out;
 	}
 
+	wc = &pdsc->adminqcq.q.info[index].completion;
 	time_start = jiffies;
 	time_limit = time_start + HZ * pdsc->devcmd_timeout;
 	do {
 		/* Timeslice the actual wait to catch IO errors etc early */
 		poll_jiffies = msecs_to_jiffies(poll_interval);
-		remaining = wait_for_completion_timeout(&wc.wait_completion,
-							poll_jiffies);
+		remaining = wait_for_completion_timeout(wc, poll_jiffies);
 		if (remaining)
 			break;
 
@@ -292,9 +282,11 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 	dev_dbg(pdsc->dev, "%s: elapsed %d msecs\n",
 		__func__, jiffies_to_msecs(time_done - time_start));
 
-	/* Check the results */
-	if (time_after_eq(time_done, time_limit))
+	/* Check the results and clear an un-completed timeout */
+	if (time_after_eq(time_done, time_limit) && !completion_done(wc)) {
 		err = -ETIMEDOUT;
+		complete(wc);
+	}
 
 	dev_dbg(pdsc->dev, "read admin queue completion idx %d:\n", index);
 	dynamic_hex_dump("comp ", DUMP_PREFIX_OFFSET, 16, 1,
diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 2babea110991..b76a9b7e0aed 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -107,9 +107,6 @@ int pds_client_adminq_cmd(struct pds_auxiliary_dev *padev,
 	dev_dbg(pf->dev, "%s: %s opcode %d\n",
 		__func__, dev_name(&padev->aux_dev.dev), req->opcode);
 
-	if (pf->state)
-		return -ENXIO;
-
 	/* Wrap the client's request */
 	cmd.client_request.opcode = PDS_AQ_CMD_CLIENT_CMD;
 	cmd.client_request.client_id = cpu_to_le16(padev->client_id);
diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 536635e57727..3c60d4cf9d0e 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -167,8 +167,10 @@ static void pdsc_q_map(struct pdsc_queue *q, void *base, dma_addr_t base_pa)
 	q->base = base;
 	q->base_pa = base_pa;
 
-	for (i = 0, cur = q->info; i < q->num_descs; i++, cur++)
+	for (i = 0, cur = q->info; i < q->num_descs; i++, cur++) {
 		cur->desc = base + (i * q->desc_size);
+		init_completion(&cur->completion);
+	}
 }
 
 static void pdsc_cq_map(struct pdsc_cq *cq, void *base, dma_addr_t base_pa)
@@ -325,10 +327,7 @@ static int pdsc_core_init(struct pdsc *pdsc)
 	size_t sz;
 	int err;
 
-	/* Scale the descriptor ring length based on number of CPUs and VFs */
-	numdescs = max_t(int, PDSC_ADMINQ_MIN_LENGTH, num_online_cpus());
-	numdescs += 2 * pci_sriov_get_totalvfs(pdsc->pdev);
-	numdescs = roundup_pow_of_two(numdescs);
+	numdescs = PDSC_ADMINQ_MAX_LENGTH;
 	err = pdsc_qcq_alloc(pdsc, PDS_CORE_QTYPE_ADMINQ, 0, "adminq",
 			     PDS_CORE_QCQ_F_CORE | PDS_CORE_QCQ_F_INTR,
 			     numdescs,
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 14522d6d5f86..ec637dc4327a 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -16,7 +16,7 @@
 
 #define PDSC_WATCHDOG_SECS	5
 #define PDSC_QUEUE_NAME_MAX_SZ  16
-#define PDSC_ADMINQ_MIN_LENGTH	16	/* must be a power of two */
+#define PDSC_ADMINQ_MAX_LENGTH	16	/* must be a power of two */
 #define PDSC_NOTIFYQ_LENGTH	64	/* must be a power of two */
 #define PDSC_TEARDOWN_RECOVERY	false
 #define PDSC_TEARDOWN_REMOVING	true
@@ -96,7 +96,7 @@ struct pdsc_q_info {
 	unsigned int bytes;
 	unsigned int nbufs;
 	struct pdsc_buf_info bufs[PDS_CORE_MAX_FRAGS];
-	struct pdsc_wait_context *wc;
+	struct completion completion;
 	void *dest;
 };
 
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 44971e71991f..ca23cde385e6 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -102,7 +102,7 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 		.fw_control.opcode = PDS_CORE_CMD_FW_CONTROL,
 		.fw_control.oper = PDS_CORE_FW_GET_LIST,
 	};
-	struct pds_core_fw_list_info fw_list;
+	struct pds_core_fw_list_info fw_list = {};
 	struct pdsc *pdsc = devlink_priv(dl);
 	union pds_core_dev_comp comp;
 	char buf[32];
@@ -115,8 +115,6 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 	if (!err)
 		memcpy_fromio(&fw_list, pdsc->cmd_regs->data, sizeof(fw_list));
 	mutex_unlock(&pdsc->devcmd_lock);
-	if (err && err != -EIO)
-		return err;
 
 	listlen = min(fw_list.num_fw_slots, ARRAY_SIZE(fw_list.fw_names));
 	for (i = 0; i < listlen; i++) {
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index d408dcda76d7..223aee1af443 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3997,11 +3997,27 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 	mtk_w32(eth, 0x21021000, MTK_FE_INT_GRP);
 
 	if (mtk_is_netsys_v3_or_greater(eth)) {
-		/* PSE should not drop port1, port8 and port9 packets */
-		mtk_w32(eth, 0x00000302, PSE_DROP_CFG);
+		/* PSE dummy page mechanism */
+		mtk_w32(eth, PSE_DUMMY_WORK_GDM(1) | PSE_DUMMY_WORK_GDM(2) |
+			PSE_DUMMY_WORK_GDM(3) | DUMMY_PAGE_THR, PSE_DUMY_REQ);
+
+		/* PSE free buffer drop threshold */
+		mtk_w32(eth, 0x00600009, PSE_IQ_REV(8));
+
+		/* PSE should not drop port8, port9 and port13 packets from
+		 * WDMA Tx
+		 */
+		mtk_w32(eth, 0x00002300, PSE_DROP_CFG);
+
+		/* PSE should drop packets to port8, port9 and port13 on WDMA Rx
+		 * ring full
+		 */
+		mtk_w32(eth, 0x00002300, PSE_PPE_DROP(0));
+		mtk_w32(eth, 0x00002300, PSE_PPE_DROP(1));
+		mtk_w32(eth, 0x00002300, PSE_PPE_DROP(2));
 
 		/* GDM and CDM Threshold */
-		mtk_w32(eth, 0x00000707, MTK_CDMW0_THRES);
+		mtk_w32(eth, 0x08000707, MTK_CDMW0_THRES);
 		mtk_w32(eth, 0x00000077, MTK_CDMW1_THRES);
 
 		/* Disable GDM1 RX CRC stripping */
@@ -4018,7 +4034,7 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 		mtk_w32(eth, 0x00000300, PSE_DROP_CFG);
 
 		/* PSE should drop packets to port 8/9 on WDMA Rx ring full */
-		mtk_w32(eth, 0x00000300, PSE_PPE0_DROP);
+		mtk_w32(eth, 0x00000300, PSE_PPE_DROP(0));
 
 		/* PSE Free Queue Flow Control  */
 		mtk_w32(eth, 0x01fa01f4, PSE_FQFC_CFG2);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 8d7b6818d860..0570623e569d 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -151,7 +151,15 @@
 #define PSE_FQFC_CFG1		0x100
 #define PSE_FQFC_CFG2		0x104
 #define PSE_DROP_CFG		0x108
-#define PSE_PPE0_DROP		0x110
+#define PSE_PPE_DROP(x)		(0x110 + ((x) * 0x4))
+
+/* PSE Last FreeQ Page Request Control */
+#define PSE_DUMY_REQ		0x10C
+/* PSE_DUMY_REQ is not a typo but actually called like that also in
+ * MediaTek's datasheet
+ */
+#define PSE_DUMMY_WORK_GDM(x)	BIT(16 + (x))
+#define DUMMY_PAGE_THR		0x1
 
 /* PSE Input Queue Reservation Register*/
 #define PSE_IQ_REV(x)		(0x140 + (((x) - 1) << 2))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index 9f13cea16446..43b2216bc0a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -618,10 +618,6 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
 	bool use_l4_type;
 	int err;
 
-	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
-	if (!ttc)
-		return ERR_PTR(-ENOMEM);
-
 	switch (params->ns_type) {
 	case MLX5_FLOW_NAMESPACE_PORT_SEL:
 		use_l4_type = MLX5_CAP_GEN_2(dev, pcc_ifa2) &&
@@ -635,7 +631,16 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
+	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
+	if (!ttc)
+		return ERR_PTR(-ENOMEM);
+
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
+	if (!ns) {
+		kvfree(ttc);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	groups = use_l4_type ? &inner_ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
 			       &inner_ttc_groups[TTC_GROUPS_DEFAULT];
 
@@ -691,10 +696,6 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 	bool use_l4_type;
 	int err;
 
-	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
-	if (!ttc)
-		return ERR_PTR(-ENOMEM);
-
 	switch (params->ns_type) {
 	case MLX5_FLOW_NAMESPACE_PORT_SEL:
 		use_l4_type = MLX5_CAP_GEN_2(dev, pcc_ifa2) &&
@@ -708,7 +709,16 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
+	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
+	if (!ttc)
+		return ERR_PTR(-ENOMEM);
+
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
+	if (!ns) {
+		kvfree(ttc);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	groups = use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
 			       &ttc_groups[TTC_GROUPS_DEFAULT];
 
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 41a27ae58ced..f5449b73b9a7 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -9058,6 +9058,8 @@ static void niu_try_msix(struct niu *np, u8 *ldg_num_map)
 		msi_vec[i].entry = i;
 	}
 
+	pdev->dev_flags |= PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST;
+
 	num_irqs = pci_enable_msix_range(pdev, msi_vec, 1, num_irqs);
 	if (num_irqs < 0) {
 		np->flags &= ~NIU_FLAGS_MSIX;
diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index 691969a4910f..e3a5961dced9 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -37,47 +37,6 @@ static int lan88xx_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, LAN88XX_EXT_PAGE_ACCESS, page);
 }
 
-static int lan88xx_phy_config_intr(struct phy_device *phydev)
-{
-	int rc;
-
-	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
-		/* unmask all source and clear them before enable */
-		rc = phy_write(phydev, LAN88XX_INT_MASK, 0x7FFF);
-		rc = phy_read(phydev, LAN88XX_INT_STS);
-		rc = phy_write(phydev, LAN88XX_INT_MASK,
-			       LAN88XX_INT_MASK_MDINTPIN_EN_ |
-			       LAN88XX_INT_MASK_LINK_CHANGE_);
-	} else {
-		rc = phy_write(phydev, LAN88XX_INT_MASK, 0);
-		if (rc)
-			return rc;
-
-		/* Ack interrupts after they have been disabled */
-		rc = phy_read(phydev, LAN88XX_INT_STS);
-	}
-
-	return rc < 0 ? rc : 0;
-}
-
-static irqreturn_t lan88xx_handle_interrupt(struct phy_device *phydev)
-{
-	int irq_status;
-
-	irq_status = phy_read(phydev, LAN88XX_INT_STS);
-	if (irq_status < 0) {
-		phy_error(phydev);
-		return IRQ_NONE;
-	}
-
-	if (!(irq_status & LAN88XX_INT_STS_LINK_CHANGE_))
-		return IRQ_NONE;
-
-	phy_trigger_machine(phydev);
-
-	return IRQ_HANDLED;
-}
-
 static int lan88xx_suspend(struct phy_device *phydev)
 {
 	struct lan88xx_priv *priv = phydev->priv;
@@ -528,8 +487,9 @@ static struct phy_driver microchip_phy_driver[] = {
 	.config_aneg	= lan88xx_config_aneg,
 	.link_change_notify = lan88xx_link_change_notify,
 
-	.config_intr	= lan88xx_phy_config_intr,
-	.handle_interrupt = lan88xx_handle_interrupt,
+	/* Interrupt handling is broken, do not define related
+	 * functions to force polling.
+	 */
 
 	.suspend	= lan88xx_suspend,
 	.resume		= genphy_resume,
diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
index f550576eb9da..6f9d8da76c4d 100644
--- a/drivers/net/phy/phy_led_triggers.c
+++ b/drivers/net/phy/phy_led_triggers.c
@@ -91,9 +91,8 @@ int phy_led_triggers_register(struct phy_device *phy)
 	if (!phy->phy_num_led_triggers)
 		return 0;
 
-	phy->led_link_trigger = devm_kzalloc(&phy->mdio.dev,
-					     sizeof(*phy->led_link_trigger),
-					     GFP_KERNEL);
+	phy->led_link_trigger = kzalloc(sizeof(*phy->led_link_trigger),
+					GFP_KERNEL);
 	if (!phy->led_link_trigger) {
 		err = -ENOMEM;
 		goto out_clear;
@@ -103,10 +102,9 @@ int phy_led_triggers_register(struct phy_device *phy)
 	if (err)
 		goto out_free_link;
 
-	phy->phy_led_triggers = devm_kcalloc(&phy->mdio.dev,
-					    phy->phy_num_led_triggers,
-					    sizeof(struct phy_led_trigger),
-					    GFP_KERNEL);
+	phy->phy_led_triggers = kcalloc(phy->phy_num_led_triggers,
+					sizeof(struct phy_led_trigger),
+					GFP_KERNEL);
 	if (!phy->phy_led_triggers) {
 		err = -ENOMEM;
 		goto out_unreg_link;
@@ -127,11 +125,11 @@ int phy_led_triggers_register(struct phy_device *phy)
 out_unreg:
 	while (i--)
 		phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
-	devm_kfree(&phy->mdio.dev, phy->phy_led_triggers);
+	kfree(phy->phy_led_triggers);
 out_unreg_link:
 	phy_led_trigger_unregister(phy->led_link_trigger);
 out_free_link:
-	devm_kfree(&phy->mdio.dev, phy->led_link_trigger);
+	kfree(phy->led_link_trigger);
 	phy->led_link_trigger = NULL;
 out_clear:
 	phy->phy_num_led_triggers = 0;
@@ -145,8 +143,13 @@ void phy_led_triggers_unregister(struct phy_device *phy)
 
 	for (i = 0; i < phy->phy_num_led_triggers; i++)
 		phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
+	kfree(phy->phy_led_triggers);
+	phy->phy_led_triggers = NULL;
 
-	if (phy->led_link_trigger)
+	if (phy->led_link_trigger) {
 		phy_led_trigger_unregister(phy->led_link_trigger);
+		kfree(phy->led_link_trigger);
+		phy->led_link_trigger = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(phy_led_triggers_unregister);
diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet3_xdp.c
index 616ecc38d172..5f470499e600 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.c
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
@@ -397,7 +397,7 @@ vmxnet3_process_xdp(struct vmxnet3_adapter *adapter,
 
 	xdp_init_buff(&xdp, PAGE_SIZE, &rq->xdp_rxq);
 	xdp_prepare_buff(&xdp, page_address(page), rq->page_pool->p.offset,
-			 rbi->len, false);
+			 rcd->len, false);
 	xdp_buff_clear_frags_flag(&xdp);
 
 	xdp_prog = rcu_dereference(rq->adapter->xdp_bpf_prog);
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 63fe51d0e64d..809b407cece1 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -985,20 +985,27 @@ static u32 xennet_run_xdp(struct netfront_queue *queue, struct page *pdata,
 	act = bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_TX:
-		get_page(pdata);
 		xdpf = xdp_convert_buff_to_frame(xdp);
+		if (unlikely(!xdpf)) {
+			trace_xdp_exception(queue->info->netdev, prog, act);
+			break;
+		}
+		get_page(pdata);
 		err = xennet_xdp_xmit(queue->info->netdev, 1, &xdpf, 0);
-		if (unlikely(!err))
+		if (unlikely(err <= 0)) {
+			if (err < 0)
+				trace_xdp_exception(queue->info->netdev, prog, act);
 			xdp_return_frame_rx_napi(xdpf);
-		else if (unlikely(err < 0))
-			trace_xdp_exception(queue->info->netdev, prog, act);
+		}
 		break;
 	case XDP_REDIRECT:
 		get_page(pdata);
 		err = xdp_do_redirect(queue->info->netdev, xdp, prog);
 		*need_xdp_flush = true;
-		if (unlikely(err))
+		if (unlikely(err)) {
 			trace_xdp_exception(queue->info->netdev, prog, act);
+			xdp_return_buff(xdp);
+		}
 		break;
 	case XDP_PASS:
 	case XDP_DROP:
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index d687e8c2cc78..63ceed89b62e 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1318,6 +1318,7 @@ static const struct pci_device_id amd_ntb_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c0), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c3), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x155a), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ 0, }
 };
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 6fc9dfe82474..419de7038570 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1041,7 +1041,7 @@ static inline char *idt_get_mw_name(enum idt_mw_type mw_type)
 static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 				       unsigned char *mw_cnt)
 {
-	struct idt_mw_cfg mws[IDT_MAX_NR_MWS], *ret_mws;
+	struct idt_mw_cfg *mws;
 	const struct idt_ntb_bar *bars;
 	enum idt_mw_type mw_type;
 	unsigned char widx, bidx, en_cnt;
@@ -1049,6 +1049,11 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 	int aprt_size;
 	u32 data;
 
+	mws = devm_kcalloc(&ndev->ntb.pdev->dev, IDT_MAX_NR_MWS,
+			   sizeof(*mws), GFP_KERNEL);
+	if (!mws)
+		return ERR_PTR(-ENOMEM);
+
 	/* Retrieve the array of the BARs registers */
 	bars = portdata_tbl[port].bars;
 
@@ -1103,16 +1108,7 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 		}
 	}
 
-	/* Allocate memory for memory window descriptors */
-	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt, sizeof(*ret_mws),
-			       GFP_KERNEL);
-	if (!ret_mws)
-		return ERR_PTR(-ENOMEM);
-
-	/* Copy the info of detected memory windows */
-	memcpy(ret_mws, mws, (*mw_cnt)*sizeof(*ret_mws));
-
-	return ret_mws;
+	return mws;
 }
 
 /*
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9bdf6fc53697..f19410723b17 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4273,6 +4273,15 @@ static void nvme_scan_work(struct work_struct *work)
 			nvme_scan_ns_sequential(ctrl);
 	}
 	mutex_unlock(&ctrl->scan_lock);
+
+	/* Requeue if we have missed AENs */
+	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
+		nvme_queue_scan(ctrl);
+#ifdef CONFIG_NVME_MULTIPATH
+	else if (ctrl->ana_log_buf)
+		/* Re-read the ANA log page to not miss updates */
+		queue_work(nvme_wq, &ctrl->ana_work);
+#endif
 }
 
 /*
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f25582e4d88b..561dd08022c0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -427,7 +427,7 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
-		return NULL;
+		return false;
 
 	list_for_each_entry_srcu(ns, &head->list, siblings,
 				 srcu_read_lock_held(&head->srcu)) {
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 7318b736d414..ef8c5961e10c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1028,33 +1028,24 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	struct nvmet_fc_hostport *newhost, *match = NULL;
 	unsigned long flags;
 
+	/*
+	 * Caller holds a reference on tgtport.
+	 */
+
 	/* if LLDD not implemented, leave as NULL */
 	if (!hosthandle)
 		return NULL;
 
-	/*
-	 * take reference for what will be the newly allocated hostport if
-	 * we end up using a new allocation
-	 */
-	if (!nvmet_fc_tgtport_get(tgtport))
-		return ERR_PTR(-EINVAL);
-
 	spin_lock_irqsave(&tgtport->lock, flags);
 	match = nvmet_fc_match_hostport(tgtport, hosthandle);
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	if (match) {
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
+	if (match)
 		return match;
-	}
 
 	newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
-	if (!newhost) {
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
+	if (!newhost)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	spin_lock_irqsave(&tgtport->lock, flags);
 	match = nvmet_fc_match_hostport(tgtport, hosthandle);
@@ -1063,6 +1054,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		kfree(newhost);
 		newhost = match;
 	} else {
+		nvmet_fc_tgtport_get(tgtport);
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
 		INIT_LIST_HEAD(&newhost->host_list);
@@ -1097,7 +1089,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static bool
diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 5cf96776dd7d..7d935908b543 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -249,25 +249,22 @@ static int adjust_local_phandle_references(struct device_node *local_fixups,
  */
 int of_resolve_phandles(struct device_node *overlay)
 {
-	struct device_node *child, *local_fixups, *refnode;
-	struct device_node *tree_symbols, *overlay_fixups;
+	struct device_node *child, *refnode;
+	struct device_node *overlay_fixups;
+	struct device_node __free(device_node) *local_fixups = NULL;
 	struct property *prop;
 	const char *refpath;
 	phandle phandle, phandle_delta;
 	int err;
 
-	tree_symbols = NULL;
-
 	if (!overlay) {
 		pr_err("null overlay\n");
-		err = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	if (!of_node_check_flag(overlay, OF_DETACHED)) {
 		pr_err("overlay not detached\n");
-		err = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	phandle_delta = live_tree_max_phandle() + 1;
@@ -279,7 +276,7 @@ int of_resolve_phandles(struct device_node *overlay)
 
 	err = adjust_local_phandle_references(local_fixups, overlay, phandle_delta);
 	if (err)
-		goto out;
+		return err;
 
 	overlay_fixups = NULL;
 
@@ -288,16 +285,13 @@ int of_resolve_phandles(struct device_node *overlay)
 			overlay_fixups = child;
 	}
 
-	if (!overlay_fixups) {
-		err = 0;
-		goto out;
-	}
+	if (!overlay_fixups)
+		return 0;
 
-	tree_symbols = of_find_node_by_path("/__symbols__");
+	struct device_node __free(device_node) *tree_symbols = of_find_node_by_path("/__symbols__");
 	if (!tree_symbols) {
 		pr_err("no symbols in root of device tree.\n");
-		err = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	for_each_property_of_node(overlay_fixups, prop) {
@@ -311,14 +305,12 @@ int of_resolve_phandles(struct device_node *overlay)
 		if (err) {
 			pr_err("node label '%s' not found in live devicetree symbols table\n",
 			       prop->name);
-			goto out;
+			return err;
 		}
 
 		refnode = of_find_node_by_path(refpath);
-		if (!refnode) {
-			err = -ENOENT;
-			goto out;
-		}
+		if (!refnode)
+			return -ENOENT;
 
 		phandle = refnode->phandle;
 		of_node_put(refnode);
@@ -328,11 +320,8 @@ int of_resolve_phandles(struct device_node *overlay)
 			break;
 	}
 
-out:
 	if (err)
 		pr_err("overlay phandle fixup failed: %d\n", err);
-	of_node_put(tree_symbols);
-
 	return err;
 }
 EXPORT_SYMBOL_GPL(of_resolve_phandles);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 2f647cac4cae..8b8848788618 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -10,12 +10,12 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 
 #include "../pci.h"
 #include "msi.h"
 
 int pci_msi_enable = 1;
-int pci_msi_ignore_mask;
 
 /**
  * pci_msi_supported - check whether MSI may be enabled on a device
@@ -295,8 +295,7 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 	/* Lies, damned lies, and MSIs */
 	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
 		control |= PCI_MSI_FLAGS_MASKBIT;
-	/* Respect XEN's mask disabling */
-	if (pci_msi_ignore_mask)
+	if (pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY))
 		control &= ~PCI_MSI_FLAGS_MASKBIT;
 
 	desc.nvec_used			= nvec;
@@ -609,12 +608,16 @@ void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 	desc->pci.msi_attrib.is_64		= 1;
 	desc->pci.msi_attrib.default_irq	= dev->irq;
 	desc->pci.mask_base			= dev->msix_base;
-	desc->pci.msi_attrib.can_mask		= !pci_msi_ignore_mask &&
-						  !desc->pci.msi_attrib.is_virtual;
 
-	if (desc->pci.msi_attrib.can_mask) {
+
+	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY) &&
+	    !desc->pci.msi_attrib.is_virtual) {
 		void __iomem *addr = pci_msix_desc_addr(desc);
 
+		desc->pci.msi_attrib.can_mask = 1;
+		/* Workaround for SUN NIU insanity, which requires write before read */
+		if (dev->dev_flags & PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST)
+			writel(0, addr + PCI_MSIX_ENTRY_DATA);
 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 	}
 }
@@ -659,9 +662,6 @@ static void msix_mask_all(void __iomem *base, int tsize)
 	u32 ctrl = PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	int i;
 
-	if (pci_msi_ignore_mask)
-		return;
-
 	for (i = 0; i < tsize; i++, base += PCI_MSIX_ENTRY_SIZE)
 		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
@@ -744,15 +744,17 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
 
-	/*
-	 * Ensure that all table entries are masked to prevent
-	 * stale entries from firing in a crash kernel.
-	 *
-	 * Done late to deal with a broken Marvell NVME device
-	 * which takes the MSI-X mask bits into account even
-	 * when MSI-X is disabled, which prevents MSI delivery.
-	 */
-	msix_mask_all(dev->msix_base, tsize);
+	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY)) {
+		/*
+		 * Ensure that all table entries are masked to prevent
+		 * stale entries from firing in a crash kernel.
+		 *
+		 * Done late to deal with a broken Marvell NVME device
+		 * which takes the MSI-X mask bits into account even
+		 * when MSI-X is disabled, which prevents MSI delivery.
+		 */
+		msix_mask_all(dev->msix_base, tsize);
+	}
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 
 	pcibios_free_irq(dev);
diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 2c51e5c62d3e..f5c6d264d89e 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -1045,7 +1045,6 @@ static int rk_udphy_dp_phy_init(struct phy *phy)
 	mutex_lock(&udphy->mutex);
 
 	udphy->dp_in_use = true;
-	rk_udphy_dp_hpd_event_trigger(udphy, udphy->dp_sink_hpd_cfg);
 
 	mutex_unlock(&udphy->mutex);
 
diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index f384c72d9554..70d7485ada36 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -382,6 +382,7 @@ static irqreturn_t mcp23s08_irq(int irq, void *data)
 {
 	struct mcp23s08 *mcp = data;
 	int intcap, intcon, intf, i, gpio, gpio_orig, intcap_mask, defval, gpinten;
+	bool need_unmask = false;
 	unsigned long int enabled_interrupts;
 	unsigned int child_irq;
 	bool intf_set, intcap_changed, gpio_bit_changed,
@@ -396,9 +397,6 @@ static irqreturn_t mcp23s08_irq(int irq, void *data)
 		goto unlock;
 	}
 
-	if (mcp_read(mcp, MCP_INTCAP, &intcap))
-		goto unlock;
-
 	if (mcp_read(mcp, MCP_INTCON, &intcon))
 		goto unlock;
 
@@ -408,6 +406,16 @@ static irqreturn_t mcp23s08_irq(int irq, void *data)
 	if (mcp_read(mcp, MCP_DEFVAL, &defval))
 		goto unlock;
 
+	/* Mask level interrupts to avoid their immediate reactivation after clearing */
+	if (intcon) {
+		need_unmask = true;
+		if (mcp_write(mcp, MCP_GPINTEN, gpinten & ~intcon))
+			goto unlock;
+	}
+
+	if (mcp_read(mcp, MCP_INTCAP, &intcap))
+		goto unlock;
+
 	/* This clears the interrupt(configurable on S18) */
 	if (mcp_read(mcp, MCP_GPIO, &gpio))
 		goto unlock;
@@ -470,9 +478,18 @@ static irqreturn_t mcp23s08_irq(int irq, void *data)
 		}
 	}
 
+	if (need_unmask) {
+		mutex_lock(&mcp->lock);
+		goto unlock;
+	}
+
 	return IRQ_HANDLED;
 
 unlock:
+	if (need_unmask)
+		if (mcp_write(mcp, MCP_GPINTEN, gpinten))
+			dev_err(mcp->chip.parent, "can't unmask GPINTEN\n");
+
 	mutex_unlock(&mcp->lock);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index 773eaf508565..8369fab61758 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -243,6 +243,9 @@ static int rza2_gpio_register(struct rza2_pinctrl_priv *priv)
 	int ret;
 
 	chip.label = devm_kasprintf(priv->dev, GFP_KERNEL, "%pOFn", np);
+	if (!chip.label)
+		return -ENOMEM;
+
 	chip.parent = priv->dev;
 	chip.ngpio = priv->npins;
 
diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 37476d2558fd..72df554b6375 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -270,8 +270,8 @@ static const unsigned int rk817_buck1_4_ramp_table[] = {
 
 static int rk806_set_mode_dcdc(struct regulator_dev *rdev, unsigned int mode)
 {
-	int rid = rdev_get_id(rdev);
-	int ctr_bit, reg;
+	unsigned int rid = rdev_get_id(rdev);
+	unsigned int ctr_bit, reg;
 
 	reg = RK806_POWER_FPWM_EN0 + rid / 8;
 	ctr_bit = rid % 8;
diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 905986c61655..73848f764559 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -35,6 +35,7 @@
 #define PCF85063_REG_CTRL1_CAP_SEL	BIT(0)
 #define PCF85063_REG_CTRL1_STOP		BIT(5)
 #define PCF85063_REG_CTRL1_EXT_TEST	BIT(7)
+#define PCF85063_REG_CTRL1_SWR		0x58
 
 #define PCF85063_REG_CTRL2		0x01
 #define PCF85063_CTRL2_AF		BIT(6)
@@ -589,7 +590,7 @@ static int pcf85063_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, pcf85063);
 
-	err = regmap_read(pcf85063->regmap, PCF85063_REG_CTRL1, &tmp);
+	err = regmap_read(pcf85063->regmap, PCF85063_REG_SC, &tmp);
 	if (err) {
 		dev_err(&client->dev, "RTC chip is not present\n");
 		return err;
@@ -599,6 +600,22 @@ static int pcf85063_probe(struct i2c_client *client)
 	if (IS_ERR(pcf85063->rtc))
 		return PTR_ERR(pcf85063->rtc);
 
+	/*
+	 * If a Power loss is detected, SW reset the device.
+	 * From PCF85063A datasheet:
+	 * There is a low probability that some devices will have corruption
+	 * of the registers after the automatic power-on reset...
+	 */
+	if (tmp & PCF85063_REG_SC_OS) {
+		dev_warn(&client->dev,
+			 "POR issue detected, sending a SW reset\n");
+		err = regmap_write(pcf85063->regmap, PCF85063_REG_CTRL1,
+				   PCF85063_REG_CTRL1_SWR);
+		if (err < 0)
+			dev_warn(&client->dev,
+				 "SW reset failed, trying to continue\n");
+	}
+
 	err = pcf85063_load_capacitance(pcf85063, client->dev.of_node,
 					config->force_cap_7000 ? 7000 : 0);
 	if (err < 0)
diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index e5d947c763ea..6a030ba38bf3 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -263,6 +263,19 @@ static struct console sclp_console =
 	.index = 0 /* ttyS0 */
 };
 
+/*
+ *  Release allocated pages.
+ */
+static void __init __sclp_console_free_pages(void)
+{
+	struct list_head *page, *p;
+
+	list_for_each_safe(page, p, &sclp_con_pages) {
+		list_del(page);
+		free_page((unsigned long)page);
+	}
+}
+
 /*
  * called by console_init() in drivers/char/tty_io.c at boot-time.
  */
@@ -282,6 +295,10 @@ sclp_console_init(void)
 	/* Allocate pages for output buffering */
 	for (i = 0; i < sclp_console_pages; i++) {
 		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		if (!page) {
+			__sclp_console_free_pages();
+			return -ENOMEM;
+		}
 		list_add_tail(page, &sclp_con_pages);
 	}
 	sclp_conbuf = NULL;
diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 892c18d2f87e..d3edacb6ee14 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -490,6 +490,17 @@ static const struct tty_operations sclp_ops = {
 	.flush_buffer = sclp_tty_flush_buffer,
 };
 
+/* Release allocated pages. */
+static void __init __sclp_tty_free_pages(void)
+{
+	struct list_head *page, *p;
+
+	list_for_each_safe(page, p, &sclp_tty_pages) {
+		list_del(page);
+		free_page((unsigned long)page);
+	}
+}
+
 static int __init
 sclp_tty_init(void)
 {
@@ -516,6 +527,7 @@ sclp_tty_init(void)
 	for (i = 0; i < MAX_KMEM_PAGES; i++) {
 		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 		if (page == NULL) {
+			__sclp_tty_free_pages();
 			tty_driver_kref_put(driver);
 			return -ENOMEM;
 		}
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index ffd15fa4f9e5..e98e6b2b9f57 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -912,8 +912,28 @@ static void hisi_sas_phyup_work_common(struct work_struct *work,
 		container_of(work, typeof(*phy), works[event]);
 	struct hisi_hba *hisi_hba = phy->hisi_hba;
 	struct asd_sas_phy *sas_phy = &phy->sas_phy;
+	struct asd_sas_port *sas_port = sas_phy->port;
+	struct hisi_sas_port *port = phy->port;
+	struct device *dev = hisi_hba->dev;
+	struct domain_device *port_dev;
 	int phy_no = sas_phy->id;
 
+	if (!test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags) &&
+	    sas_port && port && (port->id != phy->port_id)) {
+		dev_info(dev, "phy%d's hw port id changed from %d to %llu\n",
+				phy_no, port->id, phy->port_id);
+		port_dev = sas_port->port_dev;
+		if (port_dev && !dev_is_expander(port_dev->dev_type)) {
+			/*
+			 * Set the device state to gone to block
+			 * sending IO to the device.
+			 */
+			set_bit(SAS_DEV_GONE, &port_dev->state);
+			hisi_sas_notify_phy_event(phy, HISI_PHYE_LINK_RESET);
+			return;
+		}
+	}
+
 	phy->wait_phyup_cnt = 0;
 	if (phy->identify.target_port_protocols == SAS_PROTOCOL_SSP)
 		hisi_hba->hw->sl_notify_ssp(hisi_hba, phy_no);
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index ec5b1ab28717..c0a372868e1d 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -563,7 +563,7 @@ int mpi3mr_process_op_reply_q(struct mpi3mr_ioc *mrioc,
 		WRITE_ONCE(op_req_q->ci, le16_to_cpu(reply_desc->request_queue_ci));
 		mpi3mr_process_op_reply_desc(mrioc, reply_desc, &reply_dma,
 		    reply_qidx);
-		atomic_dec(&op_reply_q->pend_ios);
+
 		if (reply_dma)
 			mpi3mr_repost_reply_buf(mrioc, reply_dma);
 		num_op_reply++;
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index ee2da8e49d4c..a9d6dac41334 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -719,6 +719,7 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
 			spin_lock_irqsave(&pm8001_ha->lock, flags);
 		}
 		PM8001_CHIP_DISP->dereg_dev_req(pm8001_ha, device_id);
+		pm8001_ha->phy[pm8001_dev->attached_phy].phy_attached = 0;
 		pm8001_free_dev(pm8001_dev);
 	} else {
 		pm8001_dbg(pm8001_ha, DISC, "Found dev has gone.\n");
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index a77e0499b738..9d2db5bc8ee7 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -695,26 +695,23 @@ void scsi_cdl_check(struct scsi_device *sdev)
  */
 int scsi_cdl_enable(struct scsi_device *sdev, bool enable)
 {
-	struct scsi_mode_data data;
-	struct scsi_sense_hdr sshdr;
-	struct scsi_vpd *vpd;
-	bool is_ata = false;
 	char buf[64];
+	bool is_ata;
 	int ret;
 
 	if (!sdev->cdl_supported)
 		return -EOPNOTSUPP;
 
 	rcu_read_lock();
-	vpd = rcu_dereference(sdev->vpd_pg89);
-	if (vpd)
-		is_ata = true;
+	is_ata = rcu_dereference(sdev->vpd_pg89);
 	rcu_read_unlock();
 
 	/*
 	 * For ATA devices, CDL needs to be enabled with a SET FEATURES command.
 	 */
 	if (is_ata) {
+		struct scsi_mode_data data;
+		struct scsi_sense_hdr sshdr;
 		char *buf_data;
 		int len;
 
@@ -723,16 +720,30 @@ int scsi_cdl_enable(struct scsi_device *sdev, bool enable)
 		if (ret)
 			return -EINVAL;
 
-		/* Enable CDL using the ATA feature page */
+		/* Enable or disable CDL using the ATA feature page */
 		len = min_t(size_t, sizeof(buf),
 			    data.length - data.header_length -
 			    data.block_descriptor_length);
 		buf_data = buf + data.header_length +
 			data.block_descriptor_length;
-		if (enable)
-			buf_data[4] = 0x02;
-		else
-			buf_data[4] = 0;
+
+		/*
+		 * If we want to enable CDL and CDL is already enabled on the
+		 * device, do nothing. This avoids needlessly resetting the CDL
+		 * statistics on the device as that is implied by the CDL enable
+		 * action. Similar to this, there is no need to do anything if
+		 * we want to disable CDL and CDL is already disabled.
+		 */
+		if (enable) {
+			if ((buf_data[4] & 0x03) == 0x02)
+				goto out;
+			buf_data[4] &= ~0x03;
+			buf_data[4] |= 0x02;
+		} else {
+			if ((buf_data[4] & 0x03) == 0x00)
+				goto out;
+			buf_data[4] &= ~0x03;
+		}
 
 		ret = scsi_mode_select(sdev, 1, 0, buf_data, len, 5 * HZ, 3,
 				       &data, &sshdr);
@@ -744,6 +755,7 @@ int scsi_cdl_enable(struct scsi_device *sdev, bool enable)
 		}
 	}
 
+out:
 	sdev->cdl_enable = enable;
 
 	return 0;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3023b07dc483..ce4b428b63f8 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1237,8 +1237,12 @@ EXPORT_SYMBOL_GPL(scsi_alloc_request);
  */
 static void scsi_cleanup_rq(struct request *rq)
 {
+	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
+
+	cmd->flags = 0;
+
 	if (rq->rq_flags & RQF_DONTPREP) {
-		scsi_mq_uninit_cmd(blk_mq_rq_to_pdu(rq));
+		scsi_mq_uninit_cmd(cmd);
 		rq->rq_flags &= ~RQF_DONTPREP;
 	}
 }
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ca4bc0ac76ad..8947dab132d7 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1190,8 +1190,8 @@ static u8 sd_group_number(struct scsi_cmnd *cmd)
 	if (!sdkp->rscs)
 		return 0;
 
-	return min3((u32)rq->write_hint, (u32)sdkp->permanent_stream_count,
-		    0x3fu);
+	return min3((u32)rq->bio->bi_write_hint,
+		    (u32)sdkp->permanent_stream_count, 0x3fu);
 }
 
 static blk_status_t sd_setup_rw32_cmnd(struct scsi_cmnd *cmd, bool write,
@@ -1389,7 +1389,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua, dld);
 	} else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
-		   sdp->use_10_for_rw || protect || rq->write_hint) {
+		   sdp->use_10_for_rw || protect || rq->bio->bi_write_hint) {
 		ret = sd_setup_rw10_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua);
 	} else {
diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 50be7a9274a1..9d89bfc50e8b 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -11,6 +11,7 @@
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -324,6 +325,53 @@ struct qcom_ice *of_qcom_ice_get(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(of_qcom_ice_get);
 
+static void qcom_ice_put(const struct qcom_ice *ice)
+{
+	struct platform_device *pdev = to_platform_device(ice->dev);
+
+	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"))
+		platform_device_put(pdev);
+}
+
+static void devm_of_qcom_ice_put(struct device *dev, void *res)
+{
+	qcom_ice_put(*(struct qcom_ice **)res);
+}
+
+/**
+ * devm_of_qcom_ice_get() - Devres managed helper to get an ICE instance from
+ * a DT node.
+ * @dev: device pointer for the consumer device.
+ *
+ * This function will provide an ICE instance either by creating one for the
+ * consumer device if its DT node provides the 'ice' reg range and the 'ice'
+ * clock (for legacy DT style). On the other hand, if consumer provides a
+ * phandle via 'qcom,ice' property to an ICE DT, the ICE instance will already
+ * be created and so this function will return that instead.
+ *
+ * Return: ICE pointer on success, NULL if there is no ICE data provided by the
+ * consumer or ERR_PTR() on error.
+ */
+struct qcom_ice *devm_of_qcom_ice_get(struct device *dev)
+{
+	struct qcom_ice *ice, **dr;
+
+	dr = devres_alloc(devm_of_qcom_ice_put, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	ice = of_qcom_ice_get(dev);
+	if (!IS_ERR_OR_NULL(ice)) {
+		*dr = ice;
+		devres_add(dev, dr);
+	} else {
+		devres_free(dr);
+	}
+
+	return ice;
+}
+EXPORT_SYMBOL_GPL(devm_of_qcom_ice_get);
+
 static int qcom_ice_probe(struct platform_device *pdev)
 {
 	struct qcom_ice *engine;
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 4c31d36f3130..810541eed213 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1614,10 +1614,13 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 				struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
+	int ret;
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
 	unsigned long hz_per_byte, byte_limit;
 
-	spi_imx_setupxfer(spi, transfer);
+	ret = spi_imx_setupxfer(spi, transfer);
+	if (ret < 0)
+		return ret;
 	transfer->effective_speed_hz = spi_imx->spi_bus_clk;
 
 	/* flush rxfifo before transfer */
diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 43f11b0e9e76..2d48ad844fb8 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1117,9 +1117,9 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					(&tqspi->xfer_completion,
 					QSPI_DMA_TIMEOUT);
 
-			if (WARN_ON(ret == 0)) {
-				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
-					ret);
+			if (WARN_ON_ONCE(ret == 0)) {
+				dev_err_ratelimited(tqspi->dev,
+						    "QSPI Transfer failed with timeout\n");
 				if (tqspi->is_curr_dma_xfer &&
 				    (tqspi->cur_direction & DATA_DIR_TX))
 					dmaengine_terminate_all
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index a7c6919fbf97..e1da433a9e7f 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1295,11 +1295,15 @@ static void tb_scan_port(struct tb_port *port)
 		goto out_rpm_put;
 	}
 
-	tb_retimer_scan(port, true);
-
 	sw = tb_switch_alloc(port->sw->tb, &port->sw->dev,
 			     tb_downstream_route(port));
 	if (IS_ERR(sw)) {
+		/*
+		 * Make the downstream retimers available even if there
+		 * is no router connected.
+		 */
+		tb_retimer_scan(port, true);
+
 		/*
 		 * If there is an error accessing the connected switch
 		 * it may be connected to another domain. Also we allow
@@ -1349,6 +1353,14 @@ static void tb_scan_port(struct tb_port *port)
 	upstream_port = tb_upstream_port(sw);
 	tb_configure_link(port, upstream_port, sw);
 
+	/*
+	 * Scan for downstream retimers. We only scan them after the
+	 * router has been enumerated to avoid issues with certain
+	 * Pluggable devices that expect the host to enumerate them
+	 * within certain timeout.
+	 */
+	tb_retimer_scan(port, true);
+
 	/*
 	 * CL0s and CL1 are enabled and supported together.
 	 * Silently ignore CLx enabling in case CLx is not supported.
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 0a9c5219df88..9eeabedfb4d0 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1746,6 +1746,12 @@ msm_serial_early_console_setup_dm(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
+	/* Disable DM / single-character modes */
+	msm_write(&device->port, 0, UARTDM_DMEN);
+	msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART_CR);
+	msm_write(&device->port, MSM_UART_CR_CMD_RESET_TX, MSM_UART_CR);
+	msm_write(&device->port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
+
 	device->con->write = msm_serial_early_write_dm;
 	return 0;
 }
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index cbfce65c9d22..7fbb170cf0f4 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -563,8 +563,11 @@ static void sifive_serial_break_ctl(struct uart_port *port, int break_state)
 static int sifive_serial_startup(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_enable_rxwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 
 	return 0;
 }
@@ -572,9 +575,12 @@ static int sifive_serial_startup(struct uart_port *port)
 static void sifive_serial_shutdown(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_disable_rxwm(ssp);
 	__ssp_disable_txwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 }
 
 /**
diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 0bd6544e30a6..791e2f1f7c0b 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -193,13 +193,12 @@ int set_selection_user(const struct tiocl_selection __user *sel,
 		return -EFAULT;
 
 	/*
-	 * TIOCL_SELCLEAR, TIOCL_SELPOINTER and TIOCL_SELMOUSEREPORT are OK to
-	 * use without CAP_SYS_ADMIN as they do not modify the selection.
+	 * TIOCL_SELCLEAR and TIOCL_SELPOINTER are OK to use without
+	 * CAP_SYS_ADMIN as they do not modify the selection.
 	 */
 	switch (v.sel_mode) {
 	case TIOCL_SELCLEAR:
 	case TIOCL_SELPOINTER:
-	case TIOCL_SELMOUSEREPORT:
 		break;
 	default:
 		if (!capable(CAP_SYS_ADMIN))
diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index dba935c712d6..45b04f3c3776 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -673,13 +673,6 @@ int ufshcd_mcq_abort(struct scsi_cmnd *cmd)
 	unsigned long flags;
 	int err;
 
-	if (!ufshcd_cmd_inflight(lrbp->cmd)) {
-		dev_err(hba->dev,
-			"%s: skip abort. cmd at tag %d already completed.\n",
-			__func__, tag);
-		return FAILED;
-	}
-
 	/* Skip task abort in case previous aborts failed and report failure */
 	if (lrbp->req_abort_skip) {
 		dev_err(hba->dev, "%s: skip abort. tag %d failed earlier\n",
@@ -688,6 +681,11 @@ int ufshcd_mcq_abort(struct scsi_cmnd *cmd)
 	}
 
 	hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
+	if (!hwq) {
+		dev_err(hba->dev, "%s: skip abort. cmd at tag %d already completed.\n",
+			__func__, tag);
+		return FAILED;
+	}
 
 	if (ufshcd_mcq_sqe_search(hba, hwq, tag)) {
 		/*
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 89fc0b566291..8d4a5b8371b6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5689,6 +5689,8 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 			continue;
 
 		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
+		if (!hwq)
+			continue;
 
 		if (force_compl) {
 			ufshcd_mcq_compl_all_cqes_lock(hba, hwq);
diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index f2cbfc2d399c..5ba17ccf6417 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -34,7 +34,7 @@
  * Exynos's Vendor specific registers for UFSHCI
  */
 #define HCI_TXPRDT_ENTRY_SIZE	0x00
-#define PRDT_PREFECT_EN		BIT(31)
+#define PRDT_PREFETCH_EN	BIT(31)
 #define HCI_RXPRDT_ENTRY_SIZE	0x04
 #define HCI_1US_TO_CNT_VAL	0x0C
 #define CNT_VAL_1US_MASK	0x3FF
@@ -86,11 +86,16 @@
 				 UIC_TRANSPORT_NO_CONNECTION_RX |\
 				 UIC_TRANSPORT_BAD_TC)
 
-/* FSYS UFS Shareability */
-#define UFS_WR_SHARABLE		BIT(2)
-#define UFS_RD_SHARABLE		BIT(1)
-#define UFS_SHARABLE		(UFS_WR_SHARABLE | UFS_RD_SHARABLE)
-#define UFS_SHAREABILITY_OFFSET	0x710
+/* UFS Shareability */
+#define UFS_EXYNOSAUTO_WR_SHARABLE	BIT(2)
+#define UFS_EXYNOSAUTO_RD_SHARABLE	BIT(1)
+#define UFS_EXYNOSAUTO_SHARABLE		(UFS_EXYNOSAUTO_WR_SHARABLE | \
+					 UFS_EXYNOSAUTO_RD_SHARABLE)
+#define UFS_GS101_WR_SHARABLE		BIT(1)
+#define UFS_GS101_RD_SHARABLE		BIT(0)
+#define UFS_GS101_SHARABLE		(UFS_GS101_WR_SHARABLE | \
+					 UFS_GS101_RD_SHARABLE)
+#define UFS_SHAREABILITY_OFFSET		0x710
 
 /* Multi-host registers */
 #define MHCTRL			0xC4
@@ -198,20 +203,15 @@ static inline void exynos_ufs_ungate_clks(struct exynos_ufs *ufs)
 	exynos_ufs_ctrl_clkstop(ufs, false);
 }
 
-static int exynos7_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
-{
-	return 0;
-}
-
-static int exynosauto_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
+static int exynos_ufs_shareability(struct exynos_ufs *ufs)
 {
 	struct exynos_ufs_uic_attr *attr = ufs->drv_data->uic_attr;
 
 	/* IO Coherency setting */
 	if (ufs->sysreg) {
 		return regmap_update_bits(ufs->sysreg,
-					  ufs->shareability_reg_offset,
-					  UFS_SHARABLE, UFS_SHARABLE);
+					  ufs->iocc_offset,
+					  ufs->iocc_mask, ufs->iocc_val);
 	}
 
 	attr->tx_dif_p_nsec = 3200000;
@@ -219,6 +219,21 @@ static int exynosauto_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
 	return 0;
 }
 
+static int gs101_ufs_drv_init(struct exynos_ufs *ufs)
+{
+	struct ufs_hba *hba = ufs->hba;
+
+	/* Enable WriteBooster */
+	hba->caps |= UFSHCD_CAP_WB_EN;
+
+	return exynos_ufs_shareability(ufs);
+}
+
+static int exynosauto_ufs_drv_init(struct exynos_ufs *ufs)
+{
+	return exynos_ufs_shareability(ufs);
+}
+
 static int exynosauto_ufs_post_hce_enable(struct exynos_ufs *ufs)
 {
 	struct ufs_hba *hba = ufs->hba;
@@ -1013,9 +1028,14 @@ static int exynos_ufs_pre_link(struct ufs_hba *hba)
 	exynos_ufs_config_intr(ufs, DFES_DEF_L4_ERRS, UNIPRO_L4);
 	exynos_ufs_set_unipro_pclk_div(ufs);
 
+	exynos_ufs_setup_clocks(hba, true, PRE_CHANGE);
+
 	/* unipro */
 	exynos_ufs_config_unipro(ufs);
 
+	if (ufs->drv_data->pre_link)
+		ufs->drv_data->pre_link(ufs);
+
 	/* m-phy */
 	exynos_ufs_phy_init(ufs);
 	if (!(ufs->opts & EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR)) {
@@ -1023,11 +1043,6 @@ static int exynos_ufs_pre_link(struct ufs_hba *hba)
 		exynos_ufs_config_phy_cap_attr(ufs);
 	}
 
-	exynos_ufs_setup_clocks(hba, true, PRE_CHANGE);
-
-	if (ufs->drv_data->pre_link)
-		ufs->drv_data->pre_link(ufs);
-
 	return 0;
 }
 
@@ -1051,12 +1066,17 @@ static int exynos_ufs_post_link(struct ufs_hba *hba)
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 	struct phy *generic_phy = ufs->phy;
 	struct exynos_ufs_uic_attr *attr = ufs->drv_data->uic_attr;
+	u32 val = ilog2(DATA_UNIT_SIZE);
 
 	exynos_ufs_establish_connt(ufs);
 	exynos_ufs_fit_aggr_timeout(ufs);
 
 	hci_writel(ufs, 0xa, HCI_DATA_REORDER);
-	hci_writel(ufs, ilog2(DATA_UNIT_SIZE), HCI_TXPRDT_ENTRY_SIZE);
+
+	if (hba->caps & UFSHCD_CAP_CRYPTO)
+		val |= PRDT_PREFETCH_EN;
+	hci_writel(ufs, val, HCI_TXPRDT_ENTRY_SIZE);
+
 	hci_writel(ufs, ilog2(DATA_UNIT_SIZE), HCI_RXPRDT_ENTRY_SIZE);
 	hci_writel(ufs, (1 << hba->nutrs) - 1, HCI_UTRL_NEXUS_TYPE);
 	hci_writel(ufs, (1 << hba->nutmrs) - 1, HCI_UTMRL_NEXUS_TYPE);
@@ -1132,12 +1152,22 @@ static int exynos_ufs_parse_dt(struct device *dev, struct exynos_ufs *ufs)
 		ufs->sysreg = NULL;
 	else {
 		if (of_property_read_u32_index(np, "samsung,sysreg", 1,
-					       &ufs->shareability_reg_offset)) {
+					       &ufs->iocc_offset)) {
 			dev_warn(dev, "can't get an offset from sysreg. Set to default value\n");
-			ufs->shareability_reg_offset = UFS_SHAREABILITY_OFFSET;
+			ufs->iocc_offset = UFS_SHAREABILITY_OFFSET;
 		}
 	}
 
+	ufs->iocc_mask = ufs->drv_data->iocc_mask;
+	/*
+	 * no 'dma-coherent' property means the descriptors are
+	 * non-cacheable so iocc shareability should be disabled.
+	 */
+	if (of_dma_is_coherent(dev->of_node))
+		ufs->iocc_val = ufs->iocc_mask;
+	else
+		ufs->iocc_val = 0;
+
 	ufs->pclk_avail_min = PCLK_AVAIL_MIN;
 	ufs->pclk_avail_max = PCLK_AVAIL_MAX;
 
@@ -1438,7 +1468,7 @@ static int exynos_ufs_init(struct ufs_hba *hba)
 	exynos_ufs_fmp_init(hba, ufs);
 
 	if (ufs->drv_data->drv_init) {
-		ret = ufs->drv_data->drv_init(dev, ufs);
+		ret = ufs->drv_data->drv_init(ufs);
 		if (ret) {
 			dev_err(dev, "failed to init drv-data\n");
 			goto out;
@@ -1460,6 +1490,14 @@ static int exynos_ufs_init(struct ufs_hba *hba)
 	return ret;
 }
 
+static void exynos_ufs_exit(struct ufs_hba *hba)
+{
+	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
+
+	phy_power_off(ufs->phy);
+	phy_exit(ufs->phy);
+}
+
 static int exynos_ufs_host_reset(struct ufs_hba *hba)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
@@ -1649,6 +1687,12 @@ static void exynos_ufs_hibern8_notify(struct ufs_hba *hba,
 	}
 }
 
+static int gs101_ufs_suspend(struct exynos_ufs *ufs)
+{
+	hci_writel(ufs, 0 << 0, HCI_GPIO_OUT);
+	return 0;
+}
+
 static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 	enum ufs_notify_change_status status)
 {
@@ -1657,6 +1701,9 @@ static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 	if (status == PRE_CHANGE)
 		return 0;
 
+	if (ufs->drv_data->suspend)
+		ufs->drv_data->suspend(ufs);
+
 	if (!ufshcd_is_link_active(hba))
 		phy_power_off(ufs->phy);
 
@@ -1928,6 +1975,7 @@ static int gs101_ufs_pre_pwr_change(struct exynos_ufs *ufs,
 static const struct ufs_hba_variant_ops ufs_hba_exynos_ops = {
 	.name				= "exynos_ufs",
 	.init				= exynos_ufs_init,
+	.exit				= exynos_ufs_exit,
 	.hce_enable_notify		= exynos_ufs_hce_enable_notify,
 	.link_startup_notify		= exynos_ufs_link_startup_notify,
 	.pwr_change_notify		= exynos_ufs_pwr_change_notify,
@@ -1966,13 +2014,7 @@ static int exynos_ufs_probe(struct platform_device *pdev)
 
 static void exynos_ufs_remove(struct platform_device *pdev)
 {
-	struct ufs_hba *hba =  platform_get_drvdata(pdev);
-	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
-
 	ufshcd_pltfrm_remove(pdev);
-
-	phy_power_off(ufs->phy);
-	phy_exit(ufs->phy);
 }
 
 static struct exynos_ufs_uic_attr exynos7_uic_attr = {
@@ -2011,6 +2053,7 @@ static const struct exynos_ufs_drv_data exynosauto_ufs_drvs = {
 	.opts			= EXYNOS_UFS_OPT_BROKEN_AUTO_CLK_CTRL |
 				  EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR |
 				  EXYNOS_UFS_OPT_BROKEN_RX_SEL_IDX,
+	.iocc_mask		= UFS_EXYNOSAUTO_SHARABLE,
 	.drv_init		= exynosauto_ufs_drv_init,
 	.post_hce_enable	= exynosauto_ufs_post_hce_enable,
 	.pre_link		= exynosauto_ufs_pre_link,
@@ -2044,7 +2087,6 @@ static const struct exynos_ufs_drv_data exynos_ufs_drvs = {
 				  EXYNOS_UFS_OPT_BROKEN_RX_SEL_IDX |
 				  EXYNOS_UFS_OPT_SKIP_CONNECTION_ESTAB |
 				  EXYNOS_UFS_OPT_USE_SW_HIBERN8_TIMER,
-	.drv_init		= exynos7_ufs_drv_init,
 	.pre_link		= exynos7_ufs_pre_link,
 	.post_link		= exynos7_ufs_post_link,
 	.pre_pwr_change		= exynos7_ufs_pre_pwr_change,
@@ -2134,10 +2176,12 @@ static const struct exynos_ufs_drv_data gs101_ufs_drvs = {
 				  EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR |
 				  EXYNOS_UFS_OPT_UFSPR_SECURE |
 				  EXYNOS_UFS_OPT_TIMER_TICK_SELECT,
-	.drv_init		= exynosauto_ufs_drv_init,
+	.iocc_mask		= UFS_GS101_SHARABLE,
+	.drv_init		= gs101_ufs_drv_init,
 	.pre_link		= gs101_ufs_pre_link,
 	.post_link		= gs101_ufs_post_link,
 	.pre_pwr_change		= gs101_ufs_pre_pwr_change,
+	.suspend		= gs101_ufs_suspend,
 };
 
 static const struct of_device_id exynos_ufs_of_match[] = {
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index 1646c4a9bb08..3c6fe5132190 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -181,8 +181,9 @@ struct exynos_ufs_drv_data {
 	struct exynos_ufs_uic_attr *uic_attr;
 	unsigned int quirks;
 	unsigned int opts;
+	u32 iocc_mask;
 	/* SoC's specific operations */
-	int (*drv_init)(struct device *dev, struct exynos_ufs *ufs);
+	int (*drv_init)(struct exynos_ufs *ufs);
 	int (*pre_link)(struct exynos_ufs *ufs);
 	int (*post_link)(struct exynos_ufs *ufs);
 	int (*pre_pwr_change)(struct exynos_ufs *ufs,
@@ -191,6 +192,7 @@ struct exynos_ufs_drv_data {
 				struct ufs_pa_layer_attr *pwr);
 	int (*pre_hce_enable)(struct exynos_ufs *ufs);
 	int (*post_hce_enable)(struct exynos_ufs *ufs);
+	int (*suspend)(struct exynos_ufs *ufs);
 };
 
 struct ufs_phy_time_cfg {
@@ -230,7 +232,9 @@ struct exynos_ufs {
 	ktime_t entry_hibern8_t;
 	const struct exynos_ufs_drv_data *drv_data;
 	struct regmap *sysreg;
-	u32 shareability_reg_offset;
+	u32 iocc_offset;
+	u32 iocc_mask;
+	u32 iocc_val;
 
 	u32 opts;
 #define EXYNOS_UFS_OPT_HAS_APB_CLK_CTRL		BIT(0)
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index e12c5f9f7956..4557b1bcd635 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -118,7 +118,7 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 	struct device *dev = hba->dev;
 	struct qcom_ice *ice;
 
-	ice = of_qcom_ice_get(dev);
+	ice = devm_of_qcom_ice_get(dev);
 	if (ice == ERR_PTR(-EOPNOTSUPP)) {
 		dev_warn(dev, "Disabling inline encryption support\n");
 		ice = NULL;
diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index fd1beb10bba7..19101ff1cf1b 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1963,6 +1963,7 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
 	unsigned int bit;
 	unsigned long reg;
 
+	local_bh_disable();
 	spin_lock_irqsave(&priv_dev->lock, flags);
 
 	reg = readl(&priv_dev->regs->usb_ists);
@@ -2004,6 +2005,7 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
 irqend:
 	writel(~0, &priv_dev->regs->ep_ien);
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	local_bh_enable();
 
 	return ret;
 }
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 46d1a4428b9a..2174f6e1f82a 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -336,6 +336,13 @@ static int ci_hdrc_imx_notify_event(struct ci_hdrc *ci, unsigned int event)
 	return ret;
 }
 
+static void ci_hdrc_imx_disable_regulator(void *arg)
+{
+	struct ci_hdrc_imx_data *data = arg;
+
+	regulator_disable(data->hsic_pad_regulator);
+}
+
 static int ci_hdrc_imx_probe(struct platform_device *pdev)
 {
 	struct ci_hdrc_imx_data *data;
@@ -394,6 +401,13 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 					"Failed to enable HSIC pad regulator\n");
 				goto err_put;
 			}
+			ret = devm_add_action_or_reset(dev,
+					ci_hdrc_imx_disable_regulator, data);
+			if (ret) {
+				dev_err(dev,
+					"Failed to add regulator devm action\n");
+				goto err_put;
+			}
 		}
 	}
 
@@ -432,11 +446,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 	ret = imx_get_clks(dev);
 	if (ret)
-		goto disable_hsic_regulator;
+		goto qos_remove_request;
 
 	ret = imx_prepare_enable_clks(dev);
 	if (ret)
-		goto disable_hsic_regulator;
+		goto qos_remove_request;
 
 	ret = clk_prepare_enable(data->clk_wakeup);
 	if (ret)
@@ -470,7 +484,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	    of_usb_get_phy_mode(np) == USBPHY_INTERFACE_MODE_ULPI) {
 		pdata.flags |= CI_HDRC_OVERRIDE_PHY_CONTROL;
 		data->override_phy_control = true;
-		usb_phy_init(pdata.usb_phy);
+		ret = usb_phy_init(pdata.usb_phy);
+		if (ret) {
+			dev_err(dev, "Failed to init phy\n");
+			goto err_clk;
+		}
 	}
 
 	if (pdata.flags & CI_HDRC_SUPPORTS_RUNTIME_PM)
@@ -479,7 +497,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	ret = imx_usbmisc_init(data->usbmisc_data);
 	if (ret) {
 		dev_err(dev, "usbmisc init failed, ret=%d\n", ret);
-		goto err_clk;
+		goto phy_shutdown;
 	}
 
 	data->ci_pdev = ci_hdrc_add_device(dev,
@@ -488,7 +506,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	if (IS_ERR(data->ci_pdev)) {
 		ret = PTR_ERR(data->ci_pdev);
 		dev_err_probe(dev, ret, "ci_hdrc_add_device failed\n");
-		goto err_clk;
+		goto phy_shutdown;
 	}
 
 	if (data->usbmisc_data) {
@@ -522,19 +540,20 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 disable_device:
 	ci_hdrc_remove_device(data->ci_pdev);
+phy_shutdown:
+	if (data->override_phy_control)
+		usb_phy_shutdown(data->phy);
 err_clk:
 	clk_disable_unprepare(data->clk_wakeup);
 err_wakeup_clk:
 	imx_disable_unprepare_clks(dev);
-disable_hsic_regulator:
-	if (data->hsic_pad_regulator)
-		/* don't overwrite original ret (cf. EPROBE_DEFER) */
-		regulator_disable(data->hsic_pad_regulator);
+qos_remove_request:
 	if (pdata.flags & CI_HDRC_PMQOS)
 		cpu_latency_qos_remove_request(&data->pm_qos_req);
 	data->ci_pdev = NULL;
 err_put:
-	put_device(data->usbmisc_data->dev);
+	if (data->usbmisc_data)
+		put_device(data->usbmisc_data->dev);
 	return ret;
 }
 
@@ -556,10 +575,9 @@ static void ci_hdrc_imx_remove(struct platform_device *pdev)
 		clk_disable_unprepare(data->clk_wakeup);
 		if (data->plat_data->flags & CI_HDRC_PMQOS)
 			cpu_latency_qos_remove_request(&data->pm_qos_req);
-		if (data->hsic_pad_regulator)
-			regulator_disable(data->hsic_pad_regulator);
 	}
-	put_device(data->usbmisc_data->dev);
+	if (data->usbmisc_data)
+		put_device(data->usbmisc_data->dev);
 }
 
 static void ci_hdrc_imx_shutdown(struct platform_device *pdev)
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 86ee39db013f..16e7fa4d488d 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -726,7 +726,7 @@ static int wdm_open(struct inode *inode, struct file *file)
 		rv = -EBUSY;
 		goto out;
 	}
-
+	smp_rmb(); /* ordered against wdm_wwan_port_stop() */
 	rv = usb_autopm_get_interface(desc->intf);
 	if (rv < 0) {
 		dev_err(&desc->intf->dev, "Error autopm - %d\n", rv);
@@ -829,6 +829,7 @@ static struct usb_class_driver wdm_class = {
 static int wdm_wwan_port_start(struct wwan_port *port)
 {
 	struct wdm_device *desc = wwan_port_get_drvdata(port);
+	int rv;
 
 	/* The interface is both exposed via the WWAN framework and as a
 	 * legacy usbmisc chardev. If chardev is already open, just fail
@@ -848,7 +849,15 @@ static int wdm_wwan_port_start(struct wwan_port *port)
 	wwan_port_txon(port);
 
 	/* Start getting events */
-	return usb_submit_urb(desc->validity, GFP_KERNEL);
+	rv = usb_submit_urb(desc->validity, GFP_KERNEL);
+	if (rv < 0) {
+		wwan_port_txoff(port);
+		desc->manage_power(desc->intf, 0);
+		/* this must be last lest we race with chardev open */
+		clear_bit(WDM_WWAN_IN_USE, &desc->flags);
+	}
+
+	return rv;
 }
 
 static void wdm_wwan_port_stop(struct wwan_port *port)
@@ -859,8 +868,10 @@ static void wdm_wwan_port_stop(struct wwan_port *port)
 	poison_urbs(desc);
 	desc->manage_power(desc->intf, 0);
 	clear_bit(WDM_READ, &desc->flags);
-	clear_bit(WDM_WWAN_IN_USE, &desc->flags);
 	unpoison_urbs(desc);
+	smp_wmb(); /* ordered against wdm_open() */
+	/* this must be last lest we open a poisoned device */
+	clear_bit(WDM_WWAN_IN_USE, &desc->flags);
 }
 
 static void wdm_wwan_port_tx_complete(struct urb *urb)
@@ -868,7 +879,7 @@ static void wdm_wwan_port_tx_complete(struct urb *urb)
 	struct sk_buff *skb = urb->context;
 	struct wdm_device *desc = skb_shinfo(skb)->destructor_arg;
 
-	usb_autopm_put_interface(desc->intf);
+	usb_autopm_put_interface_async(desc->intf);
 	wwan_port_txon(desc->wwanp);
 	kfree_skb(skb);
 }
@@ -898,7 +909,7 @@ static int wdm_wwan_port_tx(struct wwan_port *port, struct sk_buff *skb)
 	req->bRequestType = (USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE);
 	req->bRequest = USB_CDC_SEND_ENCAPSULATED_COMMAND;
 	req->wValue = 0;
-	req->wIndex = desc->inum;
+	req->wIndex = desc->inum; /* already converted */
 	req->wLength = cpu_to_le16(skb->len);
 
 	skb_shinfo(skb)->destructor_arg = desc;
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 6926bd639ec6..4903c733d37a 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -369,6 +369,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0781, 0x5583), .driver_info = USB_QUIRK_NO_LPM },
 	{ USB_DEVICE(0x0781, 0x5591), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* SanDisk Corp. SanDisk 3.2Gen1 */
+	{ USB_DEVICE(0x0781, 0x55a3), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Realforce 87U Keyboard */
 	{ USB_DEVICE(0x0853, 0x011b), .driver_info = USB_QUIRK_NO_LPM },
 
@@ -383,6 +386,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0904, 0x6103), .driver_info =
 			USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL },
 
+	/* Silicon Motion Flash Drive */
+	{ USB_DEVICE(0x090c, 0x1000), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Sound Devices USBPre2 */
 	{ USB_DEVICE(0x0926, 0x0202), .driver_info =
 			USB_QUIRK_ENDPOINT_IGNORE },
@@ -536,6 +542,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x2040, 0x7200), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
 
+	/* VLI disk */
+	{ USB_DEVICE(0x2109, 0x0711), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Raydium Touchscreen */
 	{ USB_DEVICE(0x2386, 0x3114), .driver_info = USB_QUIRK_NO_LPM },
 
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 052852f80146..54a4ee2b90b7 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -148,11 +148,21 @@ static const struct property_entry dwc3_pci_intel_byt_properties[] = {
 	{}
 };
 
+/*
+ * Intel Merrifield SoC uses these endpoints for tracing and they cannot
+ * be re-allocated if being used because the side band flow control signals
+ * are hard wired to certain endpoints:
+ * - 1 High BW Bulk IN (IN#1) (RTIT)
+ * - 1 1KB BW Bulk IN (IN#8) + 1 1KB BW Bulk OUT (Run Control) (OUT#8)
+ */
+static const u8 dwc3_pci_mrfld_reserved_endpoints[] = { 3, 16, 17 };
+
 static const struct property_entry dwc3_pci_mrfld_properties[] = {
 	PROPERTY_ENTRY_STRING("dr_mode", "otg"),
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "mrfld_bcove_pwrsrc"),
 	PROPERTY_ENTRY_BOOL("snps,dis_u3_susphy_quirk"),
 	PROPERTY_ENTRY_BOOL("snps,dis_u2_susphy_quirk"),
+	PROPERTY_ENTRY_U8_ARRAY("snps,reserved-endpoints", dwc3_pci_mrfld_reserved_endpoints),
 	PROPERTY_ENTRY_BOOL("snps,usb2-gadget-lpm-disable"),
 	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
 	{}
diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 96c87dc4757f..47e891c92337 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -207,15 +207,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 
 skip_usb3_phy:
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
-	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio)) {
 		return dev_err_probe(dev, PTR_ERR(reset_gpio),
 				     "Failed to request reset GPIO\n");
 	}
 
 	if (reset_gpio) {
-		/* Toggle ulpi to reset the phy. */
-		gpiod_set_value_cansleep(reset_gpio, 1);
 		usleep_range(5000, 10000);
 		gpiod_set_value_cansleep(reset_gpio, 0);
 		usleep_range(5000, 10000);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 309a871453bf..e72bac650981 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -548,6 +548,7 @@ static int dwc3_gadget_set_xfer_resource(struct dwc3_ep *dep)
 int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
 {
 	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3_ep		*dep;
 	u32			cmd;
 	int			i;
 	int			ret;
@@ -564,8 +565,13 @@ int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
 		return ret;
 
 	/* Reset resource allocation flags */
-	for (i = resource_index; i < dwc->num_eps && dwc->eps[i]; i++)
-		dwc->eps[i]->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
+	for (i = resource_index; i < dwc->num_eps; i++) {
+		dep = dwc->eps[i];
+		if (!dep)
+			continue;
+
+		dep->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
+	}
 
 	return 0;
 }
@@ -752,9 +758,11 @@ void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
 
 	dwc->last_fifo_depth = fifo_depth;
 	/* Clear existing TXFIFO for all IN eps except ep0 */
-	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM);
-	     num += 2) {
+	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM); num += 2) {
 		dep = dwc->eps[num];
+		if (!dep)
+			continue;
+
 		/* Don't change TXFRAMNUM on usb31 version */
 		size = DWC3_IP_IS(DWC3) ? 0 :
 			dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1)) &
@@ -3670,6 +3678,8 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 
 		for (i = 0; i < DWC3_ENDPOINTS_NUM; i++) {
 			dep = dwc->eps[i];
+			if (!dep)
+				continue;
 
 			if (!(dep->flags & DWC3_EP_ENABLED))
 				continue;
@@ -3858,6 +3868,10 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	u8			epnum = event->endpoint_number;
 
 	dep = dwc->eps[epnum];
+	if (!dep) {
+		dev_warn(dwc->dev, "spurious event, endpoint %u is not allocated\n", epnum);
+		return;
+	}
 
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
 		if ((epnum > 1) && !(dep->flags & DWC3_EP_TRANSFER_STARTED))
@@ -4570,6 +4584,12 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	if (!count)
 		return IRQ_NONE;
 
+	if (count > evt->length) {
+		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
+			count, evt->length);
+		return IRQ_NONE;
+	}
+
 	evt->count = count;
 	evt->flags |= DWC3_EVENT_PENDING;
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 573109ca5b79..a09f72772e6e 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -548,6 +548,9 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 	d->vhub = vhub;
 	d->index = idx;
 	d->name = devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
+	if (!d->name)
+		return -ENOMEM;
+
 	d->regs = vhub->regs + 0x100 + 0x10 * idx;
 
 	ast_vhub_init_ep0(vhub, &d->ep0, d);
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 0881fdd1823e..dcf31a592f5d 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1946,6 +1946,12 @@ max3421_remove(struct spi_device *spi)
 	usb_put_hcd(hcd);
 }
 
+static const struct spi_device_id max3421_spi_ids[] = {
+	{ "max3421" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, max3421_spi_ids);
+
 static const struct of_device_id max3421_of_match_table[] = {
 	{ .compatible = "maxim,max3421", },
 	{},
@@ -1955,6 +1961,7 @@ MODULE_DEVICE_TABLE(of, max3421_of_match_table);
 static struct spi_driver max3421_driver = {
 	.probe		= max3421_probe,
 	.remove		= max3421_remove,
+	.id_table	= max3421_spi_ids,
 	.driver		= {
 		.name	= "max3421-hcd",
 		.of_match_table = max3421_of_match_table,
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index 900ea0d368e0..9f0a6b27e47c 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -165,6 +165,25 @@ static int ohci_quirk_amd700(struct usb_hcd *hcd)
 	return 0;
 }
 
+static int ohci_quirk_loongson(struct usb_hcd *hcd)
+{
+	struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
+
+	/*
+	 * Loongson's LS7A OHCI controller (rev 0x02) has a
+	 * flaw. MMIO register with offset 0x60/64 is treated
+	 * as legacy PS2-compatible keyboard/mouse interface.
+	 * Since OHCI only use 4KB BAR resource, LS7A OHCI's
+	 * 32KB BAR is wrapped around (the 2nd 4KB BAR space
+	 * is the same as the 1st 4KB internally). So add 4KB
+	 * offset (0x1000) to the OHCI registers as a quirk.
+	 */
+	if (pdev->revision == 0x2)
+		hcd->regs += SZ_4K;	/* SZ_4K = 0x1000 */
+
+	return 0;
+}
+
 static int ohci_quirk_qemu(struct usb_hcd *hcd)
 {
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
@@ -224,6 +243,10 @@ static const struct pci_device_id ohci_pci_quirks[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_ATI, 0x4399),
 		.driver_data = (unsigned long)ohci_quirk_amd700,
 	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a24),
+		.driver_data = (unsigned long)ohci_quirk_loongson,
+	},
 	{
 		.vendor		= PCI_VENDOR_ID_APPLE,
 		.device		= 0x003f,
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 2fe3a92978fa..1952e0503340 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1878,9 +1878,10 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 	int max_ports, port_index;
 	int sret;
 	u32 next_state;
-	u32 temp, portsc;
+	u32 portsc;
 	struct xhci_hub *rhub;
 	struct xhci_port **ports;
+	bool disabled_irq = false;
 
 	rhub = xhci_get_rhub(hcd);
 	ports = rhub->ports;
@@ -1896,17 +1897,20 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 		return -ESHUTDOWN;
 	}
 
-	/* delay the irqs */
-	temp = readl(&xhci->op_regs->command);
-	temp &= ~CMD_EIE;
-	writel(temp, &xhci->op_regs->command);
-
 	/* bus specific resume for ports we suspended at bus_suspend */
-	if (hcd->speed >= HCD_USB3)
+	if (hcd->speed >= HCD_USB3) {
 		next_state = XDEV_U0;
-	else
+	} else {
 		next_state = XDEV_RESUME;
-
+		if (bus_state->bus_suspended) {
+			/*
+			 * prevent port event interrupts from interfering
+			 * with usb2 port resume process
+			 */
+			xhci_disable_interrupter(xhci->interrupters[0]);
+			disabled_irq = true;
+		}
+	}
 	port_index = max_ports;
 	while (port_index--) {
 		portsc = readl(ports[port_index]->addr);
@@ -1974,11 +1978,9 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 	(void) readl(&xhci->op_regs->command);
 
 	bus_state->next_statechange = jiffies + msecs_to_jiffies(5);
-	/* re-enable irqs */
-	temp = readl(&xhci->op_regs->command);
-	temp |= CMD_EIE;
-	writel(temp, &xhci->op_regs->command);
-	temp = readl(&xhci->op_regs->command);
+	/* re-enable interrupter */
+	if (disabled_irq)
+		xhci_enable_interrupter(xhci->interrupters[0]);
 
 	spin_unlock_irqrestore(&xhci->lock, flags);
 	return 0;
diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
index 87f1597a0e5a..257e4d79971f 100644
--- a/drivers/usb/host/xhci-mvebu.c
+++ b/drivers/usb/host/xhci-mvebu.c
@@ -73,13 +73,3 @@ int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
 
 	return 0;
 }
-
-int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
-{
-	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
-
-	/* Without reset on resume, the HC won't work at all */
-	xhci->quirks |= XHCI_RESET_ON_RESUME;
-
-	return 0;
-}
diff --git a/drivers/usb/host/xhci-mvebu.h b/drivers/usb/host/xhci-mvebu.h
index 3be021793cc8..9d26e22c4842 100644
--- a/drivers/usb/host/xhci-mvebu.h
+++ b/drivers/usb/host/xhci-mvebu.h
@@ -12,16 +12,10 @@ struct usb_hcd;
 
 #if IS_ENABLED(CONFIG_USB_XHCI_MVEBU)
 int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd);
-int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd);
 #else
 static inline int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
 {
 	return 0;
 }
-
-static inline int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
-{
-	return 0;
-}
 #endif
 #endif /* __LINUX_XHCI_MVEBU_H */
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index e6660472501e..2379a67e34e1 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -106,7 +106,7 @@ static const struct xhci_plat_priv xhci_plat_marvell_armada = {
 };
 
 static const struct xhci_plat_priv xhci_plat_marvell_armada3700 = {
-	.init_quirk = xhci_mvebu_a3700_init_quirk,
+	.quirks = XHCI_RESET_ON_RESUME,
 };
 
 static const struct xhci_plat_priv xhci_plat_brcm = {
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 2fad9563dca4..3e70e4f6bf08 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1190,16 +1190,19 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			 * Stopped state, but it will soon change to Running.
 			 *
 			 * Assume this bug on unexpected Stop Endpoint failures.
-			 * Keep retrying until the EP starts and stops again, on
-			 * chips where this is known to help. Wait for 100ms.
+			 * Keep retrying until the EP starts and stops again.
 			 */
-			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
-				break;
 			fallthrough;
 		case EP_STATE_RUNNING:
 			/* Race, HW handled stop ep cmd before ep was running */
 			xhci_dbg(xhci, "Stop ep completion ctx error, ctx_state %d\n",
 					GET_EP_CTX_STATE(ep_ctx));
+			/*
+			 * Don't retry forever if we guessed wrong or a defective HC never starts
+			 * the EP or says 'Running' but fails the command. We must give back TDs.
+			 */
+			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
+				break;
 
 			command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
 			if (!command) {
@@ -2642,6 +2645,22 @@ static int handle_transferless_tx_event(struct xhci_hcd *xhci, struct xhci_virt_
 	return 0;
 }
 
+static bool xhci_spurious_success_tx_event(struct xhci_hcd *xhci,
+					   struct xhci_ring *ring)
+{
+	switch (ring->old_trb_comp_code) {
+	case COMP_SHORT_PACKET:
+		return xhci->quirks & XHCI_SPURIOUS_SUCCESS;
+	case COMP_USB_TRANSACTION_ERROR:
+	case COMP_BABBLE_DETECTED_ERROR:
+	case COMP_ISOCH_BUFFER_OVERRUN:
+		return xhci->quirks & XHCI_ETRON_HOST &&
+			ring->type == TYPE_ISOC;
+	default:
+		return false;
+	}
+}
+
 /*
  * If this function returns an error condition, it means it got a Transfer
  * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
@@ -2662,6 +2681,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	int status = -EINPROGRESS;
 	struct xhci_ep_ctx *ep_ctx;
 	u32 trb_comp_code;
+	bool ring_xrun_event = false;
 
 	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
 	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
@@ -2695,8 +2715,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	case COMP_SUCCESS:
 		if (EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)) != 0) {
 			trb_comp_code = COMP_SHORT_PACKET;
-			xhci_dbg(xhci, "Successful completion on short TX for slot %u ep %u with last td short %d\n",
-				 slot_id, ep_index, ep_ring->last_td_was_short);
+			xhci_dbg(xhci, "Successful completion on short TX for slot %u ep %u with last td comp code %d\n",
+				 slot_id, ep_index, ep_ring->old_trb_comp_code);
 		}
 		break;
 	case COMP_SHORT_PACKET:
@@ -2768,14 +2788,12 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		 * Underrun Event for OUT Isoch endpoint.
 		 */
 		xhci_dbg(xhci, "Underrun event on slot %u ep %u\n", slot_id, ep_index);
-		if (ep->skip)
-			break;
-		return 0;
+		ring_xrun_event = true;
+		break;
 	case COMP_RING_OVERRUN:
 		xhci_dbg(xhci, "Overrun event on slot %u ep %u\n", slot_id, ep_index);
-		if (ep->skip)
-			break;
-		return 0;
+		ring_xrun_event = true;
+		break;
 	case COMP_MISSED_SERVICE_ERROR:
 		/*
 		 * When encounter missed service error, one or more isoc tds
@@ -2787,7 +2805,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		xhci_dbg(xhci,
 			 "Miss service interval error for slot %u ep %u, set skip flag\n",
 			 slot_id, ep_index);
-		return 0;
+		break;
 	case COMP_NO_PING_RESPONSE_ERROR:
 		ep->skip = true;
 		xhci_dbg(xhci,
@@ -2838,6 +2856,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		xhci_td_cleanup(xhci, td, ep_ring, td->status);
 	}
 
+	/* Missed TDs will be skipped on the next event */
+	if (trb_comp_code == COMP_MISSED_SERVICE_ERROR)
+		return 0;
+
 	if (list_empty(&ep_ring->td_list)) {
 		/*
 		 * Don't print wanings if ring is empty due to a stopped endpoint generating an
@@ -2847,7 +2869,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		 */
 		if (trb_comp_code != COMP_STOPPED &&
 		    trb_comp_code != COMP_STOPPED_LENGTH_INVALID &&
-		    !ep_ring->last_td_was_short) {
+		    !ring_xrun_event &&
+		    !xhci_spurious_success_tx_event(xhci, ep_ring)) {
 			xhci_warn(xhci, "Event TRB for slot %u ep %u with no TDs queued\n",
 				  slot_id, ep_index);
 		}
@@ -2881,6 +2904,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 				goto check_endpoint_halted;
 			}
 
+			/* TD was queued after xrun, maybe xrun was on a link, don't panic yet */
+			if (ring_xrun_event)
+				return 0;
+
 			/*
 			 * Skip the Force Stopped Event. The 'ep_trb' of FSE is not in the current
 			 * TD pointed by 'ep_ring->dequeue' because that the hardware dequeue
@@ -2895,11 +2922,12 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 
 			/*
 			 * Some hosts give a spurious success event after a short
-			 * transfer. Ignore it.
+			 * transfer or error on last TRB. Ignore it.
 			 */
-			if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
-			    ep_ring->last_td_was_short) {
-				ep_ring->last_td_was_short = false;
+			if (xhci_spurious_success_tx_event(xhci, ep_ring)) {
+				xhci_dbg(xhci, "Spurious event dma %pad, comp_code %u after %u\n",
+					 &ep_trb_dma, trb_comp_code, ep_ring->old_trb_comp_code);
+				ep_ring->old_trb_comp_code = 0;
 				return 0;
 			}
 
@@ -2927,10 +2955,11 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	 */
 	} while (ep->skip);
 
-	if (trb_comp_code == COMP_SHORT_PACKET)
-		ep_ring->last_td_was_short = true;
-	else
-		ep_ring->last_td_was_short = false;
+	ep_ring->old_trb_comp_code = trb_comp_code;
+
+	/* Get out if a TD was queued at enqueue after the xrun occurred */
+	if (ring_xrun_event)
+		return 0;
 
 	ep_trb = &ep_seg->trbs[(ep_trb_dma - ep_seg->dma) / sizeof(*ep_trb)];
 	trace_xhci_handle_transfer(ep_ring, (struct xhci_generic_trb *) ep_trb);
@@ -3778,7 +3807,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 		 * enqueue a No Op TRB, this can prevent the Setup and Data Stage
 		 * TRB to be breaked by the Link TRB.
 		 */
-		if (trb_is_link(ep_ring->enqueue + 1)) {
+		if (last_trb_on_seg(ep_ring->enq_seg, ep_ring->enqueue + 1)) {
 			field = TRB_TYPE(TRB_TR_NOOP) | ep_ring->cycle_state;
 			queue_trb(xhci, ep_ring, false, 0, 0,
 					TRB_INTR_TARGET(0), field);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 358ed674f782..799941b6ad6c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -321,7 +321,7 @@ static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
 		xhci_info(xhci, "Fault detected\n");
 }
 
-static int xhci_enable_interrupter(struct xhci_interrupter *ir)
+int xhci_enable_interrupter(struct xhci_interrupter *ir)
 {
 	u32 iman;
 
@@ -334,7 +334,7 @@ static int xhci_enable_interrupter(struct xhci_interrupter *ir)
 	return 0;
 }
 
-static int xhci_disable_interrupter(struct xhci_interrupter *ir)
+int xhci_disable_interrupter(struct xhci_interrupter *ir)
 {
 	u32 iman;
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 71588e4db0e3..2a954efa53e8 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1360,7 +1360,7 @@ struct xhci_ring {
 	unsigned int		num_trbs_free; /* used only by xhci DbC */
 	unsigned int		bounce_buf_len;
 	enum xhci_ring_type	type;
-	bool			last_td_was_short;
+	u32			old_trb_comp_code;
 	struct radix_tree_root	*trb_address_map;
 };
 
@@ -1881,6 +1881,8 @@ int xhci_alloc_tt_info(struct xhci_hcd *xhci,
 		struct usb_tt *tt, gfp_t mem_flags);
 int xhci_set_interrupter_moderation(struct xhci_interrupter *ir,
 				    u32 imod_interval);
+int xhci_enable_interrupter(struct xhci_interrupter *ir);
+int xhci_disable_interrupter(struct xhci_interrupter *ir);
 
 /* xHCI ring, segment, TRB, and TD functions */
 dma_addr_t xhci_trb_virt_to_dma(struct xhci_segment *seg, union xhci_trb *trb);
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 236205ce3500..eef614be7db5 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1093,6 +1093,8 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 2) },
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 3) },
+	/* Abacus Electrics */
+	{ USB_DEVICE(FTDI_VID, ABACUS_OPTICAL_PROBE_PID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 52be47d684ea..9acb6f837327 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -442,6 +442,11 @@
 #define LINX_FUTURE_1_PID   0xF44B	/* Linx future device */
 #define LINX_FUTURE_2_PID   0xF44C	/* Linx future device */
 
+/*
+ * Abacus Electrics
+ */
+#define ABACUS_OPTICAL_PROBE_PID	0xf458 /* ABACUS ELECTRICS Optical Probe */
+
 /*
  * Oceanic product ids
  */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 5cd26dac2069..27879cc57536 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -611,6 +611,7 @@ static void option_instat_callback(struct urb *urb);
 /* Sierra Wireless products */
 #define SIERRA_VENDOR_ID			0x1199
 #define SIERRA_PRODUCT_EM9191			0x90d3
+#define SIERRA_PRODUCT_EM9291			0x90e3
 
 /* UNISOC (Spreadtrum) products */
 #define UNISOC_VENDOR_ID			0x1782
@@ -2432,6 +2433,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9291, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9291, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0530, 0xff),			/* TCL IK512 MBIM */
diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 2c12449ff60c..a0afaf254d12 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -100,6 +100,11 @@ DEVICE(nokia, NOKIA_IDS);
 	{ USB_DEVICE(0x09d7, 0x0100) }	/* NovAtel FlexPack GPS */
 DEVICE_N(novatel_gps, NOVATEL_IDS, 3);
 
+/* OWON electronic test and measurement equipment driver */
+#define OWON_IDS()			\
+	{ USB_DEVICE(0x5345, 0x1234) } /* HDS200 oscilloscopes and others */
+DEVICE(owon, OWON_IDS);
+
 /* Siemens USB/MPI adapter */
 #define SIEMENS_IDS()			\
 	{ USB_DEVICE(0x908, 0x0004) }
@@ -134,6 +139,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
 	&motorola_tetra_device,
 	&nokia_device,
 	&novatel_gps_device,
+	&owon_device,
 	&siemens_mpi_device,
 	&suunto_device,
 	&vivopay_device,
@@ -153,6 +159,7 @@ static const struct usb_device_id id_table[] = {
 	MOTOROLA_TETRA_IDS(),
 	NOKIA_IDS(),
 	NOVATEL_IDS(),
+	OWON_IDS(),
 	SIEMENS_IDS(),
 	SUUNTO_IDS(),
 	VIVOPAY_IDS(),
diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index 1f8c9b16a0fb..d460d71b4257 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -83,6 +83,13 @@ UNUSUAL_DEV(0x0bc2, 0x331a, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_LUNS),
 
+/* Reported-by: Oliver Neukum <oneukum@suse.com> */
+UNUSUAL_DEV(0x125f, 0xa94a, 0x0160, 0x0160,
+		"ADATA",
+		"Portable HDD CH94",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_ATA_1X),
+
 /* Reported-by: Benjamin Tissoires <benjamin.tissoires@redhat.com> */
 UNUSUAL_DEV(0x13fd, 0x3940, 0x0000, 0x9999,
 		"Initio Corporation",
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 58f40156de56..5c75634b8fa3 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -932,9 +932,11 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 	partner->dev.type = &typec_partner_dev_type;
 	dev_set_name(&partner->dev, "%s-partner", dev_name(&port->dev));
 
+	mutex_lock(&port->partner_link_lock);
 	ret = device_register(&partner->dev);
 	if (ret) {
 		dev_err(&port->dev, "failed to register partner (%d)\n", ret);
+		mutex_unlock(&port->partner_link_lock);
 		put_device(&partner->dev);
 		return ERR_PTR(ret);
 	}
@@ -943,6 +945,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 		typec_partner_link_device(partner, port->usb2_dev);
 	if (port->usb3_dev)
 		typec_partner_link_device(partner, port->usb3_dev);
+	mutex_unlock(&port->partner_link_lock);
 
 	return partner;
 }
@@ -963,12 +966,18 @@ void typec_unregister_partner(struct typec_partner *partner)
 
 	port = to_typec_port(partner->dev.parent);
 
-	if (port->usb2_dev)
+	mutex_lock(&port->partner_link_lock);
+	if (port->usb2_dev) {
 		typec_partner_unlink_device(partner, port->usb2_dev);
-	if (port->usb3_dev)
+		port->usb2_dev = NULL;
+	}
+	if (port->usb3_dev) {
 		typec_partner_unlink_device(partner, port->usb3_dev);
+		port->usb3_dev = NULL;
+	}
 
 	device_unregister(&partner->dev);
+	mutex_unlock(&port->partner_link_lock);
 }
 EXPORT_SYMBOL_GPL(typec_unregister_partner);
 
@@ -1862,25 +1871,30 @@ static struct typec_partner *typec_get_partner(struct typec_port *port)
 static void typec_partner_attach(struct typec_connector *con, struct device *dev)
 {
 	struct typec_port *port = container_of(con, struct typec_port, con);
-	struct typec_partner *partner = typec_get_partner(port);
+	struct typec_partner *partner;
 	struct usb_device *udev = to_usb_device(dev);
 
+	mutex_lock(&port->partner_link_lock);
 	if (udev->speed < USB_SPEED_SUPER)
 		port->usb2_dev = dev;
 	else
 		port->usb3_dev = dev;
 
+	partner = typec_get_partner(port);
 	if (partner) {
 		typec_partner_link_device(partner, dev);
 		put_device(&partner->dev);
 	}
+	mutex_unlock(&port->partner_link_lock);
 }
 
 static void typec_partner_deattach(struct typec_connector *con, struct device *dev)
 {
 	struct typec_port *port = container_of(con, struct typec_port, con);
-	struct typec_partner *partner = typec_get_partner(port);
+	struct typec_partner *partner;
 
+	mutex_lock(&port->partner_link_lock);
+	partner = typec_get_partner(port);
 	if (partner) {
 		typec_partner_unlink_device(partner, dev);
 		put_device(&partner->dev);
@@ -1890,6 +1904,7 @@ static void typec_partner_deattach(struct typec_connector *con, struct device *d
 		port->usb2_dev = NULL;
 	else if (port->usb3_dev == dev)
 		port->usb3_dev = NULL;
+	mutex_unlock(&port->partner_link_lock);
 }
 
 /**
@@ -2425,6 +2440,7 @@ struct typec_port *typec_register_port(struct device *parent,
 
 	ida_init(&port->mode_ids);
 	mutex_init(&port->port_type_lock);
+	mutex_init(&port->partner_link_lock);
 
 	port->id = id;
 	port->ops = cap->ops;
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index 7485cdb9dd20..300312a1c152 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -56,6 +56,7 @@ struct typec_port {
 	enum typec_pwr_opmode		pwr_opmode;
 	enum typec_port_type		port_type;
 	struct mutex			port_type_lock;
+	struct mutex			partner_link_lock;
 
 	enum typec_orientation		orientation;
 	struct typec_switch		*sw;
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 7aeff435c1d8..35a03306d134 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -630,7 +630,7 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, struct vhost_scsi_tpg *tpg,
 
 	tag = sbitmap_get(&svq->scsi_tags);
 	if (tag < 0) {
-		pr_err("Unable to obtain tag for vhost_scsi_cmd\n");
+		pr_warn_once("Guest sent too many cmds. Returning TASK_SET_FULL.\n");
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -930,24 +930,69 @@ static void vhost_scsi_target_queue_cmd(struct vhost_scsi_cmd *cmd)
 }
 
 static void
-vhost_scsi_send_bad_target(struct vhost_scsi *vs,
-			   struct vhost_virtqueue *vq,
-			   int head, unsigned out)
+vhost_scsi_send_status(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
+		       struct vhost_scsi_ctx *vc, u8 status)
 {
-	struct virtio_scsi_cmd_resp __user *resp;
 	struct virtio_scsi_cmd_resp rsp;
+	struct iov_iter iov_iter;
 	int ret;
 
 	memset(&rsp, 0, sizeof(rsp));
-	rsp.response = VIRTIO_SCSI_S_BAD_TARGET;
-	resp = vq->iov[out].iov_base;
-	ret = __copy_to_user(resp, &rsp, sizeof(rsp));
-	if (!ret)
-		vhost_add_used_and_signal(&vs->dev, vq, head, 0);
+	rsp.status = status;
+
+	iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[vc->out], vc->in,
+		      sizeof(rsp));
+
+	ret = copy_to_iter(&rsp, sizeof(rsp), &iov_iter);
+
+	if (likely(ret == sizeof(rsp)))
+		vhost_add_used_and_signal(&vs->dev, vq, vc->head, 0);
 	else
 		pr_err("Faulted on virtio_scsi_cmd_resp\n");
 }
 
+#define TYPE_IO_CMD    0
+#define TYPE_CTRL_TMF  1
+#define TYPE_CTRL_AN   2
+
+static void
+vhost_scsi_send_bad_target(struct vhost_scsi *vs,
+			   struct vhost_virtqueue *vq,
+			   struct vhost_scsi_ctx *vc, int type)
+{
+	union {
+		struct virtio_scsi_cmd_resp cmd;
+		struct virtio_scsi_ctrl_tmf_resp tmf;
+		struct virtio_scsi_ctrl_an_resp an;
+	} rsp;
+	struct iov_iter iov_iter;
+	size_t rsp_size;
+	int ret;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	if (type == TYPE_IO_CMD) {
+		rsp_size = sizeof(struct virtio_scsi_cmd_resp);
+		rsp.cmd.response = VIRTIO_SCSI_S_BAD_TARGET;
+	} else if (type == TYPE_CTRL_TMF) {
+		rsp_size = sizeof(struct virtio_scsi_ctrl_tmf_resp);
+		rsp.tmf.response = VIRTIO_SCSI_S_BAD_TARGET;
+	} else {
+		rsp_size = sizeof(struct virtio_scsi_ctrl_an_resp);
+		rsp.an.response = VIRTIO_SCSI_S_BAD_TARGET;
+	}
+
+	iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[vc->out], vc->in,
+		      rsp_size);
+
+	ret = copy_to_iter(&rsp, rsp_size, &iov_iter);
+
+	if (likely(ret == rsp_size))
+		vhost_add_used_and_signal(&vs->dev, vq, vc->head, 0);
+	else
+		pr_err("Faulted on virtio scsi type=%d\n", type);
+}
+
 static int
 vhost_scsi_get_desc(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
 		    struct vhost_scsi_ctx *vc)
@@ -1216,8 +1261,8 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 					 exp_data_len + prot_bytes,
 					 data_direction);
 		if (IS_ERR(cmd)) {
-			vq_err(vq, "vhost_scsi_get_cmd failed %ld\n",
-			       PTR_ERR(cmd));
+			ret = PTR_ERR(cmd);
+			vq_err(vq, "vhost_scsi_get_tag failed %dd\n", ret);
 			goto err;
 		}
 		cmd->tvc_vhost = vs;
@@ -1254,11 +1299,15 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		 * EINVAL: Invalid response buffer, drop the request
 		 * EIO:    Respond with bad target
 		 * EAGAIN: Pending request
+		 * ENOMEM: Could not allocate resources for request
 		 */
 		if (ret == -ENXIO)
 			break;
 		else if (ret == -EIO)
-			vhost_scsi_send_bad_target(vs, vq, vc.head, vc.out);
+			vhost_scsi_send_bad_target(vs, vq, &vc, TYPE_IO_CMD);
+		else if (ret == -ENOMEM)
+			vhost_scsi_send_status(vs, vq, &vc,
+					       SAM_STAT_TASK_SET_FULL);
 	} while (likely(!vhost_exceeds_weight(vq, ++c, 0)));
 out:
 	mutex_unlock(&vq->mutex);
@@ -1488,7 +1537,10 @@ vhost_scsi_ctl_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		if (ret == -ENXIO)
 			break;
 		else if (ret == -EIO)
-			vhost_scsi_send_bad_target(vs, vq, vc.head, vc.out);
+			vhost_scsi_send_bad_target(vs, vq, &vc,
+						   v_req.type == VIRTIO_SCSI_T_TMF ?
+						   TYPE_CTRL_TMF :
+						   TYPE_CTRL_AN);
 	} while (likely(!vhost_exceeds_weight(vq, ++c, 0)));
 out:
 	mutex_unlock(&vq->mutex);
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index f7d6f47971fd..24f485827e03 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -278,7 +278,7 @@ config XEN_PRIVCMD_EVENTFD
 
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
-	depends on XEN && XEN_PV_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
+	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
 	default m
 	help
 	  This ACPI processor uploads Power Management information to the Xen
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 78c4a3765002..eaa991e69804 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2235,15 +2235,20 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 	 * will always return true.
 	 * So here we need to do extra page alignment for
 	 * filemap_range_has_page().
+	 *
+	 * And do not decrease page_lockend right now, as it can be 0.
 	 */
 	const u64 page_lockstart = round_up(lockstart, PAGE_SIZE);
-	const u64 page_lockend = round_down(lockend + 1, PAGE_SIZE) - 1;
+	const u64 page_lockend = round_down(lockend + 1, PAGE_SIZE);
 
 	while (1) {
 		truncate_pagecache_range(inode, lockstart, lockend);
 
 		lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			    cached_state);
+		/* The same page or adjacent pages. */
+		if (page_lockend <= page_lockstart)
+			break;
 		/*
 		 * We can't have ordered extents in the range, nor dirty/writeback
 		 * pages, because we have locked the inode's VFS lock in exclusive
@@ -2255,7 +2260,7 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 		 * we do, unlock the range and retry.
 		 */
 		if (!filemap_range_has_page(inode->i_mapping, page_lockstart,
-					    page_lockend))
+					    page_lockend - 1))
 			break;
 
 		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2bb7e32ad945..2603c9d60fd2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1655,7 +1655,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		 * stripe.
 		 */
 		cache->alloc_offset = cache->zone_capacity;
-		ret = 0;
 	}
 
 out:
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 315ef02f9a3f..f7875e6f3029 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2362,7 +2362,7 @@ static int fill_fscrypt_truncate(struct inode *inode,
 
 	/* Try to writeback the dirty pagecaches */
 	if (issued & (CEPH_CAP_FILE_BUFFER)) {
-		loff_t lend = orig_pos + CEPH_FSCRYPT_BLOCK_SHIFT - 1;
+		loff_t lend = orig_pos + CEPH_FSCRYPT_BLOCK_SIZE - 1;
 
 		ret = filemap_write_and_wait_range(inode->i_mapping,
 						   orig_pos, lend);
diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 87ee3a17bd29..e8c5525afc67 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -351,10 +351,9 @@ int ext4_check_blockref(const char *function, unsigned int line,
 {
 	__le32 *bref = p;
 	unsigned int blk;
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
 
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+	if (journal && inode == journal->j_inode)
 		return 0;
 
 	while (bref < p+max) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ffa6aa55a1a7..487d9aec56c9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -383,10 +383,11 @@ static int __check_block_validity(struct inode *inode, const char *func,
 				unsigned int line,
 				struct ext4_map_blocks *map)
 {
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+
+	if (journal && inode == journal->j_inode)
 		return 0;
+
 	if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
 		ext4_error_inode(inode, func, line, map->m_pblk,
 				 "lblock %lu mapped to illegal pblock %llu "
@@ -5467,7 +5468,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			    oldsize & (inode->i_sb->s_blocksize - 1)) {
 				error = ext4_inode_attach_jinode(inode);
 				if (error)
-					goto err_out;
+					goto out_mmap_sem;
 			}
 
 			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1bad460275eb..d4b990938399 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -263,7 +263,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		}
 
 		/* truncate len if we find any trailing uptodate block(s) */
-		for ( ; i <= last; i++) {
+		while (++i <= last) {
 			if (ifs_block_is_uptodate(ifs, i)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
diff --git a/fs/namespace.c b/fs/namespace.c
index f898de3a6f70..bd601ab26e78 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2596,56 +2596,62 @@ static struct mountpoint *do_lock_mount(struct path *path, bool beneath)
 	struct vfsmount *mnt = path->mnt;
 	struct dentry *dentry;
 	struct mountpoint *mp = ERR_PTR(-ENOENT);
+	struct path under = {};
 
 	for (;;) {
-		struct mount *m;
+		struct mount *m = real_mount(mnt);
 
 		if (beneath) {
-			m = real_mount(mnt);
+			path_put(&under);
 			read_seqlock_excl(&mount_lock);
-			dentry = dget(m->mnt_mountpoint);
+			under.mnt = mntget(&m->mnt_parent->mnt);
+			under.dentry = dget(m->mnt_mountpoint);
 			read_sequnlock_excl(&mount_lock);
+			dentry = under.dentry;
 		} else {
 			dentry = path->dentry;
 		}
 
 		inode_lock(dentry->d_inode);
-		if (unlikely(cant_mount(dentry))) {
-			inode_unlock(dentry->d_inode);
-			goto out;
-		}
-
 		namespace_lock();
 
-		if (beneath && (!is_mounted(mnt) || m->mnt_mountpoint != dentry)) {
+		if (unlikely(cant_mount(dentry) || !is_mounted(mnt)))
+			break;		// not to be mounted on
+
+		if (beneath && unlikely(m->mnt_mountpoint != dentry ||
+				        &m->mnt_parent->mnt != under.mnt)) {
 			namespace_unlock();
 			inode_unlock(dentry->d_inode);
-			goto out;
+			continue;	// got moved
 		}
 
 		mnt = lookup_mnt(path);
-		if (likely(!mnt))
+		if (unlikely(mnt)) {
+			namespace_unlock();
+			inode_unlock(dentry->d_inode);
+			path_put(path);
+			path->mnt = mnt;
+			path->dentry = dget(mnt->mnt_root);
+			continue;	// got overmounted
+		}
+		mp = get_mountpoint(dentry);
+		if (IS_ERR(mp))
 			break;
-
-		namespace_unlock();
-		inode_unlock(dentry->d_inode);
-		if (beneath)
-			dput(dentry);
-		path_put(path);
-		path->mnt = mnt;
-		path->dentry = dget(mnt->mnt_root);
-	}
-
-	mp = get_mountpoint(dentry);
-	if (IS_ERR(mp)) {
-		namespace_unlock();
-		inode_unlock(dentry->d_inode);
+		if (beneath) {
+			/*
+			 * @under duplicates the references that will stay
+			 * at least until namespace_unlock(), so the path_put()
+			 * below is safe (and OK to do under namespace_lock -
+			 * we are not dropping the final references here).
+			 */
+			path_put(&under);
+		}
+		return mp;
 	}
-
-out:
+	namespace_unlock();
+	inode_unlock(dentry->d_inode);
 	if (beneath)
-		dput(dentry);
-
+		path_put(&under);
 	return mp;
 }
 
@@ -2656,14 +2662,11 @@ static inline struct mountpoint *lock_mount(struct path *path)
 
 static void unlock_mount(struct mountpoint *where)
 {
-	struct dentry *dentry = where->m_dentry;
-
+	inode_unlock(where->m_dentry->d_inode);
 	read_seqlock_excl(&mount_lock);
 	put_mountpoint(where);
 	read_sequnlock_excl(&mount_lock);
-
 	namespace_unlock();
-	inode_unlock(dentry->d_inode);
 }
 
 static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 6c7be1377ee0..3a8433e802cc 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -125,11 +125,13 @@ static int __init netfs_init(void)
 	if (mempool_init_slab_pool(&netfs_subrequest_pool, 100, netfs_subrequest_slab) < 0)
 		goto error_subreqpool;
 
+#ifdef CONFIG_PROC_FS
 	if (!proc_mkdir("fs/netfs", NULL))
 		goto error_proc;
 	if (!proc_create_seq("fs/netfs/requests", S_IFREG | 0444, NULL,
 			     &netfs_requests_seq_ops))
 		goto error_procfile;
+#endif
 #ifdef CONFIG_FSCACHE_STATS
 	if (!proc_create_single("fs/netfs/stats", S_IFREG | 0444, NULL,
 				netfs_stats_show))
@@ -142,9 +144,11 @@ static int __init netfs_init(void)
 	return 0;
 
 error_fscache:
+#ifdef CONFIG_PROC_FS
 error_procfile:
 	remove_proc_subtree("fs/netfs", NULL);
 error_proc:
+#endif
 	mempool_exit(&netfs_subrequest_pool);
 error_subreqpool:
 	kmem_cache_destroy(netfs_subrequest_slab);
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 7976ac4611c8..748c4be912db 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -428,6 +428,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 	}
 
 	if (extend_init && !is_compressed(ni)) {
+		WARN_ON(ni->i_valid >= pos);
 		err = ntfs_extend_initialized_size(file, ni, ni->i_valid, pos);
 		if (err)
 			goto out;
@@ -1238,21 +1239,22 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret;
 	int err;
 
-	err = check_write_restriction(inode);
-	if (err)
-		return err;
-
-	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
-		ntfs_inode_warn(inode, "direct i/o + compressed not supported");
-		return -EOPNOTSUPP;
-	}
-
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			return -EAGAIN;
 		inode_lock(inode);
 	}
 
+	ret = check_write_restriction(inode);
+	if (ret)
+		goto out;
+
+	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
+		ntfs_inode_warn(inode, "direct i/o + compressed not supported");
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	ret = generic_write_checks(iocb, from);
 	if (ret <= 0)
 		goto out;
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 2426fa740517..9b32f7821b71 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -707,6 +707,22 @@ unicode_oslm_strings(char **pbcc_area, const struct nls_table *nls_cp)
 	*pbcc_area = bcc_ptr;
 }
 
+static void
+ascii_oslm_strings(char **pbcc_area, const struct nls_table *nls_cp)
+{
+	char *bcc_ptr = *pbcc_area;
+
+	strcpy(bcc_ptr, "Linux version ");
+	bcc_ptr += strlen("Linux version ");
+	strcpy(bcc_ptr, init_utsname()->release);
+	bcc_ptr += strlen(init_utsname()->release) + 1;
+
+	strcpy(bcc_ptr, CIFS_NETWORK_OPSYS);
+	bcc_ptr += strlen(CIFS_NETWORK_OPSYS) + 1;
+
+	*pbcc_area = bcc_ptr;
+}
+
 static void unicode_domain_string(char **pbcc_area, struct cifs_ses *ses,
 				   const struct nls_table *nls_cp)
 {
@@ -731,6 +747,25 @@ static void unicode_domain_string(char **pbcc_area, struct cifs_ses *ses,
 	*pbcc_area = bcc_ptr;
 }
 
+static void ascii_domain_string(char **pbcc_area, struct cifs_ses *ses,
+				const struct nls_table *nls_cp)
+{
+	char *bcc_ptr = *pbcc_area;
+	int len;
+
+	/* copy domain */
+	if (ses->domainName != NULL) {
+		len = strscpy(bcc_ptr, ses->domainName, CIFS_MAX_DOMAINNAME_LEN);
+		if (WARN_ON_ONCE(len < 0))
+			len = CIFS_MAX_DOMAINNAME_LEN - 1;
+		bcc_ptr += len;
+	} /* else we send a null domain name so server will default to its own domain */
+	*bcc_ptr = 0;
+	bcc_ptr++;
+
+	*pbcc_area = bcc_ptr;
+}
+
 static void unicode_ssetup_strings(char **pbcc_area, struct cifs_ses *ses,
 				   const struct nls_table *nls_cp)
 {
@@ -776,25 +811,10 @@ static void ascii_ssetup_strings(char **pbcc_area, struct cifs_ses *ses,
 	*bcc_ptr = 0;
 	bcc_ptr++; /* account for null termination */
 
-	/* copy domain */
-	if (ses->domainName != NULL) {
-		len = strscpy(bcc_ptr, ses->domainName, CIFS_MAX_DOMAINNAME_LEN);
-		if (WARN_ON_ONCE(len < 0))
-			len = CIFS_MAX_DOMAINNAME_LEN - 1;
-		bcc_ptr += len;
-	} /* else we send a null domain name so server will default to its own domain */
-	*bcc_ptr = 0;
-	bcc_ptr++;
-
 	/* BB check for overflow here */
 
-	strcpy(bcc_ptr, "Linux version ");
-	bcc_ptr += strlen("Linux version ");
-	strcpy(bcc_ptr, init_utsname()->release);
-	bcc_ptr += strlen(init_utsname()->release) + 1;
-
-	strcpy(bcc_ptr, CIFS_NETWORK_OPSYS);
-	bcc_ptr += strlen(CIFS_NETWORK_OPSYS) + 1;
+	ascii_domain_string(&bcc_ptr, ses, nls_cp);
+	ascii_oslm_strings(&bcc_ptr, nls_cp);
 
 	*pbcc_area = bcc_ptr;
 }
@@ -1597,7 +1617,7 @@ sess_auth_kerberos(struct sess_data *sess_data)
 	sess_data->iov[1].iov_len = msg->secblob_len;
 	pSMB->req.SecurityBlobLength = cpu_to_le16(sess_data->iov[1].iov_len);
 
-	if (ses->capabilities & CAP_UNICODE) {
+	if (pSMB->req.hdr.Flags2 & SMBFLG2_UNICODE) {
 		/* unicode strings must be word aligned */
 		if (!IS_ALIGNED(sess_data->iov[0].iov_len + sess_data->iov[1].iov_len, 2)) {
 			*bcc_ptr = 0;
@@ -1606,8 +1626,8 @@ sess_auth_kerberos(struct sess_data *sess_data)
 		unicode_oslm_strings(&bcc_ptr, sess_data->nls_cp);
 		unicode_domain_string(&bcc_ptr, ses, sess_data->nls_cp);
 	} else {
-		/* BB: is this right? */
-		ascii_ssetup_strings(&bcc_ptr, ses, sess_data->nls_cp);
+		ascii_oslm_strings(&bcc_ptr, sess_data->nls_cp);
+		ascii_domain_string(&bcc_ptr, ses, sess_data->nls_cp);
 	}
 
 	sess_data->iov[2].iov_len = (long) bcc_ptr -
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index bd791aa54681..55cceb822932 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -597,6 +597,42 @@ static int cifs_query_path_info(const unsigned int xid,
 			CIFSSMBClose(xid, tcon, fid.netfid);
 	}
 
+#ifdef CONFIG_CIFS_XATTR
+	/*
+	 * For WSL CHR and BLK reparse points it is required to fetch
+	 * EA $LXDEV which contains major and minor device numbers.
+	 */
+	if (!rc && data->reparse_point) {
+		struct smb2_file_full_ea_info *ea;
+
+		ea = (struct smb2_file_full_ea_info *)data->wsl.eas;
+		rc = CIFSSMBQAllEAs(xid, tcon, full_path, SMB2_WSL_XATTR_DEV,
+				    &ea->ea_data[SMB2_WSL_XATTR_NAME_LEN + 1],
+				    SMB2_WSL_XATTR_DEV_SIZE, cifs_sb);
+		if (rc == SMB2_WSL_XATTR_DEV_SIZE) {
+			ea->next_entry_offset = cpu_to_le32(0);
+			ea->flags = 0;
+			ea->ea_name_length = SMB2_WSL_XATTR_NAME_LEN;
+			ea->ea_value_length = cpu_to_le16(SMB2_WSL_XATTR_DEV_SIZE);
+			memcpy(&ea->ea_data[0], SMB2_WSL_XATTR_DEV, SMB2_WSL_XATTR_NAME_LEN + 1);
+			data->wsl.eas_len = sizeof(*ea) + SMB2_WSL_XATTR_NAME_LEN + 1 +
+					    SMB2_WSL_XATTR_DEV_SIZE;
+			rc = 0;
+		} else if (rc >= 0) {
+			/* It is an error if EA $LXDEV has wrong size. */
+			rc = -EINVAL;
+		} else {
+			/*
+			 * In all other cases ignore error if fetching
+			 * of EA $LXDEV failed. It is needed only for
+			 * WSL CHR and BLK reparse points and wsl_to_fattr()
+			 * handle the case when EA is missing.
+			 */
+			rc = 0;
+		}
+	}
+#endif
+
 	return rc;
 }
 
diff --git a/fs/smb/server/asn1.c b/fs/smb/server/asn1.c
index b931a99ab9c8..5c4c5121fece 100644
--- a/fs/smb/server/asn1.c
+++ b/fs/smb/server/asn1.c
@@ -104,7 +104,7 @@ int build_spnego_ntlmssp_neg_blob(unsigned char **pbuffer, u16 *buflen,
 			oid_len + ntlmssp_len) * 2 +
 			neg_result_len + oid_len + ntlmssp_len;
 
-	buf = kmalloc(total_len, GFP_KERNEL);
+	buf = kmalloc(total_len, KSMBD_DEFAULT_GFP);
 	if (!buf)
 		return -ENOMEM;
 
@@ -140,7 +140,7 @@ int build_spnego_ntlmssp_auth_blob(unsigned char **pbuffer, u16 *buflen,
 	int total_len = 4 + compute_asn_hdr_len_bytes(neg_result_len) * 2 +
 		neg_result_len;
 
-	buf = kmalloc(total_len, GFP_KERNEL);
+	buf = kmalloc(total_len, KSMBD_DEFAULT_GFP);
 	if (!buf)
 		return -ENOMEM;
 
@@ -217,7 +217,7 @@ static int ksmbd_neg_token_alloc(void *context, size_t hdrlen,
 	if (!vlen)
 		return -EINVAL;
 
-	conn->mechToken = kmemdup_nul(value, vlen, GFP_KERNEL);
+	conn->mechToken = kmemdup_nul(value, vlen, KSMBD_DEFAULT_GFP);
 	if (!conn->mechToken)
 		return -ENOMEM;
 
diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 954497513683..83caa3849749 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -151,7 +151,7 @@ static int calc_ntlmv2_hash(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 
 	/* convert user_name to unicode */
 	len = strlen(user_name(sess->user));
-	uniname = kzalloc(2 + UNICODE_LEN(len), GFP_KERNEL);
+	uniname = kzalloc(2 + UNICODE_LEN(len), KSMBD_DEFAULT_GFP);
 	if (!uniname) {
 		ret = -ENOMEM;
 		goto out;
@@ -175,7 +175,7 @@ static int calc_ntlmv2_hash(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 
 	/* Convert domain name or conn name to unicode and uppercase */
 	len = strlen(dname);
-	domain = kzalloc(2 + UNICODE_LEN(len), GFP_KERNEL);
+	domain = kzalloc(2 + UNICODE_LEN(len), KSMBD_DEFAULT_GFP);
 	if (!domain) {
 		ret = -ENOMEM;
 		goto out;
@@ -254,7 +254,7 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 	}
 
 	len = CIFS_CRYPTO_KEY_SIZE + blen;
-	construct = kzalloc(len, GFP_KERNEL);
+	construct = kzalloc(len, KSMBD_DEFAULT_GFP);
 	if (!construct) {
 		rc = -ENOMEM;
 		goto out;
@@ -361,7 +361,7 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
 		if (sess_key_len > CIFS_KEY_SIZE)
 			return -EINVAL;
 
-		ctx_arc4 = kmalloc(sizeof(*ctx_arc4), GFP_KERNEL);
+		ctx_arc4 = kmalloc(sizeof(*ctx_arc4), KSMBD_DEFAULT_GFP);
 		if (!ctx_arc4)
 			return -ENOMEM;
 
@@ -451,7 +451,7 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 
 	chgblob->NegotiateFlags = cpu_to_le32(flags);
 	len = strlen(ksmbd_netbios_name());
-	name = kmalloc(2 + UNICODE_LEN(len), GFP_KERNEL);
+	name = kmalloc(2 + UNICODE_LEN(len), KSMBD_DEFAULT_GFP);
 	if (!name)
 		return -ENOMEM;
 
@@ -1045,7 +1045,7 @@ static struct scatterlist *ksmbd_init_sg(struct kvec *iov, unsigned int nvec,
 	if (!nvec)
 		return NULL;
 
-	nr_entries = kcalloc(nvec, sizeof(int), GFP_KERNEL);
+	nr_entries = kcalloc(nvec, sizeof(int), KSMBD_DEFAULT_GFP);
 	if (!nr_entries)
 		return NULL;
 
@@ -1065,7 +1065,8 @@ static struct scatterlist *ksmbd_init_sg(struct kvec *iov, unsigned int nvec,
 	/* Add two entries for transform header and signature */
 	total_entries += 2;
 
-	sg = kmalloc_array(total_entries, sizeof(struct scatterlist), GFP_KERNEL);
+	sg = kmalloc_array(total_entries, sizeof(struct scatterlist),
+			   KSMBD_DEFAULT_GFP);
 	if (!sg) {
 		kfree(nr_entries);
 		return NULL;
@@ -1165,7 +1166,7 @@ int ksmbd_crypt_message(struct ksmbd_work *work, struct kvec *iov,
 		goto free_ctx;
 	}
 
-	req = aead_request_alloc(tfm, GFP_KERNEL);
+	req = aead_request_alloc(tfm, KSMBD_DEFAULT_GFP);
 	if (!req) {
 		rc = -ENOMEM;
 		goto free_ctx;
@@ -1184,7 +1185,7 @@ int ksmbd_crypt_message(struct ksmbd_work *work, struct kvec *iov,
 	}
 
 	iv_len = crypto_aead_ivsize(tfm);
-	iv = kzalloc(iv_len, GFP_KERNEL);
+	iv = kzalloc(iv_len, KSMBD_DEFAULT_GFP);
 	if (!iv) {
 		rc = -ENOMEM;
 		goto free_sg;
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index ab11246ccd8a..7aaea71a4f20 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -39,8 +39,10 @@ void ksmbd_conn_free(struct ksmbd_conn *conn)
 	xa_destroy(&conn->sessions);
 	kvfree(conn->request_buf);
 	kfree(conn->preauth_info);
-	if (atomic_dec_and_test(&conn->refcnt))
+	if (atomic_dec_and_test(&conn->refcnt)) {
+		ksmbd_free_transport(conn->transport);
 		kfree(conn);
+	}
 }
 
 /**
@@ -52,7 +54,7 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 {
 	struct ksmbd_conn *conn;
 
-	conn = kzalloc(sizeof(struct ksmbd_conn), GFP_KERNEL);
+	conn = kzalloc(sizeof(struct ksmbd_conn), KSMBD_DEFAULT_GFP);
 	if (!conn)
 		return NULL;
 
@@ -369,7 +371,7 @@ int ksmbd_conn_handler_loop(void *p)
 		/* 4 for rfc1002 length field */
 		/* 1 for implied bcc[0] */
 		size = pdu_size + 4 + 1;
-		conn->request_buf = kvmalloc(size, GFP_KERNEL);
+		conn->request_buf = kvmalloc(size, KSMBD_DEFAULT_GFP);
 		if (!conn->request_buf)
 			break;
 
diff --git a/fs/smb/server/crypto_ctx.c b/fs/smb/server/crypto_ctx.c
index 81488d04199d..ce733dc9a4a3 100644
--- a/fs/smb/server/crypto_ctx.c
+++ b/fs/smb/server/crypto_ctx.c
@@ -89,7 +89,7 @@ static struct shash_desc *alloc_shash_desc(int id)
 		return NULL;
 
 	shash = kzalloc(sizeof(*shash) + crypto_shash_descsize(tfm),
-			GFP_KERNEL);
+			KSMBD_DEFAULT_GFP);
 	if (!shash)
 		crypto_free_shash(tfm);
 	else
@@ -133,7 +133,7 @@ static struct ksmbd_crypto_ctx *ksmbd_find_crypto_ctx(void)
 		ctx_list.avail_ctx++;
 		spin_unlock(&ctx_list.ctx_lock);
 
-		ctx = kzalloc(sizeof(struct ksmbd_crypto_ctx), GFP_KERNEL);
+		ctx = kzalloc(sizeof(struct ksmbd_crypto_ctx), KSMBD_DEFAULT_GFP);
 		if (!ctx) {
 			spin_lock(&ctx_list.ctx_lock);
 			ctx_list.avail_ctx--;
@@ -258,7 +258,7 @@ int ksmbd_crypto_create(void)
 	init_waitqueue_head(&ctx_list.ctx_wait);
 	ctx_list.avail_ctx = 1;
 
-	ctx = kzalloc(sizeof(struct ksmbd_crypto_ctx), GFP_KERNEL);
+	ctx = kzalloc(sizeof(struct ksmbd_crypto_ctx), KSMBD_DEFAULT_GFP);
 	if (!ctx)
 		return -ENOMEM;
 	list_add(&ctx->list, &ctx_list.idle_ctx);
diff --git a/fs/smb/server/glob.h b/fs/smb/server/glob.h
index d528b20b37a8..4ea187af2348 100644
--- a/fs/smb/server/glob.h
+++ b/fs/smb/server/glob.h
@@ -44,4 +44,6 @@ extern int ksmbd_debug_types;
 
 #define UNICODE_LEN(x)		((x) * 2)
 
+#define KSMBD_DEFAULT_GFP	(GFP_KERNEL | __GFP_RETRY_MAYFAIL)
+
 #endif /* __KSMBD_GLOB_H */
diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index 3d01d9d15293..3f07a612c05b 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -111,7 +111,8 @@ struct ksmbd_startup_request {
 	__u32	smb2_max_credits;	/* MAX credits */
 	__u32	smbd_max_io_size;	/* smbd read write size */
 	__u32	max_connections;	/* Number of maximum simultaneous connections */
-	__u32	reserved[126];		/* Reserved room */
+	__s8	bind_interfaces_only;
+	__s8	reserved[503];		/* Reserved room */
 	__u32	ifc_list_sz;		/* interfaces list size */
 	__s8	____payload[];
 };
diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
index 544d8ccd29b0..72b00ca6e455 100644
--- a/fs/smb/server/ksmbd_work.c
+++ b/fs/smb/server/ksmbd_work.c
@@ -18,7 +18,7 @@ static struct workqueue_struct *ksmbd_wq;
 
 struct ksmbd_work *ksmbd_alloc_work_struct(void)
 {
-	struct ksmbd_work *work = kmem_cache_zalloc(work_cache, GFP_KERNEL);
+	struct ksmbd_work *work = kmem_cache_zalloc(work_cache, KSMBD_DEFAULT_GFP);
 
 	if (work) {
 		work->compound_fid = KSMBD_NO_FID;
@@ -29,7 +29,7 @@ struct ksmbd_work *ksmbd_alloc_work_struct(void)
 		INIT_LIST_HEAD(&work->aux_read_list);
 		work->iov_alloc_cnt = 4;
 		work->iov = kcalloc(work->iov_alloc_cnt, sizeof(struct kvec),
-				    GFP_KERNEL);
+				    KSMBD_DEFAULT_GFP);
 		if (!work->iov) {
 			kmem_cache_free(work_cache, work);
 			work = NULL;
@@ -111,7 +111,7 @@ static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
 
 	if (aux_size) {
 		need_iov_cnt++;
-		ar = kmalloc(sizeof(struct aux_read), GFP_KERNEL);
+		ar = kmalloc(sizeof(struct aux_read), KSMBD_DEFAULT_GFP);
 		if (!ar)
 			return -ENOMEM;
 	}
@@ -122,7 +122,7 @@ static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
 		work->iov_alloc_cnt += 4;
 		new = krealloc(work->iov,
 			       sizeof(struct kvec) * work->iov_alloc_cnt,
-			       GFP_KERNEL | __GFP_ZERO);
+			       KSMBD_DEFAULT_GFP | __GFP_ZERO);
 		if (!new) {
 			kfree(ar);
 			work->iov_alloc_cnt -= 4;
@@ -166,7 +166,7 @@ int ksmbd_iov_pin_rsp_read(struct ksmbd_work *work, void *ib, int len,
 
 int allocate_interim_rsp_buf(struct ksmbd_work *work)
 {
-	work->response_buf = kzalloc(MAX_CIFS_SMALL_BUFFER_SIZE, GFP_KERNEL);
+	work->response_buf = kzalloc(MAX_CIFS_SMALL_BUFFER_SIZE, KSMBD_DEFAULT_GFP);
 	if (!work->response_buf)
 		return -ENOMEM;
 	work->response_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
diff --git a/fs/smb/server/mgmt/ksmbd_ida.c b/fs/smb/server/mgmt/ksmbd_ida.c
index a18e27e9e0cd..0e2ae994ab52 100644
--- a/fs/smb/server/mgmt/ksmbd_ida.c
+++ b/fs/smb/server/mgmt/ksmbd_ida.c
@@ -4,31 +4,32 @@
  */
 
 #include "ksmbd_ida.h"
+#include "../glob.h"
 
 int ksmbd_acquire_smb2_tid(struct ida *ida)
 {
-	return ida_alloc_range(ida, 1, 0xFFFFFFFE, GFP_KERNEL);
+	return ida_alloc_range(ida, 1, 0xFFFFFFFE, KSMBD_DEFAULT_GFP);
 }
 
 int ksmbd_acquire_smb2_uid(struct ida *ida)
 {
 	int id;
 
-	id = ida_alloc_min(ida, 1, GFP_KERNEL);
+	id = ida_alloc_min(ida, 1, KSMBD_DEFAULT_GFP);
 	if (id == 0xFFFE)
-		id = ida_alloc_min(ida, 1, GFP_KERNEL);
+		id = ida_alloc_min(ida, 1, KSMBD_DEFAULT_GFP);
 
 	return id;
 }
 
 int ksmbd_acquire_async_msg_id(struct ida *ida)
 {
-	return ida_alloc_min(ida, 1, GFP_KERNEL);
+	return ida_alloc_min(ida, 1, KSMBD_DEFAULT_GFP);
 }
 
 int ksmbd_acquire_id(struct ida *ida)
 {
-	return ida_alloc(ida, GFP_KERNEL);
+	return ida_alloc(ida, KSMBD_DEFAULT_GFP);
 }
 
 void ksmbd_release_id(struct ida *ida, int id)
diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index d8d03070ae44..d3d5f99bdd34 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -102,11 +102,11 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 		if (!sz)
 			break;
 
-		p = kzalloc(sizeof(struct ksmbd_veto_pattern), GFP_KERNEL);
+		p = kzalloc(sizeof(struct ksmbd_veto_pattern), KSMBD_DEFAULT_GFP);
 		if (!p)
 			return -ENOMEM;
 
-		p->pattern = kstrdup(veto_list, GFP_KERNEL);
+		p->pattern = kstrdup(veto_list, KSMBD_DEFAULT_GFP);
 		if (!p->pattern) {
 			kfree(p);
 			return -ENOMEM;
@@ -150,14 +150,14 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 			goto out;
 	}
 
-	share = kzalloc(sizeof(struct ksmbd_share_config), GFP_KERNEL);
+	share = kzalloc(sizeof(struct ksmbd_share_config), KSMBD_DEFAULT_GFP);
 	if (!share)
 		goto out;
 
 	share->flags = resp->flags;
 	atomic_set(&share->refcount, 1);
 	INIT_LIST_HEAD(&share->veto_list);
-	share->name = kstrdup(name, GFP_KERNEL);
+	share->name = kstrdup(name, KSMBD_DEFAULT_GFP);
 
 	if (!test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
 		int path_len = PATH_MAX;
@@ -166,7 +166,7 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 			path_len = resp->payload_sz - resp->veto_list_sz;
 
 		share->path = kstrndup(ksmbd_share_config_path(resp), path_len,
-				      GFP_KERNEL);
+				      KSMBD_DEFAULT_GFP);
 		if (share->path) {
 			share->path_sz = strlen(share->path);
 			while (share->path_sz > 1 &&
diff --git a/fs/smb/server/mgmt/tree_connect.c b/fs/smb/server/mgmt/tree_connect.c
index 94a52a75014a..ecfc57508671 100644
--- a/fs/smb/server/mgmt/tree_connect.c
+++ b/fs/smb/server/mgmt/tree_connect.c
@@ -31,7 +31,8 @@ ksmbd_tree_conn_connect(struct ksmbd_work *work, const char *share_name)
 	if (!sc)
 		return status;
 
-	tree_conn = kzalloc(sizeof(struct ksmbd_tree_connect), GFP_KERNEL);
+	tree_conn = kzalloc(sizeof(struct ksmbd_tree_connect),
+			    KSMBD_DEFAULT_GFP);
 	if (!tree_conn) {
 		status.ret = -ENOMEM;
 		goto out_error;
@@ -80,7 +81,7 @@ ksmbd_tree_conn_connect(struct ksmbd_work *work, const char *share_name)
 	init_waitqueue_head(&tree_conn->refcount_q);
 
 	ret = xa_err(xa_store(&sess->tree_conns, tree_conn->id, tree_conn,
-			      GFP_KERNEL));
+			      KSMBD_DEFAULT_GFP));
 	if (ret) {
 		status.ret = -ENOMEM;
 		goto out_error;
diff --git a/fs/smb/server/mgmt/user_config.c b/fs/smb/server/mgmt/user_config.c
index 421a4a95e216..56c9a38ca878 100644
--- a/fs/smb/server/mgmt/user_config.c
+++ b/fs/smb/server/mgmt/user_config.c
@@ -36,16 +36,16 @@ struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp,
 {
 	struct ksmbd_user *user;
 
-	user = kmalloc(sizeof(struct ksmbd_user), GFP_KERNEL);
+	user = kmalloc(sizeof(struct ksmbd_user), KSMBD_DEFAULT_GFP);
 	if (!user)
 		return NULL;
 
-	user->name = kstrdup(resp->account, GFP_KERNEL);
+	user->name = kstrdup(resp->account, KSMBD_DEFAULT_GFP);
 	user->flags = resp->status;
 	user->gid = resp->gid;
 	user->uid = resp->uid;
 	user->passkey_sz = resp->hash_sz;
-	user->passkey = kmalloc(resp->hash_sz, GFP_KERNEL);
+	user->passkey = kmalloc(resp->hash_sz, KSMBD_DEFAULT_GFP);
 	if (user->passkey)
 		memcpy(user->passkey, resp->hash, resp->hash_sz);
 
@@ -64,7 +64,7 @@ struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp,
 
 		user->sgid = kmemdup(resp_ext->____payload,
 				     resp_ext->ngroups * sizeof(gid_t),
-				     GFP_KERNEL);
+				     KSMBD_DEFAULT_GFP);
 		if (!user->sgid)
 			goto err_free;
 
diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index f83daf72f877..3f45f28f6f0f 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -98,7 +98,7 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 	if (!method)
 		return -EINVAL;
 
-	entry = kzalloc(sizeof(struct ksmbd_session_rpc), GFP_KERNEL);
+	entry = kzalloc(sizeof(struct ksmbd_session_rpc), KSMBD_DEFAULT_GFP);
 	if (!entry)
 		return -ENOMEM;
 
@@ -106,7 +106,7 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 	entry->id = ksmbd_ipc_id_alloc();
 	if (entry->id < 0)
 		goto free_entry;
-	old = xa_store(&sess->rpc_handle_list, entry->id, entry, GFP_KERNEL);
+	old = xa_store(&sess->rpc_handle_list, entry->id, entry, KSMBD_DEFAULT_GFP);
 	if (xa_is_err(old))
 		goto free_id;
 
@@ -201,7 +201,7 @@ int ksmbd_session_register(struct ksmbd_conn *conn,
 	sess->dialect = conn->dialect;
 	memcpy(sess->ClientGUID, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
 	ksmbd_expire_session(conn);
-	return xa_err(xa_store(&conn->sessions, sess->id, sess, GFP_KERNEL));
+	return xa_err(xa_store(&conn->sessions, sess->id, sess, KSMBD_DEFAULT_GFP));
 }
 
 static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
@@ -339,7 +339,7 @@ struct preauth_session *ksmbd_preauth_session_alloc(struct ksmbd_conn *conn,
 {
 	struct preauth_session *sess;
 
-	sess = kmalloc(sizeof(struct preauth_session), GFP_KERNEL);
+	sess = kmalloc(sizeof(struct preauth_session), KSMBD_DEFAULT_GFP);
 	if (!sess)
 		return NULL;
 
@@ -423,7 +423,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	if (protocol != CIFDS_SESSION_FLAG_SMB2)
 		return NULL;
 
-	sess = kzalloc(sizeof(struct ksmbd_session), GFP_KERNEL);
+	sess = kzalloc(sizeof(struct ksmbd_session), KSMBD_DEFAULT_GFP);
 	if (!sess)
 		return NULL;
 
diff --git a/fs/smb/server/misc.c b/fs/smb/server/misc.c
index 1a5faa6f6e7b..cb2a11ffb23f 100644
--- a/fs/smb/server/misc.c
+++ b/fs/smb/server/misc.c
@@ -165,7 +165,7 @@ char *convert_to_nt_pathname(struct ksmbd_share_config *share,
 	char *pathname, *ab_pathname, *nt_pathname;
 	int share_path_len = share->path_sz;
 
-	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	pathname = kmalloc(PATH_MAX, KSMBD_DEFAULT_GFP);
 	if (!pathname)
 		return ERR_PTR(-EACCES);
 
@@ -180,7 +180,8 @@ char *convert_to_nt_pathname(struct ksmbd_share_config *share,
 		goto free_pathname;
 	}
 
-	nt_pathname = kzalloc(strlen(&ab_pathname[share_path_len]) + 2, GFP_KERNEL);
+	nt_pathname = kzalloc(strlen(&ab_pathname[share_path_len]) + 2,
+			      KSMBD_DEFAULT_GFP);
 	if (!nt_pathname) {
 		nt_pathname = ERR_PTR(-ENOMEM);
 		goto free_pathname;
@@ -232,7 +233,7 @@ char *ksmbd_casefold_sharename(struct unicode_map *um, const char *name)
 	char *cf_name;
 	int cf_len;
 
-	cf_name = kzalloc(KSMBD_REQ_MAX_SHARE_NAME, GFP_KERNEL);
+	cf_name = kzalloc(KSMBD_REQ_MAX_SHARE_NAME, KSMBD_DEFAULT_GFP);
 	if (!cf_name)
 		return ERR_PTR(-ENOMEM);
 
@@ -294,7 +295,7 @@ char *convert_to_unix_name(struct ksmbd_share_config *share, const char *name)
 
 	path_len = share->path_sz;
 	name_len = strlen(name);
-	new_name = kmalloc(path_len + name_len + 2, GFP_KERNEL);
+	new_name = kmalloc(path_len + name_len + 2, KSMBD_DEFAULT_GFP);
 	if (!new_name)
 		return new_name;
 
@@ -320,7 +321,7 @@ char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
 	if (!sz)
 		return NULL;
 
-	conv = kmalloc(sz, GFP_KERNEL);
+	conv = kmalloc(sz, KSMBD_DEFAULT_GFP);
 	if (!conv)
 		return NULL;
 
diff --git a/fs/smb/server/ndr.c b/fs/smb/server/ndr.c
index 3507d8f89074..58d71560f626 100644
--- a/fs/smb/server/ndr.c
+++ b/fs/smb/server/ndr.c
@@ -18,7 +18,7 @@ static int try_to_realloc_ndr_blob(struct ndr *n, size_t sz)
 {
 	char *data;
 
-	data = krealloc(n->data, n->offset + sz + 1024, GFP_KERNEL);
+	data = krealloc(n->data, n->offset + sz + 1024, KSMBD_DEFAULT_GFP);
 	if (!data)
 		return -ENOMEM;
 
@@ -174,7 +174,7 @@ int ndr_encode_dos_attr(struct ndr *n, struct xattr_dos_attrib *da)
 
 	n->offset = 0;
 	n->length = 1024;
-	n->data = kzalloc(n->length, GFP_KERNEL);
+	n->data = kzalloc(n->length, KSMBD_DEFAULT_GFP);
 	if (!n->data)
 		return -ENOMEM;
 
@@ -350,7 +350,7 @@ int ndr_encode_posix_acl(struct ndr *n,
 
 	n->offset = 0;
 	n->length = 1024;
-	n->data = kzalloc(n->length, GFP_KERNEL);
+	n->data = kzalloc(n->length, KSMBD_DEFAULT_GFP);
 	if (!n->data)
 		return -ENOMEM;
 
@@ -401,7 +401,7 @@ int ndr_encode_v4_ntacl(struct ndr *n, struct xattr_ntacl *acl)
 
 	n->offset = 0;
 	n->length = 2048;
-	n->data = kzalloc(n->length, GFP_KERNEL);
+	n->data = kzalloc(n->length, KSMBD_DEFAULT_GFP);
 	if (!n->data)
 		return -ENOMEM;
 
@@ -505,7 +505,7 @@ int ndr_decode_v4_ntacl(struct ndr *n, struct xattr_ntacl *acl)
 		return ret;
 
 	acl->sd_size = n->length - n->offset;
-	acl->sd_buf = kzalloc(acl->sd_size, GFP_KERNEL);
+	acl->sd_buf = kzalloc(acl->sd_size, KSMBD_DEFAULT_GFP);
 	if (!acl->sd_buf)
 		return -ENOMEM;
 
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index e2ba0dadb5fb..81a29857b1e3 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -34,7 +34,7 @@ static struct oplock_info *alloc_opinfo(struct ksmbd_work *work,
 	struct ksmbd_session *sess = work->sess;
 	struct oplock_info *opinfo;
 
-	opinfo = kzalloc(sizeof(struct oplock_info), GFP_KERNEL);
+	opinfo = kzalloc(sizeof(struct oplock_info), KSMBD_DEFAULT_GFP);
 	if (!opinfo)
 		return NULL;
 
@@ -93,7 +93,7 @@ static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *lctx)
 {
 	struct lease *lease;
 
-	lease = kmalloc(sizeof(struct lease), GFP_KERNEL);
+	lease = kmalloc(sizeof(struct lease), KSMBD_DEFAULT_GFP);
 	if (!lease)
 		return -ENOMEM;
 
@@ -701,7 +701,7 @@ static int smb2_oplock_break_noti(struct oplock_info *opinfo)
 	if (!work)
 		return -ENOMEM;
 
-	br_info = kmalloc(sizeof(struct oplock_break_info), GFP_KERNEL);
+	br_info = kmalloc(sizeof(struct oplock_break_info), KSMBD_DEFAULT_GFP);
 	if (!br_info) {
 		ksmbd_free_work_struct(work);
 		return -ENOMEM;
@@ -806,7 +806,7 @@ static int smb2_lease_break_noti(struct oplock_info *opinfo)
 	if (!work)
 		return -ENOMEM;
 
-	br_info = kmalloc(sizeof(struct lease_break_info), GFP_KERNEL);
+	br_info = kmalloc(sizeof(struct lease_break_info), KSMBD_DEFAULT_GFP);
 	if (!br_info) {
 		ksmbd_free_work_struct(work);
 		return -ENOMEM;
@@ -1049,7 +1049,7 @@ static int add_lease_global_list(struct oplock_info *opinfo)
 	}
 	read_unlock(&lease_list_lock);
 
-	lb = kmalloc(sizeof(struct lease_table), GFP_KERNEL);
+	lb = kmalloc(sizeof(struct lease_table), KSMBD_DEFAULT_GFP);
 	if (!lb)
 		return -ENOMEM;
 
@@ -1487,7 +1487,7 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
 	if (IS_ERR_OR_NULL(cc))
 		return NULL;
 
-	lreq = kzalloc(sizeof(struct lease_ctx_info), GFP_KERNEL);
+	lreq = kzalloc(sizeof(struct lease_ctx_info), KSMBD_DEFAULT_GFP);
 	if (!lreq)
 		return NULL;
 
diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index d523b860236a..ab533c602987 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -47,7 +47,7 @@ static int ___server_conf_set(int idx, char *val)
 		return -EINVAL;
 
 	kfree(server_conf.conf[idx]);
-	server_conf.conf[idx] = kstrdup(val, GFP_KERNEL);
+	server_conf.conf[idx] = kstrdup(val, KSMBD_DEFAULT_GFP);
 	if (!server_conf.conf[idx])
 		return -ENOMEM;
 	return 0;
@@ -404,7 +404,7 @@ static int __queue_ctrl_work(int type)
 {
 	struct server_ctrl_struct *ctrl;
 
-	ctrl = kmalloc(sizeof(struct server_ctrl_struct), GFP_KERNEL);
+	ctrl = kmalloc(sizeof(struct server_ctrl_struct), KSMBD_DEFAULT_GFP);
 	if (!ctrl)
 		return -ENOMEM;
 
diff --git a/fs/smb/server/server.h b/fs/smb/server/server.h
index 94187628ff08..995555febe7d 100644
--- a/fs/smb/server/server.h
+++ b/fs/smb/server/server.h
@@ -46,6 +46,7 @@ struct ksmbd_server_config {
 
 	char			*conf[SERVER_CONF_WORK_GROUP + 1];
 	struct task_struct	*dh_task;
+	bool			bind_interfaces_only;
 };
 
 extern struct ksmbd_server_config server_conf;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 129517a0c5c7..6b9286c96343 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -38,6 +38,7 @@
 #include "mgmt/user_session.h"
 #include "mgmt/ksmbd_ida.h"
 #include "ndr.h"
+#include "transport_tcp.h"
 
 static void __wbuf(struct ksmbd_work *work, void **req, void **rsp)
 {
@@ -553,7 +554,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	if (le32_to_cpu(hdr->NextCommand) > 0)
 		sz = large_sz;
 
-	work->response_buf = kvzalloc(sz, GFP_KERNEL);
+	work->response_buf = kvzalloc(sz, KSMBD_DEFAULT_GFP);
 	if (!work->response_buf)
 		return -ENOMEM;
 
@@ -1150,7 +1151,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	case SMB311_PROT_ID:
 		conn->preauth_info =
 			kzalloc(sizeof(struct preauth_integrity_info),
-				GFP_KERNEL);
+				KSMBD_DEFAULT_GFP);
 		if (!conn->preauth_info) {
 			rc = -ENOMEM;
 			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
@@ -1272,7 +1273,7 @@ static int alloc_preauth_hash(struct ksmbd_session *sess,
 		return -ENOMEM;
 
 	sess->Preauth_HashValue = kmemdup(conn->preauth_info->Preauth_HashValue,
-					  PREAUTH_HASHVALUE_SIZE, GFP_KERNEL);
+					  PREAUTH_HASHVALUE_SIZE, KSMBD_DEFAULT_GFP);
 	if (!sess->Preauth_HashValue)
 		return -ENOMEM;
 
@@ -1358,7 +1359,7 @@ static int ntlm_negotiate(struct ksmbd_work *work,
 	sz = sizeof(struct challenge_message);
 	sz += (strlen(ksmbd_netbios_name()) * 2 + 1 + 4) * 6;
 
-	neg_blob = kzalloc(sz, GFP_KERNEL);
+	neg_blob = kzalloc(sz, KSMBD_DEFAULT_GFP);
 	if (!neg_blob)
 		return -ENOMEM;
 
@@ -1549,12 +1550,12 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 	if (conn->dialect >= SMB30_PROT_ID) {
 		chann = lookup_chann_list(sess, conn);
 		if (!chann) {
-			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
+			chann = kmalloc(sizeof(struct channel), KSMBD_DEFAULT_GFP);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, KSMBD_DEFAULT_GFP);
 		}
 	}
 
@@ -1632,12 +1633,12 @@ static int krb5_authenticate(struct ksmbd_work *work,
 	if (conn->dialect >= SMB30_PROT_ID) {
 		chann = lookup_chann_list(sess, conn);
 		if (!chann) {
-			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
+			chann = kmalloc(sizeof(struct channel), KSMBD_DEFAULT_GFP);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, KSMBD_DEFAULT_GFP);
 		}
 	}
 
@@ -2356,7 +2357,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			le16_to_cpu(eabuf->EaValueLength))
 		return -EINVAL;
 
-	attr_name = kmalloc(XATTR_NAME_MAX + 1, GFP_KERNEL);
+	attr_name = kmalloc(XATTR_NAME_MAX + 1, KSMBD_DEFAULT_GFP);
 	if (!attr_name)
 		return -ENOMEM;
 
@@ -2928,7 +2929,7 @@ int smb2_open(struct ksmbd_work *work)
 			goto err_out2;
 		}
 	} else {
-		name = kstrdup("", GFP_KERNEL);
+		name = kstrdup("", KSMBD_DEFAULT_GFP);
 		if (!name) {
 			rc = -ENOMEM;
 			goto err_out2;
@@ -3369,7 +3370,7 @@ int smb2_open(struct ksmbd_work *work)
 							sizeof(struct smb_sid) * 3 +
 							sizeof(struct smb_acl) +
 							sizeof(struct smb_ace) * ace_num * 2,
-							GFP_KERNEL);
+							KSMBD_DEFAULT_GFP);
 					if (!pntsd) {
 						posix_acl_release(fattr.cf_acls);
 						posix_acl_release(fattr.cf_dacls);
@@ -5007,7 +5008,7 @@ static int get_file_stream_info(struct ksmbd_work *work,
 
 		/* plus : size */
 		streamlen += 1;
-		stream_buf = kmalloc(streamlen + 1, GFP_KERNEL);
+		stream_buf = kmalloc(streamlen + 1, KSMBD_DEFAULT_GFP);
 		if (!stream_buf)
 			break;
 
@@ -6002,7 +6003,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 		return -EINVAL;
 
 	ksmbd_debug(SMB, "setting FILE_LINK_INFORMATION\n");
-	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	pathname = kmalloc(PATH_MAX, KSMBD_DEFAULT_GFP);
 	if (!pathname)
 		return -ENOMEM;
 
@@ -6562,7 +6563,7 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 		}
 
 		aux_payload_buf =
-			kvmalloc(rpc_resp->payload_sz, GFP_KERNEL);
+			kvmalloc(rpc_resp->payload_sz, KSMBD_DEFAULT_GFP);
 		if (!aux_payload_buf) {
 			err = -ENOMEM;
 			goto out;
@@ -6745,7 +6746,7 @@ int smb2_read(struct ksmbd_work *work)
 	ksmbd_debug(SMB, "filename %pD, offset %lld, len %zu\n",
 		    fp->filp, offset, length);
 
-	aux_payload_buf = kvzalloc(length, GFP_KERNEL);
+	aux_payload_buf = kvzalloc(length, KSMBD_DEFAULT_GFP);
 	if (!aux_payload_buf) {
 		err = -ENOMEM;
 		goto out;
@@ -6897,7 +6898,7 @@ static ssize_t smb2_write_rdma_channel(struct ksmbd_work *work,
 	int ret;
 	ssize_t nbytes;
 
-	data_buf = kvzalloc(length, GFP_KERNEL);
+	data_buf = kvzalloc(length, KSMBD_DEFAULT_GFP);
 	if (!data_buf)
 		return -ENOMEM;
 
@@ -7228,7 +7229,7 @@ static struct ksmbd_lock *smb2_lock_init(struct file_lock *flock,
 {
 	struct ksmbd_lock *lock;
 
-	lock = kzalloc(sizeof(struct ksmbd_lock), GFP_KERNEL);
+	lock = kzalloc(sizeof(struct ksmbd_lock), KSMBD_DEFAULT_GFP);
 	if (!lock)
 		return NULL;
 
@@ -7496,7 +7497,7 @@ int smb2_lock(struct ksmbd_work *work)
 					    "would have to wait for getting lock\n");
 				list_add(&smb_lock->llist, &rollback_list);
 
-				argv = kmalloc(sizeof(void *), GFP_KERNEL);
+				argv = kmalloc(sizeof(void *), KSMBD_DEFAULT_GFP);
 				if (!argv) {
 					err = -ENOMEM;
 					goto out;
@@ -7771,6 +7772,9 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 		if (netdev->type == ARPHRD_LOOPBACK)
 			continue;
 
+		if (!ksmbd_find_netdev_name_iface_list(netdev->name))
+			continue;
+
 		flags = dev_get_flags(netdev);
 		if (!(flags & IFF_RUNNING))
 			continue;
@@ -8990,7 +8994,7 @@ int smb3_encrypt_resp(struct ksmbd_work *work)
 	int rc = -ENOMEM;
 	void *tr_buf;
 
-	tr_buf = kzalloc(sizeof(struct smb2_transform_hdr) + 4, GFP_KERNEL);
+	tr_buf = kzalloc(sizeof(struct smb2_transform_hdr) + 4, KSMBD_DEFAULT_GFP);
 	if (!tr_buf)
 		return rc;
 
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index af8e24163bf2..191df59748e0 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -358,7 +358,7 @@ static int smb1_check_user_session(struct ksmbd_work *work)
 static int smb1_allocate_rsp_buf(struct ksmbd_work *work)
 {
 	work->response_buf = kzalloc(MAX_CIFS_SMALL_BUFFER_SIZE,
-			GFP_KERNEL);
+			KSMBD_DEFAULT_GFP);
 	work->response_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 
 	if (!work->response_buf) {
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 376ae68144af..5aa7a66334d9 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -350,10 +350,10 @@ int init_acl_state(struct posix_acl_state *state, u16 cnt)
 	 */
 	alloc = sizeof(struct posix_ace_state_array)
 		+ cnt * sizeof(struct posix_user_ace_state);
-	state->users = kzalloc(alloc, GFP_KERNEL);
+	state->users = kzalloc(alloc, KSMBD_DEFAULT_GFP);
 	if (!state->users)
 		return -ENOMEM;
-	state->groups = kzalloc(alloc, GFP_KERNEL);
+	state->groups = kzalloc(alloc, KSMBD_DEFAULT_GFP);
 	if (!state->groups) {
 		kfree(state->users);
 		return -ENOMEM;
@@ -417,7 +417,7 @@ static void parse_dacl(struct mnt_idmap *idmap,
 		return;
 	}
 
-	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
+	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), KSMBD_DEFAULT_GFP);
 	if (!ppace) {
 		free_acl_state(&default_acl_state);
 		free_acl_state(&acl_state);
@@ -561,7 +561,7 @@ static void parse_dacl(struct mnt_idmap *idmap,
 		if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
 			fattr->cf_acls =
 				posix_acl_alloc(acl_state.users->n +
-					acl_state.groups->n + 4, GFP_KERNEL);
+					acl_state.groups->n + 4, KSMBD_DEFAULT_GFP);
 			if (fattr->cf_acls) {
 				cf_pace = fattr->cf_acls->a_entries;
 				posix_state_to_acl(&acl_state, cf_pace);
@@ -575,7 +575,7 @@ static void parse_dacl(struct mnt_idmap *idmap,
 		if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
 			fattr->cf_dacls =
 				posix_acl_alloc(default_acl_state.users->n +
-				default_acl_state.groups->n + 4, GFP_KERNEL);
+				default_acl_state.groups->n + 4, KSMBD_DEFAULT_GFP);
 			if (fattr->cf_dacls) {
 				cf_pdace = fattr->cf_dacls->a_entries;
 				posix_state_to_acl(&default_acl_state, cf_pdace);
@@ -603,7 +603,7 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 	for (i = 0; i < fattr->cf_acls->a_count; i++, pace++) {
 		int flags = 0;
 
-		sid = kmalloc(sizeof(struct smb_sid), GFP_KERNEL);
+		sid = kmalloc(sizeof(struct smb_sid), KSMBD_DEFAULT_GFP);
 		if (!sid)
 			break;
 
@@ -670,7 +670,7 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 
 	pace = fattr->cf_dacls->a_entries;
 	for (i = 0; i < fattr->cf_dacls->a_count; i++, pace++) {
-		sid = kmalloc(sizeof(struct smb_sid), GFP_KERNEL);
+		sid = kmalloc(sizeof(struct smb_sid), KSMBD_DEFAULT_GFP);
 		if (!sid)
 			break;
 
@@ -930,7 +930,7 @@ int build_sec_desc(struct mnt_idmap *idmap,
 	gid_t gid;
 	unsigned int sid_type = SIDOWNER;
 
-	nowner_sid_ptr = kmalloc(sizeof(struct smb_sid), GFP_KERNEL);
+	nowner_sid_ptr = kmalloc(sizeof(struct smb_sid), KSMBD_DEFAULT_GFP);
 	if (!nowner_sid_ptr)
 		return -ENOMEM;
 
@@ -939,7 +939,7 @@ int build_sec_desc(struct mnt_idmap *idmap,
 		sid_type = SIDUNIX_USER;
 	id_to_sid(uid, sid_type, nowner_sid_ptr);
 
-	ngroup_sid_ptr = kmalloc(sizeof(struct smb_sid), GFP_KERNEL);
+	ngroup_sid_ptr = kmalloc(sizeof(struct smb_sid), KSMBD_DEFAULT_GFP);
 	if (!ngroup_sid_ptr) {
 		kfree(nowner_sid_ptr);
 		return -ENOMEM;
@@ -1062,7 +1062,8 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		goto free_parent_pntsd;
 	}
 
-	aces_base = kmalloc(sizeof(struct smb_ace) * num_aces * 2, GFP_KERNEL);
+	aces_base = kmalloc(sizeof(struct smb_ace) * num_aces * 2,
+			    KSMBD_DEFAULT_GFP);
 	if (!aces_base) {
 		rc = -ENOMEM;
 		goto free_parent_pntsd;
@@ -1156,7 +1157,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		pntsd_alloc_size = sizeof(struct smb_ntsd) + powner_sid_size +
 			pgroup_sid_size + sizeof(struct smb_acl) + nt_size;
 
-		pntsd = kzalloc(pntsd_alloc_size, GFP_KERNEL);
+		pntsd = kzalloc(pntsd_alloc_size, KSMBD_DEFAULT_GFP);
 		if (!pntsd) {
 			rc = -ENOMEM;
 			goto free_aces_base;
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 9b3c68014aee..2da2a5f6b983 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -244,7 +244,7 @@ static struct ksmbd_ipc_msg *ipc_msg_alloc(size_t sz)
 	struct ksmbd_ipc_msg *msg;
 	size_t msg_sz = sz + sizeof(struct ksmbd_ipc_msg);
 
-	msg = kvzalloc(msg_sz, GFP_KERNEL);
+	msg = kvzalloc(msg_sz, KSMBD_DEFAULT_GFP);
 	if (msg)
 		msg->sz = sz;
 	return msg;
@@ -284,7 +284,7 @@ static int handle_response(int type, void *payload, size_t sz)
 			continue;
 		}
 
-		entry->response = kvzalloc(sz, GFP_KERNEL);
+		entry->response = kvzalloc(sz, KSMBD_DEFAULT_GFP);
 		if (!entry->response) {
 			ret = -ENOMEM;
 			break;
@@ -338,6 +338,7 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	ret = ksmbd_set_netbios_name(req->netbios_name);
 	ret |= ksmbd_set_server_string(req->server_string);
 	ret |= ksmbd_set_work_group(req->work_group);
+	server_conf.bind_interfaces_only = req->bind_interfaces_only;
 	ret |= ksmbd_tcp_set_interfaces(KSMBD_STARTUP_CONFIG_INTERFACES(req),
 					req->ifc_list_sz);
 out:
@@ -453,7 +454,7 @@ static int ipc_msg_send(struct ksmbd_ipc_msg *msg)
 	if (!ksmbd_tools_pid)
 		return ret;
 
-	skb = genlmsg_new(msg->sz, GFP_KERNEL);
+	skb = genlmsg_new(msg->sz, KSMBD_DEFAULT_GFP);
 	if (!skb)
 		return -ENOMEM;
 
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 17c76713c6d0..7c5a0d712873 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -362,7 +362,7 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 	struct smb_direct_transport *t;
 	struct ksmbd_conn *conn;
 
-	t = kzalloc(sizeof(*t), GFP_KERNEL);
+	t = kzalloc(sizeof(*t), KSMBD_DEFAULT_GFP);
 	if (!t)
 		return NULL;
 
@@ -462,7 +462,7 @@ static struct smb_direct_sendmsg
 {
 	struct smb_direct_sendmsg *msg;
 
-	msg = mempool_alloc(t->sendmsg_mempool, GFP_KERNEL);
+	msg = mempool_alloc(t->sendmsg_mempool, KSMBD_DEFAULT_GFP);
 	if (!msg)
 		return ERR_PTR(-ENOMEM);
 	msg->transport = t;
@@ -1406,7 +1406,7 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
 	desc_buf = buf;
 	for (i = 0; i < desc_num; i++) {
 		msg = kzalloc(struct_size(msg, sg_list, SG_CHUNK_SIZE),
-			      GFP_KERNEL);
+			      KSMBD_DEFAULT_GFP);
 		if (!msg) {
 			ret = -ENOMEM;
 			goto out;
@@ -1852,7 +1852,7 @@ static int smb_direct_create_pools(struct smb_direct_transport *t)
 	INIT_LIST_HEAD(&t->recvmsg_queue);
 
 	for (i = 0; i < t->recv_credit_max; i++) {
-		recvmsg = mempool_alloc(t->recvmsg_mempool, GFP_KERNEL);
+		recvmsg = mempool_alloc(t->recvmsg_mempool, KSMBD_DEFAULT_GFP);
 		if (!recvmsg)
 			goto err;
 		recvmsg->transport = t;
@@ -2144,7 +2144,7 @@ static int smb_direct_ib_client_add(struct ib_device *ib_dev)
 	if (!rdma_frwr_is_supported(&ib_dev->attrs))
 		return 0;
 
-	smb_dev = kzalloc(sizeof(*smb_dev), GFP_KERNEL);
+	smb_dev = kzalloc(sizeof(*smb_dev), KSMBD_DEFAULT_GFP);
 	if (!smb_dev)
 		return -ENOMEM;
 	smb_dev->ib_dev = ib_dev;
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index aaed9e293b2e..abedf510899a 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -76,7 +76,7 @@ static struct tcp_transport *alloc_transport(struct socket *client_sk)
 	struct tcp_transport *t;
 	struct ksmbd_conn *conn;
 
-	t = kzalloc(sizeof(*t), GFP_KERNEL);
+	t = kzalloc(sizeof(*t), KSMBD_DEFAULT_GFP);
 	if (!t)
 		return NULL;
 	t->sock = client_sk;
@@ -93,17 +93,21 @@ static struct tcp_transport *alloc_transport(struct socket *client_sk)
 	return t;
 }
 
-static void free_transport(struct tcp_transport *t)
+void ksmbd_free_transport(struct ksmbd_transport *kt)
 {
-	kernel_sock_shutdown(t->sock, SHUT_RDWR);
-	sock_release(t->sock);
-	t->sock = NULL;
+	struct tcp_transport *t = TCP_TRANS(kt);
 
-	ksmbd_conn_free(KSMBD_TRANS(t)->conn);
+	sock_release(t->sock);
 	kfree(t->iov);
 	kfree(t);
 }
 
+static void free_transport(struct tcp_transport *t)
+{
+	kernel_sock_shutdown(t->sock, SHUT_RDWR);
+	ksmbd_conn_free(KSMBD_TRANS(t)->conn);
+}
+
 /**
  * kvec_array_init() - initialize a IO vector segment
  * @new:	IO vector to be initialized
@@ -151,7 +155,7 @@ static struct kvec *get_conn_iovec(struct tcp_transport *t, unsigned int nr_segs
 		return t->iov;
 
 	/* not big enough -- allocate a new one and release the old */
-	new_iov = kmalloc_array(nr_segs, sizeof(*new_iov), GFP_KERNEL);
+	new_iov = kmalloc_array(nr_segs, sizeof(*new_iov), KSMBD_DEFAULT_GFP);
 	if (new_iov) {
 		kfree(t->iov);
 		t->iov = new_iov;
@@ -504,52 +508,61 @@ static int create_socket(struct interface *iface)
 	return ret;
 }
 
+struct interface *ksmbd_find_netdev_name_iface_list(char *netdev_name)
+{
+	struct interface *iface;
+
+	list_for_each_entry(iface, &iface_list, entry)
+		if (!strcmp(iface->name, netdev_name))
+			return iface;
+	return NULL;
+}
+
 static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
 			      void *ptr)
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
 	struct interface *iface;
-	int ret, found = 0;
+	int ret;
 
 	switch (event) {
 	case NETDEV_UP:
 		if (netif_is_bridge_port(netdev))
 			return NOTIFY_OK;
 
-		list_for_each_entry(iface, &iface_list, entry) {
-			if (!strcmp(iface->name, netdev->name)) {
-				found = 1;
-				if (iface->state != IFACE_STATE_DOWN)
-					break;
-				ret = create_socket(iface);
-				if (ret)
-					return NOTIFY_OK;
-				break;
-			}
+		iface = ksmbd_find_netdev_name_iface_list(netdev->name);
+		if (iface && iface->state == IFACE_STATE_DOWN) {
+			ksmbd_debug(CONN, "netdev-up event: netdev(%s) is going up\n",
+					iface->name);
+			ret = create_socket(iface);
+			if (ret)
+				return NOTIFY_OK;
 		}
-		if (!found && bind_additional_ifaces) {
-			iface = alloc_iface(kstrdup(netdev->name, GFP_KERNEL));
+		if (!iface && bind_additional_ifaces) {
+			iface = alloc_iface(kstrdup(netdev->name, KSMBD_DEFAULT_GFP));
 			if (!iface)
 				return NOTIFY_OK;
+			ksmbd_debug(CONN, "netdev-up event: netdev(%s) is going up\n",
+				    iface->name);
 			ret = create_socket(iface);
 			if (ret)
 				break;
 		}
 		break;
 	case NETDEV_DOWN:
-		list_for_each_entry(iface, &iface_list, entry) {
-			if (!strcmp(iface->name, netdev->name) &&
-			    iface->state == IFACE_STATE_CONFIGURED) {
-				tcp_stop_kthread(iface->ksmbd_kthread);
-				iface->ksmbd_kthread = NULL;
-				mutex_lock(&iface->sock_release_lock);
-				tcp_destroy_socket(iface->ksmbd_socket);
-				iface->ksmbd_socket = NULL;
-				mutex_unlock(&iface->sock_release_lock);
-
-				iface->state = IFACE_STATE_DOWN;
-				break;
-			}
+		iface = ksmbd_find_netdev_name_iface_list(netdev->name);
+		if (iface && iface->state == IFACE_STATE_CONFIGURED) {
+			ksmbd_debug(CONN, "netdev-down event: netdev(%s) is going down\n",
+					iface->name);
+			tcp_stop_kthread(iface->ksmbd_kthread);
+			iface->ksmbd_kthread = NULL;
+			mutex_lock(&iface->sock_release_lock);
+			tcp_destroy_socket(iface->ksmbd_socket);
+			iface->ksmbd_socket = NULL;
+			mutex_unlock(&iface->sock_release_lock);
+
+			iface->state = IFACE_STATE_DOWN;
+			break;
 		}
 		break;
 	}
@@ -600,7 +613,7 @@ static struct interface *alloc_iface(char *ifname)
 	if (!ifname)
 		return NULL;
 
-	iface = kzalloc(sizeof(struct interface), GFP_KERNEL);
+	iface = kzalloc(sizeof(struct interface), KSMBD_DEFAULT_GFP);
 	if (!iface) {
 		kfree(ifname);
 		return NULL;
@@ -618,24 +631,12 @@ int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
 	int sz = 0;
 
 	if (!ifc_list_sz) {
-		struct net_device *netdev;
-
-		rtnl_lock();
-		for_each_netdev(&init_net, netdev) {
-			if (netif_is_bridge_port(netdev))
-				continue;
-			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL))) {
-				rtnl_unlock();
-				return -ENOMEM;
-			}
-		}
-		rtnl_unlock();
 		bind_additional_ifaces = 1;
 		return 0;
 	}
 
 	while (ifc_list_sz > 0) {
-		if (!alloc_iface(kstrdup(ifc_list, GFP_KERNEL)))
+		if (!alloc_iface(kstrdup(ifc_list, KSMBD_DEFAULT_GFP)))
 			return -ENOMEM;
 
 		sz = strlen(ifc_list);
diff --git a/fs/smb/server/transport_tcp.h b/fs/smb/server/transport_tcp.h
index e338bebe322f..1e51675ee1b2 100644
--- a/fs/smb/server/transport_tcp.h
+++ b/fs/smb/server/transport_tcp.h
@@ -7,6 +7,8 @@
 #define __KSMBD_TRANSPORT_TCP_H__
 
 int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz);
+struct interface *ksmbd_find_netdev_name_iface_list(char *netdev_name);
+void ksmbd_free_transport(struct ksmbd_transport *kt);
 int ksmbd_tcp_init(void);
 void ksmbd_tcp_destroy(void);
 
diff --git a/fs/smb/server/unicode.c b/fs/smb/server/unicode.c
index 217106ff7b82..85e6791745ec 100644
--- a/fs/smb/server/unicode.c
+++ b/fs/smb/server/unicode.c
@@ -297,7 +297,7 @@ char *smb_strndup_from_utf16(const char *src, const int maxlen,
 	if (is_unicode) {
 		len = smb_utf16_bytes((__le16 *)src, maxlen, codepage);
 		len += nls_nullsize(codepage);
-		dst = kmalloc(len, GFP_KERNEL);
+		dst = kmalloc(len, KSMBD_DEFAULT_GFP);
 		if (!dst)
 			return ERR_PTR(-ENOMEM);
 		ret = smb_from_utf16(dst, (__le16 *)src, len, maxlen, codepage,
@@ -309,7 +309,7 @@ char *smb_strndup_from_utf16(const char *src, const int maxlen,
 	} else {
 		len = strnlen(src, maxlen);
 		len++;
-		dst = kmalloc(len, GFP_KERNEL);
+		dst = kmalloc(len, KSMBD_DEFAULT_GFP);
 		if (!dst)
 			return ERR_PTR(-ENOMEM);
 		strscpy(dst, src, len);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 8fd070e31fa7..a7694aae0b94 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -444,7 +444,7 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	}
 
 	if (v_len < size) {
-		wbuf = kvzalloc(size, GFP_KERNEL);
+		wbuf = kvzalloc(size, KSMBD_DEFAULT_GFP);
 		if (!wbuf) {
 			err = -ENOMEM;
 			goto out;
@@ -866,7 +866,7 @@ ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list)
 	if (size <= 0)
 		return size;
 
-	vlist = kvzalloc(size, GFP_KERNEL);
+	vlist = kvzalloc(size, KSMBD_DEFAULT_GFP);
 	if (!vlist)
 		return -ENOMEM;
 
@@ -908,7 +908,7 @@ ssize_t ksmbd_vfs_getxattr(struct mnt_idmap *idmap,
 	if (xattr_len < 0)
 		return xattr_len;
 
-	buf = kmalloc(xattr_len + 1, GFP_KERNEL);
+	buf = kmalloc(xattr_len + 1, KSMBD_DEFAULT_GFP);
 	if (!buf)
 		return -ENOMEM;
 
@@ -1413,7 +1413,7 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct mnt_idmap *id
 
 	smb_acl = kzalloc(sizeof(struct xattr_smb_acl) +
 			  sizeof(struct xattr_acl_entry) * posix_acls->a_count,
-			  GFP_KERNEL);
+			  KSMBD_DEFAULT_GFP);
 	if (!smb_acl)
 		goto out;
 
@@ -1769,7 +1769,7 @@ int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 	else
 		type = ":$DATA";
 
-	buf = kasprintf(GFP_KERNEL, "%s%s%s",
+	buf = kasprintf(KSMBD_DEFAULT_GFP, "%s%s%s",
 			XATTR_NAME_STREAM, stream_name,	type);
 	if (!buf)
 		return -ENOMEM;
@@ -1898,7 +1898,7 @@ int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
 		acl_state.group.allow;
 	acl_state.mask.allow = 0x07;
 
-	acls = posix_acl_alloc(6, GFP_KERNEL);
+	acls = posix_acl_alloc(6, KSMBD_DEFAULT_GFP);
 	if (!acls) {
 		free_acl_state(&acl_state);
 		return -ENOMEM;
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index a19f4e563c7e..1f8fa3468173 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -188,7 +188,7 @@ static struct ksmbd_inode *ksmbd_inode_get(struct ksmbd_file *fp)
 	if (ci)
 		return ci;
 
-	ci = kmalloc(sizeof(struct ksmbd_inode), GFP_KERNEL);
+	ci = kmalloc(sizeof(struct ksmbd_inode), KSMBD_DEFAULT_GFP);
 	if (!ci)
 		return NULL;
 
@@ -577,7 +577,7 @@ static int __open_id(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
 		return -EMFILE;
 	}
 
-	idr_preload(GFP_KERNEL);
+	idr_preload(KSMBD_DEFAULT_GFP);
 	write_lock(&ft->lock);
 	ret = idr_alloc_cyclic(ft->idr, fp, 0, INT_MAX - 1, GFP_NOWAIT);
 	if (ret >= 0) {
@@ -605,7 +605,7 @@ struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp)
 	struct ksmbd_file *fp;
 	int ret;
 
-	fp = kmem_cache_zalloc(filp_cache, GFP_KERNEL);
+	fp = kmem_cache_zalloc(filp_cache, KSMBD_DEFAULT_GFP);
 	if (!fp) {
 		pr_err("Failed to allocate memory\n");
 		return ERR_PTR(-ENOMEM);
@@ -713,12 +713,8 @@ static bool tree_conn_fd_check(struct ksmbd_tree_connect *tcon,
 
 static bool ksmbd_durable_scavenger_alive(void)
 {
-	mutex_lock(&durable_scavenger_lock);
-	if (!durable_scavenger_running) {
-		mutex_unlock(&durable_scavenger_lock);
+	if (!durable_scavenger_running)
 		return false;
-	}
-	mutex_unlock(&durable_scavenger_lock);
 
 	if (kthread_should_stop())
 		return false;
@@ -799,9 +795,7 @@ static int ksmbd_durable_scavenger(void *dummy)
 			break;
 	}
 
-	mutex_lock(&durable_scavenger_lock);
 	durable_scavenger_running = false;
-	mutex_unlock(&durable_scavenger_lock);
 
 	module_put(THIS_MODULE);
 
@@ -923,7 +917,7 @@ int ksmbd_validate_name_reconnect(struct ksmbd_share_config *share,
 	char *pathname, *ab_pathname;
 	int ret = 0;
 
-	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	pathname = kmalloc(PATH_MAX, KSMBD_DEFAULT_GFP);
 	if (!pathname)
 		return -EACCES;
 
@@ -983,7 +977,7 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 
 int ksmbd_init_file_table(struct ksmbd_file_table *ft)
 {
-	ft->idr = kzalloc(sizeof(struct idr), GFP_KERNEL);
+	ft->idr = kzalloc(sizeof(struct idr), KSMBD_DEFAULT_GFP);
 	if (!ft->idr)
 		return -ENOMEM;
 
diff --git a/fs/splice.c b/fs/splice.c
index 06232d7e505f..38f8c9426731 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -45,7 +45,7 @@
  * here if set to avoid blocking other users of this pipe if splice is
  * being done on it.
  */
-static noinline void noinline pipe_clear_nowait(struct file *file)
+static noinline void pipe_clear_nowait(struct file *file)
 {
 	fmode_t fmode = READ_ONCE(file->f_mode);
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 559a3a577097..ba6b4a180e80 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -19,6 +19,7 @@
 #include "xfs_reflink.h"
 #include "xfs_errortag.h"
 #include "xfs_error.h"
+#include "xfs_icache.h"
 
 struct xfs_writepage_ctx {
 	struct iomap_writepage_ctx ctx;
@@ -528,12 +529,44 @@ xfs_vm_readahead(
 }
 
 static int
-xfs_iomap_swapfile_activate(
+xfs_vm_swap_activate(
 	struct swap_info_struct		*sis,
 	struct file			*swap_file,
 	sector_t			*span)
 {
-	sis->bdev = xfs_inode_buftarg(XFS_I(file_inode(swap_file)))->bt_bdev;
+	struct xfs_inode		*ip = XFS_I(file_inode(swap_file));
+
+	/*
+	 * Swap file activation can race against concurrent shared extent
+	 * removal in files that have been cloned.  If this happens,
+	 * iomap_swapfile_iter() can fail because it encountered a shared
+	 * extent even though an operation is in progress to remove those
+	 * shared extents.
+	 *
+	 * This race becomes problematic when we defer extent removal
+	 * operations beyond the end of a syscall (i.e. use async background
+	 * processing algorithms).  Users think the extents are no longer
+	 * shared, but iomap_swapfile_iter() still sees them as shared
+	 * because the refcountbt entries for the extents being removed have
+	 * not yet been updated.  Hence the swapon call fails unexpectedly.
+	 *
+	 * The race condition is currently most obvious from the unlink()
+	 * operation as extent removal is deferred until after the last
+	 * reference to the inode goes away.  We then process the extent
+	 * removal asynchronously, hence triggers the "syscall completed but
+	 * work not done" condition mentioned above.  To close this race
+	 * window, we need to flush any pending inodegc operations to ensure
+	 * they have updated the refcountbt records before we try to map the
+	 * swapfile.
+	 */
+	xfs_inodegc_flush(ip->i_mount);
+
+	/*
+	 * Direct the swap code to the correct block device when this file
+	 * sits on the RT device.
+	 */
+	sis->bdev = xfs_inode_buftarg(ip)->bt_bdev;
+
 	return iomap_swapfile_activate(sis, swap_file, span,
 			&xfs_read_iomap_ops);
 }
@@ -549,11 +582,11 @@ const struct address_space_operations xfs_address_space_operations = {
 	.migrate_folio		= filemap_migrate_folio,
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
 	.error_remove_folio	= generic_error_remove_folio,
-	.swap_activate		= xfs_iomap_swapfile_activate,
+	.swap_activate		= xfs_vm_swap_activate,
 };
 
 const struct address_space_operations xfs_dax_aops = {
 	.writepages		= xfs_dax_writepages,
 	.dirty_folio		= noop_dirty_folio,
-	.swap_activate		= xfs_iomap_swapfile_activate,
+	.swap_activate		= xfs_vm_swap_activate,
 };
diff --git a/fs/xfs/xfs_qm_bhv.c b/fs/xfs/xfs_qm_bhv.c
index ed1d597c30ca..dabb1d6d7e46 100644
--- a/fs/xfs/xfs_qm_bhv.c
+++ b/fs/xfs/xfs_qm_bhv.c
@@ -79,6 +79,28 @@ xfs_qm_statvfs(
 	}
 }
 
+STATIC int
+xfs_qm_validate_state_change(
+	struct xfs_mount	*mp,
+	uint			uqd,
+	uint			gqd,
+	uint			pqd)
+{
+	int state;
+
+	/* Is quota state changing? */
+	state = ((uqd && !XFS_IS_UQUOTA_ON(mp)) ||
+		(!uqd &&  XFS_IS_UQUOTA_ON(mp)) ||
+		 (gqd && !XFS_IS_GQUOTA_ON(mp)) ||
+		(!gqd &&  XFS_IS_GQUOTA_ON(mp)) ||
+		 (pqd && !XFS_IS_PQUOTA_ON(mp)) ||
+		(!pqd &&  XFS_IS_PQUOTA_ON(mp)));
+
+	return  state &&
+		(xfs_dev_is_read_only(mp, "changing quota state") ||
+		xfs_has_norecovery(mp));
+}
+
 int
 xfs_qm_newmount(
 	xfs_mount_t	*mp,
@@ -98,24 +120,21 @@ xfs_qm_newmount(
 	}
 
 	/*
-	 * If the device itself is read-only, we can't allow
-	 * the user to change the state of quota on the mount -
-	 * this would generate a transaction on the ro device,
-	 * which would lead to an I/O error and shutdown
+	 * If the device itself is read-only and/or in norecovery
+	 * mode, we can't allow the user to change the state of
+	 * quota on the mount - this would generate a transaction
+	 * on the ro device, which would lead to an I/O error and
+	 * shutdown.
 	 */
 
-	if (((uquotaondisk && !XFS_IS_UQUOTA_ON(mp)) ||
-	    (!uquotaondisk &&  XFS_IS_UQUOTA_ON(mp)) ||
-	     (gquotaondisk && !XFS_IS_GQUOTA_ON(mp)) ||
-	    (!gquotaondisk &&  XFS_IS_GQUOTA_ON(mp)) ||
-	     (pquotaondisk && !XFS_IS_PQUOTA_ON(mp)) ||
-	    (!pquotaondisk &&  XFS_IS_PQUOTA_ON(mp)))  &&
-	    xfs_dev_is_read_only(mp, "changing quota state")) {
+	if (xfs_qm_validate_state_change(mp, uquotaondisk,
+			    gquotaondisk, pquotaondisk)) {
+
 		xfs_warn(mp, "please mount with%s%s%s%s.",
-			(!quotaondisk ? "out quota" : ""),
-			(uquotaondisk ? " usrquota" : ""),
-			(gquotaondisk ? " grpquota" : ""),
-			(pquotaondisk ? " prjquota" : ""));
+				(!quotaondisk ? "out quota" : ""),
+				(uquotaondisk ? " usrquota" : ""),
+				(gquotaondisk ? " grpquota" : ""),
+				(pquotaondisk ? " prjquota" : ""));
 		return -EPERM;
 	}
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 8f7c9eaeb360..201a86b3574d 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1619,8 +1619,12 @@ xfs_fs_fill_super(
 #endif
 	}
 
-	/* Filesystem claims it needs repair, so refuse the mount. */
-	if (xfs_has_needsrepair(mp)) {
+	/*
+	 * Filesystem claims it needs repair, so refuse the mount unless
+	 * norecovery is also specified, in which case the filesystem can
+	 * be mounted with no risk of further damage.
+	 */
+	if (xfs_has_needsrepair(mp) && !xfs_has_norecovery(mp)) {
 		xfs_warn(mp, "Filesystem needs repair.  Please run xfs_repair.");
 		error = -EFSCORRUPTED;
 		goto out_free_sb;
diff --git a/include/drm/intel/i915_pciids.h b/include/drm/intel/i915_pciids.h
index dacea289acaf..1ff00e3d4418 100644
--- a/include/drm/intel/i915_pciids.h
+++ b/include/drm/intel/i915_pciids.h
@@ -810,6 +810,7 @@
 	MACRO__(0xE20C, ## __VA_ARGS__), \
 	MACRO__(0xE20D, ## __VA_ARGS__), \
 	MACRO__(0xE210, ## __VA_ARGS__), \
+	MACRO__(0xE211, ## __VA_ARGS__), \
 	MACRO__(0xE212, ## __VA_ARGS__), \
 	MACRO__(0xE215, ## __VA_ARGS__), \
 	MACRO__(0xE216, ## __VA_ARGS__)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 318245b4e38f..959f8f82a650 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -156,9 +156,6 @@ struct request {
 	struct blk_crypto_keyslot *crypt_keyslot;
 #endif
 
-	enum rw_hint write_hint;
-	unsigned short ioprio;
-
 	enum mq_rq_state state;
 	atomic_t ref;
 
@@ -222,7 +219,9 @@ static inline bool blk_rq_is_passthrough(struct request *rq)
 
 static inline unsigned short req_get_ioprio(struct request *req)
 {
-	return req->ioprio;
+	if (req->bio)
+		return req->bio->bi_ioprio;
+	return 0;
 }
 
 #define rq_data_dir(rq)		(op_is_write(req_op(rq)) ? WRITE : READ)
@@ -1010,7 +1009,6 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
 	rq->nr_phys_segments = nr_segs;
 	rq->__data_len = bio->bi_iter.bi_size;
 	rq->bio = rq->biotail = bio;
-	rq->ioprio = bio_prio(bio);
 }
 
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 1ff52020cf75..34498652f780 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -163,13 +163,13 @@ struct em_data_callback {
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
 int em_dev_update_perf_domain(struct device *dev,
-			      struct em_perf_table __rcu *new_table);
+			      struct em_perf_table *new_table);
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				struct em_data_callback *cb, cpumask_t *span,
 				bool microwatts);
 void em_dev_unregister_perf_domain(struct device *dev);
-struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
-void em_table_free(struct em_perf_table __rcu *table);
+struct em_perf_table *em_table_alloc(struct em_perf_domain *pd);
+void em_table_free(struct em_perf_table *table);
 int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
 			 int nr_states);
 int em_dev_update_chip_binning(struct device *dev);
@@ -365,14 +365,14 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
 	return 0;
 }
 static inline
-struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd)
+struct em_perf_table *em_table_alloc(struct em_perf_domain *pd)
 {
 	return NULL;
 }
-static inline void em_table_free(struct em_perf_table __rcu *table) {}
+static inline void em_table_free(struct em_perf_table *table) {}
 static inline
 int em_dev_update_perf_domain(struct device *dev,
-			      struct em_perf_table __rcu *new_table)
+			      struct em_perf_table *new_table)
 {
 	return -EINVAL;
 }
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b10093c4d00e..59a421fc42bf 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -73,7 +73,6 @@ struct msi_msg {
 	};
 };
 
-extern int pci_msi_ignore_mask;
 /* Helper functions */
 struct msi_desc;
 struct pci_dev;
@@ -556,6 +555,8 @@ enum {
 	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
 	/* PCI MSIs cannot be steered separately to CPU cores */
 	MSI_FLAG_NO_AFFINITY		= (1 << 21),
+	/* Inhibit usage of entry masking */
+	MSI_FLAG_NO_MASK		= (1 << 22),
 };
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 74114acbb07f..ade889ded4e1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -245,6 +245,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
 	/* Device does honor MSI masking despite saying otherwise */
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
+	/* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX reads */
+	PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force pci_dev_flags_t) (1 << 13),
 };
 
 enum pci_irq_reroute_variant {
diff --git a/include/net/netfilter/nft_fib.h b/include/net/netfilter/nft_fib.h
index 38cae7113de4..6e202ed5e63f 100644
--- a/include/net/netfilter/nft_fib.h
+++ b/include/net/netfilter/nft_fib.h
@@ -18,6 +18,27 @@ nft_fib_is_loopback(const struct sk_buff *skb, const struct net_device *in)
 	return skb->pkt_type == PACKET_LOOPBACK || in->flags & IFF_LOOPBACK;
 }
 
+static inline bool nft_fib_can_skip(const struct nft_pktinfo *pkt)
+{
+	const struct net_device *indev = nft_in(pkt);
+	const struct sock *sk;
+
+	switch (nft_hook(pkt)) {
+	case NF_INET_PRE_ROUTING:
+	case NF_INET_INGRESS:
+	case NF_INET_LOCAL_IN:
+		break;
+	default:
+		return false;
+	}
+
+	sk = pkt->skb->sk;
+	if (sk && sk_fullsock(sk))
+	       return sk->sk_rx_dst_ifindex == indev->ifindex;
+
+	return nft_fib_is_loopback(pkt->skb, indev);
+}
+
 int nft_fib_dump(struct sk_buff *skb, const struct nft_expr *expr, bool reset);
 int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		 const struct nlattr * const tb[]);
diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
index 5870a94599a2..d5f6a228df65 100644
--- a/include/soc/qcom/ice.h
+++ b/include/soc/qcom/ice.h
@@ -34,4 +34,6 @@ int qcom_ice_program_key(struct qcom_ice *ice,
 			 int slot);
 int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
 struct qcom_ice *of_qcom_ice_get(struct device *dev);
+struct qcom_ice *devm_of_qcom_ice_get(struct device *dev);
+
 #endif /* __QCOM_ICE_H__ */
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 1527d5d45e01..bd0ea07338eb 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -99,7 +99,7 @@ TRACE_EVENT(block_rq_requeue,
 		__entry->dev	   = rq->q->disk ? disk_devt(rq->q->disk) : 0;
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
-		__entry->ioprio    = rq->ioprio;
+		__entry->ioprio    = req_get_ioprio(rq);
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
@@ -136,7 +136,7 @@ DECLARE_EVENT_CLASS(block_rq_completion,
 		__entry->sector    = blk_rq_pos(rq);
 		__entry->nr_sector = nr_bytes >> 9;
 		__entry->error     = blk_status_to_errno(error);
-		__entry->ioprio    = rq->ioprio;
+		__entry->ioprio    = req_get_ioprio(rq);
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
@@ -209,7 +209,7 @@ DECLARE_EVENT_CLASS(block_rq,
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 		__entry->bytes     = blk_rq_bytes(rq);
-		__entry->ioprio	   = rq->ioprio;
+		__entry->ioprio	   = req_get_ioprio(rq);
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index c1fb1355d309..1e7b0bef95f5 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -119,6 +119,14 @@
 		trace_print_array_seq(p, array, count, el_size);	\
 	})
 
+#undef __print_dynamic_array
+#define __print_dynamic_array(array, el_size)				\
+	({								\
+		__print_array(__get_dynamic_array(array),		\
+			      __get_dynamic_array_len(array) / (el_size), \
+			      (el_size));				\
+	})
+
 #undef __print_hex_dump
 #define __print_hex_dump(prefix_str, prefix_type,			\
 			 rowsize, groupsize, buf, len, ascii)		\
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index bcb960d16fc0..fcd564a590f4 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -22,6 +22,7 @@
 #undef __get_rel_cpumask
 #undef __get_rel_sockaddr
 #undef __print_array
+#undef __print_dynamic_array
 #undef __print_hex_dump
 #undef __get_buf
 
diff --git a/include/uapi/drm/ivpu_accel.h b/include/uapi/drm/ivpu_accel.h
index 084fb529e1e9..13001da141c3 100644
--- a/include/uapi/drm/ivpu_accel.h
+++ b/include/uapi/drm/ivpu_accel.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2025 Intel Corporation
  */
 
 #ifndef __UAPI_IVPU_DRM_H__
@@ -131,7 +131,7 @@ struct drm_ivpu_param {
 	 * platform type when executing on a simulator or emulator (read-only)
 	 *
 	 * %DRM_IVPU_PARAM_CORE_CLOCK_RATE:
-	 * Current PLL frequency (read-only)
+	 * Maximum frequency of the NPU data processing unit clock (read-only)
 	 *
 	 * %DRM_IVPU_PARAM_NUM_CONTEXTS:
 	 * Maximum number of simultaneously existing contexts (read-only)
diff --git a/init/Kconfig b/init/Kconfig
index 243d0087f944..2b4969758da8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -708,7 +708,7 @@ endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 19de7129ae0b..fef5c6e3b251 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1103,21 +1103,22 @@ static __cold void io_fallback_tw(struct io_uring_task *tctx, bool sync)
 	while (node) {
 		req = container_of(node, struct io_kiocb, io_task_work.node);
 		node = node->next;
-		if (sync && last_ctx != req->ctx) {
+		if (last_ctx != req->ctx) {
 			if (last_ctx) {
-				flush_delayed_work(&last_ctx->fallback_work);
+				if (sync)
+					flush_delayed_work(&last_ctx->fallback_work);
 				percpu_ref_put(&last_ctx->refs);
 			}
 			last_ctx = req->ctx;
 			percpu_ref_get(&last_ctx->refs);
 		}
-		if (llist_add(&req->io_task_work.node,
-			      &req->ctx->fallback_llist))
-			schedule_delayed_work(&req->ctx->fallback_work, 1);
+		if (llist_add(&req->io_task_work.node, &last_ctx->fallback_llist))
+			schedule_delayed_work(&last_ctx->fallback_work, 1);
 	}
 
 	if (last_ctx) {
-		flush_delayed_work(&last_ctx->fallback_work);
+		if (sync)
+			flush_delayed_work(&last_ctx->fallback_work);
 		percpu_ref_put(&last_ctx->refs);
 	}
 }
@@ -1777,7 +1778,7 @@ struct io_wq_work *io_wq_free_work(struct io_wq_work *work)
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
 	struct io_kiocb *nxt = NULL;
 
-	if (req_ref_put_and_test(req)) {
+	if (req_ref_put_and_test_atomic(req)) {
 		if (req->flags & IO_REQ_LINK_FLAGS)
 			nxt = io_req_find_next(req);
 		io_free_req(req);
diff --git a/io_uring/refs.h b/io_uring/refs.h
index 63982ead9f7d..0d928d87c4ed 100644
--- a/io_uring/refs.h
+++ b/io_uring/refs.h
@@ -17,6 +17,13 @@ static inline bool req_ref_inc_not_zero(struct io_kiocb *req)
 	return atomic_inc_not_zero(&req->refs);
 }
 
+static inline bool req_ref_put_and_test_atomic(struct io_kiocb *req)
+{
+	WARN_ON_ONCE(!(data_race(req->flags) & REQ_F_REFCOUNT));
+	WARN_ON_ONCE(req_ref_zero_or_close_to_overflow(req));
+	return atomic_dec_and_test(&req->refs);
+}
+
 static inline bool req_ref_put_and_test(struct io_kiocb *req)
 {
 	if (likely(!(req->flags & REQ_F_REFCOUNT)))
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 6547fb7ac0dc..129a51b1da1b 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -162,6 +162,7 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	   void *, value, u64, flags, gfp_t, gfp_flags)
 {
 	struct bpf_local_storage_data *sdata;
+	bool nobusy;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
@@ -170,21 +171,21 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	if (!cgroup)
 		return (unsigned long)NULL;
 
-	if (!bpf_cgrp_storage_trylock())
-		return (unsigned long)NULL;
+	nobusy = bpf_cgrp_storage_trylock();
 
-	sdata = cgroup_storage_lookup(cgroup, map, true);
+	sdata = cgroup_storage_lookup(cgroup, map, nobusy);
 	if (sdata)
 		goto unlock;
 
 	/* only allocate new storage, when the cgroup is refcounted */
 	if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
-	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
+	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy)
 		sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
 						 value, BPF_NOEXIST, gfp_flags);
 
 unlock:
-	bpf_cgrp_storage_unlock();
+	if (nobusy)
+		bpf_cgrp_storage_unlock();
 	return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
 }
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3ec941a0ea41..bb3ba8ebaf3d 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -198,12 +198,12 @@ static bool htab_is_percpu(const struct bpf_htab *htab)
 static inline void htab_elem_set_ptr(struct htab_elem *l, u32 key_size,
 				     void __percpu *pptr)
 {
-	*(void __percpu **)(l->key + key_size) = pptr;
+	*(void __percpu **)(l->key + roundup(key_size, 8)) = pptr;
 }
 
 static inline void __percpu *htab_elem_get_ptr(struct htab_elem *l, u32 key_size)
 {
-	return *(void __percpu **)(l->key + key_size);
+	return *(void __percpu **)(l->key + roundup(key_size, 8));
 }
 
 static void *fd_htab_map_get_ptr(const struct bpf_map *map, struct htab_elem *l)
@@ -2355,7 +2355,7 @@ static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0,
-				offsetof(struct htab_elem, key) + map->key_size);
+				offsetof(struct htab_elem, key) + roundup(map->key_size, 8));
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
 	*insn++ = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 
diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
index 0c63bc2cd895..56a81df7a9d7 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -89,4 +89,5 @@ static void __exit fini(void)
 }
 late_initcall(load);
 module_exit(fini);
+MODULE_IMPORT_NS("BPF_INTERNAL");
 MODULE_LICENSE("GPL");
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 696e5a2cbea2..977c08457756 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1457,7 +1457,7 @@ struct bpf_map *bpf_map_get(u32 ufd)
 
 	return map;
 }
-EXPORT_SYMBOL(bpf_map_get);
+EXPORT_SYMBOL_NS(bpf_map_get, BPF_INTERNAL);
 
 struct bpf_map *bpf_map_get_with_uref(u32 ufd)
 {
@@ -3223,7 +3223,7 @@ struct bpf_link *bpf_link_get_from_fd(u32 ufd)
 	bpf_link_inc(link);
 	return link;
 }
-EXPORT_SYMBOL(bpf_link_get_from_fd);
+EXPORT_SYMBOL_NS(bpf_link_get_from_fd, BPF_INTERNAL);
 
 static void bpf_tracing_link_release(struct bpf_link *link)
 {
@@ -5853,7 +5853,7 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 		return ____bpf_sys_bpf(cmd, attr, size);
 	}
 }
-EXPORT_SYMBOL(kern_sys_bpf);
+EXPORT_SYMBOL_NS(kern_sys_bpf, BPF_INTERNAL);
 
 static const struct bpf_func_proto bpf_sys_bpf_proto = {
 	.func		= bpf_sys_bpf,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d2ef289993f2..8656208aa4bb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22289,6 +22289,33 @@ BTF_ID(func, __rcu_read_unlock)
 #endif
 BTF_SET_END(btf_id_deny)
 
+/* fexit and fmod_ret can't be used to attach to __noreturn functions.
+ * Currently, we must manually list all __noreturn functions here. Once a more
+ * robust solution is implemented, this workaround can be removed.
+ */
+BTF_SET_START(noreturn_deny)
+#ifdef CONFIG_IA32_EMULATION
+BTF_ID(func, __ia32_sys_exit)
+BTF_ID(func, __ia32_sys_exit_group)
+#endif
+#ifdef CONFIG_KUNIT
+BTF_ID(func, __kunit_abort)
+BTF_ID(func, kunit_try_catch_throw)
+#endif
+#ifdef CONFIG_MODULES
+BTF_ID(func, __module_put_and_kthread_exit)
+#endif
+#ifdef CONFIG_X86_64
+BTF_ID(func, __x64_sys_exit)
+BTF_ID(func, __x64_sys_exit_group)
+#endif
+BTF_ID(func, do_exit)
+BTF_ID(func, do_group_exit)
+BTF_ID(func, kthread_complete_and_exit)
+BTF_ID(func, kthread_exit)
+BTF_ID(func, make_task_dead)
+BTF_SET_END(noreturn_deny)
+
 static bool can_be_sleepable(struct bpf_prog *prog)
 {
 	if (prog->type == BPF_PROG_TYPE_TRACING) {
@@ -22377,6 +22404,11 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	} else if (prog->type == BPF_PROG_TYPE_TRACING &&
 		   btf_id_set_contains(&btf_id_deny, btf_id)) {
 		return -EINVAL;
+	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
+		   btf_id_set_contains(&noreturn_deny, btf_id)) {
+		verbose(env, "Attaching fexit/fmod_ret to __noreturn functions is rejected.\n");
+		return -EINVAL;
 	}
 
 	key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4378f3eff25d..e63d6f3b0047 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2339,9 +2339,37 @@ static struct file_system_type cgroup2_fs_type = {
 };
 
 #ifdef CONFIG_CPUSETS_V1
+enum cpuset_param {
+	Opt_cpuset_v2_mode,
+};
+
+static const struct fs_parameter_spec cpuset_fs_parameters[] = {
+	fsparam_flag  ("cpuset_v2_mode", Opt_cpuset_v2_mode),
+	{}
+};
+
+static int cpuset_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, cpuset_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_cpuset_v2_mode:
+		ctx->flags |= CGRP_ROOT_CPUSET_V2_MODE;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static const struct fs_context_operations cpuset_fs_context_ops = {
 	.get_tree	= cgroup1_get_tree,
 	.free		= cgroup_fs_context_free,
+	.parse_param	= cpuset_parse_param,
 };
 
 /*
@@ -2378,6 +2406,7 @@ static int cpuset_init_fs_context(struct fs_context *fc)
 static struct file_system_type cpuset_fs_type = {
 	.name			= "cpuset",
 	.init_fs_context	= cpuset_init_fs_context,
+	.parameters		= cpuset_fs_parameters,
 	.fs_flags		= FS_USERNS_MOUNT,
 };
 #endif
diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 976a8bc3ff60..383963e28ac6 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -33,6 +33,7 @@ enum prs_errcode {
 	PERR_CPUSEMPTY,
 	PERR_HKEEPING,
 	PERR_ACCESS,
+	PERR_REMOTE,
 };
 
 /* bits in struct cpuset flags field */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 839f88ba17f7..c709a05023cd 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -62,6 +62,7 @@ static const char * const perr_strings[] = {
 	[PERR_CPUSEMPTY] = "cpuset.cpus and cpuset.cpus.exclusive are empty",
 	[PERR_HKEEPING]  = "partition config conflicts with housekeeping setup",
 	[PERR_ACCESS]    = "Enable partition not permitted",
+	[PERR_REMOTE]    = "Have remote partition underneath",
 };
 
 /*
@@ -2824,6 +2825,19 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 			goto out;
 		}
 
+		/*
+		 * We don't support the creation of a new local partition with
+		 * a remote partition underneath it. This unsupported
+		 * setting can happen only if parent is the top_cpuset because
+		 * a remote partition cannot be created underneath an existing
+		 * local or remote partition.
+		 */
+		if ((parent == &top_cpuset) &&
+		    cpumask_intersects(cs->exclusive_cpus, subpartitions_cpus)) {
+			err = PERR_REMOTE;
+			goto out;
+		}
+
 		/*
 		 * If parent is valid partition, enable local partiion.
 		 * Otherwise, enable a remote partition.
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 055da410ac71..8df0dfaaca18 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -64,8 +64,7 @@ struct cma *dma_contiguous_default_area;
  * Users, who want to set the size of global CMA area for their system
  * should use cma= kernel parameter.
  */
-static const phys_addr_t size_bytes __initconst =
-	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
+#define size_bytes ((phys_addr_t)CMA_SIZE_MBYTES * SZ_1M)
 static phys_addr_t  size_cmdline __initdata = -1;
 static phys_addr_t base_cmdline __initdata;
 static phys_addr_t limit_cmdline __initdata;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 97af53c43608..edafe9fc4bdd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13661,6 +13661,9 @@ inherit_event(struct perf_event *parent_event,
 	if (IS_ERR(child_event))
 		return child_event;
 
+	get_ctx(child_ctx);
+	child_event->ctx = child_ctx;
+
 	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
 	if (IS_ERR(pmu_ctx)) {
 		free_event(child_event);
@@ -13683,8 +13686,6 @@ inherit_event(struct perf_event *parent_event,
 		return NULL;
 	}
 
-	get_ctx(child_ctx);
-
 	/*
 	 * Make the child state follow the state of the parent event,
 	 * not its attr.disabled bit.  We hold the parent's mutex,
@@ -13705,7 +13706,6 @@ inherit_event(struct perf_event *parent_event,
 		local64_set(&hwc->period_left, sample_period);
 	}
 
-	child_event->ctx = child_ctx;
 	child_event->overflow_handler = parent_event->overflow_handler;
 	child_event->overflow_handler_context
 		= parent_event->overflow_handler_context;
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 396a067a8a56..7682c36cbccc 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1143,7 +1143,7 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
 	if (!(info->flags & MSI_FLAG_MUST_REACTIVATE))
 		return false;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_ignore_mask)
+	if (info->flags & MSI_FLAG_NO_MASK)
 		return false;
 
 	/*
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 7c6588148d42..0c746a150e34 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -231,6 +231,7 @@ comment "Do not forget to sign required modules with scripts/sign-file"
 choice
 	prompt "Hash algorithm to sign modules"
 	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
+	default MODULE_SIG_SHA512
 	help
 	  This determines which sort of hashing algorithm will be used during
 	  signature generation.  This algorithm _must_ be built into the kernel
diff --git a/kernel/panic.c b/kernel/panic.c
index fbc59b3b64d0..ddad0578355b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -832,9 +832,15 @@ device_initcall(register_warn_debugfs);
  */
 __visible noinstr void __stack_chk_fail(void)
 {
+	unsigned long flags;
+
 	instrumentation_begin();
+	flags = user_access_save();
+
 	panic("stack-protector: Kernel stack is corrupted in: %pB",
 		__builtin_return_address(0));
+
+	user_access_restore(flags);
 	instrumentation_end();
 }
 EXPORT_SYMBOL(__stack_chk_fail);
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 927cc55ba0b3..4e1778071d70 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -161,22 +161,10 @@ static void em_debug_create_pd(struct device *dev) {}
 static void em_debug_remove_pd(struct device *dev) {}
 #endif
 
-static void em_destroy_table_rcu(struct rcu_head *rp)
-{
-	struct em_perf_table __rcu *table;
-
-	table = container_of(rp, struct em_perf_table, rcu);
-	kfree(table);
-}
-
 static void em_release_table_kref(struct kref *kref)
 {
-	struct em_perf_table __rcu *table;
-
 	/* It was the last owner of this table so we can free */
-	table = container_of(kref, struct em_perf_table, kref);
-
-	call_rcu(&table->rcu, em_destroy_table_rcu);
+	kfree_rcu(container_of(kref, struct em_perf_table, kref), rcu);
 }
 
 /**
@@ -185,7 +173,7 @@ static void em_release_table_kref(struct kref *kref)
  *
  * No return values.
  */
-void em_table_free(struct em_perf_table __rcu *table)
+void em_table_free(struct em_perf_table *table)
 {
 	kref_put(&table->kref, em_release_table_kref);
 }
@@ -198,9 +186,9 @@ void em_table_free(struct em_perf_table __rcu *table)
  * has a user.
  * Returns allocated table or NULL.
  */
-struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd)
+struct em_perf_table *em_table_alloc(struct em_perf_domain *pd)
 {
-	struct em_perf_table __rcu *table;
+	struct em_perf_table *table;
 	int table_size;
 
 	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
@@ -308,9 +296,9 @@ int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
  * Return 0 on success or an error code on failure.
  */
 int em_dev_update_perf_domain(struct device *dev,
-			      struct em_perf_table __rcu *new_table)
+			      struct em_perf_table *new_table)
 {
-	struct em_perf_table __rcu *old_table;
+	struct em_perf_table *old_table;
 	struct em_perf_domain *pd;
 
 	if (!dev)
@@ -327,7 +315,8 @@ int em_dev_update_perf_domain(struct device *dev,
 
 	kref_get(&new_table->kref);
 
-	old_table = pd->em_table;
+	old_table = rcu_dereference_protected(pd->em_table,
+					      lockdep_is_held(&em_pd_mutex));
 	rcu_assign_pointer(pd->em_table, new_table);
 
 	em_cpufreq_update_efficiencies(dev, new_table->state);
@@ -399,7 +388,7 @@ static int em_create_pd(struct device *dev, int nr_states,
 			struct em_data_callback *cb, cpumask_t *cpus,
 			unsigned long flags)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 	struct em_perf_domain *pd;
 	struct device *cpu_dev;
 	int cpu, ret, num_cpus;
@@ -559,6 +548,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				struct em_data_callback *cb, cpumask_t *cpus,
 				bool microwatts)
 {
+	struct em_perf_table *em_table;
 	unsigned long cap, prev_cap = 0;
 	unsigned long flags = 0;
 	int cpu, ret;
@@ -629,7 +619,9 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 
 	dev->em_pd->flags |= flags;
 
-	em_cpufreq_update_efficiencies(dev, dev->em_pd->em_table->state);
+	em_table = rcu_dereference_protected(dev->em_pd->em_table,
+					     lockdep_is_held(&em_pd_mutex));
+	em_cpufreq_update_efficiencies(dev, em_table->state);
 
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
@@ -666,7 +658,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	mutex_lock(&em_pd_mutex);
 	em_debug_remove_pd(dev);
 
-	em_table_free(dev->em_pd->em_table);
+	em_table_free(rcu_dereference_protected(dev->em_pd->em_table,
+						lockdep_is_held(&em_pd_mutex)));
 
 	kfree(dev->em_pd);
 	dev->em_pd = NULL;
@@ -674,9 +667,9 @@ void em_dev_unregister_perf_domain(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);
 
-static struct em_perf_table __rcu *em_table_dup(struct em_perf_domain *pd)
+static struct em_perf_table *em_table_dup(struct em_perf_domain *pd)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 	struct em_perf_state *ps, *new_ps;
 	int ps_size;
 
@@ -698,7 +691,7 @@ static struct em_perf_table __rcu *em_table_dup(struct em_perf_domain *pd)
 }
 
 static int em_recalc_and_update(struct device *dev, struct em_perf_domain *pd,
-				struct em_perf_table __rcu *em_table)
+				struct em_perf_table *em_table)
 {
 	int ret;
 
@@ -729,7 +722,7 @@ static void em_adjust_new_capacity(struct device *dev,
 				   struct em_perf_domain *pd,
 				   u64 max_cap)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 
 	em_table = em_table_dup(pd);
 	if (!em_table) {
@@ -820,7 +813,7 @@ static void em_update_workfn(struct work_struct *work)
  */
 int em_dev_update_chip_binning(struct device *dev)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 	struct em_perf_domain *pd;
 	int i, ret;
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fcf968490308..7ed25654820f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4530,7 +4530,7 @@ static void scx_ops_bypass(bool bypass)
 
 static void free_exit_info(struct scx_exit_info *ei)
 {
-	kfree(ei->dump);
+	kvfree(ei->dump);
 	kfree(ei->msg);
 	kfree(ei->bt);
 	kfree(ei);
@@ -4546,7 +4546,7 @@ static struct scx_exit_info *alloc_exit_info(size_t exit_dump_len)
 
 	ei->bt = kcalloc(SCX_EXIT_BT_LEN, sizeof(ei->bt[0]), GFP_KERNEL);
 	ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
-	ei->dump = kzalloc(exit_dump_len, GFP_KERNEL);
+	ei->dump = kvzalloc(exit_dump_len, GFP_KERNEL);
 
 	if (!ei->bt || !ei->msg || !ei->dump) {
 		free_exit_info(ei);
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index a47bcf71defc..9a3859443c04 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -509,6 +509,7 @@ void tick_resume(void)
 
 #ifdef CONFIG_SUSPEND
 static DEFINE_RAW_SPINLOCK(tick_freeze_lock);
+static DEFINE_WAIT_OVERRIDE_MAP(tick_freeze_map, LD_WAIT_SLEEP);
 static unsigned int tick_freeze_depth;
 
 /**
@@ -528,9 +529,22 @@ void tick_freeze(void)
 	if (tick_freeze_depth == num_online_cpus()) {
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), true);
+		/*
+		 * All other CPUs have their interrupts disabled and are
+		 * suspended to idle. Other tasks have been frozen so there
+		 * is no scheduling happening. This means that there is no
+		 * concurrency in the system at this point. Therefore it is
+		 * okay to acquire a sleeping lock on PREEMPT_RT, such as a
+		 * spinlock, because the lock cannot be held by other CPUs
+		 * or threads and acquiring it cannot block.
+		 *
+		 * Inform lockdep about the situation.
+		 */
+		lock_map_acquire_try(&tick_freeze_map);
 		system_state = SYSTEM_SUSPEND;
 		sched_clock_suspend();
 		timekeeping_suspend();
+		lock_map_release(&tick_freeze_map);
 	} else {
 		tick_suspend_local();
 	}
@@ -552,8 +566,16 @@ void tick_unfreeze(void)
 	raw_spin_lock(&tick_freeze_lock);
 
 	if (tick_freeze_depth == num_online_cpus()) {
+		/*
+		 * Similar to tick_freeze(). On resumption the first CPU may
+		 * acquire uncontended sleeping locks while other CPUs block on
+		 * tick_freeze_lock.
+		 */
+		lock_map_acquire_try(&tick_freeze_map);
 		timekeeping_resume();
 		sched_clock_resume();
+		lock_map_release(&tick_freeze_map);
+
 		system_state = SYSTEM_RUNNING;
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), false);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 55f279ddfd63..e5c063fc8ef9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -403,7 +403,7 @@ static const struct bpf_func_proto bpf_trace_printk_proto = {
 	.arg2_type	= ARG_CONST_SIZE,
 };
 
-static void __set_printk_clr_event(void)
+static void __set_printk_clr_event(struct work_struct *work)
 {
 	/*
 	 * This program might be calling bpf_trace_printk,
@@ -416,10 +416,11 @@ static void __set_printk_clr_event(void)
 	if (trace_set_clr_event("bpf_trace", "bpf_trace_printk", 1))
 		pr_warn_ratelimited("could not enable bpf_trace_printk events");
 }
+static DECLARE_WORK(set_printk_work, __set_printk_clr_event);
 
 const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
 {
-	__set_printk_clr_event();
+	schedule_work(&set_printk_work);
 	return &bpf_trace_printk_proto;
 }
 
@@ -462,7 +463,7 @@ static const struct bpf_func_proto bpf_trace_vprintk_proto = {
 
 const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
 {
-	__set_printk_clr_event();
+	schedule_work(&set_printk_work);
 	return &bpf_trace_vprintk_proto;
 }
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 11dea25ef880..15fb255733fb 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -470,6 +470,7 @@ static void test_event_printk(struct trace_event_call *call)
 			case '%':
 				continue;
 			case 'p':
+ do_pointer:
 				/* Find dereferencing fields */
 				switch (fmt[i + 1]) {
 				case 'B': case 'R': case 'r':
@@ -498,6 +499,12 @@ static void test_event_printk(struct trace_event_call *call)
 						continue;
 					if (fmt[i + j] == '*') {
 						star = true;
+						/* Handle %*pbl case */
+						if (!j && fmt[i + 1] == 'p') {
+							arg++;
+							i++;
+							goto do_pointer;
+						}
 						continue;
 					}
 					if ((fmt[i + j] == 's')) {
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 1d4aa7a83b3a..37655f58b855 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -118,7 +118,6 @@ config UBSAN_UNREACHABLE
 
 config UBSAN_SIGNED_WRAP
 	bool "Perform checking for signed arithmetic wrap-around"
-	default UBSAN
 	depends on !COMPILE_TEST
 	# The no_sanitize attribute was introduced in GCC with version 8.
 	depends on !CC_IS_GCC || GCC_VERSION >= 80000
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index b01253cac70a..b09e78da959a 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -42,7 +42,7 @@ config CRYPTO_LIB_BLAKE2S_GENERIC
 	  of CRYPTO_LIB_BLAKE2S.
 
 config CRYPTO_ARCH_HAVE_LIB_CHACHA
-	tristate
+	bool
 	help
 	  Declares whether the architecture provides an arch-specific
 	  accelerated implementation of the ChaCha library interface,
@@ -58,17 +58,21 @@ config CRYPTO_LIB_CHACHA_GENERIC
 	  implementation is enabled, this implementation serves the users
 	  of CRYPTO_LIB_CHACHA.
 
+config CRYPTO_LIB_CHACHA_INTERNAL
+	tristate
+	select CRYPTO_LIB_CHACHA_GENERIC if CRYPTO_ARCH_HAVE_LIB_CHACHA=n
+
 config CRYPTO_LIB_CHACHA
 	tristate "ChaCha library interface"
-	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
-	select CRYPTO_LIB_CHACHA_GENERIC if CRYPTO_ARCH_HAVE_LIB_CHACHA=n
+	select CRYPTO
+	select CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Enable the ChaCha library interface. This interface may be fulfilled
 	  by either the generic implementation or an arch-specific one, if one
 	  is available and enabled.
 
 config CRYPTO_ARCH_HAVE_LIB_CURVE25519
-	tristate
+	bool
 	help
 	  Declares whether the architecture provides an arch-specific
 	  accelerated implementation of the Curve25519 library interface,
@@ -76,6 +80,7 @@ config CRYPTO_ARCH_HAVE_LIB_CURVE25519
 
 config CRYPTO_LIB_CURVE25519_GENERIC
 	tristate
+	select CRYPTO_LIB_UTILS
 	help
 	  This symbol can be depended upon by arch implementations of the
 	  Curve25519 library interface that require the generic code as a
@@ -83,11 +88,14 @@ config CRYPTO_LIB_CURVE25519_GENERIC
 	  implementation is enabled, this implementation serves the users
 	  of CRYPTO_LIB_CURVE25519.
 
+config CRYPTO_LIB_CURVE25519_INTERNAL
+	tristate
+	select CRYPTO_LIB_CURVE25519_GENERIC if CRYPTO_ARCH_HAVE_LIB_CURVE25519=n
+
 config CRYPTO_LIB_CURVE25519
 	tristate "Curve25519 scalar multiplication library"
-	depends on CRYPTO_ARCH_HAVE_LIB_CURVE25519 || !CRYPTO_ARCH_HAVE_LIB_CURVE25519
-	select CRYPTO_LIB_CURVE25519_GENERIC if CRYPTO_ARCH_HAVE_LIB_CURVE25519=n
-	select CRYPTO_LIB_UTILS
+	select CRYPTO
+	select CRYPTO_LIB_CURVE25519_INTERNAL
 	help
 	  Enable the Curve25519 library interface. This interface may be
 	  fulfilled by either the generic implementation or an arch-specific
@@ -104,7 +112,7 @@ config CRYPTO_LIB_POLY1305_RSIZE
 	default 1
 
 config CRYPTO_ARCH_HAVE_LIB_POLY1305
-	tristate
+	bool
 	help
 	  Declares whether the architecture provides an arch-specific
 	  accelerated implementation of the Poly1305 library interface,
@@ -119,10 +127,14 @@ config CRYPTO_LIB_POLY1305_GENERIC
 	  implementation is enabled, this implementation serves the users
 	  of CRYPTO_LIB_POLY1305.
 
+config CRYPTO_LIB_POLY1305_INTERNAL
+	tristate
+	select CRYPTO_LIB_POLY1305_GENERIC if CRYPTO_ARCH_HAVE_LIB_POLY1305=n
+
 config CRYPTO_LIB_POLY1305
 	tristate "Poly1305 library interface"
-	depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305
-	select CRYPTO_LIB_POLY1305_GENERIC if CRYPTO_ARCH_HAVE_LIB_POLY1305=n
+	select CRYPTO
+	select CRYPTO_LIB_POLY1305_INTERNAL
 	help
 	  Enable the Poly1305 library interface. This interface may be fulfilled
 	  by either the generic implementation or an arch-specific one, if one
@@ -130,11 +142,10 @@ config CRYPTO_LIB_POLY1305
 
 config CRYPTO_LIB_CHACHA20POLY1305
 	tristate "ChaCha20-Poly1305 AEAD support (8-byte nonce library version)"
-	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
-	depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305
-	depends on CRYPTO
+	select CRYPTO
 	select CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_POLY1305
+	select CRYPTO_LIB_UTILS
 	select CRYPTO_ALGAPI
 
 config CRYPTO_LIB_SHA1
diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
index 5d7b10e98610..63b7566e7863 100644
--- a/lib/test_ubsan.c
+++ b/lib/test_ubsan.c
@@ -68,18 +68,22 @@ static void test_ubsan_shift_out_of_bounds(void)
 
 static void test_ubsan_out_of_bounds(void)
 {
-	volatile int i = 4, j = 5, k = -1;
-	volatile char above[4] = { }; /* Protect surrounding memory. */
-	volatile int arr[4];
-	volatile char below[4] = { }; /* Protect surrounding memory. */
+	int i = 4, j = 4, k = -1;
+	volatile struct {
+		char above[4]; /* Protect surrounding memory. */
+		int arr[4];
+		char below[4]; /* Protect surrounding memory. */
+	} data;
 
-	above[0] = below[0];
+	OPTIMIZER_HIDE_VAR(i);
+	OPTIMIZER_HIDE_VAR(j);
+	OPTIMIZER_HIDE_VAR(k);
 
 	UBSAN_TEST(CONFIG_UBSAN_BOUNDS, "above");
-	arr[j] = i;
+	data.arr[j] = i;
 
 	UBSAN_TEST(CONFIG_UBSAN_BOUNDS, "below");
-	arr[k] = i;
+	data.arr[k] = i;
 }
 
 enum ubsan_test_enum {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 39b3c7f35ea8..0eb5d510d4f6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1079,6 +1079,13 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (!folio_trylock(folio))
 			goto keep;
 
+		if (folio_contain_hwpoisoned_page(folio)) {
+			unmap_poisoned_folio(folio, folio_pfn(folio), false);
+			folio_unlock(folio);
+			folio_put(folio);
+			continue;
+		}
+
 		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
 
 		nr_pages = folio_nr_pages(folio);
diff --git a/net/9p/client.c b/net/9p/client.c
index 09f8ced9f8bb..52a5497cfca7 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1548,7 +1548,8 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 	struct p9_client *clnt = fid->clnt;
 	struct p9_req_t *req;
 	int count = iov_iter_count(to);
-	int rsize, received, non_zc = 0;
+	u32 rsize, received;
+	bool non_zc = false;
 	char *dataptr;
 
 	*err = 0;
@@ -1571,7 +1572,7 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 				       0, 11, "dqd", fid->fid,
 				       offset, rsize);
 	} else {
-		non_zc = 1;
+		non_zc = true;
 		req = p9_client_rpc(clnt, P9_TREAD, "dqd", fid->fid, offset,
 				    rsize);
 	}
@@ -1592,11 +1593,11 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 		return 0;
 	}
 	if (rsize < received) {
-		pr_err("bogus RREAD count (%d > %d)\n", received, rsize);
+		pr_err("bogus RREAD count (%u > %u)\n", received, rsize);
 		received = rsize;
 	}
 
-	p9_debug(P9_DEBUG_9P, "<<< RREAD count %d\n", received);
+	p9_debug(P9_DEBUG_9P, "<<< RREAD count %u\n", received);
 
 	if (non_zc) {
 		int n = copy_to_iter(dataptr, received, to);
@@ -1623,9 +1624,9 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 	*err = 0;
 
 	while (iov_iter_count(from)) {
-		int count = iov_iter_count(from);
-		int rsize = fid->iounit;
-		int written;
+		size_t count = iov_iter_count(from);
+		u32 rsize = fid->iounit;
+		u32 written;
 
 		if (!rsize || rsize > clnt->msize - P9_IOHDRSZ)
 			rsize = clnt->msize - P9_IOHDRSZ;
@@ -1633,7 +1634,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 		if (count < rsize)
 			rsize = count;
 
-		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %d (/%d)\n",
+		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %u (/%zu)\n",
 			 fid->fid, offset, rsize, count);
 
 		/* Don't bother zerocopy for small IO (< 1024) */
@@ -1659,11 +1660,11 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 			break;
 		}
 		if (rsize < written) {
-			pr_err("bogus RWRITE count (%d > %d)\n", written, rsize);
+			pr_err("bogus RWRITE count (%u > %u)\n", written, rsize);
 			written = rsize;
 		}
 
-		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", written);
+		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %u\n", written);
 
 		p9_req_put(clnt, req);
 		iov_iter_revert(from, count - written - iov_iter_count(from));
@@ -2098,7 +2099,8 @@ EXPORT_SYMBOL_GPL(p9_client_xattrcreate);
 
 int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 {
-	int err, rsize, non_zc = 0;
+	int err, non_zc = 0;
+	u32 rsize;
 	struct p9_client *clnt;
 	struct p9_req_t *req;
 	char *dataptr;
@@ -2107,7 +2109,7 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 
 	iov_iter_kvec(&to, ITER_DEST, &kv, 1, count);
 
-	p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %d\n",
+	p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %u\n",
 		 fid->fid, offset, count);
 
 	clnt = fid->clnt;
@@ -2142,11 +2144,11 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 		goto free_and_error;
 	}
 	if (rsize < count) {
-		pr_err("bogus RREADDIR count (%d > %d)\n", count, rsize);
+		pr_err("bogus RREADDIR count (%u > %u)\n", count, rsize);
 		count = rsize;
 	}
 
-	p9_debug(P9_DEBUG_9P, "<<< RREADDIR count %d\n", count);
+	p9_debug(P9_DEBUG_9P, "<<< RREADDIR count %u\n", count);
 
 	if (non_zc)
 		memmove(data, dataptr, count);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 196060dc6138..791e4868f2d4 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -191,12 +191,13 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 
 	spin_lock(&m->req_lock);
 
-	if (m->err) {
+	if (READ_ONCE(m->err)) {
 		spin_unlock(&m->req_lock);
 		return;
 	}
 
-	m->err = err;
+	WRITE_ONCE(m->err, err);
+	ASSERT_EXCLUSIVE_WRITER(m->err);
 
 	list_for_each_entry_safe(req, rtmp, &m->req_list, req_list) {
 		list_move(&req->req_list, &cancel_list);
@@ -283,7 +284,7 @@ static void p9_read_work(struct work_struct *work)
 
 	m = container_of(work, struct p9_conn, rq);
 
-	if (m->err < 0)
+	if (READ_ONCE(m->err) < 0)
 		return;
 
 	p9_debug(P9_DEBUG_TRANS, "start mux %p pos %zd\n", m, m->rc.offset);
@@ -450,7 +451,7 @@ static void p9_write_work(struct work_struct *work)
 
 	m = container_of(work, struct p9_conn, wq);
 
-	if (m->err < 0) {
+	if (READ_ONCE(m->err) < 0) {
 		clear_bit(Wworksched, &m->wsched);
 		return;
 	}
@@ -622,7 +623,7 @@ static void p9_poll_mux(struct p9_conn *m)
 	__poll_t n;
 	int err = -ECONNRESET;
 
-	if (m->err < 0)
+	if (READ_ONCE(m->err) < 0)
 		return;
 
 	n = p9_fd_poll(m->client, NULL, &err);
@@ -665,6 +666,7 @@ static void p9_poll_mux(struct p9_conn *m)
 static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 {
 	__poll_t n;
+	int err;
 	struct p9_trans_fd *ts = client->trans;
 	struct p9_conn *m = &ts->conn;
 
@@ -673,9 +675,10 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 
 	spin_lock(&m->req_lock);
 
-	if (m->err < 0) {
+	err = READ_ONCE(m->err);
+	if (err < 0) {
 		spin_unlock(&m->req_lock);
-		return m->err;
+		return err;
 	}
 
 	WRITE_ONCE(req->status, REQ_STATUS_UNSENT);
diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index 4417a18b3e95..f63586c9ce02 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -332,6 +332,8 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	struct dst_entry *dst;
 	int ret;
 
+	local_bh_disable();
+
 	if (dev_xmit_recursion()) {
 		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
 				     __func__);
@@ -347,8 +349,10 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	lwtstate = dst->lwtstate;
 
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
-		return 0;
+	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
@@ -363,11 +367,13 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (ret == -EOPNOTSUPP)
 		goto drop;
 
-	return ret;
+	goto out;
 
 drop:
 	kfree_skb(skb);
 
+out:
+	local_bh_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lwtunnel_output);
@@ -379,6 +385,8 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	struct dst_entry *dst;
 	int ret;
 
+	local_bh_disable();
+
 	if (dev_xmit_recursion()) {
 		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
 				     __func__);
@@ -395,8 +403,10 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	lwtstate = dst->lwtstate;
 
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
-		return 0;
+	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
@@ -411,11 +421,13 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	if (ret == -EOPNOTSUPP)
 		goto drop;
 
-	return ret;
+	goto out;
 
 drop:
 	kfree_skb(skb);
 
+out:
+	local_bh_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lwtunnel_xmit);
@@ -427,6 +439,8 @@ int lwtunnel_input(struct sk_buff *skb)
 	struct dst_entry *dst;
 	int ret;
 
+	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
+
 	if (dev_xmit_recursion()) {
 		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
 				     __func__);
diff --git a/net/core/selftests.c b/net/core/selftests.c
index 8f801e6e3b91..561653f9d71d 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -100,10 +100,10 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 	ehdr->h_proto = htons(ETH_P_IP);
 
 	if (attr->tcp) {
+		memset(thdr, 0, sizeof(*thdr));
 		thdr->source = htons(attr->sport);
 		thdr->dest = htons(attr->dport);
 		thdr->doff = sizeof(struct tcphdr) / 4;
-		thdr->check = 0;
 	} else {
 		uhdr->source = htons(attr->sport);
 		uhdr->dest = htons(attr->dport);
@@ -144,10 +144,18 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 	attr->id = net_test_next_id;
 	shdr->id = net_test_next_id++;
 
-	if (attr->size)
-		skb_put(skb, attr->size);
-	if (attr->max_size && attr->max_size > skb->len)
-		skb_put(skb, attr->max_size - skb->len);
+	if (attr->size) {
+		void *payload = skb_put(skb, attr->size);
+
+		memset(payload, 0, attr->size);
+	}
+
+	if (attr->max_size && attr->max_size > skb->len) {
+		size_t pad_len = attr->max_size - skb->len;
+		void *pad = skb_put(skb, pad_len);
+
+		memset(pad, 0, pad_len);
+	}
 
 	skb->csum = 0;
 	skb->ip_summed = CHECKSUM_PARTIAL;
diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
index 09fff5d424ef..d25d717c121f 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -70,6 +70,11 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	const struct net_device *oif;
 	const struct net_device *found;
 
+	if (nft_fib_can_skip(pkt)) {
+		nft_fib_store_result(dest, priv, nft_in(pkt));
+		return;
+	}
+
 	/*
 	 * Do not set flowi4_oif, it restricts results (for example, asking
 	 * for oif 3 will get RTN_UNICAST result even if the daddr exits
@@ -84,12 +89,6 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	else
 		oif = NULL;
 
-	if (nft_hook(pkt) == NF_INET_PRE_ROUTING &&
-	    nft_fib_is_loopback(pkt->skb, nft_in(pkt))) {
-		nft_fib_store_result(dest, priv, nft_in(pkt));
-		return;
-	}
-
 	iph = skb_header_pointer(pkt->skb, noff, sizeof(_iph), &_iph);
 	if (!iph) {
 		regs->verdict.code = NFT_BREAK;
diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index c9f1634b3838..7fd9d7b21cd4 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -170,6 +170,11 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	struct rt6_info *rt;
 	int lookup_flags;
 
+	if (nft_fib_can_skip(pkt)) {
+		nft_fib_store_result(dest, priv, nft_in(pkt));
+		return;
+	}
+
 	if (priv->flags & NFTA_FIB_F_IIF)
 		oif = nft_in(pkt);
 	else if (priv->flags & NFTA_FIB_F_OIF)
@@ -181,17 +186,13 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		return;
 	}
 
-	lookup_flags = nft_fib6_flowi_init(&fl6, priv, pkt, oif, iph);
-
-	if (nft_hook(pkt) == NF_INET_PRE_ROUTING ||
-	    nft_hook(pkt) == NF_INET_INGRESS) {
-		if (nft_fib_is_loopback(pkt->skb, nft_in(pkt)) ||
-		    nft_fib_v6_skip_icmpv6(pkt->skb, pkt->tprot, iph)) {
-			nft_fib_store_result(dest, priv, nft_in(pkt));
-			return;
-		}
+	if (nft_fib_v6_skip_icmpv6(pkt->skb, pkt->tprot, iph)) {
+		nft_fib_store_result(dest, priv, nft_in(pkt));
+		return;
 	}
 
+	lookup_flags = nft_fib6_flowi_init(&fl6, priv, pkt, oif, iph);
+
 	*dest = 0;
 	rt = (void *)ip6_route_lookup(nft_net(pkt), &fl6, pkt->skb,
 				      lookup_flags);
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index c287bf8423b4..5bb4ab9941d6 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -958,6 +958,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 	if (cl != NULL) {
 		int old_flags;
+		int len = 0;
 
 		if (parentid) {
 			if (cl->cl_parent &&
@@ -988,9 +989,13 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (usc != NULL)
 			hfsc_change_usc(cl, usc, cur_time);
 
+		if (cl->qdisc->q.qlen != 0)
+			len = qdisc_peek_len(cl->qdisc);
+		/* Check queue length again since some qdisc implementations
+		 * (e.g., netem/codel) might empty the queue during the peek
+		 * operation.
+		 */
 		if (cl->qdisc->q.qlen != 0) {
-			int len = qdisc_peek_len(cl->qdisc);
-
 			if (cl->cl_flags & HFSC_RSC) {
 				if (old_flags & HFSC_RSC)
 					update_ed(cl, len);
@@ -1632,10 +1637,16 @@ hfsc_dequeue(struct Qdisc *sch)
 		if (cl->qdisc->q.qlen != 0) {
 			/* update ed */
 			next_len = qdisc_peek_len(cl->qdisc);
-			if (realtime)
-				update_ed(cl, next_len);
-			else
-				update_d(cl, next_len);
+			/* Check queue length again since some qdisc implementations
+			 * (e.g., netem/codel) might empty the queue during the peek
+			 * operation.
+			 */
+			if (cl->qdisc->q.qlen != 0) {
+				if (realtime)
+					update_ed(cl, next_len);
+				else
+					update_d(cl, next_len);
+			}
 		} else {
 			/* the class becomes passive */
 			eltree_remove(cl);
diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index e2f19627e43d..b45c5b91bc7a 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -716,7 +716,8 @@ void tipc_mon_reinit_self(struct net *net)
 		if (!mon)
 			continue;
 		write_lock_bh(&mon->lock);
-		mon->self->addr = tipc_own_addr(net);
+		if (mon->self)
+			mon->self->addr = tipc_own_addr(net);
 		write_unlock_bh(&mon->lock);
 	}
 }
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index c5162fdc95ff..74c61bd61fbc 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
 
-use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
+use crate::{bindings, device::Device, error::Error, error::Result, ffi, str::CStr};
 use core::ptr::NonNull;
 
 /// # Invariants
@@ -12,7 +12,11 @@
 /// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
 /// `bindings::firmware_request_platform`, `bindings::request_firmware_direct`.
 struct FwFunc(
-    unsafe extern "C" fn(*mut *const bindings::firmware, *const u8, *mut bindings::device) -> i32,
+    unsafe extern "C" fn(
+        *mut *const bindings::firmware,
+        *const ffi::c_char,
+        *mut bindings::device,
+    ) -> i32,
 );
 
 impl FwFunc {
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 55f9a3da92d5..1a05fc153353 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -319,7 +319,8 @@ TRACE_EVENT(foo_bar,
 		__assign_cpumask(cpum, cpumask_bits(mask));
 	),
 
-	TP_printk("foo %s %d %s %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
+	TP_printk("foo %s %d %s %s %s %s %s %s (%s) (%s) %s [%d] %*pbl",
+		  __entry->foo, __entry->bar,
 
 /*
  * Notice here the use of some helper functions. This includes:
@@ -363,9 +364,17 @@ TRACE_EVENT(foo_bar,
 		  __print_array(__get_dynamic_array(list),
 				__get_dynamic_array_len(list) / sizeof(int),
 				sizeof(int)),
+
+/*     A shortcut is to use __print_dynamic_array for dynamic arrays */
+
+		  __print_dynamic_array(list, sizeof(int)),
+
 		  __get_str(str), __get_str(lstr),
 		  __get_bitmask(cpus), __get_cpumask(cpum),
-		  __get_str(vstr))
+		  __get_str(vstr),
+		  __get_dynamic_array_len(cpus),
+		  __get_dynamic_array_len(cpus),
+		  __get_dynamic_array(cpus))
 );
 
 /*
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index fe5e132fcea8..85e41c68c2c5 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -257,7 +257,7 @@ objtool-args-$(CONFIG_MITIGATION_SLS)			+= --sls
 objtool-args-$(CONFIG_STACK_VALIDATION)			+= --stackval
 objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
 objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
-objtool-args-$(CONFIG_GCOV_KERNEL)			+= --no-unreachable
+objtool-args-$(or $(CONFIG_GCOV_KERNEL),$(CONFIG_KCOV))	+= --no-unreachable
 objtool-args-$(CONFIG_PREFIX_SYMBOLS)			+= --prefix=$(CONFIG_FUNCTION_PADDING_BYTES)
 
 objtool-args = $(objtool-args-y)					\
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 1284f05555b9..0c2494ffcaf8 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -33,6 +33,10 @@ targets += vmlinux
 vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
 	+$(call if_changed_dep,link_vmlinux)
 
+ifdef CONFIG_BUILDTIME_TABLE_SORT
+vmlinux: scripts/sorttable
+endif
+
 # module.builtin.ranges
 # ---------------------------------------------------------------------------
 ifdef CONFIG_BUILTIN_MODULE_RANGES
diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 910852eb9698..c7f1b28f3b23 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -2273,7 +2273,7 @@ static irqreturn_t wcd934x_slim_irq_handler(int irq, void *data)
 {
 	struct wcd934x_codec *wcd = data;
 	unsigned long status = 0;
-	int i, j, port_id;
+	unsigned int i, j, port_id;
 	unsigned int val, int_val = 0;
 	irqreturn_t ret = IRQ_NONE;
 	bool tx;
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index f501f47242fb..1bba48318e2d 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -156,11 +156,24 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	for_each_dpcm_be(rtd, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *substream_be;
-		struct snd_soc_dai *dai = snd_soc_rtd_to_cpu(be, 0);
+		struct snd_soc_dai *dai_cpu = snd_soc_rtd_to_cpu(be, 0);
+		struct snd_soc_dai *dai_codec = snd_soc_rtd_to_codec(be, 0);
+		struct snd_soc_dai *dai;
 
 		if (dpcm->fe != rtd)
 			continue;
 
+		/*
+		 * With audio graph card, original cpu dai is changed to codec
+		 * device in backend, so if cpu dai is dummy device in backend,
+		 * get the codec dai device, which is the real hardware device
+		 * connected.
+		 */
+		if (!snd_soc_dai_is_dummy(dai_cpu))
+			dai = dai_cpu;
+		else
+			dai = dai_codec;
+
 		substream_be = snd_soc_dpcm_get_substream(be, stream);
 		dma_params_be = snd_soc_dai_get_dma_data(dai, substream_be);
 		dev_be = dai->dev;
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index 967e4c45be9b..2f7c5e709f07 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -339,6 +339,21 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
 	if (!snd->substreams)
 		return -ENOMEM;
 
+	/*
+	 * Initialize critical substream fields early in case we hit an
+	 * error path and end up trying to clean up uninitialized structures
+	 * elsewhere.
+	 */
+	for (i = 0; i < snd->nsubstreams; ++i) {
+		struct virtio_pcm_substream *vss = &snd->substreams[i];
+
+		vss->snd = snd;
+		vss->sid = i;
+		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
+		init_waitqueue_head(&vss->msg_empty);
+		spin_lock_init(&vss->lock);
+	}
+
 	info = kcalloc(snd->nsubstreams, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
@@ -352,12 +367,6 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
 		struct virtio_pcm *vpcm;
 
-		vss->snd = snd;
-		vss->sid = i;
-		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
-		init_waitqueue_head(&vss->msg_empty);
-		spin_lock_init(&vss->lock);
-
 		rc = virtsnd_pcm_build_hw(vss, &info[i]);
 		if (rc)
 			goto on_exit;
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index caedb3ef6688..f5dd84eb55dc 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -996,8 +996,8 @@ AVXcode: 4
 83: Grp1 Ev,Ib (1A),(es)
 # CTESTSCC instructions are: CTESTB, CTESTBE, CTESTF, CTESTL, CTESTLE, CTESTNB, CTESTNBE, CTESTNL,
 #			     CTESTNLE, CTESTNO, CTESTNS, CTESTNZ, CTESTO, CTESTS, CTESTT, CTESTZ
-84: CTESTSCC (ev)
-85: CTESTSCC (es) | CTESTSCC (66),(es)
+84: CTESTSCC Eb,Gb (ev)
+85: CTESTSCC Ev,Gv (es) | CTESTSCC Ev,Gv (66),(es)
 88: POPCNT Gv,Ev (es) | POPCNT Gv,Ev (66),(es)
 8f: POP2 Bq,Rq (000),(11B),(ev)
 a5: SHLD Ev,Gv,CL (es) | SHLD Ev,Gv,CL (66),(es)
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index e71be67f1d86..52ffb74ae4e8 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1928,6 +1928,7 @@ static int do_loader(int argc, char **argv)
 
 	obj = bpf_object__open_file(file, &open_opts);
 	if (!obj) {
+		err = -1;
 		p_err("failed to open object file");
 		goto err_close_obj;
 	}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ce3ea0c2de04..d8aea31ee393 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1243,12 +1243,15 @@ static const char *uaccess_safe_builtin[] = {
 	"__ubsan_handle_load_invalid_value",
 	/* STACKLEAK */
 	"stackleak_track_stack",
+	/* TRACE_BRANCH_PROFILING */
+	"ftrace_likely_update",
+	/* STACKPROTECTOR */
+	"__stack_chk_fail",
 	/* misc */
 	"csum_partial_copy_generic",
 	"copy_mc_fragile",
 	"copy_mc_fragile_handle_tail",
 	"copy_mc_enhanced_fast_string",
-	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
 	"rep_stos_alternative",
 	"rep_movs_alternative",
 	"__copy_user_nocache",
@@ -1567,6 +1570,8 @@ static int add_jump_destinations(struct objtool_file *file)
 	unsigned long dest_off;
 
 	for_each_insn(file, insn) {
+		struct symbol *func = insn_func(insn);
+
 		if (insn->jump_dest) {
 			/*
 			 * handle_group_alt() may have previously set
@@ -1590,7 +1595,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else if (reloc->sym->return_thunk) {
 			add_return_call(file, insn, true);
 			continue;
-		} else if (insn_func(insn)) {
+		} else if (func) {
 			/*
 			 * External sibling call or internal sibling call with
 			 * STT_FUNC reloc.
@@ -1623,6 +1628,15 @@ static int add_jump_destinations(struct objtool_file *file)
 				continue;
 			}
 
+			/*
+			 * GCOV/KCOV dead code can jump to the end of the
+			 * function/section.
+			 */
+			if (file->ignore_unreachables && func &&
+			    dest_sec == insn->sec &&
+			    dest_off == func->offset + func->len)
+				continue;
+
 			WARN_INSN(insn, "can't find jump dest instruction at %s+0x%lx",
 				  dest_sec->name, dest_off);
 			return -1;
@@ -1647,8 +1661,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		/*
 		 * Cross-function jump.
 		 */
-		if (insn_func(insn) && insn_func(jump_dest) &&
-		    insn_func(insn) != insn_func(jump_dest)) {
+		if (func && insn_func(jump_dest) && func != insn_func(jump_dest)) {
 
 			/*
 			 * For GCC 8+, create parent/child links for any cold
@@ -1665,10 +1678,10 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * case where the parent function's only reference to a
 			 * subfunction is through a jump table.
 			 */
-			if (!strstr(insn_func(insn)->name, ".cold") &&
+			if (!strstr(func->name, ".cold") &&
 			    strstr(insn_func(jump_dest)->name, ".cold")) {
-				insn_func(insn)->cfunc = insn_func(jump_dest);
-				insn_func(jump_dest)->pfunc = insn_func(insn);
+				func->cfunc = insn_func(jump_dest);
+				insn_func(jump_dest)->pfunc = func;
 			}
 		}
 
@@ -3634,6 +3647,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			    !strncmp(func->name, "__pfx_", 6))
 				return 0;
 
+			if (file->ignore_unreachables)
+				return 0;
+
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn_func(insn)->name);
 			return 1;
@@ -3853,6 +3869,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (!next_insn) {
 			if (state.cfi.cfa.base == CFI_UNDEFINED)
 				return 0;
+			if (file->ignore_unreachables)
+				return 0;
+
 			WARN("%s: unexpected end of section", sec->name);
 			return 1;
 		}
@@ -4005,6 +4024,9 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 			break;
 		}
 
+		if (insn->dead_end)
+			return 0;
+
 		if (!next) {
 			WARN_INSN(insn, "teh end!");
 			return -1;
diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 27784946b01b..af0ee70a53f9 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -771,12 +771,13 @@ static const char *pkt_type_str(u16 pkt_type)
 	return "Unknown";
 }
 
+#define MAX_FLAGS_STRLEN 21
 /* Show the information of the transport layer in the packet */
 static void show_transport(const u_char *packet, u16 len, u32 ifindex,
 			   const char *src_addr, const char *dst_addr,
 			   u16 proto, bool ipv6, u8 pkt_type)
 {
-	char *ifname, _ifname[IF_NAMESIZE];
+	char *ifname, _ifname[IF_NAMESIZE], flags[MAX_FLAGS_STRLEN] = "";
 	const char *transport_str;
 	u16 src_port, dst_port;
 	struct udphdr *udp;
@@ -817,29 +818,21 @@ static void show_transport(const u_char *packet, u16 len, u32 ifindex,
 
 	/* TCP or UDP*/
 
-	flockfile(stdout);
+	if (proto == IPPROTO_TCP)
+		snprintf(flags, MAX_FLAGS_STRLEN, "%s%s%s%s",
+			 tcp->fin ? ", FIN" : "",
+			 tcp->syn ? ", SYN" : "",
+			 tcp->rst ? ", RST" : "",
+			 tcp->ack ? ", ACK" : "");
+
 	if (ipv6)
-		printf("%-7s %-3s IPv6 %s.%d > %s.%d: %s, length %d",
+		printf("%-7s %-3s IPv6 %s.%d > %s.%d: %s, length %d%s\n",
 		       ifname, pkt_type_str(pkt_type), src_addr, src_port,
-		       dst_addr, dst_port, transport_str, len);
+		       dst_addr, dst_port, transport_str, len, flags);
 	else
-		printf("%-7s %-3s IPv4 %s:%d > %s:%d: %s, length %d",
+		printf("%-7s %-3s IPv4 %s:%d > %s:%d: %s, length %d%s\n",
 		       ifname, pkt_type_str(pkt_type), src_addr, src_port,
-		       dst_addr, dst_port, transport_str, len);
-
-	if (proto == IPPROTO_TCP) {
-		if (tcp->fin)
-			printf(", FIN");
-		if (tcp->syn)
-			printf(", SYN");
-		if (tcp->rst)
-			printf(", RST");
-		if (tcp->ack)
-			printf(", ACK");
-	}
-
-	printf("\n");
-	funlockfile(stdout);
+		       dst_addr, dst_port, transport_str, len, flags);
 }
 
 static void show_ipv6_packet(const u_char *packet, u32 ifindex, u8 pkt_type)
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
index 481626a875d1..df27535995af 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -2,35 +2,41 @@
 #include <uapi/linux/bpf.h>
 #include <linux/if_link.h>
 #include <test_progs.h>
+#include <network_helpers.h>
 
 #include "test_xdp_with_cpumap_frags_helpers.skel.h"
 #include "test_xdp_with_cpumap_helpers.skel.h"
 
 #define IFINDEX_LO	1
+#define TEST_NS "cpu_attach_ns"
 
 static void test_xdp_with_cpumap_helpers(void)
 {
-	struct test_xdp_with_cpumap_helpers *skel;
+	struct test_xdp_with_cpumap_helpers *skel = NULL;
 	struct bpf_prog_info info = {};
 	__u32 len = sizeof(info);
 	struct bpf_cpumap_val val = {
 		.qsize = 192,
 	};
-	int err, prog_fd, map_fd;
+	int err, prog_fd, prog_redir_fd, map_fd;
+	struct nstoken *nstoken = NULL;
 	__u32 idx = 0;
 
+	SYS(out_close, "ip netns add %s", TEST_NS);
+	nstoken = open_netns(TEST_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto out_close;
+	SYS(out_close, "ip link set dev lo up");
+
 	skel = test_xdp_with_cpumap_helpers__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_xdp_with_cpumap_helpers__open_and_load"))
 		return;
 
-	prog_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
-	err = bpf_xdp_attach(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE, NULL);
+	prog_redir_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
+	err = bpf_xdp_attach(IFINDEX_LO, prog_redir_fd, XDP_FLAGS_SKB_MODE, NULL);
 	if (!ASSERT_OK(err, "Generic attach of program with 8-byte CPUMAP"))
 		goto out_close;
 
-	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
-	ASSERT_OK(err, "XDP program detach");
-
 	prog_fd = bpf_program__fd(skel->progs.xdp_dummy_cm);
 	map_fd = bpf_map__fd(skel->maps.cpu_map);
 	err = bpf_prog_get_info_by_fd(prog_fd, &info, &len);
@@ -45,6 +51,26 @@ static void test_xdp_with_cpumap_helpers(void)
 	ASSERT_OK(err, "Read cpumap entry");
 	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry prog_id");
 
+	/* send a packet to trigger any potential bugs in there */
+	char data[ETH_HLEN] = {};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = &data,
+			    .data_size_in = sizeof(data),
+			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
+			    .repeat = 1,
+		);
+	err = bpf_prog_test_run_opts(prog_redir_fd, &opts);
+	ASSERT_OK(err, "XDP test run");
+
+	/* wait for the packets to be flushed, then check that redirect has been
+	 * performed
+	 */
+	kern_sync_rcu();
+	ASSERT_NEQ(skel->bss->redirect_count, 0, "redirected packets");
+
+	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
+	ASSERT_OK(err, "XDP program detach");
+
 	/* can not attach BPF_XDP_CPUMAP program to a device */
 	err = bpf_xdp_attach(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE, NULL);
 	if (!ASSERT_NEQ(err, 0, "Attach of BPF_XDP_CPUMAP program"))
@@ -65,6 +91,8 @@ static void test_xdp_with_cpumap_helpers(void)
 	ASSERT_NEQ(err, 0, "Add BPF_XDP program with frags to cpumap entry");
 
 out_close:
+	close_netns(nstoken);
+	SYS_NOFAIL("ip netns del %s", TEST_NS);
 	test_xdp_with_cpumap_helpers__destroy(skel);
 }
 
@@ -111,7 +139,7 @@ static void test_xdp_with_cpumap_frags_helpers(void)
 	test_xdp_with_cpumap_frags_helpers__destroy(skel);
 }
 
-void serial_test_xdp_cpumap_attach(void)
+void test_xdp_cpumap_attach(void)
 {
 	if (test__start_subtest("CPUMAP with programs in entries"))
 		test_xdp_with_cpumap_helpers();
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
index 27ffed17d4be..461ab18705d5 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -23,7 +23,7 @@ static void test_xdp_with_devmap_helpers(void)
 	__u32 len = sizeof(info);
 	int err, dm_fd, dm_fd_redir, map_fd;
 	struct nstoken *nstoken = NULL;
-	char data[10] = {};
+	char data[ETH_HLEN] = {};
 	__u32 idx = 0;
 
 	SYS(out_close, "ip netns add %s", TEST_NS);
@@ -58,7 +58,7 @@ static void test_xdp_with_devmap_helpers(void)
 	/* send a packet to trigger any potential bugs in there */
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in = &data,
-			    .data_size_in = 10,
+			    .data_size_in = sizeof(data),
 			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
 			    .repeat = 1,
 		);
@@ -158,7 +158,7 @@ static void test_xdp_with_devmap_helpers_veth(void)
 	struct nstoken *nstoken = NULL;
 	__u32 len = sizeof(info);
 	int err, dm_fd, dm_fd_redir, map_fd, ifindex_dst;
-	char data[10] = {};
+	char data[ETH_HLEN] = {};
 	__u32 idx = 0;
 
 	SYS(out_close, "ip netns add %s", TEST_NS);
@@ -208,7 +208,7 @@ static void test_xdp_with_devmap_helpers_veth(void)
 	/* send a packet to trigger any potential bugs in there */
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in = &data,
-			    .data_size_in = 10,
+			    .data_size_in = sizeof(data),
 			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
 			    .repeat = 1,
 		);
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
index 20ec6723df18..3619239b01b7 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
@@ -12,10 +12,12 @@ struct {
 	__uint(max_entries, 4);
 } cpu_map SEC(".maps");
 
+__u32 redirect_count = 0;
+
 SEC("xdp")
 int xdp_redir_prog(struct xdp_md *ctx)
 {
-	return bpf_redirect_map(&cpu_map, 1, 0);
+	return bpf_redirect_map(&cpu_map, 0, 0);
 }
 
 SEC("xdp")
@@ -27,6 +29,9 @@ int xdp_dummy_prog(struct xdp_md *ctx)
 SEC("xdp/cpumap")
 int xdp_dummy_cm(struct xdp_md *ctx)
 {
+	if (bpf_get_smp_processor_id() == 0)
+		redirect_count++;
+
 	if (ctx->ingress_ifindex == IFINDEX_LO)
 		return XDP_DROP;
 
diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index e949a43a6145..efabfcbe0b49 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -261,9 +261,6 @@ TEST(check_file_mmap)
 		TH_LOG("No read-ahead pages found in memory");
 	}
 
-	EXPECT_LT(i, vec_size) {
-		TH_LOG("Read-ahead pages reached the end of the file");
-	}
 	/*
 	 * End of the readahead window. The rest of the pages shouldn't
 	 * be in memory.
diff --git a/tools/testing/selftests/ublk/test_stripe_04.sh b/tools/testing/selftests/ublk/test_stripe_04.sh
new file mode 100755
index 000000000000..1f2b642381d1
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stripe_04.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="stripe_04"
+ERR_CODE=0
+
+_prep_test "stripe" "mkfs & mount & umount on zero copy"
+
+backfile_0=$(_create_backfile 256M)
+backfile_1=$(_create_backfile 256M)
+dev_id=$(_add_ublk_dev -t stripe -z -q 2 "$backfile_0" "$backfile_1")
+_check_add_dev $TID $? "$backfile_0" "$backfile_1"
+
+_mkfs_mount_test /dev/ublkb"${dev_id}"
+ERR_CODE=$?
+
+_cleanup_test "stripe"
+
+_remove_backfile "$backfile_0"
+_remove_backfile "$backfile_1"
+
+_show_result $TID $ERR_CODE

