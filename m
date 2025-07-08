Return-Path: <stable+bounces-161153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A4EAFD39F
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF221700F0
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AA82E540B;
	Tue,  8 Jul 2025 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aILY/GXV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D342E2F0D;
	Tue,  8 Jul 2025 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993748; cv=none; b=gmw4PRHHvTpJjhaHrEpuGZTKsMUU/9D5x6rTB0wWSKA4Eyrqs4t0NlDN0Ektt5/CwBvbaVbCwGrYVGub46aUE+QfeXC09jg0fMEyg51y/dRVv4LqfnmyOD+bWE1fcle8JU7+XtG0t1s+honwRj6N+b3kh1XFfdd6Zx0NajuNatc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993748; c=relaxed/simple;
	bh=MA7Pytkqh3ze8ZAU809MjX1kDWwXe5wwtIyu3JdAF7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxytz1BkQkXTdX5izGYfW138PViGm4vzE/VkuGPSPRst52FzE4cfv28QO5jDi5UdEaEoqKoDDdZ4tjuT3bgmAGSr23pF6BDm1N9cMTsKZXoNqCgfIN/sSYbZf64vWuJjXLVcaLYRGNiMOd+khZej8E0qcD6C6fqikHGEpmD9Tyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aILY/GXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E472C4CEED;
	Tue,  8 Jul 2025 16:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993748;
	bh=MA7Pytkqh3ze8ZAU809MjX1kDWwXe5wwtIyu3JdAF7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aILY/GXV2LO+nOscGbTM2RsPvcxA31jeOpEvOwvat09AgwfBwLvcEeEy3jWrV63fF
	 AoYyjajuNZMX4L3UcAPc2M7IrBi5QG8hDr44QjPdxloIEMnLcvXpQ+R6twsXxLn+bj
	 FZpf0ptDXNhUBVLQTTcuURaVoVSTMRn7LQRwZe0s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH 6.15 173/178] x86/bugs: Rename MDS machinery to something more generic
Date: Tue,  8 Jul 2025 18:23:30 +0200
Message-ID: <20250708162240.969523682@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Commit f9af88a3d384c8b55beb5dc5483e5da0135fadbd upstream.

It will be used by other x86 mitigations.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst |    4 -
 Documentation/arch/x86/mds.rst                                  |    8 +-
 arch/x86/entry/entry.S                                          |    8 +-
 arch/x86/include/asm/irqflags.h                                 |    4 -
 arch/x86/include/asm/mwait.h                                    |    5 +
 arch/x86/include/asm/nospec-branch.h                            |   29 +++++-----
 arch/x86/kernel/cpu/bugs.c                                      |   12 ++--
 arch/x86/kvm/vmx/vmx.c                                          |    2 
 8 files changed, 36 insertions(+), 36 deletions(-)

--- a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
+++ b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
@@ -157,9 +157,7 @@ This is achieved by using the otherwise
 combination with a microcode update. The microcode clears the affected CPU
 buffers when the VERW instruction is executed.
 
-Kernel reuses the MDS function to invoke the buffer clearing:
-
-	mds_clear_cpu_buffers()
+Kernel does the buffer clearing with x86_clear_cpu_buffers().
 
 On MDS affected CPUs, the kernel already invokes CPU buffer clear on
 kernel/userspace, hypervisor/guest and C-state (idle) transitions. No
--- a/Documentation/arch/x86/mds.rst
+++ b/Documentation/arch/x86/mds.rst
@@ -93,7 +93,7 @@ enters a C-state.
 
 The kernel provides a function to invoke the buffer clearing:
 
-    mds_clear_cpu_buffers()
+    x86_clear_cpu_buffers()
 
 Also macro CLEAR_CPU_BUFFERS can be used in ASM late in exit-to-user path.
 Other than CFLAGS.ZF, this macro doesn't clobber any registers.
@@ -185,9 +185,9 @@ Mitigation points
    idle clearing would be a window dressing exercise and is therefore not
    activated.
 
-   The invocation is controlled by the static key mds_idle_clear which is
-   switched depending on the chosen mitigation mode and the SMT state of
-   the system.
+   The invocation is controlled by the static key cpu_buf_idle_clear which is
+   switched depending on the chosen mitigation mode and the SMT state of the
+   system.
 
    The buffer clear is only invoked before entering the C-State to prevent
    that stale data from the idling CPU from spilling to the Hyper-Thread
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -36,20 +36,20 @@ EXPORT_SYMBOL_GPL(write_ibpb);
 
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
 	UNWIND_HINT_UNDEFINED
 	ANNOTATE_NOENDBR
 	.word __KERNEL_DS
 .align L1_CACHE_BYTES, 0xcc
-SYM_CODE_END(mds_verw_sel);
+SYM_CODE_END(x86_verw_sel);
 /* For KVM */
-EXPORT_SYMBOL_GPL(mds_verw_sel);
+EXPORT_SYMBOL_GPL(x86_verw_sel);
 
 .popsection
 
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -44,13 +44,13 @@ static __always_inline void native_irq_e
 
 static __always_inline void native_safe_halt(void)
 {
-	mds_idle_clear_cpu_buffers();
+	x86_idle_clear_cpu_buffers();
 	asm volatile("sti; hlt": : :"memory");
 }
 
 static __always_inline void native_halt(void)
 {
-	mds_idle_clear_cpu_buffers();
+	x86_idle_clear_cpu_buffers();
 	asm volatile("hlt": : :"memory");
 }
 
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -43,7 +43,7 @@ static __always_inline void __monitorx(c
 
 static __always_inline void __mwait(unsigned long eax, unsigned long ecx)
 {
-	mds_idle_clear_cpu_buffers();
+	x86_idle_clear_cpu_buffers();
 
 	/* "mwait %eax, %ecx;" */
 	asm volatile(".byte 0x0f, 0x01, 0xc9;"
@@ -97,7 +97,8 @@ static __always_inline void __mwaitx(uns
  */
 static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
-	mds_idle_clear_cpu_buffers();
+	x86_idle_clear_cpu_buffers();
+
 	/* "mwait %eax, %ecx;" */
 	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
 		     :: "a" (eax), "c" (ecx));
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -302,22 +302,22 @@
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
 #ifdef CONFIG_X86_64
-	ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", "verw x86_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
 #else
 	/*
 	 * In 32bit mode, the memory operand must be a %cs reference. The data
 	 * segments may not be usable (vm86 mode), and the stack segment may not
 	 * be flat (ESPFIX32).
 	 */
-	ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", "verw %cs:x86_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
 #endif
 .endm
 
@@ -567,24 +567,24 @@ DECLARE_STATIC_KEY_FALSE(switch_mm_alway
 
 DECLARE_STATIC_KEY_FALSE(switch_vcpu_ibpb);
 
-DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
+DECLARE_STATIC_KEY_FALSE(cpu_buf_idle_clear);
 
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 
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
 
@@ -601,14 +601,15 @@ static __always_inline void mds_clear_cp
 }
 
 /**
- * mds_idle_clear_cpu_buffers - Mitigation for MDS vulnerability
+ * x86_idle_clear_cpu_buffers - Buffer clearing support in idle for the MDS
+ * vulnerability
  *
  * Clear CPU buffers if the corresponding static key is enabled
  */
-static __always_inline void mds_idle_clear_cpu_buffers(void)
+static __always_inline void x86_idle_clear_cpu_buffers(void)
 {
-	if (static_branch_likely(&mds_idle_clear))
-		mds_clear_cpu_buffers();
+	if (static_branch_likely(&cpu_buf_idle_clear))
+		x86_clear_cpu_buffers();
 }
 
 #endif /* __ASSEMBLER__ */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -125,9 +125,9 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_always
 DEFINE_STATIC_KEY_FALSE(switch_vcpu_ibpb);
 EXPORT_SYMBOL_GPL(switch_vcpu_ibpb);
 
-/* Control MDS CPU buffer clear before idling (halt, mwait) */
-DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
-EXPORT_SYMBOL_GPL(mds_idle_clear);
+/* Control CPU buffer clear before idling (halt, mwait) */
+DEFINE_STATIC_KEY_FALSE(cpu_buf_idle_clear);
+EXPORT_SYMBOL_GPL(cpu_buf_idle_clear);
 
 /*
  * Controls whether l1d flush based mitigations are enabled,
@@ -469,7 +469,7 @@ static void __init mmio_select_mitigatio
 	 * is required irrespective of SMT state.
 	 */
 	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
-		static_branch_enable(&mds_idle_clear);
+		static_branch_enable(&cpu_buf_idle_clear);
 
 	/*
 	 * Check if the system has the right microcode.
@@ -2063,10 +2063,10 @@ static void update_mds_branch_idle(void)
 		return;
 
 	if (sched_smt_active()) {
-		static_branch_enable(&mds_idle_clear);
+		static_branch_enable(&cpu_buf_idle_clear);
 	} else if (mmio_mitigation == MMIO_MITIGATION_OFF ||
 		   (x86_arch_cap_msr & ARCH_CAP_FBSDP_NO)) {
-		static_branch_disable(&mds_idle_clear);
+		static_branch_disable(&cpu_buf_idle_clear);
 	}
 }
 
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7366,7 +7366,7 @@ static noinstr void vmx_vcpu_enter_exit(
 		vmx_l1d_flush(vcpu);
 	else if (static_branch_unlikely(&mmio_stale_data_clear) &&
 		 kvm_arch_has_assigned_device(vcpu->kvm))
-		mds_clear_cpu_buffers();
+		x86_clear_cpu_buffers();
 
 	vmx_disable_fb_clear(vmx);
 



