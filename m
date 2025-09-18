Return-Path: <stable+bounces-173166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC66B35B93
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56423AD9E1
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229BD2BE653;
	Tue, 26 Aug 2025 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oj2AE+6d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D436C17332C;
	Tue, 26 Aug 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207542; cv=none; b=QIPcFLUYVGBQHYLiiv7QsSnf7sdj3OnEhP7CSjavhQIFdX0CSqqISDww24BLtTqSGc+7Qw3khTyb65K7QCry52LEZkHEW18RI7aSEc0kaN85gzSEbWAE4vhbDy1IKGDLjSFn27x/UTbVArz0cpLQkv/ovinUZxf9+MfpRMmHQVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207542; c=relaxed/simple;
	bh=f9pccDxfzVwyTTICtt84hd0r6n6TUE3MSp5WgNiSEVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZcuObVl82Zk7z9KOhmWPdGtyUGkxl+0xM0xvkLUa6ZWeNlqqKCEg033imb4j557RZcsSmU9Z8VKJD7qXNsgwCrnK1E4m7q+WgqIOgSqGDIIiiAaGDupqBJ4BtqPjlqiDq5Ih0/hBx81YVQjIcCHMZXtsnjaRcDF/qP1ypvTH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oj2AE+6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E75DC4CEF1;
	Tue, 26 Aug 2025 11:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207542;
	bh=f9pccDxfzVwyTTICtt84hd0r6n6TUE3MSp5WgNiSEVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oj2AE+6dngGGi2tWw0T0tXe2eGYCHRiTTvY5x7BsGaU3Q62dYjaD3PkH9O3DVyPOq
	 lJ3k2sVGiTWyr75eMlCWbRSs9AnIh+yBgZ/yWF4Y2mS/wnC4Soa5CMvM0wyHQJh8w4
	 hvdBNdhyugTqilDxyjgHexMpxCihA48JSukZzzjQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 223/457] xfs: return the allocated transaction from xfs_trans_alloc_empty
Date: Tue, 26 Aug 2025 13:08:27 +0200
Message-ID: <20250826110942.879800228@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit d8e1ea43e5a314bc01ec059ce93396639dcf9112 ]

xfs_trans_alloc_empty can't return errors, so return the allocated
transaction directly instead of an output double pointer argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: d2845519b072 ("xfs: fully decouple XFS_IBULK* flags from XFS_IWALK* flags")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/libxfs/xfs_refcount.c |    4 +---
 fs/xfs/scrub/common.c        |    3 ++-
 fs/xfs/scrub/repair.c        |   12 ++----------
 fs/xfs/scrub/scrub.c         |    5 +----
 fs/xfs/xfs_attr_item.c       |    5 +----
 fs/xfs/xfs_discard.c         |   12 +++---------
 fs/xfs/xfs_fsmap.c           |    4 +---
 fs/xfs/xfs_icache.c          |    5 +----
 fs/xfs/xfs_inode.c           |    7 ++-----
 fs/xfs/xfs_itable.c          |   18 +++---------------
 fs/xfs/xfs_iwalk.c           |   11 +++--------
 fs/xfs/xfs_notify_failure.c  |    5 +----
 fs/xfs/xfs_qm.c              |   10 ++--------
 fs/xfs/xfs_rtalloc.c         |   13 +++----------
 fs/xfs/xfs_trans.c           |    8 +++-----
 fs/xfs/xfs_trans.h           |    3 +--
 fs/xfs/xfs_zone_gc.c         |    5 +----
 17 files changed, 31 insertions(+), 99 deletions(-)

--- a/fs/xfs/libxfs/xfs_refcount.c
+++ b/fs/xfs/libxfs/xfs_refcount.c
@@ -2099,9 +2099,7 @@ xfs_refcount_recover_cow_leftovers(
 	 * recording the CoW debris we cancel the (empty) transaction
 	 * and everything goes away cleanly.
 	 */
-	error = xfs_trans_alloc_empty(mp, &tp);
-	if (error)
-		return error;
+	tp = xfs_trans_alloc_empty(mp);
 
 	if (isrt) {
 		xfs_rtgroup_lock(to_rtg(xg), XFS_RTGLOCK_REFCOUNT);
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -870,7 +870,8 @@ int
 xchk_trans_alloc_empty(
 	struct xfs_scrub	*sc)
 {
-	return xfs_trans_alloc_empty(sc->mp, &sc->tp);
+	sc->tp = xfs_trans_alloc_empty(sc->mp);
+	return 0;
 }
 
 /*
--- a/fs/xfs/scrub/repair.c
+++ b/fs/xfs/scrub/repair.c
@@ -1279,18 +1279,10 @@ xrep_trans_alloc_hook_dummy(
 	void			**cookiep,
 	struct xfs_trans	**tpp)
 {
-	int			error;
-
 	*cookiep = current->journal_info;
 	current->journal_info = NULL;
-
-	error = xfs_trans_alloc_empty(mp, tpp);
-	if (!error)
-		return 0;
-
-	current->journal_info = *cookiep;
-	*cookiep = NULL;
-	return error;
+	*tpp = xfs_trans_alloc_empty(mp);
+	return 0;
 }
 
 /* Cancel a dummy transaction used by a live update hook function. */
--- a/fs/xfs/scrub/scrub.c
+++ b/fs/xfs/scrub/scrub.c
@@ -876,10 +876,7 @@ xchk_scrubv_open_by_handle(
 	struct xfs_inode		*ip;
 	int				error;
 
-	error = xfs_trans_alloc_empty(mp, &tp);
-	if (error)
-		return NULL;
-
+	tp = xfs_trans_alloc_empty(mp);
 	error = xfs_iget(mp, tp, head->svh_ino, XCHK_IGET_FLAGS, 0, &ip);
 	xfs_trans_cancel(tp);
 	if (error)
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -616,10 +616,7 @@ xfs_attri_iread_extents(
 	struct xfs_trans		*tp;
 	int				error;
 
-	error = xfs_trans_alloc_empty(ip->i_mount, &tp);
-	if (error)
-		return error;
-
+	tp = xfs_trans_alloc_empty(ip->i_mount);
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	error = xfs_iread_extents(tp, ip, XFS_ATTR_FORK);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -189,9 +189,7 @@ xfs_trim_gather_extents(
 	 */
 	xfs_log_force(mp, XFS_LOG_SYNC);
 
-	error = xfs_trans_alloc_empty(mp, &tp);
-	if (error)
-		return error;
+	tp = xfs_trans_alloc_empty(mp);
 
 	error = xfs_alloc_read_agf(pag, tp, 0, &agbp);
 	if (error)
@@ -583,9 +581,7 @@ xfs_trim_rtextents(
 	struct xfs_trans	*tp;
 	int			error;
 
-	error = xfs_trans_alloc_empty(mp, &tp);
-	if (error)
-		return error;
+	tp = xfs_trans_alloc_empty(mp);
 
 	/*
 	 * Walk the free ranges between low and high.  The query_range function
@@ -701,9 +697,7 @@ xfs_trim_rtgroup_extents(
 	struct xfs_trans	*tp;
 	int			error;
 
-	error = xfs_trans_alloc_empty(mp, &tp);
-	if (error)
-		return error;
+	tp = xfs_trans_alloc_empty(mp);
 
 	/*
 	 * Walk the free ranges between low and high.  The query_range function
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -1270,9 +1270,7 @@ xfs_getfsmap(
 		 * buffer locking abilities to detect cycles in the rmapbt
 		 * without deadlocking.
 		 */
-		error = xfs_trans_alloc_empty(mp, &tp);
-		if (error)
-			break;
+		tp = xfs_trans_alloc_empty(mp);
 
 		info.dev = handlers[i].dev;
 		info.last = false;
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -893,10 +893,7 @@ xfs_metafile_iget(
 	struct xfs_trans	*tp;
 	int			error;
 
-	error = xfs_trans_alloc_empty(mp, &tp);
-	if (error)
-		return error;
-
+	tp = xfs_trans_alloc_empty(mp);
 	error = xfs_trans_metafile_iget(tp, ino, metafile_type, ipp);
 	xfs_trans_cancel(tp);
 	return error;
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2932,12 +2932,9 @@ xfs_inode_reload_unlinked(
 	struct xfs_inode	*ip)
 {
 	struct xfs_trans	*tp;
-	int			error;
-
-	error = xfs_trans_alloc_empty(ip->i_mount, &tp);
-	if (error)
-		return error;
+	int			error = 0;
 
+	tp = xfs_trans_alloc_empty(ip->i_mount);
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
 	if (xfs_inode_unlinked_incomplete(ip))
 		error = xfs_inode_reload_unlinked_bucket(tp, ip);
--- a/fs/xfs/xfs_itable.c
+++ b/fs/xfs/xfs_itable.c
@@ -239,14 +239,10 @@ xfs_bulkstat_one(
 	 * Grab an empty transaction so that we can use its recursive buffer
 	 * locking abilities to detect cycles in the inobt without deadlocking.
 	 */
-	error = xfs_trans_alloc_empty(breq->mp, &tp);
-	if (error)
-		goto out;
-
+	tp = xfs_trans_alloc_empty(breq->mp);
 	error = xfs_bulkstat_one_int(breq->mp, breq->idmap, tp,
 			breq->startino, &bc);
 	xfs_trans_cancel(tp);
-out:
 	kfree(bc.buf);
 
 	/*
@@ -331,17 +327,13 @@ xfs_bulkstat(
 	 * Grab an empty transaction so that we can use its recursive buffer
 	 * locking abilities to detect cycles in the inobt without deadlocking.
 	 */
-	error = xfs_trans_alloc_empty(breq->mp, &tp);
-	if (error)
-		goto out;
-
+	tp = xfs_trans_alloc_empty(breq->mp);
 	if (breq->flags & XFS_IBULK_SAME_AG)
 		iwalk_flags |= XFS_IWALK_SAME_AG;
 
 	error = xfs_iwalk(breq->mp, tp, breq->startino, iwalk_flags,
 			xfs_bulkstat_iwalk, breq->icount, &bc);
 	xfs_trans_cancel(tp);
-out:
 	kfree(bc.buf);
 
 	/*
@@ -464,14 +456,10 @@ xfs_inumbers(
 	 * Grab an empty transaction so that we can use its recursive buffer
 	 * locking abilities to detect cycles in the inobt without deadlocking.
 	 */
-	error = xfs_trans_alloc_empty(breq->mp, &tp);
-	if (error)
-		goto out;
-
+	tp = xfs_trans_alloc_empty(breq->mp);
 	error = xfs_inobt_walk(breq->mp, tp, breq->startino, breq->flags,
 			xfs_inumbers_walk, breq->icount, &ic);
 	xfs_trans_cancel(tp);
-out:
 
 	/*
 	 * We found some inode groups, so clear the error status and return
--- a/fs/xfs/xfs_iwalk.c
+++ b/fs/xfs/xfs_iwalk.c
@@ -377,11 +377,8 @@ xfs_iwalk_run_callbacks(
 	if (!has_more)
 		return 0;
 
-	if (iwag->drop_trans) {
-		error = xfs_trans_alloc_empty(mp, &iwag->tp);
-		if (error)
-			return error;
-	}
+	if (iwag->drop_trans)
+		iwag->tp = xfs_trans_alloc_empty(mp);
 
 	/* ...and recreate the cursor just past where we left off. */
 	error = xfs_ialloc_read_agi(iwag->pag, iwag->tp, 0, agi_bpp);
@@ -617,9 +614,7 @@ xfs_iwalk_ag_work(
 	 * Grab an empty transaction so that we can use its recursive buffer
 	 * locking abilities to detect cycles in the inobt without deadlocking.
 	 */
-	error = xfs_trans_alloc_empty(mp, &iwag->tp);
-	if (error)
-		goto out;
+	iwag->tp = xfs_trans_alloc_empty(mp);
 	iwag->drop_trans = 1;
 
 	error = xfs_iwalk_ag(iwag);
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -279,10 +279,7 @@ xfs_dax_notify_dev_failure(
 		kernel_frozen = xfs_dax_notify_failure_freeze(mp) == 0;
 	}
 
-	error = xfs_trans_alloc_empty(mp, &tp);
-	if (error)
-		goto out;
-
+	tp = xfs_trans_alloc_empty(mp);
 	start_gno = xfs_fsb_to_gno(mp, start_bno, type);
 	end_gno = xfs_fsb_to_gno(mp, end_bno, type);
 	while ((xg = xfs_group_next_range(mp, xg, start_gno, end_gno, type))) {
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -660,10 +660,7 @@ xfs_qm_load_metadir_qinos(
 	struct xfs_trans	*tp;
 	int			error;
 
-	error = xfs_trans_alloc_empty(mp, &tp);
-	if (error)
-		return error;
-
+	tp = xfs_trans_alloc_empty(mp);
 	error = xfs_dqinode_load_parent(tp, &qi->qi_dirip);
 	if (error == -ENOENT) {
 		/* no quota dir directory, but we'll create one later */
@@ -1755,10 +1752,7 @@ xfs_qm_qino_load(
 	struct xfs_inode	*dp = NULL;
 	int			error;
 
-	error = xfs_trans_alloc_empty(mp, &tp);
-	if (error)
-		return error;
-
+	tp = xfs_trans_alloc_empty(mp);
 	if (xfs_has_metadir(mp)) {
 		error = xfs_dqinode_load_parent(tp, &dp);
 		if (error)
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -729,9 +729,7 @@ xfs_rtginode_ensure(
 	if (rtg->rtg_inodes[type])
 		return 0;
 
-	error = xfs_trans_alloc_empty(rtg_mount(rtg), &tp);
-	if (error)
-		return error;
+	tp = xfs_trans_alloc_empty(rtg_mount(rtg));
 	error = xfs_rtginode_load(rtg, type, tp);
 	xfs_trans_cancel(tp);
 
@@ -1305,9 +1303,7 @@ xfs_growfs_rt_prep_groups(
 	if (!mp->m_rtdirip) {
 		struct xfs_trans	*tp;
 
-		error = xfs_trans_alloc_empty(mp, &tp);
-		if (error)
-			return error;
+		tp = xfs_trans_alloc_empty(mp);
 		error = xfs_rtginode_load_parent(tp);
 		xfs_trans_cancel(tp);
 
@@ -1674,10 +1670,7 @@ xfs_rtmount_inodes(
 	struct xfs_rtgroup	*rtg = NULL;
 	int			error;
 
-	error = xfs_trans_alloc_empty(mp, &tp);
-	if (error)
-		return error;
-
+	tp = xfs_trans_alloc_empty(mp);
 	if (xfs_has_rtgroups(mp) && mp->m_sb.sb_rgcount > 0) {
 		error = xfs_rtginode_load_parent(tp);
 		if (error)
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -329,13 +329,11 @@ retry:
  * where we can be grabbing buffers at the same time that freeze is trying to
  * drain the buffer LRU list.
  */
-int
+struct xfs_trans *
 xfs_trans_alloc_empty(
-	struct xfs_mount		*mp,
-	struct xfs_trans		**tpp)
+	struct xfs_mount		*mp)
 {
-	*tpp = __xfs_trans_alloc(mp, XFS_TRANS_NO_WRITECOUNT);
-	return 0;
+	return __xfs_trans_alloc(mp, XFS_TRANS_NO_WRITECOUNT);
 }
 
 /*
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -168,8 +168,7 @@ int		xfs_trans_alloc(struct xfs_mount *m
 			struct xfs_trans **tpp);
 int		xfs_trans_reserve_more(struct xfs_trans *tp,
 			unsigned int blocks, unsigned int rtextents);
-int		xfs_trans_alloc_empty(struct xfs_mount *mp,
-			struct xfs_trans **tpp);
+struct xfs_trans *xfs_trans_alloc_empty(struct xfs_mount *mp);
 void		xfs_trans_mod_sb(xfs_trans_t *, uint, int64_t);
 
 int xfs_trans_get_buf_map(struct xfs_trans *tp, struct xfs_buftarg *target,
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -328,10 +328,7 @@ xfs_zone_gc_query(
 	iter->rec_idx = 0;
 	iter->rec_count = 0;
 
-	error = xfs_trans_alloc_empty(mp, &tp);
-	if (error)
-		return error;
-
+	tp = xfs_trans_alloc_empty(mp);
 	xfs_rtgroup_lock(rtg, XFS_RTGLOCK_RMAP);
 	cur = xfs_rtrmapbt_init_cursor(tp, rtg);
 	error = xfs_rmap_query_range(cur, &ri_low, &ri_high,



