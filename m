Return-Path: <stable+bounces-83059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 592009953E2
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FD72870B5
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E71DFE00;
	Tue,  8 Oct 2024 15:59:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA89D1E0B64
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403142; cv=none; b=BDbOGbRUDknFHT8PTkmWKFNixg0B2r/1gN4oGQ9mPCYWwBIAzTY8KBlUnPW36kowMMbLXQkPrB012ujlmQJerwFvtSprg/PPzFeteMjOTbXr2Ukl7UIArjCUiki3hm7KKkT82sJ0GIUModqkbpUBZoeYfFBz7gIetJp8u2Trfw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403142; c=relaxed/simple;
	bh=crDgjxjOvO4V+H3CYqiqLZEw+oTp9+7ix7UjbdQBIdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XmBQcrbTZJOaczh1Zzi31xSXwr/7VrebXEh/Z+bJipz2m8/sFK7opuJtaeSrjafU3WzyYVJN/ZyTuzyEZgcTS4HoRCGmwXkkIwkMwX19z2DXAWtFHolqLqC7bqFGQpRHuFkLkUhWEfTq5aJ5NBY5wvfT4SSVaDWb+ghDwE6C/ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FA93FEC;
	Tue,  8 Oct 2024 08:59:29 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 158613F73F;
	Tue,  8 Oct 2024 08:58:58 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	catalin.marnias@arm.com,
	mark.rutland@arm.com,
	stable@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 1/6] arm64: probes: Remove broken LDR (literal) uprobe support
Date: Tue,  8 Oct 2024 16:58:46 +0100
Message-Id: <20241008155851.801546-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241008155851.801546-1-mark.rutland@arm.com>
References: <20241008155851.801546-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The simulate_ldr_literal() and simulate_ldrsw_literal() functions are
unsafe to use for uprobes. Both functions were originally written for
use with kprobes, and access memory with plain C accesses. When uprobes
was added, these were reused unmodified even though they cannot safely
access user memory.

There are three key problems:

1) The plain C accesses do not have corresponding extable entries, and
   thus if they encounter a fault the kernel will treat these as
   unintentional accesses to user memory, resulting in a BUG() which
   will kill the kernel thread, and likely lead to further issues (e.g.
   lockup or panic()).

2) The plain C accesses are subject to HW PAN and SW PAN, and so when
   either is in use, any attempt to simulate an access to user memory
   will fault. Thus neither simulate_ldr_literal() nor
   simulate_ldrsw_literal() can do anything useful when simulating a
   user instruction on any system with HW PAN or SW PAN.

3) The plain C accesses are privileged, as they run in kernel context,
   and in practice can access a small range of kernel virtual addresses.
   The instructions they simulate have a range of +/-1MiB, and since the
   simulated instructions must itself be a user instructions in the
   TTBR0 address range, these can address the final 1MiB of the TTBR1
   acddress range by wrapping downwards from an address in the first
   1MiB of the TTBR0 address range.

   In contemporary kernels the last 8MiB of TTBR1 address range is
   reserved, and accesses to this will always fault, meaning this is no
   worse than (1).

   Historically, it was theoretically possible for the linear map or
   vmemmap to spill into the final 8MiB of the TTBR1 address range, but
   in practice this is extremely unlikely to occur as this would
   require either:

   * Having enough physical memory to fill the entire linear map all the
     way to the final 1MiB of the TTBR1 address range.

   * Getting unlucky with KASLR randomization of the linear map such
     that the populated region happens to overlap with the last 1MiB of
     the TTBR address range.

   ... and in either case if we were to spill into the final page there
   would be larger problems as the final page would alias with error
   pointers.

Practically speaking, (1) and (2) are the big issues. Given there have
been no reports of problems since the broken code was introduced, it
appears that no-one is relying on probing these instructions with
uprobes.

Avoid these issues by not allowing uprobes on LDR (literal) and LDRSW
(literal), limiting the use of simulate_ldr_literal() and
simulate_ldrsw_literal() to kprobes. Attempts to place uprobes on LDR
(literal) and LDRSW (literal) will be rejected as
arm_probe_decode_insn() will return INSN_REJECTED. In future we can
consider introducing working uprobes support for these instructions, but
this will require more significant work.

Fixes: 9842ceae9fa8deae ("arm64: Add uprobe support")
Cc: stable@vger.kernel.org
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/probes/decode-insn.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index 968d5fffe2330..3496d6169e59b 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -99,10 +99,6 @@ arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api)
 	    aarch64_insn_is_blr(insn) ||
 	    aarch64_insn_is_ret(insn)) {
 		api->handler = simulate_br_blr_ret;
-	} else if (aarch64_insn_is_ldr_lit(insn)) {
-		api->handler = simulate_ldr_literal;
-	} else if (aarch64_insn_is_ldrsw_lit(insn)) {
-		api->handler = simulate_ldrsw_literal;
 	} else {
 		/*
 		 * Instruction cannot be stepped out-of-line and we don't
@@ -140,6 +136,17 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
 	probe_opcode_t insn = le32_to_cpu(*addr);
 	probe_opcode_t *scan_end = NULL;
 	unsigned long size = 0, offset = 0;
+	struct arch_probe_insn *api = &asi->api;
+
+	if (aarch64_insn_is_ldr_lit(insn)) {
+		api->handler = simulate_ldr_literal;
+		decoded = INSN_GOOD_NO_SLOT;
+	} else if (aarch64_insn_is_ldrsw_lit(insn)) {
+		api->handler = simulate_ldrsw_literal;
+		decoded = INSN_GOOD_NO_SLOT;
+	} else {
+		decoded = arm_probe_decode_insn(insn, &asi->api);
+	}
 
 	/*
 	 * If there's a symbol defined in front of and near enough to
@@ -157,7 +164,6 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
 		else
 			scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
 	}
-	decoded = arm_probe_decode_insn(insn, &asi->api);
 
 	if (decoded != INSN_REJECTED && scan_end)
 		if (is_probed_address_atomic(addr - 1, scan_end))
-- 
2.30.2


