Return-Path: <stable+bounces-140782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D11AAAF51
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047C53BE620
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE0C3ACFD2;
	Mon,  5 May 2025 23:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAThlzcm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E2428750D;
	Mon,  5 May 2025 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486228; cv=none; b=MUz0AIMdONykbbTIAam2dITyEc0QUj3pL/l4YVqePQLMHH7Bi7g265wCaE4vTBgi3MCcrpjCX8/yLRLmn4Ip6eeKYUjnXNK7l7nO5CcUPY4Yrf6i8N1JzXtV8fvmmZ82FtLOc5qLgbLfbe9+eQcqF9GbvBMXRkkQ1coYRPGy+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486228; c=relaxed/simple;
	bh=Uyc7rpHSIVvxqagGUO5TBqpU3JM23OyxHyhq/1pJGMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z24smMcgfSdRqXuQpjhAhR98Bb9ozRB+OAY/mLTeLtEct3MkQYCSFEsUmLna0R0uanY/c4M8UmbD+fqS5TGdDwypHD6uLIS2MYypgvfiG8D8Ij3OuVROCqVCAcKGBFjnOXWjuegLd0GKpfIFYQyrwWrOiNo2EuZQFWcfEZuvVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAThlzcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95070C4CEED;
	Mon,  5 May 2025 23:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486227;
	bh=Uyc7rpHSIVvxqagGUO5TBqpU3JM23OyxHyhq/1pJGMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AAThlzcmjXZMD0HtbUfSSaZrjshex/avLX01ZjMLFBE0mVzLY9cVVFQ021mFGJf3w
	 YklqGbszFqLZHQ2VyolqcTPiQbCp8hp8jnc34H83JDRZgUP4ahows9Y5CWs6zF7tQf
	 7g+rO8C2lKm9+rHiww4RC9/Z2iwWMnIQqhetjTe35Ij0iJUHYGJYVIH6oPj6cEgQLF
	 c0hvpQ6KQMSvD18zn4e1gp01lwrfZbQIoch5PwVeF/YSdGnnh1s52gZqVsqR9Mjtm4
	 6ypqo5zqCexfAqXNqNc43mMGlgJEH2bHBhNWNDMcKLqUH5j5Db++pO1WjVypPkMizM
	 MILHHxXwxM0Dg==
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
	jpoimboe@kernel.org,
	kees@kernel.org,
	gatlin.newhouse@gmail.com,
	ast@kernel.org,
	thuth@redhat.com,
	xin@zytor.com,
	snovitoll@gmail.com
Subject: [PATCH AUTOSEL 6.6 217/294] x86/traps: Cleanup and robustify decode_bug()
Date: Mon,  5 May 2025 18:55:17 -0400
Message-Id: <20250505225634.2688578-217-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit c20ad96c9a8f0aeaf4e4057730a22de2657ad0c2 ]

Notably, don't attempt to decode an immediate when MOD == 3.

Additionally have it return the instruction length, such that WARN
like bugs can more reliably skip to the correct instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20250207122546.721120726@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/bug.h |  5 ++-
 arch/x86/include/asm/ibt.h |  4 +-
 arch/x86/kernel/traps.c    | 82 ++++++++++++++++++++++++++++----------
 3 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 806649c7f23dc..9a0f29be1a9ea 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -22,8 +22,9 @@
 #define SECOND_BYTE_OPCODE_UD2	0x0b
 
 #define BUG_NONE		0xffff
-#define BUG_UD1			0xfffe
-#define BUG_UD2			0xfffd
+#define BUG_UD2			0xfffe
+#define BUG_UD1			0xfffd
+#define BUG_UD1_UBSAN		0xfffc
 
 #ifdef CONFIG_GENERIC_BUG
 
diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 1e59581d500ca..b778ae6e67ee8 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -41,7 +41,7 @@
 	_ASM_PTR fname "\n\t"				\
 	".popsection\n\t"
 
-static inline __attribute_const__ u32 gen_endbr(void)
+static __always_inline __attribute_const__ u32 gen_endbr(void)
 {
 	u32 endbr;
 
@@ -56,7 +56,7 @@ static inline __attribute_const__ u32 gen_endbr(void)
 	return endbr;
 }
 
-static inline __attribute_const__ u32 gen_endbr_poison(void)
+static __always_inline __attribute_const__ u32 gen_endbr_poison(void)
 {
 	/*
 	 * 4 byte NOP that isn't NOP4 (in fact it is OSP NOP3), such that it
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d8d9bc5a9b328..8718d58dd0fbe 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -92,10 +92,17 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
 
 /*
  * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
- * If it's a UD1, get the ModRM byte to pass along to UBSan.
+ * If it's a UD1, further decode to determine its use:
+ *
+ * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
+ * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
+ * static_call:  0f b9 cc                ud1    %esp,%ecx
+ *
+ * Notably UBSAN uses EAX, static_call uses ECX.
  */
-__always_inline int decode_bug(unsigned long addr, u32 *imm)
+__always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 {
+	unsigned long start = addr;
 	u8 v;
 
 	if (addr < TASK_SIZE_MAX)
@@ -108,24 +115,42 @@ __always_inline int decode_bug(unsigned long addr, u32 *imm)
 		return BUG_NONE;
 
 	v = *(u8 *)(addr++);
-	if (v == SECOND_BYTE_OPCODE_UD2)
+	if (v == SECOND_BYTE_OPCODE_UD2) {
+		*len = addr - start;
 		return BUG_UD2;
+	}
 
-	if (!IS_ENABLED(CONFIG_UBSAN_TRAP) || v != SECOND_BYTE_OPCODE_UD1)
+	if (v != SECOND_BYTE_OPCODE_UD1)
 		return BUG_NONE;
 
-	/* Retrieve the immediate (type value) for the UBSAN UD1 */
-	v = *(u8 *)(addr++);
-	if (X86_MODRM_RM(v) == 4)
-		addr++;
-
 	*imm = 0;
-	if (X86_MODRM_MOD(v) == 1)
-		*imm = *(u8 *)addr;
-	else if (X86_MODRM_MOD(v) == 2)
-		*imm = *(u32 *)addr;
-	else
-		WARN_ONCE(1, "Unexpected MODRM_MOD: %u\n", X86_MODRM_MOD(v));
+	v = *(u8 *)(addr++);		/* ModRM */
+
+	if (X86_MODRM_MOD(v) != 3 && X86_MODRM_RM(v) == 4)
+		addr++;			/* SIB */
+
+	/* Decode immediate, if present */
+	switch (X86_MODRM_MOD(v)) {
+	case 0: if (X86_MODRM_RM(v) == 5)
+			addr += 4; /* RIP + disp32 */
+		break;
+
+	case 1: *imm = *(s8 *)addr;
+		addr += 1;
+		break;
+
+	case 2: *imm = *(s32 *)addr;
+		addr += 4;
+		break;
+
+	case 3: break;
+	}
+
+	/* record instruction length */
+	*len = addr - start;
+
+	if (X86_MODRM_REG(v) == 0)	/* EAX */
+		return BUG_UD1_UBSAN;
 
 	return BUG_UD1;
 }
@@ -256,10 +281,10 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled = false;
-	int ud_type;
-	u32 imm;
+	int ud_type, ud_len;
+	s32 ud_imm;
 
-	ud_type = decode_bug(regs->ip, &imm);
+	ud_type = decode_bug(regs->ip, &ud_imm, &ud_len);
 	if (ud_type == BUG_NONE)
 		return handled;
 
@@ -279,15 +304,28 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 */
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_enable();
-	if (ud_type == BUG_UD2) {
+
+	switch (ud_type) {
+	case BUG_UD2:
 		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
 		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
-			regs->ip += LEN_UD2;
+			regs->ip += ud_len;
 			handled = true;
 		}
-	} else if (IS_ENABLED(CONFIG_UBSAN_TRAP)) {
-		pr_crit("%s at %pS\n", report_ubsan_failure(regs, imm), (void *)regs->ip);
+		break;
+
+	case BUG_UD1_UBSAN:
+		if (IS_ENABLED(CONFIG_UBSAN_TRAP)) {
+			pr_crit("%s at %pS\n",
+				report_ubsan_failure(regs, ud_imm),
+				(void *)regs->ip);
+		}
+		break;
+
+	default:
+		break;
 	}
+
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
 	instrumentation_end();
-- 
2.39.5


