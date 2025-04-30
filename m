Return-Path: <stable+bounces-139228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0C3AA575C
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F734C2621
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E772D0AD2;
	Wed, 30 Apr 2025 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIEqBY/k"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24A2D0AC9
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048434; cv=none; b=kU0alpCxCl1sQU1IDsi/SPzs6wKmfj+pqr2nVWKY8QAFFIvCqcYBm+V4tbnbBksCkqsMYLmTxPHSQD/dQXN4R404sgEYO95hp3b60FP8HCbTnb49IhkBZT9EfIHICBcCyJiHWre3BvqYMg4uL9uqIYAJHGHrLEwuZNJYFK+Whlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048434; c=relaxed/simple;
	bh=qlyj66biuu609NN5V8cIBYCPHQ8xfLpTd1Nbe5RoeTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AE86Kdy+OCBefqe8UL7J4bpOxNHLooE9qVXn2so48f7iaI0y0rEDZ/uwrjubOJWE1ckhrGxIdgL0vn0voPLfWVyXRyDzlTF1tVId8YgqqVBOOBGXzDAnYA9Jc65+EGSEyOSJJrorMOdRr8fJHFQ+4G7wfSi7c/zplO8Qq1tL1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIEqBY/k; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73712952e1cso413468b3a.1
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048432; x=1746653232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TpMbGDhnJny2vSTVu6X+28OhpUT+ZAD4t+kyJpWZzg=;
        b=WIEqBY/kf38LXCfdEZZuqrcEecmM2vPNlkFnBiaGCFZ7/a8G8EyQT/UW5/jdWt/5gT
         CyeRn2nw4YEYwdrWNRs79BtCD3We7omF6TTi6A8dj7uHMj+IYk96o141LenOQptuD+yC
         uanckjRm3NiOBlykLKV++HGiyUnjSU7CR+fMP9LzgaQlB4eostaKOIi1VW6iDPSpBBwq
         xwwuH5GJUtZxoIOOkscx8I0e7dWxDMZB8aYNHULwW7ssLPCyZ45Fj5ymNG23M+NslzB1
         mgRlf47ZWh9dcne2jWvrDcVvD0B+le/3nG8CtpkO8IlGm+Hu238+snEC1X+dzWZgiNfB
         iG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048432; x=1746653232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TpMbGDhnJny2vSTVu6X+28OhpUT+ZAD4t+kyJpWZzg=;
        b=KwxfjeBf1Y5gbed8MFY6ByxEqp5damCII9c4UItZgc/iDaMLcna0QxtpSdM1sqlrDf
         CLK3252CF2mMi10u4uurjTpp9PnhlEdZ7Tp/B6WvXMQf4KsT/1nDbrEUTE42FhKxjKoU
         FhwNN5u7EcdYyZT+YqZLYmyuYGk/NqEGDW0dmJtPufc0wIDYaFn/GeSOFX5MUfJwcPSu
         kwU/Z0Ql3xpsRWwVqEdZ+c3ptb9HaiUiwyHgWXv32tbcv99kN3DPZtpLvzPr/l4M9EJ3
         wTM5w6owTD9uj+75UO4fbjkPl5tMdRVVQr9KE0SmL2daEfVnedyF6L6ZTKWitEGINr3h
         489g==
X-Gm-Message-State: AOJu0YyFisHDg3KLpFWs74AY3Mm8QdNtVU5Tgp1bmeArAj2FQF+zvGGE
	g79ZJ0nOV6Qw9UgLqeN/1d3Z9zRqBCZq/3YsS0ftsuczqJb5TFrfBQA9zjSS
X-Gm-Gg: ASbGncslc5BeJTpIEY2xwrIF7zWAUl6f6jlzaZsxfjUbUeMg5ohHM2PH5vKzPNeD4sq
	hVL/wgcLuQlwi2txO7n0sFgFTRxNfBE6fnE9cNs9KquMPEkQBQEroos+jKlBaP3DYwH5BQMGk1P
	JnqsfzVkvt0J9Y8Cd4P9nCLdFCRG+Azp3NDJ4+nsAsKTMOjKgEFXcwXSO/YTu+mY4BX4nUYeL3z
	HdXk4Y8qYj8arCY9f33W/Nuu4wNMuBq5m/YQ4n8/1W6xOqSyVfKUbw38kyJZU7nlawl4eO4j39V
	50HNbyzKdUvMmAhT4cXADCHNZl59VFmfvu695DxeUWLN8EWt7jWUCEv+eNXlxN4vayvB
X-Google-Smtp-Source: AGHT+IHzgU02ZSlvbVkQ3D5FFrMgBpQUxk62cCoMgmw4oLgj6ykoz6L9O3x9CTRZjNhbfg/HuhW0kA==
X-Received: by 2002:a05:6a00:2d21:b0:736:491b:536d with SMTP id d2e1a72fcca58-7404792a877mr752793b3a.20.1746048431601;
        Wed, 30 Apr 2025 14:27:11 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:11 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?=E5=88=98=E9=80=9A?= <lyutoon@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 01/16] xfs: fix error returns from xfs_bmapi_write
Date: Wed, 30 Apr 2025 14:26:48 -0700
Message-ID: <20250430212704.2905795-2-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430212704.2905795-1-leah.rumancik@gmail.com>
References: <20250430212704.2905795-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 6773da870ab89123d1b513da63ed59e32a29cb77 ]

xfs_bmapi_write can return 0 without actually returning a mapping in
mval in two different cases:

 1) when there is absolutely no space available to do an allocation
 2) when converting delalloc space, and the allocation is so small
    that it only covers parts of the delalloc extent before the
    range requested by the caller

Callers at best can handle one of these cases, but in many cases can't
cope with either one.  Switch xfs_bmapi_write to always return a
mapping or return an error code instead.  For case 1) above ENOSPC is
the obvious choice which is very much what the callers expect anyway.
For case 2) there is no really good error code, so pick a funky one
from the SysV streams portfolio.

This fixes the reproducer here:

    https://lore.kernel.org/linux-xfs/CAEJPjCvT3Uag-pMTYuigEjWZHn1sGMZ0GCjVVCv29tNHK76Cgg@mail.gmail.com0/

which uses reserved blocks to create file systems that are gravely
out of space and thus cause at least xfs_file_alloc_space to hang
and trigger the lack of ENOSPC handling in xfs_dquot_disk_alloc.

Note that this patch does not actually make any caller but
xfs_alloc_file_space deal intelligently with case 2) above.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: 刘通 <lyutoon@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr_remote.c |  1 -
 fs/xfs/libxfs/xfs_bmap.c        | 46 ++++++++++++++++++++++++++-------
 fs/xfs/libxfs/xfs_da_btree.c    | 20 ++++----------
 fs/xfs/xfs_bmap_util.c          | 31 +++++++++++-----------
 fs/xfs/xfs_dquot.c              |  1 -
 fs/xfs/xfs_iomap.c              |  8 ------
 fs/xfs/xfs_reflink.c            | 14 ----------
 fs/xfs/xfs_rtalloc.c            |  2 --
 8 files changed, 57 insertions(+), 66 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index d440393b40eb..54de405cbab5 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -617,11 +617,10 @@ xfs_attr_rmtval_set_blk(
 			attr->xattri_blkcnt, XFS_BMAPI_ATTRFORK, args->total,
 			map, &nmap);
 	if (error)
 		return error;
 
-	ASSERT(nmap == 1);
 	ASSERT((map->br_startblock != DELAYSTARTBLOCK) &&
 	       (map->br_startblock != HOLESTARTBLOCK));
 
 	/* roll attribute extent map forwards */
 	attr->xattri_lblkno += map->br_blockcount;
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 2a3b78032cb0..0235c1dd3d7e 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4111,12 +4111,14 @@ xfs_bmapi_allocate(
 		else
 			error = xfs_bmap_btalloc(bma);
 	} else {
 		error = xfs_bmap_alloc_userdata(bma);
 	}
-	if (error || bma->blkno == NULLFSBLOCK)
+	if (error)
 		return error;
+	if (bma->blkno == NULLFSBLOCK)
+		return -ENOSPC;
 
 	if (bma->flags & XFS_BMAPI_ZERO) {
 		error = xfs_zero_extent(bma->ip, bma->blkno, bma->length);
 		if (error)
 			return error;
@@ -4292,10 +4294,19 @@ xfs_bmapi_finish(
 /*
  * Map file blocks to filesystem blocks, and allocate blocks or convert the
  * extent state if necessary.  Details behaviour is controlled by the flags
  * parameter.  Only allocates blocks from a single allocation group, to avoid
  * locking problems.
+ *
+ * Returns 0 on success and places the extent mappings in mval.  nmaps is used
+ * as an input/output parameter where the caller specifies the maximum number
+ * of mappings that may be returned and xfs_bmapi_write passes back the number
+ * of mappings (including existing mappings) it found.
+ *
+ * Returns a negative error code on failure, including -ENOSPC when it could not
+ * allocate any blocks and -ENOSR when it did allocate blocks to convert a
+ * delalloc range, but those blocks were before the passed in range.
  */
 int
 xfs_bmapi_write(
 	struct xfs_trans	*tp,		/* transaction pointer */
 	struct xfs_inode	*ip,		/* incore inode */
@@ -4419,14 +4430,20 @@ xfs_bmapi_write(
 				bma.length = len;
 
 			ASSERT(len > 0);
 			ASSERT(bma.length > 0);
 			error = xfs_bmapi_allocate(&bma);
-			if (error)
+			if (error) {
+				/*
+				 * If we already allocated space in a previous
+				 * iteration return what we go so far when
+				 * running out of space.
+				 */
+				if (error == -ENOSPC && bma.nallocs)
+					break;
 				goto error0;
-			if (bma.blkno == NULLFSBLOCK)
-				break;
+			}
 
 			/*
 			 * If this is a CoW allocation, record the data in
 			 * the refcount btree for orphan recovery.
 			 */
@@ -4460,22 +4477,36 @@ xfs_bmapi_write(
 		/* Else go on to the next record. */
 		bma.prev = bma.got;
 		if (!xfs_iext_next_extent(ifp, &bma.icur, &bma.got))
 			eof = true;
 	}
-	*nmap = n;
 
 	error = xfs_bmap_btree_to_extents(tp, ip, bma.cur, &bma.logflags,
 			whichfork);
 	if (error)
 		goto error0;
 
 	ASSERT(ifp->if_format != XFS_DINODE_FMT_BTREE ||
 	       ifp->if_nextents > XFS_IFORK_MAXEXT(ip, whichfork));
 	xfs_bmapi_finish(&bma, whichfork, 0);
 	xfs_bmap_validate_ret(orig_bno, orig_len, orig_flags, orig_mval,
-		orig_nmap, *nmap);
+		orig_nmap, n);
+
+	/*
+	 * When converting delayed allocations, xfs_bmapi_allocate ignores
+	 * the passed in bno and always converts from the start of the found
+	 * delalloc extent.
+	 *
+	 * To avoid a successful return with *nmap set to 0, return the magic
+	 * -ENOSR error code for this particular case so that the caller can
+	 * handle it.
+	 */
+	if (!n) {
+		ASSERT(bma.nallocs >= *nmap);
+		return -ENOSR;
+	}
+	*nmap = n;
 	return 0;
 error0:
 	xfs_bmapi_finish(&bma, whichfork, error);
 	return error;
 }
@@ -4578,13 +4609,10 @@ xfs_bmapi_convert_delalloc(
 
 	error = xfs_bmapi_allocate(&bma);
 	if (error)
 		goto out_finish;
 
-	error = -ENOSPC;
-	if (WARN_ON_ONCE(bma.blkno == NULLFSBLOCK))
-		goto out_finish;
 	error = -EFSCORRUPTED;
 	if (WARN_ON_ONCE(!xfs_valid_startblock(ip, bma.got.br_startblock)))
 		goto out_finish;
 
 	XFS_STATS_ADD(mp, xs_xstrat_bytes, XFS_FSB_TO_B(mp, bma.length));
diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 282c7cf032f4..12e3cca804b7 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2156,61 +2156,51 @@ xfs_da_grow_inode_int(
 {
 	struct xfs_trans	*tp = args->trans;
 	struct xfs_inode	*dp = args->dp;
 	int			w = args->whichfork;
 	xfs_rfsblock_t		nblks = dp->i_nblocks;
-	struct xfs_bmbt_irec	map, *mapp;
-	int			nmap, error, got, i, mapi;
+	struct xfs_bmbt_irec	map, *mapp = &map;
+	int			nmap, error, got, i, mapi = 1;
 
 	/*
 	 * Find a spot in the file space to put the new block.
 	 */
 	error = xfs_bmap_first_unused(tp, dp, count, bno, w);
 	if (error)
 		return error;
 
 	/*
 	 * Try mapping it in one filesystem block.
 	 */
 	nmap = 1;
 	error = xfs_bmapi_write(tp, dp, *bno, count,
 			xfs_bmapi_aflag(w)|XFS_BMAPI_METADATA|XFS_BMAPI_CONTIG,
 			args->total, &map, &nmap);
-	if (error)
-		return error;
-
-	ASSERT(nmap <= 1);
-	if (nmap == 1) {
-		mapp = &map;
-		mapi = 1;
-	} else if (nmap == 0 && count > 1) {
+	if (error == -ENOSPC && count > 1) {
 		xfs_fileoff_t		b;
 		int			c;
 
 		/*
 		 * If we didn't get it and the block might work if fragmented,
 		 * try without the CONTIG flag.  Loop until we get it all.
 		 */
 		mapp = kmem_alloc(sizeof(*mapp) * count, 0);
 		for (b = *bno, mapi = 0; b < *bno + count; ) {
 			c = (int)(*bno + count - b);
 			nmap = min(XFS_BMAP_MAX_NMAP, c);
 			error = xfs_bmapi_write(tp, dp, b, c,
 					xfs_bmapi_aflag(w)|XFS_BMAPI_METADATA,
 					args->total, &mapp[mapi], &nmap);
 			if (error)
 				goto out_free_map;
-			if (nmap < 1)
-				break;
 			mapi += nmap;
 			b = mapp[mapi - 1].br_startoff +
 			    mapp[mapi - 1].br_blockcount;
 		}
-	} else {
-		mapi = 0;
-		mapp = NULL;
 	}
+	if (error)
+		goto out_free_map;
 
 	/*
 	 * Count the blocks we got, make sure it matches the total.
 	 */
 	for (i = 0, got = 0; i < mapi; i++)
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 468bb61a5e46..399451aab26a 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -866,37 +866,36 @@ xfs_alloc_file_space(
 			error = xfs_iext_count_upgrade(tp, ip,
 					XFS_IEXT_ADD_NOSPLIT_CNT);
 		if (error)
 			goto error;
 
-		error = xfs_bmapi_write(tp, ip, startoffset_fsb,
-				allocatesize_fsb, XFS_BMAPI_PREALLOC, 0, imapp,
-				&nimaps);
-		if (error)
-			goto error;
-
-		ip->i_diflags |= XFS_DIFLAG_PREALLOC;
-		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
-
-		error = xfs_trans_commit(tp);
-		xfs_iunlock(ip, XFS_ILOCK_EXCL);
-		if (error)
-			break;
-
 		/*
 		 * If the allocator cannot find a single free extent large
 		 * enough to cover the start block of the requested range,
-		 * xfs_bmapi_write will return 0 but leave *nimaps set to 0.
+		 * xfs_bmapi_write will return -ENOSR.
 		 *
 		 * In that case we simply need to keep looping with the same
 		 * startoffset_fsb so that one of the following allocations
 		 * will eventually reach the requested range.
 		 */
-		if (nimaps) {
+		error = xfs_bmapi_write(tp, ip, startoffset_fsb,
+				allocatesize_fsb, XFS_BMAPI_PREALLOC, 0, imapp,
+				&nimaps);
+		if (error) {
+			if (error != -ENOSR)
+				goto error;
+			error = 0;
+		} else {
 			startoffset_fsb += imapp->br_blockcount;
 			allocatesize_fsb -= imapp->br_blockcount;
 		}
+
+		ip->i_diflags |= XFS_DIFLAG_PREALLOC;
+		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+
+		error = xfs_trans_commit(tp);
+		xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	}
 
 	return error;
 
 error:
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index a8b2f3b278ea..6186b69be50a 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -331,11 +331,10 @@ xfs_dquot_disk_alloc(
 			&nmaps);
 	if (error)
 		goto err_cancel;
 
 	ASSERT(map.br_blockcount == XFS_DQUOT_CLUSTER_SIZE_FSB);
-	ASSERT(nmaps == 1);
 	ASSERT((map.br_startblock != DELAYSTARTBLOCK) &&
 	       (map.br_startblock != HOLESTARTBLOCK));
 
 	/*
 	 * Keep track of the blkno to save a lookup later
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index ab5512c0bcf7..60d9638cec6d 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -307,18 +307,10 @@ xfs_iomap_write_direct(
 	 */
 	error = xfs_trans_commit(tp);
 	if (error)
 		goto out_unlock;
 
-	/*
-	 * Copy any maps to caller's array and return any error.
-	 */
-	if (nimaps == 0) {
-		error = -ENOSPC;
-		goto out_unlock;
-	}
-
 	if (unlikely(!xfs_valid_startblock(ip, imap->br_startblock)))
 		error = xfs_alert_fsblock_zero(ip, imap);
 
 out_unlock:
 	*seq = xfs_iomap_inode_sequence(ip, 0);
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 1bac6a8af970..0405226fb74c 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -429,17 +429,10 @@ xfs_reflink_fill_cow_hole(
 	xfs_inode_set_cowblocks_tag(ip);
 	error = xfs_trans_commit(tp);
 	if (error)
 		return error;
 
-	/*
-	 * Allocation succeeded but the requested range was not even partially
-	 * satisfied?  Bail out!
-	 */
-	if (nimaps == 0)
-		return -ENOSPC;
-
 convert:
 	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
 
 out_trans_cancel:
 	xfs_trans_cancel(tp);
@@ -498,17 +491,10 @@ xfs_reflink_fill_delalloc(
 
 		xfs_inode_set_cowblocks_tag(ip);
 		error = xfs_trans_commit(tp);
 		if (error)
 			return error;
-
-		/*
-		 * Allocation succeeded but the requested range was not even
-		 * partially satisfied?  Bail out!
-		 */
-		if (nimaps == 0)
-			return -ENOSPC;
 	} while (cmap->br_startoff + cmap->br_blockcount <= imap->br_startoff);
 
 	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
 
 out_trans_cancel:
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 7c5134899634..5cf1e91f4c20 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -838,12 +838,10 @@ xfs_growfs_rt_alloc(
 		 * Allocate blocks to the bitmap file.
 		 */
 		nmap = 1;
 		error = xfs_bmapi_write(tp, ip, oblocks, nblocks - oblocks,
 					XFS_BMAPI_METADATA, 0, &map, &nmap);
-		if (!error && nmap < 1)
-			error = -ENOSPC;
 		if (error)
 			goto out_trans_cancel;
 		/*
 		 * Free any blocks freed up in the transaction, then commit.
 		 */
-- 
2.49.0.906.g1f30a19c02-goog


