Return-Path: <stable+bounces-53398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1946190D176
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05971F26492
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C3B1A08A7;
	Tue, 18 Jun 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lfxRL416"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D611A0739;
	Tue, 18 Jun 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716207; cv=none; b=uMJ51Hemj8FSqGl+VzUTLqv31WKmrPL2aYWBN+3lyZ/5VHTE4gVeb+4e0UG2nVx7qolRDZ5+mMDtN1lgYjBirpX9wAgGSwIYzE92C0yJ+AuEc7B1JmK0dkavk7JwCs/8jSUx3dbtp8gbb8tmnae/kDVgJPIYTDfocFtT2ziUXe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716207; c=relaxed/simple;
	bh=90myI5dibilhirvDyWmkg6T4hC9zTHDdn44SQZm22cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vd2kmI8fA10KYoLUc3ddeReIS/7cOJ9aYJfxh/VtY/cOnIgW6dZMYmn1FbKw8vNVSwNJi/TFTlp1DfYj90lwIsLvUl7LMrPRxCKWqXqIvoCelhkoafilwC9RCq/eDVo3fRl8wXdDYl7prowNhDDe9jKznABGR0YdVFQzSEVmFLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lfxRL416; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF55C3277B;
	Tue, 18 Jun 2024 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716207;
	bh=90myI5dibilhirvDyWmkg6T4hC9zTHDdn44SQZm22cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lfxRL416WCrSQ2J8AX3f/o4FsXD/6V19YrUTGzOwRkIfm22ZBpfNY6RiCxVeUR1OD
	 kULGOOEoBLTMn8KpPLjDdwaJ/QOUYTUFvR9dpWoAdl3t3AiVkrWViNcGLPAgMBjbdV
	 5JJQOx9PgV6Ajd6mZCMwkLjTUqOd7j3zJ3ecQHYU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank van der Linden <fllinden@amazon.com>,
	Wang Yugui <wangyugui@e16-tech.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 568/770] NFSD: Leave open files out of the filecache LRU
Date: Tue, 18 Jun 2024 14:37:01 +0200
Message-ID: <20240618123429.224004050@linuxfoundation.org>
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

[ Upstream commit 4a0e73e635e3f36b616ad5c943e3d23debe4632f ]

There have been reports of problems when running fstests generic/531
against Linux NFS servers with NFSv4. The NFS server that hosts the
test's SCRATCH_DEV suffers from CPU soft lock-ups during the test.
Analysis shows that:

fs/nfsd/filecache.c
 482                 ret = list_lru_walk(&nfsd_file_lru,
 483                                 nfsd_file_lru_cb,
 484                                 &head, LONG_MAX);

causes nfsd_file_gc() to walk the entire length of the filecache LRU
list every time it is called (which is quite frequently). The walk
holds a spinlock the entire time that prevents other nfsd threads
from accessing the filecache.

What's more, for NFSv4 workloads, none of the items that are visited
during this walk may be evicted, since they are all files that are
held OPEN by NFS clients.

Address this by ensuring that open files are not kept on the LRU
list.

Reported-by: Frank van der Linden <fllinden@amazon.com>
Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=386
Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 24 +++++++++++++++++++-----
 fs/nfsd/trace.h     |  2 ++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a995a744a7481..5c9e3ff6397b0 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -262,6 +262,7 @@ nfsd_file_flush(struct nfsd_file *nf)
 
 static void nfsd_file_lru_add(struct nfsd_file *nf)
 {
+	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
 	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
 		trace_nfsd_file_lru_add(nf);
 }
@@ -291,7 +292,6 @@ nfsd_file_unhash(struct nfsd_file *nf)
 {
 	if (test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
 		nfsd_file_do_unhash(nf);
-		nfsd_file_lru_remove(nf);
 		return true;
 	}
 	return false;
@@ -312,6 +312,7 @@ nfsd_file_unhash_and_release_locked(struct nfsd_file *nf, struct list_head *disp
 	if (refcount_dec_not_one(&nf->nf_ref))
 		return true;
 
+	nfsd_file_lru_remove(nf);
 	list_add(&nf->nf_lru, dispose);
 	return true;
 }
@@ -323,6 +324,7 @@ nfsd_file_put_noref(struct nfsd_file *nf)
 
 	if (refcount_dec_and_test(&nf->nf_ref)) {
 		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
+		nfsd_file_lru_remove(nf);
 		nfsd_file_free(nf);
 	}
 }
@@ -332,7 +334,7 @@ nfsd_file_put(struct nfsd_file *nf)
 {
 	might_sleep();
 
-	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
+	nfsd_file_lru_add(nf);
 	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0) {
 		nfsd_file_flush(nf);
 		nfsd_file_put_noref(nf);
@@ -432,8 +434,18 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
 	}
 }
 
-/*
+/**
+ * nfsd_file_lru_cb - Examine an entry on the LRU list
+ * @item: LRU entry to examine
+ * @lru: controlling LRU
+ * @lock: LRU list lock (unused)
+ * @arg: dispose list
+ *
  * Note this can deadlock with nfsd_file_cache_purge.
+ *
+ * Return values:
+ *   %LRU_REMOVED: @item was removed from the LRU
+ *   %LRU_SKIP: @item cannot be evicted
  */
 static enum lru_status
 nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
@@ -455,8 +467,9 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 	 * That order is deliberate to ensure that we can do this locklessly.
 	 */
 	if (refcount_read(&nf->nf_ref) > 1) {
+		list_lru_isolate(lru, &nf->nf_lru);
 		trace_nfsd_file_gc_in_use(nf);
-		return LRU_SKIP;
+		return LRU_REMOVED;
 	}
 
 	/*
@@ -1013,6 +1026,7 @@ nfsd_do_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto retry;
 	}
 
+	nfsd_file_lru_remove(nf);
 	this_cpu_inc(nfsd_file_cache_hits);
 
 	status = nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_flags));
@@ -1034,7 +1048,6 @@ nfsd_do_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	refcount_inc(&nf->nf_ref);
 	__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
 	__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
-	nfsd_file_lru_add(nf);
 	hlist_add_head_rcu(&nf->nf_node, &nfsd_file_hashtbl[hashval].nfb_head);
 	++nfsd_file_hashtbl[hashval].nfb_count;
 	nfsd_file_hashtbl[hashval].nfb_maxcount = max(nfsd_file_hashtbl[hashval].nfb_maxcount,
@@ -1059,6 +1072,7 @@ nfsd_do_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 */
 	if (status != nfs_ok || inode->i_nlink == 0) {
 		bool do_free;
+		nfsd_file_lru_remove(nf);
 		spin_lock(&nfsd_file_hashtbl[hashval].nfb_lock);
 		do_free = nfsd_file_unhash(nf);
 		spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b1aa28c062ac5..5919cdcf137b8 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -892,7 +892,9 @@ DEFINE_EVENT(nfsd_file_gc_class, name,					\
 	TP_ARGS(nf))
 
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_add);
+DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_add_disposed);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del);
+DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del_disposed);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
-- 
2.43.0




