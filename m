Return-Path: <stable+bounces-192866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44639C44A11
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 00:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AEA94E5D48
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 23:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327D826B2DA;
	Sun,  9 Nov 2025 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVZxxWmC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D561891AB
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730461; cv=none; b=dYUoANX41ZezlnJBj86zI2qQwGWeaXQWYT9HCZobdfca1ZzTZFI0bI8Xv75bQdZR4UlezmEy+yrGDxZfkw+H+C39ALHH/wX+Zk0NZlJi8BLavtt6ghnzt4kIY69Or2/bhrCiiTxEHRXL/I6PcKZ8vQCmq+Lsxwj5wFrZruXiUUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730461; c=relaxed/simple;
	bh=/0NZjPH2ixO48OZtGHo7zUvXuz/jI1FNjrh9vnqmHso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EolooV8RvLZZL68mDr3ifQaQXZSp2NQGqjStYFQ77J7CMeWqU4iUvaRIAYxY5exh/tzM0abVjlcklRyK9aBysd1pRyHRfjVorsrWrFGo4Agn1RwOgFnCB9FHjCaAZ/drae4mSfWjpA1fcR2rA8f/5QMcBFn+wiieN6ZrR4p0YFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVZxxWmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6741C19422;
	Sun,  9 Nov 2025 23:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762730460;
	bh=/0NZjPH2ixO48OZtGHo7zUvXuz/jI1FNjrh9vnqmHso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVZxxWmCkFLOHw/QBKF5trltJtlTkOY2sqrono46pNQWUcN9w6mncRe403NP5E04Q
	 psLhtsJ4pJoBumVeZyHNOAd7cv13ulu+jkNJXCxrFNdoJkoTBOj/R3rdVTdMyX4FAe
	 14lznlaVWleQKH8NdP7qgkga31ass8zGPksxaBEMKAo08ioUFVdyupCUONBhsTZY58
	 uZbvSN+FiAWpNLtVBAeSFdcaBr6smBRrXQI3n8TH/CAOFqxASG+A76Cjb635ChwQxD
	 FtaFoSVtCcUo47C02I9FNk4DU95DFvdoljXsFtSohAGn8inychcifYoUlBN8tt/i7i
	 FDlMN/w/CbNBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/2] xfs: fix various problems in xfs_atomic_write_cow_iomap_begin
Date: Sun,  9 Nov 2025 18:20:57 -0500
Message-ID: <20251109232057.531285-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109232057.531285-1-sashal@kernel.org>
References: <2025110942-language-suspect-13bc@gregkh>
 <20251109232057.531285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 8d7bba1e8314013ecc817a91624104ceb9352ddc ]

I think there are several things wrong with this function:

A) xfs_bmapi_write can return a much larger unwritten mapping than what
   the caller asked for.  We convert part of that range to written, but
   return the entire written mapping to iomap even though that's
   inaccurate.

B) The arguments to xfs_reflink_convert_cow_locked are wrong -- an
   unwritten mapping could be *smaller* than the write range (or even
   the hole range).  In this case, we convert too much file range to
   written state because we then return a smaller mapping to iomap.

C) It doesn't handle delalloc mappings.  This I covered in the patch
   that I already sent to the list.

D) Reassigning count_fsb to handle the hole means that if the second
   cmap lookup attempt succeeds (due to racing with someone else) we
   trim the mapping more than is strictly necessary.  The changing
   meaning of count_fsb makes this harder to notice.

E) The tracepoint is kinda wrong because @length is mutated.  That makes
   it harder to chase the data flows through this function because you
   can't just grep on the pos/bytecount strings.

F) We don't actually check that the br_state = XFS_EXT_NORM assignment
   is accurate, i.e that the cow fork actually contains a written
   mapping for the range we're interested in

G) Somewhat inadequate documentation of why we need to xfs_trim_extent
   so aggressively in this function.

H) Not sure why xfs_iomap_end_fsb is used here, the vfs already clamped
   the write range to s_maxbytes.

Fix these issues, and then the atomic writes regressions in generic/760,
generic/617, generic/091, generic/263, and generic/521 all go away for
me.

Cc: stable@vger.kernel.org # v6.16
Fixes: bd1d2c21d5d249 ("xfs: add xfs_atomic_write_cow_iomap_begin()")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_iomap.c | 61 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index a4a22975c7cc9..0cf84b25d6567 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1082,6 +1082,29 @@ const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
 };
 #endif /* CONFIG_XFS_RT */
 
+#ifdef DEBUG
+static void
+xfs_check_atomic_cow_conversion(
+	struct xfs_inode		*ip,
+	xfs_fileoff_t			offset_fsb,
+	xfs_filblks_t			count_fsb,
+	const struct xfs_bmbt_irec	*cmap)
+{
+	struct xfs_iext_cursor		icur;
+	struct xfs_bmbt_irec		cmap2 = { };
+
+	if (xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap2))
+		xfs_trim_extent(&cmap2, offset_fsb, count_fsb);
+
+	ASSERT(cmap2.br_startoff == cmap->br_startoff);
+	ASSERT(cmap2.br_blockcount == cmap->br_blockcount);
+	ASSERT(cmap2.br_startblock == cmap->br_startblock);
+	ASSERT(cmap2.br_state == cmap->br_state);
+}
+#else
+# define xfs_check_atomic_cow_conversion(...)	((void)0)
+#endif
+
 static int
 xfs_atomic_write_cow_iomap_begin(
 	struct inode		*inode,
@@ -1093,9 +1116,10 @@ xfs_atomic_write_cow_iomap_begin(
 {
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
-	const xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
-	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
-	xfs_filblks_t		count_fsb = end_fsb - offset_fsb;
+	const xfs_fileoff_t	offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	const xfs_fileoff_t	end_fsb = XFS_B_TO_FSB(mp, offset + length);
+	const xfs_filblks_t	count_fsb = end_fsb - offset_fsb;
+	xfs_filblks_t		hole_count_fsb;
 	int			nmaps = 1;
 	xfs_filblks_t		resaligned;
 	struct xfs_bmbt_irec	cmap;
@@ -1134,14 +1158,20 @@ xfs_atomic_write_cow_iomap_begin(
 	if (cmap.br_startoff <= offset_fsb) {
 		if (isnullstartblock(cmap.br_startblock))
 			goto convert_delay;
+
+		/*
+		 * cmap could extend outside the write range due to previous
+		 * speculative preallocations.  We must trim cmap to the write
+		 * range because the cow fork treats written mappings to mean
+		 * "write in progress".
+		 */
 		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
 		goto found;
 	}
 
-	end_fsb = cmap.br_startoff;
-	count_fsb = end_fsb - offset_fsb;
+	hole_count_fsb = cmap.br_startoff - offset_fsb;
 
-	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
+	resaligned = xfs_aligned_fsb_count(offset_fsb, hole_count_fsb,
 			xfs_get_cowextsz_hint(ip));
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 
@@ -1177,7 +1207,7 @@ xfs_atomic_write_cow_iomap_begin(
 	 * atomic writes to that same range will be aligned (and don't require
 	 * this COW-based method).
 	 */
-	error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
+	error = xfs_bmapi_write(tp, ip, offset_fsb, hole_count_fsb,
 			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC |
 			XFS_BMAPI_EXTSZALIGN, 0, &cmap, &nmaps);
 	if (error) {
@@ -1190,17 +1220,26 @@ xfs_atomic_write_cow_iomap_begin(
 	if (error)
 		goto out_unlock;
 
+	/*
+	 * cmap could map more blocks than the range we passed into bmapi_write
+	 * because of EXTSZALIGN or adjacent pre-existing unwritten mappings
+	 * that were merged.  Trim cmap to the original write range so that we
+	 * don't convert more than we were asked to do for this write.
+	 */
+	xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+
 found:
 	if (cmap.br_state != XFS_EXT_NORM) {
-		error = xfs_reflink_convert_cow_locked(ip, offset_fsb,
-				count_fsb);
+		error = xfs_reflink_convert_cow_locked(ip, cmap.br_startoff,
+				cmap.br_blockcount);
 		if (error)
 			goto out_unlock;
 		cmap.br_state = XFS_EXT_NORM;
+		xfs_check_atomic_cow_conversion(ip, offset_fsb, count_fsb,
+				&cmap);
 	}
 
-	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
-	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
+	trace_xfs_iomap_found(ip, offset, length, XFS_COW_FORK, &cmap);
 	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
-- 
2.51.0


