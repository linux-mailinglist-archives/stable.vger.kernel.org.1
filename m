Return-Path: <stable+bounces-59915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F48932C67
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF8F1F24441
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDE219DFB9;
	Tue, 16 Jul 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rTSvRtBr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AECD17A93F;
	Tue, 16 Jul 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145295; cv=none; b=tm+ZOCb96dRCRDOD6K1p9cAqCyMU4a2+9G+slJ1iS4KcQT1sae+yFSXdPh6LYMlrwcnwYA6BNu0LLqtc98VnT50sbhBJd51d88FHFsZMfJXaj1JYQkepE+xG0ZVpbhH8D2jNt2JTrrmmUhiuMF7z019YE//+9jP6x5OSWi8W6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145295; c=relaxed/simple;
	bh=qP+C0Tl6JDCXwQao3uRjhpXRvCjJHU7/yd3m3do3JAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sutT7qIvl8kgdyzkNJtJLN4rg15zT4zGaHpObH+ETQrsz0ddXKzjXyy5F8IB1MiFsKCyQ6sH8Ep/fv3ar8jTfHu74sMeGxHxWEVuWgklB+1elD710WRwZ2dczmIGOqacjoVOhvxvhyGFKtIk3tqc/oJ27t7SkWuwcpRlhno4A9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rTSvRtBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B354DC116B1;
	Tue, 16 Jul 2024 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145295;
	bh=qP+C0Tl6JDCXwQao3uRjhpXRvCjJHU7/yd3m3do3JAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTSvRtBroT2ZWMftUQcw9YleidzI4WwO1o7nGeIk+Ds28P7OR885CSS8KqOsm1koX
	 0HJhE7KVWLO5lZaWk7sMO6Iew8NIyvRXMNin41Tn46WnXXGLkHcRYcKxinueXJkpwc
	 dgv1CftQILFOhJZczE9jiG2Bf58n6piygHTPPgOk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Yonghong Song <yhs@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 19/96] bpf: Refactor some inode/task/sk storage functions for reuse
Date: Tue, 16 Jul 2024 17:31:30 +0200
Message-ID: <20240716152747.256059671@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152746.516194097@linuxfoundation.org>
References: <20240716152746.516194097@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yonghong Song <yhs@fb.com>

[ Upstream commit c83597fa5dc6b322e9bdf929e5f4136a3f4aa4db ]

Refactor codes so that inode/task/sk storage implementation
can maximally share the same code. I also added some comments
in new function bpf_local_storage_unlink_nolock() to make
codes easy to understand. There is no functionality change.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/r/20221026042845.672944-1-yhs@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: af253aef183a ("bpf: fix order of args in call to bpf_map_kvcalloc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf_local_storage.h |  17 ++-
 kernel/bpf/bpf_inode_storage.c    |  38 +-----
 kernel/bpf/bpf_local_storage.c    | 190 +++++++++++++++++++-----------
 kernel/bpf/bpf_task_storage.c     |  38 +-----
 net/core/bpf_sk_storage.c         |  35 +-----
 5 files changed, 137 insertions(+), 181 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 7ea18d4da84b8..6d37a40cd90e8 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -116,21 +116,22 @@ static struct bpf_local_storage_cache name = {			\
 	.idx_lock = __SPIN_LOCK_UNLOCKED(name.idx_lock),	\
 }
 
-u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache);
-void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cache,
-				      u16 idx);
-
 /* Helper functions for bpf_local_storage */
 int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
 
-struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr);
+struct bpf_map *
+bpf_local_storage_map_alloc(union bpf_attr *attr,
+			    struct bpf_local_storage_cache *cache);
 
 struct bpf_local_storage_data *
 bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 			 struct bpf_local_storage_map *smap,
 			 bool cacheit_lockit);
 
-void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
+bool bpf_local_storage_unlink_nolock(struct bpf_local_storage *local_storage);
+
+void bpf_local_storage_map_free(struct bpf_map *map,
+				struct bpf_local_storage_cache *cache,
 				int __percpu *busy_counter);
 
 int bpf_local_storage_map_check_btf(const struct bpf_map *map,
@@ -141,10 +142,6 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem);
 
-bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
-				     struct bpf_local_storage_elem *selem,
-				     bool uncharge_omem, bool use_trace_rcu);
-
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool use_trace_rcu);
 
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 5f7683b191998..6a1d4d22816a3 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -56,11 +56,9 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
 
 void bpf_inode_storage_free(struct inode *inode)
 {
-	struct bpf_local_storage_elem *selem;
 	struct bpf_local_storage *local_storage;
 	bool free_inode_storage = false;
 	struct bpf_storage_blob *bsb;
-	struct hlist_node *n;
 
 	bsb = bpf_inode(inode);
 	if (!bsb)
@@ -74,30 +72,11 @@ void bpf_inode_storage_free(struct inode *inode)
 		return;
 	}
 
-	/* Neither the bpf_prog nor the bpf-map's syscall
-	 * could be modifying the local_storage->list now.
-	 * Thus, no elem can be added-to or deleted-from the
-	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
-	 *
-	 * It is racing with bpf_local_storage_map_free() alone
-	 * when unlinking elem from the local_storage->list and
-	 * the map's bucket->list.
-	 */
 	raw_spin_lock_bh(&local_storage->lock);
-	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
-		/* Always unlink from map before unlinking from
-		 * local_storage.
-		 */
-		bpf_selem_unlink_map(selem);
-		free_inode_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, false, false);
-	}
+	free_inode_storage = bpf_local_storage_unlink_nolock(local_storage);
 	raw_spin_unlock_bh(&local_storage->lock);
 	rcu_read_unlock();
 
-	/* free_inoode_storage should always be true as long as
-	 * local_storage->list was non-empty.
-	 */
 	if (free_inode_storage)
 		kfree_rcu(local_storage, rcu);
 }
@@ -226,23 +205,12 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 
 static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap = bpf_local_storage_map_alloc(attr);
-	if (IS_ERR(smap))
-		return ERR_CAST(smap);
-
-	smap->cache_idx = bpf_local_storage_cache_idx_get(&inode_cache);
-	return &smap->map;
+	return bpf_local_storage_map_alloc(attr, &inode_cache);
 }
 
 static void inode_storage_map_free(struct bpf_map *map)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap = (struct bpf_local_storage_map *)map;
-	bpf_local_storage_cache_idx_free(&inode_cache, smap->cache_idx);
-	bpf_local_storage_map_free(smap, NULL);
+	bpf_local_storage_map_free(map, &inode_cache, NULL);
 }
 
 BTF_ID_LIST_SINGLE(inode_storage_map_btf_ids, struct,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index d9d88a2cda5e5..b1090a2b02b34 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -114,9 +114,9 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
  * The caller must ensure selem->smap is still valid to be
  * dereferenced for its smap->elem_size and smap->cache_idx.
  */
-bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
-				     struct bpf_local_storage_elem *selem,
-				     bool uncharge_mem, bool use_trace_rcu)
+static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
+					    struct bpf_local_storage_elem *selem,
+					    bool uncharge_mem, bool use_trace_rcu)
 {
 	struct bpf_local_storage_map *smap;
 	bool free_local_storage;
@@ -501,7 +501,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	return ERR_PTR(err);
 }
 
-u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache)
+static u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache)
 {
 	u64 min_usage = U64_MAX;
 	u16 i, res = 0;
@@ -525,76 +525,14 @@ u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache)
 	return res;
 }
 
-void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cache,
-				      u16 idx)
+static void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cache,
+					     u16 idx)
 {
 	spin_lock(&cache->idx_lock);
 	cache->idx_usage_counts[idx]--;
 	spin_unlock(&cache->idx_lock);
 }
 
-void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
-				int __percpu *busy_counter)
-{
-	struct bpf_local_storage_elem *selem;
-	struct bpf_local_storage_map_bucket *b;
-	unsigned int i;
-
-	/* Note that this map might be concurrently cloned from
-	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
-	 * RCU read section to finish before proceeding. New RCU
-	 * read sections should be prevented via bpf_map_inc_not_zero.
-	 */
-	synchronize_rcu();
-
-	/* bpf prog and the userspace can no longer access this map
-	 * now.  No new selem (of this map) can be added
-	 * to the owner->storage or to the map bucket's list.
-	 *
-	 * The elem of this map can be cleaned up here
-	 * or when the storage is freed e.g.
-	 * by bpf_sk_storage_free() during __sk_destruct().
-	 */
-	for (i = 0; i < (1U << smap->bucket_log); i++) {
-		b = &smap->buckets[i];
-
-		rcu_read_lock();
-		/* No one is adding to b->list now */
-		while ((selem = hlist_entry_safe(
-				rcu_dereference_raw(hlist_first_rcu(&b->list)),
-				struct bpf_local_storage_elem, map_node))) {
-			if (busy_counter) {
-				migrate_disable();
-				this_cpu_inc(*busy_counter);
-			}
-			bpf_selem_unlink(selem, false);
-			if (busy_counter) {
-				this_cpu_dec(*busy_counter);
-				migrate_enable();
-			}
-			cond_resched_rcu();
-		}
-		rcu_read_unlock();
-	}
-
-	/* While freeing the storage we may still need to access the map.
-	 *
-	 * e.g. when bpf_sk_storage_free() has unlinked selem from the map
-	 * which then made the above while((selem = ...)) loop
-	 * exit immediately.
-	 *
-	 * However, while freeing the storage one still needs to access the
-	 * smap->elem_size to do the uncharging in
-	 * bpf_selem_unlink_storage_nolock().
-	 *
-	 * Hence, wait another rcu grace period for the storage to be freed.
-	 */
-	synchronize_rcu();
-
-	kvfree(smap->buckets);
-	bpf_map_area_free(smap);
-}
-
 int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->map_flags & ~BPF_LOCAL_STORAGE_CREATE_FLAG_MASK ||
@@ -614,7 +552,7 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 	return 0;
 }
 
-struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
+static struct bpf_local_storage_map *__bpf_local_storage_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
 	unsigned int i;
@@ -664,3 +602,117 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 
 	return 0;
 }
+
+bool bpf_local_storage_unlink_nolock(struct bpf_local_storage *local_storage)
+{
+	struct bpf_local_storage_elem *selem;
+	bool free_storage = false;
+	struct hlist_node *n;
+
+	/* Neither the bpf_prog nor the bpf_map's syscall
+	 * could be modifying the local_storage->list now.
+	 * Thus, no elem can be added to or deleted from the
+	 * local_storage->list by the bpf_prog or by the bpf_map's syscall.
+	 *
+	 * It is racing with bpf_local_storage_map_free() alone
+	 * when unlinking elem from the local_storage->list and
+	 * the map's bucket->list.
+	 */
+	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
+		/* Always unlink from map before unlinking from
+		 * local_storage.
+		 */
+		bpf_selem_unlink_map(selem);
+		/* If local_storage list has only one element, the
+		 * bpf_selem_unlink_storage_nolock() will return true.
+		 * Otherwise, it will return false. The current loop iteration
+		 * intends to remove all local storage. So the last iteration
+		 * of the loop will set the free_cgroup_storage to true.
+		 */
+		free_storage = bpf_selem_unlink_storage_nolock(
+			local_storage, selem, false, false);
+	}
+
+	return free_storage;
+}
+
+struct bpf_map *
+bpf_local_storage_map_alloc(union bpf_attr *attr,
+			    struct bpf_local_storage_cache *cache)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = __bpf_local_storage_map_alloc(attr);
+	if (IS_ERR(smap))
+		return ERR_CAST(smap);
+
+	smap->cache_idx = bpf_local_storage_cache_idx_get(cache);
+	return &smap->map;
+}
+
+void bpf_local_storage_map_free(struct bpf_map *map,
+				struct bpf_local_storage_cache *cache,
+				int __percpu *busy_counter)
+{
+	struct bpf_local_storage_map_bucket *b;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map *smap;
+	unsigned int i;
+
+	smap = (struct bpf_local_storage_map *)map;
+	bpf_local_storage_cache_idx_free(cache, smap->cache_idx);
+
+	/* Note that this map might be concurrently cloned from
+	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
+	 * RCU read section to finish before proceeding. New RCU
+	 * read sections should be prevented via bpf_map_inc_not_zero.
+	 */
+	synchronize_rcu();
+
+	/* bpf prog and the userspace can no longer access this map
+	 * now.  No new selem (of this map) can be added
+	 * to the owner->storage or to the map bucket's list.
+	 *
+	 * The elem of this map can be cleaned up here
+	 * or when the storage is freed e.g.
+	 * by bpf_sk_storage_free() during __sk_destruct().
+	 */
+	for (i = 0; i < (1U << smap->bucket_log); i++) {
+		b = &smap->buckets[i];
+
+		rcu_read_lock();
+		/* No one is adding to b->list now */
+		while ((selem = hlist_entry_safe(
+				rcu_dereference_raw(hlist_first_rcu(&b->list)),
+				struct bpf_local_storage_elem, map_node))) {
+			if (busy_counter) {
+				migrate_disable();
+				this_cpu_inc(*busy_counter);
+			}
+			bpf_selem_unlink(selem, false);
+			if (busy_counter) {
+				this_cpu_dec(*busy_counter);
+				migrate_enable();
+			}
+			cond_resched_rcu();
+		}
+		rcu_read_unlock();
+	}
+
+	/* While freeing the storage we may still need to access the map.
+	 *
+	 * e.g. when bpf_sk_storage_free() has unlinked selem from the map
+	 * which then made the above while((selem = ...)) loop
+	 * exit immediately.
+	 *
+	 * However, while freeing the storage one still needs to access the
+	 * smap->elem_size to do the uncharging in
+	 * bpf_selem_unlink_storage_nolock().
+	 *
+	 * Hence, wait another rcu grace period for the storage to be freed.
+	 */
+	synchronize_rcu();
+
+	kvfree(smap->buckets);
+	bpf_map_area_free(smap);
+}
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 6f290623347e0..40a92edd6f539 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -71,10 +71,8 @@ task_storage_lookup(struct task_struct *task, struct bpf_map *map,
 
 void bpf_task_storage_free(struct task_struct *task)
 {
-	struct bpf_local_storage_elem *selem;
 	struct bpf_local_storage *local_storage;
 	bool free_task_storage = false;
-	struct hlist_node *n;
 	unsigned long flags;
 
 	rcu_read_lock();
@@ -85,32 +83,13 @@ void bpf_task_storage_free(struct task_struct *task)
 		return;
 	}
 
-	/* Neither the bpf_prog nor the bpf-map's syscall
-	 * could be modifying the local_storage->list now.
-	 * Thus, no elem can be added-to or deleted-from the
-	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
-	 *
-	 * It is racing with bpf_local_storage_map_free() alone
-	 * when unlinking elem from the local_storage->list and
-	 * the map's bucket->list.
-	 */
 	bpf_task_storage_lock();
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
-	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
-		/* Always unlink from map before unlinking from
-		 * local_storage.
-		 */
-		bpf_selem_unlink_map(selem);
-		free_task_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, false, false);
-	}
+	free_task_storage = bpf_local_storage_unlink_nolock(local_storage);
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 	bpf_task_storage_unlock();
 	rcu_read_unlock();
 
-	/* free_task_storage should always be true as long as
-	 * local_storage->list was non-empty.
-	 */
 	if (free_task_storage)
 		kfree_rcu(local_storage, rcu);
 }
@@ -288,23 +267,12 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap = bpf_local_storage_map_alloc(attr);
-	if (IS_ERR(smap))
-		return ERR_CAST(smap);
-
-	smap->cache_idx = bpf_local_storage_cache_idx_get(&task_cache);
-	return &smap->map;
+	return bpf_local_storage_map_alloc(attr, &task_cache);
 }
 
 static void task_storage_map_free(struct bpf_map *map)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap = (struct bpf_local_storage_map *)map;
-	bpf_local_storage_cache_idx_free(&task_cache, smap->cache_idx);
-	bpf_local_storage_map_free(smap, &bpf_task_storage_busy);
+	bpf_local_storage_map_free(map, &task_cache, &bpf_task_storage_busy);
 }
 
 BTF_ID_LIST_SINGLE(task_storage_map_btf_ids, struct, bpf_local_storage_map)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index ad01b1bea52e4..0124536e8a9db 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -48,10 +48,8 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
 void bpf_sk_storage_free(struct sock *sk)
 {
-	struct bpf_local_storage_elem *selem;
 	struct bpf_local_storage *sk_storage;
 	bool free_sk_storage = false;
-	struct hlist_node *n;
 
 	rcu_read_lock();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
@@ -60,24 +58,8 @@ void bpf_sk_storage_free(struct sock *sk)
 		return;
 	}
 
-	/* Netiher the bpf_prog nor the bpf-map's syscall
-	 * could be modifying the sk_storage->list now.
-	 * Thus, no elem can be added-to or deleted-from the
-	 * sk_storage->list by the bpf_prog or by the bpf-map's syscall.
-	 *
-	 * It is racing with bpf_local_storage_map_free() alone
-	 * when unlinking elem from the sk_storage->list and
-	 * the map's bucket->list.
-	 */
 	raw_spin_lock_bh(&sk_storage->lock);
-	hlist_for_each_entry_safe(selem, n, &sk_storage->list, snode) {
-		/* Always unlink from map before unlinking from
-		 * sk_storage.
-		 */
-		bpf_selem_unlink_map(selem);
-		free_sk_storage = bpf_selem_unlink_storage_nolock(
-			sk_storage, selem, true, false);
-	}
+	free_sk_storage = bpf_local_storage_unlink_nolock(sk_storage);
 	raw_spin_unlock_bh(&sk_storage->lock);
 	rcu_read_unlock();
 
@@ -87,23 +69,12 @@ void bpf_sk_storage_free(struct sock *sk)
 
 static void bpf_sk_storage_map_free(struct bpf_map *map)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap = (struct bpf_local_storage_map *)map;
-	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx);
-	bpf_local_storage_map_free(smap, NULL);
+	bpf_local_storage_map_free(map, &sk_cache, NULL);
 }
 
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap = bpf_local_storage_map_alloc(attr);
-	if (IS_ERR(smap))
-		return ERR_CAST(smap);
-
-	smap->cache_idx = bpf_local_storage_cache_idx_get(&sk_cache);
-	return &smap->map;
+	return bpf_local_storage_map_alloc(attr, &sk_cache);
 }
 
 static int notsupp_get_next_key(struct bpf_map *map, void *key,
-- 
2.43.0




