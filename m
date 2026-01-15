Return-Path: <stable+bounces-209160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C63D26AF7
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 298E73281D19
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CA73BC4C9;
	Thu, 15 Jan 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fwnSBolN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A239B48E;
	Thu, 15 Jan 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497904; cv=none; b=nfSa72wTL0IGMJTdxTdmjYwkhKN1GSvdeccIaNKsVoUyxb3CzwHF3IJ65ZGP+f+F23OQ9bDZAeCeMFviMoC6s2BuxvQOwwu6Ye/xwmI7qU8b9kzkhxFwmWuFrYuvZwoRakKZmTjh/ezGyORwV1xAr8t2B5gKkVTLpqX6DlOFSkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497904; c=relaxed/simple;
	bh=bUWPjT8FXhyDs19/lCj5W7V5ovSwd3BTPHG6vEO95ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTL9OU/VapQPLmzFrs8e5CHHdOecH3OVn0UwroB3uIuO/Zsnr3bMK4BBNwrhyrGfYNuf5QZMuA6jChq2K1E4yV9MXzH5cFvR8m1W2nP4/zopHkz18A/xg4WhtdADEfgwtYGzgo/XTIgk5t0aHmnt/AseeaektRV47plzj8pbTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fwnSBolN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C45C116D0;
	Thu, 15 Jan 2026 17:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768497904;
	bh=bUWPjT8FXhyDs19/lCj5W7V5ovSwd3BTPHG6vEO95ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fwnSBolNXiyzHgG7ivArjPR77Ost4wya9+8g2xRn9BD8YGyDp/WisADIalaRYFNHq
	 ZpIVd/VnG0SxxXfJc+uED7uH6O3GB6Z5DniTW6vtS4ac8/s6BARk2XTBzoq3TwsXH4
	 uxR5Q1Mo/9vXOETYINHx0qOAig0CugzT4Mya5FL4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 211/554] x86/ptrace: Always inline trivial accessors
Date: Thu, 15 Jan 2026 17:44:37 +0100
Message-ID: <20260115164253.889216149@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164246.225995385@linuxfoundation.org>
References: <20260115164246.225995385@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 1fe4002cf7f23d70c79bda429ca2a9423ebcfdfa ]

A KASAN build bloats these single load/store helpers such that
it fails to inline them:

  vmlinux.o: error: objtool: irqentry_exit+0x5e8: call to instruction_pointer_set() with UACCESS enabled

Make sure the compiler isn't allowed to do stupid.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251031105435.GU4068168@noisy.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/ptrace.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index b94f615600d57..d5186653311da 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -109,12 +109,12 @@ convert_ip_to_linear(struct task_struct *child, struct pt_regs *regs);
 extern void send_sigtrap(struct pt_regs *regs, int error_code, int si_code);
 
 
-static inline unsigned long regs_return_value(struct pt_regs *regs)
+static __always_inline unsigned long regs_return_value(struct pt_regs *regs)
 {
 	return regs->ax;
 }
 
-static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
+static __always_inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
 {
 	regs->ax = rc;
 }
@@ -195,34 +195,34 @@ static inline bool ip_within_syscall_gap(struct pt_regs *regs)
 }
 #endif
 
-static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
+static __always_inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 {
 	return regs->sp;
 }
 
-static inline unsigned long instruction_pointer(struct pt_regs *regs)
+static __always_inline unsigned long instruction_pointer(struct pt_regs *regs)
 {
 	return regs->ip;
 }
 
-static inline void instruction_pointer_set(struct pt_regs *regs,
-		unsigned long val)
+static __always_inline
+void instruction_pointer_set(struct pt_regs *regs, unsigned long val)
 {
 	regs->ip = val;
 }
 
-static inline unsigned long frame_pointer(struct pt_regs *regs)
+static __always_inline unsigned long frame_pointer(struct pt_regs *regs)
 {
 	return regs->bp;
 }
 
-static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+static __always_inline unsigned long user_stack_pointer(struct pt_regs *regs)
 {
 	return regs->sp;
 }
 
-static inline void user_stack_pointer_set(struct pt_regs *regs,
-		unsigned long val)
+static __always_inline
+void user_stack_pointer_set(struct pt_regs *regs, unsigned long val)
 {
 	regs->sp = val;
 }
-- 
2.51.0




