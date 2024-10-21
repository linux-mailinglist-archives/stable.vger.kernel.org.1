Return-Path: <stable+bounces-87021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2AD9A5E4A
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7538FB24B0E
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 08:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031AA1E1A37;
	Mon, 21 Oct 2024 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w9QUNcpB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA91E0E11
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498412; cv=none; b=KDDDaNNXHLWUSJEFDtOW3RKHQw5M1N7OsHb4pU4QxSJ6Sc2E6nKjZjCj0a8R/pha/R5oLBlxd1kpN9nyrTxAzn/1/8+8o9xrJzDIYeTPpkyvrsN0jszD9va6E0gfuXAR4JWbzK2aqjP6CQW1gTnKbYqJVcmUlojtvN8W3aAK0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498412; c=relaxed/simple;
	bh=n+ep29R2pnauZNuvIVK4SgV3+3gyR8oqdoLKH+UadIo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JB8kfoBRxWNERYBP2juCplo51x2Asxp8L1idLGmL/CVEp4R0/F0tk/sJby9LifyLLoZDVYj2mqTCLmHRFw+2d9bPALupo9IXM3s26zl9AfhzFPRmRa1OtO+4Ez9ll3t85RmjqEbD4FXqQntUXyRX60cUdJMuBdwChM1Rh/UGgRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w9QUNcpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD83CC4CEC3;
	Mon, 21 Oct 2024 08:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729498412;
	bh=n+ep29R2pnauZNuvIVK4SgV3+3gyR8oqdoLKH+UadIo=;
	h=Subject:To:Cc:From:Date:From;
	b=w9QUNcpBlzR6bWG8yipw1ReR5qcEHM233ONHL6F1Iyu5s3vxxSWlMGGEN1EUA1r9G
	 VmJvr7j0oX/aHMmYfUzZu0/2T8OV25K97c4/2fc9jrLvES7+lBIV3a1dBkGLiMtv5F
	 eAPar1wafgcHg4g9iv9AJ3Opj3ZxxgRg/pJX6TwE=
Subject: FAILED: patch "[PATCH] x86/bugs: Use code segment selector for VERW operand" failed to apply to 6.1-stable tree
To: pawan.kumar.gupta@linux.intel.com,andrew.cooper3@citrix.com,brgerst@gmail.com,dave.hansen@linux.intel.com,mingo@kernel.org,rtgill82@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Oct 2024 10:13:29 +0200
Message-ID: <2024102128-omega-phosphate-db6c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e4d2102018542e3ae5e297bc6e229303abff8a0f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102128-omega-phosphate-db6c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e4d2102018542e3ae5e297bc6e229303abff8a0f Mon Sep 17 00:00:00 2001
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Date: Thu, 26 Sep 2024 09:10:31 -0700
Subject: [PATCH] x86/bugs: Use code segment selector for VERW operand

Robert Gill reported below #GP in 32-bit mode when dosemu software was
executing vm86() system call:

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

This only happens in 32-bit mode when VERW based mitigations like MDS/RFDS
are enabled. This is because segment registers with an arbitrary user value
can result in #GP when executing VERW. Intel SDM vol. 2C documents the
following behavior for VERW instruction:

  #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
	   FS, or GS segment limit.

CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
space. Use %cs selector to reference VERW operand. This ensures VERW will
not #GP for an arbitrary user %ds.

[ mingo: Fixed the SOB chain. ]

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Reported-by: Robert Gill <rtgill82@gmail.com>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com
Cc: stable@vger.kernel.org # 5.10+
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index ff5f1ecc7d1e..96b410b1d4e8 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -323,7 +323,16 @@
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
 .macro CLEAR_CPU_BUFFERS
-	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
+#ifdef CONFIG_X86_64
+	ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
+#else
+	/*
+	 * In 32bit mode, the memory operand must be a %cs reference. The data
+	 * segments may not be usable (vm86 mode), and the stack segment may not
+	 * be flat (ESPFIX32).
+	 */
+	ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
+#endif
 .endm
 
 #ifdef CONFIG_X86_64


