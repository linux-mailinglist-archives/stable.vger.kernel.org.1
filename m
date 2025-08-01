Return-Path: <stable+bounces-165721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547CAB17F5C
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 11:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C6217208E
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 09:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8CB22F74F;
	Fri,  1 Aug 2025 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OdK7pqDD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE3522B5A3;
	Fri,  1 Aug 2025 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040792; cv=none; b=B+XETgPGU3Tx6upoGcLx5pIbmnWlEu/YQLzFystf9oSidAMT3smbs64jN0iK7AZHiUApP7Kg0SxkvUaIwNzO1SLtEcwFHR26Tk4ylEBxFUf/IgvUqItNq0esV9ja5phZu8QgDBCSPNA/gEL/7aMmyVrcbTIR9QMcPvNBUQeMLoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040792; c=relaxed/simple;
	bh=HjGFWGS/pE/umjZ1cNB4WeuNkBckHvuZMqxTzCyXyzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riZjUwl8MJ8jB2qaZChWhax36kJOqd30hvWrYa/jej01ZpdOuscxFZnjNFA5SkfMgsHhXJSLV10w6ikTXOLS2OwctfwtsQMaSPLZR6AxqDdMzH2/ReJqWHJcEVbw2g82jFnxFHUlywiTNp2h0AeHG1cHkSunQOPHpfTzGgZLQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OdK7pqDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1122C4CEE7;
	Fri,  1 Aug 2025 09:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754040789;
	bh=HjGFWGS/pE/umjZ1cNB4WeuNkBckHvuZMqxTzCyXyzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdK7pqDDuZeM9hLtWN/0g6lOG4w4wTI25xvq0qik+MPOFvvhhP+ZQNbITRwYPDqTB
	 BXaXiimMxwpgs9IvuZknwO0l/kyt/aEV4SBcDQ9NCxj7pc1P7VblJxAbVxFvDDMhv1
	 /D7yec26ET8oFCEgOFh9R8KYE8tKhfkzBU6tGb/M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.15.9
Date: Fri,  1 Aug 2025 10:32:57 +0100
Message-ID: <2025080157-recollect-untamed-1d59@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025080157-pancreas-fleshed-73c0@gregkh>
References: <2025080157-pancreas-fleshed-73c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 8e2d03723368..d38a669b3ada 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 15
-SUBLEVEL = 8
+SUBLEVEL = 9
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 25ed6f1a7c7a..e55a3fee104a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -121,7 +121,7 @@ config ARM
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
 	select HAVE_KRETPROBES if HAVE_KPROBES
-	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_CAN_USE_KEEP_IN_OVERLAY)
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_IS_LLD) && LD_CAN_USE_KEEP_IN_OVERLAY
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_OPTPROBES if !THUMB2_KERNEL
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4808d3ed98e4..e31e95ffd33f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -149,7 +149,7 @@ endif
 # Need -Uarm for gcc < 3.x
 KBUILD_CPPFLAGS	+=$(cpp-y)
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -include $(srctree)/arch/arm/include/asm/unified.h -msoft-float
 KBUILD_RUSTFLAGS += --target=arm-unknown-linux-gnueabi
 
 CHECKFLAGS	+= -D__arm__
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index ad63457a05c5..c56c21bb1eec 100644
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
index 5ae2a34b50bd..30dcb719685b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -825,6 +825,7 @@ SYM_CODE_END(__bp_harden_el1_vectors)
  *
  */
 SYM_FUNC_START(cpu_switch_to)
+	save_and_disable_daif x11
 	mov	x10, #THREAD_CPU_CONTEXT
 	add	x8, x0, x10
 	mov	x9, sp
@@ -848,6 +849,7 @@ SYM_FUNC_START(cpu_switch_to)
 	ptrauth_keys_install_kernel x1, x8, x9, x10
 	scs_save x0
 	scs_load_current
+	restore_irq x11
 	ret
 SYM_FUNC_END(cpu_switch_to)
 NOKPROBE(cpu_switch_to)
@@ -874,6 +876,7 @@ NOKPROBE(ret_from_fork)
  * Calls func(regs) using this CPU's irq stack and shadow irq stack.
  */
 SYM_FUNC_START(call_on_irq_stack)
+	save_and_disable_daif x9
 #ifdef CONFIG_SHADOW_CALL_STACK
 	get_current_task x16
 	scs_save x16
@@ -888,8 +891,10 @@ SYM_FUNC_START(call_on_irq_stack)
 
 	/* Move to the new stack and call the function there */
 	add	sp, x16, #IRQ_STACK_SIZE
+	restore_irq x9
 	blr	x1
 
+	save_and_disable_daif x9
 	/*
 	 * Restore the SP from the FP, and restore the FP and LR from the frame
 	 * record.
@@ -897,6 +902,7 @@ SYM_FUNC_START(call_on_irq_stack)
 	mov	sp, x29
 	ldp	x29, x30, [sp], #16
 	scs_load_current
+	restore_irq x9
 	ret
 SYM_FUNC_END(call_on_irq_stack)
 NOKPROBE(call_on_irq_stack)
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 31f0d29cbc5e..e28c317ac9e8 100644
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
index f094493232b6..8980786686bf 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -31,6 +31,7 @@
 
 #include <asm/apic.h>
 #include <asm/pvclock-abi.h>
+#include <asm/debugreg.h>
 #include <asm/desc.h>
 #include <asm/mtrr.h>
 #include <asm/msr-index.h>
@@ -247,7 +248,6 @@ enum x86_intercept_stage;
 #define DR7_BP_EN_MASK	0x000000ff
 #define DR7_GE		(1 << 9)
 #define DR7_GD		(1 << 13)
-#define DR7_FIXED_1	0x00000400
 #define DR7_VOLATILE	0xffff2bff
 
 #define KVM_GUESTDBG_VALID_MASK \
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c39c5c37f4e8..bab44900b937 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2220,7 +2220,7 @@ EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 static void initialize_debug_regs(void)
 {
 	/* Control register first -- to make sure everything is disabled. */
-	set_debugreg(0, 7);
+	set_debugreg(DR7_FIXED_1, 7);
 	set_debugreg(DR6_RESERVED, 6);
 	/* dr5 and dr4 don't exist */
 	set_debugreg(0, 3);
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 102641fd2172..8b1a9733d13e 100644
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
index 4636ef359973..3c7621663800 100644
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
index 7196ca7048be..8565aa31afaf 100644
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
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index be7bb6d20129..7bae91eb7b23 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10979,7 +10979,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		wrmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
 
 	if (unlikely(vcpu->arch.switch_db_regs)) {
-		set_debugreg(0, 7);
+		set_debugreg(DR7_FIXED_1, 7);
 		set_debugreg(vcpu->arch.eff_db[0], 0);
 		set_debugreg(vcpu->arch.eff_db[1], 1);
 		set_debugreg(vcpu->arch.eff_db[2], 2);
@@ -10988,7 +10988,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
 			kvm_x86_call(set_dr6)(vcpu, vcpu->arch.dr6);
 	} else if (unlikely(hw_breakpoint_active())) {
-		set_debugreg(0, 7);
+		set_debugreg(DR7_FIXED_1, 7);
 	}
 
 	vcpu->arch.host_debugctl = get_debugctlmsr();
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index f2843f814675..1f3f782a04ba 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1173,6 +1173,8 @@ struct regmap *__regmap_init(struct device *dev,
 err_map:
 	kfree(map);
 err:
+	if (bus && bus->free_on_exit)
+		kfree(bus);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(__regmap_init);
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 7671bd158545..c1c0a4759c7e 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -943,6 +943,7 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 	struct fsl_mc_obj_desc endpoint_desc = {{ 0 }};
 	struct dprc_endpoint endpoint1 = {{ 0 }};
 	struct dprc_endpoint endpoint2 = {{ 0 }};
+	struct fsl_mc_bus *mc_bus;
 	int state, err;
 
 	mc_bus_dev = to_fsl_mc_device(mc_dev->dev.parent);
@@ -966,6 +967,8 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 	strcpy(endpoint_desc.type, endpoint2.type);
 	endpoint_desc.id = endpoint2.id;
 	endpoint = fsl_mc_device_lookup(&endpoint_desc, mc_bus_dev);
+	if (endpoint)
+		return endpoint;
 
 	/*
 	 * We know that the device has an endpoint because we verified by
@@ -973,17 +976,13 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 82a22a62b99b..5a074e4b4780 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5123,6 +5123,8 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		dev->dev->power.disable_depth--;
 #endif
 	}
+
+	amdgpu_vram_mgr_clear_reset_blocks(adev);
 	adev->in_suspend = false;
 
 	if (adev->enable_mes)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 529c9696c2f3..c2242bd5ecc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -26,6 +26,8 @@
 #include "amdgpu_sdma.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
+#include "gc/gc_10_1_0_offset.h"
+#include "gc/gc_10_3_0_sh_mask.h"
 
 #define AMDGPU_CSA_SDMA_SIZE 64
 /* SDMA CSA reside in the 3rd page of CSA */
@@ -561,10 +563,46 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
 	list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
 }
 
+static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
+{
+	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
+	int r = -EOPNOTSUPP;
+
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(4, 4, 2):
+	case IP_VERSION(4, 4, 4):
+	case IP_VERSION(4, 4, 5):
+		/* For SDMA 4.x, use the existing DPM interface for backward compatibility,
+		 * we need to convert the logical instance ID to physical instance ID before reset.
+		 */
+		r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, instance_id));
+		break;
+	case IP_VERSION(5, 0, 0):
+	case IP_VERSION(5, 0, 1):
+	case IP_VERSION(5, 0, 2):
+	case IP_VERSION(5, 0, 5):
+	case IP_VERSION(5, 2, 0):
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 4):
+	case IP_VERSION(5, 2, 5):
+	case IP_VERSION(5, 2, 6):
+	case IP_VERSION(5, 2, 3):
+	case IP_VERSION(5, 2, 1):
+	case IP_VERSION(5, 2, 7):
+		if (sdma_instance->funcs->soft_reset_kernel_queue)
+			r = sdma_instance->funcs->soft_reset_kernel_queue(adev, instance_id);
+		break;
+	default:
+		break;
+	}
+
+	return r;
+}
+
 /**
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
- * @instance_id: ID of the SDMA engine instance to reset
+ * @instance_id: Logical ID of the SDMA engine instance to reset
  *
  * This function performs the following steps:
  * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
@@ -611,9 +649,9 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	}
 
 	/* Perform the SDMA reset for the specified instance */
-	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+	ret = amdgpu_sdma_soft_reset(adev, instance_id);
 	if (ret) {
-		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
+		dev_err(adev->dev, "Failed to reset SDMA logical instance %u\n", instance_id);
 		goto exit;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 47d56fd0589f..bf83d6646238 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -50,6 +50,12 @@ enum amdgpu_sdma_irq {
 
 #define NUM_SDMA(x) hweight32(x)
 
+struct amdgpu_sdma_funcs {
+	int (*stop_kernel_queue)(struct amdgpu_ring *ring);
+	int (*start_kernel_queue)(struct amdgpu_ring *ring);
+	int (*soft_reset_kernel_queue)(struct amdgpu_device *adev, u32 instance_id);
+};
+
 struct amdgpu_sdma_instance {
 	/* SDMA firmware */
 	const struct firmware	*fw;
@@ -68,7 +74,7 @@ struct amdgpu_sdma_instance {
 	/* track guilty state of GFX and PAGE queues */
 	bool			gfx_guilty;
 	bool			page_guilty;
-
+	const struct amdgpu_sdma_funcs   *funcs;
 };
 
 enum amdgpu_sdma_ras_memory_id {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 208b7d1d8a27..450e4bf093b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -154,6 +154,7 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
 				  uint64_t start, uint64_t size);
 int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
 				      uint64_t start);
+void amdgpu_vram_mgr_clear_reset_blocks(struct amdgpu_device *adev);
 
 bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
 			    struct ttm_resource *res);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index abdc52b0895a..07c936e90d8e 100644
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
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 87c2bc5f64a6..f6d71bf7c89c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3548,13 +3548,15 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 
 	luminance_range = &conn_base->display_info.luminance_range;
 
-	if (luminance_range->max_luminance) {
-		caps->aux_min_input_signal = luminance_range->min_luminance;
+	if (luminance_range->max_luminance)
 		caps->aux_max_input_signal = luminance_range->max_luminance;
-	} else {
-		caps->aux_min_input_signal = 0;
+	else
 		caps->aux_max_input_signal = 512;
-	}
+
+	if (luminance_range->min_luminance)
+		caps->aux_min_input_signal = luminance_range->min_luminance;
+	else
+		caps->aux_min_input_signal = 1;
 
 	min_input_signal_override = drm_get_panel_min_brightness_quirk(aconnector->drm_edid);
 	if (min_input_signal_override >= 0)
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 4ea13e5a3a54..48766b6abd29 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1351,7 +1351,7 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 			regmap_update_bits(pdata->regmap, SN_HPD_DISABLE_REG,
 					   HPD_DISABLE, 0);
 		mutex_unlock(&pdata->comms_mutex);
-	};
+	}
 
 	drm_bridge_add(&pdata->bridge);
 
diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index 241c855f891f..66aff35f8647 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -404,6 +404,49 @@ drm_get_buddy(struct drm_buddy_block *block)
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
diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
index b7f033d4352a..4f0320df858f 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -230,7 +230,7 @@ void drm_gem_dma_free(struct drm_gem_dma_object *dma_obj)
 
 	if (drm_gem_is_imported(gem_obj)) {
 		if (dma_obj->vaddr)
-			dma_buf_vunmap_unlocked(gem_obj->dma_buf, &map);
+			dma_buf_vunmap_unlocked(gem_obj->import_attach->dmabuf, &map);
 		drm_prime_gem_destroy(gem_obj, dma_obj->sgt);
 	} else if (dma_obj->vaddr) {
 		if (dma_obj->map_noncoherent)
diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
index 0fbeb686e561..2bf606ba24cd 100644
--- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
+++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
@@ -419,6 +419,7 @@ EXPORT_SYMBOL(drm_gem_fb_vunmap);
 static void __drm_gem_fb_end_cpu_access(struct drm_framebuffer *fb, enum dma_data_direction dir,
 					unsigned int num_planes)
 {
+	struct dma_buf_attachment *import_attach;
 	struct drm_gem_object *obj;
 	int ret;
 
@@ -427,9 +428,10 @@ static void __drm_gem_fb_end_cpu_access(struct drm_framebuffer *fb, enum dma_dat
 		obj = drm_gem_fb_get_obj(fb, num_planes);
 		if (!obj)
 			continue;
+		import_attach = obj->import_attach;
 		if (!drm_gem_is_imported(obj))
 			continue;
-		ret = dma_buf_end_cpu_access(obj->dma_buf, dir);
+		ret = dma_buf_end_cpu_access(import_attach->dmabuf, dir);
 		if (ret)
 			drm_err(fb->dev, "dma_buf_end_cpu_access(%u, %d) failed: %d\n",
 				ret, num_planes, dir);
@@ -452,6 +454,7 @@ static void __drm_gem_fb_end_cpu_access(struct drm_framebuffer *fb, enum dma_dat
  */
 int drm_gem_fb_begin_cpu_access(struct drm_framebuffer *fb, enum dma_data_direction dir)
 {
+	struct dma_buf_attachment *import_attach;
 	struct drm_gem_object *obj;
 	unsigned int i;
 	int ret;
@@ -462,9 +465,10 @@ int drm_gem_fb_begin_cpu_access(struct drm_framebuffer *fb, enum dma_data_direct
 			ret = -EINVAL;
 			goto err___drm_gem_fb_end_cpu_access;
 		}
+		import_attach = obj->import_attach;
 		if (!drm_gem_is_imported(obj))
 			continue;
-		ret = dma_buf_begin_cpu_access(obj->dma_buf, dir);
+		ret = dma_buf_begin_cpu_access(import_attach->dmabuf, dir);
 		if (ret)
 			goto err___drm_gem_fb_end_cpu_access;
 	}
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index d99dee67353a..37333aadd550 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -339,13 +339,7 @@ int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
 	int ret = 0;
 
 	if (drm_gem_is_imported(obj)) {
-		ret = dma_buf_vmap(obj->dma_buf, map);
-		if (!ret) {
-			if (drm_WARN_ON(obj->dev, map->is_iomem)) {
-				dma_buf_vunmap(obj->dma_buf, map);
-				return -EIO;
-			}
-		}
+		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
 	} else {
 		pgprot_t prot = PAGE_KERNEL;
 
@@ -405,7 +399,7 @@ void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem,
 	struct drm_gem_object *obj = &shmem->base;
 
 	if (drm_gem_is_imported(obj)) {
-		dma_buf_vunmap(obj->dma_buf, map);
+		dma_buf_vunmap(obj->import_attach->dmabuf, map);
 	} else {
 		dma_resv_assert_held(shmem->base.resv);
 
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index bdb51c8f262e..32a8781cfd67 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -453,7 +453,13 @@ struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
 	}
 
 	mutex_lock(&dev->object_name_lock);
-	/* re-export the original imported/exported object */
+	/* re-export the original imported object */
+	if (obj->import_attach) {
+		dmabuf = obj->import_attach->dmabuf;
+		get_dma_buf(dmabuf);
+		goto out_have_obj;
+	}
+
 	if (obj->dma_buf) {
 		get_dma_buf(obj->dma_buf);
 		dmabuf = obj->dma_buf;
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index ad0306283990..ba29efae986d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1603,6 +1603,12 @@ int intel_dp_rate_select(struct intel_dp *intel_dp, int rate)
 void intel_dp_compute_rate(struct intel_dp *intel_dp, int port_clock,
 			   u8 *link_bw, u8 *rate_select)
 {
+	struct intel_display *display = to_intel_display(intel_dp);
+
+	/* FIXME g4x can't generate an exact 2.7GHz with the 96MHz non-SSC refclk */
+	if (display->platform.g4x && port_clock == 268800)
+		port_clock = 270000;
+
 	/* eDP 1.4 rate select method. */
 	if (intel_dp->use_rate_select) {
 		*link_bw = 0;
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index e671aa241720..ac678de7fe5e 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -355,17 +355,6 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity)
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
  * drm_sched_entity_wakeup - callback to clear the entity's dependency and
  * wake up the scheduler
@@ -376,7 +365,8 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
 	struct drm_sched_entity *entity =
 		container_of(cb, struct drm_sched_entity, cb);
 
-	drm_sched_entity_clear_dep(f, cb);
+	entity->dependency = NULL;
+	dma_fence_put(f);
 	drm_sched_wakeup(entity->rq->sched);
 }
 
@@ -429,13 +419,6 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
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
diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index 16e20b5ad325..c3c9df8ba7bb 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -39,6 +39,7 @@
 #define LRC_ENGINE_INSTANCE			GENMASK_ULL(53, 48)
 
 #define LRC_INDIRECT_RING_STATE_SIZE		SZ_4K
+#define LRC_WA_BB_SIZE				SZ_4K
 
 static struct xe_device *
 lrc_to_xe(struct xe_lrc *lrc)
@@ -910,7 +911,11 @@ static void xe_lrc_finish(struct xe_lrc *lrc)
 	xe_bo_unpin(lrc->bo);
 	xe_bo_unlock(lrc->bo);
 	xe_bo_put(lrc->bo);
-	xe_bo_unpin_map_no_vm(lrc->bb_per_ctx_bo);
+}
+
+static size_t wa_bb_offset(struct xe_lrc *lrc)
+{
+	return lrc->bo->size - LRC_WA_BB_SIZE;
 }
 
 /*
@@ -943,15 +948,16 @@ static void xe_lrc_finish(struct xe_lrc *lrc)
 #define CONTEXT_ACTIVE 1ULL
 static int xe_lrc_setup_utilization(struct xe_lrc *lrc)
 {
+	const size_t max_size = LRC_WA_BB_SIZE;
 	u32 *cmd, *buf = NULL;
 
-	if (lrc->bb_per_ctx_bo->vmap.is_iomem) {
-		buf = kmalloc(lrc->bb_per_ctx_bo->size, GFP_KERNEL);
+	if (lrc->bo->vmap.is_iomem) {
+		buf = kmalloc(max_size, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
 		cmd = buf;
 	} else {
-		cmd = lrc->bb_per_ctx_bo->vmap.vaddr;
+		cmd = lrc->bo->vmap.vaddr + wa_bb_offset(lrc);
 	}
 
 	*cmd++ = MI_STORE_REGISTER_MEM | MI_SRM_USE_GGTT | MI_SRM_ADD_CS_OFFSET;
@@ -974,13 +980,14 @@ static int xe_lrc_setup_utilization(struct xe_lrc *lrc)
 	*cmd++ = MI_BATCH_BUFFER_END;
 
 	if (buf) {
-		xe_map_memcpy_to(gt_to_xe(lrc->gt), &lrc->bb_per_ctx_bo->vmap, 0,
-				 buf, (cmd - buf) * sizeof(*cmd));
+		xe_map_memcpy_to(gt_to_xe(lrc->gt), &lrc->bo->vmap,
+				 wa_bb_offset(lrc), buf,
+				 (cmd - buf) * sizeof(*cmd));
 		kfree(buf);
 	}
 
-	xe_lrc_write_ctx_reg(lrc, CTX_BB_PER_CTX_PTR,
-			     xe_bo_ggtt_addr(lrc->bb_per_ctx_bo) | 1);
+	xe_lrc_write_ctx_reg(lrc, CTX_BB_PER_CTX_PTR, xe_bo_ggtt_addr(lrc->bo) +
+			     wa_bb_offset(lrc) + 1);
 
 	return 0;
 }
@@ -1016,20 +1023,13 @@ static int xe_lrc_init(struct xe_lrc *lrc, struct xe_hw_engine *hwe,
 	 * FIXME: Perma-pinning LRC as we don't yet support moving GGTT address
 	 * via VM bind calls.
 	 */
-	lrc->bo = xe_bo_create_pin_map(xe, tile, vm, lrc_size,
+	lrc->bo = xe_bo_create_pin_map(xe, tile, vm,
+				       lrc_size + LRC_WA_BB_SIZE,
 				       ttm_bo_type_kernel,
 				       bo_flags);
 	if (IS_ERR(lrc->bo))
 		return PTR_ERR(lrc->bo);
 
-	lrc->bb_per_ctx_bo = xe_bo_create_pin_map(xe, tile, NULL, SZ_4K,
-						  ttm_bo_type_kernel,
-						  bo_flags);
-	if (IS_ERR(lrc->bb_per_ctx_bo)) {
-		err = PTR_ERR(lrc->bb_per_ctx_bo);
-		goto err_lrc_finish;
-	}
-
 	lrc->size = lrc_size;
 	lrc->ring.size = ring_size;
 	lrc->ring.tail = 0;
@@ -1819,7 +1819,8 @@ struct xe_lrc_snapshot *xe_lrc_snapshot_capture(struct xe_lrc *lrc)
 	snapshot->seqno = xe_lrc_seqno(lrc);
 	snapshot->lrc_bo = xe_bo_get(lrc->bo);
 	snapshot->lrc_offset = xe_lrc_pphwsp_offset(lrc);
-	snapshot->lrc_size = lrc->bo->size - snapshot->lrc_offset;
+	snapshot->lrc_size = lrc->bo->size - snapshot->lrc_offset -
+		LRC_WA_BB_SIZE;
 	snapshot->lrc_snapshot = NULL;
 	snapshot->ctx_timestamp = lower_32_bits(xe_lrc_ctx_timestamp(lrc));
 	snapshot->ctx_job_timestamp = xe_lrc_ctx_job_timestamp(lrc);
diff --git a/drivers/gpu/drm/xe/xe_lrc_types.h b/drivers/gpu/drm/xe/xe_lrc_types.h
index ae24cf6f8dd9..883e550a9423 100644
--- a/drivers/gpu/drm/xe/xe_lrc_types.h
+++ b/drivers/gpu/drm/xe/xe_lrc_types.h
@@ -53,9 +53,6 @@ struct xe_lrc {
 
 	/** @ctx_timestamp: readout value of CTX_TIMESTAMP on last update */
 	u64 ctx_timestamp;
-
-	/** @bb_per_ctx_bo: buffer object for per context batch wa buffer */
-	struct xe_bo *bb_per_ctx_bo;
 };
 
 struct xe_lrc_snapshot;
diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 3a36d682ed57..5b053e51f4c9 100644
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
index 049b4d154c23..687d1e608abc 100644
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
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index b9f4113ae5fc..ebf17ea5a5f9 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -410,12 +410,15 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 	char buf[80];
 	int ret;
 
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
 				     count);
 	if (ret < 0)
 		return ret;
 
-	buf[count] = '\0';
+	buf[ret] = '\0';
 
 	ret = sscanf(buf, "%i %i", &reg, &val);
 
diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 9979a351577f..81cf3c902e81 100644
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
 
diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index 88f311c11020..93c030608d3e 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -117,6 +117,7 @@ struct icc_provider *icc_clk_register(struct device *dev,
 
 		node->name = devm_kasprintf(dev, GFP_KERNEL, "%s_master", data[i].name);
 		if (!node->name) {
+			icc_node_destroy(node->id);
 			ret = -ENOMEM;
 			goto err;
 		}
@@ -135,6 +136,7 @@ struct icc_provider *icc_clk_register(struct device *dev,
 
 		node->name = devm_kasprintf(dev, GFP_KERNEL, "%s_slave", data[i].name);
 		if (!node->name) {
+			icc_node_destroy(node->id);
 			ret = -ENOMEM;
 			goto err;
 		}
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 346f18d70e9e..905403a3a930 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -238,6 +238,7 @@ static struct qcom_icc_node xm_pcie3_1 = {
 	.id = SC7280_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
+	.num_links = 1,
 	.links = { SC7280_SLAVE_ANOC_PCIE_GEM_NOC },
 };
 
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 5ec3170b896a..3fa805ac2c65 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -145,13 +145,16 @@ void can_change_state(struct net_device *dev, struct can_frame *cf,
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
 
@@ -173,10 +176,14 @@ static void can_restart(struct net_device *dev)
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
@@ -201,9 +208,8 @@ int can_restart_now(struct net_device *dev)
 		return -EBUSY;
 
 	cancel_delayed_work_sync(&priv->restart_work);
-	can_restart(dev);
 
-	return 0;
+	return can_restart(dev);
 }
 
 /* CAN bus-off
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index f1db9b7ffd4d..d5aa8da87961 100644
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
index 147a93bf9fa9..4643a3380618 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1448,12 +1448,19 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
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
@@ -1483,6 +1490,8 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 	dpaa2_mac_close(mac);
 err_free_mac:
 	kfree(mac);
+out_put_device:
+	put_device(&dpmac_dev->dev);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index d561d45021a5..98f5859b99f8 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1916,49 +1916,56 @@ static void gve_turnup_and_check_status(struct gve_priv *priv)
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
index b03b8758c777..aaa803563bd2 100644
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
index 3e28a08934ab..4ea19c089578 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -9576,33 +9576,36 @@ static bool hclge_need_enable_vport_vlan_filter(struct hclge_vport *vport)
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
@@ -10623,16 +10626,19 @@ static void hclge_sync_vlan_fltr_state(struct hclge_dev *hdev)
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
index ec581d4b696f..4bd52eab3914 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -497,14 +497,14 @@ int hclge_ptp_init(struct hclge_dev *hdev)
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
@@ -512,7 +512,7 @@ int hclge_ptp_init(struct hclge_dev *hdev)
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed to init ts time, ret = %d\n", ret);
-		goto out;
+		goto out_clear_int;
 	}
 
 	set_bit(HCLGE_STATE_PTP_EN, &hdev->state);
@@ -520,6 +520,9 @@ int hclge_ptp_init(struct hclge_dev *hdev)
 
 	return 0;
 
+out_clear_int:
+	clear_bit(HCLGE_PTP_FLAG_EN, &hdev->ptp->flags);
+	hclge_ptp_int_en(hdev, false);
 out:
 	hclge_ptp_destroy_clock(hdev);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index dada42e7e0ec..27d10aeafb2b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -3094,11 +3094,7 @@ static void hclgevf_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 
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
index 88e6bef69342..7ccfc1191ae5 100644
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
index 59323c019544..351824dc3c62 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -2301,6 +2301,8 @@ enum ice_ddp_state ice_copy_and_init_pkg(struct ice_hw *hw, const u8 *buf,
 		return ICE_DDP_PKG_ERR;
 
 	buf_copy = devm_kmemdup(ice_hw_to_dev(hw), buf, len, GFP_KERNEL);
+	if (!buf_copy)
+		return ICE_DDP_PKG_ERR;
 
 	state = ice_init_pkg(hw, buf_copy, len);
 	if (!ice_is_init_pkg_successful(state)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index e53dbdc0a7a1..34256ce5473b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1948,8 +1948,8 @@ static int cmd_exec(struct mlx5_core_dev *dev, void *in, int in_size, void *out,
 
 	err = mlx5_cmd_invoke(dev, inb, outb, out, out_size, callback, context,
 			      pages_queue, token, force_polling);
-	if (callback)
-		return err;
+	if (callback && !err)
+		return 0;
 
 	if (err > 0) /* Failed in FW, command didn't execute */
 		err = deliv_status_to_err(err);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 0e3a977d5332..bee906661282 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1182,19 +1182,19 @@ static void esw_set_peer_miss_rule_source_port(struct mlx5_eswitch *esw,
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
@@ -1203,7 +1203,7 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 
 	peer_miss_rules_setup(esw, peer_dev, spec, &dest);
 
-	flows = kvcalloc(nvports, sizeof(*flows), GFP_KERNEL);
+	flows = kvcalloc(peer_esw->total_vports, sizeof(*flows), GFP_KERNEL);
 	if (!flows) {
 		err = -ENOMEM;
 		goto alloc_flows_err;
@@ -1213,10 +1213,10 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
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
@@ -1224,11 +1224,11 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
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
@@ -1236,13 +1236,14 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
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
@@ -1250,22 +1251,22 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
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
 
@@ -1282,25 +1283,27 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
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
@@ -1313,37 +1316,34 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
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
index 86fc1278127c..2f5c4335dec3 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1764,10 +1764,15 @@ static int prueth_probe(struct platform_device *pdev)
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
@@ -1924,7 +1929,8 @@ static int prueth_probe(struct platform_device *pdev)
 
 free_pool:
 	gen_pool_free(prueth->sram_pool,
-		      (unsigned long)prueth->msmcram.va, msmc_ram_size);
+		      (unsigned long)prueth->msmcram.va,
+		      prueth->msmcram.size);
 
 put_mem:
 	pruss_release_mem_region(prueth->pruss, &prueth->shram);
@@ -1976,8 +1982,8 @@ static void prueth_remove(struct platform_device *pdev)
 	icss_iep_put(prueth->iep0);
 
 	gen_pool_free(prueth->sram_pool,
-		      (unsigned long)prueth->msmcram.va,
-		      MSMC_RAM_SIZE);
+		(unsigned long)prueth->msmcram.va,
+		prueth->msmcram.size);
 
 	pruss_release_mem_region(prueth->pruss, &prueth->shram);
 
@@ -1994,12 +2000,14 @@ static const struct prueth_pdata am654_icssg_pdata = {
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
index b6be4aa57a61..0ca8ea0560e5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -251,11 +251,13 @@ struct prueth_emac {
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
index c69c24194801..0c9bedb67916 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3525,6 +3525,12 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
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
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8..e03dcab8c3df 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2508,6 +2508,7 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 }
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
 
+#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
 static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(bus);
@@ -2537,6 +2538,12 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 
 	return pdev;
 }
+#else
+static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
+{
+	return NULL;
+}
+#endif
 
 /*
  * Read the config data for a PCI device, sanity-check it,
diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 771a24c397c1..1135d2cf335c 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -15,6 +15,7 @@
 #include <linux/hwmon.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <uapi/linux/psci.h>
 
 #define MLXBF_PMC_WRITE_REG_32 0x82000009
@@ -1104,7 +1105,7 @@ static int mlxbf_pmc_get_event_num(const char *blk, const char *evt)
 	return -ENODEV;
 }
 
-/* Get the event number given the name */
+/* Get the event name given the number */
 static char *mlxbf_pmc_get_event_name(const char *blk, u32 evt)
 {
 	const struct mlxbf_pmc_events *events;
@@ -1666,6 +1667,7 @@ static ssize_t mlxbf_pmc_event_store(struct device *dev,
 		attr, struct mlxbf_pmc_attribute, dev_attr);
 	unsigned int blk_num, cnt_num;
 	bool is_l3 = false;
+	char *evt_name;
 	int evt_num;
 	int err;
 
@@ -1673,14 +1675,23 @@ static ssize_t mlxbf_pmc_event_store(struct device *dev,
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
@@ -1761,13 +1772,14 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
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
 
@@ -1787,14 +1799,11 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
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
index 650dfbebb6c8..9a1884b03215 100644
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
@@ -122,7 +124,6 @@ obj-$(CONFIG_SYSTEM76_ACPI)	+= system76_acpi.o
 obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
 
 # Platform drivers
-obj-$(CONFIG_FW_ATTR_CLASS)		+= firmware_attributes_class.o
 obj-$(CONFIG_SERIAL_MULTI_INSTANTIATE)	+= serial-multi-instantiate.o
 obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 3f8b2a324efd..f84c3d03c1de 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -530,6 +530,15 @@ static const struct dmi_system_id asus_quirks[] = {
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
 
diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index eb5cbe6ae9e9..dbbb3bc341e3 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -205,6 +205,7 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &g_series_quirks,
 	},
+	{}
 };
 
 enum WMAX_THERMAL_INFORMATION_OPERATIONS {
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index b5e4da6a6779..edb9d2fb02ec 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1669,7 +1669,7 @@ static int ideapad_kbd_bl_init(struct ideapad_private *priv)
 	priv->kbd_bl.led.name                    = "platform::" LED_FUNCTION_KBD_BACKLIGHT;
 	priv->kbd_bl.led.brightness_get          = ideapad_kbd_bl_led_cdev_brightness_get;
 	priv->kbd_bl.led.brightness_set_blocking = ideapad_kbd_bl_led_cdev_brightness_set;
-	priv->kbd_bl.led.flags                   = LED_BRIGHT_HW_CHANGED;
+	priv->kbd_bl.led.flags                   = LED_BRIGHT_HW_CHANGED | LED_RETAIN_AT_SHUTDOWN;
 
 	err = led_classdev_register(&priv->platform_device->dev, &priv->kbd_bl.led);
 	if (err)
@@ -1728,7 +1728,7 @@ static int ideapad_fn_lock_led_init(struct ideapad_private *priv)
 	priv->fn_lock.led.name                    = "platform::" LED_FUNCTION_FNLOCK;
 	priv->fn_lock.led.brightness_get          = ideapad_fn_lock_led_cdev_get;
 	priv->fn_lock.led.brightness_set_blocking = ideapad_fn_lock_led_cdev_set;
-	priv->fn_lock.led.flags                   = LED_BRIGHT_HW_CHANGED;
+	priv->fn_lock.led.flags                   = LED_BRIGHT_HW_CHANGED | LED_RETAIN_AT_SHUTDOWN;
 
 	err = led_classdev_register(&priv->platform_device->dev, &priv->fn_lock.led);
 	if (err)
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 90629a756693..4ecad5c6c839 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5639,6 +5639,7 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
 				 ERR_PTR(err));
 	}
 
+	rdev->coupling_desc.n_coupled = 0;
 	kfree(rdev->coupling_desc.coupled_rdevs);
 	rdev->coupling_desc.coupled_rdevs = NULL;
 }
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 60ed70a39d2c..b8464d9433e9 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -130,6 +130,7 @@ static int ism_cmd(struct ism_dev *ism, void *cmd)
 	struct ism_req_hdr *req = cmd;
 	struct ism_resp_hdr *resp = cmd;
 
+	spin_lock(&ism->cmd_lock);
 	__ism_write_cmd(ism, req + 1, sizeof(*req), req->len - sizeof(*req));
 	__ism_write_cmd(ism, req, 0, sizeof(*req));
 
@@ -143,6 +144,7 @@ static int ism_cmd(struct ism_dev *ism, void *cmd)
 	}
 	__ism_read_cmd(ism, resp + 1, sizeof(*resp), resp->len - sizeof(*resp));
 out:
+	spin_unlock(&ism->cmd_lock);
 	return resp->ret;
 }
 
@@ -606,6 +608,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	spin_lock_init(&ism->lock);
+	spin_lock_init(&ism->cmd_lock);
 	dev_set_drvdata(&pdev->dev, ism);
 	ism->pdev = pdev;
 	ism->dev.parent = &pdev->dev;
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 506a139fbd2c..b3a0bc811593 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1960,11 +1960,6 @@ static int cqspi_probe(struct platform_device *pdev)
 
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
index 6434cbdc1a6e..721b15b7e13b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -393,8 +393,7 @@ int vchiq_shutdown(struct vchiq_instance *instance)
 	struct vchiq_state *state = instance->state;
 	int ret = 0;
 
-	if (mutex_lock_killable(&state->mutex))
-		return -EAGAIN;
+	mutex_lock(&state->mutex);
 
 	/* Remove all services */
 	vchiq_shutdown_internal(state, instance);
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 214d45f8e55c..5915bb249de5 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1160,7 +1160,7 @@ static int tcpm_set_attached_state(struct tcpm_port *port, bool attached)
 				     port->data_role);
 }
 
-static int tcpm_set_roles(struct tcpm_port *port, bool attached,
+static int tcpm_set_roles(struct tcpm_port *port, bool attached, int state,
 			  enum typec_role role, enum typec_data_role data)
 {
 	enum typec_orientation orientation;
@@ -1197,7 +1197,7 @@ static int tcpm_set_roles(struct tcpm_port *port, bool attached,
 		}
 	}
 
-	ret = tcpm_mux_set(port, TYPEC_STATE_USB, usb_role, orientation);
+	ret = tcpm_mux_set(port, state, usb_role, orientation);
 	if (ret < 0)
 		return ret;
 
@@ -4404,16 +4404,6 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
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
@@ -4423,13 +4413,24 @@ static int tcpm_src_attach(struct tcpm_port *port)
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
@@ -4440,14 +4441,14 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
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
 
@@ -4579,7 +4580,8 @@ static int tcpm_snk_attach(struct tcpm_port *port)
 
 	tcpm_enable_auto_vbus_discharge(port, true);
 
-	ret = tcpm_set_roles(port, true, TYPEC_SINK, tcpm_data_role_for_sink(port));
+	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB,
+			     TYPEC_SINK, tcpm_data_role_for_sink(port));
 	if (ret < 0)
 		return ret;
 
@@ -4602,12 +4604,24 @@ static void tcpm_snk_detach(struct tcpm_port *port)
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
 
@@ -5377,7 +5391,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 */
 		tcpm_set_vconn(port, false);
 		tcpm_set_vbus(port, false);
-		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
+		tcpm_set_roles(port, port->self_powered, TYPEC_STATE_USB, TYPEC_SOURCE,
 			       tcpm_data_role_for_source(port));
 		/*
 		 * If tcpc fails to notify vbus off, TCPM will wait for PD_T_SAFE_0V +
@@ -5409,7 +5423,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_vconn(port, false);
 		if (port->pd_capable)
 			tcpm_set_charge(port, false);
-		tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
+		tcpm_set_roles(port, port->self_powered, TYPEC_STATE_USB, TYPEC_SINK,
 			       tcpm_data_role_for_sink(port));
 		/*
 		 * VBUS may or may not toggle, depending on the adapter.
@@ -5533,10 +5547,10 @@ static void run_state_machine(struct tcpm_port *port)
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
index b784aab66867..4397392bfef0 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2797,7 +2797,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 		     void (*recycle_done)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	int err;
+	int err, err_reset;
 
 	if (num > vq->vq.num_max)
 		return -E2BIG;
@@ -2819,7 +2819,11 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
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
 
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 6613b8fcceb0..5cf7328d5360 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -472,11 +472,18 @@ static int __nilfs_read_inode(struct super_block *sb,
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
index 51cab2def9ec..876130091384 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
+#include <linux/stdarg.h>
 
 int num_to_str(char *buf, int size, unsigned long long num, unsigned int width);
 
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 1f1861c57e2a..29a0759d5582 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -474,7 +474,7 @@ struct xfrm_type_offload {
 
 int xfrm_register_type_offload(const struct xfrm_type_offload *type, unsigned short family);
 void xfrm_unregister_type_offload(const struct xfrm_type_offload *type, unsigned short family);
-void xfrm_set_type_offload(struct xfrm_state *x);
+void xfrm_set_type_offload(struct xfrm_state *x, bool try_load);
 static inline void xfrm_unset_type_offload(struct xfrm_state *x)
 {
 	if (!x->type_offload)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index efa701411712..c12dfbeb78a7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16441,6 +16441,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 		if (src_reg->type == PTR_TO_STACK)
 			insn_flags |= INSN_F_SRC_REG_STACK;
+		if (dst_reg->type == PTR_TO_STACK)
+			insn_flags |= INSN_F_DST_REG_STACK;
 	} else {
 		if (insn->src_reg != BPF_REG_0) {
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
@@ -16450,10 +16452,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
index 8d3e6ed0bdc1..f9bb5481501a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1279,8 +1279,9 @@ static int __request_region_locked(struct resource *res, struct resource *parent
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
index a009c91f7b05..83c65f3afcca 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1256,7 +1256,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 				  struct system_time_snapshot *history_begin,
 				  struct system_device_crosststamp *xtstamp)
 {
-	struct system_counterval_t system_counterval;
+	struct system_counterval_t system_counterval = {};
 	struct timekeeper *tk = &tk_core.timekeeper;
 	u64 cycles, now, interval_start;
 	unsigned int clock_was_set_seq = 0;
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index b0877035491f..62c01b4527eb 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -399,7 +399,9 @@ static void print_address_description(void *addr, u8 tag,
 	}
 
 	if (is_vmalloc_addr(addr)) {
-		pr_err("The buggy address %px belongs to a vmalloc virtual mapping\n", addr);
+		pr_err("The buggy address belongs to a");
+		if (!vmalloc_dump_obj(addr))
+			pr_cont(" vmalloc virtual mapping\n");
 		page = vmalloc_to_page(addr);
 	}
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 8583fb91ef13..a9d3e719e089 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3669,10 +3669,10 @@ static ssize_t advisor_mode_show(struct kobject *kobj,
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
index b91a33fb6c69..225dddff091d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1561,6 +1561,10 @@ static int get_hwpoison_page(struct page *p, unsigned long flags)
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
index 3783e45bfc92..d3bce4d7a339 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1128,6 +1128,14 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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
index d14a7e317ac8..03fe0452e6e2 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1053,6 +1053,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	if (!zspage)
 		return NULL;
 
+	if (!IS_ENABLED(CONFIG_COMPACTION))
+		gfp &= ~__GFP_MOVABLE;
+
 	zspage->magic = ZSPAGE_MAGIC;
 	zspage->pool = pool;
 	zspage->class = class->index;
diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index 9c787e2e4b17..4744e3fd4544 100644
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
 
@@ -477,6 +493,7 @@ int aarp_proxy_probe_network(struct atalk_iface *atif, struct atalk_addr *sa)
 	entry->dev = atif->dev;
 
 	write_lock_bh(&aarp_lock);
+	aarp_entry_get(entry);
 
 	hash = sa->s_node % (AARP_HASH_SIZE - 1);
 	entry->next = proxies[hash];
@@ -502,6 +519,7 @@ int aarp_proxy_probe_network(struct atalk_iface *atif, struct atalk_addr *sa)
 		retval = 1;
 	}
 
+	aarp_entry_put(entry);
 	write_unlock_bh(&aarp_lock);
 out:
 	return retval;
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index 0d31a8c108d4..f28cfd88eaf5 100644
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
index 2b1b025c31a3..51cc2cfb4093 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -536,9 +536,6 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 static void qfq_destroy_class(struct Qdisc *sch, struct qfq_class *cl)
 {
-	struct qfq_sched *q = qdisc_priv(sch);
-
-	qfq_rm_from_agg(q, cl);
 	gen_kill_estimator(&cl->rate_est);
 	qdisc_put(cl->qdisc);
 	kfree(cl);
@@ -559,10 +556,11 @@ static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
 
 	qdisc_purge_queue(cl->qdisc);
 	qdisc_class_hash_remove(&q->clhash, &cl->common);
-	qfq_destroy_class(sch, cl);
+	qfq_rm_from_agg(q, cl);
 
 	sch_tree_unlock(sch);
 
+	qfq_destroy_class(sch, cl);
 	return 0;
 }
 
@@ -1503,6 +1501,7 @@ static void qfq_destroy_qdisc(struct Qdisc *sch)
 	for (i = 0; i < q->clhash.hashsize; i++) {
 		hlist_for_each_entry_safe(cl, next, &q->clhash.hash[i],
 					  common.hnode) {
+			qfq_rm_from_agg(q, cl);
 			qfq_destroy_class(sch, cl);
 		}
 	}
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index f46a9e5764f0..a2d3a5f3b485 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -305,7 +305,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}
 
-	xfrm_set_type_offload(x);
 	if (!x->type_offload) {
 		NL_SET_ERR_MSG(extack, "Type doesn't support offload");
 		dev_put(dev);
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 622445f041d3..fed96bedd54e 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -875,7 +875,7 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 		return -EINVAL;
 	}
 
-	if (p.collect_md) {
+	if (p.collect_md || xi->p.collect_md) {
 		NL_SET_ERR_MSG(extack, "collect_md can't be changed");
 		return -EINVAL;
 	}
@@ -886,11 +886,6 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
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
diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 907c3ccb440d..a38545413b80 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -97,7 +97,7 @@ static int ipcomp_input_done2(struct sk_buff *skb, int err)
 	struct ip_comp_hdr *ipch = ip_comp_hdr(skb);
 	const int plen = skb->len;
 
-	skb_reset_transport_header(skb);
+	skb->transport_header = skb->network_header + sizeof(*ipch);
 
 	return ipcomp_post_acomp(skb, err, 0) ?:
 	       skb->len < (plen + sizeof(ip_comp_hdr)) ? -EINVAL :
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 5ece039846e2..0cf516b4e6d9 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -424,11 +424,10 @@ void xfrm_unregister_type_offload(const struct xfrm_type_offload *type,
 }
 EXPORT_SYMBOL(xfrm_unregister_type_offload);
 
-void xfrm_set_type_offload(struct xfrm_state *x)
+void xfrm_set_type_offload(struct xfrm_state *x, bool try_load)
 {
 	const struct xfrm_type_offload *type = NULL;
 	struct xfrm_state_afinfo *afinfo;
-	bool try_load = true;
 
 retry:
 	afinfo = xfrm_state_get_afinfo(x->props.family);
@@ -607,6 +606,7 @@ static void ___xfrm_state_destroy(struct xfrm_state *x)
 	kfree(x->coaddr);
 	kfree(x->replay_esn);
 	kfree(x->preplay_esn);
+	xfrm_unset_type_offload(x);
 	if (x->type) {
 		x->type->destructor(x);
 		xfrm_put_type(x->type);
@@ -780,8 +780,6 @@ void xfrm_dev_state_free(struct xfrm_state *x)
 	struct xfrm_dev_offload *xso = &x->xso;
 	struct net_device *dev = READ_ONCE(xso->dev);
 
-	xfrm_unset_type_offload(x);
-
 	if (dev && dev->xfrmdev_ops) {
 		spin_lock_bh(&xfrm_state_dev_gc_lock);
 		if (!hlist_unhashed(&x->dev_gclist))
@@ -1307,14 +1305,8 @@ static void xfrm_hash_grow_check(struct net *net, int have_hash_collision)
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
@@ -1381,14 +1373,15 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
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
@@ -1400,7 +1393,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, encap_family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 
 	if (best)
@@ -1417,7 +1410,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 
 cached:
@@ -1429,8 +1422,6 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	else if (acquire_in_progress) /* XXX: acquire_in_progress should not happen */
 		WARN_ON(1);
 
-	xfrm_hash_ptrs_get(net, &state_ptrs);
-
 	h = __xfrm_dst_hash(daddr, saddr, tmpl->reqid, encap_family, state_ptrs.hmask);
 	hlist_for_each_entry_rcu(x, state_ptrs.bydst + h, bydst) {
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -1460,7 +1451,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 	if (best || acquire_in_progress)
 		goto found;
@@ -1495,7 +1486,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 
 found:
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 614b58cb26ab..d17ea437a158 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -977,6 +977,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 	/* override default values from above */
 	xfrm_update_ae_params(x, attrs, 0);
 
+	xfrm_set_type_offload(x, attrs[XFRMA_OFFLOAD_DEV]);
 	/* configure the hardware if offload is requested */
 	if (attrs[XFRMA_OFFLOAD_DEV]) {
 		err = xfrm_dev_state_add(net, x,
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index a590d431c5ff..8c0dd439f5a5 100644
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
@@ -187,7 +191,9 @@ static int hda_tegra_runtime_resume(struct device *dev)
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
@@ -250,7 +256,8 @@ static int hda_tegra_init_chip(struct azx *chip, struct platform_device *pdev)
 	bus->remap_addr = hda->regs + HDA_BAR0;
 	bus->addr = res->start + HDA_BAR0;
 
-	hda_tegra_init(hda);
+	if (hda->soc->requires_init)
+		hda_tegra_init(hda);
 
 	return 0;
 }
@@ -323,7 +330,7 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	 * starts with offset 0 which is wrong as HW register for output stream
 	 * offset starts with 4.
 	 */
-	if (of_device_is_compatible(np, "nvidia,tegra234-hda"))
+	if (!hda->soc->input_stream)
 		chip->capture_streams = 4;
 
 	chip->playback_streams = (gcap >> 12) & 0x0f;
@@ -419,7 +426,6 @@ static int hda_tegra_create(struct snd_card *card,
 	chip->driver_caps = driver_caps;
 	chip->driver_type = driver_caps & 0xff;
 	chip->dev_index = 0;
-	chip->jackpoll_interval = msecs_to_jiffies(5000);
 	INIT_LIST_HEAD(&chip->pcm_list);
 
 	chip->codec_probe_mask = -1;
@@ -436,7 +442,16 @@ static int hda_tegra_create(struct snd_card *card,
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
@@ -450,22 +465,44 @@ static int hda_tegra_create(struct snd_card *card,
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
@@ -520,7 +557,9 @@ static int hda_tegra_probe(struct platform_device *pdev)
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
index 7167989a8d86..0413e831d6ce 100644
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
index 5a6d0424bfed..3c93d2135717 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4753,7 +4753,7 @@ static void alc245_fixup_hp_mute_led_v1_coefbit(struct hda_codec *codec,
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->mute_led_polarity = 0;
 		spec->mute_led_coef.idx = 0x0b;
-		spec->mute_led_coef.mask = 1 << 3;
+		spec->mute_led_coef.mask = 3 << 2;
 		spec->mute_led_coef.on = 1 << 3;
 		spec->mute_led_coef.off = 0;
 		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
@@ -10668,6 +10668,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87cc, "HP Pavilion 15-eg0xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87df, "HP ProBook 430 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
@@ -10746,6 +10747,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a2e, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a30, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a31, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8a4f, "HP Victus 15-fa0xxx (MB 8A4F)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a6e, "HP EDNA 360", ALC287_FIXUP_CS35L41_I2C_4),
 	SND_PCI_QUIRK(0x103c, 0x8a74, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.c b/sound/soc/mediatek/common/mtk-soundcard-driver.c
index 713a368f79cf..95a083939f3e 100644
--- a/sound/soc/mediatek/common/mtk-soundcard-driver.c
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.c
@@ -262,9 +262,13 @@ int mtk_soundcard_common_probe(struct platform_device *pdev)
 				soc_card_data->accdet = accdet_comp;
 			else
 				dev_err(&pdev->dev, "No sound component found from mediatek,accdet property\n");
+
+			put_device(&accdet_pdev->dev);
 		} else {
 			dev_err(&pdev->dev, "No device found from mediatek,accdet property\n");
 		}
+
+		of_node_put(accdet_node);
 	}
 
 	platform_node = of_parse_phandle(pdev->dev.of_node, "mediatek,platform", 0);
diff --git a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
index cae51756cead..cb9beb172ed5 100644
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
index 7d9bcb066d3f..92e8307b2a46 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -118,8 +118,11 @@ static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
 
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
@@ -326,7 +329,7 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
 {
 	size_t len = 0;
 
-	while (len < dest_size) {
+	while (len < dest_size && *src) {
 		if (src[len] < 0x80)
 			dest[len++] = (char)(*src++);
 		else
@@ -338,27 +341,15 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
 
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
index 6662d4b39969..c65d03782822 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -179,4 +179,57 @@ __naked int state_loop_first_last_equal(void)
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
index da5af2c680fa..1a9d57c3efa3 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import re
 import time
 
 from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen, bkg
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
@@ -74,3 +74,16 @@ class GenerateTraffic:
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
diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index aa7400ed0e99..f0d9c035641d 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -31,6 +31,7 @@ uint64_t pmd_pagesize;
 #define INPUT_MAX 80
 
 #define PID_FMT "%d,0x%lx,0x%lx,%d"
+#define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
 #define PATH_FMT "%s,0x%lx,0x%lx,%d"
 
 #define PFN_MASK     ((1UL<<55)-1)
@@ -483,7 +484,7 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
 		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
 			      (uint64_t)addr + fd_size, order);
 	else
-		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
+		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
 			      (uint64_t)addr + fd_size, order, offset);
 
 	for (i = 0; i < fd_size; i++)
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 340e1a777e16..567e6677c9d4 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -4,7 +4,8 @@ top_srcdir = ../../../../..
 
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
-TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
+TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
+	      mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
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

