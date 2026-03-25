Return-Path: <stable+bounces-230306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKiKLuK3w2litgQAu9opvQ
	(envelope-from <stable+bounces-230306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:24:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 473CE322DE2
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 649C1316ED04
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE83976B2;
	Wed, 25 Mar 2026 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TAV+Ufn4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6F73AF66E;
	Wed, 25 Mar 2026 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433812; cv=none; b=BT6/WPt8uF/4OMn4J0xMCuqZfrrASCQTFnn8tFT8z5PBy7B8H2U9B9D9OFlZ9txBcLQ7pHvXhEZs/QYwZktdqswKsdDH2Fz5FZSPUNXIl7kTljFk40isaIC/TBTSSdeDjq8dt6tpAo4IT4xQhvvru6RLwfC/KDYN0Ro2Qh104NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433812; c=relaxed/simple;
	bh=Jly1X2KLKtj2NL2lkmJiCXgq6tKNMatVKD1Tvjokp0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJ59yo+lXyY2oCMvXs0DHblp5sP+8nkywIyteyg7YVJK14PjuorACeofw81Ays9/qOLK7Xg+D4UzkLKbMnaMNUsBRC05I7xw6+VprrSiKmjbaxfiTTbZMOjdpo4eUdSYla6ghz7ThoxrFWW0HgIM47O71fXT7/CSwOUKAG+fWJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TAV+Ufn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08710C4CEF7;
	Wed, 25 Mar 2026 10:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774433811;
	bh=Jly1X2KLKtj2NL2lkmJiCXgq6tKNMatVKD1Tvjokp0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAV+Ufn4x2TSa7rEjZhwgxG246wwf6sHooAh+W6aLq737GD7RN7JxkYnNcYYkrSG0
	 zHj8JTBVOTamCJhUNy78OdMNdt+II2ylW4Kb+CQtuL6fSwPlQFspRNBJSbElPMCvbh
	 SELusF0PG8lp1pN5RatwQR6/KB+cqybne+AP0BRA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.19.10
Date: Wed, 25 Mar 2026 11:16:08 +0100
Message-ID: <2026032508-engaging-audacious-330a@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026032508-stifle-nemeses-098f@gregkh>
References: <2026032508-stifle-nemeses-098f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230306-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 473CE322DE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/netlink/specs/net_shaper.yaml
index 0b1b54be48f9..3f2ad772b64b 100644
--- a/Documentation/netlink/specs/net_shaper.yaml
+++ b/Documentation/netlink/specs/net_shaper.yaml
@@ -247,8 +247,8 @@ operations:
       flags: [admin-perm]
 
       do:
-        pre: net-shaper-nl-pre-doit
-        post: net-shaper-nl-post-doit
+        pre: net-shaper-nl-pre-doit-write
+        post: net-shaper-nl-post-doit-write
         request:
           attributes:
             - ifindex
@@ -278,8 +278,8 @@ operations:
       flags: [admin-perm]
 
       do:
-        pre: net-shaper-nl-pre-doit
-        post: net-shaper-nl-post-doit
+        pre: net-shaper-nl-pre-doit-write
+        post: net-shaper-nl-post-doit-write
         request:
           attributes: *ns-binding
 
@@ -309,8 +309,8 @@ operations:
       flags: [admin-perm]
 
       do:
-        pre: net-shaper-nl-pre-doit
-        post: net-shaper-nl-post-doit
+        pre: net-shaper-nl-pre-doit-write
+        post: net-shaper-nl-post-doit-write
         request:
           attributes:
             - ifindex
diff --git a/Makefile b/Makefile
index 96640a9632ef..1d3c0858833f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 19
-SUBLEVEL = 9
+SUBLEVEL = 10
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
index 4c97298fa763..3e1c98903cea 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
@@ -698,7 +698,7 @@ scif0: serial@c0700000 {
 			compatible = "renesas,scif-r8a78000",
 				     "renesas,rcar-gen5-scif", "renesas,scif";
 			reg = <0 0xc0700000 0 0x40>;
-			interrupts = <GIC_SPI 4074 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd16>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
@@ -708,7 +708,7 @@ scif1: serial@c0704000 {
 			compatible = "renesas,scif-r8a78000",
 				     "renesas,rcar-gen5-scif", "renesas,scif";
 			reg = <0 0xc0704000 0 0x40>;
-			interrupts = <GIC_SPI 4075 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd16>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
@@ -718,7 +718,7 @@ scif3: serial@c0708000 {
 			compatible = "renesas,scif-r8a78000",
 				     "renesas,rcar-gen5-scif", "renesas,scif";
 			reg = <0 0xc0708000 0 0x40>;
-			interrupts = <GIC_SPI 4076 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 12 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd16>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
@@ -728,7 +728,7 @@ scif4: serial@c070c000 {
 			compatible = "renesas,scif-r8a78000",
 				     "renesas,rcar-gen5-scif", "renesas,scif";
 			reg = <0 0xc070c000 0 0x40>;
-			interrupts = <GIC_SPI 4077 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 13 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd16>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
@@ -738,7 +738,7 @@ hscif0: serial@c0710000 {
 			compatible = "renesas,hscif-r8a78000",
 				     "renesas,rcar-gen5-hscif", "renesas,hscif";
 			reg = <0 0xc0710000 0 0x60>;
-			interrupts = <GIC_SPI 4078 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 14 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
@@ -748,7 +748,7 @@ hscif1: serial@c0714000 {
 			compatible = "renesas,hscif-r8a78000",
 				     "renesas,rcar-gen5-hscif", "renesas,hscif";
 			reg = <0 0xc0714000 0 0x60>;
-			interrupts = <GIC_SPI 4079 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
@@ -758,7 +758,7 @@ hscif2: serial@c0718000 {
 			compatible = "renesas,hscif-r8a78000",
 				     "renesas,rcar-gen5-hscif", "renesas,hscif";
 			reg = <0 0xc0718000 0 0x60>;
-			interrupts = <GIC_SPI 4080 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
@@ -768,7 +768,7 @@ hscif3: serial@c071c000 {
 			compatible = "renesas,hscif-r8a78000",
 				     "renesas,rcar-gen5-hscif", "renesas,hscif";
 			reg = <0 0xc071c000 0 0x60>;
-			interrupts = <GIC_SPI 4081 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index 4df32d7e9998..3d7f4dae5c19 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -581,16 +581,6 @@ ostm7: timer@12c03000 {
 			status = "disabled";
 		};
 
-		wdt0: watchdog@11c00400 {
-			compatible = "renesas,r9a09g057-wdt";
-			reg = <0 0x11c00400 0 0x400>;
-			clocks = <&cpg CPG_MOD 0x4b>, <&cpg CPG_MOD 0x4c>;
-			clock-names = "pclk", "oscclk";
-			resets = <&cpg 0x75>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
 		wdt1: watchdog@14400000 {
 			compatible = "renesas,r9a09g057-wdt";
 			reg = <0 0x14400000 0 0x400>;
@@ -601,26 +591,6 @@ wdt1: watchdog@14400000 {
 			status = "disabled";
 		};
 
-		wdt2: watchdog@13000000 {
-			compatible = "renesas,r9a09g057-wdt";
-			reg = <0 0x13000000 0 0x400>;
-			clocks = <&cpg CPG_MOD 0x4f>, <&cpg CPG_MOD 0x50>;
-			clock-names = "pclk", "oscclk";
-			resets = <&cpg 0x77>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
-		wdt3: watchdog@13000400 {
-			compatible = "renesas,r9a09g057-wdt";
-			reg = <0 0x13000400 0 0x400>;
-			clocks = <&cpg CPG_MOD 0x51>, <&cpg CPG_MOD 0x52>;
-			clock-names = "pclk", "oscclk";
-			resets = <&cpg 0x78>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
 		rtc: rtc@11c00800 {
 			compatible = "renesas,r9a09g057-rtca3", "renesas,rz-rtca3";
 			reg = <0 0x11c00800 0 0x400>;
diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index f5fa6ca06409..5f4d30f75cbd 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -747,8 +747,8 @@ mii_conv3: mii-conv@3 {
 
 		cpg: clock-controller@80280000 {
 			compatible = "renesas,r9a09g077-cpg-mssr";
-			reg = <0 0x80280000 0 0x1000>,
-			      <0 0x81280000 0 0x9000>;
+			reg = <0 0x80280000 0 0x10000>,
+			      <0 0x81280000 0 0x10000>;
 			clocks = <&extal_clk>;
 			clock-names = "extal";
 			#clock-cells = <2>;
diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 361a9235f00d..46f2b1fd98dc 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -750,8 +750,8 @@ mii_conv3: mii-conv@3 {
 
 		cpg: clock-controller@80280000 {
 			compatible = "renesas,r9a09g087-cpg-mssr";
-			reg = <0 0x80280000 0 0x1000>,
-			      <0 0x81280000 0 0x9000>;
+			reg = <0 0x80280000 0 0x10000>,
+			      <0 0x81280000 0 0x10000>;
 			clocks = <&extal_clk>;
 			clock-names = "extal";
 			#clock-cells = <2>;
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 6f25ab617982..fbfa6cfb1929 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -162,7 +162,7 @@ versa3: clock-generator@68 {
 				       <100000000>;
 		renesas,settings = [
 		  80 00 11 19 4c 42 dc 2f 06 7d 20 1a 5f 1e f2 27
-		  00 40 00 00 00 00 00 00 06 0c 19 02 3f f0 90 86
+		  00 40 00 00 00 00 00 00 06 0c 19 02 3b f0 90 86
 		  a0 80 30 30 9c
 		];
 	};
diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 63bd91690b54..890e4ddc1e78 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -53,6 +53,7 @@ vqmmc_sdhi0: regulator-vqmmc-sdhi0 {
 		regulator-max-microvolt = <3300000>;
 		gpios-states = <0>;
 		states = <3300000 0>, <1800000 1>;
+		regulator-ramp-delay = <60>;
 	};
 #endif
 
diff --git a/arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso b/arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso
index 0af1e0a6c7f4..fc53c1aae3b5 100644
--- a/arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso
+++ b/arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso
@@ -25,6 +25,7 @@ vqmmc_sdhi0: regulator-vqmmc-sdhi0 {
 		regulator-max-microvolt = <3300000>;
 		gpios-states = <0>;
 		states = <3300000 0>, <1800000 1>;
+		regulator-ramp-delay = <60>;
 	};
 };
 
diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index c64a06f58c0b..9e846ce4ef9c 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -12,6 +12,7 @@
 
 #include <asm/io.h>
 #include <asm/mem_encrypt.h>
+#include <asm/pgtable.h>
 #include <asm/rsi.h>
 
 static struct realm_config config;
@@ -146,7 +147,7 @@ void __init arm64_rsi_init(void)
 		return;
 	if (WARN_ON(rsi_get_realm_config(&config)))
 		return;
-	prot_ns_shared = BIT(config.ipa_bits - 1);
+	prot_ns_shared = __phys_to_pte_val(BIT(config.ipa_bits - 1));
 
 	if (arm64_ioremap_prot_hook_register(realm_ioremap_hook))
 		return;
diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
index 4e259d490e45..438269313e78 100644
--- a/arch/loongarch/include/asm/uaccess.h
+++ b/arch/loongarch/include/asm/uaccess.h
@@ -253,8 +253,13 @@ do {									\
 									\
 	__get_kernel_common(*((type *)(dst)), sizeof(type),		\
 			    (__force type *)(src));			\
-	if (unlikely(__gu_err))						\
+	if (unlikely(__gu_err))	{					\
+		pr_info("%s: memory access failed, ecode 0x%x\n",	\
+			__func__, read_csr_excode());			\
+		pr_info("%s: the caller is %pS\n",			\
+			__func__, __builtin_return_address(0));		\
 		goto err_label;						\
+	}								\
 } while (0)
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
@@ -264,8 +269,13 @@ do {									\
 									\
 	__pu_val = *(__force type *)(src);				\
 	__put_kernel_common(((type *)(dst)), sizeof(type));		\
-	if (unlikely(__pu_err))						\
+	if (unlikely(__pu_err))	{					\
+		pr_info("%s: memory access failed, ecode 0x%x\n",	\
+			__func__, read_csr_excode());			\
+		pr_info("%s: the caller is %pS\n",			\
+			__func__, __builtin_return_address(0));		\
 		goto err_label;						\
+	}								\
 } while (0)
 
 extern unsigned long __copy_user(void *to, const void *from, __kernel_size_t n);
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index bf037f0c6b26..9a9c34ea24b6 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -246,18 +246,21 @@ static int text_copy_cb(void *data)
 
 	if (smp_processor_id() == copy->cpu) {
 		ret = copy_to_kernel_nofault(copy->dst, copy->src, copy->len);
-		if (ret)
+		if (ret) {
 			pr_err("%s: operation failed\n", __func__);
+			return ret;
+		}
 	}
 
 	flush_icache_range((unsigned long)copy->dst, (unsigned long)copy->dst + copy->len);
 
-	return ret;
+	return 0;
 }
 
 int larch_insn_text_copy(void *dst, void *src, size_t len)
 {
 	int ret = 0;
+	int err = 0;
 	size_t start, end;
 	struct insn_copy copy = {
 		.dst = dst,
@@ -269,9 +272,19 @@ int larch_insn_text_copy(void *dst, void *src, size_t len)
 	start = round_down((size_t)dst, PAGE_SIZE);
 	end   = round_up((size_t)dst + len, PAGE_SIZE);
 
-	set_memory_rw(start, (end - start) / PAGE_SIZE);
+	err = set_memory_rw(start, (end - start) / PAGE_SIZE);
+	if (err) {
+		pr_info("%s: set_memory_rw() failed\n", __func__);
+		return err;
+	}
+
 	ret = stop_machine(text_copy_cb, &copy, cpu_online_mask);
-	set_memory_rox(start, (end - start) / PAGE_SIZE);
+
+	err = set_memory_rox(start, (end - start) / PAGE_SIZE);
+	if (err) {
+		pr_info("%s: set_memory_rox() failed\n", __func__);
+		return err;
+	}
 
 	return ret;
 }
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 4c5240d3a3c7..b189265785dc 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -953,7 +953,7 @@ SYSCALL_DEFINE3(cacheflush, unsigned long, addr, unsigned long, bytes,
 #else
 			"1: cmpb,<<,n	%0,%2,1b\n"
 #endif
-			"   fic,m	%3(%4,%0)\n"
+			"   fdc,m	%3(%4,%0)\n"
 			"2: sync\n"
 			ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 2b, "%1")
 			: "+r" (start), "+r" (error)
@@ -968,7 +968,7 @@ SYSCALL_DEFINE3(cacheflush, unsigned long, addr, unsigned long, bytes,
 #else
 			"1: cmpb,<<,n	%0,%2,1b\n"
 #endif
-			"   fdc,m	%3(%4,%0)\n"
+			"   fic,m	%3(%4,%0)\n"
 			"2: sync\n"
 			ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 2b, "%1")
 			: "+r" (start), "+r" (error)
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index af1329ae9f82..818de24921a4 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1369,6 +1369,8 @@ static void x86_pmu_enable(struct pmu *pmu)
 			else if (i < n_running)
 				continue;
 
+			cpuc->events[hwc->idx] = event;
+
 			if (hwc->state & PERF_HES_ARCH)
 				continue;
 
@@ -1376,7 +1378,6 @@ static void x86_pmu_enable(struct pmu *pmu)
 			 * if cpuc->enabled = 0, then no wrmsr as
 			 * per x86_pmu_enable_event()
 			 */
-			cpuc->events[hwc->idx] = event;
 			x86_pmu_start(event, PERF_EF_RELOAD);
 		}
 		cpuc->n_added = 0;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d85df652334f..20f078ceb51d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4367,6 +4367,19 @@ static inline void intel_pmu_set_acr_caused_constr(struct perf_event *event,
 		event->hw.dyn_constraint &= hybrid(event->pmu, acr_cause_mask64);
 }
 
+static inline int intel_set_branch_counter_constr(struct perf_event *event,
+						  int *num)
+{
+	if (branch_sample_call_stack(event))
+		return -EINVAL;
+	if (branch_sample_counters(event)) {
+		(*num)++;
+		event->hw.dyn_constraint &= x86_pmu.lbr_counters;
+	}
+
+	return 0;
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -4437,21 +4450,19 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		 * group, which requires the extra space to store the counters.
 		 */
 		leader = event->group_leader;
-		if (branch_sample_call_stack(leader))
+		if (intel_set_branch_counter_constr(leader, &num))
 			return -EINVAL;
-		if (branch_sample_counters(leader)) {
-			num++;
-			leader->hw.dyn_constraint &= x86_pmu.lbr_counters;
-		}
 		leader->hw.flags |= PERF_X86_EVENT_BRANCH_COUNTERS;
 
 		for_each_sibling_event(sibling, leader) {
-			if (branch_sample_call_stack(sibling))
+			if (intel_set_branch_counter_constr(sibling, &num))
+				return -EINVAL;
+		}
+
+		/* event isn't installed as a sibling yet. */
+		if (event != leader) {
+			if (intel_set_branch_counter_constr(event, &num))
 				return -EINVAL;
-			if (branch_sample_counters(sibling)) {
-				num++;
-				sibling->hw.dyn_constraint &= x86_pmu.lbr_counters;
-			}
 		}
 
 		if (num > fls(x86_pmu.lbr_counters))
diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index a78e4fed5720..1d91051daa3d 100644
--- a/arch/x86/hyperv/hv_crash.c
+++ b/arch/x86/hyperv/hv_crash.c
@@ -107,14 +107,12 @@ static void __noreturn hv_panic_timeout_reboot(void)
 		cpu_relax();
 }
 
-/* This cannot be inlined as it needs stack */
-static noinline __noclone void hv_crash_restore_tss(void)
+static void hv_crash_restore_tss(void)
 {
 	load_TR_desc();
 }
 
-/* This cannot be inlined as it needs stack */
-static noinline void hv_crash_clear_kernpt(void)
+static void hv_crash_clear_kernpt(void)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -125,6 +123,25 @@ static noinline void hv_crash_clear_kernpt(void)
 	native_p4d_clear(p4d);
 }
 
+
+static void __noreturn hv_crash_handle(void)
+{
+	hv_crash_restore_tss();
+	hv_crash_clear_kernpt();
+
+	/* we are now fully in devirtualized normal kernel mode */
+	__crash_kexec(NULL);
+
+	hv_panic_timeout_reboot();
+}
+
+/*
+ * __naked functions do not permit function calls, not even to __always_inline
+ * functions that only contain asm() blocks themselves. So use a macro instead.
+ */
+#define hv_wrmsr(msr, val) \
+	asm volatile("wrmsr" :: "c"(msr), "a"((u32)val), "d"((u32)(val >> 32)) : "memory")
+
 /*
  * This is the C entry point from the asm glue code after the disable hypercall.
  * We enter here in IA32-e long mode, ie, full 64bit mode running on kernel
@@ -133,51 +150,38 @@ static noinline void hv_crash_clear_kernpt(void)
  * available. We restore kernel GDT, and rest of the context, and continue
  * to kexec.
  */
-static asmlinkage void __noreturn hv_crash_c_entry(void)
+static void __naked hv_crash_c_entry(void)
 {
-	struct hv_crash_ctxt *ctxt = &hv_crash_ctxt;
-
 	/* first thing, restore kernel gdt */
-	native_load_gdt(&ctxt->gdtr);
+	asm volatile("lgdt %0" : : "m" (hv_crash_ctxt.gdtr));
 
-	asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
-	asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
+	asm volatile("movw %0, %%ss\n\t"
+		     "movq %1, %%rsp"
+		     :: "m"(hv_crash_ctxt.ss), "m"(hv_crash_ctxt.rsp));
 
-	asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds));
-	asm volatile("movw %%ax, %%es" : : "a"(ctxt->es));
-	asm volatile("movw %%ax, %%fs" : : "a"(ctxt->fs));
-	asm volatile("movw %%ax, %%gs" : : "a"(ctxt->gs));
+	asm volatile("movw %0, %%ds" : : "m"(hv_crash_ctxt.ds));
+	asm volatile("movw %0, %%es" : : "m"(hv_crash_ctxt.es));
+	asm volatile("movw %0, %%fs" : : "m"(hv_crash_ctxt.fs));
+	asm volatile("movw %0, %%gs" : : "m"(hv_crash_ctxt.gs));
 
-	native_wrmsrq(MSR_IA32_CR_PAT, ctxt->pat);
-	asm volatile("movq %0, %%cr0" : : "r"(ctxt->cr0));
+	hv_wrmsr(MSR_IA32_CR_PAT, hv_crash_ctxt.pat);
+	asm volatile("movq %0, %%cr0" : : "r"(hv_crash_ctxt.cr0));
 
-	asm volatile("movq %0, %%cr8" : : "r"(ctxt->cr8));
-	asm volatile("movq %0, %%cr4" : : "r"(ctxt->cr4));
-	asm volatile("movq %0, %%cr2" : : "r"(ctxt->cr4));
+	asm volatile("movq %0, %%cr8" : : "r"(hv_crash_ctxt.cr8));
+	asm volatile("movq %0, %%cr4" : : "r"(hv_crash_ctxt.cr4));
+	asm volatile("movq %0, %%cr2" : : "r"(hv_crash_ctxt.cr2));
 
-	native_load_idt(&ctxt->idtr);
-	native_wrmsrq(MSR_GS_BASE, ctxt->gsbase);
-	native_wrmsrq(MSR_EFER, ctxt->efer);
+	asm volatile("lidt %0" : : "m" (hv_crash_ctxt.idtr));
+	hv_wrmsr(MSR_GS_BASE, hv_crash_ctxt.gsbase);
+	hv_wrmsr(MSR_EFER, hv_crash_ctxt.efer);
 
 	/* restore the original kernel CS now via far return */
-	asm volatile("movzwq %0, %%rax\n\t"
-		     "pushq %%rax\n\t"
-		     "pushq $1f\n\t"
-		     "lretq\n\t"
-		     "1:nop\n\t" : : "m"(ctxt->cs) : "rax");
-
-	/* We are in asmlinkage without stack frame, hence make C function
-	 * calls which will buy stack frames.
-	 */
-	hv_crash_restore_tss();
-	hv_crash_clear_kernpt();
-
-	/* we are now fully in devirtualized normal kernel mode */
-	__crash_kexec(NULL);
-
-	hv_panic_timeout_reboot();
+	asm volatile("pushq %q0\n\t"
+		     "pushq %q1\n\t"
+		     "lretq"
+		     :: "r"(hv_crash_ctxt.cs), "r"(hv_crash_handle));
 }
-/* Tell gcc we are using lretq long jump in the above function intentionally */
+/* Tell objtool we are using lretq long jump in the above function intentionally */
 STACK_FRAME_NON_STANDARD(hv_crash_c_entry);
 
 static void hv_mark_tss_not_busy(void)
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 15209f220e1f..42568ceec481 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1708,8 +1708,22 @@ static void __init uv_system_init_hub(void)
 		struct uv_hub_info_s *new_hub;
 
 		/* Allocate & fill new per hub info list */
-		new_hub = (bid == 0) ?  &uv_hub_info_node0
-			: kzalloc_node(bytes, GFP_KERNEL, uv_blade_to_node(bid));
+		if (bid == 0) {
+			new_hub = &uv_hub_info_node0;
+		} else {
+			int nid;
+
+			/*
+			 * Deconfigured sockets are mapped to SOCK_EMPTY. Use
+			 * NUMA_NO_NODE to allocate on a valid node.
+			 */
+			nid = uv_blade_to_node(bid);
+			if (nid == SOCK_EMPTY)
+				nid = NUMA_NO_NODE;
+
+			new_hub = kzalloc_node(bytes, GFP_KERNEL, nid);
+		}
+
 		if (WARN_ON_ONCE(!new_hub)) {
 			/* do not kfree() bid 0, which is statically allocated */
 			while (--bid > 0)
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 3f1dda355307..7b9932f13bca 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -875,13 +875,18 @@ void amd_clear_bank(struct mce *m)
 {
 	amd_reset_thr_limit(m->bank);
 
-	/* Clear MCA_DESTAT for all deferred errors even those logged in MCA_STATUS. */
-	if (m->status & MCI_STATUS_DEFERRED)
-		mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+	if (mce_flags.smca) {
+		/*
+		 * Clear MCA_DESTAT for all deferred errors even those
+		 * logged in MCA_STATUS.
+		 */
+		if (m->status & MCI_STATUS_DEFERRED)
+			mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
 
-	/* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
-	if (m->kflags & MCE_CHECK_DFR_REGS)
-		return;
+		/* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
+		if (m->kflags & MCE_CHECK_DFR_REGS)
+			return;
+	}
 
 	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
 }
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 85096ce7b658..5a562e27d3a8 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -113,6 +113,10 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
 				     PCI_ANY_ID, PCI_ANY_ID, NULL);
 		if (ide_dev) {
 			errata.piix4.bmisx = pci_resource_start(ide_dev, 4);
+			if (errata.piix4.bmisx)
+				dev_dbg(&ide_dev->dev,
+					"Bus master activity detection (BM-IDE) erratum enabled\n");
+
 			pci_dev_put(ide_dev);
 		}
 
@@ -131,20 +135,17 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
 		if (isa_dev) {
 			pci_read_config_byte(isa_dev, 0x76, &value1);
 			pci_read_config_byte(isa_dev, 0x77, &value2);
-			if ((value1 & 0x80) || (value2 & 0x80))
+			if ((value1 & 0x80) || (value2 & 0x80)) {
 				errata.piix4.fdma = 1;
+				dev_dbg(&isa_dev->dev,
+					"Type-F DMA livelock erratum (C3 disabled)\n");
+			}
 			pci_dev_put(isa_dev);
 		}
 
 		break;
 	}
 
-	if (ide_dev)
-		dev_dbg(&ide_dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
-
-	if (isa_dev)
-		dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
-
 	return 0;
 }
 
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index da2c45880cc7..c9e65c6a2069 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -450,7 +450,7 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 
 	{{"_DSM",
 	  METHOD_4ARGS(ACPI_TYPE_BUFFER, ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER,
-		       ACPI_TYPE_ANY | ACPI_TYPE_PACKAGE) |
+		       ACPI_TYPE_PACKAGE | ACPI_TYPE_ANY) |
 		       ARG_COUNT_IS_MINIMUM,
 	  METHOD_RETURNS(ACPI_RTYPE_ALL)}},	/* Must return a value, but it can be of any type */
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7ee4eb94d218..a53325053722 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4185,6 +4185,9 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "ST3320[68]13AS",	"SD1[5-9]",	ATA_QUIRK_NONCQ |
 						ATA_QUIRK_FIRMWARE_WARN },
 
+	/* ADATA devices with LPM issues. */
+	{ "ADATA SU680",	NULL,		ATA_QUIRK_NOLPM },
+
 	/* Seagate disks with LPM issues */
 	{ "ST1000DM010-2EP102",	NULL,		ATA_QUIRK_NOLPM },
 	{ "ST2000DM008-2FR102",	NULL,		ATA_QUIRK_NOLPM },
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 98ee5e7f61eb..d93c4a1b0de5 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3600,7 +3600,7 @@ static unsigned int ata_scsiop_maint_in(struct ata_device *dev,
 
 	if (cdb[2] != 1 && cdb[2] != 3) {
 		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
-		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
+		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
 		return 0;
 	}
 
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 0ee8ea971aa4..335288e8b5b3 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1895,6 +1895,7 @@ void pm_runtime_reinit(struct device *dev)
 void pm_runtime_remove(struct device *dev)
 {
 	__pm_runtime_disable(dev, false);
+	flush_work(&dev->power.work);
 	pm_runtime_reinit(dev);
 }
 
diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 7c958d6065be..86a48d009d1b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -804,6 +804,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	 */
 	if (soc_type == QCA_WCN3988)
 		rom_ver = ((soc_ver & 0x00000f00) >> 0x05) | (soc_ver & 0x0000000f);
+	else if (soc_type == QCA_WCN3998)
+		rom_ver = ((soc_ver & 0x0000f000) >> 0x07) | (soc_ver & 0x0000000f);
 	else
 		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
 
diff --git a/drivers/cache/ax45mp_cache.c b/drivers/cache/ax45mp_cache.c
index 1d7dd3d2c101..934c5087ec2b 100644
--- a/drivers/cache/ax45mp_cache.c
+++ b/drivers/cache/ax45mp_cache.c
@@ -178,11 +178,11 @@ static const struct of_device_id ax45mp_cache_ids[] = {
 
 static int __init ax45mp_cache_init(void)
 {
-	struct device_node *np;
 	struct resource res;
 	int ret;
 
-	np = of_find_matching_node(NULL, ax45mp_cache_ids);
+	struct device_node *np __free(device_node) =
+		of_find_matching_node(NULL, ax45mp_cache_ids);
 	if (!of_device_is_available(np))
 		return -ENODEV;
 
diff --git a/drivers/cache/starfive_starlink_cache.c b/drivers/cache/starfive_starlink_cache.c
index 24c7d078ca22..3a25d2d7c70c 100644
--- a/drivers/cache/starfive_starlink_cache.c
+++ b/drivers/cache/starfive_starlink_cache.c
@@ -102,11 +102,11 @@ static const struct of_device_id starlink_cache_ids[] = {
 
 static int __init starlink_cache_init(void)
 {
-	struct device_node *np;
 	u32 block_size;
 	int ret;
 
-	np = of_find_matching_node(NULL, starlink_cache_ids);
+	struct device_node *np __free(device_node) =
+		of_find_matching_node(NULL, starlink_cache_ids);
 	if (!of_device_is_available(np))
 		return -ENODEV;
 
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index a590a67294e2..f8c3c1e44520 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -602,6 +602,22 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
 static int __scan_channels(struct ipmi_smi *intf,
 				struct ipmi_device_id *id, bool rescan);
 
+static void ipmi_lock_xmit_msgs(struct ipmi_smi *intf, int run_to_completion,
+				unsigned long *flags)
+{
+	if (run_to_completion)
+		return;
+	spin_lock_irqsave(&intf->xmit_msgs_lock, *flags);
+}
+
+static void ipmi_unlock_xmit_msgs(struct ipmi_smi *intf, int run_to_completion,
+				  unsigned long *flags)
+{
+	if (run_to_completion)
+		return;
+	spin_unlock_irqrestore(&intf->xmit_msgs_lock, *flags);
+}
+
 static void free_ipmi_user(struct kref *ref)
 {
 	struct ipmi_user *user = container_of(ref, struct ipmi_user, refcount);
@@ -1871,21 +1887,32 @@ static struct ipmi_smi_msg *smi_add_send_msg(struct ipmi_smi *intf,
 	return smi_msg;
 }
 
-static void smi_send(struct ipmi_smi *intf,
+static int smi_send(struct ipmi_smi *intf,
 		     const struct ipmi_smi_handlers *handlers,
 		     struct ipmi_smi_msg *smi_msg, int priority)
 {
 	int run_to_completion = READ_ONCE(intf->run_to_completion);
 	unsigned long flags = 0;
+	int rv = 0;
 
-	if (!run_to_completion)
-		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
+	ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
 	smi_msg = smi_add_send_msg(intf, smi_msg, priority);
-	if (!run_to_completion)
-		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
+	ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
 
-	if (smi_msg)
-		handlers->sender(intf->send_info, smi_msg);
+	if (smi_msg) {
+		rv = handlers->sender(intf->send_info, smi_msg);
+		if (rv) {
+			ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
+			intf->curr_msg = NULL;
+			ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
+			/*
+			 * Something may have been added to the transmit
+			 * queue, so schedule a check for that.
+			 */
+			queue_work(system_wq, &intf->smi_work);
+		}
+	}
+	return rv;
 }
 
 static bool is_maintenance_mode_cmd(struct kernel_ipmi_msg *msg)
@@ -2298,6 +2325,7 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	struct ipmi_recv_msg *recv_msg;
 	int run_to_completion = READ_ONCE(intf->run_to_completion);
 	int rv = 0;
+	bool in_seq_table = false;
 
 	if (supplied_recv) {
 		recv_msg = supplied_recv;
@@ -2351,33 +2379,50 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		rv = i_ipmi_req_ipmb(intf, addr, msgid, msg, smi_msg, recv_msg,
 				     source_address, source_lun,
 				     retries, retry_time_ms);
+		in_seq_table = true;
 	} else if (is_ipmb_direct_addr(addr)) {
 		rv = i_ipmi_req_ipmb_direct(intf, addr, msgid, msg, smi_msg,
 					    recv_msg, source_lun);
 	} else if (is_lan_addr(addr)) {
 		rv = i_ipmi_req_lan(intf, addr, msgid, msg, smi_msg, recv_msg,
 				    source_lun, retries, retry_time_ms);
+		in_seq_table = true;
 	} else {
-	    /* Unknown address type. */
+		/* Unknown address type. */
 		ipmi_inc_stat(intf, sent_invalid_commands);
 		rv = -EINVAL;
 	}
 
-	if (rv) {
-out_err:
-		if (!supplied_smi)
-			ipmi_free_smi_msg(smi_msg);
-		if (!supplied_recv)
-			ipmi_free_recv_msg(recv_msg);
-	} else {
+	if (!rv) {
 		dev_dbg(intf->si_dev, "Send: %*ph\n",
 			smi_msg->data_size, smi_msg->data);
 
-		smi_send(intf, intf->handlers, smi_msg, priority);
+		rv = smi_send(intf, intf->handlers, smi_msg, priority);
+		if (rv != IPMI_CC_NO_ERROR)
+			/* smi_send() returns an IPMI err, return a Linux one. */
+			rv = -EIO;
+		if (rv && in_seq_table) {
+			/*
+			 * If it's in the sequence table, it will be
+			 * retried later, so ignore errors.
+			 */
+			rv = 0;
+			/* But we need to fix the timeout. */
+			intf_start_seq_timer(intf, smi_msg->msgid);
+			ipmi_free_smi_msg(smi_msg);
+			smi_msg = NULL;
+		}
 	}
+out_err:
 	if (!run_to_completion)
 		mutex_unlock(&intf->users_mutex);
 
+	if (rv) {
+		if (!supplied_smi)
+			ipmi_free_smi_msg(smi_msg);
+		if (!supplied_recv)
+			ipmi_free_recv_msg(recv_msg);
+	}
 	return rv;
 }
 
@@ -3951,12 +3996,12 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
 		dev_dbg(intf->si_dev, "Invalid command: %*ph\n",
 			msg->data_size, msg->data);
 
-		smi_send(intf, intf->handlers, msg, 0);
-		/*
-		 * We used the message, so return the value that
-		 * causes it to not be freed or queued.
-		 */
-		rv = -1;
+		if (smi_send(intf, intf->handlers, msg, 0) == IPMI_CC_NO_ERROR)
+			/*
+			 * We used the message, so return the value that
+			 * causes it to not be freed or queued.
+			 */
+			rv = -1;
 	} else if (!IS_ERR(recv_msg)) {
 		/* Extract the source address from the data. */
 		ipmb_addr = (struct ipmi_ipmb_addr *) &recv_msg->addr;
@@ -4030,12 +4075,12 @@ static int handle_ipmb_direct_rcv_cmd(struct ipmi_smi *intf,
 		msg->data[4] = IPMI_INVALID_CMD_COMPLETION_CODE;
 		msg->data_size = 5;
 
-		smi_send(intf, intf->handlers, msg, 0);
-		/*
-		 * We used the message, so return the value that
-		 * causes it to not be freed or queued.
-		 */
-		rv = -1;
+		if (smi_send(intf, intf->handlers, msg, 0) == IPMI_CC_NO_ERROR)
+			/*
+			 * We used the message, so return the value that
+			 * causes it to not be freed or queued.
+			 */
+			rv = -1;
 	} else if (!IS_ERR(recv_msg)) {
 		/* Extract the source address from the data. */
 		daddr = (struct ipmi_ipmb_direct_addr *)&recv_msg->addr;
@@ -4175,7 +4220,7 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 				  struct ipmi_smi_msg *msg)
 {
 	struct cmd_rcvr          *rcvr;
-	int                      rv = 0;
+	int                      rv = 0; /* Free by default */
 	unsigned char            netfn;
 	unsigned char            cmd;
 	unsigned char            chan;
@@ -4228,12 +4273,12 @@ static int handle_lan_get_msg_cmd(struct ipmi_smi *intf,
 		dev_dbg(intf->si_dev, "Invalid command: %*ph\n",
 			msg->data_size, msg->data);
 
-		smi_send(intf, intf->handlers, msg, 0);
-		/*
-		 * We used the message, so return the value that
-		 * causes it to not be freed or queued.
-		 */
-		rv = -1;
+		if (smi_send(intf, intf->handlers, msg, 0) == IPMI_CC_NO_ERROR)
+			/*
+			 * We used the message, so return the value that
+			 * causes it to not be freed or queued.
+			 */
+			rv = -1;
 	} else if (!IS_ERR(recv_msg)) {
 		/* Extract the source address from the data. */
 		lan_addr = (struct ipmi_lan_addr *) &recv_msg->addr;
@@ -4826,8 +4871,7 @@ static void smi_work(struct work_struct *t)
 	 * message delivery.
 	 */
 restart:
-	if (!run_to_completion)
-		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
+	ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
 	if (intf->curr_msg == NULL && !intf->in_shutdown) {
 		struct list_head *entry = NULL;
 
@@ -4843,8 +4887,7 @@ static void smi_work(struct work_struct *t)
 			intf->curr_msg = newmsg;
 		}
 	}
-	if (!run_to_completion)
-		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
+	ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
 
 	if (newmsg) {
 		cc = intf->handlers->sender(intf->send_info, newmsg);
@@ -4852,13 +4895,9 @@ static void smi_work(struct work_struct *t)
 			if (newmsg->recv_msg)
 				deliver_err_response(intf,
 						     newmsg->recv_msg, cc);
-			if (!run_to_completion)
-				spin_lock_irqsave(&intf->xmit_msgs_lock,
-						  flags);
+			ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
 			intf->curr_msg = NULL;
-			if (!run_to_completion)
-				spin_unlock_irqrestore(&intf->xmit_msgs_lock,
-						       flags);
+			ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
 			ipmi_free_smi_msg(newmsg);
 			newmsg = NULL;
 			goto restart;
@@ -4928,16 +4967,14 @@ void ipmi_smi_msg_received(struct ipmi_smi *intf,
 		spin_unlock_irqrestore(&intf->waiting_rcv_msgs_lock,
 				       flags);
 
-	if (!run_to_completion)
-		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
+	ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
 	/*
 	 * We can get an asynchronous event or receive message in addition
 	 * to commands we send.
 	 */
 	if (msg == intf->curr_msg)
 		intf->curr_msg = NULL;
-	if (!run_to_completion)
-		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
+	ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
 
 	if (run_to_completion)
 		smi_work(&intf->smi_work);
@@ -5050,7 +5087,12 @@ static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
 				ipmi_inc_stat(intf,
 					      retransmitted_ipmb_commands);
 
-			smi_send(intf, intf->handlers, smi_msg, 0);
+			/* If this fails we'll retry later or timeout. */
+			if (smi_send(intf, intf->handlers, smi_msg, 0) != IPMI_CC_NO_ERROR) {
+				/* But fix the timeout. */
+				intf_start_seq_timer(intf, smi_msg->msgid);
+				ipmi_free_smi_msg(smi_msg);
+			}
 		} else
 			ipmi_free_smi_msg(smi_msg);
 
diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 0fcf4a39de27..a12653a65869 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -52,9 +52,10 @@ static int atmel_sha204a_rng_read_nonblocking(struct hwrng *rng, void *data,
 		rng->priv = 0;
 	} else {
 		work_data = kmalloc(sizeof(*work_data), GFP_ATOMIC);
-		if (!work_data)
+		if (!work_data) {
+			atomic_dec(&i2c_priv->tfm_count);
 			return -ENOMEM;
-
+		}
 		work_data->ctx = i2c_priv;
 		work_data->client = i2c_priv->client;
 
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 0d90b5f6a454..a554fe3de3fd 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -2408,10 +2408,8 @@ static int sev_ioctl_do_snp_platform_status(struct sev_issue_cmd *argp)
 		 * in Firmware state on failure. Use snp_reclaim_pages() to
 		 * transition either case back to Hypervisor-owned state.
 		 */
-		if (snp_reclaim_pages(__pa(data), 1, true)) {
-			snp_leak_pages(__page_to_pfn(status_page), 1);
+		if (snp_reclaim_pages(__pa(data), 1, true))
 			return -EFAULT;
-		}
 	}
 
 	if (ret)
diff --git a/drivers/crypto/padlock-sha.c b/drivers/crypto/padlock-sha.c
index 329f60ad422e..9214bbfc868f 100644
--- a/drivers/crypto/padlock-sha.c
+++ b/drivers/crypto/padlock-sha.c
@@ -332,6 +332,13 @@ static int __init padlock_init(void)
 	if (!x86_match_cpu(padlock_sha_ids) || !boot_cpu_has(X86_FEATURE_PHE_EN))
 		return -ENODEV;
 
+	/*
+	 * Skip family 0x07 and newer used by Zhaoxin processors,
+	 * as the driver's self-tests fail on these CPUs.
+	 */
+	if (c->x86 >= 0x07)
+		return -ENODEV;
+
 	/* Register the newly added algorithm module if on *
 	* VIA Nano processor, or else just do as before */
 	if (c->x86_model < 0x0f) {
diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 6d6446713539..e82945408955 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -257,9 +257,10 @@ static void fwnet_header_cache_update(struct hh_cache *hh,
 	memcpy((u8 *)hh->hh_data + HH_DATA_OFF(FWNET_HLEN), haddr, net->addr_len);
 }
 
-static int fwnet_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+static int fwnet_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+			      unsigned char *haddr)
 {
-	memcpy(haddr, skb->dev->dev_addr, FWNET_ALEN);
+	memcpy(haddr, dev->dev_addr, FWNET_ALEN);
 
 	return FWNET_ALEN;
 }
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 11a702e7f641..f6ceae987acb 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -205,12 +205,12 @@ static int ffa_rxtx_map(phys_addr_t tx_buf, phys_addr_t rx_buf, u32 pg_cnt)
 	return 0;
 }
 
-static int ffa_rxtx_unmap(u16 vm_id)
+static int ffa_rxtx_unmap(void)
 {
 	ffa_value_t ret;
 
 	invoke_ffa_fn((ffa_value_t){
-		      .a0 = FFA_RXTX_UNMAP, .a1 = PACK_TARGET_INFO(vm_id, 0),
+		      .a0 = FFA_RXTX_UNMAP,
 		      }, &ret);
 
 	if (ret.a0 == FFA_ERROR)
@@ -2093,7 +2093,7 @@ static int __init ffa_init(void)
 
 	pr_err("failed to setup partitions\n");
 	ffa_notifications_cleanup();
-	ffa_rxtx_unmap(drv_info->vm_id);
+	ffa_rxtx_unmap();
 free_pages:
 	if (drv_info->tx_buffer)
 		free_pages_exact(drv_info->tx_buffer, rxtx_bufsz);
@@ -2108,7 +2108,7 @@ static void __exit ffa_exit(void)
 {
 	ffa_notifications_cleanup();
 	ffa_partitions_cleanup();
-	ffa_rxtx_unmap(drv_info->vm_id);
+	ffa_rxtx_unmap();
 	free_pages_exact(drv_info->tx_buffer, drv_info->rxtx_bufsz);
 	free_pages_exact(drv_info->rx_buffer, drv_info->rxtx_bufsz);
 	kfree(drv_info);
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index dee9f238f6fd..2047edbdc5f6 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1066,7 +1066,7 @@ static int scmi_register_event_handler(struct scmi_notify_instance *ni,
  * since at creation time we usually want to have all setup and ready before
  * events really start flowing.
  *
- * Return: A properly refcounted handler on Success, NULL on Failure
+ * Return: A properly refcounted handler on Success, ERR_PTR on Failure
  */
 static inline struct scmi_event_handler *
 __scmi_event_handler_get_ops(struct scmi_notify_instance *ni,
@@ -1113,7 +1113,7 @@ __scmi_event_handler_get_ops(struct scmi_notify_instance *ni,
 	}
 	mutex_unlock(&ni->pending_mtx);
 
-	return hndl;
+	return hndl ?: ERR_PTR(-ENODEV);
 }
 
 static struct scmi_event_handler *
diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 87c323de17b9..398642cc25d9 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -18,6 +18,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -940,13 +941,13 @@ static int scpi_probe(struct platform_device *pdev)
 		int idx = scpi_drvinfo->num_chans;
 		struct scpi_chan *pchan = scpi_drvinfo->channels + idx;
 		struct mbox_client *cl = &pchan->cl;
-		struct device_node *shmem = of_parse_phandle(np, "shmem", idx);
+		struct device_node *shmem __free(device_node) =
+			of_parse_phandle(np, "shmem", idx);
 
 		if (!of_match_node(shmem_of_match, shmem))
 			return -ENXIO;
 
 		ret = of_address_to_resource(shmem, 0, &res);
-		of_node_put(shmem);
 		if (ret) {
 			dev_err(dev, "failed to get SCPI payload mem resource\n");
 			return ret;
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 515b948ff320..5c9d55a94a1b 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -37,15 +37,14 @@
  * service layer will return error to FPGA manager when timeout occurs,
  * timeout is set to 30 seconds (30 * 1000) at Intel Stratix10 SoC.
  */
-#define SVC_NUM_DATA_IN_FIFO			32
+#define SVC_NUM_DATA_IN_FIFO			8
 #define SVC_NUM_CHANNEL				4
-#define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
+#define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	2000
 #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
 #define BYTE_TO_WORD_SIZE              4
 
 /* stratix10 service layer clients */
 #define STRATIX10_RSU				"stratix10-rsu"
-#define INTEL_FCS				"intel-fcs"
 
 /* Maximum number of SDM client IDs. */
 #define MAX_SDM_CLIENT_IDS			16
@@ -105,11 +104,9 @@ struct stratix10_svc_chan;
 /**
  * struct stratix10_svc - svc private data
  * @stratix10_svc_rsu: pointer to stratix10 RSU device
- * @intel_svc_fcs: pointer to the FCS device
  */
 struct stratix10_svc {
 	struct platform_device *stratix10_svc_rsu;
-	struct platform_device *intel_svc_fcs;
 };
 
 /**
@@ -251,12 +248,10 @@ struct stratix10_async_ctrl {
  * @num_active_client: number of active service client
  * @node: list management
  * @genpool: memory pool pointing to the memory region
- * @task: pointer to the thread task which handles SMC or HVC call
- * @svc_fifo: a queue for storing service message data
  * @complete_status: state for completion
- * @svc_fifo_lock: protect access to service message data queue
  * @invoke_fn: function to issue secure monitor call or hypervisor call
  * @svc: manages the list of client svc drivers
+ * @sdm_lock: only allows a single command single response to SDM
  * @actrl: async control structure
  *
  * This struct is used to create communication channels for service clients, to
@@ -269,12 +264,10 @@ struct stratix10_svc_controller {
 	int num_active_client;
 	struct list_head node;
 	struct gen_pool *genpool;
-	struct task_struct *task;
-	struct kfifo svc_fifo;
 	struct completion complete_status;
-	spinlock_t svc_fifo_lock;
 	svc_invoke_fn *invoke_fn;
 	struct stratix10_svc *svc;
+	struct mutex sdm_lock;
 	struct stratix10_async_ctrl actrl;
 };
 
@@ -283,6 +276,9 @@ struct stratix10_svc_controller {
  * @ctrl: pointer to service controller which is the provider of this channel
  * @scl: pointer to service client which owns the channel
  * @name: service client name associated with the channel
+ * @task: pointer to the thread task which handles SMC or HVC call
+ * @svc_fifo: a queue for storing service message data (separate fifo for every channel)
+ * @svc_fifo_lock: protect access to service message data queue (locking pending fifo)
  * @lock: protect access to the channel
  * @async_chan: reference to asynchronous channel object for this channel
  *
@@ -293,6 +289,9 @@ struct stratix10_svc_chan {
 	struct stratix10_svc_controller *ctrl;
 	struct stratix10_svc_client *scl;
 	char *name;
+	struct task_struct *task;
+	struct kfifo svc_fifo;
+	spinlock_t svc_fifo_lock;
 	spinlock_t lock;
 	struct stratix10_async_chan *async_chan;
 };
@@ -527,10 +526,10 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
  */
 static int svc_normal_to_secure_thread(void *data)
 {
-	struct stratix10_svc_controller
-			*ctrl = (struct stratix10_svc_controller *)data;
-	struct stratix10_svc_data *pdata;
-	struct stratix10_svc_cb_data *cbdata;
+	struct stratix10_svc_chan *chan = (struct stratix10_svc_chan *)data;
+	struct stratix10_svc_controller *ctrl = chan->ctrl;
+	struct stratix10_svc_data *pdata = NULL;
+	struct stratix10_svc_cb_data *cbdata = NULL;
 	struct arm_smccc_res res;
 	unsigned long a0, a1, a2, a3, a4, a5, a6, a7;
 	int ret_fifo = 0;
@@ -555,12 +554,12 @@ static int svc_normal_to_secure_thread(void *data)
 	a6 = 0;
 	a7 = 0;
 
-	pr_debug("smc_hvc_shm_thread is running\n");
+	pr_debug("%s: %s: Thread is running!\n", __func__, chan->name);
 
 	while (!kthread_should_stop()) {
-		ret_fifo = kfifo_out_spinlocked(&ctrl->svc_fifo,
+		ret_fifo = kfifo_out_spinlocked(&chan->svc_fifo,
 						pdata, sizeof(*pdata),
-						&ctrl->svc_fifo_lock);
+						&chan->svc_fifo_lock);
 
 		if (!ret_fifo)
 			continue;
@@ -569,9 +568,25 @@ static int svc_normal_to_secure_thread(void *data)
 			 (unsigned int)pdata->paddr, pdata->command,
 			 (unsigned int)pdata->size);
 
+		/* SDM can only process one command at a time */
+		pr_debug("%s: %s: Thread is waiting for mutex!\n",
+			 __func__, chan->name);
+		if (mutex_lock_interruptible(&ctrl->sdm_lock)) {
+			/* item already dequeued; notify client to unblock it */
+			cbdata->status = BIT(SVC_STATUS_ERROR);
+			cbdata->kaddr1 = NULL;
+			cbdata->kaddr2 = NULL;
+			cbdata->kaddr3 = NULL;
+			if (pdata->chan->scl)
+				pdata->chan->scl->receive_cb(pdata->chan->scl,
+							     cbdata);
+			break;
+		}
+
 		switch (pdata->command) {
 		case COMMAND_RECONFIG_DATA_CLAIM:
 			svc_thread_cmd_data_claim(ctrl, pdata, cbdata);
+			mutex_unlock(&ctrl->sdm_lock);
 			continue;
 		case COMMAND_RECONFIG:
 			a0 = INTEL_SIP_SMC_FPGA_CONFIG_START;
@@ -700,10 +715,11 @@ static int svc_normal_to_secure_thread(void *data)
 			break;
 		default:
 			pr_warn("it shouldn't happen\n");
-			break;
+			mutex_unlock(&ctrl->sdm_lock);
+			continue;
 		}
-		pr_debug("%s: before SMC call -- a0=0x%016x a1=0x%016x",
-			 __func__,
+		pr_debug("%s: %s: before SMC call -- a0=0x%016x a1=0x%016x",
+			 __func__, chan->name,
 			 (unsigned int)a0,
 			 (unsigned int)a1);
 		pr_debug(" a2=0x%016x\n", (unsigned int)a2);
@@ -712,8 +728,8 @@ static int svc_normal_to_secure_thread(void *data)
 		pr_debug(" a5=0x%016x\n", (unsigned int)a5);
 		ctrl->invoke_fn(a0, a1, a2, a3, a4, a5, a6, a7, &res);
 
-		pr_debug("%s: after SMC call -- res.a0=0x%016x",
-			 __func__, (unsigned int)res.a0);
+		pr_debug("%s: %s: after SMC call -- res.a0=0x%016x",
+			 __func__, chan->name, (unsigned int)res.a0);
 		pr_debug(" res.a1=0x%016x, res.a2=0x%016x",
 			 (unsigned int)res.a1, (unsigned int)res.a2);
 		pr_debug(" res.a3=0x%016x\n", (unsigned int)res.a3);
@@ -728,6 +744,7 @@ static int svc_normal_to_secure_thread(void *data)
 			cbdata->kaddr2 = NULL;
 			cbdata->kaddr3 = NULL;
 			pdata->chan->scl->receive_cb(pdata->chan->scl, cbdata);
+			mutex_unlock(&ctrl->sdm_lock);
 			continue;
 		}
 
@@ -801,6 +818,8 @@ static int svc_normal_to_secure_thread(void *data)
 			break;
 
 		}
+
+		mutex_unlock(&ctrl->sdm_lock);
 	}
 
 	kfree(cbdata);
@@ -1317,7 +1336,7 @@ int stratix10_svc_async_send(struct stratix10_svc_chan *chan, void *msg,
 		dev_dbg(ctrl->dev,
 			"Async message sent with transaction_id 0x%02x\n",
 			handle->transaction_id);
-			*handler = handle;
+		*handler = handle;
 		return 0;
 	case INTEL_SIP_SMC_STATUS_BUSY:
 		dev_warn(ctrl->dev, "Mailbox is busy, try after some time\n");
@@ -1696,22 +1715,33 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 	if (!p_data)
 		return -ENOMEM;
 
-	/* first client will create kernel thread */
-	if (!chan->ctrl->task) {
-		chan->ctrl->task =
-			kthread_run_on_cpu(svc_normal_to_secure_thread,
-					   (void *)chan->ctrl,
-					   cpu, "svc_smc_hvc_thread");
-			if (IS_ERR(chan->ctrl->task)) {
-				dev_err(chan->ctrl->dev,
-					"failed to create svc_smc_hvc_thread\n");
-				kfree(p_data);
-				return -EINVAL;
-			}
+	/* first caller creates the per-channel kthread */
+	if (!chan->task) {
+		struct task_struct *task;
+
+		task = kthread_run_on_cpu(svc_normal_to_secure_thread,
+					  (void *)chan,
+					  cpu, "svc_smc_hvc_thread");
+		if (IS_ERR(task)) {
+			dev_err(chan->ctrl->dev,
+				"failed to create svc_smc_hvc_thread\n");
+			kfree(p_data);
+			return -EINVAL;
+		}
+
+		spin_lock(&chan->lock);
+		if (chan->task) {
+			/* another caller won the race; discard our thread */
+			spin_unlock(&chan->lock);
+			kthread_stop(task);
+		} else {
+			chan->task = task;
+			spin_unlock(&chan->lock);
+		}
 	}
 
-	pr_debug("%s: sent P-va=%p, P-com=%x, P-size=%u\n", __func__,
-		 p_msg->payload, p_msg->command,
+	pr_debug("%s: %s: sent P-va=%p, P-com=%x, P-size=%u\n", __func__,
+		 chan->name, p_msg->payload, p_msg->command,
 		 (unsigned int)p_msg->payload_length);
 
 	if (list_empty(&svc_data_mem)) {
@@ -1747,12 +1777,16 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 	p_data->arg[2] = p_msg->arg[2];
 	p_data->size = p_msg->payload_length;
 	p_data->chan = chan;
-	pr_debug("%s: put to FIFO pa=0x%016x, cmd=%x, size=%u\n", __func__,
-	       (unsigned int)p_data->paddr, p_data->command,
-	       (unsigned int)p_data->size);
-	ret = kfifo_in_spinlocked(&chan->ctrl->svc_fifo, p_data,
+	pr_debug("%s: %s: put to FIFO pa=0x%016x, cmd=%x, size=%u\n",
+		 __func__,
+		 chan->name,
+		 (unsigned int)p_data->paddr,
+		 p_data->command,
+		 (unsigned int)p_data->size);
+
+	ret = kfifo_in_spinlocked(&chan->svc_fifo, p_data,
 				  sizeof(*p_data),
-				  &chan->ctrl->svc_fifo_lock);
+				  &chan->svc_fifo_lock);
 
 	kfree(p_data);
 
@@ -1773,11 +1807,12 @@ EXPORT_SYMBOL_GPL(stratix10_svc_send);
  */
 void stratix10_svc_done(struct stratix10_svc_chan *chan)
 {
-	/* stop thread when thread is running AND only one active client */
-	if (chan->ctrl->task && chan->ctrl->num_active_client <= 1) {
-		pr_debug("svc_smc_hvc_shm_thread is stopped\n");
-		kthread_stop(chan->ctrl->task);
-		chan->ctrl->task = NULL;
+	/* stop thread when thread is running */
+	if (chan->task) {
+		pr_debug("%s: %s: svc_smc_hvc_shm_thread is stopping\n",
+			 __func__, chan->name);
+		kthread_stop(chan->task);
+		chan->task = NULL;
 	}
 }
 EXPORT_SYMBOL_GPL(stratix10_svc_done);
@@ -1817,8 +1852,8 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	pmem->paddr = pa;
 	pmem->size = s;
 	list_add_tail(&pmem->node, &svc_data_mem);
-	pr_debug("%s: va=%p, pa=0x%016x\n", __func__,
-		 pmem->vaddr, (unsigned int)pmem->paddr);
+	pr_debug("%s: %s: va=%p, pa=0x%016x\n", __func__,
+		 chan->name, pmem->vaddr, (unsigned int)pmem->paddr);
 
 	return (void *)va;
 }
@@ -1855,6 +1890,13 @@ static const struct of_device_id stratix10_svc_drv_match[] = {
 	{},
 };
 
+static const char * const chan_names[SVC_NUM_CHANNEL] = {
+	SVC_CLIENT_FPGA,
+	SVC_CLIENT_RSU,
+	SVC_CLIENT_FCS,
+	SVC_CLIENT_HWMON
+};
+
 static int stratix10_svc_drv_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1862,11 +1904,11 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	struct stratix10_svc_chan *chans;
 	struct gen_pool *genpool;
 	struct stratix10_svc_sh_memory *sh_memory;
-	struct stratix10_svc *svc;
+	struct stratix10_svc *svc = NULL;
 
 	svc_invoke_fn *invoke_fn;
 	size_t fifo_size;
-	int ret;
+	int ret, i = 0;
 
 	/* get SMC or HVC function */
 	invoke_fn = get_invoke_func(dev);
@@ -1905,8 +1947,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	controller->num_active_client = 0;
 	controller->chans = chans;
 	controller->genpool = genpool;
-	controller->task = NULL;
 	controller->invoke_fn = invoke_fn;
+	INIT_LIST_HEAD(&controller->node);
 	init_completion(&controller->complete_status);
 
 	ret = stratix10_svc_async_init(controller);
@@ -1917,32 +1959,20 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	}
 
 	fifo_size = sizeof(struct stratix10_svc_data) * SVC_NUM_DATA_IN_FIFO;
-	ret = kfifo_alloc(&controller->svc_fifo, fifo_size, GFP_KERNEL);
-	if (ret) {
-		dev_err(dev, "failed to allocate FIFO\n");
-		goto err_async_exit;
-	}
-	spin_lock_init(&controller->svc_fifo_lock);
-
-	chans[0].scl = NULL;
-	chans[0].ctrl = controller;
-	chans[0].name = SVC_CLIENT_FPGA;
-	spin_lock_init(&chans[0].lock);
-
-	chans[1].scl = NULL;
-	chans[1].ctrl = controller;
-	chans[1].name = SVC_CLIENT_RSU;
-	spin_lock_init(&chans[1].lock);
-
-	chans[2].scl = NULL;
-	chans[2].ctrl = controller;
-	chans[2].name = SVC_CLIENT_FCS;
-	spin_lock_init(&chans[2].lock);
+	mutex_init(&controller->sdm_lock);
 
-	chans[3].scl = NULL;
-	chans[3].ctrl = controller;
-	chans[3].name = SVC_CLIENT_HWMON;
-	spin_lock_init(&chans[3].lock);
+	for (i = 0; i < SVC_NUM_CHANNEL; i++) {
+		chans[i].scl = NULL;
+		chans[i].ctrl = controller;
+		chans[i].name = (char *)chan_names[i];
+		spin_lock_init(&chans[i].lock);
+		ret = kfifo_alloc(&chans[i].svc_fifo, fifo_size, GFP_KERNEL);
+		if (ret) {
+			dev_err(dev, "failed to allocate FIFO %d\n", i);
+			goto err_free_fifos;
+		}
+		spin_lock_init(&chans[i].svc_fifo_lock);
+	}
 
 	list_add_tail(&controller->node, &svc_ctrl);
 	platform_set_drvdata(pdev, controller);
@@ -1951,7 +1981,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	svc = devm_kzalloc(dev, sizeof(*svc), GFP_KERNEL);
 	if (!svc) {
 		ret = -ENOMEM;
-		goto err_free_kfifo;
+		goto err_free_fifos;
 	}
 	controller->svc = svc;
 
@@ -1959,51 +1989,43 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	if (!svc->stratix10_svc_rsu) {
 		dev_err(dev, "failed to allocate %s device\n", STRATIX10_RSU);
 		ret = -ENOMEM;
-		goto err_free_kfifo;
+		goto err_free_fifos;
 	}
 
 	ret = platform_device_add(svc->stratix10_svc_rsu);
-	if (ret) {
-		platform_device_put(svc->stratix10_svc_rsu);
-		goto err_free_kfifo;
-	}
-
-	svc->intel_svc_fcs = platform_device_alloc(INTEL_FCS, 1);
-	if (!svc->intel_svc_fcs) {
-		dev_err(dev, "failed to allocate %s device\n", INTEL_FCS);
-		ret = -ENOMEM;
-		goto err_unregister_rsu_dev;
-	}
-
-	ret = platform_device_add(svc->intel_svc_fcs);
-	if (ret) {
-		platform_device_put(svc->intel_svc_fcs);
-		goto err_unregister_rsu_dev;
-	}
+	if (ret)
+		goto err_put_device;
 
 	ret = of_platform_default_populate(dev_of_node(dev), NULL, dev);
 	if (ret)
-		goto err_unregister_fcs_dev;
+		goto err_unregister_rsu_dev;
 
 	pr_info("Intel Service Layer Driver Initialized\n");
 
 	return 0;
 
-err_unregister_fcs_dev:
-	platform_device_unregister(svc->intel_svc_fcs);
 err_unregister_rsu_dev:
 	platform_device_unregister(svc->stratix10_svc_rsu);
-err_free_kfifo:
-	kfifo_free(&controller->svc_fifo);
-err_async_exit:
+	goto err_free_fifos;
+err_put_device:
+	platform_device_put(svc->stratix10_svc_rsu);
+err_free_fifos:
+	/* only remove from list if list_add_tail() was reached */
+	if (!list_empty(&controller->node))
+		list_del(&controller->node);
+	/* free only the FIFOs that were successfully allocated */
+	while (i--)
+		kfifo_free(&chans[i].svc_fifo);
 	stratix10_svc_async_exit(controller);
 err_destroy_pool:
 	gen_pool_destroy(genpool);
+
 	return ret;
 }
 
 static void stratix10_svc_drv_remove(struct platform_device *pdev)
 {
+	int i;
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
 	struct stratix10_svc *svc = ctrl->svc;
 
@@ -2011,14 +2033,16 @@ static void stratix10_svc_drv_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(ctrl->dev);
 
-	platform_device_unregister(svc->intel_svc_fcs);
 	platform_device_unregister(svc->stratix10_svc_rsu);
 
-	kfifo_free(&ctrl->svc_fifo);
-	if (ctrl->task) {
-		kthread_stop(ctrl->task);
-		ctrl->task = NULL;
+	for (i = 0; i < SVC_NUM_CHANNEL; i++) {
+		if (ctrl->chans[i].task) {
+			kthread_stop(ctrl->chans[i].task);
+			ctrl->chans[i].task = NULL;
+		}
+		kfifo_free(&ctrl->chans[i].svc_fifo);
 	}
+
 	if (ctrl->genpool)
 		gen_pool_destroy(ctrl->genpool);
 	list_del(&ctrl->node);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 66fb37b64388..ded22f244ada 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -36,6 +36,7 @@
 
 #define AMDGPU_BO_LIST_MAX_PRIORITY	32u
 #define AMDGPU_BO_LIST_NUM_BUCKETS	(AMDGPU_BO_LIST_MAX_PRIORITY + 1)
+#define AMDGPU_BO_LIST_MAX_ENTRIES	(128 * 1024)
 
 static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
 {
@@ -190,6 +191,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
 
+	if (bo_number > AMDGPU_BO_LIST_MAX_ENTRIES)
+		return -EINVAL;
+
 	/* copy the handle array from userspace to a kernel buffer */
 	if (likely(info_size == bo_info_size)) {
 		info = vmemdup_array_user(uptr, bo_number, info_size);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 051c12ab5968..1726f6262f33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5081,7 +5081,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	 * before ip_fini_early to prevent kfd locking refcount issues by calling
 	 * amdgpu_amdkfd_suspend()
 	 */
-	if (drm_dev_is_unplugged(adev_to_drm(adev)))
+	if (pci_dev_is_disconnected(adev->pdev))
 		amdgpu_amdkfd_device_fini_sw(adev);
 
 	amdgpu_device_ip_fini_early(adev);
@@ -5093,7 +5093,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
-	if (drm_dev_is_unplugged(adev_to_drm(adev)))
+	if (pci_dev_is_disconnected(adev->pdev))
 		amdgpu_device_unmap_mmio(adev);
 
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bd7f83efed18..da25ba1578b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1069,7 +1069,10 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 
 	/* Prepare a TLB flush fence to be attached to PTs */
-	if (!params->unlocked) {
+	/* The check for need_tlb_fence should be dropped once we
+	 * sort out the issues with KIQ/MES TLB invalidation timeouts.
+	 */
+	if (!params->unlocked && vm->need_tlb_fence) {
 		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
 
 		/* Makes sure no PD/PT is freed before the flush */
@@ -2602,6 +2605,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
 
 	vm->is_compute_context = false;
+	vm->need_tlb_fence = amdgpu_userq_enabled(&adev->ddev);
 
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_GFX);
@@ -2739,6 +2743,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	dma_fence_put(vm->last_update);
 	vm->last_update = dma_fence_get_stub();
 	vm->is_compute_context = true;
+	vm->need_tlb_fence = true;
 
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index de53176a398d..d3edc92c7a12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -440,6 +440,8 @@ struct amdgpu_vm {
 	struct ttm_lru_bulk_move lru_bulk_move;
 	/* Flag to indicate if VM is used for compute */
 	bool			is_compute_context;
+	/* Flag to indicate if VM needs a TLB fence (KFD or KGD) */
+	bool			need_tlb_fence;
 
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f1ee3921d970..015d10658345 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -693,28 +693,35 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	} else {
 		switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 		case IP_VERSION(9, 0, 0):
-			mmhub_cid = mmhub_client_ids_vega10[cid][rw];
+			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_vega10) ?
+				mmhub_client_ids_vega10[cid][rw] : NULL;
 			break;
 		case IP_VERSION(9, 3, 0):
-			mmhub_cid = mmhub_client_ids_vega12[cid][rw];
+			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_vega12) ?
+				mmhub_client_ids_vega12[cid][rw] : NULL;
 			break;
 		case IP_VERSION(9, 4, 0):
-			mmhub_cid = mmhub_client_ids_vega20[cid][rw];
+			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_vega20) ?
+				mmhub_client_ids_vega20[cid][rw] : NULL;
 			break;
 		case IP_VERSION(9, 4, 1):
-			mmhub_cid = mmhub_client_ids_arcturus[cid][rw];
+			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_arcturus) ?
+				mmhub_client_ids_arcturus[cid][rw] : NULL;
 			break;
 		case IP_VERSION(9, 1, 0):
 		case IP_VERSION(9, 2, 0):
-			mmhub_cid = mmhub_client_ids_raven[cid][rw];
+			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_raven) ?
+				mmhub_client_ids_raven[cid][rw] : NULL;
 			break;
 		case IP_VERSION(1, 5, 0):
 		case IP_VERSION(2, 4, 0):
-			mmhub_cid = mmhub_client_ids_renoir[cid][rw];
+			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_renoir) ?
+				mmhub_client_ids_renoir[cid][rw] : NULL;
 			break;
 		case IP_VERSION(1, 8, 0):
 		case IP_VERSION(9, 4, 2):
-			mmhub_cid = mmhub_client_ids_aldebaran[cid][rw];
+			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_aldebaran) ?
+				mmhub_client_ids_aldebaran[cid][rw] : NULL;
 			break;
 		default:
 			mmhub_cid = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index a0cc8e218ca1..534cb4c544dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -154,14 +154,17 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(2, 0, 0):
 	case IP_VERSION(2, 0, 2):
-		mmhub_cid = mmhub_client_ids_navi1x[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_navi1x) ?
+			mmhub_client_ids_navi1x[cid][rw] : NULL;
 		break;
 	case IP_VERSION(2, 1, 0):
 	case IP_VERSION(2, 1, 1):
-		mmhub_cid = mmhub_client_ids_sienna_cichlid[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_sienna_cichlid) ?
+			mmhub_client_ids_sienna_cichlid[cid][rw] : NULL;
 		break;
 	case IP_VERSION(2, 1, 2):
-		mmhub_cid = mmhub_client_ids_beige_goby[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_beige_goby) ?
+			mmhub_client_ids_beige_goby[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 5eb8122e2746..ceb2f6b46de5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -94,7 +94,8 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	case IP_VERSION(2, 3, 0):
 	case IP_VERSION(2, 4, 0):
 	case IP_VERSION(2, 4, 1):
-		mmhub_cid = mmhub_client_ids_vangogh[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_vangogh) ?
+			mmhub_client_ids_vangogh[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 7d5242df58a5..ab966e69a342 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -110,7 +110,8 @@ mmhub_v3_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(3, 0, 0):
 	case IP_VERSION(3, 0, 1):
-		mmhub_cid = mmhub_client_ids_v3_0_0[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_0_0) ?
+			mmhub_client_ids_v3_0_0[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 910337dc28d1..14a742d3a99d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -117,7 +117,8 @@ mmhub_v3_0_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
 
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(3, 0, 1):
-		mmhub_cid = mmhub_client_ids_v3_0_1[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_0_1) ?
+			mmhub_client_ids_v3_0_1[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index f0f182f033b9..e1f07f2a1852 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -108,7 +108,8 @@ mmhub_v3_0_2_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
 
-	mmhub_cid = mmhub_client_ids_v3_0_2[cid][rw];
+	mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_0_2) ?
+		mmhub_client_ids_v3_0_2[cid][rw] : NULL;
 	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
index 951998454b25..88bfe321f83a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
@@ -102,7 +102,8 @@ mmhub_v4_1_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		status);
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(4, 1, 0):
-		mmhub_cid = mmhub_client_ids_v4_1_0[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v4_1_0) ?
+			mmhub_client_ids_v4_1_0[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e84ec4365ca6..5a54d3f4a3de 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13101,7 +13101,7 @@ static void parse_edid_displayid_vrr(struct drm_connector *connector,
 	u16 min_vfreq;
 	u16 max_vfreq;
 
-	if (edid == NULL || edid->extensions == 0)
+	if (!edid || !edid->extensions)
 		return;
 
 	/* Find DisplayID extension */
@@ -13111,7 +13111,7 @@ static void parse_edid_displayid_vrr(struct drm_connector *connector,
 			break;
 	}
 
-	if (edid_ext == NULL)
+	if (i == edid->extensions)
 		return;
 
 	while (j < EDID_LENGTH) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 15cf13ec5302..c450feae5fa5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -255,6 +255,10 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			BREAK_TO_DEBUGGER();
 			return NULL;
 		}
+		if (ctx->dce_version == DCN_VERSION_2_01) {
+			dcn201_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
+			return &clk_mgr->base;
+		}
 		if (ASICREV_IS_SIENNA_CICHLID_P(asic_id.hw_internal_rev)) {
 			dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			return &clk_mgr->base;
@@ -267,10 +271,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			return &clk_mgr->base;
 		}
-		if (ctx->dce_version == DCN_VERSION_2_01) {
-			dcn201_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
-			return &clk_mgr->base;
-		}
 		dcn20_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 		return &clk_mgr->base;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index d39a0f9c78c9..31eabdf198a1 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1789,7 +1789,10 @@ static bool dml1_validate(struct dc *dc, struct dc_state *context, enum dc_valid
 
 	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
 
+	DC_FP_START();
 	dcn32_override_min_req_memclk(dc, context);
+	DC_FP_END();
+
 	dcn32_override_min_req_dcfclk(dc, context);
 
 	BW_VAL_TRACE_END_WATERMARKS();
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 2d8d86efe2e7..c8a23ece8654 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3454,9 +3454,11 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 	if (adev->asic_type == CHIP_HAINAN) {
 		if ((adev->pdev->revision == 0x81) ||
 		    (adev->pdev->revision == 0xC3) ||
+		    (adev->pdev->device == 0x6660) ||
 		    (adev->pdev->device == 0x6664) ||
 		    (adev->pdev->device == 0x6665) ||
-		    (adev->pdev->device == 0x6667)) {
+		    (adev->pdev->device == 0x6667) ||
+		    (adev->pdev->device == 0x666F)) {
 			max_sclk = 75000;
 		}
 		if ((adev->pdev->revision == 0xC3) ||
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 60166919c5b5..ace9d8bcdd19 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -838,7 +838,7 @@ static int dw_hdmi_qp_config_audio_infoframe(struct dw_hdmi_qp *hdmi,
 
 	regmap_bulk_write(hdmi->regm, PKT_AUDI_CONTENTS0, &header_bytes, 1);
 	regmap_bulk_write(hdmi->regm, PKT_AUDI_CONTENTS1, &buffer[3], 1);
-	regmap_bulk_write(hdmi->regm, PKT_AUDI_CONTENTS2, &buffer[4], 1);
+	regmap_bulk_write(hdmi->regm, PKT_AUDI_CONTENTS2, &buffer[7], 1);
 
 	/* Enable ACR, AUDI, AMD */
 	dw_hdmi_qp_mod(hdmi,
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index be5e617ceb9f..6ee9b3df8735 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -233,6 +233,7 @@ static void drm_events_release(struct drm_file *file_priv)
 void drm_file_free(struct drm_file *file)
 {
 	struct drm_device *dev;
+	int idx;
 
 	if (!file)
 		return;
@@ -249,9 +250,11 @@ void drm_file_free(struct drm_file *file)
 
 	drm_events_release(file);
 
-	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
+	if (drm_core_check_feature(dev, DRIVER_MODESET) &&
+	    drm_dev_enter(dev, &idx)) {
 		drm_fb_release(file);
 		drm_property_destroy_user_blobs(dev, file);
+		drm_dev_exit(idx);
 	}
 
 	if (drm_core_check_feature(dev, DRIVER_SYNCOBJ))
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index d12db9b0bab8..802bc4608abf 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -577,10 +577,13 @@ void drm_mode_config_cleanup(struct drm_device *dev)
 	 */
 	WARN_ON(!list_empty(&dev->mode_config.fb_list));
 	list_for_each_entry_safe(fb, fbt, &dev->mode_config.fb_list, head) {
-		struct drm_printer p = drm_dbg_printer(dev, DRM_UT_KMS, "[leaked fb]");
+		if (list_empty(&fb->filp_head) || drm_framebuffer_read_refcount(fb) > 1) {
+			struct drm_printer p = drm_dbg_printer(dev, DRM_UT_KMS, "[leaked fb]");
 
-		drm_printf(&p, "framebuffer[%u]:\n", fb->base.id);
-		drm_framebuffer_print_info(&p, 1, fb);
+			drm_printf(&p, "framebuffer[%u]:\n", fb->base.id);
+			drm_framebuffer_print_info(&p, 1, fb);
+		}
+		list_del_init(&fb->filp_head);
 		drm_framebuffer_free(&fb->base.refcount);
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_power_well.c b/drivers/gpu/drm/i915/display/intel_display_power_well.c
index f4f7e73acc87..dfdd417eb6b5 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power_well.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power_well.c
@@ -798,7 +798,7 @@ void gen9_set_dc_state(struct intel_display *display, u32 state)
 			power_domains->dc_state, val & mask);
 
 	enable_dc6 = state & DC_STATE_EN_UPTO_DC6;
-	dc6_was_enabled = val & DC_STATE_EN_UPTO_DC6;
+	dc6_was_enabled = power_domains->dc_state & DC_STATE_EN_UPTO_DC6;
 	if (!dc6_was_enabled && enable_dc6)
 		intel_dmc_update_dc6_allowed_count(display, true);
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 6e26751e8d0e..1a7188970f24 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1160,6 +1160,7 @@ struct intel_crtc_state {
 	u32 dc3co_exitline;
 	u16 su_y_granularity;
 	u8 active_non_psr_pipes;
+	u8 entry_setup_frames;
 	const char *no_psr_reason;
 
 	/*
diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index 6ebbd97e6351..12c2f8adc5d7 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -1591,8 +1591,7 @@ static bool intel_dmc_get_dc6_allowed_count(struct intel_display *display, u32 *
 		return false;
 
 	mutex_lock(&power_domains->lock);
-	dc6_enabled = intel_de_read(display, DC_STATE_EN) &
-		      DC_STATE_EN_UPTO_DC6;
+	dc6_enabled = power_domains->dc_state & DC_STATE_EN_UPTO_DC6;
 	if (dc6_enabled)
 		intel_dmc_update_dc6_allowed_count(display, false);
 
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index ae23e3056851..5e90985a53d9 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1711,7 +1711,7 @@ static bool _psr_compute_config(struct intel_dp *intel_dp,
 	entry_setup_frames = intel_psr_entry_setup_frames(intel_dp, adjusted_mode);
 
 	if (entry_setup_frames >= 0) {
-		intel_dp->psr.entry_setup_frames = entry_setup_frames;
+		crtc_state->entry_setup_frames = entry_setup_frames;
 	} else {
 		crtc_state->no_psr_reason = "PSR setup timing not met";
 		drm_dbg_kms(display->drm,
@@ -1792,7 +1792,7 @@ static bool intel_psr_needs_wa_18037818876(struct intel_dp *intel_dp,
 {
 	struct intel_display *display = to_intel_display(intel_dp);
 
-	return (DISPLAY_VER(display) == 20 && intel_dp->psr.entry_setup_frames > 0 &&
+	return (DISPLAY_VER(display) == 20 && crtc_state->entry_setup_frames > 0 &&
 		!crtc_state->has_sel_update);
 }
 
@@ -2167,6 +2167,7 @@ static void intel_psr_enable_locked(struct intel_dp *intel_dp,
 	intel_dp->psr.pkg_c_latency_used = crtc_state->pkg_c_latency_used;
 	intel_dp->psr.io_wake_lines = crtc_state->alpm_state.io_wake_lines;
 	intel_dp->psr.fast_wake_lines = crtc_state->alpm_state.fast_wake_lines;
+	intel_dp->psr.entry_setup_frames = crtc_state->entry_setup_frames;
 
 	if (!psr_interrupt_error_check(intel_dp))
 		return;
@@ -2597,6 +2598,12 @@ void intel_psr2_program_trans_man_trk_ctl(struct intel_dsb *dsb,
 
 	intel_de_write_dsb(display, dsb, PIPE_SRCSZ_ERLY_TPT(crtc->pipe),
 			   crtc_state->pipe_srcsz_early_tpt);
+
+	if (!crtc_state->dsc.compression_enable)
+		return;
+
+	intel_dsc_su_et_parameters_configure(dsb, encoder, crtc_state,
+					     drm_rect_height(&crtc_state->psr2_su_area));
 }
 
 static void psr2_man_trk_ctl_calc(struct intel_crtc_state *crtc_state,
@@ -3017,6 +3024,10 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	}
 
 skip_sel_fetch_set_loop:
+	if (full_update)
+		clip_area_update(&crtc_state->psr2_su_area, &crtc_state->pipe_src,
+				 &crtc_state->pipe_src);
+
 	psr2_man_trk_ctl_calc(crtc_state, full_update);
 	crtc_state->pipe_srcsz_early_tpt =
 		psr2_pipe_srcsz_early_tpt_calc(crtc_state, full_update);
@@ -3076,6 +3087,8 @@ void intel_psr_pre_plane_update(struct intel_atomic_state *state,
 			 * - Display WA #1136: skl, bxt
 			 */
 			if (intel_crtc_needs_modeset(new_crtc_state) ||
+			    new_crtc_state->update_m_n ||
+			    new_crtc_state->update_lrr ||
 			    !new_crtc_state->has_psr ||
 			    !new_crtc_state->active_planes ||
 			    new_crtc_state->has_sel_update != psr->sel_update_enabled ||
diff --git a/drivers/gpu/drm/i915/display/intel_vdsc.c b/drivers/gpu/drm/i915/display/intel_vdsc.c
index 0e727fc5e80c..b08e677fa2b3 100644
--- a/drivers/gpu/drm/i915/display/intel_vdsc.c
+++ b/drivers/gpu/drm/i915/display/intel_vdsc.c
@@ -767,6 +767,29 @@ void intel_dsc_dp_pps_write(struct intel_encoder *encoder,
 				  sizeof(dp_dsc_pps_sdp));
 }
 
+void intel_dsc_su_et_parameters_configure(struct intel_dsb *dsb, struct intel_encoder *encoder,
+					  const struct intel_crtc_state *crtc_state, int su_lines)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
+	const struct drm_dsc_config *vdsc_cfg = &crtc_state->dsc.config;
+	enum pipe pipe = crtc->pipe;
+	int vdsc_instances_per_pipe = intel_dsc_get_vdsc_per_pipe(crtc_state);
+	int slice_row_per_frame = su_lines / vdsc_cfg->slice_height;
+	u32 val;
+
+	drm_WARN_ON_ONCE(display->drm, su_lines % vdsc_cfg->slice_height);
+	drm_WARN_ON_ONCE(display->drm, vdsc_instances_per_pipe > 2);
+
+	val = DSC_SUPS0_SU_SLICE_ROW_PER_FRAME(slice_row_per_frame);
+	val |= DSC_SUPS0_SU_PIC_HEIGHT(su_lines);
+
+	intel_de_write_dsb(display, dsb, LNL_DSC0_SU_PARAMETER_SET_0(pipe), val);
+
+	if (vdsc_instances_per_pipe == 2)
+		intel_de_write_dsb(display, dsb, LNL_DSC1_SU_PARAMETER_SET_0(pipe), val);
+}
+
 static i915_reg_t dss_ctl1_reg(struct intel_crtc *crtc, enum transcoder cpu_transcoder)
 {
 	return is_pipe_dsc(crtc, cpu_transcoder) ?
diff --git a/drivers/gpu/drm/i915/display/intel_vdsc.h b/drivers/gpu/drm/i915/display/intel_vdsc.h
index 99f64ac54b27..99bb9042592a 100644
--- a/drivers/gpu/drm/i915/display/intel_vdsc.h
+++ b/drivers/gpu/drm/i915/display/intel_vdsc.h
@@ -13,6 +13,7 @@ struct drm_printer;
 enum transcoder;
 struct intel_crtc;
 struct intel_crtc_state;
+struct intel_dsb;
 struct intel_encoder;
 
 bool intel_dsc_source_support(const struct intel_crtc_state *crtc_state);
@@ -31,6 +32,8 @@ void intel_dsc_dsi_pps_write(struct intel_encoder *encoder,
 			     const struct intel_crtc_state *crtc_state);
 void intel_dsc_dp_pps_write(struct intel_encoder *encoder,
 			    const struct intel_crtc_state *crtc_state);
+void intel_dsc_su_et_parameters_configure(struct intel_dsb *dsb, struct intel_encoder *encoder,
+					  const struct intel_crtc_state *crtc_state, int su_lines);
 void intel_vdsc_state_dump(struct drm_printer *p, int indent,
 			   const struct intel_crtc_state *crtc_state);
 int intel_vdsc_min_cdclk(const struct intel_crtc_state *crtc_state);
diff --git a/drivers/gpu/drm/i915/display/intel_vdsc_regs.h b/drivers/gpu/drm/i915/display/intel_vdsc_regs.h
index 2d478a84b07c..2b2e3c1b8138 100644
--- a/drivers/gpu/drm/i915/display/intel_vdsc_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_vdsc_regs.h
@@ -196,6 +196,18 @@
 #define   DSC_PPS18_NSL_BPG_OFFSET(offset)	REG_FIELD_PREP(DSC_PPS18_NSL_BPG_OFFSET_MASK, offset)
 #define   DSC_PPS18_SL_OFFSET_ADJ(offset)	REG_FIELD_PREP(DSC_PPS18_SL_OFFSET_ADJ_MASK, offset)
 
+#define _LNL_DSC0_SU_PARAMETER_SET_0_PA		0x78064
+#define _LNL_DSC1_SU_PARAMETER_SET_0_PA		0x78164
+#define _LNL_DSC0_SU_PARAMETER_SET_0_PB		0x78264
+#define _LNL_DSC1_SU_PARAMETER_SET_0_PB		0x78364
+#define LNL_DSC0_SU_PARAMETER_SET_0(pipe)	_MMIO_PIPE((pipe), _LNL_DSC0_SU_PARAMETER_SET_0_PA, _LNL_DSC0_SU_PARAMETER_SET_0_PB)
+#define LNL_DSC1_SU_PARAMETER_SET_0(pipe)	_MMIO_PIPE((pipe), _LNL_DSC1_SU_PARAMETER_SET_0_PA, _LNL_DSC1_SU_PARAMETER_SET_0_PB)
+
+#define   DSC_SUPS0_SU_SLICE_ROW_PER_FRAME_MASK		REG_GENMASK(31, 20)
+#define   DSC_SUPS0_SU_SLICE_ROW_PER_FRAME(rows)	REG_FIELD_PREP(DSC_SUPS0_SU_SLICE_ROW_PER_FRAME_MASK, (rows))
+#define   DSC_SUPS0_SU_PIC_HEIGHT_MASK			REG_GENMASK(15, 0)
+#define   DSC_SUPS0_SU_PIC_HEIGHT(h)			REG_FIELD_PREP(DSC_SUPS0_SU_PIC_HEIGHT_MASK, (h))
+
 /* Icelake Rate Control Buffer Threshold Registers */
 #define DSCA_RC_BUF_THRESH_0			_MMIO(0x6B230)
 #define DSCA_RC_BUF_THRESH_0_UDW		_MMIO(0x6B230 + 4)
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index b721bbd23356..ce8cdd517daa 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -1969,7 +1969,8 @@ void intel_engines_reset_default_submission(struct intel_gt *gt)
 		if (engine->sanitize)
 			engine->sanitize(engine);
 
-		engine->set_default_submission(engine);
+		if (engine->set_default_submission)
+			engine->set_default_submission(engine);
 	}
 }
 
diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 78d6b8a0a450..b2275cb7360e 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -224,29 +224,12 @@ static irqreturn_t pvr_device_irq_thread_handler(int irq, void *data)
 	}
 
 	if (pvr_dev->has_safety_events) {
-		int err;
-
-		/*
-		 * Ensure the GPU is powered on since some safety events (such
-		 * as ECC faults) can happen outside of job submissions, which
-		 * are otherwise the only time a power reference is held.
-		 */
-		err = pvr_power_get(pvr_dev);
-		if (err) {
-			drm_err_ratelimited(drm_dev,
-					    "%s: could not take power reference (%d)\n",
-					    __func__, err);
-			return ret;
-		}
-
 		while (pvr_device_safety_irq_pending(pvr_dev)) {
 			pvr_device_safety_irq_clear(pvr_dev);
 			pvr_device_handle_safety_events(pvr_dev);
 
 			ret = IRQ_HANDLED;
 		}
-
-		pvr_power_put(pvr_dev);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index b9f801c63260..50ce3668f051 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -90,7 +90,7 @@ pvr_power_request_pwr_off(struct pvr_device *pvr_dev)
 }
 
 static int
-pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset)
+pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset, bool rpm_suspend)
 {
 	if (!hard_reset) {
 		int err;
@@ -106,6 +106,11 @@ pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset)
 			return err;
 	}
 
+	if (rpm_suspend) {
+		/* Wait for late processing of GPU or firmware IRQs in other cores */
+		synchronize_irq(pvr_dev->irq);
+	}
+
 	return pvr_fw_stop(pvr_dev);
 }
 
@@ -361,7 +366,7 @@ pvr_power_device_suspend(struct device *dev)
 		return -EIO;
 
 	if (pvr_dev->fw_dev.booted) {
-		err = pvr_power_fw_disable(pvr_dev, false);
+		err = pvr_power_fw_disable(pvr_dev, false, true);
 		if (err)
 			goto err_drm_dev_exit;
 	}
@@ -510,7 +515,16 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool hard_reset)
 	}
 
 	/* Disable IRQs for the duration of the reset. */
-	disable_irq(pvr_dev->irq);
+	if (hard_reset) {
+		disable_irq(pvr_dev->irq);
+	} else {
+		/*
+		 * Soft reset is triggered as a response to a FW command to the Host and is
+		 * processed from the threaded IRQ handler. This code cannot (nor needs to)
+		 * wait for any IRQ processing to complete.
+		 */
+		disable_irq_nosync(pvr_dev->irq);
+	}
 
 	do {
 		if (hard_reset) {
@@ -518,7 +532,7 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool hard_reset)
 			queues_disabled = true;
 		}
 
-		err = pvr_power_fw_disable(pvr_dev, hard_reset);
+		err = pvr_power_fw_disable(pvr_dev, hard_reset, false);
 		if (!err) {
 			if (hard_reset) {
 				pvr_dev->fw_dev.booted = false;
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index f12227145ef0..0342d095d44c 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -2915,9 +2915,11 @@ static void si_apply_state_adjust_rules(struct radeon_device *rdev,
 	if (rdev->family == CHIP_HAINAN) {
 		if ((rdev->pdev->revision == 0x81) ||
 		    (rdev->pdev->revision == 0xC3) ||
+		    (rdev->pdev->device == 0x6660) ||
 		    (rdev->pdev->device == 0x6664) ||
 		    (rdev->pdev->device == 0x6665) ||
-		    (rdev->pdev->device == 0x6667)) {
+		    (rdev->pdev->device == 0x6667) ||
+		    (rdev->pdev->device == 0x666F)) {
 			max_sclk = 75000;
 		}
 		if ((rdev->pdev->revision == 0xC3) ||
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index bc51b5d55e38..35c7277521a9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -771,7 +771,8 @@ static struct drm_framebuffer *vmw_kms_fb_create(struct drm_device *dev,
 		ret = vmw_bo_dirty_add(bo);
 		if (!ret && surface && surface->res.func->dirty_alloc) {
 			surface->res.coherent = true;
-			ret = surface->res.func->dirty_alloc(&surface->res);
+			if (surface->res.dirty == NULL)
+				ret = surface->res.func->dirty_alloc(&surface->res);
 		}
 		ttm_bo_unreserve(&bo->tbo);
 	}
diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index 9e6b4e983542..f3d76c639aac 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -274,6 +274,8 @@ static void dev_fini_ggtt(void *arg)
 {
 	struct xe_ggtt *ggtt = arg;
 
+	scoped_guard(mutex, &ggtt->lock)
+		ggtt->flags &= ~XE_GGTT_FLAGS_ONLINE;
 	drain_workqueue(ggtt->wq);
 }
 
@@ -332,6 +334,7 @@ int xe_ggtt_init_early(struct xe_ggtt *ggtt)
 	if (err)
 		return err;
 
+	ggtt->flags |= XE_GGTT_FLAGS_ONLINE;
 	err = devm_add_action_or_reset(xe->drm.dev, dev_fini_ggtt, ggtt);
 	if (err)
 		return err;
@@ -365,13 +368,10 @@ static void xe_ggtt_initial_clear(struct xe_ggtt *ggtt)
 static void ggtt_node_remove(struct xe_ggtt_node *node)
 {
 	struct xe_ggtt *ggtt = node->ggtt;
-	struct xe_device *xe = tile_to_xe(ggtt->tile);
 	bool bound;
-	int idx;
-
-	bound = drm_dev_enter(&xe->drm, &idx);
 
 	mutex_lock(&ggtt->lock);
+	bound = ggtt->flags & XE_GGTT_FLAGS_ONLINE;
 	if (bound)
 		xe_ggtt_clear(ggtt, node->base.start, node->base.size);
 	drm_mm_remove_node(&node->base);
@@ -384,8 +384,6 @@ static void ggtt_node_remove(struct xe_ggtt_node *node)
 	if (node->invalidate_on_remove)
 		xe_ggtt_invalidate(ggtt);
 
-	drm_dev_exit(idx);
-
 free_node:
 	xe_ggtt_node_fini(node);
 }
diff --git a/drivers/gpu/drm/xe/xe_ggtt_types.h b/drivers/gpu/drm/xe/xe_ggtt_types.h
index dacd796f8184..53ba753417eb 100644
--- a/drivers/gpu/drm/xe/xe_ggtt_types.h
+++ b/drivers/gpu/drm/xe/xe_ggtt_types.h
@@ -25,11 +25,14 @@ struct xe_ggtt {
 	/** @size: Total size of this GGTT */
 	u64 size;
 
-#define XE_GGTT_FLAGS_64K BIT(0)
+#define XE_GGTT_FLAGS_64K       BIT(0)
+#define XE_GGTT_FLAGS_ONLINE	BIT(1)
 	/**
 	 * @flags: Flags for this GGTT
 	 * Acceptable flags:
 	 * - %XE_GGTT_FLAGS_64K - if PTE size is 64K. Otherwise, regular is 4K.
+	 * - %XE_GGTT_FLAGS_ONLINE - is GGTT online, protected by ggtt->lock
+	 *   after init
 	 */
 	unsigned int flags;
 	/** @scratch: Internal object allocation used as a scratch page */
diff --git a/drivers/gpu/drm/xe/xe_gt_ccs_mode.c b/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
index 50fffc9ebf62..852e73173070 100644
--- a/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
+++ b/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
@@ -12,6 +12,7 @@
 #include "xe_gt_printk.h"
 #include "xe_gt_sysfs.h"
 #include "xe_mmio.h"
+#include "xe_pm.h"
 #include "xe_sriov.h"
 
 static void __xe_gt_apply_ccs_mode(struct xe_gt *gt, u32 num_engines)
@@ -150,6 +151,7 @@ ccs_mode_store(struct device *kdev, struct device_attribute *attr,
 		xe_gt_info(gt, "Setting compute mode to %d\n", num_engines);
 		gt->ccs_mode = num_engines;
 		xe_gt_record_user_engines(gt);
+		guard(xe_pm_runtime)(xe);
 		xe_gt_reset(gt);
 	}
 
diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index edb939f26268..2eaa009ba2d8 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -1121,14 +1121,14 @@ static int guc_wait_ucode(struct xe_guc *guc)
 	struct xe_guc_pc *guc_pc = &gt->uc.guc.pc;
 	u32 before_freq, act_freq, cur_freq;
 	u32 status = 0, tries = 0;
+	int load_result, ret;
 	ktime_t before;
 	u64 delta_ms;
-	int ret;
 
 	before_freq = xe_guc_pc_get_act_freq(guc_pc);
 	before = ktime_get();
 
-	ret = poll_timeout_us(ret = guc_load_done(gt, &status, &tries), ret,
+	ret = poll_timeout_us(load_result = guc_load_done(gt, &status, &tries), load_result,
 			      10 * USEC_PER_MSEC,
 			      GUC_LOAD_TIMEOUT_SEC * USEC_PER_SEC, false);
 
@@ -1136,7 +1136,7 @@ static int guc_wait_ucode(struct xe_guc *guc)
 	act_freq = xe_guc_pc_get_act_freq(guc_pc);
 	cur_freq = xe_guc_pc_get_cur_freq_fw(guc_pc);
 
-	if (ret) {
+	if (ret || load_result <= 0) {
 		xe_gt_err(gt, "load failed: status = 0x%08X, time = %lldms, freq = %dMHz (req %dMHz)\n",
 			  status, delta_ms, xe_guc_pc_get_act_freq(guc_pc),
 			  xe_guc_pc_get_cur_freq_fw(guc_pc));
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index a5019d1e741b..791d42e455a0 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -265,6 +265,7 @@ static void guc_action_disable_ct(void *arg)
 {
 	struct xe_guc_ct *ct = arg;
 
+	xe_guc_ct_stop(ct);
 	guc_ct_change_state(ct, XE_GUC_CT_STATE_DISABLED);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index ced13f17fb72..ea9e3d506392 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -2410,8 +2410,7 @@ void xe_guc_submit_pause_abort(struct xe_guc *guc)
 			continue;
 
 		xe_sched_submission_start(sched);
-		if (exec_queue_killed_or_banned_or_wedged(q))
-			xe_guc_exec_queue_trigger_cleanup(q);
+		guc_exec_queue_kill(q);
 	}
 	mutex_unlock(&guc->submission_state.lock);
 }
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index f8bb28ab8124..164e18f4959e 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -543,8 +543,7 @@ static ssize_t xe_oa_read(struct file *file, char __user *buf,
 	size_t offset = 0;
 	int ret;
 
-	/* Can't read from disabled streams */
-	if (!stream->enabled || !stream->sample)
+	if (!stream->sample)
 		return -EINVAL;
 
 	if (!(file->f_flags & O_NONBLOCK)) {
@@ -1460,6 +1459,10 @@ static void xe_oa_stream_disable(struct xe_oa_stream *stream)
 
 	if (stream->sample)
 		hrtimer_cancel(&stream->poll_check_timer);
+
+	/* Update stream->oa_buffer.tail to allow any final reports to be read */
+	if (xe_oa_buffer_check_unlocked(stream))
+		wake_up(&stream->poll_wq);
 }
 
 static int xe_oa_enable_preempt_timeslice(struct xe_oa_stream *stream)
diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index fe7e1b45f5c0..9dc801f65712 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -390,7 +390,7 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 						    madvise_range.num_vmas,
 						    args->atomic.val)) {
 				err = -EINVAL;
-				goto unlock_vm;
+				goto free_vmas;
 			}
 		}
 
@@ -426,6 +426,7 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 err_fini:
 	if (madvise_range.has_bo_vmas)
 		drm_exec_fini(&exec);
+free_vmas:
 	kfree(madvise_range.vmas);
 	madvise_range.vmas = NULL;
 unlock_vm:
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 9a06f9b0e4ef..cf465a5fe43a 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -447,6 +447,8 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 					      (u64)(long)ctx,
 					      true); /* prevent infinite recursions */
 
+	if (ret > size)
+		ret = size;
 	if (ret > 0)
 		memcpy(buf, dma_data, ret);
 
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index d3e8a66443ad..45cf086ad430 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1334,7 +1334,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	return 0;
 
 errout:
-	vfree(region);
+	mshv_region_put(region);
 	return ret;
 }
 
diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 48fde4f1a156..b6b32286d967 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -232,7 +232,7 @@ static int max6639_read_fan(struct device *dev, u32 attr, int channel,
 static int max6639_set_ppr(struct max6639_data *data, int channel, u8 ppr)
 {
 	/* Decrement the PPR value and shift left by 6 to match the register format */
-	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr-- << 6);
+	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), --ppr << 6);
 }
 
 static int max6639_write_fan(struct device *dev, u32 attr, int channel,
@@ -524,8 +524,8 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
 
 {
 	struct device *dev = &client->dev;
-	u32 i;
-	int err, val;
+	u32 i, val;
+	int err;
 
 	err = of_property_read_u32(child, "reg", &i);
 	if (err) {
@@ -540,8 +540,8 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
 
 	err = of_property_read_u32(child, "pulses-per-revolution", &val);
 	if (!err) {
-		if (val < 1 || val > 5) {
-			dev_err(dev, "invalid pulses-per-revolution %d of %pOFn\n", val, child);
+		if (val < 1 || val > 4) {
+			dev_err(dev, "invalid pulses-per-revolution %u of %pOFn\n", val, child);
 			return -EINVAL;
 		}
 		data->ppr[i] = val;
diff --git a/drivers/hwmon/pmbus/ina233.c b/drivers/hwmon/pmbus/ina233.c
index dde1e1678394..2d8b5a5347ed 100644
--- a/drivers/hwmon/pmbus/ina233.c
+++ b/drivers/hwmon/pmbus/ina233.c
@@ -67,6 +67,8 @@ static int ina233_read_word_data(struct i2c_client *client, int page,
 	switch (reg) {
 	case PMBUS_VIRT_READ_VMON:
 		ret = pmbus_read_word_data(client, 0, 0xff, MFR_READ_VSHUNT);
+		if (ret < 0)
+			return ret;
 
 		/* Adjust returned value to match VIN coefficients */
 		/* VIN: 1.25 mV VSHUNT: 2.5 uV LSB */
diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
index 97b61836f53a..e7dac26b5be6 100644
--- a/drivers/hwmon/pmbus/isl68137.c
+++ b/drivers/hwmon/pmbus/isl68137.c
@@ -98,8 +98,11 @@ static ssize_t isl68137_avs_enable_show_page(struct i2c_client *client,
 {
 	int val = pmbus_read_byte_data(client, page, PMBUS_OPERATION);
 
-	return sprintf(buf, "%d\n",
-		       (val & ISL68137_VOUT_AVS) == ISL68137_VOUT_AVS ? 1 : 0);
+	if (val < 0)
+		return val;
+
+	return sysfs_emit(buf, "%d\n",
+			   (val & ISL68137_VOUT_AVS) == ISL68137_VOUT_AVS);
 }
 
 static ssize_t isl68137_avs_enable_store_page(struct i2c_client *client,
diff --git a/drivers/hwmon/pmbus/mp2869.c b/drivers/hwmon/pmbus/mp2869.c
index cc69a1e91dfe..4647892e5112 100644
--- a/drivers/hwmon/pmbus/mp2869.c
+++ b/drivers/hwmon/pmbus/mp2869.c
@@ -165,7 +165,7 @@ static int mp2869_read_byte_data(struct i2c_client *client, int page, int reg)
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
 	struct mp2869_data *data = to_mp2869_data(info);
-	int ret;
+	int ret, mfr;
 
 	switch (reg) {
 	case PMBUS_VOUT_MODE:
@@ -188,11 +188,14 @@ static int mp2869_read_byte_data(struct i2c_client *client, int page, int reg)
 		if (ret < 0)
 			return ret;
 
+		mfr = pmbus_read_byte_data(client, page,
+					   PMBUS_STATUS_MFR_SPECIFIC);
+		if (mfr < 0)
+			return mfr;
+
 		ret = (ret & ~GENMASK(2, 2)) |
 			FIELD_PREP(GENMASK(2, 2),
-				   FIELD_GET(GENMASK(1, 1),
-					     pmbus_read_byte_data(client, page,
-								  PMBUS_STATUS_MFR_SPECIFIC)));
+				   FIELD_GET(GENMASK(1, 1), mfr));
 		break;
 	case PMBUS_STATUS_TEMPERATURE:
 		/*
@@ -207,15 +210,16 @@ static int mp2869_read_byte_data(struct i2c_client *client, int page, int reg)
 		if (ret < 0)
 			return ret;
 
+		mfr = pmbus_read_byte_data(client, page,
+					   PMBUS_STATUS_MFR_SPECIFIC);
+		if (mfr < 0)
+			return mfr;
+
 		ret = (ret & ~GENMASK(7, 6)) |
 			FIELD_PREP(GENMASK(6, 6),
-				   FIELD_GET(GENMASK(1, 1),
-					     pmbus_read_byte_data(client, page,
-								  PMBUS_STATUS_MFR_SPECIFIC))) |
+				   FIELD_GET(GENMASK(1, 1), mfr)) |
 			 FIELD_PREP(GENMASK(7, 7),
-				    FIELD_GET(GENMASK(1, 1),
-					      pmbus_read_byte_data(client, page,
-								   PMBUS_STATUS_MFR_SPECIFIC)));
+				    FIELD_GET(GENMASK(1, 1), mfr));
 		break;
 	default:
 		ret = -ENODATA;
@@ -230,7 +234,7 @@ static int mp2869_read_word_data(struct i2c_client *client, int page, int phase,
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
 	struct mp2869_data *data = to_mp2869_data(info);
-	int ret;
+	int ret, mfr;
 
 	switch (reg) {
 	case PMBUS_STATUS_WORD:
@@ -246,11 +250,14 @@ static int mp2869_read_word_data(struct i2c_client *client, int page, int phase,
 		if (ret < 0)
 			return ret;
 
+		mfr = pmbus_read_byte_data(client, page,
+					   PMBUS_STATUS_MFR_SPECIFIC);
+		if (mfr < 0)
+			return mfr;
+
 		ret = (ret & ~GENMASK(2, 2)) |
 			 FIELD_PREP(GENMASK(2, 2),
-				    FIELD_GET(GENMASK(1, 1),
-					      pmbus_read_byte_data(client, page,
-								   PMBUS_STATUS_MFR_SPECIFIC)));
+				    FIELD_GET(GENMASK(1, 1), mfr));
 		break;
 	case PMBUS_READ_VIN:
 		/*
diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index c31982d85196..d0bc47b12cb0 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -313,6 +313,8 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
 	case PMBUS_STATUS_WORD:
 		/* MP2973 & MP2971 return PGOOD instead of PB_STATUS_POWER_GOOD_N. */
 		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
 		ret ^= PB_STATUS_POWER_GOOD_N;
 		break;
 	case PMBUS_OT_FAULT_LIMIT:
diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index e7720ea4045e..7b62ba115eb9 100644
--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -298,6 +298,9 @@ cp2615_i2c_probe(struct usb_interface *usbif, const struct usb_device_id *id)
 	if (!adap)
 		return -ENOMEM;
 
+	if (!usbdev->serial)
+		return -EINVAL;
+
 	strscpy(adap->name, usbdev->serial, sizeof(adap->name));
 	adap->owner = THIS_MODULE;
 	adap->dev.parent = &usbif->dev;
diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index ae016a9431da..6a9245423d2b 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -728,6 +728,7 @@ static int fsi_i2c_probe(struct device *dev)
 		rc = i2c_add_adapter(&port->adapter);
 		if (rc < 0) {
 			dev_err(dev, "Failed to register adapter: %d\n", rc);
+			of_node_put(np);
 			kfree(port);
 			continue;
 		}
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 09af3b3625f1..f55840b2eb9a 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -268,6 +268,7 @@ struct pxa_i2c {
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	*pinctrl_default;
 	struct pinctrl_state	*pinctrl_recovery;
+	bool			reset_before_xfer;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -1144,6 +1145,11 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap,
 {
 	struct pxa_i2c *i2c = adap->algo_data;
 
+	if (i2c->reset_before_xfer) {
+		i2c_pxa_reset(i2c);
+		i2c->reset_before_xfer = false;
+	}
+
 	return i2c_pxa_internal_xfer(i2c, msgs, num, i2c_pxa_do_xfer);
 }
 
@@ -1521,7 +1527,16 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		}
 	}
 
-	i2c_pxa_reset(i2c);
+	/*
+	 * Skip reset on Armada 3700 when recovery is used to avoid
+	 * controller hang due to the pinctrl state changes done by
+	 * the generic recovery initialization code. The reset will
+	 * be performed later, prior to the first transfer.
+	 */
+	if (i2c_type == REGS_A3700 && i2c->adap.bus_recovery_info)
+		i2c->reset_before_xfer = true;
+	else
+		i2c_pxa_reset(i2c);
 
 	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret < 0)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e216b5a13d49..cdcce3333682 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2854,8 +2854,21 @@ static struct iommu_domain blocked_domain = {
 
 static struct protection_domain identity_domain;
 
+static int amd_iommu_identity_attach(struct iommu_domain *dom, struct device *dev,
+				     struct iommu_domain *old)
+{
+	/*
+	 * Don't allow attaching a device to the identity domain if SNP is
+	 * enabled.
+	 */
+	if (amd_iommu_snp_en)
+		return -EINVAL;
+
+	return amd_iommu_attach_device(dom, dev, old);
+}
+
 static const struct iommu_domain_ops identity_domain_ops = {
-	.attach_dev = amd_iommu_attach_device,
+	.attach_dev = amd_iommu_identity_attach,
 };
 
 void amd_iommu_init_identity_domain(void)
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ec975c73cfe6..6938800e9884 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1314,7 +1314,6 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 	if (fault & DMA_FSTS_ITE) {
 		head = readl(iommu->reg + DMAR_IQH_REG);
 		head = ((head >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
-		head |= 1;
 		tail = readl(iommu->reg + DMAR_IQT_REG);
 		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
 
@@ -1331,7 +1330,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 		do {
 			if (qi->desc_status[head] == QI_IN_USE)
 				qi->desc_status[head] = QI_ABORT;
-			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
+			head = (head - 1 + QI_LENGTH) % QI_LENGTH;
 		} while (head != tail);
 
 		/*
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 71de7947971f..b1389df36ef8 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -164,9 +164,12 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
 
-	ret = iopf_for_domain_replace(domain, old, dev);
-	if (ret)
-		goto out_remove_dev_pasid;
+	/* SVA with non-IOMMU/PRI IOPF handling is allowed. */
+	if (info->pri_supported) {
+		ret = iopf_for_domain_replace(domain, old, dev);
+		if (ret)
+			goto out_remove_dev_pasid;
+	}
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
@@ -181,7 +184,8 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 
 	return 0;
 out_unwind_iopf:
-	iopf_for_domain_replace(old, domain, dev);
+	if (info->pri_supported)
+		iopf_for_domain_replace(old, domain, dev);
 out_remove_dev_pasid:
 	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index e1e63c2be82b..fd735aaae9e3 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -182,13 +182,13 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (--domain->users == 0) {
 		list_del(&domain->next);
-		iommu_domain_free(domain);
-	}
+		if (list_empty(&iommu_mm->sva_domains)) {
+			list_del(&iommu_mm->mm_list_elm);
+			if (list_empty(&iommu_sva_mms))
+				iommu_sva_present = false;
+		}
 
-	if (list_empty(&iommu_mm->sva_domains)) {
-		list_del(&iommu_mm->mm_list_elm);
-		if (list_empty(&iommu_sva_mms))
-			iommu_sva_present = false;
+		iommu_domain_free(domain);
 	}
 
 	mutex_unlock(&iommu_sva_lock);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2ca990dfbb88..3a0c0e4b42ff 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1207,7 +1207,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 			if (addr == end)
 				goto map_end;
 
-			phys_addr = iommu_iova_to_phys(domain, addr);
+			/*
+			 * Return address by iommu_iova_to_phys for 0 is
+			 * ambiguous. Offset to address 1 if addr is 0.
+			 */
+			phys_addr = iommu_iova_to_phys(domain, addr ? addr : 1);
 			if (!phys_addr) {
 				map_size += pg_size;
 				continue;
diff --git a/drivers/irqchip/irq-riscv-rpmi-sysmsi.c b/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
index 5c74c561ce31..612f3972f7af 100644
--- a/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
+++ b/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
@@ -250,6 +250,7 @@ static int rpmi_sysmsi_probe(struct platform_device *pdev)
 		rc = riscv_acpi_get_gsi_info(fwnode, &priv->gsi_base, &id,
 					     &nr_irqs, NULL);
 		if (rc) {
+			mbox_free_channel(priv->chan);
 			dev_err(dev, "failed to find GSI mapping\n");
 			return rc;
 		}
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index b0f91cc9e40e..6e4084407662 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -68,6 +68,9 @@
 #define   GLI_9750_MISC_TX1_DLY_VALUE    0x5
 #define   SDHCI_GLI_9750_MISC_SSC_OFF    BIT(26)
 
+#define SDHCI_GLI_9750_GM_BURST_SIZE		  0x510
+#define   SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT  GENMASK(17, 16)
+
 #define SDHCI_GLI_9750_TUNING_CONTROL	          0x540
 #define   SDHCI_GLI_9750_TUNING_CONTROL_EN          BIT(4)
 #define   GLI_9750_TUNING_CONTROL_EN_ON             0x1
@@ -345,10 +348,16 @@ static void gli_set_9750(struct sdhci_host *host)
 	u32 misc_value;
 	u32 parameter_value;
 	u32 control_value;
+	u32 burst_value;
 	u16 ctrl2;
 
 	gl9750_wt_on(host);
 
+	/* clear R_OSRC_Lmt to avoid DMA write corruption */
+	burst_value = sdhci_readl(host, SDHCI_GLI_9750_GM_BURST_SIZE);
+	burst_value &= ~SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT;
+	sdhci_writel(host, burst_value, SDHCI_GLI_9750_GM_BURST_SIZE);
+
 	driving_value = sdhci_readl(host, SDHCI_GLI_9750_DRIVING);
 	pll_value = sdhci_readl(host, SDHCI_GLI_9750_PLL);
 	sw_ctrl_value = sdhci_readl(host, SDHCI_GLI_9750_SW_CTRL);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ac7e11f37af7..fec9329e1edb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4532,8 +4532,15 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * their platform code before calling sdhci_add_host(), and we
 	 * won't assume 8-bit width for hosts without that CAP.
 	 */
-	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
+	if (host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA) {
+		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
+		if (host->quirks2 & SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400)
+			host->caps1 &= ~SDHCI_SUPPORT_HS400;
+		mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+		mmc->caps &= ~(MMC_CAP_DDR | MMC_CAP_UHS);
+	} else {
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
+	}
 
 	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
 		mmc->caps &= ~MMC_CAP_CMD23;
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 835653bdd5ab..8f4d001377a1 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2350,14 +2350,12 @@ static int brcmnand_write(struct mtd_info *mtd, struct nand_chip *chip,
 	for (i = 0; i < ctrl->max_oob; i += 4)
 		oob_reg_write(ctrl, i, 0xffffffff);
 
-	if (mtd->oops_panic_write)
+	if (mtd->oops_panic_write) {
 		/* switch to interrupt polling and PIO mode */
 		disable_ctrl_irqs(ctrl);
-
-	if (use_dma(ctrl) && (has_edu(ctrl) || !oob) && flash_dma_buf_ok(buf)) {
+	} else if (use_dma(ctrl) && (has_edu(ctrl) || !oob) && flash_dma_buf_ok(buf)) {
 		if (ctrl->dma_trans(host, addr, (u32 *)buf, oob, mtd->writesize,
 				    CMD_PROGRAM_PAGE))
-
 			ret = -EIO;
 
 		goto out;
diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 99135ec23010..d53b35a8b3cb 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -3133,7 +3133,7 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 						  sizeof(*cdns_ctrl->cdma_desc),
 						  &cdns_ctrl->dma_cdma_desc,
 						  GFP_KERNEL);
-	if (!cdns_ctrl->dma_cdma_desc)
+	if (!cdns_ctrl->cdma_desc)
 		return -ENOMEM;
 
 	cdns_ctrl->buf_size = SZ_16K;
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index f2322de93ab4..19e3bbf42931 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4737,11 +4737,16 @@ static void nand_shutdown(struct mtd_info *mtd)
 static int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
 
 	if (!chip->ops.lock_area)
 		return -ENOTSUPP;
 
-	return chip->ops.lock_area(chip, ofs, len);
+	nand_get_device(chip);
+	ret = chip->ops.lock_area(chip, ofs, len);
+	nand_release_device(chip);
+
+	return ret;
 }
 
 /**
@@ -4753,11 +4758,16 @@ static int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 static int nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
 
 	if (!chip->ops.unlock_area)
 		return -ENOTSUPP;
 
-	return chip->ops.unlock_area(chip, ofs, len);
+	nand_get_device(chip);
+	ret = chip->ops.unlock_area(chip, ofs, len);
+	nand_release_device(chip);
+
+	return ret;
 }
 
 /* Set default functions */
diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index 7f012b7c3eae..50d4305729f4 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -862,6 +862,9 @@ static int pl35x_nfc_setup_interface(struct nand_chip *chip, int cs,
 			  PL35X_SMC_NAND_TAR_CYCLES(tmgs.t_ar) |
 			  PL35X_SMC_NAND_TRR_CYCLES(tmgs.t_rr);
 
+	writel(plnand->timings, nfc->conf_regs + PL35X_SMC_CYCLES);
+	pl35x_smc_update_regs(nfc);
+
 	return 0;
 }
 
diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
index 3b55b676ca6b..c06ba7a2a34b 100644
--- a/drivers/mtd/parsers/redboot.c
+++ b/drivers/mtd/parsers/redboot.c
@@ -270,9 +270,9 @@ static int parse_redboot_partitions(struct mtd_info *master,
 
 		strcpy(names, fl->img->name);
 #ifdef CONFIG_MTD_REDBOOT_PARTS_READONLY
-		if (!memcmp(names, "RedBoot", 8) ||
-		    !memcmp(names, "RedBoot config", 15) ||
-		    !memcmp(names, "FIS directory", 14)) {
+		if (!strcmp(names, "RedBoot") ||
+		    !strcmp(names, "RedBoot config") ||
+		    !strcmp(names, "FIS directory")) {
 			parts[i].mask_flags = MTD_WRITEABLE;
 		}
 #endif
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d3f8a78efd3b..1f2e312feec7 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2466,7 +2466,7 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
 
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
-		if (spi_nor_spimem_check_op(nor, &op))
+		if (!spi_mem_supports_op(nor->spimem, &op))
 			nor->flags |= SNOR_F_NO_READ_CR;
 	}
 }
diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
index 8adbec7c5084..8967b65f6d84 100644
--- a/drivers/net/bonding/bond_debugfs.c
+++ b/drivers/net/bonding/bond_debugfs.c
@@ -34,11 +34,17 @@ static int bond_debug_rlb_hash_show(struct seq_file *m, void *v)
 	for (; hash_index != RLB_NULL_INDEX;
 	     hash_index = client_info->used_next) {
 		client_info = &(bond_info->rx_hashtbl[hash_index]);
-		seq_printf(m, "%-15pI4 %-15pI4 %-17pM %s\n",
-			&client_info->ip_src,
-			&client_info->ip_dst,
-			&client_info->mac_dst,
-			client_info->slave->dev->name);
+		if (client_info->slave)
+			seq_printf(m, "%-15pI4 %-15pI4 %-17pM %s\n",
+				   &client_info->ip_src,
+				   &client_info->ip_dst,
+				   &client_info->mac_dst,
+				   client_info->slave->dev->name);
+		else
+			seq_printf(m, "%-15pI4 %-15pI4 %-17pM (none)\n",
+				   &client_info->ip_src,
+				   &client_info->ip_dst,
+				   &client_info->mac_dst);
 	}
 
 	spin_unlock_bh(&bond->mode_lock);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e8e261e0cb4e..106cfe732a15 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1497,9 +1497,11 @@ static int bond_header_create(struct sk_buff *skb, struct net_device *bond_dev,
 	return ret;
 }
 
-static int bond_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+static int bond_header_parse(const struct sk_buff *skb,
+			     const struct net_device *dev,
+			     unsigned char *haddr)
 {
-	struct bonding *bond = netdev_priv(skb->dev);
+	struct bonding *bond = netdev_priv(dev);
 	const struct header_ops *slave_ops;
 	struct slave *slave;
 	int ret = 0;
@@ -1509,7 +1511,7 @@ static int bond_header_parse(const struct sk_buff *skb, unsigned char *haddr)
 	if (slave) {
 		slave_ops = READ_ONCE(slave->dev->header_ops);
 		if (slave_ops && slave_ops->parse)
-			ret = slave_ops->parse(skb, haddr);
+			ret = slave_ops->parse(skb, slave->dev, haddr);
 	}
 	rcu_read_unlock();
 	return ret;
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 960685596093..de3efa3ce9a7 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -980,15 +980,19 @@ static int bcm_sf2_sw_resume(struct dsa_switch *ds)
 	ret = bcm_sf2_sw_rst(priv);
 	if (ret) {
 		pr_err("%s: failed to software reset switch\n", __func__);
+		if (!priv->wol_ports_mask)
+			clk_disable_unprepare(priv->clk);
 		return ret;
 	}
 
 	bcm_sf2_crossbar_setup(priv);
 
 	ret = bcm_sf2_cfp_resume(ds);
-	if (ret)
+	if (ret) {
+		if (!priv->wol_ports_mask)
+			clk_disable_unprepare(priv->clk);
 		return ret;
-
+	}
 	if (priv->hw_params.num_gphy == 1)
 		bcm_sf2_gphy_enable_set(ds, true);
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 315d97036ac1..c37a1b86180f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -3080,7 +3080,6 @@ static void airoha_remove(struct platform_device *pdev)
 		if (!port)
 			continue;
 
-		airoha_dev_stop(port->dev);
 		unregister_netdev(port->dev);
 		airoha_metadata_dst_free(port);
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c4657bb3acc1..2dadc7c66858 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2927,6 +2927,8 @@ static int bnxt_async_event_process(struct bnxt *bp,
 		u16 type = (u16)BNXT_EVENT_BUF_PRODUCER_TYPE(data1);
 		u32 offset =  BNXT_EVENT_BUF_PRODUCER_OFFSET(data2);
 
+		if (type >= ARRAY_SIZE(bp->bs_trace))
+			goto async_event_process_exit;
 		bnxt_bs_trace_check_wrap(&bp->bs_trace[type], offset);
 		goto async_event_process_exit;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f88e7769a838..4d94bacf9f01 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2135,7 +2135,7 @@ enum board_idx {
 };
 
 #define BNXT_TRACE_BUF_MAGIC_BYTE ((u8)0xbc)
-#define BNXT_TRACE_MAX 11
+#define BNXT_TRACE_MAX (DBG_LOG_BUFFER_FLUSH_REQ_TYPE_ERR_QPC_TRACE + 1)
 
 struct bnxt_bs_trace_info {
 	u8 *magic_byte;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 8fb551288298..96d5d4f7f51f 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -123,7 +123,7 @@ static int bcmgenet_poll_wol_status(struct bcmgenet_priv *priv)
 	while (!(bcmgenet_rbuf_readl(priv, RBUF_STATUS)
 		& RBUF_STATUS_WOL)) {
 		retries++;
-		if (retries > 5) {
+		if (retries > 50) {
 			netdev_crit(dev, "polling wol mode timeout\n");
 			return -ETIMEDOUT;
 		}
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 256cb5bcfac7..1a46e27bfbb4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2669,6 +2669,14 @@ static void macb_init_tieoff(struct macb *bp)
 	desc->ctrl = 0;
 }
 
+static void gem_init_rx_ring(struct macb_queue *queue)
+{
+	queue->rx_tail = 0;
+	queue->rx_prepared_head = 0;
+
+	gem_rx_refill(queue);
+}
+
 static void gem_init_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -2686,10 +2694,7 @@ static void gem_init_rings(struct macb *bp)
 		queue->tx_head = 0;
 		queue->tx_tail = 0;
 
-		queue->rx_tail = 0;
-		queue->rx_prepared_head = 0;
-
-		gem_rx_refill(queue);
+		gem_init_rx_ring(queue);
 	}
 
 	macb_init_tieoff(bp);
@@ -3974,6 +3979,9 @@ static int gem_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 	struct macb *bp = netdev_priv(netdev);
 	int ret;
 
+	if (!(netdev->hw_features & NETIF_F_NTUPLE))
+		return -EOPNOTSUPP;
+
 	switch (cmd->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
 		if ((cmd->fs.location >= bp->max_tuples)
@@ -5944,8 +5952,18 @@ static int __maybe_unused macb_resume(struct device *dev)
 		rtnl_unlock();
 	}
 
+	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
+		macb_init_buffers(bp);
+
 	for (q = 0, queue = bp->queues; q < bp->num_queues;
 	     ++q, ++queue) {
+		if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
+			if (macb_is_gem(bp))
+				gem_init_rx_ring(queue);
+			else
+				macb_init_rx_ring(queue);
+		}
+
 		napi_enable(&queue->napi_rx);
 		napi_enable(&queue->napi_tx);
 	}
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index c9e77819196e..d91f7b1aa39c 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -357,8 +357,10 @@ void gem_ptp_remove(struct net_device *ndev)
 {
 	struct macb *bp = netdev_priv(ndev);
 
-	if (bp->ptp_clock)
+	if (bp->ptp_clock) {
 		ptp_clock_unregister(bp->ptp_clock);
+		bp->ptp_clock = NULL;
+	}
 
 	gem_ptp_clear_timer(bp);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 03ab2a4276bb..0a72d419782e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -757,10 +757,13 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
 		adapter->num_vlan_filters++;
 		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_VLAN_FILTER);
 	} else if (f->state == IAVF_VLAN_REMOVE) {
-		/* IAVF_VLAN_REMOVE means that VLAN wasn't yet removed.
-		 * We can safely only change the state here.
+		/* Re-add the filter since we cannot tell whether the
+		 * pending delete has already been processed by the PF.
+		 * A duplicate add is harmless.
 		 */
-		f->state = IAVF_VLAN_ACTIVE;
+		f->state = IAVF_VLAN_ADD;
+		iavf_schedule_aq_request(adapter,
+					 IAVF_FLAG_AQ_ADD_VLAN_FILTER);
 	}
 
 clearout:
diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index a427f05814c1..17236813965d 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -781,6 +781,8 @@ int igc_ptp_hwtstamp_set(struct net_device *netdev,
 			 struct kernel_hwtstamp_config *config,
 			 struct netlink_ext_ack *extack);
 void igc_ptp_tx_hang(struct igc_adapter *adapter);
+void igc_ptp_clear_xsk_tx_tstamp_queue(struct igc_adapter *adapter,
+				       u16 queue_id);
 void igc_ptp_read(struct igc_adapter *adapter, struct timespec64 *ts);
 void igc_ptp_tx_tstamp_event(struct igc_adapter *adapter);
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 4439eeb378c1..b1ca2079e5cf 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -264,6 +264,13 @@ static void igc_clean_tx_ring(struct igc_ring *tx_ring)
 	/* reset next_to_use and next_to_clean */
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
+
+	/* Clear any lingering XSK TX timestamp requests */
+	if (test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags)) {
+		struct igc_adapter *adapter = netdev_priv(tx_ring->netdev);
+
+		igc_ptp_clear_xsk_tx_tstamp_queue(adapter, tx_ring->queue_index);
+	}
 }
 
 /**
@@ -1730,11 +1737,8 @@ static netdev_tx_t igc_xmit_frame(struct sk_buff *skb,
 	/* The minimum packet size with TCTL.PSP set is 17 so pad the skb
 	 * in order to meet this minimum size requirement.
 	 */
-	if (skb->len < 17) {
-		if (skb_padto(skb, 17))
-			return NETDEV_TX_OK;
-		skb->len = 17;
-	}
+	if (skb_put_padto(skb, 17))
+		return NETDEV_TX_OK;
 
 	return igc_xmit_frame_ring(skb, igc_tx_queue_mapping(adapter, skb));
 }
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 44ee19386766..3d6b2264164a 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -577,6 +577,39 @@ static void igc_ptp_clear_tx_tstamp(struct igc_adapter *adapter)
 	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 }
 
+/**
+ * igc_ptp_clear_xsk_tx_tstamp_queue - Clear pending XSK TX timestamps for a queue
+ * @adapter: Board private structure
+ * @queue_id: TX queue index to clear timestamps for
+ *
+ * Iterates over all TX timestamp registers and releases any pending
+ * timestamp requests associated with the given TX queue. This is
+ * called when an XDP pool is being disabled to ensure no stale
+ * timestamp references remain.
+ */
+void igc_ptp_clear_xsk_tx_tstamp_queue(struct igc_adapter *adapter, u16 queue_id)
+{
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+
+	for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
+		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
+
+		if (tstamp->buffer_type != IGC_TX_BUFFER_TYPE_XSK)
+			continue;
+		if (tstamp->xsk_queue_index != queue_id)
+			continue;
+		if (!tstamp->xsk_tx_buffer)
+			continue;
+
+		igc_ptp_free_tx_buffer(adapter, tstamp);
+	}
+
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
+}
+
 static void igc_ptp_disable_tx_timestamp(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
diff --git a/drivers/net/ethernet/intel/libie/fwlog.c b/drivers/net/ethernet/intel/libie/fwlog.c
index 5d890d9d3c4d..3b32986c2978 100644
--- a/drivers/net/ethernet/intel/libie/fwlog.c
+++ b/drivers/net/ethernet/intel/libie/fwlog.c
@@ -433,17 +433,21 @@ libie_debugfs_module_write(struct file *filp, const char __user *buf,
 	module = libie_find_module_by_dentry(fwlog->debugfs_modules, dentry);
 	if (module < 0) {
 		dev_info(dev, "unknown module\n");
-		return -EINVAL;
+		count = -EINVAL;
+		goto free_cmd_buf;
 	}
 
 	cnt = sscanf(cmd_buf, "%s", user_val);
-	if (cnt != 1)
-		return -EINVAL;
+	if (cnt != 1) {
+		count = -EINVAL;
+		goto free_cmd_buf;
+	}
 
 	log_level = sysfs_match_string(libie_fwlog_level_string, user_val);
 	if (log_level < 0) {
 		dev_info(dev, "unknown log level '%s'\n", user_val);
-		return -EINVAL;
+		count = -EINVAL;
+		goto free_cmd_buf;
 	}
 
 	if (module != LIBIE_AQC_FW_LOG_ID_MAX) {
@@ -458,6 +462,9 @@ libie_debugfs_module_write(struct file *filp, const char __user *buf,
 			fwlog->cfg.module_entries[i].log_level = log_level;
 	}
 
+free_cmd_buf:
+	kfree(cmd_buf);
+
 	return count;
 }
 
@@ -515,23 +522,31 @@ libie_debugfs_nr_messages_write(struct file *filp, const char __user *buf,
 		return PTR_ERR(cmd_buf);
 
 	ret = sscanf(cmd_buf, "%s", user_val);
-	if (ret != 1)
-		return -EINVAL;
+	if (ret != 1) {
+		count = -EINVAL;
+		goto free_cmd_buf;
+	}
 
 	ret = kstrtos16(user_val, 0, &nr_messages);
-	if (ret)
-		return ret;
+	if (ret) {
+		count = ret;
+		goto free_cmd_buf;
+	}
 
 	if (nr_messages < LIBIE_AQC_FW_LOG_MIN_RESOLUTION ||
 	    nr_messages > LIBIE_AQC_FW_LOG_MAX_RESOLUTION) {
 		dev_err(dev, "Invalid FW log number of messages %d, value must be between %d - %d\n",
 			nr_messages, LIBIE_AQC_FW_LOG_MIN_RESOLUTION,
 			LIBIE_AQC_FW_LOG_MAX_RESOLUTION);
-		return -EINVAL;
+		count = -EINVAL;
+		goto free_cmd_buf;
 	}
 
 	fwlog->cfg.log_resolution = nr_messages;
 
+free_cmd_buf:
+	kfree(cmd_buf);
+
 	return count;
 }
 
@@ -588,8 +603,10 @@ libie_debugfs_enable_write(struct file *filp, const char __user *buf,
 		return PTR_ERR(cmd_buf);
 
 	ret = sscanf(cmd_buf, "%s", user_val);
-	if (ret != 1)
-		return -EINVAL;
+	if (ret != 1) {
+		ret = -EINVAL;
+		goto free_cmd_buf;
+	}
 
 	ret = kstrtobool(user_val, &enable);
 	if (ret)
@@ -624,6 +641,8 @@ libie_debugfs_enable_write(struct file *filp, const char __user *buf,
 	 */
 	if (WARN_ON(ret != (ssize_t)count && ret >= 0))
 		ret = -EIO;
+free_cmd_buf:
+	kfree(cmd_buf);
 
 	return ret;
 }
@@ -682,8 +701,10 @@ libie_debugfs_log_size_write(struct file *filp, const char __user *buf,
 		return PTR_ERR(cmd_buf);
 
 	ret = sscanf(cmd_buf, "%s", user_val);
-	if (ret != 1)
-		return -EINVAL;
+	if (ret != 1) {
+		ret = -EINVAL;
+		goto free_cmd_buf;
+	}
 
 	index = sysfs_match_string(libie_fwlog_log_size, user_val);
 	if (index < 0) {
@@ -712,6 +733,8 @@ libie_debugfs_log_size_write(struct file *filp, const char __user *buf,
 	 */
 	if (WARN_ON(ret != (ssize_t)count && ret >= 0))
 		ret = -EIO;
+free_cmd_buf:
+	kfree(cmd_buf);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 33426fded919..789e14bb1377 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5018,7 +5018,7 @@ static int mvpp2_bm_switch_buffers(struct mvpp2 *priv, bool percpu)
 	if (priv->percpu_pools)
 		numbufs = port->nrxqs * 2;
 
-	if (change_percpu)
+	if (change_percpu && priv->global_tx_fc)
 		mvpp2_bm_pool_update_priv_fc(priv, false);
 
 	for (i = 0; i < numbufs; i++)
@@ -5043,7 +5043,7 @@ static int mvpp2_bm_switch_buffers(struct mvpp2 *priv, bool percpu)
 			mvpp2_open(port->dev);
 	}
 
-	if (change_percpu)
+	if (change_percpu && priv->global_tx_fc)
 		mvpp2_bm_pool_update_priv_fc(priv, true);
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index f8eaaf37963b..abcbd38db9db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -287,6 +287,7 @@ struct mlx5e_ipsec_sa_entry {
 	struct mlx5e_ipsec_dwork *dwork;
 	struct mlx5e_ipsec_limits limits;
 	u32 rx_mapped_id;
+	u8 ctx[MLX5_ST_SZ_BYTES(ipsec_aso)];
 };
 
 struct mlx5_accel_pol_xfrm_attrs {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index ef7322d381af..e0611fa82797 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -310,10 +310,11 @@ static void mlx5e_ipsec_aso_update(struct mlx5e_ipsec_sa_entry *sa_entry,
 	mlx5e_ipsec_aso_query(sa_entry, data);
 }
 
-static void mlx5e_ipsec_update_esn_state(struct mlx5e_ipsec_sa_entry *sa_entry,
-					 u32 mode_param)
+static void
+mlx5e_ipsec_update_esn_state(struct mlx5e_ipsec_sa_entry *sa_entry,
+			     u32 mode_param,
+			     struct mlx5_accel_esp_xfrm_attrs *attrs)
 {
-	struct mlx5_accel_esp_xfrm_attrs attrs = {};
 	struct mlx5_wqe_aso_ctrl_seg data = {};
 
 	if (mode_param < MLX5E_IPSEC_ESN_SCOPE_MID) {
@@ -323,18 +324,7 @@ static void mlx5e_ipsec_update_esn_state(struct mlx5e_ipsec_sa_entry *sa_entry,
 		sa_entry->esn_state.overlap = 1;
 	}
 
-	mlx5e_ipsec_build_accel_xfrm_attrs(sa_entry, &attrs);
-
-	/* It is safe to execute the modify below unlocked since the only flows
-	 * that could affect this HW object, are create, destroy and this work.
-	 *
-	 * Creation flow can't co-exist with this modify work, the destruction
-	 * flow would cancel this work, and this work is a single entity that
-	 * can't conflict with it self.
-	 */
-	spin_unlock_bh(&sa_entry->x->lock);
-	mlx5_accel_esp_modify_xfrm(sa_entry, &attrs);
-	spin_lock_bh(&sa_entry->x->lock);
+	mlx5e_ipsec_build_accel_xfrm_attrs(sa_entry, attrs);
 
 	data.data_offset_condition_operand =
 		MLX5_IPSEC_ASO_REMOVE_FLOW_PKT_CNT_OFFSET;
@@ -370,20 +360,18 @@ static void mlx5e_ipsec_aso_update_soft(struct mlx5e_ipsec_sa_entry *sa_entry,
 static void mlx5e_ipsec_handle_limits(struct mlx5e_ipsec_sa_entry *sa_entry)
 {
 	struct mlx5_accel_esp_xfrm_attrs *attrs = &sa_entry->attrs;
-	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
-	struct mlx5e_ipsec_aso *aso = ipsec->aso;
 	bool soft_arm, hard_arm;
 	u64 hard_cnt;
 
 	lockdep_assert_held(&sa_entry->x->lock);
 
-	soft_arm = !MLX5_GET(ipsec_aso, aso->ctx, soft_lft_arm);
-	hard_arm = !MLX5_GET(ipsec_aso, aso->ctx, hard_lft_arm);
+	soft_arm = !MLX5_GET(ipsec_aso, sa_entry->ctx, soft_lft_arm);
+	hard_arm = !MLX5_GET(ipsec_aso, sa_entry->ctx, hard_lft_arm);
 	if (!soft_arm && !hard_arm)
 		/* It is not lifetime event */
 		return;
 
-	hard_cnt = MLX5_GET(ipsec_aso, aso->ctx, remove_flow_pkt_cnt);
+	hard_cnt = MLX5_GET(ipsec_aso, sa_entry->ctx, remove_flow_pkt_cnt);
 	if (!hard_cnt || hard_arm) {
 		/* It is possible to see packet counter equal to zero without
 		 * hard limit event armed. Such situation can be if packet
@@ -453,11 +441,11 @@ static void mlx5e_ipsec_handle_event(struct work_struct *_work)
 	struct mlx5e_ipsec_work *work =
 		container_of(_work, struct mlx5e_ipsec_work, work);
 	struct mlx5e_ipsec_sa_entry *sa_entry = work->data;
+	struct mlx5_accel_esp_xfrm_attrs tmp = {};
 	struct mlx5_accel_esp_xfrm_attrs *attrs;
-	struct mlx5e_ipsec_aso *aso;
+	bool need_modify = false;
 	int ret;
 
-	aso = sa_entry->ipsec->aso;
 	attrs = &sa_entry->attrs;
 
 	spin_lock_bh(&sa_entry->x->lock);
@@ -465,18 +453,22 @@ static void mlx5e_ipsec_handle_event(struct work_struct *_work)
 	if (ret)
 		goto unlock;
 
+	if (attrs->lft.soft_packet_limit != XFRM_INF)
+		mlx5e_ipsec_handle_limits(sa_entry);
+
 	if (attrs->replay_esn.trigger &&
-	    !MLX5_GET(ipsec_aso, aso->ctx, esn_event_arm)) {
-		u32 mode_param = MLX5_GET(ipsec_aso, aso->ctx, mode_parameter);
+	    !MLX5_GET(ipsec_aso, sa_entry->ctx, esn_event_arm)) {
+		u32 mode_param = MLX5_GET(ipsec_aso, sa_entry->ctx,
+					  mode_parameter);
 
-		mlx5e_ipsec_update_esn_state(sa_entry, mode_param);
+		mlx5e_ipsec_update_esn_state(sa_entry, mode_param, &tmp);
+		need_modify = true;
 	}
 
-	if (attrs->lft.soft_packet_limit != XFRM_INF)
-		mlx5e_ipsec_handle_limits(sa_entry);
-
 unlock:
 	spin_unlock_bh(&sa_entry->x->lock);
+	if (need_modify)
+		mlx5_accel_esp_modify_xfrm(sa_entry, &tmp);
 	kfree(work);
 }
 
@@ -629,6 +621,8 @@ int mlx5e_ipsec_aso_query(struct mlx5e_ipsec_sa_entry *sa_entry,
 			/* We are in atomic context */
 			udelay(10);
 	} while (ret && time_is_after_jiffies(expires));
+	if (!ret)
+		memcpy(sa_entry->ctx, aso->ctx, MLX5_ST_SZ_BYTES(ipsec_aso));
 	spin_unlock_bh(&aso->lock);
 	return ret;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 4278bcb04c72..2e11574b3a81 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1490,24 +1490,24 @@ static int esw_qos_node_enable_tc_arbitration(struct mlx5_esw_sched_node *node,
 	return err;
 }
 
-static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
+static u32 mlx5_esw_qos_lag_link_speed_get(struct mlx5_core_dev *mdev,
+					   bool take_rtnl)
 {
 	struct ethtool_link_ksettings lksettings;
 	struct net_device *slave, *master;
 	u32 speed = SPEED_UNKNOWN;
 
-	/* Lock ensures a stable reference to master and slave netdevice
-	 * while port speed of master is queried.
-	 */
-	ASSERT_RTNL();
-
 	slave = mlx5_uplink_netdev_get(mdev);
 	if (!slave)
 		goto out;
 
+	if (take_rtnl)
+		rtnl_lock();
 	master = netdev_master_upper_dev_get(slave);
 	if (master && !__ethtool_get_link_ksettings(master, &lksettings))
 		speed = lksettings.base.speed;
+	if (take_rtnl)
+		rtnl_unlock();
 
 out:
 	mlx5_uplink_netdev_put(mdev, slave);
@@ -1515,20 +1515,15 @@ static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
 }
 
 static int mlx5_esw_qos_max_link_speed_get(struct mlx5_core_dev *mdev, u32 *link_speed_max,
-					   bool hold_rtnl_lock, struct netlink_ext_ack *extack)
+					   bool take_rtnl,
+					   struct netlink_ext_ack *extack)
 {
 	int err;
 
 	if (!mlx5_lag_is_active(mdev))
 		goto skip_lag;
 
-	if (hold_rtnl_lock)
-		rtnl_lock();
-
-	*link_speed_max = mlx5_esw_qos_lag_link_speed_get_locked(mdev);
-
-	if (hold_rtnl_lock)
-		rtnl_unlock();
+	*link_speed_max = mlx5_esw_qos_lag_link_speed_get(mdev, take_rtnl);
 
 	if (*link_speed_max != (u32)SPEED_UNKNOWN)
 		return 0;
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index aa4e2731e2ba..840c6b8957c9 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -814,9 +814,6 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 		gc->max_num_cqs = 0;
 	}
 
-	kfree(hwc->caller_ctx);
-	hwc->caller_ctx = NULL;
-
 	if (hwc->txq)
 		mana_hwc_destroy_wq(hwc, hwc->txq);
 
@@ -826,6 +823,9 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 	if (hwc->cq)
 		mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);
 
+	kfree(hwc->caller_ctx);
+	hwc->caller_ctx = NULL;
+
 	mana_gd_free_res_map(&hwc->inflight_msg_res);
 
 	hwc->num_inflight_msg = 0;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 090aa74d3ce7..a9b5f86bc71b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1075,6 +1075,11 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
 
 		*xdp_state = emac_run_xdp(emac, &xdp, &pkt_len);
+		if (*xdp_state == ICSSG_XDP_CONSUMED) {
+			page_pool_recycle_direct(pool, page);
+			goto requeue;
+		}
+
 		if (*xdp_state != ICSSG_XDP_PASS)
 			goto requeue;
 		headroom = xdp.data - xdp.data_hard_start;
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index f418efb38508..eb282b295da8 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -508,7 +508,7 @@ static ssize_t sysdata_release_enabled_show(struct config_item *item,
 	bool release_enabled;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	release_enabled = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
+	release_enabled = !!(nt->sysdata_fields & SYSDATA_RELEASE);
 	mutex_unlock(&dynamic_netconsole_mutex);
 
 	return sysfs_emit(buf, "%d\n", release_enabled);
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 6927c1962277..62223ad2d63f 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -109,8 +109,11 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 	int ret;
 
 	ret = __dev_forward_skb(rx_dev, skb);
-	if (ret)
+	if (ret) {
+		if (psp_ext)
+			__skb_ext_put(psp_ext);
 		return ret;
+	}
 
 	nsim_psp_handle_ext(skb, psp_ext);
 
diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index 9201ee10a13f..d316aa66dbc2 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -1400,14 +1400,14 @@ static int aqc111_suspend(struct usb_interface *intf, pm_message_t message)
 		aqc111_write16_cmd_nopm(dev, AQ_ACCESS_MAC,
 					SFR_MEDIUM_STATUS_MODE, 2, &reg16);
 
-		aqc111_write_cmd(dev, AQ_WOL_CFG, 0, 0,
-				 WOL_CFG_SIZE, &wol_cfg);
-		aqc111_write32_cmd(dev, AQ_PHY_OPS, 0, 0,
-				   &aqc111_data->phy_cfg);
+		aqc111_write_cmd_nopm(dev, AQ_WOL_CFG, 0, 0,
+				      WOL_CFG_SIZE, &wol_cfg);
+		aqc111_write32_cmd_nopm(dev, AQ_PHY_OPS, 0, 0,
+					&aqc111_data->phy_cfg);
 	} else {
 		aqc111_data->phy_cfg |= AQ_LOW_POWER;
-		aqc111_write32_cmd(dev, AQ_PHY_OPS, 0, 0,
-				   &aqc111_data->phy_cfg);
+		aqc111_write32_cmd_nopm(dev, AQ_PHY_OPS, 0, 0,
+					&aqc111_data->phy_cfg);
 
 		/* Disable RX path */
 		aqc111_read16_cmd_nopm(dev, AQ_ACCESS_MAC,
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 5d123df0a866..81d7e99fc0f0 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1656,6 +1656,7 @@ int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset)
 	struct usbnet *dev = netdev_priv(skb_in->dev);
 	struct usb_cdc_ncm_ndp16 *ndp16;
 	int ret = -EINVAL;
+	size_t ndp_len;
 
 	if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp16)) > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "invalid NDP offset  <%u>\n",
@@ -1675,8 +1676,8 @@ int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset)
 					sizeof(struct usb_cdc_ncm_dpe16));
 	ret--; /* we process NDP entries except for the last one */
 
-	if ((sizeof(struct usb_cdc_ncm_ndp16) +
-	     ret * (sizeof(struct usb_cdc_ncm_dpe16))) > skb_in->len) {
+	ndp_len = struct_size_t(struct usb_cdc_ncm_ndp16, dpe16, ret);
+	if (ndpoffset + ndp_len > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);
 		ret = -EINVAL;
 	}
@@ -1692,6 +1693,7 @@ int cdc_ncm_rx_verify_ndp32(struct sk_buff *skb_in, int ndpoffset)
 	struct usbnet *dev = netdev_priv(skb_in->dev);
 	struct usb_cdc_ncm_ndp32 *ndp32;
 	int ret = -EINVAL;
+	size_t ndp_len;
 
 	if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp32)) > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "invalid NDP offset  <%u>\n",
@@ -1711,8 +1713,8 @@ int cdc_ncm_rx_verify_ndp32(struct sk_buff *skb_in, int ndpoffset)
 					sizeof(struct usb_cdc_ncm_dpe32));
 	ret--; /* we process NDP entries except for the last one */
 
-	if ((sizeof(struct usb_cdc_ncm_ndp32) +
-	     ret * (sizeof(struct usb_cdc_ncm_dpe32))) > skb_in->len) {
+	ndp_len = struct_size_t(struct usb_cdc_ncm_ndp32, dpe32, ret);
+	if (ndpoffset + ndp_len > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);
 		ret = -EINVAL;
 	}
diff --git a/drivers/net/wireless/ath/ath9k/channel.c b/drivers/net/wireless/ath/ath9k/channel.c
index 121e51ce1bc0..8b27d8cc086a 100644
--- a/drivers/net/wireless/ath/ath9k/channel.c
+++ b/drivers/net/wireless/ath/ath9k/channel.c
@@ -1006,7 +1006,7 @@ static void ath_scan_send_probe(struct ath_softc *sc,
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
 
 	if (!ieee80211_tx_prepare_skb(sc->hw, vif, skb, band, NULL))
-		goto error;
+		return;
 
 	txctl.txq = sc->tx.txq_map[IEEE80211_AC_VO];
 	if (ath_tx_start(sc->hw, skb, &txctl))
@@ -1119,10 +1119,8 @@ ath_chanctx_send_vif_ps_frame(struct ath_softc *sc, struct ath_vif *avp,
 
 		skb->priority = 7;
 		skb_set_queue_mapping(skb, IEEE80211_AC_VO);
-		if (!ieee80211_tx_prepare_skb(sc->hw, vif, skb, band, &sta)) {
-			dev_kfree_skb_any(skb);
+		if (!ieee80211_tx_prepare_skb(sc->hw, vif, skb, band, &sta))
 			return false;
-		}
 		break;
 	default:
 		return false;
diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index ff9176cdee3d..63b0447e55c1 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -63,10 +63,8 @@ mt76_scan_send_probe(struct mt76_dev *dev, struct cfg80211_ssid *ssid)
 
 	rcu_read_lock();
 
-	if (!ieee80211_tx_prepare_skb(phy->hw, vif, skb, band, NULL)) {
-		ieee80211_free_txskb(phy->hw, skb);
+	if (!ieee80211_tx_prepare_skb(phy->hw, vif, skb, band, NULL))
 		goto out;
-	}
 
 	info = IEEE80211_SKB_CB(skb);
 	if (req->no_cck)
diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
index 6241866d39df..75cfbcfb7626 100644
--- a/drivers/net/wireless/ti/wlcore/tx.c
+++ b/drivers/net/wireless/ti/wlcore/tx.c
@@ -210,7 +210,7 @@ static int wl1271_tx_allocate(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 		if (skb_headroom(skb) < (total_len - skb->len) &&
 		    pskb_expand_head(skb, (total_len - skb->len), 0, GFP_ATOMIC)) {
 			wl1271_free_tx_id(wl, id);
-			return -EAGAIN;
+			return -ENOMEM;
 		}
 		desc = skb_push(skb, total_len - skb->len);
 
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 79cc63272134..cfbd0c50be1c 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3021,7 +3021,6 @@ static void hw_scan_work(struct work_struct *work)
 						      hwsim->tmp_chan->band,
 						      NULL)) {
 				rcu_read_unlock();
-				kfree_skb(probe);
 				continue;
 			}
 
diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 6a5ce8ff91f0..b3d34433bd14 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -47,8 +47,8 @@ static int nxp_nci_i2c_set_mode(void *phy_id,
 {
 	struct nxp_nci_i2c_phy *phy = (struct nxp_nci_i2c_phy *) phy_id;
 
-	gpiod_set_value(phy->gpiod_fw, (mode == NXP_NCI_MODE_FW) ? 1 : 0);
-	gpiod_set_value(phy->gpiod_en, (mode != NXP_NCI_MODE_COLD) ? 1 : 0);
+	gpiod_set_value_cansleep(phy->gpiod_fw, (mode == NXP_NCI_MODE_FW) ? 1 : 0);
+	gpiod_set_value_cansleep(phy->gpiod_en, (mode != NXP_NCI_MODE_COLD) ? 1 : 0);
 	usleep_range(10000, 15000);
 
 	if (mode == NXP_NCI_MODE_COLD)
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 87178a53ff9c..8eb205459d4c 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -486,14 +486,15 @@ EXPORT_SYMBOL_GPL(nd_synchronize);
 static void nd_async_device_register(void *d, async_cookie_t cookie)
 {
 	struct device *dev = d;
+	struct device *parent = dev->parent;
 
 	if (device_add(dev) != 0) {
 		dev_err(dev, "%s: failed\n", __func__);
 		put_device(dev);
 	}
 	put_device(dev);
-	if (dev->parent)
-		put_device(dev->parent);
+	if (parent)
+		put_device(parent);
 }
 
 static void nd_async_device_unregister(void *d, async_cookie_t cookie)
diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
index 0450202bbee2..eee87a300532 100644
--- a/drivers/pmdomain/bcm/bcm2835-power.c
+++ b/drivers/pmdomain/bcm/bcm2835-power.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/mfd/bcm2835-pm.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -153,7 +154,6 @@ struct bcm2835_power {
 static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable)
 {
 	void __iomem *base = power->asb;
-	u64 start;
 	u32 val;
 
 	switch (reg) {
@@ -166,8 +166,6 @@ static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable
 		break;
 	}
 
-	start = ktime_get_ns();
-
 	/* Enable the module's async AXI bridges. */
 	if (enable) {
 		val = readl(base + reg) & ~ASB_REQ_STOP;
@@ -176,11 +174,9 @@ static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable
 	}
 	writel(PM_PASSWORD | val, base + reg);
 
-	while (!!(readl(base + reg) & ASB_ACK) == enable) {
-		cpu_relax();
-		if (ktime_get_ns() - start >= 1000)
-			return -ETIMEDOUT;
-	}
+	if (readl_poll_timeout_atomic(base + reg, val,
+				      !!(val & ASB_ACK) != enable, 0, 5))
+		return -ETIMEDOUT;
 
 	return 0;
 }
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index f64f24d520dd..e2800aa1bc59 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -1203,7 +1203,7 @@ static int scpsys_probe(struct platform_device *pdev)
 	scpsys->soc_data = soc;
 
 	scpsys->pd_data.domains = scpsys->domains;
-	scpsys->pd_data.num_domains = soc->num_domains;
+	scpsys->pd_data.num_domains = num_domains;
 
 	parent = dev->parent;
 	if (!parent) {
diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index b495d5291868..41fe42117181 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1428,6 +1428,7 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 static int mpam_restore_mbwu_state(void *_ris)
 {
 	int i;
+	u64 val;
 	struct mon_read mwbu_arg;
 	struct mpam_msc_ris *ris = _ris;
 	struct mpam_class *class = ris->vmsc->comp->class;
@@ -1437,6 +1438,7 @@ static int mpam_restore_mbwu_state(void *_ris)
 			mwbu_arg.ris = ris;
 			mwbu_arg.ctx = &ris->mbwu_state[i].cfg;
 			mwbu_arg.type = mpam_msmon_choose_counter(class);
+			mwbu_arg.val = &val;
 
 			__ris_msmon_read(&mwbu_arg);
 		}
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 6b392b3ad4b1..39a3e7aab6ff 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1827,6 +1827,8 @@ EXPORT_SYMBOL(qman_create_fq);
 
 void qman_destroy_fq(struct qman_fq *fq)
 {
+	int leaked;
+
 	/*
 	 * We don't need to lock the FQ as it is a pre-condition that the FQ be
 	 * quiesced. Instead, run some checks.
@@ -1834,11 +1836,29 @@ void qman_destroy_fq(struct qman_fq *fq)
 	switch (fq->state) {
 	case qman_fq_state_parked:
 	case qman_fq_state_oos:
-		if (fq_isset(fq, QMAN_FQ_FLAG_DYNAMIC_FQID))
-			qman_release_fqid(fq->fqid);
+		/*
+		 * There's a race condition here on releasing the fqid,
+		 * setting the fq_table to NULL, and freeing the fqid.
+		 * To prevent it, this order should be respected:
+		 */
+		if (fq_isset(fq, QMAN_FQ_FLAG_DYNAMIC_FQID)) {
+			leaked = qman_shutdown_fq(fq->fqid);
+			if (leaked)
+				pr_debug("FQID %d leaked\n", fq->fqid);
+		}
 
 		DPAA_ASSERT(fq_table[fq->idx]);
 		fq_table[fq->idx] = NULL;
+
+		if (fq_isset(fq, QMAN_FQ_FLAG_DYNAMIC_FQID) && !leaked) {
+			/*
+			 * fq_table[fq->idx] should be set to null before
+			 * freeing fq->fqid otherwise it could by allocated by
+			 * qman_alloc_fqid() while still being !NULL
+			 */
+			smp_wmb();
+			gen_pool_free(qm_fqalloc, fq->fqid | DPAA_GENALLOC_OFF, 1);
+		}
 		return;
 	default:
 		break;
diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index da5ea6d35618..6db5ab05c2c1 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -1799,8 +1799,8 @@ static int qmc_qe_init_resources(struct qmc *qmc, struct platform_device *pdev)
 		return -EINVAL;
 	qmc->dpram_offset = res->start - qe_muram_dma(qe_muram_addr(0));
 	qmc->dpram = devm_ioremap_resource(qmc->dev, res);
-	if (IS_ERR(qmc->scc_pram))
-		return PTR_ERR(qmc->scc_pram);
+	if (IS_ERR(qmc->dpram))
+		return PTR_ERR(qmc->dpram);
 
 	return 0;
 }
diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 30bc45d17d34..81636cfecd37 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -142,8 +142,10 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 
 	sys_controller->flash = of_get_mtd_device_by_node(np);
 	of_node_put(np);
-	if (IS_ERR(sys_controller->flash))
-		return dev_err_probe(dev, PTR_ERR(sys_controller->flash), "Failed to get flash\n");
+	if (IS_ERR(sys_controller->flash)) {
+		ret = dev_err_probe(dev, PTR_ERR(sys_controller->flash), "Failed to get flash\n");
+		goto out_free;
+	}
 
 no_flash:
 	sys_controller->client.dev = dev;
@@ -155,8 +157,7 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 	if (IS_ERR(sys_controller->chan)) {
 		ret = dev_err_probe(dev, PTR_ERR(sys_controller->chan),
 				    "Failed to get mbox channel\n");
-		kfree(sys_controller);
-		return ret;
+		goto out_free;
 	}
 
 	init_completion(&sys_controller->c);
@@ -174,6 +175,10 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "Registered MPFS system controller\n");
 
 	return 0;
+
+out_free:
+	kfree(sys_controller);
+	return ret;
 }
 
 static void mpfs_sys_controller_remove(struct platform_device *pdev)
diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 04937c40da47..b459607c118a 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -231,6 +231,7 @@ static int __init rockchip_grf_init(void)
 		grf = syscon_node_to_regmap(np);
 		if (IS_ERR(grf)) {
 			pr_err("%s: could not get grf syscon\n", __func__);
+			of_node_put(np);
 			return PTR_ERR(grf);
 		}
 
diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
index f324aa39a897..b2589fe2425c 100644
--- a/drivers/spi/spi-amlogic-spifc-a4.c
+++ b/drivers/spi/spi-amlogic-spifc-a4.c
@@ -1083,14 +1083,6 @@ static int aml_sfc_clk_init(struct aml_sfc *sfc)
 	return clk_set_rate(sfc->core_clk, SFC_BUS_DEFAULT_CLK);
 }
 
-static int aml_sfc_disable_clk(struct aml_sfc *sfc)
-{
-	clk_disable_unprepare(sfc->core_clk);
-	clk_disable_unprepare(sfc->gate_clk);
-
-	return 0;
-}
-
 static int aml_sfc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1141,16 +1133,12 @@ static int aml_sfc_probe(struct platform_device *pdev)
 
 	/* Enable Amlogic flash controller spi mode */
 	ret = regmap_write(sfc->regmap_base, SFC_SPI_CFG, SPI_MODE_EN);
-	if (ret) {
-		dev_err(dev, "failed to enable SPI mode\n");
-		goto err_out;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable SPI mode\n");
 
 	ret = dma_set_mask(sfc->dev, DMA_BIT_MASK(32));
-	if (ret) {
-		dev_err(sfc->dev, "failed to set dma mask\n");
-		goto err_out;
-	}
+	if (ret)
+		return dev_err_probe(sfc->dev, ret, "failed to set dma mask\n");
 
 	sfc->ecc_eng.dev = &pdev->dev;
 	sfc->ecc_eng.integration = NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
@@ -1158,10 +1146,8 @@ static int aml_sfc_probe(struct platform_device *pdev)
 	sfc->ecc_eng.priv = sfc;
 
 	ret = nand_ecc_register_on_host_hw_engine(&sfc->ecc_eng);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register Aml host ecc engine.\n");
-		goto err_out;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to register Aml host ecc engine.\n");
 
 	ret = of_property_read_u32(np, "amlogic,rx-adj", &val);
 	if (!ret)
@@ -1177,24 +1163,7 @@ static int aml_sfc_probe(struct platform_device *pdev)
 	ctrl->min_speed_hz = SFC_MIN_FREQUENCY;
 	ctrl->num_chipselect = SFC_MAX_CS_NUM;
 
-	ret = devm_spi_register_controller(dev, ctrl);
-	if (ret)
-		goto err_out;
-
-	return 0;
-
-err_out:
-	aml_sfc_disable_clk(sfc);
-
-	return ret;
-}
-
-static void aml_sfc_remove(struct platform_device *pdev)
-{
-	struct spi_controller *ctlr = platform_get_drvdata(pdev);
-	struct aml_sfc *sfc = spi_controller_get_devdata(ctlr);
-
-	aml_sfc_disable_clk(sfc);
+	return devm_spi_register_controller(dev, ctrl);
 }
 
 static const struct of_device_id aml_sfc_of_match[] = {
@@ -1212,7 +1181,6 @@ static struct platform_driver aml_sfc_driver = {
 		.of_match_table = aml_sfc_of_match,
 	},
 	.probe = aml_sfc_probe,
-	.remove = aml_sfc_remove,
 };
 module_platform_driver(aml_sfc_driver);
 
diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
index bcd7ec291ad0..6045c89c37c8 100644
--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -729,9 +729,9 @@ static int aml_spisg_probe(struct platform_device *pdev)
 	};
 
 	if (of_property_read_bool(dev->of_node, "spi-slave"))
-		ctlr = spi_alloc_target(dev, sizeof(*spisg));
+		ctlr = devm_spi_alloc_target(dev, sizeof(*spisg));
 	else
-		ctlr = spi_alloc_host(dev, sizeof(*spisg));
+		ctlr = devm_spi_alloc_host(dev, sizeof(*spisg));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -750,10 +750,8 @@ static int aml_spisg_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(spisg->map), "regmap init failed\n");
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto out_controller;
-	}
+	if (irq < 0)
+		return irq;
 
 	ret = device_reset_optional(dev);
 	if (ret)
@@ -818,8 +816,6 @@ static int aml_spisg_probe(struct platform_device *pdev)
 	if (spisg->core)
 		clk_disable_unprepare(spisg->core);
 	clk_disable_unprepare(spisg->pclk);
-out_controller:
-	spi_controller_put(ctlr);
 
 	return ret;
 }
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e25df9990f82..201b9569ce69 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2914,6 +2914,8 @@ static void spi_controller_release(struct device *dev)
 	struct spi_controller *ctlr;
 
 	ctlr = container_of(dev, struct spi_controller, dev);
+
+	free_percpu(ctlr->pcpu_statistics);
 	kfree(ctlr);
 }
 
@@ -3057,6 +3059,12 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	if (!ctlr)
 		return NULL;
 
+	ctlr->pcpu_statistics = spi_alloc_pcpu_stats(NULL);
+	if (!ctlr->pcpu_statistics) {
+		kfree(ctlr);
+		return NULL;
+	}
+
 	device_initialize(&ctlr->dev);
 	INIT_LIST_HEAD(&ctlr->queue);
 	spin_lock_init(&ctlr->queue_lock);
@@ -3344,17 +3352,8 @@ int spi_register_controller(struct spi_controller *ctlr)
 		dev_info(dev, "controller is unqueued, this is deprecated\n");
 	} else if (ctlr->transfer_one || ctlr->transfer_one_message) {
 		status = spi_controller_initialize_queue(ctlr);
-		if (status) {
-			device_del(&ctlr->dev);
-			goto free_bus_id;
-		}
-	}
-	/* Add statistics */
-	ctlr->pcpu_statistics = spi_alloc_pcpu_stats(dev);
-	if (!ctlr->pcpu_statistics) {
-		dev_err(dev, "Error allocating per-cpu statistics\n");
-		status = -ENOMEM;
-		goto destroy_queue;
+		if (status)
+			goto del_ctrl;
 	}
 
 	mutex_lock(&board_lock);
@@ -3368,8 +3367,8 @@ int spi_register_controller(struct spi_controller *ctlr)
 	acpi_register_spi_devices(ctlr);
 	return status;
 
-destroy_queue:
-	spi_destroy_queue(ctlr);
+del_ctrl:
+	device_del(&ctlr->dev);
 free_bus_id:
 	mutex_lock(&board_lock);
 	idr_remove(&spi_controller_idr, ctlr->bus_num);
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 4a47de4bb2e5..898707ca21a8 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -23,29 +23,11 @@ struct tee_shm_dma_mem {
 	struct page *page;
 };
 
-static void shm_put_kernel_pages(struct page **pages, size_t page_count)
-{
-	size_t n;
-
-	for (n = 0; n < page_count; n++)
-		put_page(pages[n]);
-}
-
-static void shm_get_kernel_pages(struct page **pages, size_t page_count)
-{
-	size_t n;
-
-	for (n = 0; n < page_count; n++)
-		get_page(pages[n]);
-}
-
 static void release_registered_pages(struct tee_shm *shm)
 {
 	if (shm->pages) {
 		if (shm->flags & TEE_SHM_USER_MAPPED)
 			unpin_user_pages(shm->pages, shm->num_pages);
-		else
-			shm_put_kernel_pages(shm->pages, shm->num_pages);
 
 		kfree(shm->pages);
 	}
@@ -477,13 +459,6 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 		goto err_put_shm_pages;
 	}
 
-	/*
-	 * iov_iter_extract_kvec_pages does not get reference on the pages,
-	 * get a reference on them.
-	 */
-	if (iov_iter_is_kvec(iter))
-		shm_get_kernel_pages(shm->pages, num_pages);
-
 	shm->offset = off;
 	shm->size = len;
 	shm->num_pages = num_pages;
@@ -499,8 +474,6 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 err_put_shm_pages:
 	if (!iov_iter_is_kvec(iter))
 		unpin_user_pages(shm->pages, shm->num_pages);
-	else
-		shm_put_kernel_pages(shm->pages, shm->num_pages);
 err_free_shm_pages:
 	kfree(shm->pages);
 err_free_shm:
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 8caecfc85d93..77fe0588fd6b 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -175,7 +175,9 @@ static unsigned int __maybe_unused serial_icr_read(struct uart_8250_port *up,
 	return value;
 }
 
+void serial8250_clear_fifos(struct uart_8250_port *p);
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p);
+void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count);
 
 void serial8250_rpm_get(struct uart_8250_port *p);
 void serial8250_rpm_put(struct uart_8250_port *p);
@@ -400,6 +402,26 @@ static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
 
 	return dma && dma->tx_running;
 }
+
+static inline void serial8250_tx_dma_pause(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	if (!dma->tx_running)
+		return;
+
+	dmaengine_pause(dma->txchan);
+}
+
+static inline void serial8250_tx_dma_resume(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	if (!dma->tx_running)
+		return;
+
+	dmaengine_resume(dma->txchan);
+}
 #else
 static inline int serial8250_tx_dma(struct uart_8250_port *p)
 {
@@ -421,6 +443,9 @@ static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
 {
 	return false;
 }
+
+static inline void serial8250_tx_dma_pause(struct uart_8250_port *p) { }
+static inline void serial8250_tx_dma_resume(struct uart_8250_port *p) { }
 #endif
 
 static inline int ns16550a_goto_highspeed(struct uart_8250_port *up)
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index bdd26c9f34bd..3b6452e759d5 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -162,7 +162,22 @@ void serial8250_tx_dma_flush(struct uart_8250_port *p)
 	 */
 	dma->tx_size = 0;
 
+	/*
+	 * We can't use `dmaengine_terminate_sync` because `uart_flush_buffer` is
+	 * holding the uart port spinlock.
+	 */
 	dmaengine_terminate_async(dma->txchan);
+
+	/*
+	 * The callback might or might not run. If it doesn't run, we need to ensure
+	 * that `tx_running` is cleared so that we can schedule new transactions.
+	 * If it does run, then the zombie callback will clear `tx_running` again
+	 * and perform a no-op since `tx_size` was cleared above.
+	 *
+	 * In either case, we ASSUME the DMA transaction will terminate before we
+	 * issue a new `serial8250_tx_dma`.
+	 */
+	dma->tx_running = 0;
 }
 
 int serial8250_rx_dma(struct uart_8250_port *p)
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 0f8207652efe..a222ec012861 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -9,10 +9,14 @@
  * LCR is written whilst busy.  If it is, then a busy detect interrupt is
  * raised, the LCR needs to be rewritten and the uart status register read.
  */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/lockdep.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
@@ -40,8 +44,12 @@
 #define RZN1_UART_RDMACR 0x110 /* DMA Control Register Receive Mode */
 
 /* DesignWare specific register fields */
+#define DW_UART_IIR_IID			GENMASK(3, 0)
+
 #define DW_UART_MCR_SIRE		BIT(6)
 
+#define DW_UART_USR_BUSY		BIT(0)
+
 /* Renesas specific register fields */
 #define RZN1_UART_xDMACR_DMA_EN		BIT(0)
 #define RZN1_UART_xDMACR_1_WORD_BURST	(0 << 1)
@@ -56,6 +64,13 @@
 #define DW_UART_QUIRK_IS_DMA_FC		BIT(3)
 #define DW_UART_QUIRK_APMC0D08		BIT(4)
 #define DW_UART_QUIRK_CPR_VALUE		BIT(5)
+#define DW_UART_QUIRK_IER_KICK		BIT(6)
+
+/*
+ * Number of consecutive IIR_NO_INT interrupts required to trigger interrupt
+ * storm prevention code.
+ */
+#define DW_UART_QUIRK_IER_KICK_THRES	4
 
 struct dw8250_platform_data {
 	u8 usr_reg;
@@ -77,6 +92,9 @@ struct dw8250_data {
 
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
+	unsigned int		in_idle:1;
+
+	u8			no_int_count;
 };
 
 static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data *data)
@@ -107,78 +125,167 @@ static inline u32 dw8250_modify_msr(struct uart_port *p, unsigned int offset, u3
 	return value;
 }
 
+static void dw8250_idle_exit(struct uart_port *p)
+{
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	if (d->uart_16550_compatible)
+		return;
+
+	if (up->capabilities & UART_CAP_FIFO)
+		serial_port_out(p, UART_FCR, up->fcr);
+	serial_port_out(p, UART_MCR, up->mcr);
+	serial_port_out(p, UART_IER, up->ier);
+
+	/* DMA Rx is restarted by IRQ handler as needed. */
+	if (up->dma)
+		serial8250_tx_dma_resume(up);
+
+	d->in_idle = 0;
+}
+
 /*
- * This function is being called as part of the uart_port::serial_out()
- * routine. Hence, it must not call serial_port_out() or serial_out()
- * against the modified registers here, i.e. LCR.
+ * Ensure BUSY is not asserted. If DW UART is configured with
+ * !uart_16550_compatible, the writes to LCR, DLL, and DLH fail while
+ * BUSY is asserted.
+ *
+ * Context: port's lock must be held
  */
-static void dw8250_force_idle(struct uart_port *p)
+static int dw8250_idle_enter(struct uart_port *p)
 {
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	unsigned int usr_reg = d->pdata ? d->pdata->usr_reg : DW_UART_USR;
 	struct uart_8250_port *up = up_to_u8250p(p);
-	unsigned int lsr;
+	int retries;
+	u32 lsr;
 
-	/*
-	 * The following call currently performs serial_out()
-	 * against the FCR register. Because it differs to LCR
-	 * there will be no infinite loop, but if it ever gets
-	 * modified, we might need a new custom version of it
-	 * that avoids infinite recursion.
-	 */
-	serial8250_clear_and_reinit_fifos(up);
+	lockdep_assert_held_once(&p->lock);
+
+	if (d->uart_16550_compatible)
+		return 0;
+
+	d->in_idle = 1;
+
+	/* Prevent triggering interrupt from RBR filling */
+	serial_port_out(p, UART_IER, 0);
+
+	if (up->dma) {
+		serial8250_rx_dma_flush(up);
+		if (serial8250_tx_dma_running(up))
+			serial8250_tx_dma_pause(up);
+	}
 
 	/*
-	 * With PSLVERR_RESP_EN parameter set to 1, the device generates an
-	 * error response when an attempt to read an empty RBR with FIFO
-	 * enabled.
+	 * Wait until Tx becomes empty + one extra frame time to ensure all bits
+	 * have been sent on the wire.
+	 *
+	 * FIXME: frame_time delay is too long with very low baudrates.
 	 */
-	if (up->fcr & UART_FCR_ENABLE_FIFO) {
-		lsr = serial_port_in(p, UART_LSR);
-		if (!(lsr & UART_LSR_DR))
-			return;
+	serial8250_fifo_wait_for_lsr_thre(up, p->fifosize);
+	ndelay(p->frame_time);
+
+	serial_port_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
+
+	retries = 4;	/* Arbitrary limit, 2 was always enough in tests */
+	do {
+		serial8250_clear_fifos(up);
+		if (!(serial_port_in(p, usr_reg) & DW_UART_USR_BUSY))
+			break;
+		/* FIXME: frame_time delay is too long with very low baudrates. */
+		ndelay(p->frame_time);
+	} while (--retries);
+
+	lsr = serial_lsr_in(up);
+	if (lsr & UART_LSR_DR) {
+		serial_port_in(p, UART_RX);
+		up->lsr_saved_flags = 0;
+	}
+
+	/* Now guaranteed to have BUSY deasserted? Just sanity check */
+	if (serial_port_in(p, usr_reg) & DW_UART_USR_BUSY) {
+		dw8250_idle_exit(p);
+		return -EBUSY;
 	}
 
-	serial_port_in(p, UART_RX);
+	return 0;
+}
+
+static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+	int ret;
+
+	ret = dw8250_idle_enter(p);
+	if (ret < 0)
+		return;
+
+	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
+	if (!(serial_port_in(p, UART_LCR) & UART_LCR_DLAB))
+		goto idle_failed;
+
+	serial_dl_write(up, quot);
+	serial_port_out(p, UART_LCR, up->lcr);
+
+idle_failed:
+	dw8250_idle_exit(p);
 }
 
 /*
  * This function is being called as part of the uart_port::serial_out()
- * routine. Hence, it must not call serial_port_out() or serial_out()
- * against the modified registers here, i.e. LCR.
+ * routine. Hence, special care must be taken when serial_port_out() or
+ * serial_out() against the modified registers here, i.e. LCR (d->in_idle is
+ * used to break recursion loop).
  */
 static void dw8250_check_lcr(struct uart_port *p, unsigned int offset, u32 value)
 {
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
-	void __iomem *addr = p->membase + (offset << p->regshift);
-	int tries = 1000;
+	u32 lcr;
+	int ret;
 
 	if (offset != UART_LCR || d->uart_16550_compatible)
 		return;
 
+	lcr = serial_port_in(p, UART_LCR);
+
 	/* Make sure LCR write wasn't ignored */
-	while (tries--) {
-		u32 lcr = serial_port_in(p, offset);
+	if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
+		return;
 
-		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
-			return;
+	if (d->in_idle)
+		goto write_err;
 
-		dw8250_force_idle(p);
+	ret = dw8250_idle_enter(p);
+	if (ret < 0)
+		goto write_err;
 
-#ifdef CONFIG_64BIT
-		if (p->type == PORT_OCTEON)
-			__raw_writeq(value & 0xff, addr);
-		else
-#endif
-		if (p->iotype == UPIO_MEM32)
-			writel(value, addr);
-		else if (p->iotype == UPIO_MEM32BE)
-			iowrite32be(value, addr);
-		else
-			writeb(value, addr);
-	}
+	serial_port_out(p, UART_LCR, value);
+	dw8250_idle_exit(p);
+	return;
+
+write_err:
 	/*
 	 * FIXME: this deadlocks if port->lock is already held
 	 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
 	 */
+	return;		/* Silences "label at the end of compound statement" */
+}
+
+/*
+ * With BUSY, LCR writes can be very expensive (IRQ + complex retry logic).
+ * If the write does not change the value of the LCR register, skip it entirely.
+ */
+static bool dw8250_can_skip_reg_write(struct uart_port *p, unsigned int offset, u32 value)
+{
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	u32 lcr;
+
+	if (offset != UART_LCR || d->uart_16550_compatible)
+		return false;
+
+	lcr = serial_port_in(p, offset);
+	return lcr == value;
 }
 
 /* Returns once the transmitter is empty or we run out of retries */
@@ -207,12 +314,18 @@ static void dw8250_tx_wait_empty(struct uart_port *p)
 
 static void dw8250_serial_out(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	writeb(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
 
 static void dw8250_serial_out38x(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	/* Allow the TX to drain before we reconfigure */
 	if (offset == UART_LCR)
 		dw8250_tx_wait_empty(p);
@@ -237,6 +350,9 @@ static u32 dw8250_serial_inq(struct uart_port *p, unsigned int offset)
 
 static void dw8250_serial_outq(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	value &= 0xff;
 	__raw_writeq(value, p->membase + (offset << p->regshift));
 	/* Read back to ensure register write ordering. */
@@ -248,6 +364,9 @@ static void dw8250_serial_outq(struct uart_port *p, unsigned int offset, u32 val
 
 static void dw8250_serial_out32(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	writel(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
@@ -261,6 +380,9 @@ static u32 dw8250_serial_in32(struct uart_port *p, unsigned int offset)
 
 static void dw8250_serial_out32be(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	iowrite32be(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
@@ -272,6 +394,29 @@ static u32 dw8250_serial_in32be(struct uart_port *p, unsigned int offset)
        return dw8250_modify_msr(p, offset, value);
 }
 
+/*
+ * INTC10EE UART can IRQ storm while reporting IIR_NO_INT. Inducing IIR value
+ * change has been observed to break the storm.
+ *
+ * If Tx is empty (THRE asserted), we use here IER_THRI to cause IIR_NO_INT ->
+ * IIR_THRI transition.
+ */
+static void dw8250_quirk_ier_kick(struct uart_port *p)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+	u32 lsr;
+
+	if (up->ier & UART_IER_THRI)
+		return;
+
+	lsr = serial_lsr_in(up);
+	if (!(lsr & UART_LSR_THRE))
+		return;
+
+	serial_port_out(p, UART_IER, up->ier | UART_IER_THRI);
+	serial_port_in(p, UART_LCR);		/* safe, no side-effects */
+	serial_port_out(p, UART_IER, up->ier);
+}
 
 static int dw8250_handle_irq(struct uart_port *p)
 {
@@ -281,7 +426,31 @@ static int dw8250_handle_irq(struct uart_port *p)
 	bool rx_timeout = (iir & 0x3f) == UART_IIR_RX_TIMEOUT;
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
-	unsigned long flags;
+
+	guard(uart_port_lock_irqsave)(p);
+
+	switch (FIELD_GET(DW_UART_IIR_IID, iir)) {
+	case UART_IIR_NO_INT:
+		if (d->uart_16550_compatible || up->dma)
+			return 0;
+
+		if (quirks & DW_UART_QUIRK_IER_KICK &&
+		    d->no_int_count == (DW_UART_QUIRK_IER_KICK_THRES - 1))
+			dw8250_quirk_ier_kick(p);
+		d->no_int_count = (d->no_int_count + 1) % DW_UART_QUIRK_IER_KICK_THRES;
+
+		return 0;
+
+	case UART_IIR_BUSY:
+		/* Clear the USR */
+		serial_port_in(p, d->pdata->usr_reg);
+
+		d->no_int_count = 0;
+
+		return 1;
+	}
+
+	d->no_int_count = 0;
 
 	/*
 	 * There are ways to get Designware-based UARTs into a state where
@@ -294,20 +463,15 @@ static int dw8250_handle_irq(struct uart_port *p)
 	 * so we limit the workaround only to non-DMA mode.
 	 */
 	if (!up->dma && rx_timeout) {
-		uart_port_lock_irqsave(p, &flags);
 		status = serial_lsr_in(up);
 
 		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
 			serial_port_in(p, UART_RX);
-
-		uart_port_unlock_irqrestore(p, flags);
 	}
 
 	/* Manually stop the Rx DMA transfer when acting as flow controller */
 	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
-		uart_port_lock_irqsave(p, &flags);
 		status = serial_lsr_in(up);
-		uart_port_unlock_irqrestore(p, flags);
 
 		if (status & (UART_LSR_DR | UART_LSR_BI)) {
 			dw8250_writel_ext(p, RZN1_UART_RDMACR, 0);
@@ -315,17 +479,9 @@ static int dw8250_handle_irq(struct uart_port *p)
 		}
 	}
 
-	if (serial8250_handle_irq(p, iir))
-		return 1;
-
-	if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
-		/* Clear the USR */
-		serial_port_in(p, d->pdata->usr_reg);
-
-		return 1;
-	}
+	serial8250_handle_irq_locked(p, iir);
 
-	return 0;
+	return 1;
 }
 
 static void dw8250_clk_work_cb(struct work_struct *work)
@@ -527,6 +683,14 @@ static void dw8250_reset_control_assert(void *data)
 	reset_control_assert(data);
 }
 
+static void dw8250_shutdown(struct uart_port *port)
+{
+	struct dw8250_data *d = to_dw8250_data(port->private_data);
+
+	serial8250_do_shutdown(port);
+	d->no_int_count = 0;
+}
+
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
@@ -545,8 +709,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->type		= PORT_8250;
 	p->flags	= UPF_FIXED_PORT;
 	p->dev		= dev;
+
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
+	p->set_divisor	= dw8250_set_divisor;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -650,10 +816,12 @@ static int dw8250_probe(struct platform_device *pdev)
 		dw8250_quirks(p, data);
 
 	/* If the Busy Functionality is not implemented, don't handle it */
-	if (data->uart_16550_compatible)
+	if (data->uart_16550_compatible) {
 		p->handle_irq = NULL;
-	else if (data->pdata)
+	} else if (data->pdata) {
 		p->handle_irq = dw8250_handle_irq;
+		p->shutdown = dw8250_shutdown;
+	}
 
 	dw8250_setup_dma_filter(p, data);
 
@@ -787,6 +955,11 @@ static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
 	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
 };
 
+static const struct dw8250_platform_data dw8250_intc10ee = {
+	.usr_reg = DW_UART_USR,
+	.quirks = DW_UART_QUIRK_IER_KICK,
+};
+
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
@@ -816,7 +989,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "INT33C5", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "INT3434", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "INT3435", (kernel_ulong_t)&dw8250_dw_apb },
-	{ "INTC10EE", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INTC10EE", (kernel_ulong_t)&dw8250_intc10ee },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
@@ -834,6 +1007,7 @@ static struct platform_driver dw8250_platform_driver = {
 
 module_platform_driver(dw8250_platform_driver);
 
+MODULE_IMPORT_NS("SERIAL_8250");
 MODULE_AUTHOR("Jamie Iles");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Synopsys DesignWare 8250 serial port driver");
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 3efe075ef7b2..a85ef082ca59 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -137,6 +137,8 @@ struct serial_private {
 };
 
 #define PCI_DEVICE_ID_HPE_PCI_SERIAL	0x37e
+#define PCIE_VENDOR_ID_ASIX		0x125B
+#define PCIE_DEVICE_ID_AX99100		0x9100
 
 static const struct pci_device_id pci_use_msi[] = {
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
@@ -149,6 +151,8 @@ static const struct pci_device_id pci_use_msi[] = {
 			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
 			 PCI_ANY_ID, PCI_ANY_ID) },
+	{ PCI_DEVICE_SUB(PCIE_VENDOR_ID_ASIX, PCIE_DEVICE_ID_AX99100,
+			 0xA000, 0x1000) },
 	{ }
 };
 
@@ -920,6 +924,7 @@ static int pci_netmos_init(struct pci_dev *dev)
 	case PCI_DEVICE_ID_NETMOS_9912:
 	case PCI_DEVICE_ID_NETMOS_9922:
 	case PCI_DEVICE_ID_NETMOS_9900:
+	case PCIE_DEVICE_ID_AX99100:
 		num_serial = pci_netmos_9900_numports(dev);
 		break;
 
@@ -2555,6 +2560,14 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.init		= pci_netmos_init,
 		.setup		= pci_netmos_9900_setup,
 	},
+	{
+		.vendor		= PCIE_VENDOR_ID_ASIX,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_netmos_init,
+		.setup		= pci_netmos_9900_setup,
+	},
 	/*
 	 * EndRun Technologies
 	*/
@@ -6076,6 +6089,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0xA000, 0x3002,
 		0, 0, pbn_NETMOS9900_2s_115200 },
 
+	{	PCIE_VENDOR_ID_ASIX, PCIE_DEVICE_ID_AX99100,
+		0xA000, 0x1000,
+		0, 0, pbn_b0_1_115200 },
+
 	/*
 	 * Best Connectivity and Rosewill PCI Multi I/O cards
 	 */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 719faf92aa8a..8785961a2a82 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -18,6 +18,7 @@
 #include <linux/irq.h>
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
+#include <linux/lockdep.h>
 #include <linux/sysrq.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
@@ -488,7 +489,7 @@ serial_port_out_sync(struct uart_port *p, int offset, int value)
 /*
  * FIFO support.
  */
-static void serial8250_clear_fifos(struct uart_8250_port *p)
+void serial8250_clear_fifos(struct uart_8250_port *p)
 {
 	if (p->capabilities & UART_CAP_FIFO) {
 		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO);
@@ -497,6 +498,7 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
 		serial_out(p, UART_FCR, 0);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(serial8250_clear_fifos, "SERIAL_8250");
 
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t);
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t);
@@ -1782,20 +1784,16 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 }
 
 /*
- * This handles the interrupt from one port.
+ * Context: port's lock must be held by the caller.
  */
-int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
+void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct tty_port *tport = &port->state->port;
 	bool skip_rx = false;
-	unsigned long flags;
 	u16 status;
 
-	if (iir & UART_IIR_NO_INT)
-		return 0;
-
-	uart_port_lock_irqsave(port, &flags);
+	lockdep_assert_held_once(&port->lock);
 
 	status = serial_lsr_in(up);
 
@@ -1828,8 +1826,19 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		else if (!up->dma->tx_running)
 			__stop_tx(up);
 	}
+}
+EXPORT_SYMBOL_NS_GPL(serial8250_handle_irq_locked, "SERIAL_8250");
+
+/*
+ * This handles the interrupt from one port.
+ */
+int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
+{
+	if (iir & UART_IIR_NO_INT)
+		return 0;
 
-	uart_unlock_and_check_sysrq_irqrestore(port, flags);
+	guard(uart_port_lock_irqsave)(port);
+	serial8250_handle_irq_locked(port, iir);
 
 	return 1;
 }
@@ -2147,8 +2156,7 @@ static void serial8250_THRE_test(struct uart_port *port)
 	if (up->port.flags & UPF_NO_THRE_TEST)
 		return;
 
-	if (port->irqflags & IRQF_SHARED)
-		disable_irq_nosync(port->irq);
+	disable_irq(port->irq);
 
 	/*
 	 * Test for UARTs that do not reassert THRE when the transmitter is idle and the interrupt
@@ -2170,8 +2178,7 @@ static void serial8250_THRE_test(struct uart_port *port)
 		serial_port_out(port, UART_IER, 0);
 	}
 
-	if (port->irqflags & IRQF_SHARED)
-		enable_irq(port->irq);
+	enable_irq(port->irq);
 
 	/*
 	 * If the interrupt is not reasserted, or we otherwise don't trust the iir, setup a timer to
@@ -2350,6 +2357,7 @@ static int serial8250_startup(struct uart_port *port)
 void serial8250_do_shutdown(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
+	u32 lcr;
 
 	serial8250_rpm_get(up);
 	/*
@@ -2376,13 +2384,13 @@ void serial8250_do_shutdown(struct uart_port *port)
 			port->mctrl &= ~TIOCM_OUT2;
 
 		serial8250_set_mctrl(port, port->mctrl);
+
+		/* Disable break condition */
+		lcr = serial_port_in(port, UART_LCR);
+		lcr &= ~UART_LCR_SBC;
+		serial_port_out(port, UART_LCR, lcr);
 	}
 
-	/*
-	 * Disable break condition and FIFOs
-	 */
-	serial_port_out(port, UART_LCR,
-			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
 	serial8250_clear_fifos(up);
 
 	rsa_disable(up);
@@ -2392,6 +2400,12 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 * the IRQ chain.
 	 */
 	serial_port_in(port, UART_RX);
+	/*
+	 * LCR writes on DW UART can trigger late (unmaskable) IRQs.
+	 * Handle them before releasing the handler.
+	 */
+	synchronize_irq(port->irq);
+
 	serial8250_rpm_put(up);
 
 	up->ops->release_irq(up);
@@ -3185,6 +3199,17 @@ void serial8250_set_defaults(struct uart_8250_port *up)
 }
 EXPORT_SYMBOL_GPL(serial8250_set_defaults);
 
+void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		if (wait_for_lsr(up, UART_LSR_THRE))
+			return;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(serial8250_fifo_wait_for_lsr_thre, "SERIAL_8250");
+
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
 static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
@@ -3226,16 +3251,6 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
 
-static void fifo_wait_for_lsr(struct uart_8250_port *up, unsigned int count)
-{
-	unsigned int i;
-
-	for (i = 0; i < count; i++) {
-		if (wait_for_lsr(up, UART_LSR_THRE))
-			return;
-	}
-}
-
 /*
  * Print a string to the serial port using the device FIFO
  *
@@ -3254,7 +3269,7 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 
 	while (s != end) {
 		/* Allow timeout for each byte of a possibly full FIFO */
-		fifo_wait_for_lsr(up, fifosize);
+		serial8250_fifo_wait_for_lsr_thre(up, fifosize);
 
 		for (i = 0; i < fifosize && s != end; ++i) {
 			if (*s == '\n' && !cr_sent) {
@@ -3272,7 +3287,7 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 	 * Allow timeout for each byte written since the caller will only wait
 	 * for UART_LSR_BOTH_EMPTY using the timeout of a single character
 	 */
-	fifo_wait_for_lsr(up, tx_count);
+	serial8250_fifo_wait_for_lsr_thre(up, tx_count);
 }
 
 /*
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2805cad10511..0b2edf185cc7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -643,7 +643,10 @@ static unsigned int uart_write_room(struct tty_struct *tty)
 	unsigned int ret;
 
 	port = uart_port_ref_lock(state, &flags);
-	ret = kfifo_avail(&state->port.xmit_fifo);
+	if (!state->port.xmit_buf)
+		ret = 0;
+	else
+		ret = kfifo_avail(&state->port.xmit_fifo);
 	uart_port_unlock_deref(port, flags);
 	return ret;
 }
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 39c1fd1ff9ce..6240c3d4dfd7 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -878,6 +878,7 @@ static int ulite_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 59b4b5e126ba..83a285577708 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1345,6 +1345,8 @@ struct vc_data *vc_deallocate(unsigned int currcons)
 			kfree(vc->vc_saved_screen);
 			vc->vc_saved_screen = NULL;
 		}
+		vc_uniscr_free(vc->vc_saved_uni_lines);
+		vc->vc_saved_uni_lines = NULL;
 	}
 	return vc;
 }
@@ -1890,6 +1892,8 @@ static void enter_alt_screen(struct vc_data *vc)
 	vc->vc_saved_screen = kmemdup((u16 *)vc->vc_origin, size, GFP_KERNEL);
 	if (vc->vc_saved_screen == NULL)
 		return;
+	vc->vc_saved_uni_lines = vc->vc_uni_lines;
+	vc->vc_uni_lines = NULL;
 	vc->vc_saved_rows = vc->vc_rows;
 	vc->vc_saved_cols = vc->vc_cols;
 	save_cur(vc);
@@ -1911,6 +1915,8 @@ static void leave_alt_screen(struct vc_data *vc)
 		dest = ((u16 *)vc->vc_origin) + r * vc->vc_cols;
 		memcpy(dest, src, 2 * cols);
 	}
+	vc_uniscr_set(vc, vc->vc_saved_uni_lines);
+	vc->vc_saved_uni_lines = NULL;
 	restore_cur(vc);
 	/* Update the entire screen */
 	if (con_should_update(vc))
@@ -2233,6 +2239,8 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	if (vc->vc_saved_screen != NULL) {
 		kfree(vc->vc_saved_screen);
 		vc->vc_saved_screen = NULL;
+		vc_uniscr_free(vc->vc_saved_uni_lines);
+		vc->vc_saved_uni_lines = NULL;
 		vc->vc_saved_rows = 0;
 		vc->vc_saved_cols = 0;
 	}
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index f52a457b302d..b8a546fe7c1e 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -12,6 +12,7 @@
 #include <linux/eventfd.h>
 #include <linux/file.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/poll.h>
@@ -30,7 +31,10 @@
 #include <linux/seq_file.h>
 #include <linux/miscdevice.h>
 #include <linux/moduleparam.h>
+#include <linux/notifier.h>
+#include <linux/security.h>
 #include <linux/virtio_mmio.h>
+#include <linux/wait.h>
 
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
@@ -46,6 +50,7 @@
 #include <xen/page.h>
 #include <xen/xen-ops.h>
 #include <xen/balloon.h>
+#include <xen/xenbus.h>
 #ifdef CONFIG_XEN_ACPI
 #include <xen/acpi.h>
 #endif
@@ -68,10 +73,20 @@ module_param_named(dm_op_buf_max_size, privcmd_dm_op_buf_max_size, uint,
 MODULE_PARM_DESC(dm_op_buf_max_size,
 		 "Maximum size of a dm_op hypercall buffer");
 
+static bool unrestricted;
+module_param(unrestricted, bool, 0);
+MODULE_PARM_DESC(unrestricted,
+	"Don't restrict hypercalls to target domain if running in a domU");
+
 struct privcmd_data {
 	domid_t domid;
 };
 
+/* DOMID_INVALID implies no restriction */
+static domid_t target_domain = DOMID_INVALID;
+static bool restrict_wait;
+static DECLARE_WAIT_QUEUE_HEAD(restrict_wait_wq);
+
 static int privcmd_vma_range_is_mapped(
                struct vm_area_struct *vma,
                unsigned long addr,
@@ -1562,13 +1577,16 @@ static long privcmd_ioctl(struct file *file,
 
 static int privcmd_open(struct inode *ino, struct file *file)
 {
-	struct privcmd_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
+	struct privcmd_data *data;
+
+	if (wait_event_interruptible(restrict_wait_wq, !restrict_wait) < 0)
+		return -EINTR;
 
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	/* DOMID_INVALID implies no restriction */
-	data->domid = DOMID_INVALID;
+	data->domid = target_domain;
 
 	file->private_data = data;
 	return 0;
@@ -1661,6 +1679,52 @@ static struct miscdevice privcmd_dev = {
 	.fops = &xen_privcmd_fops,
 };
 
+static int init_restrict(struct notifier_block *notifier,
+			 unsigned long event,
+			 void *data)
+{
+	char *target;
+	unsigned int domid;
+
+	/* Default to an guaranteed unused domain-id. */
+	target_domain = DOMID_IDLE;
+
+	target = xenbus_read(XBT_NIL, "target", "", NULL);
+	if (IS_ERR(target) || kstrtouint(target, 10, &domid)) {
+		pr_err("No target domain found, blocking all hypercalls\n");
+		goto out;
+	}
+
+	target_domain = domid;
+
+ out:
+	if (!IS_ERR(target))
+		kfree(target);
+
+	restrict_wait = false;
+	wake_up_all(&restrict_wait_wq);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block xenstore_notifier = {
+	.notifier_call = init_restrict,
+};
+
+static void __init restrict_driver(void)
+{
+	if (unrestricted) {
+		if (security_locked_down(LOCKDOWN_XEN_USER_ACTIONS))
+			pr_warn("Kernel is locked down, parameter \"unrestricted\" ignored\n");
+		else
+			return;
+	}
+
+	restrict_wait = true;
+
+	register_xenstore_notifier(&xenstore_notifier);
+}
+
 static int __init privcmd_init(void)
 {
 	int err;
@@ -1668,6 +1732,9 @@ static int __init privcmd_init(void)
 	if (!xen_domain())
 		return -ENODEV;
 
+	if (!xen_initial_domain())
+		restrict_driver();
+
 	err = misc_register(&privcmd_dev);
 	if (err != 0) {
 		pr_err("Could not register Xen privcmd device\n");
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 48fd2de3bca0..a3d4e6973b29 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -595,6 +595,12 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 #ifdef ELF_HWCAP2
 	nitems++;
 #endif
+#ifdef ELF_HWCAP3
+	nitems++;
+#endif
+#ifdef ELF_HWCAP4
+	nitems++;
+#endif
 
 	csp = sp;
 	sp -= nitems * 2 * sizeof(unsigned long);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 12d6ae49bc07..59794d726fd2 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1256,7 +1256,7 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	}
 	if (unlikely(btrfs_root_drop_level(&ri) >= BTRFS_MAX_LEVEL)) {
 		generic_err(leaf, slot,
-			    "invalid root level, have %u expect [0, %u]",
+			    "invalid root drop_level, have %u expect [0, %u]",
 			    btrfs_root_drop_level(&ri), BTRFS_MAX_LEVEL - 1);
 		return -EUCLEAN;
 	}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6cffcf0c3e7a..6c40f48cc194 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6195,6 +6195,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 				  struct btrfs_root *root,
 				  struct btrfs_log_ctx *ctx)
 {
+	const bool orig_log_new_dentries = ctx->log_new_dentries;
 	int ret = 0;
 
 	/*
@@ -6256,7 +6257,11 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 			 * dir index key range logged for the directory. So we
 			 * must make sure the deletion is recorded.
 			 */
+			ctx->log_new_dentries = false;
 			ret = btrfs_log_inode(trans, inode, LOG_INODE_ALL, ctx);
+			if (!ret && ctx->log_new_dentries)
+				ret = log_new_dir_dentries(trans, inode, ctx);
+
 			btrfs_add_delayed_iput(inode);
 			if (ret)
 				break;
@@ -6291,6 +6296,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 			break;
 	}
 
+	ctx->log_new_dentries = orig_log_new_dentries;
 	ctx->logging_conflict_inodes = false;
 	if (ret)
 		free_conflicting_inodes(ctx);
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 09fe268fe2c7..0d2feaab545b 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -36,19 +36,30 @@
  * second map contains a reference to the entry in the first map.
  */
 
+static struct workqueue_struct *nfsd_export_wq;
+
 #define	EXPKEY_HASHBITS		8
 #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
 #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
 
-static void expkey_put(struct kref *ref)
+static void expkey_release(struct work_struct *work)
 {
-	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
+	struct svc_expkey *key = container_of(to_rcu_work(work),
+					      struct svc_expkey, ek_rwork);
 
 	if (test_bit(CACHE_VALID, &key->h.flags) &&
 	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
 		path_put(&key->ek_path);
 	auth_domain_put(key->ek_client);
-	kfree_rcu(key, ek_rcu);
+	kfree(key);
+}
+
+static void expkey_put(struct kref *ref)
+{
+	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
+
+	INIT_RCU_WORK(&key->ek_rwork, expkey_release);
+	queue_rcu_work(nfsd_export_wq, &key->ek_rwork);
 }
 
 static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -353,11 +364,13 @@ static void export_stats_destroy(struct export_stats *stats)
 					    EXP_STATS_COUNTERS_NUM);
 }
 
-static void svc_export_release(struct rcu_head *rcu_head)
+static void svc_export_release(struct work_struct *work)
 {
-	struct svc_export *exp = container_of(rcu_head, struct svc_export,
-			ex_rcu);
+	struct svc_export *exp = container_of(to_rcu_work(work),
+					      struct svc_export, ex_rwork);
 
+	path_put(&exp->ex_path);
+	auth_domain_put(exp->ex_client);
 	nfsd4_fslocs_free(&exp->ex_fslocs);
 	export_stats_destroy(exp->ex_stats);
 	kfree(exp->ex_stats);
@@ -369,9 +382,8 @@ static void svc_export_put(struct kref *ref)
 {
 	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
 
-	path_put(&exp->ex_path);
-	auth_domain_put(exp->ex_client);
-	call_rcu(&exp->ex_rcu, svc_export_release);
+	INIT_RCU_WORK(&exp->ex_rwork, svc_export_release);
+	queue_rcu_work(nfsd_export_wq, &exp->ex_rwork);
 }
 
 static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -1480,6 +1492,36 @@ const struct seq_operations nfs_exports_op = {
 	.show	= e_show,
 };
 
+/**
+ * nfsd_export_wq_init - allocate the export release workqueue
+ *
+ * Called once at module load. The workqueue runs deferred svc_export and
+ * svc_expkey release work scheduled by queue_rcu_work() in the cache put
+ * callbacks.
+ *
+ * Return values:
+ *   %0: workqueue allocated
+ *   %-ENOMEM: allocation failed
+ */
+int nfsd_export_wq_init(void)
+{
+	nfsd_export_wq = alloc_workqueue("nfsd_export", WQ_UNBOUND, 0);
+	if (!nfsd_export_wq)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * nfsd_export_wq_shutdown - drain and free the export release workqueue
+ *
+ * Called once at module unload. Per-namespace teardown in
+ * nfsd_export_shutdown() has already drained all deferred work.
+ */
+void nfsd_export_wq_shutdown(void)
+{
+	destroy_workqueue(nfsd_export_wq);
+}
+
 /*
  * Initialize the exports module.
  */
@@ -1541,6 +1583,9 @@ nfsd_export_shutdown(struct net *net)
 
 	cache_unregister_net(nn->svc_expkey_cache, net);
 	cache_unregister_net(nn->svc_export_cache, net);
+	/* Drain deferred export and expkey release work. */
+	rcu_barrier();
+	flush_workqueue(nfsd_export_wq);
 	cache_destroy_net(nn->svc_expkey_cache, net);
 	cache_destroy_net(nn->svc_export_cache, net);
 	svcauth_unix_purge(net);
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index d2b09cd76145..b05399374574 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -7,6 +7,7 @@
 
 #include <linux/sunrpc/cache.h>
 #include <linux/percpu_counter.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/nfsd/export.h>
 #include <linux/nfs4.h>
 
@@ -75,7 +76,7 @@ struct svc_export {
 	u32			ex_layout_types;
 	struct nfsd4_deviceid_map *ex_devid_map;
 	struct cache_detail	*cd;
-	struct rcu_head		ex_rcu;
+	struct rcu_work		ex_rwork;
 	unsigned long		ex_xprtsec_modes;
 	struct export_stats	*ex_stats;
 };
@@ -92,7 +93,7 @@ struct svc_expkey {
 	u32			ek_fsid[6];
 
 	struct path		ek_path;
-	struct rcu_head		ek_rcu;
+	struct rcu_work		ek_rwork;
 };
 
 #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))
@@ -110,6 +111,8 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
 /*
  * Function declarations
  */
+int			nfsd_export_wq_init(void);
+void			nfsd_export_wq_shutdown(void);
 int			nfsd_export_init(struct net *);
 void			nfsd_export_shutdown(struct net *);
 void			nfsd_export_flush(struct net *);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5065727204b9..ddc6e4fb481e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5946,9 +5946,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 		int len = xdr->buf->len - (op_status_offset + XDR_UNIT);
 
 		so->so_replay.rp_status = op->status;
-		so->so_replay.rp_buflen = len;
-		read_bytes_from_xdr_buf(xdr->buf, op_status_offset + XDR_UNIT,
+		if (len <= NFSD4_REPLAY_ISIZE) {
+			so->so_replay.rp_buflen = len;
+			read_bytes_from_xdr_buf(xdr->buf,
+						op_status_offset + XDR_UNIT,
 						so->so_replay.rp_buf, len);
+		} else {
+			so->so_replay.rp_buflen = 0;
+		}
 	}
 status:
 	op->status = nfsd4_map_status(op->status,
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 85e3bd0e82ba..6b198e752821 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -149,9 +149,19 @@ static int exports_net_open(struct net *net, struct file *file)
 
 	seq = file->private_data;
 	seq->private = nn->svc_export_cache;
+	get_net(net);
 	return 0;
 }
 
+static int exports_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+	struct cache_detail *cd = seq->private;
+
+	put_net(cd->net);
+	return seq_release(inode, file);
+}
+
 static int exports_nfsd_open(struct inode *inode, struct file *file)
 {
 	return exports_net_open(inode->i_sb->s_fs_info, file);
@@ -161,7 +171,7 @@ static const struct file_operations exports_nfsd_operations = {
 	.open		= exports_nfsd_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= seq_release,
+	.release	= exports_release,
 };
 
 static int export_features_show(struct seq_file *m, void *v)
@@ -1375,7 +1385,7 @@ static const struct proc_ops exports_proc_ops = {
 	.proc_open	= exports_proc_open,
 	.proc_read	= seq_read,
 	.proc_lseek	= seq_lseek,
-	.proc_release	= seq_release,
+	.proc_release	= exports_release,
 };
 
 static int create_proc_exports_entry(void)
@@ -2252,9 +2262,12 @@ static int __init init_nfsd(void)
 	if (retval)
 		goto out_free_pnfs;
 	nfsd_lockd_init();	/* lockd->nfsd callbacks */
+	retval = nfsd_export_wq_init();
+	if (retval)
+		goto out_free_lockd;
 	retval = register_pernet_subsys(&nfsd_net_ops);
 	if (retval < 0)
-		goto out_free_lockd;
+		goto out_free_export_wq;
 	retval = register_cld_notifier();
 	if (retval)
 		goto out_free_subsys;
@@ -2283,6 +2296,8 @@ static int __init init_nfsd(void)
 	unregister_cld_notifier();
 out_free_subsys:
 	unregister_pernet_subsys(&nfsd_net_ops);
+out_free_export_wq:
+	nfsd_export_wq_shutdown();
 out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
@@ -2303,6 +2318,7 @@ static void __exit exit_nfsd(void)
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
+	nfsd_export_wq_shutdown();
 	nfsd_drc_slab_free();
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 508b7e36d846..97c5675cd1ca 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -541,11 +541,18 @@ struct nfs4_client_reclaim {
 	struct xdr_netobj	cr_princhash;
 };
 
-/* A reasonable value for REPLAY_ISIZE was estimated as follows:  
- * The OPEN response, typically the largest, requires 
- *   4(status) + 8(stateid) + 20(changeinfo) + 4(rflags) +  8(verifier) + 
- *   4(deleg. type) + 8(deleg. stateid) + 4(deleg. recall flag) + 
- *   20(deleg. space limit) + ~32(deleg. ace) = 112 bytes 
+/*
+ * REPLAY_ISIZE is sized for an OPEN response with delegation:
+ *   4(status) + 8(stateid) + 20(changeinfo) + 4(rflags) +
+ *   8(verifier) + 4(deleg. type) + 8(deleg. stateid) +
+ *   4(deleg. recall flag) + 20(deleg. space limit) +
+ *   ~32(deleg. ace) = 112 bytes
+ *
+ * Some responses can exceed this. A LOCK denial includes the conflicting
+ * lock owner, which can be up to 1024 bytes (NFS4_OPAQUE_LIMIT). Responses
+ * larger than REPLAY_ISIZE are not cached in rp_ibuf; only rp_status is
+ * saved. Enlarging this constant increases the size of every
+ * nfs4_stateowner.
  */
 
 #define NFSD4_REPLAY_ISIZE       112 
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index a3dc7cb1ab54..ce077a62da79 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -331,10 +331,14 @@ static void cifs_kill_sb(struct super_block *sb)
 
 	/*
 	 * We need to release all dentries for the cached directories
-	 * before we kill the sb.
+	 * and close all deferred file handles before we kill the sb.
 	 */
 	if (cifs_sb->root) {
 		close_all_cached_dirs(cifs_sb);
+		cifs_close_all_deferred_files_sb(cifs_sb);
+
+		/* Wait for all pending oplock breaks to complete */
+		flush_workqueue(cifsoplockd_wq);
 
 		/* finally release root dentry */
 		dput(cifs_sb->root);
@@ -865,7 +869,6 @@ static void cifs_umount_begin(struct super_block *sb)
 	spin_unlock(&tcon->tc_lock);
 	spin_unlock(&cifs_tcp_ses_lock);
 
-	cifs_close_all_deferred_files(tcon);
 	/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
 	/* cancel_notify_requests(tcon); */
 	if (tcon->ses && tcon->ses->server) {
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index f8c0615d4ee4..043cea4ff775 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -302,6 +302,7 @@ extern void cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode);
 
 extern void cifs_close_all_deferred_files(struct cifs_tcon *cifs_tcon);
 
+void cifs_close_all_deferred_files_sb(struct cifs_sb_info *cifs_sb);
 void cifs_close_deferred_file_under_dentry(struct cifs_tcon *cifs_tcon,
 					   struct dentry *dentry);
 
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 9d082f8bfa4a..97f7ef655120 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1952,6 +1952,10 @@ static int match_session(struct cifs_ses *ses,
 	case Kerberos:
 		if (!uid_eq(ctx->cred_uid, ses->cred_uid))
 			return 0;
+		if (strncmp(ses->user_name ?: "",
+			    ctx->username ?: "",
+			    CIFS_MAX_USERNAME_LEN))
+			return 0;
 		break;
 	case NTLMv2:
 	case RawNTLMSSP:
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 89dab96292de..c27a38843aa6 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -705,8 +705,6 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 	mutex_init(&cfile->fh_mutex);
 	spin_lock_init(&cfile->file_info_lock);
 
-	cifs_sb_active(inode->i_sb);
-
 	/*
 	 * If the server returned a read oplock and we have mandatory brlocks,
 	 * set oplock level to None.
@@ -761,7 +759,6 @@ static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
 	struct inode *inode = d_inode(cifs_file->dentry);
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifsLockInfo *li, *tmp;
-	struct super_block *sb = inode->i_sb;
 
 	/*
 	 * Delete any outstanding lock records. We'll lose them when the file
@@ -779,7 +776,6 @@ static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
 
 	cifs_put_tlink(cifs_file->tlink);
 	dput(cifs_file->dentry);
-	cifs_sb_deactive(sb);
 	kfree(cifs_file->symlink_target);
 	kfree(cifs_file);
 }
@@ -3151,12 +3147,6 @@ void cifs_oplock_break(struct work_struct *work)
 	__u64 persistent_fid, volatile_fid;
 	__u16 net_fid;
 
-	/*
-	 * Hold a reference to the superblock to prevent it and its inodes from
-	 * being freed while we are accessing cinode. Otherwise, _cifsFileInfo_put()
-	 * may release the last reference to the sb and trigger inode eviction.
-	 */
-	cifs_sb_active(sb);
 	wait_on_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS,
 			TASK_UNINTERRUPTIBLE);
 
@@ -3229,7 +3219,6 @@ void cifs_oplock_break(struct work_struct *work)
 	cifs_put_tlink(tlink);
 out:
 	cifs_done_oplock_break(cinode);
-	cifs_sb_deactive(sb);
 }
 
 static int cifs_swap_activate(struct swap_info_struct *sis,
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 9529fa385938..c841cfab1046 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -28,6 +28,11 @@
 #include "fs_context.h"
 #include "cached_dir.h"
 
+struct tcon_list {
+	struct list_head entry;
+	struct cifs_tcon *tcon;
+};
+
 /* The xid serves as a useful identifier for each incoming vfs request,
    in a similar way to the mid which is useful to track each sent smb,
    and CurrentXid can also provide a running counter (although it
@@ -840,6 +845,43 @@ cifs_close_all_deferred_files(struct cifs_tcon *tcon)
 	}
 }
 
+void cifs_close_all_deferred_files_sb(struct cifs_sb_info *cifs_sb)
+{
+	struct rb_root *root = &cifs_sb->tlink_tree;
+	struct rb_node *node;
+	struct cifs_tcon *tcon;
+	struct tcon_link *tlink;
+	struct tcon_list *tmp_list, *q;
+	LIST_HEAD(tcon_head);
+
+	spin_lock(&cifs_sb->tlink_tree_lock);
+	for (node = rb_first(root); node; node = rb_next(node)) {
+		tlink = rb_entry(node, struct tcon_link, tl_rbnode);
+		tcon = tlink_tcon(tlink);
+		if (IS_ERR(tcon))
+			continue;
+		tmp_list = kmalloc(sizeof(struct tcon_list), GFP_ATOMIC);
+		if (tmp_list == NULL)
+			break;
+		tmp_list->tcon = tcon;
+		/* Take a reference on tcon to prevent it from being freed */
+		spin_lock(&tcon->tc_lock);
+		++tcon->tc_count;
+		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+				    netfs_trace_tcon_ref_get_close_defer_files);
+		spin_unlock(&tcon->tc_lock);
+		list_add_tail(&tmp_list->entry, &tcon_head);
+	}
+	spin_unlock(&cifs_sb->tlink_tree_lock);
+
+	list_for_each_entry_safe(tmp_list, q, &tcon_head, entry) {
+		cifs_close_all_deferred_files(tmp_list->tcon);
+		list_del(&tmp_list->entry);
+		cifs_put_tcon(tmp_list->tcon, netfs_trace_tcon_ref_put_close_defer_files);
+		kfree(tmp_list);
+	}
+}
+
 void cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon,
 					   struct dentry *dentry)
 {
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 191f02344dcd..1e7167a23f5c 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -177,6 +177,7 @@
 	EM(netfs_trace_tcon_ref_get_cached_laundromat,	"GET Ch-Lau") \
 	EM(netfs_trace_tcon_ref_get_cached_lease_break,	"GET Ch-Lea") \
 	EM(netfs_trace_tcon_ref_get_cancelled_close,	"GET Cn-Cls") \
+	EM(netfs_trace_tcon_ref_get_close_defer_files,	"GET Cl-Def") \
 	EM(netfs_trace_tcon_ref_get_dfs_refer,		"GET DfsRef") \
 	EM(netfs_trace_tcon_ref_get_find,		"GET Find  ") \
 	EM(netfs_trace_tcon_ref_get_find_sess_tcon,	"GET FndSes") \
@@ -188,6 +189,7 @@
 	EM(netfs_trace_tcon_ref_put_cancelled_close,	"PUT Cn-Cls") \
 	EM(netfs_trace_tcon_ref_put_cancelled_close_fid, "PUT Cn-Fid") \
 	EM(netfs_trace_tcon_ref_put_cancelled_mid,	"PUT Cn-Mid") \
+	EM(netfs_trace_tcon_ref_put_close_defer_files,	"PUT Cl-Def") \
 	EM(netfs_trace_tcon_ref_put_mnt_ctx,		"PUT MntCtx") \
 	EM(netfs_trace_tcon_ref_put_dfs_refer,		"PUT DfsRfr") \
 	EM(netfs_trace_tcon_ref_put_reconnect_server,	"PUT Reconn") \
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index bfb75bad7266..8d18a97eed27 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -125,6 +125,8 @@ int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 			pr_err("The first operation in the compound does not have tcon\n");
 			return -EINVAL;
 		}
+		if (work->tcon->t_state != TREE_CONNECTED)
+			return -ENOENT;
 		if (tree_id != UINT_MAX && work->tcon->id != tree_id) {
 			pr_err("tree id(%u) is different with id(%u) in first operation\n",
 					tree_id, work->tcon->id);
@@ -1947,6 +1949,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			}
 		}
 		smb2_set_err_rsp(work);
+		conn->binding = false;
 	} else {
 		unsigned int iov_len;
 
@@ -2827,7 +2830,11 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 						goto out;
 					}
 
-					dh_info->fp->conn = conn;
+					if (dh_info->fp->conn) {
+						ksmbd_put_durable_fd(dh_info->fp);
+						err = -EBADF;
+						goto out;
+					}
 					dh_info->reconnected = true;
 					goto out;
 				}
@@ -5451,7 +5458,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 				    struct smb2_query_info_req *req,
 				    struct smb2_query_info_rsp *rsp)
 {
-	struct ksmbd_session *sess = work->sess;
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_share_config *share = work->tcon->share_conf;
 	int fsinfoclass = 0;
@@ -5588,10 +5594,11 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 
 		info = (struct object_id_info *)(rsp->Buffer);
 
-		if (!user_guest(sess->user))
-			memcpy(info->objid, user_passkey(sess->user), 16);
+		if (path.mnt->mnt_sb->s_uuid_len == 16)
+			memcpy(info->objid, path.mnt->mnt_sb->s_uuid.b,
+					path.mnt->mnt_sb->s_uuid_len);
 		else
-			memset(info->objid, 0, 16);
+			memcpy(info->objid, &stfs.f_fsid, sizeof(stfs.f_fsid));
 
 		info->extended_info.magic = cpu_to_le32(EXTENDED_INFO_MAGIC);
 		info->extended_info.version = cpu_to_le32(1);
diff --git a/fs/tests/exec_kunit.c b/fs/tests/exec_kunit.c
index f412d1a0f6bb..1c32cac098cf 100644
--- a/fs/tests/exec_kunit.c
+++ b/fs/tests/exec_kunit.c
@@ -94,9 +94,6 @@ static const struct bprm_stack_limits_result bprm_stack_limits_results[] = {
 	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * (_STK_LIM / 4 * 3 + sizeof(void *)),
 	    .argc = 0, .envc = 0 },
 	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
-	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * (_STK_LIM / 4 *  + sizeof(void *)),
-	    .argc = 0, .envc = 0 },
-	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
 	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * _STK_LIM,
 	    .argc = 0, .envc = 0 },
 	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index 407f7005e6d6..8bcb9b726262 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -4,6 +4,6 @@
 
 #include <uapi/linux/auxvec.h>
 
-#define AT_VECTOR_SIZE_BASE 22 /* NEW_AUX_ENT entries in auxiliary table */
+#define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
 #endif /* _LINUX_AUXVEC_H */
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 13b35637bd5a..d5ca855116df 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -160,6 +160,7 @@ struct vc_data {
 	struct uni_pagedict **uni_pagedict_loc; /* [!] Location of uni_pagedict variable for this console */
 	u32 **vc_uni_lines;			/* unicode screen content */
 	u16		*vc_saved_screen;
+	u32		**vc_saved_uni_lines;
 	unsigned int	vc_saved_cols;
 	unsigned int	vc_saved_rows;
 	/* additional information is in vt_kern.h */
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 9a1eacf35d37..df8f88f63a70 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -42,7 +42,8 @@ extern const struct header_ops eth_header_ops;
 
 int eth_header(struct sk_buff *skb, struct net_device *dev, unsigned short type,
 	       const void *daddr, const void *saddr, unsigned len);
-int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr);
+int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+		     unsigned char *haddr);
 int eth_header_cache(const struct neighbour *neigh, struct hh_cache *hh,
 		     __be16 type);
 void eth_header_cache_update(struct hh_cache *hh, const struct net_device *dev,
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index d290060f4c73..91013161e9db 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -68,12 +68,12 @@
  * timeout value used in Stratix10 FPGA manager driver.
  * timeout value used in RSU driver
  */
-#define SVC_RECONFIG_REQUEST_TIMEOUT_MS         300
-#define SVC_RECONFIG_BUFFER_TIMEOUT_MS          720
-#define SVC_RSU_REQUEST_TIMEOUT_MS              300
+#define SVC_RECONFIG_REQUEST_TIMEOUT_MS         5000
+#define SVC_RECONFIG_BUFFER_TIMEOUT_MS          5000
+#define SVC_RSU_REQUEST_TIMEOUT_MS              2000
 #define SVC_FCS_REQUEST_TIMEOUT_MS		2000
 #define SVC_COMPLETED_TIMEOUT_MS		30000
-#define SVC_HWMON_REQUEST_TIMEOUT_MS		300
+#define SVC_HWMON_REQUEST_TIMEOUT_MS		2000
 
 struct stratix10_svc_chan;
 
diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
index 61b7335aa037..ca9afa824aa4 100644
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -40,7 +40,8 @@ static inline struct ethhdr *inner_eth_hdr(const struct sk_buff *skb)
 	return (struct ethhdr *)skb_inner_mac_header(skb);
 }
 
-int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr);
+int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+		     unsigned char *haddr);
 
 extern ssize_t sysfs_format_mac(char *buf, const unsigned char *addr, int len);
 
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index f3a8a1306cf4..f69b31303764 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -524,6 +524,7 @@ enum {
 	REQ_F_BL_NO_RECYCLE_BIT,
 	REQ_F_BUFFERS_COMMIT_BIT,
 	REQ_F_BUF_NODE_BIT,
+	REQ_F_BUF_MORE_BIT,
 	REQ_F_HAS_METADATA_BIT,
 	REQ_F_IMPORT_BUFFER_BIT,
 	REQ_F_SQE_COPIED_BIT,
@@ -609,6 +610,8 @@ enum {
 	REQ_F_BUFFERS_COMMIT	= IO_REQ_FLAG(REQ_F_BUFFERS_COMMIT_BIT),
 	/* buf node is valid */
 	REQ_F_BUF_NODE		= IO_REQ_FLAG(REQ_F_BUF_NODE_BIT),
+	/* incremental buffer consumption, more space available */
+	REQ_F_BUF_MORE		= IO_REQ_FLAG(REQ_F_BUF_MORE_BIT),
 	/* request has read/write metadata assigned */
 	REQ_F_HAS_METADATA	= IO_REQ_FLAG(REQ_F_HAS_METADATA_BIT),
 	/*
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 65d85dc9c8f0..1216f050f069 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -311,7 +311,9 @@ struct header_ops {
 	int	(*create) (struct sk_buff *skb, struct net_device *dev,
 			   unsigned short type, const void *daddr,
 			   const void *saddr, unsigned int len);
-	int	(*parse)(const struct sk_buff *skb, unsigned char *haddr);
+	int	(*parse)(const struct sk_buff *skb,
+			 const struct net_device *dev,
+			 unsigned char *haddr);
 	int	(*cache)(const struct neighbour *neigh, struct hh_cache *hh, __be16 type);
 	void	(*cache_update)(struct hh_cache *hh,
 				const struct net_device *dev,
@@ -2153,6 +2155,7 @@ struct net_device {
 	unsigned long		state;
 	unsigned int		flags;
 	unsigned short		hard_header_len;
+	enum netdev_stat_type	pcpu_stat_type:8;
 	netdev_features_t	features;
 	struct inet6_dev __rcu	*ip6_ptr;
 	__cacheline_group_end(net_device_read_txrx);
@@ -2401,8 +2404,6 @@ struct net_device {
 	void				*ml_priv;
 	enum netdev_ml_priv_type	ml_priv_type;
 
-	enum netdev_stat_type		pcpu_stat_type:8;
-
 #if IS_ENABLED(CONFIG_GARP)
 	struct garp_port __rcu	*garp_port;
 #endif
@@ -3443,7 +3444,7 @@ static inline int dev_parse_header(const struct sk_buff *skb,
 
 	if (!dev->header_ops || !dev->header_ops->parse)
 		return 0;
-	return dev->header_ops->parse(skb, haddr);
+	return dev->header_ops->parse(skb, dev, haddr);
 }
 
 static inline __be16 dev_parse_header_protocol(const struct sk_buff *skb)
diff --git a/include/linux/security.h b/include/linux/security.h
index 83a646d72f6f..ee88dd2d2d1f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -145,6 +145,7 @@ enum lockdown_reason {
 	LOCKDOWN_BPF_WRITE_USER,
 	LOCKDOWN_DBG_WRITE_KERNEL,
 	LOCKDOWN_RTAS_ERROR_INJECTION,
+	LOCKDOWN_XEN_USER_ACTIONS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 01efdce0fda0..a95b2d143d24 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -195,6 +195,7 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
 void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 			       unsigned int quot);
 int fsl8250_handle_irq(struct uart_port *port);
+void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
 void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 80662f812080..1f577a4f8ce9 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -665,13 +665,29 @@ static inline int iptunnel_pull_offloads(struct sk_buff *skb)
 static inline void iptunnel_xmit_stats(struct net_device *dev, int pkt_len)
 {
 	if (pkt_len > 0) {
-		struct pcpu_sw_netstats *tstats = get_cpu_ptr(dev->tstats);
-
-		u64_stats_update_begin(&tstats->syncp);
-		u64_stats_add(&tstats->tx_bytes, pkt_len);
-		u64_stats_inc(&tstats->tx_packets);
-		u64_stats_update_end(&tstats->syncp);
-		put_cpu_ptr(tstats);
+		if (dev->pcpu_stat_type == NETDEV_PCPU_STAT_DSTATS) {
+			struct pcpu_dstats *dstats = get_cpu_ptr(dev->dstats);
+
+			u64_stats_update_begin(&dstats->syncp);
+			u64_stats_add(&dstats->tx_bytes, pkt_len);
+			u64_stats_inc(&dstats->tx_packets);
+			u64_stats_update_end(&dstats->syncp);
+			put_cpu_ptr(dstats);
+			return;
+		}
+		if (dev->pcpu_stat_type == NETDEV_PCPU_STAT_TSTATS) {
+			struct pcpu_sw_netstats *tstats = get_cpu_ptr(dev->tstats);
+
+			u64_stats_update_begin(&tstats->syncp);
+			u64_stats_add(&tstats->tx_bytes, pkt_len);
+			u64_stats_inc(&tstats->tx_packets);
+			u64_stats_update_end(&tstats->syncp);
+			put_cpu_ptr(tstats);
+			return;
+		}
+		pr_err_once("iptunnel_xmit_stats pcpu_stat_type=%d\n",
+			    dev->pcpu_stat_type);
+		WARN_ON_ONCE(1);
 		return;
 	}
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c2e49542626c..706f87c6d905 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7291,7 +7291,9 @@ void ieee80211_report_wowlan_wakeup(struct ieee80211_vif *vif,
  * @band: the band to transmit on
  * @sta: optional pointer to get the station to send the frame to
  *
- * Return: %true if the skb was prepared, %false otherwise
+ * Return: %true if the skb was prepared, %false otherwise.
+ * On failure, the skb is freed by this function; callers must not
+ * free it again.
  *
  * Note: must be called under RCU lock
  */
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index c18cffafc969..4dc080f7f27c 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -875,6 +875,8 @@ struct nft_elem_priv *nft_set_elem_init(const struct nft_set *set,
 					u64 timeout, u64 expiration, gfp_t gfp);
 int nft_set_elem_expr_clone(const struct nft_ctx *ctx, struct nft_set *set,
 			    struct nft_expr *expr_array[]);
+void nft_set_elem_expr_destroy(const struct nft_ctx *ctx,
+			       struct nft_set_elem_expr *elem_expr);
 void nft_set_elem_destroy(const struct nft_set *set,
 			  const struct nft_elem_priv *elem_priv,
 			  bool destroy_expr);
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d5d55cb21686..c3d657359a3d 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -716,6 +716,34 @@ void qdisc_destroy(struct Qdisc *qdisc);
 void qdisc_put(struct Qdisc *qdisc);
 void qdisc_put_unlocked(struct Qdisc *qdisc);
 void qdisc_tree_reduce_backlog(struct Qdisc *qdisc, int n, int len);
+
+static inline void dev_reset_queue(struct net_device *dev,
+				   struct netdev_queue *dev_queue,
+				   void *_unused)
+{
+	struct Qdisc *qdisc;
+	bool nolock;
+
+	qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
+	if (!qdisc)
+		return;
+
+	nolock = qdisc->flags & TCQ_F_NOLOCK;
+
+	if (nolock)
+		spin_lock_bh(&qdisc->seqlock);
+	spin_lock_bh(qdisc_lock(qdisc));
+
+	qdisc_reset(qdisc);
+
+	spin_unlock_bh(qdisc_lock(qdisc));
+	if (nolock) {
+		clear_bit(__QDISC_STATE_MISSED, &qdisc->state);
+		clear_bit(__QDISC_STATE_DRAINING, &qdisc->state);
+		spin_unlock_bh(&qdisc->seqlock);
+	}
+}
+
 #ifdef CONFIG_NET_SCHED
 int qdisc_offload_dump_helper(struct Qdisc *q, enum tc_setup_type type,
 			      void *type_data);
@@ -1429,6 +1457,11 @@ void mini_qdisc_pair_init(struct mini_Qdisc_pair *miniqp, struct Qdisc *qdisc,
 void mini_qdisc_pair_block_init(struct mini_Qdisc_pair *miniqp,
 				struct tcf_block *block);
 
+static inline bool mini_qdisc_pair_inited(struct mini_Qdisc_pair *miniqp)
+{
+	return !!miniqp->p_miniq;
+}
+
 void mq_change_real_num_tx(struct Qdisc *sch, unsigned int new_real_tx);
 
 int sch_frag_xmit_hook(struct sk_buff *skb, int (*xmit)(struct sk_buff *skb));
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 9acef2fbd2fd..d97ee26ba4f6 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -47,7 +47,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 static inline int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 				   struct socket **sockp)
 {
-	return 0;
+	return -EPFNOSUPPORT;
 }
 #endif
 
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index e7f444953dfb..f72f38d22d2b 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -34,6 +34,10 @@ struct io_provide_buf {
 
 static bool io_kbuf_inc_commit(struct io_buffer_list *bl, int len)
 {
+	/* No data consumed, return false early to avoid consuming the buffer */
+	if (!len)
+		return false;
+
 	while (len) {
 		struct io_uring_buf *buf;
 		u32 buf_len, this_len;
@@ -212,7 +216,8 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	sel.addr = u64_to_user_ptr(READ_ONCE(buf->addr));
 
 	if (io_should_commit(req, issue_flags)) {
-		io_kbuf_commit(req, sel.buf_list, *len, 1);
+		if (!io_kbuf_commit(req, sel.buf_list, *len, 1))
+			req->flags |= REQ_F_BUF_MORE;
 		sel.buf_list = NULL;
 	}
 	return sel;
@@ -345,7 +350,8 @@ int io_buffers_select(struct io_kiocb *req, struct buf_sel_arg *arg,
 		 */
 		if (ret > 0) {
 			req->flags |= REQ_F_BUFFERS_COMMIT | REQ_F_BL_NO_RECYCLE;
-			io_kbuf_commit(req, sel->buf_list, arg->out_len, ret);
+			if (!io_kbuf_commit(req, sel->buf_list, arg->out_len, ret))
+				req->flags |= REQ_F_BUF_MORE;
 		}
 	} else {
 		ret = io_provided_buffers_select(req, &arg->out_len, sel->buf_list, arg->iovs);
@@ -391,8 +397,10 @@ static inline bool __io_put_kbuf_ring(struct io_kiocb *req,
 
 	if (bl)
 		ret = io_kbuf_commit(req, bl, len, nr);
+	if (ret && (req->flags & REQ_F_BUF_MORE))
+		ret = false;
 
-	req->flags &= ~REQ_F_BUFFER_RING;
+	req->flags &= ~(REQ_F_BUFFER_RING | REQ_F_BUF_MORE);
 	return ret;
 }
 
diff --git a/io_uring/poll.c b/io_uring/poll.c
index aac4b3b881fb..488c08593b64 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -272,6 +272,7 @@ static int io_poll_check_events(struct io_kiocb *req, io_tw_token_t tw)
 				atomic_andnot(IO_POLL_RETRY_FLAG, &req->poll_refs);
 				v &= ~IO_POLL_RETRY_FLAG;
 			}
+			v &= IO_POLL_REF_MASK;
 		}
 
 		/* the mask was stashed in __io_poll_execute */
@@ -304,8 +305,13 @@ static int io_poll_check_events(struct io_kiocb *req, io_tw_token_t tw)
 				return IOU_POLL_REMOVE_POLL_USE_RES;
 			}
 		} else {
-			int ret = io_poll_issue(req, tw);
+			int ret;
 
+			/* multiple refs and HUP, ensure we loop once more */
+			if ((req->cqe.res & (POLLHUP | POLLRDHUP)) && v != 1)
+				v--;
+
+			ret = io_poll_issue(req, tw);
 			if (ret == IOU_COMPLETE)
 				return IOU_POLL_REMOVE_POLL_USE_RES;
 			else if (ret == IOU_REQUEUE)
@@ -321,7 +327,6 @@ static int io_poll_check_events(struct io_kiocb *req, io_tw_token_t tw)
 		 * Release all references, retry if someone tried to restart
 		 * task_work while we were executing it.
 		 */
-		v &= IO_POLL_REF_MASK;
 	} while (atomic_sub_return(v, &req->poll_refs) & IO_POLL_REF_MASK);
 
 	io_napi_add(req);
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index abb307a23de3..9501b0704f19 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -168,8 +168,8 @@ static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
 
 	memcpy(dm_key->data, ukp->data, ukp->datalen);
 	dm_key->key_size = ukp->datalen;
-	kexec_dprintk("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
-		      dm_key->key_desc, dm_key->data);
+	kexec_dprintk("Get dm crypt key (size=%u) %s\n", dm_key->key_size,
+		      dm_key->key_desc);
 
 out:
 	up_read(&key->sem);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 69c70d509e1c..8e00d95fb338 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	return cpuidle_enter(drv, dev, next_state);
 }
 
+static void idle_call_stop_or_retain_tick(bool stop_tick)
+{
+	if (stop_tick || tick_nohz_tick_stopped())
+		tick_nohz_idle_stop_tick();
+	else
+		tick_nohz_idle_retain_tick();
+}
+
 /**
  * cpuidle_idle_call - the main idle function
  *
@@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
  * set, and it returns with polling set.  If it ever stops polling, it
  * must clear the polling bit.
  */
-static void cpuidle_idle_call(void)
+static void cpuidle_idle_call(bool stop_tick)
 {
 	struct cpuidle_device *dev = cpuidle_get_device();
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
@@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
 	}
 
 	if (cpuidle_not_available(drv, dev)) {
-		tick_nohz_idle_stop_tick();
+		idle_call_stop_or_retain_tick(stop_tick);
 
 		default_idle_call();
 		goto exit_idle;
@@ -222,17 +230,19 @@ static void cpuidle_idle_call(void)
 		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
 		call_cpuidle(drv, dev, next_state);
 	} else if (drv->state_count > 1) {
-		bool stop_tick = true;
+		/*
+		 * stop_tick is expected to be true by default by cpuidle
+		 * governors, which allows them to select idle states with
+		 * target residency above the tick period length.
+		 */
+		stop_tick = true;
 
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
 		next_state = cpuidle_select(drv, dev, &stop_tick);
 
-		if (stop_tick || tick_nohz_tick_stopped())
-			tick_nohz_idle_stop_tick();
-		else
-			tick_nohz_idle_retain_tick();
+		idle_call_stop_or_retain_tick(stop_tick);
 
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
@@ -240,7 +250,7 @@ static void cpuidle_idle_call(void)
 		 */
 		cpuidle_reflect(dev, entered_state);
 	} else {
-		tick_nohz_idle_retain_tick();
+		idle_call_stop_or_retain_tick(stop_tick);
 
 		/*
 		 * If there is only a single idle state (or none), there is
@@ -268,6 +278,7 @@ static void cpuidle_idle_call(void)
 static void do_idle(void)
 {
 	int cpu = smp_processor_id();
+	bool got_tick = false;
 
 	/*
 	 * Check if we need to update blocked load
@@ -338,8 +349,9 @@ static void do_idle(void)
 			tick_nohz_idle_restart_tick();
 			cpu_idle_poll();
 		} else {
-			cpuidle_idle_call();
+			cpuidle_idle_call(got_tick);
 		}
+		got_tick = tick_nohz_idle_got_tick();
 		arch_cpu_idle_exit();
 	}
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 93f521b89aee..380791abeec5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2052,7 +2052,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 		entries += ret;
 		entry_bytes += local_read(&head_page->page->commit);
-		local_set(&cpu_buffer->head_page->entries, ret);
+		local_set(&head_page->entries, ret);
 
 		if (head_page == cpu_buffer->commit_page)
 			break;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 04c81fbf483f..906be54df83f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -567,7 +567,7 @@ static bool update_marker_trace(struct trace_array *tr, int enabled)
 	lockdep_assert_held(&event_mutex);
 
 	if (enabled) {
-		if (!list_empty(&tr->marker_list))
+		if (tr->trace_flags & TRACE_ITER(COPY_MARKER))
 			return false;
 
 		list_add_rcu(&tr->marker_list, &marker_copies);
@@ -575,10 +575,10 @@ static bool update_marker_trace(struct trace_array *tr, int enabled)
 		return true;
 	}
 
-	if (list_empty(&tr->marker_list))
+	if (!(tr->trace_flags & TRACE_ITER(COPY_MARKER)))
 		return false;
 
-	list_del_init(&tr->marker_list);
+	list_del_rcu(&tr->marker_list);
 	tr->trace_flags &= ~TRACE_ITER(COPY_MARKER);
 	return true;
 }
@@ -7545,6 +7545,23 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 	 */
 
 	do {
+		/*
+		 * It is possible that something is trying to migrate this
+		 * task. What happens then, is when preemption is enabled,
+		 * the migration thread will preempt this task, try to
+		 * migrate it, fail, then let it run again. That will
+		 * cause this to loop again and never succeed.
+		 * On failures, enabled and disable preemption with
+		 * migration enabled, to allow the migration thread to
+		 * migrate this task.
+		 */
+		if (trys) {
+			preempt_enable_notrace();
+			preempt_disable_notrace();
+			cpu = smp_processor_id();
+			buffer = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
+		}
+
 		/*
 		 * If for some reason, copy_from_user() always causes a context
 		 * switch, this would then cause an infinite loop.
@@ -10530,18 +10547,19 @@ static int __remove_instance(struct trace_array *tr)
 
 	list_del(&tr->list);
 
-	/* Disable all the flags that were enabled coming in */
-	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
-		if ((1ULL << i) & ZEROED_TRACE_FLAGS)
-			set_tracer_flag(tr, 1ULL << i, 0);
-	}
-
 	if (printk_trace == tr)
 		update_printk_trace(&global_trace);
 
+	/* Must be done before disabling all the flags */
 	if (update_marker_trace(tr, 0))
 		synchronize_rcu();
 
+	/* Disable all the flags that were enabled coming in */
+	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
+		if ((1ULL << i) & ZEROED_TRACE_FLAGS)
+			set_tracer_flag(tr, 1ULL << i, 0);
+	}
+
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 0728c4a95249..5d3802eba52a 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -712,7 +712,8 @@ static int __init xbc_parse_kv(char **k, char *v, int op)
 		if (op == ':') {
 			unsigned short nidx = child->next;
 
-			xbc_init_node(child, v, XBC_VALUE);
+			if (xbc_init_node(child, v, XBC_VALUE) < 0)
+				return xbc_parse_error("Failed to override value", v);
 			child->next = nidx;	/* keep subkeys */
 			goto array;
 		}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e3992314df9a..359616847364 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2797,7 +2797,8 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
 	} else {
 		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
-		_dst_pmd = folio_mk_pmd(src_folio, dst_vma->vm_page_prot);
+		_dst_pmd = move_soft_dirty_pmd(src_pmdval);
+		_dst_pmd = clear_uffd_wp_pmd(_dst_pmd);
 	}
 	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 7b9879ef442d..5b62b1da942e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1843,7 +1843,14 @@ static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
 	if (pte_unused(pte))
 		return 1;
 
-	return folio_pte_batch(folio, pvmw->pte, pte, max_nr);
+	/*
+	 * If unmap fails, we need to restore the ptes. To avoid accidentally
+	 * upgrading write permissions for ptes that were not originally
+	 * writable, and to avoid losing the soft-dirty bit, use the
+	 * appropriate FPB flags.
+	 */
+	return folio_pte_batch_flags(folio, vma, pvmw->pte, &pte, max_nr,
+				     FPB_RESPECT_WRITE | FPB_RESPECT_SOFT_DIRTY);
 }
 
 /*
@@ -2331,11 +2338,17 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			__maybe_unused pmd_t pmdval;
 
 			if (flags & TTU_SPLIT_HUGE_PMD) {
+				/*
+				 * split_huge_pmd_locked() might leave the
+				 * folio mapped through PTEs. Retry the walk
+				 * so we can detect this scenario and properly
+				 * abort the walk.
+				 */
 				split_huge_pmd_locked(vma, pvmw.address,
 						      pvmw.pmd, true);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				flags &= ~TTU_SPLIT_HUGE_PMD;
+				page_vma_mapped_walk_restart(&pvmw);
+				continue;
 			}
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 			pmdval = pmdp_get(pvmw.pmd);
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index b75c2228e69a..f28e9cbf8ad5 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -473,6 +473,9 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	if (aggregated_bytes > max_bytes)
 		return false;
 
+	if (skb_tailroom(forw_packet->skb) < packet_len)
+		return false;
+
 	if (packet_num >= BATADV_MAX_AGGREGATION_PACKETS)
 		return false;
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index dc085856f5e9..0f512c2c2fd3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1944,6 +1944,8 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 		return false;
 
 done:
+	conn->iso_qos = *qos;
+
 	if (hci_cmd_sync_queue(hdev, set_cig_params_sync,
 			       UINT_PTR(qos->ucast.cig), NULL) < 0)
 		return false;
@@ -2013,8 +2015,6 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 	}
 
 	hci_conn_hold(cis);
-
-	cis->iso_qos = *qos;
 	cis->state = BT_BOUND;
 
 	return cis;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 80b601e344ae..43b36581e336 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6596,8 +6596,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 	 * state.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-		hci_scan_disable_sync(hdev);
 		hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
+		hci_scan_disable_sync(hdev);
 	}
 
 	/* Update random address, but set require_privacy to false so
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 6724adce615b..e0e400381550 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -986,7 +986,8 @@ static void session_free(struct kref *ref)
 	skb_queue_purge(&session->intr_transmit);
 	fput(session->intr_sock->file);
 	fput(session->ctrl_sock->file);
-	l2cap_conn_put(session->conn);
+	if (session->conn)
+		l2cap_conn_put(session->conn);
 	kfree(session);
 }
 
@@ -1164,6 +1165,15 @@ static void hidp_session_remove(struct l2cap_conn *conn,
 
 	down_write(&hidp_session_sem);
 
+	/* Drop L2CAP reference immediately to indicate that
+	 * l2cap_unregister_user() shall not be called as it is already
+	 * considered removed.
+	 */
+	if (session->conn) {
+		l2cap_conn_put(session->conn);
+		session->conn = NULL;
+	}
+
 	hidp_session_terminate(session);
 
 	cancel_work_sync(&session->dev_init);
@@ -1301,7 +1311,9 @@ static int hidp_session_thread(void *arg)
 	 * Instead, this call has the same semantics as if user-space tried to
 	 * delete the session.
 	 */
-	l2cap_unregister_user(session->conn, &session->user);
+	if (session->conn)
+		l2cap_unregister_user(session->conn, &session->user);
+
 	hidp_session_put(session);
 
 	module_put_and_kthread_exit(0);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 72a4bb1fee46..9ea030fc9a9c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1686,17 +1686,15 @@ static void l2cap_info_timeout(struct work_struct *work)
 
 int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user)
 {
-	struct hci_dev *hdev = conn->hcon->hdev;
 	int ret;
 
 	/* We need to check whether l2cap_conn is registered. If it is not, we
-	 * must not register the l2cap_user. l2cap_conn_del() is unregisters
-	 * l2cap_conn objects, but doesn't provide its own locking. Instead, it
-	 * relies on the parent hci_conn object to be locked. This itself relies
-	 * on the hci_dev object to be locked. So we must lock the hci device
-	 * here, too. */
+	 * must not register the l2cap_user. l2cap_conn_del() unregisters
+	 * l2cap_conn objects under conn->lock, and we use the same lock here
+	 * to protect access to conn->users and conn->hchan.
+	 */
 
-	hci_dev_lock(hdev);
+	mutex_lock(&conn->lock);
 
 	if (!list_empty(&user->list)) {
 		ret = -EINVAL;
@@ -1717,16 +1715,14 @@ int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user)
 	ret = 0;
 
 out_unlock:
-	hci_dev_unlock(hdev);
+	mutex_unlock(&conn->lock);
 	return ret;
 }
 EXPORT_SYMBOL(l2cap_register_user);
 
 void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user)
 {
-	struct hci_dev *hdev = conn->hcon->hdev;
-
-	hci_dev_lock(hdev);
+	mutex_lock(&conn->lock);
 
 	if (list_empty(&user->list))
 		goto out_unlock;
@@ -1735,7 +1731,7 @@ void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user)
 	user->remove(conn, user);
 
 out_unlock:
-	hci_dev_unlock(hdev);
+	mutex_unlock(&conn->lock);
 }
 EXPORT_SYMBOL(l2cap_unregister_user);
 
@@ -4622,7 +4618,8 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn,
 
 	switch (type) {
 	case L2CAP_IT_FEAT_MASK:
-		conn->feat_mask = get_unaligned_le32(rsp->data);
+		if (cmd_len >= sizeof(*rsp) + sizeof(u32))
+			conn->feat_mask = get_unaligned_le32(rsp->data);
 
 		if (conn->feat_mask & L2CAP_FEAT_FIXED_CHAN) {
 			struct l2cap_info_req req;
@@ -4641,7 +4638,8 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_IT_FIXED_CHAN:
-		conn->remote_fixed_chan = rsp->data[0];
+		if (cmd_len >= sizeof(*rsp) + sizeof(rsp->data[0]))
+			conn->remote_fixed_chan = rsp->data[0];
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 		conn->info_ident = 0;
 
@@ -5043,7 +5041,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	u16 mtu, mps;
 	__le16 psm;
 	u8 result, rsp_len = 0;
-	int i, num_scid;
+	int i, num_scid = 0;
 	bool defer = false;
 
 	if (!enable_ecred)
@@ -5056,6 +5054,14 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto response;
 	}
 
+	/* Check if there are no pending channels with the same ident */
+	__l2cap_chan_list_id(conn, cmd->ident, l2cap_ecred_list_defer,
+			     &num_scid);
+	if (num_scid) {
+		result = L2CAP_CR_LE_INVALID_PARAMS;
+		goto response;
+	}
+
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
 
@@ -5408,7 +5414,7 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 					 u8 *data)
 {
 	struct l2cap_chan *chan, *tmp;
-	struct l2cap_ecred_conn_rsp *rsp = (void *) data;
+	struct l2cap_ecred_reconf_rsp *rsp = (void *)data;
 	u16 result;
 
 	if (cmd_len < sizeof(*rsp))
@@ -5416,7 +5422,7 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 
 	result = __le16_to_cpu(rsp->result);
 
-	BT_DBG("result 0x%4.4x", rsp->result);
+	BT_DBG("result 0x%4.4x", result);
 
 	if (!result)
 		return 0;
@@ -6644,8 +6650,10 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		return -ENOBUFS;
 	}
 
-	if (chan->imtu < skb->len) {
-		BT_ERR("Too big LE L2CAP PDU");
+	if (skb->len > chan->imtu) {
+		BT_ERR("Too big LE L2CAP PDU: len %u > %u", skb->len,
+		       chan->imtu);
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		return -ENOBUFS;
 	}
 
@@ -6671,7 +6679,9 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		       sdu_len, skb->len, chan->imtu);
 
 		if (sdu_len > chan->imtu) {
-			BT_ERR("Too big LE L2CAP SDU length received");
+			BT_ERR("Too big LE L2CAP SDU length: len %u > %u",
+			       skb->len, sdu_len);
+			l2cap_send_disconn_req(chan, ECONNRESET);
 			err = -EMSGSIZE;
 			goto failed;
 		}
@@ -6707,6 +6717,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	if (chan->sdu->len + skb->len > chan->sdu_len) {
 		BT_ERR("Too much LE L2CAP data received");
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		err = -EINVAL;
 		goto failed;
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0e46f9e08b10..2c63f49c3301 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2195,10 +2195,7 @@ static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
 	sk = cmd->sk;
 
 	if (status) {
-		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
-				status);
-		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev, true,
-				     cmd_status_rsp, &status);
+		mgmt_cmd_status(cmd->sk, hdev->id, cmd->opcode, status);
 		goto done;
 	}
 
@@ -5377,7 +5374,7 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
 
 	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
 			  mgmt_status(status), &rp, sizeof(rp));
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	hci_dev_unlock(hdev);
 	bt_dev_dbg(hdev, "add monitor %d complete, status %d",
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3a1ce04a7a53..9d9604074589 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2743,7 +2743,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
 	    !crypto_memneq(key, smp->local_pk, 64)) {
 		bt_dev_err(hdev, "Remote and local public keys are identical");
-		return SMP_UNSPECIFIED;
+		return SMP_DHKEY_CHECK_FAILED;
 	}
 
 	memcpy(smp->remote_pk, key, 64);
diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index c2c1c7d44c61..f4ca77d9b0e9 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -576,7 +576,7 @@ static void mep_delete_implementation(struct net_bridge *br,
 
 	/* Empty and free peer MEP list */
 	hlist_for_each_entry_safe(peer_mep, n_store, &mep->peer_mep_list, head) {
-		cancel_delayed_work_sync(&peer_mep->ccm_rx_dwork);
+		disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
 		hlist_del_rcu(&peer_mep->head);
 		kfree_rcu(peer_mep, rcu);
 	}
@@ -732,7 +732,7 @@ int br_cfm_cc_peer_mep_remove(struct net_bridge *br, const u32 instance,
 		return -ENOENT;
 	}
 
-	cc_peer_disable(peer_mep);
+	disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
 
 	hlist_del_rcu(&peer_mep->head);
 	kfree_rcu(peer_mep, rcu);
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 13a63b48b7ee..d9faadbe9b6c 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -193,14 +193,11 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 }
 EXPORT_SYMBOL(eth_type_trans);
 
-/**
- * eth_header_parse - extract hardware address from packet
- * @skb: packet to extract header from
- * @haddr: destination buffer
- */
-int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+		     unsigned char *haddr)
 {
 	const struct ethhdr *eth = eth_hdr(skb);
+
 	memcpy(haddr, eth->h_source, ETH_ALEN);
 	return ETH_ALEN;
 }
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 471dd862f663..e619b73f5063 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1067,10 +1067,12 @@ static void icmp_socket_deliver(struct sk_buff *skb, u32 info)
 
 static bool icmp_tag_validation(int proto)
 {
+	const struct net_protocol *ipprot;
 	bool ok;
 
 	rcu_read_lock();
-	ok = rcu_dereference(inet_protos[proto])->icmp_strict_tag_validation;
+	ipprot = rcu_dereference(inet_protos[proto]);
+	ok = ipprot ? ipprot->icmp_strict_tag_validation : false;
 	rcu_read_unlock();
 	return ok;
 }
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index e13244729ad8..35f0baa99d40 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -919,7 +919,8 @@ static int ipgre_header(struct sk_buff *skb, struct net_device *dev,
 	return -(t->hlen + sizeof(*iph));
 }
 
-static int ipgre_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+static int ipgre_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+			      unsigned char *haddr)
 {
 	const struct iphdr *iph = (const struct iphdr *) skb_mac_header(skb);
 	memcpy(haddr, &iph->saddr, 4);
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 310836a0cf17..1d509b6d16bb 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -379,6 +379,10 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 	hdr = (struct ipv6_sr_hdr *)skb_transport_header(skb);
 
 	idev = __in6_dev_get(skb->dev);
+	if (!idev) {
+		kfree_skb(skb);
+		return -1;
+	}
 
 	accept_seg6 = min(READ_ONCE(net->ipv6.devconf_all->seg6_enabled),
 			  READ_ONCE(idev->cnf.seg6_enabled));
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index ee6bac0160ac..e6964c6b0d38 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -184,6 +184,8 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	int require_hmac;
 
 	idev = __in6_dev_get(skb->dev);
+	if (!idev)
+		return false;
 
 	srh = (struct ipv6_sr_hdr *)skb_transport_header(skb);
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c81091a5cc3a..e480b48e8365 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1889,12 +1889,6 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	__sta_info_flush(sdata, true, link_id, NULL);
 
-	ieee80211_remove_link_keys(link, &keys);
-	if (!list_empty(&keys)) {
-		synchronize_net();
-		ieee80211_free_key_list(local, &keys);
-	}
-
 	ieee80211_stop_mbssid(sdata);
 	RCU_INIT_POINTER(link_conf->tx_bss_conf, NULL);
 
@@ -1906,6 +1900,12 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	ieee80211_link_info_change_notify(sdata, link,
 					  BSS_CHANGED_BEACON_ENABLED);
 
+	ieee80211_remove_link_keys(link, &keys);
+	if (!list_empty(&keys)) {
+		synchronize_net();
+		ieee80211_free_key_list(local, &keys);
+	}
+
 	if (sdata->wdev.links[link_id].cac_started) {
 		chandef = link_conf->chanreq.oper;
 		wiphy_delayed_work_cancel(wiphy, &link->dfs_cac_timer_work);
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index d8c5f11afc15..1b4bab698141 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -561,14 +561,16 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 	rcu_read_lock();
 	list_for_each_entry_rcu(sta, &local->sta_list,
 				list) {
-		struct ieee80211_sub_if_data *sdata = sta->sdata;
+		struct ieee80211_sub_if_data *sdata;
 		enum ieee80211_sta_rx_bandwidth new_sta_bw;
 		unsigned int link_id;
 
 		if (!ieee80211_sdata_running(sta->sdata))
 			continue;
 
-		for (link_id = 0; link_id < ARRAY_SIZE(sta->sdata->link); link_id++) {
+		sdata = get_bss_sdata(sta->sdata);
+
+		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
 			struct ieee80211_link_data *link =
 				rcu_dereference(sdata->link[link_id]);
 			struct ieee80211_bss_conf *link_conf;
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index d02f07368c51..687a66cd4943 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -320,7 +320,6 @@ static ssize_t aql_enable_read(struct file *file, char __user *user_buf,
 static ssize_t aql_enable_write(struct file *file, const char __user *user_buf,
 				size_t count, loff_t *ppos)
 {
-	bool aql_disabled = static_key_false(&aql_disable.key);
 	char buf[3];
 	size_t len;
 
@@ -335,15 +334,12 @@ static ssize_t aql_enable_write(struct file *file, const char __user *user_buf,
 	if (len > 0 && buf[len - 1] == '\n')
 		buf[len - 1] = 0;
 
-	if (buf[0] == '0' && buf[1] == '\0') {
-		if (!aql_disabled)
-			static_branch_inc(&aql_disable);
-	} else if (buf[0] == '1' && buf[1] == '\0') {
-		if (aql_disabled)
-			static_branch_dec(&aql_disable);
-	} else {
+	if (buf[0] == '0' && buf[1] == '\0')
+		static_branch_enable(&aql_disable);
+	else if (buf[0] == '1' && buf[1] == '\0')
+		static_branch_disable(&aql_disable);
+	else
 		return -EINVAL;
-	}
 
 	return count;
 }
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 129e814abe76..d7f691325746 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -79,6 +79,9 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 	 *   - MDA enabled
 	 * - Power management control on fc
 	 */
+	if (!ie->mesh_config)
+		return false;
+
 	if (!(ifmsh->mesh_id_len == ie->mesh_id_len &&
 	     memcmp(ifmsh->mesh_id, ie->mesh_id, ie->mesh_id_len) == 0 &&
 	     (ifmsh->mesh_pp_id == ie->mesh_config->meshconf_psel) &&
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 1a995bc301b1..b0d9bb830f29 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2759,7 +2759,9 @@ static void sta_set_link_sinfo(struct sta_info *sta,
 	}
 
 	link_sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, link_id));
+		jiffies_delta_to_msecs(jiffies -
+				       ieee80211_sta_last_active(sta,
+								 link_id));
 
 	if (!(link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 				    BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
@@ -2992,7 +2994,8 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	sinfo->connected_time = ktime_get_seconds() - sta->last_connected;
 	sinfo->assoc_at = sta->assoc_at;
 	sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, -1));
+		jiffies_delta_to_msecs(jiffies -
+				       ieee80211_sta_last_active(sta, -1));
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1b55e8340413..0692fbb6c489 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1898,8 +1898,10 @@ bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
 	struct ieee80211_tx_data tx;
 	struct sk_buff *skb2;
 
-	if (ieee80211_tx_prepare(sdata, &tx, NULL, skb) == TX_DROP)
+	if (ieee80211_tx_prepare(sdata, &tx, NULL, skb) == TX_DROP) {
+		kfree_skb(skb);
 		return false;
+	}
 
 	info->band = band;
 	info->control.vif = vif;
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 9e4631fade90..000be60d9580 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -469,7 +469,9 @@ static int mac802154_header_create(struct sk_buff *skb,
 }
 
 static int
-mac802154_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+mac802154_header_parse(const struct sk_buff *skb,
+		       const struct net_device *dev,
+		       unsigned char *haddr)
 {
 	struct ieee802154_hdr hdr;
 
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 580aac112dd2..c57f10e2ef26 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2854,6 +2854,7 @@ static int __init mpls_init(void)
 	rtnl_af_unregister(&mpls_af_ops);
 out_unregister_dev_type:
 	dev_remove_pack(&mpls_packet_type);
+	unregister_netdevice_notifier(&mpls_dev_notifier);
 out_unregister_pernet:
 	unregister_pernet_subsys(&mpls_net_ops);
 	goto out;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 0ef43993e15a..17eb50276e77 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -838,7 +838,7 @@ static struct lock_class_key mptcp_keys[2];
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = sk->sk_family == AF_INET6;
+	bool is_ipv6 = entry->addr.family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct sock *newsk, *ssk;
diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 46e667a50d98..248840dbca1b 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -170,7 +170,7 @@ static int bpf_nf_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
 
 static const struct bpf_link_ops bpf_nf_link_lops = {
 	.release = bpf_nf_link_release,
-	.dealloc = bpf_nf_link_dealloc,
+	.dealloc_deferred = bpf_nf_link_dealloc,
 	.detach = bpf_nf_link_detach,
 	.show_fdinfo = bpf_nf_link_show_info,
 	.fill_link_info = bpf_nf_link_fill_link_info,
diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index 62aa22a07876..7b1497ed97d2 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -331,6 +331,8 @@ static int decode_int(struct bitstr *bs, const struct field_t *f,
 		if (nf_h323_error_boundary(bs, 0, 2))
 			return H323_ERROR_BOUND;
 		len = get_bits(bs, 2) + 1;
+		if (nf_h323_error_boundary(bs, len, 0))
+			return H323_ERROR_BOUND;
 		BYTE_ALIGN(bs);
 		if (base && (f->attr & DECODE)) {	/* timeToLive */
 			unsigned int v = get_uint(bs, len) + f->lb;
@@ -922,6 +924,8 @@ int DecodeQ931(unsigned char *buf, size_t sz, Q931 *q931)
 				break;
 			p++;
 			len--;
+			if (len <= 0)
+				break;
 			return DecodeH323_UserInformation(buf, p, len,
 							  &q931->UUIE);
 		}
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 3a04665adf99..d9f33a6c807c 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3211,7 +3211,7 @@ ctnetlink_exp_ct_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct nfgenmsg *nfmsg = nlmsg_data(cb->nlh);
 	struct nf_conn *ct = cb->data;
-	struct nf_conn_help *help = nfct_help(ct);
+	struct nf_conn_help *help;
 	u_int8_t l3proto = nfmsg->nfgen_family;
 	unsigned long last_id = cb->args[1];
 	struct nf_conntrack_expect *exp;
@@ -3219,6 +3219,10 @@ ctnetlink_exp_ct_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 	if (cb->args[0])
 		return 0;
 
+	help = nfct_help(ct);
+	if (!help)
+		return 0;
+
 	rcu_read_lock();
 
 restart:
@@ -3248,6 +3252,24 @@ ctnetlink_exp_ct_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static int ctnetlink_dump_exp_ct_start(struct netlink_callback *cb)
+{
+	struct nf_conn *ct = cb->data;
+
+	if (!refcount_inc_not_zero(&ct->ct_general.use))
+		return -ENOENT;
+	return 0;
+}
+
+static int ctnetlink_dump_exp_ct_done(struct netlink_callback *cb)
+{
+	struct nf_conn *ct = cb->data;
+
+	if (ct)
+		nf_ct_put(ct);
+	return 0;
+}
+
 static int ctnetlink_dump_exp_ct(struct net *net, struct sock *ctnl,
 				 struct sk_buff *skb,
 				 const struct nlmsghdr *nlh,
@@ -3263,6 +3285,8 @@ static int ctnetlink_dump_exp_ct(struct net *net, struct sock *ctnl,
 	struct nf_conntrack_zone zone;
 	struct netlink_dump_control c = {
 		.dump = ctnetlink_exp_ct_dump_table,
+		.start = ctnetlink_dump_exp_ct_start,
+		.done = ctnetlink_dump_exp_ct_done,
 	};
 
 	err = ctnetlink_parse_tuple(cda, &tuple, CTA_EXPECT_MASTER,
@@ -3464,7 +3488,7 @@ ctnetlink_change_expect(struct nf_conntrack_expect *x,
 
 #if IS_ENABLED(CONFIG_NF_NAT)
 static const struct nla_policy exp_nat_nla_policy[CTA_EXPECT_NAT_MAX+1] = {
-	[CTA_EXPECT_NAT_DIR]	= { .type = NLA_U32 },
+	[CTA_EXPECT_NAT_DIR]	= NLA_POLICY_MAX(NLA_BE32, IP_CT_DIR_REPLY),
 	[CTA_EXPECT_NAT_TUPLE]	= { .type = NLA_NESTED },
 };
 #endif
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 7c6f7c9f7332..645d2c43ebf7 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -582,7 +582,8 @@ static int sctp_to_nlattr(struct sk_buff *skb, struct nlattr *nla,
 }
 
 static const struct nla_policy sctp_nla_policy[CTA_PROTOINFO_SCTP_MAX+1] = {
-	[CTA_PROTOINFO_SCTP_STATE]	    = { .type = NLA_U8 },
+	[CTA_PROTOINFO_SCTP_STATE]	    = NLA_POLICY_MAX(NLA_U8,
+							 SCTP_CONNTRACK_HEARTBEAT_SENT),
 	[CTA_PROTOINFO_SCTP_VTAG_ORIGINAL]  = { .type = NLA_U32 },
 	[CTA_PROTOINFO_SCTP_VTAG_REPLY]     = { .type = NLA_U32 },
 };
diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index ca748f8dbff1..4ab5ef71d96d 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -1534,11 +1534,12 @@ static int sip_help_tcp(struct sk_buff *skb, unsigned int protoff,
 {
 	struct tcphdr *th, _tcph;
 	unsigned int dataoff, datalen;
-	unsigned int matchoff, matchlen, clen;
+	unsigned int matchoff, matchlen;
 	unsigned int msglen, origlen;
 	const char *dptr, *end;
 	s16 diff, tdiff = 0;
 	int ret = NF_ACCEPT;
+	unsigned long clen;
 	bool term;
 
 	if (ctinfo != IP_CT_ESTABLISHED &&
@@ -1573,6 +1574,9 @@ static int sip_help_tcp(struct sk_buff *skb, unsigned int protoff,
 		if (dptr + matchoff == end)
 			break;
 
+		if (clen > datalen)
+			break;
+
 		term = false;
 		for (; end + strlen("\r\n\r\n") <= dptr + datalen; end++) {
 			if (end[0] == '\r' && end[1] == '\n' &&
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 78883343e5d6..458895e9e1f8 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -576,6 +576,7 @@ static int nf_flow_encap_push(struct sk_buff *skb,
 		switch (tuple->encap[i].proto) {
 		case htons(ETH_P_8021Q):
 		case htons(ETH_P_8021AD):
+			skb_reset_mac_header(skb);
 			if (skb_vlan_push(skb, tuple->encap[i].proto,
 					  tuple->encap[i].id) < 0)
 				return -1;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c9a76c760b17..fdbb1e20499b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6744,8 +6744,8 @@ static void __nft_set_elem_expr_destroy(const struct nft_ctx *ctx,
 	}
 }
 
-static void nft_set_elem_expr_destroy(const struct nft_ctx *ctx,
-				      struct nft_set_elem_expr *elem_expr)
+void nft_set_elem_expr_destroy(const struct nft_ctx *ctx,
+			       struct nft_set_elem_expr *elem_expr)
 {
 	struct nft_expr *expr;
 	u32 size;
@@ -9203,6 +9203,7 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 	return 0;
 
 err_flowtable_hooks:
+	synchronize_rcu();
 	nft_trans_destroy(trans);
 err_flowtable_trans:
 	nft_hooks_destroy(&flowtable->hook_list);
diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index c0fc431991e8..9fc9544d4bc5 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -302,7 +302,9 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
 {
 	struct nf_osf_user_finger *f;
 	struct nf_osf_finger *kf = NULL, *sf;
+	unsigned int tot_opt_len = 0;
 	int err = 0;
+	int i;
 
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
@@ -318,6 +320,17 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
 	if (f->opt_num > ARRAY_SIZE(f->opt))
 		return -EINVAL;
 
+	for (i = 0; i < f->opt_num; i++) {
+		if (!f->opt[i].length || f->opt[i].length > MAX_IPOPTLEN)
+			return -EINVAL;
+		if (f->opt[i].kind == OSFOPT_MSS && f->opt[i].length < 4)
+			return -EINVAL;
+
+		tot_opt_len += f->opt[i].length;
+		if (tot_opt_len > MAX_IPOPTLEN)
+			return -EINVAL;
+	}
+
 	if (!memchr(f->genre, 0, MAXGENRELEN) ||
 	    !memchr(f->subtype, 0, MAXGENRELEN) ||
 	    !memchr(f->version, 0, MAXGENRELEN))
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 6f2ae7cad731..db1bf69f8775 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -23,6 +23,7 @@
 #include <net/netfilter/nf_conntrack_l4proto.h>
 #include <net/netfilter/nf_conntrack_expect.h>
 #include <net/netfilter/nf_conntrack_seqadj.h>
+#include "nf_internals.h"
 
 struct nft_ct_helper_obj  {
 	struct nf_conntrack_helper *helper4;
@@ -543,6 +544,7 @@ static void __nft_ct_set_destroy(const struct nft_ctx *ctx, struct nft_ct *priv)
 #endif
 #ifdef CONFIG_NF_CONNTRACK_ZONES
 	case NFT_CT_ZONE:
+		nf_queue_nf_hook_drop(ctx->net);
 		mutex_lock(&nft_ct_pcpu_mutex);
 		if (--nft_ct_pcpu_template_refcnt == 0)
 			nft_ct_tmpl_put_pcpu();
@@ -1016,6 +1018,7 @@ static void nft_ct_timeout_obj_destroy(const struct nft_ctx *ctx,
 	struct nft_ct_timeout_obj *priv = nft_obj_data(obj);
 	struct nf_ct_timeout *timeout = priv->timeout;
 
+	nf_queue_nf_hook_drop(ctx->net);
 	nf_ct_untimeout(ctx->net, timeout);
 	nf_ct_netns_put(ctx->net, ctx->family);
 	kfree(priv->timeout);
@@ -1148,6 +1151,7 @@ static void nft_ct_helper_obj_destroy(const struct nft_ctx *ctx,
 {
 	struct nft_ct_helper_obj *priv = nft_obj_data(obj);
 
+	nf_queue_nf_hook_drop(ctx->net);
 	if (priv->helper4)
 		nf_conntrack_helper_put(priv->helper4);
 	if (priv->helper6)
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 7807d8129664..9123277be03c 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -30,18 +30,26 @@ static int nft_dynset_expr_setup(const struct nft_dynset *priv,
 				 const struct nft_set_ext *ext)
 {
 	struct nft_set_elem_expr *elem_expr = nft_set_ext_expr(ext);
+	struct nft_ctx ctx = {
+		.net	= read_pnet(&priv->set->net),
+		.family	= priv->set->table->family,
+	};
 	struct nft_expr *expr;
 	int i;
 
 	for (i = 0; i < priv->num_exprs; i++) {
 		expr = nft_setelem_expr_at(elem_expr, elem_expr->size);
 		if (nft_expr_clone(expr, priv->expr_array[i], GFP_ATOMIC) < 0)
-			return -1;
+			goto err_out;
 
 		elem_expr->size += priv->expr_array[i]->ops->size;
 	}
 
 	return 0;
+err_out:
+	nft_set_elem_expr_destroy(&ctx, elem_expr);
+
+	return -1;
 }
 
 struct nft_elem_priv *nft_dynset_new(struct nft_set *set,
diff --git a/net/netfilter/xt_CT.c b/net/netfilter/xt_CT.c
index 3ba94c34297c..498f5871c84a 100644
--- a/net/netfilter/xt_CT.c
+++ b/net/netfilter/xt_CT.c
@@ -16,6 +16,7 @@
 #include <net/netfilter/nf_conntrack_ecache.h>
 #include <net/netfilter/nf_conntrack_timeout.h>
 #include <net/netfilter/nf_conntrack_zones.h>
+#include "nf_internals.h"
 
 static inline int xt_ct_target(struct sk_buff *skb, struct nf_conn *ct)
 {
@@ -283,6 +284,9 @@ static void xt_ct_tg_destroy(const struct xt_tgdtor_param *par,
 	struct nf_conn_help *help;
 
 	if (ct) {
+		if (info->helper[0] || info->timeout[0])
+			nf_queue_nf_hook_drop(par->net);
+
 		help = nfct_help(ct);
 		xt_ct_put_helper(help);
 
diff --git a/net/netfilter/xt_time.c b/net/netfilter/xt_time.c
index 6aa12d0f54e2..61de85e02a40 100644
--- a/net/netfilter/xt_time.c
+++ b/net/netfilter/xt_time.c
@@ -227,13 +227,13 @@ time_mt(const struct sk_buff *skb, struct xt_action_param *par)
 
 	localtime_2(&current_time, stamp);
 
-	if (!(info->weekdays_match & (1 << current_time.weekday)))
+	if (!(info->weekdays_match & (1U << current_time.weekday)))
 		return false;
 
 	/* Do not spend time computing monthday if all days match anyway */
 	if (info->monthdays_match != XT_TIME_ALL_MONTHDAYS) {
 		localtime_3(&current_time, stamp);
-		if (!(info->monthdays_match & (1 << current_time.monthday)))
+		if (!(info->monthdays_match & (1U << current_time.monthday)))
 			return false;
 	}
 
diff --git a/net/phonet/af_phonet.c b/net/phonet/af_phonet.c
index 238a9638d2b0..d89225d6bfd3 100644
--- a/net/phonet/af_phonet.c
+++ b/net/phonet/af_phonet.c
@@ -129,9 +129,12 @@ static int pn_header_create(struct sk_buff *skb, struct net_device *dev,
 	return 1;
 }
 
-static int pn_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+static int pn_header_parse(const struct sk_buff *skb,
+			   const struct net_device *dev,
+			   unsigned char *haddr)
 {
 	const u8 *media = skb_mac_header(skb);
+
 	*haddr = *media;
 	return 1;
 }
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index c0f5a515a8ce..de18af4e4066 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -811,6 +811,11 @@ static int rose_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 		goto out_release;
 	}
 
+	if (sk->sk_state == TCP_SYN_SENT) {
+		err = -EALREADY;
+		goto out_release;
+	}
+
 	sk->sk_state   = TCP_CLOSE;
 	sock->state = SS_UNCONNECTED;
 
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 852e603c1755..8b07d194c4c3 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1290,33 +1290,6 @@ static void dev_deactivate_queue(struct net_device *dev,
 	}
 }
 
-static void dev_reset_queue(struct net_device *dev,
-			    struct netdev_queue *dev_queue,
-			    void *_unused)
-{
-	struct Qdisc *qdisc;
-	bool nolock;
-
-	qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
-	if (!qdisc)
-		return;
-
-	nolock = qdisc->flags & TCQ_F_NOLOCK;
-
-	if (nolock)
-		spin_lock_bh(&qdisc->seqlock);
-	spin_lock_bh(qdisc_lock(qdisc));
-
-	qdisc_reset(qdisc);
-
-	spin_unlock_bh(qdisc_lock(qdisc));
-	if (nolock) {
-		clear_bit(__QDISC_STATE_MISSED, &qdisc->state);
-		clear_bit(__QDISC_STATE_DRAINING, &qdisc->state);
-		spin_unlock_bh(&qdisc->seqlock);
-	}
-}
-
 static bool some_qdisc_is_busy(struct net_device *dev)
 {
 	unsigned int i;
diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index cc6051d4f2ef..c3e18bae8fbf 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -113,14 +113,15 @@ static void ingress_destroy(struct Qdisc *sch)
 {
 	struct ingress_sched_data *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
-	struct bpf_mprog_entry *entry = rtnl_dereference(dev->tcx_ingress);
+	struct bpf_mprog_entry *entry;
 
 	if (sch->parent != TC_H_INGRESS)
 		return;
 
 	tcf_block_put_ext(q->block, sch, &q->block_info);
 
-	if (entry) {
+	if (mini_qdisc_pair_inited(&q->miniqp)) {
+		entry = rtnl_dereference(dev->tcx_ingress);
 		tcx_miniq_dec(entry);
 		if (!tcx_entry_is_active(entry)) {
 			tcx_entry_update(dev, NULL, true);
@@ -290,10 +291,9 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
 
 static void clsact_destroy(struct Qdisc *sch)
 {
+	struct bpf_mprog_entry *ingress_entry, *egress_entry;
 	struct clsact_sched_data *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
-	struct bpf_mprog_entry *ingress_entry = rtnl_dereference(dev->tcx_ingress);
-	struct bpf_mprog_entry *egress_entry = rtnl_dereference(dev->tcx_egress);
 
 	if (sch->parent != TC_H_CLSACT)
 		return;
@@ -301,7 +301,8 @@ static void clsact_destroy(struct Qdisc *sch)
 	tcf_block_put_ext(q->ingress_block, sch, &q->ingress_block_info);
 	tcf_block_put_ext(q->egress_block, sch, &q->egress_block_info);
 
-	if (ingress_entry) {
+	if (mini_qdisc_pair_inited(&q->miniqp_ingress)) {
+		ingress_entry = rtnl_dereference(dev->tcx_ingress);
 		tcx_miniq_dec(ingress_entry);
 		if (!tcx_entry_is_active(ingress_entry)) {
 			tcx_entry_update(dev, NULL, true);
@@ -309,7 +310,8 @@ static void clsact_destroy(struct Qdisc *sch)
 		}
 	}
 
-	if (egress_entry) {
+	if (mini_qdisc_pair_inited(&q->miniqp_egress)) {
+		egress_entry = rtnl_dereference(dev->tcx_egress);
 		tcx_miniq_dec(egress_entry);
 		if (!tcx_entry_is_active(egress_entry)) {
 			tcx_entry_update(dev, NULL, false);
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 783300d8b019..ec4039a201a2 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -146,15 +146,12 @@ teql_destroy(struct Qdisc *sch)
 					master->slaves = NEXT_SLAVE(q);
 					if (q == master->slaves) {
 						struct netdev_queue *txq;
-						spinlock_t *root_lock;
 
 						txq = netdev_get_tx_queue(master->dev, 0);
 						master->slaves = NULL;
 
-						root_lock = qdisc_root_sleeping_lock(rtnl_dereference(txq->qdisc));
-						spin_lock_bh(root_lock);
-						qdisc_reset(rtnl_dereference(txq->qdisc));
-						spin_unlock_bh(root_lock);
+						dev_reset_queue(master->dev,
+								txq, NULL);
 					}
 				}
 				skb_queue_purge(&dat->q);
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 318a0567a698..be9999ab62e3 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -36,29 +36,26 @@ static struct net_shaper_binding *net_shaper_binding_from_ctx(void *ctx)
 	return &((struct net_shaper_nl_ctx *)ctx)->binding;
 }
 
-static void net_shaper_lock(struct net_shaper_binding *binding)
+static struct net_shaper_hierarchy *
+net_shaper_hierarchy(struct net_shaper_binding *binding)
 {
-	switch (binding->type) {
-	case NET_SHAPER_BINDING_TYPE_NETDEV:
-		netdev_lock(binding->netdev);
-		break;
-	}
-}
+	/* Pairs with WRITE_ONCE() in net_shaper_hierarchy_setup. */
+	if (binding->type == NET_SHAPER_BINDING_TYPE_NETDEV)
+		return READ_ONCE(binding->netdev->net_shaper_hierarchy);
 
-static void net_shaper_unlock(struct net_shaper_binding *binding)
-{
-	switch (binding->type) {
-	case NET_SHAPER_BINDING_TYPE_NETDEV:
-		netdev_unlock(binding->netdev);
-		break;
-	}
+	/* No other type supported yet. */
+	return NULL;
 }
 
 static struct net_shaper_hierarchy *
-net_shaper_hierarchy(struct net_shaper_binding *binding)
+net_shaper_hierarchy_rcu(struct net_shaper_binding *binding)
 {
-	/* Pairs with WRITE_ONCE() in net_shaper_hierarchy_setup. */
-	if (binding->type == NET_SHAPER_BINDING_TYPE_NETDEV)
+	/* Readers look up the device and take a ref, then take RCU lock
+	 * later at which point netdev may have been unregistered and flushed.
+	 * READ_ONCE() pairs with WRITE_ONCE() in net_shaper_hierarchy_setup.
+	 */
+	if (binding->type == NET_SHAPER_BINDING_TYPE_NETDEV &&
+	    READ_ONCE(binding->netdev->reg_state) <= NETREG_REGISTERED)
 		return READ_ONCE(binding->netdev->net_shaper_hierarchy);
 
 	/* No other type supported yet. */
@@ -204,12 +201,49 @@ static int net_shaper_ctx_setup(const struct genl_info *info, int type,
 	return 0;
 }
 
+/* Like net_shaper_ctx_setup(), but for "write" handlers (never for dumps!)
+ * Acquires the lock protecting the hierarchy (instance lock for netdev).
+ */
+static int net_shaper_ctx_setup_lock(const struct genl_info *info, int type,
+				     struct net_shaper_nl_ctx *ctx)
+{
+	struct net *ns = genl_info_net(info);
+	struct net_device *dev;
+	int ifindex;
+
+	if (GENL_REQ_ATTR_CHECK(info, type))
+		return -EINVAL;
+
+	ifindex = nla_get_u32(info->attrs[type]);
+	dev = netdev_get_by_index_lock(ns, ifindex);
+	if (!dev) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[type]);
+		return -ENOENT;
+	}
+
+	if (!dev->netdev_ops->net_shaper_ops) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[type]);
+		netdev_unlock(dev);
+		return -EOPNOTSUPP;
+	}
+
+	ctx->binding.type = NET_SHAPER_BINDING_TYPE_NETDEV;
+	ctx->binding.netdev = dev;
+	return 0;
+}
+
 static void net_shaper_ctx_cleanup(struct net_shaper_nl_ctx *ctx)
 {
 	if (ctx->binding.type == NET_SHAPER_BINDING_TYPE_NETDEV)
 		netdev_put(ctx->binding.netdev, &ctx->dev_tracker);
 }
 
+static void net_shaper_ctx_cleanup_unlock(struct net_shaper_nl_ctx *ctx)
+{
+	if (ctx->binding.type == NET_SHAPER_BINDING_TYPE_NETDEV)
+		netdev_unlock(ctx->binding.netdev);
+}
+
 static u32 net_shaper_handle_to_index(const struct net_shaper_handle *handle)
 {
 	return FIELD_PREP(NET_SHAPER_SCOPE_MASK, handle->scope) |
@@ -251,9 +285,10 @@ static struct net_shaper *
 net_shaper_lookup(struct net_shaper_binding *binding,
 		  const struct net_shaper_handle *handle)
 {
-	struct net_shaper_hierarchy *hierarchy = net_shaper_hierarchy(binding);
 	u32 index = net_shaper_handle_to_index(handle);
+	struct net_shaper_hierarchy *hierarchy;
 
+	hierarchy = net_shaper_hierarchy_rcu(binding);
 	if (!hierarchy || xa_get_mark(&hierarchy->shapers, index,
 				      NET_SHAPER_NOT_VALID))
 		return NULL;
@@ -262,7 +297,7 @@ net_shaper_lookup(struct net_shaper_binding *binding,
 }
 
 /* Allocate on demand the per device shaper's hierarchy container.
- * Called under the net shaper lock
+ * Called under the lock protecting the hierarchy (instance lock for netdev)
  */
 static struct net_shaper_hierarchy *
 net_shaper_hierarchy_setup(struct net_shaper_binding *binding)
@@ -681,6 +716,22 @@ void net_shaper_nl_post_doit(const struct genl_split_ops *ops,
 	net_shaper_generic_post(info);
 }
 
+int net_shaper_nl_pre_doit_write(const struct genl_split_ops *ops,
+				struct sk_buff *skb, struct genl_info *info)
+{
+	struct net_shaper_nl_ctx *ctx = (struct net_shaper_nl_ctx *)info->ctx;
+
+	BUILD_BUG_ON(sizeof(*ctx) > sizeof(info->ctx));
+
+	return net_shaper_ctx_setup_lock(info, NET_SHAPER_A_IFINDEX, ctx);
+}
+
+void net_shaper_nl_post_doit_write(const struct genl_split_ops *ops,
+				   struct sk_buff *skb, struct genl_info *info)
+{
+	net_shaper_ctx_cleanup_unlock((struct net_shaper_nl_ctx *)info->ctx);
+}
+
 int net_shaper_nl_pre_dumpit(struct netlink_callback *cb)
 {
 	struct net_shaper_nl_ctx *ctx = (struct net_shaper_nl_ctx *)cb->ctx;
@@ -778,17 +829,19 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
 
 	/* Don't error out dumps performed before any set operation. */
 	binding = net_shaper_binding_from_ctx(ctx);
-	hierarchy = net_shaper_hierarchy(binding);
-	if (!hierarchy)
-		return 0;
 
 	rcu_read_lock();
+	hierarchy = net_shaper_hierarchy_rcu(binding);
+	if (!hierarchy)
+		goto out_unlock;
+
 	for (; (shaper = xa_find(&hierarchy->shapers, &ctx->start_index,
 				 U32_MAX, XA_PRESENT)); ctx->start_index++) {
 		ret = net_shaper_fill_one(skb, binding, shaper, info);
 		if (ret)
 			break;
 	}
+out_unlock:
 	rcu_read_unlock();
 
 	return ret;
@@ -806,45 +859,38 @@ int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	binding = net_shaper_binding_from_ctx(info->ctx);
 
-	net_shaper_lock(binding);
 	ret = net_shaper_parse_info(binding, info->attrs, info, &shaper,
 				    &exists);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	if (!exists)
 		net_shaper_default_parent(&shaper.handle, &shaper.parent);
 
 	hierarchy = net_shaper_hierarchy_setup(binding);
-	if (!hierarchy) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	if (!hierarchy)
+		return -ENOMEM;
 
 	/* The 'set' operation can't create node-scope shapers. */
 	handle = shaper.handle;
 	if (handle.scope == NET_SHAPER_SCOPE_NODE &&
-	    !net_shaper_lookup(binding, &handle)) {
-		ret = -ENOENT;
-		goto unlock;
-	}
+	    !net_shaper_lookup(binding, &handle))
+		return -ENOENT;
 
 	ret = net_shaper_pre_insert(binding, &handle, info->extack);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	ops = net_shaper_ops(binding);
 	ret = ops->set(binding, &shaper, info->extack);
 	if (ret) {
 		net_shaper_rollback(binding);
-		goto unlock;
+		return ret;
 	}
 
 	net_shaper_commit(binding, 1, &shaper);
 
-unlock:
-	net_shaper_unlock(binding);
-	return ret;
+	return 0;
 }
 
 static int __net_shaper_delete(struct net_shaper_binding *binding,
@@ -1073,35 +1119,26 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 
 	binding = net_shaper_binding_from_ctx(info->ctx);
 
-	net_shaper_lock(binding);
 	ret = net_shaper_parse_handle(info->attrs[NET_SHAPER_A_HANDLE], info,
 				      &handle);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	hierarchy = net_shaper_hierarchy(binding);
-	if (!hierarchy) {
-		ret = -ENOENT;
-		goto unlock;
-	}
+	if (!hierarchy)
+		return -ENOENT;
 
 	shaper = net_shaper_lookup(binding, &handle);
-	if (!shaper) {
-		ret = -ENOENT;
-		goto unlock;
-	}
+	if (!shaper)
+		return -ENOENT;
 
 	if (handle.scope == NET_SHAPER_SCOPE_NODE) {
 		ret = net_shaper_pre_del_node(binding, shaper, info->extack);
 		if (ret)
-			goto unlock;
+			return ret;
 	}
 
-	ret = __net_shaper_delete(binding, shaper, info->extack);
-
-unlock:
-	net_shaper_unlock(binding);
-	return ret;
+	return __net_shaper_delete(binding, shaper, info->extack);
 }
 
 static int net_shaper_group_send_reply(struct net_shaper_binding *binding,
@@ -1150,21 +1187,17 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!net_shaper_ops(binding)->group)
 		return -EOPNOTSUPP;
 
-	net_shaper_lock(binding);
 	leaves_count = net_shaper_list_len(info, NET_SHAPER_A_LEAVES);
 	if (!leaves_count) {
 		NL_SET_BAD_ATTR(info->extack,
 				info->attrs[NET_SHAPER_A_LEAVES]);
-		ret = -EINVAL;
-		goto unlock;
+		return -EINVAL;
 	}
 
 	leaves = kcalloc(leaves_count, sizeof(struct net_shaper) +
 			 sizeof(struct net_shaper *), GFP_KERNEL);
-	if (!leaves) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	if (!leaves)
+		return -ENOMEM;
 	old_nodes = (void *)&leaves[leaves_count];
 
 	ret = net_shaper_parse_node(binding, info->attrs, info, &node);
@@ -1241,9 +1274,6 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 
 free_leaves:
 	kfree(leaves);
-
-unlock:
-	net_shaper_unlock(binding);
 	return ret;
 
 free_msg:
@@ -1353,14 +1383,12 @@ static void net_shaper_flush(struct net_shaper_binding *binding)
 	if (!hierarchy)
 		return;
 
-	net_shaper_lock(binding);
 	xa_lock(&hierarchy->shapers);
 	xa_for_each(&hierarchy->shapers, index, cur) {
 		__xa_erase(&hierarchy->shapers, index);
 		kfree(cur);
 	}
 	xa_unlock(&hierarchy->shapers);
-	net_shaper_unlock(binding);
 
 	kfree(hierarchy);
 }
diff --git a/net/shaper/shaper_nl_gen.c b/net/shaper/shaper_nl_gen.c
index e8cccc4c1180..9b29be3ef19a 100644
--- a/net/shaper/shaper_nl_gen.c
+++ b/net/shaper/shaper_nl_gen.c
@@ -99,27 +99,27 @@ static const struct genl_split_ops net_shaper_nl_ops[] = {
 	},
 	{
 		.cmd		= NET_SHAPER_CMD_SET,
-		.pre_doit	= net_shaper_nl_pre_doit,
+		.pre_doit	= net_shaper_nl_pre_doit_write,
 		.doit		= net_shaper_nl_set_doit,
-		.post_doit	= net_shaper_nl_post_doit,
+		.post_doit	= net_shaper_nl_post_doit_write,
 		.policy		= net_shaper_set_nl_policy,
 		.maxattr	= NET_SHAPER_A_IFINDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= NET_SHAPER_CMD_DELETE,
-		.pre_doit	= net_shaper_nl_pre_doit,
+		.pre_doit	= net_shaper_nl_pre_doit_write,
 		.doit		= net_shaper_nl_delete_doit,
-		.post_doit	= net_shaper_nl_post_doit,
+		.post_doit	= net_shaper_nl_post_doit_write,
 		.policy		= net_shaper_delete_nl_policy,
 		.maxattr	= NET_SHAPER_A_IFINDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= NET_SHAPER_CMD_GROUP,
-		.pre_doit	= net_shaper_nl_pre_doit,
+		.pre_doit	= net_shaper_nl_pre_doit_write,
 		.doit		= net_shaper_nl_group_doit,
-		.post_doit	= net_shaper_nl_post_doit,
+		.post_doit	= net_shaper_nl_post_doit_write,
 		.policy		= net_shaper_group_nl_policy,
 		.maxattr	= NET_SHAPER_A_LEAVES,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
diff --git a/net/shaper/shaper_nl_gen.h b/net/shaper/shaper_nl_gen.h
index ec41c90431a4..42c46c52c775 100644
--- a/net/shaper/shaper_nl_gen.h
+++ b/net/shaper/shaper_nl_gen.h
@@ -18,12 +18,17 @@ extern const struct nla_policy net_shaper_leaf_info_nl_policy[NET_SHAPER_A_WEIGH
 
 int net_shaper_nl_pre_doit(const struct genl_split_ops *ops,
 			   struct sk_buff *skb, struct genl_info *info);
+int net_shaper_nl_pre_doit_write(const struct genl_split_ops *ops,
+				 struct sk_buff *skb, struct genl_info *info);
 int net_shaper_nl_cap_pre_doit(const struct genl_split_ops *ops,
 			       struct sk_buff *skb, struct genl_info *info);
 void
 net_shaper_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info);
 void
+net_shaper_nl_post_doit_write(const struct genl_split_ops *ops,
+			      struct sk_buff *skb, struct genl_info *info);
+void
 net_shaper_nl_cap_post_doit(const struct genl_split_ops *ops,
 			    struct sk_buff *skb, struct genl_info *info);
 int net_shaper_nl_pre_dumpit(struct netlink_callback *cb);
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 18c56b0d7ad5..765f26aaca93 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -131,7 +131,14 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	struct smc_sock *smc;
 	struct sock *child;
 
-	smc = smc_clcsock_user_data(sk);
+	rcu_read_lock();
+	smc = smc_clcsock_user_data_rcu(sk);
+	if (!smc || !refcount_inc_not_zero(&smc->sk.sk_refcnt)) {
+		rcu_read_unlock();
+		smc = NULL;
+		goto drop;
+	}
+	rcu_read_unlock();
 
 	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
 				sk->sk_max_ack_backlog)
@@ -153,11 +160,14 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
 			inet_csk(child)->icsk_af_ops = smc->ori_af_ops;
 	}
+	sock_put(&smc->sk);
 	return child;
 
 drop:
 	dst_release(dst);
 	tcp_listendrop(sk);
+	if (smc)
+		sock_put(&smc->sk);
 	return NULL;
 }
 
@@ -254,7 +264,7 @@ static void smc_fback_restore_callbacks(struct smc_sock *smc)
 	struct sock *clcsk = smc->clcsock->sk;
 
 	write_lock_bh(&clcsk->sk_callback_lock);
-	clcsk->sk_user_data = NULL;
+	rcu_assign_sk_user_data(clcsk, NULL);
 
 	smc_clcsock_restore_cb(&clcsk->sk_state_change, &smc->clcsk_state_change);
 	smc_clcsock_restore_cb(&clcsk->sk_data_ready, &smc->clcsk_data_ready);
@@ -902,7 +912,7 @@ static void smc_fback_replace_callbacks(struct smc_sock *smc)
 	struct sock *clcsk = smc->clcsock->sk;
 
 	write_lock_bh(&clcsk->sk_callback_lock);
-	clcsk->sk_user_data = (void *)((uintptr_t)smc | SK_USER_DATA_NOCOPY);
+	__rcu_assign_sk_user_data_with_flags(clcsk, smc, SK_USER_DATA_NOCOPY);
 
 	smc_clcsock_replace_cb(&clcsk->sk_state_change, smc_fback_state_change,
 			       &smc->clcsk_state_change);
@@ -2665,8 +2675,8 @@ int smc_listen(struct socket *sock, int backlog)
 	 * smc-specific sk_data_ready function
 	 */
 	write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
-	smc->clcsock->sk->sk_user_data =
-		(void *)((uintptr_t)smc | SK_USER_DATA_NOCOPY);
+	__rcu_assign_sk_user_data_with_flags(smc->clcsock->sk, smc,
+					     SK_USER_DATA_NOCOPY);
 	smc_clcsock_replace_cb(&smc->clcsock->sk->sk_data_ready,
 			       smc_clcsock_data_ready, &smc->clcsk_data_ready);
 	write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
@@ -2687,10 +2697,11 @@ int smc_listen(struct socket *sock, int backlog)
 		write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
 		smc_clcsock_restore_cb(&smc->clcsock->sk->sk_data_ready,
 				       &smc->clcsk_data_ready);
-		smc->clcsock->sk->sk_user_data = NULL;
+		rcu_assign_sk_user_data(smc->clcsock->sk, NULL);
 		write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
 		goto out;
 	}
+	sock_set_flag(sk, SOCK_RCU_FREE);
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 	sk->sk_state = SMC_LISTEN;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 9e6af72784ba..52145df83f6e 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -346,6 +346,11 @@ static inline struct smc_sock *smc_clcsock_user_data(const struct sock *clcsk)
 	       ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
 }
 
+static inline struct smc_sock *smc_clcsock_user_data_rcu(const struct sock *clcsk)
+{
+	return (struct smc_sock *)rcu_dereference_sk_user_data(clcsk);
+}
+
 /* save target_cb in saved_cb, and replace target_cb with new_cb */
 static inline void smc_clcsock_replace_cb(void (**target_cb)(struct sock *),
 					  void (*new_cb)(struct sock *),
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 10219f55aad1..bb0313ef5f7c 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -218,7 +218,7 @@ int smc_close_active(struct smc_sock *smc)
 			write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
 			smc_clcsock_restore_cb(&smc->clcsock->sk->sk_data_ready,
 					       &smc->clcsk_data_ready);
-			smc->clcsock->sk->sk_user_data = NULL;
+			rcu_assign_sk_user_data(smc->clcsock->sk, NULL);
 			write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
 			rc = kernel_sock_shutdown(smc->clcsock, SHUT_RDWR);
 		}
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 131090f31e6a..6f6e0d4928af 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1061,14 +1061,25 @@ static int cache_release(struct inode *inode, struct file *filp,
 	struct cache_reader *rp = filp->private_data;
 
 	if (rp) {
+		struct cache_request *rq = NULL;
+
 		spin_lock(&queue_lock);
 		if (rp->offset) {
 			struct cache_queue *cq;
-			for (cq= &rp->q; &cq->list != &cd->queue;
-			     cq = list_entry(cq->list.next, struct cache_queue, list))
+			for (cq = &rp->q; &cq->list != &cd->queue;
+			     cq = list_entry(cq->list.next,
+					     struct cache_queue, list))
 				if (!cq->reader) {
-					container_of(cq, struct cache_request, q)
-						->readers--;
+					struct cache_request *cr =
+						container_of(cq,
+						struct cache_request, q);
+					cr->readers--;
+					if (cr->readers == 0 &&
+					    !test_bit(CACHE_PENDING,
+						      &cr->item->flags)) {
+						list_del(&cr->q.list);
+						rq = cr;
+					}
 					break;
 				}
 			rp->offset = 0;
@@ -1076,9 +1087,14 @@ static int cache_release(struct inode *inode, struct file *filp,
 		list_del(&rp->q.list);
 		spin_unlock(&queue_lock);
 
+		if (rq) {
+			cache_put(rq->item, cd);
+			kfree(rq->buf);
+			kfree(rq);
+		}
+
 		filp->private_data = NULL;
 		kfree(rp);
-
 	}
 	if (filp->f_mode & FMODE_WRITE) {
 		atomic_dec(&cd->writers);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6965b9a49d68..3db79e83d211 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1958,6 +1958,8 @@ static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
 	scm->fp = scm_fp_dup(UNIXCB(skb).fp);
+
+	unix_peek_fpl(scm->fp);
 }
 
 static void unix_destruct_scm(struct sk_buff *skb)
diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
index c4f1b2da363d..8119dbeef3a3 100644
--- a/net/unix/af_unix.h
+++ b/net/unix/af_unix.h
@@ -29,6 +29,7 @@ void unix_del_edges(struct scm_fp_list *fpl);
 void unix_update_edges(struct unix_sock *receiver);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
+void unix_peek_fpl(struct scm_fp_list *fpl);
 void unix_schedule_gc(struct user_struct *user);
 
 /* SOCK_DIAG */
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 25f65817faab..aaa5f5bf51ca 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -318,6 +318,25 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
+static bool gc_in_progress;
+static seqcount_t unix_peek_seq = SEQCNT_ZERO(unix_peek_seq);
+
+void unix_peek_fpl(struct scm_fp_list *fpl)
+{
+	static DEFINE_SPINLOCK(unix_peek_lock);
+
+	if (!fpl || !fpl->count_unix)
+		return;
+
+	if (!READ_ONCE(gc_in_progress))
+		return;
+
+	/* Invalidate the final refcnt check in unix_vertex_dead(). */
+	spin_lock(&unix_peek_lock);
+	raw_write_seqcount_barrier(&unix_peek_seq);
+	spin_unlock(&unix_peek_lock);
+}
+
 static bool unix_vertex_dead(struct unix_vertex *vertex)
 {
 	struct unix_edge *edge;
@@ -351,6 +370,36 @@ static bool unix_vertex_dead(struct unix_vertex *vertex)
 	return true;
 }
 
+static LIST_HEAD(unix_visited_vertices);
+static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
+
+static bool unix_scc_dead(struct list_head *scc, bool fast)
+{
+	struct unix_vertex *vertex;
+	bool scc_dead = true;
+	unsigned int seq;
+
+	seq = read_seqcount_begin(&unix_peek_seq);
+
+	list_for_each_entry_reverse(vertex, scc, scc_entry) {
+		/* Don't restart DFS from this vertex. */
+		list_move_tail(&vertex->entry, &unix_visited_vertices);
+
+		/* Mark vertex as off-stack for __unix_walk_scc(). */
+		if (!fast)
+			vertex->index = unix_vertex_grouped_index;
+
+		if (scc_dead)
+			scc_dead = unix_vertex_dead(vertex);
+	}
+
+	/* If MSG_PEEK intervened, defer this SCC to the next round. */
+	if (read_seqcount_retry(&unix_peek_seq, seq))
+		return false;
+
+	return scc_dead;
+}
+
 static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist)
 {
 	struct unix_vertex *vertex;
@@ -404,9 +453,6 @@ static bool unix_scc_cyclic(struct list_head *scc)
 	return false;
 }
 
-static LIST_HEAD(unix_visited_vertices);
-static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
-
 static unsigned long __unix_walk_scc(struct unix_vertex *vertex,
 				     unsigned long *last_index,
 				     struct sk_buff_head *hitlist)
@@ -474,9 +520,7 @@ static unsigned long __unix_walk_scc(struct unix_vertex *vertex,
 	}
 
 	if (vertex->index == vertex->scc_index) {
-		struct unix_vertex *v;
 		struct list_head scc;
-		bool scc_dead = true;
 
 		/* SCC finalised.
 		 *
@@ -485,18 +529,7 @@ static unsigned long __unix_walk_scc(struct unix_vertex *vertex,
 		 */
 		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
 
-		list_for_each_entry_reverse(v, &scc, scc_entry) {
-			/* Don't restart DFS from this vertex in unix_walk_scc(). */
-			list_move_tail(&v->entry, &unix_visited_vertices);
-
-			/* Mark vertex as off-stack. */
-			v->index = unix_vertex_grouped_index;
-
-			if (scc_dead)
-				scc_dead = unix_vertex_dead(v);
-		}
-
-		if (scc_dead) {
+		if (unix_scc_dead(&scc, false)) {
 			unix_collect_skb(&scc, hitlist);
 		} else {
 			if (unix_vertex_max_scc_index < vertex->scc_index)
@@ -550,19 +583,11 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
 		struct list_head scc;
-		bool scc_dead = true;
 
 		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
 		list_add(&scc, &vertex->scc_entry);
 
-		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
-			list_move_tail(&vertex->entry, &unix_visited_vertices);
-
-			if (scc_dead)
-				scc_dead = unix_vertex_dead(vertex);
-		}
-
-		if (scc_dead) {
+		if (unix_scc_dead(&scc, true)) {
 			cyclic_sccs--;
 			unix_collect_skb(&scc, hitlist);
 		}
@@ -577,8 +602,6 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 		   cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC);
 }
 
-static bool gc_in_progress;
-
 static void unix_gc(struct work_struct *work)
 {
 	struct sk_buff_head hitlist;
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index a117f5093ca2..13801cf35e9f 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -647,6 +647,7 @@ void cfg80211_pmsr_wdev_down(struct wireless_dev *wdev)
 	}
 	spin_unlock_bh(&wdev->pmsr_lock);
 
+	cancel_work_sync(&wdev->pmsr_free_wk);
 	if (found)
 		cfg80211_pmsr_process_abort(wdev);
 
diff --git a/security/security.c b/security/security.c
index 31a688650601..7fd2868ef0f5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -61,6 +61,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_BPF_WRITE_USER] = "use of bpf to write user RAM",
 	[LOCKDOWN_DBG_WRITE_KERNEL] = "use of kgdb/kdb to write kernel RAM",
 	[LOCKDOWN_RTAS_ERROR_INJECTION] = "RTAS error injection",
+	[LOCKDOWN_XEN_USER_ACTIONS] = "Xen guest user action",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 55d59ed507d5..643f707b8f1d 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -162,8 +162,11 @@ static int load_xbc_file(const char *path, char **buf)
 	if (fd < 0)
 		return -errno;
 	ret = fstat(fd, &stat);
-	if (ret < 0)
-		return -errno;
+	if (ret < 0) {
+		ret = -errno;
+		close(fd);
+		return ret;
+	}
 
 	ret = load_xbc_fd(fd, buf, stat.st_size);
 
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 531228b849da..125a975f32f9 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -6,8 +6,10 @@
 #define __HID_BPF_HELPERS_H
 
 /* "undefine" structs and enums in vmlinux.h, because we "override" them below */
+#define bpf_wq bpf_wq___not_used
 #define hid_bpf_ctx hid_bpf_ctx___not_used
 #define hid_bpf_ops hid_bpf_ops___not_used
+#define hid_device hid_device___not_used
 #define hid_report_type hid_report_type___not_used
 #define hid_class_request hid_class_request___not_used
 #define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
@@ -27,8 +29,10 @@
 
 #include "vmlinux.h"
 
+#undef bpf_wq
 #undef hid_bpf_ctx
 #undef hid_bpf_ops
+#undef hid_device
 #undef hid_report_type
 #undef hid_class_request
 #undef hid_bpf_attach_flags
@@ -55,6 +59,14 @@ enum hid_report_type {
 	HID_REPORT_TYPES,
 };
 
+struct hid_device {
+	unsigned int id;
+} __attribute__((preserve_access_index));
+
+struct bpf_wq {
+	__u64 __opaque[2];
+};
+
 struct hid_bpf_ctx {
 	struct hid_device *hid;
 	__u32 allocated_size;

