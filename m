Return-Path: <stable+bounces-76983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928FA9843FF
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 12:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FC5288591
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 10:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FB01A3A98;
	Tue, 24 Sep 2024 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sIqENFnU"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B52A1A0BD6
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174915; cv=none; b=mBArOcGeo+dYh56E54IjdzaL9xXiXTi9PSCIi7ma/4zk16qY4IqaVoCuwoQznDveM7EB1evNcC3/JqKsWil8P4Lpa6S3hh65Dt4/Bfk13ELqZoCP+lyVxb6rb/Gvvtyb7wGJwXJemYhdDUmZYyJU7EZzvkpb5rsf2dUdIF5oHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174915; c=relaxed/simple;
	bh=3KLpRctQZoPcQNxeFPHGp4KU5yQ26We+xSS4FVjWQzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCME7UuOr9l2LC23/wFLwePDjGiQFf51GMwuohfU1OU+5kHLbaooFf0zSswSeGhY+iJBdJr8sg6lTqExnXlAHOH5OUt/vRxD9TD9u+F5hBgsAvVa6qhD4M247SLRQXk/S/8PjYPNvnBCA1La1APnCxLQ+1xSsYKzGqGZket6iME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sIqENFnU; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OyMmvzjUjl7TCltO+c447day3rIITy8XklFX87gpXZA=; b=sIqENFnUawAYKJUqppcAXpdRqQ
	8KesAbGIcEYAejRByA/jAQelKPfI4FT1WOxmvytiy0QoJt33y2R1MuhGgPPdjJKJizZTEa0IRllg6
	bOs0DuiX9/bV7btS8FSIz+AbWUv3Vu2nL1Wxt59z2ccPbEthdk+Qm2u3KBNtyL7st0/FQ/fsNAFIp
	u8Yck+NtRGSQ1/8CTGH5r03V0xBB0JHmOtQxGcMhtXX4He3yVz4V2bFrNb9Nkgc3OIVEPxjJ9NpHB
	R2y0mbyjcafnOeXl2l5PvP+8xSY54AFg0ttt5di+585knE2Ymm/GGyPUCGJ6Q1g92pCgEE0YXmruX
	W6ObYvpA==;
Received: from [90.241.98.187] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1st2dd-000L2O-BM; Tue, 24 Sep 2024 12:19:21 +0200
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
Date: Tue, 24 Sep 2024 11:19:09 +0100
Message-ID: <20240924101914.2713-4-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240924101914.2713-1-tursulin@igalia.com>
References: <20240924101914.2713-1-tursulin@igalia.com>
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
index a75eede8bf8d..b2cf3e0c1838 100644
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


