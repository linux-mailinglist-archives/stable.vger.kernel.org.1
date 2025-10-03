Return-Path: <stable+bounces-183168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CDFBB65CC
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 11:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1343BDB65
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 09:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20524258EE1;
	Fri,  3 Oct 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nHfOpo/E"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347B81EB5D6
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483633; cv=none; b=DbLQIvZC68YdUM94kctJ1B3y3y54Y9buTlKQWSGrWHvK31CEIC0EGN/bzwacgTjfg//pxBNQstLTTCQxjVOT1ilKVUxkwdAPzpFtZNYZcRVKeq1kmZPy7CcSwUw3Y2g/b20tVRQ1M+H85+4Fi0iFrIiheYn59uPDh1gFxN7cVaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483633; c=relaxed/simple;
	bh=FduCMGB8ugAL+afmkEoxLRdDMDJ7SAHjAAtwCadxfBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aLILyZvCSRceRNb/wnz6MQ3xShjLpo3K6dfeqcbvcR/v3l5CLFLNZlUVhFEFE16XdxO7eYm/V/VxOQs65A4bVOXy6WVYjcRi05evDk/W2NFTHeR5kpis9w8XKOb33gERM2way6fYBhV5MOF6nb/vV5sFx8tZhPzsubZfZ4HguvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nHfOpo/E; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lIIBhuv8Qcx4BkAVq3ng5V3qtF2O1wVYDC1zh7zMIFY=; b=nHfOpo/E2WquEzhkLBB8splHBr
	NypXqxAhqFVBv7XHPXVKe+kKbfa/eS6sxlO6yulw3Lwg6UZQ/GVCDgNzCf3d48JW0fK46Rdso2+jl
	BYl3VSkXcpntQjqoOjPVmrFcFmF6PmOrQAssDSTW4p7JnwuvraI+sMRZo1M8ksgfZ7dzj8L1aIPrm
	oL8FC0JilkTbsF+MYUAp5EQGQ8C1rx/QT7vZni+2nuq/T3K41/mohClDiP6AwlpQrY+51MXLVkU4A
	zryzkKxatEg2RQ9Zcqjy9Lmvx9EuQcAn7wGoNOZB0jtGrbbscoLM5aTZE4zY6tWQiBkqtQy9YVoky
	pa3r6oMw==;
Received: from [84.66.36.92] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v4c3s-003ngf-Ky; Fri, 03 Oct 2025 11:26:48 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Rob Clark <robdclark@chromium.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/sched: Fix potential double free in drm_sched_job_add_resv_dependencies
Date: Fri,  3 Oct 2025 10:26:41 +0100
Message-ID: <20251003092642.37065-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drm_sched_job_add_dependency() consumes the fence reference both on
success and failure, so in the latter case the dma_fence_put() on the
error path (xarray failed to expand) is a double free.

Interestingly this bug appears to have been present ever since
ebd5f74255b9 ("drm/sched: Add dependency tracking"), since the code back
then looked like this:

drm_sched_job_add_implicit_dependencies():
...
       for (i = 0; i < fence_count; i++) {
               ret = drm_sched_job_add_dependency(job, fences[i]);
               if (ret)
                       break;
       }

       for (; i < fence_count; i++)
               dma_fence_put(fences[i]);

Which means for the failing 'i' the dma_fence_put was already a double
free. Possibly there were no users at that time, or the test cases were
insufficient to hit it.

The bug was then only noticed and fixed after
9c2ba265352a ("drm/scheduler: use new iterator in drm_sched_job_add_implicit_dependencies v2")
landed, with its fixup of
4eaf02d6076c ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies").

At that point it was a slightly different flavour of a double free, which
963d0b356935 ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies harder")
noticed and attempted to fix.

But it only moved the double free from happening inside the
drm_sched_job_add_dependency(), when releasing the reference not yet
obtained, to the caller, when releasing the reference already released by
the former in the failure case.

As such it is not easy to identify the right target for the fixes tag so
lets keep it simple and just continue the chain.

We also drop the misleading comment about additional reference, since it
is not additional but the only one from the point of view of dependency
tracking.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 963d0b356935 ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies harder")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Rob Clark <robdclark@chromium.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: "Christian König" <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.16+
---
 drivers/gpu/drm/scheduler/sched_main.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 46119aacb809..aff34240f230 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -960,20 +960,16 @@ int drm_sched_job_add_resv_dependencies(struct drm_sched_job *job,
 {
 	struct dma_resv_iter cursor;
 	struct dma_fence *fence;
-	int ret;
+	int ret = 0;
 
 	dma_resv_assert_held(resv);
 
 	dma_resv_for_each_fence(&cursor, resv, usage, fence) {
-		/* Make sure to grab an additional ref on the added fence */
-		dma_fence_get(fence);
-		ret = drm_sched_job_add_dependency(job, fence);
-		if (ret) {
-			dma_fence_put(fence);
-			return ret;
-		}
+		ret = drm_sched_job_add_dependency(job, dma_fence_get(fence));
+		if (ret)
+			break;
 	}
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(drm_sched_job_add_resv_dependencies);
 
-- 
2.48.0


