Return-Path: <stable+bounces-57845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D175925E46
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B3B1F21F22
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022F617DA08;
	Wed,  3 Jul 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hbA/NjGQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46D1137910;
	Wed,  3 Jul 2024 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006105; cv=none; b=gbs/Xnrq3E0O4RhIez4+1GQBnannx+mHgXmyeGcNDz0rFLP/0tGikr1y2kntc/MjBrs3ZWZ7ihJfk6MYYeJQUYkLccEUXZVTT4uv3DuI0i6am3nhYBGLFrQg+UmPwdjDATBFdf5mfPRUhuGLl/OH89Bz6shKjjfoV5XYXMn0lQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006105; c=relaxed/simple;
	bh=Wg3i8rrJYWXd0MiX6+1Ys9EE2UTGKY1ToSd+WniG8pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rm0beFO9RTGuz1+FtkuS0L5kKm4YJHV3jgtLTT2Qu/Huoj6+JYjoS9lmvuVt93NMhcI6qIkH+I7DNAsBwO+StHVuGkSsqe9DQTyPfXA9Dw6b0SEnE/ez0sUEzCwQPdZik0qUzrvEmdo5sQKOQC8K/IxtmB2sy6URGQbRSKmlu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hbA/NjGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D02C2BD10;
	Wed,  3 Jul 2024 11:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720006105;
	bh=Wg3i8rrJYWXd0MiX6+1Ys9EE2UTGKY1ToSd+WniG8pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbA/NjGQn7lu3XdE1RSM005QaYaFZgrOkd/xSjl1TOLf27JstwGmyy2TSksFoFvkV
	 P2tBmyLQCbquNrX2xNbvPGGonvRhaGGNHl2xYSivXIk/RJVrTa5zDxBwoqGafSsvPV
	 HYw/3QTsElps7EC0e1p5Gm3GcUwsAYa6HTbPRxmw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 302/356] x86: stop playing stack games in profile_pc()
Date: Wed,  3 Jul 2024 12:40:38 +0200
Message-ID: <20240703102924.540393534@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 093d9603b60093a9aaae942db56107f6432a5dca ]

The 'profile_pc()' function is used for timer-based profiling, which
isn't really all that relevant any more to begin with, but it also ends
up making assumptions based on the stack layout that aren't necessarily
valid.

Basically, the code tries to account the time spent in spinlocks to the
caller rather than the spinlock, and while I support that as a concept,
it's not worth the code complexity or the KASAN warnings when no serious
profiling is done using timers anyway these days.

And the code really does depend on stack layout that is only true in the
simplest of cases.  We've lost the comment at some point (I think when
the 32-bit and 64-bit code was unified), but it used to say:

	Assume the lock function has either no stack frame or a copy
	of eflags from PUSHF.

which explains why it just blindly loads a word or two straight off the
stack pointer and then takes a minimal look at the values to just check
if they might be eflags or the return pc:

	Eflags always has bits 22 and up cleared unlike kernel addresses

but that basic stack layout assumption assumes that there isn't any lock
debugging etc going on that would complicate the code and cause a stack
frame.

It causes KASAN unhappiness reported for years by syzkaller [1] and
others [2].

With no real practical reason for this any more, just remove the code.

Just for historical interest, here's some background commits relating to
this code from 2006:

  0cb91a229364 ("i386: Account spinlocks to the caller during profiling for !FP kernels")
  31679f38d886 ("Simplify profile_pc on x86-64")

and a code unification from 2009:

  ef4512882dbe ("x86: time_32/64.c unify profile_pc")

but the basics of this thing actually goes back to before the git tree.

Link: https://syzkaller.appspot.com/bug?extid=84fe685c02cd112a2ac3 [1]
Link: https://lore.kernel.org/all/CAK55_s7Xyq=nh97=K=G1sxueOFrJDAvPOJAL4TPTCAYvmxO9_A@mail.gmail.com/ [2]
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/time.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index e42faa792c079..52e1f3f0b361c 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -27,25 +27,7 @@
 
 unsigned long profile_pc(struct pt_regs *regs)
 {
-	unsigned long pc = instruction_pointer(regs);
-
-	if (!user_mode(regs) && in_lock_functions(pc)) {
-#ifdef CONFIG_FRAME_POINTER
-		return *(unsigned long *)(regs->bp + sizeof(long));
-#else
-		unsigned long *sp = (unsigned long *)regs->sp;
-		/*
-		 * Return address is either directly at stack pointer
-		 * or above a saved flags. Eflags has bits 22-31 zero,
-		 * kernel addresses don't.
-		 */
-		if (sp[0] >> 22)
-			return sp[0];
-		if (sp[1] >> 22)
-			return sp[1];
-#endif
-	}
-	return pc;
+	return instruction_pointer(regs);
 }
 EXPORT_SYMBOL(profile_pc);
 
-- 
2.43.0




