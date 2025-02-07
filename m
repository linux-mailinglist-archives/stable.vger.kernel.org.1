Return-Path: <stable+bounces-114298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0568BA2CC92
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 20:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35951886C4C
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 19:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA061A3143;
	Fri,  7 Feb 2025 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL3Hw+01"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9218DB0E;
	Fri,  7 Feb 2025 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956488; cv=none; b=NHQNPVieK0I1caHlrTcWCpxJAZXjkr7Kn5+pRMOdW9R6hFkpIJTQig/r2Nxc8/OdvCmfFZ28aVptelbs2uDZDBeWOF9vUFitYzWeIfyPOkN+TukzJIXBblMWPnWhcojKmNUhuFEnva2icLrWRh8uPBcWQStepn/OTHbQZMUZNt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956488; c=relaxed/simple;
	bh=jnwnVxh+aMWrZNOUZb0gsG0HoqZogZRNtVjlDNARwK4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWXrf6uBgPs1km+1mA/Ie508ERcr6/IBowFey0Ns+lO78b0mw0+prgJqc+zOcThfLx/ktm/fnxP2UyL69N6So1jzSgCm/Bt/3NcfIjZ37lTpfoF0h3+LmBrT7AcphkXk1sGEYMpZhgq8gnLqmBN30N15eMYMhwzJr+yCPE60rWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL3Hw+01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8C6C4CED1;
	Fri,  7 Feb 2025 19:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738956487;
	bh=jnwnVxh+aMWrZNOUZb0gsG0HoqZogZRNtVjlDNARwK4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jL3Hw+01Eu1YcU7Kmx3kRDlKnuoZ5CAnCnjaYw6Gk1aYib2KYQ1JFVJg+vohzYCy+
	 u0es4EECsF1e9rWWdIhHiKEJU1IbN0WovJtbOnOwPo1BaA38sY8rnTnAdelMWTQwA5
	 lmX+jDYir1Nod6ckzYbZE6jHy3jhX+ms1Sd5h+oAvo3DwWzc+TdFKT5hcmzgT6W0MR
	 e4Us1XzO+mzi6EHHQZZMSMi9y3Qy7nEXxfKoW5yKe8XThzR31ZxA1tUNOcIr6BQ+Im
	 U5mcNa6R2BS1L01KrbXtSWvyOe+RU9wVc0gl5kOx16RMTCYCXz3lKxD8q+Mr+w9PKu
	 fGRWmU+yRH9Pw==
Date: Fri, 07 Feb 2025 11:28:07 -0800
Subject: [PATCH 07/11] xfs: convert quotacheck to attach dquot buffers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, xfs-stable@lists.linux.dev
Cc: hch@lst.de, stable@vger.kernel.org
Message-ID: <173895601517.3373740.8627744405060077168.stgit@frogsfrogsfrogs>
In-Reply-To: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
References: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

commit ca378189fdfa890a4f0622f85ee41b710bbac271 upstream

Now that we've converted the dquot logging machinery to attach the dquot
buffer to the li_buf pointer so that the AIL dqflush doesn't have to
allocate or read buffers in a reclaim path, do the same for the
quotacheck code so that the reclaim shrinker dqflush call doesn't have
to do that either.

Cc: <stable@vger.kernel.org> # v6.12
Fixes: 903edea6c53f09 ("mm: warn about illegal __GFP_NOFAIL usage in a more appropriate location and manner")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_dquot.h |    2 --
 fs/xfs/xfs_dquot.c |    9 +++------
 fs/xfs/xfs_qm.c    |   18 +++++++++++++-----
 3 files changed, 16 insertions(+), 13 deletions(-)


diff --git a/fs/xfs/xfs_dquot.h b/fs/xfs/xfs_dquot.h
index aad483fc08b8c3..bd7bfd9e402e5b 100644
--- a/fs/xfs/xfs_dquot.h
+++ b/fs/xfs/xfs_dquot.h
@@ -204,8 +204,6 @@ void xfs_dquot_to_disk(struct xfs_disk_dquot *ddqp, struct xfs_dquot *dqp);
 #define XFS_DQ_IS_DIRTY(dqp)	((dqp)->q_flags & XFS_DQFLAG_DIRTY)
 
 void		xfs_qm_dqdestroy(struct xfs_dquot *dqp);
-int		xfs_dquot_read_buf(struct xfs_trans *tp, struct xfs_dquot *dqp,
-				xfs_buf_flags_t flags, struct xfs_buf **bpp);
 int		xfs_qm_dqflush(struct xfs_dquot *dqp, struct xfs_buf *bp);
 void		xfs_qm_dqunpin_wait(struct xfs_dquot *dqp);
 void		xfs_qm_adjust_dqtimers(struct xfs_dquot *d);
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index bba1387dfa42dc..d2b06ca2ec7a9c 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1278,11 +1278,10 @@ xfs_qm_dqflush_check(
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
@@ -1290,10 +1289,8 @@ xfs_dquot_read_buf(
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
@@ -1327,7 +1324,7 @@ xfs_dquot_attach_buf(
 		struct xfs_buf	*bp = NULL;
 
 		spin_unlock(&qlip->qli_lock);
-		error = xfs_dquot_read_buf(tp, dqp, 0, &bp);
+		error = xfs_dquot_read_buf(tp, dqp, &bp);
 		if (error)
 			return error;
 
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 10fa44165ea16d..3212b5bf3fb3c6 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -146,13 +146,13 @@ xfs_qm_dqpurge(
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
@@ -474,8 +474,8 @@ xfs_qm_dquot_isolate(
 		/* we have to drop the LRU lock to flush the dquot */
 		spin_unlock(lru_lock);
 
-		error = xfs_dquot_read_buf(NULL, dqp, XBF_TRYLOCK, &bp);
-		if (error) {
+		error = xfs_dquot_use_attached_buf(dqp, &bp);
+		if (!bp || error == -EAGAIN) {
 			xfs_dqfunlock(dqp);
 			goto out_unlock_dirty;
 		}
@@ -1132,6 +1132,10 @@ xfs_qm_quotacheck_dqadjust(
 		return error;
 	}
 
+	error = xfs_dquot_attach_buf(NULL, dqp);
+	if (error)
+		return error;
+
 	trace_xfs_dqadjust(dqp);
 
 	/*
@@ -1311,9 +1315,13 @@ xfs_qm_flush_one(
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


