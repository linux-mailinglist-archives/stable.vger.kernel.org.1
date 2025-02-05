Return-Path: <stable+bounces-113547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F35A292CB
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A6F3AE98A
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133CD190472;
	Wed,  5 Feb 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mz72ULU7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C762F18FDDB;
	Wed,  5 Feb 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767329; cv=none; b=jESX4XtUy9olPFpuMrRKFvdGRDK3FgjLw5H/qIs1ZvvLyF/sMoUqL+vMDDLaHKNeAAvIhvI5osC4Jl0N7uxlfh2yDK3h/QnFTFCvKUKLGVNgBasPzdqFjSVoX2RJNe+/Oe2Ud3joc723vPfJlZJLiqtTdkcj7jd4NHskO9YrYQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767329; c=relaxed/simple;
	bh=52Sfg3jONMXRLH7tVRHjvtIhNVtnE4MCupYwRDMIid0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9iVbvfzoiXpGEpkbb7uZon9PhvNeE5LNb3uB2Xnzl5uyjcLEC+KaUAEAKyqpoIR1l13NicawMr2ZNqxWMoo9fbZs2L0i0jvhEuzQTUuF5qVZbdVuyxLlygfSrIYdp2udoZpmtBgDddFDDxlmihoAPPLGwnsNzfkPlKlVqaNAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mz72ULU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0082DC4CED1;
	Wed,  5 Feb 2025 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767329;
	bh=52Sfg3jONMXRLH7tVRHjvtIhNVtnE4MCupYwRDMIid0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mz72ULU7eLAB0E5ytSb/iTfNybVGtJp83ZNj6apBTdWNM/OwN+Z/M88oYqaPXFZWW
	 H4TuMXTcJYGGjqehhmk+9C5yUh3mjToOaIyRh700nS+RSCT3jrjY4YBV3qp02FbOIU
	 OFDOZVpiTyY9EcJegX24sGBULjh+cyGdt+6ZBiz8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 440/590] erofs: move erofs_workgroup operations into zdata.c
Date: Wed,  5 Feb 2025 14:43:15 +0100
Message-ID: <20250205134512.100877886@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 9c91f959626e6d9f460b8906e27c37fca1b6456a ]

Move related helpers into zdata.c as an intermediate step of getting
rid of `struct erofs_workgroup`, and rename:

 erofs_workgroup_put => z_erofs_put_pcluster
 erofs_workgroup_get => z_erofs_get_pcluster
 erofs_try_to_release_workgroup => erofs_try_to_release_pcluster
 erofs_shrink_workstation => z_erofs_shrink_scan

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20241021035323.3280682-2-hsiangkao@linux.alibaba.com
Stable-dep-of: db902986dee4 ("erofs: fix potential return value overflow of z_erofs_shrink_scan()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/internal.h |   8 ++--
 fs/erofs/zdata.c    | 102 ++++++++++++++++++++++++++++++++++++++---
 fs/erofs/zutil.c    | 107 +++-----------------------------------------
 3 files changed, 105 insertions(+), 112 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b9649e3b2dd56..5fbc76b65f5c3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -452,17 +452,15 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
 void erofs_release_pages(struct page **pagepool);
 
 #ifdef CONFIG_EROFS_FS_ZIP
-void erofs_workgroup_put(struct erofs_workgroup *grp);
-bool erofs_workgroup_get(struct erofs_workgroup *grp);
-void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
+extern atomic_long_t erofs_global_shrink_cnt;
 void erofs_shrinker_register(struct super_block *sb);
 void erofs_shrinker_unregister(struct super_block *sb);
 int __init erofs_init_shrinker(void);
 void erofs_exit_shrinker(void);
 int __init z_erofs_init_subsystem(void);
 void z_erofs_exit_subsystem(void);
-int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
-					struct erofs_workgroup *egrp);
+unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
+				  unsigned long nr_shrink);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags);
 void *z_erofs_get_gbuf(unsigned int requiredpages);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 8c6082fc86b29..d2235f2a0acdc 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -587,8 +587,8 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 }
 
 /* (erofs_shrinker) disconnect cached encoded data with pclusters */
-int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
-					struct erofs_workgroup *grp)
+static int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
+					       struct erofs_workgroup *grp)
 {
 	struct z_erofs_pcluster *const pcl =
 		container_of(grp, struct z_erofs_pcluster, obj);
@@ -710,6 +710,23 @@ static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
 	return ret;
 }
 
+static bool z_erofs_get_pcluster(struct erofs_workgroup *grp)
+{
+	if (lockref_get_not_zero(&grp->lockref))
+		return true;
+
+	spin_lock(&grp->lockref.lock);
+	if (__lockref_is_dead(&grp->lockref)) {
+		spin_unlock(&grp->lockref.lock);
+		return false;
+	}
+
+	if (!grp->lockref.count++)
+		atomic_long_dec(&erofs_global_shrink_cnt);
+	spin_unlock(&grp->lockref.lock);
+	return true;
+}
+
 static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
@@ -757,7 +774,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 			xa_lock(&sbi->managed_pslots);
 			pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
 					   NULL, grp, GFP_KERNEL);
-			if (!pre || xa_is_err(pre) || erofs_workgroup_get(pre)) {
+			if (!pre || xa_is_err(pre) || z_erofs_get_pcluster(pre)) {
 				xa_unlock(&sbi->managed_pslots);
 				break;
 			}
@@ -801,7 +818,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 		while (1) {
 			rcu_read_lock();
 			grp = xa_load(&EROFS_SB(sb)->managed_pslots, blknr);
-			if (!grp || erofs_workgroup_get(grp)) {
+			if (!grp || z_erofs_get_pcluster(grp)) {
 				DBG_BUGON(grp && blknr != grp->index);
 				rcu_read_unlock();
 				break;
@@ -869,7 +886,7 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
 			struct z_erofs_pcluster, rcu));
 }
 
-void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
+static void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
 {
 	struct z_erofs_pcluster *const pcl =
 		container_of(grp, struct z_erofs_pcluster, obj);
@@ -877,6 +894,77 @@ void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
 	call_rcu(&pcl->rcu, z_erofs_rcu_callback);
 }
 
+static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+					  struct erofs_workgroup *grp)
+{
+	int free = false;
+
+	spin_lock(&grp->lockref.lock);
+	if (grp->lockref.count)
+		goto out;
+
+	/*
+	 * Note that all cached folios should be detached before deleted from
+	 * the XArray.  Otherwise some folios could be still attached to the
+	 * orphan old pcluster when the new one is available in the tree.
+	 */
+	if (erofs_try_to_free_all_cached_folios(sbi, grp))
+		goto out;
+
+	/*
+	 * It's impossible to fail after the pcluster is freezed, but in order
+	 * to avoid some race conditions, add a DBG_BUGON to observe this.
+	 */
+	DBG_BUGON(__xa_erase(&sbi->managed_pslots, grp->index) != grp);
+
+	lockref_mark_dead(&grp->lockref);
+	free = true;
+out:
+	spin_unlock(&grp->lockref.lock);
+	if (free) {
+		atomic_long_dec(&erofs_global_shrink_cnt);
+		erofs_workgroup_free_rcu(grp);
+	}
+	return free;
+}
+
+unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
+				  unsigned long nr_shrink)
+{
+	struct erofs_workgroup *grp;
+	unsigned int freed = 0;
+	unsigned long index;
+
+	xa_lock(&sbi->managed_pslots);
+	xa_for_each(&sbi->managed_pslots, index, grp) {
+		/* try to shrink each valid pcluster */
+		if (!erofs_try_to_release_pcluster(sbi, grp))
+			continue;
+		xa_unlock(&sbi->managed_pslots);
+
+		++freed;
+		if (!--nr_shrink)
+			return freed;
+		xa_lock(&sbi->managed_pslots);
+	}
+	xa_unlock(&sbi->managed_pslots);
+	return freed;
+}
+
+static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
+{
+	struct erofs_workgroup *grp = &pcl->obj;
+
+	if (lockref_put_or_lock(&grp->lockref))
+		return;
+
+	DBG_BUGON(__lockref_is_dead(&grp->lockref));
+	if (grp->lockref.count == 1)
+		atomic_long_inc(&erofs_global_shrink_cnt);
+	--grp->lockref.count;
+	spin_unlock(&grp->lockref.lock);
+}
+
 static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 {
 	struct z_erofs_pcluster *pcl = fe->pcl;
@@ -895,7 +983,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
-		erofs_workgroup_put(&pcl->obj);
+		z_erofs_put_pcluster(pcl);
 
 	fe->pcl = NULL;
 }
@@ -1327,7 +1415,7 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		if (z_erofs_is_inline_pcluster(be.pcl))
 			z_erofs_free_pcluster(be.pcl);
 		else
-			erofs_workgroup_put(&be.pcl->obj);
+			z_erofs_put_pcluster(be.pcl);
 	}
 	return err;
 }
diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 218b0249a4822..75704f58ecfa9 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             https://www.huawei.com/
+ * Copyright (C) 2024 Alibaba Cloud
  */
 #include "internal.h"
 
@@ -19,13 +20,12 @@ static unsigned int z_erofs_gbuf_count, z_erofs_gbuf_nrpages,
 module_param_named(global_buffers, z_erofs_gbuf_count, uint, 0444);
 module_param_named(reserved_pages, z_erofs_rsv_nrpages, uint, 0444);
 
-static atomic_long_t erofs_global_shrink_cnt;	/* for all mounted instances */
-/* protected by 'erofs_sb_list_lock' */
-static unsigned int shrinker_run_no;
+atomic_long_t erofs_global_shrink_cnt;	/* for all mounted instances */
 
-/* protects the mounted 'erofs_sb_list' */
+/* protects `erofs_sb_list_lock` and the mounted `erofs_sb_list` */
 static DEFINE_SPINLOCK(erofs_sb_list_lock);
 static LIST_HEAD(erofs_sb_list);
+static unsigned int shrinker_run_no;
 static struct shrinker *erofs_shrinker_info;
 
 static unsigned int z_erofs_gbuf_id(void)
@@ -214,97 +214,6 @@ void erofs_release_pages(struct page **pagepool)
 	}
 }
 
-bool erofs_workgroup_get(struct erofs_workgroup *grp)
-{
-	if (lockref_get_not_zero(&grp->lockref))
-		return true;
-
-	spin_lock(&grp->lockref.lock);
-	if (__lockref_is_dead(&grp->lockref)) {
-		spin_unlock(&grp->lockref.lock);
-		return false;
-	}
-
-	if (!grp->lockref.count++)
-		atomic_long_dec(&erofs_global_shrink_cnt);
-	spin_unlock(&grp->lockref.lock);
-	return true;
-}
-
-static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
-{
-	atomic_long_dec(&erofs_global_shrink_cnt);
-	erofs_workgroup_free_rcu(grp);
-}
-
-void erofs_workgroup_put(struct erofs_workgroup *grp)
-{
-	if (lockref_put_or_lock(&grp->lockref))
-		return;
-
-	DBG_BUGON(__lockref_is_dead(&grp->lockref));
-	if (grp->lockref.count == 1)
-		atomic_long_inc(&erofs_global_shrink_cnt);
-	--grp->lockref.count;
-	spin_unlock(&grp->lockref.lock);
-}
-
-static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
-					   struct erofs_workgroup *grp)
-{
-	int free = false;
-
-	spin_lock(&grp->lockref.lock);
-	if (grp->lockref.count)
-		goto out;
-
-	/*
-	 * Note that all cached pages should be detached before deleted from
-	 * the XArray. Otherwise some cached pages could be still attached to
-	 * the orphan old workgroup when the new one is available in the tree.
-	 */
-	if (erofs_try_to_free_all_cached_folios(sbi, grp))
-		goto out;
-
-	/*
-	 * It's impossible to fail after the workgroup is freezed,
-	 * however in order to avoid some race conditions, add a
-	 * DBG_BUGON to observe this in advance.
-	 */
-	DBG_BUGON(__xa_erase(&sbi->managed_pslots, grp->index) != grp);
-
-	lockref_mark_dead(&grp->lockref);
-	free = true;
-out:
-	spin_unlock(&grp->lockref.lock);
-	if (free)
-		__erofs_workgroup_free(grp);
-	return free;
-}
-
-static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
-					      unsigned long nr_shrink)
-{
-	struct erofs_workgroup *grp;
-	unsigned int freed = 0;
-	unsigned long index;
-
-	xa_lock(&sbi->managed_pslots);
-	xa_for_each(&sbi->managed_pslots, index, grp) {
-		/* try to shrink each valid workgroup */
-		if (!erofs_try_to_release_workgroup(sbi, grp))
-			continue;
-		xa_unlock(&sbi->managed_pslots);
-
-		++freed;
-		if (!--nr_shrink)
-			return freed;
-		xa_lock(&sbi->managed_pslots);
-	}
-	xa_unlock(&sbi->managed_pslots);
-	return freed;
-}
-
 void erofs_shrinker_register(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -321,8 +230,8 @@ void erofs_shrinker_unregister(struct super_block *sb)
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
 	mutex_lock(&sbi->umount_mutex);
-	/* clean up all remaining workgroups in memory */
-	erofs_shrink_workstation(sbi, ~0UL);
+	/* clean up all remaining pclusters in memory */
+	z_erofs_shrink_scan(sbi, ~0UL);
 
 	spin_lock(&erofs_sb_list_lock);
 	list_del(&sbi->list);
@@ -370,9 +279,7 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 
 		spin_unlock(&erofs_sb_list_lock);
 		sbi->shrinker_run_no = run_no;
-
-		freed += erofs_shrink_workstation(sbi, nr - freed);
-
+		freed += z_erofs_shrink_scan(sbi, nr - freed);
 		spin_lock(&erofs_sb_list_lock);
 		/* Get the next list element before we move this one */
 		p = p->next;
-- 
2.39.5




