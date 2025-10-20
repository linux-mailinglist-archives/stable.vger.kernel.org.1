Return-Path: <stable+bounces-187980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B3BEFDDA
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4463A831F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7902E9735;
	Mon, 20 Oct 2025 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HC2/gjld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4D92E339B
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948077; cv=none; b=eD6rBCvzzvreUdcuwZo/4m5DOXVIaAnX5F6B6bmpXizD27HZ2uzT8Lhn+6yBmBWrQRuMoj7j8KFejSKPw7PA0u3eb6oEatVDYdhYmEMNNBRXq4mFUVwW/VhAcn+AdCpP9L8FEk/lao10ZMQWMp6YxvoTrQCftExIm/kuu1xxfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948077; c=relaxed/simple;
	bh=JS9LEVBRVXIm5AbgzGLWceNb2QS9oTrAlfRDDj53BP8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eekkqOs0bkXXvPTSTfLSHJYau5zrLVdPTRrrA9khYs0ttCwFjPsy/2UTB65++AOlusgC2dWCVrJILFENWRNIQ4hxvHXWHmG7bCMxsNHL+R5/TMDcoZQthwCWl9muafsNbKijMR04hWuo0dVRX2fwAyZkne3PUlPisgtGWUed92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HC2/gjld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F82C4CEF9;
	Mon, 20 Oct 2025 08:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760948077;
	bh=JS9LEVBRVXIm5AbgzGLWceNb2QS9oTrAlfRDDj53BP8=;
	h=Subject:To:Cc:From:Date:From;
	b=HC2/gjldvM1V+fw6Jhqd6LVUVl3Swty0pyP7CZ2JiYLXq3uaCYW+NzDdsHrjDN7ao
	 dO5hnTBCKKcouCv/qH1UhpBDSNc4yljsB6R758ljMB3Vv6A1ZdO7lcxd9ELKdH7M3r
	 bA1nSZu2RSblbb9lH3agOIFyVheLP48b16CdDd7Y=
Subject: FAILED: patch "[PATCH] drm/sched: Fix potential double free in" failed to apply to 6.1-stable tree
To: tvrtko.ursulin@igalia.com,christian.koenig@amd.com,ckoenig.leichtzumerken@gmail.com,dakr@kernel.org,dan.carpenter@linaro.org,daniel.vetter@ffwll.ch,matthew.brost@intel.com,phasta@kernel.org,robdclark@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 10:14:34 +0200
Message-ID: <2025102034-voltage-truck-aeff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5801e65206b065b0b2af032f7f1eef222aa2fd83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102034-voltage-truck-aeff@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5801e65206b065b0b2af032f7f1eef222aa2fd83 Mon Sep 17 00:00:00 2001
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date: Wed, 15 Oct 2025 09:40:15 +0100
Subject: [PATCH] drm/sched: Fix potential double free in
 drm_sched_job_add_resv_dependencies
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When adding dependencies with drm_sched_job_add_dependency(), that
function consumes the fence reference both on success and failure, so in
the latter case the dma_fence_put() on the error path (xarray failed to
expand) is a double free.

Interestingly this bug appears to have been present ever since
commit ebd5f74255b9 ("drm/sched: Add dependency tracking"), since the code
back then looked like this:

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
commit 9c2ba265352a ("drm/scheduler: use new iterator in drm_sched_job_add_implicit_dependencies v2")
landed, with its fixup of
commit 4eaf02d6076c ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies").

At that point it was a slightly different flavour of a double free, which
commit 963d0b356935 ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies harder")
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
Closes: https://lore.kernel.org/dri-devel/aNFbXq8OeYl3QSdm@stanley.mountain/
Cc: Christian König <christian.koenig@amd.com>
Cc: Rob Clark <robdclark@chromium.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org # v5.16+
Signed-off-by: Philipp Stanner <phasta@kernel.org>
Link: https://lore.kernel.org/r/20251015084015.6273-1-tvrtko.ursulin@igalia.com

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


