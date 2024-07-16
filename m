Return-Path: <stable+bounces-59471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6264B932913
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB861C221B4
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F01E1AB906;
	Tue, 16 Jul 2024 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjrWK31T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCE1AB8F5;
	Tue, 16 Jul 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140150; cv=none; b=HUx2ddsBu5UJE8oMNZ6kKBK7kl/InRRtgQZtz9ZRljzn7IVZ5/jEnSAXK1ppVEJDJD8LpGythSbdDAeGJWw96D4BPjBj9ktddbTlw8VNVjR/MZDcmvK1VaiToj0mjKiDJwp5BmOE+josvvdXOqKZzIWebOaQ+8lO3Am26kA1EZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140150; c=relaxed/simple;
	bh=GvxcA8wr20XF4fdAl9dv1Gnq+YAu/czSgSdTv7mKfqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swBC2F55cKTdgb2M3fNYtEKyQE8zq6oLMwJSWtrcsGYHY/rt1R6CUyQFzaP/zbVVVnqYNeTF3iJ05k//MyyasrughEIagdwsA3RgLDGln4GAup3Sxd9uGaQQ7uzoj02AmVmTvPXFJysD3CxwcP/Jd30XYi9MqC91IfeIl9PxV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjrWK31T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05554C4AF0E;
	Tue, 16 Jul 2024 14:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140150;
	bh=GvxcA8wr20XF4fdAl9dv1Gnq+YAu/czSgSdTv7mKfqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JjrWK31Tgf2ECx+RICyFeAsLcKxekalSZ60fIwoMf8XTjDe/YQzIdHbBumFxxnauk
	 FEyKg6cDEl9OLjy0mt9f3u48sufAGdjpeXynmYPiZLKirXS5obWZdWwP6KsMLJ1ldJ
	 uxXpnPBRxC1Ds/qtyzXs84IjdHKnFxFxzlTaOAZDYTxKN7oFv82339eAhySzoqZggb
	 lOPrj5xcXUjxXvJFNnEuctyZSWNftm2BsDeswUdoTxBykiSimVoKDqVnGaTeM1tKUW
	 iAkyMo2wVJgmJ58Y555wZ4dsZiwzFpCBfzHIgjFnzNrwaxsiqbpUx1Hfo0tDU3kljs
	 MvJeb4W9CsUXg==
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
	andy.chiu@sifive.com,
	samuel.holland@sifive.com,
	dev.mbstr@gmail.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 15/15] riscv: stacktrace: fix usage of ftrace_graph_ret_addr()
Date: Tue, 16 Jul 2024 10:28:12 -0400
Message-ID: <20240716142825.2713416-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142825.2713416-1-sashal@kernel.org>
References: <20240716142825.2713416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.99
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
index 0d3f00eb0baee..10e311b2759d3 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -32,6 +32,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			     bool (*fn)(void *, unsigned long), void *arg)
 {
 	unsigned long fp, sp, pc;
+	int graph_idx = 0;
 	int level = 0;
 
 	if (regs) {
@@ -68,7 +69,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
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


