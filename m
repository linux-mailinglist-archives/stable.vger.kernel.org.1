Return-Path: <stable+bounces-125807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90ACA6CA9B
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 15:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3B01B6549F
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54702224AEE;
	Sat, 22 Mar 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="U/xe39OH"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F041F462C
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654073; cv=none; b=i7QQUrwOWuiClpZJVUipkWSF9oqfU8td/Ullhtow5kPH8ai3S4ZKlE8r4DJRIpu9KzKi+msFRg9twAFTDkYK/3dZ6/Z1F1QVN5xv2PJhFK07FDEedVC7HZOMzhviPh6jO36lByPPyFrrcu8q7Vd0wAc5rqTdF3cmQe/q+hXaf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654073; c=relaxed/simple;
	bh=UubtPHE4TBbQHwZt4gHFQrmMsACbTlVF2hxLw6/SrpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFjeXQKCacAXBhEDSZf1fHUJuejnnsxqzGIsHrRdk/DiLon5ZB6pPbJZCAVf6lX14yuu5+oGvAqPd5WCbQECfe3op5NRuVHqc2TPA/o/Lgd65UcXGUv1fPk/k7NFiY/LhdN8s+henfQaAASLfT7BDqxHC+55IZO55TBG/K25cv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=U/xe39OH; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id C46E6407617D;
	Sat, 22 Mar 2025 14:34:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C46E6407617D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1742654068;
	bh=hCaggSib9D6+mU+ovKQOdiAZaEdXyFaJQRcQLm8rcqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/xe39OHqCKBelFF9PAt7AH6nMeDo8g7/Uuq0gdozXpZBWnVRR7ndKBnrY53gnLGQ
	 WBD2UyjSEq95RRuG+vuLptTDOxdc5GJn6MGolITwEOpkDLDOfNEtvuKQ3cAPiYNzO3
	 k6JnYSs3TSZY7Ikw2l6/9wVBDDHCZisRFFIpLnX4=
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
Subject: [PATCH 6.6 1/4] xfs: recreate work items when recovering intent items
Date: Sat, 22 Mar 2025 17:34:12 +0300
Message-ID: <20250322143418.216654-2-pchelkin@ispras.ru>
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

commit e70fb328d5277297ea2d9169a3a046de6412d777 upstream.

Recreate work items for each xfs_defer_pending object when we are
recovering intent items.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
[ fp: fix conflict in calling xfs_attr_namecheck() with 2 args instead
  of 3 due to backported ea0b3e814741 ("xfs: enforce one namespace per
  attribute") ]
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 fs/xfs/libxfs/xfs_defer.c  |   3 +-
 fs/xfs/libxfs/xfs_defer.h  |   9 +++
 fs/xfs/xfs_attr_item.c     |  92 +++++++++++++++++-------------
 fs/xfs/xfs_bmap_item.c     |  55 +++++++++++-------
 fs/xfs/xfs_extfree_item.c  |  49 +++++++++-------
 fs/xfs/xfs_refcount_item.c |  60 ++++++++++----------
 fs/xfs/xfs_rmap_item.c     | 112 ++++++++++++++++++++-----------------
 7 files changed, 216 insertions(+), 164 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index 363da37a8e7f..8fb523e4f669 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -676,9 +676,8 @@ xfs_defer_add(
 		list_add_tail(&dfp->dfp_list, &tp->t_dfops);
 	}
 
-	list_add_tail(li, &dfp->dfp_work);
+	xfs_defer_add_item(dfp, li);
 	trace_xfs_defer_add_item(tp->t_mountp, dfp, li);
-	dfp->dfp_count++;
 }
 
 /*
diff --git a/fs/xfs/libxfs/xfs_defer.h b/fs/xfs/libxfs/xfs_defer.h
index 5dce938ba3d5..bef5823f61fb 100644
--- a/fs/xfs/libxfs/xfs_defer.h
+++ b/fs/xfs/libxfs/xfs_defer.h
@@ -130,6 +130,15 @@ void xfs_defer_start_recovery(struct xfs_log_item *lip,
 void xfs_defer_cancel_recovery(struct xfs_mount *mp,
 		struct xfs_defer_pending *dfp);
 
+static inline void
+xfs_defer_add_item(
+	struct xfs_defer_pending	*dfp,
+	struct list_head		*work)
+{
+	list_add_tail(work, &dfp->dfp_work);
+	dfp->dfp_count++;
+}
+
 int __init xfs_defer_init_item_caches(void);
 void xfs_defer_destroy_item_caches(void);
 
diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index df86c9c09720..2b73132fa607 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -546,43 +546,17 @@ xfs_attri_validate(
 	return xfs_verify_ino(mp, attrp->alfi_ino);
 }
 
-/*
- * Process an attr intent item that was recovered from the log.  We need to
- * delete the attr that it describes.
- */
-STATIC int
-xfs_attri_item_recover(
+static inline struct xfs_attr_intent *
+xfs_attri_recover_work(
+	struct xfs_mount		*mp,
 	struct xfs_defer_pending	*dfp,
-	struct list_head		*capture_list)
+	struct xfs_attri_log_format	*attrp,
+	struct xfs_inode		*ip,
+	struct xfs_attri_log_nameval	*nv)
 {
-	struct xfs_log_item		*lip = dfp->dfp_intent;
-	struct xfs_attri_log_item	*attrip = ATTRI_ITEM(lip);
 	struct xfs_attr_intent		*attr;
-	struct xfs_mount		*mp = lip->li_log->l_mp;
-	struct xfs_inode		*ip;
 	struct xfs_da_args		*args;
-	struct xfs_trans		*tp;
-	struct xfs_trans_res		resv;
-	struct xfs_attri_log_format	*attrp;
-	struct xfs_attri_log_nameval	*nv = attrip->attri_nameval;
-	int				error;
-	int				total;
 	int				local;
-	struct xfs_attrd_log_item	*done_item = NULL;
-
-	/*
-	 * First check the validity of the attr described by the ATTRI.  If any
-	 * are bad, then assume that all are bad and just toss the ATTRI.
-	 */
-	attrp = &attrip->attri_format;
-	if (!xfs_attri_validate(mp, attrp) ||
-	    !xfs_attr_namecheck(attrp->alfi_attr_filter, nv->name.i_addr,
-				nv->name.i_len))
-		return -EFSCORRUPTED;
-
-	error = xlog_recover_iget(mp,  attrp->alfi_ino, &ip);
-	if (error)
-		return error;
 
 	attr = kmem_zalloc(sizeof(struct xfs_attr_intent) +
 			   sizeof(struct xfs_da_args), KM_NOFS);
@@ -624,19 +598,59 @@ xfs_attri_item_recover(
 	case XFS_ATTRI_OP_FLAGS_REMOVE:
 		attr->xattri_dela_state = xfs_attr_init_remove_state(args);
 		break;
-	default:
-		ASSERT(0);
-		error = -EFSCORRUPTED;
-		goto out;
 	}
 
+	xfs_defer_add_item(dfp, &attr->xattri_list);
+	return attr;
+}
+
+/*
+ * Process an attr intent item that was recovered from the log.  We need to
+ * delete the attr that it describes.
+ */
+STATIC int
+xfs_attri_item_recover(
+	struct xfs_defer_pending	*dfp,
+	struct list_head		*capture_list)
+{
+	struct xfs_log_item		*lip = dfp->dfp_intent;
+	struct xfs_attri_log_item	*attrip = ATTRI_ITEM(lip);
+	struct xfs_attr_intent		*attr;
+	struct xfs_mount		*mp = lip->li_log->l_mp;
+	struct xfs_inode		*ip;
+	struct xfs_da_args		*args;
+	struct xfs_trans		*tp;
+	struct xfs_trans_res		resv;
+	struct xfs_attri_log_format	*attrp;
+	struct xfs_attri_log_nameval	*nv = attrip->attri_nameval;
+	int				error;
+	int				total;
+	struct xfs_attrd_log_item	*done_item = NULL;
+
+	/*
+	 * First check the validity of the attr described by the ATTRI.  If any
+	 * are bad, then assume that all are bad and just toss the ATTRI.
+	 */
+	attrp = &attrip->attri_format;
+	if (!xfs_attri_validate(mp, attrp) ||
+	    !xfs_attr_namecheck(attrp->alfi_attr_filter, nv->name.i_addr,
+				nv->name.i_len))
+		return -EFSCORRUPTED;
+
+	error = xlog_recover_iget(mp,  attrp->alfi_ino, &ip);
+	if (error)
+		return error;
+
+	attr = xfs_attri_recover_work(mp, dfp, attrp, ip, nv);
+	args = attr->xattri_da_args;
+
 	xfs_init_attr_trans(args, &resv, &total);
 	resv = xlog_recover_resv(&resv);
 	error = xfs_trans_alloc(mp, &resv, total, 0, XFS_TRANS_RESERVE, &tp);
 	if (error)
-		goto out;
-
+		return error;
 	args->trans = tp;
+
 	done_item = xfs_trans_get_attrd(tp, attrip);
 	xlog_recover_transfer_intent(tp, dfp);
 
@@ -667,8 +681,6 @@ xfs_attri_item_recover(
 out_unlock:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	xfs_irele(ip);
-out:
-	xfs_attr_free_item(attr);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index b6d63b8bdad5..b65999bf0ea3 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -480,6 +480,28 @@ xfs_bui_validate(
 	return xfs_verify_fsbext(mp, map->me_startblock, map->me_len);
 }
 
+static inline struct xfs_bmap_intent *
+xfs_bui_recover_work(
+	struct xfs_mount		*mp,
+	struct xfs_defer_pending	*dfp,
+	struct xfs_map_extent		*map)
+{
+	struct xfs_bmap_intent		*bi;
+
+	bi = kmem_cache_zalloc(xfs_bmap_intent_cache, GFP_NOFS | __GFP_NOFAIL);
+	bi->bi_whichfork = (map->me_flags & XFS_BMAP_EXTENT_ATTR_FORK) ?
+			XFS_ATTR_FORK : XFS_DATA_FORK;
+	bi->bi_type = map->me_flags & XFS_BMAP_EXTENT_TYPE_MASK;
+	bi->bi_bmap.br_startblock = map->me_startblock;
+	bi->bi_bmap.br_startoff = map->me_startoff;
+	bi->bi_bmap.br_blockcount = map->me_len;
+	bi->bi_bmap.br_state = (map->me_flags & XFS_BMAP_EXTENT_UNWRITTEN) ?
+			XFS_EXT_UNWRITTEN : XFS_EXT_NORM;
+
+	xfs_defer_add_item(dfp, &bi->bi_list);
+	return bi;
+}
+
 /*
  * Process a bmap update intent item that was recovered from the log.
  * We need to update some inode's bmbt.
@@ -489,7 +511,6 @@ xfs_bui_item_recover(
 	struct xfs_defer_pending	*dfp,
 	struct list_head		*capture_list)
 {
-	struct xfs_bmap_intent		fake = { };
 	struct xfs_trans_res		resv;
 	struct xfs_log_item		*lip = dfp->dfp_intent;
 	struct xfs_bui_log_item		*buip = BUI_ITEM(lip);
@@ -498,6 +519,7 @@ xfs_bui_item_recover(
 	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_map_extent		*map;
 	struct xfs_bud_log_item		*budp;
+	struct xfs_bmap_intent		*fake;
 	int				iext_delta;
 	int				error = 0;
 
@@ -508,9 +530,7 @@ xfs_bui_item_recover(
 	}
 
 	map = &buip->bui_format.bui_extents[0];
-	fake.bi_whichfork = (map->me_flags & XFS_BMAP_EXTENT_ATTR_FORK) ?
-			XFS_ATTR_FORK : XFS_DATA_FORK;
-	fake.bi_type = map->me_flags & XFS_BMAP_EXTENT_TYPE_MASK;
+	fake = xfs_bui_recover_work(mp, dfp, map);
 
 	error = xlog_recover_iget(mp, map->me_owner, &ip);
 	if (error)
@@ -529,36 +549,31 @@ xfs_bui_item_recover(
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_trans_ijoin(tp, ip, 0);
 
-	if (fake.bi_type == XFS_BMAP_MAP)
+	if (fake->bi_type == XFS_BMAP_MAP)
 		iext_delta = XFS_IEXT_ADD_NOSPLIT_CNT;
 	else
 		iext_delta = XFS_IEXT_PUNCH_HOLE_CNT;
 
-	error = xfs_iext_count_may_overflow(ip, fake.bi_whichfork, iext_delta);
+	error = xfs_iext_count_may_overflow(ip, fake->bi_whichfork, iext_delta);
 	if (error == -EFBIG)
 		error = xfs_iext_count_upgrade(tp, ip, iext_delta);
 	if (error)
 		goto err_cancel;
 
-	fake.bi_owner = ip;
-	fake.bi_bmap.br_startblock = map->me_startblock;
-	fake.bi_bmap.br_startoff = map->me_startoff;
-	fake.bi_bmap.br_blockcount = map->me_len;
-	fake.bi_bmap.br_state = (map->me_flags & XFS_BMAP_EXTENT_UNWRITTEN) ?
-			XFS_EXT_UNWRITTEN : XFS_EXT_NORM;
+	fake->bi_owner = ip;
 
-	xfs_bmap_update_get_group(mp, &fake);
-	error = xfs_trans_log_finish_bmap_update(tp, budp, &fake);
+	xfs_bmap_update_get_group(mp, fake);
+	error = xfs_trans_log_finish_bmap_update(tp, budp, fake);
 	if (error == -EFSCORRUPTED)
-		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp, map,
-				sizeof(*map));
-	xfs_bmap_update_put_group(&fake);
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+				&buip->bui_format, sizeof(buip->bui_format));
+	xfs_bmap_update_put_group(fake);
 	if (error)
 		goto err_cancel;
 
-	if (fake.bi_bmap.br_blockcount > 0) {
-		ASSERT(fake.bi_type == XFS_BMAP_UNMAP);
-		xfs_bmap_unmap_extent(tp, ip, &fake.bi_bmap);
+	if (fake->bi_bmap.br_blockcount > 0) {
+		ASSERT(fake->bi_type == XFS_BMAP_UNMAP);
+		xfs_bmap_unmap_extent(tp, ip, &fake->bi_bmap);
 	}
 
 	/*
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index c9908fb33765..41108a0b60c9 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -651,6 +651,24 @@ xfs_efi_validate_ext(
 	return xfs_verify_fsbext(mp, extp->ext_start, extp->ext_len);
 }
 
+static inline void
+xfs_efi_recover_work(
+	struct xfs_mount		*mp,
+	struct xfs_defer_pending	*dfp,
+	struct xfs_extent		*extp)
+{
+	struct xfs_extent_free_item	*xefi;
+
+	xefi = kmem_cache_zalloc(xfs_extfree_item_cache,
+			       GFP_KERNEL | __GFP_NOFAIL);
+	xefi->xefi_startblock = extp->ext_start;
+	xefi->xefi_blockcount = extp->ext_len;
+	xefi->xefi_agresv = XFS_AG_RESV_NONE;
+	xefi->xefi_owner = XFS_RMAP_OWN_UNKNOWN;
+
+	xfs_defer_add_item(dfp, &xefi->xefi_list);
+}
+
 /*
  * Process an extent free intent item that was recovered from
  * the log.  We need to free the extents that it describes.
@@ -666,6 +684,7 @@ xfs_efi_item_recover(
 	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_efd_log_item		*efdp;
 	struct xfs_trans		*tp;
+	struct xfs_extent_free_item	*fake;
 	int				i;
 	int				error = 0;
 	bool				requeue_only = false;
@@ -683,6 +702,8 @@ xfs_efi_item_recover(
 					sizeof(efip->efi_format));
 			return -EFSCORRUPTED;
 		}
+
+		xfs_efi_recover_work(mp, dfp, &efip->efi_format.efi_extents[i]);
 	}
 
 	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
@@ -693,22 +714,11 @@ xfs_efi_item_recover(
 	efdp = xfs_trans_get_efd(tp, efip, efip->efi_format.efi_nextents);
 	xlog_recover_transfer_intent(tp, dfp);
 
-	for (i = 0; i < efip->efi_format.efi_nextents; i++) {
-		struct xfs_extent_free_item	fake = {
-			.xefi_owner		= XFS_RMAP_OWN_UNKNOWN,
-			.xefi_agresv		= XFS_AG_RESV_NONE,
-		};
-		struct xfs_extent		*extp;
-
-		extp = &efip->efi_format.efi_extents[i];
-
-		fake.xefi_startblock = extp->ext_start;
-		fake.xefi_blockcount = extp->ext_len;
-
+	list_for_each_entry(fake, &dfp->dfp_work, xefi_list) {
 		if (!requeue_only) {
-			xfs_extent_free_get_group(mp, &fake);
-			error = xfs_trans_free_extent(tp, efdp, &fake);
-			xfs_extent_free_put_group(&fake);
+			xfs_extent_free_get_group(mp, fake);
+			error = xfs_trans_free_extent(tp, efdp, fake);
+			xfs_extent_free_put_group(fake);
 		}
 
 		/*
@@ -717,10 +727,10 @@ xfs_efi_item_recover(
 		 * run again later with a new transaction context.
 		 */
 		if (error == -EAGAIN || requeue_only) {
-			error = xfs_free_extent_later(tp, fake.xefi_startblock,
-					fake.xefi_blockcount,
+			error = xfs_free_extent_later(tp, fake->xefi_startblock,
+					fake->xefi_blockcount,
 					&XFS_RMAP_OINFO_ANY_OWNER,
-					fake.xefi_agresv);
+					fake->xefi_agresv);
 			if (!error) {
 				requeue_only = true;
 				continue;
@@ -729,7 +739,8 @@ xfs_efi_item_recover(
 
 		if (error == -EFSCORRUPTED)
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
-					extp, sizeof(*extp));
+					&efip->efi_format,
+					sizeof(efip->efi_format));
 		if (error)
 			goto abort_error;
 
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index f1b259223802..4ffc34e6f0a0 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -468,6 +468,23 @@ xfs_cui_validate_phys(
 	return xfs_verify_fsbext(mp, pmap->pe_startblock, pmap->pe_len);
 }
 
+static inline void
+xfs_cui_recover_work(
+	struct xfs_mount		*mp,
+	struct xfs_defer_pending	*dfp,
+	struct xfs_phys_extent		*pmap)
+{
+	struct xfs_refcount_intent	*ri;
+
+	ri = kmem_cache_alloc(xfs_refcount_intent_cache,
+			GFP_NOFS | __GFP_NOFAIL);
+	ri->ri_type = pmap->pe_flags & XFS_REFCOUNT_EXTENT_TYPE_MASK;
+	ri->ri_startblock = pmap->pe_startblock;
+	ri->ri_blockcount = pmap->pe_len;
+
+	xfs_defer_add_item(dfp, &ri->ri_list);
+}
+
 /*
  * Process a refcount update intent item that was recovered from the log.
  * We need to update the refcountbt.
@@ -484,7 +501,7 @@ xfs_cui_item_recover(
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
-	unsigned int			refc_type;
+	struct xfs_refcount_intent	*fake;
 	bool				requeue_only = false;
 	int				i;
 	int				error = 0;
@@ -502,6 +519,8 @@ xfs_cui_item_recover(
 					sizeof(cuip->cui_format));
 			return -EFSCORRUPTED;
 		}
+
+		xfs_cui_recover_work(mp, dfp, &cuip->cui_format.cui_extents[i]);
 	}
 
 	/*
@@ -525,35 +544,12 @@ xfs_cui_item_recover(
 	cudp = xfs_trans_get_cud(tp, cuip);
 	xlog_recover_transfer_intent(tp, dfp);
 
-	for (i = 0; i < cuip->cui_format.cui_nextents; i++) {
-		struct xfs_refcount_intent	fake = { };
-		struct xfs_phys_extent		*pmap;
-
-		pmap = &cuip->cui_format.cui_extents[i];
-		refc_type = pmap->pe_flags & XFS_REFCOUNT_EXTENT_TYPE_MASK;
-		switch (refc_type) {
-		case XFS_REFCOUNT_INCREASE:
-		case XFS_REFCOUNT_DECREASE:
-		case XFS_REFCOUNT_ALLOC_COW:
-		case XFS_REFCOUNT_FREE_COW:
-			fake.ri_type = refc_type;
-			break;
-		default:
-			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
-					&cuip->cui_format,
-					sizeof(cuip->cui_format));
-			error = -EFSCORRUPTED;
-			goto abort_error;
-		}
-
-		fake.ri_startblock = pmap->pe_startblock;
-		fake.ri_blockcount = pmap->pe_len;
-
+	list_for_each_entry(fake, &dfp->dfp_work, ri_list) {
 		if (!requeue_only) {
-			xfs_refcount_update_get_group(mp, &fake);
+			xfs_refcount_update_get_group(mp, fake);
 			error = xfs_trans_log_finish_refcount_update(tp, cudp,
-					&fake, &rcur);
-			xfs_refcount_update_put_group(&fake);
+					fake, &rcur);
+			xfs_refcount_update_put_group(fake);
 		}
 		if (error == -EFSCORRUPTED)
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
@@ -563,13 +559,13 @@ xfs_cui_item_recover(
 			goto abort_error;
 
 		/* Requeue what we didn't finish. */
-		if (fake.ri_blockcount > 0) {
+		if (fake->ri_blockcount > 0) {
 			struct xfs_bmbt_irec	irec = {
-				.br_startblock	= fake.ri_startblock,
-				.br_blockcount	= fake.ri_blockcount,
+				.br_startblock	= fake->ri_startblock,
+				.br_blockcount	= fake->ri_blockcount,
 			};
 
-			switch (fake.ri_type) {
+			switch (fake->ri_type) {
 			case XFS_REFCOUNT_INCREASE:
 				xfs_refcount_increase_extent(tp, &irec);
 				break;
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 5e8a02d2b045..9fb3ae4bfd59 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -498,6 +498,58 @@ xfs_rui_validate_map(
 	return xfs_verify_fsbext(mp, map->me_startblock, map->me_len);
 }
 
+static inline void
+xfs_rui_recover_work(
+	struct xfs_mount		*mp,
+	struct xfs_defer_pending	*dfp,
+	const struct xfs_map_extent	*map)
+{
+	struct xfs_rmap_intent		*ri;
+
+	ri = kmem_cache_alloc(xfs_rmap_intent_cache, GFP_NOFS | __GFP_NOFAIL);
+
+	switch (map->me_flags & XFS_RMAP_EXTENT_TYPE_MASK) {
+	case XFS_RMAP_EXTENT_MAP:
+		ri->ri_type = XFS_RMAP_MAP;
+		break;
+	case XFS_RMAP_EXTENT_MAP_SHARED:
+		ri->ri_type = XFS_RMAP_MAP_SHARED;
+		break;
+	case XFS_RMAP_EXTENT_UNMAP:
+		ri->ri_type = XFS_RMAP_UNMAP;
+		break;
+	case XFS_RMAP_EXTENT_UNMAP_SHARED:
+		ri->ri_type = XFS_RMAP_UNMAP_SHARED;
+		break;
+	case XFS_RMAP_EXTENT_CONVERT:
+		ri->ri_type = XFS_RMAP_CONVERT;
+		break;
+	case XFS_RMAP_EXTENT_CONVERT_SHARED:
+		ri->ri_type = XFS_RMAP_CONVERT_SHARED;
+		break;
+	case XFS_RMAP_EXTENT_ALLOC:
+		ri->ri_type = XFS_RMAP_ALLOC;
+		break;
+	case XFS_RMAP_EXTENT_FREE:
+		ri->ri_type = XFS_RMAP_FREE;
+		break;
+	default:
+		ASSERT(0);
+		return;
+	}
+
+	ri->ri_owner = map->me_owner;
+	ri->ri_whichfork = (map->me_flags & XFS_RMAP_EXTENT_ATTR_FORK) ?
+			XFS_ATTR_FORK : XFS_DATA_FORK;
+	ri->ri_bmap.br_startblock = map->me_startblock;
+	ri->ri_bmap.br_startoff = map->me_startoff;
+	ri->ri_bmap.br_blockcount = map->me_len;
+	ri->ri_bmap.br_state = (map->me_flags & XFS_RMAP_EXTENT_UNWRITTEN) ?
+			XFS_EXT_UNWRITTEN : XFS_EXT_NORM;
+
+	xfs_defer_add_item(dfp, &ri->ri_list);
+}
+
 /*
  * Process an rmap update intent item that was recovered from the log.
  * We need to update the rmapbt.
@@ -514,6 +566,7 @@ xfs_rui_item_recover(
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
+	struct xfs_rmap_intent		*fake;
 	int				i;
 	int				error = 0;
 
@@ -530,6 +583,8 @@ xfs_rui_item_recover(
 					sizeof(ruip->rui_format));
 			return -EFSCORRUPTED;
 		}
+
+		xfs_rui_recover_work(mp, dfp, &ruip->rui_format.rui_extents[i]);
 	}
 
 	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
@@ -541,60 +596,15 @@ xfs_rui_item_recover(
 	rudp = xfs_trans_get_rud(tp, ruip);
 	xlog_recover_transfer_intent(tp, dfp);
 
-	for (i = 0; i < ruip->rui_format.rui_nextents; i++) {
-		struct xfs_rmap_intent	fake = { };
-		struct xfs_map_extent	*map;
-
-		map = &ruip->rui_format.rui_extents[i];
-		switch (map->me_flags & XFS_RMAP_EXTENT_TYPE_MASK) {
-		case XFS_RMAP_EXTENT_MAP:
-			fake.ri_type = XFS_RMAP_MAP;
-			break;
-		case XFS_RMAP_EXTENT_MAP_SHARED:
-			fake.ri_type = XFS_RMAP_MAP_SHARED;
-			break;
-		case XFS_RMAP_EXTENT_UNMAP:
-			fake.ri_type = XFS_RMAP_UNMAP;
-			break;
-		case XFS_RMAP_EXTENT_UNMAP_SHARED:
-			fake.ri_type = XFS_RMAP_UNMAP_SHARED;
-			break;
-		case XFS_RMAP_EXTENT_CONVERT:
-			fake.ri_type = XFS_RMAP_CONVERT;
-			break;
-		case XFS_RMAP_EXTENT_CONVERT_SHARED:
-			fake.ri_type = XFS_RMAP_CONVERT_SHARED;
-			break;
-		case XFS_RMAP_EXTENT_ALLOC:
-			fake.ri_type = XFS_RMAP_ALLOC;
-			break;
-		case XFS_RMAP_EXTENT_FREE:
-			fake.ri_type = XFS_RMAP_FREE;
-			break;
-		default:
-			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
-					&ruip->rui_format,
-					sizeof(ruip->rui_format));
-			error = -EFSCORRUPTED;
-			goto abort_error;
-		}
-
-		fake.ri_owner = map->me_owner;
-		fake.ri_whichfork = (map->me_flags & XFS_RMAP_EXTENT_ATTR_FORK) ?
-				XFS_ATTR_FORK : XFS_DATA_FORK;
-		fake.ri_bmap.br_startblock = map->me_startblock;
-		fake.ri_bmap.br_startoff = map->me_startoff;
-		fake.ri_bmap.br_blockcount = map->me_len;
-		fake.ri_bmap.br_state = (map->me_flags & XFS_RMAP_EXTENT_UNWRITTEN) ?
-				XFS_EXT_UNWRITTEN : XFS_EXT_NORM;
-
-		xfs_rmap_update_get_group(mp, &fake);
-		error = xfs_trans_log_finish_rmap_update(tp, rudp, &fake,
+	list_for_each_entry(fake, &dfp->dfp_work, ri_list) {
+		xfs_rmap_update_get_group(mp, fake);
+		error = xfs_trans_log_finish_rmap_update(tp, rudp, fake,
 				&rcur);
 		if (error == -EFSCORRUPTED)
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
-					map, sizeof(*map));
-		xfs_rmap_update_put_group(&fake);
+					&ruip->rui_format,
+					sizeof(ruip->rui_format));
+		xfs_rmap_update_put_group(fake);
 		if (error)
 			goto abort_error;
 
-- 
2.49.0


