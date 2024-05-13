Return-Path: <stable+bounces-43667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15398C429D
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711D41F2225D
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D19153576;
	Mon, 13 May 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xf6uKN4M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29699152DFA
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608630; cv=none; b=hzo4feGjNcx1EaObqdqYjLrHZ1q0XOoib6Nb9wjeED2BcQbAWGTRaZyj3cBC9gQHSW3TW94ni1blkEja0yu2C3B/EnmgBgmeo0F/4v7hltRnE+XBUaL8LMGsR32UC50NDOM3hsEUcJk9y/MJsCwdhnvpLxn6fkVUk+y+dxla+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608630; c=relaxed/simple;
	bh=J1LiHB8fhwIStW6w5fpItgFqzPD7sSOE+8+x+TSkTTY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bt0ik52k3REq0gtbKrqehvY1q3iPLaAfrrxdvRdoz3oz605KWHAMbIUOMhDS8T1HPGySY+hvbogfLDyFbmi+YyDZvf4pmBFFRfVUPyEaMGb8uac9Kyj5K6ybXFnd5UGjoZoZs+hQ+1h+QMVD94x7xdyN2p5pyfoOEUU4dL4sSwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xf6uKN4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29592C113CC;
	Mon, 13 May 2024 13:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715608629;
	bh=J1LiHB8fhwIStW6w5fpItgFqzPD7sSOE+8+x+TSkTTY=;
	h=Subject:To:Cc:From:Date:From;
	b=xf6uKN4MdeWXKWsqv5EXBh8oirInyVLU2tZn5h7qmyhgwHMBjpsL+FDAMTFv6K1AZ
	 NZKXjnNX+OeuJyo8sL+rbXI7S82k2OCG5XaETaw24BGOxHL/xGBwl03aefEfktkKQy
	 lwoSrHUHJzGNYhpDvLCfAbqWZQhOIA6NQwSyu7hU=
Subject: FAILED: patch "[PATCH] xtensa: fix MAKE_PC_FROM_RA second argument" failed to apply to 6.1-stable tree
To: jcmvbkbc@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:57:06 +0200
Message-ID: <2024051305-harsh-aids-02ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0e60f0b75884677fb9f4f2ad40d52b43451564d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051305-harsh-aids-02ab@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

0e60f0b75884 ("xtensa: fix MAKE_PC_FROM_RA second argument")
1b6ceeb99ee0 ("xtensa: stacktrace: include <asm/ftrace.h> for prototype")

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


