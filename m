Return-Path: <stable+bounces-132300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED53A86905
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 01:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C492E1B86108
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 23:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110BC2BD593;
	Fri, 11 Apr 2025 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="jl69uMpT"
X-Original-To: stable@vger.kernel.org
Received: from sender3-op-o12.zoho.com (sender3-op-o12.zoho.com [136.143.184.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E541E47C5
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744412908; cv=pass; b=CyQuDKLpuAhkldWhi0Z8bOmkmMXRqbOU5ytZlaYb54ujWn1aPMNHVUbT/Xw68+PXru283k4nXSRceuGeYr+HQjOYmsS6ssEIb8aUoOaBZqlQSiA6q7NIm/9rYXX+UFZ+OortVF+ZoQ0pRHOhfsl3l0OfdW+bByK8d95ExltIt4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744412908; c=relaxed/simple;
	bh=RPlJHumzePWi6zfxek0y3Id4+ANSEwiCN69ZU5sWAxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAR46BikKzXNNYHjfodzSVb77zrw4bQ+kxLxa7C5uM2hYas1sJsS4eBlZQ/FZj7kXvcBdjlvz1/mjGgtW7tfUOUB6v0dAio4F7FsGp/1MOXSqMOo1XxSnkiERUx/lDOSzEJtObzBzyrNdDsxYCsrauRWUpByiMLJEG8g69cfQKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=jl69uMpT; arc=pass smtp.client-ip=136.143.184.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744412903; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CY5TzjBK+euSbzbPRedgd904ujF7Uq5f4ydRcSGN1iO+Q78RUWWgdnM7INO5hBwT3FD9VnuaI1JsCNhvc2D5c8X9mfQ+TNVVbVHZKh14mjEIwTr9vifK3isrDr6p9XCkxGFZ75XcDfu5STx13FBSpl34YAMIll7WQZcIVi3Sd/w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744412903; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fctzQ2Awgwcv7R2pLa59QIlfgnjE2k729AlFZXsqvNI=; 
	b=iInD8sRFYc8tFu0TYBSDKgq1pWKBnfwPigP7bBurlTBIr5zHowoqEjTgYpU4pSYLxiyp9FIz9uzeEx3VgxkJ4nxKQbMciAyo8311g77wE+Hp3fvzoha4AEeUVGFUf3ITRu/TIRmIJfetPoKsxUwo6RO/lF9ZiNwzCmxfLKzZ+Go=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744412902;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fctzQ2Awgwcv7R2pLa59QIlfgnjE2k729AlFZXsqvNI=;
	b=jl69uMpTl0ajKQPkpQIfazl7zIBpXP+RZ8MreJP2EF6dVeTFOmYg20A7XLTsJYW9
	IMfxZO508dH4wbElLAyUnPqiZyBMZGOtPSQdugtKwfTgZthq4Z6EtYObukrsLtS6LpU
	LGwNpCbNs2L3we55UI3Uio/iBASpkAyfGgyFhFUc=
Received: by mx.zohomail.com with SMTPS id 1744412899604893.8561971456228;
	Fri, 11 Apr 2025 16:08:19 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH 6.13.y] drm/panthor: Replace sleep locks with spinlocks in fdinfo path
Date: Sat, 12 Apr 2025 00:08:03 +0100
Message-ID: <20250411230808.3648376-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025040916-appraiser-chute-b24d@gregkh>
References: <2025040916-appraiser-chute-b24d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 0590c94c3596 ("drm/panthor: Fix race condition when gathering fdinfo
group samples") introduced an xarray lock to deal with potential
use-after-free errors when accessing groups fdinfo figures. However, this
toggles the kernel's atomic context status, so the next nested mutex lock
will raise a warning when the kernel is compiled with mutex debug options:

CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_MUTEXES=y

Replace Panthor's group fdinfo data mutex with a guarded spinlock.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: 0590c94c3596 ("drm/panthor: Fix race condition when gathering fdinfo group samples")
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250303190923.1639985-1-adrian.larumbe@collabora.com
(cherry picked from commit e379856b428acafb8ed689f31d65814da6447b2e)
---
 drivers/gpu/drm/panthor/panthor_sched.c | 28 ++++++++++++-------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index eb2c2ca375d7..52b5543acc19 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -9,6 +9,7 @@
 #include <drm/panthor_drm.h>
 
 #include <linux/build_bug.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -620,14 +621,14 @@ struct panthor_group {
 
 	/** @fdinfo: Per-file total cycle and timestamp values reference. */
 	struct {
-		/** @data: Total sampled values for jobs in queues from this group. */
+		/** @fdinfo.data: Total sampled values for jobs in queues from this group. */
 		struct panthor_gpu_usage data;
 
 		/**
-		 * @lock: Mutex to govern concurrent access from drm file's fdinfo callback
-		 * and job post-completion processing function
+		 * @fdinfo.lock: Spinlock to govern concurrent access from drm file's fdinfo
+		 * callback and job post-completion processing function
 		 */
-		struct mutex lock;
+		spinlock_t lock;
 	} fdinfo;
 
 	/** @state: Group state. */
@@ -900,8 +901,6 @@ static void group_release_work(struct work_struct *work)
 						   release_work);
 	u32 i;
 
-	mutex_destroy(&group->fdinfo.lock);
-
 	for (i = 0; i < group->queue_count; i++)
 		group_free_queue(group, group->queues[i]);
 
@@ -2845,12 +2844,12 @@ static void update_fdinfo_stats(struct panthor_job *job)
 	struct panthor_job_profiling_data *slots = queue->profiling.slots->kmap;
 	struct panthor_job_profiling_data *data = &slots[job->profiling.slot];
 
-	mutex_lock(&group->fdinfo.lock);
-	if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_CYCLES)
-		fdinfo->cycles += data->cycles.after - data->cycles.before;
-	if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_TIMESTAMP)
-		fdinfo->time += data->time.after - data->time.before;
-	mutex_unlock(&group->fdinfo.lock);
+	scoped_guard(spinlock, &group->fdinfo.lock) {
+		if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_CYCLES)
+			fdinfo->cycles += data->cycles.after - data->cycles.before;
+		if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_TIMESTAMP)
+			fdinfo->time += data->time.after - data->time.before;
+	}
 }
 
 void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
@@ -2864,12 +2863,11 @@ void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
 
 	xa_lock(&gpool->xa);
 	xa_for_each(&gpool->xa, i, group) {
-		mutex_lock(&group->fdinfo.lock);
+		guard(spinlock)(&group->fdinfo.lock);
 		pfile->stats.cycles += group->fdinfo.data.cycles;
 		pfile->stats.time += group->fdinfo.data.time;
 		group->fdinfo.data.cycles = 0;
 		group->fdinfo.data.time = 0;
-		mutex_unlock(&group->fdinfo.lock);
 	}
 	xa_unlock(&gpool->xa);
 }
@@ -3491,7 +3489,7 @@ int panthor_group_create(struct panthor_file *pfile,
 	}
 	mutex_unlock(&sched->reset.lock);
 
-	mutex_init(&group->fdinfo.lock);
+	spin_lock_init(&group->fdinfo.lock);
 
 	return gid;
 
-- 
2.48.1


