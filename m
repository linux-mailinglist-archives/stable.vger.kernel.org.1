Return-Path: <stable+bounces-180951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1659DB914D8
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4065166D6F
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95EF82899;
	Mon, 22 Sep 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b="IDT8F+3r"
X-Original-To: stable@vger.kernel.org
Received: from zdiv.net (zdiv.net [46.226.106.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B63093A0
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.226.106.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546627; cv=none; b=d6PL0wh3PtONg80oj2HmpIsat9xBjIwBHx0bn2Jb/IE3e9OwxcuO8+/lTUC2oCKv4uGL6X8ATNcyqgHcTqeOxXXTw1CR7QyP3EdGTcThB4K0bJ8KMlGhVtYJgrhlxc+qM47B6UoPan6ZA5f4eTpxiR8ishPJvMYrz0PWF1HSAQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546627; c=relaxed/simple;
	bh=7xqt3JAyQujUdwAAD30iMniTiIDEipfw0ptfRFap5bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxBCKJzNE3pbolAzWQL3+0N5CDOIPBaDWCayXokKCoMOUpOBkHi83AMK5XZhyCQJf71C8v5r/MURmvzVHpGCG7v6GCzRhR+6X2Tx0jza5uJulNThwzjihfa4zqM2TBRcSi8G+B6r+5QLS1s5xE/JCqWMfgjaZdS4Yrj58gYUA1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zdiv.net; spf=pass smtp.mailfrom=zdiv.net; dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b=IDT8F+3r; arc=none smtp.client-ip=46.226.106.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zdiv.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zdiv.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zdiv.net; s=24;
	t=1758546621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTjXZddhzb3UIy43Y5VrdrSsJN0vjZyp5LYGW4D47+0=;
	b=IDT8F+3rbdWXpuqXtfvZ5hU6/Mcg7JLqJ6ubc1IvnedpUvqT4XGxSSQsUNRs92r7gJVN/l
	o3kaY9gBplRv5DgSZLQnGmqyNd7Q334iz6mUoVmv+hO3GeqdXsSlE3mIZwHBnnsHNvHidj
	Pq6g2KN7aSZN9bv4BcAn2YcAtwVN4WdIhKis4E5YVjcDgQDPtz+xUo1edeOlvPcI2sSAbZ
	zOmDge4yd2vwf3QN7dmq4Ivqm9VtPNbSyfPlDxwVv7KNNrh1iG94ALqP7Egd1kkHXqO/k/
	PvsDFYXjF4t+kQ4TAfwAwUaIWc0EOXdgBvYsAMYOajc37Ij9qzWanULDkY4d1Q==
Received: from mini.my.domain (<unknown> [2a01:e0a:12:d860:2bfd:172b:4737:fa07])
	by zdiv.net (OpenSMTPD) with ESMTPSA id 46349170 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Sep 2025 15:10:21 +0200 (CEST)
From: Jules Maselbas <jmaselbas@zdiv.net>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 6.12.y 2/3] drm/sched: Re-group and rename the entity run-queue lock
Date: Mon, 22 Sep 2025 15:09:47 +0200
Message-ID: <20250922130948.5549-2-jmaselbas@zdiv.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922130948.5549-1-jmaselbas@zdiv.net>
References: <20250922130948.5549-1-jmaselbas@zdiv.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

commit f93126f5d55920d1447ef00a3fbe6706f40f53de upstream.

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
(cherry picked from commit f93126f5d55920d1447ef00a3fbe6706f40f53de)
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 28 ++++++++++++------------
 drivers/gpu/drm/scheduler/sched_main.c   |  2 +-
 include/drm/gpu_scheduler.h              | 21 +++++++++---------
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 9dbae7b08bc9..089e8ba0435b 100644
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
index 3609d5a8fecd..d0c3a3d9ca4d 100644
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
index 346a3c261b43..e78adc7a9195 100644
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


