Return-Path: <stable+bounces-180950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B4AB914D5
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E05188514B
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855C4303A1A;
	Mon, 22 Sep 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b="tuYAP/tz"
X-Original-To: stable@vger.kernel.org
Received: from zdiv.net (zdiv.net [46.226.106.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41727470
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.226.106.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546625; cv=none; b=D1pXcF83GvkIHVe3SGWpFzmOh6eaxEpi4KOiv7bFvbkQmZ8XEAVTq6xnM8EN7m53l/7RCdp/YhU3JU8N9Ok7lXwdCsNd61U6Lykp+h9JTw7zicw7PzLQ7SwMwJvZFLN0k118VN8Trkvig4Pnbi+DS9dYHgQhxsMuNKnqRnT6X4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546625; c=relaxed/simple;
	bh=DyvP0jZ1iD2JhyUFw95SutgKem1jFtae0WS79ARQ5IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VvLow4mWaEQjiiv0ZpC+jAYpuhnqnkOfgHn5eBY3ZeSfXS9JLmyuGjfSFMVTnxhNcdtWHC1jwnreyo3XJAoenUGXFH/UHKQ7ssdG8cmmMQl0DUInYs962mMHOxZrlgcrBsrruyY77s0lzZ3hniNf8GT7cy4deL8p22SymAREIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zdiv.net; spf=pass smtp.mailfrom=zdiv.net; dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b=tuYAP/tz; arc=none smtp.client-ip=46.226.106.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zdiv.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zdiv.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zdiv.net; s=24;
	t=1758546621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cQuBGl3GOV6TPRAdnlyVQ+5L2vuPI57BUnSlE9AXUBM=;
	b=tuYAP/tzrE30hPi4K+a5X2047tI1StFM6lQ3L4ZFXYVHmJkzmMBvvm+BfNhD8eYswgnilM
	YjF+u4XY3dORtXnyoBOGy+2MKN2KwUA0zUoH2ZD9EsIA29jU0iuUs59JJALJ+5DKWSGV30
	GciCvv7wSrlcLTIfDWHGqVow0ab5viCbAhrOcpmBkVEmyBDHgEqVJk2J/isOCuYecNSTlI
	KQkE1dajbeKqjXP+zPtWo4n1+iLZmm+yG3GwWXcdONvcemkNm6OIt/HIIPNcMOH/szh1xn
	xmR9/nbQ81Lk2xY7HWEsOnY1tRJdMKeGju7qRegXOExU3m/1ONcsDyvOyyCYwQ==
Received: from mini.my.domain (<unknown> [2a01:e0a:12:d860:2bfd:172b:4737:fa07])
	by zdiv.net (OpenSMTPD) with ESMTPSA id 6287179c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
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
Subject: [PATCH 6.12.y 1/3] drm/sched: Optimise drm_sched_entity_push_job
Date: Mon, 22 Sep 2025 15:09:46 +0200
Message-ID: <20250922130948.5549-1-jmaselbas@zdiv.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

commit d42a254633c773921884a19e8a1a0f53a31150c3 upstream.

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
(cherry picked from commit d42a254633c773921884a19e8a1a0f53a31150c3)
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 13 +++++++++----
 drivers/gpu/drm/scheduler/sched_main.c   |  6 +++---
 include/drm/gpu_scheduler.h              |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 3e75fc1f6607..9dbae7b08bc9 100644
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
index 416590ea0dc3..3609d5a8fecd 100644
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
index 9c437a057e5d..346a3c261b43 100644
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


