Return-Path: <stable+bounces-5401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D904A80CBC5
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B7F281FF0
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213D547A45;
	Mon, 11 Dec 2023 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWzMcxxz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14014776B;
	Mon, 11 Dec 2023 13:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A60C433C9;
	Mon, 11 Dec 2023 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302847;
	bh=GK4QKJzdH8xJclUvoSi7bhMR3Qj3mX8sc8lN1h3KH3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWzMcxxzuEJOYCulIaSA5WjqufdHZ/AFsPZdjlw5hRAC7LUkRGKtukndqr2h59eIM
	 ypLam2pfH3v4YEtZQiIGTquf0GenAx0w6qtVOhGConxE0d4eUPqzCw6nrM3yKDaO5r
	 aVgTZhHXPJaWFgNPEqJRbBvFeYDjah0lUQ6leKupck+TYeF1JtkZ4dRSEl2Z5P411l
	 MM8yMkFC9VEsWGn70+sPFK+Y/eOS5l2cEkKAmryY2YiQrTNivAx0C5pNlOYH8QkQws
	 TTdyWhW6syNNCOPbKL6a2ytaM/3Cdic8eUrc0IM8wIJlkaHJBnAzlAeXtKzUcEfMt6
	 ChvwohfoJa9JQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jinyang He <hejinyang@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	lienze@kylinos.cn,
	yangtiezhu@loongson.cn,
	zhangqing@loongson.cn,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 46/47] LoongArch: Set unwind stack type to unknown rather than set error flag
Date: Mon, 11 Dec 2023 08:50:47 -0500
Message-ID: <20231211135147.380223-46-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit

From: Jinyang He <hejinyang@loongson.cn>

[ Upstream commit 97ceddbc9404a7d1e2c4049435bff29427d762cc ]

During unwinding, unwind_done() is used as an end condition. Normally it
unwind to the user stack and then set the stack type to unknown, which
is a normal exit. When something unexpected happens in unwind process
and we cannot unwind anymore, we should set the error flag, and also set
the stack type to unknown to indicate that the unwind process can not
continue. The error flag emphasizes that the unwind process produce an
unexpected error. There is no unexpected things when we unwind the PT_REGS
in the top of IRQ stack and find out that is an user mode PT_REGS. Thus,
we should not set error flag and just set stack type to unknown.

Reported-by: Hengqi Chen <hengqi.chen@gmail.com>
Acked-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/stacktrace.c      | 2 +-
 arch/loongarch/kernel/unwind.c          | 1 -
 arch/loongarch/kernel/unwind_prologue.c | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/stacktrace.c b/arch/loongarch/kernel/stacktrace.c
index 92270f14db948..f623feb2129f1 100644
--- a/arch/loongarch/kernel/stacktrace.c
+++ b/arch/loongarch/kernel/stacktrace.c
@@ -32,7 +32,7 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 	}
 
 	for (unwind_start(&state, task, regs);
-	     !unwind_done(&state) && !unwind_error(&state); unwind_next_frame(&state)) {
+	     !unwind_done(&state); unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
 		if (!addr || !consume_entry(cookie, addr))
 			break;
diff --git a/arch/loongarch/kernel/unwind.c b/arch/loongarch/kernel/unwind.c
index ba324ba76fa15..a463d6961344c 100644
--- a/arch/loongarch/kernel/unwind.c
+++ b/arch/loongarch/kernel/unwind.c
@@ -28,6 +28,5 @@ bool default_next_frame(struct unwind_state *state)
 
 	} while (!get_stack_info(state->sp, state->task, info));
 
-	state->error = true;
 	return false;
 }
diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
index 55afc27320e12..929ae240280a5 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -227,7 +227,7 @@ static bool next_frame(struct unwind_state *state)
 	} while (!get_stack_info(state->sp, state->task, info));
 
 out:
-	state->error = true;
+	state->stack_info.type = STACK_TYPE_UNKNOWN;
 	return false;
 }
 
-- 
2.42.0


