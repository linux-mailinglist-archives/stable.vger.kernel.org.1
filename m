Return-Path: <stable+bounces-11330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EF582ED51
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 12:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F64CB2376F
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74361A59E;
	Tue, 16 Jan 2024 11:02:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C95A1AAA0
	for <stable@vger.kernel.org>; Tue, 16 Jan 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 602672F4;
	Tue, 16 Jan 2024 03:03:18 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2EF213F766;
	Tue, 16 Jan 2024 03:02:30 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	robh@kernel.org,
	stable@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 1/2] arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
Date: Tue, 16 Jan 2024 11:02:20 +0000
Message-Id: <20240116110221.420467-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240116110221.420467-1-mark.rutland@arm.com>
References: <20240116110221.420467-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fixes: 471470bc7052d28c ("arm64: errata: Add Cortex-A520 speculative unprivileged load workaround")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/entry.S | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 544ab46649f3f..7fcbee0f6c0e4 100644
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
-- 
2.30.2


