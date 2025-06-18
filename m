Return-Path: <stable+bounces-154606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C49FADE02B
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CABD189AF69
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E6822EE5;
	Wed, 18 Jun 2025 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIaNrabq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176F208A7
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 00:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750207525; cv=none; b=kbArK1zVQepV7Pon8lUrfP6AJxyP3W03wamW0ubkQJ/6lZJjPZzVo6CXW8TdRXkJsIbbXJ3l1YPo/B295sNSihybhYEuLxeh40vp4K8MI+odbqWS7WIc8cx73tEkBpMGvhUjtwr8KztZQeQ6oQfLV9LNKriVb07QsAvCgVl3MDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750207525; c=relaxed/simple;
	bh=QsLQEcmWRHcE5PsXdl4IHxJQKXIcTXPigK5Cr5ZajFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVap1mYEiLGQMCzXE+F4ddEh/vTfEY9DHdNAl51Vy9AWP56FcPzM1wvqhI8ys+83C68udpL1iUYWlEecO/aKIJORx8Og2PSsdBms1uQ/xHWkkB4VzYOOOsNv2eM7q7DrRkF067m/IMXJN1vCT7NBb5rDUJbMhYhvY5PqugvsjAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIaNrabq; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750207524; x=1781743524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QsLQEcmWRHcE5PsXdl4IHxJQKXIcTXPigK5Cr5ZajFQ=;
  b=eIaNrabqvhlBw2f6dwE8fFJ+Oa8Zex27xcbTjzRsqTlAW3THtINHUJrV
   fhNvKO9P+Qd4xSI8xwb+GERHEG/6ZVUTr1qFOJkDTF569H3pUNDm3tLV5
   lIChYqlefoOrII9EV+2GaVUqoFKM4mNccwg392no84DhYgg9OV1K14LBl
   w4HUFhfDvjiWr0WuODOK/3AVwORWJcGPNxrtmnbdQstwkNW+2Q9PG2094
   0cPzFAA8R9/voElYhgqbFc64hJ5S/zSzT3Ej7e0cifj9XH6KTqLCUDoIk
   O0tlT856DUQbTtsY8Wv7u+xHI/0p+wmdmRdVyBPCWv5siglW8fc80biy/
   A==;
X-CSE-ConnectionGUID: vB6/lqgkSL+2DcQCksGPXQ==
X-CSE-MsgGUID: 0o2zn3IJQw+ghvbRFvLhpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="51515144"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="51515144"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:45:23 -0700
X-CSE-ConnectionGUID: uibuEp6/S725/g7Yk6GJCg==
X-CSE-MsgGUID: PL8KhLR8QuW2E2vjkhAWnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="148898470"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:45:23 -0700
Date: Tue, 17 Jun 2025 17:45:22 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.10 v2 05/16] x86/alternatives: Teach text_poke_bp() to
 patch Jcc.d32 instructions
Message-ID: <20250617-its-5-10-v2-5-3e925a1512a1@linux.intel.com>
X-Mailer: b4 0.15-dev-c81fc
References: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>

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
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/alternative.c | 56 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9ceef8515c03..70a6165d4e11 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -506,6 +506,12 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
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
@@ -1331,6 +1337,11 @@ void text_poke_sync(void)
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
@@ -1452,6 +1463,10 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
 		int3_emulate_jmp(regs, (long)ip + tp->disp);
 		break;
 
+	case 0x70 ... 0x7f: /* Jcc */
+		int3_emulate_jcc(regs, tp->opcode & 0xf, (long)ip, tp->disp);
+		break;
+
 	default:
 		BUG();
 	}
@@ -1525,16 +1540,26 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
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
 
@@ -1562,8 +1587,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		 * The old instruction is recorded so that the event can be
 		 * processed forwards or backwards.
 		 */
-		perf_event_text_poke(text_poke_addr(&tp[i]), old, len,
-				     tp[i].text, len);
+		perf_event_text_poke(text_poke_addr(&tp[i]), old, len, new, len);
 	}
 
 	if (do_sync) {
@@ -1580,10 +1604,15 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
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
 
@@ -1601,9 +1630,11 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
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
 
@@ -1614,6 +1645,13 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
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
@@ -1630,7 +1668,6 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 		BUG_ON(len != insn.length);
 	};
 
-
 	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
 	case RET_INSN_OPCODE:
@@ -1639,6 +1676,7 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 	case CALL_INSN_OPCODE:
 	case JMP32_INSN_OPCODE:
 	case JMP8_INSN_OPCODE:
+	case 0x70 ... 0x7f: /* Jcc */
 		tp->disp = insn.immediate.value;
 		break;
 

-- 
2.43.0



