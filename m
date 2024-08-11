Return-Path: <stable+bounces-66355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80B994E0EA
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 12:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F167B1C20EA8
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41E23EA83;
	Sun, 11 Aug 2024 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P87gZBM6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738824317C;
	Sun, 11 Aug 2024 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723373900; cv=none; b=qk2lPWUhaJzOCVfFkgy3PuLKiKCd47l5C9D+WKwPfKNNHzsSeWn3EXK68WELTixA2Z/jj0XnwSwdRJMmMeTrJrpPw3d7xW+CoQdAdZsw0ezEeMbZONnFvvFuLkL7VN5oHptyeCcnNmPG2QeDnI2jPj8bTNNB6xQG5KKwLZWCBfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723373900; c=relaxed/simple;
	bh=na4tM3QwTdbKYxI3h7dxuma1Bkqy58k1anH9sGNr+hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qstxotLAaCgzEJV3A+wdANeUYm37gkgTHtrbtkXaAakLVakeFaXQRFv2OSukb8lenpgjVuQRQVAeI9NeTFpoHui4LRJog9PvVWWLuWpEgEcgjFA9W1NPndQGcpK598DdrkHDPCETn64Lawym1mbq/W/PEqp2CLQrK2AmyipwHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P87gZBM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF08C32786;
	Sun, 11 Aug 2024 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723373900;
	bh=na4tM3QwTdbKYxI3h7dxuma1Bkqy58k1anH9sGNr+hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P87gZBM6LffTUAipIf12/wL8ux+0UnJMmfKvrwkZpTVTk9lANhuGOPhizMw1tFKnE
	 pqufL0k9Kf1NBFqTRSPbD08sYs+c7NsynNlAzCJ/j+MhACjb5LFklnd7Vwnk6beoo0
	 /aLSYd3IrilYvEKlFWdB9LY1niJQwj38M2VObPJs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.104
Date: Sun, 11 Aug 2024 12:58:07 +0200
Message-ID: <2024081106-unrigged-rug-c373@gregkh>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024081106-supper-yelling-eded@gregkh>
References: <2024081106-supper-yelling-eded@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 97149e46565a..0dd963d6d8d2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 103
+SUBLEVEL = 104
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 3d8e5ba51ce0..2f53c099634b 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -593,6 +593,7 @@ dwc_0: usb@8a00000 {
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&qusb_phy_0>, <&usb0_ssphy>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,parkmode-disable-ss-quirk;
 				snps,is-utmi-l1-suspend;
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;
@@ -635,6 +636,7 @@ dwc_1: usb@8c00000 {
 				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&qusb_phy_1>, <&usb1_ssphy>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,parkmode-disable-ss-quirk;
 				snps,is-utmi-l1-suspend;
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 3d4941dc31d7..4de9ff045ff5 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2029,7 +2029,8 @@ usb3_dwc3: usb@a800000 {
 				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
-				phys = <&qusb2phy>, <&usb1_ssphy>;
+				snps,parkmode-disable-ss-quirk;
+				phys = <&qusb2phy>, <&usb3phy>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
@@ -2038,33 +2039,26 @@ usb3_dwc3: usb@a800000 {
 
 		usb3phy: phy@c010000 {
 			compatible = "qcom,msm8998-qmp-usb3-phy";
-			reg = <0x0c010000 0x18c>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
+			reg = <0x0c010000 0x1000>;
 
 			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
+				 <&gcc GCC_USB3_CLKREF_CLK>,
 				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
-				 <&gcc GCC_USB3_CLKREF_CLK>;
-			clock-names = "aux", "cfg_ahb", "ref";
+				 <&gcc GCC_USB3_PHY_PIPE_CLK>;
+			clock-names = "aux",
+				      "ref",
+				      "cfg_ahb",
+				      "pipe";
+			clock-output-names = "usb3_phy_pipe_clk_src";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
 
 			resets = <&gcc GCC_USB3_PHY_BCR>,
 				 <&gcc GCC_USB3PHY_PHY_BCR>;
-			reset-names = "phy", "common";
+			reset-names = "phy",
+				      "phy_phy";
 
-			usb1_ssphy: phy@c010200 {
-				reg = <0xc010200 0x128>,
-				      <0xc010400 0x200>,
-				      <0xc010c00 0x20c>,
-				      <0xc010600 0x128>,
-				      <0xc010800 0x200>;
-				#phy-cells = <0>;
-				#clock-cells = <0>;
-				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
-				clock-names = "pipe0";
-				clock-output-names = "usb3_phy_pipe_clk_src";
-			};
+			status = "disabled";
 		};
 
 		qusb2phy: phy@c012000 {
diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index b5bd3c38a01b..e714d7770999 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <asm/insn.h>
 
+#define HAVE_JUMP_LABEL_BATCH
 #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
 
 static __always_inline bool arch_static_branch(struct static_key *key,
diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
index faf88ec9c48e..f63ea915d6ad 100644
--- a/arch/arm64/kernel/jump_label.c
+++ b/arch/arm64/kernel/jump_label.c
@@ -7,11 +7,12 @@
  */
 #include <linux/kernel.h>
 #include <linux/jump_label.h>
+#include <linux/smp.h>
 #include <asm/insn.h>
 #include <asm/patching.h>
 
-void arch_jump_label_transform(struct jump_entry *entry,
-			       enum jump_label_type type)
+bool arch_jump_label_transform_queue(struct jump_entry *entry,
+				     enum jump_label_type type)
 {
 	void *addr = (void *)jump_entry_code(entry);
 	u32 insn;
@@ -25,4 +26,10 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	}
 
 	aarch64_insn_patch_text_nosync(addr, insn);
+	return true;
+}
+
+void arch_jump_label_transform_apply(void)
+{
+	kick_all_cpus_sync();
 }
diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
index 9089d1e4f3fe..cc7747c5f21f 100644
--- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
@@ -96,12 +96,19 @@ liointc1: interrupt-controller@1fe11440 {
 						<0x00000000>; /* int3 */
 		};
 
+		rtc0: rtc@1fe07800 {
+			compatible = "loongson,ls2k1000-rtc";
+			reg = <0 0x1fe07800 0 0x78>;
+			interrupt-parent = <&liointc1>;
+			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		uart0: serial@1fe00000 {
 			compatible = "ns16550a";
 			reg = <0 0x1fe00000 0 0x8>;
 			clock-frequency = <125000000>;
 			interrupt-parent = <&liointc0>;
-			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 			no-loopback-test;
 		};
 
@@ -110,7 +117,6 @@ pci@1a000000 {
 			device_type = "pci";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			#interrupt-cells = <2>;
 
 			reg = <0 0x1a000000 0 0x02000000>,
 				<0xfe 0x00000000 0 0x20000000>;
@@ -125,8 +131,8 @@ gmac@3,0 {
 						   "pciclass0c03";
 
 				reg = <0x1800 0x0 0x0 0x0 0x0>;
-				interrupts = <12 IRQ_TYPE_LEVEL_LOW>,
-					     <13 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
+					     <13 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "macirq", "eth_lpi";
 				interrupt-parent = <&liointc0>;
 				phy-mode = "rgmii-id";
@@ -149,8 +155,8 @@ gmac@3,1 {
 						   "loongson, pci-gmac";
 
 				reg = <0x1900 0x0 0x0 0x0 0x0>;
-				interrupts = <14 IRQ_TYPE_LEVEL_LOW>,
-					     <15 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
+					     <15 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "macirq", "eth_lpi";
 				interrupt-parent = <&liointc0>;
 				phy-mode = "rgmii-id";
@@ -172,7 +178,7 @@ ehci@4,1 {
 						   "pciclass0c03";
 
 				reg = <0x2100 0x0 0x0 0x0 0x0>;
-				interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 			};
 
@@ -183,7 +189,7 @@ ohci@4,2 {
 						   "pciclass0c03";
 
 				reg = <0x2200 0x0 0x0 0x0 0x0>;
-				interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 			};
 
@@ -194,97 +200,121 @@ sata@8,0 {
 						   "pciclass0106";
 
 				reg = <0x4000 0x0 0x0 0x0 0x0>;
-				interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc0>;
 			};
 
-			pci_bridge@9,0 {
+			pcie@9,0 {
 				compatible = "pci0014,7a19.0",
 						   "pci0014,7a19",
 						   "pciclass060400",
 						   "pciclass0604";
 
 				reg = <0x4800 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 0 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 0 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 				external-facing;
 			};
 
-			pci_bridge@a,0 {
+			pcie@a,0 {
 				compatible = "pci0014,7a09.0",
 						   "pci0014,7a09",
 						   "pciclass060400",
 						   "pciclass0604";
 
 				reg = <0x5000 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 1 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 1 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 				external-facing;
 			};
 
-			pci_bridge@b,0 {
+			pcie@b,0 {
 				compatible = "pci0014,7a09.0",
 						   "pci0014,7a09",
 						   "pciclass060400",
 						   "pciclass0604";
 
 				reg = <0x5800 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 2 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 2 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 				external-facing;
 			};
 
-			pci_bridge@c,0 {
+			pcie@c,0 {
 				compatible = "pci0014,7a09.0",
 						   "pci0014,7a09",
 						   "pciclass060400",
 						   "pciclass0604";
 
 				reg = <0x6000 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 3 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 3 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 				external-facing;
 			};
 
-			pci_bridge@d,0 {
+			pcie@d,0 {
 				compatible = "pci0014,7a19.0",
 						   "pci0014,7a19",
 						   "pciclass060400",
 						   "pciclass0604";
 
 				reg = <0x6800 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 4 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 4 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 				external-facing;
 			};
 
-			pci_bridge@e,0 {
+			pcie@e,0 {
 				compatible = "pci0014,7a09.0",
 						   "pci0014,7a09",
 						   "pciclass060400",
 						   "pciclass0604";
 
 				reg = <0x7000 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 5 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 5 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 				external-facing;
 			};
 
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 274bc6dd839f..05d7d3647964 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -60,26 +60,27 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
 
 static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_fault_t fault)
 {
+	if (!user_mode(regs)) {
+		no_context(regs, addr);
+		return;
+	}
+
 	if (fault & VM_FAULT_OOM) {
 		/*
 		 * We ran out of memory, call the OOM killer, and return the userspace
 		 * (which will retry the fault, or kill us if we got oom-killed).
 		 */
-		if (!user_mode(regs)) {
-			no_context(regs, addr);
-			return;
-		}
 		pagefault_out_of_memory();
 		return;
 	} else if (fault & VM_FAULT_SIGBUS) {
 		/* Kernel mode? Handle exceptions or die */
-		if (!user_mode(regs)) {
-			no_context(regs, addr);
-			return;
-		}
 		do_trap(regs, SIGBUS, BUS_ADRERR, addr);
 		return;
+	} else if (fault & VM_FAULT_SIGSEGV) {
+		do_trap(regs, SIGSEGV, SEGV_MAPERR, addr);
+		return;
 	}
+
 	BUG();
 }
 
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index cb03bfb0435e..2edb66097cdb 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -53,10 +53,14 @@ struct qcom_cpufreq_match_data {
 	const char **genpd_names;
 };
 
+struct qcom_cpufreq_drv_cpu {
+	int opp_token;
+};
+
 struct qcom_cpufreq_drv {
-	int *opp_tokens;
 	u32 versions;
 	const struct qcom_cpufreq_match_data *data;
+	struct qcom_cpufreq_drv_cpu cpus[];
 };
 
 static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
@@ -284,42 +288,39 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	drv = kzalloc(sizeof(*drv), GFP_KERNEL);
-	if (!drv)
+	drv = devm_kzalloc(&pdev->dev, struct_size(drv, cpus, num_possible_cpus()),
+		           GFP_KERNEL);
+	if (!drv) {
+		of_node_put(np);
 		return -ENOMEM;
+	}
 
 	match = pdev->dev.platform_data;
 	drv->data = match->data;
 	if (!drv->data) {
-		ret = -ENODEV;
-		goto free_drv;
+		of_node_put(np);
+		return -ENODEV;
 	}
 
 	if (drv->data->get_version) {
 		speedbin_nvmem = of_nvmem_cell_get(np, NULL);
 		if (IS_ERR(speedbin_nvmem)) {
-			ret = dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
-					    "Could not get nvmem cell\n");
-			goto free_drv;
+			of_node_put(np);
+			return dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
+					     "Could not get nvmem cell\n");
 		}
 
 		ret = drv->data->get_version(cpu_dev,
 							speedbin_nvmem, &pvs_name, drv);
 		if (ret) {
+			of_node_put(np);
 			nvmem_cell_put(speedbin_nvmem);
-			goto free_drv;
+			return ret;
 		}
 		nvmem_cell_put(speedbin_nvmem);
 	}
 	of_node_put(np);
 
-	drv->opp_tokens = kcalloc(num_possible_cpus(), sizeof(*drv->opp_tokens),
-				  GFP_KERNEL);
-	if (!drv->opp_tokens) {
-		ret = -ENOMEM;
-		goto free_drv;
-	}
-
 	for_each_possible_cpu(cpu) {
 		struct dev_pm_opp_config config = {
 			.supported_hw = NULL,
@@ -345,9 +346,9 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 		}
 
 		if (config.supported_hw || config.genpd_names) {
-			drv->opp_tokens[cpu] = dev_pm_opp_set_config(cpu_dev, &config);
-			if (drv->opp_tokens[cpu] < 0) {
-				ret = drv->opp_tokens[cpu];
+			drv->cpus[cpu].opp_token = dev_pm_opp_set_config(cpu_dev, &config);
+			if (drv->cpus[cpu].opp_token < 0) {
+				ret = drv->cpus[cpu].opp_token;
 				dev_err(cpu_dev, "Failed to set OPP config\n");
 				goto free_opp;
 			}
@@ -366,15 +367,11 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 
 free_opp:
 	for_each_possible_cpu(cpu)
-		dev_pm_opp_clear_config(drv->opp_tokens[cpu]);
-	kfree(drv->opp_tokens);
-free_drv:
-	kfree(drv);
-
+		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	return ret;
 }
 
-static int qcom_cpufreq_remove(struct platform_device *pdev)
+static void qcom_cpufreq_remove(struct platform_device *pdev)
 {
 	struct qcom_cpufreq_drv *drv = platform_get_drvdata(pdev);
 	unsigned int cpu;
@@ -382,17 +379,12 @@ static int qcom_cpufreq_remove(struct platform_device *pdev)
 	platform_device_unregister(cpufreq_dt_pdev);
 
 	for_each_possible_cpu(cpu)
-		dev_pm_opp_clear_config(drv->opp_tokens[cpu]);
-
-	kfree(drv->opp_tokens);
-	kfree(drv);
-
-	return 0;
+		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 }
 
 static struct platform_driver qcom_cpufreq_driver = {
 	.probe = qcom_cpufreq_probe,
-	.remove = qcom_cpufreq_remove,
+	.remove_new = qcom_cpufreq_remove,
 	.driver = {
 		.name = "qcom-cpufreq-nvmem",
 	},
diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index 3d3efcf02011..1d9e4534287b 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -103,12 +103,26 @@ intel_dp_set_lttpr_transparent_mode(struct intel_dp *intel_dp, bool enable)
 	return drm_dp_dpcd_write(&intel_dp->aux, DP_PHY_REPEATER_MODE, &val, 1) == 1;
 }
 
-static int intel_dp_init_lttpr(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+static bool intel_dp_lttpr_transparent_mode_enabled(struct intel_dp *intel_dp)
+{
+	return intel_dp->lttpr_common_caps[DP_PHY_REPEATER_MODE -
+					   DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV] ==
+		DP_PHY_REPEATER_MODE_TRANSPARENT;
+}
+
+/*
+ * Read the LTTPR common capabilities and switch the LTTPR PHYs to
+ * non-transparent mode if this is supported. Preserve the
+ * transparent/non-transparent mode on an active link.
+ *
+ * Return the number of detected LTTPRs in non-transparent mode or 0 if the
+ * LTTPRs are in transparent mode or the detection failed.
+ */
+static int intel_dp_init_lttpr_phys(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 {
 	struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)->base;
 	struct drm_i915_private *i915 = to_i915(encoder->base.dev);
 	int lttpr_count;
-	int i;
 
 	if (!intel_dp_read_lttpr_common_caps(intel_dp, dpcd))
 		return 0;
@@ -122,6 +136,19 @@ static int intel_dp_init_lttpr(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEI
 	if (lttpr_count == 0)
 		return 0;
 
+	/*
+	 * Don't change the mode on an active link, to prevent a loss of link
+	 * synchronization. See DP Standard v2.0 3.6.7. about the LTTPR
+	 * resetting its internal state when the mode is changed from
+	 * non-transparent to transparent.
+	 */
+	if (intel_dp->link_trained) {
+		if (lttpr_count < 0 || intel_dp_lttpr_transparent_mode_enabled(intel_dp))
+			goto out_reset_lttpr_count;
+
+		return lttpr_count;
+	}
+
 	/*
 	 * See DP Standard v2.0 3.6.6.1. about the explicit disabling of
 	 * non-transparent mode and the disable->enable non-transparent mode
@@ -143,11 +170,25 @@ static int intel_dp_init_lttpr(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEI
 			    encoder->base.base.id, encoder->base.name);
 
 		intel_dp_set_lttpr_transparent_mode(intel_dp, true);
-		intel_dp_reset_lttpr_count(intel_dp);
 
-		return 0;
+		goto out_reset_lttpr_count;
 	}
 
+	return lttpr_count;
+
+out_reset_lttpr_count:
+	intel_dp_reset_lttpr_count(intel_dp);
+
+	return 0;
+}
+
+static int intel_dp_init_lttpr(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+{
+	int lttpr_count;
+	int i;
+
+	lttpr_count = intel_dp_init_lttpr_phys(intel_dp, dpcd);
+
 	for (i = 0; i < lttpr_count; i++)
 		intel_dp_read_lttpr_phy_caps(intel_dp, dpcd, DP_PHY_LTTPR(i));
 
@@ -1435,8 +1476,9 @@ void intel_dp_start_link_train(struct intel_dp *intel_dp,
 {
 	bool passed;
 	/*
-	 * TODO: Reiniting LTTPRs here won't be needed once proper connector
-	 * HW state readout is added.
+	 * Reinit the LTTPRs here to ensure that they are switched to
+	 * non-transparent mode. During an earlier LTTPR detection this
+	 * could've been prevented by an active link.
 	 */
 	int lttpr_count = intel_dp_init_lttpr_and_dprx_caps(intel_dp);
 
diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
index 64dd603dc69a..ec0ef3ff9e6a 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -1552,7 +1552,7 @@ static void skl_wrpll_params_populate(struct skl_wrpll_params *params,
 }
 
 static int
-skl_ddi_calculate_wrpll(int clock /* in Hz */,
+skl_ddi_calculate_wrpll(int clock,
 			int ref_clock,
 			struct skl_wrpll_params *wrpll_params)
 {
@@ -1577,7 +1577,7 @@ skl_ddi_calculate_wrpll(int clock /* in Hz */,
 	};
 	unsigned int dco, d, i;
 	unsigned int p0, p1, p2;
-	u64 afe_clock = clock * 5; /* AFE Clock is 5x Pixel clock */
+	u64 afe_clock = (u64)clock * 1000 * 5; /* AFE Clock is 5x Pixel clock, in Hz */
 
 	for (d = 0; d < ARRAY_SIZE(dividers); d++) {
 		for (dco = 0; dco < ARRAY_SIZE(dco_central_freq); dco++) {
@@ -1709,7 +1709,7 @@ static int skl_ddi_hdmi_pll_dividers(struct intel_crtc_state *crtc_state)
 
 	ctrl1 |= DPLL_CTRL1_HDMI_MODE(0);
 
-	ret = skl_ddi_calculate_wrpll(crtc_state->port_clock * 1000,
+	ret = skl_ddi_calculate_wrpll(crtc_state->port_clock,
 				      i915->display.dpll.ref_clks.nssc, &wrpll_params);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/i915/display/intel_hdcp_regs.h b/drivers/gpu/drm/i915/display/intel_hdcp_regs.h
index 2a3733e8966c..2702cc8c88d8 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_hdcp_regs.h
@@ -249,7 +249,7 @@
 #define HDCP2_STREAM_STATUS(dev_priv, trans, port) \
 					(GRAPHICS_VER(dev_priv) >= 12 ? \
 					 TRANS_HDCP2_STREAM_STATUS(trans) : \
-					 PIPE_HDCP2_STREAM_STATUS(pipe))
+					 PIPE_HDCP2_STREAM_STATUS(port))
 
 #define _PORTA_HDCP2_AUTH_STREAM		0x66F00
 #define _PORTB_HDCP2_AUTH_STREAM		0x66F04
diff --git a/drivers/gpu/drm/nouveau/nouveau_prime.c b/drivers/gpu/drm/nouveau/nouveau_prime.c
index 9608121e49b7..8340d55aaa98 100644
--- a/drivers/gpu/drm/nouveau/nouveau_prime.c
+++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
@@ -63,7 +63,8 @@ struct drm_gem_object *nouveau_gem_prime_import_sg_table(struct drm_device *dev,
 	 * to the caller, instead of a normal nouveau_bo ttm reference. */
 	ret = drm_gem_object_init(dev, &nvbo->bo.base, size);
 	if (ret) {
-		nouveau_bo_ref(NULL, &nvbo);
+		drm_gem_object_release(&nvbo->bo.base);
+		kfree(nvbo);
 		obj = ERR_PTR(-ENOMEM);
 		goto unlock;
 	}
diff --git a/drivers/gpu/drm/udl/Makefile b/drivers/gpu/drm/udl/Makefile
index 24d61f61d7db..3f6db179455d 100644
--- a/drivers/gpu/drm/udl/Makefile
+++ b/drivers/gpu/drm/udl/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-udl-y := udl_drv.o udl_modeset.o udl_connector.o udl_main.o udl_transfer.o
+udl-y := udl_drv.o udl_modeset.o udl_main.o udl_transfer.o
 
 obj-$(CONFIG_DRM_UDL) := udl.o
diff --git a/drivers/gpu/drm/udl/udl_connector.c b/drivers/gpu/drm/udl/udl_connector.c
deleted file mode 100644
index fade4c7adbf7..000000000000
--- a/drivers/gpu/drm/udl/udl_connector.c
+++ /dev/null
@@ -1,139 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2012 Red Hat
- * based in parts on udlfb.c:
- * Copyright (C) 2009 Roberto De Ioris <roberto@unbit.it>
- * Copyright (C) 2009 Jaya Kumar <jayakumar.lkml@gmail.com>
- * Copyright (C) 2009 Bernie Thompson <bernie@plugable.com>
- */
-
-#include <drm/drm_atomic_state_helper.h>
-#include <drm/drm_edid.h>
-#include <drm/drm_crtc_helper.h>
-#include <drm/drm_probe_helper.h>
-
-#include "udl_connector.h"
-#include "udl_drv.h"
-
-static int udl_get_edid_block(void *data, u8 *buf, unsigned int block,
-			       size_t len)
-{
-	int ret, i;
-	u8 *read_buff;
-	struct udl_device *udl = data;
-	struct usb_device *udev = udl_to_usb_device(udl);
-
-	read_buff = kmalloc(2, GFP_KERNEL);
-	if (!read_buff)
-		return -1;
-
-	for (i = 0; i < len; i++) {
-		int bval = (i + block * EDID_LENGTH) << 8;
-		ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-				      0x02, (0x80 | (0x02 << 5)), bval,
-				      0xA1, read_buff, 2, 1000);
-		if (ret < 1) {
-			DRM_ERROR("Read EDID byte %d failed err %x\n", i, ret);
-			kfree(read_buff);
-			return -1;
-		}
-		buf[i] = read_buff[1];
-	}
-
-	kfree(read_buff);
-	return 0;
-}
-
-static int udl_get_modes(struct drm_connector *connector)
-{
-	struct udl_drm_connector *udl_connector =
-					container_of(connector,
-					struct udl_drm_connector,
-					connector);
-
-	drm_connector_update_edid_property(connector, udl_connector->edid);
-	if (udl_connector->edid)
-		return drm_add_edid_modes(connector, udl_connector->edid);
-	return 0;
-}
-
-static enum drm_mode_status udl_mode_valid(struct drm_connector *connector,
-			  struct drm_display_mode *mode)
-{
-	struct udl_device *udl = to_udl(connector->dev);
-	if (!udl->sku_pixel_limit)
-		return 0;
-
-	if (mode->vdisplay * mode->hdisplay > udl->sku_pixel_limit)
-		return MODE_VIRTUAL_Y;
-
-	return 0;
-}
-
-static enum drm_connector_status
-udl_detect(struct drm_connector *connector, bool force)
-{
-	struct udl_device *udl = to_udl(connector->dev);
-	struct udl_drm_connector *udl_connector =
-					container_of(connector,
-					struct udl_drm_connector,
-					connector);
-
-	/* cleanup previous edid */
-	if (udl_connector->edid != NULL) {
-		kfree(udl_connector->edid);
-		udl_connector->edid = NULL;
-	}
-
-	udl_connector->edid = drm_do_get_edid(connector, udl_get_edid_block, udl);
-	if (!udl_connector->edid)
-		return connector_status_disconnected;
-
-	return connector_status_connected;
-}
-
-static void udl_connector_destroy(struct drm_connector *connector)
-{
-	struct udl_drm_connector *udl_connector =
-					container_of(connector,
-					struct udl_drm_connector,
-					connector);
-
-	drm_connector_cleanup(connector);
-	kfree(udl_connector->edid);
-	kfree(connector);
-}
-
-static const struct drm_connector_helper_funcs udl_connector_helper_funcs = {
-	.get_modes = udl_get_modes,
-	.mode_valid = udl_mode_valid,
-};
-
-static const struct drm_connector_funcs udl_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
-	.detect = udl_detect,
-	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = udl_connector_destroy,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state   = drm_atomic_helper_connector_destroy_state,
-};
-
-struct drm_connector *udl_connector_init(struct drm_device *dev)
-{
-	struct udl_drm_connector *udl_connector;
-	struct drm_connector *connector;
-
-	udl_connector = kzalloc(sizeof(struct udl_drm_connector), GFP_KERNEL);
-	if (!udl_connector)
-		return ERR_PTR(-ENOMEM);
-
-	connector = &udl_connector->connector;
-	drm_connector_init(dev, connector, &udl_connector_funcs,
-			   DRM_MODE_CONNECTOR_VGA);
-	drm_connector_helper_add(connector, &udl_connector_helper_funcs);
-
-	connector->polled = DRM_CONNECTOR_POLL_HPD |
-		DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
-
-	return connector;
-}
diff --git a/drivers/gpu/drm/udl/udl_connector.h b/drivers/gpu/drm/udl/udl_connector.h
deleted file mode 100644
index 7f2d392df173..000000000000
--- a/drivers/gpu/drm/udl/udl_connector.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef __UDL_CONNECTOR_H__
-#define __UDL_CONNECTOR_H__
-
-#include <drm/drm_crtc.h>
-
-struct edid;
-
-struct udl_drm_connector {
-	struct drm_connector connector;
-	/* last udl_detect edid */
-	struct edid *edid;
-};
-
-
-#endif //__UDL_CONNECTOR_H__
diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index b4cc7cc568c7..d7a3d495f2e7 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -46,6 +46,17 @@ struct urb_list {
 	size_t size;
 };
 
+struct udl_connector {
+	struct drm_connector connector;
+	/* last udl_detect edid */
+	struct edid *edid;
+};
+
+static inline struct udl_connector *to_udl_connector(struct drm_connector *connector)
+{
+	return container_of(connector, struct udl_connector, connector);
+}
+
 struct udl_device {
 	struct drm_device drm;
 	struct device *dev;
diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index ec6876f449f3..8f4c4a857b6e 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -11,11 +11,13 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_damage_helper.h>
+#include <drm/drm_edid.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
 #include "udl_drv.h"
@@ -403,12 +405,145 @@ static const struct drm_simple_display_pipe_funcs udl_simple_display_pipe_funcs
 	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
 };
 
+/*
+ * Connector
+ */
+
+static int udl_connector_helper_get_modes(struct drm_connector *connector)
+{
+	struct udl_connector *udl_connector = to_udl_connector(connector);
+
+	drm_connector_update_edid_property(connector, udl_connector->edid);
+	if (udl_connector->edid)
+		return drm_add_edid_modes(connector, udl_connector->edid);
+
+	return 0;
+}
+
+static const struct drm_connector_helper_funcs udl_connector_helper_funcs = {
+	.get_modes = udl_connector_helper_get_modes,
+};
+
+static int udl_get_edid_block(void *data, u8 *buf, unsigned int block, size_t len)
+{
+	struct udl_device *udl = data;
+	struct drm_device *dev = &udl->drm;
+	struct usb_device *udev = udl_to_usb_device(udl);
+	u8 *read_buff;
+	int ret;
+	size_t i;
+
+	read_buff = kmalloc(2, GFP_KERNEL);
+	if (!read_buff)
+		return -ENOMEM;
+
+	for (i = 0; i < len; i++) {
+		int bval = (i + block * EDID_LENGTH) << 8;
+
+		ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
+				      0x02, (0x80 | (0x02 << 5)), bval,
+				      0xA1, read_buff, 2, USB_CTRL_GET_TIMEOUT);
+		if (ret < 0) {
+			drm_err(dev, "Read EDID byte %zu failed err %x\n", i, ret);
+			goto err_kfree;
+		} else if (ret < 1) {
+			ret = -EIO;
+			drm_err(dev, "Read EDID byte %zu failed\n", i);
+			goto err_kfree;
+		}
+
+		buf[i] = read_buff[1];
+	}
+
+	kfree(read_buff);
+
+	return 0;
+
+err_kfree:
+	kfree(read_buff);
+	return ret;
+}
+
+static enum drm_connector_status udl_connector_detect(struct drm_connector *connector, bool force)
+{
+	struct udl_device *udl = to_udl(connector->dev);
+	struct udl_connector *udl_connector = to_udl_connector(connector);
+
+	/* cleanup previous EDID */
+	kfree(udl_connector->edid);
+
+	udl_connector->edid = drm_do_get_edid(connector, udl_get_edid_block, udl);
+	if (!udl_connector->edid)
+		return connector_status_disconnected;
+
+	return connector_status_connected;
+}
+
+static void udl_connector_destroy(struct drm_connector *connector)
+{
+	struct udl_connector *udl_connector = to_udl_connector(connector);
+
+	drm_connector_cleanup(connector);
+	kfree(udl_connector->edid);
+	kfree(udl_connector);
+}
+
+static const struct drm_connector_funcs udl_connector_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.detect = udl_connector_detect,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = udl_connector_destroy,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+struct drm_connector *udl_connector_init(struct drm_device *dev)
+{
+	struct udl_connector *udl_connector;
+	struct drm_connector *connector;
+	int ret;
+
+	udl_connector = kzalloc(sizeof(*udl_connector), GFP_KERNEL);
+	if (!udl_connector)
+		return ERR_PTR(-ENOMEM);
+
+	connector = &udl_connector->connector;
+	ret = drm_connector_init(dev, connector, &udl_connector_funcs, DRM_MODE_CONNECTOR_VGA);
+	if (ret)
+		goto err_kfree;
+
+	drm_connector_helper_add(connector, &udl_connector_helper_funcs);
+
+	connector->polled = DRM_CONNECTOR_POLL_CONNECT |
+			    DRM_CONNECTOR_POLL_DISCONNECT;
+
+	return connector;
+
+err_kfree:
+	kfree(udl_connector);
+	return ERR_PTR(ret);
+}
+
 /*
  * Modesetting
  */
 
+static enum drm_mode_status udl_mode_config_mode_valid(struct drm_device *dev,
+						       const struct drm_display_mode *mode)
+{
+	struct udl_device *udl = to_udl(dev);
+
+	if (udl->sku_pixel_limit) {
+		if (mode->vdisplay * mode->hdisplay > udl->sku_pixel_limit)
+			return MODE_MEM;
+	}
+
+	return MODE_OK;
+}
+
 static const struct drm_mode_config_funcs udl_mode_funcs = {
 	.fb_create = drm_gem_fb_create_with_dirty,
+	.mode_valid = udl_mode_config_mode_valid,
 	.atomic_check  = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 95344735d00e..add39769283f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -32,7 +32,6 @@
 #define VMW_FENCE_WRAP (1 << 31)
 
 struct vmw_fence_manager {
-	int num_fence_objects;
 	struct vmw_private *dev_priv;
 	spinlock_t lock;
 	struct list_head fence_list;
@@ -124,13 +123,13 @@ static void vmw_fence_obj_destroy(struct dma_fence *f)
 {
 	struct vmw_fence_obj *fence =
 		container_of(f, struct vmw_fence_obj, base);
-
 	struct vmw_fence_manager *fman = fman_from_fence(fence);
 
-	spin_lock(&fman->lock);
-	list_del_init(&fence->head);
-	--fman->num_fence_objects;
-	spin_unlock(&fman->lock);
+	if (!list_empty(&fence->head)) {
+		spin_lock(&fman->lock);
+		list_del_init(&fence->head);
+		spin_unlock(&fman->lock);
+	}
 	fence->destroy(fence);
 }
 
@@ -257,7 +256,6 @@ static const struct dma_fence_ops vmw_fence_ops = {
 	.release = vmw_fence_obj_destroy,
 };
 
-
 /*
  * Execute signal actions on fences recently signaled.
  * This is done from a workqueue so we don't have to execute
@@ -355,7 +353,6 @@ static int vmw_fence_obj_init(struct vmw_fence_manager *fman,
 		goto out_unlock;
 	}
 	list_add_tail(&fence->head, &fman->fence_list);
-	++fman->num_fence_objects;
 
 out_unlock:
 	spin_unlock(&fman->lock);
@@ -403,7 +400,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fence_manager *fman,
 				      u32 passed_seqno)
 {
 	u32 goal_seqno;
-	struct vmw_fence_obj *fence;
+	struct vmw_fence_obj *fence, *next_fence;
 
 	if (likely(!fman->seqno_valid))
 		return false;
@@ -413,7 +410,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fence_manager *fman,
 		return false;
 
 	fman->seqno_valid = false;
-	list_for_each_entry(fence, &fman->fence_list, head) {
+	list_for_each_entry_safe(fence, next_fence, &fman->fence_list, head) {
 		if (!list_empty(&fence->seq_passed_actions)) {
 			fman->seqno_valid = true;
 			vmw_fence_goal_write(fman->dev_priv,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
index abc354ead4e8..5dcddcb59a6f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
@@ -98,7 +98,7 @@ static int vmw_overlay_send_put(struct vmw_private *dev_priv,
 {
 	struct vmw_escape_video_flush *flush;
 	size_t fifo_size;
-	bool have_so = (dev_priv->active_display_unit == vmw_du_screen_object);
+	bool have_so = (dev_priv->active_display_unit != vmw_du_legacy);
 	int i, num_items;
 	SVGAGuestPtr ptr;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 6dd33d1258d1..e98fde90f4e0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -1015,6 +1015,32 @@ vmw_stdu_connector_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
+/*
+ * Trigger a modeset if the X,Y position of the Screen Target changes.
+ * This is needed when multi-mon is cycled. The original Screen Target will have
+ * the same mode but its relative X,Y position in the topology will change.
+ */
+static int vmw_stdu_connector_atomic_check(struct drm_connector *conn,
+					   struct drm_atomic_state *state)
+{
+	struct drm_connector_state *conn_state;
+	struct vmw_screen_target_display_unit *du;
+	struct drm_crtc_state *new_crtc_state;
+
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	du = vmw_connector_to_stdu(conn);
+
+	if (!conn_state->crtc)
+		return 0;
+
+	new_crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	if (du->base.gui_x != du->base.set_gui_x ||
+	    du->base.gui_y != du->base.set_gui_y)
+		new_crtc_state->mode_changed = true;
+
+	return 0;
+}
+
 static const struct drm_connector_funcs vmw_stdu_connector_funcs = {
 	.dpms = vmw_du_connector_dpms,
 	.detect = vmw_du_connector_detect,
@@ -1029,7 +1055,8 @@ static const struct drm_connector_funcs vmw_stdu_connector_funcs = {
 static const struct
 drm_connector_helper_funcs vmw_stdu_connector_helper_funcs = {
 	.get_modes = vmw_connector_get_modes,
-	.mode_valid = vmw_stdu_connector_mode_valid
+	.mode_valid = vmw_stdu_connector_mode_valid,
+	.atomic_check = vmw_stdu_connector_atomic_check,
 };
 
 
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
index c751d12f5df8..4343fef7dd83 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
@@ -214,7 +214,7 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
 	struct device *dev;
 	u32 feature_report_size;
 	u32 input_report_size;
-	int rc, i, status;
+	int rc, i;
 	u8 cl_idx;
 
 	req_list = &cl_data->req_list;
@@ -285,24 +285,27 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
 		if (rc)
 			goto cleanup;
 		mp2_ops->start(privdata, info);
-		status = amd_sfh_wait_for_response
-				(privdata, cl_data->sensor_idx[i], SENSOR_ENABLED);
-		if (status == SENSOR_ENABLED) {
+		cl_data->sensor_sts[i] = amd_sfh_wait_for_response
+						(privdata, cl_data->sensor_idx[i], SENSOR_ENABLED);
+
+		if (cl_data->sensor_sts[i] == SENSOR_ENABLED)
 			cl_data->is_any_sensor_enabled = true;
-			cl_data->sensor_sts[i] = SENSOR_ENABLED;
-			rc = amdtp_hid_probe(cl_data->cur_hid_dev, cl_data);
-			if (rc) {
-				mp2_ops->stop(privdata, cl_data->sensor_idx[i]);
-				status = amd_sfh_wait_for_response
-					(privdata, cl_data->sensor_idx[i], SENSOR_DISABLED);
-				if (status != SENSOR_ENABLED)
-					cl_data->sensor_sts[i] = SENSOR_DISABLED;
-				dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
-					cl_data->sensor_idx[i],
-					get_sensor_name(cl_data->sensor_idx[i]),
-					cl_data->sensor_sts[i]);
+	}
+
+	if (!cl_data->is_any_sensor_enabled ||
+	    (mp2_ops->discovery_status && mp2_ops->discovery_status(privdata) == 0)) {
+		dev_warn(dev, "Failed to discover, sensors not enabled is %d\n",
+			 cl_data->is_any_sensor_enabled);
+		rc = -EOPNOTSUPP;
+		goto cleanup;
+	}
+
+	for (i = 0; i < cl_data->num_hid_devices; i++) {
+		cl_data->cur_hid_dev = i;
+		if (cl_data->sensor_sts[i] == SENSOR_ENABLED) {
+			rc = amdtp_hid_probe(i, cl_data);
+			if (rc)
 				goto cleanup;
-			}
 		} else {
 			cl_data->sensor_sts[i] = SENSOR_DISABLED;
 			dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
@@ -314,27 +317,13 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
 			cl_data->sensor_idx[i], get_sensor_name(cl_data->sensor_idx[i]),
 			cl_data->sensor_sts[i]);
 	}
-	if (!cl_data->is_any_sensor_enabled ||
-	   (mp2_ops->discovery_status && mp2_ops->discovery_status(privdata) == 0)) {
-		amd_sfh_hid_client_deinit(privdata);
-		for (i = 0; i < cl_data->num_hid_devices; i++) {
-			devm_kfree(dev, cl_data->feature_report[i]);
-			devm_kfree(dev, in_data->input_report[i]);
-			devm_kfree(dev, cl_data->report_descr[i]);
-		}
-		dev_warn(dev, "Failed to discover, sensors not enabled is %d\n", cl_data->is_any_sensor_enabled);
-		return -EOPNOTSUPP;
-	}
+
 	schedule_delayed_work(&cl_data->work_buffer, msecs_to_jiffies(AMD_SFH_IDLE_LOOP));
 	return 0;
 
 cleanup:
+	amd_sfh_hid_client_deinit(privdata);
 	for (i = 0; i < cl_data->num_hid_devices; i++) {
-		if (in_data->sensor_virt_addr[i]) {
-			dma_free_coherent(&privdata->pdev->dev, 8 * sizeof(int),
-					  in_data->sensor_virt_addr[i],
-					  cl_data->sensor_dma_addr[i]);
-		}
 		devm_kfree(dev, cl_data->feature_report[i]);
 		devm_kfree(dev, in_data->input_report[i]);
 		devm_kfree(dev, cl_data->report_descr[i]);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 53235b276bb2..05e40880e7d4 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -709,13 +709,12 @@ static int wacom_intuos_get_tool_type(int tool_id)
 	case 0x8e2: /* IntuosHT2 pen */
 	case 0x022:
 	case 0x200: /* Pro Pen 3 */
-	case 0x04200: /* Pro Pen 3 */
 	case 0x10842: /* MobileStudio Pro Pro Pen slim */
 	case 0x14802: /* Intuos4/5 13HD/24HD Classic Pen */
 	case 0x16802: /* Cintiq 13HD Pro Pen */
 	case 0x18802: /* DTH2242 Pen */
 	case 0x10802: /* Intuos4/5 13HD/24HD General Pen */
-	case 0x80842: /* Intuos Pro and Cintiq Pro 3D Pen */
+	case 0x8842: /* Intuos Pro and Cintiq Pro 3D Pen */
 		tool_type = BTN_TOOL_PEN;
 		break;
 
diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 024b73f84ce0..3d3673c197e3 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -193,11 +193,24 @@ int led_trigger_set(struct led_classdev *led_cdev, struct led_trigger *trig)
 		spin_unlock(&trig->leddev_list_lock);
 		led_cdev->trigger = trig;
 
+		/*
+		 * Some activate() calls use led_trigger_event() to initialize
+		 * the brightness of the LED for which the trigger is being set.
+		 * Ensure the led_cdev is visible on trig->led_cdevs for this.
+		 */
+		synchronize_rcu();
+
+		/*
+		 * If "set brightness to 0" is pending in workqueue,
+		 * we don't want that to be reordered after ->activate()
+		 */
+		flush_work(&led_cdev->set_brightness_work);
+
+		ret = 0;
 		if (trig->activate)
 			ret = trig->activate(led_cdev);
 		else
-			ret = 0;
-
+			led_set_brightness(led_cdev, trig->brightness);
 		if (ret)
 			goto err_activate;
 
@@ -268,19 +281,6 @@ void led_trigger_set_default(struct led_classdev *led_cdev)
 }
 EXPORT_SYMBOL_GPL(led_trigger_set_default);
 
-void led_trigger_rename_static(const char *name, struct led_trigger *trig)
-{
-	/* new name must be on a temporary string to prevent races */
-	BUG_ON(name == trig->name);
-
-	down_write(&triggers_list_lock);
-	/* this assumes that trig->name was originaly allocated to
-	 * non constant storage */
-	strcpy((char *)trig->name, name);
-	up_write(&triggers_list_lock);
-}
-EXPORT_SYMBOL_GPL(led_trigger_rename_static);
-
 /* LED Trigger Interface */
 
 int led_trigger_register(struct led_trigger *trig)
@@ -385,6 +385,8 @@ void led_trigger_event(struct led_trigger *trig,
 	if (!trig)
 		return;
 
+	trig->brightness = brightness;
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(led_cdev, &trig->led_cdevs, trig_list)
 		led_set_brightness(led_cdev, brightness);
diff --git a/drivers/leds/trigger/ledtrig-timer.c b/drivers/leds/trigger/ledtrig-timer.c
index b4688d1d9d2b..1d213c999d40 100644
--- a/drivers/leds/trigger/ledtrig-timer.c
+++ b/drivers/leds/trigger/ledtrig-timer.c
@@ -110,11 +110,6 @@ static int timer_trig_activate(struct led_classdev *led_cdev)
 		led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;
 	}
 
-	/*
-	 * If "set brightness to 0" is pending in workqueue, we don't
-	 * want that to be reordered after blink_set()
-	 */
-	flush_work(&led_cdev->set_brightness_work);
 	led_blink_set(led_cdev, &led_cdev->blink_delay_on,
 		      &led_cdev->blink_delay_off);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index dbe80e5053a8..bd62781191b3 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -454,7 +454,7 @@ void ice_free_rx_ring(struct ice_rx_ring *rx_ring)
 	if (rx_ring->vsi->type == ICE_VSI_PF)
 		if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
 			xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
-	rx_ring->xdp_prog = NULL;
+	WRITE_ONCE(rx_ring->xdp_prog, NULL);
 	if (rx_ring->xsk_pool) {
 		kfree(rx_ring->xdp_buf);
 		rx_ring->xdp_buf = NULL;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index b917f271cdac..2677d7c86a6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -41,10 +41,8 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
 static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
 {
 	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
-	if (ice_is_xdp_ena_vsi(vsi)) {
-		synchronize_rcu();
+	if (ice_is_xdp_ena_vsi(vsi))
 		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
-	}
 	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
 }
 
@@ -172,11 +170,12 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		usleep_range(1000, 2000);
 	}
 
+	synchronize_net();
+	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+
 	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
 	ice_qvec_toggle_napi(vsi, q_vector, false);
 
-	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
-
 	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
 	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
 	if (err)
@@ -191,10 +190,8 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		if (err)
 			return err;
 	}
-	err = ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true);
-	if (err)
-		return err;
 
+	ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, false);
 	ice_qp_clean_rings(vsi, q_idx);
 	ice_qp_reset_stats(vsi, q_idx);
 
@@ -937,6 +934,10 @@ bool ice_xmit_zc(struct ice_tx_ring *xdp_ring)
 
 	ice_clean_xdp_irq_zc(xdp_ring);
 
+	if (!netif_carrier_ok(xdp_ring->vsi->netdev) ||
+	    !netif_running(xdp_ring->vsi->netdev))
+		return true;
+
 	budget = ICE_DESC_UNUSED(xdp_ring);
 	budget = min_t(u16, budget, ICE_RING_QUARTER(xdp_ring));
 
@@ -980,7 +981,7 @@ ice_xsk_wakeup(struct net_device *netdev, u32 queue_id,
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_tx_ring *ring;
 
-	if (test_bit(ICE_VSI_DOWN, vsi->state))
+	if (test_bit(ICE_VSI_DOWN, vsi->state) || !netif_carrier_ok(netdev))
 		return -ENETDOWN;
 
 	if (!ice_is_xdp_ena_vsi(vsi))
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 2f80ee84c7ec..bbcdab562513 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -953,13 +953,13 @@ static void mvpp2_bm_pool_update_fc(struct mvpp2_port *port,
 static void mvpp2_bm_pool_update_priv_fc(struct mvpp2 *priv, bool en)
 {
 	struct mvpp2_port *port;
-	int i;
+	int i, j;
 
 	for (i = 0; i < priv->port_count; i++) {
 		port = priv->port_list[i];
 		if (port->priv->percpu_pools) {
-			for (i = 0; i < port->nrxqs; i++)
-				mvpp2_bm_pool_update_fc(port, &port->priv->bm_pools[i],
+			for (j = 0; j < port->nrxqs; j++)
+				mvpp2_bm_pool_update_fc(port, &port->priv->bm_pools[j],
 							port->tx_fc & en);
 		} else {
 			mvpp2_bm_pool_update_fc(port, port->pool_long, port->tx_fc & en);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index ceeb23f478e1..3ee61987266c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1223,7 +1223,12 @@ int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
 	if (!an_changes && link_modes == eproto.admin)
 		goto out;
 
-	mlx5_port_set_eth_ptys(mdev, an_disable, link_modes, ext);
+	err = mlx5_port_set_eth_ptys(mdev, an_disable, link_modes, ext);
+	if (err) {
+		netdev_err(priv->netdev, "%s: failed to set ptys reg: %d\n", __func__, err);
+		goto out;
+	}
+
 	mlx5_toggle_port_link(mdev);
 
 out:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index dec1492da74d..1a818759a9aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -145,6 +145,7 @@ int mlx5_fw_reset_set_live_patch(struct mlx5_core_dev *dev)
 static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
+	struct devlink *devlink = priv_to_devlink(dev);
 
 	/* if this is the driver that initiated the fw reset, devlink completed the reload */
 	if (test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags)) {
@@ -155,9 +156,11 @@ static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev)
 			mlx5_core_err(dev, "reset reload flow aborted, PCI reads still not working\n");
 		else
 			mlx5_load_one(dev, true);
-		devlink_remote_reload_actions_performed(priv_to_devlink(dev), 0,
+		devl_lock(devlink);
+		devlink_remote_reload_actions_performed(devlink, 0,
 							BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
 							BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE));
+		devl_unlock(devlink);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index a283d8ae466b..4b4d76108111 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1483,7 +1483,7 @@ u8 mlx5_lag_get_slave_port(struct mlx5_core_dev *dev,
 		goto unlock;
 
 	for (i = 0; i < ldev->ports; i++) {
-		if (ldev->pf[MLX5_LAG_P1].netdev == slave) {
+		if (ldev->pf[i].netdev == slave) {
 			port = i;
 			break;
 		}
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index f83bd15f9e99..b187371fa2f0 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4273,7 +4273,8 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 	if (unlikely(!rtl_tx_slots_avail(tp))) {
 		if (net_ratelimit())
 			netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
-		goto err_stop_0;
+		netif_stop_queue(dev);
+		return NETDEV_TX_BUSY;
 	}
 
 	opts[1] = rtl8169_tx_vlan_tag(skb);
@@ -4346,11 +4347,6 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 	dev_kfree_skb_any(skb);
 	dev->stats.tx_dropped++;
 	return NETDEV_TX_OK;
-
-err_stop_0:
-	netif_stop_queue(dev);
-	dev->stats.tx_dropped++;
-	return NETDEV_TX_BUSY;
 }
 
 static unsigned int rtl_last_frag_len(struct sk_buff *skb)
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 5ea9dc251dd9..ff777735be66 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1825,9 +1825,9 @@ static void axienet_dma_err_handler(struct work_struct *work)
 			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
 	axienet_set_mac_address(ndev, NULL);
 	axienet_set_multicast_list(ndev);
-	axienet_setoptions(ndev, lp->options);
 	napi_enable(&lp->napi_rx);
 	napi_enable(&lp->napi_tx);
+	axienet_setoptions(ndev, lp->options);
 }
 
 /**
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 0a662e42ed96..cb7d2f798fb4 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -179,6 +179,7 @@ static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	struct usbnet *dev = netdev_priv(netdev);
 	__le16 res;
 	int rc = 0;
+	int err;
 
 	if (phy_id) {
 		netdev_dbg(netdev, "Only internal phy supported\n");
@@ -189,11 +190,17 @@ static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	if (loc == MII_BMSR) {
 		u8 value;
 
-		sr_read_reg(dev, SR_NSR, &value);
+		err = sr_read_reg(dev, SR_NSR, &value);
+		if (err < 0)
+			return err;
+
 		if (value & NSR_LINKST)
 			rc = 1;
 	}
-	sr_share_read_word(dev, 1, loc, &res);
+	err = sr_share_read_word(dev, 1, loc, &res);
+	if (err < 0)
+		return err;
+
 	if (rc == 1)
 		res = le16_to_cpu(res) | BMSR_LSTATUS;
 	else
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 475a6dd72db6..809fabef3b44 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -805,9 +805,11 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
 	if (ret == -ENOPROTOOPT) {
 		dev_dbg(ec_dev->dev,
 			"GET_NEXT_EVENT returned invalid version error.\n");
+		mutex_lock(&ec_dev->lock);
 		ret = cros_ec_get_host_command_version_mask(ec_dev,
 							EC_CMD_GET_NEXT_EVENT,
 							&ver_mask);
+		mutex_unlock(&ec_dev->lock);
 		if (ret < 0 || ver_mask == 0)
 			/*
 			 * Do not change the MKBP supported version if we can't
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 676978f2e994..e9a0b27e1c4f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1065,8 +1065,8 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		block_group->space_info->active_total_bytes -= block_group->length;
 	block_group->space_info->bytes_readonly -=
 		(block_group->length - block_group->zone_unusable);
-	block_group->space_info->bytes_zone_unusable -=
-		block_group->zone_unusable;
+	btrfs_space_info_update_bytes_zone_unusable(fs_info, block_group->space_info,
+						    -block_group->zone_unusable);
 	block_group->space_info->disk_total -= block_group->length * factor;
 
 	spin_unlock(&block_group->space_info->lock);
@@ -1250,7 +1250,8 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 		if (btrfs_is_zoned(cache->fs_info)) {
 			/* Migrate zone_unusable bytes to readonly */
 			sinfo->bytes_readonly += cache->zone_unusable;
-			sinfo->bytes_zone_unusable -= cache->zone_unusable;
+			btrfs_space_info_update_bytes_zone_unusable(cache->fs_info, sinfo,
+								    -cache->zone_unusable);
 			cache->zone_unusable = 0;
 		}
 		cache->ro++;
@@ -2812,9 +2813,11 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 		if (btrfs_is_zoned(cache->fs_info)) {
 			/* Migrate zone_unusable bytes back */
 			cache->zone_unusable =
-				(cache->alloc_offset - cache->used) +
+				(cache->alloc_offset - cache->used - cache->pinned -
+				 cache->reserved) +
 				(cache->length - cache->zone_capacity);
-			sinfo->bytes_zone_unusable += cache->zone_unusable;
+			btrfs_space_info_update_bytes_zone_unusable(cache->fs_info, sinfo,
+								    cache->zone_unusable);
 			sinfo->bytes_readonly -= cache->zone_unusable;
 		}
 		num_bytes = cache->length - cache->reserved -
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0d2cc186974d..528cd88a77fd 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2731,7 +2731,8 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			readonly = true;
 		} else if (btrfs_is_zoned(fs_info)) {
 			/* Need reset before reusing in a zoned block group */
-			space_info->bytes_zone_unusable += len;
+			btrfs_space_info_update_bytes_zone_unusable(fs_info, space_info,
+								    len);
 			readonly = true;
 		}
 		spin_unlock(&cache->lock);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 862a222caab3..76d52d682b3b 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2702,8 +2702,10 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	 * If the block group is read-only, we should account freed space into
 	 * bytes_readonly.
 	 */
-	if (!block_group->ro)
+	if (!block_group->ro) {
 		block_group->zone_unusable += to_unusable;
+		WARN_ON(block_group->zone_unusable > block_group->length);
+	}
 	spin_unlock(&ctl->tree_lock);
 	if (!used) {
 		spin_lock(&block_group->lock);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 8b75f436a9a3..bede72f3dffc 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -311,7 +311,7 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	found->bytes_used += block_group->used;
 	found->disk_used += block_group->used * factor;
 	found->bytes_readonly += block_group->bytes_super;
-	found->bytes_zone_unusable += block_group->zone_unusable;
+	btrfs_space_info_update_bytes_zone_unusable(info, found, block_group->zone_unusable);
 	if (block_group->length > 0)
 		found->full = 0;
 	btrfs_try_granting_tickets(info, found);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index ce66023a9eb8..99ce3225dd59 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -121,6 +121,7 @@ btrfs_space_info_update_##name(struct btrfs_fs_info *fs_info,		\
 
 DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "space_info");
 DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
+DECLARE_SPACE_INFO_UPDATE(bytes_zone_unusable, "zone_unusable");
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 67af684e44e6..5cbe5ae5ad4a 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3113,8 +3113,9 @@ static int ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
 	if (ee_len == 0)
 		return 0;
 
-	return ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
-				     EXTENT_STATUS_WRITTEN);
+	ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
+			      EXTENT_STATUS_WRITTEN);
+	return 0;
 }
 
 /* FIXME!! we need to try to merge to left or right after zero-out  */
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 9766d3b21ca2..592229027af7 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -847,12 +847,10 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
 /*
  * ext4_es_insert_extent() adds information to an inode's extent
  * status tree.
- *
- * Return 0 on success, error code on failure.
  */
-int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
-			  ext4_lblk_t len, ext4_fsblk_t pblk,
-			  unsigned int status)
+void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
+			   ext4_lblk_t len, ext4_fsblk_t pblk,
+			   unsigned int status)
 {
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
@@ -864,13 +862,13 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	bool revise_pending = false;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
-		return 0;
+		return;
 
 	es_debug("add [%u/%u) %llu %x to extent status tree of inode %lu\n",
 		 lblk, len, pblk, status, inode->i_ino);
 
 	if (!len)
-		return 0;
+		return;
 
 	BUG_ON(end < lblk);
 
@@ -939,7 +937,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		goto retry;
 
 	ext4_es_print_tree(inode);
-	return 0;
+	return;
 }
 
 /*
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 4ec30a798260..481ec4381bee 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -127,9 +127,9 @@ extern int __init ext4_init_es(void);
 extern void ext4_exit_es(void);
 extern void ext4_es_init_tree(struct ext4_es_tree *tree);
 
-extern int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
-				 ext4_lblk_t len, ext4_fsblk_t pblk,
-				 unsigned int status);
+extern void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
+				  ext4_lblk_t len, ext4_fsblk_t pblk,
+				  unsigned int status);
 extern void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 				 ext4_lblk_t len, ext4_fsblk_t pblk,
 				 unsigned int status);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2479508deab3..93a1c22048de 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -481,6 +481,35 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 }
 #endif /* ES_AGGRESSIVE_TEST */
 
+static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
+				 struct ext4_map_blocks *map)
+{
+	unsigned int status;
+	int retval;
+
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		retval = ext4_ext_map_blocks(handle, inode, map, 0);
+	else
+		retval = ext4_ind_map_blocks(handle, inode, map, 0);
+
+	if (retval <= 0)
+		return retval;
+
+	if (unlikely(retval != map->m_len)) {
+		ext4_warning(inode->i_sb,
+			     "ES len assertion failed for inode "
+			     "%lu: retval %d != map->m_len %d",
+			     inode->i_ino, retval, map->m_len);
+		WARN_ON(1);
+	}
+
+	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
+			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
+	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+			      map->m_pblk, status);
+	return retval;
+}
+
 /*
  * The ext4_map_blocks() function tries to look up the requested blocks,
  * and returns if the blocks are already mapped.
@@ -595,10 +624,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
 				       map->m_lblk + map->m_len - 1))
 			status |= EXTENT_STATUS_DELAYED;
-		ret = ext4_es_insert_extent(inode, map->m_lblk,
-					    map->m_len, map->m_pblk, status);
-		if (ret < 0)
-			retval = ret;
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status);
 	}
 	up_read((&EXT4_I(inode)->i_data_sem));
 
@@ -707,12 +734,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
 				       map->m_lblk + map->m_len - 1))
 			status |= EXTENT_STATUS_DELAYED;
-		ret = ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-					    map->m_pblk, status);
-		if (ret < 0) {
-			retval = ret;
-			goto out_sem;
-		}
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status);
 	}
 
 out_sem:
@@ -1746,12 +1769,10 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 
 	/* Lookup extent status tree firstly */
 	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
-		if (ext4_es_is_hole(&es)) {
-			retval = 0;
-			down_read(&EXT4_I(inode)->i_data_sem);
+		if (ext4_es_is_hole(&es))
 			goto add_delayed;
-		}
 
+found:
 		/*
 		 * Delayed extent could be allocated by fallocate.
 		 * So we need to check it.
@@ -1788,52 +1809,42 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 	down_read(&EXT4_I(inode)->i_data_sem);
 	if (ext4_has_inline_data(inode))
 		retval = 0;
-	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		retval = ext4_ext_map_blocks(NULL, inode, map, 0);
 	else
-		retval = ext4_ind_map_blocks(NULL, inode, map, 0);
+		retval = ext4_map_query_blocks(NULL, inode, map);
+	up_read(&EXT4_I(inode)->i_data_sem);
+	if (retval)
+		return retval;
 
 add_delayed:
-	if (retval == 0) {
-		int ret;
-
-		/*
-		 * XXX: __block_prepare_write() unmaps passed block,
-		 * is it OK?
-		 */
-
-		ret = ext4_insert_delayed_block(inode, map->m_lblk);
-		if (ret != 0) {
-			retval = ret;
-			goto out_unlock;
+	down_write(&EXT4_I(inode)->i_data_sem);
+	/*
+	 * Page fault path (ext4_page_mkwrite does not take i_rwsem)
+	 * and fallocate path (no folio lock) can race. Make sure we
+	 * lookup the extent status tree here again while i_data_sem
+	 * is held in write mode, before inserting a new da entry in
+	 * the extent status tree.
+	 */
+	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
+		if (!ext4_es_is_hole(&es)) {
+			up_write(&EXT4_I(inode)->i_data_sem);
+			goto found;
 		}
-
-		map_bh(bh, inode->i_sb, invalid_block);
-		set_buffer_new(bh);
-		set_buffer_delay(bh);
-	} else if (retval > 0) {
-		int ret;
-		unsigned int status;
-
-		if (unlikely(retval != map->m_len)) {
-			ext4_warning(inode->i_sb,
-				     "ES len assertion failed for inode "
-				     "%lu: retval %d != map->m_len %d",
-				     inode->i_ino, retval, map->m_len);
-			WARN_ON(1);
+	} else if (!ext4_has_inline_data(inode)) {
+		retval = ext4_map_query_blocks(NULL, inode, map);
+		if (retval) {
+			up_write(&EXT4_I(inode)->i_data_sem);
+			return retval;
 		}
-
-		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
-				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-		ret = ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-					    map->m_pblk, status);
-		if (ret != 0)
-			retval = ret;
 	}
 
-out_unlock:
-	up_read((&EXT4_I(inode)->i_data_sem));
+	retval = ext4_insert_delayed_block(inode, map->m_lblk);
+	up_write(&EXT4_I(inode)->i_data_sem);
+	if (retval)
+		return retval;
 
+	map_bh(bh, inode->i_sb, invalid_block);
+	set_buffer_new(bh);
+	set_buffer_delay(bh);
 	return retval;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e19b569d938d..1264a350d4d7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3185,7 +3185,9 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 		if (page_private_gcing(fio->page)) {
 			if (fio->sbi->am.atgc_enabled &&
 				(fio->io_type == FS_DATA_IO) &&
-				(fio->sbi->gc_mode != GC_URGENT_HIGH))
+				(fio->sbi->gc_mode != GC_URGENT_HIGH) &&
+				__is_valid_data_blkaddr(fio->old_blkaddr) &&
+				!is_inode_flag_set(inode, FI_OPU_WRITE))
 				return CURSEG_ALL_DATA_ATGC;
 			else
 				return CURSEG_COLD_DATA;
diff --git a/fs/file.c b/fs/file.c
index 69386c2e37c5..82c5d2382082 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1122,6 +1122,7 @@ __releases(&files->file_lock)
 	 * tables and this condition does not arise without those.
 	 */
 	fdt = files_fdtable(files);
+	fd = array_index_nospec(fd, fdt->max_fds);
 	tofree = fdt->fd[fd];
 	if (!tofree && fd_is_open(fd, fdt))
 		goto Ebusy;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 4a4c04a3b1a0..df77a7bcce49 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -483,12 +483,10 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 			make_empty_dir_inode(inode);
 	}
 
+	inode->i_uid = GLOBAL_ROOT_UID;
+	inode->i_gid = GLOBAL_ROOT_GID;
 	if (root->set_ownership)
-		root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
-	else {
-		inode->i_uid = GLOBAL_ROOT_UID;
-		inode->i_gid = GLOBAL_ROOT_GID;
-	}
+		root->set_ownership(head, &inode->i_uid, &inode->i_gid);
 
 	return inode;
 }
diff --git a/include/linux/leds.h b/include/linux/leds.h
index ba4861ec73d3..79ab2dfd3c72 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -356,6 +356,9 @@ struct led_trigger {
 	int		(*activate)(struct led_classdev *led_cdev);
 	void		(*deactivate)(struct led_classdev *led_cdev);
 
+	/* Brightness set by led_trigger_event */
+	enum led_brightness brightness;
+
 	/* LED-private triggers have this set */
 	struct led_hw_trigger_type *trigger_type;
 
@@ -409,22 +412,11 @@ static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
 	return led_cdev->trigger_data;
 }
 
-/**
- * led_trigger_rename_static - rename a trigger
- * @name: the new trigger name
- * @trig: the LED trigger to rename
- *
- * Change a LED trigger name by copying the string passed in
- * name into current trigger name, which MUST be large
- * enough for the new string.
- *
- * Note that name must NOT point to the same string used
- * during LED registration, as that could lead to races.
- *
- * This is meant to be used on triggers with statically
- * allocated name.
- */
-void led_trigger_rename_static(const char *name, struct led_trigger *trig);
+static inline enum led_brightness
+led_trigger_get_brightness(const struct led_trigger *trigger)
+{
+	return trigger ? trigger->brightness : LED_OFF;
+}
 
 #define module_led_trigger(__led_trigger) \
 	module_driver(__led_trigger, led_trigger_register, \
@@ -462,6 +454,12 @@ static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
 	return NULL;
 }
 
+static inline enum led_brightness
+led_trigger_get_brightness(const struct led_trigger *trigger)
+{
+	return LED_OFF;
+}
+
 #endif /* CONFIG_LEDS_TRIGGERS */
 
 /* Trigger specific functions */
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index a207c7ed41bd..9f24feb94b24 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -185,7 +185,6 @@ struct ctl_table_root {
 	struct ctl_table_set default_set;
 	struct ctl_table_set *(*lookup)(struct ctl_table_root *root);
 	void (*set_ownership)(struct ctl_table_header *head,
-			      struct ctl_table *table,
 			      kuid_t *uid, kgid_t *gid);
 	int (*permissions)(struct ctl_table_header *head, struct ctl_table *table);
 };
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 5e10b5b1d16c..7a6c5a870d33 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2322,6 +2322,14 @@ DEFINE_EVENT(btrfs__space_info_update, update_bytes_pinned,
 	TP_ARGS(fs_info, sinfo, old, diff)
 );
 
+DEFINE_EVENT(btrfs__space_info_update, update_bytes_zone_unusable,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info,
+		 const struct btrfs_space_info *sinfo, u64 old, s64 diff),
+
+	TP_ARGS(fs_info, sinfo, old, diff)
+);
+
 DECLARE_EVENT_CLASS(btrfs_raid56_bio,
 
 	TP_PROTO(const struct btrfs_raid_bio *rbio,
diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 563e48617374..54e8fb5a229c 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -34,7 +34,7 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		struct sock *ssk;
 
 		__entry->active = mptcp_subflow_active(subflow);
-		__entry->backup = subflow->backup;
+		__entry->backup = subflow->backup || subflow->request_bkup;
 
 		if (subflow->tcp_sock && sk_fullsock(subflow->tcp_sock))
 			__entry->free = sk_stream_memory_free(subflow->tcp_sock);
diff --git a/init/Kconfig b/init/Kconfig
index 537f01eba2e6..4cd3fc82b09e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1924,6 +1924,7 @@ config RUST
 	depends on !MODVERSIONS
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
+	depends on !SHADOW_CALL_STACK
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
 	help
 	  Enables Rust support in the kernel.
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index ef313ecfb53a..d7ca2bdae9e8 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -14,6 +14,7 @@
 #include <linux/ipc_namespace.h>
 #include <linux/msg.h>
 #include <linux/slab.h>
+#include <linux/cred.h>
 #include "util.h"
 
 static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
@@ -190,25 +191,56 @@ static int set_is_seen(struct ctl_table_set *set)
 	return &current->nsproxy->ipc_ns->ipc_set == set;
 }
 
+static void ipc_set_ownership(struct ctl_table_header *head,
+			      kuid_t *uid, kgid_t *gid)
+{
+	struct ipc_namespace *ns =
+		container_of(head->set, struct ipc_namespace, ipc_set);
+
+	kuid_t ns_root_uid = make_kuid(ns->user_ns, 0);
+	kgid_t ns_root_gid = make_kgid(ns->user_ns, 0);
+
+	*uid = uid_valid(ns_root_uid) ? ns_root_uid : GLOBAL_ROOT_UID;
+	*gid = gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
+}
+
 static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
 {
 	int mode = table->mode;
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
-	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
+	struct ipc_namespace *ns =
+		container_of(head->set, struct ipc_namespace, ipc_set);
 
 	if (((table->data == &ns->ids[IPC_SEM_IDS].next_id) ||
 	     (table->data == &ns->ids[IPC_MSG_IDS].next_id) ||
 	     (table->data == &ns->ids[IPC_SHM_IDS].next_id)) &&
 	    checkpoint_restore_ns_capable(ns->user_ns))
 		mode = 0666;
+	else
 #endif
-	return mode;
+	{
+		kuid_t ns_root_uid;
+		kgid_t ns_root_gid;
+
+		ipc_set_ownership(head, &ns_root_uid, &ns_root_gid);
+
+		if (uid_eq(current_euid(), ns_root_uid))
+			mode >>= 6;
+
+		else if (in_egroup_p(ns_root_gid))
+			mode >>= 3;
+	}
+
+	mode &= 7;
+
+	return (mode << 6) | (mode << 3) | mode;
 }
 
 static struct ctl_table_root set_root = {
 	.lookup = set_lookup,
 	.permissions = ipc_permissions,
+	.set_ownership = ipc_set_ownership,
 };
 
 bool setup_ipc_sysctls(struct ipc_namespace *ns)
diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index fbf6a8b93a26..c960691fc24d 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -12,6 +12,7 @@
 #include <linux/stat.h>
 #include <linux/capability.h>
 #include <linux/slab.h>
+#include <linux/cred.h>
 
 static int msg_max_limit_min = MIN_MSGMAX;
 static int msg_max_limit_max = HARD_MSGMAX;
@@ -76,8 +77,42 @@ static int set_is_seen(struct ctl_table_set *set)
 	return &current->nsproxy->ipc_ns->mq_set == set;
 }
 
+static void mq_set_ownership(struct ctl_table_header *head,
+			     kuid_t *uid, kgid_t *gid)
+{
+	struct ipc_namespace *ns =
+		container_of(head->set, struct ipc_namespace, mq_set);
+
+	kuid_t ns_root_uid = make_kuid(ns->user_ns, 0);
+	kgid_t ns_root_gid = make_kgid(ns->user_ns, 0);
+
+	*uid = uid_valid(ns_root_uid) ? ns_root_uid : GLOBAL_ROOT_UID;
+	*gid = gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
+}
+
+static int mq_permissions(struct ctl_table_header *head, struct ctl_table *table)
+{
+	int mode = table->mode;
+	kuid_t ns_root_uid;
+	kgid_t ns_root_gid;
+
+	mq_set_ownership(head, &ns_root_uid, &ns_root_gid);
+
+	if (uid_eq(current_euid(), ns_root_uid))
+		mode >>= 6;
+
+	else if (in_egroup_p(ns_root_gid))
+		mode >>= 3;
+
+	mode &= 7;
+
+	return (mode << 6) | (mode << 3) | mode;
+}
+
 static struct ctl_table_root set_root = {
 	.lookup = set_lookup,
+	.permissions = mq_permissions,
+	.set_ownership = mq_set_ownership,
 };
 
 bool setup_mq_sysctls(struct ipc_namespace *ns)
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 607c0c3d3f5e..6aea9d25ab9a 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -154,7 +154,6 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
-			domain->fwnode = fwnode;
 			domain->name = kstrdup(fwid->name, GFP_KERNEL);
 			if (!domain->name) {
 				kfree(domain);
@@ -163,7 +162,6 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 			break;
 		default:
-			domain->fwnode = fwnode;
 			domain->name = fwid->name;
 			break;
 		}
@@ -185,7 +183,6 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		strreplace(name, '/', ':');
 
 		domain->name = name;
-		domain->fwnode = fwnode;
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
@@ -201,8 +198,8 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
-	fwnode_handle_get(fwnode);
-	fwnode_dev_initialized(fwnode, true);
+	domain->fwnode = fwnode_handle_get(fwnode);
+	fwnode_dev_initialized(domain->fwnode, true);
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
diff --git a/mm/Kconfig b/mm/Kconfig
index 35109a4a2f7c..a65145fe89f2 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -627,6 +627,17 @@ config HUGETLB_PAGE_SIZE_VARIABLE
 config CONTIG_ALLOC
 	def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
 
+config PCP_BATCH_SCALE_MAX
+	int "Maximum scale factor of PCP (Per-CPU pageset) batch allocate/free"
+	default 5
+	range 0 6
+	help
+	  In page allocator, PCP (Per-CPU pageset) is refilled and drained in
+	  batches.  The batch number is scaled automatically to improve page
+	  allocation/free throughput.  But too large scale factor may hurt
+	  latency.  This option sets the upper limit of scale factor to limit
+	  the maximum latency.
+
 config PHYS_ADDR_T_64BIT
 	def_bool 64BIT
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12412263d131..a905b850d31c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3176,14 +3176,21 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
  */
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
-	struct per_cpu_pages *pcp;
+	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+	int count;
 
-	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-	if (pcp->count) {
+	do {
 		spin_lock(&pcp->lock);
-		free_pcppages_bulk(zone, pcp->count, pcp, 0);
+		count = pcp->count;
+		if (count) {
+			int to_drain = min(count,
+				pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
+
+			free_pcppages_bulk(zone, to_drain, pcp, 0);
+			count -= to_drain;
+		}
 		spin_unlock(&pcp->lock);
-	}
+	} while (count);
 }
 
 /*
@@ -3389,7 +3396,7 @@ static int nr_pcp_free(struct per_cpu_pages *pcp, int high, int batch,
 	 * freeing of pages without any allocation.
 	 */
 	batch <<= pcp->free_factor;
-	if (batch < max_nr_free)
+	if (batch < max_nr_free && pcp->free_factor < CONFIG_PCP_BATCH_SCALE_MAX)
 		pcp->free_factor++;
 	batch = clamp(batch, min_nr_free, max_nr_free);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 57302021b7eb..320fc1e6dff2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2837,6 +2837,27 @@ static int hci_passive_scan_sync(struct hci_dev *hdev)
 	 */
 	filter_policy = hci_update_accept_list_sync(hdev);
 
+	/* If suspended and filter_policy set to 0x00 (no acceptlist) then
+	 * passive scanning cannot be started since that would require the host
+	 * to be woken up to process the reports.
+	 */
+	if (hdev->suspended && !filter_policy) {
+		/* Check if accept list is empty then there is no need to scan
+		 * while suspended.
+		 */
+		if (list_empty(&hdev->le_accept_list))
+			return 0;
+
+		/* If there are devices is the accept_list that means some
+		 * devices could not be programmed which in non-suspended case
+		 * means filter_policy needs to be set to 0x00 so the host needs
+		 * to filter, but since this is treating suspended case we
+		 * can ignore device needing host to filter to allow devices in
+		 * the acceptlist to be able to wakeup the system.
+		 */
+		filter_policy = 0x01;
+	}
+
 	/* When the controller is using random resolvable addresses and
 	 * with that having LE privacy enabled, then controllers with
 	 * Extended Scanner Filter Policies support can now enable support
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 1163226c025c..be663a7382ce 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3178,7 +3178,7 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(tgt_net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
-		dev = rtnl_dev_get(net, tb);
+		dev = rtnl_dev_get(tgt_net, tb);
 	else if (tb[IFLA_GROUP])
 		err = rtnl_group_dellink(tgt_net, nla_get_u32(tb[IFLA_GROUP]));
 	else
diff --git a/net/ipv4/netfilter/iptable_nat.c b/net/ipv4/netfilter/iptable_nat.c
index 56f6ecc43451..12ca666d6e2c 100644
--- a/net/ipv4/netfilter/iptable_nat.c
+++ b/net/ipv4/netfilter/iptable_nat.c
@@ -145,25 +145,27 @@ static struct pernet_operations iptable_nat_net_ops = {
 
 static int __init iptable_nat_init(void)
 {
-	int ret = xt_register_template(&nf_nat_ipv4_table,
-				       iptable_nat_table_init);
+	int ret;
 
+	/* net->gen->ptr[iptable_nat_net_id] must be allocated
+	 * before calling iptable_nat_table_init().
+	 */
+	ret = register_pernet_subsys(&iptable_nat_net_ops);
 	if (ret < 0)
 		return ret;
 
-	ret = register_pernet_subsys(&iptable_nat_net_ops);
-	if (ret < 0) {
-		xt_unregister_template(&nf_nat_ipv4_table);
-		return ret;
-	}
+	ret = xt_register_template(&nf_nat_ipv4_table,
+				   iptable_nat_table_init);
+	if (ret < 0)
+		unregister_pernet_subsys(&iptable_nat_net_ops);
 
 	return ret;
 }
 
 static void __exit iptable_nat_exit(void)
 {
-	unregister_pernet_subsys(&iptable_nat_net_ops);
 	xt_unregister_template(&nf_nat_ipv4_table);
+	unregister_pernet_subsys(&iptable_nat_net_ops);
 }
 
 module_init(iptable_nat_init);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 8c5a99fe6803..cfb4cf6e6654 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -227,6 +227,7 @@ struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
 		return NULL;
 	memset(ndopts, 0, sizeof(*ndopts));
 	while (opt_len) {
+		bool unknown = false;
 		int l;
 		if (opt_len < sizeof(struct nd_opt_hdr))
 			return NULL;
@@ -262,22 +263,23 @@ struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
 			break;
 #endif
 		default:
-			if (ndisc_is_useropt(dev, nd_opt)) {
-				ndopts->nd_useropts_end = nd_opt;
-				if (!ndopts->nd_useropts)
-					ndopts->nd_useropts = nd_opt;
-			} else {
-				/*
-				 * Unknown options must be silently ignored,
-				 * to accommodate future extension to the
-				 * protocol.
-				 */
-				ND_PRINTK(2, notice,
-					  "%s: ignored unsupported option; type=%d, len=%d\n",
-					  __func__,
-					  nd_opt->nd_opt_type,
-					  nd_opt->nd_opt_len);
-			}
+			unknown = true;
+		}
+		if (ndisc_is_useropt(dev, nd_opt)) {
+			ndopts->nd_useropts_end = nd_opt;
+			if (!ndopts->nd_useropts)
+				ndopts->nd_useropts = nd_opt;
+		} else if (unknown) {
+			/*
+			 * Unknown options must be silently ignored,
+			 * to accommodate future extension to the
+			 * protocol.
+			 */
+			ND_PRINTK(2, notice,
+				  "%s: ignored unsupported option; type=%d, len=%d\n",
+				  __func__,
+				  nd_opt->nd_opt_type,
+				  nd_opt->nd_opt_len);
 		}
 next_opt:
 		opt_len -= l;
diff --git a/net/ipv6/netfilter/ip6table_nat.c b/net/ipv6/netfilter/ip6table_nat.c
index bf3cb3a13600..52d597b16b65 100644
--- a/net/ipv6/netfilter/ip6table_nat.c
+++ b/net/ipv6/netfilter/ip6table_nat.c
@@ -147,23 +147,27 @@ static struct pernet_operations ip6table_nat_net_ops = {
 
 static int __init ip6table_nat_init(void)
 {
-	int ret = xt_register_template(&nf_nat_ipv6_table,
-				       ip6table_nat_table_init);
+	int ret;
 
+	/* net->gen->ptr[ip6table_nat_net_id] must be allocated
+	 * before calling ip6t_nat_register_lookups().
+	 */
+	ret = register_pernet_subsys(&ip6table_nat_net_ops);
 	if (ret < 0)
 		return ret;
 
-	ret = register_pernet_subsys(&ip6table_nat_net_ops);
+	ret = xt_register_template(&nf_nat_ipv6_table,
+				   ip6table_nat_table_init);
 	if (ret)
-		xt_unregister_template(&nf_nat_ipv6_table);
+		unregister_pernet_subsys(&ip6table_nat_net_ops);
 
 	return ret;
 }
 
 static void __exit ip6table_nat_exit(void)
 {
-	unregister_pernet_subsys(&ip6table_nat_net_ops);
 	xt_unregister_template(&nf_nat_ipv6_table);
+	unregister_pernet_subsys(&ip6table_nat_net_ops);
 }
 
 module_init(ip6table_nat_init);
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 498a0c35b7bb..815b1df0b2d1 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -335,8 +335,8 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
 	struct iucv_sock *iucv = iucv_sk(sk);
 	struct iucv_path *path = iucv->path;
 
-	if (iucv->path) {
-		iucv->path = NULL;
+	/* Whoever resets the path pointer, must sever and free it. */
+	if (xchg(&iucv->path, NULL)) {
 		if (with_user_data) {
 			low_nmcpy(user_data, iucv->src_name);
 			high_nmcpy(user_data, iucv->dst_name);
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a718ebcb5bc6..daf53d685b5f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -904,7 +904,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		return true;
 	} else if (subflow_req->mp_join) {
 		opts->suboptions = OPTION_MPTCP_MPJ_SYNACK;
-		opts->backup = subflow_req->backup;
+		opts->backup = subflow_req->request_bkup;
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3e2cbf0e6ce9..e9dff6382581 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -481,7 +481,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 			msk->last_snd = NULL;
 
 		subflow->send_mp_prio = 1;
-		subflow->backup = backup;
 		subflow->request_bkup = backup;
 	}
 
@@ -1445,6 +1444,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= ret;
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
@@ -1578,16 +1578,25 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
+	int anno_nr = 0;
 
 	list_for_each_entry(entry, rm_list, list) {
-		if ((remove_anno_list_by_saddr(msk, &entry->addr) ||
-		     lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) &&
-		    alist.nr < MPTCP_RM_IDS_MAX)
-			alist.ids[alist.nr++] = entry->addr.id;
+		if (alist.nr >= MPTCP_RM_IDS_MAX)
+			break;
+
+		/* only delete if either announced or matching a subflow */
+		if (remove_anno_list_by_saddr(msk, &entry->addr))
+			anno_nr++;
+		else if (!lookup_subflow_by_saddr(&msk->conn_list,
+						  &entry->addr))
+			continue;
+
+		alist.ids[alist.nr++] = entry->addr.id;
 	}
 
 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= anno_nr;
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
@@ -1600,17 +1609,18 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, rm_list, list) {
-		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
-		    slist.nr < MPTCP_RM_IDS_MAX)
+		if (slist.nr < MPTCP_RM_IDS_MAX &&
+		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
 			slist.ids[slist.nr++] = entry->addr.id;
 
-		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
-		    alist.nr < MPTCP_RM_IDS_MAX)
+		if (alist.nr < MPTCP_RM_IDS_MAX &&
+		    remove_anno_list_by_saddr(msk, &entry->addr))
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
 
 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= alist.nr;
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6f3e1b9e844..75ae91c93129 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -363,8 +363,10 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	skb_orphan(skb);
 
 	/* try to fetch required memory from subflow */
-	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize))
+	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		goto drop;
+	}
 
 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
@@ -851,10 +853,8 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		sk_rbuf = ssk_rbuf;
 
 	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (__mptcp_rmem(sk) > sk_rbuf) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+	if (__mptcp_rmem(sk) > sk_rbuf)
 		return;
-	}
 
 	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);
@@ -1491,13 +1491,15 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	}
 
 	mptcp_for_each_subflow(msk, subflow) {
+		bool backup = subflow->backup || subflow->request_bkup;
+
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
-		nr_active += !subflow->backup;
+		nr_active += !backup;
 		pace = subflow->avg_pacing_rate;
 		if (unlikely(!pace)) {
 			/* init pacing rate from socket */
@@ -1508,9 +1510,9 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		}
 
 		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
-		if (linger_time < send_info[subflow->backup].linger_time) {
-			send_info[subflow->backup].ssk = ssk;
-			send_info[subflow->backup].linger_time = linger_time;
+		if (linger_time < send_info[backup].linger_time) {
+			send_info[backup].ssk = ssk;
+			send_info[backup].linger_time = linger_time;
 		}
 	}
 	__mptcp_set_timeout(sk, tout);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index eaed858c0ff9..a2b85eebb620 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -400,6 +400,7 @@ struct mptcp_subflow_request_sock {
 	u16	mp_capable : 1,
 		mp_join : 1,
 		backup : 1,
+		request_bkup : 1,
 		csum_reqd : 1,
 		allow_join_id0 : 1;
 	u8	local_id;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f1d422396b28..96bdd4119578 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1103,14 +1103,22 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
-	u32 incr;
+	struct tcp_sock *tp = tcp_sk(ssk);
+	u32 offset, incr, avail_len;
 
-	incr = limit >= skb->len ? skb->len + fin : limit;
+	offset = tp->copied_seq - TCP_SKB_CB(skb)->seq;
+	if (WARN_ON_ONCE(offset > skb->len))
+		goto out;
+
+	avail_len = skb->len - offset;
+	incr = limit >= avail_len ? avail_len + fin : limit;
 
-	pr_debug("discarding=%d len=%d seq=%d", incr, skb->len,
-		 subflow->map_subflow_seq);
+	pr_debug("discarding=%d len=%d offset=%d seq=%d", incr, skb->len,
+		 offset, subflow->map_subflow_seq);
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
 	tcp_sk(ssk)->copied_seq += incr;
+
+out:
 	if (!before(tcp_sk(ssk)->copied_seq, TCP_SKB_CB(skb)->end_seq))
 		sk_eat_skb(ssk, skb);
 	if (mptcp_subflow_get_map_offset(subflow) >= subflow->map_data_len)
@@ -1876,6 +1884,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->mp_join = 1;
 		new_ctx->fully_established = 1;
 		new_ctx->backup = subflow_req->backup;
+		new_ctx->request_bkup = subflow_req->request_bkup;
 		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
 		new_ctx->token = subflow_req->token;
 		new_ctx->thmac = subflow_req->thmac;
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index e839c356bcb5..902ff2f3bc72 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -547,6 +547,9 @@ list_set_cancel_gc(struct ip_set *set)
 
 	if (SET_WITH_TIMEOUT(set))
 		del_timer_sync(&map->gc);
+
+	/* Flush list to drop references to other ipsets */
+	list_set_flush(set);
 }
 
 static const struct ip_set_type_variant set_variant = {
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 44ff7f356ec1..9594dbc32165 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -42,6 +42,8 @@ static DEFINE_MUTEX(zones_mutex);
 struct zones_ht_key {
 	struct net *net;
 	u16 zone;
+	/* Note : pad[] must be the last field. */
+	u8  pad[];
 };
 
 struct tcf_ct_flow_table {
@@ -58,7 +60,7 @@ struct tcf_ct_flow_table {
 static const struct rhashtable_params zones_params = {
 	.head_offset = offsetof(struct tcf_ct_flow_table, node),
 	.key_offset = offsetof(struct tcf_ct_flow_table, key),
-	.key_len = sizeof_field(struct tcf_ct_flow_table, key),
+	.key_len = offsetof(struct zones_ht_key, pad),
 	.automatic_shrinking = true,
 };
 
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 4b45ed631eb8..2edb8040eb6c 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -54,7 +54,6 @@ static int net_ctl_permissions(struct ctl_table_header *head,
 }
 
 static void net_ctl_set_ownership(struct ctl_table_header *head,
-				  struct ctl_table *table,
 				  kuid_t *uid, kgid_t *gid)
 {
 	struct net *net = container_of(head->set, struct net, sysctls);
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 875312568369..842fe127c537 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -77,6 +77,8 @@
 // overrun. Actual device can skip more, then this module stops the packet streaming.
 #define IR_JUMBO_PAYLOAD_MAX_SKIP_CYCLES	5
 
+static void pcm_period_work(struct work_struct *work);
+
 /**
  * amdtp_stream_init - initialize an AMDTP stream structure
  * @s: the AMDTP stream to initialize
@@ -105,6 +107,7 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	s->flags = flags;
 	s->context = ERR_PTR(-1);
 	mutex_init(&s->mutex);
+	INIT_WORK(&s->period_work, pcm_period_work);
 	s->packet_index = 0;
 
 	init_waitqueue_head(&s->ready_wait);
@@ -343,6 +346,7 @@ EXPORT_SYMBOL(amdtp_stream_get_max_payload);
  */
 void amdtp_stream_pcm_prepare(struct amdtp_stream *s)
 {
+	cancel_work_sync(&s->period_work);
 	s->pcm_buffer_pointer = 0;
 	s->pcm_period_pointer = 0;
 }
@@ -609,19 +613,21 @@ static void update_pcm_pointers(struct amdtp_stream *s,
 		// The program in user process should periodically check the status of intermediate
 		// buffer associated to PCM substream to process PCM frames in the buffer, instead
 		// of receiving notification of period elapsed by poll wait.
-		if (!pcm->runtime->no_period_wakeup) {
-			if (in_softirq()) {
-				// In software IRQ context for 1394 OHCI.
-				snd_pcm_period_elapsed(pcm);
-			} else {
-				// In process context of ALSA PCM application under acquired lock of
-				// PCM substream.
-				snd_pcm_period_elapsed_under_stream_lock(pcm);
-			}
-		}
+		if (!pcm->runtime->no_period_wakeup)
+			queue_work(system_highpri_wq, &s->period_work);
 	}
 }
 
+static void pcm_period_work(struct work_struct *work)
+{
+	struct amdtp_stream *s = container_of(work, struct amdtp_stream,
+					      period_work);
+	struct snd_pcm_substream *pcm = READ_ONCE(s->pcm);
+
+	if (pcm)
+		snd_pcm_period_elapsed(pcm);
+}
+
 static int queue_packet(struct amdtp_stream *s, struct fw_iso_packet *params,
 			bool sched_irq)
 {
@@ -1738,11 +1744,14 @@ unsigned long amdtp_domain_stream_pcm_pointer(struct amdtp_domain *d,
 {
 	struct amdtp_stream *irq_target = d->irq_target;
 
-	// Process isochronous packets queued till recent isochronous cycle to handle PCM frames.
 	if (irq_target && amdtp_stream_running(irq_target)) {
-		// In software IRQ context, the call causes dead-lock to disable the tasklet
-		// synchronously.
-		if (!in_softirq())
+		// use wq to prevent AB/BA deadlock competition for
+		// substream lock:
+		// fw_iso_context_flush_completions() acquires
+		// lock by ohci_flush_iso_completions(),
+		// amdtp-stream process_rx_packets() attempts to
+		// acquire same lock by snd_pcm_elapsed()
+		if (current_work() != &s->period_work)
 			fw_iso_context_flush_completions(irq_target->context);
 	}
 
@@ -1798,6 +1807,7 @@ static void amdtp_stream_stop(struct amdtp_stream *s)
 		return;
 	}
 
+	cancel_work_sync(&s->period_work);
 	fw_iso_context_stop(s->context);
 	fw_iso_context_destroy(s->context);
 	s->context = ERR_PTR(-1);
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index cf9ab347277f..011d0f0c3941 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -190,6 +190,7 @@ struct amdtp_stream {
 
 	/* For a PCM substream processing. */
 	struct snd_pcm_substream *pcm;
+	struct work_struct period_work;
 	snd_pcm_uframes_t pcm_buffer_pointer;
 	unsigned int pcm_period_pointer;
 
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 8556031bcd68..f31cb31d4636 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -28,7 +28,7 @@
 #else
 #define AZX_DCAPS_I915_COMPONENT 0		/* NOP */
 #endif
-/* 14 unused */
+#define AZX_DCAPS_AMD_ALLOC_FIX	(1 << 14)	/* AMD allocation workaround */
 #define AZX_DCAPS_CTX_WORKAROUND (1 << 15)	/* X-Fi workaround */
 #define AZX_DCAPS_POSFIX_LPIB	(1 << 16)	/* Use LPIB as default */
 #define AZX_DCAPS_AMD_WORKAROUND (1 << 17)	/* AMD-specific workaround */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index a26f2a2d44cf..695026c647e1 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -40,6 +40,7 @@
 
 #ifdef CONFIG_X86
 /* for snoop control */
+#include <linux/dma-map-ops.h>
 #include <asm/set_memory.h>
 #include <asm/cpufeature.h>
 #endif
@@ -300,7 +301,7 @@ enum {
 
 /* quirks for ATI HDMI with snoop off */
 #define AZX_DCAPS_PRESET_ATI_HDMI_NS \
-	(AZX_DCAPS_PRESET_ATI_HDMI | AZX_DCAPS_SNOOP_OFF)
+	(AZX_DCAPS_PRESET_ATI_HDMI | AZX_DCAPS_AMD_ALLOC_FIX)
 
 /* quirks for AMD SB */
 #define AZX_DCAPS_PRESET_AMD_SB \
@@ -1718,6 +1719,13 @@ static void azx_check_snoop_available(struct azx *chip)
 	if (chip->driver_caps & AZX_DCAPS_SNOOP_OFF)
 		snoop = false;
 
+#ifdef CONFIG_X86
+	/* check the presence of DMA ops (i.e. IOMMU), disable snoop conditionally */
+	if ((chip->driver_caps & AZX_DCAPS_AMD_ALLOC_FIX) &&
+	    !get_dma_ops(chip->card->dev))
+		snoop = false;
+#endif
+
 	chip->snoop = snoop;
 	if (!snoop) {
 		dev_info(chip->card->dev, "Force to non-snoop mode\n");
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index e8209178d87b..af921364195e 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -21,12 +21,6 @@
 #include "hda_jack.h"
 #include "hda_generic.h"
 
-enum {
-	CX_HEADSET_NOPRESENT = 0,
-	CX_HEADSET_PARTPRESENT,
-	CX_HEADSET_ALLPRESENT,
-};
-
 struct conexant_spec {
 	struct hda_gen_spec gen;
 
@@ -48,7 +42,6 @@ struct conexant_spec {
 	unsigned int gpio_led;
 	unsigned int gpio_mute_led_mask;
 	unsigned int gpio_mic_led_mask;
-	unsigned int headset_present_flag;
 	bool is_cx8070_sn6140;
 };
 
@@ -250,48 +243,19 @@ static void cx_process_headset_plugin(struct hda_codec *codec)
 	}
 }
 
-static void cx_update_headset_mic_vref(struct hda_codec *codec, unsigned int res)
+static void cx_update_headset_mic_vref(struct hda_codec *codec, struct hda_jack_callback *event)
 {
-	unsigned int phone_present, mic_persent, phone_tag, mic_tag;
-	struct conexant_spec *spec = codec->spec;
+	unsigned int mic_present;
 
 	/* In cx8070 and sn6140, the node 16 can only be config to headphone or disabled,
 	 * the node 19 can only be config to microphone or disabled.
 	 * Check hp&mic tag to process headset pulgin&plugout.
 	 */
-	phone_tag = snd_hda_codec_read(codec, 0x16, 0, AC_VERB_GET_UNSOLICITED_RESPONSE, 0x0);
-	mic_tag = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_UNSOLICITED_RESPONSE, 0x0);
-	if ((phone_tag & (res >> AC_UNSOL_RES_TAG_SHIFT)) ||
-	    (mic_tag & (res >> AC_UNSOL_RES_TAG_SHIFT))) {
-		phone_present = snd_hda_codec_read(codec, 0x16, 0, AC_VERB_GET_PIN_SENSE, 0x0);
-		if (!(phone_present & AC_PINSENSE_PRESENCE)) {/* headphone plugout */
-			spec->headset_present_flag = CX_HEADSET_NOPRESENT;
-			snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20);
-			return;
-		}
-		if (spec->headset_present_flag == CX_HEADSET_NOPRESENT) {
-			spec->headset_present_flag = CX_HEADSET_PARTPRESENT;
-		} else if (spec->headset_present_flag == CX_HEADSET_PARTPRESENT) {
-			mic_persent = snd_hda_codec_read(codec, 0x19, 0,
-							 AC_VERB_GET_PIN_SENSE, 0x0);
-			/* headset is present */
-			if ((phone_present & AC_PINSENSE_PRESENCE) &&
-			    (mic_persent & AC_PINSENSE_PRESENCE)) {
-				cx_process_headset_plugin(codec);
-				spec->headset_present_flag = CX_HEADSET_ALLPRESENT;
-			}
-		}
-	}
-}
-
-static void cx_jack_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	struct conexant_spec *spec = codec->spec;
-
-	if (spec->is_cx8070_sn6140)
-		cx_update_headset_mic_vref(codec, res);
-
-	snd_hda_jack_unsol_event(codec, res);
+	mic_present = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_PIN_SENSE, 0x0);
+	if (!(mic_present & AC_PINSENSE_PRESENCE)) /* mic plugout */
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20);
+	else
+		cx_process_headset_plugin(codec);
 }
 
 #ifdef CONFIG_PM
@@ -307,7 +271,7 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 	.build_pcms = snd_hda_gen_build_pcms,
 	.init = cx_auto_init,
 	.free = cx_auto_free,
-	.unsol_event = cx_jack_unsol_event,
+	.unsol_event = snd_hda_jack_unsol_event,
 #ifdef CONFIG_PM
 	.suspend = cx_auto_suspend,
 	.check_power_status = snd_hda_gen_check_power_status,
@@ -1167,7 +1131,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	case 0x14f11f86:
 	case 0x14f11f87:
 		spec->is_cx8070_sn6140 = true;
-		spec->headset_present_flag = CX_HEADSET_NOPRESENT;
+		snd_hda_jack_detect_enable_callback(codec, 0x19, cx_update_headset_mic_vref);
 		break;
 	}
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e0df44bfda4e..edfcd38175d2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9496,6 +9496,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x080d, "Acer Aspire V5-122P", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x0840, "Acer Aspire E1", ALC269VB_FIXUP_ASPIRE_E1_COEF),
+	SND_PCI_QUIRK(0x1025, 0x100c, "Acer Aspire E5-574G", ALC255_FIXUP_ACER_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1025, 0x101c, "Acer Veriton N2510G", ALC269_FIXUP_LIFEBOOK),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1065, "Acer Aspire C20-820", ALC269VC_FIXUP_ACER_HEADSET_MIC),
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index d5409f387945..e14c725acebf 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -244,8 +244,8 @@ static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
 		SNDRV_CHMAP_FR,		/* right front */
 		SNDRV_CHMAP_FC,		/* center front */
 		SNDRV_CHMAP_LFE,	/* LFE */
-		SNDRV_CHMAP_SL,		/* left surround */
-		SNDRV_CHMAP_SR,		/* right surround */
+		SNDRV_CHMAP_RL,		/* left surround */
+		SNDRV_CHMAP_RR,		/* right surround */
 		SNDRV_CHMAP_FLC,	/* left of center */
 		SNDRV_CHMAP_FRC,	/* right of center */
 		SNDRV_CHMAP_RC,		/* surround */
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index e6b514cb7bdd..b6b9f41dbc29 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1040,11 +1040,11 @@ int main_loop_s(int listensock)
 		return 1;
 	}
 
-	if (--cfg_repeat > 0) {
-		if (cfg_input)
-			close(fd);
+	if (cfg_input)
+		close(fd);
+
+	if (--cfg_repeat > 0)
 		goto again;
-	}
 
 	return 0;
 }

