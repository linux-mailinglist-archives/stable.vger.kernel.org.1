Return-Path: <stable+bounces-76090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 957E2978573
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 18:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6BE1C22B89
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 16:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035115B5D6;
	Fri, 13 Sep 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hvxS6qSO"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184D55769
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243575; cv=none; b=V7U/vt1VZtGhF9CxezeN5zGaEmOBxkmb6CAxEO4TTsw2KJatj+FgaNn/lwkD/YcBRKw2vv9h7q2U0R/BxLAlyY5dRYfIHQxcd2dgsnVEP9dkvnzS6add3rKzsk9anUeesS0lytlqh6v1UxogG+TE0wIq/98YWLYMLKS3ezxnllM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243575; c=relaxed/simple;
	bh=cHF50/CO3DfqrsUHY0RcAyr1ePvhbtHtbrapUR1pG30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKMSD83aMrhmTYn0xqE8Qf4GbQcS6/DhLqZMUyEPEzWAUYegtCAlk71g5/+GjMLNfwyBfqpJ5tfdOc2HjR8U8M2kcffuWitaaCm2umWJ9qi0K1xc6jjtV4q2hF2D+pBa5Yv7KFtLQr7oScYXtEBHQ4lHb2n+Vfu1FreiHirdxJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hvxS6qSO; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ly/qYrku6TyMmAQj6Ft96sGeN7fKiUR6tzCBQ1m8y1o=; b=hvxS6qSORxo40/eYh8IuSCnWA0
	S1pS6YB1Uay5bjd0/X3JSJh9hUVukcrYfcPlEIPwxYoyyAwaTS4D3LK+U+C2CVcvVRDNzIQI6IXSB
	jf21GAK8atCxAckihvagtMgZ3hLpaPPu+FH2x1Vrz+X/l1XlIs1q1fcucAgjqk1SXY8Xh55CWu3Kf
	dD6TcwzF14gEgou8FfGfyeUbnhqI9Y6Exgg+/MmMblLbZ+hHfnH5/g58QUbo26dJEo4wCI3PsifdC
	rhIlU7N6Cb3Erl81gLLfpaeXnxFLJ9HeJI7f9D4ktDajM98NlXN6CrLgRV0n7cVmHP8P4UerttuBy
	GVLd7roA==;
Received: from [90.241.98.187] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sp8o6-00DOeU-WA; Fri, 13 Sep 2024 18:06:03 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Philipp Stanner <pstanner@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/8] drm/sched: Always wake up correct scheduler in drm_sched_entity_push_job
Date: Fri, 13 Sep 2024 17:05:53 +0100
Message-ID: <20240913160559.49054-3-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913160559.49054-1-tursulin@igalia.com>
References: <20240913160559.49054-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Since drm_sched_entity_modify_sched() can modify the entities run queue,
lets make sure to only dereference the pointer once so both adding and
waking up are guaranteed to be consistent.

Alternative of moving the spin_unlock to after the wake up would for now
be more problematic since the same lock is taken inside
drm_sched_rq_update_fifo().

v2:
 * Improve commit message. (Philipp)
 * Cache the scheduler pointer directly. (Christian)

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: b37aced31eb0 ("drm/scheduler: implement a function to modify sched list")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Philipp Stanner <pstanner@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.7+
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index ae8be30472cd..76e422548d40 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -599,6 +599,9 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 
 	/* first job wakes up scheduler */
 	if (first) {
+		struct drm_gpu_scheduler *sched;
+		struct drm_sched_rq *rq;
+
 		/* Add the entity to the run queue */
 		spin_lock(&entity->rq_lock);
 		if (entity->stopped) {
@@ -608,13 +611,16 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 			return;
 		}
 
-		drm_sched_rq_add_entity(entity->rq, entity);
+		rq = entity->rq;
+		sched = rq->sched;
+
+		drm_sched_rq_add_entity(rq, entity);
 		spin_unlock(&entity->rq_lock);
 
 		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
 			drm_sched_rq_update_fifo(entity, submit_ts);
 
-		drm_sched_wakeup(entity->rq->sched, entity);
+		drm_sched_wakeup(sched, entity);
 	}
 }
 EXPORT_SYMBOL(drm_sched_entity_push_job);
-- 
2.46.0


