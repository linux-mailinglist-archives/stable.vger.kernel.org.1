Return-Path: <stable+bounces-124491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BBDA62155
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0A4462817
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792CD1C860B;
	Fri, 14 Mar 2025 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dpqi41yg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371281F92E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993835; cv=none; b=h6k/sTG2BPOZnNNjiYhd8/sq7M2QLUZUHpWq1JdXWTx+Qk75NOU5h4MvjeMKEbxR7F99HrSv5wWRMZ0SxDt4hCkNHfDK70kEGN4X8ED58nvyfy7iuJ5RCxx4HxDVPTv9+LQr0SNS/00br1l1G868MFlIXQaLov7Qgg1RUr4D9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993835; c=relaxed/simple;
	bh=AewI/8t2pQzHw1YTrvsQ4vk5vxtj6zNY/AJ8MLT+6VQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkL5WVipDPXMzQWCmehDbSDxaTZtyij3XkYxRQABysk/c5HUA7gQ1RUmT+RM920X6rRqFndpTeQ7k5E6Ql70mAp05ahDxjY5uja6ZpdqKWqvIWgjN7KbmREebn8+y9xvr5W7rJWqk8PaUtbNA4zkmFtmPqe1gbe/LONauzD91Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dpqi41yg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F25C4CEE3;
	Fri, 14 Mar 2025 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993835;
	bh=AewI/8t2pQzHw1YTrvsQ4vk5vxtj6zNY/AJ8MLT+6VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dpqi41yg7RSexEik6WEpDg3Lra9FDLVR27ymzFyvssyq3MMMsapC4xzPrAjL1L+No
	 P0F0bG8ZRDoeZGArmnGH32oPmZaE6FyGI2KEDWDnEhBUP/utb1EW+0Y1v8kTVQl+zO
	 I3MP11d5bdKPi07dUSp8YIGZSgJTtA1l8b04Ejvlaqbkus8UmNRIK/G4tgTl7K8yjV
	 TN40lYb43aVcug3MJ4lls1/mH8aQ4CZTSjyCUpMlTsfiLJjuhrrTYhb7ZJGoV/qEqc
	 JW44ZM66xUPybWtFAVybwqMh+oMVKkoDJuGTBqTlg44YTQ/mz2/twdqxYY9ohhbcGs
	 77j3Rj00/OCiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	leah.rumancik@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 08/29] xfs: use deferred frees for btree block freeing
Date: Fri, 14 Mar 2025 19:10:33 -0400
Message-Id: <20250314115147-c15ef59b77c89640@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250313202550.2257219-9-leah.rumancik@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
ℹ️ This is part 08/29 of a series
❌ Build failures detected

The upstream commit SHA1 provided is correct: b742d7b4f0e03df25c2a772adcded35044b625ca

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Dave Chinner<dchinner@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-6.1.y. Reject:

diff a/fs/xfs/libxfs/xfs_refcount.c b/fs/xfs/libxfs/xfs_refcount.c	(rejected hunks)
@@ -1128,11 +1128,12 @@ xfs_refcount_adjust_extents(
 			} else {
 				fsbno = XFS_AGB_TO_FSB(cur->bc_mp,
 						cur->bc_ag.pag->pag_agno,
 						tmp.rc_startblock);
 				error = xfs_free_extent_later(cur->bc_tp, fsbno,
-						  tmp.rc_blockcount, NULL);
+						  tmp.rc_blockcount, NULL,
+						  XFS_AG_RESV_NONE);
 				if (error)
 					goto out_error;
 			}
 
 			(*agbno) += tmp.rc_blockcount;
@@ -1189,11 +1190,12 @@ xfs_refcount_adjust_extents(
 		} else {
 			fsbno = XFS_AGB_TO_FSB(cur->bc_mp,
 					cur->bc_ag.pag->pag_agno,
 					ext.rc_startblock);
 			error = xfs_free_extent_later(cur->bc_tp, fsbno,
-					ext.rc_blockcount, NULL);
+					ext.rc_blockcount, NULL,
+					XFS_AG_RESV_NONE);
 			if (error)
 				goto out_error;
 		}
 
 skip:
@@ -1961,11 +1963,12 @@ xfs_refcount_recover_cow_leftovers(
 		xfs_refcount_free_cow_extent(tp, fsb,
 				rr->rr_rrec.rc_blockcount);
 
 		/* Free the block. */
 		error = xfs_free_extent_later(tp, fsb,
-				rr->rr_rrec.rc_blockcount, NULL);
+				rr->rr_rrec.rc_blockcount, NULL,
+				XFS_AG_RESV_NONE);
 		if (error)
 			goto out_trans;
 
 		error = xfs_trans_commit(tp);
 		if (error)
diff a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c	(rejected hunks)
@@ -1844,12 +1844,12 @@ xfs_difree_inode_chunk(
 
 	if (!xfs_inobt_issparse(rec->ir_holemask)) {
 		/* not sparse, calculate extent info directly */
 		return xfs_free_extent_later(tp,
 				XFS_AGB_TO_FSB(mp, agno, sagbno),
-				M_IGEO(mp)->ialloc_blks,
-				&XFS_RMAP_OINFO_INODES);
+				M_IGEO(mp)->ialloc_blks, &XFS_RMAP_OINFO_INODES,
+				XFS_AG_RESV_NONE);
 	}
 
 	/* holemask is only 16-bits (fits in an unsigned long) */
 	ASSERT(sizeof(rec->ir_holemask) <= sizeof(holemask[0]));
 	holemask[0] = rec->ir_holemask;
@@ -1890,12 +1890,12 @@ xfs_difree_inode_chunk(
 			    mp->m_sb.sb_inopblock;
 
 		ASSERT(agbno % mp->m_sb.sb_spino_align == 0);
 		ASSERT(contigblk % mp->m_sb.sb_spino_align == 0);
 		error = xfs_free_extent_later(tp,
-				XFS_AGB_TO_FSB(mp, agno, agbno),
-				contigblk, &XFS_RMAP_OINFO_INODES);
+				XFS_AGB_TO_FSB(mp, agno, agbno), contigblk,
+				&XFS_RMAP_OINFO_INODES, XFS_AG_RESV_NONE);
 		if (error)
 			return error;
 
 		/* reset range to current bit and carry on... */
 		startidx = endidx = nextbit;
diff a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c	(rejected hunks)
@@ -2505,55 +2505,59 @@ xfs_defer_agfl_block(
 	xefi = kmem_cache_zalloc(xfs_extfree_item_cache,
 			       GFP_KERNEL | __GFP_NOFAIL);
 	xefi->xefi_startblock = fsbno;
 	xefi->xefi_blockcount = 1;
 	xefi->xefi_owner = oinfo->oi_owner;
+	xefi->xefi_agresv = XFS_AG_RESV_AGFL;
 
 	trace_xfs_agfl_free_defer(mp, agno, 0, agbno, 1);
 
 	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_AGFL_FREE, &xefi->xefi_list);
 	return 0;
 }
 
 /*
  * Add the extent to the list of extents to be free at transaction end.
  * The list is maintained sorted (by block number).
  */
 int
 __xfs_free_extent_later(
 	struct xfs_trans		*tp,
 	xfs_fsblock_t			bno,
 	xfs_filblks_t			len,
 	const struct xfs_owner_info	*oinfo,
+	enum xfs_ag_resv_type		type,
 	bool				skip_discard)
 {
 	struct xfs_extent_free_item	*xefi;
 #ifdef DEBUG
 	struct xfs_mount		*mp = tp->t_mountp;
 	xfs_agnumber_t			agno;
 	xfs_agblock_t			agbno;
 
 	ASSERT(bno != NULLFSBLOCK);
 	ASSERT(len > 0);
 	ASSERT(len <= XFS_MAX_BMBT_EXTLEN);
 	ASSERT(!isnullstartblock(bno));
 	agno = XFS_FSB_TO_AGNO(mp, bno);
 	agbno = XFS_FSB_TO_AGBNO(mp, bno);
 	ASSERT(agno < mp->m_sb.sb_agcount);
 	ASSERT(agbno < mp->m_sb.sb_agblocks);
 	ASSERT(len < mp->m_sb.sb_agblocks);
 	ASSERT(agbno + len <= mp->m_sb.sb_agblocks);
 #endif
 	ASSERT(xfs_extfree_item_cache != NULL);
+	ASSERT(type != XFS_AG_RESV_AGFL);
 
 	if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
 		return -EFSCORRUPTED;
 
 	xefi = kmem_cache_zalloc(xfs_extfree_item_cache,
 			       GFP_KERNEL | __GFP_NOFAIL);
 	xefi->xefi_startblock = bno;
 	xefi->xefi_blockcount = (xfs_extlen_t)len;
+	xefi->xefi_agresv = type;
 	if (skip_discard)
 		xefi->xefi_flags |= XFS_EFI_SKIP_DISCARD;
 	if (oinfo) {
 		ASSERT(oinfo->oi_offset == 0);
 
diff a/fs/xfs/libxfs/xfs_refcount_btree.c b/fs/xfs/libxfs/xfs_refcount_btree.c	(rejected hunks)
@@ -104,23 +104,17 @@ xfs_refcountbt_free_block(
 {
 	struct xfs_mount	*mp = cur->bc_mp;
 	struct xfs_buf		*agbp = cur->bc_ag.agbp;
 	struct xfs_agf		*agf = agbp->b_addr;
 	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, xfs_buf_daddr(bp));
-	int			error;
 
 	trace_xfs_refcountbt_free_block(cur->bc_mp, cur->bc_ag.pag->pag_agno,
 			XFS_FSB_TO_AGBNO(cur->bc_mp, fsbno), 1);
 	be32_add_cpu(&agf->agf_refcount_blocks, -1);
 	xfs_alloc_log_agf(cur->bc_tp, agbp, XFS_AGF_REFCOUNT_BLOCKS);
-	error = xfs_free_extent(cur->bc_tp, cur->bc_ag.pag,
-			XFS_FSB_TO_AGBNO(cur->bc_mp, fsbno), 1,
+	return xfs_free_extent_later(cur->bc_tp, fsbno, 1,
 			&XFS_RMAP_OINFO_REFC, XFS_AG_RESV_METADATA);
-	if (error)
-		return error;
-
-	return error;
 }
 
 STATIC int
 xfs_refcountbt_get_minrecs(
 	struct xfs_btree_cur	*cur,
diff a/fs/xfs/libxfs/xfs_ialloc_btree.c b/fs/xfs/libxfs/xfs_ialloc_btree.c	(rejected hunks)
@@ -158,12 +158,11 @@ __xfs_inobt_free_block(
 {
 	xfs_fsblock_t		fsbno;
 
 	xfs_inobt_mod_blockcount(cur, -1);
 	fsbno = XFS_DADDR_TO_FSB(cur->bc_mp, xfs_buf_daddr(bp));
-	return xfs_free_extent(cur->bc_tp, cur->bc_ag.pag,
-			XFS_FSB_TO_AGBNO(cur->bc_mp, fsbno), 1,
+	return xfs_free_extent_later(cur->bc_tp, fsbno, 1,
 			&XFS_RMAP_OINFO_INOBT, resv);
 }
 
 STATIC int
 xfs_inobt_free_block(
diff a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c	(rejected hunks)
@@ -905,11 +905,11 @@ xfs_ag_shrink_space(
 		be32_add_cpu(&agf->agf_length, delta);
 		if (err2 != -ENOSPC)
 			goto resv_err;
 
 		err2 = __xfs_free_extent_later(*tpp, args.fsbno, delta, NULL,
-				true);
+				XFS_AG_RESV_NONE, true);
 		if (err2)
 			goto resv_err;
 
 		/*
 		 * Roll the transaction before trying to re-init the per-ag
diff a/fs/xfs/libxfs/xfs_bmap_btree.c b/fs/xfs/libxfs/xfs_bmap_btree.c	(rejected hunks)
@@ -286,11 +286,12 @@ xfs_bmbt_free_block(
 	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, xfs_buf_daddr(bp));
 	struct xfs_owner_info	oinfo;
 	int			error;
 
 	xfs_rmap_ino_bmbt_owner(&oinfo, ip->i_ino, cur->bc_ino.whichfork);
-	error = xfs_free_extent_later(cur->bc_tp, fsbno, 1, &oinfo);
+	error = xfs_free_extent_later(cur->bc_tp, fsbno, 1, &oinfo,
+			XFS_AG_RESV_NONE);
 	if (error)
 		return error;
 
 	ip->i_nblocks--;
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
diff a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h	(rejected hunks)
@@ -213,36 +213,38 @@ xfs_buf_to_agfl_bno(
 	return bp->b_addr;
 }
 
 int __xfs_free_extent_later(struct xfs_trans *tp, xfs_fsblock_t bno,
 		xfs_filblks_t len, const struct xfs_owner_info *oinfo,
-		bool skip_discard);
+		enum xfs_ag_resv_type type, bool skip_discard);
 
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
+	enum xfs_ag_resv_type	xefi_agresv;
 };
 
 #define XFS_EFI_SKIP_DISCARD	(1U << 0) /* don't issue discard */
 #define XFS_EFI_ATTR_FORK	(1U << 1) /* freeing attr fork block */
 #define XFS_EFI_BMBT_BLOCK	(1U << 2) /* freeing bmap btree block */
 
 static inline int
 xfs_free_extent_later(
 	struct xfs_trans		*tp,
 	xfs_fsblock_t			bno,
 	xfs_filblks_t			len,
-	const struct xfs_owner_info	*oinfo)
+	const struct xfs_owner_info	*oinfo,
+	enum xfs_ag_resv_type		type)
 {
-	return __xfs_free_extent_later(tp, bno, len, oinfo, false);
+	return __xfs_free_extent_later(tp, bno, len, oinfo, type, false);
 }
 
 
 extern struct kmem_cache	*xfs_extfree_item_cache;
 
diff a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c	(rejected hunks)
@@ -572,11 +572,12 @@ xfs_bmap_btree_to_extents(
 	cblock = XFS_BUF_TO_BLOCK(cbp);
 	if ((error = xfs_btree_check_block(cur, cblock, 0, cbp)))
 		return error;
 
 	xfs_rmap_ino_bmbt_owner(&oinfo, ip->i_ino, whichfork);
-	error = xfs_free_extent_later(cur->bc_tp, cbno, 1, &oinfo);
+	error = xfs_free_extent_later(cur->bc_tp, cbno, 1, &oinfo,
+			XFS_AG_RESV_NONE);
 	if (error)
 		return error;
 
 	ip->i_nblocks--;
 	xfs_trans_mod_dquot_byino(tp, ip, XFS_TRANS_DQ_BCOUNT, -1L);
@@ -5206,12 +5207,13 @@ xfs_bmap_del_extent_real(
 		if (xfs_is_reflink_inode(ip) && whichfork == XFS_DATA_FORK) {
 			xfs_refcount_decrease_extent(tp, del);
 		} else {
 			error = __xfs_free_extent_later(tp, del->br_startblock,
 					del->br_blockcount, NULL,
-					(bflags & XFS_BMAPI_NODISCARD) ||
-					del->br_state == XFS_EXT_UNWRITTEN);
+					XFS_AG_RESV_NONE,
+					((bflags & XFS_BMAPI_NODISCARD) ||
+					del->br_state == XFS_EXT_UNWRITTEN));
 			if (error)
 				goto done;
 		}
 	}
 
diff a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c	(rejected hunks)
@@ -367,11 +367,11 @@ xfs_trans_free_extent(
 	trace_xfs_bmap_free_deferred(tp->t_mountp, agno, 0, agbno,
 			xefi->xefi_blockcount);
 
 	pag = xfs_perag_get(mp, agno);
 	error = __xfs_free_extent(tp, pag, agbno, xefi->xefi_blockcount,
-			&oinfo, XFS_AG_RESV_NONE,
+			&oinfo, xefi->xefi_agresv,
 			xefi->xefi_flags & XFS_EFI_SKIP_DISCARD);
 	xfs_perag_put(pag);
 
 	/*
 	 * Mark the transaction dirty, even on error. This ensures the
@@ -626,10 +626,11 @@ xfs_efi_item_recover(
 	efdp = xfs_trans_get_efd(tp, efip, efip->efi_format.efi_nextents);
 
 	for (i = 0; i < efip->efi_format.efi_nextents; i++) {
 		struct xfs_extent_free_item	fake = {
 			.xefi_owner		= XFS_RMAP_OWN_UNKNOWN,
+			.xefi_agresv		= XFS_AG_RESV_NONE,
 		};
 		struct xfs_extent		*extp;
 
 		extp = &efip->efi_format.efi_extents[i];
 
diff a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c	(rejected hunks)
@@ -617,11 +617,12 @@ xfs_reflink_cancel_cow_blocks(
 			/* Free the CoW orphan record. */
 			xfs_refcount_free_cow_extent(*tpp, del.br_startblock,
 					del.br_blockcount);
 
 			error = xfs_free_extent_later(*tpp, del.br_startblock,
-					  del.br_blockcount, NULL);
+					del.br_blockcount, NULL,
+					XFS_AG_RESV_NONE);
 			if (error)
 				break;
 
 			/* Roll the transaction */
 			error = xfs_defer_finish(tpp);

