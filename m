Return-Path: <stable+bounces-165106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3101BB151F0
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658973BDB04
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 17:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DBC298CD5;
	Tue, 29 Jul 2025 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FB9FsVeh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4815A298CC3
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809302; cv=none; b=gUZuIy36oCbStNcYv0CgL5fbsJn/Z5cGt5nWZZYW93dGmWxWbqrfzg8kKSt2PNtMtaIE3NBk/wP1eRoUze4uFcEtXEpo+v4Ex/2dMVN+4/lnAYxZ6LDBtFVIBoGETmgjEzoT0CALZL92V+Zm+wL5A3W0fwRBVxwR272uyGqFy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809302; c=relaxed/simple;
	bh=cR9COhT2vhCFWAePg4zLviWdsd9iTTa49HVQiRvQoqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAJEroyhUiKP2fTNcB5myS3Mo74v3l9+ZTBtXjn6FOhfDbHFO3Qu40xwWIfd/CpyYB+lkGZU00xA0eQEPeAxr7fMp8thsOt/1GD6OBuWEgiRf//Lz5j6iCdILuWnY0AhPrzUqpedN5Pa7K3JJ8PqA40qRVBrNKx+9sahTsd8+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FB9FsVeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D32EC4CEF4;
	Tue, 29 Jul 2025 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753809301;
	bh=cR9COhT2vhCFWAePg4zLviWdsd9iTTa49HVQiRvQoqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FB9FsVehMXpo/mVwazP+MlBExVTS77LNu4vIfnNAgUZD9UA22IsVW195ngVkZALg2
	 PhfKx9TdlEgcO+lsD9zgii3rBRwP3ckMSMVWsyMfY8CMp+avLel3GtZ8XJMAzsTd9R
	 mA6TbkVCzvblfBbLwiEeqYne9B+HMAxkM03BjV5W/cb21GGHfEL3QgklmN2uUeK5x9
	 SNDTZ78tOp3TAEjMH4rGgKfbApM5XmEwpyBJEpQFrpxNfbTWmTLC5DbYdHpKfRqI0X
	 IH6tR20ZRWLEMrSneZPR08G8/KWVHoUJb3L3pOH6OXrwxAy2KF6s6ViNqTwOEnn9dX
	 +qW4T1vaup4wQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lin.Cao" <lincao12@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] drm/sched: Remove optimization that causes hang when killing dependent jobs
Date: Tue, 29 Jul 2025 13:14:55 -0400
Message-Id: <20250729171455.2825719-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072855-spongy-yodel-58e6@gregkh>
References: <2025072855-spongy-yodel-58e6@gregkh>
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
[ adjusted context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 57f9baad9e36..d9b20bb7c7f5 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -327,19 +327,6 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity)
 }
 EXPORT_SYMBOL(drm_sched_entity_destroy);
 
-/**
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
 /**
  * drm_sched_entity_clear_dep - callback to clear the entities dependency and
  * wake up scheduler
@@ -350,7 +337,8 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
 	struct drm_sched_entity *entity =
 		container_of(cb, struct drm_sched_entity, cb);
 
-	drm_sched_entity_clear_dep(f, cb);
+	entity->dependency = NULL;
+	dma_fence_put(f);
 	drm_sched_wakeup(entity->rq->sched);
 }
 
@@ -426,13 +414,6 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
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


