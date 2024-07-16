Return-Path: <stable+bounces-59480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF10593292B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782BF284244
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57901ACA17;
	Tue, 16 Jul 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5Myq3U4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EF11AC442;
	Tue, 16 Jul 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140186; cv=none; b=qGvLSLsX1NeX4VNSdNqZfQoQtgpsc6nfPixWpKSphfQ2LdIUG3PZjjbVTeLgmESgg/D08+BaI3chazpW6eOUYtmct7FMDtC83VTRFybtdrZC1qrtOfgghL14OJU22fexOCCyGbnAXIQ6nduCFCco+/e1mWQb6D7G3H/ntGuYy+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140186; c=relaxed/simple;
	bh=AHmlCBBSdOkueuk0QAeMoCqdlEeSEeLdOZ9k9NYlWYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REYSWHEf0Y7CgkX3oSC43ckgTcUtzwv1C6aEA7JS9oGkZlNfjKwQ2+8Ab+JX3R59pUHDaV6dj/lu/S7hX7p8sS2utJp5JImZe8EwW8Zs6iT2Z00hSYnA7k27rHMjsFOxkFXzSawSA3wp+qiJ4vkvN3ju5Qi7osTOAh1EpRlmJR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5Myq3U4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A454AC116B1;
	Tue, 16 Jul 2024 14:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140186;
	bh=AHmlCBBSdOkueuk0QAeMoCqdlEeSEeLdOZ9k9NYlWYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5Myq3U4kCrM0wh7fuV6gFUw3pQPM7naPUdNTZWZPNl2lPmOuJReAp/3byG56ORT+
	 8DhOU/wKJEAFuUodQ/UCDxtwG2Gk8Rjo0C6OAhApg4rb82r1Gm7To2z7k2rvIdEqne
	 pEDMptjxPWDxroA+0MIyozifaXAwaqs5EmJ3Qv00Lzfsu8c91N2kL+7LPlP6RB0q1V
	 AE0a6ekmLYeDkkERg6xPyjrAJSBhwOBnWYVczYJOZ6wCJfJZhXXEnfZINMENjdSZzT
	 X+vZH4X7Cud4hJwsdG53n2xzsZwB4qP9tZ/dI7Lo/n7rHuR2kiR+FX15CnTVJCR2z7
	 Kw84PAe7AF9Ug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	dev.mbstr@gmail.com,
	samuel.holland@sifive.com,
	andy.chiu@sifive.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 9/9] riscv: stacktrace: fix usage of ftrace_graph_ret_addr()
Date: Tue, 16 Jul 2024 10:29:11 -0400
Message-ID: <20240716142920.2713829-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142920.2713829-1-sashal@kernel.org>
References: <20240716142920.2713829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.162
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

[ Upstream commit 393da6cbb2ff89aadc47683a85269f913aa1c139 ]

ftrace_graph_ret_addr() takes an `idx` integer pointer that is used to
optimize the stack unwinding. Pass it a valid pointer to utilize the
optimizations that might be available in the future.

The commit is making riscv's usage of ftrace_graph_ret_addr() match
x86_64.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20240618145820.62112-1-puranjay@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/stacktrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 94721c484d638..95b4ad1b6708c 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -34,6 +34,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			     bool (*fn)(void *, unsigned long), void *arg)
 {
 	unsigned long fp, sp, pc;
+	int graph_idx = 0;
 	int level = 0;
 
 	if (regs) {
@@ -70,7 +71,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			pc = regs->ra;
 		} else {
 			fp = frame->fp;
-			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
+			pc = ftrace_graph_ret_addr(current, &graph_idx, frame->ra,
 						   &frame->ra);
 			if (pc == (unsigned long)ret_from_exception) {
 				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
-- 
2.43.0


