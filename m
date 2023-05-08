Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614C96FAD77
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjEHLfH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbjEHLez (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:34:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FBB3D22D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AC26631DC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2122DC433D2;
        Mon,  8 May 2023 11:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545586;
        bh=9MzuzXbYk0jKVGrjsxDW1izZe2D7HtK9yRfIxe+GalU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJoB0GOIZjbsY0mUa5duahsM8uradDi/wcExX8VSzREQmTxst0yOGNQlJmv4icYaM
         EOJxKgdu3ymlFAlqdejo951pNIpFXD2KnS2qOeVf0Mr+ahd7MpaNgx97pDAAV9DTkn
         ws2pK9j3VRv7rXM+zEfVwCGVcVkHzYHVhYId8nRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        William Zhang <william.zhang@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 088/371] arm64: dts: Add DTS files for bcmbca SoC BCM4912
Date:   Mon,  8 May 2023 11:44:49 +0200
Message-Id: <20230508094815.578344000@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: William Zhang <william.zhang@broadcom.com>

[ Upstream commit 1ba56aeb391401c4cb2126c39f90b3cdbfabdb3f ]

Add DTS for ARMv8 based broadband SoC BCM4912. bcm4912.dtsi is the
SoC description DTS header and bcm94912.dts is a simple DTS file for
Broadcom BCM94912 Reference board that only enable the UART port.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Stable-dep-of: 5cca02449490 ("arm64: dts: broadcom: bcmbca: bcm4908: fix NAND interrupt name")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/bcmbca/Makefile  |   3 +-
 .../boot/dts/broadcom/bcmbca/bcm4912.dtsi     | 128 ++++++++++++++++++
 .../boot/dts/broadcom/bcmbca/bcm94912.dts     |  30 ++++
 3 files changed, 160 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
index d5f89245336c4..b6e520e9f2f21 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_BCMBCA) += bcm963158.dtb
+dtb-$(CONFIG_ARCH_BCMBCA) += bcm94912.dtb \
+				bcm963158.dtb
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
new file mode 100644
index 0000000000000..3d016c2ce6759
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Broadcom Ltd.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "brcm,bcm4912", "brcm,bcmbca";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		B53_0: cpu@0 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_1: cpu@1 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_2: cpu@2 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_3: cpu@3 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		L2_0: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	pmu: pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&B53_0>, <&B53_1>,
+			<&B53_2>, <&B53_3>;
+	};
+
+	clocks: clocks {
+		periph_clk: periph-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
+		uart_clk: uart-clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clocks = <&periph_clk>;
+			clock-div = <4>;
+			clock-mult = <1>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	axi@81000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x81000000 0x8000>;
+
+		gic: interrupt-controller@1000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			reg = <0x1000 0x1000>,
+				<0x2000 0x2000>,
+				<0x4000 0x2000>,
+				<0x6000 0x2000>;
+		};
+	};
+
+	bus@ff800000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0xff800000 0x800000>;
+
+		uart0: serial@12000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12000 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_clk>, <&uart_clk>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts
new file mode 100644
index 0000000000000..a3623e6f6919c
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Broadcom Ltd.
+ */
+
+/dts-v1/;
+
+#include "bcm4912.dtsi"
+
+/ {
+	model = "Broadcom BCM94912 Reference Board";
+	compatible = "brcm,bcm94912", "brcm,bcm4912", "brcm,bcmbca";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x08000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.39.2



