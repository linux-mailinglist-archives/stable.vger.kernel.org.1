Return-Path: <stable+bounces-16536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD48840D5F
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68262830C0
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49E415B118;
	Mon, 29 Jan 2024 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jjP7DeW9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8189415B110;
	Mon, 29 Jan 2024 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548092; cv=none; b=tx+uwdMSwPBmpIGNYKMaB1yhkABwvq2XkzMhAeURm9OOLf4mkSEVhrrliNIlbe/yFfJ6wU6ZiTM89XNPb7YOMy8DctugzJy3YO+58gaw6AtVlIesnkQqGDLtq+hxgByysSK+feGAoXIM6fVq1ujLVa63WZL+fcGMZhYD9wQVsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548092; c=relaxed/simple;
	bh=mmdHzE7uf8hTa4B8LRlmlFVgWkmR/9n2DJU5t9gXr2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ0e7SIoO7XMML5IAfZWtvc9GQW8rrapcycasYvbWJdutOoqg/eh6kUembfbMu64Mjc7ZW4msc/1c9G0824WziVFY/eddI/q8mI8Y5bGgX5+bsFeVJCGnmUx1diZEscu6/vz2gfpQ4KfA4IVx843fKCZ8t6BhqfFd4UQE89QHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jjP7DeW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D317C43390;
	Mon, 29 Jan 2024 17:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548092;
	bh=mmdHzE7uf8hTa4B8LRlmlFVgWkmR/9n2DJU5t9gXr2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjP7DeW9UhO/8OnQ+rGVI3twBp/he8hj3UqtdD17gu5tl/r3clACmUfaiQeCqjG9e
	 VwpDEf9sglqp8PRY9R+/ognLGj1+kjUYZHD/P02cEiJCxQ+4xwahhZ7hakAM5mlKL2
	 JlDMq1mjHLvIhND5I4nRCr1BhadLylmY4tdgVt2g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>,
	Rob Herring <robh@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.7 108/346] arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
Date: Mon, 29 Jan 2024 09:02:19 -0800
Message-ID: <20240129170019.575292043@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit 832dd634bd1b4e3bbe9f10b9c9ba5db6f6f2b97f upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

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



