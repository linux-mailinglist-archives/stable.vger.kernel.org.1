Return-Path: <stable+bounces-176624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 148B6B3A246
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 16:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268C7189225D
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909C6314A69;
	Thu, 28 Aug 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ai9le17L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A340314A63;
	Thu, 28 Aug 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392000; cv=none; b=eBCv4vgscJTAY+gxAY92UEnDch9fIbusFcwByyMIXwp3w6/v1ukUVl9JvhORwSd5JtWWWw+qqCn7vzb2KJZS14n8v+udXZEKCuuwTYnX0V9qe3XZbbFuAz+8b50LSh1tTHQjpLRDixt1+M8p6EY6JarmCdrtkGrVZ1QUJnPmECE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392000; c=relaxed/simple;
	bh=TVCDAwtBwqJ1GLXLpfM0+pQz1YLEx30Gh8fHHoG5nM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+UDOwylsVr6TTI5uo/AF9IaMNcA/zsFP9h8SxnyeHoMd9UTMLvQo/fMMIwUWyenJB3QoyWhIa08fIyW11ARBZug4BjyWAit1roh5gsTt/MEW9Ro5jdpTbgDenVyWUVCTfSvw3Y9Slv76ai/GgeAaD6fnZMBO7MCTfB96sNZIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ai9le17L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42A0C4CEED;
	Thu, 28 Aug 2025 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756392000;
	bh=TVCDAwtBwqJ1GLXLpfM0+pQz1YLEx30Gh8fHHoG5nM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ai9le17LEsjFkGbd3Y34ebb9Jq59LQ/iTzB1ta+/MOjCueu0dmB+IjpJW5oPTJPWV
	 X8bVa/UuDyaLuvem3bcsAOQD292bCdymbmQR+WWC5iolP9HklRAv+7aY8IdhQUgeD4
	 Eczb5Xa/Me/lwoEdYI4WwEsgyI8SV5/7nhmzJp2k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.149
Date: Thu, 28 Aug 2025 16:39:47 +0200
Message-ID: <2025082846-cash-charcoal-3ee7@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082846-enchilada-dugout-af44@gregkh>
References: <2025082846-enchilada-dugout-af44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
index 4ebea60b8c5b..8c52fa0ea5f8 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
@@ -25,7 +25,7 @@ properties:
     maxItems: 1
 
   clocks:
-    minItems: 2
+    maxItems: 2
 
   clock-names:
     items:
diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
index bc5594d18643..300bf2252c3e 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
@@ -20,7 +20,7 @@ properties:
     maxItems: 2
 
   clocks:
-    minItems: 1
+    maxItems: 1
 
   clock-names:
     items:
diff --git a/Documentation/firmware-guide/acpi/i2c-muxes.rst b/Documentation/firmware-guide/acpi/i2c-muxes.rst
index 3a8997ccd7c4..f366539acd79 100644
--- a/Documentation/firmware-guide/acpi/i2c-muxes.rst
+++ b/Documentation/firmware-guide/acpi/i2c-muxes.rst
@@ -14,7 +14,7 @@ Consider this topology::
     |      |   | 0x70 |--CH01--> i2c client B (0x50)
     +------+   +------+
 
-which corresponds to the following ASL::
+which corresponds to the following ASL (in the scope of \_SB)::
 
     Device (SMB1)
     {
@@ -24,7 +24,7 @@ which corresponds to the following ASL::
             Name (_HID, ...)
             Name (_CRS, ResourceTemplate () {
                 I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
-                            AddressingMode7Bit, "^SMB1", 0x00,
+                            AddressingMode7Bit, "\\_SB.SMB1", 0x00,
                             ResourceConsumer,,)
             }
 
@@ -37,7 +37,7 @@ which corresponds to the following ASL::
                     Name (_HID, ...)
                     Name (_CRS, ResourceTemplate () {
                         I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                    AddressingMode7Bit, "^CH00", 0x00,
+                                    AddressingMode7Bit, "\\_SB.SMB1.CH00", 0x00,
                                     ResourceConsumer,,)
                     }
                 }
@@ -52,7 +52,7 @@ which corresponds to the following ASL::
                     Name (_HID, ...)
                     Name (_CRS, ResourceTemplate () {
                         I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                    AddressingMode7Bit, "^CH01", 0x00,
+                                    AddressingMode7Bit, "\\_SB.SMB1.CH01", 0x00,
                                     ResourceConsumer,,)
                     }
                 }
diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index 96cd7a26f3d9..870b4e134318 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -444,6 +444,18 @@ arp_missed_max
 
 	The default value is 2, and the allowable range is 1 - 255.
 
+coupled_control
+
+    Specifies whether the LACP state machine's MUX in the 802.3ad mode
+    should have separate Collecting and Distributing states.
+
+    This is by implementing the independent control state machine per
+    IEEE 802.1AX-2008 5.4.15 in addition to the existing coupled control
+    state machine.
+
+    The default value is 1. This setting does not separate the Collecting
+    and Distributing states, maintaining the bond in coupled control.
+
 downdelay
 
 	Specifies the time, in milliseconds, to wait before disabling
diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 213510698014..722b4395e91b 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -20,6 +20,8 @@ add_addr_timeout - INTEGER (seconds)
 	resent to an MPTCP peer that has not acknowledged a previous
 	ADD_ADDR message.
 
+	Do not retransmit if set to 0.
+
 	The default value matches TCP_RTO_MAX. This is a per-namespace
 	sysctl.
 
diff --git a/Makefile b/Makefile
index dd9e4faf0fd5..18a7ced92ff8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 148
+SUBLEVEL = 149
 EXTRAVERSION =
 NAME = Curry Ramen
 
@@ -1143,7 +1143,7 @@ KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD
 KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # userspace programs are linked via the compiler, use the correct linker
-ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)
+ifdef CONFIG_CC_IS_CLANG
 KBUILD_USERLDFLAGS += $(call cc-option, --ld-path=$(LD))
 endif
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c846119c448f..590617240947 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -133,7 +133,7 @@ endif
 
 # Need -Uarm for gcc < 3.x
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include $(srctree)/arch/arm/include/asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
 
diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 36915a073c23..f432d22bfed8 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -279,11 +279,6 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
-		if (rockchip_smp_prepare_sram(node)) {
-			of_node_put(node);
-			return;
-		}
-
 		/* enable the SCU power domain */
 		pmu_set_power_domain(PMU_PWRDN_SCU, true);
 
@@ -316,11 +311,19 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 		asm ("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
 		ncores = ((l2ctlr >> 24) & 0x3) + 1;
 	}
-	of_node_put(node);
 
 	/* Make sure that all cores except the first are really off */
 	for (i = 1; i < ncores; i++)
 		pmu_set_power_domain(0 + i, false);
+
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
+		if (rockchip_smp_prepare_sram(node)) {
+			of_node_put(node);
+			return;
+		}
+	}
+
+	of_node_put(node);
 }
 
 static void __init rk3036_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index d5c805adf7a8..ea706fac6358 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -63,7 +63,7 @@ static void __init tegra_cpu_reset_handler_enable(void)
 	BUG_ON(is_enabled);
 	BUG_ON(tegra_cpu_reset_handler_size > TEGRA_IRAM_RESET_HANDLER_SIZE);
 
-	memcpy(iram_base, (void *)__tegra_cpu_reset_handler_start,
+	memcpy_toio(iram_base, (void *)__tegra_cpu_reset_handler_start,
 			tegra_cpu_reset_handler_size);
 
 	err = call_firmware_op(set_cpu_boot_addr, 0, reset_address);
diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 04222028e53e..c05efc0f0ce7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -386,7 +386,6 @@ sdhci0: mmc@fa10000 {
 		clock-names = "clk_ahb", "clk_xin";
 		assigned-clocks = <&k3_clks 57 6>;
 		assigned-clock-parents = <&k3_clks 57 8>;
-		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
 		ti,trm-icp = <0x2>;
 		bus-width = <8>;
diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 702587fda70c..8cbbd08cc8c5 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -128,7 +128,7 @@ acpi_set_mailbox_entry(int cpu, struct acpi_madt_generic_interrupt *processor)
 {}
 #endif
 
-static inline const char *acpi_get_enable_method(int cpu)
+static __always_inline const char *acpi_get_enable_method(int cpu)
 {
 	if (acpi_psci_present())
 		return "psci";
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 840cc48b5147..5d2322eeee47 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -343,6 +343,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_ECBHB_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_TIDCP1_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_AFP_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_ETS_SHIFT, 4, 0),
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 62146d48dba7..4b4a9aa76e1a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -827,6 +827,7 @@ SYM_CODE_END(__bp_harden_el1_vectors)
  *
  */
 SYM_FUNC_START(cpu_switch_to)
+	save_and_disable_daif x11
 	mov	x10, #THREAD_CPU_CONTEXT
 	add	x8, x0, x10
 	mov	x9, sp
@@ -850,6 +851,7 @@ SYM_FUNC_START(cpu_switch_to)
 	ptrauth_keys_install_kernel x1, x8, x9, x10
 	scs_save x0
 	scs_load_current
+	restore_irq x11
 	ret
 SYM_FUNC_END(cpu_switch_to)
 NOKPROBE(cpu_switch_to)
@@ -876,6 +878,7 @@ NOKPROBE(ret_from_fork)
  * Calls func(regs) using this CPU's irq stack and shadow irq stack.
  */
 SYM_FUNC_START(call_on_irq_stack)
+	save_and_disable_daif x9
 #ifdef CONFIG_SHADOW_CALL_STACK
 	get_current_task x16
 	scs_save x16
@@ -890,8 +893,10 @@ SYM_FUNC_START(call_on_irq_stack)
 
 	/* Move to the new stack and call the function there */
 	add	sp, x16, #IRQ_STACK_SIZE
+	restore_irq x9
 	blr	x1
 
+	save_and_disable_daif x9
 	/*
 	 * Restore the SP from the FP, and restore the FP and LR from the frame
 	 * record.
@@ -899,6 +904,7 @@ SYM_FUNC_START(call_on_irq_stack)
 	mov	sp, x29
 	ldp	x29, x30, [sp], #16
 	scs_load_current
+	restore_irq x9
 	ret
 SYM_FUNC_END(call_on_irq_stack)
 NOKPROBE(call_on_irq_stack)
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 837d1937300a..bc42163a7fd1 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1851,10 +1851,10 @@ void fpsimd_save_and_flush_cpu_state(void)
 	if (!system_supports_fpsimd())
 		return;
 	WARN_ON(preemptible());
-	__get_cpu_fpsimd_context();
+	get_cpu_fpsimd_context();
 	fpsimd_save();
 	fpsimd_flush_cpu_state();
-	__put_cpu_fpsimd_context();
+	put_cpu_fpsimd_context();
 }
 
 #ifdef CONFIG_KERNEL_MODE_NEON
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 23d281ed7621..09489e92ff94 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -911,6 +911,7 @@ void panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigned long far)
 
 void __noreturn arm64_serror_panic(struct pt_regs *regs, unsigned long esr)
 {
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
 	console_verbose();
 
 	pr_crit("SError Interrupt on CPU%d, code 0x%016lx -- %s\n",
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 6b6b8a82f294..0776c98ad27f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -710,6 +710,7 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
 		 */
 		siaddr  = untagged_addr(far);
 	}
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
 	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
 
 	return 0;
diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 68bf1a125502..1e308328c079 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/debugfs.h>
-#include <linux/memory_hotplug.h>
 #include <linux/seq_file.h>
 
 #include <asm/ptdump.h>
@@ -9,9 +8,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 {
 	struct ptdump_info *info = m->private;
 
-	get_online_mems();
 	ptdump_walk(m, info);
-	put_online_mems();
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(ptdump);
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 93e9110aafa1..ec5123c19612 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -201,11 +201,9 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
 
-/* initialized on the first pass of build_body() */
-static int out_offset = -1;
-static int emit_bpf_tail_call(struct jit_ctx *ctx)
+static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 {
-	int off;
+	int off, tc_ninsn = 0;
 	u8 tcc = tail_call_reg(ctx);
 	u8 a1 = LOONGARCH_GPR_A1;
 	u8 a2 = LOONGARCH_GPR_A2;
@@ -215,7 +213,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	const int idx0 = ctx->idx;
 
 #define cur_offset (ctx->idx - idx0)
-#define jmp_offset (out_offset - (cur_offset))
+#define jmp_offset (tc_ninsn - (cur_offset))
 
 	/*
 	 * a0: &ctx
@@ -225,6 +223,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 * if (index >= array->map.max_entries)
 	 *	 goto out;
 	 */
+	tc_ninsn = insn ? ctx->offset[insn+1] - ctx->offset[insn] : ctx->offset[0];
 	off = offsetof(struct bpf_array, map.max_entries);
 	emit_insn(ctx, ldwu, t1, a1, off);
 	/* bgeu $a2, $t1, jmp_offset */
@@ -256,15 +255,6 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	emit_insn(ctx, ldd, t3, t2, off);
 	__build_epilogue(ctx, true);
 
-	/* out: */
-	if (out_offset == -1)
-		out_offset = cur_offset;
-	if (cur_offset != out_offset) {
-		pr_err_once("tail_call out_offset = %d, expected %d!\n",
-			    cur_offset, out_offset);
-		return -1;
-	}
-
 	return 0;
 
 toofar:
@@ -789,7 +779,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* tail call */
 	case BPF_JMP | BPF_TAIL_CALL:
 		mark_tail_call(ctx);
-		if (emit_bpf_tail_call(ctx) < 0)
+		if (emit_bpf_tail_call(ctx, i) < 0)
 			return -EINVAL;
 		break;
 
@@ -1170,7 +1160,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (tmp_blinded)
 		bpf_jit_prog_release_other(prog, prog == orig_prog ? tmp : orig_prog);
 
-	out_offset = -1;
 
 	return prog;
 }
diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
index 397114962a14..10f6aa4d8f05 100644
--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -3404,6 +3404,7 @@ L(console_clear_loop):
 
 	movel	%d4,%d1				/* screen height in pixels */
 	divul	%a0@(FONT_DESC_HEIGHT),%d1	/* d1 = max num rows */
+	subql	#1,%d1				/* row range is 0 to num - 1 */
 
 	movel	%d0,%a2@(Lconsole_struct_num_columns)
 	movel	%d1,%a2@(Lconsole_struct_num_rows)
@@ -3550,15 +3551,14 @@ func_start	console_putc,%a0/%a1/%d0-%d7
 	cmpib	#10,%d7
 	jne	L(console_not_lf)
 	movel	%a0@(Lconsole_struct_cur_row),%d0
-	addil	#1,%d0
-	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	movel	%a0@(Lconsole_struct_num_rows),%d1
 	cmpl	%d1,%d0
 	jcs	1f
-	subil	#1,%d0
-	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	console_scroll
+	jra	L(console_exit)
 1:
+	addql	#1,%d0
+	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	jra	L(console_exit)
 
 L(console_not_lf):
@@ -3585,12 +3585,6 @@ L(console_not_cr):
  */
 L(console_not_home):
 	movel	%a0@(Lconsole_struct_cur_column),%d0
-	addql	#1,%a0@(Lconsole_struct_cur_column)
-	movel	%a0@(Lconsole_struct_num_columns),%d1
-	cmpl	%d1,%d0
-	jcs	1f
-	console_putc	#'\n'	/* recursion is OK! */
-1:
 	movel	%a0@(Lconsole_struct_cur_row),%d1
 
 	/*
@@ -3637,6 +3631,23 @@ L(console_do_font_scanline):
 	addq	#1,%d1
 	dbra	%d7,L(console_read_char_scanline)
 
+	/*
+	 *	Register usage in the code below:
+	 *	a0 = pointer to console globals
+	 *	d0 = cursor column
+	 *	d1 = cursor column limit
+	 */
+
+	lea	%pc@(L(console_globals)),%a0
+
+	movel	%a0@(Lconsole_struct_cur_column),%d0
+	addql	#1,%d0
+	movel	%d0,%a0@(Lconsole_struct_cur_column)	/* Update cursor pos */
+	movel	%a0@(Lconsole_struct_num_columns),%d1
+	cmpl	%d1,%d0
+	jcs	L(console_exit)
+	console_putc	#'\n'		/* Line wrap using tail recursion */
+
 L(console_exit):
 func_return	console_putc
 
diff --git a/arch/mips/crypto/chacha-core.S b/arch/mips/crypto/chacha-core.S
index 5755f69cfe00..706aeb850fb0 100644
--- a/arch/mips/crypto/chacha-core.S
+++ b/arch/mips/crypto/chacha-core.S
@@ -55,17 +55,13 @@
 #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define MSB 0
 #define LSB 3
-#define ROTx rotl
-#define ROTR(n) rotr n, 24
 #define	CPU_TO_LE32(n) \
-	wsbh	n; \
+	wsbh	n, n; \
 	rotr	n, 16;
 #else
 #define MSB 3
 #define LSB 0
-#define ROTx rotr
 #define CPU_TO_LE32(n)
-#define ROTR(n)
 #endif
 
 #define FOR_EACH_WORD(x) \
@@ -192,10 +188,10 @@ CONCAT3(.Lchacha_mips_xor_aligned_, PLUS_ONE(x), _b: ;) \
 	xor	X(W), X(B); \
 	xor	X(Y), X(C); \
 	xor	X(Z), X(D); \
-	rotl	X(V), S;    \
-	rotl	X(W), S;    \
-	rotl	X(Y), S;    \
-	rotl	X(Z), S;
+	rotr	X(V), 32 - S; \
+	rotr	X(W), 32 - S; \
+	rotr	X(Y), 32 - S; \
+	rotr	X(Z), 32 - S;
 
 .text
 .set	reorder
@@ -372,21 +368,19 @@ chacha_crypt_arch:
 	/* First byte */
 	lbu	T1, 0(IN)
 	addiu	$at, BYTES, 1
-	CPU_TO_LE32(SAVED_X)
-	ROTR(SAVED_X)
 	xor	T1, SAVED_X
 	sb	T1, 0(OUT)
 	beqz	$at, .Lchacha_mips_xor_done
 	/* Second byte */
 	lbu	T1, 1(IN)
 	addiu	$at, BYTES, 2
-	ROTx	SAVED_X, 8
+	rotr	SAVED_X, 8
 	xor	T1, SAVED_X
 	sb	T1, 1(OUT)
 	beqz	$at, .Lchacha_mips_xor_done
 	/* Third byte */
 	lbu	T1, 2(IN)
-	ROTx	SAVED_X, 8
+	rotr	SAVED_X, 8
 	xor	T1, SAVED_X
 	sb	T1, 2(OUT)
 	b	.Lchacha_mips_xor_done
diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
index baa949a744cb..babbe8742b81 100644
--- a/arch/mips/include/asm/vpe.h
+++ b/arch/mips/include/asm/vpe.h
@@ -124,4 +124,12 @@ void cleanup_tc(struct tc *tc);
 
 int __init vpe_module_init(void);
 void __exit vpe_module_exit(void);
+
+#ifdef CONFIG_MIPS_VPE_LOADER_MT
+void *vpe_alloc(void);
+int vpe_start(void *vpe, unsigned long start);
+int vpe_stop(void *vpe);
+int vpe_free(void *vpe);
+#endif /* CONFIG_MIPS_VPE_LOADER_MT */
+
 #endif /* _ASM_VPE_H */
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 17d80e2f2e4c..86deab01c578 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -690,18 +690,20 @@ unsigned long mips_stack_top(void)
 	}
 
 	/* Space for the VDSO, data page & GIC user page */
-	top -= PAGE_ALIGN(current->thread.abi->vdso->size);
-	top -= PAGE_SIZE;
-	top -= mips_gic_present() ? PAGE_SIZE : 0;
+	if (current->thread.abi) {
+		top -= PAGE_ALIGN(current->thread.abi->vdso->size);
+		top -= PAGE_SIZE;
+		top -= mips_gic_present() ? PAGE_SIZE : 0;
+
+		/* Space to randomize the VDSO base */
+		if (current->flags & PF_RANDOMIZE)
+			top -= VDSO_RANDOMIZE_SIZE;
+	}
 
 	/* Space for cache colour alignment */
 	if (cpu_has_dc_aliases)
 		top -= shm_align_mask + 1;
 
-	/* Space to randomize the VDSO base */
-	if (current->flags & PF_RANDOMIZE)
-		top -= VDSO_RANDOMIZE_SIZE;
-
 	return top;
 }
 
diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index 1187729d8cbb..357543996ee6 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -214,19 +214,16 @@ void __init ltq_soc_init(void)
 	of_node_put(np_syseth);
 	of_node_put(np_sysgpe);
 
-	if ((request_mem_region(res_status.start, resource_size(&res_status),
-				res_status.name) < 0) ||
-		(request_mem_region(res_ebu.start, resource_size(&res_ebu),
-				res_ebu.name) < 0) ||
-		(request_mem_region(res_sys[0].start,
-				resource_size(&res_sys[0]),
-				res_sys[0].name) < 0) ||
-		(request_mem_region(res_sys[1].start,
-				resource_size(&res_sys[1]),
-				res_sys[1].name) < 0) ||
-		(request_mem_region(res_sys[2].start,
-				resource_size(&res_sys[2]),
-				res_sys[2].name) < 0))
+	if ((!request_mem_region(res_status.start, resource_size(&res_status),
+				 res_status.name)) ||
+	    (!request_mem_region(res_ebu.start, resource_size(&res_ebu),
+				 res_ebu.name)) ||
+	    (!request_mem_region(res_sys[0].start, resource_size(&res_sys[0]),
+				 res_sys[0].name)) ||
+	    (!request_mem_region(res_sys[1].start, resource_size(&res_sys[1]),
+				 res_sys[1].name)) ||
+	    (!request_mem_region(res_sys[2].start, resource_size(&res_sys[2]),
+				 res_sys[2].name)))
 		pr_err("Failed to request core resources");
 
 	status_membase = ioremap(res_status.start,
diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index a2d8600521f9..cc2a91b74f19 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -39,7 +39,9 @@ endif
 
 export LD_BFD
 
-# Set default 32 bits cross compilers for vdso
+# Set default 32 bits cross compilers for vdso.
+# This means that for 64BIT, both the 64-bit tools and the 32-bit tools
+# need to be in the path.
 CC_ARCHES_32 = hppa hppa2.0 hppa1.1
 CC_SUFFIXES  = linux linux-gnu unknown-linux-gnu suse-linux
 CROSS32_COMPILE := $(call cc-cross-prefix, \
@@ -137,7 +139,7 @@ palo lifimage: vmlinuz
 	fi
 	@if test ! -f "$(PALOCONF)"; then \
 		cp $(srctree)/arch/parisc/defpalo.conf $(objtree)/palo.conf; \
-		echo 'A generic palo config file ($(objree)/palo.conf) has been created for you.'; \
+		echo 'A generic palo config file ($(objtree)/palo.conf) has been created for you.'; \
 		echo 'You should check it and re-run "make palo".'; \
 		echo 'WARNING: the "lifimage" file is now placed in this directory by default!'; \
 		false; \
diff --git a/arch/parisc/include/asm/special_insns.h b/arch/parisc/include/asm/special_insns.h
index 51f40eaf7780..1013eeba31e5 100644
--- a/arch/parisc/include/asm/special_insns.h
+++ b/arch/parisc/include/asm/special_insns.h
@@ -32,6 +32,34 @@
 	pa;						\
 })
 
+/**
+ * prober_user() - Probe user read access
+ * @sr:		Space regster.
+ * @va:		Virtual address.
+ *
+ * Return: Non-zero if address is accessible.
+ *
+ * Due to the way _PAGE_READ is handled in TLB entries, we need
+ * a special check to determine whether a user address is accessible.
+ * The ldb instruction does the initial access check. If it is
+ * successful, the probe instruction checks user access rights.
+ */
+#define prober_user(sr, va)	({			\
+	unsigned long read_allowed;			\
+	__asm__ __volatile__(				\
+		"copy %%r0,%0\n"			\
+		"8:\tldb 0(%%sr%1,%2),%%r0\n"		\
+		"\tproberi (%%sr%1,%2),%3,%0\n"		\
+		"9:\n"					\
+		ASM_EXCEPTIONTABLE_ENTRY(8b, 9b,	\
+				"or %%r0,%%r0,%%r0")	\
+		: "=&r" (read_allowed)			\
+		: "i" (sr), "r" (va), "i" (PRIV_USER)	\
+		: "memory"				\
+	);						\
+	read_allowed;					\
+})
+
 #define CR_EIEM 15	/* External Interrupt Enable Mask */
 #define CR_CR16 16	/* CR16 Interval Timer */
 #define CR_EIRR 23	/* External Interrupt Request Register */
diff --git a/arch/parisc/include/asm/uaccess.h b/arch/parisc/include/asm/uaccess.h
index 88d0ae5769dd..6c531d2c847e 100644
--- a/arch/parisc/include/asm/uaccess.h
+++ b/arch/parisc/include/asm/uaccess.h
@@ -42,9 +42,24 @@
 	__gu_err;					\
 })
 
-#define __get_user(val, ptr)				\
-({							\
-	__get_user_internal(SR_USER, val, ptr);	\
+#define __probe_user_internal(sr, error, ptr)			\
+({								\
+	__asm__("\tproberi (%%sr%1,%2),%3,%0\n"			\
+		"\tcmpiclr,= 1,%0,%0\n"				\
+		"\tldi %4,%0\n"					\
+		: "=r"(error)					\
+		: "i"(sr), "r"(ptr), "i"(PRIV_USER),		\
+		  "i"(-EFAULT));				\
+})
+
+#define __get_user(val, ptr)					\
+({								\
+	register long __gu_err;					\
+								\
+	__gu_err = __get_user_internal(SR_USER, val, ptr);	\
+	if (likely(!__gu_err))					\
+		__probe_user_internal(SR_USER, __gu_err, ptr);	\
+	__gu_err;						\
 })
 
 #define __get_user_asm(sr, val, ldx, ptr)		\
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index 1ff54f4dbedb..0cc81d76d6c0 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -486,6 +486,12 @@
 	 * this happens is quite subtle, read below */
 	.macro		make_insert_tlb	spc,pte,prot,tmp
 	space_to_prot   \spc \prot        /* create prot id from space */
+
+#if _PAGE_SPECIAL_BIT == _PAGE_DMB_BIT
+	/* need to drop DMB bit, as it's used as SPECIAL flag */
+	depi		0,_PAGE_SPECIAL_BIT,1,\pte
+#endif
+
 	/* The following is the real subtlety.  This is depositing
 	 * T <-> _PAGE_REFTRAP
 	 * D <-> _PAGE_DIRTY
@@ -498,17 +504,18 @@
 	 * Finally, _PAGE_READ goes in the top bit of PL1 (so we
 	 * trigger an access rights trap in user space if the user
 	 * tries to read an unreadable page */
-#if _PAGE_SPECIAL_BIT == _PAGE_DMB_BIT
-	/* need to drop DMB bit, as it's used as SPECIAL flag */
-	depi		0,_PAGE_SPECIAL_BIT,1,\pte
-#endif
 	depd            \pte,8,7,\prot
 
 	/* PAGE_USER indicates the page can be read with user privileges,
 	 * so deposit X1|11 to PL1|PL2 (remember the upper bit of PL1
-	 * contains _PAGE_READ) */
+	 * contains _PAGE_READ). While the kernel can't directly write
+	 * user pages which have _PAGE_WRITE zero, it can read pages
+	 * which have _PAGE_READ zero (PL <= PL1). Thus, the kernel
+	 * exception fault handler doesn't trigger when reading pages
+	 * that aren't user read accessible */
 	extrd,u,*=      \pte,_PAGE_USER_BIT+32,1,%r0
 	depdi		7,11,3,\prot
+
 	/* If we're a gateway page, drop PL2 back to zero for promotion
 	 * to kernel privilege (so we can execute the page as kernel).
 	 * Any privilege promotion page always denys read and write */
diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
index f0f49ca70362..670aed0dea37 100644
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -600,6 +600,9 @@ lws_compare_and_swap32:
 lws_compare_and_swap:
 	/* Trigger memory reference interruptions without writing to memory */
 1:	ldw	0(%r26), %r28
+	proberi	(%r26), PRIV_USER, %r28
+	comb,=,n	%r28, %r0, lws_fault /* backwards, likely not taken */
+	nop
 2:	stbys,e	%r0, 0(%r26)
 
 	/* Calculate 8-bit hash index from virtual address */
@@ -753,6 +756,9 @@ cas2_lock_start:
 	copy	%r26, %r28
 	depi_safe	0, 31, 2, %r28
 10:	ldw	0(%r28), %r1
+	proberi	(%r28), PRIV_USER, %r1
+	comb,=,n	%r1, %r0, lws_fault /* backwards, likely not taken */
+	nop
 11:	stbys,e	%r0, 0(%r28)
 
 	/* Calculate 8-bit hash index from virtual address */
@@ -936,41 +942,47 @@ atomic_xchg_begin:
 
 	/* 8-bit exchange */
 1:	ldb	0(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 	copy	%r23, %r20
 	depi_safe	0, 31, 2, %r20
 	b	atomic_xchg_start
 2:	stbys,e	%r0, 0(%r20)
-	nop
-	nop
-	nop
 
 	/* 16-bit exchange */
 3:	ldh	0(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 	copy	%r23, %r20
 	depi_safe	0, 31, 2, %r20
 	b	atomic_xchg_start
 4:	stbys,e	%r0, 0(%r20)
-	nop
-	nop
-	nop
 
 	/* 32-bit exchange */
 5:	ldw	0(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 	b	atomic_xchg_start
 6:	stbys,e	%r0, 0(%r23)
 	nop
 	nop
-	nop
-	nop
-	nop
 
 	/* 64-bit exchange */
 #ifdef CONFIG_64BIT
 7:	ldd	0(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 8:	stdby,e	%r0, 0(%r23)
 #else
 7:	ldw	0(%r24), %r20
 8:	ldw	4(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 	copy	%r23, %r20
 	depi_safe	0, 31, 2, %r20
 9:	stbys,e	%r0, 0(%r20)
diff --git a/arch/parisc/lib/memcpy.c b/arch/parisc/lib/memcpy.c
index 5fc0c852c84c..69d65ffab312 100644
--- a/arch/parisc/lib/memcpy.c
+++ b/arch/parisc/lib/memcpy.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/compiler.h>
 #include <linux/uaccess.h>
+#include <linux/mm.h>
 
 #define get_user_space()	mfsp(SR_USER)
 #define get_kernel_space()	SR_KERNEL
@@ -32,9 +33,25 @@ EXPORT_SYMBOL(raw_copy_to_user);
 unsigned long raw_copy_from_user(void *dst, const void __user *src,
 			       unsigned long len)
 {
+	unsigned long start = (unsigned long) src;
+	unsigned long end = start + len;
+	unsigned long newlen = len;
+
 	mtsp(get_user_space(), SR_TEMP1);
 	mtsp(get_kernel_space(), SR_TEMP2);
-	return pa_memcpy(dst, (void __force *)src, len);
+
+	/* Check region is user accessible */
+	if (start)
+	while (start < end) {
+		if (!prober_user(SR_TEMP1, start)) {
+			newlen = (start - (unsigned long) src);
+			break;
+		}
+		start += PAGE_SIZE;
+		/* align to page boundry which may have different permission */
+		start = PAGE_ALIGN_DOWN(start);
+	}
+	return len - newlen + pa_memcpy(dst, (void __force *)src, newlen);
 }
 EXPORT_SYMBOL(raw_copy_from_user);
 
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index fbd9ada5e527..331f32d6234e 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -358,6 +358,10 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	mmap_read_unlock(mm);
 
 bad_area_nosemaphore:
+	if (!user_mode(regs) && fixup_exception(regs)) {
+		return;
+	}
+
 	if (user_mode(regs)) {
 		int signo, si_code;
 
diff --git a/arch/powerpc/include/asm/floppy.h b/arch/powerpc/include/asm/floppy.h
index f8ce178b43b7..34abf8bea2cc 100644
--- a/arch/powerpc/include/asm/floppy.h
+++ b/arch/powerpc/include/asm/floppy.h
@@ -144,9 +144,12 @@ static int hard_dma_setup(char *addr, unsigned long size, int mode, int io)
 		bus_addr = 0;
 	}
 
-	if (!bus_addr)	/* need to map it */
+	if (!bus_addr) {	/* need to map it */
 		bus_addr = dma_map_single(&isa_bridge_pcidev->dev, addr, size,
 					  dir);
+		if (dma_mapping_error(&isa_bridge_pcidev->dev, bus_addr))
+			return -ENOMEM;
+	}
 
 	/* remember this one as prev */
 	prev_addr = addr;
diff --git a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
index 04bf6ecf7d55..85e0fa7d902b 100644
--- a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
+++ b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
@@ -240,10 +240,8 @@ static int mpc512x_lpbfifo_kick(void)
 	dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
 	/* Make DMA channel work with LPB FIFO data register */
-	if (dma_dev->device_config(lpbfifo.chan, &dma_conf)) {
-		ret = -EINVAL;
-		goto err_dma_prep;
-	}
+	if (dma_dev->device_config(lpbfifo.chan, &dma_conf))
+		return -EINVAL;
 
 	sg_init_table(&sg, 1);
 
diff --git a/arch/s390/hypfs/hypfs_dbfs.c b/arch/s390/hypfs/hypfs_dbfs.c
index f4c7dbfaf8ee..5848f2e374a6 100644
--- a/arch/s390/hypfs/hypfs_dbfs.c
+++ b/arch/s390/hypfs/hypfs_dbfs.c
@@ -6,6 +6,7 @@
  * Author(s): Michael Holzheu <holzheu@linux.vnet.ibm.com>
  */
 
+#include <linux/security.h>
 #include <linux/slab.h>
 #include "hypfs.h"
 
@@ -64,24 +65,28 @@ static long dbfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	long rc;
 
 	mutex_lock(&df->lock);
-	if (df->unlocked_ioctl)
-		rc = df->unlocked_ioctl(file, cmd, arg);
-	else
-		rc = -ENOTTY;
+	rc = df->unlocked_ioctl(file, cmd, arg);
 	mutex_unlock(&df->lock);
 	return rc;
 }
 
-static const struct file_operations dbfs_ops = {
+static const struct file_operations dbfs_ops_ioctl = {
 	.read		= dbfs_read,
 	.llseek		= no_llseek,
 	.unlocked_ioctl = dbfs_ioctl,
 };
 
+static const struct file_operations dbfs_ops = {
+	.read		= dbfs_read,
+};
+
 void hypfs_dbfs_create_file(struct hypfs_dbfs_file *df)
 {
-	df->dentry = debugfs_create_file(df->name, 0400, dbfs_dir, df,
-					 &dbfs_ops);
+	const struct file_operations *fops = &dbfs_ops;
+
+	if (df->unlocked_ioctl && !security_locked_down(LOCKDOWN_DEBUGFS))
+		fops = &dbfs_ops_ioctl;
+	df->dentry = debugfs_create_file(df->name, 0400, dbfs_dir, df, fops);
 	mutex_init(&df->lock);
 }
 
diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index ce878e85b6e4..d0255aa5b36e 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -192,13 +192,6 @@ static inline unsigned long get_tod_clock_fast(void)
 	asm volatile("stckf %0" : "=Q" (clk) : : "cc");
 	return clk;
 }
-
-static inline cycles_t get_cycles(void)
-{
-	return (cycles_t) get_tod_clock() >> 2;
-}
-#define get_cycles get_cycles
-
 int get_phys_clock(unsigned long *clock);
 void init_cpu_timer(void);
 
@@ -221,6 +214,12 @@ static inline unsigned long get_tod_clock_monotonic(void)
 	return tod;
 }
 
+static inline cycles_t get_cycles(void)
+{
+	return (cycles_t)get_tod_clock_monotonic() >> 2;
+}
+#define get_cycles get_cycles
+
 /**
  * tod_to_ns - convert a TOD format value to nanoseconds
  * @todval: to be converted TOD format value
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 6b7b6d5e3632..add2862e835b 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -574,7 +574,7 @@ static int stp_sync_clock(void *data)
 		atomic_dec(&sync->cpus);
 		/* Wait for in_sync to be set. */
 		while (READ_ONCE(sync->in_sync) == 0)
-			__udelay(1);
+			;
 	}
 	if (sync->in_sync != 1)
 		/* Didn't work. Clear per-cpu in sync bit again. */
diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index ba5f80268878..65243e1d0c8e 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -249,11 +249,9 @@ static int ptdump_show(struct seq_file *m, void *v)
 		.marker = address_markers,
 	};
 
-	get_online_mems();
 	mutex_lock(&cpa_mutex);
 	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
 	mutex_unlock(&cpa_mutex);
-	put_online_mems();
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(ptdump);
diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index c7b4b49826a2..40d823f36c09 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -68,7 +68,11 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
+#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 
+#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL | \
+				 _TIF_NOTIFY_RESUME)
+
 #endif
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index c5281ce31685..d8c274d99390 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -97,14 +97,18 @@ void *__switch_to(struct task_struct *from, struct task_struct *to)
 void interrupt_end(void)
 {
 	struct pt_regs *regs = &current->thread.regs;
-
-	if (need_resched())
-		schedule();
-	if (test_thread_flag(TIF_SIGPENDING) ||
-	    test_thread_flag(TIF_NOTIFY_SIGNAL))
-		do_signal(regs);
-	if (test_thread_flag(TIF_NOTIFY_RESUME))
-		resume_user_mode_work(regs);
+	unsigned long thread_flags;
+
+	thread_flags = read_thread_flags();
+	while (thread_flags & _TIF_WORK_MASK) {
+		if (thread_flags & _TIF_NEED_RESCHED)
+			schedule();
+		if (thread_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
+			do_signal(regs);
+		if (thread_flags & _TIF_NOTIFY_RESUME)
+			resume_user_mode_work(regs);
+		thread_flags = read_thread_flags();
+	}
 }
 
 int get_current_pid(void)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b380fc5ea088..2cb5b1f715b6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2703,7 +2703,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 		if (pmu_enabled)
 			intel_pmu_disable_all();
 
-		if (is_topdown_event(event))
+		if (is_topdown_count(event))
 			static_call(intel_pmu_update_topdown_event)(event);
 		else
 			intel_pmu_drain_pebs_buffer();
diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 29bef25ac77c..c068565fe954 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -47,7 +47,6 @@ KVM_X86_OP(set_idt)
 KVM_X86_OP(get_gdt)
 KVM_X86_OP(set_gdt)
 KVM_X86_OP(sync_dirty_debug_regs)
-KVM_X86_OP(set_dr6)
 KVM_X86_OP(set_dr7)
 KVM_X86_OP(cache_reg)
 KVM_X86_OP(get_rflags)
@@ -100,7 +99,6 @@ KVM_X86_OP(write_tsc_multiplier)
 KVM_X86_OP(get_exit_info)
 KVM_X86_OP(check_intercept)
 KVM_X86_OP(handle_exit_irqoff)
-KVM_X86_OP(request_immediate_exit)
 KVM_X86_OP(sched_in)
 KVM_X86_OP_OPTIONAL(update_cpu_dirty_logging)
 KVM_X86_OP_OPTIONAL(vcpu_blocking)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index eb06c2f68314..d0229323ca63 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -677,6 +677,7 @@ struct kvm_vcpu_arch {
 	u32 pkru;
 	u32 hflags;
 	u64 efer;
+	u64 host_debugctl;
 	u64 apic_base;
 	struct kvm_lapic *apic;    /* kernel irqchip context */
 	bool load_eoi_exitmap_pending;
@@ -1455,6 +1456,12 @@ static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
 	return dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
 }
 
+enum kvm_x86_run_flags {
+	KVM_RUN_FORCE_IMMEDIATE_EXIT	= BIT(0),
+	KVM_RUN_LOAD_GUEST_DR6		= BIT(1),
+	KVM_RUN_LOAD_DEBUGCTL		= BIT(2),
+};
+
 struct kvm_x86_ops {
 	const char *name;
 
@@ -1478,6 +1485,12 @@ struct kvm_x86_ops {
 	void (*vcpu_load)(struct kvm_vcpu *vcpu, int cpu);
 	void (*vcpu_put)(struct kvm_vcpu *vcpu);
 
+	/*
+	 * Mask of DEBUGCTL bits that are owned by the host, i.e. that need to
+	 * match the host's value even while the guest is active.
+	 */
+	const u64 HOST_OWNED_DEBUGCTL;
+
 	void (*update_exception_bitmap)(struct kvm_vcpu *vcpu);
 	int (*get_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr);
 	int (*set_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr);
@@ -1499,7 +1512,6 @@ struct kvm_x86_ops {
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*sync_dirty_debug_regs)(struct kvm_vcpu *vcpu);
-	void (*set_dr6)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*set_dr7)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
 	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
@@ -1527,7 +1539,8 @@ struct kvm_x86_ops {
 	void (*flush_tlb_guest)(struct kvm_vcpu *vcpu);
 
 	int (*vcpu_pre_run)(struct kvm_vcpu *vcpu);
-	enum exit_fastpath_completion (*vcpu_run)(struct kvm_vcpu *vcpu);
+	enum exit_fastpath_completion (*vcpu_run)(struct kvm_vcpu *vcpu,
+						  u64 run_flags);
 	int (*handle_exit)(struct kvm_vcpu *vcpu,
 		enum exit_fastpath_completion exit_fastpath);
 	int (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
@@ -1547,10 +1560,12 @@ struct kvm_x86_ops {
 	void (*enable_nmi_window)(struct kvm_vcpu *vcpu);
 	void (*enable_irq_window)(struct kvm_vcpu *vcpu);
 	void (*update_cr8_intercept)(struct kvm_vcpu *vcpu, int tpr, int irr);
+
+	const bool x2apic_icr_is_split;
 	bool (*check_apicv_inhibit_reasons)(enum kvm_apicv_inhibit reason);
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
-	void (*hwapic_isr_update)(int isr);
+	void (*hwapic_isr_update)(struct kvm_vcpu *vcpu, int isr);
 	bool (*guest_apic_has_interrupt)(struct kvm_vcpu *vcpu);
 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
@@ -1586,8 +1601,6 @@ struct kvm_x86_ops {
 			       struct x86_exception *exception);
 	void (*handle_exit_irqoff)(struct kvm_vcpu *vcpu);
 
-	void (*request_immediate_exit)(struct kvm_vcpu *vcpu);
-
 	void (*sched_in)(struct kvm_vcpu *kvm, int cpu);
 
 	/*
@@ -2055,7 +2068,6 @@ extern bool kvm_find_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn);
 
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err);
-void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu);
 
 void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				     u32 size);
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 727947ed5e5e..afd65c815043 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -379,6 +379,7 @@
 #define DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI	(1UL << 12)
 #define DEBUGCTLMSR_FREEZE_IN_SMM_BIT	14
 #define DEBUGCTLMSR_FREEZE_IN_SMM	(1UL << DEBUGCTLMSR_FREEZE_IN_SMM_BIT)
+#define DEBUGCTLMSR_RTM_DEBUG		BIT(15)
 
 #define MSR_PEBS_FRONTEND		0x000003f7
 
diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 2551baec927d..d9a38d379d18 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -25,8 +25,9 @@ void __noreturn machine_real_restart(unsigned int type);
 #define MRR_BIOS	0
 #define MRR_APM		1
 
-typedef void crash_vmclear_fn(void);
-extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
+typedef void (cpu_emergency_virt_cb)(void);
+void cpu_emergency_register_virt_callback(cpu_emergency_virt_cb *callback);
+void cpu_emergency_unregister_virt_callback(cpu_emergency_virt_cb *callback);
 void cpu_emergency_disable_virtualization(void);
 
 typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 724ce44809ed..1b683bf71d14 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -70,16 +70,6 @@ static inline void __cpu_emergency_vmxoff(void)
 		cpu_vmxoff();
 }
 
-/** Disable VMX if it is supported and enabled on the current CPU
- */
-static inline void cpu_emergency_vmxoff(void)
-{
-	if (cpu_has_vmx())
-		__cpu_emergency_vmxoff();
-}
-
-
-
 
 /*
  * SVM functions:
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 9b4eddd5833a..a54c4d3633e9 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -94,12 +94,13 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_hypercall_func);
 #ifdef MODULE
 #define __ADDRESSABLE_xen_hypercall
 #else
-#define __ADDRESSABLE_xen_hypercall __ADDRESSABLE_ASM_STR(__SCK__xen_hypercall)
+#define __ADDRESSABLE_xen_hypercall \
+	__stringify(.global STATIC_CALL_KEY(xen_hypercall);)
 #endif
 
 #define __HYPERCALL					\
 	__ADDRESSABLE_xen_hypercall			\
-	"call __SCT__xen_hypercall"
+	__stringify(call STATIC_CALL_TRAMP(xen_hypercall))
 
 #define __HYPERCALL_ENTRY(x)	"a" (x)
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dba5262e1509..4fbb5b15ab75 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -70,10 +70,9 @@ void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
 
 static void __init set_return_thunk(void *thunk)
 {
-	if (x86_return_thunk != __x86_return_thunk)
-		pr_warn("x86/bugs: return thunk changed\n");
-
 	x86_return_thunk = thunk;
+
+	pr_info("active return thunk: %ps\n", thunk);
 }
 
 /* Update SPEC_CTRL MSR and its cached copy unconditionally */
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 8a80d5343f3a..4f69e85bc255 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -14,6 +14,7 @@
 #include <asm/cacheinfo.h>
 #include <asm/spec-ctrl.h>
 #include <asm/delay.h>
+#include <asm/resctrl.h>
 
 #include "cpu.h"
 
@@ -239,6 +240,8 @@ static void bsp_init_hygon(struct cpuinfo_x86 *c)
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << 10;
 		}
 	}
+
+	resctrl_cpu_detect(c);
 }
 
 static void early_init_hygon(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5535749620af..9939b984bceb 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1052,13 +1052,20 @@ static const char *get_name(unsigned int cpu, unsigned int bank, struct threshol
 	}
 
 	bank_type = smca_get_bank_type(cpu, bank);
-	if (bank_type >= N_SMCA_BANK_TYPES)
-		return NULL;
 
 	if (b && bank_type == SMCA_UMC) {
 		if (b->block < ARRAY_SIZE(smca_umc_block_names))
 			return smca_umc_block_names[b->block];
-		return NULL;
+	}
+
+	if (b && b->block) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN, "th_block_%u", b->block);
+		return buf_mcatype;
+	}
+
+	if (bank_type >= N_SMCA_BANK_TYPES) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN, "th_bank_%u", bank);
+		return buf_mcatype;
 	}
 
 	if (per_cpu(smca_bank_counts, cpu)[bank_type] == 1)
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index d9dbcd1cf75f..79e1ac3d0625 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -787,26 +787,27 @@ void machine_crash_shutdown(struct pt_regs *regs)
 }
 #endif
 
-/*
- * This is used to VMCLEAR all VMCSs loaded on the
- * processor. And when loading kvm_intel module, the
- * callback function pointer will be assigned.
- *
- * protected by rcu.
- */
-crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
-EXPORT_SYMBOL_GPL(crash_vmclear_loaded_vmcss);
+/* RCU-protected callback to disable virtualization prior to reboot. */
+static cpu_emergency_virt_cb __rcu *cpu_emergency_virt_callback;
 
-static inline void cpu_crash_vmclear_loaded_vmcss(void)
+void cpu_emergency_register_virt_callback(cpu_emergency_virt_cb *callback)
 {
-	crash_vmclear_fn *do_vmclear_operation = NULL;
+	if (WARN_ON_ONCE(rcu_access_pointer(cpu_emergency_virt_callback)))
+		return;
 
-	rcu_read_lock();
-	do_vmclear_operation = rcu_dereference(crash_vmclear_loaded_vmcss);
-	if (do_vmclear_operation)
-		do_vmclear_operation();
-	rcu_read_unlock();
+	rcu_assign_pointer(cpu_emergency_virt_callback, callback);
+}
+EXPORT_SYMBOL_GPL(cpu_emergency_register_virt_callback);
+
+void cpu_emergency_unregister_virt_callback(cpu_emergency_virt_cb *callback)
+{
+	if (WARN_ON_ONCE(rcu_access_pointer(cpu_emergency_virt_callback) != callback))
+		return;
+
+	rcu_assign_pointer(cpu_emergency_virt_callback, NULL);
+	synchronize_rcu();
 }
+EXPORT_SYMBOL_GPL(cpu_emergency_unregister_virt_callback);
 
 /* This is the CPU performing the emergency shutdown work. */
 int crashing_cpu = -1;
@@ -818,9 +819,15 @@ int crashing_cpu = -1;
  */
 void cpu_emergency_disable_virtualization(void)
 {
-	cpu_crash_vmclear_loaded_vmcss();
+	cpu_emergency_virt_cb *callback;
+
+	rcu_read_lock();
+	callback = rcu_dereference(cpu_emergency_virt_callback);
+	if (callback)
+		callback();
+	rcu_read_unlock();
 
-	cpu_emergency_vmxoff();
+	/* KVM_AMD doesn't yet utilize the common callback. */
 	cpu_emergency_svm_disable();
 }
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 28555bbd52e8..cb0a531e13c5 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1406,8 +1406,7 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
 		return syndbg_set_msr(vcpu, msr, data, host);
 	default:
-		vcpu_unimpl(vcpu, "Hyper-V unhandled wrmsr: 0x%x data 0x%llx\n",
-			    msr, data);
+		kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 		return 1;
 	}
 	return 0;
@@ -1528,8 +1527,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 			return 1;
 		break;
 	default:
-		vcpu_unimpl(vcpu, "Hyper-V unhandled wrmsr: 0x%x data 0x%llx\n",
-			    msr, data);
+		kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 		return 1;
 	}
 
@@ -1581,7 +1579,7 @@ static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
 		return syndbg_get_msr(vcpu, msr, pdata, host);
 	default:
-		vcpu_unimpl(vcpu, "Hyper-V unhandled rdmsr: 0x%x\n", msr);
+		kvm_pr_unimpl_rdmsr(vcpu, msr);
 		return 1;
 	}
 
@@ -1646,7 +1644,7 @@ static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 		data = APIC_BUS_FREQUENCY;
 		break;
 	default:
-		vcpu_unimpl(vcpu, "Hyper-V unhandled rdmsr: 0x%x\n", msr);
+		kvm_pr_unimpl_rdmsr(vcpu, msr);
 		return 1;
 	}
 	*pdata = data;
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 7f57dce5c828..9aae76b74417 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -587,7 +587,7 @@ static inline void apic_set_isr(int vec, struct kvm_lapic *apic)
 	 * just set SVI.
 	 */
 	if (unlikely(apic->apicv_active))
-		static_call_cond(kvm_x86_hwapic_isr_update)(vec);
+		static_call_cond(kvm_x86_hwapic_isr_update)(apic->vcpu, vec);
 	else {
 		++apic->isr_count;
 		BUG_ON(apic->isr_count > MAX_APIC_VECTOR);
@@ -632,7 +632,7 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 	 * and must be left alone.
 	 */
 	if (unlikely(apic->apicv_active))
-		static_call_cond(kvm_x86_hwapic_isr_update)(apic_find_highest_isr(apic));
+		static_call_cond(kvm_x86_hwapic_isr_update)(apic->vcpu, apic_find_highest_isr(apic));
 	else {
 		--apic->isr_count;
 		BUG_ON(apic->isr_count < 0);
@@ -640,6 +640,17 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 	}
 }
 
+void kvm_apic_update_hwapic_isr(struct kvm_vcpu *vcpu)
+{
+	struct kvm_lapic *apic = vcpu->arch.apic;
+
+	if (WARN_ON_ONCE(!lapic_in_kernel(vcpu)) || !apic->apicv_active)
+		return;
+
+	static_call(kvm_x86_hwapic_isr_update)(vcpu, apic_find_highest_isr(apic));
+}
+EXPORT_SYMBOL_GPL(kvm_apic_update_hwapic_isr);
+
 int kvm_lapic_find_highest_irr(struct kvm_vcpu *vcpu)
 {
 	/* This may race with setting of irr in __apic_accept_irq() and
@@ -2315,11 +2326,25 @@ int kvm_x2apic_icr_write(struct kvm_lapic *apic, u64 data)
 	data &= ~APIC_ICR_BUSY;
 
 	kvm_apic_send_ipi(apic, (u32)data, (u32)(data >> 32));
-	kvm_lapic_set_reg64(apic, APIC_ICR, data);
+	if (kvm_x86_ops.x2apic_icr_is_split) {
+		kvm_lapic_set_reg(apic, APIC_ICR, data);
+		kvm_lapic_set_reg(apic, APIC_ICR2, data >> 32);
+	} else {
+		kvm_lapic_set_reg64(apic, APIC_ICR, data);
+	}
 	trace_kvm_apic_write(APIC_ICR, data);
 	return 0;
 }
 
+static u64 kvm_x2apic_icr_read(struct kvm_lapic *apic)
+{
+	if (kvm_x86_ops.x2apic_icr_is_split)
+		return (u64)kvm_lapic_get_reg(apic, APIC_ICR) |
+		       (u64)kvm_lapic_get_reg(apic, APIC_ICR2) << 32;
+
+	return kvm_lapic_get_reg64(apic, APIC_ICR);
+}
+
 /* emulate APIC access in a trap manner */
 void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset)
 {
@@ -2337,7 +2362,7 @@ void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset)
 	 * maybe-unecessary write, and both are in the noise anyways.
 	 */
 	if (apic_x2apic_mode(apic) && offset == APIC_ICR)
-		WARN_ON_ONCE(kvm_x2apic_icr_write(apic, kvm_lapic_get_reg64(apic, APIC_ICR)));
+		WARN_ON_ONCE(kvm_x2apic_icr_write(apic, kvm_x2apic_icr_read(apic)));
 	else
 		kvm_lapic_reg_write(apic, offset, kvm_lapic_get_reg(apic, offset));
 }
@@ -2540,7 +2565,7 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 	if (apic->apicv_active) {
 		static_call_cond(kvm_x86_apicv_post_state_restore)(vcpu);
 		static_call_cond(kvm_x86_hwapic_irr_update)(vcpu, -1);
-		static_call_cond(kvm_x86_hwapic_isr_update)(-1);
+		static_call_cond(kvm_x86_hwapic_isr_update)(vcpu, -1);
 	}
 
 	vcpu->arch.apic_arb_prio = 0;
@@ -2760,18 +2785,22 @@ static int kvm_apic_state_fixup(struct kvm_vcpu *vcpu,
 
 		/*
 		 * In x2APIC mode, the LDR is fixed and based on the id.  And
-		 * ICR is internally a single 64-bit register, but needs to be
-		 * split to ICR+ICR2 in userspace for backwards compatibility.
+		 * if the ICR is _not_ split, ICR is internally a single 64-bit
+		 * register, but needs to be split to ICR+ICR2 in userspace for
+		 * backwards compatibility.
 		 */
-		if (set) {
+		if (set)
 			*ldr = kvm_apic_calc_x2apic_ldr(*id);
 
-			icr = __kvm_lapic_get_reg(s->regs, APIC_ICR) |
-			      (u64)__kvm_lapic_get_reg(s->regs, APIC_ICR2) << 32;
-			__kvm_lapic_set_reg64(s->regs, APIC_ICR, icr);
-		} else {
-			icr = __kvm_lapic_get_reg64(s->regs, APIC_ICR);
-			__kvm_lapic_set_reg(s->regs, APIC_ICR2, icr >> 32);
+		if (!kvm_x86_ops.x2apic_icr_is_split) {
+			if (set) {
+				icr = __kvm_lapic_get_reg(s->regs, APIC_ICR) |
+				      (u64)__kvm_lapic_get_reg(s->regs, APIC_ICR2) << 32;
+				__kvm_lapic_set_reg64(s->regs, APIC_ICR, icr);
+			} else {
+				icr = __kvm_lapic_get_reg64(s->regs, APIC_ICR);
+				__kvm_lapic_set_reg(s->regs, APIC_ICR2, icr >> 32);
+			}
 		}
 	}
 
@@ -2829,7 +2858,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 	if (apic->apicv_active) {
 		static_call_cond(kvm_x86_apicv_post_state_restore)(vcpu);
 		static_call_cond(kvm_x86_hwapic_irr_update)(vcpu, apic_find_highest_irr(apic));
-		static_call_cond(kvm_x86_hwapic_isr_update)(apic_find_highest_isr(apic));
+		static_call_cond(kvm_x86_hwapic_isr_update)(vcpu, apic_find_highest_isr(apic));
 	}
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	if (ioapic_in_kernel(vcpu->kvm))
@@ -2971,7 +3000,7 @@ static int kvm_lapic_msr_read(struct kvm_lapic *apic, u32 reg, u64 *data)
 	u32 low;
 
 	if (reg == APIC_ICR) {
-		*data = kvm_lapic_get_reg64(apic, APIC_ICR);
+		*data = kvm_x2apic_icr_read(apic);
 		return 0;
 	}
 
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index a5ac4a5a5179..e5d2dc58fcf8 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -122,6 +122,7 @@ int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
 int kvm_apic_get_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
 int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
 enum lapic_mode kvm_get_apic_mode(struct kvm_vcpu *vcpu);
+void kvm_apic_update_hwapic_isr(struct kvm_vcpu *vcpu);
 int kvm_lapic_find_highest_irr(struct kvm_vcpu *vcpu);
 
 u64 kvm_get_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b6bbd0dc4e65..5a6bd9d5cceb 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3035,8 +3035,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		break;
 	case MSR_IA32_DEBUGCTLMSR:
 		if (!lbrv) {
-			vcpu_unimpl(vcpu, "%s: MSR_IA32_DEBUGCTL 0x%llx, nop\n",
-				    __func__, data);
+			kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
 			break;
 		}
 
@@ -3077,7 +3076,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_VM_CR:
 		return svm_set_vm_cr(vcpu, data);
 	case MSR_VM_IGNNE:
-		vcpu_unimpl(vcpu, "unimplemented wrmsr: 0x%x data 0x%llx\n", ecx, data);
+		kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
 		break;
 	case MSR_AMD64_DE_CFG: {
 		struct kvm_msr_entry msr_entry;
@@ -3965,6 +3964,9 @@ static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
 	struct vmcb_control_area *control = &to_svm(vcpu)->vmcb->control;
 
+	if (is_guest_mode(vcpu))
+		return EXIT_FASTPATH_NONE;
+
 	/*
 	 * Note, the next RIP must be provided as SRCU isn't held, i.e. KVM
 	 * can't read guest memory (dereference memslots) to decode the WRMSR.
@@ -3982,6 +3984,18 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 
 	guest_state_enter_irqoff();
 
+	/*
+	 * Set RFLAGS.IF prior to VMRUN, as the host's RFLAGS.IF at the time of
+	 * VMRUN controls whether or not physical IRQs are masked (KVM always
+	 * runs with V_INTR_MASKING_MASK).  Toggle RFLAGS.IF here to avoid the
+	 * temptation to do STI+VMRUN+CLI, as AMD CPUs bleed the STI shadow
+	 * into guest state if delivery of an event during VMRUN triggers a
+	 * #VMEXIT, and the guest_state transitions already tell lockdep that
+	 * IRQs are being enabled/disabled.  Note!  GIF=0 for the entirety of
+	 * this path, so IRQs aren't actually unmasked while running host code.
+	 */
+	raw_local_irq_enable();
+
 	amd_clear_divider();
 
 	if (sev_es_guest(vcpu->kvm))
@@ -3989,15 +4003,18 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 	else
 		__svm_vcpu_run(svm, spec_ctrl_intercepted);
 
+	raw_local_irq_disable();
+
 	guest_state_exit_irqoff();
 }
 
-static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
+static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 {
+	bool force_immediate_exit = run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	bool spec_ctrl_intercepted = msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL);
 
-	trace_kvm_entry(vcpu);
+	trace_kvm_entry(vcpu, force_immediate_exit);
 
 	svm->vmcb->save.rax = vcpu->arch.regs[VCPU_REGS_RAX];
 	svm->vmcb->save.rsp = vcpu->arch.regs[VCPU_REGS_RSP];
@@ -4016,9 +4033,12 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 		 * is enough to force an immediate vmexit.
 		 */
 		disable_nmi_singlestep(svm);
-		smp_send_reschedule(vcpu->cpu);
+		force_immediate_exit = true;
 	}
 
+	if (force_immediate_exit)
+		smp_send_reschedule(vcpu->cpu);
+
 	pre_svm_run(vcpu);
 
 	sync_lapic_to_cr8(vcpu);
@@ -4032,10 +4052,13 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 	svm_hv_update_vp_id(svm->vmcb, vcpu);
 
 	/*
-	 * Run with all-zero DR6 unless needed, so that we can get the exact cause
-	 * of a #DB.
+	 * Run with all-zero DR6 unless the guest can write DR6 freely, so that
+	 * KVM can get the exact cause of a #DB.  Note, loading guest DR6 from
+	 * KVM's snapshot is only necessary when DR accesses won't exit.
 	 */
-	if (likely(!(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)))
+	if (unlikely(run_flags & KVM_RUN_LOAD_GUEST_DR6))
+		svm_set_dr6(vcpu, vcpu->arch.dr6);
+	else if (likely(!(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)))
 		svm_set_dr6(vcpu, DR6_ACTIVE_LOW);
 
 	clgi();
@@ -4113,9 +4136,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	svm_complete_interrupts(vcpu);
 
-	if (is_guest_mode(vcpu))
-		return EXIT_FASTPATH_NONE;
-
 	return svm_exit_handlers_fastpath(vcpu);
 }
 
@@ -4805,7 +4825,6 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_idt = svm_set_idt,
 	.get_gdt = svm_get_gdt,
 	.set_gdt = svm_set_gdt,
-	.set_dr6 = svm_set_dr6,
 	.set_dr7 = svm_set_dr7,
 	.sync_dirty_debug_regs = svm_sync_dirty_debug_regs,
 	.cache_reg = svm_cache_reg,
@@ -4837,6 +4856,8 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.enable_nmi_window = svm_enable_nmi_window,
 	.enable_irq_window = svm_enable_irq_window,
 	.update_cr8_intercept = svm_update_cr8_intercept,
+
+	.x2apic_icr_is_split = true,
 	.set_virtual_apic_mode = avic_refresh_virtual_apic_mode,
 	.refresh_apicv_exec_ctrl = avic_refresh_apicv_exec_ctrl,
 	.check_apicv_inhibit_reasons = avic_check_apicv_inhibit_reasons,
@@ -4858,8 +4879,6 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.check_intercept = svm_check_intercept,
 	.handle_exit_irqoff = svm_handle_exit_irqoff,
 
-	.request_immediate_exit = __kvm_request_immediate_exit,
-
 	.sched_in = svm_sched_in,
 
 	.nested_ops = &svm_nested_ops,
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 42824f9b06a2..48b72625cc45 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -170,12 +170,8 @@ SYM_FUNC_START(__svm_vcpu_run)
 	VM_CLEAR_CPU_BUFFERS
 
 	/* Enter guest mode */
-	sti
-
 3:	vmrun %_ASM_AX
 4:
-	cli
-
 	/* Pop @svm to RAX while it's the only available register. */
 	pop %_ASM_AX
 
@@ -343,11 +339,8 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	VM_CLEAR_CPU_BUFFERS
 
 	/* Enter guest mode */
-	sti
-
 1:	vmrun %_ASM_AX
-
-2:	cli
+2:
 
 	/* Pop @svm to RDI, guest registers have been saved already. */
 	pop %_ASM_DI
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 6c1dcf44c4fa..ab407bc00d84 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -15,20 +15,23 @@
  * Tracepoint for guest mode entry.
  */
 TRACE_EVENT(kvm_entry,
-	TP_PROTO(struct kvm_vcpu *vcpu),
-	TP_ARGS(vcpu),
+	TP_PROTO(struct kvm_vcpu *vcpu, bool force_immediate_exit),
+	TP_ARGS(vcpu, force_immediate_exit),
 
 	TP_STRUCT__entry(
 		__field(	unsigned int,	vcpu_id		)
 		__field(	unsigned long,	rip		)
+		__field(	bool,		immediate_exit	)
 	),
 
 	TP_fast_assign(
 		__entry->vcpu_id        = vcpu->vcpu_id;
 		__entry->rip		= kvm_rip_read(vcpu);
+		__entry->immediate_exit	= force_immediate_exit;
 	),
 
-	TP_printk("vcpu %u, rip 0x%lx", __entry->vcpu_id, __entry->rip)
+	TP_printk("vcpu %u, rip 0x%lx%s", __entry->vcpu_id, __entry->rip,
+		  __entry->immediate_exit ? "[immediate exit]" : "")
 );
 
 /*
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8052f8b7d8e1..2c3cf4351c4c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2532,10 +2532,11 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	if (vmx->nested.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
 		kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
-		vmcs_write64(GUEST_IA32_DEBUGCTL, vmcs12->guest_ia32_debugctl);
+		vmx_guest_debugctl_write(vcpu, vmcs12->guest_ia32_debugctl &
+					       vmx_get_supported_debugctl(vcpu, false));
 	} else {
 		kvm_set_dr(vcpu, 7, vcpu->arch.dr7);
-		vmcs_write64(GUEST_IA32_DEBUGCTL, vmx->nested.pre_vmenter_debugctl);
+		vmx_guest_debugctl_write(vcpu, vmx->nested.pre_vmenter_debugctl);
 	}
 	if (kvm_mpx_supported() && (!vmx->nested.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
@@ -3022,7 +3023,8 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 		return -EINVAL;
 
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS) &&
-	    CC(!kvm_dr7_valid(vmcs12->guest_dr7)))
+	    (CC(!kvm_dr7_valid(vmcs12->guest_dr7)) ||
+	     CC(!vmx_is_valid_debugctl(vcpu, vmcs12->guest_ia32_debugctl, false))))
 		return -EINVAL;
 
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PAT) &&
@@ -3402,7 +3404,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 
 	if (!vmx->nested.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
-		vmx->nested.pre_vmenter_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
+		vmx->nested.pre_vmenter_debugctl = vmx_guest_debugctl_read();
 	if (kvm_mpx_supported() &&
 	    (!vmx->nested.nested_run_pending ||
 	     !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
@@ -4374,6 +4376,12 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 		(vmcs12->vm_entry_controls & ~VM_ENTRY_IA32E_MODE) |
 		(vm_entry_controls_get(to_vmx(vcpu)) & VM_ENTRY_IA32E_MODE);
 
+	/*
+	 * Note!  Save DR7, but intentionally don't grab DEBUGCTL from vmcs02.
+	 * Writes to DEBUGCTL that aren't intercepted by L1 are immediately
+	 * propagated to vmcs12 (see vmx_set_msr()), as the value loaded into
+	 * vmcs02 doesn't strictly track vmcs12.
+	 */
 	if (vmcs12->vm_exit_controls & VM_EXIT_SAVE_DEBUG_CONTROLS)
 		kvm_get_dr(vcpu, 7, (unsigned long *)&vmcs12->guest_dr7);
 
@@ -4564,7 +4572,7 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	__vmx_set_segment(vcpu, &seg, VCPU_SREG_LDTR);
 
 	kvm_set_dr(vcpu, 7, 0x400);
-	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
+	vmx_guest_debugctl_write(vcpu, 0);
 
 	if (nested_vmx_load_msr(vcpu, vmcs12->vm_exit_msr_load_addr,
 				vmcs12->vm_exit_msr_load_count))
@@ -4619,6 +4627,9 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 			WARN_ON(kvm_set_dr(vcpu, 7, vmcs_readl(GUEST_DR7)));
 	}
 
+	/* Reload DEBUGCTL to ensure vmcs01 has a fresh FREEZE_IN_SMM value. */
+	vmx_reload_guest_debugctl(vcpu);
+
 	/*
 	 * Note that calling vmx_set_{efer,cr0,cr4} is important as they
 	 * handle a variety of side effects to KVM's software model.
@@ -4839,6 +4850,11 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
 	}
 
+	if (vmx->nested.update_vmcs01_hwapic_isr) {
+		vmx->nested.update_vmcs01_hwapic_isr = false;
+		kvm_apic_update_hwapic_isr(vcpu);
+	}
+
 	if ((vm_exit_reason != -1) &&
 	    (enable_shadow_vmcs || evmptr_is_valid(vmx->nested.hv_evmcs_vmptr)))
 		vmx->nested.need_vmcs12_to_shadow_sync = true;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 220cdbe1e286..76d3ed8abf6a 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -672,11 +672,11 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
  */
 static void intel_pmu_legacy_freezing_lbrs_on_pmi(struct kvm_vcpu *vcpu)
 {
-	u64 data = vmcs_read64(GUEST_IA32_DEBUGCTL);
+	u64 data = vmx_guest_debugctl_read();
 
 	if (data & DEBUGCTLMSR_FREEZE_LBRS_ON_PMI) {
 		data &= ~DEBUGCTLMSR_LBR;
-		vmcs_write64(GUEST_IA32_DEBUGCTL, data);
+		vmx_guest_debugctl_write(vcpu, data);
 	}
 }
 
@@ -746,7 +746,7 @@ void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu)
 
 	if (!lbr_desc->event) {
 		vmx_disable_lbr_msrs_passthrough(vcpu);
-		if (vmcs_read64(GUEST_IA32_DEBUGCTL) & DEBUGCTLMSR_LBR)
+		if (vmx_guest_debugctl_read() & DEBUGCTLMSR_LBR)
 			goto warn;
 		if (test_bit(INTEL_PMC_IDX_FIXED_VLBR, pmu->pmc_in_use))
 			goto warn;
@@ -769,7 +769,7 @@ void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu)
 
 static void intel_pmu_cleanup(struct kvm_vcpu *vcpu)
 {
-	if (!(vmcs_read64(GUEST_IA32_DEBUGCTL) & DEBUGCTLMSR_LBR))
+	if (!(vmx_guest_debugctl_read() & DEBUGCTLMSR_LBR))
 		intel_pmu_release_guest_lbr_event(vcpu);
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fbe26b88f731..22e4c9bbbcb4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -49,6 +49,8 @@
 #include <asm/virtext.h>
 #include <asm/vmx.h>
 
+#include <trace/events/ipi.h>
+
 #include "capabilities.h"
 #include "cpuid.h"
 #include "evmcs.h"
@@ -705,14 +707,19 @@ static int vmx_set_guest_uret_msr(struct vcpu_vmx *vmx,
 	return ret;
 }
 
-static void crash_vmclear_local_loaded_vmcss(void)
+static void vmx_emergency_disable(void)
 {
 	int cpu = raw_smp_processor_id();
 	struct loaded_vmcs *v;
 
 	list_for_each_entry(v, &per_cpu(loaded_vmcss_on_cpu, cpu),
-			    loaded_vmcss_on_cpu_link)
+			    loaded_vmcss_on_cpu_link) {
 		vmcs_clear(v->vmcs);
+		if (v->shadow_vmcs)
+			vmcs_clear(v->shadow_vmcs);
+	}
+
+	__cpu_emergency_vmxoff();
 }
 
 static void __loaded_vmcs_clear(void *arg)
@@ -1223,8 +1230,6 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	u16 fs_sel, gs_sel;
 	int i;
 
-	vmx->req_immediate_exit = false;
-
 	/*
 	 * Note that guest MSRs to be saved/restored can also be changed
 	 * when guest state is loaded. This happens when guest transitions
@@ -1418,13 +1423,9 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
  */
 static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-
 	vmx_vcpu_load_vmcs(vcpu, cpu, NULL);
 
 	vmx_vcpu_pi_load(vcpu, cpu);
-
-	vmx->host_debugctlmsr = get_debugctlmsr();
 }
 
 static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
@@ -2031,7 +2032,7 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			msr_info->data = vmx->pt_desc.guest.addr_a[index / 2];
 		break;
 	case MSR_IA32_DEBUGCTLMSR:
-		msr_info->data = vmcs_read64(GUEST_IA32_DEBUGCTL);
+		msr_info->data = vmx_guest_debugctl_read();
 		break;
 	default:
 	find_uret_msr:
@@ -2056,7 +2057,7 @@ static u64 nested_vmx_truncate_sysenter_addr(struct kvm_vcpu *vcpu,
 	return (unsigned long)data;
 }
 
-static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated)
+u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated)
 {
 	u64 debugctl = 0;
 
@@ -2068,9 +2069,25 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	    (host_initiated || intel_pmu_lbr_is_enabled(vcpu)))
 		debugctl |= DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
 
+	if (boot_cpu_has(X86_FEATURE_RTM) &&
+	    (host_initiated || guest_cpuid_has(vcpu, X86_FEATURE_RTM)))
+		debugctl |= DEBUGCTLMSR_RTM_DEBUG;
+
 	return debugctl;
 }
 
+bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data, bool host_initiated)
+{
+	u64 invalid;
+
+	invalid = data & ~vmx_get_supported_debugctl(vcpu, host_initiated);
+	if (invalid & (DEBUGCTLMSR_BTF | DEBUGCTLMSR_LBR)) {
+		kvm_pr_unimpl_wrmsr(vcpu, MSR_IA32_DEBUGCTLMSR, data);
+		invalid &= ~(DEBUGCTLMSR_BTF | DEBUGCTLMSR_LBR);
+	}
+	return !invalid;
+}
+
 /*
  * Writes msr value into the appropriate "register".
  * Returns 0 on success, non-0 otherwise.
@@ -2139,31 +2156,22 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		}
 		vmcs_writel(GUEST_SYSENTER_ESP, data);
 		break;
-	case MSR_IA32_DEBUGCTLMSR: {
-		u64 invalid;
-
-		invalid = data & ~vmx_get_supported_debugctl(vcpu, msr_info->host_initiated);
-		if (invalid & (DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR)) {
-			if (report_ignored_msrs)
-				vcpu_unimpl(vcpu, "%s: BTF|LBR in IA32_DEBUGCTLMSR 0x%llx, nop\n",
-					    __func__, data);
-			data &= ~(DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR);
-			invalid &= ~(DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR);
-		}
-
-		if (invalid)
+	case MSR_IA32_DEBUGCTLMSR:
+		if (!vmx_is_valid_debugctl(vcpu, data, msr_info->host_initiated))
 			return 1;
 
+		data &= vmx_get_supported_debugctl(vcpu, msr_info->host_initiated);
+
 		if (is_guest_mode(vcpu) && get_vmcs12(vcpu)->vm_exit_controls &
 						VM_EXIT_SAVE_DEBUG_CONTROLS)
 			get_vmcs12(vcpu)->guest_ia32_debugctl = data;
 
-		vmcs_write64(GUEST_IA32_DEBUGCTL, data);
+		vmx_guest_debugctl_write(vcpu, data);
+
 		if (intel_pmu_lbr_is_enabled(vcpu) && !to_vmx(vcpu)->lbr_desc.event &&
 		    (data & DEBUGCTLMSR_LBR))
 			intel_pmu_create_guest_lbr_event(vcpu);
 		return 0;
-	}
 	case MSR_IA32_BNDCFGS:
 		if (!kvm_mpx_supported() ||
 		    (!msr_info->host_initiated &&
@@ -4749,7 +4757,8 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	vmcs_write32(GUEST_SYSENTER_CS, 0);
 	vmcs_writel(GUEST_SYSENTER_ESP, 0);
 	vmcs_writel(GUEST_SYSENTER_EIP, 0);
-	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
+
+	vmx_guest_debugctl_write(&vmx->vcpu, 0);
 
 	if (cpu_has_vmx_tpr_shadow()) {
 		vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, 0);
@@ -5536,12 +5545,6 @@ static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 	set_debugreg(DR6_RESERVED, 6);
 }
 
-static void vmx_set_dr6(struct kvm_vcpu *vcpu, unsigned long val)
-{
-	lockdep_assert_irqs_disabled();
-	set_debugreg(vcpu->arch.dr6, 6);
-}
-
 static void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 {
 	vmcs_writel(GUEST_DR7, val);
@@ -5935,22 +5938,46 @@ static int handle_pml_full(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
+static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu,
+						   bool force_immediate_exit)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	if (!vmx->req_immediate_exit &&
-	    !unlikely(vmx->loaded_vmcs->hv_timer_soft_disabled)) {
-		kvm_lapic_expired_hv_timer(vcpu);
+	/*
+	 * In the *extremely* unlikely scenario that this is a spurious VM-Exit
+	 * due to the timer expiring while it was "soft" disabled, just eat the
+	 * exit and re-enter the guest.
+	 */
+	if (unlikely(vmx->loaded_vmcs->hv_timer_soft_disabled))
 		return EXIT_FASTPATH_REENTER_GUEST;
-	}
 
-	return EXIT_FASTPATH_NONE;
+	/*
+	 * If the timer expired because KVM used it to force an immediate exit,
+	 * then mission accomplished.
+	 */
+	if (force_immediate_exit)
+		return EXIT_FASTPATH_EXIT_HANDLED;
+
+	/*
+	 * If L2 is active, go down the slow path as emulating the guest timer
+	 * expiration likely requires synthesizing a nested VM-Exit.
+	 */
+	if (is_guest_mode(vcpu))
+		return EXIT_FASTPATH_NONE;
+
+	kvm_lapic_expired_hv_timer(vcpu);
+	return EXIT_FASTPATH_REENTER_GUEST;
 }
 
 static int handle_preemption_timer(struct kvm_vcpu *vcpu)
 {
-	handle_fastpath_preemption_timer(vcpu);
+	/*
+	 * This non-fastpath handler is reached if and only if the preemption
+	 * timer was being used to emulate a guest timer while L2 is active.
+	 * All other scenarios are supposed to be handled in the fastpath.
+	 */
+	WARN_ON_ONCE(!is_guest_mode(vcpu));
+	kvm_lapic_expired_hv_timer(vcpu);
 	return 1;
 }
 
@@ -6708,11 +6735,27 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 	put_page(page);
 }
 
-static void vmx_hwapic_isr_update(int max_isr)
+static void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
 {
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
+		 */
+		to_vmx(vcpu)->nested.update_vmcs01_hwapic_isr = true;
+		return;
+	}
+
 	if (max_isr == -1)
 		max_isr = 0;
 
@@ -7057,13 +7100,13 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
 					msrs[i].host, false);
 }
 
-static void vmx_update_hv_timer(struct kvm_vcpu *vcpu)
+static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u64 tscl;
 	u32 delta_tsc;
 
-	if (vmx->req_immediate_exit) {
+	if (force_immediate_exit) {
 		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, 0);
 		vmx->loaded_vmcs->hv_timer_soft_disabled = false;
 	} else if (vmx->hv_deadline_tsc != -1) {
@@ -7116,13 +7159,22 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
 	barrier_nospec();
 }
 
-static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
+static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu,
+					     bool force_immediate_exit)
 {
+	/*
+	 * If L2 is active, some VMX preemption timer exits can be handled in
+	 * the fastpath even, all other exits must use the slow path.
+	 */
+	if (is_guest_mode(vcpu) &&
+	    to_vmx(vcpu)->exit_reason.basic != EXIT_REASON_PREEMPTION_TIMER)
+		return EXIT_FASTPATH_NONE;
+
 	switch (to_vmx(vcpu)->exit_reason.basic) {
 	case EXIT_REASON_MSR_WRITE:
 		return handle_fastpath_set_msr_irqoff(vcpu);
 	case EXIT_REASON_PREEMPTION_TIMER:
-		return handle_fastpath_preemption_timer(vcpu);
+		return handle_fastpath_preemption_timer(vcpu, force_immediate_exit);
 	default:
 		return EXIT_FASTPATH_NONE;
 	}
@@ -7161,8 +7213,9 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	guest_state_exit_irqoff();
 }
 
-static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
+static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 {
+	bool force_immediate_exit = run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long cr3, cr4;
 
@@ -7188,7 +7241,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		return EXIT_FASTPATH_NONE;
 	}
 
-	trace_kvm_entry(vcpu);
+	trace_kvm_entry(vcpu, force_immediate_exit);
 
 	if (vmx->ple_window_dirty) {
 		vmx->ple_window_dirty = false;
@@ -7207,6 +7260,12 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		vmcs_writel(GUEST_RIP, vcpu->arch.regs[VCPU_REGS_RIP]);
 	vcpu->arch.regs_dirty = 0;
 
+	if (run_flags & KVM_RUN_LOAD_GUEST_DR6)
+		set_debugreg(vcpu->arch.dr6, 6);
+
+	if (run_flags & KVM_RUN_LOAD_DEBUGCTL)
+		vmx_reload_guest_debugctl(vcpu);
+
 	/*
 	 * Refresh vmcs.HOST_CR3 if necessary.  This must be done immediately
 	 * prior to VM-Enter, as the kernel may load a new ASID (PCID) any time
@@ -7243,7 +7302,9 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		vmx_passthrough_lbr_msrs(vcpu);
 
 	if (enable_preemption_timer)
-		vmx_update_hv_timer(vcpu);
+		vmx_update_hv_timer(vcpu, force_immediate_exit);
+	else if (force_immediate_exit)
+		smp_send_reschedule(vcpu->cpu);
 
 	kvm_wait_lapic_expire(vcpu);
 
@@ -7259,8 +7320,8 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	}
 
 	/* MSR_IA32_DEBUGCTLMSR is zeroed on vmexit. Restore it if needed */
-	if (vmx->host_debugctlmsr)
-		update_debugctlmsr(vmx->host_debugctlmsr);
+	if (vcpu->arch.host_debugctl)
+		update_debugctlmsr(vcpu->arch.host_debugctl);
 
 #ifndef CONFIG_X86_64
 	/*
@@ -7317,10 +7378,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	vmx_recover_nmi_blocking(vmx);
 	vmx_complete_interrupts(vmx);
 
-	if (is_guest_mode(vcpu))
-		return EXIT_FASTPATH_NONE;
-
-	return vmx_exit_handlers_fastpath(vcpu);
+	return vmx_exit_handlers_fastpath(vcpu, force_immediate_exit);
 }
 
 static void vmx_vcpu_free(struct kvm_vcpu *vcpu)
@@ -7827,11 +7885,6 @@ static __init void vmx_set_cpu_caps(void)
 		kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG);
 }
 
-static void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)
-{
-	to_vmx(vcpu)->req_immediate_exit = true;
-}
-
 static int vmx_check_intercept_io(struct kvm_vcpu *vcpu,
 				  struct x86_instruction_info *info)
 {
@@ -8152,6 +8205,8 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.vcpu_load = vmx_vcpu_load,
 	.vcpu_put = vmx_vcpu_put,
 
+	.HOST_OWNED_DEBUGCTL = DEBUGCTLMSR_FREEZE_IN_SMM,
+
 	.update_exception_bitmap = vmx_update_exception_bitmap,
 	.get_msr_feature = vmx_get_msr_feature,
 	.get_msr = vmx_get_msr,
@@ -8170,7 +8225,6 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.set_idt = vmx_set_idt,
 	.get_gdt = vmx_get_gdt,
 	.set_gdt = vmx_set_gdt,
-	.set_dr6 = vmx_set_dr6,
 	.set_dr7 = vmx_set_dr7,
 	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
 	.cache_reg = vmx_cache_reg,
@@ -8202,6 +8256,8 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.enable_nmi_window = vmx_enable_nmi_window,
 	.enable_irq_window = vmx_enable_irq_window,
 	.update_cr8_intercept = vmx_update_cr8_intercept,
+
+	.x2apic_icr_is_split = false,
 	.set_virtual_apic_mode = vmx_set_virtual_apic_mode,
 	.set_apic_access_page_addr = vmx_set_apic_access_page_addr,
 	.refresh_apicv_exec_ctrl = vmx_refresh_apicv_exec_ctrl,
@@ -8235,8 +8291,6 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.check_intercept = vmx_check_intercept,
 	.handle_exit_irqoff = vmx_handle_exit_irqoff,
 
-	.request_immediate_exit = vmx_request_immediate_exit,
-
 	.sched_in = vmx_sched_in,
 
 	.cpu_dirty_log_size = PML_ENTITY_NUM,
@@ -8493,7 +8547,6 @@ static __init int hardware_setup(void)
 	if (!enable_preemption_timer) {
 		vmx_x86_ops.set_hv_timer = NULL;
 		vmx_x86_ops.cancel_hv_timer = NULL;
-		vmx_x86_ops.request_immediate_exit = __kvm_request_immediate_exit;
 	}
 
 	kvm_caps.supported_mce_cap |= MCG_LMCE_P;
@@ -8554,8 +8607,7 @@ static void __vmx_exit(void)
 {
 	allow_smaller_maxphyaddr = false;
 
-	RCU_INIT_POINTER(crash_vmclear_loaded_vmcss, NULL);
-	synchronize_rcu();
+	cpu_emergency_unregister_virt_callback(vmx_emergency_disable);
 
 	vmx_cleanup_l1d_flush();
 }
@@ -8629,8 +8681,7 @@ static int __init vmx_init(void)
 		pi_init_cpu(cpu);
 	}
 
-	rcu_assign_pointer(crash_vmclear_loaded_vmcss,
-			   crash_vmclear_local_loaded_vmcss);
+	cpu_emergency_register_virt_callback(vmx_emergency_disable);
 
 	vmx_check_vmcs12_offsets();
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 9e0bb98b116d..dc6f06326648 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -189,6 +189,7 @@ struct nested_vmx {
 	bool reload_vmcs01_apic_access_page;
 	bool update_vmcs01_cpu_dirty_logging;
 	bool update_vmcs01_apicv_status;
+	bool update_vmcs01_hwapic_isr;
 
 	/*
 	 * Enlightened VMCS has been enabled. It does not mean that L1 has to
@@ -342,8 +343,6 @@ struct vcpu_vmx {
 	unsigned int ple_window;
 	bool ple_window_dirty;
 
-	bool req_immediate_exit;
-
 	/* Support for PML */
 #define PML_ENTITY_NUM		512
 	struct page *pml_pg;
@@ -351,8 +350,6 @@ struct vcpu_vmx {
 	/* apic deadline value in host tsc */
 	u64 hv_deadline_tsc;
 
-	unsigned long host_debugctlmsr;
-
 	/*
 	 * Only bits masked by msr_ia32_feature_control_valid_bits can be set in
 	 * msr_ia32_feature_control. FEAT_CTL_LOCKED is always included
@@ -445,6 +442,32 @@ static inline void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr,
 
 void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
 
+u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated);
+bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data, bool host_initiated);
+
+static inline void vmx_guest_debugctl_write(struct kvm_vcpu *vcpu, u64 val)
+{
+	WARN_ON_ONCE(val & DEBUGCTLMSR_FREEZE_IN_SMM);
+
+	val |= vcpu->arch.host_debugctl & DEBUGCTLMSR_FREEZE_IN_SMM;
+	vmcs_write64(GUEST_IA32_DEBUGCTL, val);
+}
+
+static inline u64 vmx_guest_debugctl_read(void)
+{
+	return vmcs_read64(GUEST_IA32_DEBUGCTL) & ~DEBUGCTLMSR_FREEZE_IN_SMM;
+}
+
+static inline void vmx_reload_guest_debugctl(struct kvm_vcpu *vcpu)
+{
+	u64 val = vmcs_read64(GUEST_IA32_DEBUGCTL);
+
+	if (!((val ^ vcpu->arch.host_debugctl) & DEBUGCTLMSR_FREEZE_IN_SMM))
+		return;
+
+	vmx_guest_debugctl_write(vcpu, val & ~DEBUGCTLMSR_FREEZE_IN_SMM);
+}
+
 /*
  * Note, early Intel manuals have the write-low and read-high bitmap offsets
  * the wrong way round.  The bitmaps control MSRs 0x00000000-0x00001fff and
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a6dc8f662fa4..f542ab5e8698 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3573,7 +3573,6 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
-	bool pr = false;
 	u32 msr = msr_info->index;
 	u64 data = msr_info->data;
 
@@ -3625,15 +3624,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (data == BIT_ULL(18)) {
 			vcpu->arch.msr_hwcr = data;
 		} else if (data != 0) {
-			vcpu_unimpl(vcpu, "unimplemented HWCR wrmsr: 0x%llx\n",
-				    data);
+			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 			return 1;
 		}
 		break;
 	case MSR_FAM10H_MMIO_CONF_BASE:
 		if (data != 0) {
-			vcpu_unimpl(vcpu, "unimplemented MMIO_CONF_BASE wrmsr: "
-				    "0x%llx\n", data);
+			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 			return 1;
 		}
 		break;
@@ -3813,16 +3810,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 	case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR3:
 	case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR1:
-		pr = true;
-		fallthrough;
 	case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL3:
 	case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL1:
 		if (kvm_pmu_is_valid_msr(vcpu, msr))
 			return kvm_pmu_set_msr(vcpu, msr_info);
 
-		if (pr || data != 0)
-			vcpu_unimpl(vcpu, "disabled perfctr wrmsr: "
-				    "0x%x data 0x%llx\n", msr, data);
+		if (data)
+			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 		break;
 	case MSR_K7_CLK_CTL:
 		/*
@@ -3849,9 +3843,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		/* Drop writes to this legacy MSR -- see rdmsr
 		 * counterpart for further detail.
 		 */
-		if (report_ignored_msrs)
-			vcpu_unimpl(vcpu, "ignored wrmsr: 0x%x data 0x%llx\n",
-				msr, data);
+		kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 		break;
 	case MSR_AMD64_OSVW_ID_LENGTH:
 		if (!guest_cpuid_has(vcpu, X86_FEATURE_OSVW))
@@ -10586,12 +10578,6 @@ static void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
 	static_call_cond(kvm_x86_set_apic_access_page_addr)(vcpu);
 }
 
-void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu)
-{
-	smp_send_reschedule(vcpu->cpu);
-}
-EXPORT_SYMBOL_GPL(__kvm_request_immediate_exit);
-
 /*
  * Called within kvm->srcu read side.
  * Returns 1 to let vcpu_run() continue the guest execution loop without
@@ -10605,6 +10591,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		dm_request_for_irq_injection(vcpu) &&
 		kvm_cpu_accept_dm_intr(vcpu);
 	fastpath_t exit_fastpath;
+	u64 run_flags, debug_ctl;
 
 	bool req_immediate_exit = false;
 
@@ -10825,9 +10812,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		goto cancel_injection;
 	}
 
+	run_flags = 0;
 	if (req_immediate_exit) {
+		run_flags |= KVM_RUN_FORCE_IMMEDIATE_EXIT;
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
-		static_call(kvm_x86_request_immediate_exit)(vcpu);
 	}
 
 	fpregs_assert_state_consistent();
@@ -10845,11 +10833,23 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(vcpu->arch.eff_db[3], 3);
 		/* When KVM_DEBUGREG_WONT_EXIT, dr6 is accessible in guest. */
 		if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
-			static_call(kvm_x86_set_dr6)(vcpu, vcpu->arch.dr6);
+			run_flags |= KVM_RUN_LOAD_GUEST_DR6;
 	} else if (unlikely(hw_breakpoint_active())) {
 		set_debugreg(0, 7);
 	}
 
+	/*
+	 * Refresh the host DEBUGCTL snapshot after disabling IRQs, as DEBUGCTL
+	 * can be modified in IRQ context, e.g. via SMP function calls.  Inform
+	 * vendor code if any host-owned bits were changed, e.g. so that the
+	 * value loaded into hardware while running the guest can be updated.
+	 */
+	debug_ctl = get_debugctlmsr();
+	if ((debug_ctl ^ vcpu->arch.host_debugctl) & kvm_x86_ops.HOST_OWNED_DEBUGCTL &&
+	    !vcpu->arch.guest_state_protected)
+		run_flags |= KVM_RUN_LOAD_DEBUGCTL;
+	vcpu->arch.host_debugctl = debug_ctl;
+
 	guest_timing_enter_irqoff();
 
 	for (;;) {
@@ -10862,7 +10862,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		WARN_ON_ONCE((kvm_vcpu_apicv_activated(vcpu) != kvm_vcpu_apicv_active(vcpu)) &&
 			     (kvm_get_apic_mode(vcpu) != LAPIC_MODE_DISABLED));
 
-		exit_fastpath = static_call(kvm_x86_vcpu_run)(vcpu);
+		exit_fastpath = static_call(kvm_x86_vcpu_run)(vcpu, run_flags);
 		if (likely(exit_fastpath != EXIT_FASTPATH_REENTER_GUEST))
 			break;
 
@@ -10874,6 +10874,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			break;
 		}
 
+		run_flags = 0;
+
 		/* Note, VM-Exits that go down the "slow" path are accounted below. */
 		++vcpu->stat.exits;
 	}
@@ -13385,16 +13387,22 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
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
 	ret = static_call(kvm_x86_pi_update_irte)(irqfd->kvm,
 					 prod->irq, irqfd->gsi, 1);
-
 	if (ret)
 		kvm_arch_end_assignment(irqfd->kvm);
 
+	spin_unlock_irq(&kvm->irqfds.lock);
+
+
 	return ret;
 }
 
@@ -13404,9 +13412,9 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	int ret;
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
 
 	WARN_ON(irqfd->producer != prod);
-	irqfd->producer = NULL;
 
 	/*
 	 * When producer of consumer is unregistered, we change back to
@@ -13414,11 +13422,18 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	 * when the irq is masked/disabled or the consumer side (KVM
 	 * int this case doesn't want to receive the interrupts.
 	*/
+	spin_lock_irq(&kvm->irqfds.lock);
+	irqfd->producer = NULL;
+
+
 	ret = static_call(kvm_x86_pi_update_irte)(irqfd->kvm, prod->irq, irqfd->gsi, 0);
 	if (ret)
 		printk(KERN_INFO "irq bypass consumer (token %p) unregistration"
 		       " fails: %d\n", irqfd->consumer.token, ret);
 
+	spin_unlock_irq(&kvm->irqfds.lock);
+
+
 	kvm_arch_end_assignment(irqfd->kvm);
 }
 
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 9de72586f406..f3554bf05201 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -331,6 +331,18 @@ extern bool report_ignored_msrs;
 
 extern bool eager_page_split;
 
+static inline void kvm_pr_unimpl_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
+{
+	if (report_ignored_msrs)
+		vcpu_unimpl(vcpu, "Unhandled WRMSR(0x%x) = 0x%llx\n", msr, data);
+}
+
+static inline void kvm_pr_unimpl_rdmsr(struct kvm_vcpu *vcpu, u32 msr)
+{
+	if (report_ignored_msrs)
+		vcpu_unimpl(vcpu, "Unhandled RDMSR(0x%x)\n", msr);
+}
+
 static inline u64 nsec_to_cycles(struct kvm_vcpu *vcpu, u64 nsec)
 {
 	return pvclock_scale_delta(nsec, vcpu->arch.virtual_tsc_mult,
diff --git a/block/blk-core.c b/block/blk-core.c
index 94941e3ce219..25b4733f25d3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -755,6 +755,15 @@ void submit_bio_noacct(struct bio *bio)
 		bio_clear_polled(bio);
 
 	switch (bio_op(bio)) {
+	case REQ_OP_READ:
+	case REQ_OP_WRITE:
+		break;
+	case REQ_OP_FLUSH:
+		/*
+		 * REQ_OP_FLUSH can't be submitted through bios, it is only
+		 * synthetized in struct request by the flush state machine.
+		 */
+		goto not_supported;
 	case REQ_OP_DISCARD:
 		if (!bdev_max_discard_sectors(bdev))
 			goto not_supported;
@@ -768,6 +777,10 @@ void submit_bio_noacct(struct bio *bio)
 		if (status != BLK_STS_OK)
 			goto end_io;
 		break;
+	case REQ_OP_WRITE_ZEROES:
+		if (!q->limits.max_write_zeroes_sectors)
+			goto not_supported;
+		break;
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_OPEN:
 	case REQ_OP_ZONE_CLOSE:
@@ -779,12 +792,15 @@ void submit_bio_noacct(struct bio *bio)
 		if (!bdev_is_zoned(bio->bi_bdev) || !blk_queue_zone_resetall(q))
 			goto not_supported;
 		break;
-	case REQ_OP_WRITE_ZEROES:
-		if (!q->limits.max_write_zeroes_sectors)
-			goto not_supported;
-		break;
+	case REQ_OP_DRV_IN:
+	case REQ_OP_DRV_OUT:
+		/*
+		 * Driver private operations are only used with passthrough
+		 * requests.
+		 */
+		fallthrough;
 	default:
-		break;
+		goto not_supported;
 	}
 
 	if (blk_throtl_bio(bio))
diff --git a/block/blk-settings.c b/block/blk-settings.c
index c702f408bbc0..305b47a38429 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -628,7 +628,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	}
 
 	/* chunk_sectors a multiple of the physical block size? */
-	if ((t->chunk_sectors << 9) & (t->physical_block_size - 1)) {
+	if (t->chunk_sectors % (t->physical_block_size >> SECTOR_SHIFT)) {
 		t->chunk_sectors = 0;
 		t->misaligned = 1;
 		ret = -1;
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 8bd5c4fa91f2..cfa75b14caa2 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -216,7 +216,7 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
 
 static int acpi_processor_get_info(struct acpi_device *device)
 {
-	union acpi_object object = { 0 };
+	union acpi_object object = { .processor = { 0 } };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 	struct acpi_processor *pr = acpi_driver_data(device);
 	int device_declaration = 0;
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 1f327ec4c30b..3c862acaa28a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -860,6 +860,8 @@ static void __ghes_panic(struct ghes *ghes,
 
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
 
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
+
 	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
 
 	if (!panic_timeout)
diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 98267f163e2b..aedf7e40145e 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -310,7 +310,7 @@ static bool applicable_image(const void *data, struct pfru_update_cap_info *cap,
 	if (type == PFRU_CODE_INJECT_TYPE)
 		return payload_hdr->rt_ver >= cap->code_rt_version;
 
-	return payload_hdr->rt_ver >= cap->drv_rt_version;
+	return payload_hdr->svn_ver >= cap->drv_svn;
 }
 
 static void print_update_debug_info(struct pfru_updated_result *result,
diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 7747ca4168ab..215ca8d60616 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -85,8 +85,6 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
 		}
 	}
 
-	pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa);
-
 	return 0;
 }
 
@@ -154,13 +152,37 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
 		th->handler_addr =
 			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
+		/*
+		 * Print a warning message if handler_addr is zero which is not expected to
+		 * ever happen.
+		 */
+		if (unlikely(!th->handler_addr))
+			pr_warn("Failed to find VA of handler for GUID: %pUL, PA: 0x%llx",
+				&th->guid, handler_info->handler_address);
 
 		th->static_data_buffer_addr =
 			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
+		/*
+		 * According to the PRM specification, static_data_buffer_address can be zero,
+		 * so avoid printing a warning message in that case.  Otherwise, if the
+		 * return value of efi_pa_va_lookup() is zero, print the message.
+		 */
+		if (unlikely(!th->static_data_buffer_addr && handler_info->static_data_buffer_address))
+			pr_warn("Failed to find VA of static data buffer for GUID: %pUL, PA: 0x%llx",
+				&th->guid, handler_info->static_data_buffer_address);
 
 		th->acpi_param_buffer_addr =
 			efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);
 
+		/*
+		 * According to the PRM specification, acpi_param_buffer_address can be zero,
+		 * so avoid printing a warning message in that case.  Otherwise, if the
+		 * return value of efi_pa_va_lookup() is zero, print the message.
+		 */
+		if (unlikely(!th->acpi_param_buffer_addr && handler_info->acpi_param_buffer_address))
+			pr_warn("Failed to find VA of acpi param buffer for GUID: %pUL, PA: 0x%llx",
+				&th->guid, handler_info->acpi_param_buffer_address);
+
 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
 
 	return 0;
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 1696700fd2fb..ebdeb77227ce 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -173,6 +173,9 @@ void acpi_processor_ppc_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu;
 
+	if (ignore_ppc == 1)
+		return;
+
 	for_each_cpu(cpu, policy->related_cpus) {
 		struct acpi_processor *pr = per_cpu(processors, cpu);
 		int ret;
@@ -193,6 +196,14 @@ void acpi_processor_ppc_init(struct cpufreq_policy *policy)
 		if (ret < 0)
 			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
 			       cpu, ret);
+
+		if (!pr->performance)
+			continue;
+
+		ret = acpi_processor_get_platform_limit(pr);
+		if (ret)
+			pr_err("Failed to update freq constraint for CPU%d (%d)\n",
+			       cpu, ret);
 	}
 }
 
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index d9b305a3427f..5f96d15e0c09 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -117,7 +117,7 @@ config SATA_AHCI
 
 config SATA_MOBILE_LPM_POLICY
 	int "Default SATA Link Power Management policy for low power chipsets"
-	range 0 4
+	range 0 5
 	default 0
 	depends on SATA_AHCI
 	help
@@ -126,15 +126,32 @@ config SATA_MOBILE_LPM_POLICY
 	  chipsets are typically found on most laptops but desktops and
 	  servers now also widely use chipsets supporting low power modes.
 
-	  The value set has the following meanings:
+	  Each policy combines power saving states and features:
+	   - Partial: The Phy logic is powered but is in a reduced power
+                      state. The exit latency from this state is no longer than
+                      10us).
+	   - Slumber: The Phy logic is powered but is in an even lower power
+                      state. The exit latency from this state is potentially
+		      longer, but no longer than 10ms.
+	   - DevSleep: The Phy logic may be powered down. The exit latency from
+	               this state is no longer than 20 ms, unless otherwise
+		       specified by DETO in the device Identify Device Data log.
+	   - HIPM: Host Initiated Power Management (host automatically
+		   transitions to partial and slumber).
+	   - DIPM: Device Initiated Power Management (device automatically
+		   transitions to partial and slumber).
+
+	  The possible values for the default SATA link power management
+	  policies are:
 		0 => Keep firmware settings
-		1 => Maximum performance
-		2 => Medium power
-		3 => Medium power with Device Initiated PM enabled
-		4 => Minimum power
-
-	  Note "Minimum power" is known to cause issues, including disk
-	  corruption, with some disks and should not be used.
+		1 => No power savings (maximum performance)
+		2 => HIPM (Partial)
+		3 => HIPM (Partial) and DIPM (Partial and Slumber)
+		4 => HIPM (Partial and DevSleep) and DIPM (Partial and Slumber)
+		5 => HIPM (Slumber and DevSleep) and DIPM (Partial and Slumber)
+
+	  Excluding the value 0, higher values represent policies with higher
+	  power savings.
 
 config SATA_AHCI_PLATFORM
 	tristate "Platform AHCI SATA support"
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 71a00842eb5e..b75999388bf0 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -812,6 +812,11 @@ static ssize_t ata_scsi_lpm_store(struct device *device,
 
 	spin_lock_irqsave(ap->lock, flags);
 
+	if (ap->flags & ATA_FLAG_NO_LPM) {
+		count = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	ata_for_each_link(link, ap, EDGE) {
 		ata_for_each_dev(dev, &ap->link, ENABLED) {
 			if (dev->horkage & ATA_HORKAGE_NOLPM) {
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0e71b8763c4c..7d2910659515 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -798,18 +798,14 @@ static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
 		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
 	};
 	static const unsigned char stat_table[][4] = {
-		/* Must be first because BUSY means no other bits valid */
-		{0x80,		ABORTED_COMMAND, 0x47, 0x00},
-		// Busy, fake parity for now
-		{0x40,		ILLEGAL_REQUEST, 0x21, 0x04},
-		// Device ready, unaligned write command
-		{0x20,		HARDWARE_ERROR,  0x44, 0x00},
-		// Device fault, internal target failure
-		{0x08,		ABORTED_COMMAND, 0x47, 0x00},
-		// Timed out in xfer, fake parity for now
-		{0x04,		RECOVERED_ERROR, 0x11, 0x00},
-		// Recovered ECC error	  Medium error, recovered
-		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
+		/* Busy: must be first because BUSY means no other bits valid */
+		{ ATA_BUSY,	ABORTED_COMMAND, 0x00, 0x00 },
+		/* Device fault: INTERNAL TARGET FAILURE */
+		{ ATA_DF,	HARDWARE_ERROR,  0x44, 0x00 },
+		/* Corrected data error */
+		{ ATA_CORR,	RECOVERED_ERROR, 0x00, 0x00 },
+
+		{ 0xFF, 0xFF, 0xFF, 0xFF }, /* END mark */
 	};
 
 	/*
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 313ccb7e7764..61d8ebc2de59 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1753,6 +1753,11 @@ void pm_runtime_reinit(struct device *dev)
 				pm_runtime_put(dev->parent);
 		}
 	}
+	/*
+	 * Clear power.needs_force_resume in case it has been set by
+	 * pm_runtime_force_suspend() invoked from a driver remove callback.
+	 */
+	dev->power.needs_force_resume = false;
 }
 
 /**
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 4ba09abbcaf6..acaa84fbe7f6 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2478,7 +2478,11 @@ static int handle_write_conflicts(struct drbd_device *device,
 			peer_req->w.cb = superseded ? e_send_superseded :
 						   e_send_retry_write;
 			list_add_tail(&peer_req->w.list, &device->done_ee);
-			queue_work(connection->ack_sender, &peer_req->peer_device->send_acks_work);
+			/* put is in drbd_send_acks_wf() */
+			kref_get(&device->kref);
+			if (!queue_work(connection->ack_sender,
+					&peer_req->peer_device->send_acks_work))
+				kref_put(&device->kref, drbd_destroy_device);
 
 			err = -ENOENT;
 			goto out;
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 9fa821fa76b0..afdf3119e119 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -956,8 +956,10 @@ static bool vdc_port_mpgroup_check(struct vio_dev *vdev)
 	dev = device_find_child(vdev->dev.parent, &port_data,
 				vdc_device_probed);
 
-	if (dev)
+	if (dev) {
+		put_device(dev);
 		return true;
+	}
 
 	return false;
 }
diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index 55e909f8cb25..13e77182d7d0 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -31,8 +31,8 @@ int mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
 	int ret;
 
 	for (i = 0; i < img_info->entries - 1; i++, mhi_buf++, bhi_vec++) {
-		bhi_vec->dma_addr = mhi_buf->dma_addr;
-		bhi_vec->size = mhi_buf->len;
+		bhi_vec->dma_addr = cpu_to_le64(mhi_buf->dma_addr);
+		bhi_vec->size = cpu_to_le64(mhi_buf->len);
 	}
 
 	dev_dbg(dev, "BHIe programming for RDDM\n");
@@ -379,8 +379,8 @@ static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
 	while (remainder) {
 		to_cpy = min(remainder, mhi_buf->len);
 		memcpy(mhi_buf->buf, buf, to_cpy);
-		bhi_vec->dma_addr = mhi_buf->dma_addr;
-		bhi_vec->size = to_cpy;
+		bhi_vec->dma_addr = cpu_to_le64(mhi_buf->dma_addr);
+		bhi_vec->size = cpu_to_le64(to_cpy);
 
 		buf += to_cpy;
 		remainder -= to_cpy;
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 6abf09da4f61..532ceba7e605 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -31,8 +31,8 @@ struct mhi_ctxt {
 };
 
 struct bhi_vec_entry {
-	u64 dma_addr;
-	u64 size;
+	__le64 dma_addr;
+	__le64 size;
 };
 
 enum mhi_ch_state_type {
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index b4bb4f8b8f44..3136c68af713 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -603,7 +603,7 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 	{
 		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
 		struct mhi_ring_element *local_rp, *ev_tre;
-		void *dev_rp;
+		void *dev_rp, *next_rp;
 		struct mhi_buf_info *buf_info;
 		u16 xfer_len;
 
@@ -622,6 +622,16 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 		result.dir = mhi_chan->dir;
 
 		local_rp = tre_ring->rp;
+
+		next_rp = local_rp + 1;
+		if (next_rp >= tre_ring->base + tre_ring->len)
+			next_rp = tre_ring->base;
+		if (dev_rp != next_rp && !MHI_TRE_DATA_GET_CHAIN(local_rp)) {
+			dev_err(&mhi_cntrl->mhi_dev->dev,
+				"Event element points to an unexpected TRE\n");
+			break;
+		}
+
 		while (local_rp != dev_rp) {
 			buf_info = buf_ring->rp;
 			/* If it's the last TRE, get length from the event */
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index e4ac38b39889..653e07171dc6 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4618,10 +4618,10 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
 		 * The NetFN and Command in the response is not even
 		 * marginally correct.
 		 */
-		dev_warn(intf->si_dev,
-			 "BMC returned incorrect response, expected netfn %x cmd %x, got netfn %x cmd %x\n",
-			 (msg->data[0] >> 2) | 1, msg->data[1],
-			 msg->rsp[0] >> 2, msg->rsp[1]);
+		dev_warn_ratelimited(intf->si_dev,
+				     "BMC returned incorrect response, expected netfn %x cmd %x, got netfn %x cmd %x\n",
+				     (msg->data[0] >> 2) | 1, msg->data[1],
+				     msg->rsp[0] >> 2, msg->rsp[1]);
 
 		goto return_unspecified;
 	}
diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index 5b4e677929ca..5eb614f954fd 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -1190,14 +1190,8 @@ static struct ipmi_smi_watcher smi_watcher = {
 	.smi_gone = ipmi_smi_gone
 };
 
-static int action_op(const char *inval, char *outval)
+static int action_op_set_val(const char *inval)
 {
-	if (outval)
-		strcpy(outval, action);
-
-	if (!inval)
-		return 0;
-
 	if (strcmp(inval, "reset") == 0)
 		action_val = WDOG_TIMEOUT_RESET;
 	else if (strcmp(inval, "none") == 0)
@@ -1208,18 +1202,26 @@ static int action_op(const char *inval, char *outval)
 		action_val = WDOG_TIMEOUT_POWER_DOWN;
 	else
 		return -EINVAL;
-	strcpy(action, inval);
 	return 0;
 }
 
-static int preaction_op(const char *inval, char *outval)
+static int action_op(const char *inval, char *outval)
 {
+	int rv;
+
 	if (outval)
-		strcpy(outval, preaction);
+		strcpy(outval, action);
 
 	if (!inval)
 		return 0;
+	rv = action_op_set_val(inval);
+	if (!rv)
+		strcpy(action, inval);
+	return rv;
+}
 
+static int preaction_op_set_val(const char *inval)
+{
 	if (strcmp(inval, "pre_none") == 0)
 		preaction_val = WDOG_PRETIMEOUT_NONE;
 	else if (strcmp(inval, "pre_smi") == 0)
@@ -1232,18 +1234,26 @@ static int preaction_op(const char *inval, char *outval)
 		preaction_val = WDOG_PRETIMEOUT_MSG_INT;
 	else
 		return -EINVAL;
-	strcpy(preaction, inval);
 	return 0;
 }
 
-static int preop_op(const char *inval, char *outval)
+static int preaction_op(const char *inval, char *outval)
 {
+	int rv;
+
 	if (outval)
-		strcpy(outval, preop);
+		strcpy(outval, preaction);
 
 	if (!inval)
 		return 0;
+	rv = preaction_op_set_val(inval);
+	if (!rv)
+		strcpy(preaction, inval);
+	return 0;
+}
 
+static int preop_op_set_val(const char *inval)
+{
 	if (strcmp(inval, "preop_none") == 0)
 		preop_val = WDOG_PREOP_NONE;
 	else if (strcmp(inval, "preop_panic") == 0)
@@ -1252,7 +1262,22 @@ static int preop_op(const char *inval, char *outval)
 		preop_val = WDOG_PREOP_GIVE_DATA;
 	else
 		return -EINVAL;
-	strcpy(preop, inval);
+	return 0;
+}
+
+static int preop_op(const char *inval, char *outval)
+{
+	int rv;
+
+	if (outval)
+		strcpy(outval, preop);
+
+	if (!inval)
+		return 0;
+
+	rv = preop_op_set_val(inval);
+	if (!rv)
+		strcpy(preop, inval);
 	return 0;
 }
 
@@ -1289,18 +1314,18 @@ static int __init ipmi_wdog_init(void)
 {
 	int rv;
 
-	if (action_op(action, NULL)) {
+	if (action_op_set_val(action)) {
 		action_op("reset", NULL);
 		pr_info("Unknown action '%s', defaulting to reset\n", action);
 	}
 
-	if (preaction_op(preaction, NULL)) {
+	if (preaction_op_set_val(preaction)) {
 		preaction_op("pre_none", NULL);
 		pr_info("Unknown preaction '%s', defaulting to none\n",
 			preaction);
 	}
 
-	if (preop_op(preop, NULL)) {
+	if (preop_op_set_val(preop)) {
 		preop_op("preop_none", NULL);
 		pr_info("Unknown preop '%s', defaulting to none\n", preop);
 	}
diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 8325cd4beeda..921280ad6bc0 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -783,6 +783,7 @@ static int is_device_busy(struct comedi_device *dev)
 	struct comedi_subdevice *s;
 	int i;
 
+	lockdep_assert_held_write(&dev->attach_lock);
 	lockdep_assert_held(&dev->mutex);
 	if (!dev->attached)
 		return 0;
@@ -791,7 +792,16 @@ static int is_device_busy(struct comedi_device *dev)
 		s = &dev->subdevices[i];
 		if (s->busy)
 			return 1;
-		if (s->async && comedi_buf_is_mmapped(s))
+		if (!s->async)
+			continue;
+		if (comedi_buf_is_mmapped(s))
+			return 1;
+		/*
+		 * There may be tasks still waiting on the subdevice's wait
+		 * queue, although they should already be about to be removed
+		 * from it since the subdevice has no active async command.
+		 */
+		if (wq_has_sleeper(&s->async->wait_head))
 			return 1;
 	}
 
@@ -821,15 +831,22 @@ static int do_devconfig_ioctl(struct comedi_device *dev,
 		return -EPERM;
 
 	if (!arg) {
-		if (is_device_busy(dev))
-			return -EBUSY;
+		int rc = 0;
+
 		if (dev->attached) {
-			struct module *driver_module = dev->driver->module;
+			down_write(&dev->attach_lock);
+			if (is_device_busy(dev)) {
+				rc = -EBUSY;
+			} else {
+				struct module *driver_module =
+					dev->driver->module;
 
-			comedi_device_detach(dev);
-			module_put(driver_module);
+				comedi_device_detach_locked(dev);
+				module_put(driver_module);
+			}
+			up_write(&dev->attach_lock);
 		}
-		return 0;
+		return rc;
 	}
 
 	if (copy_from_user(&it, arg, sizeof(it)))
@@ -1565,6 +1582,9 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 				memset(&data[n], 0, (MIN_SAMPLES - n) *
 						    sizeof(unsigned int));
 			}
+		} else {
+			memset(data, 0, max_t(unsigned int, n, MIN_SAMPLES) *
+					sizeof(unsigned int));
 		}
 		ret = parse_insn(dev, insns + i, data, file);
 		if (ret < 0)
@@ -1648,6 +1668,8 @@ static int do_insn_ioctl(struct comedi_device *dev,
 			memset(&data[insn->n], 0,
 			       (MIN_SAMPLES - insn->n) * sizeof(unsigned int));
 		}
+	} else {
+		memset(data, 0, n_data * sizeof(unsigned int));
 	}
 	ret = parse_insn(dev, insn, data, file);
 	if (ret < 0)
diff --git a/drivers/comedi/comedi_internal.h b/drivers/comedi/comedi_internal.h
index 9b3631a654c8..cf10ba016ebc 100644
--- a/drivers/comedi/comedi_internal.h
+++ b/drivers/comedi/comedi_internal.h
@@ -50,6 +50,7 @@ extern struct mutex comedi_drivers_list_lock;
 int insn_inval(struct comedi_device *dev, struct comedi_subdevice *s,
 	       struct comedi_insn *insn, unsigned int *data);
 
+void comedi_device_detach_locked(struct comedi_device *dev);
 void comedi_device_detach(struct comedi_device *dev);
 int comedi_device_attach(struct comedi_device *dev,
 			 struct comedi_devconfig *it);
diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index 086213bcc499..ce4cde140518 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -158,7 +158,7 @@ static void comedi_device_detach_cleanup(struct comedi_device *dev)
 	int i;
 	struct comedi_subdevice *s;
 
-	lockdep_assert_held(&dev->attach_lock);
+	lockdep_assert_held_write(&dev->attach_lock);
 	lockdep_assert_held(&dev->mutex);
 	if (dev->subdevices) {
 		for (i = 0; i < dev->n_subdevices; i++) {
@@ -195,16 +195,23 @@ static void comedi_device_detach_cleanup(struct comedi_device *dev)
 	comedi_clear_hw_dev(dev);
 }
 
-void comedi_device_detach(struct comedi_device *dev)
+void comedi_device_detach_locked(struct comedi_device *dev)
 {
+	lockdep_assert_held_write(&dev->attach_lock);
 	lockdep_assert_held(&dev->mutex);
 	comedi_device_cancel_all(dev);
-	down_write(&dev->attach_lock);
 	dev->attached = false;
 	dev->detach_count++;
 	if (dev->driver)
 		dev->driver->detach(dev);
 	comedi_device_detach_cleanup(dev);
+}
+
+void comedi_device_detach(struct comedi_device *dev)
+{
+	lockdep_assert_held(&dev->mutex);
+	down_write(&dev->attach_lock);
+	comedi_device_detach_locked(dev);
 	up_write(&dev->attach_lock);
 }
 
@@ -612,11 +619,9 @@ static int insn_rw_emulate_bits(struct comedi_device *dev,
 	unsigned int chan = CR_CHAN(insn->chanspec);
 	unsigned int base_chan = (chan < 32) ? 0 : chan;
 	unsigned int _data[2];
+	unsigned int i;
 	int ret;
 
-	if (insn->n == 0)
-		return 0;
-
 	memset(_data, 0, sizeof(_data));
 	memset(&_insn, 0, sizeof(_insn));
 	_insn.insn = INSN_BITS;
@@ -627,18 +632,21 @@ static int insn_rw_emulate_bits(struct comedi_device *dev,
 	if (insn->insn == INSN_WRITE) {
 		if (!(s->subdev_flags & SDF_WRITABLE))
 			return -EINVAL;
-		_data[0] = 1U << (chan - base_chan);		     /* mask */
-		_data[1] = data[0] ? (1U << (chan - base_chan)) : 0; /* bits */
+		_data[0] = 1U << (chan - base_chan);		/* mask */
 	}
+	for (i = 0; i < insn->n; i++) {
+		if (insn->insn == INSN_WRITE)
+			_data[1] = data[i] ? _data[0] : 0;	/* bits */
 
-	ret = s->insn_bits(dev, s, &_insn, _data);
-	if (ret < 0)
-		return ret;
+		ret = s->insn_bits(dev, s, &_insn, _data);
+		if (ret < 0)
+			return ret;
 
-	if (insn->insn == INSN_READ)
-		data[0] = (_data[1] >> (chan - base_chan)) & 1;
+		if (insn->insn == INSN_READ)
+			data[i] = (_data[1] >> (chan - base_chan)) & 1;
+	}
 
-	return 1;
+	return insn->n;
 }
 
 static int __comedi_device_postconfig_async(struct comedi_device *dev,
diff --git a/drivers/comedi/drivers/pcl726.c b/drivers/comedi/drivers/pcl726.c
index 0430630e6ebb..b542896fa0e4 100644
--- a/drivers/comedi/drivers/pcl726.c
+++ b/drivers/comedi/drivers/pcl726.c
@@ -328,7 +328,8 @@ static int pcl726_attach(struct comedi_device *dev,
 	 * Hook up the external trigger source interrupt only if the
 	 * user config option is valid and the board supports interrupts.
 	 */
-	if (it->options[1] && (board->irq_mask & (1 << it->options[1]))) {
+	if (it->options[1] > 0 && it->options[1] < 16 &&
+	    (board->irq_mask & (1U << it->options[1]))) {
 		ret = request_irq(it->options[1], pcl726_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0) {
diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index b0fc5e84f857..cab86a9be6bd 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -96,7 +96,7 @@ static void armada_8k_cpufreq_free_table(struct freq_table *freq_tables)
 {
 	int opps_index, nb_cpus = num_possible_cpus();
 
-	for (opps_index = 0 ; opps_index <= nb_cpus; opps_index++) {
+	for (opps_index = 0 ; opps_index < nb_cpus; opps_index++) {
 		int i;
 
 		/* If cpu_dev is NULL then we reached the end of the array */
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index cfa2e3f0e56b..d77e4aa209d9 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -809,7 +809,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 };
 
 static struct cpufreq_driver cppc_cpufreq_driver = {
-	.flags = CPUFREQ_CONST_LOOPS,
+	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify = cppc_verify_policy,
 	.target = cppc_cpufreq_set_target,
 	.get = cppc_cpufreq_get_rate,
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 805b4d26e9d2..90bdccab1dff 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2649,10 +2649,12 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	pr_debug("starting governor %s failed\n", policy->governor->name);
 	if (old_gov) {
 		policy->governor = old_gov;
-		if (cpufreq_init_governor(policy))
+		if (cpufreq_init_governor(policy)) {
 			policy->governor = NULL;
-		else
-			cpufreq_start_governor(policy);
+		} else if (cpufreq_start_governor(policy)) {
+			cpufreq_exit_governor(policy);
+			policy->governor = NULL;
+		}
 	}
 
 	return ret;
diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index ef02dadd6217..541f5eb76b6e 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -1461,11 +1461,13 @@ static void hpre_ecdh_cb(struct hpre_ctx *ctx, void *resp)
 	if (overtime_thrhld && hpre_is_bd_timeout(req, overtime_thrhld))
 		atomic64_inc(&dfx[HPRE_OVER_THRHLD_CNT].value);
 
+	/* Do unmap before data processing */
+	hpre_ecdh_hw_data_clr_all(ctx, req, areq->dst, areq->src);
+
 	p = sg_virt(areq->dst);
 	memmove(p, p + ctx->key_sz - curve_sz, curve_sz);
 	memmove(p + curve_sz, p + areq->dst_len - curve_sz, curve_sz);
 
-	hpre_ecdh_hw_data_clr_all(ctx, req, areq->dst, areq->src);
 	kpp_request_complete(areq, ret);
 
 	atomic64_inc(&dfx[HPRE_RECV_CNT].value);
@@ -1769,9 +1771,11 @@ static void hpre_curve25519_cb(struct hpre_ctx *ctx, void *resp)
 	if (overtime_thrhld && hpre_is_bd_timeout(req, overtime_thrhld))
 		atomic64_inc(&dfx[HPRE_OVER_THRHLD_CNT].value);
 
+	/* Do unmap before data processing */
+	hpre_curve25519_hw_data_clr_all(ctx, req, areq->dst, areq->src);
+
 	hpre_key_to_big_end(sg_virt(areq->dst), CURVE25519_KEY_SIZE);
 
-	hpre_curve25519_hw_data_clr_all(ctx, req, areq->dst, areq->src);
 	kpp_request_complete(areq, ret);
 
 	atomic64_inc(&dfx[HPRE_RECV_CNT].value);
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index 1577986677f6..b73a13ae55c4 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -1485,6 +1485,7 @@ int otx2_cpt_discover_eng_capabilities(struct otx2_cptpf_dev *cptpf)
 	dma_addr_t rptr_baddr;
 	struct pci_dev *pdev;
 	u32 len, compl_rlen;
+	int timeout = 10000;
 	int ret, etype;
 	void *rptr;
 
@@ -1549,16 +1550,27 @@ int otx2_cpt_discover_eng_capabilities(struct otx2_cptpf_dev *cptpf)
 							 etype);
 		otx2_cpt_fill_inst(&inst, &iq_cmd, rptr_baddr);
 		lfs->ops->send_cmd(&inst, 1, &cptpf->lfs.lf[0]);
+		timeout = 10000;
 
 		while (lfs->ops->cpt_get_compcode(result) ==
-						OTX2_CPT_COMPLETION_CODE_INIT)
+						OTX2_CPT_COMPLETION_CODE_INIT) {
 			cpu_relax();
+			udelay(1);
+			timeout--;
+			if (!timeout) {
+				ret = -ENODEV;
+				cptpf->is_eng_caps_discovered = false;
+				dev_warn(&pdev->dev, "Timeout on CPT load_fvc completion poll\n");
+				goto error_no_response;
+			}
+		}
 
 		cptpf->eng_caps[etype].u = be64_to_cpup(rptr);
 	}
-	dma_unmap_single(&pdev->dev, rptr_baddr, len, DMA_BIDIRECTIONAL);
 	cptpf->is_eng_caps_discovered = true;
 
+error_no_response:
+	dma_unmap_single(&pdev->dev, rptr_baddr, len, DMA_BIDIRECTIONAL);
 free_result:
 	kfree(result);
 lf_cleanup:
diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
index fda5f699ff57..65b52c692add 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -297,6 +297,18 @@ static char *uof_get_name(struct adf_accel_dev *accel_dev, u32 obj_num)
 	return NULL;
 }
 
+static u16 get_ring_to_svc_map(struct adf_accel_dev *accel_dev)
+{
+	switch (get_service_enabled(accel_dev)) {
+	case SVC_CY:
+		return ADF_GEN4_DEFAULT_RING_TO_SRV_MAP;
+	case SVC_DC:
+		return ADF_GEN4_DEFAULT_RING_TO_SRV_MAP_DC;
+	}
+
+	return 0;
+}
+
 static u32 uof_get_ae_mask(struct adf_accel_dev *accel_dev, u32 obj_num)
 {
 	switch (get_service_enabled(accel_dev)) {
@@ -353,6 +365,7 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data)
 	hw_data->uof_get_ae_mask = uof_get_ae_mask;
 	hw_data->set_msix_rttable = set_msix_default_rttable;
 	hw_data->set_ssm_wdtimer = adf_gen4_set_ssm_wdtimer;
+	hw_data->get_ring_to_svc_map = get_ring_to_svc_map;
 	hw_data->disable_iov = adf_disable_sriov;
 	hw_data->ring_pair_reset = adf_gen4_ring_pair_reset;
 	hw_data->enable_pm = adf_gen4_enable_pm;
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index ad01d99e6e2b..7993d0f82dea 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -176,6 +176,7 @@ struct adf_hw_device_data {
 	void (*get_arb_info)(struct arb_info *arb_csrs_info);
 	void (*get_admin_info)(struct admin_info *admin_csrs_info);
 	enum dev_sku_info (*get_sku)(struct adf_hw_device_data *self);
+	u16 (*get_ring_to_svc_map)(struct adf_accel_dev *accel_dev);
 	int (*alloc_irq)(struct adf_accel_dev *accel_dev);
 	void (*free_irq)(struct adf_accel_dev *accel_dev);
 	void (*enable_error_correction)(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h
index 4fb4b3df5a18..5e653ec755e6 100644
--- a/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h
+++ b/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h
@@ -95,6 +95,12 @@ do { \
 		   ADF_RING_BUNDLE_SIZE * (bank) + \
 		   ADF_RING_CSR_RING_SRV_ARB_EN, (value))
 
+#define ADF_GEN4_DEFAULT_RING_TO_SRV_MAP_DC \
+	(COMP << ADF_CFG_SERV_RING_PAIR_0_SHIFT | \
+	 COMP << ADF_CFG_SERV_RING_PAIR_1_SHIFT | \
+	 COMP << ADF_CFG_SERV_RING_PAIR_2_SHIFT | \
+	 COMP << ADF_CFG_SERV_RING_PAIR_3_SHIFT)
+
 /* Default ring mapping */
 #define ADF_GEN4_DEFAULT_RING_TO_SRV_MAP \
 	(ASYM << ADF_CFG_SERV_RING_PAIR_0_SHIFT | \
diff --git a/drivers/crypto/qat/qat_common/adf_init.c b/drivers/crypto/qat/qat_common/adf_init.c
index 2e3481270c4b..49f07584f8c9 100644
--- a/drivers/crypto/qat/qat_common/adf_init.c
+++ b/drivers/crypto/qat/qat_common/adf_init.c
@@ -95,6 +95,9 @@ int adf_dev_init(struct adf_accel_dev *accel_dev)
 		return -EFAULT;
 	}
 
+	if (hw_data->get_ring_to_svc_map)
+		hw_data->ring_to_svc_map = hw_data->get_ring_to_svc_map(accel_dev);
+
 	if (adf_ae_init(accel_dev)) {
 		dev_err(&GET_DEV(accel_dev),
 			"Failed to initialise Acceleration Engine\n");
diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index d69672ccacc4..8d057cea09d5 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/devfreq.h>
+#include <linux/kstrtox.h>
 #include <linux/pm.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
@@ -39,10 +40,13 @@ static ssize_t set_freq_store(struct device *dev, struct device_attribute *attr,
 	unsigned long wanted;
 	int err = 0;
 
+	err = kstrtoul(buf, 0, &wanted);
+	if (err)
+		return err;
+
 	mutex_lock(&devfreq->lock);
 	data = devfreq->governor_data;
 
-	sscanf(buf, "%lu", &wanted);
 	data->user_frequency = wanted;
 	data->valid = true;
 	err = update_devfreq(devfreq);
diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 7abcd7f2848e..34a906e4b1ff 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -745,7 +745,7 @@ static void stm32_dma_handle_chan_done(struct stm32_dma_chan *chan, u32 scr)
 		/* cyclic while CIRC/DBM disable => post resume reconfiguration needed */
 		if (!(scr & (STM32_DMA_SCR_CIRC | STM32_DMA_SCR_DBM)))
 			stm32_dma_post_resume_reconfigure(chan);
-		else if (scr & STM32_DMA_SCR_DBM)
+		else if (scr & STM32_DMA_SCR_DBM && chan->desc->num_sgs > 2)
 			stm32_dma_configure_next_sg(chan);
 	} else {
 		chan->busy = false;
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index e7c18bb61f81..c02ad4f984ad 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -333,20 +333,26 @@ struct synps_edac_priv {
 #endif
 };
 
+enum synps_platform_type {
+	ZYNQ,
+	ZYNQMP,
+	SYNPS,
+};
+
 /**
  * struct synps_platform_data -  synps platform data structure.
+ * @platform:		Identifies the target hardware platform
  * @get_error_info:	Get EDAC error info.
  * @get_mtype:		Get mtype.
  * @get_dtype:		Get dtype.
- * @get_ecc_state:	Get ECC state.
  * @get_mem_info:	Get EDAC memory info
  * @quirks:		To differentiate IPs.
  */
 struct synps_platform_data {
+	enum synps_platform_type platform;
 	int (*get_error_info)(struct synps_edac_priv *priv);
 	enum mem_type (*get_mtype)(const void __iomem *base);
 	enum dev_type (*get_dtype)(const void __iomem *base);
-	bool (*get_ecc_state)(void __iomem *base);
 #ifdef CONFIG_EDAC_DEBUG
 	u64 (*get_mem_info)(struct synps_edac_priv *priv);
 #endif
@@ -721,51 +727,38 @@ static enum dev_type zynqmp_get_dtype(const void __iomem *base)
 	return dt;
 }
 
-/**
- * zynq_get_ecc_state - Return the controller ECC enable/disable status.
- * @base:	DDR memory controller base address.
- *
- * Get the ECC enable/disable status of the controller.
- *
- * Return: true if enabled, otherwise false.
- */
-static bool zynq_get_ecc_state(void __iomem *base)
+static bool get_ecc_state(struct synps_edac_priv *priv)
 {
+	u32 ecctype, clearval;
 	enum dev_type dt;
-	u32 ecctype;
-
-	dt = zynq_get_dtype(base);
-	if (dt == DEV_UNKNOWN)
-		return false;
 
-	ecctype = readl(base + SCRUB_OFST) & SCRUB_MODE_MASK;
-	if ((ecctype == SCRUB_MODE_SECDED) && (dt == DEV_X2))
-		return true;
-
-	return false;
-}
-
-/**
- * zynqmp_get_ecc_state - Return the controller ECC enable/disable status.
- * @base:	DDR memory controller base address.
- *
- * Get the ECC enable/disable status for the controller.
- *
- * Return: a ECC status boolean i.e true/false - enabled/disabled.
- */
-static bool zynqmp_get_ecc_state(void __iomem *base)
-{
-	enum dev_type dt;
-	u32 ecctype;
-
-	dt = zynqmp_get_dtype(base);
-	if (dt == DEV_UNKNOWN)
-		return false;
-
-	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
-	if ((ecctype == SCRUB_MODE_SECDED) &&
-	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
-		return true;
+	if (priv->p_data->platform == ZYNQ) {
+		dt = zynq_get_dtype(priv->baseaddr);
+		if (dt == DEV_UNKNOWN)
+			return false;
+
+		ecctype = readl(priv->baseaddr + SCRUB_OFST) & SCRUB_MODE_MASK;
+		if (ecctype == SCRUB_MODE_SECDED && dt == DEV_X2) {
+			clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_UE_ERR;
+			writel(clearval, priv->baseaddr + ECC_CTRL_OFST);
+			writel(0x0, priv->baseaddr + ECC_CTRL_OFST);
+			return true;
+		}
+	} else {
+		dt = zynqmp_get_dtype(priv->baseaddr);
+		if (dt == DEV_UNKNOWN)
+			return false;
+
+		ecctype = readl(priv->baseaddr + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
+		if (ecctype == SCRUB_MODE_SECDED &&
+		    (dt == DEV_X2 || dt == DEV_X4 || dt == DEV_X8)) {
+			clearval = readl(priv->baseaddr + ECC_CLR_OFST) |
+			ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT |
+			ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+			writel(clearval, priv->baseaddr + ECC_CLR_OFST);
+			return true;
+		}
+	}
 
 	return false;
 }
@@ -935,18 +928,18 @@ static int setup_irq(struct mem_ctl_info *mci,
 }
 
 static const struct synps_platform_data zynq_edac_def = {
+	.platform = ZYNQ,
 	.get_error_info	= zynq_get_error_info,
 	.get_mtype	= zynq_get_mtype,
 	.get_dtype	= zynq_get_dtype,
-	.get_ecc_state	= zynq_get_ecc_state,
 	.quirks		= 0,
 };
 
 static const struct synps_platform_data zynqmp_edac_def = {
+	.platform = ZYNQMP,
 	.get_error_info	= zynqmp_get_error_info,
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
-	.get_ecc_state	= zynqmp_get_ecc_state,
 #ifdef CONFIG_EDAC_DEBUG
 	.get_mem_info	= zynqmp_get_mem_info,
 #endif
@@ -958,10 +951,10 @@ static const struct synps_platform_data zynqmp_edac_def = {
 };
 
 static const struct synps_platform_data synopsys_edac_def = {
+	.platform = SYNPS,
 	.get_error_info	= zynqmp_get_error_info,
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
-	.get_ecc_state	= zynqmp_get_ecc_state,
 	.quirks         = (DDR_ECC_INTR_SUPPORT | DDR_ECC_INTR_SELF_CLEAR
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
@@ -1393,10 +1386,6 @@ static int mc_probe(struct platform_device *pdev)
 	if (!p_data)
 		return -ENODEV;
 
-	if (!p_data->get_ecc_state(baseaddr)) {
-		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
-		return -ENXIO;
-	}
 
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
 	layers[0].size = SYNPS_EDAC_NR_CSROWS;
@@ -1416,6 +1405,12 @@ static int mc_probe(struct platform_device *pdev)
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
 	priv->p_data = p_data;
+	if (!get_ecc_state(priv)) {
+		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
+		rc = -ENODEV;
+		goto free_edac_mc;
+	}
+
 	spin_lock_init(&priv->reglock);
 
 	mc_init(mci, pdev);
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 426aa34c6a0d..77114deda11a 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -405,12 +405,12 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 		}
 	}
 
-	priv->dma_nelms =
-	    dma_map_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
-	if (priv->dma_nelms == 0) {
+	err = dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
+	if (err) {
 		dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
-		return -ENOMEM;
+		return err;
 	}
+	priv->dma_nelms = sgt->nents;
 
 	/* enable clock */
 	err = clk_enable(priv->clk);
@@ -478,7 +478,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 	clk_disable(priv->clk);
 
 out_free:
-	dma_unmap_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
+	dma_unmap_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
 	return err;
 }
 
diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
index 77a41151c921..b306722ee8b2 100644
--- a/drivers/gpio/gpio-mlxbf2.c
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -374,7 +374,7 @@ mlxbf2_gpio_probe(struct platform_device *pdev)
 	gc->ngpio = npins;
 	gc->owner = THIS_MODULE;
 
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	if (irq >= 0) {
 		gs->irq_chip.name = name;
 		gs->irq_chip.irq_set_type = mlxbf2_gpio_irq_set_type;
diff --git a/drivers/gpio/gpio-tps65912.c b/drivers/gpio/gpio-tps65912.c
index fab771cb6a87..bac757c191c2 100644
--- a/drivers/gpio/gpio-tps65912.c
+++ b/drivers/gpio/gpio-tps65912.c
@@ -49,10 +49,13 @@ static int tps65912_gpio_direction_output(struct gpio_chip *gc,
 					  unsigned offset, int value)
 {
 	struct tps65912_gpio *gpio = gpiochip_get_data(gc);
+	int ret;
 
 	/* Set the initial value */
-	regmap_update_bits(gpio->tps->regmap, TPS65912_GPIO1 + offset,
-			   GPIO_SET_MASK, value ? GPIO_SET_MASK : 0);
+	ret = regmap_update_bits(gpio->tps->regmap, TPS65912_GPIO1 + offset,
+				 GPIO_SET_MASK, value ? GPIO_SET_MASK : 0);
+	if (ret)
+		return ret;
 
 	return regmap_update_bits(gpio->tps->regmap, TPS65912_GPIO1 + offset,
 				  GPIO_CFG_MASK, GPIO_CFG_MASK);
diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index fcc5e8c08973..1d0eb49eae3b 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -539,7 +539,6 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
 
 static int virtio_gpio_probe(struct virtio_device *vdev)
 {
-	struct virtio_gpio_config config;
 	struct device *dev = &vdev->dev;
 	struct virtio_gpio *vgpio;
 	u32 gpio_names_size;
@@ -551,9 +550,11 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 		return -ENOMEM;
 
 	/* Read configuration */
-	virtio_cread_bytes(vdev, 0, &config, sizeof(config));
-	gpio_names_size = le32_to_cpu(config.gpio_names_size);
-	ngpio = le16_to_cpu(config.ngpio);
+	gpio_names_size =
+		virtio_cread32(vdev, offsetof(struct virtio_gpio_config,
+					      gpio_names_size));
+	ngpio =  virtio_cread16(vdev, offsetof(struct virtio_gpio_config,
+					       ngpio));
 	if (!ngpio) {
 		dev_err(dev, "Number of GPIOs can't be zero\n");
 		return -EINVAL;
diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
index 97e6caedf1f3..c00968ce7a56 100644
--- a/drivers/gpio/gpio-wcd934x.c
+++ b/drivers/gpio/gpio-wcd934x.c
@@ -45,9 +45,12 @@ static int wcd_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
 				     int val)
 {
 	struct wcd_gpio_data *data = gpiochip_get_data(chip);
+	int ret;
 
-	regmap_update_bits(data->map, WCD_REG_DIR_CTL_OFFSET,
-			   WCD_PIN_MASK(pin), WCD_PIN_MASK(pin));
+	ret = regmap_update_bits(data->map, WCD_REG_DIR_CTL_OFFSET,
+				 WCD_PIN_MASK(pin), WCD_PIN_MASK(pin));
+	if (ret)
+		return ret;
 
 	return regmap_update_bits(data->map, WCD_REG_VAL_CTL_OFFSET,
 				  WCD_PIN_MASK(pin),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index c6d4d41c4393..35e635c833f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -93,8 +93,8 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	r = amdgpu_vm_bo_map(adev, *bo_va, csa_addr, 0, size,
-			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
-			     AMDGPU_PTE_EXECUTABLE);
+			     AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
+			     AMDGPU_VM_PAGE_EXECUTABLE);
 
 	if (r) {
 		DRM_ERROR("failed to do bo_map on static CSA, err=%d\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 16be61abd998..f8305afa59c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2024,13 +2024,11 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
  */
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 {
-	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
-					DMA_RESV_USAGE_BOOKKEEP,
-					true, timeout);
+	timeout = drm_sched_entity_flush(&vm->immediate, timeout);
 	if (timeout <= 0)
 		return timeout;
 
-	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
+	return drm_sched_entity_flush(&vm->delayed, timeout);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 6bdf2ef0298d..8b49ff137c92 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -36,40 +36,47 @@
 
 static const char *mmhub_client_ids_v3_0_1[][2] = {
 	[0][0] = "VMC",
+	[1][0] = "ISPXT",
+	[2][0] = "ISPIXT",
 	[4][0] = "DCEDMC",
 	[5][0] = "DCEVGA",
 	[6][0] = "MP0",
 	[7][0] = "MP1",
-	[8][0] = "MPIO",
-	[16][0] = "HDP",
-	[17][0] = "LSDMA",
-	[18][0] = "JPEG",
-	[19][0] = "VCNU0",
-	[21][0] = "VSCH",
-	[22][0] = "VCNU1",
-	[23][0] = "VCN1",
-	[32+20][0] = "VCN0",
-	[2][1] = "DBGUNBIO",
+	[8][0] = "MPM",
+	[12][0] = "ISPTNR",
+	[14][0] = "ISPCRD0",
+	[15][0] = "ISPCRD1",
+	[16][0] = "ISPCRD2",
+	[22][0] = "HDP",
+	[23][0] = "LSDMA",
+	[24][0] = "JPEG",
+	[27][0] = "VSCH",
+	[28][0] = "VCNU",
+	[29][0] = "VCN",
+	[1][1] = "ISPXT",
+	[2][1] = "ISPIXT",
 	[3][1] = "DCEDWB",
 	[4][1] = "DCEDMC",
 	[5][1] = "DCEVGA",
 	[6][1] = "MP0",
 	[7][1] = "MP1",
-	[8][1] = "MPIO",
-	[10][1] = "DBGU0",
-	[11][1] = "DBGU1",
-	[12][1] = "DBGU2",
-	[13][1] = "DBGU3",
-	[14][1] = "XDP",
-	[15][1] = "OSSSYS",
-	[16][1] = "HDP",
-	[17][1] = "LSDMA",
-	[18][1] = "JPEG",
-	[19][1] = "VCNU0",
-	[20][1] = "VCN0",
-	[21][1] = "VSCH",
-	[22][1] = "VCNU1",
-	[23][1] = "VCN1",
+	[8][1] = "MPM",
+	[10][1] = "ISPMWR0",
+	[11][1] = "ISPMWR1",
+	[12][1] = "ISPTNR",
+	[13][1] = "ISPSWR",
+	[14][1] = "ISPCWR0",
+	[15][1] = "ISPCWR1",
+	[16][1] = "ISPCWR2",
+	[17][1] = "ISPCWR3",
+	[18][1] = "XDP",
+	[21][1] = "OSSSYS",
+	[22][1] = "HDP",
+	[23][1] = "LSDMA",
+	[24][1] = "JPEG",
+	[27][1] = "VSCH",
+	[28][1] = "VCNU",
+	[29][1] = "VCN",
 };
 
 static uint32_t mmhub_v3_0_1_get_invalidate_req(unsigned int vmid,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index aee2212e52f6..33aa23450b3f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -78,8 +78,8 @@ static int kfd_init(void)
 static void kfd_exit(void)
 {
 	kfd_cleanup_processes();
-	kfd_debugfs_fini();
 	kfd_process_destroy_wq();
+	kfd_debugfs_fini();
 	kfd_procfs_shutdown();
 	kfd_topology_shutdown();
 	kfd_chardev_exit();
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 64f626cc7913..39151212b8a7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4638,7 +4638,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm)
 {
-	drm_atomic_private_obj_fini(&dm->atomic_obj);
+	if (dm->atomic_obj.state)
+		drm_atomic_private_obj_fini(&dm->atomic_obj);
 }
 
 /******************************************************************************
@@ -6619,6 +6620,9 @@ amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
 	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(conn);
 	int ret;
 
+	if (WARN_ON(unlikely(!old_con_state || !new_con_state)))
+		return -EINVAL;
+
 	trace_amdgpu_dm_connector_atomic_check(new_con_state);
 
 	if (conn->connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 818a529cacc3..12a54fabd80e 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -993,7 +993,7 @@ static enum bp_result set_pixel_clock_v3(
 	allocation.sPCLKInput.usFbDiv =
 			cpu_to_le16((uint16_t)bp_params->feedback_divider);
 	allocation.sPCLKInput.ucFracFbDiv =
-			(uint8_t)bp_params->fractional_feedback_divider;
+			(uint8_t)(bp_params->fractional_feedback_divider / 100000);
 	allocation.sPCLKInput.ucPostDiv =
 			(uint8_t)bp_params->pixel_clock_post_divider;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index f276abb63bcd..10d25b894f47 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -158,7 +158,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			return NULL;
 		}
 		dce60_clk_mgr_construct(ctx, clk_mgr);
-		dce_clk_mgr_construct(ctx, clk_mgr);
 		return &clk_mgr->base;
 	}
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 26feefbb8990..b268c367c27c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -386,8 +386,6 @@ static void dce_pplib_apply_display_requirements(
 {
 	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
 
-	pp_display_cfg->avail_mclk_switch_time_us = dce110_get_min_vblank_time_us(context);
-
 	dce110_fill_display_configs(context, pp_display_cfg);
 
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
index 78df96882d6e..fb2f154f4fda 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -120,9 +120,15 @@ void dce110_fill_display_configs(
 	const struct dc_state *context,
 	struct dm_pp_display_configuration *pp_display_cfg)
 {
+	struct dc *dc = context->clk_mgr->ctx->dc;
 	int j;
 	int num_cfgs = 0;
 
+	pp_display_cfg->avail_mclk_switch_time_us = dce110_get_min_vblank_time_us(context);
+	pp_display_cfg->disp_clk_khz = dc->clk_mgr->clks.dispclk_khz;
+	pp_display_cfg->avail_mclk_switch_time_in_disp_active_us = 0;
+	pp_display_cfg->crtc_index = dc->res_pool->res_cap->num_timing_generator;
+
 	for (j = 0; j < context->stream_count; j++) {
 		int k;
 
@@ -164,6 +170,23 @@ void dce110_fill_display_configs(
 		cfg->v_refresh /= stream->timing.h_total;
 		cfg->v_refresh = (cfg->v_refresh + stream->timing.v_total / 2)
 							/ stream->timing.v_total;
+
+		/* Find first CRTC index and calculate its line time.
+		 * This is necessary for DPM on SI GPUs.
+		 */
+		if (cfg->pipe_idx < pp_display_cfg->crtc_index) {
+			const struct dc_crtc_timing *timing =
+				&context->streams[0]->timing;
+
+			pp_display_cfg->crtc_index = cfg->pipe_idx;
+			pp_display_cfg->line_time_in_us =
+				timing->h_total * 10000 / timing->pix_clk_100hz;
+		}
+	}
+
+	if (!num_cfgs) {
+		pp_display_cfg->crtc_index = 0;
+		pp_display_cfg->line_time_in_us = 0;
 	}
 
 	pp_display_cfg->display_count = num_cfgs;
@@ -223,25 +246,8 @@ void dce11_pplib_apply_display_requirements(
 	pp_display_cfg->min_engine_clock_deep_sleep_khz
 			= context->bw_ctx.bw.dce.sclk_deep_sleep_khz;
 
-	pp_display_cfg->avail_mclk_switch_time_us =
-						dce110_get_min_vblank_time_us(context);
-	/* TODO: dce11.2*/
-	pp_display_cfg->avail_mclk_switch_time_in_disp_active_us = 0;
-
-	pp_display_cfg->disp_clk_khz = dc->clk_mgr->clks.dispclk_khz;
-
 	dce110_fill_display_configs(context, pp_display_cfg);
 
-	/* TODO: is this still applicable?*/
-	if (pp_display_cfg->display_count == 1) {
-		const struct dc_crtc_timing *timing =
-			&context->streams[0]->timing;
-
-		pp_display_cfg->crtc_index =
-			pp_display_cfg->disp_configs[0].pipe_idx;
-		pp_display_cfg->line_time_in_us = timing->h_total * 10000 / timing->pix_clk_100hz;
-	}
-
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
 		dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
index 0267644717b2..ffd0f4a76310 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
@@ -83,22 +83,13 @@ static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
 static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	int dprefclk_wdivider;
-	int dp_ref_clk_khz;
-	int target_div;
+	struct dc_context *ctx = clk_mgr_base->ctx;
+	int dp_ref_clk_khz = 0;
 
-	/* DCE6 has no DPREFCLK_CNTL to read DP Reference Clock source */
-
-	/* Read the mmDENTIST_DISPCLK_CNTL to get the currently
-	 * programmed DID DENTIST_DPREFCLK_WDIVIDER*/
-	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DPREFCLK_WDIVIDER, &dprefclk_wdivider);
-
-	/* Convert DENTIST_DPREFCLK_WDIVIDERto actual divider*/
-	target_div = dentist_get_divider_from_did(dprefclk_wdivider);
-
-	/* Calculate the current DFS clock, in kHz.*/
-	dp_ref_clk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
-		* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+	if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
+		dp_ref_clk_khz = ctx->dc_bios->fw_info.default_display_engine_pll_frequency;
+	else
+		dp_ref_clk_khz = clk_mgr_base->clks.dispclk_khz;
 
 	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
 }
@@ -109,8 +100,6 @@ static void dce60_pplib_apply_display_requirements(
 {
 	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
 
-	pp_display_cfg->avail_mclk_switch_time_us = dce110_get_min_vblank_time_us(context);
-
 	dce110_fill_display_configs(context, pp_display_cfg);
 
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
@@ -123,11 +112,9 @@ static void dce60_update_clocks(struct clk_mgr *clk_mgr_base,
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dm_pp_power_level_change_request level_change_req;
-	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
-
-	/*TODO: W/A for dal3 linux, investigate why this works */
-	if (!clk_mgr_dce->dfs_bypass_active)
-		patched_disp_clk = patched_disp_clk * 115 / 100;
+	const int max_disp_clk =
+		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+	int patched_disp_clk = min(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
 
 	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
 	/* get max clock state from PPLIB */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 81b1ab55338a..d252d10c8134 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -164,14 +164,13 @@ static void dcn20_setup_gsl_group_as_lock(
 	}
 
 	/* at this point we want to program whether it's to enable or disable */
-	if (pipe_ctx->stream_res.tg->funcs->set_gsl != NULL &&
-		pipe_ctx->stream_res.tg->funcs->set_gsl_source_select != NULL) {
+	if (pipe_ctx->stream_res.tg->funcs->set_gsl != NULL) {
 		pipe_ctx->stream_res.tg->funcs->set_gsl(
 			pipe_ctx->stream_res.tg,
 			&gsl);
-
-		pipe_ctx->stream_res.tg->funcs->set_gsl_source_select(
-			pipe_ctx->stream_res.tg, group_idx,	enable ? 4 : 0);
+		if (pipe_ctx->stream_res.tg->funcs->set_gsl_source_select != NULL)
+			pipe_ctx->stream_res.tg->funcs->set_gsl_source_select(
+				pipe_ctx->stream_res.tg, group_idx, enable ? 4 : 0);
 	} else
 		BREAK_TO_DEBUGGER();
 }
@@ -758,7 +757,7 @@ enum dc_status dcn20_enable_stream_timing(
 		return DC_ERROR_UNEXPECTED;
 	}
 
-	hws->funcs.wait_for_blank_complete(pipe_ctx->stream_res.opp);
+	fsleep(stream->timing.v_total * (stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz));
 
 	params.vertical_total_min = stream->adjust.v_total_min;
 	params.vertical_total_max = stream->adjust.v_total_max;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 7f8f127e7722..ab6964ca1c2b 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -260,6 +260,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp)
 		return MOD_HDCP_STATUS_FAILURE;
 	}
 
+	if (!display)
+		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
+
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 
 	mutex_lock(&psp->hdcp_context.mutex);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 537285f255ab..3d7f34a55180 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1738,6 +1738,12 @@ static int smu_resume(void *handle)
 
 	adev->pm.dpm_enabled = true;
 
+	if (smu->current_power_limit) {
+		ret = smu_set_power_limit(smu, smu->current_power_limit);
+		if (ret && ret != -EOPNOTSUPP)
+			return ret;
+	}
+
 	dev_info(adev->dev, "SMU is resumed successfully!\n");
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index c9c0aa6376e3..e2fa0ee0dc92 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -681,7 +681,6 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 {
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_t metrics;
-	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	bool cur_value_match_level = false;
@@ -697,31 +696,25 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
-		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
-			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
-			(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
-			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
-			(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
-		}
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+		size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
+		(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
+		size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
+		(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
 		break;
 	case SMU_OD_CCLK:
-		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size += sysfs_emit_at(buf, size, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
-			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
-			(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
-			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
-			(smu->cpu_actual_soft_max_freq > 0) ? smu->cpu_actual_soft_max_freq : smu->cpu_default_soft_max_freq);
-		}
+		size += sysfs_emit_at(buf, size, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
+		size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
+		(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
+		size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
+		(smu->cpu_actual_soft_max_freq > 0) ? smu->cpu_actual_soft_max_freq : smu->cpu_default_soft_max_freq);
 		break;
 	case SMU_OD_RANGE:
-		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
-			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
-				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
-			size += sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n",
-				smu->cpu_default_soft_min_freq, smu->cpu_default_soft_max_freq);
-		}
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+			smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
+		size += sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n",
+			smu->cpu_default_soft_min_freq, smu->cpu_default_soft_max_freq);
 		break;
 	case SMU_SOCCLK:
 		/* the level 3 ~ 6 of socclk use the same frequency for vangogh */
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e839981c7b2f..ecb30e17d50c 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -663,7 +663,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	 * monitor doesn't power down exactly after the throw away read.
 	 */
 	if (!aux->is_remote) {
-		ret = drm_dp_dpcd_probe(aux, DP_DPCD_REV);
+		ret = drm_dp_dpcd_probe(aux, DP_LANE0_1_STATUS);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index fe4269c5aa0a..20c2af66ee53 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -269,12 +269,12 @@ static int hibmc_load(struct drm_device *dev)
 
 	ret = hibmc_hw_init(priv);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = drmm_vram_helper_init(dev, pci_resource_start(pdev, 0), priv->fb_size);
 	if (ret) {
 		drm_err(dev, "Error initializing VRAM MM; %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = hibmc_kms_init(priv);
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 1dee0d18abbb..7116c2aac4cb 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -874,7 +874,8 @@ void msm_gem_describe(struct drm_gem_object *obj, struct seq_file *m,
 	uint64_t off = drm_vma_node_start(&obj->vma_node);
 	const char *madv;
 
-	msm_gem_lock(obj);
+	if (!msm_gem_trylock(obj))
+		return;
 
 	stats->all.count++;
 	stats->all.size += obj->size;
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index c4844cf3a585..4c8e0a022c24 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -185,6 +185,12 @@ msm_gem_lock(struct drm_gem_object *obj)
 	dma_resv_lock(obj->resv, NULL);
 }
 
+static inline bool __must_check
+msm_gem_trylock(struct drm_gem_object *obj)
+{
+	return dma_resv_trylock(obj->resv);
+}
+
 static inline int
 msm_gem_lock_interruptible(struct drm_gem_object *obj)
 {
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 763b80633523..2634a555d275 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -327,17 +327,6 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity)
 }
 EXPORT_SYMBOL(drm_sched_entity_destroy);
 
-/* drm_sched_entity_clear_dep - callback to clear the entities dependency */
-static void drm_sched_entity_clear_dep(struct dma_fence *f,
-				       struct dma_fence_cb *cb)
-{
-	struct drm_sched_entity *entity =
-		container_of(cb, struct drm_sched_entity, cb);
-
-	entity->dependency = NULL;
-	dma_fence_put(f);
-}
-
 /*
  * drm_sched_entity_clear_dep - callback to clear the entities dependency and
  * wake up scheduler
@@ -348,7 +337,8 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
 	struct drm_sched_entity *entity =
 		container_of(cb, struct drm_sched_entity, cb);
 
-	drm_sched_entity_clear_dep(f, cb);
+	entity->dependency = NULL;
+	dma_fence_put(f);
 	drm_sched_wakeup(entity->rq->sched);
 }
 
@@ -401,13 +391,6 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
 		fence = dma_fence_get(&s_fence->scheduled);
 		dma_fence_put(entity->dependency);
 		entity->dependency = fence;
-		if (!dma_fence_add_callback(fence, &entity->cb,
-					    drm_sched_entity_clear_dep))
-			return true;
-
-		/* Ignore it when it is already scheduled */
-		dma_fence_put(fence);
-		return false;
 	}
 
 	if (!dma_fence_add_callback(entity->dependency, &entity->cb,
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 393b97b4a991..a223208b83e0 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -592,7 +592,6 @@ void ttm_pool_fini(struct ttm_pool *pool)
 	synchronize_shrinkers();
 }
 
-/* As long as pages are available make sure to release at least one */
 static unsigned long ttm_pool_shrinker_scan(struct shrinker *shrink,
 					    struct shrink_control *sc)
 {
@@ -600,9 +599,12 @@ static unsigned long ttm_pool_shrinker_scan(struct shrinker *shrink,
 
 	do
 		num_freed += ttm_pool_shrink();
-	while (!num_freed && atomic_long_read(&allocated_pages));
+	while (num_freed < sc->nr_to_scan &&
+	       atomic_long_read(&allocated_pages));
 
-	return num_freed;
+	sc->nr_scanned = num_freed;
+
+	return num_freed ?: SHRINK_STOP;
 }
 
 /* Return the number of pages available or SHRINK_EMPTY if we have none */
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 3287032a2f8e..ad3c398fc278 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -437,6 +437,9 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 	}
 	spin_unlock(&bdev->lru_lock);
 
+	if (ret && ret != -ENOENT)
+		return ret;
+
 	spin_lock(&man->move_lock);
 	fence = dma_fence_get(man->move);
 	spin_unlock(&man->move_lock);
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 746b2abfc8fd..76b76b67fa86 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -824,10 +824,12 @@ static int apple_probe(struct hid_device *hdev,
 		return ret;
 	}
 
-	timer_setup(&asc->battery_timer, apple_battery_timer_tick, 0);
-	mod_timer(&asc->battery_timer,
-		  jiffies + msecs_to_jiffies(APPLE_BATTERY_TIMEOUT_MS));
-	apple_fetch_battery(hdev);
+	if (quirks & APPLE_RDESC_BATTERY) {
+		timer_setup(&asc->battery_timer, apple_battery_timer_tick, 0);
+		mod_timer(&asc->battery_timer,
+			  jiffies + msecs_to_jiffies(APPLE_BATTERY_TIMEOUT_MS));
+		apple_fetch_battery(hdev);
+	}
 
 	if (quirks & APPLE_BACKLIGHT_CTL)
 		apple_backlight_init(hdev);
@@ -839,7 +841,8 @@ static void apple_remove(struct hid_device *hdev)
 {
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 
-	del_timer_sync(&asc->battery_timer);
+	if (asc->quirks & APPLE_RDESC_BATTERY)
+		del_timer_sync(&asc->battery_timer);
 
 	hid_hw_stop(hdev);
 }
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 9bb8daf7f786..4fe1e0bc2449 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -772,16 +772,30 @@ static void magicmouse_enable_mt_work(struct work_struct *work)
 		hid_err(msc->hdev, "unable to request touch data (%d)\n", ret);
 }
 
+static bool is_usb_magicmouse2(__u32 vendor, __u32 product)
+{
+	if (vendor != USB_VENDOR_ID_APPLE)
+		return false;
+	return product == USB_DEVICE_ID_APPLE_MAGICMOUSE2;
+}
+
+static bool is_usb_magictrackpad2(__u32 vendor, __u32 product)
+{
+	if (vendor != USB_VENDOR_ID_APPLE)
+		return false;
+	return product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
+	       product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC;
+}
+
 static int magicmouse_fetch_battery(struct hid_device *hdev)
 {
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
 
-	if (!hdev->battery || hdev->vendor != USB_VENDOR_ID_APPLE ||
-	    (hdev->product != USB_DEVICE_ID_APPLE_MAGICMOUSE2 &&
-	     hdev->product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 &&
-	     hdev->product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC))
+	if (!hdev->battery ||
+	    (!is_usb_magicmouse2(hdev->vendor, hdev->product) &&
+	     !is_usb_magictrackpad2(hdev->vendor, hdev->product)))
 		return -1;
 
 	report_enum = &hdev->report_enum[hdev->battery_report_type];
@@ -843,16 +857,17 @@ static int magicmouse_probe(struct hid_device *hdev,
 		return ret;
 	}
 
-	timer_setup(&msc->battery_timer, magicmouse_battery_timer_tick, 0);
-	mod_timer(&msc->battery_timer,
-		  jiffies + msecs_to_jiffies(USB_BATTERY_TIMEOUT_MS));
-	magicmouse_fetch_battery(hdev);
+	if (is_usb_magicmouse2(id->vendor, id->product) ||
+	    is_usb_magictrackpad2(id->vendor, id->product)) {
+		timer_setup(&msc->battery_timer, magicmouse_battery_timer_tick, 0);
+		mod_timer(&msc->battery_timer,
+			  jiffies + msecs_to_jiffies(USB_BATTERY_TIMEOUT_MS));
+		magicmouse_fetch_battery(hdev);
+	}
 
-	if (id->vendor == USB_VENDOR_ID_APPLE &&
-	    (id->product == USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
-	     ((id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
-	       id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) &&
-	      hdev->type != HID_TYPE_USBMOUSE)))
+	if (is_usb_magicmouse2(id->vendor, id->product) ||
+	    (is_usb_magictrackpad2(id->vendor, id->product) &&
+	     hdev->type != HID_TYPE_USBMOUSE))
 		return 0;
 
 	if (!msc->input) {
@@ -908,7 +923,10 @@ static int magicmouse_probe(struct hid_device *hdev,
 
 	return 0;
 err_stop_hw:
-	del_timer_sync(&msc->battery_timer);
+	if (is_usb_magicmouse2(id->vendor, id->product) ||
+	    is_usb_magictrackpad2(id->vendor, id->product))
+		del_timer_sync(&msc->battery_timer);
+
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -919,7 +937,9 @@ static void magicmouse_remove(struct hid_device *hdev)
 
 	if (msc) {
 		cancel_delayed_work_sync(&msc->work);
-		del_timer_sync(&msc->battery_timer);
+		if (is_usb_magicmouse2(hdev->vendor, hdev->product) ||
+		    is_usb_magictrackpad2(hdev->vendor, hdev->product))
+			del_timer_sync(&msc->battery_timer);
 	}
 
 	hid_hw_stop(hdev);
@@ -936,10 +956,8 @@ static __u8 *magicmouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	 *   0x05, 0x01,       // Usage Page (Generic Desktop)        0
 	 *   0x09, 0x02,       // Usage (Mouse)                       2
 	 */
-	if (hdev->vendor == USB_VENDOR_ID_APPLE &&
-	    (hdev->product == USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
-	     hdev->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
-	     hdev->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) &&
+	if ((is_usb_magicmouse2(hdev->vendor, hdev->product) ||
+	     is_usb_magictrackpad2(hdev->vendor, hdev->product)) &&
 	    *rsize == 83 && rdesc[46] == 0x84 && rdesc[58] == 0x85) {
 		hid_info(hdev,
 			 "fixing up magicmouse battery report descriptor\n");
diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index e42ae43f3de4..286582e99c28 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -301,6 +301,12 @@ static int emc2305_set_single_tz(struct device *dev, int idx)
 		dev_err(dev, "Failed to register cooling device %s\n", emc2305_fan_name[idx]);
 		return PTR_ERR(data->cdev_data[cdev_idx].cdev);
 	}
+
+	if (data->cdev_data[cdev_idx].cur_state > 0)
+		/* Update pwm when temperature is above trips */
+		pwm = EMC2305_PWM_STATE2DUTY(data->cdev_data[cdev_idx].cur_state,
+					     data->max_state, EMC2305_FAN_MAX);
+
 	/* Set minimal PWM speed. */
 	if (data->pwm_separate) {
 		ret = emc2305_set_pwm(dev, pwm, cdev_idx);
@@ -314,10 +320,10 @@ static int emc2305_set_single_tz(struct device *dev, int idx)
 		}
 	}
 	data->cdev_data[cdev_idx].cur_state =
-		EMC2305_PWM_DUTY2STATE(data->pwm_min[cdev_idx], data->max_state,
+		EMC2305_PWM_DUTY2STATE(pwm, data->max_state,
 				       EMC2305_FAN_MAX);
 	data->cdev_data[cdev_idx].last_hwmon_state =
-		EMC2305_PWM_DUTY2STATE(data->pwm_min[cdev_idx], data->max_state,
+		EMC2305_PWM_DUTY2STATE(pwm, data->max_state,
 				       EMC2305_FAN_MAX);
 	return 0;
 }
diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
index 74bfc21c2767..b5e44635f643 100644
--- a/drivers/hwmon/gsc-hwmon.c
+++ b/drivers/hwmon/gsc-hwmon.c
@@ -65,7 +65,7 @@ static ssize_t pwm_auto_point_temp_show(struct device *dev,
 		return ret;
 
 	ret = regs[0] | regs[1] << 8;
-	return sprintf(buf, "%d\n", ret * 10);
+	return sprintf(buf, "%d\n", ret * 100);
 }
 
 static ssize_t pwm_auto_point_temp_store(struct device *dev,
@@ -100,7 +100,7 @@ static ssize_t pwm_auto_point_pwm_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 
-	return sprintf(buf, "%d\n", 255 * (50 + (attr->index * 10)));
+	return sprintf(buf, "%d\n", 255 * (50 + (attr->index * 10)) / 100);
 }
 
 static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point1_pwm, pwm_auto_point_pwm, 0);
diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index d2499f302b50..f43067f6797e 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -370,6 +370,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	 * the device works without issues on Windows at what is expected to be
 	 * a 400KHz frequency. The root cause of the issue is not known.
 	 */
+	{ "DLL0945", 0 },
 	{ "ELAN06FA", 0 },
 	{}
 };
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 86b7b44cfca2..1906c711f38a 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -9,6 +9,7 @@
 #define I3C_INTERNALS_H
 
 #include <linux/i3c/master.h>
+#include <linux/io.h>
 
 extern struct bus_type i3c_bus_type;
 
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 18103c1e8d76..019fd9bd928d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1386,7 +1386,7 @@ static int i3c_master_retrieve_dev_info(struct i3c_dev_desc *dev)
 
 	if (dev->info.bcr & I3C_BCR_HDR_CAP) {
 		ret = i3c_master_gethdrcap_locked(master, &dev->info);
-		if (ret)
+		if (ret && ret != -ENOTSUPP)
 			return ret;
 	}
 
@@ -2413,6 +2413,8 @@ static int i3c_i2c_notifier_call(struct notifier_block *nb, unsigned long action
 	case BUS_NOTIFY_DEL_DEVICE:
 		ret = i3c_master_i2c_detach(adap, client);
 		break;
+	default:
+		ret = -EINVAL;
 	}
 	i3c_bus_maintenance_unlock(&master->bus);
 
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 967f06cd3f94..e147eaf1a3b1 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -203,6 +203,24 @@ static int ad7768_spi_reg_write(struct ad7768_state *st,
 	return spi_write(st->spi, st->data.d8, 2);
 }
 
+static int ad7768_send_sync_pulse(struct ad7768_state *st)
+{
+	/*
+	 * The datasheet specifies a minimum SYNC_IN pulse width of 1.5 × Tmclk,
+	 * where Tmclk is the MCLK period. The supported MCLK frequencies range
+	 * from 0.6 MHz to 17 MHz, which corresponds to a minimum SYNC_IN pulse
+	 * width of approximately 2.5 µs in the worst-case scenario (0.6 MHz).
+	 *
+	 * Add a delay to ensure the pulse width is always sufficient to
+	 * trigger synchronization.
+	 */
+	gpiod_set_value_cansleep(st->gpio_sync_in, 1);
+	fsleep(3);
+	gpiod_set_value_cansleep(st->gpio_sync_in, 0);
+
+	return 0;
+}
+
 static int ad7768_set_mode(struct ad7768_state *st,
 			   enum ad7768_conv_mode mode)
 {
@@ -288,10 +306,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
 		return ret;
 
 	/* A sync-in pulse is required every time the filter dec rate changes */
-	gpiod_set_value(st->gpio_sync_in, 1);
-	gpiod_set_value(st->gpio_sync_in, 0);
-
-	return 0;
+	return ad7768_send_sync_pulse(st);
 }
 
 static int ad7768_set_freq(struct ad7768_state *st,
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 533667eefe41..914274ed899e 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -378,7 +378,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits, 8);
+	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);
 	samples_buf_size += sizeof(int64_t);
 	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
 				    samples_buf_size, GFP_KERNEL);
@@ -406,7 +406,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
+static int ad_sd_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 
@@ -534,7 +534,7 @@ static bool ad_sd_validate_scan_mask(struct iio_dev *indio_dev, const unsigned l
 
 static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
 	.postenable = &ad_sd_buffer_postenable,
-	.postdisable = &ad_sd_buffer_postdisable,
+	.predisable = &ad_sd_buffer_predisable,
 	.validate_scan_mask = &ad_sd_validate_scan_mask,
 };
 
diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 52744dd98e65..98f17c29da69 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -118,6 +118,7 @@ struct bno055_sysfs_attr {
 	int len;
 	int *fusion_vals;
 	int *hw_xlate;
+	int hw_xlate_len;
 	int type;
 };
 
@@ -170,20 +171,24 @@ static int bno055_gyr_scale_vals[] = {
 	1000, 1877467, 2000, 1877467,
 };
 
+static int bno055_gyr_scale_hw_xlate[] = {0, 1, 2, 3, 4};
 static struct bno055_sysfs_attr bno055_gyr_scale = {
 	.vals = bno055_gyr_scale_vals,
 	.len = ARRAY_SIZE(bno055_gyr_scale_vals),
 	.fusion_vals = (int[]){1, 900},
-	.hw_xlate = (int[]){4, 3, 2, 1, 0},
+	.hw_xlate = bno055_gyr_scale_hw_xlate,
+	.hw_xlate_len = ARRAY_SIZE(bno055_gyr_scale_hw_xlate),
 	.type = IIO_VAL_FRACTIONAL,
 };
 
 static int bno055_gyr_lpf_vals[] = {12, 23, 32, 47, 64, 116, 230, 523};
+static int bno055_gyr_lpf_hw_xlate[] = {5, 4, 7, 3, 6, 2, 1, 0};
 static struct bno055_sysfs_attr bno055_gyr_lpf = {
 	.vals = bno055_gyr_lpf_vals,
 	.len = ARRAY_SIZE(bno055_gyr_lpf_vals),
 	.fusion_vals = (int[]){32},
-	.hw_xlate = (int[]){5, 4, 7, 3, 6, 2, 1, 0},
+	.hw_xlate = bno055_gyr_lpf_hw_xlate,
+	.hw_xlate_len = ARRAY_SIZE(bno055_gyr_lpf_hw_xlate),
 	.type = IIO_VAL_INT,
 };
 
@@ -561,7 +566,7 @@ static int bno055_get_regmask(struct bno055_priv *priv, int *val, int *val2,
 
 	idx = (hwval & mask) >> shift;
 	if (attr->hw_xlate)
-		for (i = 0; i < attr->len; i++)
+		for (i = 0; i < attr->hw_xlate_len; i++)
 			if (attr->hw_xlate[i] == idx) {
 				idx = i;
 				break;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 91f0f381082b..8926b48d7661 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -32,8 +32,12 @@ static int inv_icm42600_temp_read(struct inv_icm42600_state *st, int16_t *temp)
 		goto exit;
 
 	*temp = (int16_t)be16_to_cpup(raw);
+	/*
+	 * Temperature data is invalid if both accel and gyro are off.
+	 * Return -EBUSY in this case.
+	 */
 	if (*temp == INV_ICM42600_DATA_INVALID)
-		ret = -EINVAL;
+		ret = -EBUSY;
 
 exit:
 	mutex_unlock(&st->lock);
diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 895b0c9c6d1d..5f943705ce8d 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -573,7 +573,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 	struct {
 		__le16 chan[4];
 		s64 ts __aligned(8);
-	} scan;
+	} scan = { };
 	int data_result, ret;
 
 	mutex_lock(&data->mutex);
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index f10fa2abfe72..91147b27c3a6 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -103,8 +103,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 		ret_type = prox_state->scale_precision;
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = hid_sensor_convert_exponent(
-				prox_state->prox_attr.unit_expo);
+		*val = 0;
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -222,6 +221,11 @@ static int prox_parse_report(struct platform_device *pdev,
 	dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr.index,
 			st->prox_attr.report_id);
 
+	st->scale_precision = hid_sensor_format_scale(hsdev->usage,
+						      &st->prox_attr,
+						      &st->scale_pre_decml,
+						      &st->scale_post_decml);
+
 	return ret;
 }
 
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 4c867157aa96..d8321da5c6a7 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1740,11 +1740,12 @@ int bmp280_common_probe(struct device *dev,
 
 	/* Bring chip out of reset if there is an assigned GPIO line */
 	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod))
+		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get reset GPIO\n");
+
 	/* Deassert the signal */
-	if (gpiod) {
-		dev_info(dev, "release reset\n");
-		gpiod_set_value(gpiod, 0);
-	}
+	dev_info(dev, "release reset\n");
+	gpiod_set_value(gpiod, 0);
 
 	data->regmap = regmap;
 
diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index 5b6ea783795d..3ccc95cf645c 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -938,12 +938,18 @@ static irqreturn_t isl29501_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct isl29501_private *isl29501 = iio_priv(indio_dev);
 	const unsigned long *active_mask = indio_dev->active_scan_mask;
-	u32 buffer[4] __aligned(8) = {}; /* 1x16-bit + naturally aligned ts */
-
-	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask))
-		isl29501_register_read(isl29501, REG_DISTANCE, buffer);
+	u32 value;
+	struct {
+		u16 data;
+		aligned_s64 ts;
+	} scan = { };
+
+	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask)) {
+		isl29501_register_read(isl29501, REG_DISTANCE, &value);
+		scan.data = value;
+	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index 555a61e2f3fd..44fba61ccfe2 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -122,8 +123,15 @@ struct maxim_thermocouple_data {
 	struct spi_device *spi;
 	const struct maxim_thermocouple_chip *chip;
 	char tc_type;
-
-	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
+	/* Buffer for reading up to 2 hardware channels. */
+	struct {
+		union {
+			__be16 raw16;
+			__be32 raw32;
+			__be16 raw[2];
+		};
+		aligned_s64 timestamp;
+	} buffer __aligned(IIO_DMA_MINALIGN);
 };
 
 static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
@@ -131,18 +139,16 @@ static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
 {
 	unsigned int storage_bytes = data->chip->read_size;
 	unsigned int shift = chan->scan_type.shift + (chan->address * 8);
-	__be16 buf16;
-	__be32 buf32;
 	int ret;
 
 	switch (storage_bytes) {
 	case 2:
-		ret = spi_read(data->spi, (void *)&buf16, storage_bytes);
-		*val = be16_to_cpu(buf16);
+		ret = spi_read(data->spi, &data->buffer.raw16, storage_bytes);
+		*val = be16_to_cpu(data->buffer.raw16);
 		break;
 	case 4:
-		ret = spi_read(data->spi, (void *)&buf32, storage_bytes);
-		*val = be32_to_cpu(buf32);
+		ret = spi_read(data->spi, &data->buffer.raw32, storage_bytes);
+		*val = be32_to_cpu(data->buffer.raw32);
 		break;
 	default:
 		ret = -EINVAL;
@@ -167,9 +173,9 @@ static irqreturn_t maxim_thermocouple_trigger_handler(int irq, void *private)
 	struct maxim_thermocouple_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = spi_read(data->spi, data->buffer, data->chip->read_size);
+	ret = spi_read(data->spi, data->buffer.raw, data->chip->read_size);
 	if (!ret) {
-		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+		iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 						   iio_get_time_ns(indio_dev));
 	}
 
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 1adf20198afd..7e08ce963125 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1400,10 +1400,11 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 
 };
 
-static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
-			       struct netlink_ext_ack *extack,
-			       enum rdma_restrack_type res_type,
-			       res_fill_func_t fill_func)
+static noinline_for_stack int
+res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
+		    struct netlink_ext_ack *extack,
+		    enum rdma_restrack_type res_type,
+		    res_fill_func_t fill_func)
 {
 	const struct nldev_fill_res_entry *fe = &fill_entries[res_type];
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
@@ -2129,10 +2130,10 @@ static int nldev_stat_del_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return ret;
 }
 
-static int stat_get_doit_default_counter(struct sk_buff *skb,
-					 struct nlmsghdr *nlh,
-					 struct netlink_ext_ack *extack,
-					 struct nlattr *tb[])
+static noinline_for_stack int
+stat_get_doit_default_counter(struct sk_buff *skb, struct nlmsghdr *nlh,
+			      struct netlink_ext_ack *extack,
+			      struct nlattr *tb[])
 {
 	struct rdma_hw_stats *stats;
 	struct nlattr *table_attr;
@@ -2222,8 +2223,9 @@ static int stat_get_doit_default_counter(struct sk_buff *skb,
 	return ret;
 }
 
-static int stat_get_doit_qp(struct sk_buff *skb, struct nlmsghdr *nlh,
-			    struct netlink_ext_ack *extack, struct nlattr *tb[])
+static noinline_for_stack int
+stat_get_doit_qp(struct sk_buff *skb, struct nlmsghdr *nlh,
+		 struct netlink_ext_ack *extack, struct nlattr *tb[])
 
 {
 	static enum rdma_nl_counter_mode mode;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 203350c6e00f..4962d68bf217 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -121,6 +121,7 @@ static int __alloc_pbl(struct bnxt_qplib_res *res,
 	pbl->pg_arr = vmalloc(pages * sizeof(void *));
 	if (!pbl->pg_arr)
 		return -ENOMEM;
+	memset(pbl->pg_arr, 0, pages * sizeof(void *));
 
 	pbl->pg_map_arr = vmalloc(pages * sizeof(dma_addr_t));
 	if (!pbl->pg_map_arr) {
@@ -128,6 +129,7 @@ static int __alloc_pbl(struct bnxt_qplib_res *res,
 		pbl->pg_arr = NULL;
 		return -ENOMEM;
 	}
+	memset(pbl->pg_map_arr, 0, pages * sizeof(dma_addr_t));
 	pbl->pg_count = 0;
 	pbl->pg_size = sginfo->pgsize;
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 2edf0d882c6a..cc2b20c8b050 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -727,7 +727,9 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 		if (ret)
 			goto err_out_cmd;
 	} else {
-		init_kernel_qp(dev, qp, attrs);
+		ret = init_kernel_qp(dev, qp, attrs);
+		if (ret)
+			goto err_out_xa;
 	}
 
 	qp->attrs.max_send_sge = attrs->cap.max_send_sge;
diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 77ee77d4000f..7382b85c72a6 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -966,31 +966,35 @@ static void find_hw_thread_mask(uint hw_thread_no, cpumask_var_t hw_thread_mask,
 				struct hfi1_affinity_node_list *affinity)
 {
 	int possible, curr_cpu, i;
-	uint num_cores_per_socket = node_affinity.num_online_cpus /
+	uint num_cores_per_socket;
+
+	cpumask_copy(hw_thread_mask, &affinity->proc.mask);
+
+	if (affinity->num_core_siblings == 0)
+		return;
+
+	num_cores_per_socket = node_affinity.num_online_cpus /
 					affinity->num_core_siblings /
 						node_affinity.num_online_nodes;
 
-	cpumask_copy(hw_thread_mask, &affinity->proc.mask);
-	if (affinity->num_core_siblings > 0) {
-		/* Removing other siblings not needed for now */
-		possible = cpumask_weight(hw_thread_mask);
-		curr_cpu = cpumask_first(hw_thread_mask);
-		for (i = 0;
-		     i < num_cores_per_socket * node_affinity.num_online_nodes;
-		     i++)
-			curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
-
-		for (; i < possible; i++) {
-			cpumask_clear_cpu(curr_cpu, hw_thread_mask);
-			curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
-		}
+	/* Removing other siblings not needed for now */
+	possible = cpumask_weight(hw_thread_mask);
+	curr_cpu = cpumask_first(hw_thread_mask);
+	for (i = 0;
+	     i < num_cores_per_socket * node_affinity.num_online_nodes;
+	     i++)
+		curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
 
-		/* Identifying correct HW threads within physical cores */
-		cpumask_shift_left(hw_thread_mask, hw_thread_mask,
-				   num_cores_per_socket *
-				   node_affinity.num_online_nodes *
-				   hw_thread_no);
+	for (; i < possible; i++) {
+		cpumask_clear_cpu(curr_cpu, hw_thread_mask);
+		curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
 	}
+
+	/* Identifying correct HW threads within physical cores */
+	cpumask_shift_left(hw_thread_mask, hw_thread_mask,
+			   num_cores_per_socket *
+			   node_affinity.num_online_nodes *
+			   hw_thread_no);
 }
 
 int hfi1_get_proc_affinity(int node)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index bc78e8665551..23804270eda1 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3553,7 +3553,7 @@ static int __init parse_ivrs_acpihid(char *str)
 {
 	u32 seg = 0, bus, dev, fn;
 	char *hid, *uid, *p, *addr;
-	char acpiid[ACPIID_LEN] = {0};
+	char acpiid[ACPIID_LEN + 1] = { }; /* size with NULL terminator */
 	int i;
 
 	addr = strchr(str, '@');
@@ -3579,7 +3579,7 @@ static int __init parse_ivrs_acpihid(char *str)
 	/* We have the '@', make it the terminator to get just the acpiid */
 	*addr++ = 0;
 
-	if (strlen(str) > ACPIID_LEN + 1)
+	if (strlen(str) > ACPIID_LEN)
 		goto not_found;
 
 	if (sscanf(str, "=%s", acpiid) != 1)
diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index 28d6b39fa72d..cda62e3d3a3a 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -486,6 +486,7 @@ static int lp50xx_probe_dt(struct lp50xx *priv)
 		}
 
 		fwnode_for_each_child_node(child, led_node) {
+			int multi_index;
 			ret = fwnode_property_read_u32(led_node, "color",
 						       &color_id);
 			if (ret) {
@@ -493,8 +494,16 @@ static int lp50xx_probe_dt(struct lp50xx *priv)
 				dev_err(priv->dev, "Cannot read color\n");
 				goto child_out;
 			}
+			ret = fwnode_property_read_u32(led_node, "reg", &multi_index);
+			if (ret != 0) {
+				dev_err(priv->dev, "reg must be set\n");
+				return -EINVAL;
+			} else if (multi_index >= LP50XX_LEDS_PER_MODULE) {
+				dev_err(priv->dev, "reg %i out of range\n", multi_index);
+				return -EINVAL;
+			}
 
-			mc_led_info[num_colors].color_index = color_id;
+			mc_led_info[multi_index].color_index = color_id;
 			num_colors++;
 		}
 
diff --git a/drivers/md/dm-ps-historical-service-time.c b/drivers/md/dm-ps-historical-service-time.c
index 1d82c95d323d..d0d1f97d21b6 100644
--- a/drivers/md/dm-ps-historical-service-time.c
+++ b/drivers/md/dm-ps-historical-service-time.c
@@ -541,8 +541,10 @@ static int __init dm_hst_init(void)
 {
 	int r = dm_register_path_selector(&hst_ps);
 
-	if (r < 0)
+	if (r < 0) {
 		DMERR("register failed %d", r);
+		return r;
+	}
 
 	DMINFO("version " HST_VERSION " loaded");
 
diff --git a/drivers/md/dm-ps-queue-length.c b/drivers/md/dm-ps-queue-length.c
index 6fbec9fc242d..8e298570c8d2 100644
--- a/drivers/md/dm-ps-queue-length.c
+++ b/drivers/md/dm-ps-queue-length.c
@@ -259,8 +259,10 @@ static int __init dm_ql_init(void)
 {
 	int r = dm_register_path_selector(&ql_ps);
 
-	if (r < 0)
+	if (r < 0) {
 		DMERR("register failed %d", r);
+		return r;
+	}
 
 	DMINFO("version " QL_VERSION " loaded");
 
diff --git a/drivers/md/dm-ps-round-robin.c b/drivers/md/dm-ps-round-robin.c
index 1d07392b5ed4..22c68ca81a24 100644
--- a/drivers/md/dm-ps-round-robin.c
+++ b/drivers/md/dm-ps-round-robin.c
@@ -216,8 +216,10 @@ static int __init dm_rr_init(void)
 {
 	int r = dm_register_path_selector(&rr_ps);
 
-	if (r < 0)
+	if (r < 0) {
 		DMERR("register failed %d", r);
+		return r;
+	}
 
 	DMINFO("version " RR_VERSION " loaded");
 
diff --git a/drivers/md/dm-ps-service-time.c b/drivers/md/dm-ps-service-time.c
index eba2293be686..d1e77eefaf2b 100644
--- a/drivers/md/dm-ps-service-time.c
+++ b/drivers/md/dm-ps-service-time.c
@@ -340,8 +340,10 @@ static int __init dm_st_init(void)
 {
 	int r = dm_register_path_selector(&st_ps);
 
-	if (r < 0)
+	if (r < 0) {
 		DMERR("register failed %d", r);
+		return r;
+	}
 
 	DMINFO("version " ST_VERSION " loaded");
 
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 8b23b8bc5a03..f18e47a24454 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -863,17 +863,17 @@ static bool dm_table_supports_dax(struct dm_table *t,
 	return true;
 }
 
-static int device_is_rq_stackable(struct dm_target *ti, struct dm_dev *dev,
-				  sector_t start, sector_t len, void *data)
+static int device_is_not_rq_stackable(struct dm_target *ti, struct dm_dev *dev,
+				      sector_t start, sector_t len, void *data)
 {
 	struct block_device *bdev = dev->bdev;
 	struct request_queue *q = bdev_get_queue(bdev);
 
 	/* request-based cannot stack on partitions! */
 	if (bdev_is_partition(bdev))
-		return false;
+		return true;
 
-	return queue_is_mq(q);
+	return !queue_is_mq(q);
 }
 
 static int dm_table_determine_type(struct dm_table *t)
@@ -969,7 +969,7 @@ static int dm_table_determine_type(struct dm_table *t)
 
 	/* Non-request-stackable devices can't be used for request-based dm */
 	if (!ti->type->iterate_devices ||
-	    !ti->type->iterate_devices(ti, device_is_rq_stackable, NULL)) {
+	    ti->type->iterate_devices(ti, device_is_not_rq_stackable, NULL)) {
 		DMERR("table load rejected: including non-request-stackable devices");
 		return -EINVAL;
 	}
diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 4abe1e2f8ad8..cbcfadbdd51d 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -1062,7 +1062,7 @@ static int dmz_iterate_devices(struct dm_target *ti,
 	struct dmz_target *dmz = ti->private;
 	unsigned int zone_nr_sectors = dmz_zone_nr_sectors(dmz->metadata);
 	sector_t capacity;
-	int i, r;
+	int i, r = 0;
 
 	for (i = 0; i < dmz->nr_ddevs; i++) {
 		capacity = dmz->dev[i].capacity & ~(zone_nr_sectors - 1);
diff --git a/drivers/media/cec/usb/rainshadow/rainshadow-cec.c b/drivers/media/cec/usb/rainshadow/rainshadow-cec.c
index ee870ea1a886..6f8d6797c614 100644
--- a/drivers/media/cec/usb/rainshadow/rainshadow-cec.c
+++ b/drivers/media/cec/usb/rainshadow/rainshadow-cec.c
@@ -171,11 +171,12 @@ static irqreturn_t rain_interrupt(struct serio *serio, unsigned char data,
 {
 	struct rain *rain = serio_get_drvdata(serio);
 
+	spin_lock(&rain->buf_lock);
 	if (rain->buf_len == DATA_SIZE) {
+		spin_unlock(&rain->buf_lock);
 		dev_warn_once(rain->dev, "buffer overflow\n");
 		return IRQ_HANDLED;
 	}
-	spin_lock(&rain->buf_lock);
 	rain->buf_len++;
 	rain->buf[rain->buf_wr_idx] = data;
 	rain->buf_wr_idx = (rain->buf_wr_idx + 1) & 0xff;
diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
index d1e53de5206a..f40bc835649c 100644
--- a/drivers/media/dvb-frontends/dib7000p.c
+++ b/drivers/media/dvb-frontends/dib7000p.c
@@ -2198,6 +2198,8 @@ static int w7090p_tuner_write_serpar(struct i2c_adapter *i2c_adap, struct i2c_ms
 	struct dib7000p_state *state = i2c_get_adapdata(i2c_adap);
 	u8 n_overflow = 1;
 	u16 i = 1000;
+	if (msg[0].len < 3)
+		return -EOPNOTSUPP;
 	u16 serpar_num = msg[0].buf[0];
 
 	while (n_overflow == 1 && i) {
@@ -2217,6 +2219,8 @@ static int w7090p_tuner_read_serpar(struct i2c_adapter *i2c_adap, struct i2c_msg
 	struct dib7000p_state *state = i2c_get_adapdata(i2c_adap);
 	u8 n_overflow = 1, n_empty = 1;
 	u16 i = 1000;
+	if (msg[0].len < 1 || msg[1].len < 2)
+		return -EOPNOTSUPP;
 	u16 serpar_num = msg[0].buf[0];
 	u16 read_word;
 
@@ -2261,8 +2265,12 @@ static int dib7090p_rw_on_apb(struct i2c_adapter *i2c_adap,
 	u16 word;
 
 	if (num == 1) {		/* write */
+		if (msg[0].len < 3)
+			return -EOPNOTSUPP;
 		dib7000p_write_word(state, apb_address, ((msg[0].buf[1] << 8) | (msg[0].buf[2])));
 	} else {
+		if (msg[1].len < 2)
+			return -EOPNOTSUPP;
 		word = dib7000p_read_word(state, apb_address);
 		msg[1].buf[0] = (word >> 8) & 0xff;
 		msg[1].buf[1] = (word) & 0xff;
diff --git a/drivers/media/i2c/hi556.c b/drivers/media/i2c/hi556.c
index e422ac7609b5..850e828a9666 100644
--- a/drivers/media/i2c/hi556.c
+++ b/drivers/media/i2c/hi556.c
@@ -605,21 +605,23 @@ static int hi556_test_pattern(struct hi556 *hi556, u32 pattern)
 	int ret;
 	u32 val;
 
-	if (pattern) {
-		ret = hi556_read_reg(hi556, HI556_REG_ISP,
-				     HI556_REG_VALUE_08BIT, &val);
-		if (ret)
-			return ret;
+	ret = hi556_read_reg(hi556, HI556_REG_ISP,
+			     HI556_REG_VALUE_08BIT, &val);
+	if (ret)
+		return ret;
 
-		ret = hi556_write_reg(hi556, HI556_REG_ISP,
-				      HI556_REG_VALUE_08BIT,
-				      val | HI556_REG_ISP_TPG_EN);
-		if (ret)
-			return ret;
-	}
+	val = pattern ? (val | HI556_REG_ISP_TPG_EN) :
+		(val & ~HI556_REG_ISP_TPG_EN);
+
+	ret = hi556_write_reg(hi556, HI556_REG_ISP,
+			      HI556_REG_VALUE_08BIT, val);
+	if (ret)
+		return ret;
+
+	val = pattern ? BIT(pattern - 1) : 0;
 
 	return hi556_write_reg(hi556, HI556_REG_TEST_PATTERN,
-			       HI556_REG_VALUE_08BIT, pattern);
+			       HI556_REG_VALUE_08BIT, val);
 }
 
 static int hi556_set_ctrl(struct v4l2_ctrl *ctrl)
diff --git a/drivers/media/i2c/ov2659.c b/drivers/media/i2c/ov2659.c
index 42fc64ada08c..51b366650cc6 100644
--- a/drivers/media/i2c/ov2659.c
+++ b/drivers/media/i2c/ov2659.c
@@ -1479,14 +1479,15 @@ static int ov2659_probe(struct i2c_client *client)
 				     V4L2_CID_TEST_PATTERN,
 				     ARRAY_SIZE(ov2659_test_pattern_menu) - 1,
 				     0, 0, ov2659_test_pattern_menu);
-	ov2659->sd.ctrl_handler = &ov2659->ctrls;
 
 	if (ov2659->ctrls.error) {
 		dev_err(&client->dev, "%s: control initialization error %d\n",
 			__func__, ov2659->ctrls.error);
+		v4l2_ctrl_handler_free(&ov2659->ctrls);
 		return  ov2659->ctrls.error;
 	}
 
+	ov2659->sd.ctrl_handler = &ov2659->ctrls;
 	sd = &ov2659->sd;
 	client->flags |= I2C_CLIENT_SCCB;
 #ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index 2c8189e04a13..d13e8f19278f 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -110,7 +110,7 @@ static inline struct tc358743_state *to_state(struct v4l2_subdev *sd)
 
 /* --------------- I2C --------------- */
 
-static void i2c_rd(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
+static int i2c_rd(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
 {
 	struct tc358743_state *state = to_state(sd);
 	struct i2c_client *client = state->i2c_client;
@@ -136,6 +136,7 @@ static void i2c_rd(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
 		v4l2_err(sd, "%s: reading register 0x%x from 0x%x failed\n",
 				__func__, reg, client->addr);
 	}
+	return err != ARRAY_SIZE(msgs);
 }
 
 static void i2c_wr(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
@@ -192,15 +193,24 @@ static void i2c_wr(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
 	}
 }
 
-static noinline u32 i2c_rdreg(struct v4l2_subdev *sd, u16 reg, u32 n)
+static noinline u32 i2c_rdreg_err(struct v4l2_subdev *sd, u16 reg, u32 n,
+				  int *err)
 {
+	int error;
 	__le32 val = 0;
 
-	i2c_rd(sd, reg, (u8 __force *)&val, n);
+	error = i2c_rd(sd, reg, (u8 __force *)&val, n);
+	if (err)
+		*err = error;
 
 	return le32_to_cpu(val);
 }
 
+static inline u32 i2c_rdreg(struct v4l2_subdev *sd, u16 reg, u32 n)
+{
+	return i2c_rdreg_err(sd, reg, n, NULL);
+}
+
 static noinline void i2c_wrreg(struct v4l2_subdev *sd, u16 reg, u32 val, u32 n)
 {
 	__le32 raw = cpu_to_le32(val);
@@ -229,6 +239,13 @@ static u16 i2c_rd16(struct v4l2_subdev *sd, u16 reg)
 	return i2c_rdreg(sd, reg, 2);
 }
 
+static int i2c_rd16_err(struct v4l2_subdev *sd, u16 reg, u16 *value)
+{
+	int err;
+	*value = i2c_rdreg_err(sd, reg, 2, &err);
+	return err;
+}
+
 static void i2c_wr16(struct v4l2_subdev *sd, u16 reg, u16 val)
 {
 	i2c_wrreg(sd, reg, val, 2);
@@ -1651,12 +1668,23 @@ static int tc358743_enum_mbus_code(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static u32 tc358743_g_colorspace(u32 code)
+{
+	switch (code) {
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		return V4L2_COLORSPACE_SRGB;
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+		return V4L2_COLORSPACE_SMPTE170M;
+	default:
+		return 0;
+	}
+}
+
 static int tc358743_get_fmt(struct v4l2_subdev *sd,
 		struct v4l2_subdev_state *sd_state,
 		struct v4l2_subdev_format *format)
 {
 	struct tc358743_state *state = to_state(sd);
-	u8 vi_rep = i2c_rd8(sd, VI_REP);
 
 	if (format->pad != 0)
 		return -EINVAL;
@@ -1666,23 +1694,7 @@ static int tc358743_get_fmt(struct v4l2_subdev *sd,
 	format->format.height = state->timings.bt.height;
 	format->format.field = V4L2_FIELD_NONE;
 
-	switch (vi_rep & MASK_VOUT_COLOR_SEL) {
-	case MASK_VOUT_COLOR_RGB_FULL:
-	case MASK_VOUT_COLOR_RGB_LIMITED:
-		format->format.colorspace = V4L2_COLORSPACE_SRGB;
-		break;
-	case MASK_VOUT_COLOR_601_YCBCR_LIMITED:
-	case MASK_VOUT_COLOR_601_YCBCR_FULL:
-		format->format.colorspace = V4L2_COLORSPACE_SMPTE170M;
-		break;
-	case MASK_VOUT_COLOR_709_YCBCR_FULL:
-	case MASK_VOUT_COLOR_709_YCBCR_LIMITED:
-		format->format.colorspace = V4L2_COLORSPACE_REC709;
-		break;
-	default:
-		format->format.colorspace = 0;
-		break;
-	}
+	format->format.colorspace = tc358743_g_colorspace(format->format.code);
 
 	return 0;
 }
@@ -1696,19 +1708,14 @@ static int tc358743_set_fmt(struct v4l2_subdev *sd,
 	u32 code = format->format.code; /* is overwritten by get_fmt */
 	int ret = tc358743_get_fmt(sd, sd_state, format);
 
-	format->format.code = code;
+	if (code == MEDIA_BUS_FMT_RGB888_1X24 ||
+	    code == MEDIA_BUS_FMT_UYVY8_1X16)
+		format->format.code = code;
+	format->format.colorspace = tc358743_g_colorspace(format->format.code);
 
 	if (ret)
 		return ret;
 
-	switch (code) {
-	case MEDIA_BUS_FMT_RGB888_1X24:
-	case MEDIA_BUS_FMT_UYVY8_1X16:
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
 		return 0;
 
@@ -1932,8 +1939,19 @@ static int tc358743_probe_of(struct tc358743_state *state)
 	state->pdata.refclk_hz = clk_get_rate(refclk);
 	state->pdata.ddc5v_delay = DDC5V_DELAY_100_MS;
 	state->pdata.enable_hdcp = false;
-	/* A FIFO level of 16 should be enough for 2-lane 720p60 at 594 MHz. */
-	state->pdata.fifo_level = 16;
+	/*
+	 * Ideally the FIFO trigger level should be set based on the input and
+	 * output data rates, but the calculations required are buried in
+	 * Toshiba's register settings spreadsheet.
+	 * A value of 16 works with a 594Mbps data rate for 720p60 (using 2
+	 * lanes) and 1080p60 (using 4 lanes), but fails when the data rate
+	 * is increased, or a lower pixel clock is used that result in CSI
+	 * reading out faster than the data is arriving.
+	 *
+	 * A value of 374 works with both those modes at 594Mbps, and with most
+	 * modes on 972Mbps.
+	 */
+	state->pdata.fifo_level = 374;
 	/*
 	 * The PLL input clock is obtained by dividing refclk by pll_prd.
 	 * It must be between 6 MHz and 40 MHz, lower frequency is better.
@@ -2021,6 +2039,7 @@ static int tc358743_probe(struct i2c_client *client)
 	struct tc358743_platform_data *pdata = client->dev.platform_data;
 	struct v4l2_subdev *sd;
 	u16 irq_mask = MASK_HDMI_MSK | MASK_CSI_MSK;
+	u16 chipid;
 	int err;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -2052,7 +2071,8 @@ static int tc358743_probe(struct i2c_client *client)
 	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
 
 	/* i2c access */
-	if ((i2c_rd16(sd, CHIPID) & MASK_CHIPID) != 0) {
+	if (i2c_rd16_err(sd, CHIPID, &chipid) ||
+	    (chipid & MASK_CHIPID) != 0) {
 		v4l2_info(sd, "not a TC358743 on address 0x%x\n",
 			  client->addr << 1);
 		return -ENODEV;
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 1c0d4a69fee9..bbcce6d5c605 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1658,7 +1658,7 @@ static int camss_probe(struct platform_device *pdev)
 	ret = v4l2_device_register(camss->dev, &camss->v4l2_dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
-		goto err_genpd_cleanup;
+		goto err_media_device_cleanup;
 	}
 
 	v4l2_async_nf_init(&camss->notifier);
@@ -1710,6 +1710,8 @@ static int camss_probe(struct platform_device *pdev)
 	v4l2_device_unregister(&camss->v4l2_dev);
 	v4l2_async_nf_cleanup(&camss->notifier);
 	pm_runtime_disable(dev);
+err_media_device_cleanup:
+	media_device_cleanup(&camss->media_dev);
 err_genpd_cleanup:
 	camss_genpd_cleanup(camss);
 
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 4db7a5d1de72..ac6a753c9298 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -333,13 +333,13 @@ static int venus_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&core->work, venus_sys_error_handler);
 	init_waitqueue_head(&core->sys_err_done);
 
-	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, venus_isr_thread,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-					"venus", core);
+	ret = hfi_create(core, &venus_core_ops);
 	if (ret)
 		goto err_core_put;
 
-	ret = hfi_create(core, &venus_core_ops);
+	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, venus_isr_thread,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"venus", core);
 	if (ret)
 		goto err_core_put;
 
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 83a97288319b..8b77f2d0b264 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -28,6 +28,8 @@
 #define VIDC_PMDOMAINS_NUM_MAX		3
 #define VIDC_RESETS_NUM_MAX		2
 
+#define VENUS_MAX_FPS			240
+
 extern int venus_fw_debug;
 
 struct freq_tbl {
diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index ca6555bdc92f..652ad33cbc4b 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -189,7 +189,7 @@ int venus_helper_alloc_dpb_bufs(struct venus_inst *inst)
 	if (ret)
 		return ret;
 
-	count = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+	count = hfi_bufreq_get_count_min(&bufreq, ver);
 
 	for (i = 0; i < count; i++) {
 		buf = kzalloc(sizeof(*buf), GFP_KERNEL);
diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index d2d6719a2ba4..d71355a64c91 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -1150,14 +1150,6 @@ struct hfi_buffer_display_hold_count_actual {
 	u32 hold_count;
 };
 
-/* HFI 4XX reorder the fields, use these macros */
-#define HFI_BUFREQ_HOLD_COUNT(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX ? 0 : (bufreq)->hold_count)
-#define HFI_BUFREQ_COUNT_MIN(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX ? (bufreq)->hold_count : (bufreq)->count_min)
-#define HFI_BUFREQ_COUNT_MIN_HOST(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX ? (bufreq)->count_min : 0)
-
 struct hfi_buffer_requirements {
 	u32 type;
 	u32 size;
@@ -1169,6 +1161,59 @@ struct hfi_buffer_requirements {
 	u32 alignment;
 };
 
+/* On HFI 4XX, some of the struct members have been swapped. */
+static inline u32 hfi_bufreq_get_hold_count(struct hfi_buffer_requirements *req,
+					    u32 ver)
+{
+	if (ver == HFI_VERSION_4XX)
+		return 0;
+
+	return req->hold_count;
+};
+
+static inline u32 hfi_bufreq_get_count_min(struct hfi_buffer_requirements *req,
+					   u32 ver)
+{
+	if (ver == HFI_VERSION_4XX)
+		return req->hold_count;
+
+	return req->count_min;
+};
+
+static inline u32 hfi_bufreq_get_count_min_host(struct hfi_buffer_requirements *req,
+						u32 ver)
+{
+	if (ver == HFI_VERSION_4XX)
+		return req->count_min;
+
+	return 0;
+};
+
+static inline void hfi_bufreq_set_hold_count(struct hfi_buffer_requirements *req,
+					     u32 ver, u32 val)
+{
+	if (ver == HFI_VERSION_4XX)
+		return;
+
+	req->hold_count = val;
+};
+
+static inline void hfi_bufreq_set_count_min(struct hfi_buffer_requirements *req,
+					    u32 ver, u32 val)
+{
+	if (ver == HFI_VERSION_4XX)
+		req->hold_count = val;
+
+	req->count_min = val;
+};
+
+static inline void hfi_bufreq_set_count_min_host(struct hfi_buffer_requirements *req,
+						 u32 ver, u32 val)
+{
+	if (ver == HFI_VERSION_4XX)
+		req->count_min = val;
+};
+
 struct hfi_data_payload {
 	u32 size;
 	u8 data[1];
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index 1c5cc5a5f89a..4f522d3a74dc 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -33,8 +33,9 @@ static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
 	struct hfi_buffer_requirements *bufreq;
 	struct hfi_extradata_input_crop *crop;
 	struct hfi_dpb_counts *dpb_count;
+	u32 ptype, rem_bytes;
+	u32 size_read = 0;
 	u8 *data_ptr;
-	u32 ptype;
 
 	inst->error = HFI_ERR_NONE;
 
@@ -44,86 +45,118 @@ static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
 		break;
 	default:
 		inst->error = HFI_ERR_SESSION_INVALID_PARAMETER;
-		goto done;
+		inst->ops->event_notify(inst, EVT_SYS_EVENT_CHANGE, &event);
+		return;
 	}
 
 	event.event_type = pkt->event_data1;
 
 	num_properties_changed = pkt->event_data2;
-	if (!num_properties_changed) {
-		inst->error = HFI_ERR_SESSION_INSUFFICIENT_RESOURCES;
-		goto done;
-	}
+	if (!num_properties_changed)
+		goto error;
 
 	data_ptr = (u8 *)&pkt->ext_event_data[0];
+	rem_bytes = pkt->shdr.hdr.size - sizeof(*pkt);
+
 	do {
+		if (rem_bytes < sizeof(u32))
+			goto error;
 		ptype = *((u32 *)data_ptr);
+
+		data_ptr += sizeof(u32);
+		rem_bytes -= sizeof(u32);
+
 		switch (ptype) {
 		case HFI_PROPERTY_PARAM_FRAME_SIZE:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_framesize))
+				goto error;
+
 			frame_sz = (struct hfi_framesize *)data_ptr;
 			event.width = frame_sz->width;
 			event.height = frame_sz->height;
-			data_ptr += sizeof(*frame_sz);
+			size_read = sizeof(struct hfi_framesize);
 			break;
 		case HFI_PROPERTY_PARAM_PROFILE_LEVEL_CURRENT:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_profile_level))
+				goto error;
+
 			profile_level = (struct hfi_profile_level *)data_ptr;
 			event.profile = profile_level->profile;
 			event.level = profile_level->level;
-			data_ptr += sizeof(*profile_level);
+			size_read = sizeof(struct hfi_profile_level);
 			break;
 		case HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_bit_depth))
+				goto error;
+
 			pixel_depth = (struct hfi_bit_depth *)data_ptr;
 			event.bit_depth = pixel_depth->bit_depth;
-			data_ptr += sizeof(*pixel_depth);
+			size_read = sizeof(struct hfi_bit_depth);
 			break;
 		case HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_pic_struct))
+				goto error;
+
 			pic_struct = (struct hfi_pic_struct *)data_ptr;
 			event.pic_struct = pic_struct->progressive_only;
-			data_ptr += sizeof(*pic_struct);
+			size_read = sizeof(struct hfi_pic_struct);
 			break;
 		case HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_colour_space))
+				goto error;
+
 			colour_info = (struct hfi_colour_space *)data_ptr;
 			event.colour_space = colour_info->colour_space;
-			data_ptr += sizeof(*colour_info);
+			size_read = sizeof(struct hfi_colour_space);
 			break;
 		case HFI_PROPERTY_CONFIG_VDEC_ENTROPY:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(u32))
+				goto error;
+
 			event.entropy_mode = *(u32 *)data_ptr;
-			data_ptr += sizeof(u32);
+			size_read = sizeof(u32);
 			break;
 		case HFI_PROPERTY_CONFIG_BUFFER_REQUIREMENTS:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_buffer_requirements))
+				goto error;
+
 			bufreq = (struct hfi_buffer_requirements *)data_ptr;
-			event.buf_count = HFI_BUFREQ_COUNT_MIN(bufreq, ver);
-			data_ptr += sizeof(*bufreq);
+			event.buf_count = hfi_bufreq_get_count_min(bufreq, ver);
+			size_read = sizeof(struct hfi_buffer_requirements);
 			break;
 		case HFI_INDEX_EXTRADATA_INPUT_CROP:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_extradata_input_crop))
+				goto error;
+
 			crop = (struct hfi_extradata_input_crop *)data_ptr;
 			event.input_crop.left = crop->left;
 			event.input_crop.top = crop->top;
 			event.input_crop.width = crop->width;
 			event.input_crop.height = crop->height;
-			data_ptr += sizeof(*crop);
+			size_read = sizeof(struct hfi_extradata_input_crop);
 			break;
 		case HFI_PROPERTY_PARAM_VDEC_DPB_COUNTS:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_dpb_counts))
+				goto error;
+
 			dpb_count = (struct hfi_dpb_counts *)data_ptr;
 			event.buf_count = dpb_count->fw_min_cnt;
-			data_ptr += sizeof(*dpb_count);
+			size_read = sizeof(struct hfi_dpb_counts);
 			break;
 		default:
+			size_read = 0;
 			break;
 		}
+		data_ptr += size_read;
+		rem_bytes -= size_read;
 		num_properties_changed--;
 	} while (num_properties_changed > 0);
 
-done:
+	inst->ops->event_notify(inst, EVT_SYS_EVENT_CHANGE, &event);
+	return;
+
+error:
+	inst->error = HFI_ERR_SESSION_INSUFFICIENT_RESOURCES;
 	inst->ops->event_notify(inst, EVT_SYS_EVENT_CHANGE, &event);
 }
 
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 92ea4642d898..2d1e0410dc82 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -239,6 +239,7 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
 static int venus_read_queue(struct venus_hfi_device *hdev,
 			    struct iface_queue *queue, void *pkt, u32 *tx_req)
 {
+	struct hfi_pkt_hdr *pkt_hdr = NULL;
 	struct hfi_queue_header *qhdr;
 	u32 dwords, new_rd_idx;
 	u32 rd_idx, wr_idx, type, qsize;
@@ -304,6 +305,9 @@ static int venus_read_queue(struct venus_hfi_device *hdev,
 			memcpy(pkt, rd_ptr, len);
 			memcpy(pkt + len, queue->qmem.kva, new_rd_idx << 2);
 		}
+		pkt_hdr = (struct hfi_pkt_hdr *)(pkt);
+		if ((pkt_hdr->size >> 2) != dwords)
+			return -EINVAL;
 	} else {
 		/* bad packet received, dropping */
 		new_rd_idx = qhdr->write_idx;
@@ -1707,6 +1711,7 @@ void venus_hfi_destroy(struct venus_core *core)
 	venus_interface_queues_release(hdev);
 	mutex_destroy(&hdev->lock);
 	kfree(hdev);
+	disable_irq(core->irq);
 	core->ops = NULL;
 }
 
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 3b51d603605e..8a1c7b9e0c96 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -458,11 +458,10 @@ static int vdec_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
 	do_div(us_per_frame, timeperframe->denominator);
 
-	if (!us_per_frame)
-		return -EINVAL;
-
+	us_per_frame = clamp(us_per_frame, 1, USEC_PER_SEC);
 	fps = (u64)USEC_PER_SEC;
 	do_div(fps, us_per_frame);
+	fps = min(VENUS_MAX_FPS, fps);
 
 	inst->fps = fps;
 	inst->timeperframe = *timeperframe;
@@ -865,13 +864,13 @@ static int vdec_num_buffers(struct venus_inst *inst, unsigned int *in_num,
 	if (ret)
 		return ret;
 
-	*in_num = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+	*in_num = hfi_bufreq_get_count_min(&bufreq, ver);
 
 	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT, &bufreq);
 	if (ret)
 		return ret;
 
-	*out_num = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+	*out_num = hfi_bufreq_get_count_min(&bufreq, ver);
 
 	return 0;
 }
@@ -985,14 +984,14 @@ static int vdec_verify_conf(struct venus_inst *inst)
 		return ret;
 
 	if (inst->num_output_bufs < bufreq.count_actual ||
-	    inst->num_output_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
+	    inst->num_output_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
 		return -EINVAL;
 
 	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
 	if (ret)
 		return ret;
 
-	if (inst->num_input_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
+	if (inst->num_input_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/media/platform/qcom/venus/vdec_ctrls.c b/drivers/media/platform/qcom/venus/vdec_ctrls.c
index fbe12a608b21..7e0f29bf7fae 100644
--- a/drivers/media/platform/qcom/venus/vdec_ctrls.c
+++ b/drivers/media/platform/qcom/venus/vdec_ctrls.c
@@ -79,7 +79,7 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
 		ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT, &bufreq);
 		if (!ret)
-			ctrl->val = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+			ctrl->val = hfi_bufreq_get_count_min(&bufreq, ver);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index abd25720b96b..09f3bcc29dd5 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -406,11 +406,10 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
 	do_div(us_per_frame, timeperframe->denominator);
 
-	if (!us_per_frame)
-		return -EINVAL;
-
+	us_per_frame = clamp(us_per_frame, 1, USEC_PER_SEC);
 	fps = (u64)USEC_PER_SEC;
 	do_div(fps, us_per_frame);
+	fps = min(VENUS_MAX_FPS, fps);
 
 	inst->timeperframe = *timeperframe;
 	inst->fps = fps;
@@ -1177,7 +1176,7 @@ static int venc_verify_conf(struct venus_inst *inst)
 		return ret;
 
 	if (inst->num_output_bufs < bufreq.count_actual ||
-	    inst->num_output_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
+	    inst->num_output_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
 		return -EINVAL;
 
 	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
@@ -1185,7 +1184,7 @@ static int venc_verify_conf(struct venus_inst *inst)
 		return ret;
 
 	if (inst->num_input_bufs < bufreq.count_actual ||
-	    inst->num_input_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
+	    inst->num_input_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index 7468e43800a9..d9d2a293f3ef 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -358,7 +358,7 @@ static int venc_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
 		ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
 		if (!ret)
-			ctrl->val = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+			ctrl->val = hfi_bufreq_get_count_min(&bufreq, ver);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/media/test-drivers/vivid/vivid-ctrls.c b/drivers/media/test-drivers/vivid/vivid-ctrls.c
index 92b1a7598470..0e549777860f 100644
--- a/drivers/media/test-drivers/vivid/vivid-ctrls.c
+++ b/drivers/media/test-drivers/vivid/vivid-ctrls.c
@@ -238,7 +238,8 @@ static const struct v4l2_ctrl_config vivid_ctrl_u8_pixel_array = {
 	.min = 0x00,
 	.max = 0xff,
 	.step = 1,
-	.dims = { 640 / PIXEL_ARRAY_DIV, 360 / PIXEL_ARRAY_DIV },
+	.dims = { DIV_ROUND_UP(360, PIXEL_ARRAY_DIV),
+		  DIV_ROUND_UP(640, PIXEL_ARRAY_DIV) },
 };
 
 static const char * const vivid_ctrl_menu_strings[] = {
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index a9e0dd32d04b..e3e3237206ab 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -475,8 +475,8 @@ void vivid_update_format_cap(struct vivid_dev *dev, bool keep_controls)
 	if (keep_controls)
 		return;
 
-	dims[0] = roundup(dev->src_rect.width, PIXEL_ARRAY_DIV);
-	dims[1] = roundup(dev->src_rect.height, PIXEL_ARRAY_DIV);
+	dims[0] = DIV_ROUND_UP(dev->src_rect.height, PIXEL_ARRAY_DIV);
+	dims[1] = DIV_ROUND_UP(dev->src_rect.width, PIXEL_ARRAY_DIV);
 	v4l2_ctrl_modify_dimensions(dev->pixel_array, dims);
 }
 
diff --git a/drivers/media/usb/gspca/vicam.c b/drivers/media/usb/gspca/vicam.c
index d98343fd33fe..91e177aa8136 100644
--- a/drivers/media/usb/gspca/vicam.c
+++ b/drivers/media/usb/gspca/vicam.c
@@ -227,6 +227,7 @@ static int sd_init(struct gspca_dev *gspca_dev)
 	const struct ihex_binrec *rec;
 	const struct firmware *fw;
 	u8 *firmware_buf;
+	int len;
 
 	ret = request_ihex_firmware(&fw, VICAM_FIRMWARE,
 				    &gspca_dev->dev->dev);
@@ -241,9 +242,14 @@ static int sd_init(struct gspca_dev *gspca_dev)
 		goto exit;
 	}
 	for (rec = (void *)fw->data; rec; rec = ihex_next_binrec(rec)) {
-		memcpy(firmware_buf, rec->data, be16_to_cpu(rec->len));
+		len = be16_to_cpu(rec->len);
+		if (len > PAGE_SIZE) {
+			ret = -EINVAL;
+			break;
+		}
+		memcpy(firmware_buf, rec->data, len);
 		ret = vicam_control_msg(gspca_dev, 0xff, 0, 0, firmware_buf,
-					be16_to_cpu(rec->len));
+					len);
 		if (ret < 0)
 			break;
 	}
diff --git a/drivers/media/usb/hdpvr/hdpvr-i2c.c b/drivers/media/usb/hdpvr/hdpvr-i2c.c
index 070559b01b01..54956a8ff15e 100644
--- a/drivers/media/usb/hdpvr/hdpvr-i2c.c
+++ b/drivers/media/usb/hdpvr/hdpvr-i2c.c
@@ -165,10 +165,16 @@ static const struct i2c_algorithm hdpvr_algo = {
 	.functionality = hdpvr_functionality,
 };
 
+/* prevent invalid 0-length usb_control_msg */
+static const struct i2c_adapter_quirks hdpvr_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN_READ,
+};
+
 static const struct i2c_adapter hdpvr_i2c_adapter_template = {
 	.name   = "Hauppauge HD PVR I2C",
 	.owner  = THIS_MODULE,
 	.algo   = &hdpvr_algo,
+	.quirks = &hdpvr_quirks,
 };
 
 static int hdpvr_activate_ir(struct hdpvr_device *dev)
diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index 7495df6b5191..f3633448e8b9 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -73,6 +73,10 @@ static int usbtv_configure_for_norm(struct usbtv *usbtv, v4l2_std_id norm)
 	}
 
 	if (params) {
+		if (vb2_is_busy(&usbtv->vb2q) &&
+		    (usbtv->width != params->cap_width ||
+		     usbtv->height != params->cap_height))
+			return -EBUSY;
 		usbtv->width = params->cap_width;
 		usbtv->height = params->cap_height;
 		usbtv->n_chunks = usbtv->width * usbtv->height
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index fc0b7c7db2fb..ff5ca3163c3e 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -233,6 +233,9 @@ static int uvc_parse_format(struct uvc_device *dev,
 	unsigned int i, n;
 	u8 ftype;
 
+	if (buflen < 4)
+		return -EINVAL;
+
 	format->type = buffer[2];
 	format->index = buffer[3];
 
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index aa0a879a9c64..da693e3905dd 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -234,6 +234,15 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
 
 		ctrl->dwMaxPayloadTransferSize = bandwidth;
 	}
+
+	if (stream->intf->num_altsetting > 1 &&
+	    ctrl->dwMaxPayloadTransferSize > stream->maxpsize) {
+		dev_warn_ratelimited(&stream->intf->dev,
+				     "UVC non compliance: the max payload transmission size (%u) exceeds the size of the ep max packet (%u). Using the max size.\n",
+				     ctrl->dwMaxPayloadTransferSize,
+				     stream->maxpsize);
+		ctrl->dwMaxPayloadTransferSize = stream->maxpsize;
+	}
 }
 
 static size_t uvc_video_ctrl_size(struct uvc_streaming *stream)
@@ -1344,12 +1353,6 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 	if (!meta_buf || length == 2)
 		return;
 
-	if (meta_buf->length - meta_buf->bytesused <
-	    length + sizeof(meta->ns) + sizeof(meta->sof)) {
-		meta_buf->error = 1;
-		return;
-	}
-
 	has_pts = mem[1] & UVC_STREAM_PTS;
 	has_scr = mem[1] & UVC_STREAM_SCR;
 
@@ -1370,6 +1373,12 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 				  !memcmp(scr, stream->clock.last_scr, 6)))
 		return;
 
+	if (meta_buf->length - meta_buf->bytesused <
+	    length + sizeof(meta->ns) + sizeof(meta->sof)) {
+		meta_buf->error = 1;
+		return;
+	}
+
 	meta = (struct uvc_meta_buf *)((u8 *)meta_buf->mem + meta_buf->bytesused);
 	local_irq_save(flags);
 	time = uvc_video_get_time();
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 40f56e044640..1c8d36684809 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -475,10 +475,10 @@ s64 v4l2_get_link_freq(struct v4l2_ctrl_handler *handler, unsigned int mul,
 
 		freq = div_u64(v4l2_ctrl_g_ctrl_int64(ctrl) * mul, div);
 
-		pr_warn("%s: Link frequency estimated using pixel rate: result might be inaccurate\n",
-			__func__);
-		pr_warn("%s: Consider implementing support for V4L2_CID_LINK_FREQ in the transmitter driver\n",
-			__func__);
+		pr_warn_once("%s: Link frequency estimated using pixel rate: result might be inaccurate\n",
+			     __func__);
+		pr_warn_once("%s: Consider implementing support for V4L2_CID_LINK_FREQ in the transmitter driver\n",
+			     __func__);
 	}
 
 	return freq > 0 ? freq : -EINVAL;
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index ad5a40e4c2d5..0514e0479346 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -1327,7 +1327,6 @@ void v4l2_ctrl_handler_free(struct v4l2_ctrl_handler *hdl)
 	kvfree(hdl->buckets);
 	hdl->buckets = NULL;
 	hdl->cached = NULL;
-	hdl->error = 0;
 	mutex_unlock(hdl->lock);
 	mutex_destroy(&hdl->_lock);
 }
diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 4b62ebfdb9b0..9a2acf5c4014 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -548,7 +548,6 @@ EXPORT_SYMBOL(memstick_add_host);
  */
 void memstick_remove_host(struct memstick_host *host)
 {
-	host->removing = 1;
 	flush_workqueue(workqueue);
 	mutex_lock(&host->lock);
 	if (host->card)
diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index dec279845a75..43ec4948daa2 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -812,6 +812,7 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 	int err;
 
 	host->eject = true;
+	msh->removing = true;
 	cancel_work_sync(&host->handle_req);
 	cancel_delayed_work_sync(&host->poll_card);
 
diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index f150d8769f19..f546b050cb49 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -698,6 +698,12 @@ static void rtsx_usb_disconnect(struct usb_interface *intf)
 }
 
 #ifdef CONFIG_PM
+static int rtsx_usb_resume_child(struct device *dev, void *data)
+{
+	pm_request_resume(dev);
+	return 0;
+}
+
 static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct rtsx_ucr *ucr =
@@ -713,8 +719,10 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
 			mutex_unlock(&ucr->dev_mutex);
 
 			/* Defer the autosuspend if card exists */
-			if (val & (SD_CD | MS_CD))
+			if (val & (SD_CD | MS_CD)) {
+				device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
 				return -EAGAIN;
+			}
 		} else {
 			/* There is an ongoing operation*/
 			return -EAGAIN;
@@ -724,12 +732,6 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
 	return 0;
 }
 
-static int rtsx_usb_resume_child(struct device *dev, void *data)
-{
-	pm_request_resume(dev);
-	return 0;
-}
-
 static int rtsx_usb_resume(struct usb_interface *intf)
 {
 	device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 7b7f4190cd02..19bc1e9eeb7f 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -1113,6 +1113,8 @@ static void mei_dev_bus_put(struct mei_device *bus)
 static void mei_cl_bus_dev_release(struct device *dev)
 {
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
+	struct mei_device *mdev = cldev->cl->dev;
+	struct mei_cl *cl;
 
 	if (!cldev)
 		return;
@@ -1120,6 +1122,10 @@ static void mei_cl_bus_dev_release(struct device *dev)
 	mei_cl_flush_queues(cldev->cl, NULL);
 	mei_me_cl_put(cldev->me_cl);
 	mei_dev_bus_put(cldev->bus);
+
+	list_for_each_entry(cl, &mdev->file_list, link)
+		WARN_ON(cl == cldev->cl);
+
 	kfree(cldev->cl);
 	kfree(cldev);
 }
diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 2c650cd58693..c5a6bbc06953 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1032,9 +1032,7 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 		err = sd_power_on(host);
 	}
 
-	if (!err)
-		host->power_mode = power_mode;
-
+	host->power_mode = power_mode;
 	return err;
 }
 
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index c8488b8e2073..f507fa491c58 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1560,6 +1560,7 @@ static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_host *mmc = host->mmc;
 	bool done = false;
 	u32 val = SWITCHABLE_SIGNALING_VOLTAGE;
 	const struct sdhci_msm_offset *msm_offset =
@@ -1617,6 +1618,12 @@ static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
 				 "%s: pwr_irq for req: (%d) timed out\n",
 				 mmc_hostname(host->mmc), req_type);
 	}
+
+	if ((req_type & REQ_BUS_ON) && mmc->card && !mmc->ops->get_cd(mmc)) {
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+		host->pwr = 0;
+	}
+
 	pr_debug("%s: %s: request %d done\n", mmc_hostname(host->mmc),
 			__func__, req_type);
 }
@@ -1675,6 +1682,13 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 		udelay(10);
 	}
 
+	if ((irq_status & CORE_PWRCTL_BUS_ON) && mmc->card &&
+	    !mmc->ops->get_cd(mmc)) {
+		msm_host_writel(msm_host, CORE_PWRCTL_BUS_FAIL, host,
+				msm_offset->core_pwrctl_ctl);
+		return;
+	}
+
 	/* Handle BUS ON/OFF*/
 	if (irq_status & CORE_PWRCTL_BUS_ON) {
 		pwr_state = REQ_BUS_ON;
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 3b5b5c139206..7a075f0fa314 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -27,8 +27,6 @@
 #define PCI_GLI_9750_PM_CTRL	0xFC
 #define   PCI_GLI_9750_PM_STATE	  GENMASK(1, 0)
 
-#define PCI_GLI_9750_CORRERR_MASK				0x214
-#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
 
 #define SDHCI_GLI_9750_CFG2          0x848
 #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
@@ -154,12 +152,24 @@
 #define PCI_GLI_9755_PM_CTRL     0xFC
 #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
 
-#define PCI_GLI_9755_CORRERR_MASK				0x214
-#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
 
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
+static void sdhci_gli_mask_replay_timer_timeout(struct pci_dev *pdev)
+{
+	int aer;
+	u32 value;
+
+	/* mask the replay timer timeout of AER */
+	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (aer) {
+		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
+		value |= PCI_ERR_COR_REP_TIMER;
+		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
+	}
+}
+
 static inline void gl9750_wt_on(struct sdhci_host *host)
 {
 	u32 wt_value;
@@ -501,9 +511,7 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
 
 	/* mask the replay timer timeout of AER */
-	pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
-	value |= PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
-	pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
+	sdhci_gli_mask_replay_timer_timeout(pdev);
 
 	gl9750_wt_off(host);
 }
@@ -715,9 +723,7 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
 
 	/* mask the replay timer timeout of AER */
-	pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
-	value |= PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
-	pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
+	sdhci_gli_mask_replay_timer_timeout(pdev);
 
 	gl9755_wt_off(pdev);
 }
@@ -953,7 +959,7 @@ static void sdhci_gl9763e_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
-static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
+static void gl9763e_hw_setting(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
 	u32 value;
@@ -982,6 +988,9 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
 
+	/* mask the replay timer timeout of AER */
+	sdhci_gli_mask_replay_timer_timeout(pdev);
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
 	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
@@ -1125,7 +1134,7 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 	gli_pcie_enable_msi(slot);
 	host->mmc_host_ops.hs400_enhanced_strobe =
 					gl9763e_hs400_enhanced_strobe;
-	gli_set_gl9763e(slot);
+	gl9763e_hw_setting(slot);
 	sdhci_enable_v4_mode(host);
 
 	return 0;
diff --git a/drivers/most/core.c b/drivers/most/core.c
index e4412c7d25b0..5d073b3d2796 100644
--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -538,8 +538,8 @@ static struct most_channel *get_channel(char *mdev, char *mdev_ch)
 	dev = bus_find_device_by_name(&mostbus, NULL, mdev);
 	if (!dev)
 		return NULL;
-	put_device(dev);
 	iface = dev_get_drvdata(dev);
+	put_device(dev);
 	list_for_each_entry_safe(c, tmp, &iface->p->channel_list, list) {
 		if (!strcmp(dev_name(&c->dev), mdev_ch))
 			return c;
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 17786e1331e6..5ea362ec3955 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -503,6 +503,8 @@ static int dma_xfer(struct fsmc_nand_data *host, void *buffer, int len,
 
 	dma_dev = chan->device;
 	dma_addr = dma_map_single(dma_dev->dev, buffer, len, direction);
+	if (dma_mapping_error(dma_dev->dev, dma_addr))
+		return -EINVAL;
 
 	if (direction == DMA_TO_DEVICE) {
 		dma_src = dma_addr;
diff --git a/drivers/mtd/nand/raw/renesas-nand-controller.c b/drivers/mtd/nand/raw/renesas-nand-controller.c
index 1620e25a1147..3b6b0ada597a 100644
--- a/drivers/mtd/nand/raw/renesas-nand-controller.c
+++ b/drivers/mtd/nand/raw/renesas-nand-controller.c
@@ -426,6 +426,9 @@ static int rnandc_read_page_hw_ecc(struct nand_chip *chip, u8 *buf,
 	/* Configure DMA */
 	dma_addr = dma_map_single(rnandc->dev, rnandc->buf, mtd->writesize,
 				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(rnandc->dev, dma_addr))
+		return -ENOMEM;
+
 	writel(dma_addr, rnandc->regs + DMA_ADDR_LOW_REG);
 	writel(mtd->writesize, rnandc->regs + DMA_CNT_REG);
 	writel(DMA_TLVL_MAX, rnandc->regs + DMA_TLVL_REG);
@@ -606,6 +609,9 @@ static int rnandc_write_page_hw_ecc(struct nand_chip *chip, const u8 *buf,
 	/* Configure DMA */
 	dma_addr = dma_map_single(rnandc->dev, (void *)rnandc->buf, mtd->writesize,
 				  DMA_TO_DEVICE);
+	if (dma_mapping_error(rnandc->dev, dma_addr))
+		return -ENOMEM;
+
 	writel(dma_addr, rnandc->regs + DMA_ADDR_LOW_REG);
 	writel(mtd->writesize, rnandc->regs + DMA_CNT_REG);
 	writel(DMA_TLVL_MAX, rnandc->regs + DMA_TLVL_REG);
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 80e9646d2050..1ae5364c0c7c 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -624,7 +624,10 @@ static int spinand_write_page(struct spinand_device *spinand,
 			   SPINAND_WRITE_INITIAL_DELAY_US,
 			   SPINAND_WRITE_POLL_DELAY_US,
 			   &status);
-	if (!ret && (status & STATUS_PROG_FAILED))
+	if (ret)
+		return ret;
+
+	if (status & STATUS_PROG_FAILED)
 		return -EIO;
 
 	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index 1f178313ba8f..e63cdae6dd74 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -50,7 +50,6 @@ static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
 static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
 					uint64_t *len)
 {
-	struct mtd_info *mtd = &nor->mtd;
 	u64 min_prot_len;
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
 	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
@@ -71,13 +70,13 @@ static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
 	min_prot_len = spi_nor_get_min_prot_length_sr(nor);
 	*len = min_prot_len << (bp - 1);
 
-	if (*len > mtd->size)
-		*len = mtd->size;
+	if (*len > nor->params->size)
+		*len = nor->params->size;
 
 	if (nor->flags & SNOR_F_HAS_SR_TB && sr & tb_mask)
 		*ofs = 0;
 	else
-		*ofs = mtd->size - *len;
+		*ofs = nor->params->size - *len;
 }
 
 /*
@@ -153,7 +152,6 @@ static bool spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs,
  */
 static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
-	struct mtd_info *mtd = &nor->mtd;
 	u64 min_prot_len;
 	int ret, status_old, status_new;
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
@@ -178,7 +176,7 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 		can_be_bottom = false;
 
 	/* If anything above us is unlocked, we can't use 'top' protection */
-	if (!spi_nor_is_locked_sr(nor, ofs + len, mtd->size - (ofs + len),
+	if (!spi_nor_is_locked_sr(nor, ofs + len, nor->params->size - (ofs + len),
 				  status_old))
 		can_be_top = false;
 
@@ -190,11 +188,11 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 
 	/* lock_len: length of region that should end up locked */
 	if (use_top)
-		lock_len = mtd->size - ofs;
+		lock_len = nor->params->size - ofs;
 	else
 		lock_len = ofs + len;
 
-	if (lock_len == mtd->size) {
+	if (lock_len == nor->params->size) {
 		val = mask;
 	} else {
 		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
@@ -238,7 +236,6 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
  */
 static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
-	struct mtd_info *mtd = &nor->mtd;
 	u64 min_prot_len;
 	int ret, status_old, status_new;
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
@@ -263,7 +260,7 @@ static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 		can_be_top = false;
 
 	/* If anything above us is locked, we can't use 'bottom' protection */
-	if (!spi_nor_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
+	if (!spi_nor_is_unlocked_sr(nor, ofs + len, nor->params->size - (ofs + len),
 				    status_old))
 		can_be_bottom = false;
 
@@ -275,7 +272,7 @@ static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 
 	/* lock_len: length of region that should remain locked */
 	if (use_top)
-		lock_len = mtd->size - (ofs + len);
+		lock_len = nor->params->size - (ofs + len);
 	else
 		lock_len = ofs;
 
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 9270977e6c7f..37364bbfdbdc 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -98,13 +98,16 @@ static int ad_marker_send(struct port *port, struct bond_marker *marker);
 static void ad_mux_machine(struct port *port, bool *update_slave_arr);
 static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port);
 static void ad_tx_machine(struct port *port);
-static void ad_periodic_machine(struct port *port, struct bond_params *bond_params);
+static void ad_periodic_machine(struct port *port);
 static void ad_port_selection_logic(struct port *port, bool *update_slave_arr);
 static void ad_agg_selection_logic(struct aggregator *aggregator,
 				   bool *update_slave_arr);
 static void ad_clear_agg(struct aggregator *aggregator);
 static void ad_initialize_agg(struct aggregator *aggregator);
-static void ad_initialize_port(struct port *port, int lacp_fast);
+static void ad_initialize_port(struct port *port, const struct bond_params *bond_params);
+static void ad_enable_collecting(struct port *port);
+static void ad_disable_distributing(struct port *port,
+				    bool *update_slave_arr);
 static void ad_enable_collecting_distributing(struct port *port,
 					      bool *update_slave_arr);
 static void ad_disable_collecting_distributing(struct port *port,
@@ -170,9 +173,38 @@ static inline int __agg_has_partner(struct aggregator *agg)
 	return !is_zero_ether_addr(agg->partner_system.mac_addr_value);
 }
 
+/**
+ * __disable_distributing_port - disable the port's slave for distributing.
+ * Port will still be able to collect.
+ * @port: the port we're looking at
+ *
+ * This will disable only distributing on the port's slave.
+ */
+static void __disable_distributing_port(struct port *port)
+{
+	bond_set_slave_tx_disabled_flags(port->slave, BOND_SLAVE_NOTIFY_LATER);
+}
+
+/**
+ * __enable_collecting_port - enable the port's slave for collecting,
+ * if it's up
+ * @port: the port we're looking at
+ *
+ * This will enable only collecting on the port's slave.
+ */
+static void __enable_collecting_port(struct port *port)
+{
+	struct slave *slave = port->slave;
+
+	if (slave->link == BOND_LINK_UP && bond_slave_is_up(slave))
+		bond_set_slave_rx_enabled_flags(slave, BOND_SLAVE_NOTIFY_LATER);
+}
+
 /**
  * __disable_port - disable the port's slave
  * @port: the port we're looking at
+ *
+ * This will disable both collecting and distributing on the port's slave.
  */
 static inline void __disable_port(struct port *port)
 {
@@ -182,6 +214,8 @@ static inline void __disable_port(struct port *port)
 /**
  * __enable_port - enable the port's slave, if it's up
  * @port: the port we're looking at
+ *
+ * This will enable both collecting and distributing on the port's slave.
  */
 static inline void __enable_port(struct port *port)
 {
@@ -192,10 +226,27 @@ static inline void __enable_port(struct port *port)
 }
 
 /**
- * __port_is_enabled - check if the port's slave is in active state
+ * __port_move_to_attached_state - check if port should transition back to attached
+ * state.
  * @port: the port we're looking at
  */
-static inline int __port_is_enabled(struct port *port)
+static bool __port_move_to_attached_state(struct port *port)
+{
+	if (!(port->sm_vars & AD_PORT_SELECTED) ||
+	    (port->sm_vars & AD_PORT_STANDBY) ||
+	    !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) ||
+	    !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION))
+		port->sm_mux_state = AD_MUX_ATTACHED;
+
+	return port->sm_mux_state == AD_MUX_ATTACHED;
+}
+
+/**
+ * __port_is_collecting_distributing - check if the port's slave is in the
+ * combined collecting/distributing state
+ * @port: the port we're looking at
+ */
+static int __port_is_collecting_distributing(struct port *port)
 {
 	return bond_is_active_slave(port->slave);
 }
@@ -933,6 +984,7 @@ static int ad_marker_send(struct port *port, struct bond_marker *marker)
  */
 static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 {
+	struct bonding *bond = __get_bond_by_port(port);
 	mux_states_t last_state;
 
 	/* keep current State Machine state to compare later if it was
@@ -990,9 +1042,13 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 			if ((port->sm_vars & AD_PORT_SELECTED) &&
 			    (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) &&
 			    !__check_agg_selection_timer(port)) {
-				if (port->aggregator->is_active)
-					port->sm_mux_state =
-					    AD_MUX_COLLECTING_DISTRIBUTING;
+				if (port->aggregator->is_active) {
+					int state = AD_MUX_COLLECTING_DISTRIBUTING;
+
+					if (!bond->params.coupled_control)
+						state = AD_MUX_COLLECTING;
+					port->sm_mux_state = state;
+				}
 			} else if (!(port->sm_vars & AD_PORT_SELECTED) ||
 				   (port->sm_vars & AD_PORT_STANDBY)) {
 				/* if UNSELECTED or STANDBY */
@@ -1010,11 +1066,45 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 			}
 			break;
 		case AD_MUX_COLLECTING_DISTRIBUTING:
+			if (!__port_move_to_attached_state(port)) {
+				/* if port state hasn't changed make
+				 * sure that a collecting distributing
+				 * port in an active aggregator is enabled
+				 */
+				if (port->aggregator->is_active &&
+				    !__port_is_collecting_distributing(port)) {
+					__enable_port(port);
+					*update_slave_arr = true;
+				}
+			}
+			break;
+		case AD_MUX_COLLECTING:
+			if (!__port_move_to_attached_state(port)) {
+				if ((port->sm_vars & AD_PORT_SELECTED) &&
+				    (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) &&
+				    (port->partner_oper.port_state & LACP_STATE_COLLECTING)) {
+					port->sm_mux_state = AD_MUX_DISTRIBUTING;
+				} else {
+					/* If port state hasn't changed, make sure that a collecting
+					 * port is enabled for an active aggregator.
+					 */
+					struct slave *slave = port->slave;
+
+					if (port->aggregator->is_active &&
+					    bond_is_slave_rx_disabled(slave)) {
+						ad_enable_collecting(port);
+						*update_slave_arr = true;
+					}
+				}
+			}
+			break;
+		case AD_MUX_DISTRIBUTING:
 			if (!(port->sm_vars & AD_PORT_SELECTED) ||
 			    (port->sm_vars & AD_PORT_STANDBY) ||
+			    !(port->partner_oper.port_state & LACP_STATE_COLLECTING) ||
 			    !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) ||
 			    !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION)) {
-				port->sm_mux_state = AD_MUX_ATTACHED;
+				port->sm_mux_state = AD_MUX_COLLECTING;
 			} else {
 				/* if port state hasn't changed make
 				 * sure that a collecting distributing
@@ -1022,7 +1112,7 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 				 */
 				if (port->aggregator &&
 				    port->aggregator->is_active &&
-				    !__port_is_enabled(port)) {
+				    !__port_is_collecting_distributing(port)) {
 					__enable_port(port);
 					*update_slave_arr = true;
 				}
@@ -1073,6 +1163,20 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 							  update_slave_arr);
 			port->ntt = true;
 			break;
+		case AD_MUX_COLLECTING:
+			port->actor_oper_port_state |= LACP_STATE_COLLECTING;
+			port->actor_oper_port_state &= ~LACP_STATE_DISTRIBUTING;
+			port->actor_oper_port_state |= LACP_STATE_SYNCHRONIZATION;
+			ad_enable_collecting(port);
+			ad_disable_distributing(port, update_slave_arr);
+			port->ntt = true;
+			break;
+		case AD_MUX_DISTRIBUTING:
+			port->actor_oper_port_state |= LACP_STATE_DISTRIBUTING;
+			port->actor_oper_port_state |= LACP_STATE_SYNCHRONIZATION;
+			ad_enable_collecting_distributing(port,
+							  update_slave_arr);
+			break;
 		default:
 			break;
 		}
@@ -1187,10 +1291,16 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 			 * case of EXPIRED even if LINK_DOWN didn't arrive for
 			 * the port.
 			 */
-			port->partner_oper.port_state &= ~LACP_STATE_SYNCHRONIZATION;
 			port->sm_vars &= ~AD_PORT_MATCHED;
+			/* Based on IEEE 8021AX-2014, Figure 6-18 - Receive
+			 * machine state diagram, the statue should be
+			 * Partner_Oper_Port_State.Synchronization = FALSE;
+			 * Partner_Oper_Port_State.LACP_Timeout = Short Timeout;
+			 * start current_while_timer(Short Timeout);
+			 * Actor_Oper_Port_State.Expired = TRUE;
+			 */
+			port->partner_oper.port_state &= ~LACP_STATE_SYNCHRONIZATION;
 			port->partner_oper.port_state |= LACP_STATE_LACP_TIMEOUT;
-			port->partner_oper.port_state |= LACP_STATE_LACP_ACTIVITY;
 			port->sm_rx_timer_counter = __ad_timer_to_ticks(AD_CURRENT_WHILE_TIMER, (u16)(AD_SHORT_TIMEOUT));
 			port->actor_oper_port_state |= LACP_STATE_EXPIRED;
 			port->sm_vars |= AD_PORT_CHURNED;
@@ -1296,11 +1406,10 @@ static void ad_tx_machine(struct port *port)
 /**
  * ad_periodic_machine - handle a port's periodic state machine
  * @port: the port we're looking at
- * @bond_params: bond parameters we will use
  *
  * Turn ntt flag on priodically to perform periodic transmission of lacpdu's.
  */
-static void ad_periodic_machine(struct port *port, struct bond_params *bond_params)
+static void ad_periodic_machine(struct port *port)
 {
 	periodic_states_t last_state;
 
@@ -1309,8 +1418,7 @@ static void ad_periodic_machine(struct port *port, struct bond_params *bond_para
 
 	/* check if port was reinitialized */
 	if (((port->sm_vars & AD_PORT_BEGIN) || !(port->sm_vars & AD_PORT_LACP_ENABLED) || !port->is_enabled) ||
-	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)) ||
-	    !bond_params->lacp_active) {
+	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY))) {
 		port->sm_periodic_state = AD_NO_PERIODIC;
 	}
 	/* check if state machine should change state */
@@ -1834,16 +1942,16 @@ static void ad_initialize_agg(struct aggregator *aggregator)
 /**
  * ad_initialize_port - initialize a given port's parameters
  * @port: the port we're looking at
- * @lacp_fast: boolean. whether fast periodic should be used
+ * @bond_params: bond parameters we will use
  */
-static void ad_initialize_port(struct port *port, int lacp_fast)
+static void ad_initialize_port(struct port *port, const struct bond_params *bond_params)
 {
 	static const struct port_params tmpl = {
 		.system_priority = 0xffff,
 		.key             = 1,
 		.port_number     = 1,
 		.port_priority   = 0xff,
-		.port_state      = 1,
+		.port_state      = 0,
 	};
 	static const struct lacpdu lacpdu = {
 		.subtype		= 0x01,
@@ -1861,12 +1969,14 @@ static void ad_initialize_port(struct port *port, int lacp_fast)
 		port->actor_port_priority = 0xff;
 		port->actor_port_aggregator_identifier = 0;
 		port->ntt = false;
-		port->actor_admin_port_state = LACP_STATE_AGGREGATION |
-					       LACP_STATE_LACP_ACTIVITY;
-		port->actor_oper_port_state  = LACP_STATE_AGGREGATION |
-					       LACP_STATE_LACP_ACTIVITY;
+		port->actor_admin_port_state = LACP_STATE_AGGREGATION;
+		port->actor_oper_port_state  = LACP_STATE_AGGREGATION;
+		if (bond_params->lacp_active) {
+			port->actor_admin_port_state |= LACP_STATE_LACP_ACTIVITY;
+			port->actor_oper_port_state  |= LACP_STATE_LACP_ACTIVITY;
+		}
 
-		if (lacp_fast)
+		if (bond_params->lacp_fast)
 			port->actor_oper_port_state |= LACP_STATE_LACP_TIMEOUT;
 
 		memcpy(&port->partner_admin, &tmpl, sizeof(tmpl));
@@ -1897,6 +2007,45 @@ static void ad_initialize_port(struct port *port, int lacp_fast)
 	}
 }
 
+/**
+ * ad_enable_collecting - enable a port's receive
+ * @port: the port we're looking at
+ *
+ * Enable @port if it's in an active aggregator
+ */
+static void ad_enable_collecting(struct port *port)
+{
+	if (port->aggregator->is_active) {
+		struct slave *slave = port->slave;
+
+		slave_dbg(slave->bond->dev, slave->dev,
+			  "Enabling collecting on port %d (LAG %d)\n",
+			  port->actor_port_number,
+			  port->aggregator->aggregator_identifier);
+		__enable_collecting_port(port);
+	}
+}
+
+/**
+ * ad_disable_distributing - disable a port's transmit
+ * @port: the port we're looking at
+ * @update_slave_arr: Does slave array need update?
+ */
+static void ad_disable_distributing(struct port *port, bool *update_slave_arr)
+{
+	if (port->aggregator &&
+	    !MAC_ADDRESS_EQUAL(&port->aggregator->partner_system,
+			       &(null_mac_addr))) {
+		slave_dbg(port->slave->bond->dev, port->slave->dev,
+			  "Disabling distributing on port %d (LAG %d)\n",
+			  port->actor_port_number,
+			  port->aggregator->aggregator_identifier);
+		__disable_distributing_port(port);
+		/* Slave array needs an update */
+		*update_slave_arr = true;
+	}
+}
+
 /**
  * ad_enable_collecting_distributing - enable a port's transmit/receive
  * @port: the port we're looking at
@@ -2043,7 +2192,7 @@ void bond_3ad_bind_slave(struct slave *slave)
 		/* port initialization */
 		port = &(SLAVE_AD_INFO(slave)->port);
 
-		ad_initialize_port(port, bond->params.lacp_fast);
+		ad_initialize_port(port, &bond->params);
 
 		port->slave = slave;
 		port->actor_port_number = SLAVE_AD_INFO(slave)->id;
@@ -2355,7 +2504,7 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 		}
 
 		ad_rx_machine(NULL, port);
-		ad_periodic_machine(port, &bond->params);
+		ad_periodic_machine(port);
 		ad_port_selection_logic(port, &update_slave_arr);
 		ad_mux_machine(port, &update_slave_arr);
 		ad_tx_machine(port);
@@ -2725,6 +2874,31 @@ void bond_3ad_update_lacp_rate(struct bonding *bond)
 	spin_unlock_bh(&bond->mode_lock);
 }
 
+/**
+ * bond_3ad_update_lacp_active - change the lacp active
+ * @bond: bonding struct
+ *
+ * Update actor_oper_port_state when lacp_active is modified.
+ */
+void bond_3ad_update_lacp_active(struct bonding *bond)
+{
+	struct port *port = NULL;
+	struct list_head *iter;
+	struct slave *slave;
+	int lacp_active;
+
+	lacp_active = bond->params.lacp_active;
+	spin_lock_bh(&bond->mode_lock);
+	bond_for_each_slave(bond, slave, iter) {
+		port = &(SLAVE_AD_INFO(slave)->port);
+		if (lacp_active)
+			port->actor_oper_port_state |= LACP_STATE_LACP_ACTIVITY;
+		else
+			port->actor_oper_port_state &= ~LACP_STATE_LACP_ACTIVITY;
+	}
+	spin_unlock_bh(&bond->mode_lock);
+}
+
 size_t bond_3ad_stats_size(void)
 {
 	return nla_total_size_64bit(sizeof(u64)) + /* BOND_3AD_STAT_LACPDU_RX */
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 3cedadef9c8a..11c58b88f9ce 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6310,6 +6310,7 @@ static int bond_check_params(struct bond_params *params)
 	params->ad_actor_sys_prio = ad_actor_sys_prio;
 	eth_zero_addr(params->ad_actor_system);
 	params->ad_user_port_key = ad_user_port_key;
+	params->coupled_control = 1;
 	if (packets_per_slave > 0) {
 		params->reciprocal_packets_per_slave =
 			reciprocal_value(packets_per_slave);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 27cbe148f0db..aebc814ad495 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -122,6 +122,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 	[IFLA_BOND_PEER_NOTIF_DELAY]    = NLA_POLICY_FULL_RANGE(NLA_U32, &delay_range),
 	[IFLA_BOND_MISSED_MAX]		= { .type = NLA_U8 },
 	[IFLA_BOND_NS_IP6_TARGET]	= { .type = NLA_NESTED },
+	[IFLA_BOND_COUPLED_CONTROL]	= { .type = NLA_U8 },
 };
 
 static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1] = {
@@ -549,6 +550,16 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 			return err;
 	}
 
+	if (data[IFLA_BOND_COUPLED_CONTROL]) {
+		int coupled_control = nla_get_u8(data[IFLA_BOND_COUPLED_CONTROL]);
+
+		bond_opt_initval(&newval, coupled_control);
+		err = __bond_opt_set(bond, BOND_OPT_COUPLED_CONTROL, &newval,
+				     data[IFLA_BOND_COUPLED_CONTROL], extack);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -615,6 +626,7 @@ static size_t bond_get_size(const struct net_device *bond_dev)
 						/* IFLA_BOND_NS_IP6_TARGET */
 		nla_total_size(sizeof(struct nlattr)) +
 		nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_NS_TARGETS +
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_COUPLED_CONTROL */
 		0;
 }
 
@@ -774,6 +786,10 @@ static int bond_fill_info(struct sk_buff *skb,
 		       bond->params.missed_max))
 		goto nla_put_failure;
 
+	if (nla_put_u8(skb, IFLA_BOND_COUPLED_CONTROL,
+		       bond->params.coupled_control))
+		goto nla_put_failure;
+
 	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
 		struct ad_info info;
 
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 21ca95cdef42..1235878d8715 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -85,7 +85,8 @@ static int bond_option_ad_user_port_key_set(struct bonding *bond,
 					    const struct bond_opt_value *newval);
 static int bond_option_missed_max_set(struct bonding *bond,
 				      const struct bond_opt_value *newval);
-
+static int bond_option_coupled_control_set(struct bonding *bond,
+					   const struct bond_opt_value *newval);
 
 static const struct bond_opt_value bond_mode_tbl[] = {
 	{ "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
@@ -233,6 +234,12 @@ static const struct bond_opt_value bond_missed_max_tbl[] = {
 	{ NULL,		-1,	0},
 };
 
+static const struct bond_opt_value bond_coupled_control_tbl[] = {
+	{ "on",  1,  BOND_VALFLAG_DEFAULT},
+	{ "off", 0,  0},
+	{ NULL,  -1, 0},
+};
+
 static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 	[BOND_OPT_MODE] = {
 		.id = BOND_OPT_MODE,
@@ -497,6 +504,15 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 		.desc = "Delay between each peer notification on failover event, in milliseconds",
 		.values = bond_peer_notif_delay_tbl,
 		.set = bond_option_peer_notif_delay_set
+	},
+	[BOND_OPT_COUPLED_CONTROL] = {
+		.id = BOND_OPT_COUPLED_CONTROL,
+		.name = "coupled_control",
+		.desc = "Opt into using coupled control MUX for LACP states",
+		.unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
+		.flags = BOND_OPTFLAG_IFDOWN,
+		.values = bond_coupled_control_tbl,
+		.set = bond_option_coupled_control_set,
 	}
 };
 
@@ -1634,6 +1650,7 @@ static int bond_option_lacp_active_set(struct bonding *bond,
 	netdev_dbg(bond->dev, "Setting LACP active to %s (%llu)\n",
 		   newval->string, newval->value);
 	bond->params.lacp_active = newval->value;
+	bond_3ad_update_lacp_active(bond);
 
 	return 0;
 }
@@ -1827,3 +1844,13 @@ static int bond_option_ad_user_port_key_set(struct bonding *bond,
 	bond->params.ad_user_port_key = newval->value;
 	return 0;
 }
+
+static int bond_option_coupled_control_set(struct bonding *bond,
+					   const struct bond_opt_value *newval)
+{
+	netdev_info(bond->dev, "Setting coupled_control to %s (%llu)\n",
+		    newval->string, newval->value);
+
+	bond->params.coupled_control = newval->value;
+	return 0;
+}
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 1a23fcc0445c..b0e283bc3efb 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -339,18 +339,23 @@ static void b53_set_forwarding(struct b53_device *dev, int enable)
 
 	b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_MODE, mgmt);
 
-	/* Include IMP port in dumb forwarding mode
-	 */
-	b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, &mgmt);
-	mgmt |= B53_MII_DUMB_FWDG_EN;
-	b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
-
-	/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
-	 * frames should be flooded or not.
-	 */
-	b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
-	mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
-	b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+	if (!is5325(dev)) {
+		/* Include IMP port in dumb forwarding mode */
+		b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, &mgmt);
+		mgmt |= B53_MII_DUMB_FWDG_EN;
+		b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
+
+		/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
+		 * frames should be flooded or not.
+		 */
+		b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
+		mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
+		b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+	} else {
+		b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
+		mgmt |= B53_IP_MCAST_25;
+		b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+	}
 }
 
 static void b53_enable_vlan(struct b53_device *dev, int port, bool enable,
@@ -507,6 +512,10 @@ void b53_imp_vlan_setup(struct dsa_switch *ds, int cpu_port)
 	unsigned int i;
 	u16 pvlan;
 
+	/* BCM5325 CPU port is at 8 */
+	if ((is5325(dev) || is5365(dev)) && cpu_port == B53_CPU_PORT_25)
+		cpu_port = B53_CPU_PORT;
+
 	/* Enable the IMP port to be in the same VLAN as the other ports
 	 * on a per-port basis such that we only have Port i and IMP in
 	 * the same VLAN.
@@ -557,6 +566,9 @@ static void b53_port_set_learning(struct b53_device *dev, int port,
 {
 	u16 reg;
 
+	if (is5325(dev))
+		return;
+
 	b53_read16(dev, B53_CTRL_PAGE, B53_DIS_LEARNING, &reg);
 	if (learning)
 		reg &= ~BIT(port);
@@ -1163,6 +1175,8 @@ static void b53_force_link(struct b53_device *dev, int port, int link)
 	if (port == dev->imp_port) {
 		off = B53_PORT_OVERRIDE_CTRL;
 		val = PORT_OVERRIDE_EN;
+	} else if (is5325(dev)) {
+		return;
 	} else {
 		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
 		val = GMII_PO_EN;
@@ -1187,6 +1201,8 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 	if (port == dev->imp_port) {
 		off = B53_PORT_OVERRIDE_CTRL;
 		val = PORT_OVERRIDE_EN;
+	} else if (is5325(dev)) {
+		return;
 	} else {
 		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
 		val = GMII_PO_EN;
@@ -1217,10 +1233,19 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 		return;
 	}
 
-	if (rx_pause)
-		reg |= PORT_OVERRIDE_RX_FLOW;
-	if (tx_pause)
-		reg |= PORT_OVERRIDE_TX_FLOW;
+	if (rx_pause) {
+		if (is5325(dev))
+			reg |= PORT_OVERRIDE_LP_FLOW_25;
+		else
+			reg |= PORT_OVERRIDE_RX_FLOW;
+	}
+
+	if (tx_pause) {
+		if (is5325(dev))
+			reg |= PORT_OVERRIDE_LP_FLOW_25;
+		else
+			reg |= PORT_OVERRIDE_TX_FLOW;
+	}
 
 	b53_write8(dev, B53_CTRL_PAGE, off, reg);
 }
@@ -2014,7 +2039,13 @@ int b53_br_flags_pre(struct dsa_switch *ds, int port,
 		     struct switchdev_brport_flags flags,
 		     struct netlink_ext_ack *extack)
 {
-	if (flags.mask & ~(BR_FLOOD | BR_MCAST_FLOOD | BR_LEARNING))
+	struct b53_device *dev = ds->priv;
+	unsigned long mask = (BR_FLOOD | BR_MCAST_FLOOD);
+
+	if (!is5325(dev))
+		mask |= BR_LEARNING;
+
+	if (flags.mask & ~mask)
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index b2c539a42154..77fb7ae660b8 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -92,6 +92,7 @@
 #define   PORT_OVERRIDE_SPEED_10M	(0 << PORT_OVERRIDE_SPEED_S)
 #define   PORT_OVERRIDE_SPEED_100M	(1 << PORT_OVERRIDE_SPEED_S)
 #define   PORT_OVERRIDE_SPEED_1000M	(2 << PORT_OVERRIDE_SPEED_S)
+#define   PORT_OVERRIDE_LP_FLOW_25	BIT(3) /* BCM5325 only */
 #define   PORT_OVERRIDE_RV_MII_25	BIT(4) /* BCM5325 only */
 #define   PORT_OVERRIDE_RX_FLOW		BIT(4)
 #define   PORT_OVERRIDE_TX_FLOW		BIT(5)
@@ -103,6 +104,7 @@
 
 /* IP Multicast control (8 bit) */
 #define B53_IP_MULTICAST_CTRL		0x21
+#define  B53_IP_MCAST_25		BIT(0)
 #define  B53_IPMC_FWD_EN		BIT(1)
 #define  B53_UC_FWD_EN			BIT(6)
 #define  B53_MC_FWD_EN			BIT(7)
diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index aa0fc00faecb..f05d4194eb09 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -71,6 +71,7 @@ static int dummy_dev_init(struct net_device *dev)
 	if (!dev->lstats)
 		return -ENOMEM;
 
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index 5fab589b3ddf..03e7f8084965 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -2459,6 +2459,10 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 							  skb->data,
 							  skb_headlen(skb),
 							  DMA_TO_DEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      dma_addr))
+					return -ENOMEM;
+
 				desc[frag].addr_lo = lower_32_bits(dma_addr);
 				desc[frag].addr_hi = upper_32_bits(dma_addr);
 				frag++;
@@ -2468,6 +2472,10 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 							  skb->data,
 							  skb_headlen(skb) / 2,
 							  DMA_TO_DEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      dma_addr))
+					return -ENOMEM;
+
 				desc[frag].addr_lo = lower_32_bits(dma_addr);
 				desc[frag].addr_hi = upper_32_bits(dma_addr);
 				frag++;
@@ -2478,6 +2486,10 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 							  skb_headlen(skb) / 2,
 							  skb_headlen(skb) / 2,
 							  DMA_TO_DEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      dma_addr))
+					goto unmap_first_out;
+
 				desc[frag].addr_lo = lower_32_bits(dma_addr);
 				desc[frag].addr_hi = upper_32_bits(dma_addr);
 				frag++;
@@ -2489,6 +2501,9 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 						    0,
 						    desc[frag].len_vlan,
 						    DMA_TO_DEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev, dma_addr))
+				goto unmap_out;
+
 			desc[frag].addr_lo = lower_32_bits(dma_addr);
 			desc[frag].addr_hi = upper_32_bits(dma_addr);
 			frag++;
@@ -2578,6 +2593,27 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 		       &adapter->regs->global.watchdog_timer);
 	}
 	return 0;
+
+unmap_out:
+	// Unmap the body of the packet with map_page
+	while (--i) {
+		frag--;
+		dma_addr = desc[frag].addr_lo;
+		dma_addr |= (u64)desc[frag].addr_hi << 32;
+		dma_unmap_page(&adapter->pdev->dev, dma_addr,
+			       desc[frag].len_vlan, DMA_TO_DEVICE);
+	}
+
+unmap_first_out:
+	// Unmap the header with map_single
+	while (frag--) {
+		dma_addr = desc[frag].addr_lo;
+		dma_addr |= (u64)desc[frag].addr_hi << 32;
+		dma_unmap_single(&adapter->pdev->dev, dma_addr,
+				 desc[frag].len_vlan, DMA_TO_DEVICE);
+	}
+
+	return -ENOMEM;
 }
 
 static int send_packet(struct sk_buff *skb, struct et131x_adapter *adapter)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index dbd284660135..7f616abd3db2 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -113,6 +113,8 @@ struct aq_stats_s {
 #define AQ_HW_POWER_STATE_D0   0U
 #define AQ_HW_POWER_STATE_D3   3U
 
+#define	AQ_FW_WAKE_ON_LINK_RTPM BIT(10)
+
 #define AQ_HW_FLAG_STARTED     0x00000004U
 #define AQ_HW_FLAG_STOPPING    0x00000008U
 #define AQ_HW_FLAG_RESETTING   0x00000010U
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
index 58d426dda3ed..1c5c27a9f30d 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
@@ -462,6 +462,44 @@ static int aq_a2_fw_get_mac_temp(struct aq_hw_s *self, int *temp)
 	return aq_a2_fw_get_phy_temp(self, temp);
 }
 
+static int aq_a2_fw_set_wol_params(struct aq_hw_s *self, const u8 *mac, u32 wol)
+{
+	struct mac_address_aligned_s mac_address;
+	struct link_control_s link_control;
+	struct wake_on_lan_s wake_on_lan;
+
+	memcpy(mac_address.aligned.mac_address, mac, ETH_ALEN);
+	hw_atl2_shared_buffer_write(self, mac_address, mac_address);
+
+	memset(&wake_on_lan, 0, sizeof(wake_on_lan));
+
+	if (wol & WAKE_MAGIC)
+		wake_on_lan.wake_on_magic_packet = 1U;
+
+	if (wol & (WAKE_PHY | AQ_FW_WAKE_ON_LINK_RTPM))
+		wake_on_lan.wake_on_link_up = 1U;
+
+	hw_atl2_shared_buffer_write(self, sleep_proxy, wake_on_lan);
+
+	hw_atl2_shared_buffer_get(self, link_control, link_control);
+	link_control.mode = AQ_HOST_MODE_SLEEP_PROXY;
+	hw_atl2_shared_buffer_write(self, link_control, link_control);
+
+	return hw_atl2_shared_buffer_finish_ack(self);
+}
+
+static int aq_a2_fw_set_power(struct aq_hw_s *self, unsigned int power_state,
+			      const u8 *mac)
+{
+	u32 wol = self->aq_nic_cfg->wol;
+	int err = 0;
+
+	if (wol)
+		err = aq_a2_fw_set_wol_params(self, mac, wol);
+
+	return err;
+}
+
 static int aq_a2_fw_set_eee_rate(struct aq_hw_s *self, u32 speed)
 {
 	struct link_options_s link_options;
@@ -605,6 +643,7 @@ const struct aq_fw_ops aq_a2_fw_ops = {
 	.set_state          = aq_a2_fw_set_state,
 	.update_link_status = aq_a2_fw_update_link_status,
 	.update_stats       = aq_a2_fw_update_stats,
+	.set_power          = aq_a2_fw_set_power,
 	.get_mac_temp       = aq_a2_fw_get_mac_temp,
 	.get_phy_temp       = aq_a2_fw_get_phy_temp,
 	.set_eee_rate       = aq_a2_fw_set_eee_rate,
diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 4a1efe9b37d0..ff93b00dcd61 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1234,6 +1234,11 @@ static bool ag71xx_fill_rx_buf(struct ag71xx *ag, struct ag71xx_buf *buf,
 	buf->rx.rx_buf = data;
 	buf->rx.dma_addr = dma_map_single(&ag->pdev->dev, data, ag->rx_buf_size,
 					  DMA_FROM_DEVICE);
+	if (dma_mapping_error(&ag->pdev->dev, buf->rx.dma_addr)) {
+		skb_free_frag(data);
+		buf->rx.rx_buf = NULL;
+		return false;
+	}
 	desc->data = (u32)buf->rx.dma_addr + offset;
 	return true;
 }
@@ -1532,6 +1537,10 @@ static netdev_tx_t ag71xx_hard_start_xmit(struct sk_buff *skb,
 
 	dma_addr = dma_map_single(&ag->pdev->dev, skb->data, skb->len,
 				  DMA_TO_DEVICE);
+	if (dma_mapping_error(&ag->pdev->dev, dma_addr)) {
+		netif_dbg(ag, tx_err, ndev, "DMA mapping error\n");
+		goto err_drop;
+	}
 
 	i = ring->curr & ring_mask;
 	desc = ag71xx_ring_desc(ring, i);
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 7eb2ddbe9bad..8c955eefc7e4 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1428,9 +1428,9 @@ static acpi_status bgx_acpi_match_id(acpi_handle handle, u32 lvl,
 {
 	struct acpi_buffer string = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct bgx *bgx = context;
-	char bgx_sel[5];
+	char bgx_sel[7];
 
-	snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
+	snprintf(bgx_sel, sizeof(bgx_sel), "BGX%d", bgx->bgx_id);
 	if (ACPI_FAILURE(acpi_get_name(handle, ACPI_SINGLE_NAME, &string))) {
 		pr_warn("Invalid link device\n");
 		return AE_OK;
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 173625a10886..7a3f7b4b859e 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1466,10 +1466,10 @@ static void be_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 						 ntohs(tcphdr->source));
 					dev_info(dev, "TCP dest port %d\n",
 						 ntohs(tcphdr->dest));
-					dev_info(dev, "TCP sequence num %d\n",
-						 ntohs(tcphdr->seq));
-					dev_info(dev, "TCP ack_seq %d\n",
-						 ntohs(tcphdr->ack_seq));
+					dev_info(dev, "TCP sequence num %u\n",
+						 ntohl(tcphdr->seq));
+					dev_info(dev, "TCP ack_seq %u\n",
+						 ntohl(tcphdr->ack_seq));
 				} else if (ip_hdr(skb)->protocol ==
 					   IPPROTO_UDP) {
 					udphdr = udp_hdr(skb);
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 6f5c22861dc9..5cf12c27553d 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -27,7 +27,6 @@
 #include <linux/percpu.h>
 #include <linux/dma-mapping.h>
 #include <linux/sort.h>
-#include <linux/phy_fixed.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <soc/fsl/bman.h>
@@ -3179,7 +3178,6 @@ static const struct net_device_ops dpaa_ops = {
 	.ndo_stop = dpaa_eth_stop,
 	.ndo_tx_timeout = dpaa_tx_timeout,
 	.ndo_get_stats64 = dpaa_get_stats64,
-	.ndo_change_carrier = fixed_phy_change_carrier,
 	.ndo_set_mac_address = dpaa_set_mac_address,
 	.ndo_validate_addr = eth_validate_addr,
 	.ndo_set_rx_mode = dpaa_set_rx_mode,
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index fcb0cba4611e..c3a23c2f037f 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -473,8 +473,10 @@ static int dpaa_get_ts_info(struct net_device *net_dev,
 		of_node_put(ptp_node);
 	}
 
-	if (ptp_dev)
+	if (ptp_dev) {
 		ptp = platform_get_drvdata(ptp_dev);
+		put_device(&ptp_dev->dev);
+	}
 
 	if (ptp)
 		info->phc_index = ptp->phc_index;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index bdf94335ee99..b84d5a66558a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -1207,6 +1207,7 @@ static int enetc_pf_register_with_ierb(struct pci_dev *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct platform_device *ierb_pdev;
 	struct device_node *ierb_node;
+	int ret;
 
 	/* Don't register with the IERB if the PF itself is disabled */
 	if (!node || !of_device_is_available(node))
@@ -1214,16 +1215,25 @@ static int enetc_pf_register_with_ierb(struct pci_dev *pdev)
 
 	ierb_node = of_find_compatible_node(NULL, NULL,
 					    "fsl,ls1028a-enetc-ierb");
-	if (!ierb_node || !of_device_is_available(ierb_node))
+	if (!ierb_node)
 		return -ENODEV;
 
+	if (!of_device_is_available(ierb_node)) {
+		of_node_put(ierb_node);
+		return -ENODEV;
+	}
+
 	ierb_pdev = of_find_device_by_node(ierb_node);
 	of_node_put(ierb_node);
 
 	if (!ierb_pdev)
 		return -EPROBE_DEFER;
 
-	return enetc_ierb_register_pf(ierb_pdev, pdev);
+	ret = enetc_ierb_register_pf(ierb_pdev, pdev);
+
+	put_device(&ierb_pdev->dev);
+
+	return ret;
 }
 
 static int enetc_pf_probe(struct pci_dev *pdev,
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 4a513dba8f53..d10db5d6d226 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2831,27 +2831,25 @@ static int fec_enet_us_to_itr_clock(struct net_device *ndev, int us)
 static void fec_enet_itr_coal_set(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	int rx_itr, tx_itr;
+	u32 rx_itr = 0, tx_itr = 0;
+	int rx_ictt, tx_ictt;
 
-	/* Must be greater than zero to avoid unpredictable behavior */
-	if (!fep->rx_time_itr || !fep->rx_pkts_itr ||
-	    !fep->tx_time_itr || !fep->tx_pkts_itr)
-		return;
-
-	/* Select enet system clock as Interrupt Coalescing
-	 * timer Clock Source
-	 */
-	rx_itr = FEC_ITR_CLK_SEL;
-	tx_itr = FEC_ITR_CLK_SEL;
+	rx_ictt = fec_enet_us_to_itr_clock(ndev, fep->rx_time_itr);
+	tx_ictt = fec_enet_us_to_itr_clock(ndev, fep->tx_time_itr);
 
-	/* set ICFT and ICTT */
-	rx_itr |= FEC_ITR_ICFT(fep->rx_pkts_itr);
-	rx_itr |= FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev, fep->rx_time_itr));
-	tx_itr |= FEC_ITR_ICFT(fep->tx_pkts_itr);
-	tx_itr |= FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev, fep->tx_time_itr));
+	if (rx_ictt > 0 && fep->rx_pkts_itr > 1) {
+		/* Enable with enet system clock as Interrupt Coalescing timer Clock Source */
+		rx_itr = FEC_ITR_EN | FEC_ITR_CLK_SEL;
+		rx_itr |= FEC_ITR_ICFT(fep->rx_pkts_itr);
+		rx_itr |= FEC_ITR_ICTT(rx_ictt);
+	}
 
-	rx_itr |= FEC_ITR_EN;
-	tx_itr |= FEC_ITR_EN;
+	if (tx_ictt > 0 && fep->tx_pkts_itr > 1) {
+		/* Enable with enet system clock as Interrupt Coalescing timer Clock Source */
+		tx_itr = FEC_ITR_EN | FEC_ITR_CLK_SEL;
+		tx_itr |= FEC_ITR_ICFT(fep->tx_pkts_itr);
+		tx_itr |= FEC_ITR_ICTT(tx_ictt);
+	}
 
 	writel(tx_itr, fep->hwp + FEC_TXIC0);
 	writel(rx_itr, fep->hwp + FEC_RXIC0);
diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
index b2b0d3c26fcc..994c119068ea 100644
--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -1466,8 +1466,10 @@ static int gfar_get_ts_info(struct net_device *dev,
 	if (ptp_node) {
 		ptp_dev = of_find_device_by_node(ptp_node);
 		of_node_put(ptp_node);
-		if (ptp_dev)
+		if (ptp_dev) {
 			ptp = platform_get_drvdata(ptp_dev);
+			put_device(&ptp_dev->dev);
+		}
 	}
 
 	if (ptp)
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index f7621ab672b9..32a9943432ac 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -409,6 +409,7 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 		break;
 	default:
 		dev_err(&priv->pdev->dev, "unknown AQ command opcode %d\n", opcode);
+		return -EINVAL;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 4fee466a8e90..2e8b01b3ee44 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1683,6 +1683,8 @@ static void gve_shutdown(struct pci_dev *pdev)
 	struct gve_priv *priv = netdev_priv(netdev);
 	bool was_up = netif_carrier_ok(priv->dev);
 
+	netif_device_detach(netdev);
+
 	rtnl_lock();
 	if (was_up && gve_close(priv->dev)) {
 		/* If the dev was up, attempt to close, if close fails, reset */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ca3fd0270810..5bcdb1b7da29 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6553,6 +6553,13 @@ static int igc_probe(struct pci_dev *pdev,
 	adapter->port_num = hw->bus.func;
 	adapter->msg_enable = netif_msg_init(debug, DEFAULT_MSG_ENABLE);
 
+	/* PCI config space info */
+	hw->vendor_id = pdev->vendor;
+	hw->device_id = pdev->device;
+	hw->revision_id = pdev->revision;
+	hw->subsystem_vendor_id = pdev->subsystem_vendor;
+	hw->subsystem_device_id = pdev->subsystem_device;
+
 	/* Disable ASPM L1.2 on I226 devices to avoid packet loss */
 	if (igc_is_device_id_i226(hw))
 		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
@@ -6577,13 +6584,6 @@ static int igc_probe(struct pci_dev *pdev,
 	netdev->mem_start = pci_resource_start(pdev, 0);
 	netdev->mem_end = pci_resource_end(pdev, 0);
 
-	/* PCI config space info */
-	hw->vendor_id = pdev->vendor;
-	hw->device_id = pdev->device;
-	hw->revision_id = pdev->revision;
-	hw->subsystem_vendor_id = pdev->subsystem_vendor;
-	hw->subsystem_device_id = pdev->subsystem_device;
-
 	/* Copy the default MAC and PHY function pointers */
 	memcpy(&hw->mac.ops, ei->mac_ops, sizeof(hw->mac.ops));
 	memcpy(&hw->phy.ops, ei->phy_ops, sizeof(hw->phy.ops));
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 1703c640a434..7ef82c30e857 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -403,7 +403,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 	dma_addr_t dma;
 	u32 cmd_type;
 
-	while (budget-- > 0) {
+	while (likely(budget)) {
 		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
 			work_done = false;
 			break;
@@ -438,6 +438,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 		xdp_ring->next_to_use++;
 		if (xdp_ring->next_to_use == xdp_ring->count)
 			xdp_ring->next_to_use = 0;
+
+		budget--;
 	}
 
 	if (tx_desc) {
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index 8cb8d47227f5..cc8f4f5decaf 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -101,7 +101,9 @@ mtk_flow_get_wdma_info(struct net_device *dev, const u8 *addr, struct mtk_wdma_i
 	if (!IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED))
 		return -1;
 
+	rcu_read_lock();
 	err = dev_fill_forward_path(dev, addr, &stack);
+	rcu_read_unlock();
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 65e01bf4b4d2..af33efe91f06 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -1074,7 +1074,6 @@ void mtk_wed_add_hw(struct device_node *np, struct mtk_eth *eth,
 	if (!pdev)
 		goto err_of_node_put;
 
-	get_device(&pdev->dev);
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		goto err_put_device;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
index 1e887d640cff..c72ac4dbdb21 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
@@ -362,7 +362,7 @@ void mlx5e_reactivate_qos_sq(struct mlx5e_priv *priv, u16 qid, struct netdev_que
 void mlx5e_reset_qdisc(struct net_device *dev, u16 qid)
 {
 	struct netdev_queue *dev_queue = netdev_get_tx_queue(dev, qid);
-	struct Qdisc *qdisc = dev_queue->qdisc_sleeping;
+	struct Qdisc *qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 
 	if (!qdisc)
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 67ecdb9e708f..2aec55dd07c6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2522,6 +2522,8 @@ static const struct mlxsw_listener mlxsw_sp_listener[] = {
 			     ROUTER_EXP, false),
 	MLXSW_SP_RXL_NO_MARK(DISCARD_ING_ROUTER_DIP_LINK_LOCAL, FORWARD,
 			     ROUTER_EXP, false),
+	MLXSW_SP_RXL_NO_MARK(DISCARD_ING_ROUTER_SIP_LINK_LOCAL, FORWARD,
+			     ROUTER_EXP, false),
 	/* Multicast Router Traps */
 	MLXSW_SP_RXL_MARK(ACL1, TRAP_TO_CPU, MULTICAST, false),
 	MLXSW_SP_RXL_L3_MARK(ACL2, TRAP_TO_CPU, MULTICAST, false),
diff --git a/drivers/net/ethernet/mellanox/mlxsw/trap.h b/drivers/net/ethernet/mellanox/mlxsw/trap.h
index 8da169663bda..f44c8548c7e3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/trap.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/trap.h
@@ -93,6 +93,7 @@ enum {
 	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_IPV4_SIP_BC = 0x16A,
 	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_IPV4_DIP_LOCAL_NET = 0x16B,
 	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_DIP_LINK_LOCAL = 0x16C,
+	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_SIP_LINK_LOCAL = 0x16D,
 	MLXSW_TRAP_ID_DISCARD_ROUTER_IRIF_EN = 0x178,
 	MLXSW_TRAP_ID_DISCARD_ROUTER_ERIF_EN = 0x179,
 	MLXSW_TRAP_ID_DISCARD_ROUTER_LPM4 = 0x17B,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index b746944bcd2a..7ed77a8304e6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3142,10 +3142,6 @@ void ionic_lif_free(struct ionic_lif *lif)
 	lif->info = NULL;
 	lif->info_pa = 0;
 
-	/* unmap doorbell page */
-	ionic_bus_unmap_dbpage(lif->ionic, lif->kern_dbpage);
-	lif->kern_dbpage = NULL;
-
 	mutex_destroy(&lif->config_lock);
 	mutex_destroy(&lif->queue_lock);
 
@@ -3171,6 +3167,9 @@ void ionic_lif_deinit(struct ionic_lif *lif)
 	ionic_lif_qcq_deinit(lif, lif->notifyqcq);
 	ionic_lif_qcq_deinit(lif, lif->adminqcq);
 
+	ionic_bus_unmap_dbpage(lif->ionic, lif->kern_dbpage);
+	lif->kern_dbpage = NULL;
+
 	ionic_lif_reset(lif);
 }
 
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 3dd5c69b05cb..b31441fc99fc 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -349,6 +349,7 @@ static int geneve_init(struct net_device *dev)
 		gro_cells_destroy(&geneve->gro_cells);
 		return err;
 	}
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index e7fd72f57e36..ea9cb1ac4bbe 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -1057,6 +1057,7 @@ struct net_device_context {
 	struct net_device __rcu *vf_netdev;
 	struct netvsc_vf_pcpu_stats __percpu *vf_stats;
 	struct delayed_work vf_takeover;
+	struct delayed_work vfns_work;
 
 	/* 1: allocated, serial number is valid. 0: not allocated */
 	u32 vf_alloc;
@@ -1071,6 +1072,8 @@ struct net_device_context {
 	struct netvsc_device_info *saved_netvsc_dev_info;
 };
 
+void netvsc_vfns_work(struct work_struct *w);
+
 /* Azure hosts don't support non-TCP port numbers in hashing for fragmented
  * packets. We can use ethtool to change UDP hash level when necessary.
  */
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 96a1767281f7..7433fe769943 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2508,6 +2508,7 @@ static int netvsc_probe(struct hv_device *dev,
 	spin_lock_init(&net_device_ctx->lock);
 	INIT_LIST_HEAD(&net_device_ctx->reconfig_events);
 	INIT_DELAYED_WORK(&net_device_ctx->vf_takeover, netvsc_vf_setup);
+	INIT_DELAYED_WORK(&net_device_ctx->vfns_work, netvsc_vfns_work);
 
 	net_device_ctx->vf_stats
 		= netdev_alloc_pcpu_stats(struct netvsc_vf_pcpu_stats);
@@ -2647,6 +2648,8 @@ static int netvsc_remove(struct hv_device *dev)
 	cancel_delayed_work_sync(&ndev_ctx->dwork);
 
 	rtnl_lock();
+	cancel_delayed_work_sync(&ndev_ctx->vfns_work);
+
 	nvdev = rtnl_dereference(ndev_ctx->nvdev);
 	if (nvdev) {
 		cancel_work_sync(&nvdev->subchan_work);
@@ -2689,6 +2692,7 @@ static int netvsc_suspend(struct hv_device *dev)
 	cancel_delayed_work_sync(&ndev_ctx->dwork);
 
 	rtnl_lock();
+	cancel_delayed_work_sync(&ndev_ctx->vfns_work);
 
 	nvdev = rtnl_dereference(ndev_ctx->nvdev);
 	if (nvdev == NULL) {
@@ -2782,6 +2786,27 @@ static void netvsc_event_set_vf_ns(struct net_device *ndev)
 	}
 }
 
+void netvsc_vfns_work(struct work_struct *w)
+{
+	struct net_device_context *ndev_ctx =
+		container_of(w, struct net_device_context, vfns_work.work);
+	struct net_device *ndev;
+
+	if (!rtnl_trylock()) {
+		schedule_delayed_work(&ndev_ctx->vfns_work, 1);
+		return;
+	}
+
+	ndev = hv_get_drvdata(ndev_ctx->device_ctx);
+	if (!ndev)
+		goto out;
+
+	netvsc_event_set_vf_ns(ndev);
+
+out:
+	rtnl_unlock();
+}
+
 /*
  * On Hyper-V, every VF interface is matched with a corresponding
  * synthetic interface. The synthetic interface is presented first
@@ -2792,10 +2817,12 @@ static int netvsc_netdev_event(struct notifier_block *this,
 			       unsigned long event, void *ptr)
 {
 	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
+	struct net_device_context *ndev_ctx;
 	int ret = 0;
 
 	if (event_dev->netdev_ops == &device_ops && event == NETDEV_REGISTER) {
-		netvsc_event_set_vf_ns(event_dev);
+		ndev_ctx = netdev_priv(event_dev);
+		schedule_delayed_work(&ndev_ctx->vfns_work, 0);
 		return NOTIFY_DONE;
 	}
 
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index b213397672d2..8dc6a4df93c7 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -144,6 +144,7 @@ static int loopback_dev_init(struct net_device *dev)
 	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
 	if (!dev->lstats)
 		return -ENOMEM;
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 90f3953cf906..b8d1c0d207c4 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -356,6 +356,8 @@ static const struct kszphy_type ksz8051_type = {
 
 static const struct kszphy_type ksz8081_type = {
 	.led_mode_reg		= MII_KSZPHY_CTRL_2,
+	.cable_diag_reg		= KSZ8081_LMD,
+	.pair_mask		= KSZPHY_WIRE_PAIR_MASK,
 	.has_broadcast_disable	= true,
 	.has_nand_tree_disable	= true,
 	.has_rmii_ref_clk_sel	= true,
diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 055e4ca5b3b5..878298304430 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -360,6 +360,13 @@ struct vsc85xx_hw_stat {
 	u16 mask;
 };
 
+struct vsc8531_skb_cb {
+	u32 ns;
+};
+
+#define VSC8531_SKB_CB(skb) \
+	((struct vsc8531_skb_cb *)((skb)->cb))
+
 struct vsc8531_private {
 	int rate_magic;
 	u16 supp_led_modes;
@@ -408,6 +415,11 @@ struct vsc8531_private {
 	 */
 	struct mutex ts_lock;
 	struct mutex phc_lock;
+
+	/* list of skbs that were received and need timestamp information but it
+	 * didn't received it yet
+	 */
+	struct sk_buff_head rx_skbs_list;
 };
 
 /* Shared structure between the PHYs of the same package.
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 7bd940baec59..36734bb217e4 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2324,6 +2324,13 @@ static int vsc85xx_probe(struct phy_device *phydev)
 	return vsc85xx_dt_led_modes_get(phydev, default_mode);
 }
 
+static void vsc85xx_remove(struct phy_device *phydev)
+{
+	struct vsc8531_private *priv = phydev->priv;
+
+	skb_queue_purge(&priv->rx_skbs_list);
+}
+
 /* Microsemi VSC85xx PHYs */
 static struct phy_driver vsc85xx_driver[] = {
 {
@@ -2554,6 +2561,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8574_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
@@ -2579,6 +2587,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8574_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
@@ -2604,6 +2613,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8584_probe,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
@@ -2627,6 +2637,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8584_probe,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
@@ -2650,6 +2661,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8584_probe,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index d0bd6ab45ebe..add1a9ee721a 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1193,9 +1193,7 @@ static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
 {
 	struct vsc8531_private *vsc8531 =
 		container_of(mii_ts, struct vsc8531_private, mii_ts);
-	struct skb_shared_hwtstamps *shhwtstamps = NULL;
 	struct vsc85xx_ptphdr *ptphdr;
-	struct timespec64 ts;
 	unsigned long ns;
 
 	if (!vsc8531->ptp->configured)
@@ -1205,27 +1203,52 @@ static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
 	    type == PTP_CLASS_NONE)
 		return false;
 
-	vsc85xx_gettime(&vsc8531->ptp->caps, &ts);
-
 	ptphdr = get_ptp_header_rx(skb, vsc8531->ptp->rx_filter);
 	if (!ptphdr)
 		return false;
 
-	shhwtstamps = skb_hwtstamps(skb);
-	memset(shhwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
-
 	ns = ntohl(ptphdr->rsrvd2);
 
-	/* nsec is in reserved field */
-	if (ts.tv_nsec < ns)
-		ts.tv_sec--;
+	VSC8531_SKB_CB(skb)->ns = ns;
+	skb_queue_tail(&vsc8531->rx_skbs_list, skb);
 
-	shhwtstamps->hwtstamp = ktime_set(ts.tv_sec, ns);
-	netif_rx(skb);
+	ptp_schedule_worker(vsc8531->ptp->ptp_clock, 0);
 
 	return true;
 }
 
+static long vsc85xx_do_aux_work(struct ptp_clock_info *info)
+{
+	struct vsc85xx_ptp *ptp = container_of(info, struct vsc85xx_ptp, caps);
+	struct skb_shared_hwtstamps *shhwtstamps = NULL;
+	struct phy_device *phydev = ptp->phydev;
+	struct vsc8531_private *priv = phydev->priv;
+	struct sk_buff_head received;
+	struct sk_buff *rx_skb;
+	struct timespec64 ts;
+	unsigned long flags;
+
+	__skb_queue_head_init(&received);
+	spin_lock_irqsave(&priv->rx_skbs_list.lock, flags);
+	skb_queue_splice_tail_init(&priv->rx_skbs_list, &received);
+	spin_unlock_irqrestore(&priv->rx_skbs_list.lock, flags);
+
+	vsc85xx_gettime(info, &ts);
+	while ((rx_skb = __skb_dequeue(&received)) != NULL) {
+		shhwtstamps = skb_hwtstamps(rx_skb);
+		memset(shhwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
+
+		if (ts.tv_nsec < VSC8531_SKB_CB(rx_skb)->ns)
+			ts.tv_sec--;
+
+		shhwtstamps->hwtstamp = ktime_set(ts.tv_sec,
+						  VSC8531_SKB_CB(rx_skb)->ns);
+		netif_rx(rx_skb);
+	}
+
+	return -1;
+}
+
 static const struct ptp_clock_info vsc85xx_clk_caps = {
 	.owner		= THIS_MODULE,
 	.name		= "VSC85xx timer",
@@ -1239,6 +1262,7 @@ static const struct ptp_clock_info vsc85xx_clk_caps = {
 	.adjfine	= &vsc85xx_adjfine,
 	.gettime64	= &vsc85xx_gettime,
 	.settime64	= &vsc85xx_settime,
+	.do_aux_work	= &vsc85xx_do_aux_work,
 };
 
 static struct vsc8531_private *vsc8584_base_priv(struct phy_device *phydev)
@@ -1566,6 +1590,7 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 
 	mutex_init(&vsc8531->phc_lock);
 	mutex_init(&vsc8531->ts_lock);
+	skb_queue_head_init(&vsc8531->rx_skbs_list);
 
 	/* Retrieve the shared load/save GPIO. Request it as non exclusive as
 	 * the same GPIO can be requested by all the PHYs of the same package.
diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 5186cc97c655..cf72aae88fbd 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -424,6 +424,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	/* PHY_BASIC_FEATURES */
 
+	.flags		= PHY_RST_AFTER_CLK_EN,
 	.probe		= smsc_phy_probe,
 
 	/* basic functions */
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 67d9efb05443..cbf1c1f23281 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -33,6 +33,7 @@
 #include <linux/ppp_channel.h>
 #include <linux/ppp-comp.h>
 #include <linux/skbuff.h>
+#include <linux/rculist.h>
 #include <linux/rtnetlink.h>
 #include <linux/if_arp.h>
 #include <linux/ip.h>
@@ -1613,11 +1614,14 @@ static int ppp_fill_forward_path(struct net_device_path_ctx *ctx,
 	if (ppp->flags & SC_MULTILINK)
 		return -EOPNOTSUPP;
 
-	if (list_empty(&ppp->channels))
+	pch = list_first_or_null_rcu(&ppp->channels, struct channel, clist);
+	if (!pch)
+		return -ENODEV;
+
+	chan = READ_ONCE(pch->chan);
+	if (!chan)
 		return -ENODEV;
 
-	pch = list_first_entry(&ppp->channels, struct channel, clist);
-	chan = pch->chan;
 	if (!chan->ops->fill_forward_path)
 		return -EOPNOTSUPP;
 
@@ -3000,7 +3004,7 @@ ppp_unregister_channel(struct ppp_channel *chan)
 	 */
 	down_write(&pch->chan_sem);
 	spin_lock_bh(&pch->downl);
-	pch->chan = NULL;
+	WRITE_ONCE(pch->chan, NULL);
 	spin_unlock_bh(&pch->downl);
 	up_write(&pch->chan_sem);
 	ppp_disconnect_channel(pch);
@@ -3506,7 +3510,7 @@ ppp_connect_channel(struct channel *pch, int unit)
 	hdrlen = pch->file.hdrlen + 2;	/* for protocol bytes */
 	if (hdrlen > ppp->dev->hard_header_len)
 		ppp->dev->hard_header_len = hdrlen;
-	list_add_tail(&pch->clist, &ppp->channels);
+	list_add_tail_rcu(&pch->clist, &ppp->channels);
 	++ppp->n_channels;
 	pch->ppp = ppp;
 	refcount_inc(&ppp->file.refcnt);
@@ -3536,10 +3540,11 @@ ppp_disconnect_channel(struct channel *pch)
 	if (ppp) {
 		/* remove it from the ppp unit's list */
 		ppp_lock(ppp);
-		list_del(&pch->clist);
+		list_del_rcu(&pch->clist);
 		if (--ppp->n_channels == 0)
 			wake_up_interruptible(&ppp->file.rwait);
 		ppp_unlock(ppp);
+		synchronize_net();
 		if (refcount_dec_and_test(&ppp->file.refcnt))
 			ppp_destroy_interface(ppp);
 		err = 0;
diff --git a/drivers/net/thunderbolt.c b/drivers/net/thunderbolt.c
index 5966e36875de..ef13aa36e55e 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -386,9 +386,9 @@ static void tbnet_tear_down(struct tbnet *net, bool send_logout)
 
 		ret = tb_xdomain_disable_paths(net->xd,
 					       net->local_transmit_path,
-					       net->rx_ring.ring->hop,
+					       net->tx_ring.ring->hop,
 					       net->remote_transmit_path,
-					       net->tx_ring.ring->hop);
+					       net->rx_ring.ring->hop);
 		if (ret)
 			netdev_warn(net->dev, "failed to disable DMA paths\n");
 
@@ -637,9 +637,9 @@ static void tbnet_connected_work(struct work_struct *work)
 		goto err_free_rx_buffers;
 
 	ret = tb_xdomain_enable_paths(net->xd, net->local_transmit_path,
-				      net->rx_ring.ring->hop,
+				      net->tx_ring.ring->hop,
 				      net->remote_transmit_path,
-				      net->tx_ring.ring->hop);
+				      net->rx_ring.ring->hop);
 	if (ret) {
 		netdev_err(net->dev, "failed to enable DMA paths\n");
 		goto err_free_tx_buffers;
@@ -884,8 +884,12 @@ static int tbnet_open(struct net_device *dev)
 
 	netif_carrier_off(dev);
 
-	ring = tb_ring_alloc_tx(xd->tb->nhi, -1, TBNET_RING_SIZE,
-				RING_FLAG_FRAME);
+	flags = RING_FLAG_FRAME;
+	/* Only enable full E2E if the other end supports it too */
+	if (tbnet_e2e && net->svc->prtcstns & TBNET_E2E)
+		flags |= RING_FLAG_E2E;
+
+	ring = tb_ring_alloc_tx(xd->tb->nhi, -1, TBNET_RING_SIZE, flags);
 	if (!ring) {
 		netdev_err(dev, "failed to allocate Tx ring\n");
 		return -ENOMEM;
@@ -904,11 +908,6 @@ static int tbnet_open(struct net_device *dev)
 	sof_mask = BIT(TBIP_PDF_FRAME_START);
 	eof_mask = BIT(TBIP_PDF_FRAME_END);
 
-	flags = RING_FLAG_FRAME;
-	/* Only enable full E2E if the other end supports it too */
-	if (tbnet_e2e && net->svc->prtcstns & TBNET_E2E)
-		flags |= RING_FLAG_E2E;
-
 	ring = tb_ring_alloc_rx(xd->tb->nhi, -1, TBNET_RING_SIZE, flags,
 				net->tx_ring.ring->hop, sof_mask,
 				eof_mask, tbnet_start_poll, net);
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 34cd568b27f1..021f38c25be8 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -676,6 +676,7 @@ static int ax88772_init_mdio(struct usbnet *dev)
 	priv->mdio->read = &asix_mdio_bus_read;
 	priv->mdio->write = &asix_mdio_bus_write;
 	priv->mdio->name = "Asix MDIO Bus";
+	priv->mdio->phy_mask = ~(BIT(priv->phy_addr & 0x1f) | BIT(AX_EMBD_PHY_ADDR));
 	/* mii bus name is usb-<usb bus number>-<usb device number> */
 	snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
 		 dev->udev->bus->busnum, dev->udev->devnum);
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 789e3647f979..9eb3c6b66a38 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -892,6 +892,10 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 		}
 	}
 
+	if (ctx->func_desc)
+		ctx->filtering_supported = !!(ctx->func_desc->bmNetworkCapabilities
+			& USB_CDC_NCM_NCAP_ETH_FILTER);
+
 	iface_no = ctx->data->cur_altsetting->desc.bInterfaceNumber;
 
 	/* Device-specific flags */
@@ -1897,6 +1901,14 @@ static void cdc_ncm_status(struct usbnet *dev, struct urb *urb)
 	}
 }
 
+static void cdc_ncm_update_filter(struct usbnet *dev)
+{
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+
+	if (ctx->filtering_supported)
+		usbnet_cdc_update_filter(dev);
+}
+
 static const struct driver_info cdc_ncm_info = {
 	.description = "CDC NCM (NO ZLP)",
 	.flags = FLAG_POINTTOPOINT | FLAG_NO_SETINT | FLAG_MULTI_PACKET
@@ -1907,7 +1919,7 @@ static const struct driver_info cdc_ncm_info = {
 	.status = cdc_ncm_status,
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
-	.set_rx_mode = usbnet_cdc_update_filter,
+	.set_rx_mode = cdc_ncm_update_filter,
 };
 
 /* Same as cdc_ncm_info, but with FLAG_SEND_ZLP  */
@@ -1921,7 +1933,7 @@ static const struct driver_info cdc_ncm_zlp_info = {
 	.status = cdc_ncm_status,
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
-	.set_rx_mode = usbnet_cdc_update_filter,
+	.set_rx_mode = cdc_ncm_update_filter,
 };
 
 /* Same as cdc_ncm_info, but with FLAG_WWAN */
@@ -1935,7 +1947,7 @@ static const struct driver_info wwan_info = {
 	.status = cdc_ncm_status,
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
-	.set_rx_mode = usbnet_cdc_update_filter,
+	.set_rx_mode = cdc_ncm_update_filter,
 };
 
 /* Same as wwan_info, but with FLAG_NOARP  */
@@ -1949,7 +1961,7 @@ static const struct driver_info wwan_noarp_info = {
 	.status = cdc_ncm_status,
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
-	.set_rx_mode = usbnet_cdc_update_filter,
+	.set_rx_mode = cdc_ncm_update_filter,
 };
 
 static const struct usb_device_id cdc_devs[] = {
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index e1e7df00e85c..ce90b093bb45 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1373,6 +1373,7 @@ static void veth_free_queues(struct net_device *dev)
 
 static int veth_dev_init(struct net_device *dev)
 {
+	netdev_lockdep_set_classes(dev);
 	return veth_alloc_queues(dev);
 }
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 747ce00dd321..50dacdc1b6a7 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2998,6 +2998,7 @@ static int vxlan_init(struct net_device *dev)
 	if (err)
 		goto err_free_percpu;
 
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 err_free_percpu:
diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index 051bf0d73084..c4437889f159 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -393,9 +393,6 @@ static int ath11k_ce_completed_recv_next(struct ath11k_ce_pipe *pipe,
 		goto err;
 	}
 
-	/* Make sure descriptor is read after the head pointer. */
-	dma_rmb();
-
 	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
 
 	*skb = pipe->dest_ring->skb[sw_index];
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 626d7f418670..be00ea6fbf8b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2661,9 +2661,6 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 try_again:
 	ath11k_hal_srng_access_begin(ab, srng);
 
-	/* Make sure descriptor is read after the head pointer. */
-	dma_rmb();
-
 	while (likely(desc =
 	      (struct hal_reo_dest_ring *)ath11k_hal_srng_dst_get_next_entry(ab,
 									     srng))) {
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index ec64fbf9aa82..692708f52b7d 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -796,13 +796,23 @@ u32 *ath11k_hal_srng_src_peek(struct ath11k_base *ab, struct hal_srng *srng)
 
 void ath11k_hal_srng_access_begin(struct ath11k_base *ab, struct hal_srng *srng)
 {
+	u32 hp;
+
 	lockdep_assert_held(&srng->lock);
 
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		srng->u.src_ring.cached_tp =
 			*(volatile u32 *)srng->u.src_ring.tp_addr;
 	} else {
-		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+
+		if (hp != srng->u.dst_ring.cached_hp) {
+			srng->u.dst_ring.cached_hp = hp;
+			/* Make sure descriptor is read after the head
+			 * pointer.
+			 */
+			dma_rmb();
+		}
 
 		/* Try to prefetch the next descriptor in the ring */
 		if (srng->flags & HAL_SRNG_FLAGS_CACHED)
@@ -817,7 +827,6 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 {
 	lockdep_assert_held(&srng->lock);
 
-	/* TODO: See if we need a write memory barrier here */
 	if (srng->flags & HAL_SRNG_FLAGS_LMAC_RING) {
 		/* For LMAC rings, ring pointer updates are done through FW and
 		 * hence written to a shared memory location that is read by FW
@@ -825,21 +834,37 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 			srng->u.src_ring.last_tp =
 				*(volatile u32 *)srng->u.src_ring.tp_addr;
-			*srng->u.src_ring.hp_addr = srng->u.src_ring.hp;
+			/* Make sure descriptor is written before updating the
+			 * head pointer.
+			 */
+			dma_wmb();
+			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
 		} else {
 			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
-			*srng->u.dst_ring.tp_addr = srng->u.dst_ring.tp;
+			/* Make sure descriptor is read before updating the
+			 * tail pointer.
+			 */
+			dma_mb();
+			WRITE_ONCE(*srng->u.dst_ring.tp_addr, srng->u.dst_ring.tp);
 		}
 	} else {
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 			srng->u.src_ring.last_tp =
 				*(volatile u32 *)srng->u.src_ring.tp_addr;
+			/* Assume implementation use an MMIO write accessor
+			 * which has the required wmb() so that the descriptor
+			 * is written before the updating the head pointer.
+			 */
 			ath11k_hif_write32(ab,
 					   (unsigned long)srng->u.src_ring.hp_addr -
 					   (unsigned long)ab->mem,
 					   srng->u.src_ring.hp);
 		} else {
 			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
+			/* Make sure descriptor is read before updating the
+			 * tail pointer.
+			 */
+			mb();
 			ath11k_hif_write32(ab,
 					   (unsigned long)srng->u.dst_ring.tp_addr -
 					   (unsigned long)ab->mem,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
index 47c0e8e429e5..3064e603e7e3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -919,7 +919,7 @@ void wlc_lcnphy_read_table(struct brcms_phy *pi, struct phytbl_info *pti)
 
 static void
 wlc_lcnphy_common_read_table(struct brcms_phy *pi, u32 tbl_id,
-			     const u16 *tbl_ptr, u32 tbl_len,
+			     u16 *tbl_ptr, u32 tbl_len,
 			     u32 tbl_width, u32 tbl_offset)
 {
 	struct phytbl_info tab;
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 78dee8ccfebf..1c22a29d20d6 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -1575,8 +1575,11 @@ il4965_tx_cmd_build_rate(struct il_priv *il,
 	    || rate_idx > RATE_COUNT_LEGACY)
 		rate_idx = rate_lowest_index(&il->bands[info->band], sta);
 	/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
-	if (info->band == NL80211_BAND_5GHZ)
+	if (info->band == NL80211_BAND_5GHZ) {
 		rate_idx += IL_FIRST_OFDM_RATE;
+		if (rate_idx > IL_LAST_OFDM_RATE)
+			rate_idx = IL_LAST_OFDM_RATE;
+	}
 	/* Get PLCP rate for tx_cmd->rate_n_flags */
 	rate_plcp = il_rates[rate_idx].plcp;
 	/* Zero out flags for this packet */
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index 4b1f006c105b..2df93078cffe 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -2921,7 +2921,7 @@ static void rs_fill_link_cmd(struct iwl_priv *priv,
 		/* Repeat initial/next rate.
 		 * For legacy IWL_NUMBER_TRY == 1, this loop will not execute.
 		 * For HT IWL_HT_NUMBER_TRY == 3, this executes twice. */
-		while (repeat_rate > 0 && (index < LINK_QUAL_MAX_RETRY_NUM)) {
+		while (repeat_rate > 0 && index < (LINK_QUAL_MAX_RETRY_NUM - 1)) {
 			if (is_legacy(tbl_type.lq_type)) {
 				if (ant_toggle_cnt < NUM_TRY_BEFORE_ANT_TOGGLE)
 					ant_toggle_cnt++;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 4c5dbd8248e7..20db79f34163 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2786,6 +2786,7 @@ int iwl_fw_dbg_collect(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_dump_desc *desc;
 	unsigned int delay = 0;
 	bool monitor_only = false;
+	int ret;
 
 	if (trigger) {
 		u16 occurrences = le16_to_cpu(trigger->occurrences) - 1;
@@ -2816,7 +2817,11 @@ int iwl_fw_dbg_collect(struct iwl_fw_runtime *fwrt,
 	desc->trig_desc.type = cpu_to_le32(trig);
 	memcpy(desc->trig_desc.data, str, len);
 
-	return iwl_fw_dbg_collect_desc(fwrt, desc, monitor_only, delay);
+	ret = iwl_fw_dbg_collect_desc(fwrt, desc, monitor_only, delay);
+	if (ret)
+		kfree(desc);
+
+	return ret;
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_collect);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 2a4c59c71448..1d9798775f8a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -822,7 +822,7 @@ static inline bool iwl_mvm_scan_fits(struct iwl_mvm *mvm, int n_ssids,
 				     int n_channels)
 {
 	return ((n_ssids <= PROBE_OPTION_MAX) &&
-		(n_channels <= mvm->fw->ucode_capa.n_scan_channels) &
+		(n_channels <= mvm->fw->ucode_capa.n_scan_channels) &&
 		(ies->common_ie_len +
 		 ies->len[NL80211_BAND_2GHZ] + ies->len[NL80211_BAND_5GHZ] +
 		 ies->len[NL80211_BAND_6GHZ] <=
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index b423caea2c58..4029e4e590fa 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -573,8 +573,11 @@ static int _rtl_pci_init_one_rxdesc(struct ieee80211_hw *hw,
 		dma_map_single(&rtlpci->pdev->dev, skb_tail_pointer(skb),
 			       rtlpci->rxbuffersize, DMA_FROM_DEVICE);
 	bufferaddress = *((dma_addr_t *)skb->cb);
-	if (dma_mapping_error(&rtlpci->pdev->dev, bufferaddress))
+	if (dma_mapping_error(&rtlpci->pdev->dev, bufferaddress)) {
+		if (!new_skb)
+			kfree_skb(skb);
 		return 0;
+	}
 	rtlpci->rx_ring[rxring_idx].rx_buf[desc_idx] = skb;
 	if (rtlpriv->use_new_trx_flow) {
 		/* skb->cb may be 64 bit address */
@@ -803,13 +806,19 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_hw *hw)
 		skb = new_skb;
 no_new:
 		if (rtlpriv->use_new_trx_flow) {
-			_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)buffer_desc,
-						 rxring_idx,
-						 rtlpci->rx_ring[rxring_idx].idx);
+			if (!_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)buffer_desc,
+						      rxring_idx,
+						      rtlpci->rx_ring[rxring_idx].idx)) {
+				if (new_skb)
+					dev_kfree_skb_any(skb);
+			}
 		} else {
-			_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)pdesc,
-						 rxring_idx,
-						 rtlpci->rx_ring[rxring_idx].idx);
+			if (!_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)pdesc,
+						      rxring_idx,
+						      rtlpci->rx_ring[rxring_idx].idx)) {
+				if (new_skb)
+					dev_kfree_skb_any(skb);
+			}
 			if (rtlpci->rx_ring[rxring_idx].idx ==
 			    rtlpci->rxringcount - 1)
 				rtlpriv->cfg->ops->set_desc(hw, (u8 *)pdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 9e4a02a322ff..ff3a31bf3a87 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1721,6 +1721,9 @@ static enum rtw89_ps_mode rtw89_update_ps_mode(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
+	if (rtwdev->hci.type != RTW89_HCI_TYPE_PCIE)
+		return RTW89_PS_MODE_NONE;
+
 	if (rtw89_disable_ps_mode || !chip->ps_mode_supported ||
 	    RTW89_CHK_FW_FEATURE(NO_DEEP_PS, &rtwdev->fw))
 		return RTW89_PS_MODE_NONE;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0f022a5192ac..977aadfdf997 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2397,13 +2397,18 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const u32 *c2h_reg = chip->c2h_regs;
-	u32 ret;
+	u32 ret, timeout;
 	u8 i, val;
 
 	info->id = RTW89_FWCMD_C2HREG_FUNC_NULL;
 
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		timeout = RTW89_C2H_TIMEOUT_USB;
+	else
+		timeout = RTW89_C2H_TIMEOUT;
+
 	ret = read_poll_timeout_atomic(rtw89_read8, val, val, 1,
-				       RTW89_C2H_TIMEOUT, false, rtwdev,
+				       timeout, false, rtwdev,
 				       chip->c2h_ctrl_reg);
 	if (ret) {
 		rtw89_warn(rtwdev, "c2h reg timeout\n");
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 0047d5d0e9b1..d0f2c5b22513 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -33,6 +33,8 @@ enum rtw89_fw_dl_status {
 #define RTW89_C2HREG_HDR_LEN 2
 #define RTW89_H2CREG_HDR_LEN 2
 #define RTW89_C2H_TIMEOUT 1000000
+#define RTW89_C2H_TIMEOUT_USB 4000
+
 struct rtw89_mac_c2h_info {
 	u8 id;
 	u8 content_len;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 4a1c9e18c530..f15a2c6874cb 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1093,6 +1093,23 @@ void rtw89_mac_notify_wake(struct rtw89_dev *rtwdev)
 	rtw89_mac_send_rpwm(rtwdev, state, true);
 }
 
+static void rtw89_mac_power_switch_boot_mode(struct rtw89_dev *rtwdev)
+{
+	u32 boot_mode;
+
+	if (rtwdev->hci.type != RTW89_HCI_TYPE_USB)
+		return;
+
+	boot_mode = rtw89_read32_mask(rtwdev, R_AX_GPIO_MUXCFG, B_AX_BOOT_MODE);
+	if (!boot_mode)
+		return;
+
+	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFN_ONMAC);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_STATUS1, B_AX_AUTO_WLPON);
+	rtw89_write32_clr(rtwdev, R_AX_GPIO_MUXCFG, B_AX_BOOT_MODE);
+	rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
+}
+
 static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 {
 #define PWR_ACT 1
@@ -1102,6 +1119,8 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 	int ret;
 	u8 val;
 
+	rtw89_mac_power_switch_boot_mode(rtwdev);
+
 	if (on) {
 		cfg_seq = chip->pwr_on_seq;
 		cfg_func = chip->ops->pwr_on_func;
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 0291aff94016..52dd24a6216d 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -157,6 +157,7 @@
 
 #define R_AX_SYS_STATUS1 0x00F4
 #define B_AX_SEL_0XC0_MASK GENMASK(17, 16)
+#define B_AX_AUTO_WLPON BIT(10)
 #define B_AX_PAD_HCI_SEL_V2_MASK GENMASK(5, 3)
 #define MAC_AX_HCI_SEL_SDIO_UART 0
 #define MAC_AX_HCI_SEL_MULTI_USB 1
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 69ef50fb2e1b..74925e166462 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -637,8 +637,6 @@ static int xennet_xdp_xmit_one(struct net_device *dev,
 	tx_stats->packets++;
 	u64_stats_update_end(&tx_stats->syncp);
 
-	xennet_tx_buf_gc(queue);
-
 	return 0;
 }
 
@@ -848,9 +846,6 @@ static netdev_tx_t xennet_start_xmit(struct sk_buff *skb, struct net_device *dev
 	tx_stats->packets++;
 	u64_stats_update_end(&tx_stats->syncp);
 
-	/* Note: It is not safe to access skb after xennet_tx_buf_gc()! */
-	xennet_tx_buf_gc(queue);
-
 	if (!netfront_tx_slot_available(queue))
 		netif_tx_stop_queue(netdev_get_tx_queue(dev, queue->id));
 
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index bd982390e04c..32b82e916b57 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -11,6 +11,7 @@
  * ARM PCI Host generic driver.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitrev.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -43,18 +44,18 @@ static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 }
 
 static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 }
 
 static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
@@ -272,7 +273,7 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 	scale = 3; /* 0.001x */
 	curr = curr / 1000; /* convert to mA */
 	power = (curr * 3300) / 1000; /* milliwatt */
-	while (power > PCIE_RC_CONFIG_DCR_CSPL_LIMIT) {
+	while (power > FIELD_MAX(PCI_EXP_DEVCAP_PWR_VAL)) {
 		if (!scale) {
 			dev_warn(rockchip->dev, "invalid power supply\n");
 			return;
@@ -281,10 +282,10 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 		power = power / 10;
 	}
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCR);
-	status |= (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
-		  (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
+	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
+	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_SCL, scale);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
 }
 
 /**
@@ -312,14 +313,14 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_set_power_limit(rockchip);
 
 	/* Set RC's clock architecture as common clock */
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= PCI_EXP_LNKSTA_SLC << 16;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 	/* Set RC's RCB to 128 */
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= PCI_EXP_LNKCTL_RCB;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 	/* Enable Gen1 training */
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
@@ -341,9 +342,13 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
 		 */
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
+		status &= ~PCI_EXP_LNKCTL2_TLS;
+		status |= PCI_EXP_LNKCTL2_TLS_5_0GT;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 		status |= PCI_EXP_LNKCTL_RL;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 		err = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
 					 status, PCIE_LINK_IS_GEN2(status), 20,
@@ -380,15 +385,15 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 
 	/* Clear L0s from RC's link cap */
 	if (of_property_read_bool(dev->of_node, "aspm-no-l0s")) {
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LINK_CAP);
-		status &= ~PCIE_RC_CONFIG_LINK_CAP_L0S;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LINK_CAP);
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
+		status &= ~PCI_EXP_LNKCAP_ASPM_L0S;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
 	}
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCSR);
-	status &= ~PCIE_RC_CONFIG_DCSR_MPS_MASK;
-	status |= PCIE_RC_CONFIG_DCSR_MPS_256;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
+	status &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	status |= PCI_EXP_DEVCTL_PAYLOAD_256B;
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
 
 	return 0;
 err_power_off_phy:
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 15ee949f2485..049ad984a416 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -144,16 +144,7 @@
 #define PCIE_EP_CONFIG_BASE		0xa00000
 #define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
-#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
-#define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
-#define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
-#define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
-#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
-#define   PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
-#define   PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
-#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
-#define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
-#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
+#define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d4850bdd837f..6f7253d420db 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -646,6 +646,7 @@ void pci_ep_cfs_remove_epf_group(struct config_group *group)
 	if (IS_ERR_OR_NULL(group))
 		return;
 
+	list_del(&group->group_entry);
 	configfs_unregister_default_group(group);
 }
 EXPORT_SYMBOL(pci_ep_cfs_remove_epf_group);
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 7d21f134143c..69d2523249dc 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -343,7 +343,7 @@ static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 	mutex_lock(&pci_epf_mutex);
 	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
 		pci_ep_cfs_remove_epf_group(group);
-	list_del(&driver->epf_group);
+	WARN_ON(!list_empty(&driver->epf_group));
 	mutex_unlock(&pci_epf_mutex);
 }
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 2f5eddf03ac6..75938b67fd24 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -793,13 +793,11 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
 bool pciehp_is_native(struct pci_dev *bridge)
 {
 	const struct pci_host_bridge *host;
-	u32 slot_cap;
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		return false;
 
-	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
-	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
+	if (!bridge->is_pciehp)
 		return false;
 
 	if (pcie_ports_native)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0ac43a23c9f8..d0e587ab23c6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3019,8 +3019,12 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
  * pci_bridge_d3_possible - Is it possible to put the bridge into D3
  * @bridge: Bridge to check
  *
- * This function checks if it is possible to move the bridge to D3.
- * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
+ * Currently we only allow D3 for some PCIe ports and for Thunderbolt.
+ *
+ * Return: Whether it is possible to move the bridge to D3.
+ *
+ * The return value is guaranteed to be constant across the entire lifetime
+ * of the bridge, including its hot-removal.
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03f7550d8982..c37ff0ee53f8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1592,7 +1592,7 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
 	if (reg32 & PCI_EXP_SLTCAP_HPC)
-		pdev->is_hotplug_bridge = 1;
+		pdev->is_hotplug_bridge = pdev->is_pciehp = 1;
 }
 
 static void set_pcie_thunderbolt(struct pci_dev *dev)
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 4a3f5f5b966d..661eb0c1f797 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -417,6 +417,7 @@ static struct irq_chip stm32_gpio_irq_chip = {
 	.irq_set_wake	= irq_chip_set_wake_parent,
 	.irq_request_resources = stm32_gpio_irq_request_resources,
 	.irq_release_resources = stm32_gpio_irq_release_resources,
+	.irq_set_affinity = IS_ENABLED(CONFIG_SMP) ? irq_chip_set_affinity_parent : NULL,
 };
 
 static int stm32_gpio_domain_translate(struct irq_domain *d,
diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index ec733f683f34..fec99cdf6127 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -198,12 +198,14 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	if (!ec_dev->dout)
 		return -ENOMEM;
 
+	lockdep_register_key(&ec_dev->lockdep_key);
 	mutex_init(&ec_dev->lock);
+	lockdep_set_class(&ec_dev->lock, &ec_dev->lockdep_key);
 
 	err = cros_ec_query_all(ec_dev);
 	if (err) {
 		dev_err(dev, "Cannot identify the EC: error %d\n", err);
-		return err;
+		goto exit;
 	}
 
 	if (ec_dev->irq > 0) {
@@ -215,7 +217,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		if (err) {
 			dev_err(dev, "Failed to request IRQ %d: %d\n",
 				ec_dev->irq, err);
-			return err;
+			goto exit;
 		}
 	}
 
@@ -226,7 +228,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	if (IS_ERR(ec_dev->ec)) {
 		dev_err(ec_dev->dev,
 			"Failed to create CrOS EC platform device\n");
-		return PTR_ERR(ec_dev->ec);
+		err = PTR_ERR(ec_dev->ec);
+		goto exit;
 	}
 
 	if (ec_dev->max_passthru) {
@@ -292,6 +295,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 exit:
 	platform_device_unregister(ec_dev->ec);
 	platform_device_unregister(ec_dev->pd);
+	mutex_destroy(&ec_dev->lock);
+	lockdep_unregister_key(&ec_dev->lockdep_key);
 	return err;
 }
 EXPORT_SYMBOL(cros_ec_register);
@@ -306,9 +311,13 @@ EXPORT_SYMBOL(cros_ec_register);
  */
 void cros_ec_unregister(struct cros_ec_device *ec_dev)
 {
-	if (ec_dev->pd)
-		platform_device_unregister(ec_dev->pd);
+	if (ec_dev->mkbp_event_supported)
+		blocking_notifier_chain_unregister(&ec_dev->event_notifier,
+						   &ec_dev->notifier_ready);
+	platform_device_unregister(ec_dev->pd);
 	platform_device_unregister(ec_dev->ec);
+	mutex_destroy(&ec_dev->lock);
+	lockdep_unregister_key(&ec_dev->lockdep_key);
 }
 EXPORT_SYMBOL(cros_ec_unregister);
 
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 51b98f6c7b39..748efa73378c 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1194,8 +1194,8 @@ static int cros_typec_probe(struct platform_device *pdev)
 
 	typec->ec = dev_get_drvdata(pdev->dev.parent);
 	if (!typec->ec) {
-		dev_err(dev, "couldn't find parent EC device\n");
-		return -ENODEV;
+		dev_warn(dev, "couldn't find parent EC device\n");
+		return -EPROBE_DEFER;
 	}
 
 	platform_set_drvdata(pdev, typec);
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 17d74434e604..c0977ffec96c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -544,12 +544,12 @@ static unsigned long __init tpacpi_check_quirks(
 	return 0;
 }
 
-static inline bool __pure __init tpacpi_is_lenovo(void)
+static __always_inline bool __pure __init tpacpi_is_lenovo(void)
 {
 	return thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO;
 }
 
-static inline bool __pure __init tpacpi_is_ibm(void)
+static __always_inline bool __pure __init tpacpi_is_ibm(void)
 {
 	return thinkpad_id.vendor == PCI_VENDOR_ID_IBM;
 }
diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index bf3b6f1aa984..41e1fdbcda16 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -206,8 +206,8 @@ static int pps_gpio_probe(struct platform_device *pdev)
 	}
 
 	/* register IRQ interrupt handler */
-	ret = devm_request_irq(dev, data->irq, pps_gpio_irq_handler,
-			get_irqf_trigger_flags(data), data->info.name, data);
+	ret = request_irq(data->irq, pps_gpio_irq_handler,
+			  get_irqf_trigger_flags(data), data->info.name, data);
 	if (ret) {
 		pps_unregister_source(data->pps);
 		dev_err(dev, "failed to acquire IRQ %d\n", data->irq);
@@ -224,6 +224,7 @@ static int pps_gpio_remove(struct platform_device *pdev)
 {
 	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
 
+	free_irq(data->irq, data);
 	pps_unregister_source(data->pps);
 	del_timer_sync(&data->echo_timer);
 	/* reset echo pin in any case */
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 642c939d4523..e6bcccf87cd6 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -79,7 +79,7 @@ static int ptp_clock_settime(struct posix_clock *pc, const struct timespec64 *tp
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
 
 	if (ptp_clock_freerun(ptp)) {
-		pr_err("ptp: physical clock is free running\n");
+		pr_err_ratelimited("ptp: physical clock is free running\n");
 		return -EBUSY;
 	}
 
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 48eb32d9aae9..081f511cd213 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -204,6 +204,15 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
 		val |= FIELD_PREP(PWM_IMX_TPM_SC_PS, p->prescale);
 		writel(val, tpm->base + PWM_IMX_TPM_SC);
 
+		/*
+		 * if the counter is disabled (CMOD == 0), programming the new
+		 * period length (MOD) will not reset the counter (CNT). If
+		 * CNT.COUNT happens to be bigger than the new MOD value then
+		 * the counter will end up being reset way too late. Therefore,
+		 * manually reset it to 0.
+		 */
+		if (!cmod)
+			writel(0x0, tpm->base + PWM_IMX_TPM_CNT);
 		/*
 		 * set period count:
 		 * if the PWM is disabled (CMOD[1:0] = 2b00), then MOD register
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 27821f57ef6e..192748ea76e0 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -114,6 +114,26 @@ static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
 	writel(value, chip->regs + pwm_mediatek_reg_offset[num] + offset);
 }
 
+static void pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	u32 value;
+
+	value = readl(pc->regs);
+	value |= BIT(pwm->hwpwm);
+	writel(value, pc->regs);
+}
+
+static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	u32 value;
+
+	value = readl(pc->regs);
+	value &= ~BIT(pwm->hwpwm);
+	writel(value, pc->regs);
+}
+
 static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       int duty_ns, int period_ns)
 {
@@ -143,7 +163,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(resolution, clk_rate);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
-	while (cnt_period > 8191) {
+	if (!cnt_period)
+		return -EINVAL;
+
+	while (cnt_period > 8192) {
 		resolution *= 2;
 		clkdiv++;
 		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
@@ -166,9 +189,16 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);
+
 	pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
+	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period - 1);
+
+	if (cnt_duty) {
+		pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty - 1);
+		pwm_mediatek_enable(chip, pwm);
+	} else {
+		pwm_mediatek_disable(chip, pwm);
+	}
 
 out:
 	pwm_mediatek_clk_disable(chip, pwm);
@@ -176,35 +206,6 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
-static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
-	int ret;
-
-	ret = pwm_mediatek_clk_enable(chip, pwm);
-	if (ret < 0)
-		return ret;
-
-	value = readl(pc->regs);
-	value |= BIT(pwm->hwpwm);
-	writel(value, pc->regs);
-
-	return 0;
-}
-
-static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
-
-	value = readl(pc->regs);
-	value &= ~BIT(pwm->hwpwm);
-	writel(value, pc->regs);
-
-	pwm_mediatek_clk_disable(chip, pwm);
-}
-
 static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			      const struct pwm_state *state)
 {
@@ -214,8 +215,10 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 
 	if (!state->enabled) {
-		if (pwm->state.enabled)
+		if (pwm->state.enabled) {
 			pwm_mediatek_disable(chip, pwm);
+			pwm_mediatek_clk_disable(chip, pwm);
+		}
 
 		return 0;
 	}
@@ -225,7 +228,7 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return err;
 
 	if (!pwm->state.enabled)
-		err = pwm_mediatek_enable(chip, pwm);
+		err = pwm_mediatek_clk_enable(chip, pwm);
 
 	return err;
 }
diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index bbaba453383d..ff7acc326f09 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -750,8 +750,8 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv)
 	struct device *dev = priv->dev;
 	int ret;
 
-	/* Remote core is not under control of Linux */
-	if (dcfg->method == IMX_RPROC_NONE)
+	/* Remote core is not under control of Linux or it is managed by SCU API */
+	if (dcfg->method == IMX_RPROC_NONE || dcfg->method == IMX_RPROC_SCU_API)
 		return 0;
 
 	priv->clk = devm_clk_get(dev, NULL);
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 2a52c990d4fe..c561a93af655 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -51,8 +51,8 @@ config RESET_BERLIN
 
 config RESET_BRCMSTB
 	tristate "Broadcom STB reset controller"
-	depends on ARCH_BRCMSTB || COMPILE_TEST
-	default ARCH_BRCMSTB
+	depends on ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
+	default ARCH_BRCMSTB || ARCH_BCM2835
 	help
 	  This enables the reset controller driver for Broadcom STB SoCs using
 	  a SUN_TOP_CTRL_SW_INIT style controller.
@@ -60,11 +60,11 @@ config RESET_BRCMSTB
 config RESET_BRCMSTB_RESCAL
 	tristate "Broadcom STB RESCAL reset controller"
 	depends on HAS_IOMEM
-	depends on ARCH_BRCMSTB || COMPILE_TEST
-	default ARCH_BRCMSTB
+	depends on ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
+	default ARCH_BRCMSTB || ARCH_BCM2835
 	help
 	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
-	  BCM7216.
+	  BCM7216 or the BCM2712.
 
 config RESET_HSDK
 	bool "Synopsys HSDK Reset Driver"
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 73f2dd3af4d4..6d82fb45e9a8 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -273,6 +273,13 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 		if (tmp & DS1340_BIT_OSF)
 			return -EINVAL;
 		break;
+	case ds_1341:
+		ret = regmap_read(ds1307->regmap, DS1337_REG_STATUS, &tmp);
+		if (ret)
+			return ret;
+		if (tmp & DS1337_BIT_OSF)
+			return -EINVAL;
+		break;
 	case ds_1388:
 		ret = regmap_read(ds1307->regmap, DS1388_REG_FLAG, &tmp);
 		if (ret)
@@ -371,6 +378,10 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 		regmap_update_bits(ds1307->regmap, DS1340_REG_FLAG,
 				   DS1340_BIT_OSF, 0);
 		break;
+	case ds_1341:
+		regmap_update_bits(ds1307->regmap, DS1337_REG_STATUS,
+				   DS1337_BIT_OSF, 0);
+		break;
 	case ds_1388:
 		regmap_update_bits(ds1307->regmap, DS1388_REG_FLAG,
 				   DS1388_BIT_OSF, 0);
@@ -1808,10 +1819,8 @@ static int ds1307_probe(struct i2c_client *client,
 		regmap_write(ds1307->regmap, DS1337_REG_CONTROL,
 			     regs[0]);
 
-		/* oscillator fault?  clear flag, and warn */
+		/* oscillator fault? warn */
 		if (regs[1] & DS1337_BIT_OSF) {
-			regmap_write(ds1307->regmap, DS1337_REG_STATUS,
-				     regs[1] & ~DS1337_BIT_OSF);
 			dev_warn(ds1307->dev, "SET TIME!\n");
 		}
 		break;
diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 6572230df346..f8b6812828a9 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -76,6 +76,13 @@ unsigned long sclp_console_full;
 /* The currently active SCLP command word. */
 static sclp_cmdw_t active_cmd;
 
+static inline struct sccb_header *sclpint_to_sccb(u32 sccb_int)
+{
+	if (sccb_int)
+		return __va(sccb_int);
+	return NULL;
+}
+
 static inline void sclp_trace(int prio, char *id, u32 a, u64 b, bool err)
 {
 	struct sclp_trace_entry e;
@@ -625,7 +632,7 @@ __sclp_find_req(u32 sccb)
 
 static bool ok_response(u32 sccb_int, sclp_cmdw_t cmd)
 {
-	struct sccb_header *sccb = (struct sccb_header *)__va(sccb_int);
+	struct sccb_header *sccb = sclpint_to_sccb(sccb_int);
 	struct evbuf_header *evbuf;
 	u16 response;
 
@@ -664,7 +671,7 @@ static void sclp_interrupt_handler(struct ext_code ext_code,
 
 	/* INT: Interrupt received (a=intparm, b=cmd) */
 	sclp_trace_sccb(0, "INT", param32, active_cmd, active_cmd,
-			(struct sccb_header *)__va(finished_sccb),
+			sclpint_to_sccb(finished_sccb),
 			!ok_response(finished_sccb, active_cmd));
 
 	if (finished_sccb) {
diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index 0f64b0244303..31b95e6c96c5 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -481,8 +481,7 @@ void aac_define_int_mode(struct aac_dev *dev)
 	    pci_find_capability(dev->pdev, PCI_CAP_ID_MSIX)) {
 		min_msix = 2;
 		i = pci_alloc_irq_vectors(dev->pdev,
-					  min_msix, msi_count,
-					  PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
+					  min_msix, msi_count, PCI_IRQ_MSIX);
 		if (i > 0) {
 			dev->msi_enabled = 1;
 			msi_count = i;
diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index c335f7a188d2..8f2bd0a6a08c 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -706,6 +706,7 @@ bfad_im_probe(struct bfad_s *bfad)
 
 	if (bfad_thread_workq(bfad) != BFA_STATUS_OK) {
 		kfree(im);
+		bfad->im = NULL;
 		return BFA_STATUS_FAILED;
 	}
 
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 6e811d753cb1..ee4e3feedd10 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -3184,7 +3184,8 @@ iscsi_conn_setup(struct iscsi_cls_session *cls_session, int dd_size,
 		return NULL;
 	conn = cls_conn->dd_data;
 
-	conn->dd_data = cls_conn->dd_data + sizeof(*conn);
+	if (dd_size)
+		conn->dd_data = cls_conn->dd_data + sizeof(*conn);
 	conn->session = session;
 	conn->cls_conn = cls_conn;
 	conn->c_stage = ISCSI_CONN_INITIAL_STAGE;
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 250d423710ca..f149753e62ec 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -6287,7 +6287,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			}
 			phba->nvmeio_trc_on = 1;
 			phba->nvmeio_trc_output_idx = 0;
-			phba->nvmeio_trc = NULL;
 		} else {
 nvmeio_off:
 			phba->nvmeio_trc_size = 0;
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index ed32aa01c711..6d4777a5f3d4 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -390,6 +390,10 @@ lpfc_sli4_vport_delete_fcp_xri_aborted(struct lpfc_vport *vport)
 	if (!(vport->cfg_enable_fc4_type & LPFC_ENABLE_FCP))
 		return;
 
+	/* may be called before queues established if hba_setup fails */
+	if (!phba->sli4_hba.hdwq)
+		return;
+
 	spin_lock_irqsave(&phba->hbalock, iflag);
 	for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
 		qp = &phba->sli4_hba.hdwq[idx];
diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index de6914d57402..ffeadd1e3543 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -1005,6 +1005,8 @@ struct scmd_priv {
  * @logdata_buf: Circular buffer to store log data entries
  * @logdata_buf_idx: Index of entry in buffer to store
  * @logdata_entry_sz: log data entry size
+ * @adm_req_q_bar_writeq_lock: Admin request queue lock
+ * @adm_reply_q_bar_writeq_lock: Admin reply queue lock
  * @pend_large_data_sz: Counter to track pending large data
  * @io_throttle_data_length: I/O size to track in 512b blocks
  * @io_throttle_high: I/O size to start throttle in 512b blocks
@@ -1035,7 +1037,7 @@ struct mpi3mr_ioc {
 	char name[MPI3MR_NAME_LENGTH];
 	char driver_name[MPI3MR_NAME_LENGTH];
 
-	volatile struct mpi3_sysif_registers __iomem *sysif_regs;
+	struct mpi3_sysif_registers __iomem *sysif_regs;
 	resource_size_t sysif_regs_phys;
 	int bars;
 	u64 dma_mask;
@@ -1186,6 +1188,8 @@ struct mpi3mr_ioc {
 	u8 *logdata_buf;
 	u16 logdata_buf_idx;
 	u16 logdata_entry_sz;
+	spinlock_t adm_req_q_bar_writeq_lock;
+	spinlock_t adm_reply_q_bar_writeq_lock;
 
 	atomic_t pend_large_data_sz;
 	u32 io_throttle_data_length;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 015a875a46a1..d50bc6706156 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -23,17 +23,22 @@ module_param(poll_queues, int, 0444);
 MODULE_PARM_DESC(poll_queues, "Number of queues for io_uring poll mode. (Range 1 - 126)");
 
 #if defined(writeq) && defined(CONFIG_64BIT)
-static inline void mpi3mr_writeq(__u64 b, volatile void __iomem *addr)
+static inline void mpi3mr_writeq(__u64 b, void __iomem *addr,
+	spinlock_t *write_queue_lock)
 {
 	writeq(b, addr);
 }
 #else
-static inline void mpi3mr_writeq(__u64 b, volatile void __iomem *addr)
+static inline void mpi3mr_writeq(__u64 b, void __iomem *addr,
+	spinlock_t *write_queue_lock)
 {
 	__u64 data_out = b;
+	unsigned long flags;
 
+	spin_lock_irqsave(write_queue_lock, flags);
 	writel((u32)(data_out), addr);
 	writel((u32)(data_out >> 32), (addr + 4));
+	spin_unlock_irqrestore(write_queue_lock, flags);
 }
 #endif
 
@@ -411,8 +416,8 @@ static void mpi3mr_process_admin_reply_desc(struct mpi3mr_ioc *mrioc,
 				       MPI3MR_SENSE_BUF_SZ);
 			}
 			if (cmdptr->is_waiting) {
-				complete(&cmdptr->done);
 				cmdptr->is_waiting = 0;
+				complete(&cmdptr->done);
 			} else if (cmdptr->callback)
 				cmdptr->callback(mrioc, cmdptr);
 		}
@@ -2662,9 +2667,11 @@ static int mpi3mr_setup_admin_qpair(struct mpi3mr_ioc *mrioc)
 	    (mrioc->num_admin_req);
 	writel(num_admin_entries, &mrioc->sysif_regs->admin_queue_num_entries);
 	mpi3mr_writeq(mrioc->admin_req_dma,
-	    &mrioc->sysif_regs->admin_request_queue_address);
+		&mrioc->sysif_regs->admin_request_queue_address,
+		&mrioc->adm_req_q_bar_writeq_lock);
 	mpi3mr_writeq(mrioc->admin_reply_dma,
-	    &mrioc->sysif_regs->admin_reply_queue_address);
+		&mrioc->sysif_regs->admin_reply_queue_address,
+		&mrioc->adm_reply_q_bar_writeq_lock);
 	writel(mrioc->admin_req_pi, &mrioc->sysif_regs->admin_request_queue_pi);
 	writel(mrioc->admin_reply_ci, &mrioc->sysif_regs->admin_reply_queue_ci);
 	return retval;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 7bd24f71cc38..30c2b9053efe 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -42,6 +42,13 @@ static void mpi3mr_send_event_ack(struct mpi3mr_ioc *mrioc, u8 event,
 
 #define MPI3_EVENT_WAIT_FOR_DEVICES_TO_REFRESH	(0xFFFE)
 
+/*
+ * SAS Log info code for a NCQ collateral abort after an NCQ error:
+ * IOC_LOGINFO_PREFIX_PL | PL_LOGINFO_CODE_SATA_NCQ_FAIL_ALL_CMDS_AFTR_ERR
+ * See: drivers/message/fusion/lsi/mpi_log_sas.h
+ */
+#define IOC_LOGINFO_SATA_NCQ_FAIL_AFTER_ERR	0x31080000
+
 /**
  * mpi3mr_host_tag_for_scmd - Get host tag for a scmd
  * @mrioc: Adapter instance reference
@@ -3211,7 +3218,18 @@ void mpi3mr_process_op_reply_desc(struct mpi3mr_ioc *mrioc,
 		scmd->result = DID_NO_CONNECT << 16;
 		break;
 	case MPI3_IOCSTATUS_SCSI_IOC_TERMINATED:
-		scmd->result = DID_SOFT_ERROR << 16;
+		if (ioc_loginfo == IOC_LOGINFO_SATA_NCQ_FAIL_AFTER_ERR) {
+			/*
+			 * This is a ATA NCQ command aborted due to another NCQ
+			 * command failure. We must retry this command
+			 * immediately but without incrementing its retry
+			 * counter.
+			 */
+			WARN_ON_ONCE(xfer_count != 0);
+			scmd->result = DID_IMM_RETRY << 16;
+		} else {
+			scmd->result = DID_SOFT_ERROR << 16;
+		}
 		break;
 	case MPI3_IOCSTATUS_SCSI_TASK_TERMINATED:
 	case MPI3_IOCSTATUS_SCSI_EXT_TERMINATED:
@@ -4948,6 +4966,8 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	spin_lock_init(&mrioc->tgtdev_lock);
 	spin_lock_init(&mrioc->watchdog_lock);
 	spin_lock_init(&mrioc->chain_buf_lock);
+	spin_lock_init(&mrioc->adm_req_q_bar_writeq_lock);
+	spin_lock_init(&mrioc->adm_reply_q_bar_writeq_lock);
 	spin_lock_init(&mrioc->sas_node_lock);
 
 	INIT_LIST_HEAD(&mrioc->fwevt_list);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index b5b77b82d69f..06c3ab0225d3 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -197,6 +197,14 @@ struct sense_info {
 #define MPT3SAS_PORT_ENABLE_COMPLETE (0xFFFD)
 #define MPT3SAS_ABRT_TASK_SET (0xFFFE)
 #define MPT3SAS_REMOVE_UNRESPONDING_DEVICES (0xFFFF)
+
+/*
+ * SAS Log info code for a NCQ collateral abort after an NCQ error:
+ * IOC_LOGINFO_PREFIX_PL | PL_LOGINFO_CODE_SATA_NCQ_FAIL_ALL_CMDS_AFTR_ERR
+ * See: drivers/message/fusion/lsi/mpi_log_sas.h
+ */
+#define IOC_LOGINFO_SATA_NCQ_FAIL_AFTER_ERR	0x31080000
+
 /**
  * struct fw_event_work - firmware event struct
  * @list: link list framework
@@ -5825,6 +5833,17 @@ _scsih_io_done(struct MPT3SAS_ADAPTER *ioc, u16 smid, u8 msix_index, u32 reply)
 			scmd->result = DID_TRANSPORT_DISRUPTED << 16;
 			goto out;
 		}
+		if (log_info == IOC_LOGINFO_SATA_NCQ_FAIL_AFTER_ERR) {
+			/*
+			 * This is a ATA NCQ command aborted due to another NCQ
+			 * command failure. We must retry this command
+			 * immediately but without incrementing its retry
+			 * counter.
+			 */
+			WARN_ON_ONCE(xfer_cnt != 0);
+			scmd->result = DID_IMM_RETRY << 16;
+			break;
+		}
 		if (log_info == 0x31110630) {
 			if (scmd->retries > 2) {
 				scmd->result = DID_NO_CONNECT << 16;
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 2925823a494a..837ea487cc82 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -6606,6 +6606,8 @@ static struct iscsi_endpoint *qla4xxx_get_ep_fwdb(struct scsi_qla_host *ha,
 
 	ep = qla4xxx_ep_connect(ha->host, (struct sockaddr *)dst_addr, 0);
 	vfree(dst_addr);
+	if (IS_ERR(ep))
+		return NULL;
 	return ep;
 }
 
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 69288303e600..6fb995153abd 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1842,7 +1842,7 @@ int scsi_scan_host_selected(struct Scsi_Host *shost, unsigned int channel,
 
 	return 0;
 }
-
+EXPORT_SYMBOL(scsi_scan_host_selected);
 static void scsi_sysfs_add_devices(struct Scsi_Host *shost)
 {
 	struct scsi_device *sdev;
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 6941d8cfb9ba..5a19de2c7006 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -40,6 +40,8 @@
 #include <scsi/scsi_transport_sas.h>
 
 #include "scsi_sas_internal.h"
+#include "scsi_priv.h"
+
 struct sas_host_attrs {
 	struct list_head rphy_list;
 	struct mutex lock;
@@ -1681,32 +1683,66 @@ int scsi_is_sas_rphy(const struct device *dev)
 }
 EXPORT_SYMBOL(scsi_is_sas_rphy);
 
-
-/*
- * SCSI scan helper
- */
-
-static int sas_user_scan(struct Scsi_Host *shost, uint channel,
-		uint id, u64 lun)
+static void scan_channel_zero(struct Scsi_Host *shost, uint id, u64 lun)
 {
 	struct sas_host_attrs *sas_host = to_sas_host_attrs(shost);
 	struct sas_rphy *rphy;
 
-	mutex_lock(&sas_host->lock);
 	list_for_each_entry(rphy, &sas_host->rphy_list, list) {
 		if (rphy->identify.device_type != SAS_END_DEVICE ||
 		    rphy->scsi_target_id == -1)
 			continue;
 
-		if ((channel == SCAN_WILD_CARD || channel == 0) &&
-		    (id == SCAN_WILD_CARD || id == rphy->scsi_target_id)) {
+		if (id == SCAN_WILD_CARD || id == rphy->scsi_target_id) {
 			scsi_scan_target(&rphy->dev, 0, rphy->scsi_target_id,
 					 lun, SCSI_SCAN_MANUAL);
 		}
 	}
-	mutex_unlock(&sas_host->lock);
+}
 
-	return 0;
+/*
+ * SCSI scan helper
+ */
+
+static int sas_user_scan(struct Scsi_Host *shost, uint channel,
+		uint id, u64 lun)
+{
+	struct sas_host_attrs *sas_host = to_sas_host_attrs(shost);
+	int res = 0;
+	int i;
+
+	switch (channel) {
+	case 0:
+		mutex_lock(&sas_host->lock);
+		scan_channel_zero(shost, id, lun);
+		mutex_unlock(&sas_host->lock);
+		break;
+
+	case SCAN_WILD_CARD:
+		mutex_lock(&sas_host->lock);
+		scan_channel_zero(shost, id, lun);
+		mutex_unlock(&sas_host->lock);
+
+		for (i = 1; i <= shost->max_channel; i++) {
+			res = scsi_scan_host_selected(shost, i, id, lun,
+						      SCSI_SCAN_MANUAL);
+			if (res)
+				goto exit_scan;
+		}
+		break;
+
+	default:
+		if (channel < shost->max_channel) {
+			res = scsi_scan_host_selected(shost, channel, id, lun,
+						      SCSI_SCAN_MANUAL);
+		} else {
+			res = -EINVAL;
+		}
+		break;
+	}
+
+exit_scan:
+	return res;
 }
 
 
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 10235b36d131..fc6fdcd0a5d4 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -17,6 +17,37 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
 
+static bool mdt_header_valid(const struct firmware *fw)
+{
+	const struct elf32_hdr *ehdr;
+	size_t phend;
+	size_t shend;
+
+	if (fw->size < sizeof(*ehdr))
+		return false;
+
+	ehdr = (struct elf32_hdr *)fw->data;
+
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG))
+		return false;
+
+	if (ehdr->e_phentsize != sizeof(struct elf32_phdr))
+		return -EINVAL;
+
+	phend = size_add(size_mul(sizeof(struct elf32_phdr), ehdr->e_phnum), ehdr->e_phoff);
+	if (phend > fw->size)
+		return false;
+
+	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
+		return -EINVAL;
+
+	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
+	if (shend > fw->size)
+		return false;
+
+	return true;
+}
+
 static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
 {
 	if (phdr->p_type != PT_LOAD)
@@ -84,6 +115,9 @@ ssize_t qcom_mdt_get_size(const struct firmware *fw)
 	phys_addr_t max_addr = 0;
 	int i;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -136,6 +170,9 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
 	ssize_t ret;
 	void *data;
 
+	if (!mdt_header_valid(fw))
+		return ERR_PTR(-EINVAL);
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -216,6 +253,9 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 	int ret;
 	int i;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -264,6 +304,26 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_pas_init);
 
+static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char *fw_name)
+{
+	const struct elf32_phdr *phdrs;
+	const struct elf32_hdr *ehdr;
+	uint64_t seg_start, seg_end;
+	int i;
+
+	ehdr = (struct elf32_hdr *)fw->data;
+	phdrs = (struct elf32_phdr *)(ehdr + 1);
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		seg_start = phdrs[i].p_offset;
+		seg_end = phdrs[i].p_offset + phdrs[i].p_filesz;
+		if (seg_start > fw->size || seg_end > fw->size)
+			return true;
+	}
+
+	return false;
+}
+
 static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 			   const char *fw_name, int pas_id, void *mem_region,
 			   phys_addr_t mem_phys, size_t mem_size,
@@ -276,6 +336,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
 	ssize_t offset;
 	bool relocate = false;
+	bool is_split;
 	void *ptr;
 	int ret = 0;
 	int i;
@@ -283,6 +344,10 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	if (!fw || !mem_region || !mem_phys || !mem_size)
 		return -EINVAL;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
+	is_split = qcom_mdt_bins_are_split(fw, fw_name);
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -336,8 +401,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 
 		ptr = mem_region + offset;
 
-		if (phdr->p_filesz && phdr->p_offset < fw->size &&
-		    phdr->p_offset + phdr->p_filesz <= fw->size) {
+		if (phdr->p_filesz && !is_split) {
 			/* Firmware is large enough to be non-split */
 			if (phdr->p_offset + phdr->p_filesz > fw->size) {
 				dev_err(dev, "file %s segment %d would be truncated\n",
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 678e8bc8a45d..4293d269d564 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1224,7 +1224,7 @@ static int tegra_powergate_of_get_clks(struct tegra_powergate *pg,
 }
 
 static int tegra_powergate_of_get_resets(struct tegra_powergate *pg,
-					 struct device_node *np, bool off)
+					 struct device_node *np)
 {
 	struct device *dev = pg->pmc->dev;
 	int err;
@@ -1239,22 +1239,6 @@ static int tegra_powergate_of_get_resets(struct tegra_powergate *pg,
 	err = reset_control_acquire(pg->reset);
 	if (err < 0) {
 		pr_err("failed to acquire resets: %d\n", err);
-		goto out;
-	}
-
-	if (off) {
-		err = reset_control_assert(pg->reset);
-	} else {
-		err = reset_control_deassert(pg->reset);
-		if (err < 0)
-			goto out;
-
-		reset_control_release(pg->reset);
-	}
-
-out:
-	if (err) {
-		reset_control_release(pg->reset);
 		reset_control_put(pg->reset);
 	}
 
@@ -1299,20 +1283,43 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 		goto set_available;
 	}
 
-	err = tegra_powergate_of_get_resets(pg, np, off);
+	err = tegra_powergate_of_get_resets(pg, np);
 	if (err < 0) {
 		dev_err(dev, "failed to get resets for %pOFn: %d\n", np, err);
 		goto remove_clks;
 	}
 
-	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
-		if (off)
-			WARN_ON(tegra_powergate_power_up(pg, true));
+	/*
+	 * If the power-domain is off, then ensure the resets are asserted.
+	 * If the power-domain is on, then power down to ensure that when is
+	 * it turned on the power-domain, clocks and resets are all in the
+	 * expected state.
+	 */
+	if (off) {
+		err = reset_control_assert(pg->reset);
+		if (err) {
+			pr_err("failed to assert resets: %d\n", err);
+			goto remove_resets;
+		}
+	} else {
+		err = tegra_powergate_power_down(pg);
+		if (err) {
+			dev_err(dev, "failed to turn off PM domain %s: %d\n",
+				pg->genpd.name, err);
+			goto remove_resets;
+		}
+	}
 
+	/*
+	 * If PM_GENERIC_DOMAINS is not enabled, power-on
+	 * the domain and skip the genpd registration.
+	 */
+	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
+		WARN_ON(tegra_powergate_power_up(pg, true));
 		goto remove_resets;
 	}
 
-	err = pm_genpd_init(&pg->genpd, NULL, off);
+	err = pm_genpd_init(&pg->genpd, NULL, true);
 	if (err < 0) {
 		dev_err(dev, "failed to initialise PM domain %pOFn: %d\n", np,
 		       err);
diff --git a/drivers/staging/media/imx/imx-media-csc-scaler.c b/drivers/staging/media/imx/imx-media-csc-scaler.c
index 95cca281e8a3..07104e7f5a5f 100644
--- a/drivers/staging/media/imx/imx-media-csc-scaler.c
+++ b/drivers/staging/media/imx/imx-media-csc-scaler.c
@@ -914,7 +914,7 @@ imx_media_csc_scaler_device_init(struct imx_media_dev *md)
 	return &priv->vdev;
 
 err_m2m:
-	video_set_drvdata(vfd, NULL);
+	video_device_release(vfd);
 err_vfd:
 	kfree(priv);
 	return ERR_PTR(ret);
diff --git a/drivers/target/target_core_fabric_lib.c b/drivers/target/target_core_fabric_lib.c
index 6600ae44f29d..d3ab251ba049 100644
--- a/drivers/target/target_core_fabric_lib.c
+++ b/drivers/target/target_core_fabric_lib.c
@@ -257,11 +257,41 @@ static int iscsi_get_pr_transport_id_len(
 	return len;
 }
 
-static char *iscsi_parse_pr_out_transport_id(
+static void sas_parse_pr_out_transport_id(char *buf, char *i_str)
+{
+	char hex[17] = {};
+
+	bin2hex(hex, buf + 4, 8);
+	snprintf(i_str, TRANSPORT_IQN_LEN, "naa.%s", hex);
+}
+
+static void srp_parse_pr_out_transport_id(char *buf, char *i_str)
+{
+	char hex[33] = {};
+
+	bin2hex(hex, buf + 8, 16);
+	snprintf(i_str, TRANSPORT_IQN_LEN, "0x%s", hex);
+}
+
+static void fcp_parse_pr_out_transport_id(char *buf, char *i_str)
+{
+	snprintf(i_str, TRANSPORT_IQN_LEN, "%8phC", buf + 8);
+}
+
+static void sbp_parse_pr_out_transport_id(char *buf, char *i_str)
+{
+	char hex[17] = {};
+
+	bin2hex(hex, buf + 8, 8);
+	snprintf(i_str, TRANSPORT_IQN_LEN, "%s", hex);
+}
+
+static bool iscsi_parse_pr_out_transport_id(
 	struct se_portal_group *se_tpg,
 	char *buf,
 	u32 *out_tid_len,
-	char **port_nexus_ptr)
+	char **port_nexus_ptr,
+	char *i_str)
 {
 	char *p;
 	int i;
@@ -282,7 +312,7 @@ static char *iscsi_parse_pr_out_transport_id(
 	if ((format_code != 0x00) && (format_code != 0x40)) {
 		pr_err("Illegal format code: 0x%02x for iSCSI"
 			" Initiator Transport ID\n", format_code);
-		return NULL;
+		return false;
 	}
 	/*
 	 * If the caller wants the TransportID Length, we set that value for the
@@ -306,7 +336,7 @@ static char *iscsi_parse_pr_out_transport_id(
 			pr_err("Unable to locate \",i,0x\" separator"
 				" for Initiator port identifier: %s\n",
 				&buf[4]);
-			return NULL;
+			return false;
 		}
 		*p = '\0'; /* Terminate iSCSI Name */
 		p += 5; /* Skip over ",i,0x" separator */
@@ -339,7 +369,8 @@ static char *iscsi_parse_pr_out_transport_id(
 	} else
 		*port_nexus_ptr = NULL;
 
-	return &buf[4];
+	strscpy(i_str, &buf[4], TRANSPORT_IQN_LEN);
+	return true;
 }
 
 int target_get_pr_transport_id_len(struct se_node_acl *nacl,
@@ -387,33 +418,35 @@ int target_get_pr_transport_id(struct se_node_acl *nacl,
 	}
 }
 
-const char *target_parse_pr_out_transport_id(struct se_portal_group *tpg,
-		char *buf, u32 *out_tid_len, char **port_nexus_ptr)
+bool target_parse_pr_out_transport_id(struct se_portal_group *tpg,
+		char *buf, u32 *out_tid_len, char **port_nexus_ptr, char *i_str)
 {
-	u32 offset;
-
 	switch (tpg->proto_id) {
 	case SCSI_PROTOCOL_SAS:
 		/*
 		 * Assume the FORMAT CODE 00b from spc4r17, 7.5.4.7 TransportID
 		 * for initiator ports using SCSI over SAS Serial SCSI Protocol.
 		 */
-		offset = 4;
+		sas_parse_pr_out_transport_id(buf, i_str);
 		break;
-	case SCSI_PROTOCOL_SBP:
 	case SCSI_PROTOCOL_SRP:
+		srp_parse_pr_out_transport_id(buf, i_str);
+		break;
 	case SCSI_PROTOCOL_FCP:
-		offset = 8;
+		fcp_parse_pr_out_transport_id(buf, i_str);
+		break;
+	case SCSI_PROTOCOL_SBP:
+		sbp_parse_pr_out_transport_id(buf, i_str);
 		break;
 	case SCSI_PROTOCOL_ISCSI:
 		return iscsi_parse_pr_out_transport_id(tpg, buf, out_tid_len,
-					port_nexus_ptr);
+					port_nexus_ptr, i_str);
 	default:
 		pr_err("Unknown proto_id: 0x%02x\n", tpg->proto_id);
-		return NULL;
+		return false;
 	}
 
 	*port_nexus_ptr = NULL;
 	*out_tid_len = 24;
-	return buf + offset;
+	return true;
 }
diff --git a/drivers/target/target_core_internal.h b/drivers/target/target_core_internal.h
index 85e35cf582e5..84a399a997d8 100644
--- a/drivers/target/target_core_internal.h
+++ b/drivers/target/target_core_internal.h
@@ -104,8 +104,8 @@ int	target_get_pr_transport_id_len(struct se_node_acl *nacl,
 int	target_get_pr_transport_id(struct se_node_acl *nacl,
 		struct t10_pr_registration *pr_reg, int *format_code,
 		unsigned char *buf);
-const char *target_parse_pr_out_transport_id(struct se_portal_group *tpg,
-		char *buf, u32 *out_tid_len, char **port_nexus_ptr);
+bool target_parse_pr_out_transport_id(struct se_portal_group *tpg,
+		char *buf, u32 *out_tid_len, char **port_nexus_ptr, char *i_str);
 
 /* target_core_hba.c */
 struct se_hba *core_alloc_hba(const char *, u32, u32);
diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index a355661e8202..e0a6133bba98 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -1477,11 +1477,12 @@ core_scsi3_decode_spec_i_port(
 	LIST_HEAD(tid_dest_list);
 	struct pr_transport_id_holder *tidh_new, *tidh, *tidh_tmp;
 	unsigned char *buf, *ptr, proto_ident;
-	const unsigned char *i_str = NULL;
+	unsigned char i_str[TRANSPORT_IQN_LEN];
 	char *iport_ptr = NULL, i_buf[PR_REG_ISID_ID_LEN];
 	sense_reason_t ret;
 	u32 tpdl, tid_len = 0;
 	u32 dest_rtpi = 0;
+	bool tid_found;
 
 	/*
 	 * Allocate a struct pr_transport_id_holder and setup the
@@ -1570,9 +1571,9 @@ core_scsi3_decode_spec_i_port(
 			dest_rtpi = tmp_lun->lun_rtpi;
 
 			iport_ptr = NULL;
-			i_str = target_parse_pr_out_transport_id(tmp_tpg,
-					ptr, &tid_len, &iport_ptr);
-			if (!i_str)
+			tid_found = target_parse_pr_out_transport_id(tmp_tpg,
+					ptr, &tid_len, &iport_ptr, i_str);
+			if (!tid_found)
 				continue;
 			/*
 			 * Determine if this SCSI device server requires that
@@ -3152,13 +3153,14 @@ core_scsi3_emulate_pro_register_and_move(struct se_cmd *cmd, u64 res_key,
 	struct t10_pr_registration *pr_reg, *pr_res_holder, *dest_pr_reg;
 	struct t10_reservation *pr_tmpl = &dev->t10_pr;
 	unsigned char *buf;
-	const unsigned char *initiator_str;
+	unsigned char initiator_str[TRANSPORT_IQN_LEN];
 	char *iport_ptr = NULL, i_buf[PR_REG_ISID_ID_LEN] = { };
 	u32 tid_len, tmp_tid_len;
 	int new_reg = 0, type, scope, matching_iname;
 	sense_reason_t ret;
 	unsigned short rtpi;
 	unsigned char proto_ident;
+	bool tid_found;
 
 	if (!se_sess || !se_lun) {
 		pr_err("SPC-3 PR: se_sess || struct se_lun is NULL!\n");
@@ -3277,9 +3279,9 @@ core_scsi3_emulate_pro_register_and_move(struct se_cmd *cmd, u64 res_key,
 		ret = TCM_INVALID_PARAMETER_LIST;
 		goto out;
 	}
-	initiator_str = target_parse_pr_out_transport_id(dest_se_tpg,
-			&buf[24], &tmp_tid_len, &iport_ptr);
-	if (!initiator_str) {
+	tid_found = target_parse_pr_out_transport_id(dest_se_tpg,
+			&buf[24], &tmp_tid_len, &iport_ptr, initiator_str);
+	if (!tid_found) {
 		pr_err("SPC-3 PR REGISTER_AND_MOVE: Unable to locate"
 			" initiator_str from Transport ID\n");
 		ret = TCM_INVALID_PARAMETER_LIST;
diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index ad84978109e6..ccd082bf6fdc 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/bitops.h>
@@ -18,6 +19,7 @@
 #include "../thermal_core.h"
 #include "../thermal_hwmon.h"
 
+#define QPNP_TM_REG_DIG_MINOR		0x00
 #define QPNP_TM_REG_DIG_MAJOR		0x01
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
@@ -33,7 +35,7 @@
 #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
 #define STATUS_GEN2_STATE_SHIFT		4
 
-#define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
+#define SHUTDOWN_CTRL1_OVERRIDE_STAGE2	BIT(6)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
 
 #define SHUTDOWN_CTRL1_RATE_25HZ	BIT(3)
@@ -81,6 +83,7 @@ struct qpnp_tm_chip {
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
 	bool				initialized;
+	bool				require_stage2_shutdown;
 
 	struct iio_channel		*adc;
 	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
@@ -223,13 +226,13 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 {
 	long stage2_threshold_min = (*chip->temp_map)[THRESH_MIN][1];
 	long stage2_threshold_max = (*chip->temp_map)[THRESH_MAX][1];
-	bool disable_s2_shutdown = false;
+	bool disable_stage2_shutdown = false;
 	u8 reg;
 
 	WARN_ON(!mutex_is_locked(&chip->lock));
 
 	/*
-	 * Default: S2 and S3 shutdown enabled, thresholds at
+	 * Default: Stage 2 and Stage 3 shutdown enabled, thresholds at
 	 * lowest threshold set, monitoring at 25Hz
 	 */
 	reg = SHUTDOWN_CTRL1_RATE_25HZ;
@@ -244,12 +247,12 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 		chip->thresh = THRESH_MAX -
 			((stage2_threshold_max - temp) /
 			 TEMP_THRESH_STEP);
-		disable_s2_shutdown = true;
+		disable_stage2_shutdown = true;
 	} else {
 		chip->thresh = THRESH_MAX;
 
 		if (chip->adc)
-			disable_s2_shutdown = true;
+			disable_stage2_shutdown = true;
 		else
 			dev_warn(chip->dev,
 				 "No ADC is configured and critical temperature %d mC is above the maximum stage 2 threshold of %ld mC! Configuring stage 2 shutdown at %ld mC.\n",
@@ -258,8 +261,8 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 
 skip:
 	reg |= chip->thresh;
-	if (disable_s2_shutdown)
-		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
+	if (disable_stage2_shutdown && !chip->require_stage2_shutdown)
+		reg |= SHUTDOWN_CTRL1_OVERRIDE_STAGE2;
 
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
 }
@@ -373,8 +376,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 {
 	struct qpnp_tm_chip *chip;
 	struct device_node *node;
-	u8 type, subtype, dig_major;
-	u32 res;
+	u8 type, subtype, dig_major, dig_minor;
+	u32 res, dig_revision;
 	int ret, irq;
 
 	node = pdev->dev.of_node;
@@ -429,6 +432,11 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MINOR, &dig_minor);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not read dig_minor\n");
+
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
 				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
@@ -442,6 +450,23 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	else
 		chip->temp_map = &temp_map_gen1;
 
+	if (chip->subtype == QPNP_TM_SUBTYPE_GEN2) {
+		dig_revision = (dig_major << 8) | dig_minor;
+		/*
+		 * Check if stage 2 automatic partial shutdown must remain
+		 * enabled to avoid potential repeated faults upon reaching
+		 * over-temperature stage 3.
+		 */
+		switch (dig_revision) {
+		case 0x0001:
+		case 0x0002:
+		case 0x0100:
+		case 0x0101:
+			chip->require_stage2_shutdown = true;
+			break;
+		}
+	}
+
 	/*
 	 * Register the sensor before initializing the hardware to be able to
 	 * read the trip points. get_temp() returns the default temperature
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index bd7596125461..7ee89e99acbf 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -39,10 +39,13 @@ temp_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 	ret = thermal_zone_get_temp(tz, &temperature);
 
-	if (ret)
-		return ret;
+	if (!ret)
+		return sprintf(buf, "%d\n", temperature);
 
-	return sprintf(buf, "%d\n", temperature);
+	if (ret == -EAGAIN)
+		return -ENODATA;
+
+	return ret;
 }
 
 static ssize_t
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index ec7b5f65804e..e1c72a2bf3b5 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -36,7 +36,7 @@ static bool match_service_id(const struct tb_service_id *id,
 			return false;
 	}
 
-	if (id->match_flags & TBSVC_MATCH_PROTOCOL_VERSION) {
+	if (id->match_flags & TBSVC_MATCH_PROTOCOL_REVISION) {
 		if (id->protocol_revision != svc->prtcrevs)
 			return false;
 	}
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c1917774e0bb..c3ab9c1a6a80 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2370,9 +2370,8 @@ int serial8250_do_startup(struct uart_port *port)
 	/*
 	 * Now, initialize the UART
 	 */
-	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
-
 	spin_lock_irqsave(&port->lock, flags);
+	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 	if (up->port.flags & UPF_FOURPORT) {
 		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;
diff --git a/drivers/tty/vt/defkeymap.c_shipped b/drivers/tty/vt/defkeymap.c_shipped
index 0c043e4f292e..6af7bf8d5460 100644
--- a/drivers/tty/vt/defkeymap.c_shipped
+++ b/drivers/tty/vt/defkeymap.c_shipped
@@ -23,6 +23,22 @@ unsigned short plain_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 static unsigned short shift_map[NR_KEYS] = {
@@ -42,6 +58,22 @@ static unsigned short shift_map[NR_KEYS] = {
 	0xf20b,	0xf601,	0xf602,	0xf117,	0xf600,	0xf20a,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 static unsigned short altgr_map[NR_KEYS] = {
@@ -61,6 +93,22 @@ static unsigned short altgr_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 static unsigned short ctrl_map[NR_KEYS] = {
@@ -80,6 +128,22 @@ static unsigned short ctrl_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 static unsigned short shift_ctrl_map[NR_KEYS] = {
@@ -99,6 +163,22 @@ static unsigned short shift_ctrl_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 static unsigned short alt_map[NR_KEYS] = {
@@ -118,6 +198,22 @@ static unsigned short alt_map[NR_KEYS] = {
 	0xf118,	0xf210,	0xf211,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 static unsigned short ctrl_alt_map[NR_KEYS] = {
@@ -137,6 +233,22 @@ static unsigned short ctrl_alt_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf20c,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 unsigned short *key_maps[MAX_NR_KEYMAPS] = {
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index be8313cdbac3..d8ad642655d3 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1496,7 +1496,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 		rc = atomic_notifier_call_chain(&keyboard_notifier_list,
 						KBD_UNICODE, &param);
 		if (rc != NOTIFY_STOP)
-			if (down && !raw_mode)
+			if (down && !(raw_mode || kbd->kbdmode == VC_OFF))
 				k_unicode(vc, keysym, !down);
 		return;
 	}
diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index e981f1f8805f..17db3f8c8c51 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1028,8 +1028,8 @@ static int exynos_ufs_post_link(struct ufs_hba *hba)
 	hci_writel(ufs, 0xa, HCI_DATA_REORDER);
 	hci_writel(ufs, PRDT_SET_SIZE(12), HCI_TXPRDT_ENTRY_SIZE);
 	hci_writel(ufs, PRDT_SET_SIZE(12), HCI_RXPRDT_ENTRY_SIZE);
-	hci_writel(ufs, (1 << hba->nutrs) - 1, HCI_UTRL_NEXUS_TYPE);
-	hci_writel(ufs, (1 << hba->nutmrs) - 1, HCI_UTMRL_NEXUS_TYPE);
+	hci_writel(ufs, BIT(hba->nutrs) - 1, HCI_UTRL_NEXUS_TYPE);
+	hci_writel(ufs, BIT(hba->nutmrs) - 1, HCI_UTMRL_NEXUS_TYPE);
 	hci_writel(ufs, 0xf, HCI_AXIDMA_RWDATA_BURST_LEN);
 
 	if (ufs->opts & EXYNOS_UFS_OPT_SKIP_CONNECTION_ESTAB)
diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 9c911787f84c..c548c726e7f6 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -213,6 +213,32 @@ static int ufs_intel_lkf_apply_dev_quirks(struct ufs_hba *hba)
 	return ret;
 }
 
+static void ufs_intel_ctrl_uic_compl(struct ufs_hba *hba, bool enable)
+{
+	u32 set = ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
+
+	if (enable)
+		set |= UIC_COMMAND_COMPL;
+	else
+		set &= ~UIC_COMMAND_COMPL;
+	ufshcd_writel(hba, set, REG_INTERRUPT_ENABLE);
+}
+
+static void ufs_intel_mtl_h8_notify(struct ufs_hba *hba,
+				    enum uic_cmd_dme cmd,
+				    enum ufs_notify_change_status status)
+{
+	/*
+	 * Disable UIC COMPL INTR to prevent access to UFSHCI after
+	 * checking HCS.UPMCRS
+	 */
+	if (status == PRE_CHANGE && cmd == UIC_CMD_DME_HIBER_ENTER)
+		ufs_intel_ctrl_uic_compl(hba, false);
+
+	if (status == POST_CHANGE && cmd == UIC_CMD_DME_HIBER_EXIT)
+		ufs_intel_ctrl_uic_compl(hba, true);
+}
+
 #define INTEL_ACTIVELTR		0x804
 #define INTEL_IDLELTR		0x808
 
@@ -439,10 +465,23 @@ static int ufs_intel_adl_init(struct ufs_hba *hba)
 	return ufs_intel_common_init(hba);
 }
 
+static void ufs_intel_mtl_late_init(struct ufs_hba *hba)
+{
+	hba->rpm_lvl = UFS_PM_LVL_2;
+	hba->spm_lvl = UFS_PM_LVL_2;
+}
+
 static int ufs_intel_mtl_init(struct ufs_hba *hba)
 {
+	struct ufs_host *ufs_host;
+	int err;
+
 	hba->caps |= UFSHCD_CAP_CRYPTO | UFSHCD_CAP_WB_EN;
-	return ufs_intel_common_init(hba);
+	err = ufs_intel_common_init(hba);
+	/* Get variant after it is set in ufs_intel_common_init() */
+	ufs_host = ufshcd_get_variant(hba);
+	ufs_host->late_init = ufs_intel_mtl_late_init;
+	return err;
 }
 
 static struct ufs_hba_variant_ops ufs_intel_cnl_hba_vops = {
@@ -487,6 +526,7 @@ static struct ufs_hba_variant_ops ufs_intel_mtl_hba_vops = {
 	.init			= ufs_intel_mtl_init,
 	.exit			= ufs_intel_common_exit,
 	.hce_enable_notify	= ufs_intel_hce_enable_notify,
+	.hibern8_notify		= ufs_intel_mtl_h8_notify,
 	.link_startup_notify	= ufs_intel_link_startup_notify,
 	.resume			= ufs_intel_resume,
 	.device_reset		= ufs_intel_device_reset,
diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 1443e9cf631a..db9a8f2731f1 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -980,25 +980,60 @@ static int cxacru_fw(struct usb_device *usb_dev, enum cxacru_fw_request fw,
 	return ret;
 }
 
-static void cxacru_upload_firmware(struct cxacru_data *instance,
-				   const struct firmware *fw,
-				   const struct firmware *bp)
+
+static int cxacru_find_firmware(struct cxacru_data *instance,
+				char *phase, const struct firmware **fw_p)
 {
-	int ret;
+	struct usbatm_data *usbatm = instance->usbatm;
+	struct device *dev = &usbatm->usb_intf->dev;
+	char buf[16];
+
+	sprintf(buf, "cxacru-%s.bin", phase);
+	usb_dbg(usbatm, "cxacru_find_firmware: looking for %s\n", buf);
+
+	if (request_firmware(fw_p, buf, dev)) {
+		usb_dbg(usbatm, "no stage %s firmware found\n", phase);
+		return -ENOENT;
+	}
+
+	usb_info(usbatm, "found firmware %s\n", buf);
+
+	return 0;
+}
+
+static int cxacru_heavy_init(struct usbatm_data *usbatm_instance,
+			     struct usb_interface *usb_intf)
+{
+	const struct firmware *fw, *bp;
+	struct cxacru_data *instance = usbatm_instance->driver_data;
 	struct usbatm_data *usbatm = instance->usbatm;
 	struct usb_device *usb_dev = usbatm->usb_dev;
 	__le16 signature[] = { usb_dev->descriptor.idVendor,
 			       usb_dev->descriptor.idProduct };
 	__le32 val;
+	int ret;
 
-	usb_dbg(usbatm, "%s\n", __func__);
+	ret = cxacru_find_firmware(instance, "fw", &fw);
+	if (ret) {
+		usb_warn(usbatm_instance, "firmware (cxacru-fw.bin) unavailable (system misconfigured?)\n");
+		return ret;
+	}
+
+	if (instance->modem_type->boot_rom_patch) {
+		ret = cxacru_find_firmware(instance, "bp", &bp);
+		if (ret) {
+			usb_warn(usbatm_instance, "boot ROM patch (cxacru-bp.bin) unavailable (system misconfigured?)\n");
+			release_firmware(fw);
+			return ret;
+		}
+	}
 
 	/* FirmwarePllFClkValue */
 	val = cpu_to_le32(instance->modem_type->pll_f_clk);
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, PLLFCLK_ADDR, (u8 *) &val, 4);
 	if (ret) {
 		usb_err(usbatm, "FirmwarePllFClkValue failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* FirmwarePllBClkValue */
@@ -1006,7 +1041,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, PLLBCLK_ADDR, (u8 *) &val, 4);
 	if (ret) {
 		usb_err(usbatm, "FirmwarePllBClkValue failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Enable SDRAM */
@@ -1014,7 +1049,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, SDRAMEN_ADDR, (u8 *) &val, 4);
 	if (ret) {
 		usb_err(usbatm, "Enable SDRAM failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Firmware */
@@ -1022,7 +1057,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, FW_ADDR, fw->data, fw->size);
 	if (ret) {
 		usb_err(usbatm, "Firmware upload failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Boot ROM patch */
@@ -1031,7 +1066,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 		ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, BR_ADDR, bp->data, bp->size);
 		if (ret) {
 			usb_err(usbatm, "Boot ROM patching failed: %d\n", ret);
-			return;
+			goto done;
 		}
 	}
 
@@ -1039,7 +1074,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, SIG_ADDR, (u8 *) signature, 4);
 	if (ret) {
 		usb_err(usbatm, "Signature storing failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	usb_info(usbatm, "starting device\n");
@@ -1051,7 +1086,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	}
 	if (ret) {
 		usb_err(usbatm, "Passing control to firmware failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Delay to allow firmware to start up. */
@@ -1065,53 +1100,10 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_cm(instance, CM_REQUEST_CARD_GET_STATUS, NULL, 0, NULL, 0);
 	if (ret < 0) {
 		usb_err(usbatm, "modem failed to initialize: %d\n", ret);
-		return;
-	}
-}
-
-static int cxacru_find_firmware(struct cxacru_data *instance,
-				char *phase, const struct firmware **fw_p)
-{
-	struct usbatm_data *usbatm = instance->usbatm;
-	struct device *dev = &usbatm->usb_intf->dev;
-	char buf[16];
-
-	sprintf(buf, "cxacru-%s.bin", phase);
-	usb_dbg(usbatm, "cxacru_find_firmware: looking for %s\n", buf);
-
-	if (request_firmware(fw_p, buf, dev)) {
-		usb_dbg(usbatm, "no stage %s firmware found\n", phase);
-		return -ENOENT;
-	}
-
-	usb_info(usbatm, "found firmware %s\n", buf);
-
-	return 0;
-}
-
-static int cxacru_heavy_init(struct usbatm_data *usbatm_instance,
-			     struct usb_interface *usb_intf)
-{
-	const struct firmware *fw, *bp;
-	struct cxacru_data *instance = usbatm_instance->driver_data;
-	int ret = cxacru_find_firmware(instance, "fw", &fw);
-
-	if (ret) {
-		usb_warn(usbatm_instance, "firmware (cxacru-fw.bin) unavailable (system misconfigured?)\n");
-		return ret;
+		goto done;
 	}
 
-	if (instance->modem_type->boot_rom_patch) {
-		ret = cxacru_find_firmware(instance, "bp", &bp);
-		if (ret) {
-			usb_warn(usbatm_instance, "boot ROM patch (cxacru-bp.bin) unavailable (system misconfigured?)\n");
-			release_firmware(fw);
-			return ret;
-		}
-	}
-
-	cxacru_upload_firmware(instance, fw, bp);
-
+done:
 	if (instance->modem_type->boot_rom_patch)
 		release_firmware(bp);
 	release_firmware(fw);
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index ead891de5e1d..ca275933b67a 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1496,6 +1496,12 @@ static int acm_probe(struct usb_interface *intf,
 			goto err_remove_files;
 	}
 
+	if (quirks & CLEAR_HALT_CONDITIONS) {
+		/* errors intentionally ignored */
+		usb_clear_halt(usb_dev, acm->in);
+		usb_clear_halt(usb_dev, acm->out);
+	}
+
 	tty_dev = tty_port_register_device(&acm->port, acm_tty_driver, minor,
 			&control_interface->dev);
 	if (IS_ERR(tty_dev)) {
@@ -1503,11 +1509,6 @@ static int acm_probe(struct usb_interface *intf,
 		goto err_release_data_interface;
 	}
 
-	if (quirks & CLEAR_HALT_CONDITIONS) {
-		usb_clear_halt(usb_dev, acm->in);
-		usb_clear_halt(usb_dev, acm->out);
-	}
-
 	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
 
 	return 0;
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 15613b183fbd..4d9ac04a49cc 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -81,8 +81,14 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 	 */
 	desc = (struct usb_ss_ep_comp_descriptor *) buffer;
 
-	if (desc->bDescriptorType != USB_DT_SS_ENDPOINT_COMP ||
-			size < USB_DT_SS_EP_COMP_SIZE) {
+	if (size < USB_DT_SS_EP_COMP_SIZE) {
+		dev_notice(ddev,
+			   "invalid SuperSpeed endpoint companion descriptor "
+			   "of length %d, skipping\n", size);
+		return;
+	}
+
+	if (desc->bDescriptorType != USB_DT_SS_ENDPOINT_COMP) {
 		dev_notice(ddev, "No SuperSpeed endpoint companion for config %d "
 				" interface %d altsetting %d ep %d: "
 				"using minimum values\n",
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 6af0a31ff147..5440f5584dc0 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2177,7 +2177,7 @@ static struct urb *request_single_step_set_feature_urb(
 	urb->complete = usb_ehset_completion;
 	urb->status = -EINPROGRESS;
 	urb->actual_length = 0;
-	urb->transfer_flags = URB_DIR_IN;
+	urb->transfer_flags = URB_DIR_IN | URB_NO_TRANSFER_DMA_MAP;
 	usb_get_urb(urb);
 	atomic_inc(&urb->use_count);
 	atomic_inc(&urb->dev->urbnum);
@@ -2241,9 +2241,15 @@ int ehset_single_step_set_feature(struct usb_hcd *hcd, int port)
 
 	/* Complete remaining DATA and STATUS stages using the same URB */
 	urb->status = -EINPROGRESS;
+	urb->transfer_flags &= ~URB_NO_TRANSFER_DMA_MAP;
 	usb_get_urb(urb);
 	atomic_inc(&urb->use_count);
 	atomic_inc(&urb->dev->urbnum);
+	if (map_urb_for_dma(hcd, urb, GFP_KERNEL)) {
+		usb_put_urb(urb);
+		goto out1;
+	}
+
 	retval = hcd->driver->submit_single_step_set_feature(hcd, urb, 0);
 	if (!retval && !wait_for_completion_timeout(&done,
 						msecs_to_jiffies(2000))) {
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 46db600fdd82..bfd97cad8aa4 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -371,6 +371,7 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0781, 0x5591), .driver_info = USB_QUIRK_NO_LPM },
 
 	/* SanDisk Corp. SanDisk 3.2Gen1 */
+	{ USB_DEVICE(0x0781, 0x5596), .driver_info = USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x0781, 0x55a3), .driver_info = USB_QUIRK_DELAY_INIT },
 
 	/* SanDisk Extreme 55AE */
diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 9f3c54032556..64f6592b27ce 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -501,7 +501,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 
 	/* Check that the pipe's type matches the endpoint's type */
 	if (usb_pipe_type_check(urb->dev, urb->pipe))
-		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
+		dev_warn_once(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
 			usb_pipetype(urb->pipe), pipetypes[xfertype]);
 
 	/* Check against a simple/standard policy */
diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 174f07614318..d721f45cec9a 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -243,7 +243,7 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 					IRQF_ONESHOT, dev_name(dev), dwc3_imx);
 	if (err) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n", irq, err);
-		goto depopulate;
+		goto put_dwc3;
 	}
 
 	device_set_wakeup_capable(dev, true);
@@ -251,6 +251,8 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 
 	return 0;
 
+put_dwc3:
+	put_device(&dwc3_imx->dwc3->dev);
 depopulate:
 	of_platform_depopulate(dev);
 err_node_put:
@@ -271,6 +273,8 @@ static int dwc3_imx8mp_remove(struct platform_device *pdev)
 	struct dwc3_imx8mp *dwc3_imx = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
 
+	put_device(&dwc3_imx->dwc3->dev);
+
 	pm_runtime_get_sync(dev);
 	of_platform_depopulate(dev);
 
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 10298b91731e..0587ef48de1b 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -847,6 +847,9 @@ static int dwc3_meson_g12a_remove(struct platform_device *pdev)
 	if (priv->drvdata->otg_switch_supported)
 		usb_role_switch_unregister(priv->role_switch);
 
+	put_device(priv->switch_desc.udc);
+	put_device(priv->switch_desc.usb2_port);
+
 	of_platform_depopulate(dev);
 
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index ac6b36ce1f88..547cd1000765 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -286,7 +286,9 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
 			DWC3_TRBCTL_CONTROL_SETUP, false);
 	ret = dwc3_ep0_start_trans(dep);
-	WARN_ON(ret < 0);
+	if (ret < 0)
+		dev_err(dwc->dev, "ep0 out start transfer failed: %d\n", ret);
+
 	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
 		struct dwc3_ep *dwc3_ep;
 
@@ -1058,7 +1060,9 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = dwc3_ep0_start_trans(dep);
 	}
 
-	WARN_ON(ret < 0);
+	if (ret < 0)
+		dev_err(dwc->dev,
+			"ep0 data phase start transfer failed: %d\n", ret);
 }
 
 static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
@@ -1075,7 +1079,12 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
-	WARN_ON(dwc3_ep0_start_control_status(dep));
+	int	ret;
+
+	ret = dwc3_ep0_start_control_status(dep);
+	if (ret)
+		dev_err(dwc->dev,
+			"ep0 status phase start transfer failed: %d\n", ret);
 }
 
 static void dwc3_ep0_do_control_status(struct dwc3 *dwc,
@@ -1118,7 +1127,10 @@ void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
 	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
 	memset(&params, 0, sizeof(params));
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
-	WARN_ON_ONCE(ret);
+	if (ret)
+		dev_err_ratelimited(dwc->dev,
+			"ep0 data phase end transfer failed: %d\n", ret);
+
 	dep->resource_index = 0;
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 53a267550520..97236b42d4ac 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1724,7 +1724,11 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 		dep->flags |= DWC3_EP_DELAY_STOP;
 		return 0;
 	}
-	WARN_ON_ONCE(ret);
+
+	if (ret)
+		dev_err_ratelimited(dep->dwc->dev,
+				"end transfer failed: %d\n", ret);
+
 	dep->resource_index = 0;
 
 	if (!interrupt)
@@ -3590,6 +3594,15 @@ static void dwc3_gadget_endpoint_transfer_complete(struct dwc3_ep *dep,
 static void dwc3_gadget_endpoint_transfer_not_ready(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
+	/*
+	 * During a device-initiated disconnect, a late xferNotReady event can
+	 * be generated after the End Transfer command resets the event filter,
+	 * but before the controller is halted. Ignore it to prevent a new
+	 * transfer from starting.
+	 */
+	if (!dep->dwc->connected)
+		return;
+
 	dwc3_gadget_endpoint_frame_from_event(dep, event);
 
 	/*
@@ -3888,7 +3901,9 @@ static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
 		dep->flags &= ~DWC3_EP_STALL;
 
 		ret = dwc3_send_clear_stall_ep_cmd(dep);
-		WARN_ON_ONCE(ret);
+		if (ret)
+			dev_err_ratelimited(dwc->dev,
+				"failed to clear STALL on %s\n", dep->name);
 	}
 }
 
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 0bbdf82f48cd..f24d63c396df 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2594,6 +2594,7 @@ static int renesas_usb3_remove(struct platform_device *pdev)
 	struct renesas_usb3 *usb3 = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(usb3->dentry);
+	put_device(usb3->host_dev);
 	device_remove_file(&pdev->dev, &dev_attr_role);
 
 	cancel_work_sync(&usb3->role_work);
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 537a0bc0f5e1..57f739f93321 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1200,6 +1200,8 @@ int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *ud
 	ep0_ctx->deq = cpu_to_le64(dev->eps[0].ring->first_seg->dma |
 				   dev->eps[0].ring->cycle_state);
 
+	ep0_ctx->tx_info = cpu_to_le32(EP_AVG_TRB_LENGTH(8));
+
 	trace_xhci_setup_addressable_virt_device(dev);
 
 	/* Steps 7 and 8 were done in xhci_alloc_virt_device() */
diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index 93f8b355bc70..4ceed19c64f0 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -47,8 +47,9 @@
 #define RENESAS_ROM_ERASE_MAGIC				0x5A65726F
 #define RENESAS_ROM_WRITE_MAGIC				0x53524F4D
 
-#define RENESAS_RETRY	10000
-#define RENESAS_DELAY	10
+#define RENESAS_RETRY			50000	/* 50000 * RENESAS_DELAY ~= 500ms */
+#define RENESAS_CHIP_ERASE_RETRY	500000	/* 500000 * RENESAS_DELAY ~= 5s */
+#define RENESAS_DELAY			10
 
 static int renesas_fw_download_image(struct pci_dev *dev,
 				     const u32 *fw, size_t step, bool rom)
@@ -405,7 +406,7 @@ static void renesas_rom_erase(struct pci_dev *pdev)
 	/* sleep a bit while ROM is erased */
 	msleep(20);
 
-	for (i = 0; i < RENESAS_RETRY; i++) {
+	for (i = 0; i < RENESAS_CHIP_ERASE_RETRY; i++) {
 		retval = pci_read_config_byte(pdev, RENESAS_ROM_STATUS,
 					      &status);
 		status &= RENESAS_ROM_STATUS_ERASE;
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 0862fdd3e568..c8e1ead0c09e 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1289,12 +1289,15 @@ static void xhci_kill_endpoint_urbs(struct xhci_hcd *xhci,
  */
 void xhci_hc_died(struct xhci_hcd *xhci)
 {
+	bool notify;
 	int i, j;
 
 	if (xhci->xhc_state & XHCI_STATE_DYING)
 		return;
 
-	xhci_err(xhci, "xHCI host controller not responding, assume dead\n");
+	notify = !(xhci->xhc_state & XHCI_STATE_REMOVING);
+	if (notify)
+		xhci_err(xhci, "xHCI host controller not responding, assume dead\n");
 	xhci->xhc_state |= XHCI_STATE_DYING;
 
 	xhci_cleanup_command_queue(xhci);
@@ -1308,7 +1311,7 @@ void xhci_hc_died(struct xhci_hcd *xhci)
 	}
 
 	/* inform usb core hc died if PCI remove isn't already handling it */
-	if (!(xhci->xhc_state & XHCI_STATE_REMOVING))
+	if (notify)
 		usb_hc_died(xhci_to_hcd(xhci));
 }
 
@@ -4421,7 +4424,8 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 
 	if ((xhci->xhc_state & XHCI_STATE_DYING) ||
 		(xhci->xhc_state & XHCI_STATE_HALTED)) {
-		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command\n");
+		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command. state: 0x%x\n",
+			 xhci->xhc_state);
 		return -ESHUTDOWN;
 	}
 
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index e726c5edee03..a5ce544860b8 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -119,7 +119,8 @@ int xhci_halt(struct xhci_hcd *xhci)
 	ret = xhci_handshake(&xhci->op_regs->status,
 			STS_HALT, STS_HALT, XHCI_MAX_HALT_USEC);
 	if (ret) {
-		xhci_warn(xhci, "Host halt failed, %d\n", ret);
+		if (!(xhci->xhc_state & XHCI_STATE_DYING))
+			xhci_warn(xhci, "Host halt failed, %d\n", ret);
 		return ret;
 	}
 
@@ -178,7 +179,8 @@ int xhci_reset(struct xhci_hcd *xhci, u64 timeout_us)
 	state = readl(&xhci->op_regs->status);
 
 	if (state == ~(u32)0) {
-		xhci_warn(xhci, "Host not accessible, reset failed.\n");
+		if (!(xhci->xhc_state & XHCI_STATE_DYING))
+			xhci_warn(xhci, "Host not accessible, reset failed.\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 44a21ec865fb..b4dd0747aee1 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -400,7 +400,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	ret = platform_device_add_resources(musb, pdev->resource, pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	if (populate_irqs) {
@@ -413,7 +413,7 @@ static int omap2430_probe(struct platform_device *pdev)
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (!res) {
 			ret = -EINVAL;
-			goto err2;
+			goto err_put_control_otghs;
 		}
 
 		musb_res[i].start = res->start;
@@ -441,14 +441,14 @@ static int omap2430_probe(struct platform_device *pdev)
 		ret = platform_device_add_resources(musb, musb_res, i);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to add IRQ resources\n");
-			goto err2;
+			goto err_put_control_otghs;
 		}
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	pm_runtime_enable(glue->dev);
@@ -463,7 +463,9 @@ static int omap2430_probe(struct platform_device *pdev)
 
 err3:
 	pm_runtime_disable(glue->dev);
-
+err_put_control_otghs:
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 err2:
 	platform_device_put(musb);
 
@@ -471,14 +473,14 @@ static int omap2430_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int omap2430_remove(struct platform_device *pdev)
+static void omap2430_remove(struct platform_device *pdev)
 {
 	struct omap2430_glue *glue = platform_get_drvdata(pdev);
 
 	platform_device_unregister(glue->musb);
 	pm_runtime_disable(glue->dev);
-
-	return 0;
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 }
 
 #ifdef CONFIG_PM
@@ -610,7 +612,7 @@ MODULE_DEVICE_TABLE(of, omap2430_id_table);
 
 static struct platform_driver omap2430_driver = {
 	.probe		= omap2430_probe,
-	.remove		= omap2430_remove,
+	.remove_new	= omap2430_remove,
 	.driver		= {
 		.name	= "musb-omap2430",
 		.pm	= DEV_PM_OPS,
diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index 0c423916d7bf..a026c6cb6e68 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -252,7 +252,7 @@ static int rts51x_bulk_transport(struct us_data *us, u8 lun,
 		return USB_STOR_TRANSPORT_ERROR;
 	}
 
-	residue = bcs->Residue;
+	residue = le32_to_cpu(bcs->Residue);
 	if (bcs->Tag != us->tag)
 		return USB_STOR_TRANSPORT_ERROR;
 
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 54f0b1c83317..dfa5276a5a43 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -934,6 +934,13 @@ UNUSUAL_DEV(  0x05e3, 0x0723, 0x9451, 0x9451,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_SANE_SENSE ),
 
+/* Added by Maël GUERIN <mael.guerin@murena.io> */
+UNUSUAL_DEV(  0x0603, 0x8611, 0x0000, 0xffff,
+		"Novatek",
+		"NTK96550-based camera",
+		USB_SC_SCSI, USB_PR_BULK, NULL,
+		US_FL_BULK_IGNORE_TAG ),
+
 /*
  * Reported by Hanno Boeck <hanno@gmx.de>
  * Taken from the Lycoris Kernel
@@ -1494,6 +1501,28 @@ UNUSUAL_DEV( 0x0bc2, 0x3332, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_WP_DETECT ),
 
+/*
+ * Reported by Zenm Chen <zenmchen@gmail.com>
+ * Ignore driver CD mode, otherwise usb_modeswitch may fail to switch
+ * the device into Wi-Fi mode.
+ */
+UNUSUAL_DEV( 0x0bda, 0x1a2b, 0x0000, 0xffff,
+		"Realtek",
+		"DISK",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_DEVICE ),
+
+/*
+ * Reported by Zenm Chen <zenmchen@gmail.com>
+ * Ignore driver CD mode, otherwise usb_modeswitch may fail to switch
+ * the device into Wi-Fi mode.
+ */
+UNUSUAL_DEV( 0x0bda, 0xa192, 0x0000, 0xffff,
+		"Realtek",
+		"DISK",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_DEVICE ),
+
 UNUSUAL_DEV(  0x0d49, 0x7310, 0x0000, 0x9999,
 		"Maxtor",
 		"USB to SATA",
diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 87e2c9130607..a6936fc59d1e 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -667,7 +667,7 @@ static int pmc_usb_probe(struct platform_device *pdev)
 
 	pmc->ipc = devm_intel_scu_ipc_dev_get(&pdev->dev);
 	if (!pmc->ipc)
-		return -ENODEV;
+		return -EPROBE_DEFER;
 
 	pmc->dev = &pdev->dev;
 
diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 721b2a548084..ded3f6fe8b00 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -103,6 +103,7 @@ struct fusb302_chip {
 	bool vconn_on;
 	bool vbus_on;
 	bool charge_on;
+	bool pd_rx_on;
 	bool vbus_present;
 	enum typec_cc_polarity cc_polarity;
 	enum typec_cc_status cc1;
@@ -841,6 +842,11 @@ static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
 	int ret = 0;
 
 	mutex_lock(&chip->lock);
+	if (chip->pd_rx_on == on) {
+		fusb302_log(chip, "pd is already %s", str_on_off(on));
+		goto done;
+	}
+
 	ret = fusb302_pd_rx_flush(chip);
 	if (ret < 0) {
 		fusb302_log(chip, "cannot flush pd rx buffer, ret=%d", ret);
@@ -863,6 +869,8 @@ static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
 			    on ? "on" : "off", ret);
 		goto done;
 	}
+
+	chip->pd_rx_on = on;
 	fusb302_log(chip, "pd := %s", on ? "on" : "off");
 done:
 	mutex_unlock(&chip->lock);
diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index b35c6e07911e..9b0157063df0 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -163,7 +163,7 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 	case UCSI_CONSTAT_PWR_OPMODE_DEFAULT:
 	/* UCSI can't tell b/w DCP/CDP or USB2/3x1/3x2 SDP chargers */
 	default:
-		val->intval = 0;
+		val->intval = UCSI_TYPEC_DEFAULT_CURRENT * 1000;
 		break;
 	}
 	return 0;
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 2a03bb992806..c26b5aae11fb 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -806,6 +806,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	if (con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
 		typec_set_pwr_role(con->port, role);
+		ucsi_port_psy_changed(con);
 
 		/* Complete pending power role swap */
 		if (!completion_done(&con->complete))
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 793a8307dded..0167239cdcd4 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -313,9 +313,10 @@ struct ucsi {
 #define UCSI_MAX_SVID		5
 #define UCSI_MAX_ALTMODES	(UCSI_MAX_SVID * 6)
 
-#define UCSI_TYPEC_VSAFE5V	5000
-#define UCSI_TYPEC_1_5_CURRENT	1500
-#define UCSI_TYPEC_3_0_CURRENT	3000
+#define UCSI_TYPEC_VSAFE5V		5000
+#define UCSI_TYPEC_DEFAULT_CURRENT	 100
+#define UCSI_TYPEC_1_5_CURRENT		1500
+#define UCSI_TYPEC_3_0_CURRENT		3000
 
 struct ucsi_connector {
 	int num;
diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index 3f93b5c3f099..06794c48170c 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -1127,8 +1127,8 @@ int mlx5vf_start_page_tracker(struct vfio_device *vdev,
 	log_max_msg_size = MLX5_CAP_ADV_VIRTUALIZATION(mdev, pg_track_log_max_msg_size);
 	max_msg_size = (1ULL << log_max_msg_size);
 	/* The RQ must hold at least 4 WQEs/messages for successful QP creation */
-	if (rq_size < 4 * max_msg_size)
-		rq_size = 4 * max_msg_size;
+	if (rq_size < 4ULL * max_msg_size)
+		rq_size = 4ULL * max_msg_size;
 
 	memset(tracker, 0, sizeof(*tracker));
 	tracker->uar = mlx5_get_uars_page(mdev);
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 26fac124231f..888f7eeb3d6a 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -692,6 +692,13 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 
 	while (npage) {
 		if (!batch->size) {
+			/*
+			 * Large mappings may take a while to repeatedly refill
+			 * the batch, so conditionally relinquish the CPU when
+			 * needed to avoid stalls.
+			 */
+			cond_resched();
+
 			/* Empty batch, so refill it. */
 			long req_pages = min_t(long, npage, batch->capacity);
 
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 1b00ed5ef1cf..0db46b016004 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2426,6 +2426,9 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 	}
 	r = __vhost_add_used_n(vq, heads, count);
 
+	if (r < 0)
+		return r;
+
 	/* Make sure buffer is written before we update index. */
 	smp_wmb();
 	if (vhost_put_used_idx(vq)) {
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index c00f5821d6ec..1c5096c44fd7 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -340,6 +340,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 
 	len = iov_length(vq->iov, out);
 
+	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
+		return NULL;
+
 	/* len contains both payload and hdr */
 	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
 	if (!skb)
@@ -363,8 +366,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return skb;
 
 	/* The pkt is too big or the length in the header is invalid */
-	if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
-	    payload_len + sizeof(*hdr) > len) {
+	if (payload_len + sizeof(*hdr) > len) {
 		kfree_skb(skb);
 		return NULL;
 	}
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 81f27cd61027..37705290c5a5 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1149,7 +1149,7 @@ static bool vgacon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
 				     c->vc_screenbuf_size - delta);
 			c->vc_origin = vga_vram_end - c->vc_screenbuf_size;
 			vga_rolled_over = 0;
-		} else if (oldo - delta >= (unsigned long)c->vc_screenbuf)
+		} else
 			c->vc_origin -= delta;
 		c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
 		scr_memsetw((u16 *) (c->vc_origin), c->vc_video_erase_char,
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 194889e1cc34..8882c6d7c7a5 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -808,7 +808,8 @@ static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
 				   fg_vc->vc_rows);
 	}
 
-	update_screen(vc_cons[fg_console].d);
+	if (fg_console != unit)
+		update_screen(vc_cons[fg_console].d);
 }
 
 /**
@@ -1353,6 +1354,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	struct vc_data *svc;
 	struct fbcon_ops *ops = info->fbcon_par;
 	int rows, cols;
+	unsigned long ret = 0;
 
 	p = &fb_display[unit];
 
@@ -1403,11 +1405,10 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
 	cols /= vc->vc_font.width;
 	rows /= vc->vc_font.height;
-	vc_resize(vc, cols, rows);
+	ret = vc_resize(vc, cols, rows);
 
-	if (con_is_visible(vc)) {
+	if (con_is_visible(vc) && !ret)
 		update_screen(vc);
-	}
 }
 
 static __inline__ void ywrap_up(struct vc_data *vc, int count)
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index f8c32c58b5b2..5128ffed6a23 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1549,6 +1549,9 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 		if (!registered_fb[i])
 			break;
 
+	if (i >= FB_MAX)
+		return -ENXIO;
+
 	if (!fb_info->modelist.prev || !fb_info->modelist.next)
 		INIT_LIST_HEAD(&fb_info->modelist);
 
diff --git a/drivers/virt/coco/efi_secret/efi_secret.c b/drivers/virt/coco/efi_secret/efi_secret.c
index e700a5ef7043..d996feb0509a 100644
--- a/drivers/virt/coco/efi_secret/efi_secret.c
+++ b/drivers/virt/coco/efi_secret/efi_secret.c
@@ -136,15 +136,7 @@ static int efi_secret_unlink(struct inode *dir, struct dentry *dentry)
 		if (s->fs_files[i] == dentry)
 			s->fs_files[i] = NULL;
 
-	/*
-	 * securityfs_remove tries to lock the directory's inode, but we reach
-	 * the unlink callback when it's already locked
-	 */
-	inode_unlock(dir);
-	securityfs_remove(dentry);
-	inode_lock(dir);
-
-	return 0;
+	return simple_unlink(inode, dentry);
 }
 
 static const struct inode_operations efi_secret_dir_inode_operations = {
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 61af5d1332ac..e3e09dc38c65 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -658,6 +658,8 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	} else {
 		wdd->timeout = DW_WDT_DEFAULT_SECONDS;
 		watchdog_init_timeout(wdd, 0, dev);
+		/* Limit timeout value to hardware constraints. */
+		dw_wdt_set_timeout(wdd, wdd->timeout);
 	}
 
 	platform_set_drvdata(pdev, dw_wdt);
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 35ae40b35f55..75fb7cf7325b 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -601,7 +601,11 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	/* Check that the heartbeat value is within it's range;
 	   if not reset to the default */
 	if (iTCO_wdt_set_timeout(&p->wddev, heartbeat)) {
-		iTCO_wdt_set_timeout(&p->wddev, WATCHDOG_TIMEOUT);
+		ret = iTCO_wdt_set_timeout(&p->wddev, WATCHDOG_TIMEOUT);
+		if (ret != 0) {
+			dev_err(dev, "Failed to set watchdog timeout (%d)\n", WATCHDOG_TIMEOUT);
+			return ret;
+		}
 		dev_info(dev, "timeout value out of range, using %d\n",
 			WATCHDOG_TIMEOUT);
 	}
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 7bf28545b47a..f07ffc7b8312 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -76,11 +76,17 @@
 #define SBSA_GWDT_VERSION_MASK  0xF
 #define SBSA_GWDT_VERSION_SHIFT 16
 
+#define SBSA_GWDT_IMPL_MASK	0x7FF
+#define SBSA_GWDT_IMPL_SHIFT	0
+#define SBSA_GWDT_IMPL_MEDIATEK	0x426
+
 /**
  * struct sbsa_gwdt - Internal representation of the SBSA GWDT
  * @wdd:		kernel watchdog_device structure
  * @clk:		store the System Counter clock frequency, in Hz.
  * @version:            store the architecture version
+ * @need_ws0_race_workaround:
+ *			indicate whether to adjust wdd->timeout to avoid a race with WS0
  * @refresh_base:	Virtual address of the watchdog refresh frame
  * @control_base:	Virtual address of the watchdog control frame
  */
@@ -88,6 +94,7 @@ struct sbsa_gwdt {
 	struct watchdog_device	wdd;
 	u32			clk;
 	int			version;
+	bool			need_ws0_race_workaround;
 	void __iomem		*refresh_base;
 	void __iomem		*control_base;
 };
@@ -162,6 +169,31 @@ static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
 		 */
 		sbsa_gwdt_reg_write(((u64)gwdt->clk / 2) * timeout, gwdt);
 
+	/*
+	 * Some watchdog hardware has a race condition where it will ignore
+	 * sbsa_gwdt_keepalive() if it is called at the exact moment that a
+	 * timeout occurs and WS0 is being asserted. Unfortunately, the default
+	 * behavior of the watchdog core is very likely to trigger this race
+	 * when action=0 because it programs WOR to be half of the desired
+	 * timeout, and watchdog_next_keepalive() chooses the exact same time to
+	 * send keepalive pings.
+	 *
+	 * This triggers a race where sbsa_gwdt_keepalive() can be called right
+	 * as WS0 is being asserted, and affected hardware will ignore that
+	 * write and continue to assert WS0. After another (timeout / 2)
+	 * seconds, the same race happens again. If the driver wins then the
+	 * explicit refresh will reset WS0 to false but if the hardware wins,
+	 * then WS1 is asserted and the system resets.
+	 *
+	 * Avoid the problem by scheduling keepalive heartbeats one second later
+	 * than the WOR timeout.
+	 *
+	 * This workaround might not be needed in a future revision of the
+	 * hardware.
+	 */
+	if (gwdt->need_ws0_race_workaround)
+		wdd->min_hw_heartbeat_ms = timeout * 500 + 1000;
+
 	return 0;
 }
 
@@ -203,12 +235,15 @@ static int sbsa_gwdt_keepalive(struct watchdog_device *wdd)
 static void sbsa_gwdt_get_version(struct watchdog_device *wdd)
 {
 	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
-	int ver;
+	int iidr, ver, impl;
 
-	ver = readl(gwdt->control_base + SBSA_GWDT_W_IIDR);
-	ver = (ver >> SBSA_GWDT_VERSION_SHIFT) & SBSA_GWDT_VERSION_MASK;
+	iidr = readl(gwdt->control_base + SBSA_GWDT_W_IIDR);
+	ver = (iidr >> SBSA_GWDT_VERSION_SHIFT) & SBSA_GWDT_VERSION_MASK;
+	impl = (iidr >> SBSA_GWDT_IMPL_SHIFT) & SBSA_GWDT_IMPL_MASK;
 
 	gwdt->version = ver;
+	gwdt->need_ws0_race_workaround =
+		!action && (impl == SBSA_GWDT_IMPL_MEDIATEK);
 }
 
 static int sbsa_gwdt_start(struct watchdog_device *wdd)
@@ -300,6 +335,15 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	else
 		wdd->max_hw_heartbeat_ms = GENMASK_ULL(47, 0) / gwdt->clk * 1000;
 
+	if (gwdt->need_ws0_race_workaround) {
+		/*
+		 * A timeout of 3 seconds means that WOR will be set to 1.5
+		 * seconds and the heartbeat will be scheduled every 2.5
+		 * seconds.
+		 */
+		wdd->min_timeout = 3;
+	}
+
 	status = readl(cf_base + SBSA_GWDT_WCS);
 	if (status & SBSA_GWDT_WCS_WS1) {
 		dev_warn(dev, "System reset by WDT.\n");
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 91440ef79a26..3295fb978a35 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -46,6 +46,19 @@ static u64 get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
 	return target;
 }
 
+static inline bool has_unwritten_metadata(struct btrfs_block_group *block_group)
+{
+	/* The meta_write_pointer is available only on the zoned setup. */
+	if (!btrfs_is_zoned(block_group->fs_info))
+		return false;
+
+	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA)
+		return false;
+
+	return block_group->start + block_group->alloc_offset >
+		block_group->meta_write_pointer;
+}
+
 /*
  * @flags: available profiles in extended format (see ctree.h)
  *
@@ -1091,6 +1104,15 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		goto out;
 
 	spin_lock(&block_group->lock);
+	/*
+	 * Hitting this WARN means we removed a block group with an unwritten
+	 * region. It will cause "unable to find chunk map for logical" errors.
+	 */
+	if (WARN_ON(has_unwritten_metadata(block_group)))
+		btrfs_warn(fs_info,
+			   "block group %llu is removed before metadata write out",
+			   block_group->start);
+
 	set_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags);
 
 	/*
@@ -1414,8 +1436,9 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		 * needing to allocate extents from the block group.
 		 */
 		used = btrfs_space_info_used(space_info, true);
-		if (space_info->total_bytes - block_group->length < used &&
-		    block_group->zone_unusable < block_group->length) {
+		if ((space_info->total_bytes - block_group->length < used &&
+		     block_group->zone_unusable < block_group->length) ||
+		    has_unwritten_metadata(block_group)) {
 			/*
 			 * Add a reference for the list, compensate for the ref
 			 * drop under the "next" label for the
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index c7171b286de7..9620bf289f78 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -237,7 +237,14 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 
 	write_extent_buffer_fsid(cow, fs_info->fs_devices->metadata_uuid);
 
-	WARN_ON(btrfs_header_generation(buf) > trans->transid);
+	if (unlikely(btrfs_header_generation(buf) > trans->transid)) {
+		btrfs_tree_unlock(cow);
+		free_extent_buffer(cow);
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
 	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID)
 		ret = btrfs_inc_ref(trans, root, cow, 1);
 	else
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1b2af4785c0e..69fd4f9d840b 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -173,9 +173,10 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 	struct btrfs_ordered_extent *entry;
 	int ret;
 	u64 qgroup_rsv = 0;
+	const bool is_nocow = (flags &
+	       ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)));
 
-	if (flags &
-	    ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC))) {
+	if (is_nocow) {
 		/* For nocow write, we can release the qgroup rsv right now */
 		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
 		if (ret < 0)
@@ -191,8 +192,13 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			return ret;
 	}
 	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
-	if (!entry)
+	if (!entry) {
+		if (!is_nocow)
+			btrfs_qgroup_free_refroot(inode->root->fs_info,
+						  btrfs_root_id(inode->root),
+						  qgroup_rsv, BTRFS_QGROUP_RSV_DATA);
 		return -ENOMEM;
+	}
 
 	entry->file_offset = file_offset;
 	entry->num_bytes = num_bytes;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 59bb9653615e..c95902bf6144 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -573,22 +573,30 @@ bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info)
 
 /*
  * This is called from close_ctree() or open_ctree() or btrfs_quota_disable(),
- * first two are in single-threaded paths.And for the third one, we have set
- * quota_root to be null with qgroup_lock held before, so it is safe to clean
- * up the in-memory structures without qgroup_lock held.
+ * first two are in single-threaded paths.
  */
 void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
 {
 	struct rb_node *n;
 	struct btrfs_qgroup *qgroup;
 
+	/*
+	 * btrfs_quota_disable() can be called concurrently with
+	 * btrfs_qgroup_rescan() -> qgroup_rescan_zero_tracking(), so take the
+	 * lock.
+	 */
+	spin_lock(&fs_info->qgroup_lock);
 	while ((n = rb_first(&fs_info->qgroup_tree))) {
 		qgroup = rb_entry(n, struct btrfs_qgroup, node);
 		rb_erase(n, &fs_info->qgroup_tree);
 		__del_qgroup_rb(fs_info, qgroup);
+		spin_unlock(&fs_info->qgroup_lock);
 		btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
 		kfree(qgroup);
+		spin_lock(&fs_info->qgroup_lock);
 	}
+	spin_unlock(&fs_info->qgroup_lock);
+
 	/*
 	 * We call btrfs_free_qgroup_config() when unmounting
 	 * filesystem and disabling quota, so we set qgroup_ulist
@@ -3597,12 +3605,21 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
 	qgroup_rescan_zero_tracking(fs_info);
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	fs_info->qgroup_rescan_running = true;
-	btrfs_queue_work(fs_info->qgroup_rescan_workers,
-			 &fs_info->qgroup_rescan_work);
+	/*
+	 * The rescan worker is only for full accounting qgroups, check if it's
+	 * enabled as it is pointless to queue it otherwise. A concurrent quota
+	 * disable may also have just cleared BTRFS_FS_QUOTA_ENABLED.
+	 */
+	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
+		fs_info->qgroup_rescan_running = true;
+		btrfs_queue_work(fs_info->qgroup_rescan_workers,
+				 &fs_info->qgroup_rescan_work);
+	} else {
+		ret = -ENOTCONN;
+	}
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
-	return 0;
+	return ret;
 }
 
 int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index fd6ea3fcab33..46eddca596ae 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -751,6 +751,25 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 	if (root->root_key.objectid == objectid) {
 		u64 commit_root_gen;
 
+		/*
+		 * Relocation will wait for cleaner thread, and any half-dropped
+		 * subvolume will be fully cleaned up at mount time.
+		 * So here we shouldn't hit a subvolume with non-zero drop_progress.
+		 *
+		 * If this isn't the case, error out since it can make us attempt to
+		 * drop references for extents that were already dropped before.
+		 */
+		if (unlikely(btrfs_disk_key_objectid(&root->root_item.drop_progress))) {
+			struct btrfs_key cpu_key;
+
+			btrfs_disk_key_to_cpu(&cpu_key, &root->root_item.drop_progress);
+			btrfs_err(fs_info,
+	"cannot relocate partially dropped subvolume %llu, drop progress key (%llu %u %llu)",
+				  objectid, cpu_key.objectid, cpu_key.type, cpu_key.offset);
+			ret = -EUCLEAN;
+			goto fail;
+		}
+
 		/* called by btrfs_init_reloc_root */
 		ret = btrfs_copy_root(trans, root, root->commit_root, &eb,
 				      BTRFS_TREE_RELOC_OBJECTID);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 0735decec99b..f5a9f6689c46 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bsearch.h>
+#include <linux/falloc.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/sort.h>
@@ -5231,6 +5232,36 @@ static int send_update_extent(struct send_ctx *sctx,
 	return ret;
 }
 
+static int send_fallocate(struct send_ctx *sctx, u32 mode, u64 offset, u64 len)
+{
+	struct fs_path *p;
+	int ret;
+
+	p = fs_path_alloc();
+	if (!p)
+		return -ENOMEM;
+
+	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
+	if (ret < 0)
+		goto out;
+
+	ret = begin_cmd(sctx, BTRFS_SEND_C_FALLOCATE);
+	if (ret < 0)
+		goto out;
+
+	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
+	TLV_PUT_U32(sctx, BTRFS_SEND_A_FALLOCATE_MODE, mode);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_SIZE, len);
+
+	ret = send_cmd(sctx);
+
+tlv_put_failure:
+out:
+	fs_path_free(p);
+	return ret;
+}
+
 static int send_hole(struct send_ctx *sctx, u64 end)
 {
 	struct fs_path *p = NULL;
@@ -5238,6 +5269,14 @@ static int send_hole(struct send_ctx *sctx, u64 end)
 	u64 offset = sctx->cur_inode_last_extent;
 	int ret = 0;
 
+	/*
+	 * Starting with send stream v2 we have fallocate and can use it to
+	 * punch holes instead of sending writes full of zeroes.
+	 */
+	if (proto_cmd_ok(sctx, BTRFS_SEND_C_FALLOCATE))
+		return send_fallocate(sctx, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				      offset, end - offset);
+
 	/*
 	 * A hole that starts at EOF or beyond it. Since we do not yet support
 	 * fallocate (for extent preallocation and hole punching), sending a
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 982dc92bdf1d..de2b22a56c06 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -298,8 +298,7 @@ struct walk_control {
 
 	/*
 	 * Ignore any items from the inode currently being processed. Needs
-	 * to be set every time we find a BTRFS_INODE_ITEM_KEY and we are in
-	 * the LOG_WALK_REPLAY_INODES stage.
+	 * to be set every time we find a BTRFS_INODE_ITEM_KEY.
 	 */
 	bool ignore_cur_inode;
 
@@ -2427,23 +2426,30 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 
 	nritems = btrfs_header_nritems(eb);
 	for (i = 0; i < nritems; i++) {
-		btrfs_item_key_to_cpu(eb, &key, i);
+		struct btrfs_inode_item *inode_item;
 
-		/* inode keys are done during the first stage */
-		if (key.type == BTRFS_INODE_ITEM_KEY &&
-		    wc->stage == LOG_WALK_REPLAY_INODES) {
-			struct btrfs_inode_item *inode_item;
-			u32 mode;
+		btrfs_item_key_to_cpu(eb, &key, i);
 
-			inode_item = btrfs_item_ptr(eb, i,
-					    struct btrfs_inode_item);
+		if (key.type == BTRFS_INODE_ITEM_KEY) {
+			inode_item = btrfs_item_ptr(eb, i, struct btrfs_inode_item);
 			/*
-			 * If we have a tmpfile (O_TMPFILE) that got fsync'ed
-			 * and never got linked before the fsync, skip it, as
-			 * replaying it is pointless since it would be deleted
-			 * later. We skip logging tmpfiles, but it's always
-			 * possible we are replaying a log created with a kernel
-			 * that used to log tmpfiles.
+			 * An inode with no links is either:
+			 *
+			 * 1) A tmpfile (O_TMPFILE) that got fsync'ed and never
+			 *    got linked before the fsync, skip it, as replaying
+			 *    it is pointless since it would be deleted later.
+			 *    We skip logging tmpfiles, but it's always possible
+			 *    we are replaying a log created with a kernel that
+			 *    used to log tmpfiles;
+			 *
+			 * 2) A non-tmpfile which got its last link deleted
+			 *    while holding an open fd on it and later got
+			 *    fsynced through that fd. We always log the
+			 *    parent inodes when inode->last_unlink_trans is
+			 *    set to the current transaction, so ignore all the
+			 *    inode items for this inode. We will delete the
+			 *    inode when processing the parent directory with
+			 *    replay_dir_deletes().
 			 */
 			if (btrfs_inode_nlink(eb, inode_item) == 0) {
 				wc->ignore_cur_inode = true;
@@ -2451,8 +2457,14 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 			} else {
 				wc->ignore_cur_inode = false;
 			}
-			ret = replay_xattr_deletes(wc->trans, root, log,
-						   path, key.objectid);
+		}
+
+		/* Inode keys are done during the first stage. */
+		if (key.type == BTRFS_INODE_ITEM_KEY &&
+		    wc->stage == LOG_WALK_REPLAY_INODES) {
+			u32 mode;
+
+			ret = replay_xattr_deletes(wc->trans, root, log, path, key.objectid);
 			if (ret)
 				break;
 			mode = btrfs_inode_mode(eb, inode_item);
@@ -4198,6 +4210,11 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_timespec_nsec(&token, &item->ctime,
 				      inode->i_ctime.tv_nsec);
 
+	btrfs_set_token_timespec_sec(&token, &item->otime,
+				     BTRFS_I(inode)->i_otime.tv_sec);
+	btrfs_set_token_timespec_nsec(&token, &item->otime,
+				      BTRFS_I(inode)->i_otime.tv_nsec);
+
 	/*
 	 * We do not need to set the nbytes field, in fact during a fast fsync
 	 * its value may not even be correct, since a fast fsync does not wait
@@ -7252,11 +7269,14 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 
 		wc.replay_dest->log_root = log;
 		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
-		if (ret)
+		if (ret) {
 			/* The loop needs to continue due to the root refs */
 			btrfs_abort_transaction(trans, ret);
-		else
+		} else {
 			ret = walk_log_tree(trans, log, &wc);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
+		}
 
 		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
 			ret = fixup_inode_link_counts(trans, wc.replay_dest,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1dff64e62047..ba03ea17a10f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2229,8 +2229,8 @@ bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
+	u64 total = btrfs_super_total_bytes(fs_info->super_copy);
 	u64 used = 0;
-	u64 total = 0;
 	u64 factor;
 
 	ASSERT(btrfs_is_zoned(fs_info));
@@ -2243,7 +2243,6 @@ bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
 		if (!device->bdev)
 			continue;
 
-		total += device->disk_total_bytes;
 		used += device->bytes_used;
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
diff --git a/fs/buffer.c b/fs/buffer.c
index d9c6d1fbb6dd..3033a937e3a5 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -156,8 +156,8 @@ static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
  */
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
 {
-	__end_buffer_read_notouch(bh, uptodate);
 	put_bh(bh);
+	__end_buffer_read_notouch(bh, uptodate);
 }
 EXPORT_SYMBOL(end_buffer_read_sync);
 
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index d5f68a0c5d15..88414cbd97ae 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -27,6 +27,23 @@
  */
 #define FSCRYPT_MIN_KEY_SIZE	16
 
+/*
+ * This mask is passed as the third argument to the crypto_alloc_*() functions
+ * to prevent fscrypt from using the Crypto API drivers for non-inline crypto
+ * engines.  Those drivers have been problematic for fscrypt.  fscrypt users
+ * have reported hangs and even incorrect en/decryption with these drivers.
+ * Since going to the driver, off CPU, and back again is really slow, such
+ * drivers can be over 50 times slower than the CPU-based code for fscrypt's
+ * workload.  Even on platforms that lack AES instructions on the CPU, using the
+ * offloads has been shown to be slower, even staying with AES.  (Of course,
+ * Adiantum is faster still, and is the recommended option on such platforms...)
+ *
+ * Note that fscrypt also supports inline crypto engines.  Those don't use the
+ * Crypto API and work much better than the old-style (non-inline) engines.
+ */
+#define FSCRYPT_CRYPTOAPI_MASK \
+	(CRYPTO_ALG_ALLOCATES_MEMORY | CRYPTO_ALG_KERN_DRIVER_ONLY)
+
 #define FSCRYPT_CONTEXT_V1	1
 #define FSCRYPT_CONTEXT_V2	2
 
diff --git a/fs/crypto/hkdf.c b/fs/crypto/hkdf.c
index 7607d18b35fc..8cc611896c32 100644
--- a/fs/crypto/hkdf.c
+++ b/fs/crypto/hkdf.c
@@ -72,7 +72,7 @@ int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
 	u8 prk[HKDF_HASHLEN];
 	int err;
 
-	hmac_tfm = crypto_alloc_shash(HKDF_HMAC_ALG, 0, 0);
+	hmac_tfm = crypto_alloc_shash(HKDF_HMAC_ALG, 0, FSCRYPT_CRYPTOAPI_MASK);
 	if (IS_ERR(hmac_tfm)) {
 		fscrypt_err(NULL, "Error allocating " HKDF_HMAC_ALG ": %ld",
 			    PTR_ERR(hmac_tfm));
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index f7407071a952..94ad0024c529 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -88,7 +88,8 @@ fscrypt_allocate_skcipher(struct fscrypt_mode *mode, const u8 *raw_key,
 	struct crypto_skcipher *tfm;
 	int err;
 
-	tfm = crypto_alloc_skcipher(mode->cipher_str, 0, 0);
+	tfm = crypto_alloc_skcipher(mode->cipher_str, 0,
+				    FSCRYPT_CRYPTOAPI_MASK);
 	if (IS_ERR(tfm)) {
 		if (PTR_ERR(tfm) == -ENOENT) {
 			fscrypt_warn(inode,
diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index 75dabd9b27f9..159dd0288349 100644
--- a/fs/crypto/keysetup_v1.c
+++ b/fs/crypto/keysetup_v1.c
@@ -52,7 +52,8 @@ static int derive_key_aes(const u8 *master_key,
 	struct skcipher_request *req = NULL;
 	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist src_sg, dst_sg;
-	struct crypto_skcipher *tfm = crypto_alloc_skcipher("ecb(aes)", 0, 0);
+	struct crypto_skcipher *tfm =
+		crypto_alloc_skcipher("ecb(aes)", 0, FSCRYPT_CRYPTOAPI_MASK);
 
 	if (IS_ERR(tfm)) {
 		res = PTR_ERR(tfm);
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 6101dbe28344..295046df71e9 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -216,6 +216,7 @@ struct eventpoll {
 	/* used to optimize loop detection check */
 	u64 gen;
 	struct hlist_head refs;
+	u8 loop_check_depth;
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	/* used to track busy poll napi_id */
@@ -1951,23 +1952,24 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 }
 
 /**
- * ep_loop_check_proc - verify that adding an epoll file inside another
- *                      epoll structure does not violate the constraints, in
- *                      terms of closed loops, or too deep chains (which can
- *                      result in excessive stack usage).
+ * ep_loop_check_proc - verify that adding an epoll file @ep inside another
+ *                      epoll file does not create closed loops, and
+ *                      determine the depth of the subtree starting at @ep
  *
  * @ep: the &struct eventpoll to be currently checked.
  * @depth: Current depth of the path being checked.
  *
- * Return: %zero if adding the epoll @file inside current epoll
- *          structure @ep does not violate the constraints, or %-1 otherwise.
+ * Return: depth of the subtree, or INT_MAX if we found a loop or went too deep.
  */
 static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 {
-	int error = 0;
+	int result = 0;
 	struct rb_node *rbp;
 	struct epitem *epi;
 
+	if (ep->gen == loop_check_gen)
+		return ep->loop_check_depth;
+
 	mutex_lock_nested(&ep->mtx, depth + 1);
 	ep->gen = loop_check_gen;
 	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = rb_next(rbp)) {
@@ -1975,13 +1977,11 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 		if (unlikely(is_file_epoll(epi->ffd.file))) {
 			struct eventpoll *ep_tovisit;
 			ep_tovisit = epi->ffd.file->private_data;
-			if (ep_tovisit->gen == loop_check_gen)
-				continue;
 			if (ep_tovisit == inserting_into || depth > EP_MAX_NESTS)
-				error = -1;
+				result = INT_MAX;
 			else
-				error = ep_loop_check_proc(ep_tovisit, depth + 1);
-			if (error != 0)
+				result = max(result, ep_loop_check_proc(ep_tovisit, depth + 1) + 1);
+			if (result > EP_MAX_NESTS)
 				break;
 		} else {
 			/*
@@ -1995,9 +1995,27 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 			list_file(epi->ffd.file);
 		}
 	}
+	ep->loop_check_depth = result;
 	mutex_unlock(&ep->mtx);
 
-	return error;
+	return result;
+}
+
+/**
+ * ep_get_upwards_depth_proc - determine depth of @ep when traversed upwards
+ */
+static int ep_get_upwards_depth_proc(struct eventpoll *ep, int depth)
+{
+	int result = 0;
+	struct epitem *epi;
+
+	if (ep->gen == loop_check_gen)
+		return ep->loop_check_depth;
+	hlist_for_each_entry_rcu(epi, &ep->refs, fllink)
+		result = max(result, ep_get_upwards_depth_proc(epi->ep, depth + 1) + 1);
+	ep->gen = loop_check_gen;
+	ep->loop_check_depth = result;
+	return result;
 }
 
 /**
@@ -2013,8 +2031,22 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
  */
 static int ep_loop_check(struct eventpoll *ep, struct eventpoll *to)
 {
+	int depth, upwards_depth;
+
 	inserting_into = ep;
-	return ep_loop_check_proc(to, 0);
+	/*
+	 * Check how deep down we can get from @to, and whether it is possible
+	 * to loop up to @ep.
+	 */
+	depth = ep_loop_check_proc(to, 0);
+	if (depth > EP_MAX_NESTS)
+		return -1;
+	/* Check how far up we can go from @ep. */
+	rcu_read_lock();
+	upwards_depth = ep_get_upwards_depth_proc(ep, 0);
+	rcu_read_unlock();
+
+	return (depth+1+upwards_depth > EP_MAX_NESTS) ? -1 : 0;
 }
 
 static void clear_tfile_check_list(void)
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 5a32fcd55183..430ccd983491 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -860,9 +860,19 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
 	int ret;
+	loff_t i_size;
 
 	inode_lock(inode);
-	len = min_t(u64, len, i_size_read(inode));
+	i_size = i_size_read(inode);
+	/*
+	 * iomap_fiemap() returns EINVAL for 0 length. Make sure we don't trim
+	 * length to 0 but still trim the range as much as possible since
+	 * ext2_get_blocks() iterates unmapped space block by block which is
+	 * slow.
+	 */
+	if (i_size == 0)
+		i_size = 1;
+	len = min_t(u64, len, i_size);
 	ret = iomap_fiemap(inode, fieinfo, start, len, &ext2_iomap_ops);
 	inode_unlock(inode);
 
diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 53a05b8292f0..1b68586f73f3 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -393,6 +393,14 @@ static unsigned int ext4_getfsmap_find_sb(struct super_block *sb,
 	/* Reserved GDT blocks */
 	if (!ext4_has_feature_meta_bg(sb) || metagroup < first_meta_bg) {
 		len = le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks);
+
+		/*
+		 * mkfs.ext4 can set s_reserved_gdt_blocks as 0 in some cases,
+		 * check for that.
+		 */
+		if (!len)
+			return 0;
+
 		error = ext4_getfsmap_fill(meta_list, fsb, len,
 					   EXT4_FMR_OWN_RESV_GDT);
 		if (error)
@@ -526,6 +534,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 	ext4_group_t end_ag;
 	ext4_grpblk_t first_cluster;
 	ext4_grpblk_t last_cluster;
+	struct ext4_fsmap irec;
 	int error = 0;
 
 	bofs = le32_to_cpu(sbi->s_es->s_first_data_block);
@@ -609,10 +618,18 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 			goto err;
 	}
 
-	/* Report any gaps at the end of the bg */
+	/*
+	 * The dummy record below will cause ext4_getfsmap_helper() to report
+	 * any allocated blocks at the end of the range.
+	 */
+	irec.fmr_device = 0;
+	irec.fmr_physical = end_fsb + 1;
+	irec.fmr_length = 0;
+	irec.fmr_owner = EXT4_FMR_OWN_FREE;
+	irec.fmr_flags = 0;
+
 	info->gfi_last = true;
-	error = ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster + 1,
-					     0, info);
+	error = ext4_getfsmap_helper(sb, info, &irec);
 	if (error)
 		goto err;
 
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index a9f3716119d3..a99d003e9625 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -539,7 +539,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 	int indirect_blks;
 	int blocks_to_boundary = 0;
 	int depth;
-	int count = 0;
+	u64 count = 0;
 	ext4_fsblk_t first_block = 0;
 
 	trace_ext4_ind_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
@@ -588,7 +588,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 		count++;
 		/* Fill in size of a hole we found */
 		map->m_pblk = 0;
-		map->m_len = min_t(unsigned int, map->m_len, count);
+		map->m_len = umin(map->m_len, count);
 		goto cleanup;
 	}
 
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 312be3d7cfb3..af2d6e92cb7f 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -299,7 +299,11 @@ static int ext4_create_inline_data(handle_t *handle,
 	if (error)
 		goto out;
 
-	BUG_ON(!is.s.not_found);
+	if (!is.s.not_found) {
+		EXT4_ERROR_INODE(inode, "unexpected inline data xattr");
+		error = -EFSCORRUPTED;
+		goto out;
+	}
 
 	error = ext4_xattr_ibody_set(handle, inode, &i, &is);
 	if (error) {
@@ -350,7 +354,11 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 	if (error)
 		goto out;
 
-	BUG_ON(is.s.not_found);
+	if (is.s.not_found) {
+		EXT4_ERROR_INODE(inode, "missing inline data xattr");
+		error = -EFSCORRUPTED;
+		goto out;
+	}
 
 	len -= EXT4_MIN_INLINE_DATA_SIZE;
 	value = kzalloc(len, GFP_NOFS);
@@ -2002,7 +2010,12 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 			if ((err = ext4_xattr_ibody_find(inode, &i, &is)) != 0)
 				goto out_error;
 
-			BUG_ON(is.s.not_found);
+			if (is.s.not_found) {
+				EXT4_ERROR_INODE(inode,
+						 "missing inline data xattr");
+				err = -EFSCORRUPTED;
+				goto out_error;
+			}
 
 			value_len = le32_to_cpu(is.s.here->e_value_size);
 			value = kmalloc(value_len, GFP_NOFS);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 055216f9f464..7e9467252c3a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -146,7 +146,7 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
  */
 int ext4_inode_is_fast_symlink(struct inode *inode)
 {
-	if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+	if (!ext4_has_feature_ea_inode(inode->i_sb)) {
 		int ea_blocks = EXT4_I(inode)->i_file_acl ?
 				EXT4_CLUSTER_SIZE(inode->i_sb) >> 9 : 0;
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 166273584aa4..1dc25e7b922a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -829,30 +829,30 @@ static void
 mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	int new_order;
+	int new, old;
 
-	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_fragments == 0)
+	if (!test_opt2(sb, MB_OPTIMIZE_SCAN))
 		return;
 
-	new_order = mb_avg_fragment_size_order(sb,
-					grp->bb_free / grp->bb_fragments);
-	if (new_order == grp->bb_avg_fragment_size_order)
+	old = grp->bb_avg_fragment_size_order;
+	new = grp->bb_fragments == 0 ? -1 :
+	      mb_avg_fragment_size_order(sb, grp->bb_free / grp->bb_fragments);
+	if (new == old)
 		return;
 
-	if (grp->bb_avg_fragment_size_order != -1) {
-		write_lock(&sbi->s_mb_avg_fragment_size_locks[
-					grp->bb_avg_fragment_size_order]);
+	if (old >= 0) {
+		write_lock(&sbi->s_mb_avg_fragment_size_locks[old]);
 		list_del(&grp->bb_avg_fragment_size_node);
-		write_unlock(&sbi->s_mb_avg_fragment_size_locks[
-					grp->bb_avg_fragment_size_order]);
+		write_unlock(&sbi->s_mb_avg_fragment_size_locks[old]);
+	}
+
+	grp->bb_avg_fragment_size_order = new;
+	if (new >= 0) {
+		write_lock(&sbi->s_mb_avg_fragment_size_locks[new]);
+		list_add_tail(&grp->bb_avg_fragment_size_node,
+				&sbi->s_mb_avg_fragment_size[new]);
+		write_unlock(&sbi->s_mb_avg_fragment_size_locks[new]);
 	}
-	grp->bb_avg_fragment_size_order = new_order;
-	write_lock(&sbi->s_mb_avg_fragment_size_locks[
-					grp->bb_avg_fragment_size_order]);
-	list_add_tail(&grp->bb_avg_fragment_size_node,
-		&sbi->s_mb_avg_fragment_size[grp->bb_avg_fragment_size_order]);
-	write_unlock(&sbi->s_mb_avg_fragment_size_locks[
-					grp->bb_avg_fragment_size_order]);
 }
 
 /*
@@ -1032,33 +1032,28 @@ static void
 mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	int i;
+	int new, old = grp->bb_largest_free_order;
 
-	for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--)
-		if (grp->bb_counters[i] > 0)
+	for (new = MB_NUM_ORDERS(sb) - 1; new >= 0; new--)
+		if (grp->bb_counters[new] > 0)
 			break;
+
 	/* No need to move between order lists? */
-	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) ||
-	    i == grp->bb_largest_free_order) {
-		grp->bb_largest_free_order = i;
+	if (new == old)
 		return;
-	}
 
-	if (grp->bb_largest_free_order >= 0) {
-		write_lock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
+	if (old >= 0 && !list_empty(&grp->bb_largest_free_order_node)) {
+		write_lock(&sbi->s_mb_largest_free_orders_locks[old]);
 		list_del_init(&grp->bb_largest_free_order_node);
-		write_unlock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
+		write_unlock(&sbi->s_mb_largest_free_orders_locks[old]);
 	}
-	grp->bb_largest_free_order = i;
-	if (grp->bb_largest_free_order >= 0 && grp->bb_free) {
-		write_lock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
+
+	grp->bb_largest_free_order = new;
+	if (test_opt2(sb, MB_OPTIMIZE_SCAN) && new >= 0 && grp->bb_free) {
+		write_lock(&sbi->s_mb_largest_free_orders_locks[new]);
 		list_add_tail(&grp->bb_largest_free_order_node,
-		      &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
-		write_unlock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
+			      &sbi->s_mb_largest_free_orders[new]);
+		write_unlock(&sbi->s_mb_largest_free_orders_locks[new]);
 	}
 }
 
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index e5b47dda3317..a23b0c01f809 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -590,8 +590,9 @@ int ext4_init_orphan_info(struct super_block *sb)
 	}
 	oi->of_blocks = inode->i_size >> sb->s_blocksize_bits;
 	oi->of_csum_seed = EXT4_I(inode)->i_csum_seed;
-	oi->of_binfo = kmalloc(oi->of_blocks*sizeof(struct ext4_orphan_block),
-			       GFP_KERNEL);
+	oi->of_binfo = kmalloc_array(oi->of_blocks,
+				     sizeof(struct ext4_orphan_block),
+				     GFP_KERNEL);
 	if (!oi->of_binfo) {
 		ret = -ENOMEM;
 		goto out_put;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f829f989f2b5..412b173ba29d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1937,6 +1937,9 @@ int ext4_init_fs_context(struct fs_context *fc)
 	fc->fs_private = ctx;
 	fc->ops = &ext4_context_ops;
 
+	/* i_version is always enabled now */
+	fc->sb_flags |= SB_I_VERSION;
+
 	return 0;
 }
 
@@ -5113,9 +5116,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
 
-	/* i_version is always enabled now */
-	sb->s_flags |= SB_I_VERSION;
-
 	if (ext4_check_feature_compatibility(sb, es, silent))
 		goto failed_mount;
 
@@ -5295,6 +5295,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		err = ext4_load_and_init_journal(sb, es, ctx);
 		if (err)
 			goto failed_mount3a;
+		if (bdev_read_only(sb->s_bdev))
+		    needs_recovery = 0;
 	} else if (test_opt(sb, NOLOAD) && !sb_rdonly(sb) &&
 		   ext4_has_feature_journal_needs_recovery(sb)) {
 		ext4_msg(sb, KERN_ERR, "required journal recovery "
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dc8f283f210c..2b018d365b91 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3729,6 +3729,7 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 		}
 	}
 
+	clear_page_private_reference(&folio->page);
 	clear_page_private_gcing(&folio->page);
 
 	if (test_opt(sbi, COMPRESS_CACHE) &&
@@ -3754,6 +3755,7 @@ bool f2fs_release_folio(struct folio *folio, gfp_t wait)
 			clear_page_private_data(&folio->page);
 	}
 
+	clear_page_private_reference(&folio->page);
 	clear_page_private_gcing(&folio->page);
 
 	folio_detach_private(folio);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1ad9669666e8..ad7bc58ce0a4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1428,7 +1428,6 @@ static inline void clear_page_private_##name(struct page *page) \
 }
 
 PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
-PAGE_PRIVATE_GET_FUNC(reference, REF_RESOURCE);
 PAGE_PRIVATE_GET_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_GET_FUNC(gcing, ONGOING_MIGRATION);
 PAGE_PRIVATE_GET_FUNC(atomic, ATOMIC_WRITE);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index c02b5ea43f07..020a3249c9c9 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -210,6 +210,13 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if (ino_of_node(node_page) == fi->i_xattr_nid) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_warn(sbi, "%s: corrupted inode i_ino=%lx, xnid=%x, run fsck to fix.",
+			  __func__, inode->i_ino, fi->i_xattr_nid);
+		return false;
+	}
+
 	if (f2fs_sb_has_flexible_inline_xattr(sbi)
 			&& !f2fs_has_extra_attr(inode)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ccc72781e0c6..ec84bb7c31bf 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -797,6 +797,16 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	for (i = 1; i <= level; i++) {
 		bool done = false;
 
+		if (nids[i] && nids[i] == dn->inode->i_ino) {
+			err = -EFSCORRUPTED;
+			f2fs_err(sbi,
+				"inode mapping table is corrupted, run fsck to fix it, "
+				"ino:%lu, nid:%u, level:%d, offset:%d",
+				dn->inode->i_ino, nids[i], level, offset[level]);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			goto release_pages;
+		}
+
 		if (!nids[i] && mode == ALLOC_NODE) {
 			/* alloc new node */
 			if (!f2fs_alloc_nid(sbi, &(nids[i]))) {
diff --git a/fs/file.c b/fs/file.c
index 2eccbb5dcd86..e921e6072ada 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -90,18 +90,11 @@ static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
  * 'unsigned long' in some places, but simply because that is how the Linux
  * kernel bitmaps are defined to work: they are not "bits in an array of bytes",
  * they are very much "bits in an array of unsigned long".
- *
- * The ALIGN(nr, BITS_PER_LONG) here is for clarity: since we just multiplied
- * by that "1024/sizeof(ptr)" before, we already know there are sufficient
- * clear low bits. Clang seems to realize that, gcc ends up being confused.
- *
- * On a 128-bit machine, the ALIGN() would actually matter. In the meantime,
- * let's consider it documentation (and maybe a test-case for gcc to improve
- * its code generation ;)
  */
-static struct fdtable * alloc_fdtable(unsigned int nr)
+static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
 {
 	struct fdtable *fdt;
+	unsigned int nr;
 	void *data;
 
 	/*
@@ -109,22 +102,47 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
 	 * Allocation steps are keyed to the size of the fdarray, since it
 	 * grows far faster than any of the other dynamic data. We try to fit
 	 * the fdarray into comfortable page-tuned chunks: starting at 1024B
-	 * and growing in powers of two from there on.
+	 * and growing in powers of two from there on.  Since we called only
+	 * with slots_wanted > BITS_PER_LONG (embedded instance in files->fdtab
+	 * already gives BITS_PER_LONG slots), the above boils down to
+	 * 1.  use the smallest power of two large enough to give us that many
+	 * slots.
+	 * 2.  on 32bit skip 64 and 128 - the minimal capacity we want there is
+	 * 256 slots (i.e. 1Kb fd array).
+	 * 3.  on 64bit don't skip anything, 1Kb fd array means 128 slots there
+	 * and we are never going to be asked for 64 or less.
 	 */
-	nr /= (1024 / sizeof(struct file *));
-	nr = roundup_pow_of_two(nr + 1);
-	nr *= (1024 / sizeof(struct file *));
-	nr = ALIGN(nr, BITS_PER_LONG);
+	if (IS_ENABLED(CONFIG_32BIT) && slots_wanted < 256)
+		nr = 256;
+	else
+		nr = roundup_pow_of_two(slots_wanted);
 	/*
 	 * Note that this can drive nr *below* what we had passed if sysctl_nr_open
-	 * had been set lower between the check in expand_files() and here.  Deal
-	 * with that in caller, it's cheaper that way.
+	 * had been set lower between the check in expand_files() and here.
 	 *
 	 * We make sure that nr remains a multiple of BITS_PER_LONG - otherwise
 	 * bitmaps handling below becomes unpleasant, to put it mildly...
 	 */
-	if (unlikely(nr > sysctl_nr_open))
-		nr = ((sysctl_nr_open - 1) | (BITS_PER_LONG - 1)) + 1;
+	if (unlikely(nr > sysctl_nr_open)) {
+		nr = round_down(sysctl_nr_open, BITS_PER_LONG);
+		if (nr < slots_wanted)
+			return ERR_PTR(-EMFILE);
+	}
+
+	/*
+	 * Check if the allocation size would exceed INT_MAX. kvmalloc_array()
+	 * and kvmalloc() will warn if the allocation size is greater than
+	 * INT_MAX, as filp_cachep objects are not __GFP_NOWARN.
+	 *
+	 * This can happen when sysctl_nr_open is set to a very high value and
+	 * a process tries to use a file descriptor near that limit. For example,
+	 * if sysctl_nr_open is set to 1073741816 (0x3ffffff8) - which is what
+	 * systemd typically sets it to - then trying to use a file descriptor
+	 * close to that value will require allocating a file descriptor table
+	 * that exceeds 8GB in size.
+	 */
+	if (unlikely(nr > INT_MAX / sizeof(struct file *)))
+		return ERR_PTR(-EMFILE);
 
 	fdt = kmalloc(sizeof(struct fdtable), GFP_KERNEL_ACCOUNT);
 	if (!fdt)
@@ -153,7 +171,7 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
 out_fdt:
 	kfree(fdt);
 out:
-	return NULL;
+	return ERR_PTR(-ENOMEM);
 }
 
 /*
@@ -170,7 +188,7 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 	struct fdtable *new_fdt, *cur_fdt;
 
 	spin_unlock(&files->file_lock);
-	new_fdt = alloc_fdtable(nr);
+	new_fdt = alloc_fdtable(nr + 1);
 
 	/* make sure all fd_install() have seen resize_in_progress
 	 * or have finished their rcu_read_lock_sched() section.
@@ -179,16 +197,8 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 		synchronize_rcu();
 
 	spin_lock(&files->file_lock);
-	if (!new_fdt)
-		return -ENOMEM;
-	/*
-	 * extremely unlikely race - sysctl_nr_open decreased between the check in
-	 * caller and alloc_fdtable().  Cheaper to catch it here...
-	 */
-	if (unlikely(new_fdt->max_fds <= nr)) {
-		__free_fdtable(new_fdt);
-		return -EMFILE;
-	}
+	if (IS_ERR(new_fdt))
+		return PTR_ERR(new_fdt);
 	cur_fdt = files_fdtable(files);
 	BUG_ON(nr < cur_fdt->max_fds);
 	copy_fdtable(new_fdt, cur_fdt);
@@ -302,7 +312,6 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	struct file **old_fds, **new_fds;
 	unsigned int open_files, i;
 	struct fdtable *old_fdt, *new_fdt;
-	int error;
 
 	newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
 	if (!newf)
@@ -334,17 +343,10 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 		if (new_fdt != &newf->fdtab)
 			__free_fdtable(new_fdt);
 
-		new_fdt = alloc_fdtable(open_files - 1);
-		if (!new_fdt) {
-			error = -ENOMEM;
-			goto out_release;
-		}
-
-		/* beyond sysctl_nr_open; nothing to do */
-		if (unlikely(new_fdt->max_fds < open_files)) {
-			__free_fdtable(new_fdt);
-			error = -EMFILE;
-			goto out_release;
+		new_fdt = alloc_fdtable(open_files);
+		if (IS_ERR(new_fdt)) {
+			kmem_cache_free(files_cachep, newf);
+			return ERR_CAST(new_fdt);
 		}
 
 		/*
@@ -393,10 +395,6 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	rcu_assign_pointer(newf->fdt, new_fdt);
 
 	return newf;
-
-out_release:
-	kmem_cache_free(files_cachep, newf);
-	return ERR_PTR(error);
 }
 
 static struct fdtable *close_files(struct files_struct * files)
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index cb823a8a6ba9..e8cd1a31f247 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -15,6 +15,48 @@
 
 #include "btree.h"
 
+static inline
+bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
+{
+	bool is_valid = off < node->tree->node_size;
+
+	if (!is_valid) {
+		pr_err("requested invalid offset: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off);
+	}
+
+	return is_valid;
+}
+
+static inline
+int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
+{
+	unsigned int node_size;
+
+	if (!is_bnode_offset_valid(node, off))
+		return 0;
+
+	node_size = node->tree->node_size;
+
+	if ((off + len) > node_size) {
+		int new_len = (int)node_size - off;
+
+		pr_err("requested length has been corrected: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, "
+		       "requested_len %d, corrected_len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len, new_len);
+
+		return new_len;
+	}
+
+	return len;
+}
+
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 {
 	struct page *page;
@@ -22,6 +64,20 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 	int bytes_read;
 	int bytes_to_read;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagenum = off >> PAGE_SHIFT;
 	off &= ~PAGE_MASK; /* compute page offset for the first page */
@@ -80,6 +136,20 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
 {
 	struct page *page;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	page = node->page[0];
 
@@ -104,6 +174,20 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
 {
 	struct page *page;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	page = node->page[0];
 
@@ -119,6 +203,10 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 	hfs_dbg(BNODE_MOD, "copybytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
+
+	len = check_and_correct_requested_length(src_node, src, len);
+	len = check_and_correct_requested_length(dst_node, dst, len);
+
 	src += src_node->page_offset;
 	dst += dst_node->page_offset;
 	src_page = src_node->page[0];
@@ -136,6 +224,10 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
+
+	len = check_and_correct_requested_length(node, src, len);
+	len = check_and_correct_requested_length(node, dst, len);
+
 	src += node->page_offset;
 	dst += node->page_offset;
 	page = node->page[0];
@@ -482,6 +574,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
 		if (test_bit(HFS_BNODE_DELETED, &node->flags)) {
 			hfs_bnode_unhash(node);
 			spin_unlock(&tree->hash_lock);
+			hfs_bnode_clear(node, 0, tree->node_size);
 			hfs_bmap_free(node);
 			hfs_bnode_free(node);
 			return;
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 079ea80534f7..14f4995588ff 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -18,12 +18,68 @@
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
 
+static inline
+bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
+{
+	bool is_valid = off < node->tree->node_size;
+
+	if (!is_valid) {
+		pr_err("requested invalid offset: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off);
+	}
+
+	return is_valid;
+}
+
+static inline
+int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
+{
+	unsigned int node_size;
+
+	if (!is_bnode_offset_valid(node, off))
+		return 0;
+
+	node_size = node->tree->node_size;
+
+	if ((off + len) > node_size) {
+		int new_len = (int)node_size - off;
+
+		pr_err("requested length has been corrected: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, "
+		       "requested_len %d, corrected_len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len, new_len);
+
+		return new_len;
+	}
+
+	return len;
+}
+
 /* Copy a specified range of bytes from the raw data of a node */
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 {
 	struct page **pagep;
 	int l;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
 	off &= ~PAGE_MASK;
@@ -81,6 +137,20 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
 	struct page **pagep;
 	int l;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
 	off &= ~PAGE_MASK;
@@ -109,6 +179,20 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
 	struct page **pagep;
 	int l;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
 	off &= ~PAGE_MASK;
@@ -133,6 +217,10 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 	hfs_dbg(BNODE_MOD, "copybytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
+
+	len = check_and_correct_requested_length(src_node, src, len);
+	len = check_and_correct_requested_length(dst_node, dst, len);
+
 	src += src_node->page_offset;
 	dst += dst_node->page_offset;
 	src_page = src_node->page + (src >> PAGE_SHIFT);
@@ -187,6 +275,10 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
+
+	len = check_and_correct_requested_length(node, src, len);
+	len = check_and_correct_requested_length(node, dst, len);
+
 	src += node->page_offset;
 	dst += node->page_offset;
 	if (dst > src) {
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 73342c925a4b..36b6cf2a3abb 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -132,7 +132,14 @@ int hfsplus_uni2asc(struct super_block *sb,
 
 	op = astr;
 	ip = ustr->unicode;
+
 	ustrlen = be16_to_cpu(ustr->length);
+	if (ustrlen > HFSPLUS_MAX_STRLEN) {
+		ustrlen = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(ustr->length), ustrlen);
+	}
+
 	len = *len_p;
 	ce1 = NULL;
 	compose = !test_bit(HFSPLUS_SB_NODECOMPOSE, &HFSPLUS_SB(sb)->flags);
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 2b0e0ba58139..beedc1a2237a 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -172,7 +172,11 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 		return PTR_ERR(attr_file);
 	}
 
-	BUG_ON(i_size_read(attr_file) != 0);
+	if (i_size_read(attr_file) != 0) {
+		err = -EIO;
+		pr_err("detected inconsistent attributes file, running fsck.hfsplus is recommended.\n");
+		goto end_attr_file_creation;
+	}
 
 	hip = HFSPLUS_I(attr_file);
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 330729445d8a..d4b2a199cb9d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -136,7 +136,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
 	vma->vm_ops = &hugetlb_vm_ops;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index affcde540585..2c1751c637c8 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -297,6 +297,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		retry:
 			if (batch_count)
 				__flush_batch(journal, &batch_count);
+			cond_resched();
 			spin_lock(&journal->j_list_lock);
 			goto restart;
 	}
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 332dc9ac47a9..ae8df3d11663 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -44,6 +44,9 @@ static int jfs_open(struct inode *inode, struct file *file)
 {
 	int rc;
 
+	if (S_ISREG(inode->i_mode) && inode->i_size < 0)
+		return -EIO;
+
 	if ((rc = dquot_file_open(inode, file)))
 		return rc;
 
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index d1ec920aa030..d41891bb617a 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -145,9 +145,9 @@ void jfs_evict_inode(struct inode *inode)
 	if (!inode->i_nlink && !is_bad_inode(inode)) {
 		dquot_initialize(inode);
 
+		truncate_inode_pages_final(&inode->i_data);
 		if (JFS_IP(inode)->fileset == FILESYSTEM_I) {
 			struct inode *ipimap = JFS_SBI(inode->i_sb)->ipimap;
-			truncate_inode_pages_final(&inode->i_data);
 
 			if (test_cflag(COMMIT_Freewmap, inode))
 				jfs_free_zero_link(inode);
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index c761291f59ac..277f3175477f 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1389,6 +1389,12 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
 	    (1 << (L2LPERCTL - (bmp->db_agheight << 1))) / bmp->db_agwidth;
 	ti = bmp->db_agstart + bmp->db_agwidth * (agno & (agperlev - 1));
 
+	if (ti < 0 || ti >= le32_to_cpu(dcp->nleafs)) {
+		jfs_error(bmp->db_ipbmap->i_sb, "Corrupt dmapctl page\n");
+		release_metapage(mp);
+		return -EIO;
+	}
+
 	/* dmap control page trees fan-out by 4 and a single allocation
 	 * group may be described by 1 or 2 subtrees within the ag level
 	 * dmap control page, depending upon the ag size. examine the ag's
diff --git a/fs/libfs.c b/fs/libfs.c
index aada4e7c8713..cbd42d76fbd0 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -274,7 +274,7 @@ void simple_recursive_removal(struct dentry *dentry,
 		struct dentry *victim = NULL, *child;
 		struct inode *inode = this->d_inode;
 
-		inode_lock(inode);
+		inode_lock_nested(inode, I_MUTEX_CHILD);
 		if (d_is_dir(this))
 			inode->i_flags |= S_DEAD;
 		while ((child = find_next_child(this, victim)) == NULL) {
@@ -286,7 +286,7 @@ void simple_recursive_removal(struct dentry *dentry,
 			victim = this;
 			this = this->d_parent;
 			inode = this->d_inode;
-			inode_lock(inode);
+			inode_lock_nested(inode, I_MUTEX_CHILD);
 			if (simple_positive(victim)) {
 				d_invalidate(victim);	// avoid lost mounts
 				if (d_is_dir(victim))
diff --git a/fs/namespace.c b/fs/namespace.c
index f0fa2a1a6b05..2a76269f2a4e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2340,6 +2340,19 @@ static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
 	return attach_recursive_mnt(mnt, p, mp, false);
 }
 
+static int may_change_propagation(const struct mount *m)
+{
+        struct mnt_namespace *ns = m->mnt_ns;
+
+	 // it must be mounted in some namespace
+	 if (IS_ERR_OR_NULL(ns))         // is_mounted()
+		 return -EINVAL;
+	 // and the caller must be admin in userns of that namespace
+	 if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
+		 return -EPERM;
+	 return 0;
+}
+
 /*
  * Sanity check the flags to change_mnt_propagation.
  */
@@ -2376,10 +2389,10 @@ static int do_change_type(struct path *path, int ms_flags)
 		return -EINVAL;
 
 	namespace_lock();
-	if (!check_mnt(mnt)) {
-		err = -EINVAL;
+	err = may_change_propagation(mnt);
+	if (err)
 		goto out_unlock;
-	}
+
 	if (type == MS_SHARED) {
 		err = invent_group_ids(mnt, recurse);
 		if (err)
@@ -2774,18 +2787,11 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 
 	namespace_lock();
 
-	err = -EINVAL;
-	/* To and From must be mounted */
-	if (!is_mounted(&from->mnt))
-		goto out;
-	if (!is_mounted(&to->mnt))
-		goto out;
-
-	err = -EPERM;
-	/* We should be allowed to modify mount namespaces of both mounts */
-	if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
+	err = may_change_propagation(from);
+	if (err)
 		goto out;
-	if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
+	err = may_change_propagation(to);
+	if (err)
 		goto out;
 
 	err = -EINVAL;
diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 6be13e0ec170..e498aade8c47 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -149,8 +149,8 @@ do_add_page_to_bio(struct bio *bio, int npg, enum req_op op, sector_t isect,
 
 	/* limit length to what the device mapping allows */
 	end = disk_addr + *len;
-	if (end >= map->start + map->len)
-		*len = map->start + map->len - disk_addr;
+	if (end >= map->disk_offset + map->len)
+		*len = map->disk_offset + map->len - disk_addr;
 
 retry:
 	if (!bio) {
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index ce2ea6239797..fc6413953600 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -199,10 +199,11 @@ static bool bl_map_stripe(struct pnfs_block_dev *dev, u64 offset,
 	struct pnfs_block_dev *child;
 	u64 chunk;
 	u32 chunk_idx;
+	u64 disk_chunk;
 	u64 disk_offset;
 
 	chunk = div_u64(offset, dev->chunk_size);
-	div_u64_rem(chunk, dev->nr_children, &chunk_idx);
+	disk_chunk = div_u64_rem(chunk, dev->nr_children, &chunk_idx);
 
 	if (chunk_idx >= dev->nr_children) {
 		dprintk("%s: invalid chunk idx %d (%lld/%lld)\n",
@@ -215,7 +216,7 @@ static bool bl_map_stripe(struct pnfs_block_dev *dev, u64 offset,
 	offset = chunk * dev->chunk_size;
 
 	/* disk offset of the stripe */
-	disk_offset = div_u64(offset, dev->nr_children);
+	disk_offset = disk_chunk * dev->chunk_size;
 
 	child = &dev->children[chunk_idx];
 	child->map(child, disk_offset, map);
diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent_tree.c
index 8f7cff7a4293..0add0f329816 100644
--- a/fs/nfs/blocklayout/extent_tree.c
+++ b/fs/nfs/blocklayout/extent_tree.c
@@ -552,6 +552,15 @@ static int ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
 	return ret;
 }
 
+/**
+ * ext_tree_prepare_commit - encode extents that need to be committed
+ * @arg: layout commit data
+ *
+ * Return values:
+ *   %0: Success, all required extents are encoded
+ *   %-ENOSPC: Some extents are encoded, but not all, due to RPC size limit
+ *   %-ENOMEM: Out of memory, extents not encoded
+ */
 int
 ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 {
@@ -568,12 +577,12 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 	start_p = page_address(arg->layoutupdate_page);
 	arg->layoutupdate_pages = &arg->layoutupdate_page;
 
-retry:
-	ret = ext_tree_encode_commit(bl, start_p + 1, buffer_size, &count, &arg->lastbytewritten);
+	ret = ext_tree_encode_commit(bl, start_p + 1, buffer_size,
+			&count, &arg->lastbytewritten);
 	if (unlikely(ret)) {
 		ext_tree_free_commitdata(arg, buffer_size);
 
-		buffer_size = ext_tree_layoutupdate_size(bl, count);
+		buffer_size = NFS_SERVER(arg->inode)->wsize;
 		count = 0;
 
 		arg->layoutupdate_pages =
@@ -588,7 +597,8 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 			return -ENOMEM;
 		}
 
-		goto retry;
+		ret = ext_tree_encode_commit(bl, start_p + 1, buffer_size,
+				&count, &arg->lastbytewritten);
 	}
 
 	*start_p = cpu_to_be32(count);
@@ -608,7 +618,7 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 	}
 
 	dprintk("%s found %zu ranges\n", __func__, count);
-	return 0;
+	return ret;
 }
 
 void
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index de4ad41b14e2..36025097d21b 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -657,6 +657,44 @@ struct nfs_client *nfs_init_client(struct nfs_client *clp,
 }
 EXPORT_SYMBOL_GPL(nfs_init_client);
 
+static void nfs4_server_set_init_caps(struct nfs_server *server)
+{
+#if IS_ENABLED(CONFIG_NFS_V4)
+	/* Set the basic capabilities */
+	server->caps = server->nfs_client->cl_mvops->init_caps;
+	if (server->flags & NFS_MOUNT_NORDIRPLUS)
+		server->caps &= ~NFS_CAP_READDIRPLUS;
+	if (server->nfs_client->cl_proto == XPRT_TRANSPORT_RDMA)
+		server->caps &= ~NFS_CAP_READ_PLUS;
+
+	/*
+	 * Don't use NFS uid/gid mapping if we're using AUTH_SYS or lower
+	 * authentication.
+	 */
+	if (nfs4_disable_idmapping &&
+	    server->client->cl_auth->au_flavor == RPC_AUTH_UNIX)
+		server->caps |= NFS_CAP_UIDGID_NOMAP;
+#endif
+}
+
+void nfs_server_set_init_caps(struct nfs_server *server)
+{
+	switch (server->nfs_client->rpc_ops->version) {
+	case 2:
+		server->caps = NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
+		break;
+	case 3:
+		server->caps = NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
+		if (!(server->flags & NFS_MOUNT_NORDIRPLUS))
+			server->caps |= NFS_CAP_READDIRPLUS;
+		break;
+	default:
+		nfs4_server_set_init_caps(server);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(nfs_server_set_init_caps);
+
 /*
  * Create a version 2 or 3 client
  */
@@ -695,7 +733,6 @@ static int nfs_init_server(struct nfs_server *server,
 	/* Initialise the client representation from the mount data */
 	server->flags = ctx->flags;
 	server->options = ctx->options;
-	server->caps |= NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
 
 	switch (clp->rpc_ops->version) {
 	case 2:
@@ -731,6 +768,8 @@ static int nfs_init_server(struct nfs_server *server,
 	if (error < 0)
 		goto error;
 
+	nfs_server_set_init_caps(server);
+
 	/* Preserve the values of mount_server-related mount options */
 	if (ctx->mount_server.addrlen) {
 		memcpy(&server->mountd_address, &ctx->mount_server.address,
@@ -905,7 +944,6 @@ void nfs_server_copy_userdata(struct nfs_server *target, struct nfs_server *sour
 	target->acregmax = source->acregmax;
 	target->acdirmin = source->acdirmin;
 	target->acdirmax = source->acdirmax;
-	target->caps = source->caps;
 	target->options = source->options;
 	target->auth_info = source->auth_info;
 	target->port = source->port;
@@ -1112,6 +1150,8 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 	if (error < 0)
 		goto out_free_server;
 
+	nfs_server_set_init_caps(server);
+
 	/* probe the filesystem info for this server filesystem */
 	error = nfs_probe_server(server, fh);
 	if (error < 0)
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6ea10abfa851..f6ed7113092e 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -219,7 +219,7 @@ extern struct nfs_client *
 nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
 				struct nfs4_sessionid *, u32);
 extern struct nfs_server *nfs_create_server(struct fs_context *);
-extern void nfs4_server_set_init_caps(struct nfs_server *);
+extern void nfs_server_set_init_caps(struct nfs_server *);
 extern struct nfs_server *nfs4_create_server(struct fs_context *);
 extern struct nfs_server *nfs4_create_referral_server(struct fs_context *);
 extern int nfs4_update_server(struct nfs_server *server, const char *hostname,
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 02caeec2c173..6b14e4af25d3 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1065,24 +1065,6 @@ static void nfs4_session_limit_xasize(struct nfs_server *server)
 #endif
 }
 
-void nfs4_server_set_init_caps(struct nfs_server *server)
-{
-	/* Set the basic capabilities */
-	server->caps |= server->nfs_client->cl_mvops->init_caps;
-	if (server->flags & NFS_MOUNT_NORDIRPLUS)
-			server->caps &= ~NFS_CAP_READDIRPLUS;
-	if (server->nfs_client->cl_proto == XPRT_TRANSPORT_RDMA)
-		server->caps &= ~NFS_CAP_READ_PLUS;
-
-	/*
-	 * Don't use NFS uid/gid mapping if we're using AUTH_SYS or lower
-	 * authentication.
-	 */
-	if (nfs4_disable_idmapping &&
-			server->client->cl_auth->au_flavor == RPC_AUTH_UNIX)
-		server->caps |= NFS_CAP_UIDGID_NOMAP;
-}
-
 static int nfs4_server_common_setup(struct nfs_server *server,
 		struct nfs_fh *mntfh, bool auth_probe)
 {
@@ -1097,7 +1079,7 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 	if (error < 0)
 		goto out;
 
-	nfs4_server_set_init_caps(server);
+	nfs_server_set_init_caps(server);
 
 	/* Probe the root fh to retrieve its FSID and filehandle */
 	error = nfs4_get_rootfh(server, mntfh, auth_probe);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 4abac68a4f0f..71e96fddc6cb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3957,7 +3957,7 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 	};
 	int err;
 
-	nfs4_server_set_init_caps(server);
+	nfs_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 7f48e0d870bd..86f008241c56 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -3216,6 +3216,7 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	loff_t end_pos;
 	int status;
+	bool mark_as_dirty = false;
 
 	if (!pnfs_layoutcommit_outstanding(inode))
 		return 0;
@@ -3267,19 +3268,23 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 	if (ld->prepare_layoutcommit) {
 		status = ld->prepare_layoutcommit(&data->args);
 		if (status) {
-			put_cred(data->cred);
+			if (status != -ENOSPC)
+				put_cred(data->cred);
 			spin_lock(&inode->i_lock);
 			set_bit(NFS_INO_LAYOUTCOMMIT, &nfsi->flags);
 			if (end_pos > nfsi->layout->plh_lwb)
 				nfsi->layout->plh_lwb = end_pos;
-			goto out_unlock;
+			if (status != -ENOSPC)
+				goto out_unlock;
+			spin_unlock(&inode->i_lock);
+			mark_as_dirty = true;
 		}
 	}
 
 
 	status = nfs4_proc_layoutcommit(data, sync);
 out:
-	if (status)
+	if (status || mark_as_dirty)
 		mark_inode_dirty_sync(inode);
 	dprintk("<-- %s status %d\n", __func__, status);
 	return status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index bdee95d714d0..08bfc2b29b65 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4285,10 +4285,16 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 	}
 	status = nfs_ok;
 	if (conf) {
-		old = unconf;
-		unhash_client_locked(old);
-		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
-	} else {
+		if (get_client_locked(conf) == nfs_ok) {
+			old = unconf;
+			unhash_client_locked(old);
+			nfsd4_change_callback(conf, &unconf->cl_cb_conn);
+		} else {
+			conf = NULL;
+		}
+	}
+
+	if (!conf) {
 		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
 		if (old) {
 			status = nfserr_clid_inuse;
@@ -4305,10 +4311,14 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 			}
 			trace_nfsd_clid_replaced(&old->cl_clientid);
 		}
+		status = get_client_locked(unconf);
+		if (status != nfs_ok) {
+			old = NULL;
+			goto out;
+		}
 		move_to_confirmed(unconf);
 		conf = unconf;
 	}
-	get_client_locked(conf);
 	spin_unlock(&nn->client_lock);
 	if (conf == unconf)
 		fsnotify_dentry(conf->cl_nfsd_info_dentry, FS_MODIFY);
@@ -5723,6 +5733,20 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 		status = nfs4_check_deleg(cl, open, &dp);
 		if (status)
 			goto out;
+		if (dp && nfsd4_is_deleg_cur(open) &&
+				(dp->dl_stid.sc_file != fp)) {
+			/*
+			 * RFC8881 section 8.2.4 mandates the server to return
+			 * NFS4ERR_BAD_STATEID if the selected table entry does
+			 * not match the current filehandle. However returning
+			 * NFS4ERR_BAD_STATEID in the OPEN can cause the client
+			 * to repeatedly retry the operation with the same
+			 * stateid, since the stateid itself is valid. To avoid
+			 * this situation NFSD returns NFS4ERR_INVAL instead.
+			 */
+			status = nfserr_inval;
+			goto out;
+		}
 		stp = nfsd4_find_and_lock_existing_open(fp, open);
 	} else {
 		open->op_file = NULL;
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index a4ab0164d150..c49e64ebbd0a 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -304,6 +304,9 @@ static inline bool ntfs_dir_emit(struct ntfs_sb_info *sbi,
 	if (sbi->options->nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
 		return true;
 
+	if (fname->name_len + sizeof(struct NTFS_DE) > le16_to_cpu(e->size))
+		return true;
+
 	name_len = ntfs_utf16_to_nls(sbi, fname->name, fname->name_len, name,
 				     PATH_MAX);
 	if (name_len <= 0) {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 5baf6a2b3d48..844113c3175c 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1114,10 +1114,10 @@ int inode_write_data(struct inode *inode, const void *data, size_t bytes)
  * Number of bytes for REPARSE_DATA_BUFFER(IO_REPARSE_TAG_SYMLINK)
  * for unicode string of @uni_len length.
  */
-static inline u32 ntfs_reparse_bytes(u32 uni_len)
+static inline u32 ntfs_reparse_bytes(u32 uni_len, bool is_absolute)
 {
 	/* Header + unicode string + decorated unicode string. */
-	return sizeof(short) * (2 * uni_len + 4) +
+	return sizeof(short) * (2 * uni_len + (is_absolute ? 4 : 0)) +
 	       offsetof(struct REPARSE_DATA_BUFFER,
 			SymbolicLinkReparseBuffer.PathBuffer);
 }
@@ -1130,8 +1130,11 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 	struct REPARSE_DATA_BUFFER *rp;
 	__le16 *rp_name;
 	typeof(rp->SymbolicLinkReparseBuffer) *rs;
+	bool is_absolute;
 
-	rp = kzalloc(ntfs_reparse_bytes(2 * size + 2), GFP_NOFS);
+	is_absolute = (strlen(symname) > 1 && symname[1] == ':');
+
+	rp = kzalloc(ntfs_reparse_bytes(2 * size + 2, is_absolute), GFP_NOFS);
 	if (!rp)
 		return ERR_PTR(-ENOMEM);
 
@@ -1146,7 +1149,7 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 		goto out;
 
 	/* err = the length of unicode name of symlink. */
-	*nsize = ntfs_reparse_bytes(err);
+	*nsize = ntfs_reparse_bytes(err, is_absolute);
 
 	if (*nsize > sbi->reparse.max_size) {
 		err = -EFBIG;
@@ -1166,7 +1169,7 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 
 	/* PrintName + SubstituteName. */
 	rs->SubstituteNameOffset = cpu_to_le16(sizeof(short) * err);
-	rs->SubstituteNameLength = cpu_to_le16(sizeof(short) * err + 8);
+	rs->SubstituteNameLength = cpu_to_le16(sizeof(short) * err + (is_absolute ? 8 : 0));
 	rs->PrintNameLength = rs->SubstituteNameOffset;
 
 	/*
@@ -1174,16 +1177,18 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 	 * parse this path.
 	 * 0-absolute path 1- relative path (SYMLINK_FLAG_RELATIVE).
 	 */
-	rs->Flags = 0;
+	rs->Flags = cpu_to_le32(is_absolute ? 0 : SYMLINK_FLAG_RELATIVE);
 
-	memmove(rp_name + err + 4, rp_name, sizeof(short) * err);
+	memmove(rp_name + err + (is_absolute ? 4 : 0), rp_name, sizeof(short) * err);
 
-	/* Decorate SubstituteName. */
-	rp_name += err;
-	rp_name[0] = cpu_to_le16('\\');
-	rp_name[1] = cpu_to_le16('?');
-	rp_name[2] = cpu_to_le16('?');
-	rp_name[3] = cpu_to_le16('\\');
+	if (is_absolute) {
+		/* Decorate SubstituteName. */
+		rp_name += err;
+		rp_name[0] = cpu_to_le16('\\');
+		rp_name[1] = cpu_to_le16('?');
+		rp_name[2] = cpu_to_le16('?');
+		rp_name[3] = cpu_to_le16('\\');
+	}
 
 	return rp;
 out:
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index b57140ebfad0..cd4bfd92ebd6 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -354,7 +354,7 @@ static ssize_t orangefs_debug_read(struct file *file,
 		goto out;
 
 	mutex_lock(&orangefs_debug_lock);
-	sprintf_ret = sprintf(buf, "%s", (char *)file->private_data);
+	sprintf_ret = scnprintf(buf, ORANGEFS_MAX_DEBUG_STRING_LEN, "%s", (char *)file->private_data);
 	mutex_unlock(&orangefs_debug_lock);
 
 	read_ret = simple_read_from_buffer(ubuf, count, ppos, buf, sprintf_ret);
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 0c6ade196894..49d772683004 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3933,6 +3933,12 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 			pSMB->FileName[name_len] = 0;
 			pSMB->FileName[name_len+1] = 0;
 			name_len += 2;
+		} else if (!searchName[0]) {
+			pSMB->FileName[0] = CIFS_DIR_SEP(cifs_sb);
+			pSMB->FileName[1] = 0;
+			pSMB->FileName[2] = 0;
+			pSMB->FileName[3] = 0;
+			name_len = 4;
 		}
 	} else {
 		name_len = copy_path_name(pSMB->FileName, searchName);
@@ -3944,6 +3950,10 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 			pSMB->FileName[name_len] = '*';
 			pSMB->FileName[name_len+1] = 0;
 			name_len += 2;
+		} else if (!searchName[0]) {
+			pSMB->FileName[0] = CIFS_DIR_SEP(cifs_sb);
+			pSMB->FileName[1] = 0;
+			name_len = 2;
 		}
 	}
 
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index c3480e84f5c6..7105b7d653f2 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -4217,7 +4217,6 @@ cifs_negotiate_protocol(const unsigned int xid, struct cifs_ses *ses,
 		return 0;
 	}
 
-	server->lstrp = jiffies;
 	server->tcpStatus = CifsInNegotiate;
 	server->neg_start = jiffies;
 	spin_unlock(&server->srv_lock);
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 883d1cb1fc8b..6764d72ab5a5 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -292,6 +292,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	struct cifs_server_iface *last_iface = NULL;
 	struct sockaddr_storage ss;
 	int rc = 0;
+	int retry = 0;
 
 	spin_lock(&ses->chan_lock);
 	chan_index = cifs_ses_get_chan_index(ses, server);
@@ -320,6 +321,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 		return 0;
 	}
 
+try_again:
 	last_iface = list_last_entry(&ses->iface_list, struct cifs_server_iface,
 				     iface_head);
 	iface_min_speed = last_iface->speed;
@@ -358,6 +360,13 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 
 	if (list_entry_is_head(iface, &ses->iface_list, iface_head)) {
 		rc = 1;
+		list_for_each_entry(iface, &ses->iface_list, iface_head)
+			iface->weight_fulfilled = 0;
+
+		/* see if it can be satisfied in second attempt */
+		if (!retry++)
+			goto try_again;
+
 		iface = NULL;
 		cifs_dbg(FYI, "unable to find a suitable iface\n");
 	}
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7d720cf9fe72..4dd5b2e04886 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -714,6 +714,13 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			bytes_left -= sizeof(*p);
 			break;
 		}
+		/* Validate that Next doesn't point beyond the buffer */
+		if (next > bytes_left) {
+			cifs_dbg(VFS, "%s: invalid Next pointer %zu > %zd\n",
+				 __func__, next, bytes_left);
+			rc = -EINVAL;
+			goto out;
+		}
 		p = (struct network_interface_info_ioctl_rsp *)((u8 *)p+next);
 		bytes_left -= next;
 	}
@@ -725,7 +732,9 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	}
 
 	/* Azure rounds the buffer size up 8, to a 16 byte boundary */
-	if ((bytes_left > 8) || p->Next)
+	if ((bytes_left > 8) ||
+	    (bytes_left >= offsetof(struct network_interface_info_ioctl_rsp, Next)
+	     + sizeof(p->Next) && p->Next))
 		cifs_dbg(VFS, "%s: incomplete interface info\n", __func__);
 
 
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 09e1e7771592..92d8a0d898eb 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -436,7 +436,8 @@ void ksmbd_conn_transport_destroy(void)
 {
 	mutex_lock(&init_lock);
 	ksmbd_tcp_destroy();
-	ksmbd_rdma_destroy();
+	ksmbd_rdma_stop_listening();
 	stop_sessions();
+	ksmbd_rdma_destroy();
 	mutex_unlock(&init_lock);
 }
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index 0e72be594e91..1f02e1092434 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -45,7 +45,12 @@ struct ksmbd_conn {
 	struct mutex			srv_mutex;
 	int				status;
 	unsigned int			cli_cap;
-	__be32				inet_addr;
+	union {
+		__be32			inet_addr;
+#if IS_ENABLED(CONFIG_IPV6)
+		u8			inet6_addr[16];
+#endif
+	};
 	char				*request_buf;
 	struct ksmbd_transport		*transport;
 	struct nls_table		*local_nls;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 3e2cd22fb2bd..7943b2ee2a76 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5648,7 +5648,6 @@ static int smb2_create_link(struct ksmbd_work *work,
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
 	struct path path, parent_path;
-	bool file_present = false;
 	int rc;
 
 	if (buf_len < (u64)sizeof(struct smb2_file_link_info) +
@@ -5681,11 +5680,8 @@ static int smb2_create_link(struct ksmbd_work *work,
 	if (rc) {
 		if (rc != -ENOENT)
 			goto out;
-	} else
-		file_present = true;
-
-	if (file_info->ReplaceIfExists) {
-		if (file_present) {
+	} else {
+		if (file_info->ReplaceIfExists) {
 			rc = ksmbd_vfs_remove_file(work, &path);
 			if (rc) {
 				rc = -EINVAL;
@@ -5693,21 +5689,17 @@ static int smb2_create_link(struct ksmbd_work *work,
 					    link_name);
 				goto out;
 			}
-		}
-	} else {
-		if (file_present) {
+		} else {
 			rc = -EEXIST;
 			ksmbd_debug(SMB, "link already exists\n");
 			goto out;
 		}
+		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
 	}
-
 	rc = ksmbd_vfs_link(work, target_name, link_name);
 	if (rc)
 		rc = -EINVAL;
 out:
-	if (file_present)
-		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
 
 	if (!IS_ERR(link_name))
 		kfree(link_name);
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 7d59ed6e1383..3006d76d8059 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -2188,7 +2188,7 @@ int ksmbd_rdma_init(void)
 	return 0;
 }
 
-void ksmbd_rdma_destroy(void)
+void ksmbd_rdma_stop_listening(void)
 {
 	if (!smb_direct_listener.cm_id)
 		return;
@@ -2197,7 +2197,10 @@ void ksmbd_rdma_destroy(void)
 	rdma_destroy_id(smb_direct_listener.cm_id);
 
 	smb_direct_listener.cm_id = NULL;
+}
 
+void ksmbd_rdma_destroy(void)
+{
 	if (smb_direct_wq) {
 		destroy_workqueue(smb_direct_wq);
 		smb_direct_wq = NULL;
diff --git a/fs/smb/server/transport_rdma.h b/fs/smb/server/transport_rdma.h
index 77aee4e5c9dc..a2291b77488a 100644
--- a/fs/smb/server/transport_rdma.h
+++ b/fs/smb/server/transport_rdma.h
@@ -54,13 +54,15 @@ struct smb_direct_data_transfer {
 
 #ifdef CONFIG_SMB_SERVER_SMBDIRECT
 int ksmbd_rdma_init(void);
+void ksmbd_rdma_stop_listening(void);
 void ksmbd_rdma_destroy(void);
 bool ksmbd_rdma_capable_netdev(struct net_device *netdev);
 void init_smbd_max_io_size(unsigned int sz);
 unsigned int get_smbd_max_read_write_size(void);
 #else
 static inline int ksmbd_rdma_init(void) { return 0; }
-static inline int ksmbd_rdma_destroy(void) { return 0; }
+static inline void ksmbd_rdma_stop_listening(void) { }
+static inline void ksmbd_rdma_destroy(void) { }
 static inline bool ksmbd_rdma_capable_netdev(struct net_device *netdev) { return false; }
 static inline void init_smbd_max_io_size(unsigned int sz) { }
 static inline unsigned int get_smbd_max_read_write_size(void) { return 0; }
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 1222cf6be5ef..a4e7d1a5d64d 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -87,7 +87,14 @@ static struct tcp_transport *alloc_transport(struct socket *client_sk)
 		return NULL;
 	}
 
+#if IS_ENABLED(CONFIG_IPV6)
+	if (client_sk->sk->sk_family == AF_INET6)
+		memcpy(&conn->inet6_addr, &client_sk->sk->sk_v6_daddr, 16);
+	else
+		conn->inet_addr = inet_sk(client_sk->sk)->inet_daddr;
+#else
 	conn->inet_addr = inet_sk(client_sk->sk)->inet_daddr;
+#endif
 	conn->transport = KSMBD_TRANS(t);
 	KSMBD_TRANS(t)->conn = conn;
 	KSMBD_TRANS(t)->ops = &ksmbd_tcp_transport_ops;
@@ -227,7 +234,6 @@ static int ksmbd_kthread_fn(void *p)
 {
 	struct socket *client_sk = NULL;
 	struct interface *iface = (struct interface *)p;
-	struct inet_sock *csk_inet;
 	struct ksmbd_conn *conn;
 	int ret;
 
@@ -250,13 +256,27 @@ static int ksmbd_kthread_fn(void *p)
 		/*
 		 * Limits repeated connections from clients with the same IP.
 		 */
-		csk_inet = inet_sk(client_sk->sk);
 		down_read(&conn_list_lock);
 		list_for_each_entry(conn, &conn_list, conns_list)
-			if (csk_inet->inet_daddr == conn->inet_addr) {
+#if IS_ENABLED(CONFIG_IPV6)
+			if (client_sk->sk->sk_family == AF_INET6) {
+				if (memcmp(&client_sk->sk->sk_v6_daddr,
+					   &conn->inet6_addr, 16) == 0) {
+					ret = -EAGAIN;
+					break;
+				}
+			} else if (inet_sk(client_sk->sk)->inet_daddr ==
+				 conn->inet_addr) {
+				ret = -EAGAIN;
+				break;
+			}
+#else
+			if (inet_sk(client_sk->sk)->inet_daddr ==
+			    conn->inet_addr) {
 				ret = -EAGAIN;
 				break;
 			}
+#endif
 		up_read(&conn_list_lock);
 		if (ret == -EAGAIN)
 			continue;
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 37579c07f6fd..a226001b7658 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -123,10 +123,15 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	unsigned short flags;
 	unsigned int fragments;
 	u64 lookup_table_start, xattr_id_table_start, next_table;
-	int err;
+	int err, devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
 
 	TRACE("Entered squashfs_fill_superblock\n");
 
+	if (!devblksize) {
+		errorf(fc, "squashfs: unable to set blocksize\n");
+		return -EINVAL;
+	}
+
 	sb->s_fs_info = kzalloc(sizeof(*msblk), GFP_KERNEL);
 	if (sb->s_fs_info == NULL) {
 		ERROR("Failed to allocate squashfs_sb_info\n");
@@ -136,12 +141,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	msblk->panic_on_errors = (opts->errors == Opt_errors_panic);
 
-	msblk->devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
-	if (!msblk->devblksize) {
-		errorf(fc, "squashfs: unable to set blocksize\n");
-		return -EINVAL;
-	}
-
+	msblk->devblksize = devblksize;
 	msblk->devblksize_log2 = ffz(~msblk->devblksize);
 
 	mutex_init(&msblk->meta_index_mutex);
diff --git a/fs/udf/super.c b/fs/udf/super.c
index fa790be4f19f..a186d2418b50 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1410,7 +1410,7 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
 	struct genericPartitionMap *gpm;
 	uint16_t ident;
 	struct buffer_head *bh;
-	unsigned int table_len;
+	unsigned int table_len, part_map_count;
 	int ret;
 
 	bh = udf_read_tagged(sb, block, block, &ident);
@@ -1431,7 +1431,16 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
 					   "logical volume");
 	if (ret)
 		goto out_bh;
-	ret = udf_sb_alloc_partition_maps(sb, le32_to_cpu(lvd->numPartitionMaps));
+
+	part_map_count = le32_to_cpu(lvd->numPartitionMaps);
+	if (part_map_count > table_len / sizeof(struct genericPartitionMap1)) {
+		udf_err(sb, "error loading logical volume descriptor: "
+			"Too many partition maps (%u > %u)\n", part_map_count,
+			table_len / (unsigned)sizeof(struct genericPartitionMap1));
+		ret = -EIO;
+		goto out_bh;
+	}
+	ret = udf_sb_alloc_partition_maps(sb, part_map_count);
 	if (ret)
 		goto out_bh;
 
diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
index 44d603364d5a..bd59b34edc00 100644
--- a/fs/xfs/xfs_itable.c
+++ b/fs/xfs/xfs_itable.c
@@ -422,11 +422,15 @@ xfs_inumbers(
 		.breq		= breq,
 	};
 	struct xfs_trans	*tp;
+	unsigned int		iwalk_flags = 0;
 	int			error = 0;
 
 	if (xfs_bulkstat_already_done(breq->mp, breq->startino))
 		return 0;
 
+	if (breq->flags & XFS_IBULK_SAME_AG)
+		iwalk_flags |= XFS_IWALK_SAME_AG;
+
 	/*
 	 * Grab an empty transaction so that we can use its recursive buffer
 	 * locking abilities to detect cycles in the inobt without deadlocking.
@@ -435,7 +439,7 @@ xfs_inumbers(
 	if (error)
 		goto out;
 
-	error = xfs_inobt_walk(breq->mp, tp, breq->startino, breq->flags,
+	error = xfs_inobt_walk(breq->mp, tp, breq->startino, iwalk_flags,
 			xfs_inumbers_walk, breq->icount, &ic);
 	xfs_trans_cancel(tp);
 out:
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index e0b098089ef2..7e84f414a166 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -366,6 +366,8 @@ enum req_op {
 	REQ_OP_DISCARD		= (__force blk_opf_t)3,
 	/* securely erase sectors */
 	REQ_OP_SECURE_ERASE	= (__force blk_opf_t)5,
+	/* write data at the current zone write pointer */
+	REQ_OP_ZONE_APPEND	= (__force blk_opf_t)7,
 	/* write the zero filled sector many times */
 	REQ_OP_WRITE_ZEROES	= (__force blk_opf_t)9,
 	/* Open a zone */
@@ -373,9 +375,7 @@ enum req_op {
 	/* Close a zone */
 	REQ_OP_ZONE_CLOSE	= (__force blk_opf_t)11,
 	/* Transition a zone to full */
-	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)12,
-	/* write data at the current zone write pointer */
-	REQ_OP_ZONE_APPEND	= (__force blk_opf_t)13,
+	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)13,
 	/* reset a zone write pointer */
 	REQ_OP_ZONE_RESET	= (__force blk_opf_t)15,
 	/* reset all the zone present on the device */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index fdfe8e6ff0b2..f6ea15821cea 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -235,14 +235,6 @@ static inline void *offset_to_ptr(const int *off)
 #define __ADDRESSABLE(sym) \
 	___ADDRESSABLE(sym, __section(".discard.addressable"))
 
-#define __ADDRESSABLE_ASM(sym)						\
-	.pushsection .discard.addressable,"aw";				\
-	.align ARCH_SEL(8,4);						\
-	ARCH_SEL(.quad, .long) __stringify(sym);			\
-	.popsection;
-
-#define __ADDRESSABLE_ASM_STR(sym) __stringify(__ADDRESSABLE_ASM(sym))
-
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1a619b681bcc..48758ab29100 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -410,7 +410,7 @@ extern const struct address_space_operations empty_aops;
  *   It is also used to block modification of page cache contents through
  *   memory mappings.
  * @gfp_mask: Memory allocation flags to use for allocating pages.
- * @i_mmap_writable: Number of VM_SHARED mappings.
+ * @i_mmap_writable: Number of VM_SHARED, VM_MAYWRITE mappings.
  * @nr_thps: Number of THPs in the pagecache (non-shmem only).
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
@@ -513,7 +513,7 @@ static inline int mapping_mapped(struct address_space *mapping)
 
 /*
  * Might pages of this file have been modified in userspace?
- * Note that i_mmap_writable counts all VM_SHARED vmas: do_mmap
+ * Note that i_mmap_writable counts all VM_SHARED, VM_MAYWRITE vmas: do_mmap
  * marks vma as VM_SHARED if it is shared, and the file was opened for
  * writing i.e. vma may be mprotected writable even if now readonly.
  *
diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
index 9efbc54e35e5..be5417303ecf 100644
--- a/include/linux/hypervisor.h
+++ b/include/linux/hypervisor.h
@@ -37,6 +37,9 @@ static inline bool hypervisor_isolated_pci_functions(void)
 	if (IS_ENABLED(CONFIG_S390))
 		return true;
 
+	if (IS_ENABLED(CONFIG_LOONGARCH))
+		return true;
+
 	return jailhouse_paravirt();
 }
 
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 9f7dbbb34094..f4eb8dd7308a 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -253,19 +253,19 @@ vlan_for_each(struct net_device *dev,
 
 static inline struct net_device *vlan_dev_real_dev(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return NULL;
 }
 
 static inline u16 vlan_dev_vlan_id(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return 0;
 }
 
 static inline __be16 vlan_dev_vlan_proto(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return 0;
 }
 
diff --git a/include/linux/iosys-map.h b/include/linux/iosys-map.h
index cb71aa616bd3..631d58d0b838 100644
--- a/include/linux/iosys-map.h
+++ b/include/linux/iosys-map.h
@@ -264,12 +264,7 @@ static inline bool iosys_map_is_set(const struct iosys_map *map)
  */
 static inline void iosys_map_clear(struct iosys_map *map)
 {
-	if (map->is_iomem) {
-		map->vaddr_iomem = NULL;
-		map->is_iomem = false;
-	} else {
-		map->vaddr = NULL;
-	}
+	memset(map, 0, sizeof(*map));
 }
 
 /**
diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index 4f1600413f91..5d06bba9d7e5 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -6,11 +6,25 @@
 
 #ifdef CONFIG_MEMFD_CREATE
 extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg);
+unsigned int *memfd_file_seals_ptr(struct file *file);
 #else
 static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned long a)
 {
 	return -EINVAL;
 }
+
+static inline unsigned int *memfd_file_seals_ptr(struct file *file)
+{
+	return NULL;
+}
 #endif
 
+/* Retrieve memfd seals associated with the file, if any. */
+static inline unsigned int memfd_file_seals(struct file *file)
+{
+	unsigned int *sealsp = memfd_file_seals_ptr(file);
+
+	return sealsp ? *sealsp : 0;
+}
+
 #endif /* __LINUX_MEMFD_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b36dffbfbe69..9e17670de848 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -673,6 +673,17 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
 
+static inline bool is_shared_maywrite(vm_flags_t vm_flags)
+{
+	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
+		(VM_SHARED | VM_MAYWRITE);
+}
+
+static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
+{
+	return is_shared_maywrite(vma->vm_flags);
+}
+
 static inline
 struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
 {
@@ -3514,34 +3525,57 @@ void mem_dump_obj(void *object);
 static inline void mem_dump_obj(void *object) {}
 #endif
 
+static inline bool is_write_sealed(int seals)
+{
+	return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
+}
+
+/**
+ * is_readonly_sealed - Checks whether write-sealed but mapped read-only,
+ *                      in which case writes should be disallowing moving
+ *                      forwards.
+ * @seals: the seals to check
+ * @vm_flags: the VMA flags to check
+ *
+ * Returns whether readonly sealed, in which case writess should be disallowed
+ * going forward.
+ */
+static inline bool is_readonly_sealed(int seals, vm_flags_t vm_flags)
+{
+	/*
+	 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
+	 * MAP_SHARED and read-only, take care to not allow mprotect to
+	 * revert protections on such mappings. Do this only for shared
+	 * mappings. For private mappings, don't need to mask
+	 * VM_MAYWRITE as we still want them to be COW-writable.
+	 */
+	if (is_write_sealed(seals) &&
+	    ((vm_flags & (VM_SHARED | VM_WRITE)) == VM_SHARED))
+		return true;
+
+	return false;
+}
+
 /**
- * seal_check_future_write - Check for F_SEAL_FUTURE_WRITE flag and handle it
+ * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flags and
+ *                    handle them.
  * @seals: the seals to check
  * @vma: the vma to operate on
  *
- * Check whether F_SEAL_FUTURE_WRITE is set; if so, do proper check/handling on
- * the vma flags.  Return 0 if check pass, or <0 for errors.
- */
-static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
-{
-	if (seals & F_SEAL_FUTURE_WRITE) {
-		/*
-		 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
-		 * "future write" seal active.
-		 */
-		if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
-			return -EPERM;
-
-		/*
-		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
-		 * MAP_SHARED and read-only, take care to not allow mprotect to
-		 * revert protections on such mappings. Do this only for shared
-		 * mappings. For private mappings, don't need to mask
-		 * VM_MAYWRITE as we still want them to be COW-writable.
-		 */
-		if (vma->vm_flags & VM_SHARED)
-			vma->vm_flags &= ~(VM_MAYWRITE);
-	}
+ * Check whether F_SEAL_WRITE or F_SEAL_FUTURE_WRITE are set; if so, do proper
+ * check/handling on the vma flags.  Return 0 if check pass, or <0 for errors.
+ */
+static inline int seal_check_write(int seals, struct vm_area_struct *vma)
+{
+	if (!is_write_sealed(seals))
+		return 0;
+
+	/*
+	 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
+	 * write seals are active.
+	 */
+	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
+		return -EPERM;
 
 	return 0;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2fd6c6050bb5..df36df4695ed 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -317,7 +317,14 @@ struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
 
-/* The pci_dev structure describes PCI devices */
+/* struct pci_dev - describes a PCI device
+ *
+ * @is_hotplug_bridge:	Hotplug bridge of any kind (e.g. PCIe Hot-Plug Capable,
+ *			Conventional PCI Hot-Plug, ACPI slot).
+ *			Such bridges are allocated additional MMIO and bus
+ *			number resources to allow for hierarchy expansion.
+ * @is_pciehp:		PCIe Hot-Plug Capable bridge.
+ */
 struct pci_dev {
 	struct list_head bus_list;	/* Node in per-bus list */
 	struct pci_bus	*bus;		/* Bus this device is on */
@@ -438,6 +445,7 @@ struct pci_dev {
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
 	unsigned int	is_hotplug_bridge:1;
+	unsigned int	is_pciehp:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
 	/*
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index e43107e0bee1..2bf307e74490 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -9,6 +9,7 @@
 #define __LINUX_CROS_EC_PROTO_H
 
 #include <linux/device.h>
+#include <linux/lockdep_types.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
@@ -116,6 +117,8 @@ struct cros_ec_command {
  *            command. The caller should check msg.result for the EC's result
  *            code.
  * @pkt_xfer: Send packet to EC and get response.
+ * @lockdep_key: Lockdep class for each instance. Unused if CONFIG_LOCKDEP is
+ *		 not enabled.
  * @lock: One transaction at a time.
  * @mkbp_event_supported: 0 if MKBP not supported. Otherwise its value is
  *                        the maximum supported version of the MKBP host event
@@ -160,6 +163,7 @@ struct cros_ec_device {
 			struct cros_ec_command *msg);
 	int (*pkt_xfer)(struct cros_ec_device *ec,
 			struct cros_ec_command *msg);
+	struct lock_class_key lockdep_key;
 	struct mutex lock;
 	u8 mkbp_event_supported;
 	bool host_sleep_v1;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8014a335414e..9a04a188b9f8 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3495,7 +3495,13 @@ static inline void *skb_frag_address(const skb_frag_t *frag)
  */
 static inline void *skb_frag_address_safe(const skb_frag_t *frag)
 {
-	void *ptr = page_address(skb_frag_page(frag));
+	struct page *page = skb_frag_page(frag);
+	void *ptr;
+
+	if (!page)
+		return NULL;
+
+	ptr = page_address(page);
 	if (unlikely(!ptr))
 		return NULL;
 
diff --git a/include/linux/usb/cdc_ncm.h b/include/linux/usb/cdc_ncm.h
index 2d207cb4837d..4ac082a63173 100644
--- a/include/linux/usb/cdc_ncm.h
+++ b/include/linux/usb/cdc_ncm.h
@@ -119,6 +119,7 @@ struct cdc_ncm_ctx {
 	u32 timer_interval;
 	u32 max_ndp_size;
 	u8 is_ndp16;
+	u8 filtering_supported;
 	union {
 		struct usb_cdc_ncm_ndp16 *delayed_ndp16;
 		struct usb_cdc_ncm_ndp32 *delayed_ndp32;
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 3f9c16611306..689e9fc50e1b 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -110,7 +110,12 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
 	return (size_t)(skb_end_pointer(skb) - skb->head);
 }
 
-#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
+/* Dimension the RX SKB so that the entire thing fits exactly into
+ * a single 4KiB page. This avoids wasting memory due to alloc_skb()
+ * rounding up to the next page order and also means that we
+ * don't leave higher-order pages sitting around in the RX queue.
+ */
+#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	SKB_WITH_OVERHEAD(1024 * 4)
 #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
 #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
 
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index a016f275cb01..5047711944df 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -54,6 +54,8 @@ typedef enum {
 	AD_MUX_DETACHED,	/* mux machine */
 	AD_MUX_WAITING,		/* mux machine */
 	AD_MUX_ATTACHED,	/* mux machine */
+	AD_MUX_COLLECTING,	/* mux machine */
+	AD_MUX_DISTRIBUTING,	/* mux machine */
 	AD_MUX_COLLECTING_DISTRIBUTING	/* mux machine */
 } mux_states_t;
 
@@ -303,6 +305,7 @@ int bond_3ad_lacpdu_recv(const struct sk_buff *skb, struct bonding *bond,
 int bond_3ad_set_carrier(struct bonding *bond);
 void bond_3ad_update_lacp_active(struct bonding *bond);
 void bond_3ad_update_lacp_rate(struct bonding *bond);
+void bond_3ad_update_lacp_active(struct bonding *bond);
 void bond_3ad_update_ad_actor_settings(struct bonding *bond);
 int bond_3ad_stats_fill(struct sk_buff *skb, struct bond_3ad_stats *stats);
 size_t bond_3ad_stats_size(void);
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index f631d9f09941..18687ccf0638 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -76,6 +76,7 @@ enum {
 	BOND_OPT_MISSED_MAX,
 	BOND_OPT_NS_TARGETS,
 	BOND_OPT_PRIO,
+	BOND_OPT_COUPLED_CONTROL,
 	BOND_OPT_LAST
 };
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 9a3ac960dfe1..bfd3e4e58f86 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -152,6 +152,7 @@ struct bond_params {
 #if IS_ENABLED(CONFIG_IPV6)
 	struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
 #endif
+	int coupled_control;
 
 	/* 2 bytes of padding : see ether_addr_equal_64bits() */
 	u8 ad_actor_system[ETH_ALEN + 2];
@@ -171,6 +172,7 @@ struct slave {
 	u8     backup:1,   /* indicates backup slave. Value corresponds with
 			      BOND_STATE_ACTIVE and BOND_STATE_BACKUP */
 	       inactive:1, /* indicates inactive slave */
+	       rx_disabled:1, /* indicates whether slave's Rx is disabled */
 	       should_notify:1, /* indicates whether the state changed */
 	       should_notify_link:1; /* indicates whether the link changed */
 	u8     duplex;
@@ -574,6 +576,14 @@ static inline void bond_set_slave_inactive_flags(struct slave *slave,
 		bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
 	if (!slave->bond->params.all_slaves_active)
 		slave->inactive = 1;
+	if (BOND_MODE(slave->bond) == BOND_MODE_8023AD)
+		slave->rx_disabled = 1;
+}
+
+static inline void bond_set_slave_tx_disabled_flags(struct slave *slave,
+						 bool notify)
+{
+	bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
 }
 
 static inline void bond_set_slave_active_flags(struct slave *slave,
@@ -581,6 +591,14 @@ static inline void bond_set_slave_active_flags(struct slave *slave,
 {
 	bond_set_slave_state(slave, BOND_STATE_ACTIVE, notify);
 	slave->inactive = 0;
+	if (BOND_MODE(slave->bond) == BOND_MODE_8023AD)
+		slave->rx_disabled = 0;
+}
+
+static inline void bond_set_slave_rx_enabled_flags(struct slave *slave,
+					       bool notify)
+{
+	slave->rx_disabled = 0;
 }
 
 static inline bool bond_is_slave_inactive(struct slave *slave)
@@ -588,6 +606,11 @@ static inline bool bond_is_slave_inactive(struct slave *slave)
 	return slave->inactive;
 }
 
+static inline bool bond_is_slave_rx_disabled(struct slave *slave)
+{
+	return slave->rx_disabled;
+}
+
 static inline void bond_propose_link_state(struct slave *slave, int state)
 {
 	slave->link_new_state = state;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2a0fc4a64af1..e35bc5c35732 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -559,7 +559,7 @@ ieee80211_get_sband_iftype_data(const struct ieee80211_supported_band *sband,
 {
 	int i;
 
-	if (WARN_ON(iftype >= NL80211_IFTYPE_MAX))
+	if (WARN_ON(iftype >= NUM_NL80211_IFTYPES))
 		return NULL;
 
 	if (iftype == NL80211_IFTYPE_AP_VLAN)
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 6ef8348b5e93..28a9b9c00e6b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4011,6 +4011,8 @@ struct ieee80211_prep_tx_info {
  * @mgd_complete_tx: Notify the driver that the response frame for a previously
  *	transmitted frame announced with @mgd_prepare_tx was received, the data
  *	is filled similarly to @mgd_prepare_tx though the duration is not used.
+ *	Note that this isn't always called for each mgd_prepare_tx() call, for
+ *	example for SAE the 'confirm' messages can be on the air in any order.
  *
  * @mgd_protect_tdls_discover: Protect a TDLS discovery session. After sending
  *	a TDLS discovery-request, we expect a reply to arrive on the AP's
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index ccc4a0f8b4ad..93aecfaa7628 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -180,6 +180,7 @@ struct pneigh_entry {
 	netdevice_tracker	dev_tracker;
 	u32			flags;
 	u8			protocol;
+	bool			permanent;
 	u32			key[];
 };
 
diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index ea7509672086..9fece4e37828 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -272,6 +272,15 @@ int snd_soc_dai_compr_get_metadata(struct snd_soc_dai *dai,
 				   struct snd_compr_metadata *metadata);
 
 struct snd_soc_dai_ops {
+	/* DAI driver callbacks */
+	int (*probe)(struct snd_soc_dai *dai);
+	int (*remove)(struct snd_soc_dai *dai);
+	/* compress dai */
+	int (*compress_new)(struct snd_soc_pcm_runtime *rtd, int num);
+	/* Optional Callback used at pcm creation*/
+	int (*pcm_new)(struct snd_soc_pcm_runtime *rtd,
+		       struct snd_soc_dai *dai);
+
 	/*
 	 * DAI clocking configuration, all optional.
 	 * Called by soc_card drivers, normally in their hw_params.
@@ -353,6 +362,10 @@ struct snd_soc_dai_ops {
 	u64 *auto_selectable_formats;
 	int num_auto_selectable_formats;
 
+	/* probe ordering - for components with runtime dependencies */
+	int probe_order;
+	int remove_order;
+
 	/* bit field */
 	unsigned int no_capture_mute:1;
 };
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 5e7a1041df3a..feebb4509abd 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -938,6 +938,7 @@ enum {
 	IFLA_BOND_AD_LACP_ACTIVE,
 	IFLA_BOND_MISSED_MAX,
 	IFLA_BOND_NS_IP6_TARGET,
+	IFLA_BOND_COUPLED_CONTROL,
 	__IFLA_BOND_MAX,
 };
 
diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
index ff8d21f9e95b..5a47339ef7d7 100644
--- a/include/uapi/linux/in6.h
+++ b/include/uapi/linux/in6.h
@@ -152,7 +152,6 @@ struct in6_flowlabel_req {
 /*
  *	IPV6 socket options
  */
-#if __UAPI_DEF_IPV6_OPTIONS
 #define IPV6_ADDRFORM		1
 #define IPV6_2292PKTINFO	2
 #define IPV6_2292HOPOPTS	3
@@ -169,8 +168,10 @@ struct in6_flowlabel_req {
 #define IPV6_MULTICAST_IF	17
 #define IPV6_MULTICAST_HOPS	18
 #define IPV6_MULTICAST_LOOP	19
+#if __UAPI_DEF_IPV6_OPTIONS
 #define IPV6_ADD_MEMBERSHIP	20
 #define IPV6_DROP_MEMBERSHIP	21
+#endif
 #define IPV6_ROUTER_ALERT	22
 #define IPV6_MTU_DISCOVER	23
 #define IPV6_MTU		24
@@ -203,7 +204,6 @@ struct in6_flowlabel_req {
 #define IPV6_IPSEC_POLICY	34
 #define IPV6_XFRM_POLICY	35
 #define IPV6_HDRINCL		36
-#endif
 
 /*
  * Multicast:
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 8f8e39cd183e..a8579ec1a868 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -38,7 +38,7 @@ struct io_uring_sqe {
 	};
 	__u32	len;		/* buffer size or number of iovecs */
 	union {
-		__kernel_rwf_t	rw_flags;
+		__u32		rw_flags;
 		__u32		fsync_flags;
 		__u16		poll_events;	/* compatibility */
 		__u32		poll32_events;	/* word-reversed for BE */
diff --git a/include/uapi/linux/pfrut.h b/include/uapi/linux/pfrut.h
index 42fa15f8310d..b77d5c210c26 100644
--- a/include/uapi/linux/pfrut.h
+++ b/include/uapi/linux/pfrut.h
@@ -89,6 +89,7 @@ struct pfru_payload_hdr {
 	__u32 hw_ver;
 	__u32 rt_ver;
 	__u8 platform_id[16];
+	__u32 svn_ver;
 };
 
 enum pfru_dsm_status {
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 370a6bce20a8..216bdebd9426 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -455,7 +455,7 @@ static inline void check_insane_mems_config(nodemask_t *nodes)
 {
 	if (!cpusets_insane_config() &&
 		movable_only_nodes(nodes)) {
-		static_branch_enable(&cpusets_insane_config_key);
+		static_branch_enable_cpuslocked(&cpusets_insane_config_key);
 		pr_info("Unsupported (movable nodes only) cpuset configuration detected (nmask=%*pbl)!\n"
 			"Cpuset allocations might fail even with a lot of memory available.\n",
 			nodemask_pr_args(nodes));
diff --git a/kernel/fork.c b/kernel/fork.c
index 8cc313d27188..da318028aa88 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -669,7 +669,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 
 			get_file(file);
 			i_mmap_lock_write(mapping);
-			if (tmp->vm_flags & VM_SHARED)
+			if (vma_is_shared_maywrite(tmp))
 				mapping_allow_writable(mapping);
 			flush_dcache_mmap_lock(mapping);
 			/* insert tmp into the share list, just after mpnt */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 554aba47ab68..3269f6c46814 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -699,14 +699,16 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	struct module *mod;
 	char name[MODULE_NAME_LEN];
 	char buf[MODULE_FLAGS_BUF_SIZE];
-	int ret, forced = 0;
+	int ret, len, forced = 0;
 
 	if (!capable(CAP_SYS_MODULE) || modules_disabled)
 		return -EPERM;
 
-	if (strncpy_from_user(name, name_user, MODULE_NAME_LEN-1) < 0)
-		return -EFAULT;
-	name[MODULE_NAME_LEN-1] = '\0';
+	len = strncpy_from_user(name, name_user, MODULE_NAME_LEN);
+	if (len == 0 || len == MODULE_NAME_LEN)
+		return -ENOENT;
+	if (len < 0)
+		return len;
 
 	audit_log_kern_module(name);
 
diff --git a/kernel/power/console.c b/kernel/power/console.c
index fcdf0e14a47d..19c48aa5355d 100644
--- a/kernel/power/console.c
+++ b/kernel/power/console.c
@@ -16,6 +16,7 @@
 #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 
 static int orig_fgconsole, orig_kmsg;
+static bool vt_switch_done;
 
 static DEFINE_MUTEX(vt_switch_mutex);
 
@@ -136,17 +137,21 @@ void pm_prepare_console(void)
 	if (orig_fgconsole < 0)
 		return;
 
+	vt_switch_done = true;
+
 	orig_kmsg = vt_kmsg_redirect(SUSPEND_CONSOLE);
 	return;
 }
 
 void pm_restore_console(void)
 {
-	if (!pm_vt_switch())
+	if (!pm_vt_switch() && !vt_switch_done)
 		return;
 
 	if (orig_fgconsole >= 0) {
 		vt_move_to_console(orig_fgconsole, 0);
 		vt_kmsg_redirect(orig_kmsg);
 	}
+
+	vt_switch_done = false;
 }
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3929ef8148c1..6fc1ff14bfdf 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -612,10 +612,13 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
  */
 static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 {
+	unsigned long flags;
 	struct rcu_data *rdp;
 
 	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
+	local_irq_save(flags);
 	rdp->defer_qs_iw_pending = false;
+	local_irq_restore(flags);
 }
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d30e0936cfec..2deb896883d3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10941,8 +10941,14 @@ static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
 		/*
 		 * Track max cost of a domain to make sure to not delay the
 		 * next wakeup on the CPU.
+		 *
+		 * sched_balance_newidle() bumps the cost whenever newidle
+		 * balance fails, and we don't want things to grow out of
+		 * control.  Use the sysctl_sched_migration_cost as the upper
+		 * limit, plus a litle extra to avoid off by ones.
 		 */
-		sd->max_newidle_lb_cost = cost;
+		sd->max_newidle_lb_cost =
+			min(cost, sysctl_sched_migration_cost + 200);
 		sd->last_decay_max_lb_cost = jiffies;
 	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
 		/*
@@ -11624,10 +11630,17 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
-			update_newidle_cost(sd, domain_cost);
-
 			curr_cost += domain_cost;
 			t0 = t1;
+
+			/*
+			 * Failing newidle means it is not effective;
+			 * bump the cost so we end up doing less of it.
+			 */
+			if (!pulled_task)
+				domain_cost = (3 * sd->max_newidle_lb_cost) / 2;
+
+			update_newidle_cost(sd, domain_cost);
 		}
 
 		/*
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 58524d938749..cebed90b2e16 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3934,13 +3934,17 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 	        } else {
 			iter->hash = alloc_and_copy_ftrace_hash(size_bits, hash);
 		}
+	} else {
+		if (hash)
+			iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
+		else
+			iter->hash = EMPTY_HASH;
+	}
 
-		if (!iter->hash) {
-			trace_parser_put(&iter->parser);
-			goto out_unlock;
-		}
-	} else
-		iter->hash = hash;
+	if (!iter->hash) {
+		trace_parser_put(&iter->parser);
+		goto out_unlock;
+	}
 
 	ret = 0;
 
@@ -6132,9 +6136,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
 						      iter->hash, filter_hash);
 		mutex_unlock(&ftrace_lock);
-	} else {
-		/* For read only, the hash is the ops hash */
-		iter->hash = NULL;
 	}
 
 	mutex_unlock(&iter->ops->func_hash->regex_lock);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 09fbeae53ba4..874f869ae72e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1618,7 +1618,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 
 	ret = get_user(ch, ubuf++);
 	if (ret)
-		goto out;
+		goto fail;
 
 	read++;
 	cnt--;
@@ -1632,7 +1632,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		while (cnt && isspace(ch)) {
 			ret = get_user(ch, ubuf++);
 			if (ret)
-				goto out;
+				goto fail;
 			read++;
 			cnt--;
 		}
@@ -1642,8 +1642,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		/* only spaces were written */
 		if (isspace(ch) || !ch) {
 			*ppos += read;
-			ret = read;
-			goto out;
+			return read;
 		}
 	}
 
@@ -1653,11 +1652,12 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 			parser->buffer[parser->idx++] = ch;
 		else {
 			ret = -EINVAL;
-			goto out;
+			goto fail;
 		}
+
 		ret = get_user(ch, ubuf++);
 		if (ret)
-			goto out;
+			goto fail;
 		read++;
 		cnt--;
 	}
@@ -1673,13 +1673,13 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		parser->buffer[parser->idx] = 0;
 	} else {
 		ret = -EINVAL;
-		goto out;
+		goto fail;
 	}
 
 	*ppos += read;
-	ret = read;
-
-out:
+	return read;
+fail:
+	trace_parser_fail(parser);
 	return ret;
 }
 
@@ -2149,10 +2149,10 @@ int __init register_tracer(struct tracer *type)
 	mutex_unlock(&trace_types_lock);
 
 	if (ret || !default_bootup_tracer)
-		goto out_unlock;
+		return ret;
 
 	if (strncmp(default_bootup_tracer, type->name, MAX_TRACER_SIZE))
-		goto out_unlock;
+		return 0;
 
 	printk(KERN_INFO "Starting tracer '%s'\n", type->name);
 	/* Do we want this tracer to start on bootup? */
@@ -2164,8 +2164,7 @@ int __init register_tracer(struct tracer *type)
 	/* disable other selftests, since this will break it. */
 	disable_tracing_selftest("running a tracer");
 
- out_unlock:
-	return ret;
+	return 0;
 }
 
 static void tracing_reset_cpu(struct array_buffer *buf, int cpu)
@@ -8761,11 +8760,10 @@ ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
  out_reg:
 	ret = tracing_alloc_snapshot_instance(tr);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = register_ftrace_function_probe(glob, tr, ops, count);
 
- out:
 	return ret < 0 ? ret : 0;
 }
 
@@ -10292,7 +10290,7 @@ __init static int tracer_alloc_buffers(void)
 	BUILD_BUG_ON(TRACE_ITER_LAST_BIT > TRACE_FLAGS_MAX_SIZE);
 
 	if (!alloc_cpumask_var(&tracing_buffer_mask, GFP_KERNEL))
-		goto out;
+		return -ENOMEM;
 
 	if (!alloc_cpumask_var(&global_trace.tracing_cpumask, GFP_KERNEL))
 		goto out_free_buffer_mask;
@@ -10405,7 +10403,6 @@ __init static int tracer_alloc_buffers(void)
 	free_cpumask_var(global_trace.tracing_cpumask);
 out_free_buffer_mask:
 	free_cpumask_var(tracing_buffer_mask);
-out:
 	return ret;
 }
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 950782b0ab1c..9a6568217fc9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1131,6 +1131,7 @@ bool ftrace_event_is_function(struct trace_event_call *call);
  */
 struct trace_parser {
 	bool		cont;
+	bool		fail;
 	char		*buffer;
 	unsigned	idx;
 	unsigned	size;
@@ -1138,7 +1139,7 @@ struct trace_parser {
 
 static inline bool trace_parser_loaded(struct trace_parser *parser)
 {
-	return (parser->idx != 0);
+	return !parser->fail && parser->idx != 0;
 }
 
 static inline bool trace_parser_cont(struct trace_parser *parser)
@@ -1152,6 +1153,11 @@ static inline void trace_parser_clear(struct trace_parser *parser)
 	parser->idx = 0;
 }
 
+static inline void trace_parser_fail(struct trace_parser *parser)
+{
+	parser->fail = true;
+}
+
 extern int trace_parser_get_init(struct trace_parser *parser, int size);
 extern void trace_parser_put(struct trace_parser *parser);
 extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index dc7df1254f0a..fe0076471edd 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1063,29 +1063,34 @@ static void __init destroy_args(struct pgtable_debug_args *args)
 
 	/* Free page table entries */
 	if (args->start_ptep) {
+		pmd_clear(args->pmdp);
 		pte_free(args->mm, args->start_ptep);
 		mm_dec_nr_ptes(args->mm);
 	}
 
 	if (args->start_pmdp) {
+		pud_clear(args->pudp);
 		pmd_free(args->mm, args->start_pmdp);
 		mm_dec_nr_pmds(args->mm);
 	}
 
 	if (args->start_pudp) {
+		p4d_clear(args->p4dp);
 		pud_free(args->mm, args->start_pudp);
 		mm_dec_nr_puds(args->mm);
 	}
 
-	if (args->start_p4dp)
+	if (args->start_p4dp) {
+		pgd_clear(args->pgdp);
 		p4d_free(args->mm, args->start_p4dp);
+	}
 
 	/* Free vma and mm struct */
 	if (args->vma)
 		vm_area_free(args->vma);
 
 	if (args->mm)
-		mmdrop(args->mm);
+		mmput(args->mm);
 }
 
 static struct page * __init
diff --git a/mm/filemap.c b/mm/filemap.c
index 6649a853dc5f..2ae6c6146d84 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3554,7 +3554,7 @@ int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
  */
 int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+	if (vma_is_shared_maywrite(vma))
 		return -EINVAL;
 	return generic_file_mmap(file, vma);
 }
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 9430b2e283ca..d3c9a63d7a9d 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -441,6 +441,7 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
+	bool warn = false;
 
 	/* try the slab allocator first */
 	if (object_cache) {
@@ -458,8 +459,10 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 	else if (mem_pool_free_count)
 		object = &mem_pool[--mem_pool_free_count];
 	else
-		pr_warn_once("Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE\n");
+		warn = true;
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
+	if (warn)
+		pr_warn_once("Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE\n");
 
 	return object;
 }
@@ -1992,6 +1995,7 @@ static const struct file_operations kmemleak_fops = {
 static void __kmemleak_do_cleanup(void)
 {
 	struct kmemleak_object *object, *tmp;
+	unsigned int cnt = 0;
 
 	/*
 	 * Kmemleak has already been disabled, no need for RCU list traversal
@@ -2000,6 +2004,10 @@ static void __kmemleak_do_cleanup(void)
 	list_for_each_entry_safe(object, tmp, &object_list, object_list) {
 		__remove_object(object);
 		__delete_object(object);
+
+		/* Call cond_resched() once per 64 iterations to avoid soft lockup */
+		if (!(++cnt & 0x3f))
+			cond_resched();
 	}
 }
 
diff --git a/mm/madvise.c b/mm/madvise.c
index e1993e18afee..06c5adcaec59 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -980,7 +980,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 			return -EINVAL;
 	}
 
-	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) != (VM_SHARED|VM_WRITE))
+	if (!vma_is_shared_maywrite(vma))
 		return -EACCES;
 
 	offset = (loff_t)(start - vma->vm_start)
diff --git a/mm/memfd.c b/mm/memfd.c
index b0104b49bf82..4b6c8e5ccd97 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -133,7 +133,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 	return error;
 }
 
-static unsigned int *memfd_file_seals_ptr(struct file *file)
+unsigned int *memfd_file_seals_ptr(struct file *file)
 {
 	if (shmem_file(file))
 		return &SHMEM_I(file_inode(file))->seals;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9ca2b58aceec..0f706ee04baf 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -731,9 +731,17 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 #define hwpoison_hugetlb_range	NULL
 #endif
 
+static int hwpoison_test_walk(unsigned long start, unsigned long end,
+			     struct mm_walk *walk)
+{
+	/* We also want to consider pages mapped into VM_PFNMAP. */
+	return 0;
+}
+
 static const struct mm_walk_ops hwp_walk_ops = {
 	.pmd_entry = hwpoison_pte_range,
 	.hugetlb_entry = hwpoison_hugetlb_range,
+	.test_walk = hwpoison_test_walk,
 };
 
 /*
diff --git a/mm/mmap.c b/mm/mmap.c
index 0f303dc8425a..f93526b3df0c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -46,6 +46,7 @@
 #include <linux/pkeys.h>
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
+#include <linux/memfd.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -106,7 +107,7 @@ void vma_set_page_prot(struct vm_area_struct *vma)
 static void __remove_shared_vm_struct(struct vm_area_struct *vma,
 		struct file *file, struct address_space *mapping)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_is_shared_maywrite(vma))
 		mapping_unmap_writable(mapping);
 
 	flush_dcache_mmap_lock(mapping);
@@ -408,7 +409,7 @@ static unsigned long count_vma_pages_range(struct mm_struct *mm,
 static void __vma_link_file(struct vm_area_struct *vma,
 			    struct address_space *mapping)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_is_shared_maywrite(vma))
 		mapping_allow_writable(mapping);
 
 	flush_dcache_mmap_lock(mapping);
@@ -1336,6 +1337,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 
 	if (file) {
 		struct inode *inode = file_inode(file);
+		unsigned int seals = memfd_file_seals(file);
 		unsigned long flags_mask;
 
 		if (!file_mmap_ok(file, inode, pgoff, len))
@@ -1374,6 +1376,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_SHARED | VM_MAYSHARE;
 			if (!(file->f_mode & FMODE_WRITE))
 				vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
+			else if (is_readonly_sealed(seals, vm_flags))
+				vm_flags &= ~VM_MAYWRITE;
 			fallthrough;
 		case MAP_PRIVATE:
 			if (!(file->f_mode & FMODE_READ))
@@ -2827,7 +2831,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	vma_mas_store(vma, &mas);
 	mm->map_count++;
 	if (vma->vm_file) {
-		if (vma->vm_flags & VM_SHARED)
+		if (vma_is_shared_maywrite(vma))
 			mapping_allow_writable(vma->vm_file->f_mapping);
 
 		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
@@ -2901,7 +2905,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		return -EINVAL;
 
 	/* Map writable and ensure this isn't a sealed memfd. */
-	if (file && (vm_flags & VM_SHARED)) {
+	if (file && is_shared_maywrite(vm_flags)) {
 		int error = mapping_map_writable(file->f_mapping);
 
 		if (error)
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 8adab455a68b..8e29b90d6bc3 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -152,6 +152,7 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 {
 	const struct ptdump_range *range = st->range;
 
+	get_online_mems();
 	mmap_write_lock(mm);
 	while (range->start != range->end) {
 		walk_page_range_novma(mm, range->start, range->end,
@@ -159,6 +160,7 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 		range++;
 	}
 	mmap_write_unlock(mm);
+	put_online_mems();
 
 	/* Flush out the last page */
 	st->note_page(st, 0, -1, 0);
diff --git a/mm/shmem.c b/mm/shmem.c
index 2e6b7db7f14b..2034b9b3fb71 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2302,7 +2302,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	struct shmem_inode_info *info = SHMEM_I(file_inode(file));
 	int ret;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 49b9dd21b73e..5f6785fd6af5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -439,7 +439,8 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	case BT_CODEC_TRANSPARENT:
 		if (!find_next_esco_param(conn, esco_param_msbc,
 					  ARRAY_SIZE(esco_param_msbc)))
-			return false;
+			return -EINVAL;
+
 		param = &esco_param_msbc[conn->attempt - 1];
 		cp.tx_coding_format.id = 0x03;
 		cp.rx_coding_format.id = 0x03;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3f905ee4338f..acff47da799a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5525,31 +5525,46 @@ static int hci_reject_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
 int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 {
-	int err;
+	int err = 0;
+	u16 handle = conn->handle;
 
 	switch (conn->state) {
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		return hci_disconnect_sync(hdev, conn, reason);
+		err = hci_disconnect_sync(hdev, conn, reason);
+		break;
 	case BT_CONNECT:
 		err = hci_connect_cancel_sync(hdev, conn);
-		/* Cleanup hci_conn object if it cannot be cancelled as it
-		 * likelly means the controller and host stack are out of sync.
-		 */
-		if (err) {
-			hci_dev_lock(hdev);
-			hci_conn_failed(conn, err);
-			hci_dev_unlock(hdev);
-		}
-		return err;
+		break;
 	case BT_CONNECT2:
-		return hci_reject_conn_sync(hdev, conn, reason);
+		err = hci_reject_conn_sync(hdev, conn, reason);
+		break;
 	default:
 		conn->state = BT_CLOSED;
-		break;
+		return 0;
 	}
 
-	return 0;
+	/* Cleanup hci_conn object if it cannot be cancelled as it
+	 * likelly means the controller and host stack are out of sync
+	 * or in case of LE it was still scanning so it can be cleanup
+	 * safely.
+	 */
+	if (err) {
+		struct hci_conn *c;
+
+		/* Check if the connection hasn't been cleanup while waiting
+		 * commands to complete.
+		 */
+		c = hci_conn_hash_lookup_handle(hdev, handle);
+		if (!c || c != conn)
+			return 0;
+
+		hci_dev_lock(hdev);
+		hci_conn_failed(conn, err);
+		hci_dev_unlock(hdev);
+	}
+
+	return err;
 }
 
 static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index e28c9db0c4db..140dbcfc8b94 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4634,6 +4634,14 @@ void br_multicast_set_query_intvl(struct net_bridge_mcast *brmctx,
 		intvl_jiffies = BR_MULTICAST_QUERY_INTVL_MIN;
 	}
 
+	if (intvl_jiffies > BR_MULTICAST_QUERY_INTVL_MAX) {
+		br_info(brmctx->br,
+			"trying to set multicast query interval above maximum, setting to %lu (%ums)\n",
+			jiffies_to_clock_t(BR_MULTICAST_QUERY_INTVL_MAX),
+			jiffies_to_msecs(BR_MULTICAST_QUERY_INTVL_MAX));
+		intvl_jiffies = BR_MULTICAST_QUERY_INTVL_MAX;
+	}
+
 	brmctx->multicast_query_interval = intvl_jiffies;
 }
 
@@ -4650,6 +4658,14 @@ void br_multicast_set_startup_query_intvl(struct net_bridge_mcast *brmctx,
 		intvl_jiffies = BR_MULTICAST_STARTUP_QUERY_INTVL_MIN;
 	}
 
+	if (intvl_jiffies > BR_MULTICAST_STARTUP_QUERY_INTVL_MAX) {
+		br_info(brmctx->br,
+			"trying to set multicast startup query interval above maximum, setting to %lu (%ums)\n",
+			jiffies_to_clock_t(BR_MULTICAST_STARTUP_QUERY_INTVL_MAX),
+			jiffies_to_msecs(BR_MULTICAST_STARTUP_QUERY_INTVL_MAX));
+		intvl_jiffies = BR_MULTICAST_STARTUP_QUERY_INTVL_MAX;
+	}
+
 	brmctx->multicast_startup_query_interval = intvl_jiffies;
 }
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 767f0e81dd26..20c96cb406d5 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -30,6 +30,8 @@
 #define BR_MULTICAST_DEFAULT_HASH_MAX 4096
 #define BR_MULTICAST_QUERY_INTVL_MIN msecs_to_jiffies(1000)
 #define BR_MULTICAST_STARTUP_QUERY_INTVL_MIN BR_MULTICAST_QUERY_INTVL_MIN
+#define BR_MULTICAST_QUERY_INTVL_MAX msecs_to_jiffies(86400000) /* 24 hours */
+#define BR_MULTICAST_STARTUP_QUERY_INTVL_MAX BR_MULTICAST_QUERY_INTVL_MAX
 
 #define BR_HWDOM_MAX BITS_PER_LONG
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 212a909b4840..114fc8bc37f8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3610,6 +3610,18 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 			features &= ~NETIF_F_TSO_MANGLEID;
 	}
 
+	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
+	 * so neither does TSO that depends on it.
+	 */
+	if (features & NETIF_F_IPV6_CSUM &&
+	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
+	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
+	    skb_transport_header_was_set(skb) &&
+	    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
+	    !ipv6_has_hopopt_jumbo(skb))
+		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
+
 	return features;
 }
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index bcc3950638b9..92dc1f1788de 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -55,7 +55,8 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
 			   u32 pid);
 static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
 static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
-				    struct net_device *dev);
+				    struct net_device *dev,
+				    bool skip_perm);
 
 #ifdef CONFIG_PROC_FS
 static const struct seq_operations neigh_stat_seq_ops;
@@ -444,7 +445,7 @@ static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 {
 	write_lock_bh(&tbl->lock);
 	neigh_flush_dev(tbl, dev, skip_perm);
-	pneigh_ifdown_and_unlock(tbl, dev);
+	pneigh_ifdown_and_unlock(tbl, dev, skip_perm);
 	pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
 			   tbl->family);
 	if (skb_queue_empty_lockless(&tbl->proxy_queue))
@@ -845,7 +846,8 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 }
 
 static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
-				    struct net_device *dev)
+				    struct net_device *dev,
+				    bool skip_perm)
 {
 	struct pneigh_entry *n, **np, *freelist = NULL;
 	u32 h;
@@ -853,12 +855,15 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 	for (h = 0; h <= PNEIGH_HASHMASK; h++) {
 		np = &tbl->phash_buckets[h];
 		while ((n = *np) != NULL) {
+			if (skip_perm && n->permanent)
+				goto skip;
 			if (!dev || n->dev == dev) {
 				*np = n->next;
 				n->next = freelist;
 				freelist = n;
 				continue;
 			}
+skip:
 			np = &n->next;
 		}
 	}
@@ -2023,6 +2028,7 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		pn = pneigh_lookup(tbl, net, dst, dev, 1);
 		if (pn) {
 			pn->flags = ndm_flags;
+			pn->permanent = !!(ndm->ndm_state & NUD_PERMANENT);
 			if (protocol)
 				pn->protocol = protocol;
 			err = 0;
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index b70e6bbf6021..0e6daee488b4 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -62,8 +62,14 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 	skb_push(skb, ETH_HLEN);
 	skb_reset_mac_header(skb);
 	if ((!hsr->prot_version && protocol == htons(ETH_P_PRP)) ||
-	    protocol == htons(ETH_P_HSR))
+	    protocol == htons(ETH_P_HSR)) {
+		if (!pskb_may_pull(skb, ETH_HLEN + HSR_HLEN)) {
+			kfree_skb(skb);
+			goto finish_consume;
+		}
+
 		skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
+	}
 	skb_reset_mac_len(skb);
 
 	hsr_forward_skb(skb, port);
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 73d7372afb43..90e55b9979e6 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1298,6 +1298,7 @@ int ip_tunnel_init(struct net_device *dev)
 
 	if (tunnel->collect_md)
 		netif_keep_dst(dev);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_init);
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 675b5bbed638..2d663fe50f87 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -247,8 +247,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	if (!oth)
 		return;
 
-	if ((hook == NF_INET_PRE_ROUTING || hook == NF_INET_INGRESS) &&
-	    nf_reject_fill_skb_dst(oldskb) < 0)
+	if (!skb_dst(oldskb) && nf_reject_fill_skb_dst(oldskb) < 0)
 		return;
 
 	if (skb_rtable(oldskb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
@@ -321,8 +320,7 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 	if (iph->frag_off & htons(IP_OFFSET))
 		return;
 
-	if ((hook == NF_INET_PRE_ROUTING || hook == NF_INET_INGRESS) &&
-	    nf_reject_fill_skb_dst(skb_in) < 0)
+	if (!skb_dst(skb_in) && nf_reject_fill_skb_dst(skb_in) < 0)
 		return;
 
 	if (skb_csum_unnecessary(skb_in) ||
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 870108101017..c57a1cee98e2 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2562,7 +2562,6 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 	do_cache = true;
 	if (type == RTN_BROADCAST) {
 		flags |= RTCF_BROADCAST | RTCF_LOCAL;
-		fi = NULL;
 	} else if (type == RTN_MULTICAST) {
 		flags |= RTCF_MULTICAST | RTCF_LOCAL;
 		if (!ip_check_mc_rcu(in_dev, fl4->daddr, fl4->saddr,
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 1a51c4b44c00..593108049ab7 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -60,7 +60,7 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 	remcsum = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TUNNEL_REMCSUM);
 	skb->remcsum_offload = remcsum;
 
-	need_ipsec = skb_dst(skb) && dst_xfrm(skb_dst(skb));
+	need_ipsec = (skb_dst(skb) && dst_xfrm(skb_dst(skb))) || skb_sec_path(skb);
 	/* Try to offload checksum if possible */
 	offload_csum = !!(need_csum &&
 			  !need_ipsec &&
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 69915bb8b96d..cbdb510b40ea 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2185,13 +2185,12 @@ void addrconf_dad_failure(struct sk_buff *skb, struct inet6_ifaddr *ifp)
 	in6_ifa_put(ifp);
 }
 
-/* Join to solicited addr multicast group.
- * caller must hold RTNL */
+/* Join to solicited addr multicast group. */
 void addrconf_join_solict(struct net_device *dev, const struct in6_addr *addr)
 {
 	struct in6_addr maddr;
 
-	if (dev->flags&(IFF_LOOPBACK|IFF_NOARP))
+	if (READ_ONCE(dev->flags) & (IFF_LOOPBACK | IFF_NOARP))
 		return;
 
 	addrconf_addr_solict_mult(addr, &maddr);
@@ -3807,7 +3806,7 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 	 *	   Do not dev_put!
 	 */
 	if (unregister) {
-		idev->dead = 1;
+		WRITE_ONCE(idev->dead, 1);
 
 		/* protected by rtnl_lock */
 		RCU_INIT_POINTER(dev->ip6_ptr, NULL);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b3e2d658af80..718fcad69cf1 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1537,6 +1537,7 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
 	ip6gre_tnl_init_features(dev);
 
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 cleanup_dst_cache_init:
@@ -1929,6 +1930,7 @@ static int ip6erspan_tap_init(struct net_device *dev)
 	ip6erspan_tnl_link_config(tunnel, 1);
 
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 cleanup_dst_cache_init:
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index a82d382193e4..2a470c0c38ae 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1902,6 +1902,7 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len - t_hlen;
 
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 destroy_dst:
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index cb71463bbbab..add7276986f1 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -937,6 +937,7 @@ static inline int vti6_dev_init_gen(struct net_device *dev)
 	if (!dev->tstats)
 		return -ENOMEM;
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index e9e59a83ba9b..e7f569875e71 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -906,23 +906,22 @@ static struct ifmcaddr6 *mca_alloc(struct inet6_dev *idev,
 static int __ipv6_dev_mc_inc(struct net_device *dev,
 			     const struct in6_addr *addr, unsigned int mode)
 {
-	struct ifmcaddr6 *mc;
 	struct inet6_dev *idev;
-
-	ASSERT_RTNL();
+	struct ifmcaddr6 *mc;
 
 	/* we need to take a reference on idev */
 	idev = in6_dev_get(dev);
-
 	if (!idev)
 		return -EINVAL;
 
-	if (idev->dead) {
+	mutex_lock(&idev->mc_lock);
+
+	if (READ_ONCE(idev->dead)) {
+		mutex_unlock(&idev->mc_lock);
 		in6_dev_put(idev);
 		return -ENODEV;
 	}
 
-	mutex_lock(&idev->mc_lock);
 	for_each_mc_mclock(idev, mc) {
 		if (ipv6_addr_equal(&mc->mca_addr, addr)) {
 			mc->mca_users++;
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index e4776bd2ed89..f3579bccf0a5 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -293,7 +293,7 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	fl6.fl6_sport = otcph->dest;
 	fl6.fl6_dport = otcph->source;
 
-	if (hook == NF_INET_PRE_ROUTING || hook == NF_INET_INGRESS) {
+	if (!skb_dst(oldskb)) {
 		nf_ip6_route(net, &dst, flowi6_to_flowi(&fl6), false);
 		if (!dst)
 			return;
@@ -397,8 +397,7 @@ void nf_send_unreach6(struct net *net, struct sk_buff *skb_in,
 	if (hooknum == NF_INET_LOCAL_OUT && skb_in->dev == NULL)
 		skb_in->dev = net->loopback_dev;
 
-	if ((hooknum == NF_INET_PRE_ROUTING || hooknum == NF_INET_INGRESS) &&
-	    nf_reject6_fill_skb_dst(skb_in) < 0)
+	if (!skb_dst(skb_in) && nf_reject6_fill_skb_dst(skb_in) < 0)
 		return;
 
 	icmpv6_send(skb_in, ICMPV6_DEST_UNREACH, code, 0);
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index 3c3800223e0e..b90c286d77ed 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -35,6 +35,7 @@
 #include <net/xfrm.h>
 
 #include <crypto/hash.h>
+#include <crypto/algapi.h>
 #include <net/seg6.h>
 #include <net/genetlink.h>
 #include <net/seg6_hmac.h>
@@ -269,7 +270,7 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	if (seg6_hmac_compute(hinfo, srh, &ipv6_hdr(skb)->saddr, hmac_output))
 		return false;
 
-	if (memcmp(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN) != 0)
+	if (crypto_memneq(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN))
 		return false;
 
 	return true;
@@ -293,6 +294,9 @@ int seg6_hmac_info_add(struct net *net, u32 key, struct seg6_hmac_info *hinfo)
 	struct seg6_pernet_data *sdata = seg6_pernet(net);
 	int err;
 
+	if (!__hmac_get_algo(hinfo->alg_id))
+		return -EINVAL;
+
 	err = rhashtable_lookup_insert_fast(&sdata->hmac_infos, &hinfo->node,
 					    rht_params);
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index cc24cefdb85c..eb4c8e2a2b12 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1460,6 +1460,7 @@ static int ipip6_tunnel_init(struct net_device *dev)
 		return err;
 	}
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index be48d3f7ffcd..b42eb781d7f7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1735,12 +1735,12 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	}
 
 	if (params->supported_rates &&
-	    params->supported_rates_len) {
-		ieee80211_parse_bitrates(link->conf->chandef.width,
-					 sband, params->supported_rates,
-					 params->supported_rates_len,
-					 &link_sta->pub->supp_rates[sband->band]);
-	}
+	    params->supported_rates_len &&
+	    !ieee80211_parse_bitrates(link->conf->chandef.width,
+				      sband, params->supported_rates,
+				      params->supported_rates_len,
+				      &link_sta->pub->supp_rates[sband->band]))
+		return -EINVAL;
 
 	if (params->ht_capa)
 		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index f07e34bed8f3..648af67b8ec8 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1308,6 +1308,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 		goto out;
 	}
 
+	link->radar_required = link->reserved_radar_required;
 	list_move(&link->assigned_chanctx_list, &new_ctx->assigned_links);
 	rcu_assign_pointer(link_conf->chanctx_conf, &new_ctx->conf);
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b300972c3150..cc47d6b88f04 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3595,6 +3595,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_prep_tx_info info = {
 		.subtype = IEEE80211_STYPE_AUTH,
 	};
+	bool sae_need_confirm = false;
 
 	sdata_assert_lock(sdata);
 
@@ -3638,6 +3639,8 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 				jiffies + IEEE80211_AUTH_WAIT_SAE_RETRY;
 			ifmgd->auth_data->timeout_started = true;
 			run_again(sdata, ifmgd->auth_data->timeout);
+			if (auth_transaction == 1)
+				sae_need_confirm = true;
 			goto notify_driver;
 		}
 
@@ -3680,6 +3683,9 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	     ifmgd->auth_data->expected_transaction == 2)) {
 		if (!ieee80211_mark_sta_auth(sdata))
 			return; /* ignore frame -- wait for timeout */
+	} else if (ifmgd->auth_data->algorithm == WLAN_AUTH_SAE &&
+		   auth_transaction == 1) {
+		sae_need_confirm = true;
 	} else if (ifmgd->auth_data->algorithm == WLAN_AUTH_SAE &&
 		   auth_transaction == 2) {
 		sdata_info(sdata, "SAE peer confirmed\n");
@@ -3688,7 +3694,8 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 
 	cfg80211_rx_mlme_mgmt(sdata->dev, (u8 *)mgmt, len);
 notify_driver:
-	drv_mgd_complete_tx(sdata->local, sdata, &info);
+	if (!sae_need_confirm)
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 }
 
 #define case_WLAN(type) \
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index dd1864f6549f..e9ae92094794 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -357,8 +357,9 @@ static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 	struct sta_link_alloc *alloc = NULL;
 	struct link_sta_info *link_sta;
 
-	link_sta = rcu_dereference_protected(sta->link[link_id],
-					     lockdep_is_held(&sta->local->sta_mtx));
+	link_sta = rcu_access_pointer(sta->link[link_id]);
+	if (link_sta != &sta->deflink)
+		lockdep_assert_held(&sta->local->sta_mtx);
 
 	if (WARN_ON(!link_sta))
 		return;
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 6a963eac1cc2..0f49b41570f5 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -73,7 +73,6 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 
 	lock_sock(sk);
 
-	/* TODO: allow rebind */
 	if (sk_hashed(sk)) {
 		rc = -EADDRINUSE;
 		goto out_release;
@@ -550,15 +549,36 @@ static void mctp_sk_close(struct sock *sk, long timeout)
 static int mctp_sk_hash(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
+	struct sock *existing;
+	struct mctp_sock *msk;
+	int rc;
+
+	msk = container_of(sk, struct mctp_sock, sk);
 
 	/* Bind lookup runs under RCU, remain live during that. */
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
 	mutex_lock(&net->mctp.bind_lock);
+
+	/* Prevent duplicate binds. */
+	sk_for_each(existing, &net->mctp.binds) {
+		struct mctp_sock *mex =
+			container_of(existing, struct mctp_sock, sk);
+
+		if (mex->bind_type == msk->bind_type &&
+		    mex->bind_addr == msk->bind_addr &&
+		    mex->bind_net == msk->bind_net) {
+			rc = -EADDRINUSE;
+			goto out;
+		}
+	}
+
 	sk_add_node_rcu(sk, &net->mctp.binds);
-	mutex_unlock(&net->mctp.bind_lock);
+	rc = 0;
 
-	return 0;
+out:
+	mutex_unlock(&net->mctp.bind_lock);
+	return rc;
 }
 
 static void mctp_sk_unhash(struct sock *sk)
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 929074f08713..fb7786c1ca58 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -973,8 +973,9 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		if (subflow->mp_join)
 			goto reset;
 		subflow->mp_capable = 0;
+		if (!mptcp_try_fallback(ssk))
+			goto reset;
 		pr_fallback(msk);
-		mptcp_do_fallback(ssk);
 		return false;
 	}
 
@@ -1100,7 +1101,9 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	return hmac == mp_opt->ahmac;
 }
 
-/* Return false if a subflow has been reset, else return true */
+/* Return false in case of error (or subflow has been reset),
+ * else return true.
+ */
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -1198,7 +1201,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
-		return true;
+		return false;
 
 	memset(mpext, 0, sizeof(*mpext));
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 34120694ad49..6392973b1fa7 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -309,8 +309,14 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
 	pr_debug("fail_seq=%llu\n", fail_seq);
 
-	if (!READ_ONCE(msk->allow_infinite_fallback))
+	/* After accepting the fail, we can't create any other subflows */
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
 		return;
+	}
+	msk->allow_subflows = false;
+	spin_unlock_bh(&msk->fallback_lock);
 
 	if (!subflow->fail_tout) {
 		pr_debug("send MP_FAIL response and infinite map\n");
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3391d4df2dbb..cf9244a3644f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -304,6 +304,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
+	unsigned int timeout;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -321,6 +322,10 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
+	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
+	if (!timeout)
+		goto out;
+
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
@@ -332,7 +337,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+			       jiffies + timeout);
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -374,6 +379,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
+	unsigned int timeout;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -383,9 +389,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
+		goto reset_timer;
 	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -399,8 +403,10 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
-	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+reset_timer:
+	timeout = mptcp_get_add_addr_timeout(net);
+	if (timeout)
+		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
 
 	return true;
 }
@@ -1778,7 +1784,6 @@ static void __flush_addrs(struct list_head *list)
 static void __reset_counters(struct pm_nl_pernet *pernet)
 {
 	WRITE_ONCE(pernet->add_addr_signal_max, 0);
-	WRITE_ONCE(pernet->add_addr_accept_max, 0);
 	WRITE_ONCE(pernet->local_addr_max, 0);
 	pernet->addrs = 0;
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e975693b8fa9..883efcbb8dfc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -633,10 +633,9 @@ static bool mptcp_check_data_fin(struct sock *sk)
 
 static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (READ_ONCE(msk->allow_infinite_fallback)) {
+	if (mptcp_try_fallback(ssk)) {
 		MPTCP_INC_STATS(sock_net(ssk),
 				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
-		mptcp_do_fallback(ssk);
 	} else {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
 		mptcp_subflow_reset(ssk);
@@ -886,7 +885,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
 {
 	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	msk->allow_infinite_fallback = false;
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 }
 
@@ -897,6 +896,14 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return false;
 
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_subflows) {
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+	mptcp_subflow_joined(msk, ssk);
+	spin_unlock_bh(&msk->fallback_lock);
+
 	/* attach to msk socket only after we are sure we will deal with it
 	 * at close time
 	 */
@@ -904,7 +911,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 		mptcp_sock_graft(ssk, sk->sk_socket);
 
 	mptcp_sockopt_sync_locked(msk, ssk);
-	mptcp_subflow_joined(msk, ssk);
 	mptcp_stop_tout_timer(sk);
 	return true;
 }
@@ -1288,10 +1294,14 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	mpext->infinite_map = 1;
 	mpext->data_len = 0;
 
+	if (!mptcp_try_fallback(ssk)) {
+		mptcp_subflow_reset(ssk);
+		return;
+	}
+
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 	pr_fallback(msk);
-	mptcp_do_fallback(ssk);
 }
 
 #define MPTCP_MAX_GSO_SIZE (GSO_LEGACY_MAX_SIZE - (MAX_TCP_HEADER + 1))
@@ -2638,8 +2648,8 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 
 static void __mptcp_retrans(struct sock *sk)
 {
+	struct mptcp_sendmsg_info info = { .data_lock_held = true, };
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
 	size_t copied = 0;
 	struct sock *ssk;
@@ -2675,6 +2685,15 @@ static void __mptcp_retrans(struct sock *sk)
 	/* limit retransmission to the bytes already sent on some subflows */
 	info.sent = 0;
 	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
+
+	/* make the whole retrans decision, xmit, disallow fallback atomic */
+	spin_lock_bh(&msk->fallback_lock);
+	if (__mptcp_check_fallback(msk)) {
+		spin_unlock_bh(&msk->fallback_lock);
+		release_sock(ssk);
+		return;
+	}
+
 	while (info.sent < info.limit) {
 		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 		if (ret <= 0)
@@ -2688,8 +2707,9 @@ static void __mptcp_retrans(struct sock *sk)
 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
+		msk->allow_infinite_fallback = false;
 	}
+	spin_unlock_bh(&msk->fallback_lock);
 
 	release_sock(ssk);
 
@@ -2815,10 +2835,12 @@ static int __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
-	WRITE_ONCE(msk->allow_infinite_fallback, true);
+	msk->allow_infinite_fallback = true;
+	msk->allow_subflows = true;
 	msk->recovery = false;
 
 	mptcp_pm_data_init(msk);
+	spin_lock_init(&msk->fallback_lock);
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
@@ -3182,7 +3204,16 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
 	msk->last_snd = NULL;
+
+	/* The first subflow is already in TCP_CLOSE status, the following
+	 * can't overlap with a fallback anymore
+	 */
+	spin_lock_bh(&msk->fallback_lock);
+	msk->allow_subflows = true;
+	msk->allow_infinite_fallback = true;
 	WRITE_ONCE(msk->flags, 0);
+	spin_unlock_bh(&msk->fallback_lock);
+
 	msk->cb_flags = 0;
 	msk->recovery = false;
 	msk->can_ack = false;
@@ -3651,7 +3682,13 @@ bool mptcp_finish_join(struct sock *ssk)
 
 	/* active subflow, already present inside the conn_list */
 	if (!list_empty(&subflow->node)) {
+		spin_lock_bh(&msk->fallback_lock);
+		if (!msk->allow_subflows) {
+			spin_unlock_bh(&msk->fallback_lock);
+			return false;
+		}
 		mptcp_subflow_joined(msk, ssk);
+		spin_unlock_bh(&msk->fallback_lock);
 		return true;
 	}
 
@@ -3764,7 +3801,7 @@ static void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
 					 struct mptcp_subflow_context *subflow)
 {
 	subflow->request_mptcp = 0;
-	__mptcp_do_fallback(msk);
+	WARN_ON_ONCE(!__mptcp_try_fallback(msk));
 }
 
 static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 25c1cda5c1bc..e1637443203e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -314,9 +314,15 @@ struct mptcp_sock {
 		u64	time;	/* start time of measurement window */
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
+	bool		allow_subflows;
 
 	u32 setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
+
+	spinlock_t	fallback_lock;	/* protects fallback,
+					 * allow_infinite_fallback and
+					 * allow_join
+					 */
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
@@ -975,25 +981,33 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 	return __mptcp_check_fallback(msk);
 }
 
-static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
+static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
 {
 	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags)) {
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
-		return;
+		return true;
 	}
-	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
-		return;
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+
+	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+	spin_unlock_bh(&msk->fallback_lock);
+	return true;
 }
 
-static inline void mptcp_do_fallback(struct sock *ssk)
+static inline bool mptcp_try_fallback(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = subflow->conn;
 	struct mptcp_sock *msk;
 
 	msk = mptcp_sk(sk);
-	__mptcp_do_fallback(msk);
+	if (!__mptcp_try_fallback(msk))
+		return false;
 	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
 		gfp_t saved_allocation = ssk->sk_allocation;
 
@@ -1005,6 +1019,7 @@ static inline void mptcp_do_fallback(struct sock *ssk)
 		tcp_shutdown(ssk, SEND_SHUTDOWN);
 		ssk->sk_allocation = saved_allocation;
 	}
+	return true;
 }
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a6237eb55537..cff232810692 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -431,9 +431,11 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
+			if (!mptcp_try_fallback(sk))
+				goto do_reset;
+
 			MPTCP_INC_STATS(sock_net(sk),
 					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
-			mptcp_do_fallback(sk);
 			pr_fallback(mptcp_sk(subflow->conn));
 			goto fallback;
 		}
@@ -1166,20 +1168,29 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 		mptcp_schedule_work(sk);
 }
 
-static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
+static bool mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	unsigned long fail_tout;
 
+	/* we are really failing, prevent any later subflow join */
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+	msk->allow_subflows = false;
+	spin_unlock_bh(&msk->fallback_lock);
+
 	/* greceful failure can happen only on the MPC subflow */
 	if (WARN_ON_ONCE(ssk != READ_ONCE(msk->first)))
-		return;
+		return false;
 
 	/* since the close timeout take precedence on the fail one,
 	 * no need to start the latter when the first is already set
 	 */
 	if (sock_flag((struct sock *)msk, SOCK_DEAD))
-		return;
+		return true;
 
 	/* we don't need extreme accuracy here, use a zero fail_tout as special
 	 * value meaning no fail timeout at all;
@@ -1191,6 +1202,7 @@ static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_send_ack(ssk);
 
 	mptcp_reset_tout_timer(msk, subflow->fail_tout);
+	return true;
 }
 
 static bool subflow_check_data_avail(struct sock *ssk)
@@ -1259,17 +1271,16 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		    (subflow->mp_join || subflow->valid_csum_seen)) {
 			subflow->send_mp_fail = 1;
 
-			if (!READ_ONCE(msk->allow_infinite_fallback)) {
+			if (!mptcp_subflow_fail(msk, ssk)) {
 				subflow->reset_transient = 0;
 				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
 				goto reset;
 			}
-			mptcp_subflow_fail(msk, ssk);
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
 			return true;
 		}
 
-		if (!READ_ONCE(msk->allow_infinite_fallback)) {
+		if (!mptcp_try_fallback(ssk)) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
@@ -1285,8 +1296,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return false;
 		}
-
-		mptcp_do_fallback(ssk);
 	}
 
 	skb = skb_peek(&ssk->sk_receive_queue);
@@ -1519,7 +1528,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	/* discard the subflow socket */
 	mptcp_sock_graft(ssk, sk->sk_socket);
 	iput(SOCK_INODE(sf));
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
 	mptcp_stop_tout_timer(sk);
 	return 0;
 
@@ -1690,7 +1698,7 @@ static void subflow_state_change(struct sock *sk)
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
 		mptcp_propagate_sndbuf(parent, sk);
-		mptcp_do_fallback(sk);
+		WARN_ON_ONCE(!mptcp_try_fallback(sk));
 		mptcp_rcv_space_init(msk, sk);
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 2c260f33b55c..ad1f671ffc37 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -110,7 +110,7 @@ struct ncsi_channel_version {
 	u8   update;		/* NCSI version update */
 	char alpha1;		/* NCSI version alpha1 */
 	char alpha2;		/* NCSI version alpha2 */
-	u8  fw_name[12];	/* Firmware name string                */
+	u8  fw_name[12 + 1];	/* Firmware name string                */
 	u32 fw_version;		/* Firmware version                   */
 	u16 pci_ids[4];		/* PCI identification                 */
 	u32 mf_id;		/* Manufacture ID                     */
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 8668888c5a2f..d5ed80731e89 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -775,6 +775,7 @@ static int ncsi_rsp_handler_gvi(struct ncsi_request *nr)
 	ncv->alpha1 = rsp->alpha1;
 	ncv->alpha2 = rsp->alpha2;
 	memcpy(ncv->fw_name, rsp->fw_name, 12);
+	ncv->fw_name[12] = '\0';
 	ncv->fw_version = ntohl(rsp->fw_version);
 	for (i = 0; i < ARRAY_SIZE(ncv->pci_ids); i++)
 		ncv->pci_ids[i] = ntohs(rsp->pci_ids[i]);
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 2cf58a8b8e4d..d3e28574ceb9 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -859,8 +859,6 @@ ctnetlink_conntrack_event(unsigned int events, const struct nf_ct_event *item)
 
 static int ctnetlink_done(struct netlink_callback *cb)
 {
-	if (cb->args[1])
-		nf_ct_put((struct nf_conn *)cb->args[1]);
 	kfree(cb->data);
 	return 0;
 }
@@ -1175,19 +1173,26 @@ static int ctnetlink_filter_match(struct nf_conn *ct, void *data)
 	return 0;
 }
 
+static unsigned long ctnetlink_get_id(const struct nf_conn *ct)
+{
+	unsigned long id = nf_ct_get_id(ct);
+
+	return id ? id : 1;
+}
+
 static int
 ctnetlink_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	unsigned int flags = cb->data ? NLM_F_DUMP_FILTERED : 0;
 	struct net *net = sock_net(skb->sk);
-	struct nf_conn *ct, *last;
+	unsigned long last_id = cb->args[1];
 	struct nf_conntrack_tuple_hash *h;
 	struct hlist_nulls_node *n;
 	struct nf_conn *nf_ct_evict[8];
+	struct nf_conn *ct;
 	int res, i;
 	spinlock_t *lockp;
 
-	last = (struct nf_conn *)cb->args[1];
 	i = 0;
 
 	local_bh_disable();
@@ -1224,7 +1229,7 @@ ctnetlink_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 				continue;
 
 			if (cb->args[1]) {
-				if (ct != last)
+				if (ctnetlink_get_id(ct) != last_id)
 					continue;
 				cb->args[1] = 0;
 			}
@@ -1237,8 +1242,7 @@ ctnetlink_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 					    NFNL_MSG_TYPE(cb->nlh->nlmsg_type),
 					    ct, true, flags);
 			if (res < 0) {
-				nf_conntrack_get(&ct->ct_general);
-				cb->args[1] = (unsigned long)ct;
+				cb->args[1] = ctnetlink_get_id(ct);
 				spin_unlock(lockp);
 				goto out;
 			}
@@ -1251,12 +1255,10 @@ ctnetlink_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 out:
 	local_bh_enable();
-	if (last) {
+	if (last_id) {
 		/* nf ct hash resize happened, now clear the leftover. */
-		if ((struct nf_conn *)cb->args[1] == last)
+		if (cb->args[1] == last_id)
 			cb->args[1] = 0;
-
-		nf_ct_put(last);
 	}
 
 	while (i) {
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 7e55328a4338..8c441c98ba56 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1217,7 +1217,7 @@ int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
 	nlk = nlk_sk(sk);
 	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
 
-	if ((rmem == skb->truesize || rmem < READ_ONCE(sk->sk_rcvbuf)) &&
+	if ((rmem == skb->truesize || rmem <= READ_ONCE(sk->sk_rcvbuf)) &&
 	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
 		netlink_skb_set_owner_r(skb, sk);
 		return 0;
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 12dd4d41605c..d99e1603c32a 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1761,7 +1761,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	ktime_t now = ktime_get();
 	struct cake_tin_data *b;
 	struct cake_flow *flow;
-	u32 idx;
+	u32 idx, tin;
 
 	/* choose flow to insert into */
 	idx = cake_classify(sch, &b, skb, q->flow_mode, &ret);
@@ -1771,6 +1771,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		__qdisc_drop(skb, to_free);
 		return ret;
 	}
+	tin = (u32)(b - q->tins);
 	idx--;
 	flow = &b->flows[idx];
 
@@ -1938,13 +1939,22 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		q->buffer_max_used = q->buffer_used;
 
 	if (q->buffer_used > q->buffer_limit) {
+		bool same_flow = false;
 		u32 dropped = 0;
+		u32 drop_id;
 
 		while (q->buffer_used > q->buffer_limit) {
 			dropped++;
-			cake_drop(sch, to_free);
+			drop_id = cake_drop(sch, to_free);
+
+			if ((drop_id >> 16) == tin &&
+			    (drop_id & 0xFFFF) == idx)
+				same_flow = true;
 		}
 		b->drop_overlimit += dropped;
+
+		if (same_flow)
+			return NET_XMIT_CN;
 	}
 	return NET_XMIT_SUCCESS;
 }
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 3ee46f6e005d..9873f4ae90c3 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -651,23 +651,24 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 
 	sch_tree_lock(sch);
 
-	q->nbands = nbands;
+	for (i = nbands; i < oldbands; i++) {
+		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
+			list_del_init(&q->classes[i].alist);
+		qdisc_purge_queue(q->classes[i].qdisc);
+	}
+
+	WRITE_ONCE(q->nbands, nbands);
 	for (i = nstrict; i < q->nstrict; i++) {
 		if (q->classes[i].qdisc->q.qlen) {
 			list_add_tail(&q->classes[i].alist, &q->active);
 			q->classes[i].deficit = quanta[i];
 		}
 	}
-	for (i = q->nbands; i < oldbands; i++) {
-		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
-			list_del_init(&q->classes[i].alist);
-		qdisc_purge_queue(q->classes[i].qdisc);
-	}
-	q->nstrict = nstrict;
+	WRITE_ONCE(q->nstrict, nstrict);
 	memcpy(q->prio2band, priomap, sizeof(priomap));
 
 	for (i = 0; i < q->nbands; i++)
-		q->classes[i].quantum = quanta[i];
+		WRITE_ONCE(q->classes[i].quantum, quanta[i]);
 
 	for (i = oldbands; i < q->nbands; i++) {
 		q->classes[i].qdisc = queues[i];
@@ -681,7 +682,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	for (i = q->nbands; i < oldbands; i++) {
 		qdisc_put(q->classes[i].qdisc);
 		q->classes[i].qdisc = NULL;
-		q->classes[i].quantum = 0;
+		WRITE_ONCE(q->classes[i].quantum, 0);
 		q->classes[i].deficit = 0;
 		gnet_stats_basic_sync_init(&q->classes[i].bstats);
 		memset(&q->classes[i].qstats, 0, sizeof(q->classes[i].qstats));
@@ -738,6 +739,7 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct ets_sched *q = qdisc_priv(sch);
 	struct nlattr *opts;
 	struct nlattr *nest;
+	u8 nbands, nstrict;
 	int band;
 	int prio;
 	int err;
@@ -750,21 +752,22 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
 	if (!opts)
 		goto nla_err;
 
-	if (nla_put_u8(skb, TCA_ETS_NBANDS, q->nbands))
+	nbands = READ_ONCE(q->nbands);
+	if (nla_put_u8(skb, TCA_ETS_NBANDS, nbands))
 		goto nla_err;
 
-	if (q->nstrict &&
-	    nla_put_u8(skb, TCA_ETS_NSTRICT, q->nstrict))
+	nstrict = READ_ONCE(q->nstrict);
+	if (nstrict && nla_put_u8(skb, TCA_ETS_NSTRICT, nstrict))
 		goto nla_err;
 
-	if (q->nbands > q->nstrict) {
+	if (nbands > nstrict) {
 		nest = nla_nest_start(skb, TCA_ETS_QUANTA);
 		if (!nest)
 			goto nla_err;
 
-		for (band = q->nstrict; band < q->nbands; band++) {
+		for (band = nstrict; band < nbands; band++) {
 			if (nla_put_u32(skb, TCA_ETS_QUANTA_BAND,
-					q->classes[band].quantum))
+					READ_ONCE(q->classes[band].quantum)))
 				goto nla_err;
 		}
 
@@ -776,7 +779,8 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
 		goto nla_err;
 
 	for (prio = 0; prio <= TC_PRIO_MAX; prio++) {
-		if (nla_put_u8(skb, TCA_ETS_PRIOMAP_BAND, q->prio2band[prio]))
+		if (nla_put_u8(skb, TCA_ETS_PRIOMAP_BAND,
+			       READ_ONCE(q->prio2band[prio])))
 			goto nla_err;
 	}
 
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 1e19d3ffbf21..7aac0916205b 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -589,7 +589,7 @@ htb_change_class_mode(struct htb_sched *q, struct htb_class *cl, s64 *diff)
  */
 static inline void htb_activate(struct htb_sched *q, struct htb_class *cl)
 {
-	WARN_ON(cl->level || !cl->leaf.q || !cl->leaf.q->q.qlen);
+	WARN_ON(cl->level || !cl->leaf.q);
 
 	if (!cl->prio_activity) {
 		cl->prio_activity = 1 << cl->prio;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 6ac3dcbe87b5..96e62e8f1dad 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -274,9 +274,15 @@ static int tls_do_decryption(struct sock *sk,
 		DEBUG_NET_WARN_ON_ONCE(atomic_read(&ctx->decrypt_pending) < 1);
 		atomic_inc(&ctx->decrypt_pending);
 	} else {
+		DECLARE_CRYPTO_WAIT(wait);
+
 		aead_request_set_callback(aead_req,
 					  CRYPTO_TFM_REQ_MAY_BACKLOG,
-					  crypto_req_done, &ctx->async_wait);
+					  crypto_req_done, &wait);
+		ret = crypto_aead_decrypt(aead_req);
+		if (ret == -EINPROGRESS || ret == -EBUSY)
+			ret = crypto_wait_req(ret, &wait);
+		return ret;
 	}
 
 	ret = crypto_aead_decrypt(aead_req);
@@ -289,7 +295,6 @@ static int tls_do_decryption(struct sock *sk,
 		/* all completions have run, we're not doing async anymore */
 		darg->async = false;
 		return ret;
-		ret = ret ?: -EINPROGRESS;
 	}
 
 	atomic_dec(&ctx->decrypt_pending);
@@ -1859,6 +1864,9 @@ int decrypt_skb(struct sock *sk, struct scatterlist *sgout)
 	return tls_decrypt_sg(sk, NULL, sgout, &darg);
 }
 
+/* All records returned from a recvmsg() call must have the same type.
+ * 0 is not a valid content type. Use it as "no type reported, yet".
+ */
 static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
 				   u8 *control)
 {
@@ -2102,8 +2110,10 @@ int tls_sw_recvmsg(struct sock *sk,
 	if (err < 0)
 		goto end;
 
+	/* process_rx_list() will set @control if it processed any records */
 	copied = err;
-	if (len <= copied || (copied && control != TLS_RECORD_TYPE_DATA) || rx_more)
+	if (len <= copied || rx_more ||
+	    (control && control != TLS_RECORD_TYPE_DATA))
 		goto end;
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 5434c9f11d28..52de4810d48d 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -221,7 +221,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
 
 static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 {
-	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM;
+	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
 	struct scatterlist pkt, *p;
 	struct virtqueue *vq;
 	struct sk_buff *skb;
@@ -494,8 +494,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	do {
 		virtqueue_disable_cb(vq);
 		for (;;) {
+			unsigned int len, payload_len;
+			struct virtio_vsock_hdr *hdr;
 			struct sk_buff *skb;
-			unsigned int len;
 
 			if (!virtio_transport_more_replies(vsock)) {
 				/* Stop rx until the device processes already
@@ -512,12 +513,19 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			vsock->rx_buf_nr--;
 
 			/* Drop short/long packets */
-			if (unlikely(len < sizeof(struct virtio_vsock_hdr) ||
+			if (unlikely(len < sizeof(*hdr) ||
 				     len > virtio_vsock_skb_len(skb))) {
 				kfree_skb(skb);
 				continue;
 			}
 
+			hdr = virtio_vsock_hdr(skb);
+			payload_len = le32_to_cpu(hdr->len);
+			if (unlikely(payload_len > len - sizeof(*hdr))) {
+				kfree_skb(skb);
+				continue;
+			}
+
 			virtio_vsock_skb_rx_put(skb);
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index e7fa0608341d..e0246ed9f66f 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -700,7 +700,8 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 
 	mgmt = (const struct ieee80211_mgmt *)params->buf;
 
-	if (!ieee80211_is_mgmt(mgmt->frame_control))
+	if (!ieee80211_is_mgmt(mgmt->frame_control) ||
+	    ieee80211_has_order(mgmt->frame_control))
 		return -EINVAL;
 
 	stype = le16_to_cpu(mgmt->frame_control) & IEEE80211_FCTL_STYPE;
diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 5d1404178e48..3c726ead8f7e 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -783,7 +783,7 @@ static void renderer_edited(GtkCellRendererText * cell,
 	struct symbol *sym;
 
 	if (!gtk_tree_model_get_iter(model2, &iter, path))
-		return;
+		goto free;
 
 	gtk_tree_model_get(model2, &iter, COL_MENU, &menu, -1);
 	sym = menu->sym;
@@ -795,6 +795,7 @@ static void renderer_edited(GtkCellRendererText * cell,
 
 	update_tree(&rootmenu, NULL);
 
+free:
 	gtk_tree_path_free(path);
 }
 
@@ -977,13 +978,14 @@ on_treeview2_key_press_event(GtkWidget * widget,
 void
 on_treeview2_cursor_changed(GtkTreeView * treeview, gpointer user_data)
 {
+	GtkTreeModel *model = gtk_tree_view_get_model(treeview);
 	GtkTreeSelection *selection;
 	GtkTreeIter iter;
 	struct menu *menu;
 
 	selection = gtk_tree_view_get_selection(treeview);
-	if (gtk_tree_selection_get_selected(selection, &model2, &iter)) {
-		gtk_tree_model_get(model2, &iter, COL_MENU, &menu, -1);
+	if (gtk_tree_selection_get_selected(selection, &model, &iter)) {
+		gtk_tree_model_get(model, &iter, COL_MENU, &menu, -1);
 		text_insert_help(menu);
 	}
 }
diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index 1dcfb288ee63..327b60cdb8da 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -39,8 +39,10 @@ int dialog_inputbox(const char *title, const char *prompt, int height, int width
 
 	if (!init)
 		instr[0] = '\0';
-	else
-		strcpy(instr, init);
+	else {
+		strncpy(instr, init, sizeof(dialog_input_result) - 1);
+		instr[sizeof(dialog_input_result) - 1] = '\0';
+	}
 
 do_resize:
 	if (getmaxy(stdscr) <= (height - INPUTBOX_HEIGTH_MIN))
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index 58c2f8afe59b..7e10e919fbdc 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -272,7 +272,7 @@ int dialog_menu(const char *title, const char *prompt,
 		if (key < 256 && isalpha(key))
 			key = tolower(key);
 
-		if (strchr("ynmh", key))
+		if (strchr("ynmh ", key))
 			i = max_choice;
 		else {
 			for (i = choice + 1; i < max_choice; i++) {
diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index 3ba8b1af390f..16a2db59432a 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -585,6 +585,8 @@ static void item_add_str(const char *fmt, ...)
 		tmp_str,
 		sizeof(k_menu_items[index].str));
 
+	k_menu_items[index].str[sizeof(k_menu_items[index].str) - 1] = '\0';
+
 	free_item(curses_menu_items[index]);
 	curses_menu_items[index] = new_item(
 			k_menu_items[index].str,
diff --git a/scripts/kconfig/nconf.gui.c b/scripts/kconfig/nconf.gui.c
index 9aedf40f1dc0..da06ea2afe08 100644
--- a/scripts/kconfig/nconf.gui.c
+++ b/scripts/kconfig/nconf.gui.c
@@ -349,6 +349,7 @@ int dialog_inputbox(WINDOW *main_window,
 	x = (columns-win_cols)/2;
 
 	strncpy(result, init, *result_len);
+	result[*result_len - 1] = '\0';
 
 	/* create the windows */
 	win = newwin(win_lines, win_cols, y, x);
diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
index d468c8b90298..fd57e9ffc139 100644
--- a/security/apparmor/include/lib.h
+++ b/security/apparmor/include/lib.h
@@ -46,7 +46,11 @@
 #define AA_BUG_FMT(X, fmt, args...)					\
 	WARN((X), "AppArmor WARN %s: (" #X "): " fmt, __func__, ##args)
 #else
-#define AA_BUG_FMT(X, fmt, args...) no_printk(fmt, ##args)
+#define AA_BUG_FMT(X, fmt, args...)					\
+	do {								\
+		BUILD_BUG_ON_INVALID(X);				\
+		no_printk(fmt, ##args);					\
+	} while (0)
 #endif
 
 #define AA_ERROR(fmt, args...)						\
diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..e6e07787eec9 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -159,7 +159,6 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		inode->i_fop = fops;
 	}
 	d_instantiate(dentry, inode);
-	dget(dentry);
 	inode_unlock(dir);
 	return dentry;
 
@@ -306,7 +305,6 @@ void securityfs_remove(struct dentry *dentry)
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
-		dput(dentry);
 	}
 	inode_unlock(dir);
 	simple_release_fs(&mount, &mount_count);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index bf752b188b05..900525df53f0 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -24,6 +24,7 @@
 #include <sound/minors.h>
 #include <linux/uio.h>
 #include <linux/delay.h>
+#include <linux/bitops.h>
 
 #include "pcm_local.h"
 
@@ -3123,13 +3124,23 @@ struct snd_pcm_sync_ptr32 {
 static snd_pcm_uframes_t recalculate_boundary(struct snd_pcm_runtime *runtime)
 {
 	snd_pcm_uframes_t boundary;
+	snd_pcm_uframes_t border;
+	int order;
 
 	if (! runtime->buffer_size)
 		return 0;
-	boundary = runtime->buffer_size;
-	while (boundary * 2 <= 0x7fffffffUL - runtime->buffer_size)
-		boundary *= 2;
-	return boundary;
+
+	border = 0x7fffffffUL - runtime->buffer_size;
+	if (runtime->buffer_size > border)
+		return runtime->buffer_size;
+
+	order = __fls(border) - __fls(runtime->buffer_size);
+	boundary = runtime->buffer_size << order;
+
+	if (boundary <= border)
+		return boundary;
+	else
+		return boundary / 2;
 }
 
 static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 9d7d99b584fe..aef60044cb8a 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -641,24 +641,16 @@ static void hda_jackpoll_work(struct work_struct *work)
 	struct hda_codec *codec =
 		container_of(work, struct hda_codec, jackpoll_work.work);
 
-	/* for non-polling trigger: we need nothing if already powered on */
-	if (!codec->jackpoll_interval && snd_hdac_is_power_on(&codec->core))
+	if (!codec->jackpoll_interval)
 		return;
 
 	/* the power-up/down sequence triggers the runtime resume */
-	snd_hda_power_up_pm(codec);
+	snd_hda_power_up(codec);
 	/* update jacks manually if polling is required, too */
-	if (codec->jackpoll_interval) {
-		snd_hda_jack_set_dirty_all(codec);
-		snd_hda_jack_poll_all(codec);
-	}
-	snd_hda_power_down_pm(codec);
-
-	if (!codec->jackpoll_interval)
-		return;
-
-	schedule_delayed_work(&codec->jackpoll_work,
-			      codec->jackpoll_interval);
+	snd_hda_jack_set_dirty_all(codec);
+	snd_hda_jack_poll_all(codec);
+	schedule_delayed_work(&codec->jackpoll_work, codec->jackpoll_interval);
+	snd_hda_power_down(codec);
 }
 
 /* release all pincfg lists */
@@ -2922,12 +2914,12 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 		snd_hda_regmap_sync(codec);
 	}
 
-	if (codec->jackpoll_interval)
-		hda_jackpoll_work(&codec->jackpoll_work.work);
-	else
-		snd_hda_jack_report_sync(codec);
+	snd_hda_jack_report_sync(codec);
 	codec->core.dev.power.power_state = PMSG_ON;
 	snd_hdac_leave_pm(&codec->core);
+	if (codec->jackpoll_interval)
+		schedule_delayed_work(&codec->jackpoll_work,
+				      codec->jackpoll_interval);
 }
 
 static int hda_codec_runtime_suspend(struct device *dev)
@@ -2939,8 +2931,6 @@ static int hda_codec_runtime_suspend(struct device *dev)
 	if (!codec->card)
 		return 0;
 
-	cancel_delayed_work_sync(&codec->jackpoll_work);
-
 	state = hda_call_codec_suspend(codec);
 	if (codec->link_down_at_suspend ||
 	    (codec_has_clkstop(codec) && codec_has_epss(codec) &&
@@ -2948,10 +2938,6 @@ static int hda_codec_runtime_suspend(struct device *dev)
 		snd_hdac_codec_link_down(&codec->core);
 	snd_hda_codec_display_power(codec, false);
 
-	if (codec->bus->jackpoll_in_suspend &&
-		(dev->power.power_state.event != PM_EVENT_SUSPEND))
-		schedule_delayed_work(&codec->jackpoll_work,
-					codec->jackpoll_interval);
 	return 0;
 }
 
@@ -3054,6 +3040,7 @@ void snd_hda_codec_shutdown(struct hda_codec *codec)
 	if (!codec->core.registered)
 		return;
 
+	codec->jackpoll_interval = 0; /* don't poll any longer */
 	cancel_delayed_work_sync(&codec->jackpoll_work);
 	list_for_each_entry(cpcm, &codec->pcm_list_head, list)
 		snd_pcm_suspend_all(cpcm->pcm);
@@ -3120,10 +3107,11 @@ int snd_hda_codec_build_controls(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
+	snd_hda_jack_report_sync(codec); /* call at the last init point */
 	if (codec->jackpoll_interval)
-		hda_jackpoll_work(&codec->jackpoll_work.work);
-	else
-		snd_hda_jack_report_sync(codec); /* call at the last init point */
+		schedule_delayed_work(&codec->jackpoll_work,
+				      codec->jackpoll_interval);
+
 	sync_power_up_states(codec);
 	return 0;
 }
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index d825fcce05ee..45b267c02a98 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4399,7 +4399,7 @@ static int add_tuning_control(struct hda_codec *codec,
 	}
 	knew.private_value =
 		HDA_COMPOSE_AMP_VAL(nid, 1, 0, type);
-	sprintf(namestr, "%s %s Volume", name, dirstr[dir]);
+	snprintf(namestr, sizeof(namestr), "%s %s Volume", name, dirstr[dir]);
 	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
 }
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 43265f4d42a5..fa1519254c3d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9915,6 +9915,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
 	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8548, "HP EliteBook x360 830 G6", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x854a, "HP EliteBook 830 G6", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x85c6, "HP Pavilion x360 Convertible 14-dy1xxx", ALC295_FIXUP_HP_MUTE_LED_COEFBIT11),
 	SND_PCI_QUIRK(0x103c, 0x85de, "HP Envy x360 13-ar0xxx", ALC285_FIXUP_HP_ENVY_X360),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
@@ -10440,6 +10442,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1ee7, 0x2078, "HONOR BRB-X M1010", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x2014, 0x800a, "Positivo ARN50", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
@@ -10455,6 +10458,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0xf111, 0x0001, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0xf111, 0x0006, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0xf111, 0x0009, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0xf111, 0x000b, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0xf111, 0x000c, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 
 #if 0
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index ae285c0a629c..f3df6fe2b7f1 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -2252,7 +2252,7 @@ static int snd_intel8x0_mixer(struct intel8x0 *chip, int ac97_clock,
 			tmp |= chip->ac97_sdin[0] << ICH_DI1L_SHIFT;
 			for (i = 1; i < 4; i++) {
 				if (pcm->r[0].codec[i]) {
-					tmp |= chip->ac97_sdin[pcm->r[0].codec[1]->num] << ICH_DI2L_SHIFT;
+					tmp |= chip->ac97_sdin[pcm->r[0].codec[i]->num] << ICH_DI2L_SHIFT;
 					break;
 				}
 			}
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index d8e83150ea28..90baca4c2b4d 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1230,7 +1230,8 @@ static int hdac_hdmi_parse_eld(struct hdac_device *hdev,
 						>> DRM_ELD_VER_SHIFT;
 
 	if (ver != ELD_VER_CEA_861D && ver != ELD_VER_PARTIAL) {
-		dev_err(&hdev->dev, "HDMI: Unknown ELD version %d\n", ver);
+		dev_err_ratelimited(&hdev->dev,
+				    "HDMI: Unknown ELD version %d\n", ver);
 		return -EINVAL;
 	}
 
@@ -1238,7 +1239,8 @@ static int hdac_hdmi_parse_eld(struct hdac_device *hdev,
 		DRM_ELD_MNL_MASK) >> DRM_ELD_MNL_SHIFT;
 
 	if (mnl > ELD_MAX_MNL) {
-		dev_err(&hdev->dev, "HDMI: MNL Invalid %d\n", mnl);
+		dev_err_ratelimited(&hdev->dev,
+				    "HDMI: MNL Invalid %d\n", mnl);
 		return -EINVAL;
 	}
 
@@ -1297,8 +1299,8 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 
 	if (!port->eld.monitor_present || !port->eld.eld_valid) {
 
-		dev_err(&hdev->dev, "%s: disconnect for pin:port %d:%d\n",
-						__func__, pin->nid, port->id);
+		dev_dbg(&hdev->dev, "%s: disconnect for pin:port %d:%d\n",
+			__func__, pin->nid, port->id);
 
 		/*
 		 * PCMs are not registered during device probe, so don't
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 37ea4d854cb5..3185bf13dc42 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -3026,6 +3026,11 @@ static int rt5640_i2c_probe(struct i2c_client *i2c)
 	}
 
 	regmap_read(rt5640->regmap, RT5640_VENDOR_ID2, &val);
+	if (val != RT5640_DEVICE_ID) {
+		usleep_range(60000, 100000);
+		regmap_read(rt5640->regmap, RT5640_VENDOR_ID2, &val);
+	}
+
 	if (val != RT5640_DEVICE_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt5640/39\n", val);
diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index c541e2a0202a..3ec5b88bd9a2 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -781,13 +781,6 @@ static int fsl_asrc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
-	.startup      = fsl_asrc_dai_startup,
-	.hw_params    = fsl_asrc_dai_hw_params,
-	.hw_free      = fsl_asrc_dai_hw_free,
-	.trigger      = fsl_asrc_dai_trigger,
-};
-
 static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_asrc *asrc = snd_soc_dai_get_drvdata(dai);
@@ -798,12 +791,19 @@ static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
+	.probe		= fsl_asrc_dai_probe,
+	.startup	= fsl_asrc_dai_startup,
+	.hw_params	= fsl_asrc_dai_hw_params,
+	.hw_free	= fsl_asrc_dai_hw_free,
+	.trigger	= fsl_asrc_dai_trigger,
+};
+
 #define FSL_ASRC_FORMATS	(SNDRV_PCM_FMTBIT_S24_LE | \
 				 SNDRV_PCM_FMTBIT_S16_LE | \
 				 SNDRV_PCM_FMTBIT_S24_3LE)
 
 static struct snd_soc_dai_driver fsl_asrc_dai = {
-	.probe = fsl_asrc_dai_probe,
 	.playback = {
 		.stream_name = "ASRC-Playback",
 		.channels_min = 1,
diff --git a/sound/soc/fsl/fsl_aud2htx.c b/sound/soc/fsl/fsl_aud2htx.c
index 1e421d9a03fb..402d9bbdbab5 100644
--- a/sound/soc/fsl/fsl_aud2htx.c
+++ b/sound/soc/fsl/fsl_aud2htx.c
@@ -49,10 +49,6 @@ static int fsl_aud2htx_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops fsl_aud2htx_dai_ops = {
-	.trigger	= fsl_aud2htx_trigger,
-};
-
 static int fsl_aud2htx_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_aud2htx *aud2htx = dev_get_drvdata(cpu_dai->dev);
@@ -84,8 +80,12 @@ static int fsl_aud2htx_dai_probe(struct snd_soc_dai *cpu_dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_aud2htx_dai_ops = {
+	.probe		= fsl_aud2htx_dai_probe,
+	.trigger	= fsl_aud2htx_trigger,
+};
+
 static struct snd_soc_dai_driver fsl_aud2htx_dai = {
-	.probe = fsl_aud2htx_dai_probe,
 	.playback = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 84e6f9eb784d..210ca7199ada 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1531,13 +1531,6 @@ static int fsl_easrc_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops fsl_easrc_dai_ops = {
-	.startup = fsl_easrc_startup,
-	.trigger = fsl_easrc_trigger,
-	.hw_params = fsl_easrc_hw_params,
-	.hw_free = fsl_easrc_hw_free,
-};
-
 static int fsl_easrc_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_asrc *easrc = dev_get_drvdata(cpu_dai->dev);
@@ -1548,8 +1541,15 @@ static int fsl_easrc_dai_probe(struct snd_soc_dai *cpu_dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_easrc_dai_ops = {
+	.probe		= fsl_easrc_dai_probe,
+	.startup	= fsl_easrc_startup,
+	.trigger	= fsl_easrc_trigger,
+	.hw_params	= fsl_easrc_hw_params,
+	.hw_free	= fsl_easrc_hw_free,
+};
+
 static struct snd_soc_dai_driver fsl_easrc_dai = {
-	.probe = fsl_easrc_dai_probe,
 	.playback = {
 		.stream_name = "ASRC-Playback",
 		.channels_min = 1,
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 17fefd27ec90..c7f4c1734825 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -785,15 +785,6 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops fsl_esai_dai_ops = {
-	.startup = fsl_esai_startup,
-	.trigger = fsl_esai_trigger,
-	.hw_params = fsl_esai_hw_params,
-	.set_sysclk = fsl_esai_set_dai_sysclk,
-	.set_fmt = fsl_esai_set_dai_fmt,
-	.set_tdm_slot = fsl_esai_set_dai_tdm_slot,
-};
-
 static int fsl_esai_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
@@ -804,8 +795,17 @@ static int fsl_esai_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_esai_dai_ops = {
+	.probe		= fsl_esai_dai_probe,
+	.startup	= fsl_esai_startup,
+	.trigger	= fsl_esai_trigger,
+	.hw_params	= fsl_esai_hw_params,
+	.set_sysclk	= fsl_esai_set_dai_sysclk,
+	.set_fmt	= fsl_esai_set_dai_fmt,
+	.set_tdm_slot	= fsl_esai_set_dai_tdm_slot,
+};
+
 static struct snd_soc_dai_driver fsl_esai_dai = {
-	.probe = fsl_esai_dai_probe,
 	.playback = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 8ee6f41563ea..1b6f5e33ff93 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -358,12 +358,6 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops fsl_micfil_dai_ops = {
-	.startup = fsl_micfil_startup,
-	.trigger = fsl_micfil_trigger,
-	.hw_params = fsl_micfil_hw_params,
-};
-
 static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_micfil *micfil = dev_get_drvdata(cpu_dai->dev);
@@ -400,8 +394,14 @@ static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_micfil_dai_ops = {
+	.probe		= fsl_micfil_dai_probe,
+	.startup	= fsl_micfil_startup,
+	.trigger	= fsl_micfil_trigger,
+	.hw_params	= fsl_micfil_hw_params,
+};
+
 static struct snd_soc_dai_driver fsl_micfil_dai = {
-	.probe = fsl_micfil_dai_probe,
 	.capture = {
 		.stream_name = "CPU-Capture",
 		.channels_min = 1,
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 27ad825c78f2..e622c8375a46 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -768,9 +768,9 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 	 * are running concurrently.
 	 */
 	/* Software Reset */
-	regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR);
+	regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR, FSL_SAI_CSR_SR);
 	/* Clear SR bit to finish the reset */
-	regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), 0);
+	regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR, 0);
 }
 
 static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
@@ -883,28 +883,17 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
-	.set_bclk_ratio	= fsl_sai_set_dai_bclk_ratio,
-	.set_sysclk	= fsl_sai_set_dai_sysclk,
-	.set_fmt	= fsl_sai_set_dai_fmt,
-	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
-	.hw_params	= fsl_sai_hw_params,
-	.hw_free	= fsl_sai_hw_free,
-	.trigger	= fsl_sai_trigger,
-	.startup	= fsl_sai_startup,
-};
-
 static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_sai *sai = dev_get_drvdata(cpu_dai->dev);
 	unsigned int ofs = sai->soc_data->reg_offset;
 
 	/* Software Reset for both Tx and Rx */
-	regmap_write(sai->regmap, FSL_SAI_TCSR(ofs), FSL_SAI_CSR_SR);
-	regmap_write(sai->regmap, FSL_SAI_RCSR(ofs), FSL_SAI_CSR_SR);
+	regmap_update_bits(sai->regmap, FSL_SAI_TCSR(ofs), FSL_SAI_CSR_SR, FSL_SAI_CSR_SR);
+	regmap_update_bits(sai->regmap, FSL_SAI_RCSR(ofs), FSL_SAI_CSR_SR, FSL_SAI_CSR_SR);
 	/* Clear SR bit to finish the reset */
-	regmap_write(sai->regmap, FSL_SAI_TCSR(ofs), 0);
-	regmap_write(sai->regmap, FSL_SAI_RCSR(ofs), 0);
+	regmap_update_bits(sai->regmap, FSL_SAI_TCSR(ofs), FSL_SAI_CSR_SR, 0);
+	regmap_update_bits(sai->regmap, FSL_SAI_RCSR(ofs), FSL_SAI_CSR_SR, 0);
 
 	regmap_update_bits(sai->regmap, FSL_SAI_TCR1(ofs),
 			   FSL_SAI_CR1_RFW_MASK(sai->soc_data->fifo_depth),
@@ -919,6 +908,18 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
+	.probe		= fsl_sai_dai_probe,
+	.set_bclk_ratio	= fsl_sai_set_dai_bclk_ratio,
+	.set_sysclk	= fsl_sai_set_dai_sysclk,
+	.set_fmt	= fsl_sai_set_dai_fmt,
+	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
+	.hw_params	= fsl_sai_hw_params,
+	.hw_free	= fsl_sai_hw_free,
+	.trigger	= fsl_sai_trigger,
+	.startup	= fsl_sai_startup,
+};
+
 static int fsl_sai_dai_resume(struct snd_soc_component *component)
 {
 	struct fsl_sai *sai = snd_soc_component_get_drvdata(component);
@@ -937,7 +938,6 @@ static int fsl_sai_dai_resume(struct snd_soc_component *component)
 }
 
 static struct snd_soc_dai_driver fsl_sai_dai_template = {
-	.probe = fsl_sai_dai_probe,
 	.playback = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
@@ -1694,11 +1694,11 @@ static int fsl_sai_runtime_resume(struct device *dev)
 
 	regcache_cache_only(sai->regmap, false);
 	regcache_mark_dirty(sai->regmap);
-	regmap_write(sai->regmap, FSL_SAI_TCSR(ofs), FSL_SAI_CSR_SR);
-	regmap_write(sai->regmap, FSL_SAI_RCSR(ofs), FSL_SAI_CSR_SR);
+	regmap_update_bits(sai->regmap, FSL_SAI_TCSR(ofs), FSL_SAI_CSR_SR, FSL_SAI_CSR_SR);
+	regmap_update_bits(sai->regmap, FSL_SAI_RCSR(ofs), FSL_SAI_CSR_SR, FSL_SAI_CSR_SR);
 	usleep_range(1000, 2000);
-	regmap_write(sai->regmap, FSL_SAI_TCSR(ofs), 0);
-	regmap_write(sai->regmap, FSL_SAI_RCSR(ofs), 0);
+	regmap_update_bits(sai->regmap, FSL_SAI_TCSR(ofs), FSL_SAI_CSR_SR, 0);
+	regmap_update_bits(sai->regmap, FSL_SAI_RCSR(ofs), FSL_SAI_CSR_SR, 0);
 
 	ret = regcache_sync(sai->regmap);
 	if (ret)
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index fb6806b2db85..d89963b8171d 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -761,14 +761,6 @@ static int fsl_spdif_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops fsl_spdif_dai_ops = {
-	.startup = fsl_spdif_startup,
-	.hw_params = fsl_spdif_hw_params,
-	.trigger = fsl_spdif_trigger,
-	.shutdown = fsl_spdif_shutdown,
-};
-
-
 /*
  * FSL SPDIF IEC958 controller(mixer) functions
  *
@@ -1279,8 +1271,15 @@ static int fsl_spdif_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_spdif_dai_ops = {
+	.probe		= fsl_spdif_dai_probe,
+	.startup	= fsl_spdif_startup,
+	.hw_params	= fsl_spdif_hw_params,
+	.trigger	= fsl_spdif_trigger,
+	.shutdown	= fsl_spdif_shutdown,
+};
+
 static struct snd_soc_dai_driver fsl_spdif_dai = {
-	.probe = &fsl_spdif_dai_probe,
 	.playback = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 2,
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 6af00b62a60f..17887359dca1 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1152,6 +1152,7 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 }
 
 static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
+	.probe = fsl_ssi_dai_probe,
 	.startup = fsl_ssi_startup,
 	.shutdown = fsl_ssi_shutdown,
 	.hw_params = fsl_ssi_hw_params,
@@ -1162,7 +1163,6 @@ static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 };
 
 static struct snd_soc_dai_driver fsl_ssi_dai_template = {
-	.probe = fsl_ssi_dai_probe,
 	.playback = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
@@ -1187,7 +1187,6 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
 
 static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 	.symmetric_channels = 1,
-	.probe = fsl_ssi_dai_probe,
 	.playback = {
 		.stream_name = "CPU AC97 Playback",
 		.channels_min = 2,
diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index c043efe4548d..4c5864e8267d 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -864,13 +864,6 @@ static struct snd_kcontrol_new fsl_xcvr_tx_ctls[] = {
 	},
 };
 
-static const struct snd_soc_dai_ops fsl_xcvr_dai_ops = {
-	.prepare = fsl_xcvr_prepare,
-	.startup = fsl_xcvr_startup,
-	.shutdown = fsl_xcvr_shutdown,
-	.trigger = fsl_xcvr_trigger,
-};
-
 static int fsl_xcvr_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_xcvr *xcvr = snd_soc_dai_get_drvdata(dai);
@@ -887,8 +880,15 @@ static int fsl_xcvr_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops fsl_xcvr_dai_ops = {
+	.probe		= fsl_xcvr_dai_probe,
+	.prepare	= fsl_xcvr_prepare,
+	.startup	= fsl_xcvr_startup,
+	.shutdown	= fsl_xcvr_shutdown,
+	.trigger	= fsl_xcvr_trigger,
+};
+
 static struct snd_soc_dai_driver fsl_xcvr_dai = {
-	.probe  = fsl_xcvr_dai_probe,
 	.ops = &fsl_xcvr_dai_ops,
 	.playback = {
 		.stream_name = "CPU-Playback",
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 5daa824a4ffc..e5481142c6c4 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -114,7 +114,7 @@ static bool soc_component_is_pcm(struct snd_soc_dai_link_component *dlc)
 	struct snd_soc_dai *dai = snd_soc_find_dai_with_mutex(dlc);
 
 	if (dai && (dai->component->driver->pcm_construct ||
-		    dai->driver->pcm_new))
+		    (dai->driver->ops && dai->driver->ops->pcm_new)))
 		return true;
 
 	return false;
diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
index 5bb3eee2f783..04d0099adb8f 100644
--- a/sound/soc/intel/avs/core.c
+++ b/sound/soc/intel/avs/core.c
@@ -410,6 +410,8 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	adev = devm_kzalloc(dev, sizeof(*adev), GFP_KERNEL);
 	if (!adev)
 		return -ENOMEM;
+	bus = &adev->base.core;
+
 	ret = avs_bus_init(adev, pci, id);
 	if (ret < 0) {
 		dev_err(dev, "failed to init avs bus: %d\n", ret);
@@ -420,7 +422,6 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	if (ret < 0)
 		return ret;
 
-	bus = &adev->base.core;
 	bus->addr = pci_resource_start(pci, 0);
 	bus->remap_addr = pci_ioremap_bar(pci, 0);
 	if (!bus->remap_addr) {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b13370d2ec1d..80192b089f25 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -937,6 +937,9 @@ static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 void snd_soc_remove_pcm_runtime(struct snd_soc_card *card,
 				struct snd_soc_pcm_runtime *rtd)
 {
+	if (!rtd)
+		return;
+
 	lockdep_assert_held(&client_mutex);
 
 	/* release machine specific resources */
@@ -2423,6 +2426,7 @@ struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 {
 	struct device *dev = component->dev;
 	struct snd_soc_dai *dai;
+	struct snd_soc_dai_ops *ops; /* REMOVE ME */
 
 	dev_dbg(dev, "ASoC: dynamically register DAI %s\n", dev_name(dev));
 
@@ -2453,6 +2457,30 @@ struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 	if (!dai->name)
 		return NULL;
 
+	/* REMOVE ME */
+	if (dai_drv->probe		||
+	    dai_drv->remove		||
+	    dai_drv->compress_new	||
+	    dai_drv->pcm_new		||
+	    dai_drv->probe_order	||
+	    dai_drv->remove_order) {
+
+		ops = devm_kzalloc(dev, sizeof(struct snd_soc_dai_ops), GFP_KERNEL);
+		if (!ops)
+			return NULL;
+		if (dai_drv->ops)
+			memcpy(ops, dai_drv->ops, sizeof(struct snd_soc_dai_ops));
+
+		ops->probe		= dai_drv->probe;
+		ops->remove		= dai_drv->remove;
+		ops->compress_new	= dai_drv->compress_new;
+		ops->pcm_new		= dai_drv->pcm_new;
+		ops->probe_order	= dai_drv->probe_order;
+		ops->remove_order	= dai_drv->remove_order;
+
+		dai_drv->ops = ops;
+	}
+
 	dai->component = component;
 	dai->dev = dev;
 	dai->driver = dai_drv;
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index ba8a99124869..8e12f1059e72 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -460,8 +460,9 @@ int snd_soc_dai_compress_new(struct snd_soc_dai *dai,
 			     struct snd_soc_pcm_runtime *rtd, int num)
 {
 	int ret = -ENOTSUPP;
-	if (dai->driver->compress_new)
-		ret = dai->driver->compress_new(rtd, num);
+	if (dai->driver->ops &&
+	    dai->driver->ops->compress_new)
+		ret = dai->driver->ops->compress_new(rtd, num);
 	return soc_dai_ret(dai, ret);
 }
 
@@ -545,16 +546,20 @@ int snd_soc_pcm_dai_probe(struct snd_soc_pcm_runtime *rtd, int order)
 	int i;
 
 	for_each_rtd_dais(rtd, i, dai) {
-		if (dai->driver->probe_order != order)
+		if (dai->probed)
 			continue;
 
-		if (dai->driver->probe) {
-			int ret = dai->driver->probe(dai);
+		if (dai->driver->ops) {
+			if (dai->driver->ops->probe_order != order)
+				continue;
 
-			if (ret < 0)
-				return soc_dai_ret(dai, ret);
-		}
+			if (dai->driver->ops->probe) {
+				int ret = dai->driver->ops->probe(dai);
 
+				if (ret < 0)
+					return soc_dai_ret(dai, ret);
+			}
+		}
 		dai->probed = 1;
 	}
 
@@ -567,16 +572,19 @@ int snd_soc_pcm_dai_remove(struct snd_soc_pcm_runtime *rtd, int order)
 	int i, r, ret = 0;
 
 	for_each_rtd_dais(rtd, i, dai) {
-		if (dai->driver->remove_order != order)
+		if (!dai->probed)
 			continue;
 
-		if (dai->probed &&
-		    dai->driver->remove) {
-			r = dai->driver->remove(dai);
-			if (r < 0)
-				ret = r; /* use last error */
-		}
+		if (dai->driver->ops) {
+			if (dai->driver->ops->remove_order != order)
+				continue;
 
+			if (dai->driver->ops->remove) {
+				r = dai->driver->ops->remove(dai);
+				if (r < 0)
+					ret = r; /* use last error */
+			}
+		}
 		dai->probed = 0;
 	}
 
@@ -589,8 +597,9 @@ int snd_soc_pcm_dai_new(struct snd_soc_pcm_runtime *rtd)
 	int i;
 
 	for_each_rtd_dais(rtd, i, dai) {
-		if (dai->driver->pcm_new) {
-			int ret = dai->driver->pcm_new(rtd, dai);
+		if (dai->driver->ops &&
+		    dai->driver->ops->pcm_new) {
+			int ret = dai->driver->ops->pcm_new(rtd, dai);
 			if (ret < 0)
 				return soc_dai_ret(dai, ret);
 		}
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4103443770b0..481e5dd593b6 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -742,6 +742,10 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 out:
 	trace_snd_soc_bias_level_done(card, level);
 
+	/* success */
+	if (ret == 0)
+		snd_soc_dapm_init_bias_level(dapm, level);
+
 	return ret;
 }
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index be0b3c8ac705..f2cce15be4e2 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -2150,15 +2150,15 @@ static int dell_dock_mixer_init(struct usb_mixer_interface *mixer)
 #define SND_RME_CLK_FREQMUL_SHIFT		18
 #define SND_RME_CLK_FREQMUL_MASK		0x7
 #define SND_RME_CLK_SYSTEM(x) \
-	((x >> SND_RME_CLK_SYSTEM_SHIFT) & SND_RME_CLK_SYSTEM_MASK)
+	(((x) >> SND_RME_CLK_SYSTEM_SHIFT) & SND_RME_CLK_SYSTEM_MASK)
 #define SND_RME_CLK_AES(x) \
-	((x >> SND_RME_CLK_AES_SHIFT) & SND_RME_CLK_AES_SPDIF_MASK)
+	(((x) >> SND_RME_CLK_AES_SHIFT) & SND_RME_CLK_AES_SPDIF_MASK)
 #define SND_RME_CLK_SPDIF(x) \
-	((x >> SND_RME_CLK_SPDIF_SHIFT) & SND_RME_CLK_AES_SPDIF_MASK)
+	(((x) >> SND_RME_CLK_SPDIF_SHIFT) & SND_RME_CLK_AES_SPDIF_MASK)
 #define SND_RME_CLK_SYNC(x) \
-	((x >> SND_RME_CLK_SYNC_SHIFT) & SND_RME_CLK_SYNC_MASK)
+	(((x) >> SND_RME_CLK_SYNC_SHIFT) & SND_RME_CLK_SYNC_MASK)
 #define SND_RME_CLK_FREQMUL(x) \
-	((x >> SND_RME_CLK_FREQMUL_SHIFT) & SND_RME_CLK_FREQMUL_MASK)
+	(((x) >> SND_RME_CLK_FREQMUL_SHIFT) & SND_RME_CLK_FREQMUL_MASK)
 #define SND_RME_CLK_AES_LOCK			0x1
 #define SND_RME_CLK_AES_SYNC			0x4
 #define SND_RME_CLK_SPDIF_LOCK			0x2
@@ -2167,9 +2167,9 @@ static int dell_dock_mixer_init(struct usb_mixer_interface *mixer)
 #define SND_RME_SPDIF_FORMAT_SHIFT		5
 #define SND_RME_BINARY_MASK			0x1
 #define SND_RME_SPDIF_IF(x) \
-	((x >> SND_RME_SPDIF_IF_SHIFT) & SND_RME_BINARY_MASK)
+	(((x) >> SND_RME_SPDIF_IF_SHIFT) & SND_RME_BINARY_MASK)
 #define SND_RME_SPDIF_FORMAT(x) \
-	((x >> SND_RME_SPDIF_FORMAT_SHIFT) & SND_RME_BINARY_MASK)
+	(((x) >> SND_RME_SPDIF_FORMAT_SHIFT) & SND_RME_BINARY_MASK)
 
 static const u32 snd_rme_rate_table[] = {
 	32000, 44100, 48000, 50000,
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 0f1558ef8555..12a5e053ec54 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -341,20 +341,28 @@ snd_pcm_chmap_elem *convert_chmap_v3(struct uac3_cluster_header_descriptor
 
 	len = le16_to_cpu(cluster->wLength);
 	c = 0;
-	p += sizeof(struct uac3_cluster_header_descriptor);
+	p += sizeof(*cluster);
+	len -= sizeof(*cluster);
 
-	while (((p - (void *)cluster) < len) && (c < channels)) {
+	while (len > 0 && (c < channels)) {
 		struct uac3_cluster_segment_descriptor *cs_desc = p;
 		u16 cs_len;
 		u8 cs_type;
 
+		if (len < sizeof(*cs_desc))
+			break;
 		cs_len = le16_to_cpu(cs_desc->wLength);
+		if (len < cs_len)
+			break;
 		cs_type = cs_desc->bSegmentType;
 
 		if (cs_type == UAC3_CHANNEL_INFORMATION) {
 			struct uac3_cluster_information_segment_descriptor *is = p;
 			unsigned char map;
 
+			if (cs_len < sizeof(*is))
+				break;
+
 			/*
 			 * TODO: this conversion is not complete, update it
 			 * after adding UAC3 values to asound.h
@@ -456,6 +464,7 @@ snd_pcm_chmap_elem *convert_chmap_v3(struct uac3_cluster_header_descriptor
 			chmap->map[c++] = map;
 		}
 		p += cs_len;
+		len -= cs_len;
 	}
 
 	if (channels < c)
@@ -876,7 +885,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	u64 badd_formats = 0;
 	unsigned int num_channels;
 	struct audioformat *fp;
-	u16 cluster_id, wLength;
+	u16 cluster_id, wLength, cluster_wLength;
 	int clock = 0;
 	int err;
 
@@ -1005,6 +1014,16 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 		return ERR_PTR(-EIO);
 	}
 
+	cluster_wLength = le16_to_cpu(cluster->wLength);
+	if (cluster_wLength < sizeof(*cluster) ||
+	    cluster_wLength > wLength) {
+		dev_err(&dev->dev,
+			"%u:%d : invalid Cluster Descriptor size\n",
+			iface_no, altno);
+		kfree(cluster);
+		return ERR_PTR(-EIO);
+	}
+
 	num_channels = cluster->bNrChannels;
 	chmap = convert_chmap_v3(cluster);
 	kfree(cluster);
diff --git a/sound/usb/validate.c b/sound/usb/validate.c
index 6fe206f6e911..a0d55b77c994 100644
--- a/sound/usb/validate.c
+++ b/sound/usb/validate.c
@@ -221,6 +221,17 @@ static bool validate_uac3_feature_unit(const void *p,
 	return d->bLength >= sizeof(*d) + 4 + 2;
 }
 
+static bool validate_uac3_power_domain_unit(const void *p,
+					    const struct usb_desc_validator *v)
+{
+	const struct uac3_power_domain_descriptor *d = p;
+
+	if (d->bLength < sizeof(*d))
+		return false;
+	/* baEntities[] + wPDomainDescrStr */
+	return d->bLength >= sizeof(*d) + d->bNrEntities + 2;
+}
+
 static bool validate_midi_out_jack(const void *p,
 				   const struct usb_desc_validator *v)
 {
@@ -274,7 +285,7 @@ static const struct usb_desc_validator audio_validators[] = {
 	/* UAC_VERSION_3, UAC3_EXTENDED_TERMINAL: not implemented yet */
 	FUNC(UAC_VERSION_3, UAC3_MIXER_UNIT, validate_mixer_unit),
 	FUNC(UAC_VERSION_3, UAC3_SELECTOR_UNIT, validate_selector_unit),
-	FUNC(UAC_VERSION_3, UAC_FEATURE_UNIT, validate_uac3_feature_unit),
+	FUNC(UAC_VERSION_3, UAC3_FEATURE_UNIT, validate_uac3_feature_unit),
 	/*  UAC_VERSION_3, UAC3_EFFECT_UNIT: not implemented yet */
 	FUNC(UAC_VERSION_3, UAC3_PROCESSING_UNIT, validate_processing_unit),
 	FUNC(UAC_VERSION_3, UAC3_EXTENSION_UNIT, validate_processing_unit),
@@ -285,6 +296,7 @@ static const struct usb_desc_validator audio_validators[] = {
 	      struct uac3_clock_multiplier_descriptor),
 	/* UAC_VERSION_3, UAC3_SAMPLE_RATE_CONVERTER: not implemented yet */
 	/* UAC_VERSION_3, UAC3_CONNECTORS: not implemented yet */
+	FUNC(UAC_VERSION_3, UAC3_POWER_DOMAIN, validate_uac3_power_domain_unit),
 	{ } /* terminator */
 };
 
diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 1747ae125392..a0ea830e1ba1 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -33,6 +33,8 @@ typedef unsigned long     uintptr_t;
 typedef   signed long      intptr_t;
 typedef   signed long     ptrdiff_t;
 
+#include <linux/types.h>
+
 /* those are commonly provided by sys/types.h */
 typedef unsigned int          dev_t;
 typedef unsigned long         ino_t;
@@ -44,6 +46,6 @@ typedef unsigned long       nlink_t;
 typedef   signed long         off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
-typedef   signed long        time_t;
+typedef __kernel_old_time_t  time_t;
 
 #endif /* _NOLIBC_STD_H */
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index fbbc0e68c001..a6f3af0509eb 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -102,7 +102,7 @@ typedef struct {
 		int __fd = (fd);					\
 		if (__fd >= 0)						\
 			__set->fds[__fd / FD_SETIDXMASK] &=		\
-				~(1U << (__fd & FX_SETBITMASK));	\
+				~(1U << (__fd & FD_SETBITMASK));	\
 	} while (0)
 
 #define FD_SET(fd, set) do {						\
@@ -119,7 +119,7 @@ typedef struct {
 		int __r = 0;						\
 		if (__fd >= 0)						\
 			__r = !!(__set->fds[__fd / FD_SETIDXMASK] &	\
-1U << (__fd & FD_SET_BITMASK));						\
+1U << (__fd & FD_SETBITMASK));						\
 		__r;							\
 	})
 
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 0242f31e339c..0d2eabfac956 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -863,6 +863,7 @@ enum {
 	IFLA_BOND_AD_LACP_ACTIVE,
 	IFLA_BOND_MISSED_MAX,
 	IFLA_BOND_NS_IP6_TARGET,
+	IFLA_BOND_COUPLED_CONTROL,
 	__IFLA_BOND_MAX,
 };
 
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index 08a399b0be28..6ab9139f16af 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -240,9 +240,9 @@ static int mperf_stop(void)
 	int cpu;
 
 	for (cpu = 0; cpu < cpu_count; cpu++) {
-		mperf_measure_stats(cpu);
-		mperf_get_tsc(&tsc_at_measure_end[cpu]);
 		clock_gettime(CLOCK_REALTIME, &time_end[cpu]);
+		mperf_get_tsc(&tsc_at_measure_end[cpu]);
+		mperf_measure_stats(cpu);
 	}
 
 	return 0;
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 0efb8f2b33ce..5607e2405a72 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -98,7 +98,9 @@ else ifneq ($(CROSS_COMPILE),)
 # Allow userspace to override CLANG_CROSS_FLAGS to specify their own
 # sysroots and flags or to avoid the GCC call in pure Clang builds.
 ifeq ($(CLANG_CROSS_FLAGS),)
-CLANG_CROSS_FLAGS := --target=$(notdir $(CROSS_COMPILE:%-=%))
+CLANG_TARGET := $(notdir $(CROSS_COMPILE:%-=%))
+CLANG_TARGET := $(subst s390-linux,s390x-linux,$(CLANG_TARGET))
+CLANG_CROSS_FLAGS := --target=$(CLANG_TARGET)
 GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)gcc 2>/dev/null))
 ifneq ($(GCC_TOOLCHAIN_DIR),)
 CLANG_CROSS_FLAGS += --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 2109bd42c144..26544bba3f8f 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1351,7 +1351,10 @@ sub __eval_option {
 	# If a variable contains itself, use the default var
 	if (($var eq $name) && defined($opt{$var})) {
 	    $o = $opt{$var};
-	    $retval = "$retval$o";
+	    # Only append if the default doesn't contain itself
+	    if ($o !~ m/\$\{$var\}/) {
+		$retval = "$retval$o";
+	    }
 	} elsif (defined($opt{$o})) {
 	    $o = $opt{$o};
 	    $retval = "$retval$o";
diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 91dd31629ffe..9f5461cd5b8f 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -158,7 +158,7 @@ static void ptrace_set_get_inherit(pid_t child, const struct vec_type *type)
 	memset(&sve, 0, sizeof(sve));
 	sve.size = sizeof(sve);
 	sve.vl = sve_vl_from_vq(SVE_VQ_MIN);
-	sve.flags = SVE_PT_VL_INHERIT;
+	sve.flags = SVE_PT_VL_INHERIT | SVE_PT_REGS_SVE;
 	ret = set_sve(child, type, &sve);
 	if (ret != 0) {
 		ksft_test_result_fail("Failed to set %s SVE_PT_VL_INHERIT\n",
@@ -223,6 +223,7 @@ static void ptrace_set_get_vl(pid_t child, const struct vec_type *type,
 	/* Set the VL by doing a set with no register payload */
 	memset(&sve, 0, sizeof(sve));
 	sve.size = sizeof(sve);
+	sve.flags = SVE_PT_REGS_SVE;
 	sve.vl = vl;
 	ret = set_sve(child, type, &sve);
 	if (ret != 0) {
diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
index ca81d660eb96..5e88d37973c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -23,8 +23,7 @@
 static size_t log_buf_sz = 1 << 20; /* 1 MB */
 static char obj_log_buf[1048576];
 static const long c_sample_size = sizeof(struct sample) + BPF_RINGBUF_HDR_SZ;
-static const long c_ringbuf_size = 1 << 12; /* 1 small page */
-static const long c_max_entries = c_ringbuf_size / c_sample_size;
+static long c_ringbuf_size, c_max_entries;
 
 static void drain_current_samples(void)
 {
@@ -426,7 +425,9 @@ static void test_user_ringbuf_loop(void)
 	uint32_t remaining_samples = total_samples;
 	int err;
 
-	BUILD_BUG_ON(total_samples <= c_max_entries);
+	if (!ASSERT_LT(c_max_entries, total_samples, "compare_c_max_entries"))
+		return;
+
 	err = load_skel_create_user_ringbuf(&skel, &ringbuf);
 	if (err)
 		return;
@@ -739,6 +740,9 @@ void test_user_ringbuf(void)
 {
 	int i;
 
+	c_ringbuf_size = getpagesize(); /* 1 page */
+	c_max_entries = c_ringbuf_size / c_sample_size;
+
 	for (i = 0; i < ARRAY_SIZE(success_tests); i++) {
 		if (!test__start_subtest(success_tests[i].test_name))
 			continue;
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
index 4b994b6df5ac..ed81eaf2afd6 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
@@ -29,7 +29,7 @@ ftrace_filter_check 'schedule*' '^schedule.*$'
 ftrace_filter_check '*pin*lock' '.*pin.*lock$'
 
 # filter by start*mid*
-ftrace_filter_check 'mutex*try*' '^mutex.*try.*'
+ftrace_filter_check 'mutex*unl*' '^mutex.*unl.*'
 
 # Advanced full-glob matching feature is recently supported.
 # Skip the tests if we are sure the kernel does not support it.
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index ddbcfc9b7bac..7a5fd1d5355e 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -47,6 +47,17 @@ typedef volatile u_int32_t futex_t;
 					 FUTEX_PRIVATE_FLAG)
 #endif
 
+/*
+ * SYS_futex is expected from system C library, in glibc some 32-bit
+ * architectures (e.g. RV32) are using 64-bit time_t, therefore it doesn't have
+ * SYS_futex defined but just SYS_futex_time64. Define SYS_futex as
+ * SYS_futex_time64 in this situation to ensure the compilation and the
+ * compatibility.
+ */
+#if !defined(SYS_futex) && defined(SYS_futex_time64)
+#define SYS_futex SYS_futex_time64
+#endif
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 94df2692e6e4..15a90db80836 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -186,6 +186,24 @@ static void *mfd_assert_mmap_shared(int fd)
 	return p;
 }
 
+static void *mfd_assert_mmap_read_shared(int fd)
+{
+	void *p;
+
+	p = mmap(NULL,
+		 mfd_def_size,
+		 PROT_READ,
+		 MAP_SHARED,
+		 fd,
+		 0);
+	if (p == MAP_FAILED) {
+		printf("mmap() failed: %m\n");
+		abort();
+	}
+
+	return p;
+}
+
 static void *mfd_assert_mmap_private(int fd)
 {
 	void *p;
@@ -802,6 +820,30 @@ static void test_seal_future_write(void)
 	close(fd);
 }
 
+static void test_seal_write_map_read_shared(void)
+{
+	int fd;
+	void *p;
+
+	printf("%s SEAL-WRITE-MAP-READ\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_write_map_read",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_add_seals(fd, F_SEAL_WRITE);
+	mfd_assert_has_seals(fd, F_SEAL_WRITE);
+
+	p = mfd_assert_mmap_read_shared(fd);
+
+	mfd_assert_read(fd);
+	mfd_assert_read_shared(fd);
+	mfd_fail_write(fd);
+
+	munmap(p, mfd_def_size);
+	close(fd);
+}
+
 /*
  * Test SEAL_SHRINK
  * Test whether SEAL_SHRINK actually prevents shrinking
@@ -1056,6 +1098,7 @@ int main(int argc, char **argv)
 
 	test_seal_write();
 	test_seal_future_write();
+	test_seal_write_map_read_shared();
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index d02e0d63a8f9..1b0ed849c617 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -131,6 +131,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 1 9
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
 subflows 8" "set limits"
 

