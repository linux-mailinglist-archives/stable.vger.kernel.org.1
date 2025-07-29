Return-Path: <stable+bounces-165099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AE8B15195
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 18:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BA5188FDB0
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC40296160;
	Tue, 29 Jul 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOhEh82M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E486295DBD
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807453; cv=none; b=jKKYFqaCxyG0sOGUmR6OlUdHGpAglDXKxQdx6oWksZ9y4g3Lk9i+1W+cp+KGFpeKFf3LJlSTxe7tDZDSBy9thRNSfSfe9Fu87Tc/g3Dl04HLw5cTJdHeJj6/vG6ByL3wGiSy2t3bLM5QoC5/bgXT/mZ9pIfkBYK2CFxU2t0t/Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807453; c=relaxed/simple;
	bh=P4PO7hIXRxCEJ9+2jhEtCbbA9FNlK4s7CH+bzTff/vI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aN32kLgO5sxr+Di4viXBYaTdDFVnduBShwNGQEC2EIYSbqoXlQOBQcj3S4iCTynRhTD6FNpkAap8Ke9Noyo3AuuA1TGlDVblFf1TGvhmawo5LVKIEPwqCdrInXN+CGCE8ZcH6hXF+FyBwaDsU6MDZfecXwChtSeGNeed/BgEXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOhEh82M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B93DC4CEEF;
	Tue, 29 Jul 2025 16:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753807452;
	bh=P4PO7hIXRxCEJ9+2jhEtCbbA9FNlK4s7CH+bzTff/vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOhEh82MX6xmtjvByi8t8bfWuSq81W1AGHkZvyGh7fLon7WXLuRvy25xcwfPKznsC
	 C3QINldcAbCX2IGf4yfk6sq0WCTgSCmv8jWhWtXGZLtbYYuzhax4K+c1hN7gQnXDEC
	 8mOAD7zf82G2X0ByIRpqN/P+SmFSfvsXpt6NT+ixljKu+Qzhq5+arLVUDcy7NEBKv+
	 9OhxVgZ/eijR7DEbDyXQ7q2h18XjWp8dwV9+ume8VWgifJo4ttWhTYgfQ4dP9hgejr
	 j3bbnE0W8MfK2le3kEptXux8/3fI5Lh4/KsM5jjfLvzLHMLiNBKjhQhcMvjNSdlV0E
	 srp8aufuX9L8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lin.Cao" <lincao12@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/sched: Remove optimization that causes hang when killing dependent jobs
Date: Tue, 29 Jul 2025 12:44:08 -0400
Message-Id: <20250729164408.2790772-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072854-humbling-collector-aca6@gregkh>
References: <2025072854-humbling-collector-aca6@gregkh>
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
[ adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 750d91370c8a..259bcb3aec7d 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -313,19 +313,6 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity)
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
@@ -336,7 +323,8 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
 	struct drm_sched_entity *entity =
 		container_of(cb, struct drm_sched_entity, cb);
 
-	drm_sched_entity_clear_dep(f, cb);
+	entity->dependency = NULL;
+	dma_fence_put(f);
 	drm_sched_wakeup(entity->rq->sched);
 }
 
@@ -392,13 +380,6 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
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


