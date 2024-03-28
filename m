Return-Path: <stable+bounces-26527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D11870EFC
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DCA1F214A5
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D65946BA0;
	Mon,  4 Mar 2024 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NNo6HBOY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF551EB5A;
	Mon,  4 Mar 2024 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588989; cv=none; b=b6Jp3URN3Pk1XBbe7jbvo24CwDB08L+kgedgdRM6+DEB5NYEGU1zqAkhC7B998FGuFlnjUk+pfq683Ou0ncHn9Hag6NUshmHGucXW6QbfRISYisHRwXhJksE1L6iYVl923Z0MPPPZ/VWpdd2RrDBK3/EDH7NiwguDg8lAUXKOkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588989; c=relaxed/simple;
	bh=em4T4R49AQ21gemDpvVZsalZ8aOiBngL7XobsdeFSTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYXqL1ziK29A2W0g6U6fXgrtEkUUI1gzXjtcYsHIBoBTXeuSW2+LyW9Nw+0GxIvmUfoiCN/Cj1aPgYVuFqnQU5QBUjdRbaaGN6hGs0TmfBa+kyvHWMC1v3yArPnwlMQlFac48OuUXi57/I2SmXhVeNo0ZYSp1nUmZ7a8YE15hSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NNo6HBOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1DFC433F1;
	Mon,  4 Mar 2024 21:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588988;
	bh=em4T4R49AQ21gemDpvVZsalZ8aOiBngL7XobsdeFSTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NNo6HBOYMX/ykO9IWNdgvl7JTB4niNqtAXlC/ufMCmPpIiubs2c6lP/RDQ46IDXwB
	 9m8GzMNqGkzlYByWY3jhPNFOsh1wBVHvfXVZ1Dxy2SSvcCPVp+nephLoTZ/joJ3iQM
	 neHa3ta9yKVJACFh6W+U1Bm/diTKojVr4VXQWTf4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1 159/215] NFSD: Use rhashtable for managing nfs4_file objects
Date: Mon,  4 Mar 2024 21:23:42 +0000
Message-ID: <20240304211602.038230554@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit d47b295e8d76a4d69f0e2ea0cd8a79c9d3488280 ]

fh_match() is costly, especially when filehandles are large (as is
the case for NFSv4). It needs to be used sparingly when searching
data structures. Unfortunately, with common workloads, I see
multiple thousands of objects stored in file_hashtbl[], which has
just 256 buckets, making its bucket hash chains quite lengthy.

Walking long hash chains with the state_lock held blocks other
activity that needs that lock. Sizable hash chains are a common
occurrance once the server has handed out some delegations, for
example -- IIUC, each delegated file is held open on the server by
an nfs4_file object.

To help mitigate the cost of searching with fh_match(), replace the
nfs4_file hash table with an rhashtable, which can dynamically
resize its bucket array to minimize hash chain length.

The result of this modification is an improvement in the latency of
NFSv4 operations, and the reduction of nfsd CPU utilization due to
eliminating the cost of multiple calls to fh_match() and reducing
the CPU cache misses incurred while walking long hash chains in the
nfs4_file hash table.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |   97 +++++++++++++++++++++++++++++++++-------------------
 fs/nfsd/state.h     |    5 --
 2 files changed, 63 insertions(+), 39 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -44,7 +44,9 @@
 #include <linux/jhash.h>
 #include <linux/string_helpers.h>
 #include <linux/fsnotify.h>
+#include <linux/rhashtable.h>
 #include <linux/nfs_ssc.h>
+
 #include "xdr4.h"
 #include "xdr4cb.h"
 #include "vfs.h"
@@ -589,11 +591,8 @@ static void nfsd4_free_file_rcu(struct r
 void
 put_nfs4_file(struct nfs4_file *fi)
 {
-	might_lock(&state_lock);
-
-	if (refcount_dec_and_lock(&fi->fi_ref, &state_lock)) {
+	if (refcount_dec_and_test(&fi->fi_ref)) {
 		nfsd4_file_hash_remove(fi);
-		spin_unlock(&state_lock);
 		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
 		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
 		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
@@ -718,19 +717,20 @@ static unsigned int ownerstr_hashval(str
 	return ret & OWNER_HASH_MASK;
 }
 
-/* hash table for nfs4_file */
-#define FILE_HASH_BITS                   8
-#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
-
-static unsigned int file_hashval(const struct svc_fh *fh)
-{
-	struct inode *inode = d_inode(fh->fh_dentry);
+static struct rhltable nfs4_file_rhltable ____cacheline_aligned_in_smp;
 
-	/* XXX: why not (here & in file cache) use inode? */
-	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
-}
+static const struct rhashtable_params nfs4_file_rhash_params = {
+	.key_len		= sizeof_field(struct nfs4_file, fi_inode),
+	.key_offset		= offsetof(struct nfs4_file, fi_inode),
+	.head_offset		= offsetof(struct nfs4_file, fi_rlist),
 
-static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
+	/*
+	 * Start with a single page hash table to reduce resizing churn
+	 * on light workloads.
+	 */
+	.min_size		= 256,
+	.automatic_shrinking	= true,
+};
 
 /*
  * Check if courtesy clients have conflicting access and resolve it if possible
@@ -4686,12 +4686,14 @@ move_to_close_lru(struct nfs4_ol_stateid
 static noinline_for_stack struct nfs4_file *
 nfsd4_file_hash_lookup(const struct svc_fh *fhp)
 {
-	unsigned int hashval = file_hashval(fhp);
+	struct inode *inode = d_inode(fhp->fh_dentry);
+	struct rhlist_head *tmp, *list;
 	struct nfs4_file *fi;
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
-				 lockdep_is_held(&state_lock)) {
+	list = rhltable_lookup(&nfs4_file_rhltable, &inode,
+			       nfs4_file_rhash_params);
+	rhl_for_each_entry_rcu(fi, tmp, list, fi_rlist) {
 		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
 			if (refcount_inc_not_zero(&fi->fi_ref)) {
 				rcu_read_unlock();
@@ -4705,40 +4707,56 @@ nfsd4_file_hash_lookup(const struct svc_
 
 /*
  * On hash insertion, identify entries with the same inode but
- * distinct filehandles. They will all be in the same hash bucket
- * because nfs4_file's are hashed by the address in the fi_inode
- * field.
+ * distinct filehandles. They will all be on the list returned
+ * by rhltable_lookup().
+ *
+ * inode->i_lock prevents racing insertions from adding an entry
+ * for the same inode/fhp pair twice.
  */
 static noinline_for_stack struct nfs4_file *
 nfsd4_file_hash_insert(struct nfs4_file *new, const struct svc_fh *fhp)
 {
-	unsigned int hashval = file_hashval(fhp);
+	struct inode *inode = d_inode(fhp->fh_dentry);
+	struct rhlist_head *tmp, *list;
 	struct nfs4_file *ret = NULL;
 	bool alias_found = false;
 	struct nfs4_file *fi;
+	int err;
 
-	spin_lock(&state_lock);
-	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
-				 lockdep_is_held(&state_lock)) {
+	rcu_read_lock();
+	spin_lock(&inode->i_lock);
+
+	list = rhltable_lookup(&nfs4_file_rhltable, &inode,
+			       nfs4_file_rhash_params);
+	rhl_for_each_entry_rcu(fi, tmp, list, fi_rlist) {
 		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
 			if (refcount_inc_not_zero(&fi->fi_ref))
 				ret = fi;
-		} else if (d_inode(fhp->fh_dentry) == fi->fi_inode)
+		} else
 			fi->fi_aliased = alias_found = true;
 	}
-	if (likely(ret == NULL)) {
-		nfsd4_file_init(fhp, new);
-		hlist_add_head_rcu(&new->fi_hash, &file_hashtbl[hashval]);
-		new->fi_aliased = alias_found;
-		ret = new;
-	}
-	spin_unlock(&state_lock);
+	if (ret)
+		goto out_unlock;
+
+	nfsd4_file_init(fhp, new);
+	err = rhltable_insert(&nfs4_file_rhltable, &new->fi_rlist,
+			      nfs4_file_rhash_params);
+	if (err)
+		goto out_unlock;
+
+	new->fi_aliased = alias_found;
+	ret = new;
+
+out_unlock:
+	spin_unlock(&inode->i_lock);
+	rcu_read_unlock();
 	return ret;
 }
 
 static noinline_for_stack void nfsd4_file_hash_remove(struct nfs4_file *fi)
 {
-	hlist_del_rcu(&fi->fi_hash);
+	rhltable_remove(&nfs4_file_rhltable, &fi->fi_rlist,
+			nfs4_file_rhash_params);
 }
 
 /*
@@ -5648,6 +5666,8 @@ nfsd4_process_open2(struct svc_rqst *rqs
 	 * If not found, create the nfs4_file struct
 	 */
 	fp = nfsd4_file_hash_insert(open->op_file, current_fh);
+	if (unlikely(!fp))
+		return nfserr_jukebox;
 	if (fp != open->op_file) {
 		status = nfs4_check_deleg(cl, open, &dp);
 		if (status)
@@ -8064,10 +8084,16 @@ nfs4_state_start(void)
 {
 	int ret;
 
-	ret = nfsd4_create_callback_queue();
+	ret = rhltable_init(&nfs4_file_rhltable, &nfs4_file_rhash_params);
 	if (ret)
 		return ret;
 
+	ret = nfsd4_create_callback_queue();
+	if (ret) {
+		rhltable_destroy(&nfs4_file_rhltable);
+		return ret;
+	}
+
 	set_max_delegations();
 	return 0;
 }
@@ -8098,6 +8124,7 @@ nfs4_state_shutdown_net(struct net *net)
 
 	nfsd4_client_tracking_exit(net);
 	nfs4_state_destroy_net(net);
+	rhltable_destroy(&nfs4_file_rhltable);
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	nfsd4_ssc_shutdown_umount(nn);
 #endif
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -536,16 +536,13 @@ struct nfs4_clnt_odstate {
  * inode can have multiple filehandles associated with it, so there is
  * (potentially) a many to one relationship between this struct and struct
  * inode.
- *
- * These are hashed by filehandle in the file_hashtbl, which is protected by
- * the global state_lock spinlock.
  */
 struct nfs4_file {
 	refcount_t		fi_ref;
 	struct inode *		fi_inode;
 	bool			fi_aliased;
 	spinlock_t		fi_lock;
-	struct hlist_node       fi_hash;	/* hash on fi_fhandle */
+	struct rhlist_head	fi_rlist;
 	struct list_head        fi_stateids;
 	union {
 		struct list_head	fi_delegations;



