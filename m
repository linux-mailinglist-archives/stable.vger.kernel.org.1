Return-Path: <stable+bounces-27580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA76187A613
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 11:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77476282BB5
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 10:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D803D38D;
	Wed, 13 Mar 2024 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jQhUZsav"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E56383BD
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326620; cv=none; b=EZAOn3TeVDmKnrepSH4AOEsoODfn7AeGKL2PjV/nyTeXMEuq6x+SKGXwhsAjZHx9302LPWFUB/6wV/VbpKCx4Zve6TgGqHOSIYKG/GlJrm8jPx8/ExU5LdS9JyzyX53CMx/qEptqzRDnX4m3GVnyc4VmUAaxwvY632UCWSW2u8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326620; c=relaxed/simple;
	bh=tPnv+3SLDYtOYlMKV8POPb0guSvkSx6mwwGENXHwkNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/4b15uibjDILKVfVnU8glwMA446juXKgnHhywuw+Zq9Wby5Xqgu3pPVxCbsRe7kWegurTrZf0QGoSfHkptM9B19/bYbsU3A/OCI/tj3OMNitBXqjMY85wXEYHZgHMBGb9VdbRiJbolbHOJ4iGAwruc2w4Jok31bgIhnSVttgeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jQhUZsav; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mtrZwN2cQB/ALiVfM4+ZqDgqbMS260ImPFsQZC2MvpU=; b=jQhUZsav1MGeSmvJOWmLVhLE7s
	XabZvC+5kpBaQ1/8J8AAYvIxT0wPDleIpM6VXcwt6mTd6VFfb+NIC8eqFU3efwLqUbj7JOsyaHd2y
	uxTTK2N/M6By778oTasK9IMovle/y5NFX6WWrouN2xuntQQ4Fm4g3ZfGNS8jg09j+TEFvhfntyOlQ
	HfS7zNb95Y1kwaXo3ErPFD1FsLtvNZkaGQQNScX4DlOMs8FeJZsyjZoIP9RSArFYK7StBSlFSoIOP
	aqAoeRg8YfeI0DL7aB1D+szSpcZPX7QoRdFPU6z0JYJunPldaZk/MmY3B+ZmAQ526G23+JjuhJVpg
	jQhHeLJA==;
Received: from 179-125-71-247-dinamico.pombonet.net.br ([179.125.71.247] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rkM59-009uZG-U0; Wed, 13 Mar 2024 11:43:36 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	kernel-dev@igalia.com
Subject: [PATCH 5.15 5/5] x86/static_call: Add support for Jcc tail-calls
Date: Wed, 13 Mar 2024 07:42:55 -0300
Message-Id: <20240313104255.1083365-6-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313104255.1083365-1-cascardo@igalia.com>
References: <20240313104255.1083365-1-cascardo@igalia.com>
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
Change-Id: I99c8fc3f721e5d1c74f06710b38d4bac5230303a
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/Y9Kdg9QjHkr9G5b5@hirez.programming.kicks-ass.net
[cascardo: __static_call_validate didn't have the bool tramp argument]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 arch/x86/kernel/static_call.c | 50 ++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index e25050c7ff1e..0e0221271e72 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -9,6 +9,7 @@ enum insn_type {
 	NOP = 1,  /* site cond-call */
 	JMP = 2,  /* tramp / site tail-call */
 	RET = 3,  /* tramp / site cond-tail-call */
+	JCC = 4,
 };
 
 /*
@@ -25,12 +26,40 @@ static const u8 xor5rax[] = { 0x2e, 0x2e, 0x2e, 0x31, 0xc0 };
 
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
+     ASM_FUNC_ALIGN "\n\t"
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
@@ -56,6 +85,20 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 		else
 			code = &retinsn;
 		break;
+
+	case JCC:
+		if (!func) {
+			func = __static_call_return;
+			if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+				func = x86_return_thunk;
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
@@ -67,13 +110,14 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
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


