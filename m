Return-Path: <stable+bounces-77666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1827A985FAD
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E2E1C25927
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C23D1D4326;
	Wed, 25 Sep 2024 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyyndGK5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6550191F85;
	Wed, 25 Sep 2024 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266639; cv=none; b=sWb6VlwMV227+kmPGr1/Ur+HzIneSxCPRlJuUWXl5JS3I+ozg5oCLC/meCqWzJLn+zIA10tlyQvrb2GzEISiagcc2S75RD1jNB1pi8zywCOPIGYjM+CVGfOSmHXR+gYrtVr7hsBAZdKLDqy940PGkumFZy2NWQOlSUrkeCBgYi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266639; c=relaxed/simple;
	bh=p0JyOiCbdLIc84pQEST7G90tQWa7dZRRAs/EGip6X1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NymhRMJVDV2CXujGSd9/tfjcmGVB1PxiS/ryuDBqlmWi4XgAPQaklSDWrsB6iNQTV9x+/NgG0apW3Y3iTQgzFMFR0b7P9mpROd/75rGGW27Z2C5q1PVTrY0apCYxEffxZUyVKgwNE3QfNvn31rSAeBPWZ0z4vn4y0EXDbq4nI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyyndGK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D481C4CECD;
	Wed, 25 Sep 2024 12:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266639;
	bh=p0JyOiCbdLIc84pQEST7G90tQWa7dZRRAs/EGip6X1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DyyndGK5v7C2pnsQt/5RdV1M83c0H9g/BpWM3wyaK2EJkTzbh5op6qz5w+U02ipSd
	 uystTfvMTp7Y421zH/Zo7AtrUEorrdm4m8oRHb4L9N/K31ouNoGyZ6kBXhA9zg6MFL
	 T4zx/ppy5Tx2tMUzv7gqIPkMPdjWMf1OMWaHlE5HqgyHcfOa6iW08ZUxlvtGl81YPB
	 Rx9fdNPDROUqEg44FLj7l+2BtZUTuC10YeTOhK2Qi55+MtZKyhvfPT9XHIG1hvLOVR
	 KAQ0sJ9IG/48PxqoIH/45K3xygHiqVIhDBsSMrBLbZN1cRJ+7egwczTWpQx0Wq6neg
	 uXHNYxWulJ7fg==
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
Subject: [PATCH AUTOSEL 6.6 119/139] perf: Fix event_function_call() locking
Date: Wed, 25 Sep 2024 08:08:59 -0400
Message-ID: <20240925121137.1307574-119-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index d40809bdf4b30..18eab7f50ecce 100644
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


