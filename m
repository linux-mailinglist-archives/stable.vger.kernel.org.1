Return-Path: <stable+bounces-124365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E74A6028E
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB19B17C368
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60B71F4613;
	Thu, 13 Mar 2025 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5KIH28Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24491F4606
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897573; cv=none; b=WyiQrLg3YQeyeh8VMmZzTNEFS5nav4cDiiLerwoXt2qFT98h0Wia05zpe/lGeEWwWW1RjBMCohJ0MN4QQen7xVeDUKFNp0kVzbENyzs1dJw6wX1ocmO2hKOKS/vqVtUYwN1xUeT1rZXciatdITAOLa6Ca+HaxY4vVKHURq4AqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897573; c=relaxed/simple;
	bh=hSui/Tyf5EkXTr8Y75jcfwLRYaexUP2t+ETAjMjt0JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMNZP35GR0paYEsGIoBt2A/hrUFZGKuF1N8ogvWEv/kcDMV4R5cn8YsiCMdSPqTlOACe5H1x4n8tCfNc06uSA3IZ3yjWZHkEfCGw0QNGxOawpJnNioFnNQqfmNgYUoXBmJa1k6ovJLj0rP962OaoatIpxFsTnBaNm4AQLd5QE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5KIH28Y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224341bbc1dso29981605ad.3
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897571; x=1742502371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anvEKWsKs0Km96U8MThK6L9J31yCvcoaHiNwH08VQkY=;
        b=Q5KIH28Yf/Uozlc/D20+0FN2+7M9vYU7ujkR/MPBNvNWj4XqghuNyTdAwU9ma91ObB
         BdDXJpAGasyDmWHr+onOCfOWqmHHwwvNSvb6UyA8F8iac1tJru8veHwvWTHlcipMGsN7
         1FYApBv1wLQe3kZ86qE7OHEj7HEGJpelBdt5HZGPKxQe12hMO+NswUZpfmUH2rqYfEry
         T8PNd7y87cO/b+/kXB2ZuZTILt8DjxW/X7DMBhOgYE8uLxPIVzMT6fEJBTJvX2u2m8n0
         XiNqYloleTlNEeaCv+9Z10jUiAw5uuYWNOa0/07IT9YTQvKLbvZ7jBYC6OLKjv5wRTW9
         Q8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897571; x=1742502371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anvEKWsKs0Km96U8MThK6L9J31yCvcoaHiNwH08VQkY=;
        b=ROmJzWDroxLiwXNLOMsbW4FvfRvqsQ3SWcvK5iqz3F9WiiEBcOMqnIN8CPtZWqHo/6
         L3pRmFEp2b4EQLKyyJnuvQm9+kcfTujiNzY8WCeD0bppmgAE9pBJ7lPag7cunKxGUL8j
         zA6ZgQvoeP0nxDb3x+EDrytUTvSE0zFsYg8JpxnG8RL87243mAcwgEHSoVsdxwSOEbx9
         OnLquNHdqPlYlEKx5gfemiK3EBBU/z80JNifo2nfF5w6NuGj0bdFEPRuxJv3/PDfme+d
         BzA93bvaEicMp+Woptwg9IWroRnHTtEJEFKPhwSs6ys/9DbMfH6OrFAROE7kYc8eBlJj
         Gyxg==
X-Gm-Message-State: AOJu0YwyMe9cyYZw9uWc0Q7cPR8laMU5cm+RG3H0NpLtI/jpNKFh48Nc
	78xJB0tUBa40/gdtsVFGdhOesw6eGIojXAx8mrYylLAt624e6dvWeTl3zQ==
X-Gm-Gg: ASbGncvQs4SGKiEE6MzVFOoYjq9oIaeBdRaOapdWm2VhuNIKELEfxj2U/6gR5Cju0nB
	diA78jPI7kdQPgZ75YCAawolLd3hX2GA1UtbJu04kCNl790tOpUVLNqL0sXMJJF0RzxIfA6iZJc
	p1DlWRNWHHSBpcJKanofo0r4Ny1kVKN+FZpsqypsHsMbqbxnDTerz9rJba5RF6RlwqjJExkKySM
	kJmfs3OdQ0QkX7P7y5wSCskEvZE1nQnIgl4tMJiwU/hf0kUkfGP62/zEqPQENezKcxYc5OctC19
	OZJbGcVCVk/KImel+Tvq8+EaNWNwKSdxlK3mdvIM7cWqB5XaGnesSoJzJJ/kGq5FwfZ0Kmmwtw1
	/6wpbKg==
X-Google-Smtp-Source: AGHT+IFjSwuz/btC42+4RUUiD0q2FGN2S1rPVNf9xK5HNJDNWNb1cV5xvsnCBSKLxmNm4D9hhO9F5g==
X-Received: by 2002:a05:6a21:a43:b0:1f5:8c05:e8f8 with SMTP id adf61e73a8af0-1f5c1219153mr64211637.25.1741897570795;
        Thu, 13 Mar 2025 13:26:10 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:10 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 08/29] xfs: use deferred frees for btree block freeing
Date: Thu, 13 Mar 2025 13:25:28 -0700
Message-ID: <20250313202550.2257219-9-leah.rumancik@gmail.com>
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

[ Upstream commit b742d7b4f0e03df25c2a772adcded35044b625ca ]

[ 6.1: resolved conflict in xfs_extfree_item.c ]

Btrees that aren't freespace management trees use the normal extent
allocation and freeing routines for their blocks. Hence when a btree
block is freed, a direct call to xfs_free_extent() is made and the
extent is immediately freed. This puts the entire free space
management btrees under this path, so we are stacking btrees on
btrees in the call stack. The inobt, finobt and refcount btrees
all do this.

However, the bmap btree does not do this - it calls
xfs_free_extent_later() to defer the extent free operation via an
XEFI and hence it gets processed in deferred operation processing
during the commit of the primary transaction (i.e. via intent
chaining).

We need to change xfs_free_extent() to behave in a non-blocking
manner so that we can avoid deadlocks with busy extents near ENOSPC
in transactions that free multiple extents. Inserting or removing a
record from a btree can cause a multi-level tree merge operation and
that will free multiple blocks from the btree in a single
transaction. i.e. we can call xfs_free_extent() multiple times, and
hence the btree manipulation transaction is vulnerable to this busy
extent deadlock vector.

To fix this, convert all the remaining callers of xfs_free_extent()
to use xfs_free_extent_later() to queue XEFIs and hence defer
processing of the extent frees to a context that can be safely
restarted if a deadlock condition is detected.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Chandan Babu R <chandan.babu@oracle.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_ag.c             | 2 +-
 fs/xfs/libxfs/xfs_alloc.c          | 4 ++++
 fs/xfs/libxfs/xfs_alloc.h          | 8 +++++---
 fs/xfs/libxfs/xfs_bmap.c           | 8 +++++---
 fs/xfs/libxfs/xfs_bmap_btree.c     | 3 ++-
 fs/xfs/libxfs/xfs_ialloc.c         | 8 ++++----
 fs/xfs/libxfs/xfs_ialloc_btree.c   | 3 +--
 fs/xfs/libxfs/xfs_refcount.c       | 9 ++++++---
 fs/xfs/libxfs/xfs_refcount_btree.c | 8 +-------
 fs/xfs/xfs_extfree_item.c          | 3 ++-
 fs/xfs/xfs_reflink.c               | 3 ++-
 11 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index ee0d56854b83..e03bfeacbed4 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
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
diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index af447605051b..e44f3f5c6d27 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
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
 
diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index cfc9dcdc1753..bbedb18651de 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
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
 
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 29781a124323..aac071e4d000 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
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
 
diff --git a/fs/xfs/libxfs/xfs_bmap_btree.c b/fs/xfs/libxfs/xfs_bmap_btree.c
index bac2a6496a8e..57f401f2492d 100644
--- a/fs/xfs/libxfs/xfs_bmap_btree.c
+++ b/fs/xfs/libxfs/xfs_bmap_btree.c
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
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 448ea76d50f8..d1472cbd48ff 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
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
diff --git a/fs/xfs/libxfs/xfs_ialloc_btree.c b/fs/xfs/libxfs/xfs_ialloc_btree.c
index 2dbe553d87fb..7125447cde1a 100644
--- a/fs/xfs/libxfs/xfs_ialloc_btree.c
+++ b/fs/xfs/libxfs/xfs_ialloc_btree.c
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
diff --git a/fs/xfs/libxfs/xfs_refcount.c b/fs/xfs/libxfs/xfs_refcount.c
index fec1ad95988c..4ec7a81dd3ef 100644
--- a/fs/xfs/libxfs/xfs_refcount.c
+++ b/fs/xfs/libxfs/xfs_refcount.c
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
diff --git a/fs/xfs/libxfs/xfs_refcount_btree.c b/fs/xfs/libxfs/xfs_refcount_btree.c
index 3d8e62da2ccc..fbd53b6951a9 100644
--- a/fs/xfs/libxfs/xfs_refcount_btree.c
+++ b/fs/xfs/libxfs/xfs_refcount_btree.c
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
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index c1aae07467c9..b670863d8467 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
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
 
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index ee187e90d943..1bac6a8af970 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
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
-- 
2.49.0.rc1.451.g8f38331e32-goog


