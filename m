Return-Path: <stable+bounces-73807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8013896FA5E
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 20:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBCD2831F1
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4FE1D7987;
	Fri,  6 Sep 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rhI1DW1f"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CBD1D6198
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725645996; cv=none; b=H8rmT9zLudlhnebnEEqBap5U7J+yuhZEU7xGLX7yVcXWrBaWi5ff5tZCQ++X0rFyb/4MsjxTILpIImZpCYDszHFWZkoC2wpSZIfxewoyZHOssgLGKrVmLeSglfIDqr6uzaqP3C0lmZUGwjTK2ZDo9PO6MTkCfULCRjrXceYC2q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725645996; c=relaxed/simple;
	bh=d2gjWK/DJWF7Ooqflx5elAv95cYvZYkjZheW9PjHGE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGGy56M8apy1iQHrunOzyFW+xkQNm5u0YiZJ5BF3EF9SDNokcBEThyL8WBeP3UofMUwcEvrzxrCRcSXYYMXXWRsNJ+OOttzx9GUqJNZZqkCMV68oPljqt7uRW6h+46Cvl+0D4MuO2hNmH64hd43/NGPpDxg/XEYLU/g/YkYfPrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rhI1DW1f; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=piGGUX3dcGMV1LRgKhs90sz/hm+9ab898HF9zimYHKM=; b=rhI1DW1frk/ASWiOYALC0Z/ndx
	X9na8COXHtIrBpDraabBXCoFJb91xz0Pl5QRFkTWaNu2QZpmlo0hs9Gsjr8fXQ65Ww1mOo3Metfro
	N+MiR5f1mTqyg6bREtoHjRoJqJ/bJIrTEoUgQ7oyq5XcuaUiRIfr0kx/PJOa43htpC6nN3SqrHLw/
	XhWe8ItvRRglJX2EjrS49pftlydYmXXRwEfuxCFof0dRUqBXRDWS5CAvSavR/toMabrnPhBxYwwFr
	mkQaVG8yqmBrMEStOAxDZQTsnMdX/gRhmqkwRrDgT5Z9ULgiL2P/gKLH7+RTvW1juFmkHYRKLTYtl
	AKzKxIyg==;
Received: from [90.241.98.187] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1smdLm-00AW6T-IU; Fri, 06 Sep 2024 20:06:26 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Nirmoy Das <nirmoy.das@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	stable@vger.kernel.org
Subject: [RFC 3/4] drm/sched: Always increment correct scheduler score
Date: Fri,  6 Sep 2024 19:06:17 +0100
Message-ID: <20240906180618.12180-4-tursulin@igalia.com>
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

Entities run queue can change during drm_sched_entity_push_job() so make
sure to update the score consistently.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: d41a39dda140 ("drm/scheduler: improve job distribution with multiple queues")
Cc: Nirmoy Das <nirmoy.das@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.9+
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 62b07ef7630a..2a910c1df072 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -586,7 +586,6 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 	ktime_t submit_ts;
 
 	trace_drm_sched_job(sched_job, entity);
-	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
 
 	/*
@@ -612,6 +611,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 
 		rq = entity->rq;
 
+		atomic_inc(rq->sched->score);
 		drm_sched_rq_add_entity(rq, entity);
 		spin_unlock(&entity->rq_lock);
 
-- 
2.46.0


