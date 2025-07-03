Return-Path: <stable+bounces-159912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC6AF7B6A
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A186E4B21
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2AA2EF9B7;
	Thu,  3 Jul 2025 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QElYUMjm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6D42EAD10;
	Thu,  3 Jul 2025 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555752; cv=none; b=eXzi7cyTNWfriB0jGln/IPXjeRyHxQMcZwMdKesXbWk1UOO7rSE3olxmQ4rrPzeeDZWUszNJXVQY950WpphSvUnYV3f2mlfyd5n3sc5qak8joTQXVXQSygHn8E2FkXvMQxpjBrRrqFAdtbLywZ59MsipfF6TtdAOYgd0Ix2XGAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555752; c=relaxed/simple;
	bh=r6aQjR2DUNkO9gPIQZStTPUgNdtOED9ukbME4MWgafA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8xhWjZ25M/jSB+KXBZOY/4pYaWVjiah4rGhCah1Z0FP2MGGolnXSKL7zGeWYBnDrlyl4BuT/lMkWj7Wr4EVgMSaVKE4W23A4cDFOWqdfoMwGx92awUgncj5RpuWpq9pHZhrh6pxMJt+SSSEFdZUexXwbwY7jG8DoQy2BbVam34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QElYUMjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841F1C4CEE3;
	Thu,  3 Jul 2025 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555752;
	bh=r6aQjR2DUNkO9gPIQZStTPUgNdtOED9ukbME4MWgafA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QElYUMjmvoX/gfNYHLiyrtVBSP/lQXhlPgtsH8zMiyTzhVsQStkXZ+tmnsOgKR5Qt
	 8N43BMli1K1GeUs1n1g0f85KqvA7ozkJWnQlCCpsJwYT1pVa0uTlAvLmE9wc13r10E
	 euRbBPYCLSdT1bmeC1/0qfn3CoGzP7/rWQvKN614=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philipp Stanner <phasta@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 6.6 111/139] drm/etnaviv: Protect the schedulers pending list with its lock
Date: Thu,  3 Jul 2025 16:42:54 +0200
Message-ID: <20250703143945.519217658@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
References: <20250703143941.182414597@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maíra Canal <mcanal@igalia.com>

commit 61ee19dedb8d753249e20308782bf4e9e2fb7344 upstream.

Commit 704d3d60fec4 ("drm/etnaviv: don't block scheduler when GPU is still
active") ensured that active jobs are returned to the pending list when
extending the timeout. However, it didn't use the pending list's lock to
manipulate the list, which causes a race condition as the scheduler's
workqueues are running.

Hold the lock while manipulating the scheduler's pending list to prevent
a race.

Cc: stable@vger.kernel.org
Fixes: 704d3d60fec4 ("drm/etnaviv: don't block scheduler when GPU is still active")
Reported-by: Philipp Stanner <phasta@kernel.org>
Closes: https://lore.kernel.org/dri-devel/964e59ba1539083ef29b06d3c78f5e2e9b138ab8.camel@mailbox.org/
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Philipp Stanner <phasta@kernel.org>
Link: https://lore.kernel.org/r/20250602132240.93314-1-mcanal@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_sched.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
@@ -34,6 +34,7 @@ static enum drm_gpu_sched_stat etnaviv_s
 							  *sched_job)
 {
 	struct etnaviv_gem_submit *submit = to_etnaviv_submit(sched_job);
+	struct drm_gpu_scheduler *sched = sched_job->sched;
 	struct etnaviv_gpu *gpu = submit->gpu;
 	u32 dma_addr;
 	int change;
@@ -76,7 +77,9 @@ static enum drm_gpu_sched_stat etnaviv_s
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 
 out_no_timeout:
-	list_add(&sched_job->list, &sched_job->sched->pending_list);
+	spin_lock(&sched->job_list_lock);
+	list_add(&sched_job->list, &sched->pending_list);
+	spin_unlock(&sched->job_list_lock);
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 }
 



