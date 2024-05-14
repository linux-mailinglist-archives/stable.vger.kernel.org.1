Return-Path: <stable+bounces-44068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6D88C5114
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E9F282509
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60DE12F5A8;
	Tue, 14 May 2024 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xB3HHlgg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834DC12880A;
	Tue, 14 May 2024 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684037; cv=none; b=Z8dvwIF15dhdDN9XnpB+DYkqkEVaoa0v1UY5fvDAA1Y8zVpPVkbcLpInV5qc7Izj2xqughb4dqErnvaICQFPvtQwx0VKtQt23gdiZ2X7mhuiTDsir9qnDOpWzfdHu24Dk3m6eKTiFNdRNPBi6awxXz2ue619iUGEoynIDQ72MBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684037; c=relaxed/simple;
	bh=j7cTDN9lQsMNumzVc6tamDvBtakzEmzUwt3zsEv/+Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKOLolfodKQS28K2+FpAzz791IW/E5iesOHlk9eh9ft5JqYUsOmPMo5IG11ZAAlNSON3hlP4FKH8khSHsG8iNhrTHUKA+N8IEnbBADI/VUplAdmyN2BxubAlQ2BzRhO9R5qnDOdZwjhNqoDC4k9YijEIKYosLAoSR0rrM5M+ZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xB3HHlgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9137C32781;
	Tue, 14 May 2024 10:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684037;
	bh=j7cTDN9lQsMNumzVc6tamDvBtakzEmzUwt3zsEv/+Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xB3HHlggD3KeiF1Wlr84qGlnWyujSeBTEc42SoODFDRkivs64NWl7Gk8HBboc3bGA
	 /j2YcHqtGlw3MuNcawhWmWKnX5CR6xOT3ZQWv0aiGwMnLHlqeif6kSzddtq/+iy+YS
	 Wysk9tuHQGytxoDeVzpPCZC3Q6T4aYyB4brnGPUk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 6.8 281/336] xtensa: fix MAKE_PC_FROM_RA second argument
Date: Tue, 14 May 2024 12:18:05 +0200
Message-ID: <20240514101049.229159501@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit 0e60f0b75884677fb9f4f2ad40d52b43451564d5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/xtensa/include/asm/processor.h |    8 ++++----
 arch/xtensa/include/asm/ptrace.h    |    2 +-
 arch/xtensa/kernel/process.c        |    5 +++--
 arch/xtensa/kernel/stacktrace.c     |    3 ++-
 4 files changed, 10 insertions(+), 8 deletions(-)

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
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -47,6 +47,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/regs.h>
 #include <asm/hw_breakpoint.h>
+#include <asm/sections.h>
 #include <asm/traps.h>
 
 extern void ret_from_fork(void);
@@ -380,7 +381,7 @@ unsigned long __get_wchan(struct task_st
 	int count = 0;
 
 	sp = p->thread.sp;
-	pc = MAKE_PC_FROM_RA(p->thread.ra, p->thread.sp);
+	pc = MAKE_PC_FROM_RA(p->thread.ra, _text);
 
 	do {
 		if (sp < stack_page + sizeof(struct task_struct) ||
@@ -392,7 +393,7 @@ unsigned long __get_wchan(struct task_st
 
 		/* Stack layout: sp-4: ra, sp-3: sp' */
 
-		pc = MAKE_PC_FROM_RA(SPILL_SLOT(sp, 0), sp);
+		pc = MAKE_PC_FROM_RA(SPILL_SLOT(sp, 0), _text);
 		sp = SPILL_SLOT(sp, 1);
 	} while (count++ < 16);
 	return 0;
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



