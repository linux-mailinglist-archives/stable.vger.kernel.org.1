Return-Path: <stable+bounces-189135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9979FC01D52
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 16:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CF4856389C
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 14:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E332E75A;
	Thu, 23 Oct 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dHPnV8xH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14732E6B5;
	Thu, 23 Oct 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230166; cv=none; b=FwHZG/j+C4+GiwM+Nj+7Hc5mQUXZlHJnK/lAXf8yk+iH4NTyK5pbTQg6h+9Y9Rr+y+tEJLOdHMN1SQn/ZsXlLPMfI2rNYDxWt0hR/29dlKs18McAVMHjFRapV/PCh8nKphHv9mGNDERqBMiZ8ZQhO64VtXwP8OKdCmi5602ISeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230166; c=relaxed/simple;
	bh=r9rLkPjdkP2FL9VEfDaDa+KodbI2plk7BQ2tF7q0Mu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEGiSbGhcX4wLBJXXpzsx7nXKGGq4xNArd78XNjfh/+hB6tSpvpDEXBG3C9inH/QqvsYkUiLODIG7p9YdSR6g/CVxrO0WLpA2rzGIQMpLmzjE87E9+GwDIyfwl6hAX/WHpqLomDu5h5Mhle3gPb/NJ6dh7vK+M3LrQm4XJhTYv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dHPnV8xH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBCCC4CEE7;
	Thu, 23 Oct 2025 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761230166;
	bh=r9rLkPjdkP2FL9VEfDaDa+KodbI2plk7BQ2tF7q0Mu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHPnV8xH4i9wSEbLm4bXRQfsjnoE9nzPjVRQz6HyEAV7laOXjPvmGJDVAMWQanliG
	 fDMyEe8iRWGUI7FyyKrH+vhadhI0VqbmIb6kjOO3NUPaHBRRwd6z8eM0l2e/yElH3U
	 Du+wrVNFRHu3oPtGDTW7i8pgt1ZCelFxiIod9/oQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.17.5
Date: Thu, 23 Oct 2025 16:35:53 +0200
Message-ID: <2025102353-craziness-luxury-20c5@gregkh>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <2025102353-shuffling-isolated-dee5@gregkh>
References: <2025102353-shuffling-isolated-dee5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index b18ef4064bc0..a7ec57060f64 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -200,6 +200,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3AE   | #3312417        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | ARM_SMMU_MMU_500_CPRE_ERRATA|
 |                |                 | #562869,1047329 |                             |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/Documentation/networking/seg6-sysctl.rst b/Documentation/networking/seg6-sysctl.rst
index 07c20e470baf..1b6af4779be1 100644
--- a/Documentation/networking/seg6-sysctl.rst
+++ b/Documentation/networking/seg6-sysctl.rst
@@ -25,6 +25,9 @@ seg6_require_hmac - INTEGER
 
 	Default is 0.
 
+/proc/sys/net/ipv6/seg6_* variables:
+====================================
+
 seg6_flowlabel - INTEGER
 	Controls the behaviour of computing the flowlabel of outer
 	IPv6 header in case of SR T.encaps
diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index e3a51867f27b..aaac76892ceb 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -40,9 +40,11 @@ import sys
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
-from docutils.utils.error_reporting import ErrorString
 from sphinx.util.docutils import switch_source_input
 
+def ErrorString(exc):  # Shamelessly stolen from docutils
+    return f'{exc.__class__.__name}: {exc}'
+
 __version__  = '1.0'
 
 def setup(app):
diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index 1e566e87ebcd..641e81c58a8c 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -35,13 +35,15 @@
 import os.path
 
 from docutils import io, nodes, statemachine
-from docutils.utils.error_reporting import SafeString, ErrorString
 from docutils.parsers.rst import directives
 from docutils.parsers.rst.directives.body import CodeBlock, NumberLines
 from docutils.parsers.rst.directives.misc import Include
 
 __version__  = '1.0'
 
+def ErrorString(exc):  # Shamelessly stolen from docutils
+    return f'{exc.__class__.__name}: {exc}'
+
 # ==============================================================================
 def setup(app):
 # ==============================================================================
@@ -112,7 +114,7 @@ class KernelInclude(Include):
             raise self.severe('Problems with "%s" directive path:\n'
                               'Cannot encode input file path "%s" '
                               '(wrong locale?).' %
-                              (self.name, SafeString(path)))
+                              (self.name, path))
         except IOError as error:
             raise self.severe('Problems with "%s" directive path:\n%s.' %
                       (self.name, ErrorString(error)))
diff --git a/Documentation/sphinx/maintainers_include.py b/Documentation/sphinx/maintainers_include.py
index d31cff867436..519ad18685b2 100755
--- a/Documentation/sphinx/maintainers_include.py
+++ b/Documentation/sphinx/maintainers_include.py
@@ -22,10 +22,12 @@ import re
 import os.path
 
 from docutils import statemachine
-from docutils.utils.error_reporting import ErrorString
 from docutils.parsers.rst import Directive
 from docutils.parsers.rst.directives.misc import Include
 
+def ErrorString(exc):  # Shamelessly stolen from docutils
+    return f'{exc.__class__.__name}: {exc}'
+
 __version__  = '1.0'
 
 def setup(app):
diff --git a/Makefile b/Makefile
index 4c3092dae03c..072a3be62551 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 17
-SUBLEVEL = 4
+SUBLEVEL = 5
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd6e085..880cddff5eda 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -917,6 +917,7 @@ config HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
 	def_bool y
 	depends on HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG
 	depends on RUSTC_VERSION >= 107900
+	depends on ARM64 || X86_64
 	# With GCOV/KASAN we need this fix: https://github.com/rust-lang/rust/pull/129373
 	depends on (RUSTC_LLVM_VERSION >= 190103 && RUSTC_VERSION >= 108200) || \
 		(!GCOV_KERNEL && !KASAN_GENERIC && !KASAN_SW_TAGS)
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a6..93f391e67af1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1138,6 +1138,7 @@ config ARM64_ERRATUM_3194386
 	  * ARM Neoverse-V1 erratum 3324341
 	  * ARM Neoverse V2 erratum 3324336
 	  * ARM Neoverse-V3 erratum 3312417
+	  * ARM Neoverse-V3AE erratum 3312417
 
 	  On affected cores "MSR SSBS, #0" instructions may not affect
 	  subsequent speculative instructions, which may permit unexepected
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 661735616787..eaec55dd3dbe 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -93,6 +93,7 @@
 #define ARM_CPU_PART_NEOVERSE_V2	0xD4F
 #define ARM_CPU_PART_CORTEX_A720	0xD81
 #define ARM_CPU_PART_CORTEX_X4		0xD82
+#define ARM_CPU_PART_NEOVERSE_V3AE	0xD83
 #define ARM_CPU_PART_NEOVERSE_V3	0xD84
 #define ARM_CPU_PART_CORTEX_X925	0xD85
 #define ARM_CPU_PART_CORTEX_A725	0xD87
@@ -182,6 +183,7 @@
 #define MIDR_NEOVERSE_V2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V2)
 #define MIDR_CORTEX_A720 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A720)
 #define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
+#define MIDR_NEOVERSE_V3AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3AE)
 #define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
 #define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
 #define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6604fd6f33f4..9effb4b68208 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1231,10 +1231,19 @@
 	__val;								\
 })
 
+/*
+ * The "Z" constraint combined with the "%x0" template should be enough
+ * to force XZR generation if (v) is a constant 0 value but LLVM does not
+ * yet understand that modifier/constraint combo so a conditional is required
+ * to nudge the compiler into using XZR as a source for a 0 constant value.
+ */
 #define write_sysreg_s(v, r) do {					\
 	u64 __val = (u64)(v);						\
 	u32 __maybe_unused __check_r = (u32)(r);			\
-	asm volatile(__msr_s(r, "%x0") : : "rZ" (__val));		\
+	if (__builtin_constant_p(__val) && __val == 0)			\
+		asm volatile(__msr_s(r, "xzr"));			\
+	else								\
+		asm volatile(__msr_s(r, "%x0") : : "r" (__val));	\
 } while (0)
 
 /*
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 59d723c9ab8f..21f86c160aab 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -545,6 +545,7 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
 	{}
 };
 #endif
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 2b0c5925502e..db116a62ac95 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -832,6 +832,8 @@ static void noinstr el0_breakpt(struct pt_regs *regs, unsigned long esr)
 
 static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
 {
+	bool step_done;
+
 	if (!is_ttbr0_addr(regs->pc))
 		arm64_apply_bp_hardening();
 
@@ -842,10 +844,10 @@ static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
 	 * If we are stepping a suspended breakpoint there's nothing more to do:
 	 * the single-step is complete.
 	 */
-	if (!try_step_suspended_breakpoints(regs)) {
-		local_daif_restore(DAIF_PROCCTX);
+	step_done = try_step_suspended_breakpoints(regs);
+	local_daif_restore(DAIF_PROCCTX);
+	if (!step_done)
 		do_el0_softstep(esr, regs);
-	}
 	exit_to_user_mode(regs);
 }
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index bd6b6a620a09..3036df0cc201 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1789,6 +1789,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_GET_VCPU_EVENTS: {
 		struct kvm_vcpu_events events;
 
+		if (!kvm_vcpu_initialized(vcpu))
+			return -ENOEXEC;
+
 		if (kvm_arm_vcpu_get_events(vcpu, &events))
 			return -EINVAL;
 
@@ -1800,6 +1803,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_SET_VCPU_EVENTS: {
 		struct kvm_vcpu_events events;
 
+		if (!kvm_vcpu_initialized(vcpu))
+			return -ENOEXEC;
+
 		if (copy_from_user(&events, argp, sizeof(events)))
 			return -EFAULT;
 
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 5782e743fd27..4ebc333dd786 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1747,6 +1747,9 @@ void __init fadump_setup_param_area(void)
 {
 	phys_addr_t range_start, range_end;
 
+	if (!fw_dump.fadump_enabled)
+		return;
+
 	if (!fw_dump.param_area_supported || fw_dump.dump_active)
 		return;
 
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index c0738d6c6498..8723390c7cad 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -49,10 +49,15 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 	post_kprobe_handler(p, kcb, regs);
 }
 
-static bool __kprobes arch_check_kprobe(struct kprobe *p)
+static bool __kprobes arch_check_kprobe(unsigned long addr)
 {
-	unsigned long tmp  = (unsigned long)p->addr - p->offset;
-	unsigned long addr = (unsigned long)p->addr;
+	unsigned long tmp, offset;
+
+	/* start iterating at the closest preceding symbol */
+	if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
+		return false;
+
+	tmp = addr - offset;
 
 	while (tmp <= addr) {
 		if (tmp == addr)
@@ -71,7 +76,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	if ((unsigned long)insn & 0x1)
 		return -EILSEQ;
 
-	if (!arch_check_kprobe(p))
+	if (!arch_check_kprobe((unsigned long)p->addr))
 		return -EILSEQ;
 
 	/* copy instruction */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a6f88ca1a6b4..a11e17f3b4b1 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1338,11 +1338,23 @@ static __init int print_s5_reset_status_mmio(void)
 		return 0;
 
 	value = ioread32(addr);
-	iounmap(addr);
 
 	/* Value with "all bits set" is an error response and should be ignored. */
-	if (value == U32_MAX)
+	if (value == U32_MAX) {
+		iounmap(addr);
 		return 0;
+	}
+
+	/*
+	 * Clear all reason bits so they won't be retained if the next reset
+	 * does not update the register. Besides, some bits are never cleared by
+	 * hardware so it's software's responsibility to clear them.
+	 *
+	 * Writing the value back effectively clears all reason bits as they are
+	 * write-1-to-clear.
+	 */
+	iowrite32(value, addr);
+	iounmap(addr);
 
 	for (i = 0; i < ARRAY_SIZE(s5_reset_reason_txt); i++) {
 		if (!(value & BIT(i)))
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c261558276cd..eed0f8417b8c 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -224,15 +224,35 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 	return chunks >> shift;
 }
 
+static u64 get_corrected_val(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     u32 rmid, enum resctrl_event_id eventid, u64 msr_val)
+{
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct arch_mbm_state *am;
+	u64 chunks;
+
+	am = get_arch_mbm_state(hw_dom, rmid, eventid);
+	if (am) {
+		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
+						 hw_res->mbm_width);
+		chunks = get_corrected_mbm_count(rmid, am->chunks);
+		am->prev_msr = msr_val;
+	} else {
+		chunks = msr_val;
+	}
+
+	return chunks * hw_res->mon_scale;
+}
+
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
 			   u64 *val, void *ignored)
 {
 	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	int cpu = cpumask_any(&d->hdr.cpu_mask);
 	struct arch_mbm_state *am;
-	u64 msr_val, chunks;
+	u64 msr_val;
 	u32 prmid;
 	int ret;
 
@@ -240,22 +260,16 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 
 	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
 	ret = __rmid_read_phys(prmid, eventid, &msr_val);
-	if (ret)
-		return ret;
 
-	am = get_arch_mbm_state(hw_dom, rmid, eventid);
-	if (am) {
-		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
-						 hw_res->mbm_width);
-		chunks = get_corrected_mbm_count(rmid, am->chunks);
-		am->prev_msr = msr_val;
-	} else {
-		chunks = msr_val;
+	if (!ret) {
+		*val = get_corrected_val(r, d, rmid, eventid, msr_val);
+	} else if (ret == -EINVAL) {
+		am = get_arch_mbm_state(hw_dom, rmid, eventid);
+		if (am)
+			am->prev_msr = 0;
 	}
 
-	*val = chunks * hw_res->mon_scale;
-
-	return 0;
+	return ret;
 }
 
 /*
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 39f80111e6f1..5d221709353e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -911,11 +911,31 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		 * CR3 and cpu_tlbstate.loaded_mm are not all in sync.
 		 */
 		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
-		barrier();
 
-		/* Start receiving IPIs and then read tlb_gen (and LAM below) */
+		/*
+		 * Make sure this CPU is set in mm_cpumask() such that we'll
+		 * receive invalidation IPIs.
+		 *
+		 * Rely on the smp_mb() implied by cpumask_set_cpu()'s atomic
+		 * operation, or explicitly provide one. Such that:
+		 *
+		 * switch_mm_irqs_off()				flush_tlb_mm_range()
+		 *   smp_store_release(loaded_mm, SWITCHING);     atomic64_inc_return(tlb_gen)
+		 *   smp_mb(); // here                            // smp_mb() implied
+		 *   atomic64_read(tlb_gen);                      this_cpu_read(loaded_mm);
+		 *
+		 * we properly order against flush_tlb_mm_range(), where the
+		 * loaded_mm load can happen in mative_flush_tlb_multi() ->
+		 * should_flush_tlb().
+		 *
+		 * This way switch_mm() must see the new tlb_gen or
+		 * flush_tlb_mm_range() must see the new loaded_mm, or both.
+		 */
 		if (next != &init_mm && !cpumask_test_cpu(cpu, mm_cpumask(next)))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
+		else
+			smp_mb();
+
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 
 		ns = choose_new_asid(next, next_tlb_gen);
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 7246fc256315..091e9623bc29 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -812,8 +812,7 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 }
 /*
  * Similar to blkg_conf_open_bdev, but additionally freezes the queue,
- * acquires q->elevator_lock, and ensures the correct locking order
- * between q->elevator_lock and q->rq_qos_mutex.
+ * ensures the correct locking order between freeze queue and q->rq_qos_mutex.
  *
  * This function returns negative error on failure. On success it returns
  * memflags which must be saved and later passed to blkg_conf_exit_frozen
@@ -834,13 +833,11 @@ unsigned long __must_check blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx)
 	 * At this point, we haven’t started protecting anything related to QoS,
 	 * so we release q->rq_qos_mutex here, which was first acquired in blkg_
 	 * conf_open_bdev. Later, we re-acquire q->rq_qos_mutex after freezing
-	 * the queue and acquiring q->elevator_lock to maintain the correct
-	 * locking order.
+	 * the queue to maintain the correct locking order.
 	 */
 	mutex_unlock(&ctx->bdev->bd_queue->rq_qos_mutex);
 
 	memflags = blk_mq_freeze_queue(ctx->bdev->bd_queue);
-	mutex_lock(&ctx->bdev->bd_queue->elevator_lock);
 	mutex_lock(&ctx->bdev->bd_queue->rq_qos_mutex);
 
 	return memflags;
@@ -1002,9 +999,8 @@ void blkg_conf_exit(struct blkg_conf_ctx *ctx)
 EXPORT_SYMBOL_GPL(blkg_conf_exit);
 
 /*
- * Similar to blkg_conf_exit, but also unfreezes the queue and releases
- * q->elevator_lock. Should be used when blkg_conf_open_bdev_frozen
- * is used to open the bdev.
+ * Similar to blkg_conf_exit, but also unfreezes the queue. Should be used
+ * when blkg_conf_open_bdev_frozen is used to open the bdev.
  */
 void blkg_conf_exit_frozen(struct blkg_conf_ctx *ctx, unsigned long memflags)
 {
@@ -1012,7 +1008,6 @@ void blkg_conf_exit_frozen(struct blkg_conf_ctx *ctx, unsigned long memflags)
 		struct request_queue *q = ctx->bdev->bd_queue;
 
 		blkg_conf_exit(ctx);
-		mutex_unlock(&q->elevator_lock);
 		blk_mq_unfreeze_queue(q, memflags);
 	}
 }
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d06bb137a743..e0bed16485c3 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -557,7 +557,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
 	if (blk_mq_is_shared_tags(flags)) {
 		/* Shared tags are stored at index 0 in @et->tags. */
 		q->sched_shared_tags = et->tags[0];
-		blk_mq_tag_update_sched_shared_tags(q);
+		blk_mq_tag_update_sched_shared_tags(q, et->nr_requests);
 	}
 
 	queue_for_each_hw_ctx(q, hctx, i) {
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index aed84c5d5c2b..12f48e7a0f77 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -622,10 +622,11 @@ void blk_mq_tag_resize_shared_tags(struct blk_mq_tag_set *set, unsigned int size
 	sbitmap_queue_resize(&tags->bitmap_tags, size - set->reserved_tags);
 }
 
-void blk_mq_tag_update_sched_shared_tags(struct request_queue *q)
+void blk_mq_tag_update_sched_shared_tags(struct request_queue *q,
+					 unsigned int nr)
 {
 	sbitmap_queue_resize(&q->sched_shared_tags->bitmap_tags,
-			     q->nr_requests - q->tag_set->reserved_tags);
+			     nr - q->tag_set->reserved_tags);
 }
 
 /**
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f8a8a23b9040..19f62b070ca9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4942,7 +4942,7 @@ struct elevator_tags *blk_mq_update_nr_requests(struct request_queue *q,
 		 * tags can't grow, see blk_mq_alloc_sched_tags().
 		 */
 		if (q->elevator)
-			blk_mq_tag_update_sched_shared_tags(q);
+			blk_mq_tag_update_sched_shared_tags(q, nr);
 		else
 			blk_mq_tag_resize_shared_tags(set, nr);
 	} else if (!q->elevator) {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 6c9d03625ba1..2fdc8eeb4004 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -188,7 +188,8 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 		struct blk_mq_tags **tags, unsigned int depth);
 void blk_mq_tag_resize_shared_tags(struct blk_mq_tag_set *set,
 		unsigned int size);
-void blk_mq_tag_update_sched_shared_tags(struct request_queue *q);
+void blk_mq_tag_update_sched_shared_tags(struct request_queue *q,
+					 unsigned int nr);
 
 void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
diff --git a/drivers/accel/qaic/qaic.h b/drivers/accel/qaic/qaic.h
index c31081e42cee..820d133236dd 100644
--- a/drivers/accel/qaic/qaic.h
+++ b/drivers/accel/qaic/qaic.h
@@ -97,6 +97,8 @@ struct dma_bridge_chan {
 	 * response queue's head and tail pointer of this DBC.
 	 */
 	void __iomem		*dbc_base;
+	/* Synchronizes access to Request queue's head and tail pointer */
+	struct mutex		req_lock;
 	/* Head of list where each node is a memory handle queued in request queue */
 	struct list_head	xfer_list;
 	/* Synchronizes DBC readers during cleanup */
diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_control.c
index d8bdab69f800..b86a8e48e731 100644
--- a/drivers/accel/qaic/qaic_control.c
+++ b/drivers/accel/qaic/qaic_control.c
@@ -407,7 +407,7 @@ static int find_and_map_user_pages(struct qaic_device *qdev,
 		return -EINVAL;
 	remaining = in_trans->size - resources->xferred_dma_size;
 	if (remaining == 0)
-		return 0;
+		return -EINVAL;
 
 	if (check_add_overflow(xfer_start_addr, remaining, &end))
 		return -EINVAL;
diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 797289e9d780..c4f117edb266 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -1356,13 +1356,17 @@ static int __qaic_execute_bo_ioctl(struct drm_device *dev, void *data, struct dr
 		goto release_ch_rcu;
 	}
 
+	ret = mutex_lock_interruptible(&dbc->req_lock);
+	if (ret)
+		goto release_ch_rcu;
+
 	head = readl(dbc->dbc_base + REQHP_OFF);
 	tail = readl(dbc->dbc_base + REQTP_OFF);
 
 	if (head == U32_MAX || tail == U32_MAX) {
 		/* PCI link error */
 		ret = -ENODEV;
-		goto release_ch_rcu;
+		goto unlock_req_lock;
 	}
 
 	queue_level = head <= tail ? tail - head : dbc->nelem - (head - tail);
@@ -1370,11 +1374,12 @@ static int __qaic_execute_bo_ioctl(struct drm_device *dev, void *data, struct dr
 	ret = send_bo_list_to_device(qdev, file_priv, exec, args->hdr.count, is_partial, dbc,
 				     head, &tail);
 	if (ret)
-		goto release_ch_rcu;
+		goto unlock_req_lock;
 
 	/* Finalize commit to hardware */
 	submit_ts = ktime_get_ns();
 	writel(tail, dbc->dbc_base + REQTP_OFF);
+	mutex_unlock(&dbc->req_lock);
 
 	update_profiling_data(file_priv, exec, args->hdr.count, is_partial, received_ts,
 			      submit_ts, queue_level);
@@ -1382,6 +1387,9 @@ static int __qaic_execute_bo_ioctl(struct drm_device *dev, void *data, struct dr
 	if (datapath_polling)
 		schedule_work(&dbc->poll_work);
 
+unlock_req_lock:
+	if (ret)
+		mutex_unlock(&dbc->req_lock);
 release_ch_rcu:
 	srcu_read_unlock(&dbc->ch_lock, rcu_id);
 unlock_dev_srcu:
diff --git a/drivers/accel/qaic/qaic_debugfs.c b/drivers/accel/qaic/qaic_debugfs.c
index a991b8198dc4..8dc4fe5bb560 100644
--- a/drivers/accel/qaic/qaic_debugfs.c
+++ b/drivers/accel/qaic/qaic_debugfs.c
@@ -218,6 +218,9 @@ static int qaic_bootlog_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_d
 	if (ret)
 		goto destroy_workqueue;
 
+	dev_set_drvdata(&mhi_dev->dev, qdev);
+	qdev->bootlog_ch = mhi_dev;
+
 	for (i = 0; i < BOOTLOG_POOL_SIZE; i++) {
 		msg = devm_kzalloc(&qdev->pdev->dev, sizeof(*msg), GFP_KERNEL);
 		if (!msg) {
@@ -233,8 +236,6 @@ static int qaic_bootlog_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_d
 			goto mhi_unprepare;
 	}
 
-	dev_set_drvdata(&mhi_dev->dev, qdev);
-	qdev->bootlog_ch = mhi_dev;
 	return 0;
 
 mhi_unprepare:
diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
index e31bcb0ecfc9..e162f4b8a262 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -454,6 +454,9 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
 			return NULL;
 		init_waitqueue_head(&qdev->dbc[i].dbc_release);
 		INIT_LIST_HEAD(&qdev->dbc[i].bo_lists);
+		ret = drmm_mutex_init(drm, &qdev->dbc[i].req_lock);
+		if (ret)
+			return NULL;
 	}
 
 	return qdev;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ff53f5f029b4..2a210719c4ce 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2174,13 +2174,10 @@ static int ata_read_log_directory(struct ata_device *dev)
 	}
 
 	version = get_unaligned_le16(&dev->gp_log_dir[0]);
-	if (version != 0x0001) {
-		ata_dev_err(dev, "Invalid log directory version 0x%04x\n",
-			    version);
-		ata_clear_log_directory(dev);
-		dev->quirks |= ATA_QUIRK_NO_LOG_DIR;
-		return -EINVAL;
-	}
+	if (version != 0x0001)
+		ata_dev_warn_once(dev,
+				  "Invalid log directory version 0x%04x\n",
+				  version);
 
 	return 0;
 }
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 712624cba2b6..87f0ed3f3f51 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -345,7 +345,7 @@ static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
 	struct resource res;
 	int nid, rc;
 
-	res = DEFINE_RES(start, size, 0);
+	res = DEFINE_RES_MEM(start, size);
 	nid = phys_to_target_node(start);
 
 	rc = hmat_get_extended_linear_cache_size(&res, nid, &cache_size);
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 7c750599ea69..4bc484b46f43 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -371,6 +371,9 @@ cxl_feature_info(struct cxl_features_state *cxlfs,
 {
 	struct cxl_feat_entry *feat;
 
+	if (!cxlfs || !cxlfs->entries)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	for (int i = 0; i < cxlfs->entries->num_features; i++) {
 		feat = &cxlfs->entries->ent[i];
 		if (uuid_equal(uuid, &feat->uuid))
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 71cc42d05248..be4521184328 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -831,7 +831,7 @@ static int match_free_decoder(struct device *dev, const void *data)
 }
 
 static bool region_res_match_cxl_range(const struct cxl_region_params *p,
-				       struct range *range)
+				       const struct range *range)
 {
 	if (!p->res)
 		return false;
@@ -3287,10 +3287,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 	p = &cxlr->params;
 
 	guard(rwsem_read)(&cxl_rwsem.region);
-	if (p->res && p->res->start == r->start && p->res->end == r->end)
-		return 1;
-
-	return 0;
+	return region_res_match_cxl_range(p, r);
 }
 
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a53ec4798b12..a972e4ef1936 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -1068,7 +1068,7 @@ TRACE_EVENT(cxl_poison,
 			__entry->hpa = cxl_dpa_to_hpa(cxlr, cxlmd,
 						      __entry->dpa);
 			if (__entry->hpa != ULLONG_MAX && cxlr->params.cache_size)
-				__entry->hpa_alias0 = __entry->hpa +
+				__entry->hpa_alias0 = __entry->hpa -
 						      cxlr->params.cache_size;
 			else
 				__entry->hpa_alias0 = ULLONG_MAX;
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 7ebcfc5ec1f0..59c75b470efb 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -809,21 +809,163 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
 				   msecs_to_jiffies(500));
 }
 
+/**
+ * zl3073x_dev_phase_meas_setup - setup phase offset measurement
+ * @zldev: pointer to zl3073x_dev structure
+ *
+ * Enable phase offset measurement block, set measurement averaging factor
+ * and enable DPLL-to-its-ref phase measurement for all DPLLs.
+ *
+ * Returns: 0 on success, <0 on error
+ */
+static int
+zl3073x_dev_phase_meas_setup(struct zl3073x_dev *zldev)
+{
+	struct zl3073x_dpll *zldpll;
+	u8 dpll_meas_ctrl, mask = 0;
+	int rc;
+
+	/* Read DPLL phase measurement control register */
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, &dpll_meas_ctrl);
+	if (rc)
+		return rc;
+
+	/* Setup phase measurement averaging factor */
+	dpll_meas_ctrl &= ~ZL_DPLL_MEAS_CTRL_AVG_FACTOR;
+	dpll_meas_ctrl |= FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, 3);
+
+	/* Enable DPLL measurement block */
+	dpll_meas_ctrl |= ZL_DPLL_MEAS_CTRL_EN;
+
+	/* Update phase measurement control register */
+	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, dpll_meas_ctrl);
+	if (rc)
+		return rc;
+
+	/* Enable DPLL-to-connected-ref measurement for each channel */
+	list_for_each_entry(zldpll, &zldev->dplls, list)
+		mask |= BIT(zldpll->id);
+
+	return zl3073x_write_u8(zldev, ZL_REG_DPLL_PHASE_ERR_READ_MASK, mask);
+}
+
+/**
+ * zl3073x_dev_start - Start normal operation
+ * @zldev: zl3073x device pointer
+ * @full: perform full initialization
+ *
+ * The function starts normal operation, which means registering all DPLLs and
+ * their pins, and starting monitoring. If full initialization is requested,
+ * the function additionally initializes the phase offset measurement block and
+ * fetches hardware-invariant parameters.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_dev_start(struct zl3073x_dev *zldev, bool full)
+{
+	struct zl3073x_dpll *zldpll;
+	u8 info;
+	int rc;
+
+	rc = zl3073x_read_u8(zldev, ZL_REG_INFO, &info);
+	if (rc) {
+		dev_err(zldev->dev, "Failed to read device status info\n");
+		return rc;
+	}
+
+	if (!FIELD_GET(ZL_INFO_READY, info)) {
+		/* The ready bit indicates that the firmware was successfully
+		 * configured and is ready for normal operation. If it is
+		 * cleared then the configuration stored in flash is wrong
+		 * or missing. In this situation the driver will expose
+		 * only devlink interface to give an opportunity to flash
+		 * the correct config.
+		 */
+		dev_info(zldev->dev,
+			 "FW not fully ready - missing or corrupted config\n");
+
+		return 0;
+	}
+
+	if (full) {
+		/* Fetch device state */
+		rc = zl3073x_dev_state_fetch(zldev);
+		if (rc)
+			return rc;
+
+		/* Setup phase offset measurement block */
+		rc = zl3073x_dev_phase_meas_setup(zldev);
+		if (rc) {
+			dev_err(zldev->dev,
+				"Failed to setup phase measurement\n");
+			return rc;
+		}
+	}
+
+	/* Register all DPLLs */
+	list_for_each_entry(zldpll, &zldev->dplls, list) {
+		rc = zl3073x_dpll_register(zldpll);
+		if (rc) {
+			dev_err_probe(zldev->dev, rc,
+				      "Failed to register DPLL%u\n",
+				      zldpll->id);
+			return rc;
+		}
+	}
+
+	/* Perform initial firmware fine phase correction */
+	rc = zl3073x_dpll_init_fine_phase_adjust(zldev);
+	if (rc) {
+		dev_err_probe(zldev->dev, rc,
+			      "Failed to init fine phase correction\n");
+		return rc;
+	}
+
+	/* Start monitoring */
+	kthread_queue_delayed_work(zldev->kworker, &zldev->work, 0);
+
+	return 0;
+}
+
+/**
+ * zl3073x_dev_stop - Stop normal operation
+ * @zldev: zl3073x device pointer
+ *
+ * The function stops the normal operation that mean deregistration of all
+ * DPLLs and their pins and stop monitoring.
+ *
+ * Return: 0 on success, <0 on error
+ */
+void zl3073x_dev_stop(struct zl3073x_dev *zldev)
+{
+	struct zl3073x_dpll *zldpll;
+
+	/* Stop monitoring */
+	kthread_cancel_delayed_work_sync(&zldev->work);
+
+	/* Unregister all DPLLs */
+	list_for_each_entry(zldpll, &zldev->dplls, list) {
+		if (zldpll->dpll_dev)
+			zl3073x_dpll_unregister(zldpll);
+	}
+}
+
 static void zl3073x_dev_dpll_fini(void *ptr)
 {
 	struct zl3073x_dpll *zldpll, *next;
 	struct zl3073x_dev *zldev = ptr;
 
-	/* Stop monitoring thread */
+	/* Stop monitoring and unregister DPLLs */
+	zl3073x_dev_stop(zldev);
+
+	/* Destroy monitoring thread */
 	if (zldev->kworker) {
-		kthread_cancel_delayed_work_sync(&zldev->work);
 		kthread_destroy_worker(zldev->kworker);
 		zldev->kworker = NULL;
 	}
 
-	/* Release DPLLs */
+	/* Free all DPLLs */
 	list_for_each_entry_safe(zldpll, next, &zldev->dplls, list) {
-		zl3073x_dpll_unregister(zldpll);
 		list_del(&zldpll->list);
 		zl3073x_dpll_free(zldpll);
 	}
@@ -839,7 +981,7 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 
 	INIT_LIST_HEAD(&zldev->dplls);
 
-	/* Initialize all DPLLs */
+	/* Allocate all DPLLs */
 	for (i = 0; i < num_dplls; i++) {
 		zldpll = zl3073x_dpll_alloc(zldev, i);
 		if (IS_ERR(zldpll)) {
@@ -849,25 +991,9 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 			goto error;
 		}
 
-		rc = zl3073x_dpll_register(zldpll);
-		if (rc) {
-			dev_err_probe(zldev->dev, rc,
-				      "Failed to register DPLL%u\n", i);
-			zl3073x_dpll_free(zldpll);
-			goto error;
-		}
-
 		list_add_tail(&zldpll->list, &zldev->dplls);
 	}
 
-	/* Perform initial firmware fine phase correction */
-	rc = zl3073x_dpll_init_fine_phase_adjust(zldev);
-	if (rc) {
-		dev_err_probe(zldev->dev, rc,
-			      "Failed to init fine phase correction\n");
-		goto error;
-	}
-
 	/* Initialize monitoring thread */
 	kthread_init_delayed_work(&zldev->work, zl3073x_dev_periodic_work);
 	kworker = kthread_run_worker(0, "zl3073x-%s", dev_name(zldev->dev));
@@ -875,9 +1001,14 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 		rc = PTR_ERR(kworker);
 		goto error;
 	}
-
 	zldev->kworker = kworker;
-	kthread_queue_delayed_work(zldev->kworker, &zldev->work, 0);
+
+	/* Start normal operation */
+	rc = zl3073x_dev_start(zldev, true);
+	if (rc) {
+		dev_err_probe(zldev->dev, rc, "Failed to start device\n");
+		goto error;
+	}
 
 	/* Add devres action to release DPLL related resources */
 	rc = devm_add_action_or_reset(zldev->dev, zl3073x_dev_dpll_fini, zldev);
@@ -892,46 +1023,6 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 	return rc;
 }
 
-/**
- * zl3073x_dev_phase_meas_setup - setup phase offset measurement
- * @zldev: pointer to zl3073x_dev structure
- * @num_channels: number of DPLL channels
- *
- * Enable phase offset measurement block, set measurement averaging factor
- * and enable DPLL-to-its-ref phase measurement for all DPLLs.
- *
- * Returns: 0 on success, <0 on error
- */
-static int
-zl3073x_dev_phase_meas_setup(struct zl3073x_dev *zldev, int num_channels)
-{
-	u8 dpll_meas_ctrl, mask;
-	int i, rc;
-
-	/* Read DPLL phase measurement control register */
-	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, &dpll_meas_ctrl);
-	if (rc)
-		return rc;
-
-	/* Setup phase measurement averaging factor */
-	dpll_meas_ctrl &= ~ZL_DPLL_MEAS_CTRL_AVG_FACTOR;
-	dpll_meas_ctrl |= FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, 3);
-
-	/* Enable DPLL measurement block */
-	dpll_meas_ctrl |= ZL_DPLL_MEAS_CTRL_EN;
-
-	/* Update phase measurement control register */
-	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, dpll_meas_ctrl);
-	if (rc)
-		return rc;
-
-	/* Enable DPLL-to-connected-ref measurement for each channel */
-	for (i = 0, mask = 0; i < num_channels; i++)
-		mask |= BIT(i);
-
-	return zl3073x_write_u8(zldev, ZL_REG_DPLL_PHASE_ERR_READ_MASK, mask);
-}
-
 /**
  * zl3073x_dev_probe - initialize zl3073x device
  * @zldev: pointer to zl3073x device
@@ -999,17 +1090,6 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		return dev_err_probe(zldev->dev, rc,
 				     "Failed to initialize mutex\n");
 
-	/* Fetch device state */
-	rc = zl3073x_dev_state_fetch(zldev);
-	if (rc)
-		return rc;
-
-	/* Setup phase offset measurement block */
-	rc = zl3073x_dev_phase_meas_setup(zldev, chip_info->num_channels);
-	if (rc)
-		return dev_err_probe(zldev->dev, rc,
-				     "Failed to setup phase measurement\n");
-
 	/* Register DPLL channels */
 	rc = zl3073x_devm_dpll_init(zldev, chip_info->num_channels);
 	if (rc)
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 71af2c800110..84e52d5521a3 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -111,6 +111,9 @@ struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev);
 int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		      const struct zl3073x_chip_info *chip_info);
 
+int zl3073x_dev_start(struct zl3073x_dev *zldev, bool full);
+void zl3073x_dev_stop(struct zl3073x_dev *zldev);
+
 /**********************
  * Registers operations
  **********************/
diff --git a/drivers/dpll/zl3073x/devlink.c b/drivers/dpll/zl3073x/devlink.c
index 7e7fe726ee37..c2e9f7aca3c8 100644
--- a/drivers/dpll/zl3073x/devlink.c
+++ b/drivers/dpll/zl3073x/devlink.c
@@ -86,14 +86,12 @@ zl3073x_devlink_reload_down(struct devlink *devlink, bool netns_change,
 			    struct netlink_ext_ack *extack)
 {
 	struct zl3073x_dev *zldev = devlink_priv(devlink);
-	struct zl3073x_dpll *zldpll;
 
 	if (action != DEVLINK_RELOAD_ACTION_DRIVER_REINIT)
 		return -EOPNOTSUPP;
 
-	/* Unregister all DPLLs */
-	list_for_each_entry(zldpll, &zldev->dplls, list)
-		zl3073x_dpll_unregister(zldpll);
+	/* Stop normal operation */
+	zl3073x_dev_stop(zldev);
 
 	return 0;
 }
@@ -107,7 +105,6 @@ zl3073x_devlink_reload_up(struct devlink *devlink,
 {
 	struct zl3073x_dev *zldev = devlink_priv(devlink);
 	union devlink_param_value val;
-	struct zl3073x_dpll *zldpll;
 	int rc;
 
 	if (action != DEVLINK_RELOAD_ACTION_DRIVER_REINIT)
@@ -125,13 +122,10 @@ zl3073x_devlink_reload_up(struct devlink *devlink,
 		zldev->clock_id = val.vu64;
 	}
 
-	/* Re-register all DPLLs */
-	list_for_each_entry(zldpll, &zldev->dplls, list) {
-		rc = zl3073x_dpll_register(zldpll);
-		if (rc)
-			dev_warn(zldev->dev,
-				 "Failed to re-register DPLL%u\n", zldpll->id);
-	}
+	/* Restart normal operation */
+	rc = zl3073x_dev_start(zldev, false);
+	if (rc)
+		dev_warn(zldev->dev, "Failed to re-start normal operation\n");
 
 	*actions_performed = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT);
 
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 614e33128a5c..bb9965b8e8c7 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -67,6 +67,9 @@
  * Register Page 0, General
  **************************/
 
+#define ZL_REG_INFO				ZL_REG(0, 0x00, 1)
+#define ZL_INFO_READY				BIT(7)
+
 #define ZL_REG_ID				ZL_REG(0, 0x01, 2)
 #define ZL_REG_REVISION				ZL_REG(0, 0x03, 2)
 #define ZL_REG_FW_VER				ZL_REG(0, 0x05, 2)
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 930de203d533..2d0fea87af79 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -84,7 +84,8 @@ amdgpu-y += \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o soc24.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
-	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o
+	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o \
+	cyan_skillfish_reg_init.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d5f9d48bf884..902eac2c685f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2325,10 +2325,9 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
 					  struct kfd_vm_fault_info *mem)
 {
-	if (atomic_read(&adev->gmc.vm_fault_info_updated) == 1) {
+	if (atomic_read_acquire(&adev->gmc.vm_fault_info_updated) == 1) {
 		*mem = *adev->gmc.vm_fault_info;
-		mb(); /* make sure read happened */
-		atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index efe0058b48ca..e814da2b1422 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1033,7 +1033,9 @@ static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
 	/* Until a uniform way is figured, get mask based on hwid */
 	switch (hw_id) {
 	case VCN_HWID:
-		harvest = ((1 << inst) & adev->vcn.inst_mask) == 0;
+		/* VCN vs UVD+VCE */
+		if (!amdgpu_ip_version(adev, VCE_HWIP, 0))
+			harvest = ((1 << inst) & adev->vcn.inst_mask) == 0;
 		break;
 	case DMU_HWID:
 		if (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
@@ -2562,7 +2564,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_discovery_init(adev);
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
+		adev->sdma.sdma_mask = 3;
 		adev->gmc.num_umc = 4;
+		adev->gfx.xcc_mask = 1;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 0, 0);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 0, 0);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 0, 0);
@@ -2589,7 +2593,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_discovery_init(adev);
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
+		adev->sdma.sdma_mask = 3;
 		adev->gmc.num_umc = 4;
+		adev->gfx.xcc_mask = 1;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 3, 0);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 3, 0);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 0, 1);
@@ -2616,8 +2622,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_discovery_init(adev);
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 1;
+		adev->sdma.sdma_mask = 1;
 		adev->vcn.num_vcn_inst = 1;
 		adev->gmc.num_umc = 2;
+		adev->gfx.xcc_mask = 1;
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
 			adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 2, 0);
 			adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 2, 0);
@@ -2662,7 +2670,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_discovery_init(adev);
 		vega20_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
+		adev->sdma.sdma_mask = 3;
 		adev->gmc.num_umc = 8;
+		adev->gfx.xcc_mask = 1;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 0);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 0);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 2, 0);
@@ -2690,8 +2700,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_discovery_init(adev);
 		arct_reg_base_init(adev);
 		adev->sdma.num_instances = 8;
+		adev->sdma.sdma_mask = 0xff;
 		adev->vcn.num_vcn_inst = 2;
 		adev->gmc.num_umc = 8;
+		adev->gfx.xcc_mask = 1;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 1);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 1);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 2, 1);
@@ -2723,8 +2735,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_discovery_init(adev);
 		aldebaran_reg_base_init(adev);
 		adev->sdma.num_instances = 5;
+		adev->sdma.sdma_mask = 0x1f;
 		adev->vcn.num_vcn_inst = 2;
 		adev->gmc.num_umc = 4;
+		adev->gfx.xcc_mask = 1;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 2);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 2);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 4, 0);
@@ -2746,6 +2760,38 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[UVD_HWIP][1] = IP_VERSION(2, 6, 0);
 		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 1, 0);
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2) {
+			r = amdgpu_discovery_reg_base_init(adev);
+			if (r)
+				return -EINVAL;
+
+			amdgpu_discovery_harvest_ip(adev);
+			amdgpu_discovery_get_gfx_info(adev);
+			amdgpu_discovery_get_mall_info(adev);
+			amdgpu_discovery_get_vcn_info(adev);
+		} else {
+			cyan_skillfish_reg_base_init(adev);
+			adev->sdma.num_instances = 2;
+			adev->sdma.sdma_mask = 3;
+			adev->gfx.xcc_mask = 1;
+			adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(2, 0, 3);
+			adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(2, 0, 3);
+			adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(5, 0, 1);
+			adev->ip_versions[HDP_HWIP][0] = IP_VERSION(5, 0, 1);
+			adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(5, 0, 1);
+			adev->ip_versions[SDMA1_HWIP][1] = IP_VERSION(5, 0, 1);
+			adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 5, 0);
+			adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(2, 1, 1);
+			adev->ip_versions[UMC_HWIP][0] = IP_VERSION(8, 1, 1);
+			adev->ip_versions[MP0_HWIP][0] = IP_VERSION(11, 0, 8);
+			adev->ip_versions[MP1_HWIP][0] = IP_VERSION(11, 0, 8);
+			adev->ip_versions[THM_HWIP][0] = IP_VERSION(11, 0, 1);
+			adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(11, 0, 8);
+			adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 1, 3);
+			adev->ip_versions[UVD_HWIP][0] = IP_VERSION(2, 0, 3);
+		}
+		break;
 	default:
 		r = amdgpu_discovery_reg_base_init(adev);
 		if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index dbbb3407fa13..65f4a76490ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2665,7 +2665,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	/* do not resume device if it's normal hibernation */
-	if (!pm_hibernate_is_recovering())
+	if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
 		return 0;
 
 	return amdgpu_device_resume(drm_dev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 9e7506965cab..9f79f0cc5ff8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -759,11 +759,42 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
  * @fence: fence of the ring to signal
  *
  */
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 {
-	dma_fence_set_error(&fence->base, -ETIME);
-	amdgpu_fence_write(fence->ring, fence->seq);
-	amdgpu_fence_process(fence->ring);
+	struct dma_fence *unprocessed;
+	struct dma_fence __rcu **ptr;
+	struct amdgpu_fence *fence;
+	struct amdgpu_ring *ring = af->ring;
+	unsigned long flags;
+	u32 seq, last_seq;
+
+	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
+	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
+
+	/* mark all fences from the guilty context with an error */
+	spin_lock_irqsave(&ring->fence_drv.lock, flags);
+	do {
+		last_seq++;
+		last_seq &= ring->fence_drv.num_fences_mask;
+
+		ptr = &ring->fence_drv.fences[last_seq];
+		rcu_read_lock();
+		unprocessed = rcu_dereference(*ptr);
+
+		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
+			fence = container_of(unprocessed, struct amdgpu_fence, base);
+
+			if (fence == af)
+				dma_fence_set_error(&fence->base, -ETIME);
+			else if (fence->context == af->context)
+				dma_fence_set_error(&fence->base, -ECANCELED);
+		}
+		rcu_read_unlock();
+	} while (last_seq != seq);
+	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
+	/* signal the guilty fence */
+	amdgpu_fence_write(ring, af->seq);
+	amdgpu_fence_process(ring);
 }
 
 void amdgpu_fence_save_wptr(struct dma_fence *fence)
@@ -791,14 +822,19 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	struct dma_fence *unprocessed;
 	struct dma_fence __rcu **ptr;
 	struct amdgpu_fence *fence;
-	u64 wptr, i, seqno;
+	u64 wptr;
+	u32 seq, last_seq;
 
-	seqno = amdgpu_fence_read(ring);
+	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
+	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
 	wptr = ring->fence_drv.signalled_wptr;
 	ring->ring_backup_entries_to_copy = 0;
 
-	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
-		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
+	do {
+		last_seq++;
+		last_seq &= ring->fence_drv.num_fences_mask;
+
+		ptr = &ring->fence_drv.fences[last_seq];
 		rcu_read_lock();
 		unprocessed = rcu_dereference(*ptr);
 
@@ -814,7 +850,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 			wptr = fence->wptr;
 		}
 		rcu_read_unlock();
-	}
+	} while (last_seq != seq);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 693357caa9a8..d9d7fc4c33cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2350,7 +2350,7 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	}
 
 	ret = psp_ta_load(psp, &psp->securedisplay_context.context);
-	if (!ret) {
+	if (!ret && !psp->securedisplay_context.context.resp_status) {
 		psp->securedisplay_context.context.initialized = true;
 		mutex_init(&psp->securedisplay_context.mutex);
 	} else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 8f6ce948c684..5ec5c3ff22bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -811,7 +811,7 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* signal the fence of the bad job */
+	/* signal the guilty fence and set an error on all fences from the context */
 	if (guilty_fence)
 		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	/* Re-emit the non-guilty commands */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 12783ea3ba0f..869b486168f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -155,7 +155,7 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
 void amdgpu_fence_save_wptr(struct dma_fence *fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c b/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
new file mode 100644
index 000000000000..96616a865aac
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include "amdgpu.h"
+#include "nv.h"
+
+#include "soc15_common.h"
+#include "soc15_hw_ip.h"
+#include "cyan_skillfish_ip_offset.h"
+
+int cyan_skillfish_reg_base_init(struct amdgpu_device *adev)
+{
+	/* HW has more IP blocks,  only initialized the blocke needed by driver */
+	uint32_t i;
+
+	adev->gfx.xcc_mask = 1;
+	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
+		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
+		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
+		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
+		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIO_BASE.instance[i]));
+		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
+		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
+		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(UVD0_BASE.instance[i]));
+		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
+		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DMU_BASE.instance[i]));
+		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
+		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SDMA1_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
+		adev->reg_offset[THM_HWIP][i] = (uint32_t *)(&(THM_BASE.instance[i]));
+		adev->reg_offset[CLK_HWIP][i] = (uint32_t *)(&(CLK_BASE.instance[i]));
+	}
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index a8d5795084fc..cf30d3332050 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1066,7 +1066,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 					GFP_KERNEL);
 	if (!adev->gmc.vm_fault_info)
 		return -ENOMEM;
-	atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
 }
@@ -1288,7 +1288,7 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 	vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     VMID);
 	if (amdgpu_amdkfd_is_kfd_vmid(adev, vmid)
-		&& !atomic_read(&adev->gmc.vm_fault_info_updated)) {
+		&& !atomic_read_acquire(&adev->gmc.vm_fault_info_updated)) {
 		struct kfd_vm_fault_info *info = adev->gmc.vm_fault_info;
 		u32 protections = REG_GET_FIELD(status,
 					VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1304,8 +1304,7 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 		info->prot_read = protections & 0x8 ? true : false;
 		info->prot_write = protections & 0x10 ? true : false;
 		info->prot_exec = protections & 0x20 ? true : false;
-		mb();
-		atomic_set(&adev->gmc.vm_fault_info_updated, 1);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 1);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index b45fa0cea9d2..0d4c93ff6f74 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1179,7 +1179,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 					GFP_KERNEL);
 	if (!adev->gmc.vm_fault_info)
 		return -ENOMEM;
-	atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
 }
@@ -1474,7 +1474,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 	vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     VMID);
 	if (amdgpu_amdkfd_is_kfd_vmid(adev, vmid)
-		&& !atomic_read(&adev->gmc.vm_fault_info_updated)) {
+		&& !atomic_read_acquire(&adev->gmc.vm_fault_info_updated)) {
 		struct kfd_vm_fault_info *info = adev->gmc.vm_fault_info;
 		u32 protections = REG_GET_FIELD(status,
 					VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1490,8 +1490,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		info->prot_read = protections & 0x8 ? true : false;
 		info->prot_write = protections & 0x10 ? true : false;
 		info->prot_exec = protections & 0x20 ? true : false;
-		mb();
-		atomic_set(&adev->gmc.vm_fault_info_updated, 1);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 1);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 39caac14d5fe..1622b1cd6f2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -225,7 +225,12 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 			pipe, x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, seq, timeout);
-	if (r < 1 || !*status_ptr) {
+
+	/*
+	 * status_ptr[31:0] == 0 (fail) or status_ptr[63:0] == 1 (success).
+	 * If status_ptr[31:0] == 0 then status_ptr[63:32] will have debug error information.
+	 */
+	if (r < 1 || !(lower_32_bits(*status_ptr))) {
 
 		if (misc_op_str)
 			dev_err(adev->dev, "MES(%d) failed to respond to msg=%s (%s)\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
index 83e9782aef39..8f4817404f10 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -31,5 +31,6 @@ extern const struct amdgpu_ip_block_version nv_common_ip_block;
 void nv_grbm_select(struct amdgpu_device *adev,
 		    u32 me, u32 pipe, u32 queue, u32 vmid);
 void nv_set_virt_ops(struct amdgpu_device *adev);
+int cyan_skillfish_reg_base_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 58c4e57abc9e..163780030eb1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2041,8 +2041,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	dc_hardware_init(adev->dm.dc);
 
-	adev->dm.restore_backlight = true;
-
 	adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev);
 	if (!adev->dm.hpd_rx_offload_wq) {
 		drm_err(adev_to_drm(adev), "failed to create hpd rx offload workqueue.\n");
@@ -3405,7 +3403,6 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
 		dc_resume(dm->dc);
-		adev->dm.restore_backlight = true;
 
 		amdgpu_dm_irq_resume_early(adev);
 
@@ -9836,6 +9833,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	bool mode_set_reset_required = false;
 	u32 i;
 	struct dc_commit_streams_params params = {dc_state->streams, dc_state->stream_count};
+	bool set_backlight_level = false;
 
 	/* Disable writeback */
 	for_each_old_connector_in_state(state, connector, old_con_state, i) {
@@ -9955,6 +9953,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 			acrtc->hw_mode = new_crtc_state->mode;
 			crtc->hwmode = new_crtc_state->mode;
 			mode_set_reset_required = true;
+			set_backlight_level = true;
 		} else if (modereset_required(new_crtc_state)) {
 			drm_dbg_atomic(dev,
 				       "Atomic commit: RESET. crtc id %d:[%p]\n",
@@ -10011,16 +10010,13 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	 * to fix a flicker issue.
 	 * It will cause the dm->actual_brightness is not the current panel brightness
 	 * level. (the dm->brightness is the correct panel level)
-	 * So we set the backlight level with dm->brightness value after initial
-	 * set mode. Use restore_backlight flag to avoid setting backlight level
-	 * for every subsequent mode set.
+	 * So we set the backlight level with dm->brightness value after set mode
 	 */
-	if (dm->restore_backlight) {
+	if (set_backlight_level) {
 		for (i = 0; i < dm->num_of_edps; i++) {
 			if (dm->backlight_dev[i])
 				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
 		}
-		dm->restore_backlight = false;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 6aae51c1beb3..b937da0a4e4a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -610,13 +610,6 @@ struct amdgpu_display_manager {
 	 */
 	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
 
-	/**
-	 * @restore_backlight:
-	 *
-	 * Flag to indicate whether to restore backlight after modeset.
-	 */
-	bool restore_backlight;
-
 	/**
 	 * @aux_hpd_discon_quirk:
 	 *
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 8da882c51856..9b28c0728269 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5444,8 +5444,7 @@ static int smu7_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		thermal_data->max = table_info->cac_dtp_table->usSoftwareShutdownTemp *
 			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	else if (hwmgr->pp_table_version == PP_TABLE_V0)
-		thermal_data->max = data->thermal_temp_setting.temperature_shutdown *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		thermal_data->max = data->thermal_temp_setting.temperature_shutdown;
 
 	thermal_data->sw_ctf_threshold = thermal_data->max;
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index 399fa7eebd49..03fc8fd10f20 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -121,8 +121,7 @@ static int lt9211_read_chipid(struct lt9211 *ctx)
 	}
 
 	/* Test for known Chip ID. */
-	if (chipid[0] != REG_CHIPID0_VALUE || chipid[1] != REG_CHIPID1_VALUE ||
-	    chipid[2] != REG_CHIPID2_VALUE) {
+	if (chipid[0] != REG_CHIPID0_VALUE || chipid[1] != REG_CHIPID1_VALUE) {
 		dev_err(ctx->dev, "Unknown Chip ID: 0x%02x 0x%02x 0x%02x\n",
 			chipid[0], chipid[1], chipid[2]);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
index 9dc0408fbbea..5b956229c82f 100644
--- a/drivers/gpu/drm/drm_draw.c
+++ b/drivers/gpu/drm/drm_draw.c
@@ -127,7 +127,7 @@ EXPORT_SYMBOL(drm_draw_fill16);
 
 void drm_draw_fill24(struct iosys_map *dmap, unsigned int dpitch,
 		     unsigned int height, unsigned int width,
-		     u16 color)
+		     u32 color)
 {
 	unsigned int y, x;
 
diff --git a/drivers/gpu/drm/drm_draw_internal.h b/drivers/gpu/drm/drm_draw_internal.h
index f121ee7339dc..20cb404e23ea 100644
--- a/drivers/gpu/drm/drm_draw_internal.h
+++ b/drivers/gpu/drm/drm_draw_internal.h
@@ -47,7 +47,7 @@ void drm_draw_fill16(struct iosys_map *dmap, unsigned int dpitch,
 
 void drm_draw_fill24(struct iosys_map *dmap, unsigned int dpitch,
 		     unsigned int height, unsigned int width,
-		     u16 color);
+		     u32 color);
 
 void drm_draw_fill32(struct iosys_map *dmap, unsigned int dpitch,
 		     unsigned int height, unsigned int width,
diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
index 0da842bd2f2f..974e5b547d88 100644
--- a/drivers/gpu/drm/i915/display/intel_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fb.c
@@ -2111,10 +2111,10 @@ static void intel_user_framebuffer_destroy(struct drm_framebuffer *fb)
 	if (intel_fb_uses_dpt(fb))
 		intel_dpt_destroy(intel_fb->dpt_vm);
 
-	intel_frontbuffer_put(intel_fb->frontbuffer);
-
 	intel_fb_bo_framebuffer_fini(intel_fb_bo(fb));
 
+	intel_frontbuffer_put(intel_fb->frontbuffer);
+
 	kfree(intel_fb);
 }
 
@@ -2216,15 +2216,17 @@ int intel_framebuffer_init(struct intel_framebuffer *intel_fb,
 	int ret = -EINVAL;
 	int i;
 
+	/*
+	 * intel_frontbuffer_get() must be done before
+	 * intel_fb_bo_framebuffer_init() to avoid set_tiling vs. addfb race.
+	 */
+	intel_fb->frontbuffer = intel_frontbuffer_get(obj);
+	if (!intel_fb->frontbuffer)
+		return -ENOMEM;
+
 	ret = intel_fb_bo_framebuffer_init(fb, obj, mode_cmd);
 	if (ret)
-		return ret;
-
-	intel_fb->frontbuffer = intel_frontbuffer_get(obj);
-	if (!intel_fb->frontbuffer) {
-		ret = -ENOMEM;
-		goto err;
-	}
+		goto err_frontbuffer_put;
 
 	ret = -EINVAL;
 	if (!drm_any_plane_has_format(display->drm,
@@ -2233,7 +2235,7 @@ int intel_framebuffer_init(struct intel_framebuffer *intel_fb,
 		drm_dbg_kms(display->drm,
 			    "unsupported pixel format %p4cc / modifier 0x%llx\n",
 			    &mode_cmd->pixel_format, mode_cmd->modifier[0]);
-		goto err_frontbuffer_put;
+		goto err_bo_framebuffer_fini;
 	}
 
 	max_stride = intel_fb_max_stride(display, mode_cmd->pixel_format,
@@ -2244,7 +2246,7 @@ int intel_framebuffer_init(struct intel_framebuffer *intel_fb,
 			    mode_cmd->modifier[0] != DRM_FORMAT_MOD_LINEAR ?
 			    "tiled" : "linear",
 			    mode_cmd->pitches[0], max_stride);
-		goto err_frontbuffer_put;
+		goto err_bo_framebuffer_fini;
 	}
 
 	/* FIXME need to adjust LINOFF/TILEOFF accordingly. */
@@ -2252,7 +2254,7 @@ int intel_framebuffer_init(struct intel_framebuffer *intel_fb,
 		drm_dbg_kms(display->drm,
 			    "plane 0 offset (0x%08x) must be 0\n",
 			    mode_cmd->offsets[0]);
-		goto err_frontbuffer_put;
+		goto err_bo_framebuffer_fini;
 	}
 
 	drm_helper_mode_fill_fb_struct(display->drm, fb, info, mode_cmd);
@@ -2262,7 +2264,7 @@ int intel_framebuffer_init(struct intel_framebuffer *intel_fb,
 
 		if (mode_cmd->handles[i] != mode_cmd->handles[0]) {
 			drm_dbg_kms(display->drm, "bad plane %d handle\n", i);
-			goto err_frontbuffer_put;
+			goto err_bo_framebuffer_fini;
 		}
 
 		stride_alignment = intel_fb_stride_alignment(fb, i);
@@ -2270,7 +2272,7 @@ int intel_framebuffer_init(struct intel_framebuffer *intel_fb,
 			drm_dbg_kms(display->drm,
 				    "plane %d pitch (%d) must be at least %u byte aligned\n",
 				    i, fb->pitches[i], stride_alignment);
-			goto err_frontbuffer_put;
+			goto err_bo_framebuffer_fini;
 		}
 
 		if (intel_fb_is_gen12_ccs_aux_plane(fb, i)) {
@@ -2280,7 +2282,7 @@ int intel_framebuffer_init(struct intel_framebuffer *intel_fb,
 				drm_dbg_kms(display->drm,
 					    "ccs aux plane %d pitch (%d) must be %d\n",
 					    i, fb->pitches[i], ccs_aux_stride);
-				goto err_frontbuffer_put;
+				goto err_bo_framebuffer_fini;
 			}
 		}
 
@@ -2289,7 +2291,7 @@ int intel_framebuffer_init(struct intel_framebuffer *intel_fb,
 
 	ret = intel_fill_fb_info(display, intel_fb);
 	if (ret)
-		goto err_frontbuffer_put;
+		goto err_bo_framebuffer_fini;
 
 	if (intel_fb_uses_dpt(fb)) {
 		struct i915_address_space *vm;
@@ -2315,10 +2317,10 @@ int intel_framebuffer_init(struct intel_framebuffer *intel_fb,
 err_free_dpt:
 	if (intel_fb_uses_dpt(fb))
 		intel_dpt_destroy(intel_fb->dpt_vm);
+err_bo_framebuffer_fini:
+	intel_fb_bo_framebuffer_fini(obj);
 err_frontbuffer_put:
 	intel_frontbuffer_put(intel_fb->frontbuffer);
-err:
-	intel_fb_bo_framebuffer_fini(obj);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/i915/display/intel_frontbuffer.c b/drivers/gpu/drm/i915/display/intel_frontbuffer.c
index 43be5377ddc1..73ed28ac9573 100644
--- a/drivers/gpu/drm/i915/display/intel_frontbuffer.c
+++ b/drivers/gpu/drm/i915/display/intel_frontbuffer.c
@@ -270,6 +270,8 @@ static void frontbuffer_release(struct kref *ref)
 	spin_unlock(&display->fb_tracking.lock);
 
 	i915_active_fini(&front->write);
+
+	drm_gem_object_put(obj);
 	kfree_rcu(front, rcu);
 }
 
@@ -287,6 +289,8 @@ intel_frontbuffer_get(struct drm_gem_object *obj)
 	if (!front)
 		return NULL;
 
+	drm_gem_object_get(obj);
+
 	front->obj = obj;
 	kref_init(&front->ref);
 	atomic_set(&front->bits, 0);
@@ -299,8 +303,12 @@ intel_frontbuffer_get(struct drm_gem_object *obj)
 	spin_lock(&display->fb_tracking.lock);
 	cur = intel_bo_set_frontbuffer(obj, front);
 	spin_unlock(&display->fb_tracking.lock);
-	if (cur != front)
+
+	if (cur != front) {
+		drm_gem_object_put(obj);
 		kfree(front);
+	}
+
 	return cur;
 }
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_frontbuffer.h b/drivers/gpu/drm/i915/gem/i915_gem_object_frontbuffer.h
index b6dc3d1b9bb1..b682969e3a29 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object_frontbuffer.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object_frontbuffer.h
@@ -89,12 +89,10 @@ i915_gem_object_set_frontbuffer(struct drm_i915_gem_object *obj,
 
 	if (!front) {
 		RCU_INIT_POINTER(obj->frontbuffer, NULL);
-		drm_gem_object_put(intel_bo_to_drm_bo(obj));
 	} else if (rcu_access_pointer(obj->frontbuffer)) {
 		cur = rcu_dereference_protected(obj->frontbuffer, true);
 		kref_get(&cur->ref);
 	} else {
-		drm_gem_object_get(intel_bo_to_drm_bo(obj));
 		rcu_assign_pointer(obj->frontbuffer, front);
 	}
 
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
index 0d5197c0824a..5cf3a516ccfb 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
@@ -1324,9 +1324,16 @@ static int ct_receive(struct intel_guc_ct *ct)
 
 static void ct_try_receive_message(struct intel_guc_ct *ct)
 {
+	struct intel_guc *guc = ct_to_guc(ct);
 	int ret;
 
-	if (GEM_WARN_ON(!ct->enabled))
+	if (!ct->enabled) {
+		GEM_WARN_ON(!guc_to_gt(guc)->uc.reset_in_progress);
+		return;
+	}
+
+	/* When interrupt disabled, message handling is not expected */
+	if (!guc->interrupts.enabled)
 		return;
 
 	ret = ct_receive(ct);
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 36f1034839c2..44a995835188 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1099,6 +1099,7 @@ void panthor_fw_pre_reset(struct panthor_device *ptdev, bool on_hang)
 	}
 
 	panthor_job_irq_suspend(&ptdev->fw->irq);
+	panthor_fw_stop(ptdev);
 }
 
 /**
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index b50927a824b4..7ec7bea5e38e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1031,7 +1031,7 @@ static int vop2_plane_atomic_check(struct drm_plane *plane,
 		return format;
 
 	if (drm_rect_width(src) >> 16 < 4 || drm_rect_height(src) >> 16 < 4 ||
-	    drm_rect_width(dest) < 4 || drm_rect_width(dest) < 4) {
+	    drm_rect_width(dest) < 4 || drm_rect_height(dest) < 4) {
 		drm_err(vop2->drm, "Invalid size: %dx%d->%dx%d, min size is 4x4\n",
 			drm_rect_width(src) >> 16, drm_rect_height(src) >> 16,
 			drm_rect_width(dest), drm_rect_height(dest));
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index e2cda28a1af4..5193be67b28e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -986,13 +986,14 @@ int drm_sched_job_add_resv_dependencies(struct drm_sched_job *job,
 	dma_resv_assert_held(resv);
 
 	dma_resv_for_each_fence(&cursor, resv, usage, fence) {
-		/* Make sure to grab an additional ref on the added fence */
-		dma_fence_get(fence);
-		ret = drm_sched_job_add_dependency(job, fence);
-		if (ret) {
-			dma_fence_put(fence);
+		/*
+		 * As drm_sched_job_add_dependency always consumes the fence
+		 * reference (even when it fails), and dma_resv_for_each_fence
+		 * is not obtaining one, we need to grab one before calling.
+		 */
+		ret = drm_sched_job_add_dependency(job, dma_fence_get(fence));
+		if (ret)
 			return ret;
-		}
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index c38fba18effe..f2cfba674899 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -16,6 +16,7 @@
 #include "xe_device.h"
 #include "xe_ggtt.h"
 #include "xe_pm.h"
+#include "xe_vram_types.h"
 
 static void
 write_dpt_rotated(struct xe_bo *bo, struct iosys_map *map, u32 *dpt_ofs, u32 bo_ofs,
@@ -289,7 +290,7 @@ static struct i915_vma *__xe_pin_fb_vma(const struct intel_framebuffer *fb,
 	if (IS_DGFX(to_xe_device(bo->ttm.base.dev)) &&
 	    intel_fb_rc_ccs_cc_plane(&fb->base) >= 0 &&
 	    !(bo->flags & XE_BO_FLAG_NEEDS_CPU_ACCESS)) {
-		struct xe_tile *tile = xe_device_get_root_tile(xe);
+		struct xe_vram_region *vram = xe_device_get_root_tile(xe)->mem.vram;
 
 		/*
 		 * If we need to able to access the clear-color value stored in
@@ -297,7 +298,7 @@ static struct i915_vma *__xe_pin_fb_vma(const struct intel_framebuffer *fb,
 		 * accessible.  This is important on small-bar systems where
 		 * only some subset of VRAM is CPU accessible.
 		 */
-		if (tile->mem.vram.io_size < tile->mem.vram.usable_size) {
+		if (xe_vram_region_io_size(vram) < xe_vram_region_usable_size(vram)) {
 			ret = -EINVAL;
 			goto err;
 		}
diff --git a/drivers/gpu/drm/xe/display/xe_plane_initial.c b/drivers/gpu/drm/xe/display/xe_plane_initial.c
index dcbc4b2d3fd9..b2d27458def5 100644
--- a/drivers/gpu/drm/xe/display/xe_plane_initial.c
+++ b/drivers/gpu/drm/xe/display/xe_plane_initial.c
@@ -21,6 +21,7 @@
 #include "intel_plane.h"
 #include "intel_plane_initial.h"
 #include "xe_bo.h"
+#include "xe_vram_types.h"
 #include "xe_wa.h"
 
 #include <generated/xe_wa_oob.h>
@@ -103,7 +104,7 @@ initial_plane_bo(struct xe_device *xe,
 		 * We don't currently expect this to ever be placed in the
 		 * stolen portion.
 		 */
-		if (phys_base >= tile0->mem.vram.usable_size) {
+		if (phys_base >= xe_vram_region_usable_size(tile0->mem.vram)) {
 			drm_err(&xe->drm,
 				"Initial plane programming using invalid range, phys_base=%pa\n",
 				&phys_base);
diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index 5cd5ab8529c5..9994887fc73f 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -342,6 +342,7 @@
 #define POWERGATE_ENABLE			XE_REG(0xa210)
 #define   RENDER_POWERGATE_ENABLE		REG_BIT(0)
 #define   MEDIA_POWERGATE_ENABLE		REG_BIT(1)
+#define   MEDIA_SAMPLERS_POWERGATE_ENABLE	REG_BIT(2)
 #define   VDN_HCP_POWERGATE_ENABLE(n)		REG_BIT(3 + 2 * (n))
 #define   VDN_MFXVDENC_POWERGATE_ENABLE(n)	REG_BIT(4 + 2 * (n))
 
diff --git a/drivers/gpu/drm/xe/xe_assert.h b/drivers/gpu/drm/xe/xe_assert.h
index 68fe70ce2be3..a818eaa05b7d 100644
--- a/drivers/gpu/drm/xe/xe_assert.h
+++ b/drivers/gpu/drm/xe/xe_assert.h
@@ -12,6 +12,7 @@
 
 #include "xe_gt_types.h"
 #include "xe_step.h"
+#include "xe_vram.h"
 
 /**
  * DOC: Xe Asserts
@@ -145,7 +146,8 @@
 	const struct xe_tile *__tile = (tile);							\
 	char __buf[10] __maybe_unused;								\
 	xe_assert_msg(tile_to_xe(__tile), condition, "tile: %u VRAM %s\n" msg,			\
-		      __tile->id, ({ string_get_size(__tile->mem.vram.actual_physical_size, 1,	\
+		      __tile->id, ({ string_get_size(						\
+				     xe_vram_region_actual_physical_size(__tile->mem.vram), 1,	\
 				     STRING_UNITS_2, __buf, sizeof(__buf)); __buf; }), ## arg);	\
 })
 
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index bae7ff2e5927..50c79049ccea 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -36,6 +36,7 @@
 #include "xe_trace_bo.h"
 #include "xe_ttm_stolen_mgr.h"
 #include "xe_vm.h"
+#include "xe_vram_types.h"
 
 const char *const xe_mem_type_to_name[TTM_NUM_MEM_TYPES]  = {
 	[XE_PL_SYSTEM] = "system",
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 9ce94d252015..cfb1ec266a6d 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -12,6 +12,7 @@
 #include "xe_macros.h"
 #include "xe_vm_types.h"
 #include "xe_vm.h"
+#include "xe_vram_types.h"
 
 #define XE_DEFAULT_GTT_SIZE_MB          3072ULL /* 3GB by default */
 
@@ -23,8 +24,9 @@
 #define XE_BO_FLAG_VRAM_MASK		(XE_BO_FLAG_VRAM0 | XE_BO_FLAG_VRAM1)
 /* -- */
 #define XE_BO_FLAG_STOLEN		BIT(4)
+#define XE_BO_FLAG_VRAM(vram)		(XE_BO_FLAG_VRAM0 << ((vram)->id))
 #define XE_BO_FLAG_VRAM_IF_DGFX(tile)	(IS_DGFX(tile_to_xe(tile)) ? \
-					 XE_BO_FLAG_VRAM0 << (tile)->id : \
+					 XE_BO_FLAG_VRAM((tile)->mem.vram) : \
 					 XE_BO_FLAG_SYSTEM)
 #define XE_BO_FLAG_GGTT			BIT(5)
 #define XE_BO_FLAG_IGNORE_MIN_PAGE_SIZE BIT(6)
diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
index d5dbc51e8612..bc5b4c5fab81 100644
--- a/drivers/gpu/drm/xe/xe_bo_evict.c
+++ b/drivers/gpu/drm/xe/xe_bo_evict.c
@@ -182,7 +182,6 @@ int xe_bo_evict_all(struct xe_device *xe)
 
 static int xe_bo_restore_and_map_ggtt(struct xe_bo *bo)
 {
-	struct xe_device *xe = xe_bo_device(bo);
 	int ret;
 
 	ret = xe_bo_restore_pinned(bo);
@@ -201,13 +200,6 @@ static int xe_bo_restore_and_map_ggtt(struct xe_bo *bo)
 		}
 	}
 
-	/*
-	 * We expect validate to trigger a move VRAM and our move code
-	 * should setup the iosys map.
-	 */
-	xe_assert(xe, !(bo->flags & XE_BO_FLAG_PINNED_LATE_RESTORE) ||
-		  !iosys_map_is_null(&bo->vmap));
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index ff560d82496f..57d34698139e 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -9,6 +9,7 @@
 #include <linux/iosys-map.h>
 
 #include <drm/drm_gpusvm.h>
+#include <drm/drm_pagemap.h>
 #include <drm/ttm/ttm_bo.h>
 #include <drm/ttm/ttm_device.h>
 #include <drm/ttm/ttm_placement.h>
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 6ece4defa9df..1c9907b8a4e9 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -64,6 +64,7 @@
 #include "xe_ttm_sys_mgr.h"
 #include "xe_vm.h"
 #include "xe_vram.h"
+#include "xe_vram_types.h"
 #include "xe_vsec.h"
 #include "xe_wait_user_fence.h"
 #include "xe_wa.h"
@@ -688,6 +689,21 @@ static void sriov_update_device_info(struct xe_device *xe)
 	}
 }
 
+static int xe_device_vram_alloc(struct xe_device *xe)
+{
+	struct xe_vram_region *vram;
+
+	if (!IS_DGFX(xe))
+		return 0;
+
+	vram = drmm_kzalloc(&xe->drm, sizeof(*vram), GFP_KERNEL);
+	if (!vram)
+		return -ENOMEM;
+
+	xe->mem.vram = vram;
+	return 0;
+}
+
 /**
  * xe_device_probe_early: Device early probe
  * @xe: xe device instance
@@ -735,6 +751,10 @@ int xe_device_probe_early(struct xe_device *xe)
 
 	xe->wedged.mode = xe_modparam.wedged_mode;
 
+	err = xe_device_vram_alloc(xe);
+	if (err)
+		return err;
+
 	return 0;
 }
 ALLOW_ERROR_INJECTION(xe_device_probe_early, ERRNO); /* See xe_pci_probe() */
@@ -1029,7 +1049,7 @@ void xe_device_l2_flush(struct xe_device *xe)
 	spin_lock(&gt->global_invl_lock);
 
 	xe_mmio_write32(&gt->mmio, XE2_GLOBAL_INVAL, 0x1);
-	if (xe_mmio_wait32(&gt->mmio, XE2_GLOBAL_INVAL, 0x1, 0x0, 500, NULL, true))
+	if (xe_mmio_wait32(&gt->mmio, XE2_GLOBAL_INVAL, 0x1, 0x0, 1000, NULL, true))
 		xe_gt_err_once(gt, "Global invalidation timeout\n");
 
 	spin_unlock(&gt->global_invl_lock);
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 7ceb0c90f391..ac6419f47573 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -10,7 +10,6 @@
 
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
-#include <drm/drm_pagemap.h>
 #include <drm/ttm/ttm_device.h>
 
 #include "xe_devcoredump_types.h"
@@ -26,7 +25,6 @@
 #include "xe_sriov_vf_types.h"
 #include "xe_step_types.h"
 #include "xe_survivability_mode_types.h"
-#include "xe_ttm_vram_mgr_types.h"
 
 #if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
 #define TEST_VM_OPS_ERROR
@@ -39,6 +37,7 @@ struct xe_ggtt;
 struct xe_i2c;
 struct xe_pat_ops;
 struct xe_pxp;
+struct xe_vram_region;
 
 #define XE_BO_INVALID_OFFSET	LONG_MAX
 
@@ -71,61 +70,6 @@ struct xe_pxp;
 		 const struct xe_tile * : (const struct xe_device *)((tile__)->xe),	\
 		 struct xe_tile * : (tile__)->xe)
 
-/**
- * struct xe_vram_region - memory region structure
- * This is used to describe a memory region in xe
- * device, such as HBM memory or CXL extension memory.
- */
-struct xe_vram_region {
-	/** @io_start: IO start address of this VRAM instance */
-	resource_size_t io_start;
-	/**
-	 * @io_size: IO size of this VRAM instance
-	 *
-	 * This represents how much of this VRAM we can access
-	 * via the CPU through the VRAM BAR. This can be smaller
-	 * than @usable_size, in which case only part of VRAM is CPU
-	 * accessible (typically the first 256M). This
-	 * configuration is known as small-bar.
-	 */
-	resource_size_t io_size;
-	/** @dpa_base: This memory regions's DPA (device physical address) base */
-	resource_size_t dpa_base;
-	/**
-	 * @usable_size: usable size of VRAM
-	 *
-	 * Usable size of VRAM excluding reserved portions
-	 * (e.g stolen mem)
-	 */
-	resource_size_t usable_size;
-	/**
-	 * @actual_physical_size: Actual VRAM size
-	 *
-	 * Actual VRAM size including reserved portions
-	 * (e.g stolen mem)
-	 */
-	resource_size_t actual_physical_size;
-	/** @mapping: pointer to VRAM mappable space */
-	void __iomem *mapping;
-	/** @ttm: VRAM TTM manager */
-	struct xe_ttm_vram_mgr ttm;
-#if IS_ENABLED(CONFIG_DRM_XE_PAGEMAP)
-	/** @pagemap: Used to remap device memory as ZONE_DEVICE */
-	struct dev_pagemap pagemap;
-	/**
-	 * @dpagemap: The struct drm_pagemap of the ZONE_DEVICE memory
-	 * pages of this tile.
-	 */
-	struct drm_pagemap dpagemap;
-	/**
-	 * @hpa_base: base host physical address
-	 *
-	 * This is generated when remap device memory as ZONE_DEVICE
-	 */
-	resource_size_t hpa_base;
-#endif
-};
-
 /**
  * struct xe_mmio - register mmio structure
  *
@@ -216,7 +160,7 @@ struct xe_tile {
 		 * Although VRAM is associated with a specific tile, it can
 		 * still be accessed by all tiles' GTs.
 		 */
-		struct xe_vram_region vram;
+		struct xe_vram_region *vram;
 
 		/** @mem.ggtt: Global graphics translation table */
 		struct xe_ggtt *ggtt;
@@ -412,7 +356,7 @@ struct xe_device {
 	/** @mem: memory info for device */
 	struct {
 		/** @mem.vram: VRAM info for device */
-		struct xe_vram_region vram;
+		struct xe_vram_region *vram;
 		/** @mem.sys_mgr: system TTM manager */
 		struct ttm_resource_manager sys_mgr;
 		/** @mem.sys_mgr: system memory shrinker. */
diff --git a/drivers/gpu/drm/xe/xe_gt_idle.c b/drivers/gpu/drm/xe/xe_gt_idle.c
index ffb210216aa9..9bd197da6027 100644
--- a/drivers/gpu/drm/xe/xe_gt_idle.c
+++ b/drivers/gpu/drm/xe/xe_gt_idle.c
@@ -124,6 +124,9 @@ void xe_gt_idle_enable_pg(struct xe_gt *gt)
 	if (xe_gt_is_main_type(gt))
 		gtidle->powergate_enable |= RENDER_POWERGATE_ENABLE;
 
+	if (MEDIA_VERx100(xe) >= 1100 && MEDIA_VERx100(xe) < 1255)
+		gtidle->powergate_enable |= MEDIA_SAMPLERS_POWERGATE_ENABLE;
+
 	if (xe->info.platform != XE_DG1) {
 		for (i = XE_HW_ENGINE_VCS0, j = 0; i <= XE_HW_ENGINE_VCS7; ++i, ++j) {
 			if ((gt->info.engine_mask & BIT(i)))
@@ -246,6 +249,11 @@ int xe_gt_idle_pg_print(struct xe_gt *gt, struct drm_printer *p)
 				drm_printf(p, "Media Slice%d Power Gate Status: %s\n", n,
 					   str_up_down(pg_status & media_slices[n].status_bit));
 	}
+
+	if (MEDIA_VERx100(xe) >= 1100 && MEDIA_VERx100(xe) < 1255)
+		drm_printf(p, "Media Samplers Power Gating Enabled: %s\n",
+			   str_yes_no(pg_enabled & MEDIA_SAMPLERS_POWERGATE_ENABLE));
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_gt_pagefault.c b/drivers/gpu/drm/xe/xe_gt_pagefault.c
index 5a75d56d8558..ab43dec52776 100644
--- a/drivers/gpu/drm/xe/xe_gt_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_gt_pagefault.c
@@ -23,6 +23,7 @@
 #include "xe_svm.h"
 #include "xe_trace_bo.h"
 #include "xe_vm.h"
+#include "xe_vram_types.h"
 
 struct pagefault {
 	u64 page_addr;
@@ -74,7 +75,7 @@ static bool vma_is_valid(struct xe_tile *tile, struct xe_vma *vma)
 }
 
 static int xe_pf_begin(struct drm_exec *exec, struct xe_vma *vma,
-		       bool atomic, unsigned int id)
+		       bool atomic, struct xe_vram_region *vram)
 {
 	struct xe_bo *bo = xe_vma_bo(vma);
 	struct xe_vm *vm = xe_vma_vm(vma);
@@ -84,14 +85,16 @@ static int xe_pf_begin(struct drm_exec *exec, struct xe_vma *vma,
 	if (err)
 		return err;
 
-	if (atomic && IS_DGFX(vm->xe)) {
+	if (atomic && vram) {
+		xe_assert(vm->xe, IS_DGFX(vm->xe));
+
 		if (xe_vma_is_userptr(vma)) {
 			err = -EACCES;
 			return err;
 		}
 
 		/* Migrate to VRAM, move should invalidate the VMA first */
-		err = xe_bo_migrate(bo, XE_PL_VRAM0 + id);
+		err = xe_bo_migrate(bo, vram->placement);
 		if (err)
 			return err;
 	} else if (bo) {
@@ -138,7 +141,7 @@ static int handle_vma_pagefault(struct xe_gt *gt, struct xe_vma *vma,
 	/* Lock VM and BOs dma-resv */
 	drm_exec_init(&exec, 0, 0);
 	drm_exec_until_all_locked(&exec) {
-		err = xe_pf_begin(&exec, vma, atomic, tile->id);
+		err = xe_pf_begin(&exec, vma, atomic, tile->mem.vram);
 		drm_exec_retry_on_contention(&exec);
 		if (xe_vm_validate_should_retry(&exec, err, &end))
 			err = -EAGAIN;
@@ -573,7 +576,7 @@ static int handle_acc(struct xe_gt *gt, struct acc *acc)
 	/* Lock VM and BOs dma-resv */
 	drm_exec_init(&exec, 0, 0);
 	drm_exec_until_all_locked(&exec) {
-		ret = xe_pf_begin(&exec, vma, true, tile->id);
+		ret = xe_pf_begin(&exec, vma, true, tile->mem.vram);
 		drm_exec_retry_on_contention(&exec);
 		if (ret)
 			break;
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
index d84831a03610..61a357946fe1 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
@@ -33,6 +33,7 @@
 #include "xe_migrate.h"
 #include "xe_sriov.h"
 #include "xe_ttm_vram_mgr.h"
+#include "xe_vram_types.h"
 #include "xe_wopcm.h"
 
 #define make_u64_from_u32(hi, lo) ((u64)((u64)(u32)(hi) << 32 | (u32)(lo)))
@@ -1604,7 +1605,7 @@ static u64 pf_query_free_lmem(struct xe_gt *gt)
 {
 	struct xe_tile *tile = gt->tile;
 
-	return xe_ttm_vram_get_avail(&tile->mem.vram.ttm.manager);
+	return xe_ttm_vram_get_avail(&tile->mem.vram->ttm.manager);
 }
 
 static u64 pf_query_max_lmem(struct xe_gt *gt)
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 0104afbc941c..439725fc4fe6 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -44,6 +44,7 @@
 #include "xe_ring_ops_types.h"
 #include "xe_sched_job.h"
 #include "xe_trace.h"
+#include "xe_uc_fw.h"
 #include "xe_vm.h"
 
 static struct xe_guc *
@@ -1413,7 +1414,17 @@ static void __guc_exec_queue_process_msg_cleanup(struct xe_sched_msg *msg)
 	xe_gt_assert(guc_to_gt(guc), !(q->flags & EXEC_QUEUE_FLAG_PERMANENT));
 	trace_xe_exec_queue_cleanup_entity(q);
 
-	if (exec_queue_registered(q))
+	/*
+	 * Expected state transitions for cleanup:
+	 * - If the exec queue is registered and GuC firmware is running, we must first
+	 *   disable scheduling and deregister the queue to ensure proper teardown and
+	 *   resource release in the GuC, then destroy the exec queue on driver side.
+	 * - If the GuC is already stopped (e.g., during driver unload or GPU reset),
+	 *   we cannot expect a response for the deregister request. In this case,
+	 *   it is safe to directly destroy the exec queue on driver side, as the GuC
+	 *   will not process further requests and all resources must be cleaned up locally.
+	 */
+	if (exec_queue_registered(q) && xe_uc_fw_is_running(&guc->fw))
 		disable_scheduling_deregister(guc, q);
 	else
 		__guc_exec_queue_destroy(guc, q);
diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index 84f412fd3c5d..13e287e03709 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -34,6 +34,7 @@
 #include "xe_sync.h"
 #include "xe_trace_bo.h"
 #include "xe_vm.h"
+#include "xe_vram.h"
 
 /**
  * struct xe_migrate - migrate context.
@@ -130,34 +131,36 @@ static u64 xe_migrate_vram_ofs(struct xe_device *xe, u64 addr, bool is_comp_pte)
 	u64 identity_offset = IDENTITY_OFFSET;
 
 	if (GRAPHICS_VER(xe) >= 20 && is_comp_pte)
-		identity_offset += DIV_ROUND_UP_ULL(xe->mem.vram.actual_physical_size, SZ_1G);
+		identity_offset += DIV_ROUND_UP_ULL(xe_vram_region_actual_physical_size
+							(xe->mem.vram), SZ_1G);
 
-	addr -= xe->mem.vram.dpa_base;
+	addr -= xe_vram_region_dpa_base(xe->mem.vram);
 	return addr + (identity_offset << xe_pt_shift(2));
 }
 
 static void xe_migrate_program_identity(struct xe_device *xe, struct xe_vm *vm, struct xe_bo *bo,
 					u64 map_ofs, u64 vram_offset, u16 pat_index, u64 pt_2m_ofs)
 {
+	struct xe_vram_region *vram = xe->mem.vram;
+	resource_size_t dpa_base = xe_vram_region_dpa_base(vram);
 	u64 pos, ofs, flags;
 	u64 entry;
 	/* XXX: Unclear if this should be usable_size? */
-	u64 vram_limit =  xe->mem.vram.actual_physical_size +
-		xe->mem.vram.dpa_base;
+	u64 vram_limit = xe_vram_region_actual_physical_size(vram) + dpa_base;
 	u32 level = 2;
 
 	ofs = map_ofs + XE_PAGE_SIZE * level + vram_offset * 8;
 	flags = vm->pt_ops->pte_encode_addr(xe, 0, pat_index, level,
 					    true, 0);
 
-	xe_assert(xe, IS_ALIGNED(xe->mem.vram.usable_size, SZ_2M));
+	xe_assert(xe, IS_ALIGNED(xe_vram_region_usable_size(vram), SZ_2M));
 
 	/*
 	 * Use 1GB pages when possible, last chunk always use 2M
 	 * pages as mixing reserved memory (stolen, WOCPM) with a single
 	 * mapping is not allowed on certain platforms.
 	 */
-	for (pos = xe->mem.vram.dpa_base; pos < vram_limit;
+	for (pos = dpa_base; pos < vram_limit;
 	     pos += SZ_1G, ofs += 8) {
 		if (pos + SZ_1G >= vram_limit) {
 			entry = vm->pt_ops->pde_encode_bo(bo, pt_2m_ofs,
@@ -307,11 +310,11 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
 	/* Identity map the entire vram at 256GiB offset */
 	if (IS_DGFX(xe)) {
 		u64 pt30_ofs = xe_bo_size(bo) - 2 * XE_PAGE_SIZE;
+		resource_size_t actual_phy_size = xe_vram_region_actual_physical_size(xe->mem.vram);
 
 		xe_migrate_program_identity(xe, vm, bo, map_ofs, IDENTITY_OFFSET,
 					    pat_index, pt30_ofs);
-		xe_assert(xe, xe->mem.vram.actual_physical_size <=
-					(MAX_NUM_PTE - IDENTITY_OFFSET) * SZ_1G);
+		xe_assert(xe, actual_phy_size <= (MAX_NUM_PTE - IDENTITY_OFFSET) * SZ_1G);
 
 		/*
 		 * Identity map the entire vram for compressed pat_index for xe2+
@@ -320,11 +323,11 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
 		if (GRAPHICS_VER(xe) >= 20 && xe_device_has_flat_ccs(xe)) {
 			u16 comp_pat_index = xe->pat.idx[XE_CACHE_NONE_COMPRESSION];
 			u64 vram_offset = IDENTITY_OFFSET +
-				DIV_ROUND_UP_ULL(xe->mem.vram.actual_physical_size, SZ_1G);
+				DIV_ROUND_UP_ULL(actual_phy_size, SZ_1G);
 			u64 pt31_ofs = xe_bo_size(bo) - XE_PAGE_SIZE;
 
-			xe_assert(xe, xe->mem.vram.actual_physical_size <= (MAX_NUM_PTE -
-						IDENTITY_OFFSET - IDENTITY_OFFSET / 2) * SZ_1G);
+			xe_assert(xe, actual_phy_size <= (MAX_NUM_PTE - IDENTITY_OFFSET -
+							  IDENTITY_OFFSET / 2) * SZ_1G);
 			xe_migrate_program_identity(xe, vm, bo, map_ofs, vram_offset,
 						    comp_pat_index, pt31_ofs);
 		}
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 3c40ef426f0c..6c2637fc8f1a 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -687,6 +687,8 @@ static int xe_info_init(struct xe_device *xe,
 	 * All of these together determine the overall GT count.
 	 */
 	for_each_tile(tile, xe, id) {
+		int err;
+
 		gt = tile->primary_gt;
 		gt->info.type = XE_GT_TYPE_MAIN;
 		gt->info.id = tile->id * xe->info.max_gt_per_tile;
@@ -694,6 +696,10 @@ static int xe_info_init(struct xe_device *xe,
 		gt->info.engine_mask = graphics_desc->hw_engine_mask;
 		xe->info.gt_count++;
 
+		err = xe_tile_alloc_vram(tile);
+		if (err)
+			return err;
+
 		if (MEDIA_VER(xe) < 13 && media_desc)
 			gt->info.engine_mask |= media_desc->hw_engine_mask;
 
@@ -799,6 +805,8 @@ static int xe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		return err;
 
+	xe_vram_resize_bar(xe);
+
 	err = xe_device_probe_early(xe);
 	/*
 	 * In Boot Survivability mode, no drm card is exposed and driver
diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index 83fe77ce62f7..f2a3d4ced068 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -27,6 +27,7 @@
 #include "xe_oa.h"
 #include "xe_pxp.h"
 #include "xe_ttm_vram_mgr.h"
+#include "xe_vram_types.h"
 #include "xe_wa.h"
 
 static const u16 xe_to_user_engine_class[] = {
@@ -334,7 +335,7 @@ static int query_config(struct xe_device *xe, struct drm_xe_device_query *query)
 	config->num_params = num_params;
 	config->info[DRM_XE_QUERY_CONFIG_REV_AND_DEVICE_ID] =
 		xe->info.devid | (xe->info.revid << 16);
-	if (xe_device_get_root_tile(xe)->mem.vram.usable_size)
+	if (xe->mem.vram)
 		config->info[DRM_XE_QUERY_CONFIG_FLAGS] |=
 			DRM_XE_QUERY_CONFIG_FLAG_HAS_VRAM;
 	if (xe->info.has_usm && IS_ENABLED(CONFIG_DRM_XE_GPUSVM))
@@ -407,7 +408,7 @@ static int query_gt_list(struct xe_device *xe, struct drm_xe_device_query *query
 			gt_list->gt_list[iter].near_mem_regions = 0x1;
 		else
 			gt_list->gt_list[iter].near_mem_regions =
-				BIT(gt_to_tile(gt)->id) << 1;
+				BIT(gt_to_tile(gt)->mem.vram->id) << 1;
 		gt_list->gt_list[iter].far_mem_regions = xe->info.mem_region_mask ^
 			gt_list->gt_list[iter].near_mem_regions;
 
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index a7ff5975873f..10c8a1bcb86e 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -17,6 +17,7 @@
 #include "xe_ttm_vram_mgr.h"
 #include "xe_vm.h"
 #include "xe_vm_types.h"
+#include "xe_vram_types.h"
 
 static bool xe_svm_range_in_vram(struct xe_svm_range *range)
 {
@@ -306,21 +307,15 @@ static struct xe_vram_region *page_to_vr(struct page *page)
 	return container_of(page_pgmap(page), struct xe_vram_region, pagemap);
 }
 
-static struct xe_tile *vr_to_tile(struct xe_vram_region *vr)
-{
-	return container_of(vr, struct xe_tile, mem.vram);
-}
-
 static u64 xe_vram_region_page_to_dpa(struct xe_vram_region *vr,
 				      struct page *page)
 {
 	u64 dpa;
-	struct xe_tile *tile = vr_to_tile(vr);
 	u64 pfn = page_to_pfn(page);
 	u64 offset;
 
-	xe_tile_assert(tile, is_device_private_page(page));
-	xe_tile_assert(tile, (pfn << PAGE_SHIFT) >= vr->hpa_base);
+	xe_assert(vr->xe, is_device_private_page(page));
+	xe_assert(vr->xe, (pfn << PAGE_SHIFT) >= vr->hpa_base);
 
 	offset = (pfn << PAGE_SHIFT) - vr->hpa_base;
 	dpa = vr->dpa_base + offset;
@@ -337,7 +332,7 @@ static int xe_svm_copy(struct page **pages, dma_addr_t *dma_addr,
 		       unsigned long npages, const enum xe_svm_copy_dir dir)
 {
 	struct xe_vram_region *vr = NULL;
-	struct xe_tile *tile;
+	struct xe_device *xe;
 	struct dma_fence *fence = NULL;
 	unsigned long i;
 #define XE_VRAM_ADDR_INVALID	~0x0ull
@@ -370,7 +365,7 @@ static int xe_svm_copy(struct page **pages, dma_addr_t *dma_addr,
 
 		if (!vr && spage) {
 			vr = page_to_vr(spage);
-			tile = vr_to_tile(vr);
+			xe = vr->xe;
 		}
 		XE_WARN_ON(spage && page_to_vr(spage) != vr);
 
@@ -402,18 +397,18 @@ static int xe_svm_copy(struct page **pages, dma_addr_t *dma_addr,
 
 			if (vram_addr != XE_VRAM_ADDR_INVALID) {
 				if (sram) {
-					vm_dbg(&tile->xe->drm,
+					vm_dbg(&xe->drm,
 					       "COPY TO SRAM - 0x%016llx -> 0x%016llx, NPAGES=%ld",
 					       vram_addr, (u64)dma_addr[pos], i - pos + incr);
-					__fence = xe_migrate_from_vram(tile->migrate,
+					__fence = xe_migrate_from_vram(vr->migrate,
 								       i - pos + incr,
 								       vram_addr,
 								       dma_addr + pos);
 				} else {
-					vm_dbg(&tile->xe->drm,
+					vm_dbg(&xe->drm,
 					       "COPY TO VRAM - 0x%016llx -> 0x%016llx, NPAGES=%ld",
 					       (u64)dma_addr[pos], vram_addr, i - pos + incr);
-					__fence = xe_migrate_to_vram(tile->migrate,
+					__fence = xe_migrate_to_vram(vr->migrate,
 								     i - pos + incr,
 								     dma_addr + pos,
 								     vram_addr);
@@ -438,17 +433,17 @@ static int xe_svm_copy(struct page **pages, dma_addr_t *dma_addr,
 			/* Extra mismatched device page, copy it */
 			if (!match && last && vram_addr != XE_VRAM_ADDR_INVALID) {
 				if (sram) {
-					vm_dbg(&tile->xe->drm,
+					vm_dbg(&xe->drm,
 					       "COPY TO SRAM - 0x%016llx -> 0x%016llx, NPAGES=%d",
 					       vram_addr, (u64)dma_addr[pos], 1);
-					__fence = xe_migrate_from_vram(tile->migrate, 1,
+					__fence = xe_migrate_from_vram(vr->migrate, 1,
 								       vram_addr,
 								       dma_addr + pos);
 				} else {
-					vm_dbg(&tile->xe->drm,
+					vm_dbg(&xe->drm,
 					       "COPY TO VRAM - 0x%016llx -> 0x%016llx, NPAGES=%d",
 					       (u64)dma_addr[pos], vram_addr, 1);
-					__fence = xe_migrate_to_vram(tile->migrate, 1,
+					__fence = xe_migrate_to_vram(vr->migrate, 1,
 								     dma_addr + pos,
 								     vram_addr);
 				}
@@ -506,9 +501,9 @@ static u64 block_offset_to_pfn(struct xe_vram_region *vr, u64 offset)
 	return PHYS_PFN(offset + vr->hpa_base);
 }
 
-static struct drm_buddy *tile_to_buddy(struct xe_tile *tile)
+static struct drm_buddy *vram_to_buddy(struct xe_vram_region *vram)
 {
-	return &tile->mem.vram.ttm.mm;
+	return &vram->ttm.mm;
 }
 
 static int xe_svm_populate_devmem_pfn(struct drm_pagemap_devmem *devmem_allocation,
@@ -522,8 +517,7 @@ static int xe_svm_populate_devmem_pfn(struct drm_pagemap_devmem *devmem_allocati
 
 	list_for_each_entry(block, blocks, link) {
 		struct xe_vram_region *vr = block->private;
-		struct xe_tile *tile = vr_to_tile(vr);
-		struct drm_buddy *buddy = tile_to_buddy(tile);
+		struct drm_buddy *buddy = vram_to_buddy(vr);
 		u64 block_pfn = block_offset_to_pfn(vr, drm_buddy_block_offset(block));
 		int i;
 
@@ -683,20 +677,14 @@ u64 xe_svm_find_vma_start(struct xe_vm *vm, u64 start, u64 end, struct xe_vma *v
 }
 
 #if IS_ENABLED(CONFIG_DRM_XE_PAGEMAP)
-static struct xe_vram_region *tile_to_vr(struct xe_tile *tile)
-{
-	return &tile->mem.vram;
-}
-
 static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
 				      unsigned long start, unsigned long end,
 				      struct mm_struct *mm,
 				      unsigned long timeslice_ms)
 {
-	struct xe_tile *tile = container_of(dpagemap, typeof(*tile), mem.vram.dpagemap);
-	struct xe_device *xe = tile_to_xe(tile);
+	struct xe_vram_region *vr = container_of(dpagemap, typeof(*vr), dpagemap);
+	struct xe_device *xe = vr->xe;
 	struct device *dev = xe->drm.dev;
-	struct xe_vram_region *vr = tile_to_vr(tile);
 	struct drm_buddy_block *block;
 	struct list_head *blocks;
 	struct xe_bo *bo;
@@ -709,9 +697,9 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
 	xe_pm_runtime_get(xe);
 
  retry:
-	bo = xe_bo_create_locked(tile_to_xe(tile), NULL, NULL, end - start,
+	bo = xe_bo_create_locked(vr->xe, NULL, NULL, end - start,
 				 ttm_bo_type_device,
-				 XE_BO_FLAG_VRAM_IF_DGFX(tile) |
+				 (IS_DGFX(xe) ? XE_BO_FLAG_VRAM(vr) : XE_BO_FLAG_SYSTEM) |
 				 XE_BO_FLAG_CPU_ADDR_MIRROR);
 	if (IS_ERR(bo)) {
 		err = PTR_ERR(bo);
@@ -721,9 +709,7 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
 	}
 
 	drm_pagemap_devmem_init(&bo->devmem_allocation, dev, mm,
-				&dpagemap_devmem_ops,
-				&tile->mem.vram.dpagemap,
-				end - start);
+				&dpagemap_devmem_ops, dpagemap, end - start);
 
 	blocks = &to_xe_ttm_vram_mgr_resource(bo->ttm.resource)->blocks;
 	list_for_each_entry(block, blocks, link)
@@ -999,6 +985,11 @@ int xe_svm_range_get_pages(struct xe_vm *vm, struct xe_svm_range *range,
 
 #if IS_ENABLED(CONFIG_DRM_XE_PAGEMAP)
 
+static struct drm_pagemap *tile_local_pagemap(struct xe_tile *tile)
+{
+	return &tile->mem.vram->dpagemap;
+}
+
 /**
  * xe_svm_alloc_vram()- Allocate device memory pages for range,
  * migrating existing data.
@@ -1016,7 +1007,7 @@ int xe_svm_alloc_vram(struct xe_tile *tile, struct xe_svm_range *range,
 	xe_assert(tile_to_xe(tile), range->base.flags.migrate_devmem);
 	range_debug(range, "ALLOCATE VRAM");
 
-	dpagemap = xe_tile_local_pagemap(tile);
+	dpagemap = tile_local_pagemap(tile);
 	return drm_pagemap_populate_mm(dpagemap, xe_svm_range_start(range),
 				       xe_svm_range_end(range),
 				       range->base.gpusvm->mm,
diff --git a/drivers/gpu/drm/xe/xe_tile.c b/drivers/gpu/drm/xe/xe_tile.c
index 86e9811e60ba..e34edff0eaa1 100644
--- a/drivers/gpu/drm/xe/xe_tile.c
+++ b/drivers/gpu/drm/xe/xe_tile.c
@@ -7,6 +7,7 @@
 
 #include <drm/drm_managed.h>
 
+#include "xe_bo.h"
 #include "xe_device.h"
 #include "xe_ggtt.h"
 #include "xe_gt.h"
@@ -19,6 +20,8 @@
 #include "xe_tile_sysfs.h"
 #include "xe_ttm_vram_mgr.h"
 #include "xe_wa.h"
+#include "xe_vram.h"
+#include "xe_vram_types.h"
 
 /**
  * DOC: Multi-tile Design
@@ -95,6 +98,31 @@ static int xe_tile_alloc(struct xe_tile *tile)
 	return 0;
 }
 
+/**
+ * xe_tile_alloc_vram - Perform per-tile VRAM structs allocation
+ * @tile: Tile to perform allocations for
+ *
+ * Allocates VRAM per-tile data structures using DRM-managed allocations.
+ * Does not touch the hardware.
+ *
+ * Returns -ENOMEM if allocations fail, otherwise 0.
+ */
+int xe_tile_alloc_vram(struct xe_tile *tile)
+{
+	struct xe_device *xe = tile_to_xe(tile);
+	struct xe_vram_region *vram;
+
+	if (!IS_DGFX(xe))
+		return 0;
+
+	vram = xe_vram_region_alloc(xe, tile->id, XE_PL_VRAM0 + tile->id);
+	if (!vram)
+		return -ENOMEM;
+	tile->mem.vram = vram;
+
+	return 0;
+}
+
 /**
  * xe_tile_init_early - Initialize the tile and primary GT
  * @tile: Tile to initialize
@@ -127,21 +155,6 @@ int xe_tile_init_early(struct xe_tile *tile, struct xe_device *xe, u8 id)
 }
 ALLOW_ERROR_INJECTION(xe_tile_init_early, ERRNO); /* See xe_pci_probe() */
 
-static int tile_ttm_mgr_init(struct xe_tile *tile)
-{
-	struct xe_device *xe = tile_to_xe(tile);
-	int err;
-
-	if (tile->mem.vram.usable_size) {
-		err = xe_ttm_vram_mgr_init(tile, &tile->mem.vram.ttm);
-		if (err)
-			return err;
-		xe->info.mem_region_mask |= BIT(tile->id) << 1;
-	}
-
-	return 0;
-}
-
 /**
  * xe_tile_init_noalloc - Init tile up to the point where allocations can happen.
  * @tile: The tile to initialize.
@@ -159,16 +172,19 @@ static int tile_ttm_mgr_init(struct xe_tile *tile)
 int xe_tile_init_noalloc(struct xe_tile *tile)
 {
 	struct xe_device *xe = tile_to_xe(tile);
-	int err;
-
-	err = tile_ttm_mgr_init(tile);
-	if (err)
-		return err;
 
 	xe_wa_apply_tile_workarounds(tile);
 
 	if (xe->info.has_usm && IS_DGFX(xe))
-		xe_devm_add(tile, &tile->mem.vram);
+		xe_devm_add(tile, tile->mem.vram);
+
+	if (IS_DGFX(xe) && !ttm_resource_manager_used(&tile->mem.vram->ttm.manager)) {
+		int err = xe_ttm_vram_mgr_init(xe, tile->mem.vram);
+
+		if (err)
+			return err;
+		xe->info.mem_region_mask |= BIT(tile->mem.vram->id) << 1;
+	}
 
 	return xe_tile_sysfs_init(tile);
 }
diff --git a/drivers/gpu/drm/xe/xe_tile.h b/drivers/gpu/drm/xe/xe_tile.h
index cc33e8733983..dceb6297aa01 100644
--- a/drivers/gpu/drm/xe/xe_tile.h
+++ b/drivers/gpu/drm/xe/xe_tile.h
@@ -14,19 +14,9 @@ int xe_tile_init_early(struct xe_tile *tile, struct xe_device *xe, u8 id);
 int xe_tile_init_noalloc(struct xe_tile *tile);
 int xe_tile_init(struct xe_tile *tile);
 
-void xe_tile_migrate_wait(struct xe_tile *tile);
+int xe_tile_alloc_vram(struct xe_tile *tile);
 
-#if IS_ENABLED(CONFIG_DRM_XE_PAGEMAP)
-static inline struct drm_pagemap *xe_tile_local_pagemap(struct xe_tile *tile)
-{
-	return &tile->mem.vram.dpagemap;
-}
-#else
-static inline struct drm_pagemap *xe_tile_local_pagemap(struct xe_tile *tile)
-{
-	return NULL;
-}
-#endif
+void xe_tile_migrate_wait(struct xe_tile *tile);
 
 static inline bool xe_tile_is_root(struct xe_tile *tile)
 {
diff --git a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
index d9c9d2547aad..9a9733447230 100644
--- a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
@@ -25,6 +25,7 @@
 #include "xe_ttm_stolen_mgr.h"
 #include "xe_ttm_vram_mgr.h"
 #include "xe_wa.h"
+#include "xe_vram.h"
 
 struct xe_ttm_stolen_mgr {
 	struct xe_ttm_vram_mgr base;
@@ -82,15 +83,16 @@ static u32 get_wopcm_size(struct xe_device *xe)
 
 static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
 {
-	struct xe_tile *tile = xe_device_get_root_tile(xe);
+	struct xe_vram_region *tile_vram = xe_device_get_root_tile(xe)->mem.vram;
+	resource_size_t tile_io_start = xe_vram_region_io_start(tile_vram);
 	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
 	u64 stolen_size, wopcm_size;
 	u64 tile_offset;
 	u64 tile_size;
 
-	tile_offset = tile->mem.vram.io_start - xe->mem.vram.io_start;
-	tile_size = tile->mem.vram.actual_physical_size;
+	tile_offset = tile_io_start - xe_vram_region_io_start(xe->mem.vram);
+	tile_size = xe_vram_region_actual_physical_size(tile_vram);
 
 	/* Use DSM base address instead for stolen memory */
 	mgr->stolen_base = (xe_mmio_read64_2x32(mmio, DSMBASE) & BDSM_MASK) - tile_offset;
@@ -107,7 +109,7 @@ static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
 
 	/* Verify usage fits in the actual resource available */
 	if (mgr->stolen_base + stolen_size <= pci_resource_len(pdev, LMEM_BAR))
-		mgr->io_base = tile->mem.vram.io_start + mgr->stolen_base;
+		mgr->io_base = tile_io_start + mgr->stolen_base;
 
 	/*
 	 * There may be few KB of platform dependent reserved memory at the end
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
index 9e375a40aee9..9175b4a2214b 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -15,6 +15,7 @@
 #include "xe_gt.h"
 #include "xe_res_cursor.h"
 #include "xe_ttm_vram_mgr.h"
+#include "xe_vram_types.h"
 
 static inline struct drm_buddy_block *
 xe_ttm_vram_mgr_first_block(struct list_head *list)
@@ -337,13 +338,20 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
 	return drmm_add_action_or_reset(&xe->drm, ttm_vram_mgr_fini, mgr);
 }
 
-int xe_ttm_vram_mgr_init(struct xe_tile *tile, struct xe_ttm_vram_mgr *mgr)
+/**
+ * xe_ttm_vram_mgr_init - initialize TTM VRAM region
+ * @xe: pointer to Xe device
+ * @vram: pointer to xe_vram_region that contains the memory region attributes
+ *
+ * Initialize the Xe TTM for given @vram region using the given parameters.
+ *
+ * Returns 0 for success, negative error code otherwise.
+ */
+int xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_vram_region *vram)
 {
-	struct xe_device *xe = tile_to_xe(tile);
-	struct xe_vram_region *vram = &tile->mem.vram;
-
-	return __xe_ttm_vram_mgr_init(xe, mgr, XE_PL_VRAM0 + tile->id,
-				      vram->usable_size, vram->io_size,
+	return __xe_ttm_vram_mgr_init(xe, &vram->ttm, vram->placement,
+				      xe_vram_region_usable_size(vram),
+				      xe_vram_region_io_size(vram),
 				      PAGE_SIZE);
 }
 
@@ -392,7 +400,7 @@ int xe_ttm_vram_mgr_alloc_sgt(struct xe_device *xe,
 	 */
 	xe_res_first(res, offset, length, &cursor);
 	for_each_sgtable_sg((*sgt), sg, i) {
-		phys_addr_t phys = cursor.start + tile->mem.vram.io_start;
+		phys_addr_t phys = cursor.start + xe_vram_region_io_start(tile->mem.vram);
 		size_t size = min_t(u64, cursor.size, SZ_2G);
 		dma_addr_t addr;
 
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
index cc76050e376d..87b7fae5edba 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
@@ -11,11 +11,12 @@
 enum dma_data_direction;
 struct xe_device;
 struct xe_tile;
+struct xe_vram_region;
 
 int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
 			   u32 mem_type, u64 size, u64 io_size,
 			   u64 default_page_size);
-int xe_ttm_vram_mgr_init(struct xe_tile *tile, struct xe_ttm_vram_mgr *mgr);
+int xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_vram_region *vram);
 int xe_ttm_vram_mgr_alloc_sgt(struct xe_device *xe,
 			      struct ttm_resource *res,
 			      u64 offset, u64 length,
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 5146999d27fa..bf44cd5bf49c 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2894,7 +2894,7 @@ static void vm_bind_ioctl_ops_unwind(struct xe_vm *vm,
 }
 
 static int vma_lock_and_validate(struct drm_exec *exec, struct xe_vma *vma,
-				 bool validate)
+				 bool res_evict, bool validate)
 {
 	struct xe_bo *bo = xe_vma_bo(vma);
 	struct xe_vm *vm = xe_vma_vm(vma);
@@ -2905,7 +2905,8 @@ static int vma_lock_and_validate(struct drm_exec *exec, struct xe_vma *vma,
 			err = drm_exec_lock_obj(exec, &bo->ttm.base);
 		if (!err && validate)
 			err = xe_bo_validate(bo, vm,
-					     !xe_vm_in_preempt_fence_mode(vm));
+					     !xe_vm_in_preempt_fence_mode(vm) &&
+					     res_evict);
 	}
 
 	return err;
@@ -2978,14 +2979,23 @@ static int prefetch_ranges(struct xe_vm *vm, struct xe_vma_op *op)
 }
 
 static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
-			    struct xe_vma_op *op)
+			    struct xe_vma_ops *vops, struct xe_vma_op *op)
 {
 	int err = 0;
+	bool res_evict;
+
+	/*
+	 * We only allow evicting a BO within the VM if it is not part of an
+	 * array of binds, as an array of binds can evict another BO within the
+	 * bind.
+	 */
+	res_evict = !(vops->flags & XE_VMA_OPS_ARRAY_OF_BINDS);
 
 	switch (op->base.op) {
 	case DRM_GPUVA_OP_MAP:
 		if (!op->map.invalidate_on_bind)
 			err = vma_lock_and_validate(exec, op->map.vma,
+						    res_evict,
 						    !xe_vm_in_fault_mode(vm) ||
 						    op->map.immediate);
 		break;
@@ -2996,11 +3006,13 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 
 		err = vma_lock_and_validate(exec,
 					    gpuva_to_vma(op->base.remap.unmap->va),
-					    false);
+					    res_evict, false);
 		if (!err && op->remap.prev)
-			err = vma_lock_and_validate(exec, op->remap.prev, true);
+			err = vma_lock_and_validate(exec, op->remap.prev,
+						    res_evict, true);
 		if (!err && op->remap.next)
-			err = vma_lock_and_validate(exec, op->remap.next, true);
+			err = vma_lock_and_validate(exec, op->remap.next,
+						    res_evict, true);
 		break;
 	case DRM_GPUVA_OP_UNMAP:
 		err = check_ufence(gpuva_to_vma(op->base.unmap.va));
@@ -3009,7 +3021,7 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 
 		err = vma_lock_and_validate(exec,
 					    gpuva_to_vma(op->base.unmap.va),
-					    false);
+					    res_evict, false);
 		break;
 	case DRM_GPUVA_OP_PREFETCH:
 	{
@@ -3025,7 +3037,7 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 
 		err = vma_lock_and_validate(exec,
 					    gpuva_to_vma(op->base.prefetch.va),
-					    false);
+					    res_evict, false);
 		if (!err && !xe_vma_has_no_bo(vma))
 			err = xe_bo_migrate(xe_vma_bo(vma),
 					    region_to_mem_type[region]);
@@ -3069,7 +3081,7 @@ static int vm_bind_ioctl_ops_lock_and_prep(struct drm_exec *exec,
 		return err;
 
 	list_for_each_entry(op, &vops->list, link) {
-		err = op_lock_and_prep(exec, vm, op);
+		err = op_lock_and_prep(exec, vm, vops, op);
 		if (err)
 			return err;
 	}
@@ -3698,6 +3710,8 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	}
 
 	xe_vma_ops_init(&vops, vm, q, syncs, num_syncs);
+	if (args->num_binds > 1)
+		vops.flags |= XE_VMA_OPS_ARRAY_OF_BINDS;
 	for (i = 0; i < args->num_binds; ++i) {
 		u64 range = bind_ops[i].range;
 		u64 addr = bind_ops[i].addr;
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 6058cf739388..f6616d595999 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -467,6 +467,8 @@ struct xe_vma_ops {
 	struct xe_vm_pgtable_update_ops pt_update_ops[XE_MAX_TILES_PER_DEVICE];
 	/** @flag: signify the properties within xe_vma_ops*/
 #define XE_VMA_OPS_FLAG_HAS_SVM_PREFETCH BIT(0)
+#define XE_VMA_OPS_FLAG_MADVISE          BIT(1)
+#define XE_VMA_OPS_ARRAY_OF_BINDS	 BIT(2)
 	u32 flags;
 #ifdef TEST_VM_OPS_ERROR
 	/** @inject_error: inject error to test error handling */
diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index e421a74fb87c..652df7a5f4f6 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -3,6 +3,7 @@
  * Copyright © 2021-2024 Intel Corporation
  */
 
+#include <kunit/visibility.h>
 #include <linux/pci.h>
 
 #include <drm/drm_managed.h>
@@ -19,19 +20,41 @@
 #include "xe_mmio.h"
 #include "xe_module.h"
 #include "xe_sriov.h"
+#include "xe_ttm_vram_mgr.h"
 #include "xe_vram.h"
+#include "xe_vram_types.h"
 
 #define BAR_SIZE_SHIFT 20
 
-static void
-_resize_bar(struct xe_device *xe, int resno, resource_size_t size)
+/*
+ * Release all the BARs that could influence/block LMEMBAR resizing, i.e.
+ * assigned IORESOURCE_MEM_64 BARs
+ */
+static void release_bars(struct pci_dev *pdev)
+{
+	struct resource *res;
+	int i;
+
+	pci_dev_for_each_resource(pdev, res, i) {
+		/* Resource already un-assigned, do not reset it */
+		if (!res->parent)
+			continue;
+
+		/* No need to release unrelated BARs */
+		if (!(res->flags & IORESOURCE_MEM_64))
+			continue;
+
+		pci_release_resource(pdev, i);
+	}
+}
+
+static void resize_bar(struct xe_device *xe, int resno, resource_size_t size)
 {
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
 	int bar_size = pci_rebar_bytes_to_size(size);
 	int ret;
 
-	if (pci_resource_len(pdev, resno))
-		pci_release_resource(pdev, resno);
+	release_bars(pdev);
 
 	ret = pci_resize_resource(pdev, resno, bar_size);
 	if (ret) {
@@ -47,7 +70,7 @@ _resize_bar(struct xe_device *xe, int resno, resource_size_t size)
  * if force_vram_bar_size is set, attempt to set to the requested size
  * else set to maximum possible size
  */
-static void resize_vram_bar(struct xe_device *xe)
+void xe_vram_resize_bar(struct xe_device *xe)
 {
 	int force_vram_bar_size = xe_modparam.force_vram_bar_size;
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
@@ -116,7 +139,7 @@ static void resize_vram_bar(struct xe_device *xe)
 	pci_read_config_dword(pdev, PCI_COMMAND, &pci_cmd);
 	pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd & ~PCI_COMMAND_MEMORY);
 
-	_resize_bar(xe, LMEM_BAR, rebar_size);
+	resize_bar(xe, LMEM_BAR, rebar_size);
 
 	pci_assign_unassigned_bus_resources(pdev->bus);
 	pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd);
@@ -136,7 +159,7 @@ static bool resource_is_valid(struct pci_dev *pdev, int bar)
 	return true;
 }
 
-static int determine_lmem_bar_size(struct xe_device *xe)
+static int determine_lmem_bar_size(struct xe_device *xe, struct xe_vram_region *lmem_bar)
 {
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
 
@@ -145,18 +168,16 @@ static int determine_lmem_bar_size(struct xe_device *xe)
 		return -ENXIO;
 	}
 
-	resize_vram_bar(xe);
-
-	xe->mem.vram.io_start = pci_resource_start(pdev, LMEM_BAR);
-	xe->mem.vram.io_size = pci_resource_len(pdev, LMEM_BAR);
-	if (!xe->mem.vram.io_size)
+	lmem_bar->io_start = pci_resource_start(pdev, LMEM_BAR);
+	lmem_bar->io_size = pci_resource_len(pdev, LMEM_BAR);
+	if (!lmem_bar->io_size)
 		return -EIO;
 
 	/* XXX: Need to change when xe link code is ready */
-	xe->mem.vram.dpa_base = 0;
+	lmem_bar->dpa_base = 0;
 
 	/* set up a map to the total memory area. */
-	xe->mem.vram.mapping = ioremap_wc(xe->mem.vram.io_start, xe->mem.vram.io_size);
+	lmem_bar->mapping = devm_ioremap_wc(&pdev->dev, lmem_bar->io_start, lmem_bar->io_size);
 
 	return 0;
 }
@@ -278,13 +299,71 @@ static void vram_fini(void *arg)
 	struct xe_tile *tile;
 	int id;
 
-	if (xe->mem.vram.mapping)
-		iounmap(xe->mem.vram.mapping);
-
-	xe->mem.vram.mapping = NULL;
+	xe->mem.vram->mapping = NULL;
 
 	for_each_tile(tile, xe, id)
-		tile->mem.vram.mapping = NULL;
+		tile->mem.vram->mapping = NULL;
+}
+
+struct xe_vram_region *xe_vram_region_alloc(struct xe_device *xe, u8 id, u32 placement)
+{
+	struct xe_vram_region *vram;
+	struct drm_device *drm = &xe->drm;
+
+	xe_assert(xe, id < xe->info.tile_count);
+
+	vram = drmm_kzalloc(drm, sizeof(*vram), GFP_KERNEL);
+	if (!vram)
+		return NULL;
+
+	vram->xe = xe;
+	vram->id = id;
+	vram->placement = placement;
+#if defined(CONFIG_DRM_XE_PAGEMAP)
+	vram->migrate = xe->tiles[id].migrate;
+#endif
+	return vram;
+}
+
+static void print_vram_region_info(struct xe_device *xe, struct xe_vram_region *vram)
+{
+	struct drm_device *drm = &xe->drm;
+
+	if (vram->io_size < vram->usable_size)
+		drm_info(drm, "Small BAR device\n");
+
+	drm_info(drm,
+		 "VRAM[%u]: Actual physical size %pa, usable size exclude stolen %pa, CPU accessible size %pa\n",
+		 vram->id, &vram->actual_physical_size, &vram->usable_size, &vram->io_size);
+	drm_info(drm, "VRAM[%u]: DPA range: [%pa-%llx], io range: [%pa-%llx]\n",
+		 vram->id, &vram->dpa_base, vram->dpa_base + (u64)vram->actual_physical_size,
+		 &vram->io_start, vram->io_start + (u64)vram->io_size);
+}
+
+static int vram_region_init(struct xe_device *xe, struct xe_vram_region *vram,
+			    struct xe_vram_region *lmem_bar, u64 offset, u64 usable_size,
+			    u64 region_size, resource_size_t remain_io_size)
+{
+	/* Check if VRAM region is already initialized */
+	if (vram->mapping)
+		return 0;
+
+	vram->actual_physical_size = region_size;
+	vram->io_start = lmem_bar->io_start + offset;
+	vram->io_size = min_t(u64, usable_size, remain_io_size);
+
+	if (!vram->io_size) {
+		drm_err(&xe->drm, "Tile without any CPU visible VRAM. Aborting.\n");
+		return -ENODEV;
+	}
+
+	vram->dpa_base = lmem_bar->dpa_base + offset;
+	vram->mapping = lmem_bar->mapping + offset;
+	vram->usable_size = usable_size;
+
+	print_vram_region_info(xe, vram);
+
+	return 0;
 }
 
 /**
@@ -298,78 +377,108 @@ static void vram_fini(void *arg)
 int xe_vram_probe(struct xe_device *xe)
 {
 	struct xe_tile *tile;
-	resource_size_t io_size;
+	struct xe_vram_region lmem_bar;
+	resource_size_t remain_io_size;
 	u64 available_size = 0;
 	u64 total_size = 0;
-	u64 tile_offset;
-	u64 tile_size;
-	u64 vram_size;
 	int err;
 	u8 id;
 
 	if (!IS_DGFX(xe))
 		return 0;
 
-	/* Get the size of the root tile's vram for later accessibility comparison */
-	tile = xe_device_get_root_tile(xe);
-	err = tile_vram_size(tile, &vram_size, &tile_size, &tile_offset);
+	err = determine_lmem_bar_size(xe, &lmem_bar);
 	if (err)
 		return err;
+	drm_info(&xe->drm, "VISIBLE VRAM: %pa, %pa\n", &lmem_bar.io_start, &lmem_bar.io_size);
 
-	err = determine_lmem_bar_size(xe);
-	if (err)
-		return err;
+	remain_io_size = lmem_bar.io_size;
 
-	drm_info(&xe->drm, "VISIBLE VRAM: %pa, %pa\n", &xe->mem.vram.io_start,
-		 &xe->mem.vram.io_size);
-
-	io_size = xe->mem.vram.io_size;
-
-	/* tile specific ranges */
 	for_each_tile(tile, xe, id) {
-		err = tile_vram_size(tile, &vram_size, &tile_size, &tile_offset);
+		u64 region_size;
+		u64 usable_size;
+		u64 tile_offset;
+
+		err = tile_vram_size(tile, &usable_size, &region_size, &tile_offset);
 		if (err)
 			return err;
 
-		tile->mem.vram.actual_physical_size = tile_size;
-		tile->mem.vram.io_start = xe->mem.vram.io_start + tile_offset;
-		tile->mem.vram.io_size = min_t(u64, vram_size, io_size);
+		total_size += region_size;
+		available_size += usable_size;
 
-		if (!tile->mem.vram.io_size) {
-			drm_err(&xe->drm, "Tile without any CPU visible VRAM. Aborting.\n");
-			return -ENODEV;
+		err = vram_region_init(xe, tile->mem.vram, &lmem_bar, tile_offset, usable_size,
+				       region_size, remain_io_size);
+		if (err)
+			return err;
+
+		if (total_size > lmem_bar.io_size) {
+			drm_info(&xe->drm, "VRAM: %pa is larger than resource %pa\n",
+				 &total_size, &lmem_bar.io_size);
 		}
 
-		tile->mem.vram.dpa_base = xe->mem.vram.dpa_base + tile_offset;
-		tile->mem.vram.usable_size = vram_size;
-		tile->mem.vram.mapping = xe->mem.vram.mapping + tile_offset;
+		remain_io_size -= min_t(u64, tile->mem.vram->actual_physical_size, remain_io_size);
+	}
 
-		if (tile->mem.vram.io_size < tile->mem.vram.usable_size)
-			drm_info(&xe->drm, "Small BAR device\n");
-		drm_info(&xe->drm, "VRAM[%u, %u]: Actual physical size %pa, usable size exclude stolen %pa, CPU accessible size %pa\n", id,
-			 tile->id, &tile->mem.vram.actual_physical_size, &tile->mem.vram.usable_size, &tile->mem.vram.io_size);
-		drm_info(&xe->drm, "VRAM[%u, %u]: DPA range: [%pa-%llx], io range: [%pa-%llx]\n", id, tile->id,
-			 &tile->mem.vram.dpa_base, tile->mem.vram.dpa_base + (u64)tile->mem.vram.actual_physical_size,
-			 &tile->mem.vram.io_start, tile->mem.vram.io_start + (u64)tile->mem.vram.io_size);
+	err = vram_region_init(xe, xe->mem.vram, &lmem_bar, 0, available_size, total_size,
+			       lmem_bar.io_size);
+	if (err)
+		return err;
 
-		/* calculate total size using tile size to get the correct HW sizing */
-		total_size += tile_size;
-		available_size += vram_size;
+	return devm_add_action_or_reset(xe->drm.dev, vram_fini, xe);
+}
 
-		if (total_size > xe->mem.vram.io_size) {
-			drm_info(&xe->drm, "VRAM: %pa is larger than resource %pa\n",
-				 &total_size, &xe->mem.vram.io_size);
-		}
+/**
+ * xe_vram_region_io_start - Get the IO start of a VRAM region
+ * @vram: the VRAM region
+ *
+ * Return: the IO start of the VRAM region, or 0 if not valid
+ */
+resource_size_t xe_vram_region_io_start(const struct xe_vram_region *vram)
+{
+	return vram ? vram->io_start : 0;
+}
 
-		io_size -= min_t(u64, tile_size, io_size);
-	}
+/**
+ * xe_vram_region_io_size - Get the IO size of a VRAM region
+ * @vram: the VRAM region
+ *
+ * Return: the IO size of the VRAM region, or 0 if not valid
+ */
+resource_size_t xe_vram_region_io_size(const struct xe_vram_region *vram)
+{
+	return vram ? vram->io_size : 0;
+}
 
-	xe->mem.vram.actual_physical_size = total_size;
+/**
+ * xe_vram_region_dpa_base - Get the DPA base of a VRAM region
+ * @vram: the VRAM region
+ *
+ * Return: the DPA base of the VRAM region, or 0 if not valid
+ */
+resource_size_t xe_vram_region_dpa_base(const struct xe_vram_region *vram)
+{
+	return vram ? vram->dpa_base : 0;
+}
 
-	drm_info(&xe->drm, "Total VRAM: %pa, %pa\n", &xe->mem.vram.io_start,
-		 &xe->mem.vram.actual_physical_size);
-	drm_info(&xe->drm, "Available VRAM: %pa, %pa\n", &xe->mem.vram.io_start,
-		 &available_size);
+/**
+ * xe_vram_region_usable_size - Get the usable size of a VRAM region
+ * @vram: the VRAM region
+ *
+ * Return: the usable size of the VRAM region, or 0 if not valid
+ */
+resource_size_t xe_vram_region_usable_size(const struct xe_vram_region *vram)
+{
+	return vram ? vram->usable_size : 0;
+}
 
-	return devm_add_action_or_reset(xe->drm.dev, vram_fini, xe);
+/**
+ * xe_vram_region_actual_physical_size - Get the actual physical size of a VRAM region
+ * @vram: the VRAM region
+ *
+ * Return: the actual physical size of the VRAM region, or 0 if not valid
+ */
+resource_size_t xe_vram_region_actual_physical_size(const struct xe_vram_region *vram)
+{
+	return vram ? vram->actual_physical_size : 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(xe_vram_region_actual_physical_size);
diff --git a/drivers/gpu/drm/xe/xe_vram.h b/drivers/gpu/drm/xe/xe_vram.h
index e31cc04ec0db..13505cfb184d 100644
--- a/drivers/gpu/drm/xe/xe_vram.h
+++ b/drivers/gpu/drm/xe/xe_vram.h
@@ -6,8 +6,20 @@
 #ifndef _XE_VRAM_H_
 #define _XE_VRAM_H_
 
+#include <linux/types.h>
+
 struct xe_device;
+struct xe_vram_region;
 
+void xe_vram_resize_bar(struct xe_device *xe);
 int xe_vram_probe(struct xe_device *xe);
 
+struct xe_vram_region *xe_vram_region_alloc(struct xe_device *xe, u8 id, u32 placement);
+
+resource_size_t xe_vram_region_io_start(const struct xe_vram_region *vram);
+resource_size_t xe_vram_region_io_size(const struct xe_vram_region *vram);
+resource_size_t xe_vram_region_dpa_base(const struct xe_vram_region *vram);
+resource_size_t xe_vram_region_usable_size(const struct xe_vram_region *vram);
+resource_size_t xe_vram_region_actual_physical_size(const struct xe_vram_region *vram);
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_vram_types.h b/drivers/gpu/drm/xe/xe_vram_types.h
new file mode 100644
index 000000000000..83772dcbf1af
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_vram_types.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2025 Intel Corporation
+ */
+
+#ifndef _XE_VRAM_TYPES_H_
+#define _XE_VRAM_TYPES_H_
+
+#if IS_ENABLED(CONFIG_DRM_XE_PAGEMAP)
+#include <drm/drm_pagemap.h>
+#endif
+
+#include "xe_ttm_vram_mgr_types.h"
+
+struct xe_device;
+struct xe_migrate;
+
+/**
+ * struct xe_vram_region - memory region structure
+ * This is used to describe a memory region in xe
+ * device, such as HBM memory or CXL extension memory.
+ */
+struct xe_vram_region {
+	/** @xe: Back pointer to xe device */
+	struct xe_device *xe;
+	/**
+	 * @id: VRAM region instance id
+	 *
+	 * The value should be unique for VRAM region.
+	 */
+	u8 id;
+	/** @io_start: IO start address of this VRAM instance */
+	resource_size_t io_start;
+	/**
+	 * @io_size: IO size of this VRAM instance
+	 *
+	 * This represents how much of this VRAM we can access
+	 * via the CPU through the VRAM BAR. This can be smaller
+	 * than @usable_size, in which case only part of VRAM is CPU
+	 * accessible (typically the first 256M). This
+	 * configuration is known as small-bar.
+	 */
+	resource_size_t io_size;
+	/** @dpa_base: This memory regions's DPA (device physical address) base */
+	resource_size_t dpa_base;
+	/**
+	 * @usable_size: usable size of VRAM
+	 *
+	 * Usable size of VRAM excluding reserved portions
+	 * (e.g stolen mem)
+	 */
+	resource_size_t usable_size;
+	/**
+	 * @actual_physical_size: Actual VRAM size
+	 *
+	 * Actual VRAM size including reserved portions
+	 * (e.g stolen mem)
+	 */
+	resource_size_t actual_physical_size;
+	/** @mapping: pointer to VRAM mappable space */
+	void __iomem *mapping;
+	/** @ttm: VRAM TTM manager */
+	struct xe_ttm_vram_mgr ttm;
+	/** @placement: TTM placement dedicated for this region */
+	u32 placement;
+#if IS_ENABLED(CONFIG_DRM_XE_PAGEMAP)
+	/** @migrate: Back pointer to migrate */
+	struct xe_migrate *migrate;
+	/** @pagemap: Used to remap device memory as ZONE_DEVICE */
+	struct dev_pagemap pagemap;
+	/**
+	 * @dpagemap: The struct drm_pagemap of the ZONE_DEVICE memory
+	 * pages of this tile.
+	 */
+	struct drm_pagemap dpagemap;
+	/**
+	 * @hpa_base: base host physical address
+	 *
+	 * This is generated when remap device memory as ZONE_DEVICE
+	 */
+	resource_size_t hpa_base;
+#endif
+};
+
+#endif
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index f45f856a127f..2c743e35c1d3 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -622,7 +622,10 @@ static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
 		return;
 	}
 
-	if (value == 0 || value < dev->battery_min || value > dev->battery_max)
+	if ((usage & HID_USAGE_PAGE) == HID_UP_DIGITIZER && value == 0)
+		return;
+
+	if (value < dev->battery_min || value > dev->battery_max)
 		return;
 
 	capacity = hidinput_scale_battery_capacity(dev, value);
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 22c6314a8843..a9ff84f0bd9b 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -92,9 +92,8 @@ enum report_mode {
 	TOUCHPAD_REPORT_ALL = TOUCHPAD_REPORT_BUTTONS | TOUCHPAD_REPORT_CONTACTS,
 };
 
-#define MT_IO_FLAGS_RUNNING		0
-#define MT_IO_FLAGS_ACTIVE_SLOTS	1
-#define MT_IO_FLAGS_PENDING_SLOTS	2
+#define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot tracking */
+#define MT_IO_FLAGS_RUNNING		32
 
 static const bool mtrue = true;		/* default for true */
 static const bool mfalse;		/* default for false */
@@ -169,7 +168,11 @@ struct mt_device {
 	struct mt_class mtclass;	/* our mt device class */
 	struct timer_list release_timer;	/* to release sticky fingers */
 	struct hid_device *hdev;	/* hid_device we're attached to */
-	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_*) */
+	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING)
+					 * first 8 bits are reserved for keeping the slot
+					 * states, this is fine because we only support up
+					 * to 250 slots (MT_MAX_MAXCONTACT)
+					 */
 	__u8 inputmode_value;	/* InputMode HID feature value */
 	__u8 maxcontacts;
 	bool is_buttonpad;	/* is this device a button pad? */
@@ -977,6 +980,7 @@ static void mt_release_pending_palms(struct mt_device *td,
 
 	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
 		clear_bit(slotnum, app->pending_palm_slots);
+		clear_bit(slotnum, &td->mt_io_flags);
 
 		input_mt_slot(input, slotnum);
 		input_mt_report_slot_inactive(input);
@@ -1008,12 +1012,6 @@ static void mt_sync_frame(struct mt_device *td, struct mt_application *app,
 
 	app->num_received = 0;
 	app->left_button_state = 0;
-
-	if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
-		set_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
-	else
-		clear_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
-	clear_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
 }
 
 static int mt_compute_timestamp(struct mt_application *app, __s32 value)
@@ -1188,7 +1186,9 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
 
-		set_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
+		set_bit(slotnum, &td->mt_io_flags);
+	} else {
+		clear_bit(slotnum, &td->mt_io_flags);
 	}
 
 	return 0;
@@ -1323,7 +1323,7 @@ static void mt_touch_report(struct hid_device *hid,
 	 * defect.
 	 */
 	if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
-		if (test_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags))
+		if (td->mt_io_flags & MT_IO_SLOTS_MASK)
 			mod_timer(&td->release_timer,
 				  jiffies + msecs_to_jiffies(100));
 		else
@@ -1711,6 +1711,7 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	case HID_CP_CONSUMER_CONTROL:
 	case HID_GD_WIRELESS_RADIO_CTLS:
 	case HID_GD_SYSTEM_MULTIAXIS:
+	case HID_DG_PEN:
 		/* already handled by hid core */
 		break;
 	case HID_DG_TOUCHSCREEN:
@@ -1782,6 +1783,7 @@ static void mt_release_contacts(struct hid_device *hid)
 			for (i = 0; i < mt->num_slots; i++) {
 				input_mt_slot(input_dev, i);
 				input_mt_report_slot_inactive(input_dev);
+				clear_bit(i, &td->mt_io_flags);
 			}
 			input_mt_sync_frame(input_dev);
 			input_sync(input_dev);
@@ -1804,7 +1806,7 @@ static void mt_expired_timeout(struct timer_list *t)
 	 */
 	if (test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
 		return;
-	if (test_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags))
+	if (td->mt_io_flags & MT_IO_SLOTS_MASK)
 		mt_release_contacts(hdev);
 	clear_bit_unlock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
 }
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
index e6ba2ddcc9cb..16f780bc879b 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
@@ -280,8 +280,7 @@ int reset_tic(struct quickspi_device *qsdev)
 
 	qsdev->reset_ack = false;
 
-	/* First interrupt uses level trigger to avoid missing interrupt */
-	thc_int_trigger_type_select(qsdev->thc_hw, false);
+	thc_int_trigger_type_select(qsdev->thc_hw, true);
 
 	ret = acpi_tic_reset(qsdev);
 	if (ret)
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c
index 22e49d3a1287..2012dbd6a292 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c
@@ -43,7 +43,6 @@ struct mxc_isi_m2m_ctx_queue_data {
 	struct v4l2_pix_format_mplane format;
 	const struct mxc_isi_format_info *info;
 	u32 sequence;
-	bool streaming;
 };
 
 struct mxc_isi_m2m_ctx {
@@ -236,6 +235,66 @@ static void mxc_isi_m2m_vb2_buffer_queue(struct vb2_buffer *vb2)
 	v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
 }
 
+static int mxc_isi_m2m_vb2_prepare_streaming(struct vb2_queue *q)
+{
+	struct mxc_isi_m2m_ctx *ctx = vb2_get_drv_priv(q);
+	const struct v4l2_pix_format_mplane *out_pix = &ctx->queues.out.format;
+	const struct v4l2_pix_format_mplane *cap_pix = &ctx->queues.cap.format;
+	const struct mxc_isi_format_info *cap_info = ctx->queues.cap.info;
+	const struct mxc_isi_format_info *out_info = ctx->queues.out.info;
+	struct mxc_isi_m2m *m2m = ctx->m2m;
+	bool bypass;
+	int ret;
+
+	guard(mutex)(&m2m->lock);
+
+	if (m2m->usage_count == INT_MAX)
+		return -EOVERFLOW;
+
+	bypass = cap_pix->width == out_pix->width &&
+		 cap_pix->height == out_pix->height &&
+		 cap_info->encoding == out_info->encoding;
+
+	/*
+	 * Acquire the pipe and initialize the channel with the first user of
+	 * the M2M device.
+	 */
+	if (m2m->usage_count == 0) {
+		ret = mxc_isi_channel_acquire(m2m->pipe,
+					      &mxc_isi_m2m_frame_write_done,
+					      bypass);
+		if (ret)
+			return ret;
+
+		mxc_isi_channel_get(m2m->pipe);
+	}
+
+	m2m->usage_count++;
+
+	/*
+	 * Allocate resources for the channel, counting how many users require
+	 * buffer chaining.
+	 */
+	if (!ctx->chained && out_pix->width > MXC_ISI_MAX_WIDTH_UNCHAINED) {
+		ret = mxc_isi_channel_chain(m2m->pipe, bypass);
+		if (ret)
+			goto err_deinit;
+
+		m2m->chained_count++;
+		ctx->chained = true;
+	}
+
+	return 0;
+
+err_deinit:
+	if (--m2m->usage_count == 0) {
+		mxc_isi_channel_put(m2m->pipe);
+		mxc_isi_channel_release(m2m->pipe);
+	}
+
+	return ret;
+}
+
 static int mxc_isi_m2m_vb2_start_streaming(struct vb2_queue *q,
 					   unsigned int count)
 {
@@ -265,13 +324,44 @@ static void mxc_isi_m2m_vb2_stop_streaming(struct vb2_queue *q)
 	}
 }
 
+static void mxc_isi_m2m_vb2_unprepare_streaming(struct vb2_queue *q)
+{
+	struct mxc_isi_m2m_ctx *ctx = vb2_get_drv_priv(q);
+	struct mxc_isi_m2m *m2m = ctx->m2m;
+
+	guard(mutex)(&m2m->lock);
+
+	/*
+	 * If the last context is this one, reset it to make sure the device
+	 * will be reconfigured when streaming is restarted.
+	 */
+	if (m2m->last_ctx == ctx)
+		m2m->last_ctx = NULL;
+
+	/* Free the channel resources if this is the last chained context. */
+	if (ctx->chained && --m2m->chained_count == 0)
+		mxc_isi_channel_unchain(m2m->pipe);
+	ctx->chained = false;
+
+	/* Turn off the light with the last user. */
+	if (--m2m->usage_count == 0) {
+		mxc_isi_channel_disable(m2m->pipe);
+		mxc_isi_channel_put(m2m->pipe);
+		mxc_isi_channel_release(m2m->pipe);
+	}
+
+	WARN_ON(m2m->usage_count < 0);
+}
+
 static const struct vb2_ops mxc_isi_m2m_vb2_qops = {
 	.queue_setup		= mxc_isi_m2m_vb2_queue_setup,
 	.buf_init		= mxc_isi_m2m_vb2_buffer_init,
 	.buf_prepare		= mxc_isi_m2m_vb2_buffer_prepare,
 	.buf_queue		= mxc_isi_m2m_vb2_buffer_queue,
+	.prepare_streaming	= mxc_isi_m2m_vb2_prepare_streaming,
 	.start_streaming	= mxc_isi_m2m_vb2_start_streaming,
 	.stop_streaming		= mxc_isi_m2m_vb2_stop_streaming,
+	.unprepare_streaming	= mxc_isi_m2m_vb2_unprepare_streaming,
 };
 
 static int mxc_isi_m2m_queue_init(void *priv, struct vb2_queue *src_vq,
@@ -481,136 +571,6 @@ static int mxc_isi_m2m_s_fmt_vid(struct file *file, void *fh,
 	return 0;
 }
 
-static int mxc_isi_m2m_streamon(struct file *file, void *fh,
-				enum v4l2_buf_type type)
-{
-	struct mxc_isi_m2m_ctx *ctx = to_isi_m2m_ctx(fh);
-	struct mxc_isi_m2m_ctx_queue_data *q = mxc_isi_m2m_ctx_qdata(ctx, type);
-	const struct v4l2_pix_format_mplane *out_pix = &ctx->queues.out.format;
-	const struct v4l2_pix_format_mplane *cap_pix = &ctx->queues.cap.format;
-	const struct mxc_isi_format_info *cap_info = ctx->queues.cap.info;
-	const struct mxc_isi_format_info *out_info = ctx->queues.out.info;
-	struct mxc_isi_m2m *m2m = ctx->m2m;
-	bool bypass;
-	int ret;
-
-	if (q->streaming)
-		return 0;
-
-	mutex_lock(&m2m->lock);
-
-	if (m2m->usage_count == INT_MAX) {
-		ret = -EOVERFLOW;
-		goto unlock;
-	}
-
-	bypass = cap_pix->width == out_pix->width &&
-		 cap_pix->height == out_pix->height &&
-		 cap_info->encoding == out_info->encoding;
-
-	/*
-	 * Acquire the pipe and initialize the channel with the first user of
-	 * the M2M device.
-	 */
-	if (m2m->usage_count == 0) {
-		ret = mxc_isi_channel_acquire(m2m->pipe,
-					      &mxc_isi_m2m_frame_write_done,
-					      bypass);
-		if (ret)
-			goto unlock;
-
-		mxc_isi_channel_get(m2m->pipe);
-	}
-
-	m2m->usage_count++;
-
-	/*
-	 * Allocate resources for the channel, counting how many users require
-	 * buffer chaining.
-	 */
-	if (!ctx->chained && out_pix->width > MXC_ISI_MAX_WIDTH_UNCHAINED) {
-		ret = mxc_isi_channel_chain(m2m->pipe, bypass);
-		if (ret)
-			goto deinit;
-
-		m2m->chained_count++;
-		ctx->chained = true;
-	}
-
-	/*
-	 * Drop the lock to start the stream, as the .device_run() operation
-	 * needs to acquire it.
-	 */
-	mutex_unlock(&m2m->lock);
-	ret = v4l2_m2m_ioctl_streamon(file, fh, type);
-	if (ret) {
-		/* Reacquire the lock for the cleanup path. */
-		mutex_lock(&m2m->lock);
-		goto unchain;
-	}
-
-	q->streaming = true;
-
-	return 0;
-
-unchain:
-	if (ctx->chained && --m2m->chained_count == 0)
-		mxc_isi_channel_unchain(m2m->pipe);
-	ctx->chained = false;
-
-deinit:
-	if (--m2m->usage_count == 0) {
-		mxc_isi_channel_put(m2m->pipe);
-		mxc_isi_channel_release(m2m->pipe);
-	}
-
-unlock:
-	mutex_unlock(&m2m->lock);
-	return ret;
-}
-
-static int mxc_isi_m2m_streamoff(struct file *file, void *fh,
-				 enum v4l2_buf_type type)
-{
-	struct mxc_isi_m2m_ctx *ctx = to_isi_m2m_ctx(fh);
-	struct mxc_isi_m2m_ctx_queue_data *q = mxc_isi_m2m_ctx_qdata(ctx, type);
-	struct mxc_isi_m2m *m2m = ctx->m2m;
-
-	v4l2_m2m_ioctl_streamoff(file, fh, type);
-
-	if (!q->streaming)
-		return 0;
-
-	mutex_lock(&m2m->lock);
-
-	/*
-	 * If the last context is this one, reset it to make sure the device
-	 * will be reconfigured when streaming is restarted.
-	 */
-	if (m2m->last_ctx == ctx)
-		m2m->last_ctx = NULL;
-
-	/* Free the channel resources if this is the last chained context. */
-	if (ctx->chained && --m2m->chained_count == 0)
-		mxc_isi_channel_unchain(m2m->pipe);
-	ctx->chained = false;
-
-	/* Turn off the light with the last user. */
-	if (--m2m->usage_count == 0) {
-		mxc_isi_channel_disable(m2m->pipe);
-		mxc_isi_channel_put(m2m->pipe);
-		mxc_isi_channel_release(m2m->pipe);
-	}
-
-	WARN_ON(m2m->usage_count < 0);
-
-	mutex_unlock(&m2m->lock);
-
-	q->streaming = false;
-
-	return 0;
-}
-
 static const struct v4l2_ioctl_ops mxc_isi_m2m_ioctl_ops = {
 	.vidioc_querycap		= mxc_isi_m2m_querycap,
 
@@ -631,8 +591,8 @@ static const struct v4l2_ioctl_ops mxc_isi_m2m_ioctl_ops = {
 	.vidioc_prepare_buf		= v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs		= v4l2_m2m_ioctl_create_bufs,
 
-	.vidioc_streamon		= mxc_isi_m2m_streamon,
-	.vidioc_streamoff		= mxc_isi_m2m_streamoff,
+	.vidioc_streamon		= v4l2_m2m_ioctl_streamon,
+	.vidioc_streamoff		= v4l2_m2m_ioctl_streamoff,
 
 	.vidioc_subscribe_event		= v4l2_ctrl_subscribe_event,
 	.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index fe74dbd2c966..c82ea6043d40 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -812,6 +812,9 @@ static int m_can_handle_state_change(struct net_device *dev,
 	u32 timestamp = 0;
 
 	switch (new_state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		cdev->can.state = CAN_STATE_ERROR_ACTIVE;
+		break;
 	case CAN_STATE_ERROR_WARNING:
 		/* error warning state */
 		cdev->can.can_stats.error_warning++;
@@ -841,6 +844,12 @@ static int m_can_handle_state_change(struct net_device *dev,
 	__m_can_get_berr_counter(dev, &bec);
 
 	switch (new_state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
+		cf->data[1] = CAN_ERR_CRTL_ACTIVE;
+		cf->data[6] = bec.txerr;
+		cf->data[7] = bec.rxerr;
+		break;
 	case CAN_STATE_ERROR_WARNING:
 		/* error warning state */
 		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
@@ -877,30 +886,33 @@ static int m_can_handle_state_change(struct net_device *dev,
 	return 1;
 }
 
-static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
+static enum can_state
+m_can_state_get_by_psr(struct m_can_classdev *cdev)
 {
-	struct m_can_classdev *cdev = netdev_priv(dev);
-	int work_done = 0;
+	u32 reg_psr;
 
-	if (psr & PSR_EW && cdev->can.state != CAN_STATE_ERROR_WARNING) {
-		netdev_dbg(dev, "entered error warning state\n");
-		work_done += m_can_handle_state_change(dev,
-						       CAN_STATE_ERROR_WARNING);
-	}
+	reg_psr = m_can_read(cdev, M_CAN_PSR);
 
-	if (psr & PSR_EP && cdev->can.state != CAN_STATE_ERROR_PASSIVE) {
-		netdev_dbg(dev, "entered error passive state\n");
-		work_done += m_can_handle_state_change(dev,
-						       CAN_STATE_ERROR_PASSIVE);
-	}
+	if (reg_psr & PSR_BO)
+		return CAN_STATE_BUS_OFF;
+	if (reg_psr & PSR_EP)
+		return CAN_STATE_ERROR_PASSIVE;
+	if (reg_psr & PSR_EW)
+		return CAN_STATE_ERROR_WARNING;
 
-	if (psr & PSR_BO && cdev->can.state != CAN_STATE_BUS_OFF) {
-		netdev_dbg(dev, "entered error bus off state\n");
-		work_done += m_can_handle_state_change(dev,
-						       CAN_STATE_BUS_OFF);
-	}
+	return CAN_STATE_ERROR_ACTIVE;
+}
 
-	return work_done;
+static int m_can_handle_state_errors(struct net_device *dev)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+	enum can_state new_state;
+
+	new_state = m_can_state_get_by_psr(cdev);
+	if (new_state == cdev->can.state)
+		return 0;
+
+	return m_can_handle_state_change(dev, new_state);
 }
 
 static void m_can_handle_other_err(struct net_device *dev, u32 irqstatus)
@@ -1031,8 +1043,7 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
 	}
 
 	if (irqstatus & IR_ERR_STATE)
-		work_done += m_can_handle_state_errors(dev,
-						       m_can_read(cdev, M_CAN_PSR));
+		work_done += m_can_handle_state_errors(dev);
 
 	if (irqstatus & IR_ERR_BUS_30X)
 		work_done += m_can_handle_bus_errors(dev, irqstatus,
@@ -1606,7 +1617,7 @@ static int m_can_start(struct net_device *dev)
 	netdev_queue_set_dql_min_limit(netdev_get_tx_queue(cdev->net, 0),
 				       cdev->tx_max_coalesced_frames);
 
-	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
+	cdev->can.state = m_can_state_get_by_psr(cdev);
 
 	m_can_enable_all_interrupts(cdev);
 
@@ -2494,12 +2505,11 @@ int m_can_class_suspend(struct device *dev)
 		}
 
 		m_can_clk_stop(cdev);
+		cdev->can.state = CAN_STATE_SLEEPING;
 	}
 
 	pinctrl_pm_select_sleep_state(dev);
 
-	cdev->can.state = CAN_STATE_SLEEPING;
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(m_can_class_suspend);
@@ -2512,8 +2522,6 @@ int m_can_class_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
-
 	if (netif_running(ndev)) {
 		ret = m_can_clk_start(cdev);
 		if (ret)
@@ -2531,6 +2539,8 @@ int m_can_class_resume(struct device *dev)
 			if (cdev->ops->init)
 				ret = cdev->ops->init(cdev);
 
+			cdev->can.state = m_can_state_get_by_psr(cdev);
+
 			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
 		} else {
 			ret  = m_can_start(ndev);
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index b832566efda0..057eaa7b8b4b 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -180,7 +180,7 @@ static void m_can_plat_remove(struct platform_device *pdev)
 	struct m_can_classdev *mcan_class = &priv->cdev;
 
 	m_can_class_unregister(mcan_class);
-
+	pm_runtime_disable(mcan_class->dev);
 	m_can_class_free_dev(mcan_class->net);
 }
 
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index c9482d6e947b..69b8d6da651b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -289,11 +289,6 @@ struct gs_host_frame {
 #define GS_MAX_RX_URBS 30
 #define GS_NAPI_WEIGHT 32
 
-/* Maximum number of interfaces the driver supports per device.
- * Current hardware only supports 3 interfaces. The future may vary.
- */
-#define GS_MAX_INTF 3
-
 struct gs_tx_context {
 	struct gs_can *dev;
 	unsigned int echo_id;
@@ -324,7 +319,6 @@ struct gs_can {
 
 /* usb interface struct */
 struct gs_usb {
-	struct gs_can *canch[GS_MAX_INTF];
 	struct usb_anchor rx_submitted;
 	struct usb_device *udev;
 
@@ -336,9 +330,11 @@ struct gs_usb {
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+	u8 channel_cnt;
 
 	unsigned int pipe_in;
 	unsigned int pipe_out;
+	struct gs_can *canch[] __counted_by(channel_cnt);
 };
 
 /* 'allocate' a tx context.
@@ -599,7 +595,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	/* device reports out of range channel id */
-	if (hf->channel >= GS_MAX_INTF)
+	if (hf->channel >= parent->channel_cnt)
 		goto device_detach;
 
 	dev = parent->canch[hf->channel];
@@ -699,7 +695,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	/* USB failure take down all interfaces */
 	if (rc == -ENODEV) {
 device_detach:
-		for (rc = 0; rc < GS_MAX_INTF; rc++) {
+		for (rc = 0; rc < parent->channel_cnt; rc++) {
 			if (parent->canch[rc])
 				netif_device_detach(parent->canch[rc]->netdev);
 		}
@@ -1249,6 +1245,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	netdev->flags |= IFF_ECHO; /* we support full roundtrip echo */
 	netdev->dev_id = channel;
+	netdev->dev_port = channel;
 
 	/* dev setup */
 	strcpy(dev->bt_const.name, KBUILD_MODNAME);
@@ -1460,17 +1457,19 @@ static int gs_usb_probe(struct usb_interface *intf,
 	icount = dconf.icount + 1;
 	dev_info(&intf->dev, "Configuring for %u interfaces\n", icount);
 
-	if (icount > GS_MAX_INTF) {
+	if (icount > type_max(parent->channel_cnt)) {
 		dev_err(&intf->dev,
 			"Driver cannot handle more that %u CAN interfaces\n",
-			GS_MAX_INTF);
+			type_max(parent->channel_cnt));
 		return -EINVAL;
 	}
 
-	parent = kzalloc(sizeof(*parent), GFP_KERNEL);
+	parent = kzalloc(struct_size(parent, canch, icount), GFP_KERNEL);
 	if (!parent)
 		return -ENOMEM;
 
+	parent->channel_cnt = icount;
+
 	init_usb_anchor(&parent->rx_submitted);
 
 	usb_set_intfdata(intf, parent);
@@ -1531,7 +1530,7 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 		return;
 	}
 
-	for (i = 0; i < GS_MAX_INTF; i++)
+	for (i = 0; i < parent->channel_cnt; i++)
 		if (parent->canch[i])
 			gs_destroy_candev(parent->canch[i]);
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 6d23c5c049b9..ffb10c758c29 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1872,6 +1872,20 @@ static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
 #endif
 }
 
+static bool airoha_dev_tx_queue_busy(struct airoha_queue *q, u32 nr_frags)
+{
+	u32 tail = q->tail <= q->head ? q->tail + q->ndesc : q->tail;
+	u32 index = q->head + nr_frags;
+
+	/* completion napi can free out-of-order tx descriptors if hw QoS is
+	 * enabled and packets with different priorities are queued to the same
+	 * DMA ring. Take into account possible out-of-order reports checking
+	 * if the tx queue is full using circular buffer head/tail pointers
+	 * instead of the number of queued packets.
+	 */
+	return index >= tail;
+}
+
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *dev)
 {
@@ -1925,7 +1939,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	txq = netdev_get_tx_queue(dev, qid);
 	nr_frags = 1 + skb_shinfo(skb)->nr_frags;
 
-	if (q->queued + nr_frags > q->ndesc) {
+	if (airoha_dev_tx_queue_busy(q, nr_frags)) {
 		/* not enough space in the queue */
 		netif_tx_stop_queue(txq);
 		spin_unlock_bh(&q->lock);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 2e9b95a94f89..2ad672c17eec 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1065,7 +1065,6 @@ static void xgbe_free_rx_data(struct xgbe_prv_data *pdata)
 
 static int xgbe_phy_reset(struct xgbe_prv_data *pdata)
 {
-	pdata->phy_link = -1;
 	pdata->phy_speed = SPEED_UNKNOWN;
 
 	return pdata->phy_if.phy_reset(pdata);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 1a37ec45e650..7675bb98f029 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1555,6 +1555,7 @@ static int xgbe_phy_init(struct xgbe_prv_data *pdata)
 		pdata->phy.duplex = DUPLEX_FULL;
 	}
 
+	pdata->phy_link = 0;
 	pdata->phy.link = 0;
 
 	pdata->phy.pause_autoneg = pdata->pause_autoneg;
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index b4dc93a48718..8b64e4667c21 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -5803,7 +5803,7 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, bool force_reset)
 	u32 current_speed = SPEED_UNKNOWN;
 	u8 current_duplex = DUPLEX_UNKNOWN;
 	bool current_link_up = false;
-	u32 local_adv, remote_adv, sgsr;
+	u32 local_adv = 0, remote_adv = 0, sgsr;
 
 	if ((tg3_asic_rev(tp) == ASIC_REV_5719 ||
 	     tg3_asic_rev(tp) == ASIC_REV_5720) &&
@@ -5944,9 +5944,6 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, bool force_reset)
 		else
 			current_duplex = DUPLEX_HALF;
 
-		local_adv = 0;
-		remote_adv = 0;
-
 		if (bmcr & BMCR_ANENABLE) {
 			u32 common;
 
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 1996d2e4e3e2..7077d705e471 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -508,25 +508,34 @@ static int alloc_list(struct net_device *dev)
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		/* Allocated fixed size of skbuff */
 		struct sk_buff *skb;
+		dma_addr_t addr;
 
 		skb = netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
 		np->rx_skbuff[i] = skb;
-		if (!skb) {
-			free_list(dev);
-			return -ENOMEM;
-		}
+		if (!skb)
+			goto err_free_list;
+
+		addr = dma_map_single(&np->pdev->dev, skb->data,
+				      np->rx_buf_sz, DMA_FROM_DEVICE);
+		if (dma_mapping_error(&np->pdev->dev, addr))
+			goto err_kfree_skb;
 
 		np->rx_ring[i].next_desc = cpu_to_le64(np->rx_ring_dma +
 						((i + 1) % RX_RING_SIZE) *
 						sizeof(struct netdev_desc));
 		/* Rubicon now supports 40 bits of addressing space. */
-		np->rx_ring[i].fraginfo =
-		    cpu_to_le64(dma_map_single(&np->pdev->dev, skb->data,
-					       np->rx_buf_sz, DMA_FROM_DEVICE));
+		np->rx_ring[i].fraginfo = cpu_to_le64(addr);
 		np->rx_ring[i].fraginfo |= cpu_to_le64((u64)np->rx_buf_sz << 48);
 	}
 
 	return 0;
+
+err_kfree_skb:
+	dev_kfree_skb(np->rx_skbuff[i]);
+	np->rx_skbuff[i] = NULL;
+err_free_list:
+	free_list(dev);
+	return -ENOMEM;
 }
 
 static void rio_hw_init(struct net_device *dev)
diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index bceaf9b05cb4..4cc6dcbfd367 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -100,6 +100,8 @@
  */
 #define GVE_DQO_QPL_ONDEMAND_ALLOC_THRESHOLD 96
 
+#define GVE_DQO_RX_HWTSTAMP_VALID 0x1
+
 /* Each slot in the desc ring has a 1:1 mapping to a slot in the data ring */
 struct gve_rx_desc_queue {
 	struct gve_rx_desc *desc_ring; /* the descriptor ring */
diff --git a/drivers/net/ethernet/google/gve/gve_desc_dqo.h b/drivers/net/ethernet/google/gve/gve_desc_dqo.h
index d17da841b5a0..f7786b03c744 100644
--- a/drivers/net/ethernet/google/gve/gve_desc_dqo.h
+++ b/drivers/net/ethernet/google/gve/gve_desc_dqo.h
@@ -236,7 +236,8 @@ struct gve_rx_compl_desc_dqo {
 
 	u8 status_error1;
 
-	__le16 reserved5;
+	u8 reserved5;
+	u8 ts_sub_nsecs_low;
 	__le16 buf_id; /* Buffer ID which was sent on the buffer queue. */
 
 	union {
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 7380c2b7a2d8..02e25be8a50d 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -456,14 +456,20 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
  * Note that this means if the time delta between packet reception and the last
  * clock read is greater than ~2 seconds, this will provide invalid results.
  */
-static void gve_rx_skb_hwtstamp(struct gve_rx_ring *rx, u32 hwts)
+static void gve_rx_skb_hwtstamp(struct gve_rx_ring *rx,
+				const struct gve_rx_compl_desc_dqo *desc)
 {
 	u64 last_read = READ_ONCE(rx->gve->last_sync_nic_counter);
 	struct sk_buff *skb = rx->ctx.skb_head;
-	u32 low = (u32)last_read;
-	s32 diff = hwts - low;
-
-	skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(last_read + diff);
+	u32 ts, low;
+	s32 diff;
+
+	if (desc->ts_sub_nsecs_low & GVE_DQO_RX_HWTSTAMP_VALID) {
+		ts = le32_to_cpu(desc->ts);
+		low = (u32)last_read;
+		diff = ts - low;
+		skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(last_read + diff);
+	}
 }
 
 static void gve_rx_free_skb(struct napi_struct *napi, struct gve_rx_ring *rx)
@@ -919,7 +925,7 @@ static int gve_rx_complete_skb(struct gve_rx_ring *rx, struct napi_struct *napi,
 		gve_rx_skb_csum(rx->ctx.skb_head, desc, ptype);
 
 	if (rx->gve->ts_config.rx_filter == HWTSTAMP_FILTER_ALL)
-		gve_rx_skb_hwtstamp(rx, le32_to_cpu(desc->ts));
+		gve_rx_skb_hwtstamp(rx, desc);
 
 	/* RSC packets must set gso_size otherwise the TCP stack will complain
 	 * that packets are larger than MTU.
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index ee21f2ff0cad..63a41e688733 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -855,6 +855,9 @@ static void idpf_ptp_release_vport_tstamp(struct idpf_vport *vport)
 	head = &vport->tx_tstamp_caps->latches_in_use;
 	list_for_each_entry_safe(ptp_tx_tstamp, tmp, head, list_member) {
 		list_del(&ptp_tx_tstamp->list_member);
+		if (ptp_tx_tstamp->skb)
+			consume_skb(ptp_tx_tstamp->skb);
+
 		kfree(ptp_tx_tstamp);
 	}
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index 4f1fb0cefe51..688a6f4e0acc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -517,6 +517,7 @@ idpf_ptp_get_tstamp_value(struct idpf_vport *vport,
 	shhwtstamps.hwtstamp = ns_to_ktime(tstamp);
 	skb_tstamp_tx(ptp_tx_tstamp->skb, &shhwtstamps);
 	consume_skb(ptp_tx_tstamp->skb);
+	ptp_tx_tstamp->skb = NULL;
 
 	list_add(&ptp_tx_tstamp->list_member,
 		 &tx_tstamp_caps->latches_free);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6218bdb7f941..86b9caece104 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -12091,7 +12091,6 @@ static void ixgbe_remove(struct pci_dev *pdev)
 
 	devl_port_unregister(&adapter->devlink_port);
 	devl_unlock(adapter->devlink);
-	devlink_free(adapter->devlink);
 
 	ixgbe_stop_ipsec_offload(adapter);
 	ixgbe_clear_interrupt_scheme(adapter);
@@ -12127,6 +12126,8 @@ static void ixgbe_remove(struct pci_dev *pdev)
 
 	if (disable_dev)
 		pci_disable_device(pdev);
+
+	devlink_free(adapter->devlink);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h b/drivers/net/ethernet/intel/ixgbevf/defines.h
index a9bc96f6399d..e177d1d58696 100644
--- a/drivers/net/ethernet/intel/ixgbevf/defines.h
+++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
@@ -28,6 +28,7 @@
 
 /* Link speed */
 typedef u32 ixgbe_link_speed;
+#define IXGBE_LINK_SPEED_UNKNOWN	0
 #define IXGBE_LINK_SPEED_1GB_FULL	0x0020
 #define IXGBE_LINK_SPEED_10GB_FULL	0x0080
 #define IXGBE_LINK_SPEED_100_FULL	0x0008
diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index 65580b9cb06f..fce35924ff8b 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -273,6 +273,9 @@ static int ixgbevf_ipsec_add_sa(struct net_device *dev,
 	adapter = netdev_priv(dev);
 	ipsec = adapter->ipsec;
 
+	if (!(adapter->pf_features & IXGBEVF_PF_SUP_IPSEC))
+		return -EOPNOTSUPP;
+
 	if (xs->id.proto != IPPROTO_ESP && xs->id.proto != IPPROTO_AH) {
 		NL_SET_ERR_MSG_MOD(extack, "Unsupported protocol for IPsec offload");
 		return -EINVAL;
@@ -405,6 +408,9 @@ static void ixgbevf_ipsec_del_sa(struct net_device *dev,
 	adapter = netdev_priv(dev);
 	ipsec = adapter->ipsec;
 
+	if (!(adapter->pf_features & IXGBEVF_PF_SUP_IPSEC))
+		return;
+
 	if (xs->xso.dir == XFRM_DEV_OFFLOAD_IN) {
 		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_RX_INDEX;
 
@@ -612,6 +618,10 @@ void ixgbevf_init_ipsec_offload(struct ixgbevf_adapter *adapter)
 	size_t size;
 
 	switch (adapter->hw.api_version) {
+	case ixgbe_mbox_api_17:
+		if (!(adapter->pf_features & IXGBEVF_PF_SUP_IPSEC))
+			return;
+		break;
 	case ixgbe_mbox_api_14:
 		break;
 	default:
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 3a379e6a3a2a..039187607e98 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -363,6 +363,13 @@ struct ixgbevf_adapter {
 	struct ixgbe_hw hw;
 	u16 msg_enable;
 
+	u32 pf_features;
+#define IXGBEVF_PF_SUP_IPSEC		BIT(0)
+#define IXGBEVF_PF_SUP_ESX_MBX		BIT(1)
+
+#define IXGBEVF_SUPPORTED_FEATURES	(IXGBEVF_PF_SUP_IPSEC | \
+					IXGBEVF_PF_SUP_ESX_MBX)
+
 	struct ixgbevf_hw_stats stats;
 
 	unsigned long state;
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 535d0f71f521..1ecfbbb95210 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2271,10 +2271,36 @@ static void ixgbevf_init_last_counter_stats(struct ixgbevf_adapter *adapter)
 	adapter->stats.base_vfmprc = adapter->stats.last_vfmprc;
 }
 
+/**
+ * ixgbevf_set_features - Set features supported by PF
+ * @adapter: pointer to the adapter struct
+ *
+ * Negotiate with PF supported features and then set pf_features accordingly.
+ */
+static void ixgbevf_set_features(struct ixgbevf_adapter *adapter)
+{
+	u32 *pf_features = &adapter->pf_features;
+	struct ixgbe_hw *hw = &adapter->hw;
+	int err;
+
+	err = hw->mac.ops.negotiate_features(hw, pf_features);
+	if (err && err != -EOPNOTSUPP)
+		netdev_dbg(adapter->netdev,
+			   "PF feature negotiation failed.\n");
+
+	/* Address also pre API 1.7 cases */
+	if (hw->api_version == ixgbe_mbox_api_14)
+		*pf_features |= IXGBEVF_PF_SUP_IPSEC;
+	else if (hw->api_version == ixgbe_mbox_api_15)
+		*pf_features |= IXGBEVF_PF_SUP_ESX_MBX;
+}
+
 static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	static const int api[] = {
+		ixgbe_mbox_api_17,
+		ixgbe_mbox_api_16,
 		ixgbe_mbox_api_15,
 		ixgbe_mbox_api_14,
 		ixgbe_mbox_api_13,
@@ -2294,7 +2320,9 @@ static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 		idx++;
 	}
 
-	if (hw->api_version >= ixgbe_mbox_api_15) {
+	ixgbevf_set_features(adapter);
+
+	if (adapter->pf_features & IXGBEVF_PF_SUP_ESX_MBX) {
 		hw->mbx.ops.init_params(hw);
 		memcpy(&hw->mbx.ops, &ixgbevf_mbx_ops,
 		       sizeof(struct ixgbe_mbx_operations));
@@ -2651,6 +2679,8 @@ static void ixgbevf_set_num_queues(struct ixgbevf_adapter *adapter)
 		case ixgbe_mbox_api_13:
 		case ixgbe_mbox_api_14:
 		case ixgbe_mbox_api_15:
+		case ixgbe_mbox_api_16:
+		case ixgbe_mbox_api_17:
 			if (adapter->xdp_prog &&
 			    hw->mac.max_tx_queues == rss)
 				rss = rss > 3 ? 2 : 1;
@@ -4645,6 +4675,8 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
+	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		netdev->max_mtu = IXGBE_MAX_JUMBO_FRAME_SIZE -
 				  (ETH_HLEN + ETH_FCS_LEN);
 		break;
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.h b/drivers/net/ethernet/intel/ixgbevf/mbx.h
index 835bbcc5cc8e..a8ed23ee66aa 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.h
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.h
@@ -66,6 +66,8 @@ enum ixgbe_pfvf_api_rev {
 	ixgbe_mbox_api_13,	/* API version 1.3, linux/freebsd VF driver */
 	ixgbe_mbox_api_14,	/* API version 1.4, linux/freebsd VF driver */
 	ixgbe_mbox_api_15,	/* API version 1.5, linux/freebsd VF driver */
+	ixgbe_mbox_api_16,      /* API version 1.6, linux/freebsd VF driver */
+	ixgbe_mbox_api_17,	/* API version 1.7, linux/freebsd VF driver */
 	/* This value should always be last */
 	ixgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
@@ -102,6 +104,12 @@ enum ixgbe_pfvf_api_rev {
 
 #define IXGBE_VF_GET_LINK_STATE 0x10 /* get vf link state */
 
+/* mailbox API, version 1.6 VF requests */
+#define IXGBE_VF_GET_PF_LINK_STATE	0x11 /* request PF to send link info */
+
+/* mailbox API, version 1.7 VF requests */
+#define IXGBE_VF_FEATURES_NEGOTIATE	0x12 /* get features supported by PF*/
+
 /* length of permanent address message returned from PF */
 #define IXGBE_VF_PERMADDR_MSG_LEN	4
 /* word in permanent address message with the current multicast type */
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index dcaef34b88b6..74d320879513 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -313,6 +313,8 @@ int ixgbevf_get_reta_locked(struct ixgbe_hw *hw, u32 *reta, int num_rx_queues)
 	 * is not supported for this device type.
 	 */
 	switch (hw->api_version) {
+	case ixgbe_mbox_api_17:
+	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
@@ -382,6 +384,8 @@ int ixgbevf_get_rss_key_locked(struct ixgbe_hw *hw, u8 *rss_key)
 	 * or if the operation is not supported for this device type.
 	 */
 	switch (hw->api_version) {
+	case ixgbe_mbox_api_17:
+	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
@@ -552,6 +556,8 @@ static s32 ixgbevf_update_xcast_mode(struct ixgbe_hw *hw, int xcast_mode)
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
+	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -624,6 +630,85 @@ static s32 ixgbevf_hv_get_link_state_vf(struct ixgbe_hw *hw, bool *link_state)
 	return -EOPNOTSUPP;
 }
 
+/**
+ * ixgbevf_get_pf_link_state - Get PF's link status
+ * @hw: pointer to the HW structure
+ * @speed: link speed
+ * @link_up: indicate if link is up/down
+ *
+ * Ask PF to provide link_up state and speed of the link.
+ *
+ * Return: IXGBE_ERR_MBX in the case of mailbox error,
+ * -EOPNOTSUPP if the op is not supported or 0 on success.
+ */
+static int ixgbevf_get_pf_link_state(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
+				     bool *link_up)
+{
+	u32 msgbuf[3] = {};
+	int err;
+
+	switch (hw->api_version) {
+	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	msgbuf[0] = IXGBE_VF_GET_PF_LINK_STATE;
+
+	err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
+					 ARRAY_SIZE(msgbuf));
+	if (err || (msgbuf[0] & IXGBE_VT_MSGTYPE_FAILURE)) {
+		err = IXGBE_ERR_MBX;
+		*speed = IXGBE_LINK_SPEED_UNKNOWN;
+		/* No need to set @link_up to false as it will be done by
+		 * ixgbe_check_mac_link_vf().
+		 */
+	} else {
+		*speed = msgbuf[1];
+		*link_up = msgbuf[2];
+	}
+
+	return err;
+}
+
+/**
+ * ixgbevf_negotiate_features_vf - negotiate supported features with PF driver
+ * @hw: pointer to the HW structure
+ * @pf_features: bitmask of features supported by PF
+ *
+ * Return: IXGBE_ERR_MBX in the  case of mailbox error,
+ * -EOPNOTSUPP if the op is not supported or 0 on success.
+ */
+static int ixgbevf_negotiate_features_vf(struct ixgbe_hw *hw, u32 *pf_features)
+{
+	u32 msgbuf[2] = {};
+	int err;
+
+	switch (hw->api_version) {
+	case ixgbe_mbox_api_17:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	msgbuf[0] = IXGBE_VF_FEATURES_NEGOTIATE;
+	msgbuf[1] = IXGBEVF_SUPPORTED_FEATURES;
+
+	err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
+					 ARRAY_SIZE(msgbuf));
+
+	if (err || (msgbuf[0] & IXGBE_VT_MSGTYPE_FAILURE)) {
+		err = IXGBE_ERR_MBX;
+		*pf_features = 0x0;
+	} else {
+		*pf_features = msgbuf[1];
+	}
+
+	return err;
+}
+
 /**
  *  ixgbevf_set_vfta_vf - Set/Unset VLAN filter table address
  *  @hw: pointer to the HW structure
@@ -658,6 +743,58 @@ static s32 ixgbevf_set_vfta_vf(struct ixgbe_hw *hw, u32 vlan, u32 vind,
 	return err;
 }
 
+/**
+ * ixgbe_read_vflinks - Read VFLINKS register
+ * @hw: pointer to the HW structure
+ * @speed: link speed
+ * @link_up: indicate if link is up/down
+ *
+ * Get linkup status and link speed from the VFLINKS register.
+ */
+static void ixgbe_read_vflinks(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
+			       bool *link_up)
+{
+	u32 vflinks = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
+
+	/* if link status is down no point in checking to see if PF is up */
+	if (!(vflinks & IXGBE_LINKS_UP)) {
+		*link_up = false;
+		return;
+	}
+
+	/* for SFP+ modules and DA cables on 82599 it can take up to 500usecs
+	 * before the link status is correct
+	 */
+	if (hw->mac.type == ixgbe_mac_82599_vf) {
+		for (int i = 0; i < 5; i++) {
+			udelay(100);
+			vflinks = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
+
+			if (!(vflinks & IXGBE_LINKS_UP)) {
+				*link_up = false;
+				return;
+			}
+		}
+	}
+
+	/* We reached this point so there's link */
+	*link_up = true;
+
+	switch (vflinks & IXGBE_LINKS_SPEED_82599) {
+	case IXGBE_LINKS_SPEED_10G_82599:
+		*speed = IXGBE_LINK_SPEED_10GB_FULL;
+		break;
+	case IXGBE_LINKS_SPEED_1G_82599:
+		*speed = IXGBE_LINK_SPEED_1GB_FULL;
+		break;
+	case IXGBE_LINKS_SPEED_100_82599:
+		*speed = IXGBE_LINK_SPEED_100_FULL;
+		break;
+	default:
+		*speed = IXGBE_LINK_SPEED_UNKNOWN;
+	}
+}
+
 /**
  * ixgbevf_hv_set_vfta_vf - * Hyper-V variant - just a stub.
  * @hw: unused
@@ -702,10 +839,10 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 				     bool *link_up,
 				     bool autoneg_wait_to_complete)
 {
+	struct ixgbevf_adapter *adapter = hw->back;
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 	struct ixgbe_mac_info *mac = &hw->mac;
 	s32 ret_val = 0;
-	u32 links_reg;
 	u32 in_msg = 0;
 
 	/* If we were hit with a reset drop the link */
@@ -715,43 +852,21 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 	if (!mac->get_link_status)
 		goto out;
 
-	/* if link status is down no point in checking to see if pf is up */
-	links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
-	if (!(links_reg & IXGBE_LINKS_UP))
-		goto out;
-
-	/* for SFP+ modules and DA cables on 82599 it can take up to 500usecs
-	 * before the link status is correct
-	 */
-	if (mac->type == ixgbe_mac_82599_vf) {
-		int i;
-
-		for (i = 0; i < 5; i++) {
-			udelay(100);
-			links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
-
-			if (!(links_reg & IXGBE_LINKS_UP))
-				goto out;
-		}
-	}
-
-	switch (links_reg & IXGBE_LINKS_SPEED_82599) {
-	case IXGBE_LINKS_SPEED_10G_82599:
-		*speed = IXGBE_LINK_SPEED_10GB_FULL;
-		break;
-	case IXGBE_LINKS_SPEED_1G_82599:
-		*speed = IXGBE_LINK_SPEED_1GB_FULL;
-		break;
-	case IXGBE_LINKS_SPEED_100_82599:
-		*speed = IXGBE_LINK_SPEED_100_FULL;
-		break;
+	if (hw->mac.type == ixgbe_mac_e610_vf) {
+		ret_val = ixgbevf_get_pf_link_state(hw, speed, link_up);
+		if (ret_val)
+			goto out;
+	} else {
+		ixgbe_read_vflinks(hw, speed, link_up);
+		if (*link_up == false)
+			goto out;
 	}
 
 	/* if the read failed it could just be a mailbox collision, best wait
 	 * until we are called again and don't report an error
 	 */
 	if (mbx->ops.read(hw, &in_msg, 1)) {
-		if (hw->api_version >= ixgbe_mbox_api_15)
+		if (adapter->pf_features & IXGBEVF_PF_SUP_ESX_MBX)
 			mac->get_link_status = false;
 		goto out;
 	}
@@ -951,6 +1066,8 @@ int ixgbevf_get_queues(struct ixgbe_hw *hw, unsigned int *num_tcs,
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
+	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return 0;
@@ -1005,6 +1122,7 @@ static const struct ixgbe_mac_operations ixgbevf_mac_ops = {
 	.setup_link		= ixgbevf_setup_mac_link_vf,
 	.check_link		= ixgbevf_check_mac_link_vf,
 	.negotiate_api_version	= ixgbevf_negotiate_api_version_vf,
+	.negotiate_features	= ixgbevf_negotiate_features_vf,
 	.set_rar		= ixgbevf_set_rar_vf,
 	.update_mc_addr_list	= ixgbevf_update_mc_addr_list_vf,
 	.update_xcast_mode	= ixgbevf_update_xcast_mode,
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.h b/drivers/net/ethernet/intel/ixgbevf/vf.h
index 2d791bc26ae4..4f19b8900c29 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.h
@@ -26,6 +26,7 @@ struct ixgbe_mac_operations {
 	s32 (*stop_adapter)(struct ixgbe_hw *);
 	s32 (*get_bus_info)(struct ixgbe_hw *);
 	s32 (*negotiate_api_version)(struct ixgbe_hw *hw, int api);
+	int (*negotiate_features)(struct ixgbe_hw *hw, u32 *pf_features);
 
 	/* Link */
 	s32 (*setup_link)(struct ixgbe_hw *, ixgbe_link_speed, bool, bool);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 69324ae09397..31310018c3ca 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1981,6 +1981,7 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	    !is_cgx_mapped_to_nix(pdev->subsystem_device, cgx->cgx_id)) {
 		dev_notice(dev, "CGX %d not mapped to NIX, skipping probe\n",
 			   cgx->cgx_id);
+		err = -ENODEV;
 		goto err_release_regions;
 	}
 
diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 0a80d8f8cff7..16aa7e4138d3 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -670,7 +670,7 @@ mtk_wed_tx_buffer_alloc(struct mtk_wed_device *dev)
 		void *buf;
 		int s;
 
-		page = __dev_alloc_page(GFP_KERNEL);
+		page = __dev_alloc_page(GFP_KERNEL | GFP_DMA32);
 		if (!page)
 			return -ENOMEM;
 
@@ -793,7 +793,7 @@ mtk_wed_hwrro_buffer_alloc(struct mtk_wed_device *dev)
 		struct page *page;
 		int s;
 
-		page = __dev_alloc_page(GFP_KERNEL);
+		page = __dev_alloc_page(GFP_KERNEL | GFP_DMA32);
 		if (!page)
 			return -ENOMEM;
 
@@ -2405,6 +2405,10 @@ mtk_wed_attach(struct mtk_wed_device *dev)
 	dev->version = hw->version;
 	dev->hw->pcie_base = mtk_wed_get_pcie_base(dev);
 
+	ret = dma_set_mask_and_coherent(hw->dev, DMA_BIT_MASK(32));
+	if (ret)
+		goto out;
+
 	if (hw->eth->dma_dev == hw->eth->dev &&
 	    of_dma_is_coherent(hw->eth->dev->of_node))
 		mtk_eth_set_dma_device(hw->eth, hw->dev);
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9c601f271c02..4b0ac73565ea 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4994,8 +4994,9 @@ static int rtl8169_resume(struct device *device)
 	if (!device_may_wakeup(tp_to_dev(tp)))
 		clk_prepare_enable(tp->clk);
 
-	/* Reportedly at least Asus X453MA truncates packets otherwise */
-	if (tp->mac_version == RTL_GIGA_MAC_VER_37)
+	/* Some chip versions may truncate packets without this initialization */
+	if (tp->mac_version == RTL_GIGA_MAC_VER_37 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_46)
 		rtl_init_rxcfg(tp);
 
 	return rtl8169_runtime_resume(device);
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 0178219f0db5..d7938e11f24d 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -528,6 +528,7 @@ static void nsim_enable_napi(struct netdevsim *ns)
 static int nsim_open(struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct netdevsim *peer;
 	int err;
 
 	netdev_assert_locked(dev);
@@ -538,6 +539,12 @@ static int nsim_open(struct net_device *dev)
 
 	nsim_enable_napi(ns);
 
+	peer = rtnl_dereference(ns->peer);
+	if (peer && netif_running(peer->netdev)) {
+		netif_carrier_on(dev);
+		netif_carrier_on(peer->netdev);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index a60e58ef90c4..6884eaccc3e1 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -407,7 +407,7 @@ static int bcm5481x_set_brrmode(struct phy_device *phydev, bool on)
 static int bcm54811_config_init(struct phy_device *phydev)
 {
 	struct bcm54xx_phy_priv *priv = phydev->priv;
-	int err, reg, exp_sync_ethernet;
+	int err, reg, exp_sync_ethernet, aux_rgmii_en;
 
 	/* Enable CLK125 MUX on LED4 if ref clock is enabled. */
 	if (!(phydev->dev_flags & PHY_BRCM_RX_REFCLK_UNUSED)) {
@@ -436,6 +436,24 @@ static int bcm54811_config_init(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
+	/* Enable RGMII if configured */
+	if (phy_interface_is_rgmii(phydev))
+		aux_rgmii_en = MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_EN |
+			       MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN;
+	else
+		aux_rgmii_en = 0;
+
+	/* Also writing Reserved bits 6:5 because the documentation requires
+	 * them to be written to 0b11
+	 */
+	err = bcm54xx_auxctl_write(phydev,
+				   MII_BCM54XX_AUXCTL_SHDWSEL_MISC,
+				   MII_BCM54XX_AUXCTL_MISC_WREN |
+				   aux_rgmii_en |
+				   MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD);
+	if (err < 0)
+		return err;
+
 	return bcm5481x_set_brrmode(phydev, priv->brr_mode);
 }
 
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index dd0d675149ad..64af3b96f028 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -589,26 +589,25 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 			str_enabled_disabled(val_rxdly));
 	}
 
+	if (!priv->has_phycr2)
+		return 0;
+
 	/* Disable PHY-mode EEE so LPI is passed to the MAC */
 	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
 			       RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
 	if (ret)
 		return ret;
 
-	if (priv->has_phycr2) {
-		ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
-				       RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN,
-				       priv->phycr2);
-		if (ret < 0) {
-			dev_err(dev, "clkout configuration failed: %pe\n",
-				ERR_PTR(ret));
-			return ret;
-		}
-
-		return genphy_soft_reset(phydev);
+	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
+			       RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN,
+			       priv->phycr2);
+	if (ret < 0) {
+		dev_err(dev, "clkout configuration failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
 	}
 
-	return 0;
+	return genphy_soft_reset(phydev);
 }
 
 static int rtl821x_suspend(struct phy_device *phydev)
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index d75502ebbc0d..e0c425779e67 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1174,10 +1174,13 @@ static int lan78xx_write_raw_eeprom(struct lan78xx_net *dev, u32 offset,
 	}
 
 write_raw_eeprom_done:
-	if (dev->chipid == ID_REV_CHIP_ID_7800_)
-		return lan78xx_write_reg(dev, HW_CFG, saved);
-
-	return 0;
+	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
+		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
+		/* If USB fails, there is nothing to do */
+		if (rc < 0)
+			return rc;
+	}
+	return ret;
 }
 
 static int lan78xx_read_raw_otp(struct lan78xx_net *dev, u32 offset,
@@ -3241,10 +3244,6 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		}
 	} while (buf & HW_CFG_LRST_);
 
-	ret = lan78xx_init_mac_address(dev);
-	if (ret < 0)
-		return ret;
-
 	/* save DEVID for later usage */
 	ret = lan78xx_read_reg(dev, ID_REV, &buf);
 	if (ret < 0)
@@ -3253,6 +3252,10 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	dev->chipid = (buf & ID_REV_CHIP_ID_MASK_) >> 16;
 	dev->chiprev = buf & ID_REV_CHIP_REV_MASK_;
 
+	ret = lan78xx_init_mac_address(dev);
+	if (ret < 0)
+		return ret;
+
 	/* Respond to the IN token with a NAK */
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
 	if (ret < 0)
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 44cba7acfe7d..a22d4bb2cf3b 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10122,7 +10122,12 @@ static int __init rtl8152_driver_init(void)
 	ret = usb_register_device_driver(&rtl8152_cfgselector_driver, THIS_MODULE);
 	if (ret)
 		return ret;
-	return usb_register(&rtl8152_driver);
+
+	ret = usb_register(&rtl8152_driver);
+	if (ret)
+		usb_deregister_device_driver(&rtl8152_cfgselector_driver);
+
+	return ret;
 }
 
 static void __exit rtl8152_driver_exit(void)
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 511c4154cf74..bf01f2728531 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -702,6 +702,7 @@ void usbnet_resume_rx(struct usbnet *dev)
 	struct sk_buff *skb;
 	int num = 0;
 
+	local_bh_disable();
 	clear_bit(EVENT_RX_PAUSED, &dev->flags);
 
 	while ((skb = skb_dequeue(&dev->rxq_pause)) != NULL) {
@@ -710,6 +711,7 @@ void usbnet_resume_rx(struct usbnet *dev)
 	}
 
 	queue_work(system_bh_wq, &dev->bh_work);
+	local_bh_enable();
 
 	netif_dbg(dev, rx_status, dev->net,
 		  "paused rx queue disabled, %d skbs requeued\n", num);
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 012fcfc79a73..a01178caf15b 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -36,6 +36,7 @@ struct nvme_dhchap_queue_context {
 	u8 status;
 	u8 dhgroup_id;
 	u8 hash_id;
+	u8 sc_c;
 	size_t hash_len;
 	u8 c1[64];
 	u8 c2[64];
@@ -154,6 +155,8 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 	data->auth_protocol[0].dhchap.idlist[34] = NVME_AUTH_DHGROUP_6144;
 	data->auth_protocol[0].dhchap.idlist[35] = NVME_AUTH_DHGROUP_8192;
 
+	chap->sc_c = data->sc_c;
+
 	return size;
 }
 
@@ -489,7 +492,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 	ret = crypto_shash_update(shash, buf, 2);
 	if (ret)
 		goto out;
-	memset(buf, 0, sizeof(buf));
+	*buf = chap->sc_c;
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
@@ -500,6 +503,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 				  strlen(ctrl->opts->host->nqn));
 	if (ret)
 		goto out;
+	memset(buf, 0, sizeof(buf));
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3da980dc60d9..543e17aead12 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -182,12 +182,14 @@ void nvme_mpath_start_request(struct request *rq)
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct gendisk *disk = ns->head->disk;
 
-	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
+	if ((READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) &&
+	    !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
 		atomic_inc(&ns->ctrl->nr_active);
 		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
 	}
 
-	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
+	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
+	    (nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 
 	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1413788ca7d5..9a96df1a511c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1081,6 +1081,9 @@ static void nvme_tcp_write_space(struct sock *sk)
 	queue = sk->sk_user_data;
 	if (likely(queue && sk_stream_is_writeable(sk))) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		/* Ensure pending TLS partial records are retried */
+		if (nvme_tcp_queue_tls(queue))
+			queue->write_space(sk);
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 1bd5bf4a6097..b4b62b9ccc45 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -192,6 +192,12 @@ static void vmd_pci_msi_enable(struct irq_data *data)
 	data->chip->irq_unmask(data);
 }
 
+static unsigned int vmd_pci_msi_startup(struct irq_data *data)
+{
+	vmd_pci_msi_enable(data);
+	return 0;
+}
+
 static void vmd_irq_disable(struct irq_data *data)
 {
 	struct vmd_irq *vmdirq = data->chip_data;
@@ -210,6 +216,11 @@ static void vmd_pci_msi_disable(struct irq_data *data)
 	vmd_irq_disable(data->parent_data);
 }
 
+static void vmd_pci_msi_shutdown(struct irq_data *data)
+{
+	vmd_pci_msi_disable(data);
+}
+
 static struct irq_chip vmd_msi_controller = {
 	.name			= "VMD-MSI",
 	.irq_compose_msi_msg	= vmd_compose_msi_msg,
@@ -309,6 +320,8 @@ static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
 		return false;
 
+	info->chip->irq_startup		= vmd_pci_msi_startup;
+	info->chip->irq_shutdown	= vmd_pci_msi_shutdown;
 	info->chip->irq_enable		= vmd_pci_msi_enable;
 	info->chip->irq_disable		= vmd_pci_msi_disable;
 	return true;
diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index ed87a3970f83..de5389374d79 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -30,6 +30,7 @@
 
 #define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
 #define DPHY_CMN_SSM_EN			BIT(0)
+#define DPHY_CMN_SSM_CAL_WAIT_TIME	GENMASK(8, 1)
 #define DPHY_CMN_TX_MODE_EN		BIT(9)
 
 #define DPHY_CMN_PWM			DPHY_PMA_CMN(0x40)
@@ -79,6 +80,7 @@ struct cdns_dphy_cfg {
 	u8 pll_ipdiv;
 	u8 pll_opdiv;
 	u16 pll_fbdiv;
+	u32 hs_clk_rate;
 	unsigned int nlanes;
 };
 
@@ -99,6 +101,8 @@ struct cdns_dphy_ops {
 	void (*set_pll_cfg)(struct cdns_dphy *dphy,
 			    const struct cdns_dphy_cfg *cfg);
 	unsigned long (*get_wakeup_time_ns)(struct cdns_dphy *dphy);
+	int (*wait_for_pll_lock)(struct cdns_dphy *dphy);
+	int (*wait_for_cmn_ready)(struct cdns_dphy *dphy);
 };
 
 struct cdns_dphy {
@@ -108,6 +112,8 @@ struct cdns_dphy {
 	struct clk *pll_ref_clk;
 	const struct cdns_dphy_ops *ops;
 	struct phy *phy;
+	bool is_configured;
+	bool is_powered;
 };
 
 /* Order of bands is important since the index is the band number. */
@@ -154,6 +160,9 @@ static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
 					  cfg->pll_ipdiv,
 					  pll_ref_hz);
 
+	cfg->hs_clk_rate = div_u64((u64)pll_ref_hz * cfg->pll_fbdiv,
+				   2 * cfg->pll_opdiv * cfg->pll_ipdiv);
+
 	return 0;
 }
 
@@ -191,6 +200,16 @@ static unsigned long cdns_dphy_get_wakeup_time_ns(struct cdns_dphy *dphy)
 	return dphy->ops->get_wakeup_time_ns(dphy);
 }
 
+static int cdns_dphy_wait_for_pll_lock(struct cdns_dphy *dphy)
+{
+	return dphy->ops->wait_for_pll_lock ? dphy->ops->wait_for_pll_lock(dphy) : 0;
+}
+
+static int cdns_dphy_wait_for_cmn_ready(struct cdns_dphy *dphy)
+{
+	return  dphy->ops->wait_for_cmn_ready ? dphy->ops->wait_for_cmn_ready(dphy) : 0;
+}
+
 static unsigned long cdns_dphy_ref_get_wakeup_time_ns(struct cdns_dphy *dphy)
 {
 	/* Default wakeup time is 800 ns (in a simulated environment). */
@@ -232,7 +251,6 @@ static unsigned long cdns_dphy_j721e_get_wakeup_time_ns(struct cdns_dphy *dphy)
 static void cdns_dphy_j721e_set_pll_cfg(struct cdns_dphy *dphy,
 					const struct cdns_dphy_cfg *cfg)
 {
-	u32 status;
 
 	/*
 	 * set the PWM and PLL Byteclk divider settings to recommended values
@@ -249,13 +267,6 @@ static void cdns_dphy_j721e_set_pll_cfg(struct cdns_dphy *dphy,
 
 	writel(DPHY_TX_J721E_WIZ_LANE_RSTB,
 	       dphy->regs + DPHY_TX_J721E_WIZ_RST_CTRL);
-
-	readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_PLL_CTRL, status,
-			   (status & DPHY_TX_WIZ_PLL_LOCK), 0, POLL_TIMEOUT_US);
-
-	readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_STATUS, status,
-			   (status & DPHY_TX_WIZ_O_CMN_READY), 0,
-			   POLL_TIMEOUT_US);
 }
 
 static void cdns_dphy_j721e_set_psm_div(struct cdns_dphy *dphy, u8 div)
@@ -263,6 +274,23 @@ static void cdns_dphy_j721e_set_psm_div(struct cdns_dphy *dphy, u8 div)
 	writel(div, dphy->regs + DPHY_TX_J721E_WIZ_PSM_FREQ);
 }
 
+static int cdns_dphy_j721e_wait_for_pll_lock(struct cdns_dphy *dphy)
+{
+	u32 status;
+
+	return readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_PLL_CTRL, status,
+			       status & DPHY_TX_WIZ_PLL_LOCK, 0, POLL_TIMEOUT_US);
+}
+
+static int cdns_dphy_j721e_wait_for_cmn_ready(struct cdns_dphy *dphy)
+{
+	u32 status;
+
+	return readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_STATUS, status,
+			       status & DPHY_TX_WIZ_O_CMN_READY, 0,
+			       POLL_TIMEOUT_US);
+}
+
 /*
  * This is the reference implementation of DPHY hooks. Specific integration of
  * this IP may have to re-implement some of them depending on how they decided
@@ -278,6 +306,8 @@ static const struct cdns_dphy_ops j721e_dphy_ops = {
 	.get_wakeup_time_ns = cdns_dphy_j721e_get_wakeup_time_ns,
 	.set_pll_cfg = cdns_dphy_j721e_set_pll_cfg,
 	.set_psm_div = cdns_dphy_j721e_set_psm_div,
+	.wait_for_pll_lock = cdns_dphy_j721e_wait_for_pll_lock,
+	.wait_for_cmn_ready = cdns_dphy_j721e_wait_for_cmn_ready,
 };
 
 static int cdns_dphy_config_from_opts(struct phy *phy,
@@ -297,6 +327,7 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
 	if (ret)
 		return ret;
 
+	opts->hs_clk_rate = cfg->hs_clk_rate;
 	opts->wakeup = cdns_dphy_get_wakeup_time_ns(dphy) / 1000;
 
 	return 0;
@@ -334,21 +365,36 @@ static int cdns_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
 static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 {
 	struct cdns_dphy *dphy = phy_get_drvdata(phy);
-	struct cdns_dphy_cfg cfg = { 0 };
-	int ret, band_ctrl;
-	unsigned int reg;
+	int ret;
 
-	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
-	if (ret)
-		return ret;
+	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &dphy->cfg);
+	if (!ret)
+		dphy->is_configured = true;
+
+	return ret;
+}
+
+static int cdns_dphy_power_on(struct phy *phy)
+{
+	struct cdns_dphy *dphy = phy_get_drvdata(phy);
+	int ret;
+	u32 reg;
+
+	if (!dphy->is_configured || dphy->is_powered)
+		return -EINVAL;
+
+	clk_prepare_enable(dphy->psm_clk);
+	clk_prepare_enable(dphy->pll_ref_clk);
 
 	/*
 	 * Configure the internal PSM clk divider so that the DPHY has a
 	 * 1MHz clk (or something close).
 	 */
 	ret = cdns_dphy_setup_psm(dphy);
-	if (ret)
-		return ret;
+	if (ret) {
+		dev_err(&dphy->phy->dev, "Failed to setup PSM with error %d\n", ret);
+		goto err_power_on;
+	}
 
 	/*
 	 * Configure attach clk lanes to data lanes: the DPHY has 2 clk lanes
@@ -363,40 +409,61 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	 * Configure the DPHY PLL that will be used to generate the TX byte
 	 * clk.
 	 */
-	cdns_dphy_set_pll_cfg(dphy, &cfg);
+	cdns_dphy_set_pll_cfg(dphy, &dphy->cfg);
 
-	band_ctrl = cdns_dphy_tx_get_band_ctrl(opts->mipi_dphy.hs_clk_rate);
-	if (band_ctrl < 0)
-		return band_ctrl;
+	ret = cdns_dphy_tx_get_band_ctrl(dphy->cfg.hs_clk_rate);
+	if (ret < 0) {
+		dev_err(&dphy->phy->dev, "Failed to get band control value with error %d\n", ret);
+		goto err_power_on;
+	}
 
-	reg = FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, band_ctrl) |
-	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, band_ctrl);
+	reg = FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, ret) |
+	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, ret);
 	writel(reg, dphy->regs + DPHY_BAND_CFG);
 
-	return 0;
-}
+	/* Start TX state machine. */
+	reg = readl(dphy->regs + DPHY_CMN_SSM);
+	writel((reg & DPHY_CMN_SSM_CAL_WAIT_TIME) | DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
+	       dphy->regs + DPHY_CMN_SSM);
 
-static int cdns_dphy_power_on(struct phy *phy)
-{
-	struct cdns_dphy *dphy = phy_get_drvdata(phy);
+	ret = cdns_dphy_wait_for_pll_lock(dphy);
+	if (ret) {
+		dev_err(&dphy->phy->dev, "Failed to lock PLL with error %d\n", ret);
+		goto err_power_on;
+	}
 
-	clk_prepare_enable(dphy->psm_clk);
-	clk_prepare_enable(dphy->pll_ref_clk);
+	ret = cdns_dphy_wait_for_cmn_ready(dphy);
+	if (ret) {
+		dev_err(&dphy->phy->dev, "O_CMN_READY signal failed to assert with error %d\n",
+			ret);
+		goto err_power_on;
+	}
 
-	/* Start TX state machine. */
-	writel(DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
-	       dphy->regs + DPHY_CMN_SSM);
+	dphy->is_powered = true;
 
 	return 0;
+
+err_power_on:
+	clk_disable_unprepare(dphy->pll_ref_clk);
+	clk_disable_unprepare(dphy->psm_clk);
+
+	return ret;
 }
 
 static int cdns_dphy_power_off(struct phy *phy)
 {
 	struct cdns_dphy *dphy = phy_get_drvdata(phy);
+	u32 reg;
 
 	clk_disable_unprepare(dphy->pll_ref_clk);
 	clk_disable_unprepare(dphy->psm_clk);
 
+	/* Stop TX state machine. */
+	reg = readl(dphy->regs + DPHY_CMN_SSM);
+	writel(reg & ~DPHY_CMN_SSM_EN, dphy->regs + DPHY_CMN_SSM);
+
+	dphy->is_powered = false;
+
 	return 0;
 }
 
diff --git a/drivers/usb/gadget/function/f_acm.c b/drivers/usb/gadget/function/f_acm.c
index 7061720b9732..106046e17c4e 100644
--- a/drivers/usb/gadget/function/f_acm.c
+++ b/drivers/usb/gadget/function/f_acm.c
@@ -11,12 +11,15 @@
 
 /* #define VERBOSE_DEBUG */
 
+#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/err.h>
 
+#include <linux/usb/gadget.h>
+
 #include "u_serial.h"
 
 
@@ -613,6 +616,7 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_string	*us;
 	int			status;
 	struct usb_ep		*ep;
+	struct usb_request	*request __free(free_usb_request) = NULL;
 
 	/* REVISIT might want instance-specific strings to help
 	 * distinguish instances ...
@@ -630,7 +634,7 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs, and patch descriptors */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	acm->ctrl_id = status;
 	acm_iad_descriptor.bFirstInterface = status;
 
@@ -639,43 +643,41 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	acm->data_id = status;
 
 	acm_data_interface_desc.bInterfaceNumber = status;
 	acm_union_desc.bSlaveInterface0 = status;
 	acm_call_mgmt_descriptor.bDataInterface = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &acm_fs_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	acm->port.in = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &acm_fs_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	acm->port.out = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &acm_fs_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	acm->notify = ep;
 
 	acm_iad_descriptor.bFunctionProtocol = acm->bInterfaceProtocol;
 	acm_control_interface_desc.bInterfaceProtocol = acm->bInterfaceProtocol;
 
 	/* allocate notification */
-	acm->notify_req = gs_alloc_req(ep,
-			sizeof(struct usb_cdc_notification) + 2,
-			GFP_KERNEL);
-	if (!acm->notify_req)
-		goto fail;
+	request = gs_alloc_req(ep,
+			       sizeof(struct usb_cdc_notification) + 2,
+			       GFP_KERNEL);
+	if (!request)
+		return -ENODEV;
 
-	acm->notify_req->complete = acm_cdc_notify_complete;
-	acm->notify_req->context = acm;
+	request->complete = acm_cdc_notify_complete;
+	request->context = acm;
 
 	/* support all relevant hardware speeds... we expect that when
 	 * hardware is dual speed, all bulk-capable endpoints work at
@@ -692,7 +694,9 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, acm_fs_function, acm_hs_function,
 			acm_ss_function, acm_ss_function);
 	if (status)
-		goto fail;
+		return status;
+
+	acm->notify_req = no_free_ptr(request);
 
 	dev_dbg(&cdev->gadget->dev,
 		"acm ttyGS%d: IN/%s OUT/%s NOTIFY/%s\n",
@@ -700,14 +704,6 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 		acm->port.in->name, acm->port.out->name,
 		acm->notify->name);
 	return 0;
-
-fail:
-	if (acm->notify_req)
-		gs_free_req(acm->notify, acm->notify_req);
-
-	ERROR(cdev, "%s/%p: can't bind, err %d\n", f->name, f, status);
-
-	return status;
 }
 
 static void acm_unbind(struct usb_configuration *c, struct usb_function *f)
diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index 027226325039..675d2bc538a4 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -8,6 +8,7 @@
 
 /* #define VERBOSE_DEBUG */
 
+#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -15,6 +16,8 @@
 #include <linux/etherdevice.h>
 #include <linux/string_choices.h>
 
+#include <linux/usb/gadget.h>
+
 #include "u_ether.h"
 #include "u_ether_configfs.h"
 #include "u_ecm.h"
@@ -678,6 +681,7 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 
 	struct f_ecm_opts	*ecm_opts;
+	struct usb_request	*request __free(free_usb_request) = NULL;
 
 	if (!can_support_ecm(cdev->gadget))
 		return -EINVAL;
@@ -711,7 +715,7 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	ecm->ctrl_id = status;
 	ecm_iad_descriptor.bFirstInterface = status;
 
@@ -720,24 +724,22 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	ecm->data_id = status;
 
 	ecm_data_nop_intf.bInterfaceNumber = status;
 	ecm_data_intf.bInterfaceNumber = status;
 	ecm_union_desc.bSlaveInterface0 = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ecm_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ecm->port.in_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ecm_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ecm->port.out_ep = ep;
 
 	/* NOTE:  a status/notification endpoint is *OPTIONAL* but we
@@ -746,20 +748,18 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	 */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ecm_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ecm->notify = ep;
 
-	status = -ENOMEM;
-
 	/* allocate notification request and buffer */
-	ecm->notify_req = usb_ep_alloc_request(ep, GFP_KERNEL);
-	if (!ecm->notify_req)
-		goto fail;
-	ecm->notify_req->buf = kmalloc(ECM_STATUS_BYTECOUNT, GFP_KERNEL);
-	if (!ecm->notify_req->buf)
-		goto fail;
-	ecm->notify_req->context = ecm;
-	ecm->notify_req->complete = ecm_notify_complete;
+	request = usb_ep_alloc_request(ep, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+	request->buf = kmalloc(ECM_STATUS_BYTECOUNT, GFP_KERNEL);
+	if (!request->buf)
+		return -ENOMEM;
+	request->context = ecm;
+	request->complete = ecm_notify_complete;
 
 	/* support all relevant hardware speeds... we expect that when
 	 * hardware is dual speed, all bulk-capable endpoints work at
@@ -778,7 +778,7 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, ecm_fs_function, ecm_hs_function,
 			ecm_ss_function, ecm_ss_function);
 	if (status)
-		goto fail;
+		return status;
 
 	/* NOTE:  all that is done without knowing or caring about
 	 * the network link ... which is unavailable to this code
@@ -788,20 +788,12 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	ecm->port.open = ecm_open;
 	ecm->port.close = ecm_close;
 
+	ecm->notify_req = no_free_ptr(request);
+
 	DBG(cdev, "CDC Ethernet: IN/%s OUT/%s NOTIFY/%s\n",
 			ecm->port.in_ep->name, ecm->port.out_ep->name,
 			ecm->notify->name);
 	return 0;
-
-fail:
-	if (ecm->notify_req) {
-		kfree(ecm->notify_req->buf);
-		usb_ep_free_request(ecm->notify, ecm->notify_req);
-	}
-
-	ERROR(cdev, "%s: can't bind, err %d\n", f->name, status);
-
-	return status;
 }
 
 static inline struct f_ecm_opts *to_f_ecm_opts(struct config_item *item)
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 58b0dd575af3..0148d60926dc 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -11,6 +11,7 @@
  * Copyright (C) 2008 Nokia Corporation
  */
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -20,6 +21,7 @@
 #include <linux/string_choices.h>
 
 #include <linux/usb/cdc.h>
+#include <linux/usb/gadget.h>
 
 #include "u_ether.h"
 #include "u_ether_configfs.h"
@@ -1436,18 +1438,18 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 	struct f_ncm_opts	*ncm_opts;
 
+	struct usb_os_desc_table	*os_desc_table __free(kfree) = NULL;
+	struct usb_request		*request __free(free_usb_request) = NULL;
+
 	if (!can_support_ecm(cdev->gadget))
 		return -EINVAL;
 
 	ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
 
 	if (cdev->use_os_string) {
-		f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
-					   GFP_KERNEL);
-		if (!f->os_desc_table)
+		os_desc_table = kzalloc(sizeof(*os_desc_table), GFP_KERNEL);
+		if (!os_desc_table)
 			return -ENOMEM;
-		f->os_desc_n = 1;
-		f->os_desc_table[0].os_desc = &ncm_opts->ncm_os_desc;
 	}
 
 	mutex_lock(&ncm_opts->lock);
@@ -1459,16 +1461,15 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	mutex_unlock(&ncm_opts->lock);
 
 	if (status)
-		goto fail;
+		return status;
 
 	ncm_opts->bound = true;
 
 	us = usb_gstrings_attach(cdev, ncm_strings,
 				 ARRAY_SIZE(ncm_string_defs));
-	if (IS_ERR(us)) {
-		status = PTR_ERR(us);
-		goto fail;
-	}
+	if (IS_ERR(us))
+		return PTR_ERR(us);
+
 	ncm_control_intf.iInterface = us[STRING_CTRL_IDX].id;
 	ncm_data_nop_intf.iInterface = us[STRING_DATA_IDX].id;
 	ncm_data_intf.iInterface = us[STRING_DATA_IDX].id;
@@ -1478,20 +1479,16 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	ncm->ctrl_id = status;
 	ncm_iad_desc.bFirstInterface = status;
 
 	ncm_control_intf.bInterfaceNumber = status;
 	ncm_union_desc.bMasterInterface0 = status;
 
-	if (cdev->use_os_string)
-		f->os_desc_table[0].if_id =
-			ncm_iad_desc.bFirstInterface;
-
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	ncm->data_id = status;
 
 	ncm_data_nop_intf.bInterfaceNumber = status;
@@ -1500,35 +1497,31 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	ecm_desc.wMaxSegmentSize = cpu_to_le16(ncm_opts->max_segment_size);
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ncm->port.in_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ncm->port.out_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ncm->notify = ep;
 
-	status = -ENOMEM;
-
 	/* allocate notification request and buffer */
-	ncm->notify_req = usb_ep_alloc_request(ep, GFP_KERNEL);
-	if (!ncm->notify_req)
-		goto fail;
-	ncm->notify_req->buf = kmalloc(NCM_STATUS_BYTECOUNT, GFP_KERNEL);
-	if (!ncm->notify_req->buf)
-		goto fail;
-	ncm->notify_req->context = ncm;
-	ncm->notify_req->complete = ncm_notify_complete;
+	request = usb_ep_alloc_request(ep, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+	request->buf = kmalloc(NCM_STATUS_BYTECOUNT, GFP_KERNEL);
+	if (!request->buf)
+		return -ENOMEM;
+	request->context = ncm;
+	request->complete = ncm_notify_complete;
 
 	/*
 	 * support all relevant hardware speeds... we expect that when
@@ -1548,7 +1541,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, ncm_fs_function, ncm_hs_function,
 			ncm_ss_function, ncm_ss_function);
 	if (status)
-		goto fail;
+		return status;
 
 	/*
 	 * NOTE:  all that is done without knowing or caring about
@@ -1561,23 +1554,18 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	hrtimer_setup(&ncm->task_timer, ncm_tx_timeout, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 
+	if (cdev->use_os_string) {
+		os_desc_table[0].os_desc = &ncm_opts->ncm_os_desc;
+		os_desc_table[0].if_id = ncm_iad_desc.bFirstInterface;
+		f->os_desc_table = no_free_ptr(os_desc_table);
+		f->os_desc_n = 1;
+	}
+	ncm->notify_req = no_free_ptr(request);
+
 	DBG(cdev, "CDC Network: IN/%s OUT/%s NOTIFY/%s\n",
 			ncm->port.in_ep->name, ncm->port.out_ep->name,
 			ncm->notify->name);
 	return 0;
-
-fail:
-	kfree(f->os_desc_table);
-	f->os_desc_n = 0;
-
-	if (ncm->notify_req) {
-		kfree(ncm->notify_req->buf);
-		usb_ep_free_request(ncm->notify, ncm->notify_req);
-	}
-
-	ERROR(cdev, "%s: can't bind, err %d\n", f->name, status);
-
-	return status;
 }
 
 static inline struct f_ncm_opts *to_f_ncm_opts(struct config_item *item)
diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/function/f_rndis.c
index 7cec19d65fb5..7451e7cb7a85 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -19,6 +19,8 @@
 
 #include <linux/atomic.h>
 
+#include <linux/usb/gadget.h>
+
 #include "u_ether.h"
 #include "u_ether_configfs.h"
 #include "u_rndis.h"
@@ -662,6 +664,8 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 
 	struct f_rndis_opts *rndis_opts;
+	struct usb_os_desc_table        *os_desc_table __free(kfree) = NULL;
+	struct usb_request		*request __free(free_usb_request) = NULL;
 
 	if (!can_support_rndis(c))
 		return -EINVAL;
@@ -669,12 +673,9 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	rndis_opts = container_of(f->fi, struct f_rndis_opts, func_inst);
 
 	if (cdev->use_os_string) {
-		f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
-					   GFP_KERNEL);
-		if (!f->os_desc_table)
+		os_desc_table = kzalloc(sizeof(*os_desc_table), GFP_KERNEL);
+		if (!os_desc_table)
 			return -ENOMEM;
-		f->os_desc_n = 1;
-		f->os_desc_table[0].os_desc = &rndis_opts->rndis_os_desc;
 	}
 
 	rndis_iad_descriptor.bFunctionClass = rndis_opts->class;
@@ -692,16 +693,14 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 		gether_set_gadget(rndis_opts->net, cdev->gadget);
 		status = gether_register_netdev(rndis_opts->net);
 		if (status)
-			goto fail;
+			return status;
 		rndis_opts->bound = true;
 	}
 
 	us = usb_gstrings_attach(cdev, rndis_strings,
 				 ARRAY_SIZE(rndis_string_defs));
-	if (IS_ERR(us)) {
-		status = PTR_ERR(us);
-		goto fail;
-	}
+	if (IS_ERR(us))
+		return PTR_ERR(us);
 	rndis_control_intf.iInterface = us[0].id;
 	rndis_data_intf.iInterface = us[1].id;
 	rndis_iad_descriptor.iFunction = us[2].id;
@@ -709,36 +708,30 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	rndis->ctrl_id = status;
 	rndis_iad_descriptor.bFirstInterface = status;
 
 	rndis_control_intf.bInterfaceNumber = status;
 	rndis_union_desc.bMasterInterface0 = status;
 
-	if (cdev->use_os_string)
-		f->os_desc_table[0].if_id =
-			rndis_iad_descriptor.bFirstInterface;
-
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	rndis->data_id = status;
 
 	rndis_data_intf.bInterfaceNumber = status;
 	rndis_union_desc.bSlaveInterface0 = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	rndis->port.in_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	rndis->port.out_ep = ep;
 
 	/* NOTE:  a status/notification endpoint is, strictly speaking,
@@ -747,21 +740,19 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	 */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	rndis->notify = ep;
 
-	status = -ENOMEM;
-
 	/* allocate notification request and buffer */
-	rndis->notify_req = usb_ep_alloc_request(ep, GFP_KERNEL);
-	if (!rndis->notify_req)
-		goto fail;
-	rndis->notify_req->buf = kmalloc(STATUS_BYTECOUNT, GFP_KERNEL);
-	if (!rndis->notify_req->buf)
-		goto fail;
-	rndis->notify_req->length = STATUS_BYTECOUNT;
-	rndis->notify_req->context = rndis;
-	rndis->notify_req->complete = rndis_response_complete;
+	request = usb_ep_alloc_request(ep, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+	request->buf = kmalloc(STATUS_BYTECOUNT, GFP_KERNEL);
+	if (!request->buf)
+		return -ENOMEM;
+	request->length = STATUS_BYTECOUNT;
+	request->context = rndis;
+	request->complete = rndis_response_complete;
 
 	/* support all relevant hardware speeds... we expect that when
 	 * hardware is dual speed, all bulk-capable endpoints work at
@@ -778,7 +769,7 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, eth_fs_function, eth_hs_function,
 			eth_ss_function, eth_ss_function);
 	if (status)
-		goto fail;
+		return status;
 
 	rndis->port.open = rndis_open;
 	rndis->port.close = rndis_close;
@@ -789,9 +780,18 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	if (rndis->manufacturer && rndis->vendorID &&
 			rndis_set_param_vendor(rndis->params, rndis->vendorID,
 					       rndis->manufacturer)) {
-		status = -EINVAL;
-		goto fail_free_descs;
+		usb_free_all_descriptors(f);
+		return -EINVAL;
+	}
+
+	if (cdev->use_os_string) {
+		os_desc_table[0].os_desc = &rndis_opts->rndis_os_desc;
+		os_desc_table[0].if_id = rndis_iad_descriptor.bFirstInterface;
+		f->os_desc_table = no_free_ptr(os_desc_table);
+		f->os_desc_n = 1;
+
 	}
+	rndis->notify_req = no_free_ptr(request);
 
 	/* NOTE:  all that is done without knowing or caring about
 	 * the network link ... which is unavailable to this code
@@ -802,21 +802,6 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 			rndis->port.in_ep->name, rndis->port.out_ep->name,
 			rndis->notify->name);
 	return 0;
-
-fail_free_descs:
-	usb_free_all_descriptors(f);
-fail:
-	kfree(f->os_desc_table);
-	f->os_desc_n = 0;
-
-	if (rndis->notify_req) {
-		kfree(rndis->notify_req->buf);
-		usb_ep_free_request(rndis->notify, rndis->notify_req);
-	}
-
-	ERROR(cdev, "%s: can't bind, err %d\n", f->name, status);
-
-	return status;
 }
 
 void rndis_borrow_net(struct usb_function_instance *f, struct net_device *net)
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d709e24c1fd4..e3d63b8fa0f4 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -194,6 +194,9 @@ struct usb_request *usb_ep_alloc_request(struct usb_ep *ep,
 
 	req = ep->ops->alloc_request(ep, gfp_flags);
 
+	if (req)
+		req->ep = ep;
+
 	trace_usb_ep_alloc_request(ep, req, req ? 0 : -ENOMEM);
 
 	return req;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e6d2557ac37b..a1566df45be9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -914,7 +914,7 @@ static void btrfs_readahead_expand(struct readahead_control *ractl,
 {
 	const u64 ra_pos = readahead_pos(ractl);
 	const u64 ra_end = ra_pos + readahead_length(ractl);
-	const u64 em_end = em->start + em->ram_bytes;
+	const u64 em_end = em->start + em->len;
 
 	/* No expansion for holes and inline extents. */
 	if (em->disk_bytenr > EXTENT_MAP_LAST_BYTE)
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index eba7f22ae49c..a29c2ac60aef 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1106,14 +1106,15 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	 * If ret is 1 (no key found), it means this is an empty block group,
 	 * without any extents allocated from it and there's no block group
 	 * item (key BTRFS_BLOCK_GROUP_ITEM_KEY) located in the extent tree
-	 * because we are using the block group tree feature, so block group
-	 * items are stored in the block group tree. It also means there are no
-	 * extents allocated for block groups with a start offset beyond this
-	 * block group's end offset (this is the last, highest, block group).
+	 * because we are using the block group tree feature (so block group
+	 * items are stored in the block group tree) or this is a new block
+	 * group created in the current transaction and its block group item
+	 * was not yet inserted in the extent tree (that happens in
+	 * btrfs_create_pending_block_groups() -> insert_block_group_item()).
+	 * It also means there are no extents allocated for block groups with a
+	 * start offset beyond this block group's end offset (this is the last,
+	 * highest, block group).
 	 */
-	if (!btrfs_fs_compat_ro(trans->fs_info, BLOCK_GROUP_TREE))
-		ASSERT(ret == 0);
-
 	start = block_group->start;
 	end = block_group->start + block_group->length;
 	while (ret == 0) {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7e13de2bdcbf..155e11d2faa8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3740,7 +3740,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 		prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
 		if (!prealloc) {
 			ret = -ENOMEM;
-			goto drop_write;
+			goto out;
 		}
 	}
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7256f6748c8f..63baae5383e1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3795,6 +3795,7 @@ static noinline_for_stack struct inode *create_reloc_inode(
 /*
  * Mark start of chunk relocation that is cancellable. Check if the cancellation
  * has been requested meanwhile and don't start in that case.
+ * NOTE: if this returns an error, reloc_chunk_end() must not be called.
  *
  * Return:
  *   0             success
@@ -3811,10 +3812,8 @@ static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
 
 	if (atomic_read(&fs_info->reloc_cancel_req) > 0) {
 		btrfs_info(fs_info, "chunk relocation canceled on start");
-		/*
-		 * On cancel, clear all requests but let the caller mark
-		 * the end after cleanup operations.
-		 */
+		/* On cancel, clear all requests. */
+		clear_and_wake_up_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags);
 		atomic_set(&fs_info->reloc_cancel_req, 0);
 		return -ECANCELED;
 	}
@@ -3823,9 +3822,11 @@ static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
 
 /*
  * Mark end of chunk relocation that is cancellable and wake any waiters.
+ * NOTE: call only if a previous call to reloc_chunk_start() succeeded.
  */
 static void reloc_chunk_end(struct btrfs_fs_info *fs_info)
 {
+	ASSERT(test_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags));
 	/* Requested after start, clear bit first so any waiters can continue */
 	if (atomic_read(&fs_info->reloc_cancel_req) > 0)
 		btrfs_info(fs_info, "chunk relocation canceled during operation");
@@ -4038,9 +4039,9 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	if (err && rw)
 		btrfs_dec_block_group_ro(rc->block_group);
 	iput(rc->data_inode);
+	reloc_chunk_end(fs_info);
 out_put_bg:
 	btrfs_put_block_group(bg);
-	reloc_chunk_end(fs_info);
 	free_reloc_control(rc);
 	return err;
 }
@@ -4223,8 +4224,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		ret = ret2;
 out_unset:
 	unset_reloc_control(rc);
-out_end:
 	reloc_chunk_end(fs_info);
+out_end:
 	free_reloc_control(rc);
 out:
 	free_reloc_roots(&reloc_roots);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b06b8f325537..fcc7ecbb4945 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1902,8 +1902,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		return PTR_ERR(sb);
 	}
 
-	set_device_specific_options(fs_info);
-
 	if (sb->s_root) {
 		/*
 		 * Not the first mount of the fs thus got an existing super block.
@@ -1948,6 +1946,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 			deactivate_locked_super(sb);
 			return -EACCES;
 		}
+		set_device_specific_options(fs_info);
 		bdev = fs_devices->latest_dev->bdev;
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index f426276e2b6b..87c5dd3ad016 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1753,7 +1753,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	    !fs_info->stripe_root) {
 		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
 			  btrfs_bg_type_to_raid_name(map->type));
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
 	if (cache->alloc_offset > cache->zone_capacity) {
diff --git a/fs/coredump.c b/fs/coredump.c
index 60bc9685e149..c5e9a855502d 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1466,7 +1466,7 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
 	ssize_t retval;
 	char old_core_pattern[CORENAME_MAX_SIZE];
 
-	if (write)
+	if (!write)
 		return proc_dostring(table, write, buffer, lenp, ppos);
 
 	retval = strscpy(old_core_pattern, core_pattern, CORENAME_MAX_SIZE);
diff --git a/fs/dax.c b/fs/dax.c
index 20ecf652c129..260e063e3bc2 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1752,7 +1752,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iov_iter_rw(iter) == WRITE) {
 		lockdep_assert_held_write(&iomi.inode->i_rwsem);
 		iomi.flags |= IOMAP_WRITE;
-	} else {
+	} else if (!sb_rdonly(iomi.inode->i_sb)) {
 		lockdep_assert_held(&iomi.inode->i_rwsem);
 	}
 
diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..c11d87810fba 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2557,6 +2557,8 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	spin_lock(&parent->d_lock);
 	new->d_parent = dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
+	if (parent->d_flags & DCACHE_DISCONNECTED)
+		new->d_flags |= DCACHE_DISCONNECTED;
 	spin_unlock(&parent->d_lock);
 
 retry:
diff --git a/fs/exec.c b/fs/exec.c
index e861a4b7ffda..a69a2673f631 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2048,7 +2048,7 @@ static int proc_dointvec_minmax_coredump(const struct ctl_table *table, int writ
 {
 	int error = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
-	if (!error && !write)
+	if (!error && write)
 		validate_coredump_safety();
 	return error;
 }
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index b3e9b7bd7978..a0e66bc10093 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -280,9 +280,16 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 		  bh, is_metadata, inode->i_mode,
 		  test_opt(inode->i_sb, DATA_FLAGS));
 
-	/* In the no journal case, we can just do a bforget and return */
+	/*
+	 * In the no journal case, we should wait for the ongoing buffer
+	 * to complete and do a forget.
+	 */
 	if (!ext4_handle_valid(handle)) {
-		bforget(bh);
+		if (bh) {
+			clear_buffer_dirty(bh);
+			wait_on_buffer(bh);
+			__bforget(bh);
+		}
 		return 0;
 	}
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f9e4ac87211e..e99306a8f47c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5319,6 +5319,14 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
 	ext4_set_inode_flags(inode, true);
+	/* Detect invalid flag combination - can't have both inline data and extents */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
+	    ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		ext4_error_inode(inode, function, line, 0,
+			"inode has both inline data and extents flags");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
 	inode->i_blocks = ext4_inode_blocks(raw_inode, ei);
 	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl_lo);
 	if (ext4_has_feature_64bit(sb))
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 50c90bd03923..7b891b8f0a8d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1504,8 +1504,8 @@ static bool f2fs_map_blocks_cached(struct inode *inode,
 		struct f2fs_dev_info *dev = &sbi->devs[bidx];
 
 		map->m_bdev = dev->bdev;
-		map->m_pblk -= dev->start_blk;
 		map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);
+		map->m_pblk -= dev->start_blk;
 	} else {
 		map->m_bdev = inode->i_sb->s_bdev;
 	}
diff --git a/fs/file_attr.c b/fs/file_attr.c
index 12424d4945d0..460b2dd21a85 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -84,7 +84,7 @@ int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	int error;
 
 	if (!inode->i_op->fileattr_get)
-		return -EOPNOTSUPP;
+		return -ENOIOCTLCMD;
 
 	error = security_inode_file_getattr(dentry, fa);
 	if (error)
@@ -270,7 +270,7 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 	int err;
 
 	if (!inode->i_op->fileattr_set)
-		return -EOPNOTSUPP;
+		return -ENOIOCTLCMD;
 
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EPERM;
@@ -312,8 +312,6 @@ int ioctl_getflags(struct file *file, unsigned int __user *argp)
 	int err;
 
 	err = vfs_fileattr_get(file->f_path.dentry, &fa);
-	if (err == -EOPNOTSUPP)
-		err = -ENOIOCTLCMD;
 	if (!err)
 		err = put_user(fa.flags, argp);
 	return err;
@@ -335,8 +333,6 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
 			fileattr_fill_flags(&fa, flags);
 			err = vfs_fileattr_set(idmap, dentry, &fa);
 			mnt_drop_write_file(file);
-			if (err == -EOPNOTSUPP)
-				err = -ENOIOCTLCMD;
 		}
 	}
 	return err;
@@ -349,8 +345,6 @@ int ioctl_fsgetxattr(struct file *file, void __user *argp)
 	int err;
 
 	err = vfs_fileattr_get(file->f_path.dentry, &fa);
-	if (err == -EOPNOTSUPP)
-		err = -ENOIOCTLCMD;
 	if (!err)
 		err = copy_fsxattr_to_user(&fa, argp);
 
@@ -371,8 +365,6 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
 		if (!err) {
 			err = vfs_fileattr_set(idmap, dentry, &fa);
 			mnt_drop_write_file(file);
-			if (err == -EOPNOTSUPP)
-				err = -ENOIOCTLCMD;
 		}
 	}
 	return err;
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 57032eadca6c..fdc175e93f74 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -536,8 +536,6 @@ int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);
 
-	if (err == -ENOTTY)
-		err = -EOPNOTSUPP;
 	return err;
 }
 
@@ -574,7 +572,5 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);
 
-	if (err == -ENOTTY)
-		err = -EOPNOTSUPP;
 	return err;
 }
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 862ba27f1628..11e08a4a18b2 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -40,6 +40,18 @@ int hfsplus_strcasecmp(const struct hfsplus_unistr *s1,
 	p1 = s1->unicode;
 	p2 = s2->unicode;
 
+	if (len1 > HFSPLUS_MAX_STRLEN) {
+		len1 = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(s1->length), len1);
+	}
+
+	if (len2 > HFSPLUS_MAX_STRLEN) {
+		len2 = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(s2->length), len2);
+	}
+
 	while (1) {
 		c1 = c2 = 0;
 
@@ -74,6 +86,18 @@ int hfsplus_strcmp(const struct hfsplus_unistr *s1,
 	p1 = s1->unicode;
 	p2 = s2->unicode;
 
+	if (len1 > HFSPLUS_MAX_STRLEN) {
+		len1 = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(s1->length), len1);
+	}
+
+	if (len2 > HFSPLUS_MAX_STRLEN) {
+		len2 = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(s2->length), len2);
+	}
+
 	for (len = min(len1, len2); len > 0; len--) {
 		c1 = be16_to_cpu(*p1);
 		c2 = be16_to_cpu(*p2);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index c7867139af69..3e510564de6e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1659,6 +1659,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 	int drop_reserve = 0;
 	int err = 0;
 	int was_modified = 0;
+	int wait_for_writeback = 0;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -1782,18 +1783,22 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 		}
 
 		/*
-		 * The buffer is still not written to disk, we should
-		 * attach this buffer to current transaction so that the
-		 * buffer can be checkpointed only after the current
-		 * transaction commits.
+		 * The buffer has not yet been written to disk. We should
+		 * either clear the buffer or ensure that the ongoing I/O
+		 * is completed, and attach this buffer to current
+		 * transaction so that the buffer can be checkpointed only
+		 * after the current transaction commits.
 		 */
 		clear_buffer_dirty(bh);
+		wait_for_writeback = 1;
 		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
 		spin_unlock(&journal->j_list_lock);
 	}
 drop:
 	__brelse(bh);
 	spin_unlock(&jh->b_state_lock);
+	if (wait_for_writeback)
+		wait_on_buffer(bh);
 	jbd2_journal_put_journal_head(jh);
 	if (drop_reserve) {
 		/* no need to reserve log space for this block -bzzz */
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 19078a043e85..0822d8a119c6 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -118,7 +118,6 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		struct iomap *iomaps, int nr_iomaps)
 {
 	struct timespec64 mtime = inode_get_mtime(inode);
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct iattr iattr = { .ia_valid = 0 };
 	int error;
 
@@ -128,9 +127,9 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
 	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
 
-	if (new_size > i_size_read(inode)) {
+	if (lcp->lc_size_chg) {
 		iattr.ia_valid |= ATTR_SIZE;
-		iattr.ia_size = new_size;
+		iattr.ia_size = lcp->lc_newsize;
 	}
 
 	error = inode->i_sb->s_export_op->commit_blocks(inode, iomaps,
@@ -173,16 +172,18 @@ nfsd4_block_proc_getdeviceinfo(struct super_block *sb,
 }
 
 static __be32
-nfsd4_block_proc_layoutcommit(struct inode *inode,
+nfsd4_block_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
 		struct nfsd4_layoutcommit *lcp)
 {
 	struct iomap *iomaps;
 	int nr_iomaps;
 	__be32 nfserr;
 
-	nfserr = nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
-			lcp->lc_up_len, &iomaps, &nr_iomaps,
-			i_blocksize(inode));
+	rqstp->rq_arg = lcp->lc_up_layout;
+	svcxdr_init_decode(rqstp);
+
+	nfserr = nfsd4_block_decode_layoutupdate(&rqstp->rq_arg_stream,
+			&iomaps, &nr_iomaps, i_blocksize(inode));
 	if (nfserr != nfs_ok)
 		return nfserr;
 
@@ -313,16 +314,18 @@ nfsd4_scsi_proc_getdeviceinfo(struct super_block *sb,
 	return nfserrno(nfsd4_block_get_device_info_scsi(sb, clp, gdp));
 }
 static __be32
-nfsd4_scsi_proc_layoutcommit(struct inode *inode,
+nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
 		struct nfsd4_layoutcommit *lcp)
 {
 	struct iomap *iomaps;
 	int nr_iomaps;
 	__be32 nfserr;
 
-	nfserr = nfsd4_scsi_decode_layoutupdate(lcp->lc_up_layout,
-			lcp->lc_up_len, &iomaps, &nr_iomaps,
-			i_blocksize(inode));
+	rqstp->rq_arg = lcp->lc_up_layout;
+	svcxdr_init_decode(rqstp);
+
+	nfserr = nfsd4_scsi_decode_layoutupdate(&rqstp->rq_arg_stream,
+			&iomaps, &nr_iomaps, i_blocksize(inode));
 	if (nfserr != nfs_ok)
 		return nfserr;
 
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index bcf21fde9120..e50afe340737 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -29,8 +29,7 @@ nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 	*p++ = cpu_to_be32(len);
 	*p++ = cpu_to_be32(1);		/* we always return a single extent */
 
-	p = xdr_encode_opaque_fixed(p, &b->vol_id,
-			sizeof(struct nfsd4_deviceid));
+	p = svcxdr_encode_deviceid4(p, &b->vol_id);
 	p = xdr_encode_hyper(p, b->foff);
 	p = xdr_encode_hyper(p, b->len);
 	p = xdr_encode_hyper(p, b->soff);
@@ -114,8 +113,7 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 
 /**
  * nfsd4_block_decode_layoutupdate - decode the block layout extent array
- * @p: pointer to the xdr data
- * @len: number of bytes to decode
+ * @xdr: subbuf set to the encoded array
  * @iomapp: pointer to store the decoded extent array
  * @nr_iomapsp: pointer to store the number of extents
  * @block_size: alignment of extent offset and length
@@ -128,25 +126,24 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
  *
  * Return values:
  *   %nfs_ok: Successful decoding, @iomapp and @nr_iomapsp are valid
- *   %nfserr_bad_xdr: The encoded array in @p is invalid
+ *   %nfserr_bad_xdr: The encoded array in @xdr is invalid
  *   %nfserr_inval: An unaligned extent found
  *   %nfserr_delay: Failed to allocate memory for @iomapp
  */
 __be32
-nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
+nfsd4_block_decode_layoutupdate(struct xdr_stream *xdr, struct iomap **iomapp,
 		int *nr_iomapsp, u32 block_size)
 {
 	struct iomap *iomaps;
-	u32 nr_iomaps, i;
+	u32 nr_iomaps, expected, len, i;
+	__be32 nfserr;
 
-	if (len < sizeof(u32))
-		return nfserr_bad_xdr;
-	len -= sizeof(u32);
-	if (len % PNFS_BLOCK_EXTENT_SIZE)
+	if (xdr_stream_decode_u32(xdr, &nr_iomaps))
 		return nfserr_bad_xdr;
 
-	nr_iomaps = be32_to_cpup(p++);
-	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE)
+	len = sizeof(__be32) + xdr_stream_remaining(xdr);
+	expected = sizeof(__be32) + nr_iomaps * PNFS_BLOCK_EXTENT_SIZE;
+	if (len != expected)
 		return nfserr_bad_xdr;
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
@@ -156,23 +153,44 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	for (i = 0; i < nr_iomaps; i++) {
 		struct pnfs_block_extent bex;
 
-		memcpy(&bex.vol_id, p, sizeof(struct nfsd4_deviceid));
-		p += XDR_QUADLEN(sizeof(struct nfsd4_deviceid));
+		if (nfsd4_decode_deviceid4(xdr, &bex.vol_id)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
 
-		p = xdr_decode_hyper(p, &bex.foff);
+		if (xdr_stream_decode_u64(xdr, &bex.foff)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
 		if (bex.foff & (block_size - 1)) {
+			nfserr = nfserr_inval;
+			goto fail;
+		}
+
+		if (xdr_stream_decode_u64(xdr, &bex.len)) {
+			nfserr = nfserr_bad_xdr;
 			goto fail;
 		}
-		p = xdr_decode_hyper(p, &bex.len);
 		if (bex.len & (block_size - 1)) {
+			nfserr = nfserr_inval;
+			goto fail;
+		}
+
+		if (xdr_stream_decode_u64(xdr, &bex.soff)) {
+			nfserr = nfserr_bad_xdr;
 			goto fail;
 		}
-		p = xdr_decode_hyper(p, &bex.soff);
 		if (bex.soff & (block_size - 1)) {
+			nfserr = nfserr_inval;
+			goto fail;
+		}
+
+		if (xdr_stream_decode_u32(xdr, &bex.es)) {
+			nfserr = nfserr_bad_xdr;
 			goto fail;
 		}
-		bex.es = be32_to_cpup(p++);
 		if (bex.es != PNFS_BLOCK_READWRITE_DATA) {
+			nfserr = nfserr_inval;
 			goto fail;
 		}
 
@@ -185,13 +203,12 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	return nfs_ok;
 fail:
 	kfree(iomaps);
-	return nfserr_inval;
+	return nfserr;
 }
 
 /**
  * nfsd4_scsi_decode_layoutupdate - decode the scsi layout extent array
- * @p: pointer to the xdr data
- * @len: number of bytes to decode
+ * @xdr: subbuf set to the encoded array
  * @iomapp: pointer to store the decoded extent array
  * @nr_iomapsp: pointer to store the number of extents
  * @block_size: alignment of extent offset and length
@@ -203,21 +220,22 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
  *
  * Return values:
  *   %nfs_ok: Successful decoding, @iomapp and @nr_iomapsp are valid
- *   %nfserr_bad_xdr: The encoded array in @p is invalid
+ *   %nfserr_bad_xdr: The encoded array in @xdr is invalid
  *   %nfserr_inval: An unaligned extent found
  *   %nfserr_delay: Failed to allocate memory for @iomapp
  */
 __be32
-nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
+nfsd4_scsi_decode_layoutupdate(struct xdr_stream *xdr, struct iomap **iomapp,
 		int *nr_iomapsp, u32 block_size)
 {
 	struct iomap *iomaps;
-	u32 nr_iomaps, expected, i;
+	u32 nr_iomaps, expected, len, i;
+	__be32 nfserr;
 
-	if (len < sizeof(u32))
+	if (xdr_stream_decode_u32(xdr, &nr_iomaps))
 		return nfserr_bad_xdr;
 
-	nr_iomaps = be32_to_cpup(p++);
+	len = sizeof(__be32) + xdr_stream_remaining(xdr);
 	expected = sizeof(__be32) + nr_iomaps * PNFS_SCSI_RANGE_SIZE;
 	if (len != expected)
 		return nfserr_bad_xdr;
@@ -229,14 +247,22 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	for (i = 0; i < nr_iomaps; i++) {
 		u64 val;
 
-		p = xdr_decode_hyper(p, &val);
+		if (xdr_stream_decode_u64(xdr, &val)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
 		if (val & (block_size - 1)) {
+			nfserr = nfserr_inval;
 			goto fail;
 		}
 		iomaps[i].offset = val;
 
-		p = xdr_decode_hyper(p, &val);
+		if (xdr_stream_decode_u64(xdr, &val)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
 		if (val & (block_size - 1)) {
+			nfserr = nfserr_inval;
 			goto fail;
 		}
 		iomaps[i].length = val;
@@ -247,5 +273,5 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	return nfs_ok;
 fail:
 	kfree(iomaps);
-	return nfserr_inval;
+	return nfserr;
 }
diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
index 15b3569f3d9a..7d25ef689671 100644
--- a/fs/nfsd/blocklayoutxdr.h
+++ b/fs/nfsd/blocklayoutxdr.h
@@ -54,9 +54,9 @@ __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 		const struct nfsd4_getdeviceinfo *gdp);
 __be32 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 		const struct nfsd4_layoutget *lgp);
-__be32 nfsd4_block_decode_layoutupdate(__be32 *p, u32 len,
+__be32 nfsd4_block_decode_layoutupdate(struct xdr_stream *xdr,
 		struct iomap **iomapp, int *nr_iomapsp, u32 block_size);
-__be32 nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len,
+__be32 nfsd4_scsi_decode_layoutupdate(struct xdr_stream *xdr,
 		struct iomap **iomapp, int *nr_iomapsp, u32 block_size);
 
 #endif /* _NFSD_BLOCKLAYOUTXDR_H */
diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index 3ca5304440ff..3c4419da5e24 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -125,6 +125,13 @@ nfsd4_ff_proc_getdeviceinfo(struct super_block *sb, struct svc_rqst *rqstp,
 	return 0;
 }
 
+static __be32
+nfsd4_ff_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
+		struct nfsd4_layoutcommit *lcp)
+{
+	return nfs_ok;
+}
+
 const struct nfsd4_layout_ops ff_layout_ops = {
 	.notify_types		=
 			NOTIFY_DEVICEID4_DELETE | NOTIFY_DEVICEID4_CHANGE,
@@ -133,4 +140,5 @@ const struct nfsd4_layout_ops ff_layout_ops = {
 	.encode_getdeviceinfo	= nfsd4_ff_encode_getdeviceinfo,
 	.proc_layoutget		= nfsd4_ff_proc_layoutget,
 	.encode_layoutget	= nfsd4_ff_encode_layoutget,
+	.proc_layoutcommit	= nfsd4_ff_proc_layoutcommit,
 };
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index aeb71c10ff1b..f9f7e38cba13 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -54,8 +54,7 @@ nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
 	*p++ = cpu_to_be32(1);			/* single mirror */
 	*p++ = cpu_to_be32(1);			/* single data server */
 
-	p = xdr_encode_opaque_fixed(p, &fl->deviceid,
-			sizeof(struct nfsd4_deviceid));
+	p = svcxdr_encode_deviceid4(p, &fl->deviceid);
 
 	*p++ = cpu_to_be32(1);			/* efficiency */
 
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index aea905fcaf87..683bd1130afe 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -120,7 +120,6 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 
 	id->fsid_idx = fhp->fh_export->ex_devid_map->idx;
 	id->generation = device_generation;
-	id->pad = 0;
 	return 0;
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 75abdd7c6ef8..7ae8e885d753 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2504,7 +2504,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	const struct nfsd4_layout_seg *seg = &lcp->lc_seg;
 	struct svc_fh *current_fh = &cstate->current_fh;
 	const struct nfsd4_layout_ops *ops;
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct inode *inode;
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
@@ -2520,18 +2519,20 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 		goto out;
 	inode = d_inode(current_fh->fh_dentry);
 
-	nfserr = nfserr_inval;
-	if (new_size <= seg->offset) {
-		dprintk("pnfsd: last write before layout segment\n");
-		goto out;
-	}
-	if (new_size > seg->offset + seg->length) {
-		dprintk("pnfsd: last write beyond layout segment\n");
-		goto out;
-	}
-	if (!lcp->lc_newoffset && new_size > i_size_read(inode)) {
-		dprintk("pnfsd: layoutcommit beyond EOF\n");
-		goto out;
+	lcp->lc_size_chg = false;
+	if (lcp->lc_newoffset) {
+		loff_t new_size = lcp->lc_last_wr + 1;
+
+		nfserr = nfserr_inval;
+		if (new_size <= seg->offset)
+			goto out;
+		if (new_size > seg->offset + seg->length)
+			goto out;
+
+		if (new_size > i_size_read(inode)) {
+			lcp->lc_size_chg = true;
+			lcp->lc_newsize = new_size;
+		}
 	}
 
 	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lcp->lc_sid,
@@ -2548,14 +2549,7 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	/* LAYOUTCOMMIT does not require any serialization */
 	mutex_unlock(&ls->ls_mutex);
 
-	if (new_size > i_size_read(inode)) {
-		lcp->lc_size_chg = true;
-		lcp->lc_newsize = new_size;
-	} else {
-		lcp->lc_size_chg = false;
-	}
-
-	nfserr = ops->proc_layoutcommit(inode, lcp);
+	nfserr = ops->proc_layoutcommit(inode, rqstp, lcp);
 	nfs4_put_stid(&ls->ls_stid);
 out:
 	return nfserr;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a00300b28775..89cc970effbc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -588,23 +588,13 @@ nfsd4_decode_state_owner4(struct nfsd4_compoundargs *argp,
 }
 
 #ifdef CONFIG_NFSD_PNFS
-static __be32
-nfsd4_decode_deviceid4(struct nfsd4_compoundargs *argp,
-		       struct nfsd4_deviceid *devid)
-{
-	__be32 *p;
-
-	p = xdr_inline_decode(argp->xdr, NFS4_DEVICEID4_SIZE);
-	if (!p)
-		return nfserr_bad_xdr;
-	memcpy(devid, p, sizeof(*devid));
-	return nfs_ok;
-}
 
 static __be32
 nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
 			   struct nfsd4_layoutcommit *lcp)
 {
+	u32 len;
+
 	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_layout_type) < 0)
 		return nfserr_bad_xdr;
 	if (lcp->lc_layout_type < LAYOUT_NFSV4_1_FILES)
@@ -612,13 +602,10 @@ nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
 	if (lcp->lc_layout_type >= LAYOUT_TYPE_MAX)
 		return nfserr_bad_xdr;
 
-	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_up_len) < 0)
+	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
+		return nfserr_bad_xdr;
+	if (!xdr_stream_subsegment(argp->xdr, &lcp->lc_up_layout, len))
 		return nfserr_bad_xdr;
-	if (lcp->lc_up_len > 0) {
-		lcp->lc_up_layout = xdr_inline_decode(argp->xdr, lcp->lc_up_len);
-		if (!lcp->lc_up_layout)
-			return nfserr_bad_xdr;
-	}
 
 	return nfs_ok;
 }
@@ -1784,7 +1771,7 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 	__be32 status;
 
 	memset(gdev, 0, sizeof(*gdev));
-	status = nfsd4_decode_deviceid4(argp, &gdev->gd_devid);
+	status = nfsd4_decode_deviceid4(argp->xdr, &gdev->gd_devid);
 	if (status)
 		return status;
 	if (xdr_stream_decode_u32(argp->xdr, &gdev->gd_layout_type) < 0)
diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
index 925817f66917..dfd411d1f363 100644
--- a/fs/nfsd/pnfs.h
+++ b/fs/nfsd/pnfs.h
@@ -35,6 +35,7 @@ struct nfsd4_layout_ops {
 			const struct nfsd4_layoutget *lgp);
 
 	__be32 (*proc_layoutcommit)(struct inode *inode,
+			struct svc_rqst *rqstp,
 			struct nfsd4_layoutcommit *lcp);
 
 	void (*fence_client)(struct nfs4_layout_stateid *ls,
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index a23bc56051ca..d4b48602b2b0 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -595,9 +595,43 @@ struct nfsd4_reclaim_complete {
 struct nfsd4_deviceid {
 	u64			fsid_idx;
 	u32			generation;
-	u32			pad;
 };
 
+static inline __be32 *
+svcxdr_encode_deviceid4(__be32 *p, const struct nfsd4_deviceid *devid)
+{
+	__be64 *q = (__be64 *)p;
+
+	*q = (__force __be64)devid->fsid_idx;
+	p += 2;
+	*p++ = (__force __be32)devid->generation;
+	*p++ = xdr_zero;
+	return p;
+}
+
+static inline __be32 *
+svcxdr_decode_deviceid4(__be32 *p, struct nfsd4_deviceid *devid)
+{
+	__be64 *q = (__be64 *)p;
+
+	devid->fsid_idx = (__force u64)(*q);
+	p += 2;
+	devid->generation = (__force u32)(*p++);
+	p++; /* NFSD does not use the remaining octets */
+	return p;
+}
+
+static inline __be32
+nfsd4_decode_deviceid4(struct xdr_stream *xdr, struct nfsd4_deviceid *devid)
+{
+	__be32 *p = xdr_inline_decode(xdr, NFS4_DEVICEID4_SIZE);
+
+	if (unlikely(!p))
+		return nfserr_bad_xdr;
+	svcxdr_decode_deviceid4(p, devid);
+	return nfs_ok;
+}
+
 struct nfsd4_layout_seg {
 	u32			iomode;
 	u64			offset;
@@ -630,8 +664,7 @@ struct nfsd4_layoutcommit {
 	u64			lc_last_wr;	/* request */
 	struct timespec64	lc_mtime;	/* request */
 	u32			lc_layout_type;	/* request */
-	u32			lc_up_len;	/* layout length */
-	void			*lc_up_layout;	/* decoded by callback */
+	struct xdr_buf		lc_up_layout;	/* decoded by callback */
 	bool			lc_size_chg;	/* response */
 	u64			lc_newsize;	/* response */
 };
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 27396fe63f6d..20c92ea58093 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -178,7 +178,7 @@ static int ovl_copy_fileattr(struct inode *inode, const struct path *old,
 	err = ovl_real_fileattr_get(old, &oldfa);
 	if (err) {
 		/* Ntfs-3g returns -EINVAL for "no fileattr support" */
-		if (err == -EOPNOTSUPP || err == -EINVAL)
+		if (err == -ENOTTY || err == -EINVAL)
 			return 0;
 		pr_warn("failed to retrieve lower fileattr (%pd2, err=%i)\n",
 			old->dentry, err);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ecb9f2019395..d4722e1b83bc 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -720,7 +720,10 @@ int ovl_real_fileattr_get(const struct path *realpath, struct file_kattr *fa)
 	if (err)
 		return err;
 
-	return vfs_fileattr_get(realpath->dentry, fa);
+	err = vfs_fileattr_get(realpath->dentry, fa);
+	if (err == -ENOIOCTLCMD)
+		err = -ENOTTY;
+	return err;
 }
 
 int ovl_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 0f0d2dae6283..6b41360631f9 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2431,8 +2431,10 @@ cifs_do_rename(const unsigned int xid, struct dentry *from_dentry,
 	tcon = tlink_tcon(tlink);
 	server = tcon->ses->server;
 
-	if (!server->ops->rename)
-		return -ENOSYS;
+	if (!server->ops->rename) {
+		rc = -ENOSYS;
+		goto do_rename_exit;
+	}
 
 	/* try path-based rename first */
 	rc = server->ops->rename(xid, tcon, from_dentry,
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index dda6dece802a..e10123d8cd7d 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -916,6 +916,14 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 	char *data_end;
 	struct dfs_referral_level_3 *ref;
 
+	if (rsp_size < sizeof(*rsp)) {
+		cifs_dbg(VFS | ONCE,
+			 "%s: header is malformed (size is %u, must be %zu)\n",
+			 __func__, rsp_size, sizeof(*rsp));
+		rc = -EINVAL;
+		goto parse_DFS_referrals_exit;
+	}
+
 	*num_of_nodes = le16_to_cpu(rsp->NumberOfReferrals);
 
 	if (*num_of_nodes < 1) {
@@ -925,6 +933,15 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		goto parse_DFS_referrals_exit;
 	}
 
+	if (sizeof(*rsp) + *num_of_nodes * sizeof(REFERRAL3) > rsp_size) {
+		cifs_dbg(VFS | ONCE,
+			 "%s: malformed buffer (size is %u, must be at least %zu)\n",
+			 __func__, rsp_size,
+			 sizeof(*rsp) + *num_of_nodes * sizeof(REFERRAL3));
+		rc = -EINVAL;
+		goto parse_DFS_referrals_exit;
+	}
+
 	ref = (struct dfs_referral_level_3 *) &(rsp->referrals);
 	if (ref->VersionNumber != cpu_to_le16(3)) {
 		cifs_dbg(VFS, "Referrals of V%d version are not supported, should be V3\n",
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 328fdeecae29..7e86d0ef4b35 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3129,8 +3129,7 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
 	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
 	if (!utf16_path) {
 		rc = -ENOMEM;
-		free_xid(xid);
-		return ERR_PTR(rc);
+		goto put_tlink;
 	}
 
 	oparms = (struct cifs_open_parms) {
@@ -3162,6 +3161,7 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
 		SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 	}
 
+put_tlink:
 	cifs_put_tlink(tlink);
 	free_xid(xid);
 
@@ -3202,8 +3202,7 @@ set_smb2_acl(struct smb_ntsd *pnntsd, __u32 acllen,
 	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
 	if (!utf16_path) {
 		rc = -ENOMEM;
-		free_xid(xid);
-		return rc;
+		goto put_tlink;
 	}
 
 	oparms = (struct cifs_open_parms) {
@@ -3224,6 +3223,7 @@ set_smb2_acl(struct smb_ntsd *pnntsd, __u32 acllen,
 		SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 	}
 
+put_tlink:
 	cifs_put_tlink(tlink);
 	free_xid(xid);
 	return rc;
diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index b36d0676dbe5..00805aed0b07 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -147,14 +147,11 @@ void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id)
 int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id)
 {
 	struct ksmbd_session_rpc *entry;
-	int method;
 
-	down_read(&sess->rpc_lock);
+	lockdep_assert_held(&sess->rpc_lock);
 	entry = xa_load(&sess->rpc_handle_list, id);
-	method = entry ? entry->method : 0;
-	up_read(&sess->rpc_lock);
 
-	return method;
+	return entry ? entry->method : 0;
 }
 
 void ksmbd_session_destroy(struct ksmbd_session *sess)
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index a1db006ab6e9..287200d7c076 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4624,8 +4624,15 @@ static int smb2_get_info_file_pipe(struct ksmbd_session *sess,
 	 * pipe without opening it, checking error condition here
 	 */
 	id = req->VolatileFileId;
-	if (!ksmbd_session_rpc_method(sess, id))
+
+	lockdep_assert_not_held(&sess->rpc_lock);
+
+	down_read(&sess->rpc_lock);
+	if (!ksmbd_session_rpc_method(sess, id)) {
+		up_read(&sess->rpc_lock);
 		return -ENOENT;
+	}
+	up_read(&sess->rpc_lock);
 
 	ksmbd_debug(SMB, "FileInfoClass %u, FileId 0x%llx\n",
 		    req->FileInfoClass, req->VolatileFileId);
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 2aa1b29bea08..46f87fd1ce1c 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -825,6 +825,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_write(struct ksmbd_session *sess, int handle
 	if (!msg)
 		return NULL;
 
+	lockdep_assert_not_held(&sess->rpc_lock);
+
+	down_read(&sess->rpc_lock);
 	msg->type = KSMBD_EVENT_RPC_REQUEST;
 	req = (struct ksmbd_rpc_command *)msg->payload;
 	req->handle = handle;
@@ -833,6 +836,7 @@ struct ksmbd_rpc_command *ksmbd_rpc_write(struct ksmbd_session *sess, int handle
 	req->flags |= KSMBD_RPC_WRITE_METHOD;
 	req->payload_sz = payload_sz;
 	memcpy(req->payload, payload, payload_sz);
+	up_read(&sess->rpc_lock);
 
 	resp = ipc_msg_send_request(msg, req->handle);
 	ipc_msg_free(msg);
@@ -849,6 +853,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_read(struct ksmbd_session *sess, int handle)
 	if (!msg)
 		return NULL;
 
+	lockdep_assert_not_held(&sess->rpc_lock);
+
+	down_read(&sess->rpc_lock);
 	msg->type = KSMBD_EVENT_RPC_REQUEST;
 	req = (struct ksmbd_rpc_command *)msg->payload;
 	req->handle = handle;
@@ -856,6 +863,7 @@ struct ksmbd_rpc_command *ksmbd_rpc_read(struct ksmbd_session *sess, int handle)
 	req->flags |= rpc_context_flags(sess);
 	req->flags |= KSMBD_RPC_READ_METHOD;
 	req->payload_sz = 0;
+	up_read(&sess->rpc_lock);
 
 	resp = ipc_msg_send_request(msg, req->handle);
 	ipc_msg_free(msg);
@@ -876,6 +884,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_ioctl(struct ksmbd_session *sess, int handle
 	if (!msg)
 		return NULL;
 
+	lockdep_assert_not_held(&sess->rpc_lock);
+
+	down_read(&sess->rpc_lock);
 	msg->type = KSMBD_EVENT_RPC_REQUEST;
 	req = (struct ksmbd_rpc_command *)msg->payload;
 	req->handle = handle;
@@ -884,6 +895,7 @@ struct ksmbd_rpc_command *ksmbd_rpc_ioctl(struct ksmbd_session *sess, int handle
 	req->flags |= KSMBD_RPC_IOCTL_METHOD;
 	req->payload_sz = payload_sz;
 	memcpy(req->payload, payload, payload_sz);
+	up_read(&sess->rpc_lock);
 
 	resp = ipc_msg_send_request(msg, req->handle);
 	ipc_msg_free(msg);
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 0d637c276db0..942c490f23e4 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -174,12 +174,40 @@ typedef struct xlog_rec_header {
 	__be32	  h_prev_block; /* block number to previous LR		:  4 */
 	__be32	  h_num_logops;	/* number of log operations in this LR	:  4 */
 	__be32	  h_cycle_data[XLOG_HEADER_CYCLE_SIZE / BBSIZE];
-	/* new fields */
+
+	/* fields added by the Linux port: */
 	__be32    h_fmt;        /* format of log record                 :  4 */
 	uuid_t	  h_fs_uuid;    /* uuid of FS                           : 16 */
+
+	/* fields added for log v2: */
 	__be32	  h_size;	/* iclog size				:  4 */
+
+	/*
+	 * When h_size added for log v2 support, it caused structure to have
+	 * a different size on i386 vs all other architectures because the
+	 * sum of the size ofthe  member is not aligned by that of the largest
+	 * __be64-sized member, and i386 has really odd struct alignment rules.
+	 *
+	 * Due to the way the log headers are placed out on-disk that alone is
+	 * not a problem becaue the xlog_rec_header always sits alone in a
+	 * BBSIZEs area, and the rest of that area is padded with zeroes.
+	 * But xlog_cksum used to calculate the checksum based on the structure
+	 * size, and thus gives different checksums for i386 vs the rest.
+	 * We now do two checksum validation passes for both sizes to allow
+	 * moving v5 file systems with unclean logs between i386 and other
+	 * (little-endian) architectures.
+	 */
+	__u32	  h_pad0;
 } xlog_rec_header_t;
 
+#ifdef __i386__
+#define XLOG_REC_SIZE		offsetofend(struct xlog_rec_header, h_size)
+#define XLOG_REC_SIZE_OTHER	sizeof(struct xlog_rec_header)
+#else
+#define XLOG_REC_SIZE		sizeof(struct xlog_rec_header)
+#define XLOG_REC_SIZE_OTHER	offsetofend(struct xlog_rec_header, h_size)
+#endif /* __i386__ */
+
 typedef struct xlog_rec_ext_header {
 	__be32	  xh_cycle;	/* write cycle of log			: 4 */
 	__be32	  xh_cycle_data[XLOG_HEADER_CYCLE_SIZE / BBSIZE]; /*	: 256 */
diff --git a/fs/xfs/libxfs/xfs_ondisk.h b/fs/xfs/libxfs/xfs_ondisk.h
index 5ed44fdf7491..7bfa3242e2c5 100644
--- a/fs/xfs/libxfs/xfs_ondisk.h
+++ b/fs/xfs/libxfs/xfs_ondisk.h
@@ -174,6 +174,8 @@ xfs_check_ondisk_structs(void)
 	XFS_CHECK_STRUCT_SIZE(struct xfs_rud_log_format,	16);
 	XFS_CHECK_STRUCT_SIZE(struct xfs_map_extent,		32);
 	XFS_CHECK_STRUCT_SIZE(struct xfs_phys_extent,		16);
+	XFS_CHECK_STRUCT_SIZE(struct xlog_rec_header,		328);
+	XFS_CHECK_STRUCT_SIZE(struct xlog_rec_ext_header,	260);
 
 	XFS_CHECK_OFFSET(struct xfs_bui_log_format, bui_extents,	16);
 	XFS_CHECK_OFFSET(struct xfs_cui_log_format, cui_extents,	16);
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index c8a57e21a1d3..69703dc3ef94 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1568,13 +1568,13 @@ xlog_cksum(
 	struct xlog		*log,
 	struct xlog_rec_header	*rhead,
 	char			*dp,
-	int			size)
+	unsigned int		hdrsize,
+	unsigned int		size)
 {
 	uint32_t		crc;
 
 	/* first generate the crc for the record header ... */
-	crc = xfs_start_cksum_update((char *)rhead,
-			      sizeof(struct xlog_rec_header),
+	crc = xfs_start_cksum_update((char *)rhead, hdrsize,
 			      offsetof(struct xlog_rec_header, h_crc));
 
 	/* ... then for additional cycle data for v2 logs ... */
@@ -1818,7 +1818,7 @@ xlog_sync(
 
 	/* calculcate the checksum */
 	iclog->ic_header.h_crc = xlog_cksum(log, &iclog->ic_header,
-					    iclog->ic_datap, size);
+			iclog->ic_datap, XLOG_REC_SIZE, size);
 	/*
 	 * Intentionally corrupt the log record CRC based on the error injection
 	 * frequency, if defined. This facilitates testing log recovery in the
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index a9a7a271c15b..0cfc654d8e87 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -499,8 +499,8 @@ xlog_recover_finish(
 extern void
 xlog_recover_cancel(struct xlog *);
 
-extern __le32	 xlog_cksum(struct xlog *log, struct xlog_rec_header *rhead,
-			    char *dp, int size);
+__le32	 xlog_cksum(struct xlog *log, struct xlog_rec_header *rhead,
+		char *dp, unsigned int hdrsize, unsigned int size);
 
 extern struct kmem_cache *xfs_log_ticket_cache;
 struct xlog_ticket *xlog_ticket_alloc(struct xlog *log, int unit_bytes,
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index e6ed9e09c027..549d60959aee 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2894,20 +2894,34 @@ xlog_recover_process(
 	int			pass,
 	struct list_head	*buffer_list)
 {
-	__le32			old_crc = rhead->h_crc;
-	__le32			crc;
+	__le32			expected_crc = rhead->h_crc, crc, other_crc;
 
-	crc = xlog_cksum(log, rhead, dp, be32_to_cpu(rhead->h_len));
+	crc = xlog_cksum(log, rhead, dp, XLOG_REC_SIZE,
+			be32_to_cpu(rhead->h_len));
+
+	/*
+	 * Look at the end of the struct xlog_rec_header definition in
+	 * xfs_log_format.h for the glory details.
+	 */
+	if (expected_crc && crc != expected_crc) {
+		other_crc = xlog_cksum(log, rhead, dp, XLOG_REC_SIZE_OTHER,
+				be32_to_cpu(rhead->h_len));
+		if (other_crc == expected_crc) {
+			xfs_notice_once(log->l_mp,
+	"Fixing up incorrect CRC due to padding.");
+			crc = other_crc;
+		}
+	}
 
 	/*
 	 * Nothing else to do if this is a CRC verification pass. Just return
 	 * if this a record with a non-zero crc. Unfortunately, mkfs always
-	 * sets old_crc to 0 so we must consider this valid even on v5 supers.
-	 * Otherwise, return EFSBADCRC on failure so the callers up the stack
-	 * know precisely what failed.
+	 * sets expected_crc to 0 so we must consider this valid even on v5
+	 * supers.  Otherwise, return EFSBADCRC on failure so the callers up the
+	 * stack know precisely what failed.
 	 */
 	if (pass == XLOG_RECOVER_CRCPASS) {
-		if (old_crc && crc != old_crc)
+		if (expected_crc && crc != expected_crc)
 			return -EFSBADCRC;
 		return 0;
 	}
@@ -2918,11 +2932,11 @@ xlog_recover_process(
 	 * zero CRC check prevents warnings from being emitted when upgrading
 	 * the kernel from one that does not add CRCs by default.
 	 */
-	if (crc != old_crc) {
-		if (old_crc || xfs_has_crc(log->l_mp)) {
+	if (crc != expected_crc) {
+		if (expected_crc || xfs_has_crc(log->l_mp)) {
 			xfs_alert(log->l_mp,
 		"log record CRC mismatch: found 0x%x, expected 0x%x.",
-					le32_to_cpu(old_crc),
+					le32_to_cpu(expected_crc),
 					le32_to_cpu(crc));
 			xfs_hex_dump(dp, 32);
 		}
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 15c35655f482..115a964f3006 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -137,6 +137,7 @@
 
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC			0x07
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_WIRESPEED_EN	0x0010
+#define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD		0x0060
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_EN	0x0080
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN	0x0100
 #define MII_BCM54XX_AUXCTL_MISC_FORCE_AMDIX		0x0200
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0620dd67369f..87a0d956f0db 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1594,6 +1594,12 @@ do {								\
 #define ata_dev_dbg(dev, fmt, ...)				\
 	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__)
 
+#define ata_dev_warn_once(dev, fmt, ...)			\
+	pr_warn_once("ata%u.%02u: " fmt,			\
+		     (dev)->link->ap->print_id,			\
+		     (dev)->link->pmp + (dev)->devno,		\
+		     ##__VA_ARGS__)
+
 static inline void ata_print_version_once(const struct device *dev,
 					  const char *version)
 {
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 317ae31e89b3..b02876f1ae38 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -418,6 +418,12 @@ static inline int hibernate_quiet_exec(int (*func)(void *data), void *data) {
 }
 #endif /* CONFIG_HIBERNATION */
 
+#if defined(CONFIG_HIBERNATION) && defined(CONFIG_SUSPEND)
+bool pm_hibernation_mode_is_suspend(void);
+#else
+static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
+#endif
+
 int arch_resume_nosmt(void);
 
 #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 0f28c5512fcb..3aaf19e77558 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -15,6 +15,7 @@
 #ifndef __LINUX_USB_GADGET_H
 #define __LINUX_USB_GADGET_H
 
+#include <linux/cleanup.h>
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -32,6 +33,7 @@ struct usb_ep;
 
 /**
  * struct usb_request - describes one i/o request
+ * @ep: The associated endpoint set by usb_ep_alloc_request().
  * @buf: Buffer used for data.  Always provide this; some controllers
  *	only use PIO, or don't use DMA for some endpoints.
  * @dma: DMA address corresponding to 'buf'.  If you don't set this
@@ -98,6 +100,7 @@ struct usb_ep;
  */
 
 struct usb_request {
+	struct usb_ep		*ep;
 	void			*buf;
 	unsigned		length;
 	dma_addr_t		dma;
@@ -291,6 +294,28 @@ static inline void usb_ep_fifo_flush(struct usb_ep *ep)
 
 /*-------------------------------------------------------------------------*/
 
+/**
+ * free_usb_request - frees a usb_request object and its buffer
+ * @req: the request being freed
+ *
+ * This helper function frees both the request's buffer and the request object
+ * itself by calling usb_ep_free_request(). Its signature is designed to be used
+ * with DEFINE_FREE() to enable automatic, scope-based cleanup for usb_request
+ * pointers.
+ */
+static inline void free_usb_request(struct usb_request *req)
+{
+	if (!req)
+		return;
+
+	kfree(req->buf);
+	usb_ep_free_request(req->ep, req);
+}
+
+DEFINE_FREE(free_usb_request, struct usb_request *, free_usb_request(_T))
+
+/*-------------------------------------------------------------------------*/
+
 struct usb_dcd_config_params {
 	__u8  bU1devExitLat;	/* U1 Device exit Latency */
 #define USB_DEFAULT_U1_DEV_EXIT_LAT	0x01	/* Less then 1 microsec */
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 8cf1380f3656..63154c8faecc 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -609,6 +609,21 @@ struct metadata_dst *iptunnel_metadata_reply(struct metadata_dst *md,
 int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_dst,
 			  int headroom, bool reply);
 
+static inline void ip_tunnel_adj_headroom(struct net_device *dev,
+					  unsigned int headroom)
+{
+	/* we must cap headroom to some upperlimit, else pskb_expand_head
+	 * will overflow header offsets in skb_headers_offset_update().
+	 */
+	const unsigned int max_allowed = 512;
+
+	if (headroom > max_allowed)
+		headroom = max_allowed;
+
+	if (headroom > READ_ONCE(dev->needed_headroom))
+		WRITE_ONCE(dev->needed_headroom, headroom);
+}
+
 int iptunnel_handle_offloads(struct sk_buff *skb, int gso_type_mask);
 
 static inline int iptunnel_pull_offloads(struct sk_buff *skb)
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index bdedbaccf776..0b3827cd6f4a 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1497,27 +1497,6 @@ struct drm_amdgpu_info_hw_ip {
 	__u32  userq_num_slots;
 };
 
-/* GFX metadata BO sizes and alignment info (in bytes) */
-struct drm_amdgpu_info_uq_fw_areas_gfx {
-	/* shadow area size */
-	__u32 shadow_size;
-	/* shadow area base virtual mem alignment */
-	__u32 shadow_alignment;
-	/* context save area size */
-	__u32 csa_size;
-	/* context save area base virtual mem alignment */
-	__u32 csa_alignment;
-};
-
-/* IP specific fw related information used in the
- * subquery AMDGPU_INFO_UQ_FW_AREAS
- */
-struct drm_amdgpu_info_uq_fw_areas {
-	union {
-		struct drm_amdgpu_info_uq_fw_areas_gfx gfx;
-	};
-};
-
 struct drm_amdgpu_info_num_handles {
 	/** Max handles as supported by firmware for UVD */
 	__u32  uvd_max_handles;
diff --git a/io_uring/register.c b/io_uring/register.c
index a59589249fce..b1772a470bf6 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -618,6 +618,7 @@ static int io_register_mem_region(struct io_ring_ctx *ctx, void __user *uarg)
 	if (ret)
 		return ret;
 	if (copy_to_user(rd_uptr, &rd, sizeof(rd))) {
+		guard(mutex)(&ctx->mmap_lock);
 		io_free_region(ctx, &ctx->param_region);
 		return -EFAULT;
 	}
diff --git a/io_uring/rw.c b/io_uring/rw.c
index af5a54b5db12..b998d945410b 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -540,7 +540,7 @@ static void __io_complete_rw_common(struct io_kiocb *req, long res)
 {
 	if (res == req->cqe.res)
 		return;
-	if (res == -EAGAIN && io_rw_should_reissue(req)) {
+	if ((res == -EOPNOTSUPP || res == -EAGAIN) && io_rw_should_reissue(req)) {
 		req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
 	} else {
 		req_set_fail(req);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 820127536e62..6e9427c4aaff 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9390,7 +9390,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 		flags |= MAP_HUGETLB;
 
 	if (file) {
-		struct inode *inode;
+		const struct inode *inode;
 		dev_t dev;
 
 		buf = kmalloc(PATH_MAX, GFP_KERNEL);
@@ -9403,12 +9403,12 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 		 * need to add enough zero bytes after the string to handle
 		 * the 64bit alignment we do later.
 		 */
-		name = file_path(file, buf, PATH_MAX - sizeof(u64));
+		name = d_path(file_user_path(file), buf, PATH_MAX - sizeof(u64));
 		if (IS_ERR(name)) {
 			name = "//toolong";
 			goto cpy_name;
 		}
-		inode = file_inode(vma->vm_file);
+		inode = file_user_inode(vma->vm_file);
 		dev = inode->i_sb->s_dev;
 		ino = inode->i_ino;
 		gen = inode->i_generation;
@@ -9479,7 +9479,7 @@ static bool perf_addr_filter_match(struct perf_addr_filter *filter,
 	if (!filter->path.dentry)
 		return false;
 
-	if (d_inode(filter->path.dentry) != file_inode(file))
+	if (d_inode(filter->path.dentry) != file_user_inode(file))
 		return false;
 
 	if (filter->offset > offset + size)
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 26e0e662e8f2..728328c51b64 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -80,6 +80,17 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 static atomic_t hibernate_atomic = ATOMIC_INIT(1);
 
+#ifdef CONFIG_SUSPEND
+/**
+ * pm_hibernation_mode_is_suspend - Check if hibernation has been set to suspend
+ */
+bool pm_hibernation_mode_is_suspend(void)
+{
+	return hibernation_mode == HIBERNATION_SUSPEND;
+}
+EXPORT_SYMBOL_GPL(pm_hibernation_mode_is_suspend);
+#endif
+
 bool hibernate_acquire(void)
 {
 	return atomic_add_unless(&hibernate_atomic, -1, 0);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ccba6fc3c3fe..8575d67cbf73 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8603,10 +8603,12 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
 	if (rq->nr_running != 1 || rq_has_pinned_tasks(rq)) {
 		WARN(true, "Dying CPU not properly vacated!");
 		dump_rq_tasks(rq, KERN_WARNING);
 	}
+	dl_server_stop(&rq->fair_server);
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 615411a0a881..7b7671060bf9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1582,6 +1582,9 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_server(dl_se) || dl_se->dl_server_active)
 		return;
 
+	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
+		return;
+
 	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8ce56a8d507f..8f0b1acace0a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8829,21 +8829,21 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	return p;
 
 idle:
-	if (!rf)
-		return NULL;
-
-	new_tasks = sched_balance_newidle(rq, rf);
+	if (rf) {
+		new_tasks = sched_balance_newidle(rq, rf);
 
-	/*
-	 * Because sched_balance_newidle() releases (and re-acquires) rq->lock, it is
-	 * possible for any higher priority task to appear. In that case we
-	 * must re-start the pick_next_entity() loop.
-	 */
-	if (new_tasks < 0)
-		return RETRY_TASK;
+		/*
+		 * Because sched_balance_newidle() releases (and re-acquires)
+		 * rq->lock, it is possible for any higher priority task to
+		 * appear. In that case we must re-start the pick_next_entity()
+		 * loop.
+		 */
+		if (new_tasks < 0)
+			return RETRY_TASK;
 
-	if (new_tasks > 0)
-		goto again;
+		if (new_tasks > 0)
+			goto again;
+	}
 
 	/*
 	 * rq is about to be idle, check if we need to update the
diff --git a/mm/slub.c b/mm/slub.c
index 9bdadf9909e0..16b5e221c94d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2073,8 +2073,15 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	struct slabobj_ext *obj_exts;
 
 	obj_exts = slab_obj_exts(slab);
-	if (!obj_exts)
+	if (!obj_exts) {
+		/*
+		 * If obj_exts allocation failed, slab->obj_exts is set to
+		 * OBJEXTS_ALLOC_FAIL. In this case, we end up here and should
+		 * clear the flag.
+		 */
+		slab->obj_exts = 0;
 		return;
+	}
 
 	/*
 	 * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 3706a872ecaf..a93af55df5fd 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -378,6 +378,8 @@ static int j1939_netdev_notify(struct notifier_block *nb,
 		j1939_ecu_unmap_all(priv);
 		break;
 	case NETDEV_UNREGISTER:
+		j1939_cancel_active_session(priv, NULL);
+		j1939_sk_netdev_event_netdown(priv);
 		j1939_sk_netdev_event_unregister(priv);
 		break;
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index 8d49b2198d07..5194b70769cc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12088,6 +12088,35 @@ static void dev_memory_provider_uninstall(struct net_device *dev)
 	}
 }
 
+/* devices must be UP and netdev_lock()'d */
+static void netif_close_many_and_unlock(struct list_head *close_head)
+{
+	struct net_device *dev, *tmp;
+
+	netif_close_many(close_head, false);
+
+	/* ... now unlock them */
+	list_for_each_entry_safe(dev, tmp, close_head, close_list) {
+		netdev_unlock(dev);
+		list_del_init(&dev->close_list);
+	}
+}
+
+static void netif_close_many_and_unlock_cond(struct list_head *close_head)
+{
+#ifdef CONFIG_LOCKDEP
+	/* We can only track up to MAX_LOCK_DEPTH locks per task.
+	 *
+	 * Reserve half the available slots for additional locks possibly
+	 * taken by notifiers and (soft)irqs.
+	 */
+	unsigned int limit = MAX_LOCK_DEPTH / 2;
+
+	if (lockdep_depth(current) > limit)
+		netif_close_many_and_unlock(close_head);
+#endif
+}
+
 void unregister_netdevice_many_notify(struct list_head *head,
 				      u32 portid, const struct nlmsghdr *nlh)
 {
@@ -12120,17 +12149,18 @@ void unregister_netdevice_many_notify(struct list_head *head,
 
 	/* If device is running, close it first. Start with ops locked... */
 	list_for_each_entry(dev, head, unreg_list) {
+		if (!(dev->flags & IFF_UP))
+			continue;
 		if (netdev_need_ops_lock(dev)) {
 			list_add_tail(&dev->close_list, &close_head);
 			netdev_lock(dev);
 		}
+		netif_close_many_and_unlock_cond(&close_head);
 	}
-	netif_close_many(&close_head, true);
-	/* ... now unlock them and go over the rest. */
+	netif_close_many_and_unlock(&close_head);
+	/* ... now go over the rest. */
 	list_for_each_entry(dev, head, unreg_list) {
-		if (netdev_need_ops_lock(dev))
-			netdev_unlock(dev);
-		else
+		if (!netdev_need_ops_lock(dev))
 			list_add_tail(&dev->close_list, &close_head);
 	}
 	netif_close_many(&close_head, true);
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index aaeb5d16f0c9..158a30ae7c5f 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -568,20 +568,6 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 	return 0;
 }
 
-static void ip_tunnel_adj_headroom(struct net_device *dev, unsigned int headroom)
-{
-	/* we must cap headroom to some upperlimit, else pskb_expand_head
-	 * will overflow header offsets in skb_headers_offset_update().
-	 */
-	static const unsigned int max_allowed = 512;
-
-	if (headroom > max_allowed)
-		headroom = max_allowed;
-
-	if (headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, headroom);
-}
-
 void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		       u8 proto, int tunnel_hlen)
 {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index caf11920a878..16251d8e1b59 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2219,7 +2219,8 @@ static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 				 u32 max_segs)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
-	u32 send_win, cong_win, limit, in_flight;
+	u32 send_win, cong_win, limit, in_flight, threshold;
+	u64 srtt_in_ns, expected_ack, how_far_is_the_ack;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct sk_buff *head;
 	int win_divisor;
@@ -2281,9 +2282,19 @@ static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 	head = tcp_rtx_queue_head(sk);
 	if (!head)
 		goto send_now;
-	delta = tp->tcp_clock_cache - head->tstamp;
-	/* If next ACK is likely to come too late (half srtt), do not defer */
-	if ((s64)(delta - (u64)NSEC_PER_USEC * (tp->srtt_us >> 4)) < 0)
+
+	srtt_in_ns = (u64)(NSEC_PER_USEC >> 3) * tp->srtt_us;
+	/* When is the ACK expected ? */
+	expected_ack = head->tstamp + srtt_in_ns;
+	/* How far from now is the ACK expected ? */
+	how_far_is_the_ack = expected_ack - tp->tcp_clock_cache;
+
+	/* If next ACK is likely to come too late,
+	 * ie in more than min(1ms, half srtt), do not defer.
+	 */
+	threshold = min(srtt_in_ns >> 1, NSEC_PER_MSEC);
+
+	if ((s64)(how_far_is_the_ack - threshold) > 0)
 		goto send_now;
 
 	/* Ok, it looks like it is advisable to defer.
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 3262e81223df..6405072050e0 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1257,8 +1257,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	 */
 	max_headroom = LL_RESERVED_SPACE(tdev) + sizeof(struct ipv6hdr)
 			+ dst->header_len + t->hlen;
-	if (max_headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, max_headroom);
+	ip_tunnel_adj_headroom(dev, max_headroom);
 
 	err = ip6_tnl_encap(skb, t, &proto, fl6);
 	if (err)
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index a3ccb3135e51..39a2ab47fe72 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -255,12 +255,9 @@ int tls_process_cmsg(struct sock *sk, struct msghdr *msg,
 			if (msg->msg_flags & MSG_MORE)
 				return -EINVAL;
 
-			rc = tls_handle_open_record(sk, msg->msg_flags);
-			if (rc)
-				return rc;
-
 			*record_type = *(unsigned char *)CMSG_DATA(cmsg);
-			rc = 0;
+
+			rc = tls_handle_open_record(sk, msg->msg_flags);
 			break;
 		default:
 			return -EINVAL;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index daac9fd4be7e..d17135369980 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1054,7 +1054,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 			if (ret == -EINPROGRESS)
 				num_async++;
 			else if (ret != -EAGAIN)
-				goto send_end;
+				goto end;
 		}
 	}
 
@@ -1112,8 +1112,11 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 				goto send_end;
 			tls_ctx->pending_open_record_frags = true;
 
-			if (sk_msg_full(msg_pl))
+			if (sk_msg_full(msg_pl)) {
 				full_record = true;
+				sk_msg_trim(sk, msg_en,
+					    msg_pl->sg.size + prot->overhead_size);
+			}
 
 			if (full_record || eor)
 				goto copied;
@@ -1149,6 +1152,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 				} else if (ret != -EAGAIN)
 					goto send_end;
 			}
+
+			/* Transmit if any encryptions have completed */
+			if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
+				cancel_delayed_work(&ctx->tx_work.work);
+				tls_tx_records(sk, msg->msg_flags);
+			}
+
 			continue;
 rollback_iter:
 			copied -= try_to_copy;
@@ -1204,6 +1214,12 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 					goto send_end;
 				}
 			}
+
+			/* Transmit if any encryptions have completed */
+			if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
+				cancel_delayed_work(&ctx->tx_work.work);
+				tls_tx_records(sk, msg->msg_flags);
+			}
 		}
 
 		continue;
@@ -1223,8 +1239,9 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 			goto alloc_encrypted;
 	}
 
+send_end:
 	if (!num_async) {
-		goto send_end;
+		goto end;
 	} else if (num_zc || eor) {
 		int err;
 
@@ -1242,7 +1259,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		tls_tx_records(sk, msg->msg_flags);
 	}
 
-send_end:
+end:
 	ret = sk_stream_error(sk, msg->msg_flags, ret);
 	return copied > 0 ? copied : ret;
 }
@@ -1637,8 +1654,10 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 
 	if (unlikely(darg->async)) {
 		err = tls_strp_msg_hold(&ctx->strp, &ctx->async_hold);
-		if (err)
-			__skb_queue_tail(&ctx->async_hold, darg->skb);
+		if (err) {
+			err = tls_decrypt_async_wait(ctx);
+			darg->async = false;
+		}
 		return err;
 	}
 
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index b762ecdc22b0..cb15f612028e 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -39,8 +39,7 @@
 const CPUFREQ_NAME_LEN: usize = bindings::CPUFREQ_NAME_LEN as usize;
 
 /// Default transition latency value in nanoseconds.
-pub const DEFAULT_TRANSITION_LATENCY_NS: u32 =
-        bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
+pub const DEFAULT_TRANSITION_LATENCY_NS: u32 = bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 /// CPU frequency driver flags.
 pub mod flags {
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 775db3fc4959..ec10270c2cce 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -32,7 +32,7 @@
  *	allows 5 times as large as IEC 61883-6 defines.
  * @CIP_HEADER_WITHOUT_EOH: Only for in-stream. CIP Header doesn't include
  *	valid EOH.
- * @CIP_NO_HEADERS: a lack of headers in packets
+ * @CIP_NO_HEADER: a lack of headers in packets
  * @CIP_UNALIGHED_DBC: Only for in-stream. The value of dbc is not alighed to
  *	the value of current SYT_INTERVAL; e.g. initial value is not zero.
  * @CIP_UNAWARE_SYT: For outgoing packet, the value in SYT field of CIP is 0xffff.
diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 07ea76efa5de..8fb1a5c6ff6d 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6390,6 +6390,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x854a, "HP EliteBook 830 G6", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x85c6, "HP Pavilion x360 Convertible 14-dy1xxx", ALC295_FIXUP_HP_MUTE_LED_COEFBIT11),
 	SND_PCI_QUIRK(0x103c, 0x85de, "HP Envy x360 13-ar0xxx", ALC285_FIXUP_HP_ENVY_X360),
+	SND_PCI_QUIRK(0x103c, 0x860c, "HP ZBook 17 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index 37f2cdc8ce82..0ef77fae0402 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1426,6 +1426,8 @@ static int cs35l41_get_acpi_mute_state(struct cs35l41_hda *cs35l41, acpi_handle
 
 	if (cs35l41_dsm_supported(handle, CS35L41_DSM_GET_MUTE)) {
 		ret = acpi_evaluate_dsm(handle, &guid, 0, CS35L41_DSM_GET_MUTE, NULL);
+		if (!ret)
+			return -EINVAL;
 		mute = *ret->buffer.pointer;
 		dev_dbg(cs35l41->dev, "CS35L41_DSM_GET_MUTE: %d\n", mute);
 	}
diff --git a/sound/hda/codecs/side-codecs/hda_component.c b/sound/hda/codecs/side-codecs/hda_component.c
index 71860e2d6377..dd96994b1cf8 100644
--- a/sound/hda/codecs/side-codecs/hda_component.c
+++ b/sound/hda/codecs/side-codecs/hda_component.c
@@ -181,6 +181,10 @@ int hda_component_manager_init(struct hda_codec *cdc,
 		sm->match_str = match_str;
 		sm->index = i;
 		component_match_add(dev, &match, hda_comp_match_dev_name, sm);
+		if (IS_ERR(match)) {
+			codec_err(cdc, "Fail to add component %ld\n", PTR_ERR(match));
+			return PTR_ERR(match);
+		}
 	}
 
 	ret = component_master_add_with_match(dev, ops, match);
diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index 1bb3ff55b115..9e37586e3e0a 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -2077,6 +2077,7 @@ static const struct pci_device_id driver_denylist[] = {
 	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1043, 0x874f) }, /* ASUS ROG Zenith II / Strix */
 	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb59) }, /* MSI TRX40 Creator */
 	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb60) }, /* MSI TRX40 */
+	{ PCI_DEVICE_SUB(0x1022, 0x15e3, 0x1462, 0xee59) }, /* MSI X870E Tomahawk WiFi */
 	{}
 };
 
diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 91d72d4bb9a2..d055582a3bf1 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -176,9 +176,9 @@ static int create_sdw_dailink(struct snd_soc_card *card,
 			cpus->dai_name = devm_kasprintf(dev, GFP_KERNEL,
 							"SDW%d Pin%d",
 							link_num, cpu_pin_id);
-			dev_dbg(dev, "cpu->dai_name:%s\n", cpus->dai_name);
 			if (!cpus->dai_name)
 				return -ENOMEM;
+			dev_dbg(dev, "cpu->dai_name:%s\n", cpus->dai_name);
 
 			codec_maps[j].cpu = 0;
 			codec_maps[j].codec = j;
diff --git a/sound/soc/codecs/idt821034.c b/sound/soc/codecs/idt821034.c
index a03d4e5e7d14..cab2f2eecdfb 100644
--- a/sound/soc/codecs/idt821034.c
+++ b/sound/soc/codecs/idt821034.c
@@ -548,14 +548,14 @@ static int idt821034_kctrl_mute_put(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
-static const DECLARE_TLV_DB_LINEAR(idt821034_gain_in, -6520, 1306);
-#define IDT821034_GAIN_IN_MIN_RAW	1 /* -65.20 dB -> 10^(-65.2/20.0) * 1820 = 1 */
-#define IDT821034_GAIN_IN_MAX_RAW	8191 /* 13.06 dB -> 10^(13.06/20.0) * 1820 = 8191 */
+static const DECLARE_TLV_DB_LINEAR(idt821034_gain_in, -300, 1300);
+#define IDT821034_GAIN_IN_MIN_RAW	1288 /* -3.0 dB -> 10^(-3.0/20.0) * 1820 = 1288 */
+#define IDT821034_GAIN_IN_MAX_RAW	8130 /* 13.0 dB -> 10^(13.0/20.0) * 1820 = 8130 */
 #define IDT821034_GAIN_IN_INIT_RAW	1820 /* 0dB -> 10^(0/20) * 1820 = 1820 */
 
-static const DECLARE_TLV_DB_LINEAR(idt821034_gain_out, -6798, 1029);
-#define IDT821034_GAIN_OUT_MIN_RAW	1 /* -67.98 dB -> 10^(-67.98/20.0) * 2506 = 1*/
-#define IDT821034_GAIN_OUT_MAX_RAW	8191 /* 10.29 dB -> 10^(10.29/20.0) * 2506 = 8191 */
+static const DECLARE_TLV_DB_LINEAR(idt821034_gain_out, -1300, 300);
+#define IDT821034_GAIN_OUT_MIN_RAW	561 /* -13.0 dB -> 10^(-13.0/20.0) * 2506 = 561 */
+#define IDT821034_GAIN_OUT_MAX_RAW	3540 /* 3.0 dB -> 10^(3.0/20.0) * 2506 = 3540 */
 #define IDT821034_GAIN_OUT_INIT_RAW	2506 /* 0dB -> 10^(0/20) * 2506 = 2506 */
 
 static const struct snd_kcontrol_new idt821034_controls[] = {
diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index edb95f869a4a..a8ff2ce70be9 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -26,7 +26,8 @@
 #include <sound/tlv.h>
 #include "nau8821.h"
 
-#define NAU8821_JD_ACTIVE_HIGH			BIT(0)
+#define NAU8821_QUIRK_JD_ACTIVE_HIGH			BIT(0)
+#define NAU8821_QUIRK_JD_DB_BYPASS			BIT(1)
 
 static int nau8821_quirk;
 static int quirk_override = -1;
@@ -1021,12 +1022,17 @@ static bool nau8821_is_jack_inserted(struct regmap *regmap)
 	return active_high == is_high;
 }
 
-static void nau8821_int_status_clear_all(struct regmap *regmap)
+static void nau8821_irq_status_clear(struct regmap *regmap, int active_irq)
 {
-	int active_irq, clear_irq, i;
+	int clear_irq, i;
 
-	/* Reset the intrruption status from rightmost bit if the corres-
-	 * ponding irq event occurs.
+	if (active_irq) {
+		regmap_write(regmap, NAU8821_R11_INT_CLR_KEY_STATUS, active_irq);
+		return;
+	}
+
+	/* Reset the interruption status from rightmost bit if the
+	 * corresponding irq event occurs.
 	 */
 	regmap_read(regmap, NAU8821_R10_IRQ_STATUS, &active_irq);
 	for (i = 0; i < NAU8821_REG_DATA_LEN; i++) {
@@ -1052,20 +1058,24 @@ static void nau8821_eject_jack(struct nau8821 *nau8821)
 	snd_soc_component_disable_pin(component, "MICBIAS");
 	snd_soc_dapm_sync(dapm);
 
+	/* Disable & mask both insertion & ejection IRQs */
+	regmap_update_bits(regmap, NAU8821_R12_INTERRUPT_DIS_CTRL,
+			   NAU8821_IRQ_INSERT_DIS | NAU8821_IRQ_EJECT_DIS,
+			   NAU8821_IRQ_INSERT_DIS | NAU8821_IRQ_EJECT_DIS);
+	regmap_update_bits(regmap, NAU8821_R0F_INTERRUPT_MASK,
+			   NAU8821_IRQ_INSERT_EN | NAU8821_IRQ_EJECT_EN,
+			   NAU8821_IRQ_INSERT_EN | NAU8821_IRQ_EJECT_EN);
+
 	/* Clear all interruption status */
-	nau8821_int_status_clear_all(regmap);
+	nau8821_irq_status_clear(regmap, 0);
 
-	/* Enable the insertion interruption, disable the ejection inter-
-	 * ruption, and then bypass de-bounce circuit.
-	 */
+	/* Enable & unmask the insertion IRQ */
 	regmap_update_bits(regmap, NAU8821_R12_INTERRUPT_DIS_CTRL,
-		NAU8821_IRQ_EJECT_DIS | NAU8821_IRQ_INSERT_DIS,
-		NAU8821_IRQ_EJECT_DIS);
-	/* Mask unneeded IRQs: 1 - disable, 0 - enable */
+			   NAU8821_IRQ_INSERT_DIS, 0);
 	regmap_update_bits(regmap, NAU8821_R0F_INTERRUPT_MASK,
-		NAU8821_IRQ_EJECT_EN | NAU8821_IRQ_INSERT_EN,
-		NAU8821_IRQ_EJECT_EN);
+			   NAU8821_IRQ_INSERT_EN, 0);
 
+	/* Bypass de-bounce circuit */
 	regmap_update_bits(regmap, NAU8821_R0D_JACK_DET_CTRL,
 		NAU8821_JACK_DET_DB_BYPASS, NAU8821_JACK_DET_DB_BYPASS);
 
@@ -1089,7 +1099,6 @@ static void nau8821_eject_jack(struct nau8821 *nau8821)
 			NAU8821_IRQ_KEY_RELEASE_DIS |
 			NAU8821_IRQ_KEY_PRESS_DIS);
 	}
-
 }
 
 static void nau8821_jdet_work(struct work_struct *work)
@@ -1146,6 +1155,15 @@ static void nau8821_setup_inserted_irq(struct nau8821 *nau8821)
 {
 	struct regmap *regmap = nau8821->regmap;
 
+	/* Disable & mask insertion IRQ */
+	regmap_update_bits(regmap, NAU8821_R12_INTERRUPT_DIS_CTRL,
+			   NAU8821_IRQ_INSERT_DIS, NAU8821_IRQ_INSERT_DIS);
+	regmap_update_bits(regmap, NAU8821_R0F_INTERRUPT_MASK,
+			   NAU8821_IRQ_INSERT_EN, NAU8821_IRQ_INSERT_EN);
+
+	/* Clear insert IRQ status */
+	nau8821_irq_status_clear(regmap, NAU8821_JACK_INSERT_DETECTED);
+
 	/* Enable internal VCO needed for interruptions */
 	if (nau8821->dapm->bias_level < SND_SOC_BIAS_PREPARE)
 		nau8821_configure_sysclk(nau8821, NAU8821_CLK_INTERNAL, 0);
@@ -1160,21 +1178,23 @@ static void nau8821_setup_inserted_irq(struct nau8821 *nau8821)
 	regmap_update_bits(regmap, NAU8821_R1D_I2S_PCM_CTRL2,
 		NAU8821_I2S_MS_MASK, NAU8821_I2S_MS_SLAVE);
 
-	/* Not bypass de-bounce circuit */
-	regmap_update_bits(regmap, NAU8821_R0D_JACK_DET_CTRL,
-		NAU8821_JACK_DET_DB_BYPASS, 0);
+	/* Do not bypass de-bounce circuit */
+	if (!(nau8821_quirk & NAU8821_QUIRK_JD_DB_BYPASS))
+		regmap_update_bits(regmap, NAU8821_R0D_JACK_DET_CTRL,
+				   NAU8821_JACK_DET_DB_BYPASS, 0);
 
+	/* Unmask & enable the ejection IRQs */
 	regmap_update_bits(regmap, NAU8821_R0F_INTERRUPT_MASK,
-		NAU8821_IRQ_EJECT_EN, 0);
+			   NAU8821_IRQ_EJECT_EN, 0);
 	regmap_update_bits(regmap, NAU8821_R12_INTERRUPT_DIS_CTRL,
-		NAU8821_IRQ_EJECT_DIS, 0);
+			   NAU8821_IRQ_EJECT_DIS, 0);
 }
 
 static irqreturn_t nau8821_interrupt(int irq, void *data)
 {
 	struct nau8821 *nau8821 = (struct nau8821 *)data;
 	struct regmap *regmap = nau8821->regmap;
-	int active_irq, clear_irq = 0, event = 0, event_mask = 0;
+	int active_irq, event = 0, event_mask = 0;
 
 	if (regmap_read(regmap, NAU8821_R10_IRQ_STATUS, &active_irq)) {
 		dev_err(nau8821->dev, "failed to read irq status\n");
@@ -1185,48 +1205,38 @@ static irqreturn_t nau8821_interrupt(int irq, void *data)
 
 	if ((active_irq & NAU8821_JACK_EJECT_IRQ_MASK) ==
 		NAU8821_JACK_EJECT_DETECTED) {
+		cancel_work_sync(&nau8821->jdet_work);
 		regmap_update_bits(regmap, NAU8821_R71_ANALOG_ADC_1,
 			NAU8821_MICDET_MASK, NAU8821_MICDET_DIS);
 		nau8821_eject_jack(nau8821);
 		event_mask |= SND_JACK_HEADSET;
-		clear_irq = NAU8821_JACK_EJECT_IRQ_MASK;
 	} else if (active_irq & NAU8821_KEY_SHORT_PRESS_IRQ) {
 		event |= NAU8821_BUTTON;
 		event_mask |= NAU8821_BUTTON;
-		clear_irq = NAU8821_KEY_SHORT_PRESS_IRQ;
+		nau8821_irq_status_clear(regmap, NAU8821_KEY_SHORT_PRESS_IRQ);
 	} else if (active_irq & NAU8821_KEY_RELEASE_IRQ) {
 		event_mask = NAU8821_BUTTON;
-		clear_irq = NAU8821_KEY_RELEASE_IRQ;
+		nau8821_irq_status_clear(regmap, NAU8821_KEY_RELEASE_IRQ);
 	} else if ((active_irq & NAU8821_JACK_INSERT_IRQ_MASK) ==
 		NAU8821_JACK_INSERT_DETECTED) {
+		cancel_work_sync(&nau8821->jdet_work);
 		regmap_update_bits(regmap, NAU8821_R71_ANALOG_ADC_1,
 			NAU8821_MICDET_MASK, NAU8821_MICDET_EN);
 		if (nau8821_is_jack_inserted(regmap)) {
 			/* detect microphone and jack type */
-			cancel_work_sync(&nau8821->jdet_work);
 			schedule_work(&nau8821->jdet_work);
 			/* Turn off insertion interruption at manual mode */
-			regmap_update_bits(regmap,
-				NAU8821_R12_INTERRUPT_DIS_CTRL,
-				NAU8821_IRQ_INSERT_DIS,
-				NAU8821_IRQ_INSERT_DIS);
-			regmap_update_bits(regmap,
-				NAU8821_R0F_INTERRUPT_MASK,
-				NAU8821_IRQ_INSERT_EN,
-				NAU8821_IRQ_INSERT_EN);
 			nau8821_setup_inserted_irq(nau8821);
 		} else {
 			dev_warn(nau8821->dev,
 				"Inserted IRQ fired but not connected\n");
 			nau8821_eject_jack(nau8821);
 		}
+	} else {
+		/* Clear the rightmost interrupt */
+		nau8821_irq_status_clear(regmap, active_irq);
 	}
 
-	if (!clear_irq)
-		clear_irq = active_irq;
-	/* clears the rightmost interruption */
-	regmap_write(regmap, NAU8821_R11_INT_CLR_KEY_STATUS, clear_irq);
-
 	if (event_mask)
 		snd_soc_jack_report(nau8821->jack, event, event_mask);
 
@@ -1521,7 +1531,7 @@ static int nau8821_resume_setup(struct nau8821 *nau8821)
 	nau8821_configure_sysclk(nau8821, NAU8821_CLK_DIS, 0);
 	if (nau8821->irq) {
 		/* Clear all interruption status */
-		nau8821_int_status_clear_all(regmap);
+		nau8821_irq_status_clear(regmap, 0);
 
 		/* Enable both insertion and ejection interruptions, and then
 		 * bypass de-bounce circuit.
@@ -1856,7 +1866,23 @@ static const struct dmi_system_id nau8821_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
 			DMI_MATCH(DMI_BOARD_NAME, "CW14Q01P-V2"),
 		},
-		.driver_data = (void *)(NAU8821_JD_ACTIVE_HIGH),
+		.driver_data = (void *)(NAU8821_QUIRK_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Valve Steam Deck LCD */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
+		},
+		.driver_data = (void *)(NAU8821_QUIRK_JD_DB_BYPASS),
+	},
+	{
+		/* Valve Steam Deck OLED */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
+		},
+		.driver_data = (void *)(NAU8821_QUIRK_JD_DB_BYPASS),
 	},
 	{}
 };
@@ -1898,9 +1924,12 @@ static int nau8821_i2c_probe(struct i2c_client *i2c)
 
 	nau8821_check_quirks();
 
-	if (nau8821_quirk & NAU8821_JD_ACTIVE_HIGH)
+	if (nau8821_quirk & NAU8821_QUIRK_JD_ACTIVE_HIGH)
 		nau8821->jkdet_polarity = 0;
 
+	if (nau8821_quirk & NAU8821_QUIRK_JD_DB_BYPASS)
+		dev_dbg(dev, "Force bypassing jack detection debounce circuit\n");
+
 	nau8821_print_device_properties(nau8821);
 
 	nau8821_reset_chip(nau8821->regmap);
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 10d9b7285597..557f53d10ecf 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -850,10 +850,16 @@ get_alias_quirk(struct usb_device *dev, unsigned int id)
  */
 static int try_to_register_card(struct snd_usb_audio *chip, int ifnum)
 {
+	struct usb_interface *iface;
+
 	if (check_delayed_register_option(chip) == ifnum ||
-	    chip->last_iface == ifnum ||
-	    usb_interface_claimed(usb_ifnum_to_if(chip->dev, chip->last_iface)))
+	    chip->last_iface == ifnum)
+		return snd_card_register(chip->card);
+
+	iface = usb_ifnum_to_if(chip->dev, chip->last_iface);
+	if (iface && usb_interface_claimed(iface))
 		return snd_card_register(chip->card);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index bb143de68875..e27d66b75fb1 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -144,11 +144,17 @@ static void test_parse_test_list_file(void)
 	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
 		goto out_fclose;
 
+	if (!ASSERT_OK(fsync(fileno(fp)), "fsync tmp"))
+		goto out_fclose;
+
 	init_test_filter_set(&set);
 
-	ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file");
+	if (!ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file"))
+		goto out_fclose;
+
+	if (!ASSERT_EQ(set.cnt, 4, "test  count"))
+		goto out_free_set;
 
-	ASSERT_EQ(set.cnt, 4, "test  count");
 	ASSERT_OK(strcmp("test_with_spaces", set.tests[0].name), "test 0 name");
 	ASSERT_EQ(set.tests[0].subtest_cnt, 0, "test 0 subtest count");
 	ASSERT_OK(strcmp("testA", set.tests[1].name), "test 1 name");
@@ -158,8 +164,8 @@ static void test_parse_test_list_file(void)
 	ASSERT_OK(strcmp("testB", set.tests[2].name), "test 2 name");
 	ASSERT_OK(strcmp("testC_no_eof_newline", set.tests[3].name), "test 3 name");
 
+out_free_set:
 	free_test_filter_set(&set);
-
 out_fclose:
 	fclose(fp);
 out_remove:
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index d6c00efeb664..281758e40788 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -1453,6 +1453,8 @@ usage: ${0##*/} OPTS
 EOF
 }
 
+require_command jq
+
 #check for needed privileges
 if [ "$(id -u)" -ne 0 ];then
 	end_test "SKIP: Need root privileges"
diff --git a/tools/testing/selftests/net/vlan_bridge_binding.sh b/tools/testing/selftests/net/vlan_bridge_binding.sh
index e7cb8c678bde..fe5472d84424 100755
--- a/tools/testing/selftests/net/vlan_bridge_binding.sh
+++ b/tools/testing/selftests/net/vlan_bridge_binding.sh
@@ -249,6 +249,8 @@ test_binding_toggle_off_when_upper_down()
 	do_test_binding_off : "on->off when upper down"
 }
 
+require_command jq
+
 trap defer_scopes_cleanup EXIT
 setup_prepare
 tests_run

