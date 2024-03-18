Return-Path: <stable+bounces-28369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FED87EA40
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 14:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337001C21951
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 13:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88838481AD;
	Mon, 18 Mar 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lc6mVryB"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11203481C4
	for <stable@vger.kernel.org>; Mon, 18 Mar 2024 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710769184; cv=none; b=p9xwWu81KqeXZwnSo4rx0VYq5G0k6/uO5nm5eCkbOVSkA4f77A6oG69/10mogzuOjREmvB7KO1ZoJ+NzOtkwI4s773I22YnvVEsPjxvIJ1g43Ih9/hB0OwODT6x4wl7LyNkLZ3ilEbZN4FTShcHvhahuW1P0E1N+j+rDjRhqc+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710769184; c=relaxed/simple;
	bh=OamlWWKapDrJayCRu2fd2Ie/uOpkZsxSMDs48v+jaZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p4DqieIqxWSWNAJj0iy7k/xFqDzm9XGTXuhAYqs3xo6Vml4vJLnSYo0f+10ZN0dDuCdb4jr9Z2Efs2dvAi6Y7AJpd1XyUvm2GjsPLpWaZTbPY5jnmujely1GJChA9dt5aIxXa1cGoj6POOFSfx8mwaoFr0wtcSJ0VuQ/0WGJcm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lc6mVryB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fwYI/q4BkJ9XMZXCLiyktoY6jMJYS+i2dyAHieL6DBU=; b=lc6mVryBORTUjMSjoq8Ns/a16G
	BYqW4Zvl+VmAIQlYgwUEdfmwWxGiAJJ+Er/lcMdrhG37t/w0aY4AIno4r/WtVkZYm3M6fQuA6hRSs
	bNJuVis+oJlz4a1yiDbfTsGtMEvnePLErdO55A2pAkissYKm8tEAGg3EqgegQH/isFwQeOesdqVA4
	OTv/RDlvKdaJ6vOaZViCKXIK/8L4ruK5AMr8C+aGUx0W9/eW6GkK+tmJZHo+HGo0GaWY+/lyO2u3y
	vfkCNO0z7ejOPJXcN/bZCsMA9mPjgHPYC+FLNucd3toW3ve3tsODfEWfbLALaE0woedF5YWiPlea2
	9GtpFvvA==;
Received: from 179-125-79-213-dinamico.pombonet.net.br ([179.125.79.213] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rmDDH-00Bxw2-6m; Mon, 18 Mar 2024 14:39:39 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	kernel-dev@igalia.com
Subject: [PATCH 5.15 v2 3/3] x86/static_call: Add support for Jcc tail-calls
Date: Mon, 18 Mar 2024 10:39:07 -0300
Message-Id: <20240318133907.2108491-4-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318133907.2108491-1-cascardo@igalia.com>
References: <20240318133907.2108491-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

commit 923510c88d2b7d947c4217835fd9ca6bd65cc56c upstream.

Clang likes to create conditional tail calls like:

  0000000000000350 <amd_pmu_add_event>:
  350:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1) 351: R_X86_64_NONE      __fentry__-0x4
  355:       48 83 bf 20 01 00 00 00         cmpq   $0x0,0x120(%rdi)
  35d:       0f 85 00 00 00 00       jne    363 <amd_pmu_add_event+0x13>     35f: R_X86_64_PLT32     __SCT__amd_pmu_branch_add-0x4
  363:       e9 00 00 00 00          jmp    368 <amd_pmu_add_event+0x18>     364: R_X86_64_PLT32     __x86_return_thunk-0x4

Where 0x35d is a static call site that's turned into a conditional
tail-call using the Jcc class of instructions.

Teach the in-line static call text patching about this.

Notably, since there is no conditional-ret, in that case patch the Jcc
to point at an empty stub function that does the ret -- or the return
thunk when needed.

Reported-by: "Erhard F." <erhard_f@mailbox.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/Y9Kdg9QjHkr9G5b5@hirez.programming.kicks-ass.net
[nathan: Backport to 6.1:
         - Use __x86_return_thunk instead of x86_return_thunk for func in
           __static_call_transform()
         - Remove ASM_FUNC_ALIGN in __static_call_return() asm, as call
           depth tracking was merged in 6.2]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[cascardo: __static_call_validate didn't have the bool tramp argument]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 arch/x86/kernel/static_call.c | 49 ++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index e25050c7ff1e..94378f202c50 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -9,6 +9,7 @@ enum insn_type {
 	NOP = 1,  /* site cond-call */
 	JMP = 2,  /* tramp / site tail-call */
 	RET = 3,  /* tramp / site cond-tail-call */
+	JCC = 4,
 };
 
 /*
@@ -25,12 +26,39 @@ static const u8 xor5rax[] = { 0x2e, 0x2e, 0x2e, 0x31, 0xc0 };
 
 static const u8 retinsn[] = { RET_INSN_OPCODE, 0xcc, 0xcc, 0xcc, 0xcc };
 
+static u8 __is_Jcc(u8 *insn) /* Jcc.d32 */
+{
+	u8 ret = 0;
+
+	if (insn[0] == 0x0f) {
+		u8 tmp = insn[1];
+		if ((tmp & 0xf0) == 0x80)
+			ret = tmp;
+	}
+
+	return ret;
+}
+
+extern void __static_call_return(void);
+
+asm (".global __static_call_return\n\t"
+     ".type __static_call_return, @function\n\t"
+     "__static_call_return:\n\t"
+     ANNOTATE_NOENDBR
+     ANNOTATE_RETPOLINE_SAFE
+     "ret; int3\n\t"
+     ".size __static_call_return, . - __static_call_return \n\t");
+
 static void __ref __static_call_transform(void *insn, enum insn_type type,
 					  void *func, bool modinit)
 {
 	const void *emulate = NULL;
 	int size = CALL_INSN_SIZE;
 	const void *code;
+	u8 op, buf[6];
+
+	if ((type == JMP || type == RET) && (op = __is_Jcc(insn)))
+		type = JCC;
 
 	switch (type) {
 	case CALL:
@@ -56,6 +84,20 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 		else
 			code = &retinsn;
 		break;
+
+	case JCC:
+		if (!func) {
+			func = __static_call_return;
+			if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+				func = __x86_return_thunk;
+		}
+
+		buf[0] = 0x0f;
+		__text_gen_insn(buf+1, op, insn+1, func, 5);
+		code = buf;
+		size = 6;
+
+		break;
 	}
 
 	if (memcmp(insn, code, size) == 0)
@@ -67,13 +109,14 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 	text_poke_bp(insn, code, size, emulate);
 }
 
-static void __static_call_validate(void *insn, bool tail)
+static void __static_call_validate(u8 *insn, bool tail)
 {
-	u8 opcode = *(u8 *)insn;
+	u8 opcode = insn[0];
 
 	if (tail) {
 		if (opcode == JMP32_INSN_OPCODE ||
-		    opcode == RET_INSN_OPCODE)
+		    opcode == RET_INSN_OPCODE ||
+		    __is_Jcc(insn))
 			return;
 	} else {
 		if (opcode == CALL_INSN_OPCODE ||
-- 
2.34.1


