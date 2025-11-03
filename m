Return-Path: <stable+bounces-192195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21407C2BCD9
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 13:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C5F18962A3
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B5730C629;
	Mon,  3 Nov 2025 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT3jkvt0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB1230C355
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173894; cv=none; b=baX1MNnc5OpMgeSCD3wLmC343RloJQlp+2uaXWVTxOm2qZ7g0pm+wHL2sAKlqsKXyTlww03s7j010HZvO0EjjnPdCMnLL9rit4qUVJaIk0Q+2Qs8dfwJdBf4Ju+w4Uw+Ldha/JAlRo9kDrEZPOVixR1/iNjC/UVx3bHcQ5lIJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173894; c=relaxed/simple;
	bh=fC0q0Mt/impFaf5uQCZJ6IZR2AGMuZ1IVzVjwS8Je1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trNc/WW5Nw/++H/v8qxblKw0GCQjSUlJjO7yO9un51E5K53tbM5OzmOHCctWsnmAJAZEt+lo4XZmjqY+w4ziuespRd8vcfPKTXscBYd00gZF9wZYJU16cJq/wpp14MVwA1BqYC3LncsQOi69jLr7KDruY8/ROPBJ61pWVTWFfgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT3jkvt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8136EC4CEE7;
	Mon,  3 Nov 2025 12:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762173893;
	bh=fC0q0Mt/impFaf5uQCZJ6IZR2AGMuZ1IVzVjwS8Je1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LT3jkvt0BNkrAzHVEWWRcz9WG7l67RIm1PnLtbxjMxTVtxtbSuMxayP4FodrT4KDp
	 Vthm+QwvBoiRo6xeQBf6LXwYJkMdNzm+3Y+8bNybpD4g4JxQwaw1Ns/EdpP1f3a5WY
	 47TCHgWCdYa84eg2l8UvX9tPUrDZ1DCsvaqyl5PMkV2NhrjLusOqWFJ6txtqMwqxxX
	 zn7mQ+SzvGH+KyZ+WPkXrBq1EhL/z2BlxHQw2+GoCMXWWEXlOcj8vCPPWk+OLYQKNm
	 OwEdyejVPSES2zxrWHICwW9CXljoqFcdJBZs16n713bmf0iC9JgOiRFdVwQ43FcTP/
	 LOQwravldeaLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] drm/sched: Optimise drm_sched_entity_push_job
Date: Mon,  3 Nov 2025 07:44:48 -0500
Message-ID: <20251103124450.4002293-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110342-exhume-mankind-5952@gregkh>
References: <2025110342-exhume-mankind-5952@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[ Upstream commit d42a254633c773921884a19e8a1a0f53a31150c3 ]

In FIFO mode (which is the default), both drm_sched_entity_push_job() and
drm_sched_rq_update_fifo(), where the latter calls the former, are
currently taking and releasing the same entity->rq_lock.

We can avoid that design inelegance, and also have a miniscule
efficiency improvement on the submit from idle path, by introducing a new
drm_sched_rq_update_fifo_locked() helper and pulling up the lock taking to
its callers.

v2:
 * Remove drm_sched_rq_update_fifo() altogether. (Christian)

v3:
 * Improved commit message. (Philipp)

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241016122013.7857-2-tursulin@igalia.com
Stable-dep-of: d25e3a610bae ("drm/sched: Fix race in drm_sched_entity_select_rq()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 13 +++++++++----
 drivers/gpu/drm/scheduler/sched_main.c   |  6 +++---
 include/drm/gpu_scheduler.h              |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 3e75fc1f66072..9dbae7b08bc90 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -505,8 +505,12 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 		struct drm_sched_job *next;
 
 		next = to_drm_sched_job(spsc_queue_peek(&entity->job_queue));
-		if (next)
-			drm_sched_rq_update_fifo(entity, next->submit_ts);
+		if (next) {
+			spin_lock(&entity->rq_lock);
+			drm_sched_rq_update_fifo_locked(entity,
+							next->submit_ts);
+			spin_unlock(&entity->rq_lock);
+		}
 	}
 
 	/* Jobs and entities might have different lifecycles. Since we're
@@ -606,10 +610,11 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		sched = rq->sched;
 
 		drm_sched_rq_add_entity(rq, entity);
-		spin_unlock(&entity->rq_lock);
 
 		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
-			drm_sched_rq_update_fifo(entity, submit_ts);
+			drm_sched_rq_update_fifo_locked(entity, submit_ts);
+
+		spin_unlock(&entity->rq_lock);
 
 		drm_sched_wakeup(sched);
 	}
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index d5260cb1ed0ec..0b7976c908dde 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -169,14 +169,15 @@ static inline void drm_sched_rq_remove_fifo_locked(struct drm_sched_entity *enti
 	}
 }
 
-void drm_sched_rq_update_fifo(struct drm_sched_entity *entity, ktime_t ts)
+void drm_sched_rq_update_fifo_locked(struct drm_sched_entity *entity, ktime_t ts)
 {
 	/*
 	 * Both locks need to be grabbed, one to protect from entity->rq change
 	 * for entity from within concurrent drm_sched_entity_select_rq and the
 	 * other to update the rb tree structure.
 	 */
-	spin_lock(&entity->rq_lock);
+	lockdep_assert_held(&entity->rq_lock);
+
 	spin_lock(&entity->rq->lock);
 
 	drm_sched_rq_remove_fifo_locked(entity);
@@ -187,7 +188,6 @@ void drm_sched_rq_update_fifo(struct drm_sched_entity *entity, ktime_t ts)
 		      drm_sched_entity_compare_before);
 
 	spin_unlock(&entity->rq->lock);
-	spin_unlock(&entity->rq_lock);
 }
 
 /**
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 9c437a057e5de..346a3c261b437 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -593,7 +593,7 @@ void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
 void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 				struct drm_sched_entity *entity);
 
-void drm_sched_rq_update_fifo(struct drm_sched_entity *entity, ktime_t ts);
+void drm_sched_rq_update_fifo_locked(struct drm_sched_entity *entity, ktime_t ts);
 
 int drm_sched_entity_init(struct drm_sched_entity *entity,
 			  enum drm_sched_priority priority,
-- 
2.51.0


