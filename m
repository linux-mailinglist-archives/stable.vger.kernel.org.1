Return-Path: <stable+bounces-74069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5BF972049
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 19:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176DB1C2356A
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB1F16DECB;
	Mon,  9 Sep 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TZlVX4pn"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B48A16E89B
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902394; cv=none; b=WLJdo6+11e9pyHtPMjQy5lIAQNxD71UKURmACr4+bjDBiHvqpFiMZY1SIHt0nlr4IclFkyg58Itf3M6rHjW9CRsh6qJki2SKMznXVz4wUH4Nv4Pbl9KGJALvUEA2B5OCDbZWH5D9szDRxGWxZ042LRAg/diSL62OlGvHxXE/8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902394; c=relaxed/simple;
	bh=58LqM6phHeEkV5bk6Z653rwh9VoChZiYwevPKn7O5mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nG+zhcde9hyBu4Rzt2dl4wIhTFMDudbEW+ChkpK8VNMH3Fhn0QGBHddaQhigkqkQipBO4JhF8CrZDdZE8RE31J8/koN8YSVu5iBvJq+zaendbHlBNkvYihaaR61EYVrC72rHCmYxdN2zaYosiEH0lTCjmeLPi3ZM2BYr+YnYHUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TZlVX4pn; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/+G/9TW6m/sQDRxQlSk0p/9/HPvAbDsfuKqAcxJEIIU=; b=TZlVX4pnGKYQS18eAAIwzIX3FR
	Wm9LLtZdgyvB/1ajrve08MiGJYIHsCa6IZx0IWGSYpttd9y4o4OBsJ/tyHZY0nFcoX33kKOCe39WX
	b1qBBEOW+I/HYyhbid8YtkiYfABoNIEV3p5gTVlTQu9qa1SEjfN6aZR4ZV/Tx0mbpXWXk6fePAY8A
	s9qXueoVcKSBrF/+R0O9mZ9tlOq8cALMPRhVXORsWZZ/2Y4d1x5/cZZk+AoKjbmN3WtkrmJvZugJE
	eQBHzl+wIc+rEz/27ycEsclTGTRBFhM6D2VLC0e4PgqPG0QfOysdmBmYmnfA4IOH+YC+fBegcLlbe
	czbbQ0QA==;
Received: from [90.241.98.187] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sni3D-00Bg4z-7w; Mon, 09 Sep 2024 19:19:43 +0200
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
	stable@vger.kernel.org,
	Nirmoy Das <nirmoy.das@intel.com>
Subject: [PATCH 3/8] drm/sched: Always increment correct scheduler score
Date: Mon,  9 Sep 2024 18:19:32 +0100
Message-ID: <20240909171937.51550-4-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909171937.51550-1-tursulin@igalia.com>
References: <20240909171937.51550-1-tursulin@igalia.com>
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


