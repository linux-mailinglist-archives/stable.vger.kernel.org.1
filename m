Return-Path: <stable+bounces-185496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C193BD5E11
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 21:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEE9D4E6ECB
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 19:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EAB2D373F;
	Mon, 13 Oct 2025 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ajefwN/n"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734D2BEC21
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382476; cv=none; b=dTnMMBfdOR7Lsm+E4Q0yJ7Vy/whpQs10EQhgzGTzD8hgFogePmdPpHh0kFCPbRsiRaGV2hpgqAgtMPDxOubWYwERCw+ny4BHaAxKpdJ/xCwRpLDn3oVctj8kTEp7Ar85a6/6+HSXm5664rWaxCsgKXsyUtCACFR6NWC+WTc1qIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382476; c=relaxed/simple;
	bh=5KA0AVFlMvUBqWLmgxFxCefhsTAilydiqBV6B+S1OO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Py8PW2le9iTxsuqqTeLm5ASQLXlOuCJMrWiuU80RPzRsbnq3vi2E5pq9Q0jj1rMvNW06Mvi2XaTzYX6OjuvLL7xhCpBPYwpbEBuUZEXaiJWr06sXXN9A0viqrNq935XiKmcNQQeUbvU7eVwLoDi9H2SNA8i27goJ9uhYwQERc/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ajefwN/n; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NzPTsWVRAp+keFvnAfCWfv8iN5GBfdOJzMc1KcVGwyE=; b=ajefwN/nPqdQfsu9UeDkITs9vY
	+v2o0DOZHkNmpDHhtA0Q7qK/ErOR9/qXzaSzq2ycBJeaxAkzUvwotuI7bGRCwRkHe8BU4iHCUJ8ch
	zxRJ4ay+HDRHdu3j9FR2H/2X2WTXKXesfH5dXJUYzyu5uUiaIwKSD9OLbKCpfsBdfOexGui48YE+u
	+HTXnHxPTsq2vv7HVvu1pes5rDQXDDvJ6jP5Kbf/3sLLm2R1QVelj2NwyukLQ30ZRUu6MWwZQ+rMi
	Jd3MG6kGqhCfuAwYKZHX7oEeAWV0YtcZhnoqS9ejDKdfpkSZowBjB2ZLj7EnuS5UQcuv4DpfedfIs
	A14Wp7aw==;
Received: from [90.242.12.242] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v8NtR-0094U8-Jm; Mon, 13 Oct 2025 21:07:37 +0200
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
Subject: [PATCH v2] drm/sched: Fix potential double free in drm_sched_job_add_resv_dependencies
Date: Mon, 13 Oct 2025 20:07:31 +0100
Message-ID: <20251013190731.63235-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When adding dependencies with drm_sched_job_add_dependency(), that
function consumes the fence reference both on success and failure, so in
the latter case the dma_fence_put() on the error path (xarray failed to
expand) is a double free.

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

While fixing we also improve the comment and explain the reason for taking
the reference and not dropping it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 963d0b356935 ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies harder")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Reference: https://lore.kernel.org/dri-devel/aNFbXq8OeYl3QSdm@stanley.mountain/
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
v2:
 * Re-arrange commit text so discussion around sentences starting with
   capital letters in all cases can be avoided.
 * Keep double return for now.
 * Improved comment instead of dropping it.
---
 drivers/gpu/drm/scheduler/sched_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 46119aacb809..c39f0245e3a9 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -965,13 +965,14 @@ int drm_sched_job_add_resv_dependencies(struct drm_sched_job *job,
 	dma_resv_assert_held(resv);
 
 	dma_resv_for_each_fence(&cursor, resv, usage, fence) {
-		/* Make sure to grab an additional ref on the added fence */
-		dma_fence_get(fence);
-		ret = drm_sched_job_add_dependency(job, fence);
-		if (ret) {
-			dma_fence_put(fence);
+		/*
+		 * As drm_sched_job_add_dependency always consumes the fence
+		 * reference (even when it fails), and dma_resv_for_each_fence
+		 * is not obtaining one, we need to grab one before calling.
+		 */
+		ret = drm_sched_job_add_dependency(job, dma_fence_get(fence));
+		if (ret)
 			return ret;
-		}
 	}
 	return 0;
 }
-- 
2.48.0


