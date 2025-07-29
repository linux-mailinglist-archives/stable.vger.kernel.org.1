Return-Path: <stable+bounces-165095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DCAB15112
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 18:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 367147ADEA8
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB87441C71;
	Tue, 29 Jul 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuyOmfSK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC83209
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805804; cv=none; b=ZY0UrkpwhQwv5Y0s6x3K9sPCAr7G7FPc+0J2aPjqM8UOEDEsYocimSM73PZznEdmsHck3H+Mp+iWLPNU9PSwFP/g1UEWLqKqJ2gKVzudYO8jGhb970sHZ5n5Gf4pjr9WMiszx9vvE1kAQSChuiSIXiNIb4yt/GJVF3VhKQOnQu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805804; c=relaxed/simple;
	bh=M8rOGbn29UpECiy8i7bH+pyhSx8+I9qWVUnXNDZYbD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEZC5l+kT9i62gyUjV7JxVGNjy5La455kSvGS4TCX3ycZnAkOZVw7XNUPrrvXNKwpT+evnp6nnQbuBvQr/aUX/z034o9mF1GpNBDu1arVopaepFWv93+4Ko1XUsYx9kX78lACRZc7ztu1NjZdo1KHtFGwDztndwqxZnvdThwZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuyOmfSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34886C4CEEF;
	Tue, 29 Jul 2025 16:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753805803;
	bh=M8rOGbn29UpECiy8i7bH+pyhSx8+I9qWVUnXNDZYbD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AuyOmfSKNHBEiQyneJtFDKaZNH7hiM3vxnpSb7tWU3IdmX8YX0I8Q1q5+IK+3M+yz
	 ayIGupDkqHbskWlo5oQsr/w5eEoApbNWCD/wVmrB7aQwsS794Ye072/ClC8XNEOjzA
	 n5gVli7UpG6lEEiqwdYwfixKkvJyJayLHkUmE2w9MoRJmKvfFVKBMUdQLr94YlkwY5
	 PYpD6KrTPVWd0je0lZToeuvMOVOMWd5CD8ejGsLO1PmLkfCo55MG5gVB0YqJN65hSR
	 lVDwqQDUcxy4bMSoNAiC362DzluhT494DJNQUgE6W7fpqfCZZYBQO//bUGeRjYX2lL
	 RKI+cFpNYXp1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lin.Cao" <lincao12@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/sched: Remove optimization that causes hang when killing dependent jobs
Date: Tue, 29 Jul 2025 12:16:38 -0400
Message-Id: <20250729161638.2745002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072854-backlog-freeness-4f50@gregkh>
References: <2025072854-backlog-freeness-4f50@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Lin.Cao" <lincao12@amd.com>

[ Upstream commit 15f77764e90a713ee3916ca424757688e4f565b9 ]

When application A submits jobs and application B submits a job with a
dependency on A's fence, the normal flow wakes up the scheduler after
processing each job. However, the optimization in
drm_sched_entity_add_dependency_cb() uses a callback that only clears
dependencies without waking up the scheduler.

When application A is killed before its jobs can run, the callback gets
triggered but only clears the dependency without waking up the scheduler,
causing the scheduler to enter sleep state and application B to hang.

Remove the optimization by deleting drm_sched_entity_clear_dep() and its
usage, ensuring the scheduler is always woken up when dependencies are
cleared.

Fixes: 777dbd458c89 ("drm/amdgpu: drop a dummy wakeup scheduler")
Cc: stable@vger.kernel.org # v4.6+
Signed-off-by: Lin.Cao <lincao12@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
Link: https://lore.kernel.org/r/20250717084453.921097-1-lincao12@amd.com
[ Changed drm_sched_wakeup_if_can_queue() calls to drm_sched_wakeup() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 27 ++++--------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 049d520226b1..9343b5a74c71 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -317,21 +317,8 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity)
 EXPORT_SYMBOL(drm_sched_entity_destroy);
 
 /*
- * drm_sched_entity_clear_dep - callback to clear the entities dependency
- */
-static void drm_sched_entity_clear_dep(struct dma_fence *f,
-				       struct dma_fence_cb *cb)
-{
-	struct drm_sched_entity *entity =
-		container_of(cb, struct drm_sched_entity, cb);
-
-	entity->dependency = NULL;
-	dma_fence_put(f);
-}
-
-/*
- * drm_sched_entity_clear_dep - callback to clear the entities dependency and
- * wake up scheduler
+ * drm_sched_entity_wakeup - callback to clear the entity's dependency and
+ * wake up the scheduler
  */
 static void drm_sched_entity_wakeup(struct dma_fence *f,
 				    struct dma_fence_cb *cb)
@@ -339,7 +326,8 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
 	struct drm_sched_entity *entity =
 		container_of(cb, struct drm_sched_entity, cb);
 
-	drm_sched_entity_clear_dep(f, cb);
+	entity->dependency = NULL;
+	dma_fence_put(f);
 	drm_sched_wakeup(entity->rq->sched);
 }
 
@@ -395,13 +383,6 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
 		fence = dma_fence_get(&s_fence->scheduled);
 		dma_fence_put(entity->dependency);
 		entity->dependency = fence;
-		if (!dma_fence_add_callback(fence, &entity->cb,
-					    drm_sched_entity_clear_dep))
-			return true;
-
-		/* Ignore it when it is already scheduled */
-		dma_fence_put(fence);
-		return false;
 	}
 
 	if (!dma_fence_add_callback(entity->dependency, &entity->cb,
-- 
2.39.5


