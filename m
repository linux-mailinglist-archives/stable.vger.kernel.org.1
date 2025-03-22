Return-Path: <stable+bounces-125810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28167A6CA9A
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 15:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239603B2191
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 14:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6726222582;
	Sat, 22 Mar 2025 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="gUVWQYFa"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C4F1AF0BB
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654075; cv=none; b=QAIy+GkOsBCvDw7w/Zjv5/3HBCXzpXW2mH3e2deObdmaEIINeLwVSNJRrTcL9LNm4Bsw/obmmzhEOd6ZmVNfvDmlWWhXubJ3WC5Q+wKf1zSefRD5RmhqPB2xeE8ggPkdhVIl3xjIolZVi7LkXfdHY17H1JY73RkdkLxLvc+3wPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654075; c=relaxed/simple;
	bh=GpKAAeYzKFUMoKLdvRp8AhS/ekYE0mS3PETovevYOoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KO9Hi/5zJB79vxedzPQu4v0RRsJZWRygSH8A9pQuybaIr63dA5l+b0jFC7EdqrdTRarSFD+04Hw7hOPpvf0cXl5TvFbGfOpV7I+rCIj5hB0uy2jLRPqftV8SCGGZmoalU/01shso2KiwFc04H08Er7H7jTsQdB6vQP/oTA5ebJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=gUVWQYFa; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 68E57407618C;
	Sat, 22 Mar 2025 14:34:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 68E57407618C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1742654070;
	bh=00N330WYerxb59XJXKn9kCRlgGxRgzTeEZlkzYAGqyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUVWQYFajbsE6kztVOJHSAdYlubViEXo9X67rxbLmM3i6Y0FLDkCgJj3LdMKgEKPn
	 Rb4ciBvp9M0nPasT1FBSN1ZrMx/yeX/aRXj7VAQ6ekyfykbBB17kzqADovIE0JkgqM
	 Th3BuTEnFXx483mJ7a4pTdypZf4RiRAH49ywxZo8=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	stable@vger.kernel.org,
	xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.6 3/4] xfs: use xfs_defer_finish_one to finish recovered work items
Date: Sat, 22 Mar 2025 17:34:14 +0300
Message-ID: <20250322143418.216654-4-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322143418.216654-1-pchelkin@ispras.ru>
References: <20250322143418.216654-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Darrick J. Wong <djwong@kernel.org>

commit e5f1a5146ec35f3ed5d7f5ac7807a10c0062b6b8 upstream.

Get rid of the open-coded calls to xfs_defer_finish_one.  This also
means that the recovery transaction takes care of cleaning up the dfp,
and we have solved (I hope) all the ownership issues in recovery.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 fs/xfs/libxfs/xfs_defer.c       |  2 +-
 fs/xfs/libxfs/xfs_defer.h       |  1 +
 fs/xfs/libxfs/xfs_log_recover.h |  2 +-
 fs/xfs/xfs_attr_item.c          | 20 +----------
 fs/xfs/xfs_bmap_item.c          | 24 ++++---------
 fs/xfs/xfs_extfree_item.c       | 45 +++++-------------------
 fs/xfs/xfs_log_recover.c        | 22 +++++++-----
 fs/xfs/xfs_refcount_item.c      | 61 +++++----------------------------
 fs/xfs/xfs_rmap_item.c          | 29 +++++-----------
 9 files changed, 49 insertions(+), 157 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index 8fb523e4f669..eb262ea06122 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -484,7 +484,7 @@ xfs_defer_relog(
  * Log an intent-done item for the first pending intent, and finish the work
  * items.
  */
-static int
+int
 xfs_defer_finish_one(
 	struct xfs_trans		*tp,
 	struct xfs_defer_pending	*dfp)
diff --git a/fs/xfs/libxfs/xfs_defer.h b/fs/xfs/libxfs/xfs_defer.h
index bef5823f61fb..c1a648e99174 100644
--- a/fs/xfs/libxfs/xfs_defer.h
+++ b/fs/xfs/libxfs/xfs_defer.h
@@ -41,6 +41,7 @@ void xfs_defer_add(struct xfs_trans *tp, enum xfs_defer_ops_type type,
 		struct list_head *h);
 int xfs_defer_finish_noroll(struct xfs_trans **tp);
 int xfs_defer_finish(struct xfs_trans **tp);
+int xfs_defer_finish_one(struct xfs_trans *tp, struct xfs_defer_pending *dfp);
 void xfs_defer_cancel(struct xfs_trans *);
 void xfs_defer_move(struct xfs_trans *dtp, struct xfs_trans *stp);
 
diff --git a/fs/xfs/libxfs/xfs_log_recover.h b/fs/xfs/libxfs/xfs_log_recover.h
index 13583df9f239..52162a17fc5e 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -155,7 +155,7 @@ xlog_recover_resv(const struct xfs_trans_res *r)
 
 void xlog_recover_intent_item(struct xlog *log, struct xfs_log_item *lip,
 		xfs_lsn_t lsn, unsigned int dfp_type);
-void xlog_recover_transfer_intent(struct xfs_trans *tp,
+int xlog_recover_finish_intent(struct xfs_trans *tp,
 		struct xfs_defer_pending *dfp);
 
 #endif	/* __XFS_LOG_RECOVER_H__ */
diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index 8ed840c189cb..33e31d42d214 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -625,7 +625,6 @@ xfs_attri_item_recover(
 	struct xfs_attri_log_nameval	*nv = attrip->attri_nameval;
 	int				error;
 	int				total;
-	struct xfs_attrd_log_item	*done_item = NULL;
 
 	/*
 	 * First check the validity of the attr described by the ATTRI.  If any
@@ -651,27 +650,10 @@ xfs_attri_item_recover(
 		return error;
 	args->trans = tp;
 
-	done_item = xfs_trans_get_attrd(tp, attrip);
-	xlog_recover_transfer_intent(tp, dfp);
-
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_trans_ijoin(tp, ip, 0);
 
-	error = xfs_xattri_finish_update(attr, done_item);
-	if (error == -EAGAIN) {
-		/*
-		 * There's more work to do, so add the intent item to this
-		 * transaction so that we can continue it later.
-		 */
-		xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_ATTR, &attr->xattri_list);
-		error = xfs_defer_ops_capture_and_commit(tp, capture_list);
-		if (error)
-			goto out_unlock;
-
-		xfs_iunlock(ip, XFS_ILOCK_EXCL);
-		xfs_irele(ip);
-		return 0;
-	}
+	error = xlog_recover_finish_intent(tp, dfp);
 	if (error == -EFSCORRUPTED)
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 				&attrip->attri_format,
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index b65999bf0ea3..89f2d9e89607 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -497,6 +497,7 @@ xfs_bui_recover_work(
 	bi->bi_bmap.br_blockcount = map->me_len;
 	bi->bi_bmap.br_state = (map->me_flags & XFS_BMAP_EXTENT_UNWRITTEN) ?
 			XFS_EXT_UNWRITTEN : XFS_EXT_NORM;
+	xfs_bmap_update_get_group(mp, bi);
 
 	xfs_defer_add_item(dfp, &bi->bi_list);
 	return bi;
@@ -518,8 +519,7 @@ xfs_bui_item_recover(
 	struct xfs_inode		*ip = NULL;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_map_extent		*map;
-	struct xfs_bud_log_item		*budp;
-	struct xfs_bmap_intent		*fake;
+	struct xfs_bmap_intent		*work;
 	int				iext_delta;
 	int				error = 0;
 
@@ -530,7 +530,7 @@ xfs_bui_item_recover(
 	}
 
 	map = &buip->bui_format.bui_extents[0];
-	fake = xfs_bui_recover_work(mp, dfp, map);
+	work = xfs_bui_recover_work(mp, dfp, map);
 
 	error = xlog_recover_iget(mp, map->me_owner, &ip);
 	if (error)
@@ -543,39 +543,29 @@ xfs_bui_item_recover(
 	if (error)
 		goto err_rele;
 
-	budp = xfs_trans_get_bud(tp, buip);
-	xlog_recover_transfer_intent(tp, dfp);
-
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_trans_ijoin(tp, ip, 0);
 
-	if (fake->bi_type == XFS_BMAP_MAP)
+	if (work->bi_type == XFS_BMAP_MAP)
 		iext_delta = XFS_IEXT_ADD_NOSPLIT_CNT;
 	else
 		iext_delta = XFS_IEXT_PUNCH_HOLE_CNT;
 
-	error = xfs_iext_count_may_overflow(ip, fake->bi_whichfork, iext_delta);
+	error = xfs_iext_count_may_overflow(ip, work->bi_whichfork, iext_delta);
 	if (error == -EFBIG)
 		error = xfs_iext_count_upgrade(tp, ip, iext_delta);
 	if (error)
 		goto err_cancel;
 
-	fake->bi_owner = ip;
+	work->bi_owner = ip;
 
-	xfs_bmap_update_get_group(mp, fake);
-	error = xfs_trans_log_finish_bmap_update(tp, budp, fake);
+	error = xlog_recover_finish_intent(tp, dfp);
 	if (error == -EFSCORRUPTED)
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 				&buip->bui_format, sizeof(buip->bui_format));
-	xfs_bmap_update_put_group(fake);
 	if (error)
 		goto err_cancel;
 
-	if (fake->bi_bmap.br_blockcount > 0) {
-		ASSERT(fake->bi_type == XFS_BMAP_UNMAP);
-		xfs_bmap_unmap_extent(tp, ip, &fake->bi_bmap);
-	}
-
 	/*
 	 * Commit transaction, which frees the transaction and saves the inode
 	 * for later replay activities.
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 41108a0b60c9..6a434ade486c 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -665,6 +665,7 @@ xfs_efi_recover_work(
 	xefi->xefi_blockcount = extp->ext_len;
 	xefi->xefi_agresv = XFS_AG_RESV_NONE;
 	xefi->xefi_owner = XFS_RMAP_OWN_UNKNOWN;
+	xfs_extent_free_get_group(mp, xefi);
 
 	xfs_defer_add_item(dfp, &xefi->xefi_list);
 }
@@ -682,12 +683,9 @@ xfs_efi_item_recover(
 	struct xfs_log_item		*lip = dfp->dfp_intent;
 	struct xfs_efi_log_item		*efip = EFI_ITEM(lip);
 	struct xfs_mount		*mp = lip->li_log->l_mp;
-	struct xfs_efd_log_item		*efdp;
 	struct xfs_trans		*tp;
-	struct xfs_extent_free_item	*fake;
 	int				i;
 	int				error = 0;
-	bool				requeue_only = false;
 
 	/*
 	 * First check the validity of the extents described by the
@@ -711,40 +709,13 @@ xfs_efi_item_recover(
 	if (error)
 		return error;
 
-	efdp = xfs_trans_get_efd(tp, efip, efip->efi_format.efi_nextents);
-	xlog_recover_transfer_intent(tp, dfp);
-
-	list_for_each_entry(fake, &dfp->dfp_work, xefi_list) {
-		if (!requeue_only) {
-			xfs_extent_free_get_group(mp, fake);
-			error = xfs_trans_free_extent(tp, efdp, fake);
-			xfs_extent_free_put_group(fake);
-		}
-
-		/*
-		 * If we can't free the extent without potentially deadlocking,
-		 * requeue the rest of the extents to a new so that they get
-		 * run again later with a new transaction context.
-		 */
-		if (error == -EAGAIN || requeue_only) {
-			error = xfs_free_extent_later(tp, fake->xefi_startblock,
-					fake->xefi_blockcount,
-					&XFS_RMAP_OINFO_ANY_OWNER,
-					fake->xefi_agresv);
-			if (!error) {
-				requeue_only = true;
-				continue;
-			}
-		}
-
-		if (error == -EFSCORRUPTED)
-			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
-					&efip->efi_format,
-					sizeof(efip->efi_format));
-		if (error)
-			goto abort_error;
-
-	}
+	error = xlog_recover_finish_intent(tp, dfp);
+	if (error == -EFSCORRUPTED)
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+				&efip->efi_format,
+				sizeof(efip->efi_format));
+	if (error)
+		goto abort_error;
 
 	return xfs_defer_ops_capture_and_commit(tp, capture_list);
 
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 60382eb49961..92bf97a6e108 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2584,7 +2584,8 @@ xlog_recover_process_intents(
 		 * replayed in the wrong order!
 		 *
 		 * The recovery function can free the log item, so we must not
-		 * access lip after it returns.
+		 * access lip after it returns.  It must dispose of @dfp if it
+		 * returns 0.
 		 */
 		error = ops->iop_recover(dfp, &capture_list);
 		if (error) {
@@ -2592,8 +2593,6 @@ xlog_recover_process_intents(
 					ops->iop_recover);
 			break;
 		}
-
-		xfs_defer_cancel_recovery(log->l_mp, dfp);
 	}
 	if (error)
 		goto err;
@@ -2627,15 +2626,22 @@ xlog_recover_cancel_intents(
 }
 
 /*
- * Transfer ownership of the recovered log intent item to the recovery
- * transaction.
+ * Transfer ownership of the recovered pending work to the recovery transaction
+ * and try to finish the work.  If there is more work to be done, the dfp will
+ * remain attached to the transaction.  If not, the dfp is freed.
  */
-void
-xlog_recover_transfer_intent(
+int
+xlog_recover_finish_intent(
 	struct xfs_trans		*tp,
 	struct xfs_defer_pending	*dfp)
 {
-	dfp->dfp_intent = NULL;
+	int				error;
+
+	list_move(&dfp->dfp_list, &tp->t_dfops);
+	error = xfs_defer_finish_one(tp, dfp);
+	if (error == -EAGAIN)
+		return 0;
+	return error;
 }
 
 /*
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index 4ffc34e6f0a0..f561ca73c784 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -481,6 +481,7 @@ xfs_cui_recover_work(
 	ri->ri_type = pmap->pe_flags & XFS_REFCOUNT_EXTENT_TYPE_MASK;
 	ri->ri_startblock = pmap->pe_startblock;
 	ri->ri_blockcount = pmap->pe_len;
+	xfs_refcount_update_get_group(mp, ri);
 
 	xfs_defer_add_item(dfp, &ri->ri_list);
 }
@@ -497,12 +498,8 @@ xfs_cui_item_recover(
 	struct xfs_trans_res		resv;
 	struct xfs_log_item		*lip = dfp->dfp_intent;
 	struct xfs_cui_log_item		*cuip = CUI_ITEM(lip);
-	struct xfs_cud_log_item		*cudp;
 	struct xfs_trans		*tp;
-	struct xfs_btree_cur		*rcur = NULL;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
-	struct xfs_refcount_intent	*fake;
-	bool				requeue_only = false;
 	int				i;
 	int				error = 0;
 
@@ -541,59 +538,17 @@ xfs_cui_item_recover(
 	if (error)
 		return error;
 
-	cudp = xfs_trans_get_cud(tp, cuip);
-	xlog_recover_transfer_intent(tp, dfp);
-
-	list_for_each_entry(fake, &dfp->dfp_work, ri_list) {
-		if (!requeue_only) {
-			xfs_refcount_update_get_group(mp, fake);
-			error = xfs_trans_log_finish_refcount_update(tp, cudp,
-					fake, &rcur);
-			xfs_refcount_update_put_group(fake);
-		}
-		if (error == -EFSCORRUPTED)
-			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
-					&cuip->cui_format,
-					sizeof(cuip->cui_format));
-		if (error)
-			goto abort_error;
-
-		/* Requeue what we didn't finish. */
-		if (fake->ri_blockcount > 0) {
-			struct xfs_bmbt_irec	irec = {
-				.br_startblock	= fake->ri_startblock,
-				.br_blockcount	= fake->ri_blockcount,
-			};
-
-			switch (fake->ri_type) {
-			case XFS_REFCOUNT_INCREASE:
-				xfs_refcount_increase_extent(tp, &irec);
-				break;
-			case XFS_REFCOUNT_DECREASE:
-				xfs_refcount_decrease_extent(tp, &irec);
-				break;
-			case XFS_REFCOUNT_ALLOC_COW:
-				xfs_refcount_alloc_cow_extent(tp,
-						irec.br_startblock,
-						irec.br_blockcount);
-				break;
-			case XFS_REFCOUNT_FREE_COW:
-				xfs_refcount_free_cow_extent(tp,
-						irec.br_startblock,
-						irec.br_blockcount);
-				break;
-			default:
-				ASSERT(0);
-			}
-			requeue_only = true;
-		}
-	}
+	error = xlog_recover_finish_intent(tp, dfp);
+	if (error == -EFSCORRUPTED)
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+				&cuip->cui_format,
+				sizeof(cuip->cui_format));
+	if (error)
+		goto abort_error;
 
-	xfs_refcount_finish_one_cleanup(tp, rcur, error);
 	return xfs_defer_ops_capture_and_commit(tp, capture_list);
 
 abort_error:
-	xfs_refcount_finish_one_cleanup(tp, rcur, error);
 	xfs_trans_cancel(tp);
 	return error;
 }
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 9fb3ae4bfd59..23e736179894 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -546,6 +546,7 @@ xfs_rui_recover_work(
 	ri->ri_bmap.br_blockcount = map->me_len;
 	ri->ri_bmap.br_state = (map->me_flags & XFS_RMAP_EXTENT_UNWRITTEN) ?
 			XFS_EXT_UNWRITTEN : XFS_EXT_NORM;
+	xfs_rmap_update_get_group(mp, ri);
 
 	xfs_defer_add_item(dfp, &ri->ri_list);
 }
@@ -562,11 +563,8 @@ xfs_rui_item_recover(
 	struct xfs_trans_res		resv;
 	struct xfs_log_item		*lip = dfp->dfp_intent;
 	struct xfs_rui_log_item		*ruip = RUI_ITEM(lip);
-	struct xfs_rud_log_item		*rudp;
 	struct xfs_trans		*tp;
-	struct xfs_btree_cur		*rcur = NULL;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
-	struct xfs_rmap_intent		*fake;
 	int				i;
 	int				error = 0;
 
@@ -593,28 +591,17 @@ xfs_rui_item_recover(
 	if (error)
 		return error;
 
-	rudp = xfs_trans_get_rud(tp, ruip);
-	xlog_recover_transfer_intent(tp, dfp);
-
-	list_for_each_entry(fake, &dfp->dfp_work, ri_list) {
-		xfs_rmap_update_get_group(mp, fake);
-		error = xfs_trans_log_finish_rmap_update(tp, rudp, fake,
-				&rcur);
-		if (error == -EFSCORRUPTED)
-			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
-					&ruip->rui_format,
-					sizeof(ruip->rui_format));
-		xfs_rmap_update_put_group(fake);
-		if (error)
-			goto abort_error;
-
-	}
+	error = xlog_recover_finish_intent(tp, dfp);
+	if (error == -EFSCORRUPTED)
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+				&ruip->rui_format,
+				sizeof(ruip->rui_format));
+	if (error)
+		goto abort_error;
 
-	xfs_rmap_finish_one_cleanup(tp, rcur, error);
 	return xfs_defer_ops_capture_and_commit(tp, capture_list);
 
 abort_error:
-	xfs_rmap_finish_one_cleanup(tp, rcur, error);
 	xfs_trans_cancel(tp);
 	return error;
 }
-- 
2.49.0


