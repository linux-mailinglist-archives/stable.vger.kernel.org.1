Return-Path: <stable+bounces-77028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376D4984B09
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 20:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3311C22D4F
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 18:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9998B1ACDE5;
	Tue, 24 Sep 2024 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdKQ9BKH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7961B1AD5EB;
	Tue, 24 Sep 2024 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203158; cv=none; b=XGNoH+xOx/Qw6RHJLZJm/5VMgOMfZ9eUjuPdX+YIFa/kR98ykdAyYH4ekiSeh1YXUwgAZ43YhuRghlZHAxmgT/iGyQYaEFohOw4BkoVzK1yD7/IADlDMqUUmqRo2uYpfkwMgQSAxN7dW/0f1H4ypD36tRF0Ior7zdhvdIHju6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203158; c=relaxed/simple;
	bh=YRDazTeOFomx0ThoqGkq6byg6KzCcYzPscLBTVmAQKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cogLXGl9tTLh/to2cErw7w9Y14DxSooFyy0OqMy8krrEtC/uiqqb8Ck8TScibMWLB/jdU3aYDPn+U0PkSg7jRpmTy0xzVg1STPQgu1NF+Cuy6EodkADDYX0ok0LRigTU5uLx5CXEABVt1fAebU2WJtYBs+IDj7K4OWdhtVVuYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdKQ9BKH; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d873dc644dso4568386a91.3;
        Tue, 24 Sep 2024 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727203155; x=1727807955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tekeTkwOi3rMYKlOM1MMVKO3o/Nz2Zsv4uC1lEB9km8=;
        b=jdKQ9BKHgLYrk81VC2vCg+8QiRicNXTkvAHAyzj12WYZzvOP2KGwJ5v/7wR44uhj/4
         0rb///Yoap9j/SSrVqsdPkUpa0fpl3RbUSGE3j7OnlAdulpL5J9smd8yme+ne//BO10j
         nUpHzqYSP81N1gh9B7JIQYzHecUMFBCRDhjj+EibTuIX80UN8X/tNhgM4OjAbRKMhXIt
         TkerOehI9fmV20d/syKARdW/xfbJnIQEzU0pvTFEADea1BRS9p+b8tbu16bICs8/1QkD
         +MKq50eIY9S+CPD+ccl/godAC0WTNCZkwlCqWNYyeTFM/kPYCLYc10XsKDSACSrc0KB2
         dBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727203155; x=1727807955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tekeTkwOi3rMYKlOM1MMVKO3o/Nz2Zsv4uC1lEB9km8=;
        b=gRrrH+T5i6MlSEzCoBzy2XDbnnQ6JYkEPJjif6peQ2cM/2OmOEz7JWvopofl2fD7gc
         9UjtnOZXQfNSBaF5T3ihswLAbM+8DKvRZM1roQsbHmPjWJ/qiqbMztTdb+Hy3j6whq5p
         sV8z70RbkDWLS0jHxSBS5B8ncbQYsgAD62EMlg9YatX3y2QDeqSHT8PfeJoBLbzf24PE
         COwiHruM6bTW+1XH5t5tUA/RQYN7EIbnxUmiMRiTIcmNzR/N5BEWtcTY7A6+JxiNznc0
         0nXGwzWBbDyJTonE4iO5BNf/zfiS0/qDLI4H25PUlsHfi/amzh1J9QnNF+DV7sAG7xYe
         wJGQ==
X-Gm-Message-State: AOJu0Ywa2BfcMzlYTk4CSnqs6KtZ8RCUz1Xs3gSx7Jac9SsgGCLvssEd
	juz7sZq4bhOSQg+UtP+OMYUsdYnvm0jmE8cdPkI0nhfDdRZ/6B2jIH+YUWHi
X-Google-Smtp-Source: AGHT+IFFzN29Lk+GdywawMTr1/m1/vtOnaWmvVtbpIvKsNAI9hd70C6tRwMbOz57M740XA7vjk32uA==
X-Received: by 2002:a17:90a:514f:b0:2d8:9c0a:8553 with SMTP id 98e67ed59e1d1-2e06ae7be13mr99859a91.21.1727203155220;
        Tue, 24 Sep 2024 11:39:15 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2a3:200:3987:6b77:4621:58ca])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef93b2fsm11644349a91.49.2024.09.24.11.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 11:39:14 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	cem@kernel.org,
	catherine.hoang@oracle.com,
	Dave Chinner <dchinner@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Leah Rumancik <leah.rumancik@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: [PATCH 6.1 13/26] xfs: fix AGF vs inode cluster buffer deadlock
Date: Tue, 24 Sep 2024 11:38:38 -0700
Message-ID: <20240924183851.1901667-14-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240924183851.1901667-1-leah.rumancik@gmail.com>
References: <20240924183851.1901667-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 82842fee6e5979ca7e2bf4d839ef890c22ffb7aa ]

Lock order in XFS is AGI -> AGF, hence for operations involving
inode unlinked list operations we always lock the AGI first. Inode
unlinked list operations operate on the inode cluster buffer,
so the lock order there is AGI -> inode cluster buffer.

For O_TMPFILE operations, this now means the lock order set down in
xfs_rename and xfs_link is AGI -> inode cluster buffer -> AGF as the
unlinked ops are done before the directory modifications that may
allocate space and lock the AGF.

Unfortunately, we also now lock the inode cluster buffer when
logging an inode so that we can attach the inode to the cluster
buffer and pin it in memory. This creates a lock order of AGF ->
inode cluster buffer in directory operations as we have to log the
inode after we've allocated new space for it.

This creates a lock inversion between the AGF and the inode cluster
buffer. Because the inode cluster buffer is shared across multiple
inodes, the inversion is not specific to individual inodes but can
occur when inodes in the same cluster buffer are accessed in
different orders.

To fix this we need move all the inode log item cluster buffer
interactions to the end of the current transaction. Unfortunately,
xfs_trans_log_inode() calls are littered throughout the transactions
with no thought to ordering against other items or locking. This
makes it difficult to do anything that involves changing the call
sites of xfs_trans_log_inode() to change locking orders.

However, we do now have a mechanism that allows is to postpone dirty
item processing to just before we commit the transaction: the
->iop_precommit method. This will be called after all the
modifications are done and high level objects like AGI and AGF
buffers have been locked and modified, thereby providing a mechanism
that guarantees we don't lock the inode cluster buffer before those
high level objects are locked.

This change is largely moving the guts of xfs_trans_log_inode() to
xfs_inode_item_precommit() and providing an extra flag context in
the inode log item to track the dirty state of the inode in the
current transaction. This also means we do a lot less repeated work
in xfs_trans_log_inode() by only doing it once per transaction when
all the work is done.

Fixes: 298f7bec503f ("xfs: pin inode backing buffer to the inode log item")
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Chandan Babu R <chandanbabu@kernel.org>
---
 fs/xfs/libxfs/xfs_log_format.h  |   9 +-
 fs/xfs/libxfs/xfs_trans_inode.c | 113 ++----------------------
 fs/xfs/xfs_inode_item.c         | 149 ++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode_item.h         |   1 +
 4 files changed, 166 insertions(+), 106 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index f13e0809dc63..269573c82808 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -324,7 +324,6 @@ struct xfs_inode_log_format_32 {
 #define XFS_ILOG_DOWNER	0x200	/* change the data fork owner on replay */
 #define XFS_ILOG_AOWNER	0x400	/* change the attr fork owner on replay */
 
-
 /*
  * The timestamps are dirty, but not necessarily anything else in the inode
  * core.  Unlike the other fields above this one must never make it to disk
@@ -333,6 +332,14 @@ struct xfs_inode_log_format_32 {
  */
 #define XFS_ILOG_TIMESTAMP	0x4000
 
+/*
+ * The version field has been changed, but not necessarily anything else of
+ * interest. This must never make it to disk - it is used purely to ensure that
+ * the inode item ->precommit operation can update the fsync flag triggers
+ * in the inode item correctly.
+ */
+#define XFS_ILOG_IVERSION	0x8000
+
 #define	XFS_ILOG_NONCORE	(XFS_ILOG_DDATA | XFS_ILOG_DEXT | \
 				 XFS_ILOG_DBROOT | XFS_ILOG_DEV | \
 				 XFS_ILOG_ADATA | XFS_ILOG_AEXT | \
diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 8b5547073379..cb4796b6e693 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -40,9 +40,8 @@ xfs_trans_ijoin(
 	iip->ili_lock_flags = lock_flags;
 	ASSERT(!xfs_iflags_test(ip, XFS_ISTALE));
 
-	/*
-	 * Get a log_item_desc to point at the new item.
-	 */
+	/* Reset the per-tx dirty context and add the item to the tx. */
+	iip->ili_dirty_flags = 0;
 	xfs_trans_add_item(tp, &iip->ili_item);
 }
 
@@ -76,17 +75,10 @@ xfs_trans_ichgtime(
 /*
  * This is called to mark the fields indicated in fieldmask as needing to be
  * logged when the transaction is committed.  The inode must already be
- * associated with the given transaction.
- *
- * The values for fieldmask are defined in xfs_inode_item.h.  We always log all
- * of the core inode if any of it has changed, and we always log all of the
- * inline data/extents/b-tree root if any of them has changed.
- *
- * Grab and pin the cluster buffer associated with this inode to avoid RMW
- * cycles at inode writeback time. Avoid the need to add error handling to every
- * xfs_trans_log_inode() call by shutting down on read error.  This will cause
- * transactions to fail and everything to error out, just like if we return a
- * read error in a dirty transaction and cancel it.
+ * associated with the given transaction. All we do here is record where the
+ * inode was dirtied and mark the transaction and inode log item dirty;
+ * everything else is done in the ->precommit log item operation after the
+ * changes in the transaction have been completed.
  */
 void
 xfs_trans_log_inode(
@@ -96,7 +88,6 @@ xfs_trans_log_inode(
 {
 	struct xfs_inode_log_item *iip = ip->i_itemp;
 	struct inode		*inode = VFS_I(ip);
-	uint			iversion_flags = 0;
 
 	ASSERT(iip);
 	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
@@ -104,18 +95,6 @@ xfs_trans_log_inode(
 
 	tp->t_flags |= XFS_TRANS_DIRTY;
 
-	/*
-	 * Don't bother with i_lock for the I_DIRTY_TIME check here, as races
-	 * don't matter - we either will need an extra transaction in 24 hours
-	 * to log the timestamps, or will clear already cleared fields in the
-	 * worst case.
-	 */
-	if (inode->i_state & I_DIRTY_TIME) {
-		spin_lock(&inode->i_lock);
-		inode->i_state &= ~I_DIRTY_TIME;
-		spin_unlock(&inode->i_lock);
-	}
-
 	/*
 	 * First time we log the inode in a transaction, bump the inode change
 	 * counter if it is configured for this to occur. While we have the
@@ -128,86 +107,10 @@ xfs_trans_log_inode(
 	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags)) {
 		if (IS_I_VERSION(inode) &&
 		    inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
-			iversion_flags = XFS_ILOG_CORE;
-	}
-
-	/*
-	 * If we're updating the inode core or the timestamps and it's possible
-	 * to upgrade this inode to bigtime format, do so now.
-	 */
-	if ((flags & (XFS_ILOG_CORE | XFS_ILOG_TIMESTAMP)) &&
-	    xfs_has_bigtime(ip->i_mount) &&
-	    !xfs_inode_has_bigtime(ip)) {
-		ip->i_diflags2 |= XFS_DIFLAG2_BIGTIME;
-		flags |= XFS_ILOG_CORE;
-	}
-
-	/*
-	 * Inode verifiers do not check that the extent size hint is an integer
-	 * multiple of the rt extent size on a directory with both rtinherit
-	 * and extszinherit flags set.  If we're logging a directory that is
-	 * misconfigured in this way, clear the hint.
-	 */
-	if ((ip->i_diflags & XFS_DIFLAG_RTINHERIT) &&
-	    (ip->i_diflags & XFS_DIFLAG_EXTSZINHERIT) &&
-	    (ip->i_extsize % ip->i_mount->m_sb.sb_rextsize) > 0) {
-		ip->i_diflags &= ~(XFS_DIFLAG_EXTSIZE |
-				   XFS_DIFLAG_EXTSZINHERIT);
-		ip->i_extsize = 0;
-		flags |= XFS_ILOG_CORE;
+			flags |= XFS_ILOG_IVERSION;
 	}
 
-	/*
-	 * Record the specific change for fdatasync optimisation. This allows
-	 * fdatasync to skip log forces for inodes that are only timestamp
-	 * dirty.
-	 */
-	spin_lock(&iip->ili_lock);
-	iip->ili_fsync_fields |= flags;
-
-	if (!iip->ili_item.li_buf) {
-		struct xfs_buf	*bp;
-		int		error;
-
-		/*
-		 * We hold the ILOCK here, so this inode is not going to be
-		 * flushed while we are here. Further, because there is no
-		 * buffer attached to the item, we know that there is no IO in
-		 * progress, so nothing will clear the ili_fields while we read
-		 * in the buffer. Hence we can safely drop the spin lock and
-		 * read the buffer knowing that the state will not change from
-		 * here.
-		 */
-		spin_unlock(&iip->ili_lock);
-		error = xfs_imap_to_bp(ip->i_mount, tp, &ip->i_imap, &bp);
-		if (error) {
-			xfs_force_shutdown(ip->i_mount, SHUTDOWN_META_IO_ERROR);
-			return;
-		}
-
-		/*
-		 * We need an explicit buffer reference for the log item but
-		 * don't want the buffer to remain attached to the transaction.
-		 * Hold the buffer but release the transaction reference once
-		 * we've attached the inode log item to the buffer log item
-		 * list.
-		 */
-		xfs_buf_hold(bp);
-		spin_lock(&iip->ili_lock);
-		iip->ili_item.li_buf = bp;
-		bp->b_flags |= _XBF_INODES;
-		list_add_tail(&iip->ili_item.li_bio_list, &bp->b_li_list);
-		xfs_trans_brelse(tp, bp);
-	}
-
-	/*
-	 * Always OR in the bits from the ili_last_fields field.  This is to
-	 * coordinate with the xfs_iflush() and xfs_buf_inode_iodone() routines
-	 * in the eventual clearing of the ili_fields bits.  See the big comment
-	 * in xfs_iflush() for an explanation of this coordination mechanism.
-	 */
-	iip->ili_fields |= (flags | iip->ili_last_fields | iversion_flags);
-	spin_unlock(&iip->ili_lock);
+	iip->ili_dirty_flags |= flags;
 }
 
 int
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index ca2941ab6cbc..91c847a84e10 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -29,6 +29,153 @@ static inline struct xfs_inode_log_item *INODE_ITEM(struct xfs_log_item *lip)
 	return container_of(lip, struct xfs_inode_log_item, ili_item);
 }
 
+static uint64_t
+xfs_inode_item_sort(
+	struct xfs_log_item	*lip)
+{
+	return INODE_ITEM(lip)->ili_inode->i_ino;
+}
+
+/*
+ * Prior to finally logging the inode, we have to ensure that all the
+ * per-modification inode state changes are applied. This includes VFS inode
+ * state updates, format conversions, verifier state synchronisation and
+ * ensuring the inode buffer remains in memory whilst the inode is dirty.
+ *
+ * We have to be careful when we grab the inode cluster buffer due to lock
+ * ordering constraints. The unlinked inode modifications (xfs_iunlink_item)
+ * require AGI -> inode cluster buffer lock order. The inode cluster buffer is
+ * not locked until ->precommit, so it happens after everything else has been
+ * modified.
+ *
+ * Further, we have AGI -> AGF lock ordering, and with O_TMPFILE handling we
+ * have AGI -> AGF -> iunlink item -> inode cluster buffer lock order. Hence we
+ * cannot safely lock the inode cluster buffer in xfs_trans_log_inode() because
+ * it can be called on a inode (e.g. via bumplink/droplink) before we take the
+ * AGF lock modifying directory blocks.
+ *
+ * Rather than force a complete rework of all the transactions to call
+ * xfs_trans_log_inode() once and once only at the end of every transaction, we
+ * move the pinning of the inode cluster buffer to a ->precommit operation. This
+ * matches how the xfs_iunlink_item locks the inode cluster buffer, and it
+ * ensures that the inode cluster buffer locking is always done last in a
+ * transaction. i.e. we ensure the lock order is always AGI -> AGF -> inode
+ * cluster buffer.
+ *
+ * If we return the inode number as the precommit sort key then we'll also
+ * guarantee that the order all inode cluster buffer locking is the same all the
+ * inodes and unlink items in the transaction.
+ */
+static int
+xfs_inode_item_precommit(
+	struct xfs_trans	*tp,
+	struct xfs_log_item	*lip)
+{
+	struct xfs_inode_log_item *iip = INODE_ITEM(lip);
+	struct xfs_inode	*ip = iip->ili_inode;
+	struct inode		*inode = VFS_I(ip);
+	unsigned int		flags = iip->ili_dirty_flags;
+
+	/*
+	 * Don't bother with i_lock for the I_DIRTY_TIME check here, as races
+	 * don't matter - we either will need an extra transaction in 24 hours
+	 * to log the timestamps, or will clear already cleared fields in the
+	 * worst case.
+	 */
+	if (inode->i_state & I_DIRTY_TIME) {
+		spin_lock(&inode->i_lock);
+		inode->i_state &= ~I_DIRTY_TIME;
+		spin_unlock(&inode->i_lock);
+	}
+
+	/*
+	 * If we're updating the inode core or the timestamps and it's possible
+	 * to upgrade this inode to bigtime format, do so now.
+	 */
+	if ((flags & (XFS_ILOG_CORE | XFS_ILOG_TIMESTAMP)) &&
+	    xfs_has_bigtime(ip->i_mount) &&
+	    !xfs_inode_has_bigtime(ip)) {
+		ip->i_diflags2 |= XFS_DIFLAG2_BIGTIME;
+		flags |= XFS_ILOG_CORE;
+	}
+
+	/*
+	 * Inode verifiers do not check that the extent size hint is an integer
+	 * multiple of the rt extent size on a directory with both rtinherit
+	 * and extszinherit flags set.  If we're logging a directory that is
+	 * misconfigured in this way, clear the hint.
+	 */
+	if ((ip->i_diflags & XFS_DIFLAG_RTINHERIT) &&
+	    (ip->i_diflags & XFS_DIFLAG_EXTSZINHERIT) &&
+	    (ip->i_extsize % ip->i_mount->m_sb.sb_rextsize) > 0) {
+		ip->i_diflags &= ~(XFS_DIFLAG_EXTSIZE |
+				   XFS_DIFLAG_EXTSZINHERIT);
+		ip->i_extsize = 0;
+		flags |= XFS_ILOG_CORE;
+	}
+
+	/*
+	 * Record the specific change for fdatasync optimisation. This allows
+	 * fdatasync to skip log forces for inodes that are only timestamp
+	 * dirty. Once we've processed the XFS_ILOG_IVERSION flag, convert it
+	 * to XFS_ILOG_CORE so that the actual on-disk dirty tracking
+	 * (ili_fields) correctly tracks that the version has changed.
+	 */
+	spin_lock(&iip->ili_lock);
+	iip->ili_fsync_fields |= (flags & ~XFS_ILOG_IVERSION);
+	if (flags & XFS_ILOG_IVERSION)
+		flags = ((flags & ~XFS_ILOG_IVERSION) | XFS_ILOG_CORE);
+
+	if (!iip->ili_item.li_buf) {
+		struct xfs_buf	*bp;
+		int		error;
+
+		/*
+		 * We hold the ILOCK here, so this inode is not going to be
+		 * flushed while we are here. Further, because there is no
+		 * buffer attached to the item, we know that there is no IO in
+		 * progress, so nothing will clear the ili_fields while we read
+		 * in the buffer. Hence we can safely drop the spin lock and
+		 * read the buffer knowing that the state will not change from
+		 * here.
+		 */
+		spin_unlock(&iip->ili_lock);
+		error = xfs_imap_to_bp(ip->i_mount, tp, &ip->i_imap, &bp);
+		if (error)
+			return error;
+
+		/*
+		 * We need an explicit buffer reference for the log item but
+		 * don't want the buffer to remain attached to the transaction.
+		 * Hold the buffer but release the transaction reference once
+		 * we've attached the inode log item to the buffer log item
+		 * list.
+		 */
+		xfs_buf_hold(bp);
+		spin_lock(&iip->ili_lock);
+		iip->ili_item.li_buf = bp;
+		bp->b_flags |= _XBF_INODES;
+		list_add_tail(&iip->ili_item.li_bio_list, &bp->b_li_list);
+		xfs_trans_brelse(tp, bp);
+	}
+
+	/*
+	 * Always OR in the bits from the ili_last_fields field.  This is to
+	 * coordinate with the xfs_iflush() and xfs_buf_inode_iodone() routines
+	 * in the eventual clearing of the ili_fields bits.  See the big comment
+	 * in xfs_iflush() for an explanation of this coordination mechanism.
+	 */
+	iip->ili_fields |= (flags | iip->ili_last_fields);
+	spin_unlock(&iip->ili_lock);
+
+	/*
+	 * We are done with the log item transaction dirty state, so clear it so
+	 * that it doesn't pollute future transactions.
+	 */
+	iip->ili_dirty_flags = 0;
+	return 0;
+}
+
 /*
  * The logged size of an inode fork is always the current size of the inode
  * fork. This means that when an inode fork is relogged, the size of the logged
@@ -662,6 +809,8 @@ xfs_inode_item_committing(
 }
 
 static const struct xfs_item_ops xfs_inode_item_ops = {
+	.iop_sort	= xfs_inode_item_sort,
+	.iop_precommit	= xfs_inode_item_precommit,
 	.iop_size	= xfs_inode_item_size,
 	.iop_format	= xfs_inode_item_format,
 	.iop_pin	= xfs_inode_item_pin,
diff --git a/fs/xfs/xfs_inode_item.h b/fs/xfs/xfs_inode_item.h
index bbd836a44ff0..377e06007804 100644
--- a/fs/xfs/xfs_inode_item.h
+++ b/fs/xfs/xfs_inode_item.h
@@ -17,6 +17,7 @@ struct xfs_inode_log_item {
 	struct xfs_log_item	ili_item;	   /* common portion */
 	struct xfs_inode	*ili_inode;	   /* inode ptr */
 	unsigned short		ili_lock_flags;	   /* inode lock flags */
+	unsigned int		ili_dirty_flags;   /* dirty in current tx */
 	/*
 	 * The ili_lock protects the interactions between the dirty state and
 	 * the flush state of the inode log item. This allows us to do atomic
-- 
2.46.0.792.g87dc391469-goog


