Return-Path: <stable+bounces-142223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDF9AAE998
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D0A47BC2BD
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3781B414A;
	Wed,  7 May 2025 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cfyHvuky"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C71A29A;
	Wed,  7 May 2025 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643591; cv=none; b=cG9ka7bNd/RJnYs32YhEwQl+baP2vLFWJ86hQNKrlT230zhp7sEa+CEiqcBund6OuAp3LtZk2DO7LJgWL5q6TIRr1yNY9TUfOWlUnT5og4t9Tpf5YJHpoaiF+tx4by+8EnVEHmapqU334d6nwqJCxuNVUuzdeDHXa+kpDW9NdXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643591; c=relaxed/simple;
	bh=2Ub684UdFPfyEAXTYbeQyvKpdBTZkSrBNImJlekKcT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJmhhrf7ZFWfL+l5qoADPM14ZteutnRSYIXVsXlBeMLqX4BuRBV7wDPRVXEkmoy9oVhI2odLjEBvbOCEFTvH7sm/dKSTFEFo+aZXB6Mz2xAhj3PlNAIWQdviEaS+2FQ+1CcoHLadrdb7VhvVWVYamCrKS4Lj++cdUq1/BheocDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cfyHvuky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2B6C4CEE2;
	Wed,  7 May 2025 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643591;
	bh=2Ub684UdFPfyEAXTYbeQyvKpdBTZkSrBNImJlekKcT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cfyHvukyYalpVnjdT6XRgIfE+zIzIyyiuB07jocs/Rn4BZCyx9XBvNHUjS8RX9igt
	 afcqDgJkq6IArLKPJOf0OnKAXngORAoJoAZUPTgcPSmuNv8HO0DJQVwLqqGMcSyYhk
	 TUogtEKLNiqk2XWQ5QtOjNUqG0jTVNN2fH2QfW4A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?=E5=88=98=E9=80=9A?= <lyutoon@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 23/97] xfs: fix error returns from xfs_bmapi_write
Date: Wed,  7 May 2025 20:38:58 +0200
Message-ID: <20250507183807.914932329@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183806.987408728@linuxfoundation.org>
References: <20250507183806.987408728@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/libxfs/xfs_attr_remote.c |    1 
 fs/xfs/libxfs/xfs_bmap.c        |   46 ++++++++++++++++++++++++++++++++--------
 fs/xfs/libxfs/xfs_da_btree.c    |   20 ++++-------------
 fs/xfs/xfs_bmap_util.c          |   31 +++++++++++++-------------
 fs/xfs/xfs_dquot.c              |    1 
 fs/xfs/xfs_iomap.c              |    8 ------
 fs/xfs/xfs_reflink.c            |   14 ------------
 fs/xfs/xfs_rtalloc.c            |    2 -
 8 files changed, 57 insertions(+), 66 deletions(-)

--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -619,7 +619,6 @@ xfs_attr_rmtval_set_blk(
 	if (error)
 		return error;
 
-	ASSERT(nmap == 1);
 	ASSERT((map->br_startblock != DELAYSTARTBLOCK) &&
 	       (map->br_startblock != HOLESTARTBLOCK));
 
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4113,8 +4113,10 @@ xfs_bmapi_allocate(
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
@@ -4294,6 +4296,15 @@ xfs_bmapi_finish(
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
@@ -4421,10 +4432,16 @@ xfs_bmapi_write(
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
@@ -4462,7 +4479,6 @@ xfs_bmapi_write(
 		if (!xfs_iext_next_extent(ifp, &bma.icur, &bma.got))
 			eof = true;
 	}
-	*nmap = n;
 
 	error = xfs_bmap_btree_to_extents(tp, ip, bma.cur, &bma.logflags,
 			whichfork);
@@ -4473,7 +4489,22 @@ xfs_bmapi_write(
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
@@ -4580,9 +4611,6 @@ xfs_bmapi_convert_delalloc(
 	if (error)
 		goto out_finish;
 
-	error = -ENOSPC;
-	if (WARN_ON_ONCE(bma.blkno == NULLFSBLOCK))
-		goto out_finish;
 	error = -EFSCORRUPTED;
 	if (WARN_ON_ONCE(!xfs_valid_startblock(ip, bma.got.br_startblock)))
 		goto out_finish;
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2158,8 +2158,8 @@ xfs_da_grow_inode_int(
 	struct xfs_inode	*dp = args->dp;
 	int			w = args->whichfork;
 	xfs_rfsblock_t		nblks = dp->i_nblocks;
-	struct xfs_bmbt_irec	map, *mapp;
-	int			nmap, error, got, i, mapi;
+	struct xfs_bmbt_irec	map, *mapp = &map;
+	int			nmap, error, got, i, mapi = 1;
 
 	/*
 	 * Find a spot in the file space to put the new block.
@@ -2175,14 +2175,7 @@ xfs_da_grow_inode_int(
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
 
@@ -2199,16 +2192,13 @@ xfs_da_grow_inode_int(
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
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -868,33 +868,32 @@ xfs_alloc_file_space(
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
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -333,7 +333,6 @@ xfs_dquot_disk_alloc(
 		goto err_cancel;
 
 	ASSERT(map.br_blockcount == XFS_DQUOT_CLUSTER_SIZE_FSB);
-	ASSERT(nmaps == 1);
 	ASSERT((map.br_startblock != DELAYSTARTBLOCK) &&
 	       (map.br_startblock != HOLESTARTBLOCK));
 
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -309,14 +309,6 @@ xfs_iomap_write_direct(
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
 
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -431,13 +431,6 @@ xfs_reflink_fill_cow_hole(
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
 
@@ -500,13 +493,6 @@ xfs_reflink_fill_delalloc(
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
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -840,8 +840,6 @@ xfs_growfs_rt_alloc(
 		nmap = 1;
 		error = xfs_bmapi_write(tp, ip, oblocks, nblocks - oblocks,
 					XFS_BMAPI_METADATA, 0, &map, &nmap);
-		if (!error && nmap < 1)
-			error = -ENOSPC;
 		if (error)
 			goto out_trans_cancel;
 		/*



