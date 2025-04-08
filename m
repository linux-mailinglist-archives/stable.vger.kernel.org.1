Return-Path: <stable+bounces-130273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992C0A803DF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38714642E5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5462E269B01;
	Tue,  8 Apr 2025 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BElRho4Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D55422257E;
	Tue,  8 Apr 2025 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113279; cv=none; b=cuE41fc3/Aez/BuYj5wdB4lygeuRS2HEGIdh+Z/j7gKt0cRIgTWTtiWOxEVQWXI75MLwxmlnVx7E8RX1yx97mjOhI8I4Qzzsfh7z4Sx+r2eidhw0M88By2UFQUTsYxRigBFrKhXGqLpfFn1hXBd/NIOZyHzLLIvBXOHomTu5fSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113279; c=relaxed/simple;
	bh=fqU5DjTGhtFaBH4UpNXixkGHws2PlungeIKrnH93/Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXLEk639v+cdl901EZKQbcgTifzJEgMuAVZdINbKsSGmDkJmSzz5Q7mSnXjRmu++m45Ab6P3BYJdZKnJwcm9z2V2WmbZKsv9HZozszZV2V7dJC5KzTwEcG8PYMBHzKPx3XAnrXcm8isoQ/cDuZ5p6Du3JSZsjF3DC2H/XZe8m1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BElRho4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933E1C4CEE5;
	Tue,  8 Apr 2025 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113278;
	bh=fqU5DjTGhtFaBH4UpNXixkGHws2PlungeIKrnH93/Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BElRho4Y2lx+hCz/dLDqf3jOFmuWiiEJm/WbJGFZPy0SQwyMeJpMrlPfFVeJNnQp1
	 6LEVaghaBpbGGaQ6mZMrzWlRSgbr74PI0PMSadwNNuVHwHl2d7eDquqpkh/O+59Gz1
	 K1YXIjhFMRilqbqmGROeVsPDPfUY0GfqU9DW9x24=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 099/268] x86/dumpstack: Fix inaccurate unwinding from exception stacks due to misplaced assignment
Date: Tue,  8 Apr 2025 12:48:30 +0200
Message-ID: <20250408104831.166530250@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
References: <20250408104828.499967190@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

[ Upstream commit 2c118f50d7fd4d9aefc4533a26f83338b2906b7a ]

Commit:

  2e4be0d011f2 ("x86/show_trace_log_lvl: Ensure stack pointer is aligned, again")

was intended to ensure alignment of the stack pointer; but it also moved
the initialization of the "stack" variable down into the loop header.

This was likely intended as a no-op cleanup, since the commit
message does not mention it; however, this caused a behavioral change
because the value of "regs" is different between the two places.

Originally, get_stack_pointer() used the regs provided by the caller; after
that commit, get_stack_pointer() instead uses the regs at the top of the
stack frame the unwinder is looking at. Often, there are no such regs at
all, and "regs" is NULL, causing get_stack_pointer() to fall back to the
task's current stack pointer, which is not what we want here, but probably
happens to mostly work. Other times, the original regs will point to
another regs frame - in that case, the linear guess unwind logic in
show_trace_log_lvl() will start unwinding too far up the stack, causing the
first frame found by the proper unwinder to never be visited, resulting in
a stack trace consisting purely of guess lines.

Fix it by moving the "stack = " assignment back where it belongs.

Fixes: 2e4be0d011f2 ("x86/show_trace_log_lvl: Ensure stack pointer is aligned, again")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250325-2025-03-unwind-fixes-v1-2-acd774364768@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/dumpstack.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index f18ca44c904b7..52dc5839d1e8e 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -195,6 +195,7 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	printk("%sCall Trace:\n", log_lvl);
 
 	unwind_start(&state, task, regs, stack);
+	stack = stack ?: get_stack_pointer(task, regs);
 	regs = unwind_get_entry_regs(&state, &partial);
 
 	/*
@@ -213,9 +214,7 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	 * - hardirq stack
 	 * - entry stack
 	 */
-	for (stack = stack ?: get_stack_pointer(task, regs);
-	     stack;
-	     stack = stack_info.next_sp) {
+	for (; stack; stack = stack_info.next_sp) {
 		const char *stack_name;
 
 		stack = PTR_ALIGN(stack, sizeof(long));
-- 
2.39.5




