Return-Path: <stable+bounces-165720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ED8B17F5A
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82874A83D98
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 09:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D1222DFB8;
	Fri,  1 Aug 2025 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dY10WmOu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF6522DA08;
	Fri,  1 Aug 2025 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040785; cv=none; b=KzCIKUecHcbZvr9h2/f7X2oQX1syInhhHruM0czdjMt1bpnrPgQQOE8d12sYgDRrUuKLiBMN06/zXd0dwjiloj5ZSXZFlh6Uf5YgeGNrjSeJ4b/V9u22OgDgvZYUzzLbUz0ULeKYAk4BFD84Bybkmo2VM/AIg6DRbzwpXNnSh8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040785; c=relaxed/simple;
	bh=kBHqOY6TEvF8bm4q3whUUxgrb6N40vNyFlKWhTXoW0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYyv9B0AYe4kJm1qV2B7VQB3paZhHRSLQRuaHnEidHiibGOmvZNiwM0zwmtqETJ36kF6bXnc3XynEJRLPl/wXuMS6T3onRF/WT0NIWuhsdTdj1Ua3OPmWd6QsY2H2efB+8Gufz3WzQCN6WvLvE+WPJFvfcQ+PvQI6k0TX9ls8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dY10WmOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB07AC4CEE7;
	Fri,  1 Aug 2025 09:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754040785;
	bh=kBHqOY6TEvF8bm4q3whUUxgrb6N40vNyFlKWhTXoW0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dY10WmOuH7ZYHukjEV5eNWV6oyYfA0r3ekSv5IK4lqW1TR1D5eM5vGD+BdykAIend
	 T6NWnZ6F052NR+bvBgyURBbQHRBudDRnjTGEa83SsoSeLJInsOcAgwf7kbL/otfn5k
	 el2D05jG26PtsonFCv9fgbmCt6gEE1uHZ/LiOqDg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.41
Date: Fri,  1 Aug 2025 10:32:51 +0100
Message-ID: <2025080151-deck-quickness-476f@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025080151-frozen-sector-d28f@gregkh>
References: <2025080151-frozen-sector-d28f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/.clippy.toml b/.clippy.toml
index 5d99a317f7d6..137f41d203de 100644
--- a/.clippy.toml
+++ b/.clippy.toml
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+msrv = "1.78.0"
+
 check-private-items = true
 
 disallowed-macros = [
diff --git a/Makefile b/Makefile
index c891f51637d5..fbaebf00a33b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 40
+SUBLEVEL = 41
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d0040fb67c36..d5bf16462bdb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -118,7 +118,7 @@ config ARM
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
 	select HAVE_KRETPROBES if HAVE_KPROBES
-	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_CAN_USE_KEEP_IN_OVERLAY)
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_IS_LLD) && LD_CAN_USE_KEEP_IN_OVERLAY
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_OPTPROBES if !THUMB2_KERNEL
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index aafebf145738..dee8c9fe25a2 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -149,7 +149,7 @@ endif
 # Need -Uarm for gcc < 3.x
 KBUILD_CPPFLAGS	+=$(cpp-y)
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -include $(srctree)/arch/arm/include/asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
 
diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
index b1fa8f3558b3..02ae736a2205 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
@@ -232,6 +232,7 @@ vreg_l12b_1p2: ldo12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l13b_3p0: ldo13 {
@@ -253,6 +254,7 @@ vreg_l15b_1p8: ldo15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l17b_2p5: ldo17 {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 2a504a449b0b..e5d0d7d898c3 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -659,8 +659,8 @@ vreg_l1j_0p8: ldo1 {
 
 		vreg_l2j_1p2: ldo2 {
 			regulator-name = "vreg_l2j_1p2";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1256000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index c1f45fd6b3e9..d8ffccee8194 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -41,6 +41,11 @@
 /*
  * Save/restore interrupts.
  */
+	.macro save_and_disable_daif, flags
+	mrs	\flags, daif
+	msr	daifset, #0xf
+	.endm
+
 	.macro	save_and_disable_irq, flags
 	mrs	\flags, daif
 	msr	daifset, #3
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7ef0e127b149..189ce50055d1 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -823,6 +823,7 @@ SYM_CODE_END(__bp_harden_el1_vectors)
  *
  */
 SYM_FUNC_START(cpu_switch_to)
+	save_and_disable_daif x11
 	mov	x10, #THREAD_CPU_CONTEXT
 	add	x8, x0, x10
 	mov	x9, sp
@@ -846,6 +847,7 @@ SYM_FUNC_START(cpu_switch_to)
 	ptrauth_keys_install_kernel x1, x8, x9, x10
 	scs_save x0
 	scs_load_current
+	restore_irq x11
 	ret
 SYM_FUNC_END(cpu_switch_to)
 NOKPROBE(cpu_switch_to)
@@ -872,6 +874,7 @@ NOKPROBE(ret_from_fork)
  * Calls func(regs) using this CPU's irq stack and shadow irq stack.
  */
 SYM_FUNC_START(call_on_irq_stack)
+	save_and_disable_daif x9
 #ifdef CONFIG_SHADOW_CALL_STACK
 	get_current_task x16
 	scs_save x16
@@ -886,8 +889,10 @@ SYM_FUNC_START(call_on_irq_stack)
 
 	/* Move to the new stack and call the function there */
 	add	sp, x16, #IRQ_STACK_SIZE
+	restore_irq x9
 	blr	x1
 
+	save_and_disable_daif x9
 	/*
 	 * Restore the SP from the FP, and restore the FP and LR from the frame
 	 * record.
@@ -895,6 +900,7 @@ SYM_FUNC_START(call_on_irq_stack)
 	mov	sp, x29
 	ldp	x29, x30, [sp], #16
 	scs_load_current
+	restore_irq x9
 	ret
 SYM_FUNC_END(call_on_irq_stack)
 NOKPROBE(call_on_irq_stack)
diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index 7012fa55aceb..15783f2307df 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -143,6 +143,7 @@ config CRYPTO_CHACHA20_P10
 config CRYPTO_POLY1305_P10
 	tristate "Hash functions: Poly1305 (P10 or later)"
 	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
+	depends on BROKEN # Needs to be fixed to work in softirq context
 	select CRYPTO_HASH
 	select CRYPTO_LIB_POLY1305_GENERIC
 	help
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 95eada2994e1..239f612816e6 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -730,3 +730,36 @@ bool hv_is_hyperv_initialized(void)
 	return hypercall_msr.enable;
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+int hv_apicid_to_vp_index(u32 apic_id)
+{
+	u64 control;
+	u64 status;
+	unsigned long irq_flags;
+	struct hv_get_vp_from_apic_id_in *input;
+	u32 *output, ret;
+
+	local_irq_save(irq_flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->partition_id = HV_PARTITION_ID_SELF;
+	input->apic_ids[0] = apic_id;
+
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
+	status = hv_do_hypercall(control, input, output);
+	ret = output[0];
+
+	local_irq_restore(irq_flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("failed to get vp index from apic id %d, status %#llx\n",
+		       apic_id, status);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hv_apicid_to_vp_index);
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index d04ccd4b3b4a..2510e91b29b0 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -175,41 +175,9 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 	return ret;
 }
 
-static int hv_vtl_apicid_to_vp_id(u32 apic_id)
-{
-	u64 control;
-	u64 status;
-	unsigned long irq_flags;
-	struct hv_get_vp_from_apic_id_in *input;
-	u32 *output, ret;
-
-	local_irq_save(irq_flags);
-
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(input, 0, sizeof(*input));
-	input->partition_id = HV_PARTITION_ID_SELF;
-	input->apic_ids[0] = apic_id;
-
-	output = (u32 *)input;
-
-	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
-	status = hv_do_hypercall(control, input, output);
-	ret = output[0];
-
-	local_irq_restore(irq_flags);
-
-	if (!hv_result_success(status)) {
-		pr_err("failed to get vp id from apic id %d, status %#llx\n",
-		       apic_id, status);
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
 static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 {
-	int vp_id, cpu;
+	int vp_index, cpu;
 
 	/* Find the logical CPU for the APIC ID */
 	for_each_present_cpu(cpu) {
@@ -220,18 +188,18 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 		return -EINVAL;
 
 	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
-	vp_id = hv_vtl_apicid_to_vp_id(apicid);
+	vp_index = hv_apicid_to_vp_index(apicid);
 
-	if (vp_id < 0) {
+	if (vp_index < 0) {
 		pr_err("Couldn't find CPU with APIC ID %d\n", apicid);
 		return -EINVAL;
 	}
-	if (vp_id > ms_hyperv.max_vp_index) {
-		pr_err("Invalid CPU id %d for APIC ID %d\n", vp_id, apicid);
+	if (vp_index > ms_hyperv.max_vp_index) {
+		pr_err("Invalid CPU id %d for APIC ID %d\n", vp_index, apicid);
 		return -EINVAL;
 	}
 
-	return hv_vtl_bringup_vcpu(vp_id, cpu, start_eip);
+	return hv_vtl_bringup_vcpu(vp_index, cpu, start_eip);
 }
 
 int __init hv_vtl_early_init(void)
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 3215a4a07408..939b7081c5ab 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -192,7 +192,6 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	struct pci_dev *dev;
 	struct hv_interrupt_entry out_entry, *stored_entry;
 	struct irq_cfg *cfg = irqd_cfg(data);
-	const cpumask_t *affinity;
 	int cpu;
 	u64 status;
 
@@ -204,8 +203,7 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		return;
 	}
 
-	affinity = irq_data_get_effective_affinity_mask(data);
-	cpu = cpumask_first_and(affinity, cpu_online_mask);
+	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
 
 	if (data->chip_data) {
 		/*
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 4065f5ef3ae0..af87f440bc2a 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -10,6 +10,7 @@
 #include <linux/hyperv.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
 #include <asm/svm.h>
 #include <asm/sev.h>
 #include <asm/io.h>
@@ -289,7 +290,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
 		free_page((unsigned long)vmsa);
 }
 
-int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
+int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
 		__get_free_page(GFP_KERNEL | __GFP_ZERO);
@@ -298,10 +299,27 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 	u64 ret, retry = 5;
 	struct hv_enable_vp_vtl *start_vp_input;
 	unsigned long flags;
+	int cpu, vp_index;
 
 	if (!vmsa)
 		return -ENOMEM;
 
+	/* Find the Hyper-V VP index which might be not the same as APIC ID */
+	vp_index = hv_apicid_to_vp_index(apic_id);
+	if (vp_index < 0 || vp_index > ms_hyperv.max_vp_index)
+		return -EINVAL;
+
+	/*
+	 * Find the Linux CPU number for addressing the per-CPU data, and it
+	 * might not be the same as APIC ID.
+	 */
+	for_each_present_cpu(cpu) {
+		if (arch_match_cpu_phys_id(cpu, apic_id))
+			break;
+	}
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
 	native_store_gdt(&gdtr);
 
 	vmsa->gdtr.base = gdtr.address;
@@ -349,7 +367,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 	start_vp_input = (struct hv_enable_vp_vtl *)ap_start_input_arg;
 	memset(start_vp_input, 0, sizeof(*start_vp_input));
 	start_vp_input->partition_id = -1;
-	start_vp_input->vp_index = cpu;
+	start_vp_input->vp_index = vp_index;
 	start_vp_input->target_vtl.target_vtl = ms_hyperv.vtl;
 	*(u64 *)&start_vp_input->vp_context = __pa(vmsa) | 1;
 
diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index fdbbbfec745a..820b4aeabd0c 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -9,6 +9,14 @@
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
 
+/*
+ * Define bits that are always set to 1 in DR7, only bit 10 is
+ * architecturally reserved to '1'.
+ *
+ * This is also the init/reset value for DR7.
+ */
+#define DR7_FIXED_1	0x00000400
+
 DECLARE_PER_CPU(unsigned long, cpu_dr7);
 
 #ifndef CONFIG_PARAVIRT_XXL
@@ -100,8 +108,8 @@ static __always_inline void native_set_debugreg(int regno, unsigned long value)
 
 static inline void hw_breakpoint_disable(void)
 {
-	/* Zero the control register for HW Breakpoint */
-	set_debugreg(0UL, 7);
+	/* Reset the control register for HW Breakpoint */
+	set_debugreg(DR7_FIXED_1, 7);
 
 	/* Zero-out the individual HW breakpoint address registers */
 	set_debugreg(0UL, 0);
@@ -125,9 +133,12 @@ static __always_inline unsigned long local_db_save(void)
 		return 0;
 
 	get_debugreg(dr7, 7);
-	dr7 &= ~0x400; /* architecturally set bit */
+
+	/* Architecturally set bit */
+	dr7 &= ~DR7_FIXED_1;
 	if (dr7)
-		set_debugreg(0, 7);
+		set_debugreg(DR7_FIXED_1, 7);
+
 	/*
 	 * Ensure the compiler doesn't lower the above statements into
 	 * the critical section; disabling breakpoints late would not
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e4dd840e0bec..0caa3293f6db 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -31,6 +31,7 @@
 
 #include <asm/apic.h>
 #include <asm/pvclock-abi.h>
+#include <asm/debugreg.h>
 #include <asm/desc.h>
 #include <asm/mtrr.h>
 #include <asm/msr-index.h>
@@ -246,7 +247,6 @@ enum x86_intercept_stage;
 #define DR7_BP_EN_MASK	0x000000ff
 #define DR7_GE		(1 << 9)
 #define DR7_GD		(1 << 13)
-#define DR7_FIXED_1	0x00000400
 #define DR7_VOLATILE	0xffff2bff
 
 #define KVM_GUESTDBG_VALID_MASK \
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 5f0bc6a6d025..a42439c2ed24 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -275,11 +275,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
-int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
+int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip);
 #else
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
-static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { return 0; }
+static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip) { return 0; }
 #endif
 
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
@@ -313,6 +313,7 @@ static __always_inline u64 hv_raw_get_msr(unsigned int reg)
 {
 	return __rdmsr(reg);
 }
+int hv_apicid_to_vp_index(u32 apic_id);
 
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
@@ -334,6 +335,7 @@ static inline void hv_set_msr(unsigned int reg, u64 value) { }
 static inline u64 hv_get_msr(unsigned int reg) { return 0; }
 static inline void hv_set_non_nested_msr(unsigned int reg, u64 value) { }
 static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
+static inline int hv_apicid_to_vp_index(u32 apic_id) { return -EINVAL; }
 #endif /* CONFIG_HYPERV */
 
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index efd42ee9d1cc..4810271302d0 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -378,6 +378,8 @@ static bool amd_check_tsa_microcode(void)
 	p.model		= c->x86_model;
 	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
+	/* reserved bits are expected to be 0 in test below */
+	p.__reserved	= 0;
 
 	if (cpu_has(c, X86_FEATURE_ZEN3) ||
 	    cpu_has(c, X86_FEATURE_ZEN4)) {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ed072b126111..976545ec8fdc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2160,7 +2160,7 @@ EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 static void initialize_debug_regs(void)
 {
 	/* Control register first -- to make sure everything is disabled. */
-	set_debugreg(0, 7);
+	set_debugreg(DR7_FIXED_1, 7);
 	set_debugreg(DR6_RESERVED, 6);
 	/* dr5 and dr4 don't exist */
 	set_debugreg(0, 3);
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 9c9faa1634fb..e5faeec20b1f 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -385,7 +385,7 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
 	struct perf_event *bp;
 
 	/* Disable hardware debugging while we are in kgdb: */
-	set_debugreg(0UL, 7);
+	set_debugreg(DR7_FIXED_1, 7);
 	for (i = 0; i < HBP_NUM; i++) {
 		if (!breakinfo[i].enabled)
 			continue;
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0917c7f25720..f10c14cb6ef8 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -93,7 +93,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 
 	/* Only print out debug registers if they are in their non-default state. */
 	if ((d0 == 0) && (d1 == 0) && (d2 == 0) && (d3 == 0) &&
-	    (d6 == DR6_RESERVED) && (d7 == 0x400))
+	    (d6 == DR6_RESERVED) && (d7 == DR7_FIXED_1))
 		return;
 
 	printk("%sDR0: %08lx DR1: %08lx DR2: %08lx DR3: %08lx\n",
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 226472332a70..266366a945ed 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -132,7 +132,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 
 	/* Only print out debug registers if they are in their non-default state. */
 	if (!((d0 == 0) && (d1 == 0) && (d2 == 0) && (d3 == 0) &&
-	    (d6 == DR6_RESERVED) && (d7 == 0x400))) {
+	    (d6 == DR6_RESERVED) && (d7 == DR7_FIXED_1))) {
 		printk("%sDR0: %016lx DR1: %016lx DR2: %016lx\n",
 		       log_lvl, d0, d1, d2);
 		printk("%sDR3: %016lx DR6: %016lx DR7: %016lx\n",
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index ad479cfb91bc..f16a7b2c2adc 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -2,7 +2,6 @@
 #ifndef ARCH_X86_KVM_CPUID_H
 #define ARCH_X86_KVM_CPUID_H
 
-#include "x86.h"
 #include "reverse_cpuid.h"
 #include <asm/cpu.h>
 #include <asm/processor.h>
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index e72aed25d721..60986f67c35a 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -651,9 +651,10 @@ static inline u8 ctxt_virt_addr_bits(struct x86_emulate_ctxt *ctxt)
 }
 
 static inline bool emul_is_noncanonical_address(u64 la,
-						struct x86_emulate_ctxt *ctxt)
+						struct x86_emulate_ctxt *ctxt,
+						unsigned int flags)
 {
-	return !__is_canonical_address(la, ctxt_virt_addr_bits(ctxt));
+	return !ctxt->ops->is_canonical_addr(ctxt, la, flags);
 }
 
 /*
@@ -1733,7 +1734,8 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 		if (ret != X86EMUL_CONTINUE)
 			return ret;
 		if (emul_is_noncanonical_address(get_desc_base(&seg_desc) |
-						 ((u64)base3 << 32), ctxt))
+						 ((u64)base3 << 32), ctxt,
+						 X86EMUL_F_DT_LOAD))
 			return emulate_gp(ctxt, err_code);
 	}
 
@@ -2516,8 +2518,8 @@ static int em_sysexit(struct x86_emulate_ctxt *ctxt)
 		ss_sel = cs_sel + 8;
 		cs.d = 0;
 		cs.l = 1;
-		if (emul_is_noncanonical_address(rcx, ctxt) ||
-		    emul_is_noncanonical_address(rdx, ctxt))
+		if (emul_is_noncanonical_address(rcx, ctxt, 0) ||
+		    emul_is_noncanonical_address(rdx, ctxt, 0))
 			return emulate_gp(ctxt, 0);
 		break;
 	}
@@ -3494,7 +3496,8 @@ static int em_lgdt_lidt(struct x86_emulate_ctxt *ctxt, bool lgdt)
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 	if (ctxt->mode == X86EMUL_MODE_PROT64 &&
-	    emul_is_noncanonical_address(desc_ptr.address, ctxt))
+	    emul_is_noncanonical_address(desc_ptr.address, ctxt,
+					 X86EMUL_F_DT_LOAD))
 		return emulate_gp(ctxt, 0);
 	if (lgdt)
 		ctxt->ops->set_gdt(ctxt, &desc_ptr);
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 44c88537448c..79d06a8a5b7d 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1980,6 +1980,9 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 		if (entries[i] == KVM_HV_TLB_FLUSHALL_ENTRY)
 			goto out_flush_all;
 
+		if (is_noncanonical_invlpg_address(entries[i], vcpu))
+			continue;
+
 		/*
 		 * Lower 12 bits of 'address' encode the number of additional
 		 * pages to flush.
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 55a18e2f2dcd..10495fffb890 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -94,6 +94,8 @@ struct x86_instruction_info {
 #define X86EMUL_F_FETCH			BIT(1)
 #define X86EMUL_F_IMPLICIT		BIT(2)
 #define X86EMUL_F_INVLPG		BIT(3)
+#define X86EMUL_F_MSR			BIT(4)
+#define X86EMUL_F_DT_LOAD		BIT(5)
 
 struct x86_emulate_ops {
 	void (*vm_bugged)(struct x86_emulate_ctxt *ctxt);
@@ -235,6 +237,9 @@ struct x86_emulate_ops {
 
 	gva_t (*get_untagged_addr)(struct x86_emulate_ctxt *ctxt, gva_t addr,
 				   unsigned int flags);
+
+	bool (*is_canonical_addr)(struct x86_emulate_ctxt *ctxt, gva_t addr,
+				  unsigned int flags);
 };
 
 /* Type, address-of, and value of an instruction's operand. */
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 9dc5dd43ae7f..e9322358678b 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -4,6 +4,7 @@
 
 #include <linux/kvm_host.h>
 #include "kvm_cache_regs.h"
+#include "x86.h"
 #include "cpuid.h"
 
 extern bool __read_mostly enable_mmio_caching;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4607610ef062..8edfb4e4a73d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6234,7 +6234,7 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	/* It's actually a GPA for vcpu->arch.guest_mmu.  */
 	if (mmu != &vcpu->arch.guest_mmu) {
 		/* INVLPG on a non-canonical address is a NOP according to the SDM.  */
-		if (is_noncanonical_address(addr, vcpu))
+		if (is_noncanonical_invlpg_address(addr, vcpu))
 			return;
 
 		kvm_x86_call(flush_tlb_gva)(vcpu, addr);
diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
index 05490b9d8a43..6f74e2b27c1e 100644
--- a/arch/x86/kvm/mtrr.c
+++ b/arch/x86/kvm/mtrr.c
@@ -19,6 +19,7 @@
 #include <asm/mtrr.h>
 
 #include "cpuid.h"
+#include "x86.h"
 
 static u64 *find_mtrr(struct kvm_vcpu *vcpu, unsigned int msr)
 {
diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index fab6a1ad98dc..fa41d036acd4 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -4,6 +4,7 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 
+#include "x86.h"
 #include "../cpuid.h"
 #include "hyperv.h"
 #include "nested.h"
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 22bee8a71144..903e874041ac 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7,6 +7,7 @@
 #include <asm/debugreg.h>
 #include <asm/mmu_context.h>
 
+#include "x86.h"
 #include "cpuid.h"
 #include "hyperv.h"
 #include "mmu.h"
@@ -16,7 +17,6 @@
 #include "sgx.h"
 #include "trace.h"
 #include "vmx.h"
-#include "x86.h"
 #include "smm.h"
 
 static bool __read_mostly enable_shadow_vmcs = 1;
@@ -3020,8 +3020,8 @@ static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
 	    CC(!kvm_vcpu_is_legal_cr3(vcpu, vmcs12->host_cr3)))
 		return -EINVAL;
 
-	if (CC(is_noncanonical_address(vmcs12->host_ia32_sysenter_esp, vcpu)) ||
-	    CC(is_noncanonical_address(vmcs12->host_ia32_sysenter_eip, vcpu)))
+	if (CC(is_noncanonical_msr_address(vmcs12->host_ia32_sysenter_esp, vcpu)) ||
+	    CC(is_noncanonical_msr_address(vmcs12->host_ia32_sysenter_eip, vcpu)))
 		return -EINVAL;
 
 	if ((vmcs12->vm_exit_controls & VM_EXIT_LOAD_IA32_PAT) &&
@@ -3055,12 +3055,12 @@ static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
 	    CC(vmcs12->host_ss_selector == 0 && !ia32e))
 		return -EINVAL;
 
-	if (CC(is_noncanonical_address(vmcs12->host_fs_base, vcpu)) ||
-	    CC(is_noncanonical_address(vmcs12->host_gs_base, vcpu)) ||
-	    CC(is_noncanonical_address(vmcs12->host_gdtr_base, vcpu)) ||
-	    CC(is_noncanonical_address(vmcs12->host_idtr_base, vcpu)) ||
-	    CC(is_noncanonical_address(vmcs12->host_tr_base, vcpu)) ||
-	    CC(is_noncanonical_address(vmcs12->host_rip, vcpu)))
+	if (CC(is_noncanonical_base_address(vmcs12->host_fs_base, vcpu)) ||
+	    CC(is_noncanonical_base_address(vmcs12->host_gs_base, vcpu)) ||
+	    CC(is_noncanonical_base_address(vmcs12->host_gdtr_base, vcpu)) ||
+	    CC(is_noncanonical_base_address(vmcs12->host_idtr_base, vcpu)) ||
+	    CC(is_noncanonical_base_address(vmcs12->host_tr_base, vcpu)) ||
+	    CC(is_noncanonical_address(vmcs12->host_rip, vcpu, 0)))
 		return -EINVAL;
 
 	/*
@@ -3178,7 +3178,7 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 	}
 
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS) &&
-	    (CC(is_noncanonical_address(vmcs12->guest_bndcfgs & PAGE_MASK, vcpu)) ||
+	    (CC(is_noncanonical_msr_address(vmcs12->guest_bndcfgs & PAGE_MASK, vcpu)) ||
 	     CC((vmcs12->guest_bndcfgs & MSR_IA32_BNDCFGS_RSVD))))
 		return -EINVAL;
 
@@ -5172,7 +5172,7 @@ int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
 		 * non-canonical form. This is the only check on the memory
 		 * destination for long mode!
 		 */
-		exn = is_noncanonical_address(*ret, vcpu);
+		exn = is_noncanonical_address(*ret, vcpu, 0);
 	} else {
 		/*
 		 * When not in long mode, the virtual/linear address is
@@ -5983,7 +5983,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 		 * invalidation.
 		 */
 		if (!operand.vpid ||
-		    is_noncanonical_address(operand.gla, vcpu))
+		    is_noncanonical_invlpg_address(operand.gla, vcpu))
 			return nested_vmx_fail(vcpu,
 				VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
 		vpid_sync_vcpu_addr(vpid02, operand.gla);
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 83382a4d1d66..9c9d4a336166 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -365,7 +365,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		}
 		break;
 	case MSR_IA32_DS_AREA:
-		if (is_noncanonical_address(data, vcpu))
+		if (is_noncanonical_msr_address(data, vcpu))
 			return 1;
 
 		pmu->ds_area = data;
diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index a3c3d2a51f47..b352a3ba7354 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -4,12 +4,11 @@
 
 #include <asm/sgx.h>
 
-#include "cpuid.h"
+#include "x86.h"
 #include "kvm_cache_regs.h"
 #include "nested.h"
 #include "sgx.h"
 #include "vmx.h"
-#include "x86.h"
 
 bool __read_mostly enable_sgx = 1;
 module_param_named(sgx, enable_sgx, bool, 0444);
@@ -38,7 +37,7 @@ static int sgx_get_encls_gva(struct kvm_vcpu *vcpu, unsigned long offset,
 		fault = true;
 	} else if (likely(is_64_bit_mode(vcpu))) {
 		*gva = vmx_get_untagged_addr(vcpu, *gva, 0);
-		fault = is_noncanonical_address(*gva, vcpu);
+		fault = is_noncanonical_address(*gva, vcpu, 0);
 	} else {
 		*gva &= 0xffffffff;
 		fault = (s.unusable) ||
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 029fbf3791f1..9a4ebf3dfbfc 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2284,7 +2284,7 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    (!msr_info->host_initiated &&
 		     !guest_cpuid_has(vcpu, X86_FEATURE_MPX)))
 			return 1;
-		if (is_noncanonical_address(data & PAGE_MASK, vcpu) ||
+		if (is_noncanonical_msr_address(data & PAGE_MASK, vcpu) ||
 		    (data & MSR_IA32_BNDCFGS_RSVD))
 			return 1;
 
@@ -2449,7 +2449,7 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		index = msr_info->index - MSR_IA32_RTIT_ADDR0_A;
 		if (index >= 2 * vmx->pt_desc.num_address_ranges)
 			return 1;
-		if (is_noncanonical_address(data, vcpu))
+		if (is_noncanonical_msr_address(data, vcpu))
 			return 1;
 		if (index % 2)
 			vmx->pt_desc.guest.addr_b[index / 2] = data;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f378d479fea3..213af0fda768 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1845,7 +1845,7 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 	case MSR_KERNEL_GS_BASE:
 	case MSR_CSTAR:
 	case MSR_LSTAR:
-		if (is_noncanonical_address(data, vcpu))
+		if (is_noncanonical_msr_address(data, vcpu))
 			return 1;
 		break;
 	case MSR_IA32_SYSENTER_EIP:
@@ -1862,7 +1862,7 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 		 * value, and that something deterministic happens if the guest
 		 * invokes 64-bit SYSENTER.
 		 */
-		data = __canonical_address(data, vcpu_virt_addr_bits(vcpu));
+		data = __canonical_address(data, max_host_virt_addr_bits());
 		break;
 	case MSR_TSC_AUX:
 		if (!kvm_is_supported_user_return_msr(MSR_TSC_AUX))
@@ -8608,6 +8608,12 @@ static gva_t emulator_get_untagged_addr(struct x86_emulate_ctxt *ctxt,
 					       addr, flags);
 }
 
+static bool emulator_is_canonical_addr(struct x86_emulate_ctxt *ctxt,
+				       gva_t addr, unsigned int flags)
+{
+	return !is_noncanonical_address(addr, emul_to_vcpu(ctxt), flags);
+}
+
 static const struct x86_emulate_ops emulate_ops = {
 	.vm_bugged           = emulator_vm_bugged,
 	.read_gpr            = emulator_read_gpr,
@@ -8654,6 +8660,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.triple_fault        = emulator_triple_fault,
 	.set_xcr             = emulator_set_xcr,
 	.get_untagged_addr   = emulator_get_untagged_addr,
+	.is_canonical_addr   = emulator_is_canonical_addr,
 };
 
 static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
@@ -10959,7 +10966,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		wrmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
 
 	if (unlikely(vcpu->arch.switch_db_regs)) {
-		set_debugreg(0, 7);
+		set_debugreg(DR7_FIXED_1, 7);
 		set_debugreg(vcpu->arch.eff_db[0], 0);
 		set_debugreg(vcpu->arch.eff_db[1], 1);
 		set_debugreg(vcpu->arch.eff_db[2], 2);
@@ -10968,7 +10975,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
 			kvm_x86_call(set_dr6)(vcpu, vcpu->arch.dr6);
 	} else if (unlikely(hw_breakpoint_active())) {
-		set_debugreg(0, 7);
+		set_debugreg(DR7_FIXED_1, 7);
 	}
 
 	vcpu->arch.host_debugctl = get_debugctlmsr();
@@ -12888,11 +12895,11 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		mutex_unlock(&kvm->slots_lock);
 	}
 	kvm_unload_vcpu_mmus(kvm);
+	kvm_destroy_vcpus(kvm);
 	kvm_x86_call(vm_destroy)(kvm);
 	kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
 	kvm_pic_destroy(kvm);
 	kvm_ioapic_destroy(kvm);
-	kvm_destroy_vcpus(kvm);
 	kvfree(rcu_dereference_check(kvm->arch.apic_map, 1));
 	kfree(srcu_dereference_check(kvm->arch.pmu_event_filter, &kvm->srcu, 1));
 	kvm_mmu_uninit_vm(kvm);
@@ -13756,7 +13763,7 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
 		 * invalidation.
 		 */
 		if ((!pcid_enabled && (operand.pcid != 0)) ||
-		    is_noncanonical_address(operand.gla, vcpu)) {
+		    is_noncanonical_invlpg_address(operand.gla, vcpu)) {
 			kvm_inject_gp(vcpu, 0);
 			return 1;
 		}
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index a84c48ef5278..ec623d23d13d 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -8,6 +8,7 @@
 #include <asm/pvclock.h>
 #include "kvm_cache_regs.h"
 #include "kvm_emulate.h"
+#include "cpuid.h"
 
 struct kvm_caps {
 	/* control of guest tsc rate supported? */
@@ -233,9 +234,52 @@ static inline u8 vcpu_virt_addr_bits(struct kvm_vcpu *vcpu)
 	return kvm_is_cr4_bit_set(vcpu, X86_CR4_LA57) ? 57 : 48;
 }
 
-static inline bool is_noncanonical_address(u64 la, struct kvm_vcpu *vcpu)
+static inline u8 max_host_virt_addr_bits(void)
 {
-	return !__is_canonical_address(la, vcpu_virt_addr_bits(vcpu));
+	return kvm_cpu_cap_has(X86_FEATURE_LA57) ? 57 : 48;
+}
+
+/*
+ * x86 MSRs which contain linear addresses, x86 hidden segment bases, and
+ * IDT/GDT bases have static canonicality checks, the size of which depends
+ * only on the CPU's support for 5-level paging, rather than on the state of
+ * CR4.LA57.  This applies to both WRMSR and to other instructions that set
+ * their values, e.g. SGDT.
+ *
+ * KVM passes through most of these MSRS and also doesn't intercept the
+ * instructions that set the hidden segment bases.
+ *
+ * Because of this, to be consistent with hardware, even if the guest doesn't
+ * have LA57 enabled in its CPUID, perform canonicality checks based on *host*
+ * support for 5 level paging.
+ *
+ * Finally, instructions which are related to MMU invalidation of a given
+ * linear address, also have a similar static canonical check on address.
+ * This allows for example to invalidate 5-level addresses of a guest from a
+ * host which uses 4-level paging.
+ */
+static inline bool is_noncanonical_address(u64 la, struct kvm_vcpu *vcpu,
+					   unsigned int flags)
+{
+	if (flags & (X86EMUL_F_INVLPG | X86EMUL_F_MSR | X86EMUL_F_DT_LOAD))
+		return !__is_canonical_address(la, max_host_virt_addr_bits());
+	else
+		return !__is_canonical_address(la, vcpu_virt_addr_bits(vcpu));
+}
+
+static inline bool is_noncanonical_msr_address(u64 la, struct kvm_vcpu *vcpu)
+{
+	return is_noncanonical_address(la, vcpu, X86EMUL_F_MSR);
+}
+
+static inline bool is_noncanonical_base_address(u64 la, struct kvm_vcpu *vcpu)
+{
+	return is_noncanonical_address(la, vcpu, X86EMUL_F_DT_LOAD);
+}
+
+static inline bool is_noncanonical_invlpg_address(u64 la, struct kvm_vcpu *vcpu)
+{
+	return is_noncanonical_address(la, vcpu, X86EMUL_F_INVLPG);
 }
 
 static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 5962ea1230a1..de4e2f3db942 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1174,6 +1174,8 @@ struct regmap *__regmap_init(struct device *dev,
 err_map:
 	kfree(map);
 err:
+	if (bus && bus->free_on_exit)
+		kfree(bus);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(__regmap_init);
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 58d16ff166c2..4575d9a4e5ed 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -942,6 +942,7 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 	struct fsl_mc_obj_desc endpoint_desc = {{ 0 }};
 	struct dprc_endpoint endpoint1 = {{ 0 }};
 	struct dprc_endpoint endpoint2 = {{ 0 }};
+	struct fsl_mc_bus *mc_bus;
 	int state, err;
 
 	mc_bus_dev = to_fsl_mc_device(mc_dev->dev.parent);
@@ -965,6 +966,8 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 	strcpy(endpoint_desc.type, endpoint2.type);
 	endpoint_desc.id = endpoint2.id;
 	endpoint = fsl_mc_device_lookup(&endpoint_desc, mc_bus_dev);
+	if (endpoint)
+		return endpoint;
 
 	/*
 	 * We know that the device has an endpoint because we verified by
@@ -972,17 +975,13 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 	 * yet discovered by the fsl-mc bus, thus the lookup returned NULL.
 	 * Force a rescan of the devices in this container and retry the lookup.
 	 */
-	if (!endpoint) {
-		struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
-
-		if (mutex_trylock(&mc_bus->scan_mutex)) {
-			err = dprc_scan_objects(mc_bus_dev, true);
-			mutex_unlock(&mc_bus->scan_mutex);
-		}
-
-		if (err < 0)
-			return ERR_PTR(err);
+	mc_bus = to_fsl_mc_bus(mc_bus_dev);
+	if (mutex_trylock(&mc_bus->scan_mutex)) {
+		err = dprc_scan_objects(mc_bus_dev, true);
+		mutex_unlock(&mc_bus->scan_mutex);
 	}
+	if (err < 0)
+		return ERR_PTR(err);
 
 	endpoint = fsl_mc_device_lookup(&endpoint_desc, mc_bus_dev);
 	/*
diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index 05ae9122823f..e713ef611434 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -790,7 +790,7 @@ static void waveform_detach(struct comedi_device *dev)
 {
 	struct waveform_private *devpriv = dev->private;
 
-	if (devpriv) {
+	if (devpriv && dev->n_subdevices) {
 		del_timer_sync(&devpriv->ai_timer);
 		del_timer_sync(&devpriv->ao_timer);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 24e41b42c638..8cf224fd4ff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4954,6 +4954,8 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 		dev->dev->power.disable_depth--;
 #endif
 	}
+
+	amdgpu_vram_mgr_clear_reset_blocks(adev);
 	adev->in_suspend = false;
 
 	if (adev->enable_mes)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index b7742fa74e1d..3c883f1cf068 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -153,6 +153,7 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
 				  uint64_t start, uint64_t size);
 int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
 				      uint64_t start);
+void amdgpu_vram_mgr_clear_reset_blocks(struct amdgpu_device *adev);
 
 bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
 			    struct ttm_resource *res);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 8f58ec6f1400..732c79e201c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -782,6 +782,23 @@ uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_vram_mgr *mgr)
 	return atomic64_read(&mgr->vis_usage);
 }
 
+/**
+ * amdgpu_vram_mgr_clear_reset_blocks - reset clear blocks
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Reset the cleared drm buddy blocks.
+ */
+void amdgpu_vram_mgr_clear_reset_blocks(struct amdgpu_device *adev)
+{
+	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
+	struct drm_buddy *mm = &mgr->mm;
+
+	mutex_lock(&mgr->lock);
+	drm_buddy_reset_clear(mm, false);
+	mutex_unlock(&mgr->lock);
+}
+
 /**
  * amdgpu_vram_mgr_intersects - test each drm buddy block for intersection
  *
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 5500767cda7e..4d17d1e1c38b 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1352,7 +1352,7 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 			regmap_update_bits(pdata->regmap, SN_HPD_DISABLE_REG,
 					   HPD_DISABLE, 0);
 		mutex_unlock(&pdata->comms_mutex);
-	};
+	}
 
 	drm_bridge_add(&pdata->bridge);
 
diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index ca42e6081d27..16dea3f2fb11 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -400,6 +400,49 @@ drm_get_buddy(struct drm_buddy_block *block)
 }
 EXPORT_SYMBOL(drm_get_buddy);
 
+/**
+ * drm_buddy_reset_clear - reset blocks clear state
+ *
+ * @mm: DRM buddy manager
+ * @is_clear: blocks clear state
+ *
+ * Reset the clear state based on @is_clear value for each block
+ * in the freelist.
+ */
+void drm_buddy_reset_clear(struct drm_buddy *mm, bool is_clear)
+{
+	u64 root_size, size, start;
+	unsigned int order;
+	int i;
+
+	size = mm->size;
+	for (i = 0; i < mm->n_roots; ++i) {
+		order = ilog2(size) - ilog2(mm->chunk_size);
+		start = drm_buddy_block_offset(mm->roots[i]);
+		__force_merge(mm, start, start + size, order);
+
+		root_size = mm->chunk_size << order;
+		size -= root_size;
+	}
+
+	for (i = 0; i <= mm->max_order; ++i) {
+		struct drm_buddy_block *block;
+
+		list_for_each_entry_reverse(block, &mm->free_list[i], link) {
+			if (is_clear != drm_buddy_block_is_clear(block)) {
+				if (is_clear) {
+					mark_cleared(block);
+					mm->clear_avail += drm_buddy_block_size(mm, block);
+				} else {
+					clear_reset(block);
+					mm->clear_avail -= drm_buddy_block_size(mm, block);
+				}
+			}
+		}
+	}
+}
+EXPORT_SYMBOL(drm_buddy_reset_clear);
+
 /**
  * drm_buddy_free_block - free a block
  *
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index ca9e0c730013..af80f1ac8880 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1506,6 +1506,12 @@ int intel_dp_rate_select(struct intel_dp *intel_dp, int rate)
 void intel_dp_compute_rate(struct intel_dp *intel_dp, int port_clock,
 			   u8 *link_bw, u8 *rate_select)
 {
+	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
+
+	/* FIXME g4x can't generate an exact 2.7GHz with the 96MHz non-SSC refclk */
+	if (IS_G4X(i915) && port_clock == 268800)
+		port_clock = 270000;
+
 	/* eDP 1.4 rate select method. */
 	if (intel_dp->use_rate_select) {
 		*link_bw = 0;
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index c9c50e3b18a2..3e75fc1f6607 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -368,17 +368,6 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity)
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
@@ -389,7 +378,8 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
 	struct drm_sched_entity *entity =
 		container_of(cb, struct drm_sched_entity, cb);
 
-	drm_sched_entity_clear_dep(f, cb);
+	entity->dependency = NULL;
+	dma_fence_put(f);
 	drm_sched_wakeup(entity->rq->sched);
 }
 
@@ -442,13 +432,6 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
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
diff --git a/drivers/gpu/drm/xe/tests/xe_mocs.c b/drivers/gpu/drm/xe/tests/xe_mocs.c
index 61a7d20ce42b..bf3f97d0c9c7 100644
--- a/drivers/gpu/drm/xe/tests/xe_mocs.c
+++ b/drivers/gpu/drm/xe/tests/xe_mocs.c
@@ -43,14 +43,12 @@ static void read_l3cc_table(struct xe_gt *gt,
 {
 	struct kunit *test = kunit_get_current_test();
 	u32 l3cc, l3cc_expected;
-	unsigned int fw_ref, i;
+	unsigned int i;
 	u32 reg_val;
+	u32 ret;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL)) {
-		xe_force_wake_put(gt_to_fw(gt), fw_ref);
-		KUNIT_ASSERT_TRUE_MSG(test, true, "Forcewake Failed.\n");
-	}
+	ret = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	KUNIT_ASSERT_EQ_MSG(test, ret, 0, "Forcewake Failed.\n");
 
 	for (i = 0; i < info->num_mocs_regs; i++) {
 		if (!(i & 1)) {
@@ -74,7 +72,7 @@ static void read_l3cc_table(struct xe_gt *gt,
 		KUNIT_EXPECT_EQ_MSG(test, l3cc_expected, l3cc,
 				    "l3cc idx=%u has incorrect val.\n", i);
 	}
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 }
 
 static void read_mocs_table(struct xe_gt *gt,
@@ -82,14 +80,15 @@ static void read_mocs_table(struct xe_gt *gt,
 {
 	struct kunit *test = kunit_get_current_test();
 	u32 mocs, mocs_expected;
-	unsigned int fw_ref, i;
+	unsigned int i;
 	u32 reg_val;
+	u32 ret;
 
 	KUNIT_EXPECT_TRUE_MSG(test, info->unused_entries_index,
 			      "Unused entries index should have been defined\n");
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	KUNIT_ASSERT_NE_MSG(test, fw_ref, 0, "Forcewake Failed.\n");
+	ret = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	KUNIT_ASSERT_EQ_MSG(test, ret, 0, "Forcewake Failed.\n");
 
 	for (i = 0; i < info->num_mocs_regs; i++) {
 		if (regs_are_mcr(gt))
@@ -107,7 +106,7 @@ static void read_mocs_table(struct xe_gt *gt,
 				    "mocs reg 0x%x has incorrect val.\n", i);
 	}
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
 }
 
 static int mocs_kernel_test_run_device(struct xe_device *xe)
diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 8050938389b6..e412a70323cc 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -197,7 +197,6 @@ static void xe_devcoredump_deferred_snap_work(struct work_struct *work)
 	struct xe_devcoredump_snapshot *ss = container_of(work, typeof(*ss), work);
 	struct xe_devcoredump *coredump = container_of(ss, typeof(*coredump), snapshot);
 	struct xe_device *xe = coredump_to_xe(coredump);
-	unsigned int fw_ref;
 
 	/*
 	 * NB: Despite passing a GFP_ flags parameter here, more allocations are done
@@ -211,12 +210,11 @@ static void xe_devcoredump_deferred_snap_work(struct work_struct *work)
 	xe_pm_runtime_get(xe);
 
 	/* keep going if fw fails as we still want to save the memory and SW data */
-	fw_ref = xe_force_wake_get(gt_to_fw(ss->gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL))
+	if (xe_force_wake_get(gt_to_fw(ss->gt), XE_FORCEWAKE_ALL))
 		xe_gt_info(ss->gt, "failed to get forcewake for coredump capture\n");
 	xe_vm_snapshot_capture_delayed(ss->vm);
 	xe_guc_exec_queue_snapshot_capture_delayed(ss->ge);
-	xe_force_wake_put(gt_to_fw(ss->gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(ss->gt), XE_FORCEWAKE_ALL);
 
 	xe_pm_runtime_put(xe);
 
@@ -243,9 +241,8 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
 	u32 width_mask = (0x1 << q->width) - 1;
 	const char *process_name = "no process";
 
-	unsigned int fw_ref;
-	bool cookie;
 	int i;
+	bool cookie;
 
 	ss->snapshot_time = ktime_get_real();
 	ss->boot_time = ktime_get_boottime();
@@ -268,7 +265,8 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
 	}
 
 	/* keep going if fw fails as we still want to save the memory and SW data */
-	fw_ref = xe_force_wake_get(gt_to_fw(q->gt), XE_FORCEWAKE_ALL);
+	if (xe_force_wake_get(gt_to_fw(q->gt), XE_FORCEWAKE_ALL))
+		xe_gt_info(ss->gt, "failed to get forcewake for coredump capture\n");
 
 	ss->ct = xe_guc_ct_snapshot_capture(&guc->ct, true);
 	ss->ge = xe_guc_exec_queue_snapshot_capture(q);
@@ -286,7 +284,7 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
 
 	queue_work(system_unbound_wq, &ss->work);
 
-	xe_force_wake_put(gt_to_fw(q->gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(q->gt), XE_FORCEWAKE_ALL);
 	dma_fence_end_signalling(cookie);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_force_wake.h b/drivers/gpu/drm/xe/xe_force_wake.h
index 1608a55edc84..a2577672f4e3 100644
--- a/drivers/gpu/drm/xe/xe_force_wake.h
+++ b/drivers/gpu/drm/xe/xe_force_wake.h
@@ -46,20 +46,4 @@ xe_force_wake_assert_held(struct xe_force_wake *fw,
 	xe_gt_assert(fw->gt, fw->awake_domains & domain);
 }
 
-/**
- * xe_force_wake_ref_has_domain - verifies if the domains are in fw_ref
- * @fw_ref : the force_wake reference
- * @domain : forcewake domain to verify
- *
- * This function confirms whether the @fw_ref includes a reference to the
- * specified @domain.
- *
- * Return: true if domain is refcounted.
- */
-static inline bool
-xe_force_wake_ref_has_domain(unsigned int fw_ref, enum xe_force_wake_domains domain)
-{
-	return fw_ref & domain;
-}
-
 #endif
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 30ec13cb5b6d..3b53d46aad54 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -98,14 +98,14 @@ void xe_gt_sanitize(struct xe_gt *gt)
 
 static void xe_gt_enable_host_l2_vram(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	u32 reg;
+	int err;
 
 	if (!XE_WA(gt, 16023588340))
 		return;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (!fw_ref)
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (WARN_ON(err))
 		return;
 
 	if (!xe_gt_is_media_type(gt)) {
@@ -115,13 +115,13 @@ static void xe_gt_enable_host_l2_vram(struct xe_gt *gt)
 	}
 
 	xe_gt_mcr_multicast_write(gt, XEHPC_L3CLOS_MASK(3), 0xF);
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
 }
 
 static void xe_gt_disable_host_l2_vram(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	u32 reg;
+	int err;
 
 	if (!XE_WA(gt, 16023588340))
 		return;
@@ -129,15 +129,15 @@ static void xe_gt_disable_host_l2_vram(struct xe_gt *gt)
 	if (xe_gt_is_media_type(gt))
 		return;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (!fw_ref)
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (WARN_ON(err))
 		return;
 
 	reg = xe_gt_mcr_unicast_read_any(gt, XE2_GAMREQSTRM_CTRL);
 	reg &= ~CG_DIS_CNTLBUS;
 	xe_gt_mcr_multicast_write(gt, XE2_GAMREQSTRM_CTRL, reg);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
 }
 
 /**
@@ -407,14 +407,11 @@ static void dump_pat_on_error(struct xe_gt *gt)
 
 static int gt_fw_domain_init(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err, i;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (!fw_ref) {
-		err = -ETIMEDOUT;
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (err)
 		goto err_hw_fence_irq;
-	}
 
 	if (!xe_gt_is_media_type(gt)) {
 		err = xe_ggtt_init(gt_to_tile(gt)->mem.ggtt);
@@ -449,12 +446,14 @@ static int gt_fw_domain_init(struct xe_gt *gt)
 	 */
 	gt->info.gmdid = xe_mmio_read32(gt, GMD_ID);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	err = xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
+	XE_WARN_ON(err);
+
 	return 0;
 
 err_force_wake:
 	dump_pat_on_error(gt);
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
 err_hw_fence_irq:
 	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
 		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
@@ -464,14 +463,11 @@ static int gt_fw_domain_init(struct xe_gt *gt)
 
 static int all_fw_domain_init(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err, i;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL)) {
-		err = -ETIMEDOUT;
-		goto err_force_wake;
-	}
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (err)
+		goto err_hw_fence_irq;
 
 	xe_gt_mcr_set_implicit_defaults(gt);
 	xe_wa_process_gt(gt);
@@ -537,12 +533,14 @@ static int all_fw_domain_init(struct xe_gt *gt)
 	if (IS_SRIOV_PF(gt_to_xe(gt)))
 		xe_gt_sriov_pf_init_hw(gt);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	err = xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	XE_WARN_ON(err);
 
 	return 0;
 
 err_force_wake:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+err_hw_fence_irq:
 	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
 		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
 
@@ -555,12 +553,11 @@ static int all_fw_domain_init(struct xe_gt *gt)
  */
 int xe_gt_init_hwconfig(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (!fw_ref)
-		return -ETIMEDOUT;
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (err)
+		goto out;
 
 	xe_gt_mcr_init_early(gt);
 	xe_pat_init(gt);
@@ -578,7 +575,8 @@ int xe_gt_init_hwconfig(struct xe_gt *gt)
 	xe_gt_enable_host_l2_vram(gt);
 
 out_fw:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
+out:
 	return err;
 }
 
@@ -746,7 +744,6 @@ static int do_gt_restart(struct xe_gt *gt)
 
 static int gt_reset(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err;
 
 	if (xe_device_wedged(gt_to_xe(gt)))
@@ -767,11 +764,9 @@ static int gt_reset(struct xe_gt *gt)
 
 	xe_gt_sanitize(gt);
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL)) {
-		err = -ETIMEDOUT;
-		goto err_out;
-	}
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (err)
+		goto err_msg;
 
 	if (IS_SRIOV_PF(gt_to_xe(gt)))
 		xe_gt_sriov_pf_stop_prepare(gt);
@@ -792,7 +787,8 @@ static int gt_reset(struct xe_gt *gt)
 	if (err)
 		goto err_out;
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	err = xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	XE_WARN_ON(err);
 	xe_pm_runtime_put(gt_to_xe(gt));
 
 	xe_gt_info(gt, "reset done\n");
@@ -800,7 +796,8 @@ static int gt_reset(struct xe_gt *gt)
 	return 0;
 
 err_out:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
+err_msg:
 	XE_WARN_ON(xe_uc_start(&gt->uc));
 err_fail:
 	xe_gt_err(gt, "reset failed (%pe)\n", ERR_PTR(err));
@@ -832,25 +829,22 @@ void xe_gt_reset_async(struct xe_gt *gt)
 
 void xe_gt_suspend_prepare(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
-
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	XE_WARN_ON(xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 
 	xe_uc_suspend_prepare(&gt->uc);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 }
 
 int xe_gt_suspend(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err;
 
 	xe_gt_dbg(gt, "suspending\n");
 	xe_gt_sanitize(gt);
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL))
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (err)
 		goto err_msg;
 
 	err = xe_uc_suspend(&gt->uc);
@@ -861,15 +855,14 @@ int xe_gt_suspend(struct xe_gt *gt)
 
 	xe_gt_disable_host_l2_vram(gt);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 	xe_gt_dbg(gt, "suspended\n");
 
 	return 0;
 
-err_msg:
-	err = -ETIMEDOUT;
 err_force_wake:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
+err_msg:
 	xe_gt_err(gt, "suspend failed (%pe)\n", ERR_PTR(err));
 
 	return err;
@@ -877,11 +870,9 @@ int xe_gt_suspend(struct xe_gt *gt)
 
 void xe_gt_shutdown(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
-
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 	do_gt_reset(gt);
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 }
 
 /**
@@ -906,12 +897,11 @@ int xe_gt_sanitize_freq(struct xe_gt *gt)
 
 int xe_gt_resume(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err;
 
 	xe_gt_dbg(gt, "resuming\n");
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL))
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (err)
 		goto err_msg;
 
 	err = do_gt_restart(gt);
@@ -920,15 +910,14 @@ int xe_gt_resume(struct xe_gt *gt)
 
 	xe_gt_idle_enable_pg(gt);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 	xe_gt_dbg(gt, "resumed\n");
 
 	return 0;
 
-err_msg:
-	err = -ETIMEDOUT;
 err_force_wake:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
+err_msg:
 	xe_gt_err(gt, "resume failed (%pe)\n", ERR_PTR(err));
 
 	return err;
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 1f519e925f06..616e63fb2f15 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1810,7 +1810,6 @@ static struct bin_attribute chan_attr_ring_buffer = {
 		.name = "ring",
 		.mode = 0600,
 	},
-	.size = 2 * SZ_2M,
 	.mmap = hv_mmap_ring_buffer_wrapper,
 };
 static struct attribute *vmbus_chan_attrs[] = {
@@ -1866,6 +1865,7 @@ static umode_t vmbus_chan_bin_attr_is_visible(struct kobject *kobj,
 	/* Hide ring attribute if channel's ring_sysfs_visible is set to false */
 	if (attr ==  &chan_attr_ring_buffer && !channel->ring_sysfs_visible)
 		return 0;
+	attr->size = channel->ringbuffer_pagecount << PAGE_SHIFT;
 
 	return attr->attr.mode;
 }
diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index eb97abcb4cd3..592b754f48e9 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -452,8 +452,10 @@ static int qup_i2c_bus_active(struct qup_i2c_dev *qup, int len)
 		if (!(status & I2C_STATUS_BUS_ACTIVE))
 			break;
 
-		if (time_after(jiffies, timeout))
+		if (time_after(jiffies, timeout)) {
 			ret = -ETIMEDOUT;
+			break;
+		}
 
 		usleep_range(len, len * 2);
 	}
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 89ce8a62b37c..fbab82d457fb 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -607,7 +607,6 @@ static int tegra_i2c_wait_for_config_load(struct tegra_i2c_dev *i2c_dev)
 static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 {
 	u32 val, clk_divisor, clk_multiplier, tsu_thd, tlow, thigh, non_hs_mode;
-	acpi_handle handle = ACPI_HANDLE(i2c_dev->dev);
 	struct i2c_timings *t = &i2c_dev->timings;
 	int err;
 
@@ -619,11 +618,7 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 	 * emit a noisy warning on error, which won't stay unnoticed and
 	 * won't hose machine entirely.
 	 */
-	if (handle)
-		err = acpi_evaluate_object(handle, "_RST", NULL, NULL);
-	else
-		err = reset_control_reset(i2c_dev->rst);
-
+	err = device_reset(i2c_dev->dev);
 	WARN_ON_ONCE(err);
 
 	if (IS_DVC(i2c_dev))
@@ -1666,19 +1661,6 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_dev *i2c_dev)
 		i2c_dev->is_vi = true;
 }
 
-static int tegra_i2c_init_reset(struct tegra_i2c_dev *i2c_dev)
-{
-	if (ACPI_HANDLE(i2c_dev->dev))
-		return 0;
-
-	i2c_dev->rst = devm_reset_control_get_exclusive(i2c_dev->dev, "i2c");
-	if (IS_ERR(i2c_dev->rst))
-		return dev_err_probe(i2c_dev->dev, PTR_ERR(i2c_dev->rst),
-				      "failed to get reset control\n");
-
-	return 0;
-}
-
 static int tegra_i2c_init_clocks(struct tegra_i2c_dev *i2c_dev)
 {
 	int err;
@@ -1788,10 +1770,6 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 
 	tegra_i2c_parse_dt(i2c_dev);
 
-	err = tegra_i2c_init_reset(i2c_dev);
-	if (err)
-		return err;
-
 	err = tegra_i2c_init_clocks(i2c_dev);
 	if (err)
 		return err;
diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 2a351f961b89..c8c40ff9765d 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -116,15 +116,16 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
 	for (i = 0; i < num; i++) {
 		struct virtio_i2c_req *req = &reqs[i];
 
-		wait_for_completion(&req->completion);
-
-		if (!failed && req->in_hdr.status != VIRTIO_I2C_MSG_OK)
-			failed = true;
+		if (!failed) {
+			if (wait_for_completion_interruptible(&req->completion))
+				failed = true;
+			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
+				failed = true;
+			else
+				j++;
+		}
 
 		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
-
-		if (!failed)
-			j++;
 	}
 
 	return j;
diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index edd0c3a35ab7..202561cad401 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -308,7 +308,6 @@ static void ad7949_disable_reg(void *reg)
 
 static int ad7949_spi_probe(struct spi_device *spi)
 {
-	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
 	struct device *dev = &spi->dev;
 	const struct ad7949_adc_spec *spec;
 	struct ad7949_adc_chip *ad7949_adc;
@@ -337,11 +336,11 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	ad7949_adc->resolution = spec->resolution;
 
 	/* Set SPI bits per word */
-	if (spi_ctrl_mask & SPI_BPW_MASK(ad7949_adc->resolution)) {
+	if (spi_is_bpw_supported(spi, ad7949_adc->resolution)) {
 		spi->bits_per_word = ad7949_adc->resolution;
-	} else if (spi_ctrl_mask == SPI_BPW_MASK(16)) {
+	} else if (spi_is_bpw_supported(spi, 16)) {
 		spi->bits_per_word = 16;
-	} else if (spi_ctrl_mask == SPI_BPW_MASK(8)) {
+	} else if (spi_is_bpw_supported(spi, 8)) {
 		spi->bits_per_word = 8;
 	} else {
 		dev_err(dev, "unable to find common BPW with spi controller\n");
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 26c481d2998c..25901d91a613 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -102,8 +102,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 		ret_type = prox_state->scale_precision;
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = hid_sensor_convert_exponent(
-				prox_state->prox_attr.unit_expo);
+		*val = 0;
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -227,6 +226,11 @@ static int prox_parse_report(struct platform_device *pdev,
 	dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr.index,
 			st->prox_attr.report_id);
 
+	st->scale_precision = hid_sensor_format_scale(hsdev->usage,
+						      &st->prox_attr,
+						      &st->scale_pre_decml,
+						      &st->scale_post_decml);
+
 	return ret;
 }
 
diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index b7c078b7f7cf..a1291f475466 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -582,8 +582,8 @@ static int __ib_cache_gid_add(struct ib_device *ib_dev, u32 port,
 out_unlock:
 	mutex_unlock(&table->lock);
 	if (ret)
-		pr_warn("%s: unable to add gid %pI6 error=%d\n",
-			__func__, gid->raw, ret);
+		pr_warn_ratelimited("%s: unable to add gid %pI6 error=%d\n",
+				    __func__, gid->raw, ret);
 	return ret;
 }
 
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 9514f577995f..cd14017e7df6 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -488,7 +488,7 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
 	if (bdata->release_delay)
 		hrtimer_start(&bdata->release_timer,
 			      ms_to_ktime(bdata->release_delay),
-			      HRTIMER_MODE_REL_HARD);
+			      HRTIMER_MODE_REL);
 out:
 	return IRQ_HANDLED;
 }
@@ -633,7 +633,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 
 		bdata->release_delay = button->debounce_interval;
 		hrtimer_init(&bdata->release_timer,
-			     CLOCK_REALTIME, HRTIMER_MODE_REL_HARD);
+			     CLOCK_REALTIME, HRTIMER_MODE_REL);
 		bdata->release_timer.function = gpio_keys_irq_timer;
 
 		isr = gpio_keys_irq_isr;
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 167971f8e8be..fdb02a87e312 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -238,6 +238,7 @@ static struct qcom_icc_node xm_pcie3_1 = {
 	.id = SC7280_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
+	.num_links = 1,
 	.links = { SC7280_SLAVE_ANOC_PCIE_GEM_NOC },
 };
 
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index beafca6ba0df..275d34119acd 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2858,7 +2858,12 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	const struct nand_op_instr *instr = NULL;
 	unsigned int op_id = 0;
 	unsigned int len = 0;
-	int ret;
+	int ret, reg_base;
+
+	reg_base = NAND_READ_LOCATION_0;
+
+	if (nandc->props->qpic_v2)
+		reg_base = NAND_READ_LOCATION_LAST_CW_0;
 
 	ret = qcom_parse_instructions(chip, subop, &q_op);
 	if (ret)
@@ -2910,7 +2915,10 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	op_id = q_op.data_instr_idx;
 	len = nand_subop_get_data_len(subop, op_id);
 
-	nandc_set_read_loc(chip, 0, 0, 0, len, 1);
+	if (nandc->props->qpic_v2)
+		nandc_set_read_loc_last(chip, reg_base, 0, len, 1);
+	else
+		nandc_set_read_loc_first(chip, reg_base, 0, len, 1);
 
 	if (!nandc->props->qpic_v2) {
 		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 681643ab3780..63e4a495b137 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -147,13 +147,16 @@ void can_change_state(struct net_device *dev, struct can_frame *cf,
 EXPORT_SYMBOL_GPL(can_change_state);
 
 /* CAN device restart for bus-off recovery */
-static void can_restart(struct net_device *dev)
+static int can_restart(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 	struct sk_buff *skb;
 	struct can_frame *cf;
 	int err;
 
+	if (!priv->do_set_mode)
+		return -EOPNOTSUPP;
+
 	if (netif_carrier_ok(dev))
 		netdev_err(dev, "Attempt to restart for bus-off recovery, but carrier is OK?\n");
 
@@ -175,10 +178,14 @@ static void can_restart(struct net_device *dev)
 	if (err) {
 		netdev_err(dev, "Restart failed, error %pe\n", ERR_PTR(err));
 		netif_carrier_off(dev);
+
+		return err;
 	} else {
 		netdev_dbg(dev, "Restarted\n");
 		priv->can_stats.restarts++;
 	}
+
+	return 0;
 }
 
 static void can_restart_work(struct work_struct *work)
@@ -203,9 +210,8 @@ int can_restart_now(struct net_device *dev)
 		return -EBUSY;
 
 	cancel_delayed_work_sync(&priv->restart_work);
-	can_restart(dev);
 
-	return 0;
+	return can_restart(dev);
 }
 
 /* CAN bus-off
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 01aacdcda260..abe8dc051d94 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -285,6 +285,12 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (data[IFLA_CAN_RESTART_MS]) {
+		if (!priv->do_set_mode) {
+			NL_SET_ERR_MSG(extack,
+				       "Device doesn't support restart from Bus Off");
+			return -EOPNOTSUPP;
+		}
+
 		/* Do not allow changing restart delay while running */
 		if (dev->flags & IFF_UP)
 			return -EBUSY;
@@ -292,6 +298,12 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (data[IFLA_CAN_RESTART]) {
+		if (!priv->do_set_mode) {
+			NL_SET_ERR_MSG(extack,
+				       "Device doesn't support restart from Bus Off");
+			return -EOPNOTSUPP;
+		}
+
 		/* Do not allow a restart while not running */
 		if (!(dev->flags & IFF_UP))
 			return -EINVAL;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index efd0048acd3b..c744e10e6403 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4655,12 +4655,19 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
 		return PTR_ERR(dpmac_dev);
 	}
 
-	if (IS_ERR(dpmac_dev) || dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type)
+	if (IS_ERR(dpmac_dev))
 		return 0;
 
+	if (dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type) {
+		err = 0;
+		goto out_put_device;
+	}
+
 	mac = kzalloc(sizeof(struct dpaa2_mac), GFP_KERNEL);
-	if (!mac)
-		return -ENOMEM;
+	if (!mac) {
+		err = -ENOMEM;
+		goto out_put_device;
+	}
 
 	mac->mc_dev = dpmac_dev;
 	mac->mc_io = priv->mc_io;
@@ -4694,6 +4701,8 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
 	dpaa2_mac_close(mac);
 err_free_mac:
 	kfree(mac);
+out_put_device:
+	put_device(&dpmac_dev->dev);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index a293b08f36d4..cbd3859ea475 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1447,12 +1447,19 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 	if (PTR_ERR(dpmac_dev) == -EPROBE_DEFER)
 		return PTR_ERR(dpmac_dev);
 
-	if (IS_ERR(dpmac_dev) || dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type)
+	if (IS_ERR(dpmac_dev))
 		return 0;
 
+	if (dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type) {
+		err = 0;
+		goto out_put_device;
+	}
+
 	mac = kzalloc(sizeof(*mac), GFP_KERNEL);
-	if (!mac)
-		return -ENOMEM;
+	if (!mac) {
+		err = -ENOMEM;
+		goto out_put_device;
+	}
 
 	mac->mc_dev = dpmac_dev;
 	mac->mc_io = port_priv->ethsw_data->mc_io;
@@ -1482,6 +1489,8 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 	dpaa2_mac_close(mac);
 err_free_mac:
 	kfree(mac);
+out_put_device:
+	put_device(&dpmac_dev->dev);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 14f39d1f59d3..8ea3c7493663 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1972,49 +1972,56 @@ static void gve_turnup_and_check_status(struct gve_priv *priv)
 	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
 }
 
-static void gve_tx_timeout(struct net_device *dev, unsigned int txqueue)
+static struct gve_notify_block *gve_get_tx_notify_block(struct gve_priv *priv,
+							unsigned int txqueue)
 {
-	struct gve_notify_block *block;
-	struct gve_tx_ring *tx = NULL;
-	struct gve_priv *priv;
-	u32 last_nic_done;
-	u32 current_time;
 	u32 ntfy_idx;
 
-	netdev_info(dev, "Timeout on tx queue, %d", txqueue);
-	priv = netdev_priv(dev);
 	if (txqueue > priv->tx_cfg.num_queues)
-		goto reset;
+		return NULL;
 
 	ntfy_idx = gve_tx_idx_to_ntfy(priv, txqueue);
 	if (ntfy_idx >= priv->num_ntfy_blks)
-		goto reset;
+		return NULL;
+
+	return &priv->ntfy_blocks[ntfy_idx];
+}
+
+static bool gve_tx_timeout_try_q_kick(struct gve_priv *priv,
+				      unsigned int txqueue)
+{
+	struct gve_notify_block *block;
+	u32 current_time;
 
-	block = &priv->ntfy_blocks[ntfy_idx];
-	tx = block->tx;
+	block = gve_get_tx_notify_block(priv, txqueue);
+
+	if (!block)
+		return false;
 
 	current_time = jiffies_to_msecs(jiffies);
-	if (tx->last_kick_msec + MIN_TX_TIMEOUT_GAP > current_time)
-		goto reset;
+	if (block->tx->last_kick_msec + MIN_TX_TIMEOUT_GAP > current_time)
+		return false;
 
-	/* Check to see if there are missed completions, which will allow us to
-	 * kick the queue.
-	 */
-	last_nic_done = gve_tx_load_event_counter(priv, tx);
-	if (last_nic_done - tx->done) {
-		netdev_info(dev, "Kicking queue %d", txqueue);
-		iowrite32be(GVE_IRQ_MASK, gve_irq_doorbell(priv, block));
-		napi_schedule(&block->napi);
-		tx->last_kick_msec = current_time;
-		goto out;
-	} // Else reset.
+	netdev_info(priv->dev, "Kicking queue %d", txqueue);
+	napi_schedule(&block->napi);
+	block->tx->last_kick_msec = current_time;
+	return true;
+}
 
-reset:
-	gve_schedule_reset(priv);
+static void gve_tx_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	struct gve_notify_block *block;
+	struct gve_priv *priv;
 
-out:
-	if (tx)
-		tx->queue_timeout++;
+	netdev_info(dev, "Timeout on tx queue, %d", txqueue);
+	priv = netdev_priv(dev);
+
+	if (!gve_tx_timeout_try_q_kick(priv, txqueue))
+		gve_schedule_reset(priv);
+
+	block = gve_get_tx_notify_block(priv, txqueue);
+	if (block)
+		block->tx->queue_timeout++;
 	priv->tx_timeo_cnt++;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 24062a40a779..94432e237640 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -11,6 +11,7 @@
 #include <linux/irq.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/skbuff.h>
@@ -1039,6 +1040,8 @@ static bool hns3_can_use_tx_sgl(struct hns3_enet_ring *ring,
 static void hns3_init_tx_spare_buffer(struct hns3_enet_ring *ring)
 {
 	u32 alloc_size = ring->tqp->handle->kinfo.tx_spare_buf_size;
+	struct net_device *netdev = ring_to_netdev(ring);
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hns3_tx_spare *tx_spare;
 	struct page *page;
 	dma_addr_t dma;
@@ -1080,6 +1083,7 @@ static void hns3_init_tx_spare_buffer(struct hns3_enet_ring *ring)
 	tx_spare->buf = page_address(page);
 	tx_spare->len = PAGE_SIZE << order;
 	ring->tx_spare = tx_spare;
+	ring->tx_copybreak = priv->tx_copybreak;
 	return;
 
 dma_mapping_error:
@@ -4874,6 +4878,30 @@ static void hns3_nic_dealloc_vector_data(struct hns3_nic_priv *priv)
 	devm_kfree(&pdev->dev, priv->tqp_vector);
 }
 
+static void hns3_update_tx_spare_buf_config(struct hns3_nic_priv *priv)
+{
+#define HNS3_MIN_SPARE_BUF_SIZE (2 * 1024 * 1024)
+#define HNS3_MAX_PACKET_SIZE (64 * 1024)
+
+	struct iommu_domain *domain = iommu_get_domain_for_dev(priv->dev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(priv->ae_handle);
+	struct hnae3_handle *handle = priv->ae_handle;
+
+	if (ae_dev->dev_version < HNAE3_DEVICE_VERSION_V3)
+		return;
+
+	if (!(domain && iommu_is_dma_domain(domain)))
+		return;
+
+	priv->min_tx_copybreak = HNS3_MAX_PACKET_SIZE;
+	priv->min_tx_spare_buf_size = HNS3_MIN_SPARE_BUF_SIZE;
+
+	if (priv->tx_copybreak < priv->min_tx_copybreak)
+		priv->tx_copybreak = priv->min_tx_copybreak;
+	if (handle->kinfo.tx_spare_buf_size < priv->min_tx_spare_buf_size)
+		handle->kinfo.tx_spare_buf_size = priv->min_tx_spare_buf_size;
+}
+
 static void hns3_ring_get_cfg(struct hnae3_queue *q, struct hns3_nic_priv *priv,
 			      unsigned int ring_type)
 {
@@ -5107,6 +5135,7 @@ int hns3_init_all_ring(struct hns3_nic_priv *priv)
 	int i, j;
 	int ret;
 
+	hns3_update_tx_spare_buf_config(priv);
 	for (i = 0; i < ring_num; i++) {
 		ret = hns3_alloc_ring_memory(&priv->ring[i]);
 		if (ret) {
@@ -5311,6 +5340,8 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	priv->ae_handle = handle;
 	priv->tx_timeout_count = 0;
 	priv->max_non_tso_bd_num = ae_dev->dev_specs.max_non_tso_bd_num;
+	priv->min_tx_copybreak = 0;
+	priv->min_tx_spare_buf_size = 0;
 	set_bit(HNS3_NIC_STATE_DOWN, &priv->state);
 
 	handle->msg_enable = netif_msg_init(debug, DEFAULT_MSG_LEVEL);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index d36c4ed16d8d..caf7a4df8585 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -596,6 +596,8 @@ struct hns3_nic_priv {
 	struct hns3_enet_coalesce rx_coal;
 	u32 tx_copybreak;
 	u32 rx_copybreak;
+	u32 min_tx_copybreak;
+	u32 min_tx_spare_buf_size;
 };
 
 union l3_hdr_info {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 06eedf80cfac..407ad0b985b4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -9586,33 +9586,36 @@ static bool hclge_need_enable_vport_vlan_filter(struct hclge_vport *vport)
 	return false;
 }
 
-int hclge_enable_vport_vlan_filter(struct hclge_vport *vport, bool request_en)
+static int __hclge_enable_vport_vlan_filter(struct hclge_vport *vport,
+					    bool request_en)
 {
-	struct hclge_dev *hdev = vport->back;
 	bool need_en;
 	int ret;
 
-	mutex_lock(&hdev->vport_lock);
-
-	vport->req_vlan_fltr_en = request_en;
-
 	need_en = hclge_need_enable_vport_vlan_filter(vport);
-	if (need_en == vport->cur_vlan_fltr_en) {
-		mutex_unlock(&hdev->vport_lock);
+	if (need_en == vport->cur_vlan_fltr_en)
 		return 0;
-	}
 
 	ret = hclge_set_vport_vlan_filter(vport, need_en);
-	if (ret) {
-		mutex_unlock(&hdev->vport_lock);
+	if (ret)
 		return ret;
-	}
 
 	vport->cur_vlan_fltr_en = need_en;
 
+	return 0;
+}
+
+int hclge_enable_vport_vlan_filter(struct hclge_vport *vport, bool request_en)
+{
+	struct hclge_dev *hdev = vport->back;
+	int ret;
+
+	mutex_lock(&hdev->vport_lock);
+	vport->req_vlan_fltr_en = request_en;
+	ret = __hclge_enable_vport_vlan_filter(vport, request_en);
 	mutex_unlock(&hdev->vport_lock);
 
-	return 0;
+	return ret;
 }
 
 static int hclge_enable_vlan_filter(struct hnae3_handle *handle, bool enable)
@@ -10633,16 +10636,19 @@ static void hclge_sync_vlan_fltr_state(struct hclge_dev *hdev)
 					&vport->state))
 			continue;
 
-		ret = hclge_enable_vport_vlan_filter(vport,
-						     vport->req_vlan_fltr_en);
+		mutex_lock(&hdev->vport_lock);
+		ret = __hclge_enable_vport_vlan_filter(vport,
+						       vport->req_vlan_fltr_en);
 		if (ret) {
 			dev_err(&hdev->pdev->dev,
 				"failed to sync vlan filter state for vport%u, ret = %d\n",
 				vport->vport_id, ret);
 			set_bit(HCLGE_VPORT_STATE_VLAN_FLTR_CHANGE,
 				&vport->state);
+			mutex_unlock(&hdev->vport_lock);
 			return;
 		}
+		mutex_unlock(&hdev->vport_lock);
 	}
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index 0ffda5146bae..16ef5a584af3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -496,14 +496,14 @@ int hclge_ptp_init(struct hclge_dev *hdev)
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed to init freq, ret = %d\n", ret);
-		goto out;
+		goto out_clear_int;
 	}
 
 	ret = hclge_ptp_set_ts_mode(hdev, &hdev->ptp->ts_cfg);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed to init ts mode, ret = %d\n", ret);
-		goto out;
+		goto out_clear_int;
 	}
 
 	ktime_get_real_ts64(&ts);
@@ -511,7 +511,7 @@ int hclge_ptp_init(struct hclge_dev *hdev)
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed to init ts time, ret = %d\n", ret);
-		goto out;
+		goto out_clear_int;
 	}
 
 	set_bit(HCLGE_STATE_PTP_EN, &hdev->state);
@@ -519,6 +519,9 @@ int hclge_ptp_init(struct hclge_dev *hdev)
 
 	return 0;
 
+out_clear_int:
+	clear_bit(HCLGE_PTP_FLAG_EN, &hdev->ptp->flags);
+	hclge_ptp_int_en(hdev, false);
 out:
 	hclge_ptp_destroy_clock(hdev);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 8f5a85b97ac0..e8573358309c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -3096,11 +3096,7 @@ static void hclgevf_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 static u32 hclgevf_get_max_channels(struct hclgevf_dev *hdev)
 {
-	struct hnae3_handle *nic = &hdev->nic;
-	struct hnae3_knic_private_info *kinfo = &nic->kinfo;
-
-	return min_t(u32, hdev->rss_size_max,
-		     hdev->num_tqps / kinfo->tc_info.num_tc);
+	return min(hdev->rss_size_max, hdev->num_tqps);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index 8294a7c4f122..ba331899d186 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -638,6 +638,9 @@
 /* For checksumming, the sum of all words in the NVM should equal 0xBABA. */
 #define NVM_SUM                    0xBABA
 
+/* Uninitialized ("empty") checksum word value */
+#define NVM_CHECKSUM_UNINITIALIZED 0xFFFF
+
 /* PBA (printed board assembly) number words */
 #define NVM_PBA_OFFSET_0           8
 #define NVM_PBA_OFFSET_1           9
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 364378133526..df4e7d781cb1 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4274,6 +4274,8 @@ static s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
 			ret_val = e1000e_update_nvm_checksum(hw);
 			if (ret_val)
 				return ret_val;
+		} else if (hw->mac.type == e1000_pch_tgp) {
+			return 0;
 		}
 	}
 
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
index e609f4df86f4..16369e6d245a 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.c
+++ b/drivers/net/ethernet/intel/e1000e/nvm.c
@@ -558,6 +558,12 @@ s32 e1000e_validate_nvm_checksum_generic(struct e1000_hw *hw)
 		checksum += nvm_data;
 	}
 
+	if (hw->mac.type == e1000_pch_tgp &&
+	    nvm_data == NVM_CHECKSUM_UNINITIALIZED) {
+		e_dbg("Uninitialized NVM Checksum on TGP platform - ignoring\n");
+		return 0;
+	}
+
 	if (checksum != (u16)NVM_SUM) {
 		e_dbg("NVM Checksum Invalid\n");
 		return -E1000_ERR_NVM;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 625fa93fc18b..97f32a0c68d0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3137,10 +3137,10 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 		const u8 *addr = al->list[i].addr;
 
 		/* Allow to delete VF primary MAC only if it was not set
-		 * administratively by PF or if VF is trusted.
+		 * administratively by PF.
 		 */
 		if (ether_addr_equal(addr, vf->default_lan_addr.addr)) {
-			if (i40e_can_vf_change_mac(vf))
+			if (!vf->pf_set_mac)
 				was_unimac_deleted = true;
 			else
 				continue;
@@ -5006,7 +5006,7 @@ int i40e_get_vf_stats(struct net_device *netdev, int vf_id,
 	vf_stats->broadcast  = stats->rx_broadcast;
 	vf_stats->multicast  = stats->rx_multicast;
 	vf_stats->rx_dropped = stats->rx_discards + stats->rx_discards_other;
-	vf_stats->tx_dropped = stats->tx_discards;
+	vf_stats->tx_dropped = stats->tx_errors;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 272fd823a825..e4c8cd12a41d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -2277,6 +2277,8 @@ enum ice_ddp_state ice_copy_and_init_pkg(struct ice_hw *hw, const u8 *buf,
 		return ICE_DDP_PKG_ERR;
 
 	buf_copy = devm_kmemdup(ice_hw_to_dev(hw), buf, len, GFP_KERNEL);
+	if (!buf_copy)
+		return ICE_DDP_PKG_ERR;
 
 	state = ice_init_pkg(hw, buf_copy, len);
 	if (!ice_is_init_pkg_successful(state)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index e733b81e18a2..5bb4940da59d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1925,8 +1925,8 @@ static int cmd_exec(struct mlx5_core_dev *dev, void *in, int in_size, void *out,
 
 	err = mlx5_cmd_invoke(dev, inb, outb, out, out_size, callback, context,
 			      pages_queue, token, force_polling);
-	if (callback)
-		return err;
+	if (callback && !err)
+		return 0;
 
 	if (err > 0) /* Failed in FW, command didn't execute */
 		err = deliv_status_to_err(err);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 988df7047b01..558962423521 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1181,19 +1181,19 @@ static void esw_set_peer_miss_rule_source_port(struct mlx5_eswitch *esw,
 static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 				       struct mlx5_core_dev *peer_dev)
 {
+	struct mlx5_eswitch *peer_esw = peer_dev->priv.eswitch;
 	struct mlx5_flow_destination dest = {};
 	struct mlx5_flow_act flow_act = {0};
 	struct mlx5_flow_handle **flows;
-	/* total vports is the same for both e-switches */
-	int nvports = esw->total_vports;
 	struct mlx5_flow_handle *flow;
+	struct mlx5_vport *peer_vport;
 	struct mlx5_flow_spec *spec;
-	struct mlx5_vport *vport;
 	int err, pfindex;
 	unsigned long i;
 	void *misc;
 
-	if (!MLX5_VPORT_MANAGER(esw->dev) && !mlx5_core_is_ecpf_esw_manager(esw->dev))
+	if (!MLX5_VPORT_MANAGER(peer_dev) &&
+	    !mlx5_core_is_ecpf_esw_manager(peer_dev))
 		return 0;
 
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
@@ -1202,7 +1202,7 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 
 	peer_miss_rules_setup(esw, peer_dev, spec, &dest);
 
-	flows = kvcalloc(nvports, sizeof(*flows), GFP_KERNEL);
+	flows = kvcalloc(peer_esw->total_vports, sizeof(*flows), GFP_KERNEL);
 	if (!flows) {
 		err = -ENOMEM;
 		goto alloc_flows_err;
@@ -1212,10 +1212,10 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 	misc = MLX5_ADDR_OF(fte_match_param, spec->match_value,
 			    misc_parameters);
 
-	if (mlx5_core_is_ecpf_esw_manager(esw->dev)) {
-		vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_PF);
-		esw_set_peer_miss_rule_source_port(esw, peer_dev->priv.eswitch,
-						   spec, MLX5_VPORT_PF);
+	if (mlx5_core_is_ecpf_esw_manager(peer_dev)) {
+		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_PF);
+		esw_set_peer_miss_rule_source_port(esw, peer_esw, spec,
+						   MLX5_VPORT_PF);
 
 		flow = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(esw),
 					   spec, &flow_act, &dest, 1);
@@ -1223,11 +1223,11 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 			err = PTR_ERR(flow);
 			goto add_pf_flow_err;
 		}
-		flows[vport->index] = flow;
+		flows[peer_vport->index] = flow;
 	}
 
-	if (mlx5_ecpf_vport_exists(esw->dev)) {
-		vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_ECPF);
+	if (mlx5_ecpf_vport_exists(peer_dev)) {
+		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_ECPF);
 		MLX5_SET(fte_match_set_misc, misc, source_port, MLX5_VPORT_ECPF);
 		flow = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(esw),
 					   spec, &flow_act, &dest, 1);
@@ -1235,13 +1235,14 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 			err = PTR_ERR(flow);
 			goto add_ecpf_flow_err;
 		}
-		flows[vport->index] = flow;
+		flows[peer_vport->index] = flow;
 	}
 
-	mlx5_esw_for_each_vf_vport(esw, i, vport, mlx5_core_max_vfs(esw->dev)) {
+	mlx5_esw_for_each_vf_vport(peer_esw, i, peer_vport,
+				   mlx5_core_max_vfs(peer_dev)) {
 		esw_set_peer_miss_rule_source_port(esw,
-						   peer_dev->priv.eswitch,
-						   spec, vport->vport);
+						   peer_esw,
+						   spec, peer_vport->vport);
 
 		flow = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(esw),
 					   spec, &flow_act, &dest, 1);
@@ -1249,22 +1250,22 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 			err = PTR_ERR(flow);
 			goto add_vf_flow_err;
 		}
-		flows[vport->index] = flow;
+		flows[peer_vport->index] = flow;
 	}
 
-	if (mlx5_core_ec_sriov_enabled(esw->dev)) {
-		mlx5_esw_for_each_ec_vf_vport(esw, i, vport, mlx5_core_max_ec_vfs(esw->dev)) {
-			if (i >= mlx5_core_max_ec_vfs(peer_dev))
-				break;
-			esw_set_peer_miss_rule_source_port(esw, peer_dev->priv.eswitch,
-							   spec, vport->vport);
+	if (mlx5_core_ec_sriov_enabled(peer_dev)) {
+		mlx5_esw_for_each_ec_vf_vport(peer_esw, i, peer_vport,
+					      mlx5_core_max_ec_vfs(peer_dev)) {
+			esw_set_peer_miss_rule_source_port(esw, peer_esw,
+							   spec,
+							   peer_vport->vport);
 			flow = mlx5_add_flow_rules(esw->fdb_table.offloads.slow_fdb,
 						   spec, &flow_act, &dest, 1);
 			if (IS_ERR(flow)) {
 				err = PTR_ERR(flow);
 				goto add_ec_vf_flow_err;
 			}
-			flows[vport->index] = flow;
+			flows[peer_vport->index] = flow;
 		}
 	}
 
@@ -1281,25 +1282,27 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 	return 0;
 
 add_ec_vf_flow_err:
-	mlx5_esw_for_each_ec_vf_vport(esw, i, vport, mlx5_core_max_ec_vfs(esw->dev)) {
-		if (!flows[vport->index])
+	mlx5_esw_for_each_ec_vf_vport(peer_esw, i, peer_vport,
+				      mlx5_core_max_ec_vfs(peer_dev)) {
+		if (!flows[peer_vport->index])
 			continue;
-		mlx5_del_flow_rules(flows[vport->index]);
+		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 add_vf_flow_err:
-	mlx5_esw_for_each_vf_vport(esw, i, vport, mlx5_core_max_vfs(esw->dev)) {
-		if (!flows[vport->index])
+	mlx5_esw_for_each_vf_vport(peer_esw, i, peer_vport,
+				   mlx5_core_max_vfs(peer_dev)) {
+		if (!flows[peer_vport->index])
 			continue;
-		mlx5_del_flow_rules(flows[vport->index]);
+		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
-	if (mlx5_ecpf_vport_exists(esw->dev)) {
-		vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_ECPF);
-		mlx5_del_flow_rules(flows[vport->index]);
+	if (mlx5_ecpf_vport_exists(peer_dev)) {
+		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_ECPF);
+		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 add_ecpf_flow_err:
-	if (mlx5_core_is_ecpf_esw_manager(esw->dev)) {
-		vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_PF);
-		mlx5_del_flow_rules(flows[vport->index]);
+	if (mlx5_core_is_ecpf_esw_manager(peer_dev)) {
+		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_PF);
+		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 add_pf_flow_err:
 	esw_warn(esw->dev, "FDB: Failed to add peer miss flow rule err %d\n", err);
@@ -1312,37 +1315,34 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 static void esw_del_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 					struct mlx5_core_dev *peer_dev)
 {
+	struct mlx5_eswitch *peer_esw = peer_dev->priv.eswitch;
 	u16 peer_index = mlx5_get_dev_index(peer_dev);
 	struct mlx5_flow_handle **flows;
-	struct mlx5_vport *vport;
+	struct mlx5_vport *peer_vport;
 	unsigned long i;
 
 	flows = esw->fdb_table.offloads.peer_miss_rules[peer_index];
 	if (!flows)
 		return;
 
-	if (mlx5_core_ec_sriov_enabled(esw->dev)) {
-		mlx5_esw_for_each_ec_vf_vport(esw, i, vport, mlx5_core_max_ec_vfs(esw->dev)) {
-			/* The flow for a particular vport could be NULL if the other ECPF
-			 * has fewer or no VFs enabled
-			 */
-			if (!flows[vport->index])
-				continue;
-			mlx5_del_flow_rules(flows[vport->index]);
-		}
+	if (mlx5_core_ec_sriov_enabled(peer_dev)) {
+		mlx5_esw_for_each_ec_vf_vport(peer_esw, i, peer_vport,
+					      mlx5_core_max_ec_vfs(peer_dev))
+			mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 
-	mlx5_esw_for_each_vf_vport(esw, i, vport, mlx5_core_max_vfs(esw->dev))
-		mlx5_del_flow_rules(flows[vport->index]);
+	mlx5_esw_for_each_vf_vport(peer_esw, i, peer_vport,
+				   mlx5_core_max_vfs(peer_dev))
+		mlx5_del_flow_rules(flows[peer_vport->index]);
 
-	if (mlx5_ecpf_vport_exists(esw->dev)) {
-		vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_ECPF);
-		mlx5_del_flow_rules(flows[vport->index]);
+	if (mlx5_ecpf_vport_exists(peer_dev)) {
+		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_ECPF);
+		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 
-	if (mlx5_core_is_ecpf_esw_manager(esw->dev)) {
-		vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_PF);
-		mlx5_del_flow_rules(flows[vport->index]);
+	if (mlx5_core_is_ecpf_esw_manager(peer_dev)) {
+		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_PF);
+		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 
 	kvfree(flows);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index ddfd1c02a885..da53eb04b0a4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -288,8 +288,12 @@ static int prueth_fw_offload_buffer_setup(struct prueth_emac *emac)
 	int i;
 
 	addr = lower_32_bits(prueth->msmcram.pa);
-	if (slice)
-		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
+	if (slice) {
+		if (prueth->pdata.banked_ms_ram)
+			addr += MSMC_RAM_BANK_SIZE;
+		else
+			addr += PRUETH_SW_TOTAL_BUF_SIZE_PER_SLICE;
+	}
 
 	if (addr % SZ_64K) {
 		dev_warn(prueth->dev, "buffer pool needs to be 64KB aligned\n");
@@ -297,43 +301,66 @@ static int prueth_fw_offload_buffer_setup(struct prueth_emac *emac)
 	}
 
 	bpool_cfg = emac->dram.va + BUFFER_POOL_0_ADDR_OFFSET;
-	/* workaround for f/w bug. bpool 0 needs to be initialized */
-	for (i = 0; i <  PRUETH_NUM_BUF_POOLS; i++) {
+
+	/* Configure buffer pools for forwarding buffers
+	 * - used by firmware to store packets to be forwarded to other port
+	 * - 8 total pools per slice
+	 */
+	for (i = 0; i <  PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE; i++) {
 		writel(addr, &bpool_cfg[i].addr);
-		writel(PRUETH_EMAC_BUF_POOL_SIZE, &bpool_cfg[i].len);
-		addr += PRUETH_EMAC_BUF_POOL_SIZE;
+		writel(PRUETH_SW_FWD_BUF_POOL_SIZE, &bpool_cfg[i].len);
+		addr += PRUETH_SW_FWD_BUF_POOL_SIZE;
 	}
 
-	if (!slice)
-		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
-	else
-		addr += PRUETH_SW_NUM_BUF_POOLS_HOST * PRUETH_SW_BUF_POOL_SIZE_HOST;
-
-	for (i = PRUETH_NUM_BUF_POOLS;
-	     i < 2 * PRUETH_SW_NUM_BUF_POOLS_HOST + PRUETH_NUM_BUF_POOLS;
-	     i++) {
-		/* The driver only uses first 4 queues per PRU so only initialize them */
-		if (i % PRUETH_SW_NUM_BUF_POOLS_HOST < PRUETH_SW_NUM_BUF_POOLS_PER_PRU) {
-			writel(addr, &bpool_cfg[i].addr);
-			writel(PRUETH_SW_BUF_POOL_SIZE_HOST, &bpool_cfg[i].len);
-			addr += PRUETH_SW_BUF_POOL_SIZE_HOST;
+	/* Configure buffer pools for Local Injection buffers
+	 *  - used by firmware to store packets received from host core
+	 *  - 16 total pools per slice
+	 */
+	for (i = 0; i < PRUETH_NUM_LI_BUF_POOLS_PER_SLICE; i++) {
+		int cfg_idx = i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE;
+
+		/* The driver only uses first 4 queues per PRU,
+		 * so only initialize buffer for them
+		 */
+		if ((i % PRUETH_NUM_LI_BUF_POOLS_PER_PORT_PER_SLICE)
+			 < PRUETH_SW_USED_LI_BUF_POOLS_PER_PORT_PER_SLICE) {
+			writel(addr, &bpool_cfg[cfg_idx].addr);
+			writel(PRUETH_SW_LI_BUF_POOL_SIZE,
+			       &bpool_cfg[cfg_idx].len);
+			addr += PRUETH_SW_LI_BUF_POOL_SIZE;
 		} else {
-			writel(0, &bpool_cfg[i].addr);
-			writel(0, &bpool_cfg[i].len);
+			writel(0, &bpool_cfg[cfg_idx].addr);
+			writel(0, &bpool_cfg[cfg_idx].len);
 		}
 	}
 
-	if (!slice)
-		addr += PRUETH_SW_NUM_BUF_POOLS_HOST * PRUETH_SW_BUF_POOL_SIZE_HOST;
-	else
-		addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
+	/* Express RX buffer queue
+	 *  - used by firmware to store express packets to be transmitted
+	 *    to the host core
+	 */
+	rxq_ctx = emac->dram.va + HOST_RX_Q_EXP_CONTEXT_OFFSET;
+	for (i = 0; i < 3; i++)
+		writel(addr, &rxq_ctx->start[i]);
+
+	addr += PRUETH_SW_HOST_EXP_BUF_POOL_SIZE;
+	writel(addr, &rxq_ctx->end);
 
+	/* Pre-emptible RX buffer queue
+	 *  - used by firmware to store preemptible packets to be transmitted
+	 *    to the host core
+	 */
 	rxq_ctx = emac->dram.va + HOST_RX_Q_PRE_CONTEXT_OFFSET;
 	for (i = 0; i < 3; i++)
 		writel(addr, &rxq_ctx->start[i]);
 
-	addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
-	writel(addr - SZ_2K, &rxq_ctx->end);
+	addr += PRUETH_SW_HOST_PRE_BUF_POOL_SIZE;
+	writel(addr, &rxq_ctx->end);
+
+	/* Set pointer for default dropped packet write
+	 *  - used by firmware to temporarily store packet to be dropped
+	 */
+	rxq_ctx = emac->dram.va + DEFAULT_MSMC_Q_OFFSET;
+	writel(addr, &rxq_ctx->start[0]);
 
 	return 0;
 }
@@ -347,13 +374,13 @@ static int prueth_emac_buffer_setup(struct prueth_emac *emac)
 	u32 addr;
 	int i;
 
-	/* Layout to have 64KB aligned buffer pool
-	 * |BPOOL0|BPOOL1|RX_CTX0|RX_CTX1|
-	 */
-
 	addr = lower_32_bits(prueth->msmcram.pa);
-	if (slice)
-		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
+	if (slice) {
+		if (prueth->pdata.banked_ms_ram)
+			addr += MSMC_RAM_BANK_SIZE;
+		else
+			addr += PRUETH_EMAC_TOTAL_BUF_SIZE_PER_SLICE;
+	}
 
 	if (addr % SZ_64K) {
 		dev_warn(prueth->dev, "buffer pool needs to be 64KB aligned\n");
@@ -361,39 +388,66 @@ static int prueth_emac_buffer_setup(struct prueth_emac *emac)
 	}
 
 	bpool_cfg = emac->dram.va + BUFFER_POOL_0_ADDR_OFFSET;
-	/* workaround for f/w bug. bpool 0 needs to be initilalized */
-	writel(addr, &bpool_cfg[0].addr);
-	writel(0, &bpool_cfg[0].len);
 
-	for (i = PRUETH_EMAC_BUF_POOL_START;
-	     i < PRUETH_EMAC_BUF_POOL_START + PRUETH_NUM_BUF_POOLS;
-	     i++) {
-		writel(addr, &bpool_cfg[i].addr);
-		writel(PRUETH_EMAC_BUF_POOL_SIZE, &bpool_cfg[i].len);
-		addr += PRUETH_EMAC_BUF_POOL_SIZE;
+	/* Configure buffer pools for forwarding buffers
+	 *  - in mac mode - no forwarding so initialize all pools to 0
+	 *  - 8 total pools per slice
+	 */
+	for (i = 0; i <  PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE; i++) {
+		writel(0, &bpool_cfg[i].addr);
+		writel(0, &bpool_cfg[i].len);
 	}
 
-	if (!slice)
-		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
-	else
-		addr += PRUETH_EMAC_RX_CTX_BUF_SIZE * 2;
+	/* Configure buffer pools for Local Injection buffers
+	 *  - used by firmware to store packets received from host core
+	 *  - 16 total pools per slice
+	 */
+	bpool_cfg = emac->dram.va + BUFFER_POOL_0_ADDR_OFFSET;
+	for (i = 0; i < PRUETH_NUM_LI_BUF_POOLS_PER_SLICE; i++) {
+		int cfg_idx = i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE;
+
+		/* In EMAC mode, only first 4 buffers are used,
+		 * as 1 slice needs to handle only 1 port
+		 */
+		if (i < PRUETH_EMAC_USED_LI_BUF_POOLS_PER_PORT_PER_SLICE) {
+			writel(addr, &bpool_cfg[cfg_idx].addr);
+			writel(PRUETH_EMAC_LI_BUF_POOL_SIZE,
+			       &bpool_cfg[cfg_idx].len);
+			addr += PRUETH_EMAC_LI_BUF_POOL_SIZE;
+		} else {
+			writel(0, &bpool_cfg[cfg_idx].addr);
+			writel(0, &bpool_cfg[cfg_idx].len);
+		}
+	}
 
-	/* Pre-emptible RX buffer queue */
-	rxq_ctx = emac->dram.va + HOST_RX_Q_PRE_CONTEXT_OFFSET;
+	/* Express RX buffer queue
+	 *  - used by firmware to store express packets to be transmitted
+	 *    to host core
+	 */
+	rxq_ctx = emac->dram.va + HOST_RX_Q_EXP_CONTEXT_OFFSET;
 	for (i = 0; i < 3; i++)
 		writel(addr, &rxq_ctx->start[i]);
 
-	addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
+	addr += PRUETH_EMAC_HOST_EXP_BUF_POOL_SIZE;
 	writel(addr, &rxq_ctx->end);
 
-	/* Express RX buffer queue */
-	rxq_ctx = emac->dram.va + HOST_RX_Q_EXP_CONTEXT_OFFSET;
+	/* Pre-emptible RX buffer queue
+	 *  - used by firmware to store preemptible packets to be transmitted
+	 *    to host core
+	 */
+	rxq_ctx = emac->dram.va + HOST_RX_Q_PRE_CONTEXT_OFFSET;
 	for (i = 0; i < 3; i++)
 		writel(addr, &rxq_ctx->start[i]);
 
-	addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
+	addr += PRUETH_EMAC_HOST_PRE_BUF_POOL_SIZE;
 	writel(addr, &rxq_ctx->end);
 
+	/* Set pointer for default dropped packet write
+	 *  - used by firmware to temporarily store packet to be dropped
+	 */
+	rxq_ctx = emac->dram.va + DEFAULT_MSMC_Q_OFFSET;
+	writel(addr, &rxq_ctx->start[0]);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index c884e9fa099e..60d69744ffae 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -26,21 +26,71 @@ struct icssg_flow_cfg {
 #define PRUETH_MAX_RX_FLOWS	1	/* excluding default flow */
 #define PRUETH_RX_FLOW_DATA	0
 
-#define PRUETH_EMAC_BUF_POOL_SIZE	SZ_8K
-#define PRUETH_EMAC_POOLS_PER_SLICE	24
-#define PRUETH_EMAC_BUF_POOL_START	8
-#define PRUETH_NUM_BUF_POOLS	8
-#define PRUETH_EMAC_RX_CTX_BUF_SIZE	SZ_16K	/* per slice */
-#define MSMC_RAM_SIZE	\
-	(2 * (PRUETH_EMAC_BUF_POOL_SIZE * PRUETH_NUM_BUF_POOLS + \
-	 PRUETH_EMAC_RX_CTX_BUF_SIZE * 2))
-
-#define PRUETH_SW_BUF_POOL_SIZE_HOST	SZ_4K
-#define PRUETH_SW_NUM_BUF_POOLS_HOST	8
-#define PRUETH_SW_NUM_BUF_POOLS_PER_PRU 4
-#define MSMC_RAM_SIZE_SWITCH_MODE \
-	(MSMC_RAM_SIZE + \
-	(2 * PRUETH_SW_BUF_POOL_SIZE_HOST * PRUETH_SW_NUM_BUF_POOLS_HOST))
+/* Defines for forwarding path buffer pools:
+ *   - used by firmware to store packets to be forwarded to other port
+ *   - 8 total pools per slice
+ *   - only used in switch mode (as no forwarding in mac mode)
+ */
+#define PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE			8
+#define PRUETH_SW_FWD_BUF_POOL_SIZE				(SZ_8K)
+
+/* Defines for local injection path buffer pools:
+ *   - used by firmware to store packets received from host core
+ *   - 16 total pools per slice
+ *   - 8 pools per port per slice and each slice handles both ports
+ *   - only 4 out of 8 pools used per port (as only 4 real QoS levels in ICSSG)
+ *   - switch mode: 8 total pools used
+ *   - mac mode:    4 total pools used
+ */
+#define PRUETH_NUM_LI_BUF_POOLS_PER_SLICE			16
+#define PRUETH_NUM_LI_BUF_POOLS_PER_PORT_PER_SLICE		8
+#define PRUETH_SW_LI_BUF_POOL_SIZE				SZ_4K
+#define PRUETH_SW_USED_LI_BUF_POOLS_PER_SLICE			8
+#define PRUETH_SW_USED_LI_BUF_POOLS_PER_PORT_PER_SLICE		4
+#define PRUETH_EMAC_LI_BUF_POOL_SIZE				SZ_8K
+#define PRUETH_EMAC_USED_LI_BUF_POOLS_PER_SLICE			4
+#define PRUETH_EMAC_USED_LI_BUF_POOLS_PER_PORT_PER_SLICE	4
+
+/* Defines for host egress path - express and preemptible buffers
+ *   - used by firmware to store express and preemptible packets
+ *     to be transmitted to host core
+ *   - used by both mac/switch modes
+ */
+#define PRUETH_SW_HOST_EXP_BUF_POOL_SIZE	SZ_16K
+#define PRUETH_SW_HOST_PRE_BUF_POOL_SIZE	(SZ_16K - SZ_2K)
+#define PRUETH_EMAC_HOST_EXP_BUF_POOL_SIZE	PRUETH_SW_HOST_EXP_BUF_POOL_SIZE
+#define PRUETH_EMAC_HOST_PRE_BUF_POOL_SIZE	PRUETH_SW_HOST_PRE_BUF_POOL_SIZE
+
+/* Buffer used by firmware to temporarily store packet to be dropped */
+#define PRUETH_SW_DROP_PKT_BUF_SIZE		SZ_2K
+#define PRUETH_EMAC_DROP_PKT_BUF_SIZE		PRUETH_SW_DROP_PKT_BUF_SIZE
+
+/* Total switch mode memory usage for buffers per slice */
+#define PRUETH_SW_TOTAL_BUF_SIZE_PER_SLICE \
+	(PRUETH_SW_FWD_BUF_POOL_SIZE * PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE + \
+	 PRUETH_SW_LI_BUF_POOL_SIZE * PRUETH_SW_USED_LI_BUF_POOLS_PER_SLICE + \
+	 PRUETH_SW_HOST_EXP_BUF_POOL_SIZE + \
+	 PRUETH_SW_HOST_PRE_BUF_POOL_SIZE + \
+	 PRUETH_SW_DROP_PKT_BUF_SIZE)
+
+/* Total switch mode memory usage for all buffers */
+#define PRUETH_SW_TOTAL_BUF_SIZE \
+	(2 * PRUETH_SW_TOTAL_BUF_SIZE_PER_SLICE)
+
+/* Total mac mode memory usage for buffers per slice */
+#define PRUETH_EMAC_TOTAL_BUF_SIZE_PER_SLICE \
+	(PRUETH_EMAC_LI_BUF_POOL_SIZE * \
+	 PRUETH_EMAC_USED_LI_BUF_POOLS_PER_SLICE + \
+	 PRUETH_EMAC_HOST_EXP_BUF_POOL_SIZE + \
+	 PRUETH_EMAC_HOST_PRE_BUF_POOL_SIZE + \
+	 PRUETH_EMAC_DROP_PKT_BUF_SIZE)
+
+/* Total mac mode memory usage for all buffers */
+#define PRUETH_EMAC_TOTAL_BUF_SIZE \
+	(2 * PRUETH_EMAC_TOTAL_BUF_SIZE_PER_SLICE)
+
+/* Size of 1 bank of MSMC/OC_SRAM memory */
+#define MSMC_RAM_BANK_SIZE			SZ_256K
 
 #define PRUETH_SWITCH_FDB_MASK ((SIZE_OF_FDB / NUMBER_OF_FDB_BUCKET_ENTRIES) - 1)
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 6f0700d156e7..0769e1ade30b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1510,10 +1510,15 @@ static int prueth_probe(struct platform_device *pdev)
 		goto put_mem;
 	}
 
-	msmc_ram_size = MSMC_RAM_SIZE;
 	prueth->is_switchmode_supported = prueth->pdata.switch_mode;
-	if (prueth->is_switchmode_supported)
-		msmc_ram_size = MSMC_RAM_SIZE_SWITCH_MODE;
+	if (prueth->pdata.banked_ms_ram) {
+		/* Reserve 2 MSMC RAM banks for buffers to avoid arbitration */
+		msmc_ram_size = (2 * MSMC_RAM_BANK_SIZE);
+	} else {
+		msmc_ram_size = PRUETH_EMAC_TOTAL_BUF_SIZE;
+		if (prueth->is_switchmode_supported)
+			msmc_ram_size = PRUETH_SW_TOTAL_BUF_SIZE;
+	}
 
 	/* NOTE: FW bug needs buffer base to be 64KB aligned */
 	prueth->msmcram.va =
@@ -1670,7 +1675,8 @@ static int prueth_probe(struct platform_device *pdev)
 
 free_pool:
 	gen_pool_free(prueth->sram_pool,
-		      (unsigned long)prueth->msmcram.va, msmc_ram_size);
+		      (unsigned long)prueth->msmcram.va,
+		      prueth->msmcram.size);
 
 put_mem:
 	pruss_release_mem_region(prueth->pruss, &prueth->shram);
@@ -1722,8 +1728,8 @@ static void prueth_remove(struct platform_device *pdev)
 	icss_iep_put(prueth->iep0);
 
 	gen_pool_free(prueth->sram_pool,
-		      (unsigned long)prueth->msmcram.va,
-		      MSMC_RAM_SIZE);
+		(unsigned long)prueth->msmcram.va,
+		prueth->msmcram.size);
 
 	pruss_release_mem_region(prueth->pruss, &prueth->shram);
 
@@ -1740,12 +1746,14 @@ static const struct prueth_pdata am654_icssg_pdata = {
 	.fdqring_mode = K3_RINGACC_RING_MODE_MESSAGE,
 	.quirk_10m_link_issue = 1,
 	.switch_mode = 1,
+	.banked_ms_ram = 0,
 };
 
 static const struct prueth_pdata am64x_icssg_pdata = {
 	.fdqring_mode = K3_RINGACC_RING_MODE_RING,
 	.quirk_10m_link_issue = 1,
 	.switch_mode = 1,
+	.banked_ms_ram = 1,
 };
 
 static const struct of_device_id prueth_dt_match[] = {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index e456a11c5d4e..693c8731c094 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -207,11 +207,13 @@ struct prueth_emac {
  * @fdqring_mode: Free desc queue mode
  * @quirk_10m_link_issue: 10M link detect errata
  * @switch_mode: switch firmware support
+ * @banked_ms_ram: banked memory support
  */
 struct prueth_pdata {
 	enum k3_ring_mode fdqring_mode;
 	u32	quirk_10m_link_issue:1;
 	u32	switch_mode:1;
+	u32	banked_ms_ram:1;
 };
 
 struct icssg_firmwares {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
index 424a7e945ea8..12541a12ebd6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -180,6 +180,9 @@
 /* Used to notify the FW of the current link speed */
 #define PORT_LINK_SPEED_OFFSET                             0x00A8
 
+/* 2k memory pointer reserved for default writes by PRU0*/
+#define DEFAULT_MSMC_Q_OFFSET                              0x00AC
+
 /* TAS gate mask for windows list0 */
 #define TAS_GATE_MASK_LIST0                                0x0100
 
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0408c21bb122..fb3908798458 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3275,6 +3275,12 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 {
 	int qindex, err;
 
+	if (ring_num <= MAX_SKB_FRAGS + 2) {
+		netdev_err(vi->dev, "tx size (%d) cannot be smaller than %d\n",
+			   ring_num, MAX_SKB_FRAGS + 2);
+		return -EINVAL;
+	}
+
 	qindex = sq - vi->sq;
 
 	virtnet_tx_pause(vi, sq);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index ca5f1dc05815..a635b223dab1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1155,7 +1155,12 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
-		mt792x_mac_link_bss_remove(dev, mconf, mlink);
+
+		if (ieee80211_vif_is_mld(vif))
+			mt792x_mac_link_bss_remove(dev, mconf, mlink);
+		else
+			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
+						link_sta, false);
 	}
 
 	spin_lock_bh(&mdev->sta_poll_lock);
@@ -1175,6 +1180,31 @@ mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 	struct mt76_wcid *wcid;
 	unsigned int link_id;
 
+	/* clean up bss before starec */
+	for_each_set_bit(link_id, &old_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_sta *link_sta;
+		struct ieee80211_bss_conf *link_conf;
+		struct mt792x_bss_conf *mconf;
+		struct mt792x_link_sta *mlink;
+
+		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
+		if (!link_sta)
+			continue;
+
+		mlink = mt792x_sta_to_link(msta, link_id);
+		if (!mlink)
+			continue;
+
+		link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+		if (!link_conf)
+			continue;
+
+		mconf = mt792x_link_conf_to_mconf(link_conf);
+
+		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
+					link_sta, false);
+	}
+
 	for_each_set_bit(link_id, &old_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_link_sta *link_sta;
 		struct mt792x_link_sta *mlink;
@@ -1213,44 +1243,14 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
-	struct {
-		struct {
-			u8 omac_idx;
-			u8 band_idx;
-			__le16 pad;
-		} __packed hdr;
-		struct req_tlv {
-			__le16 tag;
-			__le16 len;
-			u8 active;
-			u8 link_idx; /* hw link idx */
-			u8 omac_addr[ETH_ALEN];
-		} __packed tlv;
-	} dev_req = {
-		.hdr = {
-			.omac_idx = 0,
-			.band_idx = 0,
-		},
-		.tlv = {
-			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
-			.len = cpu_to_le16(sizeof(struct req_tlv)),
-			.active = true,
-		},
-	};
 	unsigned long rem;
 
 	rem = ieee80211_vif_is_mld(vif) ? msta->valid_links : BIT(0);
 
 	mt7925_mac_sta_remove_links(dev, vif, sta, rem);
 
-	if (ieee80211_vif_is_mld(vif)) {
-		mt7925_mcu_set_dbdc(&dev->mphy, false);
-
-		/* recovery omac address for the legacy interface */
-		memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
-		mt76_mcu_send_msg(mdev, MCU_UNI_CMD(DEV_INFO_UPDATE),
-				  &dev_req, sizeof(dev_req), true);
-	}
+	if (ieee80211_vif_is_mld(vif))
+		mt7925_mcu_del_dev(mdev, vif);
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
@@ -1296,22 +1296,22 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, ssn,
 				   params->buf_size);
-		mt7925_mcu_uni_rx_ba(dev, vif, params, true);
+		mt7925_mcu_uni_rx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
-		mt7925_mcu_uni_rx_ba(dev, vif, params, false);
+		mt7925_mcu_uni_rx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		mtxq->aggr = true;
 		mtxq->send_bar = false;
-		mt7925_mcu_uni_tx_ba(dev, vif, params, true);
+		mt7925_mcu_uni_tx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, vif, params, false);
+		mt7925_mcu_uni_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		set_bit(tid, &msta->deflink.wcid.ampdu_state);
@@ -1320,7 +1320,7 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, vif, params, false);
+		mt7925_mcu_uni_tx_ba(dev, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 2aeb9ba4256a..e42b4f0abbe7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -529,10 +529,10 @@ void mt7925_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb)
 
 static int
 mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
-		  struct mt76_wcid *wcid,
 		  struct ieee80211_ampdu_params *params,
 		  bool enable, bool tx)
 {
+	struct mt76_wcid *wcid = (struct mt76_wcid *)params->sta->drv_priv;
 	struct sta_rec_ba_uni *ba;
 	struct sk_buff *skb;
 	struct tlv *tlv;
@@ -560,60 +560,28 @@ mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 
 /** starec & wtbl **/
 int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
-			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_link_sta *mlink;
-	struct mt792x_bss_conf *mconf;
-	unsigned long usable_links = ieee80211_vif_usable_links(vif);
-	struct mt76_wcid *wcid;
-	u8 link_id, ret;
-
-	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		mconf = mt792x_vif_to_link(mvif, link_id);
-		mlink = mt792x_sta_to_link(msta, link_id);
-		wcid = &mlink->wcid;
-
-		if (enable && !params->amsdu)
-			mlink->wcid.amsdu = false;
+	struct mt792x_vif *mvif = msta->vif;
 
-		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
-					enable, true);
-		if (ret < 0)
-			break;
-	}
+	if (enable && !params->amsdu)
+		msta->deflink.wcid.amsdu = false;
 
-	return ret;
+	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
+				 enable, true);
 }
 
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
-			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_link_sta *mlink;
-	struct mt792x_bss_conf *mconf;
-	unsigned long usable_links = ieee80211_vif_usable_links(vif);
-	struct mt76_wcid *wcid;
-	u8 link_id, ret;
-
-	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		mconf = mt792x_vif_to_link(mvif, link_id);
-		mlink = mt792x_sta_to_link(msta, link_id);
-		wcid = &mlink->wcid;
-
-		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
-					enable, false);
-		if (ret < 0)
-			break;
-	}
+	struct mt792x_vif *mvif = msta->vif;
 
-	return ret;
+	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
+				 enable, false);
 }
 
 static int mt7925_mcu_read_eeprom(struct mt792x_dev *dev, u32 offset, u8 *val)
@@ -2694,6 +2662,62 @@ int mt7925_mcu_set_timing(struct mt792x_phy *phy,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
 }
 
+void mt7925_mcu_del_dev(struct mt76_dev *mdev,
+			struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 omac_idx;
+			u8 band_idx;
+			__le16 pad;
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 link_idx; /* hw link idx */
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} dev_req = {
+		.tlv = {
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = true,
+		},
+	};
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_bss_basic_tlv basic;
+	} basic_req = {
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_bss_basic_tlv)),
+			.active = true,
+			.conn_state = 1,
+		},
+	};
+
+	dev_req.hdr.omac_idx = mvif->bss_conf.mt76.omac_idx;
+	dev_req.hdr.band_idx = mvif->bss_conf.mt76.band_idx;
+
+	basic_req.hdr.bss_idx = mvif->bss_conf.mt76.idx;
+	basic_req.basic.omac_idx = mvif->bss_conf.mt76.omac_idx;
+	basic_req.basic.band_idx = mvif->bss_conf.mt76.band_idx;
+	basic_req.basic.link_idx = mvif->bss_conf.mt76.link_idx;
+
+	mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE),
+			  &basic_req, sizeof(basic_req), true);
+
+	/* recovery omac address for the legacy interface */
+	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
+	mt76_mcu_send_msg(mdev, MCU_UNI_CMD(DEV_INFO_UPDATE),
+			  &dev_req, sizeof(dev_req), true);
+}
+
 int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_chanctx_conf *ctx,
 			    struct ieee80211_bss_conf *link_conf,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 780c5921679a..ee89d5778adf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -627,6 +627,8 @@ int mt7925_mcu_sched_scan_req(struct mt76_phy *phy,
 int mt7925_mcu_sched_scan_enable(struct mt76_phy *phy,
 				 struct ieee80211_vif *vif,
 				 bool enable);
+void mt7925_mcu_del_dev(struct mt76_dev *mdev,
+			struct ieee80211_vif *vif);
 int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_chanctx_conf *ctx,
 			    struct ieee80211_bss_conf *link_conf,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 4ad779329b8f..c83b8a210498 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -245,11 +245,9 @@ int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
 				 struct ieee80211_vif *vif,
 				 bool enable);
 int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
-			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
-			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 void mt7925_scan_work(struct work_struct *work);
diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index fbb8128d19de..9a0220b4de3c 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -15,6 +15,7 @@
 #include <linux/hwmon.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <uapi/linux/psci.h>
 
 #define MLXBF_PMC_WRITE_REG_32 0x82000009
@@ -1067,7 +1068,7 @@ static int mlxbf_pmc_get_event_num(const char *blk, const char *evt)
 	return -ENODEV;
 }
 
-/* Get the event number given the name */
+/* Get the event name given the number */
 static char *mlxbf_pmc_get_event_name(const char *blk, u32 evt)
 {
 	const struct mlxbf_pmc_events *events;
@@ -1625,6 +1626,7 @@ static ssize_t mlxbf_pmc_event_store(struct device *dev,
 		attr, struct mlxbf_pmc_attribute, dev_attr);
 	unsigned int blk_num, cnt_num;
 	bool is_l3 = false;
+	char *evt_name;
 	int evt_num;
 	int err;
 
@@ -1632,14 +1634,23 @@ static ssize_t mlxbf_pmc_event_store(struct device *dev,
 	cnt_num = attr_event->index;
 
 	if (isalpha(buf[0])) {
+		/* Remove the trailing newline character if present */
+		evt_name = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
+		if (!evt_name)
+			return -ENOMEM;
+
 		evt_num = mlxbf_pmc_get_event_num(pmc->block_name[blk_num],
-						  buf);
+						  evt_name);
+		kfree(evt_name);
 		if (evt_num < 0)
 			return -EINVAL;
 	} else {
 		err = kstrtouint(buf, 0, &evt_num);
 		if (err < 0)
 			return err;
+
+		if (!mlxbf_pmc_get_event_name(pmc->block_name[blk_num], evt_num))
+			return -EINVAL;
 	}
 
 	if (strstr(pmc->block_name[blk_num], "l3cache"))
@@ -1720,13 +1731,14 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_enable = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	unsigned int en, blk_num;
+	unsigned int blk_num;
 	u32 word;
 	int err;
+	bool en;
 
 	blk_num = attr_enable->nr;
 
-	err = kstrtouint(buf, 0, &en);
+	err = kstrtobool(buf, &en);
 	if (err < 0)
 		return err;
 
@@ -1746,14 +1758,11 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
 			MLXBF_PMC_CRSPACE_PERFMON_CTL(pmc->block[blk_num].counters),
 			MLXBF_PMC_WRITE_REG_32, word);
 	} else {
-		if (en && en != 1)
-			return -EINVAL;
-
 		err = mlxbf_pmc_config_l3_counters(blk_num, false, !!en);
 		if (err)
 			return err;
 
-		if (en == 1) {
+		if (en) {
 			err = mlxbf_pmc_config_l3_counters(blk_num, true, false);
 			if (err)
 				return err;
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e1b142947067..4631c7bb22cd 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -58,6 +58,8 @@ obj-$(CONFIG_X86_PLATFORM_DRIVERS_HP)	+= hp/
 # Hewlett Packard Enterprise
 obj-$(CONFIG_UV_SYSFS)       += uv_sysfs.o
 
+obj-$(CONFIG_FW_ATTR_CLASS)	+= firmware_attributes_class.o
+
 # IBM Thinkpad and Lenovo
 obj-$(CONFIG_IBM_RTL)		+= ibm_rtl.o
 obj-$(CONFIG_IDEAPAD_LAPTOP)	+= ideapad-laptop.o
@@ -120,7 +122,6 @@ obj-$(CONFIG_SYSTEM76_ACPI)	+= system76_acpi.o
 obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
 
 # Platform drivers
-obj-$(CONFIG_FW_ATTR_CLASS)		+= firmware_attributes_class.o
 obj-$(CONFIG_SERIAL_MULTI_INSTANTIATE)	+= serial-multi-instantiate.o
 obj-$(CONFIG_MLX_PLATFORM)		+= mlx-platform.o
 obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index a5933980ade3..90ad0045fec5 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -529,6 +529,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_zenbook_duo_kbd,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS Zenbook Duo UX8406CA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UX8406CA"),
+		},
+		.driver_data = &quirk_asus_zenbook_duo_kbd,
+	},
 	{},
 };
 
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 93aa72bff3f0..c7e8bcf3d623 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1672,7 +1672,7 @@ static int ideapad_kbd_bl_init(struct ideapad_private *priv)
 	priv->kbd_bl.led.name                    = "platform::" LED_FUNCTION_KBD_BACKLIGHT;
 	priv->kbd_bl.led.brightness_get          = ideapad_kbd_bl_led_cdev_brightness_get;
 	priv->kbd_bl.led.brightness_set_blocking = ideapad_kbd_bl_led_cdev_brightness_set;
-	priv->kbd_bl.led.flags                   = LED_BRIGHT_HW_CHANGED;
+	priv->kbd_bl.led.flags                   = LED_BRIGHT_HW_CHANGED | LED_RETAIN_AT_SHUTDOWN;
 
 	err = led_classdev_register(&priv->platform_device->dev, &priv->kbd_bl.led);
 	if (err)
@@ -1731,7 +1731,7 @@ static int ideapad_fn_lock_led_init(struct ideapad_private *priv)
 	priv->fn_lock.led.name                    = "platform::" LED_FUNCTION_FNLOCK;
 	priv->fn_lock.led.brightness_get          = ideapad_fn_lock_led_cdev_get;
 	priv->fn_lock.led.brightness_set_blocking = ideapad_fn_lock_led_cdev_set;
-	priv->fn_lock.led.flags                   = LED_BRIGHT_HW_CHANGED;
+	priv->fn_lock.led.flags                   = LED_BRIGHT_HW_CHANGED | LED_RETAIN_AT_SHUTDOWN;
 
 	err = led_classdev_register(&priv->platform_device->dev, &priv->fn_lock.led);
 	if (err)
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1f4698d724bb..e7f2a8b65947 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5536,6 +5536,7 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
 				 ERR_PTR(err));
 	}
 
+	rdev->coupling_desc.n_coupled = 0;
 	kfree(rdev->coupling_desc.coupled_rdevs);
 	rdev->coupling_desc.coupled_rdevs = NULL;
 }
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 2f34761e6413..7cfc4f986297 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -131,6 +131,7 @@ static int ism_cmd(struct ism_dev *ism, void *cmd)
 	struct ism_req_hdr *req = cmd;
 	struct ism_resp_hdr *resp = cmd;
 
+	spin_lock(&ism->cmd_lock);
 	__ism_write_cmd(ism, req + 1, sizeof(*req), req->len - sizeof(*req));
 	__ism_write_cmd(ism, req, 0, sizeof(*req));
 
@@ -144,6 +145,7 @@ static int ism_cmd(struct ism_dev *ism, void *cmd)
 	}
 	__ism_read_cmd(ism, resp + 1, sizeof(*resp), resp->len - sizeof(*resp));
 out:
+	spin_unlock(&ism->cmd_lock);
 	return resp->ret;
 }
 
@@ -607,6 +609,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	spin_lock_init(&ism->lock);
+	spin_lock_init(&ism->cmd_lock);
 	dev_set_drvdata(&pdev->dev, ism);
 	ism->pdev = pdev;
 	ism->dev.parent = &pdev->dev;
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 12f8073cb596..56be0b6901a8 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1931,11 +1931,6 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	if (cqspi->rx_chan) {
-		dma_release_channel(cqspi->rx_chan);
-		goto probe_setup_failed;
-	}
-
 	pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_get_noresume(dev);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 97787002080a..20ad6b1e44bc 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -739,8 +739,7 @@ int vchiq_shutdown(struct vchiq_instance *instance)
 	struct vchiq_state *state = instance->state;
 	int ret = 0;
 
-	if (mutex_lock_killable(&state->mutex))
-		return -EAGAIN;
+	mutex_lock(&state->mutex);
 
 	/* Remove all services */
 	vchiq_shutdown_internal(state, instance);
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 9838a2c8c1b8..aa2fa720af15 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1132,7 +1132,7 @@ static int tcpm_set_attached_state(struct tcpm_port *port, bool attached)
 				     port->data_role);
 }
 
-static int tcpm_set_roles(struct tcpm_port *port, bool attached,
+static int tcpm_set_roles(struct tcpm_port *port, bool attached, int state,
 			  enum typec_role role, enum typec_data_role data)
 {
 	enum typec_orientation orientation;
@@ -1169,7 +1169,7 @@ static int tcpm_set_roles(struct tcpm_port *port, bool attached,
 		}
 	}
 
-	ret = tcpm_mux_set(port, TYPEC_STATE_USB, usb_role, orientation);
+	ret = tcpm_mux_set(port, state, usb_role, orientation);
 	if (ret < 0)
 		return ret;
 
@@ -4339,16 +4339,6 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
 	tcpm_enable_auto_vbus_discharge(port, true);
 
-	ret = tcpm_set_roles(port, true, TYPEC_SOURCE, tcpm_data_role_for_source(port));
-	if (ret < 0)
-		return ret;
-
-	if (port->pd_supported) {
-		ret = port->tcpc->set_pd_rx(port->tcpc, true);
-		if (ret < 0)
-			goto out_disable_mux;
-	}
-
 	/*
 	 * USB Type-C specification, version 1.2,
 	 * chapter 4.5.2.2.8.1 (Attached.SRC Requirements)
@@ -4358,13 +4348,24 @@ static int tcpm_src_attach(struct tcpm_port *port)
 	    (polarity == TYPEC_POLARITY_CC2 && port->cc1 == TYPEC_CC_RA)) {
 		ret = tcpm_set_vconn(port, true);
 		if (ret < 0)
-			goto out_disable_pd;
+			return ret;
 	}
 
 	ret = tcpm_set_vbus(port, true);
 	if (ret < 0)
 		goto out_disable_vconn;
 
+	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB, TYPEC_SOURCE,
+			     tcpm_data_role_for_source(port));
+	if (ret < 0)
+		goto out_disable_vbus;
+
+	if (port->pd_supported) {
+		ret = port->tcpc->set_pd_rx(port->tcpc, true);
+		if (ret < 0)
+			goto out_disable_mux;
+	}
+
 	port->pd_capable = false;
 
 	port->partner = NULL;
@@ -4375,14 +4376,14 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
 	return 0;
 
-out_disable_vconn:
-	tcpm_set_vconn(port, false);
-out_disable_pd:
-	if (port->pd_supported)
-		port->tcpc->set_pd_rx(port->tcpc, false);
 out_disable_mux:
 	tcpm_mux_set(port, TYPEC_STATE_SAFE, USB_ROLE_NONE,
 		     TYPEC_ORIENTATION_NONE);
+out_disable_vbus:
+	tcpm_set_vbus(port, false);
+out_disable_vconn:
+	tcpm_set_vconn(port, false);
+
 	return ret;
 }
 
@@ -4514,7 +4515,8 @@ static int tcpm_snk_attach(struct tcpm_port *port)
 
 	tcpm_enable_auto_vbus_discharge(port, true);
 
-	ret = tcpm_set_roles(port, true, TYPEC_SINK, tcpm_data_role_for_sink(port));
+	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB,
+			     TYPEC_SINK, tcpm_data_role_for_sink(port));
 	if (ret < 0)
 		return ret;
 
@@ -4537,12 +4539,24 @@ static void tcpm_snk_detach(struct tcpm_port *port)
 static int tcpm_acc_attach(struct tcpm_port *port)
 {
 	int ret;
+	enum typec_role role;
+	enum typec_data_role data;
+	int state = TYPEC_STATE_USB;
 
 	if (port->attached)
 		return 0;
 
-	ret = tcpm_set_roles(port, true, TYPEC_SOURCE,
-			     tcpm_data_role_for_source(port));
+	role = tcpm_port_is_sink(port) ? TYPEC_SINK : TYPEC_SOURCE;
+	data = tcpm_port_is_sink(port) ? tcpm_data_role_for_sink(port)
+				       : tcpm_data_role_for_source(port);
+
+	if (tcpm_port_is_audio(port))
+		state = TYPEC_MODE_AUDIO;
+
+	if (tcpm_port_is_debug(port))
+		state = TYPEC_MODE_DEBUG;
+
+	ret = tcpm_set_roles(port, true, state, role, data);
 	if (ret < 0)
 		return ret;
 
@@ -5301,7 +5315,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 */
 		tcpm_set_vconn(port, false);
 		tcpm_set_vbus(port, false);
-		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
+		tcpm_set_roles(port, port->self_powered, TYPEC_STATE_USB, TYPEC_SOURCE,
 			       tcpm_data_role_for_source(port));
 		/*
 		 * If tcpc fails to notify vbus off, TCPM will wait for PD_T_SAFE_0V +
@@ -5333,7 +5347,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_vconn(port, false);
 		if (port->pd_capable)
 			tcpm_set_charge(port, false);
-		tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
+		tcpm_set_roles(port, port->self_powered, TYPEC_STATE_USB, TYPEC_SINK,
 			       tcpm_data_role_for_sink(port));
 		/*
 		 * VBUS may or may not toggle, depending on the adapter.
@@ -5457,10 +5471,10 @@ static void run_state_machine(struct tcpm_port *port)
 	case DR_SWAP_CHANGE_DR:
 		tcpm_unregister_altmodes(port);
 		if (port->data_role == TYPEC_HOST)
-			tcpm_set_roles(port, true, port->pwr_role,
+			tcpm_set_roles(port, true, TYPEC_STATE_USB, port->pwr_role,
 				       TYPEC_DEVICE);
 		else
-			tcpm_set_roles(port, true, port->pwr_role,
+			tcpm_set_roles(port, true, TYPEC_STATE_USB, port->pwr_role,
 				       TYPEC_HOST);
 		tcpm_ams_finish(port);
 		tcpm_set_state(port, ready_state(port), 0);
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 147926c8bae0..c0276979675d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2741,7 +2741,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 		     void (*recycle_done)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	int err;
+	int err, err_reset;
 
 	if (num > vq->vq.num_max)
 		return -E2BIG;
@@ -2763,7 +2763,11 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 	else
 		err = virtqueue_resize_split(_vq, num);
 
-	return virtqueue_enable_after_reset(_vq);
+	err_reset = virtqueue_enable_after_reset(_vq);
+	if (err_reset)
+		return err_reset;
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(virtqueue_resize);
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3d06fda70f31..856463a702b2 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -277,13 +277,8 @@ struct erofs_inode {
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_logical_clusterbits;
 			unsigned long  z_tailextent_headlcn;
-			union {
-				struct {
-					erofs_off_t    z_idataoff;
-					unsigned short z_idata_size;
-				};
-				erofs_off_t z_fragmentoff;
-			};
+			erofs_off_t    z_fragmentoff;
+			unsigned short z_idata_size;
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
@@ -329,10 +324,12 @@ static inline struct folio *erofs_grab_folio_nowait(struct address_space *as,
 /* The length of extent is full */
 #define EROFS_MAP_FULL_MAPPED	0x0008
 /* Located in the special packed inode */
-#define EROFS_MAP_FRAGMENT	0x0010
+#define __EROFS_MAP_FRAGMENT	0x0010
 /* The extent refers to partial decompressed data */
 #define EROFS_MAP_PARTIAL_REF	0x0020
 
+#define EROFS_MAP_FRAGMENT	(EROFS_MAP_MAPPED | __EROFS_MAP_FRAGMENT)
+
 struct erofs_map_blocks {
 	struct erofs_buf buf;
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 94c1e2d64df9..f35d2eb0ed11 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1016,7 +1016,7 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 			folio_zero_segment(folio, cur, end);
 			tight = false;
-		} else if (map->m_flags & EROFS_MAP_FRAGMENT) {
+		} else if (map->m_flags & __EROFS_MAP_FRAGMENT) {
 			erofs_off_t fpos = offset + cur - map->m_la;
 
 			err = z_erofs_read_fragment(inode->i_sb, folio, cur,
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 4535f2f0a014..25a4b82c183c 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -97,17 +97,48 @@ static int get_compacted_la_distance(unsigned int lobits,
 	return d1;
 }
 
-static int unpack_compacted_index(struct z_erofs_maprecorder *m,
-				  unsigned int amortizedshift,
-				  erofs_off_t pos, bool lookahead)
+static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
+					 unsigned long lcn, bool lookahead)
 {
-	struct erofs_inode *const vi = EROFS_I(m->inode);
+	struct inode *const inode = m->inode;
+	struct erofs_inode *const vi = EROFS_I(inode);
+	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
+		ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const unsigned int totalidx = erofs_iblks(inode);
+	unsigned int compacted_4b_initial, compacted_2b, amortizedshift;
 	unsigned int vcnt, lo, lobits, encodebits, nblk, bytes;
-	bool big_pcluster;
+	bool big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+	erofs_off_t pos;
 	u8 *in, type;
 	int i;
 
+	if (lcn >= totalidx || lclusterbits > 14)
+		return -EINVAL;
+
+	m->lcn = lcn;
+	/* used to align to 32-byte (compacted_2b) alignment */
+	compacted_4b_initial = ((32 - ebase % 32) / 4) & 7;
+	compacted_2b = 0;
+	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
+	    compacted_4b_initial < totalidx)
+		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
+
+	pos = ebase;
+	amortizedshift = 2;	/* compact_4b */
+	if (lcn >= compacted_4b_initial) {
+		pos += compacted_4b_initial * 4;
+		lcn -= compacted_4b_initial;
+		if (lcn < compacted_2b) {
+			amortizedshift = 1;
+		} else {
+			pos += compacted_2b * 2;
+			lcn -= compacted_2b;
+		}
+	}
+	pos += lcn * (1 << amortizedshift);
+
+	/* figure out the lcluster count in this pack */
 	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
 	else if (1 << amortizedshift == 2 && lclusterbits <= 12)
@@ -122,7 +153,6 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	/* it doesn't equal to round_up(..) */
 	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
 			 (vcnt << amortizedshift);
-	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
 	bytes = pos & ((vcnt << amortizedshift) - 1);
@@ -207,53 +237,6 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
-static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
-					 unsigned long lcn, bool lookahead)
-{
-	struct inode *const inode = m->inode;
-	struct erofs_inode *const vi = EROFS_I(inode);
-	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
-		ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	unsigned int totalidx = erofs_iblks(inode);
-	unsigned int compacted_4b_initial, compacted_2b;
-	unsigned int amortizedshift;
-	erofs_off_t pos;
-
-	if (lcn >= totalidx || vi->z_logical_clusterbits > 14)
-		return -EINVAL;
-
-	m->lcn = lcn;
-	/* used to align to 32-byte (compacted_2b) alignment */
-	compacted_4b_initial = (32 - ebase % 32) / 4;
-	if (compacted_4b_initial == 32 / 4)
-		compacted_4b_initial = 0;
-
-	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
-	    compacted_4b_initial < totalidx)
-		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
-	else
-		compacted_2b = 0;
-
-	pos = ebase;
-	if (lcn < compacted_4b_initial) {
-		amortizedshift = 2;
-		goto out;
-	}
-	pos += compacted_4b_initial * 4;
-	lcn -= compacted_4b_initial;
-
-	if (lcn < compacted_2b) {
-		amortizedshift = 1;
-		goto out;
-	}
-	pos += compacted_2b * 2;
-	lcn -= compacted_2b;
-	amortizedshift = 2;
-out:
-	pos += lcn * (1 << amortizedshift);
-	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
-}
-
 static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
 					   unsigned int lcn, bool lookahead)
 {
@@ -282,26 +265,22 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		if (err)
 			return err;
 
-		switch (m->type) {
-		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
+		if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
+			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
+				  m->type, lcn, vi->nid);
+			DBG_BUGON(1);
+			return -EOPNOTSUPP;
+		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			lookback_distance = m->delta[0];
 			if (!lookback_distance)
-				goto err_bogus;
+				break;
 			continue;
-		case Z_EROFS_LCLUSTER_TYPE_PLAIN:
-		case Z_EROFS_LCLUSTER_TYPE_HEAD1:
-		case Z_EROFS_LCLUSTER_TYPE_HEAD2:
+		} else {
 			m->headtype = m->type;
 			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
 			return 0;
-		default:
-			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
-				  m->type, lcn, vi->nid);
-			DBG_BUGON(1);
-			return -EOPNOTSUPP;
 		}
 	}
-err_bogus:
 	erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
 		  lookback_distance, m->lcn, vi->nid);
 	DBG_BUGON(1);
@@ -311,27 +290,23 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 					    unsigned int initial_lcn)
 {
-	struct super_block *sb = m->inode->i_sb;
-	struct erofs_inode *const vi = EROFS_I(m->inode);
-	struct erofs_map_blocks *const map = m->map;
-	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	unsigned long lcn;
+	struct inode *inode = m->inode;
+	struct super_block *sb = inode->i_sb;
+	struct erofs_inode *vi = EROFS_I(inode);
+	bool bigpcl1 = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+	bool bigpcl2 = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2;
+	unsigned long lcn = m->lcn + 1;
 	int err;
 
-	DBG_BUGON(m->type != Z_EROFS_LCLUSTER_TYPE_PLAIN &&
-		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD1 &&
-		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD2);
+	DBG_BUGON(m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
 	DBG_BUGON(m->type != m->headtype);
 
-	if (m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
-	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD1) &&
-	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) ||
-	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) &&
-	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
-		map->m_plen = 1ULL << lclusterbits;
-		return 0;
-	}
-	lcn = m->lcn + 1;
+	if ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD1 && !bigpcl1) ||
+	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
+	      m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) && !bigpcl2) ||
+	    (lcn << vi->z_logical_clusterbits) >= inode->i_size)
+		m->compressedblks = 1;
+
 	if (m->compressedblks)
 		goto out;
 
@@ -350,35 +325,28 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	DBG_BUGON(lcn == initial_lcn &&
 		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
 
-	switch (m->type) {
-	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
+	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+		if (m->delta[0] != 1) {
+			erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+		if (m->compressedblks)
+			goto out;
+	} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
 		/*
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
-		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
+		 * rather than CBLKCNT, it's a 1 block-sized pcluster.
 		 */
-		m->compressedblks = 1 << (lclusterbits - sb->s_blocksize_bits);
-		break;
-	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
-		if (m->delta[0] != 1)
-			goto err_bonus_cblkcnt;
-		if (m->compressedblks)
-			break;
-		fallthrough;
-	default:
-		erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn,
-			  vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
+		m->compressedblks = 1;
+		goto out;
 	}
-out:
-	map->m_plen = erofs_pos(sb, m->compressedblks);
-	return 0;
-err_bonus_cblkcnt:
-	erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
+	erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
 	DBG_BUGON(1);
 	return -EFSCORRUPTED;
+out:
+	m->map->m_plen = erofs_pos(sb, m->compressedblks);
+	return 0;
 }
 
 static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
@@ -407,9 +375,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 				m->delta[1] = 1;
 				DBG_BUGON(1);
 			}
-		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
-			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1 ||
-			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
+		} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
 			if (lcn != headlcn)
 				break;	/* ends at the next HEAD lcluster */
 			m->delta[1] = 1;
@@ -428,9 +394,10 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 static int z_erofs_do_map_blocks(struct inode *inode,
 				 struct erofs_map_blocks *map, int flags)
 {
-	struct erofs_inode *const vi = EROFS_I(inode);
-	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct super_block *sb = inode->i_sb;
 	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+	bool ztailpacking = vi->z_idata_size;
 	struct z_erofs_maprecorder m = {
 		.inode = inode,
 		.map = map,
@@ -449,9 +416,8 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	if (err)
 		goto unmap_out;
 
-	if (ztailpacking && (flags & EROFS_GET_BLOCKS_FINDTAIL))
-		vi->z_idataoff = m.nextpackoff;
-
+	if ((flags & EROFS_GET_BLOCKS_FINDTAIL) && ztailpacking)
+		vi->z_fragmentoff = m.nextpackoff;
 	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 	end = (m.lcn + 1ULL) << lclusterbits;
 
@@ -473,8 +439,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
 		if (!m.lcn) {
-			erofs_err(inode->i_sb,
-				  "invalid logical cluster 0 at nid %llu",
+			erofs_err(sb, "invalid logical cluster 0 at nid %llu",
 				  vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
@@ -490,8 +455,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			goto unmap_out;
 		break;
 	default:
-		erofs_err(inode->i_sb,
-			  "unknown type %u @ offset %llu of nid %llu",
+		erofs_err(sb, "unknown type %u @ offset %llu of nid %llu",
 			  m.type, ofs, vi->nid);
 		err = -EOPNOTSUPP;
 		goto unmap_out;
@@ -508,12 +472,18 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	}
 	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_META;
-		map->m_pa = vi->z_idataoff;
+		map->m_pa = vi->z_fragmentoff;
 		map->m_plen = vi->z_idata_size;
+		if (erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
+			erofs_err(sb, "invalid tail-packing pclustersize %llu",
+				  map->m_plen);
+			err = -EFSCORRUPTED;
+			goto unmap_out;
+		}
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
-		map->m_flags |= EROFS_MAP_FRAGMENT;
+		map->m_flags = EROFS_MAP_FRAGMENT;
 	} else {
-		map->m_pa = erofs_pos(inode->i_sb, m.pblk);
+		map->m_pa = erofs_pos(sb, m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
 		if (err)
 			goto unmap_out;
@@ -532,7 +502,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		afmt = m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2 ?
 			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
 		if (!(EROFS_I_SB(inode)->available_compr_algs & (1 << afmt))) {
-			erofs_err(inode->i_sb, "inconsistent algorithmtype %u for nid %llu",
+			erofs_err(sb, "inconsistent algorithmtype %u for nid %llu",
 				  afmt, vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
@@ -601,6 +571,10 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	vi->z_advise = le16_to_cpu(h->h_advise);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
+		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
+	else if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER)
+		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 
 	headnr = 0;
 	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
@@ -629,33 +603,12 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_put_metabuf;
 	}
 
-	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
-		struct erofs_map_blocks map = {
-			.buf = __EROFS_BUF_INITIALIZER
-		};
-
-		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
-		err = z_erofs_do_map_blocks(inode, &map,
-					    EROFS_GET_BLOCKS_FINDTAIL);
-		erofs_put_metabuf(&map.buf);
-
-		if (!map.m_plen ||
-		    erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
-			erofs_err(sb, "invalid tail-packing pclustersize %llu",
-				  map.m_plen);
-			err = -EFSCORRUPTED;
-		}
-		if (err < 0)
-			goto out_put_metabuf;
-	}
-
-	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
-	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
+	if (vi->z_idata_size ||
+	    (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
 		struct erofs_map_blocks map = {
 			.buf = __EROFS_BUF_INITIALIZER
 		};
 
-		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
 		err = z_erofs_do_map_blocks(inode, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
@@ -691,8 +644,7 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    !vi->z_tailextent_headlcn) {
 				map->m_la = 0;
 				map->m_llen = inode->i_size;
-				map->m_flags = EROFS_MAP_MAPPED |
-					EROFS_MAP_FULL_MAPPED | EROFS_MAP_FRAGMENT;
+				map->m_flags = EROFS_MAP_FRAGMENT;
 			} else {
 				err = z_erofs_do_map_blocks(inode, map, flags);
 			}
@@ -725,7 +677,7 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 	iomap->length = map.m_llen;
 	if (map.m_flags & EROFS_MAP_MAPPED) {
 		iomap->type = IOMAP_MAPPED;
-		iomap->addr = map.m_flags & EROFS_MAP_FRAGMENT ?
+		iomap->addr = map.m_flags & __EROFS_MAP_FRAGMENT ?
 			      IOMAP_NULL_ADDR : map.m_pa;
 	} else {
 		iomap->type = IOMAP_HOLE;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index e94df69ee2e0..a95525bfb99c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -368,6 +368,8 @@ struct ext4_io_submit {
 #define EXT4_MAX_BLOCKS(size, offset, blkbits) \
 	((EXT4_BLOCK_ALIGN(size + offset, blkbits) >> blkbits) - (offset >> \
 								  blkbits))
+#define EXT4_B_TO_LBLK(inode, offset) \
+	(round_up((offset), i_blocksize(inode)) >> (inode)->i_blkbits)
 
 /* Translate a block number to a cluster number */
 #define EXT4_B2C(sbi, blk)	((blk) >> (sbi)->s_cluster_bits)
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b16d72275e10..2f9c3cd4f26c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4569,122 +4569,65 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			    loff_t len, int mode)
 {
 	struct inode *inode = file_inode(file);
-	struct address_space *mapping = file->f_mapping;
 	handle_t *handle = NULL;
-	unsigned int max_blocks;
 	loff_t new_size = 0;
-	int ret = 0;
-	int flags;
-	int credits;
-	int partial_begin, partial_end;
-	loff_t start, end;
-	ext4_lblk_t lblk;
+	loff_t end = offset + len;
+	ext4_lblk_t start_lblk, end_lblk;
+	unsigned int blocksize = i_blocksize(inode);
 	unsigned int blkbits = inode->i_blkbits;
+	int ret, flags, credits;
 
 	trace_ext4_zero_range(inode, offset, len, mode);
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
-	/*
-	 * Round up offset. This is not fallocate, we need to zero out
-	 * blocks, so convert interior block aligned part of the range to
-	 * unwritten and possibly manually zero out unaligned parts of the
-	 * range. Here, start and partial_begin are inclusive, end and
-	 * partial_end are exclusive.
-	 */
-	start = round_up(offset, 1 << blkbits);
-	end = round_down((offset + len), 1 << blkbits);
-
-	if (start < offset || end > offset + len)
-		return -EINVAL;
-	partial_begin = offset & ((1 << blkbits) - 1);
-	partial_end = (offset + len) & ((1 << blkbits) - 1);
-
-	lblk = start >> blkbits;
-	max_blocks = (end >> blkbits);
-	if (max_blocks < lblk)
-		max_blocks = 0;
-	else
-		max_blocks -= lblk;
-
-	inode_lock(inode);
-
-	/*
-	 * Indirect files do not support unwritten extents
-	 */
-	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
-		ret = -EOPNOTSUPP;
-		goto out_mutex;
-	}
+	/* Indirect files do not support unwritten extents */
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
+		return -EOPNOTSUPP;
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
-	    (offset + len > inode->i_size ||
-	     offset + len > EXT4_I(inode)->i_disksize)) {
-		new_size = offset + len;
+	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
+		new_size = end;
 		ret = inode_newsize_ok(inode, new_size);
 		if (ret)
-			goto out_mutex;
+			return ret;
 	}
 
 	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
-
-	/* Wait all existing dio workers, newcomers will block on i_rwsem */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		goto out_mutex;
-
 	/* Preallocate the range including the unaligned edges */
-	if (partial_begin || partial_end) {
-		ret = ext4_alloc_file_blocks(file,
-				round_down(offset, 1 << blkbits) >> blkbits,
-				(round_up((offset + len), 1 << blkbits) -
-				 round_down(offset, 1 << blkbits)) >> blkbits,
-				new_size, flags);
-		if (ret)
-			goto out_mutex;
+	if (!IS_ALIGNED(offset | end, blocksize)) {
+		ext4_lblk_t alloc_lblk = offset >> blkbits;
+		ext4_lblk_t len_lblk = EXT4_MAX_BLOCKS(len, offset, blkbits);
 
+		ret = ext4_alloc_file_blocks(file, alloc_lblk, len_lblk,
+					     new_size, flags);
+		if (ret)
+			return ret;
 	}
 
-	/* Zero range excluding the unaligned edges */
-	if (max_blocks > 0) {
-		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
-			  EXT4_EX_NOCACHE);
-
-		/*
-		 * Prevent page faults from reinstantiating pages we have
-		 * released from page cache.
-		 */
-		filemap_invalidate_lock(mapping);
-
-		ret = ext4_break_layouts(inode);
-		if (ret) {
-			filemap_invalidate_unlock(mapping);
-			goto out_mutex;
-		}
-
-		ret = ext4_update_disksize_before_punch(inode, offset, len);
-		if (ret) {
-			filemap_invalidate_unlock(mapping);
-			goto out_mutex;
-		}
-
-		/* Now release the pages and zero block aligned part of pages */
-		ret = ext4_truncate_page_cache_block_range(inode, start, end);
-		if (ret) {
-			filemap_invalidate_unlock(mapping);
-			goto out_mutex;
-		}
+	ret = ext4_update_disksize_before_punch(inode, offset, len);
+	if (ret)
+		return ret;
 
-		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+	/* Now release the pages and zero block aligned part of pages */
+	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
+	if (ret)
+		return ret;
 
-		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
-					     flags);
-		filemap_invalidate_unlock(mapping);
+	/* Zero range excluding the unaligned edges */
+	start_lblk = EXT4_B_TO_LBLK(inode, offset);
+	end_lblk = end >> blkbits;
+	if (end_lblk > start_lblk) {
+		ext4_lblk_t zero_blks = end_lblk - start_lblk;
+
+		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN | EXT4_EX_NOCACHE);
+		ret = ext4_alloc_file_blocks(file, start_lblk, zero_blks,
+					     new_size, flags);
 		if (ret)
-			goto out_mutex;
+			return ret;
 	}
-	if (!partial_begin && !partial_end)
-		goto out_mutex;
+	/* Finish zeroing out if it doesn't contain partial block */
+	if (IS_ALIGNED(offset | end, blocksize))
+		return ret;
 
 	/*
 	 * In worst case we have to writeout two nonadjacent unwritten
@@ -4697,27 +4640,69 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		ext4_std_error(inode->i_sb, ret);
-		goto out_mutex;
+		return ret;
 	}
 
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+	/* Zero out partial block at the edges of the range */
+	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
+	if (ret)
+		goto out_handle;
+
 	if (new_size)
 		ext4_update_inode_size(inode, new_size);
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(ret))
 		goto out_handle;
-	/* Zero out partial block at the edges of the range */
-	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
-	if (ret >= 0)
-		ext4_update_inode_fsync_trans(handle, inode, 1);
 
+	ext4_update_inode_fsync_trans(handle, inode, 1);
 	if (file->f_flags & O_SYNC)
 		ext4_handle_sync(handle);
 
 out_handle:
 	ext4_journal_stop(handle);
-out_mutex:
-	inode_unlock(inode);
+	return ret;
+}
+
+static long ext4_do_fallocate(struct file *file, loff_t offset,
+			      loff_t len, int mode)
+{
+	struct inode *inode = file_inode(file);
+	loff_t end = offset + len;
+	loff_t new_size = 0;
+	ext4_lblk_t start_lblk, len_lblk;
+	int ret;
+
+	trace_ext4_fallocate_enter(inode, offset, len, mode);
+	WARN_ON_ONCE(!inode_is_locked(inode));
+
+	start_lblk = offset >> inode->i_blkbits;
+	len_lblk = EXT4_MAX_BLOCKS(len, offset, inode->i_blkbits);
+
+	/* We only support preallocation for extent-based files only. */
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
+	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
+		new_size = end;
+		ret = inode_newsize_ok(inode, new_size);
+		if (ret)
+			goto out;
+	}
+
+	ret = ext4_alloc_file_blocks(file, start_lblk, len_lblk, new_size,
+				     EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
+	if (ret)
+		goto out;
+
+	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
+		ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
+					EXT4_I(inode)->i_sync_tid);
+	}
+out:
+	trace_ext4_fallocate_exit(inode, offset, len_lblk, ret);
 	return ret;
 }
 
@@ -4731,12 +4716,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	loff_t new_size = 0;
-	unsigned int max_blocks;
-	int ret = 0;
-	int flags;
-	ext4_lblk_t lblk;
-	unsigned int blkbits = inode->i_blkbits;
+	struct address_space *mapping = file->f_mapping;
+	int ret;
 
 	/*
 	 * Encrypted inodes can't handle collapse range or insert
@@ -4756,73 +4737,47 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 
 	inode_lock(inode);
 	ret = ext4_convert_inline_data(inode);
-	inode_unlock(inode);
 	if (ret)
-		goto exit;
+		goto out_inode_lock;
 
-	if (mode & FALLOC_FL_PUNCH_HOLE) {
-		ret = ext4_punch_hole(file, offset, len);
-		goto exit;
-	}
-
-	if (mode & FALLOC_FL_COLLAPSE_RANGE) {
-		ret = ext4_collapse_range(file, offset, len);
-		goto exit;
-	}
+	/* Wait all existing dio workers, newcomers will block on i_rwsem */
+	inode_dio_wait(inode);
 
-	if (mode & FALLOC_FL_INSERT_RANGE) {
-		ret = ext4_insert_range(file, offset, len);
-		goto exit;
-	}
+	ret = file_modified(file);
+	if (ret)
+		goto out_inode_lock;
 
-	if (mode & FALLOC_FL_ZERO_RANGE) {
-		ret = ext4_zero_range(file, offset, len, mode);
-		goto exit;
+	if ((mode & FALLOC_FL_MODE_MASK) == FALLOC_FL_ALLOCATE_RANGE) {
+		ret = ext4_do_fallocate(file, offset, len, mode);
+		goto out_inode_lock;
 	}
-	trace_ext4_fallocate_enter(inode, offset, len, mode);
-	lblk = offset >> blkbits;
-
-	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
-	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
-
-	inode_lock(inode);
 
 	/*
-	 * We only support preallocation for extent-based files only
+	 * Follow-up operations will drop page cache, hold invalidate lock
+	 * to prevent page faults from reinstantiating pages we have
+	 * released from page cache.
 	 */
-	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
-	    (offset + len > inode->i_size ||
-	     offset + len > EXT4_I(inode)->i_disksize)) {
-		new_size = offset + len;
-		ret = inode_newsize_ok(inode, new_size);
-		if (ret)
-			goto out;
-	}
-
-	/* Wait all existing dio workers, newcomers will block on i_rwsem */
-	inode_dio_wait(inode);
+	filemap_invalidate_lock(mapping);
 
-	ret = file_modified(file);
+	ret = ext4_break_layouts(inode);
 	if (ret)
-		goto out;
+		goto out_invalidate_lock;
 
-	ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size, flags);
-	if (ret)
-		goto out;
+	if (mode & FALLOC_FL_PUNCH_HOLE)
+		ret = ext4_punch_hole(file, offset, len);
+	else if (mode & FALLOC_FL_COLLAPSE_RANGE)
+		ret = ext4_collapse_range(file, offset, len);
+	else if (mode & FALLOC_FL_INSERT_RANGE)
+		ret = ext4_insert_range(file, offset, len);
+	else if (mode & FALLOC_FL_ZERO_RANGE)
+		ret = ext4_zero_range(file, offset, len, mode);
+	else
+		ret = -EOPNOTSUPP;
 
-	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
-		ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
-					EXT4_I(inode)->i_sync_tid);
-	}
-out:
+out_invalidate_lock:
+	filemap_invalidate_unlock(mapping);
+out_inode_lock:
 	inode_unlock(inode);
-	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
-exit:
 	return ret;
 }
 
@@ -5319,109 +5274,72 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
 	struct address_space *mapping = inode->i_mapping;
-	ext4_lblk_t punch_start, punch_stop;
+	loff_t end = offset + len;
+	ext4_lblk_t start_lblk, end_lblk;
 	handle_t *handle;
 	unsigned int credits;
-	loff_t new_size, ioffset;
+	loff_t start, new_size;
 	int ret;
 
-	/*
-	 * We need to test this early because xfstests assumes that a
-	 * collapse range of (0, 1) will return EOPNOTSUPP if the file
-	 * system does not support collapse range.
-	 */
+	trace_ext4_collapse_range(inode, offset, len);
+	WARN_ON_ONCE(!inode_is_locked(inode));
+
+	/* Currently just for extent based files */
 	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		return -EOPNOTSUPP;
-
 	/* Collapse range works only on fs cluster size aligned regions. */
 	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
 		return -EINVAL;
-
-	trace_ext4_collapse_range(inode, offset, len);
-
-	punch_start = offset >> EXT4_BLOCK_SIZE_BITS(sb);
-	punch_stop = (offset + len) >> EXT4_BLOCK_SIZE_BITS(sb);
-
-	inode_lock(inode);
 	/*
 	 * There is no need to overlap collapse range with EOF, in which case
 	 * it is effectively a truncate operation
 	 */
-	if (offset + len >= inode->i_size) {
-		ret = -EINVAL;
-		goto out_mutex;
-	}
-
-	/* Currently just for extent based files */
-	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		ret = -EOPNOTSUPP;
-		goto out_mutex;
-	}
-
-	/* Wait for existing dio to complete */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		goto out_mutex;
-
-	/*
-	 * Prevent page faults from reinstantiating pages we have released from
-	 * page cache.
-	 */
-	filemap_invalidate_lock(mapping);
-
-	ret = ext4_break_layouts(inode);
-	if (ret)
-		goto out_mmap;
+	if (end >= inode->i_size)
+		return -EINVAL;
 
 	/*
+	 * Write tail of the last page before removed range and data that
+	 * will be shifted since they will get removed from the page cache
+	 * below. We are also protected from pages becoming dirty by
+	 * i_rwsem and invalidate_lock.
 	 * Need to round down offset to be aligned with page size boundary
 	 * for page size > block size.
 	 */
-	ioffset = round_down(offset, PAGE_SIZE);
-	/*
-	 * Write tail of the last page before removed range since it will get
-	 * removed from the page cache below.
-	 */
-	ret = filemap_write_and_wait_range(mapping, ioffset, offset);
+	start = round_down(offset, PAGE_SIZE);
+	ret = filemap_write_and_wait_range(mapping, start, offset);
+	if (!ret)
+		ret = filemap_write_and_wait_range(mapping, end, LLONG_MAX);
 	if (ret)
-		goto out_mmap;
-	/*
-	 * Write data that will be shifted to preserve them when discarding
-	 * page cache below. We are also protected from pages becoming dirty
-	 * by i_rwsem and invalidate_lock.
-	 */
-	ret = filemap_write_and_wait_range(mapping, offset + len,
-					   LLONG_MAX);
-	if (ret)
-		goto out_mmap;
-	truncate_pagecache(inode, ioffset);
+		return ret;
+
+	truncate_pagecache(inode, start);
 
 	credits = ext4_writepage_trans_blocks(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		goto out_mmap;
-	}
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
 	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
+	start_lblk = offset >> inode->i_blkbits;
+	end_lblk = (offset + len) >> inode->i_blkbits;
+
 	down_write(&EXT4_I(inode)->i_data_sem);
 	ext4_discard_preallocations(inode);
-	ext4_es_remove_extent(inode, punch_start, EXT_MAX_BLOCKS - punch_start);
+	ext4_es_remove_extent(inode, start_lblk, EXT_MAX_BLOCKS - start_lblk);
 
-	ret = ext4_ext_remove_space(inode, punch_start, punch_stop - 1);
+	ret = ext4_ext_remove_space(inode, start_lblk, end_lblk - 1);
 	if (ret) {
 		up_write(&EXT4_I(inode)->i_data_sem);
-		goto out_stop;
+		goto out_handle;
 	}
 	ext4_discard_preallocations(inode);
 
-	ret = ext4_ext_shift_extents(inode, handle, punch_stop,
-				     punch_stop - punch_start, SHIFT_LEFT);
+	ret = ext4_ext_shift_extents(inode, handle, end_lblk,
+				     end_lblk - start_lblk, SHIFT_LEFT);
 	if (ret) {
 		up_write(&EXT4_I(inode)->i_data_sem);
-		goto out_stop;
+		goto out_handle;
 	}
 
 	new_size = inode->i_size - len;
@@ -5429,18 +5347,16 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	EXT4_I(inode)->i_disksize = new_size;
 
 	up_write(&EXT4_I(inode)->i_data_sem);
-	if (IS_SYNC(inode))
-		ext4_handle_sync(handle);
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = ext4_mark_inode_dirty(handle, inode);
+	if (ret)
+		goto out_handle;
+
 	ext4_update_inode_fsync_trans(handle, inode, 1);
+	if (IS_SYNC(inode))
+		ext4_handle_sync(handle);
 
-out_stop:
+out_handle:
 	ext4_journal_stop(handle);
-out_mmap:
-	filemap_invalidate_unlock(mapping);
-out_mutex:
-	inode_unlock(inode);
 	return ret;
 }
 
@@ -5460,100 +5376,63 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	handle_t *handle;
 	struct ext4_ext_path *path;
 	struct ext4_extent *extent;
-	ext4_lblk_t offset_lblk, len_lblk, ee_start_lblk = 0;
+	ext4_lblk_t start_lblk, len_lblk, ee_start_lblk = 0;
 	unsigned int credits, ee_len;
-	int ret = 0, depth, split_flag = 0;
-	loff_t ioffset;
+	int ret, depth, split_flag = 0;
+	loff_t start;
 
-	/*
-	 * We need to test this early because xfstests assumes that an
-	 * insert range of (0, 1) will return EOPNOTSUPP if the file
-	 * system does not support insert range.
-	 */
+	trace_ext4_insert_range(inode, offset, len);
+	WARN_ON_ONCE(!inode_is_locked(inode));
+
+	/* Currently just for extent based files */
 	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		return -EOPNOTSUPP;
-
 	/* Insert range works only on fs cluster size aligned regions. */
 	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
 		return -EINVAL;
-
-	trace_ext4_insert_range(inode, offset, len);
-
-	offset_lblk = offset >> EXT4_BLOCK_SIZE_BITS(sb);
-	len_lblk = len >> EXT4_BLOCK_SIZE_BITS(sb);
-
-	inode_lock(inode);
-	/* Currently just for extent based files */
-	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		ret = -EOPNOTSUPP;
-		goto out_mutex;
-	}
-
-	/* Check whether the maximum file size would be exceeded */
-	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
-		ret = -EFBIG;
-		goto out_mutex;
-	}
-
 	/* Offset must be less than i_size */
-	if (offset >= inode->i_size) {
-		ret = -EINVAL;
-		goto out_mutex;
-	}
-
-	/* Wait for existing dio to complete */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		goto out_mutex;
+	if (offset >= inode->i_size)
+		return -EINVAL;
+	/* Check whether the maximum file size would be exceeded */
+	if (len > inode->i_sb->s_maxbytes - inode->i_size)
+		return -EFBIG;
 
 	/*
-	 * Prevent page faults from reinstantiating pages we have released from
-	 * page cache.
+	 * Write out all dirty pages. Need to round down to align start offset
+	 * to page size boundary for page size > block size.
 	 */
-	filemap_invalidate_lock(mapping);
-
-	ret = ext4_break_layouts(inode);
+	start = round_down(offset, PAGE_SIZE);
+	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
 	if (ret)
-		goto out_mmap;
+		return ret;
 
-	/*
-	 * Need to round down to align start offset to page size boundary
-	 * for page size > block size.
-	 */
-	ioffset = round_down(offset, PAGE_SIZE);
-	/* Write out all dirty pages */
-	ret = filemap_write_and_wait_range(inode->i_mapping, ioffset,
-			LLONG_MAX);
-	if (ret)
-		goto out_mmap;
-	truncate_pagecache(inode, ioffset);
+	truncate_pagecache(inode, start);
 
 	credits = ext4_writepage_trans_blocks(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		goto out_mmap;
-	}
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
 	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
 	/* Expand file to avoid data loss if there is error while shifting */
 	inode->i_size += len;
 	EXT4_I(inode)->i_disksize += len;
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (ret)
-		goto out_stop;
+		goto out_handle;
+
+	start_lblk = offset >> inode->i_blkbits;
+	len_lblk = len >> inode->i_blkbits;
 
 	down_write(&EXT4_I(inode)->i_data_sem);
 	ext4_discard_preallocations(inode);
 
-	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
+	path = ext4_find_extent(inode, start_lblk, NULL, 0);
 	if (IS_ERR(path)) {
 		up_write(&EXT4_I(inode)->i_data_sem);
 		ret = PTR_ERR(path);
-		goto out_stop;
+		goto out_handle;
 	}
 
 	depth = ext_depth(inode);
@@ -5563,16 +5442,16 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 		ee_len = ext4_ext_get_actual_len(extent);
 
 		/*
-		 * If offset_lblk is not the starting block of extent, split
-		 * the extent @offset_lblk
+		 * If start_lblk is not the starting block of extent, split
+		 * the extent @start_lblk
 		 */
-		if ((offset_lblk > ee_start_lblk) &&
-				(offset_lblk < (ee_start_lblk + ee_len))) {
+		if ((start_lblk > ee_start_lblk) &&
+				(start_lblk < (ee_start_lblk + ee_len))) {
 			if (ext4_ext_is_unwritten(extent))
 				split_flag = EXT4_EXT_MARK_UNWRIT1 |
 					EXT4_EXT_MARK_UNWRIT2;
 			path = ext4_split_extent_at(handle, inode, path,
-					offset_lblk, split_flag,
+					start_lblk, split_flag,
 					EXT4_EX_NOCACHE |
 					EXT4_GET_BLOCKS_PRE_IO |
 					EXT4_GET_BLOCKS_METADATA_NOFAIL);
@@ -5581,32 +5460,29 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 		if (IS_ERR(path)) {
 			up_write(&EXT4_I(inode)->i_data_sem);
 			ret = PTR_ERR(path);
-			goto out_stop;
+			goto out_handle;
 		}
 	}
 
 	ext4_free_ext_path(path);
-	ext4_es_remove_extent(inode, offset_lblk, EXT_MAX_BLOCKS - offset_lblk);
+	ext4_es_remove_extent(inode, start_lblk, EXT_MAX_BLOCKS - start_lblk);
 
 	/*
-	 * if offset_lblk lies in a hole which is at start of file, use
+	 * if start_lblk lies in a hole which is at start of file, use
 	 * ee_start_lblk to shift extents
 	 */
 	ret = ext4_ext_shift_extents(inode, handle,
-		max(ee_start_lblk, offset_lblk), len_lblk, SHIFT_RIGHT);
-
+		max(ee_start_lblk, start_lblk), len_lblk, SHIFT_RIGHT);
 	up_write(&EXT4_I(inode)->i_data_sem);
+	if (ret)
+		goto out_handle;
+
+	ext4_update_inode_fsync_trans(handle, inode, 1);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
-	if (ret >= 0)
-		ext4_update_inode_fsync_trans(handle, inode, 1);
 
-out_stop:
+out_handle:
 	ext4_journal_stop(handle);
-out_mmap:
-	filemap_invalidate_unlock(mapping);
-out_mutex:
-	inode_unlock(inode);
 	return ret;
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f769f5cb6deb..eb092133c6b8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3991,83 +3991,56 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 {
 	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
-	ext4_lblk_t first_block, stop_block;
-	struct address_space *mapping = inode->i_mapping;
-	loff_t first_block_offset, last_block_offset, max_length;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	ext4_lblk_t start_lblk, end_lblk;
+	loff_t max_end = sb->s_maxbytes;
+	loff_t end = offset + length;
 	handle_t *handle;
 	unsigned int credits;
-	int ret = 0, ret2 = 0;
+	int ret;
 
 	trace_ext4_punch_hole(inode, offset, length, 0);
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
-	inode_lock(inode);
+	/*
+	 * For indirect-block based inodes, make sure that the hole within
+	 * one block before last range.
+	 */
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
 
 	/* No need to punch hole beyond i_size */
-	if (offset >= inode->i_size)
-		goto out_mutex;
+	if (offset >= inode->i_size || offset >= max_end)
+		return 0;
 
 	/*
-	 * If the hole extends beyond i_size, set the hole
-	 * to end after the page that contains i_size
+	 * If the hole extends beyond i_size, set the hole to end after
+	 * the page that contains i_size.
 	 */
-	if (offset + length > inode->i_size) {
-		length = inode->i_size +
-		   PAGE_SIZE - (inode->i_size & (PAGE_SIZE - 1)) -
-		   offset;
-	}
+	if (end > inode->i_size)
+		end = round_up(inode->i_size, PAGE_SIZE);
+	if (end > max_end)
+		end = max_end;
+	length = end - offset;
 
 	/*
-	 * For punch hole the length + offset needs to be within one block
-	 * before last range. Adjust the length if it goes beyond that limit.
+	 * Attach jinode to inode for jbd2 if we do any zeroing of partial
+	 * block.
 	 */
-	max_length = sbi->s_bitmap_maxbytes - inode->i_sb->s_blocksize;
-	if (offset + length > max_length)
-		length = max_length - offset;
-
-	if (offset & (sb->s_blocksize - 1) ||
-	    (offset + length) & (sb->s_blocksize - 1)) {
-		/*
-		 * Attach jinode to inode for jbd2 if we do any zeroing of
-		 * partial block
-		 */
+	if (!IS_ALIGNED(offset | end, sb->s_blocksize)) {
 		ret = ext4_inode_attach_jinode(inode);
 		if (ret < 0)
-			goto out_mutex;
-
+			return ret;
 	}
 
-	/* Wait all existing dio workers, newcomers will block on i_rwsem */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		goto out_mutex;
-
-	/*
-	 * Prevent page faults from reinstantiating pages we have released from
-	 * page cache.
-	 */
-	filemap_invalidate_lock(mapping);
 
-	ret = ext4_break_layouts(inode);
+	ret = ext4_update_disksize_before_punch(inode, offset, length);
 	if (ret)
-		goto out_dio;
-
-	first_block_offset = round_up(offset, sb->s_blocksize);
-	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
+		return ret;
 
 	/* Now release the pages and zero block aligned part of pages*/
-	if (last_block_offset > first_block_offset) {
-		ret = ext4_update_disksize_before_punch(inode, offset, length);
-		if (ret)
-			goto out_dio;
-
-		ret = ext4_truncate_page_cache_block_range(inode,
-				first_block_offset, last_block_offset + 1);
-		if (ret)
-			goto out_dio;
-	}
+	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
+	if (ret)
+		return ret;
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		credits = ext4_writepage_trans_blocks(inode);
@@ -4077,54 +4050,51 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		ext4_std_error(sb, ret);
-		goto out_dio;
+		return ret;
 	}
 
-	ret = ext4_zero_partial_blocks(handle, inode, offset,
-				       length);
+	ret = ext4_zero_partial_blocks(handle, inode, offset, length);
 	if (ret)
-		goto out_stop;
-
-	first_block = (offset + sb->s_blocksize - 1) >>
-		EXT4_BLOCK_SIZE_BITS(sb);
-	stop_block = (offset + length) >> EXT4_BLOCK_SIZE_BITS(sb);
+		goto out_handle;
 
 	/* If there are blocks to remove, do it */
-	if (stop_block > first_block) {
-		ext4_lblk_t hole_len = stop_block - first_block;
+	start_lblk = EXT4_B_TO_LBLK(inode, offset);
+	end_lblk = end >> inode->i_blkbits;
+
+	if (end_lblk > start_lblk) {
+		ext4_lblk_t hole_len = end_lblk - start_lblk;
 
 		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_discard_preallocations(inode);
 
-		ext4_es_remove_extent(inode, first_block, hole_len);
+		ext4_es_remove_extent(inode, start_lblk, hole_len);
 
 		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-			ret = ext4_ext_remove_space(inode, first_block,
-						    stop_block - 1);
+			ret = ext4_ext_remove_space(inode, start_lblk,
+						    end_lblk - 1);
 		else
-			ret = ext4_ind_remove_space(handle, inode, first_block,
-						    stop_block);
+			ret = ext4_ind_remove_space(handle, inode, start_lblk,
+						    end_lblk);
+		if (ret) {
+			up_write(&EXT4_I(inode)->i_data_sem);
+			goto out_handle;
+		}
 
-		ext4_es_insert_extent(inode, first_block, hole_len, ~0,
+		ext4_es_insert_extent(inode, start_lblk, hole_len, ~0,
 				      EXTENT_STATUS_HOLE, 0);
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
-	ext4_fc_track_range(handle, inode, first_block, stop_block);
+	ext4_fc_track_range(handle, inode, start_lblk, end_lblk);
+
+	ret = ext4_mark_inode_dirty(handle, inode);
+	if (unlikely(ret))
+		goto out_handle;
+
+	ext4_update_inode_fsync_trans(handle, inode, 1);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
-
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
-	ret2 = ext4_mark_inode_dirty(handle, inode);
-	if (unlikely(ret2))
-		ret = ret2;
-	if (ret >= 0)
-		ext4_update_inode_fsync_trans(handle, inode, 1);
-out_stop:
+out_handle:
 	ext4_journal_stop(handle);
-out_dio:
-	filemap_invalidate_unlock(mapping);
-out_mutex:
-	inode_unlock(inode);
 	return ret;
 }
 
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 8ddc14c56501..ecb8e05b8b84 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -3029,14 +3029,23 @@ static void duplicateIXtree(struct super_block *sb, s64 blkno,
  *
  * RETURN VALUES:
  *	0	- success
- *	-ENOMEM	- insufficient memory
+ *	-EINVAL	- unexpected inode type
  */
 static int copy_from_dinode(struct dinode * dip, struct inode *ip)
 {
 	struct jfs_inode_info *jfs_ip = JFS_IP(ip);
 	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
+	int fileset = le32_to_cpu(dip->di_fileset);
+
+	switch (fileset) {
+	case AGGR_RESERVED_I: case AGGREGATE_I: case BMAP_I:
+	case LOG_I: case BADBLOCK_I: case FILESYSTEM_I:
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	jfs_ip->fileset = le32_to_cpu(dip->di_fileset);
+	jfs_ip->fileset = fileset;
 	jfs_ip->mode2 = le32_to_cpu(dip->di_mode);
 	jfs_set_inode_flags(ip);
 
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index fd2de4b2bef1..afb3b9637740 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -499,11 +499,18 @@ static int __nilfs_read_inode(struct super_block *sb,
 		inode->i_op = &nilfs_symlink_inode_operations;
 		inode_nohighmem(inode);
 		inode->i_mapping->a_ops = &nilfs_aops;
-	} else {
+	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		inode->i_op = &nilfs_special_inode_operations;
 		init_special_inode(
 			inode, inode->i_mode,
 			huge_decode_dev(le64_to_cpu(raw_inode->i_device_code)));
+	} else {
+		nilfs_error(sb,
+			    "invalid file type bits in mode 0%o for inode %lu",
+			    inode->i_mode, ino);
+		err = -EIO;
+		goto failed_unmap;
 	}
 	nilfs_ifile_unmap_inode(raw_inode);
 	brelse(bh);
diff --git a/include/drm/drm_buddy.h b/include/drm/drm_buddy.h
index 9689a7c5dd36..513837632b7d 100644
--- a/include/drm/drm_buddy.h
+++ b/include/drm/drm_buddy.h
@@ -160,6 +160,8 @@ int drm_buddy_block_trim(struct drm_buddy *mm,
 			 u64 new_size,
 			 struct list_head *blocks);
 
+void drm_buddy_reset_clear(struct drm_buddy *mm, bool is_clear);
+
 void drm_buddy_free_block(struct drm_buddy *mm, struct drm_buddy_block *block);
 
 void drm_buddy_free_list(struct drm_buddy *mm,
diff --git a/include/linux/ism.h b/include/linux/ism.h
index 5428edd90982..8358b4cd7ba6 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -28,6 +28,7 @@ struct ism_dmb {
 
 struct ism_dev {
 	spinlock_t lock; /* protects the ism device */
+	spinlock_t cmd_lock; /* serializes cmds */
 	struct list_head list;
 	struct pci_dev *pdev;
 
diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index 33dcbec71925..9e13b8040b12 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
+#include <linux/stdarg.h>
 
 int num_to_str(char *buf, int size, unsigned long long num, unsigned int width);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f01477cecf39..531412c5103d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15480,6 +15480,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 		if (src_reg->type == PTR_TO_STACK)
 			insn_flags |= INSN_F_SRC_REG_STACK;
+		if (dst_reg->type == PTR_TO_STACK)
+			insn_flags |= INSN_F_DST_REG_STACK;
 	} else {
 		if (insn->src_reg != BPF_REG_0) {
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
@@ -15489,10 +15491,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		memset(src_reg, 0, sizeof(*src_reg));
 		src_reg->type = SCALAR_VALUE;
 		__mark_reg_known(src_reg, insn->imm);
+
+		if (dst_reg->type == PTR_TO_STACK)
+			insn_flags |= INSN_F_DST_REG_STACK;
 	}
 
-	if (dst_reg->type == PTR_TO_STACK)
-		insn_flags |= INSN_F_DST_REG_STACK;
 	if (insn_flags) {
 		err = push_insn_history(env, this_branch, insn_flags, 0);
 		if (err)
diff --git a/kernel/resource.c b/kernel/resource.c
index 4101016e8b20..1d48ae864635 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1268,8 +1268,9 @@ static int __request_region_locked(struct resource *res, struct resource *parent
 		 * become unavailable to other users.  Conflicts are
 		 * not expected.  Warn to aid debugging if encountered.
 		 */
-		if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
-			pr_warn("Unaddressable device %s %pR conflicts with %pR",
+		if (parent == &iomem_resource &&
+		    conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
+			pr_warn("Unaddressable device %s %pR conflicts with %pR\n",
 				conflict->name, conflict, res);
 		}
 		if (conflict != parent) {
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 96933082431f..e3896b2be453 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1218,7 +1218,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 				  struct system_time_snapshot *history_begin,
 				  struct system_device_crosststamp *xtstamp)
 {
-	struct system_counterval_t system_counterval;
+	struct system_counterval_t system_counterval = {};
 	struct timekeeper *tk = &tk_core.timekeeper;
 	u64 cycles, now, interval_start;
 	unsigned int clock_was_set_seq = 0;
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 5675d6a412ef..f17265410156 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -398,7 +398,9 @@ static void print_address_description(void *addr, u8 tag,
 	}
 
 	if (is_vmalloc_addr(addr)) {
-		pr_err("The buggy address %px belongs to a vmalloc virtual mapping\n", addr);
+		pr_err("The buggy address belongs to a");
+		if (!vmalloc_dump_obj(addr))
+			pr_cont(" vmalloc virtual mapping\n");
 		page = vmalloc_to_page(addr);
 	}
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b538c3d48386..abd5764e4864 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2404,7 +2404,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			VM_BUG_ON(khugepaged_scan.address < hstart ||
 				  khugepaged_scan.address + HPAGE_PMD_SIZE >
 				  hend);
-			if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
+			if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
 				struct file *file = get_file(vma->vm_file);
 				pgoff_t pgoff = linear_page_index(vma,
 						khugepaged_scan.address);
@@ -2750,7 +2750,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		mmap_assert_locked(mm);
 		memset(cc->node_load, 0, sizeof(cc->node_load));
 		nodes_clear(cc->alloc_nmask);
-		if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
+		if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
 			struct file *file = get_file(vma->vm_file);
 			pgoff_t pgoff = linear_page_index(vma, addr);
 
diff --git a/mm/ksm.c b/mm/ksm.c
index a2e2a521df0a..17e6c16ab81d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3643,10 +3643,10 @@ static ssize_t advisor_mode_show(struct kobject *kobj,
 {
 	const char *output;
 
-	if (ksm_advisor == KSM_ADVISOR_NONE)
-		output = "[none] scan-time";
-	else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
+	if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
 		output = "none [scan-time]";
+	else
+		output = "[none] scan-time";
 
 	return sysfs_emit(buf, "%s\n", output);
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ec1c71abe88d..70b2ccf0d51e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1559,6 +1559,10 @@ static int get_hwpoison_page(struct page *p, unsigned long flags)
 	return ret;
 }
 
+/*
+ * The caller must guarantee the folio isn't large folio, except hugetlb.
+ * try_to_unmap() can't handle it.
+ */
 int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
 {
 	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_SYNC | TTU_HWPOISON;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0eb5d510d4f6..e3c1e2e1560d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1080,6 +1080,14 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			goto keep;
 
 		if (folio_contain_hwpoisoned_page(folio)) {
+			/*
+			 * unmap_poisoned_folio() can't handle large
+			 * folio, just skip it. memory_failure() will
+			 * handle it if the UCE is triggered again.
+			 */
+			if (folio_test_large(folio))
+				goto keep_locked;
+
 			unmap_poisoned_folio(folio, folio_pfn(folio), false);
 			folio_unlock(folio);
 			folio_put(folio);
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 16a07def09c9..e4326af00e5e 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -976,6 +976,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	if (!zspage)
 		return NULL;
 
+	if (!IS_ENABLED(CONFIG_COMPACTION))
+		gfp &= ~__GFP_MOVABLE;
+
 	zspage->magic = ZSPAGE_MAGIC;
 	migrate_lock_init(zspage);
 
diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index 9fa0b246902b..70c5a508ffac 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -35,6 +35,7 @@
 #include <linux/seq_file.h>
 #include <linux/export.h>
 #include <linux/etherdevice.h>
+#include <linux/refcount.h>
 
 int sysctl_aarp_expiry_time = AARP_EXPIRY_TIME;
 int sysctl_aarp_tick_time = AARP_TICK_TIME;
@@ -44,6 +45,7 @@ int sysctl_aarp_resolve_time = AARP_RESOLVE_TIME;
 /* Lists of aarp entries */
 /**
  *	struct aarp_entry - AARP entry
+ *	@refcnt: Reference count
  *	@last_sent: Last time we xmitted the aarp request
  *	@packet_queue: Queue of frames wait for resolution
  *	@status: Used for proxy AARP
@@ -55,6 +57,7 @@ int sysctl_aarp_resolve_time = AARP_RESOLVE_TIME;
  *	@next: Next entry in chain
  */
 struct aarp_entry {
+	refcount_t			refcnt;
 	/* These first two are only used for unresolved entries */
 	unsigned long		last_sent;
 	struct sk_buff_head	packet_queue;
@@ -79,6 +82,17 @@ static DEFINE_RWLOCK(aarp_lock);
 /* Used to walk the list and purge/kick entries.  */
 static struct timer_list aarp_timer;
 
+static inline void aarp_entry_get(struct aarp_entry *a)
+{
+	refcount_inc(&a->refcnt);
+}
+
+static inline void aarp_entry_put(struct aarp_entry *a)
+{
+	if (refcount_dec_and_test(&a->refcnt))
+		kfree(a);
+}
+
 /*
  *	Delete an aarp queue
  *
@@ -87,7 +101,7 @@ static struct timer_list aarp_timer;
 static void __aarp_expire(struct aarp_entry *a)
 {
 	skb_queue_purge(&a->packet_queue);
-	kfree(a);
+	aarp_entry_put(a);
 }
 
 /*
@@ -380,9 +394,11 @@ static void aarp_purge(void)
 static struct aarp_entry *aarp_alloc(void)
 {
 	struct aarp_entry *a = kmalloc(sizeof(*a), GFP_ATOMIC);
+	if (!a)
+		return NULL;
 
-	if (a)
-		skb_queue_head_init(&a->packet_queue);
+	refcount_set(&a->refcnt, 1);
+	skb_queue_head_init(&a->packet_queue);
 	return a;
 }
 
@@ -508,6 +524,7 @@ int aarp_proxy_probe_network(struct atalk_iface *atif, struct atalk_addr *sa)
 	entry->dev = atif->dev;
 
 	write_lock_bh(&aarp_lock);
+	aarp_entry_get(entry);
 
 	hash = sa->s_node % (AARP_HASH_SIZE - 1);
 	entry->next = proxies[hash];
@@ -533,6 +550,7 @@ int aarp_proxy_probe_network(struct atalk_iface *atif, struct atalk_addr *sa)
 		retval = 1;
 	}
 
+	aarp_entry_put(entry);
 	write_unlock_bh(&aarp_lock);
 out:
 	return retval;
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index 17d3fc2fab4c..12a1a0f42195 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -202,6 +202,9 @@ struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 	if (len <= sizeof(struct ip_esp_hdr) || udpdata32[0] == 0)
 		goto out;
 
+	/* set the transport header to ESP */
+	skb_set_transport_header(skb, offset);
+
 	NAPI_GRO_CB(skb)->proto = IPPROTO_UDP;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 841c81abaaf4..9005fc156a20 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -202,6 +202,9 @@ struct sk_buff *xfrm6_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 	if (len <= sizeof(struct ip_esp_hdr) || udpdata32[0] == 0)
 		goto out;
 
+	/* set the transport header to ESP */
+	skb_set_transport_header(skb, offset);
+
 	NAPI_GRO_CB(skb)->proto = IPPROTO_UDP;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 8e60fb5a7083..5a345ef35c9f 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -539,9 +539,6 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 static void qfq_destroy_class(struct Qdisc *sch, struct qfq_class *cl)
 {
-	struct qfq_sched *q = qdisc_priv(sch);
-
-	qfq_rm_from_agg(q, cl);
 	gen_kill_estimator(&cl->rate_est);
 	qdisc_put(cl->qdisc);
 	kfree(cl);
@@ -562,10 +559,11 @@ static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
 
 	qdisc_purge_queue(cl->qdisc);
 	qdisc_class_hash_remove(&q->clhash, &cl->common);
-	qfq_destroy_class(sch, cl);
+	qfq_rm_from_agg(q, cl);
 
 	sch_tree_unlock(sch);
 
+	qfq_destroy_class(sch, cl);
 	return 0;
 }
 
@@ -1506,6 +1504,7 @@ static void qfq_destroy_qdisc(struct Qdisc *sch)
 	for (i = 0; i < q->clhash.hashsize; i++) {
 		hlist_for_each_entry_safe(cl, next, &q->clhash.hash[i],
 					  common.hnode) {
+			qfq_rm_from_agg(q, cl);
 			qfq_destroy_class(sch, cl);
 		}
 	}
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 98f1e2b67c76..b95d882f9dbc 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -874,7 +874,7 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 		return -EINVAL;
 	}
 
-	if (p.collect_md) {
+	if (p.collect_md || xi->p.collect_md) {
 		NL_SET_ERR_MSG(extack, "collect_md can't be changed");
 		return -EINVAL;
 	}
@@ -885,11 +885,6 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 	} else {
 		if (xi->dev != dev)
 			return -EEXIST;
-		if (xi->p.collect_md) {
-			NL_SET_ERR_MSG(extack,
-				       "device can't be changed to collect_md");
-			return -EINVAL;
-		}
 	}
 
 	return xfrmi_update(xi, &p);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 7a298058fc16..ad0fe8849471 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1242,14 +1242,8 @@ static void xfrm_hash_grow_check(struct net *net, int have_hash_collision)
 static void xfrm_state_look_at(struct xfrm_policy *pol, struct xfrm_state *x,
 			       const struct flowi *fl, unsigned short family,
 			       struct xfrm_state **best, int *acq_in_progress,
-			       int *error)
+			       int *error, unsigned int pcpu_id)
 {
-	/* We need the cpu id just as a lookup key,
-	 * we don't require it to be stable.
-	 */
-	unsigned int pcpu_id = get_cpu();
-	put_cpu();
-
 	/* Resolution logic:
 	 * 1. There is a valid state with matching selector. Done.
 	 * 2. Valid state with inappropriate selector. Skip.
@@ -1316,14 +1310,15 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	/* We need the cpu id just as a lookup key,
 	 * we don't require it to be stable.
 	 */
-	pcpu_id = get_cpu();
-	put_cpu();
+	pcpu_id = raw_smp_processor_id();
 
 	to_put = NULL;
 
 	sequence = read_seqcount_begin(&net->xfrm.xfrm_state_hash_generation);
 
 	rcu_read_lock();
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
 	hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
 		if (x->props.family == encap_family &&
 		    x->props.reqid == tmpl->reqid &&
@@ -1335,7 +1330,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, encap_family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 
 	if (best)
@@ -1352,7 +1347,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 
 cached:
@@ -1364,8 +1359,6 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	else if (acquire_in_progress) /* XXX: acquire_in_progress should not happen */
 		WARN_ON(1);
 
-	xfrm_hash_ptrs_get(net, &state_ptrs);
-
 	h = __xfrm_dst_hash(daddr, saddr, tmpl->reqid, encap_family, state_ptrs.hmask);
 	hlist_for_each_entry_rcu(x, state_ptrs.bydst + h, bydst) {
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -1395,7 +1388,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 	if (best || acquire_in_progress)
 		goto found;
@@ -1430,7 +1423,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 
 found:
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index d967e70a7058..12a144a269ee 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -72,6 +72,10 @@
 struct hda_tegra_soc {
 	bool has_hda2codec_2x_reset;
 	bool has_hda2hdmi;
+	bool has_hda2codec_2x;
+	bool input_stream;
+	bool always_on;
+	bool requires_init;
 };
 
 struct hda_tegra {
@@ -187,7 +191,9 @@ static int __maybe_unused hda_tegra_runtime_resume(struct device *dev)
 	if (rc != 0)
 		return rc;
 	if (chip->running) {
-		hda_tegra_init(hda);
+		if (hda->soc->requires_init)
+			hda_tegra_init(hda);
+
 		azx_init_chip(chip, 1);
 		/* disable controller wake up event*/
 		azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
@@ -252,7 +258,8 @@ static int hda_tegra_init_chip(struct azx *chip, struct platform_device *pdev)
 	bus->remap_addr = hda->regs + HDA_BAR0;
 	bus->addr = res->start + HDA_BAR0;
 
-	hda_tegra_init(hda);
+	if (hda->soc->requires_init)
+		hda_tegra_init(hda);
 
 	return 0;
 }
@@ -325,7 +332,7 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	 * starts with offset 0 which is wrong as HW register for output stream
 	 * offset starts with 4.
 	 */
-	if (of_device_is_compatible(np, "nvidia,tegra234-hda"))
+	if (!hda->soc->input_stream)
 		chip->capture_streams = 4;
 
 	chip->playback_streams = (gcap >> 12) & 0x0f;
@@ -421,7 +428,6 @@ static int hda_tegra_create(struct snd_card *card,
 	chip->driver_caps = driver_caps;
 	chip->driver_type = driver_caps & 0xff;
 	chip->dev_index = 0;
-	chip->jackpoll_interval = msecs_to_jiffies(5000);
 	INIT_LIST_HEAD(&chip->pcm_list);
 
 	chip->codec_probe_mask = -1;
@@ -438,7 +444,16 @@ static int hda_tegra_create(struct snd_card *card,
 	chip->bus.core.sync_write = 0;
 	chip->bus.core.needs_damn_long_delay = 1;
 	chip->bus.core.aligned_mmio = 1;
-	chip->bus.jackpoll_in_suspend = 1;
+
+	/*
+	 * HDA power domain and clocks are always on for Tegra264 and
+	 * the jack detection logic would work always, so no need of
+	 * jack polling mechanism running.
+	 */
+	if (!hda->soc->always_on) {
+		chip->jackpoll_interval = msecs_to_jiffies(5000);
+		chip->bus.jackpoll_in_suspend = 1;
+	}
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err < 0) {
@@ -452,22 +467,44 @@ static int hda_tegra_create(struct snd_card *card,
 static const struct hda_tegra_soc tegra30_data = {
 	.has_hda2codec_2x_reset = true,
 	.has_hda2hdmi = true,
+	.has_hda2codec_2x = true,
+	.input_stream = true,
+	.always_on = false,
+	.requires_init = true,
 };
 
 static const struct hda_tegra_soc tegra194_data = {
 	.has_hda2codec_2x_reset = false,
 	.has_hda2hdmi = true,
+	.has_hda2codec_2x = true,
+	.input_stream = true,
+	.always_on = false,
+	.requires_init = true,
 };
 
 static const struct hda_tegra_soc tegra234_data = {
 	.has_hda2codec_2x_reset = true,
 	.has_hda2hdmi = false,
+	.has_hda2codec_2x = true,
+	.input_stream = false,
+	.always_on = false,
+	.requires_init = true,
+};
+
+static const struct hda_tegra_soc tegra264_data = {
+	.has_hda2codec_2x_reset = true,
+	.has_hda2hdmi = false,
+	.has_hda2codec_2x = false,
+	.input_stream = false,
+	.always_on = true,
+	.requires_init = false,
 };
 
 static const struct of_device_id hda_tegra_match[] = {
 	{ .compatible = "nvidia,tegra30-hda", .data = &tegra30_data },
 	{ .compatible = "nvidia,tegra194-hda", .data = &tegra194_data },
 	{ .compatible = "nvidia,tegra234-hda", .data = &tegra234_data },
+	{ .compatible = "nvidia,tegra264-hda", .data = &tegra264_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, hda_tegra_match);
@@ -522,7 +559,9 @@ static int hda_tegra_probe(struct platform_device *pdev)
 	hda->clocks[hda->nclocks++].id = "hda";
 	if (hda->soc->has_hda2hdmi)
 		hda->clocks[hda->nclocks++].id = "hda2hdmi";
-	hda->clocks[hda->nclocks++].id = "hda2codec_2x";
+
+	if (hda->soc->has_hda2codec_2x)
+		hda->clocks[hda->nclocks++].id = "hda2codec_2x";
 
 	err = devm_clk_bulk_get(&pdev->dev, hda->nclocks, hda->clocks);
 	if (err < 0)
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 643e0496b093..b05ef4bec660 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4551,6 +4551,9 @@ HDA_CODEC_ENTRY(0x10de002e, "Tegra186 HDMI/DP1", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de002f, "Tegra194 HDMI/DP2", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0030, "Tegra194 HDMI/DP3", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0031, "Tegra234 HDMI/DP", patch_tegra234_hdmi),
+HDA_CODEC_ENTRY(0x10de0033, "SoC 33 HDMI/DP",	patch_tegra234_hdmi),
+HDA_CODEC_ENTRY(0x10de0034, "Tegra264 HDMI/DP",	patch_tegra234_hdmi),
+HDA_CODEC_ENTRY(0x10de0035, "SoC 35 HDMI/DP",	patch_tegra234_hdmi),
 HDA_CODEC_ENTRY(0x10de0040, "GPU 40 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0041, "GPU 41 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0042, "GPU 42 HDMI/DP",	patch_nvhdmi),
@@ -4589,15 +4592,32 @@ HDA_CODEC_ENTRY(0x10de0097, "GPU 97 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0098, "GPU 98 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0099, "GPU 99 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009a, "GPU 9a HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de009b, "GPU 9b HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de009c, "GPU 9c HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009d, "GPU 9d HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009e, "GPU 9e HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009f, "GPU 9f HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a0, "GPU a0 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a1, "GPU a1 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a3, "GPU a3 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a4, "GPU a4 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a5, "GPU a5 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a6, "GPU a6 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a7, "GPU a7 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a8, "GPU a8 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a9, "GPU a9 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00aa, "GPU aa HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00ab, "GPU ab HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00ad, "GPU ad HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00ae, "GPU ae HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00af, "GPU af HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00b0, "GPU b0 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00b1, "GPU b1 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c0, "GPU c0 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c1, "GPU c1 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c3, "GPU c3 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c4, "GPU c4 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c5, "GPU c5 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de8001, "MCP73 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x10de8067, "MCP67/68 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x67663d82, "Arise 82 HDMI/DP",	patch_gf_hdmi),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f033214bf77f..085f0697bff1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4755,7 +4755,7 @@ static void alc245_fixup_hp_mute_led_v1_coefbit(struct hda_codec *codec,
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->mute_led_polarity = 0;
 		spec->mute_led_coef.idx = 0x0b;
-		spec->mute_led_coef.mask = 1 << 3;
+		spec->mute_led_coef.mask = 3 << 2;
 		spec->mute_led_coef.on = 1 << 3;
 		spec->mute_led_coef.off = 0;
 		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
@@ -10608,6 +10608,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87cc, "HP Pavilion 15-eg0xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87df, "HP ProBook 430 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
@@ -10686,6 +10687,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a2e, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a30, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a31, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8a4f, "HP Victus 15-fa0xxx (MB 8A4F)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a6e, "HP EDNA 360", ALC287_FIXUP_CS35L41_I2C_4),
 	SND_PCI_QUIRK(0x103c, 0x8a74, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
diff --git a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
index 11b9a5bc7163..89575bb8afed 100644
--- a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
+++ b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
@@ -812,11 +812,10 @@ static const struct snd_soc_dapm_route mtk_dai_i2s_routes[] = {
 static int mt8365_dai_i2s_set_priv(struct mtk_base_afe *afe)
 {
 	int i, ret;
-	struct mt8365_afe_private *afe_priv = afe->platform_priv;
 
 	for (i = 0; i < DAI_I2S_NUM; i++) {
 		ret = mt8365_dai_set_priv(afe, mt8365_i2s_priv[i].id,
-					  sizeof(*afe_priv),
+					  sizeof(mt8365_i2s_priv[i]),
 					  &mt8365_i2s_priv[i]);
 		if (ret)
 			return ret;
diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 12743d7f164f..9caa24caa080 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -62,8 +62,11 @@ static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
 
 	filesize = 0;
 	p = path_name;
-	snprintf(target_fname, sizeof(target_fname), "%s/%s",
-		 path_name, file_name);
+	if (snprintf(target_fname, sizeof(target_fname), "%s/%s",
+		     path_name, file_name) >= sizeof(target_fname)) {
+		syslog(LOG_ERR, "target file name is too long: %s/%s", path_name, file_name);
+		goto done;
+	}
 
 	/*
 	 * Check to see if the path is already in place; if not,
@@ -270,7 +273,7 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
 {
 	size_t len = 0;
 
-	while (len < dest_size) {
+	while (len < dest_size && *src) {
 		if (src[len] < 0x80)
 			dest[len++] = (char)(*src++);
 		else
@@ -282,27 +285,15 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
 
 static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
 {
-	setlocale(LC_ALL, "en_US.utf8");
-	size_t file_size, path_size;
-	char *file_name, *path_name;
-	char *in_file_name = (char *)smsg_in->file_name;
-	char *in_path_name = (char *)smsg_in->path_name;
-
-	file_size = wcstombs(NULL, (const wchar_t *restrict)in_file_name, 0) + 1;
-	path_size = wcstombs(NULL, (const wchar_t *restrict)in_path_name, 0) + 1;
-
-	file_name = (char *)malloc(file_size * sizeof(char));
-	path_name = (char *)malloc(path_size * sizeof(char));
-
-	if (!file_name || !path_name) {
-		free(file_name);
-		free(path_name);
-		syslog(LOG_ERR, "Can't allocate memory for file name and/or path name");
-		return HV_E_FAIL;
-	}
+	/*
+	 * file_name and path_name should have same length with appropriate
+	 * member of hv_start_fcopy.
+	 */
+	char file_name[W_MAX_PATH], path_name[W_MAX_PATH];
 
-	wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
-	wcstoutf8(path_name, (__u16 *)in_path_name, path_size);
+	setlocale(LC_ALL, "en_US.utf8");
+	wcstoutf8(file_name, smsg_in->file_name, W_MAX_PATH - 1);
+	wcstoutf8(path_name, smsg_in->path_name, W_MAX_PATH - 1);
 
 	return hv_fcopy_create_file(file_name, path_name, smsg_in->copy_flags);
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 6b564d4c0986..051d1962a4c7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -130,4 +130,57 @@ __naked int state_loop_first_last_equal(void)
 	);
 }
 
+__used __naked static void __bpf_cond_op_r10(void)
+{
+	asm volatile (
+	"r2 = 2314885393468386424 ll;"
+	"goto +0;"
+	"if r2 <= r10 goto +3;"
+	"if r1 >= -1835016 goto +0;"
+	"if r2 <= 8 goto +0;"
+	"if r3 <= 0 goto +0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("8: (bd) if r2 <= r10 goto pc+3")
+__msg("9: (35) if r1 >= 0xffe3fff8 goto pc+0")
+__msg("10: (b5) if r2 <= 0x8 goto pc+0")
+__msg("mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame1: regs=r2 stack= before 9: (35) if r1 >= 0xffe3fff8 goto pc+0")
+__msg("mark_precise: frame1: regs=r2 stack= before 8: (bd) if r2 <= r10 goto pc+3")
+__msg("mark_precise: frame1: regs=r2 stack= before 7: (05) goto pc+0")
+__naked void bpf_cond_op_r10(void)
+{
+	asm volatile (
+	"r3 = 0 ll;"
+	"call __bpf_cond_op_r10;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("3: (bf) r3 = r10")
+__msg("4: (bd) if r3 <= r2 goto pc+1")
+__msg("5: (b5) if r2 <= 0x8 goto pc+2")
+__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r2 stack= before 4: (bd) if r3 <= r2 goto pc+1")
+__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r3 = r10")
+__naked void bpf_cond_op_not_r10(void)
+{
+	asm volatile (
+	"r0 = 0;"
+	"r2 = 2314885393468386424 ll;"
+	"r3 = r10;"
+	"if r3 <= r2 goto +1;"
+	"if r2 <= 8 goto +2;"
+	"r0 = 2 ll;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index d9c10613ae67..44151b7b1a24 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import re
 import time
 
 from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
@@ -10,12 +11,11 @@ class GenerateTraffic:
 
         self.env = env
 
-        if port is None:
-            port = rand_port()
-        self._iperf_server = cmd(f"iperf3 -s -1 -p {port}", background=True)
-        wait_port_listen(port)
+        self.port = rand_port() if port is None else port
+        self._iperf_server = cmd(f"iperf3 -s -1 -p {self.port}", background=True)
+        wait_port_listen(self.port)
         time.sleep(0.1)
-        self._iperf_client = cmd(f"iperf3 -c {env.addr} -P 16 -p {port} -t 86400",
+        self._iperf_client = cmd(f"iperf3 -c {env.addr} -P 16 -p {self.port} -t 86400",
                                  background=True, host=env.remote)
 
         # Wait for traffic to ramp up
@@ -56,3 +56,16 @@ class GenerateTraffic:
             ksft_pr(">> Server:")
             ksft_pr(self._iperf_server.stdout)
             ksft_pr(self._iperf_server.stderr)
+        self._wait_client_stopped()
+
+    def _wait_client_stopped(self, sleep=0.005, timeout=5):
+        end = time.monotonic() + timeout
+
+        live_port_pattern = re.compile(fr":{self.port:04X} 0[^6] ")
+
+        while time.monotonic() < end:
+            data = cmd("cat /proc/net/tcp*", host=self.env.remote).stdout
+            if not live_port_pattern.search(data):
+                return
+            time.sleep(sleep)
+        raise Exception(f"Waiting for client to stop timed out after {timeout}s")
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 580610c46e5a..4524085784df 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -4,7 +4,8 @@ top_srcdir = ../../../../..
 
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
-TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
+TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
+	      mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
new file mode 100644
index 000000000000..ce93ec2f107f
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -C "${@}"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
new file mode 100644
index 000000000000..5dd30f9394af
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m mmap "${@}"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
new file mode 100644
index 000000000000..1d16fb1cc9bb
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m sendfile "${@}"

