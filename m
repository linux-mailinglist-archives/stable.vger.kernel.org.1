Return-Path: <stable+bounces-59038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BABAC92D8C4
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 21:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4809D1F22227
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 19:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1019753F;
	Wed, 10 Jul 2024 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMcA/O7a"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D014F606;
	Wed, 10 Jul 2024 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638417; cv=none; b=Wqlx64fsWkkROkOxUdaELojKRwyE5RZm07+FwNXDGkXHcdruwH/B8JTds1wjY67Be2saEmva9hmu5nhdp3nOd4tGkLFbH31BKWwZ4q60IMN2NzTPobETfWDXucKIbiamWYxqiUdID9CJGV74pyiPdezU81AWfmIpiUqu8Vygs3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638417; c=relaxed/simple;
	bh=QQ3nVOF7rMPLsZR2dLB1YsInmnTvUl8MZYpHycB5qSM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=siPPkgP3TbjsJIxVZZqAOvW6hWukDVaWPDPuvHBZkY0dELNBYSpHzRzLc1cKZFmYw7qvIgf3h3a1FpZtdIskQ0g0hTIkkR+j0k2blUhS72nqHBsocV7aJHeU+nvzkb6OCX8GeL3HHIzzsYHLfzRBX80C7pIVkuyjt3xcowgB1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMcA/O7a; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720638417; x=1752174417;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QQ3nVOF7rMPLsZR2dLB1YsInmnTvUl8MZYpHycB5qSM=;
  b=NMcA/O7anR0aM+ruAs9eWc4CyhEzE0cUVjJCKBKFKa9MEaft9i1WNv0S
   zC37S48vAiHo0jKMuXlam45f8y8tnDTmamqgpfIHAbkHpWi4C5KicTTIK
   PiXufL24ORFH4S8g0EMVZCHavatGHnk+dE80H9mrwjtzAdotR9xroU7B9
   hIgFyIc3ESNxFI63cMI85FlbMJ47HcGF0bidIkSASldL9Nx+BnjUUbK1Q
   NTRLnBtjNVkP1V44zgE7D8jUzeKKP91PARtemZ71dtnoYDNcmedSwganQ
   TOnuTQKTMnlOwHIhxiqw58d0weX/+Yaw1SE60TpCpfKqRg2Xl6akGBRi1
   g==;
X-CSE-ConnectionGUID: VJa1E2dNTVmpEEW0PD0ZGw==
X-CSE-MsgGUID: EqsunlWqQRKsjBNxAXeuKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18119891"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18119891"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 12:06:55 -0700
X-CSE-ConnectionGUID: IEbJoWOiTMygLdeuskQV5g==
X-CSE-MsgGUID: mxc4/P3IRU2NrZtUat6kGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48194312"
Received: from paulvall-mobl.amr.corp.intel.com (HELO desk) ([10.209.72.253])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 12:06:52 -0700
Date: Wed, 10 Jul 2024 12:06:47 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com, stable@vger.kernel.org
Subject: [PATCH v4] x86/entry_32: Use stack segment selector for VERW operand
Message-ID: <20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIACjbjmYC/3XNOw6DMAyA4augzA3CCcShU+9RdaDElEg8KgIRF
 eLuDSwMtONv2Z8X5miw5Ng1WthA3jrbdyHSS8TKuuhexK0JzUQi0iQVild25qZ31E7ct1pxYwC
 gSAAlEgtX74HCyi7eH6Fr68Z++OwPPGzT/5YHDlzrUgtVyEqivjW2m+bYdiM1cdm3bBO9OBQl8
 KyIoJgsw7xSuSbE34o8FEzgrMigPCFXeSZFiVlxVtZ1/QJ0lgr2QAEAAA==
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Robert Gill reported below #GP when dosemu software was executing vm86()
system call:

  general protection fault: 0000 [#1] PREEMPT SMP
  CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
  Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
  EIP: restore_all_switch_stack+0xbe/0xcf
  EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
  ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
  DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
  CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
  Call Trace:
   show_regs+0x70/0x78
   die_addr+0x29/0x70
   exc_general_protection+0x13c/0x348
   exc_bounds+0x98/0x98
   handle_exception+0x14d/0x14d
   exc_bounds+0x98/0x98
   restore_all_switch_stack+0xbe/0xcf
   exc_bounds+0x98/0x98
   restore_all_switch_stack+0xbe/0xcf

This only happens when VERW based mitigations like MDS/RFDS are enabled.
This is because segment registers with an arbitrary user value can result
in #GP when executing VERW. Intel SDM vol. 2C documents the following
behavior for VERW instruction:

  #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
	   FS, or GS segment limit.

CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
space. Replace CLEAR_CPU_BUFFERS with a safer version that uses %ss to
refer VERW operand mds_verw_sel. This ensures VERW will not #GP for an
arbitrary user %ds. Also, in NMI return path, move VERW to after
RESTORE_ALL_NMI that touches GPRs.

For clarity, below are the locations where the new CLEAR_CPU_BUFFERS_SAFE
version is being used:

* entry_INT80_32(), entry_SYSENTER_32() and interrupts (via
  handle_exception_return) do:

restore_all_switch_stack:
  [...]
   mov    %esi,%esi
   verw   %ss:0xc0fc92c0  <-------------
   iret

* Opportunistic SYSEXIT:

   [...]
   verw   %ss:0xc0fc92c0  <-------------
   btrl   $0x9,(%esp)
   popf
   pop    %eax
   sti
   sysexit

*  nmi_return and nmi_from_espfix:
   mov    %esi,%esi
   verw   %ss:0xc0fc92c0  <-------------
   jmp     .Lirq_return

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Cc: stable@vger.kernel.org # 5.10+
Reported-by: Robert Gill <rtgill82@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Brian Gerst <brgerst@gmail.com> # Use %ss
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
v4:
- Further simplify the patch by using %ss for all VERW calls in 32-bit mode (Brian).
- In NMI exit path move VERW after RESTORE_ALL_NMI that touches GPRs (Dave).

v3: https://lore.kernel.org/r/20240701-fix-dosemu-vm86-v3-1-b1969532c75a@linux.intel.com
- Simplify CLEAR_CPU_BUFFERS_SAFE by using %ss instead of %ds (Brian).
- Do verw before popf in SYSEXIT path (Jari).

v2: https://lore.kernel.org/r/20240627-fix-dosemu-vm86-v2-1-d5579f698e77@linux.intel.com
- Safe guard against any other system calls like vm86() that might change %ds (Dave).

v1: https://lore.kernel.org/r/20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com
---

---
 arch/x86/entry/entry_32.S | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d3a814efbff6..d54f6002e5a0 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -253,6 +253,16 @@
 .Lend_\@:
 .endm
 
+/*
+ * Safer version of CLEAR_CPU_BUFFERS that uses %ss to reference VERW operand
+ * mds_verw_sel. This ensures VERW will not #GP for an arbitrary user %ds.
+ */
+.macro CLEAR_CPU_BUFFERS_SAFE
+	ALTERNATIVE "jmp .Lskip_verw\@", "", X86_FEATURE_CLEAR_CPU_BUF
+	verw	%ss:_ASM_RIP(mds_verw_sel)
+.Lskip_verw\@:
+.endm
+
 .macro RESTORE_INT_REGS
 	popl	%ebx
 	popl	%ecx
@@ -871,6 +881,8 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	/* Now ready to switch the cr3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
+	/* Clobbers ZF */
+	CLEAR_CPU_BUFFERS_SAFE
 
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
@@ -881,7 +893,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
-	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -951,7 +962,7 @@ restore_all_switch_stack:
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
-	CLEAR_CPU_BUFFERS
+	CLEAR_CPU_BUFFERS_SAFE
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1144,7 +1155,6 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
-	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
@@ -1165,6 +1175,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	CHECK_AND_APPLY_ESPFIX
 	RESTORE_ALL_NMI cr3_reg=%edi pop=4
+	CLEAR_CPU_BUFFERS_SAFE
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1206,6 +1217,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 *  1 - orig_ax
 	 */
 	lss	(1+5+6)*4(%esp), %esp			# back to espfix stack
+	CLEAR_CPU_BUFFERS_SAFE
 	jmp	.Lirq_return
 #endif
 SYM_CODE_END(asm_exc_nmi)

---
base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
change-id: 20240426-fix-dosemu-vm86-dd111a01737e


