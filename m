Return-Path: <stable+bounces-119837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E60A47E10
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 13:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45D51888EF8
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 12:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DCC22DFB5;
	Thu, 27 Feb 2025 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LwB176Mq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B43922DFA5;
	Thu, 27 Feb 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660141; cv=none; b=Ohl5jc2Zy+o+UrTezKnzRnNnoKHXP689OebjlceoQB2sx04YNGv4yWFRi1xRl5eBRXzP7RFraDsI/Fx4X0SLrdYZcMo8TCZGLHD4R+nxlaA7cWM3YVnkpsCFMQmOoVNOQkGIaRcmWe/KQnO+Qhn4tDLaIlTmAMjVkHFpM2QSnqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660141; c=relaxed/simple;
	bh=WM+s64KUtTGtT96saFNzUfLwNle+GrpHXUbidTu8sY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/fCnVkQZRXHBLGDdCuvrjPQqrTkfTVBCqVoBR0faOYPHAEaBRBY9DXdZNnBl+pdOZJDIyp6mdhbehllTyIc6lqVKcfZHXwGt6uzSw9DQsvKC/+uOSIAbOxGErLnC6l8pkgQEgaFkC2mpKzV9YG3CIgb1DIGXA6eujKbDVxtc/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LwB176Mq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8DCC4CEDD;
	Thu, 27 Feb 2025 12:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740660141;
	bh=WM+s64KUtTGtT96saFNzUfLwNle+GrpHXUbidTu8sY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwB176MqYxYea7t0twBlq7Bqz8w4C+YY8jQ9kDhPzVtzlnwz1JMpagLKDpCWp4ta/
	 ZiDAqFm3GnLym1fecieo3FwuAwNrJ7dlNF0BqrXUiwTitEvz/lkOCdw2RQC/2iw6NX
	 xq7RGvbxe+bWCrVhjIRO1vjXnz6M9T4t7f7rP8DI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.17
Date: Thu, 27 Feb 2025 04:41:08 -0800
Message-ID: <2025022708-passing-garbage-667d@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025022708-splurge-smashup-a92a@gregkh>
References: <2025022708-splurge-smashup-a92a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
index 6cab1f74ae05..7f623d1db72a 100644
--- a/Documentation/networking/strparser.rst
+++ b/Documentation/networking/strparser.rst
@@ -112,7 +112,7 @@ Functions
 Callbacks
 =========
 
-There are six callbacks:
+There are seven callbacks:
 
     ::
 
@@ -182,6 +182,13 @@ There are six callbacks:
     the length of the message. skb->len - offset may be greater
     then full_len since strparser does not trim the skb.
 
+    ::
+
+	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
+                     sk_read_actor_t recv_actor);
+
+    The read_sock callback is used by strparser instead of
+    sock->ops->read_sock, if provided.
     ::
 
 	int (*read_sock_done)(struct strparser *strp, int err);
diff --git a/Makefile b/Makefile
index 340da922fa4f..e8b8c5b38405 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 16
+SUBLEVEL = 17
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index 1aa668c3ccf9..dbdee604edab 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -63,6 +63,18 @@ thermistor {
 		pulldown-ohm = <0>;
 		io-channels = <&auxadc 0>;
 	};
+
+	connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "d";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_connector_out>;
+			};
+		};
+	};
 };
 
 &auxadc {
@@ -120,6 +132,43 @@ &i2c6 {
 	pinctrl-0 = <&i2c6_pins>;
 	status = "okay";
 	clock-frequency = <100000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	it66121hdmitx: hdmitx@4c {
+		compatible = "ite,it66121";
+		reg = <0x4c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ite_pins>;
+		reset-gpios = <&pio 160 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&pio>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+		vcn33-supply = <&mt6358_vcn33_reg>;
+		vcn18-supply = <&mt6358_vcn18_reg>;
+		vrf12-supply = <&mt6358_vrf12_reg>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				it66121_in: endpoint {
+					bus-width = <12>;
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				hdmi_connector_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &keyboard {
@@ -362,6 +411,67 @@ pins_clk {
 			input-enable;
 		};
 	};
+
+	ite_pins: ite-pins {
+		pins-irq {
+			pinmux = <PINMUX_GPIO4__FUNC_GPIO4>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO160__FUNC_GPIO160>;
+			output-high;
+		};
+	};
+
+	dpi_func_pins: dpi-func-pins {
+		pins-dpi {
+			pinmux = <PINMUX_GPIO12__FUNC_I2S5_BCK>,
+				 <PINMUX_GPIO46__FUNC_I2S5_LRCK>,
+				 <PINMUX_GPIO47__FUNC_I2S5_DO>,
+				 <PINMUX_GPIO13__FUNC_DBPI_D0>,
+				 <PINMUX_GPIO14__FUNC_DBPI_D1>,
+				 <PINMUX_GPIO15__FUNC_DBPI_D2>,
+				 <PINMUX_GPIO16__FUNC_DBPI_D3>,
+				 <PINMUX_GPIO17__FUNC_DBPI_D4>,
+				 <PINMUX_GPIO18__FUNC_DBPI_D5>,
+				 <PINMUX_GPIO19__FUNC_DBPI_D6>,
+				 <PINMUX_GPIO20__FUNC_DBPI_D7>,
+				 <PINMUX_GPIO21__FUNC_DBPI_D8>,
+				 <PINMUX_GPIO22__FUNC_DBPI_D9>,
+				 <PINMUX_GPIO23__FUNC_DBPI_D10>,
+				 <PINMUX_GPIO24__FUNC_DBPI_D11>,
+				 <PINMUX_GPIO25__FUNC_DBPI_HSYNC>,
+				 <PINMUX_GPIO26__FUNC_DBPI_VSYNC>,
+				 <PINMUX_GPIO27__FUNC_DBPI_DE>,
+				 <PINMUX_GPIO28__FUNC_DBPI_CK>;
+		};
+	};
+
+	dpi_idle_pins: dpi-idle-pins {
+		pins-idle {
+			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>,
+				 <PINMUX_GPIO46__FUNC_GPIO46>,
+				 <PINMUX_GPIO47__FUNC_GPIO47>,
+				 <PINMUX_GPIO13__FUNC_GPIO13>,
+				 <PINMUX_GPIO14__FUNC_GPIO14>,
+				 <PINMUX_GPIO15__FUNC_GPIO15>,
+				 <PINMUX_GPIO16__FUNC_GPIO16>,
+				 <PINMUX_GPIO17__FUNC_GPIO17>,
+				 <PINMUX_GPIO18__FUNC_GPIO18>,
+				 <PINMUX_GPIO19__FUNC_GPIO19>,
+				 <PINMUX_GPIO20__FUNC_GPIO20>,
+				 <PINMUX_GPIO21__FUNC_GPIO21>,
+				 <PINMUX_GPIO22__FUNC_GPIO22>,
+				 <PINMUX_GPIO23__FUNC_GPIO23>,
+				 <PINMUX_GPIO24__FUNC_GPIO24>,
+				 <PINMUX_GPIO25__FUNC_GPIO25>,
+				 <PINMUX_GPIO26__FUNC_GPIO26>,
+				 <PINMUX_GPIO27__FUNC_GPIO27>,
+				 <PINMUX_GPIO28__FUNC_GPIO28>;
+		};
+	};
 };
 
 &pmic {
@@ -412,6 +522,15 @@ &scp {
 	status = "okay";
 };
 
-&dsi0 {
-	status = "disabled";
+&dpi0 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&dpi_func_pins>;
+	pinctrl-1 = <&dpi_idle_pins>;
+	status = "okay";
+
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&it66121_in>;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 5cb6bd3c5acb..92c41463d10e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1835,6 +1835,7 @@ dsi0: dsi@14014000 {
 			resets = <&mmsys MT8183_MMSYS_SW0_RST_B_DISP_DSI0>;
 			phys = <&mipi_tx0>;
 			phy-names = "dphy";
+			status = "disabled";
 		};
 
 		dpi0: dpi@14015000 {
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index ae398acdcf45..0905668cbe1f 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -226,7 +226,6 @@ &uart0 {
 };
 
 &uart5 {
-	pinctrl-0 = <&uart5_xfer>;
 	rts-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index b7163ed74232..f743aaf78359 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -373,6 +373,12 @@ &u2phy_host {
 	status = "okay";
 };
 
+&uart5 {
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
+	pinctrl-0 = <&uart5_xfer>;
+};
+
 /* Mule UCAN */
 &usb_host0_ehci {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
index 4237f2ee8fee..f57d4acd9807 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
@@ -15,9 +15,11 @@ / {
 };
 
 &gmac2io {
+	/delete-property/ tx_delay;
+	/delete-property/ rx_delay;
+
 	phy-handle = <&yt8531c>;
-	tx_delay = <0x19>;
-	rx_delay = <0x05>;
+	phy-mode = "rgmii-id";
 
 	mdio {
 		/delete-node/ ethernet-phy@1;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index fc67585b64b7..83e7e0fbe783 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -549,10 +549,10 @@ usb_host2_xhci: usb@fcd00000 {
 	mmu600_pcie: iommu@fc900000 {
 		compatible = "arm,smmu-v3";
 		reg = <0x0 0xfc900000 0x0 0x200000>;
-		interrupts = <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupts = <GIC_SPI 369 IRQ_TYPE_EDGE_RISING 0>,
+			     <GIC_SPI 371 IRQ_TYPE_EDGE_RISING 0>,
+			     <GIC_SPI 374 IRQ_TYPE_EDGE_RISING 0>,
+			     <GIC_SPI 367 IRQ_TYPE_EDGE_RISING 0>;
 		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
 		#iommu-cells = <1>;
 		status = "disabled";
@@ -561,10 +561,10 @@ mmu600_pcie: iommu@fc900000 {
 	mmu600_php: iommu@fcb00000 {
 		compatible = "arm,smmu-v3";
 		reg = <0x0 0xfcb00000 0x0 0x200000>;
-		interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupts = <GIC_SPI 381 IRQ_TYPE_EDGE_RISING 0>,
+			     <GIC_SPI 383 IRQ_TYPE_EDGE_RISING 0>,
+			     <GIC_SPI 386 IRQ_TYPE_EDGE_RISING 0>,
+			     <GIC_SPI 379 IRQ_TYPE_EDGE_RISING 0>;
 		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
 		#iommu-cells = <1>;
 		status = "disabled";
@@ -2626,9 +2626,9 @@ tsadc: tsadc@fec00000 {
 		rockchip,hw-tshut-temp = <120000>;
 		rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
 		rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
-		pinctrl-0 = <&tsadc_gpio_func>;
-		pinctrl-1 = <&tsadc_shut>;
-		pinctrl-names = "gpio", "otpout";
+		pinctrl-0 = <&tsadc_shut_org>;
+		pinctrl-1 = <&tsadc_gpio_func>;
+		pinctrl-names = "default", "sleep";
 		#thermal-sensor-cells = <1>;
 		status = "disabled";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
index 6418286efe40..762d36ad733a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
@@ -101,7 +101,7 @@ vcc3v3_lcd: vcc3v3-lcd-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_lcd";
 		enable-active-high;
-		gpio = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcdpwr_en>;
 		vin-supply = <&vcc3v3_sys>;
@@ -207,7 +207,7 @@ &pcie3x4 {
 &pinctrl {
 	lcd {
 		lcdpwr_en: lcdpwr-en {
-			rockchip,pins = <1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
+			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
 		};
 
 		bl_en: bl-en {
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 798d965760d4..5a280ac7570c 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -41,9 +41,12 @@ static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
 	 * backed by tags-capable memory. The vm_flags may be overridden by a
 	 * filesystem supporting MTE (RAM-based).
 	 */
-	if (system_supports_mte() &&
-	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
-		return VM_MTE_ALLOWED;
+	if (system_supports_mte()) {
+		if ((flags & MAP_ANONYMOUS) && !(flags & MAP_HUGETLB))
+			return VM_MTE_ALLOWED;
+		if (shmem_file(file))
+			return VM_MTE_ALLOWED;
+	}
 
 	return 0;
 }
diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index c3efacab4b94..aa90a048f319 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -77,9 +77,17 @@
 /*
  * With 4K page size the real_pte machinery is all nops.
  */
-#define __real_pte(e, p, o)		((real_pte_t){(e)})
+static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep, int offset)
+{
+	return (real_pte_t){pte};
+}
+
 #define __rpte_to_pte(r)	((r).pte)
-#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> H_PAGE_F_GIX_SHIFT)
+
+static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
+{
+	return pte_val(__rpte_to_pte(rpte)) >> H_PAGE_F_GIX_SHIFT;
+}
 
 #define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
 	do {							         \
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index acdab294b340..c1d9b031f0d5 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -108,7 +108,7 @@ static int text_area_cpu_up(unsigned int cpu)
 	unsigned long addr;
 	int err;
 
-	area = get_vm_area(PAGE_SIZE, VM_ALLOC);
+	area = get_vm_area(PAGE_SIZE, 0);
 	if (!area) {
 		WARN_ONCE(1, "Failed to create text area for cpu %d\n",
 			cpu);
@@ -493,7 +493,9 @@ static int __do_patch_instructions_mm(u32 *addr, u32 *code, size_t len, bool rep
 
 	orig_mm = start_using_temp_mm(patching_mm);
 
+	kasan_disable_current();
 	err = __patch_instructions(patch_addr, code, len, repeat_instr);
+	kasan_enable_current();
 
 	/* context synchronisation performed by __patch_instructions */
 	stop_using_temp_mm(patching_mm, orig_mm);
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index c2ee0745f59e..7b69be63d5d2 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -75,7 +75,7 @@ static int cmma_test_essa(void)
 		: [reg1] "=&d" (reg1),
 		  [reg2] "=&a" (reg2),
 		  [rc] "+&d" (rc),
-		  [tmp] "=&d" (tmp),
+		  [tmp] "+&d" (tmp),
 		  "+Q" (get_lowcore()->program_new_psw),
 		  "=Q" (old)
 		: [psw_old] "a" (&old),
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f5bf400f6a28..9ec3170c18f9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -397,34 +397,28 @@ static struct event_constraint intel_lnc_event_constraints[] = {
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FETCH_LAT, 6),
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_MEM_BOUND, 7),
 
+	INTEL_EVENT_CONSTRAINT(0x20, 0xf),
+
+	INTEL_UEVENT_CONSTRAINT(0x012a, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x012b, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x0148, 0x4),
 	INTEL_UEVENT_CONSTRAINT(0x0175, 0x4),
 
 	INTEL_EVENT_CONSTRAINT(0x2e, 0x3ff),
 	INTEL_EVENT_CONSTRAINT(0x3c, 0x3ff),
-	/*
-	 * Generally event codes < 0x90 are restricted to counters 0-3.
-	 * The 0x2E and 0x3C are exception, which has no restriction.
-	 */
-	INTEL_EVENT_CONSTRAINT_RANGE(0x01, 0x8f, 0xf),
 
-	INTEL_UEVENT_CONSTRAINT(0x01a3, 0xf),
-	INTEL_UEVENT_CONSTRAINT(0x02a3, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x08a3, 0x4),
 	INTEL_UEVENT_CONSTRAINT(0x0ca3, 0x4),
 	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
 	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
 	INTEL_UEVENT_CONSTRAINT(0x10a4, 0x1),
 	INTEL_UEVENT_CONSTRAINT(0x01b1, 0x8),
+	INTEL_UEVENT_CONSTRAINT(0x01cd, 0x3fc),
 	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x3),
-	INTEL_EVENT_CONSTRAINT(0xce, 0x1),
 
 	INTEL_EVENT_CONSTRAINT_RANGE(0xd0, 0xdf, 0xf),
-	/*
-	 * Generally event codes >= 0x90 are likely to have no restrictions.
-	 * The exception are defined as above.
-	 */
-	INTEL_EVENT_CONSTRAINT_RANGE(0x90, 0xfe, 0x3ff),
+
+	INTEL_UEVENT_CONSTRAINT(0x00e0, 0xf),
 
 	EVENT_CONSTRAINT_END
 };
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b6303b022453..c07ca43e67e7 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1178,7 +1178,7 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
 
-	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0x3ff),
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0x3fc),
 	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 375bbb9600d3..1a8148dec4af 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -816,6 +816,17 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 	}
 }
 
+void kvm_apic_update_hwapic_isr(struct kvm_vcpu *vcpu)
+{
+	struct kvm_lapic *apic = vcpu->arch.apic;
+
+	if (WARN_ON_ONCE(!lapic_in_kernel(vcpu)) || !apic->apicv_active)
+		return;
+
+	kvm_x86_call(hwapic_isr_update)(vcpu, apic_find_highest_isr(apic));
+}
+EXPORT_SYMBOL_GPL(kvm_apic_update_hwapic_isr);
+
 int kvm_lapic_find_highest_irr(struct kvm_vcpu *vcpu)
 {
 	/* This may race with setting of irr in __apic_accept_irq() and
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 1b8ef9856422..3aa599db7796 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -117,11 +117,10 @@ bool kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *src,
 		struct kvm_lapic_irq *irq, int *r, struct dest_map *dest_map);
 void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high);
 
-u64 kvm_get_apic_base(struct kvm_vcpu *vcpu);
 int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
 int kvm_apic_get_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
 int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
-enum lapic_mode kvm_get_apic_mode(struct kvm_vcpu *vcpu);
+void kvm_apic_update_hwapic_isr(struct kvm_vcpu *vcpu);
 int kvm_lapic_find_highest_irr(struct kvm_vcpu *vcpu);
 
 u64 kvm_get_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu);
@@ -271,6 +270,11 @@ static inline enum lapic_mode kvm_apic_mode(u64 apic_base)
 	return apic_base & (MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE);
 }
 
+static inline enum lapic_mode kvm_get_apic_mode(struct kvm_vcpu *vcpu)
+{
+	return kvm_apic_mode(vcpu->arch.apic_base);
+}
+
 static inline u8 kvm_xapic_id(struct kvm_lapic *apic)
 {
 	return kvm_lapic_get_reg(apic, APIC_ID) >> 24;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 931a7361c30f..22bee8a71144 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5043,6 +5043,11 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
 	}
 
+	if (vmx->nested.update_vmcs01_hwapic_isr) {
+		vmx->nested.update_vmcs01_hwapic_isr = false;
+		kvm_apic_update_hwapic_isr(vcpu);
+	}
+
 	if ((vm_exit_reason != -1) &&
 	    (enable_shadow_vmcs || nested_vmx_is_evmptr12_valid(vmx)))
 		vmx->nested.need_vmcs12_to_shadow_sync = true;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f06d443ec3c6..1af30e3472cd 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6858,6 +6858,27 @@ void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
 	u16 status;
 	u8 old;
 
+	/*
+	 * If L2 is active, defer the SVI update until vmcs01 is loaded, as SVI
+	 * is only relevant for if and only if Virtual Interrupt Delivery is
+	 * enabled in vmcs12, and if VID is enabled then L2 EOIs affect L2's
+	 * vAPIC, not L1's vAPIC.  KVM must update vmcs01 on the next nested
+	 * VM-Exit, otherwise L1 with run with a stale SVI.
+	 */
+	if (is_guest_mode(vcpu)) {
+		/*
+		 * KVM is supposed to forward intercepted L2 EOIs to L1 if VID
+		 * is enabled in vmcs12; as above, the EOIs affect L2's vAPIC.
+		 * Note, userspace can stuff state while L2 is active; assert
+		 * that VID is disabled if and only if the vCPU is in KVM_RUN
+		 * to avoid false positives if userspace is setting APIC state.
+		 */
+		WARN_ON_ONCE(vcpu->wants_to_run &&
+			     nested_cpu_has_vid(get_vmcs12(vcpu)));
+		to_vmx(vcpu)->nested.update_vmcs01_hwapic_isr = true;
+		return;
+	}
+
 	if (max_isr == -1)
 		max_isr = 0;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 2325f773a20b..41bf59bbc642 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -176,6 +176,7 @@ struct nested_vmx {
 	bool reload_vmcs01_apic_access_page;
 	bool update_vmcs01_cpu_dirty_logging;
 	bool update_vmcs01_apicv_status;
+	bool update_vmcs01_hwapic_isr;
 
 	/*
 	 * Enlightened VMCS has been enabled. It does not mean that L1 has to
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0846e3af5f6c..b67a2f46e40b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -667,17 +667,6 @@ static void drop_user_return_notifiers(void)
 		kvm_on_user_return(&msrs->urn);
 }
 
-u64 kvm_get_apic_base(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.apic_base;
-}
-
-enum lapic_mode kvm_get_apic_mode(struct kvm_vcpu *vcpu)
-{
-	return kvm_apic_mode(kvm_get_apic_base(vcpu));
-}
-EXPORT_SYMBOL_GPL(kvm_get_apic_mode);
-
 int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	enum lapic_mode old_mode = kvm_get_apic_mode(vcpu);
@@ -4314,7 +4303,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = 1 << 24;
 		break;
 	case MSR_IA32_APICBASE:
-		msr_info->data = kvm_get_apic_base(vcpu);
+		msr_info->data = vcpu->arch.apic_base;
 		break;
 	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
 		return kvm_x2apic_msr_read(vcpu, msr_info->index, &msr_info->data);
@@ -10159,7 +10148,7 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
 
 	kvm_run->if_flag = kvm_x86_call(get_if_flag)(vcpu);
 	kvm_run->cr8 = kvm_get_cr8(vcpu);
-	kvm_run->apic_base = kvm_get_apic_base(vcpu);
+	kvm_run->apic_base = vcpu->arch.apic_base;
 
 	kvm_run->ready_for_interrupt_injection =
 		pic_in_kernel(vcpu->kvm) ||
@@ -11718,7 +11707,7 @@ static void __get_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	sregs->cr4 = kvm_read_cr4(vcpu);
 	sregs->cr8 = kvm_get_cr8(vcpu);
 	sregs->efer = vcpu->arch.efer;
-	sregs->apic_base = kvm_get_apic_base(vcpu);
+	sregs->apic_base = vcpu->arch.apic_base;
 }
 
 static void __get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
diff --git a/drivers/accel/ivpu/Kconfig b/drivers/accel/ivpu/Kconfig
index 682c53245286..e4d418b44626 100644
--- a/drivers/accel/ivpu/Kconfig
+++ b/drivers/accel/ivpu/Kconfig
@@ -8,6 +8,7 @@ config DRM_ACCEL_IVPU
 	select FW_LOADER
 	select DRM_GEM_SHMEM_HELPER
 	select GENERIC_ALLOCATOR
+	select WANT_DEV_COREDUMP
 	help
 	  Choose this option if you have a system with an 14th generation
 	  Intel CPU (Meteor Lake) or newer. Intel NPU (formerly called Intel VPU)
diff --git a/drivers/accel/ivpu/Makefile b/drivers/accel/ivpu/Makefile
index ebd682a42eb1..232ea6d28c6e 100644
--- a/drivers/accel/ivpu/Makefile
+++ b/drivers/accel/ivpu/Makefile
@@ -19,5 +19,6 @@ intel_vpu-y := \
 	ivpu_sysfs.o
 
 intel_vpu-$(CONFIG_DEBUG_FS) += ivpu_debugfs.o
+intel_vpu-$(CONFIG_DEV_COREDUMP) += ivpu_coredump.o
 
 obj-$(CONFIG_DRM_ACCEL_IVPU) += intel_vpu.o
diff --git a/drivers/accel/ivpu/ivpu_coredump.c b/drivers/accel/ivpu/ivpu_coredump.c
new file mode 100644
index 000000000000..16ad0c30818c
--- /dev/null
+++ b/drivers/accel/ivpu/ivpu_coredump.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020-2024 Intel Corporation
+ */
+
+#include <linux/devcoredump.h>
+#include <linux/firmware.h>
+
+#include "ivpu_coredump.h"
+#include "ivpu_fw.h"
+#include "ivpu_gem.h"
+#include "vpu_boot_api.h"
+
+#define CRASH_DUMP_HEADER "Intel NPU crash dump"
+#define CRASH_DUMP_HEADERS_SIZE SZ_4K
+
+void ivpu_dev_coredump(struct ivpu_device *vdev)
+{
+	struct drm_print_iterator pi = {};
+	struct drm_printer p;
+	size_t coredump_size;
+	char *coredump;
+
+	coredump_size = CRASH_DUMP_HEADERS_SIZE + FW_VERSION_HEADER_SIZE +
+			ivpu_bo_size(vdev->fw->mem_log_crit) + ivpu_bo_size(vdev->fw->mem_log_verb);
+	coredump = vmalloc(coredump_size);
+	if (!coredump)
+		return;
+
+	pi.data = coredump;
+	pi.remain = coredump_size;
+	p = drm_coredump_printer(&pi);
+
+	drm_printf(&p, "%s\n", CRASH_DUMP_HEADER);
+	drm_printf(&p, "FW version: %s\n", vdev->fw->version);
+	ivpu_fw_log_print(vdev, false, &p);
+
+	dev_coredumpv(vdev->drm.dev, coredump, pi.offset, GFP_KERNEL);
+}
diff --git a/drivers/accel/ivpu/ivpu_coredump.h b/drivers/accel/ivpu/ivpu_coredump.h
new file mode 100644
index 000000000000..8efb09d02441
--- /dev/null
+++ b/drivers/accel/ivpu/ivpu_coredump.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020-2024 Intel Corporation
+ */
+
+#ifndef __IVPU_COREDUMP_H__
+#define __IVPU_COREDUMP_H__
+
+#include <drm/drm_print.h>
+
+#include "ivpu_drv.h"
+#include "ivpu_fw_log.h"
+
+#ifdef CONFIG_DEV_COREDUMP
+void ivpu_dev_coredump(struct ivpu_device *vdev);
+#else
+static inline void ivpu_dev_coredump(struct ivpu_device *vdev)
+{
+	struct drm_printer p = drm_info_printer(vdev->drm.dev);
+
+	ivpu_fw_log_print(vdev, false, &p);
+}
+#endif
+
+#endif /* __IVPU_COREDUMP_H__ */
diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index c91400ecf926..38b4158f5278 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -14,7 +14,7 @@
 #include <drm/drm_ioctl.h>
 #include <drm/drm_prime.h>
 
-#include "vpu_boot_api.h"
+#include "ivpu_coredump.h"
 #include "ivpu_debugfs.h"
 #include "ivpu_drv.h"
 #include "ivpu_fw.h"
@@ -29,6 +29,7 @@
 #include "ivpu_ms.h"
 #include "ivpu_pm.h"
 #include "ivpu_sysfs.h"
+#include "vpu_boot_api.h"
 
 #ifndef DRIVER_VERSION_STR
 #define DRIVER_VERSION_STR __stringify(DRM_IVPU_DRIVER_MAJOR) "." \
@@ -382,7 +383,7 @@ int ivpu_boot(struct ivpu_device *vdev)
 		ivpu_err(vdev, "Failed to boot the firmware: %d\n", ret);
 		ivpu_hw_diagnose_failure(vdev);
 		ivpu_mmu_evtq_dump(vdev);
-		ivpu_fw_log_dump(vdev);
+		ivpu_dev_coredump(vdev);
 		return ret;
 	}
 
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 63f13b697eed..2b30cc2e9272 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -152,6 +152,7 @@ struct ivpu_device {
 		int tdr;
 		int autosuspend;
 		int d0i3_entry_msg;
+		int state_dump_msg;
 	} timeout;
 };
 
diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index ede6165e09d9..b2b6d89f0653 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -25,7 +25,6 @@
 #define FW_SHAVE_NN_MAX_SIZE	SZ_2M
 #define FW_RUNTIME_MIN_ADDR	(FW_GLOBAL_MEM_START)
 #define FW_RUNTIME_MAX_ADDR	(FW_GLOBAL_MEM_END - FW_SHARED_MEM_SIZE)
-#define FW_VERSION_HEADER_SIZE	SZ_4K
 #define FW_FILE_IMAGE_OFFSET	(VPU_FW_HEADER_SIZE + FW_VERSION_HEADER_SIZE)
 
 #define WATCHDOG_MSS_REDIRECT	32
@@ -191,8 +190,10 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
 	ivpu_dbg(vdev, FW_BOOT, "Header version: 0x%x, format 0x%x\n",
 		 fw_hdr->header_version, fw_hdr->image_format);
 
-	ivpu_info(vdev, "Firmware: %s, version: %s", fw->name,
-		  (const char *)fw_hdr + VPU_FW_HEADER_SIZE);
+	if (!scnprintf(fw->version, sizeof(fw->version), "%s", fw->file->data + VPU_FW_HEADER_SIZE))
+		ivpu_warn(vdev, "Missing firmware version\n");
+
+	ivpu_info(vdev, "Firmware: %s, version: %s\n", fw->name, fw->version);
 
 	if (IVPU_FW_CHECK_API_COMPAT(vdev, fw_hdr, BOOT, 3))
 		return -EINVAL;
diff --git a/drivers/accel/ivpu/ivpu_fw.h b/drivers/accel/ivpu/ivpu_fw.h
index 40d9d17be3f5..5e8eb608b70f 100644
--- a/drivers/accel/ivpu/ivpu_fw.h
+++ b/drivers/accel/ivpu/ivpu_fw.h
@@ -1,11 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2020-2023 Intel Corporation
+ * Copyright (C) 2020-2024 Intel Corporation
  */
 
 #ifndef __IVPU_FW_H__
 #define __IVPU_FW_H__
 
+#define FW_VERSION_HEADER_SIZE	SZ_4K
+#define FW_VERSION_STR_SIZE	SZ_256
+
 struct ivpu_device;
 struct ivpu_bo;
 struct vpu_boot_params;
@@ -13,6 +16,7 @@ struct vpu_boot_params;
 struct ivpu_fw_info {
 	const struct firmware *file;
 	const char *name;
+	char version[FW_VERSION_STR_SIZE];
 	struct ivpu_bo *mem;
 	struct ivpu_bo *mem_shave_nn;
 	struct ivpu_bo *mem_log_crit;
diff --git a/drivers/accel/ivpu/ivpu_fw_log.h b/drivers/accel/ivpu/ivpu_fw_log.h
index 0b2573f6f315..4b390a99699d 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.h
+++ b/drivers/accel/ivpu/ivpu_fw_log.h
@@ -8,8 +8,6 @@
 
 #include <linux/types.h>
 
-#include <drm/drm_print.h>
-
 #include "ivpu_drv.h"
 
 #define IVPU_FW_LOG_DEFAULT 0
@@ -28,11 +26,5 @@ extern unsigned int ivpu_log_level;
 void ivpu_fw_log_print(struct ivpu_device *vdev, bool only_new_msgs, struct drm_printer *p);
 void ivpu_fw_log_clear(struct ivpu_device *vdev);
 
-static inline void ivpu_fw_log_dump(struct ivpu_device *vdev)
-{
-	struct drm_printer p = drm_info_printer(vdev->drm.dev);
-
-	ivpu_fw_log_print(vdev, false, &p);
-}
 
 #endif /* __IVPU_FW_LOG_H__ */
diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
index e69c0613513f..08b3cef58fd2 100644
--- a/drivers/accel/ivpu/ivpu_hw.c
+++ b/drivers/accel/ivpu/ivpu_hw.c
@@ -89,12 +89,14 @@ static void timeouts_init(struct ivpu_device *vdev)
 		vdev->timeout.tdr = 2000000;
 		vdev->timeout.autosuspend = -1;
 		vdev->timeout.d0i3_entry_msg = 500;
+		vdev->timeout.state_dump_msg = 10;
 	} else if (ivpu_is_simics(vdev)) {
 		vdev->timeout.boot = 50;
 		vdev->timeout.jsm = 500;
 		vdev->timeout.tdr = 10000;
 		vdev->timeout.autosuspend = -1;
 		vdev->timeout.d0i3_entry_msg = 100;
+		vdev->timeout.state_dump_msg = 10;
 	} else {
 		vdev->timeout.boot = 1000;
 		vdev->timeout.jsm = 500;
@@ -104,6 +106,7 @@ static void timeouts_init(struct ivpu_device *vdev)
 		else
 			vdev->timeout.autosuspend = 100;
 		vdev->timeout.d0i3_entry_msg = 5;
+		vdev->timeout.state_dump_msg = 10;
 	}
 }
 
diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 29b723039a34..13c8a12162e8 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -353,6 +353,32 @@ int ivpu_ipc_send_receive(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
 	return ret;
 }
 
+int ivpu_ipc_send_and_wait(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
+			   u32 channel, unsigned long timeout_ms)
+{
+	struct ivpu_ipc_consumer cons;
+	int ret;
+
+	ret = ivpu_rpm_get(vdev);
+	if (ret < 0)
+		return ret;
+
+	ivpu_ipc_consumer_add(vdev, &cons, channel, NULL);
+
+	ret = ivpu_ipc_send(vdev, &cons, req);
+	if (ret) {
+		ivpu_warn_ratelimited(vdev, "IPC send failed: %d\n", ret);
+		goto consumer_del;
+	}
+
+	msleep(timeout_ms);
+
+consumer_del:
+	ivpu_ipc_consumer_del(vdev, &cons);
+	ivpu_rpm_put(vdev);
+	return ret;
+}
+
 static bool
 ivpu_ipc_match_consumer(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 			struct ivpu_ipc_hdr *ipc_hdr, struct vpu_jsm_msg *jsm_msg)
diff --git a/drivers/accel/ivpu/ivpu_ipc.h b/drivers/accel/ivpu/ivpu_ipc.h
index fb4de7fb8210..b4dfb504679b 100644
--- a/drivers/accel/ivpu/ivpu_ipc.h
+++ b/drivers/accel/ivpu/ivpu_ipc.h
@@ -107,5 +107,7 @@ int ivpu_ipc_send_receive_internal(struct ivpu_device *vdev, struct vpu_jsm_msg
 int ivpu_ipc_send_receive(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
 			  enum vpu_ipc_msg_type expected_resp, struct vpu_jsm_msg *resp,
 			  u32 channel, unsigned long timeout_ms);
+int ivpu_ipc_send_and_wait(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
+			   u32 channel, unsigned long timeout_ms);
 
 #endif /* __IVPU_IPC_H__ */
diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.c b/drivers/accel/ivpu/ivpu_jsm_msg.c
index 88105963c1b2..f7618b605f02 100644
--- a/drivers/accel/ivpu/ivpu_jsm_msg.c
+++ b/drivers/accel/ivpu/ivpu_jsm_msg.c
@@ -555,3 +555,11 @@ int ivpu_jsm_dct_disable(struct ivpu_device *vdev)
 	return ivpu_ipc_send_receive_internal(vdev, &req, VPU_JSM_MSG_DCT_DISABLE_DONE, &resp,
 					      VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
 }
+
+int ivpu_jsm_state_dump(struct ivpu_device *vdev)
+{
+	struct vpu_jsm_msg req = { .type = VPU_JSM_MSG_STATE_DUMP };
+
+	return ivpu_ipc_send_and_wait(vdev, &req, VPU_IPC_CHAN_ASYNC_CMD,
+				      vdev->timeout.state_dump_msg);
+}
diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.h b/drivers/accel/ivpu/ivpu_jsm_msg.h
index e4e42c0ff6e6..9e84d3526a14 100644
--- a/drivers/accel/ivpu/ivpu_jsm_msg.h
+++ b/drivers/accel/ivpu/ivpu_jsm_msg.h
@@ -43,4 +43,6 @@ int ivpu_jsm_metric_streamer_info(struct ivpu_device *vdev, u64 metric_group_mas
 				  u64 buffer_size, u32 *sample_size, u64 *info_size);
 int ivpu_jsm_dct_enable(struct ivpu_device *vdev, u32 active_us, u32 inactive_us);
 int ivpu_jsm_dct_disable(struct ivpu_device *vdev);
+int ivpu_jsm_state_dump(struct ivpu_device *vdev);
+
 #endif
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index ef9a4ba18cb8..fbb61a2c3b19 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -9,17 +9,18 @@
 #include <linux/pm_runtime.h>
 #include <linux/reboot.h>
 
-#include "vpu_boot_api.h"
+#include "ivpu_coredump.h"
 #include "ivpu_drv.h"
-#include "ivpu_hw.h"
 #include "ivpu_fw.h"
 #include "ivpu_fw_log.h"
+#include "ivpu_hw.h"
 #include "ivpu_ipc.h"
 #include "ivpu_job.h"
 #include "ivpu_jsm_msg.h"
 #include "ivpu_mmu.h"
 #include "ivpu_ms.h"
 #include "ivpu_pm.h"
+#include "vpu_boot_api.h"
 
 static bool ivpu_disable_recovery;
 module_param_named_unsafe(disable_recovery, ivpu_disable_recovery, bool, 0644);
@@ -110,40 +111,57 @@ static int ivpu_resume(struct ivpu_device *vdev)
 	return ret;
 }
 
-static void ivpu_pm_recovery_work(struct work_struct *work)
+static void ivpu_pm_reset_begin(struct ivpu_device *vdev)
 {
-	struct ivpu_pm_info *pm = container_of(work, struct ivpu_pm_info, recovery_work);
-	struct ivpu_device *vdev = pm->vdev;
-	char *evt[2] = {"IVPU_PM_EVENT=IVPU_RECOVER", NULL};
-	int ret;
-
-	ivpu_err(vdev, "Recovering the NPU (reset #%d)\n", atomic_read(&vdev->pm->reset_counter));
-
-	ret = pm_runtime_resume_and_get(vdev->drm.dev);
-	if (ret)
-		ivpu_err(vdev, "Failed to resume NPU: %d\n", ret);
-
-	ivpu_fw_log_dump(vdev);
+	pm_runtime_disable(vdev->drm.dev);
 
 	atomic_inc(&vdev->pm->reset_counter);
 	atomic_set(&vdev->pm->reset_pending, 1);
 	down_write(&vdev->pm->reset_lock);
+}
+
+static void ivpu_pm_reset_complete(struct ivpu_device *vdev)
+{
+	int ret;
 
-	ivpu_suspend(vdev);
 	ivpu_pm_prepare_cold_boot(vdev);
 	ivpu_jobs_abort_all(vdev);
 	ivpu_ms_cleanup_all(vdev);
 
 	ret = ivpu_resume(vdev);
-	if (ret)
+	if (ret) {
 		ivpu_err(vdev, "Failed to resume NPU: %d\n", ret);
+		pm_runtime_set_suspended(vdev->drm.dev);
+	} else {
+		pm_runtime_set_active(vdev->drm.dev);
+	}
 
 	up_write(&vdev->pm->reset_lock);
 	atomic_set(&vdev->pm->reset_pending, 0);
 
-	kobject_uevent_env(&vdev->drm.dev->kobj, KOBJ_CHANGE, evt);
 	pm_runtime_mark_last_busy(vdev->drm.dev);
-	pm_runtime_put_autosuspend(vdev->drm.dev);
+	pm_runtime_enable(vdev->drm.dev);
+}
+
+static void ivpu_pm_recovery_work(struct work_struct *work)
+{
+	struct ivpu_pm_info *pm = container_of(work, struct ivpu_pm_info, recovery_work);
+	struct ivpu_device *vdev = pm->vdev;
+	char *evt[2] = {"IVPU_PM_EVENT=IVPU_RECOVER", NULL};
+
+	ivpu_err(vdev, "Recovering the NPU (reset #%d)\n", atomic_read(&vdev->pm->reset_counter));
+
+	ivpu_pm_reset_begin(vdev);
+
+	if (!pm_runtime_status_suspended(vdev->drm.dev)) {
+		ivpu_jsm_state_dump(vdev);
+		ivpu_dev_coredump(vdev);
+		ivpu_suspend(vdev);
+	}
+
+	ivpu_pm_reset_complete(vdev);
+
+	kobject_uevent_env(&vdev->drm.dev->kobj, KOBJ_CHANGE, evt);
 }
 
 void ivpu_pm_trigger_recovery(struct ivpu_device *vdev, const char *reason)
@@ -262,7 +280,7 @@ int ivpu_pm_runtime_suspend_cb(struct device *dev)
 	if (!is_idle || ret_d0i3) {
 		ivpu_err(vdev, "Forcing cold boot due to previous errors\n");
 		atomic_inc(&vdev->pm->reset_counter);
-		ivpu_fw_log_dump(vdev);
+		ivpu_dev_coredump(vdev);
 		ivpu_pm_prepare_cold_boot(vdev);
 	} else {
 		ivpu_pm_prepare_warm_boot(vdev);
@@ -314,16 +332,13 @@ void ivpu_pm_reset_prepare_cb(struct pci_dev *pdev)
 	struct ivpu_device *vdev = pci_get_drvdata(pdev);
 
 	ivpu_dbg(vdev, PM, "Pre-reset..\n");
-	atomic_inc(&vdev->pm->reset_counter);
-	atomic_set(&vdev->pm->reset_pending, 1);
 
-	pm_runtime_get_sync(vdev->drm.dev);
-	down_write(&vdev->pm->reset_lock);
-	ivpu_prepare_for_reset(vdev);
-	ivpu_hw_reset(vdev);
-	ivpu_pm_prepare_cold_boot(vdev);
-	ivpu_jobs_abort_all(vdev);
-	ivpu_ms_cleanup_all(vdev);
+	ivpu_pm_reset_begin(vdev);
+
+	if (!pm_runtime_status_suspended(vdev->drm.dev)) {
+		ivpu_prepare_for_reset(vdev);
+		ivpu_hw_reset(vdev);
+	}
 
 	ivpu_dbg(vdev, PM, "Pre-reset done.\n");
 }
@@ -331,18 +346,12 @@ void ivpu_pm_reset_prepare_cb(struct pci_dev *pdev)
 void ivpu_pm_reset_done_cb(struct pci_dev *pdev)
 {
 	struct ivpu_device *vdev = pci_get_drvdata(pdev);
-	int ret;
 
 	ivpu_dbg(vdev, PM, "Post-reset..\n");
-	ret = ivpu_resume(vdev);
-	if (ret)
-		ivpu_err(vdev, "Failed to set RESUME state: %d\n", ret);
-	up_write(&vdev->pm->reset_lock);
-	atomic_set(&vdev->pm->reset_pending, 0);
-	ivpu_dbg(vdev, PM, "Post-reset done.\n");
 
-	pm_runtime_mark_last_busy(vdev->drm.dev);
-	pm_runtime_put_autosuspend(vdev->drm.dev);
+	ivpu_pm_reset_complete(vdev);
+
+	ivpu_dbg(vdev, PM, "Post-reset done.\n");
 }
 
 void ivpu_pm_init(struct ivpu_device *vdev)
diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dfbbac92242a..04d02c746ec0 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -272,6 +272,39 @@ int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
 
+static bool qca_filename_has_extension(const char *filename)
+{
+	const char *suffix = strrchr(filename, '.');
+
+	/* File extensions require a dot, but not as the first or last character */
+	if (!suffix || suffix == filename || *(suffix + 1) == '\0')
+		return 0;
+
+	/* Avoid matching directories with names that look like files with extensions */
+	return !strchr(suffix, '/');
+}
+
+static bool qca_get_alt_nvm_file(char *filename, size_t max_size)
+{
+	char fwname[64];
+	const char *suffix;
+
+	/* nvm file name has an extension, replace with .bin */
+	if (qca_filename_has_extension(filename)) {
+		suffix = strrchr(filename, '.');
+		strscpy(fwname, filename, suffix - filename + 1);
+		snprintf(fwname + (suffix - filename),
+		       sizeof(fwname) - (suffix - filename), ".bin");
+		/* If nvm file is already the default one, return false to skip the retry. */
+		if (strcmp(fwname, filename) == 0)
+			return false;
+
+		snprintf(filename, max_size, "%s", fwname);
+		return true;
+	}
+	return false;
+}
+
 static int qca_tlv_check_data(struct hci_dev *hdev,
 			       struct qca_fw_config *config,
 			       u8 *fw_data, size_t fw_size,
@@ -564,6 +597,19 @@ static int qca_download_firmware(struct hci_dev *hdev,
 					   config->fwname, ret);
 				return ret;
 			}
+		}
+		/* If the board-specific file is missing, try loading the default
+		 * one, unless that was attempted already.
+		 */
+		else if (config->type == TLV_TYPE_NVM &&
+			 qca_get_alt_nvm_file(config->fwname, sizeof(config->fwname))) {
+			bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
+			ret = request_firmware(&fw, config->fwname, &hdev->dev);
+			if (ret) {
+				bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
+					   config->fwname, ret);
+				return ret;
+			}
 		} else {
 			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
 				   config->fwname, ret);
@@ -700,34 +746,38 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	return 0;
 }
 
-static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
+static void qca_get_nvm_name_by_board(char *fwname, size_t max_size,
+		const char *stem, enum qca_btsoc_type soc_type,
 		struct qca_btsoc_version ver, u8 rom_ver, u16 bid)
 {
 	const char *variant;
+	const char *prefix;
 
-	/* hsp gf chip */
-	if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
-		variant = "g";
-	else
-		variant = "";
+	/* Set the default value to variant and prefix */
+	variant = "";
+	prefix = "b";
 
-	if (bid == 0x0)
-		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
-	else
-		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
-}
+	if (soc_type == QCA_QCA2066)
+		prefix = "";
 
-static inline void qca_get_nvm_name_generic(struct qca_fw_config *cfg,
-					    const char *stem, u8 rom_ver, u16 bid)
-{
-	if (bid == 0x0)
-		snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/%snv%02x.bin", stem, rom_ver);
-	else if (bid & 0xff00)
-		snprintf(cfg->fwname, sizeof(cfg->fwname),
-			 "qca/%snv%02x.b%x", stem, rom_ver, bid);
-	else
-		snprintf(cfg->fwname, sizeof(cfg->fwname),
-			 "qca/%snv%02x.b%02x", stem, rom_ver, bid);
+	if (soc_type == QCA_WCN6855 || soc_type == QCA_QCA2066) {
+		/* If the chip is manufactured by GlobalFoundries */
+		if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
+			variant = "g";
+	}
+
+	if (rom_ver != 0) {
+		if (bid == 0x0 || bid == 0xffff)
+			snprintf(fwname, max_size, "qca/%s%02x%s.bin", stem, rom_ver, variant);
+		else
+			snprintf(fwname, max_size, "qca/%s%02x%s.%s%02x", stem, rom_ver,
+						variant, prefix, bid);
+	} else {
+		if (bid == 0x0 || bid == 0xffff)
+			snprintf(fwname, max_size, "qca/%s%s.bin", stem, variant);
+		else
+			snprintf(fwname, max_size, "qca/%s%s.%s%02x", stem, variant, prefix, bid);
+	}
 }
 
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
@@ -816,8 +866,14 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
 	if (firmware_name) {
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/%s", firmware_name);
+		/* The firmware name has an extension, use it directly */
+		if (qca_filename_has_extension(firmware_name)) {
+			snprintf(config.fwname, sizeof(config.fwname), "qca/%s", firmware_name);
+		} else {
+			qca_read_fw_board_id(hdev, &boardid);
+			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
+				 firmware_name, soc_type, ver, 0, boardid);
+		}
 	} else {
 		switch (soc_type) {
 		case QCA_WCN3990:
@@ -836,8 +892,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 				 "qca/apnv%02x.bin", rom_ver);
 			break;
 		case QCA_QCA2066:
-			qca_generate_hsp_nvm_name(config.fwname,
-				sizeof(config.fwname), ver, rom_ver, boardid);
+			qca_get_nvm_name_by_board(config.fwname,
+				sizeof(config.fwname), "hpnv", soc_type, ver,
+				rom_ver, boardid);
 			break;
 		case QCA_QCA6390:
 			snprintf(config.fwname, sizeof(config.fwname),
@@ -848,13 +905,14 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 				 "qca/msnv%02x.bin", rom_ver);
 			break;
 		case QCA_WCN6855:
-			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/hpnv%02x.bin", rom_ver);
+			qca_read_fw_board_id(hdev, &boardid);
+			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
+						  "hpnv", soc_type, ver, rom_ver, boardid);
 			break;
 		case QCA_WCN7850:
-			qca_get_nvm_name_generic(&config, "hmt", rom_ver, boardid);
+			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
+				 "hmtnv", soc_type, ver, rom_ver, boardid);
 			break;
-
 		default:
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/nvm_%08x.bin", soc_ver);
diff --git a/drivers/clocksource/jcore-pit.c b/drivers/clocksource/jcore-pit.c
index a3fe98cd3838..82815428f8f9 100644
--- a/drivers/clocksource/jcore-pit.c
+++ b/drivers/clocksource/jcore-pit.c
@@ -114,6 +114,18 @@ static int jcore_pit_local_init(unsigned cpu)
 	pit->periodic_delta = DIV_ROUND_CLOSEST(NSEC_PER_SEC, HZ * buspd);
 
 	clockevents_config_and_register(&pit->ced, freq, 1, ULONG_MAX);
+	enable_percpu_irq(pit->ced.irq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int jcore_pit_local_teardown(unsigned cpu)
+{
+	struct jcore_pit *pit = this_cpu_ptr(jcore_pit_percpu);
+
+	pr_info("Local J-Core PIT teardown on cpu %u\n", cpu);
+
+	disable_percpu_irq(pit->ced.irq);
 
 	return 0;
 }
@@ -168,6 +180,7 @@ static int __init jcore_pit_init(struct device_node *node)
 		return -ENOMEM;
 	}
 
+	irq_set_percpu_devid(pit_irq);
 	err = request_percpu_irq(pit_irq, jcore_timer_interrupt,
 				 "jcore_pit", jcore_pit_percpu);
 	if (err) {
@@ -237,7 +250,7 @@ static int __init jcore_pit_init(struct device_node *node)
 
 	cpuhp_setup_state(CPUHP_AP_JCORE_TIMER_STARTING,
 			  "clockevents/jcore:starting",
-			  jcore_pit_local_init, NULL);
+			  jcore_pit_local_init, jcore_pit_local_teardown);
 
 	return 0;
 }
diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index a9a8ba067007..0fd7a777fe7d 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -95,7 +95,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
 	 * Configure interrupt enable registers such that Tag, Data RAM related
 	 * interrupts are propagated to interrupt controller for servicing
 	 */
-	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_0_enable,
 				 TRP0_INTERRUPT_ENABLE,
 				 TRP0_INTERRUPT_ENABLE);
 	if (ret)
@@ -113,7 +113,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_0_enable,
 				 DRP0_INTERRUPT_ENABLE,
 				 DRP0_INTERRUPT_ENABLE);
 	if (ret)
diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index a86ab9b35953..2641faa329cd 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -254,8 +254,8 @@ static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
 	if (num > max_num)
 		return -EINVAL;
 
-	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_SET, sizeof(*in),
-				      0, &t);
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_SET,
+				      sizeof(*in) + num * sizeof(__le32), 0, &t);
 	if (ret)
 		return ret;
 
diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 907cd149c40a..c964f4924359 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -25,6 +25,7 @@ config IMX_SCU
 
 config IMX_SCMI_MISC_DRV
 	tristate "IMX SCMI MISC Protocol driver"
+	depends on ARCH_MXC || COMPILE_TEST
 	default y if ARCH_MXC
 	help
 	  The System Controller Management Interface firmware (SCMI FW) is
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1e8f0bdb6ae3..209871c219d6 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3068,6 +3068,8 @@ static int gpiod_get_raw_value_commit(const struct gpio_desc *desc)
 static int gpio_chip_get_multiple(struct gpio_chip *gc,
 				  unsigned long *mask, unsigned long *bits)
 {
+	lockdep_assert_held(&gc->gpiodev->srcu);
+
 	if (gc->get_multiple)
 		return gc->get_multiple(gc, mask, bits);
 	if (gc->get) {
@@ -3098,6 +3100,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  struct gpio_array *array_info,
 				  unsigned long *value_bitmap)
 {
+	struct gpio_chip *gc;
 	int ret, i = 0;
 
 	/*
@@ -3109,10 +3112,15 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 	    array_size <= array_info->size &&
 	    (void *)array_info == desc_array + array_info->size) {
 		if (!can_sleep)
-			WARN_ON(array_info->chip->can_sleep);
+			WARN_ON(array_info->gdev->can_sleep);
+
+		guard(srcu)(&array_info->gdev->srcu);
+		gc = srcu_dereference(array_info->gdev->chip,
+				      &array_info->gdev->srcu);
+		if (!gc)
+			return -ENODEV;
 
-		ret = gpio_chip_get_multiple(array_info->chip,
-					     array_info->get_mask,
+		ret = gpio_chip_get_multiple(gc, array_info->get_mask,
 					     value_bitmap);
 		if (ret)
 			return ret;
@@ -3393,6 +3401,8 @@ static void gpiod_set_raw_value_commit(struct gpio_desc *desc, bool value)
 static void gpio_chip_set_multiple(struct gpio_chip *gc,
 				   unsigned long *mask, unsigned long *bits)
 {
+	lockdep_assert_held(&gc->gpiodev->srcu);
+
 	if (gc->set_multiple) {
 		gc->set_multiple(gc, mask, bits);
 	} else {
@@ -3410,6 +3420,7 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				  struct gpio_array *array_info,
 				  unsigned long *value_bitmap)
 {
+	struct gpio_chip *gc;
 	int i = 0;
 
 	/*
@@ -3421,14 +3432,19 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 	    array_size <= array_info->size &&
 	    (void *)array_info == desc_array + array_info->size) {
 		if (!can_sleep)
-			WARN_ON(array_info->chip->can_sleep);
+			WARN_ON(array_info->gdev->can_sleep);
+
+		guard(srcu)(&array_info->gdev->srcu);
+		gc = srcu_dereference(array_info->gdev->chip,
+				      &array_info->gdev->srcu);
+		if (!gc)
+			return -ENODEV;
 
 		if (!raw && !bitmap_empty(array_info->invert_mask, array_size))
 			bitmap_xor(value_bitmap, value_bitmap,
 				   array_info->invert_mask, array_size);
 
-		gpio_chip_set_multiple(array_info->chip, array_info->set_mask,
-				       value_bitmap);
+		gpio_chip_set_multiple(gc, array_info->set_mask, value_bitmap);
 
 		i = find_first_zero_bit(array_info->set_mask, array_size);
 		if (i == array_size)
@@ -4684,9 +4700,10 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 {
 	struct gpio_desc *desc;
 	struct gpio_descs *descs;
+	struct gpio_device *gdev;
 	struct gpio_array *array_info = NULL;
-	struct gpio_chip *gc;
 	int count, bitmap_size;
+	unsigned long dflags;
 	size_t descs_size;
 
 	count = gpiod_count(dev, con_id);
@@ -4707,7 +4724,7 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 
 		descs->desc[descs->ndescs] = desc;
 
-		gc = gpiod_to_chip(desc);
+		gdev = gpiod_to_gpio_device(desc);
 		/*
 		 * If pin hardware number of array member 0 is also 0, select
 		 * its chip as a candidate for fast bitmap processing path.
@@ -4715,8 +4732,8 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 		if (descs->ndescs == 0 && gpio_chip_hwgpio(desc) == 0) {
 			struct gpio_descs *array;
 
-			bitmap_size = BITS_TO_LONGS(gc->ngpio > count ?
-						    gc->ngpio : count);
+			bitmap_size = BITS_TO_LONGS(gdev->ngpio > count ?
+						    gdev->ngpio : count);
 
 			array = krealloc(descs, descs_size +
 					 struct_size(array_info, invert_mask, 3 * bitmap_size),
@@ -4736,7 +4753,7 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 
 			array_info->desc = descs->desc;
 			array_info->size = count;
-			array_info->chip = gc;
+			array_info->gdev = gdev;
 			bitmap_set(array_info->get_mask, descs->ndescs,
 				   count - descs->ndescs);
 			bitmap_set(array_info->set_mask, descs->ndescs,
@@ -4749,7 +4766,7 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 			continue;
 
 		/* Unmark array members which don't belong to the 'fast' chip */
-		if (array_info->chip != gc) {
+		if (array_info->gdev != gdev) {
 			__clear_bit(descs->ndescs, array_info->get_mask);
 			__clear_bit(descs->ndescs, array_info->set_mask);
 		}
@@ -4772,9 +4789,10 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 					    array_info->set_mask);
 			}
 		} else {
+			dflags = READ_ONCE(desc->flags);
 			/* Exclude open drain or open source from fast output */
-			if (gpiochip_line_is_open_drain(gc, descs->ndescs) ||
-			    gpiochip_line_is_open_source(gc, descs->ndescs))
+			if (test_bit(FLAG_OPEN_DRAIN, &dflags) ||
+			    test_bit(FLAG_OPEN_SOURCE, &dflags))
 				__clear_bit(descs->ndescs,
 					    array_info->set_mask);
 			/* Identify 'fast' pins which require invertion */
@@ -4786,7 +4804,7 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 	if (array_info)
 		dev_dbg(dev,
 			"GPIO array info: chip=%s, size=%d, get_mask=%lx, set_mask=%lx, invert_mask=%lx\n",
-			array_info->chip->label, array_info->size,
+			array_info->gdev->label, array_info->size,
 			*array_info->get_mask, *array_info->set_mask,
 			*array_info->invert_mask);
 	return descs;
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 067197d61d57..87ce3753500e 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -110,7 +110,7 @@ extern const char *const gpio_suffixes[];
  *
  * @desc:		Array of pointers to the GPIO descriptors
  * @size:		Number of elements in desc
- * @chip:		Parent GPIO chip
+ * @gdev:		Parent GPIO device
  * @get_mask:		Get mask used in fastpath
  * @set_mask:		Set mask used in fastpath
  * @invert_mask:	Invert mask used in fastpath
@@ -122,7 +122,7 @@ extern const char *const gpio_suffixes[];
 struct gpio_array {
 	struct gpio_desc	**desc;
 	unsigned int		size;
-	struct gpio_chip	*chip;
+	struct gpio_device	*gdev;
 	unsigned long		*get_mask;
 	unsigned long		*set_mask;
 	unsigned long		invert_mask[];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c27b4c36a7c0..32afcf948524 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -119,9 +119,10 @@
  * - 3.58.0 - Add GFX12 DCC support
  * - 3.59.0 - Cleared VRAM
  * - 3.60.0 - Add AMDGPU_TILING_GFX12_DCC_WRITE_COMPRESS_DISABLE (Vulkan requirement)
+ * - 3.61.0 - Contains fix for RV/PCO compute queues
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	60
+#define KMS_DRIVER_MINOR	61
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e2501c98e107..05d1ae2ef84b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7415,6 +7415,34 @@ static void gfx_v9_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
 }
 
+static void gfx_v9_0_ring_begin_use_compute(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	amdgpu_gfx_enforce_isolation_ring_begin_use(ring);
+
+	/* Raven and PCO APUs seem to have stability issues
+	 * with compute and gfxoff and gfx pg.  Disable gfx pg during
+	 * submission and allow again afterwards.
+	 */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 1, 0))
+		gfx_v9_0_set_powergating_state(adev, AMD_PG_STATE_UNGATE);
+}
+
+static void gfx_v9_0_ring_end_use_compute(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	/* Raven and PCO APUs seem to have stability issues
+	 * with compute and gfxoff and gfx pg.  Disable gfx pg during
+	 * submission and allow again afterwards.
+	 */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 1, 0))
+		gfx_v9_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+
+	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
+}
+
 static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.name = "gfx_v9_0",
 	.early_init = gfx_v9_0_early_init,
@@ -7591,8 +7619,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 	.reset = gfx_v9_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
-	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
-	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
+	.begin_use = gfx_v9_0_ring_begin_use_compute,
+	.end_use = gfx_v9_0_ring_end_use_compute,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 02f7ba8c93cd..7062f12b5b75 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4117,7 +4117,8 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x0000ffff, 0x8bfe7e7e,
 	0x8bea6a6a, 0xb97af804,
 	0xbe804ec2, 0xbf94fffe,
-	0xbe804a6c, 0xbfb10000,
+	0xbe804a6c, 0xbe804ec2,
+	0xbf94fffe, 0xbfb10000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 44772eec9ef4..96fbb16ceb21 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -34,41 +34,24 @@
  *   cpp -DASIC_FAMILY=CHIP_PLUM_BONITO cwsr_trap_handler_gfx10.asm -P -o gfx11.sp3
  *   sp3 gfx11.sp3 -hex gfx11.hex
  *
- * gfx12:
- *   cpp -DASIC_FAMILY=CHIP_GFX12 cwsr_trap_handler_gfx10.asm -P -o gfx12.sp3
- *   sp3 gfx12.sp3 -hex gfx12.hex
  */
 
 #define CHIP_NAVI10 26
 #define CHIP_SIENNA_CICHLID 30
 #define CHIP_PLUM_BONITO 36
-#define CHIP_GFX12 37
 
 #define NO_SQC_STORE (ASIC_FAMILY >= CHIP_SIENNA_CICHLID)
 #define HAVE_XNACK (ASIC_FAMILY < CHIP_SIENNA_CICHLID)
 #define HAVE_SENDMSG_RTN (ASIC_FAMILY >= CHIP_PLUM_BONITO)
 #define HAVE_BUFFER_LDS_LOAD (ASIC_FAMILY < CHIP_PLUM_BONITO)
-#define SW_SA_TRAP (ASIC_FAMILY >= CHIP_PLUM_BONITO && ASIC_FAMILY < CHIP_GFX12)
+#define SW_SA_TRAP (ASIC_FAMILY == CHIP_PLUM_BONITO)
 #define SAVE_AFTER_XNACK_ERROR (HAVE_XNACK && !NO_SQC_STORE) // workaround for TCP store failure after XNACK error when ALLOW_REPLAY=0, for debugger
 #define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost MODE.DEBUG_EN exception when SAVECTX raised
 
-#if ASIC_FAMILY < CHIP_GFX12
 #define S_COHERENCE glc:1
 #define V_COHERENCE slc:1 glc:1
 #define S_WAITCNT_0 s_waitcnt 0
-#else
-#define S_COHERENCE scope:SCOPE_SYS
-#define V_COHERENCE scope:SCOPE_SYS
-#define S_WAITCNT_0 s_wait_idle
-
-#define HW_REG_SHADER_FLAT_SCRATCH_LO HW_REG_WAVE_SCRATCH_BASE_LO
-#define HW_REG_SHADER_FLAT_SCRATCH_HI HW_REG_WAVE_SCRATCH_BASE_HI
-#define HW_REG_GPR_ALLOC HW_REG_WAVE_GPR_ALLOC
-#define HW_REG_LDS_ALLOC HW_REG_WAVE_LDS_ALLOC
-#define HW_REG_MODE HW_REG_WAVE_MODE
-#endif
 
-#if ASIC_FAMILY < CHIP_GFX12
 var SQ_WAVE_STATUS_SPI_PRIO_MASK		= 0x00000006
 var SQ_WAVE_STATUS_HALT_MASK			= 0x2000
 var SQ_WAVE_STATUS_ECC_ERR_MASK			= 0x20000
@@ -81,21 +64,6 @@ var S_STATUS_ALWAYS_CLEAR_MASK			= SQ_WAVE_STATUS_SPI_PRIO_MASK|SQ_WAVE_STATUS_E
 var S_STATUS_HALT_MASK				= SQ_WAVE_STATUS_HALT_MASK
 var S_SAVE_PC_HI_TRAP_ID_MASK			= 0x00FF0000
 var S_SAVE_PC_HI_HT_MASK			= 0x01000000
-#else
-var SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK	= 0x4
-var SQ_WAVE_STATE_PRIV_SCC_SHIFT		= 9
-var SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK		= 0xC00
-var SQ_WAVE_STATE_PRIV_HALT_MASK		= 0x4000
-var SQ_WAVE_STATE_PRIV_POISON_ERR_MASK		= 0x8000
-var SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT		= 15
-var SQ_WAVE_STATUS_WAVE64_SHIFT			= 29
-var SQ_WAVE_STATUS_WAVE64_SIZE			= 1
-var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 9
-var S_STATUS_HWREG				= HW_REG_WAVE_STATE_PRIV
-var S_STATUS_ALWAYS_CLEAR_MASK			= SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK|SQ_WAVE_STATE_PRIV_POISON_ERR_MASK
-var S_STATUS_HALT_MASK				= SQ_WAVE_STATE_PRIV_HALT_MASK
-var S_SAVE_PC_HI_TRAP_ID_MASK			= 0xF0000000
-#endif
 
 var SQ_WAVE_STATUS_NO_VGPRS_SHIFT		= 24
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT		= 12
@@ -110,7 +78,6 @@ var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT		= 8
 var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT		= 12
 #endif
 
-#if ASIC_FAMILY < CHIP_GFX12
 var SQ_WAVE_TRAPSTS_SAVECTX_MASK		= 0x400
 var SQ_WAVE_TRAPSTS_EXCP_MASK			= 0x1FF
 var SQ_WAVE_TRAPSTS_SAVECTX_SHIFT		= 10
@@ -161,39 +128,6 @@ var S_TRAPSTS_RESTORE_PART_3_SIZE		= 32 - S_TRAPSTS_RESTORE_PART_3_SHIFT
 var S_TRAPSTS_HWREG				= HW_REG_TRAPSTS
 var S_TRAPSTS_SAVE_CONTEXT_MASK			= SQ_WAVE_TRAPSTS_SAVECTX_MASK
 var S_TRAPSTS_SAVE_CONTEXT_SHIFT		= SQ_WAVE_TRAPSTS_SAVECTX_SHIFT
-#else
-var SQ_WAVE_EXCP_FLAG_PRIV_ADDR_WATCH_MASK	= 0xF
-var SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK	= 0x10
-var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT	= 5
-var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK	= 0x20
-var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK	= 0x40
-var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT	= 6
-var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK	= 0x80
-var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT	= 7
-var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	= 0x100
-var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT	= 8
-var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK	= 0x200
-var SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK	= 0x800
-var SQ_WAVE_TRAP_CTRL_ADDR_WATCH_MASK		= 0x80
-var SQ_WAVE_TRAP_CTRL_TRAP_AFTER_INST_MASK	= 0x200
-
-var S_TRAPSTS_HWREG				= HW_REG_WAVE_EXCP_FLAG_PRIV
-var S_TRAPSTS_SAVE_CONTEXT_MASK			= SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK
-var S_TRAPSTS_SAVE_CONTEXT_SHIFT		= SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT
-var S_TRAPSTS_NON_MASKABLE_EXCP_MASK		= SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK		|\
-						  SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK	|\
-						  SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK		|\
-						  SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	|\
-						  SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK		|\
-						  SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK
-var S_TRAPSTS_RESTORE_PART_1_SIZE		= SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT
-var S_TRAPSTS_RESTORE_PART_2_SHIFT		= SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
-var S_TRAPSTS_RESTORE_PART_2_SIZE		= SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
-var S_TRAPSTS_RESTORE_PART_3_SHIFT		= SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
-var S_TRAPSTS_RESTORE_PART_3_SIZE		= 32 - S_TRAPSTS_RESTORE_PART_3_SHIFT
-var BARRIER_STATE_SIGNAL_OFFSET			= 16
-var BARRIER_STATE_VALID_OFFSET			= 0
-#endif
 
 // bits [31:24] unused by SPI debug data
 var TTMP11_SAVE_REPLAY_W64H_SHIFT		= 31
@@ -305,11 +239,7 @@ L_TRAP_NO_BARRIER:
 
 L_HALTED:
 	// Host trap may occur while wave is halted.
-#if ASIC_FAMILY < CHIP_GFX12
 	s_and_b32	ttmp2, s_save_pc_hi, S_SAVE_PC_HI_TRAP_ID_MASK
-#else
-	s_and_b32	ttmp2, s_save_trapsts, SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK
-#endif
 	s_cbranch_scc1	L_FETCH_2ND_TRAP
 
 L_CHECK_SAVE:
@@ -336,7 +266,6 @@ L_NOT_HALTED:
 	// Check for maskable exceptions in trapsts.excp and trapsts.excp_hi.
 	// Maskable exceptions only cause the wave to enter the trap handler if
 	// their respective bit in mode.excp_en is set.
-#if ASIC_FAMILY < CHIP_GFX12
 	s_and_b32	ttmp2, s_save_trapsts, SQ_WAVE_TRAPSTS_EXCP_MASK|SQ_WAVE_TRAPSTS_EXCP_HI_MASK
 	s_cbranch_scc0	L_CHECK_TRAP_ID
 
@@ -349,17 +278,6 @@ L_NOT_ADDR_WATCH:
 	s_lshl_b32	ttmp2, ttmp2, SQ_WAVE_MODE_EXCP_EN_SHIFT
 	s_and_b32	ttmp2, ttmp2, ttmp3
 	s_cbranch_scc1	L_FETCH_2ND_TRAP
-#else
-	s_getreg_b32	ttmp2, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
-	s_and_b32	ttmp3, s_save_trapsts, SQ_WAVE_EXCP_FLAG_PRIV_ADDR_WATCH_MASK
-	s_cbranch_scc0	L_NOT_ADDR_WATCH
-	s_or_b32	ttmp2, ttmp2, SQ_WAVE_TRAP_CTRL_ADDR_WATCH_MASK
-
-L_NOT_ADDR_WATCH:
-	s_getreg_b32	ttmp3, hwreg(HW_REG_WAVE_TRAP_CTRL)
-	s_and_b32	ttmp2, ttmp3, ttmp2
-	s_cbranch_scc1	L_FETCH_2ND_TRAP
-#endif
 
 L_CHECK_TRAP_ID:
 	// Check trap_id != 0
@@ -369,13 +287,8 @@ L_CHECK_TRAP_ID:
 #if SINGLE_STEP_MISSED_WORKAROUND
 	// Prioritize single step exception over context save.
 	// Second-level trap will halt wave and RFE, re-entering for SAVECTX.
-#if ASIC_FAMILY < CHIP_GFX12
 	s_getreg_b32	ttmp2, hwreg(HW_REG_MODE)
 	s_and_b32	ttmp2, ttmp2, SQ_WAVE_MODE_DEBUG_EN_MASK
-#else
-	// WAVE_TRAP_CTRL is already in ttmp3.
-	s_and_b32	ttmp3, ttmp3, SQ_WAVE_TRAP_CTRL_TRAP_AFTER_INST_MASK
-#endif
 	s_cbranch_scc1	L_FETCH_2ND_TRAP
 #endif
 
@@ -425,12 +338,7 @@ L_NO_NEXT_TRAP:
 	s_cbranch_scc1	L_TRAP_CASE
 
 	// Host trap will not cause trap re-entry.
-#if ASIC_FAMILY < CHIP_GFX12
 	s_and_b32	ttmp2, s_save_pc_hi, S_SAVE_PC_HI_HT_MASK
-#else
-	s_getreg_b32	ttmp2, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
-	s_and_b32	ttmp2, ttmp2, SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK
-#endif
 	s_cbranch_scc1	L_EXIT_TRAP
 	s_or_b32	s_save_status, s_save_status, S_STATUS_HALT_MASK
 
@@ -457,16 +365,7 @@ L_EXIT_TRAP:
 	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
 	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
 
-#if ASIC_FAMILY < CHIP_GFX12
 	s_setreg_b32	hwreg(S_STATUS_HWREG), s_save_status
-#else
-	// STATE_PRIV.BARRIER_COMPLETE may have changed since we read it.
-	// Only restore fields which the trap handler changes.
-	s_lshr_b32	s_save_status, s_save_status, SQ_WAVE_STATE_PRIV_SCC_SHIFT
-	s_setreg_b32	hwreg(S_STATUS_HWREG, SQ_WAVE_STATE_PRIV_SCC_SHIFT, \
-		SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT - SQ_WAVE_STATE_PRIV_SCC_SHIFT + 1), s_save_status
-#endif
-
 	s_rfe_b64	[ttmp0, ttmp1]
 
 L_SAVE:
@@ -478,14 +377,6 @@ L_SAVE:
 	s_endpgm
 L_HAVE_VGPRS:
 #endif
-#if ASIC_FAMILY >= CHIP_GFX12
-	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
-	s_bitcmp1_b32	s_save_tmp, SQ_WAVE_STATUS_NO_VGPRS_SHIFT
-	s_cbranch_scc0	L_HAVE_VGPRS
-	s_endpgm
-L_HAVE_VGPRS:
-#endif
-
 	s_and_b32	s_save_pc_hi, s_save_pc_hi, 0x0000ffff			//pc[47:32]
 	s_mov_b32	s_save_tmp, 0
 	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, S_TRAPSTS_SAVE_CONTEXT_SHIFT, 1), s_save_tmp	//clear saveCtx bit
@@ -671,19 +562,6 @@ L_SAVE_HWREG:
 	s_mov_b32	m0, 0x0							//Next lane of v2 to write to
 #endif
 
-#if ASIC_FAMILY >= CHIP_GFX12
-	// Ensure no further changes to barrier or LDS state.
-	// STATE_PRIV.BARRIER_COMPLETE may change up to this point.
-	s_barrier_signal	-2
-	s_barrier_wait	-2
-
-	// Re-read final state of BARRIER_COMPLETE field for save.
-	s_getreg_b32	s_save_tmp, hwreg(S_STATUS_HWREG)
-	s_and_b32	s_save_tmp, s_save_tmp, SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
-	s_andn2_b32	s_save_status, s_save_status, SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
-	s_or_b32	s_save_status, s_save_status, s_save_tmp
-#endif
-
 	write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)
 	write_hwreg_to_mem(s_save_pc_lo, s_save_buf_rsrc0, s_save_mem_offset)
 	s_andn2_b32	s_save_tmp, s_save_pc_hi, S_SAVE_PC_HI_FIRST_WAVE_MASK
@@ -707,21 +585,6 @@ L_SAVE_HWREG:
 	s_getreg_b32	s_save_m0, hwreg(HW_REG_SHADER_FLAT_SCRATCH_HI)
 	write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)
 
-#if ASIC_FAMILY >= CHIP_GFX12
-	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
-	write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)
-
-	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_TRAP_CTRL)
-	write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)
-
-	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
-	write_hwreg_to_mem(s_save_tmp, s_save_buf_rsrc0, s_save_mem_offset)
-
-	s_get_barrier_state s_save_tmp, -1
-	s_wait_kmcnt (0)
-	write_hwreg_to_mem(s_save_tmp, s_save_buf_rsrc0, s_save_mem_offset)
-#endif
-
 #if NO_SQC_STORE
 	// Write HWREGs with 16 VGPR lanes. TTMPs occupy space after this.
 	s_mov_b32       exec_lo, 0xFFFF
@@ -814,9 +677,7 @@ L_SAVE_LDS_NORMAL:
 	s_and_b32	s_save_alloc_size, s_save_alloc_size, 0xFFFFFFFF	//lds_size is zero?
 	s_cbranch_scc0	L_SAVE_LDS_DONE						//no lds used? jump to L_SAVE_DONE
 
-#if ASIC_FAMILY < CHIP_GFX12
 	s_barrier								//LDS is used? wait for other waves in the same TG
-#endif
 	s_and_b32	s_save_tmp, s_save_pc_hi, S_SAVE_PC_HI_FIRST_WAVE_MASK
 	s_cbranch_scc0	L_SAVE_LDS_DONE
 
@@ -1081,11 +942,6 @@ L_RESTORE:
 	s_mov_b32	s_restore_buf_rsrc2, 0					//NUM_RECORDS initial value = 0 (in bytes)
 	s_mov_b32	s_restore_buf_rsrc3, S_RESTORE_BUF_RSRC_WORD3_MISC
 
-#if ASIC_FAMILY >= CHIP_GFX12
-	// Save s_restore_spi_init_hi for later use.
-	s_mov_b32 s_restore_spi_init_hi_save, s_restore_spi_init_hi
-#endif
-
 	//determine it is wave32 or wave64
 	get_wave_size2(s_restore_size)
 
@@ -1320,9 +1176,7 @@ L_RESTORE_SGPR:
 	// s_barrier with MODE.DEBUG_EN=1, STATUS.PRIV=1 incorrectly asserts debug exception.
 	// Clear DEBUG_EN before and restore MODE after the barrier.
 	s_setreg_imm32_b32	hwreg(HW_REG_MODE), 0
-#if ASIC_FAMILY < CHIP_GFX12
 	s_barrier								//barrier to ensure the readiness of LDS before access attemps from any other wave in the same TG
-#endif
 
 	/* restore HW registers */
 L_RESTORE_HWREG:
@@ -1334,11 +1188,6 @@ L_RESTORE_HWREG:
 
 	s_mov_b32	s_restore_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
 
-#if ASIC_FAMILY >= CHIP_GFX12
-	// Restore s_restore_spi_init_hi before the saved value gets clobbered.
-	s_mov_b32 s_restore_spi_init_hi, s_restore_spi_init_hi_save
-#endif
-
 	read_hwreg_from_mem(s_restore_m0, s_restore_buf_rsrc0, s_restore_mem_offset)
 	read_hwreg_from_mem(s_restore_pc_lo, s_restore_buf_rsrc0, s_restore_mem_offset)
 	read_hwreg_from_mem(s_restore_pc_hi, s_restore_buf_rsrc0, s_restore_mem_offset)
@@ -1358,44 +1207,6 @@ L_RESTORE_HWREG:
 
 	s_setreg_b32	hwreg(HW_REG_SHADER_FLAT_SCRATCH_HI), s_restore_flat_scratch
 
-#if ASIC_FAMILY >= CHIP_GFX12
-	read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0, s_restore_mem_offset)
-	S_WAITCNT_0
-	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_USER), s_restore_tmp
-
-	read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0, s_restore_mem_offset)
-	S_WAITCNT_0
-	s_setreg_b32	hwreg(HW_REG_WAVE_TRAP_CTRL), s_restore_tmp
-
-	// Only the first wave needs to restore the workgroup barrier.
-	s_and_b32	s_restore_tmp, s_restore_spi_init_hi, S_RESTORE_SPI_INIT_FIRST_WAVE_MASK
-	s_cbranch_scc0	L_SKIP_BARRIER_RESTORE
-
-	// Skip over WAVE_STATUS, since there is no state to restore from it
-	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 4
-
-	read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0, s_restore_mem_offset)
-	S_WAITCNT_0
-
-	s_bitcmp1_b32	s_restore_tmp, BARRIER_STATE_VALID_OFFSET
-	s_cbranch_scc0	L_SKIP_BARRIER_RESTORE
-
-	// extract the saved signal count from s_restore_tmp
-	s_lshr_b32	s_restore_tmp, s_restore_tmp, BARRIER_STATE_SIGNAL_OFFSET
-
-	// We need to call s_barrier_signal repeatedly to restore the signal
-	// count of the work group barrier.  The member count is already
-	// initialized with the number of waves in the work group.
-L_BARRIER_RESTORE_LOOP:
-	s_and_b32	s_restore_tmp, s_restore_tmp, s_restore_tmp
-	s_cbranch_scc0	L_SKIP_BARRIER_RESTORE
-	s_barrier_signal	-1
-	s_add_i32	s_restore_tmp, s_restore_tmp, -1
-	s_branch	L_BARRIER_RESTORE_LOOP
-
-L_SKIP_BARRIER_RESTORE:
-#endif
-
 	s_mov_b32	m0, s_restore_m0
 	s_mov_b32	exec_lo, s_restore_exec_lo
 	s_mov_b32	exec_hi, s_restore_exec_hi
@@ -1453,13 +1264,6 @@ L_RETURN_WITHOUT_PRIV:
 
 	s_setreg_b32	hwreg(S_STATUS_HWREG), s_restore_status			// SCC is included, which is changed by previous salu
 
-#if ASIC_FAMILY >= CHIP_GFX12
-	// Make barrier and LDS state visible to all waves in the group.
-	// STATE_PRIV.BARRIER_COMPLETE may change after this point.
-	s_barrier_signal	-2
-	s_barrier_wait	-2
-#endif
-
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
 L_END_PGM:
@@ -1598,11 +1402,7 @@ function get_hwreg_size_bytes
 end
 
 function get_wave_size2(s_reg)
-#if ASIC_FAMILY < CHIP_GFX12
 	s_getreg_b32	s_reg, hwreg(HW_REG_IB_STS2,SQ_WAVE_IB_STS2_WAVE64_SHIFT,SQ_WAVE_IB_STS2_WAVE64_SIZE)
-#else
-	s_getreg_b32	s_reg, hwreg(HW_REG_WAVE_STATUS,SQ_WAVE_STATUS_WAVE64_SHIFT,SQ_WAVE_STATUS_WAVE64_SIZE)
-#endif
 	s_lshl_b32	s_reg, s_reg, S_WAVE_SIZE
 end
 
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
new file mode 100644
index 000000000000..7b9d36e5fa43
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -0,0 +1,1130 @@
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/* To compile this assembly code:
+ *
+ * gfx12:
+ *   cpp -DASIC_FAMILY=CHIP_GFX12 cwsr_trap_handler_gfx12.asm -P -o gfx12.sp3
+ *   sp3 gfx12.sp3 -hex gfx12.hex
+ */
+
+#define CHIP_GFX12 37
+
+#define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
+
+var SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK	= 0x4
+var SQ_WAVE_STATE_PRIV_SCC_SHIFT		= 9
+var SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK		= 0xC00
+var SQ_WAVE_STATE_PRIV_HALT_MASK		= 0x4000
+var SQ_WAVE_STATE_PRIV_POISON_ERR_MASK		= 0x8000
+var SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT		= 15
+var SQ_WAVE_STATUS_WAVE64_SHIFT			= 29
+var SQ_WAVE_STATUS_WAVE64_SIZE			= 1
+var SQ_WAVE_STATUS_NO_VGPRS_SHIFT		= 24
+var SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK	= SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK|SQ_WAVE_STATE_PRIV_POISON_ERR_MASK
+var S_SAVE_PC_HI_TRAP_ID_MASK			= 0xF0000000
+
+var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT		= 12
+var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE		= 9
+var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE		= 8
+var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT		= 12
+var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SHIFT	= 24
+var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE	= 4
+var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 9
+
+var SQ_WAVE_EXCP_FLAG_PRIV_ADDR_WATCH_MASK	= 0xF
+var SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK	= 0x10
+var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT	= 5
+var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK	= 0x20
+var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK	= 0x40
+var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT	= 6
+var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK	= 0x80
+var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT	= 7
+var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	= 0x100
+var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT	= 8
+var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK	= 0x200
+var SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK	= 0x800
+var SQ_WAVE_TRAP_CTRL_ADDR_WATCH_MASK		= 0x80
+var SQ_WAVE_TRAP_CTRL_TRAP_AFTER_INST_MASK	= 0x200
+
+var SQ_WAVE_EXCP_FLAG_PRIV_NON_MASKABLE_EXCP_MASK= SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK		|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK	|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK		|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK		|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK
+var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_1_SIZE	= SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT
+var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
+var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SIZE	= SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
+var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
+var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SIZE	= 32 - SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT
+var BARRIER_STATE_SIGNAL_OFFSET			= 16
+var BARRIER_STATE_VALID_OFFSET			= 0
+
+var TTMP11_DEBUG_TRAP_ENABLED_SHIFT		= 23
+var TTMP11_DEBUG_TRAP_ENABLED_MASK		= 0x800000
+
+// SQ_SEL_X/Y/Z/W, BUF_NUM_FORMAT_FLOAT, (0 for MUBUF stride[17:14]
+// when ADD_TID_ENABLE and BUF_DATA_FORMAT_32 for MTBUF), ADD_TID_ENABLE
+var S_SAVE_BUF_RSRC_WORD1_STRIDE		= 0x00040000
+var S_SAVE_BUF_RSRC_WORD3_MISC			= 0x10807FAC
+var S_SAVE_SPI_INIT_FIRST_WAVE_MASK		= 0x04000000
+var S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT		= 26
+
+var S_SAVE_PC_HI_FIRST_WAVE_MASK		= 0x80000000
+var S_SAVE_PC_HI_FIRST_WAVE_SHIFT		= 31
+
+var s_sgpr_save_num				= 108
+
+var s_save_spi_init_lo				= exec_lo
+var s_save_spi_init_hi				= exec_hi
+var s_save_pc_lo				= ttmp0
+var s_save_pc_hi				= ttmp1
+var s_save_exec_lo				= ttmp2
+var s_save_exec_hi				= ttmp3
+var s_save_state_priv				= ttmp12
+var s_save_excp_flag_priv			= ttmp15
+var s_save_xnack_mask				= s_save_excp_flag_priv
+var s_wave_size					= ttmp7
+var s_save_buf_rsrc0				= ttmp8
+var s_save_buf_rsrc1				= ttmp9
+var s_save_buf_rsrc2				= ttmp10
+var s_save_buf_rsrc3				= ttmp11
+var s_save_mem_offset				= ttmp4
+var s_save_alloc_size				= s_save_excp_flag_priv
+var s_save_tmp					= ttmp14
+var s_save_m0					= ttmp5
+var s_save_ttmps_lo				= s_save_tmp
+var s_save_ttmps_hi				= s_save_excp_flag_priv
+
+var S_RESTORE_BUF_RSRC_WORD1_STRIDE		= S_SAVE_BUF_RSRC_WORD1_STRIDE
+var S_RESTORE_BUF_RSRC_WORD3_MISC		= S_SAVE_BUF_RSRC_WORD3_MISC
+
+var S_RESTORE_SPI_INIT_FIRST_WAVE_MASK		= 0x04000000
+var S_RESTORE_SPI_INIT_FIRST_WAVE_SHIFT		= 26
+var S_WAVE_SIZE					= 25
+
+var s_restore_spi_init_lo			= exec_lo
+var s_restore_spi_init_hi			= exec_hi
+var s_restore_mem_offset			= ttmp12
+var s_restore_alloc_size			= ttmp3
+var s_restore_tmp				= ttmp2
+var s_restore_mem_offset_save			= s_restore_tmp
+var s_restore_m0				= s_restore_alloc_size
+var s_restore_mode				= ttmp7
+var s_restore_flat_scratch			= s_restore_tmp
+var s_restore_pc_lo				= ttmp0
+var s_restore_pc_hi				= ttmp1
+var s_restore_exec_lo				= ttmp4
+var s_restore_exec_hi				= ttmp5
+var s_restore_state_priv			= ttmp14
+var s_restore_excp_flag_priv			= ttmp15
+var s_restore_xnack_mask			= ttmp13
+var s_restore_buf_rsrc0				= ttmp8
+var s_restore_buf_rsrc1				= ttmp9
+var s_restore_buf_rsrc2				= ttmp10
+var s_restore_buf_rsrc3				= ttmp11
+var s_restore_size				= ttmp6
+var s_restore_ttmps_lo				= s_restore_tmp
+var s_restore_ttmps_hi				= s_restore_alloc_size
+var s_restore_spi_init_hi_save			= s_restore_exec_hi
+
+shader main
+	asic(DEFAULT)
+	type(CS)
+	wave_size(32)
+
+	s_branch	L_SKIP_RESTORE						//NOT restore. might be a regular trap or save
+
+L_JUMP_TO_RESTORE:
+	s_branch	L_RESTORE
+
+L_SKIP_RESTORE:
+	s_getreg_b32	s_save_state_priv, hwreg(HW_REG_WAVE_STATE_PRIV)	//save STATUS since we will change SCC
+
+	// Clear SPI_PRIO: do not save with elevated priority.
+	// Clear ECC_ERR: prevents SQC store and triggers FATAL_HALT if setreg'd.
+	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK
+
+	s_getreg_b32	s_save_excp_flag_priv, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
+
+	s_and_b32       ttmp2, s_save_state_priv, SQ_WAVE_STATE_PRIV_HALT_MASK
+	s_cbranch_scc0	L_NOT_HALTED
+
+L_HALTED:
+	// Host trap may occur while wave is halted.
+	s_and_b32	ttmp2, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK
+	s_cbranch_scc1	L_FETCH_2ND_TRAP
+
+L_CHECK_SAVE:
+	s_and_b32	ttmp2, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK
+	s_cbranch_scc1	L_SAVE
+
+	// Wave is halted but neither host trap nor SAVECTX is raised.
+	// Caused by instruction fetch memory violation.
+	// Spin wait until context saved to prevent interrupt storm.
+	s_sleep		0x10
+	s_getreg_b32	s_save_excp_flag_priv, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
+	s_branch	L_CHECK_SAVE
+
+L_NOT_HALTED:
+	// Let second-level handle non-SAVECTX exception or trap.
+	// Any concurrent SAVECTX will be handled upon re-entry once halted.
+
+	// Check non-maskable exceptions. memory_violation, illegal_instruction
+	// and xnack_error exceptions always cause the wave to enter the trap
+	// handler.
+	s_and_b32	ttmp2, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_NON_MASKABLE_EXCP_MASK
+	s_cbranch_scc1	L_FETCH_2ND_TRAP
+
+	// Check for maskable exceptions in trapsts.excp and trapsts.excp_hi.
+	// Maskable exceptions only cause the wave to enter the trap handler if
+	// their respective bit in mode.excp_en is set.
+	s_getreg_b32	ttmp2, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
+	s_and_b32	ttmp3, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_ADDR_WATCH_MASK
+	s_cbranch_scc0	L_NOT_ADDR_WATCH
+	s_or_b32	ttmp2, ttmp2, SQ_WAVE_TRAP_CTRL_ADDR_WATCH_MASK
+
+L_NOT_ADDR_WATCH:
+	s_getreg_b32	ttmp3, hwreg(HW_REG_WAVE_TRAP_CTRL)
+	s_and_b32	ttmp2, ttmp3, ttmp2
+	s_cbranch_scc1	L_FETCH_2ND_TRAP
+
+L_CHECK_TRAP_ID:
+	// Check trap_id != 0
+	s_and_b32	ttmp2, s_save_pc_hi, S_SAVE_PC_HI_TRAP_ID_MASK
+	s_cbranch_scc1	L_FETCH_2ND_TRAP
+
+#if SINGLE_STEP_MISSED_WORKAROUND
+	// Prioritize single step exception over context save.
+	// Second-level trap will halt wave and RFE, re-entering for SAVECTX.
+	// WAVE_TRAP_CTRL is already in ttmp3.
+	s_and_b32	ttmp3, ttmp3, SQ_WAVE_TRAP_CTRL_TRAP_AFTER_INST_MASK
+	s_cbranch_scc1	L_FETCH_2ND_TRAP
+#endif
+
+	s_and_b32	ttmp2, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK
+	s_cbranch_scc1	L_SAVE
+
+L_FETCH_2ND_TRAP:
+	// Read second-level TBA/TMA from first-level TMA and jump if available.
+	// ttmp[2:5] and ttmp12 can be used (others hold SPI-initialized debug data)
+	// ttmp12 holds SQ_WAVE_STATUS
+	s_sendmsg_rtn_b64       [ttmp14, ttmp15], sendmsg(MSG_RTN_GET_TMA)
+	s_wait_idle
+	s_lshl_b64	[ttmp14, ttmp15], [ttmp14, ttmp15], 0x8
+
+	s_bitcmp1_b32	ttmp15, 0xF
+	s_cbranch_scc0	L_NO_SIGN_EXTEND_TMA
+	s_or_b32	ttmp15, ttmp15, 0xFFFF0000
+L_NO_SIGN_EXTEND_TMA:
+
+	s_load_dword    ttmp2, [ttmp14, ttmp15], 0x10 scope:SCOPE_SYS		// debug trap enabled flag
+	s_wait_idle
+	s_lshl_b32      ttmp2, ttmp2, TTMP11_DEBUG_TRAP_ENABLED_SHIFT
+	s_andn2_b32     ttmp11, ttmp11, TTMP11_DEBUG_TRAP_ENABLED_MASK
+	s_or_b32        ttmp11, ttmp11, ttmp2
+
+	s_load_dwordx2	[ttmp2, ttmp3], [ttmp14, ttmp15], 0x0 scope:SCOPE_SYS	// second-level TBA
+	s_wait_idle
+	s_load_dwordx2	[ttmp14, ttmp15], [ttmp14, ttmp15], 0x8 scope:SCOPE_SYS	// second-level TMA
+	s_wait_idle
+
+	s_and_b64	[ttmp2, ttmp3], [ttmp2, ttmp3], [ttmp2, ttmp3]
+	s_cbranch_scc0	L_NO_NEXT_TRAP						// second-level trap handler not been set
+	s_setpc_b64	[ttmp2, ttmp3]						// jump to second-level trap handler
+
+L_NO_NEXT_TRAP:
+	// If not caused by trap then halt wave to prevent re-entry.
+	s_and_b32	ttmp2, s_save_pc_hi, S_SAVE_PC_HI_TRAP_ID_MASK
+	s_cbranch_scc1	L_TRAP_CASE
+
+	// Host trap will not cause trap re-entry.
+	s_getreg_b32	ttmp2, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
+	s_and_b32	ttmp2, ttmp2, SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK
+	s_cbranch_scc1	L_EXIT_TRAP
+	s_or_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_HALT_MASK
+
+	// If the PC points to S_ENDPGM then context save will fail if STATE_PRIV.HALT is set.
+	// Rewind the PC to prevent this from occurring.
+	s_sub_u32	ttmp0, ttmp0, 0x8
+	s_subb_u32	ttmp1, ttmp1, 0x0
+
+	s_branch	L_EXIT_TRAP
+
+L_TRAP_CASE:
+	// Advance past trap instruction to prevent re-entry.
+	s_add_u32	ttmp0, ttmp0, 0x4
+	s_addc_u32	ttmp1, ttmp1, 0x0
+
+L_EXIT_TRAP:
+	s_and_b32	ttmp1, ttmp1, 0xFFFF
+
+	// Restore SQ_WAVE_STATUS.
+	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
+	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
+
+	// STATE_PRIV.BARRIER_COMPLETE may have changed since we read it.
+	// Only restore fields which the trap handler changes.
+	s_lshr_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_SCC_SHIFT
+	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV, SQ_WAVE_STATE_PRIV_SCC_SHIFT, \
+		SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT - SQ_WAVE_STATE_PRIV_SCC_SHIFT + 1), s_save_state_priv
+
+	s_rfe_b64	[ttmp0, ttmp1]
+
+L_SAVE:
+	// If VGPRs have been deallocated then terminate the wavefront.
+	// It has no remaining program to run and cannot save without VGPRs.
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
+	s_bitcmp1_b32	s_save_tmp, SQ_WAVE_STATUS_NO_VGPRS_SHIFT
+	s_cbranch_scc0	L_HAVE_VGPRS
+	s_endpgm
+L_HAVE_VGPRS:
+
+	s_and_b32	s_save_pc_hi, s_save_pc_hi, 0x0000ffff			//pc[47:32]
+	s_mov_b32	s_save_tmp, 0
+	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT, 1), s_save_tmp	//clear saveCtx bit
+
+	/* inform SPI the readiness and wait for SPI's go signal */
+	s_mov_b32	s_save_exec_lo, exec_lo					//save EXEC and use EXEC for the go signal from SPI
+	s_mov_b32	s_save_exec_hi, exec_hi
+	s_mov_b64	exec, 0x0						//clear EXEC to get ready to receive
+
+	s_sendmsg_rtn_b64       [exec_lo, exec_hi], sendmsg(MSG_RTN_SAVE_WAVE)
+	s_wait_idle
+
+	// Save first_wave flag so we can clear high bits of save address.
+	s_and_b32	s_save_tmp, s_save_spi_init_hi, S_SAVE_SPI_INIT_FIRST_WAVE_MASK
+	s_lshl_b32	s_save_tmp, s_save_tmp, (S_SAVE_PC_HI_FIRST_WAVE_SHIFT - S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT)
+	s_or_b32	s_save_pc_hi, s_save_pc_hi, s_save_tmp
+
+	// Trap temporaries must be saved via VGPR but all VGPRs are in use.
+	// There is no ttmp space to hold the resource constant for VGPR save.
+	// Save v0 by itself since it requires only two SGPRs.
+	s_mov_b32	s_save_ttmps_lo, exec_lo
+	s_and_b32	s_save_ttmps_hi, exec_hi, 0xFFFF
+	s_mov_b32	exec_lo, 0xFFFFFFFF
+	s_mov_b32	exec_hi, 0xFFFFFFFF
+	global_store_dword_addtid	v0, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS
+	v_mov_b32	v0, 0x0
+	s_mov_b32	exec_lo, s_save_ttmps_lo
+	s_mov_b32	exec_hi, s_save_ttmps_hi
+
+	// Save trap temporaries 4-11, 13 initialized by SPI debug dispatch logic
+	// ttmp SR memory offset : size(VGPR)+size(SVGPR)+size(SGPR)+0x40
+	get_wave_size2(s_save_ttmps_hi)
+	get_vgpr_size_bytes(s_save_ttmps_lo, s_save_ttmps_hi)
+	get_svgpr_size_bytes(s_save_ttmps_hi)
+	s_add_u32	s_save_ttmps_lo, s_save_ttmps_lo, s_save_ttmps_hi
+	s_and_b32	s_save_ttmps_hi, s_save_spi_init_hi, 0xFFFF
+	s_add_u32	s_save_ttmps_lo, s_save_ttmps_lo, get_sgpr_size_bytes()
+	s_add_u32	s_save_ttmps_lo, s_save_ttmps_lo, s_save_spi_init_lo
+	s_addc_u32	s_save_ttmps_hi, s_save_ttmps_hi, 0x0
+
+	v_writelane_b32	v0, ttmp4, 0x4
+	v_writelane_b32	v0, ttmp5, 0x5
+	v_writelane_b32	v0, ttmp6, 0x6
+	v_writelane_b32	v0, ttmp7, 0x7
+	v_writelane_b32	v0, ttmp8, 0x8
+	v_writelane_b32	v0, ttmp9, 0x9
+	v_writelane_b32	v0, ttmp10, 0xA
+	v_writelane_b32	v0, ttmp11, 0xB
+	v_writelane_b32	v0, ttmp13, 0xD
+	v_writelane_b32	v0, exec_lo, 0xE
+	v_writelane_b32	v0, exec_hi, 0xF
+
+	s_mov_b32	exec_lo, 0x3FFF
+	s_mov_b32	exec_hi, 0x0
+	global_store_dword_addtid	v0, [s_save_ttmps_lo, s_save_ttmps_hi] offset:0x40 scope:SCOPE_SYS
+	v_readlane_b32	ttmp14, v0, 0xE
+	v_readlane_b32	ttmp15, v0, 0xF
+	s_mov_b32	exec_lo, ttmp14
+	s_mov_b32	exec_hi, ttmp15
+
+	/* setup Resource Contants */
+	s_mov_b32	s_save_buf_rsrc0, s_save_spi_init_lo			//base_addr_lo
+	s_and_b32	s_save_buf_rsrc1, s_save_spi_init_hi, 0x0000FFFF	//base_addr_hi
+	s_or_b32	s_save_buf_rsrc1, s_save_buf_rsrc1, S_SAVE_BUF_RSRC_WORD1_STRIDE
+	s_mov_b32	s_save_buf_rsrc2, 0					//NUM_RECORDS initial value = 0 (in bytes) although not neccessarily inited
+	s_mov_b32	s_save_buf_rsrc3, S_SAVE_BUF_RSRC_WORD3_MISC
+
+	s_mov_b32	s_save_m0, m0
+
+	/* global mem offset */
+	s_mov_b32	s_save_mem_offset, 0x0
+	get_wave_size2(s_wave_size)
+
+	/* save first 4 VGPRs, needed for SGPR save */
+	s_mov_b32	exec_lo, 0xFFFFFFFF					//need every thread from now on
+	s_lshr_b32	m0, s_wave_size, S_WAVE_SIZE
+	s_and_b32	m0, m0, 1
+	s_cmp_eq_u32	m0, 1
+	s_cbranch_scc1	L_ENABLE_SAVE_4VGPR_EXEC_HI
+	s_mov_b32	exec_hi, 0x00000000
+	s_branch	L_SAVE_4VGPR_WAVE32
+L_ENABLE_SAVE_4VGPR_EXEC_HI:
+	s_mov_b32	exec_hi, 0xFFFFFFFF
+	s_branch	L_SAVE_4VGPR_WAVE64
+L_SAVE_4VGPR_WAVE32:
+	s_mov_b32	s_save_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
+
+	// VGPR Allocated in 4-GPR granularity
+
+	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:128
+	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:128*2
+	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:128*3
+	s_branch	L_SAVE_HWREG
+
+L_SAVE_4VGPR_WAVE64:
+	s_mov_b32	s_save_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
+
+	// VGPR Allocated in 4-GPR granularity
+
+	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:256
+	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:256*2
+	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:256*3
+
+	/* save HW registers */
+
+L_SAVE_HWREG:
+	// HWREG SR memory offset : size(VGPR)+size(SVGPR)+size(SGPR)
+	get_vgpr_size_bytes(s_save_mem_offset, s_wave_size)
+	get_svgpr_size_bytes(s_save_tmp)
+	s_add_u32	s_save_mem_offset, s_save_mem_offset, s_save_tmp
+	s_add_u32	s_save_mem_offset, s_save_mem_offset, get_sgpr_size_bytes()
+
+	s_mov_b32	s_save_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
+
+	v_mov_b32	v0, 0x0							//Offset[31:0] from buffer resource
+	v_mov_b32	v1, 0x0							//Offset[63:32] from buffer resource
+	v_mov_b32	v2, 0x0							//Set of SGPRs for TCP store
+	s_mov_b32	m0, 0x0							//Next lane of v2 to write to
+
+	// Ensure no further changes to barrier or LDS state.
+	// STATE_PRIV.BARRIER_COMPLETE may change up to this point.
+	s_barrier_signal	-2
+	s_barrier_wait	-2
+
+	// Re-read final state of BARRIER_COMPLETE field for save.
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATE_PRIV)
+	s_and_b32	s_save_tmp, s_save_tmp, SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
+	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
+	s_or_b32	s_save_state_priv, s_save_state_priv, s_save_tmp
+
+	write_hwreg_to_v2(s_save_m0)
+	write_hwreg_to_v2(s_save_pc_lo)
+	s_andn2_b32	s_save_tmp, s_save_pc_hi, S_SAVE_PC_HI_FIRST_WAVE_MASK
+	write_hwreg_to_v2(s_save_tmp)
+	write_hwreg_to_v2(s_save_exec_lo)
+	write_hwreg_to_v2(s_save_exec_hi)
+	write_hwreg_to_v2(s_save_state_priv)
+
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
+	write_hwreg_to_v2(s_save_tmp)
+
+	write_hwreg_to_v2(s_save_xnack_mask)
+
+	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_MODE)
+	write_hwreg_to_v2(s_save_m0)
+
+	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_SCRATCH_BASE_LO)
+	write_hwreg_to_v2(s_save_m0)
+
+	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_SCRATCH_BASE_HI)
+	write_hwreg_to_v2(s_save_m0)
+
+	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
+	write_hwreg_to_v2(s_save_m0)
+
+	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_TRAP_CTRL)
+	write_hwreg_to_v2(s_save_m0)
+
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
+	write_hwreg_to_v2(s_save_tmp)
+
+	s_get_barrier_state s_save_tmp, -1
+	s_wait_kmcnt (0)
+	write_hwreg_to_v2(s_save_tmp)
+
+	// Write HWREGs with 16 VGPR lanes. TTMPs occupy space after this.
+	s_mov_b32       exec_lo, 0xFFFF
+	s_mov_b32	exec_hi, 0x0
+	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
+
+	// Write SGPRs with 32 VGPR lanes. This works in wave32 and wave64 mode.
+	s_mov_b32       exec_lo, 0xFFFFFFFF
+
+	/* save SGPRs */
+	// Save SGPR before LDS save, then the s0 to s4 can be used during LDS save...
+
+	// SGPR SR memory offset : size(VGPR)+size(SVGPR)
+	get_vgpr_size_bytes(s_save_mem_offset, s_wave_size)
+	get_svgpr_size_bytes(s_save_tmp)
+	s_add_u32	s_save_mem_offset, s_save_mem_offset, s_save_tmp
+	s_mov_b32	s_save_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
+
+	s_mov_b32	ttmp13, 0x0						//next VGPR lane to copy SGPR into
+
+	s_mov_b32	m0, 0x0							//SGPR initial index value =0
+	s_nop		0x0							//Manually inserted wait states
+L_SAVE_SGPR_LOOP:
+	// SGPR is allocated in 16 SGPR granularity
+	s_movrels_b64	s0, s0							//s0 = s[0+m0], s1 = s[1+m0]
+	s_movrels_b64	s2, s2							//s2 = s[2+m0], s3 = s[3+m0]
+	s_movrels_b64	s4, s4							//s4 = s[4+m0], s5 = s[5+m0]
+	s_movrels_b64	s6, s6							//s6 = s[6+m0], s7 = s[7+m0]
+	s_movrels_b64	s8, s8							//s8 = s[8+m0], s9 = s[9+m0]
+	s_movrels_b64	s10, s10						//s10 = s[10+m0], s11 = s[11+m0]
+	s_movrels_b64	s12, s12						//s12 = s[12+m0], s13 = s[13+m0]
+	s_movrels_b64	s14, s14						//s14 = s[14+m0], s15 = s[15+m0]
+
+	write_16sgpr_to_v2(s0)
+
+	s_cmp_eq_u32	ttmp13, 0x20						//have 32 VGPR lanes filled?
+	s_cbranch_scc0	L_SAVE_SGPR_SKIP_TCP_STORE
+
+	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
+	s_add_u32	s_save_mem_offset, s_save_mem_offset, 0x80
+	s_mov_b32	ttmp13, 0x0
+	v_mov_b32	v2, 0x0
+L_SAVE_SGPR_SKIP_TCP_STORE:
+
+	s_add_u32	m0, m0, 16						//next sgpr index
+	s_cmp_lt_u32	m0, 96							//scc = (m0 < first 96 SGPR) ? 1 : 0
+	s_cbranch_scc1	L_SAVE_SGPR_LOOP					//first 96 SGPR save is complete?
+
+	//save the rest 12 SGPR
+	s_movrels_b64	s0, s0							//s0 = s[0+m0], s1 = s[1+m0]
+	s_movrels_b64	s2, s2							//s2 = s[2+m0], s3 = s[3+m0]
+	s_movrels_b64	s4, s4							//s4 = s[4+m0], s5 = s[5+m0]
+	s_movrels_b64	s6, s6							//s6 = s[6+m0], s7 = s[7+m0]
+	s_movrels_b64	s8, s8							//s8 = s[8+m0], s9 = s[9+m0]
+	s_movrels_b64	s10, s10						//s10 = s[10+m0], s11 = s[11+m0]
+	write_12sgpr_to_v2(s0)
+
+	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
+
+	/* save LDS */
+
+L_SAVE_LDS:
+	// Change EXEC to all threads...
+	s_mov_b32	exec_lo, 0xFFFFFFFF					//need every thread from now on
+	s_lshr_b32	m0, s_wave_size, S_WAVE_SIZE
+	s_and_b32	m0, m0, 1
+	s_cmp_eq_u32	m0, 1
+	s_cbranch_scc1	L_ENABLE_SAVE_LDS_EXEC_HI
+	s_mov_b32	exec_hi, 0x00000000
+	s_branch	L_SAVE_LDS_NORMAL
+L_ENABLE_SAVE_LDS_EXEC_HI:
+	s_mov_b32	exec_hi, 0xFFFFFFFF
+L_SAVE_LDS_NORMAL:
+	s_getreg_b32	s_save_alloc_size, hwreg(HW_REG_WAVE_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT,SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE)
+	s_and_b32	s_save_alloc_size, s_save_alloc_size, 0xFFFFFFFF	//lds_size is zero?
+	s_cbranch_scc0	L_SAVE_LDS_DONE						//no lds used? jump to L_SAVE_DONE
+
+	s_and_b32	s_save_tmp, s_save_pc_hi, S_SAVE_PC_HI_FIRST_WAVE_MASK
+	s_cbranch_scc0	L_SAVE_LDS_DONE
+
+	// first wave do LDS save;
+
+	s_lshl_b32	s_save_alloc_size, s_save_alloc_size, SQ_WAVE_LDS_ALLOC_GRANULARITY
+	s_mov_b32	s_save_buf_rsrc2, s_save_alloc_size			//NUM_RECORDS in bytes
+
+	// LDS at offset: size(VGPR)+size(SVGPR)+SIZE(SGPR)+SIZE(HWREG)
+	//
+	get_vgpr_size_bytes(s_save_mem_offset, s_wave_size)
+	get_svgpr_size_bytes(s_save_tmp)
+	s_add_u32	s_save_mem_offset, s_save_mem_offset, s_save_tmp
+	s_add_u32	s_save_mem_offset, s_save_mem_offset, get_sgpr_size_bytes()
+	s_add_u32	s_save_mem_offset, s_save_mem_offset, get_hwreg_size_bytes()
+
+	s_mov_b32	s_save_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
+
+	//load 0~63*4(byte address) to vgpr v0
+	v_mbcnt_lo_u32_b32	v0, -1, 0
+	v_mbcnt_hi_u32_b32	v0, -1, v0
+	v_mul_u32_u24	v0, 4, v0
+
+	s_lshr_b32	m0, s_wave_size, S_WAVE_SIZE
+	s_and_b32	m0, m0, 1
+	s_cmp_eq_u32	m0, 1
+	s_mov_b32	m0, 0x0
+	s_cbranch_scc1	L_SAVE_LDS_W64
+
+L_SAVE_LDS_W32:
+	s_mov_b32	s3, 128
+	s_nop		0
+	s_nop		0
+	s_nop		0
+L_SAVE_LDS_LOOP_W32:
+	ds_read_b32	v1, v0
+	s_wait_idle
+	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
+
+	s_add_u32	m0, m0, s3						//every buffer_store_lds does 128 bytes
+	s_add_u32	s_save_mem_offset, s_save_mem_offset, s3
+	v_add_nc_u32	v0, v0, 128						//mem offset increased by 128 bytes
+	s_cmp_lt_u32	m0, s_save_alloc_size					//scc=(m0 < s_save_alloc_size) ? 1 : 0
+	s_cbranch_scc1	L_SAVE_LDS_LOOP_W32					//LDS save is complete?
+
+	s_branch	L_SAVE_LDS_DONE
+
+L_SAVE_LDS_W64:
+	s_mov_b32	s3, 256
+	s_nop		0
+	s_nop		0
+	s_nop		0
+L_SAVE_LDS_LOOP_W64:
+	ds_read_b32	v1, v0
+	s_wait_idle
+	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
+
+	s_add_u32	m0, m0, s3						//every buffer_store_lds does 256 bytes
+	s_add_u32	s_save_mem_offset, s_save_mem_offset, s3
+	v_add_nc_u32	v0, v0, 256						//mem offset increased by 256 bytes
+	s_cmp_lt_u32	m0, s_save_alloc_size					//scc=(m0 < s_save_alloc_size) ? 1 : 0
+	s_cbranch_scc1	L_SAVE_LDS_LOOP_W64					//LDS save is complete?
+
+L_SAVE_LDS_DONE:
+	/* save VGPRs  - set the Rest VGPRs */
+L_SAVE_VGPR:
+	// VGPR SR memory offset: 0
+	s_mov_b32	exec_lo, 0xFFFFFFFF					//need every thread from now on
+	s_lshr_b32	m0, s_wave_size, S_WAVE_SIZE
+	s_and_b32	m0, m0, 1
+	s_cmp_eq_u32	m0, 1
+	s_cbranch_scc1	L_ENABLE_SAVE_VGPR_EXEC_HI
+	s_mov_b32	s_save_mem_offset, (0+128*4)				// for the rest VGPRs
+	s_mov_b32	exec_hi, 0x00000000
+	s_branch	L_SAVE_VGPR_NORMAL
+L_ENABLE_SAVE_VGPR_EXEC_HI:
+	s_mov_b32	s_save_mem_offset, (0+256*4)				// for the rest VGPRs
+	s_mov_b32	exec_hi, 0xFFFFFFFF
+L_SAVE_VGPR_NORMAL:
+	s_getreg_b32	s_save_alloc_size, hwreg(HW_REG_WAVE_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
+	s_add_u32	s_save_alloc_size, s_save_alloc_size, 1
+	s_lshl_b32	s_save_alloc_size, s_save_alloc_size, 2			//Number of VGPRs = (vgpr_size + 1) * 4    (non-zero value)
+	//determine it is wave32 or wave64
+	s_lshr_b32	m0, s_wave_size, S_WAVE_SIZE
+	s_and_b32	m0, m0, 1
+	s_cmp_eq_u32	m0, 1
+	s_cbranch_scc1	L_SAVE_VGPR_WAVE64
+
+	s_mov_b32	s_save_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
+
+	// VGPR Allocated in 4-GPR granularity
+
+	// VGPR store using dw burst
+	s_mov_b32	m0, 0x4							//VGPR initial index value =4
+	s_cmp_lt_u32	m0, s_save_alloc_size
+	s_cbranch_scc0	L_SAVE_VGPR_END
+
+L_SAVE_VGPR_W32_LOOP:
+	v_movrels_b32	v0, v0							//v0 = v[0+m0]
+	v_movrels_b32	v1, v1							//v1 = v[1+m0]
+	v_movrels_b32	v2, v2							//v2 = v[2+m0]
+	v_movrels_b32	v3, v3							//v3 = v[3+m0]
+
+	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
+	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:128
+	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:128*2
+	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:128*3
+
+	s_add_u32	m0, m0, 4						//next vgpr index
+	s_add_u32	s_save_mem_offset, s_save_mem_offset, 128*4		//every buffer_store_dword does 128 bytes
+	s_cmp_lt_u32	m0, s_save_alloc_size					//scc = (m0 < s_save_alloc_size) ? 1 : 0
+	s_cbranch_scc1	L_SAVE_VGPR_W32_LOOP					//VGPR save is complete?
+
+	s_branch	L_SAVE_VGPR_END
+
+L_SAVE_VGPR_WAVE64:
+	s_mov_b32	s_save_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
+
+	// VGPR store using dw burst
+	s_mov_b32	m0, 0x4							//VGPR initial index value =4
+	s_cmp_lt_u32	m0, s_save_alloc_size
+	s_cbranch_scc0	L_SAVE_SHARED_VGPR
+
+L_SAVE_VGPR_W64_LOOP:
+	v_movrels_b32	v0, v0							//v0 = v[0+m0]
+	v_movrels_b32	v1, v1							//v1 = v[1+m0]
+	v_movrels_b32	v2, v2							//v2 = v[2+m0]
+	v_movrels_b32	v3, v3							//v3 = v[3+m0]
+
+	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
+	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:256
+	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:256*2
+	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS offset:256*3
+
+	s_add_u32	m0, m0, 4						//next vgpr index
+	s_add_u32	s_save_mem_offset, s_save_mem_offset, 256*4		//every buffer_store_dword does 256 bytes
+	s_cmp_lt_u32	m0, s_save_alloc_size					//scc = (m0 < s_save_alloc_size) ? 1 : 0
+	s_cbranch_scc1	L_SAVE_VGPR_W64_LOOP					//VGPR save is complete?
+
+L_SAVE_SHARED_VGPR:
+	s_getreg_b32	s_save_alloc_size, hwreg(HW_REG_WAVE_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SHIFT,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE)
+	s_and_b32	s_save_alloc_size, s_save_alloc_size, 0xFFFFFFFF	//shared_vgpr_size is zero?
+	s_cbranch_scc0	L_SAVE_VGPR_END						//no shared_vgpr used? jump to L_SAVE_LDS
+	s_lshl_b32	s_save_alloc_size, s_save_alloc_size, 3			//Number of SHARED_VGPRs = shared_vgpr_size * 8    (non-zero value)
+	//m0 now has the value of normal vgpr count, just add the m0 with shared_vgpr count to get the total count.
+	//save shared_vgpr will start from the index of m0
+	s_add_u32	s_save_alloc_size, s_save_alloc_size, m0
+	s_mov_b32	exec_lo, 0xFFFFFFFF
+	s_mov_b32	exec_hi, 0x00000000
+
+L_SAVE_SHARED_VGPR_WAVE64_LOOP:
+	v_movrels_b32	v0, v0							//v0 = v[0+m0]
+	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
+	s_add_u32	m0, m0, 1						//next vgpr index
+	s_add_u32	s_save_mem_offset, s_save_mem_offset, 128
+	s_cmp_lt_u32	m0, s_save_alloc_size					//scc = (m0 < s_save_alloc_size) ? 1 : 0
+	s_cbranch_scc1	L_SAVE_SHARED_VGPR_WAVE64_LOOP				//SHARED_VGPR save is complete?
+
+L_SAVE_VGPR_END:
+	s_branch	L_END_PGM
+
+L_RESTORE:
+	/* Setup Resource Contants */
+	s_mov_b32	s_restore_buf_rsrc0, s_restore_spi_init_lo		//base_addr_lo
+	s_and_b32	s_restore_buf_rsrc1, s_restore_spi_init_hi, 0x0000FFFF	//base_addr_hi
+	s_or_b32	s_restore_buf_rsrc1, s_restore_buf_rsrc1, S_RESTORE_BUF_RSRC_WORD1_STRIDE
+	s_mov_b32	s_restore_buf_rsrc2, 0					//NUM_RECORDS initial value = 0 (in bytes)
+	s_mov_b32	s_restore_buf_rsrc3, S_RESTORE_BUF_RSRC_WORD3_MISC
+
+	// Save s_restore_spi_init_hi for later use.
+	s_mov_b32 s_restore_spi_init_hi_save, s_restore_spi_init_hi
+
+	//determine it is wave32 or wave64
+	get_wave_size2(s_restore_size)
+
+	s_and_b32	s_restore_tmp, s_restore_spi_init_hi, S_RESTORE_SPI_INIT_FIRST_WAVE_MASK
+	s_cbranch_scc0	L_RESTORE_VGPR
+
+	/* restore LDS */
+L_RESTORE_LDS:
+	s_mov_b32	exec_lo, 0xFFFFFFFF					//need every thread from now on
+	s_lshr_b32	m0, s_restore_size, S_WAVE_SIZE
+	s_and_b32	m0, m0, 1
+	s_cmp_eq_u32	m0, 1
+	s_cbranch_scc1	L_ENABLE_RESTORE_LDS_EXEC_HI
+	s_mov_b32	exec_hi, 0x00000000
+	s_branch	L_RESTORE_LDS_NORMAL
+L_ENABLE_RESTORE_LDS_EXEC_HI:
+	s_mov_b32	exec_hi, 0xFFFFFFFF
+L_RESTORE_LDS_NORMAL:
+	s_getreg_b32	s_restore_alloc_size, hwreg(HW_REG_WAVE_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT,SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE)
+	s_and_b32	s_restore_alloc_size, s_restore_alloc_size, 0xFFFFFFFF	//lds_size is zero?
+	s_cbranch_scc0	L_RESTORE_VGPR						//no lds used? jump to L_RESTORE_VGPR
+	s_lshl_b32	s_restore_alloc_size, s_restore_alloc_size, SQ_WAVE_LDS_ALLOC_GRANULARITY
+	s_mov_b32	s_restore_buf_rsrc2, s_restore_alloc_size		//NUM_RECORDS in bytes
+
+	// LDS at offset: size(VGPR)+size(SVGPR)+SIZE(SGPR)+SIZE(HWREG)
+	//
+	get_vgpr_size_bytes(s_restore_mem_offset, s_restore_size)
+	get_svgpr_size_bytes(s_restore_tmp)
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, s_restore_tmp
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, get_sgpr_size_bytes()
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, get_hwreg_size_bytes()
+
+	s_mov_b32	s_restore_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
+
+	s_lshr_b32	m0, s_restore_size, S_WAVE_SIZE
+	s_and_b32	m0, m0, 1
+	s_cmp_eq_u32	m0, 1
+	s_mov_b32	m0, 0x0
+	s_cbranch_scc1	L_RESTORE_LDS_LOOP_W64
+
+L_RESTORE_LDS_LOOP_W32:
+	buffer_load_dword       v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset
+	s_wait_idle
+	ds_store_addtid_b32     v0
+	s_add_u32	m0, m0, 128						// 128 DW
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 128		//mem offset increased by 128DW
+	s_cmp_lt_u32	m0, s_restore_alloc_size				//scc=(m0 < s_restore_alloc_size) ? 1 : 0
+	s_cbranch_scc1	L_RESTORE_LDS_LOOP_W32					//LDS restore is complete?
+	s_branch	L_RESTORE_VGPR
+
+L_RESTORE_LDS_LOOP_W64:
+	buffer_load_dword       v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset
+	s_wait_idle
+	ds_store_addtid_b32     v0
+	s_add_u32	m0, m0, 256						// 256 DW
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 256		//mem offset increased by 256DW
+	s_cmp_lt_u32	m0, s_restore_alloc_size				//scc=(m0 < s_restore_alloc_size) ? 1 : 0
+	s_cbranch_scc1	L_RESTORE_LDS_LOOP_W64					//LDS restore is complete?
+
+	/* restore VGPRs */
+L_RESTORE_VGPR:
+	// VGPR SR memory offset : 0
+	s_mov_b32	s_restore_mem_offset, 0x0
+	s_mov_b32	exec_lo, 0xFFFFFFFF					//need every thread from now on
+	s_lshr_b32	m0, s_restore_size, S_WAVE_SIZE
+	s_and_b32	m0, m0, 1
+	s_cmp_eq_u32	m0, 1
+	s_cbranch_scc1	L_ENABLE_RESTORE_VGPR_EXEC_HI
+	s_mov_b32	exec_hi, 0x00000000
+	s_branch	L_RESTORE_VGPR_NORMAL
+L_ENABLE_RESTORE_VGPR_EXEC_HI:
+	s_mov_b32	exec_hi, 0xFFFFFFFF
+L_RESTORE_VGPR_NORMAL:
+	s_getreg_b32	s_restore_alloc_size, hwreg(HW_REG_WAVE_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
+	s_add_u32	s_restore_alloc_size, s_restore_alloc_size, 1
+	s_lshl_b32	s_restore_alloc_size, s_restore_alloc_size, 2		//Number of VGPRs = (vgpr_size + 1) * 4    (non-zero value)
+	//determine it is wave32 or wave64
+	s_lshr_b32	m0, s_restore_size, S_WAVE_SIZE
+	s_and_b32	m0, m0, 1
+	s_cmp_eq_u32	m0, 1
+	s_cbranch_scc1	L_RESTORE_VGPR_WAVE64
+
+	s_mov_b32	s_restore_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
+
+	// VGPR load using dw burst
+	s_mov_b32	s_restore_mem_offset_save, s_restore_mem_offset		// restore start with v1, v0 will be the last
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 128*4
+	s_mov_b32	m0, 4							//VGPR initial index value = 4
+	s_cmp_lt_u32	m0, s_restore_alloc_size
+	s_cbranch_scc0	L_RESTORE_SGPR
+
+L_RESTORE_VGPR_WAVE32_LOOP:
+	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS
+	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS offset:128
+	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS offset:128*2
+	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS offset:128*3
+	s_wait_idle
+	v_movreld_b32	v0, v0							//v[0+m0] = v0
+	v_movreld_b32	v1, v1
+	v_movreld_b32	v2, v2
+	v_movreld_b32	v3, v3
+	s_add_u32	m0, m0, 4						//next vgpr index
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 128*4	//every buffer_load_dword does 128 bytes
+	s_cmp_lt_u32	m0, s_restore_alloc_size				//scc = (m0 < s_restore_alloc_size) ? 1 : 0
+	s_cbranch_scc1	L_RESTORE_VGPR_WAVE32_LOOP				//VGPR restore (except v0) is complete?
+
+	/* VGPR restore on v0 */
+	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS
+	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS offset:128
+	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS offset:128*2
+	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS offset:128*3
+	s_wait_idle
+
+	s_branch	L_RESTORE_SGPR
+
+L_RESTORE_VGPR_WAVE64:
+	s_mov_b32	s_restore_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
+
+	// VGPR load using dw burst
+	s_mov_b32	s_restore_mem_offset_save, s_restore_mem_offset		// restore start with v4, v0 will be the last
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 256*4
+	s_mov_b32	m0, 4							//VGPR initial index value = 4
+	s_cmp_lt_u32	m0, s_restore_alloc_size
+	s_cbranch_scc0	L_RESTORE_SHARED_VGPR
+
+L_RESTORE_VGPR_WAVE64_LOOP:
+	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS
+	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS offset:256
+	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS offset:256*2
+	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS offset:256*3
+	s_wait_idle
+	v_movreld_b32	v0, v0							//v[0+m0] = v0
+	v_movreld_b32	v1, v1
+	v_movreld_b32	v2, v2
+	v_movreld_b32	v3, v3
+	s_add_u32	m0, m0, 4						//next vgpr index
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 256*4	//every buffer_load_dword does 256 bytes
+	s_cmp_lt_u32	m0, s_restore_alloc_size				//scc = (m0 < s_restore_alloc_size) ? 1 : 0
+	s_cbranch_scc1	L_RESTORE_VGPR_WAVE64_LOOP				//VGPR restore (except v0) is complete?
+
+L_RESTORE_SHARED_VGPR:
+	s_getreg_b32	s_restore_alloc_size, hwreg(HW_REG_WAVE_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SHIFT,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE)	//shared_vgpr_size
+	s_and_b32	s_restore_alloc_size, s_restore_alloc_size, 0xFFFFFFFF	//shared_vgpr_size is zero?
+	s_cbranch_scc0	L_RESTORE_V0						//no shared_vgpr used?
+	s_lshl_b32	s_restore_alloc_size, s_restore_alloc_size, 3		//Number of SHARED_VGPRs = shared_vgpr_size * 8    (non-zero value)
+	//m0 now has the value of normal vgpr count, just add the m0 with shared_vgpr count to get the total count.
+	//restore shared_vgpr will start from the index of m0
+	s_add_u32	s_restore_alloc_size, s_restore_alloc_size, m0
+	s_mov_b32	exec_lo, 0xFFFFFFFF
+	s_mov_b32	exec_hi, 0x00000000
+L_RESTORE_SHARED_VGPR_WAVE64_LOOP:
+	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset scope:SCOPE_SYS
+	s_wait_idle
+	v_movreld_b32	v0, v0							//v[0+m0] = v0
+	s_add_u32	m0, m0, 1						//next vgpr index
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 128
+	s_cmp_lt_u32	m0, s_restore_alloc_size				//scc = (m0 < s_restore_alloc_size) ? 1 : 0
+	s_cbranch_scc1	L_RESTORE_SHARED_VGPR_WAVE64_LOOP			//VGPR restore (except v0) is complete?
+
+	s_mov_b32	exec_hi, 0xFFFFFFFF					//restore back exec_hi before restoring V0!!
+
+	/* VGPR restore on v0 */
+L_RESTORE_V0:
+	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS
+	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS offset:256
+	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS offset:256*2
+	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save scope:SCOPE_SYS offset:256*3
+	s_wait_idle
+
+	/* restore SGPRs */
+	//will be 2+8+16*6
+	// SGPR SR memory offset : size(VGPR)+size(SVGPR)
+L_RESTORE_SGPR:
+	get_vgpr_size_bytes(s_restore_mem_offset, s_restore_size)
+	get_svgpr_size_bytes(s_restore_tmp)
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, s_restore_tmp
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, get_sgpr_size_bytes()
+	s_sub_u32	s_restore_mem_offset, s_restore_mem_offset, 20*4	//s108~s127 is not saved
+
+	s_mov_b32	s_restore_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
+
+	s_mov_b32	m0, s_sgpr_save_num
+
+	read_4sgpr_from_mem(s0, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_wait_idle
+
+	s_sub_u32	m0, m0, 4						// Restore from S[0] to S[104]
+	s_nop		0							// hazard SALU M0=> S_MOVREL
+
+	s_movreld_b64	s0, s0							//s[0+m0] = s0
+	s_movreld_b64	s2, s2
+
+	read_8sgpr_from_mem(s0, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_wait_idle
+
+	s_sub_u32	m0, m0, 8						// Restore from S[0] to S[96]
+	s_nop		0							// hazard SALU M0=> S_MOVREL
+
+	s_movreld_b64	s0, s0							//s[0+m0] = s0
+	s_movreld_b64	s2, s2
+	s_movreld_b64	s4, s4
+	s_movreld_b64	s6, s6
+
+ L_RESTORE_SGPR_LOOP:
+	read_16sgpr_from_mem(s0, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_wait_idle
+
+	s_sub_u32	m0, m0, 16						// Restore from S[n] to S[0]
+	s_nop		0							// hazard SALU M0=> S_MOVREL
+
+	s_movreld_b64	s0, s0							//s[0+m0] = s0
+	s_movreld_b64	s2, s2
+	s_movreld_b64	s4, s4
+	s_movreld_b64	s6, s6
+	s_movreld_b64	s8, s8
+	s_movreld_b64	s10, s10
+	s_movreld_b64	s12, s12
+	s_movreld_b64	s14, s14
+
+	s_cmp_eq_u32	m0, 0							//scc = (m0 < s_sgpr_save_num) ? 1 : 0
+	s_cbranch_scc0	L_RESTORE_SGPR_LOOP
+
+	// s_barrier with STATE_PRIV.TRAP_AFTER_INST=1, STATUS.PRIV=1 incorrectly asserts debug exception.
+	// Clear DEBUG_EN before and restore MODE after the barrier.
+	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_MODE), 0
+
+	/* restore HW registers */
+L_RESTORE_HWREG:
+	// HWREG SR memory offset : size(VGPR)+size(SVGPR)+size(SGPR)
+	get_vgpr_size_bytes(s_restore_mem_offset, s_restore_size)
+	get_svgpr_size_bytes(s_restore_tmp)
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, s_restore_tmp
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, get_sgpr_size_bytes()
+
+	s_mov_b32	s_restore_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
+
+	// Restore s_restore_spi_init_hi before the saved value gets clobbered.
+	s_mov_b32 s_restore_spi_init_hi, s_restore_spi_init_hi_save
+
+	read_hwreg_from_mem(s_restore_m0, s_restore_buf_rsrc0, s_restore_mem_offset)
+	read_hwreg_from_mem(s_restore_pc_lo, s_restore_buf_rsrc0, s_restore_mem_offset)
+	read_hwreg_from_mem(s_restore_pc_hi, s_restore_buf_rsrc0, s_restore_mem_offset)
+	read_hwreg_from_mem(s_restore_exec_lo, s_restore_buf_rsrc0, s_restore_mem_offset)
+	read_hwreg_from_mem(s_restore_exec_hi, s_restore_buf_rsrc0, s_restore_mem_offset)
+	read_hwreg_from_mem(s_restore_state_priv, s_restore_buf_rsrc0, s_restore_mem_offset)
+	read_hwreg_from_mem(s_restore_excp_flag_priv, s_restore_buf_rsrc0, s_restore_mem_offset)
+	read_hwreg_from_mem(s_restore_xnack_mask, s_restore_buf_rsrc0, s_restore_mem_offset)
+	read_hwreg_from_mem(s_restore_mode, s_restore_buf_rsrc0, s_restore_mem_offset)
+	read_hwreg_from_mem(s_restore_flat_scratch, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_wait_idle
+
+	s_setreg_b32	hwreg(HW_REG_WAVE_SCRATCH_BASE_LO), s_restore_flat_scratch
+
+	read_hwreg_from_mem(s_restore_flat_scratch, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_wait_idle
+
+	s_setreg_b32	hwreg(HW_REG_WAVE_SCRATCH_BASE_HI), s_restore_flat_scratch
+
+	read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_wait_idle
+	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_USER), s_restore_tmp
+
+	read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_wait_idle
+	s_setreg_b32	hwreg(HW_REG_WAVE_TRAP_CTRL), s_restore_tmp
+
+	// Only the first wave needs to restore the workgroup barrier.
+	s_and_b32	s_restore_tmp, s_restore_spi_init_hi, S_RESTORE_SPI_INIT_FIRST_WAVE_MASK
+	s_cbranch_scc0	L_SKIP_BARRIER_RESTORE
+
+	// Skip over WAVE_STATUS, since there is no state to restore from it
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 4
+
+	read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_wait_idle
+
+	s_bitcmp1_b32	s_restore_tmp, BARRIER_STATE_VALID_OFFSET
+	s_cbranch_scc0	L_SKIP_BARRIER_RESTORE
+
+	// extract the saved signal count from s_restore_tmp
+	s_lshr_b32	s_restore_tmp, s_restore_tmp, BARRIER_STATE_SIGNAL_OFFSET
+
+	// We need to call s_barrier_signal repeatedly to restore the signal
+	// count of the work group barrier.  The member count is already
+	// initialized with the number of waves in the work group.
+L_BARRIER_RESTORE_LOOP:
+	s_and_b32	s_restore_tmp, s_restore_tmp, s_restore_tmp
+	s_cbranch_scc0	L_SKIP_BARRIER_RESTORE
+	s_barrier_signal	-1
+	s_add_i32	s_restore_tmp, s_restore_tmp, -1
+	s_branch	L_BARRIER_RESTORE_LOOP
+
+L_SKIP_BARRIER_RESTORE:
+
+	s_mov_b32	m0, s_restore_m0
+	s_mov_b32	exec_lo, s_restore_exec_lo
+	s_mov_b32	exec_hi, s_restore_exec_hi
+
+	// EXCP_FLAG_PRIV.SAVE_CONTEXT and HOST_TRAP may have changed.
+	// Only restore the other fields to avoid clobbering them.
+	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, 0, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_1_SIZE), s_restore_excp_flag_priv
+	s_lshr_b32	s_restore_excp_flag_priv, s_restore_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT
+	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SIZE), s_restore_excp_flag_priv
+	s_lshr_b32	s_restore_excp_flag_priv, s_restore_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT
+	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SIZE), s_restore_excp_flag_priv
+
+	s_setreg_b32	hwreg(HW_REG_WAVE_MODE), s_restore_mode
+
+	// Restore trap temporaries 4-11, 13 initialized by SPI debug dispatch logic
+	// ttmp SR memory offset : size(VGPR)+size(SVGPR)+size(SGPR)+0x40
+	get_vgpr_size_bytes(s_restore_ttmps_lo, s_restore_size)
+	get_svgpr_size_bytes(s_restore_ttmps_hi)
+	s_add_u32	s_restore_ttmps_lo, s_restore_ttmps_lo, s_restore_ttmps_hi
+	s_add_u32	s_restore_ttmps_lo, s_restore_ttmps_lo, get_sgpr_size_bytes()
+	s_add_u32	s_restore_ttmps_lo, s_restore_ttmps_lo, s_restore_buf_rsrc0
+	s_addc_u32	s_restore_ttmps_hi, s_restore_buf_rsrc1, 0x0
+	s_and_b32	s_restore_ttmps_hi, s_restore_ttmps_hi, 0xFFFF
+	s_load_dwordx4	[ttmp4, ttmp5, ttmp6, ttmp7], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x50 scope:SCOPE_SYS
+	s_load_dwordx4	[ttmp8, ttmp9, ttmp10, ttmp11], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x60 scope:SCOPE_SYS
+	s_load_dword	ttmp13, [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x74 scope:SCOPE_SYS
+	s_wait_idle
+
+	s_and_b32	s_restore_pc_hi, s_restore_pc_hi, 0x0000ffff		//pc[47:32] //Do it here in order not to affect STATUS
+	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
+	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
+
+	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV), s_restore_state_priv	// SCC is included, which is changed by previous salu
+
+	// Make barrier and LDS state visible to all waves in the group.
+	// STATE_PRIV.BARRIER_COMPLETE may change after this point.
+	s_barrier_signal	-2
+	s_barrier_wait	-2
+
+	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
+
+L_END_PGM:
+	// Make sure that no wave of the workgroup can exit the trap handler
+	// before the workgroup barrier state is saved.
+	s_barrier_signal	-2
+	s_barrier_wait	-2
+	s_endpgm_saved
+end
+
+function write_hwreg_to_v2(s)
+	// Copy into VGPR for later TCP store.
+	v_writelane_b32	v2, s, m0
+	s_add_u32	m0, m0, 0x1
+end
+
+
+function write_16sgpr_to_v2(s)
+	// Copy into VGPR for later TCP store.
+	for var sgpr_idx = 0; sgpr_idx < 16; sgpr_idx ++
+		v_writelane_b32	v2, s[sgpr_idx], ttmp13
+		s_add_u32	ttmp13, ttmp13, 0x1
+	end
+end
+
+function write_12sgpr_to_v2(s)
+	// Copy into VGPR for later TCP store.
+	for var sgpr_idx = 0; sgpr_idx < 12; sgpr_idx ++
+		v_writelane_b32	v2, s[sgpr_idx], ttmp13
+		s_add_u32	ttmp13, ttmp13, 0x1
+	end
+end
+
+function read_hwreg_from_mem(s, s_rsrc, s_mem_offset)
+	s_buffer_load_dword	s, s_rsrc, s_mem_offset scope:SCOPE_SYS
+	s_add_u32	s_mem_offset, s_mem_offset, 4
+end
+
+function read_16sgpr_from_mem(s, s_rsrc, s_mem_offset)
+	s_sub_u32	s_mem_offset, s_mem_offset, 4*16
+	s_buffer_load_dwordx16	s, s_rsrc, s_mem_offset scope:SCOPE_SYS
+end
+
+function read_8sgpr_from_mem(s, s_rsrc, s_mem_offset)
+	s_sub_u32	s_mem_offset, s_mem_offset, 4*8
+	s_buffer_load_dwordx8	s, s_rsrc, s_mem_offset scope:SCOPE_SYS
+end
+
+function read_4sgpr_from_mem(s, s_rsrc, s_mem_offset)
+	s_sub_u32	s_mem_offset, s_mem_offset, 4*4
+	s_buffer_load_dwordx4	s, s_rsrc, s_mem_offset scope:SCOPE_SYS
+end
+
+function get_vgpr_size_bytes(s_vgpr_size_byte, s_size)
+	s_getreg_b32	s_vgpr_size_byte, hwreg(HW_REG_WAVE_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
+	s_add_u32	s_vgpr_size_byte, s_vgpr_size_byte, 1
+	s_bitcmp1_b32	s_size, S_WAVE_SIZE
+	s_cbranch_scc1	L_ENABLE_SHIFT_W64
+	s_lshl_b32	s_vgpr_size_byte, s_vgpr_size_byte, (2+7)		//Number of VGPRs = (vgpr_size + 1) * 4 * 32 * 4   (non-zero value)
+	s_branch	L_SHIFT_DONE
+L_ENABLE_SHIFT_W64:
+	s_lshl_b32	s_vgpr_size_byte, s_vgpr_size_byte, (2+8)		//Number of VGPRs = (vgpr_size + 1) * 4 * 64 * 4   (non-zero value)
+L_SHIFT_DONE:
+end
+
+function get_svgpr_size_bytes(s_svgpr_size_byte)
+	s_getreg_b32	s_svgpr_size_byte, hwreg(HW_REG_WAVE_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SHIFT,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE)
+	s_lshl_b32	s_svgpr_size_byte, s_svgpr_size_byte, (3+7)
+end
+
+function get_sgpr_size_bytes
+	return 512
+end
+
+function get_hwreg_size_bytes
+	return 128
+end
+
+function get_wave_size2(s_reg)
+	s_getreg_b32	s_reg, hwreg(HW_REG_WAVE_STATUS,SQ_WAVE_STATUS_WAVE64_SHIFT,SQ_WAVE_STATUS_WAVE64_SIZE)
+	s_lshl_b32	s_reg, s_reg, S_WAVE_SIZE
+end
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index ab1132bc896a..d9955c5d2e5e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -174,7 +174,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN32)
 ###############################################################################
 # DCN35
 ###############################################################################
-CLK_MGR_DCN35 = dcn35_smu.o dcn35_clk_mgr.o
+CLK_MGR_DCN35 = dcn35_smu.o dcn351_clk_mgr.o dcn35_clk_mgr.o
 
 AMD_DAL_CLK_MGR_DCN35 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn35/,$(CLK_MGR_DCN35))
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 0e243f4344d0..4c3e58c730b1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -355,8 +355,11 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			BREAK_TO_DEBUGGER();
 			return NULL;
 		}
+		if (ctx->dce_version == DCN_VERSION_3_51)
+			dcn351_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
+		else
+			dcn35_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 
-		dcn35_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 		return &clk_mgr->base.base;
 	}
 	break;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index e93df3d6222e..bc123f1884da 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -50,12 +50,13 @@
 #include "link.h"
 
 #include "logger_types.h"
+
+
+#include "yellow_carp_offset.h"
 #undef DC_LOGGER
 #define DC_LOGGER \
 	clk_mgr->base.base.ctx->logger
 
-#include "yellow_carp_offset.h"
-
 #define regCLK1_CLK_PLL_REQ			0x0237
 #define regCLK1_CLK_PLL_REQ_BASE_IDX		0
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 29eff386505a..91d872d6d392 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -53,9 +53,6 @@
 
 
 #include "logger_types.h"
-#undef DC_LOGGER
-#define DC_LOGGER \
-	clk_mgr->base.base.ctx->logger
 
 
 #define MAX_INSTANCE                                        7
@@ -77,6 +74,9 @@ static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0,
 					{ { 0x0001B200, 0x0242DC00, 0, 0, 0, 0, 0, 0 } },
 					{ { 0x0001B400, 0x0242E000, 0, 0, 0, 0, 0, 0 } } } };
 
+#undef DC_LOGGER
+#define DC_LOGGER \
+	clk_mgr->base.base.ctx->logger
 #define regCLK1_CLK_PLL_REQ			0x0237
 #define regCLK1_CLK_PLL_REQ_BASE_IDX		0
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c
new file mode 100644
index 000000000000..6a6ae618650b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c
@@ -0,0 +1,140 @@
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "core_types.h"
+#include "dcn35_clk_mgr.h"
+
+#define DCN_BASE__INST0_SEG1 0x000000C0
+#define mmCLK1_CLK_PLL_REQ 0x16E37
+
+#define mmCLK1_CLK0_DFS_CNTL 0x16E69
+#define mmCLK1_CLK1_DFS_CNTL 0x16E6C
+#define mmCLK1_CLK2_DFS_CNTL 0x16E6F
+#define mmCLK1_CLK3_DFS_CNTL 0x16E72
+#define mmCLK1_CLK4_DFS_CNTL 0x16E75
+#define mmCLK1_CLK5_DFS_CNTL 0x16E78
+
+#define mmCLK1_CLK0_CURRENT_CNT 0x16EFC
+#define mmCLK1_CLK1_CURRENT_CNT 0x16EFD
+#define mmCLK1_CLK2_CURRENT_CNT 0x16EFE
+#define mmCLK1_CLK3_CURRENT_CNT 0x16EFF
+#define mmCLK1_CLK4_CURRENT_CNT 0x16F00
+#define mmCLK1_CLK5_CURRENT_CNT 0x16F01
+
+#define mmCLK1_CLK0_BYPASS_CNTL 0x16E8A
+#define mmCLK1_CLK1_BYPASS_CNTL 0x16E93
+#define mmCLK1_CLK2_BYPASS_CNTL 0x16E9C
+#define mmCLK1_CLK3_BYPASS_CNTL 0x16EA5
+#define mmCLK1_CLK4_BYPASS_CNTL 0x16EAE
+#define mmCLK1_CLK5_BYPASS_CNTL 0x16EB7
+
+#define mmCLK1_CLK0_DS_CNTL 0x16E83
+#define mmCLK1_CLK1_DS_CNTL 0x16E8C
+#define mmCLK1_CLK2_DS_CNTL 0x16E95
+#define mmCLK1_CLK3_DS_CNTL 0x16E9E
+#define mmCLK1_CLK4_DS_CNTL 0x16EA7
+#define mmCLK1_CLK5_DS_CNTL 0x16EB0
+
+#define mmCLK1_CLK0_ALLOW_DS 0x16E84
+#define mmCLK1_CLK1_ALLOW_DS 0x16E8D
+#define mmCLK1_CLK2_ALLOW_DS 0x16E96
+#define mmCLK1_CLK3_ALLOW_DS 0x16E9F
+#define mmCLK1_CLK4_ALLOW_DS 0x16EA8
+#define mmCLK1_CLK5_ALLOW_DS 0x16EB1
+
+#define mmCLK5_spll_field_8 0x1B04B
+#define mmDENTIST_DISPCLK_CNTL 0x0124
+#define regDENTIST_DISPCLK_CNTL 0x0064
+#define regDENTIST_DISPCLK_CNTL_BASE_IDX 1
+
+#define CLK1_CLK_PLL_REQ__FbMult_int__SHIFT 0x0
+#define CLK1_CLK_PLL_REQ__PllSpineDiv__SHIFT 0xc
+#define CLK1_CLK_PLL_REQ__FbMult_frac__SHIFT 0x10
+#define CLK1_CLK_PLL_REQ__FbMult_int_MASK 0x000001FFL
+#define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK 0x0000F000L
+#define CLK1_CLK_PLL_REQ__FbMult_frac_MASK 0xFFFF0000L
+
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK 0x00000007L
+
+// DENTIST_DISPCLK_CNTL
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_WDIVIDER__SHIFT 0x0
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_RDIVIDER__SHIFT 0x8
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_CHG_DONE__SHIFT 0x13
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_CHG_DONE__SHIFT 0x14
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_WDIVIDER__SHIFT 0x18
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_WDIVIDER_MASK 0x0000007FL
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_RDIVIDER_MASK 0x00007F00L
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_CHG_DONE_MASK 0x00080000L
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_CHG_DONE_MASK 0x00100000L
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_WDIVIDER_MASK 0x7F000000L
+
+#define CLK5_spll_field_8__spll_ssc_en_MASK 0x00002000L
+
+#define REG(reg) \
+	(clk_mgr->regs->reg)
+
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
+
+#define BASE(seg) BASE_INNER(seg)
+
+#define SR(reg_name)\
+		.reg_name = BASE(reg ## reg_name ## _BASE_IDX) +  \
+					reg ## reg_name
+
+#define CLK_SR_DCN35(reg_name)\
+	.reg_name = mm ## reg_name
+
+static const struct clk_mgr_registers clk_mgr_regs_dcn351 = {
+	CLK_REG_LIST_DCN35()
+};
+
+static const struct clk_mgr_shift clk_mgr_shift_dcn351 = {
+	CLK_COMMON_MASK_SH_LIST_DCN32(__SHIFT)
+};
+
+static const struct clk_mgr_mask clk_mgr_mask_dcn351 = {
+	CLK_COMMON_MASK_SH_LIST_DCN32(_MASK)
+};
+
+#define TO_CLK_MGR_DCN35(clk_mgr)\
+	container_of(clk_mgr, struct clk_mgr_dcn35, base)
+
+
+void dcn351_clk_mgr_construct(
+		struct dc_context *ctx,
+		struct clk_mgr_dcn35 *clk_mgr,
+		struct pp_smu_funcs *pp_smu,
+		struct dccg *dccg)
+{
+	/*register offset changed*/
+	clk_mgr->base.regs = &clk_mgr_regs_dcn351;
+	clk_mgr->base.clk_mgr_shift = &clk_mgr_shift_dcn351;
+	clk_mgr->base.clk_mgr_mask = &clk_mgr_mask_dcn351;
+
+	dcn35_clk_mgr_construct(ctx,  clk_mgr, pp_smu, dccg);
+
+}
+
+
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 3bd0d46c1701..7d0d8852ce8d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -36,15 +36,11 @@
 #include "dcn20/dcn20_clk_mgr.h"
 
 
-
-
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dcn35_smu.h"
 #include "dm_helpers.h"
 
-/* TODO: remove this include once we ported over remaining clk mgr functions*/
-#include "dcn30/dcn30_clk_mgr.h"
 #include "dcn31/dcn31_clk_mgr.h"
 
 #include "dc_dmub_srv.h"
@@ -55,34 +51,102 @@
 #define DC_LOGGER \
 	clk_mgr->base.base.ctx->logger
 
-#define regCLK1_CLK_PLL_REQ			0x0237
-#define regCLK1_CLK_PLL_REQ_BASE_IDX		0
+#define DCN_BASE__INST0_SEG1 0x000000C0
+#define mmCLK1_CLK_PLL_REQ 0x16E37
+
+#define mmCLK1_CLK0_DFS_CNTL 0x16E69
+#define mmCLK1_CLK1_DFS_CNTL 0x16E6C
+#define mmCLK1_CLK2_DFS_CNTL 0x16E6F
+#define mmCLK1_CLK3_DFS_CNTL 0x16E72
+#define mmCLK1_CLK4_DFS_CNTL 0x16E75
+#define mmCLK1_CLK5_DFS_CNTL 0x16E78
+
+#define mmCLK1_CLK0_CURRENT_CNT 0x16EFB
+#define mmCLK1_CLK1_CURRENT_CNT 0x16EFC
+#define mmCLK1_CLK2_CURRENT_CNT 0x16EFD
+#define mmCLK1_CLK3_CURRENT_CNT 0x16EFE
+#define mmCLK1_CLK4_CURRENT_CNT 0x16EFF
+#define mmCLK1_CLK5_CURRENT_CNT 0x16F00
+
+#define mmCLK1_CLK0_BYPASS_CNTL 0x16E8A
+#define mmCLK1_CLK1_BYPASS_CNTL 0x16E93
+#define mmCLK1_CLK2_BYPASS_CNTL 0x16E9C
+#define mmCLK1_CLK3_BYPASS_CNTL 0x16EA5
+#define mmCLK1_CLK4_BYPASS_CNTL 0x16EAE
+#define mmCLK1_CLK5_BYPASS_CNTL 0x16EB7
+
+#define mmCLK1_CLK0_DS_CNTL 0x16E83
+#define mmCLK1_CLK1_DS_CNTL 0x16E8C
+#define mmCLK1_CLK2_DS_CNTL 0x16E95
+#define mmCLK1_CLK3_DS_CNTL 0x16E9E
+#define mmCLK1_CLK4_DS_CNTL 0x16EA7
+#define mmCLK1_CLK5_DS_CNTL 0x16EB0
+
+#define mmCLK1_CLK0_ALLOW_DS 0x16E84
+#define mmCLK1_CLK1_ALLOW_DS 0x16E8D
+#define mmCLK1_CLK2_ALLOW_DS 0x16E96
+#define mmCLK1_CLK3_ALLOW_DS 0x16E9F
+#define mmCLK1_CLK4_ALLOW_DS 0x16EA8
+#define mmCLK1_CLK5_ALLOW_DS 0x16EB1
+
+#define mmCLK5_spll_field_8 0x1B24B
+#define mmDENTIST_DISPCLK_CNTL 0x0124
+#define regDENTIST_DISPCLK_CNTL 0x0064
+#define regDENTIST_DISPCLK_CNTL_BASE_IDX 1
+
+#define CLK1_CLK_PLL_REQ__FbMult_int__SHIFT 0x0
+#define CLK1_CLK_PLL_REQ__PllSpineDiv__SHIFT 0xc
+#define CLK1_CLK_PLL_REQ__FbMult_frac__SHIFT 0x10
+#define CLK1_CLK_PLL_REQ__FbMult_int_MASK 0x000001FFL
+#define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK 0x0000F000L
+#define CLK1_CLK_PLL_REQ__FbMult_frac_MASK 0xFFFF0000L
+
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK 0x00000007L
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV_MASK 0x000F0000L
+// DENTIST_DISPCLK_CNTL
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_WDIVIDER__SHIFT 0x0
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_RDIVIDER__SHIFT 0x8
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_CHG_DONE__SHIFT 0x13
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_CHG_DONE__SHIFT 0x14
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_WDIVIDER__SHIFT 0x18
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_WDIVIDER_MASK 0x0000007FL
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_RDIVIDER_MASK 0x00007F00L
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_CHG_DONE_MASK 0x00080000L
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_CHG_DONE_MASK 0x00100000L
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_WDIVIDER_MASK 0x7F000000L
+
+#define CLK5_spll_field_8__spll_ssc_en_MASK 0x00002000L
 
-#define CLK1_CLK_PLL_REQ__FbMult_int__SHIFT	0x0
-#define CLK1_CLK_PLL_REQ__PllSpineDiv__SHIFT	0xc
-#define CLK1_CLK_PLL_REQ__FbMult_frac__SHIFT	0x10
-#define CLK1_CLK_PLL_REQ__FbMult_int_MASK	0x000001FFL
-#define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK	0x0000F000L
-#define CLK1_CLK_PLL_REQ__FbMult_frac_MASK	0xFFFF0000L
+#define SMU_VER_THRESHOLD 0x5D4A00 //93.74.0
+#undef FN
+#define FN(reg_name, field_name) \
+	clk_mgr->clk_mgr_shift->field_name, clk_mgr->clk_mgr_mask->field_name
 
-#define regCLK1_CLK2_BYPASS_CNTL			0x029c
-#define regCLK1_CLK2_BYPASS_CNTL_BASE_IDX	0
+#define REG(reg) \
+	(clk_mgr->regs->reg)
 
-#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL__SHIFT	0x0
-#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV__SHIFT	0x10
-#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK		0x00000007L
-#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV_MASK		0x000F0000L
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
-#define regCLK5_0_CLK5_spll_field_8				0x464b
-#define regCLK5_0_CLK5_spll_field_8_BASE_IDX	0
+#define BASE(seg) BASE_INNER(seg)
 
-#define CLK5_0_CLK5_spll_field_8__spll_ssc_en__SHIFT	0xd
-#define CLK5_0_CLK5_spll_field_8__spll_ssc_en_MASK		0x00002000L
+#define SR(reg_name)\
+		.reg_name = BASE(reg ## reg_name ## _BASE_IDX) +  \
+					reg ## reg_name
 
-#define SMU_VER_THRESHOLD 0x5D4A00 //93.74.0
+#define CLK_SR_DCN35(reg_name)\
+	.reg_name = mm ## reg_name
 
-#define REG(reg_name) \
-	(ctx->clk_reg_offsets[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
+static const struct clk_mgr_registers clk_mgr_regs_dcn35 = {
+	CLK_REG_LIST_DCN35()
+};
+
+static const struct clk_mgr_shift clk_mgr_shift_dcn35 = {
+	CLK_COMMON_MASK_SH_LIST_DCN32(__SHIFT)
+};
+
+static const struct clk_mgr_mask clk_mgr_mask_dcn35 = {
+	CLK_COMMON_MASK_SH_LIST_DCN32(_MASK)
+};
 
 #define TO_CLK_MGR_DCN35(clk_mgr)\
 	container_of(clk_mgr, struct clk_mgr_dcn35, base)
@@ -443,7 +507,6 @@ static int get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
 	struct fixed31_32 pll_req;
 	unsigned int fbmult_frac_val = 0;
 	unsigned int fbmult_int_val = 0;
-	struct dc_context *ctx = clk_mgr->base.ctx;
 
 	/*
 	 * Register value of fbmult is in 8.16 format, we are converting to 314.32
@@ -503,12 +566,12 @@ static void dcn35_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 static bool dcn35_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct dc_context *ctx = clk_mgr->base.ctx;
+
 	uint32_t ssc_enable;
 
-	REG_GET(CLK5_0_CLK5_spll_field_8, spll_ssc_en, &ssc_enable);
+	ssc_enable = REG_READ(CLK5_spll_field_8) & CLK5_spll_field_8__spll_ssc_en_MASK;
 
-	return ssc_enable == 1;
+	return ssc_enable != 0;
 }
 
 static void init_clk_states(struct clk_mgr *clk_mgr)
@@ -633,10 +696,10 @@ static struct dcn35_ss_info_table ss_info_table = {
 
 static void dcn35_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
 {
-	struct dc_context *ctx = clk_mgr->base.ctx;
-	uint32_t clock_source;
+	uint32_t clock_source = 0;
+
+	clock_source = REG_READ(CLK1_CLK2_BYPASS_CNTL) & CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK;
 
-	REG_GET(CLK1_CLK2_BYPASS_CNTL, CLK2_BYPASS_SEL, &clock_source);
 	// If it's DFS mode, clock_source is 0.
 	if (dcn35_is_spll_ssc_enabled(&clk_mgr->base) && (clock_source < ARRAY_SIZE(ss_info_table.ss_percentage))) {
 		clk_mgr->dprefclk_ss_percentage = ss_info_table.ss_percentage[clock_source];
@@ -1106,6 +1169,12 @@ void dcn35_clk_mgr_construct(
 	clk_mgr->base.dprefclk_ss_divider = 1000;
 	clk_mgr->base.ss_on_dprefclk = false;
 	clk_mgr->base.dfs_ref_freq_khz = 48000;
+	if (ctx->dce_version == DCN_VERSION_3_5) {
+		clk_mgr->base.regs = &clk_mgr_regs_dcn35;
+		clk_mgr->base.clk_mgr_shift = &clk_mgr_shift_dcn35;
+		clk_mgr->base.clk_mgr_mask = &clk_mgr_mask_dcn35;
+	}
+
 
 	clk_mgr->smu_wm_set.wm_set = (struct dcn35_watermarks *)dm_helpers_allocate_gpu_mem(
 				clk_mgr->base.base.ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h
index 1203dc605b12..a12a9bf90806 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h
@@ -60,4 +60,8 @@ void dcn35_clk_mgr_construct(struct dc_context *ctx,
 
 void dcn35_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int);
 
+void dcn351_clk_mgr_construct(struct dc_context *ctx,
+		struct clk_mgr_dcn35 *clk_mgr,
+		struct pp_smu_funcs *pp_smu,
+		struct dccg *dccg);
 #endif //__DCN35_CLK_MGR_H__
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index c2dd061892f4..7a1ca1e98059 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -166,6 +166,41 @@ enum dentist_divider_range {
     CLK_SR_DCN32(CLK1_CLK4_CURRENT_CNT), \
     CLK_SR_DCN32(CLK4_CLK0_CURRENT_CNT)
 
+#define CLK_REG_LIST_DCN35()	  \
+	CLK_SR_DCN35(CLK1_CLK_PLL_REQ), \
+	CLK_SR_DCN35(CLK1_CLK0_DFS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK1_DFS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK2_DFS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK3_DFS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK4_DFS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK5_DFS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK0_CURRENT_CNT), \
+	CLK_SR_DCN35(CLK1_CLK1_CURRENT_CNT), \
+	CLK_SR_DCN35(CLK1_CLK2_CURRENT_CNT), \
+	CLK_SR_DCN35(CLK1_CLK3_CURRENT_CNT), \
+	CLK_SR_DCN35(CLK1_CLK4_CURRENT_CNT), \
+	CLK_SR_DCN35(CLK1_CLK5_CURRENT_CNT), \
+	CLK_SR_DCN35(CLK1_CLK0_BYPASS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK1_BYPASS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK2_BYPASS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK3_BYPASS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK4_BYPASS_CNTL),\
+	CLK_SR_DCN35(CLK1_CLK5_BYPASS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK0_DS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK1_DS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK2_DS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK3_DS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK4_DS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK5_DS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK0_ALLOW_DS), \
+	CLK_SR_DCN35(CLK1_CLK1_ALLOW_DS), \
+	CLK_SR_DCN35(CLK1_CLK2_ALLOW_DS), \
+	CLK_SR_DCN35(CLK1_CLK3_ALLOW_DS), \
+	CLK_SR_DCN35(CLK1_CLK4_ALLOW_DS), \
+	CLK_SR_DCN35(CLK1_CLK5_ALLOW_DS), \
+	CLK_SR_DCN35(CLK5_spll_field_8), \
+	SR(DENTIST_DISPCLK_CNTL), \
+
 #define CLK_COMMON_MASK_SH_LIST_DCN32(mask_sh) \
 	CLK_COMMON_MASK_SH_LIST_DCN20_BASE(mask_sh),\
 	CLK_SF(CLK1_CLK_PLL_REQ, FbMult_int, mask_sh),\
@@ -236,6 +271,7 @@ struct clk_mgr_registers {
 	uint32_t CLK1_CLK2_DFS_CNTL;
 	uint32_t CLK1_CLK3_DFS_CNTL;
 	uint32_t CLK1_CLK4_DFS_CNTL;
+	uint32_t CLK1_CLK5_DFS_CNTL;
 	uint32_t CLK2_CLK2_DFS_CNTL;
 
 	uint32_t CLK1_CLK0_CURRENT_CNT;
@@ -243,11 +279,34 @@ struct clk_mgr_registers {
     uint32_t CLK1_CLK2_CURRENT_CNT;
     uint32_t CLK1_CLK3_CURRENT_CNT;
     uint32_t CLK1_CLK4_CURRENT_CNT;
+	uint32_t CLK1_CLK5_CURRENT_CNT;
 
 	uint32_t CLK0_CLK0_DFS_CNTL;
 	uint32_t CLK0_CLK1_DFS_CNTL;
 	uint32_t CLK0_CLK3_DFS_CNTL;
 	uint32_t CLK0_CLK4_DFS_CNTL;
+	uint32_t CLK1_CLK0_BYPASS_CNTL;
+	uint32_t CLK1_CLK1_BYPASS_CNTL;
+	uint32_t CLK1_CLK2_BYPASS_CNTL;
+	uint32_t CLK1_CLK3_BYPASS_CNTL;
+	uint32_t CLK1_CLK4_BYPASS_CNTL;
+	uint32_t CLK1_CLK5_BYPASS_CNTL;
+
+	uint32_t CLK1_CLK0_DS_CNTL;
+	uint32_t CLK1_CLK1_DS_CNTL;
+	uint32_t CLK1_CLK2_DS_CNTL;
+	uint32_t CLK1_CLK3_DS_CNTL;
+	uint32_t CLK1_CLK4_DS_CNTL;
+	uint32_t CLK1_CLK5_DS_CNTL;
+
+	uint32_t CLK1_CLK0_ALLOW_DS;
+	uint32_t CLK1_CLK1_ALLOW_DS;
+	uint32_t CLK1_CLK2_ALLOW_DS;
+	uint32_t CLK1_CLK3_ALLOW_DS;
+	uint32_t CLK1_CLK4_ALLOW_DS;
+	uint32_t CLK1_CLK5_ALLOW_DS;
+	uint32_t CLK5_spll_field_8;
+
 };
 
 struct clk_mgr_shift {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index d78c8ec4de79..885e749cdc6e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -51,9 +51,10 @@
 #include "dc_dmub_srv.h"
 #include "gpio_service_interface.h"
 
+#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
+
 #define DC_LOGGER \
 	link->ctx->logger
-#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
 
 #ifndef MAX
 #define MAX(X, Y) ((X) > (Y) ? (X) : (Y))
diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index b1c294236cc8..2f1d9ce87ceb 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3363,7 +3363,7 @@ static void intel_enable_ddi_hdmi(struct intel_atomic_state *state,
 		intel_de_rmw(dev_priv, XELPDP_PORT_BUF_CTL1(dev_priv, port),
 			     XELPDP_PORT_WIDTH_MASK | XELPDP_PORT_REVERSAL, port_buf);
 
-		buf_ctl |= DDI_PORT_WIDTH(lane_count);
+		buf_ctl |= DDI_PORT_WIDTH(crtc_state->lane_count);
 
 		if (DISPLAY_VER(dev_priv) >= 20)
 			buf_ctl |= XE2LPD_DDI_BUF_D2D_LINK_ENABLE;
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index b4ef4d59da1a..2c6d0da8a16f 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -6369,12 +6369,30 @@ static int intel_async_flip_check_hw(struct intel_atomic_state *state, struct in
 static int intel_joiner_add_affected_crtcs(struct intel_atomic_state *state)
 {
 	struct drm_i915_private *i915 = to_i915(state->base.dev);
+	const struct intel_plane_state *plane_state;
 	struct intel_crtc_state *crtc_state;
+	struct intel_plane *plane;
 	struct intel_crtc *crtc;
 	u8 affected_pipes = 0;
 	u8 modeset_pipes = 0;
 	int i;
 
+	/*
+	 * Any plane which is in use by the joiner needs its crtc.
+	 * Pull those in first as this will not have happened yet
+	 * if the plane remains disabled according to uapi.
+	 */
+	for_each_new_intel_plane_in_state(state, plane, plane_state, i) {
+		crtc = to_intel_crtc(plane_state->hw.crtc);
+		if (!crtc)
+			continue;
+
+		crtc_state = intel_atomic_get_crtc_state(&state->base, crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+	}
+
+	/* Now pull in all joined crtcs */
 	for_each_new_intel_crtc_in_state(state, crtc, crtc_state, i) {
 		affected_pipes |= crtc_state->joiner_pipes;
 		if (intel_crtc_needs_modeset(crtc_state))
diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index 40bedc31d6bf..5d8f93d4cdc6 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -1561,7 +1561,7 @@ intel_dp_128b132b_link_train(struct intel_dp *intel_dp,
 
 	if (wait_for(intel_dp_128b132b_intra_hop(intel_dp, crtc_state) == 0, 500)) {
 		lt_err(intel_dp, DP_PHY_DPRX, "128b/132b intra-hop not clear\n");
-		return false;
+		goto out;
 	}
 
 	if (intel_dp_128b132b_lane_eq(intel_dp, crtc_state) &&
@@ -1573,6 +1573,19 @@ intel_dp_128b132b_link_train(struct intel_dp *intel_dp,
 	       passed ? "passed" : "failed",
 	       crtc_state->port_clock, crtc_state->lane_count);
 
+out:
+	/*
+	 * Ensure that the training pattern does get set to TPS2 even in case
+	 * of a failure, as is the case at the end of a passing link training
+	 * and what is expected by the transcoder. Leaving TPS1 set (and
+	 * disabling the link train mode in DP_TP_CTL later from TPS1 directly)
+	 * would result in a stuck transcoder HW state and flip-done timeouts
+	 * later in the modeset sequence.
+	 */
+	if (!passed)
+		intel_dp_program_link_training_pattern(intel_dp, crtc_state,
+						       DP_PHY_DPRX, DP_TRAINING_PATTERN_2);
+
 	return passed;
 }
 
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index b0e94c95940f..8aaadbb702df 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -3425,10 +3425,10 @@ static inline int guc_lrc_desc_unpin(struct intel_context *ce)
 	 */
 	ret = deregister_context(ce, ce->guc_id.id);
 	if (ret) {
-		spin_lock(&ce->guc_state.lock);
+		spin_lock_irqsave(&ce->guc_state.lock, flags);
 		set_context_registered(ce);
 		clr_context_destroyed(ce);
-		spin_unlock(&ce->guc_state.lock);
+		spin_unlock_irqrestore(&ce->guc_state.lock, flags);
 		/*
 		 * As gt-pm is awake at function entry, intel_wakeref_put_async merely decrements
 		 * the wakeref immediately but per function spec usage call this after unlock.
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 41f4350a7c6c..b7f521a9b337 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -3869,7 +3869,7 @@ enum skl_power_gate {
 #define  DDI_BUF_IS_IDLE			(1 << 7)
 #define  DDI_BUF_CTL_TC_PHY_OWNERSHIP		REG_BIT(6)
 #define  DDI_A_4_LANES				(1 << 4)
-#define  DDI_PORT_WIDTH(width)			(((width) - 1) << 1)
+#define  DDI_PORT_WIDTH(width)			(((width) == 3 ? 4 : ((width) - 1)) << 1)
 #define  DDI_PORT_WIDTH_MASK			(7 << 1)
 #define  DDI_PORT_WIDTH_SHIFT			1
 #define  DDI_INIT_DISPLAY_DETECTED		(1 << 0)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
index 421afacb7248..36cc9dbc00b5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
@@ -297,7 +297,7 @@ static const struct dpu_wb_cfg sm8150_wb[] = {
 	{
 		.name = "wb_2", .id = WB_2,
 		.base = 0x65000, .len = 0x2c8,
-		.features = WB_SDM845_MASK,
+		.features = WB_SM8250_MASK,
 		.format_list = wb2_formats_rgb,
 		.num_formats = ARRAY_SIZE(wb2_formats_rgb),
 		.clk_ctrl = DPU_CLK_CTRL_WB2,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
index 641023b102bf..e8eacdb47967 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
@@ -304,7 +304,7 @@ static const struct dpu_wb_cfg sc8180x_wb[] = {
 	{
 		.name = "wb_2", .id = WB_2,
 		.base = 0x65000, .len = 0x2c8,
-		.features = WB_SDM845_MASK,
+		.features = WB_SM8250_MASK,
 		.format_list = wb2_formats_rgb,
 		.num_formats = ARRAY_SIZE(wb2_formats_rgb),
 		.clk_ctrl = DPU_CLK_CTRL_WB2,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
index d039b96beb97..76f60a2df7a8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
@@ -144,7 +144,7 @@ static const struct dpu_wb_cfg sm6125_wb[] = {
 	{
 		.name = "wb_2", .id = WB_2,
 		.base = 0x65000, .len = 0x2c8,
-		.features = WB_SDM845_MASK,
+		.features = WB_SM8250_MASK,
 		.format_list = wb2_formats_rgb,
 		.num_formats = ARRAY_SIZE(wb2_formats_rgb),
 		.clk_ctrl = DPU_CLK_CTRL_WB2,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index bd3698bf0cf7..2cf8150adf81 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2125,6 +2125,9 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
 		}
 	}
 
+	if (phys_enc->hw_pp && phys_enc->hw_pp->ops.setup_dither)
+		phys_enc->hw_pp->ops.setup_dither(phys_enc->hw_pp, NULL);
+
 	/* reset the merge 3D HW block */
 	if (phys_enc->hw_pp && phys_enc->hw_pp->merge_3d) {
 		phys_enc->hw_pp->merge_3d->ops.setup_3d_mode(phys_enc->hw_pp->merge_3d,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
index 5e9aad1b2aa2..d1e0fb213976 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
@@ -52,6 +52,7 @@ static void dpu_hw_dsc_config(struct dpu_hw_dsc *hw_dsc,
 	u32 slice_last_group_size;
 	u32 det_thresh_flatness;
 	bool is_cmd_mode = !(mode & DSC_MODE_VIDEO);
+	bool input_10_bits = dsc->bits_per_component == 10;
 
 	DPU_REG_WRITE(c, DSC_COMMON_MODE, mode);
 
@@ -68,7 +69,7 @@ static void dpu_hw_dsc_config(struct dpu_hw_dsc *hw_dsc,
 	data |= (dsc->line_buf_depth << 3);
 	data |= (dsc->simple_422 << 2);
 	data |= (dsc->convert_rgb << 1);
-	data |= dsc->bits_per_component;
+	data |= input_10_bits;
 
 	DPU_REG_WRITE(c, DSC_ENC, data);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
index 0f40eea7f5e2..2040bee8d512 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
@@ -272,7 +272,7 @@ static void _setup_mdp_ops(struct dpu_hw_mdp_ops *ops,
 
 	if (cap & BIT(DPU_MDP_VSYNC_SEL))
 		ops->setup_vsync_source = dpu_hw_setup_vsync_sel;
-	else
+	else if (!(cap & BIT(DPU_MDP_PERIPH_0_REMOVED)))
 		ops->setup_vsync_source = dpu_hw_setup_wd_timer;
 
 	ops->get_safe_status = dpu_hw_get_safe_status;
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 031446c87dae..798168180c1a 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -83,6 +83,9 @@ struct dsi_pll_7nm {
 	/* protects REG_DSI_7nm_PHY_CMN_CLK_CFG0 register */
 	spinlock_t postdiv_lock;
 
+	/* protects REG_DSI_7nm_PHY_CMN_CLK_CFG1 register */
+	spinlock_t pclk_mux_lock;
+
 	struct pll_7nm_cached_state cached_state;
 
 	struct dsi_pll_7nm *slave;
@@ -372,22 +375,41 @@ static void dsi_pll_enable_pll_bias(struct dsi_pll_7nm *pll)
 	ndelay(250);
 }
 
-static void dsi_pll_disable_global_clk(struct dsi_pll_7nm *pll)
+static void dsi_pll_cmn_clk_cfg0_write(struct dsi_pll_7nm *pll, u32 val)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&pll->postdiv_lock, flags);
+	writel(val, pll->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG0);
+	spin_unlock_irqrestore(&pll->postdiv_lock, flags);
+}
+
+static void dsi_pll_cmn_clk_cfg1_update(struct dsi_pll_7nm *pll, u32 mask,
+					u32 val)
+{
+	unsigned long flags;
 	u32 data;
 
+	spin_lock_irqsave(&pll->pclk_mux_lock, flags);
 	data = readl(pll->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
-	writel(data & ~BIT(5), pll->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
+	data &= ~mask;
+	data |= val & mask;
+
+	writel(data, pll->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
+	spin_unlock_irqrestore(&pll->pclk_mux_lock, flags);
+}
+
+static void dsi_pll_disable_global_clk(struct dsi_pll_7nm *pll)
+{
+	dsi_pll_cmn_clk_cfg1_update(pll, DSI_7nm_PHY_CMN_CLK_CFG1_CLK_EN, 0);
 }
 
 static void dsi_pll_enable_global_clk(struct dsi_pll_7nm *pll)
 {
-	u32 data;
+	u32 cfg_1 = DSI_7nm_PHY_CMN_CLK_CFG1_CLK_EN | DSI_7nm_PHY_CMN_CLK_CFG1_CLK_EN_SEL;
 
 	writel(0x04, pll->phy->base + REG_DSI_7nm_PHY_CMN_CTRL_3);
-
-	data = readl(pll->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
-	writel(data | BIT(5) | BIT(4), pll->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
+	dsi_pll_cmn_clk_cfg1_update(pll, cfg_1, cfg_1);
 }
 
 static void dsi_pll_phy_dig_reset(struct dsi_pll_7nm *pll)
@@ -565,7 +587,6 @@ static int dsi_7nm_pll_restore_state(struct msm_dsi_phy *phy)
 {
 	struct dsi_pll_7nm *pll_7nm = to_pll_7nm(phy->vco_hw);
 	struct pll_7nm_cached_state *cached = &pll_7nm->cached_state;
-	void __iomem *phy_base = pll_7nm->phy->base;
 	u32 val;
 	int ret;
 
@@ -574,13 +595,10 @@ static int dsi_7nm_pll_restore_state(struct msm_dsi_phy *phy)
 	val |= cached->pll_out_div;
 	writel(val, pll_7nm->phy->pll_base + REG_DSI_7nm_PHY_PLL_PLL_OUTDIV_RATE);
 
-	writel(cached->bit_clk_div | (cached->pix_clk_div << 4),
-	       phy_base + REG_DSI_7nm_PHY_CMN_CLK_CFG0);
-
-	val = readl(phy_base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
-	val &= ~0x3;
-	val |= cached->pll_mux;
-	writel(val, phy_base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
+	dsi_pll_cmn_clk_cfg0_write(pll_7nm,
+				   DSI_7nm_PHY_CMN_CLK_CFG0_DIV_CTRL_3_0(cached->bit_clk_div) |
+				   DSI_7nm_PHY_CMN_CLK_CFG0_DIV_CTRL_7_4(cached->pix_clk_div));
+	dsi_pll_cmn_clk_cfg1_update(pll_7nm, 0x3, cached->pll_mux);
 
 	ret = dsi_pll_7nm_vco_set_rate(phy->vco_hw,
 			pll_7nm->vco_current_rate,
@@ -599,7 +617,6 @@ static int dsi_7nm_pll_restore_state(struct msm_dsi_phy *phy)
 static int dsi_7nm_set_usecase(struct msm_dsi_phy *phy)
 {
 	struct dsi_pll_7nm *pll_7nm = to_pll_7nm(phy->vco_hw);
-	void __iomem *base = phy->base;
 	u32 data = 0x0;	/* internal PLL */
 
 	DBG("DSI PLL%d", pll_7nm->phy->id);
@@ -618,7 +635,8 @@ static int dsi_7nm_set_usecase(struct msm_dsi_phy *phy)
 	}
 
 	/* set PLL src */
-	writel(data << 2, base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
+	dsi_pll_cmn_clk_cfg1_update(pll_7nm, DSI_7nm_PHY_CMN_CLK_CFG1_BITCLK_SEL__MASK,
+				    DSI_7nm_PHY_CMN_CLK_CFG1_BITCLK_SEL(data));
 
 	return 0;
 }
@@ -733,7 +751,7 @@ static int pll_7nm_register(struct dsi_pll_7nm *pll_7nm, struct clk_hw **provide
 					pll_by_2_bit,
 				}), 2, 0, pll_7nm->phy->base +
 					REG_DSI_7nm_PHY_CMN_CLK_CFG1,
-				0, 1, 0, NULL);
+				0, 1, 0, &pll_7nm->pclk_mux_lock);
 		if (IS_ERR(hw)) {
 			ret = PTR_ERR(hw);
 			goto fail;
@@ -778,6 +796,7 @@ static int dsi_pll_7nm_init(struct msm_dsi_phy *phy)
 	pll_7nm_list[phy->id] = pll_7nm;
 
 	spin_lock_init(&pll_7nm->postdiv_lock);
+	spin_lock_init(&pll_7nm->pclk_mux_lock);
 
 	pll_7nm->phy = phy;
 
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 2e28a1344636..9526b22038ab 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -543,15 +543,12 @@ static inline int align_pitch(int width, int bpp)
 static inline unsigned long timeout_to_jiffies(const ktime_t *timeout)
 {
 	ktime_t now = ktime_get();
-	s64 remaining_jiffies;
 
-	if (ktime_compare(*timeout, now) < 0) {
-		remaining_jiffies = 0;
-	} else {
-		ktime_t rem = ktime_sub(*timeout, now);
-		remaining_jiffies = ktime_divns(rem, NSEC_PER_SEC / HZ);
-	}
+	if (ktime_compare(*timeout, now) <= 0)
+		return 0;
 
+	ktime_t rem = ktime_sub(*timeout, now);
+	s64 remaining_jiffies = ktime_divns(rem, NSEC_PER_SEC / HZ);
 	return clamp(remaining_jiffies, 1LL, (s64)INT_MAX);
 }
 
diff --git a/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml b/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
index d54b72f92449..35f7f40e405b 100644
--- a/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
+++ b/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
@@ -9,8 +9,15 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x00004" name="REVISION_ID1"/>
 	<reg32 offset="0x00008" name="REVISION_ID2"/>
 	<reg32 offset="0x0000c" name="REVISION_ID3"/>
-	<reg32 offset="0x00010" name="CLK_CFG0"/>
-	<reg32 offset="0x00014" name="CLK_CFG1"/>
+	<reg32 offset="0x00010" name="CLK_CFG0">
+		<bitfield name="DIV_CTRL_3_0" low="0" high="3" type="uint"/>
+		<bitfield name="DIV_CTRL_7_4" low="4" high="7" type="uint"/>
+	</reg32>
+	<reg32 offset="0x00014" name="CLK_CFG1">
+		<bitfield name="CLK_EN" pos="5" type="boolean"/>
+		<bitfield name="CLK_EN_SEL" pos="4" type="boolean"/>
+		<bitfield name="BITCLK_SEL" low="2" high="3" type="uint"/>
+	</reg32>
 	<reg32 offset="0x00018" name="GLBL_CTRL"/>
 	<reg32 offset="0x0001c" name="RBUF_CTRL"/>
 	<reg32 offset="0x00020" name="VREG_CTRL_0"/>
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index b4da82ddbb6b..8ea98f06d39a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -590,6 +590,7 @@ static int nouveau_atomic_range_fault(struct nouveau_svmm *svmm,
 	unsigned long timeout =
 		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 	struct mm_struct *mm = svmm->notifier.mm;
+	struct folio *folio;
 	struct page *page;
 	unsigned long start = args->p.addr;
 	unsigned long notifier_seq;
@@ -616,12 +617,16 @@ static int nouveau_atomic_range_fault(struct nouveau_svmm *svmm,
 			ret = -EINVAL;
 			goto out;
 		}
+		folio = page_folio(page);
 
 		mutex_lock(&svmm->mutex);
 		if (!mmu_interval_read_retry(&notifier->notifier,
 					     notifier_seq))
 			break;
 		mutex_unlock(&svmm->mutex);
+
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 
 	/* Map the page on the GPU. */
@@ -637,8 +642,8 @@ static int nouveau_atomic_range_fault(struct nouveau_svmm *svmm,
 	ret = nvif_object_ioctl(&svmm->vmm->vmm.object, args, size, NULL);
 	mutex_unlock(&svmm->mutex);
 
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 out:
 	mmu_interval_notifier_remove(&notifier->notifier);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c
index a6f410ba60bc..d393bc540f86 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c
@@ -75,7 +75,7 @@ gp10b_pmu_acr = {
 	.bootstrap_multiple_falcons = gp10b_pmu_acr_bootstrap_multiple_falcons,
 };
 
-#if IS_ENABLED(CONFIG_ARCH_TEGRA_210_SOC)
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
 MODULE_FIRMWARE("nvidia/gp10b/pmu/desc.bin");
 MODULE_FIRMWARE("nvidia/gp10b/pmu/image.bin");
 MODULE_FIRMWARE("nvidia/gp10b/pmu/sig.bin");
diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 45d09e6fa667..7d68a8acfe2e 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -109,13 +109,13 @@ static int jadard_prepare(struct drm_panel *panel)
 	if (jadard->desc->lp11_to_reset_delay_ms)
 		msleep(jadard->desc->lp11_to_reset_delay_ms);
 
-	gpiod_set_value(jadard->reset, 1);
+	gpiod_set_value(jadard->reset, 0);
 	msleep(5);
 
-	gpiod_set_value(jadard->reset, 0);
+	gpiod_set_value(jadard->reset, 1);
 	msleep(10);
 
-	gpiod_set_value(jadard->reset, 1);
+	gpiod_set_value(jadard->reset, 0);
 	msleep(130);
 
 	ret = jadard->desc->init(jadard);
@@ -1130,7 +1130,7 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->format = desc->format;
 	dsi->lanes = desc->lanes;
 
-	jadard->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	jadard->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(jadard->reset)) {
 		DRM_DEV_ERROR(&dsi->dev, "failed to get our reset GPIO\n");
 		return PTR_ERR(jadard->reset);
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 6fc00d63b285..e6744422dee4 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -36,11 +36,17 @@
 #include "xe_pm.h"
 #include "xe_sched_job.h"
 #include "xe_sriov.h"
+#include "xe_sync.h"
 
 #define DEFAULT_POLL_FREQUENCY_HZ 200
 #define DEFAULT_POLL_PERIOD_NS (NSEC_PER_SEC / DEFAULT_POLL_FREQUENCY_HZ)
 #define XE_OA_UNIT_INVALID U32_MAX
 
+enum xe_oa_submit_deps {
+	XE_OA_SUBMIT_NO_DEPS,
+	XE_OA_SUBMIT_ADD_DEPS,
+};
+
 struct xe_oa_reg {
 	struct xe_reg addr;
 	u32 value;
@@ -63,13 +69,8 @@ struct xe_oa_config {
 	struct rcu_head rcu;
 };
 
-struct flex {
-	struct xe_reg reg;
-	u32 offset;
-	u32 value;
-};
-
 struct xe_oa_open_param {
+	struct xe_file *xef;
 	u32 oa_unit_id;
 	bool sample;
 	u32 metric_set;
@@ -81,6 +82,9 @@ struct xe_oa_open_param {
 	struct xe_exec_queue *exec_q;
 	struct xe_hw_engine *hwe;
 	bool no_preempt;
+	struct drm_xe_sync __user *syncs_user;
+	int num_syncs;
+	struct xe_sync_entry *syncs;
 };
 
 struct xe_oa_config_bo {
@@ -567,32 +571,60 @@ static __poll_t xe_oa_poll(struct file *file, poll_table *wait)
 	return ret;
 }
 
-static int xe_oa_submit_bb(struct xe_oa_stream *stream, struct xe_bb *bb)
+static void xe_oa_lock_vma(struct xe_exec_queue *q)
+{
+	if (q->vm) {
+		down_read(&q->vm->lock);
+		xe_vm_lock(q->vm, false);
+	}
+}
+
+static void xe_oa_unlock_vma(struct xe_exec_queue *q)
 {
+	if (q->vm) {
+		xe_vm_unlock(q->vm);
+		up_read(&q->vm->lock);
+	}
+}
+
+static struct dma_fence *xe_oa_submit_bb(struct xe_oa_stream *stream, enum xe_oa_submit_deps deps,
+					 struct xe_bb *bb)
+{
+	struct xe_exec_queue *q = stream->exec_q ?: stream->k_exec_q;
 	struct xe_sched_job *job;
 	struct dma_fence *fence;
-	long timeout;
 	int err = 0;
 
-	/* Kernel configuration is issued on stream->k_exec_q, not stream->exec_q */
-	job = xe_bb_create_job(stream->k_exec_q, bb);
+	xe_oa_lock_vma(q);
+
+	job = xe_bb_create_job(q, bb);
 	if (IS_ERR(job)) {
 		err = PTR_ERR(job);
 		goto exit;
 	}
+	job->ggtt = true;
+
+	if (deps == XE_OA_SUBMIT_ADD_DEPS) {
+		for (int i = 0; i < stream->num_syncs && !err; i++)
+			err = xe_sync_entry_add_deps(&stream->syncs[i], job);
+		if (err) {
+			drm_dbg(&stream->oa->xe->drm, "xe_sync_entry_add_deps err %d\n", err);
+			goto err_put_job;
+		}
+	}
 
 	xe_sched_job_arm(job);
 	fence = dma_fence_get(&job->drm.s_fence->finished);
 	xe_sched_job_push(job);
 
-	timeout = dma_fence_wait_timeout(fence, false, HZ);
-	dma_fence_put(fence);
-	if (timeout < 0)
-		err = timeout;
-	else if (!timeout)
-		err = -ETIME;
+	xe_oa_unlock_vma(q);
+
+	return fence;
+err_put_job:
+	xe_sched_job_put(job);
 exit:
-	return err;
+	xe_oa_unlock_vma(q);
+	return ERR_PTR(err);
 }
 
 static void write_cs_mi_lri(struct xe_bb *bb, const struct xe_oa_reg *reg_data, u32 n_regs)
@@ -639,54 +671,30 @@ static void xe_oa_free_configs(struct xe_oa_stream *stream)
 		free_oa_config_bo(oa_bo);
 }
 
-static void xe_oa_store_flex(struct xe_oa_stream *stream, struct xe_lrc *lrc,
-			     struct xe_bb *bb, const struct flex *flex, u32 count)
-{
-	u32 offset = xe_bo_ggtt_addr(lrc->bo);
-
-	do {
-		bb->cs[bb->len++] = MI_STORE_DATA_IMM | MI_SDI_GGTT | MI_SDI_NUM_DW(1);
-		bb->cs[bb->len++] = offset + flex->offset * sizeof(u32);
-		bb->cs[bb->len++] = 0;
-		bb->cs[bb->len++] = flex->value;
-
-	} while (flex++, --count);
-}
-
-static int xe_oa_modify_ctx_image(struct xe_oa_stream *stream, struct xe_lrc *lrc,
-				  const struct flex *flex, u32 count)
+static int xe_oa_load_with_lri(struct xe_oa_stream *stream, struct xe_oa_reg *reg_lri, u32 count)
 {
+	struct dma_fence *fence;
 	struct xe_bb *bb;
 	int err;
 
-	bb = xe_bb_new(stream->gt, 4 * count, false);
+	bb = xe_bb_new(stream->gt, 2 * count + 1, false);
 	if (IS_ERR(bb)) {
 		err = PTR_ERR(bb);
 		goto exit;
 	}
 
-	xe_oa_store_flex(stream, lrc, bb, flex, count);
-
-	err = xe_oa_submit_bb(stream, bb);
-	xe_bb_free(bb, NULL);
-exit:
-	return err;
-}
-
-static int xe_oa_load_with_lri(struct xe_oa_stream *stream, struct xe_oa_reg *reg_lri)
-{
-	struct xe_bb *bb;
-	int err;
+	write_cs_mi_lri(bb, reg_lri, count);
 
-	bb = xe_bb_new(stream->gt, 3, false);
-	if (IS_ERR(bb)) {
-		err = PTR_ERR(bb);
-		goto exit;
+	fence = xe_oa_submit_bb(stream, XE_OA_SUBMIT_NO_DEPS, bb);
+	if (IS_ERR(fence)) {
+		err = PTR_ERR(fence);
+		goto free_bb;
 	}
+	xe_bb_free(bb, fence);
+	dma_fence_put(fence);
 
-	write_cs_mi_lri(bb, reg_lri, 1);
-
-	err = xe_oa_submit_bb(stream, bb);
+	return 0;
+free_bb:
 	xe_bb_free(bb, NULL);
 exit:
 	return err;
@@ -695,70 +703,54 @@ static int xe_oa_load_with_lri(struct xe_oa_stream *stream, struct xe_oa_reg *re
 static int xe_oa_configure_oar_context(struct xe_oa_stream *stream, bool enable)
 {
 	const struct xe_oa_format *format = stream->oa_buffer.format;
-	struct xe_lrc *lrc = stream->exec_q->lrc[0];
-	u32 regs_offset = xe_lrc_regs_offset(lrc) / sizeof(u32);
 	u32 oacontrol = __format_to_oactrl(format, OAR_OACONTROL_COUNTER_SEL_MASK) |
 		(enable ? OAR_OACONTROL_COUNTER_ENABLE : 0);
 
-	struct flex regs_context[] = {
+	struct xe_oa_reg reg_lri[] = {
 		{
 			OACTXCONTROL(stream->hwe->mmio_base),
-			stream->oa->ctx_oactxctrl_offset[stream->hwe->class] + 1,
 			enable ? OA_COUNTER_RESUME : 0,
 		},
+		{
+			OAR_OACONTROL,
+			oacontrol,
+		},
 		{
 			RING_CONTEXT_CONTROL(stream->hwe->mmio_base),
-			regs_offset + CTX_CONTEXT_CONTROL,
-			_MASKED_BIT_ENABLE(CTX_CTRL_OAC_CONTEXT_ENABLE),
+			_MASKED_FIELD(CTX_CTRL_OAC_CONTEXT_ENABLE,
+				      enable ? CTX_CTRL_OAC_CONTEXT_ENABLE : 0)
 		},
 	};
-	struct xe_oa_reg reg_lri = { OAR_OACONTROL, oacontrol };
-	int err;
 
-	/* Modify stream hwe context image with regs_context */
-	err = xe_oa_modify_ctx_image(stream, stream->exec_q->lrc[0],
-				     regs_context, ARRAY_SIZE(regs_context));
-	if (err)
-		return err;
-
-	/* Apply reg_lri using LRI */
-	return xe_oa_load_with_lri(stream, &reg_lri);
+	return xe_oa_load_with_lri(stream, reg_lri, ARRAY_SIZE(reg_lri));
 }
 
 static int xe_oa_configure_oac_context(struct xe_oa_stream *stream, bool enable)
 {
 	const struct xe_oa_format *format = stream->oa_buffer.format;
-	struct xe_lrc *lrc = stream->exec_q->lrc[0];
-	u32 regs_offset = xe_lrc_regs_offset(lrc) / sizeof(u32);
 	u32 oacontrol = __format_to_oactrl(format, OAR_OACONTROL_COUNTER_SEL_MASK) |
 		(enable ? OAR_OACONTROL_COUNTER_ENABLE : 0);
-	struct flex regs_context[] = {
+	struct xe_oa_reg reg_lri[] = {
 		{
 			OACTXCONTROL(stream->hwe->mmio_base),
-			stream->oa->ctx_oactxctrl_offset[stream->hwe->class] + 1,
 			enable ? OA_COUNTER_RESUME : 0,
 		},
+		{
+			OAC_OACONTROL,
+			oacontrol
+		},
 		{
 			RING_CONTEXT_CONTROL(stream->hwe->mmio_base),
-			regs_offset + CTX_CONTEXT_CONTROL,
-			_MASKED_BIT_ENABLE(CTX_CTRL_OAC_CONTEXT_ENABLE) |
+			_MASKED_FIELD(CTX_CTRL_OAC_CONTEXT_ENABLE,
+				      enable ? CTX_CTRL_OAC_CONTEXT_ENABLE : 0) |
 			_MASKED_FIELD(CTX_CTRL_RUN_ALONE, enable ? CTX_CTRL_RUN_ALONE : 0),
 		},
 	};
-	struct xe_oa_reg reg_lri = { OAC_OACONTROL, oacontrol };
-	int err;
 
 	/* Set ccs select to enable programming of OAC_OACONTROL */
 	xe_mmio_write32(stream->gt, __oa_regs(stream)->oa_ctrl, __oa_ccs_select(stream));
 
-	/* Modify stream hwe context image with regs_context */
-	err = xe_oa_modify_ctx_image(stream, stream->exec_q->lrc[0],
-				     regs_context, ARRAY_SIZE(regs_context));
-	if (err)
-		return err;
-
-	/* Apply reg_lri using LRI */
-	return xe_oa_load_with_lri(stream, &reg_lri);
+	return xe_oa_load_with_lri(stream, reg_lri, ARRAY_SIZE(reg_lri));
 }
 
 static int xe_oa_configure_oa_context(struct xe_oa_stream *stream, bool enable)
@@ -914,15 +906,32 @@ static int xe_oa_emit_oa_config(struct xe_oa_stream *stream, struct xe_oa_config
 {
 #define NOA_PROGRAM_ADDITIONAL_DELAY_US 500
 	struct xe_oa_config_bo *oa_bo;
-	int err, us = NOA_PROGRAM_ADDITIONAL_DELAY_US;
+	int err = 0, us = NOA_PROGRAM_ADDITIONAL_DELAY_US;
+	struct dma_fence *fence;
+	long timeout;
 
+	/* Emit OA configuration batch */
 	oa_bo = xe_oa_alloc_config_buffer(stream, config);
 	if (IS_ERR(oa_bo)) {
 		err = PTR_ERR(oa_bo);
 		goto exit;
 	}
 
-	err = xe_oa_submit_bb(stream, oa_bo->bb);
+	fence = xe_oa_submit_bb(stream, XE_OA_SUBMIT_ADD_DEPS, oa_bo->bb);
+	if (IS_ERR(fence)) {
+		err = PTR_ERR(fence);
+		goto exit;
+	}
+
+	/* Wait till all previous batches have executed */
+	timeout = dma_fence_wait_timeout(fence, false, 5 * HZ);
+	dma_fence_put(fence);
+	if (timeout < 0)
+		err = timeout;
+	else if (!timeout)
+		err = -ETIME;
+	if (err)
+		drm_dbg(&stream->oa->xe->drm, "dma_fence_wait_timeout err %d\n", err);
 
 	/* Additional empirical delay needed for NOA programming after registers are written */
 	usleep_range(us, 2 * us);
@@ -1362,6 +1371,9 @@ static int xe_oa_stream_init(struct xe_oa_stream *stream,
 	stream->period_exponent = param->period_exponent;
 	stream->no_preempt = param->no_preempt;
 
+	stream->num_syncs = param->num_syncs;
+	stream->syncs = param->syncs;
+
 	/*
 	 * For Xe2+, when overrun mode is enabled, there are no partial reports at the end
 	 * of buffer, making the OA buffer effectively a non-power-of-2 size circular
@@ -1712,6 +1724,20 @@ static int xe_oa_set_no_preempt(struct xe_oa *oa, u64 value,
 	return 0;
 }
 
+static int xe_oa_set_prop_num_syncs(struct xe_oa *oa, u64 value,
+				    struct xe_oa_open_param *param)
+{
+	param->num_syncs = value;
+	return 0;
+}
+
+static int xe_oa_set_prop_syncs_user(struct xe_oa *oa, u64 value,
+				     struct xe_oa_open_param *param)
+{
+	param->syncs_user = u64_to_user_ptr(value);
+	return 0;
+}
+
 typedef int (*xe_oa_set_property_fn)(struct xe_oa *oa, u64 value,
 				     struct xe_oa_open_param *param);
 static const xe_oa_set_property_fn xe_oa_set_property_funcs[] = {
@@ -1724,6 +1750,8 @@ static const xe_oa_set_property_fn xe_oa_set_property_funcs[] = {
 	[DRM_XE_OA_PROPERTY_EXEC_QUEUE_ID] = xe_oa_set_prop_exec_queue_id,
 	[DRM_XE_OA_PROPERTY_OA_ENGINE_INSTANCE] = xe_oa_set_prop_engine_instance,
 	[DRM_XE_OA_PROPERTY_NO_PREEMPT] = xe_oa_set_no_preempt,
+	[DRM_XE_OA_PROPERTY_NUM_SYNCS] = xe_oa_set_prop_num_syncs,
+	[DRM_XE_OA_PROPERTY_SYNCS] = xe_oa_set_prop_syncs_user,
 };
 
 static int xe_oa_user_ext_set_property(struct xe_oa *oa, u64 extension,
@@ -1783,6 +1811,49 @@ static int xe_oa_user_extensions(struct xe_oa *oa, u64 extension, int ext_number
 	return 0;
 }
 
+static int xe_oa_parse_syncs(struct xe_oa *oa, struct xe_oa_open_param *param)
+{
+	int ret, num_syncs, num_ufence = 0;
+
+	if (param->num_syncs && !param->syncs_user) {
+		drm_dbg(&oa->xe->drm, "num_syncs specified without sync array\n");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (param->num_syncs) {
+		param->syncs = kcalloc(param->num_syncs, sizeof(*param->syncs), GFP_KERNEL);
+		if (!param->syncs) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+	}
+
+	for (num_syncs = 0; num_syncs < param->num_syncs; num_syncs++) {
+		ret = xe_sync_entry_parse(oa->xe, param->xef, &param->syncs[num_syncs],
+					  &param->syncs_user[num_syncs], 0);
+		if (ret)
+			goto err_syncs;
+
+		if (xe_sync_is_ufence(&param->syncs[num_syncs]))
+			num_ufence++;
+	}
+
+	if (XE_IOCTL_DBG(oa->xe, num_ufence > 1)) {
+		ret = -EINVAL;
+		goto err_syncs;
+	}
+
+	return 0;
+
+err_syncs:
+	while (num_syncs--)
+		xe_sync_entry_cleanup(&param->syncs[num_syncs]);
+	kfree(param->syncs);
+exit:
+	return ret;
+}
+
 /**
  * xe_oa_stream_open_ioctl - Opens an OA stream
  * @dev: @drm_device
@@ -1808,6 +1879,7 @@ int xe_oa_stream_open_ioctl(struct drm_device *dev, u64 data, struct drm_file *f
 		return -ENODEV;
 	}
 
+	param.xef = xef;
 	ret = xe_oa_user_extensions(oa, data, 0, &param);
 	if (ret)
 		return ret;
@@ -1817,8 +1889,8 @@ int xe_oa_stream_open_ioctl(struct drm_device *dev, u64 data, struct drm_file *f
 		if (XE_IOCTL_DBG(oa->xe, !param.exec_q))
 			return -ENOENT;
 
-		if (param.exec_q->width > 1)
-			drm_dbg(&oa->xe->drm, "exec_q->width > 1, programming only exec_q->lrc[0]\n");
+		if (XE_IOCTL_DBG(oa->xe, param.exec_q->width > 1))
+			return -EOPNOTSUPP;
 	}
 
 	/*
@@ -1876,11 +1948,24 @@ int xe_oa_stream_open_ioctl(struct drm_device *dev, u64 data, struct drm_file *f
 		drm_dbg(&oa->xe->drm, "Using periodic sampling freq %lld Hz\n", oa_freq_hz);
 	}
 
+	ret = xe_oa_parse_syncs(oa, &param);
+	if (ret)
+		goto err_exec_q;
+
 	mutex_lock(&param.hwe->gt->oa.gt_lock);
 	ret = xe_oa_stream_open_ioctl_locked(oa, &param);
 	mutex_unlock(&param.hwe->gt->oa.gt_lock);
+	if (ret < 0)
+		goto err_sync_cleanup;
+
+	return ret;
+
+err_sync_cleanup:
+	while (param.num_syncs--)
+		xe_sync_entry_cleanup(&param.syncs[param.num_syncs]);
+	kfree(param.syncs);
 err_exec_q:
-	if (ret < 0 && param.exec_q)
+	if (param.exec_q)
 		xe_exec_queue_put(param.exec_q);
 	return ret;
 }
diff --git a/drivers/gpu/drm/xe/xe_oa_types.h b/drivers/gpu/drm/xe/xe_oa_types.h
index 8862eca73fbe..99f4b2d4bdcf 100644
--- a/drivers/gpu/drm/xe/xe_oa_types.h
+++ b/drivers/gpu/drm/xe/xe_oa_types.h
@@ -238,5 +238,11 @@ struct xe_oa_stream {
 
 	/** @no_preempt: Whether preemption and timeslicing is disabled for stream exec_q */
 	u32 no_preempt;
+
+	/** @num_syncs: size of @syncs array */
+	u32 num_syncs;
+
+	/** @syncs: syncs to wait on and to signal */
+	struct xe_sync_entry *syncs;
 };
 #endif
diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index 1c96375bd7df..6fec5d1a1eb4 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -679,7 +679,7 @@ static int query_oa_units(struct xe_device *xe,
 			du->oa_unit_id = u->oa_unit_id;
 			du->oa_unit_type = u->type;
 			du->oa_timestamp_freq = xe_oa_timestamp_frequency(gt);
-			du->capabilities = DRM_XE_OA_CAPS_BASE;
+			du->capabilities = DRM_XE_OA_CAPS_BASE | DRM_XE_OA_CAPS_SYNCS;
 
 			j = 0;
 			for_each_hw_engine(hwe, gt, hwe_id) {
diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/xe_ring_ops.c
index 0be4f489d3e1..9f327f27c072 100644
--- a/drivers/gpu/drm/xe/xe_ring_ops.c
+++ b/drivers/gpu/drm/xe/xe_ring_ops.c
@@ -221,7 +221,10 @@ static int emit_pipe_imm_ggtt(u32 addr, u32 value, bool stall_only, u32 *dw,
 
 static u32 get_ppgtt_flag(struct xe_sched_job *job)
 {
-	return job->q->vm ? BIT(8) : 0;
+	if (job->q->vm && !job->ggtt)
+		return BIT(8);
+
+	return 0;
 }
 
 static int emit_copy_timestamp(struct xe_lrc *lrc, u32 *dw, int i)
diff --git a/drivers/gpu/drm/xe/xe_sched_job_types.h b/drivers/gpu/drm/xe/xe_sched_job_types.h
index 0d3f76fb05ce..c207361bf43e 100644
--- a/drivers/gpu/drm/xe/xe_sched_job_types.h
+++ b/drivers/gpu/drm/xe/xe_sched_job_types.h
@@ -57,6 +57,8 @@ struct xe_sched_job {
 	u32 migrate_flush_flags;
 	/** @ring_ops_flush_tlb: The ring ops need to flush TLB before payload. */
 	bool ring_ops_flush_tlb;
+	/** @ggtt: mapped in ggtt. */
+	bool ggtt;
 	/** @ptrs: per instance pointers. */
 	struct xe_job_ptrs ptrs[];
 };
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 380aa1614442..3d1459b551bb 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -667,23 +667,50 @@ static void synaptics_pt_stop(struct serio *serio)
 	serio_continue_rx(parent->ps2dev.serio);
 }
 
+static int synaptics_pt_open(struct serio *serio)
+{
+	struct psmouse *parent = psmouse_from_serio(serio->parent);
+	struct synaptics_data *priv = parent->private;
+
+	guard(serio_pause_rx)(parent->ps2dev.serio);
+	priv->pt_port_open = true;
+
+	return 0;
+}
+
+static void synaptics_pt_close(struct serio *serio)
+{
+	struct psmouse *parent = psmouse_from_serio(serio->parent);
+	struct synaptics_data *priv = parent->private;
+
+	guard(serio_pause_rx)(parent->ps2dev.serio);
+	priv->pt_port_open = false;
+}
+
 static int synaptics_is_pt_packet(u8 *buf)
 {
 	return (buf[0] & 0xFC) == 0x84 && (buf[3] & 0xCC) == 0xC4;
 }
 
-static void synaptics_pass_pt_packet(struct serio *ptport, u8 *packet)
+static void synaptics_pass_pt_packet(struct synaptics_data *priv, u8 *packet)
 {
-	struct psmouse *child = psmouse_from_serio(ptport);
+	struct serio *ptport;
 
-	if (child && child->state == PSMOUSE_ACTIVATED) {
-		serio_interrupt(ptport, packet[1], 0);
-		serio_interrupt(ptport, packet[4], 0);
-		serio_interrupt(ptport, packet[5], 0);
-		if (child->pktsize == 4)
-			serio_interrupt(ptport, packet[2], 0);
-	} else {
-		serio_interrupt(ptport, packet[1], 0);
+	ptport = priv->pt_port;
+	if (!ptport)
+		return;
+
+	serio_interrupt(ptport, packet[1], 0);
+
+	if (priv->pt_port_open) {
+		struct psmouse *child = psmouse_from_serio(ptport);
+
+		if (child->state == PSMOUSE_ACTIVATED) {
+			serio_interrupt(ptport, packet[4], 0);
+			serio_interrupt(ptport, packet[5], 0);
+			if (child->pktsize == 4)
+				serio_interrupt(ptport, packet[2], 0);
+		}
 	}
 }
 
@@ -722,6 +749,8 @@ static void synaptics_pt_create(struct psmouse *psmouse)
 	serio->write = synaptics_pt_write;
 	serio->start = synaptics_pt_start;
 	serio->stop = synaptics_pt_stop;
+	serio->open = synaptics_pt_open;
+	serio->close = synaptics_pt_close;
 	serio->parent = psmouse->ps2dev.serio;
 
 	psmouse->pt_activate = synaptics_pt_activate;
@@ -1218,11 +1247,10 @@ static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse)
 
 		if (SYN_CAP_PASS_THROUGH(priv->info.capabilities) &&
 		    synaptics_is_pt_packet(psmouse->packet)) {
-			if (priv->pt_port)
-				synaptics_pass_pt_packet(priv->pt_port,
-							 psmouse->packet);
-		} else
+			synaptics_pass_pt_packet(priv, psmouse->packet);
+		} else {
 			synaptics_process_packet(psmouse);
+		}
 
 		return PSMOUSE_FULL_PACKET;
 	}
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 08533d1b1b16..4b34f13b9f76 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -188,6 +188,7 @@ struct synaptics_data {
 	bool disable_gesture;			/* disable gestures */
 
 	struct serio *pt_port;			/* Pass-through serio port */
+	bool pt_port_open;
 
 	/*
 	 * Last received Advanced Gesture Mode (AGM) packet. An AGM packet
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 8fdee511bc0f..cf469a672497 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -44,6 +44,7 @@ static u8 dist_prio_nmi __ro_after_init = GICV3_PRIO_NMI;
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
 #define FLAGS_WORKAROUND_ASR_ERRATUM_8601001	(1ULL << 2)
+#define FLAGS_WORKAROUND_INSECURE		(1ULL << 3)
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
@@ -83,6 +84,8 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 #define GIC_LINE_NR	min(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), 1020U)
 #define GIC_ESPI_NR	GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
 
+static bool nmi_support_forbidden;
+
 /*
  * There are 16 SGIs, though we only actually use 8 in Linux. The other 8 SGIs
  * are potentially stolen by the secure side. Some code, especially code dealing
@@ -163,21 +166,27 @@ static void __init gic_prio_init(void)
 {
 	bool ds;
 
-	ds = gic_dist_security_disabled();
-	if (!ds) {
-		u32 val;
-
-		val = readl_relaxed(gic_data.dist_base + GICD_CTLR);
-		val |= GICD_CTLR_DS;
-		writel_relaxed(val, gic_data.dist_base + GICD_CTLR);
+	cpus_have_group0 = gic_has_group0();
 
-		ds = gic_dist_security_disabled();
-		if (ds)
-			pr_warn("Broken GIC integration, security disabled");
+	ds = gic_dist_security_disabled();
+	if ((gic_data.flags & FLAGS_WORKAROUND_INSECURE) && !ds) {
+		if (cpus_have_group0) {
+			u32 val;
+
+			val = readl_relaxed(gic_data.dist_base + GICD_CTLR);
+			val |= GICD_CTLR_DS;
+			writel_relaxed(val, gic_data.dist_base + GICD_CTLR);
+
+			ds = gic_dist_security_disabled();
+			if (ds)
+				pr_warn("Broken GIC integration, security disabled\n");
+		} else {
+			pr_warn("Broken GIC integration, pNMI forbidden\n");
+			nmi_support_forbidden = true;
+		}
 	}
 
 	cpus_have_security_disabled = ds;
-	cpus_have_group0 = gic_has_group0();
 
 	/*
 	 * How priority values are used by the GIC depends on two things:
@@ -209,7 +218,7 @@ static void __init gic_prio_init(void)
 	 * be in the non-secure range, we program the non-secure values into
 	 * the distributor to match the PMR values we want.
 	 */
-	if (cpus_have_group0 & !cpus_have_security_disabled) {
+	if (cpus_have_group0 && !cpus_have_security_disabled) {
 		dist_prio_irq = __gicv3_prio_to_ns(dist_prio_irq);
 		dist_prio_nmi = __gicv3_prio_to_ns(dist_prio_nmi);
 	}
@@ -1922,6 +1931,18 @@ static bool gic_enable_quirk_arm64_2941627(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_rk3399(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	if (of_machine_is_compatible("rockchip,rk3399")) {
+		d->flags |= FLAGS_WORKAROUND_INSECURE;
+		return true;
+	}
+
+	return false;
+}
+
 static bool rd_set_non_coherent(void *data)
 {
 	struct gic_chip_data *d = data;
@@ -1996,6 +2017,12 @@ static const struct gic_quirk gic_quirks[] = {
 		.property = "dma-noncoherent",
 		.init   = rd_set_non_coherent,
 	},
+	{
+		.desc	= "GICv3: Insecure RK3399 integration",
+		.iidr	= 0x0000043b,
+		.mask	= 0xff000fff,
+		.init	= gic_enable_quirk_rk3399,
+	},
 	{
 	}
 };
@@ -2004,7 +2031,7 @@ static void gic_enable_nmi_support(void)
 {
 	int i;
 
-	if (!gic_prio_masking_enabled())
+	if (!gic_prio_masking_enabled() || nmi_support_forbidden)
 		return;
 
 	rdist_nmi_refs = kcalloc(gic_data.ppi_nr + SGI_NR,
diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index b9dcc8e78c75..1f613eb7b7f0 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -38,7 +38,7 @@ static struct irq_chip jcore_aic;
 static void handle_jcore_irq(struct irq_desc *desc)
 {
 	if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))
-		handle_percpu_irq(desc);
+		handle_percpu_devid_irq(desc);
 	else
 		handle_simple_irq(desc);
 }
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 32d587524778..31bea72bcb01 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -385,10 +385,8 @@ static int raid0_set_limits(struct mddev *mddev)
 	lim.io_min = mddev->chunk_sectors << 9;
 	lim.io_opt = lim.io_min * mddev->raid_disks;
 	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
-	if (err) {
-		queue_limits_cancel_update(mddev->gendisk->queue);
+	if (err)
 		return err;
-	}
 	return queue_limits_set(mddev->gendisk->queue, &lim);
 }
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index d83fe3b3abc0..8a994a1975ca 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3171,10 +3171,8 @@ static int raid1_set_limits(struct mddev *mddev)
 	md_init_stacking_limits(&lim);
 	lim.max_write_zeroes_sectors = 0;
 	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
-	if (err) {
-		queue_limits_cancel_update(mddev->gendisk->queue);
+	if (err)
 		return err;
-	}
 	return queue_limits_set(mddev->gendisk->queue, &lim);
 }
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index daf42acc4fb6..a214fed4f162 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3963,10 +3963,8 @@ static int raid10_set_queue_limits(struct mddev *mddev)
 	lim.io_min = mddev->chunk_sectors << 9;
 	lim.io_opt = lim.io_min * raid10_nr_stripes(conf);
 	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
-	if (err) {
-		queue_limits_cancel_update(mddev->gendisk->queue);
+	if (err)
 		return err;
-	}
 	return queue_limits_set(mddev->gendisk->queue, &lim);
 }
 
diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 3bc89b356963..fca54e21a164 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -471,6 +471,8 @@ struct cdns_nand_ctrl {
 	struct {
 		void __iomem *virt;
 		dma_addr_t dma;
+		dma_addr_t iova_dma;
+		u32 size;
 	} io;
 
 	int irq;
@@ -1835,11 +1837,11 @@ static int cadence_nand_slave_dma_transfer(struct cdns_nand_ctrl *cdns_ctrl,
 	}
 
 	if (dir == DMA_FROM_DEVICE) {
-		src_dma = cdns_ctrl->io.dma;
+		src_dma = cdns_ctrl->io.iova_dma;
 		dst_dma = buf_dma;
 	} else {
 		src_dma = buf_dma;
-		dst_dma = cdns_ctrl->io.dma;
+		dst_dma = cdns_ctrl->io.iova_dma;
 	}
 
 	tx = dmaengine_prep_dma_memcpy(cdns_ctrl->dmac, dst_dma, src_dma, len,
@@ -1861,12 +1863,12 @@ static int cadence_nand_slave_dma_transfer(struct cdns_nand_ctrl *cdns_ctrl,
 	dma_async_issue_pending(cdns_ctrl->dmac);
 	wait_for_completion(&finished);
 
-	dma_unmap_single(cdns_ctrl->dev, buf_dma, len, dir);
+	dma_unmap_single(dma_dev->dev, buf_dma, len, dir);
 
 	return 0;
 
 err_unmap:
-	dma_unmap_single(cdns_ctrl->dev, buf_dma, len, dir);
+	dma_unmap_single(dma_dev->dev, buf_dma, len, dir);
 
 err:
 	dev_dbg(cdns_ctrl->dev, "Fall back to CPU I/O\n");
@@ -2869,6 +2871,7 @@ cadence_nand_irq_cleanup(int irqnum, struct cdns_nand_ctrl *cdns_ctrl)
 static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 {
 	dma_cap_mask_t mask;
+	struct dma_device *dma_dev = cdns_ctrl->dmac->device;
 	int ret;
 
 	cdns_ctrl->cdma_desc = dma_alloc_coherent(cdns_ctrl->dev,
@@ -2904,15 +2907,24 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 	dma_cap_set(DMA_MEMCPY, mask);
 
 	if (cdns_ctrl->caps1->has_dma) {
-		cdns_ctrl->dmac = dma_request_channel(mask, NULL, NULL);
-		if (!cdns_ctrl->dmac) {
-			dev_err(cdns_ctrl->dev,
-				"Unable to get a DMA channel\n");
-			ret = -EBUSY;
+		cdns_ctrl->dmac = dma_request_chan_by_mask(&mask);
+		if (IS_ERR(cdns_ctrl->dmac)) {
+			ret = dev_err_probe(cdns_ctrl->dev, PTR_ERR(cdns_ctrl->dmac),
+					    "%d: Failed to get a DMA channel\n", ret);
 			goto disable_irq;
 		}
 	}
 
+	cdns_ctrl->io.iova_dma = dma_map_resource(dma_dev->dev, cdns_ctrl->io.dma,
+						  cdns_ctrl->io.size,
+						  DMA_BIDIRECTIONAL, 0);
+
+	ret = dma_mapping_error(dma_dev->dev, cdns_ctrl->io.iova_dma);
+	if (ret) {
+		dev_err(cdns_ctrl->dev, "Failed to map I/O resource to DMA\n");
+		goto dma_release_chnl;
+	}
+
 	nand_controller_init(&cdns_ctrl->controller);
 	INIT_LIST_HEAD(&cdns_ctrl->chips);
 
@@ -2923,18 +2935,22 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 	if (ret) {
 		dev_err(cdns_ctrl->dev, "Failed to register MTD: %d\n",
 			ret);
-		goto dma_release_chnl;
+		goto unmap_dma_resource;
 	}
 
 	kfree(cdns_ctrl->buf);
 	cdns_ctrl->buf = kzalloc(cdns_ctrl->buf_size, GFP_KERNEL);
 	if (!cdns_ctrl->buf) {
 		ret = -ENOMEM;
-		goto dma_release_chnl;
+		goto unmap_dma_resource;
 	}
 
 	return 0;
 
+unmap_dma_resource:
+	dma_unmap_resource(dma_dev->dev, cdns_ctrl->io.iova_dma,
+			   cdns_ctrl->io.size, DMA_BIDIRECTIONAL, 0);
+
 dma_release_chnl:
 	if (cdns_ctrl->dmac)
 		dma_release_channel(cdns_ctrl->dmac);
@@ -2956,6 +2972,8 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 static void cadence_nand_remove(struct cdns_nand_ctrl *cdns_ctrl)
 {
 	cadence_nand_chips_cleanup(cdns_ctrl);
+	dma_unmap_resource(cdns_ctrl->dmac->device->dev, cdns_ctrl->io.iova_dma,
+			   cdns_ctrl->io.size, DMA_BIDIRECTIONAL, 0);
 	cadence_nand_irq_cleanup(cdns_ctrl->irq, cdns_ctrl);
 	kfree(cdns_ctrl->buf);
 	dma_free_coherent(cdns_ctrl->dev, sizeof(struct cadence_nand_cdma_desc),
@@ -3020,7 +3038,9 @@ static int cadence_nand_dt_probe(struct platform_device *ofdev)
 	cdns_ctrl->io.virt = devm_platform_get_and_ioremap_resource(ofdev, 1, &res);
 	if (IS_ERR(cdns_ctrl->io.virt))
 		return PTR_ERR(cdns_ctrl->io.virt);
+
 	cdns_ctrl->io.dma = res->start;
+	cdns_ctrl->io.size = resource_size(res);
 
 	dt->clk = devm_clk_get(cdns_ctrl->dev, "nf_clk");
 	if (IS_ERR(dt->clk))
diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index b5ad7118c49a..175211fe6a5e 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -174,7 +174,7 @@ static int sst_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 	int ret;
 
 	nor->program_opcode = op;
-	ret = spi_nor_write_data(nor, to, 1, buf);
+	ret = spi_nor_write_data(nor, to, len, buf);
 	if (ret < 0)
 		return ret;
 	WARN(ret != len, "While writing %zu byte written %i bytes\n", len, ret);
diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 95471cfcff42..8ddd366d9fde 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1110,6 +1110,16 @@ static inline u32 gve_xdp_tx_start_queue_id(struct gve_priv *priv)
 	return gve_xdp_tx_queue_id(priv, 0);
 }
 
+static inline bool gve_supports_xdp_xmit(struct gve_priv *priv)
+{
+	switch (priv->queue_format) {
+	case GVE_GQI_QPL_FORMAT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /* gqi napi handler defined in gve_main.c */
 int gve_napi_poll(struct napi_struct *napi, int budget);
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index f985a3cf2b11..862c4575701f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1895,6 +1895,8 @@ static void gve_turndown(struct gve_priv *priv)
 	/* Stop tx queues */
 	netif_tx_disable(priv->dev);
 
+	xdp_features_clear_redirect_target(priv->dev);
+
 	gve_clear_napi_enabled(priv);
 	gve_clear_report_stats(priv);
 
@@ -1955,6 +1957,9 @@ static void gve_turnup(struct gve_priv *priv)
 		napi_schedule(&block->napi);
 	}
 
+	if (priv->num_xdp_queues && gve_supports_xdp_xmit(priv))
+		xdp_features_set_redirect_target(priv->dev, false);
+
 	gve_set_napi_enabled(priv);
 }
 
@@ -2229,7 +2234,6 @@ static void gve_set_netdev_xdp_features(struct gve_priv *priv)
 	if (priv->queue_format == GVE_GQI_QPL_FORMAT) {
 		xdp_features = NETDEV_XDP_ACT_BASIC;
 		xdp_features |= NETDEV_XDP_ACT_REDIRECT;
-		xdp_features |= NETDEV_XDP_ACT_NDO_XMIT;
 		xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
 	} else {
 		xdp_features = 0;
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 97425c06e1ed..61db00b2b33e 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2310,7 +2310,7 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 		tx_buff = &tx_pool->tx_buff[index];
 		adapter->netdev->stats.tx_packets--;
 		adapter->netdev->stats.tx_bytes -= tx_buff->skb->len;
-		adapter->tx_stats_buffers[queue_num].packets--;
+		adapter->tx_stats_buffers[queue_num].batched_packets--;
 		adapter->tx_stats_buffers[queue_num].bytes -=
 						tx_buff->skb->len;
 		dev_kfree_skb_any(tx_buff->skb);
@@ -2402,11 +2402,13 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	unsigned int tx_map_failed = 0;
 	union sub_crq indir_arr[16];
 	unsigned int tx_dropped = 0;
-	unsigned int tx_packets = 0;
+	unsigned int tx_dpackets = 0;
+	unsigned int tx_bpackets = 0;
 	unsigned int tx_bytes = 0;
 	dma_addr_t data_dma_addr;
 	struct netdev_queue *txq;
 	unsigned long lpar_rc;
+	unsigned int skblen;
 	union sub_crq tx_crq;
 	unsigned int offset;
 	bool use_scrq_send_direct = false;
@@ -2521,6 +2523,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tx_buff->skb = skb;
 	tx_buff->index = bufidx;
 	tx_buff->pool_index = queue_num;
+	skblen = skb->len;
 
 	memset(&tx_crq, 0, sizeof(tx_crq));
 	tx_crq.v1.first = IBMVNIC_CRQ_CMD;
@@ -2575,6 +2578,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		if (lpar_rc != H_SUCCESS)
 			goto tx_err;
 
+		tx_dpackets++;
 		goto early_exit;
 	}
 
@@ -2603,6 +2607,8 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 			goto tx_err;
 	}
 
+	tx_bpackets++;
+
 early_exit:
 	if (atomic_add_return(num_entries, &tx_scrq->used)
 					>= adapter->req_tx_entries_per_subcrq) {
@@ -2610,8 +2616,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		netif_stop_subqueue(netdev, queue_num);
 	}
 
-	tx_packets++;
-	tx_bytes += skb->len;
+	tx_bytes += skblen;
 	txq_trans_cond_update(txq);
 	ret = NETDEV_TX_OK;
 	goto out;
@@ -2640,10 +2645,11 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	rcu_read_unlock();
 	netdev->stats.tx_dropped += tx_dropped;
 	netdev->stats.tx_bytes += tx_bytes;
-	netdev->stats.tx_packets += tx_packets;
+	netdev->stats.tx_packets += tx_bpackets + tx_dpackets;
 	adapter->tx_send_failed += tx_send_failed;
 	adapter->tx_map_failed += tx_map_failed;
-	adapter->tx_stats_buffers[queue_num].packets += tx_packets;
+	adapter->tx_stats_buffers[queue_num].batched_packets += tx_bpackets;
+	adapter->tx_stats_buffers[queue_num].direct_packets += tx_dpackets;
 	adapter->tx_stats_buffers[queue_num].bytes += tx_bytes;
 	adapter->tx_stats_buffers[queue_num].dropped_packets += tx_dropped;
 
@@ -3808,7 +3814,10 @@ static void ibmvnic_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 		memcpy(data, ibmvnic_stats[i].name, ETH_GSTRING_LEN);
 
 	for (i = 0; i < adapter->req_tx_queues; i++) {
-		snprintf(data, ETH_GSTRING_LEN, "tx%d_packets", i);
+		snprintf(data, ETH_GSTRING_LEN, "tx%d_batched_packets", i);
+		data += ETH_GSTRING_LEN;
+
+		snprintf(data, ETH_GSTRING_LEN, "tx%d_direct_packets", i);
 		data += ETH_GSTRING_LEN;
 
 		snprintf(data, ETH_GSTRING_LEN, "tx%d_bytes", i);
@@ -3873,7 +3882,9 @@ static void ibmvnic_get_ethtool_stats(struct net_device *dev,
 				      (adapter, ibmvnic_stats[i].offset));
 
 	for (j = 0; j < adapter->req_tx_queues; j++) {
-		data[i] = adapter->tx_stats_buffers[j].packets;
+		data[i] = adapter->tx_stats_buffers[j].batched_packets;
+		i++;
+		data[i] = adapter->tx_stats_buffers[j].direct_packets;
 		i++;
 		data[i] = adapter->tx_stats_buffers[j].bytes;
 		i++;
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 94ac36b1408b..a189038d88df 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -213,7 +213,8 @@ struct ibmvnic_statistics {
 
 #define NUM_TX_STATS 3
 struct ibmvnic_tx_queue_stats {
-	u64 packets;
+	u64 batched_packets;
+	u64 direct_packets;
 	u64 bytes;
 	u64 dropped_packets;
 };
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
index 2ec62c8d86e1..59486fe2ad18 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
@@ -20,6 +20,8 @@ nfp_bpf_cmsg_alloc(struct nfp_app_bpf *bpf, unsigned int size)
 	struct sk_buff *skb;
 
 	skb = nfp_app_ctrl_msg_alloc(bpf->app, size, GFP_KERNEL);
+	if (!skb)
+		return NULL;
 	skb_put(skb, size);
 
 	return skb;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index de10a2d08c42..fe3438abcd25 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2888,6 +2888,7 @@ static int axienet_probe(struct platform_device *pdev)
 
 	lp->phylink_config.dev = &ndev->dev;
 	lp->phylink_config.type = PHYLINK_NETDEV;
+	lp->phylink_config.mac_managed_pm = true;
 	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
 		MAC_10FD | MAC_100FD | MAC_1000FD;
 
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index ba15a0a4ce62..963fb9261f01 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1902,21 +1902,9 @@ static void geneve_destroy_tunnels(struct net *net, struct list_head *head)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct geneve_dev *geneve, *next;
-	struct net_device *dev, *aux;
 
-	/* gather any geneve devices that were moved into this ns */
-	for_each_netdev_safe(net, dev, aux)
-		if (dev->rtnl_link_ops == &geneve_link_ops)
-			unregister_netdevice_queue(dev, head);
-
-	/* now gather any other geneve devices that were created in this ns */
-	list_for_each_entry_safe(geneve, next, &gn->geneve_list, next) {
-		/* If geneve->dev is in the same netns, it was already added
-		 * to the list by the previous loop.
-		 */
-		if (!net_eq(dev_net(geneve->dev), net))
-			unregister_netdevice_queue(geneve->dev, head);
-	}
+	list_for_each_entry_safe(geneve, next, &gn->geneve_list, next)
+		geneve_dellink(geneve->dev, head);
 }
 
 static void __net_exit geneve_exit_batch_rtnl(struct list_head *net_list,
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 47406ce99016..33b78b4007fe 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2487,11 +2487,6 @@ static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
 	list_for_each_entry(net, net_list, exit_list) {
 		struct gtp_net *gn = net_generic(net, gtp_net_id);
 		struct gtp_dev *gtp, *gtp_next;
-		struct net_device *dev;
-
-		for_each_netdev(net, dev)
-			if (dev->rtnl_link_ops == &gtp_link_ops)
-				gtp_dellink(dev, dev_to_kill);
 
 		list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
 			gtp_dellink(gtp->dev, dev_to_kill);
diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 0af7db80b2f8..7cfc36cadb57 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -999,13 +999,12 @@ static int pd692x0_pi_get_voltage(struct pse_controller_dev *pcdev, int id)
 	return (buf.sub[0] << 8 | buf.sub[1]) * 100000;
 }
 
-static int pd692x0_pi_get_current_limit(struct pse_controller_dev *pcdev,
-					int id)
+static int pd692x0_pi_get_pw_limit(struct pse_controller_dev *pcdev,
+				   int id)
 {
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
 	struct pd692x0_msg msg, buf = {0};
-	int mW, uV, uA, ret;
-	s64 tmp_64;
+	int ret;
 
 	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_PARAM];
 	msg.sub[2] = id;
@@ -1013,48 +1012,24 @@ static int pd692x0_pi_get_current_limit(struct pse_controller_dev *pcdev,
 	if (ret < 0)
 		return ret;
 
-	ret = pd692x0_pi_get_pw_from_table(buf.data[2], buf.data[3]);
-	if (ret < 0)
-		return ret;
-	mW = ret;
-
-	ret = pd692x0_pi_get_voltage(pcdev, id);
-	if (ret < 0)
-		return ret;
-	uV = ret;
-
-	tmp_64 = mW;
-	tmp_64 *= 1000000000ull;
-	/* uA = mW * 1000000000 / uV */
-	uA = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
-	return uA;
+	return pd692x0_pi_get_pw_from_table(buf.data[0], buf.data[1]);
 }
 
-static int pd692x0_pi_set_current_limit(struct pse_controller_dev *pcdev,
-					int id, int max_uA)
+static int pd692x0_pi_set_pw_limit(struct pse_controller_dev *pcdev,
+				   int id, int max_mW)
 {
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
 	struct device *dev = &priv->client->dev;
 	struct pd692x0_msg msg, buf = {0};
-	int uV, ret, mW;
-	s64 tmp_64;
+	int ret;
 
 	ret = pd692x0_fw_unavailable(priv);
 	if (ret)
 		return ret;
 
-	ret = pd692x0_pi_get_voltage(pcdev, id);
-	if (ret < 0)
-		return ret;
-	uV = ret;
-
 	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
 	msg.sub[2] = id;
-	tmp_64 = uV;
-	tmp_64 *= max_uA;
-	/* mW = uV * uA / 1000000000 */
-	mW = DIV_ROUND_CLOSEST_ULL(tmp_64, 1000000000);
-	ret = pd692x0_pi_set_pw_from_table(dev, &msg, mW);
+	ret = pd692x0_pi_set_pw_from_table(dev, &msg, max_mW);
 	if (ret)
 		return ret;
 
@@ -1068,8 +1043,8 @@ static const struct pse_controller_ops pd692x0_ops = {
 	.pi_disable = pd692x0_pi_disable,
 	.pi_is_enabled = pd692x0_pi_is_enabled,
 	.pi_get_voltage = pd692x0_pi_get_voltage,
-	.pi_get_current_limit = pd692x0_pi_get_current_limit,
-	.pi_set_current_limit = pd692x0_pi_set_current_limit,
+	.pi_get_pw_limit = pd692x0_pi_get_pw_limit,
+	.pi_set_pw_limit = pd692x0_pi_set_pw_limit,
 };
 
 #define PD692X0_FW_LINE_MAX_SZ 0xff
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 2906ce173f66..bb509d973e91 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -291,32 +291,24 @@ static int pse_pi_get_voltage(struct regulator_dev *rdev)
 	return ret;
 }
 
-static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
-				   int id,
-				   struct netlink_ext_ack *extack,
-				   struct pse_control_status *status);
-
 static int pse_pi_get_current_limit(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
 	const struct pse_controller_ops *ops;
-	struct netlink_ext_ack extack = {};
-	struct pse_control_status st = {};
-	int id, uV, ret;
+	int id, uV, mW, ret;
 	s64 tmp_64;
 
 	ops = pcdev->ops;
 	id = rdev_get_id(rdev);
+	if (!ops->pi_get_pw_limit || !ops->pi_get_voltage)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&pcdev->lock);
-	if (ops->pi_get_current_limit) {
-		ret = ops->pi_get_current_limit(pcdev, id);
+	ret = ops->pi_get_pw_limit(pcdev, id);
+	if (ret < 0)
 		goto out;
-	}
+	mW = ret;
 
-	/* If pi_get_current_limit() callback not populated get voltage
-	 * from pi_get_voltage() and power limit from ethtool_get_status()
-	 *  to calculate current limit.
-	 */
 	ret = _pse_pi_get_voltage(rdev);
 	if (!ret) {
 		dev_err(pcdev->dev, "Voltage null\n");
@@ -327,16 +319,7 @@ static int pse_pi_get_current_limit(struct regulator_dev *rdev)
 		goto out;
 	uV = ret;
 
-	ret = _pse_ethtool_get_status(pcdev, id, &extack, &st);
-	if (ret)
-		goto out;
-
-	if (!st.c33_avail_pw_limit) {
-		ret = -ENODATA;
-		goto out;
-	}
-
-	tmp_64 = st.c33_avail_pw_limit;
+	tmp_64 = mW;
 	tmp_64 *= 1000000000ull;
 	/* uA = mW * 1000000000 / uV */
 	ret = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
@@ -351,15 +334,33 @@ static int pse_pi_set_current_limit(struct regulator_dev *rdev, int min_uA,
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
 	const struct pse_controller_ops *ops;
-	int id, ret;
+	int id, mW, ret;
+	s64 tmp_64;
 
 	ops = pcdev->ops;
-	if (!ops->pi_set_current_limit)
+	if (!ops->pi_set_pw_limit || !ops->pi_get_voltage)
 		return -EOPNOTSUPP;
 
+	if (max_uA > MAX_PI_CURRENT)
+		return -ERANGE;
+
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
-	ret = ops->pi_set_current_limit(pcdev, id, max_uA);
+	ret = _pse_pi_get_voltage(rdev);
+	if (!ret) {
+		dev_err(pcdev->dev, "Voltage null\n");
+		ret = -ERANGE;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+
+	tmp_64 = ret;
+	tmp_64 *= max_uA;
+	/* mW = uA * uV / 1000000000 */
+	mW = DIV_ROUND_CLOSEST_ULL(tmp_64, 1000000000);
+	ret = ops->pi_set_pw_limit(pcdev, id, mW);
+out:
 	mutex_unlock(&pcdev->lock);
 
 	return ret;
@@ -403,11 +404,9 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 
 	rinit_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
 
-	if (pcdev->ops->pi_set_current_limit) {
+	if (pcdev->ops->pi_set_pw_limit)
 		rinit_data->constraints.valid_ops_mask |=
 			REGULATOR_CHANGE_CURRENT;
-		rinit_data->constraints.max_uA = MAX_PI_CURRENT;
-	}
 
 	rinit_data->supply_regulator = "vpwr";
 
@@ -736,23 +735,6 @@ struct pse_control *of_pse_control_get(struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_pse_control_get);
 
-static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
-				   int id,
-				   struct netlink_ext_ack *extack,
-				   struct pse_control_status *status)
-{
-	const struct pse_controller_ops *ops;
-
-	ops = pcdev->ops;
-	if (!ops->ethtool_get_status) {
-		NL_SET_ERR_MSG(extack,
-			       "PSE driver does not support status report");
-		return -EOPNOTSUPP;
-	}
-
-	return ops->ethtool_get_status(pcdev, id, extack, status);
-}
-
 /**
  * pse_ethtool_get_status - get status of PSE control
  * @psec: PSE control pointer
@@ -765,11 +747,21 @@ int pse_ethtool_get_status(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
 			   struct pse_control_status *status)
 {
+	const struct pse_controller_ops *ops;
+	struct pse_controller_dev *pcdev;
 	int err;
 
-	mutex_lock(&psec->pcdev->lock);
-	err = _pse_ethtool_get_status(psec->pcdev, psec->id, extack, status);
-	mutex_unlock(&psec->pcdev->lock);
+	pcdev = psec->pcdev;
+	ops = pcdev->ops;
+	if (!ops->ethtool_get_status) {
+		NL_SET_ERR_MSG(extack,
+			       "PSE driver does not support status report");
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&pcdev->lock);
+	err = ops->ethtool_get_status(pcdev, psec->id, extack, status);
+	mutex_unlock(&pcdev->lock);
 
 	return err;
 }
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a96976b22fa7..61af1583356c 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -276,8 +276,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 {
 	if (ns && nsid != ns->head->ns_id) {
 		dev_err(ctrl->device,
-			"%s: nsid (%u) in cmd does not match nsid (%u)"
-			"of namespace\n",
+			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
 			current->comm, nsid, ns->head->ns_id);
 		return false;
 	}
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8305d3c12807..840ae475074d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1449,11 +1449,14 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 		msg.msg_control = cbuf;
 		msg.msg_controllen = sizeof(cbuf);
 	}
+	msg.msg_flags = MSG_WAITALL;
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
-	if (ret < 0) {
+	if (ret < sizeof(*icresp)) {
 		pr_warn("queue %d: failed to receive icresp, error %d\n",
 			nvme_tcp_queue_id(queue), ret);
+		if (ret >= 0)
+			ret = -ECONNRESET;
 		goto free_icresp;
 	}
 	ret = -ENOTCONN;
@@ -1565,7 +1568,7 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
 			  ctrl->io_queues[HCTX_TYPE_POLL];
 }
 
-/**
+/*
  * Track the number of queues assigned to each cpu using a global per-cpu
  * counter and select the least used cpu from the mq_map. Our goal is to spread
  * different controllers I/O threads across different cpu cores.
diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b133967faef8..643f85849ef6 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -411,46 +411,20 @@ static inline bool mask_contains_bar(int mask, int bar)
 	return mask & BIT(bar);
 }
 
-/*
- * This is a copy of pci_intx() used to bypass the problem of recursive
- * function calls due to the hybrid nature of pci_intx().
- */
-static void __pcim_intx(struct pci_dev *pdev, int enable)
-{
-	u16 pci_command, new;
-
-	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-
-	if (enable)
-		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
-	else
-		new = pci_command | PCI_COMMAND_INTX_DISABLE;
-
-	if (new != pci_command)
-		pci_write_config_word(pdev, PCI_COMMAND, new);
-}
-
 static void pcim_intx_restore(struct device *dev, void *data)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcim_intx_devres *res = data;
 
-	__pcim_intx(pdev, res->orig_intx);
+	pci_intx(pdev, res->orig_intx);
 }
 
-static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
+static void save_orig_intx(struct pci_dev *pdev, struct pcim_intx_devres *res)
 {
-	struct pcim_intx_devres *res;
-
-	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
-	if (res)
-		return res;
+	u16 pci_command;
 
-	res = devres_alloc(pcim_intx_restore, sizeof(*res), GFP_KERNEL);
-	if (res)
-		devres_add(dev, res);
-
-	return res;
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+	res->orig_intx = !(pci_command & PCI_COMMAND_INTX_DISABLE);
 }
 
 /**
@@ -466,16 +440,28 @@ static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
 int pcim_intx(struct pci_dev *pdev, int enable)
 {
 	struct pcim_intx_devres *res;
+	struct device *dev = &pdev->dev;
 
-	res = get_or_create_intx_devres(&pdev->dev);
-	if (!res)
-		return -ENOMEM;
+	/*
+	 * pcim_intx() must only restore the INTx value that existed before the
+	 * driver was loaded, i.e., before it called pcim_intx() for the
+	 * first time.
+	 */
+	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
+	if (!res) {
+		res = devres_alloc(pcim_intx_restore, sizeof(*res), GFP_KERNEL);
+		if (!res)
+			return -ENOMEM;
+
+		save_orig_intx(pdev, res);
+		devres_add(dev, res);
+	}
 
-	res->orig_intx = !enable;
-	__pcim_intx(pdev, enable);
+	pci_intx(pdev, enable);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pcim_intx);
 
 static void pcim_disable_device(void *pdev_raw)
 {
@@ -939,7 +925,7 @@ static void pcim_release_all_regions(struct pci_dev *pdev)
  * desired, release individual regions with pcim_release_region() or all of
  * them at once with pcim_release_all_regions().
  */
-static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 {
 	int ret;
 	int bar;
@@ -957,6 +943,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL(pcim_request_all_regions);
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index dd3c6dcb47ae..1aa5d6f98ebd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4486,11 +4486,6 @@ void pci_disable_parity(struct pci_dev *dev)
  * @enable: boolean: whether to enable or disable PCI INTx
  *
  * Enables/disables PCI INTx for device @pdev
- *
- * NOTE:
- * This is a "hybrid" function: It's normally unmanaged, but becomes managed
- * when pcim_enable_device() has been called in advance. This hybrid feature is
- * DEPRECATED! If you want managed cleanup, use pcim_intx() instead.
  */
 void pci_intx(struct pci_dev *pdev, int enable)
 {
@@ -4503,15 +4498,10 @@ void pci_intx(struct pci_dev *pdev, int enable)
 	else
 		new = pci_command | PCI_COMMAND_INTX_DISABLE;
 
-	if (new != pci_command) {
-		/* Preserve the "hybrid" behavior for backwards compatibility */
-		if (pci_is_managed(pdev)) {
-			WARN_ON_ONCE(pcim_intx(pdev, enable) != 0);
-			return;
-		}
+	if (new == pci_command)
+		return;
 
-		pci_write_config_word(pdev, PCI_COMMAND, new);
-	}
+	pci_write_config_word(pdev, PCI_COMMAND, new);
 }
 EXPORT_SYMBOL_GPL(pci_intx);
 
diff --git a/drivers/platform/cznic/Kconfig b/drivers/platform/cznic/Kconfig
index 49c383eb6785..13e37b49d9d0 100644
--- a/drivers/platform/cznic/Kconfig
+++ b/drivers/platform/cznic/Kconfig
@@ -6,6 +6,7 @@
 
 menuconfig CZNIC_PLATFORMS
 	bool "Platform support for CZ.NIC's Turris hardware"
+	depends on ARCH_MVEBU || COMPILE_TEST
 	help
 	  Say Y here to be able to choose driver support for CZ.NIC's Turris
 	  devices. This option alone does not add any kernel code.
diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index f71cc90fea12..57eba1ddb17b 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -466,10 +466,9 @@ static int axp717_battery_get_prop(struct power_supply *psy,
 
 	/*
 	 * If a fault is detected it must also be cleared; if the
-	 * condition persists it should reappear (This is an
-	 * assumption, it's actually not documented). A restart was
-	 * not sufficient to clear the bit in testing despite the
-	 * register listed as POR.
+	 * condition persists it should reappear. A restart was not
+	 * sufficient to clear the bit in testing despite the register
+	 * listed as POR.
 	 */
 	case POWER_SUPPLY_PROP_HEALTH:
 		ret = regmap_read(axp20x_batt->regmap, AXP717_PMU_FAULT,
@@ -480,26 +479,26 @@ static int axp717_battery_get_prop(struct power_supply *psy,
 		switch (reg & AXP717_BATT_PMU_FAULT_MASK) {
 		case AXP717_BATT_UVLO_2_5V:
 			val->intval = POWER_SUPPLY_HEALTH_DEAD;
-			regmap_update_bits(axp20x_batt->regmap,
-					   AXP717_PMU_FAULT,
-					   AXP717_BATT_UVLO_2_5V,
-					   AXP717_BATT_UVLO_2_5V);
+			regmap_write_bits(axp20x_batt->regmap,
+					  AXP717_PMU_FAULT,
+					  AXP717_BATT_UVLO_2_5V,
+					  AXP717_BATT_UVLO_2_5V);
 			return 0;
 
 		case AXP717_BATT_OVER_TEMP:
 			val->intval = POWER_SUPPLY_HEALTH_HOT;
-			regmap_update_bits(axp20x_batt->regmap,
-					   AXP717_PMU_FAULT,
-					   AXP717_BATT_OVER_TEMP,
-					   AXP717_BATT_OVER_TEMP);
+			regmap_write_bits(axp20x_batt->regmap,
+					  AXP717_PMU_FAULT,
+					  AXP717_BATT_OVER_TEMP,
+					  AXP717_BATT_OVER_TEMP);
 			return 0;
 
 		case AXP717_BATT_UNDER_TEMP:
 			val->intval = POWER_SUPPLY_HEALTH_COLD;
-			regmap_update_bits(axp20x_batt->regmap,
-					   AXP717_PMU_FAULT,
-					   AXP717_BATT_UNDER_TEMP,
-					   AXP717_BATT_UNDER_TEMP);
+			regmap_write_bits(axp20x_batt->regmap,
+					  AXP717_PMU_FAULT,
+					  AXP717_BATT_UNDER_TEMP,
+					  AXP717_BATT_UNDER_TEMP);
 			return 0;
 
 		default:
diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
index 652c1f213af1..4f28ef1bba1a 100644
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -247,9 +247,9 @@ static int da9150_fg_current_avg(struct da9150_fg *fg,
 				      DA9150_QIF_SD_GAIN_SIZE);
 	da9150_fg_read_sync_end(fg);
 
-	div = (u64) (sd_gain * shunt_val * 65536ULL);
+	div = 65536ULL * sd_gain * shunt_val;
 	do_div(div, 1000000);
-	res = (u64) (iavg * 1000000ULL);
+	res = 1000000ULL * iavg;
 	do_div(res, div);
 
 	val->intval = (int) res;
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index e36e3ea165d3..2f34761e6413 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -588,6 +588,15 @@ static int ism_dev_init(struct ism_dev *ism)
 	return ret;
 }
 
+static void ism_dev_release(struct device *dev)
+{
+	struct ism_dev *ism;
+
+	ism = container_of(dev, struct ism_dev, dev);
+
+	kfree(ism);
+}
+
 static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct ism_dev *ism;
@@ -601,6 +610,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev_set_drvdata(&pdev->dev, ism);
 	ism->pdev = pdev;
 	ism->dev.parent = &pdev->dev;
+	ism->dev.release = ism_dev_release;
 	device_initialize(&ism->dev);
 	dev_set_name(&ism->dev, dev_name(&pdev->dev));
 	ret = device_add(&ism->dev);
@@ -637,7 +647,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	device_del(&ism->dev);
 err_dev:
 	dev_set_drvdata(&pdev->dev, NULL);
-	kfree(ism);
+	put_device(&ism->dev);
 
 	return ret;
 }
@@ -682,7 +692,7 @@ static void ism_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 	device_del(&ism->dev);
 	dev_set_drvdata(&pdev->dev, NULL);
-	kfree(ism);
+	put_device(&ism->dev);
 }
 
 static struct pci_driver ism_driver = {
diff --git a/drivers/soc/loongson/loongson2_guts.c b/drivers/soc/loongson/loongson2_guts.c
index ef352a0f5022..1fcf7ca8083e 100644
--- a/drivers/soc/loongson/loongson2_guts.c
+++ b/drivers/soc/loongson/loongson2_guts.c
@@ -114,8 +114,11 @@ static int loongson2_guts_probe(struct platform_device *pdev)
 	if (of_property_read_string(root, "model", &machine))
 		of_property_read_string_index(root, "compatible", 0, &machine);
 	of_node_put(root);
-	if (machine)
+	if (machine) {
 		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
+		if (!soc_dev_attr.machine)
+			return -ENOMEM;
+	}
 
 	svr = loongson2_guts_get_svr();
 	soc_die = loongson2_soc_die_match(svr, loongson2_soc_die);
diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 322a543b8c27..d0f397c90242 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -80,7 +80,6 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_supp *supp = &optee->supp;
 	struct optee_supp_req *req;
-	bool interruptable;
 	u32 ret;
 
 	/*
@@ -111,36 +110,18 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	/*
 	 * Wait for supplicant to process and return result, once we've
 	 * returned from wait_for_completion(&req->c) successfully we have
-	 * exclusive access again.
+	 * exclusive access again. Allow the wait to be killable such that
+	 * the wait doesn't turn into an indefinite state if the supplicant
+	 * gets hung for some reason.
 	 */
-	while (wait_for_completion_interruptible(&req->c)) {
+	if (wait_for_completion_killable(&req->c)) {
 		mutex_lock(&supp->mutex);
-		interruptable = !supp->ctx;
-		if (interruptable) {
-			/*
-			 * There's no supplicant available and since the
-			 * supp->mutex currently is held none can
-			 * become available until the mutex released
-			 * again.
-			 *
-			 * Interrupting an RPC to supplicant is only
-			 * allowed as a way of slightly improving the user
-			 * experience in case the supplicant hasn't been
-			 * started yet. During normal operation the supplicant
-			 * will serve all requests in a timely manner and
-			 * interrupting then wouldn't make sense.
-			 */
-			if (req->in_queue) {
-				list_del(&req->link);
-				req->in_queue = false;
-			}
+		if (req->in_queue) {
+			list_del(&req->link);
+			req->in_queue = false;
 		}
 		mutex_unlock(&supp->mutex);
-
-		if (interruptable) {
-			req->ret = TEEC_ERROR_COMMUNICATION;
-			break;
-		}
+		req->ret = TEEC_ERROR_COMMUNICATION;
 	}
 
 	ret = req->ret;
diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 4153643c67dc..1f18f15dba27 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -283,7 +283,7 @@ f_midi_complete(struct usb_ep *ep, struct usb_request *req)
 			/* Our transmit completed. See if there's more to go.
 			 * f_midi_transmit eats req, don't queue it again. */
 			req->length = 0;
-			f_midi_transmit(midi);
+			queue_work(system_highpri_wq, &midi->work);
 			return;
 		}
 		break;
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 90aef2627ca2..40332ab62f10 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -545,8 +545,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		 * subpage::readers and to unlock the page.
 		 */
 		if (fs_info->sectorsize < PAGE_SIZE)
-			btrfs_subpage_start_reader(fs_info, folio, cur,
-						   add_size);
+			btrfs_folio_set_lock(fs_info, folio, cur, add_size);
 		folio_put(folio);
 		cur += add_size;
 	}
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fe08c983d5bb..660a5b9c08e9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -190,7 +190,7 @@ static void process_one_folio(struct btrfs_fs_info *fs_info,
 		btrfs_folio_clamp_clear_writeback(fs_info, folio, start, len);
 
 	if (folio != locked_folio && (page_ops & PAGE_UNLOCK))
-		btrfs_folio_end_writer_lock(fs_info, folio, start, len);
+		btrfs_folio_end_lock(fs_info, folio, start, len);
 }
 
 static void __process_folios_contig(struct address_space *mapping,
@@ -276,7 +276,7 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 			range_start = max_t(u64, folio_pos(folio), start);
 			range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
 					  end + 1) - range_start;
-			btrfs_folio_set_writer_lock(fs_info, folio, range_start, range_len);
+			btrfs_folio_set_lock(fs_info, folio, range_start, range_len);
 
 			processed_end = range_start + range_len - 1;
 		}
@@ -438,7 +438,7 @@ static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 le
 	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		folio_unlock(folio);
 	else
-		btrfs_subpage_end_reader(fs_info, folio, start, len);
+		btrfs_folio_end_lock(fs_info, folio, start, len);
 }
 
 /*
@@ -495,7 +495,7 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 		return;
 
 	ASSERT(folio_test_private(folio));
-	btrfs_subpage_start_reader(fs_info, folio, folio_pos(folio), PAGE_SIZE);
+	btrfs_folio_set_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
 }
 
 /*
@@ -1105,15 +1105,59 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	return ret;
 }
 
+static void set_delalloc_bitmap(struct folio *folio, unsigned long *delalloc_bitmap,
+				u64 start, u32 len)
+{
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
+	const u64 folio_start = folio_pos(folio);
+	unsigned int start_bit;
+	unsigned int nbits;
+
+	ASSERT(start >= folio_start && start + len <= folio_start + PAGE_SIZE);
+	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
+	nbits = len >> fs_info->sectorsize_bits;
+	ASSERT(bitmap_test_range_all_zero(delalloc_bitmap, start_bit, nbits));
+	bitmap_set(delalloc_bitmap, start_bit, nbits);
+}
+
+static bool find_next_delalloc_bitmap(struct folio *folio,
+				      unsigned long *delalloc_bitmap, u64 start,
+				      u64 *found_start, u32 *found_len)
+{
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
+	const u64 folio_start = folio_pos(folio);
+	const unsigned int bitmap_size = fs_info->sectors_per_page;
+	unsigned int start_bit;
+	unsigned int first_zero;
+	unsigned int first_set;
+
+	ASSERT(start >= folio_start && start < folio_start + PAGE_SIZE);
+
+	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
+	first_set = find_next_bit(delalloc_bitmap, bitmap_size, start_bit);
+	if (first_set >= bitmap_size)
+		return false;
+
+	*found_start = folio_start + (first_set << fs_info->sectorsize_bits);
+	first_zero = find_next_zero_bit(delalloc_bitmap, bitmap_size, first_set);
+	*found_len = (first_zero - first_set) << fs_info->sectorsize_bits;
+	return true;
+}
+
 /*
- * helper for extent_writepage(), doing all of the delayed allocation setup.
+ * Do all of the delayed allocation setup.
+ *
+ * Return >0 if all the dirty blocks are submitted async (compression) or inlined.
+ * The @folio should no longer be touched (treat it as already unlocked).
  *
- * This returns 1 if btrfs_run_delalloc_range function did all the work required
- * to write the page (copy into inline extent).  In this case the IO has
- * been started and the page is already unlocked.
+ * Return 0 if there is still dirty block that needs to be submitted through
+ * extent_writepage_io().
+ * bio_ctrl->submit_bitmap will indicate which blocks of the folio should be
+ * submitted, and @folio is still kept locked.
  *
- * This returns 0 if all went well (page still locked)
- * This returns < 0 if there were errors (page still locked)
+ * Return <0 if there is any error hit.
+ * Any allocated ordered extent range covering this folio will be marked
+ * finished (IOERR), and @folio is still kept locked.
  */
 static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 						 struct folio *folio,
@@ -1124,16 +1168,28 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	const bool is_subpage = btrfs_is_subpage(fs_info, folio->mapping);
 	const u64 page_start = folio_pos(folio);
 	const u64 page_end = page_start + folio_size(folio) - 1;
+	unsigned long delalloc_bitmap = 0;
 	/*
 	 * Save the last found delalloc end. As the delalloc end can go beyond
 	 * page boundary, thus we cannot rely on subpage bitmap to locate the
 	 * last delalloc end.
 	 */
 	u64 last_delalloc_end = 0;
+	/*
+	 * The range end (exclusive) of the last successfully finished delalloc
+	 * range.
+	 * Any range covered by ordered extent must either be manually marked
+	 * finished (error handling), or has IO submitted (and finish the
+	 * ordered extent normally).
+	 *
+	 * This records the end of ordered extent cleanup if we hit an error.
+	 */
+	u64 last_finished_delalloc_end = page_start;
 	u64 delalloc_start = page_start;
 	u64 delalloc_end = page_end;
 	u64 delalloc_to_write = 0;
 	int ret = 0;
+	int bit;
 
 	/* Save the dirty bitmap as our submission bitmap will be a subset of it. */
 	if (btrfs_is_subpage(fs_info, inode->vfs_inode.i_mapping)) {
@@ -1143,6 +1199,12 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		bio_ctrl->submit_bitmap = 1;
 	}
 
+	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, fs_info->sectors_per_page) {
+		u64 start = page_start + (bit << fs_info->sectorsize_bits);
+
+		btrfs_folio_set_lock(fs_info, folio, start, fs_info->sectorsize);
+	}
+
 	/* Lock all (subpage) delalloc ranges inside the folio first. */
 	while (delalloc_start < page_end) {
 		delalloc_end = page_end;
@@ -1151,9 +1213,8 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			delalloc_start = delalloc_end + 1;
 			continue;
 		}
-		btrfs_folio_set_writer_lock(fs_info, folio, delalloc_start,
-					    min(delalloc_end, page_end) + 1 -
-					    delalloc_start);
+		set_delalloc_bitmap(folio, &delalloc_bitmap, delalloc_start,
+				    min(delalloc_end, page_end) + 1 - delalloc_start);
 		last_delalloc_end = delalloc_end;
 		delalloc_start = delalloc_end + 1;
 	}
@@ -1178,7 +1239,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			found_len = last_delalloc_end + 1 - found_start;
 			found = true;
 		} else {
-			found = btrfs_subpage_find_writer_locked(fs_info, folio,
+			found = find_next_delalloc_bitmap(folio, &delalloc_bitmap,
 					delalloc_start, &found_start, &found_len);
 		}
 		if (!found)
@@ -1192,11 +1253,19 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			found_len = last_delalloc_end + 1 - found_start;
 
 		if (ret >= 0) {
+			/*
+			 * Some delalloc range may be created by previous folios.
+			 * Thus we still need to clean up this range during error
+			 * handling.
+			 */
+			last_finished_delalloc_end = found_start;
 			/* No errors hit so far, run the current delalloc range. */
 			ret = btrfs_run_delalloc_range(inode, folio,
 						       found_start,
 						       found_start + found_len - 1,
 						       wbc);
+			if (ret >= 0)
+				last_finished_delalloc_end = found_start + found_len;
 		} else {
 			/*
 			 * We've hit an error during previous delalloc range,
@@ -1231,8 +1300,22 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 		delalloc_start = found_start + found_len;
 	}
-	if (ret < 0)
+	/*
+	 * It's possible we had some ordered extents created before we hit
+	 * an error, cleanup non-async successfully created delalloc ranges.
+	 */
+	if (unlikely(ret < 0)) {
+		unsigned int bitmap_size = min(
+				(last_finished_delalloc_end - page_start) >>
+				fs_info->sectorsize_bits,
+				fs_info->sectors_per_page);
+
+		for_each_set_bit(bit, &bio_ctrl->submit_bitmap, bitmap_size)
+			btrfs_mark_ordered_io_finished(inode, folio,
+				page_start + (bit << fs_info->sectorsize_bits),
+				fs_info->sectorsize, false);
 		return ret;
+	}
 out:
 	if (last_delalloc_end)
 		delalloc_end = last_delalloc_end;
@@ -1348,6 +1431,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long range_bitmap = 0;
 	bool submitted_io = false;
+	bool error = false;
 	const u64 folio_start = folio_pos(folio);
 	u64 cur;
 	int bit;
@@ -1390,13 +1474,26 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			break;
 		}
 		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
-		if (ret < 0)
-			goto out;
+		if (unlikely(ret < 0)) {
+			/*
+			 * bio_ctrl may contain a bio crossing several folios.
+			 * Submit it immediately so that the bio has a chance
+			 * to finish normally, other than marked as error.
+			 */
+			submit_one_bio(bio_ctrl);
+			/*
+			 * Failed to grab the extent map which should be very rare.
+			 * Since there is no bio submitted to finish the ordered
+			 * extent, we have to manually finish this sector.
+			 */
+			btrfs_mark_ordered_io_finished(inode, folio, cur,
+						       fs_info->sectorsize, false);
+			error = true;
+			continue;
+		}
 		submitted_io = true;
 	}
 
-	btrfs_folio_assert_not_dirty(fs_info, folio, start, len);
-out:
 	/*
 	 * If we didn't submitted any sector (>= i_size), folio dirty get
 	 * cleared but PAGECACHE_TAG_DIRTY is not cleared (only cleared
@@ -1404,8 +1501,11 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	 *
 	 * Here we set writeback and clear for the range. If the full folio
 	 * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
+	 *
+	 * If we hit any error, the corresponding sector will still be dirty
+	 * thus no need to clear PAGECACHE_TAG_DIRTY.
 	 */
-	if (!submitted_io) {
+	if (!submitted_io && !error) {
 		btrfs_folio_set_writeback(fs_info, folio, start, len);
 		btrfs_folio_clear_writeback(fs_info, folio, start, len);
 	}
@@ -1423,15 +1523,14 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
  */
 static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl)
 {
-	struct inode *inode = folio->mapping->host;
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	const u64 page_start = folio_pos(folio);
+	struct btrfs_inode *inode = BTRFS_I(folio->mapping->host);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int ret;
 	size_t pg_offset;
-	loff_t i_size = i_size_read(inode);
+	loff_t i_size = i_size_read(&inode->vfs_inode);
 	unsigned long end_index = i_size >> PAGE_SHIFT;
 
-	trace_extent_writepage(folio, inode, bio_ctrl->wbc);
+	trace_extent_writepage(folio, &inode->vfs_inode, bio_ctrl->wbc);
 
 	WARN_ON(!folio_test_locked(folio));
 
@@ -1455,13 +1554,13 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	if (ret < 0)
 		goto done;
 
-	ret = writepage_delalloc(BTRFS_I(inode), folio, bio_ctrl);
+	ret = writepage_delalloc(inode, folio, bio_ctrl);
 	if (ret == 1)
 		return 0;
 	if (ret)
 		goto done;
 
-	ret = extent_writepage_io(BTRFS_I(inode), folio, folio_pos(folio),
+	ret = extent_writepage_io(inode, folio, folio_pos(folio),
 				  PAGE_SIZE, bio_ctrl, i_size);
 	if (ret == 1)
 		return 0;
@@ -1469,17 +1568,13 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	bio_ctrl->wbc->nr_to_write--;
 
 done:
-	if (ret) {
-		btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
-					       page_start, PAGE_SIZE, !ret);
+	if (ret < 0)
 		mapping_set_error(folio->mapping, ret);
-	}
-
 	/*
 	 * Only unlock ranges that are submitted. As there can be some async
 	 * submitted ranges inside the folio.
 	 */
-	btrfs_folio_end_writer_lock_bitmap(fs_info, folio, bio_ctrl->submit_bitmap);
+	btrfs_folio_end_lock_bitmap(fs_info, folio, bio_ctrl->submit_bitmap);
 	ASSERT(ret <= 0);
 	return ret;
 }
@@ -2231,12 +2326,9 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 		if (ret == 1)
 			goto next_page;
 
-		if (ret) {
-			btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
-						       cur, cur_len, !ret);
+		if (ret)
 			mapping_set_error(mapping, ret);
-		}
-		btrfs_folio_end_writer_lock(fs_info, folio, cur, cur_len);
+		btrfs_folio_end_lock(fs_info, folio, cur, cur_len);
 		if (ret < 0)
 			found_error = true;
 next_page:
@@ -2463,12 +2555,6 @@ static bool folio_range_has_eb(struct btrfs_fs_info *fs_info, struct folio *foli
 		subpage = folio_get_private(folio);
 		if (atomic_read(&subpage->eb_refs))
 			return true;
-		/*
-		 * Even there is no eb refs here, we may still have
-		 * end_folio_read() call relying on page::private.
-		 */
-		if (atomic_read(&subpage->readers))
-			return true;
 	}
 	return false;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f7e7d864f414..5b842276573e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2419,8 +2419,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 
 out:
 	if (ret < 0)
-		btrfs_cleanup_ordered_extents(inode, locked_folio, start,
-					      end - start + 1);
+		btrfs_cleanup_ordered_extents(inode, NULL, start, end - start + 1);
 	return ret;
 }
 
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index ec7328a6bfd7..88a01d51ab11 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -140,12 +140,10 @@ struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 		return ERR_PTR(-ENOMEM);
 
 	spin_lock_init(&ret->lock);
-	if (type == BTRFS_SUBPAGE_METADATA) {
+	if (type == BTRFS_SUBPAGE_METADATA)
 		atomic_set(&ret->eb_refs, 0);
-	} else {
-		atomic_set(&ret->readers, 0);
-		atomic_set(&ret->writers, 0);
-	}
+	else
+		atomic_set(&ret->nr_locked, 0);
 	return ret;
 }
 
@@ -221,62 +219,6 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 	__start_bit;							\
 })
 
-void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
-				struct folio *folio, u64 start, u32 len)
-{
-	struct btrfs_subpage *subpage = folio_get_private(folio);
-	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
-	const int nbits = len >> fs_info->sectorsize_bits;
-	unsigned long flags;
-
-
-	btrfs_subpage_assert(fs_info, folio, start, len);
-
-	spin_lock_irqsave(&subpage->lock, flags);
-	/*
-	 * Even though it's just for reading the page, no one should have
-	 * locked the subpage range.
-	 */
-	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
-	bitmap_set(subpage->bitmaps, start_bit, nbits);
-	atomic_add(nbits, &subpage->readers);
-	spin_unlock_irqrestore(&subpage->lock, flags);
-}
-
-void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
-			      struct folio *folio, u64 start, u32 len)
-{
-	struct btrfs_subpage *subpage = folio_get_private(folio);
-	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
-	const int nbits = len >> fs_info->sectorsize_bits;
-	unsigned long flags;
-	bool is_data;
-	bool last;
-
-	btrfs_subpage_assert(fs_info, folio, start, len);
-	is_data = is_data_inode(BTRFS_I(folio->mapping->host));
-
-	spin_lock_irqsave(&subpage->lock, flags);
-
-	/* The range should have already been locked. */
-	ASSERT(bitmap_test_range_all_set(subpage->bitmaps, start_bit, nbits));
-	ASSERT(atomic_read(&subpage->readers) >= nbits);
-
-	bitmap_clear(subpage->bitmaps, start_bit, nbits);
-	last = atomic_sub_and_test(nbits, &subpage->readers);
-
-	/*
-	 * For data we need to unlock the page if the last read has finished.
-	 *
-	 * And please don't replace @last with atomic_sub_and_test() call
-	 * inside if () condition.
-	 * As we want the atomic_sub_and_test() to be always executed.
-	 */
-	if (is_data && last)
-		folio_unlock(folio);
-	spin_unlock_irqrestore(&subpage->lock, flags);
-}
-
 static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
 {
 	u64 orig_start = *start;
@@ -295,28 +237,8 @@ static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
 			     orig_start + orig_len) - *start;
 }
 
-static void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
-				       struct folio *folio, u64 start, u32 len)
-{
-	struct btrfs_subpage *subpage = folio_get_private(folio);
-	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
-	const int nbits = (len >> fs_info->sectorsize_bits);
-	unsigned long flags;
-	int ret;
-
-	btrfs_subpage_assert(fs_info, folio, start, len);
-
-	spin_lock_irqsave(&subpage->lock, flags);
-	ASSERT(atomic_read(&subpage->readers) == 0);
-	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
-	bitmap_set(subpage->bitmaps, start_bit, nbits);
-	ret = atomic_add_return(nbits, &subpage->writers);
-	ASSERT(ret == nbits);
-	spin_unlock_irqrestore(&subpage->lock, flags);
-}
-
-static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
-					      struct folio *folio, u64 start, u32 len)
+static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
+					    struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
@@ -334,9 +256,9 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
 	 * extent_clear_unlock_delalloc() for compression path.
 	 *
 	 * This @locked_page is locked by plain lock_page(), thus its
-	 * subpage::writers is 0.  Handle them in a special way.
+	 * subpage::locked is 0.  Handle them in a special way.
 	 */
-	if (atomic_read(&subpage->writers) == 0) {
+	if (atomic_read(&subpage->nr_locked) == 0) {
 		spin_unlock_irqrestore(&subpage->lock, flags);
 		return true;
 	}
@@ -345,39 +267,12 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
 		clear_bit(bit, subpage->bitmaps);
 		cleared++;
 	}
-	ASSERT(atomic_read(&subpage->writers) >= cleared);
-	last = atomic_sub_and_test(cleared, &subpage->writers);
+	ASSERT(atomic_read(&subpage->nr_locked) >= cleared);
+	last = atomic_sub_and_test(cleared, &subpage->nr_locked);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 	return last;
 }
 
-/*
- * Lock a folio for delalloc page writeback.
- *
- * Return -EAGAIN if the page is not properly initialized.
- * Return 0 with the page locked, and writer counter updated.
- *
- * Even with 0 returned, the page still need extra check to make sure
- * it's really the correct page, as the caller is using
- * filemap_get_folios_contig(), which can race with page invalidating.
- */
-int btrfs_folio_start_writer_lock(const struct btrfs_fs_info *fs_info,
-				  struct folio *folio, u64 start, u32 len)
-{
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping)) {
-		folio_lock(folio);
-		return 0;
-	}
-	folio_lock(folio);
-	if (!folio_test_private(folio) || !folio_get_private(folio)) {
-		folio_unlock(folio);
-		return -EAGAIN;
-	}
-	btrfs_subpage_clamp_range(folio, &start, &len);
-	btrfs_subpage_start_writer(fs_info, folio, start, len);
-	return 0;
-}
-
 /*
  * Handle different locked folios:
  *
@@ -394,8 +289,8 @@ int btrfs_folio_start_writer_lock(const struct btrfs_fs_info *fs_info,
  *   bitmap, reduce the writer lock number, and unlock the page if that's
  *   the last locked range.
  */
-void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
-				 struct folio *folio, u64 start, u32 len)
+void btrfs_folio_end_lock(const struct btrfs_fs_info *fs_info,
+			  struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 
@@ -408,24 +303,24 @@ void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
 
 	/*
 	 * For subpage case, there are two types of locked page.  With or
-	 * without writers number.
+	 * without locked number.
 	 *
-	 * Since we own the page lock, no one else could touch subpage::writers
+	 * Since we own the page lock, no one else could touch subpage::locked
 	 * and we are safe to do several atomic operations without spinlock.
 	 */
-	if (atomic_read(&subpage->writers) == 0) {
-		/* No writers, locked by plain lock_page(). */
+	if (atomic_read(&subpage->nr_locked) == 0) {
+		/* No subpage lock, locked by plain lock_page(). */
 		folio_unlock(folio);
 		return;
 	}
 
 	btrfs_subpage_clamp_range(folio, &start, &len);
-	if (btrfs_subpage_end_and_test_writer(fs_info, folio, start, len))
+	if (btrfs_subpage_end_and_test_lock(fs_info, folio, start, len))
 		folio_unlock(folio);
 }
 
-void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
-					struct folio *folio, unsigned long bitmap)
+void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
+				 struct folio *folio, unsigned long bitmap)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int start_bit = fs_info->sectors_per_page * btrfs_bitmap_nr_locked;
@@ -439,8 +334,8 @@ void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
 		return;
 	}
 
-	if (atomic_read(&subpage->writers) == 0) {
-		/* No writers, locked by plain lock_page(). */
+	if (atomic_read(&subpage->nr_locked) == 0) {
+		/* No subpage lock, locked by plain lock_page(). */
 		folio_unlock(folio);
 		return;
 	}
@@ -450,8 +345,8 @@ void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
 		if (test_and_clear_bit(bit + start_bit, subpage->bitmaps))
 			cleared++;
 	}
-	ASSERT(atomic_read(&subpage->writers) >= cleared);
-	last = atomic_sub_and_test(cleared, &subpage->writers);
+	ASSERT(atomic_read(&subpage->nr_locked) >= cleared);
+	last = atomic_sub_and_test(cleared, &subpage->nr_locked);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 	if (last)
 		folio_unlock(folio);
@@ -776,8 +671,8 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
  * This populates the involved subpage ranges so that subpage helpers can
  * properly unlock them.
  */
-void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
-				 struct folio *folio, u64 start, u32 len)
+void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
+			  struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage;
 	unsigned long flags;
@@ -796,58 +691,11 @@ void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
 	/* Target range should not yet be locked. */
 	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
 	bitmap_set(subpage->bitmaps, start_bit, nbits);
-	ret = atomic_add_return(nbits, &subpage->writers);
+	ret = atomic_add_return(nbits, &subpage->nr_locked);
 	ASSERT(ret <= fs_info->sectors_per_page);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
-/*
- * Find any subpage writer locked range inside @folio, starting at file offset
- * @search_start. The caller should ensure the folio is locked.
- *
- * Return true and update @found_start_ret and @found_len_ret to the first
- * writer locked range.
- * Return false if there is no writer locked range.
- */
-bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
-				      struct folio *folio, u64 search_start,
-				      u64 *found_start_ret, u32 *found_len_ret)
-{
-	struct btrfs_subpage *subpage = folio_get_private(folio);
-	const u32 sectors_per_page = fs_info->sectors_per_page;
-	const unsigned int len = PAGE_SIZE - offset_in_page(search_start);
-	const unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
-						locked, search_start, len);
-	const unsigned int locked_bitmap_start = sectors_per_page * btrfs_bitmap_nr_locked;
-	const unsigned int locked_bitmap_end = locked_bitmap_start + sectors_per_page;
-	unsigned long flags;
-	int first_zero;
-	int first_set;
-	bool found = false;
-
-	ASSERT(folio_test_locked(folio));
-	spin_lock_irqsave(&subpage->lock, flags);
-	first_set = find_next_bit(subpage->bitmaps, locked_bitmap_end, start_bit);
-	if (first_set >= locked_bitmap_end)
-		goto out;
-
-	found = true;
-
-	*found_start_ret = folio_pos(folio) +
-		((first_set - locked_bitmap_start) << fs_info->sectorsize_bits);
-	/*
-	 * Since @first_set is ensured to be smaller than locked_bitmap_end
-	 * here, @found_start_ret should be inside the folio.
-	 */
-	ASSERT(*found_start_ret < folio_pos(folio) + PAGE_SIZE);
-
-	first_zero = find_next_zero_bit(subpage->bitmaps, locked_bitmap_end, first_set);
-	*found_len_ret = (first_zero - first_set) << fs_info->sectorsize_bits;
-out:
-	spin_unlock_irqrestore(&subpage->lock, flags);
-	return found;
-}
-
 #define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
 {									\
 	const int sectors_per_page = fs_info->sectors_per_page;		\
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index cdb554e0d215..44fff1f4eac4 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -45,14 +45,6 @@ enum {
 struct btrfs_subpage {
 	/* Common members for both data and metadata pages */
 	spinlock_t lock;
-	/*
-	 * Both data and metadata needs to track how many readers are for the
-	 * page.
-	 * Data relies on @readers to unlock the page when last reader finished.
-	 * While metadata doesn't need page unlock, it needs to prevent
-	 * page::private get cleared before the last end_page_read().
-	 */
-	atomic_t readers;
 	union {
 		/*
 		 * Structures only used by metadata
@@ -62,8 +54,12 @@ struct btrfs_subpage {
 		 */
 		atomic_t eb_refs;
 
-		/* Structures only used by data */
-		atomic_t writers;
+		/*
+		 * Structures only used by data,
+		 *
+		 * How many sectors inside the page is locked.
+		 */
+		atomic_t nr_locked;
 	};
 	unsigned long bitmaps[];
 };
@@ -95,23 +91,12 @@ void btrfs_free_subpage(struct btrfs_subpage *subpage);
 void btrfs_folio_inc_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *folio);
 void btrfs_folio_dec_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *folio);
 
-void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
-				struct folio *folio, u64 start, u32 len);
-void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
-			      struct folio *folio, u64 start, u32 len);
-
-int btrfs_folio_start_writer_lock(const struct btrfs_fs_info *fs_info,
-				  struct folio *folio, u64 start, u32 len);
-void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
-				 struct folio *folio, u64 start, u32 len);
-void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
-				 struct folio *folio, u64 start, u32 len);
-void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
-					struct folio *folio, unsigned long bitmap);
-bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
-				      struct folio *folio, u64 search_start,
-				      u64 *found_start_ret, u32 *found_len_ret);
-
+void btrfs_folio_end_lock(const struct btrfs_fs_info *fs_info,
+			  struct folio *folio, u64 start, u32 len);
+void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
+			  struct folio *folio, u64 start, u32 len);
+void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
+				 struct folio *folio, unsigned long bitmap);
 /*
  * Template for subpage related operations.
  *
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index fafc07e38663..e11e67af760f 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1381,7 +1381,7 @@ int cifs_get_inode_info(struct inode **inode,
 	struct cifs_fattr fattr = {};
 	int rc;
 
-	if (is_inode_cache_good(*inode)) {
+	if (!data && is_inode_cache_good(*inode)) {
 		cifs_dbg(FYI, "No need to revalidate cached inode sizes\n");
 		return 0;
 	}
@@ -1480,7 +1480,7 @@ int smb311_posix_get_inode_info(struct inode **inode,
 	struct cifs_fattr fattr = {};
 	int rc;
 
-	if (is_inode_cache_good(*inode)) {
+	if (!data && is_inode_cache_good(*inode)) {
 		cifs_dbg(FYI, "No need to revalidate cached inode sizes\n");
 		return 0;
 	}
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 44952727fef9..e8da63d29a28 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4991,6 +4991,10 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 			next_buffer = (char *)cifs_buf_get();
 		else
 			next_buffer = (char *)cifs_small_buf_get();
+		if (!next_buffer) {
+			cifs_server_dbg(VFS, "No memory for (large) SMB response\n");
+			return -1;
+		}
 		memcpy(next_buffer, buf + next_cmd, pdu_length - next_cmd);
 	}
 
diff --git a/fs/xfs/scrub/common.h b/fs/xfs/scrub/common.h
index 47148cc4a833..eb00d48590f2 100644
--- a/fs/xfs/scrub/common.h
+++ b/fs/xfs/scrub/common.h
@@ -179,7 +179,6 @@ static inline bool xchk_skip_xref(struct xfs_scrub_metadata *sm)
 bool xchk_dir_looks_zapped(struct xfs_inode *dp);
 bool xchk_pptr_looks_zapped(struct xfs_inode *ip);
 
-#ifdef CONFIG_XFS_ONLINE_REPAIR
 /* Decide if a repair is required. */
 static inline bool xchk_needs_repair(const struct xfs_scrub_metadata *sm)
 {
@@ -199,10 +198,6 @@ static inline bool xchk_could_repair(const struct xfs_scrub *sc)
 	return (sc->sm->sm_flags & XFS_SCRUB_IFLAG_REPAIR) &&
 		!(sc->flags & XREP_ALREADY_FIXED);
 }
-#else
-# define xchk_needs_repair(sc)		(false)
-# define xchk_could_repair(sc)		(false)
-#endif /* CONFIG_XFS_ONLINE_REPAIR */
 
 int xchk_metadata_inode_forks(struct xfs_scrub *sc);
 
diff --git a/fs/xfs/scrub/repair.h b/fs/xfs/scrub/repair.h
index 0e0dc2bf985c..96180176c582 100644
--- a/fs/xfs/scrub/repair.h
+++ b/fs/xfs/scrub/repair.h
@@ -163,7 +163,16 @@ bool xrep_buf_verify_struct(struct xfs_buf *bp, const struct xfs_buf_ops *ops);
 #else
 
 #define xrep_ino_dqattach(sc)	(0)
-#define xrep_will_attempt(sc)	(false)
+
+/*
+ * When online repair is not built into the kernel, we still want to attempt
+ * the repair so that the stub xrep_attempt below will return EOPNOTSUPP.
+ */
+static inline bool xrep_will_attempt(const struct xfs_scrub *sc)
+{
+	return (sc->sm->sm_flags & XFS_SCRUB_IFLAG_FORCE_REBUILD) ||
+		xchk_needs_repair(sc->sm);
+}
 
 static inline int
 xrep_attempt(
diff --git a/fs/xfs/scrub/scrub.c b/fs/xfs/scrub/scrub.c
index 4cbcf7a86dbe..5c266d2842db 100644
--- a/fs/xfs/scrub/scrub.c
+++ b/fs/xfs/scrub/scrub.c
@@ -149,6 +149,18 @@ xchk_probe(
 	if (xchk_should_terminate(sc, &error))
 		return error;
 
+	/*
+	 * If the caller is probing to see if repair works but repair isn't
+	 * built into the kernel, return EOPNOTSUPP because that's the signal
+	 * that userspace expects.  If online repair is built in, set the
+	 * CORRUPT flag (without any of the usual tracing/logging) to force us
+	 * into xrep_probe.
+	 */
+	if (xchk_could_repair(sc)) {
+		if (!IS_ENABLED(CONFIG_XFS_ONLINE_REPAIR))
+			return -EOPNOTSUPP;
+		sc->sm->sm_flags |= XFS_SCRUB_OFLAG_CORRUPT;
+	}
 	return 0;
 }
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4f17b786828a..35b886385f32 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3064,6 +3064,8 @@ static inline struct net_device *first_net_device_rcu(struct net *net)
 }
 
 int netdev_boot_setup_check(struct net_device *dev);
+struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
+				   const char *hwaddr);
 struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 				       const char *hwaddr);
 struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4e77c4230c0a..74114acbb07f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2293,6 +2293,8 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
 #endif
 
+int pcim_intx(struct pci_dev *pdev, int enabled);
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				const char *name);
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 591a53e082e6..df1592022d93 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -75,12 +75,8 @@ struct pse_control_status {
  * @pi_disable: Configure the PSE PI as disabled.
  * @pi_get_voltage: Return voltage similarly to get_voltage regulator
  *		    callback.
- * @pi_get_current_limit: Get the configured current limit similarly to
- *			  get_current_limit regulator callback.
- * @pi_set_current_limit: Configure the current limit similarly to
- *			  set_current_limit regulator callback.
- *			  Should not return an error in case of MAX_PI_CURRENT
- *			  current value set.
+ * @pi_get_pw_limit: Get the configured power limit of the PSE PI.
+ * @pi_set_pw_limit: Configure the power limit of the PSE PI.
  */
 struct pse_controller_ops {
 	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
@@ -91,10 +87,10 @@ struct pse_controller_ops {
 	int (*pi_enable)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_disable)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_get_voltage)(struct pse_controller_dev *pcdev, int id);
-	int (*pi_get_current_limit)(struct pse_controller_dev *pcdev,
-				    int id);
-	int (*pi_set_current_limit)(struct pse_controller_dev *pcdev,
-				    int id, int max_uA);
+	int (*pi_get_pw_limit)(struct pse_controller_dev *pcdev,
+			       int id);
+	int (*pi_set_pw_limit)(struct pse_controller_dev *pcdev,
+			       int id, int max_mW);
 };
 
 struct module;
diff --git a/include/linux/serio.h b/include/linux/serio.h
index bf2191f25350..69a47674af65 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -6,6 +6,7 @@
 #define _SERIO_H
 
 
+#include <linux/cleanup.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
@@ -161,4 +162,6 @@ static inline void serio_continue_rx(struct serio *serio)
 	spin_unlock_irq(&serio->lock);
 }
 
+DEFINE_GUARD(serio_pause_rx, struct serio *, serio_pause_rx(_T), serio_continue_rx(_T))
+
 #endif
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 2cbe0c22a32f..0b9095a281b8 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -91,6 +91,8 @@ struct sk_psock {
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
 	struct strparser		strp;
+	u32				copied_seq;
+	u32				ingress_bytes;
 #endif
 	struct sk_buff_head		ingress_skb;
 	struct list_head		ingress_msg;
diff --git a/include/net/gro.h b/include/net/gro.h
index b9b58c1f8d19..7b548f91754b 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -11,6 +11,9 @@
 #include <net/udp.h>
 #include <net/hotdata.h>
 
+/* This should be increased if a protocol with a bigger head is added. */
+#define GRO_MAX_HEAD (MAX_HEADER + 128)
+
 struct napi_gro_cb {
 	union {
 		struct {
diff --git a/include/net/strparser.h b/include/net/strparser.h
index 41e2ce9e9e10..0a83010b3a64 100644
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@ -43,6 +43,8 @@ struct strparser;
 struct strp_callbacks {
 	int (*parse_msg)(struct strparser *strp, struct sk_buff *skb);
 	void (*rcv_msg)(struct strparser *strp, struct sk_buff *skb);
+	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
+			 sk_read_actor_t recv_actor);
 	int (*read_sock_done)(struct strparser *strp, int err);
 	void (*abort_parser)(struct strparser *strp, int err);
 	void (*lock)(struct strparser *strp);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index d1948d357dad..3255a199ef60 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -41,6 +41,7 @@
 #include <net/inet_ecn.h>
 #include <net/dst.h>
 #include <net/mptcp.h>
+#include <net/xfrm.h>
 
 #include <linux/seq_file.h>
 #include <linux/memcontrol.h>
@@ -683,6 +684,19 @@ void tcp_fin(struct sock *sk);
 void tcp_check_space(struct sock *sk);
 void tcp_sack_compress_send_ack(struct sock *sk);
 
+static inline void tcp_cleanup_skb(struct sk_buff *skb)
+{
+	skb_dst_drop(skb);
+	secpath_reset(skb);
+}
+
+static inline void tcp_add_receive_queue(struct sock *sk, struct sk_buff *skb)
+{
+	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
+	DEBUG_NET_WARN_ON_ONCE(secpath_exists(skb));
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+}
+
 /* tcp_timer.c */
 void tcp_init_xmit_timers(struct sock *);
 static inline void tcp_clear_xmit_timers(struct sock *sk)
@@ -729,6 +743,9 @@ void tcp_get_info(struct sock *, struct tcp_info *);
 /* Read 'sendfile()'-style from a TCP socket */
 int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		  sk_read_actor_t recv_actor);
+int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
+			sk_read_actor_t recv_actor, bool noack,
+			u32 *copied_seq);
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
 struct sk_buff *tcp_recv_skb(struct sock *sk, u32 seq, u32 *off);
 void tcp_read_done(struct sock *sk, size_t len);
@@ -2595,6 +2612,11 @@ struct sk_psock;
 #ifdef CONFIG_BPF_SYSCALL
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
+#ifdef CONFIG_BPF_STREAM_PARSER
+struct strparser;
+int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor);
+#endif /* CONFIG_BPF_STREAM_PARSER */
 #endif /* CONFIG_BPF_SYSCALL */
 
 #ifdef CONFIG_INET
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index c4182e95a619..4a8a4a63e99c 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1485,6 +1485,7 @@ struct drm_xe_oa_unit {
 	/** @capabilities: OA capabilities bit-mask */
 	__u64 capabilities;
 #define DRM_XE_OA_CAPS_BASE		(1 << 0)
+#define DRM_XE_OA_CAPS_SYNCS		(1 << 1)
 
 	/** @oa_timestamp_freq: OA timestamp freq */
 	__u64 oa_timestamp_freq;
@@ -1634,6 +1635,22 @@ enum drm_xe_oa_property_id {
 	 * to be disabled for the stream exec queue.
 	 */
 	DRM_XE_OA_PROPERTY_NO_PREEMPT,
+
+	/**
+	 * @DRM_XE_OA_PROPERTY_NUM_SYNCS: Number of syncs in the sync array
+	 * specified in @DRM_XE_OA_PROPERTY_SYNCS
+	 */
+	DRM_XE_OA_PROPERTY_NUM_SYNCS,
+
+	/**
+	 * @DRM_XE_OA_PROPERTY_SYNCS: Pointer to struct @drm_xe_sync array
+	 * with array size specified via @DRM_XE_OA_PROPERTY_NUM_SYNCS. OA
+	 * configuration will wait till input fences signal. Output fences
+	 * will signal after the new OA configuration takes effect. For
+	 * @DRM_XE_SYNC_TYPE_USER_FENCE, @addr is a user pointer, similar
+	 * to the VM bind case.
+	 */
+	DRM_XE_OA_PROPERTY_SYNCS,
 };
 
 /**
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 21f1bcba2f52..cf28d29fffbf 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2053,6 +2053,8 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		req->opcode = 0;
 		return io_init_fail_req(req, -EINVAL);
 	}
+	opcode = array_index_nospec(opcode, IORING_OP_LAST);
+
 	def = &io_issue_defs[opcode];
 	if (unlikely(sqe_flags & ~SQE_COMMON_FLAGS)) {
 		/* enforce forwards compatibility on users */
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 39ad25d16ed4..6abc495602a4 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -862,7 +862,15 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(ret))
 		return ret;
 
-	ret = io_iter_do_read(rw, &io->iter);
+	if (unlikely(req->opcode == IORING_OP_READ_MULTISHOT)) {
+		void *cb_copy = rw->kiocb.ki_complete;
+
+		rw->kiocb.ki_complete = NULL;
+		ret = io_iter_do_read(rw, &io->iter);
+		rw->kiocb.ki_complete = cb_copy;
+	} else {
+		ret = io_iter_do_read(rw, &io->iter);
+	}
 
 	/*
 	 * Some file systems like to return -EOPNOTSUPP for an IOCB_NOWAIT
@@ -887,7 +895,8 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
 	} else if (ret == -EIOCBQUEUED) {
 		return IOU_ISSUE_SKIP_COMPLETE;
 	} else if (ret == req->cqe.res || ret <= 0 || !force_nonblock ||
-		   (req->flags & REQ_F_NOWAIT) || !need_complete_io(req)) {
+		   (req->flags & REQ_F_NOWAIT) || !need_complete_io(req) ||
+		   (issue_flags & IO_URING_F_MULTISHOT)) {
 		/* read all, failed, already did sync or don't want to retry */
 		goto done;
 	}
diff --git a/kernel/acct.c b/kernel/acct.c
index 179848ad33e9..d9d55fa4d01a 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -103,48 +103,50 @@ struct bsd_acct_struct {
 	atomic_long_t		count;
 	struct rcu_head		rcu;
 	struct mutex		lock;
-	int			active;
+	bool			active;
+	bool			check_space;
 	unsigned long		needcheck;
 	struct file		*file;
 	struct pid_namespace	*ns;
 	struct work_struct	work;
 	struct completion	done;
+	acct_t			ac;
 };
 
-static void do_acct_process(struct bsd_acct_struct *acct);
+static void fill_ac(struct bsd_acct_struct *acct);
+static void acct_write_process(struct bsd_acct_struct *acct);
 
 /*
  * Check the amount of free space and suspend/resume accordingly.
  */
-static int check_free_space(struct bsd_acct_struct *acct)
+static bool check_free_space(struct bsd_acct_struct *acct)
 {
 	struct kstatfs sbuf;
 
-	if (time_is_after_jiffies(acct->needcheck))
-		goto out;
+	if (!acct->check_space)
+		return acct->active;
 
 	/* May block */
 	if (vfs_statfs(&acct->file->f_path, &sbuf))
-		goto out;
+		return acct->active;
 
 	if (acct->active) {
 		u64 suspend = sbuf.f_blocks * SUSPEND;
 		do_div(suspend, 100);
 		if (sbuf.f_bavail <= suspend) {
-			acct->active = 0;
+			acct->active = false;
 			pr_info("Process accounting paused\n");
 		}
 	} else {
 		u64 resume = sbuf.f_blocks * RESUME;
 		do_div(resume, 100);
 		if (sbuf.f_bavail >= resume) {
-			acct->active = 1;
+			acct->active = true;
 			pr_info("Process accounting resumed\n");
 		}
 	}
 
 	acct->needcheck = jiffies + ACCT_TIMEOUT*HZ;
-out:
 	return acct->active;
 }
 
@@ -189,7 +191,11 @@ static void acct_pin_kill(struct fs_pin *pin)
 {
 	struct bsd_acct_struct *acct = to_acct(pin);
 	mutex_lock(&acct->lock);
-	do_acct_process(acct);
+	/*
+	 * Fill the accounting struct with the exiting task's info
+	 * before punting to the workqueue.
+	 */
+	fill_ac(acct);
 	schedule_work(&acct->work);
 	wait_for_completion(&acct->done);
 	cmpxchg(&acct->ns->bacct, pin, NULL);
@@ -202,6 +208,9 @@ static void close_work(struct work_struct *work)
 {
 	struct bsd_acct_struct *acct = container_of(work, struct bsd_acct_struct, work);
 	struct file *file = acct->file;
+
+	/* We were fired by acct_pin_kill() which holds acct->lock. */
+	acct_write_process(acct);
 	if (file->f_op->flush)
 		file->f_op->flush(file, NULL);
 	__fput_sync(file);
@@ -234,6 +243,20 @@ static int acct_on(struct filename *pathname)
 		return -EACCES;
 	}
 
+	/* Exclude kernel kernel internal filesystems. */
+	if (file_inode(file)->i_sb->s_flags & (SB_NOUSER | SB_KERNMOUNT)) {
+		kfree(acct);
+		filp_close(file, NULL);
+		return -EINVAL;
+	}
+
+	/* Exclude procfs and sysfs. */
+	if (file_inode(file)->i_sb->s_iflags & SB_I_USERNS_VISIBLE) {
+		kfree(acct);
+		filp_close(file, NULL);
+		return -EINVAL;
+	}
+
 	if (!(file->f_mode & FMODE_CAN_WRITE)) {
 		kfree(acct);
 		filp_close(file, NULL);
@@ -430,13 +453,27 @@ static u32 encode_float(u64 value)
  *  do_exit() or when switching to a different output file.
  */
 
-static void fill_ac(acct_t *ac)
+static void fill_ac(struct bsd_acct_struct *acct)
 {
 	struct pacct_struct *pacct = &current->signal->pacct;
+	struct file *file = acct->file;
+	acct_t *ac = &acct->ac;
 	u64 elapsed, run_time;
 	time64_t btime;
 	struct tty_struct *tty;
 
+	lockdep_assert_held(&acct->lock);
+
+	if (time_is_after_jiffies(acct->needcheck)) {
+		acct->check_space = false;
+
+		/* Don't fill in @ac if nothing will be written. */
+		if (!acct->active)
+			return;
+	} else {
+		acct->check_space = true;
+	}
+
 	/*
 	 * Fill the accounting struct with the needed info as recorded
 	 * by the different kernel functions.
@@ -484,64 +521,61 @@ static void fill_ac(acct_t *ac)
 	ac->ac_majflt = encode_comp_t(pacct->ac_majflt);
 	ac->ac_exitcode = pacct->ac_exitcode;
 	spin_unlock_irq(&current->sighand->siglock);
-}
-/*
- *  do_acct_process does all actual work. Caller holds the reference to file.
- */
-static void do_acct_process(struct bsd_acct_struct *acct)
-{
-	acct_t ac;
-	unsigned long flim;
-	const struct cred *orig_cred;
-	struct file *file = acct->file;
 
-	/*
-	 * Accounting records are not subject to resource limits.
-	 */
-	flim = rlimit(RLIMIT_FSIZE);
-	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
-	/* Perform file operations on behalf of whoever enabled accounting */
-	orig_cred = override_creds(file->f_cred);
-
-	/*
-	 * First check to see if there is enough free_space to continue
-	 * the process accounting system.
-	 */
-	if (!check_free_space(acct))
-		goto out;
-
-	fill_ac(&ac);
 	/* we really need to bite the bullet and change layout */
-	ac.ac_uid = from_kuid_munged(file->f_cred->user_ns, orig_cred->uid);
-	ac.ac_gid = from_kgid_munged(file->f_cred->user_ns, orig_cred->gid);
+	ac->ac_uid = from_kuid_munged(file->f_cred->user_ns, current_uid());
+	ac->ac_gid = from_kgid_munged(file->f_cred->user_ns, current_gid());
 #if ACCT_VERSION == 1 || ACCT_VERSION == 2
 	/* backward-compatible 16 bit fields */
-	ac.ac_uid16 = ac.ac_uid;
-	ac.ac_gid16 = ac.ac_gid;
+	ac->ac_uid16 = ac->ac_uid;
+	ac->ac_gid16 = ac->ac_gid;
 #elif ACCT_VERSION == 3
 	{
 		struct pid_namespace *ns = acct->ns;
 
-		ac.ac_pid = task_tgid_nr_ns(current, ns);
+		ac->ac_pid = task_tgid_nr_ns(current, ns);
 		rcu_read_lock();
-		ac.ac_ppid = task_tgid_nr_ns(rcu_dereference(current->real_parent),
-					     ns);
+		ac->ac_ppid = task_tgid_nr_ns(rcu_dereference(current->real_parent), ns);
 		rcu_read_unlock();
 	}
 #endif
+}
+
+static void acct_write_process(struct bsd_acct_struct *acct)
+{
+	struct file *file = acct->file;
+	const struct cred *cred;
+	acct_t *ac = &acct->ac;
+
+	/* Perform file operations on behalf of whoever enabled accounting */
+	cred = override_creds(file->f_cred);
+
 	/*
-	 * Get freeze protection. If the fs is frozen, just skip the write
-	 * as we could deadlock the system otherwise.
+	 * First check to see if there is enough free_space to continue
+	 * the process accounting system. Then get freeze protection. If
+	 * the fs is frozen, just skip the write as we could deadlock
+	 * the system otherwise.
 	 */
-	if (file_start_write_trylock(file)) {
+	if (check_free_space(acct) && file_start_write_trylock(file)) {
 		/* it's been opened O_APPEND, so position is irrelevant */
 		loff_t pos = 0;
-		__kernel_write(file, &ac, sizeof(acct_t), &pos);
+		__kernel_write(file, ac, sizeof(acct_t), &pos);
 		file_end_write(file);
 	}
-out:
+
+	revert_creds(cred);
+}
+
+static void do_acct_process(struct bsd_acct_struct *acct)
+{
+	unsigned long flim;
+
+	/* Accounting records are not subject to resource limits. */
+	flim = rlimit(RLIMIT_FSIZE);
+	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
+	fill_ac(acct);
+	acct_write_process(acct);
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
-	revert_creds(orig_cred);
 }
 
 /**
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 93e48c7cad4e..8c775a1401d3 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -37,7 +37,7 @@
  */
 
 /* number of bytes addressable by LDX/STX insn with 16-bit 'off' field */
-#define GUARD_SZ (1ull << sizeof_field(struct bpf_insn, off) * 8)
+#define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off) * 8, PAGE_SIZE << 1)
 #define KERN_VM_SZ (SZ_4G + GUARD_SZ)
 
 struct bpf_arena {
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 28efd0a3f220..6547fb7ac0dc 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -154,7 +154,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 
 static void cgroup_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
+	bpf_local_storage_map_free(map, &cgroup_cache, &bpf_cgrp_storage_busy);
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a44f4be592be..2c54c148a94f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6483,6 +6483,8 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
 	/* rxrpc */
 	{ "rxrpc_recvdata", 0x1 },
 	{ "rxrpc_resend", 0x10 },
+	/* skb */
+	{"kfree_skb", 0x1000},
 	/* sunrpc */
 	{ "xs_stream_read_data", 0x1 },
 	/* ... from xprt_cong_event event class */
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index e1cfe890e0be..1499d8caa9a3 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -268,8 +268,6 @@ static int ringbuf_map_mmap_kern(struct bpf_map *map, struct vm_area_struct *vma
 		/* allow writable mapping for the consumer_pos only */
 		if (vma->vm_pgoff != 0 || vma->vm_end - vma->vm_start != PAGE_SIZE)
 			return -EPERM;
-	} else {
-		vm_flags_clear(vma, VM_MAYWRITE);
 	}
 	/* remap_vmalloc_range() checks size and offset constraints */
 	return remap_vmalloc_range(vma, rb_map->rb,
@@ -289,8 +287,6 @@ static int ringbuf_map_mmap_user(struct bpf_map *map, struct vm_area_struct *vma
 			 * position, and the ring buffer data itself.
 			 */
 			return -EPERM;
-	} else {
-		vm_flags_clear(vma, VM_MAYWRITE);
 	}
 	/* remap_vmalloc_range() checks size and offset constraints */
 	return remap_vmalloc_range(vma, rb_map->rb, vma->vm_pgoff + RINGBUF_PGOFF);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 368ae8d231d4..696e5a2cbea2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -936,7 +936,7 @@ static const struct vm_operations_struct bpf_map_default_vmops = {
 static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct bpf_map *map = filp->private_data;
-	int err;
+	int err = 0;
 
 	if (!map->ops->map_mmap || !IS_ERR_OR_NULL(map->record))
 		return -ENOTSUPP;
@@ -960,24 +960,33 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 			err = -EACCES;
 			goto out;
 		}
+		bpf_map_write_active_inc(map);
 	}
+out:
+	mutex_unlock(&map->freeze_mutex);
+	if (err)
+		return err;
 
 	/* set default open/close callbacks */
 	vma->vm_ops = &bpf_map_default_vmops;
 	vma->vm_private_data = map;
 	vm_flags_clear(vma, VM_MAYEXEC);
+	/* If mapping is read-only, then disallow potentially re-mapping with
+	 * PROT_WRITE by dropping VM_MAYWRITE flag. This VM_MAYWRITE clearing
+	 * means that as far as BPF map's memory-mapped VMAs are concerned,
+	 * VM_WRITE and VM_MAYWRITE and equivalent, if one of them is set,
+	 * both should be set, so we can forget about VM_MAYWRITE and always
+	 * check just VM_WRITE
+	 */
 	if (!(vma->vm_flags & VM_WRITE))
-		/* disallow re-mapping with PROT_WRITE */
 		vm_flags_clear(vma, VM_MAYWRITE);
 
 	err = map->ops->map_mmap(map, vma);
-	if (err)
-		goto out;
+	if (err) {
+		if (vma->vm_flags & VM_WRITE)
+			bpf_map_write_active_dec(map);
+	}
 
-	if (vma->vm_flags & VM_MAYWRITE)
-		bpf_map_write_active_inc(map);
-out:
-	mutex_unlock(&map->freeze_mutex);
 	return err;
 }
 
@@ -1863,8 +1872,6 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	return err;
 }
 
-#define MAP_LOOKUP_RETRIES 3
-
 int generic_map_lookup_batch(struct bpf_map *map,
 				    const union bpf_attr *attr,
 				    union bpf_attr __user *uattr)
@@ -1874,8 +1881,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	void __user *values = u64_to_user_ptr(attr->batch.values);
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
 	void *buf, *buf_prevkey, *prev_key, *key, *value;
-	int err, retry = MAP_LOOKUP_RETRIES;
 	u32 value_size, cp, max_count;
+	int err;
 
 	if (attr->batch.elem_flags & ~BPF_F_LOCK)
 		return -EINVAL;
@@ -1921,14 +1928,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
 		err = bpf_map_copy_value(map, key, value,
 					 attr->batch.elem_flags);
 
-		if (err == -ENOENT) {
-			if (retry) {
-				retry--;
-				continue;
-			}
-			err = -EINTR;
-			break;
-		}
+		if (err == -ENOENT)
+			goto next_key;
 
 		if (err)
 			goto free_buf;
@@ -1943,12 +1944,12 @@ int generic_map_lookup_batch(struct bpf_map *map,
 			goto free_buf;
 		}
 
+		cp++;
+next_key:
 		if (!prev_key)
 			prev_key = buf_prevkey;
 
 		swap(prev_key, key);
-		retry = MAP_LOOKUP_RETRIES;
-		cp++;
 		cond_resched();
 	}
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 689f7e8f69f5..aa57ae3eb1ff 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2300,12 +2300,35 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
  *
  * - The BPF scheduler is bypassed while the rq is offline and we can always say
  *   no to the BPF scheduler initiated migrations while offline.
+ *
+ * The caller must ensure that @p and @rq are on different CPUs.
  */
 static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq,
 				      bool trigger_error)
 {
 	int cpu = cpu_of(rq);
 
+	SCHED_WARN_ON(task_cpu(p) == cpu);
+
+	/*
+	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
+	 * the pinned CPU in migrate_disable_switch() while @p is being switched
+	 * out. However, put_prev_task_scx() is called before @p->cpus_ptr is
+	 * updated and thus another CPU may see @p on a DSQ inbetween leading to
+	 * @p passing the below task_allowed_on_cpu() check while migration is
+	 * disabled.
+	 *
+	 * Test the migration disabled state first as the race window is narrow
+	 * and the BPF scheduler failing to check migration disabled state can
+	 * easily be masked if task_allowed_on_cpu() is done first.
+	 */
+	if (unlikely(is_migration_disabled(p))) {
+		if (trigger_error)
+			scx_ops_error("SCX_DSQ_LOCAL[_ON] cannot move migration disabled %s[%d] from CPU %d to %d",
+				      p->comm, p->pid, task_cpu(p), cpu);
+		return false;
+	}
+
 	/*
 	 * We don't require the BPF scheduler to avoid dispatching to offline
 	 * CPUs mostly for convenience but also because CPUs can go offline
@@ -2314,14 +2337,11 @@ static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq,
 	 */
 	if (!task_allowed_on_cpu(p, cpu)) {
 		if (trigger_error)
-			scx_ops_error("SCX_DSQ_LOCAL[_ON] verdict target cpu %d not allowed for %s[%d]",
-				      cpu_of(rq), p->comm, p->pid);
+			scx_ops_error("SCX_DSQ_LOCAL[_ON] target CPU %d not allowed for %s[%d]",
+				      cpu, p->comm, p->pid);
 		return false;
 	}
 
-	if (unlikely(is_migration_disabled(p)))
-		return false;
-
 	if (!scx_rq_online(rq))
 		return false;
 
@@ -2397,6 +2417,74 @@ static inline bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *r
 static inline bool consume_remote_task(struct rq *this_rq, struct task_struct *p, struct scx_dispatch_q *dsq, struct rq *task_rq) { return false; }
 #endif	/* CONFIG_SMP */
 
+/**
+ * move_task_between_dsqs() - Move a task from one DSQ to another
+ * @p: target task
+ * @enq_flags: %SCX_ENQ_*
+ * @src_dsq: DSQ @p is currently on, must not be a local DSQ
+ * @dst_dsq: DSQ @p is being moved to, can be any DSQ
+ *
+ * Must be called with @p's task_rq and @src_dsq locked. If @dst_dsq is a local
+ * DSQ and @p is on a different CPU, @p will be migrated and thus its task_rq
+ * will change. As @p's task_rq is locked, this function doesn't need to use the
+ * holding_cpu mechanism.
+ *
+ * On return, @src_dsq is unlocked and only @p's new task_rq, which is the
+ * return value, is locked.
+ */
+static struct rq *move_task_between_dsqs(struct task_struct *p, u64 enq_flags,
+					 struct scx_dispatch_q *src_dsq,
+					 struct scx_dispatch_q *dst_dsq)
+{
+	struct rq *src_rq = task_rq(p), *dst_rq;
+
+	BUG_ON(src_dsq->id == SCX_DSQ_LOCAL);
+	lockdep_assert_held(&src_dsq->lock);
+	lockdep_assert_rq_held(src_rq);
+
+	if (dst_dsq->id == SCX_DSQ_LOCAL) {
+		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
+		if (src_rq != dst_rq &&
+		    unlikely(!task_can_run_on_remote_rq(p, dst_rq, true))) {
+			dst_dsq = find_global_dsq(p);
+			dst_rq = src_rq;
+		}
+	} else {
+		/* no need to migrate if destination is a non-local DSQ */
+		dst_rq = src_rq;
+	}
+
+	/*
+	 * Move @p into $dst_dsq. If $dst_dsq is the local DSQ of a different
+	 * CPU, @p will be migrated.
+	 */
+	if (dst_dsq->id == SCX_DSQ_LOCAL) {
+		/* @p is going from a non-local DSQ to a local DSQ */
+		if (src_rq == dst_rq) {
+			task_unlink_from_dsq(p, src_dsq);
+			move_local_task_to_local_dsq(p, enq_flags,
+						     src_dsq, dst_rq);
+			raw_spin_unlock(&src_dsq->lock);
+		} else {
+			raw_spin_unlock(&src_dsq->lock);
+			move_remote_task_to_local_dsq(p, enq_flags,
+						      src_rq, dst_rq);
+		}
+	} else {
+		/*
+		 * @p is going from a non-local DSQ to a non-local DSQ. As
+		 * $src_dsq is already locked, do an abbreviated dequeue.
+		 */
+		task_unlink_from_dsq(p, src_dsq);
+		p->scx.dsq = NULL;
+		raw_spin_unlock(&src_dsq->lock);
+
+		dispatch_enqueue(dst_dsq, p, enq_flags);
+	}
+
+	return dst_rq;
+}
+
 static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
 {
 	struct task_struct *p;
@@ -2474,7 +2562,8 @@ static void dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
 	}
 
 #ifdef CONFIG_SMP
-	if (unlikely(!task_can_run_on_remote_rq(p, dst_rq, true))) {
+	if (src_rq != dst_rq &&
+	    unlikely(!task_can_run_on_remote_rq(p, dst_rq, true))) {
 		dispatch_enqueue(find_global_dsq(p), p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
@@ -6134,7 +6223,7 @@ static bool scx_dispatch_from_dsq(struct bpf_iter_scx_dsq_kern *kit,
 				  u64 enq_flags)
 {
 	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
-	struct rq *this_rq, *src_rq, *dst_rq, *locked_rq;
+	struct rq *this_rq, *src_rq, *locked_rq;
 	bool dispatched = false;
 	bool in_balance;
 	unsigned long flags;
@@ -6180,51 +6269,18 @@ static bool scx_dispatch_from_dsq(struct bpf_iter_scx_dsq_kern *kit,
 	/* @p is still on $src_dsq and stable, determine the destination */
 	dst_dsq = find_dsq_for_dispatch(this_rq, dsq_id, p);
 
-	if (dst_dsq->id == SCX_DSQ_LOCAL) {
-		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
-		if (!task_can_run_on_remote_rq(p, dst_rq, true)) {
-			dst_dsq = find_global_dsq(p);
-			dst_rq = src_rq;
-		}
-	} else {
-		/* no need to migrate if destination is a non-local DSQ */
-		dst_rq = src_rq;
-	}
-
 	/*
-	 * Move @p into $dst_dsq. If $dst_dsq is the local DSQ of a different
-	 * CPU, @p will be migrated.
+	 * Apply vtime and slice updates before moving so that the new time is
+	 * visible before inserting into $dst_dsq. @p is still on $src_dsq but
+	 * this is safe as we're locking it.
 	 */
-	if (dst_dsq->id == SCX_DSQ_LOCAL) {
-		/* @p is going from a non-local DSQ to a local DSQ */
-		if (src_rq == dst_rq) {
-			task_unlink_from_dsq(p, src_dsq);
-			move_local_task_to_local_dsq(p, enq_flags,
-						     src_dsq, dst_rq);
-			raw_spin_unlock(&src_dsq->lock);
-		} else {
-			raw_spin_unlock(&src_dsq->lock);
-			move_remote_task_to_local_dsq(p, enq_flags,
-						      src_rq, dst_rq);
-			locked_rq = dst_rq;
-		}
-	} else {
-		/*
-		 * @p is going from a non-local DSQ to a non-local DSQ. As
-		 * $src_dsq is already locked, do an abbreviated dequeue.
-		 */
-		task_unlink_from_dsq(p, src_dsq);
-		p->scx.dsq = NULL;
-		raw_spin_unlock(&src_dsq->lock);
-
-		if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_VTIME)
-			p->scx.dsq_vtime = kit->vtime;
-		dispatch_enqueue(dst_dsq, p, enq_flags);
-	}
-
+	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_VTIME)
+		p->scx.dsq_vtime = kit->vtime;
 	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_SLICE)
 		p->scx.slice = kit->slice;
 
+	/* execute move */
+	locked_rq = move_task_between_dsqs(p, enq_flags, src_dsq, dst_dsq);
 	dispatched = true;
 out:
 	if (in_balance) {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index cd9dbfb30383..71cc1bbfe9aa 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3219,15 +3219,22 @@ static struct ftrace_hash *copy_hash(struct ftrace_hash *src)
  *  The filter_hash updates uses just the append_hash() function
  *  and the notrace_hash does not.
  */
-static int append_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash)
+static int append_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash,
+		       int size_bits)
 {
 	struct ftrace_func_entry *entry;
 	int size;
 	int i;
 
-	/* An empty hash does everything */
-	if (ftrace_hash_empty(*hash))
-		return 0;
+	if (*hash) {
+		/* An empty hash does everything */
+		if (ftrace_hash_empty(*hash))
+			return 0;
+	} else {
+		*hash = alloc_ftrace_hash(size_bits);
+		if (!*hash)
+			return -ENOMEM;
+	}
 
 	/* If new_hash has everything make hash have everything */
 	if (ftrace_hash_empty(new_hash)) {
@@ -3291,16 +3298,18 @@ static int intersect_hash(struct ftrace_hash **hash, struct ftrace_hash *new_has
 /* Return a new hash that has a union of all @ops->filter_hash entries */
 static struct ftrace_hash *append_hashes(struct ftrace_ops *ops)
 {
-	struct ftrace_hash *new_hash;
+	struct ftrace_hash *new_hash = NULL;
 	struct ftrace_ops *subops;
+	int size_bits;
 	int ret;
 
-	new_hash = alloc_ftrace_hash(ops->func_hash->filter_hash->size_bits);
-	if (!new_hash)
-		return NULL;
+	if (ops->func_hash->filter_hash)
+		size_bits = ops->func_hash->filter_hash->size_bits;
+	else
+		size_bits = FTRACE_HASH_DEFAULT_BITS;
 
 	list_for_each_entry(subops, &ops->subop_list, list) {
-		ret = append_hash(&new_hash, subops->func_hash->filter_hash);
+		ret = append_hash(&new_hash, subops->func_hash->filter_hash, size_bits);
 		if (ret < 0) {
 			free_ftrace_hash(new_hash);
 			return NULL;
@@ -3309,7 +3318,8 @@ static struct ftrace_hash *append_hashes(struct ftrace_ops *ops)
 		if (ftrace_hash_empty(new_hash))
 			break;
 	}
-	return new_hash;
+	/* Can't return NULL as that means this failed */
+	return new_hash ? : EMPTY_HASH;
 }
 
 /* Make @ops trace evenything except what all its subops do not trace */
@@ -3504,7 +3514,8 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
 		filter_hash = alloc_and_copy_ftrace_hash(size_bits, ops->func_hash->filter_hash);
 		if (!filter_hash)
 			return -ENOMEM;
-		ret = append_hash(&filter_hash, subops->func_hash->filter_hash);
+		ret = append_hash(&filter_hash, subops->func_hash->filter_hash,
+				  size_bits);
 		if (ret < 0) {
 			free_ftrace_hash(filter_hash);
 			return ret;
@@ -5747,6 +5758,9 @@ __ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 			return -ENOENT;
 		free_hash_entry(hash, entry);
 		return 0;
+	} else if (__ftrace_lookup_ip(hash, ip) != NULL) {
+		/* Already exists */
+		return 0;
 	}
 
 	entry = add_hash_entry(hash, ip);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bfc4ac265c2c..ffe1422ab03f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -26,6 +26,7 @@
 #include <linux/hardirq.h>
 #include <linux/linkage.h>
 #include <linux/uaccess.h>
+#include <linux/cleanup.h>
 #include <linux/vmalloc.h>
 #include <linux/ftrace.h>
 #include <linux/module.h>
@@ -535,19 +536,16 @@ LIST_HEAD(ftrace_trace_arrays);
 int trace_array_get(struct trace_array *this_tr)
 {
 	struct trace_array *tr;
-	int ret = -ENODEV;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		if (tr == this_tr) {
 			tr->ref++;
-			ret = 0;
-			break;
+			return 0;
 		}
 	}
-	mutex_unlock(&trace_types_lock);
 
-	return ret;
+	return -ENODEV;
 }
 
 static void __trace_array_put(struct trace_array *this_tr)
@@ -1456,22 +1454,20 @@ EXPORT_SYMBOL_GPL(tracing_snapshot_alloc);
 int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
 				 cond_update_fn_t update)
 {
-	struct cond_snapshot *cond_snapshot;
-	int ret = 0;
+	struct cond_snapshot *cond_snapshot __free(kfree) =
+		kzalloc(sizeof(*cond_snapshot), GFP_KERNEL);
+	int ret;
 
-	cond_snapshot = kzalloc(sizeof(*cond_snapshot), GFP_KERNEL);
 	if (!cond_snapshot)
 		return -ENOMEM;
 
 	cond_snapshot->cond_data = cond_data;
 	cond_snapshot->update = update;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
-	if (tr->current_trace->use_max_tr) {
-		ret = -EBUSY;
-		goto fail_unlock;
-	}
+	if (tr->current_trace->use_max_tr)
+		return -EBUSY;
 
 	/*
 	 * The cond_snapshot can only change to NULL without the
@@ -1481,29 +1477,20 @@ int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
 	 * do safely with only holding the trace_types_lock and not
 	 * having to take the max_lock.
 	 */
-	if (tr->cond_snapshot) {
-		ret = -EBUSY;
-		goto fail_unlock;
-	}
+	if (tr->cond_snapshot)
+		return -EBUSY;
 
 	ret = tracing_arm_snapshot_locked(tr);
 	if (ret)
-		goto fail_unlock;
+		return ret;
 
 	local_irq_disable();
 	arch_spin_lock(&tr->max_lock);
-	tr->cond_snapshot = cond_snapshot;
+	tr->cond_snapshot = no_free_ptr(cond_snapshot);
 	arch_spin_unlock(&tr->max_lock);
 	local_irq_enable();
 
-	mutex_unlock(&trace_types_lock);
-
-	return ret;
-
- fail_unlock:
-	mutex_unlock(&trace_types_lock);
-	kfree(cond_snapshot);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(tracing_snapshot_cond_enable);
 
@@ -2216,10 +2203,10 @@ static __init int init_trace_selftests(void)
 
 	selftests_can_run = true;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	if (list_empty(&postponed_selftests))
-		goto out;
+		return 0;
 
 	pr_info("Running postponed tracer tests:\n");
 
@@ -2248,9 +2235,6 @@ static __init int init_trace_selftests(void)
 	}
 	tracing_selftest_running = false;
 
- out:
-	mutex_unlock(&trace_types_lock);
-
 	return 0;
 }
 core_initcall(init_trace_selftests);
@@ -2818,7 +2802,7 @@ int tracepoint_printk_sysctl(const struct ctl_table *table, int write,
 	int save_tracepoint_printk;
 	int ret;
 
-	mutex_lock(&tracepoint_printk_mutex);
+	guard(mutex)(&tracepoint_printk_mutex);
 	save_tracepoint_printk = tracepoint_printk;
 
 	ret = proc_dointvec(table, write, buffer, lenp, ppos);
@@ -2831,16 +2815,13 @@ int tracepoint_printk_sysctl(const struct ctl_table *table, int write,
 		tracepoint_printk = 0;
 
 	if (save_tracepoint_printk == tracepoint_printk)
-		goto out;
+		return ret;
 
 	if (tracepoint_printk)
 		static_key_enable(&tracepoint_printk_key.key);
 	else
 		static_key_disable(&tracepoint_printk_key.key);
 
- out:
-	mutex_unlock(&tracepoint_printk_mutex);
-
 	return ret;
 }
 
@@ -5150,7 +5131,8 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
 	u32 tracer_flags;
 	int i;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
+
 	tracer_flags = tr->current_trace->flags->val;
 	trace_opts = tr->current_trace->flags->opts;
 
@@ -5167,7 +5149,6 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
 		else
 			seq_printf(m, "no%s\n", trace_opts[i].name);
 	}
-	mutex_unlock(&trace_types_lock);
 
 	return 0;
 }
@@ -5832,7 +5813,7 @@ trace_insert_eval_map_file(struct module *mod, struct trace_eval_map **start,
 		return;
 	}
 
-	mutex_lock(&trace_eval_mutex);
+	guard(mutex)(&trace_eval_mutex);
 
 	if (!trace_eval_maps)
 		trace_eval_maps = map_array;
@@ -5856,8 +5837,6 @@ trace_insert_eval_map_file(struct module *mod, struct trace_eval_map **start,
 		map_array++;
 	}
 	memset(map_array, 0, sizeof(*map_array));
-
-	mutex_unlock(&trace_eval_mutex);
 }
 
 static void trace_create_eval_file(struct dentry *d_tracer)
@@ -6019,26 +5998,15 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 				  unsigned long size, int cpu_id)
 {
-	int ret;
-
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	if (cpu_id != RING_BUFFER_ALL_CPUS) {
 		/* make sure, this cpu is enabled in the mask */
-		if (!cpumask_test_cpu(cpu_id, tracing_buffer_mask)) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!cpumask_test_cpu(cpu_id, tracing_buffer_mask))
+			return -EINVAL;
 	}
 
-	ret = __tracing_resize_ring_buffer(tr, size, cpu_id);
-	if (ret < 0)
-		ret = -ENOMEM;
-
-out:
-	mutex_unlock(&trace_types_lock);
-
-	return ret;
+	return __tracing_resize_ring_buffer(tr, size, cpu_id);
 }
 
 static void update_last_data(struct trace_array *tr)
@@ -6129,9 +6097,9 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 #ifdef CONFIG_TRACER_MAX_TRACE
 	bool had_max_tr;
 #endif
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	update_last_data(tr);
 
@@ -6139,7 +6107,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 		ret = __tracing_resize_ring_buffer(tr, trace_buf_size,
 						RING_BUFFER_ALL_CPUS);
 		if (ret < 0)
-			goto out;
+			return ret;
 		ret = 0;
 	}
 
@@ -6147,43 +6115,37 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 		if (strcmp(t->name, buf) == 0)
 			break;
 	}
-	if (!t) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!t)
+		return -EINVAL;
+
 	if (t == tr->current_trace)
-		goto out;
+		return 0;
 
 #ifdef CONFIG_TRACER_SNAPSHOT
 	if (t->use_max_tr) {
 		local_irq_disable();
 		arch_spin_lock(&tr->max_lock);
-		if (tr->cond_snapshot)
-			ret = -EBUSY;
+		ret = tr->cond_snapshot ? -EBUSY : 0;
 		arch_spin_unlock(&tr->max_lock);
 		local_irq_enable();
 		if (ret)
-			goto out;
+			return ret;
 	}
 #endif
 	/* Some tracers won't work on kernel command line */
 	if (system_state < SYSTEM_RUNNING && t->noboot) {
 		pr_warn("Tracer '%s' is not allowed on command line, ignored\n",
 			t->name);
-		goto out;
+		return 0;
 	}
 
 	/* Some tracers are only allowed for the top level buffer */
-	if (!trace_ok_for_array(t, tr)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!trace_ok_for_array(t, tr))
+		return -EINVAL;
 
 	/* If trace pipe files are being read, we can't change the tracer */
-	if (tr->trace_ref) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (tr->trace_ref)
+		return -EBUSY;
 
 	trace_branch_disable();
 
@@ -6214,7 +6176,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 	if (!had_max_tr && t->use_max_tr) {
 		ret = tracing_arm_snapshot_locked(tr);
 		if (ret)
-			goto out;
+			return ret;
 	}
 #else
 	tr->current_trace = &nop_trace;
@@ -6227,17 +6189,15 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 			if (t->use_max_tr)
 				tracing_disarm_snapshot(tr);
 #endif
-			goto out;
+			return ret;
 		}
 	}
 
 	tr->current_trace = t;
 	tr->current_trace->enabled++;
 	trace_branch_enable(tr);
- out:
-	mutex_unlock(&trace_types_lock);
 
-	return ret;
+	return 0;
 }
 
 static ssize_t
@@ -6315,22 +6275,18 @@ tracing_thresh_write(struct file *filp, const char __user *ubuf,
 	struct trace_array *tr = filp->private_data;
 	int ret;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 	ret = tracing_nsecs_write(&tracing_thresh, ubuf, cnt, ppos);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (tr->current_trace->update_thresh) {
 		ret = tr->current_trace->update_thresh(tr);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
-	ret = cnt;
-out:
-	mutex_unlock(&trace_types_lock);
-
-	return ret;
+	return cnt;
 }
 
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -6549,31 +6505,29 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 	 * This is just a matter of traces coherency, the ring buffer itself
 	 * is protected.
 	 */
-	mutex_lock(&iter->mutex);
+	guard(mutex)(&iter->mutex);
 
 	/* return any leftover data */
 	sret = trace_seq_to_user(&iter->seq, ubuf, cnt);
 	if (sret != -EBUSY)
-		goto out;
+		return sret;
 
 	trace_seq_init(&iter->seq);
 
 	if (iter->trace->read) {
 		sret = iter->trace->read(iter, filp, ubuf, cnt, ppos);
 		if (sret)
-			goto out;
+			return sret;
 	}
 
 waitagain:
 	sret = tracing_wait_pipe(filp);
 	if (sret <= 0)
-		goto out;
+		return sret;
 
 	/* stop when tracing is finished */
-	if (trace_empty(iter)) {
-		sret = 0;
-		goto out;
-	}
+	if (trace_empty(iter))
+		return 0;
 
 	if (cnt >= TRACE_SEQ_BUFFER_SIZE)
 		cnt = TRACE_SEQ_BUFFER_SIZE - 1;
@@ -6637,9 +6591,6 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 	if (sret == -EBUSY)
 		goto waitagain;
 
-out:
-	mutex_unlock(&iter->mutex);
-
 	return sret;
 }
 
@@ -7231,25 +7182,19 @@ u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_eve
  */
 int tracing_set_filter_buffering(struct trace_array *tr, bool set)
 {
-	int ret = 0;
-
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	if (set && tr->no_filter_buffering_ref++)
-		goto out;
+		return 0;
 
 	if (!set) {
-		if (WARN_ON_ONCE(!tr->no_filter_buffering_ref)) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (WARN_ON_ONCE(!tr->no_filter_buffering_ref))
+			return -EINVAL;
 
 		--tr->no_filter_buffering_ref;
 	}
- out:
-	mutex_unlock(&trace_types_lock);
 
-	return ret;
+	return 0;
 }
 
 struct ftrace_buffer_info {
@@ -7325,12 +7270,10 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	if (ret)
 		return ret;
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
-	if (tr->current_trace->use_max_tr) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (tr->current_trace->use_max_tr)
+		return -EBUSY;
 
 	local_irq_disable();
 	arch_spin_lock(&tr->max_lock);
@@ -7339,24 +7282,20 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	arch_spin_unlock(&tr->max_lock);
 	local_irq_enable();
 	if (ret)
-		goto out;
+		return ret;
 
 	switch (val) {
 	case 0:
-		if (iter->cpu_file != RING_BUFFER_ALL_CPUS) {
-			ret = -EINVAL;
-			break;
-		}
+		if (iter->cpu_file != RING_BUFFER_ALL_CPUS)
+			return -EINVAL;
 		if (tr->allocated_snapshot)
 			free_snapshot(tr);
 		break;
 	case 1:
 /* Only allow per-cpu swap if the ring buffer supports it */
 #ifndef CONFIG_RING_BUFFER_ALLOW_SWAP
-		if (iter->cpu_file != RING_BUFFER_ALL_CPUS) {
-			ret = -EINVAL;
-			break;
-		}
+		if (iter->cpu_file != RING_BUFFER_ALL_CPUS)
+			return -EINVAL;
 #endif
 		if (tr->allocated_snapshot)
 			ret = resize_buffer_duplicate_size(&tr->max_buffer,
@@ -7364,7 +7303,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 		ret = tracing_arm_snapshot_locked(tr);
 		if (ret)
-			break;
+			return ret;
 
 		/* Now, we're going to swap */
 		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
@@ -7391,8 +7330,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		*ppos += cnt;
 		ret = cnt;
 	}
-out:
-	mutex_unlock(&trace_types_lock);
+
 	return ret;
 }
 
@@ -7778,12 +7716,11 @@ void tracing_log_err(struct trace_array *tr,
 
 	len += sizeof(CMD_PREFIX) + 2 * sizeof("\n") + strlen(cmd) + 1;
 
-	mutex_lock(&tracing_err_log_lock);
+	guard(mutex)(&tracing_err_log_lock);
+
 	err = get_tracing_log_err(tr, len);
-	if (PTR_ERR(err) == -ENOMEM) {
-		mutex_unlock(&tracing_err_log_lock);
+	if (PTR_ERR(err) == -ENOMEM)
 		return;
-	}
 
 	snprintf(err->loc, TRACING_LOG_LOC_MAX, "%s: error: ", loc);
 	snprintf(err->cmd, len, "\n" CMD_PREFIX "%s\n", cmd);
@@ -7794,7 +7731,6 @@ void tracing_log_err(struct trace_array *tr,
 	err->info.ts = local_clock();
 
 	list_add_tail(&err->list, &tr->err_log);
-	mutex_unlock(&tracing_err_log_lock);
 }
 
 static void clear_tracing_err_log(struct trace_array *tr)
@@ -9535,20 +9471,17 @@ static int instance_mkdir(const char *name)
 	struct trace_array *tr;
 	int ret;
 
-	mutex_lock(&event_mutex);
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&event_mutex);
+	guard(mutex)(&trace_types_lock);
 
 	ret = -EEXIST;
 	if (trace_array_find(name))
-		goto out_unlock;
+		return -EEXIST;
 
 	tr = trace_array_create(name);
 
 	ret = PTR_ERR_OR_ZERO(tr);
 
-out_unlock:
-	mutex_unlock(&trace_types_lock);
-	mutex_unlock(&event_mutex);
 	return ret;
 }
 
@@ -9598,24 +9531,23 @@ struct trace_array *trace_array_get_by_name(const char *name, const char *system
 {
 	struct trace_array *tr;
 
-	mutex_lock(&event_mutex);
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&event_mutex);
+	guard(mutex)(&trace_types_lock);
 
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr->name && strcmp(tr->name, name) == 0)
-			goto out_unlock;
+		if (tr->name && strcmp(tr->name, name) == 0) {
+			tr->ref++;
+			return tr;
+		}
 	}
 
 	tr = trace_array_create_systems(name, systems, 0, 0);
 
 	if (IS_ERR(tr))
 		tr = NULL;
-out_unlock:
-	if (tr)
+	else
 		tr->ref++;
 
-	mutex_unlock(&trace_types_lock);
-	mutex_unlock(&event_mutex);
 	return tr;
 }
 EXPORT_SYMBOL_GPL(trace_array_get_by_name);
@@ -9666,48 +9598,36 @@ static int __remove_instance(struct trace_array *tr)
 int trace_array_destroy(struct trace_array *this_tr)
 {
 	struct trace_array *tr;
-	int ret;
 
 	if (!this_tr)
 		return -EINVAL;
 
-	mutex_lock(&event_mutex);
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&event_mutex);
+	guard(mutex)(&trace_types_lock);
 
-	ret = -ENODEV;
 
 	/* Making sure trace array exists before destroying it. */
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr == this_tr) {
-			ret = __remove_instance(tr);
-			break;
-		}
+		if (tr == this_tr)
+			return __remove_instance(tr);
 	}
 
-	mutex_unlock(&trace_types_lock);
-	mutex_unlock(&event_mutex);
-
-	return ret;
+	return -ENODEV;
 }
 EXPORT_SYMBOL_GPL(trace_array_destroy);
 
 static int instance_rmdir(const char *name)
 {
 	struct trace_array *tr;
-	int ret;
 
-	mutex_lock(&event_mutex);
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&event_mutex);
+	guard(mutex)(&trace_types_lock);
 
-	ret = -ENODEV;
 	tr = trace_array_find(name);
-	if (tr)
-		ret = __remove_instance(tr);
-
-	mutex_unlock(&trace_types_lock);
-	mutex_unlock(&event_mutex);
+	if (!tr)
+		return -ENODEV;
 
-	return ret;
+	return __remove_instance(tr);
 }
 
 static __init void create_trace_instances(struct dentry *d_tracer)
@@ -9720,19 +9640,16 @@ static __init void create_trace_instances(struct dentry *d_tracer)
 	if (MEM_FAIL(!trace_instance_dir, "Failed to create instances directory\n"))
 		return;
 
-	mutex_lock(&event_mutex);
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&event_mutex);
+	guard(mutex)(&trace_types_lock);
 
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		if (!tr->name)
 			continue;
 		if (MEM_FAIL(trace_array_create_dir(tr) < 0,
 			     "Failed to create instance directory\n"))
-			break;
+			return;
 	}
-
-	mutex_unlock(&trace_types_lock);
-	mutex_unlock(&event_mutex);
 }
 
 static void
@@ -9946,7 +9863,7 @@ static void trace_module_remove_evals(struct module *mod)
 	if (!mod->num_trace_evals)
 		return;
 
-	mutex_lock(&trace_eval_mutex);
+	guard(mutex)(&trace_eval_mutex);
 
 	map = trace_eval_maps;
 
@@ -9958,12 +9875,10 @@ static void trace_module_remove_evals(struct module *mod)
 		map = map->tail.next;
 	}
 	if (!map)
-		goto out;
+		return;
 
 	*last = trace_eval_jmp_to_tail(map)->tail.next;
 	kfree(map);
- out:
-	mutex_unlock(&trace_eval_mutex);
 }
 #else
 static inline void trace_module_remove_evals(struct module *mod) { }
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 3b0cea37e029..fbbc3c719d2f 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -193,7 +193,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
-	trace_ctx = tracing_gen_ctx();
+	trace_ctx = tracing_gen_ctx_dec();
 
 	cpu = smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
@@ -298,7 +298,6 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	struct trace_array *tr = op->private;
 	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
-	unsigned long flags;
 	int bit;
 	int cpu;
 
@@ -325,8 +324,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (is_repeat_check(tr, last_info, ip, parent_ip))
 		goto out;
 
-	local_save_flags(flags);
-	trace_ctx = tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_dec();
 	process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
 
 	trace_function(tr, ip, parent_ip, trace_ctx);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 908e75a28d90..bdb37d572e97 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1428,6 +1428,8 @@ static ssize_t __import_iovec_ubuf(int type, const struct iovec __user *uvec,
 	struct iovec *iov = *iovp;
 	ssize_t ret;
 
+	*iovp = NULL;
+
 	if (compat)
 		ret = copy_compat_iovec_from_user(iov, uvec, 1);
 	else
@@ -1438,7 +1440,6 @@ static ssize_t __import_iovec_ubuf(int type, const struct iovec __user *uvec,
 	ret = import_ubuf(type, iov->iov_base, iov->iov_len, i);
 	if (unlikely(ret))
 		return ret;
-	*iovp = NULL;
 	return i->count;
 }
 
diff --git a/mm/madvise.c b/mm/madvise.c
index ff139e57cca2..c211e8fa4e49 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -920,7 +920,16 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 			 */
 			end = vma->vm_end;
 		}
-		VM_WARN_ON(start >= end);
+		/*
+		 * If the memory region between start and end was
+		 * originally backed by 4kB pages and then remapped to
+		 * be backed by hugepages while mmap_lock was dropped,
+		 * the adjustment for hugetlb vma above may have rounded
+		 * end down to the start address.
+		 */
+		if (start == end)
+			return 0;
+		VM_WARN_ON(start > end);
 	}
 
 	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9cf26592ac93..5bd888223cc8 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -840,20 +840,15 @@ void migrate_device_finalize(unsigned long *src_pfns,
 			dst = src;
 		}
 
+		if (!folio_is_zone_device(dst))
+			folio_add_lru(dst);
 		remove_migration_ptes(src, dst, 0);
 		folio_unlock(src);
-
-		if (folio_is_zone_device(src))
-			folio_put(src);
-		else
-			folio_putback_lru(src);
+		folio_put(src);
 
 		if (dst != src) {
 			folio_unlock(dst);
-			if (folio_is_zone_device(dst))
-				folio_put(dst);
-			else
-				folio_putback_lru(dst);
+			folio_put(dst);
 		}
 	}
 }
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 501ec4249fed..8612023bec60 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -660,12 +660,9 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 	void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
 	void *data;
 
-	if (size < ETH_HLEN || size > PAGE_SIZE - headroom - tailroom)
+	if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
 		return ERR_PTR(-EINVAL);
 
-	if (user_size > size)
-		return ERR_PTR(-EMSGSIZE);
-
 	size = SKB_DATA_ALIGN(size);
 	data = kzalloc(size + headroom + tailroom, GFP_USER);
 	if (!data)
diff --git a/net/core/dev.c b/net/core/dev.c
index 2e0fe38d0e87..c761f862bc5a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1012,6 +1012,12 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
 	return ret;
 }
 
+static bool dev_addr_cmp(struct net_device *dev, unsigned short type,
+			 const char *ha)
+{
+	return dev->type == type && !memcmp(dev->dev_addr, ha, dev->addr_len);
+}
+
 /**
  *	dev_getbyhwaddr_rcu - find a device by its hardware address
  *	@net: the applicable net namespace
@@ -1020,7 +1026,7 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
  *
  *	Search for an interface by MAC address. Returns NULL if the device
  *	is not found or a pointer to the device.
- *	The caller must hold RCU or RTNL.
+ *	The caller must hold RCU.
  *	The returned device has not had its ref count increased
  *	and the caller must therefore be careful about locking
  *
@@ -1032,14 +1038,39 @@ struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 	struct net_device *dev;
 
 	for_each_netdev_rcu(net, dev)
-		if (dev->type == type &&
-		    !memcmp(dev->dev_addr, ha, dev->addr_len))
+		if (dev_addr_cmp(dev, type, ha))
 			return dev;
 
 	return NULL;
 }
 EXPORT_SYMBOL(dev_getbyhwaddr_rcu);
 
+/**
+ * dev_getbyhwaddr() - find a device by its hardware address
+ * @net: the applicable net namespace
+ * @type: media type of device
+ * @ha: hardware address
+ *
+ * Similar to dev_getbyhwaddr_rcu(), but the owner needs to hold
+ * rtnl_lock.
+ *
+ * Context: rtnl_lock() must be held.
+ * Return: pointer to the net_device, or NULL if not found
+ */
+struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
+				   const char *ha)
+{
+	struct net_device *dev;
+
+	ASSERT_RTNL();
+	for_each_netdev(net, dev)
+		if (dev_addr_cmp(dev, type, ha))
+			return dev;
+
+	return NULL;
+}
+EXPORT_SYMBOL(dev_getbyhwaddr);
+
 struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type)
 {
 	struct net_device *dev, *ret = NULL;
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 6efd4cccc9dd..212f0a048cab 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -1734,30 +1734,30 @@ static int __init init_net_drop_monitor(void)
 		return -ENOSPC;
 	}
 
-	rc = genl_register_family(&net_drop_monitor_family);
-	if (rc) {
-		pr_err("Could not create drop monitor netlink family\n");
-		return rc;
+	for_each_possible_cpu(cpu) {
+		net_dm_cpu_data_init(cpu);
+		net_dm_hw_cpu_data_init(cpu);
 	}
-	WARN_ON(net_drop_monitor_family.mcgrp_offset != NET_DM_GRP_ALERT);
 
 	rc = register_netdevice_notifier(&dropmon_net_notifier);
 	if (rc < 0) {
 		pr_crit("Failed to register netdevice notifier\n");
+		return rc;
+	}
+
+	rc = genl_register_family(&net_drop_monitor_family);
+	if (rc) {
+		pr_err("Could not create drop monitor netlink family\n");
 		goto out_unreg;
 	}
+	WARN_ON(net_drop_monitor_family.mcgrp_offset != NET_DM_GRP_ALERT);
 
 	rc = 0;
 
-	for_each_possible_cpu(cpu) {
-		net_dm_cpu_data_init(cpu);
-		net_dm_hw_cpu_data_init(cpu);
-	}
-
 	goto out;
 
 out_unreg:
-	genl_unregister_family(&net_drop_monitor_family);
+	WARN_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
 out:
 	return rc;
 }
@@ -1766,19 +1766,18 @@ static void exit_net_drop_monitor(void)
 {
 	int cpu;
 
-	BUG_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
-
 	/*
 	 * Because of the module_get/put we do in the trace state change path
 	 * we are guaranteed not to have any current users when we get here
 	 */
+	BUG_ON(genl_unregister_family(&net_drop_monitor_family));
+
+	BUG_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
 
 	for_each_possible_cpu(cpu) {
 		net_dm_hw_cpu_data_fini(cpu);
 		net_dm_cpu_data_fini(cpu);
 	}
-
-	BUG_ON(genl_unregister_family(&net_drop_monitor_family));
 }
 
 module_init(init_net_drop_monitor);
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 5db41bf2ed93..9cd8de6bebb5 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -853,23 +853,30 @@ __skb_flow_dissect_ports(const struct sk_buff *skb,
 			 void *target_container, const void *data,
 			 int nhoff, u8 ip_proto, int hlen)
 {
-	enum flow_dissector_key_id dissector_ports = FLOW_DISSECTOR_KEY_MAX;
-	struct flow_dissector_key_ports *key_ports;
+	struct flow_dissector_key_ports_range *key_ports_range = NULL;
+	struct flow_dissector_key_ports *key_ports = NULL;
+	__be32 ports;
 
 	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS))
-		dissector_ports = FLOW_DISSECTOR_KEY_PORTS;
-	else if (dissector_uses_key(flow_dissector,
-				    FLOW_DISSECTOR_KEY_PORTS_RANGE))
-		dissector_ports = FLOW_DISSECTOR_KEY_PORTS_RANGE;
+		key_ports = skb_flow_dissector_target(flow_dissector,
+						      FLOW_DISSECTOR_KEY_PORTS,
+						      target_container);
 
-	if (dissector_ports == FLOW_DISSECTOR_KEY_MAX)
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS_RANGE))
+		key_ports_range = skb_flow_dissector_target(flow_dissector,
+							    FLOW_DISSECTOR_KEY_PORTS_RANGE,
+							    target_container);
+
+	if (!key_ports && !key_ports_range)
 		return;
 
-	key_ports = skb_flow_dissector_target(flow_dissector,
-					      dissector_ports,
-					      target_container);
-	key_ports->ports = __skb_flow_get_ports(skb, nhoff, ip_proto,
-						data, hlen);
+	ports = __skb_flow_get_ports(skb, nhoff, ip_proto, data, hlen);
+
+	if (key_ports)
+		key_ports->ports = ports;
+
+	if (key_ports_range)
+		key_ports_range->tp.ports = ports;
 }
 
 static void
@@ -924,6 +931,7 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
 				     struct flow_dissector *flow_dissector,
 				     void *target_container)
 {
+	struct flow_dissector_key_ports_range *key_ports_range = NULL;
 	struct flow_dissector_key_ports *key_ports = NULL;
 	struct flow_dissector_key_control *key_control;
 	struct flow_dissector_key_basic *key_basic;
@@ -968,20 +976,21 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
 		key_control->addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
 	}
 
-	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS))
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS)) {
 		key_ports = skb_flow_dissector_target(flow_dissector,
 						      FLOW_DISSECTOR_KEY_PORTS,
 						      target_container);
-	else if (dissector_uses_key(flow_dissector,
-				    FLOW_DISSECTOR_KEY_PORTS_RANGE))
-		key_ports = skb_flow_dissector_target(flow_dissector,
-						      FLOW_DISSECTOR_KEY_PORTS_RANGE,
-						      target_container);
-
-	if (key_ports) {
 		key_ports->src = flow_keys->sport;
 		key_ports->dst = flow_keys->dport;
 	}
+	if (dissector_uses_key(flow_dissector,
+			       FLOW_DISSECTOR_KEY_PORTS_RANGE)) {
+		key_ports_range = skb_flow_dissector_target(flow_dissector,
+							    FLOW_DISSECTOR_KEY_PORTS_RANGE,
+							    target_container);
+		key_ports_range->tp.src = flow_keys->sport;
+		key_ports_range->tp.dst = flow_keys->dport;
+	}
 
 	if (dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_FLOW_LABEL)) {
diff --git a/net/core/gro.c b/net/core/gro.c
index d1f44084e978..78b320b63174 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -7,9 +7,6 @@
 
 #define MAX_GRO_SKBS 8
 
-/* This should be increased if a protocol with a bigger head is added. */
-#define GRO_MAX_HEAD (MAX_HEADER + 128)
-
 static DEFINE_SPINLOCK(offload_lock);
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 74149dc4ee31..61a950f13a91 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -69,6 +69,7 @@
 #include <net/dst.h>
 #include <net/sock.h>
 #include <net/checksum.h>
+#include <net/gro.h>
 #include <net/gso.h>
 #include <net/hotdata.h>
 #include <net/ip6_checksum.h>
@@ -95,7 +96,9 @@
 static struct kmem_cache *skbuff_ext_cache __ro_after_init;
 #endif
 
-#define SKB_SMALL_HEAD_SIZE SKB_HEAD_ALIGN(MAX_TCP_HEADER)
+#define GRO_MAX_HEAD_PAD (GRO_MAX_HEAD + NET_SKB_PAD + NET_IP_ALIGN)
+#define SKB_SMALL_HEAD_SIZE SKB_HEAD_ALIGN(max(MAX_TCP_HEADER, \
+					       GRO_MAX_HEAD_PAD))
 
 /* We want SKB_SMALL_HEAD_CACHE_SIZE to not be a power of two.
  * This should ensure that SKB_SMALL_HEAD_HEADROOM is a unique
@@ -736,7 +739,7 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 	/* If requested length is either too small or too big,
 	 * we use kmalloc() for skb->head allocation.
 	 */
-	if (len <= SKB_WITH_OVERHEAD(1024) ||
+	if (len <= SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) ||
 	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
 		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NODE);
@@ -816,7 +819,8 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
 	 * When the small frag allocator is available, prefer it over kmalloc
 	 * for small fragments
 	 */
-	if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <= SKB_WITH_OVERHEAD(1024)) ||
+	if ((!NAPI_HAS_SMALL_PAGE_FRAG &&
+	     len <= SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE)) ||
 	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
 		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX | SKB_ALLOC_NAPI,
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 8ad7e6755fd6..f76cbf49c68c 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -548,6 +548,9 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 			return num_sge;
 	}
 
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+	psock->ingress_bytes += len;
+#endif
 	copied = len;
 	msg->sg.start = 0;
 	msg->sg.size = copied;
@@ -1143,6 +1146,10 @@ int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 	if (!ret)
 		sk_psock_set_state(psock, SK_PSOCK_RX_STRP_ENABLED);
 
+	if (sk_is_tcp(sk)) {
+		psock->strp.cb.read_sock = tcp_bpf_strp_read_sock;
+		psock->copied_seq = tcp_sk(sk)->copied_seq;
+	}
 	return ret;
 }
 
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index f1b9b3958792..82a14f131d00 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -303,7 +303,10 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 
 	write_lock_bh(&sk->sk_callback_lock);
 	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
-		ret = sk_psock_init_strp(sk, psock);
+		if (sk_is_tcp(sk))
+			ret = sk_psock_init_strp(sk, psock);
+		else
+			ret = -EOPNOTSUPP;
 		if (ret) {
 			write_unlock_bh(&sk->sk_callback_lock);
 			sk_psock_put(sk, psock);
@@ -541,6 +544,9 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
 		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
 	if (sk_is_stream_unix(sk))
 		return (1 << sk->sk_state) & TCPF_ESTABLISHED;
+	if (sk_is_vsock(sk) &&
+	    (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET))
+		return (1 << sk->sk_state) & TCPF_ESTABLISHED;
 	return true;
 }
 
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 59ffaa89d7b0..8fb48f42581c 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1077,7 +1077,7 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 	__be32 mask = ((struct sockaddr_in *)&r->arp_netmask)->sin_addr.s_addr;
 
 	if (!dev && (r->arp_flags & ATF_COM)) {
-		dev = dev_getbyhwaddr_rcu(net, r->arp_ha.sa_family,
+		dev = dev_getbyhwaddr(net, r->arp_ha.sa_family,
 				      r->arp_ha.sa_data);
 		if (!dev)
 			return -ENODEV;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4f77bd862e95..68cb6a966b18 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1564,12 +1564,13 @@ EXPORT_SYMBOL(tcp_recv_skb);
  *	  or for 'peeking' the socket using this routine
  *	  (although both would be easy to implement).
  */
-int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
-		  sk_read_actor_t recv_actor)
+static int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor, bool noack,
+			   u32 *copied_seq)
 {
 	struct sk_buff *skb;
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 seq = tp->copied_seq;
+	u32 seq = *copied_seq;
 	u32 offset;
 	int copied = 0;
 
@@ -1623,9 +1624,12 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		tcp_eat_recv_skb(sk, skb);
 		if (!desc->count)
 			break;
-		WRITE_ONCE(tp->copied_seq, seq);
+		WRITE_ONCE(*copied_seq, seq);
 	}
-	WRITE_ONCE(tp->copied_seq, seq);
+	WRITE_ONCE(*copied_seq, seq);
+
+	if (noack)
+		goto out;
 
 	tcp_rcv_space_adjust(sk);
 
@@ -1634,10 +1638,25 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		tcp_recv_skb(sk, seq, &offset);
 		tcp_cleanup_rbuf(sk, copied);
 	}
+out:
 	return copied;
 }
+
+int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+		  sk_read_actor_t recv_actor)
+{
+	return __tcp_read_sock(sk, desc, recv_actor, false,
+			       &tcp_sk(sk)->copied_seq);
+}
 EXPORT_SYMBOL(tcp_read_sock);
 
+int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
+			sk_read_actor_t recv_actor, bool noack,
+			u32 *copied_seq)
+{
+	return __tcp_read_sock(sk, desc, recv_actor, noack, copied_seq);
+}
+
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct sk_buff *skb;
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 392678ae80f4..22e8a2af5dd8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -646,6 +646,42 @@ static int tcp_bpf_assert_proto_ops(struct proto *ops)
 	       ops->sendmsg  == tcp_sendmsg ? 0 : -ENOTSUPP;
 }
 
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor)
+{
+	struct sock *sk = strp->sk;
+	struct sk_psock *psock;
+	struct tcp_sock *tp;
+	int copied = 0;
+
+	tp = tcp_sk(sk);
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (WARN_ON_ONCE(!psock)) {
+		desc->error = -EINVAL;
+		goto out;
+	}
+
+	psock->ingress_bytes = 0;
+	copied = tcp_read_sock_noack(sk, desc, recv_actor, true,
+				     &psock->copied_seq);
+	if (copied < 0)
+		goto out;
+	/* recv_actor may redirect skb to another socket (SK_REDIRECT) or
+	 * just put skb into ingress queue of current socket (SK_PASS).
+	 * For SK_REDIRECT, we need to ack the frame immediately but for
+	 * SK_PASS, we want to delay the ack until tcp_bpf_recvmsg_parser().
+	 */
+	tp->copied_seq = psock->copied_seq - psock->ingress_bytes;
+	tcp_rcv_space_adjust(sk);
+	__tcp_cleanup_rbuf(sk, copied - psock->ingress_bytes);
+out:
+	rcu_read_unlock();
+	return copied;
+}
+#endif /* CONFIG_BPF_STREAM_PARSER */
+
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
 	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 0f523cbfe329..32b28fc21b63 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -178,7 +178,7 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	if (!skb)
 		return;
 
-	skb_dst_drop(skb);
+	tcp_cleanup_skb(skb);
 	/* segs_in has been initialized to 1 in tcp_create_openreq_child().
 	 * Hence, reset segs_in to 0 before calling tcp_segs_in()
 	 * to avoid double counting.  Also, tcp_segs_in() expects
@@ -195,7 +195,7 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
 
 	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
-	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	tcp_add_receive_queue(sk, skb);
 	tp->syn_data_acked = 1;
 
 	/* u64_stats_update_begin(&tp->syncp) not needed here,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2d43b29da15e..d93a5a89c569 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -243,9 +243,15 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 			do_div(val, skb->truesize);
 			tcp_sk(sk)->scaling_ratio = val ? val : 1;
 
-			if (old_ratio != tcp_sk(sk)->scaling_ratio)
-				WRITE_ONCE(tcp_sk(sk)->window_clamp,
-					   tcp_win_from_space(sk, sk->sk_rcvbuf));
+			if (old_ratio != tcp_sk(sk)->scaling_ratio) {
+				struct tcp_sock *tp = tcp_sk(sk);
+
+				val = tcp_win_from_space(sk, sk->sk_rcvbuf);
+				tcp_set_window_clamp(sk, val);
+
+				if (tp->window_clamp < tp->rcvq_space.space)
+					tp->rcvq_space.space = tp->window_clamp;
+			}
 		}
 		icsk->icsk_ack.rcv_mss = min_t(unsigned int, len,
 					       tcp_sk(sk)->advmss);
@@ -4964,7 +4970,7 @@ static void tcp_ofo_queue(struct sock *sk)
 		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
 		fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
 		if (!eaten)
-			__skb_queue_tail(&sk->sk_receive_queue, skb);
+			tcp_add_receive_queue(sk, skb);
 		else
 			kfree_skb_partial(skb, fragstolen);
 
@@ -5156,7 +5162,7 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 				  skb, fragstolen)) ? 1 : 0;
 	tcp_rcv_nxt_update(tcp_sk(sk), TCP_SKB_CB(skb)->end_seq);
 	if (!eaten) {
-		__skb_queue_tail(&sk->sk_receive_queue, skb);
+		tcp_add_receive_queue(sk, skb);
 		skb_set_owner_r(skb, sk);
 	}
 	return eaten;
@@ -5239,7 +5245,7 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 		__kfree_skb(skb);
 		return;
 	}
-	skb_dst_drop(skb);
+	tcp_cleanup_skb(skb);
 	__skb_pull(skb, tcp_hdr(skb)->doff * 4);
 
 	reason = SKB_DROP_REASON_NOT_SPECIFIED;
@@ -6208,7 +6214,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPHITS);
 
 			/* Bulk data transfer: receiver */
-			skb_dst_drop(skb);
+			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index bcc2f1e090c7..824048679e1b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2025,7 +2025,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	 */
 	skb_condense(skb);
 
-	skb_dst_drop(skb);
+	tcp_cleanup_skb(skb);
 
 	if (unlikely(tcp_checksum_complete(skb))) {
 		bh_unlock_sock(sk);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index dfa306708494..998ea3b5badf 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -97,7 +97,7 @@ tcf_exts_miss_cookie_base_alloc(struct tcf_exts *exts, struct tcf_proto *tp,
 
 	err = xa_alloc_cyclic(&tcf_exts_miss_cookies_xa, &n->miss_cookie_base,
 			      n, xa_limit_32b, &next, GFP_KERNEL);
-	if (err)
+	if (err < 0)
 		goto err_xa_alloc;
 
 	exts->miss_cookie_node = n;
diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 8299ceb3e373..95696f42647e 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -347,7 +347,10 @@ static int strp_read_sock(struct strparser *strp)
 	struct socket *sock = strp->sk->sk_socket;
 	read_descriptor_t desc;
 
-	if (unlikely(!sock || !sock->ops || !sock->ops->read_sock))
+	if (unlikely(!sock || !sock->ops))
+		return -EBUSY;
+
+	if (unlikely(!strp->cb.read_sock && !sock->ops->read_sock))
 		return -EBUSY;
 
 	desc.arg.data = strp;
@@ -355,7 +358,10 @@ static int strp_read_sock(struct strparser *strp)
 	desc.count = 1; /* give more than one skb per call */
 
 	/* sk should be locked here, so okay to do read_sock */
-	sock->ops->read_sock(strp->sk, &desc, strp_recv);
+	if (strp->cb.read_sock)
+		strp->cb.read_sock(strp, &desc, strp_recv);
+	else
+		sock->ops->read_sock(strp->sk, &desc, strp_recv);
 
 	desc.error = strp->cb.read_sock_done(strp, desc.error);
 
@@ -468,6 +474,7 @@ int strp_init(struct strparser *strp, struct sock *sk,
 	strp->cb.unlock = cb->unlock ? : strp_sock_unlock;
 	strp->cb.rcv_msg = cb->rcv_msg;
 	strp->cb.parse_msg = cb->parse_msg;
+	strp->cb.read_sock = cb->read_sock;
 	strp->cb.read_sock_done = cb->read_sock_done ? : default_read_sock_done;
 	strp->cb.abort_parser = cb->abort_parser ? : strp_abort_strp;
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 37299a7ca187..eb6ea26b390e 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1189,6 +1189,9 @@ static int vsock_read_skb(struct sock *sk, skb_read_actor_t read_actor)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
 
+	if (WARN_ON_ONCE(!vsk->transport))
+		return -ENODEV;
+
 	return vsk->transport->read_skb(vsk, read_actor);
 }
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index b58c3818f284..f0e48e6911fc 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -670,6 +670,13 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
 	};
 	int ret;
 
+	mutex_lock(&vsock->rx_lock);
+	vsock->rx_buf_nr = 0;
+	vsock->rx_buf_max_nr = 0;
+	mutex_unlock(&vsock->rx_lock);
+
+	atomic_set(&vsock->queued_replies, 0);
+
 	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
 	if (ret < 0)
 		return ret;
@@ -779,9 +786,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 
 	vsock->vdev = vdev;
 
-	vsock->rx_buf_nr = 0;
-	vsock->rx_buf_max_nr = 0;
-	atomic_set(&vsock->queued_replies, 0);
 
 	mutex_init(&vsock->tx_lock);
 	mutex_init(&vsock->rx_lock);
diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index f201d9eca1df..07b96d56f3a5 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -87,7 +87,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	lock_sock(sk);
 	vsk = vsock_sk(sk);
 
-	if (!vsk->transport) {
+	if (WARN_ON_ONCE(!vsk->transport)) {
 		copied = -ENODEV;
 		goto out;
 	}
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 77b6ac9b5c11..9955c4d54e42 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -678,12 +678,18 @@ static int snd_seq_deliver_single_event(struct snd_seq_client *client,
 					  dest_port->time_real);
 
 #if IS_ENABLED(CONFIG_SND_SEQ_UMP)
-	if (!(dest->filter & SNDRV_SEQ_FILTER_NO_CONVERT)) {
-		if (snd_seq_ev_is_ump(event)) {
+	if (snd_seq_ev_is_ump(event)) {
+		if (!(dest->filter & SNDRV_SEQ_FILTER_NO_CONVERT)) {
 			result = snd_seq_deliver_from_ump(client, dest, dest_port,
 							  event, atomic, hop);
 			goto __skip;
-		} else if (snd_seq_client_is_ump(dest)) {
+		} else if (dest->type == USER_CLIENT &&
+			   !snd_seq_client_is_ump(dest)) {
+			result = 0; // drop the event
+			goto __skip;
+		}
+	} else if (snd_seq_client_is_ump(dest)) {
+		if (!(dest->filter & SNDRV_SEQ_FILTER_NO_CONVERT)) {
 			result = snd_seq_deliver_to_ump(client, dest, dest_port,
 							event, atomic, hop);
 			goto __skip;
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 14763c0f31ad..46a220404999 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2470,7 +2470,9 @@ int snd_hda_create_dig_out_ctls(struct hda_codec *codec,
 				break;
 			id = kctl->id;
 			id.index = spdif_index;
-			snd_ctl_rename_id(codec->card, &kctl->id, &id);
+			err = snd_ctl_rename_id(codec->card, &kctl->id, &id);
+			if (err < 0)
+				return err;
 		}
 		bus->primary_dig_out_type = HDA_PCM_TYPE_HDMI;
 	}
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 538c37a78a56..84ab357b840d 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1080,6 +1080,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x822e, "HP ProBook 440 G4", CXT_FIXUP_MUTE_LED_GPIO),
+	SND_PCI_QUIRK(0x103c, 0x8231, "HP ProBook 450 G4", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),
diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index 759f48038273..621f947e3817 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -121,7 +121,7 @@ static const struct cs8409_i2c_param cs42l42_init_reg_seq[] = {
 	{ CS42L42_MIXER_CHA_VOL, 0x3F },
 	{ CS42L42_MIXER_CHB_VOL, 0x3F },
 	{ CS42L42_MIXER_ADC_VOL, 0x3f },
-	{ CS42L42_HP_CTL, 0x03 },
+	{ CS42L42_HP_CTL, 0x0D },
 	{ CS42L42_MIC_DET_CTL1, 0xB6 },
 	{ CS42L42_TIPSENSE_CTL, 0xC2 },
 	{ CS42L42_HS_CLAMP_DISABLE, 0x01 },
@@ -315,7 +315,7 @@ static const struct cs8409_i2c_param dolphin_c0_init_reg_seq[] = {
 	{ CS42L42_ASP_TX_SZ_EN, 0x01 },
 	{ CS42L42_PWR_CTL1, 0x0A },
 	{ CS42L42_PWR_CTL2, 0x84 },
-	{ CS42L42_HP_CTL, 0x03 },
+	{ CS42L42_HP_CTL, 0x0D },
 	{ CS42L42_MIXER_CHA_VOL, 0x3F },
 	{ CS42L42_MIXER_CHB_VOL, 0x3F },
 	{ CS42L42_MIXER_ADC_VOL, 0x3f },
@@ -371,7 +371,7 @@ static const struct cs8409_i2c_param dolphin_c1_init_reg_seq[] = {
 	{ CS42L42_ASP_TX_SZ_EN, 0x00 },
 	{ CS42L42_PWR_CTL1, 0x0E },
 	{ CS42L42_PWR_CTL2, 0x84 },
-	{ CS42L42_HP_CTL, 0x01 },
+	{ CS42L42_HP_CTL, 0x0D },
 	{ CS42L42_MIXER_CHA_VOL, 0x3F },
 	{ CS42L42_MIXER_CHB_VOL, 0x3F },
 	{ CS42L42_MIXER_ADC_VOL, 0x3f },
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 614327218634..b760332a4e35 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -876,7 +876,7 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 		{ CS42L42_DET_INT_STATUS2, 0x00 },
 		{ CS42L42_TSRS_PLUG_STATUS, 0x00 },
 	};
-	int fsv_old, fsv_new;
+	unsigned int fsv;
 
 	/* Bring CS42L42 out of Reset */
 	spec->gpio_data = snd_hda_codec_read(codec, CS8409_PIN_AFG, 0, AC_VERB_GET_GPIO_DATA, 0);
@@ -893,13 +893,15 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 	/* Clear interrupts, by reading interrupt status registers */
 	cs8409_i2c_bulk_read(cs42l42, irq_regs, ARRAY_SIZE(irq_regs));
 
-	fsv_old = cs8409_i2c_read(cs42l42, CS42L42_HP_CTL);
-	if (cs42l42->full_scale_vol == CS42L42_FULL_SCALE_VOL_0DB)
-		fsv_new = fsv_old & ~CS42L42_FULL_SCALE_VOL_MASK;
-	else
-		fsv_new = fsv_old & CS42L42_FULL_SCALE_VOL_MASK;
-	if (fsv_new != fsv_old)
-		cs8409_i2c_write(cs42l42, CS42L42_HP_CTL, fsv_new);
+	fsv = cs8409_i2c_read(cs42l42, CS42L42_HP_CTL);
+	if (cs42l42->full_scale_vol) {
+		// Set the full scale volume bit
+		fsv |= CS42L42_FULL_SCALE_VOL_MASK;
+		cs8409_i2c_write(cs42l42, CS42L42_HP_CTL, fsv);
+	}
+	// Unmute analog channels A and B
+	fsv = (fsv & ~CS42L42_ANA_MUTE_AB);
+	cs8409_i2c_write(cs42l42, CS42L42_HP_CTL, fsv);
 
 	/* we have to explicitly allow unsol event handling even during the
 	 * resume phase so that the jack event is processed properly
@@ -920,7 +922,7 @@ static void cs42l42_suspend(struct sub_codec *cs42l42)
 		{ CS42L42_MIXER_CHA_VOL, 0x3F },
 		{ CS42L42_MIXER_ADC_VOL, 0x3F },
 		{ CS42L42_MIXER_CHB_VOL, 0x3F },
-		{ CS42L42_HP_CTL, 0x0F },
+		{ CS42L42_HP_CTL, 0x0D },
 		{ CS42L42_ASP_RX_DAI0_EN, 0x00 },
 		{ CS42L42_ASP_CLK_CFG, 0x00 },
 		{ CS42L42_PWR_CTL1, 0xFE },
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 5e48115caf09..14645d25e70f 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -230,9 +230,10 @@ enum cs8409_coefficient_index_registers {
 #define CS42L42_PDN_TIMEOUT_US			(250000)
 #define CS42L42_PDN_SLEEP_US			(2000)
 #define CS42L42_INIT_TIMEOUT_MS			(45)
+#define CS42L42_ANA_MUTE_AB			(0x0C)
 #define CS42L42_FULL_SCALE_VOL_MASK		(2)
-#define CS42L42_FULL_SCALE_VOL_0DB		(1)
-#define CS42L42_FULL_SCALE_VOL_MINUS6DB		(0)
+#define CS42L42_FULL_SCALE_VOL_0DB		(0)
+#define CS42L42_FULL_SCALE_VOL_MINUS6DB		(1)
 
 /* Dell BULLSEYE / WARLOCK / CYBORG Specific Definitions */
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f3f849b96402..9bf99fe6cd34 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3790,6 +3790,7 @@ static void alc225_init(struct hda_codec *codec)
 				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 
 		msleep(75);
+		alc_update_coef_idx(codec, 0x4a, 3 << 10, 0);
 		alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x4); /* Hight power */
 	}
 }
diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 67c2d4cb0dea..7cfe77b57b3c 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -156,6 +156,8 @@ static int micfil_set_quality(struct fsl_micfil *micfil)
 	case QUALITY_VLOW2:
 		qsel = MICFIL_QSEL_VLOW2_QUALITY;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	return regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 8e7b75cf64db..ff3671226306 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -23,7 +23,6 @@ struct imx_audmix {
 	struct snd_soc_card card;
 	struct platform_device *audmix_pdev;
 	struct platform_device *out_pdev;
-	struct clk *cpu_mclk;
 	int num_dai;
 	struct snd_soc_dai_link *dai;
 	int num_dai_conf;
@@ -32,34 +31,11 @@ struct imx_audmix {
 	struct snd_soc_dapm_route *dapm_routes;
 };
 
-static const u32 imx_audmix_rates[] = {
-	8000, 12000, 16000, 24000, 32000, 48000, 64000, 96000,
-};
-
-static const struct snd_pcm_hw_constraint_list imx_audmix_rate_constraints = {
-	.count = ARRAY_SIZE(imx_audmix_rates),
-	.list = imx_audmix_rates,
-};
-
 static int imx_audmix_fe_startup(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-	struct imx_audmix *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct device *dev = rtd->card->dev;
-	unsigned long clk_rate = clk_get_rate(priv->cpu_mclk);
 	int ret;
 
-	if (clk_rate % 24576000 == 0) {
-		ret = snd_pcm_hw_constraint_list(runtime, 0,
-						 SNDRV_PCM_HW_PARAM_RATE,
-						 &imx_audmix_rate_constraints);
-		if (ret < 0)
-			return ret;
-	} else {
-		dev_warn(dev, "mclk may be not supported %lu\n", clk_rate);
-	}
-
 	ret = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS,
 					   1, 8);
 	if (ret < 0)
@@ -325,13 +301,6 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	}
 	put_device(&cpu_pdev->dev);
 
-	priv->cpu_mclk = devm_clk_get(&cpu_pdev->dev, "mclk1");
-	if (IS_ERR(priv->cpu_mclk)) {
-		ret = PTR_ERR(priv->cpu_mclk);
-		dev_err(&cpu_pdev->dev, "failed to get DAI mclk1: %d\n", ret);
-		return ret;
-	}
-
 	priv->audmix_pdev = audmix_pdev;
 	priv->out_pdev  = cpu_pdev;
 
diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index acd75e48851f..7feefeb6b876 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -451,11 +451,11 @@ static int rockchip_i2s_tdm_set_fmt(struct snd_soc_dai *cpu_dai,
 			break;
 		case SND_SOC_DAIFMT_DSP_A:
 			val = I2S_TXCR_TFS_TDM_PCM;
-			tdm_val = TDM_SHIFT_CTRL(0);
+			tdm_val = TDM_SHIFT_CTRL(2);
 			break;
 		case SND_SOC_DAIFMT_DSP_B:
 			val = I2S_TXCR_TFS_TDM_PCM;
-			tdm_val = TDM_SHIFT_CTRL(2);
+			tdm_val = TDM_SHIFT_CTRL(4);
 			break;
 		default:
 			ret = -EINVAL;
diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 32db2cead8a4..4f483bfa584f 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -416,8 +416,12 @@ static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
 
 	/* Cancel all remaining DMA transactions */
-	if (rz_ssi_is_dma_enabled(ssi))
-		dmaengine_terminate_async(strm->dma_ch);
+	if (rz_ssi_is_dma_enabled(ssi)) {
+		if (ssi->playback.dma_ch)
+			dmaengine_terminate_async(ssi->playback.dma_ch);
+		if (ssi->capture.dma_ch)
+			dmaengine_terminate_async(ssi->capture.dma_ch);
+	}
 
 	rz_ssi_set_idle(ssi);
 
@@ -524,6 +528,8 @@ static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	sample_space = strm->fifo_sample_size;
 	ssifsr = rz_ssi_reg_readl(ssi, SSIFSR);
 	sample_space -= (ssifsr >> SSIFSR_TDC_SHIFT) & SSIFSR_TDC_MASK;
+	if (sample_space < 0)
+		return -EINVAL;
 
 	/* Only add full frames at a time */
 	while (frames_left && (sample_space >= runtime->channels)) {
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 240fee2166d1..f82db7f2a6b7 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -671,10 +671,16 @@ static int sof_ipc4_widget_setup_comp_dai(struct snd_sof_widget *swidget)
 		}
 
 		list_for_each_entry(w, &sdev->widget_list, list) {
-			if (w->widget->sname &&
+			struct snd_sof_dai *alh_dai;
+
+			if (!WIDGET_IS_DAI(w->id) || !w->widget->sname ||
 			    strcmp(w->widget->sname, swidget->widget->sname))
 				continue;
 
+			alh_dai = w->private;
+			if (alh_dai->type != SOF_DAI_INTEL_ALH)
+				continue;
+
 			blob->alh_cfg.device_count++;
 		}
 
@@ -1973,11 +1979,13 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 			list_for_each_entry(w, &sdev->widget_list, list) {
 				u32 node_type;
 
-				if (w->widget->sname &&
+				if (!WIDGET_IS_DAI(w->id) || !w->widget->sname ||
 				    strcmp(w->widget->sname, swidget->widget->sname))
 					continue;
 
 				dai = w->private;
+				if (dai->type != SOF_DAI_INTEL_ALH)
+					continue;
 				alh_copier = (struct sof_ipc4_copier *)dai->private;
 				alh_data = &alh_copier->data;
 				node_type = SOF_IPC4_GET_NODE_TYPE(alh_data->gtw_cfg.node_id);
diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 35a7462d8b69..c5c6353f18ce 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -511,6 +511,8 @@ static int sof_pcm_close(struct snd_soc_component *component,
 		 */
 	}
 
+	spcm->stream[substream->stream].substream = NULL;
+
 	return 0;
 }
 
diff --git a/sound/soc/sof/stream-ipc.c b/sound/soc/sof/stream-ipc.c
index 794c7bbccbaf..8262443ac89a 100644
--- a/sound/soc/sof/stream-ipc.c
+++ b/sound/soc/sof/stream-ipc.c
@@ -43,7 +43,7 @@ int sof_ipc_msg_data(struct snd_sof_dev *sdev,
 				return -ESTRPIPE;
 
 			posn_offset = stream->posn_offset;
-		} else {
+		} else if (sps->cstream) {
 
 			struct sof_compr_stream *sstream = sps->cstream->runtime->private_data;
 
@@ -51,6 +51,10 @@ int sof_ipc_msg_data(struct snd_sof_dev *sdev,
 				return -ESTRPIPE;
 
 			posn_offset = sstream->posn_offset;
+
+		} else {
+			dev_err(sdev->dev, "%s: No stream opened\n", __func__);
+			return -EINVAL;
 		}
 
 		snd_sof_dsp_mailbox_read(sdev, posn_offset, p, sz);
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
index 6c3b4d4f173a..aeef86b3da74 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
@@ -40,6 +40,14 @@ DECLARE_TRACE(bpf_testmod_test_nullable_bare,
 	TP_ARGS(ctx__nullable)
 );
 
+struct sk_buff;
+
+DECLARE_TRACE(bpf_testmod_test_raw_tp_null,
+	TP_PROTO(struct sk_buff *skb),
+	TP_ARGS(skb)
+);
+
+
 #undef BPF_TESTMOD_DECLARE_TRACE
 #ifdef DECLARE_TRACE_WRITABLE
 #define BPF_TESTMOD_DECLARE_TRACE(call, proto, args, size) \
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 8835761d9a12..4e6a9e9c0368 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -380,6 +380,8 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 
 	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
 
+	(void)trace_bpf_testmod_test_raw_tp_null(NULL);
+
 	struct_arg3 = kmalloc((sizeof(struct bpf_testmod_struct_arg_3) +
 				sizeof(int)), GFP_KERNEL);
 	if (struct_arg3 != NULL) {
diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
new file mode 100644
index 000000000000..6fa19449297e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "raw_tp_null.skel.h"
+
+void test_raw_tp_null(void)
+{
+	struct raw_tp_null *skel;
+
+	skel = raw_tp_null__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "raw_tp_null__open_and_load"))
+		return;
+
+	skel->bss->tid = sys_gettid();
+
+	if (!ASSERT_OK(raw_tp_null__attach(skel), "raw_tp_null__attach"))
+		goto end;
+
+	ASSERT_OK(trigger_module_test_read(2), "trigger testmod read");
+	ASSERT_EQ(skel->bss->i, 3, "invocations");
+
+end:
+	raw_tp_null__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null.c b/tools/testing/selftests/bpf/progs/raw_tp_null.c
new file mode 100644
index 000000000000..457f34c151e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int tid;
+int i;
+
+SEC("tp_btf/bpf_testmod_test_raw_tp_null")
+int BPF_PROG(test_raw_tp_null, struct sk_buff *skb)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	if (task->pid != tid)
+		return 0;
+
+	i = i + skb->mark + 1;
+	/* The compiler may move the NULL check before this deref, which causes
+	 * the load to fail as deref of scalar. Prevent that by using a barrier.
+	 */
+	barrier();
+	/* If dead code elimination kicks in, the increment below will
+	 * be removed. For raw_tp programs, we mark input arguments as
+	 * PTR_MAYBE_NULL, so branch prediction should never kick in.
+	 */
+	if (!skb)
+		i += 2;
+	return 0;
+}
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 02e1204971b0..c0138cb19705 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -33,9 +33,16 @@ endif
 # LDLIBS.
 MAKEFLAGS += --no-builtin-rules
 
-CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS = -lrt -lpthread -lm
 
+# Some distributions (such as Ubuntu) configure GCC so that _FORTIFY_SOURCE is
+# automatically enabled at -O1 or above. This triggers various unused-result
+# warnings where functions such as read() or write() are called and their
+# return value is not checked. Disable _FORTIFY_SOURCE to silence those
+# warnings.
+CFLAGS += -U_FORTIFY_SOURCE
+
 TEST_GEN_FILES = cow
 TEST_GEN_FILES += compaction_test
 TEST_GEN_FILES += gup_longterm

