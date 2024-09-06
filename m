Return-Path: <stable+bounces-73808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8818A96FA5F
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 20:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A79285CCC
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 18:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870341D799F;
	Fri,  6 Sep 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TGmBBQMU"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D621D61B7
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725645997; cv=none; b=WxkqojyC5j++ZiGe9fypK/JzNraRtLZmkU7EcG8RzwhqtSt9OAFhMSxDQQ04fixdPw/V9ROh/zvoXwFkb6uspMxLCMXe7b+RGtbNg/oqba2kh/6WXx4Fk8rU2s3X1m97gsfkQWpESn2W1GxkMMeSIX9vJZSCl2kD9oKFxSQMBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725645997; c=relaxed/simple;
	bh=c4OVuj7p//FOUSokdqRBXZCq4Kef38GprbkDsYHE0Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCZTG/gZyuxX7cyYCQCpI6TNxzu7O2OxeCAqkO8l1QKD5kSf5xxw7En1wAWg7fMQRptg7t9rqa5n84jBeU/8yk40ra+a+cWHdl/68YakyF1xM3M0h+xP1idCQ8aLRNPALGw/7yPY8HC5hg2PlqiChSbbBs8OY/rQCUHdVXVemZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TGmBBQMU; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tF0Gxqih49lLW5OGzTjkp8Z2rb+rue64ejmqssXO1rk=; b=TGmBBQMU2mtq1tT+wPpD7P/+DM
	K4gHKHBX0ltP3L6hmGRV7L+haMl/7d8K1DYzGMf+UCz6ZziCVJeoh2Qrr3OdjCfg/mhP+rBgScJNP
	Fg8JYqPDQcF4c07MLmK8dMvvvqpLiGFwN97kliSgvC4ejYSZYHz7cHemtZyC5hFev5MMV1UmckGEq
	AqulMr5Y60mzi4rRhAwK++L/Leh5xMXscbs8oYRGBJunnGKh9L7PcPvjcE9HZqKzH3kKcP8y8/ZNL
	eCfQRmVlw1hNF/BfuGV3rYzi/QwZ1qVuSPfDxKKcjWgzBWduDirx0hg+DCZl7s4R1T++/v1CNYrht
	WfwCN3pg==;
Received: from [90.241.98.187] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1smdLl-00AW6L-Qa; Fri, 06 Sep 2024 20:06:25 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	stable@vger.kernel.org
Subject: [RFC 2/4] drm/sched: Always wake up correct scheduler in drm_sched_entity_push_job
Date: Fri,  6 Sep 2024 19:06:16 +0100
Message-ID: <20240906180618.12180-3-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906180618.12180-1-tursulin@igalia.com>
References: <20240906180618.12180-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Since drm_sched_entity_modify_sched() can modify the entities run queue
lets make sure to only derefernce the pointer once so both adding and
waking up are guaranteed to be consistent.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: b37aced31eb0 ("drm/scheduler: implement a function to modify sched list")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.7+
---
 drivers/gpu/drm/scheduler/sched_entity.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index ae8be30472cd..62b07ef7630a 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -599,6 +599,8 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 
 	/* first job wakes up scheduler */
 	if (first) {
+		struct drm_sched_rq *rq;
+
 		/* Add the entity to the run queue */
 		spin_lock(&entity->rq_lock);
 		if (entity->stopped) {
@@ -608,13 +610,15 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 			return;
 		}
 
-		drm_sched_rq_add_entity(entity->rq, entity);
+		rq = entity->rq;
+
+		drm_sched_rq_add_entity(rq, entity);
 		spin_unlock(&entity->rq_lock);
 
 		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
 			drm_sched_rq_update_fifo(entity, submit_ts);
 
-		drm_sched_wakeup(entity->rq->sched, entity);
+		drm_sched_wakeup(rq->sched, entity);
 	}
 }
 EXPORT_SYMBOL(drm_sched_entity_push_job);
-- 
2.46.0


