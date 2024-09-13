Return-Path: <stable+bounces-76089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9234978571
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 18:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBFE2815A9
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B19558B6;
	Fri, 13 Sep 2024 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KqfaRaBK"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD3936AF8
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243575; cv=none; b=HALKlcvC6AaGnkw557BFCR4O7gfRkKglrrKvC9pZ8T8cgPX2q+TkxtBTSaYuC6d4qma7kdCCenxEMiKO/hvXWAg2WbAhQf9lB3q+lBwHLjj4RVUQAIQZqWEZSV+2RTnWuEXl1TJRjumGJs5NnC2w4UxH7SXdxGRYuk+qzohCP8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243575; c=relaxed/simple;
	bh=58LqM6phHeEkV5bk6Z653rwh9VoChZiYwevPKn7O5mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWeW8wmOasog13u7aTt0u+1Ywin9jugHoreeiK83Rc3jCD2fkWPGHKFuvzv2iHsQV8EhBKVKhqvNEWIi0ZRXeo+paTy7VYM/KniFJv1ekd/p1zHMpjl6b5kmTQEGU5My3tyJms39JA9EsmYPugjA71pY4OSVqto7nhBQMvKochQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KqfaRaBK; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/+G/9TW6m/sQDRxQlSk0p/9/HPvAbDsfuKqAcxJEIIU=; b=KqfaRaBKF2/+4p7URdrDJ6gwaB
	iVzFtQmRu4fnlVBfKhbYRfzywVDi9n9WGxdO28HcVGr68Ia1Ffmu0iDI+AODCAr1vYqGtBl948W8Y
	5Asb3xkE5QKrAut6q6yNV4ZPq7u4wezZDtONq2Mld2kwplhHb1gl4L78gTFbKrfnLKC+lIoy1w5Sk
	UhOkugXjxMHU33agMfEimZXeeyRQzkSwyAJkx4XOID+edd8UhHR/vvOImBJfHEx6DBx7dnmbrEAwD
	0e40sr8e5VZ0U/olL7v+6F2poT2XJSzANpk+LudhvjwHvBCBe/P7nJXHdY8RHJMYaIN7Ujll/CQs8
	XvKvhsTQ==;
Received: from [90.241.98.187] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sp8o7-00DOea-Nj; Fri, 13 Sep 2024 18:06:03 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Nirmoy Das <nirmoy.das@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	stable@vger.kernel.org,
	Nirmoy Das <nirmoy.das@intel.com>
Subject: [PATCH 3/8] drm/sched: Always increment correct scheduler score
Date: Fri, 13 Sep 2024 17:05:54 +0100
Message-ID: <20240913160559.49054-4-tursulin@igalia.com>
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
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 76e422548d40..6645a8524699 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -586,7 +586,6 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 	ktime_t submit_ts;
 
 	trace_drm_sched_job(sched_job, entity);
-	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
 
 	/*
@@ -614,6 +613,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		rq = entity->rq;
 		sched = rq->sched;
 
+		atomic_inc(sched->score);
 		drm_sched_rq_add_entity(rq, entity);
 		spin_unlock(&entity->rq_lock);
 
-- 
2.46.0


