Return-Path: <stable+bounces-240321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLwFE3u46GmgPAIAu9opvQ
	(envelope-from <stable+bounces-240321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:00:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BE4445A99
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9909F3050416
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727BB3D2FE1;
	Wed, 22 Apr 2026 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1x+B+p2i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B4E3D2FF0;
	Wed, 22 Apr 2026 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859168; cv=none; b=kKVJictIvfmWOy9HbeJjt9xg3J5VKO1PkCZsr8I561xX6v/9SeaFlJakGxLuv4NxwrghaVOJWk1NJd2BDimessjFF6lnu8kQpkmT/iEBykdKMRUmFemNkJp8sMiaCDZEH4ZDiN/CN7S7DYonyZWnhCGaoCnhNIyZPhZfcEvQ10M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859168; c=relaxed/simple;
	bh=GqSHTQhYdK+v6KCdRXdEO6QaE8Aibw9YzGVQNN2f5c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuwilOYw6SyVcQoeqJGIVqSysI1IWLjg+yLuQBAy1sy4KKGu6Yui/NTgLvssG9Xavb7iLk43WWoBw1QuThfsapdNO7Vja2kIUSCdo9Xnwi/t4VPuSo67qTAT0AEzAfa2uu3APLxevNxzGXEUk41XQwphyJOESBBiLItcdXKefJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1x+B+p2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D53C19425;
	Wed, 22 Apr 2026 11:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776859167;
	bh=GqSHTQhYdK+v6KCdRXdEO6QaE8Aibw9YzGVQNN2f5c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1x+B+p2iBxmndoMOQ/LSg9lV8iFmm3SZ+XZFie00SgW2dkIIZMQpwZuY0fDAI6/Lu
	 5261iiEYeVIUGJ+n7PHJBD3Z/g26Ylr2YEYkGcY2RAOsHn0hGn/Ao57OvPI+yJ43gc
	 Vj6CTsMrdFvj3TosfoPxkCh0sPEnwdb83m1G4cBk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.19.14
Date: Wed, 22 Apr 2026 13:59:15 +0200
Message-ID: <2026042221-glance-purging-31d8@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026042220-coastline-flirt-ad3c@gregkh>
References: <2026042220-coastline-flirt-ad3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240321-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,args.pid:url,93b00000:email,weissschuh.net:email,linuxfoundation.org:dkim,sata-io.org:url,gitlab.freedesktop.org:url,vacharakis.de:email,2.67.213.128:email,fffff600:email,5.107.6.32:email]
X-Rspamd-Queue-Id: 30BE4445A99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 8eba3da8dcee..1d68db2aa27e 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -71,6 +71,10 @@ of parametrs except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_RECLAIM will be disabled.
 
+Once ``Y`` is written to this parameter, the user must not write to any
+parameters until reading ``commit_inputs`` again returns ``N``.  If users
+violate this rule, the kernel may exhibit undefined behavior.
+
 min_age
 -------
 
diff --git a/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml b/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml
index 2bd3efff2485..215f14d1897d 100644
--- a/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml
+++ b/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml
@@ -42,7 +42,7 @@ properties:
       - const: mgbe
       - const: mac
       - const: mac-divider
-      - const: ptp-ref
+      - const: ptp_ref
       - const: rx-input-m
       - const: rx-input
       - const: tx
@@ -133,7 +133,7 @@ examples:
                  <&bpmp TEGRA234_CLK_MGBE0_RX_PCS_M>,
                  <&bpmp TEGRA234_CLK_MGBE0_RX_PCS>,
                  <&bpmp TEGRA234_CLK_MGBE0_TX_PCS>;
-        clock-names = "mgbe", "mac", "mac-divider", "ptp-ref", "rx-input-m",
+        clock-names = "mgbe", "mac", "mac-divider", "ptp_ref", "rx-input-m",
                       "rx-input", "tx", "eee-pcs", "rx-pcs-input", "rx-pcs-m",
                       "rx-pcs", "tx-pcs";
         resets = <&bpmp TEGRA234_RESET_MGBE0_MAC>,
diff --git a/Makefile b/Makefile
index 7441da122752..cb2ba18730ac 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 19
-SUBLEVEL = 13
+SUBLEVEL = 14
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/boot/dts/microchip/sam9x7.dtsi b/arch/arm/boot/dts/microchip/sam9x7.dtsi
index 46dacbbd201d..d242d7a934d0 100644
--- a/arch/arm/boot/dts/microchip/sam9x7.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x7.dtsi
@@ -1226,7 +1226,7 @@ pioB: gpio@fffff600 {
 				interrupt-controller;
 				#gpio-cells = <2>;
 				gpio-controller;
-				#gpio-lines = <26>;
+				#gpio-lines = <27>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 607962f807be..6a25e219832c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1632,7 +1632,7 @@ gpu: gpu@38000000 {
 			                         <&clk IMX8MQ_GPU_PLL_OUT>,
 			                         <&clk IMX8MQ_GPU_PLL>;
 			assigned-clock-rates = <800000000>, <800000000>,
-			                       <800000000>, <800000000>, <0>;
+			                       <800000000>, <400000000>, <0>;
 			power-domains = <&pgc_gpu>;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi b/arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi
index 5792952b7a8e..c99d7bc16848 100644
--- a/arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi
@@ -272,20 +272,20 @@ pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 	/* enable SION for data and cmd pad due to ERR052021 */
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = /* PD | FSEL 3 | DSE X5 */
-			   <MX91_PAD_SD1_CLK__USDHC1_CLK		0x5be>,
+			   <MX91_PAD_SD1_CLK__USDHC1_CLK		0x59e>,
 			   /* HYS | FSEL 0 | no drive */
 			   <MX91_PAD_SD1_STROBE__USDHC1_STROBE		0x1000>,
 			   /* HYS | FSEL 3 | X5 */
-			   <MX91_PAD_SD1_CMD__USDHC1_CMD		0x400011be>,
+			   <MX91_PAD_SD1_CMD__USDHC1_CMD		0x4000139e>,
 			   /* HYS | FSEL 3 | X4 */
-			   <MX91_PAD_SD1_DATA0__USDHC1_DATA0		0x4000119e>,
-			   <MX91_PAD_SD1_DATA1__USDHC1_DATA1		0x4000119e>,
-			   <MX91_PAD_SD1_DATA2__USDHC1_DATA2		0x4000119e>,
-			   <MX91_PAD_SD1_DATA3__USDHC1_DATA3		0x4000119e>,
-			   <MX91_PAD_SD1_DATA4__USDHC1_DATA4		0x4000119e>,
-			   <MX91_PAD_SD1_DATA5__USDHC1_DATA5		0x4000119e>,
-			   <MX91_PAD_SD1_DATA6__USDHC1_DATA6		0x4000119e>,
-			   <MX91_PAD_SD1_DATA7__USDHC1_DATA7		0x4000119e>;
+			   <MX91_PAD_SD1_DATA0__USDHC1_DATA0		0x4000139e>,
+			   <MX91_PAD_SD1_DATA1__USDHC1_DATA1		0x4000139e>,
+			   <MX91_PAD_SD1_DATA2__USDHC1_DATA2		0x4000139e>,
+			   <MX91_PAD_SD1_DATA3__USDHC1_DATA3		0x4000139e>,
+			   <MX91_PAD_SD1_DATA4__USDHC1_DATA4		0x4000139e>,
+			   <MX91_PAD_SD1_DATA5__USDHC1_DATA5		0x4000139e>,
+			   <MX91_PAD_SD1_DATA6__USDHC1_DATA6		0x4000139e>,
+			   <MX91_PAD_SD1_DATA7__USDHC1_DATA7		0x4000139e>;
 	};
 
 	pinctrl_wdog: wdoggrp {
diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
index 0852067eab2c..197c8f8b7f66 100644
--- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -507,6 +507,7 @@ &usdhc1 {
 	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
 	bus-width = <8>;
 	non-removable;
+	fsl,tuning-step = <1>;
 	status = "okay";
 };
 
@@ -519,6 +520,7 @@ &usdhc2 {
 	vmmc-supply = <&reg_usdhc2_vmmc>;
 	bus-width = <4>;
 	no-mmc;
+	fsl,tuning-step = <1>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
index 3a23e2eb9feb..ce34a296495c 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
@@ -271,21 +271,21 @@ MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x106
 	/* enable SION for data and cmd pad due to ERR052021 */
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-			/* PD | FSEL 3 | DSE X5 */
-			MX93_PAD_SD1_CLK__USDHC1_CLK		0x5be
+			/* PD | FSEL 3 | DSE X4 */
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x59e
 			/* HYS | FSEL 0 | no drive */
 			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x1000
-			/* HYS | FSEL 3 | X5 */
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x400011be
-			/* HYS | FSEL 3 | X4 */
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000119e
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000119e
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x4000119e
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000119e
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000119e
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000119e
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000119e
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000119e
+			/* HYS | PU | FSEL 3 | DSE X4 */
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000139e
+			/* HYS | PU | FSEL 3 | DSE X4 */
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000139e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000139e
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x4000139e
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000139e
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000139e
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000139e
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000139e
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000139e
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 9e0934b302c3..f1ebb99d9424 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -269,7 +269,7 @@ cluster_c4: cpu-sleep-0 {
 				idle-state-name = "ret";
 				arm,psci-suspend-param = <0x00000004>;
 				entry-latency-us = <180>;
-				exit-latency-us = <500>;
+				exit-latency-us = <320>;
 				min-residency-us = <600>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 816fa2af8a9a..a407f80bc5e1 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -757,6 +757,11 @@ smem_mem: smem@90900000 {
 			hwlocks = <&tcsr_mutex 3>;
 		};
 
+		gunyah_md_mem: gunyah-md-region@91a80000 {
+			reg = <0x0 0x91a80000 0x0 0x80000>;
+			no-map;
+		};
+
 		lpass_machine_learning_mem: lpass-machine-learning-region@93b00000 {
 			reg = <0x0 0x93b00000 0x0 0xf00000>;
 			no-map;
@@ -5437,12 +5442,12 @@ qup_uart10_cts: qup-uart10-cts-state {
 			};
 
 			qup_uart10_rts: qup-uart10-rts-state {
-				pins = "gpio84";
+				pins = "gpio85";
 				function = "qup1_se2";
 			};
 
 			qup_uart10_tx: qup-uart10-tx-state {
-				pins = "gpio85";
+				pins = "gpio86";
 				function = "qup1_se2";
 			};
 
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 089a027c57d5..b2f00e107643 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -177,7 +177,7 @@ wcd9370: audio-codec-0 {
 		pinctrl-0 = <&wcd_default>;
 		pinctrl-names = "default";
 
-		reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 83 GPIO_ACTIVE_LOW>;
 
 		vdd-buck-supply = <&vreg_l17b_1p7>;
 		vdd-rxtx-supply = <&vreg_l18b_1p8>;
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 6dae631c7132..a2d7c17e77e0 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -25,6 +25,8 @@
  */
 #define PTE_PRESENT_INVALID	(PTE_NG)		 /* only when !PTE_VALID */
 
+#define PTE_PRESENT_VALID_KERNEL (PTE_VALID | PTE_MAYBE_NG)
+
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 #define PTE_UFFD_WP		(_AT(pteval_t, 1) << 58) /* uffd-wp tracking */
 #define PTE_SWP_UFFD_WP		(_AT(pteval_t, 1) << 3)	 /* only for swp ptes */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 5ab5fe3bef25..e62e5631b6a1 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -357,9 +357,11 @@ static inline pte_t pte_mknoncont(pte_t pte)
 	return clear_pte_bit(pte, __pgprot(PTE_CONT));
 }
 
-static inline pte_t pte_mkvalid(pte_t pte)
+static inline pte_t pte_mkvalid_k(pte_t pte)
 {
-	return set_pte_bit(pte, __pgprot(PTE_VALID));
+	pte = clear_pte_bit(pte, __pgprot(PTE_PRESENT_INVALID));
+	pte = set_pte_bit(pte, __pgprot(PTE_PRESENT_VALID_KERNEL));
+	return pte;
 }
 
 static inline pte_t pte_mkinvalid(pte_t pte)
@@ -629,6 +631,7 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
+#define pmd_mkvalid_k(pmd)	pte_pmd(pte_mkvalid_k(pmd_pte(pmd)))
 #define pmd_mkinvalid(pmd)	pte_pmd(pte_mkinvalid(pmd_pte(pmd)))
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 #define pmd_uffd_wp(pmd)	pte_uffd_wp(pmd_pte(pmd))
@@ -670,6 +673,8 @@ static inline pmd_t pmd_mkspecial(pmd_t pmd)
 
 #define pud_young(pud)		pte_young(pud_pte(pud))
 #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
+#define pud_mkwrite_novma(pud)	pte_pud(pte_mkwrite_novma(pud_pte(pud)))
+#define pud_mkvalid_k(pud)	pte_pud(pte_mkvalid_k(pud_pte(pud)))
 #define pud_write(pud)		pte_write(pud_pte(pud))
 
 static inline pud_t pud_mkhuge(pud_t pud)
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 6490930deef8..770bb5211b54 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -480,7 +480,7 @@ extern __must_check long strnlen_user(const char __user *str, long n);
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 extern unsigned long __must_check __copy_user_flushcache(void *to, const void __user *from, unsigned long n);
 
-static inline int __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
+static inline size_t copy_from_user_flushcache(void *dst, const void __user *src, size_t size)
 {
 	kasan_check_write(dst, size);
 	return __copy_user_flushcache(dst, __uaccess_mask_ptr(src), size);
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 1c87699fd886..332c453b87cf 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -29,7 +29,7 @@
 
 #include "trace.h"
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS()
 };
 
@@ -42,7 +42,7 @@ const struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, hvc_exit_stat),
 	STATS_DESC_COUNTER(VCPU, wfe_exit_stat),
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8e1d80a7033e..60fd87a92de0 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -602,6 +602,8 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
 		tableprot |= PMD_TABLE_PXN;
 
 	prot = __pgprot((pgprot_val(prot) & ~PTE_TYPE_MASK) | PTE_TYPE_PAGE);
+	if (!pmd_valid(pmd))
+		prot = pte_pgprot(pte_mkinvalid(pfn_pte(0, prot)));
 	prot = __pgprot(pgprot_val(prot) & ~PTE_CONT);
 	if (to_cont)
 		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
@@ -647,6 +649,8 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
 		tableprot |= PUD_TABLE_PXN;
 
 	prot = __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT);
+	if (!pud_valid(pud))
+		prot = pmd_pgprot(pmd_mkinvalid(pfn_pmd(0, prot)));
 	prot = __pgprot(pgprot_val(prot) & ~PTE_CONT);
 	if (to_cont)
 		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 7176ff39cb87..672058657514 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -25,6 +25,11 @@ static ptdesc_t set_pageattr_masks(ptdesc_t val, struct mm_walk *walk)
 {
 	struct page_change_data *masks = walk->private;
 
+	/*
+	 * Some users clear and set bits which alias each other (e.g. PTE_NG and
+	 * PTE_PRESENT_INVALID). It is therefore important that we always clear
+	 * first then set.
+	 */
 	val &= ~(pgprot_val(masks->clear_mask));
 	val |= (pgprot_val(masks->set_mask));
 
@@ -36,7 +41,7 @@ static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
 {
 	pud_t val = pudp_get(pud);
 
-	if (pud_sect(val)) {
+	if (pud_leaf(val)) {
 		if (WARN_ON_ONCE((next - addr) != PUD_SIZE))
 			return -EINVAL;
 		val = __pud(set_pageattr_masks(pud_val(val), walk));
@@ -52,7 +57,7 @@ static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
 {
 	pmd_t val = pmdp_get(pmd);
 
-	if (pmd_sect(val)) {
+	if (pmd_leaf(val)) {
 		if (WARN_ON_ONCE((next - addr) != PMD_SIZE))
 			return -EINVAL;
 		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
@@ -132,11 +137,12 @@ static int __change_memory_common(unsigned long start, unsigned long size,
 	ret = update_range_prot(start, size, set_mask, clear_mask);
 
 	/*
-	 * If the memory is being made valid without changing any other bits
-	 * then a TLBI isn't required as a non-valid entry cannot be cached in
-	 * the TLB.
+	 * If the memory is being switched from present-invalid to valid without
+	 * changing any other bits then a TLBI isn't required as a non-valid
+	 * entry cannot be cached in the TLB.
 	 */
-	if (pgprot_val(set_mask) != PTE_VALID || pgprot_val(clear_mask))
+	if (pgprot_val(set_mask) != PTE_PRESENT_VALID_KERNEL ||
+	    pgprot_val(clear_mask) != PTE_PRESENT_INVALID)
 		flush_tlb_kernel_range(start, start + size);
 	return ret;
 }
@@ -237,18 +243,18 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 {
 	if (enable)
 		return __change_memory_common(addr, PAGE_SIZE * numpages,
-					__pgprot(PTE_VALID),
-					__pgprot(0));
+					__pgprot(PTE_PRESENT_VALID_KERNEL),
+					__pgprot(PTE_PRESENT_INVALID));
 	else
 		return __change_memory_common(addr, PAGE_SIZE * numpages,
-					__pgprot(0),
-					__pgprot(PTE_VALID));
+					__pgprot(PTE_PRESENT_INVALID),
+					__pgprot(PTE_PRESENT_VALID_KERNEL));
 }
 
 int set_direct_map_invalid_noflush(struct page *page)
 {
-	pgprot_t clear_mask = __pgprot(PTE_VALID);
-	pgprot_t set_mask = __pgprot(0);
+	pgprot_t clear_mask = __pgprot(PTE_PRESENT_VALID_KERNEL);
+	pgprot_t set_mask = __pgprot(PTE_PRESENT_INVALID);
 
 	if (!can_set_direct_map())
 		return 0;
@@ -259,8 +265,8 @@ int set_direct_map_invalid_noflush(struct page *page)
 
 int set_direct_map_default_noflush(struct page *page)
 {
-	pgprot_t set_mask = __pgprot(PTE_VALID | PTE_WRITE);
-	pgprot_t clear_mask = __pgprot(PTE_RDONLY);
+	pgprot_t set_mask = __pgprot(PTE_PRESENT_VALID_KERNEL | PTE_WRITE);
+	pgprot_t clear_mask = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY);
 
 	if (!can_set_direct_map())
 		return 0;
@@ -296,8 +302,8 @@ static int __set_memory_enc_dec(unsigned long addr,
 	 * entries or Synchronous External Aborts caused by RIPAS_EMPTY
 	 */
 	ret = __change_memory_common(addr, PAGE_SIZE * numpages,
-				     __pgprot(set_prot),
-				     __pgprot(clear_prot | PTE_VALID));
+				     __pgprot(set_prot | PTE_PRESENT_INVALID),
+				     __pgprot(clear_prot | PTE_PRESENT_VALID_KERNEL));
 
 	if (ret)
 		return ret;
@@ -311,8 +317,8 @@ static int __set_memory_enc_dec(unsigned long addr,
 		return ret;
 
 	return __change_memory_common(addr, PAGE_SIZE * numpages,
-				      __pgprot(PTE_VALID),
-				      __pgprot(0));
+				      __pgprot(PTE_PRESENT_VALID_KERNEL),
+				      __pgprot(PTE_PRESENT_INVALID));
 }
 
 static int realm_set_memory_encrypted(unsigned long addr, int numpages)
@@ -404,15 +410,15 @@ bool kernel_page_present(struct page *page)
 	pud = READ_ONCE(*pudp);
 	if (pud_none(pud))
 		return false;
-	if (pud_sect(pud))
-		return true;
+	if (pud_leaf(pud))
+		return pud_valid(pud);
 
 	pmdp = pmd_offset(pudp, addr);
 	pmd = READ_ONCE(*pmdp);
 	if (pmd_none(pmd))
 		return false;
-	if (pmd_sect(pmd))
-		return true;
+	if (pmd_leaf(pmd))
+		return pmd_valid(pmd);
 
 	ptep = pte_offset_kernel(pmdp, addr);
 	return pte_valid(__ptep_get(ptep));
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 18543b603c77..cca9706a875c 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -31,36 +31,6 @@ static void *trans_alloc(struct trans_pgd_info *info)
 	return info->trans_alloc_page(info->trans_alloc_arg);
 }
 
-static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
-{
-	pte_t pte = __ptep_get(src_ptep);
-
-	if (pte_valid(pte)) {
-		/*
-		 * Resume will overwrite areas that may be marked
-		 * read only (code, rodata). Clear the RDONLY bit from
-		 * the temporary mappings we use during restore.
-		 */
-		__set_pte(dst_ptep, pte_mkwrite_novma(pte));
-	} else if (!pte_none(pte)) {
-		/*
-		 * debug_pagealloc will removed the PTE_VALID bit if
-		 * the page isn't in use by the resume kernel. It may have
-		 * been in use by the original kernel, in which case we need
-		 * to put it back in our copy to do the restore.
-		 *
-		 * Other cases include kfence / vmalloc / memfd_secret which
-		 * may call `set_direct_map_invalid_noflush()`.
-		 *
-		 * Before marking this entry valid, check the pfn should
-		 * be mapped.
-		 */
-		BUG_ON(!pfn_valid(pte_pfn(pte)));
-
-		__set_pte(dst_ptep, pte_mkvalid(pte_mkwrite_novma(pte)));
-	}
-}
-
 static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
 		    pmd_t *src_pmdp, unsigned long start, unsigned long end)
 {
@@ -76,7 +46,11 @@ static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
 
 	src_ptep = pte_offset_kernel(src_pmdp, start);
 	do {
-		_copy_pte(dst_ptep, src_ptep, addr);
+		pte_t pte = __ptep_get(src_ptep);
+
+		if (pte_none(pte))
+			continue;
+		__set_pte(dst_ptep, pte_mkvalid_k(pte_mkwrite_novma(pte)));
 	} while (dst_ptep++, src_ptep++, addr += PAGE_SIZE, addr != end);
 
 	return 0;
@@ -109,8 +83,7 @@ static int copy_pmd(struct trans_pgd_info *info, pud_t *dst_pudp,
 			if (copy_pte(info, dst_pmdp, src_pmdp, addr, next))
 				return -ENOMEM;
 		} else {
-			set_pmd(dst_pmdp,
-				__pmd(pmd_val(pmd) & ~PMD_SECT_RDONLY));
+			set_pmd(dst_pmdp, pmd_mkvalid_k(pmd_mkwrite_novma(pmd)));
 		}
 	} while (dst_pmdp++, src_pmdp++, addr = next, addr != end);
 
@@ -145,8 +118,7 @@ static int copy_pud(struct trans_pgd_info *info, p4d_t *dst_p4dp,
 			if (copy_pmd(info, dst_pudp, src_pudp, addr, next))
 				return -ENOMEM;
 		} else {
-			set_pud(dst_pudp,
-				__pud(pud_val(pud) & ~PUD_SECT_RDONLY));
+			set_pud(dst_pudp, pud_mkvalid_k(pud_mkwrite_novma(pud)));
 		}
 	} while (dst_pudp++, src_pudp++, addr = next, addr != end);
 
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index f15d78c00dbd..3a359d83b022 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -14,7 +14,7 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, int_exits),
 	STATS_DESC_COUNTER(VCPU, idle_exits),
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 194ccbcdc3b3..7deff56e0e1a 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -10,7 +10,7 @@
 #include <asm/kvm_eiointc.h>
 #include <asm/kvm_pch_pic.h>
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS(),
 	STATS_DESC_ICOUNTER(VM, pages),
 	STATS_DESC_ICOUNTER(VM, hugepages),
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index b0fb92fda4d4..23e69baad453 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -38,7 +38,7 @@
 #define VECTORSPACING 0x100	/* for EI/VI mode */
 #endif
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS()
 };
 
@@ -51,7 +51,7 @@ const struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, wait_exits),
 	STATS_DESC_COUNTER(VCPU, cache_exits),
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index f77c503ecc10..ea4e685f9088 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -407,8 +407,7 @@ copy_mc_to_user(void __user *to, const void *from, unsigned long n)
 }
 #endif
 
-extern long __copy_from_user_flushcache(void *dst, const void __user *src,
-		unsigned size);
+extern size_t copy_from_user_flushcache(void *dst, const void __user *src, size_t size);
 
 static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
 {
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index d79c5d1098c0..2efbe05caed7 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -38,7 +38,7 @@
 
 /* #define EXIT_DEBUG */
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS(),
 	STATS_DESC_ICOUNTER(VM, num_2M_pages),
 	STATS_DESC_ICOUNTER(VM, num_1G_pages)
@@ -53,7 +53,7 @@ const struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, sum_exits),
 	STATS_DESC_COUNTER(VCPU, mmio_exits),
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 3401b96be475..f3ddb24ece74 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -36,7 +36,7 @@
 
 unsigned long kvmppc_booke_handlers;
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS(),
 	STATS_DESC_ICOUNTER(VM, num_2M_pages),
 	STATS_DESC_ICOUNTER(VM, num_1G_pages)
@@ -51,7 +51,7 @@ const struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, sum_exits),
 	STATS_DESC_COUNTER(VCPU, mmio_exits),
diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
index 4e724c4c01ad..0f0f2d851ac6 100644
--- a/arch/powerpc/lib/pmem.c
+++ b/arch/powerpc/lib/pmem.c
@@ -66,15 +66,16 @@ EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
 /*
  * CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE symbols
  */
-long __copy_from_user_flushcache(void *dest, const void __user *src,
-		unsigned size)
+size_t copy_from_user_flushcache(void *dest, const void __user *src,
+				 size_t size)
 {
-	unsigned long copied, start = (unsigned long) dest;
+	unsigned long not_copied, start = (unsigned long) dest;
 
-	copied = __copy_from_user(dest, src, size);
+	src = mask_user_address(src);
+	not_copied = __copy_from_user(dest, src, size);
 	clean_pmem_range(start, start + size);
 
-	return copied;
+	return not_copied;
 }
 
 void memcpy_flushcache(void *dest, const void *src, size_t size)
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index a55a95da54d0..fdd99ac1e714 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -24,7 +24,7 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, ecall_exit_stat),
 	STATS_DESC_COUNTER(VCPU, wfi_exit_stat),
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index 66d91ae6e9b2..715a06ae8c13 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -13,7 +13,7 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_mmu.h>
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS()
 };
 static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 56a50524b3ee..495141bf0398 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -64,7 +64,7 @@
 #define VCPU_IRQS_MAX_BUF (sizeof(struct kvm_s390_irq) * \
 			   (KVM_MAX_VCPUS + LOCAL_IRQS))
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS(),
 	STATS_DESC_COUNTER(VM, inject_io),
 	STATS_DESC_COUNTER(VM, inject_float_mchk),
@@ -90,7 +90,7 @@ const struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, exit_userspace),
 	STATS_DESC_COUNTER(VCPU, exit_null),
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e228e564b15e..8301a589d9a6 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -67,6 +67,7 @@ int uncore_die_to_segment(int die)
 	return bus ? pci_domain_nr(bus) : -EINVAL;
 }
 
+/* Note: This API can only be used when NUMA information is available. */
 int uncore_device_to_die(struct pci_dev *dev)
 {
 	int node = pcibus_to_node(dev->bus);
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 7d57ce706feb..c5adbe440904 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -383,7 +383,7 @@ static bool intel_uncore_has_discovery_tables_pci(int *ignore)
 				     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * UNCORE_DISCOVERY_BIR_STEP;
 
 			die = get_device_die_id(dev);
-			if (die < 0)
+			if ((die < 0) || (die >= uncore_max_dies()))
 				continue;
 
 			parse_discovery_table(dev, die, bar_offset, &parsed, ignore);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index a338ee01bb24..0182785cad1f 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1475,13 +1475,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 			}
 
 			map->pbus_to_dieid[bus] = die_id = uncore_device_to_die(ubox_dev);
-
 			raw_spin_unlock(&pci2phy_map_lock);
-
-			if (WARN_ON_ONCE(die_id == -1)) {
-				err = -EINVAL;
-				break;
-			}
 		}
 	}
 
@@ -6533,7 +6527,7 @@ static void spr_update_device_location(int type_id)
 
 	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
 
-		die = uncore_device_to_die(dev);
+		die = uncore_pcibus_to_dieid(dev->bus);
 		if (die < 0)
 			continue;
 
@@ -6557,6 +6551,11 @@ static void spr_update_device_location(int type_id)
 
 int spr_uncore_pci_init(void)
 {
+	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
+
+	if (ret)
+		return ret;
+
 	/*
 	 * The discovery table of UPI on some SPR variant is broken,
 	 * which impacts the detection of both UPI and M3UPI uncore PMON.
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 367297b188c3..3a0dd3c2b233 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -507,7 +507,7 @@ extern struct movsl_mask {
 } ____cacheline_aligned_in_smp movsl_mask;
 #endif
 
-#define ARCH_HAS_NOCACHE_UACCESS 1
+#define ARCH_HAS_NONTEMPORAL_UACCESS 1
 
 /*
  * The "unsafe" user accesses aren't really "unsafe", but the naming
diff --git a/arch/x86/include/asm/uaccess_32.h b/arch/x86/include/asm/uaccess_32.h
index 40379a1adbb8..fff19e73ccb3 100644
--- a/arch/x86/include/asm/uaccess_32.h
+++ b/arch/x86/include/asm/uaccess_32.h
@@ -26,13 +26,7 @@ raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 	return __copy_user_ll(to, (__force const void *)from, n);
 }
 
-static __always_inline unsigned long
-__copy_from_user_inatomic_nocache(void *to, const void __user *from,
-				  unsigned long n)
-{
-       return __copy_from_user_ll_nocache_nozero(to, from, n);
-}
-
+unsigned long __must_check copy_from_user_inatomic_nontemporal(void *, const void __user *, unsigned long n);
 unsigned long __must_check clear_user(void __user *mem, unsigned long len);
 unsigned long __must_check __clear_user(void __user *mem, unsigned long len);
 
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 915124011c27..20de34cc9aa6 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -147,26 +147,28 @@ raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
 	return copy_user_generic((__force void *)dst, src, size);
 }
 
-extern long __copy_user_nocache(void *dst, const void __user *src, unsigned size);
-extern long __copy_user_flushcache(void *dst, const void __user *src, unsigned size);
+#define copy_to_nontemporal copy_to_nontemporal
+extern size_t copy_to_nontemporal(void *dst, const void *src, size_t size);
+extern size_t copy_user_flushcache(void *dst, const void __user *src, size_t size);
 
 static inline int
-__copy_from_user_inatomic_nocache(void *dst, const void __user *src,
+copy_from_user_inatomic_nontemporal(void *dst, const void __user *src,
 				  unsigned size)
 {
 	long ret;
 	kasan_check_write(dst, size);
+	src = mask_user_address(src);
 	stac();
-	ret = __copy_user_nocache(dst, src, size);
+	ret = copy_to_nontemporal(dst, (__force const void *)src, size);
 	clac();
 	return ret;
 }
 
-static inline int
-__copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
+static inline size_t
+copy_from_user_flushcache(void *dst, const void __user *src, size_t size)
 {
 	kasan_check_write(dst, size);
-	return __copy_user_flushcache(dst, src, size);
+	return copy_user_flushcache(dst, src, size);
 }
 
 /*
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 774eb6989ef9..d94b2471aa21 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -197,13 +197,13 @@ struct kvm_msrs {
 	__u32 nmsrs; /* number of msrs in entries */
 	__u32 pad;
 
-	struct kvm_msr_entry entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_msr_entry, entries);
 };
 
 /* for KVM_GET_MSR_INDEX_LIST */
 struct kvm_msr_list {
 	__u32 nmsrs; /* number of msrs in entries */
-	__u32 indices[];
+	__DECLARE_FLEX_ARRAY(__u32, indices);
 };
 
 /* Maximum size of any access bitmap in bytes */
@@ -245,7 +245,7 @@ struct kvm_cpuid_entry {
 struct kvm_cpuid {
 	__u32 nent;
 	__u32 padding;
-	struct kvm_cpuid_entry entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_cpuid_entry, entries);
 };
 
 struct kvm_cpuid_entry2 {
@@ -267,7 +267,7 @@ struct kvm_cpuid_entry2 {
 struct kvm_cpuid2 {
 	__u32 nent;
 	__u32 padding;
-	struct kvm_cpuid_entry2 entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_cpuid_entry2, entries);
 };
 
 /* for KVM_GET_PIT and KVM_SET_PIT */
@@ -398,7 +398,7 @@ struct kvm_xsave {
 	 * the contents of CPUID leaf 0xD on the host.
 	 */
 	__u32 region[1024];
-	__u32 extra[];
+	__DECLARE_FLEX_ARRAY(__u32, extra);
 };
 
 #define KVM_MAX_XCRS	16
@@ -565,7 +565,7 @@ struct kvm_pmu_event_filter {
 	__u32 fixed_counter_bitmap;
 	__u32 flags;
 	__u32 pad[4];
-	__u64 events[];
+	__DECLARE_FLEX_ARRAY(__u64, events);
 };
 
 #define KVM_PMU_EVENT_ALLOW 0
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 978232b6d48d..ff8edea8511b 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -351,7 +351,8 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 	need_to_check_vma = PAGE_ALIGN(*ssp) == *ssp;
 
 	if (need_to_check_vma)
-		mmap_read_lock_killable(current->mm);
+		if (mmap_read_lock_killable(current->mm))
+			return -EINTR;
 
 	err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
 	if (unlikely(err))
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f59c65abe3cf..f2a57891e570 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -683,10 +683,16 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 	if (ulen == 0 || uaddr + ulen < uaddr)
 		return ERR_PTR(-EINVAL);
 
-	/* Calculate number of pages. */
+	/*
+	 * Calculate the number of pages that need to be pinned to cover the
+	 * entire range.  Note!  This isn't simply ulen >> PAGE_SHIFT, as KVM
+	 * doesn't require the incoming address+size to be page aligned!
+	 */
 	first = (uaddr & PAGE_MASK) >> PAGE_SHIFT;
 	last = ((uaddr + ulen - 1) & PAGE_MASK) >> PAGE_SHIFT;
 	npages = (last - first + 1);
+	if (npages > INT_MAX)
+		return ERR_PTR(-EINVAL);
 
 	locked = sev->pages_locked + npages;
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
@@ -695,9 +701,6 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (WARN_ON_ONCE(npages > INT_MAX))
-		return ERR_PTR(-EINVAL);
-
 	/* Avoid using vmalloc for smaller buffers. */
 	size = npages * sizeof(struct page *);
 	if (size > PAGE_SIZE)
@@ -875,6 +878,11 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	u8 *d;
 	int i;
 
+	lockdep_assert_held(&vcpu->mutex);
+
+	if (vcpu->arch.guest_state_protected)
+		return -EINVAL;
+
 	/* Check some debug related fields before encrypting the VMSA */
 	if (svm->vcpu.guest_debug || (svm->vmcb->save.dr7 & ~DR7_FIXED_1))
 		return -EINVAL;
@@ -1020,6 +1028,9 @@ static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!sev_es_guest(kvm))
 		return -ENOTTY;
 
+	if (kvm_is_vcpu_creation_in_progress(kvm))
+		return -EBUSY;
+
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		ret = mutex_lock_killable(&vcpu->mutex);
 		if (ret)
@@ -2040,8 +2051,8 @@ static int sev_check_source_vcpus(struct kvm *dst, struct kvm *src)
 	struct kvm_vcpu *src_vcpu;
 	unsigned long i;
 
-	if (src->created_vcpus != atomic_read(&src->online_vcpus) ||
-	    dst->created_vcpus != atomic_read(&dst->online_vcpus))
+	if (kvm_is_vcpu_creation_in_progress(src) ||
+	    kvm_is_vcpu_creation_in_progress(dst))
 		return -EBUSY;
 
 	if (!sev_es_guest(src))
@@ -2451,6 +2462,13 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	unsigned long i;
 	int ret;
 
+	if (kvm_is_vcpu_creation_in_progress(kvm))
+		return -EBUSY;
+
+	ret = kvm_lock_all_vcpus(kvm);
+	if (ret)
+		return ret;
+
 	data.gctx_paddr = __psp_pa(sev->snp_context);
 	data.page_type = SNP_PAGE_TYPE_VMSA;
 
@@ -2460,12 +2478,12 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 		ret = sev_es_sync_vmsa(svm);
 		if (ret)
-			return ret;
+			goto out;
 
 		/* Transition the VMSA page to a firmware state. */
 		ret = rmp_make_private(pfn, INITIAL_VMSA_GPA, PG_LEVEL_4K, sev->asid, true);
 		if (ret)
-			return ret;
+			goto out;
 
 		/* Issue the SNP command to encrypt the VMSA */
 		data.address = __sme_pa(svm->sev_es.vmsa);
@@ -2474,7 +2492,7 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		if (ret) {
 			snp_page_reclaim(kvm, pfn);
 
-			return ret;
+			goto out;
 		}
 
 		svm->vcpu.arch.guest_state_protected = true;
@@ -2488,7 +2506,9 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		svm_enable_lbrv(vcpu);
 	}
 
-	return 0;
+out:
+	kvm_unlock_all_vcpus(kvm);
+	return ret;
 }
 
 static int snp_launch_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
@@ -2692,6 +2712,8 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	struct enc_region *region;
 	int ret = 0;
 
+	guard(mutex)(&kvm->lock);
+
 	if (!sev_guest(kvm))
 		return -ENOTTY;
 
@@ -2706,12 +2728,10 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	if (!region)
 		return -ENOMEM;
 
-	mutex_lock(&kvm->lock);
 	region->pages = sev_pin_memory(kvm, range->addr, range->size, &region->npages,
 				       FOLL_WRITE | FOLL_LONGTERM);
 	if (IS_ERR(region->pages)) {
 		ret = PTR_ERR(region->pages);
-		mutex_unlock(&kvm->lock);
 		goto e_free;
 	}
 
@@ -2729,8 +2749,6 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	region->size = range->size;
 
 	list_add_tail(&region->list, &sev->regions_list);
-	mutex_unlock(&kvm->lock);
-
 	return ret;
 
 e_free:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0d731ce4c4e1..e6ff8a2d7b54 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -239,7 +239,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_ipiv);
 bool __read_mostly enable_device_posted_irqs = true;
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_device_posted_irqs);
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS(),
 	STATS_DESC_COUNTER(VM, mmu_shadow_zapped),
 	STATS_DESC_COUNTER(VM, mmu_pte_write),
@@ -265,7 +265,7 @@ const struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, pf_taken),
 	STATS_DESC_COUNTER(VCPU, pf_fixed),
@@ -8214,7 +8214,13 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
 	WARN_ON(vcpu->mmio_nr_fragments >= KVM_MAX_MMIO_FRAGMENTS);
 	frag = &vcpu->mmio_fragments[vcpu->mmio_nr_fragments++];
 	frag->gpa = gpa;
-	frag->data = val;
+	if (write && bytes <= 8u) {
+		frag->val = 0;
+		frag->data = &frag->val;
+		memcpy(&frag->val, val, bytes);
+	} else {
+		frag->data = val;
+	}
 	frag->len = bytes;
 	return X86EMUL_CONTINUE;
 }
@@ -8229,6 +8235,9 @@ static int emulator_read_write(struct x86_emulate_ctxt *ctxt,
 	gpa_t gpa;
 	int rc;
 
+	if (WARN_ON_ONCE((bytes > 8u || !ops->write) && object_is_on_stack(val)))
+		return X86EMUL_UNHANDLEABLE;
+
 	if (ops->read_write_prepare &&
 		  ops->read_write_prepare(vcpu, val, bytes))
 		return X86EMUL_CONTINUE;
@@ -11834,6 +11843,9 @@ static int complete_emulated_mmio(struct kvm_vcpu *vcpu)
 		frag++;
 		vcpu->mmio_cur_fragment++;
 	} else {
+		if (WARN_ON_ONCE(frag->data == &frag->val))
+			return -EIO;
+
 		/* Go forward to the next mmio piece. */
 		frag->data += len;
 		frag->gpa += len;
diff --git a/arch/x86/lib/copy_user_uncached_64.S b/arch/x86/lib/copy_user_uncached_64.S
index 18350b343c2a..8ed0ce3ad227 100644
--- a/arch/x86/lib/copy_user_uncached_64.S
+++ b/arch/x86/lib/copy_user_uncached_64.S
@@ -27,7 +27,7 @@
  * Output:
  * rax uncopied bytes or 0 if successful.
  */
-SYM_FUNC_START(__copy_user_nocache)
+SYM_FUNC_START(copy_to_nontemporal)
 	ANNOTATE_NOENDBR
 	/* If destination is not 7-byte aligned, we'll have to align it */
 	testb $7,%dil
@@ -240,5 +240,5 @@ _ASM_EXTABLE_UA(95b, .Ldone)
 _ASM_EXTABLE_UA(52b, .Ldone0)
 _ASM_EXTABLE_UA(53b, .Ldone0)
 
-SYM_FUNC_END(__copy_user_nocache)
-EXPORT_SYMBOL(__copy_user_nocache)
+SYM_FUNC_END(copy_to_nontemporal)
+EXPORT_SYMBOL(copy_to_nontemporal)
diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index f6f436f1d573..ac27e39fc993 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -322,10 +322,11 @@ unsigned long __copy_user_ll(void *to, const void *from, unsigned long n)
 }
 EXPORT_SYMBOL(__copy_user_ll);
 
-unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __user *from,
+unsigned long copy_from_user_inatomic_nontemporal(void *to, const void __user *from,
 					unsigned long n)
 {
-	__uaccess_begin_nospec();
+	if (!user_access_begin(from, n))
+		return n;
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	if (n > 64 && static_cpu_has(X86_FEATURE_XMM2))
 		n = __copy_user_intel_nocache(to, from, n);
@@ -334,7 +335,7 @@ unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __user *fr
 #else
 	__copy_user(to, from, n);
 #endif
-	__uaccess_end();
+	user_access_end();
 	return n;
 }
-EXPORT_SYMBOL(__copy_from_user_ll_nocache_nozero);
+EXPORT_SYMBOL(copy_from_user_inatomic_nontemporal);
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 654280aaa3e9..c47d8cd0e243 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -43,17 +43,17 @@ void arch_wb_cache_pmem(void *addr, size_t size)
 }
 EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
 
-long __copy_user_flushcache(void *dst, const void __user *src, unsigned size)
+size_t copy_user_flushcache(void *dst, const void __user *src, size_t size)
 {
 	unsigned long flushed, dest = (unsigned long) dst;
-	long rc;
+	unsigned long rc;
 
-	stac();
-	rc = __copy_user_nocache(dst, src, size);
-	clac();
+	src = masked_user_access_begin(src);
+	rc = copy_to_nontemporal(dst, (__force const void *)src, size);
+	user_access_end();
 
 	/*
-	 * __copy_user_nocache() uses non-temporal stores for the bulk
+	 * copy_to_nontemporal() uses non-temporal stores for the bulk
 	 * of the transfer, but we need to manually flush if the
 	 * transfer is unaligned. A cached memory copy is used when
 	 * destination or size is not naturally aligned. That is:
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index bc78c915eabc..8953e2ffd55c 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -705,8 +705,8 @@ void af_alg_pull_tsgl(struct sock *sk, size_t used, struct scatterlist *dst)
 			 * Assumption: caller created af_alg_count_tsgl(len)
 			 * SG entries in dst.
 			 */
-			if (dst) {
-				/* reassign page to dst after offset */
+			if (dst && plen) {
+				/* reassign page to dst */
 				get_page(page);
 				sg_set_page(dst + j, page, plen, sg[i].offset);
 				j++;
@@ -1229,6 +1229,8 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr *msg, int flags,
 
 		seglen = min_t(size_t, (maxsize - len),
 			       msg_data_left(msg));
+		/* Never pin more pages than the remaining RX accounting budget. */
+		seglen = min_t(size_t, seglen, af_alg_rcvbuf(sk));
 
 		if (list_empty(&areq->rsgl_list)) {
 			rsgl = &areq->first_rsgl;
diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index dda15bb05e89..f8bd45f7dc83 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -144,7 +144,7 @@ static int _aead_recvmsg(struct socket *sock, struct msghdr *msg,
 	if (usedpages < outlen) {
 		size_t less = outlen - usedpages;
 
-		if (used < less) {
+		if (used < less + (ctx->enc ? 0 : as)) {
 			err = -EINVAL;
 			goto free;
 		}
diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 82735e51be10..ba0a17fd95ac 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -130,6 +130,11 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	 * full block size buffers.
 	 */
 	if (ctx->more || len < ctx->used) {
+		if (len < bs) {
+			err = -EINVAL;
+			goto free;
+		}
+
 		len -= len % bs;
 		cflags |= CRYPTO_SKCIPHER_REQ_NOTFINAL;
 	}
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 931d0081169b..1d73a53370cf 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -68,6 +68,7 @@ enum board_ids {
 	/* board IDs for specific chipsets in alphabetical order */
 	board_ahci_al,
 	board_ahci_avn,
+	board_ahci_jmb585,
 	board_ahci_mcp65,
 	board_ahci_mcp77,
 	board_ahci_mcp89,
@@ -212,6 +213,15 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_avn_ops,
 	},
+	/* JMicron JMB582/585: 64-bit DMA is broken, force 32-bit */
+	[board_ahci_jmb585] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR |
+				 AHCI_HFLAG_32BIT_ONLY),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_mcp65] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_FPDMA_AA | AHCI_HFLAG_NO_PMP |
 				 AHCI_HFLAG_YES_NCQ),
@@ -439,6 +449,10 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	/* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not tested yet */
 	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci_pcs_quirk }, /* Elkhart Lake AHCI */
 
+	/* JMicron JMB582/585: force 32-bit DMA (broken 64-bit implementation) */
+	{ PCI_VDEVICE(JMICRON, 0x0582), board_ahci_jmb585 },
+	{ PCI_VDEVICE(JMICRON, 0x0585), board_ahci_jmb585 },
+
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci_ign_iferr },
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 4013f970cb3b..f4b134c86516 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1121,7 +1121,11 @@ int idxd_device_config(struct idxd_device *idxd)
 {
 	int rc;
 
-	lockdep_assert_held(&idxd->dev_lock);
+	guard(spinlock)(&idxd->dev_lock);
+
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return 0;
+
 	rc = idxd_wqs_setup(idxd);
 	if (rc < 0)
 		return rc;
@@ -1448,11 +1452,7 @@ int idxd_drv_enable_wq(struct idxd_wq *wq)
 		}
 	}
 
-	rc = 0;
-	spin_lock(&idxd->dev_lock);
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
-		rc = idxd_device_config(idxd);
-	spin_unlock(&idxd->dev_lock);
+	rc = idxd_device_config(idxd);
 	if (rc < 0) {
 		dev_dbg(dev, "Writing wq %d config failed: %d\n", wq->id, rc);
 		goto err;
@@ -1547,10 +1547,7 @@ int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 	}
 
 	/* Device configuration */
-	spin_lock(&idxd->dev_lock);
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
-		rc = idxd_device_config(idxd);
-	spin_unlock(&idxd->dev_lock);
+	rc = idxd_device_config(idxd);
 	if (rc < 0)
 		return -ENXIO;
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f2b37c63a964..afba88f9c3e4 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1094,12 +1094,10 @@ static void idxd_reset_done(struct pci_dev *pdev)
 	idxd_device_config_restore(idxd, idxd->idxd_saved);
 
 	/* Re-configure IDXD device if allowed. */
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
-		rc = idxd_device_config(idxd);
-		if (rc < 0) {
-			dev_err(dev, "HALT: %s config fails\n", idxd_name);
-			goto out;
-		}
+	rc = idxd_device_config(idxd);
+	if (rc < 0) {
+		dev_err(dev, "HALT: %s config fails\n", idxd_name);
+		goto out;
 	}
 
 	/* Bind IDXD device to driver. */
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 15a5762a82c2..b14052fe64ac 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -595,7 +595,7 @@ static void tegra_gpio_irq_release_resources(struct irq_data *d)
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
 
 	gpiochip_relres_irq(chip, d->hwirq);
-	tegra_gpio_enable(tgi, d->hwirq);
+	tegra_gpio_disable(tgi, d->hwirq);
 }
 
 static void tegra_gpio_irq_print_chip(struct irq_data *d, struct seq_file *s)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7df6e75bd701..636a0cbbb144 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2974,14 +2974,14 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	if (!root)
 		return false;
 
-	addr /= AMDGPU_GPU_PAGE_SIZE;
-
 	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
-	    node_id, addr, ts, write_fault)) {
+	    node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
 		amdgpu_bo_unref(&root);
 		return true;
 	}
 
+	addr /= AMDGPU_GPU_PAGE_SIZE;
+
 	r = amdgpu_bo_reserve(root, true);
 	if (r)
 		goto error_unref;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 2822c90bd7be..b97f4a51db6e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -444,10 +444,11 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
 		    min(cu_num * 40, props->array_count / props->simd_arrays_per_engine * 512)
 		    : cu_num * 32;
 
-	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props), PAGE_SIZE);
+	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props),
+				AMDGPU_GPU_PAGE_SIZE);
 	ctl_stack_size = wave_num * CNTL_STACK_BYTES_PER_WAVE(gfxv) + 8;
 	ctl_stack_size = ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
-			       PAGE_SIZE);
+			       AMDGPU_GPU_PAGE_SIZE);
 
 	if ((gfxv / 10000 * 10000) == 100000) {
 		/* HW design limits control stack size to 0x7000.
@@ -459,7 +460,7 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
 
 	props->ctl_stack_size = ctl_stack_size;
 	props->debug_memory_size = ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
-	props->cwsr_size = ctl_stack_size + wg_data_size;
+	props->cwsr_size = ALIGN(ctl_stack_size + wg_data_size, PAGE_SIZE);
 
 	if (gfxv == 80002)	/* GFX_VERSION_TONGA */
 		props->eop_buffer_size = 0x8000;
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 4c82c9544b93..72fe91ed1c74 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -520,7 +520,7 @@ ggtt_write(struct io_mapping *mapping,
 
 	/* We can use the cpu mem copy function because this is X86. */
 	vaddr = io_mapping_map_atomic_wc(mapping, base);
-	unwritten = __copy_from_user_inatomic_nocache((void __force *)vaddr + offset,
+	unwritten = copy_from_user_inatomic_nontemporal((void __force *)vaddr + offset,
 						      user_data, length);
 	io_mapping_unmap_atomic(vaddr);
 	if (unwritten) {
diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 336cbff26089..26545a08cdf7 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -184,7 +184,7 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 
 	/* TODO copy slow path code from i915 */
 	fb_cmd = qxl_bo_kmap_atomic_page(qdev, cmd_bo, (release->release_offset & PAGE_MASK));
-	unwritten = __copy_from_user_inatomic_nocache
+	unwritten = copy_from_user_inatomic_nontemporal
 		(fb_cmd + sizeof(union qxl_release_info) + (release->release_offset & ~PAGE_MASK),
 		 u64_to_user_ptr(cmd->command), cmd->command_size);
 
diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 46b4474ac41d..44b1f2b00f9b 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -739,12 +739,15 @@ static int vc4_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct
 		return -EINVAL;
 	}
 
+	mutex_lock(&bo->madv_lock);
 	if (bo->madv != VC4_MADV_WILLNEED) {
 		DRM_DEBUG("mmapping of %s BO not allowed\n",
 			  bo->madv == VC4_MADV_DONTNEED ?
 			  "purgeable" : "purged");
+		mutex_unlock(&bo->madv_lock);
 		return -EINVAL;
 	}
+	mutex_unlock(&bo->madv_lock);
 
 	return drm_gem_dma_mmap(&bo->base, vma);
 }
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index ab16164b5eda..840aadb14b51 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -62,6 +62,7 @@ vc4_free_hang_state(struct drm_device *dev, struct vc4_hang_state *state)
 	for (i = 0; i < state->user_state.bo_count; i++)
 		drm_gem_object_put(state->bo[i]);
 
+	kfree(state->bo);
 	kfree(state);
 }
 
@@ -170,10 +171,8 @@ vc4_save_hang_state(struct drm_device *dev)
 	spin_lock_irqsave(&vc4->job_lock, irqflags);
 	exec[0] = vc4_first_bin_job(vc4);
 	exec[1] = vc4_first_render_job(vc4);
-	if (!exec[0] && !exec[1]) {
-		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
-		return;
-	}
+	if (!exec[0] && !exec[1])
+		goto err_free_state;
 
 	/* Get the bos from both binner and renderer into hang state. */
 	state->bo_count = 0;
@@ -190,10 +189,8 @@ vc4_save_hang_state(struct drm_device *dev)
 	kernel_state->bo = kcalloc(state->bo_count,
 				   sizeof(*kernel_state->bo), GFP_ATOMIC);
 
-	if (!kernel_state->bo) {
-		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
-		return;
-	}
+	if (!kernel_state->bo)
+		goto err_free_state;
 
 	k = 0;
 	for (i = 0; i < 2; i++) {
@@ -285,6 +282,12 @@ vc4_save_hang_state(struct drm_device *dev)
 		vc4->hang_state = kernel_state;
 		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 	}
+
+	return;
+
+err_free_state:
+	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
+	kfree(kernel_state);
 }
 
 static void
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 1798d1156d10..d89a0ec5d772 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2349,17 +2349,23 @@ static int vc4_hdmi_hotplug_init(struct vc4_hdmi *vc4_hdmi)
 	int ret;
 
 	if (vc4_hdmi->variant->external_irq_controller) {
-		unsigned int hpd_con = platform_get_irq_byname(pdev, "hpd-connected");
-		unsigned int hpd_rm = platform_get_irq_byname(pdev, "hpd-removed");
+		int hpd = platform_get_irq_byname(pdev, "hpd-connected");
 
-		ret = devm_request_threaded_irq(&pdev->dev, hpd_con,
+		if (hpd < 0)
+			return hpd;
+
+		ret = devm_request_threaded_irq(&pdev->dev, hpd,
 						NULL,
 						vc4_hdmi_hpd_irq_thread, IRQF_ONESHOT,
 						"vc4 hdmi hpd connected", vc4_hdmi);
 		if (ret)
 			return ret;
 
-		ret = devm_request_threaded_irq(&pdev->dev, hpd_rm,
+		hpd = platform_get_irq_byname(pdev, "hpd-removed");
+		if (hpd < 0)
+			return hpd;
+
+		ret = devm_request_threaded_irq(&pdev->dev, hpd,
 						NULL,
 						vc4_hdmi_hpd_irq_thread, IRQF_ONESHOT,
 						"vc4 hdmi hpd disconnected", vc4_hdmi);
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 3ffe09bc89d2..d31b906cb8e7 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -481,6 +481,7 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, 40); /* a little over 2 frames. */
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index 6a9e2a4272dd..3e928b6c098f 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -596,9 +596,8 @@ static void adjust_idledly(struct xe_hw_engine *hwe)
 		maxcnt *= maxcnt_units_ns;
 
 		if (xe_gt_WARN_ON(gt, idledly >= maxcnt || inhibit_switch)) {
-			idledly = DIV_ROUND_CLOSEST(((maxcnt - 1) * maxcnt_units_ns),
+			idledly = DIV_ROUND_CLOSEST(((maxcnt - 1) * 1000),
 						    idledly_units_ps);
-			idledly = DIV_ROUND_CLOSEST(idledly, 1000);
 			xe_mmio_write32(&gt->mmio, RING_IDLEDLY(hwe->mmio_base), idledly);
 		}
 	}
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 1d9f955573aa..4b81cebdc335 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -413,7 +413,8 @@ static void sfh_init_work(struct work_struct *work)
 	rc = amd_sfh_hid_client_init(mp2);
 	if (rc) {
 		amd_sfh_clear_intr(mp2);
-		dev_err(&pdev->dev, "amd_sfh_hid_client_init failed err %d\n", rc);
+		if (rc != -EOPNOTSUPP)
+			dev_err(&pdev->dev, "amd_sfh_hid_client_init failed err %d\n", rc);
 		return;
 	}
 
diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index ba00f6e6324b..8c3f83532ce9 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -437,6 +437,9 @@ static int alps_raw_event(struct hid_device *hdev,
 	int ret = 0;
 	struct alps_dev *hdata = hid_get_drvdata(hdev);
 
+	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !hdata->input)
+		return 0;
+
 	switch (hdev->product) {
 	case HID_PRODUCT_ID_T4_BTNLESS:
 		ret = t4_raw_event(hdata, data, size);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f5587b786f87..8be4e06af463 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -71,6 +71,9 @@ static u32 s32ton(__s32 value, unsigned int n)
 	if (!value || !n)
 		return 0;
 
+	if (n > 32)
+		n = 32;
+
 	a = value >> (n - 1);
 	if (a && a != -1)
 		return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 7fd67745ee01..666ce30c83b4 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -22,6 +22,9 @@
 #define USB_DEVICE_ID_3M2256		0x0502
 #define USB_DEVICE_ID_3M3266		0x0506
 
+#define USB_VENDOR_ID_8BITDO		0x2dc8
+#define USB_DEVICE_ID_8BITDO_PRO_3	0x6009
+
 #define USB_VENDOR_ID_A4TECH		0x09da
 #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
 #define USB_DEVICE_ID_A4TECH_X5_005D	0x000a
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 3217e436c052..f6be3ffee023 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -25,6 +25,7 @@
  */
 
 static const struct hid_device_id hid_quirks[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_8BITDO, USB_DEVICE_ID_8BITDO_PRO_3), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ADATA_XPG, USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE), HID_QUIRK_ALWAYS_POLL },
diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index c7f7562e22e5..e413662f7508 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -257,6 +257,7 @@ int roccat_report_event(int minor, u8 const *data)
 	if (!new_value)
 		return -ENOMEM;
 
+	mutex_lock(&device->readers_lock);
 	mutex_lock(&device->cbuf_lock);
 
 	report = &device->cbuf[device->cbuf_end];
@@ -279,6 +280,7 @@ int roccat_report_event(int minor, u8 const *data)
 	}
 
 	mutex_unlock(&device->cbuf_lock);
+	mutex_unlock(&device->readers_lock);
 
 	wake_up_interruptible(&device->wait);
 	return 0;
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index ad6bd59963b2..b6a69995692c 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -37,6 +37,10 @@ struct quickspi_driver_data arl = {
 	.max_packet_size_value = MAX_PACKET_SIZE_VALUE_MTL,
 };
 
+struct quickspi_driver_data nvl = {
+	.max_packet_size_value = MAX_PACKET_SIZE_VALUE_LNL,
+};
+
 /* THC QuickSPI ACPI method to get device properties */
 /* HIDSPI Method: {6e2ac436-0fcf-41af-a265-b32a220dcfab} */
 static guid_t hidspi_guid =
@@ -982,6 +986,8 @@ static const struct pci_device_id quickspi_pci_tbl[] = {
 	{PCI_DEVICE_DATA(INTEL, THC_WCL_DEVICE_ID_SPI_PORT2, &ptl), },
 	{PCI_DEVICE_DATA(INTEL, THC_ARL_DEVICE_ID_SPI_PORT1, &arl), },
 	{PCI_DEVICE_DATA(INTEL, THC_ARL_DEVICE_ID_SPI_PORT2, &arl), },
+	{PCI_DEVICE_DATA(INTEL, THC_NVL_H_DEVICE_ID_SPI_PORT1, &nvl), },
+	{PCI_DEVICE_DATA(INTEL, THC_NVL_H_DEVICE_ID_SPI_PORT2, &nvl), },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, quickspi_pci_tbl);
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index c30e1a42eb09..bf5e18f5a5f4 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -23,6 +23,8 @@
 #define PCI_DEVICE_ID_INTEL_THC_WCL_DEVICE_ID_SPI_PORT2 	0x4D4B
 #define PCI_DEVICE_ID_INTEL_THC_ARL_DEVICE_ID_SPI_PORT1 	0x7749
 #define PCI_DEVICE_ID_INTEL_THC_ARL_DEVICE_ID_SPI_PORT2 	0x774B
+#define PCI_DEVICE_ID_INTEL_THC_NVL_H_DEVICE_ID_SPI_PORT1	0xD349
+#define PCI_DEVICE_ID_INTEL_THC_NVL_H_DEVICE_ID_SPI_PORT2	0xD34B
 
 /* HIDSPI special ACPI parameters DSM methods */
 #define ACPI_QUICKSPI_REVISION_NUM			2
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 45cf086ad430..5611be36f6a8 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -642,7 +642,7 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 {
 	struct mshv_partition *p = vp->vp_partition;
 	struct mshv_mem_region *region;
-	bool ret;
+	bool ret = false;
 	u64 gfn;
 #if defined(CONFIG_X86_64)
 	struct hv_x64_memory_intercept_message *msg =
@@ -653,6 +653,8 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 		(struct hv_arm64_memory_intercept_message *)
 		vp->vp_intercept_msg_page->u.payload;
 #endif
+	enum hv_intercept_access_type access_type =
+		msg->header.intercept_access_type;
 
 	gfn = HVPFN_DOWN(msg->guest_physical_address);
 
@@ -660,12 +662,19 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 	if (!region)
 		return false;
 
+	if (access_type == HV_INTERCEPT_ACCESS_WRITE &&
+	    !(region->hv_map_flags & HV_MAP_GPA_WRITABLE))
+		goto put_region;
+
+	if (access_type == HV_INTERCEPT_ACCESS_EXECUTE &&
+	    !(region->hv_map_flags & HV_MAP_GPA_EXECUTABLE))
+		goto put_region;
+
 	/* Only movable memory ranges are supported for GPA intercepts */
 	if (region->type == MSHV_REGION_TYPE_MEM_MOVABLE)
 		ret = mshv_region_handle_gfn_fault(region, gfn);
-	else
-		ret = false;
 
+put_region:
 	mshv_region_put(region);
 
 	return ret;
diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c
index 4e663d5b4e33..a75b941bd6e2 100644
--- a/drivers/hwmon/powerz.c
+++ b/drivers/hwmon/powerz.c
@@ -108,6 +108,9 @@ static int powerz_read_data(struct usb_device *udev, struct powerz_priv *priv)
 {
 	int ret;
 
+	if (!priv->urb)
+		return -ENODEV;
+
 	priv->status = -ETIMEDOUT;
 	reinit_completion(&priv->completion);
 
@@ -224,6 +227,8 @@ static int powerz_probe(struct usb_interface *intf,
 	mutex_init(&priv->mutex);
 	init_completion(&priv->completion);
 
+	usb_set_intfdata(intf, priv);
+
 	hwmon_dev =
 	    devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,
 						 &powerz_chip_info, NULL);
@@ -232,8 +237,6 @@ static int powerz_probe(struct usb_interface *intf,
 		return PTR_ERR(hwmon_dev);
 	}
 
-	usb_set_intfdata(intf, priv);
-
 	return 0;
 }
 
@@ -244,6 +247,7 @@ static void powerz_disconnect(struct usb_interface *intf)
 	mutex_lock(&priv->mutex);
 	usb_kill_urb(priv->urb);
 	usb_free_urb(priv->urb);
+	priv->urb = NULL;
 	mutex_unlock(&priv->mutex);
 }
 
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 8138f5ef40f0..15e14a6fe6dc 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -503,8 +503,13 @@ static void i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 		i2c->msg->buf[i2c->msg_ptr++] = byte;
 
 		/* Add actual length to read for smbus block read */
-		if (i2c->msg->flags & I2C_M_RECV_LEN && i2c->msg->len == 1)
+		if (i2c->msg->flags & I2C_M_RECV_LEN && i2c->msg->len == 1) {
+			if (byte == 0 || byte > I2C_SMBUS_BLOCK_MAX) {
+				s3c24xx_i2c_stop(i2c, -EPROTO);
+				break;
+			}
 			i2c->msg->len += byte;
+		}
  prepare_read:
 		if (is_msglast(i2c)) {
 			/* last byte of buffer */
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index c454a006c78e..496d3fedaa9e 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3721,6 +3721,7 @@ static int irdma_rereg_mr_trans(struct irdma_mr *iwmr, u64 start, u64 len,
 
 err:
 	ib_umem_release(region);
+	iwmr->region = NULL;
 	return err;
 }
 
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 134a79eecfcb..3467797b5b01 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -92,12 +92,10 @@ static int rvt_wss_llc_size(void)
 static void cacheless_memcpy(void *dst, void *src, size_t n)
 {
 	/*
-	 * Use the only available X64 cacheless copy.  Add a __user cast
-	 * to quiet sparse.  The src agument is already in the kernel so
-	 * there are no security issues.  The extra fault recovery machinery
-	 * is not invoked.
+	 * Use the only available X64 cacheless copy.
+	 * The extra fault recovery machinery is not invoked.
 	 */
-	__copy_user_nocache(dst, (void __user *)src, n);
+	copy_to_nontemporal(dst, src, n);
 }
 
 void rvt_wss_exit(struct rvt_dev_info *rdi)
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 238d12ffdae8..5005a26af363 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1373,6 +1373,13 @@ static CLOSURE_CALLBACK(cached_dev_free)
 
 	mutex_unlock(&bch_register_lock);
 
+	/*
+	 * Wait for any pending sb_write to complete before free.
+	 * The sb_bio is embedded in struct cached_dev, so we must
+	 * ensure no I/O is in progress.
+	 */
+	closure_sync(&dc->sb_write);
+
 	if (dc->sb_disk)
 		folio_put(virt_to_folio(dc->sb_disk));
 
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
index 82b8ff38e8f1..4ac667a8de4c 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
@@ -215,6 +215,15 @@ static int fops_vcodec_release(struct file *file)
 	v4l2_fh_exit(&ctx->fh);
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
 
+	/*
+	 * Cancel any pending encode work before freeing the context.
+	 * Although v4l2_m2m_ctx_release() waits for m2m job completion,
+	 * the workqueue handler (mtk_venc_worker) may still be accessing
+	 * the context after v4l2_m2m_job_finish() returns. Without this,
+	 * a use-after-free occurs when the worker accesses ctx after kfree.
+	 */
+	cancel_work_sync(&ctx->encode_work);
+
 	spin_lock_irqsave(&dev->dev_ctx_lock, flags);
 	list_del_init(&ctx->list);
 	spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);
diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec-vp9.c b/drivers/media/platform/rockchip/rkvdec/rkvdec-vp9.c
index b4bf01e839ef..8fb6a1624a14 100644
--- a/drivers/media/platform/rockchip/rkvdec/rkvdec-vp9.c
+++ b/drivers/media/platform/rockchip/rkvdec/rkvdec-vp9.c
@@ -927,7 +927,8 @@ static void rkvdec_vp9_done(struct rkvdec_ctx *ctx,
 	update_ctx_last_info(vp9_ctx);
 }
 
-static void rkvdec_init_v4l2_vp9_count_tbl(struct rkvdec_ctx *ctx)
+static noinline_for_stack void
+rkvdec_init_v4l2_vp9_count_tbl(struct rkvdec_ctx *ctx)
 {
 	struct rkvdec_vp9_ctx *vp9_ctx = ctx->priv;
 	struct rkvdec_vp9_intra_frame_symbol_counts *intra_cnts = vp9_ctx->count_tbl.cpu;
diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
index 438483c62fac..52b2abe16dcf 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
@@ -237,8 +237,10 @@ static int vidtv_start_feed(struct dvb_demux_feed *feed)
 
 	if (dvb->nfeeds == 1) {
 		ret = vidtv_start_streaming(dvb);
-		if (ret < 0)
+		if (ret < 0) {
+			dvb->nfeeds--;
 			rc = ret;
+		}
 	}
 
 	mutex_unlock(&dvb->feed_lock);
diff --git a/drivers/media/test-drivers/vidtv/vidtv_channel.c b/drivers/media/test-drivers/vidtv/vidtv_channel.c
index 3541155c6fc6..aa177cf96b6a 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_channel.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_channel.c
@@ -341,6 +341,10 @@ vidtv_channel_pmt_match_sections(struct vidtv_channel *channels,
 					tail = vidtv_psi_pmt_stream_init(tail,
 									 s->type,
 									 e_pid);
+					if (!tail) {
+						vidtv_psi_pmt_stream_destroy(head);
+						return;
+					}
 
 					if (!head)
 						head = tail;
diff --git a/drivers/media/test-drivers/vidtv/vidtv_mux.c b/drivers/media/test-drivers/vidtv/vidtv_mux.c
index f99878eff7ac..7dad97881fdb 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_mux.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_mux.c
@@ -233,7 +233,7 @@ static u32 vidtv_mux_push_pcr(struct vidtv_mux *m)
 	/* the 27Mhz clock will feed both parts of the PCR bitfield */
 	args.pcr = m->timing.clk;
 
-	nbytes += vidtv_ts_pcr_write_into(args);
+	nbytes += vidtv_ts_pcr_write_into(&args);
 	m->mux_buf_offset += nbytes;
 
 	m->num_streamed_pcr++;
@@ -363,7 +363,7 @@ static u32 vidtv_mux_pad_with_nulls(struct vidtv_mux *m, u32 npkts)
 	args.continuity_counter = &ctx->cc;
 
 	for (i = 0; i < npkts; ++i) {
-		m->mux_buf_offset += vidtv_ts_null_write_into(args);
+		m->mux_buf_offset += vidtv_ts_null_write_into(&args);
 		args.dest_offset  = m->mux_buf_offset;
 	}
 
diff --git a/drivers/media/test-drivers/vidtv/vidtv_ts.c b/drivers/media/test-drivers/vidtv/vidtv_ts.c
index ca4bb9c40b78..cbe9aff9ffb5 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_ts.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_ts.c
@@ -48,7 +48,7 @@ void vidtv_ts_inc_cc(u8 *continuity_counter)
 		*continuity_counter = 0;
 }
 
-u32 vidtv_ts_null_write_into(struct null_packet_write_args args)
+u32 vidtv_ts_null_write_into(const struct null_packet_write_args *args)
 {
 	u32 nbytes = 0;
 	struct vidtv_mpeg_ts ts_header = {};
@@ -56,21 +56,21 @@ u32 vidtv_ts_null_write_into(struct null_packet_write_args args)
 	ts_header.sync_byte          = TS_SYNC_BYTE;
 	ts_header.bitfield           = cpu_to_be16(TS_NULL_PACKET_PID);
 	ts_header.payload            = 1;
-	ts_header.continuity_counter = *args.continuity_counter;
+	ts_header.continuity_counter = *args->continuity_counter;
 
 	/* copy TS header */
-	nbytes += vidtv_memcpy(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_memcpy(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       &ts_header,
 			       sizeof(ts_header));
 
-	vidtv_ts_inc_cc(args.continuity_counter);
+	vidtv_ts_inc_cc(args->continuity_counter);
 
 	/* fill the rest with empty data */
-	nbytes += vidtv_memset(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_memset(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       TS_FILL_BYTE,
 			       TS_PACKET_LEN - nbytes);
 
@@ -83,17 +83,17 @@ u32 vidtv_ts_null_write_into(struct null_packet_write_args args)
 	return nbytes;
 }
 
-u32 vidtv_ts_pcr_write_into(struct pcr_write_args args)
+u32 vidtv_ts_pcr_write_into(const struct pcr_write_args *args)
 {
 	u32 nbytes = 0;
 	struct vidtv_mpeg_ts ts_header = {};
 	struct vidtv_mpeg_ts_adaption ts_adap = {};
 
 	ts_header.sync_byte     = TS_SYNC_BYTE;
-	ts_header.bitfield      = cpu_to_be16(args.pid);
+	ts_header.bitfield      = cpu_to_be16(args->pid);
 	ts_header.scrambling    = 0;
 	/* cc is not incremented, but it is needed. see 13818-1 clause 2.4.3.3 */
-	ts_header.continuity_counter = *args.continuity_counter;
+	ts_header.continuity_counter = *args->continuity_counter;
 	ts_header.payload            = 0;
 	ts_header.adaptation_field   = 1;
 
@@ -102,27 +102,27 @@ u32 vidtv_ts_pcr_write_into(struct pcr_write_args args)
 	ts_adap.PCR    = 1;
 
 	/* copy TS header */
-	nbytes += vidtv_memcpy(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_memcpy(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       &ts_header,
 			       sizeof(ts_header));
 
 	/* write the adap after the TS header */
-	nbytes += vidtv_memcpy(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_memcpy(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       &ts_adap,
 			       sizeof(ts_adap));
 
 	/* write the PCR optional */
-	nbytes += vidtv_ts_write_pcr_bits(args.dest_buf,
-					  args.dest_offset + nbytes,
-					  args.pcr);
+	nbytes += vidtv_ts_write_pcr_bits(args->dest_buf,
+					  args->dest_offset + nbytes,
+					  args->pcr);
 
-	nbytes += vidtv_memset(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_memset(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       TS_FILL_BYTE,
 			       TS_PACKET_LEN - nbytes);
 
diff --git a/drivers/media/test-drivers/vidtv/vidtv_ts.h b/drivers/media/test-drivers/vidtv/vidtv_ts.h
index 09b4ffd02829..3606398e160d 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_ts.h
+++ b/drivers/media/test-drivers/vidtv/vidtv_ts.h
@@ -90,7 +90,7 @@ void vidtv_ts_inc_cc(u8 *continuity_counter);
  *
  * Return: The number of bytes written into the buffer.
  */
-u32 vidtv_ts_null_write_into(struct null_packet_write_args args);
+u32 vidtv_ts_null_write_into(const struct null_packet_write_args *args);
 
 /**
  * vidtv_ts_pcr_write_into - Write a PCR  packet into a buffer.
@@ -101,6 +101,6 @@ u32 vidtv_ts_null_write_into(struct null_packet_write_args args);
  *
  * Return: The number of bytes written into the buffer.
  */
-u32 vidtv_ts_pcr_write_into(struct pcr_write_args args);
+u32 vidtv_ts_pcr_write_into(const struct pcr_write_args *args);
 
 #endif //VIDTV_TS_H
diff --git a/drivers/media/usb/as102/as102_usb_drv.c b/drivers/media/usb/as102/as102_usb_drv.c
index e0ef66a522e2..44565f0297cd 100644
--- a/drivers/media/usb/as102/as102_usb_drv.c
+++ b/drivers/media/usb/as102/as102_usb_drv.c
@@ -403,7 +403,9 @@ static int as102_usb_probe(struct usb_interface *intf,
 failed_dvb:
 	as102_free_usb_stream_buffer(as102_dev);
 failed_stream:
+	usb_set_intfdata(intf, NULL);
 	usb_deregister_dev(intf, &as102_usb_class_driver);
+	return ret;
 failed:
 	usb_put_dev(as102_dev->bus_adap.usb_dev);
 	usb_set_intfdata(intf, NULL);
diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index 2dfa3242a7ab..14c35995cd95 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -2126,7 +2126,7 @@ static int em28xx_v4l2_open(struct file *filp)
 {
 	struct video_device *vdev = video_devdata(filp);
 	struct em28xx *dev = video_drvdata(filp);
-	struct em28xx_v4l2 *v4l2 = dev->v4l2;
+	struct em28xx_v4l2 *v4l2;
 	enum v4l2_buf_type fh_type = 0;
 	int ret;
 
@@ -2143,13 +2143,19 @@ static int em28xx_v4l2_open(struct file *filp)
 		return -EINVAL;
 	}
 
+	if (mutex_lock_interruptible(&dev->lock))
+		return -ERESTARTSYS;
+
+	v4l2 = dev->v4l2;
+	if (!v4l2) {
+		mutex_unlock(&dev->lock);
+		return -ENODEV;
+	}
+
 	em28xx_videodbg("open dev=%s type=%s users=%d\n",
 			video_device_node_name(vdev), v4l2_type_names[fh_type],
 			v4l2->users);
 
-	if (mutex_lock_interruptible(&dev->lock))
-		return -ERESTARTSYS;
-
 	ret = v4l2_fh_open(filp);
 	if (ret) {
 		dev_err(&dev->intf->dev,
diff --git a/drivers/media/usb/hackrf/hackrf.c b/drivers/media/usb/hackrf/hackrf.c
index 0b50de8775a3..c3c4247194d1 100644
--- a/drivers/media/usb/hackrf/hackrf.c
+++ b/drivers/media/usb/hackrf/hackrf.c
@@ -1485,7 +1485,7 @@ static int hackrf_probe(struct usb_interface *intf,
 	if (ret) {
 		dev_err(dev->dev,
 			"Failed to register as video device (%d)\n", ret);
-		goto err_v4l2_device_unregister;
+		goto err_v4l2_device_put;
 	}
 	dev_info(dev->dev, "Registered as %s\n",
 		 video_device_node_name(&dev->rx_vdev));
@@ -1513,8 +1513,9 @@ static int hackrf_probe(struct usb_interface *intf,
 	return 0;
 err_video_unregister_device_rx:
 	video_unregister_device(&dev->rx_vdev);
-err_v4l2_device_unregister:
-	v4l2_device_unregister(&dev->v4l2_dev);
+err_v4l2_device_put:
+	v4l2_device_put(&dev->v4l2_dev);
+	return ret;
 err_v4l2_ctrl_handler_free_tx:
 	v4l2_ctrl_handler_free(&dev->tx_ctrl_handler);
 err_v4l2_ctrl_handler_free_rx:
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index bb7782582f40..0d0190ae094a 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1225,7 +1225,11 @@ static int mcp251x_open(struct net_device *net)
 	}
 
 	mutex_lock(&priv->mcp_lock);
-	mcp251x_power_enable(priv->transceiver, 1);
+	ret = mcp251x_power_enable(priv->transceiver, 1);
+	if (ret) {
+		dev_err(&spi->dev, "failed to enable transceiver power: %pe\n", ERR_PTR(ret));
+		goto out_close_candev;
+	}
 
 	priv->force_quit = 0;
 	priv->tx_skb = NULL;
@@ -1272,6 +1276,7 @@ static int mcp251x_open(struct net_device *net)
 	mcp251x_hw_sleep(spi);
 out_close:
 	mcp251x_power_enable(priv->transceiver, 0);
+out_close_candev:
 	close_candev(net);
 	mutex_unlock(&priv->mcp_lock);
 	if (release_irq)
@@ -1516,11 +1521,25 @@ static int __maybe_unused mcp251x_can_resume(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
+	int ret = 0;
 
-	if (priv->after_suspend & AFTER_SUSPEND_POWER)
-		mcp251x_power_enable(priv->power, 1);
-	if (priv->after_suspend & AFTER_SUSPEND_UP)
-		mcp251x_power_enable(priv->transceiver, 1);
+	if (priv->after_suspend & AFTER_SUSPEND_POWER) {
+		ret = mcp251x_power_enable(priv->power, 1);
+		if (ret) {
+			dev_err(dev, "failed to restore power: %pe\n", ERR_PTR(ret));
+			return ret;
+		}
+	}
+
+	if (priv->after_suspend & AFTER_SUSPEND_UP) {
+		ret = mcp251x_power_enable(priv->transceiver, 1);
+		if (ret) {
+			dev_err(dev, "failed to restore transceiver power: %pe\n", ERR_PTR(ret));
+			if (priv->after_suspend & AFTER_SUSPEND_POWER)
+				mcp251x_power_enable(priv->power, 0);
+			return ret;
+		}
+	}
 
 	if (priv->after_suspend & (AFTER_SUSPEND_POWER | AFTER_SUSPEND_UP))
 		queue_work(priv->wq, &priv->restart_work);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 454d7dcf198d..fee5b2eddebb 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -697,9 +697,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		if (q->skb) {
 			dev_kfree_skb(q->skb);
 			q->skb = NULL;
-		} else {
-			page_pool_put_full_page(q->page_pool, page, true);
 		}
+		page_pool_put_full_page(q->page_pool, page, true);
 	}
 	airoha_qdma_fill_rx_queue(q);
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
index d64592b64e17..940ffffd11d8 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
@@ -194,6 +194,7 @@ void bnge_rdma_aux_device_add(struct bnge_dev *bd)
 		dev_warn(bd->dev, "Failed to add auxiliary device for ROCE\n");
 		auxiliary_device_uninit(aux_dev);
 		bd->flags &= ~BNGE_EN_ROCE;
+		return;
 	}
 
 	bd->auxr_dev->net = bd->netdev;
diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index e2a591cf9601..11edbb46a118 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -28,7 +28,7 @@ config FEC
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select CRC32
 	select PHYLIB
-	select FIXED_PHY if M5272
+	select FIXED_PHY
 	select PAGE_POOL
 	imply PAGE_POOL_STATS
 	imply NET_SELFTESTS
diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index 726365c567ef..75d0bfa7530b 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -496,14 +496,19 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		 */
 		ret_val = e1000_read_eeprom(hw, first_word, 1,
 					    &eeprom_buff[0]);
+		if (ret_val)
+			goto out;
+
 		ptr++;
 	}
-	if (((eeprom->offset + eeprom->len) & 1) && (ret_val == 0)) {
+	if ((eeprom->offset + eeprom->len) & 1) {
 		/* need read/modify/write of last changed EEPROM word
 		 * only the first byte of the word is being modified
 		 */
 		ret_val = e1000_read_eeprom(hw, last_word, 1,
 					    &eeprom_buff[last_word - first_word]);
+		if (ret_val)
+			goto out;
 	}
 
 	/* Device's eeprom is always little-endian, word addressable */
@@ -522,6 +527,7 @@ static int e1000_set_eeprom(struct net_device *netdev,
 	if ((ret_val == 0) && (first_word <= EEPROM_CHECKSUM_REG))
 		e1000_update_eeprom_checksum(hw);
 
+out:
 	kfree(eeprom_buff);
 	return ret_val;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 272683001476..082313023024 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3048,7 +3048,13 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
 	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
 	struct ice_ptp *ptp = &pf->ptp;
 
-	if (WARN_ON(!ctrl_ptp) || pf->hw.mac_type == ICE_MAC_UNKNOWN)
+	if (!ctrl_ptp) {
+		dev_info(ice_pf_to_dev(pf),
+			 "PTP unavailable: no controlling PF\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pf->hw.mac_type == ICE_MAC_UNKNOWN)
 		return -ENODEV;
 
 	INIT_LIST_HEAD(&ptp->port.list_node);
diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index d227f4d2a2d1..f32e640ef4ac 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -474,7 +474,7 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 	adapter->flags2 &= ~(IXGBE_FLAG2_API_MISMATCH |
 			     IXGBE_FLAG2_FW_ROLLBACK);
 
-	return 0;
+	return ixgbe_refresh_fw_version(adapter);
 }
 
 static const struct devlink_ops ixgbe_devlink_ops = {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index dce4936708eb..047f04045585 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -973,7 +973,7 @@ int ixgbe_init_interrupt_scheme(struct ixgbe_adapter *adapter);
 bool ixgbe_wol_supported(struct ixgbe_adapter *adapter, u16 device_id,
 			 u16 subdevice_id);
 void ixgbe_set_fw_version_e610(struct ixgbe_adapter *adapter);
-void ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter);
+int ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter);
 #ifdef CONFIG_PCI_IOV
 void ixgbe_full_sync_mac_table(struct ixgbe_adapter *adapter);
 #endif
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 2ad81f687a84..d82c51f673ec 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1153,12 +1153,17 @@ static int ixgbe_set_eeprom(struct net_device *netdev,
 	return ret_val;
 }
 
-void ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter)
+int ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
+	int err;
+
+	err = ixgbe_get_flash_data(hw);
+	if (err)
+		return err;
 
-	ixgbe_get_flash_data(hw);
 	ixgbe_set_fw_version_e610(adapter);
+	return 0;
 }
 
 static void ixgbe_get_drvinfo(struct net_device *netdev,
@@ -1166,10 +1171,6 @@ static void ixgbe_get_drvinfo(struct net_device *netdev,
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 
-	/* need to refresh info for e610 in case fw reloads in runtime */
-	if (adapter->hw.mac.type == ixgbe_mac_e610)
-		ixgbe_refresh_fw_version(adapter);
-
 	strscpy(drvinfo->driver, ixgbe_driver_name, sizeof(drvinfo->driver));
 
 	strscpy(drvinfo->fw_version, adapter->eeprom_id,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c58051e4350b..60eadef423ca 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6289,6 +6289,16 @@ void ixgbe_reinit_locked(struct ixgbe_adapter *adapter)
 	if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
 		msleep(2000);
 	ixgbe_up(adapter);
+
+	/* E610 has no FW event to notify all PFs of an EMPR reset, so
+	 * refresh the FW version here to pick up any new FW version after
+	 * a hardware reset (e.g. EMPR triggered by another PF's devlink
+	 * reload).  ixgbe_refresh_fw_version() updates both hw->flash and
+	 * adapter->eeprom_id so ethtool -i reports the correct string.
+	 */
+	if (adapter->hw.mac.type == ixgbe_mac_e610)
+		(void)ixgbe_refresh_fw_version(adapter);
+
 	clear_bit(__IXGBE_RESETTING, &adapter->state);
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index b67b580f7f1c..f6df86d124b9 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -709,6 +709,12 @@ static int ixgbevf_negotiate_features_vf(struct ixgbe_hw *hw, u32 *pf_features)
 	return err;
 }
 
+static int ixgbevf_hv_negotiate_features_vf(struct ixgbe_hw *hw,
+					    u32 *pf_features)
+{
+	return -EOPNOTSUPP;
+}
+
 /**
  *  ixgbevf_set_vfta_vf - Set/Unset VLAN filter table address
  *  @hw: pointer to the HW structure
@@ -1142,6 +1148,7 @@ static const struct ixgbe_mac_operations ixgbevf_hv_mac_ops = {
 	.setup_link		= ixgbevf_setup_mac_link_vf,
 	.check_link		= ixgbevf_hv_check_mac_link_vf,
 	.negotiate_api_version	= ixgbevf_hv_negotiate_api_version_vf,
+	.negotiate_features	= ixgbevf_hv_negotiate_features_vf,
 	.set_rar		= ixgbevf_hv_set_rar_vf,
 	.update_mc_addr_list	= ixgbevf_hv_update_mc_addr_list_vf,
 	.update_xcast_mode	= ixgbevf_hv_update_xcast_mode,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index d765acbe3754..21a0a11fc011 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -9,7 +9,7 @@
 #include "stmmac_platform.h"
 
 static const char *const mgbe_clks[] = {
-	"rx-pcs", "tx", "tx-pcs", "mac-divider", "mac", "mgbe", "ptp-ref", "mac"
+	"rx-pcs", "tx", "tx-pcs", "mac-divider", "mac", "mgbe", "ptp_ref", "mac"
 };
 
 struct tegra_mgbe {
@@ -215,6 +215,7 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_resources res;
+	bool use_legacy_ptp = false;
 	struct tegra_mgbe *mgbe;
 	int irq, err, i;
 	u32 value;
@@ -257,9 +258,23 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 	if (!mgbe->clks)
 		return -ENOMEM;
 
-	for (i = 0; i <  ARRAY_SIZE(mgbe_clks); i++)
+	/* Older device-trees use 'ptp-ref' rather than 'ptp_ref'.
+	 * Fall back when the legacy name is present.
+	 */
+	if (of_property_match_string(pdev->dev.of_node, "clock-names",
+				     "ptp-ref") >= 0)
+		use_legacy_ptp = true;
+
+	for (i = 0; i < ARRAY_SIZE(mgbe_clks); i++) {
 		mgbe->clks[i].id = mgbe_clks[i];
 
+		if (use_legacy_ptp && !strcmp(mgbe_clks[i], "ptp_ref")) {
+			dev_warn(mgbe->dev,
+				 "Device-tree update needed for PTP clock!\n");
+			mgbe->clks[i].id = "ptp-ref";
+		}
+	}
+
 	err = devm_clk_bulk_get(mgbe->dev, ARRAY_SIZE(mgbe_clks), mgbe->clks);
 	if (err < 0)
 		return err;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 82433e9cb0e3..6b05f32b4a01 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -424,10 +424,10 @@ struct txgbe_nodes {
 	char i2c_name[32];
 	char sfp_name[32];
 	char phylink_name[32];
-	struct property_entry gpio_props[1];
-	struct property_entry i2c_props[3];
-	struct property_entry sfp_props[8];
-	struct property_entry phylink_props[2];
+	struct property_entry gpio_props[2];
+	struct property_entry i2c_props[4];
+	struct property_entry sfp_props[9];
+	struct property_entry phylink_props[3];
 	struct software_node_ref_args i2c_ref[1];
 	struct software_node_ref_args gpio0_ref[1];
 	struct software_node_ref_args gpio1_ref[1];
diff --git a/drivers/net/ipa/reg/gsi_reg-v5.0.c b/drivers/net/ipa/reg/gsi_reg-v5.0.c
index 36d1e65df71b..6c4a7fbe4de9 100644
--- a/drivers/net/ipa/reg/gsi_reg-v5.0.c
+++ b/drivers/net/ipa/reg/gsi_reg-v5.0.c
@@ -30,7 +30,7 @@ REG_STRIDE_FIELDS(CH_C_CNTXT_0, ch_c_cntxt_0,
 
 static const u32 reg_ch_c_cntxt_1_fmask[] = {
 	[CH_R_LENGTH]					= GENMASK(23, 0),
-	[ERINDEX]					= GENMASK(31, 24),
+	[CH_ERINDEX]					= GENMASK(31, 24),
 };
 
 REG_STRIDE_FIELDS(CH_C_CNTXT_1, ch_c_cntxt_1,
@@ -156,9 +156,10 @@ REG_FIELDS(EV_CH_CMD, ev_ch_cmd, 0x00025010 + 0x12000 * GSI_EE_AP);
 
 static const u32 reg_generic_cmd_fmask[] = {
 	[GENERIC_OPCODE]				= GENMASK(4, 0),
-	[GENERIC_CHID]					= GENMASK(9, 5),
-	[GENERIC_EE]					= GENMASK(13, 10),
-						/* Bits 14-31 reserved */
+	[GENERIC_CHID]					= GENMASK(12, 5),
+	[GENERIC_EE]					= GENMASK(16, 13),
+						/* Bits 17-23 reserved */
+	[GENERIC_PARAMS]				= GENMASK(31, 24),
 };
 
 REG_FIELDS(GENERIC_CMD, generic_cmd, 0x00025018 + 0x12000 * GSI_EE_AP);
diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
index 405a07075dd1..8d5fb014ca06 100644
--- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -466,7 +466,6 @@ static int rtl9300_mdiobus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rtl9300_mdio_priv *priv;
-	struct fwnode_handle *child;
 	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -487,7 +486,7 @@ static int rtl9300_mdiobus_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		err = rtl9300_mdiobus_probe_one(dev, priv, child);
 		if (err)
 			return err;
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 7a85b758fb1e..c62e3f364ea7 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -543,6 +543,22 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault_and_los),
 
+	// Hisense LXT-010S-H is a GPON ONT SFP (sold as LEOX LXT-010S-H) that
+	// can operate at 2500base-X, but reports 1000BASE-LX / 1300MBd in its
+	// EEPROM
+	SFP_QUIRK("Hisense-Leox", "LXT-010S-H", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
+	// Hisense ZNID-GPON-2311NA can operate at 2500base-X, but reports
+	// 1000BASE-LX / 1300MBd in its EEPROM
+	SFP_QUIRK("Hisense", "ZNID-GPON-2311NA", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
+	// HSGQ HSGQ-XPON-Stick can operate at 2500base-X, but reports
+	// 1000BASE-LX / 1300MBd in its EEPROM
+	SFP_QUIRK("HSGQ", "HSGQ-XPON-Stick", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
 	// Lantech 8330-262D-E and 8330-265D can operate at 2500base-X, but
 	// incorrectly report 2500MBd NRZ in their EEPROM.
 	// Some 8330-265D modules have inverted LOS, while all of them report
diff --git a/drivers/net/usb/cdc-phonet.c b/drivers/net/usb/cdc-phonet.c
index ad5121e9cf5d..165650ecef64 100644
--- a/drivers/net/usb/cdc-phonet.c
+++ b/drivers/net/usb/cdc-phonet.c
@@ -157,11 +157,16 @@ static void rx_complete(struct urb *req)
 						PAGE_SIZE);
 				page = NULL;
 			}
-		} else {
+		} else if (skb_shinfo(skb)->nr_frags < MAX_SKB_FRAGS) {
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 					page, 0, req->actual_length,
 					PAGE_SIZE);
 			page = NULL;
+		} else {
+			dev_kfree_skb_any(skb);
+			pnd->rx_skb = NULL;
+			skb = NULL;
+			dev->stats.rx_length_errors++;
 		}
 		if (req->actual_length < PAGE_SIZE)
 			pnd->rx_skb = NULL; /* Last fragment */
diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index f357a7ac70ac..9861c99ea56c 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -446,33 +446,36 @@ static void lapbeth_free_device(struct lapbethdev *lapbeth)
 static int lapbeth_device_event(struct notifier_block *this,
 				unsigned long event, void *ptr)
 {
-	struct lapbethdev *lapbeth;
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct lapbethdev *lapbeth;
 
 	if (dev_net(dev) != &init_net)
 		return NOTIFY_DONE;
 
-	if (!dev_is_ethdev(dev) && !lapbeth_get_x25_dev(dev))
+	lapbeth = lapbeth_get_x25_dev(dev);
+	if (!dev_is_ethdev(dev) && !lapbeth)
 		return NOTIFY_DONE;
 
 	switch (event) {
 	case NETDEV_UP:
 		/* New ethernet device -> new LAPB interface	 */
-		if (!lapbeth_get_x25_dev(dev))
+		if (!lapbeth)
 			lapbeth_new_device(dev);
 		break;
 	case NETDEV_GOING_DOWN:
 		/* ethernet device closes -> close LAPB interface */
-		lapbeth = lapbeth_get_x25_dev(dev);
 		if (lapbeth)
 			dev_close(lapbeth->axdev);
 		break;
 	case NETDEV_UNREGISTER:
 		/* ethernet device disappears -> remove LAPB interface */
-		lapbeth = lapbeth_get_x25_dev(dev);
 		if (lapbeth)
 			lapbeth_free_device(lapbeth);
 		break;
+	case NETDEV_PRE_TYPE_CHANGE:
+		/* Our underlying device type must not change. */
+		if (lapbeth)
+			return NOTIFY_BAD;
 	}
 
 	return NOTIFY_DONE;
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 46a71ec36af8..67b07ee2d660 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -411,12 +411,11 @@ static struct rtnl_link_ops link_ops __read_mostly = {
 	.newlink		= wg_newlink,
 };
 
-static void wg_netns_pre_exit(struct net *net)
+static void __net_exit wg_netns_exit_rtnl(struct net *net, struct list_head *dev_kill_list)
 {
 	struct wg_device *wg;
 	struct wg_peer *peer;
 
-	rtnl_lock();
 	list_for_each_entry(wg, &device_list, device_list) {
 		if (rcu_access_pointer(wg->creating_net) == net) {
 			pr_debug("%s: Creating namespace exiting\n", wg->dev->name);
@@ -429,11 +428,10 @@ static void wg_netns_pre_exit(struct net *net)
 			mutex_unlock(&wg->device_update_lock);
 		}
 	}
-	rtnl_unlock();
 }
 
-static struct pernet_operations pernet_ops = {
-	.pre_exit = wg_netns_pre_exit
+static struct pernet_operations pernet_ops __read_mostly = {
+	.exit_rtnl = wg_netns_exit_rtnl
 };
 
 int __init wg_device_init(void)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index c2d98ee6652f..1d25dc9ebca8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -153,6 +153,11 @@ static void brcmf_fweh_handle_if_event(struct brcmf_pub *drvr,
 		bphy_err(drvr, "invalid interface index: %u\n", ifevent->ifidx);
 		return;
 	}
+	if (ifevent->bsscfgidx >= BRCMF_MAX_IFS) {
+		bphy_err(drvr, "invalid bsscfg index: %u\n",
+			 ifevent->bsscfgidx);
+		return;
+	}
 
 	ifp = drvr->iflist[ifevent->bsscfgidx];
 
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 3b5126ffc81a..6e841a11c752 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -1040,7 +1040,7 @@ static int rtw_usb_intf_init(struct rtw_dev *rtwdev,
 			     struct usb_interface *intf)
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
-	struct usb_device *udev = usb_get_dev(interface_to_usbdev(intf));
+	struct usb_device *udev = interface_to_usbdev(intf);
 	int ret;
 
 	rtwusb->udev = udev;
@@ -1066,7 +1066,6 @@ static void rtw_usb_intf_deinit(struct rtw_dev *rtwdev,
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
 
-	usb_put_dev(rtwusb->udev);
 	kfree(rtwusb->usb_data);
 	usb_set_intfdata(intf, NULL);
 }
diff --git a/drivers/net/wireless/ti/wl1251/tx.c b/drivers/net/wireless/ti/wl1251/tx.c
index adb4840b0489..c264d83e71d9 100644
--- a/drivers/net/wireless/ti/wl1251/tx.c
+++ b/drivers/net/wireless/ti/wl1251/tx.c
@@ -402,12 +402,14 @@ static void wl1251_tx_packet_cb(struct wl1251 *wl,
 	int hdrlen;
 	u8 *frame;
 
-	skb = wl->tx_frames[result->id];
-	if (skb == NULL) {
-		wl1251_error("SKB for packet %d is NULL", result->id);
+	if (unlikely(result->id >= ARRAY_SIZE(wl->tx_frames) ||
+		     wl->tx_frames[result->id] == NULL)) {
+		wl1251_error("invalid packet id %u", result->id);
 		return;
 	}
 
+	skb = wl->tx_frames[result->id];
+
 	info = IEEE80211_SKB_CB(skb);
 
 	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK) &&
diff --git a/drivers/nfc/s3fwrn5/uart.c b/drivers/nfc/s3fwrn5/uart.c
index 9c09c10c2a46..4ee481bd7e96 100644
--- a/drivers/nfc/s3fwrn5/uart.c
+++ b/drivers/nfc/s3fwrn5/uart.c
@@ -58,6 +58,12 @@ static size_t s3fwrn82_uart_read(struct serdev_device *serdev,
 	size_t i;
 
 	for (i = 0; i < count; i++) {
+		if (!phy->recv_skb) {
+			phy->recv_skb = alloc_skb(NCI_SKB_BUFF_LEN, GFP_KERNEL);
+			if (!phy->recv_skb)
+				return i;
+		}
+
 		skb_put_u8(phy->recv_skb, *data++);
 
 		if (phy->recv_skb->len < S3FWRN82_NCI_HEADER)
@@ -69,9 +75,7 @@ static size_t s3fwrn82_uart_read(struct serdev_device *serdev,
 
 		s3fwrn5_recv_frame(phy->common.ndev, phy->recv_skb,
 				   phy->common.mode);
-		phy->recv_skb = alloc_skb(NCI_SKB_BUFF_LEN, GFP_KERNEL);
-		if (!phy->recv_skb)
-			return 0;
+		phy->recv_skb = NULL;
 	}
 
 	return i;
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4d00263ebc93..2cee3c1729c3 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1810,12 +1810,13 @@ static void ntb_tx_copy_callback(void *data,
 
 static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
 {
-#ifdef ARCH_HAS_NOCACHE_UACCESS
+#ifdef copy_to_nontemporal
 	/*
 	 * Using non-temporal mov to improve performance on non-cached
-	 * writes, even though we aren't actually copying from user space.
+	 * writes. This only works if __iomem is strictly memory-like,
+	 * but that is the case on x86-64
 	 */
-	__copy_from_user_inatomic_nocache(offset, entry->buf, entry->len);
+	copy_to_nontemporal(offset, entry->buf, entry->len);
 #else
 	memcpy_toio(offset, entry->buf, entry->len);
 #endif
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 1e237d3538f9..7f1c1a2e5c69 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2486,6 +2486,14 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
 		if (!hv_dev)
 			continue;
 
+		/*
+		 * If the Hyper-V host doesn't provide a NUMA node for the
+		 * device, default to node 0. With NUMA_NO_NODE the kernel
+		 * may spread work across NUMA nodes, which degrades
+		 * performance on Hyper-V.
+		 */
+		set_dev_node(&dev->dev, 0);
+
 		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY &&
 		    hv_dev->desc.virtual_numa_node < num_possible_nodes())
 			/*
@@ -3781,7 +3789,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 					   hbus->bridge->domain_nr);
 	if (!hbus->wq) {
 		ret = -ENOMEM;
-		goto free_dom;
+		goto free_bus;
 	}
 
 	hdev->channel->next_request_id_callback = vmbus_next_request_id;
@@ -3877,8 +3885,6 @@ static int hv_pci_probe(struct hv_device *hdev,
 	vmbus_close(hdev->channel);
 destroy_wq:
 	destroy_workqueue(hbus->wq);
-free_dom:
-	pci_bus_release_emul_domain_nr(hbus->bridge->domain_nr);
 free_bus:
 	kfree(hbus);
 	return ret;
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 20a400e83439..65f5bbf28480 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -763,19 +763,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	}
 }
 
-/**
- * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST and VHOST
- *
- * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
- */
-static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
-{
-	pci_epc_remove_epf(ntb->epf->epc, ntb->epf, 0);
-	pci_epc_put(ntb->epf->epc);
-}
-
-
 /**
  * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -955,6 +942,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
  */
 static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 {
+	disable_delayed_work_sync(&ntb->cmd_handler);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);
@@ -1525,7 +1513,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	ret = epf_ntb_init_epc_bar(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to create NTB EPC\n");
-		goto err_bar_init;
+		return ret;
 	}
 
 	ret = epf_ntb_config_spad_bar_alloc(ntb);
@@ -1565,9 +1553,6 @@ static int epf_ntb_bind(struct pci_epf *epf)
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
 
-err_bar_init:
-	epf_ntb_epc_destroy(ntb);
-
 	return ret;
 }
 
@@ -1583,7 +1568,6 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-	epf_ntb_epc_destroy(ntb);
 
 	pci_unregister_driver(&vntb_pci_driver);
 }
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index cf9db8ac0f42..106835b5ee5a 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1610,7 +1610,7 @@ int intel_pinctrl_probe(struct platform_device *pdev,
 		value = readl(regs + REVID);
 		if (value == ~0u)
 			return -ENODEV;
-		if (((value & REVID_MASK) >> REVID_SHIFT) >= 0x94) {
+		if (((value & REVID_MASK) >> REVID_SHIFT) >= 0x92) {
 			community->features |= PINCTRL_FEATURE_DEBOUNCE;
 			community->features |= PINCTRL_FEATURE_1K_PD;
 		}
diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index 586f2f67c617..b89b3169e8be 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -664,6 +664,15 @@ int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 	if (mcp->irq && mcp->irq_controller) {
 		struct gpio_irq_chip *girq = &mcp->chip.irq;
 
+		/*
+		 * Disable all pin interrupts, to prevent the interrupt handler from
+		 * calling nested handlers for any currently-enabled interrupts that
+		 * do not (yet) have an actual handler.
+		 */
+		ret = mcp_write(mcp, MCP_GPINTEN, 0);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "can't disable interrupts\n");
+
 		gpio_irq_chip_set_chip(girq, &mcp23s08_irq_chip);
 		/* This will let us handle the parent IRQ in the driver */
 		girq->parent_handler = NULL;
diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index ed285afaf9b0..24506e342943 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -203,6 +203,15 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
 		}
 	},
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=221273 */
+	{
+		.ident = "Thinkpad L14 Gen3",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21C6"),
+		}
+	},
 	/* https://gitlab.freedesktop.org/drm/amd/-/issues/4434 */
 	{
 		.ident = "Lenovo Yoga 6 13ALC6",
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index a38a65f5c550..b4677c5bba5b 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -548,7 +548,7 @@ static const struct dmi_system_id asus_quirks[] = {
 		.callback = dmi_matched,
 		.ident = "ASUS ROG Z13",
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUS"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Flow Z13"),
 		},
 		.driver_data = &quirk_asus_z13,
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index e3a7ac2485d6..7d03903cf221 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -182,6 +182,10 @@ static const struct dmi_system_id victus_s_thermal_profile_boards[] __initconst
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8BD5") },
 		.driver_data = (void *)&victus_s_thermal_params,
 	},
+	{
+		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8C76") },
+		.driver_data = (void *)&omen_v1_thermal_params,
+	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8C78") },
 		.driver_data = (void *)&omen_v1_thermal_params,
diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 67e9ac3d08ec..a90b100f4d10 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -39,7 +39,7 @@ static const char *siliconid_to_name(u32 siliconid)
 	unsigned int i;
 
 	for (i = 0 ; i < ARRAY_SIZE(rev_table) ; ++i) {
-		if (rev_table[i].id == id)
+		if ((rev_table[i].id & 0xff00ffff) == id)
 			return rev_table[i].name;
 	}
 
diff --git a/drivers/soc/microchip/mpfs-control-scb.c b/drivers/soc/microchip/mpfs-control-scb.c
index f0b84b1f49cb..8dda5704a389 100644
--- a/drivers/soc/microchip/mpfs-control-scb.c
+++ b/drivers/soc/microchip/mpfs-control-scb.c
@@ -14,8 +14,10 @@ static int mpfs_control_scb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
-	return mfd_add_devices(dev, PLATFORM_DEVID_NONE, mpfs_control_scb_devs,
-			       ARRAY_SIZE(mpfs_control_scb_devs), NULL, 0, NULL);
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				    mpfs_control_scb_devs,
+				    ARRAY_SIZE(mpfs_control_scb_devs), NULL, 0,
+				    NULL);
 }
 
 static const struct of_device_id mpfs_control_scb_of_match[] = {
diff --git a/drivers/soc/microchip/mpfs-mss-top-sysreg.c b/drivers/soc/microchip/mpfs-mss-top-sysreg.c
index b2244e44ff0f..b0f42b8dd3ed 100644
--- a/drivers/soc/microchip/mpfs-mss-top-sysreg.c
+++ b/drivers/soc/microchip/mpfs-mss-top-sysreg.c
@@ -16,8 +16,10 @@ static int mpfs_mss_top_sysreg_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE, mpfs_mss_top_sysreg_devs,
-			      ARRAY_SIZE(mpfs_mss_top_sysreg_devs) , NULL, 0, NULL);
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				   mpfs_mss_top_sysreg_devs,
+				   ARRAY_SIZE(mpfs_mss_top_sysreg_devs), NULL,
+				   0, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/soc/qcom/pdr_internal.h b/drivers/soc/qcom/pdr_internal.h
index 039508c1bbf7..047c0160b617 100644
--- a/drivers/soc/qcom/pdr_internal.h
+++ b/drivers/soc/qcom/pdr_internal.h
@@ -84,7 +84,7 @@ struct servreg_set_ack_resp {
 
 struct servreg_loc_pfr_req {
 	char service[SERVREG_NAME_LENGTH + 1];
-	char reason[257];
+	char reason[SERVREG_PFR_LENGTH + 1];
 };
 
 struct servreg_loc_pfr_resp {
diff --git a/drivers/soc/qcom/qcom_pdr_msg.c b/drivers/soc/qcom/qcom_pdr_msg.c
index ca98932140d8..02022b11ecf0 100644
--- a/drivers/soc/qcom/qcom_pdr_msg.c
+++ b/drivers/soc/qcom/qcom_pdr_msg.c
@@ -325,7 +325,7 @@ const struct qmi_elem_info servreg_loc_pfr_req_ei[] = {
 	},
 	{
 		.data_type = QMI_STRING,
-		.elem_len = SERVREG_NAME_LENGTH + 1,
+		.elem_len = SERVREG_PFR_LENGTH + 1,
 		.elem_size = sizeof(char),
 		.array_type = VAR_LEN_ARRAY,
 		.tlv_type = 0x02,
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 2f941ffbd465..5f64d5ae49db 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1313,7 +1313,7 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 	u8 mic[16];
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	__le16 le_tmp;
-	__le64 le_tmp64;
+	__le64 le_tmp64 = 0;
 
 	ori_len = pattrib->pkt_len - WLAN_HDR_A3_LEN + BIP_AAD_SIZE;
 	BIP_AAD = rtw_zmalloc(ori_len);
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 2d54d52ba357..458b528d98b3 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -481,6 +481,9 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	struct lynxfb_crtc *crtc;
 	resource_size_t request;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	ret = 0;
 	par = info->par;
 	crtc = &par->crtc;
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 76ce2e6c9864..782be75fb71b 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -114,6 +114,8 @@ static int acm_ctrl_msg(struct acm *acm, int request, int value,
 	int retval;
 
 	retval = usb_autopm_get_interface(acm->control);
+#define VENDOR_CLASS_DATA_IFACE		BIT(9)  /* data interface uses vendor-specific class */
+#define ALWAYS_POLL_CTRL		BIT(10) /* keep ctrl URB active even without an open TTY */
 	if (retval)
 		return retval;
 
@@ -710,12 +712,14 @@ static int acm_port_activate(struct tty_port *port, struct tty_struct *tty)
 	set_bit(TTY_NO_WRITE_SPLIT, &tty->flags);
 	acm->control->needs_remote_wakeup = 1;
 
-	acm->ctrlurb->dev = acm->dev;
-	retval = usb_submit_urb(acm->ctrlurb, GFP_KERNEL);
-	if (retval) {
-		dev_err(&acm->control->dev,
-			"%s - usb_submit_urb(ctrl irq) failed\n", __func__);
-		goto error_submit_urb;
+	if (!(acm->quirks & ALWAYS_POLL_CTRL)) {
+		acm->ctrlurb->dev = acm->dev;
+		retval = usb_submit_urb(acm->ctrlurb, GFP_KERNEL);
+		if (retval) {
+			dev_err(&acm->control->dev,
+				"%s - usb_submit_urb(ctrl irq) failed\n", __func__);
+			goto error_submit_urb;
+		}
 	}
 
 	acm_tty_set_termios(tty, NULL);
@@ -788,6 +792,14 @@ static void acm_port_shutdown(struct tty_port *port)
 
 	acm_unpoison_urbs(acm);
 
+	if (acm->quirks & ALWAYS_POLL_CTRL) {
+		acm->ctrlurb->dev = acm->dev;
+		if (usb_submit_urb(acm->ctrlurb, GFP_KERNEL))
+			dev_dbg(&acm->control->dev,
+				"ctrl polling restart failed after port close\n");
+		/* port_shutdown() cleared DTR/RTS; restore them */
+		acm_set_control(acm, USB_CDC_CTRL_DTR | USB_CDC_CTRL_RTS);
+	}
 }
 
 static void acm_tty_cleanup(struct tty_struct *tty)
@@ -1328,6 +1340,9 @@ static int acm_probe(struct usb_interface *intf,
 			dev_dbg(&intf->dev,
 				"Your device has switched interfaces.\n");
 			swap(control_interface, data_interface);
+		} else if (quirks & VENDOR_CLASS_DATA_IFACE) {
+			dev_dbg(&intf->dev,
+				"Vendor-specific data interface class, continuing.\n");
 		} else {
 			return -EINVAL;
 		}
@@ -1522,6 +1537,9 @@ static int acm_probe(struct usb_interface *intf,
 	acm->line.bDataBits = 8;
 	acm_set_line(acm, &acm->line);
 
+	if (quirks & ALWAYS_POLL_CTRL)
+		acm_set_control(acm, USB_CDC_CTRL_DTR | USB_CDC_CTRL_RTS);
+
 	if (!acm->combined_interfaces) {
 		rv = usb_driver_claim_interface(&acm_driver, data_interface, acm);
 		if (rv)
@@ -1543,6 +1561,13 @@ static int acm_probe(struct usb_interface *intf,
 
 	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
 
+	if (acm->quirks & ALWAYS_POLL_CTRL) {
+		acm->ctrlurb->dev = acm->dev;
+		if (usb_submit_urb(acm->ctrlurb, GFP_KERNEL))
+			dev_warn(&intf->dev,
+				 "failed to start persistent ctrl polling\n");
+	}
+
 	return 0;
 
 err_release_data_interface:
@@ -1669,7 +1694,7 @@ static int acm_resume(struct usb_interface *intf)
 
 	acm_unpoison_urbs(acm);
 
-	if (tty_port_initialized(&acm->port)) {
+	if (tty_port_initialized(&acm->port) || (acm->quirks & ALWAYS_POLL_CTRL)) {
 		rv = usb_submit_urb(acm->ctrlurb, GFP_ATOMIC);
 
 		for (;;) {
@@ -2016,6 +2041,20 @@ static const struct usb_device_id acm_ids[] = {
 	/* CH343 supports CAP_BRK, but doesn't advertise it */
 	{ USB_DEVICE(0x1a86, 0x55d3), .driver_info = MISSING_CAP_BRK, },
 
+	/*
+	 * Lenovo Yoga Book 9 14IAH10 (83KJ) — INGENIC 17EF:6161 touchscreen
+	 * composite device.  The CDC ACM control interface (0) uses a standard
+	 * Union descriptor, but the data interface (1) is declared as vendor-
+	 * specific class (0xff) with no CDC data descriptors, so cdc-acm would
+	 * normally reject it.  The firmware also requires continuous polling of
+	 * the notification endpoint (EP 0x82) to suppress a 20-second watchdog
+	 * reset; ALWAYS_POLL_CTRL keeps the ctrlurb active even when no TTY is
+	 * open.  Match only the control interface by class to avoid probing the
+	 * vendor-specific data interface.
+	 */
+	{ USB_DEVICE_INTERFACE_CLASS(0x17ef, 0x6161, USB_CLASS_COMM),
+	  .driver_info = VENDOR_CLASS_DATA_IFACE | ALWAYS_POLL_CTRL },
+
 	/* control interfaces without any protocol set */
 	{ USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ACM,
 		USB_CDC_PROTO_NONE) },
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index f54198171b6a..a47df5d32f7c 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -141,6 +141,7 @@ static ssize_t disable_store(struct device *dev, struct device_attribute *attr,
 		usb_disconnect(&port_dev->child);
 
 	rc = usb_hub_set_port_power(hdev, hub, port1, !disabled);
+	msleep(2 * hub_power_on_good_delay(hub));
 
 	if (disabled) {
 		usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_C_CONNECTION);
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 491bd6ee14e0..4fc82e51d6ea 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -106,7 +106,7 @@ struct f_hidg {
 	struct list_head		report_list;
 
 	struct device			dev;
-	struct cdev			cdev;
+	struct cdev			*cdev;
 	struct usb_function		func;
 
 	struct usb_ep			*in_ep;
@@ -749,8 +749,9 @@ static int f_hidg_release(struct inode *inode, struct file *fd)
 
 static int f_hidg_open(struct inode *inode, struct file *fd)
 {
+	struct kobject *parent = inode->i_cdev->kobj.parent;
 	struct f_hidg *hidg =
-		container_of(inode->i_cdev, struct f_hidg, cdev);
+		container_of(parent, struct f_hidg, dev.kobj);
 
 	fd->private_data = hidg;
 
@@ -1276,8 +1277,12 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	}
 
 	/* create char device */
-	cdev_init(&hidg->cdev, &f_hidg_fops);
-	status = cdev_device_add(&hidg->cdev, &hidg->dev);
+	hidg->cdev = cdev_alloc();
+	if (!hidg->cdev)
+		goto fail_free_all;
+	hidg->cdev->ops = &f_hidg_fops;
+
+	status = cdev_device_add(hidg->cdev, &hidg->dev);
 	if (status)
 		goto fail_free_all;
 
@@ -1579,7 +1584,7 @@ static void hidg_unbind(struct usb_configuration *c, struct usb_function *f)
 {
 	struct f_hidg *hidg = func_to_hidg(f);
 
-	cdev_device_del(&hidg->cdev, &hidg->dev);
+	cdev_device_del(hidg->cdev, &hidg->dev);
 	destroy_workqueue(hidg->workqueue);
 	usb_free_all_descriptors(f);
 }
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 834d64e22bdf..04be7047aa3d 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1210,8 +1210,8 @@ static int ncm_unwrap_ntb(struct gether *port,
 
 	block_len = get_ncm(&tmp, opts->block_length);
 	/* (d)wBlockLength */
-	if (block_len > ntb_max) {
-		INFO(port->func.config->cdev, "OUT size exceeded\n");
+	if ((block_len < opts->nth_size + opts->ndp_size) || (block_len > ntb_max)) {
+		INFO(port->func.config->cdev, "Bad block length: %#X\n", block_len);
 		goto err;
 	}
 
diff --git a/drivers/usb/gadget/function/f_phonet.c b/drivers/usb/gadget/function/f_phonet.c
index 0aa9e8224cae..a3e11c2011a8 100644
--- a/drivers/usb/gadget/function/f_phonet.c
+++ b/drivers/usb/gadget/function/f_phonet.c
@@ -333,6 +333,15 @@ static void pn_rx_complete(struct usb_ep *ep, struct usb_request *req)
 		if (unlikely(!skb))
 			break;
 
+		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS)) {
+			/* Frame count from host exceeds frags[] capacity */
+			dev_kfree_skb_any(skb);
+			if (fp->rx.skb == skb)
+				fp->rx.skb = NULL;
+			dev->stats.rx_length_errors++;
+			break;
+		}
+
 		if (skb->len == 0) { /* First fragment */
 			skb->protocol = htons(ETH_P_PHONET);
 			skb_reset_mac_header(skb);
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 7cdcc9d16b8b..ea89bcb9ad35 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -1669,6 +1669,10 @@ static bool usb3_std_req_get_status(struct renesas_usb3 *usb3,
 		break;
 	case USB_RECIP_ENDPOINT:
 		num = le16_to_cpu(ctrl->wIndex) & USB_ENDPOINT_NUMBER_MASK;
+		if (num >= usb3->num_usb3_eps) {
+			stall = true;
+			break;
+		}
 		usb3_ep = usb3_get_ep(usb3, num);
 		if (usb3_ep->halt)
 			status |= 1 << USB_ENDPOINT_HALT;
@@ -1781,7 +1785,8 @@ static bool usb3_std_req_feature_endpoint(struct renesas_usb3 *usb3,
 	struct renesas_usb3_ep *usb3_ep;
 	struct renesas_usb3_request *usb3_req;
 
-	if (le16_to_cpu(ctrl->wValue) != USB_ENDPOINT_HALT)
+	if ((le16_to_cpu(ctrl->wValue) != USB_ENDPOINT_HALT) ||
+	    (num >= usb3->num_usb3_eps))
 		return true;	/* stall */
 
 	usb3_ep = usb3_get_ep(usb3, num);
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 3eaab7645494..5f16ea44084f 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1383,6 +1383,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),	/* Telit FN990A (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1074, 0xff),	/* Telit FN990A (MBIM) */
+	  .driver_info = NCTRL(5) | RSVD(6) | RSVD(7) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990A (PCIe) */
 	  .driver_info = RSVD(0) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1077, 0xff),	/* Telit FN990A (rmnet + audio) */
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 47f50d7a385c..255968f9ca42 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2350,10 +2350,11 @@ UNUSUAL_DEV(  0x2027, 0xa001, 0x0000, 0x9999,
 		US_FL_SCM_MULT_TARG ),
 
 /*
- * Reported by DocMAX <mail@vacharakis.de>
- * and Thomas Weißschuh <linux@weissschuh.net>
+ * Reported by DocMAX <mail@vacharakis.de>,
+ * Thomas Weißschuh <linux@weissschuh.net>
+ * and Daniel Brát <danek.brat@gmail.com>
  */
-UNUSUAL_DEV( 0x2109, 0x0715, 0x9999, 0x9999,
+UNUSUAL_DEV( 0x2109, 0x0715, 0x0000, 0x9999,
 		"VIA Labs, Inc.",
 		"VL817 SATA Bridge",
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 19ff8217818e..5b1f2750cfc3 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1755,8 +1755,9 @@ static int fusb302_probe(struct i2c_client *client)
 		goto destroy_workqueue;
 	}
 
-	ret = request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
-			  IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);
+	ret = request_threaded_irq(chip->gpio_int_n_irq, NULL, fusb302_irq_intn,
+				   IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+				   "fsc_interrupt_int_n", chip);
 	if (ret < 0) {
 		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", ret);
 		goto tcpm_unregister_port;
diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index a2b2da1255dd..ba9e7c616e12 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -470,6 +470,18 @@ static void usbip_pack_ret_submit(struct usbip_header *pdu, struct urb *urb,
 		urb->status		= rpdu->status;
 		urb->actual_length	= rpdu->actual_length;
 		urb->start_frame	= rpdu->start_frame;
+		/*
+		 * The number_of_packets field determines the length of
+		 * iso_frame_desc[], which is a flexible array allocated
+		 * at URB creation time. A response must never claim more
+		 * packets than originally submitted; doing so would cause
+		 * an out-of-bounds write in usbip_recv_iso() and
+		 * usbip_pad_iso(). Clamp to zero on violation so both
+		 * functions safely return early.
+		 */
+		if (rpdu->number_of_packets < 0 ||
+		    rpdu->number_of_packets > urb->number_of_packets)
+			rpdu->number_of_packets = 0;
 		urb->number_of_packets = rpdu->number_of_packets;
 		urb->error_count	= rpdu->error_count;
 	}
diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
index 2a5eb9260ec7..ef698ca1565e 100644
--- a/drivers/vfio/pci/xe/main.c
+++ b/drivers/vfio/pci/xe/main.c
@@ -454,39 +454,46 @@ static const struct vfio_migration_ops xe_vfio_pci_migration_ops = {
 static void xe_vfio_pci_migration_init(struct xe_vfio_pci_core_device *xe_vdev)
 {
 	struct vfio_device *core_vdev = &xe_vdev->core_device.vdev;
-	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
-	struct xe_device *xe = xe_sriov_vfio_get_pf(pdev);
 
-	if (!xe)
+	if (!xe_sriov_vfio_migration_supported(xe_vdev->xe))
 		return;
-	if (!xe_sriov_vfio_migration_supported(xe))
-		return;
-
-	mutex_init(&xe_vdev->state_mutex);
-	spin_lock_init(&xe_vdev->reset_lock);
-
-	/* PF internal control uses vfid index starting from 1 */
-	xe_vdev->vfid = pci_iov_vf_id(pdev) + 1;
-	xe_vdev->xe = xe;
 
 	core_vdev->migration_flags = VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_P2P;
 	core_vdev->mig_ops = &xe_vfio_pci_migration_ops;
 }
 
-static void xe_vfio_pci_migration_fini(struct xe_vfio_pci_core_device *xe_vdev)
+static int xe_vfio_pci_vf_init(struct xe_vfio_pci_core_device *xe_vdev)
 {
-	if (!xe_vdev->vfid)
-		return;
+	struct vfio_device *core_vdev = &xe_vdev->core_device.vdev;
+	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
+	struct xe_device *xe = xe_sriov_vfio_get_pf(pdev);
 
-	mutex_destroy(&xe_vdev->state_mutex);
+	if (!pdev->is_virtfn)
+		return 0;
+	if (!xe)
+		return -ENODEV;
+	xe_vdev->xe = xe;
+
+	/* PF internal control uses vfid index starting from 1 */
+	xe_vdev->vfid = pci_iov_vf_id(pdev) + 1;
+
+	xe_vfio_pci_migration_init(xe_vdev);
+
+	return 0;
 }
 
 static int xe_vfio_pci_init_dev(struct vfio_device *core_vdev)
 {
 	struct xe_vfio_pci_core_device *xe_vdev =
 		container_of(core_vdev, struct xe_vfio_pci_core_device, core_device.vdev);
+	int ret;
 
-	xe_vfio_pci_migration_init(xe_vdev);
+	mutex_init(&xe_vdev->state_mutex);
+	spin_lock_init(&xe_vdev->reset_lock);
+
+	ret = xe_vfio_pci_vf_init(xe_vdev);
+	if (ret)
+		return ret;
 
 	return vfio_pci_core_init_dev(core_vdev);
 }
@@ -496,7 +503,7 @@ static void xe_vfio_pci_release_dev(struct vfio_device *core_vdev)
 	struct xe_vfio_pci_core_device *xe_vdev =
 		container_of(core_vdev, struct xe_vfio_pci_core_device, core_device.vdev);
 
-	xe_vfio_pci_migration_fini(xe_vdev);
+	mutex_destroy(&xe_vdev->state_mutex);
 }
 
 static const struct vfio_device_ops xe_vfio_pci_ops = {
diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 51ebe78359ec..531fb8478e20 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -496,6 +496,9 @@ static int tdfxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 		}
 	}
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	if (PICOS2KHZ(var->pixclock) > par->max_pixclock) {
 		DPRINTK("pixclock too high (%ldKHz)\n",
 			PICOS2KHZ(var->pixclock));
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index ccede85df1e1..28e6d75e13ed 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1018,6 +1018,9 @@ static int dlfb_ops_check_var(struct fb_var_screeninfo *var,
 	struct fb_videomode mode;
 	struct dlfb_data *dlfb = info->par;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	/* set device-specific elements of var unrelated to mode */
 	dlfb_var_color_format(var);
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6c40f48cc194..4cea0489f121 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4609,21 +4609,32 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 			    struct inode *inode, bool log_inode_only,
 			    u64 logged_isize)
 {
+	u64 gen = BTRFS_I(inode)->generation;
 	u64 flags;
 
 	if (log_inode_only) {
-		/* set the generation to zero so the recover code
-		 * can tell the difference between an logging
-		 * just to say 'this inode exists' and a logging
-		 * to say 'update this inode with these values'
+		/*
+		 * Set the generation to zero so the recover code can tell the
+		 * difference between a logging just to say 'this inode exists'
+		 * and a logging to say 'update this inode with these values'.
+		 * But only if the inode was not already logged before.
+		 * We access ->logged_trans directly since it was already set
+		 * up in the call chain by btrfs_log_inode(), and data_race()
+		 * to avoid false alerts from KCSAN and since it was set already
+		 * and one can set it to 0 since that only happens on eviction
+		 * and we are holding a ref on the inode.
 		 */
-		btrfs_set_inode_generation(leaf, item, 0);
+		ASSERT(data_race(BTRFS_I(inode)->logged_trans) > 0);
+		if (data_race(BTRFS_I(inode)->logged_trans) < trans->transid)
+			gen = 0;
+
 		btrfs_set_inode_size(leaf, item, logged_isize);
 	} else {
-		btrfs_set_inode_generation(leaf, item, BTRFS_I(inode)->generation);
 		btrfs_set_inode_size(leaf, item, inode->i_size);
 	}
 
+	btrfs_set_inode_generation(leaf, item, gen);
+
 	btrfs_set_inode_uid(leaf, item, i_uid_read(inode));
 	btrfs_set_inode_gid(leaf, item, i_gid_read(inode));
 	btrfs_set_inode_mode(leaf, item, inode->i_mode);
@@ -5427,42 +5438,63 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-static int logged_inode_size(struct btrfs_root *log, struct btrfs_inode *inode,
-			     struct btrfs_path *path, u64 *size_ret)
+static int get_inode_size_to_log(struct btrfs_trans_handle *trans,
+				 struct btrfs_inode *inode,
+				 struct btrfs_path *path, u64 *size_ret)
 {
 	struct btrfs_key key;
+	struct btrfs_inode_item *item;
 	int ret;
 
 	key.objectid = btrfs_ino(inode);
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
-	ret = btrfs_search_slot(NULL, log, &key, path, 0, 0);
-	if (ret < 0) {
-		return ret;
-	} else if (ret > 0) {
-		*size_ret = 0;
-	} else {
-		struct btrfs_inode_item *item;
+	/*
+	 * Our caller called inode_logged(), so logged_trans is up to date.
+	 * Use data_race() to silence any warning from KCSAN. Once logged_trans
+	 * is set, it can only be reset to 0 after inode eviction.
+	 */
+	if (data_race(inode->logged_trans) == trans->transid) {
+		ret = btrfs_search_slot(NULL, inode->root->log_root, &key, path, 0, 0);
+	} else if (inode->generation < trans->transid) {
+		path->search_commit_root = true;
+		path->skip_locking = true;
+		ret = btrfs_search_slot(NULL, inode->root, &key, path, 0, 0);
+		path->search_commit_root = false;
+		path->skip_locking = false;
 
-		item = btrfs_item_ptr(path->nodes[0], path->slots[0],
-				      struct btrfs_inode_item);
-		*size_ret = btrfs_inode_size(path->nodes[0], item);
-		/*
-		 * If the in-memory inode's i_size is smaller then the inode
-		 * size stored in the btree, return the inode's i_size, so
-		 * that we get a correct inode size after replaying the log
-		 * when before a power failure we had a shrinking truncate
-		 * followed by addition of a new name (rename / new hard link).
-		 * Otherwise return the inode size from the btree, to avoid
-		 * data loss when replaying a log due to previously doing a
-		 * write that expands the inode's size and logging a new name
-		 * immediately after.
-		 */
-		if (*size_ret > inode->vfs_inode.i_size)
-			*size_ret = inode->vfs_inode.i_size;
+	} else {
+		*size_ret = 0;
+		return 0;
 	}
 
+	/*
+	 * If the inode was logged before or is from a past transaction, then
+	 * its inode item must exist in the log root or in the commit root.
+	 */
+	ASSERT(ret <= 0);
+	if (WARN_ON_ONCE(ret > 0))
+		ret = -ENOENT;
+
+	if (ret < 0)
+		return ret;
+
+	item = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			      struct btrfs_inode_item);
+	*size_ret = btrfs_inode_size(path->nodes[0], item);
+	/*
+	 * If the in-memory inode's i_size is smaller then the inode size stored
+	 * in the btree, return the inode's i_size, so that we get a correct
+	 * inode size after replaying the log when before a power failure we had
+	 * a shrinking truncate followed by addition of a new name (rename / new
+	 * hard link). Otherwise return the inode size from the btree, to avoid
+	 * data loss when replaying a log due to previously doing a write that
+	 * expands the inode's size and logging a new name immediately after.
+	 */
+	if (*size_ret > inode->vfs_inode.i_size)
+		*size_ret = inode->vfs_inode.i_size;
+
 	btrfs_release_path(path);
 	return 0;
 }
@@ -6975,7 +7007,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			ret = drop_inode_items(trans, log, path, inode,
 					       BTRFS_XATTR_ITEM_KEY);
 	} else {
-		if (inode_only == LOG_INODE_EXISTS && ctx->logged_before) {
+		if (inode_only == LOG_INODE_EXISTS) {
 			/*
 			 * Make sure the new inode item we write to the log has
 			 * the same isize as the current one (if it exists).
@@ -6989,7 +7021,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			 * (zeroes), as if an expanding truncate happened,
 			 * instead of getting a file of 4Kb only.
 			 */
-			ret = logged_inode_size(log, inode, path, &logged_isize);
+			ret = get_inode_size_to_log(trans, inode, path, &logged_isize);
 			if (ret)
 				goto out_unlock;
 		}
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index e5ec90dccc27..eb9eb7683e3c 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -810,6 +810,11 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 	if (ret < 0)
 		goto error_unlock;
 
+	/*
+	 * cachefiles_bury_object() expects 2 references to 'victim',
+	 * and drops one.
+	 */
+	dget(victim);
 	ret = cachefiles_bury_object(cache, NULL, dir, victim,
 				     FSCACHE_OBJECT_WAS_CULLED);
 	dput(victim);
diff --git a/fs/dcache.c b/fs/dcache.c
index 66dd1bb830d1..957a44d2c44a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3260,7 +3260,7 @@ static void __init dcache_init_early(void)
 					HASH_EARLY | HASH_ZERO,
 					&d_hash_shift,
 					NULL,
-					0,
+					2,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
 
@@ -3292,7 +3292,7 @@ static void __init dcache_init(void)
 					HASH_ZERO,
 					&d_hash_shift,
 					NULL,
-					0,
+					2,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
 
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d20917b03161..3bdbaf202d4d 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -226,6 +226,9 @@ struct eventpoll {
 	 */
 	refcount_t refcount;
 
+	/* used to defer freeing past ep_get_upwards_depth_proc() RCU walk */
+	struct rcu_head rcu;
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	/* used to track busy poll napi_id */
 	unsigned int napi_id;
@@ -819,7 +822,8 @@ static void ep_free(struct eventpoll *ep)
 	mutex_destroy(&ep->mtx);
 	free_uid(ep->user);
 	wakeup_source_unregister(ep->ws);
-	kfree(ep);
+	/* ep_get_upwards_depth_proc() may still hold epi->ep under RCU */
+	kfree_rcu(ep, rcu);
 }
 
 /*
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 674380837ab9..888dc1831c86 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -524,6 +524,9 @@ int nilfs_dat_read(struct super_block *sb, size_t entry_size,
 	if (err)
 		goto failed;
 
+	err = nilfs_attach_btree_node_cache(dat);
+	if (err)
+		goto failed;
 	err = nilfs_read_inode_common(dat, raw_inode);
 	if (err)
 		goto failed;
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 76c86f1c2b1c..7a65d5a36a3e 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2295,8 +2295,6 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 		goto out;
 	}
 
-	down_write(&oi->ip_alloc_sem);
-
 	/* Delete orphan before acquire i_rwsem. */
 	if (dwc->dw_orphaned) {
 		BUG_ON(dwc->dw_writer_pid != task_pid_nr(current));
@@ -2309,6 +2307,7 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 			mlog_errno(ret);
 	}
 
+	down_write(&oi->ip_alloc_sem);
 	di = (struct ocfs2_dinode *)di_bh->b_data;
 
 	ocfs2_init_dinode_extent_tree(&et, INODE_CACHE(inode), di_bh);
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index b5fcc2725a29..121560052b71 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1494,12 +1494,35 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
-	if ((le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) &&
-	    le32_to_cpu(di->i_clusters)) {
-		rc = ocfs2_error(sb, "Invalid dinode %llu: %u clusters\n",
-				 (unsigned long long)bh->b_blocknr,
-				 le32_to_cpu(di->i_clusters));
-		goto bail;
+	if (le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) {
+		struct ocfs2_inline_data *data = &di->id2.i_data;
+
+		if (le32_to_cpu(di->i_clusters)) {
+			rc = ocfs2_error(sb,
+					 "Invalid dinode %llu: %u clusters\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le32_to_cpu(di->i_clusters));
+			goto bail;
+		}
+
+		if (le16_to_cpu(data->id_count) >
+		    ocfs2_max_inline_data_with_xattr(sb, di)) {
+			rc = ocfs2_error(sb,
+					 "Invalid dinode #%llu: inline data id_count %u exceeds max %d\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le16_to_cpu(data->id_count),
+					 ocfs2_max_inline_data_with_xattr(sb, di));
+			goto bail;
+		}
+
+		if (le64_to_cpu(di->i_size) > le16_to_cpu(data->id_count)) {
+			rc = ocfs2_error(sb,
+					 "Invalid dinode #%llu: inline data i_size %llu exceeds id_count %u\n",
+					 (unsigned long long)bh->b_blocknr,
+					 (unsigned long long)le64_to_cpu(di->i_size),
+					 le16_to_cpu(data->id_count));
+			goto bail;
+		}
 	}
 
 	if (le32_to_cpu(di->i_flags) & OCFS2_CHAIN_FL) {
diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index 50e2faf64c19..6c570157caf1 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -30,7 +30,8 @@
 
 static vm_fault_t ocfs2_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	unsigned long long ip_blkno =
+		OCFS2_I(file_inode(vmf->vma->vm_file))->ip_blkno;
 	sigset_t oldset;
 	vm_fault_t ret;
 
@@ -38,11 +39,9 @@ static vm_fault_t ocfs2_fault(struct vm_fault *vmf)
 	ret = filemap_fault(vmf);
 	ocfs2_unblock_signals(&oldset);
 
-	trace_ocfs2_fault(OCFS2_I(vma->vm_file->f_mapping->host)->ip_blkno,
-			  vma, vmf->page, vmf->pgoff);
+	trace_ocfs2_fault(ip_blkno, vmf->page, vmf->pgoff);
 	return ret;
 }
-
 static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
 			struct buffer_head *di_bh, struct folio *folio)
 {
diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
index 4b32fb5658ad..6c2c97a9804f 100644
--- a/fs/ocfs2/ocfs2_trace.h
+++ b/fs/ocfs2/ocfs2_trace.h
@@ -1246,22 +1246,20 @@ TRACE_EVENT(ocfs2_write_end_inline,
 
 TRACE_EVENT(ocfs2_fault,
 	TP_PROTO(unsigned long long ino,
-		 void *area, void *page, unsigned long pgoff),
-	TP_ARGS(ino, area, page, pgoff),
+		 void *page, unsigned long pgoff),
+	TP_ARGS(ino, page, pgoff),
 	TP_STRUCT__entry(
 		__field(unsigned long long, ino)
-		__field(void *, area)
 		__field(void *, page)
 		__field(unsigned long, pgoff)
 	),
 	TP_fast_assign(
 		__entry->ino = ino;
-		__entry->area = area;
 		__entry->page = page;
 		__entry->pgoff = pgoff;
 	),
-	TP_printk("%llu %p %p %lu",
-		  __entry->ino, __entry->area, __entry->page, __entry->pgoff)
+	TP_printk("%llu %p %lu",
+		  __entry->ino, __entry->page, __entry->pgoff)
 );
 
 /* End of trace events for fs/ocfs2/mmap.c. */
diff --git a/fs/ocfs2/resize.c b/fs/ocfs2/resize.c
index ac3ec2c21119..09724e7dc01b 100644
--- a/fs/ocfs2/resize.c
+++ b/fs/ocfs2/resize.c
@@ -303,9 +303,13 @@ int ocfs2_group_extend(struct inode * inode, int new_clusters)
 
 	fe = (struct ocfs2_dinode *)main_bm_bh->b_data;
 
-	/* main_bm_bh is validated by inode read inside ocfs2_inode_lock(),
-	 * so any corruption is a code bug. */
-	BUG_ON(!OCFS2_IS_VALID_DINODE(fe));
+	/* JBD-managed buffers can bypass validation, so treat this as corruption. */
+	if (!OCFS2_IS_VALID_DINODE(fe)) {
+		ret = ocfs2_error(main_bm_inode->i_sb,
+				  "Invalid dinode #%llu\n",
+				  (unsigned long long)OCFS2_I(main_bm_inode)->ip_blkno);
+		goto out_unlock;
+	}
 
 	if (le16_to_cpu(fe->id2.i_chain.cl_cpg) !=
 		ocfs2_group_bitmap_size(osb->sb, 0,
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index e0d2cd78c82f..e61bb6ac1d11 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -589,6 +589,10 @@ char *cifs_sanitize_prepath(char *prepath, gfp_t gfp)
 	while (IS_DELIM(*cursor1))
 		cursor1++;
 
+	/* exit in case of only delimiters */
+	if (!*cursor1)
+		return NULL;
+
 	/* copy the first letter */
 	*cursor2 = *cursor1;
 
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index 1f7f284a7844..b2ddcecd00b9 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -27,10 +27,11 @@ static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
 {
 	struct smb2_err_rsp *err = iov->iov_base;
 	struct smb2_symlink_err_rsp *sym = ERR_PTR(-EINVAL);
+	u8 *end = (u8 *)err + iov->iov_len;
 	u32 len;
 
 	if (err->ErrorContextCount) {
-		struct smb2_error_context_rsp *p, *end;
+		struct smb2_error_context_rsp *p;
 
 		len = (u32)err->ErrorContextCount * (offsetof(struct smb2_error_context_rsp,
 							      ErrorContextData) +
@@ -39,8 +40,7 @@ static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
 			return ERR_PTR(-EINVAL);
 
 		p = (struct smb2_error_context_rsp *)err->ErrorData;
-		end = (struct smb2_error_context_rsp *)((u8 *)err + iov->iov_len);
-		do {
+		while ((u8 *)p + sizeof(*p) <= end) {
 			if (le32_to_cpu(p->ErrorId) == SMB2_ERROR_ID_DEFAULT) {
 				sym = (struct smb2_symlink_err_rsp *)p->ErrorContextData;
 				break;
@@ -50,14 +50,16 @@ static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
 
 			len = ALIGN(le32_to_cpu(p->ErrorDataLength), 8);
 			p = (struct smb2_error_context_rsp *)(p->ErrorContextData + len);
-		} while (p < end);
+		}
 	} else if (le32_to_cpu(err->ByteCount) >= sizeof(*sym) &&
 		   iov->iov_len >= SMB2_SYMLINK_STRUCT_SIZE) {
 		sym = (struct smb2_symlink_err_rsp *)err->ErrorData;
 	}
 
-	if (!IS_ERR(sym) && (le32_to_cpu(sym->SymLinkErrorTag) != SYMLINK_ERROR_TAG ||
-			     le32_to_cpu(sym->ReparseTag) != IO_REPARSE_TAG_SYMLINK))
+	if (!IS_ERR(sym) &&
+	    ((u8 *)sym + sizeof(*sym) > end ||
+	     le32_to_cpu(sym->SymLinkErrorTag) != SYMLINK_ERROR_TAG ||
+	     le32_to_cpu(sym->ReparseTag) != IO_REPARSE_TAG_SYMLINK))
 		sym = ERR_PTR(-EINVAL);
 
 	return sym;
@@ -128,8 +130,10 @@ int smb2_parse_symlink_response(struct cifs_sb_info *cifs_sb, const struct kvec
 	print_len = le16_to_cpu(sym->PrintNameLength);
 	print_offs = le16_to_cpu(sym->PrintNameOffset);
 
-	if (iov->iov_len < SMB2_SYMLINK_STRUCT_SIZE + sub_offs + sub_len ||
-	    iov->iov_len < SMB2_SYMLINK_STRUCT_SIZE + print_offs + print_len)
+	if ((char *)sym->PathBuffer + sub_offs + sub_len >
+		(char *)iov->iov_base + iov->iov_len ||
+	    (char *)sym->PathBuffer + print_offs + print_len >
+		(char *)iov->iov_base + iov->iov_len)
 		return -EINVAL;
 
 	return smb2_parse_native_symlink(path,
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 5ebcc68560a0..ed378fbe5375 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -128,7 +128,7 @@ static int check_wsl_eas(struct kvec *rsp_iov)
 		nlen = ea->ea_name_length;
 		vlen = le16_to_cpu(ea->ea_value_length);
 		if (nlen != SMB2_WSL_XATTR_NAME_LEN ||
-		    (u8 *)ea + nlen + 1 + vlen > end)
+		    (u8 *)ea->ea_data + nlen + 1 + vlen > end)
 			return -EINVAL;
 
 		switch (vlen) {
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index c8cef098d480..ff44a2dc4993 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1525,17 +1525,25 @@ static int smbd_post_send_iter(struct smbdirect_socket *sc,
 
 	rc = smbd_post_send(sc, batch, request);
 	if (!rc) {
+		/*
+		 * From here request is moved to batch
+		 * and we should not free it explicitly.
+		 */
+
 		if (batch != &_batch)
 			return 0;
 
 		rc = smbd_send_batch_flush(sc, batch, true);
 		if (!rc)
 			return 0;
+
+		goto err_flush;
 	}
 
 err_dma:
 	smbd_free_send_io(request);
 
+err_flush:
 err_alloc:
 	atomic_inc(&sc->send_io.credits.count);
 	wake_up(&sc->send_io.credits.wait_queue);
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 6cac48c8fbe8..7e58739c0d3e 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -39,6 +39,7 @@ void ksmbd_conn_free(struct ksmbd_conn *conn)
 	xa_destroy(&conn->sessions);
 	kvfree(conn->request_buf);
 	kfree(conn->preauth_info);
+	kfree(conn->mechToken);
 	if (atomic_dec_and_test(&conn->refcnt)) {
 		conn->transport->ops->free_transport(conn->transport);
 		kfree(conn);
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 276dcb9b83f4..a75fe467a4f0 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1914,7 +1914,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	else if (rc)
 		rsp->hdr.Status = STATUS_LOGON_FAILURE;
 
-	if (conn->use_spnego && conn->mechToken) {
+	if (conn->mechToken) {
 		kfree(conn->mechToken);
 		conn->mechToken = NULL;
 	}
@@ -4715,6 +4715,11 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 
 		ea_req = (struct smb2_ea_info_req *)((char *)req +
 						     le16_to_cpu(req->InputBufferOffset));
+
+		if (le32_to_cpu(req->InputBufferLength) <
+		    offsetof(struct smb2_ea_info_req, name) +
+		    ea_req->EaNameLength)
+			return -EINVAL;
 	} else {
 		/* need to send all EAs, if no specific EA is requested*/
 		if (le32_to_cpu(req->Flags) & SL_RETURN_SINGLE_ENTRY)
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 441c4ed02aba..04c96534575b 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -451,7 +451,8 @@ static void parse_dacl(struct mnt_idmap *idmap,
 		ppace[i]->access_req =
 			smb_map_generic_desired_access(ppace[i]->access_req);
 
-		if (!(compare_sids(&ppace[i]->sid, &sid_unix_NFS_mode))) {
+		if (ppace[i]->sid.num_subauth >= 3 &&
+		    !(compare_sids(&ppace[i]->sid, &sid_unix_NFS_mode))) {
 			fattr->cf_mode =
 				le32_to_cpu(ppace[i]->sid.sub_auth[2]);
 			break;
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index dcc7a6c20d6f..fa56b5726993 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1575,15 +1575,21 @@ static int smb_direct_post_send_data(struct smbdirect_socket *sc,
 	if (ret)
 		goto err;
 
+	/*
+	 * From here msg is moved to send_ctx
+	 * and we should not free it explicitly.
+	 */
+
 	if (send_ctx == &_send_ctx) {
 		ret = smb_direct_flush_send_list(sc, send_ctx, true);
 		if (ret)
-			goto err;
+			goto flush_failed;
 	}
 
 	return 0;
 err:
 	smb_direct_free_sendmsg(sc, msg);
+flush_failed:
 header_failed:
 	atomic_inc(&sc->send_io.credits.count);
 credit_failed:
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 30fbbde81c5c..9c523ee57a35 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -1528,4 +1528,10 @@ struct hv_mmio_write_input {
 	u8 data[HV_HYPERCALL_MMIO_MAX_DATA_LENGTH];
 } __packed;
 
+enum hv_intercept_access_type {
+	HV_INTERCEPT_ACCESS_READ	= 0,
+	HV_INTERCEPT_ACCESS_WRITE	= 1,
+	HV_INTERCEPT_ACCESS_EXECUTE	= 2
+};
+
 #endif /* _HV_HVGDK_MINI_H */
diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 08965970c17d..84ebe56f1f8d 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -770,7 +770,7 @@ struct hv_x64_intercept_message_header {
 	u32 vp_index;
 	u8 instruction_length:4;
 	u8 cr8:4; /* Only set for exo partitions */
-	u8 intercept_access_type;
+	u8 intercept_access_type; /* enum hv_intercept_access_type */
 	union hv_x64_vp_execution_state execution_state;
 	struct hv_x64_segment_register cs_segment;
 	u64 rip;
@@ -816,7 +816,7 @@ union hv_arm64_vp_execution_state {
 struct hv_arm64_intercept_message_header {
 	u32 vp_index;
 	u8 instruction_length;
-	u8 intercept_access_type;
+	u8 intercept_access_type; /* enum hv_intercept_access_type */
 	union hv_arm64_vp_execution_state execution_state;
 	u64 pc;
 	u64 cpsr;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 190eab9f5e8c..3e63046b899b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -78,6 +78,13 @@
  */
 #define DMA_ATTR_MMIO		(1UL << 10)
 
+/*
+ * DMA_ATTR_CPU_CACHE_CLEAN: Indicates the CPU will not dirty any cacheline
+ * overlapping this buffer while it is mapped for DMA. All mappings sharing
+ * a cacheline must have this attribute for this to be considered safe.
+ */
+#define DMA_ATTR_CPU_CACHE_CLEAN	(1UL << 11)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e51b8ef0cebd..986372cd5c14 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -796,6 +796,23 @@ static inline unsigned huge_page_shift(struct hstate *h)
 	return h->order + PAGE_SHIFT;
 }
 
+/**
+ * hugetlb_linear_page_index() - linear_page_index() but in hugetlb
+ *				 page size granularity.
+ * @vma: the hugetlb VMA
+ * @address: the virtual address within the VMA
+ *
+ * Return: the page offset within the mapping in huge page units.
+ */
+static inline pgoff_t hugetlb_linear_page_index(struct vm_area_struct *vma,
+		unsigned long address)
+{
+	struct hstate *h = hstate_vma(vma);
+
+	return ((address - vma->vm_start) >> huge_page_shift(h)) +
+		(vma->vm_pgoff >> huge_page_order(h));
+}
+
 static inline bool order_is_gigantic(unsigned int order)
 {
 	return order > MAX_PAGE_ORDER;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d93f75b05ae2..7501735045e1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -320,7 +320,8 @@ static inline bool kvm_vcpu_can_poll(ktime_t cur, ktime_t stop)
 struct kvm_mmio_fragment {
 	gpa_t gpa;
 	void *data;
-	unsigned len;
+	u64 val;
+	unsigned int len;
 };
 
 struct kvm_vcpu {
@@ -1030,6 +1031,13 @@ static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 	return NULL;
 }
 
+static inline bool kvm_is_vcpu_creation_in_progress(struct kvm *kvm)
+{
+	lockdep_assert_held(&kvm->lock);
+
+	return kvm->created_vcpus != atomic_read(&kvm->online_vcpus);
+}
+
 void kvm_destroy_vcpus(struct kvm *kvm);
 
 int kvm_trylock_all_vcpus(struct kvm *kvm);
@@ -1927,56 +1935,43 @@ enum kvm_stat_kind {
 
 struct kvm_stat_data {
 	struct kvm *kvm;
-	const struct _kvm_stats_desc *desc;
+	const struct kvm_stats_desc *desc;
 	enum kvm_stat_kind kind;
 };
 
-struct _kvm_stats_desc {
-	struct kvm_stats_desc desc;
-	char name[KVM_STATS_NAME_SIZE];
-};
-
-#define STATS_DESC_COMMON(type, unit, base, exp, sz, bsz)		       \
-	.flags = type | unit | base |					       \
-		 BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |	       \
-		 BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |	       \
-		 BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),	       \
-	.exponent = exp,						       \
-	.size = sz,							       \
+#define STATS_DESC_COMMON(type, unit, base, exp, sz, bsz)		\
+	.flags = type | unit | base |					\
+		 BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |       \
+		 BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |	\
+		 BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),	\
+	.exponent = exp,						\
+	.size = sz,							\
 	.bucket_size = bsz
 
-#define VM_GENERIC_STATS_DESC(stat, type, unit, base, exp, sz, bsz)	       \
-	{								       \
-		{							       \
-			STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),     \
-			.offset = offsetof(struct kvm_vm_stat, generic.stat)   \
-		},							       \
-		.name = #stat,						       \
-	}
-#define VCPU_GENERIC_STATS_DESC(stat, type, unit, base, exp, sz, bsz)	       \
-	{								       \
-		{							       \
-			STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),     \
-			.offset = offsetof(struct kvm_vcpu_stat, generic.stat) \
-		},							       \
-		.name = #stat,						       \
-	}
-#define VM_STATS_DESC(stat, type, unit, base, exp, sz, bsz)		       \
-	{								       \
-		{							       \
-			STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),     \
-			.offset = offsetof(struct kvm_vm_stat, stat)	       \
-		},							       \
-		.name = #stat,						       \
-	}
-#define VCPU_STATS_DESC(stat, type, unit, base, exp, sz, bsz)		       \
-	{								       \
-		{							       \
-			STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),     \
-			.offset = offsetof(struct kvm_vcpu_stat, stat)	       \
-		},							       \
-		.name = #stat,						       \
-	}
+#define VM_GENERIC_STATS_DESC(stat, type, unit, base, exp, sz, bsz)	\
+{									\
+	STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),		\
+	.offset = offsetof(struct kvm_vm_stat, generic.stat),		\
+	.name = #stat,							\
+}
+#define VCPU_GENERIC_STATS_DESC(stat, type, unit, base, exp, sz, bsz)	\
+{									\
+	STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),		\
+	.offset = offsetof(struct kvm_vcpu_stat, generic.stat),		\
+	.name = #stat,							\
+}
+#define VM_STATS_DESC(stat, type, unit, base, exp, sz, bsz)		\
+{									\
+	STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),		\
+	.offset = offsetof(struct kvm_vm_stat, stat),			\
+	.name = #stat,							\
+}
+#define VCPU_STATS_DESC(stat, type, unit, base, exp, sz, bsz)		\
+{									\
+	STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),		\
+	.offset = offsetof(struct kvm_vcpu_stat, stat),			\
+	.name = #stat,							\
+}
 /* SCOPE: VM, VM_GENERIC, VCPU, VCPU_GENERIC */
 #define STATS_DESC(SCOPE, stat, type, unit, base, exp, sz, bsz)		       \
 	SCOPE##_STATS_DESC(stat, type, unit, base, exp, sz, bsz)
@@ -2053,7 +2048,7 @@ struct _kvm_stats_desc {
 	STATS_DESC_IBOOLEAN(VCPU_GENERIC, blocking)
 
 ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
-		       const struct _kvm_stats_desc *desc,
+		       const struct kvm_stats_desc *desc,
 		       void *stats, size_t size_stats,
 		       char __user *user_buffer, size_t size, loff_t *offset);
 
@@ -2098,9 +2093,9 @@ static inline void kvm_stats_log_hist_update(u64 *data, size_t size, u64 value)
 
 
 extern const struct kvm_stats_header kvm_vm_stats_header;
-extern const struct _kvm_stats_desc kvm_vm_stats_desc[];
+extern const struct kvm_stats_desc kvm_vm_stats_desc[];
 extern const struct kvm_stats_header kvm_vcpu_stats_header;
-extern const struct _kvm_stats_desc kvm_vcpu_stats_desc[];
+extern const struct kvm_stats_desc kvm_vcpu_stats_desc[];
 
 #ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index d53f72dba7fe..81fcfde3563d 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -345,7 +345,7 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
-static inline int mmap_write_lock_killable(struct mm_struct *mm)
+static inline int __must_check mmap_write_lock_killable(struct mm_struct *mm)
 {
 	int ret;
 
@@ -392,7 +392,7 @@ static inline void mmap_read_lock(struct mm_struct *mm)
 	__mmap_lock_trace_acquire_returned(mm, false, true);
 }
 
-static inline int mmap_read_lock_killable(struct mm_struct *mm)
+static inline int __must_check mmap_read_lock_killable(struct mm_struct *mm)
 {
 	int ret;
 
@@ -402,7 +402,7 @@ static inline int mmap_read_lock_killable(struct mm_struct *mm)
 	return ret;
 }
 
-static inline bool mmap_read_trylock(struct mm_struct *mm)
+static inline bool __must_check mmap_read_trylock(struct mm_struct *mm)
 {
 	bool ret;
 
diff --git a/include/linux/soc/qcom/pdr.h b/include/linux/soc/qcom/pdr.h
index 83a8ea612e69..2b7691e47c2a 100644
--- a/include/linux/soc/qcom/pdr.h
+++ b/include/linux/soc/qcom/pdr.h
@@ -5,6 +5,7 @@
 #include <linux/soc/qcom/qmi.h>
 
 #define SERVREG_NAME_LENGTH	64
+#define SERVREG_PFR_LENGTH	256
 
 struct pdr_service;
 struct pdr_handle;
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index e0698024667a..313a0e17f22f 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_SRCU_TINY_H
 #define _LINUX_SRCU_TINY_H
 
+#include <linux/irq_work_types.h>
 #include <linux/swait.h>
 
 struct srcu_struct {
@@ -24,18 +25,21 @@ struct srcu_struct {
 	struct rcu_head *srcu_cb_head;	/* Pending callbacks: Head. */
 	struct rcu_head **srcu_cb_tail;	/* Pending callbacks: Tail. */
 	struct work_struct srcu_work;	/* For driving grace periods. */
+	struct irq_work srcu_irq_work;	/* Defer schedule_work() to irq work. */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 };
 
 void srcu_drive_gp(struct work_struct *wp);
+void srcu_tiny_irq_work(struct irq_work *irq_work);
 
 #define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, ____ignored)	\
 {									\
 	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
 	.srcu_cb_tail = &name.srcu_cb_head,				\
 	.srcu_work = __WORK_INITIALIZER(name.srcu_work, srcu_drive_gp),	\
+	.srcu_irq_work = { .func = srcu_tiny_irq_work },		\
 	__SRCU_DEP_MAP_INIT(name)					\
 }
 
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 809e4f7dfdbd..fa7125c0e103 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -331,16 +331,21 @@ static inline size_t probe_subpage_writeable(char __user *uaddr, size_t size)
 
 #endif /* CONFIG_ARCH_HAS_SUBPAGE_FAULTS */
 
-#ifndef ARCH_HAS_NOCACHE_UACCESS
+#ifndef ARCH_HAS_NONTEMPORAL_UACCESS
 
 static inline __must_check unsigned long
-__copy_from_user_inatomic_nocache(void *to, const void __user *from,
+copy_from_user_inatomic_nontemporal(void *to, const void __user *from,
 				  unsigned long n)
 {
+	if (can_do_masked_user_access())
+		from = mask_user_address(from);
+	else
+		if (!access_ok(from, n))
+			return n;
 	return __copy_from_user_inatomic(to, from, n);
 }
 
-#endif		/* ARCH_HAS_NOCACHE_UACCESS */
+#endif		/* ARCH_HAS_NONTEMPORAL_UACCESS */
 
 extern __must_check int check_zeroed_user(const void __user *from, size_t size);
 
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1f577a4f8ce9..d708b66e55cd 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -32,7 +32,7 @@
  * recursion involves route lookups and full IP output, consuming much
  * more stack per level, so a lower limit is needed.
  */
-#define IP_TUNNEL_RECURSION_LIMIT	4
+#define IP_TUNNEL_RECURSION_LIMIT	5
 
 /* Keep error state on tunnel for 30 sec */
 #define IPTUNNEL_ERR_TIMEO	(30*HZ)
diff --git a/include/net/netfilter/nf_conntrack_core.h b/include/net/netfilter/nf_conntrack_core.h
index 3384859a8921..8883575adcc1 100644
--- a/include/net/netfilter/nf_conntrack_core.h
+++ b/include/net/netfilter/nf_conntrack_core.h
@@ -83,6 +83,11 @@ void nf_conntrack_lock(spinlock_t *lock);
 
 extern spinlock_t nf_conntrack_expect_lock;
 
+static inline void lockdep_nfct_expect_lock_held(void)
+{
+	lockdep_assert_held(&nf_conntrack_expect_lock);
+}
+
 /* ctnetlink code shared by both ctnetlink and nf_conntrack_bpf */
 
 static inline void __nf_ct_set_timeout(struct nf_conn *ct, u64 timeout)
diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index 45eb26b2e95b..d17035d14d96 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -23,7 +23,6 @@ struct nf_queue_entry {
 	struct nf_hook_state	state;
 	bool			nf_ct_is_unconfirmed;
 	u16			size; /* sizeof(entry) + saved route keys */
-	u16			queue_num;
 
 	/* extra space to store route keys */
 };
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 23e8861e8b25..ebac60a3d8a1 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -14,7 +14,7 @@
 #include <linux/mm.h>
 #include <net/sock.h>
 
-#define XDP_UMEM_SG_FLAG (1 << 1)
+#define XDP_UMEM_SG_FLAG BIT(3)
 
 struct net_device;
 struct xsk_queue;
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 6b9ebae2dc95..46797645a0c2 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -41,16 +41,37 @@ static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
 	return XDP_PACKET_HEADROOM + pool->headroom;
 }
 
+static inline u32 xsk_pool_get_tailroom(bool mbuf)
+{
+	return mbuf ? SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) : 0;
+}
+
 static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
 {
 	return pool->chunk_size;
 }
 
-static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
+static inline u32 __xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
 {
 	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool);
 }
 
+static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
+{
+	u32 frame_size =  __xsk_pool_get_rx_frame_size(pool);
+	struct xdp_umem *umem = pool->umem;
+	bool mbuf;
+
+	/* Reserve tailroom only for zero-copy pools that opted into
+	 * multi-buffer. The reserved area is used for skb_shared_info,
+	 * matching the XDP core's xdp_data_hard_end() layout.
+	 */
+	mbuf = pool->dev && (umem->flags & XDP_UMEM_SG_FLAG);
+	frame_size -= xsk_pool_get_tailroom(mbuf);
+
+	return ALIGN_DOWN(frame_size, 128);
+}
+
 static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
 {
 	return pool->unaligned ? 0 : xsk_pool_get_chunk_size(pool);
diff --git a/include/sound/sdca_interrupts.h b/include/sound/sdca_interrupts.h
index 8f13417d129a..109e7826ce38 100644
--- a/include/sound/sdca_interrupts.h
+++ b/include/sound/sdca_interrupts.h
@@ -69,6 +69,8 @@ struct sdca_interrupt_info {
 int sdca_irq_request(struct device *dev, struct sdca_interrupt_info *interrupt_info,
 		     int sdca_irq, const char *name, irq_handler_t handler,
 		     void *data);
+void sdca_irq_free(struct device *dev, struct sdca_interrupt_info *interrupt_info,
+		   int sdca_irq, const char *name, void *data);
 int sdca_irq_data_populate(struct device *dev, struct regmap *function_regmap,
 			   struct snd_soc_component *component,
 			   struct sdca_function_data *function,
@@ -81,6 +83,9 @@ int sdca_irq_populate_early(struct device *dev, struct regmap *function_regmap,
 int sdca_irq_populate(struct sdca_function_data *function,
 		      struct snd_soc_component *component,
 		      struct sdca_interrupt_info *info);
+void sdca_irq_cleanup(struct device *dev,
+		      struct sdca_function_data *function,
+		      struct sdca_interrupt_info *info);
 struct sdca_interrupt_info *sdca_irq_allocate(struct device *dev,
 					      struct regmap *regmap, int irq);
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 125bdc166bfe..0864700f76e0 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -769,12 +769,15 @@ TRACE_EVENT(btrfs_sync_file,
 	),
 
 	TP_fast_assign(
-		const struct dentry *dentry = file->f_path.dentry;
-		const struct inode *inode = d_inode(dentry);
+		struct dentry *dentry = file_dentry(file);
+		struct inode *inode = file_inode(file);
+		struct dentry *parent = dget_parent(dentry);
+		struct inode *parent_inode = d_inode(parent);
 
-		TP_fast_assign_fsid(btrfs_sb(file->f_path.dentry->d_sb));
+		dput(parent);
+		TP_fast_assign_fsid(btrfs_sb(inode->i_sb));
 		__entry->ino		= btrfs_ino(BTRFS_I(inode));
-		__entry->parent		= btrfs_ino(BTRFS_I(d_inode(dentry->d_parent)));
+		__entry->parent		= btrfs_ino(BTRFS_I(parent_inode));
 		__entry->datasync	= datasync;
 		__entry->root_objectid	= btrfs_root_id(BTRFS_I(inode)->root);
 	),
diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 33e99e792f1a..69cb3805ee81 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -32,7 +32,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
 		{ DMA_ATTR_ALLOC_SINGLE_PAGES, "ALLOC_SINGLE_PAGES" }, \
 		{ DMA_ATTR_NO_WARN, "NO_WARN" }, \
 		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
-		{ DMA_ATTR_MMIO, "MMIO" })
+		{ DMA_ATTR_MMIO, "MMIO" }, \
+		{ DMA_ATTR_CPU_CACHE_CLEAN, "CACHE_CLEAN" })
 
 DECLARE_EVENT_CLASS(dma_map,
 	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index dddb781b0507..bcc853298617 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -11,9 +11,14 @@
 #include <linux/const.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/stddef.h>
 #include <linux/ioctl.h>
 #include <asm/kvm.h>
 
+#ifdef __KERNEL__
+#include <linux/kvm_types.h>
+#endif
+
 #define KVM_API_VERSION 12
 
 /*
@@ -528,7 +533,7 @@ struct kvm_coalesced_mmio {
 
 struct kvm_coalesced_mmio_ring {
 	__u32 first, last;
-	struct kvm_coalesced_mmio coalesced_mmio[];
+	__DECLARE_FLEX_ARRAY(struct kvm_coalesced_mmio, coalesced_mmio);
 };
 
 #define KVM_COALESCED_MMIO_MAX \
@@ -578,7 +583,7 @@ struct kvm_clear_dirty_log {
 /* for KVM_SET_SIGNAL_MASK */
 struct kvm_signal_mask {
 	__u32 len;
-	__u8  sigset[];
+	__DECLARE_FLEX_ARRAY(__u8, sigset);
 };
 
 /* for KVM_TPR_ACCESS_REPORTING */
@@ -1036,7 +1041,7 @@ struct kvm_irq_routing_entry {
 struct kvm_irq_routing {
 	__u32 nr;
 	__u32 flags;
-	struct kvm_irq_routing_entry entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_irq_routing_entry, entries);
 };
 
 #define KVM_IRQFD_FLAG_DEASSIGN (1 << 0)
@@ -1127,7 +1132,7 @@ struct kvm_dirty_tlb {
 
 struct kvm_reg_list {
 	__u64 n; /* number of regs */
-	__u64 reg[];
+	__DECLARE_FLEX_ARRAY(__u64, reg);
 };
 
 struct kvm_one_reg {
@@ -1579,7 +1584,11 @@ struct kvm_stats_desc {
 	__u16 size;
 	__u32 offset;
 	__u32 bucket_size;
-	char name[];
+#ifdef __KERNEL__
+	char name[KVM_STATS_NAME_SIZE];
+#else
+	__DECLARE_FLEX_ARRAY(char, name);
+#endif
 };
 
 #define KVM_GET_STATS_FD  _IO(KVMIO,  0xce)
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 138ede653de4..21db33118591 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -63,6 +63,7 @@ enum map_err_types {
  * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
  * @paddr: physical start address of the mapping
  * @map_err_type: track whether dma_mapping_error() was checked
+ * @is_cache_clean: driver promises not to write to buffer while mapped
  * @stack_len: number of backtrace entries in @stack_entries
  * @stack_entries: stack of backtrace history
  */
@@ -76,7 +77,8 @@ struct dma_debug_entry {
 	int		 sg_call_ents;
 	int		 sg_mapped_ents;
 	phys_addr_t	 paddr;
-	enum map_err_types  map_err_type;
+	enum map_err_types map_err_type;
+	bool		 is_cache_clean;
 #ifdef CONFIG_STACKTRACE
 	unsigned int	stack_len;
 	unsigned long	stack_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
@@ -451,7 +453,7 @@ static int active_cacheline_set_overlap(phys_addr_t cln, int overlap)
 	return overlap;
 }
 
-static void active_cacheline_inc_overlap(phys_addr_t cln)
+static void active_cacheline_inc_overlap(phys_addr_t cln, bool is_cache_clean)
 {
 	int overlap = active_cacheline_read_overlap(cln);
 
@@ -460,7 +462,7 @@ static void active_cacheline_inc_overlap(phys_addr_t cln)
 	/* If we overflowed the overlap counter then we're potentially
 	 * leaking dma-mappings.
 	 */
-	WARN_ONCE(overlap > ACTIVE_CACHELINE_MAX_OVERLAP,
+	WARN_ONCE(!is_cache_clean && overlap > ACTIVE_CACHELINE_MAX_OVERLAP,
 		  pr_fmt("exceeded %d overlapping mappings of cacheline %pa\n"),
 		  ACTIVE_CACHELINE_MAX_OVERLAP, &cln);
 }
@@ -472,12 +474,15 @@ static int active_cacheline_dec_overlap(phys_addr_t cln)
 	return active_cacheline_set_overlap(cln, --overlap);
 }
 
-static int active_cacheline_insert(struct dma_debug_entry *entry)
+static int active_cacheline_insert(struct dma_debug_entry *entry,
+				   bool *overlap_cache_clean)
 {
 	phys_addr_t cln = to_cacheline_number(entry);
 	unsigned long flags;
 	int rc;
 
+	*overlap_cache_clean = false;
+
 	/* If the device is not writing memory then we don't have any
 	 * concerns about the cpu consuming stale data.  This mitigates
 	 * legitimate usages of overlapping mappings.
@@ -487,8 +492,16 @@ static int active_cacheline_insert(struct dma_debug_entry *entry)
 
 	spin_lock_irqsave(&radix_lock, flags);
 	rc = radix_tree_insert(&dma_active_cacheline, cln, entry);
-	if (rc == -EEXIST)
-		active_cacheline_inc_overlap(cln);
+	if (rc == -EEXIST) {
+		struct dma_debug_entry *existing;
+
+		active_cacheline_inc_overlap(cln, entry->is_cache_clean);
+		existing = radix_tree_lookup(&dma_active_cacheline, cln);
+		/* A lookup failure here after we got -EEXIST is unexpected. */
+		WARN_ON(!existing);
+		if (existing)
+			*overlap_cache_clean = existing->is_cache_clean;
+	}
 	spin_unlock_irqrestore(&radix_lock, flags);
 
 	return rc;
@@ -583,19 +596,25 @@ DEFINE_SHOW_ATTRIBUTE(dump);
  */
 static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 {
+	bool overlap_cache_clean;
 	struct hash_bucket *bucket;
 	unsigned long flags;
 	int rc;
 
+	entry->is_cache_clean = !!(attrs & DMA_ATTR_CPU_CACHE_CLEAN);
+
 	bucket = get_hash_bucket(entry, &flags);
 	hash_bucket_add(bucket, entry);
 	put_hash_bucket(bucket, flags);
 
-	rc = active_cacheline_insert(entry);
+	rc = active_cacheline_insert(entry, &overlap_cache_clean);
 	if (rc == -ENOMEM) {
 		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
-	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	} else if (rc == -EEXIST &&
+		   !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		   !(entry->is_cache_clean && overlap_cache_clean) &&
+		   dma_get_cache_alignment() >= L1_CACHE_BYTES &&
 		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
 		     is_swiotlb_active(entry->dev))) {
 		err_printk(entry->dev, entry,
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 3450c3751ef7..a2e2d516e51b 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/irq_work.h>
 #include <linux/mutex.h>
 #include <linux/preempt.h>
 #include <linux/rcupdate_wait.h>
@@ -41,6 +42,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
 	ssp->srcu_idx_max = 0;
 	INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
 	INIT_LIST_HEAD(&ssp->srcu_work.entry);
+	init_irq_work(&ssp->srcu_irq_work, srcu_tiny_irq_work);
 	return 0;
 }
 
@@ -84,6 +86,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
 void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
 	WARN_ON(ssp->srcu_lock_nesting[0] || ssp->srcu_lock_nesting[1]);
+	irq_work_sync(&ssp->srcu_irq_work);
 	flush_work(&ssp->srcu_work);
 	WARN_ON(ssp->srcu_gp_running);
 	WARN_ON(ssp->srcu_gp_waiting);
@@ -177,6 +180,20 @@ void srcu_drive_gp(struct work_struct *wp)
 }
 EXPORT_SYMBOL_GPL(srcu_drive_gp);
 
+/*
+ * Use an irq_work to defer schedule_work() to avoid acquiring the workqueue
+ * pool->lock while the caller might hold scheduler locks, causing lockdep
+ * splats due to workqueue_init() doing a wakeup.
+ */
+void srcu_tiny_irq_work(struct irq_work *irq_work)
+{
+	struct srcu_struct *ssp;
+
+	ssp = container_of(irq_work, struct srcu_struct, srcu_irq_work);
+	schedule_work(&ssp->srcu_work);
+}
+EXPORT_SYMBOL_GPL(srcu_tiny_irq_work);
+
 static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
 	unsigned long cookie;
@@ -189,7 +206,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 	WRITE_ONCE(ssp->srcu_idx_max, cookie);
 	if (!READ_ONCE(ssp->srcu_gp_running)) {
 		if (likely(srcu_init_done))
-			schedule_work(&ssp->srcu_work);
+			irq_work_queue(&ssp->srcu_irq_work);
 		else if (list_empty(&ssp->srcu_work.entry))
 			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
 	}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e3a6b8ed1d6d..3f8041197206 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1027,7 +1027,7 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
 	    dl_entity_overflow(dl_se, rq_clock(rq))) {
 
-		if (unlikely(!dl_is_implicit(dl_se) &&
+		if (unlikely((!dl_is_implicit(dl_se) || dl_se->dl_defer) &&
 			     !dl_time_before(dl_se->deadline, rq_clock(rq)) &&
 			     !is_dl_boosted(dl_se))) {
 			update_dl_revised_wakeup(dl_se, rq);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2f571083ce9e..8dc495561c3f 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1069,7 +1069,7 @@ static int __parse_imm_string(char *str, char **pbuf, int offs)
 {
 	size_t len = strlen(str);
 
-	if (str[len - 1] != '"') {
+	if (!len || str[len - 1] != '"') {
 		trace_probe_log_err(offs + len, IMMSTR_NO_CLOSE);
 		return -EINVAL;
 	}
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 896760bad455..3abbe7405be4 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -277,7 +277,7 @@ static __always_inline
 size_t copy_from_user_iter_nocache(void __user *iter_from, size_t progress,
 				   size_t len, void *to, void *priv2)
 {
-	return __copy_from_user_inatomic_nocache(to + progress, iter_from, len);
+	return copy_from_user_inatomic_nontemporal(to + progress, iter_from, len);
 }
 
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
@@ -296,7 +296,7 @@ static __always_inline
 size_t copy_from_user_iter_flushcache(void __user *iter_from, size_t progress,
 				      size_t len, void *to, void *priv2)
 {
-	return __copy_from_user_flushcache(to + progress, iter_from, len);
+	return copy_from_user_flushcache(to + progress, iter_from, len);
 }
 
 static __always_inline
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index c5740c6d37a2..d51c9c4d7b8d 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -618,12 +618,13 @@ static void cgwb_release_workfn(struct work_struct *work)
 	wb_shutdown(wb);
 
 	css_put(wb->memcg_css);
-	css_put(wb->blkcg_css);
-	mutex_unlock(&wb->bdi->cgwb_release_mutex);
 
 	/* triggers blkg destruction if no online users left */
 	blkcg_unpin_online(wb->blkcg_css);
 
+	css_put(wb->blkcg_css);
+	mutex_unlock(&wb->bdi->cgwb_release_mutex);
+
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 
 	spin_lock_irq(&cgwb_lock);
diff --git a/mm/filemap.c b/mm/filemap.c
index 1192e1e6f104..0f3c731549f5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -228,7 +228,8 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
 	page_cache_delete(mapping, folio, shadow);
 }
 
-void filemap_free_folio(struct address_space *mapping, struct folio *folio)
+static void filemap_free_folio(const struct address_space *mapping,
+		struct folio *folio)
 {
 	void (*free_folio)(struct folio *);
 
diff --git a/mm/internal.h b/mm/internal.h
index f35dbcf99a86..d54ef4a8f2c5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -471,7 +471,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
-void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
 		loff_t end);
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index f084e7a5df1e..9c880f607c6a 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -292,7 +292,7 @@ static void kasan_free_pte(pte_t *pte_start, pmd_t *pmd)
 			return;
 	}
 
-	pte_free_kernel(&init_mm, (pte_t *)page_to_virt(pmd_page(*pmd)));
+	pte_free_kernel(&init_mm, pte_start);
 	pmd_clear(pmd);
 }
 
@@ -307,7 +307,7 @@ static void kasan_free_pmd(pmd_t *pmd_start, pud_t *pud)
 			return;
 	}
 
-	pmd_free(&init_mm, (pmd_t *)page_to_virt(pud_page(*pud)));
+	pmd_free(&init_mm, pmd_start);
 	pud_clear(pud);
 }
 
@@ -322,7 +322,7 @@ static void kasan_free_pud(pud_t *pud_start, p4d_t *p4d)
 			return;
 	}
 
-	pud_free(&init_mm, (pud_t *)page_to_virt(p4d_page(*p4d)));
+	pud_free(&init_mm, pud_start);
 	p4d_clear(p4d);
 }
 
@@ -337,7 +337,7 @@ static void kasan_free_p4d(p4d_t *p4d_start, pgd_t *pgd)
 			return;
 	}
 
-	p4d_free(&init_mm, (p4d_t *)page_to_virt(pgd_page(*pgd)));
+	p4d_free(&init_mm, p4d_start);
 	pgd_clear(pgd);
 }
 
diff --git a/mm/truncate.c b/mm/truncate.c
index 12467c1bd711..8617a12cb169 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -622,6 +622,7 @@ static int folio_launder(struct address_space *mapping, struct folio *folio)
 int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 			   gfp_t gfp)
 {
+	void (*free_folio)(struct folio *);
 	int ret;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -648,9 +649,12 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
 		inode_lru_list_add(mapping->host);
+	free_folio = mapping->a_ops->free_folio;
 	spin_unlock(&mapping->host->i_lock);
 
-	filemap_free_folio(mapping, folio);
+	if (free_folio)
+		free_folio(folio);
+	folio_put_refs(folio, folio_nr_pages(folio));
 	return 1;
 failed:
 	xa_unlock_irq(&mapping->i_pages);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e6dfd5f28acd..a553e821dff6 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -573,7 +573,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		 * in the case of shared pmds.  fault mutex prevents
 		 * races with other faulting threads.
 		 */
-		idx = linear_page_index(dst_vma, dst_addr);
+		idx = hugetlb_linear_page_index(dst_vma, dst_addr);
 		mapping = dst_vma->vm_file->f_mapping;
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a966d36d0e79..92dcd9d21b7c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -3100,7 +3100,7 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 * hci_connect_le serializes the connection attempts so only one
 	 * connection can be in BT_CONNECT at time.
 	 */
-	if (conn->state == BT_CONNECT && hdev->req_status == HCI_REQ_PEND) {
+	if (conn->state == BT_CONNECT && READ_ONCE(hdev->req_status) == HCI_REQ_PEND) {
 		switch (hci_skb_event(hdev->sent_cmd)) {
 		case HCI_EV_CONN_COMPLETE:
 		case HCI_EV_LE_CONN_COMPLETE:
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8ccec73dce45..0f86b81b3973 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4125,7 +4125,7 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		kfree_skb(skb);
 	}
 
-	if (hdev->req_status == HCI_REQ_PEND &&
+	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND &&
 	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d638e62f3002..74339358d599 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -25,11 +25,11 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 {
 	bt_dev_dbg(hdev, "result 0x%2.2x", result);
 
-	if (hdev->req_status != HCI_REQ_PEND)
+	if (READ_ONCE(hdev->req_status) != HCI_REQ_PEND)
 		return;
 
 	hdev->req_result = result;
-	hdev->req_status = HCI_REQ_DONE;
+	WRITE_ONCE(hdev->req_status, HCI_REQ_DONE);
 
 	/* Free the request command so it is not used as response */
 	kfree_skb(hdev->req_skb);
@@ -167,20 +167,20 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	hci_cmd_sync_add(&req, opcode, plen, param, event, sk);
 
-	hdev->req_status = HCI_REQ_PEND;
+	WRITE_ONCE(hdev->req_status, HCI_REQ_PEND);
 
 	err = hci_req_sync_run(&req);
 	if (err < 0)
 		return ERR_PTR(err);
 
 	err = wait_event_interruptible_timeout(hdev->req_wait_q,
-					       hdev->req_status != HCI_REQ_PEND,
+					       READ_ONCE(hdev->req_status) != HCI_REQ_PEND,
 					       timeout);
 
 	if (err == -ERESTARTSYS)
 		return ERR_PTR(-EINTR);
 
-	switch (hdev->req_status) {
+	switch (READ_ONCE(hdev->req_status)) {
 	case HCI_REQ_DONE:
 		err = -bt_to_errno(hdev->req_result);
 		break;
@@ -194,7 +194,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		break;
 	}
 
-	hdev->req_status = 0;
+	WRITE_ONCE(hdev->req_status, 0);
 	hdev->req_result = 0;
 	skb = hdev->req_rsp;
 	hdev->req_rsp = NULL;
@@ -665,9 +665,9 @@ void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
 {
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
-	if (hdev->req_status == HCI_REQ_PEND) {
+	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND) {
 		hdev->req_result = err;
-		hdev->req_status = HCI_REQ_CANCELED;
+		WRITE_ONCE(hdev->req_status, HCI_REQ_CANCELED);
 
 		queue_work(hdev->workqueue, &hdev->cmd_sync_cancel_work);
 	}
@@ -683,12 +683,12 @@ void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
 {
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
-	if (hdev->req_status == HCI_REQ_PEND) {
+	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND) {
 		/* req_result is __u32 so error must be positive to be properly
 		 * propagated.
 		 */
 		hdev->req_result = err < 0 ? -err : err;
-		hdev->req_status = HCI_REQ_CANCELED;
+		WRITE_ONCE(hdev->req_status, HCI_REQ_CANCELED);
 
 		wake_up_interruptible(&hdev->req_wait_q);
 	}
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 0501ffcb8a3d..e2c17f620f00 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -597,6 +597,9 @@ static void br_fdb_delete_locals_per_vlan_port(struct net_bridge *br,
 		dev = br->dev;
 	}
 
+	if (!vg)
+		return;
+
 	list_for_each_entry(v, &vg->vlan_list, vlist)
 		br_fdb_find_delete_local(br, p, dev->dev_addr, v->vid);
 }
@@ -630,6 +633,9 @@ static int br_fdb_insert_locals_per_vlan_port(struct net_bridge *br,
 		dev = br->dev;
 	}
 
+	if (!vg)
+		return 0;
+
 	list_for_each_entry(v, &vg->vlan_list, vlist) {
 		if (!br_vlan_should_use(v))
 			continue;
diff --git a/net/can/raw.c b/net/can/raw.c
index 12293363413c..d7c557802cf4 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -360,6 +360,14 @@ static int raw_notifier(struct notifier_block *nb, unsigned long msg,
 	return NOTIFY_DONE;
 }
 
+static void raw_sock_destruct(struct sock *sk)
+{
+	struct raw_sock *ro = raw_sk(sk);
+
+	free_percpu(ro->uniq);
+	can_sock_destruct(sk);
+}
+
 static int raw_init(struct sock *sk)
 {
 	struct raw_sock *ro = raw_sk(sk);
@@ -386,6 +394,8 @@ static int raw_init(struct sock *sk)
 	if (unlikely(!ro->uniq))
 		return -ENOMEM;
 
+	sk->sk_destruct = raw_sock_destruct;
+
 	/* set notifier */
 	spin_lock(&raw_notifier_lock);
 	list_add_tail(&ro->notifier, &raw_notifier_list);
@@ -435,7 +445,6 @@ static int raw_release(struct socket *sock)
 	ro->bound = 0;
 	ro->dev = NULL;
 	ro->count = 0;
-	free_percpu(ro->uniq);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 11cdad3972ad..c2ada5107dff 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3894,28 +3894,42 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	goto out;
 }
 
-static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
+static struct net *rtnl_get_peer_net(struct sk_buff *skb,
+				     const struct rtnl_link_ops *ops,
 				     struct nlattr *tbp[],
 				     struct nlattr *data[],
 				     struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[IFLA_MAX + 1];
+	struct nlattr *tb[IFLA_MAX + 1], **attrs;
+	struct net *net;
 	int err;
 
-	if (!data || !data[ops->peer_type])
-		return rtnl_link_get_net_ifla(tbp);
-
-	err = rtnl_nla_parse_ifinfomsg(tb, data[ops->peer_type], extack);
-	if (err < 0)
-		return ERR_PTR(err);
-
-	if (ops->validate) {
-		err = ops->validate(tb, NULL, extack);
+	if (!data || !data[ops->peer_type]) {
+		attrs = tbp;
+	} else {
+		err = rtnl_nla_parse_ifinfomsg(tb, data[ops->peer_type], extack);
 		if (err < 0)
 			return ERR_PTR(err);
+
+		if (ops->validate) {
+			err = ops->validate(tb, NULL, extack);
+			if (err < 0)
+				return ERR_PTR(err);
+		}
+
+		attrs = tb;
 	}
 
-	return rtnl_link_get_net_ifla(tb);
+	net = rtnl_link_get_net_ifla(attrs);
+	if (IS_ERR_OR_NULL(net))
+		return net;
+
+	if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
+		put_net(net);
+		return ERR_PTR(-EPERM);
+	}
+
+	return net;
 }
 
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -4054,7 +4068,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 
 		if (ops->peer_type) {
-			peer_net = rtnl_get_peer_net(ops, tb, data, extack);
+			peer_net = rtnl_get_peer_net(skb, ops, tb, data, extack);
 			if (IS_ERR(peer_net)) {
 				ret = PTR_ERR(peer_net);
 				goto put_ops;
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 136a67c36a20..0798c82096bd 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -1327,7 +1327,7 @@ void devlink_fmsg_dump_skb(struct devlink_fmsg *fmsg, const struct sk_buff *skb)
 	if (sk) {
 		devlink_fmsg_pair_nest_start(fmsg, "sk");
 		devlink_fmsg_obj_nest_start(fmsg);
-		devlink_fmsg_put(fmsg, "family", sk->sk_type);
+		devlink_fmsg_put(fmsg, "family", sk->sk_family);
 		devlink_fmsg_put(fmsg, "type", sk->sk_type);
 		devlink_fmsg_put(fmsg, "proto", sk->sk_protocol);
 		devlink_fmsg_obj_nest_end(fmsg);
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e619b73f5063..11bda6c9eaa4 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1333,6 +1333,13 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 			if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
 				goto send_mal_query;
 			dev = ipv6_stub->ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
+			/*
+			 * If IPv6 identifier lookup is unavailable, silently
+			 * discard the request instead of misreporting NO_IF.
+			 */
+			if (IS_ERR(dev))
+				return false;
+
 			dev_hold(dev);
 			break;
 #endif
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 427c20117594..c958b8edfe54 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -905,8 +905,7 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
 		goto nla_put_failure;
 
 	if (op_flags & NHA_OP_FLAG_DUMP_STATS &&
-	    (nla_put_u32(skb, NHA_HW_STATS_ENABLE, nhg->hw_stats) ||
-	     nla_put_nh_group_stats(skb, nh, op_flags)))
+	    nla_put_nh_group_stats(skb, nh, op_flags))
 		goto nla_put_failure;
 
 	return 0;
@@ -1007,16 +1006,32 @@ static size_t nh_nlmsg_size_grp_res(struct nh_group *nhg)
 		nla_total_size_64bit(8);/* NHA_RES_GROUP_UNBALANCED_TIME */
 }
 
-static size_t nh_nlmsg_size_grp(struct nexthop *nh)
+static size_t nh_nlmsg_size_grp(struct nexthop *nh, u32 op_flags)
 {
 	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
 	size_t sz = sizeof(struct nexthop_grp) * nhg->num_nh;
 	size_t tot = nla_total_size(sz) +
-		nla_total_size(2); /* NHA_GROUP_TYPE */
+		nla_total_size(2) +	/* NHA_GROUP_TYPE */
+		nla_total_size(0);	/* NHA_FDB */
 
 	if (nhg->resilient)
 		tot += nh_nlmsg_size_grp_res(nhg);
 
+	if (op_flags & NHA_OP_FLAG_DUMP_STATS) {
+		tot += nla_total_size(0) +	  /* NHA_GROUP_STATS */
+		       nla_total_size(4);	  /* NHA_HW_STATS_ENABLE */
+		tot += nhg->num_nh *
+		       (nla_total_size(0) +	  /* NHA_GROUP_STATS_ENTRY */
+			nla_total_size(4) +	  /* NHA_GROUP_STATS_ENTRY_ID */
+			nla_total_size_64bit(8)); /* NHA_GROUP_STATS_ENTRY_PACKETS */
+
+		if (op_flags & NHA_OP_FLAG_DUMP_HW_STATS) {
+			tot += nhg->num_nh *
+			       nla_total_size_64bit(8); /* NHA_GROUP_STATS_ENTRY_PACKETS_HW */
+			tot += nla_total_size(4);	/* NHA_HW_STATS_USED */
+		}
+	}
+
 	return tot;
 }
 
@@ -1051,14 +1066,14 @@ static size_t nh_nlmsg_size_single(struct nexthop *nh)
 	return sz;
 }
 
-static size_t nh_nlmsg_size(struct nexthop *nh)
+static size_t nh_nlmsg_size(struct nexthop *nh, u32 op_flags)
 {
 	size_t sz = NLMSG_ALIGN(sizeof(struct nhmsg));
 
 	sz += nla_total_size(4); /* NHA_ID */
 
 	if (nh->is_group)
-		sz += nh_nlmsg_size_grp(nh) +
+		sz += nh_nlmsg_size_grp(nh, op_flags) +
 		      nla_total_size(4) +	/* NHA_OP_FLAGS */
 		      0;
 	else
@@ -1074,7 +1089,7 @@ static void nexthop_notify(int event, struct nexthop *nh, struct nl_info *info)
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(nh_nlmsg_size(nh), gfp_any());
+	skb = nlmsg_new(nh_nlmsg_size(nh, 0), gfp_any());
 	if (!skb)
 		goto errout;
 
@@ -3380,15 +3395,15 @@ static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err)
 		return err;
 
-	err = -ENOBUFS;
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!skb)
-		goto out;
-
 	err = -ENOENT;
 	nh = nexthop_find_by_id(net, id);
 	if (!nh)
-		goto errout_free;
+		goto out;
+
+	err = -ENOBUFS;
+	skb = nlmsg_new(nh_nlmsg_size(nh, op_flags), GFP_KERNEL);
+	if (!skb)
+		goto out;
 
 	err = nh_fill_node(skb, nh, RTM_NEWNEXTHOP, NETLINK_CB(in_skb).portid,
 			   nlh->nlmsg_seq, 0, op_flags);
diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index 8db7f965696a..b91de51ffa9e 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -710,7 +710,9 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 				    struct ioam6_schema *sc,
 				    unsigned int sclen, bool is_input)
 {
-	struct net_device *dev = skb_dst_dev(skb);
+	/* Note: skb_dst_dev_rcu() can't be NULL at this point. */
+	struct net_device *dev = skb_dst_dev_rcu(skb);
+	struct inet6_dev *i_skb_dev, *idev;
 	struct timespec64 ts;
 	ktime_t tstamp;
 	u64 raw64;
@@ -721,13 +723,16 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 
 	data = trace->data + trace->remlen * 4 - trace->nodelen * 4 - sclen * 4;
 
+	i_skb_dev = skb->dev ? __in6_dev_get(skb->dev) : NULL;
+	idev = __in6_dev_get(dev);
+
 	/* hop_lim and node_id */
 	if (trace->type.bit0) {
 		byte = ipv6_hdr(skb)->hop_limit;
 		if (is_input)
 			byte--;
 
-		raw32 = dev_net(dev)->ipv6.sysctl.ioam6_id;
+		raw32 = READ_ONCE(dev_net(dev)->ipv6.sysctl.ioam6_id);
 
 		*(__be32 *)data = cpu_to_be32((byte << 24) | raw32);
 		data += sizeof(__be32);
@@ -735,18 +740,18 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 
 	/* ingress_if_id and egress_if_id */
 	if (trace->type.bit1) {
-		if (!skb->dev)
+		if (!i_skb_dev)
 			raw16 = IOAM6_U16_UNAVAILABLE;
 		else
-			raw16 = (__force u16)READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_id);
+			raw16 = (__force u16)READ_ONCE(i_skb_dev->cnf.ioam6_id);
 
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
 
-		if (dev->flags & IFF_LOOPBACK)
+		if ((dev->flags & IFF_LOOPBACK) || !idev)
 			raw16 = IOAM6_U16_UNAVAILABLE;
 		else
-			raw16 = (__force u16)READ_ONCE(__in6_dev_get(dev)->cnf.ioam6_id);
+			raw16 = (__force u16)READ_ONCE(idev->cnf.ioam6_id);
 
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
@@ -798,12 +803,16 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		struct Qdisc *qdisc;
 		__u32 qlen, backlog;
 
-		if (dev->flags & IFF_LOOPBACK) {
+		if (dev->flags & IFF_LOOPBACK ||
+		    skb_get_queue_mapping(skb) >= dev->num_tx_queues) {
 			*(__be32 *)data = cpu_to_be32(IOAM6_U32_UNAVAILABLE);
 		} else {
 			queue = skb_get_tx_queue(dev, skb);
 			qdisc = rcu_dereference(queue->qdisc);
+
+			spin_lock_bh(qdisc_lock(qdisc));
 			qdisc_qstats_qlen_backlog(qdisc, &qlen, &backlog);
+			spin_unlock_bh(qdisc_lock(qdisc));
 
 			*(__be32 *)data = cpu_to_be32(backlog);
 		}
@@ -822,7 +831,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (is_input)
 			byte--;
 
-		raw64 = dev_net(dev)->ipv6.sysctl.ioam6_id_wide;
+		raw64 = READ_ONCE(dev_net(dev)->ipv6.sysctl.ioam6_id_wide);
 
 		*(__be64 *)data = cpu_to_be64(((u64)byte << 56) | raw64);
 		data += sizeof(__be64);
@@ -830,18 +839,18 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 
 	/* ingress_if_id and egress_if_id (wide) */
 	if (trace->type.bit9) {
-		if (!skb->dev)
+		if (!i_skb_dev)
 			raw32 = IOAM6_U32_UNAVAILABLE;
 		else
-			raw32 = READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_id_wide);
+			raw32 = READ_ONCE(i_skb_dev->cnf.ioam6_id_wide);
 
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
 
-		if (dev->flags & IFF_LOOPBACK)
+		if ((dev->flags & IFF_LOOPBACK) || !idev)
 			raw32 = IOAM6_U32_UNAVAILABLE;
 		else
-			raw32 = READ_ONCE(__in6_dev_get(dev)->cnf.ioam6_id_wide);
+			raw32 = READ_ONCE(idev->cnf.ioam6_id_wide);
 
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
diff --git a/net/ipv6/netfilter/ip6t_eui64.c b/net/ipv6/netfilter/ip6t_eui64.c
index d704f7ed300c..da69a27e8332 100644
--- a/net/ipv6/netfilter/ip6t_eui64.c
+++ b/net/ipv6/netfilter/ip6t_eui64.c
@@ -22,8 +22,7 @@ eui64_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	unsigned char eui64[8];
 
 	if (!(skb_mac_header(skb) >= skb->head &&
-	      skb_mac_header(skb) + ETH_HLEN <= skb->data) &&
-	    par->fragoff != 0) {
+	      skb_mac_header(skb) + ETH_HLEN <= skb->data)) {
 		par->hotdrop = true;
 		return false;
 	}
diff --git a/net/key/af_key.c b/net/key/af_key.c
index bc91aeeb74bb..a6a9a40717ee 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -757,6 +757,22 @@ static unsigned int pfkey_sockaddr_fill(const xfrm_address_t *xaddr, __be16 port
 	return 0;
 }
 
+static unsigned int pfkey_sockaddr_fill_zero_tail(const xfrm_address_t *xaddr,
+						  __be16 port,
+						  struct sockaddr *sa,
+						  unsigned short family)
+{
+	unsigned int prefixlen;
+	int sockaddr_len = pfkey_sockaddr_len(family);
+	int sockaddr_size = pfkey_sockaddr_size(family);
+
+	prefixlen = pfkey_sockaddr_fill(xaddr, port, sa, family);
+	if (sockaddr_size > sockaddr_len)
+		memset((u8 *)sa + sockaddr_len, 0, sockaddr_size - sockaddr_len);
+
+	return prefixlen;
+}
+
 static struct sk_buff *__pfkey_xfrm_state2msg(const struct xfrm_state *x,
 					      int add_keys, int hsc)
 {
@@ -3206,9 +3222,9 @@ static int pfkey_send_acquire(struct xfrm_state *x, struct xfrm_tmpl *t, struct
 	addr->sadb_address_proto = 0;
 	addr->sadb_address_reserved = 0;
 	addr->sadb_address_prefixlen =
-		pfkey_sockaddr_fill(&x->props.saddr, 0,
-				    (struct sockaddr *) (addr + 1),
-				    x->props.family);
+		pfkey_sockaddr_fill_zero_tail(&x->props.saddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      x->props.family);
 	if (!addr->sadb_address_prefixlen)
 		BUG();
 
@@ -3221,9 +3237,9 @@ static int pfkey_send_acquire(struct xfrm_state *x, struct xfrm_tmpl *t, struct
 	addr->sadb_address_proto = 0;
 	addr->sadb_address_reserved = 0;
 	addr->sadb_address_prefixlen =
-		pfkey_sockaddr_fill(&x->id.daddr, 0,
-				    (struct sockaddr *) (addr + 1),
-				    x->props.family);
+		pfkey_sockaddr_fill_zero_tail(&x->id.daddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      x->props.family);
 	if (!addr->sadb_address_prefixlen)
 		BUG();
 
@@ -3421,9 +3437,9 @@ static int pfkey_send_new_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr,
 	addr->sadb_address_proto = 0;
 	addr->sadb_address_reserved = 0;
 	addr->sadb_address_prefixlen =
-		pfkey_sockaddr_fill(&x->props.saddr, 0,
-				    (struct sockaddr *) (addr + 1),
-				    x->props.family);
+		pfkey_sockaddr_fill_zero_tail(&x->props.saddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      x->props.family);
 	if (!addr->sadb_address_prefixlen)
 		BUG();
 
@@ -3443,9 +3459,9 @@ static int pfkey_send_new_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr,
 	addr->sadb_address_proto = 0;
 	addr->sadb_address_reserved = 0;
 	addr->sadb_address_prefixlen =
-		pfkey_sockaddr_fill(ipaddr, 0,
-				    (struct sockaddr *) (addr + 1),
-				    x->props.family);
+		pfkey_sockaddr_fill_zero_tail(ipaddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      x->props.family);
 	if (!addr->sadb_address_prefixlen)
 		BUG();
 
@@ -3474,15 +3490,15 @@ static int set_sadb_address(struct sk_buff *skb, int sasize, int type,
 	switch (type) {
 	case SADB_EXT_ADDRESS_SRC:
 		addr->sadb_address_prefixlen = sel->prefixlen_s;
-		pfkey_sockaddr_fill(&sel->saddr, 0,
-				    (struct sockaddr *)(addr + 1),
-				    sel->family);
+		pfkey_sockaddr_fill_zero_tail(&sel->saddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      sel->family);
 		break;
 	case SADB_EXT_ADDRESS_DST:
 		addr->sadb_address_prefixlen = sel->prefixlen_d;
-		pfkey_sockaddr_fill(&sel->daddr, 0,
-				    (struct sockaddr *)(addr + 1),
-				    sel->family);
+		pfkey_sockaddr_fill_zero_tail(&sel->daddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      sel->family);
 		break;
 	default:
 		return -EINVAL;
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index f9b0f666600f..336e447897bd 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1290,6 +1290,11 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 		uh->source = inet->inet_sport;
 		uh->dest = inet->inet_dport;
 		udp_len = uhlen + session->hdr_len + data_len;
+		if (udp_len > U16_MAX) {
+			kfree_skb(skb);
+			ret = NET_XMIT_DROP;
+			goto out_unlock;
+		}
 		uh->len = htons(udp_len);
 
 		/* Calculate UDP checksum if configured to do so */
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 068702894377..ce217a25a6af 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1452,7 +1452,6 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 		ret = ip_vs_bind_scheduler(svc, sched);
 		if (ret)
 			goto out_err;
-		sched = NULL;
 	}
 
 	ret = ip_vs_start_estimator(ipvs, &svc->stats);
diff --git a/net/netfilter/nf_conntrack_ecache.c b/net/netfilter/nf_conntrack_ecache.c
index 81baf2082604..9df159448b89 100644
--- a/net/netfilter/nf_conntrack_ecache.c
+++ b/net/netfilter/nf_conntrack_ecache.c
@@ -247,6 +247,8 @@ void nf_ct_expect_event_report(enum ip_conntrack_expect_events event,
 	struct nf_ct_event_notifier *notify;
 	struct nf_conntrack_ecache *e;
 
+	lockdep_nfct_expect_lock_held();
+
 	rcu_read_lock();
 	notify = rcu_dereference(net->ct.nf_conntrack_event_cb);
 	if (!notify)
diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
index 2234c444a320..24d0576d84b7 100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -51,6 +51,7 @@ void nf_ct_unlink_expect_report(struct nf_conntrack_expect *exp,
 	struct net *net = nf_ct_exp_net(exp);
 	struct nf_conntrack_net *cnet;
 
+	lockdep_nfct_expect_lock_held();
 	WARN_ON(!master_help);
 	WARN_ON(timer_pending(&exp->timeout));
 
@@ -118,6 +119,8 @@ nf_ct_exp_equal(const struct nf_conntrack_tuple *tuple,
 
 bool nf_ct_remove_expect(struct nf_conntrack_expect *exp)
 {
+	lockdep_nfct_expect_lock_held();
+
 	if (timer_delete(&exp->timeout)) {
 		nf_ct_unlink_expect(exp);
 		nf_ct_expect_put(exp);
@@ -177,6 +180,8 @@ nf_ct_find_expectation(struct net *net,
 	struct nf_conntrack_expect *i, *exp = NULL;
 	unsigned int h;
 
+	lockdep_nfct_expect_lock_held();
+
 	if (!cnet->expect_count)
 		return NULL;
 
@@ -459,6 +464,8 @@ static inline int __nf_ct_expect_check(struct nf_conntrack_expect *expect,
 	unsigned int h;
 	int ret = 0;
 
+	lockdep_nfct_expect_lock_held();
+
 	if (!master_help) {
 		ret = -ESHUTDOWN;
 		goto out;
@@ -515,8 +522,9 @@ int nf_ct_expect_related_report(struct nf_conntrack_expect *expect,
 
 	nf_ct_expect_insert(expect);
 
-	spin_unlock_bh(&nf_conntrack_expect_lock);
 	nf_ct_expect_event_report(IPEXP_NEW, expect, portid, report);
+	spin_unlock_bh(&nf_conntrack_expect_lock);
+
 	return 0;
 out:
 	spin_unlock_bh(&nf_conntrack_expect_lock);
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 2bb9eb2d25fb..fbe9e3f1036f 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3337,31 +3337,37 @@ static int ctnetlink_get_expect(struct sk_buff *skb,
 	if (err < 0)
 		return err;
 
+	skb2 = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb2)
+		return -ENOMEM;
+
+	spin_lock_bh(&nf_conntrack_expect_lock);
 	exp = nf_ct_expect_find_get(info->net, &zone, &tuple);
-	if (!exp)
+	if (!exp) {
+		spin_unlock_bh(&nf_conntrack_expect_lock);
+		kfree_skb(skb2);
 		return -ENOENT;
+	}
 
 	if (cda[CTA_EXPECT_ID]) {
 		__be32 id = nla_get_be32(cda[CTA_EXPECT_ID]);
 
 		if (id != nf_expect_get_id(exp)) {
 			nf_ct_expect_put(exp);
+			spin_unlock_bh(&nf_conntrack_expect_lock);
+			kfree_skb(skb2);
 			return -ENOENT;
 		}
 	}
 
-	skb2 = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!skb2) {
-		nf_ct_expect_put(exp);
-		return -ENOMEM;
-	}
-
 	rcu_read_lock();
 	err = ctnetlink_exp_fill_info(skb2, NETLINK_CB(skb).portid,
 				      info->nlh->nlmsg_seq, IPCTNL_MSG_EXP_NEW,
 				      exp);
 	rcu_read_unlock();
 	nf_ct_expect_put(exp);
+	spin_unlock_bh(&nf_conntrack_expect_lock);
+
 	if (err <= 0) {
 		kfree_skb(skb2);
 		return -ENOMEM;
@@ -3408,22 +3414,26 @@ static int ctnetlink_del_expect(struct sk_buff *skb,
 		if (err < 0)
 			return err;
 
+		spin_lock_bh(&nf_conntrack_expect_lock);
+
 		/* bump usage count to 2 */
 		exp = nf_ct_expect_find_get(info->net, &zone, &tuple);
-		if (!exp)
+		if (!exp) {
+			spin_unlock_bh(&nf_conntrack_expect_lock);
 			return -ENOENT;
+		}
 
 		if (cda[CTA_EXPECT_ID]) {
 			__be32 id = nla_get_be32(cda[CTA_EXPECT_ID]);
 
 			if (id != nf_expect_get_id(exp)) {
 				nf_ct_expect_put(exp);
+				spin_unlock_bh(&nf_conntrack_expect_lock);
 				return -ENOENT;
 			}
 		}
 
 		/* after list removal, usage count == 1 */
-		spin_lock_bh(&nf_conntrack_expect_lock);
 		if (timer_delete(&exp->timeout)) {
 			nf_ct_unlink_expect_report(exp, NETLINK_CB(skb).portid,
 						   nlmsg_report(info->nlh));
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index dcd2493a9a40..b1f3eda85989 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -361,10 +361,10 @@ static void
 __nfulnl_send(struct nfulnl_instance *inst)
 {
 	if (inst->qlen > 1) {
-		struct nlmsghdr *nlh = nlmsg_put(inst->skb, 0, 0,
-						 NLMSG_DONE,
-						 sizeof(struct nfgenmsg),
-						 0);
+		struct nlmsghdr *nlh = nfnl_msg_put(inst->skb, 0, 0,
+						    NLMSG_DONE, 0,
+						    AF_UNSPEC, NFNETLINK_V0,
+						    htons(inst->group_num));
 		if (WARN_ONCE(!nlh, "bad nlskb size: %u, tailroom %d\n",
 			      inst->skb->len, skb_tailroom(inst->skb))) {
 			kfree_skb(inst->skb);
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 0b96d20bacb7..fe5942535245 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -49,8 +49,8 @@
 #endif
 
 #define NFQNL_QMAX_DEFAULT 1024
-#define NFQNL_HASH_MIN     1024
-#define NFQNL_HASH_MAX     1048576
+#define NFQNL_HASH_MIN     8
+#define NFQNL_HASH_MAX     32768
 
 /* We're using struct nlattr which has 16bit nla_len. Note that nla_len
  * includes the header length. Thus, the maximum packet length that we
@@ -60,29 +60,10 @@
  */
 #define NFQNL_MAX_COPY_RANGE (0xffff - NLA_HDRLEN)
 
-/* Composite key for packet lookup: (net, queue_num, packet_id) */
-struct nfqnl_packet_key {
-	possible_net_t net;
-	u32 packet_id;
-	u16 queue_num;
-} __aligned(sizeof(u32));  /* jhash2 requires 32-bit alignment */
-
-/* Global rhashtable - one for entire system, all netns */
-static struct rhashtable nfqnl_packet_map __read_mostly;
-
-/* Helper to initialize composite key */
-static inline void nfqnl_init_key(struct nfqnl_packet_key *key,
-				  struct net *net, u32 packet_id, u16 queue_num)
-{
-	memset(key, 0, sizeof(*key));
-	write_pnet(&key->net, net);
-	key->packet_id = packet_id;
-	key->queue_num = queue_num;
-}
-
 struct nfqnl_instance {
 	struct hlist_node hlist;		/* global list of queues */
-	struct rcu_head rcu;
+	struct rhashtable nfqnl_packet_map;
+	struct rcu_work	rwork;
 
 	u32 peer_portid;
 	unsigned int queue_maxlen;
@@ -106,6 +87,7 @@ struct nfqnl_instance {
 
 typedef int (*nfqnl_cmpfn)(struct nf_queue_entry *, unsigned long);
 
+static struct workqueue_struct *nfq_cleanup_wq __read_mostly;
 static unsigned int nfnl_queue_net_id __read_mostly;
 
 #define INSTANCE_BUCKETS	16
@@ -124,34 +106,10 @@ static inline u_int8_t instance_hashfn(u_int16_t queue_num)
 	return ((queue_num >> 8) ^ queue_num) % INSTANCE_BUCKETS;
 }
 
-/* Extract composite key from nf_queue_entry for hashing */
-static u32 nfqnl_packet_obj_hashfn(const void *data, u32 len, u32 seed)
-{
-	const struct nf_queue_entry *entry = data;
-	struct nfqnl_packet_key key;
-
-	nfqnl_init_key(&key, entry->state.net, entry->id, entry->queue_num);
-
-	return jhash2((u32 *)&key, sizeof(key) / sizeof(u32), seed);
-}
-
-/* Compare stack-allocated key against entry */
-static int nfqnl_packet_obj_cmpfn(struct rhashtable_compare_arg *arg,
-				  const void *obj)
-{
-	const struct nfqnl_packet_key *key = arg->key;
-	const struct nf_queue_entry *entry = obj;
-
-	return !net_eq(entry->state.net, read_pnet(&key->net)) ||
-	       entry->queue_num != key->queue_num ||
-	       entry->id != key->packet_id;
-}
-
 static const struct rhashtable_params nfqnl_rhashtable_params = {
 	.head_offset = offsetof(struct nf_queue_entry, hash_node),
-	.key_len = sizeof(struct nfqnl_packet_key),
-	.obj_hashfn = nfqnl_packet_obj_hashfn,
-	.obj_cmpfn = nfqnl_packet_obj_cmpfn,
+	.key_offset = offsetof(struct nf_queue_entry, id),
+	.key_len = sizeof(u32),
 	.automatic_shrinking = true,
 	.min_size = NFQNL_HASH_MIN,
 	.max_size = NFQNL_HASH_MAX,
@@ -178,17 +136,9 @@ instance_create(struct nfnl_queue_net *q, u_int16_t queue_num, u32 portid)
 	unsigned int h;
 	int err;
 
-	spin_lock(&q->instances_lock);
-	if (instance_lookup(q, queue_num)) {
-		err = -EEXIST;
-		goto out_unlock;
-	}
-
-	inst = kzalloc(sizeof(*inst), GFP_ATOMIC);
-	if (!inst) {
-		err = -ENOMEM;
-		goto out_unlock;
-	}
+	inst = kzalloc(sizeof(*inst), GFP_KERNEL_ACCOUNT);
+	if (!inst)
+		return ERR_PTR(-ENOMEM);
 
 	inst->queue_num = queue_num;
 	inst->peer_portid = portid;
@@ -198,9 +148,19 @@ instance_create(struct nfnl_queue_net *q, u_int16_t queue_num, u32 portid)
 	spin_lock_init(&inst->lock);
 	INIT_LIST_HEAD(&inst->queue_list);
 
+	err = rhashtable_init(&inst->nfqnl_packet_map, &nfqnl_rhashtable_params);
+	if (err < 0)
+		goto out_free;
+
+	spin_lock(&q->instances_lock);
+	if (instance_lookup(q, queue_num)) {
+		err = -EEXIST;
+		goto out_unlock;
+	}
+
 	if (!try_module_get(THIS_MODULE)) {
 		err = -EAGAIN;
-		goto out_free;
+		goto out_unlock;
 	}
 
 	h = instance_hashfn(queue_num);
@@ -210,25 +170,29 @@ instance_create(struct nfnl_queue_net *q, u_int16_t queue_num, u32 portid)
 
 	return inst;
 
-out_free:
-	kfree(inst);
 out_unlock:
 	spin_unlock(&q->instances_lock);
+	rhashtable_destroy(&inst->nfqnl_packet_map);
+out_free:
+	kfree(inst);
 	return ERR_PTR(err);
 }
 
 static void nfqnl_flush(struct nfqnl_instance *queue, nfqnl_cmpfn cmpfn,
 			unsigned long data);
 
-static void
-instance_destroy_rcu(struct rcu_head *head)
+static void instance_destroy_work(struct work_struct *work)
 {
-	struct nfqnl_instance *inst = container_of(head, struct nfqnl_instance,
-						   rcu);
+	struct nfqnl_instance *inst;
 
+	inst = container_of(to_rcu_work(work), struct nfqnl_instance,
+			    rwork);
 	rcu_read_lock();
 	nfqnl_flush(inst, NULL, 0);
 	rcu_read_unlock();
+
+	rhashtable_destroy(&inst->nfqnl_packet_map);
+
 	kfree(inst);
 	module_put(THIS_MODULE);
 }
@@ -237,7 +201,9 @@ static void
 __instance_destroy(struct nfqnl_instance *inst)
 {
 	hlist_del_rcu(&inst->hlist);
-	call_rcu(&inst->rcu, instance_destroy_rcu);
+
+	INIT_RCU_WORK(&inst->rwork, instance_destroy_work);
+	queue_rcu_work(nfq_cleanup_wq, &inst->rwork);
 }
 
 static void
@@ -253,9 +219,7 @@ __enqueue_entry(struct nfqnl_instance *queue, struct nf_queue_entry *entry)
 {
 	int err;
 
-	entry->queue_num = queue->queue_num;
-
-	err = rhashtable_insert_fast(&nfqnl_packet_map, &entry->hash_node,
+	err = rhashtable_insert_fast(&queue->nfqnl_packet_map, &entry->hash_node,
 				     nfqnl_rhashtable_params);
 	if (unlikely(err))
 		return err;
@@ -269,23 +233,19 @@ __enqueue_entry(struct nfqnl_instance *queue, struct nf_queue_entry *entry)
 static void
 __dequeue_entry(struct nfqnl_instance *queue, struct nf_queue_entry *entry)
 {
-	rhashtable_remove_fast(&nfqnl_packet_map, &entry->hash_node,
+	rhashtable_remove_fast(&queue->nfqnl_packet_map, &entry->hash_node,
 			       nfqnl_rhashtable_params);
 	list_del(&entry->list);
 	queue->queue_total--;
 }
 
 static struct nf_queue_entry *
-find_dequeue_entry(struct nfqnl_instance *queue, unsigned int id,
-		   struct net *net)
+find_dequeue_entry(struct nfqnl_instance *queue, unsigned int id)
 {
-	struct nfqnl_packet_key key;
 	struct nf_queue_entry *entry;
 
-	nfqnl_init_key(&key, net, id, queue->queue_num);
-
 	spin_lock_bh(&queue->lock);
-	entry = rhashtable_lookup_fast(&nfqnl_packet_map, &key,
+	entry = rhashtable_lookup_fast(&queue->nfqnl_packet_map, &id,
 				       nfqnl_rhashtable_params);
 
 	if (entry)
@@ -1534,7 +1494,7 @@ static int nfqnl_recv_verdict(struct sk_buff *skb, const struct nfnl_info *info,
 
 	verdict = ntohl(vhdr->verdict);
 
-	entry = find_dequeue_entry(queue, ntohl(vhdr->id), info->net);
+	entry = find_dequeue_entry(queue, ntohl(vhdr->id));
 	if (entry == NULL)
 		return -ENOENT;
 
@@ -1604,7 +1564,8 @@ static int nfqnl_recv_config(struct sk_buff *skb, const struct nfnl_info *info,
 	struct nfqnl_msg_config_cmd *cmd = NULL;
 	struct nfqnl_instance *queue;
 	__u32 flags = 0, mask = 0;
-	int ret = 0;
+
+	WARN_ON_ONCE(!lockdep_nfnl_is_held(NFNL_SUBSYS_QUEUE));
 
 	if (nfqa[NFQA_CFG_CMD]) {
 		cmd = nla_data(nfqa[NFQA_CFG_CMD]);
@@ -1650,47 +1611,44 @@ static int nfqnl_recv_config(struct sk_buff *skb, const struct nfnl_info *info,
 		}
 	}
 
+	/* Lookup queue under RCU. After peer_portid check (or for new queue
+	 * in BIND case), the queue is owned by the socket sending this message.
+	 * A socket cannot simultaneously send a message and close, so while
+	 * processing this CONFIG message, nfqnl_rcv_nl_event() (triggered by
+	 * socket close) cannot destroy this queue. Safe to use without RCU.
+	 */
 	rcu_read_lock();
 	queue = instance_lookup(q, queue_num);
 	if (queue && queue->peer_portid != NETLINK_CB(skb).portid) {
-		ret = -EPERM;
-		goto err_out_unlock;
+		rcu_read_unlock();
+		return -EPERM;
 	}
+	rcu_read_unlock();
 
 	if (cmd != NULL) {
 		switch (cmd->command) {
 		case NFQNL_CFG_CMD_BIND:
-			if (queue) {
-				ret = -EBUSY;
-				goto err_out_unlock;
-			}
-			queue = instance_create(q, queue_num,
-						NETLINK_CB(skb).portid);
-			if (IS_ERR(queue)) {
-				ret = PTR_ERR(queue);
-				goto err_out_unlock;
-			}
+			if (queue)
+				return -EBUSY;
+			queue = instance_create(q, queue_num, NETLINK_CB(skb).portid);
+			if (IS_ERR(queue))
+				return PTR_ERR(queue);
 			break;
 		case NFQNL_CFG_CMD_UNBIND:
-			if (!queue) {
-				ret = -ENODEV;
-				goto err_out_unlock;
-			}
+			if (!queue)
+				return -ENODEV;
 			instance_destroy(q, queue);
-			goto err_out_unlock;
+			return 0;
 		case NFQNL_CFG_CMD_PF_BIND:
 		case NFQNL_CFG_CMD_PF_UNBIND:
 			break;
 		default:
-			ret = -ENOTSUPP;
-			goto err_out_unlock;
+			return -EOPNOTSUPP;
 		}
 	}
 
-	if (!queue) {
-		ret = -ENODEV;
-		goto err_out_unlock;
-	}
+	if (!queue)
+		return -ENODEV;
 
 	if (nfqa[NFQA_CFG_PARAMS]) {
 		struct nfqnl_msg_config_params *params =
@@ -1715,9 +1673,7 @@ static int nfqnl_recv_config(struct sk_buff *skb, const struct nfnl_info *info,
 		spin_unlock_bh(&queue->lock);
 	}
 
-err_out_unlock:
-	rcu_read_unlock();
-	return ret;
+	return 0;
 }
 
 static const struct nfnl_callback nfqnl_cb[NFQNL_MSG_MAX] = {
@@ -1887,40 +1843,38 @@ static int __init nfnetlink_queue_init(void)
 {
 	int status;
 
-	status = rhashtable_init(&nfqnl_packet_map, &nfqnl_rhashtable_params);
-	if (status < 0)
-		return status;
+	nfq_cleanup_wq = alloc_ordered_workqueue("nfq_workqueue", 0);
+	if (!nfq_cleanup_wq)
+		return -ENOMEM;
 
 	status = register_pernet_subsys(&nfnl_queue_net_ops);
-	if (status < 0) {
-		pr_err("failed to register pernet ops\n");
-		goto cleanup_rhashtable;
-	}
+	if (status < 0)
+		goto cleanup_pernet_subsys;
 
-	netlink_register_notifier(&nfqnl_rtnl_notifier);
-	status = nfnetlink_subsys_register(&nfqnl_subsys);
-	if (status < 0) {
-		pr_err("failed to create netlink socket\n");
-		goto cleanup_netlink_notifier;
-	}
+	status = netlink_register_notifier(&nfqnl_rtnl_notifier);
+	if (status < 0)
+	       goto cleanup_rtnl_notifier;
 
 	status = register_netdevice_notifier(&nfqnl_dev_notifier);
-	if (status < 0) {
-		pr_err("failed to register netdevice notifier\n");
-		goto cleanup_netlink_subsys;
-	}
+	if (status < 0)
+		goto cleanup_dev_notifier;
+
+	status = nfnetlink_subsys_register(&nfqnl_subsys);
+	if (status < 0)
+		goto cleanup_nfqnl_subsys;
 
 	nf_register_queue_handler(&nfqh);
 
 	return status;
 
-cleanup_netlink_subsys:
-	nfnetlink_subsys_unregister(&nfqnl_subsys);
-cleanup_netlink_notifier:
+cleanup_nfqnl_subsys:
+	unregister_netdevice_notifier(&nfqnl_dev_notifier);
+cleanup_dev_notifier:
 	netlink_unregister_notifier(&nfqnl_rtnl_notifier);
+cleanup_rtnl_notifier:
 	unregister_pernet_subsys(&nfnl_queue_net_ops);
-cleanup_rhashtable:
-	rhashtable_destroy(&nfqnl_packet_map);
+cleanup_pernet_subsys:
+	destroy_workqueue(nfq_cleanup_wq);
 	return status;
 }
 
@@ -1931,9 +1885,7 @@ static void __exit nfnetlink_queue_fini(void)
 	nfnetlink_subsys_unregister(&nfqnl_subsys);
 	netlink_unregister_notifier(&nfqnl_rtnl_notifier);
 	unregister_pernet_subsys(&nfnl_queue_net_ops);
-
-	rhashtable_destroy(&nfqnl_packet_map);
-
+	destroy_workqueue(nfq_cleanup_wq);
 	rcu_barrier(); /* Wait for completion of call_rcu()'s */
 }
 
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 7ff90325c97f..6395982e4d95 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -242,7 +242,7 @@ static int nft_pipapo_avx2_lookup_4b_2(unsigned long *map, unsigned long *fill,
 
 		b = nft_pipapo_avx2_refill(i_ul, &map[i_ul], fill, f->mt, last);
 		if (last)
-			return b;
+			ret = b;
 
 		if (unlikely(ret == -1))
 			ret = b / XSAVE_YMM_SIZE;
@@ -319,7 +319,7 @@ static int nft_pipapo_avx2_lookup_4b_4(unsigned long *map, unsigned long *fill,
 
 		b = nft_pipapo_avx2_refill(i_ul, &map[i_ul], fill, f->mt, last);
 		if (last)
-			return b;
+			ret = b;
 
 		if (unlikely(ret == -1))
 			ret = b / XSAVE_YMM_SIZE;
@@ -414,7 +414,7 @@ static int nft_pipapo_avx2_lookup_4b_8(unsigned long *map, unsigned long *fill,
 
 		b = nft_pipapo_avx2_refill(i_ul, &map[i_ul], fill, f->mt, last);
 		if (last)
-			return b;
+			ret = b;
 
 		if (unlikely(ret == -1))
 			ret = b / XSAVE_YMM_SIZE;
@@ -505,7 +505,7 @@ static int nft_pipapo_avx2_lookup_4b_12(unsigned long *map, unsigned long *fill,
 
 		b = nft_pipapo_avx2_refill(i_ul, &map[i_ul], fill, f->mt, last);
 		if (last)
-			return b;
+			ret = b;
 
 		if (unlikely(ret == -1))
 			ret = b / XSAVE_YMM_SIZE;
@@ -641,7 +641,7 @@ static int nft_pipapo_avx2_lookup_4b_32(unsigned long *map, unsigned long *fill,
 
 		b = nft_pipapo_avx2_refill(i_ul, &map[i_ul], fill, f->mt, last);
 		if (last)
-			return b;
+			ret = b;
 
 		if (unlikely(ret == -1))
 			ret = b / XSAVE_YMM_SIZE;
@@ -699,7 +699,7 @@ static int nft_pipapo_avx2_lookup_8b_1(unsigned long *map, unsigned long *fill,
 
 		b = nft_pipapo_avx2_refill(i_ul, &map[i_ul], fill, f->mt, last);
 		if (last)
-			return b;
+			ret = b;
 
 		if (unlikely(ret == -1))
 			ret = b / XSAVE_YMM_SIZE;
@@ -764,7 +764,7 @@ static int nft_pipapo_avx2_lookup_8b_2(unsigned long *map, unsigned long *fill,
 
 		b = nft_pipapo_avx2_refill(i_ul, &map[i_ul], fill, f->mt, last);
 		if (last)
-			return b;
+			ret = b;
 
 		if (unlikely(ret == -1))
 			ret = b / XSAVE_YMM_SIZE;
@@ -839,7 +839,7 @@ static int nft_pipapo_avx2_lookup_8b_4(unsigned long *map, unsigned long *fill,
 
 		b = nft_pipapo_avx2_refill(i_ul, &map[i_ul], fill, f->mt, last);
 		if (last)
-			return b;
+			ret = b;
 
 		if (unlikely(ret == -1))
 			ret = b / XSAVE_YMM_SIZE;
@@ -925,7 +925,7 @@ static int nft_pipapo_avx2_lookup_8b_6(unsigned long *map, unsigned long *fill,
 
 		b = nft_pipapo_avx2_refill(i_ul, &map[i_ul], fill, f->mt, last);
 		if (last)
-			return b;
+			ret = b;
 
 		if (unlikely(ret == -1))
 			ret = b / XSAVE_YMM_SIZE;
@@ -1019,7 +1019,7 @@ static int nft_pipapo_avx2_lookup_8b_16(unsigned long *map, unsigned long *fill,
 
 		b = nft_pipapo_avx2_refill(i_ul, &map[i_ul], fill, f->mt, last);
 		if (last)
-			return b;
+			ret = b;
 
 		if (unlikely(ret == -1))
 			ret = b / XSAVE_YMM_SIZE;
diff --git a/net/netfilter/xt_multiport.c b/net/netfilter/xt_multiport.c
index 44a00f5acde8..a1691ff405d3 100644
--- a/net/netfilter/xt_multiport.c
+++ b/net/netfilter/xt_multiport.c
@@ -105,6 +105,28 @@ multiport_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	return ports_match_v1(multiinfo, ntohs(pptr[0]), ntohs(pptr[1]));
 }
 
+static bool
+multiport_valid_ranges(const struct xt_multiport_v1 *multiinfo)
+{
+	unsigned int i;
+
+	for (i = 0; i < multiinfo->count; i++) {
+		if (!multiinfo->pflags[i])
+			continue;
+
+		if (++i >= multiinfo->count)
+			return false;
+
+		if (multiinfo->pflags[i])
+			return false;
+
+		if (multiinfo->ports[i - 1] > multiinfo->ports[i])
+			return false;
+	}
+
+	return true;
+}
+
 static inline bool
 check(u_int16_t proto,
       u_int8_t ip_invflags,
@@ -127,8 +149,10 @@ static int multiport_mt_check(const struct xt_mtchk_param *par)
 	const struct ipt_ip *ip = par->entryinfo;
 	const struct xt_multiport_v1 *multiinfo = par->matchinfo;
 
-	return check(ip->proto, ip->invflags, multiinfo->flags,
-		     multiinfo->count) ? 0 : -EINVAL;
+	if (!check(ip->proto, ip->invflags, multiinfo->flags, multiinfo->count))
+		return -EINVAL;
+
+	return multiport_valid_ranges(multiinfo) ? 0 : -EINVAL;
 }
 
 static int multiport_mt6_check(const struct xt_mtchk_param *par)
@@ -136,8 +160,10 @@ static int multiport_mt6_check(const struct xt_mtchk_param *par)
 	const struct ip6t_ip6 *ip = par->entryinfo;
 	const struct xt_multiport_v1 *multiinfo = par->matchinfo;
 
-	return check(ip->proto, ip->invflags, multiinfo->flags,
-		     multiinfo->count) ? 0 : -EINVAL;
+	if (!check(ip->proto, ip->invflags, multiinfo->flags, multiinfo->count))
+		return -EINVAL;
+
+	return multiport_valid_ranges(multiinfo) ? 0 : -EINVAL;
 }
 
 static struct xt_match multiport_mt_reg[] __read_mostly = {
diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index 3adf4589852a..e29dd10f280e 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -424,6 +424,12 @@ static void digital_in_recv_sdd_res(struct nfc_digital_dev *ddev, void *arg,
 		size = 4;
 	}
 
+	if (target->nfcid1_len + size > NFC_NFCID1_MAXSIZE) {
+		PROTOCOL_ERR("4.7.2.1");
+		rc = -EPROTO;
+		goto exit;
+	}
+
 	memcpy(target->nfcid1 + target->nfcid1_len, sdd_res->nfcid1 + offset,
 	       size);
 	target->nfcid1_len += size;
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 444a3774c8e8..da8d3add0018 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1091,6 +1091,7 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	/* Pass the payload upstream */
@@ -1182,6 +1183,7 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	if (sk->sk_state == LLCP_CONNECTED) {
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 0939e6b2ba4d..3a377604ad34 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -604,8 +604,12 @@ TC_INDIRECT_SCOPE int tcf_csum_act(struct sk_buff *skb,
 			protocol = skb->protocol;
 			orig_vlan_tag_present = true;
 		} else {
-			struct vlan_hdr *vlan = (struct vlan_hdr *)skb->data;
+			struct vlan_hdr *vlan;
 
+			if (!pskb_may_pull(skb, VLAN_HLEN))
+				goto drop;
+
+			vlan = (struct vlan_hdr *)skb->data;
 			protocol = vlan->h_vlan_encapsulated_proto;
 			skb_pull(skb, VLAN_HLEN);
 			skb_reset_network_header(skb);
diff --git a/net/unix/diag.c b/net/unix/diag.c
index ca3473026151..c9c1e51c4419 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -28,18 +28,23 @@ static int sk_diag_dump_name(struct sock *sk, struct sk_buff *nlskb)
 
 static int sk_diag_dump_vfs(struct sock *sk, struct sk_buff *nlskb)
 {
-	struct dentry *dentry = unix_sk(sk)->path.dentry;
+	struct unix_diag_vfs uv;
+	struct dentry *dentry;
+	bool have_vfs = false;
 
+	unix_state_lock(sk);
+	dentry = unix_sk(sk)->path.dentry;
 	if (dentry) {
-		struct unix_diag_vfs uv = {
-			.udiag_vfs_ino = d_backing_inode(dentry)->i_ino,
-			.udiag_vfs_dev = dentry->d_sb->s_dev,
-		};
-
-		return nla_put(nlskb, UNIX_DIAG_VFS, sizeof(uv), &uv);
+		uv.udiag_vfs_ino = d_backing_inode(dentry)->i_ino;
+		uv.udiag_vfs_dev = dentry->d_sb->s_dev;
+		have_vfs = true;
 	}
+	unix_state_unlock(sk);
 
-	return 0;
+	if (!have_vfs)
+		return 0;
+
+	return nla_put(nlskb, UNIX_DIAG_VFS, sizeof(uv), &uv);
 }
 
 static int sk_diag_dump_peer(struct sock *sk, struct sk_buff *nlskb)
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 9f76ca591d54..9ec7bd948acc 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -202,7 +202,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (!unaligned_chunks && chunks_rem)
 		return -EINVAL;
 
-	if (headroom >= chunk_size - XDP_PACKET_HEADROOM)
+	if (headroom > chunk_size - XDP_PACKET_HEADROOM -
+		       SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - 128)
 		return -EINVAL;
 
 	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index a6d3938154f2..4a1cc44ab305 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -239,7 +239,7 @@ static u32 xsk_copy_xdp(void *to, void **from, u32 to_len,
 
 static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
-	u32 frame_size = xsk_pool_get_rx_frame_size(xs->pool);
+	u32 frame_size = __xsk_pool_get_rx_frame_size(xs->pool);
 	void *copy_from = xsk_copy_xdp_start(xdp), *copy_to;
 	u32 from_len, meta_len, rem, num_desc;
 	struct xdp_buff_xsk *xskb;
@@ -338,7 +338,7 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
 		return -EINVAL;
 
-	if (len > xsk_pool_get_rx_frame_size(xs->pool) && !xs->sg) {
+	if (len > __xsk_pool_get_rx_frame_size(xs->pool) && !xs->sg) {
 		xs->rx_dropped++;
 		return -ENOSPC;
 	}
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 51526034c42a..1f96bdf1e7a6 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -10,6 +10,8 @@
 #include "xdp_umem.h"
 #include "xsk.h"
 
+#define ETH_PAD_LEN (ETH_HLEN + 2 * VLAN_HLEN  + ETH_FCS_LEN)
+
 void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 {
 	if (!xs->tx)
@@ -158,8 +160,12 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
 int xp_assign_dev(struct xsk_buff_pool *pool,
 		  struct net_device *netdev, u16 queue_id, u16 flags)
 {
+	u32 needed = netdev->mtu + ETH_PAD_LEN;
+	u32 segs = netdev->xdp_zc_max_segs;
+	bool mbuf = flags & XDP_USE_SG;
 	bool force_zc, force_copy;
 	struct netdev_bpf bpf;
+	u32 frame_size;
 	int err = 0;
 
 	ASSERT_RTNL();
@@ -179,7 +185,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	if (err)
 		return err;
 
-	if (flags & XDP_USE_SG)
+	if (mbuf)
 		pool->umem->flags |= XDP_UMEM_SG_FLAG;
 
 	if (flags & XDP_USE_NEED_WAKEUP)
@@ -201,8 +207,24 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_pool;
 	}
 
-	if (netdev->xdp_zc_max_segs == 1 && (flags & XDP_USE_SG)) {
-		err = -EOPNOTSUPP;
+	if (mbuf) {
+		if (segs == 1) {
+			err = -EOPNOTSUPP;
+			goto err_unreg_pool;
+		}
+	} else {
+		segs = 1;
+	}
+
+	/* open-code xsk_pool_get_rx_frame_size() as pool->dev is not
+	 * set yet at this point; we are before getting down to driver
+	 */
+	frame_size = __xsk_pool_get_rx_frame_size(pool) -
+		     xsk_pool_get_tailroom(mbuf);
+	frame_size = ALIGN_DOWN(frame_size, 128);
+
+	if (needed > frame_size * segs) {
+		err = -EINVAL;
 		goto err_unreg_pool;
 	}
 
@@ -252,6 +274,10 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
 		return -EINVAL;
 
 	flags = umem->zc ? XDP_ZEROCOPY : XDP_COPY;
+
+	if (umem->flags & XDP_UMEM_SG_FLAG)
+		flags |= XDP_USE_SG;
+
 	if (umem_xs->pool->uses_need_wakeup)
 		flags |= XDP_USE_NEED_WAKEUP;
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c32d34c441ee..29c94ee0ceb2 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4290,6 +4290,8 @@ static void xfrm_policy_fini(struct net *net)
 #endif
 	xfrm_policy_flush(net, XFRM_POLICY_TYPE_MAIN, false);
 
+	synchronize_rcu();
+
 	WARN_ON(!list_empty(&net->xfrm.policy_all));
 
 	for (dir = 0; dir < XFRM_POLICY_MAX; dir++) {
@@ -4526,9 +4528,6 @@ static struct xfrm_policy *xfrm_migrate_policy_find(const struct xfrm_selector *
 	pol = xfrm_policy_lookup_bytype(net, type, &fl, sel->family, dir, if_id);
 	if (IS_ERR_OR_NULL(pol))
 		goto out_unlock;
-
-	if (!xfrm_pol_hold_rcu(pol))
-		pol = NULL;
 out_unlock:
 	rcu_read_unlock();
 	return pol;
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 306e4f65ce26..b3f69c0760d4 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2668,7 +2668,8 @@ static inline unsigned int xfrm_aevent_msgsize(struct xfrm_state *x)
 	       + nla_total_size(4) /* XFRM_AE_RTHR */
 	       + nla_total_size(4) /* XFRM_AE_ETHR */
 	       + nla_total_size(sizeof(x->dir)) /* XFRMA_SA_DIR */
-	       + nla_total_size(4); /* XFRMA_SA_PCPU */
+	       + nla_total_size(4) /* XFRMA_SA_PCPU */
+	       + nla_total_size(sizeof(x->if_id)); /* XFRMA_IF_ID */
 }
 
 static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
@@ -2780,7 +2781,12 @@ static int xfrm_get_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
 	c.portid = nlh->nlmsg_pid;
 
 	err = build_aevent(r_skb, x, &c);
-	BUG_ON(err < 0);
+	if (err < 0) {
+		spin_unlock_bh(&x->lock);
+		xfrm_state_put(x);
+		kfree_skb(r_skb);
+		return err;
+	}
 
 	err = nlmsg_unicast(net->xfrm.nlsk, r_skb, NETLINK_CB(skb).portid);
 	spin_unlock_bh(&x->lock);
@@ -4158,6 +4164,7 @@ static int build_mapping(struct sk_buff *skb, struct xfrm_state *x,
 
 	um = nlmsg_data(nlh);
 
+	memset(&um->id, 0, sizeof(um->id));
 	memcpy(&um->id.daddr, &x->id.daddr, sizeof(um->id.daddr));
 	um->id.spi = x->id.spi;
 	um->id.family = x->props.family;
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c0250244cf7a..8bdec08cd12a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -641,6 +641,7 @@ our $signature_tags = qr{(?xi:
 	Reviewed-by:|
 	Reported-by:|
 	Suggested-by:|
+	Assisted-by:|
 	To:|
 	Cc:
 )};
@@ -3091,6 +3092,15 @@ sub process {
 				}
 			}
 
+			# Assisted-by uses AGENT_NAME:MODEL_VERSION format, not email
+			if ($sign_off =~ /^Assisted-by:/i) {
+				if ($email !~ /^\S+:\S+/) {
+					WARN("BAD_SIGN_OFF",
+					     "Assisted-by expects 'AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]' format\n" . $herecurr);
+				}
+				next;
+			}
+
 			my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
 			my $suggested_email = format_email(($email_name, $name_comment, $email_address, $comment));
 			if ($suggested_email eq "") {
diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index d4308b726183..943ff1228b48 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -298,7 +298,7 @@ are loaded as well."""
             if p == "-bpf":
                 monitor_bpf = True
             else:
-                p.append(os.path.abspath(os.path.expanduser(p)))
+                self.module_paths.append(os.path.abspath(os.path.expanduser(p)))
         self.module_paths.append(os.getcwd())
 
         if self.breakpoint is not None:
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 766c2d91cd81..91673d131d8c 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -190,9 +190,10 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
 
     def is_root_crate(build_file, target):
         try:
-            return f"{target}.o" in open(build_file).read()
+            contents = build_file.read_text()
         except FileNotFoundError:
             return False
+        return f"{target}.o" in contents
 
     # Then, the rest outside of `rust/`.
     #
diff --git a/sound/firewire/fireworks/fireworks_command.c b/sound/firewire/fireworks/fireworks_command.c
index 2b595ee0bc35..05550f36fac5 100644
--- a/sound/firewire/fireworks/fireworks_command.c
+++ b/sound/firewire/fireworks/fireworks_command.c
@@ -151,10 +151,13 @@ efw_transaction(struct snd_efw *efw, unsigned int category,
 	    (be32_to_cpu(header->category) != category) ||
 	    (be32_to_cpu(header->command) != command) ||
 	    (be32_to_cpu(header->status) != EFR_STATUS_OK)) {
+		u32 st = be32_to_cpu(header->status);
+
 		dev_err(&efw->unit->device, "EFW command failed [%u/%u]: %s\n",
 			be32_to_cpu(header->category),
 			be32_to_cpu(header->command),
-			efr_status_names[be32_to_cpu(header->status)]);
+			st < ARRAY_SIZE(efr_status_names) ?
+				efr_status_names[st] : "unknown");
 		err = -EIO;
 		goto end;
 	}
diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index cb39054bfe79..d954de3fd225 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3725,22 +3725,42 @@ static void alc245_tas2781_spi_hp_fixup_muteled(struct hda_codec *codec,
 	alc_fixup_hp_gpio_led(codec, action, 0x04, 0x0);
 	alc285_fixup_hp_coef_micmute_led(codec, fix, action);
 }
+
+static void alc245_hp_spk_mute_led_update(void *private_data, int enabled)
+{
+	struct hda_codec *codec = private_data;
+	unsigned int val;
+
+	val = enabled ? 0x08 : 0x04; /* 0x08 led on, 0x04 led off */
+	alc_update_coef_idx(codec, 0x0b, 0x0c, val);
+}
+
 /* JD2: mute led GPIO3: micmute led */
 static void alc245_tas2781_i2c_hp_fixup_muteled(struct hda_codec *codec,
 					  const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
 	static const hda_nid_t conn[] = { 0x02 };
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
+		if (!hp_pin) {
+			spec->gen.vmaster_mute.hook = alc245_hp_spk_mute_led_update;
+			spec->gen.vmaster_mute_led = 1;
+		}
 		spec->gen.auto_mute_via_amp = 1;
 		snd_hda_override_conn_list(codec, 0x17, ARRAY_SIZE(conn), conn);
 		break;
+	case HDA_FIXUP_ACT_INIT:
+		if (!hp_pin)
+			alc245_hp_spk_mute_led_update(codec, !spec->gen.master_mute);
+		break;
 	}
 
 	tas2781_fixup_txnw_i2c(codec, fix, action);
-	alc245_fixup_hp_mute_led_coefbit(codec, fix, action);
+	if (hp_pin)
+		alc245_fixup_hp_mute_led_coefbit(codec, fix, action);
 	alc285_fixup_hp_coef_micmute_led(codec, fix, action);
 }
 /*
@@ -6888,6 +6908,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8730, "HP ProBook 445 G7", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8735, "HP ProBook 435 G7", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8736, "HP", ALC285_FIXUP_HP_GPIO_AMP_INIT),
+	SND_PCI_QUIRK(0x103c, 0x8756, "HP ENVY Laptop 13-ba0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8760, "HP EliteBook 8{4,5}5 G7", ALC285_FIXUP_HP_BEEP_MICMUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x876e, "HP ENVY x360 Convertible 13-ay0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x877a, "HP", ALC285_FIXUP_HP_MUTE_LED),
@@ -6901,6 +6922,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87cb, "HP Pavilion 15-eg0xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87cc, "HP Pavilion 15-eg0xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87df, "HP ProBook 430 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
@@ -7133,6 +7155,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8da7, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da8, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8dd4, "HP EliteStudio 8 AIO", ALC274_FIXUP_HP_AIO_BIND_DACS),
+	SND_PCI_QUIRK(0x103c, 0x8dd7, "HP Laptop 15-fd0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8de8, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
 	SND_PCI_QUIRK(0x103c, 0x8de9, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
 	SND_PCI_QUIRK(0x103c, 0x8dec, "HP EliteBook 640 G12", ALC236_FIXUP_HP_GPIO_LED),
@@ -7242,6 +7265,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x14e3, "ASUS G513PI/PU/PV", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x14f2, "ASUS VivoBook X515JA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1503, "ASUS G733PY/PZ/PZV/PYV", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x1514, "ASUS ROG Flow Z13 GZ302EAC", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x1533, "ASUS GV302XA/XJ/XQ/XU/XV/XI", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1573, "ASUS GZ301VV/VQ/VU/VJ/VA/VC/VE/VVC/VQC/VUC/VJC/VEC/VCC", ALC285_FIXUP_ASUS_HEADSET_MIC),
@@ -7386,6 +7410,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc188, "Samsung Galaxy Book Flex (NT950QCT-A38A)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc189, "Samsung Galaxy Book Flex (NT950QCG-X716)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc18a, "Samsung Galaxy Book Ion (NP930XCJ-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
+	SND_PCI_QUIRK(0x144d, 0xc1ac, "Samsung Galaxy Book2 Pro 360 (NP950QED)", ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc1a3, "Samsung Galaxy Book Pro (NP935XDB-KC1SE)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc1a4, "Samsung Galaxy Book Pro 360 (NT935QBD)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc1a6, "Samsung Galaxy Book Pro 360 (NP930QBD)", ALC298_FIXUP_SAMSUNG_AMP),
@@ -7581,6 +7606,10 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3834, "Lenovo IdeaPad Slim 9i 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x383d, "Legion Y9000X 2019", ALC285_FIXUP_LEGION_Y9000X_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3843, "Lenovo Yoga 9i / Yoga Book 9i", ALC287_FIXUP_LENOVO_YOGA_BOOK_9I),
+	/* Yoga Pro 7 14IMH9 shares PCI SSID 17aa:3847 with Legion 7 16ACHG6;
+	 * use codec SSID to distinguish them
+	 */
+	HDA_CODEC_QUIRK(0x17aa, 0x38cf, "Lenovo Yoga Pro 7 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3847, "Legion 7 16ACHG6", ALC287_FIXUP_LEGION_16ACHG6),
 	SND_PCI_QUIRK(0x17aa, 0x384a, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
@@ -7612,6 +7641,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38ab, "Thinkbook 16P", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38b4, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	HDA_CODEC_QUIRK(0x17aa, 0x391c, "Lenovo Yoga 7 2-in-1 14AKP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	HDA_CODEC_QUIRK(0x17aa, 0x391d, "Lenovo Yoga 7 2-in-1 16AKP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x38b5, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b6, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b7, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
@@ -7641,7 +7671,9 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38fd, "ThinkBook plus Gen5 Hybrid", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x390d, "Lenovo Yoga Pro 7 14ASP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3911, "Lenovo Yoga Pro 7 14IAH10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
+	SND_PCI_QUIRK(0x17aa, 0x391a, "Lenovo Yoga Slim 7 14AKP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x391f, "Yoga S990-16 pro Quad YC Quad", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3920, "Yoga S990-16 pro Quad VECO Quad", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3929, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
@@ -7735,6 +7767,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0xf111, 0x0009, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0xf111, 0x000b, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0xf111, 0x000c, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0xf111, 0x000f, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
diff --git a/sound/pci/asihpi/hpimsgx.c b/sound/pci/asihpi/hpimsgx.c
index b68e6bfbbfba..ed1c7b774436 100644
--- a/sound/pci/asihpi/hpimsgx.c
+++ b/sound/pci/asihpi/hpimsgx.c
@@ -581,8 +581,10 @@ static u16 adapter_prepare(u16 adapter)
 		HPI_ADAPTER_OPEN);
 	hm.adapter_index = adapter;
 	hw_entry_point(&hm, &hr);
-	memcpy(&rESP_HPI_ADAPTER_OPEN[adapter], &hr,
-		sizeof(rESP_HPI_ADAPTER_OPEN[0]));
+	memcpy(&rESP_HPI_ADAPTER_OPEN[adapter].h, &hr,
+		sizeof(rESP_HPI_ADAPTER_OPEN[adapter].h));
+	memcpy(&rESP_HPI_ADAPTER_OPEN[adapter].a, &hr.u.ax.info,
+		sizeof(rESP_HPI_ADAPTER_OPEN[adapter].a));
 	if (hr.error)
 		return hr.error;
 
diff --git a/sound/pci/ctxfi/ctvmem.h b/sound/pci/ctxfi/ctvmem.h
index da54cbcdb0be..43a0065b40c3 100644
--- a/sound/pci/ctxfi/ctvmem.h
+++ b/sound/pci/ctxfi/ctvmem.h
@@ -15,7 +15,7 @@
 #ifndef CTVMEM_H
 #define CTVMEM_H
 
-#define CT_PTP_NUM	4	/* num of device page table pages */
+#define CT_PTP_NUM	1	/* num of device page table pages */
 
 #include <linux/mutex.h>
 #include <linux/list.h>
diff --git a/sound/soc/amd/acp/acp-sdw-legacy-mach.c b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
index 4f92de33a71a..9d6744367276 100644
--- a/sound/soc/amd/acp/acp-sdw-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
@@ -99,17 +99,25 @@ static const struct dmi_system_id soc_sdw_quirk_table[] = {
 		.callback = soc_sdw_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "21YW"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "21YW"),
 		},
-		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
+		.driver_data = (void *)((ASOC_SDW_CODEC_SPKR) | (ASOC_SDW_ACP_DMIC)),
 	},
 	{
 		.callback = soc_sdw_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "21YX"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "21YX"),
 		},
-		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
+		.driver_data = (void *)((ASOC_SDW_CODEC_SPKR) | (ASOC_SDW_ACP_DMIC)),
+	},
+	{
+		.callback = soc_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HN7306EA"),
+		},
+		.driver_data = (void *)(ASOC_SDW_ACP_DMIC),
 	},
 	{}
 };
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1324543b42d7..4c0acdad13ea 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -45,6 +45,13 @@ static struct snd_soc_card acp6x_card = {
 };
 
 static const struct dmi_system_id yc_acp_quirk_table[] = {
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Laptop 15-fc0xxx"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
@@ -717,6 +724,20 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "PM1503CDA"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "BM1403CDA"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Thin A15 B7VE"),
+		}
+	},
 	{}
 };
 
diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
index 52e6266a7cb8..96dc637ccb20 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -520,7 +520,8 @@ static int avs_register_i2s_test_boards(struct avs_dev *adev)
 	if (num_elems > max_ssps) {
 		dev_err(adev->dev, "board supports only %d SSP, %d specified\n",
 			max_ssps, num_elems);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto exit;
 	}
 
 	for (ssp_port = 0; ssp_port < num_elems; ssp_port++) {
@@ -528,11 +529,13 @@ static int avs_register_i2s_test_boards(struct avs_dev *adev)
 		for_each_set_bit(tdm_slot, &tdm_slots, 16) {
 			ret = avs_register_i2s_test_board(adev, ssp_port, tdm_slot);
 			if (ret)
-				return ret;
+				goto exit;
 		}
 	}
 
-	return 0;
+exit:
+	kfree(array);
+	return ret;
 }
 
 static int avs_register_i2s_board(struct avs_dev *adev, struct snd_soc_acpi_mach *mach)
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 5b8367a966b9..e337a259bb58 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -744,13 +744,22 @@ static int apm_probe(gpr_device_t *gdev)
 
 	q6apm_get_apm_state(apm);
 
-	ret = devm_snd_soc_register_component(dev, &q6apm_audio_component, NULL, 0);
+	ret = snd_soc_register_component(dev, &q6apm_audio_component, NULL, 0);
 	if (ret < 0) {
 		dev_err(dev, "failed to register q6apm: %d\n", ret);
 		return ret;
 	}
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret)
+		snd_soc_unregister_component(dev);
+
+	return ret;
+}
+
+static void apm_remove(gpr_device_t *gdev)
+{
+	snd_soc_unregister_component(&gdev->dev);
 }
 
 struct audioreach_module *q6apm_find_module_by_mid(struct q6apm_graph *graph, uint32_t mid)
@@ -817,6 +826,7 @@ MODULE_DEVICE_TABLE(of, apm_device_id);
 
 static gpr_driver_t apm_driver = {
 	.probe = apm_probe,
+	.remove = apm_remove,
 	.gpr_callback = apm_callback,
 	.driver = {
 		.name = "qcom-apm",
diff --git a/sound/soc/sdca/sdca_class_function.c b/sound/soc/sdca/sdca_class_function.c
index 0028482a1e75..92600f419db4 100644
--- a/sound/soc/sdca/sdca_class_function.c
+++ b/sound/soc/sdca/sdca_class_function.c
@@ -19,6 +19,7 @@
 #include <sound/sdca_fdl.h>
 #include <sound/sdca_function.h>
 #include <sound/sdca_interrupts.h>
+#include <sound/sdca_jack.h>
 #include <sound/sdca_regmap.h>
 #include <sound/sdw.h>
 #include <sound/soc-component.h>
@@ -195,8 +196,26 @@ static int class_function_component_probe(struct snd_soc_component *component)
 	return sdca_irq_populate(drv->function, component, core->irq_info);
 }
 
+static void class_function_component_remove(struct snd_soc_component *component)
+{
+	struct class_function_drv *drv = snd_soc_component_get_drvdata(component);
+	struct sdca_class_drv *core = drv->core;
+
+	sdca_irq_cleanup(component->dev, drv->function, core->irq_info);
+}
+
+static int class_function_set_jack(struct snd_soc_component *component,
+				   struct snd_soc_jack *jack, void *d)
+{
+	struct class_function_drv *drv = snd_soc_component_get_drvdata(component);
+	struct sdca_class_drv *core = drv->core;
+
+	return sdca_jack_set_jack(core->irq_info, jack);
+}
+
 static const struct snd_soc_component_driver class_function_component_drv = {
 	.probe			= class_function_component_probe,
+	.remove			= class_function_component_remove,
 	.endianness		= 1,
 };
 
@@ -351,6 +370,9 @@ static int class_function_probe(struct auxiliary_device *auxdev,
 		return dev_err_probe(dev, PTR_ERR(drv->regmap),
 				     "failed to create regmap");
 
+	if (desc->type == SDCA_FUNCTION_TYPE_UAJ)
+		cmp_drv->set_jack = class_function_set_jack;
+
 	ret = sdca_asoc_populate_component(dev, drv->function, cmp_drv,
 					   &dais, &num_dais,
 					   &class_function_sdw_ops);
@@ -380,6 +402,13 @@ static int class_function_probe(struct auxiliary_device *auxdev,
 	return 0;
 }
 
+static void class_function_remove(struct auxiliary_device *auxdev)
+{
+	struct class_function_drv *drv = auxiliary_get_drvdata(auxdev);
+
+	sdca_irq_cleanup(drv->dev, drv->function, drv->core->irq_info);
+}
+
 static int class_function_runtime_suspend(struct device *dev)
 {
 	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
@@ -451,6 +480,7 @@ static struct auxiliary_driver class_function_drv = {
 	},
 
 	.probe		= class_function_probe,
+	.remove		= class_function_remove,
 	.id_table	= class_function_id_table
 };
 module_auxiliary_driver(class_function_drv);
diff --git a/sound/soc/sdca/sdca_interrupts.c b/sound/soc/sdca/sdca_interrupts.c
index 49b675e60143..76f50a0f6b0e 100644
--- a/sound/soc/sdca/sdca_interrupts.c
+++ b/sound/soc/sdca/sdca_interrupts.c
@@ -117,9 +117,7 @@ static irqreturn_t function_status_handler(int irq, void *data)
 
 	status = val;
 	for_each_set_bit(mask, &status, BITS_PER_BYTE) {
-		mask = 1 << mask;
-
-		switch (mask) {
+		switch (BIT(mask)) {
 		case SDCA_CTL_ENTITY_0_FUNCTION_NEEDS_INITIALIZATION:
 			//FIXME: Add init writes
 			break;
@@ -233,8 +231,7 @@ static int sdca_irq_request_locked(struct device *dev,
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_threaded_irq(dev, irq, NULL, handler,
-					IRQF_ONESHOT, name, data);
+	ret = request_threaded_irq(irq, NULL, handler, IRQF_ONESHOT, name, data);
 	if (ret)
 		return ret;
 
@@ -245,6 +242,22 @@ static int sdca_irq_request_locked(struct device *dev,
 	return 0;
 }
 
+static void sdca_irq_free_locked(struct device *dev, struct sdca_interrupt_info *info,
+				 int sdca_irq, const char *name, void *data)
+{
+	int irq;
+
+	irq = regmap_irq_get_virq(info->irq_data, sdca_irq);
+	if (irq < 0)
+		return;
+
+	free_irq(irq, data);
+
+	info->irqs[sdca_irq].irq = 0;
+
+	dev_dbg(dev, "freed irq %d for %s\n", irq, name);
+}
+
 /**
  * sdca_irq_request - request an individual SDCA interrupt
  * @dev: Pointer to the struct device against which things should be allocated.
@@ -283,6 +296,30 @@ int sdca_irq_request(struct device *dev, struct sdca_interrupt_info *info,
 }
 EXPORT_SYMBOL_NS_GPL(sdca_irq_request, "SND_SOC_SDCA");
 
+/**
+ * sdca_irq_free - free an individual SDCA interrupt
+ * @dev: Pointer to the struct device.
+ * @info: Pointer to the interrupt information structure.
+ * @sdca_irq: SDCA interrupt position.
+ * @name: Name to be given to the IRQ.
+ * @data: Private data pointer that will be passed to the handler.
+ *
+ * Typically this is handled internally by sdca_irq_cleanup, however if
+ * a device requires custom IRQ handling this can be called manually before
+ * calling sdca_irq_cleanup, which will then skip that IRQ whilst processing.
+ */
+void sdca_irq_free(struct device *dev, struct sdca_interrupt_info *info,
+		   int sdca_irq, const char *name, void *data)
+{
+	if (sdca_irq < 0 || sdca_irq >= SDCA_MAX_INTERRUPTS)
+		return;
+
+	guard(mutex)(&info->irq_lock);
+
+	sdca_irq_free_locked(dev, info, sdca_irq, name, data);
+}
+EXPORT_SYMBOL_NS_GPL(sdca_irq_free, "SND_SOC_SDCA");
+
 /**
  * sdca_irq_data_populate - Populate common interrupt data
  * @dev: Pointer to the Function device.
@@ -309,8 +346,8 @@ int sdca_irq_data_populate(struct device *dev, struct regmap *regmap,
 	if (!dev)
 		return -ENODEV;
 
-	name = devm_kasprintf(dev, GFP_KERNEL, "%s %s %s", function->desc->name,
-			      entity->label, control->label);
+	name = kasprintf(GFP_KERNEL, "%s %s %s", function->desc->name,
+			 entity->label, control->label);
 	if (!name)
 		return -ENOMEM;
 
@@ -497,6 +534,35 @@ int sdca_irq_populate(struct sdca_function_data *function,
 }
 EXPORT_SYMBOL_NS_GPL(sdca_irq_populate, "SND_SOC_SDCA");
 
+/**
+ * sdca_irq_cleanup - Free all the individual IRQs for an SDCA Function
+ * @sdev: Device pointer against which the sdca_interrupt_info was allocated.
+ * @function: Pointer to the SDCA Function.
+ * @info: Pointer to the SDCA interrupt info for this device.
+ *
+ * Typically this would be called from the driver for a single SDCA Function.
+ */
+void sdca_irq_cleanup(struct device *dev,
+		      struct sdca_function_data *function,
+		      struct sdca_interrupt_info *info)
+{
+	int i;
+
+	guard(mutex)(&info->irq_lock);
+
+	for (i = 0; i < SDCA_MAX_INTERRUPTS; i++) {
+		struct sdca_interrupt *interrupt = &info->irqs[i];
+
+		if (interrupt->function != function || !interrupt->irq)
+			continue;
+
+		sdca_irq_free_locked(dev, info, i, interrupt->name, interrupt);
+
+		kfree(interrupt->name);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(sdca_irq_cleanup, "SND_SOC_SDCA");
+
 /**
  * sdca_irq_allocate - allocate an SDCA interrupt structure for a device
  * @sdev: Device pointer against which things should be allocated.
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 23ba821cd759..c9a6471661ad 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2849,6 +2849,7 @@ int snd_soc_component_initialize(struct snd_soc_component *component,
 	INIT_LIST_HEAD(&component->dobj_list);
 	INIT_LIST_HEAD(&component->card_list);
 	INIT_LIST_HEAD(&component->list);
+	INIT_LIST_HEAD(&component->card_aux_list);
 	mutex_init(&component->io_mutex);
 
 	if (!component->name) {
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 686ecc040867..b039306454da 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1133,13 +1133,12 @@ static void hda_generic_machine_select(struct snd_sof_dev *sdev,
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
 
-static bool is_endpoint_present(struct sdw_slave *sdw_device,
-				struct asoc_sdw_codec_info *dai_info, int dai_type)
+static bool is_endpoint_present(struct sdw_slave *sdw_device, int dai_type)
 {
 	int i;
 
 	for (i = 0; i < sdw_device->sdca_data.num_functions; i++) {
-		if (dai_type == dai_info->dais[i].dai_type)
+		if (dai_type == asoc_sdw_get_dai_type(sdw_device->sdca_data.function[i].type))
 			return true;
 	}
 	dev_dbg(&sdw_device->dev, "Endpoint DAI type %d not found\n", dai_type);
@@ -1193,11 +1192,10 @@ static struct snd_soc_acpi_adr_device *find_acpi_adr_device(struct device *dev,
 		}
 		for (j = 0; j < codec_info_list[i].dai_num; j++) {
 			/* Check if the endpoint is present by the SDCA DisCo table */
-			if (!is_endpoint_present(sdw_device, &codec_info_list[i],
-						 codec_info_list[i].dais[j].dai_type))
+			if (!is_endpoint_present(sdw_device, codec_info_list[i].dais[j].dai_type))
 				continue;
 
-			endpoints[ep_index].num = ep_index;
+			endpoints[ep_index].num = j;
 			if (codec_info_list[i].dais[j].dai_type == SOC_SDW_DAI_TYPE_AMP) {
 				/* Assume all amp are aggregated */
 				endpoints[ep_index].aggregated = 1;
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 9bf8ab610a7e..8880ac5d8d6f 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -736,7 +736,7 @@ static int sof_parse_token_sets(struct snd_soc_component *scomp,
 		asize = le32_to_cpu(array->size);
 
 		/* validate asize */
-		if (asize < 0) { /* FIXME: A zero-size array makes no sense */
+		if (asize < sizeof(*array)) {
 			dev_err(scomp->dev, "error: invalid array size 0x%x\n",
 				asize);
 			return -EINVAL;
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 450e1585edee..3e82fa90e719 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -802,6 +802,7 @@ static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		break;
 	/* Left justified */
 	case SND_SOC_DAIFMT_MSB:
+		cr1 |= SAI_XCR1_CKSTR;
 		frcr |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSDEF;
 		break;
 	/* Right justified */
@@ -809,9 +810,11 @@ static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		frcr |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSDEF;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
+		cr1 |= SAI_XCR1_CKSTR;
 		frcr |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSOFF;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
+		cr1 |= SAI_XCR1_CKSTR;
 		frcr |= SAI_XFRCR_FSPOL;
 		break;
 	default:
diff --git a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
index 5ff78814e687..874f6cd503ca 100644
--- a/sound/usb/6fire/chip.c
+++ b/sound/usb/6fire/chip.c
@@ -53,11 +53,6 @@ static void usb6fire_chip_abort(struct sfire_chip *chip)
 			usb6fire_comm_abort(chip);
 		if (chip->control)
 			usb6fire_control_abort(chip);
-		if (chip->card) {
-			snd_card_disconnect(chip->card);
-			snd_card_free_when_closed(chip->card);
-			chip->card = NULL;
-		}
 	}
 }
 
@@ -168,6 +163,7 @@ static int usb6fire_chip_probe(struct usb_interface *intf,
 static void usb6fire_chip_disconnect(struct usb_interface *intf)
 {
 	struct sfire_chip *chip;
+	struct snd_card *card;
 
 	chip = usb_get_intfdata(intf);
 	if (chip) { /* if !chip, fw upload has been performed */
@@ -178,8 +174,19 @@ static void usb6fire_chip_disconnect(struct usb_interface *intf)
 				chips[chip->regidx] = NULL;
 			}
 
+			/*
+			 * Save card pointer before teardown.
+			 * snd_card_free_when_closed() may free card (and
+			 * the embedded chip) immediately, so it must be
+			 * called last and chip must not be accessed after.
+			 */
+			card = chip->card;
 			chip->shutdown = true;
+			if (card)
+				snd_card_disconnect(card);
 			usb6fire_chip_abort(chip);
+			if (card)
+				snd_card_free_when_closed(card);
 		}
 	}
 }
diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 9b890abd96d3..b4588915efa1 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -192,6 +192,7 @@ config SND_USB_AUDIO_QMI
 	tristate "Qualcomm Audio Offload driver"
 	depends on QCOM_QMI_HELPERS && SND_USB_AUDIO && SND_SOC_USB
 	depends on USB_XHCI_HCD && USB_XHCI_SIDEBAND
+	select AUXILIARY_BUS
 	help
 	  Say Y here to enable the Qualcomm USB audio offloading feature.
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index a56fb8ef987e..1686022db0ad 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2299,6 +2299,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_PLAYBACK_FIRST | QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x13e5, 0x0001, /* Serato Phono */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
+	DEVICE_FLG(0x152a, 0x880a, /* NeuralDSP Quad Cortex */
+		   0), /* Doesn't have the vendor quirk which would otherwise apply */
 	DEVICE_FLG(0x154e, 0x1002, /* Denon DCD-1500RE */
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x154e, 0x1003, /* Denon DA-300USB */
diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index bc71968df8e2..fd028715e9ec 100644
--- a/sound/usb/usx2y/us144mkii.c
+++ b/sound/usb/usx2y/us144mkii.c
@@ -420,7 +420,11 @@ static int tascam_probe(struct usb_interface *intf,
 
 	/* The device has two interfaces; we drive both from this driver. */
 	if (intf->cur_altsetting->desc.bInterfaceNumber == 1) {
-		tascam = usb_get_intfdata(usb_ifnum_to_if(dev, 0));
+		struct usb_interface *intf_zero = usb_ifnum_to_if(dev, 0);
+
+		if (!intf_zero)
+			return -ENODEV;
+		tascam = usb_get_intfdata(intf_zero);
 		if (tascam) {
 			usb_set_intfdata(intf, tascam);
 			tascam->iface1 = intf;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2f63f938d089..948e0cb3141d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1261,7 +1261,7 @@ static const char *uaccess_safe_builtin[] = {
 	"copy_mc_enhanced_fast_string",
 	"rep_stos_alternative",
 	"rep_movs_alternative",
-	"__copy_user_nocache",
+	"copy_to_nontemporal",
 	NULL
 };
 
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1b26d94c373f..c6060f65eaaf 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2732,30 +2732,29 @@ static inline int print_name(int width, int *printed, char *delim, char *name, e
 	UNUSED(type);
 
 	if (format == FORMAT_RAW && width >= 64)
-		return (sprintf(outp, "%s%-8s", (*printed++ ? delim : ""), name));
+		return (sprintf(outp, "%s%-8s", ((*printed)++ ? delim : ""), name));
 	else
-		return (sprintf(outp, "%s%s", (*printed++ ? delim : ""), name));
+		return (sprintf(outp, "%s%s", ((*printed)++ ? delim : ""), name));
 }
 
 static inline int print_hex_value(int width, int *printed, char *delim, unsigned long long value)
 {
 	if (width <= 32)
-		return (sprintf(outp, "%s%08x", (*printed++ ? delim : ""), (unsigned int)value));
+		return (sprintf(outp, "%s%08x", ((*printed)++ ? delim : ""), (unsigned int)value));
 	else
-		return (sprintf(outp, "%s%016llx", (*printed++ ? delim : ""), value));
+		return (sprintf(outp, "%s%016llx", ((*printed)++ ? delim : ""), value));
 }
 
 static inline int print_decimal_value(int width, int *printed, char *delim, unsigned long long value)
 {
-	if (width <= 32)
-		return (sprintf(outp, "%s%d", (*printed++ ? delim : ""), (unsigned int)value));
-	else
-		return (sprintf(outp, "%s%-8lld", (*printed++ ? delim : ""), value));
+	UNUSED(width);
+
+	return (sprintf(outp, "%s%lld", ((*printed)++ ? delim : ""), value));
 }
 
 static inline int print_float_value(int *printed, char *delim, double value)
 {
-	return (sprintf(outp, "%s%0.2f", (*printed++ ? delim : ""), value));
+	return (sprintf(outp, "%s%0.2f", ((*printed)++ ? delim : ""), value));
 }
 
 void print_header(char *delim)
@@ -3331,7 +3330,7 @@ int format_counters(PER_THREAD_PARAMS)
 	for (i = 0, pp = sys.perf_tp; pp; ++i, pp = pp->next) {
 		if (pp->format == FORMAT_RAW)
 			outp += print_hex_value(pp->width, &printed, delim, t->perf_counter[i]);
-		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
+		else if (pp->format == FORMAT_DELTA || pp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, t->perf_counter[i]);
 		else if (pp->format == FORMAT_PERCENT) {
 			if (pp->type == COUNTER_USEC)
@@ -3401,7 +3400,7 @@ int format_counters(PER_THREAD_PARAMS)
 	for (i = 0, pp = sys.perf_cp; pp; i++, pp = pp->next) {
 		if (pp->format == FORMAT_RAW)
 			outp += print_hex_value(pp->width, &printed, delim, c->perf_counter[i]);
-		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
+		else if (pp->format == FORMAT_DELTA || pp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, c->perf_counter[i]);
 		else if (pp->format == FORMAT_PERCENT)
 			outp += print_float_value(&printed, delim, pct(c->perf_counter[i], tsc));
@@ -3559,7 +3558,7 @@ int format_counters(PER_THREAD_PARAMS)
 			outp += print_hex_value(pp->width, &printed, delim, p->perf_counter[i]);
 		else if (pp->type == COUNTER_K2M)
 			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), (unsigned int)p->perf_counter[i] / 1000);
-		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
+		else if (pp->format == FORMAT_DELTA || pp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, p->perf_counter[i]);
 		else if (pp->format == FORMAT_PERCENT)
 			outp += print_float_value(&printed, delim, pct(p->perf_counter[i], tsc));
@@ -8813,10 +8812,13 @@ void process_cpuid()
 	edx_flags = edx;
 
 	if (!no_msr) {
-		if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch))
+		if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch)) {
 			warnx("get_msr(UCODE)");
-		else
+		} else {
 			ucode_patch_valid = true;
+			if (!authentic_amd && !hygon_genuine)
+				ucode_patch >>= 32;
+		}
 	}
 
 	/*
@@ -8830,7 +8832,7 @@ void process_cpuid()
 	if (!quiet) {
 		fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x (%d:%d:%d)", family, model, stepping, family, model, stepping);
 		if (ucode_patch_valid)
-			fprintf(outf, " microcode 0x%x", (unsigned int)((ucode_patch >> 32) & 0xFFFFFFFF));
+			fprintf(outf, " microcode 0x%x", (unsigned int)ucode_patch);
 		fputc('\n', outf);
 
 		fprintf(outf, "CPUID(0x80000000): max_extended_levels: 0x%x\n", max_extended_level);
@@ -10906,6 +10908,14 @@ void probe_cpuidle_residency(void)
 	}
 }
 
+static bool cpuidle_counter_wanted(char *name)
+{
+	if (is_deferred_skip(name))
+		return false;
+
+	return DO_BIC(BIC_cpuidle) || is_deferred_add(name);
+}
+
 void probe_cpuidle_counts(void)
 {
 	char path[64];
@@ -10915,7 +10925,7 @@ void probe_cpuidle_counts(void)
 	int min_state = 1024, max_state = 0;
 	char *sp;
 
-	if (!DO_BIC(BIC_cpuidle))
+	if (!DO_BIC(BIC_cpuidle) && !deferred_add_index)
 		return;
 
 	for (state = 10; state >= 0; --state) {
@@ -10930,12 +10940,6 @@ void probe_cpuidle_counts(void)
 
 		remove_underbar(name_buf);
 
-		if (!DO_BIC(BIC_cpuidle) && !is_deferred_add(name_buf))
-			continue;
-
-		if (is_deferred_skip(name_buf))
-			continue;
-
 		/* truncate "C1-HSW\n" to "C1", or truncate "C1\n" to "C1" */
 		sp = strchr(name_buf, '-');
 		if (!sp)
@@ -10950,16 +10954,19 @@ void probe_cpuidle_counts(void)
 			 * Add 'C1+' for C1, and so on. The 'below' sysfs file always contains 0 for
 			 * the last state, so do not add it.
 			 */
-
 			*sp = '+';
 			*(sp + 1) = '\0';
-			sprintf(path, "cpuidle/state%d/below", state);
-			add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+			if (cpuidle_counter_wanted(name_buf)) {
+				sprintf(path, "cpuidle/state%d/below", state);
+				add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+			}
 		}
 
 		*sp = '\0';
-		sprintf(path, "cpuidle/state%d/usage", state);
-		add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+		if (cpuidle_counter_wanted(name_buf)) {
+			sprintf(path, "cpuidle/state%d/usage", state);
+			add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+		}
 
 		/*
 		 * The 'above' sysfs file always contains 0 for the shallowest state (smallest
@@ -10968,8 +10975,10 @@ void probe_cpuidle_counts(void)
 		if (state != min_state) {
 			*sp = '-';
 			*(sp + 1) = '\0';
-			sprintf(path, "cpuidle/state%d/above", state);
-			add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+			if (cpuidle_counter_wanted(name_buf)) {
+				sprintf(path, "cpuidle/state%d/above", state);
+				add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+			}
 		}
 	}
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 411a18437d7e..74d498580052 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1863,4 +1863,141 @@ l1_%=:	r0 = 1;				\
 	: __clobber_all);
 }
 
+/* This test covers the bounds deduction when the u64 range and the tnum
+ * overlap only at umax. After instruction 3, the ranges look as follows:
+ *
+ * 0    umin=0xe01     umax=0xf00                              U64_MAX
+ * |    [xxxxxxxxxxxxxx]                                       |
+ * |----------------------------|------------------------------|
+ * |   x               x                                       | tnum values
+ *
+ * The verifier can therefore deduce that the R0=0xf0=240.
+ */
+SEC("socket")
+__description("bounds refinement with single-value tnum on umax")
+__msg("3: (15) if r0 == 0xe0 {{.*}} R0=240")
+__success __log_level(2)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void bounds_refinement_tnum_umax(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 |= 0xe0;			\
+	r0 &= 0xf0;			\
+	if r0 == 0xe0 goto +2;		\
+	if r0 == 0xf0 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test covers the bounds deduction when the u64 range and the tnum
+ * overlap only at umin. After instruction 3, the ranges look as follows:
+ *
+ * 0    umin=0xe00     umax=0xeff                              U64_MAX
+ * |    [xxxxxxxxxxxxxx]                                       |
+ * |----------------------------|------------------------------|
+ * |    x               x                                      | tnum values
+ *
+ * The verifier can therefore deduce that the R0=0xe0=224.
+ */
+SEC("socket")
+__description("bounds refinement with single-value tnum on umin")
+__msg("3: (15) if r0 == 0xf0 {{.*}} R0=224")
+__success __log_level(2)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void bounds_refinement_tnum_umin(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 |= 0xe0;			\
+	r0 &= 0xf0;			\
+	if r0 == 0xf0 goto +2;		\
+	if r0 == 0xe0 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test covers the bounds deduction when the only possible tnum value is
+ * in the middle of the u64 range. After instruction 3, the ranges look as
+ * follows:
+ *
+ * 0    umin=0x7cf   umax=0x7df                                U64_MAX
+ * |    [xxxxxxxxxxxx]                                         |
+ * |----------------------------|------------------------------|
+ * |     x            x            x            x            x | tnum values
+ *       |            +--- 0x7e0
+ *       +--- 0x7d0
+ *
+ * Since the lower four bits are zero, the tnum and the u64 range only overlap
+ * in R0=0x7d0=2000. Instruction 5 is therefore dead code.
+ */
+SEC("socket")
+__description("bounds refinement with single-value tnum in middle of range")
+__msg("3: (a5) if r0 < 0x7cf {{.*}} R0=2000")
+__success __log_level(2)
+__naked void bounds_refinement_tnum_middle(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	if r0 & 0x0f goto +4;		\
+	if r0 > 0x7df goto +3;		\
+	if r0 < 0x7cf goto +2;		\
+	if r0 == 0x7d0 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test cover the negative case for the tnum/u64 overlap. Since
+ * they contain the same two values (i.e., {0, 1}), we can't deduce
+ * anything more.
+ */
+SEC("socket")
+__description("bounds refinement: several overlaps between tnum and u64")
+__msg("2: (25) if r0 > 0x1 {{.*}} R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))")
+__failure __log_level(2)
+__naked void bounds_refinement_several_overlaps(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	if r0 < 0 goto +3;		\
+	if r0 > 1 goto +2;		\
+	if r0 == 1 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test cover the negative case for the tnum/u64 overlap. Since
+ * they overlap in the two values contained by the u64 range (i.e.,
+ * {0xf, 0x10}), we can't deduce anything more.
+ */
+SEC("socket")
+__description("bounds refinement: multiple overlaps between tnum and u64")
+__msg("2: (25) if r0 > 0x10 {{.*}} R0=scalar(smin=umin=smin32=umin32=15,smax=umax=smax32=umax32=16,var_off=(0x0; 0x1f))")
+__failure __log_level(2)
+__naked void bounds_refinement_multiple_overlaps(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	if r0 < 0xf goto +3;		\
+	if r0 > 0x10 goto +2;		\
+	if r0 == 0x10 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
index 0a6dfba3905b..6b0928e69051 100644
--- a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
@@ -36,8 +36,6 @@ static struct kvm_vm *sev_vm_create(bool es)
 
 	sev_vm_launch(vm, es ? SEV_POLICY_ES : 0);
 
-	if (es)
-		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 	return vm;
 }
 
diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index e8328c89d855..788689497e92 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -34,6 +34,7 @@
  */
 #include <lib/test_hmm_uapi.h>
 #include <mm/gup_test.h>
+#include <mm/vm_util.h>
 
 struct hmm_buffer {
 	void		*ptr;
@@ -548,7 +549,7 @@ TEST_F(hmm, anon_write_child)
 
 	for (migrate = 0; migrate < 2; ++migrate) {
 		for (use_thp = 0; use_thp < 2; ++use_thp) {
-			npages = ALIGN(use_thp ? TWOMEG : HMM_BUFFER_SIZE,
+			npages = ALIGN(use_thp ? read_pmd_pagesize() : HMM_BUFFER_SIZE,
 				       self->page_size) >> self->page_shift;
 			ASSERT_NE(npages, 0);
 			size = npages << self->page_shift;
@@ -728,7 +729,7 @@ TEST_F(hmm, anon_write_huge)
 	int *ptr;
 	int ret;
 
-	size = 2 * TWOMEG;
+	size = 2 * read_pmd_pagesize();
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
@@ -744,7 +745,7 @@ TEST_F(hmm, anon_write_huge)
 			   buffer->fd, 0);
 	ASSERT_NE(buffer->ptr, MAP_FAILED);
 
-	size = TWOMEG;
+	size /= 2;
 	npages = size >> self->page_shift;
 	map = (void *)ALIGN((uintptr_t)buffer->ptr, size);
 	ret = madvise(map, size, MADV_HUGEPAGE);
@@ -770,54 +771,6 @@ TEST_F(hmm, anon_write_huge)
 	hmm_buffer_free(buffer);
 }
 
-/*
- * Read numeric data from raw and tagged kernel status files.  Used to read
- * /proc and /sys data (without a tag) and from /proc/meminfo (with a tag).
- */
-static long file_read_ulong(char *file, const char *tag)
-{
-	int fd;
-	char buf[2048];
-	int len;
-	char *p, *q;
-	long val;
-
-	fd = open(file, O_RDONLY);
-	if (fd < 0) {
-		/* Error opening the file */
-		return -1;
-	}
-
-	len = read(fd, buf, sizeof(buf));
-	close(fd);
-	if (len < 0) {
-		/* Error in reading the file */
-		return -1;
-	}
-	if (len == sizeof(buf)) {
-		/* Error file is too large */
-		return -1;
-	}
-	buf[len] = '\0';
-
-	/* Search for a tag if provided */
-	if (tag) {
-		p = strstr(buf, tag);
-		if (!p)
-			return -1; /* looks like the line we want isn't there */
-		p += strlen(tag);
-	} else
-		p = buf;
-
-	val = strtol(p, &q, 0);
-	if (*q != ' ') {
-		/* Error parsing the file */
-		return -1;
-	}
-
-	return val;
-}
-
 /*
  * Write huge TLBFS page.
  */
@@ -826,15 +779,13 @@ TEST_F(hmm, anon_write_hugetlbfs)
 	struct hmm_buffer *buffer;
 	unsigned long npages;
 	unsigned long size;
-	unsigned long default_hsize;
+	unsigned long default_hsize = default_huge_page_size();
 	unsigned long i;
 	int *ptr;
 	int ret;
 
-	default_hsize = file_read_ulong("/proc/meminfo", "Hugepagesize:");
-	if (default_hsize < 0 || default_hsize*1024 < default_hsize)
+	if (!default_hsize)
 		SKIP(return, "Huge page size could not be determined");
-	default_hsize = default_hsize*1024; /* KB to B */
 
 	size = ALIGN(TWOMEG, default_hsize);
 	npages = size >> self->page_shift;
@@ -1606,7 +1557,7 @@ TEST_F(hmm, compound)
 	struct hmm_buffer *buffer;
 	unsigned long npages;
 	unsigned long size;
-	unsigned long default_hsize;
+	unsigned long default_hsize = default_huge_page_size();
 	int *ptr;
 	unsigned char *m;
 	int ret;
@@ -1614,10 +1565,8 @@ TEST_F(hmm, compound)
 
 	/* Skip test if we can't allocate a hugetlbfs page. */
 
-	default_hsize = file_read_ulong("/proc/meminfo", "Hugepagesize:");
-	if (default_hsize < 0 || default_hsize*1024 < default_hsize)
+	if (!default_hsize)
 		SKIP(return, "Huge page size could not be determined");
-	default_hsize = default_hsize*1024; /* KB to B */
 
 	size = ALIGN(TWOMEG, default_hsize);
 	npages = size >> self->page_shift;
@@ -2106,7 +2055,7 @@ TEST_F(hmm, migrate_anon_huge_empty)
 	int *ptr;
 	int ret;
 
-	size = TWOMEG;
+	size = read_pmd_pagesize();
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
@@ -2158,7 +2107,7 @@ TEST_F(hmm, migrate_anon_huge_zero)
 	int ret;
 	int val;
 
-	size = TWOMEG;
+	size = read_pmd_pagesize();
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
@@ -2221,7 +2170,7 @@ TEST_F(hmm, migrate_anon_huge_free)
 	int *ptr;
 	int ret;
 
-	size = TWOMEG;
+	size = read_pmd_pagesize();
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
@@ -2280,7 +2229,7 @@ TEST_F(hmm, migrate_anon_huge_fault)
 	int *ptr;
 	int ret;
 
-	size = TWOMEG;
+	size = read_pmd_pagesize();
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
@@ -2332,7 +2281,7 @@ TEST_F(hmm, migrate_partial_unmap_fault)
 {
 	struct hmm_buffer *buffer;
 	unsigned long npages;
-	unsigned long size = TWOMEG;
+	unsigned long size = read_pmd_pagesize();
 	unsigned long i;
 	void *old_ptr;
 	void *map;
@@ -2398,7 +2347,7 @@ TEST_F(hmm, migrate_remap_fault)
 {
 	struct hmm_buffer *buffer;
 	unsigned long npages;
-	unsigned long size = TWOMEG;
+	unsigned long size = read_pmd_pagesize();
 	unsigned long i;
 	void *old_ptr, *new_ptr = NULL;
 	void *map;
@@ -2498,7 +2447,7 @@ TEST_F(hmm, migrate_anon_huge_err)
 	int *ptr;
 	int ret;
 
-	size = TWOMEG;
+	size = read_pmd_pagesize();
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
@@ -2593,7 +2542,7 @@ TEST_F(hmm, migrate_anon_huge_zero_err)
 	int *ptr;
 	int ret;
 
-	size = TWOMEG;
+	size = read_pmd_pagesize();
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index 72dfbeaf56b9..e8031f68200a 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -414,6 +414,7 @@ vlmc_querier_intvl_test()
 	bridge vlan add vid 10 dev br1 self pvid untagged
 	ip link set dev $h1 master br1
 	ip link set dev br1 up
+	setup_wait_dev $h1 0
 	bridge vlan add vid 10 dev $h1 master
 	bridge vlan global set vid 10 dev br1 mcast_snooping 1 mcast_querier 1
 	sleep 2
diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 9430ef5b8bc3..1fe1338c79cd 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -344,7 +344,9 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
 		ret = send(fd, buf + nwritten, len - nwritten, flags);
 		timeout_check("send");
 
-		if (ret == 0 || (ret < 0 && errno != EINTR))
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret <= 0)
 			break;
 
 		nwritten += ret;
@@ -396,7 +398,9 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
 		ret = recv(fd, buf + nread, len - nread, flags);
 		timeout_check("recv");
 
-		if (ret == 0 || (ret < 0 && errno != EINTR))
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret <= 0)
 			break;
 
 		nread += ret;
diff --git a/virt/kvm/binary_stats.c b/virt/kvm/binary_stats.c
index eefca6c69f51..76ce697c773b 100644
--- a/virt/kvm/binary_stats.c
+++ b/virt/kvm/binary_stats.c
@@ -50,7 +50,7 @@
  * Return: the number of bytes that has been successfully read
  */
 ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
-		       const struct _kvm_stats_desc *desc,
+		       const struct kvm_stats_desc *desc,
 		       void *stats, size_t size_stats,
 		       char __user *user_buffer, size_t size, loff_t *offset)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5b5b69c97665..cf65fd82d36d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -983,9 +983,9 @@ static void kvm_free_memslots(struct kvm *kvm, struct kvm_memslots *slots)
 		kvm_free_memslot(kvm, memslot);
 }
 
-static umode_t kvm_stats_debugfs_mode(const struct _kvm_stats_desc *pdesc)
+static umode_t kvm_stats_debugfs_mode(const struct kvm_stats_desc *desc)
 {
-	switch (pdesc->desc.flags & KVM_STATS_TYPE_MASK) {
+	switch (desc->flags & KVM_STATS_TYPE_MASK) {
 	case KVM_STATS_TYPE_INSTANT:
 		return 0444;
 	case KVM_STATS_TYPE_CUMULATIVE:
@@ -1020,7 +1020,7 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, const char *fdname)
 	struct dentry *dent;
 	char dir_name[ITOA_MAX_LEN * 2];
 	struct kvm_stat_data *stat_data;
-	const struct _kvm_stats_desc *pdesc;
+	const struct kvm_stats_desc *pdesc;
 	int i, ret = -ENOMEM;
 	int kvm_debugfs_num_entries = kvm_vm_stats_header.num_desc +
 				      kvm_vcpu_stats_header.num_desc;
@@ -6186,11 +6186,11 @@ static int kvm_stat_data_get(void *data, u64 *val)
 	switch (stat_data->kind) {
 	case KVM_STAT_VM:
 		r = kvm_get_stat_per_vm(stat_data->kvm,
-					stat_data->desc->desc.offset, val);
+					stat_data->desc->offset, val);
 		break;
 	case KVM_STAT_VCPU:
 		r = kvm_get_stat_per_vcpu(stat_data->kvm,
-					  stat_data->desc->desc.offset, val);
+					  stat_data->desc->offset, val);
 		break;
 	}
 
@@ -6208,11 +6208,11 @@ static int kvm_stat_data_clear(void *data, u64 val)
 	switch (stat_data->kind) {
 	case KVM_STAT_VM:
 		r = kvm_clear_stat_per_vm(stat_data->kvm,
-					  stat_data->desc->desc.offset);
+					  stat_data->desc->offset);
 		break;
 	case KVM_STAT_VCPU:
 		r = kvm_clear_stat_per_vcpu(stat_data->kvm,
-					    stat_data->desc->desc.offset);
+					    stat_data->desc->offset);
 		break;
 	}
 
@@ -6360,7 +6360,7 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 static void kvm_init_debug(void)
 {
 	const struct file_operations *fops;
-	const struct _kvm_stats_desc *pdesc;
+	const struct kvm_stats_desc *pdesc;
 	int i;
 
 	kvm_debugfs_dir = debugfs_create_dir("kvm", NULL);
@@ -6373,7 +6373,7 @@ static void kvm_init_debug(void)
 			fops = &vm_stat_readonly_fops;
 		debugfs_create_file(pdesc->name, kvm_stats_debugfs_mode(pdesc),
 				kvm_debugfs_dir,
-				(void *)(long)pdesc->desc.offset, fops);
+				(void *)(long)pdesc->offset, fops);
 	}
 
 	for (i = 0; i < kvm_vcpu_stats_header.num_desc; ++i) {
@@ -6384,7 +6384,7 @@ static void kvm_init_debug(void)
 			fops = &vcpu_stat_readonly_fops;
 		debugfs_create_file(pdesc->name, kvm_stats_debugfs_mode(pdesc),
 				kvm_debugfs_dir,
-				(void *)(long)pdesc->desc.offset, fops);
+				(void *)(long)pdesc->offset, fops);
 	}
 }
 

