Return-Path: <stable+bounces-82642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F757994DC4
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FAB1F237B5
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503571DEFDD;
	Tue,  8 Oct 2024 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wjy+WDV1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8361DED74;
	Tue,  8 Oct 2024 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392938; cv=none; b=QD7fnzurXsZT/Dm1T2E5xgmZIupPF9kBHtcfdy6LzxdRFfkhp58kiaTp2LiD5Ja7H/zPH2e7R0eCay87olKiXEevg9NAIUpLEwKiC3hKVLymLTgCLzcIMpW0lUKeL9H397bq75O1AwrZHwQb0xshM5rMKRjrU7n1Y9SkjVp11Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392938; c=relaxed/simple;
	bh=3lIOERm0VleAnIsciTi9wcNkCUNVB+ysaceYqOaeDVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BErXxHb93J6pkqux/6EVAgmNhCQPbLKmGZ8xIeOPJExXDOxncFAvYFH0wYK3zf+oOzRZHWLfuFqW0WK+2VLdxWox2lmneQmFL2CfA+mT+c3Y8LUxflt0pIVpRUYPAbDs6FiZdVQKiYacZAuwi0oasp2jjOKjapUgpSQ+hdsC2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wjy+WDV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F92BC4CEC7;
	Tue,  8 Oct 2024 13:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392937;
	bh=3lIOERm0VleAnIsciTi9wcNkCUNVB+ysaceYqOaeDVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wjy+WDV1DunhY2sSrAn2C8/XuhufKI6dOcTVkCrlv2NlIk3QjlVnT8JTz4yEXlLt8
	 +09DYHD81jJjlVerOcLd7zG067PfWHSa+to2LQWXA0SKtVPOHp+T7ooPD+22nOHwxe
	 0GmRiXDtPJd/ZFack/T2KOtX+Dmw3GXtBVKdJZMY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 6.11 551/558] drm/sched: revert "Always increment correct scheduler score"
Date: Tue,  8 Oct 2024 14:09:41 +0200
Message-ID: <20241008115723.917720871@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

commit abf201f6ce14c4ceeccde5471bdf59614b83a3d8 upstream.

This reverts commit 087913e0ba2b3b9d7ccbafb2acf5dab9e35ae1d5.

It turned out that the original code was correct since the rq can only
change when there is no armed job for an entity.

This change here broke the logic since we only incremented the counter
for the first job, so revert it.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240930131451.536150-1-christian.koenig@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -586,6 +586,7 @@ void drm_sched_entity_push_job(struct dr
 	ktime_t submit_ts;
 
 	trace_drm_sched_job(sched_job, entity);
+	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
 
 	/*
@@ -613,7 +614,6 @@ void drm_sched_entity_push_job(struct dr
 		rq = entity->rq;
 		sched = rq->sched;
 
-		atomic_inc(sched->score);
 		drm_sched_rq_add_entity(rq, entity);
 		spin_unlock(&entity->rq_lock);
 



