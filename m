Return-Path: <stable+bounces-124362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56660A6028C
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8BF19C584E
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC4B1F3FED;
	Thu, 13 Mar 2025 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqEWQsPu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C71F4180
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897571; cv=none; b=M86k209QpJffbHgHbSsz9zA/yUta1C5Bjy7S1FYaZ+n0oCbB608okMUOCpjlcgMHKNaJwNIDca8iDA/1xFy+P0fC0Y7L0zYbwOokAxlToS3dssesZd0dZOvE+nprwvnRtI4M99YctnSdN7fesJfuvjUBveRfiIL62dOiQ1fpkLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897571; c=relaxed/simple;
	bh=nHu0wUKj+AcEYHWgalT8MFMI8/Kit11CK3UXrpju2Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvwUTPXppykd8kSlGE+sW/H9dTe8YP00MASMz2JNuhlYqEBstiVXMrdOXl6WlahWu/drqsiKlA4tHKeiHmLSb8deYieEgG4usxfG2DyKW5ypKLwa+Xq8w6B1xijcEhxn5CtVrnW+ZmkWoFIn9PGWRh/EHLABc4GYDRbOitSPk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqEWQsPu; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so3109176a91.0
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897568; x=1742502368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+pc838Z9e5/ChbXI0i2jmkR4hCMnsa2XNcyAogJjy4=;
        b=JqEWQsPu/938njOopuBBH2YrFA2UhnJHo3/5Ri/hYkhf2gxdR0Hg8fdoCUo0+w21Kk
         c8Gmon0j9xqW4sK1dkEXSVZp21MkWSsF5grhY6lVjaRoC9ZRucD5mNR0BV4WWlDeXsZS
         lzjmGQMhFp2vTaMOMynzveMXxN08zRKiF9jF7OVtZSANYzjVb5x4Pe4pxeWRzImB8bFu
         6SiW2nq0PqXFkVzOLXsiaDP/9eXlS+JtCKoB2QkJeKDIEVYqu0z5cE70wGmSCZHgTxEb
         /OYxkdXVhfCEUBPsGCnCV4VbPlWdFmTtInTG9QBmRtmHj1FE5gNdKbCu/ghd7YNzTqar
         BR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897568; x=1742502368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+pc838Z9e5/ChbXI0i2jmkR4hCMnsa2XNcyAogJjy4=;
        b=LZ3WV26bdox/8hj5qY0tu9hZTgSKx3O661nTwO77LaWPJmbiYejl2FgWh+/OWmR9JM
         KNV6MaDca33E7CX//r4Htq0drZC4xb8HYqnQjMaS1HzMM2ApahLcnP2VzcE9pwzQI0fm
         piCcQb116DnfxtGC/JQfO0kXXdakX/K7PBid83RTgoSRUMqLEl7dkJleUQBnciv6zjFF
         YNNsv2i25/AxiUi1vLuLMvEKRMETvVs+xkjY6qNs/o/Q3KLoYjoL3aMIBpDy9O6rTjZS
         m0UpmRhSWp2wWzY6rEs90dk+Etfgc++3jVqn4SxnSFJ20SLujH2+T1cLNZkNTpwUBPgs
         fPug==
X-Gm-Message-State: AOJu0Yxc23AGbv6UURpgTWjtddgcgz+Tmz7us6/GjgR969iGILRPf9/o
	Y3Y4K2/QqXdOd6N9m8p8YKusRnQ/lHdbrRxdx31/CTo9bgMAtKZVOrWL3A==
X-Gm-Gg: ASbGncsBsFPREoh+IPLjVtERVhgWQFIrzh7cEzxV68wYzWAHJk9/geVACZ5uxO+Fsaw
	+7R3d3abY5gv5pV+vJunu/sEyD7nwJqKjbil/f1CvY3EgyT0Tu38a8/VZYh71n1oR7EYtgbs3O2
	ScEzEa+6XOioqLzCzlsjs40U2FS2BpNSQVpMsvBCKIJxvvseBbWMqg0TLSBOF4+Fkywa6B1yoGC
	o1RuKS8jNMR+6Gy71h0Dt8xyQa3CTJx5qSZ5caiAMV9I0YdltGqHlAhRDV2Xnbx+CeLBKnyBTt3
	E7lP6IUdEwxGL9f1JXp0za6axDsDizsr28P58RA3BSASHYSIsYbiTotGcESpkIrleqILSkM=
X-Google-Smtp-Source: AGHT+IEd+wEk6wZg4gV6eigYymmzIJz1V4ZtteTT1BEntp7snualw7hjVKC7ToSFzz3c3oiLwwVVoA==
X-Received: by 2002:a05:6a21:62c8:b0:1f5:92ac:d6b7 with SMTP id adf61e73a8af0-1f5c10ec93amr101867637.4.1741897567861;
        Thu, 13 Mar 2025 13:26:07 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:07 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 05/29] xfs: pass per-ag references to xfs_free_extent
Date: Thu, 13 Mar 2025 13:25:25 -0700
Message-ID: <20250313202550.2257219-6-leah.rumancik@gmail.com>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit b2ccab3199aa7cea9154d80ea2585312c5f6eba0 ]

Pass a reference to the per-AG structure to xfs_free_extent.  Most
callers already have one, so we can eliminate unnecessary lookups.  The
one exception to this is the EFI code, which the next patch will fix.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_ag.c             |  6 ++----
 fs/xfs/libxfs/xfs_alloc.c          | 15 +++++----------
 fs/xfs/libxfs/xfs_alloc.h          |  8 +++++---
 fs/xfs/libxfs/xfs_ialloc_btree.c   |  7 +++++--
 fs/xfs/libxfs/xfs_refcount_btree.c |  5 +++--
 fs/xfs/scrub/repair.c              |  3 ++-
 fs/xfs/xfs_extfree_item.c          |  8 ++++++--
 7 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index bf47efe08a58..f29767e6eb7f 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -979,14 +979,12 @@ xfs_ag_extend_space(
 	error = xfs_rmap_free(tp, bp, pag, be32_to_cpu(agf->agf_length) - len,
 				len, &XFS_RMAP_OINFO_SKIP_UPDATE);
 	if (error)
 		return error;
 
-	error = xfs_free_extent(tp, XFS_AGB_TO_FSB(pag->pag_mount, pag->pag_agno,
-					be32_to_cpu(agf->agf_length) - len),
-				len, &XFS_RMAP_OINFO_SKIP_UPDATE,
-				XFS_AG_RESV_NONE);
+	error = xfs_free_extent(tp, pag, be32_to_cpu(agf->agf_length) - len,
+			len, &XFS_RMAP_OINFO_SKIP_UPDATE, XFS_AG_RESV_NONE);
 	if (error)
 		return error;
 
 	/* Update perag geometry */
 	pag->block_count = be32_to_cpu(agf->agf_length);
diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index cc5c954cda88..da6d158d666f 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -3445,63 +3445,58 @@ xfs_free_extent_fix_freelist(
  * after fixing up the freelist.
  */
 int
 __xfs_free_extent(
 	struct xfs_trans		*tp,
-	xfs_fsblock_t			bno,
+	struct xfs_perag		*pag,
+	xfs_agblock_t			agbno,
 	xfs_extlen_t			len,
 	const struct xfs_owner_info	*oinfo,
 	enum xfs_ag_resv_type		type,
 	bool				skip_discard)
 {
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_buf			*agbp;
-	xfs_agnumber_t			agno = XFS_FSB_TO_AGNO(mp, bno);
-	xfs_agblock_t			agbno = XFS_FSB_TO_AGBNO(mp, bno);
 	struct xfs_agf			*agf;
 	int				error;
 	unsigned int			busy_flags = 0;
-	struct xfs_perag		*pag;
 
 	ASSERT(len != 0);
 	ASSERT(type != XFS_AG_RESV_AGFL);
 
 	if (XFS_TEST_ERROR(false, mp,
 			XFS_ERRTAG_FREE_EXTENT))
 		return -EIO;
 
-	pag = xfs_perag_get(mp, agno);
 	error = xfs_free_extent_fix_freelist(tp, pag, &agbp);
 	if (error)
-		goto err;
+		return error;
 	agf = agbp->b_addr;
 
 	if (XFS_IS_CORRUPT(mp, agbno >= mp->m_sb.sb_agblocks)) {
 		error = -EFSCORRUPTED;
 		goto err_release;
 	}
 
 	/* validate the extent size is legal now we have the agf locked */
 	if (XFS_IS_CORRUPT(mp, agbno + len > be32_to_cpu(agf->agf_length))) {
 		error = -EFSCORRUPTED;
 		goto err_release;
 	}
 
-	error = xfs_free_ag_extent(tp, agbp, agno, agbno, len, oinfo, type);
+	error = xfs_free_ag_extent(tp, agbp, pag->pag_agno, agbno, len, oinfo,
+			type);
 	if (error)
 		goto err_release;
 
 	if (skip_discard)
 		busy_flags |= XFS_EXTENT_BUSY_SKIP_DISCARD;
 	xfs_extent_busy_insert(tp, pag, agbno, len, busy_flags);
-	xfs_perag_put(pag);
 	return 0;
 
 err_release:
 	xfs_trans_brelse(tp, agbp);
-err:
-	xfs_perag_put(pag);
 	return error;
 }
 
 struct xfs_alloc_query_range_info {
 	xfs_alloc_query_range_fn	fn;
diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index 2c3f762dfb58..5074aed6dfad 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -128,25 +128,27 @@ xfs_alloc_vextent(
  * Free an extent.
  */
 int				/* error */
 __xfs_free_extent(
 	struct xfs_trans	*tp,	/* transaction pointer */
-	xfs_fsblock_t		bno,	/* starting block number of extent */
+	struct xfs_perag	*pag,
+	xfs_agblock_t		agbno,
 	xfs_extlen_t		len,	/* length of extent */
 	const struct xfs_owner_info	*oinfo,	/* extent owner */
 	enum xfs_ag_resv_type	type,	/* block reservation type */
 	bool			skip_discard);
 
 static inline int
 xfs_free_extent(
 	struct xfs_trans	*tp,
-	xfs_fsblock_t		bno,
+	struct xfs_perag	*pag,
+	xfs_agblock_t		agbno,
 	xfs_extlen_t		len,
 	const struct xfs_owner_info	*oinfo,
 	enum xfs_ag_resv_type	type)
 {
-	return __xfs_free_extent(tp, bno, len, oinfo, type, false);
+	return __xfs_free_extent(tp, pag, agbno, len, oinfo, type, false);
 }
 
 int				/* error */
 xfs_alloc_lookup_le(
 	struct xfs_btree_cur	*cur,	/* btree cursor */
diff --git a/fs/xfs/libxfs/xfs_ialloc_btree.c b/fs/xfs/libxfs/xfs_ialloc_btree.c
index 8c83e265770c..2dbe553d87fb 100644
--- a/fs/xfs/libxfs/xfs_ialloc_btree.c
+++ b/fs/xfs/libxfs/xfs_ialloc_btree.c
@@ -154,13 +154,16 @@ STATIC int
 __xfs_inobt_free_block(
 	struct xfs_btree_cur	*cur,
 	struct xfs_buf		*bp,
 	enum xfs_ag_resv_type	resv)
 {
+	xfs_fsblock_t		fsbno;
+
 	xfs_inobt_mod_blockcount(cur, -1);
-	return xfs_free_extent(cur->bc_tp,
-			XFS_DADDR_TO_FSB(cur->bc_mp, xfs_buf_daddr(bp)), 1,
+	fsbno = XFS_DADDR_TO_FSB(cur->bc_mp, xfs_buf_daddr(bp));
+	return xfs_free_extent(cur->bc_tp, cur->bc_ag.pag,
+			XFS_FSB_TO_AGBNO(cur->bc_mp, fsbno), 1,
 			&XFS_RMAP_OINFO_INOBT, resv);
 }
 
 STATIC int
 xfs_inobt_free_block(
diff --git a/fs/xfs/libxfs/xfs_refcount_btree.c b/fs/xfs/libxfs/xfs_refcount_btree.c
index e1f789866683..3d8e62da2ccc 100644
--- a/fs/xfs/libxfs/xfs_refcount_btree.c
+++ b/fs/xfs/libxfs/xfs_refcount_btree.c
@@ -110,12 +110,13 @@ xfs_refcountbt_free_block(
 
 	trace_xfs_refcountbt_free_block(cur->bc_mp, cur->bc_ag.pag->pag_agno,
 			XFS_FSB_TO_AGBNO(cur->bc_mp, fsbno), 1);
 	be32_add_cpu(&agf->agf_refcount_blocks, -1);
 	xfs_alloc_log_agf(cur->bc_tp, agbp, XFS_AGF_REFCOUNT_BLOCKS);
-	error = xfs_free_extent(cur->bc_tp, fsbno, 1, &XFS_RMAP_OINFO_REFC,
-			XFS_AG_RESV_METADATA);
+	error = xfs_free_extent(cur->bc_tp, cur->bc_ag.pag,
+			XFS_FSB_TO_AGBNO(cur->bc_mp, fsbno), 1,
+			&XFS_RMAP_OINFO_REFC, XFS_AG_RESV_METADATA);
 	if (error)
 		return error;
 
 	return error;
 }
diff --git a/fs/xfs/scrub/repair.c b/fs/xfs/scrub/repair.c
index c18bd039fce9..e0ed0ebfdaea 100644
--- a/fs/xfs/scrub/repair.c
+++ b/fs/xfs/scrub/repair.c
@@ -580,11 +580,12 @@ xrep_reap_block(
 		error = xfs_rmap_free(sc->tp, agf_bp, sc->sa.pag, agbno,
 					1, oinfo);
 	else if (resv == XFS_AG_RESV_AGFL)
 		error = xrep_put_freelist(sc, agbno);
 	else
-		error = xfs_free_extent(sc->tp, fsbno, 1, oinfo, resv);
+		error = xfs_free_extent(sc->tp, sc->sa.pag, agbno, 1, oinfo,
+				resv);
 	if (agf_bp != sc->sa.agf_bp)
 		xfs_trans_brelse(sc->tp, agf_bp);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 011b50469301..c1aae07467c9 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -348,29 +348,33 @@ xfs_trans_free_extent(
 	struct xfs_extent_free_item	*xefi)
 {
 	struct xfs_owner_info		oinfo = { };
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_extent		*extp;
+	struct xfs_perag		*pag;
 	uint				next_extent;
 	xfs_agnumber_t			agno = XFS_FSB_TO_AGNO(mp,
 							xefi->xefi_startblock);
 	xfs_agblock_t			agbno = XFS_FSB_TO_AGBNO(mp,
 							xefi->xefi_startblock);
 	int				error;
 
 	oinfo.oi_owner = xefi->xefi_owner;
 	if (xefi->xefi_flags & XFS_EFI_ATTR_FORK)
 		oinfo.oi_flags |= XFS_OWNER_INFO_ATTR_FORK;
 	if (xefi->xefi_flags & XFS_EFI_BMBT_BLOCK)
 		oinfo.oi_flags |= XFS_OWNER_INFO_BMBT_BLOCK;
 
 	trace_xfs_bmap_free_deferred(tp->t_mountp, agno, 0, agbno,
 			xefi->xefi_blockcount);
 
-	error = __xfs_free_extent(tp, xefi->xefi_startblock,
-			xefi->xefi_blockcount, &oinfo, XFS_AG_RESV_NONE,
+	pag = xfs_perag_get(mp, agno);
+	error = __xfs_free_extent(tp, pag, agbno, xefi->xefi_blockcount,
+			&oinfo, XFS_AG_RESV_NONE,
 			xefi->xefi_flags & XFS_EFI_SKIP_DISCARD);
+	xfs_perag_put(pag);
+
 	/*
 	 * Mark the transaction dirty, even on error. This ensures the
 	 * transaction is aborted, which:
 	 *
 	 * 1.) releases the EFI and frees the EFD
-- 
2.49.0.rc1.451.g8f38331e32-goog


