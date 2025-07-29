Return-Path: <stable+bounces-165093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6883FB15051
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 17:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C631F4E773A
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A761295DB8;
	Tue, 29 Jul 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIXaSEq4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C9295D91
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803650; cv=none; b=lvXK6dV3SnYnkA5WtIcOtXjNrMSqf9kflcJpBpafiqHIKQLah6rGhdZF1WKNBiK/4NhUC8RbH9BccZ31grKHOI0fuHFHEFrMm4/iKkYSmfGtlxBQLa7ZXOiVpQnaog5hQ1RKjKIes2pu0gsbhMRHYiKatAz9mUYPtsjo072Yi9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803650; c=relaxed/simple;
	bh=JnNmyTM3fEN8HHqNuBfE4SoHgH5+ERE3FUGc5xNW6EM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzO3Oj8Saldv28I45X+yxmKEUGs7wy2y1rZ/6ULq07ofgBPlipTIZyYclJpVT+Sb7OZfmsvRbzI09lVMekE2/Yy8Tifg8QZhZPPRvMDM64ZG+WbWwDLr2z49M9iFNtVmpPpzTWGhnl/nXs6C//9exghB45T6fPM03ptdFU5y50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIXaSEq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C92C4CEF4;
	Tue, 29 Jul 2025 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753803649;
	bh=JnNmyTM3fEN8HHqNuBfE4SoHgH5+ERE3FUGc5xNW6EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TIXaSEq4yNY4KHjEaNnmZo4DFJ5iq/nV0ZuCCnNB6yVFJ6FriBg7RtpnjdGIIGQKR
	 fLXcyfLcncF8aV2G55trssYwlmntJDWmunNaLhn6/WWOO6sSZerexxX7B/3Y6nLuRf
	 L4znWgx5NnNJ1fWWw15bhHjNh2a/3ZzwPnD01KFmFZWOV7ydof6P/7UOJtP+NKMN3G
	 7+625SIpkr9mFdwkmH205MwCL2CG+o/Wt2pSACgeIh9SxnawIrKgIjogsHLLZ6TUlZ
	 MR6+0xLeQsU9BdunnBDWwaA04x+vCPVWrSnb7PKv1yQmgr+YQnNP9tuoqt+VdIItS+
	 Lxr6FvZAEjpAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lin.Cao" <lincao12@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/sched: Remove optimization that causes hang when killing dependent jobs
Date: Tue, 29 Jul 2025 11:40:45 -0400
Message-Id: <20250729154045.2736146-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072852-shrivel-theorize-77f8@gregkh>
References: <2025072852-shrivel-theorize-77f8@gregkh>
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
[ replaced drm_sched_wakeup() calls with drm_sched_wakeup_if_can_queue() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 25 ++++--------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index eed3b8bed9e4..245a1ef5278e 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -346,20 +346,9 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity)
 }
 EXPORT_SYMBOL(drm_sched_entity_destroy);
 
-/* drm_sched_entity_clear_dep - callback to clear the entities dependency */
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
 /*
- * drm_sched_entity_clear_dep - callback to clear the entities dependency and
- * wake up scheduler
+ * drm_sched_entity_wakeup - callback to clear the entity's dependency and
+ * wake up the scheduler
  */
 static void drm_sched_entity_wakeup(struct dma_fence *f,
 				    struct dma_fence_cb *cb)
@@ -367,7 +356,8 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
 	struct drm_sched_entity *entity =
 		container_of(cb, struct drm_sched_entity, cb);
 
-	drm_sched_entity_clear_dep(f, cb);
+	entity->dependency = NULL;
+	dma_fence_put(f);
 	drm_sched_wakeup_if_can_queue(entity->rq->sched);
 }
 
@@ -420,13 +410,6 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
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


