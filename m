Return-Path: <stable+bounces-87737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BBD9AB132
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 16:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3261C22725
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 14:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A2C19E970;
	Tue, 22 Oct 2024 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L+aTOe1A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7041A2C15;
	Tue, 22 Oct 2024 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608351; cv=none; b=QDcZSL83JNixivsiBlA15oginW5MtWjZ+nk02+IiMVw4cKAM9GymTZoBzJzU/kaBjwNpcvuGzXJcF+leQ/VzW+LmYiEqsqlwA/X4DqbVuIcSXaGYd5GwpTGc7BB792FgLtd1kdhojEH4FQ9KxoOyF9WPXNtKlGJkPMf2700f1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608351; c=relaxed/simple;
	bh=lx+XHB7DCZuXmdZeVebEzqIkhl/7b6i374oG8DhT7a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izHbwaaEHyNAtrCy8MoWbWMX+hZBXTGCewo0Um/AwAuLfG+nDsQDK2kEhmtnTNp2sUhj8TfE2SMo7c5AMYxGrulXE5xiZIZxab2iTIJByNYRhkS3amPLFLPU/TerSVcaY4TgjxqIV8V5hUeRHl8D9WxG5EA+Mct1IcSgcM7b56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L+aTOe1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D897C4CEE7;
	Tue, 22 Oct 2024 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729608351;
	bh=lx+XHB7DCZuXmdZeVebEzqIkhl/7b6i374oG8DhT7a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+aTOe1AXUdzFmlN+9u1paRChLOLemRLDzDi3iqHTcbnYyWl6RsMeq3kj+afL02MQ
	 eWnnKUT2kigcz2eI16rStYzqPWjm1ZFyZSrjZDDwo4wynb9Xd04a10lj3YgtowqXEs
	 gwrgsDvmhbq4Ksz3v1e6DT46dwITubWUvKe6wko4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.169
Date: Tue, 22 Oct 2024 16:45:39 +0200
Message-ID: <2024102238-epilogue-rescuer-7026@gregkh>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024102238-reenter-bakery-db9f@gregkh>
References: <2024102238-reenter-bakery-db9f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 38ffaecf1edf..8c97377cd56e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 168
+SUBLEVEL = 169
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index 104101f633b1..492e50a6ddbf 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -99,10 +99,6 @@ arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api)
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
@@ -140,6 +136,17 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
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
@@ -157,7 +164,6 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
 		else
 			scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
 	}
-	decoded = arm_probe_decode_insn(insn, &asi->api);
 
 	if (decoded != INSN_REJECTED && scan_end)
 		if (is_probed_address_atomic(addr - 1, scan_end))
diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
index 22d0b3252476..b65334ab79d2 100644
--- a/arch/arm64/kernel/probes/simulate-insn.c
+++ b/arch/arm64/kernel/probes/simulate-insn.c
@@ -171,17 +171,15 @@ simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs)
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
@@ -189,14 +187,12 @@ simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs)
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
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 9c038c8cebeb..a756f3f5a230 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1162,6 +1162,9 @@ void __init mem_topology_setup(void)
 {
 	int cpu;
 
+	max_low_pfn = max_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
+	min_low_pfn = MEMORY_START >> PAGE_SHIFT;
+
 	/*
 	 * Linux/mm assumes node 0 to be online at boot. However this is not
 	 * true on PowerPC, where node 0 is similar to any other node, it
@@ -1206,9 +1209,6 @@ void __init initmem_init(void)
 {
 	int nid;
 
-	max_low_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
-	max_pfn = max_low_pfn;
-
 	memblock_dump_all();
 
 	for_each_online_node(nid) {
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 3c65b8258ae6..2cc3ec034046 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -77,7 +77,7 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
 	vcpu->stat.instruction_diagnose_258++;
 	if (vcpu->run->s.regs.gprs[rx] & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	rc = read_guest(vcpu, vcpu->run->s.regs.gprs[rx], rx, &parm, sizeof(parm));
+	rc = read_guest_real(vcpu, vcpu->run->s.regs.gprs[rx], &parm, sizeof(parm));
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	if (parm.parm_version != 2 || parm.parm_len < 5 || parm.code != 0x258)
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index 09e99d13fc0b..f4419afc7147 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -9,6 +9,8 @@
 #include <asm/unwind_hints.h>
 #include <asm/segment.h>
 #include <asm/cache.h>
+#include <asm/cpufeatures.h>
+#include <asm/nospec-branch.h>
 
 .pushsection .noinstr.text, "ax"
 
@@ -17,6 +19,9 @@ SYM_FUNC_START(entry_ibpb)
 	movl	$PRED_CMD_IBPB, %eax
 	xorl	%edx, %edx
 	wrmsr
+
+	/* Make sure IBPB clears return stack preductions too. */
+	FILL_RETURN_BUFFER %rax, RSB_CLEAR_LOOPS, X86_BUG_IBPB_NO_RET
 	RET
 SYM_FUNC_END(entry_ibpb)
 /* For KVM */
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index ee5def1060c8..475ce40401ec 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -902,6 +902,8 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	/* Now ready to switch the cr3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
+	/* Clobbers ZF */
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
@@ -912,7 +914,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
-	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -1175,7 +1176,6 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
-	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
@@ -1196,6 +1196,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	CHECK_AND_APPLY_ESPFIX
 	RESTORE_ALL_NMI cr3_reg=%edi pop=4
+	CLEAR_CPU_BUFFERS
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1237,6 +1238,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 *  1 - orig_ax
 	 */
 	lss	(1+5+6)*4(%esp), %esp			# back to espfix stack
+	CLEAR_CPU_BUFFERS
 	jmp	.Lirq_return
 #endif
 SYM_CODE_END(asm_exc_nmi)
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 18817817ea81..3c0f7e332478 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -217,7 +217,7 @@
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
 #define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* "" AMD SSBD implementation via LS_CFG MSR */
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
-#define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
+#define X86_FEATURE_IBPB		( 7*32+26) /* "ibpb" Indirect Branch Prediction Barrier without a guaranteed RSB flush */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 or above (Zen) */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
@@ -329,6 +329,7 @@
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 #define X86_FEATURE_BTC_NO		(13*32+29) /* "" Not vulnerable to Branch Type Confusion */
+#define X86_FEATURE_AMD_IBPB_RET	(13*32+30) /* "" IBPB clears return address predictor */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
@@ -480,4 +481,5 @@
 #define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* AMD DIV0 speculation bug */
 #define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* CPU is vulnerable to Register File Data Sampling */
 #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* CPU is affected by Branch History Injection */
+#define X86_BUG_IBPB_NO_RET		X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 4df7d694369a..0baca232125a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -493,7 +493,19 @@ static int lapic_timer_shutdown(struct clock_event_device *evt)
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
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 247545b57dff..f84d59cd180b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1092,7 +1092,24 @@ static void __init retbleed_select_mitigation(void)
 
 	case RETBLEED_MITIGATION_IBPB:
 		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+
+		/*
+		 * IBPB on entry already obviates the need for
+		 * software-based untraining so clear those in case some
+		 * other mitigation like SRSO has selected them.
+		 */
+		setup_clear_cpu_cap(X86_FEATURE_UNRET);
+		setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
+
 		mitigate_smt = true;
+
+		/*
+		 * There is no need for RSB filling: entry_ibpb() ensures
+		 * all predictions, including the RSB, are invalidated,
+		 * regardless of IBPB implementation.
+		 */
+		setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
+
 		break;
 
 	default:
@@ -2591,6 +2608,14 @@ static void __init srso_select_mitigation(void)
 			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
 				srso_mitigation = SRSO_MITIGATION_IBPB;
+
+				/*
+				 * IBPB on entry already obviates the need for
+				 * software-based untraining so clear those in case some
+				 * other mitigation like Retbleed has selected them.
+				 */
+				setup_clear_cpu_cap(X86_FEATURE_UNRET);
+				setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
 			}
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
@@ -2603,6 +2628,13 @@ static void __init srso_select_mitigation(void)
 			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
+
+				/*
+				 * There is no need for RSB filling: entry_ibpb() ensures
+				 * all predictions, including the RSB, are invalidated,
+				 * regardless of IBPB implementation.
+				 */
+				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 			}
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 809e12f130d8..f0cc4c616ceb 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1352,6 +1352,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	     boot_cpu_has(X86_FEATURE_HYPERVISOR)))
 		setup_force_cpu_bug(X86_BUG_BHI);
 
+	if (cpu_has(c, X86_FEATURE_AMD_IBPB) && !cpu_has(c, X86_FEATURE_AMD_IBPB_RET))
+		setup_force_cpu_bug(X86_BUG_IBPB_NO_RET);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index a5c51a14fbce..d852ee9ea221 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -175,7 +175,7 @@ static inline bool rdt_get_mb_table(struct rdt_resource *r)
 	return false;
 }
 
-static bool __get_mem_config_intel(struct rdt_resource *r)
+static __init bool __get_mem_config_intel(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	union cpuid_0x10_3_eax eax;
@@ -210,7 +210,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	return true;
 }
 
-static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
+static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	union cpuid_0x10_3_eax eax;
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index e83af7bc7591..26dd3e7bd00d 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -225,8 +225,8 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
 
 	data->got_token = true;
 	smp_wmb();
-	list_del_init(&curr->entry);
 	wake_up_process(data->task);
+	list_del_init_careful(&curr->entry);
 	return 1;
 }
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fcd1910825b6..4a5b937f78d9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1002,10 +1002,15 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	if (!urb)
 		return -ENOMEM;
 
-	/* Use maximum HCI Event size so the USB stack handles
-	 * ZPL/short-transfer automatically.
-	 */
-	size = HCI_MAX_EVENT_SIZE;
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
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 54f1ab3071f9..eb486c9c9575 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -607,6 +607,9 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
 		return ret;
 	}
 
+	if (is_cow_mapping(vma->vm_flags))
+		return -EINVAL;
+
 	ret = drm_gem_shmem_get_pages(shmem);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/radeon/radeon_encoders.c b/drivers/gpu/drm/radeon/radeon_encoders.c
index 46549d5179ee..d49a6d4a430e 100644
--- a/drivers/gpu/drm/radeon/radeon_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_encoders.c
@@ -41,7 +41,7 @@ static uint32_t radeon_encoder_clones(struct drm_encoder *encoder)
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_encoder *radeon_encoder = to_radeon_encoder(encoder);
 	struct drm_encoder *clone_encoder;
-	uint32_t index_mask = 0;
+	uint32_t index_mask = drm_encoder_mask(encoder);
 	int count;
 
 	/* DIG routing gets problematic */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index e2a52b5de173..23010d60edfe 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1417,6 +1417,7 @@ static struct drm_framebuffer *vmw_kms_fb_create(struct drm_device *dev,
 		DRM_ERROR("Surface size cannot exceed %dx%d\n",
 			dev_priv->texture_max_width,
 			dev_priv->texture_max_height);
+		ret = -EINVAL;
 		goto err_out;
 	}
 
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 86b83dc7b7d9..1dca0e82b2e8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1131,6 +1131,8 @@ config TI_ADS8344
 config TI_ADS8688
 	tristate "Texas Instruments ADS8688"
 	depends on SPI && OF
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for Texas Instruments ADS8684 and
 	  and ADS8688 ADC chips
@@ -1141,6 +1143,8 @@ config TI_ADS8688
 config TI_ADS124S08
 	tristate "Texas Instruments ADS124S08"
 	depends on SPI && OF
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for Texas Instruments ADS124S08
 	  and ADS124S06 ADC chips
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index a4ec11a3b68a..82ab168cc13e 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -32,7 +32,7 @@ static ssize_t _hid_sensor_set_report_latency(struct device *dev,
 	latency = integer * 1000 + fract / 1000;
 	ret = hid_sensor_set_report_latency(attrb, latency);
 	if (ret < 0)
-		return len;
+		return ret;
 
 	attrb->latency_ms = hid_sensor_get_report_latency(attrb);
 
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 75e1f2b48638..79a4fe015e98 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -203,6 +203,7 @@ config AD5766
 config AD5770R
 	tristate "Analog Devices AD5770R IDAC driver"
 	depends on SPI_MASTER
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Analog Devices AD5770R Digital to
 	  Analog Converter.
@@ -283,6 +284,7 @@ config LPC18XX_DAC
 config LTC1660
 	tristate "Linear Technology LTC1660/LTC1665 DAC SPI driver"
 	depends on SPI
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Linear Technology
 	  LTC1660 and LTC1665 Digital to Analog Converters.
@@ -369,6 +371,7 @@ config STM32_DAC
 
 config STM32_DAC_CORE
 	tristate
+	select REGMAP_MMIO
 
 config TI_DAC082S085
 	tristate "Texas Instruments 8/10/12-bit 2/4-channel DAC driver"
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 1880bd5bb258..f2462121aa04 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -138,6 +138,10 @@ static const struct opt3001_scale opt3001_scales[] = {
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
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 3c937c55a10d..9b9697d67850 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -99,9 +99,8 @@ static const char * const period_values[] = {
 static ssize_t in_illuminance_period_available_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
+	struct veml6030_data *data = iio_priv(dev_to_iio_dev(dev));
 	int ret, reg, x;
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-	struct veml6030_data *data = iio_priv(indio_dev);
 
 	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
 	if (ret) {
@@ -780,7 +779,7 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
 
 	/* Cache currently active measurement parameters */
 	data->cur_gain = 3;
-	data->cur_resolution = 4608;
+	data->cur_resolution = 5376;
 	data->cur_integration_time = 3;
 
 	return ret;
diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 7c7203ca3ac6..1449fd2016b4 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -60,6 +60,8 @@ config LIDAR_LITE_V2
 config MB1232
 	tristate "MaxSonar I2CXL family ultrasonic sensors"
 	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y to build a driver for the ultrasonic sensors I2CXL of
 	  MaxBotix which have an i2c interface. It can be used to measure
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index acb870a877ec..1d2e3c12dc81 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4465,8 +4465,10 @@ static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *op
  */
 static void domain_context_clear(struct device_domain_info *info)
 {
-	if (!dev_is_pci(info->dev))
+	if (!dev_is_pci(info->dev)) {
 		domain_context_clear_one(info, info->bus, info->devfn);
+		return;
+	}
 
 	pci_for_each_dma_alias(to_pci_dev(info->dev),
 			       &domain_context_clear_one_cb, info);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3fa6c7184326..567d758503fb 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -779,6 +779,7 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 					   struct its_cmd_block *cmd,
 					   struct its_cmd_desc *desc)
 {
+	struct its_vpe *vpe = valid_vpe(its, desc->its_vmapp_cmd.vpe);
 	unsigned long vpt_addr, vconf_addr;
 	u64 target;
 	bool alloc;
@@ -788,9 +789,14 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 	its_encode_valid(cmd, desc->its_vmapp_cmd.valid);
 
 	if (!desc->its_vmapp_cmd.valid) {
+		alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
 		if (is_v4_1(its)) {
-			alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
 			its_encode_alloc(cmd, alloc);
+			/*
+			 * Unmapping a VPE is self-synchronizing on GICv4.1,
+			 * no need to issue a VSYNC.
+			 */
+			vpe = NULL;
 		}
 
 		goto out;
@@ -803,13 +809,13 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 	its_encode_vpt_addr(cmd, vpt_addr);
 	its_encode_vpt_size(cmd, LPI_NRBITS - 1);
 
+	alloc = !atomic_fetch_inc(&desc->its_vmapp_cmd.vpe->vmapp_count);
+
 	if (!is_v4_1(its))
 		goto out;
 
 	vconf_addr = virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->its_vm->vprop_page));
 
-	alloc = !atomic_fetch_inc(&desc->its_vmapp_cmd.vpe->vmapp_count);
-
 	its_encode_alloc(cmd, alloc);
 
 	/*
@@ -825,7 +831,7 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 out:
 	its_fixup_cmd(cmd);
 
-	return valid_vpe(its, desc->its_vmapp_cmd.vpe);
+	return vpe;
 }
 
 static struct its_vpe *its_build_vmapti_cmd(struct its_node *its,
@@ -3804,6 +3810,13 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	unsigned long flags;
 	int from, cpu;
 
+	/*
+	 * Check if we're racing against a VPE being destroyed, for
+	 * which we don't want to allow a VMOVP.
+	 */
+	if (!atomic_read(&vpe->vmapp_count))
+		return -EINVAL;
+
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
 	 * we can and only do it if we really have to. Also, if mapped
@@ -4440,9 +4453,8 @@ static int its_vpe_init(struct its_vpe *vpe)
 	raw_spin_lock_init(&vpe->vpe_lock);
 	vpe->vpe_id = vpe_id;
 	vpe->vpt_page = vpt_page;
-	if (gic_rdists->has_rvpeid)
-		atomic_set(&vpe->vmapp_count, 0);
-	else
+	atomic_set(&vpe->vmapp_count, 0);
+	if (!gic_rdists->has_rvpeid)
 		vpe->vpe_proxy_event = -1;
 
 	return 0;
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index a3db76dcdb3e..6e392f3cbd37 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -69,10 +69,8 @@ struct dm_crypt_io {
 	struct bio *base_bio;
 	u8 *integrity_metadata;
 	bool integrity_metadata_from_pool:1;
-	bool in_tasklet:1;
 
 	struct work_struct work;
-	struct tasklet_struct tasklet;
 
 	struct convert_context ctx;
 
@@ -1725,7 +1723,6 @@ static void crypt_io_init(struct dm_crypt_io *io, struct crypt_config *cc,
 	io->ctx.r.req = NULL;
 	io->integrity_metadata = NULL;
 	io->integrity_metadata_from_pool = false;
-	io->in_tasklet = false;
 	atomic_set(&io->io_pending, 0);
 }
 
@@ -1734,12 +1731,6 @@ static void crypt_inc_pending(struct dm_crypt_io *io)
 	atomic_inc(&io->io_pending);
 }
 
-static void kcryptd_io_bio_endio(struct work_struct *work)
-{
-	struct dm_crypt_io *io = container_of(work, struct dm_crypt_io, work);
-	bio_endio(io->base_bio);
-}
-
 /*
  * One of the bios was finished. Check for completion of
  * the whole request and correctly clean up the buffer.
@@ -1763,20 +1754,6 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
 
 	base_bio->bi_status = error;
 
-	/*
-	 * If we are running this function from our tasklet,
-	 * we can't call bio_endio() here, because it will call
-	 * clone_endio() from dm.c, which in turn will
-	 * free the current struct dm_crypt_io structure with
-	 * our tasklet. In this case we need to delay bio_endio()
-	 * execution to after the tasklet is done and dequeued.
-	 */
-	if (io->in_tasklet) {
-		INIT_WORK(&io->work, kcryptd_io_bio_endio);
-		queue_work(cc->io_queue, &io->work);
-		return;
-	}
-
 	bio_endio(base_bio);
 }
 
@@ -2220,11 +2197,6 @@ static void kcryptd_crypt(struct work_struct *work)
 		kcryptd_crypt_write_convert(io);
 }
 
-static void kcryptd_crypt_tasklet(unsigned long work)
-{
-	kcryptd_crypt((struct work_struct *)work);
-}
-
 static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 {
 	struct crypt_config *cc = io->cc;
@@ -2236,15 +2208,10 @@ static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 		 * irqs_disabled(): the kernel may run some IO completion from the idle thread, but
 		 * it is being executed with irqs disabled.
 		 */
-		if (in_hardirq() || irqs_disabled()) {
-			io->in_tasklet = true;
-			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
-			tasklet_schedule(&io->tasklet);
+		if (!(in_hardirq() || irqs_disabled())) {
+			kcryptd_crypt(&io->work);
 			return;
 		}
-
-		kcryptd_crypt(&io->work);
-		return;
 	}
 
 	INIT_WORK(&io->work, kcryptd_crypt);
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index dac56169851a..4e7359657941 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -902,9 +902,6 @@ static int macb_mdiobus_register(struct macb *bp)
 {
 	struct device_node *child, *np = bp->pdev->dev.of_node;
 
-	if (of_phy_is_fixed_link(np))
-		return mdiobus_register(bp->mii_bus);
-
 	/* Only create the PHY from the device tree if at least one PHY is
 	 * described. Otherwise scan the entire MDIO bus. We do this to support
 	 * old device tree that did not follow the best practices and did not
@@ -925,8 +922,19 @@ static int macb_mdiobus_register(struct macb *bp)
 
 static int macb_mii_init(struct macb *bp)
 {
+	struct device_node *child, *np = bp->pdev->dev.of_node;
 	int err = -ENXIO;
 
+	/* With fixed-link, we don't need to register the MDIO bus,
+	 * except if we have a child named "mdio" in the device tree.
+	 * In that case, some devices may be attached to the MACB's MDIO bus.
+	 */
+	child = of_get_child_by_name(np, "mdio");
+	if (child)
+		of_node_put(child);
+	else if (of_phy_is_fixed_link(np))
+		return macb_mii_probe(bp->dev);
+
 	/* Enable management port */
 	macb_writel(bp, NCR, MACB_BIT(MPE));
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 9e063eb17f52..b51d54799669 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1223,7 +1223,6 @@ static void enetc_xdp_drop(struct enetc_bdr *rx_ring, int rx_ring_first,
 				  &rx_ring->rx_swbd[rx_ring_first]);
 		enetc_bdr_idx_inc(rx_ring, &rx_ring_first);
 	}
-	rx_ring->stats.xdp_drops++;
 }
 
 static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
@@ -1280,6 +1279,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			fallthrough;
 		case XDP_DROP:
 			enetc_xdp_drop(rx_ring, orig_i, i);
+			rx_ring->stats.xdp_drops++;
 			break;
 		case XDP_PASS:
 			rxbd = orig_rxbd;
diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 8400a379186e..180376c09cb4 100644
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
@@ -155,7 +155,7 @@ static int do_hardware_irq(struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += snprintf (buffer, sizeof(buffer), "%d\n", port->irq);
+	len += scnprintf (buffer, sizeof(buffer), "%d\n", port->irq);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -182,7 +182,7 @@ static int do_hardware_dma(struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += snprintf (buffer, sizeof(buffer), "%d\n", port->dma);
+	len += scnprintf (buffer, sizeof(buffer), "%d\n", port->dma);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -213,7 +213,7 @@ static int do_hardware_modes(struct ctl_table *table, int write,
 #define printmode(x)							\
 do {									\
 	if (port->modes & PARPORT_MODE_##x)				\
-		len += snprintf(buffer + len, sizeof(buffer) - len, "%s%s", f++ ? "," : "", #x); \
+		len += scnprintf(buffer + len, sizeof(buffer) - len, "%s%s", f++ ? "," : "", #x); \
 } while (0)
 		int f = 0;
 		printmode(PCSPP);
diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index b14f1b7a625e..9f1b88fa33b4 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1279,21 +1279,21 @@ static void ocelot_irq_handler(struct irq_desc *desc)
 	unsigned int reg = 0, irq, i;
 	unsigned long irqs;
 
+	chained_irq_enter(parent_chip, desc);
+
 	for (i = 0; i < info->stride; i++) {
 		regmap_read(info->map, id_reg + 4 * i, &reg);
 		if (!reg)
 			continue;
 
-		chained_irq_enter(parent_chip, desc);
-
 		irqs = reg;
 
 		for_each_set_bit(irq, &irqs,
 				 min(32U, info->desc->npins - 32 * i))
 			generic_handle_domain_irq(chip->irq.domain, irq + 32 * i);
-
-		chained_irq_exit(parent_chip, desc);
 	}
+
+	chained_irq_exit(parent_chip, desc);
 }
 
 static int ocelot_gpiochip_register(struct platform_device *pdev,
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 29a6a0099f83..7bf9a0a87a00 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -320,7 +320,7 @@ sclp_vt220_add_msg(struct sclp_vt220_request *request,
 	buffer = (void *) ((addr_t) sccb + sccb->header.length);
 
 	if (convertlf) {
-		/* Perform Linefeed conversion (0x0a -> 0x0a 0x0d)*/
+		/* Perform Linefeed conversion (0x0a -> 0x0d 0x0a)*/
 		for (from=0, to=0;
 		     (from < count) && (to < sclp_vt220_space_left(request));
 		     from++) {
@@ -329,8 +329,8 @@ sclp_vt220_add_msg(struct sclp_vt220_request *request,
 			/* Perform conversion */
 			if (c == 0x0a) {
 				if (to + 1 < sclp_vt220_space_left(request)) {
-					((unsigned char *) buffer)[to++] = c;
 					((unsigned char *) buffer)[to++] = 0x0d;
+					((unsigned char *) buffer)[to++] = c;
 				} else
 					break;
 
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index f12d30a3307c..15ffa16ba447 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1013,7 +1013,7 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 					td_to_noop(xhci, ring, cached_td, false);
 					cached_td->cancel_status = TD_CLEARED;
 				}
-
+				td_to_noop(xhci, ring, td, false);
 				td->cancel_status = TD_CLEARING_CACHE;
 				cached_td = td;
 				break;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 977b3fdf4fb5..f2133f2a1767 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1286,7 +1286,7 @@ enum xhci_setup_dev {
 /* Set TR Dequeue Pointer command TRB fields, 6.4.3.9 */
 #define TRB_TO_STREAM_ID(p)		((((p) & (0xffff << 16)) >> 16))
 #define STREAM_ID_FOR_TRB(p)		((((p)) & 0xffff) << 16)
-#define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
+#define SCT_FOR_TRB(p)			(((p) & 0x7) << 1)
 
 /* Link TRB specific fields */
 #define TRB_TC			(1<<1)
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index d34458f11d82..9d2c8dc14945 100644
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
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 5369d82e0bfb..e69e2a4f99b9 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1020,7 +1020,7 @@ static int vfat_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	if (corrupt < 0) {
 		fat_fs_error(new_dir->i_sb,
 			     "%s: Filesystem corrupted (i_pos %lld)",
-			     __func__, sinfo.i_pos);
+			     __func__, new_i_pos);
 	}
 	goto out;
 }
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
index 91eebeb0c48b..af3a74bd0fbd 100644
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
 
@@ -263,10 +271,11 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
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
@@ -361,10 +370,11 @@ static int nilfs_rename(struct user_namespace *mnt_userns,
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
@@ -381,10 +391,12 @@ static int nilfs_rename(struct user_namespace *mnt_userns,
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
@@ -438,13 +450,14 @@ static int nilfs_rename(struct user_namespace *mnt_userns,
  */
 static struct dentry *nilfs_get_parent(struct dentry *child)
 {
-	unsigned long ino;
+	ino_t ino;
+	int res;
 	struct inode *inode;
 	struct nilfs_root *root;
 
-	ino = nilfs_inode_by_name(d_inode(child), &dotdot_name);
-	if (!ino)
-		return ERR_PTR(-ENOENT);
+	res = nilfs_inode_by_name(d_inode(child), &dotdot_name, &ino);
+	if (res)
+		return ERR_PTR(res);
 
 	root = NILFS_I(d_inode(child))->i_root;
 
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index a4491d29ad57..935fb5234c24 100644
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
diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index 42e3e551fa4c..212393b12c22 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -39,26 +39,13 @@
 static int udf_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *dir = file_inode(file);
-	struct udf_inode_info *iinfo = UDF_I(dir);
-	struct udf_fileident_bh fibh = { .sbh = NULL, .ebh = NULL};
-	struct fileIdentDesc *fi = NULL;
-	struct fileIdentDesc cfi;
-	udf_pblk_t block, iblock;
 	loff_t nf_pos, emit_pos = 0;
 	int flen;
-	unsigned char *fname = NULL, *copy_name = NULL;
-	unsigned char *nameptr;
-	uint16_t liu;
-	uint8_t lfi;
-	loff_t size = udf_ext0_offset(dir) + dir->i_size;
-	struct buffer_head *tmp, *bha[16];
-	struct kernel_lb_addr eloc;
-	uint32_t elen;
-	sector_t offset;
-	int i, num, ret = 0;
-	struct extent_position epos = { NULL, 0, {0, 0} };
+	unsigned char *fname = NULL;
+	int ret = 0;
 	struct super_block *sb = dir->i_sb;
 	bool pos_valid = false;
+	struct udf_fileident_iter iter;
 
 	if (ctx->pos == 0) {
 		if (!dir_emit_dot(file, ctx))
@@ -66,7 +53,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos = 1;
 	}
 	nf_pos = (ctx->pos - 1) << 2;
-	if (nf_pos >= size)
+	if (nf_pos >= dir->i_size)
 		goto out;
 
 	/*
@@ -90,138 +77,57 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 		goto out;
 	}
 
-	if (nf_pos == 0)
-		nf_pos = udf_ext0_offset(dir);
-
-	fibh.soffset = fibh.eoffset = nf_pos & (sb->s_blocksize - 1);
-	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
-		if (inode_bmap(dir, nf_pos >> sb->s_blocksize_bits,
-		    &epos, &eloc, &elen, &offset)
-		    != (EXT_RECORDED_ALLOCATED >> 30)) {
-			ret = -ENOENT;
-			goto out;
-		}
-		block = udf_get_lb_pblock(sb, &eloc, offset);
-		if ((++offset << sb->s_blocksize_bits) < elen) {
-			if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (iinfo->i_alloc_type ==
-					ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-		} else {
-			offset = 0;
-		}
-
-		if (!(fibh.sbh = fibh.ebh = udf_tread(sb, block))) {
-			ret = -EIO;
-			goto out;
-		}
-
-		if (!(offset & ((16 >> (sb->s_blocksize_bits - 9)) - 1))) {
-			i = 16 >> (sb->s_blocksize_bits - 9);
-			if (i + offset > (elen >> sb->s_blocksize_bits))
-				i = (elen >> sb->s_blocksize_bits) - offset;
-			for (num = 0; i > 0; i--) {
-				block = udf_get_lb_pblock(sb, &eloc, offset + i);
-				tmp = udf_tgetblk(sb, block);
-				if (tmp && !buffer_uptodate(tmp) && !buffer_locked(tmp))
-					bha[num++] = tmp;
-				else
-					brelse(tmp);
-			}
-			if (num) {
-				ll_rw_block(REQ_OP_READ, REQ_RAHEAD, num, bha);
-				for (i = 0; i < num; i++)
-					brelse(bha[i]);
-			}
-		}
-	}
-
-	while (nf_pos < size) {
+	for (ret = udf_fiiter_init(&iter, dir, nf_pos);
+	     !ret && iter.pos < dir->i_size;
+	     ret = udf_fiiter_advance(&iter)) {
 		struct kernel_lb_addr tloc;
-		loff_t cur_pos = nf_pos;
+		udf_pblk_t iblock;
 
-		/* Update file position only if we got past the current one */
-		if (nf_pos >= emit_pos) {
-			ctx->pos = (nf_pos >> 2) + 1;
-			pos_valid = true;
-		}
-
-		fi = udf_fileident_read(dir, &nf_pos, &fibh, &cfi, &epos, &eloc,
-					&elen, &offset);
-		if (!fi)
-			goto out;
 		/* Still not at offset where user asked us to read from? */
-		if (cur_pos < emit_pos)
+		if (iter.pos < emit_pos)
 			continue;
 
-		liu = le16_to_cpu(cfi.lengthOfImpUse);
-		lfi = cfi.lengthFileIdent;
-
-		if (fibh.sbh == fibh.ebh) {
-			nameptr = udf_get_fi_ident(fi);
-		} else {
-			int poffset;	/* Unpaded ending offset */
-
-			poffset = fibh.soffset + sizeof(struct fileIdentDesc) + liu + lfi;
-
-			if (poffset >= lfi) {
-				nameptr = (char *)(fibh.ebh->b_data + poffset - lfi);
-			} else {
-				if (!copy_name) {
-					copy_name = kmalloc(UDF_NAME_LEN,
-							    GFP_NOFS);
-					if (!copy_name) {
-						ret = -ENOMEM;
-						goto out;
-					}
-				}
-				nameptr = copy_name;
-				memcpy(nameptr, udf_get_fi_ident(fi),
-				       lfi - poffset);
-				memcpy(nameptr + lfi - poffset,
-				       fibh.ebh->b_data, poffset);
-			}
-		}
+		/* Update file position only if we got past the current one */
+		pos_valid = true;
+		ctx->pos = (iter.pos >> 2) + 1;
 
-		if ((cfi.fileCharacteristics & FID_FILE_CHAR_DELETED) != 0) {
+		if (iter.fi.fileCharacteristics & FID_FILE_CHAR_DELETED) {
 			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNDELETE))
 				continue;
 		}
 
-		if ((cfi.fileCharacteristics & FID_FILE_CHAR_HIDDEN) != 0) {
+		if (iter.fi.fileCharacteristics & FID_FILE_CHAR_HIDDEN) {
 			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNHIDE))
 				continue;
 		}
 
-		if (cfi.fileCharacteristics & FID_FILE_CHAR_PARENT) {
+		if (iter.fi.fileCharacteristics & FID_FILE_CHAR_PARENT) {
 			if (!dir_emit_dotdot(file, ctx))
-				goto out;
+				goto out_iter;
 			continue;
 		}
 
-		flen = udf_get_filename(sb, nameptr, lfi, fname, UDF_NAME_LEN);
+		flen = udf_get_filename(sb, iter.name,
+				iter.fi.lengthFileIdent, fname, UDF_NAME_LEN);
 		if (flen < 0)
 			continue;
 
-		tloc = lelb_to_cpu(cfi.icb.extLocation);
+		tloc = lelb_to_cpu(iter.fi.icb.extLocation);
 		iblock = udf_get_lb_pblock(sb, &tloc, 0);
 		if (!dir_emit(ctx, fname, flen, iblock, DT_UNKNOWN))
-			goto out;
-	} /* end while */
-
-	ctx->pos = (nf_pos >> 2) + 1;
-	pos_valid = true;
+			goto out_iter;
+	}
 
+	if (!ret) {
+		ctx->pos = (iter.pos >> 2) + 1;
+		pos_valid = true;
+	}
+out_iter:
+	udf_fiiter_release(&iter);
 out:
 	if (pos_valid)
 		file->f_version = inode_query_iversion(dir);
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-	brelse(epos.bh);
 	kfree(fname);
-	kfree(copy_name);
 
 	return ret;
 }
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 73720320f0ab..e97ffae07833 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -17,183 +17,457 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/bio.h>
+#include <linux/crc-itu-t.h>
+#include <linux/iversion.h>
 
-struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
-					 struct udf_fileident_bh *fibh,
-					 struct fileIdentDesc *cfi,
-					 struct extent_position *epos,
-					 struct kernel_lb_addr *eloc, uint32_t *elen,
-					 sector_t *offset)
+static int udf_verify_fi(struct udf_fileident_iter *iter)
 {
-	struct fileIdentDesc *fi;
-	int i, num;
-	udf_pblk_t block;
-	struct buffer_head *tmp, *bha[16];
-	struct udf_inode_info *iinfo = UDF_I(dir);
-
-	fibh->soffset = fibh->eoffset;
+	unsigned int len;
+
+	if (iter->fi.descTag.tagIdent != cpu_to_le16(TAG_IDENT_FID)) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry at pos %llu with incorrect tag %x\n",
+			iter->dir->i_ino, (unsigned long long)iter->pos,
+			le16_to_cpu(iter->fi.descTag.tagIdent));
+		return -EFSCORRUPTED;
+	}
+	len = udf_dir_entry_len(&iter->fi);
+	if (le16_to_cpu(iter->fi.lengthOfImpUse) & 3) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry at pos %llu with unaligned lenght of impUse field\n",
+			iter->dir->i_ino, (unsigned long long)iter->pos);
+		return -EFSCORRUPTED;
+	}
+	/*
+	 * This is in fact allowed by the spec due to long impUse field but
+	 * we don't support it. If there is real media with this large impUse
+	 * field, support can be added.
+	 */
+	if (len > 1 << iter->dir->i_blkbits) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has too big (%u) entry at pos %llu\n",
+			iter->dir->i_ino, len, (unsigned long long)iter->pos);
+		return -EFSCORRUPTED;
+	}
+	if (iter->pos + len > iter->dir->i_size) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry past directory size at pos %llu\n",
+			iter->dir->i_ino, (unsigned long long)iter->pos);
+		return -EFSCORRUPTED;
+	}
+	if (udf_dir_entry_len(&iter->fi) !=
+	    sizeof(struct tag) + le16_to_cpu(iter->fi.descTag.descCRCLength)) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry where CRC length (%u) does not match entry length (%u)\n",
+			iter->dir->i_ino,
+			(unsigned)le16_to_cpu(iter->fi.descTag.descCRCLength),
+			(unsigned)(udf_dir_entry_len(&iter->fi) -
+							sizeof(struct tag)));
+		return -EFSCORRUPTED;
+	}
+	return 0;
+}
 
+static int udf_copy_fi(struct udf_fileident_iter *iter)
+{
+	struct udf_inode_info *iinfo = UDF_I(iter->dir);
+	int blksize = 1 << iter->dir->i_blkbits;
+	int err, off, len, nameoff;
+
+	/* Skip copying when we are at EOF */
+	if (iter->pos >= iter->dir->i_size) {
+		iter->name = NULL;
+		return 0;
+	}
+	if (iter->dir->i_size < iter->pos + sizeof(struct fileIdentDesc)) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry straddling EOF\n",
+			iter->dir->i_ino);
+		return -EFSCORRUPTED;
+	}
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-		fi = udf_get_fileident(iinfo->i_data -
-				       (iinfo->i_efe ?
-					sizeof(struct extendedFileEntry) :
-					sizeof(struct fileEntry)),
-				       dir->i_sb->s_blocksize,
-				       &(fibh->eoffset));
-		if (!fi)
-			return NULL;
-
-		*nf_pos += fibh->eoffset - fibh->soffset;
-
-		memcpy((uint8_t *)cfi, (uint8_t *)fi,
+		memcpy(&iter->fi, iinfo->i_data + iinfo->i_lenEAttr + iter->pos,
 		       sizeof(struct fileIdentDesc));
-
-		return fi;
+		err = udf_verify_fi(iter);
+		if (err < 0)
+			return err;
+		iter->name = iinfo->i_data + iinfo->i_lenEAttr + iter->pos +
+			sizeof(struct fileIdentDesc) +
+			le16_to_cpu(iter->fi.lengthOfImpUse);
+		return 0;
 	}
 
-	if (fibh->eoffset == dir->i_sb->s_blocksize) {
-		uint32_t lextoffset = epos->offset;
-		unsigned char blocksize_bits = dir->i_sb->s_blocksize_bits;
-
-		if (udf_next_aext(dir, epos, eloc, elen, 1) !=
-		    (EXT_RECORDED_ALLOCATED >> 30))
-			return NULL;
+	off = iter->pos & (blksize - 1);
+	len = min_t(int, sizeof(struct fileIdentDesc), blksize - off);
+	memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
+	if (len < sizeof(struct fileIdentDesc))
+		memcpy((char *)(&iter->fi) + len, iter->bh[1]->b_data,
+		       sizeof(struct fileIdentDesc) - len);
+	err = udf_verify_fi(iter);
+	if (err < 0)
+		return err;
+
+	/* Handle directory entry name */
+	nameoff = off + sizeof(struct fileIdentDesc) +
+				le16_to_cpu(iter->fi.lengthOfImpUse);
+	if (off + udf_dir_entry_len(&iter->fi) <= blksize) {
+		iter->name = iter->bh[0]->b_data + nameoff;
+	} else if (nameoff >= blksize) {
+		iter->name = iter->bh[1]->b_data + (nameoff - blksize);
+	} else {
+		iter->name = iter->namebuf;
+		len = blksize - nameoff;
+		memcpy(iter->name, iter->bh[0]->b_data + nameoff, len);
+		memcpy(iter->name + len, iter->bh[1]->b_data,
+		       iter->fi.lengthFileIdent - len);
+	}
+	return 0;
+}
 
-		block = udf_get_lb_pblock(dir->i_sb, eloc, *offset);
+/* Readahead 8k once we are at 8k boundary */
+static void udf_readahead_dir(struct udf_fileident_iter *iter)
+{
+	unsigned int ralen = 16 >> (iter->dir->i_blkbits - 9);
+	struct buffer_head *tmp, *bha[16];
+	int i, num;
+	udf_pblk_t blk;
+
+	if (iter->loffset & (ralen - 1))
+		return;
+
+	if (iter->loffset + ralen > (iter->elen >> iter->dir->i_blkbits))
+		ralen = (iter->elen >> iter->dir->i_blkbits) - iter->loffset;
+	num = 0;
+	for (i = 0; i < ralen; i++) {
+		blk = udf_get_lb_pblock(iter->dir->i_sb, &iter->eloc,
+					iter->loffset + i);
+		tmp = udf_tgetblk(iter->dir->i_sb, blk);
+		if (tmp && !buffer_uptodate(tmp) && !buffer_locked(tmp))
+			bha[num++] = tmp;
+		else
+			brelse(tmp);
+	}
+	if (num) {
+		ll_rw_block(REQ_OP_READ, REQ_RAHEAD, num, bha);
+		for (i = 0; i < num; i++)
+			brelse(bha[i]);
+	}
+}
 
-		(*offset)++;
+static struct buffer_head *udf_fiiter_bread_blk(struct udf_fileident_iter *iter)
+{
+	udf_pblk_t blk;
 
-		if ((*offset << blocksize_bits) >= *elen)
-			*offset = 0;
-		else
-			epos->offset = lextoffset;
+	udf_readahead_dir(iter);
+	blk = udf_get_lb_pblock(iter->dir->i_sb, &iter->eloc, iter->loffset);
+	return udf_tread(iter->dir->i_sb, blk);
+}
 
-		brelse(fibh->sbh);
-		fibh->sbh = fibh->ebh = udf_tread(dir->i_sb, block);
-		if (!fibh->sbh)
-			return NULL;
-		fibh->soffset = fibh->eoffset = 0;
-
-		if (!(*offset & ((16 >> (blocksize_bits - 9)) - 1))) {
-			i = 16 >> (blocksize_bits - 9);
-			if (i + *offset > (*elen >> blocksize_bits))
-				i = (*elen >> blocksize_bits)-*offset;
-			for (num = 0; i > 0; i--) {
-				block = udf_get_lb_pblock(dir->i_sb, eloc,
-							  *offset + i);
-				tmp = udf_tgetblk(dir->i_sb, block);
-				if (tmp && !buffer_uptodate(tmp) &&
-						!buffer_locked(tmp))
-					bha[num++] = tmp;
-				else
-					brelse(tmp);
-			}
-			if (num) {
-				ll_rw_block(REQ_OP_READ, REQ_RAHEAD, num, bha);
-				for (i = 0; i < num; i++)
-					brelse(bha[i]);
-			}
+/*
+ * Updates loffset to point to next directory block; eloc, elen & epos are
+ * updated if we need to traverse to the next extent as well.
+ */
+static int udf_fiiter_advance_blk(struct udf_fileident_iter *iter)
+{
+	iter->loffset++;
+	if (iter->loffset < iter->elen >> iter->dir->i_blkbits)
+		return 0;
+
+	iter->loffset = 0;
+	if (udf_next_aext(iter->dir, &iter->epos, &iter->eloc, &iter->elen, 1)
+			!= (EXT_RECORDED_ALLOCATED >> 30)) {
+		if (iter->pos == iter->dir->i_size) {
+			iter->elen = 0;
+			return 0;
 		}
-	} else if (fibh->sbh != fibh->ebh) {
-		brelse(fibh->sbh);
-		fibh->sbh = fibh->ebh;
+		udf_err(iter->dir->i_sb,
+			"extent after position %llu not allocated in directory (ino %lu)\n",
+			(unsigned long long)iter->pos, iter->dir->i_ino);
+		return -EFSCORRUPTED;
 	}
+	return 0;
+}
 
-	fi = udf_get_fileident(fibh->sbh->b_data, dir->i_sb->s_blocksize,
-			       &(fibh->eoffset));
-
-	if (!fi)
-		return NULL;
+static int udf_fiiter_load_bhs(struct udf_fileident_iter *iter)
+{
+	int blksize = 1 << iter->dir->i_blkbits;
+	int off = iter->pos & (blksize - 1);
+	int err;
+	struct fileIdentDesc *fi;
 
-	*nf_pos += fibh->eoffset - fibh->soffset;
+	/* Is there any further extent we can map from? */
+	if (!iter->bh[0] && iter->elen) {
+		iter->bh[0] = udf_fiiter_bread_blk(iter);
+		if (!iter->bh[0]) {
+			err = -ENOMEM;
+			goto out_brelse;
+		}
+		if (!buffer_uptodate(iter->bh[0])) {
+			err = -EIO;
+			goto out_brelse;
+		}
+	}
+	/* There's no next block so we are done */
+	if (iter->pos >= iter->dir->i_size)
+		return 0;
+	/* Need to fetch next block as well? */
+	if (off + sizeof(struct fileIdentDesc) > blksize)
+		goto fetch_next;
+	fi = (struct fileIdentDesc *)(iter->bh[0]->b_data + off);
+	/* Need to fetch next block to get name? */
+	if (off + udf_dir_entry_len(fi) > blksize) {
+fetch_next:
+		udf_fiiter_advance_blk(iter);
+		iter->bh[1] = udf_fiiter_bread_blk(iter);
+		if (!iter->bh[1]) {
+			err = -ENOMEM;
+			goto out_brelse;
+		}
+		if (!buffer_uptodate(iter->bh[1])) {
+			err = -EIO;
+			goto out_brelse;
+		}
+	}
+	return 0;
+out_brelse:
+	brelse(iter->bh[0]);
+	brelse(iter->bh[1]);
+	iter->bh[0] = iter->bh[1] = NULL;
+	return err;
+}
 
-	if (fibh->eoffset <= dir->i_sb->s_blocksize) {
-		memcpy((uint8_t *)cfi, (uint8_t *)fi,
-		       sizeof(struct fileIdentDesc));
-	} else if (fibh->eoffset > dir->i_sb->s_blocksize) {
-		uint32_t lextoffset = epos->offset;
+int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
+		    loff_t pos)
+{
+	struct udf_inode_info *iinfo = UDF_I(dir);
+	int err = 0;
+
+	iter->dir = dir;
+	iter->bh[0] = iter->bh[1] = NULL;
+	iter->pos = pos;
+	iter->elen = 0;
+	iter->epos.bh = NULL;
+	iter->name = NULL;
+
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
+		return udf_copy_fi(iter);
+
+	if (inode_bmap(dir, iter->pos >> dir->i_blkbits, &iter->epos,
+		       &iter->eloc, &iter->elen, &iter->loffset) !=
+	    (EXT_RECORDED_ALLOCATED >> 30)) {
+		if (pos == dir->i_size)
+			return 0;
+		udf_err(dir->i_sb,
+			"position %llu not allocated in directory (ino %lu)\n",
+			(unsigned long long)pos, dir->i_ino);
+		return -EFSCORRUPTED;
+	}
+	err = udf_fiiter_load_bhs(iter);
+	if (err < 0)
+		return err;
+	err = udf_copy_fi(iter);
+	if (err < 0) {
+		udf_fiiter_release(iter);
+		return err;
+	}
+	return 0;
+}
 
-		if (udf_next_aext(dir, epos, eloc, elen, 1) !=
-		    (EXT_RECORDED_ALLOCATED >> 30))
-			return NULL;
+int udf_fiiter_advance(struct udf_fileident_iter *iter)
+{
+	unsigned int oldoff, len;
+	int blksize = 1 << iter->dir->i_blkbits;
+	int err;
+
+	oldoff = iter->pos & (blksize - 1);
+	len = udf_dir_entry_len(&iter->fi);
+	iter->pos += len;
+	if (UDF_I(iter->dir)->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
+		if (oldoff + len >= blksize) {
+			brelse(iter->bh[0]);
+			iter->bh[0] = NULL;
+			/* Next block already loaded? */
+			if (iter->bh[1]) {
+				iter->bh[0] = iter->bh[1];
+				iter->bh[1] = NULL;
+			} else {
+				udf_fiiter_advance_blk(iter);
+			}
+		}
+		err = udf_fiiter_load_bhs(iter);
+		if (err < 0)
+			return err;
+	}
+	return udf_copy_fi(iter);
+}
 
-		block = udf_get_lb_pblock(dir->i_sb, eloc, *offset);
+void udf_fiiter_release(struct udf_fileident_iter *iter)
+{
+	iter->dir = NULL;
+	brelse(iter->bh[0]);
+	brelse(iter->bh[1]);
+	iter->bh[0] = iter->bh[1] = NULL;
+}
 
-		(*offset)++;
+static void udf_copy_to_bufs(void *buf1, int len1, void *buf2, int len2,
+			     int off, void *src, int len)
+{
+	int copy;
+
+	if (off >= len1) {
+		off -= len1;
+	} else {
+		copy = min(off + len, len1) - off;
+		memcpy(buf1 + off, src, copy);
+		src += copy;
+		len -= copy;
+		off = 0;
+	}
+	if (len > 0) {
+		if (WARN_ON_ONCE(off + len > len2 || !buf2))
+			return;
+		memcpy(buf2 + off, src, len);
+	}
+}
 
-		if ((*offset << dir->i_sb->s_blocksize_bits) >= *elen)
-			*offset = 0;
-		else
-			epos->offset = lextoffset;
+static uint16_t udf_crc_fi_bufs(void *buf1, int len1, void *buf2, int len2,
+				int off, int len)
+{
+	int copy;
+	uint16_t crc = 0;
+
+	if (off >= len1) {
+		off -= len1;
+	} else {
+		copy = min(off + len, len1) - off;
+		crc = crc_itu_t(crc, buf1 + off, copy);
+		len -= copy;
+		off = 0;
+	}
+	if (len > 0) {
+		if (WARN_ON_ONCE(off + len > len2 || !buf2))
+			return 0;
+		crc = crc_itu_t(crc, buf2 + off, len);
+	}
+	return crc;
+}
 
-		fibh->soffset -= dir->i_sb->s_blocksize;
-		fibh->eoffset -= dir->i_sb->s_blocksize;
+static void udf_copy_fi_to_bufs(char *buf1, int len1, char *buf2, int len2,
+				int off, struct fileIdentDesc *fi,
+				uint8_t *impuse, uint8_t *name)
+{
+	uint16_t crc;
+	int fioff = off;
+	int crcoff = off + sizeof(struct tag);
+	unsigned int crclen = udf_dir_entry_len(fi) - sizeof(struct tag);
+
+	udf_copy_to_bufs(buf1, len1, buf2, len2, off, fi,
+			 sizeof(struct fileIdentDesc));
+	off += sizeof(struct fileIdentDesc);
+	if (impuse)
+		udf_copy_to_bufs(buf1, len1, buf2, len2, off, impuse,
+				 le16_to_cpu(fi->lengthOfImpUse));
+	off += le16_to_cpu(fi->lengthOfImpUse);
+	if (name)
+		udf_copy_to_bufs(buf1, len1, buf2, len2, off, name,
+				 fi->lengthFileIdent);
+
+	crc = udf_crc_fi_bufs(buf1, len1, buf2, len2, crcoff, crclen);
+	fi->descTag.descCRC = cpu_to_le16(crc);
+	fi->descTag.descCRCLength = cpu_to_le16(crclen);
+	fi->descTag.tagChecksum = udf_tag_checksum(&fi->descTag);
+
+	udf_copy_to_bufs(buf1, len1, buf2, len2, fioff, fi, sizeof(struct tag));
+}
 
-		fibh->ebh = udf_tread(dir->i_sb, block);
-		if (!fibh->ebh)
-			return NULL;
+void udf_fiiter_write_fi(struct udf_fileident_iter *iter, uint8_t *impuse)
+{
+	struct udf_inode_info *iinfo = UDF_I(iter->dir);
+	void *buf1, *buf2 = NULL;
+	int len1, len2 = 0, off;
+	int blksize = 1 << iter->dir->i_blkbits;
 
-		if (sizeof(struct fileIdentDesc) > -fibh->soffset) {
-			int fi_len;
+	off = iter->pos & (blksize - 1);
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		buf1 = iinfo->i_data + iinfo->i_lenEAttr;
+		len1 = iter->dir->i_size;
+	} else {
+		buf1 = iter->bh[0]->b_data;
+		len1 = blksize;
+		if (iter->bh[1]) {
+			buf2 = iter->bh[1]->b_data;
+			len2 = blksize;
+		}
+	}
 
-			memcpy((uint8_t *)cfi, (uint8_t *)fi, -fibh->soffset);
-			memcpy((uint8_t *)cfi - fibh->soffset,
-			       fibh->ebh->b_data,
-			       sizeof(struct fileIdentDesc) + fibh->soffset);
+	udf_copy_fi_to_bufs(buf1, len1, buf2, len2, off, &iter->fi, impuse,
+			    iter->name == iter->namebuf ? iter->name : NULL);
 
-			fi_len = udf_dir_entry_len(cfi);
-			*nf_pos += fi_len - (fibh->eoffset - fibh->soffset);
-			fibh->eoffset = fibh->soffset + fi_len;
-		} else {
-			memcpy((uint8_t *)cfi, (uint8_t *)fi,
-			       sizeof(struct fileIdentDesc));
-		}
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		mark_inode_dirty(iter->dir);
+	} else {
+		mark_buffer_dirty_inode(iter->bh[0], iter->dir);
+		if (iter->bh[1])
+			mark_buffer_dirty_inode(iter->bh[1], iter->dir);
 	}
-	/* Got last entry outside of dir size - fs is corrupted! */
-	if (*nf_pos > dir->i_size)
-		return NULL;
-	return fi;
+	inode_inc_iversion(iter->dir);
 }
 
-struct fileIdentDesc *udf_get_fileident(void *buffer, int bufsize, int *offset)
+void udf_fiiter_update_elen(struct udf_fileident_iter *iter, uint32_t new_elen)
 {
-	struct fileIdentDesc *fi;
-	int lengthThisIdent;
-	uint8_t *ptr;
-	int padlen;
+	struct udf_inode_info *iinfo = UDF_I(iter->dir);
+	int diff = new_elen - iter->elen;
+
+	/* Skip update when we already went past the last extent */
+	if (!iter->elen)
+		return;
+	iter->elen = new_elen;
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
+		iter->epos.offset -= sizeof(struct short_ad);
+	else if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
+		iter->epos.offset -= sizeof(struct long_ad);
+	udf_write_aext(iter->dir, &iter->epos, &iter->eloc, iter->elen, 1);
+	iinfo->i_lenExtents += diff;
+	mark_inode_dirty(iter->dir);
+}
 
-	if ((!buffer) || (!offset)) {
-		udf_debug("invalidparms, buffer=%p, offset=%p\n",
-			  buffer, offset);
-		return NULL;
+/* Append new block to directory. @iter is expected to point at EOF */
+int udf_fiiter_append_blk(struct udf_fileident_iter *iter)
+{
+	struct udf_inode_info *iinfo = UDF_I(iter->dir);
+	int blksize = 1 << iter->dir->i_blkbits;
+	struct buffer_head *bh;
+	sector_t block;
+	uint32_t old_elen = iter->elen;
+	int err;
+
+	if (WARN_ON_ONCE(iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB))
+		return -EINVAL;
+
+	/* Round up last extent in the file */
+	udf_fiiter_update_elen(iter, ALIGN(iter->elen, blksize));
+
+	/* Allocate new block and refresh mapping information */
+	block = iinfo->i_lenExtents >> iter->dir->i_blkbits;
+	bh = udf_bread(iter->dir, block, 1, &err);
+	if (!bh) {
+		udf_fiiter_update_elen(iter, old_elen);
+		return err;
 	}
-
-	ptr = buffer;
-
-	if ((*offset > 0) && (*offset < bufsize))
-		ptr += *offset;
-	fi = (struct fileIdentDesc *)ptr;
-	if (fi->descTag.tagIdent != cpu_to_le16(TAG_IDENT_FID)) {
-		udf_debug("0x%x != TAG_IDENT_FID\n",
-			  le16_to_cpu(fi->descTag.tagIdent));
-		udf_debug("offset: %d sizeof: %lu bufsize: %d\n",
-			  *offset, (unsigned long)sizeof(struct fileIdentDesc),
-			  bufsize);
-		return NULL;
+	if (inode_bmap(iter->dir, block, &iter->epos, &iter->eloc, &iter->elen,
+		       &iter->loffset) != (EXT_RECORDED_ALLOCATED >> 30)) {
+		udf_err(iter->dir->i_sb,
+			"block %llu not allocated in directory (ino %lu)\n",
+			(unsigned long long)block, iter->dir->i_ino);
+		return -EFSCORRUPTED;
 	}
-	if ((*offset + sizeof(struct fileIdentDesc)) > bufsize)
-		lengthThisIdent = sizeof(struct fileIdentDesc);
-	else
-		lengthThisIdent = sizeof(struct fileIdentDesc) +
-			fi->lengthFileIdent + le16_to_cpu(fi->lengthOfImpUse);
-
-	/* we need to figure padding, too! */
-	padlen = lengthThisIdent % UDF_NAME_PAD;
-	if (padlen)
-		lengthThisIdent += (UDF_NAME_PAD - padlen);
-	*offset = *offset + lengthThisIdent;
-
-	return fi;
+	if (!(iter->pos & (blksize - 1))) {
+		brelse(iter->bh[0]);
+		iter->bh[0] = bh;
+	} else {
+		iter->bh[1] = bh;
+	}
+	return 0;
 }
 
 struct short_ad *udf_get_fileshortad(uint8_t *ptr, int maxoffset, uint32_t *offset,
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index da6fb28b4eea..e68490991f5c 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -324,96 +324,6 @@ int udf_expand_file_adinicb(struct inode *inode)
 	return err;
 }
 
-struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
-					    udf_pblk_t *block, int *err)
-{
-	udf_pblk_t newblock;
-	struct buffer_head *dbh = NULL;
-	struct kernel_lb_addr eloc;
-	uint8_t alloctype;
-	struct extent_position epos;
-
-	struct udf_fileident_bh sfibh, dfibh;
-	loff_t f_pos = udf_ext0_offset(inode);
-	int size = udf_ext0_offset(inode) + inode->i_size;
-	struct fileIdentDesc cfi, *sfi, *dfi;
-	struct udf_inode_info *iinfo = UDF_I(inode);
-
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
-		alloctype = ICBTAG_FLAG_AD_SHORT;
-	else
-		alloctype = ICBTAG_FLAG_AD_LONG;
-
-	if (!inode->i_size) {
-		iinfo->i_alloc_type = alloctype;
-		mark_inode_dirty(inode);
-		return NULL;
-	}
-
-	/* alloc block, and copy data to it */
-	*block = udf_new_block(inode->i_sb, inode,
-			       iinfo->i_location.partitionReferenceNum,
-			       iinfo->i_location.logicalBlockNum, err);
-	if (!(*block))
-		return NULL;
-	newblock = udf_get_pblock(inode->i_sb, *block,
-				  iinfo->i_location.partitionReferenceNum,
-				0);
-	if (!newblock)
-		return NULL;
-	dbh = udf_tgetblk(inode->i_sb, newblock);
-	if (!dbh)
-		return NULL;
-	lock_buffer(dbh);
-	memset(dbh->b_data, 0x00, inode->i_sb->s_blocksize);
-	set_buffer_uptodate(dbh);
-	unlock_buffer(dbh);
-	mark_buffer_dirty_inode(dbh, inode);
-
-	sfibh.soffset = sfibh.eoffset =
-			f_pos & (inode->i_sb->s_blocksize - 1);
-	sfibh.sbh = sfibh.ebh = NULL;
-	dfibh.soffset = dfibh.eoffset = 0;
-	dfibh.sbh = dfibh.ebh = dbh;
-	while (f_pos < size) {
-		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
-		sfi = udf_fileident_read(inode, &f_pos, &sfibh, &cfi, NULL,
-					 NULL, NULL, NULL);
-		if (!sfi) {
-			brelse(dbh);
-			return NULL;
-		}
-		iinfo->i_alloc_type = alloctype;
-		sfi->descTag.tagLocation = cpu_to_le32(*block);
-		dfibh.soffset = dfibh.eoffset;
-		dfibh.eoffset += (sfibh.eoffset - sfibh.soffset);
-		dfi = (struct fileIdentDesc *)(dbh->b_data + dfibh.soffset);
-		if (udf_write_fi(inode, sfi, dfi, &dfibh, sfi->impUse,
-				 udf_get_fi_ident(sfi))) {
-			iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
-			brelse(dbh);
-			return NULL;
-		}
-	}
-	mark_buffer_dirty_inode(dbh, inode);
-
-	memset(iinfo->i_data + iinfo->i_lenEAttr, 0, iinfo->i_lenAlloc);
-	iinfo->i_lenAlloc = 0;
-	eloc.logicalBlockNum = *block;
-	eloc.partitionReferenceNum =
-				iinfo->i_location.partitionReferenceNum;
-	iinfo->i_lenExtents = inode->i_size;
-	epos.bh = NULL;
-	epos.block = iinfo->i_location;
-	epos.offset = udf_file_entry_alloc_offset(inode);
-	udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
-	/* UniqueID stuff */
-
-	brelse(epos.bh);
-	mark_inode_dirty(inode);
-	return dbh;
-}
-
 static int udf_get_block(struct inode *inode, sector_t block,
 			 struct buffer_head *bh_result, int create)
 {
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 0e30a50060d9..5e39cbc74524 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -41,283 +41,93 @@ static inline int udf_match(int len1, const unsigned char *name1, int len2,
 	return !memcmp(name1, name2, len1);
 }
 
-int udf_write_fi(struct inode *inode, struct fileIdentDesc *cfi,
-		 struct fileIdentDesc *sfi, struct udf_fileident_bh *fibh,
-		 uint8_t *impuse, uint8_t *fileident)
-{
-	uint16_t crclen = fibh->eoffset - fibh->soffset - sizeof(struct tag);
-	uint16_t crc;
-	int offset;
-	uint16_t liu = le16_to_cpu(cfi->lengthOfImpUse);
-	uint8_t lfi = cfi->lengthFileIdent;
-	int padlen = fibh->eoffset - fibh->soffset - liu - lfi -
-		sizeof(struct fileIdentDesc);
-	int adinicb = 0;
-
-	if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		adinicb = 1;
-
-	offset = fibh->soffset + sizeof(struct fileIdentDesc);
-
-	if (impuse) {
-		if (adinicb || (offset + liu < 0)) {
-			memcpy((uint8_t *)sfi->impUse, impuse, liu);
-		} else if (offset >= 0) {
-			memcpy(fibh->ebh->b_data + offset, impuse, liu);
-		} else {
-			memcpy((uint8_t *)sfi->impUse, impuse, -offset);
-			memcpy(fibh->ebh->b_data, impuse - offset,
-				liu + offset);
-		}
-	}
-
-	offset += liu;
-
-	if (fileident) {
-		if (adinicb || (offset + lfi < 0)) {
-			memcpy(sfi->impUse + liu, fileident, lfi);
-		} else if (offset >= 0) {
-			memcpy(fibh->ebh->b_data + offset, fileident, lfi);
-		} else {
-			memcpy(sfi->impUse + liu, fileident, -offset);
-			memcpy(fibh->ebh->b_data, fileident - offset,
-				lfi + offset);
-		}
-	}
-
-	offset += lfi;
-
-	if (adinicb || (offset + padlen < 0)) {
-		memset(sfi->impUse + liu + lfi, 0x00, padlen);
-	} else if (offset >= 0) {
-		memset(fibh->ebh->b_data + offset, 0x00, padlen);
-	} else {
-		memset(sfi->impUse + liu + lfi, 0x00, -offset);
-		memset(fibh->ebh->b_data, 0x00, padlen + offset);
-	}
-
-	crc = crc_itu_t(0, (uint8_t *)cfi + sizeof(struct tag),
-		      sizeof(struct fileIdentDesc) - sizeof(struct tag));
-
-	if (fibh->sbh == fibh->ebh) {
-		crc = crc_itu_t(crc, (uint8_t *)sfi->impUse,
-			      crclen + sizeof(struct tag) -
-			      sizeof(struct fileIdentDesc));
-	} else if (sizeof(struct fileIdentDesc) >= -fibh->soffset) {
-		crc = crc_itu_t(crc, fibh->ebh->b_data +
-					sizeof(struct fileIdentDesc) +
-					fibh->soffset,
-			      crclen + sizeof(struct tag) -
-					sizeof(struct fileIdentDesc));
-	} else {
-		crc = crc_itu_t(crc, (uint8_t *)sfi->impUse,
-			      -fibh->soffset - sizeof(struct fileIdentDesc));
-		crc = crc_itu_t(crc, fibh->ebh->b_data, fibh->eoffset);
-	}
-
-	cfi->descTag.descCRC = cpu_to_le16(crc);
-	cfi->descTag.descCRCLength = cpu_to_le16(crclen);
-	cfi->descTag.tagChecksum = udf_tag_checksum(&cfi->descTag);
-
-	if (adinicb || (sizeof(struct fileIdentDesc) <= -fibh->soffset)) {
-		memcpy((uint8_t *)sfi, (uint8_t *)cfi,
-			sizeof(struct fileIdentDesc));
-	} else {
-		memcpy((uint8_t *)sfi, (uint8_t *)cfi, -fibh->soffset);
-		memcpy(fibh->ebh->b_data, (uint8_t *)cfi - fibh->soffset,
-		       sizeof(struct fileIdentDesc) + fibh->soffset);
-	}
-
-	if (adinicb) {
-		mark_inode_dirty(inode);
-	} else {
-		if (fibh->sbh != fibh->ebh)
-			mark_buffer_dirty_inode(fibh->ebh, inode);
-		mark_buffer_dirty_inode(fibh->sbh, inode);
-	}
-	inode_inc_iversion(inode);
-
-	return 0;
-}
-
 /**
- * udf_find_entry - find entry in given directory.
+ * udf_fiiter_find_entry - find entry in given directory.
  *
  * @dir:	directory inode to search in
  * @child:	qstr of the name
- * @fibh:	buffer head / inode with file identifier descriptor we found
- * @cfi:	found file identifier descriptor with given name
+ * @iter:	iter to use for searching
  *
  * This function searches in the directory @dir for a file name @child. When
- * found, @fibh points to the buffer head(s) (bh is NULL for in ICB
- * directories) containing the file identifier descriptor (FID). In that case
- * the function returns pointer to the FID in the buffer or inode - but note
- * that FID may be split among two buffers (blocks) so accessing it via that
- * pointer isn't easily possible. This pointer can be used only as an iterator
- * for other directory manipulation functions. For inspection of the FID @cfi
- * can be used - the found FID is copied there.
+ * found, @iter points to the position in the directory with given entry.
  *
- * Returns pointer to FID, NULL when nothing found, or error code.
+ * Returns 0 on success, < 0 on error (including -ENOENT).
  */
-static struct fileIdentDesc *udf_find_entry(struct inode *dir,
-					    const struct qstr *child,
-					    struct udf_fileident_bh *fibh,
-					    struct fileIdentDesc *cfi)
+static int udf_fiiter_find_entry(struct inode *dir, const struct qstr *child,
+				 struct udf_fileident_iter *iter)
 {
-	struct fileIdentDesc *fi = NULL;
-	loff_t f_pos;
-	udf_pblk_t block;
 	int flen;
-	unsigned char *fname = NULL, *copy_name = NULL;
-	unsigned char *nameptr;
-	uint8_t lfi;
-	uint16_t liu;
-	loff_t size;
-	struct kernel_lb_addr eloc;
-	uint32_t elen;
-	sector_t offset;
-	struct extent_position epos = {};
-	struct udf_inode_info *dinfo = UDF_I(dir);
+	unsigned char *fname = NULL;
+	struct super_block *sb = dir->i_sb;
 	int isdotdot = child->len == 2 &&
 		child->name[0] == '.' && child->name[1] == '.';
-	struct super_block *sb = dir->i_sb;
-
-	size = udf_ext0_offset(dir) + dir->i_size;
-	f_pos = udf_ext0_offset(dir);
-
-	fibh->sbh = fibh->ebh = NULL;
-	fibh->soffset = fibh->eoffset = f_pos & (sb->s_blocksize - 1);
-	if (dinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
-		if (inode_bmap(dir, f_pos >> sb->s_blocksize_bits, &epos,
-		    &eloc, &elen, &offset) != (EXT_RECORDED_ALLOCATED >> 30)) {
-			fi = ERR_PTR(-EIO);
-			goto out_err;
-		}
-
-		block = udf_get_lb_pblock(sb, &eloc, offset);
-		if ((++offset << sb->s_blocksize_bits) < elen) {
-			if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-		} else
-			offset = 0;
-
-		fibh->sbh = fibh->ebh = udf_tread(sb, block);
-		if (!fibh->sbh) {
-			fi = ERR_PTR(-EIO);
-			goto out_err;
-		}
-	}
+	int ret;
 
 	fname = kmalloc(UDF_NAME_LEN, GFP_NOFS);
-	if (!fname) {
-		fi = ERR_PTR(-ENOMEM);
-		goto out_err;
-	}
-
-	while (f_pos < size) {
-		fi = udf_fileident_read(dir, &f_pos, fibh, cfi, &epos, &eloc,
-					&elen, &offset);
-		if (!fi) {
-			fi = ERR_PTR(-EIO);
-			goto out_err;
-		}
-
-		liu = le16_to_cpu(cfi->lengthOfImpUse);
-		lfi = cfi->lengthFileIdent;
-
-		if (fibh->sbh == fibh->ebh) {
-			nameptr = udf_get_fi_ident(fi);
-		} else {
-			int poffset;	/* Unpaded ending offset */
-
-			poffset = fibh->soffset + sizeof(struct fileIdentDesc) +
-					liu + lfi;
-
-			if (poffset >= lfi)
-				nameptr = (uint8_t *)(fibh->ebh->b_data +
-						      poffset - lfi);
-			else {
-				if (!copy_name) {
-					copy_name = kmalloc(UDF_NAME_LEN_CS0,
-							    GFP_NOFS);
-					if (!copy_name) {
-						fi = ERR_PTR(-ENOMEM);
-						goto out_err;
-					}
-				}
-				nameptr = copy_name;
-				memcpy(nameptr, udf_get_fi_ident(fi),
-					lfi - poffset);
-				memcpy(nameptr + lfi - poffset,
-					fibh->ebh->b_data, poffset);
-			}
-		}
+	if (!fname)
+		return -ENOMEM;
 
-		if ((cfi->fileCharacteristics & FID_FILE_CHAR_DELETED) != 0) {
+	for (ret = udf_fiiter_init(iter, dir, 0);
+	     !ret && iter->pos < dir->i_size;
+	     ret = udf_fiiter_advance(iter)) {
+		if (iter->fi.fileCharacteristics & FID_FILE_CHAR_DELETED) {
 			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNDELETE))
 				continue;
 		}
 
-		if ((cfi->fileCharacteristics & FID_FILE_CHAR_HIDDEN) != 0) {
+		if (iter->fi.fileCharacteristics & FID_FILE_CHAR_HIDDEN) {
 			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNHIDE))
 				continue;
 		}
 
-		if ((cfi->fileCharacteristics & FID_FILE_CHAR_PARENT) &&
+		if ((iter->fi.fileCharacteristics & FID_FILE_CHAR_PARENT) &&
 		    isdotdot)
 			goto out_ok;
 
-		if (!lfi)
+		if (!iter->fi.lengthFileIdent)
 			continue;
 
-		flen = udf_get_filename(sb, nameptr, lfi, fname, UDF_NAME_LEN);
+		flen = udf_get_filename(sb, iter->name,
+				iter->fi.lengthFileIdent, fname, UDF_NAME_LEN);
 		if (flen < 0) {
-			fi = ERR_PTR(flen);
+			ret = flen;
 			goto out_err;
 		}
 
 		if (udf_match(flen, fname, child->len, child->name))
 			goto out_ok;
 	}
+	if (!ret)
+		ret = -ENOENT;
 
-	fi = NULL;
 out_err:
-	if (fibh->sbh != fibh->ebh)
-		brelse(fibh->ebh);
-	brelse(fibh->sbh);
+	udf_fiiter_release(iter);
 out_ok:
-	brelse(epos.bh);
 	kfree(fname);
-	kfree(copy_name);
 
-	return fi;
+	return ret;
 }
 
 static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
 				 unsigned int flags)
 {
 	struct inode *inode = NULL;
-	struct fileIdentDesc cfi;
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc *fi;
+	struct udf_fileident_iter iter;
+	int err;
 
 	if (dentry->d_name.len > UDF_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	fi = udf_find_entry(dir, &dentry->d_name, &fibh, &cfi);
-	if (IS_ERR(fi))
-		return ERR_CAST(fi);
+	err = udf_fiiter_find_entry(dir, &dentry->d_name, &iter);
+	if (err < 0 && err != -ENOENT)
+		return ERR_PTR(err);
 
-	if (fi) {
+	if (err == 0) {
 		struct kernel_lb_addr loc;
 
-		if (fibh.sbh != fibh.ebh)
-			brelse(fibh.ebh);
-		brelse(fibh.sbh);
+		loc = lelb_to_cpu(iter.fi.icb.extLocation);
+		udf_fiiter_release(&iter);
 
-		loc = lelb_to_cpu(cfi.icb.extLocation);
 		inode = udf_iget(dir->i_sb, &loc);
 		if (IS_ERR(inode))
 			return ERR_CAST(inode);
@@ -326,281 +136,227 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
 	return d_splice_alias(inode, dentry);
 }
 
-static struct fileIdentDesc *udf_add_entry(struct inode *dir,
-					   struct dentry *dentry,
-					   struct udf_fileident_bh *fibh,
-					   struct fileIdentDesc *cfi, int *err)
+static int udf_expand_dir_adinicb(struct inode *inode, udf_pblk_t *block)
 {
-	struct super_block *sb = dir->i_sb;
-	struct fileIdentDesc *fi = NULL;
-	unsigned char *name = NULL;
-	int namelen;
-	loff_t f_pos;
-	loff_t size = udf_ext0_offset(dir) + dir->i_size;
-	int nfidlen;
-	udf_pblk_t block;
+	udf_pblk_t newblock;
+	struct buffer_head *dbh = NULL;
 	struct kernel_lb_addr eloc;
-	uint32_t elen = 0;
-	sector_t offset;
-	struct extent_position epos = {};
-	struct udf_inode_info *dinfo;
+	struct extent_position epos;
+	uint8_t alloctype;
+	struct udf_inode_info *iinfo = UDF_I(inode);
+	struct udf_fileident_iter iter;
+	uint8_t *impuse;
+	int ret;
 
-	fibh->sbh = fibh->ebh = NULL;
-	name = kmalloc(UDF_NAME_LEN_CS0, GFP_NOFS);
-	if (!name) {
-		*err = -ENOMEM;
-		goto out_err;
-	}
+	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
+		alloctype = ICBTAG_FLAG_AD_SHORT;
+	else
+		alloctype = ICBTAG_FLAG_AD_LONG;
 
-	if (dentry) {
-		if (!dentry->d_name.len) {
-			*err = -EINVAL;
-			goto out_err;
-		}
-		namelen = udf_put_filename(sb, dentry->d_name.name,
-					   dentry->d_name.len,
-					   name, UDF_NAME_LEN_CS0);
-		if (!namelen) {
-			*err = -ENAMETOOLONG;
-			goto out_err;
-		}
-	} else {
-		namelen = 0;
+	if (!inode->i_size) {
+		iinfo->i_alloc_type = alloctype;
+		mark_inode_dirty(inode);
+		return 0;
 	}
 
-	nfidlen = ALIGN(sizeof(struct fileIdentDesc) + namelen, UDF_NAME_PAD);
-
-	f_pos = udf_ext0_offset(dir);
-
-	fibh->soffset = fibh->eoffset = f_pos & (dir->i_sb->s_blocksize - 1);
-	dinfo = UDF_I(dir);
-	if (dinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
-		if (inode_bmap(dir, f_pos >> dir->i_sb->s_blocksize_bits, &epos,
-		    &eloc, &elen, &offset) != (EXT_RECORDED_ALLOCATED >> 30)) {
-			block = udf_get_lb_pblock(dir->i_sb,
-					&dinfo->i_location, 0);
-			fibh->soffset = fibh->eoffset = sb->s_blocksize;
-			goto add;
-		}
-		block = udf_get_lb_pblock(dir->i_sb, &eloc, offset);
-		if ((++offset << dir->i_sb->s_blocksize_bits) < elen) {
-			if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-		} else
-			offset = 0;
-
-		fibh->sbh = fibh->ebh = udf_tread(dir->i_sb, block);
-		if (!fibh->sbh) {
-			*err = -EIO;
-			goto out_err;
-		}
+	/* alloc block, and copy data to it */
+	*block = udf_new_block(inode->i_sb, inode,
+			       iinfo->i_location.partitionReferenceNum,
+			       iinfo->i_location.logicalBlockNum, &ret);
+	if (!(*block))
+		return ret;
+	newblock = udf_get_pblock(inode->i_sb, *block,
+				  iinfo->i_location.partitionReferenceNum,
+				0);
+	if (newblock == 0xffffffff)
+		return -EFSCORRUPTED;
+	dbh = udf_tgetblk(inode->i_sb, newblock);
+	if (!dbh)
+		return -ENOMEM;
+	lock_buffer(dbh);
+	memcpy(dbh->b_data, iinfo->i_data, inode->i_size);
+	memset(dbh->b_data + inode->i_size, 0,
+	       inode->i_sb->s_blocksize - inode->i_size);
+	set_buffer_uptodate(dbh);
+	unlock_buffer(dbh);
+
+	/* Drop inline data, add block instead */
+	iinfo->i_alloc_type = alloctype;
+	memset(iinfo->i_data + iinfo->i_lenEAttr, 0, iinfo->i_lenAlloc);
+	iinfo->i_lenAlloc = 0;
+	eloc.logicalBlockNum = *block;
+	eloc.partitionReferenceNum =
+				iinfo->i_location.partitionReferenceNum;
+	iinfo->i_lenExtents = inode->i_size;
+	epos.bh = NULL;
+	epos.block = iinfo->i_location;
+	epos.offset = udf_file_entry_alloc_offset(inode);
+	ret = udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
+	brelse(epos.bh);
+	if (ret < 0) {
+		brelse(dbh);
+		udf_free_blocks(inode->i_sb, inode, &eloc, 0, 1);
+		return ret;
+	}
+	mark_inode_dirty(inode);
 
-		block = dinfo->i_location.logicalBlockNum;
+	/* Now fixup tags in moved directory entries */
+	for (ret = udf_fiiter_init(&iter, inode, 0);
+	     !ret && iter.pos < inode->i_size;
+	     ret = udf_fiiter_advance(&iter)) {
+		iter.fi.descTag.tagLocation = cpu_to_le32(*block);
+		if (iter.fi.lengthOfImpUse != cpu_to_le16(0))
+			impuse = dbh->b_data + iter.pos +
+						sizeof(struct fileIdentDesc);
+		else
+			impuse = NULL;
+		udf_fiiter_write_fi(&iter, impuse);
 	}
+	brelse(dbh);
+	/*
+	 * We don't expect the iteration to fail as the directory has been
+	 * already verified to be correct
+	 */
+	WARN_ON_ONCE(ret);
+	udf_fiiter_release(&iter);
+
+	return 0;
+}
 
-	while (f_pos < size) {
-		fi = udf_fileident_read(dir, &f_pos, fibh, cfi, &epos, &eloc,
-					&elen, &offset);
+static int udf_fiiter_add_entry(struct inode *dir, struct dentry *dentry,
+				struct udf_fileident_iter *iter)
+{
+	struct udf_inode_info *dinfo = UDF_I(dir);
+	int nfidlen, namelen = 0;
+	int ret;
+	int off, blksize = 1 << dir->i_blkbits;
+	udf_pblk_t block;
+	char name[UDF_NAME_LEN_CS0];
 
-		if (!fi) {
-			*err = -EIO;
-			goto out_err;
-		}
+	if (dentry) {
+		if (!dentry->d_name.len)
+			return -EINVAL;
+		namelen = udf_put_filename(dir->i_sb, dentry->d_name.name,
+					   dentry->d_name.len,
+					   name, UDF_NAME_LEN_CS0);
+		if (!namelen)
+			return -ENAMETOOLONG;
+	}
+	nfidlen = ALIGN(sizeof(struct fileIdentDesc) + namelen, UDF_NAME_PAD);
 
-		if ((cfi->fileCharacteristics & FID_FILE_CHAR_DELETED) != 0) {
-			if (udf_dir_entry_len(cfi) == nfidlen) {
-				cfi->descTag.tagSerialNum = cpu_to_le16(1);
-				cfi->fileVersionNum = cpu_to_le16(1);
-				cfi->fileCharacteristics = 0;
-				cfi->lengthFileIdent = namelen;
-				cfi->lengthOfImpUse = cpu_to_le16(0);
-				if (!udf_write_fi(dir, cfi, fi, fibh, NULL,
-						  name))
-					goto out_ok;
-				else {
-					*err = -EIO;
-					goto out_err;
-				}
+	for (ret = udf_fiiter_init(iter, dir, 0);
+	     !ret && iter->pos < dir->i_size;
+	     ret = udf_fiiter_advance(iter)) {
+		if (iter->fi.fileCharacteristics & FID_FILE_CHAR_DELETED) {
+			if (udf_dir_entry_len(&iter->fi) == nfidlen) {
+				iter->fi.descTag.tagSerialNum = cpu_to_le16(1);
+				iter->fi.fileVersionNum = cpu_to_le16(1);
+				iter->fi.fileCharacteristics = 0;
+				iter->fi.lengthFileIdent = namelen;
+				iter->fi.lengthOfImpUse = cpu_to_le16(0);
+				memcpy(iter->namebuf, name, namelen);
+				iter->name = iter->namebuf;
+				return 0;
 			}
 		}
 	}
-
-add:
-	f_pos += nfidlen;
-
-	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB &&
-	    sb->s_blocksize - fibh->eoffset < nfidlen) {
-		brelse(epos.bh);
-		epos.bh = NULL;
-		fibh->soffset -= udf_ext0_offset(dir);
-		fibh->eoffset -= udf_ext0_offset(dir);
-		f_pos -= udf_ext0_offset(dir);
-		if (fibh->sbh != fibh->ebh)
-			brelse(fibh->ebh);
-		brelse(fibh->sbh);
-		fibh->sbh = fibh->ebh =
-				udf_expand_dir_adinicb(dir, &block, err);
-		if (!fibh->sbh)
-			goto out_err;
-		epos.block = dinfo->i_location;
-		epos.offset = udf_file_entry_alloc_offset(dir);
-		/* Load extent udf_expand_dir_adinicb() has created */
-		udf_current_aext(dir, &epos, &eloc, &elen, 1);
+	if (ret) {
+		udf_fiiter_release(iter);
+		return ret;
 	}
-
-	/* Entry fits into current block? */
-	if (sb->s_blocksize - fibh->eoffset >= nfidlen) {
-		fibh->soffset = fibh->eoffset;
-		fibh->eoffset += nfidlen;
-		if (fibh->sbh != fibh->ebh) {
-			brelse(fibh->sbh);
-			fibh->sbh = fibh->ebh;
-		}
-
-		if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-			block = dinfo->i_location.logicalBlockNum;
-			fi = (struct fileIdentDesc *)
-					(dinfo->i_data + fibh->soffset -
-					 udf_ext0_offset(dir) +
-					 dinfo->i_lenEAttr);
-		} else {
-			block = eloc.logicalBlockNum +
-					((elen - 1) >>
-						dir->i_sb->s_blocksize_bits);
-			fi = (struct fileIdentDesc *)
-				(fibh->sbh->b_data + fibh->soffset);
-		}
+	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB &&
+	    blksize - udf_ext0_offset(dir) - iter->pos < nfidlen) {
+		udf_fiiter_release(iter);
+		ret = udf_expand_dir_adinicb(dir, &block);
+		if (ret)
+			return ret;
+		ret = udf_fiiter_init(iter, dir, dir->i_size);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Get blocknumber to use for entry tag */
+	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		block = dinfo->i_location.logicalBlockNum;
 	} else {
-		/* Round up last extent in the file */
-		elen = (elen + sb->s_blocksize - 1) & ~(sb->s_blocksize - 1);
-		if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-			epos.offset -= sizeof(struct short_ad);
-		else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-			epos.offset -= sizeof(struct long_ad);
-		udf_write_aext(dir, &epos, &eloc, elen, 1);
-		dinfo->i_lenExtents = (dinfo->i_lenExtents + sb->s_blocksize
-					- 1) & ~(sb->s_blocksize - 1);
-
-		fibh->soffset = fibh->eoffset - sb->s_blocksize;
-		fibh->eoffset += nfidlen - sb->s_blocksize;
-		if (fibh->sbh != fibh->ebh) {
-			brelse(fibh->sbh);
-			fibh->sbh = fibh->ebh;
-		}
-
-		block = eloc.logicalBlockNum + ((elen - 1) >>
-						dir->i_sb->s_blocksize_bits);
-		fibh->ebh = udf_bread(dir,
-				f_pos >> dir->i_sb->s_blocksize_bits, 1, err);
-		if (!fibh->ebh)
-			goto out_err;
-		/* Extents could have been merged, invalidate our position */
-		brelse(epos.bh);
-		epos.bh = NULL;
-		epos.block = dinfo->i_location;
-		epos.offset = udf_file_entry_alloc_offset(dir);
-
-		if (!fibh->soffset) {
-			/* Find the freshly allocated block */
-			while (udf_next_aext(dir, &epos, &eloc, &elen, 1) ==
-				(EXT_RECORDED_ALLOCATED >> 30))
-				;
-			block = eloc.logicalBlockNum + ((elen - 1) >>
-					dir->i_sb->s_blocksize_bits);
-			brelse(fibh->sbh);
-			fibh->sbh = fibh->ebh;
-			fi = (struct fileIdentDesc *)(fibh->sbh->b_data);
-		} else {
-			fi = (struct fileIdentDesc *)
-				(fibh->sbh->b_data + sb->s_blocksize +
-					fibh->soffset);
-		}
+		block = iter->eloc.logicalBlockNum +
+				((iter->elen - 1) >> dir->i_blkbits);
 	}
-
-	memset(cfi, 0, sizeof(struct fileIdentDesc));
-	if (UDF_SB(sb)->s_udfrev >= 0x0200)
-		udf_new_tag((char *)cfi, TAG_IDENT_FID, 3, 1, block,
+	off = iter->pos & (blksize - 1);
+	if (!off)
+		off = blksize;
+	/* Entry fits into current block? */
+	if (blksize - udf_ext0_offset(dir) - off >= nfidlen)
+		goto store_fi;
+
+	ret = udf_fiiter_append_blk(iter);
+	if (ret) {
+		udf_fiiter_release(iter);
+		return ret;
+	}
+
+	/* Entry will be completely in the new block? Update tag location... */
+	if (!(iter->pos & (blksize - 1)))
+		block = iter->eloc.logicalBlockNum +
+				((iter->elen - 1) >> dir->i_blkbits);
+store_fi:
+	memset(&iter->fi, 0, sizeof(struct fileIdentDesc));
+	if (UDF_SB(dir->i_sb)->s_udfrev >= 0x0200)
+		udf_new_tag((char *)(&iter->fi), TAG_IDENT_FID, 3, 1, block,
 			    sizeof(struct tag));
 	else
-		udf_new_tag((char *)cfi, TAG_IDENT_FID, 2, 1, block,
+		udf_new_tag((char *)(&iter->fi), TAG_IDENT_FID, 2, 1, block,
 			    sizeof(struct tag));
-	cfi->fileVersionNum = cpu_to_le16(1);
-	cfi->lengthFileIdent = namelen;
-	cfi->lengthOfImpUse = cpu_to_le16(0);
-	if (!udf_write_fi(dir, cfi, fi, fibh, NULL, name)) {
-		dir->i_size += nfidlen;
-		if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-			dinfo->i_lenAlloc += nfidlen;
-		else {
-			/* Find the last extent and truncate it to proper size */
-			while (udf_next_aext(dir, &epos, &eloc, &elen, 1) ==
-				(EXT_RECORDED_ALLOCATED >> 30))
-				;
-			elen -= dinfo->i_lenExtents - dir->i_size;
-			if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-			udf_write_aext(dir, &epos, &eloc, elen, 1);
-			dinfo->i_lenExtents = dir->i_size;
-		}
-
-		mark_inode_dirty(dir);
-		goto out_ok;
+	iter->fi.fileVersionNum = cpu_to_le16(1);
+	iter->fi.lengthFileIdent = namelen;
+	iter->fi.lengthOfImpUse = cpu_to_le16(0);
+	memcpy(iter->namebuf, name, namelen);
+	iter->name = iter->namebuf;
+
+	dir->i_size += nfidlen;
+	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		dinfo->i_lenAlloc += nfidlen;
 	} else {
-		*err = -EIO;
-		goto out_err;
+		/* Truncate last extent to proper size */
+		udf_fiiter_update_elen(iter, iter->elen -
+					(dinfo->i_lenExtents - dir->i_size));
 	}
+	mark_inode_dirty(dir);
 
-out_err:
-	fi = NULL;
-	if (fibh->sbh != fibh->ebh)
-		brelse(fibh->ebh);
-	brelse(fibh->sbh);
-out_ok:
-	brelse(epos.bh);
-	kfree(name);
-	return fi;
+	return 0;
 }
 
-static int udf_delete_entry(struct inode *inode, struct fileIdentDesc *fi,
-			    struct udf_fileident_bh *fibh,
-			    struct fileIdentDesc *cfi)
+static void udf_fiiter_delete_entry(struct udf_fileident_iter *iter)
 {
-	cfi->fileCharacteristics |= FID_FILE_CHAR_DELETED;
+	iter->fi.fileCharacteristics |= FID_FILE_CHAR_DELETED;
 
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_STRICT))
-		memset(&(cfi->icb), 0x00, sizeof(struct long_ad));
+	if (UDF_QUERY_FLAG(iter->dir->i_sb, UDF_FLAG_STRICT))
+		memset(&iter->fi.icb, 0x00, sizeof(struct long_ad));
 
-	return udf_write_fi(inode, cfi, fi, fibh, NULL, NULL);
+	udf_fiiter_write_fi(iter, NULL);
 }
 
 static int udf_add_nondir(struct dentry *dentry, struct inode *inode)
 {
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	struct inode *dir = d_inode(dentry->d_parent);
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc cfi, *fi;
+	struct udf_fileident_iter iter;
 	int err;
 
-	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (unlikely(!fi)) {
+	err = udf_fiiter_add_entry(dir, dentry, &iter);
+	if (err) {
 		inode_dec_link_count(inode);
 		discard_new_inode(inode);
 		return err;
 	}
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
+	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	iter.fi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
+	*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
-	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
+	udf_fiiter_write_fi(&iter, NULL);
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	mark_inode_dirty(dir);
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
+	udf_fiiter_release(&iter);
 	d_instantiate_new(dentry, inode);
 
 	return 0;
@@ -665,8 +421,7 @@ static int udf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		     struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc cfi, *fi;
+	struct udf_fileident_iter iter;
 	int err;
 	struct udf_inode_info *dinfo = UDF_I(dir);
 	struct udf_inode_info *iinfo;
@@ -678,144 +433,82 @@ static int udf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	iinfo = UDF_I(inode);
 	inode->i_op = &udf_dir_inode_operations;
 	inode->i_fop = &udf_dir_operations;
-	fi = udf_add_entry(inode, NULL, &fibh, &cfi, &err);
-	if (!fi) {
-		inode_dec_link_count(inode);
+	err = udf_fiiter_add_entry(inode, NULL, &iter);
+	if (err) {
+		clear_nlink(inode);
 		discard_new_inode(inode);
-		goto out;
+		return err;
 	}
 	set_nlink(inode, 2);
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(dinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
+	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	iter.fi.icb.extLocation = cpu_to_lelb(dinfo->i_location);
+	*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 		cpu_to_le32(dinfo->i_unique & 0x00000000FFFFFFFFUL);
-	cfi.fileCharacteristics =
+	iter.fi.fileCharacteristics =
 			FID_FILE_CHAR_DIRECTORY | FID_FILE_CHAR_PARENT;
-	udf_write_fi(inode, &cfi, fi, &fibh, NULL, NULL);
-	brelse(fibh.sbh);
+	udf_fiiter_write_fi(&iter, NULL);
+	udf_fiiter_release(&iter);
 	mark_inode_dirty(inode);
 
-	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (!fi) {
+	err = udf_fiiter_add_entry(dir, dentry, &iter);
+	if (err) {
 		clear_nlink(inode);
-		mark_inode_dirty(inode);
 		discard_new_inode(inode);
-		goto out;
+		return err;
 	}
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
+	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	iter.fi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
+	*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
-	cfi.fileCharacteristics |= FID_FILE_CHAR_DIRECTORY;
-	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
+	iter.fi.fileCharacteristics |= FID_FILE_CHAR_DIRECTORY;
+	udf_fiiter_write_fi(&iter, NULL);
+	udf_fiiter_release(&iter);
 	inc_nlink(dir);
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	mark_inode_dirty(dir);
 	d_instantiate_new(dentry, inode);
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-	err = 0;
 
-out:
-	return err;
+	return 0;
 }
 
 static int empty_dir(struct inode *dir)
 {
-	struct fileIdentDesc *fi, cfi;
-	struct udf_fileident_bh fibh;
-	loff_t f_pos;
-	loff_t size = udf_ext0_offset(dir) + dir->i_size;
-	udf_pblk_t block;
-	struct kernel_lb_addr eloc;
-	uint32_t elen;
-	sector_t offset;
-	struct extent_position epos = {};
-	struct udf_inode_info *dinfo = UDF_I(dir);
-
-	f_pos = udf_ext0_offset(dir);
-	fibh.soffset = fibh.eoffset = f_pos & (dir->i_sb->s_blocksize - 1);
-
-	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		fibh.sbh = fibh.ebh = NULL;
-	else if (inode_bmap(dir, f_pos >> dir->i_sb->s_blocksize_bits,
-			      &epos, &eloc, &elen, &offset) ==
-					(EXT_RECORDED_ALLOCATED >> 30)) {
-		block = udf_get_lb_pblock(dir->i_sb, &eloc, offset);
-		if ((++offset << dir->i_sb->s_blocksize_bits) < elen) {
-			if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-		} else
-			offset = 0;
-
-		fibh.sbh = fibh.ebh = udf_tread(dir->i_sb, block);
-		if (!fibh.sbh) {
-			brelse(epos.bh);
+	struct udf_fileident_iter iter;
+	int ret;
+
+	for (ret = udf_fiiter_init(&iter, dir, 0);
+	     !ret && iter.pos < dir->i_size;
+	     ret = udf_fiiter_advance(&iter)) {
+		if (iter.fi.lengthFileIdent &&
+		    !(iter.fi.fileCharacteristics & FID_FILE_CHAR_DELETED)) {
+			udf_fiiter_release(&iter);
 			return 0;
 		}
-	} else {
-		brelse(epos.bh);
-		return 0;
 	}
-
-	while (f_pos < size) {
-		fi = udf_fileident_read(dir, &f_pos, &fibh, &cfi, &epos, &eloc,
-					&elen, &offset);
-		if (!fi) {
-			if (fibh.sbh != fibh.ebh)
-				brelse(fibh.ebh);
-			brelse(fibh.sbh);
-			brelse(epos.bh);
-			return 0;
-		}
-
-		if (cfi.lengthFileIdent &&
-		    (cfi.fileCharacteristics & FID_FILE_CHAR_DELETED) == 0) {
-			if (fibh.sbh != fibh.ebh)
-				brelse(fibh.ebh);
-			brelse(fibh.sbh);
-			brelse(epos.bh);
-			return 0;
-		}
-	}
-
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-	brelse(epos.bh);
+	udf_fiiter_release(&iter);
 
 	return 1;
 }
 
 static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	int retval;
+	int ret;
 	struct inode *inode = d_inode(dentry);
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc *fi, cfi;
+	struct udf_fileident_iter iter;
 	struct kernel_lb_addr tloc;
 
-	retval = -ENOENT;
-	fi = udf_find_entry(dir, &dentry->d_name, &fibh, &cfi);
-	if (IS_ERR_OR_NULL(fi)) {
-		if (fi)
-			retval = PTR_ERR(fi);
+	ret = udf_fiiter_find_entry(dir, &dentry->d_name, &iter);
+	if (ret)
 		goto out;
-	}
 
-	retval = -EIO;
-	tloc = lelb_to_cpu(cfi.icb.extLocation);
+	ret = -EFSCORRUPTED;
+	tloc = lelb_to_cpu(iter.fi.icb.extLocation);
 	if (udf_get_lb_pblock(dir->i_sb, &tloc, 0) != inode->i_ino)
 		goto end_rmdir;
-	retval = -ENOTEMPTY;
+	ret = -ENOTEMPTY;
 	if (!empty_dir(inode))
 		goto end_rmdir;
-	retval = udf_delete_entry(dir, fi, &fibh, &cfi);
-	if (retval)
-		goto end_rmdir;
+	udf_fiiter_delete_entry(&iter);
 	if (inode->i_nlink != 2)
 		udf_warn(inode->i_sb, "empty directory has nlink != 2 (%u)\n",
 			 inode->i_nlink);
@@ -825,36 +518,26 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 	inode->i_ctime = dir->i_ctime = dir->i_mtime =
 						current_time(inode);
 	mark_inode_dirty(dir);
-
+	ret = 0;
 end_rmdir:
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-
+	udf_fiiter_release(&iter);
 out:
-	return retval;
+	return ret;
 }
 
 static int udf_unlink(struct inode *dir, struct dentry *dentry)
 {
-	int retval;
+	int ret;
 	struct inode *inode = d_inode(dentry);
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc *fi;
-	struct fileIdentDesc cfi;
+	struct udf_fileident_iter iter;
 	struct kernel_lb_addr tloc;
 
-	retval = -ENOENT;
-	fi = udf_find_entry(dir, &dentry->d_name, &fibh, &cfi);
-
-	if (IS_ERR_OR_NULL(fi)) {
-		if (fi)
-			retval = PTR_ERR(fi);
+	ret = udf_fiiter_find_entry(dir, &dentry->d_name, &iter);
+	if (ret)
 		goto out;
-	}
 
-	retval = -EIO;
-	tloc = lelb_to_cpu(cfi.icb.extLocation);
+	ret = -EFSCORRUPTED;
+	tloc = lelb_to_cpu(iter.fi.icb.extLocation);
 	if (udf_get_lb_pblock(dir->i_sb, &tloc, 0) != inode->i_ino)
 		goto end_unlink;
 
@@ -863,22 +546,16 @@ static int udf_unlink(struct inode *dir, struct dentry *dentry)
 			  inode->i_ino, inode->i_nlink);
 		set_nlink(inode, 1);
 	}
-	retval = udf_delete_entry(dir, fi, &fibh, &cfi);
-	if (retval)
-		goto end_unlink;
+	udf_fiiter_delete_entry(&iter);
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	mark_inode_dirty(dir);
 	inode_dec_link_count(inode);
 	inode->i_ctime = dir->i_ctime;
-	retval = 0;
-
+	ret = 0;
 end_unlink:
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-
+	udf_fiiter_release(&iter);
 out:
-	return retval;
+	return ret;
 }
 
 static int udf_symlink(struct user_namespace *mnt_userns, struct inode *dir,
@@ -1038,27 +715,21 @@ static int udf_link(struct dentry *old_dentry, struct inode *dir,
 		    struct dentry *dentry)
 {
 	struct inode *inode = d_inode(old_dentry);
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc cfi, *fi;
+	struct udf_fileident_iter iter;
 	int err;
 
-	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (!fi) {
+	err = udf_fiiter_add_entry(dir, dentry, &iter);
+	if (err)
 		return err;
-	}
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(UDF_I(inode)->i_location);
+	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	iter.fi.icb.extLocation = cpu_to_lelb(UDF_I(inode)->i_location);
 	if (UDF_SB(inode->i_sb)->s_lvid_bh) {
-		*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
+		*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 			cpu_to_le32(lvid_get_unique_id(inode->i_sb));
 	}
-	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
-	if (UDF_I(dir)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		mark_inode_dirty(dir);
+	udf_fiiter_write_fi(&iter, NULL);
+	udf_fiiter_release(&iter);
 
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
 	inc_nlink(inode);
 	inode->i_ctime = current_time(inode);
 	mark_inode_dirty(inode);
@@ -1079,78 +750,68 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 {
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
-	struct udf_fileident_bh ofibh, nfibh;
-	struct fileIdentDesc *ofi = NULL, *nfi = NULL, *dir_fi = NULL;
-	struct fileIdentDesc ocfi, ncfi;
-	struct buffer_head *dir_bh = NULL;
-	int retval = -ENOENT;
+	struct udf_fileident_iter oiter, niter, diriter;
+	bool has_diriter = false;
+	int retval;
 	struct kernel_lb_addr tloc;
-	struct udf_inode_info *old_iinfo = UDF_I(old_inode);
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
-	ofi = udf_find_entry(old_dir, &old_dentry->d_name, &ofibh, &ocfi);
-	if (!ofi || IS_ERR(ofi)) {
-		if (IS_ERR(ofi))
-			retval = PTR_ERR(ofi);
-		goto end_rename;
-	}
-
-	if (ofibh.sbh != ofibh.ebh)
-		brelse(ofibh.ebh);
-
-	brelse(ofibh.sbh);
-	tloc = lelb_to_cpu(ocfi.icb.extLocation);
-	if (udf_get_lb_pblock(old_dir->i_sb, &tloc, 0) != old_inode->i_ino)
-		goto end_rename;
+	retval = udf_fiiter_find_entry(old_dir, &old_dentry->d_name, &oiter);
+	if (retval)
+		return retval;
 
-	nfi = udf_find_entry(new_dir, &new_dentry->d_name, &nfibh, &ncfi);
-	if (IS_ERR(nfi)) {
-		retval = PTR_ERR(nfi);
-		goto end_rename;
-	}
-	if (nfi && !new_inode) {
-		if (nfibh.sbh != nfibh.ebh)
-			brelse(nfibh.ebh);
-		brelse(nfibh.sbh);
-		nfi = NULL;
+	tloc = lelb_to_cpu(oiter.fi.icb.extLocation);
+	if (udf_get_lb_pblock(old_dir->i_sb, &tloc, 0) != old_inode->i_ino) {
+		retval = -ENOENT;
+		goto out_oiter;
 	}
-	if (S_ISDIR(old_inode->i_mode)) {
-		int offset = udf_ext0_offset(old_inode);
 
+	if (S_ISDIR(old_inode->i_mode)) {
 		if (new_inode) {
 			retval = -ENOTEMPTY;
 			if (!empty_dir(new_inode))
-				goto end_rename;
+				goto out_oiter;
 		}
-		retval = -EIO;
-		if (old_iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-			dir_fi = udf_get_fileident(
-					old_iinfo->i_data -
-					  (old_iinfo->i_efe ?
-					   sizeof(struct extendedFileEntry) :
-					   sizeof(struct fileEntry)),
-					old_inode->i_sb->s_blocksize, &offset);
-		} else {
-			dir_bh = udf_bread(old_inode, 0, 0, &retval);
-			if (!dir_bh)
-				goto end_rename;
-			dir_fi = udf_get_fileident(dir_bh->b_data,
-					old_inode->i_sb->s_blocksize, &offset);
+		retval = udf_fiiter_find_entry(old_inode, &dotdot_name,
+					       &diriter);
+		if (retval == -ENOENT) {
+			udf_err(old_inode->i_sb,
+				"directory (ino %lu) has no '..' entry\n",
+				old_inode->i_ino);
+			retval = -EFSCORRUPTED;
 		}
-		if (!dir_fi)
-			goto end_rename;
-		tloc = lelb_to_cpu(dir_fi->icb.extLocation);
+		if (retval)
+			goto out_oiter;
+		has_diriter = true;
+		tloc = lelb_to_cpu(diriter.fi.icb.extLocation);
 		if (udf_get_lb_pblock(old_inode->i_sb, &tloc, 0) !=
-				old_dir->i_ino)
-			goto end_rename;
+				old_dir->i_ino) {
+			retval = -EFSCORRUPTED;
+			udf_err(old_inode->i_sb,
+				"directory (ino %lu) has parent entry pointing to another inode (%lu != %u)\n",
+				old_inode->i_ino, old_dir->i_ino,
+				udf_get_lb_pblock(old_inode->i_sb, &tloc, 0));
+			goto out_oiter;
+		}
 	}
-	if (!nfi) {
-		nfi = udf_add_entry(new_dir, new_dentry, &nfibh, &ncfi,
-				    &retval);
-		if (!nfi)
-			goto end_rename;
+
+	retval = udf_fiiter_find_entry(new_dir, &new_dentry->d_name, &niter);
+	if (retval && retval != -ENOENT)
+		goto out_oiter;
+	/* Entry found but not passed by VFS? */
+	if (!retval && !new_inode) {
+		retval = -EFSCORRUPTED;
+		udf_fiiter_release(&niter);
+		goto out_oiter;
+	}
+	/* Entry not found? Need to add one... */
+	if (retval) {
+		udf_fiiter_release(&niter);
+		retval = udf_fiiter_add_entry(new_dir, new_dentry, &niter);
+		if (retval)
+			goto out_oiter;
 	}
 
 	/*
@@ -1163,14 +824,26 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	/*
 	 * ok, that's it
 	 */
-	ncfi.fileVersionNum = ocfi.fileVersionNum;
-	ncfi.fileCharacteristics = ocfi.fileCharacteristics;
-	memcpy(&(ncfi.icb), &(ocfi.icb), sizeof(ocfi.icb));
-	udf_write_fi(new_dir, &ncfi, nfi, &nfibh, NULL, NULL);
+	niter.fi.fileVersionNum = oiter.fi.fileVersionNum;
+	niter.fi.fileCharacteristics = oiter.fi.fileCharacteristics;
+	memcpy(&(niter.fi.icb), &(oiter.fi.icb), sizeof(oiter.fi.icb));
+	udf_fiiter_write_fi(&niter, NULL);
+	udf_fiiter_release(&niter);
 
-	/* The old fid may have moved - find it again */
-	ofi = udf_find_entry(old_dir, &old_dentry->d_name, &ofibh, &ocfi);
-	udf_delete_entry(old_dir, ofi, &ofibh, &ocfi);
+	/*
+	 * The old entry may have moved due to new entry allocation. Find it
+	 * again.
+	 */
+	udf_fiiter_release(&oiter);
+	retval = udf_fiiter_find_entry(old_dir, &old_dentry->d_name, &oiter);
+	if (retval) {
+		udf_err(old_dir->i_sb,
+			"failed to find renamed entry again in directory (ino %lu)\n",
+			old_dir->i_ino);
+	} else {
+		udf_fiiter_delete_entry(&oiter);
+		udf_fiiter_release(&oiter);
+	}
 
 	if (new_inode) {
 		new_inode->i_ctime = current_time(new_inode);
@@ -1181,13 +854,11 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	mark_inode_dirty(old_dir);
 	mark_inode_dirty(new_dir);
 
-	if (dir_fi) {
-		dir_fi->icb.extLocation = cpu_to_lelb(UDF_I(new_dir)->i_location);
-		udf_update_tag((char *)dir_fi, udf_dir_entry_len(dir_fi));
-		if (old_iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-			mark_inode_dirty(old_inode);
-		else
-			mark_buffer_dirty_inode(dir_bh, old_inode);
+	if (has_diriter) {
+		diriter.fi.icb.extLocation =
+					cpu_to_lelb(UDF_I(new_dir)->i_location);
+		udf_fiiter_write_fi(&diriter, NULL);
+		udf_fiiter_release(&diriter);
 
 		inode_dec_link_count(old_dir);
 		if (new_inode)
@@ -1197,22 +868,11 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			mark_inode_dirty(new_dir);
 		}
 	}
-
-	if (ofi) {
-		if (ofibh.sbh != ofibh.ebh)
-			brelse(ofibh.ebh);
-		brelse(ofibh.sbh);
-	}
-
-	retval = 0;
-
-end_rename:
-	brelse(dir_bh);
-	if (nfi) {
-		if (nfibh.sbh != nfibh.ebh)
-			brelse(nfibh.ebh);
-		brelse(nfibh.sbh);
-	}
+	return 0;
+out_oiter:
+	if (has_diriter)
+		udf_fiiter_release(&diriter);
+	udf_fiiter_release(&oiter);
 
 	return retval;
 }
@@ -1221,17 +881,15 @@ static struct dentry *udf_get_parent(struct dentry *child)
 {
 	struct kernel_lb_addr tloc;
 	struct inode *inode = NULL;
-	struct fileIdentDesc cfi;
-	struct udf_fileident_bh fibh;
-
-	if (!udf_find_entry(d_inode(child), &dotdot_name, &fibh, &cfi))
-		return ERR_PTR(-EACCES);
+	struct udf_fileident_iter iter;
+	int err;
 
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
+	err = udf_fiiter_find_entry(d_inode(child), &dotdot_name, &iter);
+	if (err)
+		return ERR_PTR(err);
 
-	tloc = lelb_to_cpu(cfi.icb.extLocation);
+	tloc = lelb_to_cpu(iter.fi.icb.extLocation);
+	udf_fiiter_release(&iter);
 	inode = udf_iget(child->d_sb, &tloc);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 7e258f15b8ef..f764b4d15094 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -86,11 +86,22 @@ extern const struct address_space_operations udf_aops;
 extern const struct address_space_operations udf_adinicb_aops;
 extern const struct address_space_operations udf_symlink_aops;
 
-struct udf_fileident_bh {
-	struct buffer_head *sbh;
-	struct buffer_head *ebh;
-	int soffset;
-	int eoffset;
+struct udf_fileident_iter {
+	struct inode *dir;		/* Directory we are working with */
+	loff_t pos;			/* Logical position in a dir */
+	struct buffer_head *bh[2];	/* Buffer containing 'pos' and possibly
+					 * next buffer if entry straddles
+					 * blocks */
+	struct kernel_lb_addr eloc;	/* Start of extent containing 'pos' */
+	uint32_t elen;			/* Length of extent containing 'pos' */
+	sector_t loffset;		/* Block offset of 'pos' within above
+					 * extent */
+	struct extent_position epos;	/* Position after the above extent */
+	struct fileIdentDesc fi;	/* Copied directory entry */
+	uint8_t *name;			/* Pointer to entry name */
+	uint8_t namebuf[UDF_NAME_LEN_CS0]; /* Storage for entry name in case
+					 * the name is split between two blocks
+					 */
 };
 
 struct udf_vds_record {
@@ -121,19 +132,12 @@ struct inode *udf_find_metadata_inode_efe(struct super_block *sb,
 					u32 meta_file_loc, u32 partition_num);
 
 /* namei.c */
-extern int udf_write_fi(struct inode *inode, struct fileIdentDesc *,
-			struct fileIdentDesc *, struct udf_fileident_bh *,
-			uint8_t *, uint8_t *);
 static inline unsigned int udf_dir_entry_len(struct fileIdentDesc *cfi)
 {
 	return ALIGN(sizeof(struct fileIdentDesc) +
 		le16_to_cpu(cfi->lengthOfImpUse) + cfi->lengthFileIdent,
 		UDF_NAME_PAD);
 }
-static inline uint8_t *udf_get_fi_ident(struct fileIdentDesc *fi)
-{
-	return ((uint8_t *)(fi + 1)) + le16_to_cpu(fi->lengthOfImpUse);
-}
 
 /* file.c */
 extern long udf_ioctl(struct file *, unsigned int, unsigned long);
@@ -151,8 +155,6 @@ static inline struct inode *udf_iget(struct super_block *sb,
 	return __udf_iget(sb, ino, false);
 }
 extern int udf_expand_file_adinicb(struct inode *);
-extern struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
-						  udf_pblk_t *block, int *err);
 extern struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
 				      int create, int *err);
 extern int udf_setsize(struct inode *, loff_t);
@@ -243,14 +245,13 @@ extern udf_pblk_t udf_new_block(struct super_block *sb, struct inode *inode,
 				 uint16_t partition, uint32_t goal, int *err);
 
 /* directory.c */
-extern struct fileIdentDesc *udf_fileident_read(struct inode *, loff_t *,
-						struct udf_fileident_bh *,
-						struct fileIdentDesc *,
-						struct extent_position *,
-						struct kernel_lb_addr *, uint32_t *,
-						sector_t *);
-extern struct fileIdentDesc *udf_get_fileident(void *buffer, int bufsize,
-					       int *offset);
+int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
+		    loff_t pos);
+int udf_fiiter_advance(struct udf_fileident_iter *iter);
+void udf_fiiter_release(struct udf_fileident_iter *iter);
+void udf_fiiter_write_fi(struct udf_fileident_iter *iter, uint8_t *impuse);
+void udf_fiiter_update_elen(struct udf_fileident_iter *iter, uint32_t new_elen);
+int udf_fiiter_append_blk(struct udf_fileident_iter *iter);
 extern struct long_ad *udf_get_filelongad(uint8_t *, int, uint32_t *, int);
 extern struct short_ad *udf_get_fileshortad(uint8_t *, int, uint32_t *, int);
 
diff --git a/include/linux/fsl/enetc_mdio.h b/include/linux/fsl/enetc_mdio.h
index 2d9203314865..b90c4dc50b7d 100644
--- a/include/linux/fsl/enetc_mdio.h
+++ b/include/linux/fsl/enetc_mdio.h
@@ -48,7 +48,8 @@ static inline int enetc_mdio_read(struct mii_bus *bus, int phy_id, int regnum)
 static inline int enetc_mdio_write(struct mii_bus *bus, int phy_id, int regnum,
 				   u16 value)
 { return -EINVAL; }
-struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs)
+static inline struct enetc_hw *enetc_hw_alloc(struct device *dev,
+					      void __iomem *port_regs)
 { return ERR_PTR(-EINVAL); }
 
 #endif
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 2c63375bbd43..bf9e0640288d 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -58,10 +58,12 @@ struct its_vpe {
 				bool	enabled;
 				bool	group;
 			}			sgi_config[16];
-			atomic_t vmapp_count;
 		};
 	};
 
+	/* Track the VPE being mapped */
+	atomic_t vmapp_count;
+
 	/*
 	 * Ensures mutual exclusion between affinity setting of the
 	 * vPE and vLPI operations using vpe->col_idx.
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8ed2c6552971..f1ab0cd98727 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -56,6 +56,7 @@
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/percpu.h>
+#include <linux/cpuset.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
 #include <linux/bvec.h>
@@ -1582,7 +1583,14 @@ static inline bool io_sqring_full(struct io_ring_ctx *ctx)
 {
 	struct io_rings *r = ctx->rings;
 
-	return READ_ONCE(r->sq.tail) - ctx->cached_sq_head == ctx->sq_entries;
+	/*
+	 * SQPOLL must use the actual sqring head, as using the cached_sq_head
+	 * is race prone if the SQPOLL thread has grabbed entries but not yet
+	 * committed them to the ring. For !SQPOLL, this doesn't matter, but
+	 * since this helper is just used for SQPOLL sqring waits (or POLLOUT),
+	 * just read the actual sqring head unconditionally.
+	 */
+	return READ_ONCE(r->sq.tail) - READ_ONCE(r->sq.head) == ctx->sq_entries;
 }
 
 static inline unsigned int __io_cqring_events(struct io_ring_ctx *ctx)
@@ -8746,11 +8754,22 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
 			return 0;
 
 		if (p->flags & IORING_SETUP_SQ_AFF) {
+			cpumask_var_t allowed_mask;
 			int cpu = p->sq_thread_cpu;
 
 			ret = -EINVAL;
 			if (cpu >= nr_cpu_ids || !cpu_online(cpu))
 				goto err_sqpoll;
+			ret = -ENOMEM;
+			if (!alloc_cpumask_var(&allowed_mask, GFP_KERNEL))
+				goto err_sqpoll;
+			ret = -EINVAL;
+			cpuset_cpus_allowed(current, allowed_mask);
+			if (!cpumask_test_cpu(cpu, allowed_mask)) {
+				free_cpumask_var(allowed_mask);
+				goto err_sqpoll;
+			}
+			free_cpumask_var(allowed_mask);
 			sqd->sq_cpu = cpu;
 		} else {
 			sqd->sq_cpu = -1;
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 77c0c2370b6d..8127673bfc45 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -299,6 +299,9 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 		goto out;
 	}
 
+	if (!timespec64_valid_strict(ts))
+		return -EINVAL;
+
 	if (cd.clk->ops.clock_settime)
 		err = cd.clk->ops.clock_settime(cd.clk, ts);
 	else
diff --git a/mm/secretmem.c b/mm/secretmem.c
index d1986ce2e7c7..624663a94808 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -234,7 +234,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 	/* make sure local flags do not confict with global fcntl.h */
 	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
 
-	if (!secretmem_enable)
+	if (!secretmem_enable || !can_set_direct_map())
 		return -ENOSYS;
 
 	if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
@@ -278,7 +278,7 @@ static int secretmem_init(void)
 {
 	int ret = 0;
 
-	if (!secretmem_enable)
+	if (!secretmem_enable || !can_set_direct_map())
 		return ret;
 
 	secretmem_mnt = kern_mount(&secretmem_fs);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index fec3e736a194..c9b9053c7969 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2125,7 +2125,7 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type,
 
 	mmap_read_lock(mm);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		if (vma->anon_vma) {
+		if (vma->anon_vma && !is_vm_hugetlb_page(vma)) {
 			ret = unuse_vma(vma, type, frontswap,
 					fs_pages_to_unuse);
 			if (ret)
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index b7498e890f0b..9c9c855b9736 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -779,6 +779,7 @@ static int __init bt_init(void)
 	bt_sysfs_cleanup();
 cleanup_led:
 	bt_leds_cleanup();
+	debugfs_remove_recursive(bt_debugfs);
 	return err;
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 2c9670c83202..44eedae43eaa 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2308,7 +2308,7 @@ static bool tcp_can_coalesce_send_queue_head(struct sock *sk, int len)
 		if (len <= skb->len)
 			break;
 
-		if (unlikely(TCP_SKB_CB(skb)->eor) || tcp_has_tx_tstamp(skb))
+		if (tcp_has_tx_tstamp(skb) || !tcp_skb_can_collapse(skb, next))
 			return false;
 
 		len -= skb->len;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f652982a106b..c54b3be62c0a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -511,6 +511,9 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 		sta->cipher_scheme = cs;
 
 	err = ieee80211_key_link(key, sdata, sta);
+	/* KRACK protection, shouldn't happen but just silently accept key */
+	if (err == -EALREADY)
+		err = 0;
 
  out_unlock:
 	mutex_unlock(&local->sta_mtx);
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index f695fc80088b..7b427e39831b 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -843,7 +843,7 @@ int ieee80211_key_link(struct ieee80211_key *key,
 	 */
 	if (ieee80211_key_identical(sdata, old_key, key)) {
 		ieee80211_key_free_unused(key);
-		ret = 0;
+		ret = -EALREADY;
 		goto out;
 	}
 
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index c2fadfcfd6d6..3e773259fa83 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -15,6 +15,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPCapableACKRX", MPTCP_MIB_MPCAPABLEPASSIVEACK),
 	SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
 	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLBACK),
+	SNMP_MIB_ITEM("MPCapableEndpAttempt", MPTCP_MIB_MPCAPABLEENDPATTEMPT),
 	SNMP_MIB_ITEM("MPFallbackTokenInit", MPTCP_MIB_TOKENFALLBACKINIT),
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
@@ -26,6 +27,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("DSSCorruptionFallback", MPTCP_MIB_DSSCORRUPTIONFALLBACK),
+	SNMP_MIB_ITEM("DSSCorruptionReset", MPTCP_MIB_DSSCORRUPTIONRESET),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
 	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
 	SNMP_MIB_ITEM("DataCsumErr", MPTCP_MIB_DATACSUMERR),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 90025acdcf72..0690db18fc95 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -8,6 +8,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPCAPABLEPASSIVEACK,	/* Received third ACK with MP_CAPABLE */
 	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3-way handshake */
 	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way handshake */
+	MPTCP_MIB_MPCAPABLEENDPATTEMPT,	/* Prohibited MPC to port-based endp */
 	MPTCP_MIB_TOKENFALLBACKINIT,	/* Could not init/allocate token */
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
@@ -19,6 +20,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
+	MPTCP_MIB_DSSCORRUPTIONFALLBACK,/* DSS corruption detected, fallback */
+	MPTCP_MIB_DSSCORRUPTIONRESET,	/* DSS corruption detected, MPJ subflow reset */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
 	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence numbers */
 	MPTCP_MIB_DATACSUMERR,		/* The data checksum fail */
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e524171291bc..a7a46d99d5a3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -793,10 +793,10 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 				 i, rm_list->ids[i], subflow->local_id, subflow->remote_id);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
+			removed |= subflow->request_join;
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 
-			removed |= subflow->request_join;
 			msk->pm.subflows--;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW)
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
@@ -991,6 +991,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 		goto out;
 	}
 
+	WRITE_ONCE(mptcp_subflow_ctx(ssock->sk)->pm_listener, true);
 	err = kernel_listen(ssock, backlog);
 	if (err) {
 		pr_warn("kernel_listen error, err=%d", err);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index da2a1a150bc6..34c98596350e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -554,6 +554,18 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	return ret;
 }
 
+static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
+{
+	if (READ_ONCE(msk->allow_infinite_fallback)) {
+		MPTCP_INC_STATS(sock_net(ssk),
+				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
+		mptcp_do_fallback(ssk);
+	} else {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
+		mptcp_subflow_reset(ssk);
+	}
+}
+
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk,
 					   unsigned int *bytes)
@@ -626,10 +638,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 				moved += len;
 			seq += len;
 
-			if (WARN_ON_ONCE(map_remaining < len))
-				break;
+			if (unlikely(map_remaining < len))
+				mptcp_dss_corruption(msk, ssk);
 		} else {
-			WARN_ON_ONCE(!fin);
+			if (unlikely(!fin))
+				mptcp_dss_corruption(msk, ssk);
+
 			sk_eat_skb(ssk, skb);
 			done = true;
 		}
@@ -2472,6 +2486,7 @@ static void __mptcp_retrans(struct sock *sk)
 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
+		WRITE_ONCE(msk->allow_infinite_fallback, false);
 	}
 
 	release_sock(ssk);
@@ -2549,6 +2564,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
+	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery = false;
 
 	mptcp_pm_data_init(msk);
@@ -3299,6 +3315,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	if (parent_sock && !ssk->sk_socket)
 		mptcp_sock_graft(ssk, parent_sock);
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
 out:
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 	return true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9e0a5591d4e1..8f5e5a66babf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -249,6 +249,7 @@ struct mptcp_sock {
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
+	bool		allow_infinite_fallback;
 	spinlock_t	join_list_lock;
 	int		keepalive_cnt;
 	int		keepalive_idle;
@@ -445,6 +446,7 @@ struct mptcp_subflow_context {
 		close_event_done : 1,       /* has done the post-closed part */
 		__unused : 11;
 	enum mptcp_data_avail data_avail;
+	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e71082dd6484..d8b33e10750b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -129,6 +129,13 @@ static void subflow_add_reset_reason(struct sk_buff *skb, u8 reason)
 	}
 }
 
+static int subflow_reset_req_endp(struct request_sock *req, struct sk_buff *skb)
+{
+	SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEENDPATTEMPT);
+	subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+	return -EPERM;
+}
+
 /* Init mptcp request socket.
  *
  * Returns an error code if a JOIN has failed and a TCP reset
@@ -160,6 +167,8 @@ static int subflow_check_req(struct request_sock *req,
 	if (opt_mp_capable) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
 
+		if (unlikely(listener->pm_listener))
+			return subflow_reset_req_endp(req, skb);
 		if (opt_mp_join)
 			return 0;
 	} else if (opt_mp_join) {
@@ -167,6 +176,8 @@ static int subflow_check_req(struct request_sock *req,
 
 		if (mp_opt.backup)
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNBACKUPRX);
+	} else if (unlikely(listener->pm_listener)) {
+		return subflow_reset_req_endp(req, skb);
 	}
 
 	if (opt_mp_capable && listener->request_mptcp) {
@@ -847,7 +858,7 @@ static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
 	unsigned int skb_consumed;
 
 	skb_consumed = tcp_sk(ssk)->copied_seq - TCP_SKB_CB(skb)->seq;
-	if (WARN_ON_ONCE(skb_consumed >= skb->len))
+	if (unlikely(skb_consumed >= skb->len))
 		return true;
 
 	return skb->len - skb_consumed <= subflow->map_data_len -
@@ -1152,7 +1163,7 @@ static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
 	else if (READ_ONCE(msk->csum_enabled))
 		return !subflow->valid_csum_seen;
 	else
-		return !subflow->fully_established;
+		return READ_ONCE(msk->allow_infinite_fallback);
 }
 
 static bool subflow_check_data_avail(struct sock *ssk)
@@ -1219,7 +1230,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 fallback:
 	/* RFC 8684 section 3.7. */
 	if (subflow->send_mp_fail) {
-		if (mptcp_has_another_subflow(ssk)) {
+		if (mptcp_has_another_subflow(ssk) ||
+		    !READ_ONCE(msk->allow_infinite_fallback)) {
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
 		}
@@ -1481,6 +1493,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	/* discard the subflow socket */
 	mptcp_sock_graft(ssk, sk->sk_socket);
 	iput(SOCK_INODE(sf));
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
 	return err;
 
 failed_unlink:
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 5b296cacb389..3d687d1f7beb 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -307,6 +307,7 @@ enum {
 	CXT_FIXUP_HP_SPECTRE,
 	CXT_FIXUP_HP_GATE_MIC,
 	CXT_FIXUP_MUTE_LED_GPIO,
+	CXT_FIXUP_HP_ELITEONE_OUT_DIS,
 	CXT_FIXUP_HP_ZBOOK_MUTE_LED,
 	CXT_FIXUP_HEADSET_MIC,
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
@@ -324,6 +325,19 @@ static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
 	spec->gen.inv_dmic_split = 1;
 }
 
+/* fix widget control pin settings */
+static void cxt_fixup_update_pinctl(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PROBE) {
+		/* Unset OUT_EN for this Node pin, leaving only HP_EN.
+		 * This is the value stored in the codec register after
+		 * the correct initialization of the previous windows boot.
+		 */
+		snd_hda_set_pin_ctl_cache(codec, 0x1d, AC_PINCTL_HP_EN);
+	}
+}
+
 static void cxt5066_increase_mic_boost(struct hda_codec *codec,
 				   const struct hda_fixup *fix, int action)
 {
@@ -975,6 +989,10 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_mute_led_gpio,
 	},
+	[CXT_FIXUP_HP_ELITEONE_OUT_DIS] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_update_pinctl,
+	},
 	[CXT_FIXUP_HP_ZBOOK_MUTE_LED] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_hp_zbook_mute_led,
@@ -1065,6 +1083,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x83b2, "HP EliteBook 840 G5", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x83b3, "HP EliteBook 830 G5", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x83d3, "HP ProBook 640 G4", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x83e5, "HP EliteOne 1000 G2", CXT_FIXUP_HP_ELITEONE_OUT_DIS),
 	SND_PCI_QUIRK(0x103c, 0x8402, "HP ProBook 645 G4", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x8427, "HP ZBook Studio G5", CXT_FIXUP_HP_ZBOOK_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x844f, "HP ZBook Studio G5", CXT_FIXUP_HP_ZBOOK_MUTE_LED),
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d11c581ce9b9..243ef8fa4005 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3528,12 +3528,13 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
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
@@ -3565,7 +3566,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 
 			yielded = kvm_vcpu_yield_to(vcpu);
 			if (yielded > 0) {
-				kvm->last_boosted_vcpu = i;
+				WRITE_ONCE(kvm->last_boosted_vcpu, i);
 				break;
 			} else if (yielded < 0) {
 				try--;

