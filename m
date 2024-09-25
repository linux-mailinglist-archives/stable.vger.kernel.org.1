Return-Path: <stable+bounces-77303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEC3985B9C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A41287464
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2FA1C2306;
	Wed, 25 Sep 2024 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGsTuSpu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DA81C1AD9;
	Wed, 25 Sep 2024 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265073; cv=none; b=J+EHRL/WCeuYvdW3QulE47P5hScFqLpthij2YFQaEs2RdKyGwH2XZIn+EEehEqTgAS1/SsOyPCLGS1uqR0GD8eZYBLaNZNAZzYaUt7Jfyt5ScQCK8WuVN8j28Nc1QNHOoKO4604smjPmwtg0CpGXU/mfqgKmXmdyTUpcI8VTuR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265073; c=relaxed/simple;
	bh=1QP5ayxrDR5BQGpkmtWaF03CGFmV/OvpiA5aYPYCc9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZuifqWeo3ejDBJcSsanqSNDWbTALPxKqwT+KaPYFFS53+6F3BeyKA9CNkoUd2r3pjb1JVxecGBLqo+bdU/BcynhD2ErCOCBH8+Wh3ThzxdDxRYHSlgWT3rS+/5wabE9bwbjgQJtc2X/I9s77mmb6gXVVolyLJeIHe+RJMV9OyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGsTuSpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4A6C4CEC7;
	Wed, 25 Sep 2024 11:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265073;
	bh=1QP5ayxrDR5BQGpkmtWaF03CGFmV/OvpiA5aYPYCc9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGsTuSpuUIFULNgJomzvUZsXHXlVOb+oLZTAIeqDqARfNcVe8ORwJafsKMQK54diV
	 RcerCUZxxc90ErcdaGSix4jhXQf/VzsRHdpR/p8EudO10eGbcRP3kyl3PNGmf1sMrl
	 3nUc2zZcbPPCcFrcC9tieq4xaav+a9j/ximKPgE9onkuQaYYLrDj1dyRYFRnBM7K44
	 wHqh0BNQIhobGQTJXvbXc1IN+91y4vOjGW6FvLG7vWfXAYjQ2m1HrReosnFeEGwKDd
	 R4P1AXaIqeWefbZBqk5DfP9H2FIZhBL7lOAaJ3dYexR1seN3mV1lzjC18fAXrf8eE9
	 t/u+Ut0SCLkqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	acme@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 205/244] perf: Fix event_function_call() locking
Date: Wed, 25 Sep 2024 07:27:06 -0400
Message-ID: <20240925113641.1297102-205-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 558abc7e3f895049faa46b08656be4c60dc6e9fd ]

All the event_function/@func call context already uses perf_ctx_lock()
except for the !ctx->is_active case. Make it all consistent.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240807115550.138301094@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b21c8f24a9876..4339df585d42d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -263,6 +263,7 @@ static int event_function(void *info)
 static void event_function_call(struct perf_event *event, event_f func, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct task_struct *task = READ_ONCE(ctx->task); /* verified in event_function */
 	struct event_function_struct efs = {
 		.event = event,
@@ -291,22 +292,22 @@ static void event_function_call(struct perf_event *event, event_f func, void *da
 	if (!task_function_call(task, event_function, &efs))
 		return;
 
-	raw_spin_lock_irq(&ctx->lock);
+	perf_ctx_lock(cpuctx, ctx);
 	/*
 	 * Reload the task pointer, it might have been changed by
 	 * a concurrent perf_event_context_sched_out().
 	 */
 	task = ctx->task;
 	if (task == TASK_TOMBSTONE) {
-		raw_spin_unlock_irq(&ctx->lock);
+		perf_ctx_unlock(cpuctx, ctx);
 		return;
 	}
 	if (ctx->is_active) {
-		raw_spin_unlock_irq(&ctx->lock);
+		perf_ctx_unlock(cpuctx, ctx);
 		goto again;
 	}
 	func(event, NULL, ctx, data);
-	raw_spin_unlock_irq(&ctx->lock);
+	perf_ctx_unlock(cpuctx, ctx);
 }
 
 /*
-- 
2.43.0


