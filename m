Return-Path: <stable+bounces-192196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77924C2BCDC
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 13:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06BD1896C27
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7621930C63C;
	Mon,  3 Nov 2025 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUEKYa72"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338F30C355
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173895; cv=none; b=dcDdKYINykvtBc+9aN/t7RNa/IH/0uxA3LCSNA5qpbrci6xa8ob9QwvBRJA020TtKWkbk/AzAZZ7vtwcZ8P2sZWZk+Lx/75FMePzoY0lf1j/9c5dvywUmOQJfz4jhyBSUWvSUUx3C9tGYZleUaRc0mWv6mnqFp0dgfgud6wPNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173895; c=relaxed/simple;
	bh=OlZ/EPdK2XLUvwBhp2wnmYCqX7FG7gY8ZSxhAFdpnVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoCiHMlFxy6dFBGewHP36obMIT9wNeZdAlVzZKWoHda/tEVW0WIWTecani9qdMbjDxqyQxSKwyJXrniJKpXJdmuLEYr2+BX99RXQhdbtll2Da8XS7AxNa/EhrSTOQGNo3scmE2BiYZaz2rHV3JIu2nrXjRds089bL+j89ITpYV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUEKYa72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A78C116B1;
	Mon,  3 Nov 2025 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762173894;
	bh=OlZ/EPdK2XLUvwBhp2wnmYCqX7FG7gY8ZSxhAFdpnVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUEKYa72TXCtFks+7WJWPiGo1xnc4XAV9ehEDhqnRVb3p++SoeMqYxWoWs+upad+/
	 0bo2MwjXxTwJhB24Yn4gsXxE41rZ3WM4w91Huc1Y7I8VqJh+Z/RI66xRDqBuLdEAMU
	 X6rV1nlxOivyLmhi+Bzx4mJ1K8XMs4RvWFqEgayDh8wKXIw093/U9EobR8jS9gePnx
	 vIgw/rykw81yHQCMlX+yLp1igrLx/wnIOJ901W8/a8U0sF1einqwJ9akFK3mbspa7E
	 ORmWkmXuGxQ3aoxBdhrisLXZMpr1AhDiYnOulbHQtpKojMZelQH9BXZyV4H9hY8DKc
	 RuKfgYjjJD0qQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] drm/sched: Re-group and rename the entity run-queue lock
Date: Mon,  3 Nov 2025 07:44:49 -0500
Message-ID: <20251103124450.4002293-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103124450.4002293-1-sashal@kernel.org>
References: <2025110342-exhume-mankind-5952@gregkh>
 <20251103124450.4002293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[ Upstream commit f93126f5d55920d1447ef00a3fbe6706f40f53de ]

When writing to a drm_sched_entity's run-queue, writers are protected
through the lock drm_sched_entity.rq_lock. This naming, however,
frequently collides with the separate internal lock of struct
drm_sched_rq, resulting in uses like this:

	spin_lock(&entity->rq_lock);
	spin_lock(&entity->rq->lock);

Rename drm_sched_entity.rq_lock to improve readability. While at it,
re-order that struct's members to make it more obvious what the lock
protects.

v2:
 * Rename some rq_lock straddlers in kerneldoc, improve commit text. (Philipp)

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
[pstanner: Fix typo in docstring]
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241016122013.7857-5-tursulin@igalia.com
Stable-dep-of: d25e3a610bae ("drm/sched: Fix race in drm_sched_entity_select_rq()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 28 ++++++++++++------------
 drivers/gpu/drm/scheduler/sched_main.c   |  2 +-
 include/drm/gpu_scheduler.h              | 21 +++++++++---------
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 9dbae7b08bc90..089e8ba0435b8 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -105,7 +105,7 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	/* We start in an idle state. */
 	complete_all(&entity->entity_idle);
 
-	spin_lock_init(&entity->rq_lock);
+	spin_lock_init(&entity->lock);
 	spsc_queue_init(&entity->job_queue);
 
 	atomic_set(&entity->fence_seq, 0);
@@ -133,10 +133,10 @@ void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
 {
 	WARN_ON(!num_sched_list || !sched_list);
 
-	spin_lock(&entity->rq_lock);
+	spin_lock(&entity->lock);
 	entity->sched_list = sched_list;
 	entity->num_sched_list = num_sched_list;
-	spin_unlock(&entity->rq_lock);
+	spin_unlock(&entity->lock);
 }
 EXPORT_SYMBOL(drm_sched_entity_modify_sched);
 
@@ -245,10 +245,10 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 	if (!entity->rq)
 		return;
 
-	spin_lock(&entity->rq_lock);
+	spin_lock(&entity->lock);
 	entity->stopped = true;
 	drm_sched_rq_remove_entity(entity->rq, entity);
-	spin_unlock(&entity->rq_lock);
+	spin_unlock(&entity->lock);
 
 	/* Make sure this entity is not used by the scheduler at the moment */
 	wait_for_completion(&entity->entity_idle);
@@ -394,9 +394,9 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
 void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
 				   enum drm_sched_priority priority)
 {
-	spin_lock(&entity->rq_lock);
+	spin_lock(&entity->lock);
 	entity->priority = priority;
-	spin_unlock(&entity->rq_lock);
+	spin_unlock(&entity->lock);
 }
 EXPORT_SYMBOL(drm_sched_entity_set_priority);
 
@@ -506,10 +506,10 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 
 		next = to_drm_sched_job(spsc_queue_peek(&entity->job_queue));
 		if (next) {
-			spin_lock(&entity->rq_lock);
+			spin_lock(&entity->lock);
 			drm_sched_rq_update_fifo_locked(entity,
 							next->submit_ts);
-			spin_unlock(&entity->rq_lock);
+			spin_unlock(&entity->lock);
 		}
 	}
 
@@ -550,14 +550,14 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	if (fence && !dma_fence_is_signaled(fence))
 		return;
 
-	spin_lock(&entity->rq_lock);
+	spin_lock(&entity->lock);
 	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
 	rq = sched ? sched->sched_rq[entity->priority] : NULL;
 	if (rq != entity->rq) {
 		drm_sched_rq_remove_entity(entity->rq, entity);
 		entity->rq = rq;
 	}
-	spin_unlock(&entity->rq_lock);
+	spin_unlock(&entity->lock);
 
 	if (entity->num_sched_list == 1)
 		entity->sched_list = NULL;
@@ -598,9 +598,9 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		struct drm_sched_rq *rq;
 
 		/* Add the entity to the run queue */
-		spin_lock(&entity->rq_lock);
+		spin_lock(&entity->lock);
 		if (entity->stopped) {
-			spin_unlock(&entity->rq_lock);
+			spin_unlock(&entity->lock);
 
 			DRM_ERROR("Trying to push to a killed entity\n");
 			return;
@@ -614,7 +614,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
 			drm_sched_rq_update_fifo_locked(entity, submit_ts);
 
-		spin_unlock(&entity->rq_lock);
+		spin_unlock(&entity->lock);
 
 		drm_sched_wakeup(sched);
 	}
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 0b7976c908dde..4dde0dc525ce5 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -176,7 +176,7 @@ void drm_sched_rq_update_fifo_locked(struct drm_sched_entity *entity, ktime_t ts
 	 * for entity from within concurrent drm_sched_entity_select_rq and the
 	 * other to update the rb tree structure.
 	 */
-	lockdep_assert_held(&entity->rq_lock);
+	lockdep_assert_held(&entity->lock);
 
 	spin_lock(&entity->rq->lock);
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 346a3c261b437..e78adc7a91951 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -96,14 +96,22 @@ struct drm_sched_entity {
 	 */
 	struct list_head		list;
 
+	/**
+	 * @lock:
+	 *
+	 * Lock protecting the run-queue (@rq) to which this entity belongs,
+	 * @priority and the list of schedulers (@sched_list, @num_sched_list).
+	 */
+	spinlock_t			lock;
+
 	/**
 	 * @rq:
 	 *
 	 * Runqueue on which this entity is currently scheduled.
 	 *
 	 * FIXME: Locking is very unclear for this. Writers are protected by
-	 * @rq_lock, but readers are generally lockless and seem to just race
-	 * with not even a READ_ONCE.
+	 * @lock, but readers are generally lockless and seem to just race with
+	 * not even a READ_ONCE.
 	 */
 	struct drm_sched_rq		*rq;
 
@@ -136,17 +144,10 @@ struct drm_sched_entity {
 	 * @priority:
 	 *
 	 * Priority of the entity. This can be modified by calling
-	 * drm_sched_entity_set_priority(). Protected by &rq_lock.
+	 * drm_sched_entity_set_priority(). Protected by @lock.
 	 */
 	enum drm_sched_priority         priority;
 
-	/**
-	 * @rq_lock:
-	 *
-	 * Lock to modify the runqueue to which this entity belongs.
-	 */
-	spinlock_t			rq_lock;
-
 	/**
 	 * @job_queue: the list of jobs of this entity.
 	 */
-- 
2.51.0


