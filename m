Return-Path: <stable+bounces-152329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D51DFAD4300
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 21:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4363B7A4764
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 19:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E0126462E;
	Tue, 10 Jun 2025 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMvzygV6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2665F23183E
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584507; cv=none; b=n0k8d8dNdzqa+5Eopk8s0y0CO8ifeecOJ3sKbOLDclgYdkArt7tNv5NMQaWS4zBbRxpWWpjb/VwMy0SwS90DB10Fw8a6fjVltxOOHWgBENrKdQc5VBXfasGWjYtI14q28z/AYxnD/u9AdDNUQzfX8gAvH6AHZbrOXz4oBRFhTLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584507; c=relaxed/simple;
	bh=AV6MvDFP/42iUREMwXy4YfWhjfF2neiSDDJYNchBJg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sup8fUAyv/JSuZ9N07l782aW0PdNZyGZ1Z66+9PYHsUteehF39r637Ci6LwgsdmSgvaAAGJVaJGJFsHhUfaO0A57dbtl32zZclBR/LsBaipGQ/gevJRtbV7oZvmM13hcwkUXEXG7TWubXnloxw1eMDxQgerB5w8NgVKbWXcbyQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMvzygV6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749584507; x=1781120507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AV6MvDFP/42iUREMwXy4YfWhjfF2neiSDDJYNchBJg8=;
  b=YMvzygV6+GZnk54Z0r888SP4oRT1pAVdq581DcjRQGdUbRFDe4uibx5v
   lMytS1fduzGwH7EG+WDLZmFofcJofr9OlKLiG1nFSCChaRtfobhA6YhVH
   Dl4yyf6IhE8Zcb7NpmEXu6EISIuArEsNFIzFXQQHCOg6LgKHxNXyIneMK
   Maw5yhuSNCdIaKwPhkc01G9JrxtI80iUGEHSFZa+EN7rAzc14eOC9rdMi
   NT7bwEYNfJTQWIPXvjJjIH3Oa/uTBErfdAUx9vyQvUDwSe+LaVyaJ90Lq
   b9SOdnzXFkkzxLcvvTmMSX89R3qjuhZs2bHqaJXtGTN1eYkifJ+ACTH7f
   w==;
X-CSE-ConnectionGUID: 8RuTCQMwQK+FkTD2gh5PSw==
X-CSE-MsgGUID: uBQQ0LTgS6a+CqUM7qQrYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51703071"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51703071"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:41:39 -0700
X-CSE-ConnectionGUID: vanxfVRtQ+2RxUfRLlvn2g==
X-CSE-MsgGUID: nKfbkgngR/ydnkLdXaqnUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="177851407"
Received: from bdahal-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:41:37 -0700
Date: Tue, 10 Jun 2025 12:41:36 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH 5.10 05/16] x86/alternatives: Teach text_poke_bp() to
 patch Jcc.d32 instructions
Message-ID: <20250610-its-5-10-v1-5-64f0ae98c98d@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/alternative.c | 56 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9ceef8515c0312b292d67ac2d2ffbb1b7d6acd1d..70a6165d4e11899b6e0de8548255fef6b913da08 100644
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
2.34.1



