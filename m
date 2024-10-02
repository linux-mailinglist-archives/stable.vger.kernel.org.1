Return-Path: <stable+bounces-79064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EB898D662
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EB01C2241A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AA71D078E;
	Wed,  2 Oct 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DN4Mx99Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93931D0164;
	Wed,  2 Oct 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876334; cv=none; b=NZflDq+s+u+UTeP+1/9z4cZfLL/MEZcS/UwJxUe9R1513xr1EOkVb8Oqyz0rXZ/gjQhR4Mc41jA04Hi2xwS9E9wK6tSpPHS4qaNj67YE4CpecvPwlmOWYpDoy0pgY6QWIQDpN+sxrdoVIkgsSunCoJZH3eUC8jIAtLk7I0L9Sc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876334; c=relaxed/simple;
	bh=+JVmJYKbYXPmrHcJc2XsKRz6t6ISJ9sTW/AzxSrqoR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEWiCvs74dPQ+O/CkBW9vymjuq4hpP9HUjsrLEYMPLCS/Bw5IUE630xwO0MPtT+z4otg/kvVuqoPefk2a+xhw3yP3aiz4t2aQ4jeF/LF3L7TLoWJOSnewFReVHnDom4/g13DD6fea+HFHiUgoOXzs07iIHdr6kG6GV9EgFIcA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DN4Mx99Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FFCC4CEC5;
	Wed,  2 Oct 2024 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876333;
	bh=+JVmJYKbYXPmrHcJc2XsKRz6t6ISJ9sTW/AzxSrqoR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DN4Mx99Y/TqralrUiG1N6R89Ze6tckTUqqaxYunUrqHuHNvKYQP01sc/JHjX8BENc
	 rN5b48CnQRxlby30iis912XbDzaCQmXFTeZroY0Y14g38gGGO1pKmEznX3+i1V/ofl
	 DG3JV6u06EEg+Es9lj8A8hB35R/sNaCAx1QLXX8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 408/695] RDMA/mlx5: Fix MR cache temp entries cleanup
Date: Wed,  2 Oct 2024 14:56:46 +0200
Message-ID: <20241002125838.740894265@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Guralnik <michaelgur@nvidia.com>

[ Upstream commit 7ebb00cea49db641b458edef0ede389f7004821d ]

Fix the cleanup of the temp cache entries that are dynamically created
in the MR cache.

The cleanup of the temp cache entries is currently scheduled only when a
new entry is created. Since in the cleanup of the entries only the mkeys
are destroyed and the cache entry stays in the cache, subsequent
registrations might reuse the entry and it will eventually be filled with
new mkeys without cleanup ever getting scheduled again.

On workloads that register and deregister MRs with a wide range of
properties we see the cache ends up holding many cache entries, each
holding the max number of mkeys that were ever used through it.

Additionally, as the cleanup work is scheduled to run over the whole
cache, any mkey that is returned to the cache after the cleanup was
scheduled will be held for less than the intended 30 seconds timeout.

Solve both issues by dropping the existing remove_ent_work and reusing
the existing per-entry work to also handle the temp entries cleanup.

Schedule the work to run with a 30 seconds delay every time we push an
mkey to a clean temp entry.
This ensures the cleanup runs on each entry only 30 seconds after the
first mkey was pushed to an empty entry.

As we have already been distinguishing between persistent and temp entries
when scheduling the cache_work_func, it is not being scheduled in any
other flows for the temp entries.

Another benefit from moving to a per-entry cleanup is we now not
required to hold the rb_tree mutex, thus enabling other flow to run
concurrently.

Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Link: https://patch.msgid.link/e4fa4bb03bebf20dceae320f26816cd2dde23a26.1725362530.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
 drivers/infiniband/hw/mlx5/mr.c      | 82 +++++++++++-----------------
 2 files changed, 32 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index d5eb1b726675d..85118b7cb63db 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -796,6 +796,7 @@ struct mlx5_cache_ent {
 	u8 is_tmp:1;
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
+	u8 tmp_cleanup_scheduled:1;
 
 	/*
 	 * - limit is the low water mark for stored mkeys, 2* limit is the
@@ -827,7 +828,6 @@ struct mlx5_mkey_cache {
 	struct mutex		rb_lock;
 	struct dentry		*fs_root;
 	unsigned long		last_add;
-	struct delayed_work	remove_ent_dwork;
 };
 
 struct mlx5_ib_port_resources {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 19f5e5957e180..e4db3a9569c14 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -528,6 +528,21 @@ static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 	}
 }
 
+static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
+{
+	u32 mkey;
+
+	spin_lock_irq(&ent->mkeys_queue.lock);
+	while (ent->mkeys_queue.ci) {
+		mkey = pop_mkey_locked(ent);
+		spin_unlock_irq(&ent->mkeys_queue.lock);
+		mlx5_core_destroy_mkey(dev->mdev, mkey);
+		spin_lock_irq(&ent->mkeys_queue.lock);
+	}
+	ent->tmp_cleanup_scheduled = false;
+	spin_unlock_irq(&ent->mkeys_queue.lock);
+}
+
 static void __cache_work_func(struct mlx5_cache_ent *ent)
 {
 	struct mlx5_ib_dev *dev = ent->dev;
@@ -599,7 +614,11 @@ static void delayed_cache_work_func(struct work_struct *work)
 	struct mlx5_cache_ent *ent;
 
 	ent = container_of(work, struct mlx5_cache_ent, dwork.work);
-	__cache_work_func(ent);
+	/* temp entries are never filled, only cleaned */
+	if (ent->is_tmp)
+		clean_keys(ent->dev, ent);
+	else
+		__cache_work_func(ent);
 }
 
 static int cache_ent_key_cmp(struct mlx5r_cache_rb_key key1,
@@ -775,20 +794,6 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 	return _mlx5_mr_cache_alloc(dev, ent, access_flags);
 }
 
-static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
-{
-	u32 mkey;
-
-	spin_lock_irq(&ent->mkeys_queue.lock);
-	while (ent->mkeys_queue.ci) {
-		mkey = pop_mkey_locked(ent);
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-		mlx5_core_destroy_mkey(dev->mdev, mkey);
-		spin_lock_irq(&ent->mkeys_queue.lock);
-	}
-	spin_unlock_irq(&ent->mkeys_queue.lock);
-}
-
 static void mlx5_mkey_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
 {
 	if (!mlx5_debugfs_root || dev->is_rep)
@@ -901,10 +906,6 @@ mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
 			ent->limit = 0;
 
 		mlx5_mkey_cache_debugfs_add_ent(dev, ent);
-	} else {
-		mod_delayed_work(ent->dev->cache.wq,
-				 &ent->dev->cache.remove_ent_dwork,
-				 msecs_to_jiffies(30 * 1000));
 	}
 
 	return ent;
@@ -915,35 +916,6 @@ mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
 	return ERR_PTR(ret);
 }
 
-static void remove_ent_work_func(struct work_struct *work)
-{
-	struct mlx5_mkey_cache *cache;
-	struct mlx5_cache_ent *ent;
-	struct rb_node *cur;
-
-	cache = container_of(work, struct mlx5_mkey_cache,
-			     remove_ent_dwork.work);
-	mutex_lock(&cache->rb_lock);
-	cur = rb_last(&cache->rb_root);
-	while (cur) {
-		ent = rb_entry(cur, struct mlx5_cache_ent, node);
-		cur = rb_prev(cur);
-		mutex_unlock(&cache->rb_lock);
-
-		spin_lock_irq(&ent->mkeys_queue.lock);
-		if (!ent->is_tmp) {
-			spin_unlock_irq(&ent->mkeys_queue.lock);
-			mutex_lock(&cache->rb_lock);
-			continue;
-		}
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-
-		clean_keys(ent->dev, ent);
-		mutex_lock(&cache->rb_lock);
-	}
-	mutex_unlock(&cache->rb_lock);
-}
-
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_mkey_cache *cache = &dev->cache;
@@ -959,7 +931,6 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->slow_path_mutex);
 	mutex_init(&dev->cache.rb_lock);
 	dev->cache.rb_root = RB_ROOT;
-	INIT_DELAYED_WORK(&dev->cache.remove_ent_dwork, remove_ent_work_func);
 	cache->wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
 	if (!cache->wq) {
 		mlx5_ib_warn(dev, "failed to create work queue\n");
@@ -1010,7 +981,6 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 		return;
 
 	mutex_lock(&dev->cache.rb_lock);
-	cancel_delayed_work(&dev->cache.remove_ent_dwork);
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		spin_lock_irq(&ent->mkeys_queue.lock);
@@ -1861,8 +1831,18 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
 	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
 
-	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr))
+	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr)) {
+		ent = mr->mmkey.cache_ent;
+		/* upon storing to a clean temp entry - schedule its cleanup */
+		spin_lock_irq(&ent->mkeys_queue.lock);
+		if (ent->is_tmp && !ent->tmp_cleanup_scheduled) {
+			mod_delayed_work(ent->dev->cache.wq, &ent->dwork,
+					 msecs_to_jiffies(30 * 1000));
+			ent->tmp_cleanup_scheduled = true;
+		}
+		spin_unlock_irq(&ent->mkeys_queue.lock);
 		return 0;
+	}
 
 	if (ent) {
 		spin_lock_irq(&ent->mkeys_queue.lock);
-- 
2.43.0




