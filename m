Return-Path: <stable+bounces-134739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43509A94732
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 10:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFCB3A8669
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 08:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF4D1E3DD6;
	Sun, 20 Apr 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pdCKH6hA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD831A7046;
	Sun, 20 Apr 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745137968; cv=none; b=hZCYiY0F3B5WhppObC9mKgEp+jArg027H1XbCmEiHnsorqDtNhGPZ/+LBm6NO1Yww0ni48BShyLazrJH8pLW+7nuHlacYcRKXc/BQv4jbOVnJNxPU4ZteoI9Qc/wDi73UxqbsGZREAZYH1nxDrRjom3SkzxPSNrbcA+LdU/RSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745137968; c=relaxed/simple;
	bh=kW4MgebZcwMKOlptzmgppdwffbLiVw9GVCV8/yrbRRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwGsG/QABj24th85KL8T4HPhZKtrVBABptHejGFuu0Sd+ERKv/nBkerhmdUzDiNfxK85t06VfcVD+TCbZ56GZsKFpTs3ZsEMGJYmUbsnqg74pc8o3GYaXPaimrtnCoEDNT3blWQrN84uCczqIUXQqukgGgHyhVEfw4tGmW8i7xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pdCKH6hA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB181C4CEE2;
	Sun, 20 Apr 2025 08:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745137966;
	bh=kW4MgebZcwMKOlptzmgppdwffbLiVw9GVCV8/yrbRRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdCKH6hAxm98htvOAEgDovXM7+itlgM9JtB7VBu8ms/oNKc35kYbC2pcRLLr2NaMS
	 YLLZRK/kYIvD4ZB0q8KzodRbB1g8OEuDFCr7kOsvDXk0DU5VW1QKB+4QDDq4l8n3Ae
	 FgkMZxCDVQ2b/gcbtK8QuPKjI6MxgGDy7DaBkS7o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.24
Date: Sun, 20 Apr 2025 10:32:31 +0200
Message-ID: <2025042031-elitism-knelt-df5b@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025042031-drastic-chunk-c8c7@gregkh>
References: <2025042031-drastic-chunk-c8c7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d401577b5a6a..607a8937f175 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3028,6 +3028,8 @@
 			* max_sec_lba48: Set or clear transfer size limit to
 			  65535 sectors.
 
+			* external: Mark port as external (hotplug-capable).
+
 			* [no]lpm: Enable or disable link power management.
 
 			* [no]setxfer: Indicate if transfer speed mode setting
diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
index 76163abed655..5ed40f21b8eb 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -55,8 +55,7 @@ properties:
       - const: arm,primecell
 
   reg:
-    minItems: 1
-    maxItems: 2
+    maxItems: 1
 
   clocks:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 8eec07d9d454..07d21a3617f5 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -41,8 +41,7 @@ properties:
       - const: arm,primecell
 
   reg:
-    minItems: 1
-    maxItems: 2
+    maxItems: 1
 
   qcom,dsb-element-bits:
     description:
diff --git a/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml b/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
index b68141264c0e..4d40e75b4e1e 100644
--- a/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
@@ -71,7 +71,7 @@ properties:
                 description:
                   Any lane can be inverted or not.
                 minItems: 1
-                maxItems: 2
+                maxItems: 3
 
             required:
               - data-lanes
diff --git a/Makefile b/Makefile
index 6a2a60eb67a3..e1fa425089c2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 23
+SUBLEVEL = 24
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
@@ -1013,6 +1013,9 @@ ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS   += -fconserve-stack
 endif
 
+# Ensure compilers do not transform certain loops into calls to wcslen()
+KBUILD_CFLAGS += -fno-builtin-wcslen
+
 # change __FILE__ to the relative path from the srctree
 KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 
diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 302c5beb224a..b8f8255f840b 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1451,6 +1451,7 @@ pinctrl_gsacore: pinctrl@17a80000 {
 			/* TODO: update once support for this CMU exists */
 			clocks = <0>;
 			clock-names = "pclk";
+			status = "disabled";
 		};
 
 		cmu_top: clock-controller@1e080000 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 3458be7f7f61..f49ec7495906 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1255,8 +1255,7 @@ dpi0_out: endpoint {
 		};
 
 		pwm0: pwm@1401e000 {
-			compatible = "mediatek,mt8173-disp-pwm",
-				     "mediatek,mt6595-disp-pwm";
+			compatible = "mediatek,mt8173-disp-pwm";
 			reg = <0 0x1401e000 0 0x1000>;
 			#pwm-cells = <2>;
 			clocks = <&mmsys CLK_MM_DISP_PWM026M>,
@@ -1266,8 +1265,7 @@ pwm0: pwm@1401e000 {
 		};
 
 		pwm1: pwm@1401f000 {
-			compatible = "mediatek,mt8173-disp-pwm",
-				     "mediatek,mt6595-disp-pwm";
+			compatible = "mediatek,mt8173-disp-pwm";
 			reg = <0 0x1401f000 0 0x1000>;
 			#pwm-cells = <2>;
 			clocks = <&mmsys CLK_MM_DISP_PWM126M>,
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi
index 19340d13f789..41821354bbda 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi
@@ -227,13 +227,6 @@ key-power {
 			wakeup-event-action = <EV_ACT_ASSERTED>;
 			wakeup-source;
 		};
-
-		key-suspend {
-			label = "Suspend";
-			gpios = <&gpio TEGRA234_MAIN_GPIO(G, 2) GPIO_ACTIVE_LOW>;
-			linux,input-type = <EV_KEY>;
-			linux,code = <KEY_SLEEP>;
-		};
 	};
 
 	fan: pwm-fan {
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 488f8e751349..2a4e686e633c 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -75,6 +75,7 @@
 #define ARM_CPU_PART_CORTEX_A76		0xD0B
 #define ARM_CPU_PART_NEOVERSE_N1	0xD0C
 #define ARM_CPU_PART_CORTEX_A77		0xD0D
+#define ARM_CPU_PART_CORTEX_A76AE	0xD0E
 #define ARM_CPU_PART_NEOVERSE_V1	0xD40
 #define ARM_CPU_PART_CORTEX_A78		0xD41
 #define ARM_CPU_PART_CORTEX_A78AE	0xD42
@@ -119,6 +120,7 @@
 #define QCOM_CPU_PART_KRYO		0x200
 #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
 #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
+#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
 #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
 #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
 #define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
@@ -158,6 +160,7 @@
 #define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
 #define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
 #define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
+#define MIDR_CORTEX_A76AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76AE)
 #define MIDR_NEOVERSE_V1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V1)
 #define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
 #define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
@@ -195,6 +198,7 @@
 #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 #define MIDR_QCOM_KRYO_2XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_GOLD)
 #define MIDR_QCOM_KRYO_2XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_SILVER)
+#define MIDR_QCOM_KRYO_3XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_GOLD)
 #define MIDR_QCOM_KRYO_3XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_SILVER)
 #define MIDR_QCOM_KRYO_4XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_GOLD)
 #define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index 0c4d9045c31f..f1524cdeacf1 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -97,7 +97,6 @@ enum mitigation_state arm64_get_meltdown_state(void);
 
 enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
-u8 spectre_bhb_loop_affected(int scope);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr);
 
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index d780d1bd2eac..82cf1f879c61 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -109,10 +109,9 @@ static inline void arm64_mops_reset_regs(struct user_pt_regs *regs, unsigned lon
 	int dstreg = ESR_ELx_MOPS_ISS_DESTREG(esr);
 	int srcreg = ESR_ELx_MOPS_ISS_SRCREG(esr);
 	int sizereg = ESR_ELx_MOPS_ISS_SIZEREG(esr);
-	unsigned long dst, src, size;
+	unsigned long dst, size;
 
 	dst = regs->regs[dstreg];
-	src = regs->regs[srcreg];
 	size = regs->regs[sizereg];
 
 	/*
@@ -129,6 +128,7 @@ static inline void arm64_mops_reset_regs(struct user_pt_regs *regs, unsigned lon
 		}
 	} else {
 		/* CPY* instruction */
+		unsigned long src = regs->regs[srcreg];
 		if (!(option_a ^ wrong_option)) {
 			/* Format is from Option B */
 			if (regs->pstate & PSR_N_BIT) {
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index da53722f95d4..0f51fd10b4b0 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -845,52 +845,86 @@ static unsigned long system_bhb_mitigations;
  * This must be called with SCOPE_LOCAL_CPU for each type of CPU, before any
  * SCOPE_SYSTEM call will give the right answer.
  */
-u8 spectre_bhb_loop_affected(int scope)
+static bool is_spectre_bhb_safe(int scope)
+{
+	static const struct midr_range spectre_bhb_safe_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A510),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A520),
+		MIDR_ALL_VERSIONS(MIDR_BRAHMA_B53),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_SILVER),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_SILVER),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_SILVER),
+		{},
+	};
+	static bool all_safe = true;
+
+	if (scope != SCOPE_LOCAL_CPU)
+		return all_safe;
+
+	if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_safe_list))
+		return true;
+
+	all_safe = false;
+
+	return false;
+}
+
+static u8 spectre_bhb_loop_affected(void)
 {
 	u8 k = 0;
-	static u8 max_bhb_k;
-
-	if (scope == SCOPE_LOCAL_CPU) {
-		static const struct midr_range spectre_bhb_k32_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
-			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
-			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
-			{},
-		};
-		static const struct midr_range spectre_bhb_k24_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
-			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
-			{},
-		};
-		static const struct midr_range spectre_bhb_k11_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_AMPERE1),
-			{},
-		};
-		static const struct midr_range spectre_bhb_k8_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
-			{},
-		};
-
-		if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k32_list))
-			k = 32;
-		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_list))
-			k = 24;
-		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k11_list))
-			k = 11;
-		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k8_list))
-			k =  8;
-
-		max_bhb_k = max(max_bhb_k, k);
-	} else {
-		k = max_bhb_k;
-	}
+
+	static const struct midr_range spectre_bhb_k132_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+	};
+	static const struct midr_range spectre_bhb_k38_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+	};
+	static const struct midr_range spectre_bhb_k32_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+		{},
+	};
+	static const struct midr_range spectre_bhb_k24_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A76AE),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
+		{},
+	};
+	static const struct midr_range spectre_bhb_k11_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+		{},
+	};
+	static const struct midr_range spectre_bhb_k8_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+		{},
+	};
+
+	if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k132_list))
+		k = 132;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k38_list))
+		k = 38;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k32_list))
+		k = 32;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_list))
+		k = 24;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k11_list))
+		k = 11;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k8_list))
+		k =  8;
 
 	return k;
 }
@@ -916,29 +950,13 @@ static enum mitigation_state spectre_bhb_get_cpu_fw_mitigation_state(void)
 	}
 }
 
-static bool is_spectre_bhb_fw_affected(int scope)
+static bool has_spectre_bhb_fw_mitigation(void)
 {
-	static bool system_affected;
 	enum mitigation_state fw_state;
 	bool has_smccc = arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_NONE;
-	static const struct midr_range spectre_bhb_firmware_mitigated_list[] = {
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
-		{},
-	};
-	bool cpu_in_list = is_midr_in_range_list(read_cpuid_id(),
-					 spectre_bhb_firmware_mitigated_list);
-
-	if (scope != SCOPE_LOCAL_CPU)
-		return system_affected;
 
 	fw_state = spectre_bhb_get_cpu_fw_mitigation_state();
-	if (cpu_in_list || (has_smccc && fw_state == SPECTRE_MITIGATED)) {
-		system_affected = true;
-		return true;
-	}
-
-	return false;
+	return has_smccc && fw_state == SPECTRE_MITIGATED;
 }
 
 static bool supports_ecbhb(int scope)
@@ -954,6 +972,8 @@ static bool supports_ecbhb(int scope)
 						    ID_AA64MMFR1_EL1_ECBHB_SHIFT);
 }
 
+static u8 max_bhb_k;
+
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry,
 			     int scope)
 {
@@ -962,16 +982,18 @@ bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry,
 	if (supports_csv2p3(scope))
 		return false;
 
-	if (supports_clearbhb(scope))
-		return true;
-
-	if (spectre_bhb_loop_affected(scope))
-		return true;
+	if (is_spectre_bhb_safe(scope))
+		return false;
 
-	if (is_spectre_bhb_fw_affected(scope))
-		return true;
+	/*
+	 * At this point the core isn't known to be "safe" so we're going to
+	 * assume it's vulnerable. We still need to update `max_bhb_k` though,
+	 * but only if we aren't mitigating with clearbhb though.
+	 */
+	if (scope == SCOPE_LOCAL_CPU && !supports_clearbhb(SCOPE_LOCAL_CPU))
+		max_bhb_k = max(max_bhb_k, spectre_bhb_loop_affected());
 
-	return false;
+	return true;
 }
 
 static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
@@ -1002,7 +1024,7 @@ early_param("nospectre_bhb", parse_spectre_bhb_param);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 {
 	bp_hardening_cb_t cpu_cb;
-	enum mitigation_state fw_state, state = SPECTRE_VULNERABLE;
+	enum mitigation_state state = SPECTRE_VULNERABLE;
 	struct bp_hardening_data *data = this_cpu_ptr(&bp_hardening_data);
 
 	if (!is_spectre_bhb_affected(entry, SCOPE_LOCAL_CPU))
@@ -1028,7 +1050,7 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 		this_cpu_set_vectors(EL1_VECTOR_BHB_CLEAR_INSN);
 		state = SPECTRE_MITIGATED;
 		set_bit(BHB_INSN, &system_bhb_mitigations);
-	} else if (spectre_bhb_loop_affected(SCOPE_LOCAL_CPU)) {
+	} else if (spectre_bhb_loop_affected()) {
 		/*
 		 * Ensure KVM uses the indirect vector which will have the
 		 * branchy-loop added. A57/A72-r0 will already have selected
@@ -1041,32 +1063,29 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 		this_cpu_set_vectors(EL1_VECTOR_BHB_LOOP);
 		state = SPECTRE_MITIGATED;
 		set_bit(BHB_LOOP, &system_bhb_mitigations);
-	} else if (is_spectre_bhb_fw_affected(SCOPE_LOCAL_CPU)) {
-		fw_state = spectre_bhb_get_cpu_fw_mitigation_state();
-		if (fw_state == SPECTRE_MITIGATED) {
-			/*
-			 * Ensure KVM uses one of the spectre bp_hardening
-			 * vectors. The indirect vector doesn't include the EL3
-			 * call, so needs upgrading to
-			 * HYP_VECTOR_SPECTRE_INDIRECT.
-			 */
-			if (!data->slot || data->slot == HYP_VECTOR_INDIRECT)
-				data->slot += 1;
-
-			this_cpu_set_vectors(EL1_VECTOR_BHB_FW);
-
-			/*
-			 * The WA3 call in the vectors supersedes the WA1 call
-			 * made during context-switch. Uninstall any firmware
-			 * bp_hardening callback.
-			 */
-			cpu_cb = spectre_v2_get_sw_mitigation_cb();
-			if (__this_cpu_read(bp_hardening_data.fn) != cpu_cb)
-				__this_cpu_write(bp_hardening_data.fn, NULL);
-
-			state = SPECTRE_MITIGATED;
-			set_bit(BHB_FW, &system_bhb_mitigations);
-		}
+	} else if (has_spectre_bhb_fw_mitigation()) {
+		/*
+		 * Ensure KVM uses one of the spectre bp_hardening
+		 * vectors. The indirect vector doesn't include the EL3
+		 * call, so needs upgrading to
+		 * HYP_VECTOR_SPECTRE_INDIRECT.
+		 */
+		if (!data->slot || data->slot == HYP_VECTOR_INDIRECT)
+			data->slot += 1;
+
+		this_cpu_set_vectors(EL1_VECTOR_BHB_FW);
+
+		/*
+		 * The WA3 call in the vectors supersedes the WA1 call
+		 * made during context-switch. Uninstall any firmware
+		 * bp_hardening callback.
+		 */
+		cpu_cb = spectre_v2_get_sw_mitigation_cb();
+		if (__this_cpu_read(bp_hardening_data.fn) != cpu_cb)
+			__this_cpu_write(bp_hardening_data.fn, NULL);
+
+		state = SPECTRE_MITIGATED;
+		set_bit(BHB_FW, &system_bhb_mitigations);
 	}
 
 	update_mitigation_state(&spectre_bhb_state, state);
@@ -1100,7 +1119,6 @@ void noinstr spectre_bhb_patch_loop_iter(struct alt_instr *alt,
 {
 	u8 rd;
 	u32 insn;
-	u16 loop_count = spectre_bhb_loop_affected(SCOPE_SYSTEM);
 
 	BUG_ON(nr_inst != 1); /* MOV -> MOV */
 
@@ -1109,7 +1127,7 @@ void noinstr spectre_bhb_patch_loop_iter(struct alt_instr *alt,
 
 	insn = le32_to_cpu(*origptr);
 	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, insn);
-	insn = aarch64_insn_gen_movewide(rd, loop_count, 0,
+	insn = aarch64_insn_gen_movewide(rd, max_bhb_k, 0,
 					 AARCH64_INSN_VARIANT_64BIT,
 					 AARCH64_INSN_MOVEWIDE_ZERO);
 	*updptr++ = cpu_to_le32(insn);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 634d3f624818..7d301da8ff28 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -493,7 +493,11 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (err)
 		return err;
 
-	return kvm_share_hyp(vcpu, vcpu + 1);
+	err = kvm_share_hyp(vcpu, vcpu + 1);
+	if (err)
+		kvm_vgic_vcpu_destroy(vcpu);
+
+	return err;
 }
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e59c628c93f2..9bcd51fd67d4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1360,7 +1360,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
 		__remove_pgd_mapping(swapper_pg_dir,
 				     __phys_to_virt(start), size);
 	else {
-		max_pfn = PFN_UP(start + size);
+		/* Address of hotplugged memory can be smaller */
+		max_pfn = max(max_pfn, PFN_UP(start + size));
 		max_low_pfn = max_pfn;
 	}
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index f14329989e9a..4b6ce4f07bc2 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -550,12 +550,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_SPAPR_TCE:
+		fallthrough;
 	case KVM_CAP_SPAPR_TCE_64:
-		r = 1;
-		break;
 	case KVM_CAP_SPAPR_TCE_VFIO:
-		r = !!cpu_has_feature(CPU_FTR_HVMODE);
-		break;
 	case KVM_CAP_PPC_RTAS:
 	case KVM_CAP_PPC_FIXUP_HCALL:
 	case KVM_CAP_PPC_ENABLE_HCALL:
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 9b7720932787..5b97af311709 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -15,7 +15,7 @@ KBUILD_CFLAGS_MODULE += -fPIC
 KBUILD_AFLAGS	+= -m64
 KBUILD_CFLAGS	+= -m64
 KBUILD_CFLAGS	+= -fPIC
-LDFLAGS_vmlinux	:= -no-pie --emit-relocs --discard-none
+LDFLAGS_vmlinux	:= $(call ld-option,-no-pie) --emit-relocs --discard-none
 extra_tools	:= relocs
 aflags_dwarf	:= -Wa,-gdwarf-2
 KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index c3075e4a8efc..6d6b057b562f 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -858,18 +858,13 @@ static int cpumf_pmu_event_type(struct perf_event *event)
 static int cpumf_pmu_event_init(struct perf_event *event)
 {
 	unsigned int type = event->attr.type;
-	int err;
+	int err = -ENOENT;
 
 	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_RAW)
 		err = __hw_perf_event_init(event, type);
 	else if (event->pmu->type == type)
 		/* Registered as unknown PMU */
 		err = __hw_perf_event_init(event, cpumf_pmu_event_type(event));
-	else
-		return -ENOENT;
-
-	if (unlikely(err) && event->destroy)
-		event->destroy(event);
 
 	return err;
 }
@@ -1819,8 +1814,6 @@ static int cfdiag_event_init(struct perf_event *event)
 	event->destroy = hw_perf_event_destroy;
 
 	err = cfdiag_event_init2(event);
-	if (unlikely(err))
-		event->destroy(event);
 out:
 	return err;
 }
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 331e0654d61d..efdd6ead7ba8 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -898,9 +898,6 @@ static int cpumsf_pmu_event_init(struct perf_event *event)
 		event->attr.exclude_idle = 0;
 
 	err = __hw_perf_event_init(event);
-	if (unlikely(err))
-		if (event->destroy)
-			event->destroy(event);
 	return err;
 }
 
diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index c38546829345..23c27c632013 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -335,6 +335,9 @@ static bool zpci_bus_is_isolated_vf(struct zpci_bus *zbus, struct zpci_dev *zdev
 {
 	struct pci_dev *pdev;
 
+	if (!zdev->vfn)
+		return false;
+
 	pdev = zpci_iov_find_parent_pf(zbus, zdev);
 	if (!pdev)
 		return true;
diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index de5c0b389a3e..4779c3cb6cfa 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -171,8 +171,12 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 	args.address = mmio_addr;
 	args.vma = vma;
 	ret = follow_pfnmap_start(&args);
-	if (ret)
-		goto out_unlock_mmap;
+	if (ret) {
+		fixup_user_fault(current->mm, mmio_addr, FAULT_FLAG_WRITE, NULL);
+		ret = follow_pfnmap_start(&args);
+		if (ret)
+			goto out_unlock_mmap;
+	}
 
 	io_addr = (void __iomem *)((args.pfn << PAGE_SHIFT) |
 			(mmio_addr & ~PAGE_MASK));
@@ -305,14 +309,18 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
 		goto out_unlock_mmap;
 	ret = -EACCES;
-	if (!(vma->vm_flags & VM_WRITE))
+	if (!(vma->vm_flags & VM_READ))
 		goto out_unlock_mmap;
 
 	args.vma = vma;
 	args.address = mmio_addr;
 	ret = follow_pfnmap_start(&args);
-	if (ret)
-		goto out_unlock_mmap;
+	if (ret) {
+		fixup_user_fault(current->mm, mmio_addr, 0, NULL);
+		ret = follow_pfnmap_start(&args);
+		if (ret)
+			goto out_unlock_mmap;
+	}
 
 	io_addr = (void __iomem *)((args.pfn << PAGE_SHIFT) |
 			(mmio_addr & ~PAGE_MASK));
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 2b7f358762c1..dc28f2c4eee3 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -936,7 +936,6 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_t *ptep, pte_t pte, unsigned int nr)
 {
-	arch_enter_lazy_mmu_mode();
 	for (;;) {
 		__set_pte_at(mm, addr, ptep, pte, 0);
 		if (--nr == 0)
@@ -945,7 +944,6 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_val(pte) += PAGE_SIZE;
 		addr += PAGE_SIZE;
 	}
-	arch_leave_lazy_mmu_mode();
 }
 #define set_ptes set_ptes
 
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 8648a50afe88..a35ddcca5e76 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -52,8 +52,10 @@ void flush_tlb_pending(void)
 
 void arch_enter_lazy_mmu_mode(void)
 {
-	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
+	struct tlb_batch *tb;
 
+	preempt_disable();
+	tb = this_cpu_ptr(&tlb_batch);
 	tb->active = 1;
 }
 
@@ -64,6 +66,7 @@ void arch_leave_lazy_mmu_mode(void)
 	if (tb->tlb_nr)
 		flush_tlb_pending();
 	tb->active = 0;
+	preempt_enable();
 }
 
 static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index db38d2b9b788..e54da3b4d334 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2434,18 +2434,20 @@ config CC_HAS_NAMED_AS
 	def_bool $(success,echo 'int __seg_fs fs; int __seg_gs gs;' | $(CC) -x c - -S -o /dev/null)
 	depends on CC_IS_GCC
 
+#
+# -fsanitize=kernel-address (KASAN) and -fsanitize=thread (KCSAN)
+# are incompatible with named address spaces with GCC < 13.3
+# (see GCC PR sanitizer/111736 and also PR sanitizer/115172).
+#
+
 config CC_HAS_NAMED_AS_FIXED_SANITIZERS
-	def_bool CC_IS_GCC && GCC_VERSION >= 130300
+	def_bool y
+	depends on !(KASAN || KCSAN) || GCC_VERSION >= 130300
+	depends on !(UBSAN_BOOL && KASAN) || GCC_VERSION >= 140200
 
 config USE_X86_SEG_SUPPORT
-	def_bool y
-	depends on CC_HAS_NAMED_AS
-	#
-	# -fsanitize=kernel-address (KASAN) and -fsanitize=thread
-	# (KCSAN) are incompatible with named address spaces with
-	# GCC < 13.3 - see GCC PR sanitizer/111736.
-	#
-	depends on !(KASAN || KCSAN) || CC_HAS_NAMED_AS_FIXED_SANITIZERS
+	def_bool CC_HAS_NAMED_AS
+	depends on CC_HAS_NAMED_AS_FIXED_SANITIZERS
 
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index cf7fc2b8e3ce..1c2db11a2c3c 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -76,6 +76,28 @@ static __always_inline void native_local_irq_restore(unsigned long flags)
 
 #endif
 
+#ifndef CONFIG_PARAVIRT
+#ifndef __ASSEMBLY__
+/*
+ * Used in the idle loop; sti takes one instruction cycle
+ * to complete:
+ */
+static __always_inline void arch_safe_halt(void)
+{
+	native_safe_halt();
+}
+
+/*
+ * Used when interrupts are already enabled or to
+ * shutdown the processor:
+ */
+static __always_inline void halt(void)
+{
+	native_halt();
+}
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
@@ -97,24 +119,6 @@ static __always_inline void arch_local_irq_enable(void)
 	native_irq_enable();
 }
 
-/*
- * Used in the idle loop; sti takes one instruction cycle
- * to complete:
- */
-static __always_inline void arch_safe_halt(void)
-{
-	native_safe_halt();
-}
-
-/*
- * Used when interrupts are already enabled or to
- * shutdown the processor:
- */
-static __always_inline void halt(void)
-{
-	native_halt();
-}
-
 /*
  * For spinlocks, etc:
  */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index d4eb9e1d61b8..75d4c994f5e2 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -107,6 +107,16 @@ static inline void notify_page_enc_status_changed(unsigned long pfn,
 	PVOP_VCALL3(mmu.notify_page_enc_status_changed, pfn, npages, enc);
 }
 
+static __always_inline void arch_safe_halt(void)
+{
+	PVOP_VCALL0(irq.safe_halt);
+}
+
+static inline void halt(void)
+{
+	PVOP_VCALL0(irq.halt);
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static inline void load_sp0(unsigned long sp0)
 {
@@ -170,16 +180,6 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
-static __always_inline void arch_safe_halt(void)
-{
-	PVOP_VCALL0(irq.safe_halt);
-}
-
-static inline void halt(void)
-{
-	PVOP_VCALL0(irq.halt);
-}
-
 extern noinstr void pv_native_wbinvd(void);
 
 static __always_inline void wbinvd(void)
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 8d4fbe1be489..9334fdd1f635 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -122,10 +122,9 @@ struct pv_irq_ops {
 	struct paravirt_callee_save save_fl;
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
-
+#endif
 	void (*safe_halt)(void);
 	void (*halt)(void);
-#endif
 } __no_randomize_layout;
 
 struct pv_mmu_ops {
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index c70b86f1f295..63adda8a143f 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -23,6 +23,8 @@
 #include <linux/serial_core.h>
 #include <linux/pgtable.h>
 
+#include <xen/xen.h>
+
 #include <asm/e820/api.h>
 #include <asm/irqdomain.h>
 #include <asm/pci_x86.h>
@@ -1730,6 +1732,15 @@ int __init acpi_mps_check(void)
 {
 #if defined(CONFIG_X86_LOCAL_APIC) && !defined(CONFIG_X86_MPPARSE)
 /* mptable code is not built-in*/
+
+	/*
+	 * Xen disables ACPI in PV DomU guests but it still emulates APIC and
+	 * supports SMP. Returning early here ensures that APIC is not disabled
+	 * unnecessarily and the guest is not limited to a single vCPU.
+	 */
+	if (xen_pv_domain() && !xen_initial_domain())
+		return 0;
+
 	if (acpi_disabled || acpi_noirq) {
 		pr_warn("MPS support code is not built-in, using acpi=off or acpi=noirq or pci=noacpi may have problem\n");
 		return 1;
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 79d2e17f6582..425bed00b2e0 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -627,7 +627,7 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 	 * (model = 0x14) and later actually support it.
 	 * (AMD Erratum #110, docId: 25759).
 	 */
-	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM)) {
+	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM) && !cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		clear_cpu_cap(c, X86_FEATURE_LAHF_LM);
 		if (!rdmsrl_amd_safe(0xc001100d, &value)) {
 			value &= ~BIT_64(32);
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 4893d30ce438..b4746eb8b115 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -754,22 +754,21 @@ void __init e820__memory_setup_extended(u64 phys_addr, u32 data_len)
 void __init e820__register_nosave_regions(unsigned long limit_pfn)
 {
 	int i;
-	unsigned long pfn = 0;
+	u64 last_addr = 0;
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		struct e820_entry *entry = &e820_table->entries[i];
 
-		if (pfn < PFN_UP(entry->addr))
-			register_nosave_region(pfn, PFN_UP(entry->addr));
-
-		pfn = PFN_DOWN(entry->addr + entry->size);
-
 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
-			register_nosave_region(PFN_UP(entry->addr), pfn);
+			continue;
 
-		if (pfn >= limit_pfn)
-			break;
+		if (last_addr < entry->addr)
+			register_nosave_region(PFN_DOWN(last_addr), PFN_UP(entry->addr));
+
+		last_addr = entry->addr + entry->size;
 	}
+
+	register_nosave_region(PFN_DOWN(last_addr), limit_pfn);
 }
 
 #ifdef CONFIG_ACPI
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index fec381533555..0c1b915d7efa 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -100,6 +100,11 @@ int paravirt_disable_iospace(void)
 	return request_resource(&ioport_resource, &reserve_ioports);
 }
 
+static noinstr void pv_native_safe_halt(void)
+{
+	native_safe_halt();
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static noinstr void pv_native_write_cr2(unsigned long val)
 {
@@ -121,10 +126,6 @@ noinstr void pv_native_wbinvd(void)
 	native_wbinvd();
 }
 
-static noinstr void pv_native_safe_halt(void)
-{
-	native_safe_halt();
-}
 #endif
 
 struct pv_info pv_info = {
@@ -182,9 +183,11 @@ struct paravirt_patch_template pv_ops = {
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(pv_native_save_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(pv_native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
+#endif /* CONFIG_PARAVIRT_XXL */
+
+	/* Irq HLT ops. */
 	.irq.safe_halt		= pv_native_safe_halt,
 	.irq.halt		= native_halt,
-#endif /* CONFIG_PARAVIRT_XXL */
 
 	/* Mmu ops. */
 	.mmu.flush_tlb_user	= native_flush_tlb_local,
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index ef654530bf5a..98123ff10506 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -33,25 +33,55 @@
 #include <asm/smap.h>
 #include <asm/gsseg.h>
 
+/*
+ * The first GDT descriptor is reserved as 'NULL descriptor'.  As bits 0
+ * and 1 of a segment selector, i.e., the RPL bits, are NOT used to index
+ * GDT, selector values 0~3 all point to the NULL descriptor, thus values
+ * 0, 1, 2 and 3 are all valid NULL selector values.
+ *
+ * However IRET zeros ES, FS, GS, and DS segment registers if any of them
+ * is found to have any nonzero NULL selector value, which can be used by
+ * userspace in pre-FRED systems to spot any interrupt/exception by loading
+ * a nonzero NULL selector and waiting for it to become zero.  Before FRED
+ * there was nothing software could do to prevent such an information leak.
+ *
+ * ERETU, the only legit instruction to return to userspace from kernel
+ * under FRED, by design does NOT zero any segment register to avoid this
+ * problem behavior.
+ *
+ * As such, leave NULL selector values 0~3 unchanged.
+ */
+static inline u16 fixup_rpl(u16 sel)
+{
+	return sel <= 3 ? sel : sel | 3;
+}
+
 #ifdef CONFIG_IA32_EMULATION
 #include <asm/unistd_32_ia32.h>
 
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
-	unsigned int cur;
+	u16 cur;
 
+	/*
+	 * Reload fs and gs if they have changed in the signal
+	 * handler.  This does not handle long fs/gs base changes in
+	 * the handler, but does not clobber them at least in the
+	 * normal case.
+	 */
 	savesegment(gs, cur);
-	if ((sc->gs | 0x03) != cur)
-		load_gs_index(sc->gs | 0x03);
+	if (fixup_rpl(sc->gs) != cur)
+		load_gs_index(fixup_rpl(sc->gs));
 	savesegment(fs, cur);
-	if ((sc->fs | 0x03) != cur)
-		loadsegment(fs, sc->fs | 0x03);
+	if (fixup_rpl(sc->fs) != cur)
+		loadsegment(fs, fixup_rpl(sc->fs));
+
 	savesegment(ds, cur);
-	if ((sc->ds | 0x03) != cur)
-		loadsegment(ds, sc->ds | 0x03);
+	if (fixup_rpl(sc->ds) != cur)
+		loadsegment(ds, fixup_rpl(sc->ds));
 	savesegment(es, cur);
-	if ((sc->es | 0x03) != cur)
-		loadsegment(es, sc->es | 0x03);
+	if (fixup_rpl(sc->es) != cur)
+		loadsegment(es, fixup_rpl(sc->es));
 }
 
 #define sigset32_t			compat_sigset_t
@@ -105,18 +135,12 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
 	regs->orig_ax = -1;
 
 #ifdef CONFIG_IA32_EMULATION
-	/*
-	 * Reload fs and gs if they have changed in the signal
-	 * handler.  This does not handle long fs/gs base changes in
-	 * the handler, but does not clobber them at least in the
-	 * normal case.
-	 */
 	reload_segments(&sc);
 #else
-	loadsegment(gs, sc.gs);
-	regs->fs = sc.fs;
-	regs->es = sc.es;
-	regs->ds = sc.ds;
+	loadsegment(gs, fixup_rpl(sc.gs));
+	regs->fs = fixup_rpl(sc.fs);
+	regs->es = fixup_rpl(sc.es);
+	regs->ds = fixup_rpl(sc.ds);
 #endif
 
 	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 9157b4485ded..c92e43f2d0c4 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1047,8 +1047,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		}
 		break;
 	case 0xa: { /* Architectural Performance Monitoring */
-		union cpuid10_eax eax;
-		union cpuid10_edx edx;
+		union cpuid10_eax eax = { };
+		union cpuid10_edx edx = { };
 
 		if (!enable_pmu || !static_cpu_has(X86_FEATURE_ARCH_PERFMON)) {
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
@@ -1064,8 +1064,6 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 
 		if (kvm_pmu_cap.version)
 			edx.split.anythread_deprecated = 1;
-		edx.split.reserved1 = 0;
-		edx.split.reserved2 = 0;
 
 		entry->eax = eax.full;
 		entry->ebx = kvm_pmu_cap.events_mask;
@@ -1383,7 +1381,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		break;
 	/* AMD Extended Performance Monitoring and Debug */
 	case 0x80000022: {
-		union cpuid_0x80000022_ebx ebx;
+		union cpuid_0x80000022_ebx ebx = { };
 
 		entry->ecx = entry->edx = 0;
 		if (!enable_pmu || !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2)) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 45337a3fc03c..1a4ca471d63d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11769,6 +11769,8 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 	if (kvm_mpx_supported())
 		kvm_load_guest_fpu(vcpu);
 
+	kvm_vcpu_srcu_read_lock(vcpu);
+
 	r = kvm_apic_accept_events(vcpu);
 	if (r < 0)
 		goto out;
@@ -11782,6 +11784,8 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 		mp_state->mp_state = vcpu->arch.mp_state;
 
 out:
+	kvm_vcpu_srcu_read_unlock(vcpu);
+
 	if (kvm_mpx_supported())
 		kvm_put_guest_fpu(vcpu);
 	vcpu_put(vcpu);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 44f7b2ea6a07..69ceb967d73e 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2422,7 +2422,7 @@ static int __set_pages_np(struct page *page, int numpages)
 				.pgd = NULL,
 				.numpages = numpages,
 				.mask_set = __pgprot(0),
-				.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW),
+				.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY),
 				.flags = CPA_NO_CHECK_ALIAS };
 
 	/*
@@ -2501,7 +2501,7 @@ int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 		.pgd = pgd,
 		.numpages = numpages,
 		.mask_set = __pgprot(0),
-		.mask_clr = __pgprot(~page_flags & (_PAGE_NX|_PAGE_RW)),
+		.mask_clr = __pgprot(~page_flags & (_PAGE_NX|_PAGE_RW|_PAGE_DIRTY)),
 		.flags = CPA_NO_CHECK_ALIAS,
 	};
 
@@ -2544,7 +2544,7 @@ int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
 		.pgd		= pgd,
 		.numpages	= numpages,
 		.mask_set	= __pgprot(0),
-		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
+		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY),
 		.flags		= CPA_NO_CHECK_ALIAS,
 	};
 
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index b4f3784f27e9..0c950bbca309 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -70,6 +70,9 @@ EXPORT_SYMBOL(xen_start_flags);
  */
 struct shared_info *HYPERVISOR_shared_info = &xen_dummy_shared_info;
 
+/* Number of pages released from the initial allocation. */
+unsigned long xen_released_pages;
+
 static __ref void xen_get_vendor(void)
 {
 	init_cpu_devs();
@@ -465,6 +468,13 @@ int __init arch_xen_unpopulated_init(struct resource **res)
 			xen_free_unpopulated_pages(1, &pg);
 		}
 
+		/*
+		 * Account for the region being in the physmap but unpopulated.
+		 * The value in xen_released_pages is used by the balloon
+		 * driver to know how much of the physmap is unpopulated and
+		 * set an accurate initial memory target.
+		 */
+		xen_released_pages += xen_extra_mem[i].n_pfns;
 		/* Zero so region is not also added to the balloon driver. */
 		xen_extra_mem[i].n_pfns = 0;
 	}
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index c3db71d96c43..3823e52aef52 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -37,9 +37,6 @@
 
 #define GB(x) ((uint64_t)(x) * 1024 * 1024 * 1024)
 
-/* Number of pages released from the initial allocation. */
-unsigned long xen_released_pages;
-
 /* Memory map would allow PCI passthrough. */
 bool xen_pv_pci_possible;
 
diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
index 8d50981594d1..eccedb0c8886 100644
--- a/drivers/accel/ivpu/ivpu_debugfs.c
+++ b/drivers/accel/ivpu/ivpu_debugfs.c
@@ -331,7 +331,7 @@ ivpu_force_recovery_fn(struct file *file, const char __user *user_buf, size_t si
 		return -EINVAL;
 
 	ret = ivpu_rpm_get(vdev);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	ivpu_pm_trigger_recovery(vdev, "debugfs");
@@ -408,7 +408,7 @@ static int dct_active_set(void *data, u64 active_percent)
 		return -EINVAL;
 
 	ret = ivpu_rpm_get(vdev);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	if (active_percent)
diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 13c8a12162e8..f0402dc84758 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -299,7 +299,8 @@ ivpu_ipc_send_receive_internal(struct ivpu_device *vdev, struct vpu_jsm_msg *req
 	struct ivpu_ipc_consumer cons;
 	int ret;
 
-	drm_WARN_ON(&vdev->drm, pm_runtime_status_suspended(vdev->drm.dev));
+	drm_WARN_ON(&vdev->drm, pm_runtime_status_suspended(vdev->drm.dev) &&
+		    pm_runtime_enabled(vdev->drm.dev));
 
 	ivpu_ipc_consumer_add(vdev, &cons, channel, NULL);
 
diff --git a/drivers/accel/ivpu/ivpu_ms.c b/drivers/accel/ivpu/ivpu_ms.c
index 2f9d37f5c208..a961002fe25b 100644
--- a/drivers/accel/ivpu/ivpu_ms.c
+++ b/drivers/accel/ivpu/ivpu_ms.c
@@ -4,6 +4,7 @@
  */
 
 #include <drm/drm_file.h>
+#include <linux/pm_runtime.h>
 
 #include "ivpu_drv.h"
 #include "ivpu_gem.h"
@@ -44,6 +45,10 @@ int ivpu_ms_start_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 	    args->sampling_period_ns < MS_MIN_SAMPLE_PERIOD_NS)
 		return -EINVAL;
 
+	ret = ivpu_rpm_get(vdev);
+	if (ret < 0)
+		return ret;
+
 	mutex_lock(&file_priv->ms_lock);
 
 	if (get_instance_by_mask(file_priv, args->metric_group_mask)) {
@@ -96,6 +101,8 @@ int ivpu_ms_start_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 	kfree(ms);
 unlock:
 	mutex_unlock(&file_priv->ms_lock);
+
+	ivpu_rpm_put(vdev);
 	return ret;
 }
 
@@ -160,6 +167,10 @@ int ivpu_ms_get_data_ioctl(struct drm_device *dev, void *data, struct drm_file *
 	if (!args->metric_group_mask)
 		return -EINVAL;
 
+	ret = ivpu_rpm_get(vdev);
+	if (ret < 0)
+		return ret;
+
 	mutex_lock(&file_priv->ms_lock);
 
 	ms = get_instance_by_mask(file_priv, args->metric_group_mask);
@@ -187,6 +198,7 @@ int ivpu_ms_get_data_ioctl(struct drm_device *dev, void *data, struct drm_file *
 unlock:
 	mutex_unlock(&file_priv->ms_lock);
 
+	ivpu_rpm_put(vdev);
 	return ret;
 }
 
@@ -204,11 +216,17 @@ int ivpu_ms_stop_ioctl(struct drm_device *dev, void *data, struct drm_file *file
 {
 	struct ivpu_file_priv *file_priv = file->driver_priv;
 	struct drm_ivpu_metric_streamer_stop *args = data;
+	struct ivpu_device *vdev = file_priv->vdev;
 	struct ivpu_ms_instance *ms;
+	int ret;
 
 	if (!args->metric_group_mask)
 		return -EINVAL;
 
+	ret = ivpu_rpm_get(vdev);
+	if (ret < 0)
+		return ret;
+
 	mutex_lock(&file_priv->ms_lock);
 
 	ms = get_instance_by_mask(file_priv, args->metric_group_mask);
@@ -217,6 +235,7 @@ int ivpu_ms_stop_ioctl(struct drm_device *dev, void *data, struct drm_file *file
 
 	mutex_unlock(&file_priv->ms_lock);
 
+	ivpu_rpm_put(vdev);
 	return ms ? 0 : -EINVAL;
 }
 
@@ -281,6 +300,9 @@ int ivpu_ms_get_info_ioctl(struct drm_device *dev, void *data, struct drm_file *
 void ivpu_ms_cleanup(struct ivpu_file_priv *file_priv)
 {
 	struct ivpu_ms_instance *ms, *tmp;
+	struct ivpu_device *vdev = file_priv->vdev;
+
+	pm_runtime_get_sync(vdev->drm.dev);
 
 	mutex_lock(&file_priv->ms_lock);
 
@@ -293,6 +315,8 @@ void ivpu_ms_cleanup(struct ivpu_file_priv *file_priv)
 		free_instance(file_priv, ms);
 
 	mutex_unlock(&file_priv->ms_lock);
+
+	pm_runtime_put_autosuspend(vdev->drm.dev);
 }
 
 void ivpu_ms_cleanup_all(struct ivpu_device *vdev)
diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d2f7fd7743a1..11278f785526 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -22,8 +22,8 @@ static const char * const profile_names[] = {
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
-static ssize_t platform_profile_choices_show(struct device *dev,
-					struct device_attribute *attr,
+static ssize_t platform_profile_choices_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
 					char *buf)
 {
 	int len = 0;
@@ -49,8 +49,8 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 	return len;
 }
 
-static ssize_t platform_profile_show(struct device *dev,
-					struct device_attribute *attr,
+static ssize_t platform_profile_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
 					char *buf)
 {
 	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
@@ -77,8 +77,8 @@ static ssize_t platform_profile_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", profile_names[profile]);
 }
 
-static ssize_t platform_profile_store(struct device *dev,
-			    struct device_attribute *attr,
+static ssize_t platform_profile_store(struct kobject *kobj,
+			    struct kobj_attribute *attr,
 			    const char *buf, size_t count)
 {
 	int err, i;
@@ -115,12 +115,12 @@ static ssize_t platform_profile_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR_RO(platform_profile_choices);
-static DEVICE_ATTR_RW(platform_profile);
+static struct kobj_attribute attr_platform_profile_choices = __ATTR_RO(platform_profile_choices);
+static struct kobj_attribute attr_platform_profile = __ATTR_RW(platform_profile);
 
 static struct attribute *platform_profile_attrs[] = {
-	&dev_attr_platform_profile_choices.attr,
-	&dev_attr_platform_profile.attr,
+	&attr_platform_profile_choices.attr,
+	&attr_platform_profile.attr,
 	NULL
 };
 
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 45f63b09828a..650122deb480 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -63,6 +63,7 @@ enum board_ids {
 	board_ahci_pcs_quirk_no_devslp,
 	board_ahci_pcs_quirk_no_sntf,
 	board_ahci_yes_fbs,
+	board_ahci_yes_fbs_atapi_dma,
 
 	/* board IDs for specific chipsets in alphabetical order */
 	board_ahci_al,
@@ -188,6 +189,14 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_yes_fbs_atapi_dma] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_YES_FBS |
+				 AHCI_HFLAG_ATAPI_DMA_QUIRK),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	/* by chipsets */
 	[board_ahci_al] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_PMP | AHCI_HFLAG_NO_MSI),
@@ -589,6 +598,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
 	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
+	  .driver_data = board_ahci_yes_fbs_atapi_dma },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 8f40f75ba08c..10a5fe02f0a4 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -246,6 +246,7 @@ enum {
 	AHCI_HFLAG_NO_SXS		= BIT(26), /* SXS not supported */
 	AHCI_HFLAG_43BIT_ONLY		= BIT(27), /* 43bit DMA addr limit */
 	AHCI_HFLAG_INTEL_PCS_QUIRK	= BIT(28), /* apply Intel PCS quirk */
+	AHCI_HFLAG_ATAPI_DMA_QUIRK	= BIT(29), /* force ATAPI to use DMA */
 
 	/* ap->flags bits */
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index fdfa7b266218..a28ffe1e5969 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1321,6 +1321,10 @@ static void ahci_dev_config(struct ata_device *dev)
 {
 	struct ahci_host_priv *hpriv = dev->link->ap->host->private_data;
 
+	if ((dev->class == ATA_DEV_ATAPI) &&
+	    (hpriv->flags & AHCI_HFLAG_ATAPI_DMA_QUIRK))
+		dev->quirks |= ATA_QUIRK_ATAPI_MOD16_DMA;
+
 	if (hpriv->flags & AHCI_HFLAG_SECT255) {
 		dev->max_sectors = 255;
 		ata_dev_info(dev,
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d956735e2a76..0cb97181d10a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -88,6 +88,7 @@ struct ata_force_param {
 	unsigned int	xfer_mask;
 	unsigned int	quirk_on;
 	unsigned int	quirk_off;
+	unsigned int	pflags_on;
 	u16		lflags_on;
 	u16		lflags_off;
 };
@@ -331,6 +332,35 @@ void ata_force_cbl(struct ata_port *ap)
 	}
 }
 
+/**
+ *	ata_force_pflags - force port flags according to libata.force
+ *	@ap: ATA port of interest
+ *
+ *	Force port flags according to libata.force and whine about it.
+ *
+ *	LOCKING:
+ *	EH context.
+ */
+static void ata_force_pflags(struct ata_port *ap)
+{
+	int i;
+
+	for (i = ata_force_tbl_size - 1; i >= 0; i--) {
+		const struct ata_force_ent *fe = &ata_force_tbl[i];
+
+		if (fe->port != -1 && fe->port != ap->print_id)
+			continue;
+
+		/* let pflags stack */
+		if (fe->param.pflags_on) {
+			ap->pflags |= fe->param.pflags_on;
+			ata_port_notice(ap,
+					"FORCE: port flag 0x%x forced -> 0x%x\n",
+					fe->param.pflags_on, ap->pflags);
+		}
+	}
+}
+
 /**
  *	ata_force_link_limits - force link limits according to libata.force
  *	@link: ATA link of interest
@@ -486,6 +516,7 @@ static void ata_force_quirks(struct ata_device *dev)
 	}
 }
 #else
+static inline void ata_force_pflags(struct ata_port *ap) { }
 static inline void ata_force_link_limits(struct ata_link *link) { }
 static inline void ata_force_xfermask(struct ata_device *dev) { }
 static inline void ata_force_quirks(struct ata_device *dev) { }
@@ -5460,6 +5491,8 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 #endif
 	ata_sff_port_init(ap);
 
+	ata_force_pflags(ap);
+
 	return ap;
 }
 EXPORT_SYMBOL_GPL(ata_port_alloc);
@@ -6272,6 +6305,9 @@ EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 	{ "no" #name,	.lflags_on	= (flags) },	\
 	{ #name,	.lflags_off	= (flags) }
 
+#define force_pflag_on(name, flags)			\
+	{ #name,	.pflags_on	= (flags) }
+
 #define force_quirk_on(name, flag)			\
 	{ #name,	.quirk_on	= (flag) }
 
@@ -6331,6 +6367,8 @@ static const struct ata_force_param force_tbl[] __initconst = {
 	force_lflag_on(rstonce,		ATA_LFLAG_RST_ONCE),
 	force_lflag_onoff(dbdelay,	ATA_LFLAG_NO_DEBOUNCE_DELAY),
 
+	force_pflag_on(external,	ATA_PFLAG_EXTERNAL),
+
 	force_quirk_onoff(ncq,		ATA_QUIRK_NONCQ),
 	force_quirk_onoff(ncqtrim,	ATA_QUIRK_NO_NCQ_TRIM),
 	force_quirk_onoff(ncqati,	ATA_QUIRK_NO_NCQ_ON_ATI),
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3b303d4ae37a..16cd676eae1f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1542,8 +1542,15 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.command = ATA_CMD_PACKET;
 
-	/* is it pointless to prefer PIO for "safety reasons"? */
-	if (ap->flags & ATA_FLAG_PIO_DMA) {
+	/*
+	 * Do not use DMA if the connected device only supports PIO, even if the
+	 * port prefers PIO commands via DMA.
+	 *
+	 * Ideally, we should call atapi_check_dma() to check if it is safe for
+	 * the LLD to use DMA for REQUEST_SENSE, but we don't have a qc.
+	 * Since we can't check the command, perhaps we should only use pio?
+	 */
+	if ((ap->flags & ATA_FLAG_PIO_DMA) && !(dev->flags & ATA_DFLAG_PIO)) {
 		tf.protocol = ATAPI_PROT_DMA;
 		tf.feature |= ATAPI_PKT_DMA;
 	} else {
diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 538bd3423d85..1bdcd6ee741d 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -223,10 +223,16 @@ static int pxa_ata_probe(struct platform_device *pdev)
 
 	ap->ioaddr.cmd_addr	= devm_ioremap(&pdev->dev, cmd_res->start,
 						resource_size(cmd_res));
+	if (!ap->ioaddr.cmd_addr)
+		return -ENOMEM;
 	ap->ioaddr.ctl_addr	= devm_ioremap(&pdev->dev, ctl_res->start,
 						resource_size(ctl_res));
+	if (!ap->ioaddr.ctl_addr)
+		return -ENOMEM;
 	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
 						resource_size(dma_res));
+	if (!ap->ioaddr.bmdma_addr)
+		return -ENOMEM;
 
 	/*
 	 * Adjust register offsets
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index a482741eb181..c3042eca6332 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1117,9 +1117,14 @@ static int pdc20621_prog_dimm0(struct ata_host *host)
 	mmio += PDC_CHIP0_OFS;
 
 	for (i = 0; i < ARRAY_SIZE(pdc_i2c_read_data); i++)
-		pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
-				  pdc_i2c_read_data[i].reg,
-				  &spd0[pdc_i2c_read_data[i].ofs]);
+		if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
+				       pdc_i2c_read_data[i].reg,
+				       &spd0[pdc_i2c_read_data[i].ofs])) {
+			dev_err(host->dev,
+				"Failed in i2c read at index %d: device=%#x, reg=%#x\n",
+				i, PDC_DIMM0_SPD_DEV_ADDRESS, pdc_i2c_read_data[i].reg);
+			return -EIO;
+		}
 
 	data |= (spd0[4] - 8) | ((spd0[21] != 0) << 3) | ((spd0[3]-11) << 4);
 	data |= ((spd0[17] / 4) << 6) | ((spd0[5] / 2) << 7) |
@@ -1284,6 +1289,8 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 
 	/* Programming DIMM0 Module Control Register (index_CID0:80h) */
 	size = pdc20621_prog_dimm0(host);
+	if (size < 0)
+		return size;
 	dev_dbg(host->dev, "Local DIMM Size = %dMB\n", size);
 
 	/* Programming DIMM Module Global Control Register (index_CID0:88h) */
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 025dc6855cb2..41807ce36339 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -313,7 +313,7 @@ static int hd44780_probe(struct platform_device *pdev)
 fail3:
 	kfree(hd);
 fail2:
-	kfree(lcd);
+	charlcd_free(lcd);
 fail1:
 	kfree(hdc);
 	return ret;
@@ -328,7 +328,7 @@ static void hd44780_remove(struct platform_device *pdev)
 	kfree(hdc->hd44780);
 	kfree(lcd->drvdata);
 
-	kfree(lcd);
+	charlcd_free(lcd);
 }
 
 static const struct of_device_id hd44780_of_match[] = {
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 2152eec0c135..68224f2f83ff 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -687,6 +687,13 @@ int devres_release_group(struct device *dev, void *id)
 		spin_unlock_irqrestore(&dev->devres_lock, flags);
 
 		release_nodes(dev, &todo);
+	} else if (list_empty(&dev->devres_head)) {
+		/*
+		 * dev is probably dying via devres_release_all(): groups
+		 * have already been removed and are on the process of
+		 * being released - don't touch and don't warn.
+		 */
+		spin_unlock_irqrestore(&dev->devres_lock, flags);
 	} else {
 		WARN_ON(1);
 		spin_unlock_irqrestore(&dev->devres_lock, flags);
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 79b7bd8bfd45..38b9e485e520 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -681,22 +681,44 @@ static int ublk_max_cmd_buf_size(void)
 	return __ublk_queue_cmd_buf_size(UBLK_MAX_QUEUE_DEPTH);
 }
 
-static inline bool ublk_queue_can_use_recovery_reissue(
-		struct ublk_queue *ubq)
+/*
+ * Should I/O outstanding to the ublk server when it exits be reissued?
+ * If not, outstanding I/O will get errors.
+ */
+static inline bool ublk_nosrv_should_reissue_outstanding(struct ublk_device *ub)
 {
-	return (ubq->flags & UBLK_F_USER_RECOVERY) &&
-			(ubq->flags & UBLK_F_USER_RECOVERY_REISSUE);
+	return (ub->dev_info.flags & UBLK_F_USER_RECOVERY) &&
+	       (ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE);
 }
 
-static inline bool ublk_queue_can_use_recovery(
-		struct ublk_queue *ubq)
+/*
+ * Should I/O issued while there is no ublk server queue? If not, I/O
+ * issued while there is no ublk server will get errors.
+ */
+static inline bool ublk_nosrv_dev_should_queue_io(struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_USER_RECOVERY;
+}
+
+/*
+ * Same as ublk_nosrv_dev_should_queue_io, but uses a queue-local copy
+ * of the device flags for smaller cache footprint - better for fast
+ * paths.
+ */
+static inline bool ublk_nosrv_should_queue_io(struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_USER_RECOVERY;
 }
 
-static inline bool ublk_can_use_recovery(struct ublk_device *ub)
+/*
+ * Should ublk devices be stopped (i.e. no recovery possible) when the
+ * ublk server exits? If not, devices can be used again by a future
+ * incarnation of a ublk server via the start_recovery/end_recovery
+ * commands.
+ */
+static inline bool ublk_nosrv_should_stop_dev(struct ublk_device *ub)
 {
-	return ub->dev_info.flags & UBLK_F_USER_RECOVERY;
+	return !(ub->dev_info.flags & UBLK_F_USER_RECOVERY);
 }
 
 static void ublk_free_disk(struct gendisk *disk)
@@ -1059,6 +1081,25 @@ static void ublk_complete_rq(struct kref *ref)
 	__ublk_complete_rq(req);
 }
 
+static void ublk_do_fail_rq(struct request *req)
+{
+	struct ublk_queue *ubq = req->mq_hctx->driver_data;
+
+	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
+		blk_mq_requeue_request(req, false);
+	else
+		__ublk_complete_rq(req);
+}
+
+static void ublk_fail_rq_fn(struct kref *ref)
+{
+	struct ublk_rq_data *data = container_of(ref, struct ublk_rq_data,
+			ref);
+	struct request *req = blk_mq_rq_from_pdu(data);
+
+	ublk_do_fail_rq(req);
+}
+
 /*
  * Since __ublk_rq_task_work always fails requests immediately during
  * exiting, __ublk_fail_req() is only called from abort context during
@@ -1072,10 +1113,13 @@ static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
 {
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
-	if (ublk_queue_can_use_recovery_reissue(ubq))
-		blk_mq_requeue_request(req, false);
-	else
-		ublk_put_req_ref(ubq, req);
+	if (ublk_need_req_ref(ubq)) {
+		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+
+		kref_put(&data->ref, ublk_fail_rq_fn);
+	} else {
+		ublk_do_fail_rq(req);
+	}
 }
 
 static void ubq_complete_io_cmd(struct ublk_io *io, int res,
@@ -1100,7 +1144,7 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		struct request *rq)
 {
 	/* We cannot process this rq so just requeue it. */
-	if (ublk_queue_can_use_recovery(ubq))
+	if (ublk_nosrv_dev_should_queue_io(ubq->dev))
 		blk_mq_requeue_request(rq, false);
 	else
 		blk_mq_end_request(rq, BLK_STS_IOERR);
@@ -1245,10 +1289,10 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 		struct ublk_device *ub = ubq->dev;
 
 		if (ublk_abort_requests(ub, ubq)) {
-			if (ublk_can_use_recovery(ub))
-				schedule_work(&ub->quiesce_work);
-			else
+			if (ublk_nosrv_should_stop_dev(ub))
 				schedule_work(&ub->stop_work);
+			else
+				schedule_work(&ub->quiesce_work);
 		}
 		return BLK_EH_DONE;
 	}
@@ -1277,7 +1321,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * Note: force_abort is guaranteed to be seen because it is set
 	 * before request queue is unqiuesced.
 	 */
-	if (ublk_queue_can_use_recovery(ubq) && unlikely(ubq->force_abort))
+	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
 		return BLK_STS_IOERR;
 
 	if (unlikely(ubq->canceling)) {
@@ -1517,10 +1561,10 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	ublk_cancel_cmd(ubq, io, issue_flags);
 
 	if (need_schedule) {
-		if (ublk_can_use_recovery(ub))
-			schedule_work(&ub->quiesce_work);
-		else
+		if (ublk_nosrv_should_stop_dev(ub))
 			schedule_work(&ub->stop_work);
+		else
+			schedule_work(&ub->quiesce_work);
 	}
 }
 
@@ -1640,7 +1684,7 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
 		goto unlock;
-	if (ublk_can_use_recovery(ub)) {
+	if (ublk_nosrv_dev_should_queue_io(ub)) {
 		if (ub->dev_info.state == UBLK_S_DEV_LIVE)
 			__ublk_quiesce_dev(ub);
 		ublk_unquiesce_dev(ub);
@@ -2738,7 +2782,7 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	int i;
 
 	mutex_lock(&ub->mutex);
-	if (!ublk_can_use_recovery(ub))
+	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
 	if (!ub->nr_queues_ready)
 		goto out_unlock;
@@ -2791,7 +2835,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
 
 	mutex_lock(&ub->mutex);
-	if (!ublk_can_use_recovery(ub))
+	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
 
 	if (ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 53f6b4f76bcc..ab465e13c1f6 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -36,6 +36,7 @@
 /* Intel Bluetooth PCIe device id table */
 static const struct pci_device_id btintel_pcie_table[] = {
 	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
+	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 04d02c746ec0..dd2c0485b984 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -785,6 +785,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   const char *firmware_name)
 {
 	struct qca_fw_config config = {};
+	const char *variant = "";
 	int err;
 	u8 rom_ver = 0;
 	u32 soc_ver;
@@ -879,13 +880,11 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		case QCA_WCN3990:
 		case QCA_WCN3991:
 		case QCA_WCN3998:
-			if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID) {
-				snprintf(config.fwname, sizeof(config.fwname),
-					 "qca/crnv%02xu.bin", rom_ver);
-			} else {
-				snprintf(config.fwname, sizeof(config.fwname),
-					 "qca/crnv%02x.bin", rom_ver);
-			}
+			if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID)
+				variant = "u";
+
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/crnv%02x%s.bin", rom_ver, variant);
 			break;
 		case QCA_WCN3988:
 			snprintf(config.fwname, sizeof(config.fwname),
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3a0b9dc98707..151054a71852 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -626,6 +626,10 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe102), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe152), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe153), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x3804), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x38e4), .driver_info = BTUSB_MEDIATEK |
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 395d66e32a2e..2f322f890b81 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -102,7 +102,8 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
 	if (!skb) {
 		percpu_down_read(&hu->proto_lock);
 
-		if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+		if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
+		    test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 			skb = hu->proto->dequeue(hu);
 
 		percpu_up_read(&hu->proto_lock);
@@ -124,7 +125,8 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
 	if (!percpu_down_read_trylock(&hu->proto_lock))
 		return 0;
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 		goto no_schedule;
 
 	set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
@@ -278,7 +280,8 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	percpu_down_read(&hu->proto_lock);
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
 		percpu_up_read(&hu->proto_lock);
 		return -EUNATCH;
 	}
@@ -585,7 +588,8 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
 	if (tty != hu->tty)
 		return;
 
-	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
+	    test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 		hci_uart_tx_wakeup(hu);
 }
 
@@ -611,7 +615,8 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 
 	percpu_down_read(&hu->proto_lock);
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
 		percpu_up_read(&hu->proto_lock);
 		return;
 	}
@@ -707,12 +712,16 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	hu->proto = p;
 
+	set_bit(HCI_UART_PROTO_INIT, &hu->flags);
+
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		return err;
 	}
 
 	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+	clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
+
 	return 0;
 }
 
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 37fddf6055be..1837622ea625 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2353,6 +2353,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_WCN6750:
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the
@@ -2372,7 +2373,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
-	case QCA_WCN6750:
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index fbf3079b92a5..5ea5dd80e297 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -90,6 +90,7 @@ struct hci_uart {
 #define HCI_UART_REGISTERED		1
 #define HCI_UART_PROTO_READY		2
 #define HCI_UART_NO_SUSPEND_NOTIFIER	3
+#define HCI_UART_PROTO_INIT		4
 
 /* TX states  */
 #define HCI_UART_SENDING	1
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 4de75674f193..aa8a0ef697c7 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1207,11 +1207,16 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 	struct mhi_ring_element *mhi_tre;
 	struct mhi_buf_info *buf_info;
 	int eot, eob, chain, bei;
-	int ret;
+	int ret = 0;
 
 	/* Protect accesses for reading and incrementing WP */
 	write_lock_bh(&mhi_chan->lock);
 
+	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	buf_ring = &mhi_chan->buf_ring;
 	tre_ring = &mhi_chan->tre_ring;
 
@@ -1229,10 +1234,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 
 	if (!info->pre_mapped) {
 		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
-		if (ret) {
-			write_unlock_bh(&mhi_chan->lock);
-			return ret;
-		}
+		if (ret)
+			goto out;
 	}
 
 	eob = !!(flags & MHI_EOB);
@@ -1250,9 +1253,10 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 	mhi_add_ring_element(mhi_cntrl, tre_ring);
 	mhi_add_ring_element(mhi_cntrl, buf_ring);
 
+out:
 	write_unlock_bh(&mhi_chan->lock);
 
-	return 0;
+	return ret;
 }
 
 int mhi_queue_buf(struct mhi_device *mhi_dev, enum dma_data_direction dir,
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 7df7abaf3e52..e25daf2396d3 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -168,6 +168,11 @@ int tpm_try_get_ops(struct tpm_chip *chip)
 		goto out_ops;
 
 	mutex_lock(&chip->tpm_mutex);
+
+	/* tmp_chip_start may issue IO that is denied while suspended */
+	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
+		goto out_lock;
+
 	rc = tpm_chip_start(chip);
 	if (rc)
 		goto out_lock;
@@ -300,6 +305,7 @@ int tpm_class_shutdown(struct device *dev)
 	down_write(&chip->ops_sem);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		if (!tpm_chip_start(chip)) {
+			tpm2_end_auth_session(chip);
 			tpm2_shutdown(chip, TPM2_SU_CLEAR);
 			tpm_chip_stop(chip);
 		}
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index b1daa0d7b341..f62f7871edbd 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -445,18 +445,11 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 	if (!chip)
 		return -ENODEV;
 
-	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
-	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED) {
-		rc = 0;
-		goto out;
-	}
-
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		rc = tpm2_get_random(chip, out, max);
 	else
 		rc = tpm1_get_random(chip, out, max);
 
-out:
 	tpm_put_ops(chip);
 	return rc;
 }
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index fdef214b9f6b..ed0d3d8449b3 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -114,11 +114,10 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		return 0;
 	/* process status changes without irq support */
 	do {
+		usleep_range(priv->timeout_min, priv->timeout_max);
 		status = chip->ops->status(chip);
 		if ((status & mask) == mask)
 			return 0;
-		usleep_range(priv->timeout_min,
-			     priv->timeout_max);
 	} while (time_before(jiffies, stop));
 	return -ETIME;
 }
@@ -464,7 +463,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 
 		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
 					&priv->int_queue, false) < 0) {
-			rc = -ETIME;
+			if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
+				rc = -EAGAIN;
+			else
+				rc = -ETIME;
 			goto out_err;
 		}
 		status = tpm_tis_status(chip);
@@ -481,7 +483,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 
 	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
 				&priv->int_queue, false) < 0) {
-		rc = -ETIME;
+		if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
+			rc = -EAGAIN;
+		else
+			rc = -ETIME;
 		goto out_err;
 	}
 	status = tpm_tis_status(chip);
@@ -546,9 +551,11 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 		if (rc >= 0)
 			/* Data transfer done successfully */
 			break;
-		else if (rc != -EIO)
+		else if (rc != -EAGAIN && rc != -EIO)
 			/* Data transfer failed, not recoverable */
 			return rc;
+
+		usleep_range(priv->timeout_min, priv->timeout_max);
 	}
 
 	/* go and do it */
@@ -1144,6 +1151,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
 	}
 
+	if (priv->manufacturer_id == TPM_VID_IFX)
+		set_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags);
+
 	if (is_bsw()) {
 		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
 					ILB_REMAP_SIZE);
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 690ad8e9b731..970d02c337c7 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -89,6 +89,7 @@ enum tpm_tis_flags {
 	TPM_TIS_INVALID_STATUS		= 1,
 	TPM_TIS_DEFAULT_CANCELLATION	= 2,
 	TPM_TIS_IRQ_TESTED		= 3,
+	TPM_TIS_STATUS_VALID_RETRY	= 4,
 };
 
 struct tpm_tis_data {
diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index 229480c5b075..0f10090d4ae6 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -28,7 +28,7 @@ static bool clk_branch_in_hwcg_mode(const struct clk_branch *br)
 
 static bool clk_branch_check_halt(const struct clk_branch *br, bool enabling)
 {
-	bool invert = (br->halt_check == BRANCH_HALT_ENABLE);
+	bool invert = (br->halt_check & BRANCH_HALT_ENABLE);
 	u32 val;
 
 	regmap_read(br->clkr.regmap, br->halt_reg, &val);
@@ -44,7 +44,7 @@ static bool clk_branch2_check_halt(const struct clk_branch *br, bool enabling)
 {
 	u32 val;
 	u32 mask;
-	bool invert = (br->halt_check == BRANCH_HALT_ENABLE);
+	bool invert = (br->halt_check & BRANCH_HALT_ENABLE);
 
 	mask = CBCR_NOC_FSM_STATUS;
 	mask |= CBCR_CLK_OFF;
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index fa5fe4c2a2ee..208fc430ec98 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -292,6 +292,9 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	 */
 	udelay(1);
 
+	if (sc->flags & RETAIN_FF_ENABLE)
+		gdsc_retain_ff_on(sc);
+
 	/* Turn on HW trigger mode if supported */
 	if (sc->flags & HW_CTRL) {
 		ret = gdsc_hwctrl(sc, true);
@@ -308,9 +311,6 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 		udelay(1);
 	}
 
-	if (sc->flags & RETAIN_FF_ENABLE)
-		gdsc_retain_ff_on(sc);
-
 	return 0;
 }
 
@@ -457,13 +457,6 @@ static int gdsc_init(struct gdsc *sc)
 				goto err_disable_supply;
 		}
 
-		/* Turn on HW trigger mode if supported */
-		if (sc->flags & HW_CTRL) {
-			ret = gdsc_hwctrl(sc, true);
-			if (ret < 0)
-				goto err_disable_supply;
-		}
-
 		/*
 		 * Make sure the retain bit is set if the GDSC is already on,
 		 * otherwise we end up turning off the GDSC and destroying all
@@ -471,6 +464,14 @@ static int gdsc_init(struct gdsc *sc)
 		 */
 		if (sc->flags & RETAIN_FF_ENABLE)
 			gdsc_retain_ff_on(sc);
+
+		/* Turn on HW trigger mode if supported */
+		if (sc->flags & HW_CTRL) {
+			ret = gdsc_hwctrl(sc, true);
+			if (ret < 0)
+				goto err_disable_supply;
+		}
+
 	} else if (sc->flags & ALWAYS_ON) {
 		/* If ALWAYS_ON GDSCs are not ON, turn them ON */
 		gdsc_enable(&sc->pd);
@@ -506,6 +507,23 @@ static int gdsc_init(struct gdsc *sc)
 	return ret;
 }
 
+static void gdsc_pm_subdomain_remove(struct gdsc_desc *desc, size_t num)
+{
+	struct device *dev = desc->dev;
+	struct gdsc **scs = desc->scs;
+	int i;
+
+	/* Remove subdomains */
+	for (i = num - 1; i >= 0; i--) {
+		if (!scs[i])
+			continue;
+		if (scs[i]->parent)
+			pm_genpd_remove_subdomain(scs[i]->parent, &scs[i]->pd);
+		else if (!IS_ERR_OR_NULL(dev->pm_domain))
+			pm_genpd_remove_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+	}
+}
+
 int gdsc_register(struct gdsc_desc *desc,
 		  struct reset_controller_dev *rcdev, struct regmap *regmap)
 {
@@ -555,30 +573,27 @@ int gdsc_register(struct gdsc_desc *desc,
 		if (!scs[i])
 			continue;
 		if (scs[i]->parent)
-			pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
+			ret = pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
 		else if (!IS_ERR_OR_NULL(dev->pm_domain))
-			pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+			ret = pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+		if (ret)
+			goto err_pm_subdomain_remove;
 	}
 
 	return of_genpd_add_provider_onecell(dev->of_node, data);
+
+err_pm_subdomain_remove:
+	gdsc_pm_subdomain_remove(desc, i);
+
+	return ret;
 }
 
 void gdsc_unregister(struct gdsc_desc *desc)
 {
-	int i;
 	struct device *dev = desc->dev;
-	struct gdsc **scs = desc->scs;
 	size_t num = desc->num;
 
-	/* Remove subdomains */
-	for (i = 0; i < num; i++) {
-		if (!scs[i])
-			continue;
-		if (scs[i]->parent)
-			pm_genpd_remove_subdomain(scs[i]->parent, &scs[i]->pd);
-		else if (!IS_ERR_OR_NULL(dev->pm_domain))
-			pm_genpd_remove_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
-	}
+	gdsc_pm_subdomain_remove(desc, num);
 	of_genpd_del_provider(dev->of_node);
 }
 
diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index c3c2b0c43983..fce2eecfa8c0 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -89,7 +89,9 @@ static const struct clk_div_table dtable_1_32[] = {
 
 /* Mux clock tables */
 static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
+#ifdef CONFIG_ARM64
 static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };
+#endif
 static const char * const sel_sdhi[] = { ".clk_533", ".clk_400", ".clk_266" };
 
 static const u32 mtable_sdhi[] = { 1, 2, 3 };
@@ -137,7 +139,12 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_DIV("P2", R9A07G043_CLK_P2, CLK_PLL3_DIV2_4_2, DIVPL3A, dtable_1_32),
 	DEF_FIXED("M0", R9A07G043_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
 	DEF_FIXED("ZT", R9A07G043_CLK_ZT, CLK_PLL3_DIV2_4_2, 1, 1),
+#ifdef CONFIG_ARM64
 	DEF_MUX("HP", R9A07G043_CLK_HP, SEL_PLL6_2, sel_pll6_2),
+#endif
+#ifdef CONFIG_RISCV
+	DEF_FIXED("HP", R9A07G043_CLK_HP, CLK_PLL6_250, 1, 1),
+#endif
 	DEF_FIXED("SPI0", R9A07G043_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 	DEF_FIXED("SPI1", R9A07G043_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
 	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, SEL_SDHI0, SEL_SDHI0_STS, sel_sdhi,
diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index a4c95161cb22..193e4f643358 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -168,9 +168,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_read_bool(pdev->dev.parent->of_node, "wakeup-source")) {
-		ret = device_init_wakeup(&pdev->dev, true);
-		if (ret)
-			goto out_clk_disable;
+		device_set_wakeup_capable(&pdev->dev, true);
 
 		ret = dev_pm_set_wake_irq(&pdev->dev, irq);
 		if (ret)
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index 248d98fd8c48..157f9a9ed636 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -189,14 +189,17 @@ static bool sp_pci_is_master(struct sp_device *sp)
 	pdev_new = to_pci_dev(dev_new);
 	pdev_cur = to_pci_dev(dev_cur);
 
-	if (pdev_new->bus->number < pdev_cur->bus->number)
-		return true;
+	if (pci_domain_nr(pdev_new->bus) != pci_domain_nr(pdev_cur->bus))
+		return pci_domain_nr(pdev_new->bus) < pci_domain_nr(pdev_cur->bus);
 
-	if (PCI_SLOT(pdev_new->devfn) < PCI_SLOT(pdev_cur->devfn))
-		return true;
+	if (pdev_new->bus->number != pdev_cur->bus->number)
+		return pdev_new->bus->number < pdev_cur->bus->number;
 
-	if (PCI_FUNC(pdev_new->devfn) < PCI_FUNC(pdev_cur->devfn))
-		return true;
+	if (PCI_SLOT(pdev_new->devfn) != PCI_SLOT(pdev_cur->devfn))
+		return PCI_SLOT(pdev_new->devfn) < PCI_SLOT(pdev_cur->devfn);
+
+	if (PCI_FUNC(pdev_new->devfn) != PCI_FUNC(pdev_cur->devfn))
+		return PCI_FUNC(pdev_new->devfn) < PCI_FUNC(pdev_cur->devfn);
 
 	return false;
 }
diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 1ecb733a5e88..45543ab5073f 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -823,6 +823,7 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	struct gpio_irq_chip *irq;
 	struct tegra_gpio *gpio;
 	struct device_node *np;
+	struct resource *res;
 	char **names;
 	int err;
 
@@ -842,19 +843,19 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	gpio->num_banks++;
 
 	/* get register apertures */
-	gpio->secure = devm_platform_ioremap_resource_byname(pdev, "security");
-	if (IS_ERR(gpio->secure)) {
-		gpio->secure = devm_platform_ioremap_resource(pdev, 0);
-		if (IS_ERR(gpio->secure))
-			return PTR_ERR(gpio->secure);
-	}
-
-	gpio->base = devm_platform_ioremap_resource_byname(pdev, "gpio");
-	if (IS_ERR(gpio->base)) {
-		gpio->base = devm_platform_ioremap_resource(pdev, 1);
-		if (IS_ERR(gpio->base))
-			return PTR_ERR(gpio->base);
-	}
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "security");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	gpio->secure = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gpio->secure))
+		return PTR_ERR(gpio->secure);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpio");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	gpio->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gpio->base))
+		return PTR_ERR(gpio->base);
 
 	err = platform_irq_count(pdev);
 	if (err < 0)
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 1a42336dfc1d..cc53e6940ad7 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -1011,6 +1011,7 @@ static void zynq_gpio_remove(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
 		dev_warn(&pdev->dev, "pm_runtime_get_sync() Failed\n");
+	device_init_wakeup(&pdev->dev, 0);
 	gpiochip_remove(&gpio->chip);
 	device_set_wakeup_capable(&pdev->dev, 0);
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 880f1efcaca5..e543129d3605 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -193,6 +193,8 @@ static void of_gpio_try_fixup_polarity(const struct device_node *np,
 		 */
 		{ "himax,hx8357",	"gpios-reset",	false },
 		{ "himax,hx8369",	"gpios-reset",	false },
+#endif
+#if IS_ENABLED(CONFIG_MTD_NAND_JZ4780)
 		/*
 		 * The rb-gpios semantics was undocumented and qi,lb60 (along with
 		 * the ingenic driver) got it wrong. The active state encodes the
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 96845541b2d2..31d4df968898 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6575,18 +6575,26 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 {
 	struct dma_fence *old = NULL;
 
+	dma_fence_get(gang);
 	do {
 		dma_fence_put(old);
 		old = amdgpu_device_get_gang(adev);
 		if (old == gang)
 			break;
 
-		if (!dma_fence_is_signaled(old))
+		if (!dma_fence_is_signaled(old)) {
+			dma_fence_put(gang);
 			return old;
+		}
 
 	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
 			 old, gang) != old);
 
+	/*
+	 * Drop it once for the exchanged reference in adev and once for the
+	 * thread local reference acquired in amdgpu_device_get_gang().
+	 */
+	dma_fence_put(old);
 	dma_fence_put(old);
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 73e02141a6e2..37d53578825b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2434,8 +2434,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	spin_lock_init(&vm->status_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
-	INIT_LIST_HEAD(&vm->pt_freed);
-	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
 	INIT_KFIFO(vm->faults);
 
 	r = amdgpu_vm_init_entities(adev, vm);
@@ -2607,8 +2605,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
-	flush_work(&vm->pt_free_work);
-
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	amdgpu_vm_put_task_info(vm->task_info);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 52dd7cdfdc81..ee893527a4f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -360,10 +360,6 @@ struct amdgpu_vm {
 	/* BOs which are invalidated, has been updated in the PTs */
 	struct list_head        done;
 
-	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
-	struct list_head	pt_freed;
-	struct work_struct	pt_free_work;
-
 	/* contains the page directory */
 	struct amdgpu_vm_bo_base     root;
 	struct dma_fence	*last_update;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f78a0434a48f..54ae0e9bc6d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -546,27 +546,6 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	amdgpu_bo_unref(&entry->bo);
 }
 
-void amdgpu_vm_pt_free_work(struct work_struct *work)
-{
-	struct amdgpu_vm_bo_base *entry, *next;
-	struct amdgpu_vm *vm;
-	LIST_HEAD(pt_freed);
-
-	vm = container_of(work, struct amdgpu_vm, pt_free_work);
-
-	spin_lock(&vm->status_lock);
-	list_splice_init(&vm->pt_freed, &pt_freed);
-	spin_unlock(&vm->status_lock);
-
-	/* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
-	amdgpu_bo_reserve(vm->root.bo, true);
-
-	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
-		amdgpu_vm_pt_free(entry);
-
-	amdgpu_bo_unreserve(vm->root.bo);
-}
-
 /**
  * amdgpu_vm_pt_free_list - free PD/PT levels
  *
@@ -579,19 +558,15 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params)
 {
 	struct amdgpu_vm_bo_base *entry, *next;
-	struct amdgpu_vm *vm = params->vm;
 	bool unlocked = params->unlocked;
 
 	if (list_empty(&params->tlb_flush_waitlist))
 		return;
 
-	if (unlocked) {
-		spin_lock(&vm->status_lock);
-		list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
-		spin_unlock(&vm->status_lock);
-		schedule_work(&vm->pt_free_work);
-		return;
-	}
+	/*
+	 * unlocked unmap clear page table leaves, warning to free the page entry.
+	 */
+	WARN_ON(unlocked);
 
 	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
 		amdgpu_vm_pt_free(entry);
@@ -899,7 +874,15 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		incr = (uint64_t)AMDGPU_GPU_PAGE_SIZE << shift;
 		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
 		pe_start = ((cursor.pfn >> shift) & mask) * 8;
-		entry_end = ((uint64_t)mask + 1) << shift;
+
+		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
+			/*
+			 * MMU notifier callback unlocked unmap huge page, leave is PDE entry,
+			 * only clear one entry. Next entry search again for PDE or PTE leave.
+			 */
+			entry_end = 1ULL << shift;
+		else
+			entry_end = ((uint64_t)mask + 1) << shift;
 		entry_end += cursor.pfn & ~(entry_end - 1);
 		entry_end = min(entry_end, end);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3e6b4736a7fe..67b5f3d7ff8e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -212,6 +212,11 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 		return -EINVAL;
 	}
 
+	if (args->ring_size < KFD_MIN_QUEUE_RING_SIZE) {
+		args->ring_size = KFD_MIN_QUEUE_RING_SIZE;
+		pr_debug("Size lower. clamped to KFD_MIN_QUEUE_RING_SIZE");
+	}
+
 	if (!access_ok((const void __user *) args->read_pointer_address,
 			sizeof(uint32_t))) {
 		pr_err("Can't access read pointer\n");
@@ -461,6 +466,11 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
 		return -EINVAL;
 	}
 
+	if (args->ring_size < KFD_MIN_QUEUE_RING_SIZE) {
+		args->ring_size = KFD_MIN_QUEUE_RING_SIZE;
+		pr_debug("Size lower. clamped to KFD_MIN_QUEUE_RING_SIZE");
+	}
+
 	properties.queue_address = args->ring_base_address;
 	properties.queue_size = args->ring_size;
 	properties.queue_percent = args->queue_percentage & 0xFF;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index d350c7ce35b3..9186ef0bd2a3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1493,6 +1493,11 @@ int kfd_debugfs_hang_hws(struct kfd_node *dev)
 		return -EINVAL;
 	}
 
+	if (dev->kfd->shared_resources.enable_mes) {
+		dev_err(dev->adev->dev, "Inducing MES hang is not supported\n");
+		return -EINVAL;
+	}
+
 	return dqm_debugfs_hang_hws(dev->dqm);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 264bd764f6f2..0ec8b457494b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -35,6 +35,7 @@
 #include <linux/pm_runtime.h>
 #include "amdgpu_amdkfd.h"
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 
 struct mm_struct;
 
@@ -1140,6 +1141,17 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
 	p->kobj = NULL;
 }
 
+/*
+ * If any GPU is ongoing reset, wait for reset complete.
+ */
+static void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
+{
+	int i;
+
+	for (i = 0; i < p->n_pdds; i++)
+		flush_workqueue(p->pdds[i]->dev->adev->reset_domain->wq);
+}
+
 /* No process locking is needed in this function, because the process
  * is not findable any more. We must assume that no other thread is
  * using it any more, otherwise we couldn't safely free the process
@@ -1154,6 +1166,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 	kfd_process_dequeue_from_all_devices(p);
 	pqm_uninit(&p->pqm);
 
+	/*
+	 * If GPU in reset, user queues may still running, wait for reset complete.
+	 */
+	kfd_process_wait_gpu_reset_complete(p);
+
 	/* Signal the eviction fence after user mode queues are
 	 * destroyed. This allows any BOs to be freed without
 	 * triggering pointless evictions or waiting for fences.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index ac777244ee0a..4078a8176187 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -546,7 +546,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
 				pqm->process->pasid,
 				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME)
+			if (retval != -ETIME && retval != -EIO)
 				goto err_destroy_queue;
 		}
 		kfd_procfs_del_queue(pqn->q);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8c61dee5ca0d..b50283864dcd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2992,19 +2992,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	/* check if this page fault time stamp is before svms->checkpoint_ts */
-	if (svms->checkpoint_ts[gpuidx] != 0) {
-		if (amdgpu_ih_ts_after(ts,  svms->checkpoint_ts[gpuidx])) {
-			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
-			r = 0;
-			goto out;
-		} else
-			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
-			 * to zero to avoid following ts wrap around give wrong comparing
-			 */
-			svms->checkpoint_ts[gpuidx] = 0;
-	}
-
 	if (!p->xnack_enabled) {
 		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
 		r = -EFAULT;
@@ -3024,6 +3011,21 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mmap_read_lock(mm);
 retry_write_locked:
 	mutex_lock(&svms->lock);
+
+	/* check if this page fault time stamp is before svms->checkpoint_ts */
+	if (svms->checkpoint_ts[gpuidx] != 0) {
+		if (amdgpu_ih_ts_after(ts,  svms->checkpoint_ts[gpuidx])) {
+			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+			r = -EAGAIN;
+			goto out_unlock_svms;
+		} else {
+			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
+			 * to zero to avoid following ts wrap around give wrong comparing
+			 */
+			svms->checkpoint_ts[gpuidx] = 0;
+		}
+	}
+
 	prange = svm_range_from_addr(svms, addr, NULL);
 	if (!prange) {
 		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
@@ -3148,7 +3150,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
 
-	svm_range_count_fault(node, p, gpuidx);
+	if (r != -EAGAIN)
+		svm_range_count_fault(node, p, gpuidx);
 
 	mmput(mm);
 out:
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 1ed21c1b86a5..a966abd40788 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -532,26 +532,6 @@ static void calculate_odm_slices(const struct dc_stream_state *stream, unsigned
 	odm_slice_end_x[odm_factor - 1] = stream->src.width - 1;
 }
 
-static bool is_plane_in_odm_slice(const struct dc_plane_state *plane, unsigned int slice_index, unsigned int *odm_slice_end_x, unsigned int num_slices)
-{
-	unsigned int slice_start_x, slice_end_x;
-
-	if (slice_index == 0)
-		slice_start_x = 0;
-	else
-		slice_start_x = odm_slice_end_x[slice_index - 1] + 1;
-
-	slice_end_x = odm_slice_end_x[slice_index];
-
-	if (plane->clip_rect.x + plane->clip_rect.width < slice_start_x)
-		return false;
-
-	if (plane->clip_rect.x > slice_end_x)
-		return false;
-
-	return true;
-}
-
 static void add_odm_slice_to_odm_tree(struct dml2_context *ctx,
 		struct dc_state *state,
 		struct dc_pipe_mapping_scratch *scratch,
@@ -791,12 +771,6 @@ static void map_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state
 	sort_pipes_for_splitting(&scratch->pipe_pool);
 
 	for (odm_slice_index = 0; odm_slice_index < scratch->odm_info.odm_factor; odm_slice_index++) {
-		// We build the tree for one ODM slice at a time.
-		// Each ODM slice shares a common OPP
-		if (!is_plane_in_odm_slice(plane, odm_slice_index, scratch->odm_info.odm_slice_end_x, scratch->odm_info.odm_factor)) {
-			continue;
-		}
-
 		// Now we have a list of all pipes to be used for this plane/stream, now setup the tree.
 		scratch->odm_info.next_higher_pipe_for_odm_slice[odm_slice_index] = add_plane_to_blend_tree(ctx, state,
 				plane,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
index a65a0ddee646..c671908ba7d0 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
@@ -44,7 +44,7 @@ void hubp31_set_unbounded_requesting(struct hubp *hubp, bool enable)
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
 	REG_UPDATE(DCHUBP_CNTL, HUBP_UNBOUNDED_REQ_MODE, enable);
-	REG_UPDATE(CURSOR_CONTROL, CURSOR_REQ_MODE, enable);
+	REG_UPDATE(CURSOR_CONTROL, CURSOR_REQ_MODE, 1);
 }
 
 void hubp31_soft_reset(struct hubp *hubp, bool reset)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index fd0530251c6e..d725af14af37 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1992,20 +1992,11 @@ static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	dc->hwss.get_position(&pipe_ctx, 1, &position);
 	vpos = position.vertical_count;
 
-	/* Avoid wraparound calculation issues */
-	vupdate_start += stream->timing.v_total;
-	vupdate_end += stream->timing.v_total;
-	vpos += stream->timing.v_total;
-
 	if (vpos <= vupdate_start) {
 		/* VPOS is in VACTIVE or back porch. */
 		lines_to_vupdate = vupdate_start - vpos;
-	} else if (vpos > vupdate_end) {
-		/* VPOS is in the front porch. */
-		return;
 	} else {
-		/* VPOS is in VUPDATE. */
-		lines_to_vupdate = 0;
+		lines_to_vupdate = stream->timing.v_total - vpos + vupdate_start;
 	}
 
 	/* Calculate time until VUPDATE in microseconds. */
@@ -2013,13 +2004,18 @@ static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
 		stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz;
 	us_to_vupdate = lines_to_vupdate * us_per_line;
 
+	/* Stall out until the cursor update completes. */
+	if (vupdate_end < vupdate_start)
+		vupdate_end += stream->timing.v_total;
+
+	/* Position is in the range of vupdate start and end*/
+	if (lines_to_vupdate > stream->timing.v_total - vupdate_end + vupdate_start)
+		us_to_vupdate = 0;
+
 	/* 70 us is a conservative estimate of cursor update time*/
 	if (us_to_vupdate > 70)
 		return;
 
-	/* Stall out until the cursor update completes. */
-	if (vupdate_end < vupdate_start)
-		vupdate_end += stream->timing.v_total;
 	us_vupdate = (vupdate_end - vupdate_start + 1) * us_per_line;
 	udelay(us_to_vupdate + us_vupdate);
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index a71c6117d7e5..0115d26b5af9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -51,6 +51,11 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
 	hwmgr->adev = adev;
 	hwmgr->not_vf = !amdgpu_sriov_vf(adev);
 	hwmgr->device = amdgpu_cgs_create_device(adev);
+	if (!hwmgr->device) {
+		kfree(hwmgr);
+		return -ENOMEM;
+	}
+
 	mutex_init(&hwmgr->msg_lock);
 	hwmgr->chip_family = adev->family;
 	hwmgr->chip_id = adev->asic_type;
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 5186d2114a50..32902f77f00d 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1376,7 +1376,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 		mode = &new_crtc_state->mode;
 		adjusted_mode = &new_crtc_state->adjusted_mode;
 
-		if (!new_crtc_state->mode_changed)
+		if (!new_crtc_state->mode_changed && !new_crtc_state->connectors_changed)
 			continue;
 
 		drm_dbg_atomic(dev, "modeset on [ENCODER:%d:%s]\n",
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 9d3e6dd68810..98a37dc3324e 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -743,7 +743,7 @@ static int bridges_show(struct seq_file *m, void *data)
 	unsigned int idx = 0;
 
 	drm_for_each_bridge_in_chain(encoder, bridge) {
-		drm_printf(&p, "bridge[%d]: %ps\n", idx++, bridge->funcs);
+		drm_printf(&p, "bridge[%u]: %ps\n", idx++, bridge->funcs);
 		drm_printf(&p, "\ttype: [%d] %s\n",
 			   bridge->type,
 			   drm_get_connector_type_name(bridge->type));
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 19ab0a794add..fd8fa2e0ef6f 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -49,7 +49,7 @@ static LIST_HEAD(panel_list);
  * @dev: parent device of the panel
  * @funcs: panel operations
  * @connector_type: the connector type (DRM_MODE_CONNECTOR_*) corresponding to
- *	the panel interface
+ *	the panel interface (must NOT be DRM_MODE_CONNECTOR_Unknown)
  *
  * Initialize the panel structure for subsequent registration with
  * drm_panel_add().
@@ -57,6 +57,9 @@ static LIST_HEAD(panel_list);
 void drm_panel_init(struct drm_panel *panel, struct device *dev,
 		    const struct drm_panel_funcs *funcs, int connector_type)
 {
+	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
+		DRM_WARN("%s: %s: a valid connector type is required!\n", __func__, dev_name(dev));
+
 	INIT_LIST_HEAD(&panel->list);
 	INIT_LIST_HEAD(&panel->followers);
 	mutex_init(&panel->follower_lock);
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 4a73821b81f6..c554ad8f246b 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -93,6 +93,12 @@ static const struct drm_dmi_panel_orientation_data onegx1_pro = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd640x960_leftside_up = {
+	.width = 640,
+	.height = 960,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd720x1280_rightside_up = {
 	.width = 720,
 	.height = 1280,
@@ -123,6 +129,12 @@ static const struct drm_dmi_panel_orientation_data lcd1080x1920_rightside_up = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd1200x1920_leftside_up = {
+	.width = 1200,
+	.height = 1920,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd1200x1920_rightside_up = {
 	.width = 1200,
 	.height = 1920,
@@ -184,10 +196,10 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T103HAF"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
-	}, {	/* AYA NEO AYANEO 2 */
+	}, {	/* AYA NEO AYANEO 2/2S */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* AYA NEO 2021 */
@@ -202,6 +214,18 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_PRODUCT_NAME, "AIR"),
 		},
 		.driver_data = (void *)&lcd1080x1920_leftside_up,
+	}, {    /* AYA NEO Flip DS Bottom Screen */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "FLIP DS"),
+		},
+		.driver_data = (void *)&lcd640x960_leftside_up,
+	}, {    /* AYA NEO Flip KB/DS Top Screen */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "FLIP"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* AYA NEO Founder */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYA NEO"),
@@ -226,6 +250,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
 		},
 		.driver_data = (void *)&lcd1600x2560_rightside_up,
+	}, {	/* AYA NEO SLIDE */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "SLIDE"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {    /* AYN Loki Max */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
@@ -315,6 +345,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
 		},
 		.driver_data = (void *)&gpd_win2,
+	}, {	/* GPD Win 2 (correct DMI strings) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "WIN2")
+		},
+		.driver_data = (void *)&lcd720x1280_rightside_up,
 	}, {	/* GPD Win 3 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
@@ -443,6 +479,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
 		},
 		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OneXPlayer Mini (Intel) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK TECHNOLOGY CO., LTD."),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
+		},
+		.driver_data = (void *)&lcd1200x1920_leftside_up,
 	}, {	/* OrangePi Neo */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),
diff --git a/drivers/gpu/drm/i915/gt/intel_rc6.c b/drivers/gpu/drm/i915/gt/intel_rc6.c
index 9378d5901c49..9ca42589da4d 100644
--- a/drivers/gpu/drm/i915/gt/intel_rc6.c
+++ b/drivers/gpu/drm/i915/gt/intel_rc6.c
@@ -117,21 +117,10 @@ static void gen11_rc6_enable(struct intel_rc6 *rc6)
 			GEN6_RC_CTL_RC6_ENABLE |
 			GEN6_RC_CTL_EI_MODE(1);
 
-	/*
-	 * BSpec 52698 - Render powergating must be off.
-	 * FIXME BSpec is outdated, disabling powergating for MTL is just
-	 * temporary wa and should be removed after fixing real cause
-	 * of forcewake timeouts.
-	 */
-	if (IS_GFX_GT_IP_RANGE(gt, IP_VER(12, 70), IP_VER(12, 74)))
-		pg_enable =
-			GEN9_MEDIA_PG_ENABLE |
-			GEN11_MEDIA_SAMPLER_PG_ENABLE;
-	else
-		pg_enable =
-			GEN9_RENDER_PG_ENABLE |
-			GEN9_MEDIA_PG_ENABLE |
-			GEN11_MEDIA_SAMPLER_PG_ENABLE;
+	pg_enable =
+		GEN9_RENDER_PG_ENABLE |
+		GEN9_MEDIA_PG_ENABLE |
+		GEN11_MEDIA_SAMPLER_PG_ENABLE;
 
 	if (GRAPHICS_VER(gt->i915) >= 12 && !IS_DG1(gt->i915)) {
 		for (i = 0; i < I915_MAX_VCS; i++)
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc.c b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
index 2d9152eb7282..24fdce844d9e 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_huc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
@@ -317,6 +317,11 @@ void intel_huc_init_early(struct intel_huc *huc)
 	}
 }
 
+void intel_huc_fini_late(struct intel_huc *huc)
+{
+	delayed_huc_load_fini(huc);
+}
+
 #define HUC_LOAD_MODE_STRING(x) (x ? "GSC" : "legacy")
 static int check_huc_loading_mode(struct intel_huc *huc)
 {
@@ -414,12 +419,6 @@ int intel_huc_init(struct intel_huc *huc)
 
 void intel_huc_fini(struct intel_huc *huc)
 {
-	/*
-	 * the fence is initialized in init_early, so we need to clean it up
-	 * even if HuC loading is off.
-	 */
-	delayed_huc_load_fini(huc);
-
 	if (huc->heci_pkt)
 		i915_vma_unpin_and_release(&huc->heci_pkt, 0);
 
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc.h b/drivers/gpu/drm/i915/gt/uc/intel_huc.h
index ba5cb08e9e7b..09aff3148f7d 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_huc.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_huc.h
@@ -55,6 +55,7 @@ struct intel_huc {
 
 int intel_huc_sanitize(struct intel_huc *huc);
 void intel_huc_init_early(struct intel_huc *huc);
+void intel_huc_fini_late(struct intel_huc *huc);
 int intel_huc_init(struct intel_huc *huc);
 void intel_huc_fini(struct intel_huc *huc);
 void intel_huc_suspend(struct intel_huc *huc);
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_uc.c b/drivers/gpu/drm/i915/gt/uc/intel_uc.c
index 5b8080ec5315..4f751ce74214 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_uc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_uc.c
@@ -136,6 +136,7 @@ void intel_uc_init_late(struct intel_uc *uc)
 
 void intel_uc_driver_late_release(struct intel_uc *uc)
 {
+	intel_huc_fini_late(&uc->huc);
 }
 
 /**
diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index fee76c1d2f45..889281819c5b 100644
--- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
+++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
@@ -23,7 +23,9 @@
 
 #include <linux/random.h>
 
+#include "gt/intel_gt.h"
 #include "gt/intel_gt_pm.h"
+#include "gt/intel_gt_regs.h"
 #include "gt/uc/intel_gsc_fw.h"
 
 #include "i915_driver.h"
@@ -253,11 +255,27 @@ int i915_mock_selftests(void)
 int i915_live_selftests(struct pci_dev *pdev)
 {
 	struct drm_i915_private *i915 = pdev_to_i915(pdev);
+	struct intel_uncore *uncore = &i915->uncore;
 	int err;
+	u32 pg_enable;
+	intel_wakeref_t wakeref;
 
 	if (!i915_selftest.live)
 		return 0;
 
+	/*
+	 * FIXME Disable render powergating, this is temporary wa and should be removed
+	 * after fixing real cause of forcewake timeouts.
+	 */
+	with_intel_runtime_pm(uncore->rpm, wakeref) {
+		if (IS_GFX_GT_IP_RANGE(to_gt(i915), IP_VER(12, 00), IP_VER(12, 74))) {
+			pg_enable = intel_uncore_read(uncore, GEN9_PG_ENABLE);
+			if (pg_enable & GEN9_RENDER_PG_ENABLE)
+				intel_uncore_write_fw(uncore, GEN9_PG_ENABLE,
+						      pg_enable & ~GEN9_RENDER_PG_ENABLE);
+		}
+	}
+
 	__wait_gsc_proxy_completed(i915);
 	__wait_gsc_huc_load_completed(i915);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index a08d20654954..9c11d3158324 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -127,14 +127,14 @@ struct mtk_dpi_yc_limit {
  * @is_ck_de_pol: Support CK/DE polarity.
  * @swap_input_support: Support input swap function.
  * @support_direct_pin: IP supports direct connection to dpi panels.
- * @input_2pixel: Input pixel of dp_intf is 2 pixel per round, so enable this
- *		  config to enable this feature.
  * @dimension_mask: Mask used for HWIDTH, HPORCH, VSYNC_WIDTH and VSYNC_PORCH
  *		    (no shift).
  * @hvsize_mask: Mask of HSIZE and VSIZE mask (no shift).
  * @channel_swap_shift: Shift value of channel swap.
  * @yuv422_en_bit: Enable bit of yuv422.
  * @csc_enable_bit: Enable bit of CSC.
+ * @input_2p_en_bit: Enable bit for input two pixel per round feature.
+ *		     If present, implies that the feature must be enabled.
  * @pixels_per_iter: Quantity of transferred pixels per iteration.
  * @edge_cfg_in_mmsys: If the edge configuration for DPI's output needs to be set in MMSYS.
  */
@@ -148,12 +148,12 @@ struct mtk_dpi_conf {
 	bool is_ck_de_pol;
 	bool swap_input_support;
 	bool support_direct_pin;
-	bool input_2pixel;
 	u32 dimension_mask;
 	u32 hvsize_mask;
 	u32 channel_swap_shift;
 	u32 yuv422_en_bit;
 	u32 csc_enable_bit;
+	u32 input_2p_en_bit;
 	u32 pixels_per_iter;
 	bool edge_cfg_in_mmsys;
 };
@@ -471,6 +471,7 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
 
 	mtk_dpi_disable(dpi);
 	clk_disable_unprepare(dpi->pixel_clk);
+	clk_disable_unprepare(dpi->tvd_clk);
 	clk_disable_unprepare(dpi->engine_clk);
 }
 
@@ -487,6 +488,12 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 		goto err_refcount;
 	}
 
+	ret = clk_prepare_enable(dpi->tvd_clk);
+	if (ret) {
+		dev_err(dpi->dev, "Failed to enable tvd pll: %d\n", ret);
+		goto err_engine;
+	}
+
 	ret = clk_prepare_enable(dpi->pixel_clk);
 	if (ret) {
 		dev_err(dpi->dev, "Failed to enable pixel clock: %d\n", ret);
@@ -496,6 +503,8 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 	return 0;
 
 err_pixel:
+	clk_disable_unprepare(dpi->tvd_clk);
+err_engine:
 	clk_disable_unprepare(dpi->engine_clk);
 err_refcount:
 	dpi->refcount--;
@@ -610,9 +619,9 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 		mtk_dpi_dual_edge(dpi);
 		mtk_dpi_config_disable_edge(dpi);
 	}
-	if (dpi->conf->input_2pixel) {
-		mtk_dpi_mask(dpi, DPI_CON, DPINTF_INPUT_2P_EN,
-			     DPINTF_INPUT_2P_EN);
+	if (dpi->conf->input_2p_en_bit) {
+		mtk_dpi_mask(dpi, DPI_CON, dpi->conf->input_2p_en_bit,
+			     dpi->conf->input_2p_en_bit);
 	}
 	mtk_dpi_sw_reset(dpi, false);
 
@@ -992,12 +1001,12 @@ static const struct mtk_dpi_conf mt8195_dpintf_conf = {
 	.output_fmts = mt8195_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8195_output_fmts),
 	.pixels_per_iter = 4,
-	.input_2pixel = true,
 	.dimension_mask = DPINTF_HPW_MASK,
 	.hvsize_mask = DPINTF_HSIZE_MASK,
 	.channel_swap_shift = DPINTF_CH_SWAP,
 	.yuv422_en_bit = DPINTF_YUV422_EN,
 	.csc_enable_bit = DPINTF_CSC_ENABLE,
+	.input_2p_en_bit = DPINTF_INPUT_2P_EN,
 };
 
 static int mtk_dpi_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/drm/tests/drm_client_modeset_test.c
index 7516f6cb36e4..3e9518d7b8b7 100644
--- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
+++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
@@ -95,6 +95,9 @@ static void drm_test_pick_cmdline_res_1920_1080_60(struct kunit *test)
 	expected_mode = drm_mode_find_dmt(priv->drm, 1920, 1080, 60, false);
 	KUNIT_ASSERT_NOT_NULL(test, expected_mode);
 
+	ret = drm_kunit_add_mode_destroy_action(test, expected_mode);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	KUNIT_ASSERT_TRUE(test,
 			  drm_mode_parse_command_line_for_connector(cmdline,
 								    connector,
diff --git a/drivers/gpu/drm/tests/drm_cmdline_parser_test.c b/drivers/gpu/drm/tests/drm_cmdline_parser_test.c
index 59c8408c453c..1cfcb597b088 100644
--- a/drivers/gpu/drm/tests/drm_cmdline_parser_test.c
+++ b/drivers/gpu/drm/tests/drm_cmdline_parser_test.c
@@ -7,6 +7,7 @@
 #include <kunit/test.h>
 
 #include <drm/drm_connector.h>
+#include <drm/drm_kunit_helpers.h>
 #include <drm/drm_modes.h>
 
 static const struct drm_connector no_connector = {};
@@ -955,8 +956,15 @@ struct drm_cmdline_tv_option_test {
 static void drm_test_cmdline_tv_options(struct kunit *test)
 {
 	const struct drm_cmdline_tv_option_test *params = test->param_value;
-	const struct drm_display_mode *expected_mode = params->mode_fn(NULL);
+	struct drm_display_mode *expected_mode;
 	struct drm_cmdline_mode mode = { };
+	int ret;
+
+	expected_mode = params->mode_fn(NULL);
+	KUNIT_ASSERT_NOT_NULL(test, expected_mode);
+
+	ret = drm_kunit_add_mode_destroy_action(test, expected_mode);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	KUNIT_EXPECT_TRUE(test, drm_mode_parse_command_line_for_connector(params->cmdline,
 									  &no_connector, &mode));
diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 3c0b7824c0be..922c4b6ed1dc 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -319,6 +319,28 @@ static void kunit_action_drm_mode_destroy(void *ptr)
 	drm_mode_destroy(NULL, mode);
 }
 
+/**
+ * drm_kunit_add_mode_destroy_action() - Add a drm_destroy_mode kunit action
+ * @test: The test context object
+ * @mode: The drm_display_mode to destroy eventually
+ *
+ * Registers a kunit action that will destroy the drm_display_mode at
+ * the end of the test.
+ *
+ * If an error occurs, the drm_display_mode will be destroyed.
+ *
+ * Returns:
+ * 0 on success, an error code otherwise.
+ */
+int drm_kunit_add_mode_destroy_action(struct kunit *test,
+				      struct drm_display_mode *mode)
+{
+	return kunit_add_action_or_reset(test,
+					 kunit_action_drm_mode_destroy,
+					 mode);
+}
+EXPORT_SYMBOL_GPL(drm_kunit_add_mode_destroy_action);
+
 /**
  * drm_kunit_display_mode_from_cea_vic() - return a mode for CEA VIC for a KUnit test
  * @test: The test context object
diff --git a/drivers/gpu/drm/tests/drm_modes_test.c b/drivers/gpu/drm/tests/drm_modes_test.c
index 6ed51f99e133..7ba646d87856 100644
--- a/drivers/gpu/drm/tests/drm_modes_test.c
+++ b/drivers/gpu/drm/tests/drm_modes_test.c
@@ -40,6 +40,7 @@ static void drm_test_modes_analog_tv_ntsc_480i(struct kunit *test)
 {
 	struct drm_test_modes_priv *priv = test->priv;
 	struct drm_display_mode *mode;
+	int ret;
 
 	mode = drm_analog_tv_mode(priv->drm,
 				  DRM_MODE_TV_MODE_NTSC,
@@ -47,6 +48,9 @@ static void drm_test_modes_analog_tv_ntsc_480i(struct kunit *test)
 				  true);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
+	ret = drm_kunit_add_mode_destroy_action(test, mode);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	KUNIT_EXPECT_EQ(test, drm_mode_vrefresh(mode), 60);
 	KUNIT_EXPECT_EQ(test, mode->hdisplay, 720);
 
@@ -70,6 +74,7 @@ static void drm_test_modes_analog_tv_ntsc_480i_inlined(struct kunit *test)
 {
 	struct drm_test_modes_priv *priv = test->priv;
 	struct drm_display_mode *expected, *mode;
+	int ret;
 
 	expected = drm_analog_tv_mode(priv->drm,
 				      DRM_MODE_TV_MODE_NTSC,
@@ -77,9 +82,15 @@ static void drm_test_modes_analog_tv_ntsc_480i_inlined(struct kunit *test)
 				      true);
 	KUNIT_ASSERT_NOT_NULL(test, expected);
 
+	ret = drm_kunit_add_mode_destroy_action(test, expected);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	mode = drm_mode_analog_ntsc_480i(priv->drm);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
+	ret = drm_kunit_add_mode_destroy_action(test, mode);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	KUNIT_EXPECT_TRUE(test, drm_mode_equal(expected, mode));
 }
 
@@ -87,6 +98,7 @@ static void drm_test_modes_analog_tv_pal_576i(struct kunit *test)
 {
 	struct drm_test_modes_priv *priv = test->priv;
 	struct drm_display_mode *mode;
+	int ret;
 
 	mode = drm_analog_tv_mode(priv->drm,
 				  DRM_MODE_TV_MODE_PAL,
@@ -94,6 +106,9 @@ static void drm_test_modes_analog_tv_pal_576i(struct kunit *test)
 				  true);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
+	ret = drm_kunit_add_mode_destroy_action(test, mode);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	KUNIT_EXPECT_EQ(test, drm_mode_vrefresh(mode), 50);
 	KUNIT_EXPECT_EQ(test, mode->hdisplay, 720);
 
@@ -117,6 +132,7 @@ static void drm_test_modes_analog_tv_pal_576i_inlined(struct kunit *test)
 {
 	struct drm_test_modes_priv *priv = test->priv;
 	struct drm_display_mode *expected, *mode;
+	int ret;
 
 	expected = drm_analog_tv_mode(priv->drm,
 				      DRM_MODE_TV_MODE_PAL,
@@ -124,9 +140,15 @@ static void drm_test_modes_analog_tv_pal_576i_inlined(struct kunit *test)
 				      true);
 	KUNIT_ASSERT_NOT_NULL(test, expected);
 
+	ret = drm_kunit_add_mode_destroy_action(test, expected);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	mode = drm_mode_analog_pal_576i(priv->drm);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
+	ret = drm_kunit_add_mode_destroy_action(test, mode);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	KUNIT_EXPECT_TRUE(test, drm_mode_equal(expected, mode));
 }
 
diff --git a/drivers/gpu/drm/tests/drm_probe_helper_test.c b/drivers/gpu/drm/tests/drm_probe_helper_test.c
index bc09ff38aca1..db0e4f5df275 100644
--- a/drivers/gpu/drm/tests/drm_probe_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_probe_helper_test.c
@@ -98,7 +98,7 @@ drm_test_connector_helper_tv_get_modes_check(struct kunit *test)
 	struct drm_connector *connector = &priv->connector;
 	struct drm_cmdline_mode *cmdline = &connector->cmdline_mode;
 	struct drm_display_mode *mode;
-	const struct drm_display_mode *expected;
+	struct drm_display_mode *expected;
 	size_t len;
 	int ret;
 
@@ -134,6 +134,9 @@ drm_test_connector_helper_tv_get_modes_check(struct kunit *test)
 
 		KUNIT_EXPECT_TRUE(test, drm_mode_equal(mode, expected));
 		KUNIT_EXPECT_TRUE(test, mode->type & DRM_MODE_TYPE_PREFERRED);
+
+		ret = drm_kunit_add_mode_destroy_action(test, expected);
+		KUNIT_ASSERT_EQ(test, ret, 0);
 	}
 
 	if (params->num_expected_modes >= 2) {
@@ -145,6 +148,9 @@ drm_test_connector_helper_tv_get_modes_check(struct kunit *test)
 
 		KUNIT_EXPECT_TRUE(test, drm_mode_equal(mode, expected));
 		KUNIT_EXPECT_FALSE(test, mode->type & DRM_MODE_TYPE_PREFERRED);
+
+		ret = drm_kunit_add_mode_destroy_action(test, expected);
+		KUNIT_ASSERT_EQ(test, ret, 0);
 	}
 
 	mutex_unlock(&priv->drm->mode_config.mutex);
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 98fe8573e054..17ba15132a98 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -32,6 +32,7 @@
 #include "xe_gt_pagefault.h"
 #include "xe_gt_printk.h"
 #include "xe_gt_sriov_pf.h"
+#include "xe_gt_sriov_vf.h"
 #include "xe_gt_sysfs.h"
 #include "xe_gt_tlb_invalidation.h"
 #include "xe_gt_topology.h"
@@ -647,6 +648,9 @@ static int do_gt_reset(struct xe_gt *gt)
 {
 	int err;
 
+	if (IS_SRIOV_VF(gt_to_xe(gt)))
+		return xe_gt_sriov_vf_reset(gt);
+
 	xe_gsc_wa_14015076503(gt, true);
 
 	xe_mmio_write32(gt, GDRST, GRDOM_FULL);
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_vf.c b/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
index 4ebc82e607af..f982d6f9f218 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
@@ -57,6 +57,22 @@ static int vf_reset_guc_state(struct xe_gt *gt)
 	return err;
 }
 
+/**
+ * xe_gt_sriov_vf_reset - Reset GuC VF internal state.
+ * @gt: the &xe_gt
+ *
+ * It requires functional `GuC MMIO based communication`_.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int xe_gt_sriov_vf_reset(struct xe_gt *gt)
+{
+	if (!xe_device_uc_enabled(gt_to_xe(gt)))
+		return -ENODEV;
+
+	return vf_reset_guc_state(gt);
+}
+
 static int guc_action_match_version(struct xe_guc *guc,
 				    u32 wanted_branch, u32 wanted_major, u32 wanted_minor,
 				    u32 *branch, u32 *major, u32 *minor, u32 *patch)
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_vf.h b/drivers/gpu/drm/xe/xe_gt_sriov_vf.h
index e541ce57bec2..576ff5e795a8 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_vf.h
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_vf.h
@@ -12,6 +12,7 @@ struct drm_printer;
 struct xe_gt;
 struct xe_reg;
 
+int xe_gt_sriov_vf_reset(struct xe_gt *gt);
 int xe_gt_sriov_vf_bootstrap(struct xe_gt *gt);
 int xe_gt_sriov_vf_query_config(struct xe_gt *gt);
 int xe_gt_sriov_vf_connect(struct xe_gt *gt);
diff --git a/drivers/gpu/drm/xe/xe_hw_engine_class_sysfs.c b/drivers/gpu/drm/xe/xe_hw_engine_class_sysfs.c
index b53e8d2accdb..a440442b4d72 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine_class_sysfs.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine_class_sysfs.c
@@ -32,14 +32,61 @@ bool xe_hw_engine_timeout_in_range(u64 timeout, u64 min, u64 max)
 	return timeout >= min && timeout <= max;
 }
 
-static void kobj_xe_hw_engine_release(struct kobject *kobj)
+static void xe_hw_engine_sysfs_kobj_release(struct kobject *kobj)
 {
 	kfree(kobj);
 }
 
+static ssize_t xe_hw_engine_class_sysfs_attr_show(struct kobject *kobj,
+						  struct attribute *attr,
+						  char *buf)
+{
+	struct xe_device *xe = kobj_to_xe(kobj);
+	struct kobj_attribute *kattr;
+	ssize_t ret = -EIO;
+
+	kattr = container_of(attr, struct kobj_attribute, attr);
+	if (kattr->show) {
+		xe_pm_runtime_get(xe);
+		ret = kattr->show(kobj, kattr, buf);
+		xe_pm_runtime_put(xe);
+	}
+
+	return ret;
+}
+
+static ssize_t xe_hw_engine_class_sysfs_attr_store(struct kobject *kobj,
+						   struct attribute *attr,
+						   const char *buf,
+						   size_t count)
+{
+	struct xe_device *xe = kobj_to_xe(kobj);
+	struct kobj_attribute *kattr;
+	ssize_t ret = -EIO;
+
+	kattr = container_of(attr, struct kobj_attribute, attr);
+	if (kattr->store) {
+		xe_pm_runtime_get(xe);
+		ret = kattr->store(kobj, kattr, buf, count);
+		xe_pm_runtime_put(xe);
+	}
+
+	return ret;
+}
+
+static const struct sysfs_ops xe_hw_engine_class_sysfs_ops = {
+	.show = xe_hw_engine_class_sysfs_attr_show,
+	.store = xe_hw_engine_class_sysfs_attr_store,
+};
+
 static const struct kobj_type kobj_xe_hw_engine_type = {
-	.release = kobj_xe_hw_engine_release,
-	.sysfs_ops = &kobj_sysfs_ops
+	.release = xe_hw_engine_sysfs_kobj_release,
+	.sysfs_ops = &xe_hw_engine_class_sysfs_ops,
+};
+
+static const struct kobj_type kobj_xe_hw_engine_type_def = {
+	.release = xe_hw_engine_sysfs_kobj_release,
+	.sysfs_ops = &kobj_sysfs_ops,
 };
 
 static ssize_t job_timeout_max_store(struct kobject *kobj,
@@ -543,7 +590,7 @@ static int xe_add_hw_engine_class_defaults(struct xe_device *xe,
 	if (!kobj)
 		return -ENOMEM;
 
-	kobject_init(kobj, &kobj_xe_hw_engine_type);
+	kobject_init(kobj, &kobj_xe_hw_engine_type_def);
 	err = kobject_add(kobj, parent, "%s", ".defaults");
 	if (err)
 		goto err_object;
@@ -559,57 +606,6 @@ static int xe_add_hw_engine_class_defaults(struct xe_device *xe,
 	return err;
 }
 
-static void xe_hw_engine_sysfs_kobj_release(struct kobject *kobj)
-{
-	kfree(kobj);
-}
-
-static ssize_t xe_hw_engine_class_sysfs_attr_show(struct kobject *kobj,
-						  struct attribute *attr,
-						  char *buf)
-{
-	struct xe_device *xe = kobj_to_xe(kobj);
-	struct kobj_attribute *kattr;
-	ssize_t ret = -EIO;
-
-	kattr = container_of(attr, struct kobj_attribute, attr);
-	if (kattr->show) {
-		xe_pm_runtime_get(xe);
-		ret = kattr->show(kobj, kattr, buf);
-		xe_pm_runtime_put(xe);
-	}
-
-	return ret;
-}
-
-static ssize_t xe_hw_engine_class_sysfs_attr_store(struct kobject *kobj,
-						   struct attribute *attr,
-						   const char *buf,
-						   size_t count)
-{
-	struct xe_device *xe = kobj_to_xe(kobj);
-	struct kobj_attribute *kattr;
-	ssize_t ret = -EIO;
-
-	kattr = container_of(attr, struct kobj_attribute, attr);
-	if (kattr->store) {
-		xe_pm_runtime_get(xe);
-		ret = kattr->store(kobj, kattr, buf, count);
-		xe_pm_runtime_put(xe);
-	}
-
-	return ret;
-}
-
-static const struct sysfs_ops xe_hw_engine_class_sysfs_ops = {
-	.show = xe_hw_engine_class_sysfs_attr_show,
-	.store = xe_hw_engine_class_sysfs_attr_store,
-};
-
-static const struct kobj_type xe_hw_engine_sysfs_kobj_type = {
-	.release = xe_hw_engine_sysfs_kobj_release,
-	.sysfs_ops = &xe_hw_engine_class_sysfs_ops,
-};
 
 static void hw_engine_class_sysfs_fini(void *arg)
 {
@@ -640,7 +636,7 @@ int xe_hw_engine_class_sysfs_init(struct xe_gt *gt)
 	if (!kobj)
 		return -ENOMEM;
 
-	kobject_init(kobj, &xe_hw_engine_sysfs_kobj_type);
+	kobject_init(kobj, &kobj_xe_hw_engine_type);
 
 	err = kobject_add(kobj, gt->sysfs, "engines");
 	if (err)
diff --git a/drivers/gpu/drm/xe/xe_tuning.c b/drivers/gpu/drm/xe/xe_tuning.c
index 0d5e04158917..1fb12da21c9e 100644
--- a/drivers/gpu/drm/xe/xe_tuning.c
+++ b/drivers/gpu/drm/xe/xe_tuning.c
@@ -97,14 +97,6 @@ static const struct xe_rtp_entry_sr engine_tunings[] = {
 };
 
 static const struct xe_rtp_entry_sr lrc_tunings[] = {
-	{ XE_RTP_NAME("Tuning: ganged timer, also known as 16011163337"),
-	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1210), ENGINE_CLASS(RENDER)),
-	  /* read verification is ignored due to 1608008084. */
-	  XE_RTP_ACTIONS(FIELD_SET_NO_READ_MASK(FF_MODE2,
-						FF_MODE2_GS_TIMER_MASK,
-						FF_MODE2_GS_TIMER_224))
-	},
-
 	/* DG2 */
 
 	{ XE_RTP_NAME("Tuning: L3 cache"),
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index 37e592b2bf06..0a1905f8d380 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -606,6 +606,13 @@ static const struct xe_rtp_entry_sr engine_was[] = {
 };
 
 static const struct xe_rtp_entry_sr lrc_was[] = {
+	{ XE_RTP_NAME("16011163337"),
+	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1210), ENGINE_CLASS(RENDER)),
+	  /* read verification is ignored due to 1608008084. */
+	  XE_RTP_ACTIONS(FIELD_SET_NO_READ_MASK(FF_MODE2,
+						FF_MODE2_GS_TIMER_MASK,
+						FF_MODE2_GS_TIMER_224))
+	},
 	{ XE_RTP_NAME("1409342910, 14010698770, 14010443199, 1408979724, 1409178076, 1409207793, 1409217633, 1409252684, 1409347922, 1409142259"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1210)),
 	  XE_RTP_ACTIONS(SET(COMMON_SLICE_CHICKEN3,
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4500d7653b05..95a4ede27099 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1205,6 +1205,20 @@ config HID_U2FZERO
 	  allow setting the brightness to anything but 1, which will
 	  trigger a single blink and immediately reset back to 0.
 
+config HID_UNIVERSAL_PIDFF
+	tristate "universal-pidff: extended USB PID driver compatibility and usage"
+	depends on USB_HID
+	depends on HID_PID
+	help
+	  Extended PID support for selected devices.
+
+	  Contains report fixups, extended usable button range and
+	  pidff quirk management to extend compatibility with slightly
+	  non-compliant USB PID devices and better fuzz/flat values for
+	  high precision direct drive devices.
+
+	  Supports Moza Racing, Cammus, VRS, FFBeast and more.
+
 config HID_WACOM
 	tristate "Wacom Intuos/Graphire tablet support (USB)"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index f2900ee2ef85..27ee02bf6f26 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -139,6 +139,7 @@ hid-uclogic-objs		:= hid-uclogic-core.o \
 				   hid-uclogic-params.o
 obj-$(CONFIG_HID_UCLOGIC)	+= hid-uclogic.o
 obj-$(CONFIG_HID_UDRAW_PS3)	+= hid-udraw-ps3.o
+obj-$(CONFIG_HID_UNIVERSAL_PIDFF)	+= hid-universal-pidff.o
 obj-$(CONFIG_HID_LED)		+= hid-led.o
 obj-$(CONFIG_HID_XIAOMI)	+= hid-xiaomi.o
 obj-$(CONFIG_HID_XINMO)		+= hid-xinmo.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c6ae7c4268b8..92baa34f42f2 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -190,6 +190,12 @@
 #define USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLIGHT 0x8102
 #define USB_DEVICE_ID_APPLE_TOUCHBAR_DISPLAY 0x8302
 
+#define USB_VENDOR_ID_ASETEK			0x2433
+#define USB_DEVICE_ID_ASETEK_INVICTA		0xf300
+#define USB_DEVICE_ID_ASETEK_FORTE		0xf301
+#define USB_DEVICE_ID_ASETEK_LA_PRIMA		0xf303
+#define USB_DEVICE_ID_ASETEK_TONY_KANAAN	0xf306
+
 #define USB_VENDOR_ID_ASUS		0x0486
 #define USB_DEVICE_ID_ASUS_T91MT	0x0185
 #define USB_DEVICE_ID_ASUSTEK_MULTITOUCH_YFO	0x0186
@@ -262,6 +268,10 @@
 #define USB_DEVICE_ID_BTC_EMPREX_REMOTE	0x5578
 #define USB_DEVICE_ID_BTC_EMPREX_REMOTE_2	0x5577
 
+#define USB_VENDOR_ID_CAMMUS		0x3416
+#define USB_DEVICE_ID_CAMMUS_C5		0x0301
+#define USB_DEVICE_ID_CAMMUS_C12	0x0302
+
 #define USB_VENDOR_ID_CANDO		0x2087
 #define USB_DEVICE_ID_CANDO_PIXCIR_MULTI_TOUCH 0x0703
 #define USB_DEVICE_ID_CANDO_MULTI_TOUCH	0x0a01
@@ -453,6 +463,11 @@
 #define USB_VENDOR_ID_EVISION           0x320f
 #define USB_DEVICE_ID_EVISION_ICL01     0x5041
 
+#define USB_VENDOR_ID_FFBEAST		0x045b
+#define USB_DEVICE_ID_FFBEAST_JOYSTICK	0x58f9
+#define USB_DEVICE_ID_FFBEAST_RUDDER	0x5968
+#define USB_DEVICE_ID_FFBEAST_WHEEL	0x59d7
+
 #define USB_VENDOR_ID_FLATFROG		0x25b5
 #define USB_DEVICE_ID_MULTITOUCH_3200	0x0002
 
@@ -813,6 +828,13 @@
 #define I2C_DEVICE_ID_LG_8001		0x8001
 #define I2C_DEVICE_ID_LG_7010		0x7010
 
+#define USB_VENDOR_ID_LITE_STAR		0x11ff
+#define USB_DEVICE_ID_PXN_V10		0x3245
+#define USB_DEVICE_ID_PXN_V12		0x1212
+#define USB_DEVICE_ID_PXN_V12_LITE	0x1112
+#define USB_DEVICE_ID_PXN_V12_LITE_2	0x1211
+#define USB_DEVICE_LITE_STAR_GT987_FF	0x2141
+
 #define USB_VENDOR_ID_LOGITECH		0x046d
 #define USB_DEVICE_ID_LOGITECH_Z_10_SPK	0x0a07
 #define USB_DEVICE_ID_LOGITECH_AUDIOHUB 0x0a0e
@@ -960,6 +982,18 @@
 #define USB_VENDOR_ID_MONTEREY		0x0566
 #define USB_DEVICE_ID_GENIUS_KB29E	0x3004
 
+#define USB_VENDOR_ID_MOZA		0x346e
+#define USB_DEVICE_ID_MOZA_R3		0x0005
+#define USB_DEVICE_ID_MOZA_R3_2		0x0015
+#define USB_DEVICE_ID_MOZA_R5		0x0004
+#define USB_DEVICE_ID_MOZA_R5_2		0x0014
+#define USB_DEVICE_ID_MOZA_R9		0x0002
+#define USB_DEVICE_ID_MOZA_R9_2		0x0012
+#define USB_DEVICE_ID_MOZA_R12		0x0006
+#define USB_DEVICE_ID_MOZA_R12_2	0x0016
+#define USB_DEVICE_ID_MOZA_R16_R21	0x0000
+#define USB_DEVICE_ID_MOZA_R16_R21_2	0x0010
+
 #define USB_VENDOR_ID_MSI		0x1770
 #define USB_DEVICE_ID_MSI_GT683R_LED_PANEL 0xff00
 
@@ -1371,6 +1405,9 @@
 #define USB_DEVICE_ID_VELLEMAN_K8061_FIRST	0x8061
 #define USB_DEVICE_ID_VELLEMAN_K8061_LAST	0x8068
 
+#define USB_VENDOR_ID_VRS	0x0483
+#define USB_DEVICE_ID_VRS_DFP	0xa355
+
 #define USB_VENDOR_ID_VTL		0x0306
 #define USB_DEVICE_ID_VTL_MULTITOUCH_FF3F	0xff3f
 
diff --git a/drivers/hid/hid-universal-pidff.c b/drivers/hid/hid-universal-pidff.c
new file mode 100644
index 000000000000..5b89ec7b5c26
--- /dev/null
+++ b/drivers/hid/hid-universal-pidff.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * HID UNIVERSAL PIDFF
+ * hid-pidff wrapper for PID-enabled devices
+ * Handles device reports, quirks and extends usable button range
+ *
+ * Copyright (c) 2024, 2025 Oleg Makarenko
+ * Copyright (c) 2024, 2025 Tomasz Pakuła
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/input-event-codes.h>
+#include "hid-ids.h"
+#include "usbhid/hid-pidff.h"
+
+#define JOY_RANGE (BTN_DEAD - BTN_JOYSTICK + 1)
+
+/*
+ * Map buttons manually to extend the default joystick button limit
+ */
+static int universal_pidff_input_mapping(struct hid_device *hdev,
+	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
+	unsigned long **bit, int *max)
+{
+	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_BUTTON)
+		return 0;
+
+	if (field->application != HID_GD_JOYSTICK)
+		return 0;
+
+	int button = ((usage->hid - 1) & HID_USAGE);
+	int code = button + BTN_JOYSTICK;
+
+	/* Detect the end of JOYSTICK buttons range */
+	if (code > BTN_DEAD)
+		code = button + KEY_NEXT_FAVORITE - JOY_RANGE;
+
+	/*
+	 * Map overflowing buttons to KEY_RESERVED to not ignore
+	 * them and let them still trigger MSC_SCAN
+	 */
+	if (code > KEY_MAX)
+		code = KEY_RESERVED;
+
+	hid_map_usage(hi, usage, bit, max, EV_KEY, code);
+	hid_dbg(hdev, "Button %d: usage %d", button, code);
+	return 1;
+}
+
+/*
+ * Check if the device is PID and initialize it
+ * Add quirks after initialisation
+ */
+static int universal_pidff_probe(struct hid_device *hdev,
+				 const struct hid_device_id *id)
+{
+	int i, error;
+	error = hid_parse(hdev);
+	if (error) {
+		hid_err(hdev, "HID parse failed\n");
+		goto err;
+	}
+
+	error = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
+	if (error) {
+		hid_err(hdev, "HID hw start failed\n");
+		goto err;
+	}
+
+	/* Check if device contains PID usage page */
+	error = 1;
+	for (i = 0; i < hdev->collection_size; i++)
+		if ((hdev->collection[i].usage & HID_USAGE_PAGE) == HID_UP_PID) {
+			error = 0;
+			hid_dbg(hdev, "PID usage page found\n");
+			break;
+		}
+
+	/*
+	 * Do not fail as this might be the second "device"
+	 * just for additional buttons/axes. Exit cleanly if force
+	 * feedback usage page wasn't found (included devices were
+	 * tested and confirmed to be USB PID after all).
+	 */
+	if (error) {
+		hid_dbg(hdev, "PID usage page not found in the descriptor\n");
+		return 0;
+	}
+
+	/* Check if HID_PID support is enabled */
+	int (*init_function)(struct hid_device *, u32);
+	init_function = hid_pidff_init_with_quirks;
+
+	if (!init_function) {
+		hid_warn(hdev, "HID_PID support not enabled!\n");
+		return 0;
+	}
+
+	error = init_function(hdev, id->driver_data);
+	if (error) {
+		hid_warn(hdev, "Error initialising force feedback\n");
+		goto err;
+	}
+
+	hid_info(hdev, "Universal pidff driver loaded sucessfully!");
+
+	return 0;
+err:
+	return error;
+}
+
+static int universal_pidff_input_configured(struct hid_device *hdev,
+					    struct hid_input *hidinput)
+{
+	int axis;
+	struct input_dev *input = hidinput->input;
+
+	if (!input->absinfo)
+		return 0;
+
+	/* Decrease fuzz and deadzone on available axes */
+	for (axis = ABS_X; axis <= ABS_BRAKE; axis++) {
+		if (!test_bit(axis, input->absbit))
+			continue;
+
+		input_set_abs_params(input, axis,
+			input->absinfo[axis].minimum,
+			input->absinfo[axis].maximum,
+			axis == ABS_X ? 0 : 8, 0);
+	}
+
+	/* Remove fuzz and deadzone from the second joystick axis */
+	if (hdev->vendor == USB_VENDOR_ID_FFBEAST &&
+	    hdev->product == USB_DEVICE_ID_FFBEAST_JOYSTICK)
+		input_set_abs_params(input, ABS_Y,
+			input->absinfo[ABS_Y].minimum,
+			input->absinfo[ABS_Y].maximum, 0, 0);
+
+	return 0;
+}
+
+static const struct hid_device_id universal_pidff_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MOZA, USB_DEVICE_ID_MOZA_R3),
+		.driver_data = HID_PIDFF_QUIRK_FIX_WHEEL_DIRECTION },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MOZA, USB_DEVICE_ID_MOZA_R3_2),
+		.driver_data = HID_PIDFF_QUIRK_FIX_WHEEL_DIRECTION },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MOZA, USB_DEVICE_ID_MOZA_R5),
+		.driver_data = HID_PIDFF_QUIRK_FIX_WHEEL_DIRECTION },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MOZA, USB_DEVICE_ID_MOZA_R5_2),
+		.driver_data = HID_PIDFF_QUIRK_FIX_WHEEL_DIRECTION },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MOZA, USB_DEVICE_ID_MOZA_R9),
+		.driver_data = HID_PIDFF_QUIRK_FIX_WHEEL_DIRECTION },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MOZA, USB_DEVICE_ID_MOZA_R9_2),
+		.driver_data = HID_PIDFF_QUIRK_FIX_WHEEL_DIRECTION },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MOZA, USB_DEVICE_ID_MOZA_R12),
+		.driver_data = HID_PIDFF_QUIRK_FIX_WHEEL_DIRECTION },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MOZA, USB_DEVICE_ID_MOZA_R12_2),
+		.driver_data = HID_PIDFF_QUIRK_FIX_WHEEL_DIRECTION },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MOZA, USB_DEVICE_ID_MOZA_R16_R21),
+		.driver_data = HID_PIDFF_QUIRK_FIX_WHEEL_DIRECTION },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MOZA, USB_DEVICE_ID_MOZA_R16_R21_2),
+		.driver_data = HID_PIDFF_QUIRK_FIX_WHEEL_DIRECTION },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CAMMUS, USB_DEVICE_ID_CAMMUS_C5) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CAMMUS, USB_DEVICE_ID_CAMMUS_C12) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_VRS, USB_DEVICE_ID_VRS_DFP),
+		.driver_data = HID_PIDFF_QUIRK_PERMISSIVE_CONTROL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_FFBEAST, USB_DEVICE_ID_FFBEAST_JOYSTICK), },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_FFBEAST, USB_DEVICE_ID_FFBEAST_RUDDER), },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_FFBEAST, USB_DEVICE_ID_FFBEAST_WHEEL) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LITE_STAR, USB_DEVICE_ID_PXN_V10),
+		.driver_data = HID_PIDFF_QUIRK_PERIODIC_SINE_ONLY },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LITE_STAR, USB_DEVICE_ID_PXN_V12),
+		.driver_data = HID_PIDFF_QUIRK_PERIODIC_SINE_ONLY },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LITE_STAR, USB_DEVICE_ID_PXN_V12_LITE),
+		.driver_data = HID_PIDFF_QUIRK_PERIODIC_SINE_ONLY },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LITE_STAR, USB_DEVICE_ID_PXN_V12_LITE_2),
+		.driver_data = HID_PIDFF_QUIRK_PERIODIC_SINE_ONLY },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LITE_STAR, USB_DEVICE_LITE_STAR_GT987_FF),
+		.driver_data = HID_PIDFF_QUIRK_PERIODIC_SINE_ONLY },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASETEK, USB_DEVICE_ID_ASETEK_INVICTA) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASETEK, USB_DEVICE_ID_ASETEK_FORTE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASETEK, USB_DEVICE_ID_ASETEK_LA_PRIMA) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASETEK, USB_DEVICE_ID_ASETEK_TONY_KANAAN) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, universal_pidff_devices);
+
+static struct hid_driver universal_pidff = {
+	.name = "hid-universal-pidff",
+	.id_table = universal_pidff_devices,
+	.input_mapping = universal_pidff_input_mapping,
+	.probe = universal_pidff_probe,
+	.input_configured = universal_pidff_input_configured
+};
+module_hid_driver(universal_pidff);
+
+MODULE_DESCRIPTION("Universal driver for USB PID Force Feedback devices");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Oleg Makarenko <oleg@makarenk.ooo>");
+MODULE_AUTHOR("Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>");
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index a9e85bdd4cc6..bf0f51ef0149 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -35,6 +35,7 @@
 #include <linux/hid-debug.h>
 #include <linux/hidraw.h>
 #include "usbhid.h"
+#include "hid-pidff.h"
 
 /*
  * Version Information
diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 3b4ee21cd811..8dfd2c554a27 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -3,27 +3,27 @@
  *  Force feedback driver for USB HID PID compliant devices
  *
  *  Copyright (c) 2005, 2006 Anssi Hannula <anssi.hannula@gmail.com>
+ *  Upgraded 2025 by Oleg Makarenko and Tomasz Pakuła
  */
 
-/*
- */
-
-/* #define DEBUG */
-
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include "hid-pidff.h"
 #include <linux/input.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
-
 #include <linux/hid.h>
+#include <linux/minmax.h>
 
-#include "usbhid.h"
 
 #define	PID_EFFECTS_MAX		64
+#define	PID_INFINITE		U16_MAX
 
-/* Report usage table used to put reports into an array */
+/* Linux Force Feedback API uses miliseconds as time unit */
+#define FF_TIME_EXPONENT	-3
+#define FF_INFINITE		0
 
+/* Report usage table used to put reports into an array */
 #define PID_SET_EFFECT		0
 #define PID_EFFECT_OPERATION	1
 #define PID_DEVICE_GAIN		2
@@ -44,12 +44,19 @@ static const u8 pidff_reports[] = {
 	0x21, 0x77, 0x7d, 0x7f, 0x89, 0x90, 0x96, 0xab,
 	0x5a, 0x5f, 0x6e, 0x73, 0x74
 };
+/*
+ * device_control is really 0x95, but 0x96 specified
+ * as it is the usage of the only field in that report.
+ */
 
-/* device_control is really 0x95, but 0x96 specified as it is the usage of
-the only field in that report */
+/* PID special fields */
+#define PID_EFFECT_TYPE			0x25
+#define PID_DIRECTION			0x57
+#define PID_EFFECT_OPERATION_ARRAY	0x78
+#define PID_BLOCK_LOAD_STATUS		0x8b
+#define PID_DEVICE_CONTROL_ARRAY	0x96
 
 /* Value usage tables used to put fields and values into arrays */
-
 #define PID_EFFECT_BLOCK_INDEX	0
 
 #define PID_DURATION		1
@@ -107,10 +114,13 @@ static const u8 pidff_device_gain[] = { 0x7e };
 static const u8 pidff_pool[] = { 0x80, 0x83, 0xa9 };
 
 /* Special field key tables used to put special field keys into arrays */
-
 #define PID_ENABLE_ACTUATORS	0
-#define PID_RESET		1
-static const u8 pidff_device_control[] = { 0x97, 0x9a };
+#define PID_DISABLE_ACTUATORS	1
+#define PID_STOP_ALL_EFFECTS	2
+#define PID_RESET		3
+#define PID_PAUSE		4
+#define PID_CONTINUE		5
+static const u8 pidff_device_control[] = { 0x97, 0x98, 0x99, 0x9a, 0x9b, 0x9c };
 
 #define PID_CONSTANT	0
 #define PID_RAMP	1
@@ -130,12 +140,16 @@ static const u8 pidff_effect_types[] = {
 
 #define PID_BLOCK_LOAD_SUCCESS	0
 #define PID_BLOCK_LOAD_FULL	1
-static const u8 pidff_block_load_status[] = { 0x8c, 0x8d };
+#define PID_BLOCK_LOAD_ERROR	2
+static const u8 pidff_block_load_status[] = { 0x8c, 0x8d, 0x8e};
 
 #define PID_EFFECT_START	0
 #define PID_EFFECT_STOP		1
 static const u8 pidff_effect_operation_status[] = { 0x79, 0x7b };
 
+/* Polar direction 90 degrees (East) */
+#define PIDFF_FIXED_WHEEL_DIRECTION	0x4000
+
 struct pidff_usage {
 	struct hid_field *field;
 	s32 *value;
@@ -159,8 +173,10 @@ struct pidff_device {
 	struct pidff_usage effect_operation[sizeof(pidff_effect_operation)];
 	struct pidff_usage block_free[sizeof(pidff_block_free)];
 
-	/* Special field is a field that is not composed of
-	   usage<->value pairs that pidff_usage values are */
+	/*
+	 * Special field is a field that is not composed of
+	 * usage<->value pairs that pidff_usage values are
+	 */
 
 	/* Special field in create_new_effect */
 	struct hid_field *create_new_effect_type;
@@ -184,30 +200,61 @@ struct pidff_device {
 	int operation_id[sizeof(pidff_effect_operation_status)];
 
 	int pid_id[PID_EFFECTS_MAX];
+
+	u32 quirks;
+	u8 effect_count;
 };
 
+/*
+ * Clamp value for a given field
+ */
+static s32 pidff_clamp(s32 i, struct hid_field *field)
+{
+	s32 clamped = clamp(i, field->logical_minimum, field->logical_maximum);
+	pr_debug("clamped from %d to %d", i, clamped);
+	return clamped;
+}
+
 /*
  * Scale an unsigned value with range 0..max for the given field
  */
 static int pidff_rescale(int i, int max, struct hid_field *field)
 {
 	return i * (field->logical_maximum - field->logical_minimum) / max +
-	    field->logical_minimum;
+		field->logical_minimum;
 }
 
 /*
- * Scale a signed value in range -0x8000..0x7fff for the given field
+ * Scale a signed value in range S16_MIN..S16_MAX for the given field
  */
 static int pidff_rescale_signed(int i, struct hid_field *field)
 {
-	return i == 0 ? 0 : i >
-	    0 ? i * field->logical_maximum / 0x7fff : i *
-	    field->logical_minimum / -0x8000;
+	if (i > 0) return i * field->logical_maximum / S16_MAX;
+	if (i < 0) return i * field->logical_minimum / S16_MIN;
+	return 0;
+}
+
+/*
+ * Scale time value from Linux default (ms) to field units
+ */
+static u32 pidff_rescale_time(u16 time, struct hid_field *field)
+{
+	u32 scaled_time = time;
+	int exponent = field->unit_exponent;
+	pr_debug("time field exponent: %d\n", exponent);
+
+	for (;exponent < FF_TIME_EXPONENT; exponent++)
+		scaled_time *= 10;
+	for (;exponent > FF_TIME_EXPONENT; exponent--)
+		scaled_time /= 10;
+
+	pr_debug("time calculated from %d to %d\n", time, scaled_time);
+	return scaled_time;
 }
 
 static void pidff_set(struct pidff_usage *usage, u16 value)
 {
-	usage->value[0] = pidff_rescale(value, 0xffff, usage->field);
+	usage->value[0] = pidff_rescale(value, U16_MAX, usage->field);
 	pr_debug("calculated from %d to %d\n", value, usage->value[0]);
 }
 
@@ -218,14 +265,35 @@ static void pidff_set_signed(struct pidff_usage *usage, s16 value)
 	else {
 		if (value < 0)
 			usage->value[0] =
-			    pidff_rescale(-value, 0x8000, usage->field);
+			    pidff_rescale(-value, -S16_MIN, usage->field);
 		else
 			usage->value[0] =
-			    pidff_rescale(value, 0x7fff, usage->field);
+			    pidff_rescale(value, S16_MAX, usage->field);
 	}
 	pr_debug("calculated from %d to %d\n", value, usage->value[0]);
 }
 
+static void pidff_set_time(struct pidff_usage *usage, u16 time)
+{
+	u32 modified_time = pidff_rescale_time(time, usage->field);
+	usage->value[0] = pidff_clamp(modified_time, usage->field);
+}
+
+static void pidff_set_duration(struct pidff_usage *usage, u16 duration)
+{
+	/* Infinite value conversion from Linux API -> PID */
+	if (duration == FF_INFINITE)
+		duration = PID_INFINITE;
+
+	/* PID defines INFINITE as the max possible value for duration field */
+	if (duration == PID_INFINITE) {
+		usage->value[0] = (1U << usage->field->report_size) - 1;
+		return;
+	}
+
+	pidff_set_time(usage, duration);
+}
+
 /*
  * Send envelope report to the device
  */
@@ -233,19 +301,21 @@ static void pidff_set_envelope_report(struct pidff_device *pidff,
 				      struct ff_envelope *envelope)
 {
 	pidff->set_envelope[PID_EFFECT_BLOCK_INDEX].value[0] =
-	    pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
+		pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
 
 	pidff->set_envelope[PID_ATTACK_LEVEL].value[0] =
-	    pidff_rescale(envelope->attack_level >
-			  0x7fff ? 0x7fff : envelope->attack_level, 0x7fff,
-			  pidff->set_envelope[PID_ATTACK_LEVEL].field);
+		pidff_rescale(envelope->attack_level >
+			S16_MAX ? S16_MAX : envelope->attack_level, S16_MAX,
+			pidff->set_envelope[PID_ATTACK_LEVEL].field);
 	pidff->set_envelope[PID_FADE_LEVEL].value[0] =
-	    pidff_rescale(envelope->fade_level >
-			  0x7fff ? 0x7fff : envelope->fade_level, 0x7fff,
-			  pidff->set_envelope[PID_FADE_LEVEL].field);
+		pidff_rescale(envelope->fade_level >
+			S16_MAX ? S16_MAX : envelope->fade_level, S16_MAX,
+			pidff->set_envelope[PID_FADE_LEVEL].field);
 
-	pidff->set_envelope[PID_ATTACK_TIME].value[0] = envelope->attack_length;
-	pidff->set_envelope[PID_FADE_TIME].value[0] = envelope->fade_length;
+	pidff_set_time(&pidff->set_envelope[PID_ATTACK_TIME],
+			envelope->attack_length);
+	pidff_set_time(&pidff->set_envelope[PID_FADE_TIME],
+			envelope->fade_length);
 
 	hid_dbg(pidff->hid, "attack %u => %d\n",
 		envelope->attack_level,
@@ -261,10 +331,22 @@ static void pidff_set_envelope_report(struct pidff_device *pidff,
 static int pidff_needs_set_envelope(struct ff_envelope *envelope,
 				    struct ff_envelope *old)
 {
-	return envelope->attack_level != old->attack_level ||
-	       envelope->fade_level != old->fade_level ||
+	bool needs_new_envelope;
+	needs_new_envelope = envelope->attack_level  != 0 ||
+			     envelope->fade_level    != 0 ||
+			     envelope->attack_length != 0 ||
+			     envelope->fade_length   != 0;
+
+	if (!needs_new_envelope)
+		return false;
+
+	if (!old)
+		return needs_new_envelope;
+
+	return envelope->attack_level  != old->attack_level  ||
+	       envelope->fade_level    != old->fade_level    ||
 	       envelope->attack_length != old->attack_length ||
-	       envelope->fade_length != old->fade_length;
+	       envelope->fade_length   != old->fade_length;
 }
 
 /*
@@ -301,17 +383,27 @@ static void pidff_set_effect_report(struct pidff_device *pidff,
 		pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
 	pidff->set_effect_type->value[0] =
 		pidff->create_new_effect_type->value[0];
-	pidff->set_effect[PID_DURATION].value[0] = effect->replay.length;
+
+	pidff_set_duration(&pidff->set_effect[PID_DURATION],
+		effect->replay.length);
+
 	pidff->set_effect[PID_TRIGGER_BUTTON].value[0] = effect->trigger.button;
-	pidff->set_effect[PID_TRIGGER_REPEAT_INT].value[0] =
-		effect->trigger.interval;
+	pidff_set_time(&pidff->set_effect[PID_TRIGGER_REPEAT_INT],
+			effect->trigger.interval);
 	pidff->set_effect[PID_GAIN].value[0] =
 		pidff->set_effect[PID_GAIN].field->logical_maximum;
 	pidff->set_effect[PID_DIRECTION_ENABLE].value[0] = 1;
-	pidff->effect_direction->value[0] =
-		pidff_rescale(effect->direction, 0xffff,
-				pidff->effect_direction);
-	pidff->set_effect[PID_START_DELAY].value[0] = effect->replay.delay;
+
+	/* Use fixed direction if needed */
+	pidff->effect_direction->value[0] = pidff_rescale(
+		pidff->quirks & HID_PIDFF_QUIRK_FIX_WHEEL_DIRECTION ?
+		PIDFF_FIXED_WHEEL_DIRECTION : effect->direction,
+		U16_MAX, pidff->effect_direction);
+
+	/* Omit setting delay field if it's missing */
+	if (!(pidff->quirks & HID_PIDFF_QUIRK_MISSING_DELAY))
+		pidff_set_time(&pidff->set_effect[PID_START_DELAY],
+				effect->replay.delay);
 
 	hid_hw_request(pidff->hid, pidff->reports[PID_SET_EFFECT],
 			HID_REQ_SET_REPORT);
@@ -343,11 +435,11 @@ static void pidff_set_periodic_report(struct pidff_device *pidff,
 	pidff_set_signed(&pidff->set_periodic[PID_OFFSET],
 			 effect->u.periodic.offset);
 	pidff_set(&pidff->set_periodic[PID_PHASE], effect->u.periodic.phase);
-	pidff->set_periodic[PID_PERIOD].value[0] = effect->u.periodic.period;
+	pidff_set_time(&pidff->set_periodic[PID_PERIOD],
+			effect->u.periodic.period);
 
 	hid_hw_request(pidff->hid, pidff->reports[PID_SET_PERIODIC],
 			HID_REQ_SET_REPORT);
-
 }
 
 /*
@@ -368,13 +460,19 @@ static int pidff_needs_set_periodic(struct ff_effect *effect,
 static void pidff_set_condition_report(struct pidff_device *pidff,
 				       struct ff_effect *effect)
 {
-	int i;
+	int i, max_axis;
+
+	/* Devices missing Parameter Block Offset can only have one axis */
+	max_axis = pidff->quirks & HID_PIDFF_QUIRK_MISSING_PBO ? 1 : 2;
 
 	pidff->set_condition[PID_EFFECT_BLOCK_INDEX].value[0] =
 		pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
 
-	for (i = 0; i < 2; i++) {
-		pidff->set_condition[PID_PARAM_BLOCK_OFFSET].value[0] = i;
+	for (i = 0; i < max_axis; i++) {
+		/* Omit Parameter Block Offset if missing */
+		if (!(pidff->quirks & HID_PIDFF_QUIRK_MISSING_PBO))
+			pidff->set_condition[PID_PARAM_BLOCK_OFFSET].value[0] = i;
+
 		pidff_set_signed(&pidff->set_condition[PID_CP_OFFSET],
 				 effect->u.condition[i].center);
 		pidff_set_signed(&pidff->set_condition[PID_POS_COEFFICIENT],
@@ -441,9 +539,104 @@ static int pidff_needs_set_ramp(struct ff_effect *effect, struct ff_effect *old)
 	       effect->u.ramp.end_level != old->u.ramp.end_level;
 }
 
+/*
+ * Set device gain
+ */
+static void pidff_set_gain_report(struct pidff_device *pidff, u16 gain)
+{
+	if (!pidff->device_gain[PID_DEVICE_GAIN_FIELD].field)
+		return;
+
+	pidff_set(&pidff->device_gain[PID_DEVICE_GAIN_FIELD], gain);
+	hid_hw_request(pidff->hid, pidff->reports[PID_DEVICE_GAIN],
+			HID_REQ_SET_REPORT);
+}
+
+/*
+ * Send device control report to the device
+ */
+static void pidff_set_device_control(struct pidff_device *pidff, int field)
+{
+	int i, index;
+	int field_index = pidff->control_id[field];
+
+	if (field_index < 1)
+		return;
+
+	/* Detect if the field is a bitmask variable or an array */
+	if (pidff->device_control->flags & HID_MAIN_ITEM_VARIABLE) {
+		hid_dbg(pidff->hid, "DEVICE_CONTROL is a bitmask\n");
+
+		/* Clear current bitmask */
+		for(i = 0; i < sizeof(pidff_device_control); i++) {
+			index = pidff->control_id[i];
+			if (index < 1)
+				continue;
+
+			pidff->device_control->value[index - 1] = 0;
+		}
+
+		pidff->device_control->value[field_index - 1] = 1;
+	} else {
+		hid_dbg(pidff->hid, "DEVICE_CONTROL is an array\n");
+		pidff->device_control->value[0] = field_index;
+	}
+
+	hid_hw_request(pidff->hid, pidff->reports[PID_DEVICE_CONTROL], HID_REQ_SET_REPORT);
+	hid_hw_wait(pidff->hid);
+}
+
+/*
+ * Modify actuators state
+ */
+static void pidff_set_actuators(struct pidff_device *pidff, bool enable)
+{
+	hid_dbg(pidff->hid, "%s actuators\n", enable ? "Enable" : "Disable");
+	pidff_set_device_control(pidff,
+		enable ? PID_ENABLE_ACTUATORS : PID_DISABLE_ACTUATORS);
+}
+
+/*
+ * Reset the device, stop all effects, enable actuators
+ */
+static void pidff_reset(struct pidff_device *pidff)
+{
+	/* We reset twice as sometimes hid_wait_io isn't waiting long enough */
+	pidff_set_device_control(pidff, PID_RESET);
+	pidff_set_device_control(pidff, PID_RESET);
+	pidff->effect_count = 0;
+
+	pidff_set_device_control(pidff, PID_STOP_ALL_EFFECTS);
+	pidff_set_actuators(pidff, 1);
+}
+
+/*
+ * Fetch pool report
+ */
+static void pidff_fetch_pool(struct pidff_device *pidff)
+{
+	int i;
+	struct hid_device *hid = pidff->hid;
+
+	/* Repeat if PID_SIMULTANEOUS_MAX < 2 to make sure it's correct */
+	for(i = 0; i < 20; i++) {
+		hid_hw_request(hid, pidff->reports[PID_POOL], HID_REQ_GET_REPORT);
+		hid_hw_wait(hid);
+
+		if (!pidff->pool[PID_SIMULTANEOUS_MAX].value)
+			return;
+		if (pidff->pool[PID_SIMULTANEOUS_MAX].value[0] >= 2)
+			return;
+	}
+	hid_warn(hid, "device reports %d simultaneous effects\n",
+		 pidff->pool[PID_SIMULTANEOUS_MAX].value[0]);
+}
+
 /*
  * Send a request for effect upload to the device
  *
+ * Reset and enable actuators if no effects were present on the device
+ *
  * Returns 0 if device reported success, -ENOSPC if the device reported memory
  * is full. Upon unknown response the function will retry for 60 times, if
  * still unsuccessful -EIO is returned.
@@ -452,6 +645,9 @@ static int pidff_request_effect_upload(struct pidff_device *pidff, int efnum)
 {
 	int j;
 
+	if (!pidff->effect_count)
+		pidff_reset(pidff);
+
 	pidff->create_new_effect_type->value[0] = efnum;
 	hid_hw_request(pidff->hid, pidff->reports[PID_CREATE_NEW_EFFECT],
 			HID_REQ_SET_REPORT);
@@ -471,6 +667,8 @@ static int pidff_request_effect_upload(struct pidff_device *pidff, int efnum)
 			hid_dbg(pidff->hid, "device reported free memory: %d bytes\n",
 				 pidff->block_load[PID_RAM_POOL_AVAILABLE].value ?
 				 pidff->block_load[PID_RAM_POOL_AVAILABLE].value[0] : -1);
+
+			pidff->effect_count++;
 			return 0;
 		}
 		if (pidff->block_load_status->value[0] ==
@@ -480,6 +678,11 @@ static int pidff_request_effect_upload(struct pidff_device *pidff, int efnum)
 				pidff->block_load[PID_RAM_POOL_AVAILABLE].value[0] : -1);
 			return -ENOSPC;
 		}
+		if (pidff->block_load_status->value[0] ==
+		    pidff->status_id[PID_BLOCK_LOAD_ERROR]) {
+			hid_dbg(pidff->hid, "device error during effect creation\n");
+			return -EREMOTEIO;
+		}
 	}
 	hid_err(pidff->hid, "pid_block_load failed 60 times\n");
 	return -EIO;
@@ -498,7 +701,8 @@ static void pidff_playback_pid(struct pidff_device *pidff, int pid_id, int n)
 	} else {
 		pidff->effect_operation_status->value[0] =
 			pidff->operation_id[PID_EFFECT_START];
-		pidff->effect_operation[PID_LOOP_COUNT].value[0] = n;
+		pidff->effect_operation[PID_LOOP_COUNT].value[0] =
+			pidff_clamp(n, pidff->effect_operation[PID_LOOP_COUNT].field);
 	}
 
 	hid_hw_request(pidff->hid, pidff->reports[PID_EFFECT_OPERATION],
@@ -511,20 +715,22 @@ static void pidff_playback_pid(struct pidff_device *pidff, int pid_id, int n)
 static int pidff_playback(struct input_dev *dev, int effect_id, int value)
 {
 	struct pidff_device *pidff = dev->ff->private;
-
 	pidff_playback_pid(pidff, pidff->pid_id[effect_id], value);
-
 	return 0;
 }
 
 /*
  * Erase effect with PID id
+ * Decrease the device effect counter
  */
 static void pidff_erase_pid(struct pidff_device *pidff, int pid_id)
 {
 	pidff->block_free[PID_EFFECT_BLOCK_INDEX].value[0] = pid_id;
 	hid_hw_request(pidff->hid, pidff->reports[PID_BLOCK_FREE],
 			HID_REQ_SET_REPORT);
+
+	if (pidff->effect_count > 0)
+		pidff->effect_count--;
 }
 
 /*
@@ -537,8 +743,11 @@ static int pidff_erase_effect(struct input_dev *dev, int effect_id)
 
 	hid_dbg(pidff->hid, "starting to erase %d/%d\n",
 		effect_id, pidff->pid_id[effect_id]);
-	/* Wait for the queue to clear. We do not want a full fifo to
-	   prevent the effect removal. */
+
+	/*
+	 * Wait for the queue to clear. We do not want
+	 * a full fifo to prevent the effect removal.
+	 */
 	hid_hw_wait(pidff->hid);
 	pidff_playback_pid(pidff, pid_id, 0);
 	pidff_erase_pid(pidff, pid_id);
@@ -574,11 +783,9 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 			pidff_set_effect_report(pidff, effect);
 		if (!old || pidff_needs_set_constant(effect, old))
 			pidff_set_constant_force_report(pidff, effect);
-		if (!old ||
-		    pidff_needs_set_envelope(&effect->u.constant.envelope,
-					&old->u.constant.envelope))
-			pidff_set_envelope_report(pidff,
-					&effect->u.constant.envelope);
+		if (pidff_needs_set_envelope(&effect->u.constant.envelope,
+					old ? &old->u.constant.envelope : NULL))
+			pidff_set_envelope_report(pidff, &effect->u.constant.envelope);
 		break;
 
 	case FF_PERIODIC:
@@ -604,6 +811,9 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 				return -EINVAL;
 			}
 
+			if (pidff->quirks & HID_PIDFF_QUIRK_PERIODIC_SINE_ONLY)
+				type_id = PID_SINE;
+
 			error = pidff_request_effect_upload(pidff,
 					pidff->type_id[type_id]);
 			if (error)
@@ -613,11 +823,9 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 			pidff_set_effect_report(pidff, effect);
 		if (!old || pidff_needs_set_periodic(effect, old))
 			pidff_set_periodic_report(pidff, effect);
-		if (!old ||
-		    pidff_needs_set_envelope(&effect->u.periodic.envelope,
-					&old->u.periodic.envelope))
-			pidff_set_envelope_report(pidff,
-					&effect->u.periodic.envelope);
+		if (pidff_needs_set_envelope(&effect->u.periodic.envelope,
+					old ? &old->u.periodic.envelope : NULL))
+			pidff_set_envelope_report(pidff, &effect->u.periodic.envelope);
 		break;
 
 	case FF_RAMP:
@@ -631,56 +839,32 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 			pidff_set_effect_report(pidff, effect);
 		if (!old || pidff_needs_set_ramp(effect, old))
 			pidff_set_ramp_force_report(pidff, effect);
-		if (!old ||
-		    pidff_needs_set_envelope(&effect->u.ramp.envelope,
-					&old->u.ramp.envelope))
-			pidff_set_envelope_report(pidff,
-					&effect->u.ramp.envelope);
+		if (pidff_needs_set_envelope(&effect->u.ramp.envelope,
+					old ? &old->u.ramp.envelope : NULL))
+			pidff_set_envelope_report(pidff, &effect->u.ramp.envelope);
 		break;
 
 	case FF_SPRING:
-		if (!old) {
-			error = pidff_request_effect_upload(pidff,
-					pidff->type_id[PID_SPRING]);
-			if (error)
-				return error;
-		}
-		if (!old || pidff_needs_set_effect(effect, old))
-			pidff_set_effect_report(pidff, effect);
-		if (!old || pidff_needs_set_condition(effect, old))
-			pidff_set_condition_report(pidff, effect);
-		break;
-
-	case FF_FRICTION:
-		if (!old) {
-			error = pidff_request_effect_upload(pidff,
-					pidff->type_id[PID_FRICTION]);
-			if (error)
-				return error;
-		}
-		if (!old || pidff_needs_set_effect(effect, old))
-			pidff_set_effect_report(pidff, effect);
-		if (!old || pidff_needs_set_condition(effect, old))
-			pidff_set_condition_report(pidff, effect);
-		break;
-
 	case FF_DAMPER:
-		if (!old) {
-			error = pidff_request_effect_upload(pidff,
-					pidff->type_id[PID_DAMPER]);
-			if (error)
-				return error;
-		}
-		if (!old || pidff_needs_set_effect(effect, old))
-			pidff_set_effect_report(pidff, effect);
-		if (!old || pidff_needs_set_condition(effect, old))
-			pidff_set_condition_report(pidff, effect);
-		break;
-
 	case FF_INERTIA:
+	case FF_FRICTION:
 		if (!old) {
+			switch(effect->type) {
+			case FF_SPRING:
+				type_id = PID_SPRING;
+				break;
+			case FF_DAMPER:
+				type_id = PID_DAMPER;
+				break;
+			case FF_INERTIA:
+				type_id = PID_INERTIA;
+				break;
+			case FF_FRICTION:
+				type_id = PID_FRICTION;
+				break;
+			}
 			error = pidff_request_effect_upload(pidff,
-					pidff->type_id[PID_INERTIA]);
+					pidff->type_id[type_id]);
 			if (error)
 				return error;
 		}
@@ -709,11 +893,7 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
  */
 static void pidff_set_gain(struct input_dev *dev, u16 gain)
 {
-	struct pidff_device *pidff = dev->ff->private;
-
-	pidff_set(&pidff->device_gain[PID_DEVICE_GAIN_FIELD], gain);
-	hid_hw_request(pidff->hid, pidff->reports[PID_DEVICE_GAIN],
-			HID_REQ_SET_REPORT);
+	pidff_set_gain_report(dev->ff->private, gain);
 }
 
 static void pidff_autocenter(struct pidff_device *pidff, u16 magnitude)
@@ -736,7 +916,10 @@ static void pidff_autocenter(struct pidff_device *pidff, u16 magnitude)
 	pidff->set_effect[PID_TRIGGER_REPEAT_INT].value[0] = 0;
 	pidff_set(&pidff->set_effect[PID_GAIN], magnitude);
 	pidff->set_effect[PID_DIRECTION_ENABLE].value[0] = 1;
-	pidff->set_effect[PID_START_DELAY].value[0] = 0;
+
+	/* Omit setting delay field if it's missing */
+	if (!(pidff->quirks & HID_PIDFF_QUIRK_MISSING_DELAY))
+		pidff->set_effect[PID_START_DELAY].value[0] = 0;
 
 	hid_hw_request(pidff->hid, pidff->reports[PID_SET_EFFECT],
 			HID_REQ_SET_REPORT);
@@ -747,9 +930,7 @@ static void pidff_autocenter(struct pidff_device *pidff, u16 magnitude)
  */
 static void pidff_set_autocenter(struct input_dev *dev, u16 magnitude)
 {
-	struct pidff_device *pidff = dev->ff->private;
-
-	pidff_autocenter(pidff, magnitude);
+	pidff_autocenter(dev->ff->private, magnitude);
 }
 
 /*
@@ -758,7 +939,13 @@ static void pidff_set_autocenter(struct input_dev *dev, u16 magnitude)
 static int pidff_find_fields(struct pidff_usage *usage, const u8 *table,
 			     struct hid_report *report, int count, int strict)
 {
+	if (!report) {
+		pr_debug("pidff_find_fields, null report\n");
+		return -1;
+	}
+
 	int i, j, k, found;
+	int return_value = 0;
 
 	for (k = 0; k < count; k++) {
 		found = 0;
@@ -783,12 +970,22 @@ static int pidff_find_fields(struct pidff_usage *usage, const u8 *table,
 			if (found)
 				break;
 		}
-		if (!found && strict) {
+		if (!found && table[k] == pidff_set_effect[PID_START_DELAY]) {
+			pr_debug("Delay field not found, but that's OK\n");
+			pr_debug("Setting MISSING_DELAY quirk\n");
+			return_value |= HID_PIDFF_QUIRK_MISSING_DELAY;
+		}
+		else if (!found && table[k] == pidff_set_condition[PID_PARAM_BLOCK_OFFSET]) {
+			pr_debug("PBO field not found, but that's OK\n");
+			pr_debug("Setting MISSING_PBO quirk\n");
+			return_value |= HID_PIDFF_QUIRK_MISSING_PBO;
+		}
+		else if (!found && strict) {
 			pr_debug("failed to locate %d\n", k);
 			return -1;
 		}
 	}
-	return 0;
+	return return_value;
 }
 
 /*
@@ -871,6 +1068,11 @@ static int pidff_reports_ok(struct pidff_device *pidff)
 static struct hid_field *pidff_find_special_field(struct hid_report *report,
 						  int usage, int enforce_min)
 {
+	if (!report) {
+		pr_debug("pidff_find_special_field, null report\n");
+		return NULL;
+	}
+
 	int i;
 
 	for (i = 0; i < report->maxfield; i++) {
@@ -923,22 +1125,24 @@ static int pidff_find_special_fields(struct pidff_device *pidff)
 
 	pidff->create_new_effect_type =
 		pidff_find_special_field(pidff->reports[PID_CREATE_NEW_EFFECT],
-					 0x25, 1);
+					 PID_EFFECT_TYPE, 1);
 	pidff->set_effect_type =
 		pidff_find_special_field(pidff->reports[PID_SET_EFFECT],
-					 0x25, 1);
+					 PID_EFFECT_TYPE, 1);
 	pidff->effect_direction =
 		pidff_find_special_field(pidff->reports[PID_SET_EFFECT],
-					 0x57, 0);
+					 PID_DIRECTION, 0);
 	pidff->device_control =
 		pidff_find_special_field(pidff->reports[PID_DEVICE_CONTROL],
-					 0x96, 1);
+			PID_DEVICE_CONTROL_ARRAY,
+			!(pidff->quirks & HID_PIDFF_QUIRK_PERMISSIVE_CONTROL));
+
 	pidff->block_load_status =
 		pidff_find_special_field(pidff->reports[PID_BLOCK_LOAD],
-					 0x8b, 1);
+					 PID_BLOCK_LOAD_STATUS, 1);
 	pidff->effect_operation_status =
 		pidff_find_special_field(pidff->reports[PID_EFFECT_OPERATION],
-					 0x78, 1);
+					 PID_EFFECT_OPERATION_ARRAY, 1);
 
 	hid_dbg(pidff->hid, "search done\n");
 
@@ -967,10 +1171,6 @@ static int pidff_find_special_fields(struct pidff_device *pidff)
 		return -1;
 	}
 
-	pidff_find_special_keys(pidff->control_id, pidff->device_control,
-				pidff_device_control,
-				sizeof(pidff_device_control));
-
 	PIDFF_FIND_SPECIAL_KEYS(control_id, device_control, device_control);
 
 	if (!PIDFF_FIND_SPECIAL_KEYS(type_id, create_new_effect_type,
@@ -1049,7 +1249,6 @@ static int pidff_find_effects(struct pidff_device *pidff,
 		set_bit(FF_FRICTION, dev->ffbit);
 
 	return 0;
-
 }
 
 #define PIDFF_FIND_FIELDS(name, report, strict) \
@@ -1062,12 +1261,19 @@ static int pidff_find_effects(struct pidff_device *pidff,
  */
 static int pidff_init_fields(struct pidff_device *pidff, struct input_dev *dev)
 {
-	int envelope_ok = 0;
+	int status = 0;
 
-	if (PIDFF_FIND_FIELDS(set_effect, PID_SET_EFFECT, 1)) {
+	/* Save info about the device not having the DELAY ffb field. */
+	status = PIDFF_FIND_FIELDS(set_effect, PID_SET_EFFECT, 1);
+	if (status == -1) {
 		hid_err(pidff->hid, "unknown set_effect report layout\n");
 		return -ENODEV;
 	}
+	pidff->quirks |= status;
+
+	if (status & HID_PIDFF_QUIRK_MISSING_DELAY)
+		hid_dbg(pidff->hid, "Adding MISSING_DELAY quirk\n");
+
 
 	PIDFF_FIND_FIELDS(block_load, PID_BLOCK_LOAD, 0);
 	if (!pidff->block_load[PID_EFFECT_BLOCK_INDEX].value) {
@@ -1085,13 +1291,10 @@ static int pidff_init_fields(struct pidff_device *pidff, struct input_dev *dev)
 		return -ENODEV;
 	}
 
-	if (!PIDFF_FIND_FIELDS(set_envelope, PID_SET_ENVELOPE, 1))
-		envelope_ok = 1;
-
 	if (pidff_find_special_fields(pidff) || pidff_find_effects(pidff, dev))
 		return -ENODEV;
 
-	if (!envelope_ok) {
+	if (PIDFF_FIND_FIELDS(set_envelope, PID_SET_ENVELOPE, 1)) {
 		if (test_and_clear_bit(FF_CONSTANT, dev->ffbit))
 			hid_warn(pidff->hid,
 				 "has constant effect but no envelope\n");
@@ -1116,16 +1319,20 @@ static int pidff_init_fields(struct pidff_device *pidff, struct input_dev *dev)
 		clear_bit(FF_RAMP, dev->ffbit);
 	}
 
-	if ((test_bit(FF_SPRING, dev->ffbit) ||
-	     test_bit(FF_DAMPER, dev->ffbit) ||
-	     test_bit(FF_FRICTION, dev->ffbit) ||
-	     test_bit(FF_INERTIA, dev->ffbit)) &&
-	    PIDFF_FIND_FIELDS(set_condition, PID_SET_CONDITION, 1)) {
-		hid_warn(pidff->hid, "unknown condition effect layout\n");
-		clear_bit(FF_SPRING, dev->ffbit);
-		clear_bit(FF_DAMPER, dev->ffbit);
-		clear_bit(FF_FRICTION, dev->ffbit);
-		clear_bit(FF_INERTIA, dev->ffbit);
+	if (test_bit(FF_SPRING, dev->ffbit) ||
+	    test_bit(FF_DAMPER, dev->ffbit) ||
+	    test_bit(FF_FRICTION, dev->ffbit) ||
+	    test_bit(FF_INERTIA, dev->ffbit)) {
+		status = PIDFF_FIND_FIELDS(set_condition, PID_SET_CONDITION, 1);
+
+		if (status < 0) {
+			hid_warn(pidff->hid, "unknown condition effect layout\n");
+			clear_bit(FF_SPRING, dev->ffbit);
+			clear_bit(FF_DAMPER, dev->ffbit);
+			clear_bit(FF_FRICTION, dev->ffbit);
+			clear_bit(FF_INERTIA, dev->ffbit);
+		}
+		pidff->quirks |= status;
 	}
 
 	if (test_bit(FF_PERIODIC, dev->ffbit) &&
@@ -1142,46 +1349,6 @@ static int pidff_init_fields(struct pidff_device *pidff, struct input_dev *dev)
 	return 0;
 }
 
-/*
- * Reset the device
- */
-static void pidff_reset(struct pidff_device *pidff)
-{
-	struct hid_device *hid = pidff->hid;
-	int i = 0;
-
-	pidff->device_control->value[0] = pidff->control_id[PID_RESET];
-	/* We reset twice as sometimes hid_wait_io isn't waiting long enough */
-	hid_hw_request(hid, pidff->reports[PID_DEVICE_CONTROL], HID_REQ_SET_REPORT);
-	hid_hw_wait(hid);
-	hid_hw_request(hid, pidff->reports[PID_DEVICE_CONTROL], HID_REQ_SET_REPORT);
-	hid_hw_wait(hid);
-
-	pidff->device_control->value[0] =
-		pidff->control_id[PID_ENABLE_ACTUATORS];
-	hid_hw_request(hid, pidff->reports[PID_DEVICE_CONTROL], HID_REQ_SET_REPORT);
-	hid_hw_wait(hid);
-
-	/* pool report is sometimes messed up, refetch it */
-	hid_hw_request(hid, pidff->reports[PID_POOL], HID_REQ_GET_REPORT);
-	hid_hw_wait(hid);
-
-	if (pidff->pool[PID_SIMULTANEOUS_MAX].value) {
-		while (pidff->pool[PID_SIMULTANEOUS_MAX].value[0] < 2) {
-			if (i++ > 20) {
-				hid_warn(pidff->hid,
-					 "device reports %d simultaneous effects\n",
-					 pidff->pool[PID_SIMULTANEOUS_MAX].value[0]);
-				break;
-			}
-			hid_dbg(pidff->hid, "pid_pool requested again\n");
-			hid_hw_request(hid, pidff->reports[PID_POOL],
-					  HID_REQ_GET_REPORT);
-			hid_hw_wait(hid);
-		}
-	}
-}
-
 /*
  * Test if autocenter modification is using the supported method
  */
@@ -1206,24 +1373,23 @@ static int pidff_check_autocenter(struct pidff_device *pidff,
 
 	if (pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0] ==
 	    pidff->block_load[PID_EFFECT_BLOCK_INDEX].field->logical_minimum + 1) {
-		pidff_autocenter(pidff, 0xffff);
+		pidff_autocenter(pidff, U16_MAX);
 		set_bit(FF_AUTOCENTER, dev->ffbit);
 	} else {
 		hid_notice(pidff->hid,
 			   "device has unknown autocenter control method\n");
 	}
-
 	pidff_erase_pid(pidff,
 			pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0]);
 
 	return 0;
-
 }
 
 /*
  * Check if the device is PID and initialize it
+ * Set initial quirks
  */
-int hid_pidff_init(struct hid_device *hid)
+int hid_pidff_init_with_quirks(struct hid_device *hid, u32 initial_quirks)
 {
 	struct pidff_device *pidff;
 	struct hid_input *hidinput = list_entry(hid->inputs.next,
@@ -1245,6 +1411,8 @@ int hid_pidff_init(struct hid_device *hid)
 		return -ENOMEM;
 
 	pidff->hid = hid;
+	pidff->quirks = initial_quirks;
+	pidff->effect_count = 0;
 
 	hid_device_io_start(hid);
 
@@ -1261,14 +1429,9 @@ int hid_pidff_init(struct hid_device *hid)
 	if (error)
 		goto fail;
 
-	pidff_reset(pidff);
-
-	if (test_bit(FF_GAIN, dev->ffbit)) {
-		pidff_set(&pidff->device_gain[PID_DEVICE_GAIN_FIELD], 0xffff);
-		hid_hw_request(hid, pidff->reports[PID_DEVICE_GAIN],
-				     HID_REQ_SET_REPORT);
-	}
-
+	/* pool report is sometimes messed up, refetch it */
+	pidff_fetch_pool(pidff);
+	pidff_set_gain_report(pidff, U16_MAX);
 	error = pidff_check_autocenter(pidff, dev);
 	if (error)
 		goto fail;
@@ -1311,6 +1474,7 @@ int hid_pidff_init(struct hid_device *hid)
 	ff->playback = pidff_playback;
 
 	hid_info(dev, "Force feedback for USB HID PID devices by Anssi Hannula <anssi.hannula@gmail.com>\n");
+	hid_dbg(dev, "Active quirks mask: 0x%x\n", pidff->quirks);
 
 	hid_device_io_stop(hid);
 
@@ -1322,3 +1486,14 @@ int hid_pidff_init(struct hid_device *hid)
 	kfree(pidff);
 	return error;
 }
+EXPORT_SYMBOL_GPL(hid_pidff_init_with_quirks);
+
+/*
+ * Check if the device is PID and initialize it
+ * Wrapper made to keep the compatibility with old
+ * init function
+ */
+int hid_pidff_init(struct hid_device *hid)
+{
+	return hid_pidff_init_with_quirks(hid, 0);
+}
diff --git a/drivers/hid/usbhid/hid-pidff.h b/drivers/hid/usbhid/hid-pidff.h
new file mode 100644
index 000000000000..dda571e0a5bd
--- /dev/null
+++ b/drivers/hid/usbhid/hid-pidff.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __HID_PIDFF_H
+#define __HID_PIDFF_H
+
+#include <linux/hid.h>
+
+/* HID PIDFF quirks */
+
+/* Delay field (0xA7) missing. Skip it during set effect report upload */
+#define HID_PIDFF_QUIRK_MISSING_DELAY		BIT(0)
+
+/* Missing Paramter block offset (0x23). Skip it during SET_CONDITION
+   report upload */
+#define HID_PIDFF_QUIRK_MISSING_PBO		BIT(1)
+
+/* Initialise device control field even if logical_minimum != 1 */
+#define HID_PIDFF_QUIRK_PERMISSIVE_CONTROL	BIT(2)
+
+/* Use fixed 0x4000 direction during SET_EFFECT report upload */
+#define HID_PIDFF_QUIRK_FIX_WHEEL_DIRECTION	BIT(3)
+
+/* Force all periodic effects to be uploaded as SINE */
+#define HID_PIDFF_QUIRK_PERIODIC_SINE_ONLY	BIT(4)
+
+#ifdef CONFIG_HID_PID
+int hid_pidff_init(struct hid_device *hid);
+int hid_pidff_init_with_quirks(struct hid_device *hid, u32 initial_quirks);
+#else
+#define hid_pidff_init NULL
+#define hid_pidff_init_with_quirks NULL
+#endif
+
+#endif
diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index afe470f3661c..6105ea9a6c6a 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -401,6 +401,7 @@ static void ssip_reset(struct hsi_client *cl)
 	del_timer(&ssi->rx_wd);
 	del_timer(&ssi->tx_wd);
 	del_timer(&ssi->keep_alive);
+	cancel_work_sync(&ssi->work);
 	ssi->main_state = 0;
 	ssi->send_state = 0;
 	ssi->recv_state = 0;
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 53ab814b676f..7c1dc42b809b 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2553,6 +2553,9 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
  */
 void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
 {
+	if (!dev->ibi || !slot)
+		return;
+
 	atomic_inc(&dev->ibi->pending_ibis);
 	queue_work(dev->ibi->wq, &slot->work);
 }
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 87f98fa8afd5..42102baabcdd 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -378,7 +378,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	       slot->len < SVC_I3C_FIFO_SIZE) {
 		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
 		count = SVC_I3C_MDATACTRL_RXCOUNT(mdatactrl);
-		readsl(master->regs + SVC_I3C_MRDATAB, buf, count);
+		readsb(master->regs + SVC_I3C_MRDATAB, buf, count);
 		slot->len += count;
 		buf += count;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index d525ab43a4ae..dd7d030d2e89 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -487,17 +487,6 @@ static int tegra241_cmdqv_hw_reset(struct arm_smmu_device *smmu)
 
 /* VCMDQ Resource Helpers */
 
-static void tegra241_vcmdq_free_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
-{
-	struct arm_smmu_queue *q = &vcmdq->cmdq.q;
-	size_t nents = 1 << q->llq.max_n_shift;
-	size_t qsz = nents << CMDQ_ENT_SZ_SHIFT;
-
-	if (!q->base)
-		return;
-	dmam_free_coherent(vcmdq->cmdqv->smmu.dev, qsz, q->base, q->base_dma);
-}
-
 static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 {
 	struct arm_smmu_device *smmu = &vcmdq->cmdqv->smmu;
@@ -560,7 +549,8 @@ static void tegra241_vintf_free_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
 	struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
 	char header[64];
 
-	tegra241_vcmdq_free_smmu_cmdq(vcmdq);
+	/* Note that the lvcmdq queue memory space is managed by devres */
+
 	tegra241_vintf_deinit_lvcmdq(vintf, lidx);
 
 	dev_dbg(vintf->cmdqv->dev,
@@ -768,13 +758,13 @@ static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
 
 	vintf = kzalloc(sizeof(*vintf), GFP_KERNEL);
 	if (!vintf)
-		goto out_fallback;
+		return -ENOMEM;
 
 	/* Init VINTF0 for in-kernel use */
 	ret = tegra241_cmdqv_init_vintf(cmdqv, 0, vintf);
 	if (ret) {
 		dev_err(cmdqv->dev, "failed to init vintf0: %d\n", ret);
-		goto free_vintf;
+		return ret;
 	}
 
 	/* Preallocate logical VCMDQs to VINTF0 */
@@ -783,24 +773,12 @@ static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
 
 		vcmdq = tegra241_vintf_alloc_lvcmdq(vintf, lidx);
 		if (IS_ERR(vcmdq))
-			goto free_lvcmdq;
+			return PTR_ERR(vcmdq);
 	}
 
 	/* Now, we are ready to run all the impl ops */
 	smmu->impl_ops = &tegra241_cmdqv_impl_ops;
 	return 0;
-
-free_lvcmdq:
-	for (lidx--; lidx >= 0; lidx--)
-		tegra241_vintf_free_lvcmdq(vintf, lidx);
-	tegra241_cmdqv_deinit_vintf(cmdqv, vintf->idx);
-free_vintf:
-	kfree(vintf);
-out_fallback:
-	dev_info(smmu->impl_dev, "Falling back to standard SMMU CMDQ\n");
-	smmu->options &= ~ARM_SMMU_OPT_TEGRA241_CMDQV;
-	tegra241_cmdqv_remove(smmu);
-	return 0;
 }
 
 #ifdef CONFIG_IOMMU_DEBUGFS
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index c666ecab955d..7465dbb6fa80 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -832,7 +832,7 @@ static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
 		struct exynos_iommu_owner *owner = dev_iommu_priv_get(master);
 
 		mutex_lock(&owner->rpm_lock);
-		if (&data->domain->domain != &exynos_identity_domain) {
+		if (data->domain) {
 			dev_dbg(data->sysmmu, "saving state\n");
 			__sysmmu_disable(data);
 		}
@@ -850,7 +850,7 @@ static int __maybe_unused exynos_sysmmu_resume(struct device *dev)
 		struct exynos_iommu_owner *owner = dev_iommu_priv_get(master);
 
 		mutex_lock(&owner->rpm_lock);
-		if (&data->domain->domain != &exynos_identity_domain) {
+		if (data->domain) {
 			dev_dbg(data->sysmmu, "restoring state\n");
 			__sysmmu_enable(data);
 		}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9c46a4cd3848..038a66388564 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3174,6 +3174,7 @@ static int __init probe_acpi_namespace_devices(void)
 			if (dev->bus != &acpi_bus_type)
 				continue;
 
+			up_read(&dmar_global_lock);
 			adev = to_acpi_device(dev);
 			mutex_lock(&adev->physical_node_lock);
 			list_for_each_entry(pn,
@@ -3183,6 +3184,7 @@ static int __init probe_acpi_namespace_devices(void)
 					break;
 			}
 			mutex_unlock(&adev->physical_node_lock);
+			down_read(&dmar_global_lock);
 
 			if (ret)
 				return ret;
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 7a6d188e3bea..71b3383b7115 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -26,11 +26,6 @@
 #include "../iommu-pages.h"
 #include "cap_audit.h"
 
-enum irq_mode {
-	IRQ_REMAPPING,
-	IRQ_POSTING,
-};
-
 struct ioapic_scope {
 	struct intel_iommu *iommu;
 	unsigned int id;
@@ -50,8 +45,8 @@ struct irq_2_iommu {
 	u16 irte_index;
 	u16 sub_handle;
 	u8  irte_mask;
-	enum irq_mode mode;
 	bool posted_msi;
+	bool posted_vcpu;
 };
 
 struct intel_ir_data {
@@ -139,7 +134,6 @@ static int alloc_irte(struct intel_iommu *iommu,
 		irq_iommu->irte_index =  index;
 		irq_iommu->sub_handle = 0;
 		irq_iommu->irte_mask = mask;
-		irq_iommu->mode = IRQ_REMAPPING;
 	}
 	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
 
@@ -194,8 +188,6 @@ static int modify_irte(struct irq_2_iommu *irq_iommu,
 
 	rc = qi_flush_iec(iommu, index, 0);
 
-	/* Update iommu mode according to the IRTE mode */
-	irq_iommu->mode = irte->pst ? IRQ_POSTING : IRQ_REMAPPING;
 	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
 
 	return rc;
@@ -1173,7 +1165,26 @@ static void intel_ir_reconfigure_irte_posted(struct irq_data *irqd)
 static inline void intel_ir_reconfigure_irte_posted(struct irq_data *irqd) {}
 #endif
 
-static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
+static void __intel_ir_reconfigure_irte(struct irq_data *irqd, bool force_host)
+{
+	struct intel_ir_data *ir_data = irqd->chip_data;
+
+	/*
+	 * Don't modify IRTEs for IRQs that are being posted to vCPUs if the
+	 * host CPU affinity changes.
+	 */
+	if (ir_data->irq_2_iommu.posted_vcpu && !force_host)
+		return;
+
+	ir_data->irq_2_iommu.posted_vcpu = false;
+
+	if (ir_data->irq_2_iommu.posted_msi)
+		intel_ir_reconfigure_irte_posted(irqd);
+	else
+		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
+}
+
+static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force_host)
 {
 	struct intel_ir_data *ir_data = irqd->chip_data;
 	struct irte *irte = &ir_data->irte_entry;
@@ -1186,10 +1197,7 @@ static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
 	irte->vector = cfg->vector;
 	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
 
-	if (ir_data->irq_2_iommu.posted_msi)
-		intel_ir_reconfigure_irte_posted(irqd);
-	else if (force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
-		modify_irte(&ir_data->irq_2_iommu, irte);
+	__intel_ir_reconfigure_irte(irqd, force_host);
 }
 
 /*
@@ -1244,7 +1252,7 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 
 	/* stop posting interrupts, back to the default mode */
 	if (!vcpu_pi_info) {
-		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
+		__intel_ir_reconfigure_irte(data, true);
 	} else {
 		struct irte irte_pi;
 
@@ -1267,6 +1275,7 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		irte_pi.pda_h = (vcpu_pi_info->pi_desc_addr >> 32) &
 				~(-1UL << PDA_HIGH_BIT);
 
+		ir_data->irq_2_iommu.posted_vcpu = true;
 		modify_irte(&ir_data->irq_2_iommu, &irte_pi);
 	}
 
@@ -1282,43 +1291,44 @@ static struct irq_chip intel_ir_chip = {
 };
 
 /*
- * With posted MSIs, all vectors are multiplexed into a single notification
- * vector. Devices MSIs are then dispatched in a demux loop where
- * EOIs can be coalesced as well.
+ * With posted MSIs, the MSI vectors are multiplexed into a single notification
+ * vector, and only the notification vector is sent to the APIC IRR.  Device
+ * MSIs are then dispatched in a demux loop that harvests the MSIs from the
+ * CPU's Posted Interrupt Request bitmap.  I.e. Posted MSIs never get sent to
+ * the APIC IRR, and thus do not need an EOI.  The notification handler instead
+ * performs a single EOI after processing the PIR.
  *
- * "INTEL-IR-POST" IRQ chip does not do EOI on ACK, thus the dummy irq_ack()
- * function. Instead EOI is performed by the posted interrupt notification
- * handler.
+ * Note!  Pending SMP/CPU affinity changes, which are per MSI, must still be
+ * honored, only the APIC EOI is omitted.
  *
  * For the example below, 3 MSIs are coalesced into one CPU notification. Only
- * one apic_eoi() is needed.
+ * one apic_eoi() is needed, but each MSI needs to process pending changes to
+ * its CPU affinity.
  *
  * __sysvec_posted_msi_notification()
  *	irq_enter();
  *		handle_edge_irq()
  *			irq_chip_ack_parent()
- *				dummy(); // No EOI
+ *				irq_move_irq(); // No EOI
  *			handle_irq_event()
  *				driver_handler()
  *		handle_edge_irq()
  *			irq_chip_ack_parent()
- *				dummy(); // No EOI
+ *				irq_move_irq(); // No EOI
  *			handle_irq_event()
  *				driver_handler()
  *		handle_edge_irq()
  *			irq_chip_ack_parent()
- *				dummy(); // No EOI
+ *				irq_move_irq(); // No EOI
  *			handle_irq_event()
  *				driver_handler()
  *	apic_eoi()
  *	irq_exit()
+ *
  */
-
-static void dummy_ack(struct irq_data *d) { }
-
 static struct irq_chip intel_ir_chip_post_msi = {
 	.name			= "INTEL-IR-POST",
-	.irq_ack		= dummy_ack,
+	.irq_ack		= irq_move_irq,
 	.irq_set_affinity	= intel_ir_set_affinity,
 	.irq_compose_msi_msg	= intel_ir_compose_msi_msg,
 	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
@@ -1494,6 +1504,9 @@ static void intel_irq_remapping_deactivate(struct irq_domain *domain,
 	struct intel_ir_data *data = irq_data->chip_data;
 	struct irte entry;
 
+	WARN_ON_ONCE(data->irq_2_iommu.posted_vcpu);
+	data->irq_2_iommu.posted_vcpu = false;
+
 	memset(&entry, 0, sizeof(entry));
 	modify_irte(&data->irq_2_iommu, &entry);
 }
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 5fd3dd420290..3fd8920e79ff 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -352,6 +352,122 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 	return 0;
 }
 
+/* The device attach/detach/replace helpers for attach_handle */
+
+/* Check if idev is attached to igroup->hwpt */
+static bool iommufd_device_is_attached(struct iommufd_device *idev)
+{
+	struct iommufd_device *cur;
+
+	list_for_each_entry(cur, &idev->igroup->device_list, group_item)
+		if (cur == idev)
+			return true;
+	return false;
+}
+
+static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
+				      struct iommufd_device *idev)
+{
+	struct iommufd_attach_handle *handle;
+	int rc;
+
+	lockdep_assert_held(&idev->igroup->lock);
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	if (hwpt->fault) {
+		rc = iommufd_fault_iopf_enable(idev);
+		if (rc)
+			goto out_free_handle;
+	}
+
+	handle->idev = idev;
+	rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
+				       &handle->handle);
+	if (rc)
+		goto out_disable_iopf;
+
+	return 0;
+
+out_disable_iopf:
+	if (hwpt->fault)
+		iommufd_fault_iopf_disable(idev);
+out_free_handle:
+	kfree(handle);
+	return rc;
+}
+
+static struct iommufd_attach_handle *
+iommufd_device_get_attach_handle(struct iommufd_device *idev)
+{
+	struct iommu_attach_handle *handle;
+
+	lockdep_assert_held(&idev->igroup->lock);
+
+	handle =
+		iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
+	if (IS_ERR(handle))
+		return NULL;
+	return to_iommufd_handle(handle);
+}
+
+static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
+				       struct iommufd_device *idev)
+{
+	struct iommufd_attach_handle *handle;
+
+	handle = iommufd_device_get_attach_handle(idev);
+	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
+	if (hwpt->fault) {
+		iommufd_auto_response_faults(hwpt, handle);
+		iommufd_fault_iopf_disable(idev);
+	}
+	kfree(handle);
+}
+
+static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
+				       struct iommufd_hw_pagetable *hwpt,
+				       struct iommufd_hw_pagetable *old)
+{
+	struct iommufd_attach_handle *handle, *old_handle =
+		iommufd_device_get_attach_handle(idev);
+	int rc;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	if (hwpt->fault && !old->fault) {
+		rc = iommufd_fault_iopf_enable(idev);
+		if (rc)
+			goto out_free_handle;
+	}
+
+	handle->idev = idev;
+	rc = iommu_replace_group_handle(idev->igroup->group, hwpt->domain,
+					&handle->handle);
+	if (rc)
+		goto out_disable_iopf;
+
+	if (old->fault) {
+		iommufd_auto_response_faults(hwpt, old_handle);
+		if (!hwpt->fault)
+			iommufd_fault_iopf_disable(idev);
+	}
+	kfree(old_handle);
+
+	return 0;
+
+out_disable_iopf:
+	if (hwpt->fault && !old->fault)
+		iommufd_fault_iopf_disable(idev);
+out_free_handle:
+	kfree(handle);
+	return rc;
+}
+
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
@@ -488,6 +604,11 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 		goto err_unlock;
 	}
 
+	if (!iommufd_device_is_attached(idev)) {
+		rc = -EINVAL;
+		goto err_unlock;
+	}
+
 	if (hwpt == igroup->hwpt) {
 		mutex_unlock(&idev->igroup->lock);
 		return NULL;
@@ -1127,7 +1248,7 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 	struct io_pagetable *iopt;
 	struct iopt_area *area;
 	unsigned long last_iova;
-	int rc;
+	int rc = -EINVAL;
 
 	if (!length)
 		return -EINVAL;
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 95e2e99ab272..1b0812f8bf84 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -16,7 +16,7 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
-static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
+int iommufd_fault_iopf_enable(struct iommufd_device *idev)
 {
 	struct device *dev = idev->dev;
 	int ret;
@@ -45,7 +45,7 @@ static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
 	return ret;
 }
 
-static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
+void iommufd_fault_iopf_disable(struct iommufd_device *idev)
 {
 	mutex_lock(&idev->iopf_lock);
 	if (!WARN_ON(idev->iopf_enabled == 0)) {
@@ -93,8 +93,8 @@ int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 	return ret;
 }
 
-static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
-					 struct iommufd_attach_handle *handle)
+void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
+				  struct iommufd_attach_handle *handle)
 {
 	struct iommufd_fault *fault = hwpt->fault;
 	struct iopf_group *group, *next;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index c1f82cb68242..18cdf1391a03 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -523,35 +523,10 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 				     struct iommufd_hw_pagetable *hwpt,
 				     struct iommufd_hw_pagetable *old);
 
-static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
-					     struct iommufd_device *idev)
-{
-	if (hwpt->fault)
-		return iommufd_fault_domain_attach_dev(hwpt, idev);
-
-	return iommu_attach_group(hwpt->domain, idev->igroup->group);
-}
-
-static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
-					      struct iommufd_device *idev)
-{
-	if (hwpt->fault) {
-		iommufd_fault_domain_detach_dev(hwpt, idev);
-		return;
-	}
-
-	iommu_detach_group(hwpt->domain, idev->igroup->group);
-}
-
-static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
-					      struct iommufd_hw_pagetable *hwpt,
-					      struct iommufd_hw_pagetable *old)
-{
-	if (old->fault || hwpt->fault)
-		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
-
-	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
-}
+int iommufd_fault_iopf_enable(struct iommufd_device *idev);
+void iommufd_fault_iopf_disable(struct iommufd_device *idev);
+void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
+				  struct iommufd_attach_handle *handle);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6a2707fe7a78..32deab732209 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1371,15 +1371,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 	mutex_init(&data->mutex);
 
-	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
-				     "mtk-iommu.%pa", &ioaddr);
-	if (ret)
-		goto out_link_remove;
-
-	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
-	if (ret)
-		goto out_sysfs_remove;
-
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE)) {
 		list_add_tail(&data->list, data->plat_data->hw_list);
 		data->hw_list = data->plat_data->hw_list;
@@ -1389,19 +1380,28 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		data->hw_list = &data->hw_list_head;
 	}
 
+	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
+				     "mtk-iommu.%pa", &ioaddr);
+	if (ret)
+		goto out_list_del;
+
+	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
+	if (ret)
+		goto out_sysfs_remove;
+
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 		if (ret)
-			goto out_list_del;
+			goto out_device_unregister;
 	}
 	return ret;
 
-out_list_del:
-	list_del(&data->list);
+out_device_unregister:
 	iommu_device_unregister(&data->iommu);
 out_sysfs_remove:
 	iommu_device_sysfs_remove(&data->iommu);
-out_link_remove:
+out_list_del:
+	list_del(&data->list);
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
 		device_link_remove(data->smicomm_dev, dev);
 out_runtime_disable:
diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index f3c9ef2bfa57..5d8e27e2e7ae 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -461,7 +461,7 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 		max_res = LPG_RESOLUTION_9BIT;
 	}
 
-	min_period = div64_u64((u64)NSEC_PER_SEC * (1 << pwm_resolution_arr[0]),
+	min_period = div64_u64((u64)NSEC_PER_SEC * ((1 << pwm_resolution_arr[0]) - 1),
 			       clk_rate_arr[clk_len - 1]);
 	if (period <= min_period)
 		return -EINVAL;
@@ -482,7 +482,7 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 	 */
 
 	for (i = 0; i < pwm_resolution_count; i++) {
-		resolution = 1 << pwm_resolution_arr[i];
+		resolution = (1 << pwm_resolution_arr[i]) - 1;
 		for (clk_sel = 1; clk_sel < clk_len; clk_sel++) {
 			u64 numerator = period * clk_rate_arr[clk_sel];
 
@@ -529,7 +529,7 @@ static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
 	unsigned int clk_rate;
 
 	if (chan->subtype == LPG_SUBTYPE_HI_RES_PWM) {
-		max = LPG_RESOLUTION_15BIT - 1;
+		max = BIT(lpg_pwm_resolution_hi_res[chan->pwm_resolution_sel]) - 1;
 		clk_rate = lpg_clk_rates_hi_res[chan->clk_sel];
 	} else {
 		max = LPG_RESOLUTION_9BIT - 1;
@@ -1291,7 +1291,7 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (ret)
 			return ret;
 
-		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * (1 << resolution) *
+		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * ((1 << resolution) - 1) *
 						 pre_div * (1 << m), refclk);
 		state->duty_cycle = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * pwm_value * pre_div * (1 << m), refclk);
 	} else {
diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 46c921000a34..76f54f8b6b6c 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2016-2023, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2016-2025, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <linux/delay.h>
@@ -28,12 +28,6 @@
 #define HSP_INT_FULL_MASK	0xff
 
 #define HSP_INT_DIMENSIONING	0x380
-#define HSP_nSM_SHIFT		0
-#define HSP_nSS_SHIFT		4
-#define HSP_nAS_SHIFT		8
-#define HSP_nDB_SHIFT		12
-#define HSP_nSI_SHIFT		16
-#define HSP_nINT_MASK		0xf
 
 #define HSP_DB_TRIGGER	0x0
 #define HSP_DB_ENABLE	0x4
@@ -97,6 +91,20 @@ struct tegra_hsp_soc {
 	bool has_per_mb_ie;
 	bool has_128_bit_mb;
 	unsigned int reg_stride;
+
+	/* Shifts for dimensioning register. */
+	unsigned int si_shift;
+	unsigned int db_shift;
+	unsigned int as_shift;
+	unsigned int ss_shift;
+	unsigned int sm_shift;
+
+	/* Masks for dimensioning register. */
+	unsigned int si_mask;
+	unsigned int db_mask;
+	unsigned int as_mask;
+	unsigned int ss_mask;
+	unsigned int sm_mask;
 };
 
 struct tegra_hsp {
@@ -747,11 +755,11 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 		return PTR_ERR(hsp->regs);
 
 	value = tegra_hsp_readl(hsp, HSP_INT_DIMENSIONING);
-	hsp->num_sm = (value >> HSP_nSM_SHIFT) & HSP_nINT_MASK;
-	hsp->num_ss = (value >> HSP_nSS_SHIFT) & HSP_nINT_MASK;
-	hsp->num_as = (value >> HSP_nAS_SHIFT) & HSP_nINT_MASK;
-	hsp->num_db = (value >> HSP_nDB_SHIFT) & HSP_nINT_MASK;
-	hsp->num_si = (value >> HSP_nSI_SHIFT) & HSP_nINT_MASK;
+	hsp->num_sm = (value >> hsp->soc->sm_shift) & hsp->soc->sm_mask;
+	hsp->num_ss = (value >> hsp->soc->ss_shift) & hsp->soc->ss_mask;
+	hsp->num_as = (value >> hsp->soc->as_shift) & hsp->soc->as_mask;
+	hsp->num_db = (value >> hsp->soc->db_shift) & hsp->soc->db_mask;
+	hsp->num_si = (value >> hsp->soc->si_shift) & hsp->soc->si_mask;
 
 	err = platform_get_irq_byname_optional(pdev, "doorbell");
 	if (err >= 0)
@@ -915,6 +923,16 @@ static const struct tegra_hsp_soc tegra186_hsp_soc = {
 	.has_per_mb_ie = false,
 	.has_128_bit_mb = false,
 	.reg_stride = 0x100,
+	.si_shift = 16,
+	.db_shift = 12,
+	.as_shift = 8,
+	.ss_shift = 4,
+	.sm_shift = 0,
+	.si_mask = 0xf,
+	.db_mask = 0xf,
+	.as_mask = 0xf,
+	.ss_mask = 0xf,
+	.sm_mask = 0xf,
 };
 
 static const struct tegra_hsp_soc tegra194_hsp_soc = {
@@ -922,6 +940,16 @@ static const struct tegra_hsp_soc tegra194_hsp_soc = {
 	.has_per_mb_ie = true,
 	.has_128_bit_mb = false,
 	.reg_stride = 0x100,
+	.si_shift = 16,
+	.db_shift = 12,
+	.as_shift = 8,
+	.ss_shift = 4,
+	.sm_shift = 0,
+	.si_mask = 0xf,
+	.db_mask = 0xf,
+	.as_mask = 0xf,
+	.ss_mask = 0xf,
+	.sm_mask = 0xf,
 };
 
 static const struct tegra_hsp_soc tegra234_hsp_soc = {
@@ -929,6 +957,16 @@ static const struct tegra_hsp_soc tegra234_hsp_soc = {
 	.has_per_mb_ie = false,
 	.has_128_bit_mb = true,
 	.reg_stride = 0x100,
+	.si_shift = 16,
+	.db_shift = 12,
+	.as_shift = 8,
+	.ss_shift = 4,
+	.sm_shift = 0,
+	.si_mask = 0xf,
+	.db_mask = 0xf,
+	.as_mask = 0xf,
+	.ss_mask = 0xf,
+	.sm_mask = 0xf,
 };
 
 static const struct tegra_hsp_soc tegra264_hsp_soc = {
@@ -936,6 +974,16 @@ static const struct tegra_hsp_soc tegra264_hsp_soc = {
 	.has_per_mb_ie = false,
 	.has_128_bit_mb = true,
 	.reg_stride = 0x1000,
+	.si_shift = 17,
+	.db_shift = 12,
+	.as_shift = 8,
+	.ss_shift = 4,
+	.sm_shift = 0,
+	.si_mask = 0x1f,
+	.db_mask = 0x1f,
+	.as_mask = 0xf,
+	.ss_mask = 0xf,
+	.sm_mask = 0xf,
 };
 
 static const struct of_device_id tegra_hsp_match[] = {
diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 18ae45dcbfb2..b19b0142a690 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -390,6 +390,12 @@ static int ebs_map(struct dm_target *ti, struct bio *bio)
 	return DM_MAPIO_REMAPPED;
 }
 
+static void ebs_postsuspend(struct dm_target *ti)
+{
+	struct ebs_c *ec = ti->private;
+	dm_bufio_client_reset(ec->bufio);
+}
+
 static void ebs_status(struct dm_target *ti, status_type_t type,
 		       unsigned int status_flags, char *result, unsigned int maxlen)
 {
@@ -447,6 +453,7 @@ static struct target_type ebs_target = {
 	.ctr		 = ebs_ctr,
 	.dtr		 = ebs_dtr,
 	.map		 = ebs_map,
+	.postsuspend	 = ebs_postsuspend,
 	.status		 = ebs_status,
 	.io_hints	 = ebs_io_hints,
 	.prepare_ioctl	 = ebs_prepare_ioctl,
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 555dc06b9422..b35b779b1704 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -21,6 +21,7 @@
 #include <linux/reboot.h>
 #include <crypto/hash.h>
 #include <crypto/skcipher.h>
+#include <crypto/utils.h>
 #include <linux/async_tx.h>
 #include <linux/dm-bufio.h>
 
@@ -516,7 +517,7 @@ static int sb_mac(struct dm_integrity_c *ic, bool wr)
 			dm_integrity_io_error(ic, "crypto_shash_digest", r);
 			return r;
 		}
-		if (memcmp(mac, actual_mac, mac_size)) {
+		if (crypto_memneq(mac, actual_mac, mac_size)) {
 			dm_integrity_io_error(ic, "superblock mac", -EILSEQ);
 			dm_audit_log_target(DM_MSG_PREFIX, "mac-superblock", ic->ti, 0);
 			return -EILSEQ;
@@ -859,7 +860,7 @@ static void rw_section_mac(struct dm_integrity_c *ic, unsigned int section, bool
 		if (likely(wr))
 			memcpy(&js->mac, result + (j * JOURNAL_MAC_PER_SECTOR), JOURNAL_MAC_PER_SECTOR);
 		else {
-			if (memcmp(&js->mac, result + (j * JOURNAL_MAC_PER_SECTOR), JOURNAL_MAC_PER_SECTOR)) {
+			if (crypto_memneq(&js->mac, result + (j * JOURNAL_MAC_PER_SECTOR), JOURNAL_MAC_PER_SECTOR)) {
 				dm_integrity_io_error(ic, "journal mac", -EILSEQ);
 				dm_audit_log_target(DM_MSG_PREFIX, "mac-journal", ic->ti, 0);
 			}
@@ -1401,10 +1402,9 @@ static bool find_newer_committed_node(struct dm_integrity_c *ic, struct journal_
 static int dm_integrity_rw_tag(struct dm_integrity_c *ic, unsigned char *tag, sector_t *metadata_block,
 			       unsigned int *metadata_offset, unsigned int total_size, int op)
 {
-#define MAY_BE_FILLER		1
-#define MAY_BE_HASH		2
 	unsigned int hash_offset = 0;
-	unsigned int may_be = MAY_BE_HASH | (ic->discard ? MAY_BE_FILLER : 0);
+	unsigned char mismatch_hash = 0;
+	unsigned char mismatch_filler = !ic->discard;
 
 	do {
 		unsigned char *data, *dp;
@@ -1425,7 +1425,7 @@ static int dm_integrity_rw_tag(struct dm_integrity_c *ic, unsigned char *tag, se
 		if (op == TAG_READ) {
 			memcpy(tag, dp, to_copy);
 		} else if (op == TAG_WRITE) {
-			if (memcmp(dp, tag, to_copy)) {
+			if (crypto_memneq(dp, tag, to_copy)) {
 				memcpy(dp, tag, to_copy);
 				dm_bufio_mark_partial_buffer_dirty(b, *metadata_offset, *metadata_offset + to_copy);
 			}
@@ -1433,29 +1433,30 @@ static int dm_integrity_rw_tag(struct dm_integrity_c *ic, unsigned char *tag, se
 			/* e.g.: op == TAG_CMP */
 
 			if (likely(is_power_of_2(ic->tag_size))) {
-				if (unlikely(memcmp(dp, tag, to_copy)))
-					if (unlikely(!ic->discard) ||
-					    unlikely(memchr_inv(dp, DISCARD_FILLER, to_copy) != NULL)) {
-						goto thorough_test;
-				}
+				if (unlikely(crypto_memneq(dp, tag, to_copy)))
+					goto thorough_test;
 			} else {
 				unsigned int i, ts;
 thorough_test:
 				ts = total_size;
 
 				for (i = 0; i < to_copy; i++, ts--) {
-					if (unlikely(dp[i] != tag[i]))
-						may_be &= ~MAY_BE_HASH;
-					if (likely(dp[i] != DISCARD_FILLER))
-						may_be &= ~MAY_BE_FILLER;
+					/*
+					 * Warning: the control flow must not be
+					 * dependent on match/mismatch of
+					 * individual bytes.
+					 */
+					mismatch_hash |= dp[i] ^ tag[i];
+					mismatch_filler |= dp[i] ^ DISCARD_FILLER;
 					hash_offset++;
 					if (unlikely(hash_offset == ic->tag_size)) {
-						if (unlikely(!may_be)) {
+						if (unlikely(mismatch_hash) && unlikely(mismatch_filler)) {
 							dm_bufio_release(b);
 							return ts;
 						}
 						hash_offset = 0;
-						may_be = MAY_BE_HASH | (ic->discard ? MAY_BE_FILLER : 0);
+						mismatch_hash = 0;
+						mismatch_filler = !ic->discard;
 					}
 				}
 			}
@@ -1476,8 +1477,6 @@ static int dm_integrity_rw_tag(struct dm_integrity_c *ic, unsigned char *tag, se
 	} while (unlikely(total_size));
 
 	return 0;
-#undef MAY_BE_FILLER
-#undef MAY_BE_HASH
 }
 
 struct flush_request {
@@ -2076,7 +2075,7 @@ static bool __journal_read_write(struct dm_integrity_io *dio, struct bio *bio,
 					char checksums_onstack[MAX_T(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 
 					integrity_sector_checksum(ic, logical_sector, mem + bv.bv_offset, checksums_onstack);
-					if (unlikely(memcmp(checksums_onstack, journal_entry_tag(ic, je), ic->tag_size))) {
+					if (unlikely(crypto_memneq(checksums_onstack, journal_entry_tag(ic, je), ic->tag_size))) {
 						DMERR_LIMIT("Checksum failed when reading from journal, at sector 0x%llx",
 							    logical_sector);
 						dm_audit_log_bio(DM_MSG_PREFIX, "journal-checksum",
@@ -2595,7 +2594,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		bio_put(outgoing_bio);
 
 		integrity_sector_checksum(ic, dio->bio_details.bi_iter.bi_sector, outgoing_data, digest);
-		if (unlikely(memcmp(digest, dio->integrity_payload, min(crypto_shash_digestsize(ic->internal_hash), ic->tag_size)))) {
+		if (unlikely(crypto_memneq(digest, dio->integrity_payload, min(crypto_shash_digestsize(ic->internal_hash), ic->tag_size)))) {
 			DMERR_LIMIT("%pg: Checksum failed at sector 0x%llx",
 				ic->dev->bdev, dio->bio_details.bi_iter.bi_sector);
 			atomic64_inc(&ic->number_of_mismatches);
@@ -2634,7 +2633,7 @@ static int dm_integrity_end_io(struct dm_target *ti, struct bio *bio, blk_status
 				char *mem = bvec_kmap_local(&bv);
 				//memset(mem, 0xff, ic->sectors_per_block << SECTOR_SHIFT);
 				integrity_sector_checksum(ic, dio->bio_details.bi_iter.bi_sector, mem, digest);
-				if (unlikely(memcmp(digest, dio->integrity_payload + pos,
+				if (unlikely(crypto_memneq(digest, dio->integrity_payload + pos,
 						min(crypto_shash_digestsize(ic->internal_hash), ic->tag_size)))) {
 					kunmap_local(mem);
 					dm_integrity_free_payload(dio);
@@ -2911,7 +2910,7 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned int write_start
 
 					integrity_sector_checksum(ic, sec + ((l - j) << ic->sb->log2_sectors_per_block),
 								  (char *)access_journal_data(ic, i, l), test_tag);
-					if (unlikely(memcmp(test_tag, journal_entry_tag(ic, je2), ic->tag_size))) {
+					if (unlikely(crypto_memneq(test_tag, journal_entry_tag(ic, je2), ic->tag_size))) {
 						dm_integrity_io_error(ic, "tag mismatch when replaying journal", -EILSEQ);
 						dm_audit_log_target(DM_MSG_PREFIX, "integrity-replay-journal", ic->ti, 0);
 					}
@@ -5081,16 +5080,19 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 
 		ic->recalc_bitmap = dm_integrity_alloc_page_list(n_bitmap_pages);
 		if (!ic->recalc_bitmap) {
+			ti->error = "Could not allocate memory for bitmap";
 			r = -ENOMEM;
 			goto bad;
 		}
 		ic->may_write_bitmap = dm_integrity_alloc_page_list(n_bitmap_pages);
 		if (!ic->may_write_bitmap) {
+			ti->error = "Could not allocate memory for bitmap";
 			r = -ENOMEM;
 			goto bad;
 		}
 		ic->bbs = kvmalloc_array(ic->n_bitmap_blocks, sizeof(struct bitmap_block_status), GFP_KERNEL);
 		if (!ic->bbs) {
+			ti->error = "Could not allocate memory for bitmap";
 			r = -ENOMEM;
 			goto bad;
 		}
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index c142ec5458b7..53ba0fbdf495 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -796,6 +796,13 @@ static int verity_map(struct dm_target *ti, struct bio *bio)
 	return DM_MAPIO_SUBMITTED;
 }
 
+static void verity_postsuspend(struct dm_target *ti)
+{
+	struct dm_verity *v = ti->private;
+	flush_workqueue(v->verify_wq);
+	dm_bufio_client_reset(v->bufio);
+}
+
 /*
  * Status: V (valid) or C (corruption found)
  */
@@ -1766,6 +1773,7 @@ static struct target_type verity_target = {
 	.ctr		= verity_ctr,
 	.dtr		= verity_dtr,
 	.map		= verity_map,
+	.postsuspend	= verity_postsuspend,
 	.status		= verity_status,
 	.prepare_ioctl	= verity_prepare_ioctl,
 	.iterate_devices = verity_iterate_devices,
diff --git a/drivers/media/common/siano/smsdvb-main.c b/drivers/media/common/siano/smsdvb-main.c
index 44d8fe8b220e..9b1a650ed055 100644
--- a/drivers/media/common/siano/smsdvb-main.c
+++ b/drivers/media/common/siano/smsdvb-main.c
@@ -1243,6 +1243,8 @@ static int __init smsdvb_module_init(void)
 	smsdvb_debugfs_register();
 
 	rc = smscore_register_hotplug(smsdvb_hotplug);
+	if (rc)
+		smsdvb_debugfs_unregister();
 
 	pr_debug("\n");
 
diff --git a/drivers/media/i2c/adv748x/adv748x.h b/drivers/media/i2c/adv748x/adv748x.h
index 9bc0121d0eff..2c1db5968af8 100644
--- a/drivers/media/i2c/adv748x/adv748x.h
+++ b/drivers/media/i2c/adv748x/adv748x.h
@@ -320,7 +320,7 @@ struct adv748x_state {
 
 /* Free run pattern select */
 #define ADV748X_SDP_FRP			0x14
-#define ADV748X_SDP_FRP_MASK		GENMASK(3, 1)
+#define ADV748X_SDP_FRP_MASK		GENMASK(2, 0)
 
 /* Saturation */
 #define ADV748X_SDP_SD_SAT_U		0xe3	/* user_map_rw_reg_e3 */
diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index cb21df46bab1..4b7d8039b1c9 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3562,6 +3562,7 @@ static int ccs_probe(struct i2c_client *client)
 out_disable_runtime_pm:
 	pm_runtime_put_noidle(&client->dev);
 	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
 
 out_cleanup:
 	ccs_cleanup(sensor);
@@ -3591,9 +3592,10 @@ static void ccs_remove(struct i2c_client *client)
 	v4l2_async_unregister_subdev(subdev);
 
 	pm_runtime_disable(&client->dev);
-	if (!pm_runtime_status_suspended(&client->dev))
+	if (!pm_runtime_status_suspended(&client->dev)) {
 		ccs_power_off(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+		pm_runtime_set_suspended(&client->dev);
+	}
 
 	for (i = 0; i < sensor->ssds_used; i++)
 		v4l2_device_unregister_subdev(&sensor->ssds[i].sd);
diff --git a/drivers/media/i2c/hi556.c b/drivers/media/i2c/hi556.c
index f31f9886c924..0e89aff9c664 100644
--- a/drivers/media/i2c/hi556.c
+++ b/drivers/media/i2c/hi556.c
@@ -1230,12 +1230,13 @@ static int hi556_check_hwcfg(struct device *dev)
 	ret = fwnode_property_read_u32(fwnode, "clock-frequency", &mclk);
 	if (ret) {
 		dev_err(dev, "can't get clock frequency");
-		return ret;
+		goto check_hwcfg_error;
 	}
 
 	if (mclk != HI556_MCLK) {
 		dev_err(dev, "external clock %d is not supported", mclk);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto check_hwcfg_error;
 	}
 
 	if (bus_cfg.bus.mipi_csi2.num_data_lanes != 2) {
diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 4962cfe7c83d..6a393e18267f 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -1075,10 +1075,6 @@ static int imx214_probe(struct i2c_client *client)
 	 */
 	imx214_power_on(imx214->dev);
 
-	pm_runtime_set_active(imx214->dev);
-	pm_runtime_enable(imx214->dev);
-	pm_runtime_idle(imx214->dev);
-
 	ret = imx214_ctrls_init(imx214);
 	if (ret < 0)
 		goto error_power_off;
@@ -1099,22 +1095,30 @@ static int imx214_probe(struct i2c_client *client)
 
 	imx214_entity_init_state(&imx214->sd, NULL);
 
+	pm_runtime_set_active(imx214->dev);
+	pm_runtime_enable(imx214->dev);
+
 	ret = v4l2_async_register_subdev_sensor(&imx214->sd);
 	if (ret < 0) {
 		dev_err(dev, "could not register v4l2 device\n");
 		goto free_entity;
 	}
 
+	pm_runtime_idle(imx214->dev);
+
 	return 0;
 
 free_entity:
+	pm_runtime_disable(imx214->dev);
+	pm_runtime_set_suspended(&client->dev);
 	media_entity_cleanup(&imx214->sd.entity);
+
 free_ctrl:
 	mutex_destroy(&imx214->mutex);
 	v4l2_ctrl_handler_free(&imx214->ctrls);
+
 error_power_off:
-	pm_runtime_disable(imx214->dev);
-	regulator_bulk_disable(IMX214_NUM_SUPPLIES, imx214->supplies);
+	imx214_power_off(imx214->dev);
 
 	return ret;
 }
@@ -1127,11 +1131,12 @@ static void imx214_remove(struct i2c_client *client)
 	v4l2_async_unregister_subdev(&imx214->sd);
 	media_entity_cleanup(&imx214->sd.entity);
 	v4l2_ctrl_handler_free(&imx214->ctrls);
-
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-
 	mutex_destroy(&imx214->mutex);
+	pm_runtime_disable(&client->dev);
+	if (!pm_runtime_status_suspended(&client->dev)) {
+		imx214_power_off(imx214->dev);
+		pm_runtime_set_suspended(&client->dev);
+	}
 }
 
 static const struct of_device_id imx214_of_match[] = {
diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index e78a80b2bb2e..906aa314b7f8 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -134,10 +134,11 @@
 
 /* Pixel rate is fixed for all the modes */
 #define IMX219_PIXEL_RATE		182400000
-#define IMX219_PIXEL_RATE_4LANE		280800000
+#define IMX219_PIXEL_RATE_4LANE		281600000
 
 #define IMX219_DEFAULT_LINK_FREQ	456000000
-#define IMX219_DEFAULT_LINK_FREQ_4LANE	363000000
+#define IMX219_DEFAULT_LINK_FREQ_4LANE_UNSUPPORTED	363000000
+#define IMX219_DEFAULT_LINK_FREQ_4LANE	364000000
 
 /* IMX219 native and active pixel array size. */
 #define IMX219_NATIVE_WIDTH		3296U
@@ -169,15 +170,6 @@ static const struct cci_reg_sequence imx219_common_regs[] = {
 	{ CCI_REG8(0x30eb), 0x05 },
 	{ CCI_REG8(0x30eb), 0x09 },
 
-	/* PLL Clock Table */
-	{ IMX219_REG_VTPXCK_DIV, 5 },
-	{ IMX219_REG_VTSYCK_DIV, 1 },
-	{ IMX219_REG_PREPLLCK_VT_DIV, 3 },	/* 0x03 = AUTO set */
-	{ IMX219_REG_PREPLLCK_OP_DIV, 3 },	/* 0x03 = AUTO set */
-	{ IMX219_REG_PLL_VT_MPY, 57 },
-	{ IMX219_REG_OPSYCK_DIV, 1 },
-	{ IMX219_REG_PLL_OP_MPY, 114 },
-
 	/* Undocumented registers */
 	{ CCI_REG8(0x455e), 0x00 },
 	{ CCI_REG8(0x471e), 0x4b },
@@ -202,12 +194,45 @@ static const struct cci_reg_sequence imx219_common_regs[] = {
 	{ IMX219_REG_EXCK_FREQ, IMX219_EXCK_FREQ(IMX219_XCLK_FREQ / 1000000) },
 };
 
+static const struct cci_reg_sequence imx219_2lane_regs[] = {
+	/* PLL Clock Table */
+	{ IMX219_REG_VTPXCK_DIV, 5 },
+	{ IMX219_REG_VTSYCK_DIV, 1 },
+	{ IMX219_REG_PREPLLCK_VT_DIV, 3 },	/* 0x03 = AUTO set */
+	{ IMX219_REG_PREPLLCK_OP_DIV, 3 },	/* 0x03 = AUTO set */
+	{ IMX219_REG_PLL_VT_MPY, 57 },
+	{ IMX219_REG_OPSYCK_DIV, 1 },
+	{ IMX219_REG_PLL_OP_MPY, 114 },
+
+	/* 2-Lane CSI Mode */
+	{ IMX219_REG_CSI_LANE_MODE, IMX219_CSI_2_LANE_MODE },
+};
+
+static const struct cci_reg_sequence imx219_4lane_regs[] = {
+	/* PLL Clock Table */
+	{ IMX219_REG_VTPXCK_DIV, 5 },
+	{ IMX219_REG_VTSYCK_DIV, 1 },
+	{ IMX219_REG_PREPLLCK_VT_DIV, 3 },	/* 0x03 = AUTO set */
+	{ IMX219_REG_PREPLLCK_OP_DIV, 3 },	/* 0x03 = AUTO set */
+	{ IMX219_REG_PLL_VT_MPY, 88 },
+	{ IMX219_REG_OPSYCK_DIV, 1 },
+	{ IMX219_REG_PLL_OP_MPY, 91 },
+
+	/* 4-Lane CSI Mode */
+	{ IMX219_REG_CSI_LANE_MODE, IMX219_CSI_4_LANE_MODE },
+};
+
 static const s64 imx219_link_freq_menu[] = {
 	IMX219_DEFAULT_LINK_FREQ,
 };
 
 static const s64 imx219_link_freq_4lane_menu[] = {
 	IMX219_DEFAULT_LINK_FREQ_4LANE,
+	/*
+	 * This will never be advertised to userspace, but will be used for
+	 * v4l2_link_freq_to_bitmap
+	 */
+	IMX219_DEFAULT_LINK_FREQ_4LANE_UNSUPPORTED,
 };
 
 static const char * const imx219_test_pattern_menu[] = {
@@ -663,9 +688,11 @@ static int imx219_set_framefmt(struct imx219 *imx219,
 
 static int imx219_configure_lanes(struct imx219 *imx219)
 {
-	return cci_write(imx219->regmap, IMX219_REG_CSI_LANE_MODE,
-			 imx219->lanes == 2 ? IMX219_CSI_2_LANE_MODE :
-			 IMX219_CSI_4_LANE_MODE, NULL);
+	/* Write the appropriate PLL settings for the number of MIPI lanes */
+	return cci_multi_reg_write(imx219->regmap,
+				  imx219->lanes == 2 ? imx219_2lane_regs : imx219_4lane_regs,
+				  imx219->lanes == 2 ? ARRAY_SIZE(imx219_2lane_regs) :
+				  ARRAY_SIZE(imx219_4lane_regs), NULL);
 };
 
 static int imx219_start_streaming(struct imx219 *imx219,
@@ -1042,6 +1069,7 @@ static int imx219_check_hwcfg(struct device *dev, struct imx219 *imx219)
 	struct v4l2_fwnode_endpoint ep_cfg = {
 		.bus_type = V4L2_MBUS_CSI2_DPHY
 	};
+	unsigned long link_freq_bitmap;
 	int ret = -EINVAL;
 
 	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
@@ -1063,23 +1091,40 @@ static int imx219_check_hwcfg(struct device *dev, struct imx219 *imx219)
 	imx219->lanes = ep_cfg.bus.mipi_csi2.num_data_lanes;
 
 	/* Check the link frequency set in device tree */
-	if (!ep_cfg.nr_of_link_frequencies) {
-		dev_err_probe(dev, -EINVAL,
-			      "link-frequency property not found in DT\n");
-		goto error_out;
+	switch (imx219->lanes) {
+	case 2:
+		ret = v4l2_link_freq_to_bitmap(dev,
+					       ep_cfg.link_frequencies,
+					       ep_cfg.nr_of_link_frequencies,
+					       imx219_link_freq_menu,
+					       ARRAY_SIZE(imx219_link_freq_menu),
+					       &link_freq_bitmap);
+		break;
+	case 4:
+		ret = v4l2_link_freq_to_bitmap(dev,
+					       ep_cfg.link_frequencies,
+					       ep_cfg.nr_of_link_frequencies,
+					       imx219_link_freq_4lane_menu,
+					       ARRAY_SIZE(imx219_link_freq_4lane_menu),
+					       &link_freq_bitmap);
+
+		if (!ret && (link_freq_bitmap & BIT(1))) {
+			dev_warn(dev, "Link frequency of %d not supported, but has been incorrectly advertised previously\n",
+				 IMX219_DEFAULT_LINK_FREQ_4LANE_UNSUPPORTED);
+			dev_warn(dev, "Using link frequency of %d\n",
+				 IMX219_DEFAULT_LINK_FREQ_4LANE);
+			link_freq_bitmap |= BIT(0);
+		}
+		break;
 	}
 
-	if (ep_cfg.nr_of_link_frequencies != 1 ||
-	   (ep_cfg.link_frequencies[0] != ((imx219->lanes == 2) ?
-	    IMX219_DEFAULT_LINK_FREQ : IMX219_DEFAULT_LINK_FREQ_4LANE))) {
+	if (ret || !(link_freq_bitmap & BIT(0))) {
+		ret = -EINVAL;
 		dev_err_probe(dev, -EINVAL,
 			      "Link frequency not supported: %lld\n",
 			      ep_cfg.link_frequencies[0]);
-		goto error_out;
 	}
 
-	ret = 0;
-
 error_out:
 	v4l2_fwnode_endpoint_free(&ep_cfg);
 	fwnode_handle_put(endpoint);
@@ -1186,6 +1231,9 @@ static int imx219_probe(struct i2c_client *client)
 		goto error_media_entity;
 	}
 
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	ret = v4l2_async_register_subdev_sensor(&imx219->sd);
 	if (ret < 0) {
 		dev_err_probe(dev, ret,
@@ -1193,15 +1241,14 @@ static int imx219_probe(struct i2c_client *client)
 		goto error_subdev_cleanup;
 	}
 
-	/* Enable runtime PM and turn off the device */
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
 	pm_runtime_idle(dev);
 
 	return 0;
 
 error_subdev_cleanup:
 	v4l2_subdev_cleanup(&imx219->sd);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 
 error_media_entity:
 	media_entity_cleanup(&imx219->sd.entity);
@@ -1226,9 +1273,10 @@ static void imx219_remove(struct i2c_client *client)
 	imx219_free_controls(imx219);
 
 	pm_runtime_disable(&client->dev);
-	if (!pm_runtime_status_suspended(&client->dev))
+	if (!pm_runtime_status_suspended(&client->dev)) {
 		imx219_power_off(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+		pm_runtime_set_suspended(&client->dev);
+	}
 }
 
 static const struct of_device_id imx219_dt_ids[] = {
diff --git a/drivers/media/i2c/imx319.c b/drivers/media/i2c/imx319.c
index dd1b4ff983dc..701840f4a5cc 100644
--- a/drivers/media/i2c/imx319.c
+++ b/drivers/media/i2c/imx319.c
@@ -2442,17 +2442,19 @@ static int imx319_probe(struct i2c_client *client)
 	if (full_power)
 		pm_runtime_set_active(&client->dev);
 	pm_runtime_enable(&client->dev);
-	pm_runtime_idle(&client->dev);
 
 	ret = v4l2_async_register_subdev_sensor(&imx319->sd);
 	if (ret < 0)
 		goto error_media_entity_pm;
 
+	pm_runtime_idle(&client->dev);
+
 	return 0;
 
 error_media_entity_pm:
 	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	if (full_power)
+		pm_runtime_set_suspended(&client->dev);
 	media_entity_cleanup(&imx319->sd.entity);
 
 error_handler_free:
@@ -2474,7 +2476,8 @@ static void imx319_remove(struct i2c_client *client)
 	v4l2_ctrl_handler_free(sd->ctrl_handler);
 
 	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	if (!pm_runtime_status_suspended(&client->dev))
+		pm_runtime_set_suspended(&client->dev);
 
 	mutex_destroy(&imx319->mutex);
 }
diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index 30f61e04ecaf..3226888d77e9 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -922,6 +922,8 @@ static int ov7251_set_power_on(struct device *dev)
 		return ret;
 	}
 
+	usleep_range(1000, 1100);
+
 	gpiod_set_value_cansleep(ov7251->enable_gpio, 1);
 
 	/* wait at least 65536 external clock cycles */
@@ -1696,7 +1698,7 @@ static int ov7251_probe(struct i2c_client *client)
 		return PTR_ERR(ov7251->analog_regulator);
 	}
 
-	ov7251->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
+	ov7251->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(ov7251->enable_gpio)) {
 		dev_err(dev, "cannot get enable gpio\n");
 		return PTR_ERR(ov7251->enable_gpio);
diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
index b37561352ead..48388c0c851c 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
@@ -1296,6 +1296,7 @@ int ipu6_isys_video_init(struct ipu6_isys_video *av)
 	av->vdev.release = video_device_release_empty;
 	av->vdev.fops = &isys_fops;
 	av->vdev.v4l2_dev = &av->isys->v4l2_dev;
+	av->vdev.dev_parent = &av->isys->adev->isp->pdev->dev;
 	if (!av->vdev.ioctl_ops)
 		av->vdev.ioctl_ops = &ipu6_v4l2_ioctl_ops;
 	av->vdev.queue = &av->aq.vbq;
diff --git a/drivers/media/pci/mgb4/mgb4_cmt.c b/drivers/media/pci/mgb4/mgb4_cmt.c
index a25b68403bc6..c22ef51436ed 100644
--- a/drivers/media/pci/mgb4/mgb4_cmt.c
+++ b/drivers/media/pci/mgb4/mgb4_cmt.c
@@ -135,8 +135,8 @@ static const u16 cmt_vals_out[][15] = {
 };
 
 static const u16 cmt_vals_in[][13] = {
-	{0x1082, 0x0000, 0x5104, 0x0000, 0x11C7, 0x0000, 0x1041, 0x02BC, 0x7C01, 0xFFE9, 0x9900, 0x9908, 0x8100},
 	{0x1104, 0x0000, 0x9208, 0x0000, 0x138E, 0x0000, 0x1041, 0x015E, 0x7C01, 0xFFE9, 0x0100, 0x0908, 0x1000},
+	{0x1082, 0x0000, 0x5104, 0x0000, 0x11C7, 0x0000, 0x1041, 0x02BC, 0x7C01, 0xFFE9, 0x9900, 0x9908, 0x8100},
 };
 
 static const u32 cmt_addrs_out[][15] = {
@@ -206,10 +206,11 @@ u32 mgb4_cmt_set_vout_freq(struct mgb4_vout_dev *voutdev, unsigned int freq)
 
 	mgb4_write_reg(video, regs->config, 0x1 | (config & ~0x3));
 
+	mgb4_mask_reg(video, regs->config, 0x100, 0x100);
+
 	for (i = 0; i < ARRAY_SIZE(cmt_addrs_out[0]); i++)
 		mgb4_write_reg(&voutdev->mgbdev->cmt, addr[i], reg_set[i]);
 
-	mgb4_mask_reg(video, regs->config, 0x100, 0x100);
 	mgb4_mask_reg(video, regs->config, 0x100, 0x0);
 
 	mgb4_write_reg(video, regs->config, config & ~0x1);
@@ -236,10 +237,11 @@ void mgb4_cmt_set_vin_freq_range(struct mgb4_vin_dev *vindev,
 
 	mgb4_write_reg(video, regs->config, 0x1 | (config & ~0x3));
 
+	mgb4_mask_reg(video, regs->config, 0x1000, 0x1000);
+
 	for (i = 0; i < ARRAY_SIZE(cmt_addrs_in[0]); i++)
 		mgb4_write_reg(&vindev->mgbdev->cmt, addr[i], reg_set[i]);
 
-	mgb4_mask_reg(video, regs->config, 0x1000, 0x1000);
 	mgb4_mask_reg(video, regs->config, 0x1000, 0x0);
 
 	mgb4_write_reg(video, regs->config, config & ~0x1);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index c89aafabc742..710311d85113 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -576,7 +576,7 @@ int wave5_vpu_build_up_dec_param(struct vpu_instance *inst,
 		vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1,
 			      WAVE521_COMMAND_QUEUE_DEPTH - 1);
 	}
-
+	vpu_write_reg(inst->dev, W5_CMD_ERR_CONCEAL, 0);
 	ret = send_firmware_command(inst, W5_CREATE_INSTANCE, true, NULL, NULL);
 	if (ret) {
 		wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_work);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 0c5c9a8de91f..e238447c88bb 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1424,10 +1424,24 @@ static int wave5_vpu_dec_start_streaming(struct vb2_queue *q, unsigned int count
 		if (ret)
 			goto free_bitstream_vbuf;
 	} else if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
+		struct dec_initial_info *initial_info =
+			&inst->codec_info->dec_info.initial_info;
+
 		if (inst->state == VPU_INST_STATE_STOP)
 			ret = switch_state(inst, VPU_INST_STATE_INIT_SEQ);
 		if (ret)
 			goto return_buffers;
+
+		if (inst->state == VPU_INST_STATE_INIT_SEQ &&
+		    inst->dev->product_code == WAVE521C_CODE) {
+			if (initial_info->luma_bitdepth != 8) {
+				dev_info(inst->dev->dev, "%s: no support for %d bit depth",
+					 __func__, initial_info->luma_bitdepth);
+				ret = -EINVAL;
+				goto return_buffers;
+			}
+		}
+
 	}
 
 	return ret;
@@ -1446,6 +1460,16 @@ static int streamoff_output(struct vb2_queue *q)
 	struct vb2_v4l2_buffer *buf;
 	int ret;
 	dma_addr_t new_rd_ptr;
+	struct dec_output_info dec_info;
+	unsigned int i;
+
+	for (i = 0; i < v4l2_m2m_num_dst_bufs_ready(m2m_ctx); i++) {
+		ret = wave5_vpu_dec_set_disp_flag(inst, i);
+		if (ret)
+			dev_dbg(inst->dev->dev,
+				"%s: Setting display flag of buf index: %u, fail: %d\n",
+				__func__, i, ret);
+	}
 
 	while ((buf = v4l2_m2m_src_buf_remove(m2m_ctx))) {
 		dev_dbg(inst->dev->dev, "%s: (Multiplanar) buf type %4u | index %4u\n",
@@ -1453,6 +1477,11 @@ static int streamoff_output(struct vb2_queue *q)
 		v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
 	}
 
+	while (wave5_vpu_dec_get_output_info(inst, &dec_info) == 0) {
+		if (dec_info.index_frame_display >= 0)
+			wave5_vpu_dec_set_disp_flag(inst, dec_info.index_frame_display);
+	}
+
 	ret = wave5_vpu_flush_instance(inst);
 	if (ret)
 		return ret;
@@ -1535,7 +1564,7 @@ static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
 			break;
 
 		if (wave5_vpu_dec_get_output_info(inst, &dec_output_info))
-			dev_dbg(inst->dev->dev, "Getting decoding results from fw, fail\n");
+			dev_dbg(inst->dev->dev, "there is no output info\n");
 	}
 
 	v4l2_m2m_update_stop_streaming_state(m2m_ctx, q);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 7273254ecb03..b13c5cd46d7e 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -54,12 +54,12 @@ static void wave5_vpu_handle_irq(void *dev_id)
 	struct vpu_device *dev = dev_id;
 
 	irq_reason = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
+	seq_done = wave5_vdi_read_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO);
+	cmd_done = wave5_vdi_read_register(dev, W5_RET_QUEUE_CMD_DONE_INST);
 	wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
 	wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
 
 	list_for_each_entry(inst, &dev->instances, list) {
-		seq_done = wave5_vdi_read_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO);
-		cmd_done = wave5_vdi_read_register(dev, W5_RET_QUEUE_CMD_DONE_INST);
 
 		if (irq_reason & BIT(INT_WAVE5_INIT_SEQ) ||
 		    irq_reason & BIT(INT_WAVE5_ENC_SET_PARAM)) {
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
index 1a3efb638dde..65fdabcd9d29 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
@@ -73,6 +73,16 @@ int wave5_vpu_flush_instance(struct vpu_instance *inst)
 				 inst->type == VPU_INST_TYPE_DEC ? "DECODER" : "ENCODER", inst->id);
 			mutex_unlock(&inst->dev->hw_lock);
 			return -ETIMEDOUT;
+		} else if (ret == -EBUSY) {
+			struct dec_output_info dec_info;
+
+			mutex_unlock(&inst->dev->hw_lock);
+			wave5_vpu_dec_get_output_info(inst, &dec_info);
+			ret = mutex_lock_interruptible(&inst->dev->hw_lock);
+			if (ret)
+				return ret;
+			if (dec_info.index_frame_display > 0)
+				wave5_vpu_dec_set_disp_flag(inst, dec_info.index_frame_display);
 		}
 	} while (ret != 0);
 	mutex_unlock(&inst->dev->hw_lock);
diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
index ff23b225db70..1b0bc47355c0 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
@@ -79,8 +79,11 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec_fw_use
 	}
 
 	fw = devm_kzalloc(&plat_dev->dev, sizeof(*fw), GFP_KERNEL);
-	if (!fw)
+	if (!fw) {
+		scp_put(scp);
 		return ERR_PTR(-ENOMEM);
+	}
+
 	fw->type = SCP;
 	fw->ops = &mtk_vcodec_rproc_msg;
 	fw->scp = scp;
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
index eea709d93820..47c302745c1d 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
@@ -1188,7 +1188,8 @@ static int vdec_vp9_slice_setup_lat(struct vdec_vp9_slice_instance *instance,
 	return ret;
 }
 
-static
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
 void vdec_vp9_slice_map_counts_eob_coef(unsigned int i, unsigned int j, unsigned int k,
 					struct vdec_vp9_slice_frame_counts *counts,
 					struct v4l2_vp9_frame_symbol_counts *counts_helper)
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
index f8145998fcaf..8522f71fc901 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
@@ -594,7 +594,11 @@ static int h264_enc_init(struct mtk_vcodec_enc_ctx *ctx)
 
 	inst->ctx = ctx;
 	inst->vpu_inst.ctx = ctx;
-	inst->vpu_inst.id = is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
+	if (is_ext)
+		inst->vpu_inst.id = SCP_IPI_VENC_H264;
+	else
+		inst->vpu_inst.id = IPI_VENC_H264;
+
 	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VENC_SYS);
 
 	ret = vpu_enc_init(&inst->vpu_inst);
diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
index db454c9d2641..e0dee768a3be 100644
--- a/drivers/media/platform/nuvoton/npcm-video.c
+++ b/drivers/media/platform/nuvoton/npcm-video.c
@@ -1650,8 +1650,8 @@ static int npcm_video_setup_video(struct npcm_video *video)
 
 static int npcm_video_ece_init(struct npcm_video *video)
 {
+	struct device_node *ece_node __free(device_node) = NULL;
 	struct device *dev = video->dev;
-	struct device_node *ece_node;
 	struct platform_device *ece_pdev;
 	void __iomem *regs;
 
@@ -1671,7 +1671,7 @@ static int npcm_video_ece_init(struct npcm_video *video)
 			dev_err(dev, "Failed to find ECE device\n");
 			return -ENODEV;
 		}
-		of_node_put(ece_node);
+		struct device *ece_dev __free(put_device) = &ece_pdev->dev;
 
 		regs = devm_platform_ioremap_resource(ece_pdev, 0);
 		if (IS_ERR(regs)) {
@@ -1686,7 +1686,7 @@ static int npcm_video_ece_init(struct npcm_video *video)
 			return PTR_ERR(video->ece.regmap);
 		}
 
-		video->ece.reset = devm_reset_control_get(&ece_pdev->dev, NULL);
+		video->ece.reset = devm_reset_control_get(ece_dev, NULL);
 		if (IS_ERR(video->ece.reset)) {
 			dev_err(dev, "Failed to get ECE reset control in DTS\n");
 			return PTR_ERR(video->ece.reset);
diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 3df241dc3a11..1b3db2caa99f 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -19,6 +19,8 @@ static void init_codecs(struct venus_core *core)
 	struct hfi_plat_caps *caps = core->caps, *cap;
 	unsigned long bit;
 
+	core->codecs_count = 0;
+
 	if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) > MAX_CODEC_NUM)
 		return;
 
@@ -62,7 +64,7 @@ fill_buf_mode(struct hfi_plat_caps *cap, const void *data, unsigned int num)
 		cap->cap_bufs_mode_dynamic = true;
 }
 
-static void
+static int
 parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_buffer_alloc_mode_supported *mode = data;
@@ -70,7 +72,7 @@ parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	u32 *type;
 
 	if (num_entries > MAX_ALLOC_MODE_ENTRIES)
-		return;
+		return -EINVAL;
 
 	type = mode->data;
 
@@ -82,6 +84,8 @@ parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 
 		type++;
 	}
+
+	return sizeof(*mode);
 }
 
 static void fill_profile_level(struct hfi_plat_caps *cap, const void *data,
@@ -96,7 +100,7 @@ static void fill_profile_level(struct hfi_plat_caps *cap, const void *data,
 	cap->num_pl += num;
 }
 
-static void
+static int
 parse_profile_level(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_profile_level_supported *pl = data;
@@ -104,12 +108,14 @@ parse_profile_level(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	struct hfi_profile_level pl_arr[HFI_MAX_PROFILE_COUNT] = {};
 
 	if (pl->profile_count > HFI_MAX_PROFILE_COUNT)
-		return;
+		return -EINVAL;
 
 	memcpy(pl_arr, proflevel, pl->profile_count * sizeof(*proflevel));
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_profile_level, pl_arr, pl->profile_count);
+
+	return pl->profile_count * sizeof(*proflevel) + sizeof(u32);
 }
 
 static void
@@ -124,7 +130,7 @@ fill_caps(struct hfi_plat_caps *cap, const void *data, unsigned int num)
 	cap->num_caps += num;
 }
 
-static void
+static int
 parse_caps(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_capabilities *caps = data;
@@ -133,12 +139,14 @@ parse_caps(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	struct hfi_capability caps_arr[MAX_CAP_ENTRIES] = {};
 
 	if (num_caps > MAX_CAP_ENTRIES)
-		return;
+		return -EINVAL;
 
 	memcpy(caps_arr, cap, num_caps * sizeof(*cap));
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_caps, caps_arr, num_caps);
+
+	return sizeof(*caps);
 }
 
 static void fill_raw_fmts(struct hfi_plat_caps *cap, const void *fmts,
@@ -153,7 +161,7 @@ static void fill_raw_fmts(struct hfi_plat_caps *cap, const void *fmts,
 	cap->num_fmts += num_fmts;
 }
 
-static void
+static int
 parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_uncompressed_format_supported *fmt = data;
@@ -162,7 +170,8 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	struct raw_formats rawfmts[MAX_FMT_ENTRIES] = {};
 	u32 entries = fmt->format_entries;
 	unsigned int i = 0;
-	u32 num_planes;
+	u32 num_planes = 0;
+	u32 size;
 
 	while (entries) {
 		num_planes = pinfo->num_planes;
@@ -172,7 +181,7 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 		i++;
 
 		if (i >= MAX_FMT_ENTRIES)
-			return;
+			return -EINVAL;
 
 		if (pinfo->num_planes > MAX_PLANES)
 			break;
@@ -184,9 +193,13 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_raw_fmts, rawfmts, i);
+	size = fmt->format_entries * (sizeof(*constr) * num_planes + 2 * sizeof(u32))
+		+ 2 * sizeof(u32);
+
+	return size;
 }
 
-static void parse_codecs(struct venus_core *core, void *data)
+static int parse_codecs(struct venus_core *core, void *data)
 {
 	struct hfi_codec_supported *codecs = data;
 
@@ -198,21 +211,27 @@ static void parse_codecs(struct venus_core *core, void *data)
 		core->dec_codecs &= ~HFI_VIDEO_CODEC_SPARK;
 		core->enc_codecs &= ~HFI_VIDEO_CODEC_HEVC;
 	}
+
+	return sizeof(*codecs);
 }
 
-static void parse_max_sessions(struct venus_core *core, const void *data)
+static int parse_max_sessions(struct venus_core *core, const void *data)
 {
 	const struct hfi_max_sessions_supported *sessions = data;
 
 	core->max_sessions_supported = sessions->max_sessions;
+
+	return sizeof(*sessions);
 }
 
-static void parse_codecs_mask(u32 *codecs, u32 *domain, void *data)
+static int parse_codecs_mask(u32 *codecs, u32 *domain, void *data)
 {
 	struct hfi_codec_mask_supported *mask = data;
 
 	*codecs = mask->codecs;
 	*domain = mask->video_domains;
+
+	return sizeof(*mask);
 }
 
 static void parser_init(struct venus_inst *inst, u32 *codecs, u32 *domain)
@@ -281,8 +300,9 @@ static int hfi_platform_parser(struct venus_core *core, struct venus_inst *inst)
 u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
 	       u32 size)
 {
-	unsigned int words_count = size >> 2;
-	u32 *word = buf, *data, codecs = 0, domain = 0;
+	u32 *words = buf, *payload, codecs = 0, domain = 0;
+	u32 *frame_size = buf + size;
+	u32 rem_bytes = size;
 	int ret;
 
 	ret = hfi_platform_parser(core, inst);
@@ -299,38 +319,66 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
 		memset(core->caps, 0, sizeof(core->caps));
 	}
 
-	while (words_count) {
-		data = word + 1;
+	while (words < frame_size) {
+		payload = words + 1;
 
-		switch (*word) {
+		switch (*words) {
 		case HFI_PROPERTY_PARAM_CODEC_SUPPORTED:
-			parse_codecs(core, data);
+			if (rem_bytes <= sizeof(struct hfi_codec_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_codecs(core, payload);
+			if (ret < 0)
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
 			init_codecs(core);
 			break;
 		case HFI_PROPERTY_PARAM_MAX_SESSIONS_SUPPORTED:
-			parse_max_sessions(core, data);
+			if (rem_bytes <= sizeof(struct hfi_max_sessions_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_max_sessions(core, payload);
 			break;
 		case HFI_PROPERTY_PARAM_CODEC_MASK_SUPPORTED:
-			parse_codecs_mask(&codecs, &domain, data);
+			if (rem_bytes <= sizeof(struct hfi_codec_mask_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_codecs_mask(&codecs, &domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_UNCOMPRESSED_FORMAT_SUPPORTED:
-			parse_raw_formats(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_uncompressed_format_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_raw_formats(core, codecs, domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_CAPABILITY_SUPPORTED:
-			parse_caps(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_capabilities))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_caps(core, codecs, domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_PROFILE_LEVEL_SUPPORTED:
-			parse_profile_level(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_profile_level_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_profile_level(core, codecs, domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE_SUPPORTED:
-			parse_alloc_mode(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_buffer_alloc_mode_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_alloc_mode(core, codecs, domain, payload);
 			break;
 		default:
+			ret = sizeof(u32);
 			break;
 		}
 
-		word++;
-		words_count--;
+		if (ret < 0)
+			return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+		words += ret / sizeof(u32);
+		rem_bytes -= ret;
 	}
 
 	if (!core->max_sessions_supported)
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index f9437b6412b9..ab93757fff4b 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -187,6 +187,9 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
 	/* ensure rd/wr indices's are read from memory */
 	rmb();
 
+	if (qsize > IFACEQ_QUEUE_SIZE / 4)
+		return -EINVAL;
+
 	if (wr_idx >= rd_idx)
 		empty_space = qsize - (wr_idx - rd_idx);
 	else
@@ -255,6 +258,9 @@ static int venus_read_queue(struct venus_hfi_device *hdev,
 	wr_idx = qhdr->write_idx;
 	qsize = qhdr->q_size;
 
+	if (qsize > IFACEQ_QUEUE_SIZE / 4)
+		return -EINVAL;
+
 	/* make sure data is valid before using it */
 	rmb();
 
@@ -1035,18 +1041,26 @@ static void venus_sfr_print(struct venus_hfi_device *hdev)
 {
 	struct device *dev = hdev->core->dev;
 	struct hfi_sfr *sfr = hdev->sfr.kva;
+	u32 size;
 	void *p;
 
 	if (!sfr)
 		return;
 
-	p = memchr(sfr->data, '\0', sfr->buf_size);
+	size = sfr->buf_size;
+	if (!size)
+		return;
+
+	if (size > ALIGNED_SFR_SIZE)
+		size = ALIGNED_SFR_SIZE;
+
+	p = memchr(sfr->data, '\0', size);
 	/*
 	 * SFR isn't guaranteed to be NULL terminated since SYS_ERROR indicates
 	 * that Venus is in the process of crashing.
 	 */
 	if (!p)
-		sfr->data[sfr->buf_size - 1] = '\0';
+		sfr->data[size - 1] = '\0';
 
 	dev_err_ratelimited(dev, "SFR message from FW: %s\n", sfr->data);
 }
diff --git a/drivers/media/platform/rockchip/rga/rga-hw.c b/drivers/media/platform/rockchip/rga/rga-hw.c
index 11c3d7234757..b2ef3beec525 100644
--- a/drivers/media/platform/rockchip/rga/rga-hw.c
+++ b/drivers/media/platform/rockchip/rga/rga-hw.c
@@ -376,7 +376,7 @@ static void rga_cmd_set_dst_info(struct rga_ctx *ctx,
 	 * Configure the dest framebuffer base address with pixel offset.
 	 */
 	offsets = rga_get_addr_offset(&ctx->out, offset, dst_x, dst_y, dst_w, dst_h);
-	dst_offset = rga_lookup_draw_pos(&offsets, mir_mode, rot_mode);
+	dst_offset = rga_lookup_draw_pos(&offsets, rot_mode, mir_mode);
 
 	dest[(RGA_DST_Y_RGB_BASE_ADDR - RGA_MODE_BASE_REG) >> 2] =
 		dst_offset->y_off;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 73f7af674c01..0c636090d723 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -549,8 +549,9 @@ static void s5p_mfc_enc_calc_src_size_v6(struct s5p_mfc_ctx *ctx)
 		case V4L2_PIX_FMT_NV21M:
 			ctx->stride[0] = ALIGN(ctx->img_width, S5P_FIMV_NV12M_HALIGN_V6);
 			ctx->stride[1] = ALIGN(ctx->img_width, S5P_FIMV_NV12M_HALIGN_V6);
-			ctx->luma_size = ctx->stride[0] * ALIGN(ctx->img_height, 16);
-			ctx->chroma_size =  ctx->stride[0] * ALIGN(ctx->img_height / 2, 16);
+			ctx->luma_size = ALIGN(ctx->stride[0] * ALIGN(ctx->img_height, 16), 256);
+			ctx->chroma_size = ALIGN(ctx->stride[0] * ALIGN(ctx->img_height / 2, 16),
+					256);
 			break;
 		case V4L2_PIX_FMT_YUV420M:
 		case V4L2_PIX_FMT_YVU420M:
diff --git a/drivers/media/platform/st/stm32/dma2d/dma2d.c b/drivers/media/platform/st/stm32/dma2d/dma2d.c
index 92f1edee58f8..3c64e9126025 100644
--- a/drivers/media/platform/st/stm32/dma2d/dma2d.c
+++ b/drivers/media/platform/st/stm32/dma2d/dma2d.c
@@ -492,7 +492,8 @@ static void device_run(void *prv)
 	dst->sequence = frm_cap->sequence++;
 	v4l2_m2m_buf_copy_metadata(src, dst, true);
 
-	clk_enable(dev->gate);
+	if (clk_enable(dev->gate))
+		goto end;
 
 	dma2d_config_fg(dev, frm_out,
 			vb2_dma_contig_plane_dma_addr(&src->vb2_buf, 0));
diff --git a/drivers/media/rc/streamzap.c b/drivers/media/rc/streamzap.c
index 2ce62fe5d60f..d3b48a0dd1f4 100644
--- a/drivers/media/rc/streamzap.c
+++ b/drivers/media/rc/streamzap.c
@@ -138,39 +138,10 @@ static void sz_push_half_space(struct streamzap_ir *sz,
 	sz_push_full_space(sz, value & SZ_SPACE_MASK);
 }
 
-/*
- * streamzap_callback - usb IRQ handler callback
- *
- * This procedure is invoked on reception of data from
- * the usb remote.
- */
-static void streamzap_callback(struct urb *urb)
+static void sz_process_ir_data(struct streamzap_ir *sz, int len)
 {
-	struct streamzap_ir *sz;
 	unsigned int i;
-	int len;
-
-	if (!urb)
-		return;
-
-	sz = urb->context;
-	len = urb->actual_length;
-
-	switch (urb->status) {
-	case -ECONNRESET:
-	case -ENOENT:
-	case -ESHUTDOWN:
-		/*
-		 * this urb is terminated, clean up.
-		 * sz might already be invalid at this point
-		 */
-		dev_err(sz->dev, "urb terminated, status: %d\n", urb->status);
-		return;
-	default:
-		break;
-	}
 
-	dev_dbg(sz->dev, "%s: received urb, len %d\n", __func__, len);
 	for (i = 0; i < len; i++) {
 		dev_dbg(sz->dev, "sz->buf_in[%d]: %x\n",
 			i, (unsigned char)sz->buf_in[i]);
@@ -219,6 +190,43 @@ static void streamzap_callback(struct urb *urb)
 	}
 
 	ir_raw_event_handle(sz->rdev);
+}
+
+/*
+ * streamzap_callback - usb IRQ handler callback
+ *
+ * This procedure is invoked on reception of data from
+ * the usb remote.
+ */
+static void streamzap_callback(struct urb *urb)
+{
+	struct streamzap_ir *sz;
+	int len;
+
+	if (!urb)
+		return;
+
+	sz = urb->context;
+	len = urb->actual_length;
+
+	switch (urb->status) {
+	case 0:
+		dev_dbg(sz->dev, "%s: received urb, len %d\n", __func__, len);
+		sz_process_ir_data(sz, len);
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/*
+		 * this urb is terminated, clean up.
+		 * sz might already be invalid at this point
+		 */
+		dev_err(sz->dev, "urb terminated, status: %d\n", urb->status);
+		return;
+	default:
+		break;
+	}
+
 	usb_submit_urb(urb, GFP_ATOMIC);
 }
 
diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-drivers/vim2m.c
index 3e3b424b4860..8ca6459286ba 100644
--- a/drivers/media/test-drivers/vim2m.c
+++ b/drivers/media/test-drivers/vim2m.c
@@ -1316,9 +1316,6 @@ static int vim2m_probe(struct platform_device *pdev)
 	vfd->v4l2_dev = &dev->v4l2_dev;
 
 	video_set_drvdata(vfd, dev);
-	v4l2_info(&dev->v4l2_dev,
-		  "Device registered as /dev/video%d\n", vfd->num);
-
 	platform_set_drvdata(pdev, dev);
 
 	dev->m2m_dev = v4l2_m2m_init(&m2m_ops);
@@ -1345,6 +1342,9 @@ static int vim2m_probe(struct platform_device *pdev)
 		goto error_m2m;
 	}
 
+	v4l2_info(&dev->v4l2_dev,
+		  "Device registered as /dev/video%d\n", vfd->num);
+
 #ifdef CONFIG_MEDIA_CONTROLLER
 	ret = v4l2_m2m_register_media_controller(dev->m2m_dev, vfd,
 						 MEDIA_ENT_F_PROC_VIDEO_SCALER);
diff --git a/drivers/media/test-drivers/visl/visl-core.c b/drivers/media/test-drivers/visl/visl-core.c
index c46464bcaf2e..93239391f2cf 100644
--- a/drivers/media/test-drivers/visl/visl-core.c
+++ b/drivers/media/test-drivers/visl/visl-core.c
@@ -161,9 +161,15 @@ static const struct visl_ctrl_desc visl_h264_ctrl_descs[] = {
 	},
 	{
 		.cfg.id = V4L2_CID_STATELESS_H264_DECODE_MODE,
+		.cfg.min = V4L2_STATELESS_H264_DECODE_MODE_SLICE_BASED,
+		.cfg.max = V4L2_STATELESS_H264_DECODE_MODE_FRAME_BASED,
+		.cfg.def = V4L2_STATELESS_H264_DECODE_MODE_SLICE_BASED,
 	},
 	{
 		.cfg.id = V4L2_CID_STATELESS_H264_START_CODE,
+		.cfg.min = V4L2_STATELESS_H264_START_CODE_NONE,
+		.cfg.max = V4L2_STATELESS_H264_START_CODE_ANNEX_B,
+		.cfg.def = V4L2_STATELESS_H264_START_CODE_NONE,
 	},
 	{
 		.cfg.id = V4L2_CID_STATELESS_H264_SLICE_PARAMS,
@@ -198,9 +204,15 @@ static const struct visl_ctrl_desc visl_hevc_ctrl_descs[] = {
 	},
 	{
 		.cfg.id = V4L2_CID_STATELESS_HEVC_DECODE_MODE,
+		.cfg.min = V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
+		.cfg.max = V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
+		.cfg.def = V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
 	},
 	{
 		.cfg.id = V4L2_CID_STATELESS_HEVC_START_CODE,
+		.cfg.min = V4L2_STATELESS_HEVC_START_CODE_NONE,
+		.cfg.max = V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
+		.cfg.def = V4L2_STATELESS_HEVC_START_CODE_NONE,
 	},
 	{
 		.cfg.id = V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS,
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 4d8e00b425f4..a0d683d26647 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -3039,6 +3039,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_PROBE_MINMAX
 					| UVC_QUIRK_IGNORE_SELECTOR_UNIT) },
+	/* Actions Microelectronics Co. Display capture-UVC05 */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x1de1,
+	  .idProduct		= 0xf105,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND) },
 	/* NXP Semiconductors IR VIDEO */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/v4l2-core/v4l2-dv-timings.c b/drivers/media/v4l2-core/v4l2-dv-timings.c
index 2cf5dcee0ce8..4d05873892c1 100644
--- a/drivers/media/v4l2-core/v4l2-dv-timings.c
+++ b/drivers/media/v4l2-core/v4l2-dv-timings.c
@@ -764,7 +764,7 @@ bool v4l2_detect_gtf(unsigned int frame_height,
 		u64 num;
 		u32 den;
 
-		num = ((image_width * GTF_D_C_PRIME * (u64)hfreq) -
+		num = (((u64)image_width * GTF_D_C_PRIME * hfreq) -
 		      ((u64)image_width * GTF_D_M_PRIME * 1000));
 		den = (hfreq * (100 - GTF_D_C_PRIME) + GTF_D_M_PRIME * 1000) *
 		      (2 * GTF_CELL_GRAN);
@@ -774,7 +774,7 @@ bool v4l2_detect_gtf(unsigned int frame_height,
 		u64 num;
 		u32 den;
 
-		num = ((image_width * GTF_S_C_PRIME * (u64)hfreq) -
+		num = (((u64)image_width * GTF_S_C_PRIME * hfreq) -
 		      ((u64)image_width * GTF_S_M_PRIME * 1000));
 		den = (hfreq * (100 - GTF_S_C_PRIME) + GTF_S_M_PRIME * 1000) *
 		      (2 * GTF_CELL_GRAN);
diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
index fa0ad2f14a39..9460a67acb0b 100644
--- a/drivers/mfd/ene-kb3930.c
+++ b/drivers/mfd/ene-kb3930.c
@@ -162,7 +162,7 @@ static int kb3930_probe(struct i2c_client *client)
 			devm_gpiod_get_array_optional(dev, "off", GPIOD_IN);
 		if (IS_ERR(ddata->off_gpios))
 			return PTR_ERR(ddata->off_gpios);
-		if (ddata->off_gpios->ndescs < 2) {
+		if (ddata->off_gpios && ddata->off_gpios->ndescs < 2) {
 			dev_err(dev, "invalid off-gpios property\n");
 			return -EINVAL;
 		}
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee..8dea2b44fd8b 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -85,7 +85,6 @@
 #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
 #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
 
-#define PCI_VENDOR_ID_ROCKCHIP			0x1d87
 #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
 
 static DEFINE_IDA(pci_endpoint_test_ida);
@@ -235,7 +234,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 	return true;
 
 fail:
-	switch (irq_type) {
+	switch (test->irq_type) {
 	case IRQ_TYPE_INTX:
 		dev_err(dev, "Failed to request IRQ %d for Legacy\n",
 			pci_irq_vector(pdev, i));
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index e9f6e4e62290..55158540c28c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2579,6 +2579,91 @@ static void dw_mci_pull_data64(struct dw_mci *host, void *buf, int cnt)
 	}
 }
 
+static void dw_mci_push_data64_32(struct dw_mci *host, void *buf, int cnt)
+{
+	struct mmc_data *data = host->data;
+	int init_cnt = cnt;
+
+	/* try and push anything in the part_buf */
+	if (unlikely(host->part_buf_count)) {
+		int len = dw_mci_push_part_bytes(host, buf, cnt);
+
+		buf += len;
+		cnt -= len;
+
+		if (host->part_buf_count == 8) {
+			mci_fifo_l_writeq(host->fifo_reg, host->part_buf);
+			host->part_buf_count = 0;
+		}
+	}
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	if (unlikely((unsigned long)buf & 0x7)) {
+		while (cnt >= 8) {
+			u64 aligned_buf[16];
+			int len = min(cnt & -8, (int)sizeof(aligned_buf));
+			int items = len >> 3;
+			int i;
+			/* memcpy from input buffer into aligned buffer */
+			memcpy(aligned_buf, buf, len);
+			buf += len;
+			cnt -= len;
+			/* push data from aligned buffer into fifo */
+			for (i = 0; i < items; ++i)
+				mci_fifo_l_writeq(host->fifo_reg, aligned_buf[i]);
+		}
+	} else
+#endif
+	{
+		u64 *pdata = buf;
+
+		for (; cnt >= 8; cnt -= 8)
+			mci_fifo_l_writeq(host->fifo_reg, *pdata++);
+		buf = pdata;
+	}
+	/* put anything remaining in the part_buf */
+	if (cnt) {
+		dw_mci_set_part_bytes(host, buf, cnt);
+		/* Push data if we have reached the expected data length */
+		if ((data->bytes_xfered + init_cnt) ==
+		    (data->blksz * data->blocks))
+			mci_fifo_l_writeq(host->fifo_reg, host->part_buf);
+	}
+}
+
+static void dw_mci_pull_data64_32(struct dw_mci *host, void *buf, int cnt)
+{
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	if (unlikely((unsigned long)buf & 0x7)) {
+		while (cnt >= 8) {
+			/* pull data from fifo into aligned buffer */
+			u64 aligned_buf[16];
+			int len = min(cnt & -8, (int)sizeof(aligned_buf));
+			int items = len >> 3;
+			int i;
+
+			for (i = 0; i < items; ++i)
+				aligned_buf[i] = mci_fifo_l_readq(host->fifo_reg);
+
+			/* memcpy from aligned buffer into output buffer */
+			memcpy(buf, aligned_buf, len);
+			buf += len;
+			cnt -= len;
+		}
+	} else
+#endif
+	{
+		u64 *pdata = buf;
+
+		for (; cnt >= 8; cnt -= 8)
+			*pdata++ = mci_fifo_l_readq(host->fifo_reg);
+		buf = pdata;
+	}
+	if (cnt) {
+		host->part_buf = mci_fifo_l_readq(host->fifo_reg);
+		dw_mci_pull_final_bytes(host, buf, cnt);
+	}
+}
+
 static void dw_mci_pull_data(struct dw_mci *host, void *buf, int cnt)
 {
 	int len;
@@ -3379,8 +3464,13 @@ int dw_mci_probe(struct dw_mci *host)
 		width = 16;
 		host->data_shift = 1;
 	} else if (i == 2) {
-		host->push_data = dw_mci_push_data64;
-		host->pull_data = dw_mci_pull_data64;
+		if ((host->quirks & DW_MMC_QUIRK_FIFO64_32)) {
+			host->push_data = dw_mci_push_data64_32;
+			host->pull_data = dw_mci_pull_data64_32;
+		} else {
+			host->push_data = dw_mci_push_data64;
+			host->pull_data = dw_mci_pull_data64;
+		}
 		width = 64;
 		host->data_shift = 3;
 	} else {
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 6447b916990d..5463392dc811 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -281,6 +281,8 @@ struct dw_mci_board {
 
 /* Support for longer data read timeout */
 #define DW_MMC_QUIRK_EXTENDED_TMOUT            BIT(0)
+/* Force 32-bit access to the FIFO */
+#define DW_MMC_QUIRK_FIFO64_32                 BIT(1)
 
 #define DW_MMC_240A		0x240a
 #define DW_MMC_280A		0x280a
@@ -472,6 +474,31 @@ struct dw_mci_board {
 #define mci_fifo_writel(__value, __reg)	__raw_writel(__reg, __value)
 #define mci_fifo_writeq(__value, __reg)	__raw_writeq(__reg, __value)
 
+/*
+ * Some dw_mmc devices have 64-bit FIFOs, but expect them to be
+ * accessed using two 32-bit accesses. If such controller is used
+ * with a 64-bit kernel, this has to be done explicitly.
+ */
+static inline u64 mci_fifo_l_readq(void __iomem *addr)
+{
+	u64 ans;
+	u32 proxy[2];
+
+	proxy[0] = mci_fifo_readl(addr);
+	proxy[1] = mci_fifo_readl(addr + 4);
+	memcpy(&ans, proxy, 8);
+	return ans;
+}
+
+static inline void mci_fifo_l_writeq(void __iomem *addr, u64 value)
+{
+	u32 proxy[2];
+
+	memcpy(proxy, &value, 8);
+	mci_fifo_writel(addr, proxy[0]);
+	mci_fifo_writel(addr + 4, proxy[1]);
+}
+
 /* Register access macros */
 #define mci_readl(dev, reg)			\
 	readl_relaxed((dev)->regs + SDMMC_##reg)
diff --git a/drivers/mtd/inftlcore.c b/drivers/mtd/inftlcore.c
index 9739387cff8c..58c6e1743f5c 100644
--- a/drivers/mtd/inftlcore.c
+++ b/drivers/mtd/inftlcore.c
@@ -482,10 +482,11 @@ static inline u16 INFTL_findwriteunit(struct INFTLrecord *inftl, unsigned block)
 		silly = MAX_LOOPS;
 
 		while (thisEUN <= inftl->lastEUN) {
-			inftl_read_oob(mtd, (thisEUN * inftl->EraseSize) +
-				       blockofs, 8, &retlen, (char *)&bci);
-
-			status = bci.Status | bci.Status1;
+			if (inftl_read_oob(mtd, (thisEUN * inftl->EraseSize) +
+				       blockofs, 8, &retlen, (char *)&bci) < 0)
+				status = SECTOR_IGNORE;
+			else
+				status = bci.Status | bci.Status1;
 			pr_debug("INFTL: status of block %d in EUN %d is %x\n",
 					block , writeEUN, status);
 
diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index 7ac8ac901306..9cf3872e37ae 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -417,11 +417,14 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 	}
 
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, info->kmsg_size));
-	cxt->rmmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
-	cxt->usedmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
+	cxt->rmmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
+	cxt->usedmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
 
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
-	cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
+	cxt->badmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
+
+	if (!cxt->rmmap || !cxt->usedmap || !cxt->badmap)
+		return;
 
 	/* just support dmesg right now */
 	cxt->dev.flags = PSTORE_FLAGS_DMESG;
@@ -527,9 +530,6 @@ static void mtdpstore_notify_remove(struct mtd_info *mtd)
 	mtdpstore_flush_removed(cxt);
 
 	unregister_pstore_device(&cxt->dev);
-	kfree(cxt->badmap);
-	kfree(cxt->usedmap);
-	kfree(cxt->rmmap);
 	cxt->mtd = NULL;
 	cxt->index = -1;
 }
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index e76df6a00ed4..2eb44c1428fb 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -3008,7 +3008,7 @@ static int brcmnand_resume(struct device *dev)
 		brcmnand_save_restore_cs_config(host, 1);
 
 		/* Reset the chip, required by some chips after power-up */
-		nand_reset_op(chip);
+		nand_reset(chip, 0);
 	}
 
 	return 0;
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index ed0cf732d20e..36cfe03cd4ac 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -387,6 +387,9 @@ static int r852_wait(struct nand_chip *chip)
 static int r852_ready(struct nand_chip *chip)
 {
 	struct r852_device *dev = r852_get_dev(nand_to_mtd(chip));
+	if (dev->card_unstable)
+		return 0;
+
 	return !(r852_read_reg(dev, R852_CARD_STA) & R852_CARD_STA_BUSY);
 }
 
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index b080740bcb10..fca290afb532 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -386,6 +386,16 @@ static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
+static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_NR_IRQ_3 |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -1762,14 +1772,25 @@ static int flexcan_open(struct net_device *dev)
 			goto out_free_irq_boff;
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		err = request_irq(priv->irq_secondary_mb,
+				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq_err;
+	}
+
 	flexcan_chip_interrupts_enable(dev);
 
 	netif_start_queue(dev);
 
 	return 0;
 
+ out_free_irq_err:
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
-	free_irq(priv->irq_boff, dev);
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		free_irq(priv->irq_boff, dev);
  out_free_irq:
 	free_irq(dev->irq, dev);
  out_can_rx_offload_disable:
@@ -1794,6 +1815,9 @@ static int flexcan_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	flexcan_chip_interrupts_disable(dev);
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		free_irq(priv->irq_secondary_mb, dev);
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		free_irq(priv->irq_err, dev);
 		free_irq(priv->irq_boff, dev);
@@ -2041,6 +2065,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
+	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
@@ -2187,6 +2212,14 @@ static int flexcan_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		priv->irq_secondary_mb = platform_get_irq_byname(pdev, "mb-1");
+		if (priv->irq_secondary_mb < 0) {
+			err = priv->irq_secondary_mb;
+			goto failed_platform_get_irq;
+		}
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_FD_NON_ISO;
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 4933d8c7439e..2cf886618c96 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -70,6 +70,10 @@
 #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
 /* Setup stop mode with ATF SCMI protocol to support wakeup */
 #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
+/* Device has two separate interrupt lines for two mailbox ranges, which
+ * both need to have an interrupt handler registered.
+ */
+#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
@@ -107,6 +111,7 @@ struct flexcan_priv {
 
 	int irq_boff;
 	int irq_err;
+	int irq_secondary_mb;
 
 	/* IPC handle when setup stop mode by System Controller firmware(scfw) */
 	struct imx_sc_ipc *sc_ipc_handle;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 5935100e7d65..e20d9d62032e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3691,6 +3691,21 @@ static int mv88e6xxx_stats_setup(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_g1_stats_clear(chip);
 }
 
+static int mv88e6320_setup_errata(struct mv88e6xxx_chip *chip)
+{
+	u16 dummy;
+	int err;
+
+	/* Workaround for erratum
+	 *   3.3 RGMII timing may be out of spec when transmit delay is enabled
+	 */
+	err = mv88e6xxx_port_hidden_write(chip, 0, 0xf, 0x7, 0xe000);
+	if (err)
+		return err;
+
+	return mv88e6xxx_port_hidden_read(chip, 0, 0xf, 0x7, &dummy);
+}
+
 /* Check if the errata has already been applied. */
 static bool mv88e6390_setup_errata_applied(struct mv88e6xxx_chip *chip)
 {
@@ -5144,6 +5159,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 
 static const struct mv88e6xxx_ops mv88e6320_ops = {
 	/* MV88E6XXX_FAMILY_6320 */
+	.setup_errata = mv88e6320_setup_errata,
 	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
 	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
@@ -5193,6 +5209,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 
 static const struct mv88e6xxx_ops mv88e6321_ops = {
 	/* MV88E6XXX_FAMILY_6320 */
+	.setup_errata = mv88e6320_setup_errata,
 	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
 	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
@@ -6154,7 +6171,8 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 5,
+		.num_internal_phys = 2,
+		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,
@@ -6348,7 +6366,8 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 5,
+		.num_internal_phys = 2,
+		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index bdfc6e77b2af..1f5db1096d4a 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -392,7 +392,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				 */
 				data[i++] = 0;
 				data[i++] = 0;
-				data[i++] = tx->dqo_tx.tail - tx->dqo_tx.head;
+				data[i++] =
+					(tx->dqo_tx.tail - tx->dqo_tx.head) &
+					tx->mask;
 			}
 			do {
 				start =
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 0f844c14485a..35acc07bd964 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -165,6 +165,11 @@ static void __otx2_qos_txschq_cfg(struct otx2_nic *pfvf,
 
 		otx2_config_sched_shaping(pfvf, node, cfg, &num_regs);
 	} else if (level == NIX_TXSCH_LVL_TL2) {
+		/* configure parent txschq */
+		cfg->reg[num_regs] = NIX_AF_TL2X_PARENT(node->schq);
+		cfg->regval[num_regs] = (u64)hw->tx_link << 16;
+		num_regs++;
+
 		/* configure link cfg */
 		if (level == pfvf->qos.link_cfg_lvl) {
 			cfg->reg[num_regs] = NIX_AF_TL3_TL2X_LINKX_CFG(node->schq, hw->tx_link);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index b2d206dec70c..12c22261dd3a 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -636,30 +636,16 @@ int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu, int num_qu
 	mpc->rxbpre_total = 0;
 
 	for (i = 0; i < num_rxb; i++) {
-		if (mpc->rxbpre_alloc_size > PAGE_SIZE) {
-			va = netdev_alloc_frag(mpc->rxbpre_alloc_size);
-			if (!va)
-				goto error;
-
-			page = virt_to_head_page(va);
-			/* Check if the frag falls back to single page */
-			if (compound_order(page) <
-			    get_order(mpc->rxbpre_alloc_size)) {
-				put_page(page);
-				goto error;
-			}
-		} else {
-			page = dev_alloc_page();
-			if (!page)
-				goto error;
+		page = dev_alloc_pages(get_order(mpc->rxbpre_alloc_size));
+		if (!page)
+			goto error;
 
-			va = page_to_virt(page);
-		}
+		va = page_to_virt(page);
 
 		da = dma_map_single(dev, va + mpc->rxbpre_headroom,
 				    mpc->rxbpre_datasize, DMA_FROM_DEVICE);
 		if (dma_mapping_error(dev, da)) {
-			put_page(virt_to_head_page(va));
+			put_page(page);
 			goto error;
 		}
 
@@ -1618,7 +1604,7 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 }
 
 static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
-			     dma_addr_t *da, bool *from_pool, bool is_napi)
+			     dma_addr_t *da, bool *from_pool)
 {
 	struct page *page;
 	void *va;
@@ -1629,21 +1615,6 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
 	if (rxq->xdp_save_va) {
 		va = rxq->xdp_save_va;
 		rxq->xdp_save_va = NULL;
-	} else if (rxq->alloc_size > PAGE_SIZE) {
-		if (is_napi)
-			va = napi_alloc_frag(rxq->alloc_size);
-		else
-			va = netdev_alloc_frag(rxq->alloc_size);
-
-		if (!va)
-			return NULL;
-
-		page = virt_to_head_page(va);
-		/* Check if the frag falls back to single page */
-		if (compound_order(page) < get_order(rxq->alloc_size)) {
-			put_page(page);
-			return NULL;
-		}
 	} else {
 		page = page_pool_dev_alloc_pages(rxq->page_pool);
 		if (!page)
@@ -1676,7 +1647,7 @@ static void mana_refill_rx_oob(struct device *dev, struct mana_rxq *rxq,
 	dma_addr_t da;
 	void *va;
 
-	va = mana_get_rxfrag(rxq, dev, &da, &from_pool, true);
+	va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
 	if (!va)
 		return;
 
@@ -2083,7 +2054,7 @@ static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
 	if (mpc->rxbufs_pre)
 		va = mana_get_rxbuf_pre(rxq, &da);
 	else
-		va = mana_get_rxfrag(rxq, dev, &da, &from_pool, false);
+		va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
 
 	if (!va)
 		return -ENOMEM;
@@ -2169,6 +2140,7 @@ static int mana_create_page_pool(struct mana_rxq *rxq, struct gdma_context *gc)
 	pprm.nid = gc->numa_node;
 	pprm.napi = &rxq->rx_cq.napi;
 	pprm.netdev = rxq->ndev;
+	pprm.order = get_order(rxq->alloc_size);
 
 	rxq->page_pool = page_pool_create(&pprm);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 2b3d6586f44a..71c891d14fb6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -309,7 +309,8 @@ static bool wx_alloc_mapped_page(struct wx_ring *rx_ring,
 		return true;
 
 	page = page_pool_dev_alloc_pages(rx_ring->page_pool);
-	WARN_ON(!page);
+	if (unlikely(!page))
+		return false;
 	dma = page_pool_get_dma_addr(page);
 
 	bi->page_dma = dma;
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 119dfa2d6643..8af44224480f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -289,6 +289,46 @@ static bool phy_drv_wol_enabled(struct phy_device *phydev)
 	return wol.wolopts != 0;
 }
 
+static void phy_link_change(struct phy_device *phydev, bool up)
+{
+	struct net_device *netdev = phydev->attached_dev;
+
+	if (up)
+		netif_carrier_on(netdev);
+	else
+		netif_carrier_off(netdev);
+	phydev->adjust_link(netdev);
+	if (phydev->mii_ts && phydev->mii_ts->link_state)
+		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
+}
+
+/**
+ * phy_uses_state_machine - test whether consumer driver uses PAL state machine
+ * @phydev: the target PHY device structure
+ *
+ * Ultimately, this aims to indirectly determine whether the PHY is attached
+ * to a consumer which uses the state machine by calling phy_start() and
+ * phy_stop().
+ *
+ * When the PHY driver consumer uses phylib, it must have previously called
+ * phy_connect_direct() or one of its derivatives, so that phy_prepare_link()
+ * has set up a hook for monitoring state changes.
+ *
+ * When the PHY driver is used by the MAC driver consumer through phylink (the
+ * only other provider of a phy_link_change() method), using the PHY state
+ * machine is not optional.
+ *
+ * Return: true if consumer calls phy_start() and phy_stop(), false otherwise.
+ */
+static bool phy_uses_state_machine(struct phy_device *phydev)
+{
+	if (phydev->phy_link_change == phy_link_change)
+		return phydev->attached_dev && phydev->adjust_link;
+
+	/* phydev->phy_link_change is implicitly phylink_phy_change() */
+	return true;
+}
+
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 {
 	struct device_driver *drv = phydev->mdio.dev.driver;
@@ -355,7 +395,7 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	 * may call phy routines that try to grab the same lock, and that may
 	 * lead to a deadlock.
 	 */
-	if (phydev->attached_dev && phydev->adjust_link)
+	if (phy_uses_state_machine(phydev))
 		phy_stop_machine(phydev);
 
 	if (!mdio_bus_phy_may_suspend(phydev))
@@ -409,7 +449,7 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 		}
 	}
 
-	if (phydev->attached_dev && phydev->adjust_link)
+	if (phy_uses_state_machine(phydev))
 		phy_start_machine(phydev);
 
 	return 0;
@@ -1101,19 +1141,6 @@ struct phy_device *phy_find_first(struct mii_bus *bus)
 }
 EXPORT_SYMBOL(phy_find_first);
 
-static void phy_link_change(struct phy_device *phydev, bool up)
-{
-	struct net_device *netdev = phydev->attached_dev;
-
-	if (up)
-		netif_carrier_on(netdev);
-	else
-		netif_carrier_off(netdev);
-	phydev->adjust_link(netdev);
-	if (phydev->mii_ts && phydev->mii_ts->link_state)
-		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
-}
-
 /**
  * phy_prepare_link - prepares the PHY layer to monitor link status
  * @phydev: target phy_device struct
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index dcec92625cf6..7b33993f7001 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -385,7 +385,7 @@ static void sfp_fixup_rollball(struct sfp *sfp)
 	sfp->phy_t_retry = msecs_to_jiffies(1000);
 }
 
-static void sfp_fixup_fs_2_5gt(struct sfp *sfp)
+static void sfp_fixup_rollball_wait4s(struct sfp *sfp)
 {
 	sfp_fixup_rollball(sfp);
 
@@ -399,7 +399,7 @@ static void sfp_fixup_fs_2_5gt(struct sfp *sfp)
 static void sfp_fixup_fs_10gt(struct sfp *sfp)
 {
 	sfp_fixup_10gbaset_30m(sfp);
-	sfp_fixup_fs_2_5gt(sfp);
+	sfp_fixup_rollball_wait4s(sfp);
 }
 
 static void sfp_fixup_halny_gsfp(struct sfp *sfp)
@@ -479,9 +479,10 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// PHY.
 	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
 
-	// Fiberstore SFP-2.5G-T uses Rollball protocol to talk to the PHY and
-	// needs 4 sec wait before probing the PHY.
-	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_fs_2_5gt),
+	// Fiberstore SFP-2.5G-T and SFP-10GM-T uses Rollball protocol to talk
+	// to the PHY and needs 4 sec wait before probing the PHY.
+	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_rollball_wait4s),
+	SFP_QUIRK_F("FS", "SFP-10GM-T", sfp_fixup_rollball_wait4s),
 
 	// Fiberstore GPON-ONU-34-20BI can operate at 2500base-X, but report 1.2GBd
 	// NRZ in their EEPROM
@@ -515,6 +516,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 644e99fc3623..9c4932198931 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -506,6 +506,11 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *skb)
 	unsigned char *data;
 	int islcp;
 
+	/* Ensure we can safely access protocol field and LCP code */
+	if (!pskb_may_pull(skb, 3)) {
+		kfree_skb(skb);
+		return NULL;
+	}
 	data  = skb->data;
 	proto = get_unaligned_be16(data);
 
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 57d6e5abc30e..da24941a6e44 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -1421,6 +1421,19 @@ static const struct driver_info hg20f9_info = {
 	.data = FLAG_EEPROM_MAC,
 };
 
+static const struct driver_info lyconsys_fibergecko100_info = {
+	.description = "LyconSys FiberGecko 100 USB 2.0 to SFP Adapter",
+	.bind = ax88178_bind,
+	.status = asix_status,
+	.link_reset = ax88178_link_reset,
+	.reset = ax88178_link_reset,
+	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
+		 FLAG_MULTI_PACKET,
+	.rx_fixup = asix_rx_fixup_common,
+	.tx_fixup = asix_tx_fixup,
+	.data = 0x20061201,
+};
+
 static const struct usb_device_id	products [] = {
 {
 	// Linksys USB200M
@@ -1578,6 +1591,10 @@ static const struct usb_device_id	products [] = {
 	// Linux Automation GmbH USB 10Base-T1L
 	USB_DEVICE(0x33f7, 0x0004),
 	.driver_info = (unsigned long) &lxausb_t1l_info,
+}, {
+	/* LyconSys FiberGecko 100 */
+	USB_DEVICE(0x1d2a, 0x0801),
+	.driver_info = (unsigned long) &lyconsys_fibergecko100_info,
 },
 	{ },		// END
 };
diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index a6469235d904..a032c1ded406 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -783,6 +783,13 @@ static const struct usb_device_id	products[] = {
 	.driver_info = 0,
 },
 
+/* Lenovo ThinkPad Hybrid USB-C with USB-A Dock (40af0135eu, based on Realtek RTL8153) */
+{
+	USB_DEVICE_AND_INTERFACE_INFO(LENOVO_VENDOR_ID, 0xa359, USB_CLASS_COMM,
+			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
+	.driver_info = 0,
+},
+
 /* Aquantia AQtion USB to 5GbE Controller (based on AQC111U) */
 {
 	USB_DEVICE_AND_INTERFACE_INFO(AQUANTIA_VENDOR_ID, 0xc101,
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 468c73974046..96fa3857d8e2 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -785,6 +785,7 @@ enum rtl8152_flags {
 #define DEVICE_ID_THINKPAD_USB_C_DONGLE			0x720c
 #define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2		0xa387
 #define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3		0x3062
+#define DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK		0xa359
 
 struct tally_counter {
 	__le64	tx_packets;
@@ -9787,6 +9788,7 @@ static bool rtl8152_supports_lenovo_macpassthru(struct usb_device *udev)
 		case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2:
 		case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3:
 		case DEVICE_ID_THINKPAD_USB_C_DONGLE:
+		case DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK:
 			return 1;
 		}
 	} else if (vendor_id == VENDOR_ID_REALTEK && parent_vendor_id == VENDOR_ID_LENOVO) {
@@ -10064,6 +10066,8 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0927) },
 	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0c5e) },
 	{ USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101) },
+
+	/* Lenovo */
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x304f) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3054) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
@@ -10074,7 +10078,9 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x720c) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x721e) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0xa359) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0xa387) },
+
 	{ USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041) },
 	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
 	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
diff --git a/drivers/net/usb/r8153_ecm.c b/drivers/net/usb/r8153_ecm.c
index 20b2df8d74ae..8d860dacdf49 100644
--- a/drivers/net/usb/r8153_ecm.c
+++ b/drivers/net/usb/r8153_ecm.c
@@ -135,6 +135,12 @@ static const struct usb_device_id products[] = {
 				      USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long)&r8153_info,
 },
+/* Lenovo ThinkPad Hybrid USB-C with USB-A Dock (40af0135eu, based on Realtek RTL8153) */
+{
+	USB_DEVICE_AND_INTERFACE_INFO(VENDOR_ID_LENOVO, 0xa359, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&r8153_info,
+},
 
 	{ },		/* END */
 };
diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 97b12f51ef28..9389dc5f4a3d 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -1290,6 +1290,7 @@ static void ath11k_ahb_remove(struct platform_device *pdev)
 	ath11k_core_deinit(ab);
 
 qmi_fail:
+	ath11k_fw_destroy(ab);
 	ath11k_ahb_free_resources(ab);
 }
 
@@ -1309,6 +1310,7 @@ static void ath11k_ahb_shutdown(struct platform_device *pdev)
 	ath11k_core_deinit(ab);
 
 free_resources:
+	ath11k_fw_destroy(ab);
 	ath11k_ahb_free_resources(ab);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index ccf4ad35fdc3..7eba6ee054ff 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -2214,7 +2214,6 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 	ath11k_hif_power_down(ab);
 	ath11k_mac_destroy(ab);
 	ath11k_core_soc_destroy(ab);
-	ath11k_fw_destroy(ab);
 }
 EXPORT_SYMBOL(ath11k_core_deinit);
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index fbf666d0ecf1..f124b7329e1a 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <crypto/hash.h>
@@ -104,14 +104,12 @@ void ath11k_dp_srng_cleanup(struct ath11k_base *ab, struct dp_srng *ring)
 	if (!ring->vaddr_unaligned)
 		return;
 
-	if (ring->cached) {
-		dma_unmap_single(ab->dev, ring->paddr_unaligned, ring->size,
-				 DMA_FROM_DEVICE);
-		kfree(ring->vaddr_unaligned);
-	} else {
+	if (ring->cached)
+		dma_free_noncoherent(ab->dev, ring->size, ring->vaddr_unaligned,
+				     ring->paddr_unaligned, DMA_FROM_DEVICE);
+	else
 		dma_free_coherent(ab->dev, ring->size, ring->vaddr_unaligned,
 				  ring->paddr_unaligned);
-	}
 
 	ring->vaddr_unaligned = NULL;
 }
@@ -249,25 +247,14 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 		default:
 			cached = false;
 		}
-
-		if (cached) {
-			ring->vaddr_unaligned = kzalloc(ring->size, GFP_KERNEL);
-			if (!ring->vaddr_unaligned)
-				return -ENOMEM;
-
-			ring->paddr_unaligned = dma_map_single(ab->dev,
-							       ring->vaddr_unaligned,
-							       ring->size,
-							       DMA_FROM_DEVICE);
-			if (dma_mapping_error(ab->dev, ring->paddr_unaligned)) {
-				kfree(ring->vaddr_unaligned);
-				ring->vaddr_unaligned = NULL;
-				return -ENOMEM;
-			}
-		}
 	}
 
-	if (!cached)
+	if (cached)
+		ring->vaddr_unaligned = dma_alloc_noncoherent(ab->dev, ring->size,
+							      &ring->paddr_unaligned,
+							      DMA_FROM_DEVICE,
+							      GFP_KERNEL);
+	else
 		ring->vaddr_unaligned = dma_alloc_coherent(ab->dev, ring->size,
 							   &ring->paddr_unaligned,
 							   GFP_KERNEL);
diff --git a/drivers/net/wireless/ath/ath11k/fw.c b/drivers/net/wireless/ath/ath11k/fw.c
index 4e36292a79db..cbbd8e57119f 100644
--- a/drivers/net/wireless/ath/ath11k/fw.c
+++ b/drivers/net/wireless/ath/ath11k/fw.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
- * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
@@ -166,3 +166,4 @@ void ath11k_fw_destroy(struct ath11k_base *ab)
 {
 	release_firmware(ab->fw.fw);
 }
+EXPORT_SYMBOL(ath11k_fw_destroy);
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index be9d2c69cc41..6ebfa5d02e2e 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -981,6 +981,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	ath11k_core_deinit(ab);
 
 qmi_fail:
+	ath11k_fw_destroy(ab);
 	ath11k_mhi_unregister(ab_pci);
 
 	ath11k_pcic_free_irq(ab);
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 5c6749bc4039..1706ec27eb9c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2533,7 +2533,7 @@ int ath12k_dp_mon_rx_process_stats(struct ath12k *ar, int mac_id,
 		dest_idx = 0;
 move_next:
 		ath12k_dp_mon_buf_replenish(ab, buf_ring, 1);
-		ath12k_hal_srng_src_get_next_entry(ab, srng);
+		ath12k_hal_srng_dst_get_next_entry(ab, srng);
 		num_buffs_reaped++;
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 91e3393f7b5f..4cbba96121a1 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2470,6 +2470,29 @@ static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *nap
 	ieee80211_rx_napi(ath12k_ar_to_hw(ar), pubsta, msdu, napi);
 }
 
+static bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
+						   struct hal_rx_desc *rx_desc,
+						   struct sk_buff *msdu)
+{
+	struct ieee80211_hdr *hdr;
+	u8 decap_type;
+	u32 hdr_len;
+
+	decap_type = ath12k_dp_rx_h_decap_type(ab, rx_desc);
+	if (decap_type != DP_RX_DECAP_TYPE_NATIVE_WIFI)
+		return true;
+
+	hdr = (struct ieee80211_hdr *)msdu->data;
+	hdr_len = ieee80211_hdrlen(hdr->frame_control);
+
+	if ((likely(hdr_len <= DP_MAX_NWIFI_HDR_LEN)))
+		return true;
+
+	ab->soc_stats.invalid_rbm++;
+	WARN_ON_ONCE(1);
+	return false;
+}
+
 static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 				     struct sk_buff *msdu,
 				     struct sk_buff_head *msdu_list,
@@ -2528,6 +2551,11 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 		}
 	}
 
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu))) {
+		ret = -EINVAL;
+		goto free_out;
+	}
+
 	ath12k_dp_rx_h_ppdu(ar, rx_desc, rx_status);
 	ath12k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_status);
 
@@ -2880,6 +2908,9 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
 	skb_pull(msdu, hal_rx_desc_sz);
 
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu)))
+		return -EINVAL;
+
 	ath12k_dp_rx_h_ppdu(ar, rx_desc, rxs);
 	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
 			       HAL_ENCRYPT_TYPE_TKIP_MIC, rxs, true);
@@ -3600,6 +3631,9 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 		skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 		skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 	}
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
+		return -EINVAL;
+
 	ath12k_dp_rx_h_ppdu(ar, desc, status);
 
 	ath12k_dp_rx_h_mpdu(ar, msdu, desc, status);
@@ -3644,7 +3678,7 @@ static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
 	return drop;
 }
 
-static void ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
+static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 					struct ieee80211_rx_status *status)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -3662,6 +3696,9 @@ static void ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
+		return true;
+
 	ath12k_dp_rx_h_ppdu(ar, desc, status);
 
 	status->flag |= (RX_FLAG_MMIC_STRIPPED | RX_FLAG_MMIC_ERROR |
@@ -3669,6 +3706,7 @@ static void ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 
 	ath12k_dp_rx_h_undecap(ar, msdu, desc,
 			       HAL_ENCRYPT_TYPE_TKIP_MIC, status, false);
+	return false;
 }
 
 static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
@@ -3687,7 +3725,7 @@ static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR:
 		err_bitmap = ath12k_dp_rx_h_mpdu_err(ab, rx_desc);
 		if (err_bitmap & HAL_RX_MPDU_ERR_TKIP_MIC) {
-			ath12k_dp_rx_h_tkip_mic_err(ar, msdu, status);
+			drop = ath12k_dp_rx_h_tkip_mic_err(ar, msdu, status);
 			break;
 		}
 		fallthrough;
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index bd269aa1740b..2ff866e1d7d5 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1541,6 +1541,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 	ath12k_core_deinit(ab);
 
 qmi_fail:
+	ath12k_fw_unmap(ab);
 	ath12k_mhi_unregister(ab_pci);
 
 	ath12k_pci_free_irq(ab);
diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 0bc66cc19acd..443517d06c9f 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -95,6 +95,10 @@ int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int offset, int l
 
 #ifdef CONFIG_NL80211_TESTMODE
 	dev->test_mtd.name = devm_kstrdup(dev->dev, part, GFP_KERNEL);
+	if (!dev->test_mtd.name) {
+		ret = -ENOMEM;
+		goto out_put_node;
+	}
 	dev->test_mtd.offset = offset;
 #endif
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0b75a45ad2e8..e2e9b5ece74e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -755,6 +755,7 @@ struct mt76_testmode_data {
 
 struct mt76_vif {
 	u8 idx;
+	u8 link_idx;
 	u8 omac_idx;
 	u8 band_idx;
 	u8 wmm_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 7d07e720e4ec..452579ccc492 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1164,7 +1164,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
 			.len = cpu_to_le16(sizeof(struct req_tlv)),
 			.active = enable,
-			.link_idx = mvif->idx,
+			.link_idx = mvif->link_idx,
 		},
 	};
 	struct {
@@ -1187,7 +1187,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 			.bmc_tx_wlan_idx = cpu_to_le16(wcid->idx),
 			.sta_idx = cpu_to_le16(wcid->idx),
 			.conn_state = 1,
-			.link_idx = mvif->idx,
+			.link_idx = mvif->link_idx,
 		},
 	};
 	int err, idx, cmd, len;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index e832ad53e239..a4f4d12f904e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -22,6 +22,7 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
 	{ USB_DEVICE(0x045e, 0x02e6) },	/* XBox One Wireless Adapter */
 	{ USB_DEVICE(0x045e, 0x02fe) },	/* XBox One Wireless Adapter */
+	{ USB_DEVICE(0x2357, 0x0137) },	/* TP-Link TL-WDN6200 */
 	{ },
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index ddc67423efe2..d2a98c92e114 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -256,7 +256,7 @@ int mt7925_init_mlo_caps(struct mt792x_phy *phy)
 
 	ext_capab[0].eml_capabilities = phy->eml_cap;
 	ext_capab[0].mld_capa_and_ops =
-		u16_encode_bits(1, IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS);
+		u16_encode_bits(0, IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS);
 
 	wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
 	wiphy->iftype_ext_capab = ext_capab;
@@ -356,10 +356,15 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 	struct mt76_txq *mtxq;
 	int idx, ret = 0;
 
-	mconf->mt76.idx = __ffs64(~dev->mt76.vif_mask);
-	if (mconf->mt76.idx >= MT792x_MAX_INTERFACES) {
-		ret = -ENOSPC;
-		goto out;
+	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+		mconf->mt76.idx = MT792x_MAX_INTERFACES;
+	} else {
+		mconf->mt76.idx = __ffs64(~dev->mt76.vif_mask);
+
+		if (mconf->mt76.idx >= MT792x_MAX_INTERFACES) {
+			ret = -ENOSPC;
+			goto out;
+		}
 	}
 
 	mconf->mt76.omac_idx = ieee80211_vif_is_mld(vif) ?
@@ -367,6 +372,7 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 	mconf->mt76.band_idx = 0xff;
 	mconf->mt76.wmm_idx = ieee80211_vif_is_mld(vif) ?
 			      0 : mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
+	mconf->mt76.link_idx = hweight16(mvif->valid_links);
 
 	if (mvif->phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
 		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL + 4;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index c7eba60897d2..8476f9caa98d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3119,13 +3119,14 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		.env = env_cap,
 	};
 	int ret, valid_cnt = 0;
-	u8 i, *pos;
+	u8 *pos, *last_pos;
 
 	if (!clc)
 		return 0;
 
 	pos = clc->data + sizeof(*seg) * clc->nr_seg;
-	for (i = 0; i < clc->nr_country; i++) {
+	last_pos = clc->data + le32_to_cpu(*(__le32 *)(clc->data + 4));
+	while (pos < last_pos) {
 		struct mt7925_clc_rule *rule = (struct mt7925_clc_rule *)pos;
 
 		pos += sizeof(*rule);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index fe6a613ba008..887427e0760a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -566,8 +566,8 @@ struct mt7925_wow_pattern_tlv {
 	u8 offset;
 	u8 mask[MT76_CONNAC_WOW_MASK_MAX_LEN];
 	u8 pattern[MT76_CONNAC_WOW_PATTEN_MAX_LEN];
-	u8 rsv[7];
-} __packed;
+	u8 rsv[4];
+};
 
 struct roc_acquire_tlv {
 	__le16 tag;
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index a22ea4a4b202..4f775c3e218f 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1353,7 +1353,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	qp_count = ilog2(qp_bitmap);
 	if (nt->use_msi) {
 		qp_count -= 1;
-		nt->msi_db_mask = 1 << qp_count;
+		nt->msi_db_mask = BIT_ULL(qp_count);
 		ntb_db_clear_mask(ndev, nt->msi_db_mask);
 	}
 
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index e1abb27927ff..da195d61a966 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -478,7 +478,7 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	if (targetport) {
 		tport = targetport->private;
 		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &tport->ls_list);
 		spin_unlock(&tport->lock);
 		queue_work(nvmet_wq, &tport->ls_work);
 	}
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 1fb329c0a55b..5fbfc4d4e06e 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt)	"OF: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/list.h>
@@ -38,11 +39,15 @@
 unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
 {
 	struct of_phandle_args oirq;
+	unsigned int ret;
 
 	if (of_irq_parse_one(dev, index, &oirq))
 		return 0;
 
-	return irq_create_of_mapping(&oirq);
+	ret = irq_create_of_mapping(&oirq);
+	of_node_put(oirq.np);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
 
@@ -165,6 +170,8 @@ const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_ph
  * the specifier for each map, and then returns the translated map.
  *
  * Return: 0 on success and a negative number on error
+ *
+ * Note: refcount of node @out_irq->np is increased by 1 on success.
  */
 int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 {
@@ -310,6 +317,12 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		addrsize = (imap - match_array) - intsize;
 
 		if (ipar == newpar) {
+			/*
+			 * We got @ipar's refcount, but the refcount was
+			 * gotten again by of_irq_parse_imap_parent() via its
+			 * alias @newpar.
+			 */
+			of_node_put(ipar);
 			pr_debug("%pOF interrupt-map entry to self\n", ipar);
 			return 0;
 		}
@@ -339,10 +352,12 @@ EXPORT_SYMBOL_GPL(of_irq_parse_raw);
  * This function resolves an interrupt for a node by walking the interrupt tree,
  * finding which interrupt controller node it is attached to, and returning the
  * interrupt specifier that can be used to retrieve a Linux IRQ number.
+ *
+ * Note: refcount of node @out_irq->np is increased by 1 on success.
  */
 int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_args *out_irq)
 {
-	struct device_node *p;
+	struct device_node __free(device_node) *p = NULL;
 	const __be32 *addr;
 	u32 intsize;
 	int i, res, addr_len;
@@ -367,41 +382,33 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 	/* Try the new-style interrupts-extended first */
 	res = of_parse_phandle_with_args(device, "interrupts-extended",
 					"#interrupt-cells", index, out_irq);
-	if (!res)
-		return of_irq_parse_raw(addr_buf, out_irq);
-
-	/* Look for the interrupt parent. */
-	p = of_irq_find_parent(device);
-	if (p == NULL)
-		return -EINVAL;
+	if (!res) {
+		p = out_irq->np;
+	} else {
+		/* Look for the interrupt parent. */
+		p = of_irq_find_parent(device);
+		/* Get size of interrupt specifier */
+		if (!p || of_property_read_u32(p, "#interrupt-cells", &intsize))
+			return -EINVAL;
+
+		pr_debug(" parent=%pOF, intsize=%d\n", p, intsize);
+
+		/* Copy intspec into irq structure */
+		out_irq->np = p;
+		out_irq->args_count = intsize;
+		for (i = 0; i < intsize; i++) {
+			res = of_property_read_u32_index(device, "interrupts",
+							(index * intsize) + i,
+							out_irq->args + i);
+			if (res)
+				return res;
+		}
 
-	/* Get size of interrupt specifier */
-	if (of_property_read_u32(p, "#interrupt-cells", &intsize)) {
-		res = -EINVAL;
-		goto out;
+		pr_debug(" intspec=%d\n", *out_irq->args);
 	}
 
-	pr_debug(" parent=%pOF, intsize=%d\n", p, intsize);
-
-	/* Copy intspec into irq structure */
-	out_irq->np = p;
-	out_irq->args_count = intsize;
-	for (i = 0; i < intsize; i++) {
-		res = of_property_read_u32_index(device, "interrupts",
-						 (index * intsize) + i,
-						 out_irq->args + i);
-		if (res)
-			goto out;
-	}
-
-	pr_debug(" intspec=%d\n", *out_irq->args);
-
-
 	/* Check if there are any interrupt-map translations to process */
-	res = of_irq_parse_raw(addr_buf, out_irq);
- out:
-	of_node_put(p);
-	return res;
+	return of_irq_parse_raw(addr_buf, out_irq);
 }
 EXPORT_SYMBOL_GPL(of_irq_parse_one);
 
@@ -505,8 +512,10 @@ int of_irq_count(struct device_node *dev)
 	struct of_phandle_args irq;
 	int nr = 0;
 
-	while (of_irq_parse_one(dev, nr, &irq) == 0)
+	while (of_irq_parse_one(dev, nr, &irq) == 0) {
+		of_node_put(irq.np);
 		nr++;
+	}
 
 	return nr;
 }
@@ -623,6 +632,8 @@ void __init of_irq_init(const struct of_device_id *matches)
 				       __func__, desc->dev, desc->dev,
 				       desc->interrupt_parent);
 				of_node_clear_flag(desc->dev, OF_POPULATED);
+				of_node_put(desc->interrupt_parent);
+				of_node_put(desc->dev);
 				kfree(desc);
 				continue;
 			}
@@ -653,6 +664,7 @@ void __init of_irq_init(const struct of_device_id *matches)
 err:
 	list_for_each_entry_safe(desc, temp_desc, &intc_desc_list, list) {
 		list_del(&desc->list);
+		of_node_put(desc->interrupt_parent);
 		of_node_put(desc->dev);
 		kfree(desc);
 	}
diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index e091c3e55b5c..bae829ac759e 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -355,6 +355,7 @@ static const struct j721e_pcie_data j7200_pcie_rc_data = {
 static const struct j721e_pcie_data j7200_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
 	.quirk_detect_quiet_flag = true,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.quirk_disable_flr = true,
 	.max_lanes = 2,
 };
@@ -376,13 +377,13 @@ static const struct j721e_pcie_data j784s4_pcie_rc_data = {
 	.mode = PCI_MODE_RC,
 	.quirk_retrain_flag = true,
 	.byte_access_allowed = false,
-	.linkdown_irq_regfield = LINK_DOWN,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.max_lanes = 4,
 };
 
 static const struct j721e_pcie_data j784s4_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
-	.linkdown_irq_regfield = LINK_DOWN,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.max_lanes = 4,
 };
 
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 582fa1107087..792d24cea574 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1786,7 +1786,7 @@ static struct pci_ops brcm7425_pcie_ops = {
 
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node, *msi_np;
+	struct device_node *np = pdev->dev.of_node;
 	struct pci_host_bridge *bridge;
 	const struct pcie_cfg_data *data;
 	struct brcm_pcie *pcie;
@@ -1890,9 +1890,14 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
-	if (pci_msi_enabled() && msi_np == pcie->np) {
-		ret = brcm_pcie_enable_msi(pcie);
+	if (pci_msi_enabled()) {
+		struct device_node *msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
+
+		if (msi_np == pcie->np)
+			ret = brcm_pcie_enable_msi(pcie);
+
+		of_node_put(msi_np);
+
 		if (ret) {
 			dev_err(pcie->dev, "probe of internal MSI failed");
 			goto fail;
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index cbec71114825..481dcc476c55 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -367,7 +367,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		}
 	}
 
-	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
+	rockchip_pcie_write(rockchip, PCI_VENDOR_ID_ROCKCHIP,
 			    PCIE_CORE_CONFIG_VENDOR);
 	rockchip_pcie_write(rockchip,
 			    PCI_CLASS_BRIDGE_PCI_NORMAL << 8,
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 15ee949f2485..688f51d9bde6 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -188,7 +188,6 @@
 #define AXI_WRAPPER_NOR_MSG			0xc
 
 #define PCIE_RC_SEND_PME_OFF			0x11960
-#define ROCKCHIP_VENDOR_ID			0x1d87
 #define PCIE_LINK_IS_L2(x) \
 	(((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) == PCIE_CLIENT_DEBUG_LTSSM_L2)
 #define PCIE_LINK_UP(x) \
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9d9596947350..94ceec50a2b9 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -125,7 +125,7 @@ struct vmd_irq_list {
 struct vmd_dev {
 	struct pci_dev		*dev;
 
-	spinlock_t		cfg_lock;
+	raw_spinlock_t		cfg_lock;
 	void __iomem		*cfgbar;
 
 	int msix_count;
@@ -391,7 +391,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		*value = readb(addr);
@@ -406,7 +406,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -426,7 +426,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		writeb(value, addr);
@@ -444,7 +444,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -1009,7 +1009,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
-	spin_lock_init(&vmd->cfg_lock);
+	raw_spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
 	if (err)
diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 643f85849ef6..3f2691888c35 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -40,7 +40,7 @@
  * Legacy struct storing addresses to whole mapped BARs.
  */
 struct pcim_iomap_devres {
-	void __iomem *table[PCI_STD_NUM_BARS];
+	void __iomem *table[PCI_NUM_RESOURCES];
 };
 
 /* Used to restore the old INTx state on driver detach. */
@@ -577,7 +577,7 @@ static int pcim_add_mapping_to_legacy_table(struct pci_dev *pdev,
 {
 	void __iomem **legacy_iomap_table;
 
-	if (bar >= PCI_STD_NUM_BARS)
+	if (!pci_bar_index_is_valid(bar))
 		return -EINVAL;
 
 	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
@@ -622,7 +622,7 @@ static void pcim_remove_bar_from_legacy_table(struct pci_dev *pdev, int bar)
 {
 	void __iomem **legacy_iomap_table;
 
-	if (bar >= PCI_STD_NUM_BARS)
+	if (!pci_bar_index_is_valid(bar))
 		return;
 
 	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
@@ -655,6 +655,9 @@ void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
 	void __iomem *mapping;
 	struct pcim_addr_devres *res;
 
+	if (!pci_bar_index_is_valid(bar))
+		return NULL;
+
 	res = pcim_addr_devres_alloc(pdev);
 	if (!res)
 		return NULL;
@@ -722,6 +725,9 @@ void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 	int ret;
 	struct pcim_addr_devres *res;
 
+	if (!pci_bar_index_is_valid(bar))
+		return IOMEM_ERR_PTR(-EINVAL);
+
 	res = pcim_addr_devres_alloc(pdev);
 	if (!res)
 		return IOMEM_ERR_PTR(-ENOMEM);
@@ -822,6 +828,9 @@ static int _pcim_request_region(struct pci_dev *pdev, int bar, const char *name,
 	int ret;
 	struct pcim_addr_devres *res;
 
+	if (!pci_bar_index_is_valid(bar))
+		return -EINVAL;
+
 	res = pcim_addr_devres_alloc(pdev);
 	if (!res)
 		return -ENOMEM;
@@ -1043,6 +1052,9 @@ void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
 	void __iomem *mapping;
 	struct pcim_addr_devres *res;
 
+	if (!pci_bar_index_is_valid(bar))
+		return IOMEM_ERR_PTR(-EINVAL);
+
 	res = pcim_addr_devres_alloc(pdev);
 	if (!res)
 		return IOMEM_ERR_PTR(-ENOMEM);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ff458e692fed..997841c69893 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -286,9 +286,12 @@ static int pciehp_suspend(struct pcie_device *dev)
 
 static bool pciehp_device_replaced(struct controller *ctrl)
 {
-	struct pci_dev *pdev __free(pci_dev_put);
+	struct pci_dev *pdev __free(pci_dev_put) = NULL;
 	u32 reg;
 
+	if (pci_dev_is_disconnected(ctrl->pcie->port))
+		return false;
+
 	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
 	if (!pdev)
 		return true;
diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
index 9fb7cacc15cd..fe706ed946df 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -9,6 +9,8 @@
 
 #include <linux/export.h>
 
+#include "pci.h" /* for pci_bar_index_is_valid() */
+
 /**
  * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
@@ -33,12 +35,19 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
 			      unsigned long offset,
 			      unsigned long maxlen)
 {
-	resource_size_t start = pci_resource_start(dev, bar);
-	resource_size_t len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
+	resource_size_t start, len;
+	unsigned long flags;
+
+	if (!pci_bar_index_is_valid(bar))
+		return NULL;
+
+	start = pci_resource_start(dev, bar);
+	len = pci_resource_len(dev, bar);
+	flags = pci_resource_flags(dev, bar);
 
 	if (len <= offset || !start)
 		return NULL;
+
 	len -= offset;
 	start += offset;
 	if (maxlen && len > maxlen)
@@ -77,16 +86,20 @@ void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
 				 unsigned long offset,
 				 unsigned long maxlen)
 {
-	resource_size_t start = pci_resource_start(dev, bar);
-	resource_size_t len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
+	resource_size_t start, len;
+	unsigned long flags;
 
-
-	if (flags & IORESOURCE_IO)
+	if (!pci_bar_index_is_valid(bar))
 		return NULL;
 
+	start = pci_resource_start(dev, bar);
+	len = pci_resource_len(dev, bar);
+	flags = pci_resource_flags(dev, bar);
+
 	if (len <= offset || !start)
 		return NULL;
+	if (flags & IORESOURCE_IO)
+		return NULL;
 
 	len -= offset;
 	start += offset;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 169aa8fd74a1..be61fa93d397 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3922,6 +3922,9 @@ EXPORT_SYMBOL(pci_enable_atomic_ops_to_root);
  */
 void pci_release_region(struct pci_dev *pdev, int bar)
 {
+	if (!pci_bar_index_is_valid(bar))
+		return;
+
 	/*
 	 * This is done for backwards compatibility, because the old PCI devres
 	 * API had a mode in which the function became managed if it had been
@@ -3967,6 +3970,9 @@ EXPORT_SYMBOL(pci_release_region);
 static int __pci_request_region(struct pci_dev *pdev, int bar,
 				const char *res_name, int exclusive)
 {
+	if (!pci_bar_index_is_valid(bar))
+		return -EINVAL;
+
 	if (pci_is_managed(pdev)) {
 		if (exclusive == IORESOURCE_EXCLUSIVE)
 			return pcim_request_region_exclusive(pdev, bar, res_name);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1cdc2c9547a7..65df6d2ac003 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -165,6 +165,22 @@ static inline void pci_wakeup_event(struct pci_dev *dev)
 	pm_wakeup_event(&dev->dev, 100);
 }
 
+/**
+ * pci_bar_index_is_valid - Check whether a BAR index is within valid range
+ * @bar: BAR index
+ *
+ * Protects against overflowing &struct pci_dev.resource array.
+ *
+ * Return: true for valid index, false otherwise.
+ */
+static inline bool pci_bar_index_is_valid(int bar)
+{
+	if (bar >= 0 && bar < PCI_NUM_RESOURCES)
+		return true;
+
+	return false;
+}
+
 static inline bool pci_has_subordinate(struct pci_dev *pci_dev)
 {
 	return !!(pci_dev->subordinate);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0e757b23a09f..cf7c7886b642 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -908,6 +908,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	resource_size_t offset, next_offset;
 	LIST_HEAD(resources);
 	struct resource *res, *next_res;
+	bool bus_registered = false;
 	char addr[64], *fmt;
 	const char *name;
 	int err;
@@ -971,6 +972,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	name = dev_name(&bus->dev);
 
 	err = device_register(&bus->dev);
+	bus_registered = true;
 	if (err)
 		goto unregister;
 
@@ -1057,12 +1059,15 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 unregister:
 	put_device(&bridge->dev);
 	device_del(&bridge->dev);
-
 free:
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	pci_bus_release_domain_nr(parent, bus->domain_nr);
 #endif
-	kfree(bus);
+	if (bus_registered)
+		put_device(&bus->dev);
+	else
+		kfree(bus);
+
 	return err;
 }
 
@@ -1171,7 +1176,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 add_dev:
 	pci_set_bus_msi_domain(child);
 	ret = device_register(&child->dev);
-	WARN_ON(ret < 0);
+	if (WARN_ON(ret < 0)) {
+		put_device(&child->dev);
+		return NULL;
+	}
 
 	pcibios_add_bus(child);
 
@@ -1327,8 +1335,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
-	pci_enable_rrs_sv(dev);
-
 	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
 	    !is_cardbus && !broken) {
 		unsigned int cmax, buses;
@@ -1569,6 +1575,11 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pdev->pcie_cap = pos;
 	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
 	pdev->pcie_flags_reg = reg16;
+
+	type = pci_pcie_type(pdev);
+	if (type == PCI_EXP_TYPE_ROOT_PORT)
+		pci_enable_rrs_sv(pdev);
+
 	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &pdev->devcap);
 	pdev->pcie_mpss = FIELD_GET(PCI_EXP_DEVCAP_PAYLOAD, pdev->devcap);
 
@@ -1585,7 +1596,6 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	 * correctly so detect impossible configurations here and correct
 	 * the port type accordingly.
 	 */
-	type = pci_pcie_type(pdev);
 	if (type == PCI_EXP_TYPE_DOWNSTREAM) {
 		/*
 		 * If pdev claims to be downstream port but the parent
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 398cce3d76fc..2f33e69a8caf 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -342,12 +342,10 @@ armpmu_add(struct perf_event *event, int flags)
 	if (idx < 0)
 		return idx;
 
-	/*
-	 * If there is an event in the counter we are going to use then make
-	 * sure it is disabled.
-	 */
+	/* The newly-allocated counter should be empty */
+	WARN_ON_ONCE(hw_events->events[idx]);
+
 	event->hw.idx = idx;
-	armpmu->disable(event);
 	hw_events->events[idx] = event;
 
 	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 4ca50f9b6dfe..7dbda36884c8 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -567,8 +567,10 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
 		return PTR_ERR(plat_dev);
 
 	dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
-	if (!dev_info)
+	if (!dev_info) {
+		platform_device_unregister(plat_dev);
 		return -ENOMEM;
+	}
 
 	/* Cache platform device to handle pci device hotplug */
 	dev_info->plat_dev = plat_dev;
@@ -724,6 +726,15 @@ static struct platform_driver dwc_pcie_pmu_driver = {
 	.driver = {.name = "dwc_pcie_pmu",},
 };
 
+static void dwc_pcie_cleanup_devices(void)
+{
+	struct dwc_pcie_dev_info *dev_info, *tmp;
+
+	list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, dev_node) {
+		dwc_pcie_unregister_dev(dev_info);
+	}
+}
+
 static int __init dwc_pcie_pmu_init(void)
 {
 	struct pci_dev *pdev = NULL;
@@ -736,7 +747,7 @@ static int __init dwc_pcie_pmu_init(void)
 		ret = dwc_pcie_register_dev(pdev);
 		if (ret) {
 			pci_dev_put(pdev);
-			return ret;
+			goto err_cleanup;
 		}
 	}
 
@@ -745,35 +756,35 @@ static int __init dwc_pcie_pmu_init(void)
 				      dwc_pcie_pmu_online_cpu,
 				      dwc_pcie_pmu_offline_cpu);
 	if (ret < 0)
-		return ret;
+		goto err_cleanup;
 
 	dwc_pcie_pmu_hp_state = ret;
 
 	ret = platform_driver_register(&dwc_pcie_pmu_driver);
 	if (ret)
-		goto platform_driver_register_err;
+		goto err_remove_cpuhp;
 
 	ret = bus_register_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
 	if (ret)
-		goto platform_driver_register_err;
+		goto err_unregister_driver;
 	notify = true;
 
 	return 0;
 
-platform_driver_register_err:
+err_unregister_driver:
+	platform_driver_unregister(&dwc_pcie_pmu_driver);
+err_remove_cpuhp:
 	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
-
+err_cleanup:
+	dwc_pcie_cleanup_devices();
 	return ret;
 }
 
 static void __exit dwc_pcie_pmu_exit(void)
 {
-	struct dwc_pcie_dev_info *dev_info, *tmp;
-
 	if (notify)
 		bus_unregister_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
-	list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, dev_node)
-		dwc_pcie_unregister_dev(dev_info);
+	dwc_pcie_cleanup_devices();
 	platform_driver_unregister(&dwc_pcie_pmu_driver);
 	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
 }
diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index e98361dcdead..afd52392cd53 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -162,6 +162,16 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 	return ret;
 }
 
+static int imx8_pcie_phy_power_off(struct phy *phy)
+{
+	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
+
+	reset_control_assert(imx8_phy->reset);
+	reset_control_assert(imx8_phy->perst);
+
+	return 0;
+}
+
 static int imx8_pcie_phy_init(struct phy *phy)
 {
 	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
@@ -182,6 +192,7 @@ static const struct phy_ops imx8_pcie_phy_ops = {
 	.init		= imx8_pcie_phy_init,
 	.exit		= imx8_pcie_phy_exit,
 	.power_on	= imx8_pcie_phy_power_on,
+	.power_off	= imx8_pcie_phy_power_off,
 	.owner		= THIS_MODULE,
 };
 
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index aeaf0d1958f5..a6bdff7a0bb2 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1044,8 +1044,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	const struct msm_pingroup *g;
 	u32 intr_target_mask = GENMASK(2, 0);
 	unsigned long flags;
-	bool was_enabled;
-	u32 val;
+	u32 val, oldval;
 
 	if (msm_gpio_needs_dual_edge_parent_workaround(d, type)) {
 		set_bit(d->hwirq, pctrl->dual_edge_irqs);
@@ -1107,8 +1106,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	 * internal circuitry of TLMM, toggling the RAW_STATUS
 	 * could cause the INTR_STATUS to be set for EDGE interrupts.
 	 */
-	val = msm_readl_intr_cfg(pctrl, g);
-	was_enabled = val & BIT(g->intr_raw_status_bit);
+	val = oldval = msm_readl_intr_cfg(pctrl, g);
 	val |= BIT(g->intr_raw_status_bit);
 	if (g->intr_detection_width == 2) {
 		val &= ~(3 << g->intr_detection_bit);
@@ -1161,9 +1159,11 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	/*
 	 * The first time we set RAW_STATUS_EN it could trigger an interrupt.
 	 * Clear the interrupt.  This is safe because we have
-	 * IRQCHIP_SET_TYPE_MASKED.
+	 * IRQCHIP_SET_TYPE_MASKED. When changing the interrupt type, we could
+	 * also still have a non-matching interrupt latched, so clear whenever
+	 * making changes to the interrupt configuration.
 	 */
-	if (!was_enabled)
+	if (val != oldval)
 		msm_ack_intr_status(pctrl, g);
 
 	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index 5480e0884abe..23b4bc1e5da8 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -939,83 +939,83 @@ const struct samsung_pinctrl_of_match_data fsd_of_data __initconst = {
 
 /* pin banks of gs101 pin-controller (ALIVE) */
 static const struct samsung_pin_bank_data gs101_pin_alive[] = {
-	EXYNOS850_PIN_BANK_EINTW(8, 0x0, "gpa0", 0x00),
-	EXYNOS850_PIN_BANK_EINTW(7, 0x20, "gpa1", 0x04),
-	EXYNOS850_PIN_BANK_EINTW(5, 0x40, "gpa2", 0x08),
-	EXYNOS850_PIN_BANK_EINTW(4, 0x60, "gpa3", 0x0c),
-	EXYNOS850_PIN_BANK_EINTW(4, 0x80, "gpa4", 0x10),
-	EXYNOS850_PIN_BANK_EINTW(7, 0xa0, "gpa5", 0x14),
-	EXYNOS850_PIN_BANK_EINTW(8, 0xc0, "gpa9", 0x18),
-	EXYNOS850_PIN_BANK_EINTW(2, 0xe0, "gpa10", 0x1c),
+	GS101_PIN_BANK_EINTW(8, 0x0, "gpa0", 0x00, 0x00),
+	GS101_PIN_BANK_EINTW(7, 0x20, "gpa1", 0x04, 0x08),
+	GS101_PIN_BANK_EINTW(5, 0x40, "gpa2", 0x08, 0x10),
+	GS101_PIN_BANK_EINTW(4, 0x60, "gpa3", 0x0c, 0x18),
+	GS101_PIN_BANK_EINTW(4, 0x80, "gpa4", 0x10, 0x1c),
+	GS101_PIN_BANK_EINTW(7, 0xa0, "gpa5", 0x14, 0x20),
+	GS101_PIN_BANK_EINTW(8, 0xc0, "gpa9", 0x18, 0x28),
+	GS101_PIN_BANK_EINTW(2, 0xe0, "gpa10", 0x1c, 0x30),
 };
 
 /* pin banks of gs101 pin-controller (FAR_ALIVE) */
 static const struct samsung_pin_bank_data gs101_pin_far_alive[] = {
-	EXYNOS850_PIN_BANK_EINTW(8, 0x0, "gpa6", 0x00),
-	EXYNOS850_PIN_BANK_EINTW(4, 0x20, "gpa7", 0x04),
-	EXYNOS850_PIN_BANK_EINTW(8, 0x40, "gpa8", 0x08),
-	EXYNOS850_PIN_BANK_EINTW(2, 0x60, "gpa11", 0x0c),
+	GS101_PIN_BANK_EINTW(8, 0x0, "gpa6", 0x00, 0x00),
+	GS101_PIN_BANK_EINTW(4, 0x20, "gpa7", 0x04, 0x08),
+	GS101_PIN_BANK_EINTW(8, 0x40, "gpa8", 0x08, 0x0c),
+	GS101_PIN_BANK_EINTW(2, 0x60, "gpa11", 0x0c, 0x14),
 };
 
 /* pin banks of gs101 pin-controller (GSACORE) */
 static const struct samsung_pin_bank_data gs101_pin_gsacore[] = {
-	EXYNOS850_PIN_BANK_EINTG(2, 0x0, "gps0", 0x00),
-	EXYNOS850_PIN_BANK_EINTG(8, 0x20, "gps1", 0x04),
-	EXYNOS850_PIN_BANK_EINTG(3, 0x40, "gps2", 0x08),
+	GS101_PIN_BANK_EINTG(2, 0x0, "gps0", 0x00, 0x00),
+	GS101_PIN_BANK_EINTG(8, 0x20, "gps1", 0x04, 0x04),
+	GS101_PIN_BANK_EINTG(3, 0x40, "gps2", 0x08, 0x0c),
 };
 
 /* pin banks of gs101 pin-controller (GSACTRL) */
 static const struct samsung_pin_bank_data gs101_pin_gsactrl[] = {
-	EXYNOS850_PIN_BANK_EINTW(6, 0x0, "gps3", 0x00),
+	GS101_PIN_BANK_EINTW(6, 0x0, "gps3", 0x00, 0x00),
 };
 
 /* pin banks of gs101 pin-controller (PERIC0) */
 static const struct samsung_pin_bank_data gs101_pin_peric0[] = {
-	EXYNOS850_PIN_BANK_EINTG(5, 0x0, "gpp0", 0x00),
-	EXYNOS850_PIN_BANK_EINTG(4, 0x20, "gpp1", 0x04),
-	EXYNOS850_PIN_BANK_EINTG(4, 0x40, "gpp2", 0x08),
-	EXYNOS850_PIN_BANK_EINTG(2, 0x60, "gpp3", 0x0c),
-	EXYNOS850_PIN_BANK_EINTG(4, 0x80, "gpp4", 0x10),
-	EXYNOS850_PIN_BANK_EINTG(2, 0xa0, "gpp5", 0x14),
-	EXYNOS850_PIN_BANK_EINTG(4, 0xc0, "gpp6", 0x18),
-	EXYNOS850_PIN_BANK_EINTG(2, 0xe0, "gpp7", 0x1c),
-	EXYNOS850_PIN_BANK_EINTG(4, 0x100, "gpp8", 0x20),
-	EXYNOS850_PIN_BANK_EINTG(2, 0x120, "gpp9", 0x24),
-	EXYNOS850_PIN_BANK_EINTG(4, 0x140, "gpp10", 0x28),
-	EXYNOS850_PIN_BANK_EINTG(2, 0x160, "gpp11", 0x2c),
-	EXYNOS850_PIN_BANK_EINTG(4, 0x180, "gpp12", 0x30),
-	EXYNOS850_PIN_BANK_EINTG(2, 0x1a0, "gpp13", 0x34),
-	EXYNOS850_PIN_BANK_EINTG(4, 0x1c0, "gpp14", 0x38),
-	EXYNOS850_PIN_BANK_EINTG(2, 0x1e0, "gpp15", 0x3c),
-	EXYNOS850_PIN_BANK_EINTG(4, 0x200, "gpp16", 0x40),
-	EXYNOS850_PIN_BANK_EINTG(2, 0x220, "gpp17", 0x44),
-	EXYNOS850_PIN_BANK_EINTG(4, 0x240, "gpp18", 0x48),
-	EXYNOS850_PIN_BANK_EINTG(4, 0x260, "gpp19", 0x4c),
+	GS101_PIN_BANK_EINTG(5, 0x0, "gpp0", 0x00, 0x00),
+	GS101_PIN_BANK_EINTG(4, 0x20, "gpp1", 0x04, 0x08),
+	GS101_PIN_BANK_EINTG(4, 0x40, "gpp2", 0x08, 0x0c),
+	GS101_PIN_BANK_EINTG(2, 0x60, "gpp3", 0x0c, 0x10),
+	GS101_PIN_BANK_EINTG(4, 0x80, "gpp4", 0x10, 0x14),
+	GS101_PIN_BANK_EINTG(2, 0xa0, "gpp5", 0x14, 0x18),
+	GS101_PIN_BANK_EINTG(4, 0xc0, "gpp6", 0x18, 0x1c),
+	GS101_PIN_BANK_EINTG(2, 0xe0, "gpp7", 0x1c, 0x20),
+	GS101_PIN_BANK_EINTG(4, 0x100, "gpp8", 0x20, 0x24),
+	GS101_PIN_BANK_EINTG(2, 0x120, "gpp9", 0x24, 0x28),
+	GS101_PIN_BANK_EINTG(4, 0x140, "gpp10", 0x28, 0x2c),
+	GS101_PIN_BANK_EINTG(2, 0x160, "gpp11", 0x2c, 0x30),
+	GS101_PIN_BANK_EINTG(4, 0x180, "gpp12", 0x30, 0x34),
+	GS101_PIN_BANK_EINTG(2, 0x1a0, "gpp13", 0x34, 0x38),
+	GS101_PIN_BANK_EINTG(4, 0x1c0, "gpp14", 0x38, 0x3c),
+	GS101_PIN_BANK_EINTG(2, 0x1e0, "gpp15", 0x3c, 0x40),
+	GS101_PIN_BANK_EINTG(4, 0x200, "gpp16", 0x40, 0x44),
+	GS101_PIN_BANK_EINTG(2, 0x220, "gpp17", 0x44, 0x48),
+	GS101_PIN_BANK_EINTG(4, 0x240, "gpp18", 0x48, 0x4c),
+	GS101_PIN_BANK_EINTG(4, 0x260, "gpp19", 0x4c, 0x50),
 };
 
 /* pin banks of gs101 pin-controller (PERIC1) */
 static const struct samsung_pin_bank_data gs101_pin_peric1[] = {
-	EXYNOS850_PIN_BANK_EINTG(8, 0x0, "gpp20", 0x00),
-	EXYNOS850_PIN_BANK_EINTG(4, 0x20, "gpp21", 0x04),
-	EXYNOS850_PIN_BANK_EINTG(2, 0x40, "gpp22", 0x08),
-	EXYNOS850_PIN_BANK_EINTG(8, 0x60, "gpp23", 0x0c),
-	EXYNOS850_PIN_BANK_EINTG(4, 0x80, "gpp24", 0x10),
-	EXYNOS850_PIN_BANK_EINTG(4, 0xa0, "gpp25", 0x14),
-	EXYNOS850_PIN_BANK_EINTG(5, 0xc0, "gpp26", 0x18),
-	EXYNOS850_PIN_BANK_EINTG(4, 0xe0, "gpp27", 0x1c),
+	GS101_PIN_BANK_EINTG(8, 0x0, "gpp20", 0x00, 0x00),
+	GS101_PIN_BANK_EINTG(4, 0x20, "gpp21", 0x04, 0x08),
+	GS101_PIN_BANK_EINTG(2, 0x40, "gpp22", 0x08, 0x0c),
+	GS101_PIN_BANK_EINTG(8, 0x60, "gpp23", 0x0c, 0x10),
+	GS101_PIN_BANK_EINTG(4, 0x80, "gpp24", 0x10, 0x18),
+	GS101_PIN_BANK_EINTG(4, 0xa0, "gpp25", 0x14, 0x1c),
+	GS101_PIN_BANK_EINTG(5, 0xc0, "gpp26", 0x18, 0x20),
+	GS101_PIN_BANK_EINTG(4, 0xe0, "gpp27", 0x1c, 0x28),
 };
 
 /* pin banks of gs101 pin-controller (HSI1) */
 static const struct samsung_pin_bank_data gs101_pin_hsi1[] = {
-	EXYNOS850_PIN_BANK_EINTG(6, 0x0, "gph0", 0x00),
-	EXYNOS850_PIN_BANK_EINTG(7, 0x20, "gph1", 0x04),
+	GS101_PIN_BANK_EINTG(6, 0x0, "gph0", 0x00, 0x00),
+	GS101_PIN_BANK_EINTG(7, 0x20, "gph1", 0x04, 0x08),
 };
 
 /* pin banks of gs101 pin-controller (HSI2) */
 static const struct samsung_pin_bank_data gs101_pin_hsi2[] = {
-	EXYNOS850_PIN_BANK_EINTG(6, 0x0, "gph2", 0x00),
-	EXYNOS850_PIN_BANK_EINTG(2, 0x20, "gph3", 0x04),
-	EXYNOS850_PIN_BANK_EINTG(6, 0x40, "gph4", 0x08),
+	GS101_PIN_BANK_EINTG(6, 0x0, "gph2", 0x00, 0x00),
+	GS101_PIN_BANK_EINTG(2, 0x20, "gph3", 0x04, 0x08),
+	GS101_PIN_BANK_EINTG(6, 0x40, "gph4", 0x08, 0x0c),
 };
 
 static const struct samsung_pin_ctrl gs101_pin_ctrl[] __initconst = {
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 305cb1d31de4..97a43fa4dfc5 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -165,6 +165,28 @@
 		.name			= id				\
 	}
 
+#define GS101_PIN_BANK_EINTG(pins, reg, id, offs, fltcon_offs) \
+	{							\
+		.type			= &exynos850_bank_type_off,	\
+		.pctl_offset		= reg,			\
+		.nr_pins		= pins,			\
+		.eint_type		= EINT_TYPE_GPIO,	\
+		.eint_offset		= offs,			\
+		.eint_fltcon_offset	= fltcon_offs,		\
+		.name			= id			\
+	}
+
+#define GS101_PIN_BANK_EINTW(pins, reg, id, offs, fltcon_offs) \
+	{								\
+		.type			= &exynos850_bank_type_alive,	\
+		.pctl_offset		= reg,				\
+		.nr_pins		= pins,				\
+		.eint_type		= EINT_TYPE_WKUP,		\
+		.eint_offset		= offs,				\
+		.eint_fltcon_offset	= fltcon_offs,			\
+		.name			= id				\
+	}
+
 /**
  * struct exynos_weint_data: irq specific data for all the wakeup interrupts
  * generated by the external wakeup interrupt controller.
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index c142cd792030..63ac89a802d3 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1230,6 +1230,7 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 		bank->eint_con_offset = bdata->eint_con_offset;
 		bank->eint_mask_offset = bdata->eint_mask_offset;
 		bank->eint_pend_offset = bdata->eint_pend_offset;
+		bank->eint_fltcon_offset = bdata->eint_fltcon_offset;
 		bank->name = bdata->name;
 
 		raw_spin_lock_init(&bank->slock);
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index a1e7377bd890..14c3b6b96585 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -144,6 +144,7 @@ struct samsung_pin_bank_type {
  * @eint_con_offset: ExynosAuto SoC-specific EINT control register offset of bank.
  * @eint_mask_offset: ExynosAuto SoC-specific EINT mask register offset of bank.
  * @eint_pend_offset: ExynosAuto SoC-specific EINT pend register offset of bank.
+ * @eint_fltcon_offset: GS101 SoC-specific EINT filter config register offset.
  * @name: name to be prefixed for each pin in this pin bank.
  */
 struct samsung_pin_bank_data {
@@ -158,6 +159,7 @@ struct samsung_pin_bank_data {
 	u32		eint_con_offset;
 	u32		eint_mask_offset;
 	u32		eint_pend_offset;
+	u32		eint_fltcon_offset;
 	const char	*name;
 };
 
@@ -175,6 +177,7 @@ struct samsung_pin_bank_data {
  * @eint_con_offset: ExynosAuto SoC-specific EINT register or interrupt offset of bank.
  * @eint_mask_offset: ExynosAuto SoC-specific EINT mask register offset of bank.
  * @eint_pend_offset: ExynosAuto SoC-specific EINT pend register offset of bank.
+ * @eint_fltcon_offset: GS101 SoC-specific EINT filter config register offset.
  * @name: name to be prefixed for each pin in this pin bank.
  * @id: id of the bank, propagated to the pin range.
  * @pin_base: starting pin number of the bank.
@@ -201,6 +204,7 @@ struct samsung_pin_bank {
 	u32		eint_con_offset;
 	u32		eint_mask_offset;
 	u32		eint_pend_offset;
+	u32		eint_fltcon_offset;
 	const char	*name;
 	u32		id;
 
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 626e2635e3da..ac198d1fd170 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -30,6 +30,7 @@
 
 #define DRV_NAME "cros_ec_lpcs"
 #define ACPI_DRV_NAME "GOOG0004"
+#define FRMW_ACPI_DRV_NAME "FRMWC004"
 
 /* True if ACPI device is present */
 static bool cros_ec_lpc_acpi_device_found;
@@ -460,7 +461,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	acpi_status status;
 	struct cros_ec_device *ec_dev;
 	struct cros_ec_lpc *ec_lpc;
-	struct lpc_driver_data *driver_data;
+	const struct lpc_driver_data *driver_data;
 	u8 buf[2] = {};
 	int irq, ret;
 	u32 quirks;
@@ -472,6 +473,9 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	ec_lpc->mmio_memory_base = EC_LPC_ADDR_MEMMAP;
 
 	driver_data = platform_get_drvdata(pdev);
+	if (!driver_data)
+		driver_data = acpi_device_get_match_data(dev);
+
 	if (driver_data) {
 		quirks = driver_data->quirks;
 
@@ -625,12 +629,6 @@ static void cros_ec_lpc_remove(struct platform_device *pdev)
 	cros_ec_unregister(ec_dev);
 }
 
-static const struct acpi_device_id cros_ec_lpc_acpi_device_ids[] = {
-	{ ACPI_DRV_NAME, 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, cros_ec_lpc_acpi_device_ids);
-
 static const struct lpc_driver_data framework_laptop_npcx_lpc_driver_data __initconst = {
 	.quirks = CROS_EC_LPC_QUIRK_REMAP_MEMORY,
 	.quirk_mmio_memory_base = 0xE00,
@@ -642,6 +640,13 @@ static const struct lpc_driver_data framework_laptop_mec_lpc_driver_data __initc
 	.quirk_aml_mutex_name = "ECMT",
 };
 
+static const struct acpi_device_id cros_ec_lpc_acpi_device_ids[] = {
+	{ ACPI_DRV_NAME, 0 },
+	{ FRMW_ACPI_DRV_NAME, (kernel_ulong_t)&framework_laptop_npcx_lpc_driver_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cros_ec_lpc_acpi_device_ids);
+
 static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 	{
 		/*
@@ -795,7 +800,8 @@ static int __init cros_ec_lpc_init(void)
 	int ret;
 	const struct dmi_system_id *dmi_match;
 
-	cros_ec_lpc_acpi_device_found = !!cros_ec_lpc_get_device(ACPI_DRV_NAME);
+	cros_ec_lpc_acpi_device_found = !!cros_ec_lpc_get_device(ACPI_DRV_NAME) ||
+		!!cros_ec_lpc_get_device(FRMW_ACPI_DRV_NAME);
 
 	dmi_match = dmi_first_match(cros_ec_lpc_dmi_table);
 
diff --git a/drivers/platform/x86/x86-android-tablets/Kconfig b/drivers/platform/x86/x86-android-tablets/Kconfig
index 88d9e8f2ff24..c98dfbdfb9dd 100644
--- a/drivers/platform/x86/x86-android-tablets/Kconfig
+++ b/drivers/platform/x86/x86-android-tablets/Kconfig
@@ -8,6 +8,7 @@ config X86_ANDROID_TABLETS
 	depends on I2C && SPI && SERIAL_DEV_BUS && ACPI && EFI && GPIOLIB && PMIC_OPREGION
 	select NEW_LEDS
 	select LEDS_CLASS
+	select POWER_SUPPLY
 	help
 	  X86 tablets which ship with Android as (part of) the factory image
 	  typically have various problems with their DSDTs. The factory kernels
diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 2510c10ca473..c45a5fca4cbb 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -118,6 +118,9 @@ static unsigned int fsl_pwm_ticks_to_ns(struct fsl_pwm_chip *fpc,
 	unsigned long long exval;
 
 	rate = clk_get_rate(fpc->clk[fpc->period.clk_select]);
+	if (rate >> fpc->period.clk_ps == 0)
+		return 0;
+
 	exval = ticks;
 	exval *= 1000000000UL;
 	do_div(exval, rate >> fpc->period.clk_ps);
@@ -190,6 +193,9 @@ static unsigned int fsl_pwm_calculate_duty(struct fsl_pwm_chip *fpc,
 	unsigned int period = fpc->period.mod_period + 1;
 	unsigned int period_ns = fsl_pwm_ticks_to_ns(fpc, period);
 
+	if (!period_ns)
+		return 0;
+
 	duty = (unsigned long long)duty_ns * period;
 	do_div(duty, period_ns);
 
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 01dfa0fab80a..7eaab5831499 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -121,21 +121,25 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
 	    reg_thres = PWMTHRES;
+	unsigned long clk_rate;
 	u64 resolution;
 	int ret;
 
 	ret = pwm_mediatek_clk_enable(chip, pwm);
-
 	if (ret < 0)
 		return ret;
 
+	clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
+	if (!clk_rate)
+		return -EINVAL;
+
 	/* Make sure we use the bus clock and not the 26MHz clock */
 	if (pc->soc->has_ck_26m_sel)
 		writel(0, pc->regs + PWM_CK_26M_SEL);
 
 	/* Using resolution in picosecond gets accuracy higher */
 	resolution = (u64)NSEC_PER_SEC * 1000;
-	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
+	do_div(resolution, clk_rate);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
 	while (cnt_period > 8191) {
diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 2261789cc27d..578dbdd2d5a7 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -8,6 +8,7 @@
  * - The hardware cannot generate a 0% duty cycle.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -102,23 +103,24 @@ static void rcar_pwm_set_clock_control(struct rcar_pwm_chip *rp,
 	rcar_pwm_write(rp, value, RCAR_PWMCR);
 }
 
-static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
-				int period_ns)
+static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, u64 duty_ns,
+				u64 period_ns)
 {
-	unsigned long long one_cycle, tmp;	/* 0.01 nanoseconds */
+	unsigned long long tmp;
 	unsigned long clk_rate = clk_get_rate(rp->clk);
 	u32 cyc, ph;
 
-	one_cycle = NSEC_PER_SEC * 100ULL << div;
-	do_div(one_cycle, clk_rate);
+	/* div <= 24 == RCAR_PWM_MAX_DIVISION, so the shift doesn't overflow. */
+	tmp = mul_u64_u64_div_u64(period_ns, clk_rate, (u64)NSEC_PER_SEC << div);
+	if (tmp > FIELD_MAX(RCAR_PWMCNT_CYC0_MASK))
+		tmp = FIELD_MAX(RCAR_PWMCNT_CYC0_MASK);
 
-	tmp = period_ns * 100ULL;
-	do_div(tmp, one_cycle);
-	cyc = (tmp << RCAR_PWMCNT_CYC0_SHIFT) & RCAR_PWMCNT_CYC0_MASK;
+	cyc = FIELD_PREP(RCAR_PWMCNT_CYC0_MASK, tmp);
 
-	tmp = duty_ns * 100ULL;
-	do_div(tmp, one_cycle);
-	ph = tmp & RCAR_PWMCNT_PH0_MASK;
+	tmp = mul_u64_u64_div_u64(duty_ns, clk_rate, (u64)NSEC_PER_SEC << div);
+	if (tmp > FIELD_MAX(RCAR_PWMCNT_PH0_MASK))
+		tmp = FIELD_MAX(RCAR_PWMCNT_PH0_MASK);
+	ph = FIELD_PREP(RCAR_PWMCNT_PH0_MASK, tmp);
 
 	/* Avoid prohibited setting */
 	if (cyc == 0 || ph == 0)
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 21fa7ac849e5..4904b831c0a7 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -302,11 +302,17 @@ static struct airq_info *new_airq_info(int index)
 static unsigned long *get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 					 u64 *first, void **airq_info)
 {
-	int i, j;
+	int i, j, queue_idx, highest_queue_idx = -1;
 	struct airq_info *info;
 	unsigned long *indicator_addr = NULL;
 	unsigned long bit, flags;
 
+	/* Array entries without an actual queue pointer must be ignored. */
+	for (i = 0; i < nvqs; i++) {
+		if (vqs[i])
+			highest_queue_idx++;
+	}
+
 	for (i = 0; i < MAX_AIRQ_AREAS && !indicator_addr; i++) {
 		mutex_lock(&airq_areas_lock);
 		if (!airq_areas[i])
@@ -316,7 +322,7 @@ static unsigned long *get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 		if (!info)
 			return NULL;
 		write_lock_irqsave(&info->lock, flags);
-		bit = airq_iv_alloc(info->aiv, nvqs);
+		bit = airq_iv_alloc(info->aiv, highest_queue_idx + 1);
 		if (bit == -1UL) {
 			/* Not enough vacancies. */
 			write_unlock_irqrestore(&info->lock, flags);
@@ -325,8 +331,10 @@ static unsigned long *get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 		*first = bit;
 		*airq_info = info;
 		indicator_addr = info->aiv->vector;
-		for (j = 0; j < nvqs; j++) {
-			airq_iv_set_ptr(info->aiv, bit + j,
+		for (j = 0, queue_idx = 0; j < nvqs; j++) {
+			if (!vqs[j])
+				continue;
+			airq_iv_set_ptr(info->aiv, bit + queue_idx++,
 					(unsigned long)vqs[j]);
 		}
 		write_unlock_irqrestore(&info->lock, flags);
diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 1e715fd65a7d..ee5a75a4b3bb 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -81,13 +81,14 @@ extern atomic64_t event_counter;
 
 /* Admin queue management definitions */
 #define MPI3MR_ADMIN_REQ_Q_SIZE		(2 * MPI3MR_PAGE_SIZE_4K)
-#define MPI3MR_ADMIN_REPLY_Q_SIZE	(4 * MPI3MR_PAGE_SIZE_4K)
+#define MPI3MR_ADMIN_REPLY_Q_SIZE	(8 * MPI3MR_PAGE_SIZE_4K)
 #define MPI3MR_ADMIN_REQ_FRAME_SZ	128
 #define MPI3MR_ADMIN_REPLY_FRAME_SZ	16
 
 /* Operational queue management definitions */
 #define MPI3MR_OP_REQ_Q_QD		512
 #define MPI3MR_OP_REP_Q_QD		1024
+#define MPI3MR_OP_REP_Q_QD2K		2048
 #define MPI3MR_OP_REP_Q_QD4K		4096
 #define MPI3MR_OP_REQ_Q_SEG_SIZE	4096
 #define MPI3MR_OP_REP_Q_SEG_SIZE	4096
@@ -329,6 +330,7 @@ enum mpi3mr_reset_reason {
 #define MPI3MR_RESET_REASON_OSTYPE_SHIFT	28
 #define MPI3MR_RESET_REASON_IOCNUM_SHIFT	20
 
+
 /* Queue type definitions */
 enum queue_type {
 	MPI3MR_DEFAULT_QUEUE = 0,
@@ -388,6 +390,7 @@ struct mpi3mr_ioc_facts {
 	u16 max_msix_vectors;
 	u8 personality;
 	u8 dma_mask;
+	bool max_req_limit;
 	u8 protocol_flags;
 	u8 sge_mod_mask;
 	u8 sge_mod_value;
@@ -457,6 +460,8 @@ struct op_req_qinfo {
  * @enable_irq_poll: Flag to indicate polling is enabled
  * @in_use: Queue is handled by poll/ISR
  * @qtype: Type of queue (types defined in enum queue_type)
+ * @qfull_watermark: Watermark defined in reply queue to avoid
+ *                    reply queue full
  */
 struct op_reply_qinfo {
 	u16 ci;
@@ -472,6 +477,7 @@ struct op_reply_qinfo {
 	bool enable_irq_poll;
 	atomic_t in_use;
 	enum queue_type qtype;
+	u16 qfull_watermark;
 };
 
 /**
@@ -1091,6 +1097,7 @@ struct scmd_priv {
  * @ts_update_interval: Timestamp update interval
  * @reset_in_progress: Reset in progress flag
  * @unrecoverable: Controller unrecoverable flag
+ * @io_admin_reset_sync: Manage state of I/O ops during an admin reset process
  * @prev_reset_result: Result of previous reset
  * @reset_mutex: Controller reset mutex
  * @reset_waitq: Controller reset  wait queue
@@ -1154,6 +1161,8 @@ struct scmd_priv {
  * @snapdump_trigger_active: Snapdump trigger active flag
  * @pci_err_recovery: PCI error recovery in progress
  * @block_on_pci_err: Block IO during PCI error recovery
+ * @reply_qfull_count: Occurences of reply queue full avoidance kicking-in
+ * @prevent_reply_qfull: Enable reply queue prevention
  */
 struct mpi3mr_ioc {
 	struct list_head list;
@@ -1277,6 +1286,7 @@ struct mpi3mr_ioc {
 	u16 ts_update_interval;
 	u8 reset_in_progress;
 	u8 unrecoverable;
+	u8 io_admin_reset_sync;
 	int prev_reset_result;
 	struct mutex reset_mutex;
 	wait_queue_head_t reset_waitq;
@@ -1352,6 +1362,8 @@ struct mpi3mr_ioc {
 	bool fw_release_trigger_active;
 	bool pci_err_recovery;
 	bool block_on_pci_err;
+	atomic_t reply_qfull_count;
+	bool prevent_reply_qfull;
 };
 
 /**
diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 7589f48aebc8..1532436f0f3a 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -3060,6 +3060,29 @@ reply_queue_count_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(reply_queue_count);
 
+/**
+ * reply_qfull_count_show - Show reply qfull count
+ * @dev: class device
+ * @attr: Device attributes
+ * @buf: Buffer to copy
+ *
+ * Retrieves the current value of the reply_qfull_count from the mrioc structure and
+ * formats it as a string for display.
+ *
+ * Return: sysfs_emit() return
+ */
+static ssize_t
+reply_qfull_count_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct mpi3mr_ioc *mrioc = shost_priv(shost);
+
+	return sysfs_emit(buf, "%u\n", atomic_read(&mrioc->reply_qfull_count));
+}
+
+static DEVICE_ATTR_RO(reply_qfull_count);
+
 /**
  * logging_level_show - Show controller debug level
  * @dev: class device
@@ -3152,6 +3175,7 @@ static struct attribute *mpi3mr_host_attrs[] = {
 	&dev_attr_fw_queue_depth.attr,
 	&dev_attr_op_req_q_count.attr,
 	&dev_attr_reply_queue_count.attr,
+	&dev_attr_reply_qfull_count.attr,
 	&dev_attr_logging_level.attr,
 	&dev_attr_adp_state.attr,
 	NULL,
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 5ed31fe57474..ec5b1ab28717 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -17,7 +17,7 @@ static void mpi3mr_process_factsdata(struct mpi3mr_ioc *mrioc,
 	struct mpi3_ioc_facts_data *facts_data);
 static void mpi3mr_pel_wait_complete(struct mpi3mr_ioc *mrioc,
 	struct mpi3mr_drv_cmd *drv_cmd);
-
+static int mpi3mr_check_op_admin_proc(struct mpi3mr_ioc *mrioc);
 static int poll_queues;
 module_param(poll_queues, int, 0444);
 MODULE_PARM_DESC(poll_queues, "Number of queues for io_uring poll mode. (Range 1 - 126)");
@@ -459,7 +459,7 @@ int mpi3mr_process_admin_reply_q(struct mpi3mr_ioc *mrioc)
 	}
 
 	do {
-		if (mrioc->unrecoverable)
+		if (mrioc->unrecoverable || mrioc->io_admin_reset_sync)
 			break;
 
 		mrioc->admin_req_ci = le16_to_cpu(reply_desc->request_queue_ci);
@@ -554,7 +554,7 @@ int mpi3mr_process_op_reply_q(struct mpi3mr_ioc *mrioc,
 	}
 
 	do {
-		if (mrioc->unrecoverable)
+		if (mrioc->unrecoverable || mrioc->io_admin_reset_sync)
 			break;
 
 		req_q_idx = le16_to_cpu(reply_desc->request_queue_id) - 1;
@@ -2104,15 +2104,22 @@ static int mpi3mr_create_op_reply_q(struct mpi3mr_ioc *mrioc, u16 qidx)
 	}
 
 	reply_qid = qidx + 1;
-	op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD;
-	if ((mrioc->pdev->device == MPI3_MFGPAGE_DEVID_SAS4116) &&
-		!mrioc->pdev->revision)
-		op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD4K;
+
+	if (mrioc->pdev->device == MPI3_MFGPAGE_DEVID_SAS4116) {
+		if (mrioc->pdev->revision)
+			op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD;
+		else
+			op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD4K;
+	} else
+		op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD2K;
+
 	op_reply_q->ci = 0;
 	op_reply_q->ephase = 1;
 	atomic_set(&op_reply_q->pend_ios, 0);
 	atomic_set(&op_reply_q->in_use, 0);
 	op_reply_q->enable_irq_poll = false;
+	op_reply_q->qfull_watermark =
+		op_reply_q->num_replies - (MPI3MR_THRESHOLD_REPLY_COUNT * 2);
 
 	if (!op_reply_q->q_segments) {
 		retval = mpi3mr_alloc_op_reply_q_segments(mrioc, qidx);
@@ -2416,8 +2423,10 @@ int mpi3mr_op_request_post(struct mpi3mr_ioc *mrioc,
 	void *segment_base_addr;
 	u16 req_sz = mrioc->facts.op_req_sz;
 	struct segments *segments = op_req_q->q_segments;
+	struct op_reply_qinfo *op_reply_q = NULL;
 
 	reply_qidx = op_req_q->reply_qid - 1;
+	op_reply_q = mrioc->op_reply_qinfo + reply_qidx;
 
 	if (mrioc->unrecoverable)
 		return -EFAULT;
@@ -2448,6 +2457,15 @@ int mpi3mr_op_request_post(struct mpi3mr_ioc *mrioc,
 		goto out;
 	}
 
+	/* Reply queue is nearing to get full, push back IOs to SML */
+	if ((mrioc->prevent_reply_qfull == true) &&
+		(atomic_read(&op_reply_q->pend_ios) >
+	     (op_reply_q->qfull_watermark))) {
+		atomic_inc(&mrioc->reply_qfull_count);
+		retval = -EAGAIN;
+		goto out;
+	}
+
 	segment_base_addr = segments[pi / op_req_q->segment_qd].segment;
 	req_entry = (u8 *)segment_base_addr +
 	    ((pi % op_req_q->segment_qd) * req_sz);
@@ -3091,6 +3109,9 @@ static void mpi3mr_process_factsdata(struct mpi3mr_ioc *mrioc,
 	mrioc->facts.dma_mask = (facts_flags &
 	    MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_MASK) >>
 	    MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_SHIFT;
+	mrioc->facts.dma_mask = (facts_flags &
+	    MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_MASK) >>
+	    MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_SHIFT;
 	mrioc->facts.protocol_flags = facts_data->protocol_flags;
 	mrioc->facts.mpi_version = le32_to_cpu(facts_data->mpi_version.word);
 	mrioc->facts.max_reqs = le16_to_cpu(facts_data->max_outstanding_requests);
@@ -4214,6 +4235,9 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
 		mrioc->shost->transportt = mpi3mr_transport_template;
 	}
 
+	if (mrioc->facts.max_req_limit)
+		mrioc->prevent_reply_qfull = true;
+
 	mrioc->reply_sz = mrioc->facts.reply_sz;
 
 	retval = mpi3mr_check_reset_dma_mask(mrioc);
@@ -4370,6 +4394,7 @@ int mpi3mr_reinit_ioc(struct mpi3mr_ioc *mrioc, u8 is_resume)
 		goto out_failed_noretry;
 	}
 
+	mrioc->io_admin_reset_sync = 0;
 	if (is_resume || mrioc->block_on_pci_err) {
 		dprint_reset(mrioc, "setting up single ISR\n");
 		retval = mpi3mr_setup_isr(mrioc, 1);
@@ -5228,6 +5253,55 @@ void mpi3mr_pel_get_seqnum_complete(struct mpi3mr_ioc *mrioc,
 	drv_cmd->retry_count = 0;
 }
 
+/**
+ * mpi3mr_check_op_admin_proc -
+ * @mrioc: Adapter instance reference
+ *
+ * Check if any of the operation reply queues
+ * or the admin reply queue are currently in use.
+ * If any queue is in use, this function waits for
+ * a maximum of 10 seconds for them to become available.
+ *
+ * Return: 0 on success, non-zero on failure.
+ */
+static int mpi3mr_check_op_admin_proc(struct mpi3mr_ioc *mrioc)
+{
+
+	u16 timeout = 10 * 10;
+	u16 elapsed_time = 0;
+	bool op_admin_in_use = false;
+
+	do {
+		op_admin_in_use = false;
+
+		/* Check admin_reply queue first to exit early */
+		if (atomic_read(&mrioc->admin_reply_q_in_use) == 1)
+			op_admin_in_use = true;
+		else {
+			/* Check op_reply queues */
+			int i;
+
+			for (i = 0; i < mrioc->num_queues; i++) {
+				if (atomic_read(&mrioc->op_reply_qinfo[i].in_use) == 1) {
+					op_admin_in_use = true;
+					break;
+				}
+			}
+		}
+
+		if (!op_admin_in_use)
+			break;
+
+		msleep(100);
+
+	} while (++elapsed_time < timeout);
+
+	if (op_admin_in_use)
+		return 1;
+
+	return 0;
+}
+
 /**
  * mpi3mr_soft_reset_handler - Reset the controller
  * @mrioc: Adapter instance reference
@@ -5308,6 +5382,7 @@ int mpi3mr_soft_reset_handler(struct mpi3mr_ioc *mrioc,
 	mpi3mr_wait_for_host_io(mrioc, MPI3MR_RESET_HOST_IOWAIT_TIMEOUT);
 
 	mpi3mr_ioc_disable_intr(mrioc);
+	mrioc->io_admin_reset_sync = 1;
 
 	if (snapdump) {
 		mpi3mr_set_diagsave(mrioc);
@@ -5335,6 +5410,16 @@ int mpi3mr_soft_reset_handler(struct mpi3mr_ioc *mrioc,
 		ioc_err(mrioc, "Failed to issue soft reset to the ioc\n");
 		goto out;
 	}
+
+	retval = mpi3mr_check_op_admin_proc(mrioc);
+	if (retval) {
+		ioc_err(mrioc, "Soft reset failed due to an Admin or I/O queue polling\n"
+				"thread still processing replies even after a 10 second\n"
+				"timeout. Marking the controller as unrecoverable!\n");
+
+		goto out;
+	}
+
 	if (mrioc->num_io_throttle_group !=
 	    mrioc->facts.max_io_throttle_group) {
 		ioc_err(mrioc,
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 0dc37fc6f236..a17441635ff3 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4119,7 +4119,7 @@ static void validate_options(void)
  */
 static int __init st_setup(char *str)
 {
-	int i, len, ints[5];
+	int i, len, ints[ARRAY_SIZE(parms) + 1];
 	char *stp;
 
 	stp = get_options(str, ARRAY_SIZE(ints), ints);
diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index b1118d37779e..bba8d86ae1bb 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -131,6 +131,8 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 
 	soc_dev_attr->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 						"%x", soc_info.revision);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
 	soc_dev_attr->soc_id = product_id_to_soc_id(soc_info.product_id);
 	if (!soc_dev_attr->soc_id) {
 		pr_err("Unknown SoC\n");
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 73b1edd0531b..f9463f263fba 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1634,6 +1634,12 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 		int ret = PTR_ERR(cqspi->rx_chan);
 
 		cqspi->rx_chan = NULL;
+		if (ret == -ENODEV) {
+			/* DMA support is not mandatory */
+			dev_info(&cqspi->pdev->dev, "No Rx DMA available\n");
+			return 0;
+		}
+
 		return dev_err_probe(&cqspi->pdev->dev, ret, "No Rx DMA available\n");
 	}
 	init_completion(&cqspi->rx_dma_complete);
diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
index ea14a3835681..61c065702350 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -2243,7 +2243,7 @@ spc_emulate_report_supp_op_codes(struct se_cmd *cmd)
 			response_length += spc_rsoc_encode_command_descriptor(
 					&buf[response_length], rctd, descr);
 		}
-		put_unaligned_be32(response_length - 3, buf);
+		put_unaligned_be32(response_length - 4, buf);
 	} else {
 		response_length = spc_rsoc_encode_one_command_descriptor(
 				&buf[response_length], rctd, descr,
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 1997e91bb3be..4b3225377e8f 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -65,7 +65,7 @@
 #define LVTS_HW_FILTER				0x0
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
-#define LVTS_MONINT_CONF			0x8300318C
+#define LVTS_MONINT_CONF			0x0300318C
 
 #define LVTS_MONINT_OFFSET_SENSOR0		0xC
 #define LVTS_MONINT_OFFSET_SENSOR1		0x180
@@ -91,8 +91,6 @@
 #define LVTS_MSR_READ_TIMEOUT_US	400
 #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
 
-#define LVTS_HW_TSHUT_TEMP		105000
-
 #define LVTS_MINIMUM_THRESHOLD		20000
 
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
@@ -145,7 +143,6 @@ struct lvts_ctrl {
 	struct lvts_sensor sensors[LVTS_SENSOR_MAX];
 	const struct lvts_data *lvts_data;
 	u32 calibration[LVTS_SENSOR_MAX];
-	u32 hw_tshut_raw_temp;
 	u8 valid_sensor_mask;
 	int mode;
 	void __iomem *base;
@@ -837,14 +834,6 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 		 */
 		lvts_ctrl[i].mode = lvts_data->lvts_ctrl[i].mode;
 
-		/*
-		 * The temperature to raw temperature must be done
-		 * after initializing the calibration.
-		 */
-		lvts_ctrl[i].hw_tshut_raw_temp =
-			lvts_temp_to_raw(LVTS_HW_TSHUT_TEMP,
-					 lvts_data->temp_factor);
-
 		lvts_ctrl[i].low_thresh = INT_MIN;
 		lvts_ctrl[i].high_thresh = INT_MIN;
 	}
@@ -860,6 +849,32 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 	return 0;
 }
 
+static void lvts_ctrl_monitor_enable(struct device *dev, struct lvts_ctrl *lvts_ctrl, bool enable)
+{
+	/*
+	 * Bitmaps to enable each sensor on filtered mode in the MONCTL0
+	 * register.
+	 */
+	static const u8 sensor_filt_bitmap[] = { BIT(0), BIT(1), BIT(2), BIT(3) };
+	u32 sensor_map = 0;
+	int i;
+
+	if (lvts_ctrl->mode != LVTS_MSR_FILTERED_MODE)
+		return;
+
+	if (enable) {
+		lvts_for_each_valid_sensor(i, lvts_ctrl)
+			sensor_map |= sensor_filt_bitmap[i];
+	}
+
+	/*
+	 * Bits:
+	 *      9: Single point access flow
+	 *    0-3: Enable sensing point 0-3
+	 */
+	writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
+}
+
 /*
  * At this point the configuration register is the only place in the
  * driver where we write multiple values. Per hardware constraint,
@@ -893,7 +908,6 @@ static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
 	 *         10 : Selected sensor with bits 19-18
 	 *         11 : Reserved
 	 */
-	writel(BIT(16), LVTS_PROTCTL(lvts_ctrl->base));
 
 	/*
 	 * LVTS_PROTTA : Stage 1 temperature threshold
@@ -906,8 +920,8 @@ static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
 	 *
 	 * writel(0x0, LVTS_PROTTA(lvts_ctrl->base));
 	 * writel(0x0, LVTS_PROTTB(lvts_ctrl->base));
+	 * writel(0x0, LVTS_PROTTC(lvts_ctrl->base));
 	 */
-	writel(lvts_ctrl->hw_tshut_raw_temp, LVTS_PROTTC(lvts_ctrl->base));
 
 	/*
 	 * LVTS_MONINT : Interrupt configuration register
@@ -1381,8 +1395,11 @@ static int lvts_suspend(struct device *dev)
 
 	lvts_td = dev_get_drvdata(dev);
 
-	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
+	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
+		lvts_ctrl_monitor_enable(dev, &lvts_td->lvts_ctrl[i], false);
+		usleep_range(100, 200);
 		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
+	}
 
 	clk_disable_unprepare(lvts_td->clk);
 
@@ -1400,8 +1417,11 @@ static int lvts_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
+	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
 		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], true);
+		usleep_range(100, 200);
+		lvts_ctrl_monitor_enable(dev, &lvts_td->lvts_ctrl[i], true);
+	}
 
 	return 0;
 }
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 086ed42dd16c..a84f48a752d1 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -386,6 +386,7 @@ static const struct tsadc_table rk3328_code_table[] = {
 	{296, -40000},
 	{304, -35000},
 	{313, -30000},
+	{322, -25000},
 	{331, -20000},
 	{340, -15000},
 	{349, -10000},
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 8455f08f5d40..61424342c096 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -190,9 +190,12 @@ static void fill_indir(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mkey, v
 			klm->bcount = cpu_to_be32(klm_bcount(dmr->end - dmr->start));
 			preve = dmr->end;
 		} else {
+			u64 bcount = min_t(u64, dmr->start - preve, MAX_KLM_SIZE);
+
 			klm->key = cpu_to_be32(mvdev->res.null_mkey);
-			klm->bcount = cpu_to_be32(klm_bcount(dmr->start - preve));
-			preve = dmr->start;
+			klm->bcount = cpu_to_be32(klm_bcount(bcount));
+			preve += bcount;
+
 			goto again;
 		}
 	}
diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index c7aefcd6e4e3..782600601845 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -229,8 +229,11 @@ static void led_bl_remove(struct platform_device *pdev)
 	backlight_device_unregister(bl);
 
 	led_bl_power_off(priv);
-	for (i = 0; i < priv->nb_leds; i++)
+	for (i = 0; i < priv->nb_leds; i++) {
+		mutex_lock(&priv->leds[i]->led_access);
 		led_sysfs_enable(priv->leds[i]);
+		mutex_unlock(&priv->leds[i]->led_access);
+	}
 }
 
 static const struct of_device_id led_bl_of_match[] = {
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index 5832485ab998..c29b6236952b 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -2749,9 +2749,13 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		bool mem_to_mem)
 {
 	int r;
-	enum omap_overlay_caps caps = dss_feat_get_overlay_caps(plane);
+	enum omap_overlay_caps caps;
 	enum omap_channel channel;
 
+	if (plane == OMAP_DSS_WB)
+		return -EINVAL;
+
+	caps = dss_feat_get_overlay_caps(plane);
 	channel = dispc_ovl_get_channel_out(plane);
 
 	DSSDBG("dispc_ovl_setup %d, pa %pad, pa_uv %pad, sw %d, %d,%d, %dx%d ->"
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 528395133b4f..4bd31242bd77 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -675,7 +675,7 @@ void xen_free_ballooned_pages(unsigned int nr_pages, struct page **pages)
 }
 EXPORT_SYMBOL(xen_free_ballooned_pages);
 
-static void __init balloon_add_regions(void)
+static int __init balloon_add_regions(void)
 {
 	unsigned long start_pfn, pages;
 	unsigned long pfn, extra_pfn_end;
@@ -698,26 +698,38 @@ static void __init balloon_add_regions(void)
 		for (pfn = start_pfn; pfn < extra_pfn_end; pfn++)
 			balloon_append(pfn_to_page(pfn));
 
-		balloon_stats.total_pages += extra_pfn_end - start_pfn;
+		/*
+		 * Extra regions are accounted for in the physmap, but need
+		 * decreasing from current_pages to balloon down the initial
+		 * allocation, because they are already accounted for in
+		 * total_pages.
+		 */
+		if (extra_pfn_end - start_pfn >= balloon_stats.current_pages) {
+			WARN(1, "Extra pages underflow current target");
+			return -ERANGE;
+		}
+		balloon_stats.current_pages -= extra_pfn_end - start_pfn;
 	}
+
+	return 0;
 }
 
 static int __init balloon_init(void)
 {
 	struct task_struct *task;
+	int rc;
 
 	if (!xen_domain())
 		return -ENODEV;
 
 	pr_info("Initialising balloon driver\n");
 
-#ifdef CONFIG_XEN_PV
-	balloon_stats.current_pages = xen_pv_domain()
-		? min(xen_start_info->nr_pages - xen_released_pages, max_pfn)
-		: get_num_physpages();
-#else
-	balloon_stats.current_pages = get_num_physpages();
-#endif
+	if (xen_released_pages >= get_num_physpages()) {
+		WARN(1, "Released pages underflow current target");
+		return -ERANGE;
+	}
+
+	balloon_stats.current_pages = get_num_physpages() - xen_released_pages;
 	balloon_stats.target_pages  = balloon_stats.current_pages;
 	balloon_stats.balloon_low   = 0;
 	balloon_stats.balloon_high  = 0;
@@ -734,7 +746,9 @@ static int __init balloon_init(void)
 	register_sysctl_init("xen/balloon", balloon_table);
 #endif
 
-	balloon_add_regions();
+	rc = balloon_add_regions();
+	if (rc)
+		return rc;
 
 	task = kthread_run(balloon_thread, NULL, "xen-balloon");
 	if (IS_ERR(task)) {
diff --git a/drivers/xen/xenfs/xensyms.c b/drivers/xen/xenfs/xensyms.c
index b799bc759c15..088b7f02c358 100644
--- a/drivers/xen/xenfs/xensyms.c
+++ b/drivers/xen/xenfs/xensyms.c
@@ -48,7 +48,7 @@ static int xensyms_next_sym(struct xensyms *xs)
 			return -ENOMEM;
 
 		set_xen_guest_handle(symdata->name, xs->name);
-		symdata->symnum--; /* Rewind */
+		symdata->symnum = symnum; /* Rewind */
 
 		ret = HYPERVISOR_platform_op(&xs->op);
 		if (ret < 0)
@@ -78,7 +78,7 @@ static void *xensyms_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	struct xensyms *xs = m->private;
 
-	xs->op.u.symdata.symnum = ++(*pos);
+	*pos = xs->op.u.symdata.symnum;
 
 	if (xensyms_next_sym(xs))
 		return NULL;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 563f106774e5..19e5f8eaae77 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4274,6 +4274,18 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 */
 	btrfs_flush_workqueue(fs_info->delalloc_workers);
 
+	/*
+	 * When finishing a compressed write bio we schedule a work queue item
+	 * to finish an ordered extent - btrfs_finish_compressed_write_work()
+	 * calls btrfs_finish_ordered_extent() which in turns does a call to
+	 * btrfs_queue_ordered_fn(), and that queues the ordered extent
+	 * completion either in the endio_write_workers work queue or in the
+	 * fs_info->endio_freespace_worker work queue. We flush those queues
+	 * below, so before we flush them we must flush this queue for the
+	 * workers of compressed writes.
+	 */
+	flush_workqueue(fs_info->compressed_write_workers);
+
 	/*
 	 * After we parked the cleaner kthread, ordered extents may have
 	 * completed and created new delayed iputs. If one of the async reclaim
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f3e93ba7ec97..4ceffbef3298 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2897,7 +2897,15 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 						   block_group->length,
 						   &trimmed);
 
+		/*
+		 * Not strictly necessary to lock, as the block_group should be
+		 * read-only from btrfs_delete_unused_bgs().
+		 */
+		ASSERT(block_group->ro);
+		spin_lock(&fs_info->unused_bgs_lock);
 		list_del_init(&block_group->bg_list);
+		spin_unlock(&fs_info->unused_bgs_lock);
+
 		btrfs_unfreeze_block_group(block_group);
 		btrfs_put_block_group(block_group);
 
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 56e61ac1cc64..609bb6c9c087 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -1045,6 +1045,7 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 	ret = btrfs_add_chunk_map(fs_info, map);
 	if (ret) {
 		test_err("error adding chunk map to mapping tree");
+		btrfs_free_chunk_map(map);
 		goto out_free;
 	}
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 82dd9ee89fbc..24806e19c7c4 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -161,7 +161,13 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
 			cache = list_first_entry(&transaction->deleted_bgs,
 						 struct btrfs_block_group,
 						 bg_list);
+			/*
+			 * Not strictly necessary to lock, as no other task will be using a
+			 * block_group on the deleted_bgs list during a transaction abort.
+			 */
+			spin_lock(&transaction->fs_info->unused_bgs_lock);
 			list_del_init(&cache->bg_list);
+			spin_unlock(&transaction->fs_info->unused_bgs_lock);
 			btrfs_unfreeze_block_group(cache);
 			btrfs_put_block_group(cache);
 		}
@@ -2099,7 +2105,13 @@ static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handle *trans)
 
        list_for_each_entry_safe(block_group, tmp, &trans->new_bgs, bg_list) {
                btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
+		/*
+		* Not strictly necessary to lock, as no other task will be using a
+		* block_group on the new_bgs list during a transaction abort.
+		*/
+	       spin_lock(&fs_info->unused_bgs_lock);
                list_del_init(&block_group->bg_list);
+	       spin_unlock(&fs_info->unused_bgs_lock);
        }
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 69d03feea4e0..2bb7e32ad945 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2107,6 +2107,9 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		physical = map->stripes[i].physical;
 		zinfo = device->zone_info;
 
+		if (!device->bdev)
+			continue;
+
 		if (zinfo->max_active_zones == 0)
 			continue;
 
@@ -2268,6 +2271,9 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		struct btrfs_zoned_device_info *zinfo = device->zone_info;
 		unsigned int nofs_flags;
 
+		if (!device->bdev)
+			continue;
+
 		if (zinfo->max_active_zones == 0)
 			continue;
 
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 0c01e4423ee2..0ad496ceb638 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -741,6 +741,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 	read_lock_bh(&ls->ls_rsbtbl_lock);
 	if (!rsb_flag(r, RSB_HASHED)) {
 		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -EBADR;
 		goto do_new;
 	}
 	
@@ -784,6 +785,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		}
 	} else {
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -EBADR;
 		goto do_new;
 	}
 
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 33f8539dda4a..17aed5f6c549 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -32,6 +32,8 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 		ret = 0;
 	}
 	if (rq->bio.bi_end_io) {
+		if (ret < 0 && !rq->bio.bi_status)
+			rq->bio.bi_status = errno_to_blk_status(ret);
 		rq->bio.bi_end_io(&rq->bio);
 	} else {
 		bio_for_each_folio_all(fi, &rq->bio) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 67a5b937f5a9..ffa6aa55a1a7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4681,22 +4681,43 @@ static inline void ext4_inode_set_iversion_queried(struct inode *inode, u64 val)
 		inode_set_iversion_queried(inode, val);
 }
 
-static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
-
+static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
+			    const char *function, unsigned int line)
 {
+	const char *err_str;
+
 	if (flags & EXT4_IGET_EA_INODE) {
-		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
-			return "missing EA_INODE flag";
+		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+			err_str = "missing EA_INODE flag";
+			goto error;
+		}
 		if (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
-		    EXT4_I(inode)->i_file_acl)
-			return "ea_inode with extended attributes";
+		    EXT4_I(inode)->i_file_acl) {
+			err_str = "ea_inode with extended attributes";
+			goto error;
+		}
 	} else {
-		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
-			return "unexpected EA_INODE flag";
+		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+			/*
+			 * open_by_handle_at() could provide an old inode number
+			 * that has since been reused for an ea_inode; this does
+			 * not indicate filesystem corruption
+			 */
+			if (flags & EXT4_IGET_HANDLE)
+				return -ESTALE;
+			err_str = "unexpected EA_INODE flag";
+			goto error;
+		}
+	}
+	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD)) {
+		err_str = "unexpected bad inode w/o EXT4_IGET_BAD";
+		goto error;
 	}
-	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD))
-		return "unexpected bad inode w/o EXT4_IGET_BAD";
-	return NULL;
+	return 0;
+
+error:
+	ext4_error_inode(inode, function, line, 0, err_str);
+	return -EFSCORRUPTED;
 }
 
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
@@ -4708,7 +4729,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	struct ext4_inode_info *ei;
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct inode *inode;
-	const char *err_str;
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 	long ret;
 	loff_t size;
@@ -4737,10 +4757,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW)) {
-		if ((err_str = check_igot_inode(inode, flags)) != NULL) {
-			ext4_error_inode(inode, function, line, 0, err_str);
+		ret = check_igot_inode(inode, flags, function, line);
+		if (ret) {
 			iput(inode);
-			return ERR_PTR(-EFSCORRUPTED);
+			return ERR_PTR(ret);
 		}
 		return inode;
 	}
@@ -5012,13 +5032,21 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
-	if ((err_str = check_igot_inode(inode, flags)) != NULL) {
-		ext4_error_inode(inode, function, line, 0, err_str);
-		ret = -EFSCORRUPTED;
-		goto bad_inode;
+	ret = check_igot_inode(inode, flags, function, line);
+	/*
+	 * -ESTALE here means there is nothing inherently wrong with the inode,
+	 * it's just not an inode we can return for an fhandle lookup.
+	 */
+	if (ret == -ESTALE) {
+		brelse(iloc.bh);
+		unlock_new_inode(inode);
+		iput(inode);
+		return ERR_PTR(-ESTALE);
 	}
-
+	if (ret)
+		goto bad_inode;
 	brelse(iloc.bh);
+
 	unlock_new_inode(inode);
 	return inode;
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 790db7eac6c2..286f8fcb74cc 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1995,7 +1995,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	 * split it in half by count; each resulting block will have at least
 	 * half the space free.
 	 */
-	if (i > 0)
+	if (i >= 0)
 		split = count - move;
 	else
 		split = count/2;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d3795c6c0a9d..4291ab3c20be 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6906,12 +6906,25 @@ static int ext4_release_dquot(struct dquot *dquot)
 {
 	int ret, err;
 	handle_t *handle;
+	bool freeze_protected = false;
+
+	/*
+	 * Trying to sb_start_intwrite() in a running transaction
+	 * can result in a deadlock. Further, running transactions
+	 * are already protected from freezing.
+	 */
+	if (!ext4_journal_current_handle()) {
+		sb_start_intwrite(dquot->dq_sb);
+		freeze_protected = true;
+	}
 
 	handle = ext4_journal_start(dquot_to_inode(dquot), EXT4_HT_QUOTA,
 				    EXT4_QUOTA_DEL_BLOCKS(dquot->dq_sb));
 	if (IS_ERR(handle)) {
 		/* Release dquot anyway to avoid endless cycle in dqput() */
 		dquot_release(dquot);
+		if (freeze_protected)
+			sb_end_intwrite(dquot->dq_sb);
 		return PTR_ERR(handle);
 	}
 	ret = dquot_release(dquot);
@@ -6922,6 +6935,10 @@ static int ext4_release_dquot(struct dquot *dquot)
 	err = ext4_journal_stop(handle);
 	if (!ret)
 		ret = err;
+
+	if (freeze_protected)
+		sb_end_intwrite(dquot->dq_sb);
+
 	return ret;
 }
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7647e9f6e190..6ff94cdf1515 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1176,15 +1176,24 @@ ext4_xattr_inode_dec_ref_all(handle_t *handle, struct inode *parent,
 {
 	struct inode *ea_inode;
 	struct ext4_xattr_entry *entry;
+	struct ext4_iloc iloc;
 	bool dirty = false;
 	unsigned int ea_ino;
 	int err;
 	int credits;
+	void *end;
+
+	if (block_csum)
+		end = (void *)bh->b_data + bh->b_size;
+	else {
+		ext4_get_inode_loc(parent, &iloc);
+		end = (void *)ext4_raw_inode(&iloc) + EXT4_SB(parent->i_sb)->s_inode_size;
+	}
 
 	/* One credit for dec ref on ea_inode, one for orphan list addition, */
 	credits = 2 + extra_credits;
 
-	for (entry = first; !IS_LAST_ENTRY(entry);
+	for (entry = first; (void *)entry < end && !IS_LAST_ENTRY(entry);
 	     entry = EXT4_XATTR_NEXT(entry)) {
 		if (!entry->e_value_inum)
 			continue;
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index efda9a022981..86228f82f54d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1344,21 +1344,13 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	unsigned long flags;
 
-	if (cpc->reason & CP_UMOUNT) {
-		if (le32_to_cpu(ckpt->cp_pack_total_block_count) +
-			NM_I(sbi)->nat_bits_blocks > BLKS_PER_SEG(sbi)) {
-			clear_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
-			f2fs_notice(sbi, "Disable nat_bits due to no space");
-		} else if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG) &&
-						f2fs_nat_bitmap_enabled(sbi)) {
-			f2fs_enable_nat_bits(sbi);
-			set_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
-			f2fs_notice(sbi, "Rebuild and enable nat_bits");
-		}
-	}
-
 	spin_lock_irqsave(&sbi->cp_lock, flags);
 
+	if ((cpc->reason & CP_UMOUNT) &&
+			le32_to_cpu(ckpt->cp_pack_total_block_count) >
+			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks)
+		disable_nat_bits(sbi, false);
+
 	if (cpc->reason & CP_TRIMMED)
 		__set_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
 	else
@@ -1541,8 +1533,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	start_blk = __start_cp_next_addr(sbi);
 
 	/* write nat bits */
-	if ((cpc->reason & CP_UMOUNT) &&
-			is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG)) {
+	if (enabled_nat_bits(sbi, cpc)) {
 		__u64 cp_ver = cur_cp_version(ckpt);
 		block_t blk;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b52df8aa9535..1c783c2e4902 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2231,6 +2231,36 @@ static inline void f2fs_up_write(struct f2fs_rwsem *sem)
 #endif
 }
 
+static inline void disable_nat_bits(struct f2fs_sb_info *sbi, bool lock)
+{
+	unsigned long flags;
+	unsigned char *nat_bits;
+
+	/*
+	 * In order to re-enable nat_bits we need to call fsck.f2fs by
+	 * set_sbi_flag(sbi, SBI_NEED_FSCK). But it may give huge cost,
+	 * so let's rely on regular fsck or unclean shutdown.
+	 */
+
+	if (lock)
+		spin_lock_irqsave(&sbi->cp_lock, flags);
+	__clear_ckpt_flags(F2FS_CKPT(sbi), CP_NAT_BITS_FLAG);
+	nat_bits = NM_I(sbi)->nat_bits;
+	NM_I(sbi)->nat_bits = NULL;
+	if (lock)
+		spin_unlock_irqrestore(&sbi->cp_lock, flags);
+
+	kvfree(nat_bits);
+}
+
+static inline bool enabled_nat_bits(struct f2fs_sb_info *sbi,
+					struct cp_control *cpc)
+{
+	bool set = is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
+
+	return (cpc) ? (cpc->reason & CP_UMOUNT) && set : set;
+}
+
 static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
 {
 	f2fs_down_read(&sbi->cp_rwsem);
@@ -3671,7 +3701,6 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);
 int f2fs_truncate_xattr_node(struct inode *inode);
 int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
 					unsigned int seq_id);
-bool f2fs_nat_bitmap_enabled(struct f2fs_sb_info *sbi);
 int f2fs_remove_inode_page(struct inode *inode);
 struct page *f2fs_new_inode_page(struct inode *inode);
 struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
@@ -3696,7 +3725,6 @@ int f2fs_recover_xattr_data(struct inode *inode, struct page *page);
 int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
 int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum);
-void f2fs_enable_nat_bits(struct f2fs_sb_info *sbi);
 int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 int f2fs_build_node_manager(struct f2fs_sb_info *sbi);
 void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 10780e37fc7b..a60db5e795a4 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -34,10 +34,8 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 	if (f2fs_inode_dirtied(inode, sync))
 		return;
 
-	if (f2fs_is_atomic_file(inode)) {
-		set_inode_flag(inode, FI_ATOMIC_DIRTIED);
+	if (f2fs_is_atomic_file(inode))
 		return;
-	}
 
 	mark_inode_dirty_sync(inode);
 }
@@ -751,8 +749,12 @@ void f2fs_update_inode_page(struct inode *inode)
 		if (err == -ENOENT)
 			return;
 
+		if (err == -EFSCORRUPTED)
+			goto stop_checkpoint;
+
 		if (err == -ENOMEM || ++count <= DEFAULT_RETRY_IO_COUNT)
 			goto retry;
+stop_checkpoint:
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_UPDATE_INODE);
 		return;
 	}
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4d7b9fd6ef31..12c76e3d1cd4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1134,7 +1134,14 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	trace_f2fs_truncate_inode_blocks_enter(inode, from);
 
 	level = get_node_path(inode, from, offset, noffset);
-	if (level < 0) {
+	if (level <= 0) {
+		if (!level) {
+			level = -EFSCORRUPTED;
+			f2fs_err(sbi, "%s: inode ino=%lx has corrupted node block, from:%lu addrs:%u",
+					__func__, inode->i_ino,
+					from, ADDRS_PER_INODE(inode));
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+		}
 		trace_f2fs_truncate_inode_blocks_exit(inode, level);
 		return level;
 	}
@@ -2270,24 +2277,6 @@ static void __move_free_nid(struct f2fs_sb_info *sbi, struct free_nid *i,
 	}
 }
 
-bool f2fs_nat_bitmap_enabled(struct f2fs_sb_info *sbi)
-{
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	unsigned int i;
-	bool ret = true;
-
-	f2fs_down_read(&nm_i->nat_tree_lock);
-	for (i = 0; i < nm_i->nat_blocks; i++) {
-		if (!test_bit_le(i, nm_i->nat_block_bitmap)) {
-			ret = false;
-			break;
-		}
-	}
-	f2fs_up_read(&nm_i->nat_tree_lock);
-
-	return ret;
-}
-
 static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
 							bool set, bool build)
 {
@@ -2966,23 +2955,7 @@ static void __adjust_nat_entry_set(struct nat_entry_set *nes,
 	list_add_tail(&nes->set_list, head);
 }
 
-static void __update_nat_bits(struct f2fs_nm_info *nm_i, unsigned int nat_ofs,
-							unsigned int valid)
-{
-	if (valid == 0) {
-		__set_bit_le(nat_ofs, nm_i->empty_nat_bits);
-		__clear_bit_le(nat_ofs, nm_i->full_nat_bits);
-		return;
-	}
-
-	__clear_bit_le(nat_ofs, nm_i->empty_nat_bits);
-	if (valid == NAT_ENTRY_PER_BLOCK)
-		__set_bit_le(nat_ofs, nm_i->full_nat_bits);
-	else
-		__clear_bit_le(nat_ofs, nm_i->full_nat_bits);
-}
-
-static void update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
+static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 						struct page *page)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
@@ -2991,7 +2964,7 @@ static void update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 	int valid = 0;
 	int i = 0;
 
-	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
+	if (!enabled_nat_bits(sbi, NULL))
 		return;
 
 	if (nat_index == 0) {
@@ -3002,36 +2975,17 @@ static void update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 		if (le32_to_cpu(nat_blk->entries[i].block_addr) != NULL_ADDR)
 			valid++;
 	}
-
-	__update_nat_bits(nm_i, nat_index, valid);
-}
-
-void f2fs_enable_nat_bits(struct f2fs_sb_info *sbi)
-{
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	unsigned int nat_ofs;
-
-	f2fs_down_read(&nm_i->nat_tree_lock);
-
-	for (nat_ofs = 0; nat_ofs < nm_i->nat_blocks; nat_ofs++) {
-		unsigned int valid = 0, nid_ofs = 0;
-
-		/* handle nid zero due to it should never be used */
-		if (unlikely(nat_ofs == 0)) {
-			valid = 1;
-			nid_ofs = 1;
-		}
-
-		for (; nid_ofs < NAT_ENTRY_PER_BLOCK; nid_ofs++) {
-			if (!test_bit_le(nid_ofs,
-					nm_i->free_nid_bitmap[nat_ofs]))
-				valid++;
-		}
-
-		__update_nat_bits(nm_i, nat_ofs, valid);
+	if (valid == 0) {
+		__set_bit_le(nat_index, nm_i->empty_nat_bits);
+		__clear_bit_le(nat_index, nm_i->full_nat_bits);
+		return;
 	}
 
-	f2fs_up_read(&nm_i->nat_tree_lock);
+	__clear_bit_le(nat_index, nm_i->empty_nat_bits);
+	if (valid == NAT_ENTRY_PER_BLOCK)
+		__set_bit_le(nat_index, nm_i->full_nat_bits);
+	else
+		__clear_bit_le(nat_index, nm_i->full_nat_bits);
 }
 
 static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
@@ -3050,7 +3004,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	 * #1, flush nat entries to journal in current hot data summary block.
 	 * #2, flush nat entries to nat page.
 	 */
-	if ((cpc->reason & CP_UMOUNT) ||
+	if (enabled_nat_bits(sbi, cpc) ||
 		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
 		to_journal = false;
 
@@ -3097,7 +3051,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	if (to_journal) {
 		up_write(&curseg->journal_rwsem);
 	} else {
-		update_nat_bits(sbi, start_nid, page);
+		__update_nat_bits(sbi, start_nid, page);
 		f2fs_put_page(page, 1);
 	}
 
@@ -3128,7 +3082,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * during unmount, let's flush nat_bits before checking
 	 * nat_cnt[DIRTY_NAT].
 	 */
-	if (cpc->reason & CP_UMOUNT) {
+	if (enabled_nat_bits(sbi, cpc)) {
 		f2fs_down_write(&nm_i->nat_tree_lock);
 		remove_nats_in_journal(sbi);
 		f2fs_up_write(&nm_i->nat_tree_lock);
@@ -3144,7 +3098,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * entries, remove all entries from journal and merge them
 	 * into nat entry set.
 	 */
-	if (cpc->reason & CP_UMOUNT ||
+	if (enabled_nat_bits(sbi, cpc) ||
 		!__has_cursum_space(journal,
 			nm_i->nat_cnt[DIRTY_NAT], NAT_JOURNAL))
 		remove_nats_in_journal(sbi);
@@ -3181,18 +3135,15 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 	__u64 cp_ver = cur_cp_version(ckpt);
 	block_t nat_bits_addr;
 
+	if (!enabled_nat_bits(sbi, NULL))
+		return 0;
+
 	nm_i->nat_bits_blocks = F2FS_BLK_ALIGN((nat_bits_bytes << 1) + 8);
 	nm_i->nat_bits = f2fs_kvzalloc(sbi,
 			F2FS_BLK_TO_BYTES(nm_i->nat_bits_blocks), GFP_KERNEL);
 	if (!nm_i->nat_bits)
 		return -ENOMEM;
 
-	nm_i->full_nat_bits = nm_i->nat_bits + 8;
-	nm_i->empty_nat_bits = nm_i->full_nat_bits + nat_bits_bytes;
-
-	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
-		return 0;
-
 	nat_bits_addr = __start_cp_addr(sbi) + BLKS_PER_SEG(sbi) -
 						nm_i->nat_bits_blocks;
 	for (i = 0; i < nm_i->nat_bits_blocks; i++) {
@@ -3209,12 +3160,13 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 
 	cp_ver |= (cur_cp_crc(ckpt) << 32);
 	if (cpu_to_le64(cp_ver) != *(__le64 *)nm_i->nat_bits) {
-		clear_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
-		f2fs_notice(sbi, "Disable nat_bits due to incorrect cp_ver (%llu, %llu)",
-			cp_ver, le64_to_cpu(*(__le64 *)nm_i->nat_bits));
+		disable_nat_bits(sbi, true);
 		return 0;
 	}
 
+	nm_i->full_nat_bits = nm_i->nat_bits + 8;
+	nm_i->empty_nat_bits = nm_i->full_nat_bits + nat_bits_bytes;
+
 	f2fs_notice(sbi, "Found nat_bits in checkpoint");
 	return 0;
 }
@@ -3225,7 +3177,7 @@ static inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
 	unsigned int i = 0;
 	nid_t nid, last_nid;
 
-	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
+	if (!enabled_nat_bits(sbi, NULL))
 		return;
 
 	for (i = 0; i < nm_i->nat_blocks; i++) {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a622056f27f3..573cc4725e2e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1515,6 +1515,10 @@ int f2fs_inode_dirtied(struct inode *inode, bool sync)
 		inc_page_count(sbi, F2FS_DIRTY_IMETA);
 	}
 	spin_unlock(&sbi->inode_lock[DIRTY_META]);
+
+	if (!ret && f2fs_is_atomic_file(inode))
+		set_inode_flag(inode, FI_ATOMIC_DIRTIED);
+
 	return ret;
 }
 
diff --git a/fs/file.c b/fs/file.c
index 4cb952541dd0..b6fb6d18ac3b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -367,17 +367,25 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	old_fds = old_fdt->fd;
 	new_fds = new_fdt->fd;
 
+	/*
+	 * We may be racing against fd allocation from other threads using this
+	 * files_struct, despite holding ->file_lock.
+	 *
+	 * alloc_fd() might have already claimed a slot, while fd_install()
+	 * did not populate it yet. Note the latter operates locklessly, so
+	 * the file can show up as we are walking the array below.
+	 *
+	 * At the same time we know no files will disappear as all other
+	 * operations take the lock.
+	 *
+	 * Instead of trying to placate userspace racing with itself, we
+	 * ref the file if we see it and mark the fd slot as unused otherwise.
+	 */
 	for (i = open_files; i != 0; i--) {
-		struct file *f = *old_fds++;
+		struct file *f = rcu_dereference_raw(*old_fds++);
 		if (f) {
 			get_file(f);
 		} else {
-			/*
-			 * The fd may be claimed in the fd bitmap but not yet
-			 * instantiated in the files array if a sibling thread
-			 * is partway through open().  So make sure that this
-			 * fd is available to the new process.
-			 */
 			__clear_open_fd(open_files - i, new_fdt);
 		}
 		rcu_assign_pointer(*new_fds++, f);
@@ -637,7 +645,7 @@ struct file *file_close_fd_locked(struct files_struct *files, unsigned fd)
 		return NULL;
 
 	fd = array_index_nospec(fd, fdt->max_fds);
-	file = fdt->fd[fd];
+	file = rcu_dereference_raw(fdt->fd[fd]);
 	if (file) {
 		rcu_assign_pointer(fdt->fd[fd], NULL);
 		__put_unused_fd(files, fd);
@@ -1219,7 +1227,7 @@ __releases(&files->file_lock)
 	 */
 	fdt = files_fdtable(files);
 	fd = array_index_nospec(fd, fdt->max_fds);
-	tofree = fdt->fd[fd];
+	tofree = rcu_dereference_raw(fdt->fd[fd]);
 	if (!tofree && fd_is_open(fd, fdt))
 		goto Ebusy;
 	get_file(file);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 97f487c3d8fc..c073f5fb9859 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1884,7 +1884,6 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 
 	/* Log is no longer empty */
 	write_lock(&journal->j_state_lock);
-	WARN_ON(!sb->s_sequence);
 	journal->j_flags &= ~JBD2_FLUSHED;
 	write_unlock(&journal->j_state_lock);
 
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index f9009e4f9ffd..0e1019382cf5 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -204,6 +204,10 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_aglevel = le32_to_cpu(dbmp_le->dn_aglevel);
 	bmp->db_agheight = le32_to_cpu(dbmp_le->dn_agheight);
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
+	if (!bmp->db_agwidth) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
 	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
 	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
 	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
@@ -3403,7 +3407,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 	oldl2agsize = bmp->db_agl2size;
 
 	bmp->db_agl2size = l2agsize;
-	bmp->db_agsize = 1 << l2agsize;
+	bmp->db_agsize = (s64)1 << l2agsize;
 
 	/* compute new number of AG */
 	agno = bmp->db_numag;
@@ -3666,8 +3670,8 @@ void dbFinalizeBmap(struct inode *ipbmap)
 	 * system size is not a multiple of the group size).
 	 */
 	inactfree = (inactags && ag_rem) ?
-	    ((inactags - 1) << bmp->db_agl2size) + ag_rem
-	    : inactags << bmp->db_agl2size;
+	    (((s64)inactags - 1) << bmp->db_agl2size) + ag_rem
+	    : ((s64)inactags << bmp->db_agl2size);
 
 	/* determine how many free blocks are in the active
 	 * allocation groups plus the average number of free blocks
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index a360b24ed320..8ddc14c56501 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -102,7 +102,7 @@ int diMount(struct inode *ipimap)
 	 * allocate/initialize the in-memory inode map control structure
 	 */
 	/* allocate the in-memory inode map control structure. */
-	imap = kmalloc(sizeof(struct inomap), GFP_KERNEL);
+	imap = kzalloc(sizeof(struct inomap), GFP_KERNEL);
 	if (imap == NULL)
 		return -ENOMEM;
 
@@ -456,7 +456,7 @@ struct inode *diReadSpecial(struct super_block *sb, ino_t inum, int secondary)
 	dp += inum % 8;		/* 8 inodes per 4K page */
 
 	/* copy on-disk inode to in-memory inode */
-	if ((copy_from_dinode(dp, ip)) != 0) {
+	if ((copy_from_dinode(dp, ip) != 0) || (ip->i_nlink == 0)) {
 		/* handle bad return by returning NULL for ip */
 		set_nlink(ip, 1);	/* Don't want iput() deleting it */
 		iput(ip);
diff --git a/fs/namespace.c b/fs/namespace.c
index 73da51ac5a03..f898de3a6f70 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1986,6 +1986,7 @@ static void warn_mandlock(void)
 static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
+	struct super_block *sb = path->dentry->d_sb;
 
 	if (!may_mount())
 		return -EPERM;
@@ -1995,7 +1996,7 @@ static int can_umount(const struct path *path, int flags)
 		return -EINVAL;
 	if (mnt->mnt.mnt_flags & MNT_LOCKED) /* Check optimistically */
 		return -EINVAL;
-	if (flags & MNT_FORCE && !capable(CAP_SYS_ADMIN))
+	if (flags & MNT_FORCE && !ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 	return 0;
 }
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 88c03e182573..127626aba7a2 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -605,7 +605,7 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
 		return status;
 
 	status = decode_cb_op_status(xdr, OP_CB_GETATTR, &cb->cb_status);
-	if (status)
+	if (unlikely(status || cb->cb_status))
 		return status;
 	if (xdr_stream_decode_uint32_array(xdr, bitmap, 3) < 0)
 		return -NFSERR_BAD_XDR;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index e83629f39604..2e835e7c107e 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2244,8 +2244,14 @@ static __net_init int nfsd_net_init(struct net *net)
 					  NFSD_STATS_COUNTERS_NUM);
 	if (retval)
 		goto out_repcache_error;
+
 	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
 	nn->nfsd_svcstats.program = &nfsd_programs[0];
+	if (!nfsd_proc_stat_init(net)) {
+		retval = -ENOMEM;
+		goto out_proc_error;
+	}
+
 	for (i = 0; i < sizeof(nn->nfsd_versions); i++)
 		nn->nfsd_versions[i] = nfsd_support_version(i);
 	for (i = 0; i < sizeof(nn->nfsd4_minorversions); i++)
@@ -2255,12 +2261,13 @@ static __net_init int nfsd_net_init(struct net *net)
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
-	nfsd_proc_stat_init(net);
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	INIT_LIST_HEAD(&nn->local_clients);
 #endif
 	return 0;
 
+out_proc_error:
+	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 out_repcache_error:
 	nfsd_idmap_shutdown(net);
 out_idmap_error:
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index bb22893f1157..f7eaf95e20fc 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -73,11 +73,11 @@ static int nfsd_show(struct seq_file *seq, void *v)
 
 DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
 
-void nfsd_proc_stat_init(struct net *net)
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
+	return svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
 }
 
 void nfsd_proc_stat_shutdown(struct net *net)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 04aacb6c36e2..e4efb0e4e56d 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,7 +10,7 @@
 #include <uapi/linux/nfsd/stats.h>
 #include <linux/percpu_counter.h>
 
-void nfsd_proc_stat_init(struct net *net);
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net);
 void nfsd_proc_stat_shutdown(struct net *net);
 
 static inline void nfsd_stats_rc_hits_inc(struct nfsd_net *nn)
diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 7a43daacc815..7c61c1e944c7 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -702,18 +702,12 @@ cifs_crypto_secmech_release(struct TCP_Server_Info *server)
 	cifs_free_hash(&server->secmech.md5);
 	cifs_free_hash(&server->secmech.sha512);
 
-	if (!SERVER_IS_CHAN(server)) {
-		if (server->secmech.enc) {
-			crypto_free_aead(server->secmech.enc);
-			server->secmech.enc = NULL;
-		}
-
-		if (server->secmech.dec) {
-			crypto_free_aead(server->secmech.dec);
-			server->secmech.dec = NULL;
-		}
-	} else {
+	if (server->secmech.enc) {
+		crypto_free_aead(server->secmech.enc);
 		server->secmech.enc = NULL;
+	}
+	if (server->secmech.dec) {
+		crypto_free_aead(server->secmech.dec);
 		server->secmech.dec = NULL;
 	}
 }
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 8b8475b4e262..3aaf5cdce1b7 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1722,6 +1722,7 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 	/* Grab netns reference for this server. */
 	cifs_set_net_ns(tcp_ses, get_net(current->nsproxy->net_ns));
 
+	tcp_ses->sign = ctx->sign;
 	tcp_ses->conn_id = atomic_inc_return(&tcpSesNextId);
 	tcp_ses->noblockcnt = ctx->rootfs;
 	tcp_ses->noblocksnd = ctx->noblocksnd || ctx->rootfs;
@@ -2474,6 +2475,8 @@ static int match_tcon(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 		return 0;
 	if (tcon->nodelete != ctx->nodelete)
 		return 0;
+	if (tcon->posix_extensions != ctx->linux_ext)
+		return 0;
 	return 1;
 }
 
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index f8bc1da30037..1f1f4586673a 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1287,6 +1287,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		ctx->closetimeo = HZ * result.uint_32;
 		break;
 	case Opt_echo_interval:
+		if (result.uint_32 < SMB_ECHO_INTERVAL_MIN ||
+		    result.uint_32 > SMB_ECHO_INTERVAL_MAX) {
+			cifs_errorf(fc, "echo interval is out of bounds\n");
+			goto cifs_parse_mount_err;
+		}
 		ctx->echo_interval = result.uint_32;
 		break;
 	case Opt_snapshot:
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 97151715d1a4..31fce0a1b571 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1206,6 +1206,16 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 				cifs_create_junction_fattr(fattr, sb);
 				goto out;
 			}
+			/*
+			 * If the reparse point is unsupported by the Linux SMB
+			 * client then let it process by the SMB server. So mask
+			 * the -EOPNOTSUPP error code. This will allow Linux SMB
+			 * client to send SMB OPEN request to server. If server
+			 * does not support this reparse point too then server
+			 * will return error during open the path.
+			 */
+			if (rc == -EOPNOTSUPP)
+				rc = 0;
 		}
 		break;
 	}
diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index bb246ef0458f..b6556fe3dfa1 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -633,8 +633,6 @@ int parse_reparse_point(struct reparse_data_buffer *buf,
 			const char *full_path,
 			bool unicode, struct cifs_open_info_data *data)
 {
-	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
-
 	data->reparse.buf = buf;
 
 	/* See MS-FSCC 2.1.2 */
@@ -658,8 +656,6 @@ int parse_reparse_point(struct reparse_data_buffer *buf,
 		}
 		return 0;
 	default:
-		cifs_tcon_dbg(VFS | ONCE, "unhandled reparse tag: 0x%08x\n",
-			      le32_to_cpu(buf->ReparseTag));
 		return -EOPNOTSUPP;
 	}
 }
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 95e14977baea..2426fa740517 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -550,6 +550,13 @@ cifs_ses_add_channel(struct cifs_ses *ses,
 	ctx->sockopt_tcp_nodelay = ses->server->tcp_nodelay;
 	ctx->echo_interval = ses->server->echo_interval / HZ;
 	ctx->max_credits = ses->server->max_credits;
+	ctx->min_offload = ses->server->min_offload;
+	ctx->compress = ses->server->compression.requested;
+	ctx->dfs_conn = ses->server->dfs_conn;
+	ctx->ignore_signature = ses->server->ignore_signature;
+	ctx->leaf_fullpath = ses->server->leaf_fullpath;
+	ctx->rootfs = ses->server->noblockcnt;
+	ctx->retrans = ses->server->retrans;
 
 	/*
 	 * This will be used for encoding/decoding user/domain/pw
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index f3c4b70b77b9..cddf273c14ae 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -816,11 +816,12 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
 		WARN_ONCE(tcon->tc_count < 0, "tcon refcount is negative");
 		spin_unlock(&cifs_tcp_ses_lock);
 
-		if (tcon->ses)
+		if (tcon->ses) {
 			server = tcon->ses->server;
-
-		cifs_server_dbg(FYI, "tid=0x%x: tcon is closing, skipping async close retry of fid %llu %llu\n",
-				tcon->tid, persistent_fid, volatile_fid);
+			cifs_server_dbg(FYI,
+					"tid=0x%x: tcon is closing, skipping async close retry of fid %llu %llu\n",
+					tcon->tid, persistent_fid, volatile_fid);
+		}
 
 		return 0;
 	}
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 516be8c0b2a9..590b70d71694 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4576,9 +4576,9 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 			return rc;
 		}
 	} else {
-		if (unlikely(!server->secmech.dec))
-			return -EIO;
-
+		rc = smb3_crypto_aead_allocate(server);
+		if (unlikely(rc))
+			return rc;
 		tfm = server->secmech.dec;
 	}
 
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 75b13175a2e7..1a7b82664255 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1269,15 +1269,8 @@ SMB2_negotiate(const unsigned int xid,
 			cifs_server_dbg(VFS, "Missing expected negotiate contexts\n");
 	}
 
-	if (server->cipher_type && !rc) {
-		if (!SERVER_IS_CHAN(server)) {
-			rc = smb3_crypto_aead_allocate(server);
-		} else {
-			/* For channels, just reuse the primary server crypto secmech. */
-			server->secmech.enc = server->primary_server->secmech.enc;
-			server->secmech.dec = server->primary_server->secmech.dec;
-		}
-	}
+	if (server->cipher_type && !rc)
+		rc = smb3_crypto_aead_allocate(server);
 neg_exit:
 	free_rsp_buf(resp_buftype, rsp);
 	return rc;
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 70c907fe8af9..4386dd845e40 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -810,6 +810,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 		}
 		map->oflags = UDF_BLK_MAPPED;
 		map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc, offset);
+		ret = 0;
 		goto out_free;
 	}
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7c0bd0b55f88..199ec6d10b62 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -395,32 +395,6 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	if (!(vmf->flags & FAULT_FLAG_USER) && (ctx->flags & UFFD_USER_MODE_ONLY))
 		goto out;
 
-	/*
-	 * If it's already released don't get it. This avoids to loop
-	 * in __get_user_pages if userfaultfd_release waits on the
-	 * caller of handle_userfault to release the mmap_lock.
-	 */
-	if (unlikely(READ_ONCE(ctx->released))) {
-		/*
-		 * Don't return VM_FAULT_SIGBUS in this case, so a non
-		 * cooperative manager can close the uffd after the
-		 * last UFFDIO_COPY, without risking to trigger an
-		 * involuntary SIGBUS if the process was starting the
-		 * userfaultfd while the userfaultfd was still armed
-		 * (but after the last UFFDIO_COPY). If the uffd
-		 * wasn't already closed when the userfault reached
-		 * this point, that would normally be solved by
-		 * userfaultfd_must_wait returning 'false'.
-		 *
-		 * If we were to return VM_FAULT_SIGBUS here, the non
-		 * cooperative manager would be instead forced to
-		 * always call UFFDIO_UNREGISTER before it can safely
-		 * close the uffd.
-		 */
-		ret = VM_FAULT_NOPAGE;
-		goto out;
-	}
-
 	/*
 	 * Check that we can return VM_FAULT_RETRY.
 	 *
@@ -457,6 +431,31 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
 		goto out;
 
+	if (unlikely(READ_ONCE(ctx->released))) {
+		/*
+		 * If a concurrent release is detected, do not return
+		 * VM_FAULT_SIGBUS or VM_FAULT_NOPAGE, but instead always
+		 * return VM_FAULT_RETRY with lock released proactively.
+		 *
+		 * If we were to return VM_FAULT_SIGBUS here, the non
+		 * cooperative manager would be instead forced to
+		 * always call UFFDIO_UNREGISTER before it can safely
+		 * close the uffd, to avoid involuntary SIGBUS triggered.
+		 *
+		 * If we were to return VM_FAULT_NOPAGE, it would work for
+		 * the fault path, in which the lock will be released
+		 * later.  However for GUP, faultin_page() does nothing
+		 * special on NOPAGE, so GUP would spin retrying without
+		 * releasing the mmap read lock, causing possible livelock.
+		 *
+		 * Here only VM_FAULT_RETRY would make sure the mmap lock
+		 * be released immediately, so that the thread concurrently
+		 * releasing the userfault would always make progress.
+		 */
+		release_fault_lock(vmf);
+		goto out;
+	}
+
 	/* take the reference before dropping the mmap_lock */
 	userfaultfd_ctx_get(ctx);
 
diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index afdd46ef04f7..c835f113055d 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -120,6 +120,9 @@ drm_kunit_helper_create_crtc(struct kunit *test,
 			     const struct drm_crtc_funcs *funcs,
 			     const struct drm_crtc_helper_funcs *helper_funcs);
 
+int drm_kunit_add_mode_destroy_action(struct kunit *test,
+				      struct drm_display_mode *mode);
+
 struct drm_display_mode *
 drm_kunit_display_mode_from_cea_vic(struct kunit *test, struct drm_device *dev,
 				    u8 video_code);
diff --git a/include/drm/intel/i915_pciids.h b/include/drm/intel/i915_pciids.h
index f35534522d33..dacea289acaf 100644
--- a/include/drm/intel/i915_pciids.h
+++ b/include/drm/intel/i915_pciids.h
@@ -809,6 +809,9 @@
 	MACRO__(0xE20B, ## __VA_ARGS__), \
 	MACRO__(0xE20C, ## __VA_ARGS__), \
 	MACRO__(0xE20D, ## __VA_ARGS__), \
-	MACRO__(0xE212, ## __VA_ARGS__)
+	MACRO__(0xE210, ## __VA_ARGS__), \
+	MACRO__(0xE212, ## __VA_ARGS__), \
+	MACRO__(0xE215, ## __VA_ARGS__), \
+	MACRO__(0xE216, ## __VA_ARGS__)
 
 #endif /* _I915_PCIIDS_H */
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 38b2af336e4a..252eed781a6e 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -711,6 +711,7 @@ struct cgroup_subsys {
 	void (*css_released)(struct cgroup_subsys_state *css);
 	void (*css_free)(struct cgroup_subsys_state *css);
 	void (*css_reset)(struct cgroup_subsys_state *css);
+	void (*css_killed)(struct cgroup_subsys_state *css);
 	void (*css_rstat_flush)(struct cgroup_subsys_state *css, int cpu);
 	int (*css_extra_stat_show)(struct seq_file *seq,
 				   struct cgroup_subsys_state *css);
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f8ef47f8a634..fc1324ed597d 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -343,7 +343,7 @@ static inline u64 cgroup_id(const struct cgroup *cgrp)
  */
 static inline bool css_is_dying(struct cgroup_subsys_state *css)
 {
-	return !(css->flags & CSS_NO_REF) && percpu_ref_is_dying(&css->refcnt);
+	return css->flags & CSS_DYING;
 }
 
 static inline void cgroup_get(struct cgroup *cgrp)
diff --git a/include/linux/hid.h b/include/linux/hid.h
index dd3342301253..018de72505b0 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1221,12 +1221,6 @@ unsigned long hid_lookup_quirk(const struct hid_device *hdev);
 int hid_quirks_init(char **quirks_param, __u16 bus, int count);
 void hid_quirks_exit(__u16 bus);
 
-#ifdef CONFIG_HID_PID
-int hid_pidff_init(struct hid_device *hid);
-#else
-#define hid_pidff_init NULL
-#endif
-
 #define dbg_hid(fmt, ...) pr_debug("%s: " fmt, __FILE__, ##__VA_ARGS__)
 
 #define hid_err(hid, fmt, ...)				\
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 4b9ba523978d..5ce332fc6ff5 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -457,6 +457,7 @@ enum {
 	REQ_F_SKIP_LINK_CQES_BIT,
 	REQ_F_SINGLE_POLL_BIT,
 	REQ_F_DOUBLE_POLL_BIT,
+	REQ_F_MULTISHOT_BIT,
 	REQ_F_APOLL_MULTISHOT_BIT,
 	REQ_F_CLEAR_POLLIN_BIT,
 	REQ_F_HASH_LOCKED_BIT,
@@ -530,6 +531,8 @@ enum {
 	REQ_F_SINGLE_POLL	= IO_REQ_FLAG(REQ_F_SINGLE_POLL_BIT),
 	/* double poll may active */
 	REQ_F_DOUBLE_POLL	= IO_REQ_FLAG(REQ_F_DOUBLE_POLL_BIT),
+	/* request posts multiple completions, should be set at prep time */
+	REQ_F_MULTISHOT		= IO_REQ_FLAG(REQ_F_MULTISHOT_BIT),
 	/* fast poll multishot mode */
 	REQ_F_APOLL_MULTISHOT	= IO_REQ_FLAG(REQ_F_APOLL_MULTISHOT_BIT),
 	/* recvmsg special flag, clear EPOLLIN */
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2c66ca21801c..15206450929d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2330,7 +2330,7 @@ static inline bool kvm_is_visible_memslot(struct kvm_memory_slot *memslot)
 struct kvm_vcpu *kvm_get_running_vcpu(void);
 struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
 
-#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
+#if IS_ENABLED(CONFIG_HAVE_KVM_IRQ_BYPASS)
 bool kvm_arch_has_irq_bypass(void);
 int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *,
 			   struct irq_bypass_producer *);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 48c66b846682..a9244291f506 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1111,6 +1111,12 @@ static inline bool is_page_hwpoison(const struct page *page)
 	return folio_test_hugetlb(folio) && PageHWPoison(&folio->page);
 }
 
+static inline bool folio_contain_hwpoisoned_page(struct folio *folio)
+{
+	return folio_test_hwpoison(folio) ||
+	    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio));
+}
+
 bool is_free_buddy_page(const struct page *page);
 
 PAGEFLAG(Isolated, isolated, PF_ANY);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c9dc15355f1b..c395b3c5c05c 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2605,6 +2605,8 @@
 
 #define PCI_VENDOR_ID_ZHAOXIN		0x1d17
 
+#define PCI_VENDOR_ID_ROCKCHIP		0x1d87
+
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
 #define PCI_VENDOR_ID_META		0x1d9b
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 347901525a46..0997077bcc52 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -170,6 +170,12 @@ struct hw_perf_event {
 		};
 		struct { /* aux / Intel-PT */
 			u64		aux_config;
+			/*
+			 * For AUX area events, aux_paused cannot be a state
+			 * flag because it can be updated asynchronously to
+			 * state.
+			 */
+			unsigned int	aux_paused;
 		};
 		struct { /* software */
 			struct hrtimer	hrtimer;
@@ -294,6 +300,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_NO_EXCLUDE			0x0040
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
+#define PERF_PMU_CAP_AUX_PAUSE			0x0200
 
 /**
  * pmu::scope
@@ -384,6 +391,8 @@ struct pmu {
 #define PERF_EF_START	0x01		/* start the counter when adding    */
 #define PERF_EF_RELOAD	0x02		/* reload the counter when starting */
 #define PERF_EF_UPDATE	0x04		/* update the counter when stopping */
+#define PERF_EF_PAUSE	0x08		/* AUX area event, pause tracing */
+#define PERF_EF_RESUME	0x10		/* AUX area event, resume tracing */
 
 	/*
 	 * Adds/Removes a counter to/from the PMU, can be done inside a
@@ -423,6 +432,18 @@ struct pmu {
 	 *
 	 * ->start() with PERF_EF_RELOAD will reprogram the counter
 	 *  value, must be preceded by a ->stop() with PERF_EF_UPDATE.
+	 *
+	 * ->stop() with PERF_EF_PAUSE will stop as simply as possible. Will not
+	 * overlap another ->stop() with PERF_EF_PAUSE nor ->start() with
+	 * PERF_EF_RESUME.
+	 *
+	 * ->start() with PERF_EF_RESUME will start as simply as possible but
+	 * only if the counter is not otherwise stopped. Will not overlap
+	 * another ->start() with PERF_EF_RESUME nor ->stop() with
+	 * PERF_EF_PAUSE.
+	 *
+	 * Notably, PERF_EF_PAUSE/PERF_EF_RESUME *can* be concurrent with other
+	 * ->stop()/->start() invocations, just not itself.
 	 */
 	void (*start)			(struct perf_event *event, int flags);
 	void (*stop)			(struct perf_event *event, int flags);
@@ -652,13 +673,15 @@ struct swevent_hlist {
 	struct rcu_head			rcu_head;
 };
 
-#define PERF_ATTACH_CONTEXT	0x01
-#define PERF_ATTACH_GROUP	0x02
-#define PERF_ATTACH_TASK	0x04
-#define PERF_ATTACH_TASK_DATA	0x08
-#define PERF_ATTACH_ITRACE	0x10
-#define PERF_ATTACH_SCHED_CB	0x20
-#define PERF_ATTACH_CHILD	0x40
+#define PERF_ATTACH_CONTEXT	0x0001
+#define PERF_ATTACH_GROUP	0x0002
+#define PERF_ATTACH_TASK	0x0004
+#define PERF_ATTACH_TASK_DATA	0x0008
+#define PERF_ATTACH_ITRACE	0x0010
+#define PERF_ATTACH_SCHED_CB	0x0020
+#define PERF_ATTACH_CHILD	0x0040
+#define PERF_ATTACH_EXCLUSIVE	0x0080
+#define PERF_ATTACH_CALLCHAIN	0x0100
 
 struct bpf_prog;
 struct perf_cgroup;
@@ -810,7 +833,6 @@ struct perf_event {
 	struct irq_work			pending_disable_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
-	struct rcuwait			pending_work_wait;
 
 	atomic_t			event_limit;
 
@@ -1685,6 +1707,13 @@ static inline bool has_aux(struct perf_event *event)
 	return event->pmu->setup_aux;
 }
 
+static inline bool has_aux_action(struct perf_event *event)
+{
+	return event->attr.aux_sample_size ||
+	       event->attr.aux_pause ||
+	       event->attr.aux_resume;
+}
+
 static inline bool is_write_backward(struct perf_event *event)
 {
 	return !!event->attr.write_backward;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8df030ebd862..be6ca84db4d8 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -201,10 +201,14 @@ static inline int pmd_dirty(pmd_t pmd)
  * hazard could result in the direct mode hypervisor case, since the actual
  * write to the page tables may not yet have taken place, so reads though
  * a raw PTE pointer after it has been modified are not guaranteed to be
- * up to date.  This mode can only be entered and left under the protection of
- * the page table locks for all page tables which may be modified.  In the UP
- * case, this is required so that preemption is disabled, and in the SMP case,
- * it must synchronize the delayed page table writes properly on other CPUs.
+ * up to date.
+ *
+ * In the general case, no lock is guaranteed to be held between entry and exit
+ * of the lazy mode. So the implementation must assume preemption may be enabled
+ * and cpu migration is possible; it must take steps to be robust against this.
+ * (In practice, for user PTE updates, the appropriate page table lock(s) are
+ * held, but for kernel PTE updates, no lock is held). Nesting is not permitted
+ * and the mode cannot be used in interrupt context.
  */
 #ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 #define arch_enter_lazy_mmu_mode()	do {} while (0)
@@ -266,7 +270,6 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 {
 	page_table_check_ptes_set(mm, ptep, pte, nr);
 
-	arch_enter_lazy_mmu_mode();
 	for (;;) {
 		set_pte(ptep, pte);
 		if (--nr == 0)
@@ -274,7 +277,6 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		ptep++;
 		pte = pte_next_pfn(pte);
 	}
-	arch_leave_lazy_mmu_mode();
 }
 #endif
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
diff --git a/include/linux/printk.h b/include/linux/printk.h
index eca9bb2ee637..0cb647ecd77f 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -204,6 +204,7 @@ void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
+bool pr_flush(int timeout_ms, bool reset_on_progress);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -304,6 +305,11 @@ static inline void nbcon_atomic_flush_unsafe(void)
 {
 }
 
+static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
+{
+	return true;
+}
+
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 20a40ade8030..6c3125300c00 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -335,6 +335,7 @@ enum tpm2_cc_attrs {
 #define TPM_VID_WINBOND  0x1050
 #define TPM_VID_STM      0x104A
 #define TPM_VID_ATML     0x1114
+#define TPM_VID_IFX      0x15D1
 
 enum tpm_chip_flags {
 	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index dd10e02bfc74..71d243287640 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -353,6 +353,22 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY,
+
+	/* When this quirk is set, the HCI_OP_READ_VOICE_SETTING command is
+	 * skipped. This is required for a subset of the CSR controller clones
+	 * which erroneously claim to support it.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_BROKEN_READ_VOICE_SETTING,
+
+	/* When this quirk is set, the HCI_OP_READ_PAGE_SCAN_TYPE command is
+	 * skipped. This is required for a subset of the CSR controller clones
+	 * which erroneously claim to support it.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c95f7e6ba255..4245910ffc4a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1921,6 +1921,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 	((dev)->commands[20] & 0x10 && \
 	 !test_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks))
 
+#define read_voice_setting_capable(dev) \
+	((dev)->commands[9] & 0x04 && \
+	 !test_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &(dev)->quirks))
+
 /* Use enhanced synchronous connection if command is supported and its quirk
  * has not been set.
  */
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 5b712582f9a9..3b964f8834e7 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2826,6 +2826,11 @@ struct ieee80211_txq {
  *	implements MLO, so operation can continue on other links when one
  *	link is switching.
  *
+ * @IEEE80211_HW_STRICT: strictly enforce certain things mandated by the spec
+ *	but otherwise ignored/worked around for interoperability. This is a
+ *	HW flag so drivers can opt in according to their own control, e.g. in
+ *	testing.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2885,6 +2890,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_DISALLOW_PUNCTURING,
 	IEEE80211_HW_DISALLOW_PUNCTURING_5GHZ,
 	IEEE80211_HW_HANDLES_QUIET_CSA,
+	IEEE80211_HW_STRICT,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 31248cfdfb23..dcd288fa1bb6 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -775,6 +775,7 @@ struct sctp_transport {
 
 	/* Reference counting. */
 	refcount_t refcnt;
+	__u32	dead:1,
 		/* RTO-Pending : A flag used to track if one of the DATA
 		 *		chunks sent to this address is currently being
 		 *		used to compute a RTT. If this flag is 0,
@@ -784,7 +785,7 @@ struct sctp_transport {
 		 *		calculation completes (i.e. the DATA chunk
 		 *		is SACK'd) clear this flag.
 		 */
-	__u32	rto_pending:1,
+		rto_pending:1,
 
 		/*
 		 * hb_sent : a flag that signals that we have a pending
diff --git a/include/net/sock.h b/include/net/sock.h
index fa055cf1785e..fa9b9dadbe17 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -338,6 +338,8 @@ struct sk_filter;
   *	@sk_txtime_unused: unused txtime flags
   *	@ns_tracker: tracker for netns reference
   *	@sk_user_frags: xarray of pages the user is holding a reference on.
+  *	@sk_owner: reference to the real owner of the socket that calls
+  *		   sock_lock_init_class_and_name().
   */
 struct sock {
 	/*
@@ -544,6 +546,10 @@ struct sock {
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
 	struct xarray		sk_user_frags;
+
+#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
+	struct module		*sk_owner;
+#endif
 };
 
 struct sock_bh_locked {
@@ -1585,6 +1591,35 @@ static inline void sk_mem_uncharge(struct sock *sk, int size)
 	sk_mem_reclaim(sk);
 }
 
+#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
+static inline void sk_owner_set(struct sock *sk, struct module *owner)
+{
+	__module_get(owner);
+	sk->sk_owner = owner;
+}
+
+static inline void sk_owner_clear(struct sock *sk)
+{
+	sk->sk_owner = NULL;
+}
+
+static inline void sk_owner_put(struct sock *sk)
+{
+	module_put(sk->sk_owner);
+}
+#else
+static inline void sk_owner_set(struct sock *sk, struct module *owner)
+{
+}
+
+static inline void sk_owner_clear(struct sock *sk)
+{
+}
+
+static inline void sk_owner_put(struct sock *sk)
+{
+}
+#endif
 /*
  * Macro so as to not evaluate some arguments when
  * lockdep is not enabled.
@@ -1594,13 +1629,14 @@ static inline void sk_mem_uncharge(struct sock *sk, int size)
  */
 #define sock_lock_init_class_and_name(sk, sname, skey, name, key)	\
 do {									\
+	sk_owner_set(sk, THIS_MODULE);					\
 	sk->sk_lock.owned = 0;						\
 	init_waitqueue_head(&sk->sk_lock.wq);				\
 	spin_lock_init(&(sk)->sk_lock.slock);				\
 	debug_check_no_locks_freed((void *)&(sk)->sk_lock,		\
-			sizeof((sk)->sk_lock));				\
+				   sizeof((sk)->sk_lock));		\
 	lockdep_set_class_and_name(&(sk)->sk_lock.slock,		\
-				(skey), (sname));				\
+				   (skey), (sname));			\
 	lockdep_init_map(&(sk)->sk_lock.dep_map, (name), (key), 0);	\
 } while (0)
 
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 717307d6b5b7..3e1c11d9d980 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -62,6 +62,8 @@ struct kfd_ioctl_get_version_args {
 #define KFD_MAX_QUEUE_PERCENTAGE	100
 #define KFD_MAX_QUEUE_PRIORITY		15
 
+#define KFD_MIN_QUEUE_RING_SIZE		1024
+
 struct kfd_ioctl_create_queue_args {
 	__u64 ring_base_address;	/* to KFD */
 	__u64 write_pointer_address;	/* from KFD */
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 33745642f787..c223572f8229 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -57,9 +57,11 @@ struct landlock_ruleset_attr {
  *
  * - %LANDLOCK_CREATE_RULESET_VERSION: Get the highest supported Landlock ABI
  *   version.
+ * - %LANDLOCK_CREATE_RULESET_ERRATA: Get a bitmask of fixed issues.
  */
 /* clang-format off */
 #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
+#define LANDLOCK_CREATE_RULESET_ERRATA			(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 4842c36fdf80..0524d541d4e3 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -511,7 +511,16 @@ struct perf_event_attr {
 	__u16	sample_max_stack;
 	__u16	__reserved_2;
 	__u32	aux_sample_size;
-	__u32	__reserved_3;
+
+	union {
+		__u32	aux_action;
+		struct {
+			__u32	aux_start_paused :  1, /* start AUX area tracing paused */
+				aux_pause        :  1, /* on overflow, pause AUX area tracing */
+				aux_resume       :  1, /* on overflow, resume AUX area tracing */
+				__reserved_3     : 29;
+		};
+	};
 
 	/*
 	 * User provided data if sigtrap=1, passed back to user via
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 832c15d9155b..eeb20dfb1fda 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -73,13 +73,20 @@ typedef enum {
 	SEV_RET_INVALID_PARAM,
 	SEV_RET_RESOURCE_LIMIT,
 	SEV_RET_SECURE_DATA_INVALID,
-	SEV_RET_INVALID_KEY = 0x27,
-	SEV_RET_INVALID_PAGE_SIZE,
-	SEV_RET_INVALID_PAGE_STATE,
-	SEV_RET_INVALID_MDATA_ENTRY,
-	SEV_RET_INVALID_PAGE_OWNER,
-	SEV_RET_INVALID_PAGE_AEAD_OFLOW,
-	SEV_RET_RMP_INIT_REQUIRED,
+	SEV_RET_INVALID_PAGE_SIZE          = 0x0019,
+	SEV_RET_INVALID_PAGE_STATE         = 0x001A,
+	SEV_RET_INVALID_MDATA_ENTRY        = 0x001B,
+	SEV_RET_INVALID_PAGE_OWNER         = 0x001C,
+	SEV_RET_AEAD_OFLOW                 = 0x001D,
+	SEV_RET_EXIT_RING_BUFFER           = 0x001F,
+	SEV_RET_RMP_INIT_REQUIRED          = 0x0020,
+	SEV_RET_BAD_SVN                    = 0x0021,
+	SEV_RET_BAD_VERSION                = 0x0022,
+	SEV_RET_SHUTDOWN_REQUIRED          = 0x0023,
+	SEV_RET_UPDATE_FAILED              = 0x0024,
+	SEV_RET_RESTORE_REQUIRED           = 0x0025,
+	SEV_RET_RMP_INITIALIZATION_FAILED  = 0x0026,
+	SEV_RET_INVALID_KEY                = 0x0027,
 	SEV_RET_MAX,
 } sev_ret_code;
 
diff --git a/include/uapi/linux/rkisp1-config.h b/include/uapi/linux/rkisp1-config.h
index 430daceafac7..2d995f3c1ca3 100644
--- a/include/uapi/linux/rkisp1-config.h
+++ b/include/uapi/linux/rkisp1-config.h
@@ -1528,7 +1528,7 @@ enum rksip1_ext_param_buffer_version {
  * The expected memory layout of the parameters buffer is::
  *
  *	+-------------------- struct rkisp1_ext_params_cfg -------------------+
- *	| version = RKISP_EXT_PARAMS_BUFFER_V1;                               |
+ *	| version = RKISP1_EXT_PARAM_BUFFER_V1;                               |
  *	| data_size = sizeof(struct rkisp1_ext_params_bls_config)             |
  *	|           + sizeof(struct rkisp1_ext_params_dpcc_config);           |
  *	| +------------------------- data  ---------------------------------+ |
diff --git a/include/xen/interface/xen-mca.h b/include/xen/interface/xen-mca.h
index 464aa6b3a5f9..1c9afbe8cc26 100644
--- a/include/xen/interface/xen-mca.h
+++ b/include/xen/interface/xen-mca.h
@@ -372,7 +372,7 @@ struct xen_mce {
 #define XEN_MCE_LOG_LEN 32
 
 struct xen_mce_log {
-	char signature[12]; /* "MACHINECHECK" */
+	char signature[12] __nonstring; /* "MACHINECHECK" */
 	unsigned len;	    /* = XEN_MCE_LOG_LEN */
 	unsigned next;
 	unsigned flags;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index cf28d29fffbf..19de7129ae0b 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1821,7 +1821,7 @@ void io_wq_submit_work(struct io_wq_work *work)
 	 * Don't allow any multishot execution from io-wq. It's more restrictive
 	 * than necessary and also cleaner.
 	 */
-	if (req->flags & REQ_F_APOLL_MULTISHOT) {
+	if (req->flags & (REQ_F_MULTISHOT|REQ_F_APOLL_MULTISHOT)) {
 		err = -EBADFD;
 		if (!io_file_can_poll(req))
 			goto fail;
@@ -1832,7 +1832,7 @@ void io_wq_submit_work(struct io_wq_work *work)
 				goto fail;
 			return;
 		} else {
-			req->flags &= ~REQ_F_APOLL_MULTISHOT;
+			req->flags &= ~(REQ_F_APOLL_MULTISHOT|REQ_F_MULTISHOT);
 		}
 	}
 
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index e1895952066e..7a8c3a004800 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -484,6 +484,8 @@ int io_provide_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 	p->nbufs = tmp;
 	p->addr = READ_ONCE(sqe->addr);
 	p->len = READ_ONCE(sqe->len);
+	if (!p->len)
+		return -EINVAL;
 
 	if (check_mul_overflow((unsigned long)p->len, (unsigned long)p->nbufs,
 				&size))
diff --git a/io_uring/net.c b/io_uring/net.c
index 7ea99e082e97..384915d931b7 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -435,6 +435,7 @@ int io_sendmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		sr->msg_flags |= MSG_WAITALL;
 		sr->buf_group = req->buf_index;
 		req->buf_list = NULL;
+		req->flags |= REQ_F_MULTISHOT;
 	}
 
 #ifdef CONFIG_COMPAT
@@ -1616,6 +1617,8 @@ int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 	}
 
 	io_req_set_res(req, ret, cflags);
+	if (!(issue_flags & IO_URING_F_MULTISHOT))
+		return IOU_OK;
 	return IOU_STOP_MULTISHOT;
 }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 216535e055e1..4378f3eff25d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5909,6 +5909,12 @@ static void kill_css(struct cgroup_subsys_state *css)
 	if (css->flags & CSS_DYING)
 		return;
 
+	/*
+	 * Call css_killed(), if defined, before setting the CSS_DYING flag
+	 */
+	if (css->ss->css_killed)
+		css->ss->css_killed(css);
+
 	css->flags |= CSS_DYING;
 
 	/*
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 24ece85fd3b1..839f88ba17f7 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -84,9 +84,19 @@ static bool		have_boot_isolcpus;
 static struct list_head remote_children;
 
 /*
- * A flag to force sched domain rebuild at the end of an operation while
- * inhibiting it in the intermediate stages when set. Currently it is only
- * set in hotplug code.
+ * A flag to force sched domain rebuild at the end of an operation.
+ * It can be set in
+ *  - update_partition_sd_lb()
+ *  - remote_partition_check()
+ *  - update_cpumasks_hier()
+ *  - cpuset_update_flag()
+ *  - cpuset_hotplug_update_tasks()
+ *  - cpuset_handle_hotplug()
+ *
+ * Protected by cpuset_mutex (with cpus_read_lock held) or cpus_write_lock.
+ *
+ * Note that update_relax_domain_level() in cpuset-v1.c can still call
+ * rebuild_sched_domains_locked() directly without using this flag.
  */
 static bool force_sd_rebuild;
 
@@ -283,6 +293,12 @@ static inline void dec_attach_in_progress(struct cpuset *cs)
 	mutex_unlock(&cpuset_mutex);
 }
 
+static inline bool cpuset_v2(void)
+{
+	return !IS_ENABLED(CONFIG_CPUSETS_V1) ||
+		cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
+}
+
 /*
  * Cgroup v2 behavior is used on the "cpus" and "mems" control files when
  * on default hierarchy or when the cpuset_v2_mode flag is set by mounting
@@ -293,7 +309,7 @@ static inline void dec_attach_in_progress(struct cpuset *cs)
  */
 static inline bool is_in_v2_mode(void)
 {
-	return cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
+	return cpuset_v2() ||
 	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
 }
 
@@ -728,7 +744,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	int nslot;		/* next empty doms[] struct cpumask slot */
 	struct cgroup_subsys_state *pos_css;
 	bool root_load_balance = is_sched_load_balance(&top_cpuset);
-	bool cgrpv2 = cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
+	bool cgrpv2 = cpuset_v2();
 	int nslot_update;
 
 	doms = NULL;
@@ -998,6 +1014,7 @@ void rebuild_sched_domains_locked(void)
 
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&cpuset_mutex);
+	force_sd_rebuild = false;
 
 	/*
 	 * If we have raced with CPU hotplug, return early to avoid
@@ -1172,8 +1189,8 @@ static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
 			clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 	}
 
-	if (rebuild_domains && !force_sd_rebuild)
-		rebuild_sched_domains_locked();
+	if (rebuild_domains)
+		cpuset_force_rebuild();
 }
 
 /*
@@ -1195,7 +1212,7 @@ static void reset_partition_data(struct cpuset *cs)
 {
 	struct cpuset *parent = parent_cs(cs);
 
-	if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
+	if (!cpuset_v2())
 		return;
 
 	lockdep_assert_held(&callback_lock);
@@ -1383,6 +1400,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	list_add(&cs->remote_sibling, &remote_children);
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
+	cs->prs_err = 0;
 
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
@@ -1413,9 +1431,11 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	list_del_init(&cs->remote_sibling);
 	isolcpus_updated = partition_xcpus_del(cs->partition_root_state,
 					       NULL, tmp->new_cpus);
-	cs->partition_root_state = -cs->partition_root_state;
-	if (!cs->prs_err)
-		cs->prs_err = PERR_INVCPUS;
+	if (cs->prs_err)
+		cs->partition_root_state = -cs->partition_root_state;
+	else
+		cs->partition_root_state = PRS_MEMBER;
+
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
@@ -1448,8 +1468,10 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 
 	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
 
-	if (cpumask_empty(newmask))
+	if (cpumask_empty(newmask)) {
+		cs->prs_err = PERR_CPUSEMPTY;
 		goto invalidate;
+	}
 
 	adding   = cpumask_andnot(tmp->addmask, newmask, cs->effective_xcpus);
 	deleting = cpumask_andnot(tmp->delmask, cs->effective_xcpus, newmask);
@@ -1459,10 +1481,15 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 	 * not allocated to other partitions and there are effective_cpus
 	 * left in the top cpuset.
 	 */
-	if (adding && (!capable(CAP_SYS_ADMIN) ||
-		       cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
-		       cpumask_subset(top_cpuset.effective_cpus, tmp->addmask)))
-		goto invalidate;
+	if (adding) {
+		if (!capable(CAP_SYS_ADMIN))
+			cs->prs_err = PERR_ACCESS;
+		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
+			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
+			cs->prs_err = PERR_NOCPUS;
+		if (cs->prs_err)
+			goto invalidate;
+	}
 
 	spin_lock_irq(&callback_lock);
 	if (adding)
@@ -1520,8 +1547,8 @@ static void remote_partition_check(struct cpuset *cs, struct cpumask *newmask,
 			remote_partition_disable(child, tmp);
 			disable_cnt++;
 		}
-	if (disable_cnt && !force_sd_rebuild)
-		rebuild_sched_domains_locked();
+	if (disable_cnt)
+		cpuset_force_rebuild();
 }
 
 /*
@@ -1578,7 +1605,7 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
  * The partcmd_update command is used by update_cpumasks_hier() with newmask
  * NULL and update_cpumask() with newmask set. The partcmd_invalidate is used
  * by update_cpumask() with NULL newmask. In both cases, the callers won't
- * check for error and so partition_root_state and prs_error will be updated
+ * check for error and so partition_root_state and prs_err will be updated
  * directly.
  */
 static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
@@ -1656,9 +1683,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		if (nocpu)
 			return PERR_NOCPUS;
 
-		cpumask_copy(tmp->delmask, xcpus);
-		deleting = true;
-		subparts_delta++;
+		deleting = cpumask_and(tmp->delmask, xcpus, parent->effective_xcpus);
+		if (deleting)
+			subparts_delta++;
 		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
 	} else if (cmd == partcmd_disable) {
 		/*
@@ -1930,12 +1957,6 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
 	rcu_read_unlock();
 }
 
-/*
- * update_cpumasks_hier() flags
- */
-#define HIER_CHECKALL		0x01	/* Check all cpusets with no skipping */
-#define HIER_NO_SD_REBUILD	0x02	/* Don't rebuild sched domains */
-
 /*
  * update_cpumasks_hier - Update effective cpumasks and tasks in the subtree
  * @cs:  the cpuset to consider
@@ -1950,7 +1971,7 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
  * Called with cpuset_mutex held
  */
 static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
-				 int flags)
+				 bool force)
 {
 	struct cpuset *cp;
 	struct cgroup_subsys_state *pos_css;
@@ -2015,12 +2036,12 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * Skip the whole subtree if
 		 * 1) the cpumask remains the same,
 		 * 2) has no partition root state,
-		 * 3) HIER_CHECKALL flag not set, and
+		 * 3) force flag not set, and
 		 * 4) for v2 load balance state same as its parent.
 		 */
-		if (!cp->partition_root_state && !(flags & HIER_CHECKALL) &&
+		if (!cp->partition_root_state && !force &&
 		    cpumask_equal(tmp->new_cpus, cp->effective_cpus) &&
-		    (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
+		    (!cpuset_v2() ||
 		    (is_sched_load_balance(parent) == is_sched_load_balance(cp)))) {
 			pos_css = css_rightmost_descendant(pos_css);
 			continue;
@@ -2094,8 +2115,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * from parent if current cpuset isn't a valid partition root
 		 * and their load balance states differ.
 		 */
-		if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
-		    !is_partition_valid(cp) &&
+		if (cpuset_v2() && !is_partition_valid(cp) &&
 		    (is_sched_load_balance(parent) != is_sched_load_balance(cp))) {
 			if (is_sched_load_balance(parent))
 				set_bit(CS_SCHED_LOAD_BALANCE, &cp->flags);
@@ -2111,8 +2131,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 */
 		if (!cpumask_empty(cp->cpus_allowed) &&
 		    is_sched_load_balance(cp) &&
-		   (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
-		    is_partition_valid(cp)))
+		   (!cpuset_v2() || is_partition_valid(cp)))
 			need_rebuild_sched_domains = true;
 
 		rcu_read_lock();
@@ -2120,9 +2139,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 	}
 	rcu_read_unlock();
 
-	if (need_rebuild_sched_domains && !(flags & HIER_NO_SD_REBUILD) &&
-	    !force_sd_rebuild)
-		rebuild_sched_domains_locked();
+	if (need_rebuild_sched_domains)
+		cpuset_force_rebuild();
 }
 
 /**
@@ -2149,9 +2167,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	 * directly.
 	 *
 	 * The update_cpumasks_hier() function may sleep. So we have to
-	 * release the RCU read lock before calling it. HIER_NO_SD_REBUILD
-	 * flag is used to suppress rebuild of sched domains as the callers
-	 * will take care of that.
+	 * release the RCU read lock before calling it.
 	 */
 	rcu_read_lock();
 	cpuset_for_each_child(sibling, pos_css, parent) {
@@ -2167,7 +2183,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 			continue;
 
 		rcu_read_unlock();
-		update_cpumasks_hier(sibling, tmp, HIER_NO_SD_REBUILD);
+		update_cpumasks_hier(sibling, tmp, false);
 		rcu_read_lock();
 		css_put(&sibling->css);
 	}
@@ -2187,7 +2203,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	struct tmpmasks tmp;
 	struct cpuset *parent = parent_cs(cs);
 	bool invalidate = false;
-	int hier_flags = 0;
+	bool force = false;
 	int old_prs = cs->partition_root_state;
 
 	/* top_cpuset.cpus_allowed tracks cpu_online_mask; it's read-only */
@@ -2248,12 +2264,11 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 * Check all the descendants in update_cpumasks_hier() if
 	 * effective_xcpus is to be changed.
 	 */
-	if (!cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus))
-		hier_flags = HIER_CHECKALL;
+	force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
 
 	retval = validate_change(cs, trialcs);
 
-	if ((retval == -EINVAL) && cgroup_subsys_on_dfl(cpuset_cgrp_subsys)) {
+	if ((retval == -EINVAL) && cpuset_v2()) {
 		struct cgroup_subsys_state *css;
 		struct cpuset *cp;
 
@@ -2317,7 +2332,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	spin_unlock_irq(&callback_lock);
 
 	/* effective_cpus/effective_xcpus will be updated here */
-	update_cpumasks_hier(cs, &tmp, hier_flags);
+	update_cpumasks_hier(cs, &tmp, force);
 
 	/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains, if necessary */
 	if (cs->partition_root_state)
@@ -2342,7 +2357,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	struct tmpmasks tmp;
 	struct cpuset *parent = parent_cs(cs);
 	bool invalidate = false;
-	int hier_flags = 0;
+	bool force = false;
 	int old_prs = cs->partition_root_state;
 
 	if (!*buf) {
@@ -2365,8 +2380,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 * Check all the descendants in update_cpumasks_hier() if
 	 * effective_xcpus is to be changed.
 	 */
-	if (!cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus))
-		hier_flags = HIER_CHECKALL;
+	force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
 
 	retval = validate_change(cs, trialcs);
 	if (retval)
@@ -2419,8 +2433,8 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 * of the subtree when it is a valid partition root or effective_xcpus
 	 * is updated.
 	 */
-	if (is_partition_valid(cs) || hier_flags)
-		update_cpumasks_hier(cs, &tmp, hier_flags);
+	if (is_partition_valid(cs) || force)
+		update_cpumasks_hier(cs, &tmp, force);
 
 	/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains, if necessary */
 	if (cs->partition_root_state)
@@ -2745,9 +2759,12 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	cs->flags = trialcs->flags;
 	spin_unlock_irq(&callback_lock);
 
-	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed &&
-	    !force_sd_rebuild)
-		rebuild_sched_domains_locked();
+	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed) {
+		if (cpuset_v2())
+			cpuset_force_rebuild();
+		else
+			rebuild_sched_domains_locked();
+	}
 
 	if (spread_flag_changed)
 		cpuset1_update_tasks_flags(cs);
@@ -2861,12 +2878,14 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	update_unbound_workqueue_cpumask(new_xcpus_state);
 
 	/* Force update if switching back to member */
-	update_cpumasks_hier(cs, &tmpmask, !new_prs ? HIER_CHECKALL : 0);
+	update_cpumasks_hier(cs, &tmpmask, !new_prs);
 
 	/* Update sched domains and load balance flag */
 	update_partition_sd_lb(cs, old_prs);
 
 	notify_partition_change(cs, old_prs);
+	if (force_sd_rebuild)
+		rebuild_sched_domains_locked();
 	free_cpumasks(NULL, &tmpmask);
 	return 0;
 }
@@ -2927,8 +2946,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		 * migration permission derives from hierarchy ownership in
 		 * cgroup_procs_write_permission()).
 		 */
-		if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
-		    (cpus_updated || mems_updated)) {
+		if (!cpuset_v2() || (cpus_updated || mems_updated)) {
 			ret = security_task_setscheduler(task);
 			if (ret)
 				goto out_unlock;
@@ -3042,8 +3060,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * in effective cpus and mems. In that case, we can optimize out
 	 * by skipping the task iteration and update.
 	 */
-	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
-	    !cpus_updated && !mems_updated) {
+	if (cpuset_v2() && !cpus_updated && !mems_updated) {
 		cpuset_attach_nodemask_to = cs->effective_mems;
 		goto out;
 	}
@@ -3137,6 +3154,8 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	}
 
 	free_cpuset(trialcs);
+	if (force_sd_rebuild)
+		rebuild_sched_domains_locked();
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
@@ -3366,7 +3385,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 	INIT_LIST_HEAD(&cs->remote_sibling);
 
 	/* Set CS_MEMORY_MIGRATE for default hierarchy */
-	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
+	if (cpuset_v2())
 		__set_bit(CS_MEMORY_MIGRATE, &cs->flags);
 
 	return &cs->css;
@@ -3393,8 +3412,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	/*
 	 * For v2, clear CS_SCHED_LOAD_BALANCE if parent is isolated
 	 */
-	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
-	    !is_sched_load_balance(parent))
+	if (cpuset_v2() && !is_sched_load_balance(parent))
 		clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 
 	cpuset_inc();
@@ -3461,11 +3479,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
 
-	if (is_partition_valid(cs))
-		update_prstate(cs, 0);
-
-	if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
-	    is_sched_load_balance(cs))
+	if (!cpuset_v2() && is_sched_load_balance(cs))
 		cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
 
 	cpuset_dec();
@@ -3475,6 +3489,22 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	cpus_read_unlock();
 }
 
+static void cpuset_css_killed(struct cgroup_subsys_state *css)
+{
+	struct cpuset *cs = css_cs(css);
+
+	cpus_read_lock();
+	mutex_lock(&cpuset_mutex);
+
+	/* Reset valid partition back to member */
+	if (is_partition_valid(cs))
+		update_prstate(cs, PRS_MEMBER);
+
+	mutex_unlock(&cpuset_mutex);
+	cpus_read_unlock();
+
+}
+
 static void cpuset_css_free(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
@@ -3596,6 +3626,7 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
 	.css_alloc	= cpuset_css_alloc,
 	.css_online	= cpuset_css_online,
 	.css_offline	= cpuset_css_offline,
+	.css_killed	= cpuset_css_killed,
 	.css_free	= cpuset_css_free,
 	.can_attach	= cpuset_can_attach,
 	.cancel_attach	= cpuset_cancel_attach,
@@ -3726,6 +3757,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 
 	if (remote && cpumask_empty(&new_cpus) &&
 	    partition_is_populated(cs, NULL)) {
+		cs->prs_err = PERR_HOTPLUG;
 		remote_partition_disable(cs, tmp);
 		compute_effective_cpumask(&new_cpus, cs, parent);
 		remote = false;
@@ -3879,11 +3911,9 @@ static void cpuset_handle_hotplug(void)
 		rcu_read_unlock();
 	}
 
-	/* rebuild sched domains if cpus_allowed has changed */
-	if (force_sd_rebuild) {
-		force_sd_rebuild = false;
+	/* rebuild sched domains if necessary */
+	if (force_sd_rebuild)
 		rebuild_sched_domains_cpuslocked();
-	}
 
 	free_cpumasks(NULL, ptmp);
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b5ccf52bb71b..97af53c43608 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2146,7 +2146,7 @@ static void perf_put_aux_event(struct perf_event *event)
 
 static bool perf_need_aux_event(struct perf_event *event)
 {
-	return !!event->attr.aux_output || !!event->attr.aux_sample_size;
+	return event->attr.aux_output || has_aux_action(event);
 }
 
 static int perf_get_aux_event(struct perf_event *event,
@@ -2171,6 +2171,10 @@ static int perf_get_aux_event(struct perf_event *event,
 	    !perf_aux_output_match(event, group_leader))
 		return 0;
 
+	if ((event->attr.aux_pause || event->attr.aux_resume) &&
+	    !(group_leader->pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE))
+		return 0;
+
 	if (event->attr.aux_sample_size && !group_leader->pmu->snapshot_aux)
 		return 0;
 
@@ -5258,6 +5262,8 @@ static int exclusive_event_init(struct perf_event *event)
 			return -EBUSY;
 	}
 
+	event->attach_state |= PERF_ATTACH_EXCLUSIVE;
+
 	return 0;
 }
 
@@ -5265,14 +5271,13 @@ static void exclusive_event_destroy(struct perf_event *event)
 {
 	struct pmu *pmu = event->pmu;
 
-	if (!is_exclusive_pmu(pmu))
-		return;
-
 	/* see comment in exclusive_event_init() */
 	if (event->attach_state & PERF_ATTACH_TASK)
 		atomic_dec(&pmu->exclusive_cnt);
 	else
 		atomic_inc(&pmu->exclusive_cnt);
+
+	event->attach_state &= ~PERF_ATTACH_EXCLUSIVE;
 }
 
 static bool exclusive_event_match(struct perf_event *e1, struct perf_event *e2)
@@ -5307,35 +5312,58 @@ static bool exclusive_event_installable(struct perf_event *event,
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
 
-static void perf_pending_task_sync(struct perf_event *event)
+/* vs perf_event_alloc() error */
+static void __free_event(struct perf_event *event)
 {
-	struct callback_head *head = &event->pending_task;
+	if (event->attach_state & PERF_ATTACH_CALLCHAIN)
+		put_callchain_buffers();
+
+	kfree(event->addr_filter_ranges);
+
+	if (event->attach_state & PERF_ATTACH_EXCLUSIVE)
+		exclusive_event_destroy(event);
+
+	if (is_cgroup_event(event))
+		perf_detach_cgroup(event);
+
+	if (event->destroy)
+		event->destroy(event);
 
-	if (!event->pending_work)
-		return;
 	/*
-	 * If the task is queued to the current task's queue, we
-	 * obviously can't wait for it to complete. Simply cancel it.
+	 * Must be after ->destroy(), due to uprobe_perf_close() using
+	 * hw.target.
 	 */
-	if (task_work_cancel(current, head)) {
-		event->pending_work = 0;
-		local_dec(&event->ctx->nr_no_switch_fast);
-		return;
+	if (event->hw.target)
+		put_task_struct(event->hw.target);
+
+	if (event->pmu_ctx) {
+		/*
+		 * put_pmu_ctx() needs an event->ctx reference, because of
+		 * epc->ctx.
+		 */
+		WARN_ON_ONCE(!event->ctx);
+		WARN_ON_ONCE(event->pmu_ctx->ctx != event->ctx);
+		put_pmu_ctx(event->pmu_ctx);
 	}
 
 	/*
-	 * All accesses related to the event are within the same RCU section in
-	 * perf_pending_task(). The RCU grace period before the event is freed
-	 * will make sure all those accesses are complete by then.
+	 * perf_event_free_task() relies on put_ctx() being 'last', in
+	 * particular all task references must be cleaned up.
 	 */
-	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
+	if (event->ctx)
+		put_ctx(event->ctx);
+
+	if (event->pmu)
+		module_put(event->pmu->module);
+
+	call_rcu(&event->rcu_head, free_event_rcu);
 }
 
+/* vs perf_event_alloc() success */
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
 	irq_work_sync(&event->pending_disable_irq);
-	perf_pending_task_sync(event);
 
 	unaccount_event(event);
 
@@ -5353,42 +5381,10 @@ static void _free_event(struct perf_event *event)
 		mutex_unlock(&event->mmap_mutex);
 	}
 
-	if (is_cgroup_event(event))
-		perf_detach_cgroup(event);
-
-	if (!event->parent) {
-		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-			put_callchain_buffers();
-	}
-
 	perf_event_free_bpf_prog(event);
 	perf_addr_filters_splice(event, NULL);
-	kfree(event->addr_filter_ranges);
-
-	if (event->destroy)
-		event->destroy(event);
-
-	/*
-	 * Must be after ->destroy(), due to uprobe_perf_close() using
-	 * hw.target.
-	 */
-	if (event->hw.target)
-		put_task_struct(event->hw.target);
 
-	if (event->pmu_ctx)
-		put_pmu_ctx(event->pmu_ctx);
-
-	/*
-	 * perf_event_free_task() relies on put_ctx() being 'last', in particular
-	 * all task references must be cleaned up.
-	 */
-	if (event->ctx)
-		put_ctx(event->ctx);
-
-	exclusive_event_destroy(event);
-	module_put(event->pmu->module);
-
-	call_rcu(&event->rcu_head, free_event_rcu);
+	__free_event(event);
 }
 
 /*
@@ -5460,10 +5456,17 @@ static void perf_remove_from_owner(struct perf_event *event)
 
 static void put_event(struct perf_event *event)
 {
+	struct perf_event *parent;
+
 	if (!atomic_long_dec_and_test(&event->refcount))
 		return;
 
+	parent = event->parent;
 	_free_event(event);
+
+	/* Matches the refcount bump in inherit_event() */
+	if (parent)
+		put_event(parent);
 }
 
 /*
@@ -5547,11 +5550,6 @@ int perf_event_release_kernel(struct perf_event *event)
 		if (tmp == child) {
 			perf_remove_from_context(child, DETACH_GROUP);
 			list_move(&child->child_list, &free_list);
-			/*
-			 * This matches the refcount bump in inherit_event();
-			 * this can't be the last reference.
-			 */
-			put_event(event);
 		} else {
 			var = &ctx->refcount;
 		}
@@ -5577,7 +5575,8 @@ int perf_event_release_kernel(struct perf_event *event)
 		void *var = &child->ctx->refcount;
 
 		list_del(&child->child_list);
-		free_event(child);
+		/* Last reference unless ->pending_task work is pending */
+		put_event(child);
 
 		/*
 		 * Wake any perf_event_free_task() waiting for this event to be
@@ -5588,7 +5587,11 @@ int perf_event_release_kernel(struct perf_event *event)
 	}
 
 no_ctx:
-	put_event(event); /* Must be the 'last' reference */
+	/*
+	 * Last reference unless ->pending_task work is pending on this event
+	 * or any of its children.
+	 */
+	put_event(event);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_event_release_kernel);
@@ -6973,12 +6976,6 @@ static void perf_pending_task(struct callback_head *head)
 	struct perf_event *event = container_of(head, struct perf_event, pending_task);
 	int rctx;
 
-	/*
-	 * All accesses to the event must belong to the same implicit RCU read-side
-	 * critical section as the ->pending_work reset. See comment in
-	 * perf_pending_task_sync().
-	 */
-	rcu_read_lock();
 	/*
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
@@ -6989,9 +6986,8 @@ static void perf_pending_task(struct callback_head *head)
 		event->pending_work = 0;
 		perf_sigtrap(event);
 		local_dec(&event->ctx->nr_no_switch_fast);
-		rcuwait_wake_up(&event->pending_work_wait);
 	}
-	rcu_read_unlock();
+	put_event(event);
 
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
@@ -8029,6 +8025,49 @@ void perf_prepare_header(struct perf_event_header *header,
 	WARN_ON_ONCE(header->size & 7);
 }
 
+static void __perf_event_aux_pause(struct perf_event *event, bool pause)
+{
+	if (pause) {
+		if (!event->hw.aux_paused) {
+			event->hw.aux_paused = 1;
+			event->pmu->stop(event, PERF_EF_PAUSE);
+		}
+	} else {
+		if (event->hw.aux_paused) {
+			event->hw.aux_paused = 0;
+			event->pmu->start(event, PERF_EF_RESUME);
+		}
+	}
+}
+
+static void perf_event_aux_pause(struct perf_event *event, bool pause)
+{
+	struct perf_buffer *rb;
+
+	if (WARN_ON_ONCE(!event))
+		return;
+
+	rb = ring_buffer_get(event);
+	if (!rb)
+		return;
+
+	scoped_guard (irqsave) {
+		/*
+		 * Guard against self-recursion here. Another event could trip
+		 * this same from NMI context.
+		 */
+		if (READ_ONCE(rb->aux_in_pause_resume))
+			break;
+
+		WRITE_ONCE(rb->aux_in_pause_resume, 1);
+		barrier();
+		__perf_event_aux_pause(event, pause);
+		barrier();
+		WRITE_ONCE(rb->aux_in_pause_resume, 0);
+	}
+	ring_buffer_put(rb);
+}
+
 static __always_inline int
 __perf_event_output(struct perf_event *event,
 		    struct perf_sample_data *data,
@@ -9832,9 +9871,12 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
+	if (event->attr.aux_pause)
+		perf_event_aux_pause(event->aux_event, true);
+
 	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
 	    !bpf_overflow_handler(event, data, regs))
-		return ret;
+		goto out;
 
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
@@ -9868,6 +9910,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		    !task_work_add(current, &event->pending_task, notify_mode)) {
 			event->pending_work = pending_id;
 			local_inc(&event->ctx->nr_no_switch_fast);
+			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
 
 			event->pending_addr = 0;
 			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
@@ -9896,6 +9939,9 @@ static int __perf_event_overflow(struct perf_event *event,
 		event->pending_wakeup = 1;
 		irq_work_queue(&event->pending_irq);
 	}
+out:
+	if (event->attr.aux_resume)
+		perf_event_aux_pause(event->aux_event, false);
 
 	return ret;
 }
@@ -11961,8 +12007,10 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 			event->destroy(event);
 	}
 
-	if (ret)
+	if (ret) {
+		event->pmu = NULL;
 		module_put(pmu->module);
+	}
 
 	return ret;
 }
@@ -12211,7 +12259,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	init_irq_work(&event->pending_irq, perf_pending_irq);
 	event->pending_disable_irq = IRQ_WORK_INIT_HARD(perf_pending_disable);
 	init_task_work(&event->pending_task, perf_pending_task);
-	rcuwait_init(&event->pending_work_wait);
 
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
@@ -12290,7 +12337,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	 * See perf_output_read().
 	 */
 	if (has_inherit_and_sample_read(attr) && !(attr->sample_type & PERF_SAMPLE_TID))
-		goto err_ns;
+		goto err;
 
 	if (!has_branch_stack(event))
 		event->attr.branch_sample_type = 0;
@@ -12298,7 +12345,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	pmu = perf_init_event(event);
 	if (IS_ERR(pmu)) {
 		err = PTR_ERR(pmu);
-		goto err_ns;
+		goto err;
 	}
 
 	/*
@@ -12308,24 +12355,38 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	 */
 	if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1)) {
 		err = -EINVAL;
-		goto err_pmu;
+		goto err;
 	}
 
 	if (event->attr.aux_output &&
-	    !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT)) {
+	    (!(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT) ||
+	     event->attr.aux_pause || event->attr.aux_resume)) {
 		err = -EOPNOTSUPP;
-		goto err_pmu;
+		goto err;
+	}
+
+	if (event->attr.aux_pause && event->attr.aux_resume) {
+		err = -EINVAL;
+		goto err;
+	}
+
+	if (event->attr.aux_start_paused) {
+		if (!(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE)) {
+			err = -EOPNOTSUPP;
+			goto err;
+		}
+		event->hw.aux_paused = 1;
 	}
 
 	if (cgroup_fd != -1) {
 		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
 		if (err)
-			goto err_pmu;
+			goto err;
 	}
 
 	err = exclusive_event_init(event);
 	if (err)
-		goto err_pmu;
+		goto err;
 
 	if (has_addr_filter(event)) {
 		event->addr_filter_ranges = kcalloc(pmu->nr_addr_filters,
@@ -12333,7 +12394,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 						    GFP_KERNEL);
 		if (!event->addr_filter_ranges) {
 			err = -ENOMEM;
-			goto err_per_task;
+			goto err;
 		}
 
 		/*
@@ -12358,41 +12419,22 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
 			err = get_callchain_buffers(attr->sample_max_stack);
 			if (err)
-				goto err_addr_filters;
+				goto err;
+			event->attach_state |= PERF_ATTACH_CALLCHAIN;
 		}
 	}
 
 	err = security_perf_event_alloc(event);
 	if (err)
-		goto err_callchain_buffer;
+		goto err;
 
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
 	return event;
 
-err_callchain_buffer:
-	if (!event->parent) {
-		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-			put_callchain_buffers();
-	}
-err_addr_filters:
-	kfree(event->addr_filter_ranges);
-
-err_per_task:
-	exclusive_event_destroy(event);
-
-err_pmu:
-	if (is_cgroup_event(event))
-		perf_detach_cgroup(event);
-	if (event->destroy)
-		event->destroy(event);
-	module_put(pmu->module);
-err_ns:
-	if (event->hw.target)
-		put_task_struct(event->hw.target);
-	call_rcu(&event->rcu_head, free_event_rcu);
-
+err:
+	__free_event(event);
 	return ERR_PTR(err);
 }
 
@@ -13112,7 +13154,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 	 * Grouping is not supported for kernel events, neither is 'AUX',
 	 * make sure the caller's intentions are adjusted.
 	 */
-	if (attr->aux_output)
+	if (attr->aux_output || attr->aux_action)
 		return ERR_PTR(-EINVAL);
 
 	event = perf_event_alloc(attr, cpu, task, NULL, NULL,
@@ -13359,8 +13401,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		 * Kick perf_poll() for is_event_hup();
 		 */
 		perf_event_wakeup(parent_event);
-		free_event(event);
-		put_event(parent_event);
+		put_event(event);
 		return;
 	}
 
@@ -13478,13 +13519,11 @@ static void perf_free_event(struct perf_event *event,
 	list_del_init(&event->child_list);
 	mutex_unlock(&parent->child_mutex);
 
-	put_event(parent);
-
 	raw_spin_lock_irq(&ctx->lock);
 	perf_group_detach(event);
 	list_del_event(event, ctx);
 	raw_spin_unlock_irq(&ctx->lock);
-	free_event(event);
+	put_event(event);
 }
 
 /*
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index e072d995d670..249288d82b8d 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -52,6 +52,7 @@ struct perf_buffer {
 	void				(*free_aux)(void *);
 	refcount_t			aux_refcount;
 	int				aux_in_sampling;
+	int				aux_in_pause_resume;
 	void				**aux_pages;
 	void				*aux_priv;
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 536bd471557f..53c76dc71f3f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6223,6 +6223,9 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 		hlist_del_rcu(&class->hash_entry);
 		WRITE_ONCE(class->key, NULL);
 		WRITE_ONCE(class->name, NULL);
+		/* Class allocated but not used, -1 in nr_unused_locks */
+		if (class->usage_mask == 0)
+			debug_atomic_dec(nr_unused_locks);
 		nr_lock_classes--;
 		__clear_bit(class - lock_classes, lock_classes_in_use);
 		if (class - lock_classes == max_lock_class_idx)
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index b483fcea811b..d8bad1eeedd3 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1443,10 +1443,10 @@ static const char * const comp_alg_enabled[] = {
 static int hibernate_compressor_param_set(const char *compressor,
 		const struct kernel_param *kp)
 {
-	unsigned int sleep_flags;
 	int index, ret;
 
-	sleep_flags = lock_system_sleep();
+	if (!mutex_trylock(&system_transition_mutex))
+		return -EBUSY;
 
 	index = sysfs_match_string(comp_alg_enabled, compressor);
 	if (index >= 0) {
@@ -1458,7 +1458,7 @@ static int hibernate_compressor_param_set(const char *compressor,
 		ret = index;
 	}
 
-	unlock_system_sleep(sleep_flags);
+	mutex_unlock(&system_transition_mutex);
 
 	if (ret)
 		pr_debug("Cannot set specified compressor %s\n",
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3b75f6e8410b..881a26e18c65 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2436,7 +2436,6 @@ asmlinkage __visible int _printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(_printk);
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress);
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
 #else /* CONFIG_PRINTK */
@@ -2449,7 +2448,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 static u64 syslog_seq;
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
 #endif /* CONFIG_PRINTK */
@@ -4436,7 +4434,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
  * Context: Process context. May sleep while acquiring console lock.
  * Return: true if all usable printers are caught up.
  */
-static bool pr_flush(int timeout_ms, bool reset_on_progress)
+bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return __pr_flush(NULL, timeout_ms, reset_on_progress);
 }
diff --git a/kernel/reboot.c b/kernel/reboot.c
index f05dbde2c93f..d6ee090eda94 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -697,6 +697,7 @@ void kernel_power_off(void)
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	pr_emerg("Power down\n");
+	pr_flush(1000, true);
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_power_off();
 }
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e5cab54dfdd1..fcf968490308 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4160,8 +4160,8 @@ static struct scx_dispatch_q *create_dsq(u64 dsq_id, int node)
 
 	init_dsq(dsq, dsq_id);
 
-	ret = rhashtable_insert_fast(&dsq_hash, &dsq->hash_node,
-				     dsq_hash_params);
+	ret = rhashtable_lookup_insert_fast(&dsq_hash, &dsq->hash_node,
+					    dsq_hash_params);
 	if (ret) {
 		kfree(dsq);
 		return ERR_PTR(ret);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index dbd375f28ee0..90b59c627bb8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3523,16 +3523,16 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
 	    ftrace_hash_empty(subops->func_hash->notrace_hash)) {
 		notrace_hash = EMPTY_HASH;
 	} else {
-		size_bits = max(ops->func_hash->filter_hash->size_bits,
-				subops->func_hash->filter_hash->size_bits);
+		size_bits = max(ops->func_hash->notrace_hash->size_bits,
+				subops->func_hash->notrace_hash->size_bits);
 		notrace_hash = alloc_ftrace_hash(size_bits);
 		if (!notrace_hash) {
 			free_ftrace_hash(filter_hash);
 			return -ENOMEM;
 		}
 
-		ret = intersect_hash(&notrace_hash, ops->func_hash->filter_hash,
-				     subops->func_hash->filter_hash);
+		ret = intersect_hash(&notrace_hash, ops->func_hash->notrace_hash,
+				     subops->func_hash->notrace_hash);
 		if (ret < 0) {
 			free_ftrace_hash(filter_hash);
 			free_ftrace_hash(notrace_hash);
@@ -6848,6 +6848,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 				}
 			}
 		}
+		cond_resched();
 	} while_for_each_ftrace_rec();
 out:
 	mutex_unlock(&ftrace_lock);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3e252ba16d5c..e1ffbed8cc5e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5994,7 +5994,7 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 	meta->read = cpu_buffer->read;
 
 	/* Some archs do not have data cache coherency between kernel and user-space */
-	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
+	flush_kernel_vmap_range(cpu_buffer->meta_page, PAGE_SIZE);
 }
 
 static void
@@ -7309,7 +7309,8 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 
 out:
 	/* Some archs do not have data cache coherency between kernel and user-space */
-	flush_dcache_folio(virt_to_folio(cpu_buffer->reader_page->page));
+	flush_kernel_vmap_range(cpu_buffer->reader_page->page,
+				buffer->subbuf_size + BUF_PAGE_HDR_SIZE);
 
 	rb_update_meta_page(cpu_buffer);
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 29eba68e0785..11dea25ef880 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -790,7 +790,9 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
 			}
 
-			call->class->reg(call, TRACE_REG_UNREGISTER, file);
+			ret = call->class->reg(call, TRACE_REG_UNREGISTER, file);
+
+			WARN_ON_ONCE(ret);
 		}
 		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
 		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 24c9962c40db..1b9e32f6442f 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -377,7 +377,6 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 				union trace_synth_field *data = &entry->fields[n_u64];
 
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
-						 STR_VAR_LEN_MAX,
 						 (char *)entry + data->as_dynamic.offset,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64++;
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 4acdab165793..af7d6e2060d9 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -888,9 +888,15 @@ static void __find_tracepoint_module_cb(struct tracepoint *tp, struct module *mo
 	struct __find_tracepoint_cb_data *data = priv;
 
 	if (!data->tpoint && !strcmp(data->tp_name, tp->name)) {
-		data->tpoint = tp;
-		if (!data->mod)
+		/* If module is not specified, try getting module refcount. */
+		if (!data->mod && mod) {
+			/* If failed to get refcount, ignore this tracepoint. */
+			if (!try_module_get(mod))
+				return;
+
 			data->mod = mod;
+		}
+		data->tpoint = tp;
 	}
 }
 
@@ -902,7 +908,11 @@ static void __find_tracepoint_cb(struct tracepoint *tp, void *priv)
 		data->tpoint = tp;
 }
 
-/* Find a tracepoint from kernel and module. */
+/*
+ * Find a tracepoint from kernel and module. If the tracepoint is on the module,
+ * the module's refcount is incremented and returned as *@tp_mod. Thus, if it is
+ * not NULL, caller must call module_put(*tp_mod) after used the tracepoint.
+ */
 static struct tracepoint *find_tracepoint(const char *tp_name,
 					  struct module **tp_mod)
 {
@@ -931,7 +941,10 @@ static void reenable_trace_fprobe(struct trace_fprobe *tf)
 	}
 }
 
-/* Find a tracepoint from specified module. */
+/*
+ * Find a tracepoint from specified module. In this case, this does not get the
+ * module's refcount. The caller must ensure the module is not freed.
+ */
 static struct tracepoint *find_tracepoint_in_module(struct module *mod,
 						    const char *tp_name)
 {
@@ -1167,11 +1180,6 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	if (is_tracepoint) {
 		ctx.flags |= TPARG_FL_TPOINT;
 		tpoint = find_tracepoint(symbol, &tp_mod);
-		/* lock module until register this tprobe. */
-		if (tp_mod && !try_module_get(tp_mod)) {
-			tpoint = NULL;
-			tp_mod = NULL;
-		}
 		if (tpoint) {
 			ctx.funcname = kallsyms_lookup(
 				(unsigned long)tpoint->probestub,
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 16a5e368e7b7..578919962e5d 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -770,6 +770,10 @@ static int check_prepare_btf_string_fetch(char *typename,
 
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 
+/*
+ * Add the entry code to store the 'argnum'th parameter and return the offset
+ * in the entry data buffer where the data will be stored.
+ */
 static int __store_entry_arg(struct trace_probe *tp, int argnum)
 {
 	struct probe_entry_arg *earg = tp->entry_arg;
@@ -793,6 +797,20 @@ static int __store_entry_arg(struct trace_probe *tp, int argnum)
 		tp->entry_arg = earg;
 	}
 
+	/*
+	 * The entry code array is repeating the pair of
+	 * [FETCH_OP_ARG(argnum)][FETCH_OP_ST_EDATA(offset of entry data buffer)]
+	 * and the rest of entries are filled with [FETCH_OP_END].
+	 *
+	 * To reduce the redundant function parameter fetching, we scan the entry
+	 * code array to find the FETCH_OP_ARG which already fetches the 'argnum'
+	 * parameter. If it doesn't match, update 'offset' to find the last
+	 * offset.
+	 * If we find the FETCH_OP_END without matching FETCH_OP_ARG entry, we
+	 * will save the entry with FETCH_OP_ARG and FETCH_OP_ST_EDATA, and
+	 * return data offset so that caller can find the data offset in the entry
+	 * data buffer.
+	 */
 	offset = 0;
 	for (i = 0; i < earg->size - 1; i++) {
 		switch (earg->code[i].op) {
@@ -826,6 +844,16 @@ int traceprobe_get_entry_data_size(struct trace_probe *tp)
 	if (!earg)
 		return 0;
 
+	/*
+	 * earg->code[] array has an operation sequence which is run in
+	 * the entry handler.
+	 * The sequence stopped by FETCH_OP_END and each data stored in
+	 * the entry data buffer by FETCH_OP_ST_EDATA. The FETCH_OP_ST_EDATA
+	 * stores the data at the data buffer + its offset, and all data are
+	 * "unsigned long" size. The offset must be increased when a data is
+	 * stored. Thus we need to find the last FETCH_OP_ST_EDATA in the
+	 * code array.
+	 */
 	for (i = 0; i < earg->size; i++) {
 		switch (earg->code[i].op) {
 		case FETCH_OP_END:
diff --git a/lib/sg_split.c b/lib/sg_split.c
index 60a0babebf2e..0f89aab5c671 100644
--- a/lib/sg_split.c
+++ b/lib/sg_split.c
@@ -88,8 +88,6 @@ static void sg_split_phys(struct sg_splitter *splitters, const int nb_splits)
 			if (!j) {
 				out_sg->offset += split->skip_sg0;
 				out_sg->length -= split->skip_sg0;
-			} else {
-				out_sg->offset = 0;
 			}
 			sg_dma_address(out_sg) = 0;
 			sg_dma_len(out_sg) = 0;
diff --git a/lib/zstd/common/portability_macros.h b/lib/zstd/common/portability_macros.h
index 0e3b2c0a527d..0dde8bf56595 100644
--- a/lib/zstd/common/portability_macros.h
+++ b/lib/zstd/common/portability_macros.h
@@ -55,7 +55,7 @@
 #ifndef DYNAMIC_BMI2
   #if ((defined(__clang__) && __has_attribute(__target__)) \
       || (defined(__GNUC__) \
-          && (__GNUC__ >= 5 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 8)))) \
+          && (__GNUC__ >= 11))) \
       && (defined(__x86_64__) || defined(_M_X64)) \
       && !defined(__BMI2__)
   #  define DYNAMIC_BMI2 1
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index d25d99cb5f2b..d511be201c4c 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -24,7 +24,7 @@ struct folio *damon_get_folio(unsigned long pfn)
 	struct page *page = pfn_to_online_page(pfn);
 	struct folio *folio;
 
-	if (!page || PageTail(page))
+	if (!page)
 		return NULL;
 
 	folio = page_folio(page);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index a9ff35341d65..8813038abc6f 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -264,11 +264,14 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 		damos_add_filter(s, filter);
 	}
 
-	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+	addr = r->ar.start;
+	while (addr < r->ar.end) {
 		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
-		if (!folio)
+		if (!folio) {
+			addr += PAGE_SIZE;
 			continue;
+		}
 
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
@@ -282,6 +285,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 		else
 			list_add(&folio->lru, &folio_list);
 put_folio:
+		addr += folio_size(folio);
 		folio_put(folio);
 	}
 	if (install_young_filter)
@@ -296,11 +300,14 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 {
 	unsigned long addr, applied = 0;
 
-	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+	addr = r->ar.start;
+	while (addr < r->ar.end) {
 		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
-		if (!folio)
+		if (!folio) {
+			addr += PAGE_SIZE;
 			continue;
+		}
 
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
@@ -311,6 +318,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 			folio_deactivate(folio);
 		applied += folio_nr_pages(folio);
 put_folio:
+		addr += folio_size(folio);
 		folio_put(folio);
 	}
 	return applied * PAGE_SIZE;
@@ -454,11 +462,14 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s)
 	unsigned long addr, applied;
 	LIST_HEAD(folio_list);
 
-	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+	addr = r->ar.start;
+	while (addr < r->ar.end) {
 		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
-		if (!folio)
+		if (!folio) {
+			addr += PAGE_SIZE;
 			continue;
+		}
 
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
@@ -467,6 +478,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s)
 			goto put_folio;
 		list_add(&folio->lru, &folio_list);
 put_folio:
+		addr += folio_size(folio);
 		folio_put(folio);
 	}
 	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e28e820fdb77..ad646fe6688a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4863,7 +4863,7 @@ static struct ctl_table hugetlb_table[] = {
 	},
 };
 
-static void hugetlb_sysctl_init(void)
+static void __init hugetlb_sysctl_init(void)
 {
 	register_sysctl_init("vm", hugetlb_table);
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fa25a022e64d..ec1c71abe88d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -879,12 +879,17 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 	mmap_read_lock(p->mm);
 	ret = walk_page_range(p->mm, 0, TASK_SIZE, &hwpoison_walk_ops,
 			      (void *)&priv);
+	/*
+	 * ret = 1 when CMCI wins, regardless of whether try_to_unmap()
+	 * succeeds or fails, then kill the process with SIGBUS.
+	 * ret = 0 when poison page is a clean page and it's dropped, no
+	 * SIGBUS is needed.
+	 */
 	if (ret == 1 && priv.tk.addr)
 		kill_proc(&priv.tk, pfn, flags);
-	else
-		ret = 0;
 	mmap_read_unlock(p->mm);
-	return ret > 0 ? -EHWPOISON : -EFAULT;
+
+	return ret > 0 ? -EHWPOISON : 0;
 }
 
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 619445096ef4..0a42e9a8caba 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1801,8 +1801,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		if (unlikely(page_folio(page) != folio))
 			goto put_folio;
 
-		if (folio_test_hwpoison(folio) ||
-		    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio))) {
+		if (folio_contain_hwpoisoned_page(folio)) {
 			if (WARN_ON(folio_test_lru(folio)))
 				folio_isolate_lru(folio);
 			if (folio_mapped(folio)) {
diff --git a/mm/mremap.c b/mm/mremap.c
index 1b2edd65c2a1..12af89b4342a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -696,8 +696,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	unsigned long vm_flags = vma->vm_flags;
 	unsigned long new_pgoff;
 	unsigned long moved_len;
-	unsigned long account_start = 0;
-	unsigned long account_end = 0;
+	bool account_start = false;
+	bool account_end = false;
 	unsigned long hiwater_vm;
 	int err = 0;
 	bool need_rmap_locks;
@@ -781,9 +781,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
 		vm_flags_clear(vma, VM_ACCOUNT);
 		if (vma->vm_start < old_addr)
-			account_start = vma->vm_start;
+			account_start = true;
 		if (vma->vm_end > old_addr + old_len)
-			account_end = vma->vm_end;
+			account_end = true;
 	}
 
 	/*
@@ -823,7 +823,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);
-		account_start = account_end = 0;
+		account_start = account_end = false;
 	}
 
 	if (vm_flags & VM_LOCKED) {
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index ae5cc42aa208..585a53f7b06f 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -77,6 +77,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
  * mapped at the @pvmw->pte
  * @pvmw: page_vma_mapped_walk struct, includes a pair pte and pfn range
  * for checking
+ * @pte_nr: the number of small pages described by @pvmw->pte.
  *
  * page_vma_mapped_walk() found a place where pfn range is *potentially*
  * mapped. check_pte() has to validate this.
@@ -93,7 +94,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
  * Otherwise, return false.
  *
  */
-static bool check_pte(struct page_vma_mapped_walk *pvmw)
+static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
 {
 	unsigned long pfn;
 	pte_t ptent = ptep_get(pvmw->pte);
@@ -126,7 +127,11 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 		pfn = pte_pfn(ptent);
 	}
 
-	return (pfn - pvmw->pfn) < pvmw->nr_pages;
+	if ((pfn + pte_nr - 1) < pvmw->pfn)
+		return false;
+	if (pfn > (pvmw->pfn + pvmw->nr_pages - 1))
+		return false;
+	return true;
 }
 
 /* Returns true if the two ranges overlap.  Careful to not overflow. */
@@ -201,7 +206,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			return false;
 
 		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
-		if (!check_pte(pvmw))
+		if (!check_pte(pvmw, pages_per_huge_page(hstate)))
 			return not_found(pvmw);
 		return true;
 	}
@@ -284,7 +289,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			goto next_pte;
 		}
 this_pte:
-		if (check_pte(pvmw))
+		if (check_pte(pvmw, 1))
 			return true;
 next_pte:
 		do {
diff --git a/mm/rmap.c b/mm/rmap.c
index 73d5998677d4..674362de029d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2488,7 +2488,7 @@ static bool folio_make_device_exclusive(struct folio *folio,
 	 * Restrict to anonymous folios for now to avoid potential writeback
 	 * issues.
 	 */
-	if (!folio_test_anon(folio))
+	if (!folio_test_anon(folio) || folio_test_hugetlb(folio))
 		return false;
 
 	rmap_walk(folio, &rwc);
diff --git a/mm/shmem.c b/mm/shmem.c
index 5960e5035f98..88fd6e2a2dcf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3042,8 +3042,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 	if (ret)
 		return ret;
 
-	if (folio_test_hwpoison(folio) ||
-	    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio))) {
+	if (folio_contain_hwpoisoned_page(folio)) {
 		folio_unlock(folio);
 		folio_put(folio);
 		return -EIO;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 77d015d5db0c..39b3c7f35ea8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7557,7 +7557,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 		return NODE_RECLAIM_NOSCAN;
 
 	ret = __node_reclaim(pgdat, gfp_mask, order);
-	clear_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
+	clear_bit_unlock(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
 
 	if (ret)
 		count_vm_event(PGSCAN_ZONE_RECLAIM_SUCCESS);
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 458040e8a0e0..9184cf7eb128 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -273,17 +273,6 @@ static int vlan_dev_open(struct net_device *dev)
 			goto out;
 	}
 
-	if (dev->flags & IFF_ALLMULTI) {
-		err = dev_set_allmulti(real_dev, 1);
-		if (err < 0)
-			goto del_unicast;
-	}
-	if (dev->flags & IFF_PROMISC) {
-		err = dev_set_promiscuity(real_dev, 1);
-		if (err < 0)
-			goto clear_allmulti;
-	}
-
 	ether_addr_copy(vlan->real_dev_addr, real_dev->dev_addr);
 
 	if (vlan->flags & VLAN_FLAG_GVRP)
@@ -297,12 +286,6 @@ static int vlan_dev_open(struct net_device *dev)
 		netif_carrier_on(dev);
 	return 0;
 
-clear_allmulti:
-	if (dev->flags & IFF_ALLMULTI)
-		dev_set_allmulti(real_dev, -1);
-del_unicast:
-	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
-		dev_uc_del(real_dev, dev->dev_addr);
 out:
 	netif_carrier_off(dev);
 	return err;
@@ -315,10 +298,6 @@ static int vlan_dev_stop(struct net_device *dev)
 
 	dev_mc_unsync(real_dev, dev);
 	dev_uc_unsync(real_dev, dev);
-	if (dev->flags & IFF_ALLMULTI)
-		dev_set_allmulti(real_dev, -1);
-	if (dev->flags & IFF_PROMISC)
-		dev_set_promiscuity(real_dev, -1);
 
 	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
 		dev_uc_del(real_dev, dev->dev_addr);
@@ -490,12 +469,10 @@ static void vlan_dev_change_rx_flags(struct net_device *dev, int change)
 {
 	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
 
-	if (dev->flags & IFF_UP) {
-		if (change & IFF_ALLMULTI)
-			dev_set_allmulti(real_dev, dev->flags & IFF_ALLMULTI ? 1 : -1);
-		if (change & IFF_PROMISC)
-			dev_set_promiscuity(real_dev, dev->flags & IFF_PROMISC ? 1 : -1);
-	}
+	if (change & IFF_ALLMULTI)
+		dev_set_allmulti(real_dev, dev->flags & IFF_ALLMULTI ? 1 : -1);
+	if (change & IFF_PROMISC)
+		dev_set_promiscuity(real_dev, dev->flags & IFF_PROMISC ? 1 : -1);
 }
 
 static void vlan_dev_set_rx_mode(struct net_device *vlan_dev)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7b2b04d6b856..cb4d47ae129e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3720,6 +3720,9 @@ static int hci_read_local_name_sync(struct hci_dev *hdev)
 /* Read Voice Setting */
 static int hci_read_voice_setting_sync(struct hci_dev *hdev)
 {
+	if (!read_voice_setting_capable(hdev))
+		return 0;
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_READ_VOICE_SETTING,
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
@@ -4153,7 +4156,8 @@ static int hci_read_page_scan_type_sync(struct hci_dev *hdev)
 	 * support the Read Page Scan Type command. Check support for
 	 * this command in the bit mask of supported commands.
 	 */
-	if (!(hdev->commands[13] & 0x01))
+	if (!(hdev->commands[13] & 0x01) ||
+	    test_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quirks))
 		return 0;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_READ_PAGE_SCAN_TYPE,
diff --git a/net/core/filter.c b/net/core/filter.c
index a2f990bf51e5..790345c2546b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -218,24 +218,36 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_buff *, skb, u32, a, u32, x)
 	return 0;
 }
 
+static int bpf_skb_load_helper_convert_offset(const struct sk_buff *skb, int offset)
+{
+	if (likely(offset >= 0))
+		return offset;
+
+	if (offset >= SKF_NET_OFF)
+		return offset - SKF_NET_OFF + skb_network_offset(skb);
+
+	if (offset >= SKF_LL_OFF && skb_mac_header_was_set(skb))
+		return offset - SKF_LL_OFF + skb_mac_offset(skb);
+
+	return INT_MIN;
+}
+
 BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	u8 tmp, *ptr;
+	u8 tmp;
 	const int len = sizeof(tmp);
 
-	if (offset >= 0) {
-		if (headlen - offset >= len)
-			return *(u8 *)(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return tmp;
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return *(u8 *)ptr;
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return *(u8 *)(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return tmp;
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
@@ -248,21 +260,19 @@ BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_16, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	__be16 tmp, *ptr;
+	__be16 tmp;
 	const int len = sizeof(tmp);
 
-	if (offset >= 0) {
-		if (headlen - offset >= len)
-			return get_unaligned_be16(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return be16_to_cpu(tmp);
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return get_unaligned_be16(ptr);
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return get_unaligned_be16(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return be16_to_cpu(tmp);
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
@@ -275,21 +285,19 @@ BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_32, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	__be32 tmp, *ptr;
+	__be32 tmp;
 	const int len = sizeof(tmp);
 
-	if (likely(offset >= 0)) {
-		if (headlen - offset >= len)
-			return get_unaligned_be32(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return be32_to_cpu(tmp);
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return get_unaligned_be32(ptr);
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return get_unaligned_be32(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return be32_to_cpu(tmp);
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_32_no_cache, const struct sk_buff *, skb,
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a813d30d2135..7b20f6fcb82c 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1066,7 +1066,13 @@ static void page_pool_release_retry(struct work_struct *wq)
 	int inflight;
 
 	inflight = page_pool_release(pool);
-	if (!inflight)
+	/* In rare cases, a driver bug may cause inflight to go negative.
+	 * Don't reschedule release if inflight is 0 or negative.
+	 * - If 0, the page_pool has been destroyed
+	 * - if negative, we will never recover
+	 * in both cases no reschedule is necessary.
+	 */
+	if (inflight <= 0)
 		return;
 
 	/* Periodic warning for page pools the user can't see */
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 48335766c1bf..8d31c71bea1a 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -353,7 +353,7 @@ void page_pool_unlist(struct page_pool *pool)
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq)
 {
-	struct net_devmem_dmabuf_binding *binding = rxq->mp_params.mp_priv;
+	void *binding = rxq->mp_params.mp_priv;
 	struct page_pool *pool;
 	struct hlist_node *n;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index a83f64a1d96a..0842dc9189bf 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2107,6 +2107,8 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
  */
 static inline void sock_lock_init(struct sock *sk)
 {
+	sk_owner_clear(sk);
+
 	if (sk->sk_kern_sock)
 		sock_lock_init_class_and_name(
 			sk,
@@ -2203,6 +2205,9 @@ static void sk_prot_free(struct proto *prot, struct sock *sk)
 	cgroup_sk_free(&sk->sk_cgrp_data);
 	mem_cgroup_sk_free(sk);
 	security_sk_free(sk);
+
+	sk_owner_put(sk);
+
 	if (slab != NULL)
 		kmem_cache_free(slab, sk);
 	else
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index e233dfc8ca4b..a52be67139d0 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -490,7 +490,7 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 	ret = ops->prepare_data(req_info, reply_data, info);
 	rtnl_unlock();
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_dev;
 	ret = ops->reply_size(req_info, reply_data);
 	if (ret < 0)
 		goto err_cleanup;
@@ -548,7 +548,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 	ret = ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, info);
 	rtnl_unlock();
 	if (ret < 0)
-		goto out;
+		goto out_cancel;
 	ret = ethnl_fill_reply_header(skb, dev, ctx->ops->hdr_attr);
 	if (ret < 0)
 		goto out;
@@ -557,6 +557,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 out:
 	if (ctx->ops->cleanup_data)
 		ctx->ops->cleanup_data(ctx->reply_data);
+out_cancel:
 	ctx->reply_data->dev = NULL;
 	if (ret < 0)
 		genlmsg_cancel(skb, ehdr);
@@ -760,7 +761,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 	ethnl_init_reply_data(reply_data, ops, dev);
 	ret = ops->prepare_data(req_info, reply_data, &info);
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_rep;
 	ret = ops->reply_size(req_info, reply_data);
 	if (ret < 0)
 		goto err_cleanup;
@@ -795,6 +796,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 err_cleanup:
 	if (ops->cleanup_data)
 		ops->cleanup_data(reply_data);
+err_rep:
 	kfree(reply_data);
 	kfree(req_info);
 	return;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 987492dcb07c..bae8ece3e881 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -470,10 +470,10 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 		goto out;
 
 	hash = fl6->mp_hash;
-	if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
-	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
-			    strict) >= 0) {
-		match = first;
+	if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound)) {
+		if (rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
+				    strict) >= 0)
+			match = first;
 		goto out;
 	}
 
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 02b5476a4376..a0710ae0e7a4 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -499,6 +499,7 @@ static const char *hw_flag_names[] = {
 	FLAG(DISALLOW_PUNCTURING),
 	FLAG(DISALLOW_PUNCTURING_5GHZ),
 	FLAG(HANDLES_QUIET_CSA),
+	FLAG(STRICT),
 #undef FLAG
 };
 
@@ -531,6 +532,46 @@ static ssize_t hwflags_read(struct file *file, char __user *user_buf,
 	return rv;
 }
 
+static ssize_t hwflags_write(struct file *file, const char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	char buf[100];
+	int val;
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	else
+		buf[count] = '\0';
+
+	if (sscanf(buf, "strict=%d", &val) == 1) {
+		switch (val) {
+		case 0:
+			ieee80211_hw_set(&local->hw, STRICT);
+			return count;
+		case 1:
+			__clear_bit(IEEE80211_HW_STRICT, local->hw.flags);
+			return count;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const struct file_operations hwflags_ops = {
+	.open = simple_open,
+	.read = hwflags_read,
+	.write = hwflags_write,
+};
+
 static ssize_t misc_read(struct file *file, char __user *user_buf,
 			 size_t count, loff_t *ppos)
 {
@@ -581,7 +622,6 @@ static ssize_t queues_read(struct file *file, char __user *user_buf,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, res);
 }
 
-DEBUGFS_READONLY_FILE_OPS(hwflags);
 DEBUGFS_READONLY_FILE_OPS(queues);
 DEBUGFS_READONLY_FILE_OPS(misc);
 
@@ -659,7 +699,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 #ifdef CONFIG_PM
 	DEBUGFS_ADD_MODE(reset, 0200);
 #endif
-	DEBUGFS_ADD(hwflags);
+	DEBUGFS_ADD_MODE(hwflags, 0600);
 	DEBUGFS_ADD(user_power);
 	DEBUGFS_ADD(power);
 	DEBUGFS_ADD(hw_conf);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 8bbfa45e1796..dbcd75c5d778 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -8,7 +8,7 @@
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (c) 2016        Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -812,6 +812,9 @@ static void ieee80211_set_multicast_list(struct net_device *dev)
  */
 static void ieee80211_teardown_sdata(struct ieee80211_sub_if_data *sdata)
 {
+	if (WARN_ON(!list_empty(&sdata->work.entry)))
+		wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->work);
+
 	/* free extra data */
 	ieee80211_free_keys(sdata, false);
 
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 579d0f24ac9d..2922a9fec950 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -367,6 +367,12 @@ u32 airtime_link_metric_get(struct ieee80211_local *local,
 	return (u32)result;
 }
 
+/* Check that the first metric is at least 10% better than the second one */
+static bool is_metric_better(u32 x, u32 y)
+{
+	return (x < y) && (x < (y - x / 10));
+}
+
 /**
  * hwmp_route_info_get - Update routing info to originator and transmitter
  *
@@ -458,8 +464,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 				    (mpath->sn == orig_sn &&
 				     (rcu_access_pointer(mpath->next_hop) !=
 						      sta ?
-					      mult_frac(new_metric, 10, 9) :
-					      new_metric) >= mpath->metric)) {
+					      !is_metric_better(new_metric, mpath->metric) :
+					      new_metric >= mpath->metric))) {
 					process = false;
 					fresh_info = false;
 				}
@@ -533,8 +539,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 			if ((mpath->flags & MESH_PATH_FIXED) ||
 			    ((mpath->flags & MESH_PATH_ACTIVE) &&
 			     ((rcu_access_pointer(mpath->next_hop) != sta ?
-				       mult_frac(last_hop_metric, 10, 9) :
-				       last_hop_metric) > mpath->metric)))
+				      !is_metric_better(last_hop_metric, mpath->metric) :
+				       last_hop_metric > mpath->metric))))
 				fresh_info = false;
 		} else {
 			mpath = mesh_path_add(sdata, ta);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 88751b0eb317..ad0d040569dc 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -166,6 +166,9 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 	bool no_vht = false;
 	u32 ht_cfreq;
 
+	if (ieee80211_hw_check(&sdata->local->hw, STRICT))
+		ignore_ht_channel_mismatch = false;
+
 	*chandef = (struct cfg80211_chan_def) {
 		.chan = channel,
 		.width = NL80211_CHAN_WIDTH_20_NOHT,
@@ -385,7 +388,7 @@ ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 	 * zeroes, which is nonsense, and completely inconsistent with itself
 	 * (it doesn't have 8 streams). Accept the settings in this case anyway.
 	 */
-	if (!ap_min_req_set)
+	if (!ieee80211_hw_check(&sdata->local->hw, STRICT) && !ap_min_req_set)
 		return true;
 
 	/* make sure the AP is consistent with itself
@@ -445,7 +448,7 @@ ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 	 * zeroes, which is nonsense, and completely inconsistent with itself
 	 * (it doesn't have 8 streams). Accept the settings in this case anyway.
 	 */
-	if (!ap_min_req_set)
+	if (!ieee80211_hw_check(&sdata->local->hw, STRICT) && !ap_min_req_set)
 		return true;
 
 	/* Need to go over for 80MHz, 160MHz and for 80+80 */
@@ -1212,13 +1215,15 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 	 * Some APs apparently get confused if our capabilities are better
 	 * than theirs, so restrict what we advertise in the assoc request.
 	 */
-	if (!(ap_vht_cap->vht_cap_info &
-			cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)))
-		cap &= ~(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
-			 IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
-	else if (!(ap_vht_cap->vht_cap_info &
-			cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE)))
-		cap &= ~IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
+	if (!ieee80211_hw_check(&local->hw, STRICT)) {
+		if (!(ap_vht_cap->vht_cap_info &
+				cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)))
+			cap &= ~(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+				 IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
+		else if (!(ap_vht_cap->vht_cap_info &
+				cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE)))
+			cap &= ~IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
+	}
 
 	/*
 	 * If some other vif is using the MU-MIMO capability we cannot associate
@@ -1260,14 +1265,16 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 	return mu_mimo_owner;
 }
 
-static void ieee80211_assoc_add_rates(struct sk_buff *skb,
+static void ieee80211_assoc_add_rates(struct ieee80211_local *local,
+				      struct sk_buff *skb,
 				      enum nl80211_chan_width width,
 				      struct ieee80211_supported_band *sband,
 				      struct ieee80211_mgd_assoc_data *assoc_data)
 {
 	u32 rates;
 
-	if (assoc_data->supp_rates_len) {
+	if (assoc_data->supp_rates_len &&
+	    !ieee80211_hw_check(&local->hw, STRICT)) {
 		/*
 		 * Get all rates supported by the device and the AP as
 		 * some APs don't like getting a superset of their rates
@@ -1481,7 +1488,7 @@ static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
 		*capab |= WLAN_CAPABILITY_SPECTRUM_MGMT;
 
 	if (sband->band != NL80211_BAND_S1GHZ)
-		ieee80211_assoc_add_rates(skb, width, sband, assoc_data);
+		ieee80211_assoc_add_rates(local, skb, width, sband, assoc_data);
 
 	if (*capab & WLAN_CAPABILITY_SPECTRUM_MGMT ||
 	    *capab & WLAN_CAPABILITY_RADIO_MEASURE) {
@@ -1925,7 +1932,8 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	 * for some reason check it and want it to be set, set the bit for all
 	 * pre-EHT connections as we used to do.
 	 */
-	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT)
+	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT &&
+	    !ieee80211_hw_check(&local->hw, STRICT))
 		capab |= WLAN_CAPABILITY_ESS;
 
 	/* add the elements for the assoc (main) link */
@@ -4710,7 +4718,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	 * 2G/3G/4G wifi routers, reported models include the "Onda PN51T",
 	 * "Vodafone PocketWiFi 2", "ZTE MF60" and a similar T-Mobile device.
 	 */
-	if (!is_6ghz &&
+	if (!ieee80211_hw_check(&local->hw, STRICT) && !is_6ghz &&
 	    ((assoc_data->wmm && !elems->wmm_param) ||
 	     (link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT &&
 	      (!elems->ht_cap_elem || !elems->ht_operation)) ||
@@ -4846,6 +4854,15 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 				bss_vht_cap = (const void *)elem->data;
 		}
 
+		if (ieee80211_hw_check(&local->hw, STRICT) &&
+		    (!bss_vht_cap || memcmp(bss_vht_cap, elems->vht_cap_elem,
+					    sizeof(*bss_vht_cap)))) {
+			rcu_read_unlock();
+			ret = false;
+			link_info(link, "VHT capabilities mismatch\n");
+			goto out;
+		}
+
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
 						    elems->vht_cap_elem,
 						    bss_vht_cap, link_sta);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 505445a9598f..3caa0a9d3b38 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1419,6 +1419,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_TOS:
 		return mptcp_put_int_option(msk, optval, optlen, READ_ONCE(inet_sk(sk)->tos));
+	case IP_FREEBIND:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(FREEBIND, sk));
+	case IP_TRANSPARENT:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(TRANSPARENT, sk));
 	case IP_BIND_ADDRESS_NO_PORT:
 		return mptcp_put_int_option(msk, optval, optlen,
 				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
@@ -1430,6 +1436,26 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
+			       char __user *optval, int __user *optlen)
+{
+	struct sock *sk = (void *)msk;
+
+	switch (optname) {
+	case IPV6_V6ONLY:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    sk->sk_ipv6only);
+	case IPV6_TRANSPARENT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_test_bit(TRANSPARENT, sk));
+	case IPV6_FREEBIND:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_test_bit(FREEBIND, sk));
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_getsockopt_sol_mptcp(struct mptcp_sock *msk, int optname,
 				      char __user *optval, int __user *optlen)
 {
@@ -1469,6 +1495,8 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 
 	if (level == SOL_IP)
 		return mptcp_getsockopt_v4(msk, optname, optval, option);
+	if (level == SOL_IPV6)
+		return mptcp_getsockopt_v6(msk, optname, optval, option);
 	if (level == SOL_TCP)
 		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
 	if (level == SOL_MPTCP)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b56bbee7312c..4c2aa45c466d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -754,8 +754,6 @@ static bool subflow_hmac_valid(const struct request_sock *req,
 
 	subflow_req = mptcp_subflow_rsk(req);
 	msk = subflow_req->msk;
-	if (!msk)
-		return false;
 
 	subflow_generate_hmac(READ_ONCE(msk->remote_key),
 			      READ_ONCE(msk->local_key),
@@ -853,12 +851,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
-		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK) ||
-		    !subflow_hmac_valid(req, &mp_opt) ||
-		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
-			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
+		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK))
 			fallback = true;
-		}
 	}
 
 create_child:
@@ -908,6 +902,17 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
+			if (!subflow_hmac_valid(req, &mp_opt)) {
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				goto dispose_child;
+			}
+
+			if (!mptcp_can_accept_new_subflow(owner)) {
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				goto dispose_child;
+			}
+
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
 			ctx->conn = (struct sock *)owner;
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index b8d3c3213efe..c15db28c5ebc 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -994,8 +994,9 @@ static int nft_pipapo_avx2_lookup_8b_16(unsigned long *map, unsigned long *fill,
 		NFT_PIPAPO_AVX2_BUCKET_LOAD8(5, lt,  8,  pkt[8], bsize);
 
 		NFT_PIPAPO_AVX2_AND(6, 2, 3);
+		NFT_PIPAPO_AVX2_AND(3, 4, 7);
 		NFT_PIPAPO_AVX2_BUCKET_LOAD8(7, lt,  9,  pkt[9], bsize);
-		NFT_PIPAPO_AVX2_AND(0, 4, 5);
+		NFT_PIPAPO_AVX2_AND(0, 3, 5);
 		NFT_PIPAPO_AVX2_BUCKET_LOAD8(1, lt, 10, pkt[10], bsize);
 		NFT_PIPAPO_AVX2_AND(2, 6, 7);
 		NFT_PIPAPO_AVX2_BUCKET_LOAD8(3, lt, 11, pkt[11], bsize);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 998ea3b5badf..a3bab5e27e71 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2051,6 +2051,7 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
 	struct tcmsg *tcm;
 	struct nlmsghdr  *nlh;
 	unsigned char *b = skb_tail_pointer(skb);
+	int ret = -EMSGSIZE;
 
 	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*tcm), flags);
 	if (!nlh)
@@ -2095,11 +2096,45 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
 
 	return skb->len;
 
+cls_op_not_supp:
+	ret = -EOPNOTSUPP;
 out_nlmsg_trim:
 nla_put_failure:
-cls_op_not_supp:
 	nlmsg_trim(skb, b);
-	return -1;
+	return ret;
+}
+
+static struct sk_buff *tfilter_notify_prep(struct net *net,
+					   struct sk_buff *oskb,
+					   struct nlmsghdr *n,
+					   struct tcf_proto *tp,
+					   struct tcf_block *block,
+					   struct Qdisc *q, u32 parent,
+					   void *fh, int event,
+					   u32 portid, bool rtnl_held,
+					   struct netlink_ext_ack *extack)
+{
+	unsigned int size = oskb ? max(NLMSG_GOODSIZE, oskb->len) : NLMSG_GOODSIZE;
+	struct sk_buff *skb;
+	int ret;
+
+retry:
+	skb = alloc_skb(size, GFP_KERNEL);
+	if (!skb)
+		return ERR_PTR(-ENOBUFS);
+
+	ret = tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
+			    n->nlmsg_seq, n->nlmsg_flags, event, false,
+			    rtnl_held, extack);
+	if (ret <= 0) {
+		kfree_skb(skb);
+		if (ret == -EMSGSIZE) {
+			size += NLMSG_GOODSIZE;
+			goto retry;
+		}
+		return ERR_PTR(-EINVAL);
+	}
+	return skb;
 }
 
 static int tfilter_notify(struct net *net, struct sk_buff *oskb,
@@ -2115,16 +2150,10 @@ static int tfilter_notify(struct net *net, struct sk_buff *oskb,
 	if (!unicast && !rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
 		return 0;
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
-	if (tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
-			  n->nlmsg_seq, n->nlmsg_flags, event,
-			  false, rtnl_held, extack) <= 0) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
+	skb = tfilter_notify_prep(net, oskb, n, tp, block, q, parent, fh, event,
+				  portid, rtnl_held, extack);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
 
 	if (unicast)
 		err = rtnl_unicast(skb, net, portid);
@@ -2147,16 +2176,11 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
 		return tp->ops->delete(tp, fh, last, rtnl_held, extack);
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
-	if (tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
-			  n->nlmsg_seq, n->nlmsg_flags, RTM_DELTFILTER,
-			  false, rtnl_held, extack) <= 0) {
+	skb = tfilter_notify_prep(net, oskb, n, tp, block, q, parent, fh,
+				  RTM_DELTFILTER, portid, rtnl_held, extack);
+	if (IS_ERR(skb)) {
 		NL_SET_ERR_MSG(extack, "Failed to build del event notification");
-		kfree_skb(skb);
-		return -EINVAL;
+		return PTR_ERR(skb);
 	}
 
 	err = tp->ops->delete(tp, fh, last, rtnl_held, extack);
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 3e8d4fe4d91e..e1f6e7618deb 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -65,10 +65,7 @@ static struct sk_buff *codel_qdisc_dequeue(struct Qdisc *sch)
 			    &q->stats, qdisc_pkt_len, codel_get_enqueue_time,
 			    drop_func, dequeue_func);
 
-	/* We cant call qdisc_tree_reduce_backlog() if our qlen is 0,
-	 * or HTB crashes. Defer it for next round.
-	 */
-	if (q->stats.drop_count && sch->q.qlen) {
+	if (q->stats.drop_count) {
 		qdisc_tree_reduce_backlog(sch, q->stats.drop_count, q->stats.drop_len);
 		q->stats.drop_count = 0;
 		q->stats.drop_len = 0;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 4f908c11ba95..778f6e5966be 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -314,10 +314,8 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
 	}
 	qdisc_bstats_update(sch, skb);
 	flow->deficit -= qdisc_pkt_len(skb);
-	/* We cant call qdisc_tree_reduce_backlog() if our qlen is 0,
-	 * or HTB crashes. Defer it for next round.
-	 */
-	if (q->cstats.drop_count && sch->q.qlen) {
+
+	if (q->cstats.drop_count) {
 		qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
 					  q->cstats.drop_len);
 		q->cstats.drop_count = 0;
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 65d5b59da583..58b42dcf8f20 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -631,6 +631,15 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	struct red_parms *p = NULL;
 	struct sk_buff *to_free = NULL;
 	struct sk_buff *tail = NULL;
+	unsigned int maxflows;
+	unsigned int quantum;
+	unsigned int divisor;
+	int perturb_period;
+	u8 headdrop;
+	u8 maxdepth;
+	int limit;
+	u8 flags;
+
 
 	if (opt->nla_len < nla_attr_size(sizeof(*ctl)))
 		return -EINVAL;
@@ -652,39 +661,64 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		if (!p)
 			return -ENOMEM;
 	}
-	if (ctl->limit == 1) {
-		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
-		return -EINVAL;
-	}
+
 	sch_tree_lock(sch);
+
+	limit = q->limit;
+	divisor = q->divisor;
+	headdrop = q->headdrop;
+	maxdepth = q->maxdepth;
+	maxflows = q->maxflows;
+	perturb_period = q->perturb_period;
+	quantum = q->quantum;
+	flags = q->flags;
+
+	/* update and validate configuration */
 	if (ctl->quantum)
-		q->quantum = ctl->quantum;
-	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
+		quantum = ctl->quantum;
+	perturb_period = ctl->perturb_period * HZ;
 	if (ctl->flows)
-		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
+		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-		q->divisor = ctl->divisor;
-		q->maxflows = min_t(u32, q->maxflows, q->divisor);
+		divisor = ctl->divisor;
+		maxflows = min_t(u32, maxflows, divisor);
 	}
 	if (ctl_v1) {
 		if (ctl_v1->depth)
-			q->maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
+			maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
 		if (p) {
-			swap(q->red_parms, p);
-			red_set_parms(q->red_parms,
+			red_set_parms(p,
 				      ctl_v1->qth_min, ctl_v1->qth_max,
 				      ctl_v1->Wlog,
 				      ctl_v1->Plog, ctl_v1->Scell_log,
 				      NULL,
 				      ctl_v1->max_P);
 		}
-		q->flags = ctl_v1->flags;
-		q->headdrop = ctl_v1->headdrop;
+		flags = ctl_v1->flags;
+		headdrop = ctl_v1->headdrop;
 	}
 	if (ctl->limit) {
-		q->limit = min_t(u32, ctl->limit, q->maxdepth * q->maxflows);
-		q->maxflows = min_t(u32, q->maxflows, q->limit);
+		limit = min_t(u32, ctl->limit, maxdepth * maxflows);
+		maxflows = min_t(u32, maxflows, limit);
 	}
+	if (limit == 1) {
+		sch_tree_unlock(sch);
+		kfree(p);
+		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
+		return -EINVAL;
+	}
+
+	/* commit configuration */
+	q->limit = limit;
+	q->divisor = divisor;
+	q->headdrop = headdrop;
+	q->maxdepth = maxdepth;
+	q->maxflows = maxflows;
+	WRITE_ONCE(q->perturb_period, perturb_period);
+	q->quantum = quantum;
+	q->flags = flags;
+	if (p)
+		swap(q->red_parms, p);
 
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > q->limit) {
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 36ee34f483d7..53725ee7ba06 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -72,8 +72,9 @@
 /* Forward declarations for internal helper functions. */
 static bool sctp_writeable(const struct sock *sk);
 static void sctp_wfree(struct sk_buff *skb);
-static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len);
+static int sctp_wait_for_sndbuf(struct sctp_association *asoc,
+				struct sctp_transport *transport,
+				long *timeo_p, size_t msg_len);
 static int sctp_wait_for_packet(struct sock *sk, int *err, long *timeo_p);
 static int sctp_wait_for_connect(struct sctp_association *, long *timeo_p);
 static int sctp_wait_for_accept(struct sock *sk, long timeo);
@@ -1828,7 +1829,7 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 
 	if (sctp_wspace(asoc) <= 0 || !sk_wmem_schedule(sk, msg_len)) {
 		timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
-		err = sctp_wait_for_sndbuf(asoc, &timeo, msg_len);
+		err = sctp_wait_for_sndbuf(asoc, transport, &timeo, msg_len);
 		if (err)
 			goto err;
 		if (unlikely(sinfo->sinfo_stream >= asoc->stream.outcnt)) {
@@ -9214,8 +9215,9 @@ void sctp_sock_rfree(struct sk_buff *skb)
 
 
 /* Helper function to wait for space in the sndbuf.  */
-static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len)
+static int sctp_wait_for_sndbuf(struct sctp_association *asoc,
+				struct sctp_transport *transport,
+				long *timeo_p, size_t msg_len)
 {
 	struct sock *sk = asoc->base.sk;
 	long current_timeo = *timeo_p;
@@ -9225,7 +9227,9 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 	pr_debug("%s: asoc:%p, timeo:%ld, msg_len:%zu\n", __func__, asoc,
 		 *timeo_p, msg_len);
 
-	/* Increment the association's refcnt.  */
+	/* Increment the transport and association's refcnt. */
+	if (transport)
+		sctp_transport_hold(transport);
 	sctp_association_hold(asoc);
 
 	/* Wait on the association specific sndbuf space. */
@@ -9234,7 +9238,7 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 					  TASK_INTERRUPTIBLE);
 		if (asoc->base.dead)
 			goto do_dead;
-		if (!*timeo_p)
+		if ((!*timeo_p) || (transport && transport->dead))
 			goto do_nonblock;
 		if (sk->sk_err || asoc->state >= SCTP_STATE_SHUTDOWN_PENDING)
 			goto do_error;
@@ -9259,7 +9263,9 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 out:
 	finish_wait(&asoc->wait, &wait);
 
-	/* Release the association's refcnt.  */
+	/* Release the transport and association's refcnt. */
+	if (transport)
+		sctp_transport_put(transport);
 	sctp_association_put(asoc);
 
 	return err;
diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index 2abe45af98e7..31eca29b6cfb 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -117,6 +117,8 @@ struct sctp_transport *sctp_transport_new(struct net *net,
  */
 void sctp_transport_free(struct sctp_transport *transport)
 {
+	transport->dead = 1;
+
 	/* Try to delete the heartbeat timer.  */
 	if (del_timer(&transport->hb_timer))
 		sctp_transport_put(transport);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index c3fbf0779d4a..aca8bdf65d72 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -621,7 +621,8 @@ static void __svc_rdma_free(struct work_struct *work)
 	/* Destroy the CM ID */
 	rdma_destroy_id(rdma->sc_cm_id);
 
-	rpcrdma_rn_unregister(device, &rdma->sc_rn);
+	if (!test_bit(XPT_LISTENER, &rdma->sc_xprt.xpt_flags))
+		rpcrdma_rn_unregister(device, &rdma->sc_rn);
 	kfree(rdma);
 }
 
diff --git a/net/tipc/link.c b/net/tipc/link.c
index 5c2088a469ce..5689e1f48547 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1046,6 +1046,7 @@ int tipc_link_xmit(struct tipc_link *l, struct sk_buff_head *list,
 	if (unlikely(l->backlog[imp].len >= l->backlog[imp].limit)) {
 		if (imp == TIPC_SYSTEM_IMPORTANCE) {
 			pr_warn("%s<%s>, link overflow", link_rst_msg, l->name);
+			__skb_queue_purge(list);
 			return -ENOBUFS;
 		}
 		rc = link_schedule_user(l, hdr);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 6b4b9f2749a6..0acf313deb01 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -809,6 +809,11 @@ static int tls_setsockopt(struct sock *sk, int level, int optname,
 	return do_tls_setsockopt(sk, optname, optval, optlen);
 }
 
+static int tls_disconnect(struct sock *sk, int flags)
+{
+	return -EOPNOTSUPP;
+}
+
 struct tls_context *tls_ctx_create(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -904,6 +909,7 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 	prot[TLS_BASE][TLS_BASE] = *base;
 	prot[TLS_BASE][TLS_BASE].setsockopt	= tls_setsockopt;
 	prot[TLS_BASE][TLS_BASE].getsockopt	= tls_getsockopt;
+	prot[TLS_BASE][TLS_BASE].disconnect	= tls_disconnect;
 	prot[TLS_BASE][TLS_BASE].close		= tls_sk_proto_close;
 
 	prot[TLS_SW][TLS_BASE] = prot[TLS_BASE][TLS_BASE];
diff --git a/scripts/generate_builtin_ranges.awk b/scripts/generate_builtin_ranges.awk
index b9ec761b3bef..d4bd5c2b998c 100755
--- a/scripts/generate_builtin_ranges.awk
+++ b/scripts/generate_builtin_ranges.awk
@@ -282,6 +282,11 @@ ARGIND == 2 && !anchor && NF == 2 && $1 ~ /^0x/ && $2 !~ /^0x/ {
 # section.
 #
 ARGIND == 2 && sect && NF == 4 && /^ [^ \*]/ && !($1 in sect_addend) {
+	# There are a few sections with constant data (without symbols) that
+	# can get resized during linking, so it is best to ignore them.
+	if ($1 ~ /^\.rodata\.(cst|str)[0-9]/)
+		next;
+
 	if (!($1 in sect_base)) {
 		sect_base[$1] = base;
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index abfdb4905ca2..56bf2f55d938 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -181,7 +181,8 @@ struct ima_kexec_hdr {
 #define IMA_UPDATE_XATTR	1
 #define IMA_CHANGE_ATTR		2
 #define IMA_DIGSIG		3
-#define IMA_MUST_MEASURE	4
+#define IMA_MAY_EMIT_TOMTOU	4
+#define IMA_EMITTED_OPENWRITERS	5
 
 /* IMA integrity metadata associated with an inode */
 struct ima_iint_cache {
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 4b213de8dcb4..a9aab10bebca 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -129,16 +129,22 @@ static void ima_rdwr_violation_check(struct file *file,
 		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
 			if (!iint)
 				iint = ima_iint_find(inode);
+
 			/* IMA_MEASURE is set from reader side */
-			if (iint && test_bit(IMA_MUST_MEASURE,
-						&iint->atomic_flags))
+			if (iint && test_and_clear_bit(IMA_MAY_EMIT_TOMTOU,
+						       &iint->atomic_flags))
 				send_tomtou = true;
 		}
 	} else {
 		if (must_measure)
-			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
-		if (inode_is_open_for_write(inode) && must_measure)
-			send_writers = true;
+			set_bit(IMA_MAY_EMIT_TOMTOU, &iint->atomic_flags);
+
+		/* Limit number of open_writers violations */
+		if (inode_is_open_for_write(inode) && must_measure) {
+			if (!test_and_set_bit(IMA_EMITTED_OPENWRITERS,
+					      &iint->atomic_flags))
+				send_writers = true;
+		}
 	}
 
 	if (!send_tomtou && !send_writers)
@@ -167,6 +173,8 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 	if (atomic_read(&inode->i_writecount) == 1) {
 		struct kstat stat;
 
+		clear_bit(IMA_EMITTED_OPENWRITERS, &iint->atomic_flags);
+
 		update = test_and_clear_bit(IMA_UPDATE_XATTR,
 					    &iint->atomic_flags);
 		if ((iint->flags & IMA_NEW_FILE) ||
diff --git a/security/landlock/errata.h b/security/landlock/errata.h
new file mode 100644
index 000000000000..8e626accac10
--- /dev/null
+++ b/security/landlock/errata.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - Errata information
+ *
+ * Copyright © 2025 Microsoft Corporation
+ */
+
+#ifndef _SECURITY_LANDLOCK_ERRATA_H
+#define _SECURITY_LANDLOCK_ERRATA_H
+
+#include <linux/init.h>
+
+struct landlock_erratum {
+	const int abi;
+	const u8 number;
+};
+
+/* clang-format off */
+#define LANDLOCK_ERRATUM(NUMBER) \
+	{ \
+		.abi = LANDLOCK_ERRATA_ABI, \
+		.number = NUMBER, \
+	},
+/* clang-format on */
+
+/*
+ * Some fixes may require user space to check if they are applied on the running
+ * kernel before using a specific feature.  For instance, this applies when a
+ * restriction was previously too restrictive and is now getting relaxed (for
+ * compatibility or semantic reasons).  However, non-visible changes for
+ * legitimate use (e.g. security fixes) do not require an erratum.
+ */
+static const struct landlock_erratum landlock_errata_init[] __initconst = {
+
+/*
+ * Only Sparse may not implement __has_include.  If a compiler does not
+ * implement __has_include, a warning will be printed at boot time (see
+ * setup.c).
+ */
+#ifdef __has_include
+
+#define LANDLOCK_ERRATA_ABI 1
+#if __has_include("errata/abi-1.h")
+#include "errata/abi-1.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 2
+#if __has_include("errata/abi-2.h")
+#include "errata/abi-2.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 3
+#if __has_include("errata/abi-3.h")
+#include "errata/abi-3.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 4
+#if __has_include("errata/abi-4.h")
+#include "errata/abi-4.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 5
+#if __has_include("errata/abi-5.h")
+#include "errata/abi-5.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 6
+#if __has_include("errata/abi-6.h")
+#include "errata/abi-6.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+/*
+ * For each new erratum, we need to include all the ABI files up to the impacted
+ * ABI to make all potential future intermediate errata easy to backport.
+ *
+ * If such change involves more than one ABI addition, then it must be in a
+ * dedicated commit with the same Fixes tag as used for the actual fix.
+ *
+ * Each commit creating a new security/landlock/errata/abi-*.h file must have a
+ * Depends-on tag to reference the commit that previously added the line to
+ * include this new file, except if the original Fixes tag is enough.
+ *
+ * Each erratum must be documented in its related ABI file, and a dedicated
+ * commit must update Documentation/userspace-api/landlock.rst to include this
+ * erratum.  This commit will not be backported.
+ */
+
+#endif
+
+	{}
+};
+
+#endif /* _SECURITY_LANDLOCK_ERRATA_H */
diff --git a/security/landlock/errata/abi-4.h b/security/landlock/errata/abi-4.h
new file mode 100644
index 000000000000..c052ee54f89f
--- /dev/null
+++ b/security/landlock/errata/abi-4.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/**
+ * DOC: erratum_1
+ *
+ * Erratum 1: TCP socket identification
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This fix addresses an issue where IPv4 and IPv6 stream sockets (e.g., SMC,
+ * MPTCP, or SCTP) were incorrectly restricted by TCP access rights during
+ * :manpage:`bind(2)` and :manpage:`connect(2)` operations. This change ensures
+ * that only TCP sockets are subject to TCP access rights, allowing other
+ * protocols to operate without unnecessary restrictions.
+ */
+LANDLOCK_ERRATUM(1)
diff --git a/security/landlock/errata/abi-6.h b/security/landlock/errata/abi-6.h
new file mode 100644
index 000000000000..df7bc0e1fdf4
--- /dev/null
+++ b/security/landlock/errata/abi-6.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/**
+ * DOC: erratum_2
+ *
+ * Erratum 2: Scoped signal handling
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This fix addresses an issue where signal scoping was overly restrictive,
+ * preventing sandboxed threads from signaling other threads within the same
+ * process if they belonged to different domains.  Because threads are not
+ * security boundaries, user space might assume that any thread within the same
+ * process can send signals between themselves (see :manpage:`nptl(7)` and
+ * :manpage:`libpsx(3)`).  Consistent with :manpage:`ptrace(2)` behavior, direct
+ * interaction between threads of the same process should always be allowed.
+ * This change ensures that any thread is allowed to send signals to any other
+ * thread within the same process, regardless of their domain.
+ */
+LANDLOCK_ERRATUM(2)
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7adb25150488..511e6ae8b79c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -27,7 +27,9 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/path.h>
+#include <linux/pid.h>
 #include <linux/rcupdate.h>
+#include <linux/sched/signal.h>
 #include <linux/spinlock.h>
 #include <linux/stat.h>
 #include <linux/types.h>
@@ -1623,21 +1625,46 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
 	return -EACCES;
 }
 
-static void hook_file_set_fowner(struct file *file)
+/*
+ * Always allow sending signals between threads of the same process.  This
+ * ensures consistency with hook_task_kill().
+ */
+static bool control_current_fowner(struct fown_struct *const fown)
 {
-	struct landlock_ruleset *new_dom, *prev_dom;
+	struct task_struct *p;
 
 	/*
 	 * Lock already held by __f_setown(), see commit 26f204380a3c ("fs: Fix
 	 * file_set_fowner LSM hook inconsistencies").
 	 */
-	lockdep_assert_held(&file_f_owner(file)->lock);
-	new_dom = landlock_get_current_domain();
-	landlock_get_ruleset(new_dom);
+	lockdep_assert_held(&fown->lock);
+
+	/*
+	 * Some callers (e.g. fcntl_dirnotify) may not be in an RCU read-side
+	 * critical section.
+	 */
+	guard(rcu)();
+	p = pid_task(fown->pid, fown->pid_type);
+	if (!p)
+		return true;
+
+	return !same_thread_group(p, current);
+}
+
+static void hook_file_set_fowner(struct file *file)
+{
+	struct landlock_ruleset *prev_dom;
+	struct landlock_ruleset *new_dom = NULL;
+
+	if (control_current_fowner(file_f_owner(file))) {
+		new_dom = landlock_get_current_domain();
+		landlock_get_ruleset(new_dom);
+	}
+
 	prev_dom = landlock_file(file)->fown_domain;
 	landlock_file(file)->fown_domain = new_dom;
 
-	/* Called in an RCU read-side critical section. */
+	/* May be called in an RCU read-side critical section. */
 	landlock_put_ruleset_deferred(prev_dom);
 }
 
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 28519a45b11f..0c85ea27e409 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -6,12 +6,14 @@
  * Copyright © 2018-2020 ANSSI
  */
 
+#include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
 #include "common.h"
 #include "cred.h"
+#include "errata.h"
 #include "fs.h"
 #include "net.h"
 #include "setup.h"
@@ -19,6 +21,11 @@
 
 bool landlock_initialized __ro_after_init = false;
 
+const struct lsm_id landlock_lsmid = {
+	.name = LANDLOCK_NAME,
+	.id = LSM_ID_LANDLOCK,
+};
+
 struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
 	.lbs_cred = sizeof(struct landlock_cred_security),
 	.lbs_file = sizeof(struct landlock_file_security),
@@ -26,13 +33,36 @@ struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
-const struct lsm_id landlock_lsmid = {
-	.name = LANDLOCK_NAME,
-	.id = LSM_ID_LANDLOCK,
-};
+int landlock_errata __ro_after_init;
+
+static void __init compute_errata(void)
+{
+	size_t i;
+
+#ifndef __has_include
+	/*
+	 * This is a safeguard to make sure the compiler implements
+	 * __has_include (see errata.h).
+	 */
+	WARN_ON_ONCE(1);
+	return;
+#endif
+
+	for (i = 0; landlock_errata_init[i].number; i++) {
+		const int prev_errata = landlock_errata;
+
+		if (WARN_ON_ONCE(landlock_errata_init[i].abi >
+				 landlock_abi_version))
+			continue;
+
+		landlock_errata |= BIT(landlock_errata_init[i].number - 1);
+		WARN_ON_ONCE(prev_errata == landlock_errata);
+	}
+}
 
 static int __init landlock_init(void)
 {
+	compute_errata();
 	landlock_add_cred_hooks();
 	landlock_add_task_hooks();
 	landlock_add_fs_hooks();
diff --git a/security/landlock/setup.h b/security/landlock/setup.h
index c4252d46d49d..fca307c35fee 100644
--- a/security/landlock/setup.h
+++ b/security/landlock/setup.h
@@ -11,7 +11,10 @@
 
 #include <linux/lsm_hooks.h>
 
+extern const int landlock_abi_version;
+
 extern bool landlock_initialized;
+extern int landlock_errata;
 
 extern struct lsm_blob_sizes landlock_blob_sizes;
 extern const struct lsm_id landlock_lsmid;
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index c097d356fa45..4fa2d09f657a 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -159,7 +159,9 @@ static const struct file_operations ruleset_fops = {
  *        the new ruleset.
  * @size: Size of the pointed &struct landlock_ruleset_attr (needed for
  *        backward and forward compatibility).
- * @flags: Supported value: %LANDLOCK_CREATE_RULESET_VERSION.
+ * @flags: Supported value:
+ *         - %LANDLOCK_CREATE_RULESET_VERSION
+ *         - %LANDLOCK_CREATE_RULESET_ERRATA
  *
  * This system call enables to create a new Landlock ruleset, and returns the
  * related file descriptor on success.
@@ -168,6 +170,10 @@ static const struct file_operations ruleset_fops = {
  * 0, then the returned value is the highest supported Landlock ABI version
  * (starting at 1).
  *
+ * If @flags is %LANDLOCK_CREATE_RULESET_ERRATA and @attr is NULL and @size is
+ * 0, then the returned value is a bitmask of fixed issues for the current
+ * Landlock ABI version.
+ *
  * Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
@@ -191,9 +197,15 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 		return -EOPNOTSUPP;
 
 	if (flags) {
-		if ((flags == LANDLOCK_CREATE_RULESET_VERSION) && !attr &&
-		    !size)
-			return LANDLOCK_ABI_VERSION;
+		if (attr || size)
+			return -EINVAL;
+
+		if (flags == LANDLOCK_CREATE_RULESET_VERSION)
+			return landlock_abi_version;
+
+		if (flags == LANDLOCK_CREATE_RULESET_ERRATA)
+			return landlock_errata;
+
 		return -EINVAL;
 	}
 
@@ -234,6 +246,8 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	return ruleset_fd;
 }
 
+const int landlock_abi_version = LANDLOCK_ABI_VERSION;
+
 /*
  * Returns an owned ruleset from a FD. It is thus needed to call
  * landlock_put_ruleset() on the return value.
diff --git a/security/landlock/task.c b/security/landlock/task.c
index dc7dab78392e..4578ce6e319d 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -13,6 +13,7 @@
 #include <linux/lsm_hooks.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <net/af_unix.h>
 #include <net/sock.h>
 
@@ -264,6 +265,17 @@ static int hook_task_kill(struct task_struct *const p,
 		/* Dealing with USB IO. */
 		dom = landlock_cred(cred)->domain;
 	} else {
+		/*
+		 * Always allow sending signals between threads of the same process.
+		 * This is required for process credential changes by the Native POSIX
+		 * Threads Library and implemented by the set*id(2) wrappers and
+		 * libcap(3) with tgkill(2).  See nptl(7) and libpsx(3).
+		 *
+		 * This exception is similar to the __ptrace_may_access() one.
+		 */
+		if (same_thread_group(p, current))
+			return 0;
+
 		dom = landlock_get_current_domain();
 	}
 	dom = landlock_get_applicable_domain(dom, signal_scope);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index cb9925948175..25b1984898ab 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -37,6 +37,7 @@
 #include <linux/completion.h>
 #include <linux/acpi.h>
 #include <linux/pgtable.h>
+#include <linux/dmi.h>
 
 #ifdef CONFIG_X86
 /* for snoop control */
@@ -1360,8 +1361,21 @@ static void azx_free(struct azx *chip)
 	if (use_vga_switcheroo(hda)) {
 		if (chip->disabled && hda->probe_continued)
 			snd_hda_unlock_devices(&chip->bus);
-		if (hda->vga_switcheroo_registered)
+		if (hda->vga_switcheroo_registered) {
 			vga_switcheroo_unregister_client(chip->pci);
+
+			/* Some GPUs don't have sound, and azx_first_init fails,
+			 * leaving the device probed but non-functional. As long
+			 * as it's probed, the PCI subsystem keeps its runtime
+			 * PM status as active. Force it to suspended (as we
+			 * actually stop the chip) to allow GPU to suspend via
+			 * vga_switcheroo, and print a warning.
+			 */
+			dev_warn(&pci->dev, "GPU sound probed, but not operational: please add a quirk to driver_denylist\n");
+			pm_runtime_disable(&pci->dev);
+			pm_runtime_set_suspended(&pci->dev);
+			pm_runtime_enable(&pci->dev);
+		}
 	}
 
 	if (bus->chip_init) {
@@ -2071,6 +2085,27 @@ static const struct pci_device_id driver_denylist[] = {
 	{}
 };
 
+static struct pci_device_id driver_denylist_ideapad_z570[] = {
+	{ PCI_DEVICE_SUB(0x10de, 0x0bea, 0x0000, 0x0000) }, /* NVIDIA GF108 HDA */
+	{}
+};
+
+/* DMI-based denylist, to be used when:
+ *  - PCI subsystem IDs are zero, impossible to distinguish from valid sound cards.
+ *  - Different modifications of the same laptop use different GPU models.
+ */
+static const struct dmi_system_id driver_denylist_dmi[] = {
+	{
+		/* No HDA in NVIDIA DGPU. BIOS disables it, but quirk_nvidia_hda() reenables. */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Ideapad Z570"),
+		},
+		.driver_data = &driver_denylist_ideapad_z570,
+	},
+	{}
+};
+
 static const struct hda_controller_ops pci_hda_ops = {
 	.disable_msi_reset_irq = disable_msi_reset_irq,
 	.position_check = azx_position_check,
@@ -2081,6 +2116,7 @@ static DECLARE_BITMAP(probed_devs, SNDRV_CARDS);
 static int azx_probe(struct pci_dev *pci,
 		     const struct pci_device_id *pci_id)
 {
+	const struct dmi_system_id *dmi;
 	struct snd_card *card;
 	struct hda_intel *hda;
 	struct azx *chip;
@@ -2093,6 +2129,12 @@ static int azx_probe(struct pci_dev *pci,
 		return -ENODEV;
 	}
 
+	dmi = dmi_first_match(driver_denylist_dmi);
+	if (dmi && pci_match_id(dmi->driver_data, pci)) {
+		dev_info(&pci->dev, "Skipping the device on the DMI denylist\n");
+		return -ENODEV;
+	}
+
 	dev = find_first_zero_bit(probed_devs, SNDRV_CARDS);
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 59e59fdc38f2..0bf833c96021 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4744,6 +4744,22 @@ static void alc245_fixup_hp_mute_led_coefbit(struct hda_codec *codec,
 	}
 }
 
+static void alc245_fixup_hp_mute_led_v1_coefbit(struct hda_codec *codec,
+					  const struct hda_fixup *fix,
+					  int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0x0b;
+		spec->mute_led_coef.mask = 1 << 3;
+		spec->mute_led_coef.on = 1 << 3;
+		spec->mute_led_coef.off = 0;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 /* turn on/off mic-mute LED per capture hook by coef bit */
 static int coef_micmute_led_set(struct led_classdev *led_cdev,
 				enum led_brightness brightness)
@@ -7851,6 +7867,7 @@ enum {
 	ALC287_FIXUP_TAS2781_I2C,
 	ALC287_FIXUP_YOGA7_14ARB7_I2C,
 	ALC245_FIXUP_HP_MUTE_LED_COEFBIT,
+	ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT,
 	ALC245_FIXUP_HP_X360_MUTE_LEDS,
 	ALC287_FIXUP_THINKPAD_I2S_SPK,
 	ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD,
@@ -10084,6 +10101,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_mute_led_coefbit,
 	},
+	[ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_mute_led_v1_coefbit,
+	},
 	[ALC245_FIXUP_HP_X360_MUTE_LEDS] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_mute_led_coefbit,
@@ -10569,6 +10590,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8bb3, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bb4, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bdd, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bde, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bdf, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 39208305dd6c..f9759c9342cf 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -11,6 +11,7 @@
 #define ACP_DEVICE_ID 0x15E2
 #define ACP63_REG_START		0x1240000
 #define ACP63_REG_END		0x125C000
+#define ACP63_PCI_REV		0x63
 
 #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
 #define ACP_PGFSM_CNTL_POWER_ON_MASK	1
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 5c4a0be7a788..aec3150ecf58 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -559,7 +559,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 
 	/* Pink Sardine device check */
 	switch (pci->revision) {
-	case 0x63:
+	case ACP63_PCI_REV:
 		break;
 	default:
 		dev_dbg(&pci->dev, "acp63 pci device not found\n");
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index a7637056972a..e632f16c9102 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -339,6 +339,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83J2"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
@@ -584,6 +591,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "pang13"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 C7UCX"),
+		}
+	},
 	{}
 };
 
diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 08fb13a334a4..9c1997a42334 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -2564,6 +2564,7 @@ static int wcd937x_soc_codec_probe(struct snd_soc_component *component)
 						ARRAY_SIZE(wcd9375_dapm_widgets));
 		if (ret < 0) {
 			dev_err(component->dev, "Failed to add snd_ctls\n");
+			wcd_clsh_ctrl_free(wcd937x->clsh_info);
 			return ret;
 		}
 
@@ -2571,6 +2572,7 @@ static int wcd937x_soc_codec_probe(struct snd_soc_component *component)
 					      ARRAY_SIZE(wcd9375_audio_map));
 		if (ret < 0) {
 			dev_err(component->dev, "Failed to add routes\n");
+			wcd_clsh_ctrl_free(wcd937x->clsh_info);
 			return ret;
 		}
 	}
diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index 3cd9a66b70a1..7981d598ba13 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -488,11 +488,17 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 		goto err_disable_pm;
 	}
 
-	priv->pdev = platform_device_register_data(dev, "imx-audmix", 0, NULL, 0);
-	if (IS_ERR(priv->pdev)) {
-		ret = PTR_ERR(priv->pdev);
-		dev_err(dev, "failed to register platform: %d\n", ret);
-		goto err_disable_pm;
+	/*
+	 * If dais property exist, then register the imx-audmix card driver.
+	 * otherwise, it should be linked by audio graph card.
+	 */
+	if (of_find_property(pdev->dev.of_node, "dais", NULL)) {
+		priv->pdev = platform_device_register_data(dev, "imx-audmix", 0, NULL, 0);
+		if (IS_ERR(priv->pdev)) {
+			ret = PTR_ERR(priv->pdev);
+			dev_err(dev, "failed to register platform: %d\n", ret);
+			goto err_disable_pm;
+		}
 	}
 
 	return 0;
diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index bb1324fb588e..a68efbe98948 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -214,6 +214,15 @@ static const struct snd_soc_acpi_adr_device rt1316_1_group2_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_adr_device rt1316_2_group2_adr[] = {
+	{
+		.adr = 0x000232025D131601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "rt1316-2"
+	}
+};
+
 static const struct snd_soc_acpi_adr_device rt1316_1_single_adr[] = {
 	{
 		.adr = 0x000130025D131601ull,
@@ -547,6 +556,20 @@ static const struct snd_soc_acpi_link_adr adl_chromebook_base[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr adl_sdw_rt1316_link02[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt1316_0_group2_adr),
+		.adr_d = rt1316_0_group2_adr,
+	},
+	{
+		.mask = BIT(2),
+		.num_adr = ARRAY_SIZE(rt1316_2_group2_adr),
+		.adr_d = rt1316_2_group2_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_codecs adl_max98357a_amp = {
 	.num_codecs = 1,
 	.codecs = {"MX98357A"}
@@ -749,6 +772,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-adl-sdw-max98373-rt5682.tplg",
 	},
+	{
+		.link_mask = BIT(0) | BIT(2),
+		.links = adl_sdw_rt1316_link02,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-adl-rt1316-l02.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_adl_sdw_machines);
diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index c9404b5934c7..2cd522108221 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -24,8 +24,8 @@
 #define PLAYBACK_MIN_PERIOD_SIZE	128
 #define CAPTURE_MIN_NUM_PERIODS		2
 #define CAPTURE_MAX_NUM_PERIODS		8
-#define CAPTURE_MAX_PERIOD_SIZE		4096
-#define CAPTURE_MIN_PERIOD_SIZE		320
+#define CAPTURE_MAX_PERIOD_SIZE		65536
+#define CAPTURE_MIN_PERIOD_SIZE		6144
 #define BUFFER_BYTES_MAX (PLAYBACK_MAX_NUM_PERIODS * PLAYBACK_MAX_PERIOD_SIZE)
 #define BUFFER_BYTES_MIN (PLAYBACK_MIN_NUM_PERIODS * PLAYBACK_MIN_PERIOD_SIZE)
 #define COMPR_PLAYBACK_MAX_FRAGMENT_SIZE (128 * 1024)
@@ -64,12 +64,12 @@ struct q6apm_dai_rtd {
 	phys_addr_t phys;
 	unsigned int pcm_size;
 	unsigned int pcm_count;
-	unsigned int pos;       /* Buffer position */
 	unsigned int periods;
 	unsigned int bytes_sent;
 	unsigned int bytes_received;
 	unsigned int copied_total;
 	uint16_t bits_per_sample;
+	snd_pcm_uframes_t queue_ptr;
 	bool next_track;
 	enum stream_state state;
 	struct q6apm_graph *graph;
@@ -123,25 +123,16 @@ static void event_handler(uint32_t opcode, uint32_t token, void *payload, void *
 {
 	struct q6apm_dai_rtd *prtd = priv;
 	struct snd_pcm_substream *substream = prtd->substream;
-	unsigned long flags;
 
 	switch (opcode) {
 	case APM_CLIENT_EVENT_CMD_EOS_DONE:
 		prtd->state = Q6APM_STREAM_STOPPED;
 		break;
 	case APM_CLIENT_EVENT_DATA_WRITE_DONE:
-		spin_lock_irqsave(&prtd->lock, flags);
-		prtd->pos += prtd->pcm_count;
-		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
-		if (prtd->state == Q6APM_STREAM_RUNNING)
-			q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, 0);
 
 		break;
 	case APM_CLIENT_EVENT_DATA_READ_DONE:
-		spin_lock_irqsave(&prtd->lock, flags);
-		prtd->pos += prtd->pcm_count;
-		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
 		if (prtd->state == Q6APM_STREAM_RUNNING)
 			q6apm_read(prtd->graph);
@@ -248,7 +239,6 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
 	}
 
 	prtd->pcm_count = snd_pcm_lib_period_bytes(substream);
-	prtd->pos = 0;
 	/* rate and channels are sent to audio driver */
 	ret = q6apm_graph_media_format_shmem(prtd->graph, &cfg);
 	if (ret < 0) {
@@ -294,6 +284,27 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
 	return 0;
 }
 
+static int q6apm_dai_ack(struct snd_soc_component *component, struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	int i, ret = 0, avail_periods;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		avail_periods = (runtime->control->appl_ptr - prtd->queue_ptr)/runtime->period_size;
+		for (i = 0; i < avail_periods; i++) {
+			ret = q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+			if (ret < 0) {
+				dev_err(component->dev, "Error queuing playback buffer %d\n", ret);
+				return ret;
+			}
+			prtd->queue_ptr += runtime->period_size;
+		}
+	}
+
+	return ret;
+}
+
 static int q6apm_dai_trigger(struct snd_soc_component *component,
 			     struct snd_pcm_substream *substream, int cmd)
 {
@@ -305,9 +316,6 @@ static int q6apm_dai_trigger(struct snd_soc_component *component,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		 /* start writing buffers for playback only as we already queued capture buffers */
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			ret = q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* TODO support be handled via SoftPause Module */
@@ -377,13 +385,14 @@ static int q6apm_dai_open(struct snd_soc_component *component,
 		}
 	}
 
-	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
+	/* setup 10ms latency to accommodate DSP restrictions */
+	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 480);
 	if (ret < 0) {
 		dev_err(dev, "constraint for period bytes step ret = %d\n", ret);
 		goto err;
 	}
 
-	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
+	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 480);
 	if (ret < 0) {
 		dev_err(dev, "constraint for buffer bytes step ret = %d\n", ret);
 		goto err;
@@ -428,16 +437,12 @@ static snd_pcm_uframes_t q6apm_dai_pointer(struct snd_soc_component *component,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct q6apm_dai_rtd *prtd = runtime->private_data;
 	snd_pcm_uframes_t ptr;
-	unsigned long flags;
 
-	spin_lock_irqsave(&prtd->lock, flags);
-	if (prtd->pos == prtd->pcm_size)
-		prtd->pos = 0;
-
-	ptr =  bytes_to_frames(runtime, prtd->pos);
-	spin_unlock_irqrestore(&prtd->lock, flags);
+	ptr = q6apm_get_hw_pointer(prtd->graph, substream->stream) * runtime->period_size;
+	if (ptr)
+		return ptr - 1;
 
-	return ptr;
+	return 0;
 }
 
 static int q6apm_dai_hw_params(struct snd_soc_component *component,
@@ -652,8 +657,6 @@ static int q6apm_dai_compr_set_params(struct snd_soc_component *component,
 	prtd->pcm_size = runtime->fragments * runtime->fragment_size;
 	prtd->bits_per_sample = 16;
 
-	prtd->pos = 0;
-
 	if (prtd->next_track != true) {
 		memcpy(&prtd->codec, codec, sizeof(*codec));
 
@@ -836,6 +839,7 @@ static const struct snd_soc_component_driver q6apm_fe_dai_component = {
 	.hw_params	= q6apm_dai_hw_params,
 	.pointer	= q6apm_dai_pointer,
 	.trigger	= q6apm_dai_trigger,
+	.ack		= q6apm_dai_ack,
 	.compress_ops	= &q6apm_dai_compress_ops,
 	.use_dai_pcm_id = true,
 };
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 2a2a5bd98110..ca57413cb784 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -494,6 +494,19 @@ int q6apm_read(struct q6apm_graph *graph)
 }
 EXPORT_SYMBOL_GPL(q6apm_read);
 
+int q6apm_get_hw_pointer(struct q6apm_graph *graph, int dir)
+{
+	struct audioreach_graph_data *data;
+
+	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
+		data = &graph->rx_data;
+	else
+		data = &graph->tx_data;
+
+	return (int)atomic_read(&data->hw_ptr);
+}
+EXPORT_SYMBOL_GPL(q6apm_get_hw_pointer);
+
 static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 {
 	struct data_cmd_rsp_rd_sh_mem_ep_data_buffer_done_v2 *rd_done;
@@ -520,7 +533,8 @@ static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 		done = data->payload;
 		phys = graph->rx_data.buf[token].phys;
 		mutex_unlock(&graph->lock);
-
+		/* token numbering starts at 0 */
+		atomic_set(&graph->rx_data.hw_ptr, token + 1);
 		if (lower_32_bits(phys) == done->buf_addr_lsw &&
 		    upper_32_bits(phys) == done->buf_addr_msw) {
 			graph->result.opcode = hdr->opcode;
@@ -553,6 +567,8 @@ static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 		rd_done = data->payload;
 		phys = graph->tx_data.buf[hdr->token].phys;
 		mutex_unlock(&graph->lock);
+		/* token numbering starts at 0 */
+		atomic_set(&graph->tx_data.hw_ptr, hdr->token + 1);
 
 		if (upper_32_bits(phys) == rd_done->buf_addr_msw &&
 		    lower_32_bits(phys) == rd_done->buf_addr_lsw) {
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index c248c8d2b1ab..7ce08b401e31 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -2,6 +2,7 @@
 #ifndef __Q6APM_H__
 #define __Q6APM_H__
 #include <linux/types.h>
+#include <linux/atomic.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/kernel.h>
@@ -77,6 +78,7 @@ struct audioreach_graph_data {
 	uint32_t num_periods;
 	uint32_t dsp_buf;
 	uint32_t mem_map_handle;
+	atomic_t hw_ptr;
 };
 
 struct audioreach_graph {
@@ -150,4 +152,5 @@ int q6apm_enable_compress_module(struct device *dev, struct q6apm_graph *graph,
 int q6apm_remove_initial_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples);
 int q6apm_remove_trailing_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples);
 int q6apm_set_real_module_id(struct device *dev, struct q6apm_graph *graph, uint32_t codec_id);
+int q6apm_get_hw_pointer(struct q6apm_graph *graph, int dir);
 #endif /* __APM_GRAPH_ */
diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 045100c94352..a400c9a31fea 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -892,9 +892,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 
 		if (ret < 0) {
 			dev_err(dev, "q6asm_open_write failed\n");
-			q6asm_audio_client_free(prtd->audio_client);
-			prtd->audio_client = NULL;
-			return ret;
+			goto open_err;
 		}
 	}
 
@@ -903,7 +901,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 			      prtd->session_id, dir);
 	if (ret) {
 		dev_err(dev, "Stream reg failed ret:%d\n", ret);
-		return ret;
+		goto q6_err;
 	}
 
 	ret = __q6asm_dai_compr_set_codec_params(component, stream,
@@ -911,7 +909,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 						 prtd->stream_id);
 	if (ret) {
 		dev_err(dev, "codec param setup failed ret:%d\n", ret);
-		return ret;
+		goto q6_err;
 	}
 
 	ret = q6asm_map_memory_regions(dir, prtd->audio_client, prtd->phys,
@@ -920,12 +918,21 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 
 	if (ret < 0) {
 		dev_err(dev, "Buffer Mapping failed ret:%d\n", ret);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto q6_err;
 	}
 
 	prtd->state = Q6ASM_STREAM_RUNNING;
 
 	return 0;
+
+q6_err:
+	q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
+
+open_err:
+	q6asm_audio_client_free(prtd->audio_client);
+	prtd->audio_client = NULL;
+	return ret;
 }
 
 static int q6asm_dai_compr_set_metadata(struct snd_soc_component *component,
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index b3fca5fd87d6..37ca15cc5728 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1269,8 +1269,8 @@ static int sof_widget_parse_tokens(struct snd_soc_component *scomp, struct snd_s
 			struct snd_sof_tuple *new_tuples;
 
 			num_tuples += token_list[object_token_list[i]].count * (num_sets - 1);
-			new_tuples = krealloc(swidget->tuples,
-					      sizeof(*new_tuples) * num_tuples, GFP_KERNEL);
+			new_tuples = krealloc_array(swidget->tuples,
+						    num_tuples, sizeof(*new_tuples), GFP_KERNEL);
 			if (!new_tuples) {
 				ret = -ENOMEM;
 				goto err;
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 779d97d31f17..826ac870f246 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -489,16 +489,84 @@ static void ch345_broken_sysex_input(struct snd_usb_midi_in_endpoint *ep,
 
 /*
  * CME protocol: like the standard protocol, but SysEx commands are sent as a
- * single USB packet preceded by a 0x0F byte.
+ * single USB packet preceded by a 0x0F byte, as are system realtime
+ * messages and MIDI Active Sensing.
+ * Also, multiple messages can be sent in the same packet.
  */
 static void snd_usbmidi_cme_input(struct snd_usb_midi_in_endpoint *ep,
 				  uint8_t *buffer, int buffer_length)
 {
-	if (buffer_length < 2 || (buffer[0] & 0x0f) != 0x0f)
-		snd_usbmidi_standard_input(ep, buffer, buffer_length);
-	else
-		snd_usbmidi_input_data(ep, buffer[0] >> 4,
-				       &buffer[1], buffer_length - 1);
+	int remaining = buffer_length;
+
+	/*
+	 * CME send sysex, song position pointer, system realtime
+	 * and active sensing using CIN 0x0f, which in the standard
+	 * is only intended for single byte unparsed data.
+	 * So we need to interpret these here before sending them on.
+	 * By default, we assume single byte data, which is true
+	 * for system realtime (midi clock, start, stop and continue)
+	 * and active sensing, and handle the other (known) cases
+	 * separately.
+	 * In contrast to the standard, CME does not split sysex
+	 * into multiple 4-byte packets, but lumps everything together
+	 * into one. In addition, CME can string multiple messages
+	 * together in the same packet; pressing the Record button
+	 * on an UF6 sends a sysex message directly followed
+	 * by a song position pointer in the same packet.
+	 * For it to have any reasonable meaning, a sysex message
+	 * needs to be at least 3 bytes in length (0xf0, id, 0xf7),
+	 * corresponding to a packet size of 4 bytes, and the ones sent
+	 * by CME devices are 6 or 7 bytes, making the packet fragments
+	 * 7 or 8 bytes long (six or seven bytes plus preceding CN+CIN byte).
+	 * For the other types, the packet size is always 4 bytes,
+	 * as per the standard, with the data size being 3 for SPP
+	 * and 1 for the others.
+	 * Thus all packet fragments are at least 4 bytes long, so we can
+	 * skip anything that is shorter; this also conveniantly skips
+	 * packets with size 0, which CME devices continuously send when
+	 * they have nothing better to do.
+	 * Another quirk is that sometimes multiple messages are sent
+	 * in the same packet. This has been observed for midi clock
+	 * and active sensing i.e. 0x0f 0xf8 0x00 0x00 0x0f 0xfe 0x00 0x00,
+	 * but also multiple note ons/offs, and control change together
+	 * with MIDI clock. Similarly, some sysex messages are followed by
+	 * the song position pointer in the same packet, and occasionally
+	 * additionally by a midi clock or active sensing.
+	 * We handle this by looping over all data and parsing it along the way.
+	 */
+	while (remaining >= 4) {
+		int source_length = 4; /* default */
+
+		if ((buffer[0] & 0x0f) == 0x0f) {
+			int data_length = 1; /* default */
+
+			if (buffer[1] == 0xf0) {
+				/* Sysex: Find EOX and send on whole message. */
+				/* To kick off the search, skip the first
+				 * two bytes (CN+CIN and SYSEX (0xf0).
+				 */
+				uint8_t *tmp_buf = buffer + 2;
+				int tmp_length = remaining - 2;
+
+				while (tmp_length > 1 && *tmp_buf != 0xf7) {
+					tmp_buf++;
+					tmp_length--;
+				}
+				data_length = tmp_buf - buffer;
+				source_length = data_length + 1;
+			} else if (buffer[1] == 0xf2) {
+				/* Three byte song position pointer */
+				data_length = 3;
+			}
+			snd_usbmidi_input_data(ep, buffer[0] >> 4,
+					       &buffer[1], data_length);
+		} else {
+			/* normal channel events */
+			snd_usbmidi_standard_input(ep, buffer, source_length);
+		}
+		buffer += source_length;
+		remaining -= source_length;
+	}
 }
 
 /*
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 0a7327541c17..46cce18c8308 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -867,8 +867,8 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
 	} pads[] = {
 		{"long", d->ptr_sz * 8}, {"int", 32}, {"short", 16}, {"char", 8}
 	};
-	int new_off, pad_bits, bits, i;
-	const char *pad_type;
+	int new_off = 0, pad_bits = 0, bits, i;
+	const char *pad_type = NULL;
 
 	if (cur_off >= next_off)
 		return; /* no gap */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 286a2c0af02a..127862fa05c6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3990,6 +3990,11 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 			WARN_INSN(insn, "RET before UNTRAIN");
 			return 1;
 
+		case INSN_CONTEXT_SWITCH:
+			if (insn_func(insn))
+				break;
+			return 0;
+
 		case INSN_NOP:
 			if (insn->retpoline_safe)
 				return 0;
diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index e63dc11fa3a5..48e25be6e163 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -120,6 +120,10 @@ FILE *prepare_output(const char *dirname)
 struct config *prepare_default_config()
 {
 	struct config *config = malloc(sizeof(struct config));
+	if (!config) {
+		perror("malloc");
+		return NULL;
+	}
 
 	dprintf("loading defaults\n");
 
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index c76ad0be54e2..7e524601e01a 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4303,6 +4303,14 @@ if (defined($opt{"LOG_FILE"})) {
     if ($opt{"CLEAR_LOG"}) {
 	unlink $opt{"LOG_FILE"};
     }
+
+    if (! -e $opt{"LOG_FILE"} && $opt{"LOG_FILE"} =~ m,^(.*/),) {
+        my $dir = $1;
+        if (! -d $dir) {
+            mkpath($dir) or die "Failed to create directories '$dir': $!";
+            print "\nThe log directory $dir did not exist, so it was created.\n";
+        }
+    }
     open(LOG, ">> $opt{LOG_FILE}") or die "Can't write to $opt{LOG_FILE}";
     LOG->autoflush(1);
 }
diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 7d7a6a06cdb7..2d8230da9064 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -98,7 +98,7 @@ int main(int argc, char *argv[])
 	info("Calling futex_waitv on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
 	res = futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
 	if (!res || errno != EWOULDBLOCK) {
-		ksft_test_result_pass("futex_waitv returned: %d %s\n",
+		ksft_test_result_fail("futex_waitv returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
 		ret = RET_FAIL;
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 1bc16fde2e8a..4766f8fec9f6 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -98,10 +98,54 @@ TEST(abi_version)
 	ASSERT_EQ(EINVAL, errno);
 }
 
+/*
+ * Old source trees might not have the set of Kselftest fixes related to kernel
+ * UAPI headers.
+ */
+#ifndef LANDLOCK_CREATE_RULESET_ERRATA
+#define LANDLOCK_CREATE_RULESET_ERRATA (1U << 1)
+#endif
+
+TEST(errata)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	int errata;
+
+	errata = landlock_create_ruleset(NULL, 0,
+					 LANDLOCK_CREATE_RULESET_ERRATA);
+	/* The errata bitmask will not be backported to tests. */
+	ASSERT_LE(0, errata);
+	TH_LOG("errata: 0x%x", errata);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
+					      LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
+					      LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1,
+		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
+					  LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(
+			      NULL, 0,
+			      LANDLOCK_CREATE_RULESET_VERSION |
+				      LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
+					      LANDLOCK_CREATE_RULESET_ERRATA |
+						      1 << 31));
+	ASSERT_EQ(EINVAL, errno);
+}
+
 /* Tests ordering of syscall argument checks. */
 TEST(create_ruleset_checks_ordering)
 {
-	const int last_flag = LANDLOCK_CREATE_RULESET_VERSION;
+	const int last_flag = LANDLOCK_CREATE_RULESET_ERRATA;
 	const int invalid_flag = last_flag << 1;
 	int ruleset_fd;
 	const struct landlock_ruleset_attr ruleset_attr = {
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 40a2def50b83..60afc1ce11bc 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -68,6 +68,7 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 		CAP_MKNOD,
 		CAP_NET_ADMIN,
 		CAP_NET_BIND_SERVICE,
+		CAP_SETUID,
 		CAP_SYS_ADMIN,
 		CAP_SYS_CHROOT,
 		/* clang-format on */
diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 475ee62a832d..d8bf33417619 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -249,47 +249,67 @@ TEST_F(scoped_domains, check_access_signal)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
-static int thread_pipe[2];
-
 enum thread_return {
 	THREAD_INVALID = 0,
 	THREAD_SUCCESS = 1,
 	THREAD_ERROR = 2,
+	THREAD_TEST_FAILED = 3,
 };
 
-void *thread_func(void *arg)
+static void *thread_sync(void *arg)
 {
+	const int pipe_read = *(int *)arg;
 	char buf;
 
-	if (read(thread_pipe[0], &buf, 1) != 1)
+	if (read(pipe_read, &buf, 1) != 1)
 		return (void *)THREAD_ERROR;
 
 	return (void *)THREAD_SUCCESS;
 }
 
-TEST(signal_scoping_threads)
+TEST(signal_scoping_thread_before)
 {
-	pthread_t no_sandbox_thread, scoped_thread;
+	pthread_t no_sandbox_thread;
 	enum thread_return ret = THREAD_INVALID;
+	int thread_pipe[2];
 
 	drop_caps(_metadata);
 	ASSERT_EQ(0, pipe2(thread_pipe, O_CLOEXEC));
 
-	ASSERT_EQ(0,
-		  pthread_create(&no_sandbox_thread, NULL, thread_func, NULL));
+	ASSERT_EQ(0, pthread_create(&no_sandbox_thread, NULL, thread_sync,
+				    &thread_pipe[0]));
 
-	/* Restricts the domain after creating the first thread. */
+	/* Enforces restriction after creating the thread. */
 	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
 
-	ASSERT_EQ(EPERM, pthread_kill(no_sandbox_thread, 0));
-	ASSERT_EQ(1, write(thread_pipe[1], ".", 1));
-
-	ASSERT_EQ(0, pthread_create(&scoped_thread, NULL, thread_func, NULL));
-	ASSERT_EQ(0, pthread_kill(scoped_thread, 0));
-	ASSERT_EQ(1, write(thread_pipe[1], ".", 1));
+	EXPECT_EQ(0, pthread_kill(no_sandbox_thread, 0));
+	EXPECT_EQ(1, write(thread_pipe[1], ".", 1));
 
 	EXPECT_EQ(0, pthread_join(no_sandbox_thread, (void **)&ret));
 	EXPECT_EQ(THREAD_SUCCESS, ret);
+
+	EXPECT_EQ(0, close(thread_pipe[0]));
+	EXPECT_EQ(0, close(thread_pipe[1]));
+}
+
+TEST(signal_scoping_thread_after)
+{
+	pthread_t scoped_thread;
+	enum thread_return ret = THREAD_INVALID;
+	int thread_pipe[2];
+
+	drop_caps(_metadata);
+	ASSERT_EQ(0, pipe2(thread_pipe, O_CLOEXEC));
+
+	/* Enforces restriction before creating the thread. */
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+
+	ASSERT_EQ(0, pthread_create(&scoped_thread, NULL, thread_sync,
+				    &thread_pipe[0]));
+
+	EXPECT_EQ(0, pthread_kill(scoped_thread, 0));
+	EXPECT_EQ(1, write(thread_pipe[1], ".", 1));
+
 	EXPECT_EQ(0, pthread_join(scoped_thread, (void **)&ret));
 	EXPECT_EQ(THREAD_SUCCESS, ret);
 
@@ -297,6 +317,64 @@ TEST(signal_scoping_threads)
 	EXPECT_EQ(0, close(thread_pipe[1]));
 }
 
+struct thread_setuid_args {
+	int pipe_read, new_uid;
+};
+
+void *thread_setuid(void *ptr)
+{
+	const struct thread_setuid_args *arg = ptr;
+	char buf;
+
+	if (read(arg->pipe_read, &buf, 1) != 1)
+		return (void *)THREAD_ERROR;
+
+	/* libc's setuid() should update all thread's credentials. */
+	if (getuid() != arg->new_uid)
+		return (void *)THREAD_TEST_FAILED;
+
+	return (void *)THREAD_SUCCESS;
+}
+
+TEST(signal_scoping_thread_setuid)
+{
+	struct thread_setuid_args arg;
+	pthread_t no_sandbox_thread;
+	enum thread_return ret = THREAD_INVALID;
+	int pipe_parent[2];
+	int prev_uid;
+
+	disable_caps(_metadata);
+
+	/* This test does not need to be run as root. */
+	prev_uid = getuid();
+	arg.new_uid = prev_uid + 1;
+	EXPECT_LT(0, arg.new_uid);
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	arg.pipe_read = pipe_parent[0];
+
+	/* Capabilities must be set before creating a new thread. */
+	set_cap(_metadata, CAP_SETUID);
+	ASSERT_EQ(0, pthread_create(&no_sandbox_thread, NULL, thread_setuid,
+				    &arg));
+
+	/* Enforces restriction after creating the thread. */
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+
+	EXPECT_NE(arg.new_uid, getuid());
+	EXPECT_EQ(0, setuid(arg.new_uid));
+	EXPECT_EQ(arg.new_uid, getuid());
+	EXPECT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	EXPECT_EQ(0, pthread_join(no_sandbox_thread, (void **)&ret));
+	EXPECT_EQ(THREAD_SUCCESS, ret);
+
+	clear_cap(_metadata, CAP_SETUID);
+	EXPECT_EQ(0, close(pipe_parent[0]));
+	EXPECT_EQ(0, close(pipe_parent[1]));
+}
+
 const short backlog = 10;
 
 static volatile sig_atomic_t signal_received;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index d240d02fa443..c83a8b47bbdf 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1270,7 +1270,7 @@ int main_loop(void)
 
 	if (cfg_input && cfg_sockopt_types.mptfo) {
 		fd_in = open(cfg_input, O_RDONLY);
-		if (fd < 0)
+		if (fd_in < 0)
 			xerror("can't open %s:%d", cfg_input, errno);
 	}
 
@@ -1293,13 +1293,13 @@ int main_loop(void)
 
 	if (cfg_input && !cfg_sockopt_types.mptfo) {
 		fd_in = open(cfg_input, O_RDONLY);
-		if (fd < 0)
+		if (fd_in < 0)
 			xerror("can't open %s:%d", cfg_input, errno);
 	}
 
 	ret = copyfd_io(fd_in, fd, 1, 0, &winfo);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (cfg_truncate > 0) {
 		shutdown(fd, SHUT_WR);
@@ -1320,7 +1320,10 @@ int main_loop(void)
 		close(fd);
 	}
 
-	return 0;
+out:
+	if (cfg_input)
+		close(fd_in);
+	return ret;
 }
 
 int parse_proto(const char *proto)
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index fd6a3010afa8..1f51a4d906b8 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -75,7 +75,7 @@ config KVM_COMPAT
        depends on KVM && COMPAT && !(S390 || ARM64 || RISCV)
 
 config HAVE_KVM_IRQ_BYPASS
-       bool
+       tristate
        select IRQ_BYPASS_MANAGER
 
 config HAVE_KVM_VCPU_ASYNC_IOCTL
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 6b390b622b72..929c7980fda6 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -149,7 +149,7 @@ irqfd_shutdown(struct work_struct *work)
 	/*
 	 * It is now safe to release the object's resources
 	 */
-#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
+#if IS_ENABLED(CONFIG_HAVE_KVM_IRQ_BYPASS)
 	irq_bypass_unregister_consumer(&irqfd->consumer);
 #endif
 	eventfd_ctx_put(irqfd->eventfd);
@@ -274,7 +274,7 @@ static void irqfd_update(struct kvm *kvm, struct kvm_kernel_irqfd *irqfd)
 	write_seqcount_end(&irqfd->irq_entry_sc);
 }
 
-#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
+#if IS_ENABLED(CONFIG_HAVE_KVM_IRQ_BYPASS)
 void __attribute__((weak)) kvm_arch_irq_bypass_stop(
 				struct irq_bypass_consumer *cons)
 {
@@ -425,7 +425,7 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	if (events & EPOLLIN)
 		schedule_work(&irqfd->inject);
 
-#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
+#if IS_ENABLED(CONFIG_HAVE_KVM_IRQ_BYPASS)
 	if (kvm_arch_has_irq_bypass()) {
 		irqfd->consumer.token = (void *)irqfd->eventfd;
 		irqfd->consumer.add_producer = kvm_arch_irq_bypass_add_producer;
@@ -618,14 +618,14 @@ void kvm_irq_routing_update(struct kvm *kvm)
 	spin_lock_irq(&kvm->irqfds.lock);
 
 	list_for_each_entry(irqfd, &kvm->irqfds.items, list) {
-#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
+#if IS_ENABLED(CONFIG_HAVE_KVM_IRQ_BYPASS)
 		/* Under irqfds.lock, so can read irq_entry safely */
 		struct kvm_kernel_irq_routing_entry old = irqfd->irq_entry;
 #endif
 
 		irqfd_update(kvm, irqfd);
 
-#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
+#if IS_ENABLED(CONFIG_HAVE_KVM_IRQ_BYPASS)
 		if (irqfd->producer &&
 		    kvm_arch_irqfd_route_changed(&old, &irqfd->irq_entry)) {
 			int ret = kvm_arch_update_irqfd_routing(

