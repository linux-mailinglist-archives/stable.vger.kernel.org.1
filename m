Return-Path: <stable+bounces-37579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D3889C585
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB221F21125
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FB97D413;
	Mon,  8 Apr 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZOldciSi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E47D408;
	Mon,  8 Apr 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584647; cv=none; b=Xvmtdy5TYeTw5zMGgzsU9xnhFR2oneikJVmgKT4fUgIS5Ak818EL8KgJDHItPe6QUZgQ4SVSSRL1BbjuIMwMEqzYp9MFl+fwFoBlp6HD7rW8ytSKMXWeBEB1ZuYFO41a2BgqDM6fe63M1ogLAPcrj3r3fx+8/uMa57VCwvvTIoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584647; c=relaxed/simple;
	bh=kYmN3fSbiH66HoMP+77goGv3W4Yafmy9zrUex51tDhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhJZjpnSoJZUJH/175fwNwnh1P0k3ZDgQ5tsZ4UJdobY6j8xkbtNcD+p5kREYD/93dtSvxgaKPxYx87p1Hj51DNsp5/Xa2tGaJLhciH9D6C6Z1WNOY8xivRXxLd3D4r8f47Rr4e1ZPqX3w5eB0rgiJ8p+K/WHbOIljoG3up7fKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZOldciSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2951C433F1;
	Mon,  8 Apr 2024 13:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584647;
	bh=kYmN3fSbiH66HoMP+77goGv3W4Yafmy9zrUex51tDhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZOldciSiz1u+gjY9Aj/F10+G/IOUPhHh4yrny+v20vrtNIKqOwF3vhm/VCg09MMIB
	 RlZ8SSdN3bRF9svX8wCjsT2CmA8GJ2MdoToh0nlFxYv4tjBe5R9lGJJ3dIPsxHdNyo
	 g5Diic29/+7I4wtAPYVBDHEW0KTjI7HMETA3cdhU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 509/690] nfsd: rework refcounting in filecache
Date: Mon,  8 Apr 2024 14:56:15 +0200
Message-ID: <20240408125418.093027686@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit ac3a2585f018f10039b4a856dcb122da88c1c1c9 ]

The filecache refcounting is a bit non-standard for something searchable
by RCU, in that we maintain a sentinel reference while it's hashed. This
in turn requires that we have to do things differently in the "put"
depending on whether its hashed, which we believe to have led to races.

There are other problems in here too. nfsd_file_close_inode_sync can end
up freeing an nfsd_file while there are still outstanding references to
it, and there are a number of subtle ToC/ToU races.

Rework the code so that the refcount is what drives the lifecycle. When
the refcount goes to zero, then unhash and rcu free the object. A task
searching for a nfsd_file is allowed to bump its refcount, but only if
it's not already 0. Ensure that we don't make any other changes to it
until a reference is held.

With this change, the LRU carries a reference. Take special care to deal
with it when removing an entry from the list, and ensure that we only
repurpose the nf_lru list_head when the refcount is 0 to ensure
exclusive access to it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 318 +++++++++++++++++++++++---------------------
 fs/nfsd/trace.h     |  51 +++----
 2 files changed, 189 insertions(+), 180 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 6b8873b0c2c38..140094a44cc40 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -323,8 +323,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
 		if (key->gc)
 			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
 		nf->nf_inode = key->inode;
-		/* nf_ref is pre-incremented for hash table */
-		refcount_set(&nf->nf_ref, 2);
+		refcount_set(&nf->nf_ref, 1);
 		nf->nf_may = key->need;
 		nf->nf_mark = NULL;
 	}
@@ -376,24 +375,35 @@ nfsd_file_unhash(struct nfsd_file *nf)
 	return false;
 }
 
-static bool
+static void
 nfsd_file_free(struct nfsd_file *nf)
 {
 	s64 age = ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
-	bool flush = false;
 
 	trace_nfsd_file_free(nf);
 
 	this_cpu_inc(nfsd_file_releases);
 	this_cpu_add(nfsd_file_total_age, age);
 
+	nfsd_file_unhash(nf);
+
+	/*
+	 * We call fsync here in order to catch writeback errors. It's not
+	 * strictly required by the protocol, but an nfsd_file could get
+	 * evicted from the cache before a COMMIT comes in. If another
+	 * task were to open that file in the interim and scrape the error,
+	 * then the client may never see it. By calling fsync here, we ensure
+	 * that writeback happens before the entry is freed, and that any
+	 * errors reported result in the write verifier changing.
+	 */
+	nfsd_file_fsync(nf);
+
 	if (nf->nf_mark)
 		nfsd_file_mark_put(nf->nf_mark);
 	if (nf->nf_file) {
 		get_file(nf->nf_file);
 		filp_close(nf->nf_file, NULL);
 		fput(nf->nf_file);
-		flush = true;
 	}
 
 	/*
@@ -401,10 +411,9 @@ nfsd_file_free(struct nfsd_file *nf)
 	 * WARN and leak it to preserve system stability.
 	 */
 	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
-		return flush;
+		return;
 
 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
-	return flush;
 }
 
 static bool
@@ -420,17 +429,23 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 }
 
-static void nfsd_file_lru_add(struct nfsd_file *nf)
+static bool nfsd_file_lru_add(struct nfsd_file *nf)
 {
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
+	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
 		trace_nfsd_file_lru_add(nf);
+		return true;
+	}
+	return false;
 }
 
-static void nfsd_file_lru_remove(struct nfsd_file *nf)
+static bool nfsd_file_lru_remove(struct nfsd_file *nf)
 {
-	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
+	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
 		trace_nfsd_file_lru_del(nf);
+		return true;
+	}
+	return false;
 }
 
 struct nfsd_file *
@@ -441,86 +456,60 @@ nfsd_file_get(struct nfsd_file *nf)
 	return NULL;
 }
 
-static void
-nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispose)
-{
-	trace_nfsd_file_unhash_and_queue(nf);
-	if (nfsd_file_unhash(nf)) {
-		/* caller must call nfsd_file_dispose_list() later */
-		nfsd_file_lru_remove(nf);
-		list_add(&nf->nf_lru, dispose);
-	}
-}
-
-static void
-nfsd_file_put_noref(struct nfsd_file *nf)
-{
-	trace_nfsd_file_put(nf);
-
-	if (refcount_dec_and_test(&nf->nf_ref)) {
-		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
-		nfsd_file_lru_remove(nf);
-		nfsd_file_free(nf);
-	}
-}
-
-static void
-nfsd_file_unhash_and_put(struct nfsd_file *nf)
-{
-	if (nfsd_file_unhash(nf))
-		nfsd_file_put_noref(nf);
-}
-
+/**
+ * nfsd_file_put - put the reference to a nfsd_file
+ * @nf: nfsd_file of which to put the reference
+ *
+ * Put a reference to a nfsd_file. In the non-GC case, we just put the
+ * reference immediately. In the GC case, if the reference would be
+ * the last one, the put it on the LRU instead to be cleaned up later.
+ */
 void
 nfsd_file_put(struct nfsd_file *nf)
 {
 	might_sleep();
+	trace_nfsd_file_put(nf);
 
-	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
-		nfsd_file_lru_add(nf);
-	else if (refcount_read(&nf->nf_ref) == 2)
-		nfsd_file_unhash_and_put(nf);
-
-	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-		nfsd_file_fsync(nf);
-		nfsd_file_put_noref(nf);
-	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
-		nfsd_file_put_noref(nf);
-		nfsd_file_schedule_laundrette();
-	} else
-		nfsd_file_put_noref(nf);
-}
-
-static void
-nfsd_file_dispose_list(struct list_head *dispose)
-{
-	struct nfsd_file *nf;
+	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
+	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
+		/*
+		 * If this is the last reference (nf_ref == 1), then try to
+		 * transfer it to the LRU.
+		 */
+		if (refcount_dec_not_one(&nf->nf_ref))
+			return;
+
+		/* Try to add it to the LRU.  If that fails, decrement. */
+		if (nfsd_file_lru_add(nf)) {
+			/* If it's still hashed, we're done */
+			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
+				nfsd_file_schedule_laundrette();
+				return;
+			}
 
-	while(!list_empty(dispose)) {
-		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
-		list_del_init(&nf->nf_lru);
-		nfsd_file_fsync(nf);
-		nfsd_file_put_noref(nf);
+			/*
+			 * We're racing with unhashing, so try to remove it from
+			 * the LRU. If removal fails, then someone else already
+			 * has our reference.
+			 */
+			if (!nfsd_file_lru_remove(nf))
+				return;
+		}
 	}
+	if (refcount_dec_and_test(&nf->nf_ref))
+		nfsd_file_free(nf);
 }
 
 static void
-nfsd_file_dispose_list_sync(struct list_head *dispose)
+nfsd_file_dispose_list(struct list_head *dispose)
 {
-	bool flush = false;
 	struct nfsd_file *nf;
 
-	while(!list_empty(dispose)) {
+	while (!list_empty(dispose)) {
 		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
 		list_del_init(&nf->nf_lru);
-		nfsd_file_fsync(nf);
-		if (!refcount_dec_and_test(&nf->nf_ref))
-			continue;
-		if (nfsd_file_free(nf))
-			flush = true;
+		nfsd_file_free(nf);
 	}
-	if (flush)
-		flush_delayed_fput();
 }
 
 static void
@@ -590,21 +579,8 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 	struct list_head *head = arg;
 	struct nfsd_file *nf = list_entry(item, struct nfsd_file, nf_lru);
 
-	/*
-	 * Do a lockless refcount check. The hashtable holds one reference, so
-	 * we look to see if anything else has a reference, or if any have
-	 * been put since the shrinker last ran. Those don't get unhashed and
-	 * released.
-	 *
-	 * Note that in the put path, we set the flag and then decrement the
-	 * counter. Here we check the counter and then test and clear the flag.
-	 * That order is deliberate to ensure that we can do this locklessly.
-	 */
-	if (refcount_read(&nf->nf_ref) > 1) {
-		list_lru_isolate(lru, &nf->nf_lru);
-		trace_nfsd_file_gc_in_use(nf);
-		return LRU_REMOVED;
-	}
+	/* We should only be dealing with GC entries here */
+	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
 
 	/*
 	 * Don't throw out files that are still undergoing I/O or
@@ -615,40 +591,30 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 		return LRU_SKIP;
 	}
 
+	/* If it was recently added to the list, skip it */
 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
 		trace_nfsd_file_gc_referenced(nf);
 		return LRU_ROTATE;
 	}
 
-	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-		trace_nfsd_file_gc_hashed(nf);
-		return LRU_SKIP;
+	/*
+	 * Put the reference held on behalf of the LRU. If it wasn't the last
+	 * one, then just remove it from the LRU and ignore it.
+	 */
+	if (!refcount_dec_and_test(&nf->nf_ref)) {
+		trace_nfsd_file_gc_in_use(nf);
+		list_lru_isolate(lru, &nf->nf_lru);
+		return LRU_REMOVED;
 	}
 
+	/* Refcount went to zero. Unhash it and queue it to the dispose list */
+	nfsd_file_unhash(nf);
 	list_lru_isolate_move(lru, &nf->nf_lru, head);
 	this_cpu_inc(nfsd_file_evictions);
 	trace_nfsd_file_gc_disposed(nf);
 	return LRU_REMOVED;
 }
 
-/*
- * Unhash items on @dispose immediately, then queue them on the
- * disposal workqueue to finish releasing them in the background.
- *
- * cel: Note that between the time list_lru_shrink_walk runs and
- * now, these items are in the hash table but marked unhashed.
- * Why release these outside of lru_cb ? There's no lock ordering
- * problem since lru_cb currently takes no lock.
- */
-static void nfsd_file_gc_dispose_list(struct list_head *dispose)
-{
-	struct nfsd_file *nf;
-
-	list_for_each_entry(nf, dispose, nf_lru)
-		nfsd_file_hash_remove(nf);
-	nfsd_file_dispose_list_delayed(dispose);
-}
-
 static void
 nfsd_file_gc(void)
 {
@@ -658,7 +624,7 @@ nfsd_file_gc(void)
 	ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
 			    &dispose, list_lru_count(&nfsd_file_lru));
 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_gc_dispose_list(&dispose);
+	nfsd_file_dispose_list_delayed(&dispose);
 }
 
 static void
@@ -684,7 +650,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 	ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
 				   nfsd_file_lru_cb, &dispose);
 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_gc_dispose_list(&dispose);
+	nfsd_file_dispose_list_delayed(&dispose);
 	return ret;
 }
 
@@ -694,72 +660,111 @@ static struct shrinker	nfsd_file_shrinker = {
 	.seeks = 1,
 };
 
-/*
- * Find all cache items across all net namespaces that match @inode and
- * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire().
+/**
+ * nfsd_file_queue_for_close: try to close out any open nfsd_files for an inode
+ * @inode:   inode on which to close out nfsd_files
+ * @dispose: list on which to gather nfsd_files to close out
+ *
+ * An nfsd_file represents a struct file being held open on behalf of nfsd. An
+ * open file however can block other activity (such as leases), or cause
+ * undesirable behavior (e.g. spurious silly-renames when reexporting NFS).
+ *
+ * This function is intended to find open nfsd_files when this sort of
+ * conflicting access occurs and then attempt to close those files out.
+ *
+ * Populates the dispose list with entries that have already had their
+ * refcounts go to zero. The actual free of an nfsd_file can be expensive,
+ * so we leave it up to the caller whether it wants to wait or not.
  */
-static unsigned int
-__nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
+static void
+nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose)
 {
 	struct nfsd_file_lookup_key key = {
 		.type	= NFSD_FILE_KEY_INODE,
 		.inode	= inode,
 	};
-	unsigned int count = 0;
 	struct nfsd_file *nf;
 
 	rcu_read_lock();
 	do {
+		int decrement = 1;
+
 		nf = rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
 				       nfsd_file_rhash_params);
 		if (!nf)
 			break;
-		nfsd_file_unhash_and_queue(nf, dispose);
-		count++;
+
+		/* If we raced with someone else unhashing, ignore it */
+		if (!nfsd_file_unhash(nf))
+			continue;
+
+		/* If we can't get a reference, ignore it */
+		if (!nfsd_file_get(nf))
+			continue;
+
+		/* Extra decrement if we remove from the LRU */
+		if (nfsd_file_lru_remove(nf))
+			++decrement;
+
+		/* If refcount goes to 0, then put on the dispose list */
+		if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
+			list_add(&nf->nf_lru, dispose);
+			trace_nfsd_file_closing(nf);
+		}
 	} while (1);
 	rcu_read_unlock();
-	return count;
 }
 
 /**
- * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
+ * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
  * @inode: inode of the file to attempt to remove
  *
- * Unhash and put, then flush and fput all cache items associated with @inode.
+ * Close out any open nfsd_files that can be reaped for @inode. The
+ * actual freeing is deferred to the dispose_list_delayed infrastructure.
+ *
+ * This is used by the fsnotify callbacks and setlease notifier.
  */
-void
-nfsd_file_close_inode_sync(struct inode *inode)
+static void
+nfsd_file_close_inode(struct inode *inode)
 {
 	LIST_HEAD(dispose);
-	unsigned int count;
 
-	count = __nfsd_file_close_inode(inode, &dispose);
-	trace_nfsd_file_close_inode_sync(inode, count);
-	nfsd_file_dispose_list_sync(&dispose);
+	nfsd_file_queue_for_close(inode, &dispose);
+	nfsd_file_dispose_list_delayed(&dispose);
 }
 
 /**
- * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
+ * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
  * @inode: inode of the file to attempt to remove
  *
- * Unhash and put all cache item associated with @inode.
+ * Close out any open nfsd_files that can be reaped for @inode. The
+ * nfsd_files are closed out synchronously.
+ *
+ * This is called from nfsd_rename and nfsd_unlink to avoid silly-renames
+ * when reexporting NFS.
  */
-static void
-nfsd_file_close_inode(struct inode *inode)
+void
+nfsd_file_close_inode_sync(struct inode *inode)
 {
+	struct nfsd_file *nf;
 	LIST_HEAD(dispose);
-	unsigned int count;
 
-	count = __nfsd_file_close_inode(inode, &dispose);
-	trace_nfsd_file_close_inode(inode, count);
-	nfsd_file_dispose_list_delayed(&dispose);
+	trace_nfsd_file_close(inode);
+
+	nfsd_file_queue_for_close(inode, &dispose);
+	while (!list_empty(&dispose)) {
+		nf = list_first_entry(&dispose, struct nfsd_file, nf_lru);
+		list_del_init(&nf->nf_lru);
+		nfsd_file_free(nf);
+	}
+	flush_delayed_fput();
 }
 
 /**
  * nfsd_file_delayed_close - close unused nfsd_files
  * @work: dummy
  *
- * Walk the LRU list and close any entries that have not been used since
+ * Walk the LRU list and destroy any entries that have not been used since
  * the last scan.
  */
 static void
@@ -781,7 +786,7 @@ nfsd_file_lease_notifier_call(struct notifier_block *nb, unsigned long arg,
 
 	/* Only close files for F_SETLEASE leases */
 	if (fl->fl_flags & FL_LEASE)
-		nfsd_file_close_inode_sync(file_inode(fl->fl_file));
+		nfsd_file_close_inode(file_inode(fl->fl_file));
 	return 0;
 }
 
@@ -902,6 +907,13 @@ nfsd_file_cache_init(void)
 	goto out;
 }
 
+/**
+ * __nfsd_file_cache_purge: clean out the cache for shutdown
+ * @net: net-namespace to shut down the cache (may be NULL)
+ *
+ * Walk the nfsd_file cache and close out any that match @net. If @net is NULL,
+ * then close out everything. Called when an nfsd instance is being shut down.
+ */
 static void
 __nfsd_file_cache_purge(struct net *net)
 {
@@ -915,8 +927,11 @@ __nfsd_file_cache_purge(struct net *net)
 
 		nf = rhashtable_walk_next(&iter);
 		while (!IS_ERR_OR_NULL(nf)) {
-			if (!net || nf->nf_net == net)
-				nfsd_file_unhash_and_queue(nf, &dispose);
+			if (!net || nf->nf_net == net) {
+				nfsd_file_unhash(nf);
+				nfsd_file_lru_remove(nf);
+				list_add(&nf->nf_lru, &dispose);
+			}
 			nf = rhashtable_walk_next(&iter);
 		}
 
@@ -1083,8 +1098,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (nf)
 		nf = nfsd_file_get(nf);
 	rcu_read_unlock();
-	if (nf)
+
+	if (nf) {
+		if (nfsd_file_lru_remove(nf))
+			WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
 		goto wait_for_construction;
+	}
 
 	nf = nfsd_file_alloc(&key, may_flags);
 	if (!nf) {
@@ -1117,11 +1136,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			goto out;
 		}
 		open_retry = false;
-		nfsd_file_put_noref(nf);
+		if (refcount_dec_and_test(&nf->nf_ref))
+			nfsd_file_free(nf);
 		goto retry;
 	}
 
-	nfsd_file_lru_remove(nf);
 	this_cpu_inc(nfsd_file_cache_hits);
 
 	status = nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_flags));
@@ -1131,7 +1150,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			this_cpu_inc(nfsd_file_acquisitions);
 		*pnf = nf;
 	} else {
-		nfsd_file_put(nf);
+		if (refcount_dec_and_test(&nf->nf_ref))
+			nfsd_file_free(nf);
 		nf = NULL;
 	}
 
@@ -1157,8 +1177,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * If construction failed, or we raced with a call to unlink()
 	 * then unhash.
 	 */
-	if (status != nfs_ok || key.inode->i_nlink == 0)
-		nfsd_file_unhash_and_put(nf);
+	if (status == nfs_ok && key.inode->i_nlink == 0)
+		status = nfserr_jukebox;
+	if (status != nfs_ok)
+		nfsd_file_unhash(nf);
 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
 	smp_mb__after_atomic();
 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index f8eaef5b319eb..77be39fcb3d44 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -875,8 +875,8 @@ DEFINE_CLID_EVENT(confirmed_r);
 	__print_flags(val, "|",						\
 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
-		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"},		\
-		{ 1 << NFSD_FILE_GC,		"GC"})
+		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
+		{ 1 << NFSD_FILE_GC,		"GC" })
 
 DECLARE_EVENT_CLASS(nfsd_file_class,
 	TP_PROTO(struct nfsd_file *nf),
@@ -911,6 +911,7 @@ DEFINE_EVENT(nfsd_file_class, name, \
 DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
 DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
 DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
+DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
 DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
 
 TRACE_EVENT(nfsd_file_alloc,
@@ -1102,35 +1103,6 @@ TRACE_EVENT(nfsd_file_open,
 		__entry->nf_file)
 )
 
-DECLARE_EVENT_CLASS(nfsd_file_search_class,
-	TP_PROTO(
-		const struct inode *inode,
-		unsigned int count
-	),
-	TP_ARGS(inode, count),
-	TP_STRUCT__entry(
-		__field(const struct inode *, inode)
-		__field(unsigned int, count)
-	),
-	TP_fast_assign(
-		__entry->inode = inode;
-		__entry->count = count;
-	),
-	TP_printk("inode=%p count=%u",
-		__entry->inode, __entry->count)
-);
-
-#define DEFINE_NFSD_FILE_SEARCH_EVENT(name)				\
-DEFINE_EVENT(nfsd_file_search_class, name,				\
-	TP_PROTO(							\
-		const struct inode *inode,				\
-		unsigned int count					\
-	),								\
-	TP_ARGS(inode, count))
-
-DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_close_inode_sync);
-DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_close_inode);
-
 TRACE_EVENT(nfsd_file_is_cached,
 	TP_PROTO(
 		const struct inode *inode,
@@ -1208,7 +1180,6 @@ DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del_disposed);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
-DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_hashed);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_disposed);
 
 DECLARE_EVENT_CLASS(nfsd_file_lruwalk_class,
@@ -1240,6 +1211,22 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
 DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
 DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
 
+TRACE_EVENT(nfsd_file_close,
+	TP_PROTO(
+		const struct inode *inode
+	),
+	TP_ARGS(inode),
+	TP_STRUCT__entry(
+		__field(const void *, inode)
+	),
+	TP_fast_assign(
+		__entry->inode = inode;
+	),
+	TP_printk("inode=%p",
+		__entry->inode
+	)
+);
+
 TRACE_EVENT(nfsd_file_fsync,
 	TP_PROTO(
 		const struct nfsd_file *nf,
-- 
2.43.0




