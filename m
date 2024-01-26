Return-Path: <stable+bounces-16004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2207583E66D
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE0D28AB53
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B023159144;
	Fri, 26 Jan 2024 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v6jzU5nc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E059142
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310875; cv=none; b=L/lXRb/jM+RwL1IRcmNpPQT+IsiTxB2gOB6cYWmzO5rl5XDmuNX6uJVZw5kPIajMzyeaXL1lwVVXRhZnYDY5o6Dkl9/fttpzLJ6cqzWffLshl4ZAl/inDjg9pp4qxU/Zjj6aZPrleQWZSO9h/IuhmACBTB3SHXAFWL0kRZOL2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310875; c=relaxed/simple;
	bh=nTFAvHrOFHjls0US+R66Guv6BxptMv+b4PZY8uzn2m0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EyDBA1YtjQE8KFC1m5fpcD1BztcjksuoEOSRwxFdyrM7JEhs7Hdz4DKGl6rdk4e8DKMuXtnG19Yh0gTUpugxwsLHu8pn4Ebd/ZlN+1K+NfYRXe8X3giQ+wJz8Wuoy/iyYX/rBOip/kSfAprHYmOA0bQvMIzOT/rE3uxSPAjkojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v6jzU5nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2E3C433C7;
	Fri, 26 Jan 2024 23:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706310875;
	bh=nTFAvHrOFHjls0US+R66Guv6BxptMv+b4PZY8uzn2m0=;
	h=Subject:To:Cc:From:Date:From;
	b=v6jzU5ncwePOYXVaUNZLRuIswC4XqqsyasV7L/Rjss4sLKPCZzja0KyJU5a5RAbOW
	 az/ehknbcnA3WdPoY8yFZ5eSehexq1wLjL3Y/4jJKi6X9XW6+RPEiggE7A7gBG6SUC
	 2as+4zXelAXr04w8kOqrwPXFpgr30sZdPjSlSlZY=
Subject: FAILED: patch "[PATCH] arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD" failed to apply to 6.1-stable tree
To: mark.rutland@arm.com,catalin.marinas@arm.com,james.morse@arm.com,robh@kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:14:34 -0800
Message-ID: <2024012633-expenses-vastly-81bc@gregkh>
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
git cherry-pick -x 832dd634bd1b4e3bbe9f10b9c9ba5db6f6f2b97f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012633-expenses-vastly-81bc@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

832dd634bd1b ("arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD")
546b7cde9b1d ("arm64: Rename ARM64_WORKAROUND_2966298")
471470bc7052 ("arm64: errata: Add Cortex-A520 speculative unprivileged load workaround")
cce8365fc47b ("arm64: errata: Group all Cortex-A510 errata together")
e8069f5a8e3b ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 832dd634bd1b4e3bbe9f10b9c9ba5db6f6f2b97f Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 16 Jan 2024 11:02:20 +0000
Subject: [PATCH] arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD

Currently the ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD workaround isn't
quite right, as it is supposed to be applied after the last explicit
memory access, but is immediately followed by an LDR.

The ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD workaround is used to
handle Cortex-A520 erratum 2966298 and Cortex-A510 erratum 3117295,
which are described in:

* https://developer.arm.com/documentation/SDEN2444153/0600/?lang=en
* https://developer.arm.com/documentation/SDEN1873361/1600/?lang=en

In both cases the workaround is described as:

| If pagetable isolation is disabled, the context switch logic in the
| kernel can be updated to execute the following sequence on affected
| cores before exiting to EL0, and after all explicit memory accesses:
|
| 1. A non-shareable TLBI to any context and/or address, including
|    unused contexts or addresses, such as a `TLBI VALE1 Xzr`.
|
| 2. A DSB NSH to guarantee completion of the TLBI.

The important part being that the TLBI+DSB must be placed "after all
explicit memory accesses".

Unfortunately, as-implemented, the TLBI+DSB is immediately followed by
an LDR, as we have:

| alternative_if ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
| 	tlbi	vale1, xzr
| 	dsb	nsh
| alternative_else_nop_endif
| alternative_if_not ARM64_UNMAP_KERNEL_AT_EL0
| 	ldr	lr, [sp, #S_LR]
| 	add	sp, sp, #PT_REGS_SIZE		// restore sp
| 	eret
| alternative_else_nop_endif
|
| [ ... KPTI exception return path ... ]

This patch fixes this by reworking the logic to place the TLBI+DSB
immediately before the ERET, after all explicit memory accesses.

The ERET is currently in a separate alternative block, and alternatives
cannot be nested. To account for this, the alternative block for
ARM64_UNMAP_KERNEL_AT_EL0 is replaced with a single alternative branch
to skip the KPTI logic, with the new shape of the logic being:

| alternative_insn "b .L_skip_tramp_exit_\@", nop, ARM64_UNMAP_KERNEL_AT_EL0
| 	[ ... KPTI exception return path ... ]
| .L_skip_tramp_exit_\@:
|
| 	ldr	lr, [sp, #S_LR]
| 	add	sp, sp, #PT_REGS_SIZE		// restore sp
|
| alternative_if ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
| 	tlbi	vale1, xzr
| 	dsb	nsh
| alternative_else_nop_endif
| 	eret

The new structure means that the workaround is only applied when KPTI is
not in use; this is fine as noted in the documented implications of the
erratum:

| Pagetable isolation between EL0 and higher level ELs prevents the
| issue from occurring.

... and as per the workaround description quoted above, the workaround
is only necessary "If pagetable isolation is disabled".

Fixes: 471470bc7052 ("arm64: errata: Add Cortex-A520 speculative unprivileged load workaround")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240116110221.420467-2-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 544ab46649f3..7fcbee0f6c0e 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -428,16 +428,9 @@ alternative_else_nop_endif
 	ldp	x28, x29, [sp, #16 * 14]
 
 	.if	\el == 0
-alternative_if ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
-	tlbi	vale1, xzr
-	dsb	nsh
-alternative_else_nop_endif
-alternative_if_not ARM64_UNMAP_KERNEL_AT_EL0
-	ldr	lr, [sp, #S_LR]
-	add	sp, sp, #PT_REGS_SIZE		// restore sp
-	eret
-alternative_else_nop_endif
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	alternative_insn "b .L_skip_tramp_exit_\@", nop, ARM64_UNMAP_KERNEL_AT_EL0
+
 	msr	far_el1, x29
 
 	ldr_this_cpu	x30, this_cpu_vector, x29
@@ -446,7 +439,18 @@ alternative_else_nop_endif
 	ldr		lr, [sp, #S_LR]		// restore x30
 	add		sp, sp, #PT_REGS_SIZE	// restore sp
 	br		x29
+
+.L_skip_tramp_exit_\@:
 #endif
+	ldr	lr, [sp, #S_LR]
+	add	sp, sp, #PT_REGS_SIZE		// restore sp
+
+	/* This must be after the last explicit memory access */
+alternative_if ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
+	tlbi	vale1, xzr
+	dsb	nsh
+alternative_else_nop_endif
+	eret
 	.else
 	ldr	lr, [sp, #S_LR]
 	add	sp, sp, #PT_REGS_SIZE		// restore sp


