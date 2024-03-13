Return-Path: <stable+bounces-27579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF1A87A612
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 11:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289A31F21CC9
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 10:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194A63D0D0;
	Wed, 13 Mar 2024 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Jda472M4"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6B6383BD
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326616; cv=none; b=Guw0HQ0PmWgQwuSSi1CDxHVMCQl81nCdU7qDVPqPE+1cIqvKsSyNiOhN274JigZOa6P/JKtsCsPGg402NUwwBeY8SUodHhrp9D7GZUWC1tMApTqbA58jW4n1SMZ+C7lmKabQLEnAEO/KlFEQkqEj+daWRhQ3c1x6HpzRgF8nN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326616; c=relaxed/simple;
	bh=43/SytMZMl5Bhcj0yDzxZpOc4ovwF38Vcs0kbW+y7VA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YeRkLxpYgfBQs24zxiI5t2QmxAPtYvFikIUoVWqjfej8+L9Ob3WatQ/S9um23Fr/UGXBqKGGOW+qND+R751dBc2WopM3g0BzQ2LX4NOQiCKERPNYj1zCPyqSY72V0nCHLrd8UtbihQsod0XViTOtBGSN1a1sBL/S90vJ6TVbcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Jda472M4; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zPBcl6NKdeIWQu4YwszwNKpkH/bBCEh1srCiHpyND9s=; b=Jda472M4/PUGVaOET2O1N0Gk17
	29uSTkSReBKHavVo5dmBUB3yc+g8kKAWBWqpKcNik2uD0lopKZVRarQBCA70dy2+hpwd71bjyLqWI
	ApS/51qboi+3AF0DfpcYYNXyXY36o0VKkhJsYSDfyirAH+UWzQAipHTwC78w+L+fSm9GuMcF18rG/
	tgvEoEA52UmgAs09Ion+8YVPWBR8qmdV7QBMSGpLGLBc/jvcOjZM67W7eTe0cLJtt55w6uC7mIjWg
	diWymuWTW8tJqTcEjV41e+y1PLqUs/9VsJuG2WRxr4KAHEFnNv9txrkDDyVJGk6A4MC03QGhRDcIe
	Uf3vgtbw==;
Received: from 179-125-71-247-dinamico.pombonet.net.br ([179.125.71.247] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rkM56-009uZG-Ej; Wed, 13 Mar 2024 11:43:32 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	kernel-dev@igalia.com
Subject: [PATCH 5.15 4/5] x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
Date: Wed, 13 Mar 2024 07:42:54 -0300
Message-Id: <20240313104255.1083365-5-cascardo@igalia.com>
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

commit ac0ee0a9560c97fa5fe1409e450c2425d4ebd17a upstream.

In order to re-write Jcc.d32 instructions text_poke_bp() needs to be
taught about them.

The biggest hurdle is that the whole machinery is currently made for 5
byte instructions and extending this would grow struct text_poke_loc
which is currently a nice 16 bytes and used in an array.

However, since text_poke_loc contains a full copy of the (s32)
displacement, it is possible to map the Jcc.d32 2 byte opcodes to
Jcc.d8 1 byte opcode for the int3 emulation.

This then leaves the replacement bytes; fudge that by only storing the
last 5 bytes and adding the rule that 'length == 6' instruction will
be prefixed with a 0x0f byte.

Change-Id: Ie3f72c6b92f865d287c8940e5a87e59d41cfaa27
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20230123210607.115718513@infradead.org
[cascardo: there is no emit_call_track_retpoline]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 arch/x86/kernel/alternative.c | 56 +++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e5536edbae57..5614e6d219b7 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -351,6 +351,12 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	kasan_enable_current();
 }
 
+static inline bool is_jcc32(struct insn *insn)
+{
+	/* Jcc.d32 second opcode byte is in the range: 0x80-0x8f */
+	return insn->opcode.bytes[0] == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80;
+}
+
 #if defined(CONFIG_RETPOLINE) && defined(CONFIG_STACK_VALIDATION)
 
 /*
@@ -1201,6 +1207,11 @@ void text_poke_sync(void)
 	on_each_cpu(do_sync_core, NULL, 1);
 }
 
+/*
+ * NOTE: crazy scheme to allow patching Jcc.d32 but not increase the size of
+ * this thing. When len == 6 everything is prefixed with 0x0f and we map
+ * opcode to Jcc.d8, using len to distinguish.
+ */
 struct text_poke_loc {
 	/* addr := _stext + rel_addr */
 	s32 rel_addr;
@@ -1322,6 +1333,10 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
 		int3_emulate_jmp(regs, (long)ip + tp->disp);
 		break;
 
+	case 0x70 ... 0x7f: /* Jcc */
+		int3_emulate_jcc(regs, tp->opcode & 0xf, (long)ip, tp->disp);
+		break;
+
 	default:
 		BUG();
 	}
@@ -1395,16 +1410,26 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * Second step: update all but the first byte of the patched range.
 	 */
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
-		u8 old[POKE_MAX_OPCODE_SIZE] = { tp[i].old, };
+		u8 old[POKE_MAX_OPCODE_SIZE+1] = { tp[i].old, };
+		u8 _new[POKE_MAX_OPCODE_SIZE+1];
+		const u8 *new = tp[i].text;
 		int len = tp[i].len;
 
 		if (len - INT3_INSN_SIZE > 0) {
 			memcpy(old + INT3_INSN_SIZE,
 			       text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
 			       len - INT3_INSN_SIZE);
+
+			if (len == 6) {
+				_new[0] = 0x0f;
+				memcpy(_new + 1, new, 5);
+				new = _new;
+			}
+
 			text_poke(text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
-				  (const char *)tp[i].text + INT3_INSN_SIZE,
+				  new + INT3_INSN_SIZE,
 				  len - INT3_INSN_SIZE);
+
 			do_sync++;
 		}
 
@@ -1432,8 +1457,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		 * The old instruction is recorded so that the event can be
 		 * processed forwards or backwards.
 		 */
-		perf_event_text_poke(text_poke_addr(&tp[i]), old, len,
-				     tp[i].text, len);
+		perf_event_text_poke(text_poke_addr(&tp[i]), old, len, new, len);
 	}
 
 	if (do_sync) {
@@ -1450,10 +1474,15 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * replacing opcode.
 	 */
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
-		if (tp[i].text[0] == INT3_INSN_OPCODE)
+		u8 byte = tp[i].text[0];
+
+		if (tp[i].len == 6)
+			byte = 0x0f;
+
+		if (byte == INT3_INSN_OPCODE)
 			continue;
 
-		text_poke(text_poke_addr(&tp[i]), tp[i].text, INT3_INSN_SIZE);
+		text_poke(text_poke_addr(&tp[i]), &byte, INT3_INSN_SIZE);
 		do_sync++;
 	}
 
@@ -1471,9 +1500,11 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 			       const void *opcode, size_t len, const void *emulate)
 {
 	struct insn insn;
-	int ret, i;
+	int ret, i = 0;
 
-	memcpy((void *)tp->text, opcode, len);
+	if (len == 6)
+		i = 1;
+	memcpy((void *)tp->text, opcode+i, len-i);
 	if (!emulate)
 		emulate = opcode;
 
@@ -1484,6 +1515,13 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 	tp->len = len;
 	tp->opcode = insn.opcode.bytes[0];
 
+	if (is_jcc32(&insn)) {
+		/*
+		 * Map Jcc.d32 onto Jcc.d8 and use len to distinguish.
+		 */
+		tp->opcode = insn.opcode.bytes[1] - 0x10;
+	}
+
 	switch (tp->opcode) {
 	case RET_INSN_OPCODE:
 	case JMP32_INSN_OPCODE:
@@ -1500,7 +1538,6 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 		BUG_ON(len != insn.length);
 	};
 
-
 	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
 	case RET_INSN_OPCODE:
@@ -1509,6 +1546,7 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 	case CALL_INSN_OPCODE:
 	case JMP32_INSN_OPCODE:
 	case JMP8_INSN_OPCODE:
+	case 0x70 ... 0x7f: /* Jcc */
 		tp->disp = insn.immediate.value;
 		break;
 
-- 
2.34.1


