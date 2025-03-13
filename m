Return-Path: <stable+bounces-124363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEA8A6028F
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E65D7A91EE
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120EC1F4610;
	Thu, 13 Mar 2025 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHl8cvgy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED501F4613
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897571; cv=none; b=q9lPvzl4WFydHtQKAC0Jrv/vUzesCLE5FGpC+nAY1ngMjHVryksr4Nnvtl5CZxma/QMGZHCdsnuym2KsQjQMJGo4vrZ9BjV3O4yNLZxn8p9if4n3Fexq+UAXR6+Mhiu0Sk/D9RANgHcUfySSTjKgNzyvwX9XEzD626GlhpzYKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897571; c=relaxed/simple;
	bh=U+UuuVMgFKZRrYdLNe/NtNFe32xD+QB29ldio09DzIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bu8MjogyFXEWc7Z971fBEn7b7bZ+trO+LR8N7yAmCKFRWU5FBnLCge94IJ8RKW+Azd+gP7Sw8LLYyFAiaommOWbeMIeBR7HRc40/Yg6gbw9OerpGRO6Yi8LP255Wo02J/q6/bfku7eUUJtWqrSjClFHTxq9IDhhtM1kuZzgRWG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHl8cvgy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22409077c06so38181115ad.1
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897569; x=1742502369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4Ub+gTFMvFjVkuogAxNgjG5F5v1H24XVaTG389EvnY=;
        b=OHl8cvgyFIP4n7SScL4MDF1cSvX3i8HPMUMh6WKkt0unNVSRR7Z8bv+QuGfhqDx95c
         XChxCEI9xRXMhITw0ctnaXonSiU56o/EGkPADe7X/YQ5Gj5nhdZ/aHKtF6iixOU2hy4O
         dULNF3nhZVPGWhA/WAm6fBfD2HPn04GcAaUzi+uO1hqMHui6NXHCIpvjQeD4iusI2Foe
         ZhXSFql+7dramMXwp5CSkPAwh4uRgHpqSRUwFRMW7FoT6ynWcibmZW7uoD6L58k7q1Ds
         64+UcIvM0giNmb1wrmSkVX0EHPEXRMqcXZaY5BRsywe/AxK1bBIkjDUS6/Jj7Faj+a4S
         UvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897569; x=1742502369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4Ub+gTFMvFjVkuogAxNgjG5F5v1H24XVaTG389EvnY=;
        b=M6DeiXNOPowDZflRtSD4fxX7Gm+6l3gLcWrNXAABo6xNHXimYgnKSqw5MaOSw7q6sa
         9PaRAkPsZ4l8rpLEWXAhwmPUlQDXDTxbITWOvrko2X6JkBFOsilsN+MWBVWFw+iOPpHN
         bwhhPUjfpQWgIpX3N4rq32hQRCHKXQJCd7pDTH6Vn9O/UaM1WvsksnNOpdliIp3ZoOyr
         HuyG5fXsz39iLAa9jo/WZpYc/mffUGydYT8l2RhQJ7Py/ZCeqN+HecuqLf2wHwp6rWM3
         WtAtAr28mA0ZrmgG1ijsMYhsToPfw60BeP8LVy/NgOL+LBsGQZWMeq3GyxHs1rVclOF/
         KcOw==
X-Gm-Message-State: AOJu0Ywnz2m817cs021QTsAhKwNmw+UpM6YBMfZsNfywKbMhqb2JEGOA
	8Sc2DHUJnHoy2JMTxEBz+C8bOb7+o9r2Zo8L0JTYdiymgFxpVEr5/BoBuw==
X-Gm-Gg: ASbGncsk1cEqoUsq7KpAa6VxGR78MxORekzDSiXBD7uNvCF6ASDxzcrfWej1vC7Kl3j
	N1SF8aU707DdrA4Zouz9F4lD+4QSHg1MIU8XDD05ovurfx7KGDnbkmGghQAaefdwyJOOYxND4aN
	/cCs2rAdwB3mbWGr0gAT7cxIyW815GR+Woiaklwe+B8T4oUiw6qaKmSTTdKzQb0zfrnGoZ6o+0R
	zPPG6T9fsTX2ovsYg2DSm4YZ/QcjJ2sQobMoi8RA7yoH4Mof3QQJnomJ5xzBRFifbu3DswatnWS
	3LkFCEv/xtKaQp7UTcH4WIcnaIYYl+V1eWI8LHtg8KLg6FdaOfpywDKYVzqQuNHnHQnQMN0=
X-Google-Smtp-Source: AGHT+IE2eKsXAob4VGHtmTTAW0+o9jQyg6ZrS7y11DcWrMz3NyW+uCMIqTol8tC4XMXqdIsNMqu8Uw==
X-Received: by 2002:a05:6a21:6016:b0:1f3:486c:8509 with SMTP id adf61e73a8af0-1f5c11dc272mr87134637.25.1741897568899;
        Thu, 13 Mar 2025 13:26:08 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:08 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	Dave Chinner <dchinner@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 06/29] xfs: validate block number being freed before adding to xefi
Date: Thu, 13 Mar 2025 13:25:26 -0700
Message-ID: <20250313202550.2257219-7-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
In-Reply-To: <20250313202550.2257219-1-leah.rumancik@gmail.com>
References: <20250313202550.2257219-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 7dfee17b13e5024c5c0ab1911859ded4182de3e5 ]

Bad things happen in defered extent freeing operations if it is
passed a bad block number in the xefi. This can come from a bogus
agno/agbno pair from deferred agfl freeing, or just a bad fsbno
being passed to __xfs_free_extent_later(). Either way, it's very
difficult to diagnose where a null perag oops in EFI creation
is coming from when the operation that queued the xefi has already
been completed and there's no longer any trace of it around....

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_ag.c         |  5 ++++-
 fs/xfs/libxfs/xfs_alloc.c      | 16 +++++++++++++---
 fs/xfs/libxfs/xfs_alloc.h      |  6 +++---
 fs/xfs/libxfs/xfs_bmap.c       | 10 ++++++++--
 fs/xfs/libxfs/xfs_bmap_btree.c |  7 +++++--
 fs/xfs/libxfs/xfs_ialloc.c     | 24 ++++++++++++++++--------
 fs/xfs/libxfs/xfs_refcount.c   | 13 ++++++++++---
 fs/xfs/xfs_reflink.c           |  4 +++-
 8 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index f29767e6eb7f..ee0d56854b83 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -904,11 +904,14 @@ xfs_ag_shrink_space(
 		be32_add_cpu(&agi->agi_length, delta);
 		be32_add_cpu(&agf->agf_length, delta);
 		if (err2 != -ENOSPC)
 			goto resv_err;
 
-		__xfs_free_extent_later(*tpp, args.fsbno, delta, NULL, true);
+		err2 = __xfs_free_extent_later(*tpp, args.fsbno, delta, NULL,
+				true);
+		if (err2)
+			goto resv_err;
 
 		/*
 		 * Roll the transaction before trying to re-init the per-ag
 		 * reservation. The new transaction is clean so it will cancel
 		 * without any side effects.
diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index da6d158d666f..ec03040237db 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2483,39 +2483,43 @@ xfs_agfl_reset(
  * because for one they are always freed one at a time. Further, an immediate
  * AGFL block free can cause a btree join and require another block free before
  * the real allocation can proceed. Deferring the free disconnects freeing up
  * the AGFL slot from freeing the block.
  */
-STATIC void
+static int
 xfs_defer_agfl_block(
 	struct xfs_trans		*tp,
 	xfs_agnumber_t			agno,
 	xfs_fsblock_t			agbno,
 	struct xfs_owner_info		*oinfo)
 {
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_extent_free_item	*xefi;
 
 	ASSERT(xfs_extfree_item_cache != NULL);
 	ASSERT(oinfo != NULL);
 
 	xefi = kmem_cache_zalloc(xfs_extfree_item_cache,
 			       GFP_KERNEL | __GFP_NOFAIL);
 	xefi->xefi_startblock = XFS_AGB_TO_FSB(mp, agno, agbno);
 	xefi->xefi_blockcount = 1;
 	xefi->xefi_owner = oinfo->oi_owner;
 
+	if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbno(mp, xefi->xefi_startblock)))
+		return -EFSCORRUPTED;
+
 	trace_xfs_agfl_free_defer(mp, agno, 0, agbno, 1);
 
 	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_AGFL_FREE, &xefi->xefi_list);
+	return 0;
 }
 
 /*
  * Add the extent to the list of extents to be free at transaction end.
  * The list is maintained sorted (by block number).
  */
-void
+int
 __xfs_free_extent_later(
 	struct xfs_trans		*tp,
 	xfs_fsblock_t			bno,
 	xfs_filblks_t			len,
 	const struct xfs_owner_info	*oinfo,
@@ -2538,31 +2542,35 @@ __xfs_free_extent_later(
 	ASSERT(len < mp->m_sb.sb_agblocks);
 	ASSERT(agbno + len <= mp->m_sb.sb_agblocks);
 #endif
 	ASSERT(xfs_extfree_item_cache != NULL);
 
+	if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
+		return -EFSCORRUPTED;
+
 	xefi = kmem_cache_zalloc(xfs_extfree_item_cache,
 			       GFP_KERNEL | __GFP_NOFAIL);
 	xefi->xefi_startblock = bno;
 	xefi->xefi_blockcount = (xfs_extlen_t)len;
 	if (skip_discard)
 		xefi->xefi_flags |= XFS_EFI_SKIP_DISCARD;
 	if (oinfo) {
 		ASSERT(oinfo->oi_offset == 0);
 
 		if (oinfo->oi_flags & XFS_OWNER_INFO_ATTR_FORK)
 			xefi->xefi_flags |= XFS_EFI_ATTR_FORK;
 		if (oinfo->oi_flags & XFS_OWNER_INFO_BMBT_BLOCK)
 			xefi->xefi_flags |= XFS_EFI_BMBT_BLOCK;
 		xefi->xefi_owner = oinfo->oi_owner;
 	} else {
 		xefi->xefi_owner = XFS_RMAP_OWN_NULL;
 	}
 	trace_xfs_bmap_free_defer(tp->t_mountp,
 			XFS_FSB_TO_AGNO(tp->t_mountp, bno), 0,
 			XFS_FSB_TO_AGBNO(tp->t_mountp, bno), len);
 	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_FREE, &xefi->xefi_list);
+	return 0;
 }
 
 #ifdef DEBUG
 /*
  * Check if an AGF has a free extent record whose length is equal to
@@ -2718,11 +2726,13 @@ xfs_alloc_fix_freelist(
 		error = xfs_alloc_get_freelist(pag, tp, agbp, &bno, 0);
 		if (error)
 			goto out_agbp_relse;
 
 		/* defer agfl frees */
-		xfs_defer_agfl_block(tp, args->agno, bno, &targs.oinfo);
+		error = xfs_defer_agfl_block(tp, args->agno, bno, &targs.oinfo);
+		if (error)
+			goto out_agbp_relse;
 	}
 
 	targs.tp = tp;
 	targs.mp = mp;
 	targs.agbp = agbp;
diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index 5074aed6dfad..cfc9dcdc1753 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -211,38 +211,38 @@ xfs_buf_to_agfl_bno(
 	if (xfs_has_crc(bp->b_mount))
 		return bp->b_addr + sizeof(struct xfs_agfl);
 	return bp->b_addr;
 }
 
-void __xfs_free_extent_later(struct xfs_trans *tp, xfs_fsblock_t bno,
+int __xfs_free_extent_later(struct xfs_trans *tp, xfs_fsblock_t bno,
 		xfs_filblks_t len, const struct xfs_owner_info *oinfo,
 		bool skip_discard);
 
 /*
  * List of extents to be free "later".
  * The list is kept sorted on xbf_startblock.
  */
 struct xfs_extent_free_item {
 	struct list_head	xefi_list;
 	uint64_t		xefi_owner;
 	xfs_fsblock_t		xefi_startblock;/* starting fs block number */
 	xfs_extlen_t		xefi_blockcount;/* number of blocks in extent */
 	unsigned int		xefi_flags;
 };
 
 #define XFS_EFI_SKIP_DISCARD	(1U << 0) /* don't issue discard */
 #define XFS_EFI_ATTR_FORK	(1U << 1) /* freeing attr fork block */
 #define XFS_EFI_BMBT_BLOCK	(1U << 2) /* freeing bmap btree block */
 
-static inline void
+static inline int
 xfs_free_extent_later(
 	struct xfs_trans		*tp,
 	xfs_fsblock_t			bno,
 	xfs_filblks_t			len,
 	const struct xfs_owner_info	*oinfo)
 {
-	__xfs_free_extent_later(tp, bno, len, oinfo, false);
+	return __xfs_free_extent_later(tp, bno, len, oinfo, false);
 }
 
 
 extern struct kmem_cache	*xfs_extfree_item_cache;
 
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index d523ac51c662..29781a124323 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -570,12 +570,16 @@ xfs_bmap_btree_to_extents(
 	if (error)
 		return error;
 	cblock = XFS_BUF_TO_BLOCK(cbp);
 	if ((error = xfs_btree_check_block(cur, cblock, 0, cbp)))
 		return error;
+
 	xfs_rmap_ino_bmbt_owner(&oinfo, ip->i_ino, whichfork);
-	xfs_free_extent_later(cur->bc_tp, cbno, 1, &oinfo);
+	error = xfs_free_extent_later(cur->bc_tp, cbno, 1, &oinfo);
+	if (error)
+		return error;
+
 	ip->i_nblocks--;
 	xfs_trans_mod_dquot_byino(tp, ip, XFS_TRANS_DQ_BCOUNT, -1L);
 	xfs_trans_binval(tp, cbp);
 	if (cur->bc_levels[0].bp == cbp)
 		cur->bc_levels[0].bp = NULL;
@@ -5200,14 +5204,16 @@ xfs_bmap_del_extent_real(
 	 */
 	if (do_fx && !(bflags & XFS_BMAPI_REMAP)) {
 		if (xfs_is_reflink_inode(ip) && whichfork == XFS_DATA_FORK) {
 			xfs_refcount_decrease_extent(tp, del);
 		} else {
-			__xfs_free_extent_later(tp, del->br_startblock,
+			error = __xfs_free_extent_later(tp, del->br_startblock,
 					del->br_blockcount, NULL,
 					(bflags & XFS_BMAPI_NODISCARD) ||
 					del->br_state == XFS_EXT_UNWRITTEN);
+			if (error)
+				goto done;
 		}
 	}
 
 	/*
 	 * Adjust inode # blocks in the file.
diff --git a/fs/xfs/libxfs/xfs_bmap_btree.c b/fs/xfs/libxfs/xfs_bmap_btree.c
index 18de4fbfef4e..bac2a6496a8e 100644
--- a/fs/xfs/libxfs/xfs_bmap_btree.c
+++ b/fs/xfs/libxfs/xfs_bmap_btree.c
@@ -283,15 +283,18 @@ xfs_bmbt_free_block(
 	struct xfs_mount	*mp = cur->bc_mp;
 	struct xfs_inode	*ip = cur->bc_ino.ip;
 	struct xfs_trans	*tp = cur->bc_tp;
 	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, xfs_buf_daddr(bp));
 	struct xfs_owner_info	oinfo;
+	int			error;
 
 	xfs_rmap_ino_bmbt_owner(&oinfo, ip->i_ino, cur->bc_ino.whichfork);
-	xfs_free_extent_later(cur->bc_tp, fsbno, 1, &oinfo);
-	ip->i_nblocks--;
+	error = xfs_free_extent_later(cur->bc_tp, fsbno, 1, &oinfo);
+	if (error)
+		return error;
 
+	ip->i_nblocks--;
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 	xfs_trans_mod_dquot_byino(tp, ip, XFS_TRANS_DQ_BCOUNT, -1L);
 	return 0;
 }
 
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 120dbec16f5c..448ea76d50f8 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -1825,81 +1825,87 @@ xfs_dialloc(
 /*
  * Free the blocks of an inode chunk. We must consider that the inode chunk
  * might be sparse and only free the regions that are allocated as part of the
  * chunk.
  */
-STATIC void
+static int
 xfs_difree_inode_chunk(
 	struct xfs_trans		*tp,
 	xfs_agnumber_t			agno,
 	struct xfs_inobt_rec_incore	*rec)
 {
 	struct xfs_mount		*mp = tp->t_mountp;
 	xfs_agblock_t			sagbno = XFS_AGINO_TO_AGBNO(mp,
 							rec->ir_startino);
 	int				startidx, endidx;
 	int				nextbit;
 	xfs_agblock_t			agbno;
 	int				contigblk;
 	DECLARE_BITMAP(holemask, XFS_INOBT_HOLEMASK_BITS);
 
 	if (!xfs_inobt_issparse(rec->ir_holemask)) {
 		/* not sparse, calculate extent info directly */
-		xfs_free_extent_later(tp, XFS_AGB_TO_FSB(mp, agno, sagbno),
-				  M_IGEO(mp)->ialloc_blks,
-				  &XFS_RMAP_OINFO_INODES);
-		return;
+		return xfs_free_extent_later(tp,
+				XFS_AGB_TO_FSB(mp, agno, sagbno),
+				M_IGEO(mp)->ialloc_blks,
+				&XFS_RMAP_OINFO_INODES);
 	}
 
 	/* holemask is only 16-bits (fits in an unsigned long) */
 	ASSERT(sizeof(rec->ir_holemask) <= sizeof(holemask[0]));
 	holemask[0] = rec->ir_holemask;
 
 	/*
 	 * Find contiguous ranges of zeroes (i.e., allocated regions) in the
 	 * holemask and convert the start/end index of each range to an extent.
 	 * We start with the start and end index both pointing at the first 0 in
 	 * the mask.
 	 */
 	startidx = endidx = find_first_zero_bit(holemask,
 						XFS_INOBT_HOLEMASK_BITS);
 	nextbit = startidx + 1;
 	while (startidx < XFS_INOBT_HOLEMASK_BITS) {
+		int error;
+
 		nextbit = find_next_zero_bit(holemask, XFS_INOBT_HOLEMASK_BITS,
 					     nextbit);
 		/*
 		 * If the next zero bit is contiguous, update the end index of
 		 * the current range and continue.
 		 */
 		if (nextbit != XFS_INOBT_HOLEMASK_BITS &&
 		    nextbit == endidx + 1) {
 			endidx = nextbit;
 			goto next;
 		}
 
 		/*
 		 * nextbit is not contiguous with the current end index. Convert
 		 * the current start/end to an extent and add it to the free
 		 * list.
 		 */
 		agbno = sagbno + (startidx * XFS_INODES_PER_HOLEMASK_BIT) /
 				  mp->m_sb.sb_inopblock;
 		contigblk = ((endidx - startidx + 1) *
 			     XFS_INODES_PER_HOLEMASK_BIT) /
 			    mp->m_sb.sb_inopblock;
 
 		ASSERT(agbno % mp->m_sb.sb_spino_align == 0);
 		ASSERT(contigblk % mp->m_sb.sb_spino_align == 0);
-		xfs_free_extent_later(tp, XFS_AGB_TO_FSB(mp, agno, agbno),
-				  contigblk, &XFS_RMAP_OINFO_INODES);
+		error = xfs_free_extent_later(tp,
+				XFS_AGB_TO_FSB(mp, agno, agbno),
+				contigblk, &XFS_RMAP_OINFO_INODES);
+		if (error)
+			return error;
 
 		/* reset range to current bit and carry on... */
 		startidx = endidx = nextbit;
 
 next:
 		nextbit++;
 	}
+	return 0;
 }
 
 STATIC int
 xfs_difree_inobt(
 	struct xfs_mount		*mp,
@@ -1996,11 +2002,13 @@ xfs_difree_inobt(
 			xfs_warn(mp, "%s: xfs_btree_delete returned error %d.",
 				__func__, error);
 			goto error0;
 		}
 
-		xfs_difree_inode_chunk(tp, pag->pag_agno, &rec);
+		error = xfs_difree_inode_chunk(tp, pag->pag_agno, &rec);
+		if (error)
+			goto error0;
 	} else {
 		xic->deleted = false;
 
 		error = xfs_inobt_update(cur, &rec);
 		if (error) {
diff --git a/fs/xfs/libxfs/xfs_refcount.c b/fs/xfs/libxfs/xfs_refcount.c
index bcf46aa0d08b..fec1ad95988c 100644
--- a/fs/xfs/libxfs/xfs_refcount.c
+++ b/fs/xfs/libxfs/xfs_refcount.c
@@ -1127,12 +1127,14 @@ xfs_refcount_adjust_extents(
 				}
 			} else {
 				fsbno = XFS_AGB_TO_FSB(cur->bc_mp,
 						cur->bc_ag.pag->pag_agno,
 						tmp.rc_startblock);
-				xfs_free_extent_later(cur->bc_tp, fsbno,
+				error = xfs_free_extent_later(cur->bc_tp, fsbno,
 						  tmp.rc_blockcount, NULL);
+				if (error)
+					goto out_error;
 			}
 
 			(*agbno) += tmp.rc_blockcount;
 			(*aglen) -= tmp.rc_blockcount;
 
@@ -1186,12 +1188,14 @@ xfs_refcount_adjust_extents(
 			goto advloop;
 		} else {
 			fsbno = XFS_AGB_TO_FSB(cur->bc_mp,
 					cur->bc_ag.pag->pag_agno,
 					ext.rc_startblock);
-			xfs_free_extent_later(cur->bc_tp, fsbno,
+			error = xfs_free_extent_later(cur->bc_tp, fsbno,
 					ext.rc_blockcount, NULL);
+			if (error)
+				goto out_error;
 		}
 
 skip:
 		error = xfs_btree_increment(cur, 0, &found_rec);
 		if (error)
@@ -1956,11 +1960,14 @@ xfs_refcount_recover_cow_leftovers(
 				rr->rr_rrec.rc_startblock);
 		xfs_refcount_free_cow_extent(tp, fsb,
 				rr->rr_rrec.rc_blockcount);
 
 		/* Free the block. */
-		xfs_free_extent_later(tp, fsb, rr->rr_rrec.rc_blockcount, NULL);
+		error = xfs_free_extent_later(tp, fsb,
+				rr->rr_rrec.rc_blockcount, NULL);
+		if (error)
+			goto out_trans;
 
 		error = xfs_trans_commit(tp);
 		if (error)
 			goto out_free;
 
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index cbdc23217a42..ee187e90d943 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -616,12 +616,14 @@ xfs_reflink_cancel_cow_blocks(
 
 			/* Free the CoW orphan record. */
 			xfs_refcount_free_cow_extent(*tpp, del.br_startblock,
 					del.br_blockcount);
 
-			xfs_free_extent_later(*tpp, del.br_startblock,
+			error = xfs_free_extent_later(*tpp, del.br_startblock,
 					  del.br_blockcount, NULL);
+			if (error)
+				break;
 
 			/* Roll the transaction */
 			error = xfs_defer_finish(tpp);
 			if (error)
 				break;
-- 
2.49.0.rc1.451.g8f38331e32-goog


