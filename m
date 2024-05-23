Return-Path: <stable+bounces-45608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B268CCA58
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 03:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C784F1F21C8E
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0C6EC7;
	Thu, 23 May 2024 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7O28/vF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBD65227
	for <stable@vger.kernel.org>; Thu, 23 May 2024 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716427227; cv=none; b=rbU5jufKcXbbhkToqb4+3lOS30R8Y1obFjnIuHKspxDyRJ+1k2rGMCGhU3Xe3OYwqcgM+8xHd/ppk86kzzelhBB21XT/GiupDUisBp9JZaz8ymkZGgzWPMa5ZsQ6FyYlBnKtFeP7HJmxsMO70dhWOxc3VwVc0uriibY4SwMEFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716427227; c=relaxed/simple;
	bh=OBJ6NI3y8qebJ5AK/thr6FfcOgOdvK+rfZRhsCXNxII=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RfPDkCCB/BQV4o31eTESu5kGLIWOnSFOVzmRiX6EwUPbkMeazSjfiEecBwrugVKx1WppT1+e//WK/uk4vf/dI1sHlNH5HqlanwUBFoqA6VAs5pJHzKm6bwvhMQ+F/FVH+/YK9Kyp2syXEN/jz/w4fHduD8HaLbY7m33DmWJaQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7O28/vF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716427226; x=1747963226;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OBJ6NI3y8qebJ5AK/thr6FfcOgOdvK+rfZRhsCXNxII=;
  b=l7O28/vFsBB2dl8Gsy/KMhxNiSnTtXit6m4hcXn0HE86u5tk27TtiPSL
   gg+zJHtEcuGAHw5kK5MCUCLDGZugC3gaQk4FWUv+0s2/g9DFacaqyxJV8
   75q5p4/fxXVJQYHOh5dlelya9V4ZnTpfPPwSRKqU4FhX1LJ5XjwQpSvjn
   ehl7S2XY7yCGipXfSeKBfbe5ex/Q1mMi6UYdAw7U2J86LTBaC0GPuuaOE
   VmGIc8oeJ4cd1gytLEr8SCSsBoeOGY1oLwU746oCKZ+7hOCMuDUsv8Xg3
   RiGwbO6agaeCK1uTyujm1r/MEk/eG3uenLIgpYu95BeDn34M5tlwk0V2P
   A==;
X-CSE-ConnectionGUID: UBpnbBC5S6eK6wWBkw4U+Q==
X-CSE-MsgGUID: OCsJerdkTf6Og384X/j6fw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12551039"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12551039"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 18:20:24 -0700
X-CSE-ConnectionGUID: OiVUy4GeSKWtjX+5/NuI4A==
X-CSE-MsgGUID: Pscf/n4xQnuzctPt7iKQSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="34026442"
Received: from jjsopko-mobl1.amr.corp.intel.com (HELO desk) ([10.212.211.181])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 18:20:24 -0700
Date: Wed, 22 May 2024 18:20:15 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, dave.hansen@linux.intel.com,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	xen-devel@lists.xenproject.org, security@debian.org,
	Salvatore Bonaccorso <carnil@debian.org>, benh@debian.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
	Deep Shah <sdeep@vmware.com>,
	"VMware, Inc." <pv-drivers@vmware.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Borislav Petkov <bp@suse.de>
Subject: [PATCH 5.10] x86/xen: Drop USERGS_SYSRET64 paravirt call
Message-ID: <20240522-verw-xen-pv-fix-v1-1-45add699c0e4@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAHmZTmYC/x2MywqAIBAAfyX23Iat2etXooPYVnuxULAg+vek4
 wzMPBA5CEcYiwcCJ4ly+Ax1WYDbrd8YZckMpKhRhggThwtv9ngmXOVGbnXf0WCddhZydQbO+j9
 OYKpawfy+H0Rh7bhnAAAA
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Juergen Gross <jgross@suse.com>

commit afd30525a659ac0ae0904f0cb4a2ca75522c3123 upstream.

USERGS_SYSRET64 is used to return from a syscall via SYSRET, but
a Xen PV guest will nevertheless use the IRET hypercall, as there
is no sysret PV hypercall defined.

So instead of testing all the prerequisites for doing a sysret and
then mangling the stack for Xen PV again for doing an iret just use
the iret exit from the beginning.

This can easily be done via an ALTERNATIVE like it is done for the
sysenter compat case already.

It should be noted that this drops the optimization in Xen for not
restoring a few registers when returning to user mode, but it seems
as if the saved instructions in the kernel more than compensate for
this drop (a kernel build in a Xen PV guest was slightly faster with
this patch applied).

While at it remove the stale sysret32 remnants.

  [ pawan: Brad Spengler and Salvatore Bonaccorso <carnil@debian.org>
	   reported a problem with the 5.10 backport commit edc702b4a820
	   ("x86/entry_64: Add VERW just before userspace transition").

	   When CONFIG_PARAVIRT_XXL=y, CLEAR_CPU_BUFFERS is not executed in
	   syscall_return_via_sysret path as USERGS_SYSRET64 is runtime
	   patched to:

	.cpu_usergs_sysret64    = { 0x0f, 0x01, 0xf8,
				    0x48, 0x0f, 0x07 }, // swapgs; sysretq

	   which is missing CLEAR_CPU_BUFFERS. It turns out dropping
	   USERGS_SYSRET64 simplifies the code, allowing CLEAR_CPU_BUFFERS
	   to be explicitly added to syscall_return_via_sysret path. Below
	   is with CONFIG_PARAVIRT_XXL=y and this patch applied:

	   syscall_return_via_sysret:
	   ...
	   <+342>:   swapgs
	   <+345>:   xchg   %ax,%ax
	   <+347>:   verw   -0x1a2(%rip)  <------
	   <+354>:   sysretq
  ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lkml.kernel.org/r/20210120135555.32594-6-jgross@suse.com
---
 arch/x86/entry/entry_64.S             | 17 ++++++++---------
 arch/x86/include/asm/irqflags.h       |  7 -------
 arch/x86/include/asm/paravirt.h       |  5 -----
 arch/x86/include/asm/paravirt_types.h |  8 --------
 arch/x86/kernel/asm-offsets_64.c      |  2 --
 arch/x86/kernel/paravirt.c            |  5 +----
 arch/x86/kernel/paravirt_patch.c      |  4 ----
 arch/x86/xen/enlighten_pv.c           |  1 -
 arch/x86/xen/xen-asm.S                | 21 ---------------------
 arch/x86/xen/xen-ops.h                |  2 --
 10 files changed, 9 insertions(+), 63 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1631a9a1566e..bd785386d629 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -46,14 +46,6 @@
 .code64
 .section .entry.text, "ax"
 
-#ifdef CONFIG_PARAVIRT_XXL
-SYM_CODE_START(native_usergs_sysret64)
-	UNWIND_HINT_EMPTY
-	swapgs
-	sysretq
-SYM_CODE_END(native_usergs_sysret64)
-#endif /* CONFIG_PARAVIRT_XXL */
-
 /*
  * 64-bit SYSCALL instruction entry. Up to 6 arguments in registers.
  *
@@ -128,7 +120,12 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	 * Try to use SYSRET instead of IRET if we're returning to
 	 * a completely clean 64-bit userspace context.  If we're not,
 	 * go to the slow exit path.
+	 * In the Xen PV case we must use iret anyway.
 	 */
+
+	ALTERNATIVE "", "jmp	swapgs_restore_regs_and_return_to_usermode", \
+		X86_FEATURE_XENPV
+
 	movq	RCX(%rsp), %rcx
 	movq	RIP(%rsp), %r11
 
@@ -220,7 +217,9 @@ syscall_return_via_sysret:
 
 	popq	%rdi
 	popq	%rsp
-	USERGS_SYSRET64
+	swapgs
+	CLEAR_CPU_BUFFERS
+	sysretq
 SYM_CODE_END(entry_SYSCALL_64)
 
 /*
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index f40dea50dfbf..e585a4705b8d 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -132,13 +132,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #endif
 
 #define INTERRUPT_RETURN	jmp native_iret
-#define USERGS_SYSRET64				\
-	swapgs;					\
-	CLEAR_CPU_BUFFERS;			\
-	sysretq;
-#define USERGS_SYSRET32				\
-	swapgs;					\
-	sysretl
 
 #else
 #define INTERRUPT_RETURN		iret
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 4a32b0d34376..3c89c1f64871 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -776,11 +776,6 @@ extern void default_banner(void);
 
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT_XXL
-#define USERGS_SYSRET64							\
-	PARA_SITE(PARA_PATCH(PV_CPU_usergs_sysret64),			\
-		  ANNOTATE_RETPOLINE_SAFE;				\
-		  jmp PARA_INDIRECT(pv_ops+PV_CPU_usergs_sysret64);)
-
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
 	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),			    \
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 903d71884fa2..55d8b7950e61 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -157,14 +157,6 @@ struct pv_cpu_ops {
 
 	u64 (*read_pmc)(int counter);
 
-	/*
-	 * Switch to usermode gs and return to 64-bit usermode using
-	 * sysret.  Only used in 64-bit kernels to return to 64-bit
-	 * processes.  Usermode register state, including %rsp, must
-	 * already be restored.
-	 */
-	void (*usergs_sysret64)(void);
-
 	/* Normal iret.  Jump to this with the standard iret stack
 	   frame set up. */
 	void (*iret)(void);
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 1354bc30614d..b14533af7676 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -13,8 +13,6 @@ int main(void)
 {
 #ifdef CONFIG_PARAVIRT
 #ifdef CONFIG_PARAVIRT_XXL
-	OFFSET(PV_CPU_usergs_sysret64, paravirt_patch_template,
-	       cpu.usergs_sysret64);
 #ifdef CONFIG_DEBUG_ENTRY
 	OFFSET(PV_IRQ_save_fl, paravirt_patch_template, irq.save_fl);
 #endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index f0e4ad8595ca..9d91061b862c 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -124,8 +124,7 @@ unsigned paravirt_patch_default(u8 type, void *insn_buff,
 	else if (opfunc == _paravirt_ident_64)
 		ret = paravirt_patch_ident_64(insn_buff, len);
 
-	else if (type == PARAVIRT_PATCH(cpu.iret) ||
-		 type == PARAVIRT_PATCH(cpu.usergs_sysret64))
+	else if (type == PARAVIRT_PATCH(cpu.iret))
 		/* If operation requires a jmp, then jmp */
 		ret = paravirt_patch_jmp(insn_buff, opfunc, addr, len);
 #endif
@@ -159,7 +158,6 @@ static u64 native_steal_clock(int cpu)
 
 /* These are in entry.S */
 extern void native_iret(void);
-extern void native_usergs_sysret64(void);
 
 static struct resource reserve_ioports = {
 	.start = 0,
@@ -299,7 +297,6 @@ struct paravirt_patch_template pv_ops = {
 
 	.cpu.load_sp0		= native_load_sp0,
 
-	.cpu.usergs_sysret64	= native_usergs_sysret64,
 	.cpu.iret		= native_iret,
 
 #ifdef CONFIG_X86_IOPL_IOPERM
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
index 7c518b08aa3c..2fada2c347c9 100644
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -27,7 +27,6 @@ struct patch_xxl {
 	const unsigned char	mmu_write_cr3[3];
 	const unsigned char	irq_restore_fl[2];
 	const unsigned char	cpu_wbinvd[2];
-	const unsigned char	cpu_usergs_sysret64[6];
 	const unsigned char	mov64[3];
 };
 
@@ -40,8 +39,6 @@ static const struct patch_xxl patch_data_xxl = {
 	.mmu_write_cr3		= { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
 	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
 	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
-	.cpu_usergs_sysret64	= { 0x0f, 0x01, 0xf8,
-				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
 	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
 };
 
@@ -83,7 +80,6 @@ unsigned int native_patch(u8 type, void *insn_buff, unsigned long addr,
 	PATCH_CASE(mmu, read_cr3, xxl, insn_buff, len);
 	PATCH_CASE(mmu, write_cr3, xxl, insn_buff, len);
 
-	PATCH_CASE(cpu, usergs_sysret64, xxl, insn_buff, len);
 	PATCH_CASE(cpu, wbinvd, xxl, insn_buff, len);
 #endif
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 94804670caab..b1efc4b4f42a 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1059,7 +1059,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 	.read_pmc = xen_read_pmc,
 
 	.iret = xen_iret,
-	.usergs_sysret64 = xen_sysret64,
 
 	.load_tr_desc = paravirt_nop,
 	.set_ldt = xen_set_ldt,
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index e3031afcb103..3a33713cf449 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -220,27 +220,6 @@ SYM_CODE_START(xen_iret)
 	jmp hypercall_iret
 SYM_CODE_END(xen_iret)
 
-SYM_CODE_START(xen_sysret64)
-	UNWIND_HINT_EMPTY
-	/*
-	 * We're already on the usermode stack at this point, but
-	 * still with the kernel gs, so we can easily switch back.
-	 *
-	 * tss.sp2 is scratch space.
-	 */
-	movq %rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
-	movq PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-
-	pushq $__USER_DS
-	pushq PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
-	pushq %r11
-	pushq $__USER_CS
-	pushq %rcx
-
-	pushq $VGCF_in_syscall
-	jmp hypercall_iret
-SYM_CODE_END(xen_sysret64)
-
 /*
  * XEN pv doesn't use trampoline stack, PER_CPU_VAR(cpu_tss_rw + TSS_sp0) is
  * also the kernel stack.  Reusing swapgs_restore_regs_and_return_to_usermode()
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 8695809b88f0..98242430d07e 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -138,8 +138,6 @@ __visible unsigned long xen_read_cr2_direct(void);
 
 /* These are not functions, and cannot be called normally */
 __visible void xen_iret(void);
-__visible void xen_sysret32(void);
-__visible void xen_sysret64(void);
 
 extern int xen_panic_handler_init(void);
 

---
base-commit: ce3838dbefdccfb95a63f81fe6cf77592ae9138c
change-id: 20240522-verw-xen-pv-fix-e638729ac3ca

Best regards,
-- 
Thanks,
Pawan


