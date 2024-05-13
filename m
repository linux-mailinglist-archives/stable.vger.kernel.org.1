Return-Path: <stable+bounces-43669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CA58C429F
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA39286D0D
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56E153572;
	Mon, 13 May 2024 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MFhSuGIC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B270152DFA
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608637; cv=none; b=pHS+WbdPaCEfRrTw7ewD7pfrpjrzyie3hPdCVxlG45D195/CTaPLPnUHxkuia+STI1Qw7UT9Bf3B/Ht19x7lbO1MiPkexQ3V279xuGNQRA5VF9Wbu+YF4+R0dOQnIpbnPJ0FByWxgbJeILSu0VtTWMmHc+nriQqJUZMBxz/09L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608637; c=relaxed/simple;
	bh=upISJp6YrkqwBpxk3rqSNhK5Hz26hfgJcqRedT39s0k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aFpQayvoe6w+XYhbpU8bm5xstZdR840qXM5f/Iwnd+j37TrUHXAPZ5WtvLkUcEFCbbiLrbiuKplLT8LvyqBcUCzwQmQ4glaLql2yWyCABb4y0Gu8mCWmEu+vufBjzc3ZVgt4gsIZRcaiwkGpEkuCSAr7sqBXmrfDFFebMmSMlGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MFhSuGIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B9AC4AF09;
	Mon, 13 May 2024 13:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715608637;
	bh=upISJp6YrkqwBpxk3rqSNhK5Hz26hfgJcqRedT39s0k=;
	h=Subject:To:Cc:From:Date:From;
	b=MFhSuGIChmiBEsYZlvi6w+Fy3oZMbjXLcEvwuXsp0eMASIJ83ZMUqy2DdSiZkVOuQ
	 qHK/lZnae4aApTIKMwdcSeRiDsjTCfATWcREOyycuDKWCWRSVc2BqgiISiSyhU07vG
	 5iU83gxAZ42Dm/G2gEOAkFZUhVhJEPgEJw7800LU=
Subject: FAILED: patch "[PATCH] xtensa: fix MAKE_PC_FROM_RA second argument" failed to apply to 5.10-stable tree
To: jcmvbkbc@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:57:13 +0200
Message-ID: <2024051312-survival-stoic-e4d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0e60f0b75884677fb9f4f2ad40d52b43451564d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051312-survival-stoic-e4d5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

0e60f0b75884 ("xtensa: fix MAKE_PC_FROM_RA second argument")
1b6ceeb99ee0 ("xtensa: stacktrace: include <asm/ftrace.h> for prototype")
11e969bc964a ("xtensa: support coprocessors on SMP")
e45d4bfbeb26 ("xtensa: merge SAVE_CP_REGS_TAB and LOAD_CP_REGS_TAB")
0b549f813387 ("xtensa: handle coprocessor exceptions in kernel mode")
6179ef4d460a ("xtensa: use callx0 opcode in fast_coprocessor")
3e554d47dfe3 ("xtensa: clean up declarations in coprocessor.h")
fc55402b8438 ("xtensa: clean up exception handler prototypes")
db0d07fa192a ("xtensa: clean up function declarations in traps.c")
839769c35477 ("xtensa: fix a7 clobbering in coprocessor context load/store")
967747bbc084 ("uaccess: remove CONFIG_SET_FS")
12700c17fc28 ("uaccess: generalize access_ok()")
52fe8d125c9a ("arm64: simplify access_ok()")
26509034bef1 ("m68k: fix access_ok for coldfire")
15f3d81a8c8a ("MIPS: use simpler access_ok()")
34737e269803 ("uaccess: add generic __{get,put}_kernel_nofault")
1830a1d6a5b7 ("x86: use more conventional access_ok() definition")
36903abedfe8 ("x86: remove __range_not_ok()")
8afafbc955ba ("sparc64: add __{get,put}_kernel_nofault()")
222ca305c9fd ("uaccess: fix integer overflow on access_ok()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0e60f0b75884677fb9f4f2ad40d52b43451564d5 Mon Sep 17 00:00:00 2001
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 17 Feb 2024 05:15:42 -0800
Subject: [PATCH] xtensa: fix MAKE_PC_FROM_RA second argument

Xtensa has two-argument MAKE_PC_FROM_RA macro to convert a0 to an actual
return address because when windowed ABI is used call{,x}{4,8,12}
opcodes stuff encoded window size into the top 2 bits of the register
that becomes a return address in the called function. Second argument of
that macro is supposed to be an address having these 2 topmost bits set
correctly, but the comment suggested that that could be the stack
address. However the stack doesn't have to be in the same 1GByte region
as the code, especially in noMMU XIP configurations.

Fix the comment and use either _text or regs->pc as the second argument
for the MAKE_PC_FROM_RA macro.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index d008a153a2b9..7ed1a2085bd7 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -115,9 +115,9 @@
 #define MAKE_RA_FOR_CALL(ra,ws)   (((ra) & 0x3fffffff) | (ws) << 30)
 
 /* Convert return address to a valid pc
- * Note: We assume that the stack pointer is in the same 1GB ranges as the ra
+ * Note: 'text' is the address within the same 1GB range as the ra
  */
-#define MAKE_PC_FROM_RA(ra,sp)    (((ra) & 0x3fffffff) | ((sp) & 0xc0000000))
+#define MAKE_PC_FROM_RA(ra, text) (((ra) & 0x3fffffff) | ((unsigned long)(text) & 0xc0000000))
 
 #elif defined(__XTENSA_CALL0_ABI__)
 
@@ -127,9 +127,9 @@
 #define MAKE_RA_FOR_CALL(ra, ws)   (ra)
 
 /* Convert return address to a valid pc
- * Note: We assume that the stack pointer is in the same 1GB ranges as the ra
+ * Note: 'text' is not used as 'ra' is always the full address
  */
-#define MAKE_PC_FROM_RA(ra, sp)    (ra)
+#define MAKE_PC_FROM_RA(ra, text)  (ra)
 
 #else
 #error Unsupported Xtensa ABI
diff --git a/arch/xtensa/include/asm/ptrace.h b/arch/xtensa/include/asm/ptrace.h
index a270467556dc..86c70117371b 100644
--- a/arch/xtensa/include/asm/ptrace.h
+++ b/arch/xtensa/include/asm/ptrace.h
@@ -87,7 +87,7 @@ struct pt_regs {
 # define user_mode(regs) (((regs)->ps & 0x00000020)!=0)
 # define instruction_pointer(regs) ((regs)->pc)
 # define return_pointer(regs) (MAKE_PC_FROM_RA((regs)->areg[0], \
-					       (regs)->areg[1]))
+					       (regs)->pc))
 
 # ifndef CONFIG_SMP
 #  define profile_pc(regs) instruction_pointer(regs)
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index a815577d25fd..7bd66677f7b6 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -47,6 +47,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/regs.h>
 #include <asm/hw_breakpoint.h>
+#include <asm/sections.h>
 #include <asm/traps.h>
 
 extern void ret_from_fork(void);
@@ -380,7 +381,7 @@ unsigned long __get_wchan(struct task_struct *p)
 	int count = 0;
 
 	sp = p->thread.sp;
-	pc = MAKE_PC_FROM_RA(p->thread.ra, p->thread.sp);
+	pc = MAKE_PC_FROM_RA(p->thread.ra, _text);
 
 	do {
 		if (sp < stack_page + sizeof(struct task_struct) ||
@@ -392,7 +393,7 @@ unsigned long __get_wchan(struct task_struct *p)
 
 		/* Stack layout: sp-4: ra, sp-3: sp' */
 
-		pc = MAKE_PC_FROM_RA(SPILL_SLOT(sp, 0), sp);
+		pc = MAKE_PC_FROM_RA(SPILL_SLOT(sp, 0), _text);
 		sp = SPILL_SLOT(sp, 1);
 	} while (count++ < 16);
 	return 0;
diff --git a/arch/xtensa/kernel/stacktrace.c b/arch/xtensa/kernel/stacktrace.c
index 831ffb648bda..ed324fdf2a2f 100644
--- a/arch/xtensa/kernel/stacktrace.c
+++ b/arch/xtensa/kernel/stacktrace.c
@@ -13,6 +13,7 @@
 #include <linux/stacktrace.h>
 
 #include <asm/ftrace.h>
+#include <asm/sections.h>
 #include <asm/stacktrace.h>
 #include <asm/traps.h>
 #include <linux/uaccess.h>
@@ -189,7 +190,7 @@ void walk_stackframe(unsigned long *sp,
 		if (a1 <= (unsigned long)sp)
 			break;
 
-		frame.pc = MAKE_PC_FROM_RA(a0, a1);
+		frame.pc = MAKE_PC_FROM_RA(a0, _text);
 		frame.sp = a1;
 
 		if (fn(&frame, data))


