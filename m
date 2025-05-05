Return-Path: <stable+bounces-140190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FB9AAA63A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC1687A413C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C162E28E5F0;
	Mon,  5 May 2025 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrWU7Sfw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78B7261B;
	Mon,  5 May 2025 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484301; cv=none; b=VtdOjDh1WNLr7hNga3S7j2qhaaA8o7+YVxFw/cjdmeQ/s2MwfxwPw76i69liokro6fr/Gv88qhi8BoXE7MZtiSlHk8a9Wu9fmljrwzBucNUn2f+p5FyTOMz4ByVtyh/x55O+TI3eQ/H9JfyuR3hy6XYf6ILMLS9dhUNyZmIzJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484301; c=relaxed/simple;
	bh=ygDMfQgwAraTz1hHELlmttpnRaqAKSDNkeZwI9GwHCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RcLd9Dzmg1tLH2hkRE14TKbBAyesGMNcZaUX3DAESVDeI+eT+ac8uUtvmnd0RSr3gsOnnwJF0MZyzrO7Fcc11LHs9hCybxGN9zWa6ApXBy9Hg5RDNKe/M0jnBDwf2/XkqYRyNLJkFxEBI7qy9go9RHTS+PWPwNgTab3U/q+kJcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrWU7Sfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9AEC4CEE4;
	Mon,  5 May 2025 22:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484301;
	bh=ygDMfQgwAraTz1hHELlmttpnRaqAKSDNkeZwI9GwHCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CrWU7Sfw1WJT7pT5ZSdtGeskdvdP9nbVFIGRQ5yifjpW4300bgaL7l6mAR+lYudan
	 4uStHErqRBXJ+BZx2Z74e0aSproMhNI1wZbhFToSw+2Wc45/zwmfpTI/O/0dd4wFQX
	 QreWq1J0jRydT2KUbgvFiGdaDUqGdNpB/TYnZvra5oMNK2D0kuezCZXGEOU//axUz7
	 6Qcy5Z/edpSd8Zf3OPxSnWSZL09YFDjvChp9wXe1bWGC9CAUHgTZA8PnuQrX5RJbmb
	 udfJY/GvwQjYJWBXUDzMnmsqHv6gS2b0LO5MpZVJAQoPHpU12Jj/qBn2iIa9fD6w4K
	 Nw2SUukxDQkGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	kees@kernel.org,
	nathan@kernel.org,
	rppt@kernel.org,
	riel@surriel.com
Subject: [PATCH AUTOSEL 6.14 443/642] x86/ibt: Handle FineIBT in handle_cfi_failure()
Date: Mon,  5 May 2025 18:10:59 -0400
Message-Id: <20250505221419.2672473-443-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 882b86fd4e0d49bf91148dbadcdbece19ded40e6 ]

Sami reminded me that FineIBT failure does not hook into the regular
CFI failure case, and as such CFI_PERMISSIVE does not work.

Reported-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lkml.kernel.org/r/20250214092619.GB21726@noisy.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/cfi.h    | 11 +++++++++++
 arch/x86/kernel/alternative.c | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cfi.c         | 22 ++++++++++++++++++----
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 31d19c815f992..7dd5ab239c87b 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -126,6 +126,17 @@ static inline int cfi_get_offset(void)
 
 extern u32 cfi_get_func_hash(void *func);
 
+#ifdef CONFIG_FINEIBT
+extern bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type);
+#else
+static inline bool
+decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+{
+	return false;
+}
+
+#endif
+
 #else
 static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c71b575bf2292..f9ada11c910e1 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1080,6 +1080,7 @@ asm(	".pushsection .rodata			\n"
 	"	endbr64				\n"
 	"	subl	$0x12345678, %r10d	\n"
 	"	je	fineibt_preamble_end	\n"
+	"fineibt_preamble_ud2:			\n"
 	"	ud2				\n"
 	"	nop				\n"
 	"fineibt_preamble_end:			\n"
@@ -1087,9 +1088,11 @@ asm(	".pushsection .rodata			\n"
 );
 
 extern u8 fineibt_preamble_start[];
+extern u8 fineibt_preamble_ud2[];
 extern u8 fineibt_preamble_end[];
 
 #define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
+#define fineibt_preamble_ud2  (fineibt_preamble_ud2 - fineibt_preamble_start)
 #define fineibt_preamble_hash 7
 
 asm(	".pushsection .rodata			\n"
@@ -1407,6 +1410,33 @@ static void poison_cfi(void *addr, void *wr_addr)
 	}
 }
 
+/*
+ * regs->ip points to a UD2 instruction, return true and fill out target and
+ * type when this UD2 is from a FineIBT preamble.
+ *
+ * We check the preamble by checking for the ENDBR instruction relative to the
+ * UD2 instruction.
+ */
+bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+{
+	unsigned long addr = regs->ip - fineibt_preamble_ud2;
+	u32 endbr, hash;
+
+	__get_kernel_nofault(&endbr, addr, u32, Efault);
+	if (endbr != gen_endbr())
+		return false;
+
+	*target = addr + fineibt_preamble_size;
+
+	__get_kernel_nofault(&hash, addr + fineibt_preamble_hash, u32, Efault);
+	*type = (u32)regs->r10 + hash;
+
+	return true;
+
+Efault:
+	return false;
+}
+
 #else
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
diff --git a/arch/x86/kernel/cfi.c b/arch/x86/kernel/cfi.c
index e6bf78fac1462..f6905bef0af84 100644
--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -70,11 +70,25 @@ enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 	unsigned long target;
 	u32 type;
 
-	if (!is_cfi_trap(regs->ip))
-		return BUG_TRAP_TYPE_NONE;
+	switch (cfi_mode) {
+	case CFI_KCFI:
+		if (!is_cfi_trap(regs->ip))
+			return BUG_TRAP_TYPE_NONE;
+
+		if (!decode_cfi_insn(regs, &target, &type))
+			return report_cfi_failure_noaddr(regs, regs->ip);
+
+		break;
 
-	if (!decode_cfi_insn(regs, &target, &type))
-		return report_cfi_failure_noaddr(regs, regs->ip);
+	case CFI_FINEIBT:
+		if (!decode_fineibt_insn(regs, &target, &type))
+			return BUG_TRAP_TYPE_NONE;
+
+		break;
+
+	default:
+		return BUG_TRAP_TYPE_NONE;
+	}
 
 	return report_cfi_failure(regs, regs->ip, &target, type);
 }
-- 
2.39.5


