Return-Path: <stable+bounces-11329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1905C82ED50
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 12:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A540028568C
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D841A59C;
	Tue, 16 Jan 2024 11:02:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9881AAA1
	for <stable@vger.kernel.org>; Tue, 16 Jan 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15D371063;
	Tue, 16 Jan 2024 03:03:22 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DBA6A3F766;
	Tue, 16 Jan 2024 03:02:33 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	robh@kernel.org,
	stable@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 2/2] arm64: entry: simplify kernel_exit logic
Date: Tue, 16 Jan 2024 11:02:21 +0000
Message-Id: <20240116110221.420467-3-mark.rutland@arm.com>
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

For historical reasons, the non-KPTI exception return path is duplicated for
EL1 and EL0, with the structure:

	.if \el == 0
	[ KPTI handling ]
	ldr     lr, [sp, #S_LR]
 	add	sp, sp, #PT_REGS_SIZE		// restore sp
	[ EL0 exception return workaround ]
	eret
	.else
	ldr     lr, [sp, #S_LR]
 	add	sp, sp, #PT_REGS_SIZE		// restore sp
	[ EL1 exception return workaround ]
	eret
	.endif
	sb

This would be simpler and clearer with the common portions factored out,
e.g.

	.if \el == 0
	[ KPTI handling ]
	.endif

	ldr     lr, [sp, #S_LR]
 	add	sp, sp, #PT_REGS_SIZE		// restore sp

	.if \el == 0
	[ EL0 exception return workaround ]
	.else
	[ EL1 exception return workaround ]
	.endif

	eret
	sb

This expands to the same code, but is simpler for a human to follow as
it avoids duplicates the restore of LR+SP, and makes it clear that the
ERET is associated with the SB.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/entry.S | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7fcbee0f6c0e4..7ef0e127b149f 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -442,24 +442,23 @@ alternative_else_nop_endif
 
 .L_skip_tramp_exit_\@:
 #endif
+	.endif
+
 	ldr	lr, [sp, #S_LR]
 	add	sp, sp, #PT_REGS_SIZE		// restore sp
 
+	.if \el == 0
 	/* This must be after the last explicit memory access */
 alternative_if ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
 	tlbi	vale1, xzr
 	dsb	nsh
 alternative_else_nop_endif
-	eret
 	.else
-	ldr	lr, [sp, #S_LR]
-	add	sp, sp, #PT_REGS_SIZE		// restore sp
-
 	/* Ensure any device/NC reads complete */
 	alternative_insn nop, "dmb sy", ARM64_WORKAROUND_1508412
+	.endif
 
 	eret
-	.endif
 	sb
 	.endm
 
-- 
2.30.2


