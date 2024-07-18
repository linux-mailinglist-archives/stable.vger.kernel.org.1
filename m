Return-Path: <stable+bounces-60547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A78D9934C7E
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 13:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE56E1C21E87
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 11:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A26813A405;
	Thu, 18 Jul 2024 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ty9vjTGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBEA136653;
	Thu, 18 Jul 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302052; cv=none; b=cA9f4tCmai6nDtAk3JIyjYSSkvIPg/WaZdVb0PvemP/JY500TJAezkd0TcX8u8qFhjtq/7iFg3g1XF8S/lEq+PSxnbuv1at9aUGbfffVlw3iWy5cfshmtkOe/Xq+gq5/9ucizoz2HcWQq8FjXXjGglKb3XgDXR8YtEYb8gUjgLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302052; c=relaxed/simple;
	bh=KajYZOFSGuElZM9jrxzrbMF1JIjPx8BFlZ4VFVxZqJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsccvfUnbkC6/S/d5SjsFAhzVaDE7ES9vInJseNLbcpC8155wFLmPMbKeA6AF4uPwl7w1wQtBpcTlaYyAnbrcTukYqJFbdfF43TbquKFH04IVCzCptRe3X+9rg+ZzBk3tzYVIu8Ns2uTJnWu149PL7m+rKvOwzF3RxLqjLF89x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ty9vjTGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2DCC4AF0B;
	Thu, 18 Jul 2024 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721302050;
	bh=KajYZOFSGuElZM9jrxzrbMF1JIjPx8BFlZ4VFVxZqJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ty9vjTGOUbR82FWiuINVw6+hQACOA2UdrMSunLHuo8hd80TC8LA0ZVC5URaIgPxg2
	 pwQSV9TQMy5xIpRhQBIwfbZ2+q1a/cRwZKkchYKRyJ0bK+U/cbiKXPSt0CBd3Edqzl
	 ic9+zVxi6lSnLES+agrK8ol5zxXqOOCUWOn9wiwY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.9.10
Date: Thu, 18 Jul 2024 13:27:22 +0200
Message-ID: <2024071822-coconut-rectify-73ef@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024071821-gestate-october-19ef@gregkh>
References: <2024071821-gestate-october-19ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/cifs/usage.rst b/Documentation/admin-guide/cifs/usage.rst
index aa8290a29dc8..fd4b56c0996f 100644
--- a/Documentation/admin-guide/cifs/usage.rst
+++ b/Documentation/admin-guide/cifs/usage.rst
@@ -723,40 +723,26 @@ Configuration pseudo-files:
 ======================= =======================================================
 SecurityFlags		Flags which control security negotiation and
 			also packet signing. Authentication (may/must)
-			flags (e.g. for NTLM and/or NTLMv2) may be combined with
+			flags (e.g. for NTLMv2) may be combined with
 			the signing flags.  Specifying two different password
 			hashing mechanisms (as "must use") on the other hand
 			does not make much sense. Default flags are::
 
-				0x07007
-
-			(NTLM, NTLMv2 and packet signing allowed).  The maximum
-			allowable flags if you want to allow mounts to servers
-			using weaker password hashes is 0x37037 (lanman,
-			plaintext, ntlm, ntlmv2, signing allowed).  Some
-			SecurityFlags require the corresponding menuconfig
-			options to be enabled.  Enabling plaintext
-			authentication currently requires also enabling
-			lanman authentication in the security flags
-			because the cifs module only supports sending
-			laintext passwords using the older lanman dialect
-			form of the session setup SMB.  (e.g. for authentication
-			using plain text passwords, set the SecurityFlags
-			to 0x30030)::
+				0x00C5
+
+			(NTLMv2 and packet signing allowed).  Some SecurityFlags
+			may require enabling a corresponding menuconfig option.
 
 			  may use packet signing			0x00001
 			  must use packet signing			0x01001
-			  may use NTLM (most common password hash)	0x00002
-			  must use NTLM					0x02002
 			  may use NTLMv2				0x00004
 			  must use NTLMv2				0x04004
-			  may use Kerberos security			0x00008
-			  must use Kerberos				0x08008
-			  may use lanman (weak) password hash		0x00010
-			  must use lanman password hash			0x10010
-			  may use plaintext passwords			0x00020
-			  must use plaintext passwords			0x20020
-			  (reserved for future packet encryption)	0x00040
+			  may use Kerberos security (krb5)		0x00008
+			  must use Kerberos                             0x08008
+			  may use NTLMSSP               		0x00080
+			  must use NTLMSSP           			0x80080
+			  seal (packet encryption)			0x00040
+			  must seal (not implemented yet)               0x40040
 
 cifsFYI			If set to non-zero value, additional debug information
 			will be logged to the system error log.  This field
diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
index 07ccbda4a0ab..b9a9f2cf32a1 100644
--- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
@@ -66,7 +66,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,qdu1000-llcc
               - qcom,sc7180-llcc
               - qcom,sm6350-llcc
     then:
@@ -104,6 +103,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,qdu1000-llcc
               - qcom,sc8180x-llcc
               - qcom,sc8280xp-llcc
               - qcom,x1e80100-llcc
diff --git a/Makefile b/Makefile
index cbe3a580ff48..5471f554f95e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 9
-SUBLEVEL = 9
+SUBLEVEL = 10
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
index 8aa39db095d7..2c5155bd376b 100644
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -61,7 +61,7 @@ static void davinci_pm_suspend(void)
 
 	/* Configure sleep count in deep sleep register */
 	val = __raw_readl(pm_config.deepsleep_reg);
-	val &= ~DEEPSLEEP_SLEEPCOUNT_MASK,
+	val &= ~DEEPSLEEP_SLEEPCOUNT_MASK;
 	val |= pm_config.sleepcount;
 	__raw_writel(val, pm_config.deepsleep_reg);
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
index b6e3c169797f..0dba41396377 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h64-remix-mini-pc.dts
@@ -191,7 +191,7 @@ axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		x-powers,drive-vbus-en;
 
 		vin1-supply = <&reg_vcc5v>;
diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index 832f472c4b7a..ceed9c4e8fcd 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -1459,9 +1459,23 @@ gem_noc: interconnect@19100000 {
 
 		system-cache-controller@19200000 {
 			compatible = "qcom,qdu1000-llcc";
-			reg = <0 0x19200000 0 0xd80000>,
+			reg = <0 0x19200000 0 0x80000>,
+			      <0 0x19300000 0 0x80000>,
+			      <0 0x19600000 0 0x80000>,
+			      <0 0x19700000 0 0x80000>,
+			      <0 0x19a00000 0 0x80000>,
+			      <0 0x19b00000 0 0x80000>,
+			      <0 0x19e00000 0 0x80000>,
+			      <0 0x19f00000 0 0x80000>,
 			      <0 0x1a200000 0 0x80000>;
 			reg-names = "llcc0_base",
+				    "llcc1_base",
+				    "llcc2_base",
+				    "llcc3_base",
+				    "llcc4_base",
+				    "llcc5_base",
+				    "llcc6_base",
+				    "llcc7_base",
 				    "llcc_broadcast_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 231cea1f0fa8..beb203964315 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -3605,7 +3605,7 @@ arch_timer: timer {
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	pcie0: pcie@1c00000 {
diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 053f7861c3ce..b594938c757b 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2608,11 +2608,14 @@ usb_sec_dpphy: dp-phy@88ef200 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sc8180x-llcc";
-			reg = <0 0x09200000 0 0x50000>, <0 0x09280000 0 0x50000>,
-			      <0 0x09300000 0 0x50000>, <0 0x09380000 0 0x50000>,
-			      <0 0x09600000 0 0x50000>;
+			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
+			      <0 0x09300000 0 0x58000>, <0 0x09380000 0 0x58000>,
+			      <0 0x09400000 0 0x58000>, <0 0x09480000 0 0x58000>,
+			      <0 0x09500000 0 0x58000>, <0 0x09580000 0 0x58000>,
+			      <0 0x09600000 0 0x58000>;
 			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
-				    "llcc3_base", "llcc_broadcast_base";
+				    "llcc3_base", "llcc4_base", "llcc5_base",
+				    "llcc6_base", "llcc7_base",  "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 15ae94c1602d..4ddca2ff7a11 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -618,15 +618,16 @@ &i2c4 {
 
 	status = "okay";
 
-	/* FIXME: verify */
 	touchscreen@10 {
-		compatible = "hid-over-i2c";
+		compatible = "elan,ekth5015m", "elan,ekth6915";
 		reg = <0x10>;
 
-		hid-descr-addr = <0x1>;
 		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
-		vdd-supply = <&vreg_misc_3p3>;
-		vddl-supply = <&vreg_s10b>;
+		reset-gpios = <&tlmm 99 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+		no-reset-on-power-off;
+
+		vcc33-supply = <&vreg_misc_3p3>;
+		vccio-supply = <&vreg_misc_3p3>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&ts0_default>;
@@ -1417,8 +1418,8 @@ int-n-pins {
 		reset-n-pins {
 			pins = "gpio99";
 			function = "gpio";
-			output-high;
-			drive-strength = <16>;
+			drive-strength = <2>;
+			bias-disable;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index aca0a87092e4..9ed062150aaf 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1090,6 +1090,7 @@ sdhc_1: mmc@4744000 {
 
 			power-domains = <&rpmpd SM6115_VDDCX>;
 			operating-points-v2 = <&sdhc1_opp_table>;
+			iommus = <&apps_smmu 0x00c0 0x0>;
 			interconnects = <&system_noc MASTER_SDCC_1 RPM_ALWAYS_TAG
 					 &bimc SLAVE_EBI_CH0 RPM_ALWAYS_TAG>,
 					<&bimc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 6a0a54532e5f..c5442396dcec 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -48,6 +48,15 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	reserved-memory {
+		linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x0 0x8000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+
 	sound {
 		compatible = "qcom,x1e80100-sndcard";
 		model = "X1E80100-CRD";
@@ -92,7 +101,7 @@ cpu {
 			};
 
 			codec {
-				sound-dai = <&wcd938x 1>, <&swr2 0>, <&lpass_txmacro 0>;
+				sound-dai = <&wcd938x 1>, <&swr2 1>, <&lpass_txmacro 0>;
 			};
 
 			platform {
@@ -727,7 +736,7 @@ &swr2 {
 	wcd_tx: codec@0,3 {
 		compatible = "sdw20217010d00";
 		reg = <0 3>;
-		qcom,tx-port-mapping = <1 1 2 3>;
+		qcom,tx-port-mapping = <2 2 3 4>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index e76d29053d79..49e19a64455b 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -22,6 +22,15 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	reserved-memory {
+		linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x0 0x8000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 6b40082bac68..ee78185ca538 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -2737,15 +2737,17 @@ pcie6a: pci@1bf8000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-x1e80100";
 			reg = <0 0x01bf8000 0 0x3000>,
-			      <0 0x70000000 0 0xf1d>,
-			      <0 0x70000f20 0 0xa8>,
+			      <0 0x70000000 0 0xf20>,
+			      <0 0x70000f40 0 0xa8>,
 			      <0 0x70001000 0 0x1000>,
-			      <0 0x70100000 0 0x100000>;
+			      <0 0x70100000 0 0x100000>,
+			      <0 0x01bfb000 0 0x1000>;
 			reg-names = "parf",
 				    "dbi",
 				    "elbi",
 				    "atu",
-				    "config";
+				    "config",
+				    "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0 0x00000000 0 0x70200000 0 0x100000>,
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index abb629d7e131..7e3e767ab87d 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -55,6 +55,8 @@ unsigned long *crst_table_alloc(struct mm_struct *mm)
 
 void crst_table_free(struct mm_struct *mm, unsigned long *table)
 {
+	if (!table)
+		return;
 	pagetable_free(virt_to_ptdesc(table));
 }
 
@@ -262,6 +264,8 @@ static unsigned long *base_crst_alloc(unsigned long val)
 
 static void base_crst_free(unsigned long *table)
 {
+	if (!table)
+		return;
 	pagetable_free(virt_to_ptdesc(table));
 }
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index c779046cc3fe..2e8ead609039 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -90,10 +90,6 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 
 	cld
 
-	IBRS_ENTER
-	UNTRAIN_RET
-	CLEAR_BRANCH_HISTORY
-
 	/*
 	 * SYSENTER doesn't filter flags, so we need to clear NT and AC
 	 * ourselves.  To save a few cycles, we can check whether
@@ -117,6 +113,16 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 	jnz	.Lsysenter_fix_flags
 .Lsysenter_flags_fixed:
 
+	/*
+	 * CPU bugs mitigations mechanisms can call other functions. They
+	 * should be invoked after making sure TF is cleared because
+	 * single-step is ignored only for instructions inside the
+	 * entry_SYSENTER_compat function.
+	 */
+	IBRS_ENTER
+	UNTRAIN_RET
+	CLEAR_BRANCH_HISTORY
+
 	movq	%rsp, %rdi
 	call	do_SYSENTER_32
 	jmp	sysret32_from_system_call
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index bd6a7857ce05..831fa4a12159 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -16,7 +16,6 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/sched.h>       /* need_resched() */
-#include <linux/sort.h>
 #include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
@@ -386,25 +385,24 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 	acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
 }
 
-static int acpi_cst_latency_cmp(const void *a, const void *b)
+static void acpi_cst_latency_sort(struct acpi_processor_cx *states, size_t length)
 {
-	const struct acpi_processor_cx *x = a, *y = b;
+	int i, j, k;
 
-	if (!(x->valid && y->valid))
-		return 0;
-	if (x->latency > y->latency)
-		return 1;
-	if (x->latency < y->latency)
-		return -1;
-	return 0;
-}
-static void acpi_cst_latency_swap(void *a, void *b, int n)
-{
-	struct acpi_processor_cx *x = a, *y = b;
+	for (i = 1; i < length; i++) {
+		if (!states[i].valid)
+			continue;
 
-	if (!(x->valid && y->valid))
-		return;
-	swap(x->latency, y->latency);
+		for (j = i - 1, k = i; j >= 0; j--) {
+			if (!states[j].valid)
+				continue;
+
+			if (states[j].latency > states[k].latency)
+				swap(states[j].latency, states[k].latency);
+
+			k = j;
+		}
+	}
 }
 
 static int acpi_processor_power_verify(struct acpi_processor *pr)
@@ -449,10 +447,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 
 	if (buggy_latency) {
 		pr_notice("FW issue: working around C-state latencies out of order\n");
-		sort(&pr->power.states[1], max_cstate,
-		     sizeof(struct acpi_processor_cx),
-		     acpi_cst_latency_cmp,
-		     acpi_cst_latency_swap);
+		acpi_cst_latency_sort(&pr->power.states[1], max_cstate);
 	}
 
 	lapic_timer_propagate_broadcast(pr);
diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index d51fc8321d41..da32e8ed0830 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -269,8 +269,13 @@ hpet_read(struct file *file, char __user *buf, size_t count, loff_t * ppos)
 	if (!devp->hd_ireqfreq)
 		return -EIO;
 
-	if (count < sizeof(unsigned long))
-		return -EINVAL;
+	if (in_compat_syscall()) {
+		if (count < sizeof(compat_ulong_t))
+			return -EINVAL;
+	} else {
+		if (count < sizeof(unsigned long))
+			return -EINVAL;
+	}
 
 	add_wait_queue(&devp->hd_waitqueue, &wait);
 
@@ -294,9 +299,16 @@ hpet_read(struct file *file, char __user *buf, size_t count, loff_t * ppos)
 		schedule();
 	}
 
-	retval = put_user(data, (unsigned long __user *)buf);
-	if (!retval)
-		retval = sizeof(unsigned long);
+	if (in_compat_syscall()) {
+		retval = put_user(data, (compat_ulong_t __user *)buf);
+		if (!retval)
+			retval = sizeof(compat_ulong_t);
+	} else {
+		retval = put_user(data, (unsigned long __user *)buf);
+		if (!retval)
+			retval = sizeof(unsigned long);
+	}
+
 out:
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&devp->hd_waitqueue, &wait);
@@ -651,12 +663,24 @@ struct compat_hpet_info {
 	unsigned short hi_timer;
 };
 
+/* 32-bit types would lead to different command codes which should be
+ * translated into 64-bit ones before passed to hpet_ioctl_common
+ */
+#define COMPAT_HPET_INFO       _IOR('h', 0x03, struct compat_hpet_info)
+#define COMPAT_HPET_IRQFREQ    _IOW('h', 0x6, compat_ulong_t)
+
 static long
 hpet_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct hpet_info info;
 	int err;
 
+	if (cmd == COMPAT_HPET_INFO)
+		cmd = HPET_INFO;
+
+	if (cmd == COMPAT_HPET_IRQFREQ)
+		cmd = HPET_IRQFREQ;
+
 	mutex_lock(&hpet_mutex);
 	err = hpet_ioctl_common(file->private_data, cmd, arg, &info);
 	mutex_unlock(&hpet_mutex);
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 37f1cdf46d29..4ac3a35dcd98 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -890,8 +890,10 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
 		pr_warn(FW_WARN "P-state 0 is not max freq\n");
 
-	if (acpi_cpufreq_driver.set_boost)
+	if (acpi_cpufreq_driver.set_boost) {
 		set_boost(policy, acpi_cpufreq_driver.boost_enabled);
+		policy->boost_enabled = acpi_cpufreq_driver.boost_enabled;
+	}
 
 	return result;
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fd9c3ed21f49..d7630d9cdb2f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1431,7 +1431,8 @@ static int cpufreq_online(unsigned int cpu)
 		}
 
 		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
+		if (cpufreq_boost_enabled() && policy_has_boost_freq(policy))
+			policy->boost_enabled = true;
 
 		/*
 		 * The initialization has succeeded and the policy is online.
diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 9f3d665cfdcf..a1da7581adb0 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1053,9 +1053,16 @@ struct cs_dsp_coeff_parsed_coeff {
 	int len;
 };
 
-static int cs_dsp_coeff_parse_string(int bytes, const u8 **pos, const u8 **str)
+static int cs_dsp_coeff_parse_string(int bytes, const u8 **pos, unsigned int avail,
+				     const u8 **str)
 {
-	int length;
+	int length, total_field_len;
+
+	/* String fields are at least one __le32 */
+	if (sizeof(__le32) > avail) {
+		*pos = NULL;
+		return 0;
+	}
 
 	switch (bytes) {
 	case 1:
@@ -1068,10 +1075,16 @@ static int cs_dsp_coeff_parse_string(int bytes, const u8 **pos, const u8 **str)
 		return 0;
 	}
 
+	total_field_len = ((length + bytes) + 3) & ~0x03;
+	if ((unsigned int)total_field_len > avail) {
+		*pos = NULL;
+		return 0;
+	}
+
 	if (str)
 		*str = *pos + bytes;
 
-	*pos += ((length + bytes) + 3) & ~0x03;
+	*pos += total_field_len;
 
 	return length;
 }
@@ -1096,71 +1109,134 @@ static int cs_dsp_coeff_parse_int(int bytes, const u8 **pos)
 	return val;
 }
 
-static inline void cs_dsp_coeff_parse_alg(struct cs_dsp *dsp, const u8 **data,
-					  struct cs_dsp_coeff_parsed_alg *blk)
+static int cs_dsp_coeff_parse_alg(struct cs_dsp *dsp,
+				  const struct wmfw_region *region,
+				  struct cs_dsp_coeff_parsed_alg *blk)
 {
 	const struct wmfw_adsp_alg_data *raw;
+	unsigned int data_len = le32_to_cpu(region->len);
+	unsigned int pos;
+	const u8 *tmp;
+
+	raw = (const struct wmfw_adsp_alg_data *)region->data;
 
 	switch (dsp->fw_ver) {
 	case 0:
 	case 1:
-		raw = (const struct wmfw_adsp_alg_data *)*data;
-		*data = raw->data;
+		if (sizeof(*raw) > data_len)
+			return -EOVERFLOW;
 
 		blk->id = le32_to_cpu(raw->id);
 		blk->name = raw->name;
-		blk->name_len = strlen(raw->name);
+		blk->name_len = strnlen(raw->name, ARRAY_SIZE(raw->name));
 		blk->ncoeff = le32_to_cpu(raw->ncoeff);
+
+		pos = sizeof(*raw);
 		break;
 	default:
-		blk->id = cs_dsp_coeff_parse_int(sizeof(raw->id), data);
-		blk->name_len = cs_dsp_coeff_parse_string(sizeof(u8), data,
+		if (sizeof(raw->id) > data_len)
+			return -EOVERFLOW;
+
+		tmp = region->data;
+		blk->id = cs_dsp_coeff_parse_int(sizeof(raw->id), &tmp);
+		pos = tmp - region->data;
+
+		tmp = &region->data[pos];
+		blk->name_len = cs_dsp_coeff_parse_string(sizeof(u8), &tmp, data_len - pos,
 							  &blk->name);
-		cs_dsp_coeff_parse_string(sizeof(u16), data, NULL);
-		blk->ncoeff = cs_dsp_coeff_parse_int(sizeof(raw->ncoeff), data);
+		if (!tmp)
+			return -EOVERFLOW;
+
+		pos = tmp - region->data;
+		cs_dsp_coeff_parse_string(sizeof(u16), &tmp, data_len - pos, NULL);
+		if (!tmp)
+			return -EOVERFLOW;
+
+		pos = tmp - region->data;
+		if (sizeof(raw->ncoeff) > (data_len - pos))
+			return -EOVERFLOW;
+
+		blk->ncoeff = cs_dsp_coeff_parse_int(sizeof(raw->ncoeff), &tmp);
+		pos += sizeof(raw->ncoeff);
 		break;
 	}
 
+	if ((int)blk->ncoeff < 0)
+		return -EOVERFLOW;
+
 	cs_dsp_dbg(dsp, "Algorithm ID: %#x\n", blk->id);
 	cs_dsp_dbg(dsp, "Algorithm name: %.*s\n", blk->name_len, blk->name);
 	cs_dsp_dbg(dsp, "# of coefficient descriptors: %#x\n", blk->ncoeff);
+
+	return pos;
 }
 
-static inline void cs_dsp_coeff_parse_coeff(struct cs_dsp *dsp, const u8 **data,
-					    struct cs_dsp_coeff_parsed_coeff *blk)
+static int cs_dsp_coeff_parse_coeff(struct cs_dsp *dsp,
+				    const struct wmfw_region *region,
+				    unsigned int pos,
+				    struct cs_dsp_coeff_parsed_coeff *blk)
 {
 	const struct wmfw_adsp_coeff_data *raw;
+	unsigned int data_len = le32_to_cpu(region->len);
+	unsigned int blk_len, blk_end_pos;
 	const u8 *tmp;
-	int length;
+
+	raw = (const struct wmfw_adsp_coeff_data *)&region->data[pos];
+	if (sizeof(raw->hdr) > (data_len - pos))
+		return -EOVERFLOW;
+
+	blk_len = le32_to_cpu(raw->hdr.size);
+	if (blk_len > S32_MAX)
+		return -EOVERFLOW;
+
+	if (blk_len > (data_len - pos - sizeof(raw->hdr)))
+		return -EOVERFLOW;
+
+	blk_end_pos = pos + sizeof(raw->hdr) + blk_len;
+
+	blk->offset = le16_to_cpu(raw->hdr.offset);
+	blk->mem_type = le16_to_cpu(raw->hdr.type);
 
 	switch (dsp->fw_ver) {
 	case 0:
 	case 1:
-		raw = (const struct wmfw_adsp_coeff_data *)*data;
-		*data = *data + sizeof(raw->hdr) + le32_to_cpu(raw->hdr.size);
+		if (sizeof(*raw) > (data_len - pos))
+			return -EOVERFLOW;
 
-		blk->offset = le16_to_cpu(raw->hdr.offset);
-		blk->mem_type = le16_to_cpu(raw->hdr.type);
 		blk->name = raw->name;
-		blk->name_len = strlen(raw->name);
+		blk->name_len = strnlen(raw->name, ARRAY_SIZE(raw->name));
 		blk->ctl_type = le16_to_cpu(raw->ctl_type);
 		blk->flags = le16_to_cpu(raw->flags);
 		blk->len = le32_to_cpu(raw->len);
 		break;
 	default:
-		tmp = *data;
-		blk->offset = cs_dsp_coeff_parse_int(sizeof(raw->hdr.offset), &tmp);
-		blk->mem_type = cs_dsp_coeff_parse_int(sizeof(raw->hdr.type), &tmp);
-		length = cs_dsp_coeff_parse_int(sizeof(raw->hdr.size), &tmp);
-		blk->name_len = cs_dsp_coeff_parse_string(sizeof(u8), &tmp,
+		pos += sizeof(raw->hdr);
+		tmp = &region->data[pos];
+		blk->name_len = cs_dsp_coeff_parse_string(sizeof(u8), &tmp, data_len - pos,
 							  &blk->name);
-		cs_dsp_coeff_parse_string(sizeof(u8), &tmp, NULL);
-		cs_dsp_coeff_parse_string(sizeof(u16), &tmp, NULL);
+		if (!tmp)
+			return -EOVERFLOW;
+
+		pos = tmp - region->data;
+		cs_dsp_coeff_parse_string(sizeof(u8), &tmp, data_len - pos, NULL);
+		if (!tmp)
+			return -EOVERFLOW;
+
+		pos = tmp - region->data;
+		cs_dsp_coeff_parse_string(sizeof(u16), &tmp, data_len - pos, NULL);
+		if (!tmp)
+			return -EOVERFLOW;
+
+		pos = tmp - region->data;
+		if (sizeof(raw->ctl_type) + sizeof(raw->flags) + sizeof(raw->len) >
+		    (data_len - pos))
+			return -EOVERFLOW;
+
 		blk->ctl_type = cs_dsp_coeff_parse_int(sizeof(raw->ctl_type), &tmp);
+		pos += sizeof(raw->ctl_type);
 		blk->flags = cs_dsp_coeff_parse_int(sizeof(raw->flags), &tmp);
+		pos += sizeof(raw->flags);
 		blk->len = cs_dsp_coeff_parse_int(sizeof(raw->len), &tmp);
-
-		*data = *data + sizeof(raw->hdr) + length;
 		break;
 	}
 
@@ -1170,6 +1246,8 @@ static inline void cs_dsp_coeff_parse_coeff(struct cs_dsp *dsp, const u8 **data,
 	cs_dsp_dbg(dsp, "\tCoefficient flags: %#x\n", blk->flags);
 	cs_dsp_dbg(dsp, "\tALSA control type: %#x\n", blk->ctl_type);
 	cs_dsp_dbg(dsp, "\tALSA control len: %#x\n", blk->len);
+
+	return blk_end_pos;
 }
 
 static int cs_dsp_check_coeff_flags(struct cs_dsp *dsp,
@@ -1193,12 +1271,16 @@ static int cs_dsp_parse_coeff(struct cs_dsp *dsp,
 	struct cs_dsp_alg_region alg_region = {};
 	struct cs_dsp_coeff_parsed_alg alg_blk;
 	struct cs_dsp_coeff_parsed_coeff coeff_blk;
-	const u8 *data = region->data;
-	int i, ret;
+	int i, pos, ret;
+
+	pos = cs_dsp_coeff_parse_alg(dsp, region, &alg_blk);
+	if (pos < 0)
+		return pos;
 
-	cs_dsp_coeff_parse_alg(dsp, &data, &alg_blk);
 	for (i = 0; i < alg_blk.ncoeff; i++) {
-		cs_dsp_coeff_parse_coeff(dsp, &data, &coeff_blk);
+		pos = cs_dsp_coeff_parse_coeff(dsp, region, pos, &coeff_blk);
+		if (pos < 0)
+			return pos;
 
 		switch (coeff_blk.ctl_type) {
 		case WMFW_CTL_TYPE_BYTES:
@@ -1267,6 +1349,10 @@ static unsigned int cs_dsp_adsp1_parse_sizes(struct cs_dsp *dsp,
 	const struct wmfw_adsp1_sizes *adsp1_sizes;
 
 	adsp1_sizes = (void *)&firmware->data[pos];
+	if (sizeof(*adsp1_sizes) > firmware->size - pos) {
+		cs_dsp_err(dsp, "%s: file truncated\n", file);
+		return 0;
+	}
 
 	cs_dsp_dbg(dsp, "%s: %d DM, %d PM, %d ZM\n", file,
 		   le32_to_cpu(adsp1_sizes->dm), le32_to_cpu(adsp1_sizes->pm),
@@ -1283,6 +1369,10 @@ static unsigned int cs_dsp_adsp2_parse_sizes(struct cs_dsp *dsp,
 	const struct wmfw_adsp2_sizes *adsp2_sizes;
 
 	adsp2_sizes = (void *)&firmware->data[pos];
+	if (sizeof(*adsp2_sizes) > firmware->size - pos) {
+		cs_dsp_err(dsp, "%s: file truncated\n", file);
+		return 0;
+	}
 
 	cs_dsp_dbg(dsp, "%s: %d XM, %d YM %d PM, %d ZM\n", file,
 		   le32_to_cpu(adsp2_sizes->xm), le32_to_cpu(adsp2_sizes->ym),
@@ -1322,7 +1412,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 	struct regmap *regmap = dsp->regmap;
 	unsigned int pos = 0;
 	const struct wmfw_header *header;
-	const struct wmfw_adsp1_sizes *adsp1_sizes;
 	const struct wmfw_footer *footer;
 	const struct wmfw_region *region;
 	const struct cs_dsp_region *mem;
@@ -1338,10 +1427,8 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 
 	ret = -EINVAL;
 
-	pos = sizeof(*header) + sizeof(*adsp1_sizes) + sizeof(*footer);
-	if (pos >= firmware->size) {
-		cs_dsp_err(dsp, "%s: file too short, %zu bytes\n",
-			   file, firmware->size);
+	if (sizeof(*header) >= firmware->size) {
+		ret = -EOVERFLOW;
 		goto out_fw;
 	}
 
@@ -1369,22 +1456,36 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 
 	pos = sizeof(*header);
 	pos = dsp->ops->parse_sizes(dsp, file, pos, firmware);
+	if ((pos == 0) || (sizeof(*footer) > firmware->size - pos)) {
+		ret = -EOVERFLOW;
+		goto out_fw;
+	}
 
 	footer = (void *)&firmware->data[pos];
 	pos += sizeof(*footer);
 
 	if (le32_to_cpu(header->len) != pos) {
-		cs_dsp_err(dsp, "%s: unexpected header length %d\n",
-			   file, le32_to_cpu(header->len));
+		ret = -EOVERFLOW;
 		goto out_fw;
 	}
 
 	cs_dsp_dbg(dsp, "%s: timestamp %llu\n", file,
 		   le64_to_cpu(footer->timestamp));
 
-	while (pos < firmware->size &&
-	       sizeof(*region) < firmware->size - pos) {
+	while (pos < firmware->size) {
+		/* Is there enough data for a complete block header? */
+		if (sizeof(*region) > firmware->size - pos) {
+			ret = -EOVERFLOW;
+			goto out_fw;
+		}
+
 		region = (void *)&(firmware->data[pos]);
+
+		if (le32_to_cpu(region->len) > firmware->size - pos - sizeof(*region)) {
+			ret = -EOVERFLOW;
+			goto out_fw;
+		}
+
 		region_name = "Unknown";
 		reg = 0;
 		text = NULL;
@@ -1441,16 +1542,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 			   regions, le32_to_cpu(region->len), offset,
 			   region_name);
 
-		if (le32_to_cpu(region->len) >
-		    firmware->size - pos - sizeof(*region)) {
-			cs_dsp_err(dsp,
-				   "%s.%d: %s region len %d bytes exceeds file length %zu\n",
-				   file, regions, region_name,
-				   le32_to_cpu(region->len), firmware->size);
-			ret = -EINVAL;
-			goto out_fw;
-		}
-
 		if (text) {
 			memcpy(text, region->data, le32_to_cpu(region->len));
 			cs_dsp_info(dsp, "%s: %s\n", file, text);
@@ -1501,6 +1592,9 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 	cs_dsp_buf_free(&buf_list);
 	kfree(text);
 
+	if (ret == -EOVERFLOW)
+		cs_dsp_err(dsp, "%s: file content overflows file data\n", file);
+
 	return ret;
 }
 
@@ -2068,10 +2162,20 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 	pos = le32_to_cpu(hdr->len);
 
 	blocks = 0;
-	while (pos < firmware->size &&
-	       sizeof(*blk) < firmware->size - pos) {
+	while (pos < firmware->size) {
+		/* Is there enough data for a complete block header? */
+		if (sizeof(*blk) > firmware->size - pos) {
+			ret = -EOVERFLOW;
+			goto out_fw;
+		}
+
 		blk = (void *)(&firmware->data[pos]);
 
+		if (le32_to_cpu(blk->len) > firmware->size - pos - sizeof(*blk)) {
+			ret = -EOVERFLOW;
+			goto out_fw;
+		}
+
 		type = le16_to_cpu(blk->type);
 		offset = le16_to_cpu(blk->offset);
 		version = le32_to_cpu(blk->ver) >> 8;
@@ -2168,17 +2272,6 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 		}
 
 		if (reg) {
-			if (le32_to_cpu(blk->len) >
-			    firmware->size - pos - sizeof(*blk)) {
-				cs_dsp_err(dsp,
-					   "%s.%d: %s region len %d bytes exceeds file length %zu\n",
-					   file, blocks, region_name,
-					   le32_to_cpu(blk->len),
-					   firmware->size);
-				ret = -EINVAL;
-				goto out_fw;
-			}
-
 			buf = cs_dsp_buf_alloc(blk->data,
 					       le32_to_cpu(blk->len),
 					       &buf_list);
@@ -2218,6 +2311,10 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 	regmap_async_complete(regmap);
 	cs_dsp_buf_free(&buf_list);
 	kfree(text);
+
+	if (ret == -EOVERFLOW)
+		cs_dsp_err(dsp, "%s: file content overflows file data\n", file);
+
 	return ret;
 }
 
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 828aa2ea0fe4..185a5d60f101 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -257,6 +257,14 @@ static void rcar_i2c_init(struct rcar_i2c_priv *priv)
 	}
 }
 
+static void rcar_i2c_reset_slave(struct rcar_i2c_priv *priv)
+{
+	rcar_i2c_write(priv, ICSIER, 0);
+	rcar_i2c_write(priv, ICSSR, 0);
+	rcar_i2c_write(priv, ICSCR, SDBS);
+	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
+}
+
 static int rcar_i2c_bus_barrier(struct rcar_i2c_priv *priv)
 {
 	int ret;
@@ -875,6 +883,10 @@ static int rcar_i2c_do_reset(struct rcar_i2c_priv *priv)
 {
 	int ret;
 
+	/* Don't reset if a slave instance is currently running */
+	if (priv->slave)
+		return -EISCONN;
+
 	ret = reset_control_reset(priv->rstc);
 	if (ret)
 		return ret;
@@ -903,10 +915,10 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 	/* Gen3+ needs a reset. That also allows RXDMA once */
 	if (priv->devtype >= I2C_RCAR_GEN3) {
-		priv->flags &= ~ID_P_NO_RXDMA;
 		ret = rcar_i2c_do_reset(priv);
 		if (ret)
 			goto out;
+		priv->flags &= ~ID_P_NO_RXDMA;
 	}
 
 	rcar_i2c_init(priv);
@@ -1033,11 +1045,8 @@ static int rcar_unreg_slave(struct i2c_client *slave)
 
 	/* ensure no irq is running before clearing ptr */
 	disable_irq(priv->irq);
-	rcar_i2c_write(priv, ICSIER, 0);
-	rcar_i2c_write(priv, ICSSR, 0);
+	rcar_i2c_reset_slave(priv);
 	enable_irq(priv->irq);
-	rcar_i2c_write(priv, ICSCR, SDBS);
-	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
 
 	priv->slave = NULL;
 
@@ -1152,7 +1161,9 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 		goto out_pm_disable;
 	}
 
-	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
+	/* Bring hardware to known state */
+	rcar_i2c_init(priv);
+	rcar_i2c_reset_slave(priv);
 
 	if (priv->devtype < I2C_RCAR_GEN3) {
 		irqflags |= IRQF_NO_THREAD;
@@ -1168,6 +1179,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	if (of_property_read_bool(dev->of_node, "smbus"))
 		priv->flags |= ID_P_HOST_NOTIFY;
 
+	/* R-Car Gen3+ needs a reset before every transfer */
 	if (priv->devtype >= I2C_RCAR_GEN3) {
 		priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 		if (IS_ERR(priv->rstc)) {
@@ -1178,6 +1190,9 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 		ret = reset_control_status(priv->rstc);
 		if (ret < 0)
 			goto out_pm_put;
+
+		/* hard reset disturbs HostNotify local target, so disable it */
+		priv->flags &= ~ID_P_HOST_NOTIFY;
 	}
 
 	ret = platform_get_irq(pdev, 0);
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index db0d1ac82910..7e7b15440832 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1067,6 +1067,7 @@ EXPORT_SYMBOL(i2c_find_device_by_fwnode);
 
 static const struct i2c_device_id dummy_id[] = {
 	{ "dummy", 0 },
+	{ "smbus_host_notify", 0 },
 	{ },
 };
 
diff --git a/drivers/i2c/i2c-slave-testunit.c b/drivers/i2c/i2c-slave-testunit.c
index ca43e98cae1b..23a11e4e9256 100644
--- a/drivers/i2c/i2c-slave-testunit.c
+++ b/drivers/i2c/i2c-slave-testunit.c
@@ -118,6 +118,13 @@ static int i2c_slave_testunit_slave_cb(struct i2c_client *client,
 			queue_delayed_work(system_long_wq, &tu->worker,
 					   msecs_to_jiffies(10 * tu->regs[TU_REG_DELAY]));
 		}
+
+		/*
+		 * Reset reg_idx to avoid that work gets queued again in case of
+		 * STOP after a following read message. But do not clear TU regs
+		 * here because we still need them in the workqueue!
+		 */
+		tu->reg_idx = 0;
 		break;
 
 	case I2C_SLAVE_WRITE_REQUESTED:
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 18f83158f637..b5fed8a000ea 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -322,7 +322,7 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	 * this is the case if the IIO device and the trigger device share the
 	 * same parent device.
 	 */
-	if (iio_validate_own_trigger(pf->indio_dev, trig))
+	if (!iio_validate_own_trigger(pf->indio_dev, trig))
 		trig->attached_own_device = true;
 
 	return ret;
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4c67e2c5a82e..a7a2bcedb37e 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1238,6 +1238,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	struct fastrpc_phy_page pages[1];
 	char *name;
 	int err;
+	bool scm_done = false;
 	struct {
 		int pgid;
 		u32 namelen;
@@ -1289,6 +1290,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
 				goto err_map;
 			}
+			scm_done = true;
 		}
 	}
 
@@ -1320,10 +1322,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		goto err_invoke;
 
 	kfree(args);
+	kfree(name);
 
 	return 0;
 err_invoke:
-	if (fl->cctx->vmcount) {
+	if (fl->cctx->vmcount && scm_done) {
 		u64 src_perms = 0;
 		struct qcom_scm_vmperm dst_perms;
 		u32 i;
@@ -1693,16 +1696,20 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
 {
 	struct fastrpc_invoke_args args[2] = { 0 };
 
-	/* Capability filled in userspace */
+	/*
+	 * Capability filled in userspace. This carries the information
+	 * about the remoteproc support which is fetched from the remoteproc
+	 * sysfs node by userspace.
+	 */
 	dsp_attr_buf[0] = 0;
+	dsp_attr_buf_len -= 1;
 
 	args[0].ptr = (u64)(uintptr_t)&dsp_attr_buf_len;
 	args[0].length = sizeof(dsp_attr_buf_len);
 	args[0].fd = -1;
 	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];
-	args[1].length = dsp_attr_buf_len;
+	args[1].length = dsp_attr_buf_len * sizeof(u32);
 	args[1].fd = -1;
-	fl->pd = USER_PD;
 
 	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
 				       FASTRPC_SCALARS(0, 1, 1), args);
@@ -1730,7 +1737,7 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
 	if (!dsp_attributes)
 		return -ENOMEM;
 
-	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES_LEN);
+	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES);
 	if (err == DSP_UNSUPPORTED_API) {
 		dev_info(&cctx->rpdev->dev,
 			 "Warning: DSP capabilities not supported on domain: %d\n", domain);
@@ -1783,7 +1790,7 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
 	if (err)
 		return err;
 
-	if (copy_to_user(argp, &cap.capability, sizeof(cap.capability)))
+	if (copy_to_user(argp, &cap, sizeof(cap)))
 		return -EFAULT;
 
 	return 0;
@@ -2080,6 +2087,16 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	return err;
 }
 
+static int is_attach_rejected(struct fastrpc_user *fl)
+{
+	/* Check if the device node is non-secure */
+	if (!fl->is_secure_dev) {
+		dev_dbg(&fl->cctx->rpdev->dev, "untrusted app trying to attach to privileged DSP PD\n");
+		return -EACCES;
+	}
+	return 0;
+}
+
 static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 				 unsigned long arg)
 {
@@ -2092,13 +2109,19 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 		err = fastrpc_invoke(fl, argp);
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH:
-		err = fastrpc_init_attach(fl, ROOT_PD);
+		err = is_attach_rejected(fl);
+		if (!err)
+			err = fastrpc_init_attach(fl, ROOT_PD);
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
-		err = fastrpc_init_attach(fl, SENSORS_PD);
+		err = is_attach_rejected(fl);
+		if (!err)
+			err = fastrpc_init_attach(fl, SENSORS_PD);
 		break;
 	case FASTRPC_IOCTL_INIT_CREATE_STATIC:
-		err = fastrpc_init_create_static_process(fl, argp);
+		err = is_attach_rejected(fl);
+		if (!err)
+			err = fastrpc_init_create_static_process(fl, argp);
 		break;
 	case FASTRPC_IOCTL_INIT_CREATE:
 		err = fastrpc_init_create_process(fl, argp);
diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
index 16695cb5e69c..7c3d8bedf90b 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
@@ -153,7 +153,6 @@ static int pci1xxxx_eeprom_read(void *priv_t, unsigned int off,
 
 		buf[byte] = readl(rb + MMAP_EEPROM_OFFSET(EEPROM_DATA_REG));
 	}
-	ret = byte;
 error:
 	release_sys_lock(priv);
 	return ret;
@@ -197,7 +196,6 @@ static int pci1xxxx_eeprom_write(void *priv_t, unsigned int off,
 			goto error;
 		}
 	}
-	ret = byte;
 error:
 	release_sys_lock(priv);
 	return ret;
@@ -258,7 +256,6 @@ static int pci1xxxx_otp_read(void *priv_t, unsigned int off,
 
 		buf[byte] = readl(rb + MMAP_OTP_OFFSET(OTP_RD_DATA_OFFSET));
 	}
-	ret = byte;
 error:
 	release_sys_lock(priv);
 	return ret;
@@ -315,7 +312,6 @@ static int pci1xxxx_otp_write(void *priv_t, unsigned int off,
 			goto error;
 		}
 	}
-	ret = byte;
 error:
 	release_sys_lock(priv);
 	return ret;
diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-vsc.c
index 1ec65d87488a..d02f6e881139 100644
--- a/drivers/misc/mei/platform-vsc.c
+++ b/drivers/misc/mei/platform-vsc.c
@@ -28,8 +28,8 @@
 
 #define MEI_VSC_MAX_MSG_SIZE		512
 
-#define MEI_VSC_POLL_DELAY_US		(50 * USEC_PER_MSEC)
-#define MEI_VSC_POLL_TIMEOUT_US		(200 * USEC_PER_MSEC)
+#define MEI_VSC_POLL_DELAY_US		(100 * USEC_PER_MSEC)
+#define MEI_VSC_POLL_TIMEOUT_US		(400 * USEC_PER_MSEC)
 
 #define mei_dev_to_vsc_hw(dev)		((struct mei_vsc_hw *)((dev)->hw))
 
diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index e6a98dba8a73..876330474444 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -336,7 +336,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
 		return ret;
 
 	if (ibuf)
-		cpu_to_be32_array(ibuf, tp->rx_buf, words);
+		be32_to_cpu_array(ibuf, tp->rx_buf, words);
 
 	return ret;
 }
@@ -568,6 +568,19 @@ static void vsc_tp_remove(struct spi_device *spi)
 	free_irq(spi->irq, tp);
 }
 
+static void vsc_tp_shutdown(struct spi_device *spi)
+{
+	struct vsc_tp *tp = spi_get_drvdata(spi);
+
+	platform_device_unregister(tp->pdev);
+
+	mutex_destroy(&tp->mutex);
+
+	vsc_tp_reset(tp);
+
+	free_irq(spi->irq, tp);
+}
+
 static const struct acpi_device_id vsc_tp_acpi_ids[] = {
 	{ "INTC1009" }, /* Raptor Lake */
 	{ "INTC1058" }, /* Tiger Lake */
@@ -580,6 +593,7 @@ MODULE_DEVICE_TABLE(acpi, vsc_tp_acpi_ids);
 static struct spi_driver vsc_tp_driver = {
 	.probe = vsc_tp_probe,
 	.remove = vsc_tp_remove,
+	.shutdown = vsc_tp_shutdown,
 	.driver = {
 		.name = "vsc-tp",
 		.acpi_match_table = vsc_tp_acpi_ids,
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index d7427894e0bc..c302eb380e42 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -224,6 +224,9 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 	}
 	p = sgm->addr;
 
+	if (n > sgm->length)
+		n = sgm->length;
+
 	/* NOTE:  we never transfer more than rw_threshold bytes
 	 * to/from the fifo here; there's no I/O overlap.
 	 * This also assumes that access width( i.e. ACCWD) is 4 bytes
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 112584aa0772..fbf7a91bed35 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4727,6 +4727,21 @@ int sdhci_setup_host(struct sdhci_host *host)
 		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) {
 			host->max_adma = 65532; /* 32-bit alignment */
 			mmc->max_seg_size = 65535;
+			/*
+			 * sdhci_adma_table_pre() expects to define 1 DMA
+			 * descriptor per segment, so the maximum segment size
+			 * is set accordingly. SDHCI allows up to 64KiB per DMA
+			 * descriptor (16-bit field), but some controllers do
+			 * not support "zero means 65536" reducing the maximum
+			 * for them to 65535. That is a problem if PAGE_SIZE is
+			 * 64KiB because the block layer does not support
+			 * max_seg_size < PAGE_SIZE, however
+			 * sdhci_adma_table_pre() has a workaround to handle
+			 * that case, and split the descriptor. Refer also
+			 * comment in sdhci_adma_table_pre().
+			 */
+			if (mmc->max_seg_size < PAGE_SIZE)
+				mmc->max_seg_size = PAGE_SIZE;
 		} else {
 			mmc->max_seg_size = 65536;
 		}
diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index fcb20eac332a..b47841e67e98 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1048,31 +1048,31 @@ static int lan9303_get_sset_count(struct dsa_switch *ds, int port, int sset)
 	return ARRAY_SIZE(lan9303_mib);
 }
 
-static int lan9303_phy_read(struct dsa_switch *ds, int phy, int regnum)
+static int lan9303_phy_read(struct dsa_switch *ds, int port, int regnum)
 {
 	struct lan9303 *chip = ds->priv;
 	int phy_base = chip->phy_addr_base;
 
-	if (phy == phy_base)
+	if (port == 0)
 		return lan9303_virt_phy_reg_read(chip, regnum);
-	if (phy > phy_base + 2)
+	if (port > 2)
 		return -ENODEV;
 
-	return chip->ops->phy_read(chip, phy, regnum);
+	return chip->ops->phy_read(chip, phy_base + port, regnum);
 }
 
-static int lan9303_phy_write(struct dsa_switch *ds, int phy, int regnum,
+static int lan9303_phy_write(struct dsa_switch *ds, int port, int regnum,
 			     u16 val)
 {
 	struct lan9303 *chip = ds->priv;
 	int phy_base = chip->phy_addr_base;
 
-	if (phy == phy_base)
+	if (port == 0)
 		return lan9303_virt_phy_reg_write(chip, regnum, val);
-	if (phy > phy_base + 2)
+	if (port > 2)
 		return -ENODEV;
 
-	return chip->ops->phy_write(chip, phy, regnum, val);
+	return chip->ops->phy_write(chip, phy_base + port, regnum, val);
 }
 
 static int lan9303_port_enable(struct dsa_switch *ds, int port,
@@ -1100,7 +1100,7 @@ static void lan9303_port_disable(struct dsa_switch *ds, int port)
 	vlan_vid_del(dsa_port_to_conduit(dp), htons(ETH_P_8021Q), port);
 
 	lan9303_disable_processing_port(chip, port);
-	lan9303_phy_write(ds, chip->phy_addr_base + port, MII_BMCR, BMCR_PDOWN);
+	lan9303_phy_write(ds, port, MII_BMCR, BMCR_PDOWN);
 }
 
 static int lan9303_port_bridge_join(struct dsa_switch *ds, int port,
@@ -1355,8 +1355,6 @@ static const struct dsa_switch_ops lan9303_switch_ops = {
 
 static int lan9303_register_switch(struct lan9303 *chip)
 {
-	int base;
-
 	chip->ds = devm_kzalloc(chip->dev, sizeof(*chip->ds), GFP_KERNEL);
 	if (!chip->ds)
 		return -ENOMEM;
@@ -1365,8 +1363,7 @@ static int lan9303_register_switch(struct lan9303 *chip)
 	chip->ds->num_ports = LAN9303_NUM_PORTS;
 	chip->ds->priv = chip;
 	chip->ds->ops = &lan9303_switch_ops;
-	base = chip->phy_addr_base;
-	chip->ds->phys_mii_mask = GENMASK(LAN9303_NUM_PORTS - 1 + base, base);
+	chip->ds->phys_mii_mask = GENMASK(LAN9303_NUM_PORTS - 1, 0);
 
 	return dsa_register_switch(chip->ds);
 }
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index a806dadc4196..20c6529ec135 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1380,6 +1380,7 @@ static int bcmasp_probe(struct platform_device *pdev)
 			dev_err(dev, "Cannot create eth interface %d\n", i);
 			bcmasp_remove_intfs(priv);
 			of_node_put(intf_node);
+			ret = -ENOMEM;
 			goto of_put_exit;
 		}
 		list_add_tail(&intf->list, &priv->intfs);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index ee86d2c53079..55b5bb884d73 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -109,10 +109,6 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
 		-EFBIG,      /* I40E_AQ_RC_EFBIG */
 	};
 
-	/* aq_rc is invalid if AQ timed out */
-	if (aq_ret == -EIO)
-		return -EAGAIN;
-
 	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
 		return -ERANGE;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ffb9f9f15c52..3a2d4d069795 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13264,6 +13264,10 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
 	bool need_reset;
 	int i;
 
+	/* VSI shall be deleted in a moment, block loading new programs */
+	if (prog && test_bit(__I40E_IN_REMOVE, pf->state))
+		return -EINVAL;
+
 	/* Don't allow frames that span over multiple buffers */
 	if (vsi->netdev->mtu > frame_size - I40E_PACKET_HDR_PAD) {
 		NL_SET_ERR_MSG_MOD(extack, "MTU too large for linear frames and XDP prog does not support frags");
@@ -13272,14 +13276,9 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
 
 	/* When turning XDP on->off/off->on we reset and rebuild the rings. */
 	need_reset = (i40e_enabled_xdp_vsi(vsi) != !!prog);
-
 	if (need_reset)
 		i40e_prep_for_reset(pf);
 
-	/* VSI shall be deleted in a moment, just return EINVAL */
-	if (test_bit(__I40E_IN_REMOVE, pf->state))
-		return -EINVAL;
-
 	old_prog = xchg(&vsi->xdp_prog, prog);
 
 	if (need_reset) {
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 1d5b7bb6380f..8a810e69cb33 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -217,9 +217,9 @@ ltq_etop_free_channel(struct net_device *dev, struct ltq_etop_chan *ch)
 	if (ch->dma.irq)
 		free_irq(ch->dma.irq, priv);
 	if (IS_RX(ch->idx)) {
-		int desc;
+		struct ltq_dma_channel *dma = &ch->dma;
 
-		for (desc = 0; desc < LTQ_DESC_NUM; desc++)
+		for (dma->desc = 0; dma->desc < LTQ_DESC_NUM; dma->desc++)
 			dev_kfree_skb_any(ch->skb[ch->dma.desc]);
 	}
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index eb2a20b5a0d0..f92dfc65a0ff 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1746,7 +1746,7 @@ struct cpt_lf_alloc_req_msg {
 	u16 nix_pf_func;
 	u16 sso_pf_func;
 	u16 eng_grpmsk;
-	int blkaddr;
+	u8 blkaddr;
 	u8 ctx_ilen_valid : 1;
 	u8 ctx_ilen : 7;
 };
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index d883157393ea..6c3aca6f278d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -63,8 +63,13 @@ enum npc_kpu_lb_ltype {
 	NPC_LT_LB_CUSTOM1 = 0xF,
 };
 
+/* Don't modify ltypes up to IP6_EXT, otherwise length and checksum of IP
+ * headers may not be checked correctly. IPv4 ltypes and IPv6 ltypes must
+ * differ only at bit 0 so mask 0xE can be used to detect extended headers.
+ */
 enum npc_kpu_lc_ltype {
-	NPC_LT_LC_IP = 1,
+	NPC_LT_LC_PTP = 1,
+	NPC_LT_LC_IP,
 	NPC_LT_LC_IP_OPT,
 	NPC_LT_LC_IP6,
 	NPC_LT_LC_IP6_EXT,
@@ -72,7 +77,6 @@ enum npc_kpu_lc_ltype {
 	NPC_LT_LC_RARP,
 	NPC_LT_LC_MPLS,
 	NPC_LT_LC_NSH,
-	NPC_LT_LC_PTP,
 	NPC_LT_LC_FCOE,
 	NPC_LT_LC_NGIO,
 	NPC_LT_LC_CUSTOM0 = 0xE,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ff78251f92d4..5f661e67ccbc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1643,7 +1643,7 @@ static int rvu_check_rsrc_availability(struct rvu *rvu,
 		if (req->ssow > block->lf.max) {
 			dev_err(&rvu->pdev->dev,
 				"Func 0x%x: Invalid SSOW req, %d > max %d\n",
-				 pcifunc, req->sso, block->lf.max);
+				 pcifunc, req->ssow, block->lf.max);
 			return -EINVAL;
 		}
 		mappedlfs = rvu_get_rsrc_mapcount(pfvf, block->addr);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index f047185f38e0..3e09d2285814 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -696,7 +696,8 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 					struct cpt_rd_wr_reg_msg *req,
 					struct cpt_rd_wr_reg_msg *rsp)
 {
-	int blkaddr;
+	u64 offset = req->reg_offset;
+	int blkaddr, lf;
 
 	blkaddr = validate_and_get_cpt_blkaddr(req->blkaddr);
 	if (blkaddr < 0)
@@ -707,17 +708,25 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 	    !is_cpt_vf(rvu, req->hdr.pcifunc))
 		return CPT_AF_ERR_ACCESS_DENIED;
 
-	rsp->reg_offset = req->reg_offset;
-	rsp->ret_val = req->ret_val;
-	rsp->is_write = req->is_write;
-
 	if (!is_valid_offset(rvu, req))
 		return CPT_AF_ERR_ACCESS_DENIED;
 
+	/* Translate local LF used by VFs to global CPT LF */
+	lf = rvu_get_lf(rvu, &rvu->hw->block[blkaddr], req->hdr.pcifunc,
+			(offset & 0xFFF) >> 3);
+
+	/* Translate local LF's offset to global CPT LF's offset */
+	offset &= 0xFF000;
+	offset += lf << 3;
+
+	rsp->reg_offset = offset;
+	rsp->ret_val = req->ret_val;
+	rsp->is_write = req->is_write;
+
 	if (req->is_write)
-		rvu_write64(rvu, blkaddr, req->reg_offset, req->val);
+		rvu_write64(rvu, blkaddr, offset, req->val);
 	else
-		rsp->val = rvu_read64(rvu, blkaddr, req->reg_offset);
+		rsp->val = rvu_read64(rvu, blkaddr, offset);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 00af8888e329..3dc828cf6c5a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -3864,6 +3864,11 @@ static int get_flowkey_alg_idx(struct nix_hw *nix_hw, u32 flow_cfg)
 	return -ERANGE;
 }
 
+/* Mask to match ipv6(NPC_LT_LC_IP6) and ipv6 ext(NPC_LT_LC_IP6_EXT) */
+#define NPC_LT_LC_IP6_MATCH_MSK ((~(NPC_LT_LC_IP6 ^ NPC_LT_LC_IP6_EXT)) & 0xf)
+/* Mask to match both ipv4(NPC_LT_LC_IP) and ipv4 ext(NPC_LT_LC_IP_OPT) */
+#define NPC_LT_LC_IP_MATCH_MSK  ((~(NPC_LT_LC_IP ^ NPC_LT_LC_IP_OPT)) & 0xf)
+
 static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 {
 	int idx, nr_field, key_off, field_marker, keyoff_marker;
@@ -3933,7 +3938,7 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 			field->hdr_offset = 9; /* offset */
 			field->bytesm1 = 0; /* 1 byte */
 			field->ltype_match = NPC_LT_LC_IP;
-			field->ltype_mask = 0xF;
+			field->ltype_mask = NPC_LT_LC_IP_MATCH_MSK;
 			break;
 		case NIX_FLOW_KEY_TYPE_IPV4:
 		case NIX_FLOW_KEY_TYPE_INNR_IPV4:
@@ -3960,8 +3965,7 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 					field->bytesm1 = 3; /* DIP, 4 bytes */
 				}
 			}
-
-			field->ltype_mask = 0xF; /* Match only IPv4 */
+			field->ltype_mask = NPC_LT_LC_IP_MATCH_MSK;
 			keyoff_marker = false;
 			break;
 		case NIX_FLOW_KEY_TYPE_IPV6:
@@ -3990,7 +3994,7 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 					field->bytesm1 = 15; /* DIP,16 bytes */
 				}
 			}
-			field->ltype_mask = 0xF; /* Match only IPv6 */
+			field->ltype_mask = NPC_LT_LC_IP6_MATCH_MSK;
 			break;
 		case NIX_FLOW_KEY_TYPE_TCP:
 		case NIX_FLOW_KEY_TYPE_UDP:
diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 31aebeb2e285..25989c79c92e 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1524,6 +1524,7 @@ static int mtk_star_probe(struct platform_device *pdev)
 {
 	struct device_node *of_node;
 	struct mtk_star_priv *priv;
+	struct phy_device *phydev;
 	struct net_device *ndev;
 	struct device *dev;
 	void __iomem *base;
@@ -1649,6 +1650,12 @@ static int mtk_star_probe(struct platform_device *pdev)
 	netif_napi_add(ndev, &priv->rx_napi, mtk_star_rx_poll);
 	netif_napi_add_tx(ndev, &priv->tx_napi, mtk_star_tx_poll);
 
+	phydev = of_phy_find_device(priv->phy_node);
+	if (phydev) {
+		phydev->mac_managed_pm = true;
+		put_device(&phydev->mdio.dev);
+	}
+
 	return devm_register_netdev(dev, ndev);
 }
 
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 6453c92f0fa7..7fa1820db9cc 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -352,11 +352,11 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 		netif_dbg(ks, intr, ks->netdev,
 			  "%s: txspace %d\n", __func__, tx_space);
 
-		spin_lock(&ks->statelock);
+		spin_lock_bh(&ks->statelock);
 		ks->tx_space = tx_space;
 		if (netif_queue_stopped(ks->netdev))
 			netif_wake_queue(ks->netdev);
-		spin_unlock(&ks->statelock);
+		spin_unlock_bh(&ks->statelock);
 	}
 
 	if (status & IRQ_SPIBEI) {
@@ -482,6 +482,7 @@ static int ks8851_net_open(struct net_device *dev)
 	ks8851_wrreg16(ks, KS_IER, ks->rc_ier);
 
 	ks->queued_len = 0;
+	ks->tx_space = ks8851_rdreg16(ks, KS_TXMIR);
 	netif_start_queue(ks->netdev);
 
 	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
@@ -635,14 +636,14 @@ static void ks8851_set_rx_mode(struct net_device *dev)
 
 	/* schedule work to do the actual set of the data if needed */
 
-	spin_lock(&ks->statelock);
+	spin_lock_bh(&ks->statelock);
 
 	if (memcmp(&rxctrl, &ks->rxctrl, sizeof(rxctrl)) != 0) {
 		memcpy(&ks->rxctrl, &rxctrl, sizeof(ks->rxctrl));
 		schedule_work(&ks->rxctrl_work);
 	}
 
-	spin_unlock(&ks->statelock);
+	spin_unlock_bh(&ks->statelock);
 }
 
 static int ks8851_set_mac_address(struct net_device *dev, void *addr)
@@ -1101,7 +1102,6 @@ int ks8851_probe_common(struct net_device *netdev, struct device *dev,
 	int ret;
 
 	ks->netdev = netdev;
-	ks->tx_space = 6144;
 
 	ks->gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	ret = PTR_ERR_OR_ZERO(ks->gpio);
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
index 670c1de966db..3062cc0f9199 100644
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -340,10 +340,10 @@ static void ks8851_tx_work(struct work_struct *work)
 
 	tx_space = ks8851_rdreg16_spi(ks, KS_TXMIR);
 
-	spin_lock(&ks->statelock);
+	spin_lock_bh(&ks->statelock);
 	ks->queued_len -= dequeued_len;
 	ks->tx_space = tx_space;
-	spin_unlock(&ks->statelock);
+	spin_unlock_bh(&ks->statelock);
 
 	ks8851_unlock_spi(ks, &flags);
 }
diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index a838b61cd844..a35528497a57 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -748,7 +748,7 @@ static int lan87xx_cable_test_report(struct phy_device *phydev)
 	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
 				lan87xx_cable_test_report_trans(detect));
 
-	return 0;
+	return phy_init_hw(phydev);
 }
 
 static int lan87xx_cable_test_get_status(struct phy_device *phydev,
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index fe380fe196e7..996dee54d751 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -70,6 +70,7 @@
 #define MPHDRLEN_SSN	4	/* ditto with short sequence numbers */
 
 #define PPP_PROTO_LEN	2
+#define PPP_LCP_HDRLEN	4
 
 /*
  * An instance of /dev/ppp can be associated with either a ppp
@@ -493,6 +494,15 @@ static ssize_t ppp_read(struct file *file, char __user *buf,
 	return ret;
 }
 
+static bool ppp_check_packet(struct sk_buff *skb, size_t count)
+{
+	/* LCP packets must include LCP header which 4 bytes long:
+	 * 1-byte code, 1-byte identifier, and 2-byte length.
+	 */
+	return get_unaligned_be16(skb->data) != PPP_LCP ||
+		count >= PPP_PROTO_LEN + PPP_LCP_HDRLEN;
+}
+
 static ssize_t ppp_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
@@ -515,6 +525,11 @@ static ssize_t ppp_write(struct file *file, const char __user *buf,
 		kfree_skb(skb);
 		goto out;
 	}
+	ret = -EINVAL;
+	if (unlikely(!ppp_check_packet(skb, count))) {
+		kfree_skb(skb);
+		goto out;
+	}
 
 	switch (pf->kind) {
 	case INTERFACE:
diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
index 0ba714ca5185..4b8528206cc8 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -15,8 +15,8 @@ static void swap_endian(u8 *dst, const u8 *src, u8 bits)
 	if (bits == 32) {
 		*(u32 *)dst = be32_to_cpu(*(const __be32 *)src);
 	} else if (bits == 128) {
-		((u64 *)dst)[0] = be64_to_cpu(((const __be64 *)src)[0]);
-		((u64 *)dst)[1] = be64_to_cpu(((const __be64 *)src)[1]);
+		((u64 *)dst)[0] = get_unaligned_be64(src);
+		((u64 *)dst)[1] = get_unaligned_be64(src + 8);
 	}
 }
 
diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 1ea4f874e367..7eb76724b3ed 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -124,10 +124,10 @@ static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
  */
 static inline int wg_cpumask_next_online(int *last_cpu)
 {
-	int cpu = cpumask_next(*last_cpu, cpu_online_mask);
+	int cpu = cpumask_next(READ_ONCE(*last_cpu), cpu_online_mask);
 	if (cpu >= nr_cpu_ids)
 		cpu = cpumask_first(cpu_online_mask);
-	*last_cpu = cpu;
+	WRITE_ONCE(*last_cpu, cpu);
 	return cpu;
 }
 
diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
index 0d48e0f4a1ba..26e09c30d596 100644
--- a/drivers/net/wireguard/send.c
+++ b/drivers/net/wireguard/send.c
@@ -222,7 +222,7 @@ void wg_packet_send_keepalive(struct wg_peer *peer)
 {
 	struct sk_buff *skb;
 
-	if (skb_queue_empty(&peer->staged_packet_queue)) {
+	if (skb_queue_empty_lockless(&peer->staged_packet_queue)) {
 		skb = alloc_skb(DATA_PACKET_HEAD_ROOM + MESSAGE_MINIMUM_LENGTH,
 				GFP_ATOMIC);
 		if (unlikely(!skb))
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2c6b99402df8..3a3f9b5018ca 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -396,10 +396,9 @@ static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
 	if (!config->base_dev)
 		return -EINVAL;
 
-	if (config->type == NVMEM_TYPE_FRAM)
-		bin_attr_nvmem_eeprom_compat.attr.name = "fram";
-
 	nvmem->eeprom = bin_attr_nvmem_eeprom_compat;
+	if (config->type == NVMEM_TYPE_FRAM)
+		nvmem->eeprom.attr.name = "fram";
 	nvmem->eeprom.attr.mode = nvmem_bin_attr_get_umode(nvmem);
 	nvmem->eeprom.size = nvmem->size;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -463,7 +462,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 						    "%s@%x,%x", entry->name,
 						    entry->offset,
 						    entry->bit_offset);
-		attrs[i].attr.mode = 0444;
+		attrs[i].attr.mode = 0444 & nvmem_bin_attr_get_umode(nvmem);
 		attrs[i].size = entry->bytes;
 		attrs[i].read = &nvmem_cell_attr_read;
 		attrs[i].private = entry;
diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 33678d0af2c2..6c2f80e166e2 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -18,18 +18,24 @@ static int meson_efuse_read(void *context, unsigned int offset,
 			    void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
+	int ret;
 
-	return meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
-				  bytes, 0, 0, 0);
+	ret = meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
+				 bytes, 0, 0, 0);
+
+	return ret < 0 ? ret : 0;
 }
 
 static int meson_efuse_write(void *context, unsigned int offset,
 			     void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
+	int ret;
+
+	ret = meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
+				  bytes, 0, 0, 0);
 
-	return meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
-				   bytes, 0, 0, 0);
+	return ret < 0 ? ret : 0;
 }
 
 static const struct of_device_id meson_efuse_match[] = {
diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
index 752d0bf4445e..7f907c5a445e 100644
--- a/drivers/nvmem/rmem.c
+++ b/drivers/nvmem/rmem.c
@@ -46,7 +46,10 @@ static int rmem_read(void *context, unsigned int offset,
 
 	memunmap(addr);
 
-	return count;
+	if (count < 0)
+		return count;
+
+	return count == bytes ? 0 : -EIO;
 }
 
 static int rmem_probe(struct platform_device *pdev)
diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 7d345009c327..5574cea0c2ef 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3304,6 +3304,7 @@ static const struct dmi_system_id toshiba_dmi_quirks[] __initconst = {
 		},
 	 .driver_data = (void *)(QUIRK_TURN_ON_PANEL_ON_RESUME | QUIRK_HCI_HOTKEY_QUICKSTART),
 	},
+	{ }
 };
 
 static int toshiba_acpi_add(struct acpi_device *acpi_dev)
diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index de9121ef4216..d2cb4271a1ca 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -40,6 +40,7 @@
  * @addr:		Resource address as looped up using resource name from
  *			cmd-db
  * @state_synced:	Indicator that sync_state has been invoked for the rpmhpd resource
+ * @skip_retention_level: Indicate that retention level should not be used for the power domain
  */
 struct rpmhpd {
 	struct device	*dev;
@@ -56,6 +57,7 @@ struct rpmhpd {
 	const char	*res_name;
 	u32		addr;
 	bool		state_synced;
+	bool            skip_retention_level;
 };
 
 struct rpmhpd_desc {
@@ -173,6 +175,7 @@ static struct rpmhpd mxc = {
 	.pd = { .name = "mxc", },
 	.peer = &mxc_ao,
 	.res_name = "mxc.lvl",
+	.skip_retention_level = true,
 };
 
 static struct rpmhpd mxc_ao = {
@@ -180,6 +183,7 @@ static struct rpmhpd mxc_ao = {
 	.active_only = true,
 	.peer = &mxc,
 	.res_name = "mxc.lvl",
+	.skip_retention_level = true,
 };
 
 static struct rpmhpd nsp = {
@@ -819,6 +823,9 @@ static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
 		return -EINVAL;
 
 	for (i = 0; i < rpmhpd->level_count; i++) {
+		if (rpmhpd->skip_retention_level && buf[i] == RPMH_REGULATOR_LEVEL_RETENTION)
+			continue;
+
 		rpmhpd->level[i] = buf[i];
 
 		/* Remember the first corner with non-zero level */
diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index e358ac5b4509..96a524772549 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -164,16 +164,20 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 }
 
 static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
-				 int delay_ns, u32 sclk_hz)
+				 int delay_ns, int inst_ns, u32 sclk_hz)
 {
 	unsigned int t;
 
-	/* negative delay indicates error, e.g. from spi_delay_to_ns() */
-	if (delay_ns <= 0)
+	/*
+	 * Negative delay indicates error, e.g. from spi_delay_to_ns(). And if
+	 * delay is less that the instruction execution time, there is no need
+	 * for an extra sleep instruction since the instruction execution time
+	 * will already cover the required delay.
+	 */
+	if (delay_ns < 0 || delay_ns <= inst_ns)
 		return;
 
-	/* rounding down since executing the instruction adds a couple of ticks delay */
-	t = DIV_ROUND_DOWN_ULL((u64)delay_ns * sclk_hz, NSEC_PER_SEC);
+	t = DIV_ROUND_UP_ULL((u64)(delay_ns - inst_ns) * sclk_hz, NSEC_PER_SEC);
 	while (t) {
 		unsigned int n = min(t, 256U);
 
@@ -220,10 +224,16 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	struct spi_device *spi = msg->spi;
 	struct spi_controller *host = spi->controller;
 	struct spi_transfer *xfer;
-	int clk_div, new_clk_div;
+	int clk_div, new_clk_div, inst_ns;
 	bool keep_cs = false;
 	u8 bits_per_word = 0;
 
+	/*
+	 * Take into account instruction execution time for more accurate sleep
+	 * times, especially when the delay is small.
+	 */
+	inst_ns = DIV_ROUND_UP(NSEC_PER_SEC, host->max_speed_hz);
+
 	clk_div = 1;
 
 	spi_engine_program_add_cmd(p, dry,
@@ -252,7 +262,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 
 		spi_engine_gen_xfer(p, dry, xfer);
 		spi_engine_gen_sleep(p, dry, spi_delay_to_ns(&xfer->delay, xfer),
-				     xfer->effective_speed_hz);
+				     inst_ns, xfer->effective_speed_hz);
 
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list, &msg->transfers)) {
@@ -262,7 +272,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 					spi_engine_gen_cs(p, dry, spi, false);
 
 				spi_engine_gen_sleep(p, dry, spi_delay_to_ns(
-					&xfer->cs_change_delay, xfer),
+					&xfer->cs_change_delay, xfer), inst_ns,
 					xfer->effective_speed_hz);
 
 				if (!list_next_entry(xfer, transfer_list)->cs_off)
diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index bd988f53753e..031b5795d106 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -162,6 +162,7 @@ static int spi_mux_probe(struct spi_device *spi)
 	ctlr->bus_num = -1;
 	ctlr->dev.of_node = spi->dev.of_node;
 	ctlr->must_async = true;
+	ctlr->defer_optimize_message = true;
 
 	ret = devm_spi_register_controller(&spi->dev, ctlr);
 	if (ret)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c349d6012625..9304fd03bf76 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2137,7 +2137,8 @@ static void __spi_unoptimize_message(struct spi_message *msg)
  */
 static void spi_maybe_unoptimize_message(struct spi_message *msg)
 {
-	if (!msg->pre_optimized && msg->optimized)
+	if (!msg->pre_optimized && msg->optimized &&
+	    !msg->spi->controller->defer_optimize_message)
 		__spi_unoptimize_message(msg);
 }
 
@@ -4285,6 +4286,11 @@ static int __spi_optimize_message(struct spi_device *spi,
 static int spi_maybe_optimize_message(struct spi_device *spi,
 				      struct spi_message *msg)
 {
+	if (spi->controller->defer_optimize_message) {
+		msg->spi = spi;
+		return 0;
+	}
+
 	if (msg->pre_optimized)
 		return 0;
 
@@ -4315,6 +4321,13 @@ int spi_optimize_message(struct spi_device *spi, struct spi_message *msg)
 {
 	int ret;
 
+	/*
+	 * Pre-optimization is not supported and optimization is deferred e.g.
+	 * when using spi-mux.
+	 */
+	if (spi->controller->defer_optimize_message)
+		return 0;
+
 	ret = __spi_optimize_message(spi, msg);
 	if (ret)
 		return ret;
@@ -4341,6 +4354,9 @@ EXPORT_SYMBOL_GPL(spi_optimize_message);
  */
 void spi_unoptimize_message(struct spi_message *msg)
 {
+	if (msg->spi->controller->defer_optimize_message)
+		return;
+
 	__spi_unoptimize_message(msg);
 	msg->pre_optimized = false;
 }
@@ -4423,8 +4439,6 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
 
 	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
 
-	spi_maybe_unoptimize_message(message);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_async);
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index f63cdd679441..8fde71138c5d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1560,6 +1560,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long flags;
 	u32 ucr1, ucr2, ucr4, uts;
+	int loops;
 
 	if (sport->dma_is_enabled) {
 		dmaengine_terminate_sync(sport->dma_chan_tx);
@@ -1622,6 +1623,56 @@ static void imx_uart_shutdown(struct uart_port *port)
 	ucr4 &= ~UCR4_TCEN;
 	imx_uart_writel(sport, ucr4, UCR4);
 
+	/*
+	 * We have to ensure the tx state machine ends up in OFF. This
+	 * is especially important for rs485 where we must not leave
+	 * the RTS signal high, blocking the bus indefinitely.
+	 *
+	 * All interrupts are now disabled, so imx_uart_stop_tx() will
+	 * no longer be called from imx_uart_transmit_buffer(). It may
+	 * still be called via the hrtimers, and if those are in play,
+	 * we have to honour the delays.
+	 */
+	if (sport->tx_state == WAIT_AFTER_RTS || sport->tx_state == SEND)
+		imx_uart_stop_tx(port);
+
+	/*
+	 * In many cases (rs232 mode, or if tx_state was
+	 * WAIT_AFTER_RTS, or if tx_state was SEND and there is no
+	 * delay_rts_after_send), this will have moved directly to
+	 * OFF. In rs485 mode, tx_state might already have been
+	 * WAIT_AFTER_SEND and the hrtimer thus already started, or
+	 * the above imx_uart_stop_tx() call could have started it. In
+	 * those cases, we have to wait for the hrtimer to fire and
+	 * complete the transition to OFF.
+	 */
+	loops = port->rs485.flags & SER_RS485_ENABLED ?
+		port->rs485.delay_rts_after_send : 0;
+	while (sport->tx_state != OFF && loops--) {
+		uart_port_unlock_irqrestore(&sport->port, flags);
+		msleep(1);
+		uart_port_lock_irqsave(&sport->port, &flags);
+	}
+
+	if (sport->tx_state != OFF) {
+		dev_warn(sport->port.dev, "unexpected tx_state %d\n",
+			 sport->tx_state);
+		/*
+		 * This machine may be busted, but ensure the RTS
+		 * signal is inactive in order not to block other
+		 * devices.
+		 */
+		if (port->rs485.flags & SER_RS485_ENABLED) {
+			ucr2 = imx_uart_readl(sport, UCR2);
+			if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+				imx_uart_rts_active(sport, &ucr2);
+			else
+				imx_uart_rts_inactive(sport, &ucr2);
+			imx_uart_writel(sport, ucr2, UCR2);
+		}
+		sport->tx_state = OFF;
+	}
+
 	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	clk_disable_unprepare(sport->clk_per);
diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 19f0a305cc43..3b4206e815fe 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -688,12 +688,13 @@ static int ma35d1serial_probe(struct platform_device *pdev)
 	struct uart_ma35d1_port *up;
 	int ret = 0;
 
-	if (pdev->dev.of_node) {
-		ret = of_alias_get_id(pdev->dev.of_node, "serial");
-		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
-			return ret;
-		}
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	ret = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
+		return ret;
 	}
 	up = &ma35d1serial_ports[ret];
 	up->port.line = ret;
diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 8944548c30fa..c532416aec22 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -105,16 +105,15 @@ EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);
  * @hba: per adapter instance
  * @req: pointer to the request to be issued
  *
- * Return: the hardware queue instance on which the request would
- * be queued.
+ * Return: the hardware queue instance on which the request will be or has
+ * been queued. %NULL if the request has already been freed.
  */
 struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 					 struct request *req)
 {
-	u32 utag = blk_mq_unique_tag(req);
-	u32 hwq = blk_mq_unique_tag_to_hwq(utag);
+	struct blk_mq_hw_ctx *hctx = READ_ONCE(req->mq_hctx);
 
-	return &hba->uhq[hwq];
+	return hctx ? &hba->uhq[hctx->queue_num] : NULL;
 }
 
 /**
@@ -515,6 +514,8 @@ int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag)
 		if (!cmd)
 			return -EINVAL;
 		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
+		if (!hwq)
+			return 0;
 	} else {
 		hwq = hba->dev_cmd_queue;
 	}
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f7d04f7c0017..ad192b74536a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6506,6 +6506,8 @@ static bool ufshcd_abort_one(struct request *rq, void *priv)
 	/* Release cmd in MCQ mode if abort succeeds */
 	if (is_mcq_enabled(hba) && (*ret == 0)) {
 		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(lrbp->cmd));
+		if (!hwq)
+			return 0;
 		spin_lock_irqsave(&hwq->cq_lock, flags);
 		if (ufshcd_cmd_inflight(lrbp->cmd))
 			ufshcd_release_scsi_cmd(hba, lrbp);
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 7f8d33f92ddb..847dd32c0f5e 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -291,6 +291,20 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	if (ifp->desc.bNumEndpoints >= num_ep)
 		goto skip_to_next_endpoint_or_interface_descriptor;
 
+	/* Save a copy of the descriptor and use it instead of the original */
+	endpoint = &ifp->endpoint[ifp->desc.bNumEndpoints];
+	memcpy(&endpoint->desc, d, n);
+	d = &endpoint->desc;
+
+	/* Clear the reserved bits in bEndpointAddress */
+	i = d->bEndpointAddress &
+			(USB_ENDPOINT_DIR_MASK | USB_ENDPOINT_NUMBER_MASK);
+	if (i != d->bEndpointAddress) {
+		dev_notice(ddev, "config %d interface %d altsetting %d has an endpoint descriptor with address 0x%X, changing to 0x%X\n",
+		    cfgno, inum, asnum, d->bEndpointAddress, i);
+		endpoint->desc.bEndpointAddress = i;
+	}
+
 	/* Check for duplicate endpoint addresses */
 	if (config_endpoint_is_duplicate(config, inum, asnum, d)) {
 		dev_notice(ddev, "config %d interface %d altsetting %d has a duplicate endpoint with address 0x%X, skipping\n",
@@ -308,10 +322,8 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 		}
 	}
 
-	endpoint = &ifp->endpoint[ifp->desc.bNumEndpoints];
+	/* Accept this endpoint */
 	++ifp->desc.bNumEndpoints;
-
-	memcpy(&endpoint->desc, d, n);
 	INIT_LIST_HEAD(&endpoint->urb_list);
 
 	/*
diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
index f1a499ee482c..763e4122ed5b 100644
--- a/drivers/usb/core/of.c
+++ b/drivers/usb/core/of.c
@@ -84,9 +84,12 @@ static bool usb_of_has_devices_or_graph(const struct usb_device *hub)
 	if (of_graph_is_present(np))
 		return true;
 
-	for_each_child_of_node(np, child)
-		if (of_property_present(child, "reg"))
+	for_each_child_of_node(np, child) {
+		if (of_property_present(child, "reg")) {
+			of_node_put(child);
 			return true;
+		}
+	}
 
 	return false;
 }
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index b4783574b8e6..13171454f959 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -506,6 +506,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x1b1c, 0x1b38), .driver_info = USB_QUIRK_DELAY_INIT |
 	  USB_QUIRK_DELAY_CTRL_MSG },
 
+	/* START BP-850k Printer */
+	{ USB_DEVICE(0x1bc3, 0x0003), .driver_info = USB_QUIRK_NO_SET_INTF },
+
 	/* MIDI keyboard WORLDE MINI */
 	{ USB_DEVICE(0x1c75, 0x0204), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 9ef821ca2fc7..052852f80146 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -54,6 +54,10 @@
 #define PCI_DEVICE_ID_INTEL_MTL			0x7e7e
 #define PCI_DEVICE_ID_INTEL_ARLH_PCH		0x777e
 #define PCI_DEVICE_ID_INTEL_TGL			0x9a15
+#define PCI_DEVICE_ID_INTEL_PTLH		0xe332
+#define PCI_DEVICE_ID_INTEL_PTLH_PCH		0xe37e
+#define PCI_DEVICE_ID_INTEL_PTLU		0xe432
+#define PCI_DEVICE_ID_INTEL_PTLU_PCH		0xe47e
 #define PCI_DEVICE_ID_AMD_MR			0x163a
 
 #define PCI_INTEL_BXT_DSM_GUID		"732b85d5-b7a7-4a1b-9ba0-4bbd00ffd511"
@@ -430,6 +434,10 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 	{ PCI_DEVICE_DATA(INTEL, MTLS, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, ARLH_PCH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, TGL, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, PTLH, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, PTLH_PCH, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, PTLU, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, PTLU_PCH, &dwc3_pci_intel_swnode) },
 
 	{ PCI_DEVICE_DATA(AMD, NL_USB, &dwc3_pci_amd_swnode) },
 	{ PCI_DEVICE_DATA(AMD, MR, &dwc3_pci_amd_mr_swnode) },
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index ce3cfa1f36f5..0e7c1e947c0a 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -115,9 +115,12 @@ static int usb_string_copy(const char *s, char **s_copy)
 	int ret;
 	char *str;
 	char *copy = *s_copy;
+
 	ret = strlen(s);
 	if (ret > USB_MAX_STRING_LEN)
 		return -EOVERFLOW;
+	if (ret < 1)
+		return -EINVAL;
 
 	if (copy) {
 		str = copy;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 8579603edaff..26d6ac940b69 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1125,10 +1125,20 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 			xhci_dbg(xhci, "Start the secondary HCD\n");
 			retval = xhci_run(xhci->shared_hcd);
 		}
-
+		if (retval)
+			return retval;
+		/*
+		 * Resume roothubs unconditionally as PORTSC change bits are not
+		 * immediately visible after xHC reset
+		 */
 		hcd->state = HC_STATE_SUSPENDED;
-		if (xhci->shared_hcd)
+
+		if (xhci->shared_hcd) {
 			xhci->shared_hcd->state = HC_STATE_SUSPENDED;
+			usb_hcd_resume_root_hub(xhci->shared_hcd);
+		}
+		usb_hcd_resume_root_hub(hcd);
+
 		goto done;
 	}
 
@@ -1152,7 +1162,6 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 
 	xhci_dbc_resume(xhci);
 
- done:
 	if (retval == 0) {
 		/*
 		 * Resume roothubs only if there are pending events.
@@ -1178,6 +1187,7 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 			usb_hcd_resume_root_hub(hcd);
 		}
 	}
+done:
 	/*
 	 * If system is subject to the Quirk, Compliance Mode Timer needs to
 	 * be re-initialized Always after a system resume. Ports are subject
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 8b0308d84270..85697466b147 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1737,6 +1737,49 @@ static void mos7840_port_remove(struct usb_serial_port *port)
 	kfree(mos7840_port);
 }
 
+static int mos7840_suspend(struct usb_serial *serial, pm_message_t message)
+{
+	struct moschip_port *mos7840_port;
+	struct usb_serial_port *port;
+	int i;
+
+	for (i = 0; i < serial->num_ports; ++i) {
+		port = serial->port[i];
+		if (!tty_port_initialized(&port->port))
+			continue;
+
+		mos7840_port = usb_get_serial_port_data(port);
+
+		usb_kill_urb(mos7840_port->read_urb);
+		mos7840_port->read_urb_busy = false;
+	}
+
+	return 0;
+}
+
+static int mos7840_resume(struct usb_serial *serial)
+{
+	struct moschip_port *mos7840_port;
+	struct usb_serial_port *port;
+	int res;
+	int i;
+
+	for (i = 0; i < serial->num_ports; ++i) {
+		port = serial->port[i];
+		if (!tty_port_initialized(&port->port))
+			continue;
+
+		mos7840_port = usb_get_serial_port_data(port);
+
+		mos7840_port->read_urb_busy = true;
+		res = usb_submit_urb(mos7840_port->read_urb, GFP_NOIO);
+		if (res)
+			mos7840_port->read_urb_busy = false;
+	}
+
+	return 0;
+}
+
 static struct usb_serial_driver moschip7840_4port_device = {
 	.driver = {
 		   .owner = THIS_MODULE,
@@ -1764,6 +1807,8 @@ static struct usb_serial_driver moschip7840_4port_device = {
 	.port_probe = mos7840_port_probe,
 	.port_remove = mos7840_port_remove,
 	.read_bulk_callback = mos7840_bulk_in_callback,
+	.suspend = mos7840_suspend,
+	.resume = mos7840_resume,
 };
 
 static struct usb_serial_driver * const serial_drivers[] = {
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 8a5846d4adf6..311040f9b935 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1425,6 +1425,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1901, 0xff),	/* Telit LN940 (MBIM) */
 	  .driver_info = NCTRL(0) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x3000, 0xff),	/* Telit FN912 */
+	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x3001, 0xff),	/* Telit FN912 */
+	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x7010, 0xff),	/* Telit LE910-S1 (RNDIS) */
 	  .driver_info = NCTRL(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x7011, 0xff),	/* Telit LE910-S1 (ECM) */
@@ -1433,6 +1437,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x701b, 0xff),	/* Telit LE910R1 (ECM) */
 	  .driver_info = NCTRL(2) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x9000, 0xff),	/* Telit generic core-dump device */
+	  .driver_info = NCTRL(0) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, 0x9010),				/* Telit SBL FN980 flashing device */
 	  .driver_info = NCTRL(0) | ZLP },
 	{ USB_DEVICE(TELIT_VENDOR_ID, 0x9200),				/* Telit LE910S1 flashing device */
@@ -2224,6 +2230,10 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, MEDIATEK_PRODUCT_7106_2COM, 0x02, 0x02, 0x01) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, MEDIATEK_PRODUCT_DC_4COM2, 0xff, 0x02, 0x01) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, MEDIATEK_PRODUCT_DC_4COM2, 0xff, 0x00, 0x00) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7126, 0xff, 0x00, 0x00),
+	  .driver_info = NCTRL(2) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7127, 0xff, 0x00, 0x00),
+	  .driver_info = NCTRL(2) | NCTRL(3) | NCTRL(4) },
 	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MEN200) },
 	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MPL200),
 	  .driver_info = RSVD(1) | RSVD(4) },
@@ -2284,6 +2294,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0f0, 0xff),			/* Foxconn T99W373 MBIM */
 	  .driver_info = RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe145, 0xff),			/* Foxconn T99W651 RNDIS */
+	  .driver_info = RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
@@ -2321,6 +2333,32 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0115, 0xff),			/* Rolling RW135-GL (laptop MBIM) */
 	  .driver_info = RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0802, 0xff),			/* Rolling RW350-GL (laptop MBIM) */
+	  .driver_info = RSVD(5) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for Global */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0101, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WRD for Global SKU */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0101, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0101, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0106, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WRD for China SKU */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0106, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0106, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0111, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for SA */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0111, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0111, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0112, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for EU */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0112, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0112, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0113, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for NA */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0113, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0113, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0115, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for China EDU */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0115, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0115, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0116, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for Golbal EDU */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0116, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0116, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index d8c95cc16be8..ea36d2139590 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1260,7 +1260,7 @@ static int vfio_pci_ioctl_get_pci_hot_reset_info(
 	struct vfio_pci_hot_reset_info hdr;
 	struct vfio_pci_fill_info fill = {};
 	bool slot = false;
-	int ret, count;
+	int ret, count = 0;
 
 	if (copy_from_user(&hdr, arg, minsz))
 		return -EFAULT;
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 06cdf1a8a16f..89b11336a836 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -366,14 +366,14 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 
 	if (cachefiles_in_ondemand_mode(cache)) {
 		if (!xa_empty(&cache->reqs)) {
-			rcu_read_lock();
+			xas_lock(&xas);
 			xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
 				if (!cachefiles_ondemand_is_reopening_read(req)) {
 					mask |= EPOLLIN;
 					break;
 				}
 			}
-			rcu_read_unlock();
+			xas_unlock(&xas);
 		}
 	} else {
 		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 6845a90cdfcc..7b99bd98de75 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -48,6 +48,7 @@ enum cachefiles_object_state {
 	CACHEFILES_ONDEMAND_OBJSTATE_CLOSE, /* Anonymous fd closed by daemon or initial state */
 	CACHEFILES_ONDEMAND_OBJSTATE_OPEN, /* Anonymous fd associated with object is available */
 	CACHEFILES_ONDEMAND_OBJSTATE_REOPENING, /* Object that was closed and is being reopened. */
+	CACHEFILES_ONDEMAND_OBJSTATE_DROPPING, /* Object is being dropped. */
 };
 
 struct cachefiles_ondemand_info {
@@ -128,6 +129,7 @@ struct cachefiles_cache {
 	unsigned long			req_id_next;
 	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
 	u32				ondemand_id_next;
+	u32				msg_id_next;
 };
 
 static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
@@ -335,6 +337,7 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
 CACHEFILES_OBJECT_STATE_FUNCS(close, CLOSE);
 CACHEFILES_OBJECT_STATE_FUNCS(reopening, REOPENING);
+CACHEFILES_OBJECT_STATE_FUNCS(dropping, DROPPING);
 
 static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
 {
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 89f118d68d12..7e4874f60de1 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -494,7 +494,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		 */
 		xas_lock(&xas);
 
-		if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
+		if (test_bit(CACHEFILES_DEAD, &cache->flags) ||
+		    cachefiles_ondemand_object_is_dropping(object)) {
 			xas_unlock(&xas);
 			ret = -EIO;
 			goto out;
@@ -504,20 +505,32 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		smp_mb();
 
 		if (opcode == CACHEFILES_OP_CLOSE &&
-			!cachefiles_ondemand_object_is_open(object)) {
+		    !cachefiles_ondemand_object_is_open(object)) {
 			WARN_ON_ONCE(object->ondemand->ondemand_id == 0);
 			xas_unlock(&xas);
 			ret = -EIO;
 			goto out;
 		}
 
-		xas.xa_index = 0;
+		/*
+		 * Cyclically find a free xas to avoid msg_id reuse that would
+		 * cause the daemon to successfully copen a stale msg_id.
+		 */
+		xas.xa_index = cache->msg_id_next;
 		xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
+		if (xas.xa_node == XAS_RESTART) {
+			xas.xa_index = 0;
+			xas_find_marked(&xas, cache->msg_id_next - 1, XA_FREE_MARK);
+		}
 		if (xas.xa_node == XAS_RESTART)
 			xas_set_err(&xas, -EBUSY);
+
 		xas_store(&xas, req);
-		xas_clear_mark(&xas, XA_FREE_MARK);
-		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+		if (xas_valid(&xas)) {
+			cache->msg_id_next = xas.xa_index + 1;
+			xas_clear_mark(&xas, XA_FREE_MARK);
+			xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+		}
 		xas_unlock(&xas);
 	} while (xas_nomem(&xas, GFP_KERNEL));
 
@@ -535,7 +548,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 	 * If error occurs after creating the anonymous fd,
 	 * cachefiles_ondemand_fd_release() will set object to close.
 	 */
-	if (opcode == CACHEFILES_OP_OPEN)
+	if (opcode == CACHEFILES_OP_OPEN &&
+	    !cachefiles_ondemand_object_is_dropping(object))
 		cachefiles_ondemand_set_object_close(object);
 	kfree(req);
 	return ret;
@@ -634,8 +648,34 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 
 void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 {
+	unsigned long index;
+	struct cachefiles_req *req;
+	struct cachefiles_cache *cache;
+
+	if (!object->ondemand)
+		return;
+
 	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
 			cachefiles_ondemand_init_close_req, NULL);
+
+	if (!object->ondemand->ondemand_id)
+		return;
+
+	/* Cancel all requests for the object that is being dropped. */
+	cache = object->volume->cache;
+	xa_lock(&cache->reqs);
+	cachefiles_ondemand_set_object_dropping(object);
+	xa_for_each(&cache->reqs, index, req) {
+		if (req->object == object) {
+			req->error = -EIO;
+			complete(&req->done);
+			__xa_erase(&cache->reqs, index);
+		}
+	}
+	xa_unlock(&cache->reqs);
+
+	/* Wait for ondemand_object_worker() to finish to avoid UAF. */
+	cancel_work_sync(&object->ondemand->ondemand_work);
 }
 
 int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index bcb6173943ee..4dd8a993c60a 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -110,9 +110,11 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 	if (xlen == 0)
 		xlen = vfs_getxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache, buf, tlen);
 	if (xlen != tlen) {
-		if (xlen < 0)
+		if (xlen < 0) {
+			ret = xlen;
 			trace_cachefiles_vfs_error(object, file_inode(file), xlen,
 						   cachefiles_trace_getxattr_error);
+		}
 		if (xlen == -EIO)
 			cachefiles_io_error_obj(
 				object,
@@ -252,6 +254,7 @@ int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
 		xlen = vfs_getxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache, buf, len);
 	if (xlen != len) {
 		if (xlen < 0) {
+			ret = xlen;
 			trace_cachefiles_vfs_error(NULL, d_inode(dentry), xlen,
 						   cachefiles_trace_getxattr_error);
 			if (xlen == -EIO)
diff --git a/fs/dcache.c b/fs/dcache.c
index 71a8e943a0fa..66515fbc9dd7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -355,7 +355,11 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 	flags &= ~DCACHE_ENTRY_TYPE;
 	WRITE_ONCE(dentry->d_flags, flags);
 	dentry->d_inode = NULL;
-	if (dentry->d_flags & DCACHE_LRU_LIST)
+	/*
+	 * The negative counter only tracks dentries on the LRU. Don't inc if
+	 * d_lru is on another list.
+	 */
+	if ((flags & (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
 		this_cpu_inc(nr_dentry_negative);
 }
 
@@ -1844,9 +1848,11 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 
 	spin_lock(&dentry->d_lock);
 	/*
-	 * Decrement negative dentry count if it was in the LRU list.
+	 * The negative counter only tracks dentries on the LRU. Don't dec if
+	 * d_lru is on another list.
 	 */
-	if (dentry->d_flags & DCACHE_LRU_LIST)
+	if ((dentry->d_flags &
+	     (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
 		this_cpu_dec(nr_dentry_negative);
 	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
 	raw_write_seqcount_begin(&dentry->d_seq);
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 63cbda3700ea..d65dccb44ed5 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -473,6 +473,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 			*((unsigned int *) ptr) = t;
 		return len;
 	case attr_clusters_in_group:
+		if (!ptr)
+			return 0;
 		ret = kstrtouint(skip_spaces(buf), 0, &t);
 		if (ret)
 			return ret;
diff --git a/fs/locks.c b/fs/locks.c
index c360d1992d21..bdd94c32256f 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1367,9 +1367,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		locks_wake_up_blocks(&left->c);
 	}
  out:
+	trace_posix_lock_inode(inode, request, error);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
-	trace_posix_lock_inode(inode, request, error);
 	/*
 	 * Free any unused locks.
 	 */
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index d6031acc34f0..a944a0f17b53 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -213,8 +213,7 @@ static int minix_rename(struct mnt_idmap *idmap,
 		if (!new_de)
 			goto out_dir;
 		err = minix_set_link(new_de, new_page, old_inode);
-		kunmap(new_page);
-		put_page(new_page);
+		unmap_and_put_page(new_page, new_de);
 		if (err)
 			goto out_dir;
 		inode_set_ctime_current(new_inode);
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index d748d9dce74e..69ac866332ac 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -384,11 +384,39 @@ struct nilfs_dir_entry *nilfs_find_entry(struct inode *dir,
 
 struct nilfs_dir_entry *nilfs_dotdot(struct inode *dir, struct folio **foliop)
 {
-	struct nilfs_dir_entry *de = nilfs_get_folio(dir, 0, foliop);
+	struct folio *folio;
+	struct nilfs_dir_entry *de, *next_de;
+	size_t limit;
+	char *msg;
 
+	de = nilfs_get_folio(dir, 0, &folio);
 	if (IS_ERR(de))
 		return NULL;
-	return nilfs_next_entry(de);
+
+	limit = nilfs_last_byte(dir, 0);  /* is a multiple of chunk size */
+	if (unlikely(!limit || le64_to_cpu(de->inode) != dir->i_ino ||
+		     !nilfs_match(1, ".", de))) {
+		msg = "missing '.'";
+		goto fail;
+	}
+
+	next_de = nilfs_next_entry(de);
+	/*
+	 * If "next_de" has not reached the end of the chunk, there is
+	 * at least one more record.  Check whether it matches "..".
+	 */
+	if (unlikely((char *)next_de == (char *)de + nilfs_chunk_size(dir) ||
+		     !nilfs_match(2, "..", next_de))) {
+		msg = "missing '..'";
+		goto fail;
+	}
+	*foliop = folio;
+	return next_de;
+
+fail:
+	nilfs_error(dir->i_sb, "directory #%lu %s", dir->i_ino, msg);
+	folio_release_kmap(folio, de);
+	return NULL;
 }
 
 ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 6ff35570db81..37b58c04b6b8 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1938,8 +1938,8 @@ require use of the stronger protocol */
 #define   CIFSSEC_MUST_SEAL	0x40040 /* not supported yet */
 #define   CIFSSEC_MUST_NTLMSSP	0x80080 /* raw ntlmssp with ntlmv2 */
 
-#define   CIFSSEC_DEF (CIFSSEC_MAY_SIGN | CIFSSEC_MAY_NTLMV2 | CIFSSEC_MAY_NTLMSSP)
-#define   CIFSSEC_MAX (CIFSSEC_MUST_NTLMV2)
+#define   CIFSSEC_DEF (CIFSSEC_MAY_SIGN | CIFSSEC_MAY_NTLMV2 | CIFSSEC_MAY_NTLMSSP | CIFSSEC_MAY_SEAL)
+#define   CIFSSEC_MAX (CIFSSEC_MAY_SIGN | CIFSSEC_MUST_KRB5 | CIFSSEC_MAY_SEAL)
 #define   CIFSSEC_AUTH_MASK (CIFSSEC_MAY_NTLMV2 | CIFSSEC_MAY_KRB5 | CIFSSEC_MAY_NTLMSSP)
 /*
  *****************************************************************
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index e7e07891781b..7d26fdcebbf9 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2051,15 +2051,22 @@ int smb2_tree_connect(struct ksmbd_work *work)
  * @access:		file access flags
  * @disposition:	file disposition flags
  * @may_flags:		set with MAY_ flags
+ * @is_dir:		is creating open flags for directory
  *
  * Return:      file open flags
  */
 static int smb2_create_open_flags(bool file_present, __le32 access,
 				  __le32 disposition,
-				  int *may_flags)
+				  int *may_flags,
+				  bool is_dir)
 {
 	int oflags = O_NONBLOCK | O_LARGEFILE;
 
+	if (is_dir) {
+		access &= ~FILE_WRITE_DESIRE_ACCESS_LE;
+		ksmbd_debug(SMB, "Discard write access to a directory\n");
+	}
+
 	if (access & FILE_READ_DESIRED_ACCESS_LE &&
 	    access & FILE_WRITE_DESIRE_ACCESS_LE) {
 		oflags |= O_RDWR;
@@ -3167,7 +3174,9 @@ int smb2_open(struct ksmbd_work *work)
 
 	open_flags = smb2_create_open_flags(file_present, daccess,
 					    req->CreateDisposition,
-					    &may_flags);
+					    &may_flags,
+		req->CreateOptions & FILE_DIRECTORY_FILE_LE ||
+		(file_present && S_ISDIR(d_inode(path.dentry)->i_mode)));
 
 	if (!test_tree_conn_flag(tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
 		if (open_flags & (O_CREAT | O_TRUNC)) {
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 292f5fd50104..5583214cdf5c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2053,7 +2053,7 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 		goto out;
 	features = uffdio_api.features;
 	ret = -EINVAL;
-	if (uffdio_api.api != UFFD_API || (features & ~UFFD_API_FEATURES))
+	if (uffdio_api.api != UFFD_API)
 		goto err_out;
 	ret = -EPERM;
 	if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
@@ -2077,6 +2077,11 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
 	uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
 #endif
+
+	ret = -EINVAL;
+	if (features & ~uffdio_api.features)
+		goto err_out;
+
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
 	if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a4f6f1fecc6f..f8d89a021abc 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1976,8 +1976,9 @@ static inline int subsection_map_index(unsigned long pfn)
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 {
 	int idx = subsection_map_index(pfn);
+	struct mem_section_usage *usage = READ_ONCE(ms->usage);
 
-	return test_bit(idx, READ_ONCE(ms->usage)->subsection_map);
+	return usage ? test_bit(idx, usage->subsection_map) : 0;
 }
 #else
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d31e59e2e411..365a649ef10e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -352,11 +352,18 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  * a good order (that's 1MB if you're using 4kB pages)
  */
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
+#define PREFERRED_MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
 #else
-#define MAX_PAGECACHE_ORDER	8
+#define PREFERRED_MAX_PAGECACHE_ORDER	8
 #endif
 
+/*
+ * xas_split_alloc() does not support arbitrary orders. This implies no
+ * 512MB THP on ARM64 with 64KB base page size.
+ */
+#define MAX_XAS_ORDER		(XA_CHUNK_SHIFT * 2 - 1)
+#define MAX_PAGECACHE_ORDER	min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
+
 /**
  * mapping_set_large_folios() - Indicate the file supports large folios.
  * @mapping: The file.
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c459809efee4..64a4deb18dd0 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -532,6 +532,9 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @queue_empty: signal green light for opportunistically skipping the queue
  *	for spi_sync transfers.
  * @must_async: disable all fast paths in the core
+ * @defer_optimize_message: set to true if controller cannot pre-optimize messages
+ *	and needs to defer the optimization step until the message is actually
+ *	being transferred
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -775,6 +778,7 @@ struct spi_controller {
 	/* Flag for enabling opportunistic skipping of the queue in spi_sync */
 	bool			queue_empty;
 	bool			must_async;
+	bool			defer_optimize_message;
 };
 
 static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
diff --git a/include/linux/swap.h b/include/linux/swap.h
index f53d608daa01..7b5c33e5d846 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -344,7 +344,8 @@ static inline swp_entry_t page_swap_entry(struct page *page)
 }
 
 /* linux/mm/workingset.c */
-bool workingset_test_recent(void *shadow, bool file, bool *workingset);
+bool workingset_test_recent(void *shadow, bool file, bool *workingset,
+				bool flush);
 void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
 void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
 void workingset_refault(struct folio *folio, void *shadow);
diff --git a/include/net/tcx.h b/include/net/tcx.h
index 04be9377785d..0a5f40a91c42 100644
--- a/include/net/tcx.h
+++ b/include/net/tcx.h
@@ -13,7 +13,7 @@ struct mini_Qdisc;
 struct tcx_entry {
 	struct mini_Qdisc __rcu *miniq;
 	struct bpf_mprog_bundle bundle;
-	bool miniq_active;
+	u32 miniq_active;
 	struct rcu_head rcu;
 };
 
@@ -124,11 +124,16 @@ static inline void tcx_skeys_dec(bool ingress)
 	tcx_dec();
 }
 
-static inline void tcx_miniq_set_active(struct bpf_mprog_entry *entry,
-					const bool active)
+static inline void tcx_miniq_inc(struct bpf_mprog_entry *entry)
 {
 	ASSERT_RTNL();
-	tcx_entry(entry)->miniq_active = active;
+	tcx_entry(entry)->miniq_active++;
+}
+
+static inline void tcx_miniq_dec(struct bpf_mprog_entry *entry)
+{
+	ASSERT_RTNL();
+	tcx_entry(entry)->miniq_active--;
 }
 
 static inline bool tcx_entry_is_active(struct bpf_mprog_entry *entry)
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index f33d914d8f46..91583690bddc 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -8,11 +8,14 @@
 #define FASTRPC_IOCTL_ALLOC_DMA_BUFF	_IOWR('R', 1, struct fastrpc_alloc_dma_buf)
 #define FASTRPC_IOCTL_FREE_DMA_BUFF	_IOWR('R', 2, __u32)
 #define FASTRPC_IOCTL_INVOKE		_IOWR('R', 3, struct fastrpc_invoke)
+/* This ioctl is only supported with secure device nodes */
 #define FASTRPC_IOCTL_INIT_ATTACH	_IO('R', 4)
 #define FASTRPC_IOCTL_INIT_CREATE	_IOWR('R', 5, struct fastrpc_init_create)
 #define FASTRPC_IOCTL_MMAP		_IOWR('R', 6, struct fastrpc_req_mmap)
 #define FASTRPC_IOCTL_MUNMAP		_IOWR('R', 7, struct fastrpc_req_munmap)
+/* This ioctl is only supported with secure device nodes */
 #define FASTRPC_IOCTL_INIT_ATTACH_SNS	_IO('R', 8)
+/* This ioctl is only supported with secure device nodes */
 #define FASTRPC_IOCTL_INIT_CREATE_STATIC _IOWR('R', 9, struct fastrpc_init_create_static)
 #define FASTRPC_IOCTL_MEM_MAP		_IOWR('R', 10, struct fastrpc_mem_map)
 #define FASTRPC_IOCTL_MEM_UNMAP		_IOWR('R', 11, struct fastrpc_mem_unmap)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index bdea1a459153..bea5873d96d1 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -782,8 +782,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	nbuckets = max_t(u32, 2, nbuckets);
 	smap->bucket_log = ilog2(nbuckets);
 
-	smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
-					 nbuckets, GFP_USER | __GFP_NOWARN);
+	smap->buckets = bpf_map_kvcalloc(&smap->map, nbuckets,
+					 sizeof(*smap->buckets), GFP_USER | __GFP_NOWARN);
 	if (!smap->buckets) {
 		err = -ENOMEM;
 		goto free_smap;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 449b9a5d3fe3..6ad7a61c7617 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1079,11 +1079,23 @@ const struct bpf_func_proto bpf_snprintf_proto = {
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
+struct bpf_async_cb {
+	struct bpf_map *map;
+	struct bpf_prog *prog;
+	void __rcu *callback_fn;
+	void *value;
+	union {
+		struct rcu_head rcu;
+		struct work_struct delete_work;
+	};
+	u64 flags;
+};
+
 /* BPF map elements can contain 'struct bpf_timer'.
  * Such map owns all of its BPF timers.
  * 'struct bpf_timer' is allocated as part of map element allocation
  * and it's zero initialized.
- * That space is used to keep 'struct bpf_timer_kern'.
+ * That space is used to keep 'struct bpf_async_kern'.
  * bpf_timer_init() allocates 'struct bpf_hrtimer', inits hrtimer, and
  * remembers 'struct bpf_map *' pointer it's part of.
  * bpf_timer_set_callback() increments prog refcnt and assign bpf callback_fn.
@@ -1096,17 +1108,17 @@ const struct bpf_func_proto bpf_snprintf_proto = {
  * freeing the timers when inner map is replaced or deleted by user space.
  */
 struct bpf_hrtimer {
+	struct bpf_async_cb cb;
 	struct hrtimer timer;
-	struct bpf_map *map;
-	struct bpf_prog *prog;
-	void __rcu *callback_fn;
-	void *value;
-	struct rcu_head rcu;
+	atomic_t cancelling;
 };
 
 /* the actual struct hidden inside uapi struct bpf_timer */
-struct bpf_timer_kern {
-	struct bpf_hrtimer *timer;
+struct bpf_async_kern {
+	union {
+		struct bpf_async_cb *cb;
+		struct bpf_hrtimer *timer;
+	};
 	/* bpf_spin_lock is used here instead of spinlock_t to make
 	 * sure that it always fits into space reserved by struct bpf_timer
 	 * regardless of LOCKDEP and spinlock debug flags.
@@ -1114,19 +1126,23 @@ struct bpf_timer_kern {
 	struct bpf_spin_lock lock;
 } __attribute__((aligned(8)));
 
+enum bpf_async_type {
+	BPF_ASYNC_TYPE_TIMER = 0,
+};
+
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 {
 	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);
-	struct bpf_map *map = t->map;
-	void *value = t->value;
+	struct bpf_map *map = t->cb.map;
+	void *value = t->cb.value;
 	bpf_callback_t callback_fn;
 	void *key;
 	u32 idx;
 
 	BTF_TYPE_EMIT(struct bpf_timer);
-	callback_fn = rcu_dereference_check(t->callback_fn, rcu_read_lock_bh_held());
+	callback_fn = rcu_dereference_check(t->cb.callback_fn, rcu_read_lock_bh_held());
 	if (!callback_fn)
 		goto out;
 
@@ -1155,46 +1171,72 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
 
-BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map,
-	   u64, flags)
+static void bpf_timer_delete_work(struct work_struct *work)
 {
-	clockid_t clockid = flags & (MAX_CLOCKS - 1);
+	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, cb.delete_work);
+
+	/* Cancel the timer and wait for callback to complete if it was running.
+	 * If hrtimer_cancel() can be safely called it's safe to call
+	 * kfree_rcu(t) right after for both preallocated and non-preallocated
+	 * maps.  The async->cb = NULL was already done and no code path can see
+	 * address 't' anymore. Timer if armed for existing bpf_hrtimer before
+	 * bpf_timer_cancel_and_free will have been cancelled.
+	 */
+	hrtimer_cancel(&t->timer);
+	kfree_rcu(t, cb.rcu);
+}
+
+static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
+			    enum bpf_async_type type)
+{
+	struct bpf_async_cb *cb;
 	struct bpf_hrtimer *t;
+	clockid_t clockid;
+	size_t size;
 	int ret = 0;
 
-	BUILD_BUG_ON(MAX_CLOCKS != 16);
-	BUILD_BUG_ON(sizeof(struct bpf_timer_kern) > sizeof(struct bpf_timer));
-	BUILD_BUG_ON(__alignof__(struct bpf_timer_kern) != __alignof__(struct bpf_timer));
-
 	if (in_nmi())
 		return -EOPNOTSUPP;
 
-	if (flags >= MAX_CLOCKS ||
-	    /* similar to timerfd except _ALARM variants are not supported */
-	    (clockid != CLOCK_MONOTONIC &&
-	     clockid != CLOCK_REALTIME &&
-	     clockid != CLOCK_BOOTTIME))
+	switch (type) {
+	case BPF_ASYNC_TYPE_TIMER:
+		size = sizeof(struct bpf_hrtimer);
+		break;
+	default:
 		return -EINVAL;
-	__bpf_spin_lock_irqsave(&timer->lock);
-	t = timer->timer;
+	}
+
+	__bpf_spin_lock_irqsave(&async->lock);
+	t = async->timer;
 	if (t) {
 		ret = -EBUSY;
 		goto out;
 	}
+
 	/* allocate hrtimer via map_kmalloc to use memcg accounting */
-	t = bpf_map_kmalloc_node(map, sizeof(*t), GFP_ATOMIC, map->numa_node);
-	if (!t) {
+	cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
+	if (!cb) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	t->value = (void *)timer - map->record->timer_off;
-	t->map = map;
-	t->prog = NULL;
-	rcu_assign_pointer(t->callback_fn, NULL);
-	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
-	t->timer.function = bpf_timer_cb;
-	WRITE_ONCE(timer->timer, t);
-	/* Guarantee the order between timer->timer and map->usercnt. So
+
+	if (type == BPF_ASYNC_TYPE_TIMER) {
+		clockid = flags & (MAX_CLOCKS - 1);
+		t = (struct bpf_hrtimer *)cb;
+
+		atomic_set(&t->cancelling, 0);
+		INIT_WORK(&t->cb.delete_work, bpf_timer_delete_work);
+		hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
+		t->timer.function = bpf_timer_cb;
+		cb->value = (void *)async - map->record->timer_off;
+	}
+	cb->map = map;
+	cb->prog = NULL;
+	cb->flags = flags;
+	rcu_assign_pointer(cb->callback_fn, NULL);
+
+	WRITE_ONCE(async->cb, cb);
+	/* Guarantee the order between async->cb and map->usercnt. So
 	 * when there are concurrent uref release and bpf timer init, either
 	 * bpf_timer_cancel_and_free() called by uref release reads a no-NULL
 	 * timer or atomic64_read() below returns a zero usercnt.
@@ -1204,15 +1246,34 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 		/* maps with timers must be either held by user space
 		 * or pinned in bpffs.
 		 */
-		WRITE_ONCE(timer->timer, NULL);
-		kfree(t);
+		WRITE_ONCE(async->cb, NULL);
+		kfree(cb);
 		ret = -EPERM;
 	}
 out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
+	__bpf_spin_unlock_irqrestore(&async->lock);
 	return ret;
 }
 
+BPF_CALL_3(bpf_timer_init, struct bpf_async_kern *, timer, struct bpf_map *, map,
+	   u64, flags)
+{
+	clock_t clockid = flags & (MAX_CLOCKS - 1);
+
+	BUILD_BUG_ON(MAX_CLOCKS != 16);
+	BUILD_BUG_ON(sizeof(struct bpf_async_kern) > sizeof(struct bpf_timer));
+	BUILD_BUG_ON(__alignof__(struct bpf_async_kern) != __alignof__(struct bpf_timer));
+
+	if (flags >= MAX_CLOCKS ||
+	    /* similar to timerfd except _ALARM variants are not supported */
+	    (clockid != CLOCK_MONOTONIC &&
+	     clockid != CLOCK_REALTIME &&
+	     clockid != CLOCK_BOOTTIME))
+		return -EINVAL;
+
+	return __bpf_async_init(timer, map, flags, BPF_ASYNC_TYPE_TIMER);
+}
+
 static const struct bpf_func_proto bpf_timer_init_proto = {
 	.func		= bpf_timer_init,
 	.gpl_only	= true,
@@ -1222,7 +1283,7 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callback_fn,
+BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,
 	   struct bpf_prog_aux *, aux)
 {
 	struct bpf_prog *prev, *prog = aux->prog;
@@ -1237,7 +1298,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
 		ret = -EINVAL;
 		goto out;
 	}
-	if (!atomic64_read(&t->map->usercnt)) {
+	if (!atomic64_read(&t->cb.map->usercnt)) {
 		/* maps with timers must be either held by user space
 		 * or pinned in bpffs. Otherwise timer might still be
 		 * running even when bpf prog is detached and user space
@@ -1246,7 +1307,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
 		ret = -EPERM;
 		goto out;
 	}
-	prev = t->prog;
+	prev = t->cb.prog;
 	if (prev != prog) {
 		/* Bump prog refcnt once. Every bpf_timer_set_callback()
 		 * can pick different callback_fn-s within the same prog.
@@ -1259,9 +1320,9 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
 		if (prev)
 			/* Drop prev prog refcnt when swapping with new prog */
 			bpf_prog_put(prev);
-		t->prog = prog;
+		t->cb.prog = prog;
 	}
-	rcu_assign_pointer(t->callback_fn, callback_fn);
+	rcu_assign_pointer(t->cb.callback_fn, callback_fn);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	return ret;
@@ -1275,7 +1336,7 @@ static const struct bpf_func_proto bpf_timer_set_callback_proto = {
 	.arg2_type	= ARG_PTR_TO_FUNC,
 };
 
-BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, flags)
+BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, flags)
 {
 	struct bpf_hrtimer *t;
 	int ret = 0;
@@ -1287,7 +1348,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 		return -EINVAL;
 	__bpf_spin_lock_irqsave(&timer->lock);
 	t = timer->timer;
-	if (!t || !t->prog) {
+	if (!t || !t->cb.prog) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1315,20 +1376,21 @@ static const struct bpf_func_proto bpf_timer_start_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static void drop_prog_refcnt(struct bpf_hrtimer *t)
+static void drop_prog_refcnt(struct bpf_async_cb *async)
 {
-	struct bpf_prog *prog = t->prog;
+	struct bpf_prog *prog = async->prog;
 
 	if (prog) {
 		bpf_prog_put(prog);
-		t->prog = NULL;
-		rcu_assign_pointer(t->callback_fn, NULL);
+		async->prog = NULL;
+		rcu_assign_pointer(async->callback_fn, NULL);
 	}
 }
 
-BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
+BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 {
-	struct bpf_hrtimer *t;
+	struct bpf_hrtimer *t, *cur_t;
+	bool inc = false;
 	int ret = 0;
 
 	if (in_nmi())
@@ -1340,21 +1402,50 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 		ret = -EINVAL;
 		goto out;
 	}
-	if (this_cpu_read(hrtimer_running) == t) {
+
+	cur_t = this_cpu_read(hrtimer_running);
+	if (cur_t == t) {
 		/* If bpf callback_fn is trying to bpf_timer_cancel()
 		 * its own timer the hrtimer_cancel() will deadlock
-		 * since it waits for callback_fn to finish
+		 * since it waits for callback_fn to finish.
+		 */
+		ret = -EDEADLK;
+		goto out;
+	}
+
+	/* Only account in-flight cancellations when invoked from a timer
+	 * callback, since we want to avoid waiting only if other _callbacks_
+	 * are waiting on us, to avoid introducing lockups. Non-callback paths
+	 * are ok, since nobody would synchronously wait for their completion.
+	 */
+	if (!cur_t)
+		goto drop;
+	atomic_inc(&t->cancelling);
+	/* Need full barrier after relaxed atomic_inc */
+	smp_mb__after_atomic();
+	inc = true;
+	if (atomic_read(&cur_t->cancelling)) {
+		/* We're cancelling timer t, while some other timer callback is
+		 * attempting to cancel us. In such a case, it might be possible
+		 * that timer t belongs to the other callback, or some other
+		 * callback waiting upon it (creating transitive dependencies
+		 * upon us), and we will enter a deadlock if we continue
+		 * cancelling and waiting for it synchronously, since it might
+		 * do the same. Bail!
 		 */
 		ret = -EDEADLK;
 		goto out;
 	}
-	drop_prog_refcnt(t);
+drop:
+	drop_prog_refcnt(&t->cb);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	/* Cancel the timer and wait for associated callback to finish
 	 * if it was running.
 	 */
 	ret = ret ?: hrtimer_cancel(&t->timer);
+	if (inc)
+		atomic_dec(&t->cancelling);
 	rcu_read_unlock();
 	return ret;
 }
@@ -1371,7 +1462,7 @@ static const struct bpf_func_proto bpf_timer_cancel_proto = {
  */
 void bpf_timer_cancel_and_free(void *val)
 {
-	struct bpf_timer_kern *timer = val;
+	struct bpf_async_kern *timer = val;
 	struct bpf_hrtimer *t;
 
 	/* Performance optimization: read timer->timer without lock first. */
@@ -1383,7 +1474,7 @@ void bpf_timer_cancel_and_free(void *val)
 	t = timer->timer;
 	if (!t)
 		goto out;
-	drop_prog_refcnt(t);
+	drop_prog_refcnt(&t->cb);
 	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
 	 * this timer, since it won't be initialized.
 	 */
@@ -1392,25 +1483,39 @@ void bpf_timer_cancel_and_free(void *val)
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	if (!t)
 		return;
-	/* Cancel the timer and wait for callback to complete if it was running.
-	 * If hrtimer_cancel() can be safely called it's safe to call kfree(t)
-	 * right after for both preallocated and non-preallocated maps.
-	 * The timer->timer = NULL was already done and no code path can
-	 * see address 't' anymore.
-	 *
-	 * Check that bpf_map_delete/update_elem() wasn't called from timer
-	 * callback_fn. In such case don't call hrtimer_cancel() (since it will
-	 * deadlock) and don't call hrtimer_try_to_cancel() (since it will just
-	 * return -1). Though callback_fn is still running on this cpu it's
+	/* We check that bpf_map_delete/update_elem() was called from timer
+	 * callback_fn. In such case we don't call hrtimer_cancel() (since it
+	 * will deadlock) and don't call hrtimer_try_to_cancel() (since it will
+	 * just return -1). Though callback_fn is still running on this cpu it's
 	 * safe to do kfree(t) because bpf_timer_cb() read everything it needed
 	 * from 't'. The bpf subprog callback_fn won't be able to access 't',
 	 * since timer->timer = NULL was already done. The timer will be
 	 * effectively cancelled because bpf_timer_cb() will return
 	 * HRTIMER_NORESTART.
+	 *
+	 * However, it is possible the timer callback_fn calling us armed the
+	 * timer _before_ calling us, such that failing to cancel it here will
+	 * cause it to possibly use struct hrtimer after freeing bpf_hrtimer.
+	 * Therefore, we _need_ to cancel any outstanding timers before we do
+	 * kfree_rcu, even though no more timers can be armed.
+	 *
+	 * Moreover, we need to schedule work even if timer does not belong to
+	 * the calling callback_fn, as on two different CPUs, we can end up in a
+	 * situation where both sides run in parallel, try to cancel one
+	 * another, and we end up waiting on both sides in hrtimer_cancel
+	 * without making forward progress, since timer1 depends on time2
+	 * callback to finish, and vice versa.
+	 *
+	 *  CPU 1 (timer1_cb)			CPU 2 (timer2_cb)
+	 *  bpf_timer_cancel_and_free(timer2)	bpf_timer_cancel_and_free(timer1)
+	 *
+	 * To avoid these issues, punt to workqueue context when we are in a
+	 * timer callback.
 	 */
-	if (this_cpu_read(hrtimer_running) != t)
-		hrtimer_cancel(&t->timer);
-	kfree_rcu(t, rcu);
+	if (this_cpu_read(hrtimer_running))
+		queue_work(system_unbound_wq, &t->cb.delete_work);
+	else
+		bpf_timer_delete_work(&t->cb.delete_work);
 }
 
 BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a04a436af8cc..dce51bf2d322 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1805,8 +1805,13 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 			 * The replenish timer needs to be canceled. No
 			 * problem if it fires concurrently: boosted threads
 			 * are ignored in dl_task_timer().
+			 *
+			 * If the timer callback was running (hrtimer_try_to_cancel == -1),
+			 * it will eventually call put_task_struct().
 			 */
-			hrtimer_try_to_cancel(&p->dl.dl_timer);
+			if (hrtimer_try_to_cancel(&p->dl.dl_timer) == 1 &&
+			    !dl_server(&p->dl))
+				put_task_struct(p);
 			p->dl.dl_throttled = 0;
 		}
 	} else if (!dl_prio(p->normal_prio)) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 213c94d027a4..98d03b34a817 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9106,12 +9106,8 @@ static int detach_tasks(struct lb_env *env)
 			break;
 
 		env->loop++;
-		/*
-		 * We've more or less seen every task there is, call it quits
-		 * unless we haven't found any movable task yet.
-		 */
-		if (env->loop > env->loop_max &&
-		    !(env->flags & LBF_ALL_PINNED))
+		/* We've more or less seen every task there is, call it quits */
+		if (env->loop > env->loop_max)
 			break;
 
 		/* take a breather every nr_migrate tasks */
@@ -11363,9 +11359,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 
 		if (env.flags & LBF_NEED_BREAK) {
 			env.flags &= ~LBF_NEED_BREAK;
-			/* Stop if we tried all running tasks */
-			if (env.loop < busiest->nr_running)
-				goto more_balance;
+			goto more_balance;
 		}
 
 		/*
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6d503c1c125e..d6f7e14abd6d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1357,14 +1357,31 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
  * access frequencies are similar.  This is for minimizing the monitoring
  * overhead under the dynamically changeable access pattern.  If a merge was
  * unnecessarily made, later 'kdamond_split_regions()' will revert it.
+ *
+ * The total number of regions could be higher than the user-defined limit,
+ * max_nr_regions for some cases.  For example, the user can update
+ * max_nr_regions to a number that lower than the current number of regions
+ * while DAMON is running.  For such a case, repeat merging until the limit is
+ * met while increasing @threshold up to possible maximum level.
  */
 static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 				  unsigned long sz_limit)
 {
 	struct damon_target *t;
-
-	damon_for_each_target(t, c)
-		damon_merge_regions_of(t, threshold, sz_limit);
+	unsigned int nr_regions;
+	unsigned int max_thres;
+
+	max_thres = c->attrs.aggr_interval /
+		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
+	do {
+		nr_regions = 0;
+		damon_for_each_target(t, c) {
+			damon_merge_regions_of(t, threshold, sz_limit);
+			nr_regions += damon_nr_regions(t);
+		}
+		threshold = max(1, threshold * 2);
+	} while (nr_regions > c->attrs.max_nr_regions &&
+			threshold / 2 < max_thres);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 30de18c4fd28..41bf94f7dbd1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3100,7 +3100,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* Use the readahead code, even if readahead is disabled */
-	if (vm_flags & VM_HUGEPAGE) {
+	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
 		ra->size = HPAGE_PMD_NR;
@@ -3207,7 +3207,8 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
 		return 0;
 
-	ptep = pte_offset_map(vmf->pmd, vmf->address);
+	ptep = pte_offset_map_nolock(vma->vm_mm, vmf->pmd, vmf->address,
+				     &vmf->ptl);
 	if (unlikely(!ptep))
 		return VM_FAULT_NOPAGE;
 
@@ -4153,6 +4154,9 @@ static void filemap_cachestat(struct address_space *mapping,
 	XA_STATE(xas, &mapping->i_pages, first_index);
 	struct folio *folio;
 
+	/* Flush stats (and potentially sleep) outside the RCU read section. */
+	mem_cgroup_flush_stats_ratelimited(NULL);
+
 	rcu_read_lock();
 	xas_for_each(&xas, folio, last_index) {
 		int order;
@@ -4216,7 +4220,7 @@ static void filemap_cachestat(struct address_space *mapping,
 					goto resched;
 			}
 #endif
-			if (workingset_test_recent(shadow, true, &workingset))
+			if (workingset_test_recent(shadow, true, &workingset, false))
 				cs->nr_recently_evicted += nr_pages;
 
 			goto resched;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 612558f306f4..d960151da50c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7609,17 +7609,6 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 
 	/* Transfer the charge and the css ref */
 	commit_charge(new, memcg);
-	/*
-	 * If the old folio is a large folio and is in the split queue, it needs
-	 * to be removed from the split queue now, in case getting an incorrect
-	 * split queue in destroy_large_folio() after the memcg of the old folio
-	 * is cleared.
-	 *
-	 * In addition, the old folio is about to be freed after migration, so
-	 * removing from the split queue a bit earlier seems reasonable.
-	 */
-	if (folio_test_large(old) && folio_test_large_rmappable(old))
-		folio_undo_large_rmappable(old);
 	old->memcg_data = 0;
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 73a052a382f1..8f99fcea99e4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -415,6 +415,15 @@ int folio_migrate_mapping(struct address_space *mapping,
 		if (folio_ref_count(folio) != expected_count)
 			return -EAGAIN;
 
+		/* Take off deferred split queue while frozen and memcg set */
+		if (folio_test_large(folio) &&
+		    folio_test_large_rmappable(folio)) {
+			if (!folio_ref_freeze(folio, expected_count))
+				return -EAGAIN;
+			folio_undo_large_rmappable(folio);
+			folio_ref_unfreeze(folio, expected_count);
+		}
+
 		/* No turning back from here */
 		newfolio->index = folio->index;
 		newfolio->mapping = folio->mapping;
@@ -433,6 +442,10 @@ int folio_migrate_mapping(struct address_space *mapping,
 		return -EAGAIN;
 	}
 
+	/* Take off deferred split queue while frozen and memcg set */
+	if (folio_test_large(folio) && folio_test_large_rmappable(folio))
+		folio_undo_large_rmappable(folio);
+
 	/*
 	 * Now we know that no one else is looking at the folio:
 	 * no turning back from here.
diff --git a/mm/readahead.c b/mm/readahead.c
index d55138e9560b..e5d0a56218de 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -499,11 +499,11 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	limit = min(limit, index + ra->size - 1);
 
-	if (new_order < MAX_PAGECACHE_ORDER) {
+	if (new_order < MAX_PAGECACHE_ORDER)
 		new_order += 2;
-		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
-		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
-	}
+
+	new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
+	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
 
 	/* See comment in page_cache_ra_unbounded() */
 	nofs = memalloc_nofs_save();
diff --git a/mm/shmem.c b/mm/shmem.c
index b66e99e2c70f..324843224690 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -541,8 +541,9 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
-bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
-		   struct mm_struct *mm, unsigned long vm_flags)
+static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
+			    bool shmem_huge_force, struct mm_struct *mm,
+			    unsigned long vm_flags)
 {
 	loff_t i_size;
 
@@ -573,6 +574,16 @@ bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
 	}
 }
 
+bool shmem_is_huge(struct inode *inode, pgoff_t index,
+		   bool shmem_huge_force, struct mm_struct *mm,
+		   unsigned long vm_flags)
+{
+	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
+		return false;
+
+	return __shmem_is_huge(inode, index, shmem_huge_force, mm, vm_flags);
+}
+
 #if defined(CONFIG_SYSFS)
 static int shmem_parse_huge(const char *str)
 {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 2cd015e97610..03c78fae06f3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2519,7 +2519,15 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
 static struct xarray *
 addr_to_vb_xa(unsigned long addr)
 {
-	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
+
+	/*
+	 * Please note, nr_cpu_ids points on a highest set
+	 * possible bit, i.e. we never invoke cpumask_next()
+	 * if an index points on it which is nr_cpu_ids - 1.
+	 */
+	if (!cpu_possible(index))
+		index = cpumask_next(index, cpu_possible_mask);
 
 	return &per_cpu(vmap_block_queue, index).vmap_blocks;
 }
diff --git a/mm/workingset.c b/mm/workingset.c
index f2a0ecaf708d..8a044921ed7a 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -412,10 +412,12 @@ void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
  * @file: whether the corresponding folio is from the file lru.
  * @workingset: where the workingset value unpacked from shadow should
  * be stored.
+ * @flush: whether to flush cgroup rstat.
  *
  * Return: true if the shadow is for a recently evicted folio; false otherwise.
  */
-bool workingset_test_recent(void *shadow, bool file, bool *workingset)
+bool workingset_test_recent(void *shadow, bool file, bool *workingset,
+				bool flush)
 {
 	struct mem_cgroup *eviction_memcg;
 	struct lruvec *eviction_lruvec;
@@ -467,10 +469,16 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 
 	/*
 	 * Flush stats (and potentially sleep) outside the RCU read section.
+	 *
+	 * Note that workingset_test_recent() itself might be called in RCU read
+	 * section (for e.g, in cachestat) - these callers need to skip flushing
+	 * stats (via the flush argument).
+	 *
 	 * XXX: With per-memcg flushing and thresholding, is ratelimiting
 	 * still needed here?
 	 */
-	mem_cgroup_flush_stats_ratelimited(eviction_memcg);
+	if (flush)
+		mem_cgroup_flush_stats_ratelimited(eviction_memcg);
 
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
 	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
@@ -558,7 +566,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
-	if (!workingset_test_recent(shadow, file, &workingset))
+	if (!workingset_test_recent(shadow, file, &workingset, true))
 		return;
 
 	folio_set_active(folio);
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index f263f7e91a21..ab66b599ac47 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1085,13 +1085,19 @@ static void delayed_work(struct work_struct *work)
 	struct ceph_mon_client *monc =
 		container_of(work, struct ceph_mon_client, delayed_work.work);
 
-	dout("monc delayed_work\n");
 	mutex_lock(&monc->mutex);
+	dout("%s mon%d\n", __func__, monc->cur_mon);
+	if (monc->cur_mon < 0) {
+		goto out;
+	}
+
 	if (monc->hunting) {
 		dout("%s continuing hunt\n", __func__);
 		reopen_session(monc);
 	} else {
 		int is_auth = ceph_auth_is_authenticated(monc->auth);
+
+		dout("%s is_authed %d\n", __func__, is_auth);
 		if (ceph_con_keepalive_expired(&monc->con,
 					       CEPH_MONC_PING_TIMEOUT)) {
 			dout("monc keepalive timeout\n");
@@ -1116,6 +1122,8 @@ static void delayed_work(struct work_struct *work)
 		}
 	}
 	__schedule_delayed(monc);
+
+out:
 	mutex_unlock(&monc->mutex);
 }
 
@@ -1232,13 +1240,15 @@ EXPORT_SYMBOL(ceph_monc_init);
 void ceph_monc_stop(struct ceph_mon_client *monc)
 {
 	dout("stop\n");
-	cancel_delayed_work_sync(&monc->delayed_work);
 
 	mutex_lock(&monc->mutex);
 	__close_session(monc);
+	monc->hunting = false;
 	monc->cur_mon = -1;
 	mutex_unlock(&monc->mutex);
 
+	cancel_delayed_work_sync(&monc->delayed_work);
+
 	/*
 	 * flush msgr queue before we destroy ourselves to ensure that:
 	 *  - any work that references our embedded con is finished.
diff --git a/net/core/datagram.c b/net/core/datagram.c
index cb72923acc21..99abfafb0b43 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -442,11 +442,12 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 			if (copy > len)
 				copy = len;
 
+			n = 0;
 			skb_frag_foreach_page(frag,
 					      skb_frag_off(frag) + offset - start,
 					      copy, p, p_off, p_len, copied) {
 				vaddr = kmap_local_page(p);
-				n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
+				n += INDIRECT_CALL_1(cb, simple_copy_to_iter,
 					vaddr + p_off, p_len, data, to);
 				kunmap_local(vaddr);
 			}
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index fd20aae30be2..bbf40b999713 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -434,7 +434,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 			page = sg_page(sge);
 			if (copied + copy > len)
 				copy = len - copied;
-			copy = copy_page_to_iter(page, sge->offset, copy, iter);
+			if (copy)
+				copy = copy_page_to_iter(page, sge->offset, copy, iter);
 			if (!copy) {
 				copied = copied ? copied : -EFAULT;
 				goto out;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index e645d751a5e8..223dcd25d88a 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1306,7 +1306,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (rxfh.input_xfrm && rxfh.input_xfrm != RXH_XFRM_SYM_XOR &&
 	    rxfh.input_xfrm != RXH_XFRM_NO_CHANGE)
 		return -EINVAL;
-	if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
+	if (rxfh.input_xfrm != RXH_XFRM_NO_CHANGE &&
+	    (rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
 	    !ops->cap_rss_sym_xor_supported)
 		return -EOPNOTSUPP;
 
diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index b2de2108b356..34d76e87847d 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -37,6 +37,8 @@ static int linkstate_get_sqi(struct net_device *dev)
 	mutex_lock(&phydev->lock);
 	if (!phydev->drv || !phydev->drv->get_sqi)
 		ret = -EOPNOTSUPP;
+	else if (!phydev->link)
+		ret = -ENETDOWN;
 	else
 		ret = phydev->drv->get_sqi(phydev);
 	mutex_unlock(&phydev->lock);
@@ -55,6 +57,8 @@ static int linkstate_get_sqi_max(struct net_device *dev)
 	mutex_lock(&phydev->lock);
 	if (!phydev->drv || !phydev->drv->get_sqi_max)
 		ret = -EOPNOTSUPP;
+	else if (!phydev->link)
+		ret = -ENETDOWN;
 	else
 		ret = phydev->drv->get_sqi_max(phydev);
 	mutex_unlock(&phydev->lock);
@@ -62,6 +66,17 @@ static int linkstate_get_sqi_max(struct net_device *dev)
 	return ret;
 };
 
+static bool linkstate_sqi_critical_error(int sqi)
+{
+	return sqi < 0 && sqi != -EOPNOTSUPP && sqi != -ENETDOWN;
+}
+
+static bool linkstate_sqi_valid(struct linkstate_reply_data *data)
+{
+	return data->sqi >= 0 && data->sqi_max >= 0 &&
+	       data->sqi <= data->sqi_max;
+}
+
 static int linkstate_get_link_ext_state(struct net_device *dev,
 					struct linkstate_reply_data *data)
 {
@@ -93,12 +108,12 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 	data->link = __ethtool_get_link(dev);
 
 	ret = linkstate_get_sqi(dev);
-	if (ret < 0 && ret != -EOPNOTSUPP)
+	if (linkstate_sqi_critical_error(ret))
 		goto out;
 	data->sqi = ret;
 
 	ret = linkstate_get_sqi_max(dev);
-	if (ret < 0 && ret != -EOPNOTSUPP)
+	if (linkstate_sqi_critical_error(ret))
 		goto out;
 	data->sqi_max = ret;
 
@@ -136,11 +151,10 @@ static int linkstate_reply_size(const struct ethnl_req_info *req_base,
 	len = nla_total_size(sizeof(u8)) /* LINKSTATE_LINK */
 		+ 0;
 
-	if (data->sqi != -EOPNOTSUPP)
-		len += nla_total_size(sizeof(u32));
-
-	if (data->sqi_max != -EOPNOTSUPP)
-		len += nla_total_size(sizeof(u32));
+	if (linkstate_sqi_valid(data)) {
+		len += nla_total_size(sizeof(u32)); /* LINKSTATE_SQI */
+		len += nla_total_size(sizeof(u32)); /* LINKSTATE_SQI_MAX */
+	}
 
 	if (data->link_ext_state_provided)
 		len += nla_total_size(sizeof(u8)); /* LINKSTATE_EXT_STATE */
@@ -164,13 +178,14 @@ static int linkstate_fill_reply(struct sk_buff *skb,
 	    nla_put_u8(skb, ETHTOOL_A_LINKSTATE_LINK, !!data->link))
 		return -EMSGSIZE;
 
-	if (data->sqi != -EOPNOTSUPP &&
-	    nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI, data->sqi))
-		return -EMSGSIZE;
+	if (linkstate_sqi_valid(data)) {
+		if (nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI, data->sqi))
+			return -EMSGSIZE;
 
-	if (data->sqi_max != -EOPNOTSUPP &&
-	    nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI_MAX, data->sqi_max))
-		return -EMSGSIZE;
+		if (nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI_MAX,
+				data->sqi_max))
+			return -EMSGSIZE;
+	}
 
 	if (data->link_ext_state_provided) {
 		if (nla_put_u8(skb, ETHTOOL_A_LINKSTATE_EXT_STATE,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7b692bcb61d4..c765d479869d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2126,8 +2126,16 @@ void tcp_clear_retrans(struct tcp_sock *tp)
 static inline void tcp_init_undo(struct tcp_sock *tp)
 {
 	tp->undo_marker = tp->snd_una;
+
 	/* Retransmission still in flight may cause DSACKs later. */
-	tp->undo_retrans = tp->retrans_out ? : -1;
+	/* First, account for regular retransmits in flight: */
+	tp->undo_retrans = tp->retrans_out;
+	/* Next, account for TLP retransmits in flight: */
+	if (tp->tlp_high_seq && tp->tlp_retrans)
+		tp->undo_retrans++;
+	/* Finally, avoid 0, because undo_retrans==0 means "can undo now": */
+	if (!tp->undo_retrans)
+		tp->undo_retrans = -1;
 }
 
 static bool tcp_is_rack(const struct sock *sk)
@@ -2206,6 +2214,7 @@ void tcp_enter_loss(struct sock *sk)
 
 	tcp_set_ca_state(sk, TCP_CA_Loss);
 	tp->high_seq = tp->snd_nxt;
+	tp->tlp_high_seq = 0;
 	tcp_ecn_queue_cwr(tp);
 
 	/* F-RTO RFC5682 sec 3.1 step 1: retransmit SND.UNA if no previous
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index f96f68cf7961..cceb4fabd4c8 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -481,15 +481,26 @@ static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
 				     const struct sk_buff *skb,
 				     u32 rtx_delta)
 {
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+	u32 user_timeout = READ_ONCE(icsk->icsk_user_timeout);
 	const struct tcp_sock *tp = tcp_sk(sk);
-	const int timeout = TCP_RTO_MAX * 2;
+	int timeout = TCP_RTO_MAX * 2;
 	s32 rcv_delta;
 
+	if (user_timeout) {
+		/* If user application specified a TCP_USER_TIMEOUT,
+		 * it does not want win 0 packets to 'reset the timer'
+		 * while retransmits are not making progress.
+		 */
+		if (rtx_delta > user_timeout)
+			return true;
+		timeout = min_t(u32, timeout, msecs_to_jiffies(user_timeout));
+	}
 	/* Note: timer interrupt might have been delayed by at least one jiffy,
 	 * and tp->rcv_tstamp might very well have been written recently.
 	 * rcv_delta can thus be negative.
 	 */
-	rcv_delta = inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
+	rcv_delta = icsk->icsk_timeout - tp->rcv_tstamp;
 	if (rcv_delta <= timeout)
 		return false;
 
@@ -534,8 +545,6 @@ void tcp_retransmit_timer(struct sock *sk)
 	if (WARN_ON_ONCE(!skb))
 		return;
 
-	tp->tlp_high_seq = 0;
-
 	if (!tp->snd_wnd && !sock_flag(sk, SOCK_DEAD) &&
 	    !((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))) {
 		/* Receiver dastardly shrinks window. Our retransmits
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 72d3bf136810..fb71bf3b12b4 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -326,6 +326,8 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 			goto fail_unlock;
 		}
 
+		sock_set_flag(sk, SOCK_RCU_FREE);
+
 		sk_add_node_rcu(sk, &hslot->head);
 		hslot->count++;
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
@@ -342,7 +344,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 		hslot2->count++;
 		spin_unlock(&hslot2->lock);
 	}
-	sock_set_flag(sk, SOCK_RCU_FREE);
+
 	error = 0;
 fail_unlock:
 	spin_unlock_bh(&hslot->lock);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0f77ba3306c2..d129b826924e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3823,6 +3823,15 @@ static void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *r
 	nf_tables_rule_destroy(ctx, rule);
 }
 
+/** nft_chain_validate - loop detection and hook validation
+ *
+ * @ctx: context containing call depth and base chain
+ * @chain: chain to validate
+ *
+ * Walk through the rules of the given chain and chase all jumps/gotos
+ * and set lookups until either the jump limit is hit or all reachable
+ * chains have been validated.
+ */
 int nft_chain_validate(const struct nft_ctx *ctx, const struct nft_chain *chain)
 {
 	struct nft_expr *expr, *last;
@@ -3844,6 +3853,9 @@ int nft_chain_validate(const struct nft_ctx *ctx, const struct nft_chain *chain)
 			if (!expr->ops->validate)
 				continue;
 
+			/* This may call nft_chain_validate() recursively,
+			 * callers that do so must increment ctx->level.
+			 */
 			err = expr->ops->validate(ctx, expr, &data);
 			if (err < 0)
 				return err;
@@ -10805,150 +10817,6 @@ int nft_chain_validate_hooks(const struct nft_chain *chain,
 }
 EXPORT_SYMBOL_GPL(nft_chain_validate_hooks);
 
-/*
- * Loop detection - walk through the ruleset beginning at the destination chain
- * of a new jump until either the source chain is reached (loop) or all
- * reachable chains have been traversed.
- *
- * The loop check is performed whenever a new jump verdict is added to an
- * expression or verdict map or a verdict map is bound to a new chain.
- */
-
-static int nf_tables_check_loops(const struct nft_ctx *ctx,
-				 const struct nft_chain *chain);
-
-static int nft_check_loops(const struct nft_ctx *ctx,
-			   const struct nft_set_ext *ext)
-{
-	const struct nft_data *data;
-	int ret;
-
-	data = nft_set_ext_data(ext);
-	switch (data->verdict.code) {
-	case NFT_JUMP:
-	case NFT_GOTO:
-		ret = nf_tables_check_loops(ctx, data->verdict.chain);
-		break;
-	default:
-		ret = 0;
-		break;
-	}
-
-	return ret;
-}
-
-static int nf_tables_loop_check_setelem(const struct nft_ctx *ctx,
-					struct nft_set *set,
-					const struct nft_set_iter *iter,
-					struct nft_elem_priv *elem_priv)
-{
-	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem_priv);
-
-	if (!nft_set_elem_active(ext, iter->genmask))
-		return 0;
-
-	if (nft_set_ext_exists(ext, NFT_SET_EXT_FLAGS) &&
-	    *nft_set_ext_flags(ext) & NFT_SET_ELEM_INTERVAL_END)
-		return 0;
-
-	return nft_check_loops(ctx, ext);
-}
-
-static int nft_set_catchall_loops(const struct nft_ctx *ctx,
-				  struct nft_set *set)
-{
-	u8 genmask = nft_genmask_next(ctx->net);
-	struct nft_set_elem_catchall *catchall;
-	struct nft_set_ext *ext;
-	int ret = 0;
-
-	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
-		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_set_elem_active(ext, genmask))
-			continue;
-
-		ret = nft_check_loops(ctx, ext);
-		if (ret < 0)
-			return ret;
-	}
-
-	return ret;
-}
-
-static int nf_tables_check_loops(const struct nft_ctx *ctx,
-				 const struct nft_chain *chain)
-{
-	const struct nft_rule *rule;
-	const struct nft_expr *expr, *last;
-	struct nft_set *set;
-	struct nft_set_binding *binding;
-	struct nft_set_iter iter;
-
-	if (ctx->chain == chain)
-		return -ELOOP;
-
-	if (fatal_signal_pending(current))
-		return -EINTR;
-
-	list_for_each_entry(rule, &chain->rules, list) {
-		nft_rule_for_each_expr(expr, last, rule) {
-			struct nft_immediate_expr *priv;
-			const struct nft_data *data;
-			int err;
-
-			if (strcmp(expr->ops->type->name, "immediate"))
-				continue;
-
-			priv = nft_expr_priv(expr);
-			if (priv->dreg != NFT_REG_VERDICT)
-				continue;
-
-			data = &priv->data;
-			switch (data->verdict.code) {
-			case NFT_JUMP:
-			case NFT_GOTO:
-				err = nf_tables_check_loops(ctx,
-							data->verdict.chain);
-				if (err < 0)
-					return err;
-				break;
-			default:
-				break;
-			}
-		}
-	}
-
-	list_for_each_entry(set, &ctx->table->sets, list) {
-		if (!nft_is_active_next(ctx->net, set))
-			continue;
-		if (!(set->flags & NFT_SET_MAP) ||
-		    set->dtype != NFT_DATA_VERDICT)
-			continue;
-
-		list_for_each_entry(binding, &set->bindings, list) {
-			if (!(binding->flags & NFT_SET_MAP) ||
-			    binding->chain != chain)
-				continue;
-
-			iter.genmask	= nft_genmask_next(ctx->net);
-			iter.type	= NFT_ITER_UPDATE;
-			iter.skip 	= 0;
-			iter.count	= 0;
-			iter.err	= 0;
-			iter.fn		= nf_tables_loop_check_setelem;
-
-			set->ops->walk(ctx, set, &iter);
-			if (!iter.err)
-				iter.err = nft_set_catchall_loops(ctx, set);
-
-			if (iter.err < 0)
-				return iter.err;
-		}
-	}
-
-	return 0;
-}
-
 /**
  *	nft_parse_u32_check - fetch u32 attribute and check for maximum value
  *
@@ -11061,7 +10929,7 @@ static int nft_validate_register_store(const struct nft_ctx *ctx,
 		if (data != NULL &&
 		    (data->verdict.code == NFT_GOTO ||
 		     data->verdict.code == NFT_JUMP)) {
-			err = nf_tables_check_loops(ctx, data->verdict.chain);
+			err = nft_chain_validate(ctx, data->verdict.chain);
 			if (err < 0)
 				return err;
 		}
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index f1c31757e496..55e28e1da66e 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -325,7 +325,7 @@ static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	hooks = nf_hook_entries_head(net, pf, entry->state.hook);
 
 	i = entry->hook_index;
-	if (WARN_ON_ONCE(!hooks || i >= hooks->num_hook_entries)) {
+	if (!hooks || i >= hooks->num_hook_entries) {
 		kfree_skb_reason(skb, SKB_DROP_REASON_NETFILTER_DROP);
 		nf_queue_entry_free(entry);
 		return;
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 2a96d9c1db65..6fa3cca87d34 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1077,6 +1077,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		 */
 		if (nf_conntrack_confirm(skb) != NF_ACCEPT)
 			goto drop;
+
+		/* The ct may be dropped if a clash has been resolved,
+		 * so it's necessary to retrieve it from skb again to
+		 * prevent UAF.
+		 */
+		ct = nf_ct_get(skb, &ctinfo);
+		if (!ct)
+			skip_add = true;
 	}
 
 	if (!skip_add)
diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index c2ef9dcf91d2..cc6051d4f2ef 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -91,7 +91,7 @@ static int ingress_init(struct Qdisc *sch, struct nlattr *opt,
 	entry = tcx_entry_fetch_or_create(dev, true, &created);
 	if (!entry)
 		return -ENOMEM;
-	tcx_miniq_set_active(entry, true);
+	tcx_miniq_inc(entry);
 	mini_qdisc_pair_init(&q->miniqp, sch, &tcx_entry(entry)->miniq);
 	if (created)
 		tcx_entry_update(dev, entry, true);
@@ -121,7 +121,7 @@ static void ingress_destroy(struct Qdisc *sch)
 	tcf_block_put_ext(q->block, sch, &q->block_info);
 
 	if (entry) {
-		tcx_miniq_set_active(entry, false);
+		tcx_miniq_dec(entry);
 		if (!tcx_entry_is_active(entry)) {
 			tcx_entry_update(dev, NULL, true);
 			tcx_entry_free(entry);
@@ -257,7 +257,7 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
 	entry = tcx_entry_fetch_or_create(dev, true, &created);
 	if (!entry)
 		return -ENOMEM;
-	tcx_miniq_set_active(entry, true);
+	tcx_miniq_inc(entry);
 	mini_qdisc_pair_init(&q->miniqp_ingress, sch, &tcx_entry(entry)->miniq);
 	if (created)
 		tcx_entry_update(dev, entry, true);
@@ -276,7 +276,7 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
 	entry = tcx_entry_fetch_or_create(dev, false, &created);
 	if (!entry)
 		return -ENOMEM;
-	tcx_miniq_set_active(entry, true);
+	tcx_miniq_inc(entry);
 	mini_qdisc_pair_init(&q->miniqp_egress, sch, &tcx_entry(entry)->miniq);
 	if (created)
 		tcx_entry_update(dev, entry, false);
@@ -302,7 +302,7 @@ static void clsact_destroy(struct Qdisc *sch)
 	tcf_block_put_ext(q->egress_block, sch, &q->egress_block_info);
 
 	if (ingress_entry) {
-		tcx_miniq_set_active(ingress_entry, false);
+		tcx_miniq_dec(ingress_entry);
 		if (!tcx_entry_is_active(ingress_entry)) {
 			tcx_entry_update(dev, NULL, true);
 			tcx_entry_free(ingress_entry);
@@ -310,7 +310,7 @@ static void clsact_destroy(struct Qdisc *sch)
 	}
 
 	if (egress_entry) {
-		tcx_miniq_set_active(egress_entry, false);
+		tcx_miniq_dec(egress_entry);
 		if (!tcx_entry_is_active(egress_entry)) {
 			tcx_entry_update(dev, NULL, false);
 			tcx_entry_free(egress_entry);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index ce18716491c8..b9121adef8b7 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2442,6 +2442,13 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 		transport->srcport = 0;
 		status = -EAGAIN;
 		break;
+	case -EPERM:
+		/* Happens, for instance, if a BPF program is preventing
+		 * the connect. Remap the error so upper layers can better
+		 * deal with it.
+		 */
+		status = -ECONNREFUSED;
+		fallthrough;
 	case -EINVAL:
 		/* Happens, for instance, if the user specified a link
 		 * local IPv6 address without a scope-id.
diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
index a78b804b680c..b9513d224476 100755
--- a/scripts/ld-version.sh
+++ b/scripts/ld-version.sh
@@ -57,9 +57,11 @@ else
 	fi
 fi
 
-# Some distributions append a package release number, as in 2.34-4.fc32
-# Trim the hyphen and any characters that follow.
-version=${version%-*}
+# There may be something after the version, such as a distribution's package
+# release number (like Fedora's "2.34-4.fc32") or punctuation (like LLD briefly
+# added before the "compatible with GNU linkers" string), so remove everything
+# after just numbers and periods.
+version=${version%%[!0-9.]*}
 
 cversion=$(get_canonical_version $version)
 min_cversion=$(get_canonical_version $min_version)
diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index fffc8af8deb1..c52d517b9364 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -83,7 +83,6 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEA
 	done
 
 	if [ -d "%{buildroot}/lib/modules/%{KERNELRELEASE}/dtb" ];then
-		echo "/lib/modules/%{KERNELRELEASE}/dtb"
 		find "%{buildroot}/lib/modules/%{KERNELRELEASE}/dtb" -printf "%%%ghost /boot/dtb-%{KERNELRELEASE}/%%P\n"
 	fi
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c0530d4aa3fc..98f580e273e4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9999,6 +9999,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x841c, "HP Pavilion 15-CK0xx", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8497, "HP Envy x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x84a6, "HP 250 G7 Notebook PC", ALC269_FIXUP_HP_LINE1_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x84ae, "HP 15-db0403ng", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
@@ -10327,6 +10328,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
 	SND_PCI_QUIRK(0x10ec, 0x118c, "Medion EE4254 MD62100", ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE),
+	SND_PCI_QUIRK(0x10ec, 0x11bc, "VAIO VJFE-IL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x10ec, 0x1230, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x124c, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1252, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
@@ -10424,6 +10426,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0xa600, "Clevo NL50NU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa650, "Clevo NP[567]0SN[CD]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa671, "Clevo NP70SN[CDE]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0xa763, "Clevo V54x_6x_TU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb018, "Clevo NP50D[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb019, "Clevo NH77D[BE]Q", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb022, "Clevo NH77D[DC][QW]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
@@ -10594,6 +10597,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 6a39ca632f55..4a6beddb0f6c 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -566,12 +566,6 @@ static int hda_dai_suspend(struct hdac_bus *bus)
 			sdai = swidget->private;
 			ops = sdai->platform_private;
 
-			ret = hda_link_dma_cleanup(hext_stream->link_substream,
-						   hext_stream,
-						   cpu_dai);
-			if (ret < 0)
-				return ret;
-
 			/* for consistency with TRIGGER_SUSPEND  */
 			if (ops->post_trigger) {
 				ret = ops->post_trigger(sdev, cpu_dai,
@@ -580,6 +574,12 @@ static int hda_dai_suspend(struct hdac_bus *bus)
 				if (ret < 0)
 					return ret;
 			}
+
+			ret = hda_link_dma_cleanup(hext_stream->link_substream,
+						   hext_stream,
+						   cpu_dai);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
diff --git a/tools/testing/selftests/wireguard/qemu/Makefile b/tools/testing/selftests/wireguard/qemu/Makefile
index e95bd56b332f..35856b11c143 100644
--- a/tools/testing/selftests/wireguard/qemu/Makefile
+++ b/tools/testing/selftests/wireguard/qemu/Makefile
@@ -109,9 +109,9 @@ KERNEL_ARCH := x86_64
 KERNEL_BZIMAGE := $(KERNEL_BUILD_PATH)/arch/x86/boot/bzImage
 QEMU_VPORT_RESULT := virtio-serial-device
 ifeq ($(HOST_ARCH),$(ARCH))
-QEMU_MACHINE := -cpu host -machine microvm,accel=kvm,pit=off,pic=off,rtc=off -no-acpi
+QEMU_MACHINE := -cpu host -machine microvm,accel=kvm,pit=off,pic=off,rtc=off,acpi=off
 else
-QEMU_MACHINE := -cpu max -machine microvm -no-acpi
+QEMU_MACHINE := -cpu max -machine microvm,acpi=off
 endif
 else ifeq ($(ARCH),i686)
 CHOST := i686-linux-musl
@@ -120,9 +120,9 @@ KERNEL_ARCH := x86
 KERNEL_BZIMAGE := $(KERNEL_BUILD_PATH)/arch/x86/boot/bzImage
 QEMU_VPORT_RESULT := virtio-serial-device
 ifeq ($(subst x86_64,i686,$(HOST_ARCH)),$(ARCH))
-QEMU_MACHINE := -cpu host -machine microvm,accel=kvm,pit=off,pic=off,rtc=off -no-acpi
+QEMU_MACHINE := -cpu host -machine microvm,accel=kvm,pit=off,pic=off,rtc=off,acpi=off
 else
-QEMU_MACHINE := -cpu coreduo -machine microvm -no-acpi
+QEMU_MACHINE := -cpu coreduo -machine microvm,acpi=off
 endif
 else ifeq ($(ARCH),mips64)
 CHOST := mips64-linux-musl

