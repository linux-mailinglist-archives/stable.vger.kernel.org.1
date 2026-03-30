Return-Path: <stable+bounces-231139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGqTKgpLymmb7QUAu9opvQ
	(envelope-from <stable+bounces-231139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:06:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CD1358D72
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 229223068F0E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4F2DCF7D;
	Mon, 30 Mar 2026 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ADpivB8T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC111FF1C7
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864689; cv=none; b=P0vtdz16v3T0WvorVAF8qz0H+nk/XDJqr9A/2GH8qAt8PmV3lpu0UtTBgTiW4PNg+jNS/MwU7iw7MGkCJLffFQHVFOdVt6xL76Rg8yXKcCV/6exqNL+6Uw/jzLS17FyXwmBg5gpUpN3Gh+mt/YCLT52H461mF9hKoka+ji9kPoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864689; c=relaxed/simple;
	bh=p1QsD6uYlO8nvhIOwHwJJyg2FCsICmy9OZ0vIftpRno=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EQgimA8lCEgbv9lYWkmFaaFJul30SZNM+T+j8tdVmKz7t0/r1X5lcl3RJhOdZ16aCwaF4dwKg80pRSfqzfWEZplPGgIiWsk3wERoQIkQ+6siSgMkPktx8Fuq51yWGqBmVF6uI95xRBHXDSW/bDnnv8KsRlQtn9yeVuG22x2vZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ADpivB8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E76C4CEF7;
	Mon, 30 Mar 2026 09:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774864689;
	bh=p1QsD6uYlO8nvhIOwHwJJyg2FCsICmy9OZ0vIftpRno=;
	h=Subject:To:Cc:From:Date:From;
	b=ADpivB8TQmquDKvq/no2USk0DTNftqoE4wZxq79xZ0Ipx/cUwDnlGWJR9qwWn1JjW
	 va5M96AIGPdB4DYtFJ/QE7lbEa/wXcU76vGLZ6BHSJag3R6EEWHTXuFupMQd/SymHe
	 bbV04P/JshS4RLa65JBRDGNMAm0jtDMyjysyTAfc=
Subject: FAILED: patch "[PATCH] xfs: close crash window in attr dabtree inactivation" failed to apply to 5.10-stable tree
To: leo.lilong@huawei.com,cem@kernel.org,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:57:58 +0200
Message-ID: <2026033058-chapped-baggage-be8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231139-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,huawei.com:email]
X-Rspamd-Queue-Id: E2CD1358D72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b854e1c4eff3473b6d3a9ae74129ac5c48bc0b61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033058-chapped-baggage-be8d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b854e1c4eff3473b6d3a9ae74129ac5c48bc0b61 Mon Sep 17 00:00:00 2001
From: Long Li <leo.lilong@huawei.com>
Date: Tue, 17 Mar 2026 09:51:55 +0800
Subject: [PATCH] xfs: close crash window in attr dabtree inactivation

When inactivating an inode with node-format extended attributes,
xfs_attr3_node_inactive() invalidates all child leaf/node blocks via
xfs_trans_binval(), but intentionally does not remove the corresponding
entries from their parent node blocks.  The implicit assumption is that
xfs_attr_inactive() will truncate the entire attr fork to zero extents
afterwards, so log recovery will never reach the root node and follow
those stale pointers.

However, if a log shutdown occurs after the leaf/node block cancellations
commit but before the attr bmap truncation commits, this assumption
breaks.  Recovery replays the attr bmap intact (the inode still has
attr fork extents), but suppresses replay of all cancelled leaf/node
blocks, maybe leaving them as stale data on disk.  On the next mount,
xlog_recover_process_iunlinks() retries inactivation and attempts to
read the root node via the attr bmap. If the root node was not replayed,
reading the unreplayed root block triggers a metadata verification
failure immediately; if it was replayed, following its child pointers
to unreplayed child blocks triggers the same failure:

 XFS (pmem0): Metadata corruption detected at
 xfs_da3_node_read_verify+0x53/0x220, xfs_da3_node block 0x78
 XFS (pmem0): Unmount and run xfs_repair
 XFS (pmem0): First 128 bytes of corrupted metadata buffer:
 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 XFS (pmem0): metadata I/O error in "xfs_da_read_buf+0x104/0x190" at daddr 0x78 len 8 error 117

Fix this in two places:

In xfs_attr3_node_inactive(), after calling xfs_trans_binval() on a
child block, immediately remove the entry that references it from the
parent node in the same transaction.  This eliminates the window where
the parent holds a pointer to a cancelled block.  Once all children are
removed, the now-empty root node is converted to a leaf block within the
same transaction. This node-to-leaf conversion is necessary for crash
safety. If the system shutdown after the empty node is written to the
log but before the second-phase bmap truncation commits, log recovery
will attempt to verify the root block on disk. xfs_da3_node_verify()
does not permit a node block with count == 0; such a block will fail
verification and trigger a metadata corruption shutdown. on the other
hand, leaf blocks are allowed to have this transient state.

In xfs_attr_inactive(), split the attr fork truncation into two explicit
phases.  First, truncate all extents beyond the root block (the child
extents whose parent references have already been removed above).
Second, invalidate the root block and truncate the attr bmap to zero in
a single transaction.  The two operations in the second phase must be
atomic: as long as the attr bmap has any non-zero length, recovery can
follow it to the root block, so the root block invalidation must commit
together with the bmap-to-zero truncation.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_attr_inactive.c b/fs/xfs/xfs_attr_inactive.c
index 92331991f9fd..a5b69c0fbfd0 100644
--- a/fs/xfs/xfs_attr_inactive.c
+++ b/fs/xfs/xfs_attr_inactive.c
@@ -140,7 +140,7 @@ xfs_attr3_node_inactive(
 	xfs_daddr_t		parent_blkno, child_blkno;
 	struct xfs_buf		*child_bp;
 	struct xfs_da3_icnode_hdr ichdr;
-	int			error, i;
+	int			error;
 
 	/*
 	 * Since this code is recursive (gasp!) we must protect ourselves.
@@ -152,7 +152,7 @@ xfs_attr3_node_inactive(
 		return -EFSCORRUPTED;
 	}
 
-	xfs_da3_node_hdr_from_disk(dp->i_mount, &ichdr, bp->b_addr);
+	xfs_da3_node_hdr_from_disk(mp, &ichdr, bp->b_addr);
 	parent_blkno = xfs_buf_daddr(bp);
 	if (!ichdr.count) {
 		xfs_trans_brelse(*trans, bp);
@@ -167,7 +167,7 @@ xfs_attr3_node_inactive(
 	 * over the leaves removing all of them.  If this is higher up
 	 * in the tree, recurse downward.
 	 */
-	for (i = 0; i < ichdr.count; i++) {
+	while (ichdr.count > 0) {
 		/*
 		 * Read the subsidiary block to see what we have to work with.
 		 * Don't do this in a transaction.  This is a depth-first
@@ -218,29 +218,32 @@ xfs_attr3_node_inactive(
 		xfs_trans_binval(*trans, child_bp);
 		child_bp = NULL;
 
-		/*
-		 * If we're not done, re-read the parent to get the next
-		 * child block number.
-		 */
-		if (i + 1 < ichdr.count) {
-			struct xfs_da3_icnode_hdr phdr;
+		error = xfs_da3_node_read_mapped(*trans, dp,
+				parent_blkno, &bp, XFS_ATTR_FORK);
+		if (error)
+			return error;
 
-			error = xfs_da3_node_read_mapped(*trans, dp,
-					parent_blkno, &bp, XFS_ATTR_FORK);
+		/*
+		 * Remove entry from parent node, prevents being indexed to.
+		 */
+		xfs_attr3_node_entry_remove(*trans, dp, bp, 0);
+
+		xfs_da3_node_hdr_from_disk(mp, &ichdr, bp->b_addr);
+		bp = NULL;
+
+		if (ichdr.count > 0) {
+			/*
+			 * If we're not done, get the next child block number.
+			 */
+			child_fsb = be32_to_cpu(ichdr.btree[0].before);
+
+			/*
+			 * Atomically commit the whole invalidate stuff.
+			 */
+			error = xfs_trans_roll_inode(trans, dp);
 			if (error)
 				return error;
-			xfs_da3_node_hdr_from_disk(dp->i_mount, &phdr,
-						  bp->b_addr);
-			child_fsb = be32_to_cpu(phdr.btree[i + 1].before);
-			xfs_trans_brelse(*trans, bp);
-			bp = NULL;
 		}
-		/*
-		 * Atomically commit the whole invalidate stuff.
-		 */
-		error = xfs_trans_roll_inode(trans, dp);
-		if (error)
-			return  error;
 	}
 
 	return 0;
@@ -257,10 +260,8 @@ xfs_attr3_root_inactive(
 	struct xfs_trans	**trans,
 	struct xfs_inode	*dp)
 {
-	struct xfs_mount	*mp = dp->i_mount;
 	struct xfs_da_blkinfo	*info;
 	struct xfs_buf		*bp;
-	xfs_daddr_t		blkno;
 	int			error;
 
 	/*
@@ -272,7 +273,6 @@ xfs_attr3_root_inactive(
 	error = xfs_da3_node_read(*trans, dp, 0, &bp, XFS_ATTR_FORK);
 	if (error)
 		return error;
-	blkno = xfs_buf_daddr(bp);
 
 	/*
 	 * Invalidate the tree, even if the "tree" is only a single leaf block.
@@ -283,10 +283,26 @@ xfs_attr3_root_inactive(
 	case cpu_to_be16(XFS_DA_NODE_MAGIC):
 	case cpu_to_be16(XFS_DA3_NODE_MAGIC):
 		error = xfs_attr3_node_inactive(trans, dp, bp, 1);
+		/*
+		 * Empty root node block are not allowed, convert it to leaf.
+		 */
+		if (!error)
+			error = xfs_attr3_leaf_init(*trans, dp, 0);
+		if (!error)
+			error = xfs_trans_roll_inode(trans, dp);
 		break;
 	case cpu_to_be16(XFS_ATTR_LEAF_MAGIC):
 	case cpu_to_be16(XFS_ATTR3_LEAF_MAGIC):
 		error = xfs_attr3_leaf_inactive(trans, dp, bp);
+		/*
+		 * Reinit the leaf before truncating extents so that a crash
+		 * mid-truncation leaves an empty leaf rather than one with
+		 * entries that may reference freed remote value blocks.
+		 */
+		if (!error)
+			error = xfs_attr3_leaf_init(*trans, dp, 0);
+		if (!error)
+			error = xfs_trans_roll_inode(trans, dp);
 		break;
 	default:
 		xfs_dirattr_mark_sick(dp, XFS_ATTR_FORK);
@@ -295,21 +311,6 @@ xfs_attr3_root_inactive(
 		xfs_trans_brelse(*trans, bp);
 		break;
 	}
-	if (error)
-		return error;
-
-	/*
-	 * Invalidate the incore copy of the root block.
-	 */
-	error = xfs_trans_get_buf(*trans, mp->m_ddev_targp, blkno,
-			XFS_FSB_TO_BB(mp, mp->m_attr_geo->fsbcount), 0, &bp);
-	if (error)
-		return error;
-	xfs_trans_binval(*trans, bp);	/* remove from cache */
-	/*
-	 * Commit the invalidate and start the next transaction.
-	 */
-	error = xfs_trans_roll_inode(trans, dp);
 
 	return error;
 }
@@ -328,6 +329,7 @@ xfs_attr_inactive(
 {
 	struct xfs_trans	*trans;
 	struct xfs_mount	*mp;
+	struct xfs_buf          *bp;
 	int			lock_mode = XFS_ILOCK_SHARED;
 	int			error = 0;
 
@@ -363,10 +365,27 @@ xfs_attr_inactive(
 	 * removal below.
 	 */
 	if (dp->i_af.if_nextents > 0) {
+		/*
+		 * Invalidate and truncate all blocks but leave the root block.
+		 */
 		error = xfs_attr3_root_inactive(&trans, dp);
 		if (error)
 			goto out_cancel;
 
+		error = xfs_itruncate_extents(&trans, dp, XFS_ATTR_FORK,
+				XFS_FSB_TO_B(mp, mp->m_attr_geo->fsbcount));
+		if (error)
+			goto out_cancel;
+
+		/*
+		 * Invalidate and truncate the root block and ensure that the
+		 * operation is completed within a single transaction.
+		 */
+		error = xfs_da_get_buf(trans, dp, 0, &bp, XFS_ATTR_FORK);
+		if (error)
+			goto out_cancel;
+
+		xfs_trans_binval(trans, bp);
 		error = xfs_itruncate_extents(&trans, dp, XFS_ATTR_FORK, 0);
 		if (error)
 			goto out_cancel;


