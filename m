Return-Path: <stable+bounces-125809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 823FDA6CA9C
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 15:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91798482BE9
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 14:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E022541C;
	Sat, 22 Mar 2025 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="f7lNmNEv"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83520A5C2
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654075; cv=none; b=TLSzpITtromG1UcrqdVFcZLkPDkoPdR92ypPjlD3JaDYHGyJup8kwAeubf9/0B7jbkRONQxV47sMSIqG0Q6zjYborFueOJTd+YZT1eTdOGDrQvfN8bTVI0XDuHMlV9I05yUeWHYpekwbyyeKgYuHHgb6HMbGF0Lelevo0fCn+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654075; c=relaxed/simple;
	bh=BqR6zQToEqIwEiSJpCGMu7K8O9jPhh9LycH1NqLCLzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5MbdTRbLY/czwXsev4rPMSyTjS/9dg0zFgZnQOuEjpsI20pKp6eojZjii41UE8fbsm8lB4o4+ZBhcEiRz1qsPaHmeUOzx+57kFMTyk0ng8Y6zxPLylNLTbIfdHjdt2rXaNLuYEPGsNl0iiNvtcrU88uQdepzPAurcJc5HMjcDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=f7lNmNEv; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2BC93407619E;
	Sat, 22 Mar 2025 14:34:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2BC93407619E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1742654071;
	bh=CE65I93BbGVbqycNXN1EBB6SALtTd3y0xQjC5qdb9Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f7lNmNEvDkIuti7p/PFbhiKyvc/WedhE1QwwtwutdzJtVkHeEJecGL9tBifQ8vK0p
	 GcyXfP7WEeinI5XM34vmdwFFi3wycxmocyznyhCmoulMq5eMvW4WHajIMkOWAj4mMe
	 u4tzXRfQx6vWXPNw9BNmyQxrbMPI8+pN43u1GwTE=
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
Subject: [PATCH 6.6 4/4] xfs: move ->iop_recover to xfs_defer_op_type
Date: Sat, 22 Mar 2025 17:34:15 +0300
Message-ID: <20250322143418.216654-5-pchelkin@ispras.ru>
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

commit db7ccc0bac2add5a41b66578e376b49328fc99d0 upstream.

Finish off the series by moving the intent item recovery function
pointer to the xfs_defer_op_type struct, since this is really a deferred
work function now.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 fs/xfs/libxfs/xfs_defer.c       | 17 +++++++++++++
 fs/xfs/libxfs/xfs_defer.h       |  4 +++
 fs/xfs/libxfs/xfs_log_recover.h |  2 ++
 fs/xfs/xfs_attr_item.c          | 21 +++++++++-------
 fs/xfs/xfs_bmap_item.c          | 39 ++++++++++++++++--------------
 fs/xfs/xfs_extfree_item.c       | 43 +++++++++++++++++----------------
 fs/xfs/xfs_log_recover.c        | 19 ++++++---------
 fs/xfs/xfs_refcount_item.c      | 24 +++++++++---------
 fs/xfs/xfs_rmap_item.c          | 24 +++++++++---------
 fs/xfs/xfs_trans.h              |  4 ---
 10 files changed, 109 insertions(+), 88 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index eb262ea06122..dd565e4e3daf 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -713,6 +713,23 @@ xfs_defer_cancel_recovery(
 	xfs_defer_pending_cancel_work(mp, dfp);
 }
 
+/* Replay the deferred work item created from a recovered log intent item. */
+int
+xfs_defer_finish_recovery(
+	struct xfs_mount		*mp,
+	struct xfs_defer_pending	*dfp,
+	struct list_head		*capture_list)
+{
+	const struct xfs_defer_op_type	*ops = defer_op_types[dfp->dfp_type];
+	int				error;
+
+	error = ops->recover_work(dfp, capture_list);
+	if (error)
+		trace_xlog_intent_recovery_failed(mp, error,
+				ops->recover_work);
+	return error;
+}
+
 /*
  * Move deferred ops from one transaction to another and reset the source to
  * initial state. This is primarily used to carry state forward across
diff --git a/fs/xfs/libxfs/xfs_defer.h b/fs/xfs/libxfs/xfs_defer.h
index c1a648e99174..ef86a7f9b059 100644
--- a/fs/xfs/libxfs/xfs_defer.h
+++ b/fs/xfs/libxfs/xfs_defer.h
@@ -57,6 +57,8 @@ struct xfs_defer_op_type {
 	void (*finish_cleanup)(struct xfs_trans *tp,
 			struct xfs_btree_cur *state, int error);
 	void (*cancel_item)(struct list_head *item);
+	int (*recover_work)(struct xfs_defer_pending *dfp,
+			    struct list_head *capture_list);
 	unsigned int		max_items;
 };
 
@@ -130,6 +132,8 @@ void xfs_defer_start_recovery(struct xfs_log_item *lip,
 		enum xfs_defer_ops_type dfp_type, struct list_head *r_dfops);
 void xfs_defer_cancel_recovery(struct xfs_mount *mp,
 		struct xfs_defer_pending *dfp);
+int xfs_defer_finish_recovery(struct xfs_mount *mp,
+		struct xfs_defer_pending *dfp, struct list_head *capture_list);
 
 static inline void
 xfs_defer_add_item(
diff --git a/fs/xfs/libxfs/xfs_log_recover.h b/fs/xfs/libxfs/xfs_log_recover.h
index 52162a17fc5e..c8e5d912895b 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -153,6 +153,8 @@ xlog_recover_resv(const struct xfs_trans_res *r)
 	return ret;
 }
 
+struct xfs_defer_pending;
+
 void xlog_recover_intent_item(struct xlog *log, struct xfs_log_item *lip,
 		xfs_lsn_t lsn, unsigned int dfp_type);
 int xlog_recover_finish_intent(struct xfs_trans *tp,
diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index 33e31d42d214..d539abdb54c2 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -551,12 +551,17 @@ xfs_attri_recover_work(
 	struct xfs_mount		*mp,
 	struct xfs_defer_pending	*dfp,
 	struct xfs_attri_log_format	*attrp,
-	struct xfs_inode		*ip,
+	struct xfs_inode		**ipp,
 	struct xfs_attri_log_nameval	*nv)
 {
 	struct xfs_attr_intent		*attr;
 	struct xfs_da_args		*args;
 	int				local;
+	int				error;
+
+	error = xlog_recover_iget(mp,  attrp->alfi_ino, ipp);
+	if (error)
+		return ERR_PTR(error);
 
 	attr = kmem_zalloc(sizeof(struct xfs_attr_intent) +
 			   sizeof(struct xfs_da_args), KM_NOFS);
@@ -574,7 +579,7 @@ xfs_attri_recover_work(
 	attr->xattri_nameval = xfs_attri_log_nameval_get(nv);
 	ASSERT(attr->xattri_nameval);
 
-	args->dp = ip;
+	args->dp = *ipp;
 	args->geo = mp->m_attr_geo;
 	args->whichfork = XFS_ATTR_FORK;
 	args->name = nv->name.i_addr;
@@ -609,7 +614,7 @@ xfs_attri_recover_work(
  * delete the attr that it describes.
  */
 STATIC int
-xfs_attri_item_recover(
+xfs_attr_recover_work(
 	struct xfs_defer_pending	*dfp,
 	struct list_head		*capture_list)
 {
@@ -636,11 +641,9 @@ xfs_attri_item_recover(
 				nv->name.i_len))
 		return -EFSCORRUPTED;
 
-	error = xlog_recover_iget(mp,  attrp->alfi_ino, &ip);
-	if (error)
-		return error;
-
-	attr = xfs_attri_recover_work(mp, dfp, attrp, ip, nv);
+	attr = xfs_attri_recover_work(mp, dfp, attrp, &ip, nv);
+	if (IS_ERR(attr))
+		return PTR_ERR(attr);
 	args = attr->xattri_da_args;
 
 	xfs_init_attr_trans(args, &resv, &total);
@@ -890,6 +893,7 @@ const struct xfs_defer_op_type xfs_attr_defer_type = {
 	.create_done	= xfs_attr_create_done,
 	.finish_item	= xfs_attr_finish_item,
 	.cancel_item	= xfs_attr_cancel_item,
+	.recover_work	= xfs_attr_recover_work,
 };
 
 /*
@@ -926,7 +930,6 @@ static const struct xfs_item_ops xfs_attri_item_ops = {
 	.iop_format	= xfs_attri_item_format,
 	.iop_unpin	= xfs_attri_item_unpin,
 	.iop_release    = xfs_attri_item_release,
-	.iop_recover	= xfs_attri_item_recover,
 	.iop_match	= xfs_attri_item_match,
 	.iop_relog	= xfs_attri_item_relog,
 };
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 89f2d9e89607..bd8f6fe22b40 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -437,15 +437,6 @@ xfs_bmap_update_cancel_item(
 	kmem_cache_free(xfs_bmap_intent_cache, bi);
 }
 
-const struct xfs_defer_op_type xfs_bmap_update_defer_type = {
-	.max_items	= XFS_BUI_MAX_FAST_EXTENTS,
-	.create_intent	= xfs_bmap_update_create_intent,
-	.abort_intent	= xfs_bmap_update_abort_intent,
-	.create_done	= xfs_bmap_update_create_done,
-	.finish_item	= xfs_bmap_update_finish_item,
-	.cancel_item	= xfs_bmap_update_cancel_item,
-};
-
 /* Is this recovered BUI ok? */
 static inline bool
 xfs_bui_validate(
@@ -484,9 +475,15 @@ static inline struct xfs_bmap_intent *
 xfs_bui_recover_work(
 	struct xfs_mount		*mp,
 	struct xfs_defer_pending	*dfp,
+	struct xfs_inode		**ipp,
 	struct xfs_map_extent		*map)
 {
 	struct xfs_bmap_intent		*bi;
+	int				error;
+
+	error = xlog_recover_iget(mp, map->me_owner, ipp);
+	if (error)
+		return ERR_PTR(error);
 
 	bi = kmem_cache_zalloc(xfs_bmap_intent_cache, GFP_NOFS | __GFP_NOFAIL);
 	bi->bi_whichfork = (map->me_flags & XFS_BMAP_EXTENT_ATTR_FORK) ?
@@ -497,6 +494,7 @@ xfs_bui_recover_work(
 	bi->bi_bmap.br_blockcount = map->me_len;
 	bi->bi_bmap.br_state = (map->me_flags & XFS_BMAP_EXTENT_UNWRITTEN) ?
 			XFS_EXT_UNWRITTEN : XFS_EXT_NORM;
+	bi->bi_owner = *ipp;
 	xfs_bmap_update_get_group(mp, bi);
 
 	xfs_defer_add_item(dfp, &bi->bi_list);
@@ -508,7 +506,7 @@ xfs_bui_recover_work(
  * We need to update some inode's bmbt.
  */
 STATIC int
-xfs_bui_item_recover(
+xfs_bmap_recover_work(
 	struct xfs_defer_pending	*dfp,
 	struct list_head		*capture_list)
 {
@@ -530,11 +528,9 @@ xfs_bui_item_recover(
 	}
 
 	map = &buip->bui_format.bui_extents[0];
-	work = xfs_bui_recover_work(mp, dfp, map);
-
-	error = xlog_recover_iget(mp, map->me_owner, &ip);
-	if (error)
-		return error;
+	work = xfs_bui_recover_work(mp, dfp, &ip, map);
+	if (IS_ERR(work))
+		return PTR_ERR(work);
 
 	/* Allocate transaction and do the work. */
 	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
@@ -557,8 +553,6 @@ xfs_bui_item_recover(
 	if (error)
 		goto err_cancel;
 
-	work->bi_owner = ip;
-
 	error = xlog_recover_finish_intent(tp, dfp);
 	if (error == -EFSCORRUPTED)
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
@@ -587,6 +581,16 @@ xfs_bui_item_recover(
 	return error;
 }
 
+const struct xfs_defer_op_type xfs_bmap_update_defer_type = {
+	.max_items	= XFS_BUI_MAX_FAST_EXTENTS,
+	.create_intent	= xfs_bmap_update_create_intent,
+	.abort_intent	= xfs_bmap_update_abort_intent,
+	.create_done	= xfs_bmap_update_create_done,
+	.finish_item	= xfs_bmap_update_finish_item,
+	.cancel_item	= xfs_bmap_update_cancel_item,
+	.recover_work	= xfs_bmap_recover_work,
+};
+
 STATIC bool
 xfs_bui_item_match(
 	struct xfs_log_item	*lip,
@@ -627,7 +631,6 @@ static const struct xfs_item_ops xfs_bui_item_ops = {
 	.iop_format	= xfs_bui_item_format,
 	.iop_unpin	= xfs_bui_item_unpin,
 	.iop_release	= xfs_bui_item_release,
-	.iop_recover	= xfs_bui_item_recover,
 	.iop_match	= xfs_bui_item_match,
 	.iop_relog	= xfs_bui_item_relog,
 };
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 6a434ade486c..49e96ffd64e0 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -567,15 +567,6 @@ xfs_extent_free_cancel_item(
 	kmem_cache_free(xfs_extfree_item_cache, xefi);
 }
 
-const struct xfs_defer_op_type xfs_extent_free_defer_type = {
-	.max_items	= XFS_EFI_MAX_FAST_EXTENTS,
-	.create_intent	= xfs_extent_free_create_intent,
-	.abort_intent	= xfs_extent_free_abort_intent,
-	.create_done	= xfs_extent_free_create_done,
-	.finish_item	= xfs_extent_free_finish_item,
-	.cancel_item	= xfs_extent_free_cancel_item,
-};
-
 /*
  * AGFL blocks are accounted differently in the reserve pools and are not
  * inserted into the busy extent list.
@@ -632,16 +623,6 @@ xfs_agfl_free_finish_item(
 	return error;
 }
 
-/* sub-type with special handling for AGFL deferred frees */
-const struct xfs_defer_op_type xfs_agfl_free_defer_type = {
-	.max_items	= XFS_EFI_MAX_FAST_EXTENTS,
-	.create_intent	= xfs_extent_free_create_intent,
-	.abort_intent	= xfs_extent_free_abort_intent,
-	.create_done	= xfs_extent_free_create_done,
-	.finish_item	= xfs_agfl_free_finish_item,
-	.cancel_item	= xfs_extent_free_cancel_item,
-};
-
 /* Is this recovered EFI ok? */
 static inline bool
 xfs_efi_validate_ext(
@@ -675,7 +656,7 @@ xfs_efi_recover_work(
  * the log.  We need to free the extents that it describes.
  */
 STATIC int
-xfs_efi_item_recover(
+xfs_extent_free_recover_work(
 	struct xfs_defer_pending	*dfp,
 	struct list_head		*capture_list)
 {
@@ -724,6 +705,27 @@ xfs_efi_item_recover(
 	return error;
 }
 
+const struct xfs_defer_op_type xfs_extent_free_defer_type = {
+	.max_items	= XFS_EFI_MAX_FAST_EXTENTS,
+	.create_intent	= xfs_extent_free_create_intent,
+	.abort_intent	= xfs_extent_free_abort_intent,
+	.create_done	= xfs_extent_free_create_done,
+	.finish_item	= xfs_extent_free_finish_item,
+	.cancel_item	= xfs_extent_free_cancel_item,
+	.recover_work	= xfs_extent_free_recover_work,
+};
+
+/* sub-type with special handling for AGFL deferred frees */
+const struct xfs_defer_op_type xfs_agfl_free_defer_type = {
+	.max_items	= XFS_EFI_MAX_FAST_EXTENTS,
+	.create_intent	= xfs_extent_free_create_intent,
+	.abort_intent	= xfs_extent_free_abort_intent,
+	.create_done	= xfs_extent_free_create_done,
+	.finish_item	= xfs_agfl_free_finish_item,
+	.cancel_item	= xfs_extent_free_cancel_item,
+	.recover_work	= xfs_extent_free_recover_work,
+};
+
 STATIC bool
 xfs_efi_item_match(
 	struct xfs_log_item	*lip,
@@ -766,7 +768,6 @@ static const struct xfs_item_ops xfs_efi_item_ops = {
 	.iop_format	= xfs_efi_item_format,
 	.iop_unpin	= xfs_efi_item_unpin,
 	.iop_release	= xfs_efi_item_release,
-	.iop_recover	= xfs_efi_item_recover,
 	.iop_match	= xfs_efi_item_match,
 	.iop_relog	= xfs_efi_item_relog,
 };
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 92bf97a6e108..3f343ba36b09 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2565,17 +2565,14 @@ xlog_recover_process_intents(
 #endif
 
 	list_for_each_entry_safe(dfp, n, &log->r_dfops, dfp_list) {
-		struct xfs_log_item	*lip = dfp->dfp_intent;
-		const struct xfs_item_ops *ops = lip->li_ops;
-
-		ASSERT(xlog_item_is_intent(lip));
+		ASSERT(xlog_item_is_intent(dfp->dfp_intent));
 
 		/*
 		 * We should never see a redo item with a LSN higher than
 		 * the last transaction we found in the log at the start
 		 * of recovery.
 		 */
-		ASSERT(XFS_LSN_CMP(last_lsn, lip->li_lsn) >= 0);
+		ASSERT(XFS_LSN_CMP(last_lsn, dfp->dfp_intent->li_lsn) >= 0);
 
 		/*
 		 * NOTE: If your intent processing routine can create more
@@ -2584,15 +2581,13 @@ xlog_recover_process_intents(
 		 * replayed in the wrong order!
 		 *
 		 * The recovery function can free the log item, so we must not
-		 * access lip after it returns.  It must dispose of @dfp if it
-		 * returns 0.
+		 * access dfp->dfp_intent after it returns.  It must dispose of
+		 * @dfp if it returns 0.
 		 */
-		error = ops->iop_recover(dfp, &capture_list);
-		if (error) {
-			trace_xlog_intent_recovery_failed(log->l_mp, error,
-					ops->iop_recover);
+		error = xfs_defer_finish_recovery(log->l_mp, dfp,
+				&capture_list);
+		if (error)
 			break;
-		}
 	}
 	if (error)
 		goto err;
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index f561ca73c784..48f1a38b272e 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -433,16 +433,6 @@ xfs_refcount_update_cancel_item(
 	kmem_cache_free(xfs_refcount_intent_cache, ri);
 }
 
-const struct xfs_defer_op_type xfs_refcount_update_defer_type = {
-	.max_items	= XFS_CUI_MAX_FAST_EXTENTS,
-	.create_intent	= xfs_refcount_update_create_intent,
-	.abort_intent	= xfs_refcount_update_abort_intent,
-	.create_done	= xfs_refcount_update_create_done,
-	.finish_item	= xfs_refcount_update_finish_item,
-	.finish_cleanup = xfs_refcount_finish_one_cleanup,
-	.cancel_item	= xfs_refcount_update_cancel_item,
-};
-
 /* Is this recovered CUI ok? */
 static inline bool
 xfs_cui_validate_phys(
@@ -491,7 +481,7 @@ xfs_cui_recover_work(
  * We need to update the refcountbt.
  */
 STATIC int
-xfs_cui_item_recover(
+xfs_refcount_recover_work(
 	struct xfs_defer_pending	*dfp,
 	struct list_head		*capture_list)
 {
@@ -553,6 +543,17 @@ xfs_cui_item_recover(
 	return error;
 }
 
+const struct xfs_defer_op_type xfs_refcount_update_defer_type = {
+	.max_items	= XFS_CUI_MAX_FAST_EXTENTS,
+	.create_intent	= xfs_refcount_update_create_intent,
+	.abort_intent	= xfs_refcount_update_abort_intent,
+	.create_done	= xfs_refcount_update_create_done,
+	.finish_item	= xfs_refcount_update_finish_item,
+	.finish_cleanup = xfs_refcount_finish_one_cleanup,
+	.cancel_item	= xfs_refcount_update_cancel_item,
+	.recover_work	= xfs_refcount_recover_work,
+};
+
 STATIC bool
 xfs_cui_item_match(
 	struct xfs_log_item	*lip,
@@ -593,7 +594,6 @@ static const struct xfs_item_ops xfs_cui_item_ops = {
 	.iop_format	= xfs_cui_item_format,
 	.iop_unpin	= xfs_cui_item_unpin,
 	.iop_release	= xfs_cui_item_release,
-	.iop_recover	= xfs_cui_item_recover,
 	.iop_match	= xfs_cui_item_match,
 	.iop_relog	= xfs_cui_item_relog,
 };
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 23e736179894..23684bc2ab85 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -452,16 +452,6 @@ xfs_rmap_update_cancel_item(
 	kmem_cache_free(xfs_rmap_intent_cache, ri);
 }
 
-const struct xfs_defer_op_type xfs_rmap_update_defer_type = {
-	.max_items	= XFS_RUI_MAX_FAST_EXTENTS,
-	.create_intent	= xfs_rmap_update_create_intent,
-	.abort_intent	= xfs_rmap_update_abort_intent,
-	.create_done	= xfs_rmap_update_create_done,
-	.finish_item	= xfs_rmap_update_finish_item,
-	.finish_cleanup = xfs_rmap_finish_one_cleanup,
-	.cancel_item	= xfs_rmap_update_cancel_item,
-};
-
 /* Is this recovered RUI ok? */
 static inline bool
 xfs_rui_validate_map(
@@ -556,7 +546,7 @@ xfs_rui_recover_work(
  * We need to update the rmapbt.
  */
 STATIC int
-xfs_rui_item_recover(
+xfs_rmap_recover_work(
 	struct xfs_defer_pending	*dfp,
 	struct list_head		*capture_list)
 {
@@ -606,6 +596,17 @@ xfs_rui_item_recover(
 	return error;
 }
 
+const struct xfs_defer_op_type xfs_rmap_update_defer_type = {
+	.max_items	= XFS_RUI_MAX_FAST_EXTENTS,
+	.create_intent	= xfs_rmap_update_create_intent,
+	.abort_intent	= xfs_rmap_update_abort_intent,
+	.create_done	= xfs_rmap_update_create_done,
+	.finish_item	= xfs_rmap_update_finish_item,
+	.finish_cleanup = xfs_rmap_finish_one_cleanup,
+	.cancel_item	= xfs_rmap_update_cancel_item,
+	.recover_work	= xfs_rmap_recover_work,
+};
+
 STATIC bool
 xfs_rui_item_match(
 	struct xfs_log_item	*lip,
@@ -646,7 +647,6 @@ static const struct xfs_item_ops xfs_rui_item_ops = {
 	.iop_format	= xfs_rui_item_format,
 	.iop_unpin	= xfs_rui_item_unpin,
 	.iop_release	= xfs_rui_item_release,
-	.iop_recover	= xfs_rui_item_recover,
 	.iop_match	= xfs_rui_item_match,
 	.iop_relog	= xfs_rui_item_relog,
 };
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index ead65f5f8dc3..ae32ffe9a1b1 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -66,8 +66,6 @@ struct xfs_log_item {
 	{ (1u << XFS_LI_DIRTY),		"DIRTY" }, \
 	{ (1u << XFS_LI_WHITEOUT),	"WHITEOUT" }
 
-struct xfs_defer_pending;
-
 struct xfs_item_ops {
 	unsigned flags;
 	void (*iop_size)(struct xfs_log_item *, int *, int *);
@@ -80,8 +78,6 @@ struct xfs_item_ops {
 	xfs_lsn_t (*iop_committed)(struct xfs_log_item *, xfs_lsn_t);
 	uint (*iop_push)(struct xfs_log_item *, struct list_head *);
 	void (*iop_release)(struct xfs_log_item *);
-	int (*iop_recover)(struct xfs_defer_pending *dfp,
-			   struct list_head *capture_list);
 	bool (*iop_match)(struct xfs_log_item *item, uint64_t id);
 	struct xfs_log_item *(*iop_relog)(struct xfs_log_item *intent,
 			struct xfs_trans *tp);
-- 
2.49.0


