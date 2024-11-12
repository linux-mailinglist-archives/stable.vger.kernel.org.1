Return-Path: <stable+bounces-92231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE999C5327
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4471F264AC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D7E212D3E;
	Tue, 12 Nov 2024 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="esd95081"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C725C212D04;
	Tue, 12 Nov 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406976; cv=none; b=SfcIFFymkOpwi21lJwpViVhwW79MLJj3sIiFqxzrPkOkEwE8DuJua3aTwtVFwU8tnT5nKGI54r3A3bPSpyfYGyclZC/mUJ5yN5JfylTCDKJ3Yw5TC9QvYnn1DI4lLb/b8H8/0UIsT84D/0QgDYyvUqeieaRV8DoJwfYjfdN1p2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406976; c=relaxed/simple;
	bh=pTfrNpJIMYX2cikAE+y6sB5F/4HGAN4fN98hFGy8LyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CE18fHPq+hhPyGF/zbHAZtnbnMgINUyUgmLgFYNYiYIS7WdB2O/eS+DaPXqsNXiAcOdarOAyD4iH5RjQyty+xytmhNT/gye5/7fnYEmASgn5OPXm1V311OCwlhlMwZyqehFm+fOvAVyWkaXnNQ+sSek31w5Q+WDOdddprAzG+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=esd95081; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A13C4CECD;
	Tue, 12 Nov 2024 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731406976;
	bh=pTfrNpJIMYX2cikAE+y6sB5F/4HGAN4fN98hFGy8LyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=esd95081hhDFfcLMEQrvQIA21O67OCjLYPaQpVTcdZ5oSch2pg0atjTnkV6yCpTyV
	 SOJYfhhnpU2ode3LDXXfyhFvvnZeFkrkvLz4+a/tZqhWdgWdDhuxVDx5kPRFNU7zmD
	 bfTSHPLciPEyUTCq+TGPMuDIRrxCxAZskdur0XCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 14/76] NFSv3: handle out-of-order write replies.
Date: Tue, 12 Nov 2024 11:20:39 +0100
Message-ID: <20241112101840.324637492@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101839.777512218@linuxfoundation.org>
References: <20241112101839.777512218@linuxfoundation.org>
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

From: NeilBrown <neilb@suse.de>

[ Upstream commit 3db63daabe210af32a09533fe7d8d47c711a103c ]

NFSv3 includes pre/post wcc attributes which allow the client to
determine if all changes to the file have been made by the client
itself, or if any might have been made by some other client.

If there are gaps in the pre/post ctime sequence it must be assumed that
some other client changed the file in that gap and the local cache must
be suspect.  The next time the file is opened the cache should be
invalidated.

Since Commit 1c341b777501 ("NFS: Add deferred cache invalidation for
close-to-open consistency violations") in linux 5.3 the Linux client has
been triggering this invalidation.  The chunk in nfs_update_inode() in
particularly triggers.

Unfortunately Linux NFS assumes that all replies will be processed in
the order sent, and will arrive in the order processed.  This is not
true in general.  Consequently Linux NFS might ignore the wcc info in a
WRITE reply because the reply is in response to a WRITE that was sent
before some other request for which a reply has already been seen.  This
is detected by Linux using the gencount tests in nfs_inode_attr_cmp().

Also, when the gencount tests pass it is still possible that the request
were processed on the server in a different order, and a gap seen in
the ctime sequence might be filled in by a subsequent reply, so gaps
should not immediately trigger delayed invalidation.

The net result is that writing to a server and then reading the file
back can result in going to the server for the read rather than serving
it from cache - all because a couple of replies arrived out-of-order.
This is a performance regression over kernels before 5.3, though the
change in 5.3 is a correctness improvement.

This has been seen with Linux writing to a Netapp server which
occasionally re-orders requests.  In testing the majority of requests
were in-order, but a few (maybe 2 or three at a time) could be
re-ordered.

This patch addresses the problem by recording any gaps seen in the
pre/post ctime sequence and not triggering invalidation until either
there are too many gaps to fit in the table, or until there are no more
active writes and the remaining gaps cannot be resolved.

We allocate a table of 16 gaps on demand.  If the allocation fails we
revert to current behaviour which is of little cost as we are unlikely
to be able to cache the writes anyway.

In the table we store "start->end" pair when iversion is updated and
"end<-start" pairs pre/post pairs reported by the server.  Usually these
exactly cancel out and so nothing is stored.  When there are
out-of-order replies we do store gaps and these will eventually be
cancelled against later replies when this client is the only writer.

If the final write is out-of-order there may be one gap remaining when
the file is closed.  This will be noticed and if there is precisely on
gap and if the iversion can be advanced to match it, then we do so.

This patch makes no attempt to handle directories correctly.  The same
problem potentially exists in the out-of-order replies to create/unlink
requests can cause future lookup requires to be sent to the server
unnecessarily.  A similar scheme using the same primitives could be used
to notice and handle out-of-order replies.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Stable-dep-of: 867da60d463b ("nfs: avoid i_lock contention in nfs_clear_invalid_mapping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/inode.c         | 112 +++++++++++++++++++++++++++++++++++------
 include/linux/nfs_fs.h |  47 +++++++++++++++++
 2 files changed, 144 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 3861cd056cec3..edf59f809ded9 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -214,11 +214,12 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 
 	nfsi->cache_validity |= flags;
 
-	if (inode->i_mapping->nrpages == 0)
-		nfsi->cache_validity &= ~(NFS_INO_INVALID_DATA |
-					  NFS_INO_DATA_INVAL_DEFER);
-	else if (nfsi->cache_validity & NFS_INO_INVALID_DATA)
-		nfsi->cache_validity &= ~NFS_INO_DATA_INVAL_DEFER;
+	if (inode->i_mapping->nrpages == 0) {
+		nfsi->cache_validity &= ~NFS_INO_INVALID_DATA;
+		nfs_ooo_clear(nfsi);
+	} else if (nfsi->cache_validity & NFS_INO_INVALID_DATA) {
+		nfs_ooo_clear(nfsi);
+	}
 	trace_nfs_set_cache_invalid(inode, 0);
 }
 EXPORT_SYMBOL_GPL(nfs_set_cache_invalid);
@@ -692,9 +693,10 @@ static int nfs_vmtruncate(struct inode * inode, loff_t offset)
 
 	i_size_write(inode, offset);
 	/* Optimisation */
-	if (offset == 0)
-		NFS_I(inode)->cache_validity &= ~(NFS_INO_INVALID_DATA |
-				NFS_INO_DATA_INVAL_DEFER);
+	if (offset == 0) {
+		NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_DATA;
+		nfs_ooo_clear(NFS_I(inode));
+	}
 	NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_SIZE;
 
 	spin_unlock(&inode->i_lock);
@@ -1109,7 +1111,7 @@ void nfs_inode_attach_open_context(struct nfs_open_context *ctx)
 
 	spin_lock(&inode->i_lock);
 	if (list_empty(&nfsi->open_files) &&
-	    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
+	    nfs_ooo_test(nfsi))
 		nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA |
 						     NFS_INO_REVAL_FORCED);
 	list_add_tail_rcu(&ctx->list, &nfsi->open_files);
@@ -1361,8 +1363,8 @@ int nfs_clear_invalid_mapping(struct address_space *mapping)
 
 	set_bit(NFS_INO_INVALIDATING, bitlock);
 	smp_wmb();
-	nfsi->cache_validity &=
-		~(NFS_INO_INVALID_DATA | NFS_INO_DATA_INVAL_DEFER);
+	nfsi->cache_validity &= ~NFS_INO_INVALID_DATA;
+	nfs_ooo_clear(nfsi);
 	spin_unlock(&inode->i_lock);
 	trace_nfs_invalidate_mapping_enter(inode);
 	ret = nfs_invalidate_mapping(inode, mapping);
@@ -1825,6 +1827,66 @@ static int nfs_inode_finish_partial_attr_update(const struct nfs_fattr *fattr,
 	return 0;
 }
 
+static void nfs_ooo_merge(struct nfs_inode *nfsi,
+			  u64 start, u64 end)
+{
+	int i, cnt;
+
+	if (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER)
+		/* No point merging anything */
+		return;
+
+	if (!nfsi->ooo) {
+		nfsi->ooo = kmalloc(sizeof(*nfsi->ooo), GFP_ATOMIC);
+		if (!nfsi->ooo) {
+			nfsi->cache_validity |= NFS_INO_DATA_INVAL_DEFER;
+			return;
+		}
+		nfsi->ooo->cnt = 0;
+	}
+
+	/* add this range, merging if possible */
+	cnt = nfsi->ooo->cnt;
+	for (i = 0; i < cnt; i++) {
+		if (end == nfsi->ooo->gap[i].start)
+			end = nfsi->ooo->gap[i].end;
+		else if (start == nfsi->ooo->gap[i].end)
+			start = nfsi->ooo->gap[i].start;
+		else
+			continue;
+		/* Remove 'i' from table and loop to insert the new range */
+		cnt -= 1;
+		nfsi->ooo->gap[i] = nfsi->ooo->gap[cnt];
+		i = -1;
+	}
+	if (start != end) {
+		if (cnt >= ARRAY_SIZE(nfsi->ooo->gap)) {
+			nfsi->cache_validity |= NFS_INO_DATA_INVAL_DEFER;
+			kfree(nfsi->ooo);
+			nfsi->ooo = NULL;
+			return;
+		}
+		nfsi->ooo->gap[cnt].start = start;
+		nfsi->ooo->gap[cnt].end = end;
+		cnt += 1;
+	}
+	nfsi->ooo->cnt = cnt;
+}
+
+static void nfs_ooo_record(struct nfs_inode *nfsi,
+			   struct nfs_fattr *fattr)
+{
+	/* This reply was out-of-order, so record in the
+	 * pre/post change id, possibly cancelling
+	 * gaps created when iversion was jumpped forward.
+	 */
+	if ((fattr->valid & NFS_ATTR_FATTR_CHANGE) &&
+	    (fattr->valid & NFS_ATTR_FATTR_PRECHANGE))
+		nfs_ooo_merge(nfsi,
+			      fattr->change_attr,
+			      fattr->pre_change_attr);
+}
+
 static int nfs_refresh_inode_locked(struct inode *inode,
 				    struct nfs_fattr *fattr)
 {
@@ -1835,8 +1897,12 @@ static int nfs_refresh_inode_locked(struct inode *inode,
 
 	if (attr_cmp > 0 || nfs_inode_finish_partial_attr_update(fattr, inode))
 		ret = nfs_update_inode(inode, fattr);
-	else if (attr_cmp == 0)
-		ret = nfs_check_inode_attributes(inode, fattr);
+	else {
+		nfs_ooo_record(NFS_I(inode), fattr);
+
+		if (attr_cmp == 0)
+			ret = nfs_check_inode_attributes(inode, fattr);
+	}
 
 	trace_nfs_refresh_inode_exit(inode, ret);
 	return ret;
@@ -1927,6 +1993,8 @@ int nfs_post_op_update_inode_force_wcc_locked(struct inode *inode, struct nfs_fa
 	if (attr_cmp < 0)
 		return 0;
 	if ((fattr->valid & NFS_ATTR_FATTR) == 0 || !attr_cmp) {
+		/* Record the pre/post change info before clearing PRECHANGE */
+		nfs_ooo_record(NFS_I(inode), fattr);
 		fattr->valid &= ~(NFS_ATTR_FATTR_PRECHANGE
 				| NFS_ATTR_FATTR_PRESIZE
 				| NFS_ATTR_FATTR_PREMTIME
@@ -2081,6 +2149,15 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 
 	/* More cache consistency checks */
 	if (fattr->valid & NFS_ATTR_FATTR_CHANGE) {
+		if (!have_writers && nfsi->ooo && nfsi->ooo->cnt == 1 &&
+		    nfsi->ooo->gap[0].end == inode_peek_iversion_raw(inode)) {
+			/* There is one remaining gap that hasn't been
+			 * merged into iversion - do that now.
+			 */
+			inode_set_iversion_raw(inode, nfsi->ooo->gap[0].start);
+			kfree(nfsi->ooo);
+			nfsi->ooo = NULL;
+		}
 		if (!inode_eq_iversion_raw(inode, fattr->change_attr)) {
 			/* Could it be a race with writeback? */
 			if (!(have_writers || have_delegation)) {
@@ -2102,8 +2179,11 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 				dprintk("NFS: change_attr change on server for file %s/%ld\n",
 						inode->i_sb->s_id,
 						inode->i_ino);
-			} else if (!have_delegation)
-				nfsi->cache_validity |= NFS_INO_DATA_INVAL_DEFER;
+			} else if (!have_delegation) {
+				nfs_ooo_record(nfsi, fattr);
+				nfs_ooo_merge(nfsi, inode_peek_iversion_raw(inode),
+					      fattr->change_attr);
+			}
 			inode_set_iversion_raw(inode, fattr->change_attr);
 		}
 	} else {
@@ -2265,6 +2345,7 @@ struct inode *nfs_alloc_inode(struct super_block *sb)
 		return NULL;
 	nfsi->flags = 0UL;
 	nfsi->cache_validity = 0UL;
+	nfsi->ooo = NULL;
 #if IS_ENABLED(CONFIG_NFS_V4)
 	nfsi->nfs4_acl = NULL;
 #endif /* CONFIG_NFS_V4 */
@@ -2277,6 +2358,7 @@ EXPORT_SYMBOL_GPL(nfs_alloc_inode);
 
 void nfs_free_inode(struct inode *inode)
 {
+	kfree(NFS_I(inode)->ooo);
 	kmem_cache_free(nfs_inode_cachep, NFS_I(inode));
 }
 EXPORT_SYMBOL_GPL(nfs_free_inode);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 886bfa99a6af4..218e79ba263b2 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -189,6 +189,39 @@ struct nfs_inode {
 	/* Open contexts for shared mmap writes */
 	struct list_head	open_files;
 
+	/* Keep track of out-of-order replies.
+	 * The ooo array contains start/end pairs of
+	 * numbers from the changeid sequence when
+	 * the inode's iversion has been updated.
+	 * It also contains end/start pair (i.e. reverse order)
+	 * of sections of the changeid sequence that have
+	 * been seen in replies from the server.
+	 * Normally these should match and when both
+	 * A:B and B:A are found in ooo, they are both removed.
+	 * And if a reply with A:B causes an iversion update
+	 * of A:B, then neither are added.
+	 * When a reply has pre_change that doesn't match
+	 * iversion, then the changeid pair and any consequent
+	 * change in iversion ARE added.  Later replies
+	 * might fill in the gaps, or possibly a gap is caused
+	 * by a change from another client.
+	 * When a file or directory is opened, if the ooo table
+	 * is not empty, then we assume the gaps were due to
+	 * another client and we invalidate the cached data.
+	 *
+	 * We can only track a limited number of concurrent gaps.
+	 * Currently that limit is 16.
+	 * We allocate the table on demand.  If there is insufficient
+	 * memory, then we probably cannot cache the file anyway
+	 * so there is no loss.
+	 */
+	struct {
+		int cnt;
+		struct {
+			u64 start, end;
+		} gap[16];
+	} *ooo;
+
 #if IS_ENABLED(CONFIG_NFS_V4)
 	struct nfs4_cached_acl	*nfs4_acl;
         /* NFSv4 state */
@@ -624,6 +657,20 @@ nfs_fileid_to_ino_t(u64 fileid)
 	return ino;
 }
 
+static inline void nfs_ooo_clear(struct nfs_inode *nfsi)
+{
+	nfsi->cache_validity &= ~NFS_INO_DATA_INVAL_DEFER;
+	kfree(nfsi->ooo);
+	nfsi->ooo = NULL;
+}
+
+static inline bool nfs_ooo_test(struct nfs_inode *nfsi)
+{
+	return (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER) ||
+		(nfsi->ooo && nfsi->ooo->cnt > 0);
+
+}
+
 #define NFS_JUKEBOX_RETRY_TIME (5 * HZ)
 
 
-- 
2.43.0




