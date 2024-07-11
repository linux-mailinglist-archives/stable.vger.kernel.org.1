Return-Path: <stable+bounces-59169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A7292F1A5
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 00:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B711C20826
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 22:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308E516D4E8;
	Thu, 11 Jul 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SW5F7wFq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349954903;
	Thu, 11 Jul 2024 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735427; cv=none; b=m7YVPIVfZk1oTgBrHcwpUW8pc3Tvq6cOyQxkf5qLcCMBLgEpU3KF+dhP+QUNABz+f9lws3uUw19wYOefudXi0wYLXiPwcStXjYoazmPv8wBz3TTw8LfOgKSBwCEdkkcCFD2p8/MDJU148w25R3RtcPGLtcFHODpZ66yfYfYcWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735427; c=relaxed/simple;
	bh=vZ/eekIB62QHGzRjLzJCvVidytw7m8uo1a+YsfLmyOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pjE32Cdyq5SYJrDeE5kyodXdwsWQvx4ycPLV6ktvChNd59EUnru6x1VL/tDzkh2CQ4c0oZH9NSz4kOgXkysrqNdb4+s/Kust8LhbREUnq6krURFE4adPSVIYfZ0vDgLSQvdziHpAYAmW0ZjYvzsxg8O+RNb8i03R8ePDN1ZD2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SW5F7wFq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720735425; x=1752271425;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vZ/eekIB62QHGzRjLzJCvVidytw7m8uo1a+YsfLmyOs=;
  b=SW5F7wFqNfk1JCn4xDt66mbvM33klXxNSuTHr8qmA7Uw3h7pL9Bnzcfa
   lsdAENSRV9YpMb2wlBPegna9XQOfj6mKty7N7Qa1klis1cuZb4AgooZSU
   2HCVyMfOsx6Gvw4YT35Fap1CEaCUJm8iLpY48zh0897Mm6pqOqW845alS
   c9xEXwKc9dSkSNp1x46CSOZAcI3mgH0zyg1MjQwa3OvuWywt8Bb22Yjo2
   SFAjfLP8mTtKb47X9we5KIJe9TvYxJSXmlUGl8XBKMJzBTxh+0STqGY5H
   z2xnjHKIBH/FTXRckiWJGqtlG/9EP7tZQfQAUMGuX+1gHCh1nkyTUcz+o
   g==;
X-CSE-ConnectionGUID: VILHcv+2QOuKY6zym9Y1Lg==
X-CSE-MsgGUID: 0u0XDwerS6aKt6Ked/rgpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28827303"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="28827303"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 15:03:44 -0700
X-CSE-ConnectionGUID: fyH/RCdgTwaQHFAF0Zqwig==
X-CSE-MsgGUID: u0M/yqP4RtiNRI7f2bvx5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="53636196"
Received: from tmsagapo-mobl2.amr.corp.intel.com (HELO desk) ([10.209.8.238])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 15:03:43 -0700
Date: Thu, 11 Jul 2024 15:03:37 -0700
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
Subject: [PATCH v5] x86/entry_32: Use stack segment selector for VERW operand
Message-ID: <20240711-fix-dosemu-vm86-v5-1-e87dcd7368aa@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAD5WkGYC/3XNzW7CMAzA8VdBOS9VnA873Yn3QByyxh2RaDs1E
 IFQ330pFyaVHf+W/fNDZJ4TZ/G5e4iZS8ppGmu4j53oTmH8ZplibaGVtspqlH26yThlHq6yDB5
 ljAAQFJAhFvXqZ+a68hQPx9qnlC/TfH8+KLBO/7cKSJDed15jML0hvz+n8Xpr0njhc9NNg1jFo
 l8KatoquirROWp7bD0TvVfMSyEFW8VU5QtabJ3RHbnwXrF/FFBbxVYlBLRoGSJjv1WWZfkFrez
 Am4YBAAA=
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
v5:
- Simplify the use of ALTERNATIVE construct (Uros/Jiri/Peter).

v4: https://lore.kernel.org/r/20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com
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
 arch/x86/entry/entry_32.S | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d3a814efbff6..25c942149fb5 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -253,6 +253,14 @@
 .Lend_\@:
 .endm
 
+/*
+ * Safer version of CLEAR_CPU_BUFFERS that uses %ss to reference VERW operand
+ * mds_verw_sel. This ensures VERW will not #GP for an arbitrary user %ds.
+ */
+.macro CLEAR_CPU_BUFFERS_SAFE
+	ALTERNATIVE "", __stringify(verw %ss:_ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
+.endm
+
 .macro RESTORE_INT_REGS
 	popl	%ebx
 	popl	%ecx
@@ -871,6 +879,8 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	/* Now ready to switch the cr3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
+	/* Clobbers ZF */
+	CLEAR_CPU_BUFFERS_SAFE
 
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
@@ -881,7 +891,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
-	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -951,7 +960,7 @@ restore_all_switch_stack:
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
-	CLEAR_CPU_BUFFERS
+	CLEAR_CPU_BUFFERS_SAFE
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1144,7 +1153,6 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
-	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
@@ -1165,6 +1173,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	CHECK_AND_APPLY_ESPFIX
 	RESTORE_ALL_NMI cr3_reg=%edi pop=4
+	CLEAR_CPU_BUFFERS_SAFE
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1206,6 +1215,7 @@ SYM_CODE_START(asm_exc_nmi)
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


