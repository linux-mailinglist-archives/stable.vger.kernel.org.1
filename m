Return-Path: <stable+bounces-85947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4012B99EAEE
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642C71C230C9
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668701C07DD;
	Tue, 15 Oct 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PQMojQhg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233661C07C4;
	Tue, 15 Oct 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997250; cv=none; b=GEDZAE4aT2V/Fr8xHXu0Bx6H62K94/ljjbwKPonTrqJSWkdP8bSA1s/YUb7ZIhpHLPoT9AHB9h+kLIFUuAHpTyQO+m3khKmmpK4LnJidVTb2cCli7dNUU6X5mFkDMQbasYkf1HXr4ko9tRYjUcW0jAFjS4Fls1GsvV+91Uida30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997250; c=relaxed/simple;
	bh=YnAQeRlrW5Zpx2kB6VJJKOcf/p1RtFqb/E0FOSbTpAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXOVuJKRyL7qIhng4IkqKgl7MCpCfDDMCedMbulEPr/JenNMKIc+0EhFGeXvmYhSB1Ps4skBm51CdVjhDC8aGe1m7BRWZLKvHjc5Ve/Sxl3dFWUQ6rhCpr6cX5kusi7PgBq0e8RpJHI9j/Oz5tFMbZ3dXGhKJlLb40ZYeAaNONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PQMojQhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960F6C4CEC6;
	Tue, 15 Oct 2024 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997250;
	bh=YnAQeRlrW5Zpx2kB6VJJKOcf/p1RtFqb/E0FOSbTpAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQMojQhgLf/ppPz4vJtfQ3w0jq1pq+ALdjdci1UdBZhXImeZ3BpGt34xZA7xLJnPL
	 LUN1SBdqTi7rYZ8p4tcffGnaB4k81RkpBvYVqtlehNWGeP5yswTlOdzmTfCGha8/YU
	 pEaQv1W9tTNoMgj/ZV6mdCyl6MGI3dRXKRqLQmik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rob Clark <robdclark@chromium.org>,
	Jordan Crouse <jcrouse@codeaurora.org>,
	"Kristian H. Kristensen" <hoegsberg@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 127/518] drm/msm: Add priv->mm_lock to protect active/inactive lists
Date: Tue, 15 Oct 2024 14:40:31 +0200
Message-ID: <20241015123921.896511662@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit d984457b31c4c53d2af374d5e78b3eb64debd483 ]

Rather than relying on the big dev->struct_mutex hammer, introduce a
more specific lock for protecting the bo lists.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Kristian H. Kristensen <hoegsberg@google.com>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Stable-dep-of: a30f9f65b5ac ("drm/msm/a5xx: workaround early ring-buffer emptiness check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_debugfs.c      |  7 +++++++
 drivers/gpu/drm/msm/msm_drv.c          |  7 +++++++
 drivers/gpu/drm/msm/msm_drv.h          | 13 +++++++++++-
 drivers/gpu/drm/msm/msm_gem.c          | 28 +++++++++++++++-----------
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 12 +++++++++++
 drivers/gpu/drm/msm/msm_gpu.h          |  5 ++++-
 6 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index 7a7ccad65c922..97cbb850ad6d4 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -113,6 +113,11 @@ static int msm_gem_show(struct drm_device *dev, struct seq_file *m)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gpu *gpu = priv->gpu;
+	int ret;
+
+	ret = mutex_lock_interruptible(&priv->mm_lock);
+	if (ret)
+		return ret;
 
 	if (gpu) {
 		seq_printf(m, "Active Objects (%s):\n", gpu->name);
@@ -122,6 +127,8 @@ static int msm_gem_show(struct drm_device *dev, struct seq_file *m)
 	seq_printf(m, "Inactive Objects:\n");
 	msm_gem_describe_objects(&priv->inactive_list, m);
 
+	mutex_unlock(&priv->mm_lock);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 087efcb1f34cf..130c721fcd4e6 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -7,6 +7,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/kthread.h>
+#include <linux/sched/mm.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/sched/types.h>
 
@@ -442,6 +443,12 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	init_llist_head(&priv->free_list);
 
 	INIT_LIST_HEAD(&priv->inactive_list);
+	mutex_init(&priv->mm_lock);
+
+	/* Teach lockdep about lock ordering wrt. shrinker: */
+	fs_reclaim_acquire(GFP_KERNEL);
+	might_lock(&priv->mm_lock);
+	fs_reclaim_release(GFP_KERNEL);
 
 	drm_mode_config_init(ddev);
 
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 1fe809add8f62..3a49e8eb338c0 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -175,8 +175,19 @@ struct msm_drm_private {
 	struct msm_rd_state *hangrd;   /* debugfs to dump hanging submits */
 	struct msm_perf_state *perf;
 
-	/* list of GEM objects: */
+	/*
+	 * List of inactive GEM objects.  Every bo is either in the inactive_list
+	 * or gpu->active_list (for the gpu it is active on[1])
+	 *
+	 * These lists are protected by mm_lock.  If struct_mutex is involved, it
+	 * should be aquired prior to mm_lock.  One should *not* hold mm_lock in
+	 * get_pages()/vmap()/etc paths, as they can trigger the shrinker.
+	 *
+	 * [1] if someone ever added support for the old 2d cores, there could be
+	 *     more than one gpu object
+	 */
 	struct list_head inactive_list;
+	struct mutex mm_lock;
 
 	/* worker for delayed free of objects: */
 	struct work_struct free_work;
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 9c05bf6c45510..d0201909ee7ae 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -745,13 +745,17 @@ int msm_gem_sync_object(struct drm_gem_object *obj,
 void msm_gem_active_get(struct drm_gem_object *obj, struct msm_gpu *gpu)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	WARN_ON(!mutex_is_locked(&obj->dev->struct_mutex));
+	struct msm_drm_private *priv = obj->dev->dev_private;
+
+	might_sleep();
 	WARN_ON(msm_obj->madv != MSM_MADV_WILLNEED);
 
 	if (!atomic_fetch_inc(&msm_obj->active_count)) {
+		mutex_lock(&priv->mm_lock);
 		msm_obj->gpu = gpu;
 		list_del_init(&msm_obj->mm_list);
 		list_add_tail(&msm_obj->mm_list, &gpu->active_list);
+		mutex_unlock(&priv->mm_lock);
 	}
 }
 
@@ -760,12 +764,14 @@ void msm_gem_active_put(struct drm_gem_object *obj)
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct msm_drm_private *priv = obj->dev->dev_private;
 
-	WARN_ON(!mutex_is_locked(&obj->dev->struct_mutex));
+	might_sleep();
 
 	if (!atomic_dec_return(&msm_obj->active_count)) {
+		mutex_lock(&priv->mm_lock);
 		msm_obj->gpu = NULL;
 		list_del_init(&msm_obj->mm_list);
 		list_add_tail(&msm_obj->mm_list, &priv->inactive_list);
+		mutex_unlock(&priv->mm_lock);
 	}
 }
 
@@ -921,13 +927,16 @@ static void free_object(struct msm_gem_object *msm_obj)
 {
 	struct drm_gem_object *obj = &msm_obj->base;
 	struct drm_device *dev = obj->dev;
+	struct msm_drm_private *priv = dev->dev_private;
 
 	WARN_ON(!mutex_is_locked(&dev->struct_mutex));
 
 	/* object should not be on active list: */
 	WARN_ON(is_active(msm_obj));
 
+	mutex_lock(&priv->mm_lock);
 	list_del(&msm_obj->mm_list);
+	mutex_unlock(&priv->mm_lock);
 
 	mutex_lock(&msm_obj->lock);
 
@@ -1103,14 +1112,9 @@ static struct drm_gem_object *_msm_gem_new(struct drm_device *dev,
 		mapping_set_gfp_mask(obj->filp->f_mapping, GFP_HIGHUSER);
 	}
 
-	if (struct_mutex_locked) {
-		WARN_ON(!mutex_is_locked(&dev->struct_mutex));
-		list_add_tail(&msm_obj->mm_list, &priv->inactive_list);
-	} else {
-		mutex_lock(&dev->struct_mutex);
-		list_add_tail(&msm_obj->mm_list, &priv->inactive_list);
-		mutex_unlock(&dev->struct_mutex);
-	}
+	mutex_lock(&priv->mm_lock);
+	list_add_tail(&msm_obj->mm_list, &priv->inactive_list);
+	mutex_unlock(&priv->mm_lock);
 
 	return obj;
 
@@ -1174,9 +1178,9 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 
 	mutex_unlock(&msm_obj->lock);
 
-	mutex_lock(&dev->struct_mutex);
+	mutex_lock(&priv->mm_lock);
 	list_add_tail(&msm_obj->mm_list, &priv->inactive_list);
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&priv->mm_lock);
 
 	return obj;
 
diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 482576d7a39a5..c41b84a3a4842 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -51,11 +51,15 @@ msm_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
 	if (!msm_gem_shrinker_lock(dev, &unlock))
 		return 0;
 
+	mutex_lock(&priv->mm_lock);
+
 	list_for_each_entry(msm_obj, &priv->inactive_list, mm_list) {
 		if (is_purgeable(msm_obj))
 			count += msm_obj->base.size >> PAGE_SHIFT;
 	}
 
+	mutex_unlock(&priv->mm_lock);
+
 	if (unlock)
 		mutex_unlock(&dev->struct_mutex);
 
@@ -75,6 +79,8 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 	if (!msm_gem_shrinker_lock(dev, &unlock))
 		return SHRINK_STOP;
 
+	mutex_lock(&priv->mm_lock);
+
 	list_for_each_entry(msm_obj, &priv->inactive_list, mm_list) {
 		if (freed >= sc->nr_to_scan)
 			break;
@@ -84,6 +90,8 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 		}
 	}
 
+	mutex_unlock(&priv->mm_lock);
+
 	if (unlock)
 		mutex_unlock(&dev->struct_mutex);
 
@@ -106,6 +114,8 @@ msm_gem_shrinker_vmap(struct notifier_block *nb, unsigned long event, void *ptr)
 	if (!msm_gem_shrinker_lock(dev, &unlock))
 		return NOTIFY_DONE;
 
+	mutex_lock(&priv->mm_lock);
+
 	list_for_each_entry(msm_obj, &priv->inactive_list, mm_list) {
 		if (is_vunmapable(msm_obj)) {
 			msm_gem_vunmap(&msm_obj->base, OBJ_LOCK_SHRINKER);
@@ -118,6 +128,8 @@ msm_gem_shrinker_vmap(struct notifier_block *nb, unsigned long event, void *ptr)
 		}
 	}
 
+	mutex_unlock(&priv->mm_lock);
+
 	if (unlock)
 		mutex_unlock(&dev->struct_mutex);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 6c9e1fdc1a762..1806e87600c0e 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -94,7 +94,10 @@ struct msm_gpu {
 	struct msm_ringbuffer *rb[MSM_GPU_MAX_RINGS];
 	int nr_rings;
 
-	/* list of GEM active objects: */
+	/*
+	 * List of GEM active objects on this gpu.  Protected by
+	 * msm_drm_private::mm_lock
+	 */
 	struct list_head active_list;
 
 	/* does gpu need hw_init? */
-- 
2.43.0




