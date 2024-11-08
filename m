Return-Path: <stable+bounces-91945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1D9C2152
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EC61C2330F
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74A521B459;
	Fri,  8 Nov 2024 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WDv0ZhHu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2525221B446;
	Fri,  8 Nov 2024 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081579; cv=none; b=tuqg+yoFZ2Hs0hAtOcOOq2+rO0k7WCAmQouPjbbgzR5/neTnTi8c6vOemf1/IkLOm7Uyd60F1TvvrD/HA9BWhFxcJwCq/WYoKMdC7hQFnz9Eg86t7AhXj5mdcLQTob5IQlefr4BbHCsdTG0xl5VFKDoZcATR3lz3gh1h40Y5v7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081579; c=relaxed/simple;
	bh=YolpKGxs0tPIE6qWzqwulqlO6Qq2eOk52EppldkFQVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxfzokWnNuekno+bwmY7MxWu0uCXumxKhYYlLJKlhmb/7IrxcRwaQ3VbIm5L+eCIXHHXuh0Bqb4vTX6A8edWvmbUjaI6ZxYEckjfamtzPhX8MV4Vlq+nnU2nCB74WfKahDJd5ULMRehatqTX9E0lVAhHAyM0sE1cb3Xjgd4Kpu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WDv0ZhHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825C5C4CECD;
	Fri,  8 Nov 2024 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731081577;
	bh=YolpKGxs0tPIE6qWzqwulqlO6Qq2eOk52EppldkFQVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDv0ZhHuU4T0UBjkK4MSzhoxUMBYNwDsbRjUsCIos7cGoya28SzVmWkJ+V2o5tKDd
	 oEVa2YpbjE5VWjvgdiIjztDkWKXP/j0kHtPOIs1b7cjSeMVmL3iaG944pxBqC0chx+
	 XZIXaG22b0Hxs/xxkBUoRobV6NUAodSVseQrwS6I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.323
Date: Fri,  8 Nov 2024 16:59:09 +0100
Message-ID: <2024110809-showgirl-awkward-e85d@gregkh>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024110809-unbalance-erupt-8ba5@gregkh>
References: <2024110809-unbalance-erupt-8ba5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/.gitignore b/.gitignore
index 97ba6b79834c..0cf6d31dbbad 100644
--- a/.gitignore
+++ b/.gitignore
@@ -114,7 +114,6 @@ GTAGS
 # id-utils files
 ID
 
-*.orig
 *~
 \#*#
 
diff --git a/Documentation/IPMI.txt b/Documentation/IPMI.txt
index 5ef1047e2e66..f3c6530d9f35 100644
--- a/Documentation/IPMI.txt
+++ b/Documentation/IPMI.txt
@@ -518,7 +518,7 @@ at module load time (for a module) with::
 	[dbg_probe=1]
 
 The addresses are normal I2C addresses.  The adapter is the string
-name of the adapter, as shown in /sys/class/i2c-adapter/i2c-<n>/name.
+name of the adapter, as shown in /sys/bus/i2c/devices/i2c-<n>/name.
 It is *NOT* i2c-<n> itself.  Also, the comparison is done ignoring
 spaces, so if the name is "This is an I2C chip" you can say
 adapter_name=ThisisanI2cchip.  This is because it's hard to pass in
diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index eab3b0cf0dbe..a67ba12ffa03 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -66,6 +66,7 @@ stable kernels.
 | ARM            | Cortex-A78      | #3324344        | ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-A78C     | #3324346,3324347| ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-A715     | #3456084        | ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-A720     | #3456091        | ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
@@ -77,6 +78,7 @@ stable kernels.
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
 | ARM            | Neoverse-N1     | #3324349        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
+| ARM            | Neoverse-N3     | #3456111        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-V1     | #3324341        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 43681ca0837f..5a2d8c7ce247 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -235,6 +235,7 @@ certainly invest a bit more effort into libata core layer).
 
 CLOCK
   devm_clk_get()
+  devm_clk_get_optional()
   devm_clk_put()
   devm_clk_hw_register()
   devm_of_clk_add_hw_provider()
diff --git a/Makefile b/Makefile
index 64cc724be113..0f4d0d011787 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 322
+SUBLEVEL = 323
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm/mach-realview/platsmp-dt.c b/arch/arm/mach-realview/platsmp-dt.c
index c242423bf8db..66d6b11eda7b 100644
--- a/arch/arm/mach-realview/platsmp-dt.c
+++ b/arch/arm/mach-realview/platsmp-dt.c
@@ -70,6 +70,7 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
 		return;
 	}
 	map = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (IS_ERR(map)) {
 		pr_err("PLATSMP: No syscon regmap\n");
 		return;
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 15c7a2b6e491..5fa1b1d3172e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -543,6 +543,7 @@ config ARM64_ERRATUM_3194386
 	  * ARM Cortex-A78C erratum 3324346
 	  * ARM Cortex-A78C erratum 3324347
 	  * ARM Cortex-A710 erratam 3324338
+	  * ARM Cortex-A715 errartum 3456084
 	  * ARM Cortex-A720 erratum 3456091
 	  * ARM Cortex-A725 erratum 3456106
 	  * ARM Cortex-X1 erratum 3324344
@@ -553,6 +554,7 @@ config ARM64_ERRATUM_3194386
 	  * ARM Cortex-X925 erratum 3324334
 	  * ARM Neoverse-N1 erratum 3324349
 	  * ARM Neoverse N2 erratum 3324339
+	  * ARM Neoverse-N3 erratum 3456111
 	  * ARM Neoverse-V1 erratum 3324341
 	  * ARM Neoverse V2 erratum 3324336
 	  * ARM Neoverse-V3 erratum 3312417
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index a0470f014e56..c65a14fbb3e5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -147,6 +147,22 @@
 	status = "okay";
 };
 
+&gpio3 {
+	/*
+	 * The Qseven BIOS_DISABLE signal on the RK3399-Q7 keeps the on-module
+	 * eMMC and SPI flash powered-down initially (in fact it keeps the
+	 * reset signal asserted). BIOS_DISABLE_OVERRIDE pin allows to override
+	 * that signal so that eMMC and SPI can be used regardless of the state
+	 * of the signal.
+	 */
+	bios-disable-override-hog {
+		gpios = <RK_PD5 GPIO_ACTIVE_LOW>;
+		gpio-hog;
+		line-name = "bios_disable_override";
+		output-high;
+	};
+};
+
 &gmac {
 	assigned-clocks = <&cru SCLK_RMII_SRC>;
 	assigned-clock-parents = <&clkin_gmac>;
@@ -433,9 +449,14 @@
 
 &pinctrl {
 	pinctrl-names = "default";
-	pinctrl-0 = <&q7_thermal_pin>;
+	pinctrl-0 = <&q7_thermal_pin &bios_disable_override_hog_pin>;
 
 	gpios {
+		bios_disable_override_hog_pin: bios-disable-override-hog-pin {
+			rockchip,pins =
+				<3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
 		q7_thermal_pin: q7-thermal-pin {
 			rockchip,pins =
 				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index f8be4d7ecde2..b8593cebb4ff 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -86,6 +86,7 @@
 #define ARM_CPU_PART_CORTEX_A78		0xD41
 #define ARM_CPU_PART_CORTEX_X1		0xD44
 #define ARM_CPU_PART_CORTEX_A710	0xD47
+#define ARM_CPU_PART_CORTEX_A715	0xD4D
 #define ARM_CPU_PART_CORTEX_X2		0xD48
 #define ARM_CPU_PART_NEOVERSE_N2	0xD49
 #define ARM_CPU_PART_CORTEX_A78C	0xD4B
@@ -97,6 +98,7 @@
 #define ARM_CPU_PART_NEOVERSE_V3	0xD84
 #define ARM_CPU_PART_CORTEX_X925	0xD85
 #define ARM_CPU_PART_CORTEX_A725	0xD87
+#define ARM_CPU_PART_NEOVERSE_N3	0xD8E
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -130,6 +132,7 @@
 #define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
 #define MIDR_CORTEX_X1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1)
 #define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A710)
+#define MIDR_CORTEX_A715 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A715)
 #define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
 #define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
 #define MIDR_CORTEX_A78C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78C)
@@ -141,6 +144,7 @@
 #define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
 #define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
 #define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
+#define MIDR_NEOVERSE_N3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N3)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
diff --git a/arch/arm64/include/asm/uprobes.h b/arch/arm64/include/asm/uprobes.h
index 8d004073d0e8..f57c96ac042f 100644
--- a/arch/arm64/include/asm/uprobes.h
+++ b/arch/arm64/include/asm/uprobes.h
@@ -13,21 +13,19 @@
 #include <asm/insn.h>
 #include <asm/probes.h>
 
-#define MAX_UINSN_BYTES		AARCH64_INSN_SIZE
-
-#define UPROBE_SWBP_INSN	BRK64_OPCODE_UPROBES
+#define UPROBE_SWBP_INSN	cpu_to_le32(BRK64_OPCODE_UPROBES)
 #define UPROBE_SWBP_INSN_SIZE	AARCH64_INSN_SIZE
-#define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
+#define UPROBE_XOL_SLOT_BYTES	AARCH64_INSN_SIZE
 
-typedef u32 uprobe_opcode_t;
+typedef __le32 uprobe_opcode_t;
 
 struct arch_uprobe_task {
 };
 
 struct arch_uprobe {
 	union {
-		u8 insn[MAX_UINSN_BYTES];
-		u8 ixol[MAX_UINSN_BYTES];
+		__le32 insn;
+		__le32 ixol;
 	};
 	struct arch_probe_insn api;
 	bool simulate;
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index e87f8d60075d..a92530a8d7fc 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -714,6 +714,7 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
@@ -724,6 +725,7 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N3),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index 6bf6657a5a52..3d0684b72839 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -104,10 +104,6 @@ arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api)
 	    aarch64_insn_is_blr(insn) ||
 	    aarch64_insn_is_ret(insn)) {
 		api->handler = simulate_br_blr_ret;
-	} else if (aarch64_insn_is_ldr_lit(insn)) {
-		api->handler = simulate_ldr_literal;
-	} else if (aarch64_insn_is_ldrsw_lit(insn)) {
-		api->handler = simulate_ldrsw_literal;
 	} else {
 		/*
 		 * Instruction cannot be stepped out-of-line and we don't
@@ -145,6 +141,17 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
 	probe_opcode_t insn = le32_to_cpu(*addr);
 	probe_opcode_t *scan_end = NULL;
 	unsigned long size = 0, offset = 0;
+	struct arch_probe_insn *api = &asi->api;
+
+	if (aarch64_insn_is_ldr_lit(insn)) {
+		api->handler = simulate_ldr_literal;
+		decoded = INSN_GOOD_NO_SLOT;
+	} else if (aarch64_insn_is_ldrsw_lit(insn)) {
+		api->handler = simulate_ldrsw_literal;
+		decoded = INSN_GOOD_NO_SLOT;
+	} else {
+		decoded = arm_probe_decode_insn(insn, &asi->api);
+	}
 
 	/*
 	 * If there's a symbol defined in front of and near enough to
@@ -162,7 +169,6 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
 		else
 			scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
 	}
-	decoded = arm_probe_decode_insn(insn, &asi->api);
 
 	if (decoded != INSN_REJECTED && scan_end)
 		if (is_probed_address_atomic(addr - 1, scan_end))
diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
index be05868418ee..a98699948cb2 100644
--- a/arch/arm64/kernel/probes/simulate-insn.c
+++ b/arch/arm64/kernel/probes/simulate-insn.c
@@ -178,17 +178,15 @@ simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs)
 void __kprobes
 simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs)
 {
-	u64 *load_addr;
+	unsigned long load_addr;
 	int xn = opcode & 0x1f;
-	int disp;
 
-	disp = ldr_displacement(opcode);
-	load_addr = (u64 *) (addr + disp);
+	load_addr = addr + ldr_displacement(opcode);
 
 	if (opcode & (1 << 30))	/* x0-x30 */
-		set_x_reg(regs, xn, *load_addr);
+		set_x_reg(regs, xn, READ_ONCE(*(u64 *)load_addr));
 	else			/* w0-w30 */
-		set_w_reg(regs, xn, *load_addr);
+		set_w_reg(regs, xn, READ_ONCE(*(u32 *)load_addr));
 
 	instruction_pointer_set(regs, instruction_pointer(regs) + 4);
 }
@@ -196,14 +194,12 @@ simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs)
 void __kprobes
 simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)
 {
-	s32 *load_addr;
+	unsigned long load_addr;
 	int xn = opcode & 0x1f;
-	int disp;
 
-	disp = ldr_displacement(opcode);
-	load_addr = (s32 *) (addr + disp);
+	load_addr = addr + ldr_displacement(opcode);
 
-	set_x_reg(regs, xn, *load_addr);
+	set_x_reg(regs, xn, READ_ONCE(*(s32 *)load_addr));
 
 	instruction_pointer_set(regs, instruction_pointer(regs) + 4);
 }
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index 6aeb11aa7e28..851689216007 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -45,7 +45,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	else if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
 		return -EINVAL;
 
-	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
+	insn = le32_to_cpu(auprobe->insn);
 
 	switch (arm_probe_decode_insn(insn, &auprobe->api)) {
 	case INSN_REJECTED:
@@ -111,7 +111,7 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 	if (!auprobe->simulate)
 		return false;
 
-	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
+	insn = le32_to_cpu(auprobe->insn);
 	addr = instruction_pointer(regs);
 
 	if (auprobe->api.handler)
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index df6de7ccdc2e..ecad6d8b9154 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -289,11 +289,6 @@ asmlinkage void __init mmu_init(void)
 {
 	unsigned int kstart, ksize;
 
-	if (!memblock.reserved.cnt) {
-		pr_emerg("Error memory count\n");
-		machine_restart(NULL);
-	}
-
 	if ((u32) memblock.memory.regions[0].size < 0x400000) {
 		pr_emerg("Memory must be greater than 4MB\n");
 		machine_restart(NULL);
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index a0c251c4f302..7125743459fa 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -1089,8 +1089,7 @@ ENTRY_CFI(intr_save)		/* for os_hpmc */
 	STREG           %r16, PT_ISR(%r29)
 	STREG           %r17, PT_IOR(%r29)
 
-#if 0 && defined(CONFIG_64BIT)
-	/* Revisit when we have 64-bit code above 4Gb */
+#if defined(CONFIG_64BIT)
 	b,n		intr_save2
 
 skip_save_ior:
@@ -1098,8 +1097,7 @@ skip_save_ior:
 	 * need to adjust iasq/iaoq here in the same way we adjusted isr/ior
 	 * above.
 	 */
-	extrd,u,*	%r8,PSW_W_BIT,1,%r1
-	cmpib,COND(=),n	1,%r1,intr_save2
+	bb,COND(>=),n	%r8,PSW_W_BIT,intr_save2
 	LDREG		PT_IASQ0(%r29), %r16
 	LDREG		PT_IAOQ0(%r29), %r17
 	/* adjust iasq/iaoq */
diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
index 1ae007ec65c5..1ec58848bb3e 100644
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -217,10 +217,10 @@ linux_gateway_entry:
 
 #ifdef CONFIG_64BIT
 	ldil	L%sys_call_table, %r1
-	or,=	%r2,%r2,%r2
-	addil	L%(sys_call_table64-sys_call_table), %r1
+	or,ev	%r2,%r2,%r2
+	ldil	L%sys_call_table64, %r1
 	ldo	R%sys_call_table(%r1), %r19
-	or,=	%r2,%r2,%r2
+	or,ev	%r2,%r2,%r2
 	ldo	R%sys_call_table64(%r1), %r19
 #else
 	load32	sys_call_table, %r19
@@ -355,10 +355,10 @@ tracesys_next:
 	extrd,u	%r19,63,1,%r2			/* W hidden in bottom bit */
 
 	ldil	L%sys_call_table, %r1
-	or,=	%r2,%r2,%r2
-	addil	L%(sys_call_table64-sys_call_table), %r1
+	or,ev	%r2,%r2,%r2
+	ldil	L%sys_call_table64, %r1
 	ldo	R%sys_call_table(%r1), %r19
-	or,=	%r2,%r2,%r2
+	or,ev	%r2,%r2,%r2
 	ldo	R%sys_call_table64(%r1), %r19
 #else
 	load32	sys_call_table, %r19
@@ -930,6 +930,8 @@ ENTRY(sys_call_table)
 END(sys_call_table)
 
 #ifdef CONFIG_64BIT
+#undef __SYSCALL_WITH_COMPAT
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
 	.align 8
 ENTRY(sys_call_table64)
 #define SYSCALL_TABLE_64BIT
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a344980287a5..a2dc7918c52a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -84,6 +84,11 @@ config GENERIC_CSUM
 config GENERIC_HWEIGHT
 	def_bool y
 
+config ILLEGAL_POINTER_VALUE
+	hex
+	default 0 if 32BIT
+	default 0xdead000000000000 if 64BIT
+
 config PGTABLE_LEVELS
 	int
 	default 3 if 64BIT
diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
index 7ffbc5d7ccf3..79730031e17f 100644
--- a/arch/s390/include/asm/facility.h
+++ b/arch/s390/include/asm/facility.h
@@ -53,8 +53,10 @@ static inline int test_facility(unsigned long nr)
 	unsigned long facilities_als[] = { FACILITIES_ALS };
 
 	if (__builtin_constant_p(nr) && nr < sizeof(facilities_als) * 8) {
-		if (__test_facility(nr, &facilities_als))
-			return 1;
+		if (__test_facility(nr, &facilities_als)) {
+			if (!__is_defined(__DECOMPRESSOR))
+				return 1;
+		}
 	}
 	return __test_facility(nr, &S390_lowcore.stfle_fac_list);
 }
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index c8e1e325215b..c7f94b5d9396 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1360,7 +1360,7 @@ static int aux_output_begin(struct perf_output_handle *handle,
 	unsigned long head, base, offset;
 	struct hws_trailer_entry *te;
 
-	if (WARN_ON_ONCE(handle->head & ~PAGE_MASK))
+	if (handle->head & ~PAGE_MASK)
 		return -EINVAL;
 
 	aux->head = handle->head >> PAGE_SHIFT;
@@ -1528,7 +1528,7 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 	unsigned long num_sdb;
 
 	aux = perf_get_aux(handle);
-	if (WARN_ON_ONCE(!aux))
+	if (!aux)
 		return;
 
 	/* Inform user space new data arrived */
@@ -1547,7 +1547,7 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 			debug_sprintf_event(sfdbg, 1, "AUX buffer used up\n");
 			break;
 		}
-		if (WARN_ON_ONCE(!aux))
+		if (!aux)
 			return;
 
 		/* Update head and alert_mark to new position */
@@ -1746,12 +1746,8 @@ static void cpumsf_pmu_start(struct perf_event *event, int flags)
 {
 	struct cpu_hw_sf *cpuhw = this_cpu_ptr(&cpu_hw_sf);
 
-	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
+	if (!(event->hw.state & PERF_HES_STOPPED))
 		return;
-
-	if (flags & PERF_EF_RELOAD)
-		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
-
 	perf_pmu_disable(event->pmu);
 	event->hw.state = 0;
 	cpuhw->lsctl.cs = 1;
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 45634b3d2e0a..584c5da9b3fe 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -78,7 +78,7 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
 	vcpu->stat.diagnose_258++;
 	if (vcpu->run->s.regs.gprs[rx] & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	rc = read_guest(vcpu, vcpu->run->s.regs.gprs[rx], rx, &parm, sizeof(parm));
+	rc = read_guest_real(vcpu, vcpu->run->s.regs.gprs[rx], &parm, sizeof(parm));
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	if (parm.parm_version != 2 || parm.parm_len < 5 || parm.code != 0x258)
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 07d30ffcfa41..11ddac5e3e92 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -794,46 +794,102 @@ static int low_address_protection_enabled(struct kvm_vcpu *vcpu,
 	return 1;
 }
 
-static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
-			    unsigned long *pages, unsigned long nr_pages,
-			    const union asce asce, enum gacc_mode mode)
+/**
+ * guest_range_to_gpas() - Calculate guest physical addresses of page fragments
+ * covering a logical range
+ * @vcpu: virtual cpu
+ * @ga: guest address, start of range
+ * @ar: access register
+ * @gpas: output argument, may be NULL
+ * @len: length of range in bytes
+ * @asce: address-space-control element to use for translation
+ * @mode: access mode
+ *
+ * Translate a logical range to a series of guest absolute addresses,
+ * such that the concatenation of page fragments starting at each gpa make up
+ * the whole range.
+ * The translation is performed as if done by the cpu for the given @asce, @ar,
+ * @mode and state of the @vcpu.
+ * If the translation causes an exception, its program interruption code is
+ * returned and the &struct kvm_s390_pgm_info pgm member of @vcpu is modified
+ * such that a subsequent call to kvm_s390_inject_prog_vcpu() will inject
+ * a correct exception into the guest.
+ * The resulting gpas are stored into @gpas, unless it is NULL.
+ *
+ * Note: All fragments except the first one start at the beginning of a page.
+ *	 When deriving the boundaries of a fragment from a gpa, all but the last
+ *	 fragment end at the end of the page.
+ *
+ * Return:
+ * * 0		- success
+ * * <0		- translation could not be performed, for example if  guest
+ *		  memory could not be accessed
+ * * >0		- an access exception occurred. In this case the returned value
+ *		  is the program interruption code and the contents of pgm may
+ *		  be used to inject an exception into the guest.
+ */
+static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
+			       unsigned long *gpas, unsigned long len,
+			       const union asce asce, enum gacc_mode mode)
 {
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
+	unsigned int offset = offset_in_page(ga);
+	unsigned int fragment_len;
 	int lap_enabled, rc = 0;
 	enum prot_type prot;
+	unsigned long gpa;
 
 	lap_enabled = low_address_protection_enabled(vcpu, asce);
-	while (nr_pages) {
+	while (min(PAGE_SIZE - offset, len) > 0) {
+		fragment_len = min(PAGE_SIZE - offset, len);
 		ga = kvm_s390_logical_to_effective(vcpu, ga);
 		if (mode == GACC_STORE && lap_enabled && is_low_address(ga))
 			return trans_exc(vcpu, PGM_PROTECTION, ga, ar, mode,
 					 PROT_TYPE_LA);
-		ga &= PAGE_MASK;
 		if (psw_bits(*psw).dat) {
-			rc = guest_translate(vcpu, ga, pages, asce, mode, &prot);
+			rc = guest_translate(vcpu, ga, &gpa, asce, mode, &prot);
 			if (rc < 0)
 				return rc;
 		} else {
-			*pages = kvm_s390_real_to_abs(vcpu, ga);
-			if (kvm_is_error_gpa(vcpu->kvm, *pages))
+			gpa = kvm_s390_real_to_abs(vcpu, ga);
+			if (kvm_is_error_gpa(vcpu->kvm, gpa))
 				rc = PGM_ADDRESSING;
 		}
 		if (rc)
 			return trans_exc(vcpu, rc, ga, ar, mode, prot);
-		ga += PAGE_SIZE;
-		pages++;
-		nr_pages--;
+		if (gpas)
+			*gpas++ = gpa;
+		offset = 0;
+		ga += fragment_len;
+		len -= fragment_len;
 	}
 	return 0;
 }
 
+static int access_guest_page(struct kvm *kvm, enum gacc_mode mode, gpa_t gpa,
+			     void *data, unsigned int len)
+{
+	const unsigned int offset = offset_in_page(gpa);
+	const gfn_t gfn = gpa_to_gfn(gpa);
+	int rc;
+
+	if (!gfn_to_memslot(kvm, gfn))
+		return PGM_ADDRESSING;
+	if (mode == GACC_STORE)
+		rc = kvm_write_guest_page(kvm, gfn, data, offset, len);
+	else
+		rc = kvm_read_guest_page(kvm, gfn, data, offset, len);
+	return rc;
+}
+
 int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
 		 unsigned long len, enum gacc_mode mode)
 {
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
-	unsigned long _len, nr_pages, gpa, idx;
-	unsigned long pages_array[2];
-	unsigned long *pages;
+	unsigned long nr_pages, idx;
+	unsigned long gpa_array[2];
+	unsigned int fragment_len;
+	unsigned long *gpas;
 	int need_ipte_lock;
 	union asce asce;
 	int rc;
@@ -845,50 +901,45 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
 	if (rc)
 		return rc;
 	nr_pages = (((ga & ~PAGE_MASK) + len - 1) >> PAGE_SHIFT) + 1;
-	pages = pages_array;
-	if (nr_pages > ARRAY_SIZE(pages_array))
-		pages = vmalloc(array_size(nr_pages, sizeof(unsigned long)));
-	if (!pages)
+	gpas = gpa_array;
+	if (nr_pages > ARRAY_SIZE(gpa_array))
+		gpas = vmalloc(array_size(nr_pages, sizeof(unsigned long)));
+	if (!gpas)
 		return -ENOMEM;
 	need_ipte_lock = psw_bits(*psw).dat && !asce.r;
 	if (need_ipte_lock)
 		ipte_lock(vcpu);
-	rc = guest_page_range(vcpu, ga, ar, pages, nr_pages, asce, mode);
+	rc = guest_range_to_gpas(vcpu, ga, ar, gpas, len, asce, mode);
 	for (idx = 0; idx < nr_pages && !rc; idx++) {
-		gpa = *(pages + idx) + (ga & ~PAGE_MASK);
-		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
-		if (mode == GACC_STORE)
-			rc = kvm_write_guest(vcpu->kvm, gpa, data, _len);
-		else
-			rc = kvm_read_guest(vcpu->kvm, gpa, data, _len);
-		len -= _len;
-		ga += _len;
-		data += _len;
+		fragment_len = min(PAGE_SIZE - offset_in_page(gpas[idx]), len);
+		rc = access_guest_page(vcpu->kvm, mode, gpas[idx], data, fragment_len);
+		len -= fragment_len;
+		data += fragment_len;
 	}
 	if (need_ipte_lock)
 		ipte_unlock(vcpu);
-	if (nr_pages > ARRAY_SIZE(pages_array))
-		vfree(pages);
+	if (nr_pages > ARRAY_SIZE(gpa_array))
+		vfree(gpas);
 	return rc;
 }
 
 int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 		      void *data, unsigned long len, enum gacc_mode mode)
 {
-	unsigned long _len, gpa;
+	unsigned int fragment_len;
+	unsigned long gpa;
 	int rc = 0;
 
 	while (len && !rc) {
 		gpa = kvm_s390_real_to_abs(vcpu, gra);
-		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
-		if (mode)
-			rc = write_guest_abs(vcpu, gpa, data, _len);
-		else
-			rc = read_guest_abs(vcpu, gpa, data, _len);
-		len -= _len;
-		gra += _len;
-		data += _len;
+		fragment_len = min(PAGE_SIZE - offset_in_page(gpa), len);
+		rc = access_guest_page(vcpu->kvm, mode, gpa, data, fragment_len);
+		len -= fragment_len;
+		gra += fragment_len;
+		data += fragment_len;
 	}
+	if (rc > 0)
+		vcpu->arch.pgm.code = rc;
 	return rc;
 }
 
@@ -904,8 +955,6 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 			    unsigned long *gpa, enum gacc_mode mode)
 {
-	psw_t *psw = &vcpu->arch.sie_block->gpsw;
-	enum prot_type prot;
 	union asce asce;
 	int rc;
 
@@ -913,23 +962,7 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 	rc = get_vcpu_asce(vcpu, &asce, gva, ar, mode);
 	if (rc)
 		return rc;
-	if (is_low_address(gva) && low_address_protection_enabled(vcpu, asce)) {
-		if (mode == GACC_STORE)
-			return trans_exc(vcpu, PGM_PROTECTION, gva, 0,
-					 mode, PROT_TYPE_LA);
-	}
-
-	if (psw_bits(*psw).dat && !asce.r) {	/* Use DAT? */
-		rc = guest_translate(vcpu, gva, gpa, asce, mode, &prot);
-		if (rc > 0)
-			return trans_exc(vcpu, rc, gva, 0, mode, prot);
-	} else {
-		*gpa = kvm_s390_real_to_abs(vcpu, gva);
-		if (kvm_is_error_gpa(vcpu->kvm, *gpa))
-			return trans_exc(vcpu, rc, gva, PGM_ADDRESSING, mode, 0);
-	}
-
-	return rc;
+	return guest_range_to_gpas(vcpu, gva, ar, gpa, 1, asce, mode);
 }
 
 /**
@@ -938,17 +971,14 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 		    unsigned long length, enum gacc_mode mode)
 {
-	unsigned long gpa;
-	unsigned long currlen;
+	union asce asce;
 	int rc = 0;
 
+	rc = get_vcpu_asce(vcpu, &asce, gva, ar, mode);
+	if (rc)
+		return rc;
 	ipte_lock(vcpu);
-	while (length > 0 && !rc) {
-		currlen = min(length, PAGE_SIZE - (gva % PAGE_SIZE));
-		rc = guest_translate_address(vcpu, gva, ar, &gpa, mode);
-		gva += currlen;
-		length -= currlen;
-	}
+	rc = guest_range_to_gpas(vcpu, gva, ar, NULL, length, asce, mode);
 	ipte_unlock(vcpu);
 
 	return rc;
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 4c56de542960..6c97cde8623a 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -344,11 +344,12 @@ int read_guest_abs(struct kvm_vcpu *vcpu, unsigned long gpa, void *data,
  * @len: number of bytes to copy
  *
  * Copy @len bytes from @data (kernel space) to @gra (guest real address).
- * It is up to the caller to ensure that the entire guest memory range is
- * valid memory before calling this function.
  * Guest low address and key protection are not checked.
  *
- * Returns zero on success or -EFAULT on error.
+ * Returns zero on success, -EFAULT when copying from @data failed, or
+ * PGM_ADRESSING in case @gra is outside a memslot. In this case, pgm check info
+ * is also stored to allow injecting into the guest (if applicable) using
+ * kvm_s390_inject_prog_cond().
  *
  * If an error occurs data may have been copied partially to guest memory.
  */
@@ -367,11 +368,12 @@ int write_guest_real(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
  * @len: number of bytes to copy
  *
  * Copy @len bytes from @gra (guest real address) to @data (kernel space).
- * It is up to the caller to ensure that the entire guest memory range is
- * valid memory before calling this function.
  * Guest key protection is not checked.
  *
- * Returns zero on success or -EFAULT on error.
+ * Returns zero on success, -EFAULT when copying to @data failed, or
+ * PGM_ADRESSING in case @gra is outside a memslot. In this case, pgm check info
+ * is also stored to allow injecting into the guest (if applicable) using
+ * kvm_s390_inject_prog_cond().
  *
  * If an error occurs data may have been copied partially to kernel space.
  */
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index a51c892f14f3..756aefbd0524 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -98,11 +98,12 @@ static long cmm_alloc_pages(long nr, long *counter,
 		(*counter)++;
 		spin_unlock(&cmm_lock);
 		nr--;
+		cond_resched();
 	}
 	return nr;
 }
 
-static long cmm_free_pages(long nr, long *counter, struct cmm_page_array **list)
+static long __cmm_free_pages(long nr, long *counter, struct cmm_page_array **list)
 {
 	struct cmm_page_array *pa;
 	unsigned long addr;
@@ -126,6 +127,21 @@ static long cmm_free_pages(long nr, long *counter, struct cmm_page_array **list)
 	return nr;
 }
 
+static long cmm_free_pages(long nr, long *counter, struct cmm_page_array **list)
+{
+	long inc = 0;
+
+	while (nr) {
+		inc = min(256L, nr);
+		nr -= inc;
+		inc = __cmm_free_pages(inc, counter, list);
+		if (inc)
+			break;
+		cond_resched();
+	}
+	return nr + inc;
+}
+
 static int cmm_oom_notify(struct notifier_block *self,
 			  unsigned long dummy, void *parm)
 {
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 464b2b5d87bd..551db384bcb3 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -216,7 +216,7 @@
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
 #define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* "" AMD SSBD implementation via LS_CFG MSR */
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
-#define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
+#define X86_FEATURE_IBPB		( 7*32+26) /* "ibpb" Indirect Branch Prediction Barrier without a guaranteed RSB flush */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
@@ -306,6 +306,7 @@
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 #define X86_FEATURE_BTC_NO		(13*32+29) /* "" Not vulnerable to Branch Type Confusion */
+#define X86_FEATURE_AMD_IBPB_RET	(13*32+30) /* "" IBPB clears return address predictor */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 9318fe7d850e..e316f5a2aab4 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -484,7 +484,19 @@ static int lapic_timer_shutdown(struct clock_event_device *evt)
 	v = apic_read(APIC_LVTT);
 	v |= (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
 	apic_write(APIC_LVTT, v);
-	apic_write(APIC_TMICT, 0);
+
+	/*
+	 * Setting APIC_LVT_MASKED (above) should be enough to tell
+	 * the hardware that this timer will never fire. But AMD
+	 * erratum 411 and some Intel CPU behavior circa 2024 say
+	 * otherwise.  Time for belt and suspenders programming: mask
+	 * the timer _and_ zero the counter registers:
+	 */
+	if (v & APIC_LVT_TIMER_TSCDEADLINE)
+		wrmsrl(MSR_IA32_TSC_DEADLINE, 0);
+	else
+		apic_write(APIC_TMICT, 0);
+
 	return 0;
 }
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f8b0fa2dbe37..b43f25b3c99d 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -243,6 +243,7 @@ static void __init ms_hyperv_init_platform(void)
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		x86_platform.calibrate_tsc = hv_get_tsc_khz;
 		x86_platform.calibrate_cpu = hv_get_tsc_khz;
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 
 	if (ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED) {
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 075ed47993bb..69fd1134b7fc 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -862,7 +862,7 @@ char * __init xen_memory_setup(void)
 	 * to relocating (and even reusing) pages with kernel text or data.
 	 */
 	if (xen_is_e820_reserved(__pa_symbol(_text),
-			__pa_symbol(__bss_stop) - __pa_symbol(_text))) {
+				 __pa_symbol(_end) - __pa_symbol(_text))) {
 		xen_raw_console_write("Xen hypervisor allocated kernel memory conflicts with E820 map\n");
 		BUG();
 	}
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7415db053217..afc30a200fe8 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2226,8 +2226,12 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	struct bfq_queue *in_service_bfqq, *new_bfqq;
 
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
 	 * Prevent bfqq from being merged if it has been created too
@@ -5033,7 +5037,7 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq)
 {
 	bfq_log_bfqq(bfqq->bfqd, bfqq, "splitting queue");
 
-	if (bfqq_process_refs(bfqq) == 1) {
+	if (bfqq_process_refs(bfqq) == 1 && !bfqq->new_bfqq) {
 		bfqq->pid = current->pid;
 		bfq_clear_bfqq_coop(bfqq);
 		bfq_clear_bfqq_split_coop(bfqq);
@@ -5218,7 +5222,8 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	 * addition, if the queue has also just been split, we have to
 	 * resume its state.
 	 */
-	if (likely(bfqq != &bfqd->oom_bfqq) && bfqq_process_refs(bfqq) == 1) {
+	if (likely(bfqq != &bfqd->oom_bfqq) && !bfqq->new_bfqq &&
+	    bfqq_process_refs(bfqq) == 1) {
 		bfqq->bic = bic;
 		if (split) {
 			/*
diff --git a/crypto/aead.c b/crypto/aead.c
index 9688ada13981..f8b2cd0567f1 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -45,8 +45,7 @@ static int setkey_unaligned(struct crypto_aead *tfm, const u8 *key,
 	alignbuffer = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
 	memcpy(alignbuffer, key, keylen);
 	ret = crypto_aead_alg(tfm)->setkey(tfm, alignbuffer, keylen);
-	memset(alignbuffer, 0, keylen);
-	kfree(buffer);
+	kzfree(buffer);
 	return ret;
 }
 
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 57836c30a49a..3d3fa8d0d533 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -38,8 +38,7 @@ static int setkey_unaligned(struct crypto_tfm *tfm, const u8 *key,
 	alignbuffer = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
 	memcpy(alignbuffer, key, keylen);
 	ret = cia->cia_setkey(tfm, alignbuffer, keylen);
-	memset(alignbuffer, 0, keylen);
-	kfree(buffer);
+	kzfree(buffer);
 	return ret;
 
 }
diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 9fd9a98a9cbe..5255a0837c82 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -170,6 +170,8 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	elements =
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
+	if (!elements)
+		return (AE_NO_MEMORY);
 
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 228feeea555f..91143bcfe090 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -437,6 +437,9 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 
 		if (info->connection_node) {
 			second_desc = info->connection_node->object;
+			if (second_desc == NULL) {
+				break;
+			}
 			if (!(second_desc->common.flags & AOPOBJ_DATA_VALID)) {
 				status =
 				    acpi_ds_get_buffer_arguments(second_desc);
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 176d28d60125..956aaf6a3f3d 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -25,6 +25,8 @@ acpi_ps_get_next_package_length(struct acpi_parse_state *parser_state);
 static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 						       *parser_state);
 
+static void acpi_ps_free_field_list(union acpi_parse_object *start);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ps_get_next_package_length
@@ -683,6 +685,39 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 	return_PTR(field);
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ps_free_field_list
+ *
+ * PARAMETERS:  start               - First Op in field list
+ *
+ * RETURN:      None.
+ *
+ * DESCRIPTION: Free all Op objects inside a field list.
+ *
+ ******************************************************************************/
+
+static void acpi_ps_free_field_list(union acpi_parse_object *start)
+{
+	union acpi_parse_object *cur = start;
+	union acpi_parse_object *next;
+	union acpi_parse_object *arg;
+
+	while (cur) {
+		next = cur->common.next;
+
+		/* AML_INT_CONNECTION_OP can have a single argument */
+
+		arg = acpi_ps_get_arg(cur, 0);
+		if (arg) {
+			acpi_ps_free_op(arg);
+		}
+
+		acpi_ps_free_op(cur);
+		cur = next;
+	}
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ps_get_next_arg
@@ -751,6 +786,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 			while (parser_state->aml < parser_state->pkg_end) {
 				field = acpi_ps_get_next_field(parser_state);
 				if (!field) {
+					if (arg) {
+						acpi_ps_free_field_list(arg);
+					}
+
 					return_ACPI_STATUS(AE_NO_MEMORY);
 				}
 
@@ -820,6 +859,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 			    acpi_ps_get_next_namepath(walk_state, parser_state,
 						      arg,
 						      ACPI_NOT_METHOD_CALL);
+			if (ACPI_FAILURE(status)) {
+				acpi_ps_free_op(arg);
+				return_ACPI_STATUS(status);
+			}
 		} else {
 			/* Single complex argument, nothing returned */
 
@@ -854,6 +897,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 			    acpi_ps_get_next_namepath(walk_state, parser_state,
 						      arg,
 						      ACPI_POSSIBLE_METHOD_CALL);
+			if (ACPI_FAILURE(status)) {
+				acpi_ps_free_op(arg);
+				return_ACPI_STATUS(status);
+			}
 
 			if (arg->common.aml_opcode == AML_INT_METHODCALL_OP) {
 
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 88f4040d6c1f..46aa0e5e6f8b 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -713,27 +713,34 @@ static LIST_HEAD(acpi_battery_list);
 static LIST_HEAD(battery_hook_list);
 static DEFINE_MUTEX(hook_mutex);
 
-static void __battery_hook_unregister(struct acpi_battery_hook *hook, int lock)
+static void battery_hook_unregister_unlocked(struct acpi_battery_hook *hook)
 {
 	struct acpi_battery *battery;
+
 	/*
 	 * In order to remove a hook, we first need to
 	 * de-register all the batteries that are registered.
 	 */
-	if (lock)
-		mutex_lock(&hook_mutex);
 	list_for_each_entry(battery, &acpi_battery_list, list) {
 		hook->remove_battery(battery->bat);
 	}
-	list_del(&hook->list);
-	if (lock)
-		mutex_unlock(&hook_mutex);
+	list_del_init(&hook->list);
+
 	pr_info("extension unregistered: %s\n", hook->name);
 }
 
 void battery_hook_unregister(struct acpi_battery_hook *hook)
 {
-	__battery_hook_unregister(hook, 1);
+	mutex_lock(&hook_mutex);
+	/*
+	 * Ignore already unregistered battery hooks. This might happen
+	 * if a battery hook was previously unloaded due to an error when
+	 * adding a new battery.
+	 */
+	if (!list_empty(&hook->list))
+		battery_hook_unregister_unlocked(hook);
+
+	mutex_unlock(&hook_mutex);
 }
 EXPORT_SYMBOL_GPL(battery_hook_unregister);
 
@@ -742,7 +749,6 @@ void battery_hook_register(struct acpi_battery_hook *hook)
 	struct acpi_battery *battery;
 
 	mutex_lock(&hook_mutex);
-	INIT_LIST_HEAD(&hook->list);
 	list_add(&hook->list, &battery_hook_list);
 	/*
 	 * Now that the driver is registered, we need
@@ -759,7 +765,7 @@ void battery_hook_register(struct acpi_battery_hook *hook)
 			 * hooks.
 			 */
 			pr_err("extension failed to load: %s", hook->name);
-			__battery_hook_unregister(hook, 0);
+			battery_hook_unregister_unlocked(hook);
 			goto end;
 		}
 	}
@@ -796,7 +802,7 @@ static void battery_hook_add_battery(struct acpi_battery *battery)
 			 */
 			pr_err("error in extension, unloading: %s",
 					hook_node->name);
-			__battery_hook_unregister(hook_node, 0);
+			battery_hook_unregister_unlocked(hook_node);
 		}
 	}
 	mutex_unlock(&hook_mutex);
@@ -829,7 +835,7 @@ static void __exit battery_hook_exit(void)
 	 * need to remove the hooks.
 	 */
 	list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
-		__battery_hook_unregister(hook, 1);
+		battery_hook_unregister(hook);
 	}
 	mutex_destroy(&hook_mutex);
 }
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index abf101451c92..626e82eca870 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -124,6 +124,17 @@ static const struct dmi_system_id lid_blacklst[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
 	},
+	{
+		/*
+		 * Samsung galaxybook2 ,initial _LID device notification returns
+		 * lid closed.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "750XED"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+	},
 	{}
 };
 
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 146be9cdeca5..36b584ff9fc7 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -539,8 +539,9 @@ int acpi_device_setup_files(struct acpi_device *dev)
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
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7db62dec2ee5..1d0366c2c217 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -807,6 +807,9 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	unsigned long tmp;
 	int ret = 0;
 
+	if (t->rdata)
+		memset(t->rdata, 0, t->rlen);
+
 	/* start transaction */
 	spin_lock_irqsave(&ec->lock, tmp);
 	/* Enable GPE for command processing (IBF=0/OBF=1) */
@@ -843,8 +846,6 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 
 	if (!ec || (!t) || (t->wlen && !t->wdata) || (t->rlen && !t->rdata))
 		return -EINVAL;
-	if (t->rdata)
-		memset(t->rdata, 0, t->rlen);
 
 	mutex_lock(&ec->mutex);
 	if (ec->global_lock) {
@@ -871,7 +872,7 @@ static int acpi_ec_burst_enable(struct acpi_ec *ec)
 				.wdata = NULL, .rdata = &d,
 				.wlen = 0, .rlen = 1};
 
-	return acpi_ec_transaction(ec, &t);
+	return acpi_ec_transaction_unlocked(ec, &t);
 }
 
 static int acpi_ec_burst_disable(struct acpi_ec *ec)
@@ -881,7 +882,7 @@ static int acpi_ec_burst_disable(struct acpi_ec *ec)
 				.wlen = 0, .rlen = 0};
 
 	return (acpi_ec_read_status(ec) & ACPI_EC_FLAG_BURST) ?
-				acpi_ec_transaction(ec, &t) : 0;
+				acpi_ec_transaction_unlocked(ec, &t) : 0;
 }
 
 static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 *data)
@@ -897,6 +898,19 @@ static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 *data)
 	return result;
 }
 
+static int acpi_ec_read_unlocked(struct acpi_ec *ec, u8 address, u8 *data)
+{
+	int result;
+	u8 d;
+	struct transaction t = {.command = ACPI_EC_COMMAND_READ,
+				.wdata = &address, .rdata = &d,
+				.wlen = 1, .rlen = 1};
+
+	result = acpi_ec_transaction_unlocked(ec, &t);
+	*data = d;
+	return result;
+}
+
 static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
 {
 	u8 wdata[2] = { address, data };
@@ -907,6 +921,16 @@ static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
 	return acpi_ec_transaction(ec, &t);
 }
 
+static int acpi_ec_write_unlocked(struct acpi_ec *ec, u8 address, u8 data)
+{
+	u8 wdata[2] = { address, data };
+	struct transaction t = {.command = ACPI_EC_COMMAND_WRITE,
+				.wdata = wdata, .rdata = NULL,
+				.wlen = 2, .rlen = 0};
+
+	return acpi_ec_transaction_unlocked(ec, &t);
+}
+
 int ec_read(u8 addr, u8 *val)
 {
 	int err;
@@ -1320,6 +1344,7 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	struct acpi_ec *ec = handler_context;
 	int result = 0, i, bytes = bits / 8;
 	u8 *value = (u8 *)value64;
+	u32 glk;
 
 	if ((address > 0xFF) || !value || !handler_context)
 		return AE_BAD_PARAMETER;
@@ -1327,13 +1352,25 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (function != ACPI_READ && function != ACPI_WRITE)
 		return AE_BAD_PARAMETER;
 
+	mutex_lock(&ec->mutex);
+
+	if (ec->global_lock) {
+		acpi_status status;
+
+		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
+		if (ACPI_FAILURE(status)) {
+			result = -ENODEV;
+			goto unlock;
+		}
+	}
+
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_enable(ec);
 
 	for (i = 0; i < bytes; ++i, ++address, ++value) {
 		result = (function == ACPI_READ) ?
-			acpi_ec_read(ec, address, value) :
-			acpi_ec_write(ec, address, *value);
+			acpi_ec_read_unlocked(ec, address, value) :
+			acpi_ec_write_unlocked(ec, address, *value);
 		if (result < 0)
 			break;
 	}
@@ -1341,6 +1378,12 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_disable(ec);
 
+	if (ec->global_lock)
+		acpi_release_global_lock(glk);
+
+unlock:
+	mutex_unlock(&ec->mutex);
+
 	switch (result) {
 	case -EINVAL:
 		return AE_BAD_PARAMETER;
diff --git a/drivers/acpi/pmic/tps68470_pmic.c b/drivers/acpi/pmic/tps68470_pmic.c
index a083de507009..fde8a1271c9b 100644
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
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 82adaf02887f..8613a3cf2c8a 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -144,7 +144,7 @@ static const struct pci_device_id sil_pci_tbl[] = {
 static const struct sil_drivelist {
 	const char *product;
 	unsigned int quirk;
-} sil_blacklist [] = {
+} sil_quirks[] = {
 	{ "ST320012AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
@@ -617,8 +617,8 @@ static void sil_thaw(struct ata_port *ap)
  *	list, and apply the fixups to only the specific
  *	devices/hosts/firmwares that need it.
  *
- *	20040111 - Seagate drives affected by the Mod15Write bug are blacklisted
- *	The Maxtor quirk is in the blacklist, but I'm keeping the original
+ *	20040111 - Seagate drives affected by the Mod15Write bug are quirked
+ *	The Maxtor quirk is in sil_quirks, but I'm keeping the original
  *	pessimistic fix for the following reasons...
  *	- There seems to be less info on it, only one device gleaned off the
  *	Windows	driver, maybe only one is affected.  More info would be greatly
@@ -637,9 +637,9 @@ static void sil_dev_config(struct ata_device *dev)
 
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 
-	for (n = 0; sil_blacklist[n].product; n++)
-		if (!strcmp(sil_blacklist[n].product, model_num)) {
-			quirks = sil_blacklist[n].quirk;
+	for (n = 0; sil_quirks[n].product; n++)
+		if (!strcmp(sil_quirks[n].product, model_num)) {
+			quirks = sil_quirks[n].quirk;
 			break;
 		}
 
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index e06a57936cc9..aad13af4175b 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -103,7 +103,8 @@ static ssize_t bus_attr_show(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	/* return -EIO for reading a bus attribute without show() */
+	ssize_t ret = -EIO;
 
 	if (bus_attr->show)
 		ret = bus_attr->show(subsys_priv->bus, buf);
@@ -115,7 +116,8 @@ static ssize_t bus_attr_store(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	/* return -EIO for writing a bus attribute without store() */
+	ssize_t ret = -EIO;
 
 	if (bus_attr->store)
 		ret = bus_attr->store(subsys_priv->bus, buf, count);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8d86ca28c54d..838d084d852b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -24,7 +24,6 @@
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/netdevice.h>
-#include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 #include <linux/sysfs.h>
 
@@ -1138,7 +1137,6 @@ static int dev_uevent(struct kset *kset, struct kobject *kobj,
 		      struct kobj_uevent_env *env)
 {
 	struct device *dev = kobj_to_dev(kobj);
-	struct device_driver *driver;
 	int retval = 0;
 
 	/* add device node properties if present */
@@ -1167,12 +1165,8 @@ static int dev_uevent(struct kset *kset, struct kobject *kobj,
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
@@ -1242,8 +1236,11 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	if (!env)
 		return -ENOMEM;
 
+	/* Synchronize with really_probe() */
+	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(kset, &dev->kobj, env);
+	device_unlock(dev);
 	if (retval)
 		goto out;
 
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index cfa5e598a0dc..b9985c7338dc 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -565,6 +565,26 @@ static void fw_abort_batch_reqs(struct firmware *fw)
 	mutex_unlock(&fw_lock);
 }
 
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
@@ -582,6 +602,14 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
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
 					opt_flags);
 	if (ret <= 0) /* error or already assigned */
@@ -622,6 +650,8 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
  *      @name will be used as $FIRMWARE in the uevent environment and
  *      should be distinctive enough not to be confused with any other
  *      firmware image for this or any other device.
+ *	It must not contain any ".." path components - "foo/bar..bin" is
+ *	allowed, but "foo/../bar.bin" is not.
  *
  *	Caller must hold the reference count of @device.
  *
diff --git a/drivers/base/module.c b/drivers/base/module.c
index 851cc5367c04..46ad4d636731 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -7,7 +7,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/rcupdate.h>
 #include "base.h"
 
 static char *make_driver_name(struct device_driver *drv)
@@ -78,9 +77,6 @@ void module_remove_driver(struct device_driver *drv)
 	if (!drv)
 		return;
 
-	/* Synchronize with dev_uevent() */
-	synchronize_rcu();
-
 	sysfs_remove_link(&drv->p->kobj, "module");
 
 	if (drv->owner)
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index c2b32c53da2b..8a4ca3484983 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -362,6 +362,7 @@ ata_rw_frameinit(struct frame *f)
 	}
 
 	ah->cmdstat = ATA_CMD_PIO_READ | writebit | extbit;
+	dev_hold(t->ifp->nd);
 	skb->dev = t->ifp->nd;
 }
 
@@ -402,6 +403,8 @@ aoecmd_ata_rw(struct aoedev *d)
 		__skb_queue_head_init(&queue);
 		__skb_queue_tail(&queue, skb);
 		aoenet_xmit(&queue);
+	} else {
+		dev_put(f->t->ifp->nd);
 	}
 	return 1;
 }
@@ -484,10 +487,13 @@ resend(struct aoedev *d, struct frame *f)
 	memcpy(h->dst, t->addr, sizeof h->dst);
 	memcpy(h->src, t->ifp->nd->dev_addr, sizeof h->src);
 
+	dev_hold(t->ifp->nd);
 	skb->dev = t->ifp->nd;
 	skb = skb_clone(skb, GFP_ATOMIC);
-	if (skb == NULL)
+	if (skb == NULL) {
+		dev_put(t->ifp->nd);
 		return;
+	}
 	f->sent = ktime_get();
 	__skb_queue_head_init(&queue);
 	__skb_queue_tail(&queue, skb);
@@ -618,6 +624,8 @@ probe(struct aoetgt *t)
 		__skb_queue_head_init(&queue);
 		__skb_queue_tail(&queue, skb);
 		aoenet_xmit(&queue);
+	} else {
+		dev_put(f->t->ifp->nd);
 	}
 }
 
@@ -1407,6 +1415,7 @@ aoecmd_ata_id(struct aoedev *d)
 	ah->cmdstat = ATA_CMD_ID_ATA;
 	ah->lba3 = 0xa0;
 
+	dev_hold(t->ifp->nd);
 	skb->dev = t->ifp->nd;
 
 	d->rttavg = RTTAVG_INIT;
@@ -1416,6 +1425,8 @@ aoecmd_ata_id(struct aoedev *d)
 	skb = skb_clone(skb, GFP_ATOMIC);
 	if (skb)
 		f->sent = ktime_get();
+	else
+		dev_put(t->ifp->nd);
 
 	return skb;
 }
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 1ff5af6c4f3f..bb2460a2d824 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3499,10 +3499,12 @@ void drbd_uuid_new_current(struct drbd_device *device) __must_hold(local)
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
index 1474250f9440..9d8f952514db 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -888,7 +888,7 @@ is_valid_state(struct drbd_device *device, union drbd_state ns)
 		  ns.disk == D_OUTDATED)
 		rv = SS_CONNECTED_OUTDATES;
 
-	else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
+	else if (nc && (ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
 		 (nc->verify_alg[0] == 0))
 		rv = SS_NO_VERIFY_ALG;
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b6eb48e44e6b..7ee8cdc8dcb9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -743,7 +743,15 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	if (!urb)
 		return -ENOMEM;
 
-	size = le16_to_cpu(data->intr_ep->wMaxPacketSize);
+	if (le16_to_cpu(data->udev->descriptor.idVendor)  == 0x0a12 &&
+	    le16_to_cpu(data->udev->descriptor.idProduct) == 0x0001)
+		/* Fake CSR devices don't seem to support sort-transter */
+		size = le16_to_cpu(data->intr_ep->wMaxPacketSize);
+	else
+		/* Use maximum HCI Event size so the USB stack handles
+		 * ZPL/short-transfer automatically.
+		 */
+		size = HCI_MAX_EVENT_SIZE;
 
 	buf = kmalloc(size, mem_flags);
 	if (!buf) {
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index d3937d690400..ad9e26665260 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2075,25 +2075,27 @@ static int virtcons_probe(struct virtio_device *vdev)
 		multiport = true;
 	}
 
-	err = init_vqs(portdev);
-	if (err < 0) {
-		dev_err(&vdev->dev, "Error %d initializing vqs\n", err);
-		goto free_chrdev;
-	}
-
 	spin_lock_init(&portdev->ports_lock);
 	INIT_LIST_HEAD(&portdev->ports);
 	INIT_LIST_HEAD(&portdev->list);
 
-	virtio_device_ready(portdev->vdev);
-
 	INIT_WORK(&portdev->config_work, &config_work_handler);
 	INIT_WORK(&portdev->control_work, &control_work_handler);
 
 	if (multiport) {
 		spin_lock_init(&portdev->c_ivq_lock);
 		spin_lock_init(&portdev->c_ovq_lock);
+	}
 
+	err = init_vqs(portdev);
+	if (err < 0) {
+		dev_err(&vdev->dev, "Error %d initializing vqs\n", err);
+		goto free_chrdev;
+	}
+
+	virtio_device_ready(portdev->vdev);
+
+	if (multiport) {
 		err = fill_queue(portdev->c_ivq, &portdev->c_ivq_lock);
 		if (err < 0) {
 			dev_err(&vdev->dev,
diff --git a/drivers/clk/bcm/clk-bcm53573-ilp.c b/drivers/clk/bcm/clk-bcm53573-ilp.c
index 36eb3716ffb0..3bc6837f844d 100644
--- a/drivers/clk/bcm/clk-bcm53573-ilp.c
+++ b/drivers/clk/bcm/clk-bcm53573-ilp.c
@@ -115,7 +115,7 @@ static void bcm53573_ilp_init(struct device_node *np)
 		goto err_free_ilp;
 	}
 
-	ilp->regmap = syscon_node_to_regmap(of_get_parent(np));
+	ilp->regmap = syscon_node_to_regmap(np->parent);
 	if (IS_ERR(ilp->regmap)) {
 		err = PTR_ERR(ilp->regmap);
 		goto err_free_ilp;
diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index d854e26a8ddb..51c3701d9a34 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -9,31 +9,101 @@
 #include <linux/export.h>
 #include <linux/gfp.h>
 
+struct devm_clk_state {
+	struct clk *clk;
+	void (*exit)(struct clk *clk);
+};
+
 static void devm_clk_release(struct device *dev, void *res)
 {
-	clk_put(*(struct clk **)res);
+	struct devm_clk_state *state = res;
+
+	if (state->exit)
+		state->exit(state->clk);
+
+	clk_put(state->clk);
 }
 
-struct clk *devm_clk_get(struct device *dev, const char *id)
+static struct clk *__devm_clk_get(struct device *dev, const char *id,
+				  struct clk *(*get)(struct device *dev, const char *id),
+				  int (*init)(struct clk *clk),
+				  void (*exit)(struct clk *clk))
 {
-	struct clk **ptr, *clk;
+	struct devm_clk_state *state;
+	struct clk *clk;
+	int ret;
 
-	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
+	state = devres_alloc(devm_clk_release, sizeof(*state), GFP_KERNEL);
+	if (!state)
 		return ERR_PTR(-ENOMEM);
 
-	clk = clk_get(dev, id);
-	if (!IS_ERR(clk)) {
-		*ptr = clk;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
+	clk = get(dev, id);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto err_clk_get;
 	}
 
+	if (init) {
+		ret = init(clk);
+		if (ret)
+			goto err_clk_init;
+	}
+
+	state->clk = clk;
+	state->exit = exit;
+
+	devres_add(dev, state);
+
 	return clk;
+
+err_clk_init:
+
+	clk_put(clk);
+err_clk_get:
+
+	devres_free(state);
+	return ERR_PTR(ret);
+}
+
+struct clk *devm_clk_get(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get, NULL, NULL);
 }
 EXPORT_SYMBOL(devm_clk_get);
 
+struct clk *devm_clk_get_prepared(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get, clk_prepare, clk_unprepare);
+}
+EXPORT_SYMBOL_GPL(devm_clk_get_prepared);
+
+struct clk *devm_clk_get_enabled(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get,
+			      clk_prepare_enable, clk_disable_unprepare);
+}
+EXPORT_SYMBOL_GPL(devm_clk_get_enabled);
+
+struct clk *devm_clk_get_optional(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get_optional, NULL, NULL);
+}
+EXPORT_SYMBOL(devm_clk_get_optional);
+
+struct clk *devm_clk_get_optional_prepared(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get_optional,
+			      clk_prepare, clk_unprepare);
+}
+EXPORT_SYMBOL_GPL(devm_clk_get_optional_prepared);
+
+struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get_optional,
+			      clk_prepare_enable, clk_disable_unprepare);
+}
+EXPORT_SYMBOL_GPL(devm_clk_get_optional_enabled);
+
 struct clk_bulk_devres {
 	struct clk_bulk_data *clks;
 	int num_clks;
@@ -93,18 +163,19 @@ EXPORT_SYMBOL(devm_clk_put);
 struct clk *devm_get_clk_from_child(struct device *dev,
 				    struct device_node *np, const char *con_id)
 {
-	struct clk **ptr, *clk;
+	struct devm_clk_state *state;
+	struct clk *clk;
 
-	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
+	state = devres_alloc(devm_clk_release, sizeof(*state), GFP_KERNEL);
+	if (!state)
 		return ERR_PTR(-ENOMEM);
 
 	clk = of_clk_get_by_name(np, con_id);
 	if (!IS_ERR(clk)) {
-		*ptr = clk;
-		devres_add(dev, ptr);
+		state->clk = clk;
+		devres_add(dev, state);
 	} else {
-		devres_free(ptr);
+		devres_free(state);
 	}
 
 	return clk;
diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index 8d11d76e1db7..811f0d43ee90 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -415,7 +415,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(29), 0, 3, DFLAGS),
 	DIV(0, "sclk_vop_pre", "sclk_vop_src", 0,
 			RK2928_CLKSEL_CON(27), 8, 8, DFLAGS),
-	MUX(DCLK_VOP, "dclk_vop", mux_dclk_vop_p, 0,
+	MUX(DCLK_VOP, "dclk_vop", mux_dclk_vop_p, CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			RK2928_CLKSEL_CON(27), 1, 1, MFLAGS),
 
 	FACTOR(0, "xin12m", "xin24m", 0, 1, 2),
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index c3ad92965823..fb346d0b35b4 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -444,12 +444,13 @@ void __init rockchip_clk_register_branches(
 				      struct rockchip_clk_branch *list,
 				      unsigned int nr_clk)
 {
-	struct clk *clk = NULL;
+	struct clk *clk;
 	unsigned int idx;
 	unsigned long flags;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
 		flags = list->flags;
+		clk = NULL;
 
 		/* catch simple muxes */
 		switch (list->branch_type) {
diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index a4b6f3ac2d34..afd71c894150 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -257,6 +257,7 @@ static int of_dra7_atl_clk_probe(struct platform_device *pdev)
 		}
 
 		clk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to get atl clock %d from provider\n",
 			       __func__, i);
diff --git a/drivers/clocksource/timer-qcom.c b/drivers/clocksource/timer-qcom.c
index 89816f89ff3f..83385bc431ac 100644
--- a/drivers/clocksource/timer-qcom.c
+++ b/drivers/clocksource/timer-qcom.c
@@ -242,6 +242,7 @@ static int __init msm_dt_timer_init(struct device_node *np)
 	}
 
 	if (of_property_read_u32(np, "clock-frequency", &freq)) {
+		iounmap(cpu0_base);
 		pr_err("Unknown frequency\n");
 		return -EINVAL;
 	}
@@ -252,7 +253,11 @@ static int __init msm_dt_timer_init(struct device_node *np)
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
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index ea2c2bdcf4f7..eb99a02e5114 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -800,7 +800,7 @@ static int sdei_device_freeze(struct device *dev)
 	int err;
 
 	/* unregister private events */
-	cpuhp_remove_state(sdei_entry_point);
+	cpuhp_remove_state(sdei_hp_state);
 
 	err = sdei_unregister_shared();
 	if (err)
diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index ba1cd971d50b..cab3d9a4018a 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -407,6 +407,8 @@ static void __aspeed_gpio_set(struct gpio_chip *gc, unsigned int offset,
 	gpio->dcache[GPIO_BANK(offset)] = reg;
 
 	iowrite32(reg, addr);
+	/* Flush write */
+	ioread32(addr);
 }
 
 static void aspeed_gpio_set(struct gpio_chip *gc, unsigned int offset,
@@ -1174,7 +1176,7 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 	if (!gpio_id)
 		return -EINVAL;
 
-	gpio->clk = of_clk_get(pdev->dev.of_node, 0);
+	gpio->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(gpio->clk)) {
 		dev_warn(&pdev->dev,
 				"Failed to get clock from devicetree, debouncing disabled\n");
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index ab9f7acaae76..5d2b848cfc6a 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -294,7 +294,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
  * serve as EDMA event triggers.
  */
 
-static void gpio_irq_disable(struct irq_data *d)
+static void gpio_irq_mask(struct irq_data *d)
 {
 	struct davinci_gpio_regs __iomem *g = irq2regs(d);
 	u32 mask = (u32) irq_data_get_irq_handler_data(d);
@@ -303,7 +303,7 @@ static void gpio_irq_disable(struct irq_data *d)
 	writel_relaxed(mask, &g->clr_rising);
 }
 
-static void gpio_irq_enable(struct irq_data *d)
+static void gpio_irq_unmask(struct irq_data *d)
 {
 	struct davinci_gpio_regs __iomem *g = irq2regs(d);
 	u32 mask = (u32) irq_data_get_irq_handler_data(d);
@@ -329,8 +329,8 @@ static int gpio_irq_type(struct irq_data *d, unsigned trigger)
 
 static struct irq_chip gpio_irqchip = {
 	.name		= "GPIO",
-	.irq_enable	= gpio_irq_enable,
-	.irq_disable	= gpio_irq_disable,
+	.irq_unmask	= gpio_irq_unmask,
+	.irq_mask	= gpio_irq_mask,
 	.irq_set_type	= gpio_irq_type,
 	.flags		= IRQCHIP_SET_TYPE_MASKED | IRQCHIP_SKIP_SET_WAKE,
 };
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 12472b84a71c..f93c4ece69e2 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3,6 +3,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/nospec.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/device.h>
@@ -144,7 +145,7 @@ struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip,
 	if (hwnum >= gdev->ngpio)
 		return ERR_PTR(-EINVAL);
 
-	return &gdev->descs[hwnum];
+	return &gdev->descs[array_index_nospec(hwnum, gdev->ngpio)];
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index bbd927e800af..bf8044bf4734 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -90,6 +90,7 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 					   struct acpi_buffer *params)
 {
 	acpi_status status;
+	union acpi_object *obj;
 	union acpi_object atif_arg_elements[2];
 	struct acpi_object_list atif_arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -112,16 +113,24 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 
 	status = acpi_evaluate_object(atif->handle, NULL, &atif_arg,
 				      &buffer);
+	obj = (union acpi_object *)buffer.pointer;
 
-	/* Fail only if calling the method fails and ATIF is supported */
+	/* Fail if calling the method fails and ATIF is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		DRM_DEBUG_DRIVER("failed to evaluate ATIF got %s\n",
 				 acpi_format_exception(status));
-		kfree(buffer.pointer);
+		kfree(obj);
 		return NULL;
 	}
 
-	return buffer.pointer;
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		DRM_DEBUG_DRIVER("bad object returned from ATIF: %d\n",
+				 obj->type);
+		kfree(obj);
+		return NULL;
+	}
+
+	return obj;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index d702fb8e3427..251975697d69 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -2095,23 +2095,29 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
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
-						fake_edid_record->ucFakeEDIDLength + 2 :
-						sizeof(ATOM_FAKE_EDID_PATCH_RECORD);
 					break;
 				case LCD_PANEL_RESOLUTION_RECORD_TYPE:
 					panel_res_record = (ATOM_PANEL_RESOLUTION_PATCH_RECORD *)record;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 8b4337794d1e..18ebbbf67f23 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1569,6 +1569,8 @@ static bool are_stream_backends_same(
 bool dc_is_stream_unchanged(
 	struct dc_stream_state *old_stream, struct dc_stream_state *stream)
 {
+	if (!old_stream || !stream)
+		return false;
 
 	if (!are_stream_backends_same(old_stream, stream))
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index 67a3ba49234e..ad4247061344 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -482,6 +482,8 @@ bool cm_helper_translate_curve_to_degamma_hw_format(
 				i += increment) {
 			if (j == hw_points - 1)
 				break;
+			if (i >= TRANSFER_FUNC_POINTS)
+				return false;
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
 			rgb_resulted[j].green = output_tf->tf_pts.green[i];
 			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index 7931502fa54f..c9f70accd46d 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -4106,8 +4106,8 @@ typedef struct  _ATOM_LCD_MODE_CONTROL_CAP
 typedef struct _ATOM_FAKE_EDID_PATCH_RECORD
 {
   UCHAR ucRecordType;
-  UCHAR ucFakeEDIDLength;       // = 128 means EDID lenght is 128 bytes, otherwise the EDID length = ucFakeEDIDLength*128
-  UCHAR ucFakeEDIDString[1];    // This actually has ucFakeEdidLength elements.
+  UCHAR ucFakeEDIDLength;       // = 128 means EDID length is 128 bytes, otherwise the EDID length = ucFakeEDIDLength*128
+  UCHAR ucFakeEDIDString[];     // This actually has ucFakeEdidLength elements.
 } ATOM_FAKE_EDID_PATCH_RECORD;
 
 typedef struct  _ATOM_PANEL_RESOLUTION_PATCH_RECORD
diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 22eba10af165..e8d5fc8408c5 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -567,9 +567,9 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	struct drm_mode_crtc *crtc_req = data;
 	struct drm_crtc *crtc;
 	struct drm_plane *plane;
-	struct drm_connector **connector_set, *connector;
-	struct drm_framebuffer *fb;
-	struct drm_display_mode *mode;
+	struct drm_connector **connector_set = NULL, *connector;
+	struct drm_framebuffer *fb = NULL;
+	struct drm_display_mode *mode = NULL;
 	struct drm_mode_set set;
 	uint32_t __user *set_connectors_ptr;
 	struct drm_modeset_acquire_ctx ctx;
@@ -601,10 +601,6 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	mutex_lock(&crtc->dev->mode_config.mutex);
 	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
 retry:
-	connector_set = NULL;
-	fb = NULL;
-	mode = NULL;
-
 	ret = drm_modeset_lock_all_ctx(crtc->dev, &ctx);
 	if (ret)
 		goto out;
@@ -767,6 +763,13 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	}
 	kfree(connector_set);
 	drm_mode_destroy(dev, mode);
+
+	/* In case we need to retry... */
+	connector_set = NULL;
+	fb = NULL;
+	mode = NULL;
+	num_connectors = 0;
+
 	if (ret == -EDEADLK) {
 		ret = drm_modeset_backoff(&ctx);
 		if (!ret)
diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 0e7fc3e7dfb4..711a1b329879 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -54,8 +54,9 @@ void __drm_puts_coredump(struct drm_printer *p, const char *str)
 			copy = iterator->remain;
 
 		/* Copy out the bit of the string that we need */
-		memcpy(iterator->data,
-			str + (iterator->start - iterator->offset), copy);
+		if (iterator->data)
+			memcpy(iterator->data,
+			       str + (iterator->start - iterator->offset), copy);
 
 		iterator->offset = iterator->start + copy;
 		iterator->remain -= copy;
@@ -64,7 +65,8 @@ void __drm_puts_coredump(struct drm_printer *p, const char *str)
 
 		len = min_t(ssize_t, strlen(str), iterator->remain);
 
-		memcpy(iterator->data + pos, str, len);
+		if (iterator->data)
+			memcpy(iterator->data + pos, str, len);
 
 		iterator->offset += len;
 		iterator->remain -= len;
@@ -94,8 +96,9 @@ void __drm_printfn_coredump(struct drm_printer *p, struct va_format *vaf)
 	if ((iterator->offset >= iterator->start) && (len < iterator->remain)) {
 		ssize_t pos = iterator->offset - iterator->start;
 
-		snprintf(((char *) iterator->data) + pos,
-			iterator->remain, "%pV", vaf);
+		if (iterator->data)
+			snprintf(((char *) iterator->data) + pos,
+				 iterator->remain, "%pV", vaf);
 
 		iterator->offset += len;
 		iterator->remain -= len;
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
index 7d71860c4bee..c9b1da1517dc 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
@@ -44,6 +44,7 @@ struct a5xx_gpu {
 	uint64_t preempt_iova[MSM_GPU_MAX_RINGS];
 
 	atomic_t preempt_state;
+	spinlock_t preempt_start_lock;
 	struct timer_list preempt_timer;
 };
 
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
index 970c7963ae29..63445e88f8ad 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
@@ -107,12 +107,19 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
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
@@ -137,9 +144,11 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
 		set_preempt_state(a5xx_gpu, PREEMPT_ABORT);
 		update_wptr(gpu, a5xx_gpu->cur_ring);
 		set_preempt_state(a5xx_gpu, PREEMPT_NONE);
-		return;
+		goto out;
 	}
 
+	spin_unlock_irqrestore(&a5xx_gpu->preempt_start_lock, flags);
+
 	/* Make sure the wptr doesn't update while we're in motion */
 	spin_lock_irqsave(&ring->lock, flags);
 	a5xx_gpu->preempt[ring->id]->wptr = get_wptr(ring);
@@ -163,6 +172,10 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
 
 	/* And actually start the preemption */
 	gpu_write(gpu, REG_A5XX_CP_CONTEXT_SWITCH_CNTL, 1);
+	return;
+
+out:
+	spin_unlock_irqrestore(&a5xx_gpu->preempt_start_lock, flags);
 }
 
 void a5xx_preempt_irq(struct msm_gpu *gpu)
@@ -200,6 +213,12 @@ void a5xx_preempt_irq(struct msm_gpu *gpu)
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
@@ -209,6 +228,8 @@ void a5xx_preempt_hw_init(struct msm_gpu *gpu)
 	int i;
 
 	for (i = 0; i < gpu->nr_rings; i++) {
+		a5xx_gpu->preempt[i]->data = 0;
+		a5xx_gpu->preempt[i]->info = 0;
 		a5xx_gpu->preempt[i]->wptr = 0;
 		a5xx_gpu->preempt[i]->rptr = 0;
 		a5xx_gpu->preempt[i]->rbase = gpu->rb[i]->iova;
@@ -300,5 +321,6 @@ void a5xx_preempt_init(struct msm_gpu *gpu)
 		}
 	}
 
+	spin_lock_init(&a5xx_gpu->preempt_start_lock);
 	timer_setup(&a5xx_gpu->preempt_timer, a5xx_preempt_timer, 0);
 }
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
index 96c2b828dba4..2d9027c8418e 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
@@ -366,7 +366,7 @@ void mdp5_smp_dump(struct mdp5_smp *smp, struct drm_printer *p)
 
 			drm_printf(p, "%s:%d\t%d\t%s\n",
 				pipe2name(pipe), j, inuse,
-				plane ? plane->name : NULL);
+				plane ? plane->name : "(null)");
 
 			total += inuse;
 		}
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 5f4dd3659bf9..137c0ec1b577 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -671,7 +671,7 @@ static u32 dsi_get_pclk_rate(struct msm_dsi_host *msm_host, bool is_dual_dsi)
 	struct drm_display_mode *mode = msm_host->mode;
 	u32 pclk_rate;
 
-	pclk_rate = mode->clock * 1000;
+	pclk_rate = mode->clock * 1000u;
 
 	/*
 	 * For dual DSI mode, the current DRM mode has the complete width of the
diff --git a/drivers/gpu/drm/radeon/atombios.h b/drivers/gpu/drm/radeon/atombios.h
index 4b86e8b45009..e3f496464764 100644
--- a/drivers/gpu/drm/radeon/atombios.h
+++ b/drivers/gpu/drm/radeon/atombios.h
@@ -3615,7 +3615,7 @@ typedef struct _ATOM_FAKE_EDID_PATCH_RECORD
 {
   UCHAR ucRecordType;
   UCHAR ucFakeEDIDLength;
-  UCHAR ucFakeEDIDString[1];    // This actually has ucFakeEdidLength elements.
+  UCHAR ucFakeEDIDString[];    // This actually has ucFakeEdidLength elements.
 } ATOM_FAKE_EDID_PATCH_RECORD;
 
 typedef struct  _ATOM_PANEL_RESOLUTION_PATCH_RECORD
diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index 2f0a5bd50174..44a5c9059323 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -396,7 +396,7 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 	struct evergreen_cs_track *track = p->track;
 	struct eg_surface surf;
 	unsigned pitch, slice, mslice;
-	unsigned long offset;
+	u64 offset;
 	int r;
 
 	mslice = G_028C6C_SLICE_MAX(track->cb_color_view[id]) + 1;
@@ -434,14 +434,14 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
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
@@ -449,14 +449,14 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
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
@@ -468,7 +468,7 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 				slice = ((nby * surf.nbx) / 64) - 1;
 				if (!evergreen_surface_check(p, &surf, "cb")) {
 					/* check if this one works */
-					tmp += surf.layer_size * mslice;
+					tmp += (u64)surf.layer_size * mslice;
 					if (tmp <= bsize) {
 						ib[track->cb_color_slice_idx[id]] = slice;
 						goto old_ddx_ok;
@@ -477,9 +477,9 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
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
@@ -563,7 +563,7 @@ static int evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
 	struct evergreen_cs_track *track = p->track;
 	struct eg_surface surf;
 	unsigned pitch, slice, mslice;
-	unsigned long offset;
+	u64 offset;
 	int r;
 
 	mslice = G_028008_SLICE_MAX(track->db_depth_view) + 1;
@@ -609,18 +609,18 @@ static int evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
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
@@ -628,18 +628,18 @@ static int evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
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
@@ -660,7 +660,7 @@ static int evergreen_cs_track_validate_depth(struct radeon_cs_parser *p)
 	struct evergreen_cs_track *track = p->track;
 	struct eg_surface surf;
 	unsigned pitch, slice, mslice;
-	unsigned long offset;
+	u64 offset;
 	int r;
 
 	mslice = G_028008_SLICE_MAX(track->db_depth_view) + 1;
@@ -707,34 +707,34 @@ static int evergreen_cs_track_validate_depth(struct radeon_cs_parser *p)
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
diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 15241b80e9d2..444a135158bd 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -999,45 +999,65 @@ static int r100_cp_init_microcode(struct radeon_device *rdev)
 
 	DRM_DEBUG_KMS("\n");
 
-	if ((rdev->family == CHIP_R100) || (rdev->family == CHIP_RV100) ||
-	    (rdev->family == CHIP_RV200) || (rdev->family == CHIP_RS100) ||
-	    (rdev->family == CHIP_RS200)) {
+	switch (rdev->family) {
+	case CHIP_R100:
+	case CHIP_RV100:
+	case CHIP_RV200:
+	case CHIP_RS100:
+	case CHIP_RS200:
 		DRM_INFO("Loading R100 Microcode\n");
 		fw_name = FIRMWARE_R100;
-	} else if ((rdev->family == CHIP_R200) ||
-		   (rdev->family == CHIP_RV250) ||
-		   (rdev->family == CHIP_RV280) ||
-		   (rdev->family == CHIP_RS300)) {
+		break;
+
+	case CHIP_R200:
+	case CHIP_RV250:
+	case CHIP_RV280:
+	case CHIP_RS300:
 		DRM_INFO("Loading R200 Microcode\n");
 		fw_name = FIRMWARE_R200;
-	} else if ((rdev->family == CHIP_R300) ||
-		   (rdev->family == CHIP_R350) ||
-		   (rdev->family == CHIP_RV350) ||
-		   (rdev->family == CHIP_RV380) ||
-		   (rdev->family == CHIP_RS400) ||
-		   (rdev->family == CHIP_RS480)) {
+		break;
+
+	case CHIP_R300:
+	case CHIP_R350:
+	case CHIP_RV350:
+	case CHIP_RV380:
+	case CHIP_RS400:
+	case CHIP_RS480:
 		DRM_INFO("Loading R300 Microcode\n");
 		fw_name = FIRMWARE_R300;
-	} else if ((rdev->family == CHIP_R420) ||
-		   (rdev->family == CHIP_R423) ||
-		   (rdev->family == CHIP_RV410)) {
+		break;
+
+	case CHIP_R420:
+	case CHIP_R423:
+	case CHIP_RV410:
 		DRM_INFO("Loading R400 Microcode\n");
 		fw_name = FIRMWARE_R420;
-	} else if ((rdev->family == CHIP_RS690) ||
-		   (rdev->family == CHIP_RS740)) {
+		break;
+
+	case CHIP_RS690:
+	case CHIP_RS740:
 		DRM_INFO("Loading RS690/RS740 Microcode\n");
 		fw_name = FIRMWARE_RS690;
-	} else if (rdev->family == CHIP_RS600) {
+		break;
+
+	case CHIP_RS600:
 		DRM_INFO("Loading RS600 Microcode\n");
 		fw_name = FIRMWARE_RS600;
-	} else if ((rdev->family == CHIP_RV515) ||
-		   (rdev->family == CHIP_R520) ||
-		   (rdev->family == CHIP_RV530) ||
-		   (rdev->family == CHIP_R580) ||
-		   (rdev->family == CHIP_RV560) ||
-		   (rdev->family == CHIP_RV570)) {
+		break;
+
+	case CHIP_RV515:
+	case CHIP_R520:
+	case CHIP_RV530:
+	case CHIP_R580:
+	case CHIP_RV560:
+	case CHIP_RV570:
 		DRM_INFO("Loading R500 Microcode\n");
 		fw_name = FIRMWARE_R520;
+		break;
+
+	default:
+		DRM_ERROR("Unsupported Radeon family %u\n", rdev->family);
+		return -EINVAL;
 	}
 
 	err = request_firmware(&rdev->me_fw, fw_name, rdev->dev);
diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 821b03d6142b..317843bd67d9 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -1727,23 +1727,29 @@ struct radeon_encoder_atom_dig *radeon_atombios_get_lvds_info(struct
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
-						fake_edid_record->ucFakeEDIDLength + 2 :
-						sizeof(ATOM_FAKE_EDID_PATCH_RECORD);
 					break;
 				case LCD_PANEL_RESOLUTION_RECORD_TYPE:
 					panel_res_record = (ATOM_PANEL_RESOLUTION_PATCH_RECORD *)record;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index c502d24b8253..63c4e16ec449 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -308,8 +308,8 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 	if (info->is_yuv)
 		is_yuv = true;
 
-	if (dst_w > 3840) {
-		DRM_DEV_ERROR(vop->dev, "Maximum dst width (3840) exceeded\n");
+	if (dst_w > 4096) {
+		DRM_DEV_ERROR(vop->dev, "Maximum dst width (4096) exceeded\n");
 		return;
 	}
 
diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index f2021b23554d..dade0ecdfc1a 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -152,10 +152,12 @@ static int stm_drm_platform_probe(struct platform_device *pdev)
 
 	ret = drm_dev_register(ddev, 0);
 	if (ret)
-		goto err_put;
+		goto err_unload;
 
 	return 0;
 
+err_unload:
+	drv_unload(ddev);
 err_put:
 	drm_dev_put(ddev);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index bf8c721ebfe9..77fba2867c4c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1468,6 +1468,7 @@ static struct drm_framebuffer *vmw_kms_fb_create(struct drm_device *dev,
 		DRM_ERROR("Surface size cannot exceed %dx%d",
 			dev_priv->texture_max_width,
 			dev_priv->texture_max_height);
+		ret = -EINVAL;
 		goto err_out;
 	}
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3267e2da30e6..0cb25ecfb2a1 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -916,6 +916,8 @@
 #define USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3220_SERIES	0xc056
 #define USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3215_SERIES	0xc057
 #define USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3225_SERIES	0xc058
+#define USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3325_SERIES	0x430c
+#define USB_DEVICE_ID_PLANTRONICS_ENCOREPRO_500_SERIES		0x431e
 
 #define USB_VENDOR_ID_PANASONIC		0x04da
 #define USB_DEVICE_ID_PANABOARD_UBT780	0x1044
diff --git a/drivers/hid/hid-plantronics.c b/drivers/hid/hid-plantronics.c
index 3b75cadd543f..1f1716da4af1 100644
--- a/drivers/hid/hid-plantronics.c
+++ b/drivers/hid/hid-plantronics.c
@@ -41,8 +41,10 @@
 			    (usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER)
 
 #define PLT_QUIRK_DOUBLE_VOLUME_KEYS BIT(0)
+#define PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS BIT(1)
 
 #define PLT_DOUBLE_KEY_TIMEOUT 5 /* ms */
+#define PLT_FOLLOWED_OPPOSITE_KEY_TIMEOUT 220 /* ms */
 
 struct plt_drv_data {
 	unsigned long device_type;
@@ -140,6 +142,21 @@ static int plantronics_event(struct hid_device *hdev, struct hid_field *field,
 
 		drv_data->last_volume_key_ts = cur_ts;
 	}
+	if (drv_data->quirks & PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS) {
+		unsigned long prev_ts, cur_ts;
+
+		/* Usages are filtered in plantronics_usages. */
+
+		if (!value) /* Handle key presses only. */
+			return 0;
+
+		prev_ts = drv_data->last_volume_key_ts;
+		cur_ts = jiffies;
+		if (jiffies_to_msecs(cur_ts - prev_ts) <= PLT_FOLLOWED_OPPOSITE_KEY_TIMEOUT)
+			return 1; /* Ignore the followed opposite volume key. */
+
+		drv_data->last_volume_key_ts = cur_ts;
+	}
 
 	return 0;
 }
@@ -213,6 +230,12 @@ static const struct hid_device_id plantronics_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
 					 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3225_SERIES),
 		.driver_data = PLT_QUIRK_DOUBLE_VOLUME_KEYS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
+					 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3325_SERIES),
+		.driver_data = PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
+					 USB_DEVICE_ID_PLANTRONICS_ENCOREPRO_500_SERIES),
+		.driver_data = PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS, HID_ANY_ID) },
 	{ }
 };
diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index 162401aaef71..3015dd1a7514 100644
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -117,9 +117,10 @@ static inline int LIMIT_TO_MV(int limit, int range)
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
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index c52d07c6b49f..6e4c1453b8ab 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -57,6 +57,7 @@ static const struct platform_device_id ntc_thermistor_id[] = {
 	{ "ncp15xh103", TYPE_NCPXXXH103 },
 	{ },
 };
+MODULE_DEVICE_TABLE(platform, ntc_thermistor_id);
 
 /*
  * A compensation table should be sorted by the values of .ohm
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 8f850c22be41..99344e9daf5d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -222,6 +222,7 @@ void tmc_free_sg_table(struct tmc_sg_table *sg_table)
 {
 	tmc_free_table_pages(sg_table);
 	tmc_free_data_pages(sg_table);
+	kfree(sg_table);
 }
 
 /*
@@ -302,7 +303,6 @@ struct tmc_sg_table *tmc_alloc_sg_table(struct device *dev,
 		rc = tmc_alloc_table_pages(sg_table);
 	if (rc) {
 		tmc_free_sg_table(sg_table);
-		kfree(sg_table);
 		return ERR_PTR(rc);
 	}
 
diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index d9401b519106..d142e951bf98 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -159,6 +159,13 @@ struct aspeed_i2c_bus {
 
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
@@ -176,7 +183,7 @@ static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
 			command);
 
 		reinit_completion(&bus->cmd_complete);
-		writel(ASPEED_I2CD_M_STOP_CMD, bus->base + ASPEED_I2C_CMD_REG);
+		aspeed_i2c_do_stop(bus);
 		spin_unlock_irqrestore(&bus->lock, flags);
 
 		time_left = wait_for_completion_timeout(
@@ -350,13 +357,6 @@ static void aspeed_i2c_do_start(struct aspeed_i2c_bus *bus)
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
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index c1e2539b7950..b552f8d62fa2 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1674,8 +1674,15 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	i801_add_tco(priv);
 
+	/*
+	 * adapter.name is used by platform code to find the main I801 adapter
+	 * to instantiante i2c_clients, do not change.
+	 */
 	snprintf(priv->adapter.name, sizeof(priv->adapter.name),
-		"SMBus I801 adapter at %04lx", priv->smba);
+		 "SMBus %s adapter at %04lx",
+		 (priv->features & FEATURE_IDF) ? "I801 IDF" : "I801",
+		 priv->smba);
+
 	err = i2c_add_adapter(&priv->adapter);
 	if (err) {
 		platform_device_unregister(priv->tco_pdev);
diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index 5c754bf659e2..94b18f864849 100644
--- a/drivers/i2c/busses/i2c-isch.c
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -107,8 +107,7 @@ static int sch_transaction(void)
 	if (retries > MAX_RETRIES) {
 		dev_err(&sch_adapter.dev, "SMBus Timeout!\n");
 		result = -ETIMEDOUT;
-	}
-	if (temp & 0x04) {
+	} else if (temp & 0x04) {
 		result = -EIO;
 		dev_dbg(&sch_adapter.dev, "Bus collision! SMBus may be "
 			"locked until next hard reset. (sorry!)\n");
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index c1f85114ab81..bf0f86a47dd0 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -478,14 +478,17 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 			goto out;
 		}
 
-		xiic_fill_tx_fifo(i2c);
-
-		/* current message sent and there is space in the fifo */
-		if (!xiic_tx_space(i2c) && xiic_tx_fifo_space(i2c) >= 2) {
+		if (xiic_tx_space(i2c)) {
+			xiic_fill_tx_fifo(i2c);
+		} else {
+			/* current message fully written */
 			dev_dbg(i2c->adap.dev.parent,
 				"%s end of message sent, nmsgs: %d\n",
 				__func__, i2c->nmsgs);
-			if (i2c->nmsgs > 1) {
+			/* Don't move onto the next message until the TX FIFO empties,
+			 * to ensure that a NAK is not missed.
+			 */
+			if (i2c->nmsgs > 1 && (pend & XIIC_INTR_TX_EMPTY_MASK)) {
 				i2c->nmsgs--;
 				i2c->tx_msg++;
 				xfer_more = 1;
@@ -496,11 +499,7 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 					"%s Got TX IRQ but no more to do...\n",
 					__func__);
 			}
-		} else if (!xiic_tx_space(i2c) && (i2c->nmsgs == 1))
-			/* current frame is sent and is last,
-			 * make sure to disable tx half
-			 */
-			xiic_irq_dis(i2c, XIIC_INTR_TX_HALF_MASK);
+		}
 	}
 out:
 	dev_dbg(i2c->adap.dev.parent, "%s clr: 0x%x\n", __func__, clr);
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1dabd366ec0b..ef2eb0588aae 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -852,6 +852,8 @@ config TI_ADS7950
 config TI_ADS8688
 	tristate "Texas Instruments ADS8688"
 	depends on SPI && OF
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for Texas Instruments ADS8684 and
 	  and ADS8688 ADC chips
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 1e10c0af2f2c..3a9bb226d6ac 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -46,7 +46,7 @@ static ssize_t _hid_sensor_set_report_latency(struct device *dev,
 	latency = integer * 1000 + fract / 1000;
 	ret = hid_sensor_set_report_latency(attrb, latency);
 	if (ret < 0)
-		return len;
+		return ret;
 
 	attrb->latency_ms = hid_sensor_get_report_latency(attrb);
 
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 69f4cfa6494b..8a27d105cc06 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -335,6 +335,7 @@ config STM32_DAC
 
 config STM32_DAC_CORE
 	tristate
+	select REGMAP_MMIO
 
 config TI_DAC082S085
 	tristate "Texas Instruments 8/10/12-bit 2/4-channel DAC driver"
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 162eff78c673..8a4499f07668 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -145,6 +145,10 @@ static const struct opt3001_scale opt3001_scales[] = {
 		.val = 20966,
 		.val2 = 400000,
 	},
+	{
+		.val = 41932,
+		.val2 = 800000,
+	},
 	{
 		.val = 83865,
 		.val2 = 600000,
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 3303feb54984..a2bd9e10235a 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -673,22 +673,8 @@ static int ak8975_start_read_axis(struct ak8975_data *data,
 	if (ret < 0)
 		return ret;
 
-	/* This will be executed only for non-interrupt based waiting case */
-	if (ret & data->def->ctrl_masks[ST1_DRDY]) {
-		ret = i2c_smbus_read_byte_data(client,
-					       data->def->ctrl_regs[ST2]);
-		if (ret < 0) {
-			dev_err(&client->dev, "Error in reading ST2\n");
-			return ret;
-		}
-		if (ret & (data->def->ctrl_masks[ST2_DERR] |
-			   data->def->ctrl_masks[ST2_HOFL])) {
-			dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
+	/* Return with zero if the data is ready. */
+	return !data->def->ctrl_regs[ST1_DRDY];
 }
 
 /* Retrieve raw flux value for one of the x, y, or z axis.  */
@@ -715,6 +701,20 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	if (ret < 0)
 		goto exit;
 
+	/* Read out ST2 for release lock on measurment data. */
+	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]);
+	if (ret < 0) {
+		dev_err(&client->dev, "Error in reading ST2\n");
+		goto exit;
+	}
+
+	if (ret & (data->def->ctrl_masks[ST2_DERR] |
+		   data->def->ctrl_masks[ST2_HOFL])) {
+		dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	mutex_unlock(&data->lock);
 
 	pm_runtime_mark_last_busy(&data->client->dev);
diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 84fa7b727a2b..6070488850ed 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -1178,7 +1178,7 @@ static int __init iw_cm_init(void)
 	if (ret)
 		return ret;
 
-	iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", 0);
+	iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", WQ_MEM_RECLAIM);
 	if (!iwcm_wq)
 		goto err_alloc;
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index d0b24e961511..aed0c53d84be 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -150,7 +150,7 @@ struct bnxt_qplib_swqe {
 			};
 			u32		q_key;
 			u32		dst_qp;
-			u16		avid;
+			u32		avid;
 		} send;
 
 		/* Send Raw Ethernet and QP1 */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 8b3b5fdc19bb..092cc11428f5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -234,7 +234,7 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 		/* failed with status */
 		dev_err(&rcfw->pdev->dev, "QPLIB: cmdq[%#x]=%#x status %#x",
 			cookie, opcode, evnt->status);
-		rc = -EFAULT;
+		rc = -EIO;
 	}
 
 	return rc;
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index e8d2135df22d..81b5b009a0dd 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -1180,6 +1180,8 @@ static int act_establish(struct c4iw_dev *dev, struct sk_buff *skb)
 	int ret;
 
 	ep = lookup_atid(t, atid);
+	if (!ep)
+		return -EINVAL;
 
 	pr_debug("ep %p tid %u snd_isn %u rcv_isn %u\n", ep, tid,
 		 be32_to_cpu(req->snd_isn), be32_to_cpu(req->rcv_isn));
@@ -2041,7 +2043,7 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 	err = -ENOMEM;
 	if (n->dev->flags & IFF_LOOPBACK) {
 		if (iptype == 4)
-			pdev = ip_dev_find(&init_net, *(__be32 *)peer_ip);
+			pdev = __ip_dev_find(&init_net, *(__be32 *)peer_ip, false);
 		else if (IS_ENABLED(CONFIG_IPV6))
 			for_each_netdev(&init_net, pdev) {
 				if (ipv6_chk_addr(&init_net,
@@ -2056,12 +2058,12 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 			err = -ENODEV;
 			goto out;
 		}
+		if (is_vlan_dev(pdev))
+			pdev = vlan_dev_real_dev(pdev);
 		ep->l2t = cxgb4_l2t_get(cdev->rdev.lldi.l2t,
 					n, pdev, rt_tos2priority(tos));
-		if (!ep->l2t) {
-			dev_put(pdev);
+		if (!ep->l2t)
 			goto out;
-		}
 		ep->mtu = pdev->mtu;
 		ep->tx_chan = cxgb4_port_chan(pdev);
 		ep->smac_idx = cxgb4_tp_smt_idx(adapter_type,
@@ -2075,7 +2077,6 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 		ep->rss_qid = cdev->rdev.lldi.rxq_ids[
 			cxgb4_port_idx(pdev) * step];
 		set_tcp_window(ep, (struct port_info *)netdev_priv(pdev));
-		dev_put(pdev);
 	} else {
 		pdev = get_real_dev(n->dev);
 		ep->l2t = cxgb4_l2t_get(cdev->rdev.lldi.l2t,
@@ -2235,6 +2236,9 @@ static int act_open_rpl(struct c4iw_dev *dev, struct sk_buff *skb)
 	int ret = 0;
 
 	ep = lookup_atid(t, atid);
+	if (!ep)
+		return -EINVAL;
+
 	la = (struct sockaddr_in *)&ep->com.local_addr;
 	ra = (struct sockaddr_in *)&ep->com.remote_addr;
 	la6 = (struct sockaddr_in6 *)&ep->com.local_addr;
diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
index 2835fba71c33..482b214feaab 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -390,10 +390,17 @@ static int adp5589_gpio_get_value(struct gpio_chip *chip, unsigned off)
 	struct adp5589_kpad *kpad = gpiochip_get_data(chip);
 	unsigned int bank = kpad->var->bank(kpad->gpiomap[off]);
 	unsigned int bit = kpad->var->bit(kpad->gpiomap[off]);
+	int val;
 
-	return !!(adp5589_read(kpad->client,
-			       kpad->var->reg(ADP5589_GPI_STATUS_A) + bank) &
-			       bit);
+	mutex_lock(&kpad->gpio_lock);
+	if (kpad->dir[bank] & bit)
+		val = kpad->dat_out[bank];
+	else
+		val = adp5589_read(kpad->client,
+				   kpad->var->reg(ADP5589_GPI_STATUS_A) + bank);
+	mutex_unlock(&kpad->gpio_lock);
+
+	return !!(val & bit);
 }
 
 static void adp5589_gpio_set_value(struct gpio_chip *chip,
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 0da814b41e72..75cd4c813cbb 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -981,12 +981,12 @@ static int rmi_driver_remove(struct device *dev)
 
 	rmi_disable_irq(rmi_dev, false);
 
-	irq_domain_remove(data->irqdomain);
-	data->irqdomain = NULL;
-
 	rmi_f34_remove_sysfs(rmi_dev);
 	rmi_free_function_list(rmi_dev);
 
+	irq_domain_remove(data->irqdomain);
+	data->irqdomain = NULL;
+
 	return 0;
 }
 
diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
index e92bbc533821..9466cb007629 100644
--- a/drivers/mailbox/bcm2835-mailbox.c
+++ b/drivers/mailbox/bcm2835-mailbox.c
@@ -152,7 +152,8 @@ static int bcm2835_mbox_probe(struct platform_device *pdev)
 	spin_lock_init(&mbox->lock);
 
 	ret = devm_request_irq(dev, irq_of_parse_and_map(dev->of_node, 0),
-			       bcm2835_mbox_irq, 0, dev_name(dev), mbox);
+			       bcm2835_mbox_irq, IRQF_NO_SUSPEND, dev_name(dev),
+			       mbox);
 	if (ret) {
 		dev_err(dev, "Failed to register a mailbox IRQ handler: %d\n",
 			ret);
diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index d702a204f5c1..bf09ab923d1e 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -167,7 +167,7 @@ static const struct of_device_id rockchip_mbox_of_match[] = {
 	{ .compatible = "rockchip,rk3368-mailbox", .data = &rk3368_drv_data},
 	{ },
 };
-MODULE_DEVICE_TABLE(of, rockchp_mbox_of_match);
+MODULE_DEVICE_TABLE(of, rockchip_mbox_of_match);
 
 static int rockchip_mbox_probe(struct platform_device *pdev)
 {
diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 50015a2ea5ce..98719aa986bb 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -281,6 +281,10 @@ static void __vb2_plane_dmabuf_put(struct vb2_buffer *vb, struct vb2_plane *p)
 	p->mem_priv = NULL;
 	p->dbuf = NULL;
 	p->dbuf_mapped = 0;
+	p->bytesused = 0;
+	p->length = 0;
+	p->m.fd = 0;
+	p->data_offset = 0;
 }
 
 /*
@@ -1169,10 +1173,6 @@ static int __prepare_dmabuf(struct vb2_buffer *vb, const void *pb)
 
 		/* Release previously acquired memory if present */
 		__vb2_plane_dmabuf_put(vb, &vb->planes[plane]);
-		vb->planes[plane].bytesused = 0;
-		vb->planes[plane].length = 0;
-		vb->planes[plane].m.fd = 0;
-		vb->planes[plane].data_offset = 0;
 
 		/* Acquire each plane's memory */
 		mem_priv = call_ptr_memop(vb, attach_dmabuf,
diff --git a/drivers/media/dvb-frontends/rtl2830.c b/drivers/media/dvb-frontends/rtl2830.c
index c0659568471b..8cda25902d63 100644
--- a/drivers/media/dvb-frontends/rtl2830.c
+++ b/drivers/media/dvb-frontends/rtl2830.c
@@ -619,7 +619,7 @@ static int rtl2830_pid_filter(struct dvb_frontend *fe, u8 index, u16 pid, int on
 		index, pid, onoff);
 
 	/* skip invalid PIDs (0x2000) */
-	if (pid > 0x1fff || index > 32)
+	if (pid > 0x1fff || index >= 32)
 		return 0;
 
 	if (onoff)
diff --git a/drivers/media/dvb-frontends/rtl2832.c b/drivers/media/dvb-frontends/rtl2832.c
index 7cad4e985315..608bd2a81633 100644
--- a/drivers/media/dvb-frontends/rtl2832.c
+++ b/drivers/media/dvb-frontends/rtl2832.c
@@ -995,7 +995,7 @@ static int rtl2832_pid_filter(struct dvb_frontend *fe, u8 index, u16 pid,
 		index, pid, onoff, dev->slave_ts);
 
 	/* skip invalid PIDs (0x2000) */
-	if (pid > 0x1fff || index > 32)
+	if (pid > 0x1fff || index >= 32)
 		return 0;
 
 	if (onoff)
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 168f5af6abcc..b661769445e5 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -348,6 +348,7 @@ static int venus_remove(struct platform_device *pdev)
 	struct device *dev = core->dev;
 	int ret;
 
+	cancel_delayed_work_sync(&core->work);
 	ret = pm_runtime_get_sync(dev);
 	WARN_ON(ret < 0);
 
diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/grukservices.c
index 030769018461..256be2e12faa 100644
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -270,7 +270,6 @@ static int gru_get_cpu_resources(int dsr_bytes, void **cb, void **dsr)
 	int lcpu;
 
 	BUG_ON(dsr_bytes > GRU_NUM_KERNEL_DSR_BYTES);
-	preempt_disable();
 	bs = gru_lock_kernel_context(-1);
 	lcpu = uv_blade_processor_id();
 	*cb = bs->kernel_cb + lcpu * GRU_HANDLE_STRIDE;
@@ -284,7 +283,6 @@ static int gru_get_cpu_resources(int dsr_bytes, void **cb, void **dsr)
 static void gru_free_cpu_resources(void *cb, void *dsr)
 {
 	gru_unlock_kernel_context(uv_numa_blade_id());
-	preempt_enable();
 }
 
 /*
diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index 8c3e0317c115..cb4c97210ec3 100644
--- a/drivers/misc/sgi-gru/grumain.c
+++ b/drivers/misc/sgi-gru/grumain.c
@@ -954,10 +954,8 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 
 again:
 	mutex_lock(&gts->ts_ctxlock);
-	preempt_disable();
 
 	if (gru_check_context_placement(gts)) {
-		preempt_enable();
 		mutex_unlock(&gts->ts_ctxlock);
 		gru_unload_context(gts, 1);
 		return VM_FAULT_NOPAGE;
@@ -966,7 +964,6 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 	if (!gts->ts_gru) {
 		STAT(load_user_context);
 		if (!gru_assign_gru_context(gts)) {
-			preempt_enable();
 			mutex_unlock(&gts->ts_ctxlock);
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(GRU_ASSIGN_DELAY);  /* true hack ZZZ */
@@ -982,7 +979,6 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 				vma->vm_page_prot);
 	}
 
-	preempt_enable();
 	mutex_unlock(&gts->ts_ctxlock);
 
 	return VM_FAULT_NOPAGE;
diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
index be28f05bfafa..0f837cc3a417 100644
--- a/drivers/misc/sgi-gru/grutlbpurge.c
+++ b/drivers/misc/sgi-gru/grutlbpurge.c
@@ -78,7 +78,6 @@ static struct gru_tlb_global_handle *get_lock_tgh_handle(struct gru_state
 	struct gru_tlb_global_handle *tgh;
 	int n;
 
-	preempt_disable();
 	if (uv_numa_blade_id() == gru->gs_blade_id)
 		n = get_on_blade_tgh(gru);
 	else
@@ -92,7 +91,6 @@ static struct gru_tlb_global_handle *get_lock_tgh_handle(struct gru_state
 static void get_unlock_tgh_handle(struct gru_tlb_global_handle *tgh)
 {
 	unlock_tgh_handle(tgh);
-	preempt_enable();
 }
 
 /*
diff --git a/drivers/mtd/devices/slram.c b/drivers/mtd/devices/slram.c
index 10183ee4e12b..aa4f73aef362 100644
--- a/drivers/mtd/devices/slram.c
+++ b/drivers/mtd/devices/slram.c
@@ -295,10 +295,12 @@ static int __init init_slram(void)
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
diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index ea243840ee0f..aca35c9d9fbd 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -363,7 +363,8 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
 		dev_err_ratelimited(chip->dev,
 				    "ATU full violation for %pM portvec %x spid %d\n",
 				    entry.mac, entry.portvec, spid);
-		chip->ports[spid].atu_full_violation++;
+		if (spid < ARRAY_SIZE(chip->ports))
+			chip->ports[spid].atu_full_violation++;
 	}
 	mutex_unlock(&chip->reg_lock);
 
diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
index 4df8da8f5e7e..59690330d81c 100644
--- a/drivers/net/ethernet/aeroflex/greth.c
+++ b/drivers/net/ethernet/aeroflex/greth.c
@@ -488,7 +488,7 @@ greth_start_xmit_gbit(struct sk_buff *skb, struct net_device *dev)
 
 	if (unlikely(skb->len > MAX_FRAME_SIZE)) {
 		dev->stats.tx_errors++;
-		goto out;
+		goto len_error;
 	}
 
 	/* Save skb pointer. */
@@ -579,6 +579,7 @@ greth_start_xmit_gbit(struct sk_buff *skb, struct net_device *dev)
 map_error:
 	if (net_ratelimit())
 		dev_warn(greth->dev, "Could not create TX DMA mapping\n");
+len_error:
 	dev_kfree_skb(skb);
 out:
 	return err;
diff --git a/drivers/net/ethernet/amd/mvme147.c b/drivers/net/ethernet/amd/mvme147.c
index 0a920448522f..0bb27f4dd642 100644
--- a/drivers/net/ethernet/amd/mvme147.c
+++ b/drivers/net/ethernet/amd/mvme147.c
@@ -105,10 +105,6 @@ struct net_device * __init mvme147lance_probe(int unit)
 	address = address >> 8;
 	dev->dev_addr[3] = address&0xff;
 
-	printk("%s: MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
-	       dev->name, dev->base_addr, MVME147_LANCE_IRQ,
-	       dev->dev_addr);
-
 	lp = netdev_priv(dev);
 	lp->ram = __get_dma_pages(GFP_ATOMIC, 3);	/* 32K */
 	if (!lp->ram) {
@@ -138,6 +134,9 @@ struct net_device * __init mvme147lance_probe(int unit)
 		return ERR_PTR(err);
 	}
 
+	netdev_info(dev, "MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
+		    dev->base_addr, MVME147_LANCE_IRQ, dev->dev_addr);
+
 	return dev;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index b3fc8745b580..55b869f5c825 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1319,6 +1319,7 @@ static netdev_tx_t bcm_sysport_xmit(struct sk_buff *skb,
 		netif_err(priv, tx_err, dev, "DMA map failed at %p (len=%d)\n",
 			  skb->data, skb_len);
 		ret = NETDEV_TX_OK;
+		dev_kfree_skb_any(skb);
 		goto out;
 	}
 
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index d464dec9825a..556600e425b3 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -81,8 +81,7 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 #define GMAC0_IRQ4_8 (GMAC0_MIB_INT_BIT | GMAC0_RX_OVERRUN_INT_BIT)
 
 #define GMAC_OFFLOAD_FEATURES (NETIF_F_SG | NETIF_F_IP_CSUM | \
-		NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | \
-		NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6)
+			       NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM)
 
 /**
  * struct gmac_queue_page - page buffer per-page info
@@ -1156,23 +1155,13 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	struct gmac_txdesc *txd;
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
-	unsigned short mtu;
 	void *buffer;
 	int ret;
 
-	mtu  = ETH_HLEN;
-	mtu += netdev->mtu;
-	if (skb->protocol == htons(ETH_P_8021Q))
-		mtu += VLAN_HLEN;
-
+	/* TODO: implement proper TSO using MTU in word3 */
 	word1 = skb->len;
 	word3 = SOF_BIT;
 
-	if (word1 > mtu) {
-		word1 |= TSS_MTU_ENABLE_BIT;
-		word3 |= mtu;
-	}
-
 	if (skb->len >= ETH_FRAME_LEN) {
 		/* Hardware offloaded checksumming isn't working on frames
 		 * bigger than 1514 bytes. A hypothesis about this is that the
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index d0d9a420f557..8215bd1ca022 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1386,10 +1386,8 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 	be_get_wrb_params_from_skb(adapter, skb, &wrb_params);
 
 	wrb_cnt = be_xmit_enqueue(adapter, txo, skb, &wrb_params);
-	if (unlikely(!wrb_cnt)) {
-		dev_kfree_skb_any(skb);
-		goto drop;
-	}
+	if (unlikely(!wrb_cnt))
+		goto drop_skb;
 
 	/* if os2bmc is enabled and if the pkt is destined to bmc,
 	 * enqueue the pkt a 2nd time with mgmt bit set.
@@ -1398,7 +1396,7 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 		BE_WRB_F_SET(wrb_params.features, OS2BMC, 1);
 		wrb_cnt = be_xmit_enqueue(adapter, txo, skb, &wrb_params);
 		if (unlikely(!wrb_cnt))
-			goto drop;
+			goto drop_skb;
 		else
 			skb_get(skb);
 	}
@@ -1412,6 +1410,8 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 		be_xmit_flush(adapter, txo);
 
 	return NETDEV_TX_OK;
+drop_skb:
+	dev_kfree_skb_any(skb);
 drop:
 	tx_stats(txo)->tx_drv_drops++;
 	/* Flush the already enqueued tx requests */
diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 23c019d1278c..f6ed8d167d53 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -579,7 +579,7 @@ static bool ftgmac100_rx_packet(struct ftgmac100 *priv, int *processed)
 	(*processed)++;
 	return true;
 
- drop:
+drop:
 	/* Clean rxdes0 (which resets own bit) */
 	rxdes->rxdes0 = cpu_to_le32(status & priv->rxdes0_edorr_mask);
 	priv->rx_pointer = ftgmac100_next_rx_pointer(priv, pointer);
@@ -663,6 +663,11 @@ static bool ftgmac100_tx_complete_packet(struct ftgmac100 *priv)
 	ftgmac100_free_tx_packet(priv, pointer, skb, txdes, ctl_stat);
 	txdes->txdes0 = cpu_to_le32(ctl_stat & priv->txdes0_edotr_mask);
 
+	/* Ensure the descriptor config is visible before setting the tx
+	 * pointer.
+	 */
+	smp_wmb();
+
 	priv->tx_clean_pointer = ftgmac100_next_tx_pointer(priv, pointer);
 
 	return true;
@@ -816,6 +821,11 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	dma_wmb();
 	first->txdes0 = cpu_to_le32(f_ctl_stat);
 
+	/* Ensure the descriptor config is visible before setting the tx
+	 * pointer.
+	 */
+	smp_wmb();
+
 	/* Update next TX pointer */
 	priv->tx_pointer = pointer;
 
@@ -836,7 +846,7 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 
 	return NETDEV_TX_OK;
 
- dma_err:
+dma_err:
 	if (net_ratelimit())
 		netdev_err(netdev, "map tx fragment failed\n");
 
@@ -858,7 +868,7 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	 * last fragment, so we know ftgmac100_free_tx_packet()
 	 * hasn't freed the skb yet.
 	 */
- drop:
+drop:
 	/* Drop the packet */
 	dev_kfree_skb_any(skb);
 	netdev->stats.tx_dropped++;
@@ -1444,7 +1454,7 @@ static void ftgmac100_reset_task(struct work_struct *work)
 	ftgmac100_init_all(priv, true);
 
 	netdev_dbg(netdev, "Reset done !\n");
- bail:
+bail:
 	if (priv->mii_bus)
 		mutex_unlock(&priv->mii_bus->mdio_lock);
 	if (netdev->phydev)
@@ -1515,15 +1525,15 @@ static int ftgmac100_open(struct net_device *netdev)
 
 	return 0;
 
- err_ncsi:
+err_ncsi:
 	napi_disable(&priv->napi);
 	netif_stop_queue(netdev);
- err_alloc:
+err_alloc:
 	ftgmac100_free_buffers(priv);
 	free_irq(netdev->irq, netdev);
- err_irq:
+err_irq:
 	netif_napi_del(&priv->napi);
- err_hw:
+err_hw:
 	iowrite32(0, priv->base + FTGMAC100_OFFSET_IER);
 	ftgmac100_free_rings(priv);
 	return err;
diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 0653d8176e6a..6349e7c7c074 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -97,7 +97,7 @@
 			    FTGMAC100_INT_RPKT_BUF)
 
 /* All the interrupts we care about */
-#define FTGMAC100_INT_ALL (FTGMAC100_INT_RPKT_BUF  |  \
+#define FTGMAC100_INT_ALL (FTGMAC100_INT_RXTX  |  \
 			   FTGMAC100_INT_BAD)
 
 /*
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 4b21ae27a9fd..5c60f2a2b6d8 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2055,12 +2055,12 @@ static netdev_tx_t
 dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 {
 	const int queue_mapping = skb_get_queue_mapping(skb);
-	bool nonlinear = skb_is_nonlinear(skb);
 	struct rtnl_link_stats64 *percpu_stats;
 	struct dpaa_percpu_priv *percpu_priv;
 	struct netdev_queue *txq;
 	struct dpaa_priv *priv;
 	struct qm_fd fd;
+	bool nonlinear;
 	int offset = 0;
 	int err = 0;
 
@@ -2070,6 +2070,13 @@ dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 
 	qm_fd_clear_fd(&fd);
 
+	/* Packet data is always read as 32-bit words, so zero out any part of
+	 * the skb which might be sent if we have to pad the packet
+	 */
+	if (__skb_put_padto(skb, ETH_ZLEN, false))
+		goto enomem;
+
+	nonlinear = skb_is_nonlinear(skb);
 	if (!nonlinear) {
 		/* We're going to store the skb backpointer at the beginning
 		 * of the data buffer, so we need a privately owned skb
diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index 718afa4be2a0..c0ca12dd5f15 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -861,6 +861,7 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	priv->tx_coalesce_timer.function = tx_done;
 
 	priv->map = syscon_node_to_regmap(arg.np);
+	of_node_put(arg.np);
 	if (IS_ERR(priv->map)) {
 		dev_warn(d, "no syscon hisilicon,hip04-ppe\n");
 		ret = PTR_ERR(priv->map);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index d2791bcff5d4..5ee4317e5a52 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -937,6 +937,7 @@ static int hns_mac_get_info(struct hns_mac_cb *mac_cb)
 			mac_cb->cpld_ctrl = NULL;
 		} else {
 			syscon = syscon_node_to_regmap(cpld_args.np);
+			of_node_put(cpld_args.np);
 			if (IS_ERR_OR_NULL(syscon)) {
 				dev_dbg(mac_cb->dev, "no cpld-syscon found!\n");
 				mac_cb->cpld_ctrl = NULL;
diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index 9a3bc0994a1d..b0f798042e41 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -508,6 +508,7 @@ static int hns_mdio_probe(struct platform_device *pdev)
 						MDIO_SC_RESET_ST;
 				}
 			}
+			of_node_put(reg_args.np);
 		} else {
 			dev_warn(&pdev->dev, "find syscon ret = %#x\n", ret);
 			mdio_dev->subctrl_vbase = NULL;
diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
index e0c9fee4e1e6..7948d59b9628 100644
--- a/drivers/net/ethernet/i825xx/sun3_82586.c
+++ b/drivers/net/ethernet/i825xx/sun3_82586.c
@@ -1015,6 +1015,7 @@ sun3_82586_send_packet(struct sk_buff *skb, struct net_device *dev)
 	if(skb->len > XMIT_BUFF_SIZE)
 	{
 		printk("%s: Sorry, max. framelength is %d bytes. The length of your frame is %d bytes.\n",dev->name,XMIT_BUFF_SIZE,skb->len);
+		dev_kfree_skb(skb);
 		return NETDEV_TX_OK;
 	}
 
diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index fff09dcf9e34..9b3ba4db3222 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -581,7 +581,7 @@ static int mal_probe(struct platform_device *ofdev)
 		printk(KERN_ERR "%pOF: Support for 405EZ not enabled!\n",
 				ofdev->dev.of_node);
 		err = -ENODEV;
-		goto fail;
+		goto fail_unmap;
 #endif
 	}
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 01138fc93ea1..3a65dccc08ba 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9151,6 +9151,10 @@ static void igb_io_resume(struct pci_dev *pdev)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
 	if (netif_running(netdev)) {
+		if (!test_bit(__IGB_DOWN, &adapter->state)) {
+			dev_dbg(&pdev->dev, "Resuming from non-fatal error, do nothing.\n");
+			return;
+		}
 		if (igb_up(adapter)) {
 			dev_err(&pdev->dev, "igb_up failed after reset\n");
 			return;
diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index a5ab6f3403ae..9b2471b2a955 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -966,15 +966,13 @@ jme_udpsum(struct sk_buff *skb)
 	if (skb->protocol != htons(ETH_P_IP))
 		return csum;
 	skb_set_network_header(skb, ETH_HLEN);
-	if ((ip_hdr(skb)->protocol != IPPROTO_UDP) ||
-	    (skb->len < (ETH_HLEN +
-			(ip_hdr(skb)->ihl << 2) +
-			sizeof(struct udphdr)))) {
+
+	if (ip_hdr(skb)->protocol != IPPROTO_UDP ||
+	    skb->len < (ETH_HLEN + ip_hdrlen(skb) + sizeof(struct udphdr))) {
 		skb_reset_network_header(skb);
 		return csum;
 	}
-	skb_set_transport_header(skb,
-			ETH_HLEN + (ip_hdr(skb)->ihl << 2));
+	skb_set_transport_header(skb, ETH_HLEN + ip_hdrlen(skb));
 	csum = udp_hdr(skb)->check;
 	skb_reset_transport_header(skb);
 	skb_reset_network_header(skb);
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index b41822d08649..d492b8899d32 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -478,7 +478,9 @@ ltq_etop_tx(struct sk_buff *skb, struct net_device *dev)
 	unsigned long flags;
 	u32 byte_offset;
 
-	len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
+	if (skb_put_padto(skb, ETH_ZLEN))
+		return NETDEV_TX_OK;
+	len = skb->len;
 
 	if ((desc->ctl & (LTQ_DMA_OWN | LTQ_DMA_C)) || ch->skb[ch->dma.desc]) {
 		netdev_err(dev, "tx ring full\n");
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 23f60bc5d48f..57fbfef33665 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -756,7 +756,7 @@ struct mvpp2 {
 	unsigned int max_port_rxqs;
 
 	/* Workqueue to gather hardware statistics */
-	char queue_name[30];
+	char queue_name[31];
 	struct workqueue_struct *stats_queue;
 
 	/* Debugfs root entry */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index e09bd059984e..908984464c13 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1642,6 +1642,8 @@ static const struct pci_device_id mlx5_core_pci_table[] = {
 	{ PCI_VDEVICE(MELLANOX, 0x101a), MLX5_PCI_DEV_IS_VF},	/* ConnectX-5 Ex VF */
 	{ PCI_VDEVICE(MELLANOX, 0x101b) },			/* ConnectX-6 */
 	{ PCI_VDEVICE(MELLANOX, 0x101c), MLX5_PCI_DEV_IS_VF},	/* ConnectX-6 VF */
+	{ PCI_VDEVICE(MELLANOX, 0x101d) },			/* ConnectX-6 Dx */
+	{ PCI_VDEVICE(MELLANOX, 0x101e), MLX5_PCI_DEV_IS_VF},	/* ConnectX Family mlx5Gen Virtual Function */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d2) },			/* BlueField integrated ConnectX-5 network controller */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d3), MLX5_PCI_DEV_IS_VF},	/* BlueField integrated ConnectX-5 network controller VF */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d6) },			/* BlueField-2 integrated ConnectX-6 Dx network controller */
diff --git a/drivers/net/ethernet/seeq/ether3.c b/drivers/net/ethernet/seeq/ether3.c
index d1bb73bf9914..a612ca641888 100644
--- a/drivers/net/ethernet/seeq/ether3.c
+++ b/drivers/net/ethernet/seeq/ether3.c
@@ -851,9 +851,11 @@ static void ether3_remove(struct expansion_card *ec)
 {
 	struct net_device *dev = ecard_get_drvdata(ec);
 
+	ether3_outw(priv(dev)->regs.config2 |= CFG2_CTRLO, REG_CONFIG2);
 	ecard_set_drvdata(ec, NULL);
 
 	unregister_netdev(dev);
+	del_timer_sync(&priv(dev)->timer);
 	free_netdev(dev);
 	ecard_release_resources(ec);
 }
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 733cafb0888f..2a544724f0e2 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -853,31 +853,32 @@ static int gtp_encap_enable(struct gtp_dev *gtp, struct nlattr *data[])
 	unsigned int role = GTP_ROLE_GGSN;
 
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
-			if (sk0)
+		if (fd1 >= 0) {
+			sk1u = gtp_encap_enable_socket(fd1, UDP_ENCAP_GTP1U, gtp);
+			if (IS_ERR(sk1u)) {
 				gtp_encap_disable_sock(sk0);
-			return PTR_ERR(sk1u);
+				return PTR_ERR(sk1u);
+			}
 		}
 	}
 
 	if (data[IFLA_GTP_ROLE]) {
 		role = nla_get_u32(data[IFLA_GTP_ROLE]);
 		if (role > GTP_ROLE_SGSN) {
-			if (sk0)
-				gtp_encap_disable_sock(sk0);
-			if (sk1u)
-				gtp_encap_disable_sock(sk1u);
+			gtp_encap_disable_sock(sk0);
+			gtp_encap_disable_sock(sk1u);
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index e24513e34306..6bf63290978e 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2526,6 +2526,31 @@ static struct  hv_driver netvsc_drv = {
 	},
 };
 
+/* Set VF's namespace same as the synthetic NIC */
+static void netvsc_event_set_vf_ns(struct net_device *ndev)
+{
+	struct net_device_context *ndev_ctx = netdev_priv(ndev);
+	struct net_device *vf_netdev;
+	int ret;
+
+	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
+	if (!vf_netdev)
+		return;
+
+	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
+		ret = dev_change_net_namespace(vf_netdev, dev_net(ndev),
+					       "eth%d");
+		if (ret)
+			netdev_err(vf_netdev,
+				   "Cannot move to same namespace as %s: %d\n",
+				   ndev->name, ret);
+		else
+			netdev_info(vf_netdev,
+				    "Moved VF to namespace with: %s\n",
+				    ndev->name);
+	}
+}
+
 /*
  * On Hyper-V, every VF interface is matched with a corresponding
  * synthetic interface. The synthetic interface is presented first
@@ -2538,6 +2563,11 @@ static int netvsc_netdev_event(struct notifier_block *this,
 	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
 	int ret = 0;
 
+	if (event_dev->netdev_ops == &device_ops && event == NETDEV_REGISTER) {
+		netvsc_event_set_vf_ns(event_dev);
+		return NOTIFY_DONE;
+	}
+
 	ret = check_dev_is_matching_vf(event_dev);
 	if (ret != 0)
 		return NOTIFY_DONE;
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 54b19977fb67..d870a168caba 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -322,19 +322,6 @@ static struct macsec_rx_sa *macsec_rxsa_get(struct macsec_rx_sa __rcu *ptr)
 	return sa;
 }
 
-static struct macsec_rx_sa *macsec_active_rxsa_get(struct macsec_rx_sc *rx_sc)
-{
-	struct macsec_rx_sa *sa = NULL;
-	int an;
-
-	for (an = 0; an < MACSEC_NUM_AN; an++)	{
-		sa = macsec_rxsa_get(rx_sc->sa[an]);
-		if (sa)
-			break;
-	}
-	return sa;
-}
-
 static void free_rx_sc_rcu(struct rcu_head *head)
 {
 	struct macsec_rx_sc *rx_sc = container_of(head, struct macsec_rx_sc, rcu_head);
@@ -1206,15 +1193,12 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		/* If validateFrames is Strict or the C bit in the
 		 * SecTAG is set, discard
 		 */
-		struct macsec_rx_sa *active_rx_sa = macsec_active_rxsa_get(rx_sc);
 		if (hdr->tci_an & MACSEC_TCI_C ||
 		    secy->validate_frames == MACSEC_VALIDATE_STRICT) {
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsNotUsingSA++;
 			u64_stats_update_end(&rxsc_stats->syncp);
 			DEV_STATS_INC(secy->netdev, rx_errors);
-			if (active_rx_sa)
-				this_cpu_inc(active_rx_sa->stats->InPktsNotUsingSA);
 			goto drop_nosa;
 		}
 
@@ -1224,8 +1208,6 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		rxsc_stats->stats.InPktsUnusedSA++;
 		u64_stats_update_end(&rxsc_stats->syncp);
-		if (active_rx_sa)
-			this_cpu_inc(active_rx_sa->stats->InPktsUnusedSA);
 		goto deliver;
 	}
 
diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index fbf9ad429593..697b07fdf3ec 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -241,16 +241,6 @@ static int vsc739x_config_init(struct phy_device *phydev)
 	return genphy_config_init(phydev);
 }
 
-static int vsc73xx_config_aneg(struct phy_device *phydev)
-{
-	/* The VSC73xx switches does not like to be instructed to
-	 * do autonegotiation in any way, it prefers that you just go
-	 * with the power-on/reset defaults. Writing some registers will
-	 * just make autonegotiation permanently fail.
-	 */
-	return 0;
-}
-
 /* This adds a skew for both TX and RX clocks, so the skew should only be
  * applied to "rgmii-id" interfaces. It may not work as expected
  * on "rgmii-txid", "rgmii-rxid" or "rgmii" interfaces. */
@@ -459,7 +449,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	.features       = PHY_GBIT_FEATURES,
 	.config_init    = vsc738x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -468,7 +457,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	.features       = PHY_GBIT_FEATURES,
 	.config_init    = vsc738x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -477,7 +465,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	.features       = PHY_GBIT_FEATURES,
 	.config_init    = vsc739x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -486,7 +473,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	.features       = PHY_GBIT_FEATURES,
 	.config_init    = vsc739x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index fb1e28a29892..14e8ad3f9354 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -555,7 +555,7 @@ ppp_async_encode(struct asyncppp *ap)
 	 * and 7 (code-reject) must be sent as though no options
 	 * had been negotiated.
 	 */
-	islcp = proto == PPP_LCP && 1 <= data[2] && data[2] <= 7;
+	islcp = proto == PPP_LCP && count >= 3 && 1 <= data[2] && data[2] <= 7;
 
 	if (i == 0) {
 		if (islcp)
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 65dac36d8d4f..64d83f7905d0 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1708,10 +1708,10 @@ int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 {
 	struct sk_buff *skb;
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
-	int len;
+	unsigned int len;
 	int nframes;
 	int x;
-	int offset;
+	unsigned int offset;
 	union {
 		struct usb_cdc_ncm_ndp16 *ndp16;
 		struct usb_cdc_ncm_ndp32 *ndp32;
@@ -1783,8 +1783,8 @@ int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 			break;
 		}
 
-		/* sanity checking */
-		if (((offset + len) > skb_in->len) ||
+		/* sanity checking - watch out for integer wrap*/
+		if ((offset > skb_in->len) || (len > skb_in->len - offset) ||
 				(len > ctx->rx_max) || (len < ETH_HLEN)) {
 			netif_dbg(dev, rx_err, dev->net,
 				  "invalid frame detected (ignored) offset[%u]=%u, length=%u, skb=%p\n",
diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 0a86ba028c4d..6a3a4504767f 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -307,13 +307,14 @@ static int ipheth_carrier_set(struct ipheth_device *dev)
 			0x02, /* index */
 			dev->ctrl_buf, IPHETH_CTRL_BUF_SIZE,
 			IPHETH_CTRL_TIMEOUT);
-	if (retval < 0) {
+	if (retval <= 0) {
 		dev_err(&dev->intf->dev, "%s: usb_control_msg: %d\n",
 			__func__, retval);
 		return retval;
 	}
 
-	if (dev->ctrl_buf[0] == IPHETH_CARRIER_ON) {
+	if ((retval == 1 && dev->ctrl_buf[0] == IPHETH_CARRIER_ON) ||
+	    (retval >= 2 && dev->ctrl_buf[1] == IPHETH_CARRIER_ON)) {
 		netif_carrier_on(dev->net);
 		if (dev->tx_urb->status != -EINPROGRESS)
 			netif_wake_queue(dev->net);
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 9c17332c19fd..2f9daf077e8a 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3007,11 +3007,23 @@ static void r8152b_hw_phy_cfg(struct r8152 *tp)
 	set_bit(PHY_RESET, &tp->flags);
 }
 
-static void r8152b_exit_oob(struct r8152 *tp)
+static void wait_oob_link_list_ready(struct r8152 *tp)
 {
 	u32 ocp_data;
 	int i;
 
+	for (i = 0; i < 1000; i++) {
+		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
+		if (ocp_data & LINK_LIST_READY)
+			break;
+		usleep_range(1000, 2000);
+	}
+}
+
+static void r8152b_exit_oob(struct r8152 *tp)
+{
+	u32 ocp_data;
+
 	ocp_data = ocp_read_dword(tp, MCU_TYPE_PLA, PLA_RCR);
 	ocp_data &= ~RCR_ACPT_ALL;
 	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
@@ -3029,23 +3041,13 @@ static void r8152b_exit_oob(struct r8152 *tp)
 	ocp_data &= ~MCU_BORW_EN;
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
 
-	for (i = 0; i < 1000; i++) {
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-		if (ocp_data & LINK_LIST_READY)
-			break;
-		usleep_range(1000, 2000);
-	}
+	wait_oob_link_list_ready(tp);
 
 	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
 	ocp_data |= RE_INIT_LL;
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
 
-	for (i = 0; i < 1000; i++) {
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-		if (ocp_data & LINK_LIST_READY)
-			break;
-		usleep_range(1000, 2000);
-	}
+	wait_oob_link_list_ready(tp);
 
 	rtl8152_nic_reset(tp);
 
@@ -3087,7 +3089,6 @@ static void r8152b_exit_oob(struct r8152 *tp)
 static void r8152b_enter_oob(struct r8152 *tp)
 {
 	u32 ocp_data;
-	int i;
 
 	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
 	ocp_data &= ~NOW_IS_OOB;
@@ -3099,23 +3100,13 @@ static void r8152b_enter_oob(struct r8152 *tp)
 
 	rtl_disable(tp);
 
-	for (i = 0; i < 1000; i++) {
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-		if (ocp_data & LINK_LIST_READY)
-			break;
-		usleep_range(1000, 2000);
-	}
+	wait_oob_link_list_ready(tp);
 
 	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
 	ocp_data |= RE_INIT_LL;
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
 
-	for (i = 0; i < 1000; i++) {
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-		if (ocp_data & LINK_LIST_READY)
-			break;
-		usleep_range(1000, 2000);
-	}
+	wait_oob_link_list_ready(tp);
 
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, RTL8152_RMS);
 
@@ -3388,7 +3379,6 @@ static void r8153b_hw_phy_cfg(struct r8152 *tp)
 static void r8153_first_init(struct r8152 *tp)
 {
 	u32 ocp_data;
-	int i;
 
 	rxdy_gated_en(tp, true);
 	r8153_teredo_off(tp);
@@ -3408,23 +3398,13 @@ static void r8153_first_init(struct r8152 *tp)
 	ocp_data &= ~MCU_BORW_EN;
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
 
-	for (i = 0; i < 1000; i++) {
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-		if (ocp_data & LINK_LIST_READY)
-			break;
-		usleep_range(1000, 2000);
-	}
+	wait_oob_link_list_ready(tp);
 
 	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
 	ocp_data |= RE_INIT_LL;
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
 
-	for (i = 0; i < 1000; i++) {
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-		if (ocp_data & LINK_LIST_READY)
-			break;
-		usleep_range(1000, 2000);
-	}
+	wait_oob_link_list_ready(tp);
 
 	rtl_rx_vlan_en(tp, tp->netdev->features & NETIF_F_HW_VLAN_CTAG_RX);
 
@@ -3449,7 +3429,6 @@ static void r8153_first_init(struct r8152 *tp)
 static void r8153_enter_oob(struct r8152 *tp)
 {
 	u32 ocp_data;
-	int i;
 
 	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
 	ocp_data &= ~NOW_IS_OOB;
@@ -3458,23 +3437,13 @@ static void r8153_enter_oob(struct r8152 *tp)
 	rtl_disable(tp);
 	rtl_reset_bmu(tp);
 
-	for (i = 0; i < 1000; i++) {
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-		if (ocp_data & LINK_LIST_READY)
-			break;
-		usleep_range(1000, 2000);
-	}
+	wait_oob_link_list_ready(tp);
 
 	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7);
 	ocp_data |= RE_INIT_LL;
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, ocp_data);
 
-	for (i = 0; i < 1000; i++) {
-		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
-		if (ocp_data & LINK_LIST_READY)
-			break;
-		usleep_range(1000, 2000);
-	}
+	wait_oob_link_list_ready(tp);
 
 	ocp_data = tp->netdev->mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, ocp_data);
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 938335f4738d..ec3a7cea8c8a 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1746,7 +1746,8 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		// can rename the link if it knows better.
 		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
 		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
-		     (net->dev_addr [0] & 0x02) == 0))
+		     /* somebody touched it*/
+		     !is_zero_ether_addr(net->dev_addr)))
 			strscpy(net->name, "eth%d", sizeof(net->name));
 		/* WLAN devices should always be named "wlan%d" */
 		if ((dev->driver_info->flags & FLAG_WLAN) != 0)
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index c9df78950ff4..1d3031bd44fe 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -2655,9 +2655,14 @@ ath10k_wmi_tlv_op_cleanup_mgmt_tx_send(struct ath10k *ar,
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
index 967a39304648..e21b5c501575 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -2362,6 +2362,7 @@ static int wmi_process_mgmt_tx_comp(struct ath10k *ar, u32 desc_id,
 	dma_unmap_single(ar->dev, pkt_addr->paddr,
 			 msdu->len, DMA_TO_DEVICE);
 	info = IEEE80211_SKB_CB(msdu);
+	kfree(pkt_addr);
 
 	if (status)
 		info->flags &= ~IEEE80211_TX_STAT_ACK;
@@ -9233,6 +9234,7 @@ static int ath10k_wmi_mgmt_tx_clean_up_pending(int msdu_id, void *ptr,
 	dma_unmap_single(ar->dev, pkt_addr->paddr,
 			 msdu->len, DMA_TO_DEVICE);
 	ieee80211_free_txskb(ar->hw, msdu);
+	kfree(pkt_addr);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index e0a4e3fa8730..c89f89f553e6 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -1329,11 +1329,11 @@ void ath9k_get_et_stats(struct ieee80211_hw *hw,
 	struct ath_softc *sc = hw->priv;
 	int i = 0;
 
-	data[i++] = (sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_pkts_all +
+	data[i++] = ((u64)sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_pkts_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BK)].tx_pkts_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VI)].tx_pkts_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VO)].tx_pkts_all);
-	data[i++] = (sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_bytes_all +
+	data[i++] = ((u64)sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_bytes_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BK)].tx_bytes_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VI)].tx_bytes_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VO)].tx_bytes_all);
@@ -1384,8 +1384,6 @@ int ath9k_init_debug(struct ath_hw *ah)
 
 	sc->debug.debugfs_phy = debugfs_create_dir("ath9k",
 						   sc->hw->wiphy->debugfsdir);
-	if (!sc->debug.debugfs_phy)
-		return -ENOMEM;
 
 #ifdef CONFIG_ATH_DEBUG
 	debugfs_create_file("debug", 0600, sc->debug.debugfs_phy,
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 3aa915d21554..24059a5178a9 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -718,8 +718,7 @@ static void ath9k_hif_usb_rx_cb(struct urb *urb)
 	}
 
 resubmit:
-	skb_reset_tail_pointer(skb);
-	skb_trim(skb, 0);
+	__skb_set_length(skb, 0);
 
 	usb_anchor_urb(urb, &hif_dev->rx_submitted);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
@@ -756,8 +755,7 @@ static void ath9k_hif_usb_reg_in_cb(struct urb *urb)
 	case -ESHUTDOWN:
 		goto free_skb;
 	default:
-		skb_reset_tail_pointer(skb);
-		skb_trim(skb, 0);
+		__skb_set_length(skb, 0);
 
 		goto resubmit;
 	}
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index e79bbcd3279a..81332086e289 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -491,8 +491,6 @@ int ath9k_htc_init_debug(struct ath_hw *ah)
 
 	priv->debug.debugfs_phy = debugfs_create_dir(KBUILD_MODNAME,
 					     priv->hw->wiphy->debugfsdir);
-	if (IS_ERR(priv->debug.debugfs_phy))
-		return -ENOMEM;
 
 	ath9k_cmn_spectral_init_debug(&priv->spec_priv, priv->debug.debugfs_phy);
 
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index c1c1cf330de7..de3988deb4d0 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -4986,6 +4986,8 @@ il_pci_resume(struct device *device)
 	 */
 	pci_write_config_byte(pdev, PCI_CFG_RETRY_TIMEOUT, 0x00);
 
+	_il_wr(il, CSR_INT, 0xffffffff);
+	_il_wr(il, CSR_FH_INT_STATUS, 0xffffffff);
 	il_enable_interrupts(il);
 
 	if (!(_il_rd(il, CSR_GP_CNTRL) & CSR_GP_CNTRL_REG_FLAG_HW_RF_KILL_SW))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 3f37fb64e71c..3c00a737c4b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4326,6 +4326,10 @@ static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
 	int i;
 
 	if (!iwl_mvm_has_new_tx_api(mvm)) {
+		/* we can't ask the firmware anything if it is dead */
+		if (test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+			     &mvm->status))
+			return;
 		if (drop) {
 			mutex_lock(&mvm->mutex);
 			iwl_mvm_flush_tx_path(mvm,
@@ -4407,8 +4411,11 @@ static void iwl_mvm_mac_flush(struct ieee80211_hw *hw,
 
 	/* this can take a while, and we may need/want other operations
 	 * to succeed while doing this, so do it without the mutex held
+	 * If the firmware is dead, this can't work...
 	 */
-	if (!drop && !iwl_mvm_has_new_tx_api(mvm))
+	if (!drop && !iwl_mvm_has_new_tx_api(mvm) &&
+	    !test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+		      &mvm->status))
 		iwl_trans_wait_tx_queues_empty(mvm->trans, msk);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index eb2d235e9dc5..7f9eeef17f23 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -91,6 +91,8 @@
 /* adaptive dwell default APs number in social channels (1, 6, 11) */
 #define IWL_SCAN_ADWELL_DEFAULT_N_APS_SOCIAL 10
 
+#define WFA_TPC_IE_LEN	9
+
 struct iwl_mvm_scan_timing_params {
 	u32 suspend_time;
 	u32 max_out_time;
@@ -328,8 +330,8 @@ static int iwl_mvm_max_scan_ie_fw_cmd_room(struct iwl_mvm *mvm)
 
 	max_probe_len = SCAN_OFFLOAD_PROBE_REQ_SIZE;
 
-	/* we create the 802.11 header and SSID element */
-	max_probe_len -= 24 + 2;
+	/* we create the 802.11 header SSID element and WFA TPC element */
+	max_probe_len -= 24 + 2 + WFA_TPC_IE_LEN;
 
 	/* DS parameter set element is added on 2.4GHZ band if required */
 	if (iwl_mvm_rrm_scan_needed(mvm))
@@ -727,8 +729,6 @@ static u8 *iwl_mvm_copy_and_insert_ds_elem(struct iwl_mvm *mvm, const u8 *ies,
 	return newpos;
 }
 
-#define WFA_TPC_IE_LEN	9
-
 static void iwl_mvm_add_tpc_report_ie(u8 *pos)
 {
 	pos[0] = WLAN_EID_VENDOR_SPECIFIC;
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 3e3134bcc2b0..bfa482cf464f 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -1590,7 +1590,7 @@ struct host_cmd_ds_802_11_scan_rsp {
 
 struct host_cmd_ds_802_11_scan_ext {
 	u32   reserved;
-	u8    tlv_buffer[1];
+	u8    tlv_buffer[];
 } __packed;
 
 struct mwifiex_ie_types_bss_mode {
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 4f0e78ae3dbd..0cbdd5a930d8 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2570,8 +2570,7 @@ int mwifiex_ret_802_11_scan_ext(struct mwifiex_private *priv,
 	ext_scan_resp = &resp->params.ext_scan;
 
 	tlv = (void *)ext_scan_resp->tlv_buffer;
-	buf_left = le16_to_cpu(resp->size) - (sizeof(*ext_scan_resp) + S_DS_GEN
-					      - 1);
+	buf_left = le16_to_cpu(resp->size) - (sizeof(*ext_scan_resp) + S_DS_GEN);
 
 	while (buf_left >= sizeof(struct mwifiex_ie_types_header)) {
 		type = le16_to_cpu(tlv->type);
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 084bd1d1ac1d..0e913fd6b592 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -777,7 +777,7 @@ static void ndev_init_debugfs(struct intel_ntb_dev *ndev)
 		ndev->debugfs_dir =
 			debugfs_create_dir(pci_name(ndev->ntb.pdev),
 					   debugfs_dir);
-		if (!ndev->debugfs_dir)
+		if (IS_ERR(ndev->debugfs_dir))
 			ndev->debugfs_info = NULL;
 		else
 			ndev->debugfs_info =
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index f06c9df60e34..09079dce58f6 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -302,8 +302,8 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 	addr = of_get_property(device, "reg", &addr_len);
 
 	/* Prevent out-of-bounds read in case of longer interrupt parent address size */
-	if (addr_len > (3 * sizeof(__be32)))
-		addr_len = 3 * sizeof(__be32);
+	if (addr_len > sizeof(addr_buf))
+		addr_len = sizeof(addr_buf);
 	if (addr)
 		memcpy(addr_buf, addr, addr_len);
 
@@ -641,8 +641,7 @@ struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 rid)
  * @np: device node for @dev
  * @token: bus type for this domain
  *
- * Parse the msi-parent property (both the simple and the complex
- * versions), and returns the corresponding MSI domain.
+ * Parse the msi-parent property and returns the corresponding MSI domain.
  *
  * Returns: the MSI domain for this device (or NULL on failure).
  */
@@ -650,33 +649,14 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
 				     struct device_node *np,
 				     enum irq_domain_bus_token token)
 {
-	struct device_node *msi_np;
+	struct of_phandle_iterator it;
 	struct irq_domain *d;
+	int err;
 
-	/* Check for a single msi-parent property */
-	msi_np = of_parse_phandle(np, "msi-parent", 0);
-	if (msi_np && !of_property_read_bool(msi_np, "#msi-cells")) {
-		d = irq_find_matching_host(msi_np, token);
-		if (!d)
-			of_node_put(msi_np);
-		return d;
-	}
-
-	if (token == DOMAIN_BUS_PLATFORM_MSI) {
-		/* Check for the complex msi-parent version */
-		struct of_phandle_args args;
-		int index = 0;
-
-		while (!of_parse_phandle_with_args(np, "msi-parent",
-						   "#msi-cells",
-						   index, &args)) {
-			d = irq_find_matching_host(args.np, token);
-			if (d)
-				return d;
-
-			of_node_put(args.np);
-			index++;
-		}
+	of_for_each_phandle(&it, err, np, "msi-parent", "#msi-cells", 0) {
+		d = irq_find_matching_host(it.node, token);
+		if (d)
+			return d;
 	}
 
 	return NULL;
diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 595e23e6859b..c193d657f0ab 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -51,12 +51,12 @@ static int do_active_device(struct ctl_table *table, int write,
 	
 	for (dev = port->devices; dev ; dev = dev->next) {
 		if(dev == port->cad) {
-			len += snprintf(buffer, sizeof(buffer), "%s\n", dev->name);
+			len += scnprintf(buffer, sizeof(buffer), "%s\n", dev->name);
 		}
 	}
 
 	if(!len) {
-		len += snprintf(buffer, sizeof(buffer), "%s\n", "none");
+		len += scnprintf(buffer, sizeof(buffer), "%s\n", "none");
 	}
 
 	if (len > *lenp)
@@ -87,19 +87,19 @@ static int do_autoprobe(struct ctl_table *table, int write,
 	}
 	
 	if ((str = info->class_name) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "CLASS:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "CLASS:%s;\n", str);
 
 	if ((str = info->model) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "MODEL:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "MODEL:%s;\n", str);
 
 	if ((str = info->mfr) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "MANUFACTURER:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "MANUFACTURER:%s;\n", str);
 
 	if ((str = info->description) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "DESCRIPTION:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "DESCRIPTION:%s;\n", str);
 
 	if ((str = info->cmdset) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "COMMAND SET:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "COMMAND SET:%s;\n", str);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -128,7 +128,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += snprintf (buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
+	len += scnprintf (buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -156,7 +156,7 @@ static int do_hardware_irq(struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += snprintf (buffer, sizeof(buffer), "%d\n", port->irq);
+	len += scnprintf (buffer, sizeof(buffer), "%d\n", port->irq);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -184,7 +184,7 @@ static int do_hardware_dma(struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += snprintf (buffer, sizeof(buffer), "%d\n", port->dma);
+	len += scnprintf (buffer, sizeof(buffer), "%d\n", port->dma);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -216,7 +216,7 @@ static int do_hardware_modes(struct ctl_table *table, int write,
 #define printmode(x)							\
 do {									\
 	if (port->modes & PARPORT_MODE_##x)				\
-		len += snprintf(buffer + len, sizeof(buffer) - len, "%s%s", f++ ? "," : "", #x); \
+		len += scnprintf(buffer + len, sizeof(buffer) - len, "%s%s", f++ ? "," : "", #x); \
 } while (0)
 		int f = 0;
 		printmode(PCSPP);
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index a86bd9660dae..9fde526045ec 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -79,8 +79,8 @@
 #define MSGF_MISC_SR_NON_FATAL_DEV	BIT(22)
 #define MSGF_MISC_SR_FATAL_DEV		BIT(23)
 #define MSGF_MISC_SR_LINK_DOWN		BIT(24)
-#define MSGF_MSIC_SR_LINK_AUTO_BWIDTH	BIT(25)
-#define MSGF_MSIC_SR_LINK_BWIDTH	BIT(26)
+#define MSGF_MISC_SR_LINK_AUTO_BWIDTH	BIT(25)
+#define MSGF_MISC_SR_LINK_BWIDTH	BIT(26)
 
 #define MSGF_MISC_SR_MASKALL		(MSGF_MISC_SR_RXMSG_AVAIL | \
 					MSGF_MISC_SR_RXMSG_OVER | \
@@ -95,8 +95,8 @@
 					MSGF_MISC_SR_NON_FATAL_DEV | \
 					MSGF_MISC_SR_FATAL_DEV | \
 					MSGF_MISC_SR_LINK_DOWN | \
-					MSGF_MSIC_SR_LINK_AUTO_BWIDTH | \
-					MSGF_MSIC_SR_LINK_BWIDTH)
+					MSGF_MISC_SR_LINK_AUTO_BWIDTH | \
+					MSGF_MISC_SR_LINK_BWIDTH)
 
 /* Legacy interrupt status mask bits */
 #define MSGF_LEG_SR_INTA		BIT(0)
@@ -308,10 +308,10 @@ static irqreturn_t nwl_pcie_misc_handler(int irq, void *data)
 	if (misc_stat & MSGF_MISC_SR_FATAL_DEV)
 		dev_err(dev, "Fatal Error Detected\n");
 
-	if (misc_stat & MSGF_MSIC_SR_LINK_AUTO_BWIDTH)
+	if (misc_stat & MSGF_MISC_SR_LINK_AUTO_BWIDTH)
 		dev_info(dev, "Link Autonomous Bandwidth Management Status bit set\n");
 
-	if (misc_stat & MSGF_MSIC_SR_LINK_BWIDTH)
+	if (misc_stat & MSGF_MISC_SR_LINK_BWIDTH)
 		dev_info(dev, "Link Bandwidth Management Status bit set\n");
 
 	/* Clear misc interrupt status */
@@ -384,14 +384,12 @@ static void nwl_pcie_msi_handler_low(struct irq_desc *desc)
 
 static void nwl_mask_leg_irq(struct irq_data *data)
 {
-	struct irq_desc *desc = irq_to_desc(data->irq);
-	struct nwl_pcie *pcie;
+	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
 	unsigned long flags;
 	u32 mask;
 	u32 val;
 
-	pcie = irq_desc_get_chip_data(desc);
-	mask = 1 << (data->hwirq - 1);
+	mask = 1 << data->hwirq;
 	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
 	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
 	nwl_bridge_writel(pcie, (val & (~mask)), MSGF_LEG_MASK);
@@ -400,14 +398,12 @@ static void nwl_mask_leg_irq(struct irq_data *data)
 
 static void nwl_unmask_leg_irq(struct irq_data *data)
 {
-	struct irq_desc *desc = irq_to_desc(data->irq);
-	struct nwl_pcie *pcie;
+	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
 	unsigned long flags;
 	u32 mask;
 	u32 val;
 
-	pcie = irq_desc_get_chip_data(desc);
-	mask = 1 << (data->hwirq - 1);
+	mask = 1 << data->hwirq;
 	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
 	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
 	nwl_bridge_writel(pcie, (val | mask), MSGF_LEG_MASK);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index bb5182089096..c009b1760f47 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3347,6 +3347,8 @@ DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
 			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004, /* Ceton InfiniTV4 */
 			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_20K2,
+			quirk_broken_intx_masking);
 
 /*
  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
@@ -4042,6 +4044,10 @@ static void quirk_dma_func0_alias(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe832, quirk_dma_func0_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
 
+/* Some Glenfly chips use function 0 as the PCIe Requester ID for DMA */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, 0x3d40, quirk_dma_func0_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, 0x3d41, quirk_dma_func0_alias);
+
 static void quirk_dma_func1_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 1)
diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index 8472f61f2bbe..c15f08fab0bb 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -773,7 +773,7 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 		of_match_device(dove_pinctrl_of_match, &pdev->dev);
 	struct mvebu_mpp_ctrl_data *mpp_data;
 	void __iomem *base;
-	int i;
+	int i, ret;
 
 	pdev->dev.platform_data = (void *)match->data;
 
@@ -790,13 +790,17 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 
 	mpp_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, mpp_res);
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
@@ -815,8 +819,10 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
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
@@ -827,8 +833,10 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
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
@@ -838,12 +846,17 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
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
@@ -851,6 +864,9 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, FW_BUG "Missing pinctrl regs in DTB. Please update your firmware.\n");
 
 	return mvebu_pinctrl_probe(pdev);
+err_probe:
+	clk_disable_unprepare(clk);
+	return ret;
 }
 
 static struct platform_driver dove_pinctrl_driver = {
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index ad01cc579823..48374945b2d7 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1290,8 +1290,11 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 
 	/* We will handle a range of GPIO pins */
 	for (i = 0; i < gpio_banks; i++)
-		if (gpio_chips[i])
+		if (gpio_chips[i]) {
 			pinctrl_add_gpio_range(info->pctl, &gpio_chips[i]->range);
+			gpiochip_add_pin_range(&gpio_chips[i]->chip, dev_name(info->pctl->dev), 0,
+				gpio_chips[i]->range.pin_base, gpio_chips[i]->range.npins);
+		}
 
 	dev_info(&pdev->dev, "initialized AT91 pinctrl driver\n");
 
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 86691841efc0..004410e58e54 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1898,7 +1898,8 @@ static int pcs_probe(struct platform_device *pdev)
 
 	dev_info(pcs->dev, "%i pins, size %u\n", pcs->desc.npins, pcs->size);
 
-	if (pinctrl_enable(pcs->pctl))
+	ret = pinctrl_enable(pcs->pctl);
+	if (ret)
 		goto free;
 
 	return 0;
diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
index 884b53c483c0..9f8b9e5cad93 100644
--- a/drivers/power/reset/brcmstb-reboot.c
+++ b/drivers/power/reset/brcmstb-reboot.c
@@ -72,9 +72,6 @@ static int brcmstb_restart_handler(struct notifier_block *this,
 		return NOTIFY_DONE;
 	}
 
-	while (1)
-		;
-
 	return NOTIFY_DONE;
 }
 
diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 33fbb0fc952b..6d3ad453e609 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -848,7 +848,10 @@ static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 off)
 	/* program interrupt thesholds such that we should
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
diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index 4db824f88d00..9710207bce7c 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -158,7 +158,10 @@ static void parport_attach(struct parport *port)
 		return;
 	}
 
-	index = ida_simple_get(&pps_client_index, 0, 0, GFP_KERNEL);
+	index = ida_alloc(&pps_client_index, GFP_KERNEL);
+	if (index < 0)
+		goto err_free_device;
+
 	memset(&pps_client_cb, 0, sizeof(pps_client_cb));
 	pps_client_cb.private = device;
 	pps_client_cb.irq_func = parport_irq;
@@ -169,7 +172,7 @@ static void parport_attach(struct parport *port)
 						    index);
 	if (!device->pardev) {
 		pr_err("couldn't register with %s\n", port->name);
-		goto err_free;
+		goto err_free_ida;
 	}
 
 	if (parport_claim_or_block(device->pardev) < 0) {
@@ -197,8 +200,9 @@ static void parport_attach(struct parport *port)
 	parport_release(device->pardev);
 err_unregister_dev:
 	parport_unregister_device(device->pardev);
-err_free:
-	ida_simple_remove(&pps_client_index, index);
+err_free_ida:
+	ida_free(&pps_client_index, index);
+err_free_device:
 	kfree(device);
 }
 
@@ -218,7 +222,7 @@ static void parport_detach(struct parport *port)
 	pps_unregister_source(device->pps);
 	parport_release(pardev);
 	parport_unregister_device(pardev);
-	ida_simple_remove(&pps_client_index, device->index);
+	ida_free(&pps_client_index, device->index);
 	kfree(device);
 }
 
diff --git a/drivers/reset/reset-berlin.c b/drivers/reset/reset-berlin.c
index 371197bbd055..542d32719b8a 100644
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
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 199cc3945919..6dedba21683f 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1404,7 +1404,7 @@ config RTC_DRV_AT91RM9200
 config RTC_DRV_AT91SAM9
 	tristate "AT91SAM9 RTT as RTC"
 	depends on ARCH_AT91 || COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on OF && HAS_IOMEM
 	select MFD_SYSCON
 	help
 	  Some AT91SAM9 SoCs provide an RTT (Real Time Timer) block which
diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index ee71e647fd43..4672dde68c78 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -348,13 +348,6 @@ static const struct rtc_class_ops at91_rtc_ops = {
 	.alarm_irq_enable = at91_rtc_alarm_irq_enable,
 };
 
-static const struct regmap_config gpbr_regmap_config = {
-	.name = "gpbr",
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = 4,
-};
-
 /*
  * Initialize and install RTC driver
  */
@@ -365,6 +358,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
 	int		ret, irq;
 	u32		mr;
 	unsigned int	sclk_rate;
+	struct of_phandle_args args;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -390,34 +384,15 @@ static int at91_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->rtt))
 		return PTR_ERR(rtc->rtt);
 
-	if (!pdev->dev.of_node) {
-		/*
-		 * TODO: Remove this code chunk when removing non DT board
-		 * support. Remember to remove the gpbr_regmap_config
-		 * variable too.
-		 */
-		void __iomem *gpbr;
-
-		r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		gpbr = devm_ioremap_resource(&pdev->dev, r);
-		if (IS_ERR(gpbr))
-			return PTR_ERR(gpbr);
-
-		rtc->gpbr = regmap_init_mmio(NULL, gpbr,
-					     &gpbr_regmap_config);
-	} else {
-		struct of_phandle_args args;
-
-		ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
-						"atmel,rtt-rtc-time-reg", 1, 0,
-						&args);
-		if (ret)
-			return ret;
-
-		rtc->gpbr = syscon_node_to_regmap(args.np);
-		rtc->gpbr_offset = args.args[0];
-	}
+	ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
+					"atmel,rtt-rtc-time-reg", 1, 0,
+					&args);
+	if (ret)
+		return ret;
 
+	rtc->gpbr = syscon_node_to_regmap(args.np);
+	of_node_put(args.np);
+	rtc->gpbr_offset = args.args[0];
 	if (IS_ERR(rtc->gpbr)) {
 		dev_err(&pdev->dev, "failed to retrieve gpbr regmap, aborting.\n");
 		return -ENOMEM;
@@ -569,13 +544,11 @@ static int at91_rtc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(at91_rtc_pm_ops, at91_rtc_suspend, at91_rtc_resume);
 
-#ifdef CONFIG_OF
 static const struct of_device_id at91_rtc_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9260-rtt" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, at91_rtc_dt_ids);
-#endif
 
 static struct platform_driver at91_rtc_driver = {
 	.probe		= at91_rtc_probe,
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 3c2ed6d01387..d574c167c9dc 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -325,7 +325,7 @@ sclp_vt220_add_msg(struct sclp_vt220_request *request,
 	buffer = (void *) ((addr_t) sccb + sccb->header.length);
 
 	if (convertlf) {
-		/* Perform Linefeed conversion (0x0a -> 0x0a 0x0d)*/
+		/* Perform Linefeed conversion (0x0a -> 0x0d 0x0a)*/
 		for (from=0, to=0;
 		     (from < count) && (to < sclp_vt220_space_left(request));
 		     from++) {
@@ -334,8 +334,8 @@ sclp_vt220_add_msg(struct sclp_vt220_request *request,
 			/* Perform conversion */
 			if (c == 0x0a) {
 				if (to + 1 < sclp_vt220_space_left(request)) {
-					((unsigned char *) buffer)[to++] = c;
 					((unsigned char *) buffer)[to++] = 0x0d;
+					((unsigned char *) buffer)[to++] = c;
 				} else
 					break;
 
diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 074760f21014..135e3f39c895 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -2037,8 +2037,8 @@ struct aac_srb_reply
 };
 
 struct aac_srb_unit {
-	struct aac_srb		srb;
 	struct aac_srb_reply	srb_reply;
+	struct aac_srb		srb;
 };
 
 /*
diff --git a/drivers/soc/versatile/soc-integrator.c b/drivers/soc/versatile/soc-integrator.c
index a5d7d39ae0ad..5ffad35dfb19 100644
--- a/drivers/soc/versatile/soc-integrator.c
+++ b/drivers/soc/versatile/soc-integrator.c
@@ -115,6 +115,7 @@ static int __init integrator_soc_init(void)
 		return -ENODEV;
 
 	syscon_regmap = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (IS_ERR(syscon_regmap))
 		return PTR_ERR(syscon_regmap);
 
diff --git a/drivers/soc/versatile/soc-realview.c b/drivers/soc/versatile/soc-realview.c
index caf698e5f0b0..a9220701c190 100644
--- a/drivers/soc/versatile/soc-realview.c
+++ b/drivers/soc/versatile/soc-realview.c
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  *
  */
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -83,6 +84,13 @@ static ssize_t realview_get_build(struct device *dev,
 static struct device_attribute realview_build_attr =
 	__ATTR(build,  S_IRUGO, realview_get_build,  NULL);
 
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
@@ -95,7 +103,7 @@ static int realview_soc_probe(struct platform_device *pdev)
 	if (IS_ERR(syscon_regmap))
 		return PTR_ERR(syscon_regmap);
 
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
@@ -107,10 +115,14 @@ static int realview_soc_probe(struct platform_device *pdev)
 	soc_dev_attr->machine = "RealView";
 	soc_dev_attr->family = "Versatile";
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
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 7c08385acab1..42bc701e2304 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1232,18 +1232,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 				unsigned int port_num)
 {
 	struct sdw_dpn_prop *dpn_prop;
-	unsigned long mask;
+	u8 num_ports;
 	int i;
 
 	if (direction == SDW_DATA_DIR_TX) {
-		mask = slave->prop.source_ports;
+		num_ports = hweight32(slave->prop.source_ports);
 		dpn_prop = slave->prop.src_dpn_prop;
 	} else {
-		mask = slave->prop.sink_ports;
+		num_ports = hweight32(slave->prop.sink_ports);
 		dpn_prop = slave->prop.sink_dpn_prop;
 	}
 
-	for_each_set_bit(i, &mask, 32) {
+	for (i = 0; i < num_ports; i++) {
 		if (dpn_prop[i].num == port_num)
 			return &dpn_prop[i];
 	}
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index cc6ec3fb5bfd..0c5fd0fe2a2a 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -484,12 +484,14 @@ static const struct platform_device_id bcm63xx_spi_dev_match[] = {
 	{
 	},
 };
+MODULE_DEVICE_TABLE(platform, bcm63xx_spi_dev_match);
 
 static const struct of_device_id bcm63xx_spi_of_match[] = {
 	{ .compatible = "brcm,bcm6348-spi", .data = &bcm6348_spi_reg_offsets },
 	{ .compatible = "brcm,bcm6358-spi", .data = &bcm6358_spi_reg_offsets },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, bcm63xx_spi_of_match);
 
 static int bcm63xx_spi_probe(struct platform_device *pdev)
 {
diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 58765a62fc15..7e8fc572f26c 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -29,7 +29,6 @@
 #include <linux/errno.h>
 #include <linux/wait.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 #include <linux/interrupt.h>
@@ -494,7 +493,11 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
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
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index d9420561236c..108a087a2777 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -211,7 +211,7 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 	loops = msecs_to_loops(1);
 	do {
 		val = readl(regs + S3C64XX_SPI_STATUS);
-	} while (TX_FIFO_LVL(val, sdd) && loops--);
+	} while (TX_FIFO_LVL(val, sdd) && --loops);
 
 	if (loops == 0)
 		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO\n");
@@ -224,7 +224,7 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 			readl(regs + S3C64XX_SPI_RX_DATA);
 		else
 			break;
-	} while (loops--);
+	} while (--loops);
 
 	if (loops == 0)
 		dev_warn(&sdd->pdev->dev, "Timed out flushing RX FIFO\n");
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 4c6d4043903e..3eb089dc220e 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -6,6 +6,7 @@
  * Licensed under the GPL-2.
  */
 
+#include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
@@ -71,7 +72,7 @@
 struct ad9834_state {
 	struct spi_device		*spi;
 	struct regulator		*reg;
-	unsigned int			mclk;
+	struct clk			*mclk;
 	unsigned short			control;
 	unsigned short			devid;
 	struct spi_transfer		xfer;
@@ -110,12 +111,15 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 static int ad9834_write_frequency(struct ad9834_state *st,
 				  unsigned long addr, unsigned long fout)
 {
+	unsigned long clk_freq;
 	unsigned long regval;
 
-	if (fout > (st->mclk / 2))
+	clk_freq = clk_get_rate(st->mclk);
+
+	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
-	regval = ad9834_calc_freqreg(st->mclk, fout);
+	regval = ad9834_calc_freqreg(clk_freq, fout);
 
 	st->freq_data[0] = cpu_to_be16(addr | (regval &
 				       RES_MASK(AD9834_FREQ_BITS / 2)));
@@ -389,16 +393,11 @@ static const struct iio_info ad9833_info = {
 
 static int ad9834_probe(struct spi_device *spi)
 {
-	struct ad9834_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct ad9834_state *st;
 	struct iio_dev *indio_dev;
 	struct regulator *reg;
 	int ret;
 
-	if (!pdata) {
-		dev_dbg(&spi->dev, "no platform data?\n");
-		return -ENODEV;
-	}
 
 	reg = devm_regulator_get(&spi->dev, "avdd");
 	if (IS_ERR(reg))
@@ -418,7 +417,14 @@ static int ad9834_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
-	st->mclk = pdata->mclk;
+	st->mclk = devm_clk_get(&spi->dev, NULL);
+
+	ret = clk_prepare_enable(st->mclk);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable master clock\n");
+		goto error_disable_reg;
+	}
+
 	st->spi = spi;
 	st->devid = spi_get_device_id(spi)->driver_data;
 	st->reg = reg;
@@ -454,42 +460,41 @@ static int ad9834_probe(struct spi_device *spi)
 	spi_message_add_tail(&st->freq_xfer[1], &st->freq_msg);
 
 	st->control = AD9834_B28 | AD9834_RESET;
+	st->control |= AD9834_DIV2;
 
-	if (!pdata->en_div2)
-		st->control |= AD9834_DIV2;
-
-	if (!pdata->en_signbit_msb_out && (st->devid == ID_AD9834))
+	if (st->devid == ID_AD9834)
 		st->control |= AD9834_SIGN_PIB;
 
 	st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
 	ret = spi_sync(st->spi, &st->msg);
 	if (ret) {
 		dev_err(&spi->dev, "device init failed\n");
-		goto error_disable_reg;
+		goto error_clock_unprepare;
 	}
 
-	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, pdata->freq0);
+	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, 1000000);
 	if (ret)
-		goto error_disable_reg;
+		goto error_clock_unprepare;
 
-	ret = ad9834_write_frequency(st, AD9834_REG_FREQ1, pdata->freq1);
+	ret = ad9834_write_frequency(st, AD9834_REG_FREQ1, 5000000);
 	if (ret)
-		goto error_disable_reg;
+		goto error_clock_unprepare;
 
-	ret = ad9834_write_phase(st, AD9834_REG_PHASE0, pdata->phase0);
+	ret = ad9834_write_phase(st, AD9834_REG_PHASE0, 512);
 	if (ret)
-		goto error_disable_reg;
+		goto error_clock_unprepare;
 
-	ret = ad9834_write_phase(st, AD9834_REG_PHASE1, pdata->phase1);
+	ret = ad9834_write_phase(st, AD9834_REG_PHASE1, 1024);
 	if (ret)
-		goto error_disable_reg;
+		goto error_clock_unprepare;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_disable_reg;
+		goto error_clock_unprepare;
 
 	return 0;
-
+error_clock_unprepare:
+	clk_disable_unprepare(st->mclk);
 error_disable_reg:
 	regulator_disable(reg);
 
@@ -502,6 +507,7 @@ static int ad9834_remove(struct spi_device *spi)
 	struct ad9834_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
+	clk_disable_unprepare(st->mclk);
 	regulator_disable(st->reg);
 
 	return 0;
diff --git a/drivers/staging/iio/frequency/ad9834.h b/drivers/staging/iio/frequency/ad9834.h
index ae620f38eb49..da7e83ceedad 100644
--- a/drivers/staging/iio/frequency/ad9834.h
+++ b/drivers/staging/iio/frequency/ad9834.h
@@ -8,32 +8,4 @@
 #ifndef IIO_DDS_AD9834_H_
 #define IIO_DDS_AD9834_H_
 
-/*
- * TODO: struct ad7887_platform_data needs to go into include/linux/iio
- */
-
-/**
- * struct ad9834_platform_data - platform specific information
- * @mclk:		master clock in Hz
- * @freq0:		power up freq0 tuning word in Hz
- * @freq1:		power up freq1 tuning word in Hz
- * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
- * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
- * @en_div2:		digital output/2 is passed to the SIGN BIT OUT pin
- * @en_signbit_msb_out:	the MSB (or MSB/2) of the DAC data is connected to the
- *			SIGN BIT OUT pin. en_div2 controls whether it is the MSB
- *			or MSB/2 that is output. if en_signbit_msb_out=false,
- *			the on-board comparator is connected to SIGN BIT OUT
- */
-
-struct ad9834_platform_data {
-	unsigned int		mclk;
-	unsigned int		freq0;
-	unsigned int		freq1;
-	unsigned short		phase0;
-	unsigned short		phase1;
-	bool			en_div2;
-	bool			en_signbit_msb_out;
-};
-
 #endif /* IIO_DDS_AD9834_H_ */
diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 944a4c010579..a8d3fbde5b0e 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -600,8 +600,8 @@ static void rp2_reset_asic(struct rp2_card *card, unsigned int asic_id)
 	u32 clk_cfg;
 
 	writew(1, base + RP2_GLOBAL_CMD);
-	readw(base + RP2_GLOBAL_CMD);
 	msleep(100);
+	readw(base + RP2_GLOBAL_CMD);
 	writel(0, base + RP2_CLK_PRESCALER);
 
 	/* TDM clock configuration */
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index abcacd377e09..4c8c961d2320 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4450,7 +4450,7 @@ static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 	int c;
 
 	if (op->data) {
-		font.data = kmalloc(max_font_size, GFP_KERNEL);
+		font.data = kzalloc(max_font_size, GFP_KERNEL);
 		if (!font.data)
 			return -ENOMEM;
 	} else
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 3bda856ff2ca..6a626f41cded 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -81,7 +81,7 @@ static int hw_device_state(struct ci_hdrc *ci, u32 dma)
 		hw_write(ci, OP_ENDPTLISTADDR, ~0, dma);
 		/* interrupt, error, port change, reset, sleep/suspend */
 		hw_write(ci, OP_USBINTR, ~0,
-			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI|USBi_SLI);
+			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI);
 	} else {
 		hw_write(ci, OP_USBINTR, ~0, 0);
 	}
@@ -748,6 +748,7 @@ __releases(ci->lock)
 __acquires(ci->lock)
 {
 	int retval;
+	u32 intr;
 
 	spin_unlock(&ci->lock);
 	if (ci->gadget.speed != USB_SPEED_UNKNOWN)
@@ -761,6 +762,11 @@ __acquires(ci->lock)
 	if (retval)
 		goto done;
 
+	/* clear SLI */
+	hw_write(ci, OP_USBSTS, USBi_SLI, USBi_SLI);
+	intr = hw_read(ci, OP_USBINTR, ~0);
+	hw_write(ci, OP_USBINTR, ~0, intr | USBi_SLI);
+
 	ci->status = usb_ep_alloc_request(&ci->ep0in->ep, GFP_ATOMIC);
 	if (ci->status == NULL)
 		retval = -ENOMEM;
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4002c6790be6..c10306234bb1 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -116,6 +116,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 	struct dwc3 *dwc = work_to_dwc(work);
 	unsigned long flags;
 	int ret;
+	u32 reg;
 
 	if (dwc->dr_mode != USB_DR_MODE_OTG)
 		return;
@@ -167,7 +168,11 @@ static void __dwc3_set_mode(struct work_struct *work)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
 			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
 			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
-			phy_calibrate(dwc->usb2_generic_phy);
+			if (dwc->dis_split_quirk) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
+				reg |= DWC3_GUCTL3_SPLITDISABLE;
+				dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+			}
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -399,6 +404,7 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
 int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
+	u32				reg;
 
 	if (!dwc->ev_buf)
 		return 0;
@@ -411,8 +417,10 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 			upper_32_bits(evt->dma));
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
 			DWC3_GEVNTSIZ_SIZE(evt->length));
-	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
 
+	/* Clear any stale event */
+	reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
 	return 0;
 }
 
@@ -439,7 +447,10 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0), 0);
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), DWC3_GEVNTSIZ_INTMASK
 			| DWC3_GEVNTSIZ_SIZE(0));
-	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
+
+	/* Clear any stale event */
+	reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
 }
 
 static int dwc3_alloc_scratch_buffers(struct dwc3 *dwc)
@@ -1178,7 +1189,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 				dev_err(dev, "failed to initialize host\n");
 			return ret;
 		}
-		phy_calibrate(dwc->usb2_generic_phy);
 		break;
 	case USB_DR_MODE_OTG:
 		INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
@@ -1316,6 +1326,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_metastability_quirk = device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
 
+	dwc->dis_split_quirk = device_property_read_bool(dev,
+				"snps,dis-split-quirk");
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
@@ -1785,7 +1798,11 @@ static int dwc3_runtime_resume(struct device *dev)
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
-		dwc3_gadget_process_pending_events(dwc);
+		if (dwc->pending_events) {
+			pm_runtime_put(dwc->dev);
+			dwc->pending_events = false;
+			enable_irq(dwc->irq_gadget);
+		}
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
 	default:
@@ -1852,10 +1869,32 @@ static int dwc3_resume(struct device *dev)
 
 	return 0;
 }
+
+static void dwc3_complete(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	u32		reg;
+
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST &&
+			dwc->dis_split_quirk) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
+		reg |= DWC3_GUCTL3_SPLITDISABLE;
+		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+	}
+}
+#else
+#define dwc3_complete NULL
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops dwc3_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
+	.complete = dwc3_complete,
+
+	/*
+	 * Runtime suspend halts the controller on disconnection. It relies on
+	 * platforms with custom connection notification to start the controller
+	 * again.
+	 */
 	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
 			dwc3_runtime_idle)
 };
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a1d65e36a4d4..1115ed88f357 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -135,6 +135,7 @@
 #define DWC3_GEVNTCOUNT(n)	(0xc40c + ((n) * 0x10))
 
 #define DWC3_GHWPARAMS8		0xc600
+#define DWC3_GUCTL3		0xc60c
 #define DWC3_GFLADJ		0xc630
 
 /* Device Registers */
@@ -362,6 +363,9 @@
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
 
+/* Global User Control Register 3 */
+#define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
+
 /* Device Configuration Register */
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
@@ -1004,6 +1008,7 @@ struct dwc3_scratchpad_array {
  * 	2	- No de-emphasis
  * 	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
+ * @dis_split_quirk: set to disable split boundary.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *                 increments or 0 to disable.
  */
@@ -1175,6 +1180,8 @@ struct dwc3 {
 
 	unsigned		dis_metastability_quirk:1;
 
+	unsigned		dis_split_quirk:1;
+
 	u16			imod_interval;
 };
 
@@ -1423,7 +1430,6 @@ static inline void dwc3_otg_host_init(struct dwc3 *dwc)
 #if !IS_ENABLED(CONFIG_USB_DWC3_HOST)
 int dwc3_gadget_suspend(struct dwc3 *dwc);
 int dwc3_gadget_resume(struct dwc3 *dwc);
-void dwc3_gadget_process_pending_events(struct dwc3 *dwc);
 #else
 static inline int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
@@ -1435,9 +1441,6 @@ static inline int dwc3_gadget_resume(struct dwc3 *dwc)
 	return 0;
 }
 
-static inline void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
-{
-}
 #endif /* !IS_ENABLED(CONFIG_USB_DWC3_HOST) */
 
 #if IS_ENABLED(CONFIG_USB_DWC3_ULPI)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e617a28aca43..c6610c15e03e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3474,14 +3474,3 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 err0:
 	return ret;
 }
-
-void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
-{
-	if (dwc->pending_events) {
-		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
-		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
-		pm_runtime_put(dwc->dev);
-		dwc->pending_events = false;
-		enable_irq(dwc->irq_gadget);
-	}
-}
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 6e34f8086397..da3d0a40828c 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -55,6 +55,7 @@
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
 #define PCI_DEVICE_ID_ASMEDIA_1142_XHCI			0x1242
 #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
+#define PCI_DEVICE_ID_ASMEDIA_3042_XHCI			0x3042
 #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
 
 static const char hcd_name[] = "xhci_hcd";
@@ -272,6 +273,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI)
 		xhci->quirks |= XHCI_ASMEDIA_MODIFY_FLOWCONTROL;
 
+	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
+	    pdev->device == PCI_DEVICE_ID_ASMEDIA_3042_XHCI)
+		xhci->quirks |= XHCI_RESET_ON_RESUME;
+
 	if (pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241)
 		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_7;
 
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 6579c9af8858..7ce5642a8591 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1431,6 +1431,14 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 
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
@@ -1447,14 +1455,6 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 
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
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 32a5f2a62ad5..fb6551c5d805 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1273,7 +1273,7 @@ enum xhci_setup_dev {
 /* Set TR Dequeue Pointer command TRB fields, 6.4.3.9 */
 #define TRB_TO_STREAM_ID(p)		((((p) & (0xffff << 16)) >> 16))
 #define STREAM_ID_FOR_TRB(p)		((((p)) & 0xffff) << 16)
-#define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
+#define SCT_FOR_TRB(p)			(((p) & 0x7) << 1)
 
 /* Link TRB specific fields */
 #define TRB_TC			(1<<1)
diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledisplay.c
index 718d692b07ac..4b9bd99453fd 100644
--- a/drivers/usb/misc/appledisplay.c
+++ b/drivers/usb/misc/appledisplay.c
@@ -111,7 +111,12 @@ static void appledisplay_complete(struct urb *urb)
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
@@ -208,6 +213,7 @@ static int appledisplay_probe(struct usb_interface *iface,
 	const struct usb_device_id *id)
 {
 	struct backlight_properties props;
+	struct backlight_device *backlight;
 	struct appledisplay *pdata;
 	struct usb_device *udev = interface_to_usbdev(iface);
 	struct usb_endpoint_descriptor *endpoint;
@@ -278,13 +284,14 @@ static int appledisplay_probe(struct usb_interface *iface,
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
index 9d780b77314b..5a8b2873c29b 100644
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
index 08b72bb22b7e..de2cc882f576 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -508,8 +508,11 @@ static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
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
diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 0277f62739a2..1bb3c001cfd8 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -579,7 +579,7 @@ void devm_usb_put_phy(struct device *dev, struct usb_phy *phy)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_usb_phy_release, devm_usb_phy_match, phy);
+	r = devres_release(dev, devm_usb_phy_release, devm_usb_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_usb_put_phy);
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 0a284bf9f0dc..761054bdb733 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -279,6 +279,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EG912Y			0x6001
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
 #define QUECTEL_PRODUCT_EC200A			0x6005
+#define QUECTEL_PRODUCT_EG916Q			0x6007
 #define QUECTEL_PRODUCT_EM061K_LWW		0x6008
 #define QUECTEL_PRODUCT_EM061K_LCN		0x6009
 #define QUECTEL_PRODUCT_EC200T			0x6026
@@ -1270,6 +1271,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG912Y, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG916Q, 0xff, 0x00, 0x00) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
@@ -1380,10 +1382,16 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a0, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a2, 0xff),	/* Telit FN920C04 (MBIM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a4, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a7, 0xff),	/* Telit FN920C04 (MBIM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a9, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),	/* Telit FN920C04 (MBIM) */
+	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index 4bbccc30748a..96aca606cfea 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -112,6 +112,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(SMART_VENDOR_ID, SMART_PRODUCT_ID) },
 	{ USB_DEVICE(AT_VENDOR_ID, AT_VTKIT3_PRODUCT_ID) },
 	{ USB_DEVICE(IBM_VENDOR_ID, IBM_PRODUCT_ID) },
+	{ USB_DEVICE(MACROSILICON_VENDOR_ID, MACROSILICON_MS3020_PRODUCT_ID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index 873e50088a36..fcabe62cc851 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -165,3 +165,7 @@
 /* Allied Telesis VT-Kit3 */
 #define AT_VENDOR_ID		0x0caa
 #define AT_VTKIT3_PRODUCT_ID	0x3001
+
+/* Macrosilicon MS3020 */
+#define MACROSILICON_VENDOR_ID		0x345f
+#define MACROSILICON_MS3020_PRODUCT_ID	0x3020
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index b270be141b8e..606a68bd8059 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2412,6 +2412,17 @@ UNUSUAL_DEV(  0xc251, 0x4003, 0x0100, 0x0100,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NOT_LOCKABLE),
 
+/*
+ * Reported by Icenowy Zheng <uwu@icenowy.me>
+ * This is an interface for vendor-specific cryptic commands instead
+ * of real USB storage device.
+ */
+UNUSUAL_DEV(  0xe5b7, 0x0811, 0x0100, 0x0100,
+		"ZhuHai JieLi Technology",
+		"JieLi BR21",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_DEVICE),
+
 /* Reported by Andrew Simmons <andrew.simmons@gmail.com> */
 UNUSUAL_DEV(  0xed06, 0x4500, 0x0001, 0x0001,
 		"DataStor",
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index d396836244ff..ae6835a79239 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -465,6 +465,7 @@ static void typec_altmode_release(struct device *dev)
 		typec_altmode_put_partner(alt);
 
 	altmode_id_remove(alt->adev.dev.parent, alt->id);
+	put_device(alt->adev.dev.parent);
 	kfree(alt);
 }
 
@@ -514,6 +515,8 @@ typec_register_altmode(struct device *parent,
 	alt->adev.dev.type = &typec_altmode_dev_type;
 	dev_set_name(&alt->adev.dev, "%s.%u", dev_name(parent), id);
 
+	get_device(alt->adev.dev.parent);
+
 	/* Link partners and plugs with the ports */
 	if (is_port)
 		BLOCKING_INIT_NOTIFIER_HEAD(&alt->nh);
diff --git a/drivers/video/fbdev/hpfb.c b/drivers/video/fbdev/hpfb.c
index 9230db9ea94b..47ec02a38f76 100644
--- a/drivers/video/fbdev/hpfb.c
+++ b/drivers/video/fbdev/hpfb.c
@@ -343,6 +343,7 @@ static int hpfb_dio_probe(struct dio_dev *d, const struct dio_device_id *ent)
 	if (hpfb_init_one(paddr, vaddr)) {
 		if (d->scode >= DIOII_SCBASE)
 			iounmap((void *)vaddr);
+		release_mem_region(d->resource.start, resource_size(&d->resource));
 		return -ENOMEM;
 	}
 	return 0;
diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 90dee3e6f8bc..f76da5c6c6cd 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2437,6 +2437,7 @@ static int pxafb_remove(struct platform_device *dev)
 	info = &fbi->fb;
 
 	pxafb_overlay_exit(fbi);
+	cancel_work_sync(&fbi->task);
 	unregister_framebuffer(info);
 
 	pxafb_disable_controller(fbi);
diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index b7f9da690db2..38a772582bc3 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -197,7 +197,7 @@ static void sisfb_search_mode(char *name, bool quiet)
 {
 	unsigned int j = 0, xres = 0, yres = 0, depth = 0, rate = 0;
 	int i = 0;
-	char strbuf[16], strbuf1[20];
+	char strbuf[24], strbuf1[20];
 	char *nameptr = name;
 
 	/* We don't know the hardware specs yet and there is no ivideo */
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 3d9997595d90..98f82c759d1e 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -94,34 +94,24 @@ static inline dma_addr_t xen_virt_to_bus(void *address)
 	return xen_phys_to_bus(virt_to_phys(address));
 }
 
-static int check_pages_physically_contiguous(unsigned long xen_pfn,
-					     unsigned int offset,
-					     size_t length)
+static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 {
-	unsigned long next_bfn;
-	int i;
-	int nr_pages;
+	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
+	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
+	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
 
 	next_bfn = pfn_to_bfn(xen_pfn);
-	nr_pages = (offset + length + XEN_PAGE_SIZE-1) >> XEN_PAGE_SHIFT;
 
-	for (i = 1; i < nr_pages; i++) {
+	/* If buffer is physically aligned, ensure DMA alignment. */
+	if (IS_ALIGNED(p, algn) &&
+	    !IS_ALIGNED((phys_addr_t)next_bfn << XEN_PAGE_SHIFT, algn))
+		return 1;
+
+	for (i = 1; i < nr_pages; i++)
 		if (pfn_to_bfn(++xen_pfn) != ++next_bfn)
-			return 0;
-	}
-	return 1;
-}
+			return 1;
 
-static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
-{
-	unsigned long xen_pfn = XEN_PFN_DOWN(p);
-	unsigned int offset = p & ~XEN_PAGE_MASK;
-
-	if (offset + size <= XEN_PAGE_SIZE)
-		return 0;
-	if (check_pages_physically_contiguous(xen_pfn, offset, size))
-		return 0;
-	return 1;
+	return 0;
 }
 
 static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 437ca4691967..1f4c446409cf 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4244,6 +4244,17 @@ static void btrfs_destroy_all_ordered_extents(struct btrfs_fs_info *fs_info)
 	}
 	spin_unlock(&fs_info->ordered_root_lock);
 
+	/*
+	 * Wait for any fixup workers to complete.
+	 * If we don't wait for them here and they are still running by the time
+	 * we call kthread_stop() against the cleaner kthread further below, we
+	 * get an use-after-free on the cleaner because the fixup worker adds an
+	 * inode to the list of delayed iputs and then attempts to wakeup the
+	 * cleaner kthread, which was already stopped and destroyed. We parked
+	 * already the cleaner, but below we run all pending delayed iputs.
+	 */
+	btrfs_flush_workqueue(fs_info->fixup_workers);
+
 	/*
 	 * We need this here because if we've been flipped read-only we won't
 	 * get sync() from the umount, so we need to make sure any ordered
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index de10899da837..98b17992524b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -88,7 +88,6 @@ static int ceph_set_page_dirty(struct page *page)
 
 	/* dirty the head */
 	spin_lock(&ci->i_ceph_lock);
-	BUG_ON(ci->i_wr_ref == 0); // caller should hold Fw reference
 	if (__ceph_have_pending_cap_snap(ci)) {
 		struct ceph_cap_snap *capsnap =
 				list_last_entry(&ci->i_cap_snaps,
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index fa2579abea7d..3871df6b6732 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -629,6 +629,7 @@ enum {
  */
 #define EXT4_EX_NOCACHE				0x40000000
 #define EXT4_EX_FORCE_CACHE			0x20000000
+#define EXT4_EX_NOFAIL				0x10000000
 
 /*
  * Flags used by ext4_free_blocks
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d162cc059053..4f2b48627db0 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -290,11 +290,14 @@ ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
 {
 	struct ext4_ext_path *path = *ppath;
 	int unwritten = ext4_ext_is_unwritten(path[path->p_depth].p_ext);
+	int flags = EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_PRE_IO;
+
+	if (nofail)
+		flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL | EXT4_EX_NOFAIL;
 
 	return ext4_split_extent_at(handle, inode, ppath, lblk, unwritten ?
 			EXT4_EXT_MARK_UNWRIT1|EXT4_EXT_MARK_UNWRIT2 : 0,
-			EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_PRE_IO |
-			(nofail ? EXT4_GET_BLOCKS_METADATA_NOFAIL:0));
+			flags);
 }
 
 /*
@@ -536,8 +539,12 @@ __read_extent_tree_block(const char *function, unsigned int line,
 {
 	struct buffer_head		*bh;
 	int				err;
+	gfp_t				gfp_flags = __GFP_MOVABLE | GFP_NOFS;
+
+	if (flags & EXT4_EX_NOFAIL)
+		gfp_flags |= __GFP_NOFAIL;
 
-	bh = sb_getblk_gfp(inode->i_sb, pblk, __GFP_MOVABLE | GFP_NOFS);
+	bh = sb_getblk_gfp(inode->i_sb, pblk, gfp_flags);
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 
@@ -879,6 +886,10 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	struct ext4_ext_path *path = orig_path ? *orig_path : NULL;
 	short int depth, i, ppos = 0;
 	int ret;
+	gfp_t gfp_flags = GFP_NOFS;
+
+	if (flags & EXT4_EX_NOFAIL)
+		gfp_flags |= __GFP_NOFAIL;
 
 	eh = ext_inode_hdr(inode);
 	depth = ext_depth(inode);
@@ -899,7 +910,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	if (!path) {
 		/* account possible depth increase */
 		path = kcalloc(depth + 2, sizeof(struct ext4_ext_path),
-				GFP_NOFS);
+				gfp_flags);
 		if (unlikely(!path))
 			return ERR_PTR(-ENOMEM);
 		path[0].p_maxdepth = depth + 1;
@@ -945,6 +956,8 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 
 	ext4_ext_show_path(inode, path);
 
+	if (orig_path)
+		*orig_path = path;
 	return path;
 
 err:
@@ -1049,9 +1062,13 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	ext4_fsblk_t newblock, oldblock;
 	__le32 border;
 	ext4_fsblk_t *ablocks = NULL; /* array of allocated blocks */
+	gfp_t gfp_flags = GFP_NOFS;
 	int err = 0;
 	size_t ext_size = 0;
 
+	if (flags & EXT4_EX_NOFAIL)
+		gfp_flags |= __GFP_NOFAIL;
+
 	/* make decision: where to split? */
 	/* FIXME: now decision is simplest: at current extent */
 
@@ -1085,7 +1102,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	 * We need this to handle errors and free blocks
 	 * upon them.
 	 */
-	ablocks = kcalloc(depth, sizeof(ext4_fsblk_t), GFP_NOFS);
+	ablocks = kcalloc(depth, sizeof(ext4_fsblk_t), gfp_flags);
 	if (!ablocks)
 		return -ENOMEM;
 
@@ -1872,6 +1889,7 @@ static void ext4_ext_try_to_merge_up(handle_t *handle,
 	path[0].p_hdr->eh_max = cpu_to_le16(max_root);
 
 	brelse(path[1].p_bh);
+	path[1].p_bh = NULL;
 	ext4_free_blocks(handle, inode, NULL, blk, 1,
 			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
 }
@@ -2074,7 +2092,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	if (next != EXT_MAX_BLOCKS) {
 		ext_debug("next leaf block - %u\n", next);
 		BUG_ON(npath != NULL);
-		npath = ext4_find_extent(inode, next, NULL, 0);
+		npath = ext4_find_extent(inode, next, NULL, gb_flags);
 		if (IS_ERR(npath))
 			return PTR_ERR(npath);
 		BUG_ON(npath->p_depth != path->p_depth);
@@ -2099,6 +2117,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 				       ppath, newext);
 	if (err)
 		goto cleanup;
+	path = *ppath;
 	depth = ext_depth(inode);
 	eh = path[depth].p_hdr;
 
@@ -2876,7 +2895,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		ext4_fsblk_t pblk;
 
 		/* find extent for or closest extent to this block */
-		path = ext4_find_extent(inode, end, NULL, EXT4_EX_NOCACHE);
+		path = ext4_find_extent(inode, end, NULL,
+					EXT4_EX_NOCACHE | EXT4_EX_NOFAIL);
 		if (IS_ERR(path)) {
 			ext4_journal_stop(handle);
 			return PTR_ERR(path);
@@ -2958,7 +2978,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				le16_to_cpu(path[k].p_hdr->eh_entries)+1;
 	} else {
 		path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
-			       GFP_NOFS);
+			       GFP_NOFS | __GFP_NOFAIL);
 		if (path == NULL) {
 			ext4_journal_stop(handle);
 			return -ENOMEM;
@@ -3273,9 +3293,27 @@ static int ext4_split_extent_at(handle_t *handle,
 		ext4_ext_mark_unwritten(ex2);
 
 	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
-	if (err != -ENOSPC && err != -EDQUOT)
+	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
 		goto out;
 
+	/*
+	 * Update path is required because previous ext4_ext_insert_extent()
+	 * may have freed or reallocated the path. Using EXT4_EX_NOFAIL
+	 * guarantees that ext4_find_extent() will not return -ENOMEM,
+	 * otherwise -ENOMEM will cause a retry in do_writepages(), and a
+	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
+	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
+	 */
+	path = ext4_find_extent(inode, ee_block, ppath,
+				flags | EXT4_EX_NOFAIL);
+	if (IS_ERR(path)) {
+		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
+				 split, PTR_ERR(path));
+		return PTR_ERR(path);
+	}
+	depth = ext_depth(inode);
+	ex = path[depth].p_ext;
+
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
 		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
 			if (split_flag & EXT4_EXT_DATA_VALID1) {
@@ -3324,7 +3362,7 @@ static int ext4_split_extent_at(handle_t *handle,
 	ext4_ext_dirty(handle, inode, path + path->p_depth);
 	return err;
 out:
-	ext4_ext_show_leaf(inode, path);
+	ext4_ext_show_leaf(inode, *ppath);
 	return err;
 }
 
@@ -3380,7 +3418,7 @@ static int ext4_split_extent(handle_t *handle,
 	 * Update path is required because previous ext4_split_extent_at() may
 	 * result in split of original leaf or extent zeroout.
 	 */
-	path = ext4_find_extent(inode, map->m_lblk, ppath, 0);
+	path = ext4_find_extent(inode, map->m_lblk, ppath, flags);
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 	depth = ext_depth(inode);
@@ -4675,7 +4713,14 @@ int ext4_ext_truncate(handle_t *handle, struct inode *inode)
 	}
 	if (err)
 		return err;
-	return ext4_ext_remove_space(inode, last_block, EXT_MAX_BLOCKS - 1);
+retry_remove_space:
+	err = ext4_ext_remove_space(inode, last_block, EXT_MAX_BLOCKS - 1);
+	if (err == -ENOMEM) {
+		cond_resched();
+		congestion_wait(BLK_RW_ASYNC, HZ/50);
+		goto retry_remove_space;
+	}
+	return err;
 }
 
 static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
@@ -5731,6 +5776,7 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
 	if (IS_ERR(path)) {
 		up_write(&EXT4_I(inode)->i_data_sem);
+		ret = PTR_ERR(path);
 		goto out_stop;
 	}
 
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 5dfb34802aed..39a824df5272 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -510,6 +510,8 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 	if (min_inodes < 1)
 		min_inodes = 1;
 	min_clusters = avefreec - EXT4_CLUSTERS_PER_GROUP(sb)*flex_size / 4;
+	if (min_clusters < 0)
+		min_clusters = 0;
 
 	/*
 	 * Start looking in the flex group where we last allocated an
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 71bb3cfc5933..2230b3647962 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1653,24 +1653,36 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
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
@@ -1680,20 +1692,23 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
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
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 646285fbc9fc..a9fbb047d30d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5545,8 +5545,9 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 	struct page *page;
 	unsigned offset;
 	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
-	tid_t commit_tid = 0;
+	tid_t commit_tid;
 	int ret;
+	bool has_transaction;
 
 	offset = inode->i_size & (PAGE_SIZE - 1);
 	/*
@@ -5571,12 +5572,14 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 		put_page(page);
 		if (ret != -EBUSY)
 			return;
-		commit_tid = 0;
+		has_transaction = false;
 		read_lock(&journal->j_state_lock);
-		if (journal->j_committing_transaction)
+		if (journal->j_committing_transaction) {
 			commit_tid = journal->j_committing_transaction->t_tid;
+			has_transaction = true;
+		}
 		read_unlock(&journal->j_state_lock);
-		if (commit_tid)
+		if (has_transaction)
 			jbd2_log_wait_commit(journal, commit_tid);
 	}
 }
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 75dbe40ed8f7..329b3cf10574 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2834,11 +2834,8 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
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
@@ -4962,8 +4959,9 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 					 " group:%d block:%d count:%lu failed"
 					 " with %d", block_group, bit, count,
 					 err);
-		} else
-			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
+		}
+
+		EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
 
 		ext4_lock_group(sb, block_group);
 		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 4a72583c7559..9f73c2f7f949 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -678,8 +678,8 @@ int ext4_ind_migrate(struct inode *inode)
 		ei->i_data[i] = cpu_to_le32(blk++);
 	ext4_mark_inode_dirty(handle, inode);
 errout:
-	ext4_journal_stop(handle);
 	up_write(&EXT4_I(inode)->i_data_sem);
+	ext4_journal_stop(handle);
 out_unlock:
 	percpu_up_write(&sbi->s_writepages_rwsem);
 	return ret;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 2c368d67a33a..1581b48af1fe 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -37,7 +37,6 @@ get_ext_path(struct inode *inode, ext4_lblk_t lblock,
 		*ppath = NULL;
 		return -ENODATA;
 	}
-	*ppath = path;
 	return 0;
 }
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 8594feea2d93..590f3a07dc47 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1334,7 +1334,7 @@ static inline bool ext4_match(const struct ext4_filename *fname,
 }
 
 /*
- * Returns 0 if not found, -1 on failure, and 1 on success
+ * Returns 0 if not found, -EFSCORRUPTED on failure, and 1 on success
  */
 int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		    struct inode *dir, struct ext4_filename *fname,
@@ -1355,7 +1355,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 			 * a full check */
 			if (ext4_check_dir_entry(dir, NULL, de, bh, search_buf,
 						 buf_size, offset))
-				return -1;
+				return -EFSCORRUPTED;
 			*res_dir = de;
 			return 1;
 		}
@@ -1363,7 +1363,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		de_len = ext4_rec_len_from_disk(de->rec_len,
 						dir->i_sb->s_blocksize);
 		if (de_len <= 0)
-			return -1;
+			return -EFSCORRUPTED;
 		offset += de_len;
 		de = (struct ext4_dir_entry_2 *) ((char *) de + de_len);
 	}
@@ -1514,8 +1514,10 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 			goto cleanup_and_exit;
 		} else {
 			brelse(bh);
-			if (i < 0)
+			if (i < 0) {
+				ret = ERR_PTR(i);
 				goto cleanup_and_exit;
+			}
 		}
 	next:
 		if (++block >= nblocks)
@@ -1609,7 +1611,7 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		if (retval == 1)
 			goto success;
 		brelse(bh);
-		if (retval == -1) {
+		if (retval < 0) {
 			bh = ERR_PTR(ERR_BAD_DX_DIR);
 			goto errout;
 		}
@@ -1830,7 +1832,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 		split = count/2;
 
 	hash2 = map[split].hash;
-	continued = hash2 == map[split - 1].hash;
+	continued = split > 0 ? hash2 == map[split - 1].hash : 0;
 	dxtrace(printk(KERN_INFO "Split block %lu at %x, %i/%i\n",
 			(unsigned long)dx_get_block(frame->at),
 					hash2, split, count-split));
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index e9299f769dbf..4e8cd5dde186 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -437,7 +437,7 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
 		ext4_set_inode_state(inode, EXT4_STATE_LUSTRE_EA_INODE);
 		ext4_xattr_inode_set_ref(inode, 1);
 	} else {
-		inode_lock(inode);
+		inode_lock_nested(inode, I_MUTEX_XATTR);
 		inode->i_flags |= S_NOQUOTA;
 		inode_unlock(inode);
 	}
@@ -1053,7 +1053,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 	s64 ref_count;
 	int ret;
 
-	inode_lock(ea_inode);
+	inode_lock_nested(ea_inode, I_MUTEX_XATTR);
 
 	ret = ext4_reserve_inode_write(handle, ea_inode, &iloc);
 	if (ret) {
diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index b9fe937a3c70..cc53d4c80b0a 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -200,6 +200,27 @@ struct posix_acl *f2fs_get_acl(struct inode *inode, int type)
 	return __f2fs_get_acl(inode, type, NULL);
 }
 
+static int f2fs_acl_update_mode(struct inode *inode, umode_t *mode_p,
+			  struct posix_acl **acl)
+{
+	umode_t mode = inode->i_mode;
+	int error;
+
+	if (is_inode_flag_set(inode, FI_ACL_MODE))
+		mode = F2FS_I(inode)->i_acl_mode;
+
+	error = posix_acl_equiv_mode(*acl, &mode);
+	if (error < 0)
+		return error;
+	if (error == 0)
+		*acl = NULL;
+	if (!in_group_p(inode->i_gid) &&
+	    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
+		mode &= ~S_ISGID;
+	*mode_p = mode;
+	return 0;
+}
+
 static int __f2fs_set_acl(struct inode *inode, int type,
 			struct posix_acl *acl, struct page *ipage)
 {
@@ -213,7 +234,7 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	case ACL_TYPE_ACCESS:
 		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
 		if (acl && !ipage) {
-			error = posix_acl_update_mode(inode, &mode, &acl);
+			error = f2fs_acl_update_mode(inode, &mode, &acl);
 			if (error)
 				return error;
 			set_acl_inode(inode, mode);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 2cd85ce3e450..044de0d7c1e0 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -79,7 +79,8 @@ static unsigned long dir_block_index(unsigned int level,
 	unsigned long bidx = 0;
 
 	for (i = 0; i < level; i++)
-		bidx += dir_buckets(i, dir_level) * bucket_blocks(i);
+		bidx += mul_u32_u32(dir_buckets(i, dir_level),
+				    bucket_blocks(i));
 	bidx += idx * bucket_blocks(level);
 	return bidx;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index aacd8e11758c..f90aaa16bdee 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -213,7 +213,8 @@ enum {
 	ORPHAN_INO,		/* for orphan ino list */
 	APPEND_INO,		/* for append ino list */
 	UPDATE_INO,		/* for update ino list */
-	TRANS_DIR_INO,		/* for trasactions dir ino list */
+	TRANS_DIR_INO,		/* for transactions dir ino list */
+	XATTR_DIR_INO,		/* for xattr updated dir ino list */
 	FLUSH_INO,		/* for multiple device flushing */
 	MAX_INO_ENTRY,		/* max. list */
 };
@@ -998,6 +999,7 @@ enum cp_reason_type {
 	CP_FASTBOOT_MODE,
 	CP_SPEC_LOG_NUM,
 	CP_RECOVER_DIR,
+	CP_XATTR_DIR,
 };
 
 enum iostat_type {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 043ce96ac127..aabc5fe45a3b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -170,6 +170,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
 		f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
 							TRANS_DIR_INO))
 		cp_reason = CP_RECOVER_DIR;
+	else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
+							XATTR_DIR_INO))
+		cp_reason = CP_XATTR_DIR;
 
 	return cp_reason;
 }
@@ -839,8 +842,10 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if (attr->ia_valid & ATTR_MODE) {
 		err = posix_acl_chmod(inode, f2fs_get_inode_mode(inode));
-		if (err || is_inode_flag_set(inode, FI_ACL_MODE)) {
-			inode->i_mode = F2FS_I(inode)->i_acl_mode;
+
+		if (is_inode_flag_set(inode, FI_ACL_MODE)) {
+			if (!err)
+				inode->i_mode = F2FS_I(inode)->i_acl_mode;
 			clear_inode_flag(inode, FI_ACL_MODE);
 		}
 	}
@@ -1711,6 +1716,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
@@ -1768,6 +1776,9 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
@@ -1813,6 +1824,9 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
@@ -1848,6 +1862,9 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
@@ -1877,6 +1894,9 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b075ba3e62dc..a667d263093f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2116,9 +2116,9 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 	u32 segment_count = le32_to_cpu(raw_super->segment_count);
 	u32 log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
 	u64 main_end_blkaddr = main_blkaddr +
-				(segment_count_main << log_blocks_per_seg);
+				((u64)segment_count_main << log_blocks_per_seg);
 	u64 seg_end_blkaddr = segment0_blkaddr +
-				(segment_count << log_blocks_per_seg);
+				((u64)segment_count << log_blocks_per_seg);
 
 	if (segment0_blkaddr != cp_blkaddr) {
 		f2fs_msg(sb, KERN_INFO,
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index db3e76b35607..0b9568480d8f 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -607,6 +607,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 			const char *name, const void *value, size_t size,
 			struct page *ipage, int flags)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_xattr_entry *here, *last;
 	void *base_addr, *last_base_addr;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
@@ -651,7 +652,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		}
 
 		if (value && f2fs_xattr_value_same(here, value, size))
-			goto exit;
+			goto same;
 	} else if ((flags & XATTR_REPLACE)) {
 		error = -ENODATA;
 		goto exit;
@@ -729,17 +730,29 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (error)
 		goto exit;
 
+	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
+			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
+		f2fs_set_encrypted_inode(inode);
+
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
+same:
 	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
 		inode->i_mode = F2FS_I(inode)->i_acl_mode;
-		inode->i_ctime = current_time(inode);
 		clear_inode_flag(inode, FI_ACL_MODE);
 	}
-	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
-			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
-		f2fs_set_encrypted_inode(inode);
+
+	inode->i_ctime = current_time(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
-	if (!error && S_ISDIR(inode->i_mode))
-		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
 exit:
 	kzfree(base_addr);
 	return error;
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 82cd1e69cbdf..4f8e9e70b6df 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1018,7 +1018,7 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (corrupt < 0) {
 		fat_fs_error(new_dir->i_sb,
 			     "%s: Filesystem corrupted (i_pos %lld)",
-			     __func__, sinfo.i_pos);
+			     __func__, new_i_pos);
 	}
 	goto out;
 }
diff --git a/fs/fcntl.c b/fs/fcntl.c
index dffb5245ae72..3579fb6da5e2 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -84,8 +84,8 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
 	return error;
 }
 
-static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
-                     int force)
+void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
+		int force)
 {
 	write_lock_irq(&filp->f_owner.lock);
 	if (force || !filp->f_owner.pid) {
@@ -95,19 +95,13 @@ static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
 
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
 
 int f_setown(struct file *filp, unsigned long arg, int force)
@@ -143,7 +137,7 @@ EXPORT_SYMBOL(f_setown);
 
 void f_delown(struct file *filp)
 {
-	f_modown(filp, NULL, PIDTYPE_TGID, 1);
+	__f_setown(filp, NULL, PIDTYPE_TGID, 1);
 }
 
 pid_t f_getown(struct file *filp)
diff --git a/fs/inode.c b/fs/inode.c
index 5df2e8ee23ed..86303c04e15e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -616,6 +616,10 @@ void evict_inodes(struct super_block *sb)
 			continue;
 
 		spin_lock(&inode->i_lock);
+		if (atomic_read(&inode->i_count)) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
 		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
 			spin_unlock(&inode->i_lock);
 			continue;
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 66409cbd3ed5..086da7cbca1f 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -137,17 +137,23 @@ void __jbd2_log_wait_for_space(journal_t *journal)
 		if (space_left < nblocks) {
 			int chkpt = journal->j_checkpoint_transactions != NULL;
 			tid_t tid = 0;
+			bool has_transaction = false;
 
-			if (journal->j_committing_transaction)
+			if (journal->j_committing_transaction) {
 				tid = journal->j_committing_transaction->t_tid;
+				has_transaction = true;
+			}
 			spin_unlock(&journal->j_list_lock);
 			write_unlock(&journal->j_state_lock);
 			if (chkpt) {
 				jbd2_log_do_checkpoint(journal);
-			} else if (jbd2_cleanup_journal_tail(journal) == 0) {
-				/* We were able to recover space; yay! */
+			} else if (jbd2_cleanup_journal_tail(journal) <= 0) {
+				/*
+				 * We were able to recover space or the
+				 * journal was aborted due to an error.
+				 */
 				;
-			} else if (tid) {
+			} else if (has_transaction) {
 				/*
 				 * jbd2_journal_commit_transaction() may want
 				 * to take the checkpoint_mutex if JBD2_FLUSHED
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 97760cb9bcd7..0250a6e1f91c 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -187,19 +187,17 @@ static int journal_wait_on_commit_record(journal_t *journal,
  * use writepages() because with dealyed allocation we may be doing
  * block allocation in writepages().
  */
-static int journal_submit_inode_data_buffers(struct address_space *mapping,
-		loff_t dirty_start, loff_t dirty_end)
+int jbd2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 {
-	int ret;
+	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
 	struct writeback_control wbc = {
 		.sync_mode =  WB_SYNC_ALL,
 		.nr_to_write = mapping->nrpages * 2,
-		.range_start = dirty_start,
-		.range_end = dirty_end,
+		.range_start = jinode->i_dirty_start,
+		.range_end = jinode->i_dirty_end,
 	};
 
-	ret = generic_writepages(mapping, &wbc);
-	return ret;
+	return generic_writepages(mapping, &wbc);
 }
 
 /*
@@ -215,16 +213,11 @@ static int journal_submit_data_buffers(journal_t *journal,
 {
 	struct jbd2_inode *jinode;
 	int err, ret = 0;
-	struct address_space *mapping;
 
 	spin_lock(&journal->j_list_lock);
 	list_for_each_entry(jinode, &commit_transaction->t_inode_list, i_list) {
-		loff_t dirty_start = jinode->i_dirty_start;
-		loff_t dirty_end = jinode->i_dirty_end;
-
 		if (!(jinode->i_flags & JI_WRITE_DATA))
 			continue;
-		mapping = jinode->i_vfs_inode->i_mapping;
 		jinode->i_flags |= JI_COMMIT_RUNNING;
 		spin_unlock(&journal->j_list_lock);
 		/*
@@ -234,8 +227,7 @@ static int journal_submit_data_buffers(journal_t *journal,
 		 * only allocated blocks here.
 		 */
 		trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
-		err = journal_submit_inode_data_buffers(mapping, dirty_start,
-				dirty_end);
+		err = jbd2_journal_submit_inode_data_buffers(jinode);
 		if (!ret)
 			ret = err;
 		spin_lock(&journal->j_list_lock);
@@ -248,6 +240,15 @@ static int journal_submit_data_buffers(journal_t *journal,
 	return ret;
 }
 
+int jbd2_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
+{
+	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
+
+	return filemap_fdatawait_range_keep_errors(mapping,
+						   jinode->i_dirty_start,
+						   jinode->i_dirty_end);
+}
+
 /*
  * Wait for data submitted for writeout, refile inodes to proper
  * transaction if needed.
@@ -262,16 +263,11 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 	/* For locking, see the comment in journal_submit_data_buffers() */
 	spin_lock(&journal->j_list_lock);
 	list_for_each_entry(jinode, &commit_transaction->t_inode_list, i_list) {
-		loff_t dirty_start = jinode->i_dirty_start;
-		loff_t dirty_end = jinode->i_dirty_end;
-
 		if (!(jinode->i_flags & JI_WAIT_DATA))
 			continue;
 		jinode->i_flags |= JI_COMMIT_RUNNING;
 		spin_unlock(&journal->j_list_lock);
-		err = filemap_fdatawait_range_keep_errors(
-				jinode->i_vfs_inode->i_mapping, dirty_start,
-				dirty_end);
+		err = jbd2_journal_finish_inode_data_buffers(jinode);
 		if (!ret)
 			ret = err;
 		spin_lock(&journal->j_list_lock);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 08cff80f8c29..79eceebbf3df 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -96,6 +96,8 @@ EXPORT_SYMBOL(jbd2_journal_inode_add_write);
 EXPORT_SYMBOL(jbd2_journal_inode_add_wait);
 EXPORT_SYMBOL(jbd2_journal_inode_ranged_write);
 EXPORT_SYMBOL(jbd2_journal_inode_ranged_wait);
+EXPORT_SYMBOL(jbd2_journal_submit_inode_data_buffers);
+EXPORT_SYMBOL(jbd2_journal_finish_inode_data_buffers);
 EXPORT_SYMBOL(jbd2_journal_init_jbd_inode);
 EXPORT_SYMBOL(jbd2_journal_release_jbd_inode);
 EXPORT_SYMBOL(jbd2_journal_begin_ordered_truncate);
diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
index f76ff0a46444..9d78c427b944 100644
--- a/fs/jfs/jfs_discard.c
+++ b/fs/jfs/jfs_discard.c
@@ -78,7 +78,7 @@ void jfs_issue_discard(struct inode *ip, u64 blkno, u64 nblocks)
 int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 {
 	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
-	struct bmap *bmp = JFS_SBI(ip->i_sb)->bmap;
+	struct bmap *bmp;
 	struct super_block *sb = ipbmap->i_sb;
 	int agno, agno_end;
 	u64 start, end, minlen;
@@ -96,10 +96,15 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 	if (minlen == 0)
 		minlen = 1;
 
+	down_read(&sb->s_umount);
+	bmp = JFS_SBI(ip->i_sb)->bmap;
+
 	if (minlen > bmp->db_agsize ||
 	    start >= bmp->db_mapsize ||
-	    range->len < sb->s_blocksize)
+	    range->len < sb->s_blocksize) {
+		up_read(&sb->s_umount);
 		return -EINVAL;
+	}
 
 	if (end >= bmp->db_mapsize)
 		end = bmp->db_mapsize - 1;
@@ -113,6 +118,8 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 		trimmed += dbDiscardAG(ip, agno, minlen);
 		agno++;
 	}
+
+	up_read(&sb->s_umount);
 	range->len = trimmed << sb->s_blocksize_bits;
 
 	return 0;
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 893bc59658da..b6c698fe7301 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -200,7 +200,7 @@ int dbMount(struct inode *ipbmap)
 	}
 
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
-	if (!bmp->db_numag) {
+	if (!bmp->db_numag || bmp->db_numag > MAXAG) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
@@ -665,7 +665,7 @@ int dbNextAG(struct inode *ipbmap)
 	 * average free space.
 	 */
 	for (i = 0 ; i < bmp->db_numag; i++, agpref++) {
-		if (agpref == bmp->db_numag)
+		if (agpref >= bmp->db_numag)
 			agpref = 0;
 
 		if (atomic_read(&bmp->db_active[agpref]))
@@ -3019,9 +3019,10 @@ static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl)
 {
 	int ti, n = 0, k, x = 0;
-	int max_size;
+	int max_size, max_idx;
 
 	max_size = is_ctl ? CTLTREESIZE : TREESIZE;
+	max_idx = is_ctl ? LPERCTL : LPERDMAP;
 
 	/* first check the root of the tree to see if there is
 	 * sufficient free space.
@@ -3053,6 +3054,8 @@ static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl)
 		 */
 		assert(n < 4);
 	}
+	if (le32_to_cpu(tp->dmt_leafidx) >= max_idx)
+		return -ENOSPC;
 
 	/* set the return to the leftmost leaf describing sufficient
 	 * free space.
@@ -3097,7 +3100,7 @@ static int dbFindBits(u32 word, int l2nb)
 
 	/* scan the word for nb free bits at nb alignments.
 	 */
-	for (bitno = 0; mask != 0; bitno += nb, mask >>= nb) {
+	for (bitno = 0; mask != 0; bitno += nb, mask = (mask >> nb)) {
 		if ((mask & word) == mask)
 			break;
 	}
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 9893cb6b8a75..1e9a3ec4bfa8 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -1375,7 +1375,7 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 	/* get the ag number of this iag */
 	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
 	dn_numag = JFS_SBI(pip->i_sb)->bmap->db_numag;
-	if (agno < 0 || agno > dn_numag)
+	if (agno < 0 || agno > dn_numag || agno >= MAXAG)
 		return -EIO;
 
 	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 37b984692ca9..bb8c4583f065 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -447,6 +447,8 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 	int rc;
 	int quota_allocation = 0;
 
+	memset(&ea_buf->new_ea, 0, sizeof(ea_buf->new_ea));
+
 	/* When fsck.jfs clears a bad ea, it doesn't clear the size */
 	if (ji->ea.flag == 0)
 		ea_size = 0;
diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index 214a2fa1f1e3..7df6324ccb8a 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -74,17 +74,6 @@ static void nlm4_compute_offsets(const struct nlm_lock *lock,
 		*l_len = loff_t_to_s64(fl->fl_end - fl->fl_start + 1);
 }
 
-/*
- * Handle decode buffer overflows out-of-line.
- */
-static void print_overflow_msg(const char *func, const struct xdr_stream *xdr)
-{
-	dprintk("lockd: %s prematurely hit the end of our receive buffer. "
-		"Remaining buffer length is %tu words.\n",
-		func, xdr->end - xdr->p);
-}
-
-
 /*
  * Encode/decode NLMv4 basic data types
  *
@@ -176,7 +165,6 @@ static int decode_cookie(struct xdr_stream *xdr,
 	dprintk("NFS: returned cookie was too long: %u\n", length);
 	return -EIO;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
@@ -236,7 +224,6 @@ static int decode_nlm4_stat(struct xdr_stream *xdr, __be32 *stat)
 			__func__, be32_to_cpup(p));
 	return -EIO;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
@@ -309,7 +296,6 @@ static int decode_nlm4_holder(struct xdr_stream *xdr, struct nlm_res *result)
 out:
 	return error;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
index 747b9c8c940a..4df62f635529 100644
--- a/fs/lockd/clntxdr.c
+++ b/fs/lockd/clntxdr.c
@@ -70,17 +70,6 @@ static void nlm_compute_offsets(const struct nlm_lock *lock,
 		*l_len = loff_t_to_s32(fl->fl_end - fl->fl_start + 1);
 }
 
-/*
- * Handle decode buffer overflows out-of-line.
- */
-static void print_overflow_msg(const char *func, const struct xdr_stream *xdr)
-{
-	dprintk("lockd: %s prematurely hit the end of our receive buffer. "
-		"Remaining buffer length is %tu words.\n",
-		func, xdr->end - xdr->p);
-}
-
-
 /*
  * Encode/decode NLMv3 basic data types
  *
@@ -173,7 +162,6 @@ static int decode_cookie(struct xdr_stream *xdr,
 	dprintk("NFS: returned cookie was too long: %u\n", length);
 	return -EIO;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
@@ -231,7 +219,6 @@ static int decode_nlm_stat(struct xdr_stream *xdr,
 		__func__, be32_to_cpup(p));
 	return -EIO;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
@@ -303,7 +290,6 @@ static int decode_nlm_holder(struct xdr_stream *xdr, struct nlm_res *result)
 out:
 	return error;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 2f84c612838c..8f8b3a7868e8 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -72,16 +72,6 @@ static int nfs4_encode_void(struct svc_rqst *rqstp, __be32 *p)
 	return xdr_ressize_check(rqstp, p);
 }
 
-static __be32 *read_buf(struct xdr_stream *xdr, size_t nbytes)
-{
-	__be32 *p;
-
-	p = xdr_inline_decode(xdr, nbytes);
-	if (unlikely(p == NULL))
-		printk(KERN_WARNING "NFS: NFSv4 callback reply buffer overflowed!\n");
-	return p;
-}
-
 static __be32 decode_string(struct xdr_stream *xdr, unsigned int *len,
 		const char **str, size_t maxlen)
 {
@@ -98,13 +88,13 @@ static __be32 decode_fh(struct xdr_stream *xdr, struct nfs_fh *fh)
 {
 	__be32 *p;
 
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 	fh->size = ntohl(*p);
 	if (fh->size > NFS4_FHSIZE)
 		return htonl(NFS4ERR_BADHANDLE);
-	p = read_buf(xdr, fh->size);
+	p = xdr_inline_decode(xdr, fh->size);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 	memcpy(&fh->data[0], p, fh->size);
@@ -117,11 +107,11 @@ static __be32 decode_bitmap(struct xdr_stream *xdr, uint32_t *bitmap)
 	__be32 *p;
 	unsigned int attrlen;
 
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 	attrlen = ntohl(*p);
-	p = read_buf(xdr, attrlen << 2);
+	p = xdr_inline_decode(xdr, attrlen << 2);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 	if (likely(attrlen > 0))
@@ -135,7 +125,7 @@ static __be32 decode_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
 {
 	__be32 *p;
 
-	p = read_buf(xdr, NFS4_STATEID_SIZE);
+	p = xdr_inline_decode(xdr, NFS4_STATEID_SIZE);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 	memcpy(stateid->data, p, NFS4_STATEID_SIZE);
@@ -156,7 +146,7 @@ static __be32 decode_compound_hdr_arg(struct xdr_stream *xdr, struct cb_compound
 	status = decode_string(xdr, &hdr->taglen, &hdr->tag, CB_OP_TAGLEN_MAXSZ);
 	if (unlikely(status != 0))
 		return status;
-	p = read_buf(xdr, 12);
+	p = xdr_inline_decode(xdr, 12);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 	hdr->minorversion = ntohl(*p++);
@@ -176,7 +166,7 @@ static __be32 decode_compound_hdr_arg(struct xdr_stream *xdr, struct cb_compound
 static __be32 decode_op_hdr(struct xdr_stream *xdr, unsigned int *op)
 {
 	__be32 *p;
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE_HDR);
 	*op = ntohl(*p);
@@ -205,7 +195,7 @@ static __be32 decode_recall_args(struct svc_rqst *rqstp,
 	status = decode_delegation_stateid(xdr, &args->stateid);
 	if (unlikely(status != 0))
 		return status;
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 	args->truncate = ntohl(*p);
@@ -227,7 +217,7 @@ static __be32 decode_layoutrecall_args(struct svc_rqst *rqstp,
 	__be32 status = 0;
 	uint32_t iomode;
 
-	p = read_buf(xdr, 4 * sizeof(uint32_t));
+	p = xdr_inline_decode(xdr, 4 * sizeof(uint32_t));
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_BADXDR);
 
@@ -245,14 +235,14 @@ static __be32 decode_layoutrecall_args(struct svc_rqst *rqstp,
 		if (unlikely(status != 0))
 			return status;
 
-		p = read_buf(xdr, 2 * sizeof(uint64_t));
+		p = xdr_inline_decode(xdr, 2 * sizeof(uint64_t));
 		if (unlikely(p == NULL))
 			return htonl(NFS4ERR_BADXDR);
 		p = xdr_decode_hyper(p, &args->cbl_range.offset);
 		p = xdr_decode_hyper(p, &args->cbl_range.length);
 		return decode_layout_stateid(xdr, &args->cbl_stateid);
 	} else if (args->cbl_recall_type == RETURN_FSID) {
-		p = read_buf(xdr, 2 * sizeof(uint64_t));
+		p = xdr_inline_decode(xdr, 2 * sizeof(uint64_t));
 		if (unlikely(p == NULL))
 			return htonl(NFS4ERR_BADXDR);
 		p = xdr_decode_hyper(p, &args->cbl_fsid.major);
@@ -273,7 +263,7 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 	__be32 status = 0;
 
 	/* Num of device notifications */
-	p = read_buf(xdr, sizeof(uint32_t));
+	p = xdr_inline_decode(xdr, sizeof(uint32_t));
 	if (unlikely(p == NULL)) {
 		status = htonl(NFS4ERR_BADXDR);
 		goto out;
@@ -292,7 +282,8 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 	for (i = 0; i < n; i++) {
 		struct cb_devicenotifyitem *dev = &args->devs[i];
 
-		p = read_buf(xdr, (4 * sizeof(uint32_t)) + NFS4_DEVICEID4_SIZE);
+		p = xdr_inline_decode(xdr, (4 * sizeof(uint32_t)) +
+				      NFS4_DEVICEID4_SIZE);
 		if (unlikely(p == NULL)) {
 			status = htonl(NFS4ERR_BADXDR);
 			goto err;
@@ -323,7 +314,7 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 		p += XDR_QUADLEN(NFS4_DEVICEID4_SIZE);
 
 		if (dev->cbd_layout_type == NOTIFY_DEVICEID4_CHANGE) {
-			p = read_buf(xdr, sizeof(uint32_t));
+			p = xdr_inline_decode(xdr, sizeof(uint32_t));
 			if (unlikely(p == NULL)) {
 				status = htonl(NFS4ERR_BADXDR);
 				goto err;
@@ -355,7 +346,7 @@ static __be32 decode_sessionid(struct xdr_stream *xdr,
 {
 	__be32 *p;
 
-	p = read_buf(xdr, NFS4_MAX_SESSIONID_LEN);
+	p = xdr_inline_decode(xdr, NFS4_MAX_SESSIONID_LEN);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 
@@ -375,13 +366,15 @@ static __be32 decode_rc_list(struct xdr_stream *xdr,
 		goto out;
 
 	status = htonl(NFS4ERR_RESOURCE);
-	p = read_buf(xdr, sizeof(uint32_t));
+	p = xdr_inline_decode(xdr, sizeof(uint32_t));
 	if (unlikely(p == NULL))
 		goto out;
 
 	rc_list->rcl_nrefcalls = ntohl(*p++);
 	if (rc_list->rcl_nrefcalls) {
-		p = read_buf(xdr,
+		if (unlikely(rc_list->rcl_nrefcalls > xdr->buf->len))
+			goto out;
+		p = xdr_inline_decode(xdr,
 			     rc_list->rcl_nrefcalls * 2 * sizeof(uint32_t));
 		if (unlikely(p == NULL))
 			goto out;
@@ -414,7 +407,7 @@ static __be32 decode_cb_sequence_args(struct svc_rqst *rqstp,
 	if (status)
 		return status;
 
-	p = read_buf(xdr, 5 * sizeof(uint32_t));
+	p = xdr_inline_decode(xdr, 5 * sizeof(uint32_t));
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 
@@ -457,7 +450,7 @@ static __be32 decode_recallany_args(struct svc_rqst *rqstp,
 	uint32_t bitmap[2];
 	__be32 *p, status;
 
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_BADXDR);
 	args->craa_objs_to_keep = ntohl(*p++);
@@ -476,7 +469,7 @@ static __be32 decode_recallslot_args(struct svc_rqst *rqstp,
 	struct cb_recallslotargs *args = argp;
 	__be32 *p;
 
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_BADXDR);
 	args->crsa_target_highest_slotid = ntohl(*p++);
@@ -488,14 +481,14 @@ static __be32 decode_lockowner(struct xdr_stream *xdr, struct cb_notify_lock_arg
 	__be32		*p;
 	unsigned int	len;
 
-	p = read_buf(xdr, 12);
+	p = xdr_inline_decode(xdr, 12);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_BADXDR);
 
 	p = xdr_decode_hyper(p, &args->cbnl_owner.clientid);
 	len = be32_to_cpu(*p);
 
-	p = read_buf(xdr, len);
+	p = xdr_inline_decode(xdr, len);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_BADXDR);
 
@@ -533,7 +526,7 @@ static __be32 decode_write_response(struct xdr_stream *xdr,
 	__be32 *p;
 
 	/* skip the always zero field */
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
 		goto out;
 	p++;
@@ -573,7 +566,7 @@ static __be32 decode_offload_args(struct svc_rqst *rqstp,
 		return status;
 
 	/* decode status */
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
 		goto out;
 	args->error = ntohl(*p++);
diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 040a05f0e61e..6968d6ffe84f 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -79,17 +79,6 @@ static void prepare_reply_buffer(struct rpc_rqst *req, struct page **pages,
 	xdr_inline_pages(&req->rq_rcv_buf, replen << 2, pages, base, len);
 }
 
-/*
- * Handle decode buffer overflows out-of-line.
- */
-static void print_overflow_msg(const char *func, const struct xdr_stream *xdr)
-{
-	dprintk("NFS: %s prematurely hit the end of our receive buffer. "
-		"Remaining buffer length is %tu words.\n",
-		func, xdr->end - xdr->p);
-}
-
-
 /*
  * Encode/decode NFSv2 basic data types
  *
@@ -110,8 +99,8 @@ static int decode_nfsdata(struct xdr_stream *xdr, struct nfs_pgio_res *result)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	count = be32_to_cpup(p);
 	recvd = xdr_read_pages(xdr, count);
 	if (unlikely(count > recvd))
@@ -125,9 +114,6 @@ static int decode_nfsdata(struct xdr_stream *xdr, struct nfs_pgio_res *result)
 		"count %u > recvd %u\n", count, recvd);
 	count = recvd;
 	goto out;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -157,13 +143,10 @@ static int decode_stat(struct xdr_stream *xdr, enum nfs_stat *status)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	*status = be32_to_cpup(p);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -205,14 +188,11 @@ static int decode_fhandle(struct xdr_stream *xdr, struct nfs_fh *fh)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, NFS2_FHSIZE);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	fh->size = NFS2_FHSIZE;
 	memcpy(fh->data, p, NFS2_FHSIZE);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -282,8 +262,8 @@ static int decode_fattr(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, NFS_fattr_sz << 2);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 
 	fattr->valid |= NFS_ATTR_FATTR_V2;
 
@@ -325,9 +305,6 @@ static int decode_fattr(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 out_gid:
 	dprintk("NFS: returned invalid gid\n");
 	return -EINVAL;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -416,23 +393,20 @@ static int decode_filename_inline(struct xdr_stream *xdr,
 	u32 count;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	count = be32_to_cpup(p);
 	if (count > NFS3_MAXNAMLEN)
 		goto out_nametoolong;
 	p = xdr_inline_decode(xdr, count);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	*name = (const char *)p;
 	*length = count;
 	return 0;
 out_nametoolong:
 	dprintk("NFS: returned filename too long: %u\n", count);
 	return -ENAMETOOLONG;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -455,8 +429,8 @@ static int decode_path(struct xdr_stream *xdr)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	length = be32_to_cpup(p);
 	if (unlikely(length >= xdr->buf->page_len || length > NFS_MAXPATHLEN))
 		goto out_size;
@@ -472,9 +446,6 @@ static int decode_path(struct xdr_stream *xdr)
 	dprintk("NFS: server cheating in pathname result: "
 		"length %u > received %u\n", length, recvd);
 	return -EIO;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -951,12 +922,12 @@ int nfs2_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	int error;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EAGAIN;
 	if (*p++ == xdr_zero) {
 		p = xdr_inline_decode(xdr, 4);
-		if (unlikely(p == NULL))
-			goto out_overflow;
+		if (unlikely(!p))
+			return -EAGAIN;
 		if (*p++ == xdr_zero)
 			return -EAGAIN;
 		entry->eof = 1;
@@ -964,8 +935,8 @@ int nfs2_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	}
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EAGAIN;
 	entry->ino = be32_to_cpup(p);
 
 	error = decode_filename_inline(xdr, &entry->name, &entry->len);
@@ -978,17 +949,13 @@ int nfs2_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	 */
 	entry->prev_cookie = entry->cookie;
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EAGAIN;
 	entry->cookie = be32_to_cpup(p);
 
 	entry->d_type = DT_UNKNOWN;
 
 	return 0;
-
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EAGAIN;
 }
 
 /*
@@ -1052,17 +1019,14 @@ static int decode_info(struct xdr_stream *xdr, struct nfs2_fsstat *result)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, NFS_info_sz << 2);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	result->tsize  = be32_to_cpup(p++);
 	result->bsize  = be32_to_cpup(p++);
 	result->blocks = be32_to_cpup(p++);
 	result->bfree  = be32_to_cpup(p++);
 	result->bavail = be32_to_cpup(p);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int nfs2_xdr_dec_statfsres(struct rpc_rqst *req, struct xdr_stream *xdr,
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 0ed419bb02b0..ebe7d1ce00e3 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -119,17 +119,6 @@ static void prepare_reply_buffer(struct rpc_rqst *req, struct page **pages,
 	xdr_inline_pages(&req->rq_rcv_buf, replen << 2, pages, base, len);
 }
 
-/*
- * Handle decode buffer overflows out-of-line.
- */
-static void print_overflow_msg(const char *func, const struct xdr_stream *xdr)
-{
-	dprintk("NFS: %s prematurely hit the end of our receive buffer. "
-		"Remaining buffer length is %tu words.\n",
-		func, xdr->end - xdr->p);
-}
-
-
 /*
  * Encode/decode NFSv3 basic data types
  *
@@ -152,13 +141,10 @@ static int decode_uint32(struct xdr_stream *xdr, u32 *value)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	*value = be32_to_cpup(p);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_uint64(struct xdr_stream *xdr, u64 *value)
@@ -166,13 +152,10 @@ static int decode_uint64(struct xdr_stream *xdr, u64 *value)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 8);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	xdr_decode_hyper(p, value);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -212,14 +195,14 @@ static int decode_inline_filename3(struct xdr_stream *xdr,
 	u32 count;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	count = be32_to_cpup(p);
 	if (count > NFS3_MAXNAMLEN)
 		goto out_nametoolong;
 	p = xdr_inline_decode(xdr, count);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	*name = (const char *)p;
 	*length = count;
 	return 0;
@@ -227,9 +210,6 @@ static int decode_inline_filename3(struct xdr_stream *xdr,
 out_nametoolong:
 	dprintk("NFS: returned filename too long: %u\n", count);
 	return -ENAMETOOLONG;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -250,8 +230,8 @@ static int decode_nfspath3(struct xdr_stream *xdr)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	count = be32_to_cpup(p);
 	if (unlikely(count >= xdr->buf->page_len || count > NFS3_MAXPATHLEN))
 		goto out_nametoolong;
@@ -268,9 +248,6 @@ static int decode_nfspath3(struct xdr_stream *xdr)
 	dprintk("NFS: server cheating in pathname result: "
 		"count %u > recvd %u\n", count, recvd);
 	return -EIO;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -304,13 +281,10 @@ static int decode_cookieverf3(struct xdr_stream *xdr, __be32 *verifier)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, NFS3_COOKIEVERFSIZE);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	memcpy(verifier, p, NFS3_COOKIEVERFSIZE);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -331,13 +305,10 @@ static int decode_writeverf3(struct xdr_stream *xdr, struct nfs_write_verifier *
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, NFS3_WRITEVERFSIZE);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	memcpy(verifier->data, p, NFS3_WRITEVERFSIZE);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -365,13 +336,10 @@ static int decode_nfsstat3(struct xdr_stream *xdr, enum nfs_stat *status)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	*status = be32_to_cpup(p);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -454,23 +422,20 @@ static int decode_nfs_fh3(struct xdr_stream *xdr, struct nfs_fh *fh)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	length = be32_to_cpup(p++);
 	if (unlikely(length > NFS3_FHSIZE))
 		goto out_toobig;
 	p = xdr_inline_decode(xdr, length);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	fh->size = length;
 	memcpy(fh->data, p, length);
 	return 0;
 out_toobig:
 	dprintk("NFS: file handle size (%u) too big\n", length);
 	return -E2BIG;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static void zero_nfs_fh3(struct nfs_fh *fh)
@@ -656,8 +621,8 @@ static int decode_fattr3(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, NFS3_fattr_sz << 2);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 
 	p = xdr_decode_ftype3(p, &fmode);
 
@@ -691,9 +656,6 @@ static int decode_fattr3(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 out_gid:
 	dprintk("NFS: returned invalid gid\n");
 	return -EINVAL;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -711,14 +673,11 @@ static int decode_post_op_attr(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	if (*p != xdr_zero)
 		return decode_fattr3(xdr, fattr);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -734,8 +693,8 @@ static int decode_wcc_attr(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, NFS3_wcc_attr_sz << 2);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 
 	fattr->valid |= NFS_ATTR_FATTR_PRESIZE
 		| NFS_ATTR_FATTR_PRECHANGE
@@ -748,9 +707,6 @@ static int decode_wcc_attr(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 	fattr->pre_change_attr = nfs_timespec_to_change_attr(&fattr->pre_ctime);
 
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -774,14 +730,11 @@ static int decode_pre_op_attr(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	if (*p != xdr_zero)
 		return decode_wcc_attr(xdr, fattr);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_wcc_data(struct xdr_stream *xdr, struct nfs_fattr *fattr)
@@ -809,15 +762,12 @@ static int decode_wcc_data(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 static int decode_post_op_fh3(struct xdr_stream *xdr, struct nfs_fh *fh)
 {
 	__be32 *p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	if (*p != xdr_zero)
 		return decode_nfs_fh3(xdr, fh);
 	zero_nfs_fh3(fh);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -1641,8 +1591,8 @@ static int decode_read3resok(struct xdr_stream *xdr,
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4 + 4 + 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	count = be32_to_cpup(p++);
 	eof = be32_to_cpup(p++);
 	ocount = be32_to_cpup(p++);
@@ -1665,9 +1615,6 @@ static int decode_read3resok(struct xdr_stream *xdr,
 	count = recvd;
 	eof = 0;
 	goto out;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int nfs3_xdr_dec_read3res(struct rpc_rqst *req, struct xdr_stream *xdr,
@@ -1726,22 +1673,18 @@ static int decode_write3resok(struct xdr_stream *xdr,
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4 + 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	result->count = be32_to_cpup(p++);
 	result->verf->committed = be32_to_cpup(p++);
 	if (unlikely(result->verf->committed > NFS_FILE_SYNC))
 		goto out_badvalue;
 	if (decode_writeverf3(xdr, &result->verf->verifier))
-		goto out_eio;
+		return -EIO;
 	return result->count;
 out_badvalue:
 	dprintk("NFS: bad stable_how value: %u\n", result->verf->committed);
 	return -EIO;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-out_eio:
-	return -EIO;
 }
 
 static int nfs3_xdr_dec_write3res(struct rpc_rqst *req, struct xdr_stream *xdr,
@@ -2005,12 +1948,12 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	u64 new_cookie;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EAGAIN;
 	if (*p == xdr_zero) {
 		p = xdr_inline_decode(xdr, 4);
-		if (unlikely(p == NULL))
-			goto out_overflow;
+		if (unlikely(!p))
+			return -EAGAIN;
 		if (*p == xdr_zero)
 			return -EAGAIN;
 		entry->eof = 1;
@@ -2046,8 +1989,8 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 		/* In fact, a post_op_fh3: */
 		p = xdr_inline_decode(xdr, 4);
-		if (unlikely(p == NULL))
-			goto out_overflow;
+		if (unlikely(!p))
+			return -EAGAIN;
 		if (*p != xdr_zero) {
 			error = decode_nfs_fh3(xdr, entry->fh);
 			if (unlikely(error)) {
@@ -2064,9 +2007,6 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 	return 0;
 
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EAGAIN;
 out_truncated:
 	dprintk("NFS: directory entry contains invalid file handle\n");
 	*entry = old;
@@ -2178,8 +2118,8 @@ static int decode_fsstat3resok(struct xdr_stream *xdr,
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 8 * 6 + 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	p = xdr_decode_size3(p, &result->tbytes);
 	p = xdr_decode_size3(p, &result->fbytes);
 	p = xdr_decode_size3(p, &result->abytes);
@@ -2188,9 +2128,6 @@ static int decode_fsstat3resok(struct xdr_stream *xdr,
 	xdr_decode_size3(p, &result->afiles);
 	/* ignore invarsec */
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int nfs3_xdr_dec_fsstat3res(struct rpc_rqst *req,
@@ -2250,8 +2187,8 @@ static int decode_fsinfo3resok(struct xdr_stream *xdr,
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4 * 7 + 8 + 8 + 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	result->rtmax  = be32_to_cpup(p++);
 	result->rtpref = be32_to_cpup(p++);
 	result->rtmult = be32_to_cpup(p++);
@@ -2265,9 +2202,6 @@ static int decode_fsinfo3resok(struct xdr_stream *xdr,
 	/* ignore properties */
 	result->lease_time = 0;
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int nfs3_xdr_dec_fsinfo3res(struct rpc_rqst *req,
@@ -2323,15 +2257,12 @@ static int decode_pathconf3resok(struct xdr_stream *xdr,
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4 * 6);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	result->max_link = be32_to_cpup(p++);
 	result->max_namelen = be32_to_cpup(p);
 	/* ignore remaining fields */
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int nfs3_xdr_dec_pathconf3res(struct rpc_rqst *req,
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index eee011de3f58..d66e1025b4a4 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -404,7 +404,7 @@ static int decode_write_response(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	count = be32_to_cpup(p);
 	if (count > 1)
 		return -EREMOTEIO;
@@ -412,18 +412,14 @@ static int decode_write_response(struct xdr_stream *xdr,
 		status = decode_opaque_fixed(xdr, &res->stateid,
 				NFS4_STATEID_SIZE);
 		if (unlikely(status))
-			goto out_overflow;
+			return -EIO;
 	}
 	p = xdr_inline_decode(xdr, 8 + 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	p = xdr_decode_hyper(p, &res->count);
 	res->verifier.committed = be32_to_cpup(p);
 	return decode_verifier(xdr, &res->verifier.verifier);
-
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_copy_requirements(struct xdr_stream *xdr,
@@ -432,14 +428,11 @@ static int decode_copy_requirements(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 4 + 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 
 	res->consecutive = be32_to_cpup(p++);
 	res->synchronous = be32_to_cpup(p++);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_copy(struct xdr_stream *xdr, struct nfs42_copy_res *res)
@@ -484,15 +477,11 @@ static int decode_seek(struct xdr_stream *xdr, struct nfs42_seek_res *res)
 
 	p = xdr_inline_decode(xdr, 4 + 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 
 	res->sr_eof = be32_to_cpup(p++);
 	p = xdr_decode_hyper(p, &res->sr_offset);
 	return 0;
-
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_layoutstats(struct xdr_stream *xdr)
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f0f0fb7499e3..e337494a6da7 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1892,6 +1892,7 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
 				set_bit(ops->owner_flag_bit, &sp->so_flags);
 				nfs4_put_state_owner(sp);
 				status = nfs4_recovery_handle_error(clp, status);
+				nfs4_free_state_owners(&freeme);
 				return (status != 0) ? status : -EAGAIN;
 			}
 
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index f0021e3b8efd..767448b015cf 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -3144,22 +3144,12 @@ static void nfs4_xdr_enc_free_stateid(struct rpc_rqst *req,
 }
 #endif /* CONFIG_NFS_V4_1 */
 
-static void print_overflow_msg(const char *func, const struct xdr_stream *xdr)
-{
-	dprintk("nfs: %s: prematurely hit end of receive buffer. "
-		"Remaining buffer length is %tu words.\n",
-		func, xdr->end - xdr->p);
-}
-
 static int decode_opaque_inline(struct xdr_stream *xdr, unsigned int *len, char **string)
 {
 	ssize_t ret = xdr_stream_decode_opaque_inline(xdr, (void **)string,
 			NFS4_OPAQUE_LIMIT);
-	if (unlikely(ret < 0)) {
-		if (ret == -EBADMSG)
-			print_overflow_msg(__func__, xdr);
+	if (unlikely(ret < 0))
 		return -EIO;
-	}
 	*len = ret;
 	return 0;
 }
@@ -3170,22 +3160,19 @@ static int decode_compound_hdr(struct xdr_stream *xdr, struct compound_hdr *hdr)
 
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	hdr->status = be32_to_cpup(p++);
 	hdr->taglen = be32_to_cpup(p);
 
 	p = xdr_inline_decode(xdr, hdr->taglen + 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	hdr->tag = (char *)p;
 	p += XDR_QUADLEN(hdr->taglen);
 	hdr->nops = be32_to_cpup(p);
 	if (unlikely(hdr->nops < 1))
 		return nfs4_stat_to_errno(hdr->status);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static bool __decode_op_hdr(struct xdr_stream *xdr, enum nfs_opnum4 expected,
@@ -3214,7 +3201,6 @@ static bool __decode_op_hdr(struct xdr_stream *xdr, enum nfs_opnum4 expected,
 	*nfs_retval = -EREMOTEIO;
 	return false;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	*nfs_retval = -EIO;
 	return false;
 }
@@ -3235,10 +3221,9 @@ static int decode_ace(struct xdr_stream *xdr, void *ace)
 	char *str;
 
 	p = xdr_inline_decode(xdr, 12);
-	if (likely(p))
-		return decode_opaque_inline(xdr, &strlen, &str);
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
+	if (unlikely(!p))
+		return -EIO;
+	return decode_opaque_inline(xdr, &strlen, &str);
 }
 
 static ssize_t
@@ -3249,10 +3234,9 @@ decode_bitmap4(struct xdr_stream *xdr, uint32_t *bitmap, size_t sz)
 	ret = xdr_stream_decode_uint32_array(xdr, bitmap, sz);
 	if (likely(ret >= 0))
 		return ret;
-	if (ret == -EMSGSIZE)
-		return sz;
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
+	if (ret != -EMSGSIZE)
+		return -EIO;
+	return sz;
 }
 
 static int decode_attr_bitmap(struct xdr_stream *xdr, uint32_t *bitmap)
@@ -3268,13 +3252,10 @@ static int decode_attr_length(struct xdr_stream *xdr, uint32_t *attrlen, unsigne
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	*attrlen = be32_to_cpup(p);
 	*savep = xdr_stream_pos(xdr);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_supported(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *bitmask)
@@ -3303,7 +3284,7 @@ static int decode_attr_type(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *
 	if (likely(bitmap[0] & FATTR4_WORD0_TYPE)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*type = be32_to_cpup(p);
 		if (*type < NF4REG || *type > NF4NAMEDATTR) {
 			dprintk("%s: bad type %d\n", __func__, *type);
@@ -3314,9 +3295,6 @@ static int decode_attr_type(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *
 	}
 	dprintk("%s: type=0%o\n", __func__, nfs_type2fmt[*type]);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_fh_expire_type(struct xdr_stream *xdr,
@@ -3330,15 +3308,12 @@ static int decode_attr_fh_expire_type(struct xdr_stream *xdr,
 	if (likely(bitmap[0] & FATTR4_WORD0_FH_EXPIRE_TYPE)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*type = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_FH_EXPIRE_TYPE;
 	}
 	dprintk("%s: expire type=0x%x\n", __func__, *type);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_change(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *change)
@@ -3352,7 +3327,7 @@ static int decode_attr_change(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t
 	if (likely(bitmap[0] & FATTR4_WORD0_CHANGE)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, change);
 		bitmap[0] &= ~FATTR4_WORD0_CHANGE;
 		ret = NFS_ATTR_FATTR_CHANGE;
@@ -3360,9 +3335,6 @@ static int decode_attr_change(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t
 	dprintk("%s: change attribute=%Lu\n", __func__,
 			(unsigned long long)*change);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_size(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *size)
@@ -3376,16 +3348,13 @@ static int decode_attr_size(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *
 	if (likely(bitmap[0] & FATTR4_WORD0_SIZE)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, size);
 		bitmap[0] &= ~FATTR4_WORD0_SIZE;
 		ret = NFS_ATTR_FATTR_SIZE;
 	}
 	dprintk("%s: file size=%Lu\n", __func__, (unsigned long long)*size);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_link_support(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
@@ -3398,15 +3367,12 @@ static int decode_attr_link_support(struct xdr_stream *xdr, uint32_t *bitmap, ui
 	if (likely(bitmap[0] & FATTR4_WORD0_LINK_SUPPORT)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*res = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_LINK_SUPPORT;
 	}
 	dprintk("%s: link support=%s\n", __func__, *res == 0 ? "false" : "true");
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_symlink_support(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
@@ -3419,15 +3385,12 @@ static int decode_attr_symlink_support(struct xdr_stream *xdr, uint32_t *bitmap,
 	if (likely(bitmap[0] & FATTR4_WORD0_SYMLINK_SUPPORT)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*res = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_SYMLINK_SUPPORT;
 	}
 	dprintk("%s: symlink support=%s\n", __func__, *res == 0 ? "false" : "true");
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_fsid(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs_fsid *fsid)
@@ -3442,7 +3405,7 @@ static int decode_attr_fsid(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs
 	if (likely(bitmap[0] & FATTR4_WORD0_FSID)) {
 		p = xdr_inline_decode(xdr, 16);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		p = xdr_decode_hyper(p, &fsid->major);
 		xdr_decode_hyper(p, &fsid->minor);
 		bitmap[0] &= ~FATTR4_WORD0_FSID;
@@ -3452,9 +3415,6 @@ static int decode_attr_fsid(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs
 			(unsigned long long)fsid->major,
 			(unsigned long long)fsid->minor);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_lease_time(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
@@ -3467,15 +3427,12 @@ static int decode_attr_lease_time(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	if (likely(bitmap[0] & FATTR4_WORD0_LEASE_TIME)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*res = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_LEASE_TIME;
 	}
 	dprintk("%s: file size=%u\n", __func__, (unsigned int)*res);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_error(struct xdr_stream *xdr, uint32_t *bitmap, int32_t *res)
@@ -3487,14 +3444,11 @@ static int decode_attr_error(struct xdr_stream *xdr, uint32_t *bitmap, int32_t *
 	if (likely(bitmap[0] & FATTR4_WORD0_RDATTR_ERROR)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		bitmap[0] &= ~FATTR4_WORD0_RDATTR_ERROR;
 		*res = -be32_to_cpup(p);
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_exclcreat_supported(struct xdr_stream *xdr,
@@ -3526,13 +3480,13 @@ static int decode_attr_filehandle(struct xdr_stream *xdr, uint32_t *bitmap, stru
 	if (likely(bitmap[0] & FATTR4_WORD0_FILEHANDLE)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		len = be32_to_cpup(p);
 		if (len > NFS4_FHSIZE)
 			return -EIO;
 		p = xdr_inline_decode(xdr, len);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		if (fh != NULL) {
 			memcpy(fh->data, p, len);
 			fh->size = len;
@@ -3540,9 +3494,6 @@ static int decode_attr_filehandle(struct xdr_stream *xdr, uint32_t *bitmap, stru
 		bitmap[0] &= ~FATTR4_WORD0_FILEHANDLE;
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_aclsupport(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
@@ -3555,15 +3506,12 @@ static int decode_attr_aclsupport(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	if (likely(bitmap[0] & FATTR4_WORD0_ACLSUPPORT)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*res = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_ACLSUPPORT;
 	}
 	dprintk("%s: ACLs supported=%u\n", __func__, (unsigned int)*res);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_fileid(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *fileid)
@@ -3577,16 +3525,13 @@ static int decode_attr_fileid(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t
 	if (likely(bitmap[0] & FATTR4_WORD0_FILEID)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, fileid);
 		bitmap[0] &= ~FATTR4_WORD0_FILEID;
 		ret = NFS_ATTR_FATTR_FILEID;
 	}
 	dprintk("%s: fileid=%Lu\n", __func__, (unsigned long long)*fileid);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_mounted_on_fileid(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *fileid)
@@ -3600,16 +3545,13 @@ static int decode_attr_mounted_on_fileid(struct xdr_stream *xdr, uint32_t *bitma
 	if (likely(bitmap[1] & FATTR4_WORD1_MOUNTED_ON_FILEID)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, fileid);
 		bitmap[1] &= ~FATTR4_WORD1_MOUNTED_ON_FILEID;
 		ret = NFS_ATTR_FATTR_MOUNTED_ON_FILEID;
 	}
 	dprintk("%s: fileid=%Lu\n", __func__, (unsigned long long)*fileid);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_files_avail(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
@@ -3623,15 +3565,12 @@ static int decode_attr_files_avail(struct xdr_stream *xdr, uint32_t *bitmap, uin
 	if (likely(bitmap[0] & FATTR4_WORD0_FILES_AVAIL)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 		bitmap[0] &= ~FATTR4_WORD0_FILES_AVAIL;
 	}
 	dprintk("%s: files avail=%Lu\n", __func__, (unsigned long long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_files_free(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
@@ -3645,15 +3584,12 @@ static int decode_attr_files_free(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	if (likely(bitmap[0] & FATTR4_WORD0_FILES_FREE)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 		bitmap[0] &= ~FATTR4_WORD0_FILES_FREE;
 	}
 	dprintk("%s: files free=%Lu\n", __func__, (unsigned long long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_files_total(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
@@ -3667,15 +3603,12 @@ static int decode_attr_files_total(struct xdr_stream *xdr, uint32_t *bitmap, uin
 	if (likely(bitmap[0] & FATTR4_WORD0_FILES_TOTAL)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 		bitmap[0] &= ~FATTR4_WORD0_FILES_TOTAL;
 	}
 	dprintk("%s: files total=%Lu\n", __func__, (unsigned long long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_pathname(struct xdr_stream *xdr, struct nfs4_pathname *path)
@@ -3686,7 +3619,7 @@ static int decode_pathname(struct xdr_stream *xdr, struct nfs4_pathname *path)
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	n = be32_to_cpup(p);
 	if (n == 0)
 		goto root_path;
@@ -3718,9 +3651,6 @@ static int decode_pathname(struct xdr_stream *xdr, struct nfs4_pathname *path)
 	dprintk(" status %d", status);
 	status = -EIO;
 	goto out;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_fs_locations(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs4_fs_locations *res)
@@ -3745,7 +3675,7 @@ static int decode_attr_fs_locations(struct xdr_stream *xdr, uint32_t *bitmap, st
 		goto out;
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		goto out_eio;
 	n = be32_to_cpup(p);
 	for (res->nlocations = 0; res->nlocations < n; res->nlocations++) {
 		u32 m;
@@ -3756,7 +3686,7 @@ static int decode_attr_fs_locations(struct xdr_stream *xdr, uint32_t *bitmap, st
 		loc = &res->locations[res->nlocations];
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			goto out_eio;
 		m = be32_to_cpup(p);
 
 		dprintk("%s: servers:\n", __func__);
@@ -3794,8 +3724,6 @@ static int decode_attr_fs_locations(struct xdr_stream *xdr, uint32_t *bitmap, st
 out:
 	dprintk("%s: fs_locations done, error = %d\n", __func__, status);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
 out_eio:
 	status = -EIO;
 	goto out;
@@ -3812,15 +3740,12 @@ static int decode_attr_maxfilesize(struct xdr_stream *xdr, uint32_t *bitmap, uin
 	if (likely(bitmap[0] & FATTR4_WORD0_MAXFILESIZE)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 		bitmap[0] &= ~FATTR4_WORD0_MAXFILESIZE;
 	}
 	dprintk("%s: maxfilesize=%Lu\n", __func__, (unsigned long long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_maxlink(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *maxlink)
@@ -3834,15 +3759,12 @@ static int decode_attr_maxlink(struct xdr_stream *xdr, uint32_t *bitmap, uint32_
 	if (likely(bitmap[0] & FATTR4_WORD0_MAXLINK)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*maxlink = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_MAXLINK;
 	}
 	dprintk("%s: maxlink=%u\n", __func__, *maxlink);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_maxname(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *maxname)
@@ -3856,15 +3778,12 @@ static int decode_attr_maxname(struct xdr_stream *xdr, uint32_t *bitmap, uint32_
 	if (likely(bitmap[0] & FATTR4_WORD0_MAXNAME)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*maxname = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_MAXNAME;
 	}
 	dprintk("%s: maxname=%u\n", __func__, *maxname);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_maxread(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
@@ -3879,7 +3798,7 @@ static int decode_attr_maxread(struct xdr_stream *xdr, uint32_t *bitmap, uint32_
 		uint64_t maxread;
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, &maxread);
 		if (maxread > 0x7FFFFFFF)
 			maxread = 0x7FFFFFFF;
@@ -3888,9 +3807,6 @@ static int decode_attr_maxread(struct xdr_stream *xdr, uint32_t *bitmap, uint32_
 	}
 	dprintk("%s: maxread=%lu\n", __func__, (unsigned long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_maxwrite(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
@@ -3905,7 +3821,7 @@ static int decode_attr_maxwrite(struct xdr_stream *xdr, uint32_t *bitmap, uint32
 		uint64_t maxwrite;
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, &maxwrite);
 		if (maxwrite > 0x7FFFFFFF)
 			maxwrite = 0x7FFFFFFF;
@@ -3914,9 +3830,6 @@ static int decode_attr_maxwrite(struct xdr_stream *xdr, uint32_t *bitmap, uint32
 	}
 	dprintk("%s: maxwrite=%lu\n", __func__, (unsigned long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_mode(struct xdr_stream *xdr, uint32_t *bitmap, umode_t *mode)
@@ -3931,7 +3844,7 @@ static int decode_attr_mode(struct xdr_stream *xdr, uint32_t *bitmap, umode_t *m
 	if (likely(bitmap[1] & FATTR4_WORD1_MODE)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		tmp = be32_to_cpup(p);
 		*mode = tmp & ~S_IFMT;
 		bitmap[1] &= ~FATTR4_WORD1_MODE;
@@ -3939,9 +3852,6 @@ static int decode_attr_mode(struct xdr_stream *xdr, uint32_t *bitmap, umode_t *m
 	}
 	dprintk("%s: file mode=0%o\n", __func__, (unsigned int)*mode);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_nlink(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *nlink)
@@ -3955,16 +3865,13 @@ static int decode_attr_nlink(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t
 	if (likely(bitmap[1] & FATTR4_WORD1_NUMLINKS)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*nlink = be32_to_cpup(p);
 		bitmap[1] &= ~FATTR4_WORD1_NUMLINKS;
 		ret = NFS_ATTR_FATTR_NLINK;
 	}
 	dprintk("%s: nlink=%u\n", __func__, (unsigned int)*nlink);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static ssize_t decode_nfs4_string(struct xdr_stream *xdr,
@@ -4009,10 +3916,9 @@ static int decode_attr_owner(struct xdr_stream *xdr, uint32_t *bitmap,
 		return NFS_ATTR_FATTR_OWNER;
 	}
 out:
-	if (len != -EBADMSG)
-		return 0;
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
+	if (len == -EBADMSG)
+		return -EIO;
+	return 0;
 }
 
 static int decode_attr_group(struct xdr_stream *xdr, uint32_t *bitmap,
@@ -4044,10 +3950,9 @@ static int decode_attr_group(struct xdr_stream *xdr, uint32_t *bitmap,
 		return NFS_ATTR_FATTR_GROUP;
 	}
 out:
-	if (len != -EBADMSG)
-		return 0;
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
+	if (len == -EBADMSG)
+		return -EIO;
+	return 0;
 }
 
 static int decode_attr_rdev(struct xdr_stream *xdr, uint32_t *bitmap, dev_t *rdev)
@@ -4064,7 +3969,7 @@ static int decode_attr_rdev(struct xdr_stream *xdr, uint32_t *bitmap, dev_t *rde
 
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		major = be32_to_cpup(p++);
 		minor = be32_to_cpup(p);
 		tmp = MKDEV(major, minor);
@@ -4075,9 +3980,6 @@ static int decode_attr_rdev(struct xdr_stream *xdr, uint32_t *bitmap, dev_t *rde
 	}
 	dprintk("%s: rdev=(0x%x:0x%x)\n", __func__, major, minor);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_space_avail(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
@@ -4091,15 +3993,12 @@ static int decode_attr_space_avail(struct xdr_stream *xdr, uint32_t *bitmap, uin
 	if (likely(bitmap[1] & FATTR4_WORD1_SPACE_AVAIL)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 		bitmap[1] &= ~FATTR4_WORD1_SPACE_AVAIL;
 	}
 	dprintk("%s: space avail=%Lu\n", __func__, (unsigned long long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_space_free(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
@@ -4113,15 +4012,12 @@ static int decode_attr_space_free(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	if (likely(bitmap[1] & FATTR4_WORD1_SPACE_FREE)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 		bitmap[1] &= ~FATTR4_WORD1_SPACE_FREE;
 	}
 	dprintk("%s: space free=%Lu\n", __func__, (unsigned long long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_space_total(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
@@ -4135,15 +4031,12 @@ static int decode_attr_space_total(struct xdr_stream *xdr, uint32_t *bitmap, uin
 	if (likely(bitmap[1] & FATTR4_WORD1_SPACE_TOTAL)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 		bitmap[1] &= ~FATTR4_WORD1_SPACE_TOTAL;
 	}
 	dprintk("%s: space total=%Lu\n", __func__, (unsigned long long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_space_used(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *used)
@@ -4157,7 +4050,7 @@ static int decode_attr_space_used(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	if (likely(bitmap[1] & FATTR4_WORD1_SPACE_USED)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, used);
 		bitmap[1] &= ~FATTR4_WORD1_SPACE_USED;
 		ret = NFS_ATTR_FATTR_SPACE_USED;
@@ -4165,9 +4058,6 @@ static int decode_attr_space_used(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	dprintk("%s: space used=%Lu\n", __func__,
 			(unsigned long long)*used);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static __be32 *
@@ -4187,12 +4077,9 @@ static int decode_attr_time(struct xdr_stream *xdr, struct timespec *time)
 
 	p = xdr_inline_decode(xdr, nfstime4_maxsz << 2);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	xdr_decode_nfstime4(p, time);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_time_access(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec *time)
@@ -4263,19 +4150,19 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 	if (likely(bitmap[2] & FATTR4_WORD2_SECURITY_LABEL)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		lfs = be32_to_cpup(p++);
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		pi = be32_to_cpup(p++);
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		len = be32_to_cpup(p++);
 		p = xdr_inline_decode(xdr, len);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		if (len < NFS4_MAXLABELLEN) {
 			if (label && label->len) {
 				if (label->len < len)
@@ -4296,10 +4183,6 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 				label->len, label->pi, label->lfs);
 	}
 	return status;
-
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_time_modify(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec *time)
@@ -4343,14 +4226,11 @@ static int decode_change_info(struct xdr_stream *xdr, struct nfs4_change_info *c
 
 	p = xdr_inline_decode(xdr, 20);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	cinfo->atomic = be32_to_cpup(p++);
 	p = xdr_decode_hyper(p, &cinfo->before);
 	xdr_decode_hyper(p, &cinfo->after);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_access(struct xdr_stream *xdr, u32 *supported, u32 *access)
@@ -4364,24 +4244,19 @@ static int decode_access(struct xdr_stream *xdr, u32 *supported, u32 *access)
 		return status;
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	supp = be32_to_cpup(p++);
 	acc = be32_to_cpup(p);
 	*supported = supp;
 	*access = acc;
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_opaque_fixed(struct xdr_stream *xdr, void *buf, size_t len)
 {
 	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
-	if (unlikely(ret < 0)) {
-		print_overflow_msg(__func__, xdr);
+	if (unlikely(ret < 0))
 		return -EIO;
-	}
 	return 0;
 }
 
@@ -4464,13 +4339,11 @@ static int decode_create(struct xdr_stream *xdr, struct nfs4_change_info *cinfo)
 		return status;
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	bmlen = be32_to_cpup(p);
 	p = xdr_inline_decode(xdr, bmlen << 2);
 	if (likely(p))
 		return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
@@ -4578,13 +4451,10 @@ static int decode_threshold_hint(struct xdr_stream *xdr,
 	if (likely(bitmap[0] & hint_bit)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_first_threshold_item4(struct xdr_stream *xdr,
@@ -4597,10 +4467,8 @@ static int decode_first_threshold_item4(struct xdr_stream *xdr,
 
 	/* layout type */
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(!p)) {
-		print_overflow_msg(__func__, xdr);
+	if (unlikely(!p))
 		return -EIO;
-	}
 	res->l_type = be32_to_cpup(p);
 
 	/* thi_hintset bitmap */
@@ -4658,7 +4526,7 @@ static int decode_attr_mdsthreshold(struct xdr_stream *xdr,
 			return -EREMOTEIO;
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		num = be32_to_cpup(p);
 		if (num == 0)
 			return 0;
@@ -4671,9 +4539,6 @@ static int decode_attr_mdsthreshold(struct xdr_stream *xdr,
 		bitmap[2] &= ~FATTR4_WORD2_MDSTHRESHOLD;
 	}
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
@@ -4861,7 +4726,7 @@ static int decode_pnfs_layout_types(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	fsinfo->nlayouttypes = be32_to_cpup(p);
 
 	/* pNFS is not supported by the underlying file system */
@@ -4871,7 +4736,7 @@ static int decode_pnfs_layout_types(struct xdr_stream *xdr,
 	/* Decode and set first layout type, move xdr->p past unused types */
 	p = xdr_inline_decode(xdr, fsinfo->nlayouttypes * 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 
 	/* If we get too many, then just cap it at the max */
 	if (fsinfo->nlayouttypes > NFS_MAX_LAYOUT_TYPES) {
@@ -4883,9 +4748,6 @@ static int decode_pnfs_layout_types(struct xdr_stream *xdr,
 	for(i = 0; i < fsinfo->nlayouttypes; ++i)
 		fsinfo->layouttype[i] = be32_to_cpup(p++);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -4919,10 +4781,8 @@ static int decode_attr_layout_blksize(struct xdr_stream *xdr, uint32_t *bitmap,
 	*res = 0;
 	if (bitmap[2] & FATTR4_WORD2_LAYOUT_BLKSIZE) {
 		p = xdr_inline_decode(xdr, 4);
-		if (unlikely(!p)) {
-			print_overflow_msg(__func__, xdr);
+		if (unlikely(!p))
 			return -EIO;
-		}
 		*res = be32_to_cpup(p);
 		bitmap[2] &= ~FATTR4_WORD2_LAYOUT_BLKSIZE;
 	}
@@ -4941,10 +4801,8 @@ static int decode_attr_clone_blksize(struct xdr_stream *xdr, uint32_t *bitmap,
 	*res = 0;
 	if (bitmap[2] & FATTR4_WORD2_CLONE_BLKSIZE) {
 		p = xdr_inline_decode(xdr, 4);
-		if (unlikely(!p)) {
-			print_overflow_msg(__func__, xdr);
+		if (unlikely(!p))
 			return -EIO;
-		}
 		*res = be32_to_cpup(p);
 		bitmap[2] &= ~FATTR4_WORD2_CLONE_BLKSIZE;
 	}
@@ -5020,19 +4878,16 @@ static int decode_getfh(struct xdr_stream *xdr, struct nfs_fh *fh)
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	len = be32_to_cpup(p);
 	if (len > NFS4_FHSIZE)
 		return -EIO;
 	fh->size = len;
 	p = xdr_inline_decode(xdr, len);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	memcpy(fh->data, p, len);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_link(struct xdr_stream *xdr, struct nfs4_change_info *cinfo)
@@ -5056,7 +4911,7 @@ static int decode_lock_denied (struct xdr_stream *xdr, struct file_lock *fl)
 
 	p = xdr_inline_decode(xdr, 32); /* read 32 bytes */
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	p = xdr_decode_hyper(p, &offset); /* read 2 8-byte long words */
 	p = xdr_decode_hyper(p, &length);
 	type = be32_to_cpup(p++); /* 4 byte read */
@@ -5073,11 +4928,9 @@ static int decode_lock_denied (struct xdr_stream *xdr, struct file_lock *fl)
 	p = xdr_decode_hyper(p, &clientid); /* read 8 bytes */
 	namelen = be32_to_cpup(p); /* read 4 bytes */  /* have read all 32 bytes now */
 	p = xdr_inline_decode(xdr, namelen); /* variable size field */
-	if (likely(p))
-		return -NFS4ERR_DENIED;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
+	if (likely(!p))
+		return -EIO;
+	return -NFS4ERR_DENIED;
 }
 
 static int decode_lock(struct xdr_stream *xdr, struct nfs_lock_res *res)
@@ -5146,7 +4999,7 @@ static int decode_space_limit(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 12);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	limit_type = be32_to_cpup(p++);
 	switch (limit_type) {
 	case NFS4_LIMIT_SIZE:
@@ -5160,9 +5013,6 @@ static int decode_space_limit(struct xdr_stream *xdr,
 	maxsize >>= PAGE_SHIFT;
 	*pagemod_limit = min_t(u64, maxsize, ULONG_MAX);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_rw_delegation(struct xdr_stream *xdr,
@@ -5177,7 +5027,7 @@ static int decode_rw_delegation(struct xdr_stream *xdr,
 		return status;
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	res->do_recall = be32_to_cpup(p);
 
 	switch (delegation_type) {
@@ -5190,9 +5040,6 @@ static int decode_rw_delegation(struct xdr_stream *xdr,
 				return -EIO;
 	}
 	return decode_ace(xdr, NULL);
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_no_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
@@ -5202,7 +5049,7 @@ static int decode_no_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	why_no_delegation = be32_to_cpup(p);
 	switch (why_no_delegation) {
 		case WND4_CONTENTION:
@@ -5211,9 +5058,6 @@ static int decode_no_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
 			/* Ignore for now */
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
@@ -5223,7 +5067,7 @@ static int decode_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	delegation_type = be32_to_cpup(p);
 	res->delegation_type = 0;
 	switch (delegation_type) {
@@ -5236,9 +5080,6 @@ static int decode_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
 		return decode_no_delegation(xdr, res);
 	}
 	return -EIO;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_open(struct xdr_stream *xdr, struct nfs_openres *res)
@@ -5260,7 +5101,7 @@ static int decode_open(struct xdr_stream *xdr, struct nfs_openres *res)
 
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	res->rflags = be32_to_cpup(p++);
 	bmlen = be32_to_cpup(p);
 	if (bmlen > 10)
@@ -5268,7 +5109,7 @@ static int decode_open(struct xdr_stream *xdr, struct nfs_openres *res)
 
 	p = xdr_inline_decode(xdr, bmlen << 2);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	savewords = min_t(uint32_t, bmlen, NFS4_BITMAP_SIZE);
 	for (i = 0; i < savewords; ++i)
 		res->attrset[i] = be32_to_cpup(p++);
@@ -5279,9 +5120,6 @@ static int decode_open(struct xdr_stream *xdr, struct nfs_openres *res)
 xdr_error:
 	dprintk("%s: Bitmap too large! Length = %u\n", __func__, bmlen);
 	return -EIO;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_open_confirm(struct xdr_stream *xdr, struct nfs_open_confirmres *res)
@@ -5330,7 +5168,7 @@ static int decode_read(struct xdr_stream *xdr, struct rpc_rqst *req,
 		return status;
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	eof = be32_to_cpup(p++);
 	count = be32_to_cpup(p);
 	recvd = xdr_read_pages(xdr, count);
@@ -5343,9 +5181,6 @@ static int decode_read(struct xdr_stream *xdr, struct rpc_rqst *req,
 	res->eof = eof;
 	res->count = count;
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_readdir(struct xdr_stream *xdr, struct rpc_rqst *req, struct nfs4_readdir_res *readdir)
@@ -5378,7 +5213,7 @@ static int decode_readlink(struct xdr_stream *xdr, struct rpc_rqst *req)
 	/* Convert length of symlink */
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	len = be32_to_cpup(p);
 	if (len >= rcvbuf->page_len || len <= 0) {
 		dprintk("nfs: server returned giant symlink!\n");
@@ -5399,9 +5234,6 @@ static int decode_readlink(struct xdr_stream *xdr, struct rpc_rqst *req)
 	 */
 	xdr_terminate_string(rcvbuf, len);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_remove(struct xdr_stream *xdr, struct nfs4_change_info *cinfo)
@@ -5504,7 +5336,6 @@ static int decode_setattr(struct xdr_stream *xdr)
 		return status;
 	if (decode_bitmap4(xdr, NULL, 0) >= 0)
 		return 0;
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
@@ -5516,7 +5347,7 @@ static int decode_setclientid(struct xdr_stream *xdr, struct nfs4_setclientid_re
 
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	opnum = be32_to_cpup(p++);
 	if (opnum != OP_SETCLIENTID) {
 		dprintk("nfs: decode_setclientid: Server returned operation"
@@ -5527,7 +5358,7 @@ static int decode_setclientid(struct xdr_stream *xdr, struct nfs4_setclientid_re
 	if (nfserr == NFS_OK) {
 		p = xdr_inline_decode(xdr, 8 + NFS4_VERIFIER_SIZE);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		p = xdr_decode_hyper(p, &res->clientid);
 		memcpy(res->confirm.data, p, NFS4_VERIFIER_SIZE);
 	} else if (nfserr == NFSERR_CLID_INUSE) {
@@ -5536,28 +5367,25 @@ static int decode_setclientid(struct xdr_stream *xdr, struct nfs4_setclientid_re
 		/* skip netid string */
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		len = be32_to_cpup(p);
 		p = xdr_inline_decode(xdr, len);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 
 		/* skip uaddr string */
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		len = be32_to_cpup(p);
 		p = xdr_inline_decode(xdr, len);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		return -NFSERR_CLID_INUSE;
 	} else
 		return nfs4_stat_to_errno(nfserr);
 
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_setclientid_confirm(struct xdr_stream *xdr)
@@ -5576,13 +5404,10 @@ static int decode_write(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	res->count = be32_to_cpup(p++);
 	res->verf->committed = be32_to_cpup(p++);
 	return decode_write_verifier(xdr, &res->verf->verifier);
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_delegreturn(struct xdr_stream *xdr)
@@ -5598,30 +5423,24 @@ static int decode_secinfo_gss(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	oid_len = be32_to_cpup(p);
 	if (oid_len > GSS_OID_MAX_LEN)
-		goto out_err;
+		return -EINVAL;
 
 	p = xdr_inline_decode(xdr, oid_len);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	memcpy(flavor->flavor_info.oid.data, p, oid_len);
 	flavor->flavor_info.oid.len = oid_len;
 
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	flavor->flavor_info.qop = be32_to_cpup(p++);
 	flavor->flavor_info.service = be32_to_cpup(p);
 
 	return 0;
-
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
-out_err:
-	return -EINVAL;
 }
 
 static int decode_secinfo_common(struct xdr_stream *xdr, struct nfs4_secinfo_res *res)
@@ -5633,7 +5452,7 @@ static int decode_secinfo_common(struct xdr_stream *xdr, struct nfs4_secinfo_res
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 
 	res->flavors->num_flavors = 0;
 	num_flavors = be32_to_cpup(p);
@@ -5645,7 +5464,7 @@ static int decode_secinfo_common(struct xdr_stream *xdr, struct nfs4_secinfo_res
 
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		sec_flavor->flavor = be32_to_cpup(p);
 
 		if (sec_flavor->flavor == RPC_AUTH_GSS) {
@@ -5659,9 +5478,6 @@ static int decode_secinfo_common(struct xdr_stream *xdr, struct nfs4_secinfo_res
 	status = 0;
 out:
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_secinfo(struct xdr_stream *xdr, struct nfs4_secinfo_res *res)
@@ -5715,11 +5531,11 @@ static int decode_exchange_id(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	xdr_decode_hyper(p, &res->clientid);
 	p = xdr_inline_decode(xdr, 12);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	res->seqid = be32_to_cpup(p++);
 	res->flags = be32_to_cpup(p++);
 
@@ -5743,7 +5559,7 @@ static int decode_exchange_id(struct xdr_stream *xdr,
 	/* server_owner4.so_minor_id */
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	p = xdr_decode_hyper(p, &res->server_owner->minor_id);
 
 	/* server_owner4.so_major_id */
@@ -5763,7 +5579,7 @@ static int decode_exchange_id(struct xdr_stream *xdr,
 	/* Implementation Id */
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	impl_id_count = be32_to_cpup(p++);
 
 	if (impl_id_count) {
@@ -5782,16 +5598,13 @@ static int decode_exchange_id(struct xdr_stream *xdr,
 		/* nii_date */
 		p = xdr_inline_decode(xdr, 12);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		p = xdr_decode_hyper(p, &res->impl_id->date.seconds);
 		res->impl_id->date.nseconds = be32_to_cpup(p);
 
 		/* if there's more than one entry, ignore the rest */
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_chan_attrs(struct xdr_stream *xdr,
@@ -5802,7 +5615,7 @@ static int decode_chan_attrs(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 28);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	val = be32_to_cpup(p++);	/* headerpadsz */
 	if (val)
 		return -EINVAL;		/* no support for header padding yet */
@@ -5820,12 +5633,9 @@ static int decode_chan_attrs(struct xdr_stream *xdr,
 	if (nr_attrs == 1) {
 		p = xdr_inline_decode(xdr, 4); /* skip rdma_attrs */
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_sessionid(struct xdr_stream *xdr, struct nfs4_sessionid *sid)
@@ -5848,7 +5658,7 @@ static int decode_bind_conn_to_session(struct xdr_stream *xdr,
 	/* dir flags, rdma mode bool */
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 
 	res->dir = be32_to_cpup(p++);
 	if (res->dir == 0 || res->dir > NFS4_CDFS4_BOTH)
@@ -5859,9 +5669,6 @@ static int decode_bind_conn_to_session(struct xdr_stream *xdr,
 		res->use_conn_in_rdma_mode = true;
 
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_create_session(struct xdr_stream *xdr,
@@ -5879,7 +5686,7 @@ static int decode_create_session(struct xdr_stream *xdr,
 	/* seqid, flags */
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	res->seqid = be32_to_cpup(p++);
 	res->flags = be32_to_cpup(p);
 
@@ -5888,9 +5695,6 @@ static int decode_create_session(struct xdr_stream *xdr,
 	if (!status)
 		status = decode_chan_attrs(xdr, &res->bc_attrs);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_destroy_session(struct xdr_stream *xdr, void *dummy)
@@ -5971,7 +5775,6 @@ static int decode_sequence(struct xdr_stream *xdr,
 	res->sr_status = status;
 	return status;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	status = -EIO;
 	goto out_err;
 #else  /* CONFIG_NFS_V4_1 */
@@ -5999,7 +5802,7 @@ static int decode_getdeviceinfo(struct xdr_stream *xdr,
 		if (status == -ETOOSMALL) {
 			p = xdr_inline_decode(xdr, 4);
 			if (unlikely(!p))
-				goto out_overflow;
+				return -EIO;
 			pdev->mincount = be32_to_cpup(p);
 			dprintk("%s: Min count too small. mincnt = %u\n",
 				__func__, pdev->mincount);
@@ -6009,7 +5812,7 @@ static int decode_getdeviceinfo(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	type = be32_to_cpup(p++);
 	if (type != pdev->layout_type) {
 		dprintk("%s: layout mismatch req: %u pdev: %u\n",
@@ -6023,19 +5826,19 @@ static int decode_getdeviceinfo(struct xdr_stream *xdr,
 	 */
 	pdev->mincount = be32_to_cpup(p);
 	if (xdr_read_pages(xdr, pdev->mincount) != pdev->mincount)
-		goto out_overflow;
+		return -EIO;
 
 	/* Parse notification bitmap, verifying that it is zero. */
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	len = be32_to_cpup(p);
 	if (len) {
 		uint32_t i;
 
 		p = xdr_inline_decode(xdr, 4 * len);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 
 		res->notification = be32_to_cpup(p++);
 		for (i = 1; i < len; i++) {
@@ -6047,9 +5850,6 @@ static int decode_getdeviceinfo(struct xdr_stream *xdr,
 		}
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
@@ -6119,7 +5919,6 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 	res->status = status;
 	return status;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	status = -EIO;
 	goto out;
 }
@@ -6135,16 +5934,13 @@ static int decode_layoutreturn(struct xdr_stream *xdr,
 		return status;
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	res->lrs_present = be32_to_cpup(p);
 	if (res->lrs_present)
 		status = decode_layout_stateid(xdr, &res->stateid);
 	else
 		nfs4_stateid_copy(&res->stateid, &invalid_stateid);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_layoutcommit(struct xdr_stream *xdr,
@@ -6162,19 +5958,16 @@ static int decode_layoutcommit(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	sizechanged = be32_to_cpup(p);
 
 	if (sizechanged) {
 		/* throw away new size */
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_test_stateid(struct xdr_stream *xdr,
@@ -6190,21 +5983,17 @@ static int decode_test_stateid(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	num_res = be32_to_cpup(p++);
 	if (num_res != 1)
-		goto out;
+		return -EIO;
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	res->status = be32_to_cpup(p++);
 
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-out:
-	return -EIO;
 }
 
 static int decode_free_stateid(struct xdr_stream *xdr,
@@ -7574,11 +7363,11 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	uint64_t new_cookie;
 	__be32 *p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EAGAIN;
 	if (*p == xdr_zero) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EAGAIN;
 		if (*p == xdr_zero)
 			return -EAGAIN;
 		entry->eof = 1;
@@ -7587,13 +7376,13 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 	p = xdr_inline_decode(xdr, 12);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EAGAIN;
 	p = xdr_decode_hyper(p, &new_cookie);
 	entry->len = be32_to_cpup(p);
 
 	p = xdr_inline_decode(xdr, entry->len);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EAGAIN;
 	entry->name = (const char *) p;
 
 	/*
@@ -7605,14 +7394,14 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	entry->fattr->valid = 0;
 
 	if (decode_attr_bitmap(xdr, bitmap) < 0)
-		goto out_overflow;
+		return -EAGAIN;
 
 	if (decode_attr_length(xdr, &len, &savep) < 0)
-		goto out_overflow;
+		return -EAGAIN;
 
 	if (decode_getfattr_attrs(xdr, bitmap, entry->fattr, entry->fh,
 			NULL, entry->label, entry->server) < 0)
-		goto out_overflow;
+		return -EAGAIN;
 	if (entry->fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID)
 		entry->ino = entry->fattr->mounted_on_fileid;
 	else if (entry->fattr->valid & NFS_ATTR_FATTR_FILEID)
@@ -7626,10 +7415,6 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	entry->cookie = new_cookie;
 
 	return 0;
-
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EAGAIN;
 }
 
 /*
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 519d994c0c4c..e6c7448d3d89 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -59,16 +59,6 @@ struct nfs4_cb_compound_hdr {
 	int		status;
 };
 
-/*
- * Handle decode buffer overflows out-of-line.
- */
-static void print_overflow_msg(const char *func, const struct xdr_stream *xdr)
-{
-	dprintk("NFS: %s prematurely hit the end of our receive buffer. "
-		"Remaining buffer length is %tu words.\n",
-		func, xdr->end - xdr->p);
-}
-
 static __be32 *xdr_encode_empty_array(__be32 *p)
 {
 	*p++ = xdr_zero;
@@ -238,7 +228,6 @@ static int decode_cb_op_status(struct xdr_stream *xdr,
 	*status = nfs_cb_stat_to_errno(be32_to_cpup(p));
 	return 0;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 out_unexpected:
 	dprintk("NFSD: Callback server returned operation %d but "
@@ -307,7 +296,6 @@ static int decode_cb_compound4res(struct xdr_stream *xdr,
 	hdr->nops = be32_to_cpup(p);
 	return 0;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
@@ -435,7 +423,6 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
 	cb->cb_seq_status = status;
 	return status;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	status = -EIO;
 	goto out;
 }
diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index a5bb76593ce7..de6bab641b20 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -565,6 +565,7 @@ static __be32 idmap_id_to_name(struct xdr_stream *xdr,
 		.id = id,
 		.type = type,
 	};
+	__be32 status = nfs_ok;
 	__be32 *p;
 	int ret;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
@@ -577,12 +578,16 @@ static __be32 idmap_id_to_name(struct xdr_stream *xdr,
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
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7ac644d64ab1..061694c405ac 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -743,7 +743,8 @@ static void nfs4_free_deleg(struct nfs4_stid *stid)
  * When a delegation is recalled, the filehandle is stored in the "new"
  * filter.
  * Every 30 seconds we swap the filters and clear the "new" one,
- * unless both are empty of course.
+ * unless both are empty of course.  This results in delegations for a
+ * given filehandle being blocked for between 30 and 60 seconds.
  *
  * Each filter is 256 bits.  We hash the filehandle to 32bit and use the
  * low 3 bytes as hash-table indices.
@@ -755,7 +756,7 @@ static void nfs4_free_deleg(struct nfs4_stid *stid)
 static DEFINE_SPINLOCK(blocked_delegations_lock);
 static struct bloom_pair {
 	int	entries, old_entries;
-	time_t	swap_time;
+	time64_t swap_time;
 	int	new; /* index into 'set' */
 	DECLARE_BITMAP(set[2], 256);
 } blocked_delegations;
@@ -767,15 +768,15 @@ static int delegation_blocked(struct knfsd_fh *fh)
 
 	if (bd->entries == 0)
 		return 0;
-	if (seconds_since_boot() - bd->swap_time > 30) {
+	if (ktime_get_seconds() - bd->swap_time > 30) {
 		spin_lock(&blocked_delegations_lock);
-		if (seconds_since_boot() - bd->swap_time > 30) {
+		if (ktime_get_seconds() - bd->swap_time > 30) {
 			bd->entries -= bd->old_entries;
 			bd->old_entries = bd->entries;
+			bd->new = 1-bd->new;
 			memset(bd->set[bd->new], 0,
 			       sizeof(bd->set[0]));
-			bd->new = 1-bd->new;
-			bd->swap_time = seconds_since_boot();
+			bd->swap_time = ktime_get_seconds();
 		}
 		spin_unlock(&blocked_delegations_lock);
 	}
@@ -805,7 +806,7 @@ static void block_delegations(struct knfsd_fh *fh)
 	__set_bit((hash>>8)&255, bd->set[bd->new]);
 	__set_bit((hash>>16)&255, bd->set[bd->new]);
 	if (bd->entries == 0)
-		bd->swap_time = seconds_since_boot();
+		bd->swap_time = ktime_get_seconds();
 	bd->entries += 1;
 	spin_unlock(&blocked_delegations_lock);
 }
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index a426e4e2acda..7c9f4d79bdbc 100644
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
@@ -1659,13 +1660,16 @@ static int nilfs_btree_check_delete(struct nilfs_bmap *btree, __u64 key)
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
@@ -1674,12 +1678,12 @@ static int nilfs_btree_check_delete(struct nilfs_bmap *btree, __u64 key)
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
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 5c0e280c83ee..365cae5c3e35 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -331,6 +331,8 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
  * returns the page in which the entry was found, and the entry itself
  * (as a parameter - res_dir). Page is returned mapped and unlocked.
  * Entry is guaranteed to be valid.
+ *
+ * On failure, returns an error pointer and the caller should ignore res_page.
  */
 struct nilfs_dir_entry *
 nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
@@ -358,22 +360,24 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 	do {
 		char *kaddr = nilfs_get_page(dir, n, &page);
 
-		if (!IS_ERR(kaddr)) {
-			de = (struct nilfs_dir_entry *)kaddr;
-			kaddr += nilfs_last_byte(dir, n) - reclen;
-			while ((char *) de <= kaddr) {
-				if (de->rec_len == 0) {
-					nilfs_error(dir->i_sb,
-						"zero-length directory entry");
-					nilfs_put_page(page);
-					goto out;
-				}
-				if (nilfs_match(namelen, name, de))
-					goto found;
-				de = nilfs_next_entry(de);
+		if (IS_ERR(kaddr))
+			return ERR_CAST(kaddr);
+
+		de = (struct nilfs_dir_entry *)kaddr;
+		kaddr += nilfs_last_byte(dir, n) - reclen;
+		while ((char *)de <= kaddr) {
+			if (de->rec_len == 0) {
+				nilfs_error(dir->i_sb,
+					    "zero-length directory entry");
+				nilfs_put_page(page);
+				goto out;
 			}
-			nilfs_put_page(page);
+			if (nilfs_match(namelen, name, de))
+				goto found;
+			de = nilfs_next_entry(de);
 		}
+		nilfs_put_page(page);
+
 		if (++n >= npages)
 			n = 0;
 		/* next page is past the blocks we've got */
@@ -386,7 +390,7 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 		}
 	} while (n != start);
 out:
-	return NULL;
+	return ERR_PTR(-ENOENT);
 
 found:
 	*res_page = page;
@@ -431,19 +435,19 @@ struct nilfs_dir_entry *nilfs_dotdot(struct inode *dir, struct page **p)
 	return NULL;
 }
 
-ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)
+int nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr, ino_t *ino)
 {
-	ino_t res = 0;
 	struct nilfs_dir_entry *de;
 	struct page *page;
 
 	de = nilfs_find_entry(dir, qstr, &page);
-	if (de) {
-		res = le64_to_cpu(de->inode);
-		kunmap(page);
-		put_page(page);
-	}
-	return res;
+	if (IS_ERR(de))
+		return PTR_ERR(de);
+
+	*ino = le64_to_cpu(de->inode);
+	kunmap(page);
+	put_page(page);
+	return 0;
 }
 
 /* Releases the page */
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index a6ec7961d4f5..eeccd69cd797 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -55,12 +55,20 @@ nilfs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
 	ino_t ino;
+	int res;
 
 	if (dentry->d_name.len > NILFS_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	ino = nilfs_inode_by_name(dir, &dentry->d_name);
-	inode = ino ? nilfs_iget(dir->i_sb, NILFS_I(dir)->i_root, ino) : NULL;
+	res = nilfs_inode_by_name(dir, &dentry->d_name, &ino);
+	if (res) {
+		if (res != -ENOENT)
+			return ERR_PTR(res);
+		inode = NULL;
+	} else {
+		inode = nilfs_iget(dir->i_sb, NILFS_I(dir)->i_root, ino);
+	}
+
 	return d_splice_alias(inode, dentry);
 }
 
@@ -148,6 +156,9 @@ static int nilfs_symlink(struct inode *dir, struct dentry *dentry,
 	/* slow symlink */
 	inode->i_op = &nilfs_symlink_inode_operations;
 	inode_nohighmem(inode);
+	mapping_set_gfp_mask(inode->i_mapping,
+			     mapping_gfp_constraint(inode->i_mapping,
+						    ~__GFP_FS));
 	inode->i_mapping->a_ops = &nilfs_aops;
 	err = page_symlink(inode, symname, l);
 	if (err)
@@ -261,10 +272,11 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 	struct page *page;
 	int err;
 
-	err = -ENOENT;
 	de = nilfs_find_entry(dir, &dentry->d_name, &page);
-	if (!de)
+	if (IS_ERR(de)) {
+		err = PTR_ERR(de);
 		goto out;
+	}
 
 	inode = d_inode(dentry);
 	err = -EIO;
@@ -358,10 +370,11 @@ static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (unlikely(err))
 		return err;
 
-	err = -ENOENT;
 	old_de = nilfs_find_entry(old_dir, &old_dentry->d_name, &old_page);
-	if (!old_de)
+	if (IS_ERR(old_de)) {
+		err = PTR_ERR(old_de);
 		goto out;
+	}
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
@@ -378,10 +391,12 @@ static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		if (dir_de && !nilfs_empty_dir(new_inode))
 			goto out_dir;
 
-		err = -ENOENT;
-		new_de = nilfs_find_entry(new_dir, &new_dentry->d_name, &new_page);
-		if (!new_de)
+		new_de = nilfs_find_entry(new_dir, &new_dentry->d_name,
+					  &new_page);
+		if (IS_ERR(new_de)) {
+			err = PTR_ERR(new_de);
 			goto out_dir;
+		}
 		nilfs_set_link(new_dir, new_de, new_page, old_inode);
 		nilfs_mark_inode_dirty(new_dir);
 		new_inode->i_ctime = current_time(new_inode);
@@ -435,14 +450,15 @@ static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
  */
 static struct dentry *nilfs_get_parent(struct dentry *child)
 {
-	unsigned long ino;
+	ino_t ino;
+	int res;
 	struct inode *inode;
 	struct qstr dotdot = QSTR_INIT("..", 2);
 	struct nilfs_root *root;
 
-	ino = nilfs_inode_by_name(d_inode(child), &dotdot);
-	if (!ino)
-		return ERR_PTR(-ENOENT);
+	res = nilfs_inode_by_name(d_inode(child), &dotdot, &ino);
+	if (res)
+		return ERR_PTR(res);
 
 	root = NILFS_I(d_inode(child))->i_root;
 
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index f7e2032f4ecf..65254027366b 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -233,7 +233,7 @@ static inline __u32 nilfs_mask_flags(umode_t mode, __u32 flags)
 
 /* dir.c */
 extern int nilfs_add_link(struct dentry *, struct inode *);
-extern ino_t nilfs_inode_by_name(struct inode *, const struct qstr *);
+int nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr, ino_t *ino);
 extern int nilfs_make_empty(struct inode *, struct inode *);
 extern struct nilfs_dir_entry *
 nilfs_find_entry(struct inode *, const struct qstr *, struct page **);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 762dd277099e..6e02bd5e2f18 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -78,7 +78,8 @@ void nilfs_forget_buffer(struct buffer_head *bh)
 	const unsigned long clear_bits =
 		(BIT(BH_Uptodate) | BIT(BH_Dirty) | BIT(BH_Mapped) |
 		 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
-		 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected));
+		 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected) |
+		 BIT(BH_Delay));
 
 	lock_buffer(bh);
 	set_mask_bits(&bh->b_state, clear_bits, 0);
@@ -406,13 +407,15 @@ void nilfs_clear_dirty_page(struct page *page, bool silent)
 
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
+	ClearPageChecked(page);
 
 	if (page_has_buffers(page)) {
 		struct buffer_head *bh, *head;
 		const unsigned long clear_bits =
 			(BIT(BH_Uptodate) | BIT(BH_Dirty) | BIT(BH_Mapped) |
 			 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
-			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected));
+			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected) |
+			 BIT(BH_Delay));
 
 		bh = head = page_buffers(page);
 		do {
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 1353db3f7f48..1adb258430ea 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -172,9 +172,8 @@ int ocfs2_get_block(struct inode *inode, sector_t iblock,
 	err = ocfs2_extent_map_get_blocks(inode, iblock, &p_blkno, &count,
 					  &ext_flags);
 	if (err) {
-		mlog(ML_ERROR, "Error %d from get_blocks(0x%p, %llu, 1, "
-		     "%llu, NULL)\n", err, inode, (unsigned long long)iblock,
-		     (unsigned long long)p_blkno);
+		mlog(ML_ERROR, "get_blocks() failed, inode: 0x%p, "
+		     "block: %llu\n", inode, (unsigned long long)iblock);
 		goto bail;
 	}
 
diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index f9b84f7a3e4b..71a3c0201887 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -251,7 +251,6 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
 		if (bhs[i] == NULL) {
 			bhs[i] = sb_getblk(sb, block++);
 			if (bhs[i] == NULL) {
-				ocfs2_metadata_cache_io_unlock(ci);
 				status = -ENOMEM;
 				mlog_errno(status);
 				/* Don't forget to put previous bh! */
@@ -405,7 +404,8 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
 		/* Always set the buffer in the cache, even if it was
 		 * a forced read, or read-ahead which hasn't yet
 		 * completed. */
-		ocfs2_set_buffer_uptodate(ci, bh);
+		if (bh)
+			ocfs2_set_buffer_uptodate(ci, bh);
 	}
 	ocfs2_metadata_cache_io_unlock(ci);
 
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index a6f486f4138f..3c71c05a0581 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1795,6 +1795,14 @@ int ocfs2_remove_inode_range(struct inode *inode,
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
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index c27d8ef47392..3b3ae7521485 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -989,7 +989,7 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 	if (!igrab(inode))
 		BUG();
 
-	num_running_trans = atomic_read(&(osb->journal->j_num_trans));
+	num_running_trans = atomic_read(&(journal->j_num_trans));
 	trace_ocfs2_journal_shutdown(num_running_trans);
 
 	/* Do a commit_cache here. It will flush our journal, *and*
@@ -1008,9 +1008,10 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 		osb->commit_task = NULL;
 	}
 
-	BUG_ON(atomic_read(&(osb->journal->j_num_trans)) != 0);
+	BUG_ON(atomic_read(&(journal->j_num_trans)) != 0);
 
-	if (ocfs2_mount_local(osb)) {
+	if (ocfs2_mount_local(osb) &&
+	    (journal->j_journal->j_flags & JBD2_LOADED)) {
 		jbd2_journal_lock_updates(journal->j_journal);
 		status = jbd2_journal_flush(journal->j_journal);
 		jbd2_journal_unlock_updates(journal->j_journal);
diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index a46aff7135d3..e6941e090857 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -1026,6 +1026,25 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
 		start = bit_off + 1;
 	}
 
+	/* clear the contiguous bits until the end boundary */
+	if (count) {
+		blkno = la_start_blk +
+			ocfs2_clusters_to_blocks(osb->sb,
+					start - count);
+
+		trace_ocfs2_sync_local_to_main_free(
+				count, start - count,
+				(unsigned long long)la_start_blk,
+				(unsigned long long)blkno);
+
+		status = ocfs2_release_clusters(handle,
+				main_bm_inode,
+				main_bm_bh, blkno,
+				count);
+		if (status < 0)
+			mlog_errno(status);
+	}
+
 bail:
 	if (status)
 		mlog_errno(status);
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index b1a8b046f4c2..7a1c8da9e44b 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -689,7 +689,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 	int status;
 	struct buffer_head *bh = NULL;
 	struct ocfs2_quota_recovery *rec;
-	int locked = 0;
+	int locked = 0, global_read = 0;
 
 	info->dqi_max_spc_limit = 0x7fffffffffffffffLL;
 	info->dqi_max_ino_limit = 0x7fffffffffffffffLL;
@@ -697,6 +697,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 	if (!oinfo) {
 		mlog(ML_ERROR, "failed to allocate memory for ocfs2 quota"
 			       " info.");
+		status = -ENOMEM;
 		goto out_err;
 	}
 	info->dqi_priv = oinfo;
@@ -709,6 +710,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 	status = ocfs2_global_read_info(sb, type);
 	if (status < 0)
 		goto out_err;
+	global_read = 1;
 
 	status = ocfs2_inode_lock(lqinode, &oinfo->dqi_lqi_bh, 1);
 	if (status < 0) {
@@ -779,10 +781,12 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 		if (locked)
 			ocfs2_inode_unlock(lqinode, 1);
 		ocfs2_release_local_quota_bitmaps(&oinfo->dqi_chunk);
+		if (global_read)
+			cancel_delayed_work_sync(&oinfo->dqi_sync_work);
 		kfree(oinfo);
 	}
 	brelse(bh);
-	return -1;
+	return status;
 }
 
 /* Write local info to quota file */
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index e184b36f8dd3..7eefd6bd8f8f 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -35,6 +35,7 @@
 #include "namei.h"
 #include "ocfs2_trace.h"
 #include "file.h"
+#include "symlink.h"
 
 #include <linux/bio.h>
 #include <linux/blkdev.h>
@@ -4192,8 +4193,9 @@ static int __ocfs2_reflink(struct dentry *old_dentry,
 	int ret;
 	struct inode *inode = d_inode(old_dentry);
 	struct buffer_head *new_bh = NULL;
+	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 
-	if (OCFS2_I(inode)->ip_flags & OCFS2_INODE_SYSTEM_FILE) {
+	if (oi->ip_flags & OCFS2_INODE_SYSTEM_FILE) {
 		ret = -EINVAL;
 		mlog_errno(ret);
 		goto out;
@@ -4219,6 +4221,26 @@ static int __ocfs2_reflink(struct dentry *old_dentry,
 		goto out_unlock;
 	}
 
+	if ((oi->ip_dyn_features & OCFS2_HAS_XATTR_FL) &&
+	    (oi->ip_dyn_features & OCFS2_INLINE_XATTR_FL)) {
+		/*
+		 * Adjust extent record count to reserve space for extended attribute.
+		 * Inline data count had been adjusted in ocfs2_duplicate_inline_data().
+		 */
+		struct ocfs2_inode_info *new_oi = OCFS2_I(new_inode);
+
+		if (!(new_oi->ip_dyn_features & OCFS2_INLINE_DATA_FL) &&
+		    !(ocfs2_inode_is_fast_symlink(new_inode))) {
+			struct ocfs2_dinode *new_di = (struct ocfs2_dinode *)new_bh->b_data;
+			struct ocfs2_dinode *old_di = (struct ocfs2_dinode *)old_bh->b_data;
+			struct ocfs2_extent_list *el = &new_di->id2.i_list;
+			int inline_size = le16_to_cpu(old_di->i_xattr_inline_size);
+
+			le16_add_cpu(&el->l_count, -(inline_size /
+					sizeof(struct ocfs2_extent_rec)));
+		}
+	}
+
 	ret = ocfs2_create_reflink_node(inode, old_bh,
 					new_inode, new_bh, preserve);
 	if (ret) {
@@ -4226,7 +4248,7 @@ static int __ocfs2_reflink(struct dentry *old_dentry,
 		goto inode_unlock;
 	}
 
-	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_HAS_XATTR_FL) {
+	if (oi->ip_dyn_features & OCFS2_HAS_XATTR_FL) {
 		ret = ocfs2_reflink_xattrs(inode, old_bh,
 					   new_inode, new_bh,
 					   preserve);
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 54d881c9ac81..b9dfac2a5649 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1076,13 +1076,13 @@ ssize_t ocfs2_listxattr(struct dentry *dentry,
 	return i_ret + b_ret;
 }
 
-static int ocfs2_xattr_find_entry(int name_index,
+static int ocfs2_xattr_find_entry(struct inode *inode, int name_index,
 				  const char *name,
 				  struct ocfs2_xattr_search *xs)
 {
 	struct ocfs2_xattr_entry *entry;
 	size_t name_len;
-	int i, cmp = 1;
+	int i, name_offset, cmp = 1;
 
 	if (name == NULL)
 		return -EINVAL;
@@ -1090,13 +1090,22 @@ static int ocfs2_xattr_find_entry(int name_index,
 	name_len = strlen(name);
 	entry = xs->here;
 	for (i = 0; i < le16_to_cpu(xs->header->xh_count); i++) {
+		if ((void *)entry >= xs->end) {
+			ocfs2_error(inode->i_sb, "corrupted xattr entries");
+			return -EFSCORRUPTED;
+		}
 		cmp = name_index - ocfs2_xattr_get_type(entry);
 		if (!cmp)
 			cmp = name_len - entry->xe_name_len;
-		if (!cmp)
-			cmp = memcmp(name, (xs->base +
-				     le16_to_cpu(entry->xe_name_offset)),
-				     name_len);
+		if (!cmp) {
+			name_offset = le16_to_cpu(entry->xe_name_offset);
+			if ((xs->base + name_offset + name_len) > xs->end) {
+				ocfs2_error(inode->i_sb,
+					    "corrupted xattr entries");
+				return -EFSCORRUPTED;
+			}
+			cmp = memcmp(name, (xs->base + name_offset), name_len);
+		}
 		if (cmp == 0)
 			break;
 		entry += 1;
@@ -1180,7 +1189,7 @@ static int ocfs2_xattr_ibody_get(struct inode *inode,
 	xs->base = (void *)xs->header;
 	xs->here = xs->header->xh_entries;
 
-	ret = ocfs2_xattr_find_entry(name_index, name, xs);
+	ret = ocfs2_xattr_find_entry(inode, name_index, name, xs);
 	if (ret)
 		return ret;
 	size = le64_to_cpu(xs->here->xe_value_size);
@@ -2712,7 +2721,7 @@ static int ocfs2_xattr_ibody_find(struct inode *inode,
 
 	/* Find the named attribute. */
 	if (oi->ip_dyn_features & OCFS2_INLINE_XATTR_FL) {
-		ret = ocfs2_xattr_find_entry(name_index, name, xs);
+		ret = ocfs2_xattr_find_entry(inode, name_index, name, xs);
 		if (ret && ret != -ENODATA)
 			return ret;
 		xs->not_found = ret;
@@ -2847,7 +2856,7 @@ static int ocfs2_xattr_block_find(struct inode *inode,
 		xs->end = (void *)(blk_bh->b_data) + blk_bh->b_size;
 		xs->here = xs->header->xh_entries;
 
-		ret = ocfs2_xattr_find_entry(name_index, name, xs);
+		ret = ocfs2_xattr_find_entry(inode, name_index, name, xs);
 	} else
 		ret = ocfs2_xattr_index_block_find(inode, blk_bh,
 						   name_index,
@@ -6525,16 +6534,7 @@ static int ocfs2_reflink_xattr_inline(struct ocfs2_xattr_reflink *args)
 	}
 
 	new_oi = OCFS2_I(args->new_inode);
-	/*
-	 * Adjust extent record count to reserve space for extended attribute.
-	 * Inline data count had been adjusted in ocfs2_duplicate_inline_data().
-	 */
-	if (!(new_oi->ip_dyn_features & OCFS2_INLINE_DATA_FL) &&
-	    !(ocfs2_inode_is_fast_symlink(args->new_inode))) {
-		struct ocfs2_extent_list *el = &new_di->id2.i_list;
-		le16_add_cpu(&el->l_count, -(inline_size /
-					sizeof(struct ocfs2_extent_rec)));
-	}
+
 	spin_lock(&new_oi->ip_lock);
 	new_oi->ip_dyn_features |= OCFS2_HAS_XATTR_FL | OCFS2_INLINE_XATTR_FL;
 	new_di->i_dyn_features = cpu_to_le16(new_oi->ip_dyn_features);
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 08d7208eb7b7..76bb8be01b8d 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -2166,12 +2166,15 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 		alen = udf_file_entry_alloc_offset(inode) +
 							iinfo->i_lenAlloc;
 	} else {
+		struct allocExtDesc *header =
+			(struct allocExtDesc *)epos->bh->b_data;
+
 		if (!epos->offset)
 			epos->offset = sizeof(struct allocExtDesc);
 		ptr = epos->bh->b_data + epos->offset;
-		alen = sizeof(struct allocExtDesc) +
-			le32_to_cpu(((struct allocExtDesc *)epos->bh->b_data)->
-							lengthAllocDescs);
+		if (check_add_overflow(sizeof(struct allocExtDesc),
+				le32_to_cpu(header->lengthAllocDescs), &alen))
+			return -1;
 	}
 
 	switch (iinfo->i_alloc_type) {
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index f3e6eed3e79c..fbf6dc19c132 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -111,7 +111,8 @@ drm_vprintf(struct drm_printer *p, const char *fmt, va_list *va)
 
 /**
  * struct drm_print_iterator - local struct used with drm_printer_coredump
- * @data: Pointer to the devcoredump output buffer
+ * @data: Pointer to the devcoredump output buffer, can be NULL if using
+ * drm_printer_coredump to determine size of devcoredump
  * @start: The offset within the buffer to start writing
  * @remain: The number of bytes to write for this iteration
  */
@@ -156,6 +157,57 @@ struct drm_print_iterator {
  *			coredump_read, ...)
  *	}
  *
+ * The above example has a time complexity of O(N^2), where N is the size of the
+ * devcoredump. This is acceptable for small devcoredumps but scales poorly for
+ * larger ones.
+ *
+ * Another use case for drm_coredump_printer is to capture the devcoredump into
+ * a saved buffer before the dev_coredump() callback. This involves two passes:
+ * one to determine the size of the devcoredump and another to print it to a
+ * buffer. Then, in dev_coredump(), copy from the saved buffer into the
+ * devcoredump read buffer.
+ *
+ * For example::
+ *
+ *	char *devcoredump_saved_buffer;
+ *
+ *	ssize_t __coredump_print(char *buffer, ssize_t count, ...)
+ *	{
+ *		struct drm_print_iterator iter;
+ *		struct drm_printer p;
+ *
+ *		iter.data = buffer;
+ *		iter.start = 0;
+ *		iter.remain = count;
+ *
+ *		p = drm_coredump_printer(&iter);
+ *
+ *		drm_printf(p, "foo=%d\n", foo);
+ *		...
+ *		return count - iter.remain;
+ *	}
+ *
+ *	void coredump_print(...)
+ *	{
+ *		ssize_t count;
+ *
+ *		count = __coredump_print(NULL, INT_MAX, ...);
+ *		devcoredump_saved_buffer = kvmalloc(count, GFP_KERNEL);
+ *		__coredump_print(devcoredump_saved_buffer, count, ...);
+ *	}
+ *
+ *	void coredump_read(char *buffer, loff_t offset, size_t count,
+ *			   void *data, size_t datalen)
+ *	{
+ *		...
+ *		memcpy(buffer, devcoredump_saved_buffer + offset, count);
+ *		...
+ *	}
+ *
+ * The above example has a time complexity of O(N*2), where N is the size of the
+ * devcoredump. This scales better than the previous example for larger
+ * devcoredumps.
+ *
  * RETURNS:
  * The &drm_printer object
  */
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0a2382d3f68c..fb4c86360e5a 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -388,6 +388,102 @@ int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
  */
 struct clk *devm_clk_get(struct device *dev, const char *id);
 
+/**
+ * devm_clk_get_prepared - devm_clk_get() + clk_prepare()
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Context: May sleep.
+ *
+ * Return: a struct clk corresponding to the clock producer, or
+ * valid IS_ERR() condition containing errno.  The implementation
+ * uses @dev and @id to determine the clock consumer, and thereby
+ * the clock producer.  (IOW, @id may be identical strings, but
+ * clk_get may return different clock producers depending on @dev.)
+ *
+ * The returned clk (if valid) is prepared. Drivers must however assume
+ * that the clock is not enabled.
+ *
+ * The clock will automatically be unprepared and freed when the device
+ * is unbound from the bus.
+ */
+struct clk *devm_clk_get_prepared(struct device *dev, const char *id);
+
+/**
+ * devm_clk_get_enabled - devm_clk_get() + clk_prepare_enable()
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Context: May sleep.
+ *
+ * Return: a struct clk corresponding to the clock producer, or
+ * valid IS_ERR() condition containing errno.  The implementation
+ * uses @dev and @id to determine the clock consumer, and thereby
+ * the clock producer.  (IOW, @id may be identical strings, but
+ * clk_get may return different clock producers depending on @dev.)
+ *
+ * The returned clk (if valid) is prepared and enabled.
+ *
+ * The clock will automatically be disabled, unprepared and freed
+ * when the device is unbound from the bus.
+ */
+struct clk *devm_clk_get_enabled(struct device *dev, const char *id);
+
+/**
+ * devm_clk_get_optional - lookup and obtain a managed reference to an optional
+ *			   clock producer.
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Behaves the same as devm_clk_get() except where there is no clock producer.
+ * In this case, instead of returning -ENOENT, the function returns NULL.
+ */
+struct clk *devm_clk_get_optional(struct device *dev, const char *id);
+
+/**
+ * devm_clk_get_optional_prepared - devm_clk_get_optional() + clk_prepare()
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Context: May sleep.
+ *
+ * Return: a struct clk corresponding to the clock producer, or
+ * valid IS_ERR() condition containing errno.  The implementation
+ * uses @dev and @id to determine the clock consumer, and thereby
+ * the clock producer.  If no such clk is found, it returns NULL
+ * which serves as a dummy clk.  That's the only difference compared
+ * to devm_clk_get_prepared().
+ *
+ * The returned clk (if valid) is prepared. Drivers must however
+ * assume that the clock is not enabled.
+ *
+ * The clock will automatically be unprepared and freed when the
+ * device is unbound from the bus.
+ */
+struct clk *devm_clk_get_optional_prepared(struct device *dev, const char *id);
+
+/**
+ * devm_clk_get_optional_enabled - devm_clk_get_optional() +
+ *                                 clk_prepare_enable()
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Context: May sleep.
+ *
+ * Return: a struct clk corresponding to the clock producer, or
+ * valid IS_ERR() condition containing errno.  The implementation
+ * uses @dev and @id to determine the clock consumer, and thereby
+ * the clock producer.  If no such clk is found, it returns NULL
+ * which serves as a dummy clk.  That's the only difference compared
+ * to devm_clk_get_enabled().
+ *
+ * The returned clk (if valid) is prepared and enabled.
+ *
+ * The clock will automatically be disabled, unprepared and freed
+ * when the device is unbound from the bus.
+ */
+struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *id);
+
 /**
  * devm_get_clk_from_child - lookup and obtain a managed reference to a
  *			     clock producer from child node.
@@ -655,6 +751,36 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
+static inline struct clk *devm_clk_get_prepared(struct device *dev,
+						const char *id)
+{
+	return NULL;
+}
+
+static inline struct clk *devm_clk_get_enabled(struct device *dev,
+					       const char *id)
+{
+	return NULL;
+}
+
+static inline struct clk *devm_clk_get_optional(struct device *dev,
+						const char *id)
+{
+	return NULL;
+}
+
+static inline struct clk *devm_clk_get_optional_prepared(struct device *dev,
+							 const char *id)
+{
+	return NULL;
+}
+
+static inline struct clk *devm_clk_get_optional_enabled(struct device *dev,
+							const char *id)
+{
+	return NULL;
+}
+
 static inline int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 						 struct clk_bulk_data *clks)
 {
@@ -774,6 +900,25 @@ static inline void clk_bulk_disable_unprepare(int num_clks,
 	clk_bulk_unprepare(num_clks, clks);
 }
 
+/**
+ * clk_get_optional - lookup and obtain a reference to an optional clock
+ *		      producer.
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Behaves the same as clk_get() except where there is no clock producer. In
+ * this case, instead of returning -ENOENT, the function returns NULL.
+ */
+static inline struct clk *clk_get_optional(struct device *dev, const char *id)
+{
+	struct clk *clk = clk_get(dev, id);
+
+	if (clk == ERR_PTR(-ENOENT))
+		return NULL;
+
+	return clk;
+}
+
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 268f3000d1b3..1d81afb54928 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1421,6 +1421,10 @@ extern int	   jbd2_journal_inode_ranged_write(handle_t *handle,
 extern int	   jbd2_journal_inode_ranged_wait(handle_t *handle,
 			struct jbd2_inode *inode, loff_t start_byte,
 			loff_t length);
+extern int	   jbd2_journal_submit_inode_data_buffers(
+			struct jbd2_inode *jinode);
+extern int	   jbd2_journal_finish_inode_data_buffers(
+			struct jbd2_inode *jinode);
 extern int	   jbd2_journal_begin_ordered_truncate(journal_t *journal,
 				struct jbd2_inode *inode, loff_t new_size);
 extern void	   jbd2_journal_init_jbd_inode(struct jbd2_inode *jinode, struct inode *inode);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 91193284710f..5f996cf93c13 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2647,6 +2647,8 @@
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
 
+#define PCI_VENDOR_ID_GLENFLY		0x6766
+
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_PXHD_0	0x0320
diff --git a/include/net/sock.h b/include/net/sock.h
index 6304e287087f..0fd67a5f15e8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -764,6 +764,8 @@ static inline void sk_add_bind_node(struct sock *sk,
 	hlist_for_each_entry_safe(__sk, tmp, list, sk_node)
 #define sk_for_each_bound(__sk, list) \
 	hlist_for_each_entry(__sk, list, sk_bind_node)
+#define sk_for_each_bound_safe(__sk, tmp, list) \
+	hlist_for_each_entry_safe(__sk, tmp, list, sk_bind_node)
 
 /**
  * sk_for_each_entry_offset_rcu - iterate over a list at a given struct offset
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 49da4d4a3c3d..9f991c5927c3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -794,6 +794,12 @@ static inline u32 tcp_skb_timestamp(const struct sk_buff *skb)
 	return div_u64(skb->skb_mstamp, USEC_PER_SEC / TCP_TS_HZ);
 }
 
+/* provide the departure time in us unit */
+static inline u64 tcp_skb_timestamp_us(const struct sk_buff *skb)
+{
+	return skb->skb_mstamp;
+}
+
 
 #define tcp_flag_byte(th) (((u_int8_t *)th)[13])
 
@@ -2003,9 +2009,26 @@ static inline s64 tcp_rto_delta_us(const struct sock *sk)
 {
 	const struct sk_buff *skb = tcp_rtx_queue_head(sk);
 	u32 rto = inet_csk(sk)->icsk_rto;
-	u64 rto_time_stamp_us = skb->skb_mstamp + jiffies_to_usecs(rto);
 
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
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 098d6dff20be..abffe3a3f39e 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -148,7 +148,8 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
 		{ CP_NODE_NEED_CP,	"node needs cp" },		\
 		{ CP_FASTBOOT_MODE,	"fastboot mode" },		\
 		{ CP_SPEC_LOG_NUM,	"log type is 2" },		\
-		{ CP_RECOVER_DIR,	"dir needs recovery" })
+		{ CP_RECOVER_DIR,	"dir needs recovery" },		\
+		{ CP_XATTR_DIR,		"dir's xattr updated" })
 
 struct victim_sel_policy;
 struct f2fs_map_blocks;
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9a4bdfadab07..a4eb7bc6fcf5 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -5,6 +5,7 @@
 #if !defined(_TRACE_SCHED_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_SCHED_H
 
+#include <linux/kthread.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/tracepoint.h>
 #include <linux/binfmts.h>
@@ -51,6 +52,89 @@ TRACE_EVENT(sched_kthread_stop_ret,
 	TP_printk("ret=%d", __entry->ret)
 );
 
+/**
+ * sched_kthread_work_queue_work - called when a work gets queued
+ * @worker:	pointer to the kthread_worker
+ * @work:	pointer to struct kthread_work
+ *
+ * This event occurs when a work is queued immediately or once a
+ * delayed work is actually queued (ie: once the delay has been
+ * reached).
+ */
+TRACE_EVENT(sched_kthread_work_queue_work,
+
+	TP_PROTO(struct kthread_worker *worker,
+		 struct kthread_work *work),
+
+	TP_ARGS(worker, work),
+
+	TP_STRUCT__entry(
+		__field( void *,	work	)
+		__field( void *,	function)
+		__field( void *,	worker)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= work->func;
+		__entry->worker		= worker;
+	),
+
+	TP_printk("work struct=%p function=%ps worker=%p",
+		  __entry->work, __entry->function, __entry->worker)
+);
+
+/**
+ * sched_kthread_work_execute_start - called immediately before the work callback
+ * @work:	pointer to struct kthread_work
+ *
+ * Allows to track kthread work execution.
+ */
+TRACE_EVENT(sched_kthread_work_execute_start,
+
+	TP_PROTO(struct kthread_work *work),
+
+	TP_ARGS(work),
+
+	TP_STRUCT__entry(
+		__field( void *,	work	)
+		__field( void *,	function)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= work->func;
+	),
+
+	TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
+);
+
+/**
+ * sched_kthread_work_execute_end - called immediately after the work callback
+ * @work:	pointer to struct work_struct
+ * @function:   pointer to worker function
+ *
+ * Allows to track workqueue execution.
+ */
+TRACE_EVENT(sched_kthread_work_execute_end,
+
+	TP_PROTO(struct kthread_work *work, kthread_work_func_t function),
+
+	TP_ARGS(work, function),
+
+	TP_STRUCT__entry(
+		__field( void *,	work	)
+		__field( void *,	function)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= function;
+	),
+
+	TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
+);
+
 /*
  * Tracepoint for waking up a task:
  */
diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
index d6ba68880cef..8b7085c7577d 100644
--- a/include/uapi/linux/cec.h
+++ b/include/uapi/linux/cec.h
@@ -132,6 +132,8 @@ static inline void cec_msg_init(struct cec_msg *msg,
  * Set the msg destination to the orig initiator and the msg initiator to the
  * orig destination. Note that msg and orig may be the same pointer, in which
  * case the change is done in place.
+ *
+ * It also zeroes the reply, timeout and flags fields.
  */
 static inline void cec_msg_set_reply_to(struct cec_msg *msg,
 					struct cec_msg *orig)
@@ -139,7 +141,9 @@ static inline void cec_msg_set_reply_to(struct cec_msg *msg,
 	/* The destination becomes the initiator and vice versa */
 	msg->msg[0] = (cec_msg_destination(orig) << 4) |
 		      cec_msg_initiator(orig);
-	msg->reply = msg->timeout = 0;
+	msg->reply = 0;
+	msg->timeout = 0;
+	msg->flags = 0;
 }
 
 /* cec_msg flags field */
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 00781db11419..af33a7519b08 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1464,7 +1464,7 @@ enum nft_object_attributes {
  *
  * @NFTA_FLOWTABLE_TABLE: name of the table containing the expression (NLA_STRING)
  * @NFTA_FLOWTABLE_NAME: name of this flow table (NLA_STRING)
- * @NFTA_FLOWTABLE_HOOK: netfilter hook configuration(NLA_U32)
+ * @NFTA_FLOWTABLE_HOOK: netfilter hook configuration (NLA_NESTED)
  * @NFTA_FLOWTABLE_USE: number of references to this flow table (NLA_U32)
  * @NFTA_FLOWTABLE_HANDLE: object handle (NLA_U64)
  */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 44f53c06629e..03e244b11f5a 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -71,6 +71,9 @@ int array_map_alloc_check(union bpf_attr *attr)
 		 * access the elements.
 		 */
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 16081d8384bf..bca328703046 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -291,6 +291,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 		 * kmalloc-able later in htab_map_update_elem()
 		 */
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index fcd3a15add41..a929ee0e86b1 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -629,7 +629,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
 	if (!key || key->prefixlen > trie->max_prefixlen)
 		goto find_leftmost;
 
-	node_stack = kmalloc_array(trie->max_prefixlen,
+	node_stack = kmalloc_array(trie->max_prefixlen + 1,
 				   sizeof(struct lpm_trie_node *),
 				   GFP_ATOMIC | __GFP_NOWARN);
 	if (!node_stack)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 30c058806702..4ab74d06be19 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5104,7 +5104,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 {
 	struct cgroup *cgroup;
 	int ret = false;
-	int level = 1;
+	int level = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -5112,7 +5112,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 		if (cgroup->nr_descendants >= cgroup->max_descendants)
 			goto fail;
 
-		if (level > cgroup->max_depth)
+		if (level >= cgroup->max_depth)
 			goto fail;
 
 		level++;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4f1b0fc2e74d..26a547866ed9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3618,7 +3618,11 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 	period = perf_calculate_period(event, nsec, count);
 
 	delta = (s64)(period - hwc->sample_period);
-	delta = (delta + 7) / 8; /* low pass filter */
+	if (delta >= 0)
+		delta += 7;
+	else
+		delta -= 7;
+	delta /= 8; /* low pass filter */
 
 	sample_period = hwc->sample_period + delta;
 
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 3361da45e1db..3ca91daddc9f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1198,7 +1198,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 
 	area->xol_mapping.name = "[uprobes]";
 	area->xol_mapping.pages = area->pages;
-	area->pages[0] = alloc_page(GFP_HIGHUSER);
+	area->pages[0] = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
 	if (!area->pages[0])
 		goto free_bitmap;
 	area->pages[1] = NULL;
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 9750f4f7f901..9c562b3b362a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -696,10 +696,25 @@ int kthread_worker_fn(void *worker_ptr)
 	spin_unlock_irq(&worker->lock);
 
 	if (work) {
+		kthread_work_func_t func = work->func;
 		__set_current_state(TASK_RUNNING);
+		trace_sched_kthread_work_execute_start(work);
 		work->func(work);
-	} else if (!freezing(current))
+		/*
+		 * Avoid dereferencing work after this point.  The trace
+		 * event only cares about the address.
+		 */
+		trace_sched_kthread_work_execute_end(work, func);
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
@@ -826,6 +841,8 @@ static void kthread_insert_work(struct kthread_worker *worker,
 {
 	kthread_insert_work_sanity_check(worker, work);
 
+	trace_sched_kthread_work_queue_work(worker, work);
+
 	list_add_tail(&work->node, pos);
 	work->worker = worker;
 	if (!worker->current_work && likely(worker->task))
diff --git a/kernel/signal.c b/kernel/signal.c
index c79b87ac1041..356bdf5c45e6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1739,10 +1739,11 @@ struct sigqueue *sigqueue_alloc(void)
 
 void sigqueue_free(struct sigqueue *q)
 {
-	unsigned long flags;
 	spinlock_t *lock = &current->sighand->siglock;
+	unsigned long flags;
 
-	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
+		return;
 	/*
 	 * We must hold ->siglock while testing q->list
 	 * to serialize with collect_signal() or with
@@ -1770,7 +1771,10 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	unsigned long flags;
 	int ret, result;
 
-	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
+		return 0;
+	if (WARN_ON_ONCE(q->info.si_code != SI_TIMER))
+		return 0;
 
 	ret = -1;
 	rcu_read_lock();
@@ -1789,7 +1793,6 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 		 * If an SI_TIMER entry is already queue just increment
 		 * the overrun count.
 		 */
-		BUG_ON(q->info.si_code != SI_TIMER);
 		q->info.si_overrun++;
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index c8a8501fae5b..c1e5feff8185 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -303,6 +303,9 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 	struct posix_clock_desc cd;
 	int err;
 
+	if (!timespec64_valid_strict(ts))
+		return -EINVAL;
+
 	err = get_clock_desc(id, &cd);
 	if (err)
 		return err;
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 43fb832d26d2..62015d62dd6f 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1320,12 +1320,11 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 {
 	struct print_entry *field;
 	struct trace_seq *s = &iter->seq;
-	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
 	seq_print_ip_sym(s, field->ip, flags);
-	trace_seq_printf(s, ": %.*s", max, field->buf);
+	trace_seq_printf(s, ": %s", field->buf);
 
 	return trace_handle_return(s);
 }
@@ -1334,11 +1333,10 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
 					 struct trace_event *event)
 {
 	struct print_entry *field;
-	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
-	trace_seq_printf(&iter->seq, "# %lx %.*s", field->ip, max, field->buf);
+	trace_seq_printf(&iter->seq, "# %lx %s", field->ip, field->buf);
 
 	return trace_handle_return(&iter->seq);
 }
diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
index 912aae5fa09e..34532d14fd4c 100644
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
index 09360ebb510e..482b90f363fe 100644
--- a/lib/xz/xz_private.h
+++ b/lib/xz/xz_private.h
@@ -102,10 +102,6 @@
 #	endif
 #endif
 
-#ifndef CRC32_POLY_LE
-#define CRC32_POLY_LE 0xedb88320
-#endif
-
 /*
  * Allocate memory for LZMA2 decoder. xz_dec_lzma2_reset() must be used
  * before calling xz_dec_lzma2_run().
diff --git a/mm/shmem.c b/mm/shmem.c
index 0788616696dc..6e9027cb72ef 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1014,7 +1014,9 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
 		shmem_recalc_inode(inode);
 		spin_unlock_irq(&info->lock);
 	}
+	inode_lock_shared(inode);
 	generic_fillattr(inode, stat);
+	inode_unlock_shared(inode);
 
 	if (is_huge_enabled(sb_info))
 		stat->blksize = HPAGE_PMD_SIZE;
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 798f8f485e5a..ecda737113ce 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -781,6 +781,7 @@ static int __init bt_init(void)
 	bt_sysfs_cleanup();
 cleanup_led:
 	bt_leds_cleanup();
+	debugfs_remove_recursive(bt_debugfs);
 	return err;
 }
 
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index a16d584a6c0d..e1cfd110d281 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -744,8 +744,7 @@ static int __init bnep_init(void)
 	if (flt[0])
 		BT_INFO("BNEP filters: %s", flt);
 
-	bnep_sock_init();
-	return 0;
+	return bnep_sock_init();
 }
 
 static void __exit bnep_exit(void)
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 78830efe89d7..8f53cc0d9682 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -872,9 +872,7 @@ static int rfcomm_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned lon
 
 	if (err == -ENOIOCTLCMD) {
 #ifdef CONFIG_BT_RFCOMM_TTY
-		lock_sock(sk);
 		err = rfcomm_dev_ioctl(sk, cmd, (void __user *) arg);
-		release_sock(sk);
 #else
 		err = -EOPNOTSUPP;
 #endif
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 35642dc96852..75e35fae6f24 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -37,6 +37,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/addrconf.h>
+#include <net/dst_metadata.h>
 #include <net/route.h>
 #include <net/netfilter/br_netfilter.h>
 #include <net/netns/generic.h>
@@ -737,6 +738,10 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 		return br_dev_queue_push_xmit(net, sk, skb);
 	}
 
+	/* Fragmentation on metadata/template dst is not supported */
+	if (unlikely(!skb_valid_dst(skb)))
+		goto drop;
+
 	/* This is wrong! We should preserve the original fragment
 	 * boundaries by preserving frag_list rather than refragmenting.
 	 */
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 095f68536c14..07c0634b32f7 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1423,8 +1423,10 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
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
diff --git a/net/core/dev.c b/net/core/dev.c
index b5c9648c2192..c5b5dac093d6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3323,7 +3323,22 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		return !!(features & NETIF_F_SCTP_CRC) ? 0 :
 			skb_crc32c_csum_help(skb);
 
-	return !!(features & NETIF_F_CSUM_MASK) ? 0 : skb_checksum_help(skb);
+	if (features & NETIF_F_HW_CSUM)
+		return 0;
+
+	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
+		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+			goto sw_checksum;
+		switch (skb->csum_offset) {
+		case offsetof(struct tcphdr, check):
+		case offsetof(struct udphdr, check):
+			return 0;
+		}
+	}
+
+sw_checksum:
+	return skb_checksum_help(skb);
 }
 EXPORT_SYMBOL(skb_csum_hwoffload_help);
 
@@ -3435,7 +3450,7 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
 						sizeof(_tcphdr), &_tcphdr);
 			if (likely(th))
 				hdr_len += __tcp_hdrlen(th);
-		} else {
+		} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
 			struct udphdr _udphdr;
 
 			if (skb_header_pointer(skb, skb_transport_offset(skb),
@@ -3443,10 +3458,14 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
 				hdr_len += sizeof(struct udphdr);
 		}
 
-		if (shinfo->gso_type & SKB_GSO_DODGY)
-			gso_segs = DIV_ROUND_UP(skb->len - hdr_len,
-						shinfo->gso_size);
+		if (unlikely(shinfo->gso_type & SKB_GSO_DODGY)) {
+			int payload = skb->len - hdr_len;
 
+			/* Malicious packet. */
+			if (payload <= 0)
+				return;
+			gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
+		}
 		qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
 	}
 }
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index e2ab8cdb7134..e4fea3adb065 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -541,10 +541,6 @@ static int inet_set_ifa(struct net_device *dev, struct in_ifaddr *ifa)
 
 	ASSERT_RTNL();
 
-	if (!in_dev) {
-		inet_free_ifa(ifa);
-		return -ENOBUFS;
-	}
 	ipv4_devconf_setall(in_dev);
 	neigh_parms_data_state_setall(in_dev->arp_parms);
 	if (ifa->ifa_dev != in_dev) {
@@ -1113,6 +1109,8 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 
 		if (!ifa) {
 			ret = -ENOBUFS;
+			if (!in_dev)
+				break;
 			ifa = inet_alloc_ifa();
 			if (!ifa)
 				break;
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 9aa48b4c4096..322ba1ba2ac3 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1135,7 +1135,7 @@ static void nl_fib_lookup(struct net *net, struct fib_result_nl *frn)
 	struct flowi4           fl4 = {
 		.flowi4_mark = frn->fl_mark,
 		.daddr = frn->fl_addr,
-		.flowi4_tos = frn->fl_tos,
+		.flowi4_tos = frn->fl_tos & IPTOS_RT_MASK,
 		.flowi4_scope = frn->fl_scope,
 	};
 	struct fib_table *tb;
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 2f5d2109c919..ea30393c8c66 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -711,11 +711,11 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 		if (skb_cow_head(skb, 0))
 			goto free_skb;
 
-		tnl_params = (const struct iphdr *)skb->data;
-
-		if (!pskb_network_may_pull(skb, pull_len))
+		if (!pskb_may_pull(skb, pull_len))
 			goto free_skb;
 
+		tnl_params = (const struct iphdr *)skb->data;
+
 		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
 		skb_pull(skb, pull_len);
 		skb_reset_mac_header(skb);
diff --git a/net/ipv4/netfilter/nf_dup_ipv4.c b/net/ipv4/netfilter/nf_dup_ipv4.c
index 39895b9ddeb9..b385c97ddc29 100644
--- a/net/ipv4/netfilter/nf_dup_ipv4.c
+++ b/net/ipv4/netfilter/nf_dup_ipv4.c
@@ -55,8 +55,9 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 {
 	struct iphdr *iph;
 
+	local_bh_disable();
 	if (this_cpu_read(nf_skb_duplicated))
-		return;
+		goto out;
 	/*
 	 * Copy the skb, and route the copy. Will later return %XT_CONTINUE for
 	 * the original skb, which should continue on its way as if nothing has
@@ -64,7 +65,7 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	 */
 	skb = pskb_copy(skb, GFP_ATOMIC);
 	if (skb == NULL)
-		return;
+		goto out;
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 	/* Avoid counting cloned packets towards the original connection. */
@@ -93,6 +94,8 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	} else {
 		kfree_skb(skb);
 	}
+out:
+	local_bh_enable();
 }
 EXPORT_SYMBOL_GPL(nf_dup_ipv4);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9254705afa86..0f2320d821ff 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1301,7 +1301,7 @@ static bool tcp_shifted_skb(struct sock *sk, struct sk_buff *prev,
 	 */
 	tcp_sacktag_one(sk, state, TCP_SKB_CB(skb)->sacked,
 			start_seq, end_seq, dup_sack, pcount,
-			skb->skb_mstamp);
+			tcp_skb_timestamp_us(skb));
 	tcp_rate_skb_delivered(sk, skb, state->rate);
 
 	if (skb == tp->lost_skb_hint)
@@ -1590,7 +1590,7 @@ static struct sk_buff *tcp_sacktag_walk(struct sk_buff *skb, struct sock *sk,
 						TCP_SKB_CB(skb)->end_seq,
 						dup_sack,
 						tcp_skb_pcount(skb),
-						skb->skb_mstamp);
+						tcp_skb_timestamp_us(skb));
 			tcp_rate_skb_delivered(sk, skb, state->rate);
 			if (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED)
 				list_del_init(&skb->tcp_tsorted_anchor);
@@ -2320,6 +2320,16 @@ static bool tcp_any_retrans_done(const struct sock *sk)
 	return false;
 }
 
+/* If loss recovery is finished and there are no retransmits out in the
+ * network, then we clear retrans_stamp so that upon the next loss recovery
+ * retransmits_timed_out() and timestamp-undo are using the correct value.
+ */
+static void tcp_retrans_stamp_cleanup(struct sock *sk)
+{
+	if (!tcp_any_retrans_done(sk))
+		tcp_sk(sk)->retrans_stamp = 0;
+}
+
 static void DBGUNDO(struct sock *sk, const char *msg)
 {
 #if FASTRETRANS_DEBUG > 1
@@ -2662,6 +2672,9 @@ void tcp_enter_recovery(struct sock *sk, bool ece_ack)
 	struct tcp_sock *tp = tcp_sk(sk);
 	int mib_idx;
 
+	/* Start the clock with our fast retransmit, for undo and ETIMEDOUT. */
+	tcp_retrans_stamp_cleanup(sk);
+
 	if (tcp_is_reno(tp))
 		mib_idx = LINUX_MIB_TCPRENORECOVERY;
 	else
@@ -3140,7 +3153,7 @@ static int tcp_clean_rtx_queue(struct sock *sk, u32 prior_fack,
 				tp->retrans_out -= acked_pcount;
 			flag |= FLAG_RETRANS_DATA_ACKED;
 		} else if (!(sacked & TCPCB_SACKED_ACKED)) {
-			last_ackt = skb->skb_mstamp;
+			last_ackt = tcp_skb_timestamp_us(skb);
 			WARN_ON_ONCE(last_ackt == 0);
 			if (!first_ackt)
 				first_ackt = last_ackt;
@@ -3158,7 +3171,7 @@ static int tcp_clean_rtx_queue(struct sock *sk, u32 prior_fack,
 			tp->delivered += acked_pcount;
 			if (!tcp_skb_spurious_retrans(tp, skb))
 				tcp_rack_advance(tp, sacked, scb->end_seq,
-						 skb->skb_mstamp);
+						 tcp_skb_timestamp_us(skb));
 		}
 		if (sacked & TCPCB_LOST)
 			tp->lost_out -= acked_pcount;
@@ -3253,7 +3266,8 @@ static int tcp_clean_rtx_queue(struct sock *sk, u32 prior_fack,
 			tp->lost_cnt_hint -= min(tp->lost_cnt_hint, delta);
 		}
 	} else if (skb && rtt_update && sack_rtt_us >= 0 &&
-		   sack_rtt_us > tcp_stamp_us_delta(tp->tcp_mstamp, skb->skb_mstamp)) {
+		   sack_rtt_us > tcp_stamp_us_delta(tp->tcp_mstamp,
+						    tcp_skb_timestamp_us(skb))) {
 		/* Do not re-arm RTO if the sack RTT is measured from data sent
 		 * after when the head was last (re)transmitted. Otherwise the
 		 * timeout may continue to extend in loss recovery.
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index aa9aa38471f9..1bf315e83d7b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -115,6 +115,9 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	const struct tcp_timewait_sock *tcptw = tcp_twsk(sktw);
 	struct tcp_sock *tp = tcp_sk(sk);
 
+	if (tw->tw_substate == TCP_FIN_WAIT2)
+		reuse = 0;
+
 	if (reuse == 2) {
 		/* Still does not detect *everything* that goes through
 		 * lo, since we require a loopback src or dst address
@@ -556,7 +559,7 @@ void tcp_v4_err(struct sk_buff *icmp_skb, u32 info)
 		icsk->icsk_rto = inet_csk_rto_backoff(icsk, TCP_RTO_MAX);
 
 		tcp_mstamp_refresh(tp);
-		delta_us = (u32)(tp->tcp_mstamp - skb->skb_mstamp);
+		delta_us = (u32)(tp->tcp_mstamp - tcp_skb_timestamp_us(skb));
 		remaining = icsk->icsk_rto -
 			    usecs_to_jiffies(delta_us);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index fbeb40a481fc..20bce57a19f0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1993,7 +1993,7 @@ static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 	head = tcp_rtx_queue_head(sk);
 	if (!head)
 		goto send_now;
-	age = tcp_stamp_us_delta(tp->tcp_mstamp, head->skb_mstamp);
+	age = tcp_stamp_us_delta(tp->tcp_mstamp, tcp_skb_timestamp_us(head));
 	/* If next ACK is likely to come too late (half srtt), do not defer */
 	if (age < (tp->srtt_us >> 4))
 		goto send_now;
diff --git a/net/ipv4/tcp_rate.c b/net/ipv4/tcp_rate.c
index 4dff40dad4dc..baed2186c7c6 100644
--- a/net/ipv4/tcp_rate.c
+++ b/net/ipv4/tcp_rate.c
@@ -55,8 +55,10 @@ void tcp_rate_skb_sent(struct sock *sk, struct sk_buff *skb)
 	  * bandwidth estimate.
 	  */
 	if (!tp->packets_out) {
-		tp->first_tx_mstamp  = skb->skb_mstamp;
-		tp->delivered_mstamp = skb->skb_mstamp;
+		u64 tstamp_us = tcp_skb_timestamp_us(skb);
+
+		tp->first_tx_mstamp  = tstamp_us;
+		tp->delivered_mstamp = tstamp_us;
 	}
 
 	TCP_SKB_CB(skb)->tx.first_tx_mstamp	= tp->first_tx_mstamp;
@@ -88,13 +90,12 @@ void tcp_rate_skb_delivered(struct sock *sk, struct sk_buff *skb,
 		rs->is_app_limited   = scb->tx.is_app_limited;
 		rs->is_retrans	     = scb->sacked & TCPCB_RETRANS;
 
+		/* Record send time of most recently ACKed packet: */
+		tp->first_tx_mstamp  = tcp_skb_timestamp_us(skb);
 		/* Find the duration of the "send phase" of this window: */
-		rs->interval_us      = tcp_stamp_us_delta(
-						skb->skb_mstamp,
-						scb->tx.first_tx_mstamp);
+		rs->interval_us = tcp_stamp_us_delta(tp->first_tx_mstamp,
+						     scb->tx.first_tx_mstamp);
 
-		/* Record send time of most recently ACKed packet: */
-		tp->first_tx_mstamp  = skb->skb_mstamp;
 	}
 	/* Mark off the skb delivered once it's sacked to avoid being
 	 * used again when it's cumulatively acked. For acked packets
diff --git a/net/ipv4/tcp_recovery.c b/net/ipv4/tcp_recovery.c
index 844ff390f726..db3469c95c49 100644
--- a/net/ipv4/tcp_recovery.c
+++ b/net/ipv4/tcp_recovery.c
@@ -51,7 +51,7 @@ static u32 tcp_rack_reo_wnd(const struct sock *sk)
 s32 tcp_rack_skb_timeout(struct tcp_sock *tp, struct sk_buff *skb, u32 reo_wnd)
 {
 	return tp->rack.rtt_us + reo_wnd -
-	       tcp_stamp_us_delta(tp->tcp_mstamp, skb->skb_mstamp);
+	       tcp_stamp_us_delta(tp->tcp_mstamp, tcp_skb_timestamp_us(skb));
 }
 
 /* RACK loss detection (IETF draft draft-ietf-tcpm-rack-01):
@@ -92,7 +92,8 @@ static void tcp_rack_detect_loss(struct sock *sk, u32 *reo_timeout)
 		    !(scb->sacked & TCPCB_SACKED_RETRANS))
 			continue;
 
-		if (!tcp_rack_sent_after(tp->rack.mstamp, skb->skb_mstamp,
+		if (!tcp_rack_sent_after(tp->rack.mstamp,
+					 tcp_skb_timestamp_us(skb),
 					 tp->rack.end_seq, scb->end_seq))
 			break;
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9058d59acd0a..7763b7f672fa 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3679,6 +3679,7 @@ static int addrconf_ifdown(struct net_device *dev, int how)
 	struct inet6_ifaddr *ifa;
 	LIST_HEAD(tmp_addr_list);
 	bool keep_addr = false;
+	bool was_ready;
 	int state, i;
 
 	ASSERT_RTNL();
@@ -3744,7 +3745,10 @@ static int addrconf_ifdown(struct net_device *dev, int how)
 
 	addrconf_del_rs_timer(idev);
 
-	/* Step 2: clear flags for stateless addrconf */
+	/* Step 2: clear flags for stateless addrconf, repeated down
+	 *         detection
+	 */
+	was_ready = idev->if_flags & IF_READY;
 	if (!how)
 		idev->if_flags &= ~(IF_RS_SENT|IF_RA_RCVD|IF_READY);
 
@@ -3824,7 +3828,7 @@ static int addrconf_ifdown(struct net_device *dev, int how)
 	if (how) {
 		ipv6_ac_destroy_dev(idev);
 		ipv6_mc_destroy_dev(idev);
-	} else {
+	} else if (was_ready) {
 		ipv6_mc_down(idev);
 	}
 
diff --git a/net/ipv6/netfilter/nf_dup_ipv6.c b/net/ipv6/netfilter/nf_dup_ipv6.c
index 4a7ddeddbaab..941e389c227f 100644
--- a/net/ipv6/netfilter/nf_dup_ipv6.c
+++ b/net/ipv6/netfilter/nf_dup_ipv6.c
@@ -50,11 +50,12 @@ static bool nf_dup_ipv6_route(struct net *net, struct sk_buff *skb,
 void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 		 const struct in6_addr *gw, int oif)
 {
+	local_bh_disable();
 	if (this_cpu_read(nf_skb_duplicated))
-		return;
+		goto out;
 	skb = pskb_copy(skb, GFP_ATOMIC);
 	if (skb == NULL)
-		return;
+		goto out;
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 	nf_reset(skb);
@@ -72,6 +73,8 @@ void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	} else {
 		kfree_skb(skb);
 	}
+out:
+	local_bh_enable();
 }
 EXPORT_SYMBOL_GPL(nf_dup_ipv6);
 
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 24858402e374..0edf9c1192de 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -92,33 +92,23 @@ void nf_reject_ip6_tcphdr_put(struct sk_buff *nskb,
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
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index cfbaafcea0a4..1c59b8f90f5c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2443,7 +2443,8 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
-	if (local->ops->get_txpower)
+	if (local->ops->get_txpower &&
+	    (sdata->flags & IEEE80211_SDATA_IN_DRIVER))
 		return drv_get_txpower(local, sdata, dbm);
 
 	if (!local->use_chanctx)
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 358028a09ce4..433083cc1533 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -798,6 +798,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 	unsigned long flags;
+	struct sk_buff_head freeq;
 	struct sk_buff *skb, *tmp;
 	u32 hw_reconf_flags = 0;
 	int i, flushed;
@@ -996,18 +997,32 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 		skb_queue_purge(&sdata->skb_queue);
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
 
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 7fc55177db84..bb09a1ec258d 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -777,6 +777,26 @@ void ieee80211_reset_crypto_tx_tailroom(struct ieee80211_sub_if_data *sdata)
 	mutex_unlock(&sdata->local->key_mtx);
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
@@ -796,16 +816,13 @@ void ieee80211_iter_keys(struct ieee80211_hw *hw,
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
 	mutex_unlock(&local->key_mtx);
 }
@@ -823,17 +840,8 @@ _ieee80211_iter_keys_rcu(struct ieee80211_hw *hw,
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
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index bcb72ad2c178..4101a3ce2e30 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -359,7 +359,7 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 #define ctnetlink_dump_secctx(a, b) (0)
 #endif
 
-#ifdef CONFIG_NF_CONNTRACK_LABELS
+#ifdef CONFIG_NF_CONNTRACK_EVENTS
 static inline int ctnetlink_label_size(const struct nf_conn *ct)
 {
 	struct nf_conn_labels *labels = nf_ct_labels_find(ct);
@@ -368,6 +368,7 @@ static inline int ctnetlink_label_size(const struct nf_conn *ct)
 		return 0;
 	return nla_total_size(sizeof(labels->bits));
 }
+#endif
 
 static int
 ctnetlink_dump_labels(struct sk_buff *skb, const struct nf_conn *ct)
@@ -388,10 +389,6 @@ ctnetlink_dump_labels(struct sk_buff *skb, const struct nf_conn *ct)
 
 	return 0;
 }
-#else
-#define ctnetlink_dump_labels(a, b) (0)
-#define ctnetlink_label_size(a)	(0)
-#endif
 
 #define master_tuple(ct) &(ct->master->tuplehash[IP_CT_DIR_ORIGINAL].tuple)
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a033c9baf58a..25b2870dda24 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3339,7 +3339,7 @@ int nf_msecs_to_jiffies64(const struct nlattr *nla, u64 *result)
 		return -ERANGE;
 
 	ms *= NSEC_PER_MSEC;
-	*result = nsecs_to_jiffies64(ms);
+	*result = nsecs_to_jiffies64(ms) ? : !!ms;
 	return 0;
 }
 
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 0ef51c81ec94..128195a7ea5e 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -306,6 +306,9 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 	if ((priv->csum_type == NFT_PAYLOAD_CSUM_INET || priv->csum_flags) &&
 	    (priv->base != NFT_PAYLOAD_TRANSPORT_HEADER ||
 	     skb->ip_summed != CHECKSUM_PARTIAL)) {
+		if (offset + priv->len > skb->len)
+			goto err;
+
 		fsum = skb_checksum(skb, offset, priv->len, 0);
 		tsum = csum_partial(src, priv->len, 0);
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 1fe9b4a04b22..2e26ecb46707 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2145,8 +2145,9 @@ void __netlink_clear_multicast_users(struct sock *ksk, unsigned int group)
 {
 	struct sock *sk;
 	struct netlink_table *tbl = &nl_table[ksk->sk_protocol];
+	struct hlist_node *tmp;
 
-	sk_for_each_bound(sk, &tbl->mc_list)
+	sk_for_each_bound_safe(sk, tmp, &tbl->mc_list)
 		netlink_update_socket_mc(nlk_sk(sk), group, 0);
 }
 
diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index 128d0a48478d..890a8fe51a9a 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -718,7 +718,7 @@ static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 
 	mutex_lock(&qrtr_node_lock);
 	list_for_each_entry(node, &qrtr_all_nodes, item) {
-		skbn = skb_clone(skb, GFP_KERNEL);
+		skbn = pskb_copy(skb, GFP_KERNEL);
 		if (!skbn)
 			break;
 		skb_set_owner_w(skbn, skb->sk);
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index ab57c0ee9923..49c4e8525788 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -783,7 +783,7 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, unsigned int n,
 	drops = max_t(int, n, 0);
 	rcu_read_lock();
 	while ((parentid = sch->parent)) {
-		if (TC_H_MAJ(parentid) == TC_H_MAJ(TC_H_INGRESS))
+		if (parentid == TC_H_ROOT)
 			break;
 
 		if (sch->flags & TCQ_F_NOPARENT)
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c429a1a2bfe2..421b0340b631 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7845,8 +7845,10 @@ static int sctp_listen_start(struct sock *sk, int backlog)
 	 */
 	inet_sk_set_state(sk, SCTP_SS_LISTENING);
 	if (!ep->base.bind_addr.port) {
-		if (sctp_autobind(sk))
+		if (sctp_autobind(sk)) {
+			inet_sk_set_state(sk, SCTP_SS_CLOSED);
 			return -EAGAIN;
+		}
 	} else {
 		if (sctp_get_port(sk, inet_sk(sk)->inet_num)) {
 			inet_sk_set_state(sk, SCTP_SS_CLOSED);
diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index c7686ff00f5b..5ceb7d489686 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -158,8 +158,12 @@ static int bearer_name_validate(const char *name,
 
 	/* return bearer name components, if necessary */
 	if (name_parts) {
-		strcpy(name_parts->media_name, media_name);
-		strcpy(name_parts->if_name, if_name);
+		if (strscpy(name_parts->media_name, media_name,
+			    TIPC_MAX_MEDIA_NAME) < 0)
+			return 0;
+		if (strscpy(name_parts->if_name, if_name,
+			    TIPC_MAX_IF_NAME) < 0)
+			return 0;
 	}
 	return 1;
 }
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ebd8449f2fcf..f3f01ab1abd3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7578,7 +7578,8 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
 		return ERR_PTR(-ENOMEM);
 
 	if (n_ssids)
-		request->ssids = (void *)&request->channels[n_channels];
+		request->ssids = (void *)request +
+			struct_size(request, channels, n_channels);
 	request->n_ssids = n_ssids;
 	if (ie_len) {
 		if (n_ssids)
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 0dc27703443c..4c6c333011e0 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1414,8 +1414,8 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 		n_channels = ieee80211_get_num_supported_channels(wiphy);
 	}
 
-	creq = kzalloc(sizeof(*creq) + sizeof(struct cfg80211_ssid) +
-		       n_channels * sizeof(void *),
+	creq = kzalloc(struct_size(creq, channels, n_channels) +
+		       sizeof(struct cfg80211_ssid),
 		       GFP_ATOMIC);
 	if (!creq) {
 		err = -ENOMEM;
@@ -1425,7 +1425,7 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 	creq->wiphy = wiphy;
 	creq->wdev = dev->ieee80211_ptr;
 	/* SSIDs come after channels */
-	creq->ssids = (void *)&creq->channels[n_channels];
+	creq->ssids = (void *)creq + struct_size(creq, channels, n_channels);
 	creq->n_channels = n_channels;
 	creq->n_ssids = 1;
 	creq->scan_start = jiffies;
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index ebc73faa8fb1..4e6afb765e81 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -116,7 +116,8 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 		n_channels = i;
 	}
 	request->n_channels = n_channels;
-	request->ssids = (void *)&request->channels[n_channels];
+	request->ssids = (void *)request +
+		struct_size(request, channels, n_channels);
 	request->n_ssids = 1;
 
 	memcpy(request->ssids[0].ssid, wdev->conn->params.ssid,
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 5892ff68d168..8146ef538ab3 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -148,6 +148,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 			     struct nlattr **attrs)
 {
 	int err;
+	u16 family = p->sel.family;
 
 	err = -EINVAL;
 	switch (p->family) {
@@ -166,7 +167,10 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		goto out;
 	}
 
-	switch (p->sel.family) {
+	if (!family && !(p->flags & XFRM_STATE_AF_UNSPEC))
+		family = p->family;
+
+	switch (family) {
 	case AF_UNSPEC:
 		break;
 
diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index 67d131447631..6b918882d32c 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -128,6 +128,8 @@ for MERGE_FILE in $MERGE_LIST ; do
 		fi
 		sed -i "/$CFG[ =]/d" $TMP_FILE
 	done
+	# In case the previous file lacks a new line at the end
+	echo >> $TMP_FILE
 	cat $MERGE_FILE >> $TMP_FILE
 done
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 60b3f16bb5c7..c35aab9f2447 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -536,6 +536,16 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	ssize_t length;
 	void *data = NULL;
 
+	/* no partial writes */
+	if (*ppos)
+		return -EINVAL;
+	/* no empty policies */
+	if (!count)
+		return -EINVAL;
+
+	if (count > 64 * 1024 * 1024)
+		return -EFBIG;
+
 	mutex_lock(&fsi->mutex);
 
 	length = avc_has_perm(&selinux_state,
@@ -544,23 +554,15 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (length)
 		goto out;
 
-	/* No partial writes. */
-	length = -EINVAL;
-	if (*ppos != 0)
-		goto out;
-
-	length = -EFBIG;
-	if (count > 64 * 1024 * 1024)
-		goto out;
-
-	length = -ENOMEM;
 	data = vmalloc(count);
-	if (!data)
+	if (!data) {
+		length = -ENOMEM;
 		goto out;
-
-	length = -EFAULT;
-	if (copy_from_user(data, buf, count) != 0)
+	}
+	if (copy_from_user(data, buf, count) != 0) {
+		length = -EFAULT;
 		goto out;
+	}
 
 	length = security_load_policy(fsi->state, data, count);
 	if (length) {
@@ -579,6 +581,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		"auid=%u ses=%u lsm=selinux res=1",
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
+
 out:
 	mutex_unlock(&fsi->mutex);
 	vfree(data);
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 61e734baa332..83dbfa26a651 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -948,7 +948,7 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	rc = smk_netlbl_mls(maplevel, mapcatset, &ncats, SMK_CIPSOLEN);
 	if (rc >= 0) {
 		old_cat = skp->smk_netlabel.attr.mls.cat;
-		skp->smk_netlabel.attr.mls.cat = ncats.attr.mls.cat;
+		rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
 		skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;
 		synchronize_rcu();
 		netlbl_catmap_free(old_cat);
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index f6758dad981f..0271b40b4bb6 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -701,10 +701,13 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 	ee->r.obj = &ee->obj;
 	ee->obj.path1 = bprm->file->f_path;
 	/* Get symlink's pathname of program. */
-	retval = -ENOENT;
 	exename.name = tomoyo_realpath_nofollow(original_name);
-	if (!exename.name)
-		goto out;
+	if (!exename.name) {
+		/* Fallback to realpath if symlink's pathname does not exist. */
+		exename.name = tomoyo_realpath_from_path(&bprm->file->f_path);
+		if (!exename.name)
+			goto out;
+	}
 	tomoyo_fill_path_info(&exename);
 retry:
 	/* Check 'aggregator' directive. */
diff --git a/sound/core/init.c b/sound/core/init.c
index 3eafa15006f8..ed093184ea16 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -548,13 +548,19 @@ int snd_card_free(struct snd_card *card)
 }
 EXPORT_SYMBOL(snd_card_free);
 
+/* check, if the character is in the valid ASCII range */
+static inline bool safe_ascii_char(char c)
+{
+	return isascii(c) && isalnum(c);
+}
+
 /* retrieve the last word of shortname or longname */
 static const char *retrieve_id_from_card_name(const char *name)
 {
 	const char *spos = name;
 
 	while (*name) {
-		if (isspace(*name) && isalnum(name[1]))
+		if (isspace(*name) && safe_ascii_char(name[1]))
 			spos = name + 1;
 		name++;
 	}
@@ -581,12 +587,12 @@ static void copy_valid_id_string(struct snd_card *card, const char *src,
 {
 	char *id = card->id;
 
-	while (*nid && !isalnum(*nid))
+	while (*nid && !safe_ascii_char(*nid))
 		nid++;
 	if (isdigit(*nid))
 		*id++ = isalpha(*src) ? *src : 'D';
 	while (*nid && (size_t)(id - card->id) < sizeof(card->id) - 1) {
-		if (isalnum(*nid))
+		if (safe_ascii_char(*nid))
 			*id++ = *nid;
 		nid++;
 	}
@@ -684,7 +690,7 @@ card_id_store_attr(struct device *dev, struct device_attribute *attr,
 
 	for (idx = 0; idx < copy; idx++) {
 		c = buf[idx];
-		if (!isalnum(c) && c != '_' && c != '-')
+		if (!safe_ascii_char(c) && c != '_' && c != '-')
 			return -EINVAL;
 	}
 	memcpy(buf1, buf, copy);
diff --git a/sound/pci/asihpi/hpimsgx.c b/sound/pci/asihpi/hpimsgx.c
index 736f45337fc7..5be1d910a5d5 100644
--- a/sound/pci/asihpi/hpimsgx.c
+++ b/sound/pci/asihpi/hpimsgx.c
@@ -724,7 +724,7 @@ static u16 HPIMSGX__init(struct hpi_message *phm,
 		phr->error = HPI_ERROR_PROCESSING_MESSAGE;
 		return phr->error;
 	}
-	if (hr.error == 0) {
+	if (hr.error == 0 && hr.u.s.adapter_index < HPI_MAX_ADAPTERS) {
 		/* the adapter was created successfully
 		   save the mapping for future use */
 		hpi_entry_points[hr.u.s.adapter_index] = entry_point_func;
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f4b07dc6f1cc..e48dca4d6e43 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1383,7 +1383,7 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 		struct nid_path *path;
 		hda_nid_t pin = pins[i];
 
-		if (!spec->obey_preferred_dacs) {
+		if (!spec->preferred_dacs) {
 			path = snd_hda_get_path_from_idx(codec, path_idx[i]);
 			if (path) {
 				badness += assign_out_path_ctls(codec, path);
@@ -1395,7 +1395,7 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 		if (dacs[i]) {
 			if (is_dac_already_used(codec, dacs[i]))
 				badness += bad->shared_primary;
-		} else if (spec->obey_preferred_dacs) {
+		} else if (spec->preferred_dacs) {
 			badness += BAD_NO_PRIMARY_DAC;
 		}
 
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 1d95977b4a91..ad658f698257 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -730,6 +730,23 @@ static const struct hda_pintbl cxt_pincfg_sws_js201d[] = {
 	{}
 };
 
+/* pincfg quirk for Tuxedo Sirius;
+ * unfortunately the (PCI) SSID conflicts with System76 Pangolin pang14,
+ * which has incompatible pin setup, so we check the codec SSID (luckily
+ * different one!) and conditionally apply the quirk here
+ */
+static void cxt_fixup_sirius_top_speaker(struct hda_codec *codec,
+					 const struct hda_fixup *fix,
+					 int action)
+{
+	/* ignore for incorrectly picked-up pang14 */
+	if (codec->core.subsystem_id == 0x278212b3)
+		return;
+	/* set up the top speaker pin */
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		snd_hda_codec_set_pincfg(codec, 0x1d, 0x82170111);
+}
+
 static const struct hda_fixup cxt_fixups[] = {
 	[CXT_PINCFG_LENOVO_X200] = {
 		.type = HDA_FIXUP_PINS,
@@ -886,11 +903,8 @@ static const struct hda_fixup cxt_fixups[] = {
 		.v.pins = cxt_pincfg_sws_js201d,
 	},
 	[CXT_PINCFG_TOP_SPEAKER] = {
-		.type = HDA_FIXUP_PINS,
-		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x1d, 0x82170111 },
-			{ }
-		},
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_sirius_top_speaker,
 	},
 };
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 60dfaf2adaaf..f33d09d939e1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3537,20 +3537,18 @@ static void alc_default_init(struct hda_codec *codec)
 
 	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 
-	if (hp_pin_sense)
+	if (hp_pin_sense) {
 		msleep(2);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-
-	if (hp_pin_sense)
-		msleep(85);
+		snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		msleep(75);
 
-	if (hp_pin_sense)
-		msleep(100);
+		snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+		msleep(75);
+	}
 }
 
 static void alc_default_shutup(struct hda_codec *codec)
@@ -3566,22 +3564,20 @@ static void alc_default_shutup(struct hda_codec *codec)
 
 	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 
-	if (hp_pin_sense)
+	if (hp_pin_sense) {
 		msleep(2);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-
-	if (hp_pin_sense)
-		msleep(85);
-
-	if (!spec->no_shutup_pins)
 		snd_hda_codec_write(codec, hp_pin, 0,
-				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
-	if (hp_pin_sense)
-		msleep(100);
+		msleep(75);
 
+		if (!spec->no_shutup_pins)
+			snd_hda_codec_write(codec, hp_pin, 0,
+					    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+		msleep(75);
+	}
 	alc_auto_setup_eapd(codec, false);
 	alc_shutup_pins(codec);
 }
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index a0797fc17d95..b2e38524b1fe 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -1322,8 +1322,10 @@ static int snd_hdsp_midi_output_possible (struct hdsp *hdsp, int id)
 
 static void snd_hdsp_flush_midi_input (struct hdsp *hdsp, int id)
 {
-	while (snd_hdsp_midi_input_available (hdsp, id))
-		snd_hdsp_midi_read_byte (hdsp, id);
+	int count = 256;
+
+	while (snd_hdsp_midi_input_available(hdsp, id) && --count)
+		snd_hdsp_midi_read_byte(hdsp, id);
 }
 
 static int snd_hdsp_midi_output_write (struct hdsp_midi *hmidi)
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 5dfddade1bae..cc8313913d64 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1846,8 +1846,10 @@ static inline int snd_hdspm_midi_output_possible (struct hdspm *hdspm, int id)
 
 static void snd_hdspm_flush_midi_input(struct hdspm *hdspm, int id)
 {
-	while (snd_hdspm_midi_input_available (hdspm, id))
-		snd_hdspm_midi_read_byte (hdspm, id);
+	int count = 256;
+
+	while (snd_hdspm_midi_input_available(hdspm, id) && --count)
+		snd_hdspm_midi_read_byte(hdspm, id);
 }
 
 static int snd_hdspm_midi_output_write (struct hdspm_midi *hmidi)
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 301e1fc9a377..24d16e6bf750 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -43,6 +43,7 @@ static const struct platform_device_id db1200_pids[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(platform, db1200_pids);
 
 /*-------------------------  AC97 PART  ---------------------------*/
 
diff --git a/sound/soc/codecs/tda7419.c b/sound/soc/codecs/tda7419.c
index 7f3b79c5a563..a3fc9b7fefd8 100644
--- a/sound/soc/codecs/tda7419.c
+++ b/sound/soc/codecs/tda7419.c
@@ -637,6 +637,7 @@ static const struct of_device_id tda7419_of_match[] = {
 	{ .compatible = "st,tda7419" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, tda7419_of_match);
 
 static struct i2c_driver tda7419_driver = {
 	.driver = {
diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index ca9f33fa51c9..e8cf3dc8de72 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -483,6 +483,10 @@ int main(int argc, char **argv)
 			return -ENOMEM;
 		}
 		trigger_name = malloc(IIO_MAX_NAME_LENGTH);
+		if (!trigger_name) {
+			ret = -ENOMEM;
+			goto error;
+		}
 		ret = read_sysfs_string("name", trig_dev_name, trigger_name);
 		free(trig_dev_name);
 		if (ret < 0) {
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 4562e3b2f4d3..cf8dc3910ef2 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2553,9 +2553,12 @@ static int timehist_sched_change_event(struct perf_tool *tool,
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
@@ -2994,7 +2997,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
 
 	if (perf_time__parse_str(&sched->ptime, sched->time_str) != 0) {
 		pr_err("Invalid time string\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto out;
 	}
 
 	if (timehist_check_attr(sched, evlist) != 0)
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 6193b46050a5..540a71450de5 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -17,7 +17,7 @@ int parse_nsec_time(const char *str, u64 *ptime)
 	u64 time_sec, time_nsec;
 	char *end;
 
-	time_sec = strtoul(str, &end, 10);
+	time_sec = strtoull(str, &end, 10);
 	if (*end != '.' && *end != '\0')
 		return -1;
 
@@ -35,7 +35,7 @@ int parse_nsec_time(const char *str, u64 *ptime)
 		for (i = strlen(nsec_buf); i < 9; i++)
 			nsec_buf[i] = '0';
 
-		time_nsec = strtoul(nsec_buf, &end, 10);
+		time_nsec = strtoull(nsec_buf, &end, 10);
 		if (*end != '\0')
 			return -1;
 	} else
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index a29d9e125b00..fe73902a197c 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1969,7 +1969,7 @@ sub get_grub_index {
     } elsif ($reboot_type eq "grub2") {
 	$command = "cat $grub_file";
 	$target = '^\s*menuentry.*' . $grub_menu_qt;
-	$skip = '^\s*menuentry';
+	$skip = '^\s*menuentry\s';
 	$submenu = '^\s*submenu\s';
     } elsif ($reboot_type eq "grub2bls") {
         $command = $grub_bls_get;
diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index 781c7de343be..a9ed4b58c087 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -76,7 +76,8 @@ static int sched_next_online(int pid, int *next_to_try)
 
 	while (next < nr_cpus) {
 		CPU_ZERO(&cpuset);
-		CPU_SET(next++, &cpuset);
+		CPU_SET(next, &cpuset);
+		next++;
 		if (!sched_setaffinity(pid, sizeof(cpuset), &cpuset)) {
 			ret = 0;
 			break;
diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index f82dcc1f8841..67a2aaf1f9d9 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -161,7 +161,10 @@ void suspend(void)
 	if (err < 0)
 		ksft_exit_fail_msg("timerfd_settime() failed\n");
 
-	if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
+	system("(echo mem > /sys/power/state) 2> /dev/null");
+
+	timerfd_gettime(timerfd, &spec);
+	if (spec.it_value.tv_sec != 0 || spec.it_value.tv_nsec != 0)
 		ksft_exit_fail_msg("Failed to enter Suspend state\n");
 
 	close(timerfd);
diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index d7a8e321bb16..60305f858c48 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -89,7 +89,6 @@ int main(int argc, char **argv)
 		int ret;
 
 		ksft_print_header();
-		ksft_set_plan(3);
 
 		fd2 = open(kpath, O_RDWR);
 		if (fd2 < 0) {
diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 9ef3ad3789c1..540f9a284e9f 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -238,7 +238,8 @@ void *vdso_sym(const char *version, const char *name)
 		ELF(Sym) *sym = &vdso_info.symtab[chain];
 
 		/* Check for a defined global or weak function w/ right name. */
-		if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC)
+		if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC &&
+		    ELF64_ST_TYPE(sym->st_info) != STT_NOTYPE)
 			continue;
 		if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL &&
 		    ELF64_ST_BIND(sym->st_info) != STB_WEAK)
diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/selftests/vm/compaction_test.c
index e056cfc487e0..e7044fa7f0b7 100644
--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -183,8 +183,6 @@ int main(int argc, char **argv)
 	if (prereq() != 0)
 		return ksft_exit_pass();
 
-	ksft_set_plan(1);
-
 	lim.rlim_cur = RLIM_INFINITY;
 	lim.rlim_max = RLIM_INFINITY;
 	if (setrlimit(RLIMIT_MEMLOCK, &lim))
diff --git a/tools/usb/usbip/src/usbip_detach.c b/tools/usb/usbip/src/usbip_detach.c
index 777f7286a0c5..744a95d49d65 100644
--- a/tools/usb/usbip/src/usbip_detach.c
+++ b/tools/usb/usbip/src/usbip_detach.c
@@ -80,6 +80,7 @@ static int detach_port(char *port)
 	}
 
 	if (!found) {
+		ret = -1;
 		err("Invalid port %s > maxports %d",
 			port, vhci_driver->nports);
 		goto call_driver_close;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6f9c0060a3e5..92a998a57772 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2586,12 +2586,13 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 {
 	struct kvm *kvm = me->kvm;
 	struct kvm_vcpu *vcpu;
-	int last_boosted_vcpu = me->kvm->last_boosted_vcpu;
+	int last_boosted_vcpu;
 	int yielded = 0;
 	int try = 3;
 	int pass;
 	int i;
 
+	last_boosted_vcpu = READ_ONCE(kvm->last_boosted_vcpu);
 	kvm_vcpu_set_in_spin_loop(me, true);
 	/*
 	 * We boost the priority of a VCPU that is runnable but not
@@ -2620,7 +2621,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 
 			yielded = kvm_vcpu_yield_to(vcpu);
 			if (yielded > 0) {
-				kvm->last_boosted_vcpu = i;
+				WRITE_ONCE(kvm->last_boosted_vcpu, i);
 				break;
 			} else if (yielded < 0) {
 				try--;

