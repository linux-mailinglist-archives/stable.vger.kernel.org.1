Return-Path: <stable+bounces-131916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F55EA8226E
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 12:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B4C7A69B1
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAA525D536;
	Wed,  9 Apr 2025 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UhglxuYM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF8B25D210
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195131; cv=none; b=XPd12K3hGS3HifPDAOLj1Pzf5+V1nyBk/vBzAkReBbjMaazCMFivHJ2WPeFSqkz5Xth5YzqC9ow43o1p58Qd8i6Qng4qW2Pm2b9xzKoEHqPMm3oFAQqrWUPZwA0Tqv3aj/8cLQtz3D/cF4gLKZYc2Z8rEDwPced+VcLM70nOUZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195131; c=relaxed/simple;
	bh=o+AjhrvwOzqpxWWvumcXZNVcIwjQpsTTzIZvFoOFzJI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bB01M0TozXNH5Wv1zGZFUHgctBax88oa7i7aBGcD/mu6RThkDmEb2DKOzLRi6RZ0WNafj1BolWuUZQjmYvSDtOHLZdQ8oa958itWy9tdnUazHqZWkN42Ipn3Gj3M7jHVVOwU4pXPbSEzfua+NFeOkHKYKrLnKwBQASicfwZcYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UhglxuYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E54C4CEE3;
	Wed,  9 Apr 2025 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744195130;
	bh=o+AjhrvwOzqpxWWvumcXZNVcIwjQpsTTzIZvFoOFzJI=;
	h=Subject:To:Cc:From:Date:From;
	b=UhglxuYMoVls/c+IZR+dDyrRopc4uJ2bLejKjRstfqto2L8FQW2cbIiF7KDBZVX9b
	 /ASIarr+hoSphBX355jCsHfWXcAitMt1feuwJOiCDrzs7scSTLnerp+k/C7TWgg87b
	 Ubx8UGBxF0xR+UrI9HgpFmkY/NO3xERXqtKGU438=
Subject: FAILED: patch "[PATCH] drm/panthor: Replace sleep locks with spinlocks in fdinfo" failed to apply to 6.13-stable tree
To: adrian.larumbe@collabora.com,boris.brezillon@collabora.com,liviu.dudau@arm.com,steven.price@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Apr 2025 12:37:16 +0200
Message-ID: <2025040916-appraiser-chute-b24d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x e379856b428acafb8ed689f31d65814da6447b2e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040916-appraiser-chute-b24d@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e379856b428acafb8ed689f31d65814da6447b2e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 3 Mar 2025 19:08:45 +0000
Subject: [PATCH] drm/panthor: Replace sleep locks with spinlocks in fdinfo
 path
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

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 1a276db095ff..4d31d1967716 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -9,6 +9,7 @@
 #include <drm/panthor_drm.h>
 
 #include <linux/build_bug.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -631,10 +632,10 @@ struct panthor_group {
 		struct panthor_gpu_usage data;
 
 		/**
-		 * @lock: Mutex to govern concurrent access from drm file's fdinfo callback
-		 * and job post-completion processing function
+		 * @fdinfo.lock: Spinlock to govern concurrent access from drm file's fdinfo
+		 * callback and job post-completion processing function
 		 */
-		struct mutex lock;
+		spinlock_t lock;
 
 		/** @fdinfo.kbo_sizes: Aggregate size of private kernel BO's held by the group. */
 		size_t kbo_sizes;
@@ -910,8 +911,6 @@ static void group_release_work(struct work_struct *work)
 						   release_work);
 	u32 i;
 
-	mutex_destroy(&group->fdinfo.lock);
-
 	for (i = 0; i < group->queue_count; i++)
 		group_free_queue(group, group->queues[i]);
 
@@ -2861,12 +2860,12 @@ static void update_fdinfo_stats(struct panthor_job *job)
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
@@ -2880,12 +2879,11 @@ void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
 
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
@@ -3537,7 +3535,7 @@ int panthor_group_create(struct panthor_file *pfile,
 	mutex_unlock(&sched->reset.lock);
 
 	add_group_kbo_sizes(group->ptdev, group);
-	mutex_init(&group->fdinfo.lock);
+	spin_lock_init(&group->fdinfo.lock);
 
 	return gid;
 


