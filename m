Return-Path: <stable+bounces-104261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 597349F22B9
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4824188059F
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1813E03A;
	Sun, 15 Dec 2024 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i9rP43GE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E013D28F
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734252826; cv=none; b=SmdmPXt9Qx21GBeeY3Xgn3Wu4ZvFLRk8lRf7DiJ4M/g9YGaSX87aIvAfVg56dpE2d+CHV5kJCsOoMAY8jPiYdSNhnYncoTY/rC1In4iCSYTQ0rFjI3kXLHBbIF9QV+gtPY1F1QwIyvsCtVvM5lvBfe7mCH/iV1nj7Aa3zBFVHtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734252826; c=relaxed/simple;
	bh=aB4KKaqmItIBQrnTOozoZDslneNVZOVc9F7ck+EWqzk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QVDbwqCvK3h/HZ/JQpyng/yVS0YRFcQgAuHrzVDGggKTAtd9+nrP6Bi6wWTvlYlpW5PlfLVolCD7TtxdGMW9blcF+KvhLWL43MJ8v/68mgAVHppn3TtnjkCkEVxs5nyt0HxEcjxHnjRXCys1rhXk3XZnWFQHIewHG7Jw8BCL2R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i9rP43GE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1100C4CECE;
	Sun, 15 Dec 2024 08:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734252826;
	bh=aB4KKaqmItIBQrnTOozoZDslneNVZOVc9F7ck+EWqzk=;
	h=Subject:To:Cc:From:Date:From;
	b=i9rP43GE2z3VJ1XZbOvIYlWk5RfVcZ4GKBuI0WtRXPsXBsE6x3Qy7y8E6o2Sulqjb
	 gN12z+sdboCoNqILJXS85PyUJKD08lEL3BWlY86wbs9mbVCQq5hn3ZcTBO1GBRU5E+
	 b5GXCFmI0DKwkG1iIayeV0qFILXXp/q3QzWxZJ+Q=
Subject: FAILED: patch "[PATCH] xfs: separate healthy clearing mask during repair" failed to apply to 6.12-stable tree
To: djwong@kernel.org,hch@lst.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:53:43 +0100
Message-ID: <2024121542-fretful-identity-5931@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x aa7bfb537edf62085d7718845f6644b0e4efb9df
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121542-fretful-identity-5931@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aa7bfb537edf62085d7718845f6644b0e4efb9df Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 2 Dec 2024 10:57:27 -0800
Subject: [PATCH] xfs: separate healthy clearing mask during repair

In commit d9041681dd2f53 we introduced some XFS_SICK_*ZAPPED flags so
that the inode record repair code could clean up a damaged inode record
enough to iget the inode but still be able to remember that the higher
level repair code needs to be called.  As part of that, we introduced a
xchk_mark_healthy_if_clean helper that is supposed to cause the ZAPPED
state to be removed if that higher level metadata actually checks out.
This was done by setting additional bits in sick_mask hoping that
xchk_update_health will clear all those bits after a healthy scrub.

Unfortunately, that's not quite what sick_mask means -- bits in that
mask are indeed cleared if the metadata is healthy, but they're set if
the metadata is NOT healthy.  fsck is only intended to set the ZAPPED
bits explicitly.

If something else sets the CORRUPT/XCORRUPT state after the
xchk_mark_healthy_if_clean call, we end up marking the metadata zapped.
This can happen if the following sequence happens:

1. Scrub runs, discovers that the metadata is fine but could be
   optimized and calls xchk_mark_healthy_if_clean on a ZAPPED flag.
   That causes the ZAPPED flag to be set in sick_mask because the
   metadata is not CORRUPT or XCORRUPT.

2. Repair runs to optimize the metadata.

3. Some other metadata used for cross-referencing in (1) becomes
   corrupt.

4. Post-repair scrub runs, but this time it sets CORRUPT or XCORRUPT due
   to the events in (3).

5. Now the xchk_health_update sets the ZAPPED flag on the metadata we
   just repaired.  This is not the correct state.

Fix this by moving the "if healthy" mask to a separate field, and only
ever using it to clear the sick state.

Cc: <stable@vger.kernel.org> # v6.8
Fixes: d9041681dd2f53 ("xfs: set inode sick state flags when we zap either ondisk fork")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>

diff --git a/fs/xfs/scrub/health.c b/fs/xfs/scrub/health.c
index ce86bdad37fa..ccc6ca5934ca 100644
--- a/fs/xfs/scrub/health.c
+++ b/fs/xfs/scrub/health.c
@@ -71,7 +71,8 @@
 /* Map our scrub type to a sick mask and a set of health update functions. */
 
 enum xchk_health_group {
-	XHG_FS = 1,
+	XHG_NONE = 1,
+	XHG_FS,
 	XHG_AG,
 	XHG_INO,
 	XHG_RTGROUP,
@@ -83,6 +84,7 @@ struct xchk_health_map {
 };
 
 static const struct xchk_health_map type_to_health_flag[XFS_SCRUB_TYPE_NR] = {
+	[XFS_SCRUB_TYPE_PROBE]		= { XHG_NONE,  0 },
 	[XFS_SCRUB_TYPE_SB]		= { XHG_AG,  XFS_SICK_AG_SB },
 	[XFS_SCRUB_TYPE_AGF]		= { XHG_AG,  XFS_SICK_AG_AGF },
 	[XFS_SCRUB_TYPE_AGFL]		= { XHG_AG,  XFS_SICK_AG_AGFL },
@@ -133,7 +135,7 @@ xchk_mark_healthy_if_clean(
 {
 	if (!(sc->sm->sm_flags & (XFS_SCRUB_OFLAG_CORRUPT |
 				  XFS_SCRUB_OFLAG_XCORRUPT)))
-		sc->sick_mask |= mask;
+		sc->healthy_mask |= mask;
 }
 
 /*
@@ -189,6 +191,7 @@ xchk_update_health(
 {
 	struct xfs_perag	*pag;
 	struct xfs_rtgroup	*rtg;
+	unsigned int		mask = sc->sick_mask;
 	bool			bad;
 
 	/*
@@ -203,50 +206,56 @@ xchk_update_health(
 		return;
 	}
 
-	if (!sc->sick_mask)
-		return;
-
 	bad = (sc->sm->sm_flags & (XFS_SCRUB_OFLAG_CORRUPT |
 				   XFS_SCRUB_OFLAG_XCORRUPT));
+	if (!bad)
+		mask |= sc->healthy_mask;
 	switch (type_to_health_flag[sc->sm->sm_type].group) {
+	case XHG_NONE:
+		break;
 	case XHG_AG:
+		if (!mask)
+			return;
 		pag = xfs_perag_get(sc->mp, sc->sm->sm_agno);
 		if (bad)
-			xfs_group_mark_corrupt(pag_group(pag), sc->sick_mask);
+			xfs_group_mark_corrupt(pag_group(pag), mask);
 		else
-			xfs_group_mark_healthy(pag_group(pag), sc->sick_mask);
+			xfs_group_mark_healthy(pag_group(pag), mask);
 		xfs_perag_put(pag);
 		break;
 	case XHG_INO:
 		if (!sc->ip)
 			return;
-		if (bad) {
-			unsigned int	mask = sc->sick_mask;
-
-			/*
-			 * If we're coming in for repairs then we don't want
-			 * sickness flags to propagate to the incore health
-			 * status if the inode gets inactivated before we can
-			 * fix it.
-			 */
-			if (sc->sm->sm_flags & XFS_SCRUB_IFLAG_REPAIR)
-				mask |= XFS_SICK_INO_FORGET;
+		/*
+		 * If we're coming in for repairs then we don't want sickness
+		 * flags to propagate to the incore health status if the inode
+		 * gets inactivated before we can fix it.
+		 */
+		if (sc->sm->sm_flags & XFS_SCRUB_IFLAG_REPAIR)
+			mask |= XFS_SICK_INO_FORGET;
+		if (!mask)
+			return;
+		if (bad)
 			xfs_inode_mark_corrupt(sc->ip, mask);
-		} else
-			xfs_inode_mark_healthy(sc->ip, sc->sick_mask);
+		else
+			xfs_inode_mark_healthy(sc->ip, mask);
 		break;
 	case XHG_FS:
+		if (!mask)
+			return;
 		if (bad)
-			xfs_fs_mark_corrupt(sc->mp, sc->sick_mask);
+			xfs_fs_mark_corrupt(sc->mp, mask);
 		else
-			xfs_fs_mark_healthy(sc->mp, sc->sick_mask);
+			xfs_fs_mark_healthy(sc->mp, mask);
 		break;
 	case XHG_RTGROUP:
+		if (!mask)
+			return;
 		rtg = xfs_rtgroup_get(sc->mp, sc->sm->sm_agno);
 		if (bad)
-			xfs_group_mark_corrupt(rtg_group(rtg), sc->sick_mask);
+			xfs_group_mark_corrupt(rtg_group(rtg), mask);
 		else
-			xfs_group_mark_healthy(rtg_group(rtg), sc->sick_mask);
+			xfs_group_mark_healthy(rtg_group(rtg), mask);
 		xfs_rtgroup_put(rtg);
 		break;
 	default:
diff --git a/fs/xfs/scrub/scrub.h b/fs/xfs/scrub/scrub.h
index a7fda3e2b013..5dbbe93cb49b 100644
--- a/fs/xfs/scrub/scrub.h
+++ b/fs/xfs/scrub/scrub.h
@@ -184,6 +184,12 @@ struct xfs_scrub {
 	 */
 	unsigned int			sick_mask;
 
+	/*
+	 * Clear these XFS_SICK_* flags but only if the scan is ok.  Useful for
+	 * removing ZAPPED flags after a repair.
+	 */
+	unsigned int			healthy_mask;
+
 	/* next time we want to cond_resched() */
 	struct xchk_relax		relax;
 


