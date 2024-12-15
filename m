Return-Path: <stable+bounces-104244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E1A9F22A4
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BA0165C11
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753EB47F69;
	Sun, 15 Dec 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xjRLrf9/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B97483
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734251874; cv=none; b=Vaqsovp9tJiQs2wIGpsN9WWXzSPl2BZ7udlpPgKq4oYjrr4jHeTs1Y8KZZT7E05Sszw68dNTgDlnD1C6RlZ7xlFO2OpeyArYOw/eEESGjcOJtI7yDudJuYRItvlQl3Np01KLZ/EkBtv0XPhBH3/tU11XYIOT5L+E15MYE656XZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734251874; c=relaxed/simple;
	bh=EdGigVVUxTCPUpRj9/BTeoLL/fACK7PUIp+p9dymID4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xji5xJ73UUOSRH69QI92HvmVNjiJZkopigVSdC2HheATKzlmalqVbhZzaH/afK0g3N49Srl2d6zpLc1QAX32fpVuNV9crveXkTcvsJ3D9sNsOUY0RO4E+fpTHRPSJVkpbSEgslL1odLbKqko7Y6dyXB22kR0c8IKNNEYJxGSbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xjRLrf9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63268C4CECE;
	Sun, 15 Dec 2024 08:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734251873;
	bh=EdGigVVUxTCPUpRj9/BTeoLL/fACK7PUIp+p9dymID4=;
	h=Subject:To:Cc:From:Date:From;
	b=xjRLrf9/bGLQ/WDPrxyluwGHAa5oDmSK7tA++Emb1NeQoUgZWn99lMqa186h2VkKW
	 BZBUwUrMC0kzi32MLXH3YYgnt9Jyjgqtn0LMPtPXYhqYOV0UXlaLtCbUgBZ65J75zm
	 Q6cYcjAuGmvw1qHyo5qHDPB4X8zOcKjbzyQJiC+Y=
Subject: FAILED: patch "[PATCH] xfs: return a 64-bit block count from xfs_btree_count_blocks" failed to apply to 6.1-stable tree
To: djwong@kernel.org,hch@lst.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:37:42 +0100
Message-ID: <2024121541-preamble-bash-0363@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bd27c7bcdca25ce8067ebb94ded6ac1bd7b47317
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121541-preamble-bash-0363@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bd27c7bcdca25ce8067ebb94ded6ac1bd7b47317 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 2 Dec 2024 10:57:26 -0800
Subject: [PATCH] xfs: return a 64-bit block count from xfs_btree_count_blocks

With the nrext64 feature enabled, it's possible for a data fork to have
2^48 extent mappings.  Even with a 64k fsblock size, that maps out to
a bmbt containing more than 2^32 blocks.  Therefore, this predicate must
return a u64 count to avoid an integer wraparound that will cause scrub
to do the wrong thing.

It's unlikely that any such filesystem currently exists, because the
incore bmbt would consume more than 64GB of kernel memory on its own,
and so far nobody except me has driven a filesystem that far, judging
from the lack of complaints.

Cc: <stable@vger.kernel.org> # v5.19
Fixes: df9ad5cc7a5240 ("xfs: Introduce macros to represent new maximum extent counts for data/attr forks")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>

diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 2b5fc5fd1643..c748866ef923 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -5144,7 +5144,7 @@ xfs_btree_count_blocks_helper(
 	int			level,
 	void			*data)
 {
-	xfs_extlen_t		*blocks = data;
+	xfs_filblks_t		*blocks = data;
 	(*blocks)++;
 
 	return 0;
@@ -5154,7 +5154,7 @@ xfs_btree_count_blocks_helper(
 int
 xfs_btree_count_blocks(
 	struct xfs_btree_cur	*cur,
-	xfs_extlen_t		*blocks)
+	xfs_filblks_t		*blocks)
 {
 	*blocks = 0;
 	return xfs_btree_visit_blocks(cur, xfs_btree_count_blocks_helper,
diff --git a/fs/xfs/libxfs/xfs_btree.h b/fs/xfs/libxfs/xfs_btree.h
index 3b739459ebb0..c5bff273cae2 100644
--- a/fs/xfs/libxfs/xfs_btree.h
+++ b/fs/xfs/libxfs/xfs_btree.h
@@ -484,7 +484,7 @@ typedef int (*xfs_btree_visit_blocks_fn)(struct xfs_btree_cur *cur, int level,
 int xfs_btree_visit_blocks(struct xfs_btree_cur *cur,
 		xfs_btree_visit_blocks_fn fn, unsigned int flags, void *data);
 
-int xfs_btree_count_blocks(struct xfs_btree_cur *cur, xfs_extlen_t *blocks);
+int xfs_btree_count_blocks(struct xfs_btree_cur *cur, xfs_filblks_t *blocks);
 
 union xfs_btree_rec *xfs_btree_rec_addr(struct xfs_btree_cur *cur, int n,
 		struct xfs_btree_block *block);
diff --git a/fs/xfs/libxfs/xfs_ialloc_btree.c b/fs/xfs/libxfs/xfs_ialloc_btree.c
index 9b34896dd1a3..6f270d8f4270 100644
--- a/fs/xfs/libxfs/xfs_ialloc_btree.c
+++ b/fs/xfs/libxfs/xfs_ialloc_btree.c
@@ -744,6 +744,7 @@ xfs_finobt_count_blocks(
 {
 	struct xfs_buf		*agbp = NULL;
 	struct xfs_btree_cur	*cur;
+	xfs_filblks_t		blocks;
 	int			error;
 
 	error = xfs_ialloc_read_agi(pag, tp, 0, &agbp);
@@ -751,9 +752,10 @@ xfs_finobt_count_blocks(
 		return error;
 
 	cur = xfs_finobt_init_cursor(pag, tp, agbp);
-	error = xfs_btree_count_blocks(cur, tree_blocks);
+	error = xfs_btree_count_blocks(cur, &blocks);
 	xfs_btree_del_cursor(cur, error);
 	xfs_trans_brelse(tp, agbp);
+	*tree_blocks = blocks;
 
 	return error;
 }
diff --git a/fs/xfs/scrub/agheader.c b/fs/xfs/scrub/agheader.c
index 61f80a6410c7..1d41b85478da 100644
--- a/fs/xfs/scrub/agheader.c
+++ b/fs/xfs/scrub/agheader.c
@@ -458,7 +458,7 @@ xchk_agf_xref_btreeblks(
 {
 	struct xfs_agf		*agf = sc->sa.agf_bp->b_addr;
 	struct xfs_mount	*mp = sc->mp;
-	xfs_agblock_t		blocks;
+	xfs_filblks_t		blocks;
 	xfs_agblock_t		btreeblks;
 	int			error;
 
@@ -507,7 +507,7 @@ xchk_agf_xref_refcblks(
 	struct xfs_scrub	*sc)
 {
 	struct xfs_agf		*agf = sc->sa.agf_bp->b_addr;
-	xfs_agblock_t		blocks;
+	xfs_filblks_t		blocks;
 	int			error;
 
 	if (!sc->sa.refc_cur)
@@ -840,7 +840,7 @@ xchk_agi_xref_fiblocks(
 	struct xfs_scrub	*sc)
 {
 	struct xfs_agi		*agi = sc->sa.agi_bp->b_addr;
-	xfs_agblock_t		blocks;
+	xfs_filblks_t		blocks;
 	int			error = 0;
 
 	if (!xfs_has_inobtcounts(sc->mp))
diff --git a/fs/xfs/scrub/agheader_repair.c b/fs/xfs/scrub/agheader_repair.c
index 0fad0baaba2f..b45d2b32051a 100644
--- a/fs/xfs/scrub/agheader_repair.c
+++ b/fs/xfs/scrub/agheader_repair.c
@@ -256,7 +256,7 @@ xrep_agf_calc_from_btrees(
 	struct xfs_agf		*agf = agf_bp->b_addr;
 	struct xfs_mount	*mp = sc->mp;
 	xfs_agblock_t		btreeblks;
-	xfs_agblock_t		blocks;
+	xfs_filblks_t		blocks;
 	int			error;
 
 	/* Update the AGF counters from the bnobt. */
@@ -946,7 +946,7 @@ xrep_agi_calc_from_btrees(
 	if (error)
 		goto err;
 	if (xfs_has_inobtcounts(mp)) {
-		xfs_agblock_t	blocks;
+		xfs_filblks_t	blocks;
 
 		error = xfs_btree_count_blocks(cur, &blocks);
 		if (error)
@@ -959,7 +959,7 @@ xrep_agi_calc_from_btrees(
 	agi->agi_freecount = cpu_to_be32(freecount);
 
 	if (xfs_has_finobt(mp) && xfs_has_inobtcounts(mp)) {
-		xfs_agblock_t	blocks;
+		xfs_filblks_t	blocks;
 
 		cur = xfs_finobt_init_cursor(sc->sa.pag, sc->tp, agi_bp);
 		error = xfs_btree_count_blocks(cur, &blocks);
diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index 4a50f8e00040..ca23cf4db6c5 100644
--- a/fs/xfs/scrub/fscounters.c
+++ b/fs/xfs/scrub/fscounters.c
@@ -261,7 +261,7 @@ xchk_fscount_btreeblks(
 	struct xchk_fscounters	*fsc,
 	xfs_agnumber_t		agno)
 {
-	xfs_extlen_t		blocks;
+	xfs_filblks_t		blocks;
 	int			error;
 
 	error = xchk_ag_init_existing(sc, agno, &sc->sa);
diff --git a/fs/xfs/scrub/ialloc.c b/fs/xfs/scrub/ialloc.c
index abad54c3621d..4dc7c83dc08a 100644
--- a/fs/xfs/scrub/ialloc.c
+++ b/fs/xfs/scrub/ialloc.c
@@ -650,8 +650,8 @@ xchk_iallocbt_xref_rmap_btreeblks(
 	struct xfs_scrub	*sc)
 {
 	xfs_filblks_t		blocks;
-	xfs_extlen_t		inobt_blocks = 0;
-	xfs_extlen_t		finobt_blocks = 0;
+	xfs_filblks_t		inobt_blocks = 0;
+	xfs_filblks_t		finobt_blocks = 0;
 	int			error;
 
 	if (!sc->sa.ino_cur || !sc->sa.rmap_cur ||
diff --git a/fs/xfs/scrub/refcount.c b/fs/xfs/scrub/refcount.c
index 2b6be75e9424..1c5e45cc6419 100644
--- a/fs/xfs/scrub/refcount.c
+++ b/fs/xfs/scrub/refcount.c
@@ -491,7 +491,7 @@ xchk_refcount_xref_rmap(
 	struct xfs_scrub	*sc,
 	xfs_filblks_t		cow_blocks)
 {
-	xfs_extlen_t		refcbt_blocks = 0;
+	xfs_filblks_t		refcbt_blocks = 0;
 	xfs_filblks_t		blocks;
 	int			error;
 
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index a59bbe767a7d..0836fea2d6d8 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -103,7 +103,7 @@ xfs_bmap_count_blocks(
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, whichfork);
 	struct xfs_btree_cur	*cur;
-	xfs_extlen_t		btblocks = 0;
+	xfs_filblks_t		btblocks = 0;
 	int			error;
 
 	*nextents = 0;


