Return-Path: <stable+bounces-82032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF80994AB6
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8C2B227E4
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B511D27B3;
	Tue,  8 Oct 2024 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZfYsVKpe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D691779B1;
	Tue,  8 Oct 2024 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390944; cv=none; b=Y+YcgrXGAqIvREgk1c5aug3iLlSym4oar0/rcEOjVziTW7+RxUJDG7mqb5uoB/XZBll4rPazTEGm7JaYu8DNo+Tn2LTaC3uPM45CBo/BymbiSdYyd3Wfwyq9GddUpN2XJ0Hpe4itOw9FYwcO/5GKhAE0Va0Ht/vj8tqx0lYMkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390944; c=relaxed/simple;
	bh=rnBrmP9dUEToPp45OePR25D3ThEFMu5XBNKjfRF1Gpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgHE99gl6BIRK4z0x22lMremBsoUgHAaxwHQU7bEsZPcvf1bBcXaj8SUlVYaSNejFH+stsFIDNDKu/1ayDGvyJIvBavKVs1MLJqAx4yZQdD3Q9bTlKIs/1+Ugx5IW7lHB8HLVLSZngwJIMcAojfB6gtmG3XR0F9YrBAalSwhWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZfYsVKpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3ADC4CEC7;
	Tue,  8 Oct 2024 12:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390943;
	bh=rnBrmP9dUEToPp45OePR25D3ThEFMu5XBNKjfRF1Gpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfYsVKpef/Apxsrqt88oDkDOzItRXeVZcmytBmNWzsG2qHaeC8JgU91lnxvPgkycJ
	 LAv6bh5pacLiNhdhgLZqfexMoHkELnzP6u+BR0B867KOrQICAU4ernMk3sswD68LF2
	 6RUZEoPqySTwciAah3qf12btxHD4+JshTkrrwW+Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Nirmoy Das <nirmoy.das@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Nirmoy Das <nirmoy.das@intel.com>
Subject: [PATCH 6.10 442/482] drm/sched: Always increment correct scheduler score
Date: Tue,  8 Oct 2024 14:08:25 +0200
Message-ID: <20241008115705.917801566@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

commit 087913e0ba2b3b9d7ccbafb2acf5dab9e35ae1d5 upstream.

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
Link: https://patchwork.freedesktop.org/patch/msgid/20240924101914.2713-4-tursulin@igalia.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -586,7 +586,6 @@ void drm_sched_entity_push_job(struct dr
 	ktime_t submit_ts;
 
 	trace_drm_sched_job(sched_job, entity);
-	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
 
 	/*
@@ -614,6 +613,7 @@ void drm_sched_entity_push_job(struct dr
 		rq = entity->rq;
 		sched = rq->sched;
 
+		atomic_inc(sched->score);
 		drm_sched_rq_add_entity(rq, entity);
 		spin_unlock(&entity->rq_lock);
 



