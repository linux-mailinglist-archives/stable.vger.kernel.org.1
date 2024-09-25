Return-Path: <stable+bounces-77515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7199F985DFC
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B22286610
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEFC1B5836;
	Wed, 25 Sep 2024 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOmCb/iA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BF5208E6F;
	Wed, 25 Sep 2024 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266086; cv=none; b=qSAGbGjs8q1srMJEcsGqLXK9mRKdjruZMdqyz9oNipPvFqFyG3aI3h80EJy0hq3CAkS0AAxrNP3ZRM1BGxdly7duKZO9Z5D+3oO1Rp+l65GV+Kw8y4QYjzyDFcfnC1N4cGWKUWtfVSIOOUKrwJH/ABzdLMdaJ+0T1BeoV+ynICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266086; c=relaxed/simple;
	bh=qViNjhDnwURNqBMyggd43t6rbIrnVfxZrwhGkjgTn6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3S/IU37dKTSznDnxQ/pZWJsz+dYP5K3izz4RIffRvygHme4w/FaP2Jt+7D9DUa2FdG5HevPgoZ5aKAL8hKYfjsrarO+lu/o/KvUx074Rzlj1Dp6/EfL5wacPGV2MxXGt/OV6rz1TSrmogXll4MKjEhLWe85l+RUOp/Eaio2xoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOmCb/iA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05731C4CECD;
	Wed, 25 Sep 2024 12:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266086;
	bh=qViNjhDnwURNqBMyggd43t6rbIrnVfxZrwhGkjgTn6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOmCb/iAKJdoHyEh7fTd1d9t+xDu0W8xzdKFGF6lPuFTVuX7TF4mjmt/jtGnt4Foy
	 tnSFgEd4A2MTnxagNaG3PljXNghOknSCOxrNSlNBdf+Cg79nhdXDFpDquk/YR1LuNh
	 H64oYIwL/J3DUs11Vk5spN6qe0fay1wac6nwyU30zz9RDhW0uYqK1JcMWAotU7sooy
	 3sU5H+oECZbd7P4ihXZejO2LYdLF8FZ+G5rcFtpi0NODDdpmere1nPsMFliL2qIIYX
	 xy6D01BIM428VMLfYwCsk2XLpvEyv34WMafzjlKOcN+8eS/q5Nb1tD4ZBYBuKXuNiB
	 itg+T/bH8E0AA==
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
Subject: [PATCH AUTOSEL 6.10 167/197] perf: Fix event_function_call() locking
Date: Wed, 25 Sep 2024 07:53:06 -0400
Message-ID: <20240925115823.1303019-167-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index 081d9692ce747..e18a07de9920a 100644
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


