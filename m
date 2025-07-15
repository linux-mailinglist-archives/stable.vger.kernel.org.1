Return-Path: <stable+bounces-161968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8479B05A5D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D891156035E
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 12:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F062E03FF;
	Tue, 15 Jul 2025 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OM/yYRuG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C3D2E03F5
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583074; cv=none; b=jpSyWEjMuDTx6jqBntexIZNoJqAIbuknLVHlH3pNwlyEpimPfxvEnoV9oQhrAilr8zlcL/xhOO2hVPMrkjXWtFGKaajAxtZgJcfGLlJ9fpKnmGhj3j055jdCS9fbBzB0X8GCYoN12NTfN/+BYbotB/iITiqw6N/Wj99uGkexJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583074; c=relaxed/simple;
	bh=6CWGL5trs7NBYzJq6xWUWxeP5PF1sPN7O/gaVkthHsQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUO/0inGOsPAhKO6fo6CXddPC6sns0tBWRqmFpcjt3LY1jr2+9uu9y6boV9vx9PflVvp+UHIxCR3kNFGLXUTgm7O1iXvwsqXupu84Djf9olGdHBLoPwbptar412SDB4NepvujNghI0clz6it3AxpRGOveRA2eOu3ngyfq3/VxII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OM/yYRuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A428EC4CEF6;
	Tue, 15 Jul 2025 12:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752583074;
	bh=6CWGL5trs7NBYzJq6xWUWxeP5PF1sPN7O/gaVkthHsQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OM/yYRuGvucieMQ9LMm/PEFNbyOPy+UP2FlMl6ENQRqPao8/SPxOufL081tMYXZQp
	 u3TQeYntL9B+aaxh6WYGN+uYAOvfioC63Yd5PfT46FyJ4UsImVI3iZuLm3MIQagtzT
	 p3se+92kaRrs/VvBbckEagUpN03/UYSpvuzlJ0RD/2qWucPeBt2M/OBg67dWPll3Ur
	 8MrMFgQwtdd1IGGYnSyVTwQ8iODqa8RiUfOnOY0EsOISX0enutUQMcTqpPYdweQ3Ln
	 aNxVtjTxr0lGbEY1cR9i27eCpUJwFZQol3LxqUi3y60RAtKeZKVEXNDbozlXo956Lb
	 g39zR/ZYexyKg==
From: Borislav Petkov <bp@kernel.org>
To: <stable@vger.kernel.org>
Subject: [PATCH 1/5] x86/bugs: Rename MDS machinery to something more generic
Date: Tue, 15 Jul 2025 14:37:45 +0200
Message-ID: <20250715123749.4610-2-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715123749.4610-1-bp@kernel.org>
References: <20250715123749.4610-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Commit f9af88a3d384c8b55beb5dc5483e5da0135fadbd upstream.

It will be used by other x86 mitigations.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 .../hw-vuln/processor_mmio_stale_data.rst     |  4 +--
 arch/x86/entry/entry.S                        |  8 ++---
 arch/x86/include/asm/irqflags.h               |  4 +--
 arch/x86/include/asm/mwait.h                  |  5 ++--
 arch/x86/include/asm/nospec-branch.h          | 29 ++++++++++---------
 arch/x86/kernel/cpu/bugs.c                    | 12 ++++----
 arch/x86/kvm/vmx/vmx.c                        |  2 +-
 7 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
index c98fd11907cc..e916dc232b0f 100644
--- a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
+++ b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
@@ -157,9 +157,7 @@ This is achieved by using the otherwise unused and obsolete VERW instruction in
 combination with a microcode update. The microcode clears the affected CPU
 buffers when the VERW instruction is executed.
 
-Kernel reuses the MDS function to invoke the buffer clearing:
-
-	mds_clear_cpu_buffers()
+Kernel does the buffer clearing with x86_clear_cpu_buffers().
 
 On MDS affected CPUs, the kernel already invokes CPU buffer clear on
 kernel/userspace, hypervisor/guest and C-state (idle) transitions. No
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index bda217961172..057eeb4eda4e 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -31,20 +31,20 @@ EXPORT_SYMBOL_GPL(entry_ibpb);
 
 /*
  * Define the VERW operand that is disguised as entry code so that
- * it can be referenced with KPTI enabled. This ensure VERW can be
+ * it can be referenced with KPTI enabled. This ensures VERW can be
  * used late in exit-to-user path after page tables are switched.
  */
 .pushsection .entry.text, "ax"
 
 .align L1_CACHE_BYTES, 0xcc
-SYM_CODE_START_NOALIGN(mds_verw_sel)
+SYM_CODE_START_NOALIGN(x86_verw_sel)
 	UNWIND_HINT_EMPTY
 	ANNOTATE_NOENDBR
 	.word __KERNEL_DS
 .align L1_CACHE_BYTES, 0xcc
-SYM_CODE_END(mds_verw_sel);
+SYM_CODE_END(x86_verw_sel);
 /* For KVM */
-EXPORT_SYMBOL_GPL(mds_verw_sel);
+EXPORT_SYMBOL_GPL(x86_verw_sel);
 
 .popsection
 
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index e585a4705b8d..62b29995e51c 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -56,13 +56,13 @@ static __always_inline void native_irq_enable(void)
 
 static inline __cpuidle void native_safe_halt(void)
 {
-	mds_idle_clear_cpu_buffers();
+	x86_idle_clear_cpu_buffers();
 	asm volatile("sti; hlt": : :"memory");
 }
 
 static inline __cpuidle void native_halt(void)
 {
-	mds_idle_clear_cpu_buffers();
+	x86_idle_clear_cpu_buffers();
 	asm volatile("hlt": : :"memory");
 }
 
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 29dd27b5a339..35e20e8a7cc6 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -43,7 +43,7 @@ static inline void __monitorx(const void *eax, unsigned long ecx,
 
 static inline void __mwait(unsigned long eax, unsigned long ecx)
 {
-	mds_idle_clear_cpu_buffers();
+	x86_idle_clear_cpu_buffers();
 
 	/* "mwait %eax, %ecx;" */
 	asm volatile(".byte 0x0f, 0x01, 0xc9;"
@@ -88,7 +88,8 @@ static inline void __mwaitx(unsigned long eax, unsigned long ebx,
 
 static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
-	mds_idle_clear_cpu_buffers();
+	x86_idle_clear_cpu_buffers();
+
 	/* "mwait %eax, %ecx;" */
 	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
 		     :: "a" (eax), "c" (ecx));
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7978d5fe1ce6..432506c0f16e 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -191,23 +191,23 @@
 .endm
 
 /*
- * Macro to execute VERW instruction that mitigate transient data sampling
- * attacks such as MDS. On affected systems a microcode update overloaded VERW
- * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
- *
+ * Macro to execute VERW insns that mitigate transient data sampling
+ * attacks such as MDS or TSA. On affected systems a microcode update
+ * overloaded VERW insns to also clear the CPU buffers. VERW clobbers
+ * CFLAGS.ZF.
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
 .macro CLEAR_CPU_BUFFERS
 	ALTERNATIVE "jmp .Lskip_verw_\@", "", X86_FEATURE_CLEAR_CPU_BUF
 #ifdef CONFIG_X86_64
-	verw mds_verw_sel(%rip)
+	verw x86_verw_sel(%rip)
 #else
 	/*
 	 * In 32bit mode, the memory operand must be a %cs reference. The data
 	 * segments may not be usable (vm86 mode), and the stack segment may not
 	 * be flat (ESPFIX32).
 	 */
-	verw %cs:mds_verw_sel
+	verw %cs:x86_verw_sel
 #endif
 .Lskip_verw_\@:
 .endm
@@ -387,22 +387,22 @@ DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
-DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
+DECLARE_STATIC_KEY_FALSE(cpu_buf_idle_clear);
 
 DECLARE_STATIC_KEY_FALSE(mmio_stale_data_clear);
 
-extern u16 mds_verw_sel;
+extern u16 x86_verw_sel;
 
 #include <asm/segment.h>
 
 /**
- * mds_clear_cpu_buffers - Mitigation for MDS and TAA vulnerability
+ * x86_clear_cpu_buffers - Buffer clearing support for different x86 CPU vulns
  *
  * This uses the otherwise unused and obsolete VERW instruction in
  * combination with microcode which triggers a CPU buffer flush when the
  * instruction is executed.
  */
-static __always_inline void mds_clear_cpu_buffers(void)
+static __always_inline void x86_clear_cpu_buffers(void)
 {
 	static const u16 ds = __KERNEL_DS;
 
@@ -419,14 +419,15 @@ static __always_inline void mds_clear_cpu_buffers(void)
 }
 
 /**
- * mds_idle_clear_cpu_buffers - Mitigation for MDS vulnerability
+ * x86_idle_clear_cpu_buffers - Buffer clearing support in idle for the MDS
+ * vulnerability
  *
  * Clear CPU buffers if the corresponding static key is enabled
  */
-static inline void mds_idle_clear_cpu_buffers(void)
+static __always_inline void x86_idle_clear_cpu_buffers(void)
 {
-	if (static_branch_likely(&mds_idle_clear))
-		mds_clear_cpu_buffers();
+	if (static_branch_likely(&cpu_buf_idle_clear))
+		x86_clear_cpu_buffers();
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9b3611e4cb80..bb9b6e7fed20 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -109,9 +109,9 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 /* Control unconditional IBPB in switch_mm() */
 DEFINE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
-/* Control MDS CPU buffer clear before idling (halt, mwait) */
-DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
-EXPORT_SYMBOL_GPL(mds_idle_clear);
+/* Control CPU buffer clear before idling (halt, mwait) */
+DEFINE_STATIC_KEY_FALSE(cpu_buf_idle_clear);
+EXPORT_SYMBOL_GPL(cpu_buf_idle_clear);
 
 /* Controls CPU Fill buffer clear before KVM guest MMIO accesses */
 DEFINE_STATIC_KEY_FALSE(mmio_stale_data_clear);
@@ -435,7 +435,7 @@ static void __init mmio_select_mitigation(void)
 	 * is required irrespective of SMT state.
 	 */
 	if (!(ia32_cap & ARCH_CAP_FBSDP_NO))
-		static_branch_enable(&mds_idle_clear);
+		static_branch_enable(&cpu_buf_idle_clear);
 
 	/*
 	 * Check if the system has the right microcode.
@@ -1806,10 +1806,10 @@ static void update_mds_branch_idle(void)
 		return;
 
 	if (sched_smt_active()) {
-		static_branch_enable(&mds_idle_clear);
+		static_branch_enable(&cpu_buf_idle_clear);
 	} else if (mmio_mitigation == MMIO_MITIGATION_OFF ||
 		   (ia32_cap & ARCH_CAP_FBSDP_NO)) {
-		static_branch_disable(&mds_idle_clear);
+		static_branch_disable(&cpu_buf_idle_clear);
 	}
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1908f2aae9fa..795bbaf89d94 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6810,7 +6810,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 		vmx_l1d_flush(vcpu);
 	else if (static_branch_unlikely(&mmio_stale_data_clear) &&
 		 kvm_arch_has_assigned_device(vcpu->kvm))
-		mds_clear_cpu_buffers();
+		x86_clear_cpu_buffers();
 
 	vmx_disable_fb_clear(vmx);
 
-- 
2.43.0


