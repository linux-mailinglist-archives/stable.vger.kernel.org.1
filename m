Return-Path: <stable+bounces-19870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87818537A6
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C30283065
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D315FB86;
	Tue, 13 Feb 2024 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ShWpBaXY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD35FEEF;
	Tue, 13 Feb 2024 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845267; cv=none; b=VM2L+daAGNbFATKHcgD5Iqb5OH8yuGc5+xcwR5+8HnApLq45gsJjEHYFpJoLUaD4dqUQXe1J2mo/hY+mXdCKbFWufCq7NmcOadrlOZj+uuJxFTxxNEjK9frk2XHiXDVGxmd8+VvtqnPpp7jaNGaVqF9mKtCFql8EDa0B8kT7vgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845267; c=relaxed/simple;
	bh=/BlT+2ml+JFhyzZEb60oJGYlN+QrXy6SGWWBC3rL6zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUiRZupCwHjm/IVTrY8+BsR6RWTUGfNZDKcRdKj2JLdm3MSTa8s35gdczA4WtDFAsNH/FS0oxpov6S1Sh9SrpeJdEv031NjzJBn3dWxr4reIKWeT2X4DxAQpaaJFylC0dG7nk7NzW1agock0D1hC9xuxcgSxenc/QMMrTrlNPBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ShWpBaXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A64DC433F1;
	Tue, 13 Feb 2024 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845267;
	bh=/BlT+2ml+JFhyzZEb60oJGYlN+QrXy6SGWWBC3rL6zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ShWpBaXYBEAH0owSYv5aajRzGqyUKNMviI+Q47uVrnKtvHSBSiqPsLDhKRNO7LZQu
	 p/rgpzy1epahn06IpAAldVDGTBRX8LfrIM5a0OeEmcExpsEqGGdEnHBAjMAZVFmGah
	 AoL+IkyPQPeegh9IDiP/KMjwdks7Fex3UAYcy5b4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 031/121] xfs: fix internal error from AGFL exhaustion
Date: Tue, 13 Feb 2024 18:20:40 +0100
Message-ID: <20240213171853.889327092@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>
References: <20240213171852.948844634@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>

commit f63a5b3769ad7659da4c0420751d78958ab97675 upstream.

We've been seeing XFS errors like the following:

XFS: Internal error i != 1 at line 3526 of file fs/xfs/libxfs/xfs_btree.c.  Caller xfs_btree_insert+0x1ec/0x280
...
Call Trace:
 xfs_corruption_error+0x94/0xa0
 xfs_btree_insert+0x221/0x280
 xfs_alloc_fixup_trees+0x104/0x3e0
 xfs_alloc_ag_vextent_size+0x667/0x820
 xfs_alloc_fix_freelist+0x5d9/0x750
 xfs_free_extent_fix_freelist+0x65/0xa0
 __xfs_free_extent+0x57/0x180
...

This is the XFS_IS_CORRUPT() check in xfs_btree_insert() when
xfs_btree_insrec() fails.

After converting this into a panic and dissecting the core dump, I found
that xfs_btree_insrec() is failing because it's trying to split a leaf
node in the cntbt when the AG free list is empty. In particular, it's
failing to get a block from the AGFL _while trying to refill the AGFL_.

If a single operation splits every level of the bnobt and the cntbt (and
the rmapbt if it is enabled) at once, the free list will be empty. Then,
when the next operation tries to refill the free list, it allocates
space. If the allocation does not use a full extent, it will need to
insert records for the remaining space in the bnobt and cntbt. And if
those new records go in full leaves, the leaves (and potentially more
nodes up to the old root) need to be split.

Fix it by accounting for the additional splits that may be required to
refill the free list in the calculation for the minimum free list size.

P.S. As far as I can tell, this bug has existed for a long time -- maybe
back to xfs-history commit afdf80ae7405 ("Add XFS_AG_MAXLEVELS macros
...") in April 1994! It requires a very unlucky sequence of events, and
in fact we didn't hit it until a particular sparse mmap workload updated
from 5.12 to 5.19. But this bug existed in 5.12, so it must've been
exposed by some other change in allocation or writeback patterns. It's
also much less likely to be hit with the rmapbt enabled, since that
increases the minimum free list size and is unlikely to split at the
same time as the bnobt and cntbt.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_alloc.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 3069194527dd..100ab5931b31 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2275,16 +2275,37 @@ xfs_alloc_min_freelist(
 
 	ASSERT(mp->m_alloc_maxlevels > 0);
 
+	/*
+	 * For a btree shorter than the maximum height, the worst case is that
+	 * every level gets split and a new level is added, then while inserting
+	 * another entry to refill the AGFL, every level under the old root gets
+	 * split again. This is:
+	 *
+	 *   (full height split reservation) + (AGFL refill split height)
+	 * = (current height + 1) + (current height - 1)
+	 * = (new height) + (new height - 2)
+	 * = 2 * new height - 2
+	 *
+	 * For a btree of maximum height, the worst case is that every level
+	 * under the root gets split, then while inserting another entry to
+	 * refill the AGFL, every level under the root gets split again. This is
+	 * also:
+	 *
+	 *   2 * (current height - 1)
+	 * = 2 * (new height - 1)
+	 * = 2 * new height - 2
+	 */
+
 	/* space needed by-bno freespace btree */
 	min_free = min_t(unsigned int, levels[XFS_BTNUM_BNOi] + 1,
-				       mp->m_alloc_maxlevels);
+				       mp->m_alloc_maxlevels) * 2 - 2;
 	/* space needed by-size freespace btree */
 	min_free += min_t(unsigned int, levels[XFS_BTNUM_CNTi] + 1,
-				       mp->m_alloc_maxlevels);
+				       mp->m_alloc_maxlevels) * 2 - 2;
 	/* space needed reverse mapping used space btree */
 	if (xfs_has_rmapbt(mp))
 		min_free += min_t(unsigned int, levels[XFS_BTNUM_RMAPi] + 1,
-						mp->m_rmap_maxlevels);
+						mp->m_rmap_maxlevels) * 2 - 2;
 
 	return min_free;
 }
-- 
2.43.0




