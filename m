Return-Path: <stable+bounces-104253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2193C9F22B1
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B461886A4D
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3633A13D28F;
	Sun, 15 Dec 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xdgecX4P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62EE13E03A
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734252781; cv=none; b=RlI7JmAdELdCPQ+UhNQ+slpQeMxx8WFpAzZUzBlRGRtZGX9WRKjuDatI4hWtu8FEIerOiEPzdAiqi7pgyWKSUt9LEYB/S7JV+o9PBXj4ia+jMTeV42oO0eb4Zw1GsDrc2frWkDyOMiOSE8XXFIxWBzOoWF9B+sPY9TuofbnbFgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734252781; c=relaxed/simple;
	bh=1Ea67Wf2k3h9dFTBLT+rjU+JH7gDw1gggN7GtQ3EZSA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lWdABmQIC9CptSldZs9wZPztg0GF092+ss8U8ksL3qvjxV2TFBDLiPPZWclMFOGNQJajNEnKmNbAoBqKG6lXrKyPRzB0SOv7q7uwuDH5EySweE1Gb2mdwPROAOLkxZIMtsp9LgCD7RfRX7SXyAJolkQyp/jcvBaLPHGGQ4XKCCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xdgecX4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B179C4CECE;
	Sun, 15 Dec 2024 08:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734252780;
	bh=1Ea67Wf2k3h9dFTBLT+rjU+JH7gDw1gggN7GtQ3EZSA=;
	h=Subject:To:Cc:From:Date:From;
	b=xdgecX4Pvj6tt1bdJeEa9E3cD1SxO+kvisguX64wCkdDK1iCT8fJ90NF5kD/09xTN
	 zSQQvQkIaO5xNxmTyZ/adHqjohEFaA0niXurelw97EBMgGntwtjnv4kSJ4P5RrnzAz
	 Z+HwGGFBNk2RuESKBpiTW2k+EJrRvD+PskVskvdA=
Subject: FAILED: patch "[PATCH] xfs: convert quotacheck to attach dquot buffers" failed to apply to 6.12-stable tree
To: djwong@kernel.org,hch@lst.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:52:57 +0100
Message-ID: <2024121557-herring-copartner-3013@gregkh>
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
git cherry-pick -x ca378189fdfa890a4f0622f85ee41b710bbac271
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121557-herring-copartner-3013@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca378189fdfa890a4f0622f85ee41b710bbac271 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 2 Dec 2024 10:57:39 -0800
Subject: [PATCH] xfs: convert quotacheck to attach dquot buffers

Now that we've converted the dquot logging machinery to attach the dquot
buffer to the li_buf pointer so that the AIL dqflush doesn't have to
allocate or read buffers in a reclaim path, do the same for the
quotacheck code so that the reclaim shrinker dqflush call doesn't have
to do that either.

Cc: <stable@vger.kernel.org> # v6.12
Fixes: 903edea6c53f09 ("mm: warn about illegal __GFP_NOFAIL usage in a more appropriate location and manner")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>

diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 708fd3358375..f11d475898f2 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1285,11 +1285,10 @@ xfs_qm_dqflush_check(
  * Requires dquot flush lock, will clear the dirty flag, delete the quota log
  * item from the AIL, and shut down the system if something goes wrong.
  */
-int
+static int
 xfs_dquot_read_buf(
 	struct xfs_trans	*tp,
 	struct xfs_dquot	*dqp,
-	xfs_buf_flags_t		xbf_flags,
 	struct xfs_buf		**bpp)
 {
 	struct xfs_mount	*mp = dqp->q_mount;
@@ -1297,10 +1296,8 @@ xfs_dquot_read_buf(
 	int			error;
 
 	error = xfs_trans_read_buf(mp, tp, mp->m_ddev_targp, dqp->q_blkno,
-				   mp->m_quotainfo->qi_dqchunklen, xbf_flags,
+				   mp->m_quotainfo->qi_dqchunklen, 0,
 				   &bp, &xfs_dquot_buf_ops);
-	if (error == -EAGAIN)
-		return error;
 	if (xfs_metadata_is_sick(error))
 		xfs_dquot_mark_sick(dqp);
 	if (error)
@@ -1334,7 +1331,7 @@ xfs_dquot_attach_buf(
 		struct xfs_buf	*bp = NULL;
 
 		spin_unlock(&qlip->qli_lock);
-		error = xfs_dquot_read_buf(tp, dqp, 0, &bp);
+		error = xfs_dquot_read_buf(tp, dqp, &bp);
 		if (error)
 			return error;
 
diff --git a/fs/xfs/xfs_dquot.h b/fs/xfs/xfs_dquot.h
index c7e80fc90823..c617bac75361 100644
--- a/fs/xfs/xfs_dquot.h
+++ b/fs/xfs/xfs_dquot.h
@@ -214,8 +214,6 @@ void xfs_dquot_to_disk(struct xfs_disk_dquot *ddqp, struct xfs_dquot *dqp);
 #define XFS_DQ_IS_DIRTY(dqp)	((dqp)->q_flags & XFS_DQFLAG_DIRTY)
 
 void		xfs_qm_dqdestroy(struct xfs_dquot *dqp);
-int		xfs_dquot_read_buf(struct xfs_trans *tp, struct xfs_dquot *dqp,
-				xfs_buf_flags_t flags, struct xfs_buf **bpp);
 int		xfs_qm_dqflush(struct xfs_dquot *dqp, struct xfs_buf *bp);
 void		xfs_qm_dqunpin_wait(struct xfs_dquot *dqp);
 void		xfs_qm_adjust_dqtimers(struct xfs_dquot *d);
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 7d07d4b5c339..69b70c3e999d 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -148,13 +148,13 @@ xfs_qm_dqpurge(
 		 * We don't care about getting disk errors here. We need
 		 * to purge this dquot anyway, so we go ahead regardless.
 		 */
-		error = xfs_dquot_read_buf(NULL, dqp, XBF_TRYLOCK, &bp);
+		error = xfs_dquot_use_attached_buf(dqp, &bp);
 		if (error == -EAGAIN) {
 			xfs_dqfunlock(dqp);
 			dqp->q_flags &= ~XFS_DQFLAG_FREEING;
 			goto out_unlock;
 		}
-		if (error)
+		if (!bp)
 			goto out_funlock;
 
 		/*
@@ -506,8 +506,8 @@ xfs_qm_dquot_isolate(
 		/* we have to drop the LRU lock to flush the dquot */
 		spin_unlock(&lru->lock);
 
-		error = xfs_dquot_read_buf(NULL, dqp, XBF_TRYLOCK, &bp);
-		if (error) {
+		error = xfs_dquot_use_attached_buf(dqp, &bp);
+		if (!bp || error == -EAGAIN) {
 			xfs_dqfunlock(dqp);
 			goto out_unlock_dirty;
 		}
@@ -1331,6 +1331,10 @@ xfs_qm_quotacheck_dqadjust(
 		return error;
 	}
 
+	error = xfs_dquot_attach_buf(NULL, dqp);
+	if (error)
+		return error;
+
 	trace_xfs_dqadjust(dqp);
 
 	/*
@@ -1513,9 +1517,13 @@ xfs_qm_flush_one(
 		goto out_unlock;
 	}
 
-	error = xfs_dquot_read_buf(NULL, dqp, XBF_TRYLOCK, &bp);
+	error = xfs_dquot_use_attached_buf(dqp, &bp);
 	if (error)
 		goto out_unlock;
+	if (!bp) {
+		error = -EFSCORRUPTED;
+		goto out_unlock;
+	}
 
 	error = xfs_qm_dqflush(dqp, bp);
 	if (!error)


