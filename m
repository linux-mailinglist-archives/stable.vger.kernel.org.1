Return-Path: <stable+bounces-53589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3BB90D281
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002551F24C9A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF701AD3EC;
	Tue, 18 Jun 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VSyOAwFK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CADB13D528;
	Tue, 18 Jun 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716777; cv=none; b=IbhDYHRT6RC6sogVUrnuKHs/A+xisxVu2QjmYSUSHeygkhDYfuZWfkwid+ZBJh+/+17VeiHoxBrbCNTB3cEt5iyt6ohZAKsaf0g5sziJzobWFn2+2L65zNhdqSgcgdsx/sKE0IKKIKPCBlex1h5FLtC1eOLr2zALp87d7ezyfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716777; c=relaxed/simple;
	bh=kO1zg9/XUBgByYyluAjwk6PKu8yHpflYPtraTNPo0dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuiCpOaUYJmN2Ls2hZl5KXR6a9UwPMnvpI3AqlVyHOaPRJTBqFsMAJp7DMA/GQB60lT9KV2EScvggwp48VPAyQrqG1R6jst7AIlW74FCfTl4iSuVEm/d5yAFEDAdKiSOf9HWl8x3bevO8109V/Uh/eWpkIYkPikj7+hX/YZgrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VSyOAwFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F61C3277B;
	Tue, 18 Jun 2024 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716777;
	bh=kO1zg9/XUBgByYyluAjwk6PKu8yHpflYPtraTNPo0dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VSyOAwFKJ0K0+BoI+XHqK+Ke0MBMAgncwxFc9fcMt/lqmBksIZpMtjPf1gT/o6akZ
	 ZDLeIYX11r6VigMYGGkRzNKnILsb1jQqvq0EAuEGMel+Iva0NOU5oKKk6CBfSwP0Wd
	 pjOLvTI/UVzL57xb1azT+GnvE4xGRcqqSAEHOntw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neil Brown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 752/770] NFSD: Convert filecache to rhltable
Date: Tue, 18 Jun 2024 14:40:05 +0200
Message-ID: <20240618123436.297014091@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit c4c649ab413ba6a785b25f0edbb12f617c87db2a ]

While we were converting the nfs4_file hashtable to use the kernel's
resizable hashtable data structure, Neil Brown observed that the
list variant (rhltable) would be better for managing nfsd_file items
as well. The nfsd_file hash table will contain multiple entries for
the same inode -- these should be kept together on a list. And, it
could be possible for exotic or malicious client behavior to cause
the hash table to resize itself on every insertion.

A nice simplification is that rhltable_lookup() can return a list
that contains only nfsd_file items that match a given inode, which
enables us to eliminate specialized hash table helper functions and
use the default functions provided by the rhashtable implementation).

Since we are now storing nfsd_file items for the same inode on a
single list, that effectively reduces the number of hash entries
that have to be tracked in the hash table. The mininum bucket count
is therefore lowered.

Light testing with fstests generic/531 show no regressions.

Suggested-by: Neil Brown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 311 ++++++++++++++++++--------------------------
 fs/nfsd/filecache.h |   9 +-
 2 files changed, 133 insertions(+), 187 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 080d796547854..52e67ec267965 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -73,70 +73,9 @@ static struct list_lru			nfsd_file_lru;
 static unsigned long			nfsd_file_flags;
 static struct fsnotify_group		*nfsd_file_fsnotify_group;
 static struct delayed_work		nfsd_filecache_laundrette;
-static struct rhashtable		nfsd_file_rhash_tbl
+static struct rhltable			nfsd_file_rhltable
 						____cacheline_aligned_in_smp;
 
-enum nfsd_file_lookup_type {
-	NFSD_FILE_KEY_INODE,
-	NFSD_FILE_KEY_FULL,
-};
-
-struct nfsd_file_lookup_key {
-	struct inode			*inode;
-	struct net			*net;
-	const struct cred		*cred;
-	unsigned char			need;
-	bool				gc;
-	enum nfsd_file_lookup_type	type;
-};
-
-/*
- * The returned hash value is based solely on the address of an in-code
- * inode, a pointer to a slab-allocated object. The entropy in such a
- * pointer is concentrated in its middle bits.
- */
-static u32 nfsd_file_inode_hash(const struct inode *inode, u32 seed)
-{
-	unsigned long ptr = (unsigned long)inode;
-	u32 k;
-
-	k = ptr >> L1_CACHE_SHIFT;
-	k &= 0x00ffffff;
-	return jhash2(&k, 1, seed);
-}
-
-/**
- * nfsd_file_key_hashfn - Compute the hash value of a lookup key
- * @data: key on which to compute the hash value
- * @len: rhash table's key_len parameter (unused)
- * @seed: rhash table's random seed of the day
- *
- * Return value:
- *   Computed 32-bit hash value
- */
-static u32 nfsd_file_key_hashfn(const void *data, u32 len, u32 seed)
-{
-	const struct nfsd_file_lookup_key *key = data;
-
-	return nfsd_file_inode_hash(key->inode, seed);
-}
-
-/**
- * nfsd_file_obj_hashfn - Compute the hash value of an nfsd_file
- * @data: object on which to compute the hash value
- * @len: rhash table's key_len parameter (unused)
- * @seed: rhash table's random seed of the day
- *
- * Return value:
- *   Computed 32-bit hash value
- */
-static u32 nfsd_file_obj_hashfn(const void *data, u32 len, u32 seed)
-{
-	const struct nfsd_file *nf = data;
-
-	return nfsd_file_inode_hash(nf->nf_inode, seed);
-}
-
 static bool
 nfsd_match_cred(const struct cred *c1, const struct cred *c2)
 {
@@ -157,55 +96,16 @@ nfsd_match_cred(const struct cred *c1, const struct cred *c2)
 	return true;
 }
 
-/**
- * nfsd_file_obj_cmpfn - Match a cache item against search criteria
- * @arg: search criteria
- * @ptr: cache item to check
- *
- * Return values:
- *   %0 - Item matches search criteria
- *   %1 - Item does not match search criteria
- */
-static int nfsd_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
-			       const void *ptr)
-{
-	const struct nfsd_file_lookup_key *key = arg->key;
-	const struct nfsd_file *nf = ptr;
-
-	switch (key->type) {
-	case NFSD_FILE_KEY_INODE:
-		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
-			return 1;
-		if (nf->nf_inode != key->inode)
-			return 1;
-		break;
-	case NFSD_FILE_KEY_FULL:
-		if (nf->nf_inode != key->inode)
-			return 1;
-		if (nf->nf_may != key->need)
-			return 1;
-		if (nf->nf_net != key->net)
-			return 1;
-		if (!nfsd_match_cred(nf->nf_cred, key->cred))
-			return 1;
-		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
-			return 1;
-		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0)
-			return 1;
-		break;
-	}
-	return 0;
-}
-
 static const struct rhashtable_params nfsd_file_rhash_params = {
 	.key_len		= sizeof_field(struct nfsd_file, nf_inode),
 	.key_offset		= offsetof(struct nfsd_file, nf_inode),
-	.head_offset		= offsetof(struct nfsd_file, nf_rhash),
-	.hashfn			= nfsd_file_key_hashfn,
-	.obj_hashfn		= nfsd_file_obj_hashfn,
-	.obj_cmpfn		= nfsd_file_obj_cmpfn,
-	/* Reduce resizing churn on light workloads */
-	.min_size		= 512,		/* buckets */
+	.head_offset		= offsetof(struct nfsd_file, nf_rlist),
+
+	/*
+	 * Start with a single page hash table to reduce resizing churn
+	 * on light workloads.
+	 */
+	.min_size		= 256,
 	.automatic_shrinking	= true,
 };
 
@@ -308,27 +208,27 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf, struct inode *inode)
 }
 
 static struct nfsd_file *
-nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
+nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
+		bool want_gc)
 {
 	struct nfsd_file *nf;
 
 	nf = kmem_cache_alloc(nfsd_file_slab, GFP_KERNEL);
-	if (nf) {
-		INIT_LIST_HEAD(&nf->nf_lru);
-		nf->nf_birthtime = ktime_get();
-		nf->nf_file = NULL;
-		nf->nf_cred = get_current_cred();
-		nf->nf_net = key->net;
-		nf->nf_flags = 0;
-		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
-		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
-		if (key->gc)
-			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
-		nf->nf_inode = key->inode;
-		refcount_set(&nf->nf_ref, 1);
-		nf->nf_may = key->need;
-		nf->nf_mark = NULL;
-	}
+	if (unlikely(!nf))
+		return NULL;
+
+	INIT_LIST_HEAD(&nf->nf_lru);
+	nf->nf_birthtime = ktime_get();
+	nf->nf_file = NULL;
+	nf->nf_cred = get_current_cred();
+	nf->nf_net = net;
+	nf->nf_flags = want_gc ?
+		BIT(NFSD_FILE_HASHED) | BIT(NFSD_FILE_PENDING) | BIT(NFSD_FILE_GC) :
+		BIT(NFSD_FILE_HASHED) | BIT(NFSD_FILE_PENDING);
+	nf->nf_inode = inode;
+	refcount_set(&nf->nf_ref, 1);
+	nf->nf_may = need;
+	nf->nf_mark = NULL;
 	return nf;
 }
 
@@ -353,8 +253,8 @@ static void
 nfsd_file_hash_remove(struct nfsd_file *nf)
 {
 	trace_nfsd_file_unhash(nf);
-	rhashtable_remove_fast(&nfsd_file_rhash_tbl, &nf->nf_rhash,
-			       nfsd_file_rhash_params);
+	rhltable_remove(&nfsd_file_rhltable, &nf->nf_rlist,
+			nfsd_file_rhash_params);
 }
 
 static bool
@@ -687,8 +587,8 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct list_head *dispose)
  * @inode:   inode on which to close out nfsd_files
  * @dispose: list on which to gather nfsd_files to close out
  *
- * An nfsd_file represents a struct file being held open on behalf of nfsd. An
- * open file however can block other activity (such as leases), or cause
+ * An nfsd_file represents a struct file being held open on behalf of nfsd.
+ * An open file however can block other activity (such as leases), or cause
  * undesirable behavior (e.g. spurious silly-renames when reexporting NFS).
  *
  * This function is intended to find open nfsd_files when this sort of
@@ -701,21 +601,17 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct list_head *dispose)
 static void
 nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose)
 {
-	struct nfsd_file_lookup_key key = {
-		.type	= NFSD_FILE_KEY_INODE,
-		.inode	= inode,
-		.gc	= true,
-	};
+	struct rhlist_head *tmp, *list;
 	struct nfsd_file *nf;
 
 	rcu_read_lock();
-	do {
-		nf = rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
-				       nfsd_file_rhash_params);
-		if (!nf)
-			break;
+	list = rhltable_lookup(&nfsd_file_rhltable, &inode,
+			       nfsd_file_rhash_params);
+	rhl_for_each_entry_rcu(nf, tmp, list, nf_rlist) {
+		if (!test_bit(NFSD_FILE_GC, &nf->nf_flags))
+			continue;
 		nfsd_file_cond_queue(nf, dispose);
-	} while (1);
+	}
 	rcu_read_unlock();
 }
 
@@ -839,7 +735,7 @@ nfsd_file_cache_init(void)
 	if (test_and_set_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1)
 		return 0;
 
-	ret = rhashtable_init(&nfsd_file_rhash_tbl, &nfsd_file_rhash_params);
+	ret = rhltable_init(&nfsd_file_rhltable, &nfsd_file_rhash_params);
 	if (ret)
 		return ret;
 
@@ -907,7 +803,7 @@ nfsd_file_cache_init(void)
 	nfsd_file_mark_slab = NULL;
 	destroy_workqueue(nfsd_filecache_wq);
 	nfsd_filecache_wq = NULL;
-	rhashtable_destroy(&nfsd_file_rhash_tbl);
+	rhltable_destroy(&nfsd_file_rhltable);
 	goto out;
 }
 
@@ -926,7 +822,7 @@ __nfsd_file_cache_purge(struct net *net)
 	struct nfsd_file *nf;
 	LIST_HEAD(dispose);
 
-	rhashtable_walk_enter(&nfsd_file_rhash_tbl, &iter);
+	rhltable_walk_enter(&nfsd_file_rhltable, &iter);
 	do {
 		rhashtable_walk_start(&iter);
 
@@ -1032,7 +928,7 @@ nfsd_file_cache_shutdown(void)
 	nfsd_file_mark_slab = NULL;
 	destroy_workqueue(nfsd_filecache_wq);
 	nfsd_filecache_wq = NULL;
-	rhashtable_destroy(&nfsd_file_rhash_tbl);
+	rhltable_destroy(&nfsd_file_rhltable);
 
 	for_each_possible_cpu(i) {
 		per_cpu(nfsd_file_cache_hits, i) = 0;
@@ -1043,6 +939,35 @@ nfsd_file_cache_shutdown(void)
 	}
 }
 
+static struct nfsd_file *
+nfsd_file_lookup_locked(const struct net *net, const struct cred *cred,
+			struct inode *inode, unsigned char need,
+			bool want_gc)
+{
+	struct rhlist_head *tmp, *list;
+	struct nfsd_file *nf;
+
+	list = rhltable_lookup(&nfsd_file_rhltable, &inode,
+			       nfsd_file_rhash_params);
+	rhl_for_each_entry_rcu(nf, tmp, list, nf_rlist) {
+		if (nf->nf_may != need)
+			continue;
+		if (nf->nf_net != net)
+			continue;
+		if (!nfsd_match_cred(nf->nf_cred, cred))
+			continue;
+		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) != want_gc)
+			continue;
+		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0)
+			continue;
+
+		if (!nfsd_file_get(nf))
+			continue;
+		return nf;
+	}
+	return NULL;
+}
+
 /**
  * nfsd_file_is_cached - are there any cached open files for this inode?
  * @inode: inode to check
@@ -1057,16 +982,20 @@ nfsd_file_cache_shutdown(void)
 bool
 nfsd_file_is_cached(struct inode *inode)
 {
-	struct nfsd_file_lookup_key key = {
-		.type	= NFSD_FILE_KEY_INODE,
-		.inode	= inode,
-		.gc	= true,
-	};
+	struct rhlist_head *tmp, *list;
+	struct nfsd_file *nf;
 	bool ret = false;
 
-	if (rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
-				   nfsd_file_rhash_params) != NULL)
-		ret = true;
+	rcu_read_lock();
+	list = rhltable_lookup(&nfsd_file_rhltable, &inode,
+			       nfsd_file_rhash_params);
+	rhl_for_each_entry_rcu(nf, tmp, list, nf_rlist)
+		if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
+			ret = true;
+			break;
+		}
+	rcu_read_unlock();
+
 	trace_nfsd_file_is_cached(inode, (int)ret);
 	return ret;
 }
@@ -1076,14 +1005,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int may_flags, struct file *file,
 		     struct nfsd_file **pnf, bool want_gc)
 {
-	struct nfsd_file_lookup_key key = {
-		.type	= NFSD_FILE_KEY_FULL,
-		.need	= may_flags & NFSD_FILE_MAY_MASK,
-		.net	= SVC_NET(rqstp),
-		.gc	= want_gc,
-	};
+	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
+	struct net *net = SVC_NET(rqstp);
+	struct nfsd_file *new, *nf;
+	const struct cred *cred;
 	bool open_retry = true;
-	struct nfsd_file *nf;
+	struct inode *inode;
 	__be32 status;
 	int ret;
 
@@ -1091,14 +1018,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
 	if (status != nfs_ok)
 		return status;
-	key.inode = d_inode(fhp->fh_dentry);
-	key.cred = get_current_cred();
+	inode = d_inode(fhp->fh_dentry);
+	cred = get_current_cred();
 
 retry:
 	rcu_read_lock();
-	nf = rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
-			       nfsd_file_rhash_params);
-	nf = nfsd_file_get(nf);
+	nf = nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
 	rcu_read_unlock();
 
 	if (nf) {
@@ -1112,21 +1037,32 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto wait_for_construction;
 	}
 
-	nf = nfsd_file_alloc(&key, may_flags);
-	if (!nf) {
+	new = nfsd_file_alloc(net, inode, need, want_gc);
+	if (!new) {
 		status = nfserr_jukebox;
 		goto out;
 	}
 
-	ret = rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
-					   &key, &nf->nf_rhash,
-					   nfsd_file_rhash_params);
+	rcu_read_lock();
+	spin_lock(&inode->i_lock);
+	nf = nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
+	if (unlikely(nf)) {
+		spin_unlock(&inode->i_lock);
+		rcu_read_unlock();
+		nfsd_file_slab_free(&new->nf_rcu);
+		goto wait_for_construction;
+	}
+	nf = new;
+	ret = rhltable_insert(&nfsd_file_rhltable, &nf->nf_rlist,
+			      nfsd_file_rhash_params);
+	spin_unlock(&inode->i_lock);
+	rcu_read_unlock();
 	if (likely(ret == 0))
 		goto open_file;
 
 	if (ret == -EEXIST)
 		goto retry;
-	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
+	trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
 	status = nfserr_jukebox;
 	goto construction_err;
 
@@ -1135,7 +1071,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	/* Did construction of this file fail? */
 	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-		trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
+		trace_nfsd_file_cons_err(rqstp, inode, may_flags, nf);
 		if (!open_retry) {
 			status = nfserr_jukebox;
 			goto construction_err;
@@ -1157,13 +1093,13 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		nfsd_file_check_write_error(nf);
 		*pnf = nf;
 	}
-	put_cred(key.cred);
-	trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
+	put_cred(cred);
+	trace_nfsd_file_acquire(rqstp, inode, may_flags, nf, status);
 	return status;
 
 open_file:
 	trace_nfsd_file_alloc(nf);
-	nf->nf_mark = nfsd_file_mark_find_or_create(nf, key.inode);
+	nf->nf_mark = nfsd_file_mark_find_or_create(nf, inode);
 	if (nf->nf_mark) {
 		if (file) {
 			get_file(file);
@@ -1181,7 +1117,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * If construction failed, or we raced with a call to unlink()
 	 * then unhash.
 	 */
-	if (status == nfs_ok && key.inode->i_nlink == 0)
+	if (status != nfs_ok || inode->i_nlink == 0)
 		status = nfserr_jukebox;
 	if (status != nfs_ok)
 		nfsd_file_unhash(nf);
@@ -1208,8 +1144,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * seconds after the final nfsd_file_put() in case the caller
  * wants to re-use it.
  *
- * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
- * network byte order is returned.
+ * Return values:
+ *   %nfs_ok - @pnf points to an nfsd_file with its reference
+ *   count boosted.
+ *
+ * On error, an nfsstat value in network byte order is returned.
  */
 __be32
 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
@@ -1229,8 +1168,11 @@ nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * but not garbage-collected. The object is unhashed after the
  * final nfsd_file_put().
  *
- * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
- * network byte order is returned.
+ * Return values:
+ *   %nfs_ok - @pnf points to an nfsd_file with its reference
+ *   count boosted.
+ *
+ * On error, an nfsstat value in network byte order is returned.
  */
 __be32
 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
@@ -1251,8 +1193,11 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * and @file is non-NULL, use it to instantiate a new nfsd_file instead of
  * opening a new one.
  *
- * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
- * network byte order is returned.
+ * Return values:
+ *   %nfs_ok - @pnf points to an nfsd_file with its reference
+ *   count boosted.
+ *
+ * On error, an nfsstat value in network byte order is returned.
  */
 __be32
 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
@@ -1283,7 +1228,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 		lru = list_lru_count(&nfsd_file_lru);
 
 		rcu_read_lock();
-		ht = &nfsd_file_rhash_tbl;
+		ht = &nfsd_file_rhltable.ht;
 		count = atomic_read(&ht->nelems);
 		tbl = rht_dereference_rcu(ht->tbl, ht);
 		buckets = tbl->size;
@@ -1299,7 +1244,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 		evictions += per_cpu(nfsd_file_evictions, i);
 	}
 
-	seq_printf(m, "total entries: %u\n", count);
+	seq_printf(m, "total inodes:  %u\n", count);
 	seq_printf(m, "hash buckets:  %u\n", buckets);
 	seq_printf(m, "lru entries:   %lu\n", lru);
 	seq_printf(m, "cache hits:    %lu\n", hits);
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 41516a4263ea5..e54165a3224f0 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -29,9 +29,8 @@ struct nfsd_file_mark {
  * never be dereferenced, only used for comparison.
  */
 struct nfsd_file {
-	struct rhash_head	nf_rhash;
-	struct list_head	nf_lru;
-	struct rcu_head		nf_rcu;
+	struct rhlist_head	nf_rlist;
+	void			*nf_inode;
 	struct file		*nf_file;
 	const struct cred	*nf_cred;
 	struct net		*nf_net;
@@ -40,10 +39,12 @@ struct nfsd_file {
 #define NFSD_FILE_REFERENCED	(2)
 #define NFSD_FILE_GC		(3)
 	unsigned long		nf_flags;
-	struct inode		*nf_inode;	/* don't deref */
 	refcount_t		nf_ref;
 	unsigned char		nf_may;
+
 	struct nfsd_file_mark	*nf_mark;
+	struct list_head	nf_lru;
+	struct rcu_head		nf_rcu;
 	ktime_t			nf_birthtime;
 };
 
-- 
2.43.0




