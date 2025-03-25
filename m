Return-Path: <stable+bounces-126131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F146A70011
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7276C19A4181
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0F026657F;
	Tue, 25 Mar 2025 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ns5hCMVY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3E257421;
	Tue, 25 Mar 2025 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905658; cv=none; b=Ueaa+fR2WMg79rOyiUmdqLVmfqkzrfDxddFRWUmcgCv7l95BLbQ4yC8GoN1iZXKdWH9+XvfmJaQxx1jGNwJTYfrCgrSIsRlnUAAqiNcvOH/ppAaD3OhpT9o1dC+QExxOXJoJMa0YPuoDNGSXiBCif7Sv0JgcyLw6m0dIxsgaxug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905658; c=relaxed/simple;
	bh=DOF9ryErt8T+s0afIau7AXltqmlYm4nwgGnW3h7zVvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlCBEUGNzGtypmenraJITz4qZwbwq5YihsPyRxCIuW+sF2cKmVB1LkSs8s5AzFZm+zV/4W17JiK5LiXEEtMO1EokkDtmUH4dXEmjUZNqGNYN1eHRG19dWHNqBChHS5BgndiOebkta/qvWzpEsN5+/YDYmRJcSxpAavQf4V91DE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ns5hCMVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ED1C4CEE4;
	Tue, 25 Mar 2025 12:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742905658;
	bh=DOF9ryErt8T+s0afIau7AXltqmlYm4nwgGnW3h7zVvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ns5hCMVYbFifilRBk5KkDRtCZ/CheIYPA28deHB3kOqF2WcT9jPUMkJ4SbGO4rBaI
	 SMv0CoG66QltVpbPVfv1Tmv8weDSOyRFZWW/mmCDZK+Ge8+L4nqNX0saDANLX7pIrK
	 QdU0juptW+1u/L+HjC5pKSg8DZyUesWX/JLSOny0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 093/198] xfs: dont allow overly small or large realtime volumes
Date: Tue, 25 Mar 2025 08:20:55 -0400
Message-ID: <20250325122159.089543480@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
References: <20250325122156.633329074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit e14293803f4e84eb23a417b462b56251033b5a66 ]

Don't allow realtime volumes that are less than one rt extent long.
This has been broken across 4 LTS kernels with nobody noticing, so let's
just disable it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/libxfs/xfs_rtbitmap.h |   13 +++++++++++++
 fs/xfs/libxfs/xfs_sb.c       |    3 ++-
 fs/xfs/xfs_rtalloc.c         |    2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

--- a/fs/xfs/libxfs/xfs_rtbitmap.h
+++ b/fs/xfs/libxfs/xfs_rtbitmap.h
@@ -73,6 +73,18 @@ int xfs_rtfree_blocks(struct xfs_trans *
 
 uint8_t xfs_compute_rextslog(xfs_rtbxlen_t rtextents);
 
+/* Do we support an rt volume having this number of rtextents? */
+static inline bool
+xfs_validate_rtextents(
+	xfs_rtbxlen_t		rtextents)
+{
+	/* No runt rt volumes */
+	if (rtextents == 0)
+		return false;
+
+	return true;
+}
+
 #else /* CONFIG_XFS_RT */
 # define xfs_rtfree_extent(t,b,l)			(-ENOSYS)
 # define xfs_rtfree_blocks(t,rb,rl)			(-ENOSYS)
@@ -81,6 +93,7 @@ uint8_t xfs_compute_rextslog(xfs_rtbxlen
 # define xfs_rtbuf_get(m,t,b,i,p)			(-ENOSYS)
 # define xfs_rtalloc_extent_is_free(m,t,s,l,i)		(-ENOSYS)
 # define xfs_compute_rextslog(rtx)			(0)
+# define xfs_validate_rtextents(rtx)			(false)
 #endif /* CONFIG_XFS_RT */
 
 #endif /* __XFS_RTBITMAP_H__ */
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -502,7 +502,8 @@ xfs_validate_sb_common(
 		rbmblocks = howmany_64(sbp->sb_rextents,
 				       NBBY * sbp->sb_blocksize);
 
-		if (sbp->sb_rextents != rexts ||
+		if (!xfs_validate_rtextents(rexts) ||
+		    sbp->sb_rextents != rexts ||
 		    sbp->sb_rextslog != xfs_compute_rextslog(rexts) ||
 		    sbp->sb_rbmblocks != rbmblocks) {
 			xfs_notice(mp,
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -998,6 +998,8 @@ xfs_growfs_rt(
 	 */
 	nrextents = nrblocks;
 	do_div(nrextents, in->extsize);
+	if (!xfs_validate_rtextents(nrextents))
+		return -EINVAL;
 	nrbmblocks = howmany_64(nrextents, NBBY * sbp->sb_blocksize);
 	nrextslog = xfs_compute_rextslog(nrextents);
 	nrsumlevels = nrextslog + 1;



